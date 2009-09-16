;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  5 4/8/97   akh  respell quanta
;;  3 4/1/97   akh  see below
;;  1 2/25/97  akh  new file
;;  (do not edit before this line!!)


(in-package :ccl)

;; new processes

;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; 04/14/00 slh   %process-wait-p: don't retry error; show condition for wait-function errors
;; 06/12/99 akh - fix from slh re: *active-processes* not as stable as we thought
;; 04/02/97 bill  The real 4.1d23 changes from Alice.
;; 03/29/97 akh   readjust-internal-priorities-and-check-timeouts - doesn't adjust if waitp set a new priority
;; 03/27/97 akh   use short floats, keep our runtime info in a private slot
;;                use that to compute new-process-utilization
;;                Change the interpretation of scheduler.spread (its old val/100s0)
;; 03/18/97 bill  Move *dont-sort-processes* outside of (let ((*warn-if-redefine* nil) ...) ...)
;;                to avoid compiler warnings.
;;

;; did do
;; 1) new-process-block and new-process-block-with-timeout that take wait-function and args, process is *current-process*
;; 2) process-wakeup, process-force-wakeup
;; 3) added a scheduler-policy structure
;; 4) added process.internal-priority which is used for ordering . It is increased for runnable processes that have
;;     been denied use of processor for a long time. It is decreased for processes with high utilization.
;;     Thus no runnable process is denied the processor forever because of a higher priority runnable process.
;;     How often a lower priority process will run is a function of the difference in priorities and the
;;     parameters in the scheduler policy.
;; 5) wait-function may return a new priority (minimal testing) - note that Symbolics periodically ran wait functions.
;;    and so do we every scheduler.wakeup    
;; 6) with-process-priority - much simpler than Symbolics version

;; didn't do:
;; 1) wakeup-without-test which somehow manages to wake up the process and get the test executed
;;   in the context of the call to process-block - lets assume that process-poll is sufficient
;; 2) background, deadline, preemptive priorities - priorities are still just numbers
;; 3) process-block-and-poll-with-mumble - kind of a cross between blocking and waiting
;;  that is it blocks but its wait function is tested periodically (less often than when process-wait) or something
;; 4) promotion protocol for locks.
;; 5) make-process should probably check priority for sanity (a number between min and max priority)

#|
new-scheduler.lisp

You can load this file into a running MCL image as long as *event-processor* is the highest
priority process and there are no blocked processes.

The new scheduler prevents a high priority runnable process from completely locking out a lower
priority runnable process. Wait functions can return a new priority (a number) as well as t or nil.
The new functions new-process-block and new-process-block-with-timeout take wait-function and
wait arguments. The process is always *current-process* as with process-wait and process-
wait-with-timeout. There are also new functions process-wakeup and process-force-wakeup
Process-wakeup tests the wait function and the timeout of a process and wakes it up
if the wait-function returns true or it has timed out. Process-force-wakeup wakes up
a process unconditionally. Processes that are blocked with timeout may also be unblocked
when the timeout expires without testing the wait function. 

The behavior of the new scheduler is controlled by *scheduler-policy* which is an
instance of a scheduler-policy structure.
(def-accessors (scheduler-policy) %svref
  nil
  scheduler.boost          ; if a process has waited for the processor for more than 1 second, its internal-priority is set to (+ priority (* boost wait-seconds)) 
  scheduler.spread
  scheduler.wakeup         ; interval (in ticks) between recomputation of internal priorities
  scheduler.last-wakeup
  scheduler.reset          ; interval (in ticks) between resets of runtimes
  scheduler.last-reset
  scheduler.max-utilization ; if process utilization (between 0 and 100) exceeds this, its internal-priority is reduced by (* spread util)
)

(defparameter *default-scheduler-boost* .1s0)
(defparameter *default-scheduler-spread* .001s0) ;.1s0)
(defparameter *default-scheduler-wakeup* 30)  ; its in ticks
(defparameter *default-scheduler-reset* 6000)
(defparameter  *default-scheduler-max-utilization* 50) ; between 0 and 100

The initial value of *scheduler-policy* is created with 
(make-scheduler-policy  (&key (boost *default-scheduler-boost*) 
                                   (spread *default-scheduler-spread*)
                                   (wakeup *default-scheduler-wakeup*)
                                   (reset *default-scheduler-reset*)
                                   (max-utilization *default-scheduler-max-utilization*)))

Processes have a new slot, process.internal-priority, for use only by the scheduler.
It is increased for runnable processes that have been denied use of processor for a long time. 
It is decreased for processes with high utilization. Thus no runnable process is denied the processor
forever because of a higher priority runnable process. How often a lower priority process will run
is a function of the difference in priorities and the parameters in the scheduler policy.

The scheduler adjusts the internal priorities of all active processes every scheduler.wakeup ticks.
Wait functions for waiting processes (as opposed to blocked processes) are tested by the scheduler
as it looks for a process to run in internal priority order. They are also tested for all processes
every scheduler.wakeup ticks when, if one returns a new priority, it will take effect.

The scheduler resets all internal process runtimes every scheduler.reset ticks.

Blocked process may be activated by process-wakeup, process-force-wakeup or when the timeout (if any)
expires.

(defvar *min-priority* 0)
(defvar *max-priority* 10)

These are currently not enforced by make-process though probably should be. They are enforced
in the computation of internal priorities.


NEW FUNCTIONS

new-process-block  (whostate function &rest args)
 blocks *current-process* setting process.wait-function to function and process.wait-argumemts to args
 and process.whostate to whostate. Process.whostate is restored when *current-process* is unblocked.
 Returns NIL if awakened by process-force-wakeup, otherwise the true value returned by
 (apply function args).

new-process-block-with-timeout (whostate time function &rest args)
 blocks *current-process* setting timeout, wait function, wait arguments and whostate.
 Function can be nil. Returns NIL if timed out or awakened by process-force-wakeup,
 otherwise the true value returned by (apply function args).

process-wakeup (process)
 Tests wait-function and timeout of process. Wakes up process if either wait function returns true
 or timeout has expired.  Returns true if process woke up. 

process-force-wakeup (process)
 Wakes up process unconditionally. Returns true to caller of process-force-wakeup. The
call to new-process-block (or process-block, etc.) will return NIL. 

NEW MACROS

with-process-priority (new-priority &rest body)
 Executes body with the priority of *current-process* being new-priority. The internal priority may be
 adjusted during execution.

|# 



;; from lispequ - include this always 

#|
(def-accessors (process) %svref
  nil                                   ; 'process
  process.name
  process.stack-group
  process.initial-stack-group
  process.initial-form
  process.wait-function
  process.wait-argument-list
  process.run-reasons
  process.arrest-reasons
  process.priority
  process.quantum                       ; ticks remaining
  process.warm-boot-action              ; ???
  process.whostate
  process.nexttick                      ; n - when quantum expires
  process.splice                        ; a cons cell
  process.background-p
  process.creation-time                 ; reset to now by clear-process-run-time
  process.last-run-time			; tick count when last ran
  process.total-run-time		; reset to 0 by clear-process-run-time
  process.internal-priority            ; new
  process.timeout                      ; new for  blocked processes
  process.wait-finished                ; when a process-wait starts this is set to nil, when a wait function
                                       ; returns true and this value is nil this is set to (get-tick-count)
)
|#

(export '(*min-priority* *max-priority* make-scheduler-policy *scheduler-policy*
          *default-scheduler-boost* *default-scheduler-spread*
          *default-scheduler-wakeup* *default-scheduler-reset* 
          *default-scheduler-max-utilization*
          new-process-block new-process-block-with-timeout
          with-process-priority
          process-wakeup process-force-wakeup)
        (find-package :ccl))
;(defvar *new-processes*)

(setq *new-processes* nil)

(defvar *min-priority* 0)
(defvar *max-priority* 10)

(def-accessors (scheduler-policy) %svref
  nil
  scheduler.boost          ; if a process has waited for the processor for more than 1 second, its internal-priority is set to (+ priority (* boost wait-seconds)) 
  scheduler.spread
  scheduler.wakeup         ; interval (in ticks) between recomputation of internal priorities
  scheduler.last-wakeup
  scheduler.reset          ; interval (in ticks) between resets of runtimes
  scheduler.last-reset
  scheduler.max-utilization ; if process utilization (between 0 and 100) exceeds this, its internal-priority is reduced by (* spread util)
)

(defparameter *default-scheduler-boost* .1s0)
(defparameter *default-scheduler-spread* .001s0) ;.1s0)
(defparameter *default-scheduler-wakeup* 30)  ; its in ticks
(defparameter *default-scheduler-reset* 6000)
(defparameter  *default-scheduler-max-utilization* 50) ; between 0 and 100

 
(defun make-scheduler-policy  (&key (boost *default-scheduler-boost*) 
                                   (spread *default-scheduler-spread*)
                                   (wakeup *default-scheduler-wakeup*)
                                   (reset *default-scheduler-reset*)
                                   (max-utilization *default-scheduler-max-utilization*))
  (%istruct 'scheduler-policy
            boost
            spread
            wakeup
            0
            reset
            0
            max-utilization))


(defparameter *scheduler-policy* (make-scheduler-policy))

;; its a bad idea to do this in a wait function.
(defmacro with-process-priority (new-priority &rest body)
  (let* ((pvar (gensym))
         (cvar (gensym))
         (ipvar (gensym)))
    `(let* ((,cvar *current-process*)
            (,pvar (process.priority ,cvar))
            (,ipvar (process.internal-priority ,cvar)))
       (unwind-protect
         (progn
           (setf (process.priority ,cvar) ,new-priority
                 (process.internal-priority ,cvar) nil)
           (sort-active-processes)
           ,@body)
         (setf (process.priority ,cvar) ,pvar
               (process.internal-priority ,cvar) ,ipvar)
         (sort-active-processes)))))
         
         

;; in symbolics land an active process can be runnable or blocked
;; With old scheduler blocked processes (without timeout) are NOT on the active queue or blocked list but 
;; blocked processes with timeout are on the active queue and the blocked list.
;; With *new-processes* blocked processes are on blocked list however blocked and are not on active list

(defvar *dont-sort-processes* nil)

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))

(defun new-process-block (whostate function &rest args)
  (declare (dynamic-extent args))
  (let* ((p *current-process*)
         (old-whostate (process.whostate p)))
    (when function (require-type function 'function))
    (or (and function (apply function args))  ; use %process-wait-p here too for recursive wait/block and new priority?
        (unwind-protect
          (progn 
            (without-interrupts
             ;(when timeout (setq timeout (%tick-sum (get-tick-count) timeout))) 
             (deactivate-process p)  ; remove from *active-processes*
             (setf (process.whostate p) whostate)
             (push p  *blocked-processes*)
             (setf ;(process.timeout p) timeout
                   (process.wait-function p) function
                   (process.wait-argument-list p) args)
             (setf (process.wait-finished p) nil))
            (scheduler))
          ; some of this  is unnecessary - its done in forget-process-blocked
          (setf (process.wait-function p) nil
                (process.wait-argument-list p) nil
                (process.wait-finished p) (get-tick-count)
                (process.timeout p) nil
                (process.whostate p) old-whostate)))))


; like symbolics process:block-with-timeout (arg order differs)
; how does this differ from wait-with-timeout? pg 33 
; it wakes up when someone does an explicit wakeup and verify function rets true OR it times out with or without wakeup  

(defun new-process-block-with-timeout (whostate time function &rest args)
  (declare (dynamic-extent args))
  (cond ((null time)  (apply #'new-process-block whostate function args) t)
        (t (let* ((win nil)
                  (when (%tick-sum (get-tick-count) time))
                  (f #'(lambda () (let ((val (when function (apply function args)))) ; or win (i.e. it returned true once)
                                    (if val
                                      (setq win val)
                                      (> (%tick-difference (get-tick-count) when) 0))))))
             (declare (dynamic-extent f))
             (setf (process.timeout *current-process*) when) ; does this redundancy make sense? presumably the wait function should only be called by process-wakeup
             (new-process-block whostate f)
             win))))

; redefinition
(defun process-block (process whostate)
  (if (eq process *current-process*)
    (new-process-block whostate nil)
    (process-block-with-timeout process nil whostate)))

; redefinition
(defun process-block-with-timeout (process timeout whostate)
  (if (eq process *current-process*)
    (new-process-block-with-timeout whostate timeout nil)
    (progn
      (when (memq process *blocked-processes*)
        (error "Process ~s is already blocked." process))
      (without-interrupts
       (when timeout (setq timeout (%tick-sum (get-tick-count) timeout)))
       (deactivate-process (require-type process 'process))  ; remove from *active-processes*
       (setf (process.whostate process) whostate)
       (push process  *blocked-processes*)
       (setf (process.timeout process) timeout
             (process.wait-function process) nil
             (process.wait-finished process) nil
             (process.wait-argument-list process) nil)))))

; redefinition
(defun process-unblock (process)
  (when (not (memq process *blocked-processes*))
    (error "Process ~s is not blocked." process))
  (forget-process-blocked process)
  t)
  
; redefinition - don't cons needlessly
(defun process-total-run-time (p)
  (let ((total (process.total-run-time (require-type p 'process))))
    (declare (type cons total))
    (if (eq 0 (car total)) 
      (cdr total)
      (+ (* (car total) (+ most-positive-fixnum most-positive-fixnum 2))
         (cdr total)))))


; redefinition
; this is called by scheduler - the old way processes blocked-with-timeout were on active-processes
; now they aren't so this will never be called for a blocked process. So could as well just return nil.
(defun %process-blocked-p (process)
  "If process is not blocked, returns nil; if blocked with timeout and has timed out returns nil; else returns true."
  (let ()    
    (and (memq process *blocked-processes*)
         (let ((timeout (process.timeout process)))
           (if (null timeout)
             t
             (cond ((%i< (get-tick-count) timeout) t)
                   (t (setq *blocked-processes* (delq process *blocked-processes*))
                      (setf (process.whostate process) "Unblocked")
                      nil)))))))

; this is just a predicate - unused
(defun %new-process-blocked-p (process)
  "If process is not blocked, returns nil; if blocked with timeout and has timed out returns (values nil t); else returns true."
  (let ()    
    (and (memq process *blocked-processes*)
         (let ((timeout (process.timeout process)))
           (if (null timeout)
             t
             (cond ((%i< (get-tick-count) timeout) t)
                   (t (values nil t))))))))

;; this only makes sense for processes blocked-with-timeout
(defun process-timed-out-p (process)
  (let ((timeout (process.timeout process)))
    (and timeout (%i>= (get-tick-count) timeout))))

; symbolics process:wakeup - does test verify function
(defun process-wakeup (process)
  (let ((fn (process.wait-function process)))   ; beware - it can be :polled or :polling too      
    (when (or (process-timed-out-p process)
            (if fn
              (%process-wait-p process)
              ; if had no wait fn or timeout just do it
              (not (process.timeout process))))
      (forget-process-blocked process)
      ; return t if wokeup for whatever reason
      t)))

; doesnt test wait-function symbolics process:force-wakeup
(defun process-force-wakeup (process)
  (forget-process-blocked process)
  t)

;; we assume one might reasonably do process-wakeup on a process that wasn't blocked but only waiting.
(defun forget-process-blocked (process)
  (without-interrupts    
    (when (memq process *blocked-processes*)
      (setf (process.whostate process) "Unblocked")
      (setq *blocked-processes* (delq process *blocked-processes*)))
    (setf (process.wait-function process) nil
          (process.wait-argument-list process) nil)
    (setf (process.timeout process) nil)
    (setf (process.wait-finished process)(get-tick-count))
    (setf (process.internal-priority process) (process.priority process))
    (ensure-process-active process)  ; back on *active-processes*
    ))

;; grovels recomputing priorities - and checks for timeouts of blocked-processes
;; N.B. this is all pointless when there is only one runnable  process

;;  who should deal with processes blocked with timeout ? - maybe the old way was good enuf?

#|
(defun record-runnable-processes (vect)  
  (do* ((i 0 (1+ i))
        (ls  *active-processes* (cdr ls))
        (nrun 0))
       ((null ls) nrun)
    (declare (fixnum i nrun))
    (let ((p (car ls)))
      (when (not (process.internal-priority p))
        (setf (process.internal-priority p)(process.priority p)))
      (let ((runnable (process-runnable-p p)))
        (setf (uvref vect i) runnable)
        (when runnable (incf nrun))))))
|#

(defun record-runnable-processes (vect processes)  
  (do* ((i 0 (1+ i))
        (ls processes (cdr ls))
        (nrun 0))
       ((null ls) nrun)
    (declare (fixnum i nrun))
    (let ((p (car ls)))
      (when (not (process.internal-priority p))
        (setf (process.internal-priority p) (process.priority p)))
      (let ((runnable (process-runnable-p p)))
        (setf (uvref vect i) runnable)
        (when runnable (incf nrun))))))

#|
(defun sum-equal-priority-quanta (priority vect)
  (do* ((i 0 (1+ i))
        (ls  *active-processes* (cdr ls))
        (sum 0))
       ((null ls) sum)
    (declare (fixnum i sum))
    (let ((p (car ls)))
      (when (uvref vect i)
        (when (= (process.internal-priority p) priority)
          (setq sum (+ sum (process.quantum p))))))))
|#

(defun sum-equal-priority-quanta (priority vect processes)
  (do* ((i 0 (1+ i))
        (ls processes (cdr ls))
        (sum 0))
       ((null ls) sum)
    (declare (fixnum i sum))
    (let ((p (car ls)))
      (when (uvref vect i)
        (when (= (process.internal-priority p) priority)
          (setq sum (+ sum (process.quantum p))))))))
    

#|
(defun readjust-internal-priorities-and-check-timeouts (policy)
  (let* ((changed nil)
         (*dont-sort-processes* t)  ; ugh
         (nrunnable 0)
         (runnable-vector (make-array (length *active-processes*))))
    (declare (dynamic-extent runnable-vector))
    (setq nrunnable (record-runnable-processes runnable-vector)) ; grovel once
    ;(if (eq nrunnable 0)(incf zip)(if (eq nrunnable 1)(incf one)(incf more)))
    (when (> nrunnable 1)
      (do* ((i 0 (1+ i))
            (ls  *active-processes* (cdr ls))) ; grovel twice
           ((null ls))
        (declare (fixnum i))
        (let* ((p (car ls))
               (wait-val (uvref runnable-vector i)))
          (when wait-val            
            (if (memq wait-val '( :reordered-less :reordered-greater)) 
              (setq changed t) ; ugh
              (let* ((idle (process-idle-time p))
                     (old-priority (process.internal-priority p)))
                (if (and (> idle 60)
                         (> idle (sum-equal-priority-quanta old-priority runnable-vector))) ;grovel thrice
                  (progn 
                    ; boost processes that have been idle for a long time
                    ; Seems screwy. If there are 10+ compute bound processes of = priority it will take
                    ; more than a second to round-robin them all, but that's really the best
                    ; one can do. It doesn't help anything to boost the "last" ones.
                    ; So we only boost if idle longer than it would take to do them all.
                    (setq idle (truncate idle 60))
                    ; each second of idleness adds one boost unit to priority
                    (let ((new-priority (min *max-priority* (+ (process.priority p)(* (scheduler.boost policy) idle)))))
                      (when (not (= new-priority old-priority))
                        ;(push (list 'boosting p new-priority old-priority) thing)
                        (setf (process.internal-priority p) new-priority)
                        (setq changed t))))
                  (progn
                    ; demote processes with high utilization - why both??
                    (let ((util ;(process-utilization p)))  ; its between 0 and 100
                           (new-process-utilization p)))
                      (if (> util (scheduler.max-utilization policy))  ;  could both of these happen to one process?
                        
                        (let ((new-priority (max *min-priority* (- (min old-priority (process.priority p))
                                                                   (* (scheduler.spread policy) util)))))
                          (when (not (= new-priority old-priority))
                            ;(push (list 'demoting p new-priority old-priority) thing)
                            (setf (process.internal-priority p) new-priority)                
                            (setq changed t)))
                        ; no longer any reason for promotion or demotion so revert to original priority
                        (when (/= old-priority (process.priority p))
                          ;(push (list 'reverting p) thing)
                          (setf (process.internal-priority p)(process.priority p))
                          (setq changed t))))))))))))
    (when changed      
      (sort-active-processes))
    ; used to check timeouts for blocked-with-timeout much more often - does anyone care?
    (dolist (p *blocked-processes*)
      (when (process-timed-out-p p)
        (forget-process-blocked p)))        
    (setf (scheduler.last-wakeup policy)(get-tick-count))
    ))
|#

(defun readjust-internal-priorities-and-check-timeouts (policy &rest processes)
  (declare (dynamic-extent processes))
  (let* ((changed nil)
         (*dont-sort-processes* t)  ; ugh
         (nrunnable 0)
         (runnable-vector (make-array (length processes))))
    (declare (dynamic-extent runnable-vector))
    (setq nrunnable (record-runnable-processes runnable-vector processes)) ; grovel once
    ;(if (eq nrunnable 0)(incf zip)(if (eq nrunnable 1)(incf one)(incf more)))
    (when (> nrunnable 1)
      (do* ((i 0 (1+ i))
            (ls processes (cdr ls))) ; grovel twice
           ((null ls))
        (declare (fixnum i))
        (let* ((p (car ls))
               (wait-val (uvref runnable-vector i)))
          (when wait-val            
            (if (memq wait-val '( :reordered-less :reordered-greater)) 
              (setq changed t) ; ugh
              (let* ((idle (process-idle-time p))
                     (old-priority (process.internal-priority p)))
                (if (and (> idle 60)
                         (> idle (sum-equal-priority-quanta old-priority runnable-vector processes))) ;grovel thrice
                  (progn 
                    ; boost processes that have been idle for a long time
                    ; Seems screwy. If there are 10+ compute bound processes of = priority it will take
                    ; more than a second to round-robin them all, but that's really the best
                    ; one can do. It doesn't help anything to boost the "last" ones.
                    ; So we only boost if idle longer than it would take to do them all.
                    (setq idle (truncate idle 60))
                    ; each second of idleness adds one boost unit to priority
                    (let ((new-priority (min *max-priority* (+ (process.priority p)(* (scheduler.boost policy) idle)))))
                      (when (not (= new-priority old-priority))
                        ;(push (list 'boosting p new-priority old-priority) thing)
                        (setf (process.internal-priority p) new-priority)
                        (setq changed t))))
                  (progn
                    ; demote processes with high utilization - why both??
                    (let ((util ;(process-utilization p)))  ; its between 0 and 100
                           (new-process-utilization p)))
                      (if (> util (scheduler.max-utilization policy))  ;  could both of these happen to one process?
                        
                        (let ((new-priority (max *min-priority* (- (min old-priority (process.priority p))
                                                                   (* (scheduler.spread policy) util)))))
                          (when (not (= new-priority old-priority))
                            ;(push (list 'demoting p new-priority old-priority) thing)
                            (setf (process.internal-priority p) new-priority)                
                            (setq changed t)))
                        ; no longer any reason for promotion or demotion so revert to original priority
                        (when (/= old-priority (process.priority p))
                          ;(push (list 'reverting p) thing)
                          (setf (process.internal-priority p)(process.priority p))
                          (setq changed t))))))))))))
    (when changed      
      (sort-active-processes))
    ; used to check timeouts for blocked-with-timeout much more often - does anyone care?
    (dolist (p *blocked-processes*)
      (when (process-timed-out-p p)
        (forget-process-blocked p)))        
    (setf (scheduler.last-wakeup policy)(get-tick-count))
    ))

(defun process-current-priority (p)
  (or (process.internal-priority p)(process.priority p)))

(defun sort-active-processes ()
  ; this should probably worry about *active-processes-tail* too.
  (without-interrupts
   (let ((tail-car (car *active-processes-tail*)))
     (setq *active-processes* (sort *active-processes* #'> :key #'process-current-priority ))
     (setq *active-processes-tail* (memq tail-car *active-processes*)) ; ??
     (do* ((l *active-processes* (cdr l)))
          ((null l))
       (setf (process.splice (car l)) l)))))

(defun process-runnable-p (P)
  (and (not *in-process-wait-function*)  ; could this ever happen? probably not
       (process-active-p p)
       (%process-wait-p p)))    
#|
; redefinition  
(defun scheduler ()
  (let-globally ((*in-scheduler* t))
    (if (null *current-process*)
      #+ppc-target(bug "*current-process* is nil in scheduler")
      #-ppc-target (dbg))
    ; give first preference to the guy who is processing events or who doesnt
    ; want event processing to happen quite yet.
    (when *new-processes*
      (let* ((now (get-tick-count))
             (policy *scheduler-policy*))
        (if (%i> now (%i+ (scheduler.last-reset policy) (scheduler.reset policy)))
          (reset-scheduler-times policy)
          (when (%i> now (%i+ (scheduler.last-wakeup policy) (scheduler.wakeup policy)))
            (readjust-internal-priorities-and-check-timeouts policy)))))
    (let ((pe *processing-events*))
      (when (and pe 
                 (neq pe t)
                 ;(not (%process-blocked-p pe))
                 (%process-wait-p pe))
        (return-from scheduler (%activate-process pe)))
      (loop
        (tagbody 
          top
          (let ((active-processes-tail *active-processes-tail*)
                (wait-val))
            (if active-processes-tail
              (setq *active-processes-tail* nil)
              (setq active-processes-tail *active-processes*))
            (dolist (p active-processes-tail)
              (progn ; unless (%process-blocked-p p)  
                (when (setq wait-val (%process-wait-p p))
                  (when (eq wait-val :reordered-less) ; if priority changed and became less
                    (go top))
                  (return-from scheduler (%activate-process p)))))))
        ; Nobody ready to run, must be idle so poll for events
        (clear-process-polling)
        (event-poll)))))
|#

; patch: pass *active-processes* to readjust-internal-priorities-and-check-timeouts
(defun scheduler ()
  (let-globally ((*in-scheduler* t))
    (if (null *current-process*)
      #+ppc-target (bug "*current-process* is nil in scheduler")
      #-ppc-target (dbg))
    ; give first preference to the guy who is processing events or who doesnt
    ; want event processing to happen quite yet.
    (when *new-processes*
      (let* ((now (get-tick-count))
             (policy *scheduler-policy*))
        (if (%i> now (%i+ (scheduler.last-reset policy) (scheduler.reset policy)))
          (reset-scheduler-times policy)
          (when (%i> now (%i+ (scheduler.last-wakeup policy) (scheduler.wakeup policy)))
            (apply #'readjust-internal-priorities-and-check-timeouts policy *active-processes*)))))
    (let ((pe *processing-events*))
      (when (and pe 
                 (neq pe t)
                 ;(not (%process-blocked-p pe))
                 (%process-wait-p pe))
        (return-from scheduler (%activate-process pe)))
      (loop
        (tagbody 
          top
          (let ((active-processes-tail *active-processes-tail*)
                (wait-val))
            (if active-processes-tail
              (setq *active-processes-tail* nil)
              (setq active-processes-tail *active-processes*))
            (dolist (p active-processes-tail)
              (progn ; unless (%process-blocked-p p)  
                (when (setq wait-val (%process-wait-p p))
                  (when (eq wait-val :reordered-less) ; if priority changed and became less
                    (go top))
                  (return-from scheduler (%activate-process p)))))))
        ; Nobody ready to run, must be idle so poll for events
        (clear-process-polling)
        (event-poll)))))

(defun reset-scheduler-times (policy)
  (let ((changed))
    (dolist (p *active-processes*)
      (set-runtime-info p)
      ;(clear-process-run-time p)
      (when nil
        (Let ((priority (process.priority p)))
          (when(not (= priority (process.internal-priority p)))
            (setf (process.internal-priority p) priority)
            (setq changed t)))))
    (when changed (sort-active-processes))
    (setf (scheduler.last-reset policy)(get-tick-count))))



; a list of 2 samples of tick-count and total-run-time
(defun runtime-info (process)
  (let ((run-times (process.run-times process)))
    (if (not (consp run-times))
      (progn
        (setf (process.run-times process)
              (list (cons (get-tick-count) (process-total-run-time process))
                    (cons (process.creation-time process) 0)))
        (runtime-info process))
      run-times)))

;; car is tick-count, cdr is runtime
;; utilzation uses second entry so it has some history
(defun set-runtime-info (process)
  (let ((info (runtime-info process))
        (now (get-tick-count))
        (now-runtime (process-total-run-time process)))
    (if (not (consp info))
      (setf (process.run-times process)
            (list (cons now now-runtime)
                  (cons (process.creation-time process) 0)))      
      (let* ((second (cadr info))
             (first (car info)))
        (setf (car second) (car first))
        (setf (cdr second) (cdr first))
        (setf (car first) now)
        (setf (cdr first) now-runtime)))))

(defun new-process-utilization (process)
 (when (not (consp (runtime-info process))) (set-runtime-info process))
 (let* ((info (runtime-info process))
        (old-stuff (cadr info))
        (old-run-time (cdr old-stuff))
        (ticks (- (get-tick-count)(car old-stuff))))
   (values (truncate (* 100 (- (process-total-run-time process) old-run-time))
                     (if (eql ticks 0) 1 ticks)))))
    
(defun process-utilization (process)
  (let ((ticks (- (get-tick-count)(process-creation-time process))))
    (truncate (* 100 (process-total-run-time process)) (if (eql ticks 0) 1 ticks))))

(defun process-idle-time (process)
  (let* ((ticks (get-tick-count))
         (wait-finished (process.wait-finished process)))
    (let ((res 
           (if (and (process.wait-function process)(not wait-finished)) ; still waiting - not in pain      
             0
             (if wait-finished      
               (- ticks (max (process.last-run-time process) wait-finished))
               (- ticks (process.last-run-time process))))))
      res)))

; redefinition
(defun %process-wait-p (process &optional 
                                (wf (process.wait-function process))
                                (args (process.wait-argument-list process)))
  (cond ((null wf) 
         (clear-process-polling)
         t)
        ((eq wf :polling) t)
        ((eq wf :polled) nil)
        (t (catch '%process-wait-p
             (let* ((*in-process-wait-function* process)
                    (old-debugger-hook *debugger-hook*)
                    (*debugger-hook* #'(lambda (condition hook)
                                         (declare (ignore hook))
                                         (if (eq process *current-process*)
                                           (let ((*in-process-wait-function* nil))
                                             (if old-debugger-hook
                                               (funcall old-debugger-hook condition old-debugger-hook)
                                               (error condition)))
                                           (process-interrupt process
                                                              #'(lambda (condition)
                                                                  (error "Error inside process-wait function: ~A" condition))
                                                              condition))
                                         (throw '%process-wait-p nil))))
               (declare (dynamic-extent *debugger-hook*))
               (let ((wait-val (apply wf args)))
                 (when wait-val
                   (when *new-processes* 
                     (when (not (process.wait-finished process))
                       (setf (process.wait-finished process)(get-tick-count)))
                     (when (numberp wait-val)
                       (when (or (not (= wait-val (process.priority process)))
                                 (and (process.internal-priority process)
                                       (not (= wait-val (process.internal-priority process)))))
                         (let ((lessp (< wait-val (or (process.internal-priority process)(process.priority process)))))
                           (setf (process.priority process) wait-val
                                 (process.internal-priority process) wait-val)
                           ; scheduler doesn't care if its priority went higher cause its about to run now
                           ; if went lower scheduler starts over
                           (setq wait-val (if lessp :reordered-less :reordered-greater))
                           (unless *dont-sort-processes* 
                             (sort-active-processes)  ; ?? seems to be about the same time either way.
                             #| ; or 
                             (deactivate-process process)
                             (ensure-process-active process)|#
                             ))))) ; <<
                   (clear-process-polling)
                   wait-val)))))))
) ; end let


; event processor better be the current highest priority process.

(setf (process.priority *event-processor*) *max-priority* 
      (process.internal-priority *event-processor*) *max-priority*)

(setq *new-processes* t)

#|
(process-run-function '(:name "foo2" :priority 5)
                        #'(lambda () (loop (dotimes (i 100000)(setq *xx* (cons 1 2))) (sleep .1))))

  (let ((i 0))
    (loop
      (print (incf i))
      (sleep 1)))

|#