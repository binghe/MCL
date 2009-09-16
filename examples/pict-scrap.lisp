;;-*- Mode: Lisp; Package: CCL -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Pict-Scrap.Lisp
;;
;; Copyright 1989-1994, Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;;
;;
;;  This file a scrap-handler for scraps of type PICT
;;
;;  Once this is installed, windows which copy and paste PICTs will
;;  be able to share their work with other applications
;;
;; Modified for 2.0 by Henry Lieberman

;;;;;;;;;;;;
;;
;; Modification History
;;
;; akh fix internalize-scrap
;; -------- 4.4b3
;; akh carbon stuff
;; -------- 4.3.1
;; 04/24/92 bill Don't push multiple entries on *scrap-handler-alist*
;;               if loaded multiple times. Also, eliminate the memory
;;               leak in internalize-scrap (thanx to Bob Strong).
;; ------------- 2.0
;; 11/18/91 bill Don't need to require traps or records anymore.
;; 08/24/91 gb  Use new traps; don't use $applScratch

(in-package :ccl)

(defclass pict-scrap-handler (scrap-handler) ())

(defmethod set-internal-scrap ((self pict-scrap-handler) scrap)
  (let* ((old-pict (slot-value self 'internal-scrap)))
    (when (handlep old-pict)
      (#_KillPicture old-pict)))        ;dispose of the old pict before we
                                        ;put a new one in its place
                                        ;this will crash if your program has
                                        ;other pointers to the pict, so
                                        ;always make sure cut/copy really do
                                        ;-copy- the pict
  (call-next-method self scrap)
  (when scrap (pushnew :pict *scrap-state*)))

;; never called in carbon land
#-carbon-compat
(defmethod externalize-scrap ((pict-scrap-handler pict-scrap-handler))
  (let* ((the-pict (slot-value pict-scrap-handler 'internal-scrap))
         (size (#_GetHandleSize the-pict)))
    (when the-pict
      (with-dereferenced-handles
        ((the-pict the-pict))
        (#_PutScrap size :pict the-pict)))))

#-carbon-compat
(defmethod internalize-scrap ((self pict-scrap-handler))
  (let* ((the-pict (slot-value self 'internal-scrap)))
    (unless (handlep the-pict)
      (setq the-pict
            (setf (slot-value self 'internal-scrap)
                   (#_NewHandle 0))))
    (rlet ((junk :signed-long))
      (#_GetScrap the-pict :pict junk))
    the-pict))

#+carbon-compat
(defmethod internalize-scrap ((self pict-scrap-handler))
  (when (get-scrap-flavor-flags :|PICT|)
    (let* ((the-pict (slot-value self 'internal-scrap)))
      (unless (handlep the-pict)
        (setq the-pict
              (setf (slot-value self 'internal-scrap)
                    (#_NewHandle 0))))
      (rlet ((rsize :signed-long))  ;; SIGNED?? - yeah can be -1 for unknown
        (let* ((scrap (get-current-scrapref)) 
               (size (get-scrap-flavor-size :|PICT|)))
          (when (neq size -1)
            (#_sethandlesize the-pict size)
            (%put-long rsize size)
            (with-dereferenced-handles ((ptr the-pict))
              (#_getscrapflavordata scrap :|PICT| RSIZE ptr)
              ))))
      the-pict)))

#+carbon-compat
(defmethod put-scrap-flavor ((type (eql :|PICT|)) thing)
  (clear-current-scrap)
  (let* ((scrap (get-current-scrapref)) 
         (size (#_gethandlesize thing)))
    (when (> size 0)
      (with-dereferenced-handles ((ptr thing))
        (#_putscrapflavor scrap type 0 size ptr)))))


(defmethod get-internal-scrap ((pict-scrap-handler pict-scrap-handler))
  (slot-value pict-scrap-handler 'internal-scrap))

(let ((p (assq :pict *scrap-handler-alist*)))
  (if p 
    (setf (cdr p) (make-instance 'pict-scrap-handler))
    (push `(:pict . ,(make-instance 'pict-scrap-handler))
          *scrap-handler-alist*)))

#|
;;;;;;;;;;;;;;;;;;;;;
;;
;; a simple window, supporting cut and paste with picts
;;
;; because it doesn't remember the picts which it pastes,
;; it can only cut a pseudo-pict, that is, a pict which
;; contains the window's current contents as a bitmap.

(defclass pict-window (window) ()
  (:default-initargs 
    :color-p t
    :window-title "A Pict Window"))

(defmethod paste ((pict-window pict-window))
  (let* ((pict (get-scrap :pict)))
    (when pict
      (with-port (wptr pict-window)
        (rlet ((r :rect))
          (with-dereferenced-handles ((pict-point pict))
            (copy-record (rref pict-point :picture.picframe
                               :storage :pointer)
                         :rect
                         r))
        (#_DrawPicture pict r))))))

(defmethod copy ((pict-window pict-window))
  (let* ((wptr (wptr pict-window)))
    (rlet #-carbon-compat ((rect :rect 
                                 :left (rref wptr windowrecord.portrect.left)
                                 :top (rref wptr windowrecord.portrect.top)
                                 :right (rref wptr windowrecord.portrect.right)
                                 :bottom (rref wptr windowrecord.portrect.bottom)))
          #+carbon-compat ((rect :rect))
      #+carbon-compat
      (#_getwindowportbounds wptr rect)
          
      (with-port wptr
        (#_cliprect rect)
        #-carbon-compat
        (let* ((pict (#_OpenPicture rect))
               (bits (rref wptr :windowrecord.portbits)))
          (#_CopyBits 
           bits 
           bits 
           rect 
           rect 0        ;transfer mode
           (%null-ptr))
          (#_ClosePicture)
          (put-scrap :pict pict))
        #+carbon-compat  ;; i dunno
        (let* ((pict (#_OpenPicture rect)))
          (with-macptrs ((bits (#_getportbitmapforcopybits (#_getwindowport wptr))))
            (#_CopyBits 
             bits 
             bits 
             rect 
             rect 0        ;transfer mode
             (%null-ptr))
            (#_ClosePicture)
            (put-scrap :pict pict)))
          ))))

(defmethod clear ((pict-window pict-window))
  (let ((wptr (wptr pict-window)))
    (with-port wptr
      #-carbon-compat
      (#_EraseRect (rref wptr :windowrecord.portrect))
      #+carbon-compat
      (rlet ((rect :rect))
        (#_getwindowportbounds wptr rect)
        (#_eraserect rect))
      )))

(defmethod cut ((pict-window pict-window))
  (copy pict-window)
  (clear pict-window))

(setq pw (make-instance 'pict-window))


|#
