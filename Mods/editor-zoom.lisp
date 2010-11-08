;;;-*- Mode: Lisp; Package: CCL -*-;;;;;; Command-+ to zoom in the editor, a must for aging lispers...;;; March 2010, Terje Norderhaug <terje@in-progress.com>;;; License: LLGPL.
(in-package :ccl)

(defun update-after-zoom (w)
  (let* ((view (fred-item w))
         (frec (frec view)))
    (setf (fr.bmod frec) 0)  ; make sure it really updates
    (setf (fr.zmod frec) 0)
    (frec-update frec t)))

(defmethod window-zoom-in ((w fred-window))
  (incf (zoom-level (mark-buffer (fred-buffer w))))
  (update-after-zoom w))

(defmethod window-zoom-in ((w fred-window))
  (incf (zoom-level (mark-buffer (fred-buffer (current-key-handler w)))))
  (update-after-zoom w)
  ; for split windows:
  (invalidate-view w))

(defmethod window-zoom-out ((w fred-window))
  (decf (zoom-level (mark-buffer (fred-buffer (current-key-handler w)))))
  (update-after-zoom w)
  ; for split windows:
  (invalidate-view w))

(defmethod zoom-level (item)
  (declare (ignore item))
  0)

(defmethod zoom-level ((b buffer))
  (buffer-getprop b 'zoom-level 0))

(defmethod (setf zoom-level) (v (b buffer))
  (setf (buffer-getprop b 'zoom-level) v))

(defmethod zoom-level ((w window))
  (view-get w 'zoom-level 0))

(defmethod (setf zoom-level) (v (w window))
  (setf (view-get w 'zoom-level) v))

;; should really be in a View menu....
(add-new-item *edit-menu* "Zoom In" #'window-zoom-in
   :command-key #\+
  :class 'window-menu-item)

(comtab-set-key %initial-comtab% '(:command #\=) 
                (lambda (fred-item)(window-zoom-in (view-window fred-item)))) 

(add-new-item *edit-menu* "Zoom Out" #'window-zoom-out
  :command-key #\-
  :class 'window-menu-item)

; see %redraw-screen-lines

;; new , but similar code is many places in MCL, so consider integrate and use!
(defun buffer-fred-item (buffer)
  ; code ripped from mcl!
    (let* ((frec (block blob ; what a lousy way to get from buffer to fred-item
                   (let ((the-fun
                          #'(lambda (frec)
                              (when (same-buffer-p buffer (fr.cursor frec))
                                (return-from blob frec)))))
                     (declare (dynamic-extent the-fun))
                     (map-frecs the-fun)))))
           (when frec (fr.owner frec)))) ;; w is a fred-item

(defun buffer-zoom-factor (buffer)
    (expt 10/9 (zoom-level (mark-buffer buffer))))

;; need to be event better? set ms for size correctly?
;; patches l1-dfrec.lisp

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))

(defun %set-screen-font (buffer position)
  (multiple-value-bind (ff ms) (ccl::buffer-char-font-codes buffer position)    
    (setq ms (make-point (round (* (buffer-zoom-factor buffer)(point-h ms))) #$srcOr))    
    (progn 
      (#_textfont (ash ff -16))
      (#_textface (logand (ash ff -8) #xff))
      (#_textmode (ash ms -16))
      (#_textsize (logand ms #xffff)))
    (set-grafport-fred-color (logand 255 ff))
    (values ff ms)))

) ; end redefine


(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))

(defun bp-and-caret (frec srcmode)
  (without-interrupts
   (with-fore-color *black-color*
     (multiple-value-bind (top-h top-v bot-h bot-v) (screen-caret-corners frec)
       (when top-h
         (progn ;without-interrupts
           (with-pen-saved-simple
             (#_PenMode #$patxor)
             (#_MoveTo bot-h bot-v)
             (#_LineTo top-h top-v)))))
     (let ((point (fr.bpoint frec)))
       (when (>= point 0)
         (let* ((ff (fr.bp-ff frec))
                (ms (fr.bp-ms frec)))
           (setq ms (make-point (round (* (buffer-zoom-factor (fr.cursor frec))(point-h ms))) (point-v ms)))
           (progn ;with-font-codes ff (make-point (point-h ms) srcmode)
             #|
             (set-grafport-fred-color (logand 255 ff))
             (#_MoveTo (point-h point)(point-v point))
             (#_DrawChar (fr.bpchar frec))
             |#
             (when (eq srcmode #$srcbic)
               (setq ff (logior (logand ff (lognot #xff)) #.(fred-palette-closest-entry *white-color*))))   ;; or (fred-palette-closest-entry (grafport-back-color))
             (let ((*use-quickdraw-for-roman* nil))
               (grafport-write-char-at-point (fr.bpchar frec) point ff ms))            
             )))))))

) ; end redefine