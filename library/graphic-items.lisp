;;-*- Mode: Lisp; Package: CCL -*-
;;;;;;;;;;;;;;;;;;;;
;;
;;  graphic-items.lisp
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995-2000 Digitool, Inc.
;;
;;
;;  an abstract class of dialog-items which display, but can't be clicked.
;;  graphic-dialog-items work by defining point-in-item-p to always
;;  return nil.
;;
;;  title-box-dialog-items are a sub-class of graphic-dialog-items which
;;  are used for putting frames around areas in dialogs
;;

;;;;;;;;;;;;;;;;;;;;
;;
;; Change History
;;
;; no change
;; ------- 5.2b4
;; use draw-theme-text-box
;; ------- 5.1 final
;; 09/11/00 akh carbon-compat don't invalrect
;; ----------- 4.3.1b2
;; 03/11/94 bill view-corners accounts for title outside of bounding box.
;;               set-view-font-codes & set-view-font invalidate correctly and smartly
;; ------------- 2.0.1, 3.0d13
;; 04/07/92 bill The interface-designer package is no more
;;-------------- 2.0
;; 10/15/91 bill window-font -> view-font
;;-------------- 2.0b3
;; 07/09/91 bill (provide 'graphic-items)
;;-------------- 2.0b2

(in-package :ccl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(graphic-dialog-item title-box-dialog-item) :ccl))

(defclass graphic-dialog-item (dialog-item)
  ())
(defclass title-box-dialog-item (graphic-dialog-item)
  ((title-box-width :initform 0 :accessor title-box-width)))

;;;;;;;;;;;;;;;;;;;;;;
;;
;; graphic-dialog-items redefine point-in-click-region-p so that the
;; items aren't clickable (i.e., they never cover up other items)
;;

(defmethod point-in-click-region-p ((item graphic-dialog-item) point)
  (if (and (editing-dialogs-p (view-window item))
           (call-next-method))
      (progn
        (do-dialog-items (item (view-container item))
          (unless (inherit-from-p item 'graphic-dialog-item)
            (when (view-contains-point-p item point)
              (return-from point-in-click-region-p nil))))
        t)
      nil))


;;;;;;;;;;;;;;;;;;;;;;
;;
;;  title-box-dialog-items are used for putting named frames around
;;  areas in a dialog.
;;

(defmethod install-view-in-window ((item title-box-dialog-item) dialog)
  (declare (ignore-if-unused dialog))
  (let* ((topleft (view-position item))
         (bottomright (add-points topleft (view-size item))))
    (rlet ((r :rect :topleft topleft
              :bottomright bottomright))
      (rset r :rect.top (- (rref r :rect.top) 8))
      #-carbon-compat
      (#_InvalRect :ptr r)
      #+carbon-compat
      (inval-window-rect (wptr dialog) r)))
  (call-next-method)
  (update-title-box-width item))

(defun update-title-box-width (item)
  (when (wptr item)
    (multiple-value-bind (ff ms) (view-font-codes item)
    (setf (title-box-width item)          
          (font-codes-string-width-for-control (dialog-item-text item) ff ms)))))

(defvar *dont-invalidate* nil)

(defmethod set-view-font-codes :around ((item title-box-dialog-item) ff ms &optional
                                        ff-mask ms-mask)
  (declare (ignore ff ms ff-mask ms-mask))
  (invalidate-title item t)
  (let ((*dont-invalidate* t))
    (call-next-method))
  (update-title-box-width item)
  (invalidate-title item))

(defmethod set-dialog-item-text :around ((item title-box-dialog-item) new-text)
  (declare (ignore new-text))
  (invalidate-title item t)
  (let ((*dont-invalidate* t))
    (call-next-method))
  (update-title-box-width item)
  (invalidate-title item))

(defmethod view-draw-contents ((item title-box-dialog-item))
  (let* ((topleft (view-position item))
         (bottomright (add-points topleft (view-size item))))
    (rlet ((r :rect :topleft topleft
              :bottomright bottomright))
      (#_FrameRect :ptr r)
      (rset r rect.left (+ (rref r rect.left) 4))
      (rset r rect.bottom (+ (rref r rect.top) 2))
      (rset r rect.right (+ (rref r rect.left)
                            4
                            (title-box-width item)))
      (#_EraseRect :ptr r)
      (let ((top-offset (nth-value 1 (label-offset item))))
        (rset r rect.top (+ (rref r rect.top) top-offset))
        (multiple-value-bind (ff ms)(view-font-codes item)
          (rset r rect.bottom (+ (rref r rect.top) (font-codes-line-height ff ms)))
          (draw-theme-text-box (dialog-item-text item) r :left))))))

(defun label-offset (title-box-dialog-item)
  (multiple-value-bind (ff ms) (view-font-codes title-box-dialog-item)
    (multiple-value-bind (ascent descent) (font-codes-info ff ms)
      (let ((ascent/2 (floor ascent 2)))
      (values (make-point 6 ascent/2)
              (- ascent/2 ascent)
              descent)))))

(defun invalidate-title (item &optional erase-p)
  (let ((container (view-container item)))
    (when container
      (multiple-value-bind (offset top-offset descent) (label-offset item)
        (let ((pos (view-position item))
              (offset-h (point-h offset))
              (offset-v (point-v offset)))
          (invalidate-corners container
                              (add-points pos
                                          (make-point offset-h top-offset))
                              (add-points pos
                                          (make-point (+ offset-h (title-box-width item) 4)
                                                      (+ offset-v descent)))
                              erase-p))))))

; The title extends outside of the bounding box, so
; we need to correct.
(defmethod view-corners ((item title-box-dialog-item))
  (if *dont-invalidate*
    (values #@(0 0) #@(0 0))
    (multiple-value-bind (tl br) (call-next-method)
      (values (add-points tl (make-point 0 (nth-value 1 (label-offset item))))
              br))))

(provide 'graphic-items)


#|

(setq my-box (make-instance 'title-box-dialog-item
                            :dialog-item-text "Buttons"
                            :view-position #@(20 20)
                            :view-size #@(100 100)))

(setq my-dialog (make-instance 'dialog
                               :view-size #@(200 125)
                               :view-subviews (list my-box)))

|#

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
