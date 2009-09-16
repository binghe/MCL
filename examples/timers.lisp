;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Package: CCL; Base: 10 -*-
;;; timers.lisp
;;;
;;; Genera style timers
;;; Just enough for CL-HTTP
;;; Copyright 1996-1999, Digitool, Inc.
;;; All rights reserved.

(in-package :ccl)

;;;
;;; create-timer-call creates a process, so it is a fairly heavy-weight operation.
;;; This package currently requires MCL-PPC, either 3.9 or 4.0 or greater in order for timer
;;; processes to be automatically killed when the timer is GC'd.
;;; Other than that, it works in MCL for 68K.
;;; In MCL for 68K, you need to explicitly execute (ccl::terminate timer) to get rid
;;; of a timer's process.
;;;

(eval-when (:execute :compile-toplevel :load-toplevel)
  (export '(create-timer-call
            clear-timer
            reset-timer-absolute
            reset-timer-relative
            )))

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History
;;;
;;; 08/08/99 akh add reset-timer-relative
;;; 07/29/99 akh   use #_lmgettime, nah use get-time-words
;;; -------------- 4.3f1c1
;;; 11/04/96 bill  Define $time if it isn't defined already.
;;;                This fixes Terje Norderhaug's bug.
;;; 10/29/96 bill  Gerhard Weber's fix to get-decoded-universal-time to
;;;                make it work outside of daylight savings time.
;;; -------------  4.0
;;; 10/09/96 slh   move export to inside eval-when
;;; 09/30/96 bill  Gerhard Weber's fix to get-decoded-universal-time to make
;;;                it work when the time zone is negative.
;;; 09/27/96 bill  Gerhard Weber's fixes to my brain-damage in remove-from-timer-queue
;;;                and %reset-timer-absolute.
;;; 09/20/96 slh   use declaim ftype to avoid warning
;;; -------------  4.0b2
;;; 09/20/96 bill  clear-timer removed a :pending-universal-time timer
;;;                from *universal-time-timer-qhead* instead of *ticks-timer-qhead*.
;;;                Thanks to Gerhard Weber.
;;;                In create-timer-call, say (funcall 'terminate-when-unreachable ...)
;;;                So that 3.0 won't warn about an undefined function.
;;; -------------  4.0b2
;;;  9/18/96 slh   prep for Examples; use defloadvar for timer task
;;; 08/23/96 bill  New file
;;;

(defclass timer ()
  ((name :accessor timer-name :initarg :name)
   (function :accessor timer-function :initarg :function)
   (args :accessor timer-args :initarg :args)
   (process :accessor timer-process :initarg :process)
   (universal-time :accessor timer-universal-time
                   :initform (multiple-value-bind (sec min hour date month year)
                                                  (get-decoded-universal-time)
                               (vector sec min hour date month year)))
   (ticks :accessor timer-ticks :initform (get-tick-count))
   (link :accessor timer-link :initform nil)
   (reset-while-running-p :accessor timer-reset-while-running-p :initform nil)
   (state :accessor timer-state         ; nil, :pending-ticks, :pending-universal-time, the timer itself
          :initform (list nil))))       ; It's a cons so the process doesn't hold on to the timer

(defmethod print-object ((timer timer) stream)
  (print-unreadable-object (timer stream :type t :identity t)
    (prin1 (timer-name timer) stream)))

(defvar *ticks-timer-qhead* nil)
(defvar *universal-time-timer-qhead* nil)

; Don't do boundp checks
(declaim (type t *ticks-timer-qhead* *universal-time-timer-qhead*))

#+not-yet-implemented
(defun ticks-timer-task ()
  (loop
    (let ((now (get-tick-count))
          timer)
      (declare (fixnum now))
      (without-interrupts               ; already there, but be sure
       (unless (setq timer *ticks-timer-qhead*)
         (return))
       (when (> 0 (%tick-difference now (timer-ticks timer)))
         (return))
       (setf *ticks-timer-qhead* (timer-link timer)
             (timer-link timer) nil))
      ; Put the timer in the timer-state cell. This both marks it as running
      ; and protects it from GC until its process runs and clears the cell.
      (setf (car (timer-state timer)) timer)
      (process-unblock (timer-process timer)))))

; For MCL 3.0
(eval-when (:compile-toplevel :execute :load-toplevel)
  (unless (boundp '$time)
    (defconstant $time 524)))

; Same as (decode-universal-time (get-universal-time) 0), but it doesn't cons.
(defun get-decoded-universal-time ()
  (rlet ((dt :longDateRec))
    (multiple-value-bind (time-zone dst) (get-time-zone)
      (declare (fixnum time-zone))
      (unless (eql dst 0) (decf time-zone 1))
      (multiple-value-bind (time-high time-low)(get-time-words)
        (let* (;(it (#_lmgettime))
               ;(time-high (logand #xffff (ash it -16)))
               ;(time-low (logand it #xffff))
               (seconds (* 3600 time-zone)))
          (declare (fixnum time-low time-high seconds))
          (incf time-low seconds)
          (when (>= time-low (expt 2 16))
            (decf time-low (expt 2 16))
            (incf time-high))
          (when (< time-low 0)
            (incf time-low (expt 2 16))
            (decf time-high))
          (decode-long-time time-high time-low dt)
          (let* ((second (rref dt longDateRec.second))
                 (minute (rref dt longDateRec.minute))
                 (hour (rref dt longDateRec.hour))
                 (date (rref dt longDateRec.day))
                 (month (rref dt longDateRec.month))
                 (year (rref dt longDateRec.year))
                 (day (mod (%i- (rref dt longDateRec.dayofweek) 2) 7)))
            (values second minute hour date month year day nil 0)))))))

(defun %decoded-time-< (sec1 min1 hour1 date1 month1 year1 sec2 min2 hour2 date2 month2 year2)
  (declare (fixnum sec1 min1 hour1 date1 month1 year1 sec2 min2 hour2 date2 month2 year2))
  (or (< year1 year2)
      (and (= year1 year2)
           (or (< month1 month2)
               (and (= month1 month2)
                    (or (< date1 date2)
                        (and (= date1 date2)
                             (or (< hour1 hour2)
                                 (and (= hour1 hour2)
                                      (or (< min1 min2)
                                          (and (= min1 min2)
                                               (< sec1 sec2))))))))))))

(defun %decoded-time-<-universal-time-array (second minute hour date month year ut-array)
  (%decoded-time-< second minute hour date month year
                   (%svref ut-array 0)
                   (%svref ut-array 1)
                   (%svref ut-array 2)
                   (%svref ut-array 3)
                   (%svref ut-array 4)
                   (%svref ut-array 5)))

(defun universal-time-timer-task ()
  (when *universal-time-timer-qhead*
    (multiple-value-bind (second minute hour date month year) (get-decoded-universal-time)
      (declare (fixnum sec min hour date month year))
      (let (timer)
        (loop
          (unless (setq timer *universal-time-timer-qhead*)
            (return))
          (let ((ut-array (timer-universal-time timer)))
            (when (%decoded-time-<-universal-time-array second minute hour date month year ut-array)
              (return))
            (setf *universal-time-timer-qhead* (timer-link timer)
                  (timer-link timer) nil)
            ; Put the timer in the timer-state cell. This both marks it as running
            ; and protects it from GC until its process runs and clears the cell.
            (setf (car (timer-state timer)) timer)
            (process-unblock (timer-process timer))))))))

#+not-yet-implemented
(defloadvar *ticks-timer-task*
  (%install-periodic-task 'ticks-timer-task 'ticks-timer-task 1000))

(defloadvar *universal-time-timer-task*
  (%install-periodic-task 'universal-time-timer-task 'universal-time-timer-task 60))

(defparameter *timer-resolution* 6)
(defparameter *minimum-timer-resolution* 1)
(defparameter *timer-units* 60)

(defparameter *default-timer-entry-priority* 0)

(defmethod terminate ((timer timer))
  (let ((process (timer-process timer)))
    (when (typep process 'process)
      (setf (car (timer-state timer)) :kill)
      (process-kill process)
      (process-unblock process))))      ; let it run so it will die

(declaim (ftype (function (&rest t) t) terminate-when-unreachable))

(defun create-timer-call (function args &key 
                                   (name "timer")
                                   (priority *default-timer-entry-priority*))
  (let* ((timer (make-instance 'timer
                  :name name
                  :function function
                  :args args))
         (state-cell (timer-state timer)))
    (setf (car state-cell) :startup)
    (setf (timer-process timer)
          (process-run-function `(:name ,name :priority ,priority :restart-after-reset t)
                                #'(lambda (function args state-cell)
                                    (setq *interrupt-level* -1)
                                    (setf (car state-cell) nil)
                                    (loop
                                      (block continue
                                        (unwind-protect
                                          (do-timer-process function args state-cell)
                                          (unless (eq (car state-cell) :kill)
                                            (return-from continue))))))
                                function args (timer-state timer)))
    (when (fboundp 'terminate-when-unreachable)
      (terminate-when-unreachable timer))
    (process-wait "Timer startup" #'(lambda (state-cell) (null (car state-cell))) state-cell)
    timer))

; This is the code that runs in a timer process, called in a loop
(defun do-timer-process (function args state-cell)
  (unwind-protect
    (progn
      (process-block *current-process* "Timer")
      (setq *interrupt-level* 0)
      (apply function args))
    ; Cleanup
    (setq *interrupt-level* -1)
    (let ((timer (car state-cell)))
      (unless (eq timer :kill)
        (setf (car state-cell) nil)
        (when timer
          (let ((reset-while-running-p (timer-reset-while-running-p timer)))
            (when reset-while-running-p
              (setf (timer-reset-while-running-p timer) nil)
              (case reset-while-running-p
                (:pending-universal-time
                 (enqueue-timer-universal-time timer))
                #+not-yet-implemented
                (:pending-ticks
                 (enqueue-timer-ticks timer))
                (otherwise (error "~s = ~s"
                                  `(timer-reset-while-running-p ,timer)
                                  reset-while-running-p))))))))))

(defun remove-from-timer-queue (var timer)
  (without-interrupts
   (let ((last nil)
         (this (symbol-value var)))
     (loop
       (when (null this) (return nil))
       (when (eq this timer)
         (let ((next (timer-link timer)))
           (if last
             (setf (timer-link last) next)
             (setf (symbol-value var) next)))
         (setf (timer-link timer) nil)
         (return t))
       (setq last this
             this (timer-link this))))))

(defun clear-timer (timer)
  "Clears a timer, so that it does not go off."
  (without-interrupts
   (let* ((state (timer-state timer))
          (car-state (car state)))
     (case car-state
       (:pending-ticks
        (remove-from-timer-queue '*ticks-timer-qhead* timer))
       (:pending-universal-time
        (remove-from-timer-queue '*universal-time-timer-qhead* timer)))
     (unless (eq car-state timer)     ; running
       (setf (car state) nil)))))

(defun reset-timer-absolute (timer universal-time)
  "Resets timer to an absolute time, using universal-time."
  (clear-timer timer)
  (multiple-value-bind (second minute hour date month year) (decode-universal-time universal-time 0)
    (let ((time (timer-universal-time timer)))
      (setf (%svref time 0) second
            (%svref time 1) minute
            (%svref time 2) hour
            (%svref time 3) date
            (%svref time 4) month
            (%svref time 5) year))
    (%reset-timer-absolute timer second minute hour date month year))
  universal-time)

#|
(defun reset-timer-relative (timer seconds)
   "Resets TIMER to SECONDS from the time of invocation."
   (declare (fixnum seconds))
   (reset-timer-absolute timer (+ seconds (get-universal-time))))
|#

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))
;; this is in my sources but not in 4.3 release  - akh
#|
#+ppc-target
(defppclapfunction get-time-words ()
;(twnei nargs 0)
  (mflr loc-pc)
  (bla .spsavecontextvsp)
  ;(lwz nargs 331 rnil)
  ;(twgti nargs 0)
  (stwu sp -72 sp)
  (stw rzero 8 sp)
  ;(mr arg_z slep)
  (lwz arg_z '#.(get-shared-library-entry-point "LMGetTime") fn)
  (vpush arg_z)
  (lwz arg_z 0 vsp)
  (la vsp 4 vsp)
  (bla .spffcallslep)
  (rlwinm arg_z imm0 (+ 16 ppc::fixnum-shift) (- 16 ppc::fixnum-shift) (- 31 ppc::fixnum-shift))
  (vpush arg_z)  
  (rlwinm arg_z imm0 ppc::fixnum-shift (- 16 ppc::fixnum-shift) (- 31 ppc::fixnum-shift))
  (vpush arg_z)                     
  (set-nargs 2)
  (ba .spnvalret)
)
|#

#-ppc-target
(defun get-time-words ()
  (values (%get-word (%int-to-ptr $Time))(%get-word (%int-to-ptr $Time) 2)))

)

(defun reset-timer-relative (timer seconds)
  (declare (fixnum seconds))
  ;; like get-decoded-universal-time
  (rlet ((dt :longDateRec))
    (multiple-value-bind (time-zone dst) (get-time-zone)
      (declare (fixnum time-zone))
      (unless (eql dst 0) (decf time-zone 1))
      (multiple-value-bind (time-high time-low)(get-time-words)
        (let* ((seconds (+ seconds (* 3600 time-zone)))) ; <<
          (declare (fixnum time-low time-high seconds))
          (incf time-low seconds)
          (while (>= time-low (expt 2 16))
            (decf time-low (expt 2 16))
            (incf time-high))
          (when (< time-low 0)
            (incf time-low (expt 2 16))
            (decf time-high))
          (decode-long-time time-high time-low dt)    
          (let* ((second (rref dt longDateRec.second))
                 (minute (rref dt longDateRec.minute))
                 (hour (rref dt longDateRec.hour))
                 (date (rref dt longDateRec.day))
                 (month (rref dt longDateRec.month))
                 (year (rref dt longDateRec.year))
                 ;(day (mod (%i- (rref dt longDateRec.dayofweek) 2) 7))
                 (time (timer-universal-time timer)))
            ;; like innards of reset-timer-absolute
            (clear-timer timer)
            (setf (%svref time 0) second
                  (%svref time 1) minute
                  (%svref time 2) hour
                  (%svref time 3) date
                  (%svref time 4) month
                  (%svref time 5) year)
            (%reset-timer-absolute timer second minute hour date month year)))))))

; Called by the process when the timer is reset while running
(defun enqueue-timer-universal-time (timer)
  (let ((time (timer-universal-time timer)))
    (%reset-timer-absolute
     timer
     (%svref time 0)
     (%svref time 1)
     (%svref time 2)
     (%svref time 3)
     (%svref time 4)
     (%svref time 5))))

(defun %reset-timer-absolute (timer second minute hour date month year)
  (without-interrupts
   (let ((last nil)
         (next *universal-time-timer-qhead*)
         (state (timer-state timer)))
     (if (eq (car state) timer)
       (setf (timer-reset-while-running-p timer) :pending-universal-time)
       (progn
         (loop
           (unless next (return))
           (when (%decoded-time-<-universal-time-array
                  second minute hour date month year (timer-universal-time next))
             (return))
           (setq last next
                 next (timer-link next)))
         (if last
           (setf (timer-link last) timer)
           (setq *universal-time-timer-qhead* timer))
         (setf (timer-link timer) next)
         (setf (car (timer-state timer)) :pending-universal-time))))))

; end
