;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; clock-dialog-items.lisp
;;;
;;; "DATE & TIME"-STYLE CONTROLS
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
;;; Caution: a clock item that is both live-p and editiable-p will change
;;;   your system clock.
;;;
;;; fix to set-universal-time from Terje N.

(in-package :ccl)

(export '(time-dialog-item time-seconds-dialog-item date-dialog-item
          month-year-dialog-item universal-time set-universal-time
          live-p editable-p))

;;;----------------------------------------------------------------------
;;; External requirements

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :new-control-dialog-item))

;;;----------------------------------------------------------------------
;;; Classes

(defclass clock-dialog-item (key-handler-mixin  new-control-dialog-item)
  ((editable-p :reader editable-p :initform nil)
   (live-p     :reader live-p :initform nil)
   (initial-time :initform (get-universal-time) :initarg :initial-time 
                 :reader initial-time)))

(defclass time-dialog-item (clock-dialog-item)
  ((procid :allocation :class :initform #$kControlClockTimeProc)))

(defclass time-seconds-dialog-item (clock-dialog-item)
  ((procid :allocation :class :initform #$kControlClockTimeSecondsProc)))

(defclass date-dialog-item (clock-dialog-item)
  ((procid :allocation :class :initform #$kControlClockDateProc)))

(defclass month-year-dialog-item (clock-dialog-item)
  ((procid :allocation :class :initform #$kControlClockMonthYearProc)))

;;;----------------------------------------------------------------------
;;; Defaut size methods

(defmethod view-default-size ((view time-dialog-item))
  #@(80 24))

(defmethod view-default-size ((view time-seconds-dialog-item))
  #@(100 24))

(defmethod view-default-size ((view date-dialog-item))
  #@(80 24))

(defmethod view-default-size ((view month-year-dialog-item))
  #@(60 24))

;;;----------------------------------------------------------------------
;;; Initialization methods

(defmethod initialize-instance ((item clock-dialog-item) &rest initargs
                                &key (editable-p nil) (live-p nil))
  (declare (ignore initargs))
  (call-next-method)
  (setf (slot-value item 'editable-p) editable-p)
  (setf (slot-value item 'live-p) live-p))

(defmethod make-control-handle ((item clock-dialog-item) wptr)
  (with-pstrs ((sp (dialog-item-text item)))
    (with-item-rect (rect item)
      (setf (dialog-item-handle item)
            (#_NewControl  
             wptr
             rect 
             sp
             nil
             (+ (if (editable-p item) 0 #$kControlClockIsDisplayOnly)
                (if (live-p item) #$kControlClockIsLive 0))
             0 
             1
             (control-dialog-item-procid item)             
             0))))      
  (when (and (not (live-p item))
             (initial-time item))
    (setf (universal-time item) (initial-time item))))

;;;----------------------------------------------------------------------
;;; Save the time in case we get added again

(defmethod remove-view-from-window ((item clock-dialog-item))
  (setf (slot-value item 'initial-time) (universal-time item))
  (call-next-method))

;;;----------------------------------------------------------------------
;;; Setting live-p and editable-p

(defmethod (setf editable-p) (value (item clock-dialog-item))
  (unless (eql value (editable-p item))
    (setf (slot-value item 'editable-p) value)
    (maybe-reinstall-item item)))

(defmethod (setf live-p) (value (item clock-dialog-item))
  (unless (eql value (live-p item))
    (setf (slot-value item 'live-p) value)
    (maybe-reinstall-item item)))

;;;----------------------------------------------------------------------
;;; Key-handling stuff

(defmethod key-handler-p ((item clock-dialog-item))
  (editable-p item))

(defmethod view-cursor ((item clock-dialog-item) where)
  (declare (ignore where))
  *arrow-cursor*)

(defmethod enter-key-handler ((item clock-dialog-item) old-item)
  (declare (ignore old-item))
  (when (installed-item-p item)
    (with-focused-dialog-item (item)
      (with-back-color (back-color item)
        (#_SetKeyboardFocus 
         (wptr item)
         (dialog-item-handle item)
         #$kControlFocusNextPart))))
  (call-next-method))

(defmethod exit-key-handler ((item clock-dialog-item) new-item)
  (declare (ignore new-item))
  (when (installed-item-p item)
    (with-focused-dialog-item (item)
      (with-back-color (back-color item)
        (#_SetKeyboardFocus 
         (wptr item)
         (dialog-item-handle item)
         #$kControlFocusNoPart))
      (invalidate-view item)))
  (call-next-method))

(defmethod view-key-event-handler ((item clock-dialog-item) char)
  (when (installed-item-p item)
    (with-focused-dialog-item (item)
      (with-back-color (back-color item)
        (case char
          (#\ForwardArrow
           (#_AdvanceKeyboardFocus (wptr item)))
          (#\BackArrow
           (#_ReverseKeyboardFocus (wptr item)))
          (t
           (#_HandleControlKey
            (dialog-item-handle item)
            (char-code char)
            (char-code char)
            (get-modifiers))))))))

;;;----------------------------------------------------------------------
;;; Make ourselves the key handler when we get clicked

(defmethod view-click-event-handler ((item clock-dialog-item) where)
  (declare (ignore where))
  (when (key-handler-p item)
    (with-focused-dialog-item (item)
      (set-current-key-handler (view-window item) item)))
  (call-next-method))

;;;----------------------------------------------------------------------
;;; Getting and setting the time/date via universal-time

(defmethod universal-time ((item clock-dialog-item))
  (when (installed-item-p item)
    (rlet ((size :size)
           (date :LongDateRec))
      (let ((ecode (#_GetControlData  
                    (dialog-item-handle item)
                    0
                    #$kControlClockLongDateTag
                    #.(record-length :LongDateRec)
                    date
                    size)))
        (when (eq ecode #$noErr)
          (let ((year   (pref date :LongDateRec.year))
                (month  (pref date :LongDateRec.month))
                (day    (pref date :LongDateRec.day))
                (hour   (pref date :LongDateRec.hour))
                (minute (pref date :LongDateRec.minute))
                (second (pref date :LongDateRec.second)))
            (encode-universal-time (if (<= 0 second 59) second 0)
                                   (if (<= 0 minute 59) minute 0)
                                   (if (<= 0 hour 23) hour 0)
                                   (if (<= 1 day 31) day 0)
                                   (if (<= 1 month 12) month 1)
                                   (if (<= 1904 year) year 1904))))))))

(defmethod set-universal-time ((item clock-dialog-item) utime)
  (multiple-value-bind (second minute hour day month year day-of-week dst-p)
                       (decode-universal-time utime)
    (set-control-data item
                      #$kControlClockLongDateTag
                      :LongDateRec
                      :era       1
                      :year      year
                      :month     month
                      :day       day
                      :hour      (if dst-p
                                   (mod (1- hour) 24)
                                   hour)
                      :minute    minute
                      :second    second
                      :dayOfWeek day-of-week))
  utime)

(defmethod (setf universal-time) (utime (item clock-dialog-item))
  (set-universal-time item utime))

;;;----------------------------------------------------------------------
;;; The appearance-activity-mixin is incompatable with editable clock
;;; dialog items.

(defmethod activation-hilite ((item clock-dialog-item) hilite-p)
  (declare (ignore hilite-p))
  (unless (editable-p item)
    (call-next-method)))

;;;----------------------------------------------------------------------

(provide :clock-dialog-items)