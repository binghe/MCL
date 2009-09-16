;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; appearance-editable-text.lisp
;;;
;;; Patches the basic-editable-text-dialog-item so that it supports the Appearance Manager of MacOS 8.
;;;
;;; Copyright © 1999 Terje Norderhaug and Media Design in¥Progress
;;;
;;; Use and copying of this software and preparation of derivative works
;;; based upon this software are permitted, so long as this copyright 
;;; notice is included intact.
;;;
;;; Digitool is welcome to integrate parts or whole of this module in MCL without
;;; including the copyright note, as long as the author is mentioned in the version history.
;;;
;;; This software is made available AS IS, and no warranty is made about 
;;; the software or its performance. 
;;;
;;; Author: Terje Norderhaug <terje@in-progress.com> of Media Design in*Progress.
;;;
;;; Latest version available from <http://www.in-progress.com/src/appearance-editable-text.lisp>.
;;; Tested on MCL 4.2, but should also work with other recent versions of MCL.
;;; Requires the Appearance Manager contribution to MCL by Eric Russell <eric-r@nwu.edu>.
;;;
;;; Modifications to original MCL source are in blue color.

#| VERSION HISTORY

;; this file is obsolete
;; ----- 5.1b2
03/04/04 enhancement from Alex Repenning
1999-07-06 Version 1.0 released.

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :ccl)

(warn "Appearance-editable-text.lisp is obsolete. It does nothing.")

#+ignore
(require :appearance-manager "ccl:examples;appearance-manager-folder;appearance-manager.lisp")


;; Alexander Repenning: make this user controlable
#+ignore
(defmethod ERASE-FOCUS-RECT-P ((Self basic-editable-text-dialog-item))
  t)



#+ignore ;; this file is obsolete
(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))


  (defmethod view-draw-contents :after ((item basic-editable-text-dialog-item))
    (let ((item-position (view-position item))
          (item-size (view-size item))
          (colorp (color-or-gray-p item)))
      (with-slot-values (dialog-item-enabled-p draw-outline) item
        (rlet ((rect :rect)
               (ps :penstate))
          (rset rect rect.topleft item-position)
          (rset rect rect.bottomright
                (add-points item-position item-size))
          (#_GetPenState ps)
          (unwind-protect
            (progn
              (when draw-outline
                (let ((rgn1 *temp-rgn*)
                      (rgn2 *temp-rgn-2*)
                      (inset (if (fixnump draw-outline) draw-outline -3)))
                  (#_RectRgn rgn1 rect)
                  (if (appearance-available-p)
                    (#_insetRect rect 0 0) ;; adjust if necessarry
                    (#_insetRect rect inset inset)) ; I like -2 -2 better
                  (#_RectRgn rgn2 rect)
                  (#_DiffRgn rgn2 rgn1 rgn1)
                  (#_PenNormal)
                  (unless (or dialog-item-enabled-p colorp)
                    (#_PenPat *gray-pattern*))
                  (with-fore-color (if (and colorp (not dialog-item-enabled-p))
                                     *gray-color*
                                     (part-color item :frame))
                    (with-back-color (get-back-color (view-window item))
                      (#_EraseRgn rgn1)
                      (cond
                       ((appearance-available-p)
                        (let ((key-handler? (eq (window-key-handler (view-window item)) item)))
                          (when (erase-focus-rect-p item)
                            (unless key-handler? 
                              (#_DrawThemeFocusRect rect NIL)))
                          (#_DrawThemeEditTextFrame rect
                           (if dialog-item-enabled-p 1 0))
                          (when key-handler? 
                            (#_DrawThemeFocusRect rect T))))
                       (T
                        (#_FrameRect rect)))
                      ))
                  (#_insetRect rect 1 1)))
              (unless (or colorp dialog-item-enabled-p)
                (#_PenPat *gray-pattern*)
                (#_PenMode 11)
                (#_PaintRect rect)))
            (#_SetPenState ps))))))
)

#+ignore
(defmethod view-corners :around ((item basic-editable-text-dialog-item))
  (if (and (slot-value item 'draw-outline) (appearance-available-p))
    (multiple-value-call #'inset-corners #@(-3 -3) (call-next-method))
    (call-next-method)))

#+ignore
(defmethod exit-key-handler ((item basic-editable-text-dialog-item) new-item)
  (declare (ignore new-item))
  (when (and (slot-value item 'draw-outline) (appearance-available-p))
    (invalidate-view item))
  (call-next-method))

#+IGNORE
(defmethod enter-key-handler ((item basic-editable-text-dialog-item) old-item)
  (declare (ignore old-item))
  (when (and (slot-value item 'draw-outline) (appearance-available-p))
    (invalidate-view item))
  (call-next-method))

#+ignore
(provide :appearance-editable-text)




