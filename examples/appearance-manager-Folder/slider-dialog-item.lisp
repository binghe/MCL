;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; slider-dialog-item.lisp
;;;
;;; THE SLIDER CONTROL
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
;;; Last Updated: 4/13/98
;;;
;;; add-pascal-upp-alist -> add-pascal-upp-alist-macho
;;; ----- 5.1 final
;;; akh add-pascal-upp-alist

(in-package :ccl)

(export '(slider-dialog-item
          slider-min set-slider-min
          slider-max set-slider-max
          slider-setting set-slider-setting
          slider-changed))

;;;----------------------------------------------------------------------
;;; Requirements

(eval-when (:compile-toplevel :load-toplevel :execute)
   (require :new-control-dialog-item "ccl:examples;appearance-manager-folder;new-control-dialog-item"))

;;;----------------------------------------------------------------------
;;; Variables

(defvar *slider-item* nil)

;;;----------------------------------------------------------------------
;;; Our action proc

#+ignore
(add-pascal-upp-alist '*slider-action-proc* #'(lambda (procptr)(#_newcontrolactionupp procptr)))

#-ignore
(add-pascal-upp-alist-macho '*slider-action-proc* "NewControlActionUPP")

(defpascal *slider-action-proc* (:ptr handle :word part)
  (declare (ignore part))
  (let ((item *slider-item*))
    (set-slider-setting
     item
     (outside-slider-setting item handle))))

;;;----------------------------------------------------------------------
;;; The class

(defclass slider-dialog-item (new-control-dialog-item)
  ((procid :initarg :procid :initform #$kControlSliderProc :allocation :class)
   (action-proc :initarg :action-proc :initform *slider-action-proc* :allocation :class)
   (direction :initarg :direction :reader slider-direction)
   (thumb-direction :initarg :thumb-direction :reader thumb-direction)
   (min :initarg :min :reader slider-min)
   (max :initarg :max :reader slider-max)
   (setting :initarg :setting :reader slider-setting)
   (tick-count :initarg :tick-count :reader slider-tick-count)
   (track-thumb-p :initarg :track-thumb-p :initform t :reader track-thumb-p)
   (adjustee :initarg :adjustee :initform nil :reader slider-adjustee)))

;;;----------------------------------------------------------------------
;;; Re-set the action-proc slot when MCL is launched, because 
;;; kill-lisp-pointers will get rid of it when you save an application
;;; (thanks to David B. Lamkins for pointing this out)

(def-load-pointers slider-dialog-item ()
  (setf (slot-value (class-prototype (find-class 'slider-dialog-item))
                    'action-proc)
        *slider-action-proc*))

;;;----------------------------------------------------------------------
;;; Functions

(defconstant $slider-max 32767)
(defconstant $slider-min -32768)

(defun mac-slider-min-max (min max &aux dif)
  (unless (>= max min) (setq max min))
  (cond ((and (>= min $slider-min) (<= max $slider-max))
         (values min max))
        ((< (setq dif (- max min)) (+ $slider-max $slider-max))
         (let ((min-return
                (max $slider-min
                     (min min (- $slider-max dif)))))
           (values min-return (+ min-return dif))))
        (t (values $slider-min $slider-max))))

(defun mac-slider-setting (setting min max &optional mac-min mac-max)
  (if (<= max min)
    min
    (progn (unless (and mac-min mac-max)
             (multiple-value-setq (mac-min mac-max) 
               (mac-slider-min-max min max)))
           (min mac-max (max mac-min setting)))))

(defun outside-slider-setting (slider handle)
  (let ((mac-setting (#_GetControlValue handle))
        (mac-min (#_GetControlMinimum handle))
        (mac-max (#_GetControlMaximum handle))
        (min (slider-min slider))
        (max (slider-max slider)))
    (declare (fixnum mac-min mac-max))
    (if (eql mac-min mac-max)
      mac-min
      (+ min (round (* (- mac-setting mac-min) (- max min))
                    (- mac-max mac-min))))))

;;;----------------------------------------------------------------------
;;; Initialization methods

(defmethod view-default-size ((item slider-dialog-item))
  #@(24 100))

(defmethod initialize-instance ((item slider-dialog-item) &rest initargs
                                &key
                                (min 0)
                                (max 100)
                                (setting 0)
                                (direction :vertical)
                                (thumb-direction :none)
                                view-size)
  (setq min (min min max)
        max (max min max)
        setting (min (max setting min) max))
  (when view-size
    (setq direction 
          (if (> (point-h view-size) (point-v view-size))
            :horizontal
            :vertical)))
  (ecase direction
    (:vertical   (unless (memq thumb-direction '(:right :left :none))
                   (error "Illegal thumb-direction ~S (must be one of ~
                           '(:right :left :none) for vertical slider)."
                          thumb-direction)))
    (:horizontal (unless (memq thumb-direction '(:up :down :none))
                   (error "Illegal thumb-direction ~S (must be one of ~
                           '(:up :down :none) for horizontal slider)."
                          thumb-direction))))
  (apply #'call-next-method
         item
         :min min
         :max max
         :setting setting
         :direction direction
         :view-size view-size
         :thumb-direction thumb-direction
         initargs))

(defmethod make-control-handle ((item slider-dialog-item) wptr)
  (let* ((setting     (slider-setting item))
         (min         (slider-min item))
         (max         (slider-max item))
         (mac-setting (mac-slider-setting setting min max))
         (ticks-p     (and (fixnump (slider-tick-count item))
                           (> (slider-tick-count item) 0))))
    (multiple-value-bind (mac-min mac-max) (mac-slider-min-max min max)
      (with-item-rect (rect item)
        (setf (dialog-item-handle item)
              (#_NewControl 
               wptr
               rect
               (%null-ptr)
               nil
               (if ticks-p
                 (slider-tick-count item)
                 mac-setting)
               mac-min
               mac-max
               (+ (control-dialog-item-procid item)
                  (if (track-thumb-p item)
                    #$kControlSliderLiveFeedback
                    0)
                  (if (eq (thumb-direction item) :none)
                    #$kControlSliderNonDirectional
                    0)
                  (if (or (and (eq (slider-direction item) :horizontal)
                               (eq (thumb-direction item) :up))
                          (and (eq (slider-direction item) :vertical)
                               (eq (thumb-direction item) :left)))
                    #$kControlSliderReverseDirection
                    0)
                  (if (and (fixnump (slider-tick-count item))
                           (> (slider-tick-count item) 0))
                    #$kControlSliderHasTickMarks
                    0))
               0))))
    (when ticks-p
      (#_SetControlValue (dialog-item-handle item) mac-setting))))

;;;----------------------------------------------------------------------
;;; Tracking methods

(defmethod view-click-event-handler ((item slider-dialog-item) where)
  (let ((*slider-item* item)
        (handle (dialog-item-handle item)))
    (cond ((track-thumb-p item)
           (call-next-method))
          (t
           (#_TrackControl handle where (%null-ptr))
           (set-slider-setting
            item
            (outside-slider-setting item handle))))))

(defmethod dialog-item-action ((item slider-dialog-item))
  (let ((f (dialog-item-action-function item)))
    (if f
      (funcall f item)
      (let ((adjustee (slider-adjustee item)))
        (when adjustee
          (slider-changed adjustee item))))))

(defmethod slider-changed (adjustee slider)
  (declare (ignore adjustee slider)))

;;;----------------------------------------------------------------------
;;; Property-setting methods

(defmethod set-slider-setting ((item slider-dialog-item) value)
  (setq value (require-type value 'fixnum))
  (%set-slider-setting item value t))

(defmethod (setf slider-setting) (value (item slider-dialog-item))
  (set-slider-setting item value))

(defun %set-slider-setting (item value only-if-changed-p)
  (setq value (max (slider-min item) (min (slider-max item) value)))
  (unless (and only-if-changed-p (eql value (slider-setting item)))
    (let ((handle (dialog-item-handle item)))
      (when handle
        (#_SetControlValue
         handle
         (mac-slider-setting 
          value
          (slider-min item)
          (slider-max item)))))
    (setf (slot-value item 'setting) value)
    (dialog-item-action item)))

(defmethod set-slider-min ((item slider-dialog-item) value)
  (setq value (require-type value 'fixnum))
  (unless (eql value (slider-min item))
    (setf (slot-value item 'min) value)
    (update-slider-min-max item))
  value)

(defmethod (setf slider-min) (value (item slider-dialog-item))
  (set-slider-min item value))

(defmethod set-slider-max ((item slider-dialog-item) value)
  (setq value (require-type value 'fixnum))
  (unless (eql value (slider-max item))
    (setf (slot-value item 'max) value)
    (update-slider-min-max item))
  value)

(defmethod (setf slider-max) (value (item slider-dialog-item))
  (set-slider-max item value))

(defmethod update-slider-min-max ((item slider-dialog-item))
  (let ((handle (dialog-item-handle item)))
    (when handle
      (let ((min (slider-min item))
            (max (slider-max item))
            (setting (slider-setting item)))
        (multiple-value-bind (mac-min mac-max) (mac-slider-min-max min max)
          (#_SetControlMinimum handle mac-min)
          (#_SetControlMaximum handle mac-max)
          (%set-slider-setting item setting t))))))

;;;----------------------------------------------------------------------

(provide :slider-dialog-item)