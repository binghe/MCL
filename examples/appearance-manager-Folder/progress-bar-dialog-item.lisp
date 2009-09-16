;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; progress-bar-dialog-item.lisp
;;;
;;; THE OS8 PROGRESS BAR
;;;
;;; Copyright ©1997-1999
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
;;; Based in part on "ccl:Library;scroll-bar-dialog-items.lisp" by Digitool
;;;
;;; Thanks to Terje Norderhaug for finding a bug in update-progress-bar-min-max
;;;
;;; akh July 01 - no more (rref (wptr item) :GrafPort.portRect.topleft) if carbon
;;; akh oct 03 - fix so that progress bar can be contained in a subview - from Terje N.
;;; akh oct 03 - set-progress-bar-determinate-p fix from Terje N. 

(in-package :ccl)

(export '(progress-bar-dialog-item
          progress-bar-min set-progress-bar-min
          progress-bar-max set-progress-bar-max
          progress-bar-setting set-progress-bar-setting
          progress-bar-determinate-p set-progress-bar-determinate-p))

;;;----------------------------------------------------------------------
;;; Requirements

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :new-control-dialog-item "ccl:examples;appearance-manager-folder;new-control-dialog-item"))

;;;----------------------------------------------------------------------
;;; The class

(defclass progress-bar-dialog-item (new-control-dialog-item)
  ((procid :initarg :procid :initform #$kControlProgressBarProc 
           :allocation :class)
   (min :initarg :min :reader progress-bar-min)
   (max :initarg :max :reader progress-bar-max)
   (setting :initarg :setting :reader progress-bar-setting)
   (determinate-p :initarg :determinate-p :initform t 
                  :reader progress-bar-determinate-p)))

;;;----------------------------------------------------------------------
;;; Functions

(defconstant $progress-bar-max 32767)
(defconstant $progress-bar-min -32768)

(defun mac-progress-bar-min-max (min max &aux dif)
  (unless (>= max min) (setq max min))
  (cond ((and (>= min $progress-bar-min) (<= max $progress-bar-max))
         (values min max))
        ((< (setq dif (- max min)) (+ $progress-bar-max $progress-bar-max))
         (let ((min-return
                (max $progress-bar-min
                     (min min (- $progress-bar-max dif)))))
           (values min-return (+ min-return dif))))
        (t (values $progress-bar-min $progress-bar-max))))

(defun mac-progress-bar-setting (setting min max &optional mac-min mac-max)
  (if (<= max min)
    min
    (progn (unless (and mac-min mac-max)
             (multiple-value-setq (mac-min mac-max) 
               (mac-progress-bar-min-max min max)))
           (min mac-max (max mac-min setting)))))


;;;----------------------------------------------------------------------
;;; Initialization methods

(defmethod view-default-size ((item progress-bar-dialog-item))
  #@(100 12))

(defmethod initialize-instance ((item progress-bar-dialog-item)
                                &rest initargs
                                &key
                                (min 0)
                                (max 100)
                                (setting 0))
  (setq min     (min min max)
        max     (max min max)
        setting (min (max setting min) max))
  (apply #'call-next-method
         item
         :min min
         :max max
         :setting setting
         initargs))

#| ;; ITS IN QUICKDRAW
(defun offset-rect (RECT offset)
  (setf (pref rect :rect.topleft) (add-points (pref rect :rect.topleft) offset))
  (setf (pref rect :rect.botright) (add-points (pref rect :rect.botright) offset)))
|#
  

(defmethod make-control-handle ((item progress-bar-dialog-item) wptr)
  (let* ((setting     (progress-bar-setting item))
         (min         (progress-bar-min item))
         (max         (progress-bar-max item))
         (mac-setting (mac-progress-bar-setting setting min max)))
    (multiple-value-bind (mac-min mac-max) (mac-progress-bar-min-max min max)
      (with-item-rect (rect item)        
        (setf (dialog-item-handle item)
              (#_NewControl 
               wptr
               rect
               (%null-ptr)
               nil
               mac-setting
               mac-min
               mac-max
               (control-dialog-item-procid item)
               0))))
    (set-control-data item
                      #$kControlProgressBarIndeterminateTag
                      :byte
                      (if (progress-bar-determinate-p item) 0 1))))

(defun get-wptr-origin (wptr)
  #+carbon-compat
  (rlet ((rect :rect))
    (#_getwindowportbounds wptr rect)  ;; is this the same thing?
    (pref rect :rect.topleft))
  #-carbon-compat
  (rref wptr :GrafPort.portRect.topleft))
     

#|
;; below setorigin 0,0 things may not be needed
(defmethod view-draw-contents :around ((item progress-bar-dialog-item))
  (let ((origin (get-wptr-origin (wptr item))))
    (#_SetOrigin :word 0 :word 0)
    (call-next-method)
    (#_SetOrigin :long origin)))

(defmethod view-activate-event-handler :around ((item progress-bar-dialog-item))
  (let ((origin (get-wptr-origin (wptr item))))
    (#_SetOrigin :word 0 :word 0)
    (call-next-method)
    (#_SetOrigin :long origin)))

(defmethod view-deactivate-event-handler :around ((item progress-bar-dialog-item))
  (let ((origin (get-wptr-origin (wptr item))))
    (#_SetOrigin :word 0 :word 0)
    (call-next-method)
    (#_SetOrigin :long origin)))
|#


;;;----------------------------------------------------------------------
;;; property-setting methods

(defmethod set-progress-bar-setting ((item progress-bar-dialog-item) value)
  (setq value (require-type value 'fixnum))
  (with-focused-dialog-item (item)
    (with-macptrs ((handle (dialog-item-handle item)))
      (when handle
        (#_SetControlValue
         handle
         (mac-progress-bar-setting
          value
          (progress-bar-min item)
          (progress-bar-max item))))))
  (setf (slot-value item 'setting) value))

(defmethod (setf progress-bar-setting) (value (item progress-bar-dialog-item))
  (set-progress-bar-setting item value))

(defmethod set-progress-bar-min ((item progress-bar-dialog-item) value)
  (setq value (require-type value 'fixnum))
  (unless (eql value (progress-bar-min item))
    (setf (slot-value item 'min) value)
    (update-progress-bar-min-max item))
  value)

(defmethod (setf progress-bar-min) (value (item progress-bar-dialog-item))
  (set-progress-bar-min item value))

(defmethod set-progress-bar-max ((item progress-bar-dialog-item) value)
  (setq value (require-type value 'fixnum))
  (unless (eql value (progress-bar-max item))
    (setf (slot-value item 'max) value)
    (update-progress-bar-min-max item))
  value)

(defmethod (setf progress-bar-max) (value (item progress-bar-dialog-item))
  (set-progress-bar-max item value))

(defmethod update-progress-bar-min-max ((item progress-bar-dialog-item))
  (let ((handle (dialog-item-handle item)))
    (when handle
      (let ((min (progress-bar-min item))
            (max (progress-bar-max item))
            (setting (progress-bar-setting item)))
        (multiple-value-bind (mac-min mac-max) (mac-progress-bar-min-max min max)
          (#_SetControlMinimum handle mac-min)
          (#_SetControlMaximum handle mac-max)
          (set-progress-bar-setting item setting))))))

(defmethod set-progress-bar-determinate-p ((item progress-bar-dialog-item)
                                           determinate-p)
  (setf determinate-p (and determinate-p T)) ; ensure boolean to avoid eql problems
  (unless (eql determinate-p (progress-bar-determinate-p item))
    (setf (slot-value item 'determinate-p) determinate-p)
    (set-control-data item
                      #$kControlProgressBarIndeterminateTag
                      :byte
                      (if determinate-p 0 1)))
  determinate-p)

(defmethod (setf progress-bar-determinate-p) (determinate-p 
                                              (item progress-bar-dialog-item))
  (set-progress-bar-determinate-p item determinate-p))

;;;----------------------------------------------------------------------

(provide :progress-bar-dialog-item)