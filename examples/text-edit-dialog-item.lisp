;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  2 6/2/97   akh  see below
;;  2 11/29/95 slh  merged in Alice's changes (below)
;;  3 6/23/95  akh  added te-typein-menu class, fixed some  set size and position bugs
;;                  No luck with body color
;;  (do not edit before this line!!)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; text-edit-dialog-item.lisp
;; Copyright 1990-1994, Apple Computer, Inc
;; Copyright 1995 Digitool, Inc.

;;
;; This file implements text-edit-dialog-item's.  If Fred is too big
;; for your application, you may wish to replace editable-text-dialog-item's
;; with text-edit-dialog-item's.
;;

;;;;;;;
;;
;; Mod history
;;
;; don't say #_offsetrect :ptr
;; with-pointers -> with-dereferenced-handles
;; ----- 5.1
;; more carbon-compat - use wptr-font-codes
;; -------- 4.4B3
;; 07/13/01 akh more carbon-compat in get-*te-handle*
;; 05/11/01 akh carbon-compat
;; _textbox => tetextbox
;; ------- 4.3f1c1
;; 05/05/97  akh better luck with body color
;; 03/26/96  gb  lowmem accessors.
;; 07/14/93 bill JooFung Wong's fix (slightly modified) that makes justification work
;;               No longer need color-list in view-key-event-handler
;; ------------- 3.0d11
;; 06/01/92 bill support :body color: with-fore-color -> with-text-color
;; 04/14/92 bill modernize dialog-item-text. Add dialog-item-text-length
;; ------------- 2.0
;; 01/07/92 gb   don't require "RECORDS".
;; 12/12/91 bill miner's fix to paste
;; ------------- 2.0b4
;; 10/30/91 bill remove "-iv" on the end of slot names
;; 10/24/91 bill Blake Meike's fix to dialog-te-handle.
;;               Prevent flashing in view-key-event-handler
;; 09/13/91 bill with-focused-font-view -> with-focused-dialog-item
;; 08/26/91 bill :pointer -> :ptr, indentation
;; 08/24/91 gb   use new trap syntax.
;; 05/17/91 bill # in front of $TEScrpHandle & $TEScrpLength thanx to UEDA masaya
;; foo/05/91 bill add TOGGLE-BLINKERS
;;----------- 2.0b1
;; 

(in-package :ccl)



(eval-when (:execute :load-toplevel :compile-toplevel)
  (export '(text-edit-dialog-item) :ccl))

(defclass text-edit-dialog-item (basic-editable-text-dialog-item)
  ((text-justification :initform 0 :initarg :text-justification)
   (sel-start :initform 0)
   (sel-end :initform 0)))

;; use this class if you want to have typein menus that use text-edit-dialog-item 
(defclass te-typein-menu (typein-menu)()
  (:default-initargs    
    :editable-text-class 'text-edit-dialog-item))

(defmethod part-color ((item text-edit-dialog-item) key)
  (or (getf (slot-value item 'color-list) key nil)
      (case key
        (:body *white-color*)
        (:text *black-color*))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Allocate one text-edit record for sharing by all. Process wise does this make sense??
;;
(defvar *te-handle* nil)
(defvar *null-text-handle* nil)
(defvar *te-handle-dialog-item* nil)

#-carbon-compat
(defun get-*te-handle* ()
  (let ((te-handle *te-handle*))
    (if (macptrp te-handle)
      te-handle
      (let* ((wptr %temp-port%)
             (rect (rref wptr grafport.portrect)))  ;; wrong for OSX
        (with-port wptr
          (setq te-handle (#_TENew rect rect))
          (setq *te-handle* te-handle
                *null-text-handle* (rref te-handle :TERec.HText)
                *te-handle-dialog-item* nil)
          te-handle)))))

#+carbon-compat
(defun get-*te-handle* ()
  (let ((te-handle *te-handle*))
    (if (macptrp te-handle)
      te-handle
      (let* ((wptr %temp-port%))
        (rlet ((rect :rect))
          (#_getwindowportbounds wptr rect)
          (with-port wptr
            (setq te-handle (#_TENew rect rect))
            (setq *te-handle* te-handle
                  *null-text-handle* (rref te-handle :TERec.HText)
                  *te-handle-dialog-item* nil)
            te-handle))))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Update the text-edit record for the current-key-handler of a window
;;
(defmethod dialog-te-handle ((w window) &optional select)
  (without-interrupts
   (let* ((hTE (get-*te-handle*))
          (item *te-handle-dialog-item*)
          (current-text (current-key-handler w)))
     (cond ((not (typep current-text 'text-edit-dialog-item))   ; ignore fred-dialog-items
            (setq *te-handle-dialog-item* nil))
           (t (unless (eq current-text item)
                (let ((wptr (wptr w)))         ; generate error if there is none.
                  (when item
                    (setf (slot-value item 'sel-start) (rref hTE TERec.selstart)
                          (slot-value item 'sel-end) (rref hTE TERec.selend))
                    (with-focused-view (view-container item)
                      (with-fore-color (part-color item :text)
                        (with-back-color (part-color item :body)
                          (#_TEDeactivate hTE)))))
                  (if (null current-text)
                    (progn
                      (rset hTE TERec.hText *null-text-handle*)
                      (rset hTE TERec.inport #+carbon-compat (#_getwindowport %temp-port%)
                                             #-carbon-compat %temp-port))
                    (with-focused-view (view-container current-text)
                      (with-fore-color (part-color current-text :text)
                        (with-back-color (part-color current-text :body)
                      (rset hTE terec.inport #+carbon-compat (#_getwindowport wptr)
                                              #-carbon-compat wptr)
                      (with-slot-values (dialog-item-handle line-height font-ascent
                                         text-justification)
                                        current-text
                        (rset hTE TERec.Just text-justification)   ; JooFung Wong's fix
                        (rset hTE TERec.hText dialog-item-handle)
                        (rset hTE TERec.LineHeight line-height)
                        (rset hTE TERec.FontAscent font-ascent))
                      (with-item-rect (rect current-text)
                        ;could change this to copy-record for clarity ***
                        (rset hTE TERec.destrect.topleft (rref rect :rect.topleft))
                        (rset hTE TERec.destrect.bottomright (rref rect :rect.bottomright))
                        (rset hTE TERec.viewrect.topleft (rref rect :rect.topleft))
                        (rset hTE TERec.viewrect.bottomright (rref rect :rect.bottomright)))
                      (rset hTE TERec.clickloc -1)
                      (multiple-value-bind (ff ms) (view-font-codes current-text)
                        (%hput-long hTE ff 74)
                        (%hput-long hTE ms 78)
                        (with-font-codes ff ms
                          (#_TEAutoView t hTE)
                          (#_TECalText hTE)
                          (if select
                            (progn
                              (rset hTE TERec.selstart 0)
                              (rset hTE TERec.selend 32000))
                            (progn
                              (rset hTE TERec.selstart (slot-value current-text 'sel-start))
                              (rset hTE TERec.selend  (slot-value current-text 'sel-end))))
                          (if #-carbon-compat (rref wptr windowrecord.hilited)
                              #+carbon-compat (#_iswindowhilited wptr)
                            (#_TEActivate hTE))))))))
                  (setq *te-handle-dialog-item* current-text)))
              hTE)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; The guts
;;

(defmethod key-handler-idle ((item text-edit-dialog-item) &optional 
                          (dialog (view-window item)))
  (let ((hTE (dialog-te-handle dialog)))
    (with-focused-dialog-item (item)
      (#_TEIdle hTE))))

; Should never be called unless the item is contained in a window.
(defmethod install-view-in-window ((item text-edit-dialog-item) view)
  (declare (ignore view))
  (let* ((text (ensure-simple-string (slot-value item 'dialog-item-text)))
         (h (%str-to-handle text)))
    (setf (slot-value item 'dialog-item-handle) h
          (slot-value item 'dialog-item-text) nil))
  (call-next-method))

(defmethod remove-view-from-window ((item text-edit-dialog-item))
  (dispose-text-edit-handle item))

(defun dispose-text-edit-handle (item)
  (with-slot-values ((h dialog-item-handle)) item
    (when h
      (with-dereferenced-handles ((p h))
        (setf (slot-value item 'dialog-item-text)
              (%str-from-ptr p (#_GetHandleSize h))))
      (#_DisposeHandle :errchk h))))

(defmethod remove-key-handler :after ((item text-edit-dialog-item) &optional
                                      (dialog (view-window item)))
  (when dialog
    (dialog-te-handle dialog)))   ; update the *te-handle*

; This is not always necessary, but the code that knows if it is
; is in the method for basic-editable-text-dialog-item.
(defmethod dialog-item-disable :before ((item text-edit-dialog-item))
  (let ((dialog (view-window item)))
    (when (and dialog (dialog-item-handle item))
      (dialog-te-handle dialog))))

(defmethod set-view-font-codes :after ((item text-edit-dialog-item)
                                       ff ms &optional ff-mask ms-mask
                                       &aux height)
  (declare (ignore ff-mask ms-mask))
  (multiple-value-setq (ff ms) (view-font-codes item))
  (multiple-value-bind (ascent descent widmax leading)
                       (font-codes-info ff ms)
    (declare (ignore widmax))
    (setf height (+ ascent descent leading)
          (slot-value item 'line-height) height
          (slot-value item 'font-ascent) ascent)
    (let ((my-dialog (view-window item)))
      (when (and my-dialog
                 (eq item (current-key-handler my-dialog)))
        (let ((te-handle (dialog-te-handle my-dialog)))
          (rset te-handle :terec.fontAscent ascent)
          (rset te-handle :terec.lineHeight height))))))

(defmethod set-view-position :before ((item text-edit-dialog-item) h &optional v
                              &aux (new-pos (make-point h v)))
  (let ((my-dialog (view-window item))
        (position (view-position item)))    
    (when my-dialog
       (if (eq item (current-key-handler my-dialog))
         (with-dereferenced-handles ((pTE (dialog-te-handle my-dialog)))
           (if position
             (let* ((diff (subtract-points new-pos position))
                    (h (point-h diff))
                    (v (point-v diff)))
              (#_OffsetRect (pref pTE terec.viewrect) h v)
              (#_OffsetRect (pref pTE terec.destrect) h v))
             (progn
               (setf (pref pTE terec.viewrect.topleft) position)
               (setf (pref pTE terec.destrect.bottomright) (add-points position (view-size item))))))))))

(defmethod set-view-size ((item text-edit-dialog-item) h &optional v
                          &aux (new-size (make-point h v)))
  (without-interrupts
   (invalidate-view item t)
   (setf (slot-value item 'view-size) new-size)
   (when (and (installed-item-p item)(view-position item))
     (with-focused-dialog-item (item)
       (let* ((my-dialog (view-window item))
              (position (view-position item))
              (new-corner (add-points position new-size))
              (hTE (dialog-te-handle my-dialog)))
         (if (eq item (current-key-handler my-dialog))
           (progn
             (rset hTE terec.viewrect.bottomright new-corner)
             (rset hTE terec.destrect.bottomright new-corner)
             (#_TECalText hTE)
             (invalidate-view item)))))))
  new-size)

(defmethod view-click-event-handler ((item text-edit-dialog-item) where)
  (let ((my-dialog (view-window item)))
    (with-quieted-view item             ; prevents flashing
      (if (neq item (current-key-handler my-dialog)) 
        (set-current-key-handler my-dialog item nil))
      (with-focused-dialog-item (item)
        (with-fore-color (part-color item :text)
          (with-back-color (part-color item :body)            
            (#_TEClick where (shift-key-p) (dialog-te-handle my-dialog))))))))

(defmethod view-activate-event-handler ((item text-edit-dialog-item))
  (let ((my-dialog (view-window item)))
    (if (eq item (current-key-handler my-dialog))
      (with-focused-dialog-item (item)
        (with-fore-color (part-color item :text)
          (with-back-color (part-color item :body)
            (#_TEActivate (dialog-te-handle my-dialog))))))))

(defmethod view-deactivate-event-handler ((item text-edit-dialog-item))
  (let ((my-dialog (view-window item)))
    (if (and my-dialog (eq item (current-key-handler my-dialog)))
      (with-focused-dialog-item (item)
        (with-fore-color (part-color item :text)
          (with-back-color (part-color item :body)
            (#_TEDeactivate (dialog-te-handle my-dialog))))))))

(defmethod toggle-blinkers ((item text-edit-dialog-item) on-p)
  (if on-p
    (view-activate-event-handler item)
    (view-deactivate-event-handler item)))

(defmethod set-dialog-item-text ((item text-edit-dialog-item) text)
  (setq text (ensure-simple-string text))
  (if (installed-item-p item)
    (progn
      (%str-to-handle text (dialog-item-handle item))
      (with-focused-dialog-item (item)
        (let ((my-dialog (view-window item)))
          (when (eq item (current-key-handler my-dialog))
            (#_TECalText (dialog-te-handle my-dialog))))
        (when (> (length text) 0)
          (set-selection-range item 0 32000))
        (invalidate-view item)))
    (setf (slot-value item 'dialog-item-text) text))
  text)

(defmethod dialog-item-text ((item text-edit-dialog-item))
  (let ((handle (dialog-item-handle item)))
    (if (and handle (wptr item))
      (with-dereferenced-handles ((tp handle))
        (%str-from-ptr tp (#_GetHandleSize handle)))
      (slot-value item 'dialog-item-text))))

(defmethod dialog-item-text-length ((item text-edit-dialog-item))
  (let ((handle (dialog-item-handle item)))
    (if (and handle (wptr item))
      (#_GetHandleSize handle)
      (length (slot-value item 'dialog-item-text)))))      

(defmethod view-draw-contents :after ((item text-edit-dialog-item)
                                      &aux  te size)
  (let ((my-dialog (view-window item))
        (item-position (view-position item))
        (item-size (view-size item))
        (enabled-p (dialog-item-enabled-p item))
        (colorp (color-or-gray-p item)))
    (when (installed-item-p item)
      (with-slot-values (dialog-item-handle text-justification)
                        item
        (without-interrupts
         (rlet ((rect :rect))
           (rset rect rect.topleft item-position)
           (rset rect rect.bottomright
                 (add-points item-position item-size))
           (setq te (dialog-te-handle my-dialog))
           (setq size (#_GetHandleSize dialog-item-handle))           
           (with-fore-color (if (and colorp (not enabled-p))
                              *gray-color* 
                              (part-color item :text))
             (with-back-color (part-color item :body)
               (if (eq item (current-key-handler my-dialog))
                 (progn
                   (let ((wp (wptr my-dialog)))
                     (multiple-value-bind (ff ms)
                                          (wptr-font-codes wp)
                       
                       (%hput-long te ff 74)
                       (%hput-long te ms 78)
                       (#_EraseRect rect)  ; << put this back seems good for body color
                       (#_TEUpdate rect te))))
                 (with-dereferenced-handles ((tp dialog-item-handle))
                   (#_TETextBox tp size rect text-justification)))))))))))

(defmethod view-key-event-handler ((item text-edit-dialog-item) char)
  (when (integerp char) (setq char (code-char char)))
  (let ((container (view-container item)))
    (with-focused-dialog-item (item container)
      (with-text-colors item
        (#_TEKey char (dialog-te-handle (view-window item))))
      (dialog-item-action item))))

(defmethod selection-range ((item text-edit-dialog-item))
  (without-interrupts
   (if (eq item *te-handle-dialog-item*)
     (let ((teh *te-handle*))
       (values
        (rref teh teREC.selstart)
        (rref teh teREC.selend)))
     (values (slot-value item 'sel-start)
             (slot-value item 'sel-end)))))

(defmethod set-selection-range ((item text-edit-dialog-item) &optional start end)
  (multiple-value-bind (s e) (selection-range item)
    (unless start (setq start e))
    (unless end (setq end e))
    (if (< end start) (psetq start end end start))
    (unless (and (eq start s) (eq end e))
      (setf (slot-value item 'sel-start) start
            (slot-value item 'sel-end) end)
      (without-interrupts
       (when (eq item *te-handle-dialog-item*)
         (let ((teh *te-handle*))
           (with-focused-view (view-container item)
             (with-fore-color (part-color item :text)
               (with-back-color (part-color item :body)
                 (#_TESetSelect start end teh))))))))))

(defmethod cut ((item text-edit-dialog-item))
  (let ((my-dialog (view-container item)))
    (with-focused-view my-dialog
      (with-fore-color (part-color item :text)
        (with-back-color (part-color item :body)
          (with-font-codes nil nil
            (#_TECut (dialog-te-handle (view-window item))))))))
  (te-scrap-to-lisp-scrap)
  (dialog-item-action item))

(defmethod copy ((item text-edit-dialog-item))
  (let ((my-dialog (view-container item)))
    (with-focused-view my-dialog
      (with-font-codes nil nil
        (#_TECopy (dialog-te-handle (view-window item))))))
  (te-scrap-to-lisp-scrap)
  (dialog-item-action item))

(defun te-scrap-to-lisp-scrap ()
  #-carbon-compat
  (put-scrap :text (%str-from-ptr (%get-ptr (#_LMGetTEScrpHandle))
                                  (#_LMGetTEScrpLength)))
  #+carbon-compat
  (put-scrap :text (%str-from-ptr (%get-ptr (#_TEGetScrapHandle))
                                  (#_TEGetScrapLength))))
                                  
             

(defmethod paste ((item text-edit-dialog-item))
  (let ((my-dialog (view-container item))
        (scrap (get-scrap :text))
        (te-handle (dialog-te-handle (view-window item))))
    (when scrap
      (with-focused-view my-dialog
        (with-fore-color (part-color item :text)
          (with-back-color (part-color item :body)
            (with-font-codes nil nil
              (with-cstrs ((sp scrap))
                (#_TEDelete te-handle)
                (#_TEInsert sp (length scrap) te-handle))))))))
  (dialog-item-action item))

(defmethod select-all ((item text-edit-dialog-item))
  (set-selection-range item 0 32000))
  

(defmethod clear ((item text-edit-dialog-item))
  (let ((my-dialog (view-container item)))
    (with-focused-view my-dialog
      (with-fore-color (part-color item :text)
        (with-back-color (part-color item :body)
          (with-font-codes nil nil
            (#_TEDelete (dialog-te-handle (view-window item))))))))
  (dialog-item-action item))

#| This code doesn't work yet
(defclass etdi (fred-dialog-item) ())
(defclass etdi (text-edit-dialog-item) ())

(defmethod update-instance-for-redefined-class
  ((item etdi #|editable-text-dialog-item|#) added-slots discarded-slots property-list
   &key)
  (declare (ignore discarded-slots))
  (let ((fred-p (memq 'frec added-slots))
        (window (view-window item)))
    (if window
      (remove-view-from-window item))
    (if fred-p
      (progn
        (dispose-text-edit-handle item)
        (instance-initialize item :view-font (view-font item)))
      (let* ((frec (getf property-list 'frec))
             (buf (uvref frec 1)))      ; (fr.cursor frec)
        (setf (slot-value item 'dialog-item-text)
              (buffer-substring buf 0 (buffer-size buf)))))
    (if window
      (install-view-in-window item window)))
  item)
|#


(provide 'text-edit-dialog-item)

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
