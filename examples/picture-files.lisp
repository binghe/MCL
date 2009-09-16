;;-*- Mode: Lisp; Package: CCL -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; picture-files.lisp
;; Copyright 1990-1994, Apple Computer, Inc.
;; Copyright 1995-1999 Digitool, Inc.


; Examples of reading and writing picture files.
; Adapted from the code on page V-88 of Inside Macintosh.
; If you draw a PICT2 pict to a color window with a palette
; (e.g. a PALETTE-WINDOW below), it will copy the color table
; to the palette.  Does not yet have any way to clean up your
; desktop.  You can always close all the color windows, then
; zoom the listener to fill the screen and back.

; See the function DISPLAY-PICT-FILE for an example of use.

;;;;;;;
;;
;; Modification history
;; well at least it compiles and example does draw
;; ------ 5.2b5
;; add-pascal-upp-alist -> add-pascal-upp-alist-macho
;; 02/02/04 pick -> pict, add some add-pascal-upp-alist - at least it doesn't crash
;;    but doesn't draw anything either
;; ----
;; with-pointers -> with-dereferenced-handles
;; ------ 5.0 final
;; 11/18/02 carbon-compat in example at end of file
;; ------- 4.4b5
;; 04/30/00 some carbon-compat
;; -------------
;; 01/28/98 akh fix from Eric Russell - dont write picture-size too often
;; 10/18/95 bill open-pict-output-file writes 10 bytes, not 8 for the header,
;;               and it initializes *pict-output-handle* correctly so that
;;               *put-pict-data* will update the length field and the pict
;;               writing code will word-align the opcodes.
;; ------------- 3.0
;; 11/17/93 bill save-pict-to-file, :creator keyword to with-pict-output-file
;; 03/18/93 bill load-pict-file. Warnings on use of open-pict-input-file
;; 04/17/92 bill Steve Miner's def-load-pointers for *std-bits-proc*
;; ------------- 2.0
;; 12/18/91 bill (from STEVE.M) remove %getport, it's in the kernel.
;;          scale-point -> scale-lisp-point so it won't conflict with
;;          ccl:library;quickdraw.lisp.;;               
;; 10/08/91 bill move to CCL package
;;

#-ccl-2
(eval-when (:compile-toplevel :load-toplevel :execute)
  (error "This code expects MCL 2.0 or later."))

(in-package :ccl)

(require :mac-file-io)              ; high-level File I/O ala Inside Macintosh

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(with-pict-input-file with-pict-output-file display-pict-file
             palette-window load-pict-file)))

(defvar *pict-input-pb* nil)

#+ignore
(add-pascal-upp-alist '*get-pict-data* #'(lambda (procptr)(#_newQDGetPicUPP procptr)))

(add-pascal-upp-alist-macho '*get-pict-data* "NewQDGetPicUPP")
(defpascal *get-pict-data* (:ptr dataPtr :word byteCount)
  (FSRead *pict-input-pb* byteCount dataPtr 0 nil))

(defvar *pict-output-pb* nil)
(defvar *pict-output-handle* nil)

#+ignore
(add-pascal-upp-alist '*put-pict-data* #'(lambda (procptr)(#_newQDPutPicUPP procptr))) ;; ??

(add-pascal-upp-alist-macho '*put-pict-data* "NewQDPutPicUPP")


(defpascal *put-pict-data* (:ptr dataPtr :word byteCount)
  (FSWrite *pict-output-pb* byteCount dataPtr 0 nil)
  (let ((handle *pict-output-handle*))
    (when handle
      (rset handle :picture.picsize 
            (+ byteCount (rref handle :picture.picsize))))))

; Color palette stuff.
; Note that this initial palette is all black.
; It really should be initialized to the default
; system color table for the device with the most bits.
; It works because set the palette from a PICT that is
; drawn here.
(defun add-palette (window)
  (when (window-color-p window)
    (let ((wptr (wptr window)))
      (when (%null-ptr-p (#_GetPalette wptr))
        (#_SetPalette 
         wptr
         (#_NewPalette 256 (%null-ptr) 2 0 )
         nil)))))

(defun remove-palette (window)
  (when (window-color-p window)
    (let* ((wptr (wptr window))
           (palette (#_GetPalette wptr)))
      (declare (dynamic-extent palette))
      (unless (%null-ptr-p palette)
        (#_SetPalette  wptr (%null-ptr) nil)
        (#_DisposePalette palette)))))
        
(defclass palette-window (window) ()    ; a class for 8-bit graphics
  (:default-initargs
    :color-p t
    :grow-icon-p nil))

(defmethod initialize-instance :after ((w palette-window) &key)
  (add-palette w))

(defmethod window-close :before ((w palette-window))
  (remove-palette w))


(defvar *std-bits-proc* nil)
(def-load-pointers *std-bits-proc* ()
  (setq *std-bits-proc* (%null-ptr)))

(defvar *bits-proc-cnt* 0)
(defvar *palette-changes* 0)

#+ignore
(add-pascal-upp-alist '*bits-proc* #'(lambda (procptr)(#_NewQDBitsUPP procptr)))

(add-pascal-upp-alist-macho '*bits-proc* "NewQDBitsUPP")
(defpascal *bits-proc* (:ptr srcBits :ptr srcRect :ptr dstRect
                             :word mode :ptr rgnHandle)
   (incf *bits-proc-cnt*)
   (let* ((port (%getPort)))
     (declare (dynamic-extent port))
     (when (and (logbitp 15 (rref srcBits :pixMap.rowBytes :storage :pointer))
                #-CARBON-COMPAT
                (logbitp 15 (rref port :cGrafport.portVersion)))  ;; whats that - is color? - headers say always true
       (let ((palette (#_GetPalette port)))
         (declare (dynamic-extent palette))
         (unless (%null-ptr-p palette)
           (incf *palette-changes*)
           (#_CTab2Palette (rref srcBits :pixMap.pmTable :storage :pointer)
                           palette
                           2  #x0000)   ; tolerant usage, no tolerance
           (#_ActivatePalette port)))))
   #+ignore ;; what the heck is that
   (ff-call *std-bits-proc*
                 :ptr srcBits :ptr srcRect :ptr dstRect :word mode :ptr rgnHandle)
   #|
   (PPC-FF-CALL *std-bits-proc* :ADDRESS SRCBITS
             :ADDRESS SRCRECT
             :ADDRESS DSTRECT
             :SIGNED-HALFWORD MODE
             :ADDRESS RGNHANDLE
             :VOID)
   |#
   ;; is this what was meant?
   (#_stdbits srcbits srcrect dstrect mode rgnhandle))



(eval-when (:compile-toplevel :execute)
#+ignore ;; use the one in the headers
(defrecord QDProcs
  (textProc :pointer)
  (lineProc :pointer)
  (rectProc :pointer)
  (rRectProc :pointer)
  (ovalProc :pointer)
  (arcProc :pointer)
  (polyProc :pointer)
  (rgnProc :pointer)
  (bitsProc :pointer)
  (commentProc :pointer)
  (txMeasProc :pointer)
  (getPicProc :pointer)
  (putPicProc :pointer)
  (opcodeProc :pointer)
  (newProc1 :pointer)
  (newProc2 :pointer)
  (newProc3 :pointer)
  (newProc4 :pointer)
  (newProc5 :pointer)
  (newProc6 :pointer))

#+ignore ;; from headers
(defrecord QDProcs 
   (textProc :pointer)
   (lineProc :pointer)
   (rectProc :pointer)
   (rRectProc :pointer)
   (ovalProc :pointer)
   (arcProc :pointer)
   (polyProc :pointer)
   (rgnProc :pointer)
   (bitsProc :pointer)
   (commentProc :pointer)
   (txMeasProc :pointer)
   (getPicProc :pointer)
   (putPicProc :pointer)
   )
#+ignore ;; from headers
(defrecord CQDProcs 
   (textProc :pointer)
   (lineProc :pointer)
   (rectProc :pointer)
   (rRectProc :pointer)
   (ovalProc :pointer)
   (arcProc :pointer)
   (polyProc :pointer)
   (rgnProc :pointer)
   (bitsProc :pointer)
   (commentProc :pointer)
   (txMeasProc :pointer)
   (getPicProc :pointer)
   (putPicProc :pointer)
   (opcodeProc :pointer)
   (newProc1 :pointer)                          ;   this is the StdPix bottleneck -- see ImageCompression.h  
   (glyphsProc :pointer)                        ;   was newProc2; now used in Unicode text drawing  
   (printerStatusProc :pointer)                 ;   was newProc3;  now used to communicate status between Printing code and System imaging code  
   (newProc4 :pointer)
   (newProc5 :pointer)
   (newProc6 :pointer)
   )

(defconstant $CQDProcs-size (record-length :CQdprocs))
(defconstant $QDProcs-size (record-length :QDProcs))
)

(defvar *pict-input-grafProcs* nil)

; Offsets in the GrafProcs structure that we allocate for storing our state
(defconstant $gpWptr 0)
(defconstant $gpPictHand 4)
(defconstant $gpOldGrafProcs 8)
(defconstant $gpHeaderSize 12)
(defconstant $pictureSize 10)            ; length of a PICTURE header

; Returns a PICTURE handle on which you can call _DrawPicture to the window.
; If error, signal if errorp is true, or return two values, NIL and the
; error number. Note that you should never use this except when balanced
; with a call to close-pict-file (the easiest way to do this is with-pict-input-file).
; It modifies the :grafport.grafProcs field of window's wptr. close-pict-file does
; the restoration. Also, only one pict file at a time can be open with this file.
; #_DrawPicture on the resultant picture handle will work only to the specified
; window.
(defun open-pict-input-file (filename window &optional (errorp t))
  (let ((old-pb *pict-input-pb*)
        pb pict-hand errnum grafProcs)
    (when old-pb
      (error "A picture input file is already open"))
    (unwind-protect
      (progn
        (setq *pict-input-pb* t)            ; grab it
        (let* ((wptr (wptr window))
               (color-p (window-color-p window))
               (size (if color-p $CQDProcs-size $QDProcs-size)))
          (setq grafProcs (#_NewPtr :errchk (+ $gpHeaderSize size)))
          (setq pict-hand (#_NewHandle :errchk $pictureSize))
          (multiple-value-setq (pb errnum) (FSOpen filename nil 0 errorp))
          (if (not pb)
            (values nil errnum)
            (let ((oldGrafProcs #-carbon-compat 
                                (rref wptr :grafport.grafProcs)
                                #+carbon-compat 
                                (let ((port (#_GetWindowPort wptr)))
                                  (#_GetPortGrafProcs port)))
                  (newGrafProcs (%inc-ptr GrafProcs $gpHeaderSize)))
              (declare (dynamic-extent oldGrafProcs newGrafProcs))
              (%put-ptr grafProcs wptr $gpWptr)
              (%put-ptr grafProcs pict-hand $gpPictHand)
              (%put-ptr grafProcs oldGrafProcs $gpOldGrafProcs)
              (if (%null-ptr-p oldGrafProcs)
                (if color-p
                  (#_SetStdCProcs newGrafProcs)
                  (#_SetStdProcs newGrafProcs))
                (#_BlockMove oldGrafProcs newGrafProcs size))
              (setFpos pb 512)          ; skip MacDraw header block
              (with-dereferenced-handles ((pict pict-hand)) ;with-pointers ((pict pict-hand))
                (FSRead pb $pictureSize pict))   ; read size & picture frame
              (rset newGrafProcs :QDProcs.getPicProc *get-pict-data*)
              (when (window-color-p window)
                (let ((bitsProc (rref newGrafProcs :QDProcs.bitsProc)))
                  (declare (dynamic-extent bitsProc))
                  (unless (eql *bits-proc* bitsProc)
                    (%setf-macptr *std-bits-proc* bitsProc)
                    (rset newGrafProcs :QDProcs.bitsProc *bits-proc*))))
              (setq *pict-input-GrafProcs* grafProcs
                    *pict-input-pb* pb)
              #-CARBON-COMPAT
              (rset wptr :grafport.grafProcs newGrafProcs)
              #+CARBON-COMPAT
              (let ((port (#_GetWindowPort wptr)))
                (#_SetPortGrafProcs port newgrafprocs))
              pict-hand
              ))))
      (when (eq t *pict-input-pb*)
        (if pb (FSClose pb))
        (setq *pict-input-pb* nil)
        (when grafProcs
          (#_DisposePtr grafProcs))
        (when pict-hand
          (#_DisposeHandle pict-hand))))))

(defun close-pict-input-file (pict-hand)
  (let ((grafProcs *pict-input-GrafProcs*)
        (pb *pict-input-pb*))
    (unless pb
      (error "No picture input file open."))
    (unless (eql pict-hand (%get-ptr grafProcs $gpPictHand))
      (error "~s is not the pict-hand returned from open-pict-input-file"
             pict-hand))
    (let ((wptr (%get-ptr grafProcs $gpWptr))
          (oldGrafProcs (%get-ptr grafProcs $gpOldGrafProcs)))
      #-carbon-compat
      (rset wptr :grafport.GrafProcs oldGrafProcs)
      #+carbon-compat
      (#_SetPortGrafProcs (#_GetWindowPort wptr) oldgrafprocs)
      (#_DisposePtr grafProcs)
      (#_DisposeHandle pict-hand)
      (FSClose pb)
      (setq *pict-input-GrafProcs* nil
            *pict-input-pb* nil))))

(defmacro with-pict-input-file ((pict-hand filename window) &body body)
  `(let ((,pict-hand (open-pict-input-file ,filename ,window)))
     (unwind-protect
       (progn ,@body)
       (close-pict-input-file ,pict-hand))))

(defvar *pict-output-GrafProcs* nil)

; Picture output to a file.
; Sets up to output a picture to the file named filename.
; Picture output will be done on the given window in the picture
; frame described by the two points topleft & botright
; Same limitations as for open-pict-input-file. You need to balance
; open-pict-output-file calls with close-pict-output-file, and you
; can only open one pict output file at a time.
(defun open-pict-output-file (filename window topleft botright
                                       &key creator)
  (unless creator
    (setq creator  "dPro"))             ; MacDraw Pro
  (let ((old-pb *pict-output-pb*)
        pb pict-hand grafProcs)
    (when old-pb
      (error "A picture output file is already open"))
    (unwind-protect
      (progn
        (setq *pict-output-pb* t)            ; grab it
        (create-file filename
                     :mac-file-type "PICT"
                     :mac-file-creator creator)
        (let* ((wptr (wptr window))
               (color-p (window-color-p window))
               (size (if color-p $CQDProcs-size $QDProcs-size)))
          (setq grafProcs (#_NewPtr :errchk (+ $gpHeaderSize size)))
          (setq pb (FSOpen filename t))
          (let ((oldGrafProcs 
                 #-carbon-compat (rref wptr :grafport.grafProcs)
                 #+carbon-compat (#_GetPortGrafProcs (#_GetWindowPort wptr)))
                (newGrafProcs (%inc-ptr GrafProcs $gpHeaderSize)))
            (declare (dynamic-extent oldGrafProcs newGrafProcs))
            (%put-ptr grafProcs wptr $gpWptr)
            (%put-ptr grafProcs oldGrafProcs $gpOldGrafProcs)
            (if (%null-ptr-p oldGrafProcs)
              (if color-p
                (#_SetStdCProcs newGrafProcs)
                (#_SetStdProcs newGrafProcs))
              (#_BlockMove oldGrafProcs newGrafProcs size))
            (%stack-block ((data (max 4 $PictureSize) :clear t))
              (dotimes (i (/ 512 4))
                (FSWrite pb 4 data))
              (FsWrite pb $PictureSize data))
            (rset newGrafProcs :QDProcs.putPicProc *put-pict-data*)
            (unwind-protect
              (progn
                #-carbon-compat
                (rset wptr :grafport.grafProcs newGrafProcs)
                #+carbon-compat
                (#_SetPortGrafProcs (#_GetWindowPort wptr) newgrafprocs)
                (setq *pict-output-GrafProcs* t
                      *pict-output-pb* pb)
                (rlet ((picFrame :rect :topleft topleft :bottomright botright))
                  (with-port wptr
                    (setq pict-hand (#_OpenPicture picFrame)
                          *pict-output-handle* pict-hand)))
                (unless (%null-ptr-p pict-hand)
                  (setq *pict-output-GrafProcs* GrafProcs)
                  (%put-ptr grafProcs pict-hand $gpPictHand)))
              (when (eq t *pict-output-GrafProcs*)
                (setq *pict-output-pb* t)
                #-carbon-compat
                (rset wptr :grafport.grafProcs oldGrafProcs)
                #+carbon-compat
                (#_SetPortGrafProcs (#_GetWindowPort wptr) oldgrafprocs)))
            pict-hand
            )))
      (when (eq t *pict-output-pb*)
        (if pb (FSClose pb))
        (setq *pict-output-pb* nil
              *pict-output-handle* nil)
        (when grafProcs
          (#_DisposePtr grafProcs))))))

(defun close-pict-output-file (pict-hand)
  (let ((grafProcs *pict-output-GrafProcs*)
        (pb *pict-output-pb*))
    (unless pb
      (error "No picture output file open."))
    (unless (eql pict-hand (%get-ptr grafProcs $gpPictHand))
      (error "~s is not the pict-hand returned from open-pict-output-file"
             pict-hand))
    (let ((wptr (%get-ptr grafProcs $gpWptr))
          (oldGrafProcs (%get-ptr grafProcs $gpOldGrafProcs)))
      (with-port wptr
        (#_ClosePicture))
      #-carbon-compat
      (rset wptr :grafport.GrafProcs oldGrafProcs)
      #+carbon-compat
      (#_SetPortGrafProcs (#_GetWindowPort wptr) oldgrafprocs)
      (#_DisposePtr grafProcs)
      (SetFpos pb 512)
      (with-dereferenced-handles ((pict pict-hand)) ;with-pointers ((pict pict-hand))
        (FSWrite pb $PictureSize pict))
      (#_KillPicture pict-hand)
      (FSClose pb)
      (setq *pict-output-GrafProcs* nil
            *pict-output-handle* nil
            *pict-output-pb* nil))))

(defmacro with-pict-output-file ((filename window topleft botright &key creator) &body body)
  (let ((pict-hand (make-symbol "PICT-HAND")))
    `(let ((,pict-hand (open-pict-output-file
                        ,filename ,window ,topleft ,botright :creator ,creator)))
       (unwind-protect
         (progn ,@body)
         (close-pict-output-file ,pict-hand)))))

(defun scale-lisp-point (point factor)
  (make-point (round (* (point-h point) factor))
              (round (* (point-v point) factor))))

(defun display-pict-file (filename &optional (scale-factor 1) window)
  (unless window
    (setq window (make-instance 'palette-window :window-show nil)))
  (with-pict-input-file (pict filename window)
    (let* ((topleft (scale-lisp-point (rref pict :picture.picFrame.topLeft) scale-factor))
           (bottomright (scale-lisp-point (rref pict :picture.picFrame.bottomRight)
                                          scale-factor))
           (size (subtract-points bottomright topleft)))
      (set-view-size window size)
      (rlet ((rect :rect :topleft topleft :bottomright bottomright))
        (window-select window)
        (event-dispatch)
        (with-focused-view window
          (#_DrawPicture pict rect)
          (with-port-macptr port
            (#_QDFlushPortBuffer port *null-ptr*)))))))

; Sometimes you want to load a pict file into memory.
(defun load-pict-file (pathname)
  (with-FSOpen-file (pb pathname)
    (let* ((size (- (getEOF pb) 512))
           (pict (#_NewHandle :errchk size)))
      (setFpos pb 512)      
      (with-dereferenced-handles ((pict-pointer pict))
        (FSRead pb size pict-pointer))
      pict)))

; Sometimes you want to store a pict into a file
(defun store-pict-to-file (pict pathname &key 
                                (if-exists :error)
                                (creator "dPro"))       ; MacDraw Pro
  (setq pict (require-type pict 'macptr))
  (create-file pathname
               :if-exists if-exists
               :mac-file-type "PICT"
               :mac-file-creator creator)
  (with-FSOpen-file (pb pathname t)
    (%stack-block ((header 512))
      (dotimes (i 512) (setf (%get-byte header i) 0))
      (FSWrite pb 512 header))
    (with-dereferenced-handles ((pict-pointer pict))
      (FSWrite pb (#_GetHandleSize pict) pict-pointer))))

(provide :picture-files)

#|
; Example of use

(defparameter *w* (make-instance 'window :view-size #@(200 200) :color-p t))

(defvar *picture-file* "ccl:picture-file.temp")

; Draw a square with an X inside and save it to *picture-file*
(defun make-it ()
  (delete-file *picture-file*)
  (window-select *w*)
  (with-focused-view *w*
    (with-pict-output-file (*picture-file* *w* #@(0 0) #@(200 200))
      (#_MoveTo 50 50)
      (#_LineTo 150 50)
      (#_LineTo 150 150)
      (#_LineTo 50 150)
      (#_LineTo 50 50)
      (#_LineTo 150 150)
      (#_MoveTo 150 50)
      (#_LineTo 50 150))
    #+carbon-compat
    (rlet ((rect :rect))
      (#_getwindowportbounds (wptr *w*) rect)
      (#_eraserect rect))
    #-carbon-compat
    (#_EraseRect (rref (wptr *w*) :windowRecord.portrect))))

; Draw the picture that is in *picture-file* on *w* inside the given rect.
(defun draw-it (&optional (bottomright #@(200 200)) (topleft #@(0 0)))
  (window-select *w*)
  (with-focused-view *w*
    #+carbon-compat
    (rlet ((rect :rect))
      (#_getwindowportbounds (wptr *w*) rect)
      (#_eraserect rect))
    #-carbon-compat
    (#_EraseRect (rref (wptr *w*) :windowRecord.portrect))
    (with-pict-input-file (pict *picture-file* *w*)
      ; Real code would probably want to access
      ; (rref pict :picture.picFrame.topleft) & 
      ; (rref pict :picture.picFrame.bottomright) here
      (unless topleft (setq topleft (rref pict :picture.picFrame.topLeft)))
      (unless bottomright (setq bottomright (rref pict :picture.picFrame.bottomRight)))
      (rlet ((rect :rect :topleft topleft :bottomright bottomright))
        (#_DrawPicture pict rect)
        (with-port-macptr port ;; doesn;t help
          (#_QDFlushPortBuffer port *null-ptr*))))))

(defun do-it ()
  (make-it)
  (draw-it))

|#
     


#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
