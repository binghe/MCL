;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; appearance-activity-mixin.lisp
;;;
;;; MIXIN FOR VIEWS THAT DRAW DIFFERENTLY WHEN INACTIVE
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

;; require :new-control-dialog-item
;; lose view-activate/deactivate for control-dialog-item, make it new-control-dialog-item
;; ------- 5.1b2

(in-package :ccl)

(eval-when (:compile-toplevel :load-toplevel :execute) 
  (require :appearance-globals)
  ;(require :appearance-manager)
  (require :new-control-dialog-item "ccl:examples;appearance-manager-folder;new-control-dialog-item")
  )

(export '(appearance-activity-mixin draw-active-p))

;;;----------------------------------------------------------------------
;;; The class

(defclass appearance-activity-mixin () ())

;;;----------------------------------------------------------------------
;;; Invalidate when we're activated or deactivated…

(defmethod view-activate-event-handler ((view appearance-activity-mixin))
  (call-next-method)
  (when *draw-inactive-dialog-items-as-disabled*
    (invalidate-view view)))

(defmethod view-deactivate-event-handler ((view appearance-activity-mixin))
  (call-next-method)
  (when *draw-inactive-dialog-items-as-disabled*
    (invalidate-view view)))

;;
;; …unless we're in the midst of changing key handlers
;;

(defmethod set-current-key-handler :around ((window window) handler &optional select-all)
  (declare (ignore handler select-all))
  (let ((*draw-inactive-dialog-items-as-disabled* nil))
    (call-next-method)))

;;;----------------------------------------------------------------------
;;; This is how draw methods ask how they should draw

(defmethod draw-active-p ((view simple-view) &aux (window (view-window view)))
  (or (appearance-compatibility-mode-p)
      (not *draw-inactive-dialog-items-as-disabled*)
      (and window (window-active-p window))))

(defmethod draw-active-p ((view dialog-item) &aux (window (view-window view)))
  (or (appearance-compatibility-mode-p)
      (not *draw-inactive-dialog-items-as-disabled*)
      (and window (window-active-p window) (dialog-item-enabled-p view))))

;;;----------------------------------------------------------------------
;;; Give control-dialog-items the desired behavior


(defmethod view-activate-event-handler ((view new-control-dialog-item))
  (call-next-method)
  (when (and (not (appearance-compatibility-mode-p))
             *draw-inactive-dialog-items-as-disabled*
             (dialog-item-enabled-p view))
    (activation-hilite view t)))

(defmethod view-deactivate-event-handler ((view new-control-dialog-item))
  (when (and (not (appearance-compatibility-mode-p))
             *draw-inactive-dialog-items-as-disabled*
             (dialog-item-enabled-p view))
    (activation-hilite view nil))
  (call-next-method))


(defmethod activation-hilite ((view new-control-dialog-item) hilite-p)
  (when (installed-item-p view)
    (with-focused-dialog-item (view)
      (#_HiliteControl (dialog-item-handle view) (if hilite-p 0 255)))))


;;;----------------------------------------------------------------------

(provide :appearance-activity-mixin)