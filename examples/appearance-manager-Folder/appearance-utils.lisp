;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; appearance-utils.lisp
;;;
;;; UTILITY FUNCTIONS AND METHODS FOR THE APPEARANCE-MANAGER MODULE
;;;
;;; Copyright ©1998-1999
;;; Supportive Inquiry Based Learning Environments Project
;;; Learning Sciences Program
;;; School of Education & Social Policy
;;; Northwestern University
;;;
;;; Use and copying of this software and preparation of derivative works
;;; based upon this software are permitted, so long as this copyright 
;;; notice is included intact.
;;;
;;; This software is made available AS IS, and no warranty is made about 
;;; the software or its performance. 
;;;
;;; Author: Eric Russell <eric-r@nwu.edu>
;;; 

(in-package :ccl)

;; don't say #_invertrect :pointer ...
;;
;; Oodles-of-utils has a hilite-view method. This allows you to load
;; either method first, without encountering package problems.
;;

(eval-when (:compile-toplevel :load-toplevel :execute)
  (let ((p (find-package "OOU")))
    (when p
      (let ((sym (find-symbol "HILITE-VIEW" p)))
        (if sym
          (shadowing-import (list sym) (find-package "CCL"))
          (shadowing-import '(hilite-view) p))))))

(export '(track-button-click hilite-view system-font-spec))

;;;----------------------------------------------------------------------
;;; Font Utilities
;;;
;;; "ignore" parameter allows you to call these with multiple-value-call
;;; without worrying about extra return values stepping on the stack.

;;;
;;; Font
;;;

(defun font-codes-font (ff ms &rest ignore)
  (declare (dynamic-extent ignore) (ignore ms ignore))
  (rlet ((fname (:string 256)))
    (#_GetFontName (ff-font-number ff) fname)
    (%get-string fname)))

(defun font-codes-font-number (ff ms &rest ignore)
  (declare (dynamic-extent ignore) (ignore ms ignore))
  (ff-font-number ff))

(defun ff-font-number (ff)
  (point-v ff))

;;
;; Face (style)
;;

(defun font-codes-style-number (ff ms &rest ignore)
  (declare (dynamic-extent ignore) (ignore ms ignore))
  (ff-style-number ff))

(defun ff-style-number (ff)
  (ash (point-h ff) -8))

;;
;; Color
;;

(defun font-codes-color (ff ms &rest ignore)
  (declare (dynamic-extent ignore) (ignore ms ignore))
  (ff-color ff))

(defun ff-color (ff)
  (logand ff #xFF))

;;
;; Size
;;

(defun font-codes-size (ff ms &rest ignore)
  (declare (dynamic-extent ignore) (ignore ff ignore))
  (ms-size ms))

(defun ms-size (ms)
  (point-h ms))

;;
;; Mode
;;

(defun font-codes-mode (ff ms &rest ignore)
  (declare (dynamic-extent ignore) (ignore ff ignore))
  (elt *pen-modes* (ms-mode-number ms)))

(defun font-codes-mode-number (ff ms &rest ignore)
  (declare (dynamic-extent ignore) (ignore ff ignore))
  (ms-mode-number ms))

(defun ms-mode-number (ms)
  (point-v ms))

;;
;; Now that the system font is variable, we need a way to get it.
;;

(defun system-font-spec ()
  (rlet ((name (:string 256)))
    (#_GetFontName (#_LMGetSysFontFam) name)
    (list (%get-string name)
          (#_LMGetSysFontSize)
          :srcor
          :plain)))

;;;----------------------------------------------------------------------
;;; View utilities

(unless (fboundp 'hilite-view)
  (defmethod hilite-view ((view simple-view) hilite-p)
    (declare (ignore hilite-p))
    (multiple-value-bind (topleft botright) (view-corners view)
      (rlet ((r :rect :topleft topleft :botright botright))
        (with-hilite-mode
          (#_InvertRect r))))))

(defmethod track-button-click ((view simple-view) 
                               &optional
                               (hilite-function #'hilite-view)
                               (test-function #'point-in-click-region-p))
  (let ((container (view-container view))
        (mouse-was-in-view-p t))
    (funcall hilite-function view t)
    (ccl::while (mouse-down-p)
      (if (funcall test-function view (view-mouse-position container))
        (unless mouse-was-in-view-p
          (funcall hilite-function view t)
          (setq mouse-was-in-view-p t))
        (when mouse-was-in-view-p
          (funcall hilite-function view nil)
          (setq mouse-was-in-view-p nil))))
    (when mouse-was-in-view-p
      (funcall hilite-function view nil)
      t)))

;;;----------------------------------------------------------------------

(provide :appearance-utils)