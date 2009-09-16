;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; little-arrows-dialog-item.lisp
;;;
;;; THE LITTLE ARROWS CONTROL
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
;;; Authors: Eric Russell <eric-r@nwu.edu>,
;;;          Terje Norderhaug <terje@in-progress.com> of Media Design in*Progress
;;;
;;; Based in part on "ccl:Library;scroll-bar-dialog-items.lisp" by Digitool
;;;
;;; add-pascal-upp-alist -> add-pascal-upp-alist-macho
;;; --- 5.1 final
;;; akh (#_LMGetDoubleTime)   => (#_getdbltime)
;;; akh - add-pascal-upp-alist

(in-package :ccl)

(export '(little-arrows-dialog-item little-arrows-min
          set-little-arrows-min little-arrows-max set-little-arrows-max
          little-arrows-setting set-little-arrows-setting 
          little-arrows-increment set-little-arrows-increment 
          little-arrows-adjustee set-little-arrows-adjustee 
          little-arrows-changed))

;;;----------------------------------------------------------------------
;;; Requirements

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :new-control-dialog-item "ccl:examples;appearance-manager-folder;new-control-dialog-item"))

;;;----------------------------------------------------------------------
;;; Variables

(defvar *little-arrows-item* nil)

;;;----------------------------------------------------------------------
;;; Our action proc

#+ignore
(add-pascal-upp-alist '*little-arrows-action-proc* #'(lambda (procptr)(#_newcontrolactionupp procptr)))

#-ignore
(add-pascal-upp-alist-macho '*little-arrows-action-proc* "NewControlActionUPP")

(defpascal *little-arrows-action-proc* (:ptr handle :word part)
  "Adjust the control value and call dialog-item-action"
  (declare (ignore handle))
  (let ((item *little-arrows-item*))
    (track-little-arrows 
     item
     (little-arrows-setting item)
     (case part
       (#.#$kControlUpButtonPart :up-button)
       (#.#$kControlDownButtonPart :down-button)
       (t nil)))))

;;;----------------------------------------------------------------------
;;; The class 

(defclass little-arrows-dialog-item (new-control-dialog-item)
  ((procid :initarg :procid :initform #$kControlLittleArrowsProc :allocation :class)
   (action-proc :initarg :action-proc :initform *little-arrows-action-proc* :allocation :class)
   (min :initarg :min :reader little-arrows-min)
   (max :initarg :max :reader little-arrows-max)
   (setting :initarg :setting :reader little-arrows-setting)
   (increment :initarg :increment :initform 1 :reader little-arrows-increment)
   (adjustee :initarg :adjustee :initform nil :reader little-arrows-adjustee)))

;;;----------------------------------------------------------------------
;;; Re-set the action-proc slot when MCL is launched, because 
;;; kill-lisp-pointers will get rid of it when you save an application
;;; (thanks to David B. Lamkins for pointing this out)

(def-load-pointers little-arrows-dialog-item ()
  (setf (slot-value (class-prototype (find-class 'little-arrows-dialog-item))
                    'action-proc)
        *little-arrows-action-proc*))

;;;----------------------------------------------------------------------
;;; Functions

(defconstant $little-arrows-max 32767)
(defconstant $little-arrows-min -32768)

(defun mac-little-arrows-min-max (min max &aux dif)
  (unless (>= max min) (setq max min))
  (cond ((and (>= min $little-arrows-min) (<= max $little-arrows-max))
         (values min max))
        ((< (setq dif (- max min)) (+ $little-arrows-max $little-arrows-max))
         (let ((min-return
                (max $little-arrows-min
                     (min min (- $little-arrows-max dif)))))
           (values min-return (+ min-return dif))))
        (t (values $little-arrows-min $little-arrows-max))))

(defun mac-little-arrows-setting (setting min max &optional mac-min mac-max)
  (if (<= max min)
    min
    (progn (unless (and mac-min mac-max)
             (multiple-value-setq (mac-min mac-max) 
               (mac-little-arrows-min-max min max)))
           (min mac-max (max mac-min setting)))))

;;;----------------------------------------------------------------------
;;; Initialization methods

(defmethod view-default-size ((item little-arrows-dialog-item))
  #@(14 23))

(defmethod initialize-instance ((item little-arrows-dialog-item) &rest initargs
                                &key (min 0) (max 100) (setting 0))
  (setq min     (min min max)
        max     (max min max)
        setting (min (max setting min) max))
  (apply #'call-next-method
         item
         :max max
         :min min
         :setting setting
         initargs))

(defmethod make-control-handle ((item little-arrows-dialog-item) wptr)
  (let* ((setting     (little-arrows-setting item))
         (min         (little-arrows-min item))
         (max         (little-arrows-max item))
         (mac-setting (mac-little-arrows-setting setting min max)))
    (multiple-value-bind (mac-min mac-max) (mac-little-arrows-min-max min max)
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
               0))))))

;;;----------------------------------------------------------------------
;;; Tracking methods

(defmethod view-click-event-handler ((item little-arrows-dialog-item) where)
  (declare (ignore where))
  (let ((*little-arrows-item* item))
    (call-next-method)))

(defmethod track-little-arrows ((item little-arrows-dialog-item) value part)
  (set-little-arrows-setting
   item
   (case part
     (:up-button (+ value (little-arrows-increment item)))
     (:down-button (- value (little-arrows-increment item)))
     (t value))))

(defmethod dialog-item-action ((item little-arrows-dialog-item))
  (let ((f (dialog-item-action-function item)))
    (if f
      (funcall f item)
      (let ((adjustee (little-arrows-adjustee item)))
        (when adjustee
          (little-arrows-changed adjustee item))))))

(defmethod little-arrows-changed (view arrows)
  (declare (ignore view arrows)))

;;;----------------------------------------------------------------------
;;; Property-setting methods

(defmethod set-little-arrows-increment ((item little-arrows-dialog-item) value)
  (setq value (require-type value 'fixnum))
  (setf (slot-value item 'increment) value))

(defmethod (setf little-arrows-increment) (value (item little-arrows-dialog-item))
  (set-little-arrows-increment item value))

(defmethod set-little-arrows-setting ((item little-arrows-dialog-item) value)
  (cond ((appearance-available-p)
         (setq value (require-type value 'fixnum))
         (%set-little-arrows-setting item value t))
        (t
         ;;
         ;; Pre-OS8 compatability (thanks to Terje Norderhaug)
         ;;
         (setf (slot-value item 'setting) value)
         (dialog-item-action item))))

(defmethod (setf little-arrows-setting) (value (item little-arrows-dialog-item))
  (set-little-arrows-setting item value))

(defun %set-little-arrows-setting (item value only-if-changed-p)
  (setq value (max (little-arrows-min item) (min (little-arrows-max item) value)))
  (unless (and only-if-changed-p (eql value (little-arrows-setting item)))
    (let ((handle (dialog-item-handle item)))
      (when handle
        (#_SetControlValue
         handle
         (mac-little-arrows-setting
          value
          (little-arrows-min item)
          (little-arrows-max item)))))
    (setf (slot-value item 'setting) value)
    (dialog-item-action item))
  value)

(defmethod set-little-arrows-min ((item little-arrows-dialog-item) value)
  (setq value (require-type value 'fixnum))
  (unless (eql value (little-arrows-min item))
    (setf (slot-value item 'min) value)
    (update-little-arrows-max-min-setting item))
  value)

(defmethod (setf little-arrows-min) (value (item little-arrows-dialog-item))
  (set-little-arrows-min item value))

(defmethod set-little-arrows-max ((item little-arrows-dialog-item) value)
  (setq value (require-type value 'fixnum))
  (unless (eql value (little-arrows-max item))
    (setf (slot-value item 'max) value)
    (update-little-arrows-max-min-setting item))
  value)

(defmethod (setf little-arrows-max) (value (item little-arrows-dialog-item))
  (set-little-arrows-max item value))

(defun update-little-arrows-max-min-setting (item)
  (let ((handle (dialog-item-handle item)))
    (when handle
      (let ((max (little-arrows-max item))
            (min (little-arrows-min item))
            (setting (little-arrows-setting item)))
        (multiple-value-bind (mac-min mac-max) (mac-little-arrows-min-max min max)
          (#_SetControlMinimum handle mac-min)
          (#_SetControlMaximum handle mac-max)
          (%set-little-arrows-setting item setting t))))))

;;;----------------------------------------------------------------------
;;; Pre-OS8 compatability methods (thanks to Terje Norderhaug).

(defparameter %little-arrows-direction% NIL)

(defmethod view-draw-no-appearance-contents ((item little-arrows-dialog-item))
  (with-focused-view (view-container item)
    (with-item-rect (rect item)
      (#_InsetRect rect 1 0)
      (#_OffsetRect rect -1 0)
      (with-back-color (part-color item :back-color)
       (with-fore-color (if (dialog-item-enabled-p item) *black-color* *gray-color*)
        (#_eraseroundrect rect 5 5)
        (#_frameroundrect rect 5 5)
        (#_MoveTo 
          (+ (rref rect rect.left) 3)
          (+ (rref rect rect.top) 4))
        (#_Move :long #@( 3 0))
        (#_Line :long #@( 1 1))
        (#_Line :long #@(-2 0))
        (#_Line :long #@(-1 1))
        (#_Line :long #@( 4 0))
        (#_Move :long #@( 0 10))
        (#_Line :long #@(-4 0))
        (#_Line :long #@( 1 1))
        (#_Line :long #@( 2 0))
        (#_Line :long #@(-1 1))        
        (let ((split (floor (+ (rref rect rect.top) (rref rect rect.bottom)) 2)))
          (#_MoveTo (rref rect rect.left) split)
          (#_LineTo (1- (rref rect rect.right)) split)
          (when %little-arrows-direction%
            (#_InsetRect rect 1 1)
            (case %little-arrows-direction%
              (:up-button 
                (setf (rref rect rect.bottom) split)) 
              (:down-button
                (setf (rref rect rect.top) (1+ split))))
            (#_invertrect rect))))))))

(defmethod little-arrow-direction ((item little-arrows-dialog-item) pos)
  (rlet ((rect :rect :topleft #@(0 0) :botright (view-size item)))
    (when (point-in-rect-p rect pos)
      (if (< (point-v pos)
             (+ 2 (floor (point-v (view-size item)) 2)))
        :up-button
        :down-button))))

(defmethod view-click-event-handler ((item little-arrows-dialog-item) where)
  (declare (ignore where))
  (if (appearance-available-p)
    (let ((*little-arrows-item* item))  ;; << AKH
      (call-next-method))
    (when (dialog-item-enabled-p item)
      (with-focused-view item
        (loop
          for dir = (little-arrow-direction item (view-mouse-position item))
          do (unless (eq %little-arrows-direction% dir)
               (setf %little-arrows-direction% dir)
               (force-view-draw-contents item))
          do (when dir
               (track-little-arrows item 1 dir))
          do (process-wait "Doubletime"
                           #'(lambda ()
                               (or (not (mouse-down-p))
                                   (> (- (get-tick-count) *last-mouse-down-time*)
                                      #-carbon-compat(#_LMGetDoubleTime)
                                      #+carbon-compat (#_getdbltime)
                                      ))))
          do (process-wait-with-timeout "MouseUp" 
                                        5 
                                        #'(lambda ()
                                            (not (mouse-down-p))))
          while (mouse-down-p) 
          do (%run-masked-periodic-tasks))
        (setf %little-arrows-direction% NIL)
        (force-view-draw-contents item)))))

;;;----------------------------------------------------------------------

(provide :little-arrows-dialog-item)