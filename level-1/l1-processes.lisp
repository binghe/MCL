;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  5 4/1/97   akh  see below
;;  3 2/25/97  akh  mods for compatibility with new scheduler
;;  2 2/13/97  akh  #+ppc-target call to bug
;;  27 1/22/97 akh  make-process has args for vstack and tstack size (ignored for 68K)
;;  23 9/26/96 akh  without-interrupts around whole cond vs clauses
;;  20 4/24/96 akh  bill's fix for process-interrupt
;;  10 11/19/95 gb  phony %stack-group-exhausted-p
;;  8 11/15/95 gb   enable simple case of process-interrupt for PPC.
;;  4 10/26/95 Alice Hartley %istruct/make-uvector stuff
;;  2 10/17/95 akh  merge patches - or maybe no change
;;  12 3/20/95 akh  no change
;;  8 2/21/95  slh  removed naughty word (file is public now)
;;  7 2/17/95  akh  probably no change
;;  6 2/6/95   akh  process-active-p was mis parenthesized
;;  3 1/17/95  akh  scheduler gives first preference to process *processing-events* (if not t or nil)
;;                  Extreme prejudice has cancel option
;;  (do not edit before this line!!)

;; L1-processes.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

;; Modification History
;
; %activate-process - fix the hi part of total-run-time
; most of %activate-process is without-interrupts, error msg in %process-reset more informative
; --------- 5.1final
; 09/29/04 define and use variable *event-processor-priority*
; ---------- 5.2b3
; 04/16/04 fix deactivate-process re *active-processes-tail*
;--------- 5.1b1
; 06/14/00 slh   %process-wait-p: show the condition in the error hook
; 07/18/00 akh   suspend-current-process - don't if *no-scheduling* is true.
;; -------- 4.3f1c1
; 10/22/98 akh   make-lock takes a type arg and makes a bigger frob for cl-http
; 07/20/98 akh   process-wait-with-timeout checks that if time it is a fixnum
; 01/28/98 akh   %process-wait-p - dont mess with possible stack-consed function in debugger hook
; 04/11/97 bill  slh's Slight speed up for process-reset's kill option error checking
;                when it is :shutdown.
; -------------  4.1b1
; 03/27/97 akh   make-process adds another slot
; 02/04/97 bill  run-process-initial-function and %process-run-function re-run the
;                function if the thrown "kill" value is :toplevel.
;                This supports the toplevel function.
; 02/21/97 akh   deactivate-process heeds *active-processes-tail*, ensure-process-active is woi, additions for *new-processes*
; 11/21/96 bill  from gb: make process-wait save/restore process.whostate.
; 11/11/96 bill  make-lock takes an optional name argument. Its print-object method prints it.
;                lock-name returns it.
; 10/29/96 bill  New functions: process-poll & process-poll-with-timeout.
;                New variables: *process-polling-p*, *always-process-poll-p*, *active-processes-tail*.
;                Modify scheduler & %process-wait-p to accomodate.
; -------------  4.0
; 10/04/96 bill  in get-tick-count, #$ticks -> #.#$ticks.
;                Otherwise, inlining it in code in other files fails.
; 10/01/96 bill  %process-wait-p sets up a context so that errors in process-wait functions
;                or calls to process-wait will signal an error in the offending process
;                instead of crashing badly. Call it from scheduler instead of funcalling
;                the process-wait function in-line.
; -------------  MCL 4.0b2
;  7/31/96 slh   %process-preset-internal: ensure process is on *all-processes*
; 06/26/96 bill  process-maximum-stack-size, (setf process-maximum-stack-size)
; -------------  MCL-PPC 3.9
; 04/02/96 bill  maybe-process-run-function
; 03/28/96 bill  store-conditional
; 03/26/96  gb   lowmem accessors.
; 02/07/96 bill  maybe-finish-process-kill calls kill-stack-group if necessary
;                and if its not the *current-stack-group*.
; 02/05/96 bill  *using-stack-groups* becomes true again.
; 12/30/96 bill  PPC version of process-interrupt
; 12/13/95 bill  No fancy process.stack-group switching unless *using-stack-groups* is true
;                (I've been getting process-related hangs & "Wrong process" errors recently).
; 12/06/95 bill  PPC versions of *current-stack-group*, %stack-group-exhausted-p,
;                symbol-value-in-stack-group move from here to ppc-stack-groups
; 12/01/95 bill  %activate-process handles a stack group dying correctly,
;                and it doesn't bother to do anything if the process being
;                activated is already current.
;                %process-preset-internal sets the current stack group to the initial stack group.
;                process-initial-form-exited binds *in-scheduler* true when calling %activate-process.
; 11/15/95 bill  %activate-process & process-reset now work correctly if the
;                process explicitly switches to another stack group.
; 11/15/95 gb    process-interrupt *current-process* on PPC.
; 10/26/95 slh   %gvector -> %istruct, %lock
; 10/20/95 slh   dumb de-lap: ignore most of file for PPC
;  6/06/95 slh   Bill's fix to process-initial-form-exited, process-allow-schedule
;  6/05/95 slh   Bill's mods to %activate-process, process-initial-form-exited
;  6/01/95 slh   Bill's fix to Bill's fix to Bill's fix
;  5/31/95 slh   Bill's fix to Bill's fix
;  5/30/95 slh   Bill's fix to %process-preset-internal
;  5/15/95 slh   process-abort, process-reset-and-enable
;  4/20/95 slh   ensure-process-active: typo splicr -> splice (in declare)
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
; 3/09/95 slh    process-enable: set whostate, just once
;                various block/run/arrest changes
; 3/07/95 slh    process-disable: set whostate
;                added process-enable-run-reason, process-disable-run-reason
; 2/06/95 akh    process-active-p was mis parenthesized
;-------------   3.0d17
; 1/27/95 slh    *dflt-process-stackseg-size* (= $default-stackseg-size)
;                process-block-with-timeout
; 1/25/95 slh    added baby process-block/unblock functions
;-------------   3.0d16
;07/13/93 bill   "lock" -> "Lock"
;07/09/93 bill   make-process & process-run-function: stack-size default -> 16384
;--------------  3.0d11
;06/15/93 alice  lock-value => lock-owner
;06/02/93 bill   %cons-lock renamed to make-lock. lock-value.
;-------------   3.0d8
;04/29/93 bill   all-processes & friends -> *all-processes* & friends
;04/28/93 bill   Fix up whostate a little.
;                (#_TickCount) -> (get-tick-count) except in process.creation-time
;                Keep track of process.last-run-time & process.total-run-time in %activate-process
;04/27/93 bill   process-run-function returns the process instead of NIL.
;04/24/93 bill   one-timers created with process-run-function do not ever
;                appear on *shutdown-processes*
;04/22/93 bill   *shutdown-processes*
;04/21/93 bill   process-background-p
;04/14/93 bill   remove *killed* (there for debugging only).
;                startup code (def-ccl-pointers processes ...) calls %process-preset-internal
;                which was extracted from process-preset.
;-------------   2.1d4, 2.1d5
;03/24/93 bill   process-enqueue-with-timeout, symbol-value-in-process.
;                Remove consing from process-interrupt and make it preserve process.whostate
; 03/18/93 bill  with-standard-abort-handling in run-process-initial-form and
;                %process-run-function
; 03/17/93 bill  initial-initial-process
; 02/17/93 bill  stack-size keyword to make-process & process-run-function
; 02/02/93 bill  process-allow-schedule
; 01/28/93 bill  funcall-in-top-listener-process now takes args just like process-interrupt
; 01/17/93 bill  def-ccl-pointers processes presets the processes.
;                %activate-process no longer operates without-interrupts.
;                This allows the "Break" menu command to work.
; 01/11/93 bill  process-enqueue & friends
; 01/08/93 bill  be a little more paranoid about without-interrupts in process-lock.
;                process-unlock
; 12/24/92 bill  %activate-process & ensure-process-active handle
;                exhausted stack groups without causing repeating errors
; 11/20/92  gb   new file
; --------  2.0

(cl:in-package "CCL")

(defglobal *all-processes* ())


(defglobal *default-process-stackseg-size* $default-stackseg-size)


(defvar *default-quantum* 6)              ; Ticks before rescheduling

(defglobal *shutdown-processes* nil)

(defvar *process-polling-p* nil)

(defvar *always-process-poll-p* nil)

(defvar *active-processes-tail* nil)

(declaim (type t
               *always-process-poll-p*
               *process-polling-p*
               *active-processes-tail*))

(defvar *new-processes*)

(setq *new-processes* nil)

(declaim (inline get-tick-count))
#-ppc-target
(defun get-tick-count ()
  (%get-fixnum (%int-to-ptr #.#$Ticks)))  ;;; SCREW: use lowmem accessor

#+ppc-target
(progn

;; lots easier than a bunch of compiler changes and other hoo hah to get the fixnum portion of tick-count
;; but it won't inline

  #-use-cfm  ;; this feature isn't defined anywhere - bye bye OS9
  (defppclapfunction get-tick-count ()
    (check-nargs 0)
    (mflr loc-pc)
    (bla .spsavecontextvsp)
    (stwu sp #.(- (+ ppc::c-frame.minsize ppc::lisp-frame.size )) sp)
    (stw rzero 8 sp)
    (LWZ ARG_Z '#.(get-macho-entry-point "TickCount") fn)
    (SET-NARGS 1)
    (LWZ TEMP3 'MACHO-ADDRESS FN)
    (BLA .SPJMPSYM)
    ;(VPUSH ARG_Z)
    ;(LWZ ARG_Z 0 VSP)
    ;(LA VSP 4 VSP)
    (BLA .SPFFCALLADDRESS)
    (slwi arg_z imm0 ppc::fixnumshift)
    (ba .sppopj))
  
  #+use-cfm ;; cfm version 
  (defppclapfunction get-tick-count ()
    (twnei nargs 0)
    (mflr loc-pc)
    (bla .spsavecontextvsp)
    ;(lwz nargs 331 rnil)
    ;(twgti nargs 0)
    (stwu sp #.(- (+ ppc::c-frame.minsize ppc::lisp-frame.size )) sp)
    (stw rzero 8 sp)
    ;(mr arg_z slep)
    (lwz arg_z '#.(get-shared-library-entry-point "TickCount") fn)
    ;(vpush arg_z)
    ;(lwz arg_z 0 vsp)
    ;(la vsp 4 vsp)
    (bla .spffcallslep)
    (slwi arg_z imm0 ppc::fixnumshift)
    (ba .sppopj))
)

;; returns 2 values - the first same as get-tick-count, the second the hi 2 bits of #_tickcount
#+use-cfm
(defppclapfunction get-tick-count-lo-hi ()
  (twnei nargs 0)
  (mflr loc-pc)
  (bla .spsavecontextvsp)  
  (stwu sp #.(- (+ ppc::c-frame.minsize ppc::lisp-frame.size )) sp)
  (stw rzero 8 sp)
  (lwz arg_z '#.(get-shared-library-entry-point "TickCount") fn)
  (bla .spffcallslep)
  (slwi arg_z imm0 ppc::fixnumshift)
  (vpush arg_z)
  (rlwinm arg_z imm0 (+ ppc::fixnumshift ppc::fixnumshift)  (- 30 ppc::fixnumshift) (- 31 ppc::fixnumshift))
  (vpush arg_z)
  (set-nargs 2)
  (ba .spnvalret))

#-use-cfm
(defppclapfunction get-tick-count-lo-hi ()
  (twnei nargs 0)
  (mflr loc-pc)
  (bla .spsavecontextvsp)  
  (stwu sp #.(- (+ ppc::c-frame.minsize ppc::lisp-frame.size )) sp)
  (stw rzero 8 sp)
  (LWZ ARG_Z '#.(get-macho-entry-point "TickCount") FN)
  (SET-NARGS 1)
  (LWZ TEMP3 'MACHO-ADDRESS FN)
  (BLA .SPJMPSYM)  
  (BLA .SPFFCALLADDRESS)
  (slwi arg_z imm0 ppc::fixnumshift)
  (vpush arg_z)
  (rlwinm arg_z imm0 (+ ppc::fixnumshift ppc::fixnumshift)  (- 30 ppc::fixnumshift) (- 31 ppc::fixnumshift))
  (vpush arg_z)
  (set-nargs 2)
  (ba .spnvalret))





; These only work correctly compiled - also only if args are really fixnums
(defmacro %tick-sum (x y)
  `(the fixnum (+ (the fixnum ,x) (the fixnum ,y))))

(defmacro %tick-difference (x y)
  `(the fixnum (- (the fixnum ,x) (the fixnum ,y))))

(defun startup-shutdown-processes ()
  (dolist (p *all-processes*)
    (clear-process-run-time p))
  (let* ((now (get-tick-count))
         p)
    (loop
      (unless *shutdown-processes* (return))
      (setq p (pop *shutdown-processes*))
      (setf (process.nexttick p) now
            (process.stack-group p) (process.initial-stack-group p))
      (%process-preset-internal p)
      (ensure-process-active p)
      ; May have some work to do here depending on process.warm-boot-action.
      )))

; Done with a queue-fixup so that it will be the last thing
; that happens on startup.
(queue-fixup
 (pushnew 'startup-shutdown-processes *lisp-system-pointer-functions*))

(defmethod print-object ((p process) s)
  (print-unreadable-object (p s :type t :identity t)
    (format s "~a [~a]" (process.name p) (process-whostate p))))

(defun make-process (name &key 
                          simple-p
                          flavor        ; ignored
                          stack-group
                          warm-boot-action
                          (quantum *default-quantum*)
                          (priority 0)
                          run-reasons
                          arrest-reasons
                          (stack-size *default-process-stackseg-size*)
                          (vstack-size stack-size)
                          (tstack-size stack-size)
                          background-p)
  (declare (ignore flavor))
  #-ppc-target (declare (ignore tstack-size vstack-size))
  (let* ((sg (unless simple-p (or stack-group 
                                  (make-stack-group name stack-size #+ppc-target vstack-size 
                                                                    #+ppc-target tstack-size))))
         (now (get-tick-count))
         (long-now (#_TickCount))
         (p (%istruct 'process
                      name
                      sg
                      sg
                      (cons nil nil)
                      #'false                     ; wait-function
                      nil                         ; wait-arguments-list
                      run-reasons
                      arrest-reasons
                      priority
                      quantum
                      warm-boot-action
                      "New"
                      0
                      (cons nil nil)
                      background-p
                      long-now          ; creation-time
                      now               ; last-run-time
                      (cons 0 0)        ; total-run-time: (hi . lo)
                      nil  ; internal priority
                      nil  ; timeout
                      0    ; wait finished
                      nil  ; run-times
                      )))
    (push p *all-processes*)
    (setf (car (process.splice p)) p)
    p))

(defparameter *event-processor-priority* 1)
(defglobal *initial-process* (let* ((p (make-process "Initial" :stack-group *current-stack-group* 
                                                     :priority *event-processor-priority*)))
                               (push :enabled (process.run-reasons p))
                               (setf (process.wait-function p) #'true)
                               (setf (process.whostate p) "Run")
                               p))

(defglobal *current-process* *initial-process*)

(defglobal *event-processor* *initial-process*)


(defun processp (p)
  (istruct-typep p 'process))

(set-type-predicate 'process 'processp)

(defun process-name (p)
  (process.name (require-type p 'process)))

(defun process-stack-group (p)
  (process.stack-group (require-type p 'process)))

(defun stack-group-process (sg)
  (dolist (p *all-processes*)
    (when (eq sg (process-stack-group p))
      (return p))))

(defun process-initial-stack-group (p)
  (process.initial-stack-group (require-type p 'process)))

(defun process-initial-form (p)
  (process.initial-form (require-type p 'process)))

(defun process-wait-function (p)
  (process.wait-function (require-type p 'process)))

(defun process-wait-argument-list (p)
  (process.wait-argument-list (require-type p 'process)))

(defun process-exhausted-p (p)
  (%stack-group-exhausted-p (process-stack-group p)))
  

(defun process-whostate (p)
  (if (%stack-group-exhausted-p (process-stack-group p))
    "exhausted"
    (process.whostate p)))

(defun process-quantum-remaining (p)
  (if (eq (setq p (require-type p 'process)) *current-process*)
    (max (%tick-difference (process.nexttick p) (get-tick-count)) 0)
    0))

(defun process-priority (p)
  (process.priority (require-type p 'process)))

(defun (setf process-priority) (new p)
  (setf (process.priority (require-type p 'process))
        (require-type new 'real)))

(defun process-simple-p (p)
  (not (typep (process.stack-group (require-type p 'process)) 'stack-group)))

(defun process-run-reasons (p)
  (process.run-reasons (require-type p 'process)))

(defun process-arrest-reasons (p)
  (process.arrest-reasons (require-type p 'process)))

(defun process-background-p (p)
  (or (eq *event-processor* (require-type p 'process))
      (process.background-p p)))

(defun (setf process-background-p) (value p)
  (setf (process.background-p (require-type p 'process)) value))

(defun process-last-run-time (p)
  (process.last-run-time (require-type p 'process)))

(defun process-total-run-time (p)
  (let ((total (process.total-run-time (require-type p 'process))))
    (declare (type cons total))
    (+ (* (car total) (+ most-positive-fixnum most-positive-fixnum 2))
       (cdr total))))

(defun process-creation-time (p)
  (process.creation-time (require-type p 'process)))

(defun clear-process-run-time (p)
  (let ((total (process.total-run-time (require-type p 'process))))
    (declare (type cons total))
    (without-interrupts
     (setf (car total) 0
           (cdr total) 0
           (process.creation-time p) (#_TickCount))
     (when (eq p *current-process*)
       (setf (process.last-run-time p) (get-tick-count))))))

(defun process-maximum-stack-size (p)
  (stack-group-maximum-size (process-stack-group p)))

(defun (setf process-maximum-stack-size) (size p)
  (setf (stack-group-maximum-size (process-stack-group p)) size))

(defun symbol-value-in-process (sym process)
  (symbol-value-in-stack-group sym (process-stack-group process)))

(defun (setf symbol-value-in-process) (value sym process)
  (setf (symbol-value-in-stack-group sym (process-stack-group process)) value))

(defun process-enable (p)
  (setq p (require-type p 'process))
  (deactivate-process p)
  (setf (process.run-reasons p) (list :enable)
        (process.arrest-reasons p) nil
        (process.whostate p) "Enabled")
  (ensure-process-active p))

(defun process-disable (p)
  (setq p (require-type p 'process))
  (setf (process.run-reasons p) nil
        (process.arrest-reasons p) nil
        (process.whostate p) "Disabled")
  (deactivate-process p))

(defun process-active-p (p)
  (setq p (require-type p 'process))
  (and (process-run-reasons p)
       (null (process-arrest-reasons p))
       (not (%stack-group-exhausted-p (process-stack-group p)))))

(defun process-enable-run-reason (process &optional (reason :user))
  (without-interrupts
   (let* ((old-run-reasons (process.run-reasons (require-type process 'process)))
          (new-run-reasons (pushnew reason (process.run-reasons process))))
     (ensure-process-active process)
     (unless (or old-run-reasons
                 (process.arrest-reasons process))
       (setf (process.whostate process) "Active"))
     new-run-reasons)))

(defun process-disable-run-reason (process &optional (reason :user))
  (let (stop-p new-run-reasons)
    (without-interrupts
     (let ((old-run-reasons (process.run-reasons (require-type process 'process))))
       (setq new-run-reasons (setf (process.run-reasons process)
                                   (delq reason (process.run-reasons process)))
             stop-p (and old-run-reasons
                         (null new-run-reasons)))
       (when stop-p
         (deactivate-process process)
         (setf (process.whostate process) "Stopped"))))
    (when (and stop-p (eq process *current-process*))
      (scheduler))
    new-run-reasons))

(defun process-enable-arrest-reason (process &optional (reason 'user))
  (prog1
    (without-interrupts
     (prog1
       (pushnew reason (process.arrest-reasons (require-type process 'process)))
       (deactivate-process process)
       (setf (process.whostate process) "Arrested")))
    (when (eq process *current-process*)
      (scheduler))))

(defun process-disable-arrest-reason (process &optional (reason 'user))
  (let* ((old-arrest-reasons (process.arrest-reasons (require-type process 'process)))
         (new-arrest-reasons (setf (process.arrest-reasons (require-type process 'process))
                                   (delq reason (process.arrest-reasons process)))))
    (when (and old-arrest-reasons
               (null new-arrest-reasons))
      (setf (process.whostate process) "Unarrested"))
    (ensure-process-active process)
    new-arrest-reasons))

; Used by process-run-function
(defun process-preset (process function &rest args)
  (let* ((p (require-type process 'process))
         (f (require-type function 'function))
         (initial-form (process.initial-form p)))
    (declare (type cons initial-form))
    ; Not quite right ...
    (rplaca initial-form f)
    (rplacd initial-form args)
    (%process-preset-internal process)))

(defun %process-preset-internal (process)
  (without-interrupts
   (let ((initial-form (process.initial-form process))
         (sg (process.initial-stack-group process)))
     (declare (type cons initial-form))
     (setf (process.wait-function process) nil
           (process.wait-argument-list process) nil)
     (setf (process.stack-group process) sg)
     (stack-group-preset sg
                         #'(lambda (process initial-form)
                             (run-process-initial-form process initial-form))
                         process
                         initial-form)
     (pushnew process *all-processes* :test #'eq)
     (let-globally ((*in-scheduler* t))
       (unless (eq process *current-process*)
         (%activate-process process)))
     process)))

; Flag is pushed onto process.arrest-reasons when a one-timer
; created by process-run-function exits. Ensures that we don't try
; to restart any one-timers.
(defun run-process-initial-form (process initial-form)
  (loop
    (let* ((exited? nil)
           (kill (catch (process-reset-tag process)
                   (with-standard-abort-handling "Restart process"
                     ; Done starting up. We may not be runnable yet, so
                     ; let the scheduler decide who to run next.
                     (suspend-current-process)
                     (apply (car initial-form) (cdr (the list initial-form)))
                     (setq exited? t)
                     nil))))
      (when (or kill exited?)
        (unless (eq kill :toplevel)
          (process-initial-form-exited process kill)
          (return nil))))))

; Separated from run-process-initial-form just so I can change it easily.
(defun process-initial-form-exited (process kill)
  ; Enter the *initial-process* and have it finish us up
  (let-globally ((*in-scheduler* t))
    (without-interrupts
     (if (eq kill :shutdown)
       (progn
         (deactivate-process process)
         (setf (process.whostate process) "Shutdown")
         (pushnew process *shutdown-processes*))
       (process-disable process))
     ; This is here to set the process'es stack group's resumer to the
     ; *initial-process*'es stack group.
     (process-interrupt *initial-process*
                        #'(lambda (process)
                            ; Avoid function entry event processing
                            (declare (optimize (speed 3) (safety 0)))
                              (without-interrupts
                               (let-globally ((*in-scheduler* t))
                                 (%activate-process process t t))))
                        *current-process*)
     (%activate-process *initial-process* t)
     (maybe-finish-process-kill process kill))))

(defun maybe-finish-process-kill (process kill)
  (when (and kill (neq kill :shutdown))
    (let-globally ((*in-scheduler* t))
      (deactivate-process process)
      (setf (process.whostate process) "Dead")
      (setq *all-processes* (delete process *all-processes*))
      (let ((sg (process-stack-group process)))
        (unless (or (eq sg *current-stack-group*)
                    (%stack-group-exhausted-p sg))
          (kill-stack-group sg)))))
  nil)

; Splice process p into *active-processes*, after all others of >= priority.
(defun ensure-process-active (p)
  (unless (memq p *active-processes*)
    (when (process-active-p p)
      (without-interrupts
       (let* ((splice (process.splice p))
              (ourpri (or (and *new-processes* (process.internal-priority p))(process.priority p)))
              (handle (cons nil *active-processes*)))
         (declare (dynamic-extent handle) 
                  (type cons handle splice))
         (rplacd splice nil)
         (do* ((h handle cell)
               (cell (cdr h) (cdr h)))
              ((null cell) (rplacd h splice))
           (declare (type cons h) (type list cell))
           (let* ((other (car cell)))
             (when (< (or (and *new-processes* (process.internal-priority other))(process.priority other)) ourpri)
               (rplacd splice cell)
               (rplacd h splice)
               (return))))
         (setq *active-processes* (cdr handle)))))))

(defun deactivate-process (p)
  (without-interrupts
   #|
   (when (eq p (car *active-processes-tail*))
     (setq *active-processes-tail* (cdr *active-processes-tail*)))
   |#
   (let ((tail (memq p *active-processes-tail*)))
     (when tail 
       (setq *active-processes-tail* (cdr tail))
       ))
   (setf *active-processes* (delete p *active-processes*)
         (cdr (process.splice p)) nil)))

(defglobal *active-processes* (process.splice *initial-process*))

; A unique token so we can tell when %activate-process
; is restarted due to a process becoming exhausted.
(defvar *scheduler-value* (list '*scheduler-value*))

; Set true to enable debugging messages
(defvar *process-debug-msgs* nil)

; This is an attempt to debug the new %activate-process code.
(defparameter *using-stack-groups* t)   ; set true if you use explicit stack groups

; P is an active (runnable) process.
; Don't call this unless you've (let-globally ((*in-scheduler* t)) ...)
(defun %activate-process (p &optional dont-set-in-scheduler funcall-stack-group)
  (declare (optimize (speed 3)(safety 0))) ;; avoid event check on entry
  (let* ((current *current-process*)
         (sg (process.stack-group p)))
    (unless (eq p current)
      (if (%stack-group-exhausted-p sg)
        (progn
          (process-disable p)
          (error "Exhausted stack group for ~s" p))
        (without-interrupts  ;; << 
         (let* ((now (get-tick-count))
                (nexttick (%tick-sum now (process.quantum p))))
           (setf (process.whostate p) "Running")
           (setf (process.nexttick p) nexttick)
           (let ((sg *current-stack-group*))
             (unless (eq sg (process.stack-group current))
               (cond ((stack-group-process sg)
                      (when *process-debug-msgs*
                        (warn "Can't set stack group of ~s to ~s" current sg)))
                     ((and *using-stack-groups*
                           (neq current *initial-process*)
                           (neq current *event-processor*))
                      (setf (process.stack-group current) sg)))))
           (setq *current-process* p)
           (unless (eq p current)
             (unless (process-background-p p)
               (setq *idle* nil))
             (let* ((ticks (%tick-difference now (process.last-run-time current)))
                    (total (process.total-run-time current))
                    (lo-total (cdr total))
                    (new-lo-total (%tick-sum lo-total ticks)))
               (declare (cons total) (fixnum ticks lo-total new-lo-total))
               (setf (cdr total) new-lo-total)
               (when (and (< lo-total 0) (>= new-lo-total 0))  ;; <<
                 (setf (car total) (the fixnum (1+ (the fixnum (car total)))))))
             (setf (process.last-run-time p) now
                   (process.last-run-time current) now)
             (unless dont-set-in-scheduler
               (setq *in-scheduler* nil))
             (unless (eq *scheduler-value*
                         (if funcall-stack-group
                           (funcall sg *scheduler-value*)
                           (stack-group-resume sg *scheduler-value*)))
               ; I'm being resumed by other than myself in another process.
               ; The *current-process* must have become exhausted and resumed its resumer.
               ; Need to make *current-process* match *current-stack-group*.
               (when *using-stack-groups*
                 (let ((process (stack-group-process *current-stack-group*)))
                   (when process
                     (setq *current-process* process)))))
             nil)))))))

(defvar *in-process-wait-function* nil)

; True if either the wait function doesn't exist or it returns true
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
               (when (apply wf args)
                 (when *new-processes* 
                   (when (not (process.wait-finished process))
                     (setf (process.wait-finished process)(get-tick-count)))) ; <<
                 (clear-process-polling)
                 t))))))

; Called from process-wait to signal an error on a recursive process-wait
(defun recursive-process-wait (process)
  (if (eq process *current-process*)
    (error "process-wait called from inside a process-wait function")
    (process-interrupt process
                       #'(lambda (process)
                           (let ((*in-process-wait-function* nil))
                             ; try to signal the error in context
                             (%process-wait-p process)
                             ; didn't signal in context, so signal out of context
                             (recursive-process-wait process)))
                       process))
  (throw '%process-wait-p nil))

(defloadvar *in-scheduler* nil)

(defun scheduler ()
  (let-globally ((*in-scheduler* t))
    (if (null *current-process*)
      #+ppc-target(bug "*current-process* is nil in scheduler")
      #-ppc-target (dbg))
    ; give first preference to the guy who is processing events or who doesnt
    ; want event processing to happen quite yet.    
    (let ((pe *processing-events*))
      (when (and pe 
                 (neq pe t)
                 (not (%process-blocked-p pe))
                 (%process-wait-p pe))
        (return-from scheduler (%activate-process pe)))
      (loop
        (let ((active-processes-tail *active-processes-tail*))
          (if active-processes-tail
            (setq *active-processes-tail* nil)
            (setq active-processes-tail *active-processes*))
          (dolist (p active-processes-tail)
            (unless (%process-blocked-p p)
              (when (%process-wait-p p)
                (return-from scheduler (%activate-process p))))))
        ; Nobody ready to run, must be idle so poll for events
        (clear-process-polling)
        (event-poll)))))

; This does something like special binding, but the "bindings" established
; aren't undone by context switch.
(defmacro let-globally ((&rest vars) &body body &environment env)
  (multiple-value-bind (body decls) (parse-body body env)
    (let* ((initforms nil)
           (psetform nil)
           (specvars nil)
           (restoreform nil))
      (flet ((pair-name-value (p)
               (if (atom p)
                 (values p nil)
                 (if (and (consp (%cdr p)) (null (%cddr p)))
                   (values (%car p) (%cadr p))
                   (error "Invalid variable initialization form : ~s")))))
        (declare (inline pair-name-value))
        (dolist (v vars)
          (let* ((oldval (gensym))
                 (newval (gensym)))
            (multiple-value-bind (var valueform) (pair-name-value v)
              (push var specvars)
              (push var restoreform)
              (push oldval restoreform)
              (push `(,oldval (%sym-value ',var)) initforms)
              (push `(,newval ,valueform) initforms)
              (push var psetform)
              (push newval psetform))))
        `(let ,(nreverse initforms)
           ,@decls
           (locally (declare (special ,@(nreverse specvars)))
             (unwind-protect
               (progn (psetq ,@(nreverse psetform)) ,@body)
               (psetq ,@(nreverse restoreform)))))))))

#| ;; old one
(defun make-lock (&optional name)
  (if name
    (gvector :lock nil name)
    (gvector :lock nil)))
|#

;;; for cl-http

;; this used to make a structure containing only the lock value/owner if name was nil
(defun make-lock (&optional name type)
  (require-type type '(member nil :multiple-reader-single-writer :simple))
  (if (eq type :simple) (setq type nil))
  (gvector :lock nil name type  0))


(defun lock-type (lock)
  (lock.type lock))

(defun lock-nreaders (lock)
  (lock.nreaders lock))

(defun (setf lock-nreaders) (val lock)
  (setq lock (require-type lock 'lock))
  (setf (lock.nreaders lock) val))

(defun (setf lock-type) (val lock)
  (setq lock (require-type lock 'lock))
  (setf (lock.type lock) val)) 

(defun lock-owner (lock)
  (lock.value (require-type lock 'lock)))

(defun lock-name (lock)
  (and (> (uvsize (require-type lock 'lock)) lock.name)
       (lock.name lock)))

(defmethod print-object ((l lock) s)
  (print-unreadable-object (l s :identity t :type t)
    (when (> (uvsize l) lock.name)
      (prin1 (lock.name l) s)
      (write-char #\space s)
      (prin1 (lock.value l) s)
      (when (lock.type l)
        (write-char #\space s)
        (prin1 (lock.type l) s)))))

#-ppc-target
(defun lockp (l)
  (and (uvectorp l) (eq $v_lock (%vect-subtype l))))
#+ppc-target
(defun lockp (l)
  (eq ppc::subtag-lock (ppc-typecode l)))

(set-type-predicate 'lock 'lockp)

; This will need a without-interrupts if we ever go to a preemptive scheduler
; So will the compiler macro in "ccl:compiler;optimizers.lisp"
(defun store-conditional (lock old new)
  (unless (typep lock 'lock)
    (setq lock (require-type lock 'lock)))
  (locally (declare (type lock lock))
    (when (eq (lock.value lock) old)
      (setf (lock.value lock) new)
      t)))

; This will also need to be without-interrupts between the time the
; lock is tested and set if we ever go to a preemptive scheduler
(defun process-lock (lock &optional lock-value (whostate "Lock") interlock-function)
  (setq lock (require-type lock 'lock))
  (when (null lock-value)
    (setq lock-value *current-process*))
  (if interlock-function (setq interlock-function (coerce-to-function interlock-function)))
  (setq lock-value (or lock-value *current-process*))
  (loop
    (let* ((value (lock.value lock)))
      (cond ((null value)
             (if interlock-function
               (without-interrupts
                (setf (lock.value lock) lock-value)
                (funcall interlock-function))
               (setf (lock.value lock) lock-value))
             (return lock-value))
            ((neq value lock-value)
             (process-wait whostate #'(lambda (x) (null (lock.value x))) lock))
            (t (return lock-value))))))

; IBID on the without-interrupts requirement.
(defun process-unlock (lock &optional lock-value (error-p t))
  (setq lock (require-type lock 'lock))
  (when (null lock-value) (setq lock-value *current-process*))
  (unless (or (null error-p)
              (eq lock-value (lock.value lock)))
    (error "process-unlock called with wrong lock-value: ~s~%for ~s"
           lock-value lock))
  (setf (lock.value lock) nil))

(defun make-process-queue (name &optional size)
  (%cons-process-queue name size))

(defun process-queue-p (queue)
  (istruct-typep queue 'process-queue))

(set-type-predicate 'process-queue 'process-queue-p)

(defun process-queue-empty-p (queue)
  (null (process-queue.start (require-type queue 'process-queue))))

(defun process-queue-full-p (queue)
  (eql 0 (process-queue.positions-left (require-type queue 'process-queue))))

(defun process-queue-locker (queue)
  (car (process-queue.start (require-type queue 'process-queue))))

(defmethod print-object ((q process-queue) stream)
  (print-unreadable-object (q stream :type t :identity t)
    (prin1 (process-queue.name q) stream)
    (write-char #\space stream)
    (prin1 (process-queue-locker q) stream)))

(defun process-enqueue (queue &optional queue-value (whostate "Lock"))
  (process-enqueue-with-timeout queue nil queue-value whostate))

; timeout doesn't work right for a queue with a limited size, but I don't expect many
; people will use those (why would you want to except to be compatible with the Symbolics
; spec?)
(defun process-enqueue-with-timeout (queue timeout &optional queue-value (whostate "Lock"))
  (setq queue (require-type queue 'process-queue))
  (when (null queue-value)
    (setq queue-value *current-process*))
  (when (memq queue-value (process-queue.start queue))
    (error "~s already enqueued on ~s" queue-value queue))
  (without-interrupts
   (cond ((process-queue-full-p queue)
          (unless (process-wait-with-timeout
                   whostate
                   timeout
                   #'(lambda (queue) (not (process-queue-full-p queue)))
                   queue)
            (return-from process-enqueue-with-timeout nil))
          (process-enqueue-with-timeout queue timeout queue-value whostate))
         ((process-queue-empty-p queue)         
          (let ((cons (cheap-cons queue-value nil)))
            (setf (process-queue.start queue) cons
                  (process-queue.end queue) cons)
            (when (fixnump (process-queue.positions-left queue))
              (decf (the fixnum (process-queue.positions-left queue)))))
          t)
         ((eq timeout :usurp)         
          (let* ((cons (process-queue.start queue))
                 (owner (car cons)))
            (unless (processp owner)
              (error "Attempt to usurp a process-queue whose owner cannot be determined"))
            (setf (process-queue.start queue) (cheap-cons queue-value cons))
            (when (fixnump (process-queue.positions-left queue))
              (decf (the fixnum (process-queue.positions-left queue))))
            (process-interrupt owner
                               #'(lambda (queue cons)
                                   (process-wait "Usurper"
                                                 #'(lambda (queue cons)
                                                     (eq cons (process-queue.start queue)))
                                                 queue cons))
                               queue cons))
          :usurp)
         (t (let (cons)
              (setq cons (cheap-cons queue-value nil))
              (setf (cdr (process-queue.end queue)) cons
                    (process-queue.end queue) cons)
              (when (fixnump (process-queue.positions-left queue))
                (decf (the fixnum (process-queue.positions-left queue))))
              (let ((dont-dequeue? nil))
                (unwind-protect
                  (setq dont-dequeue? (process-wait-with-timeout
                                       whostate
                                       timeout
                                       #'(lambda (queue cons)
                                           (eq cons (process-queue.start queue)))
                                       queue cons))
                  (unless dont-dequeue?
                    (process-dequeue queue queue-value)))))))))

(defun process-dequeue (queue &optional queue-value (error-p t))
  (setq queue (require-type queue 'process-queue))
  (unless queue-value (setq queue-value *current-process*))
  (unless (without-interrupts
           (let ((last nil)
                 (current (process-queue.start queue)))
             (loop
               (when (null current) (return nil))
               (when (eq queue-value (car current))
                 (if last
                   (let ((next (cdr current)))
                     (setf (cdr last) next)
                     (when (null next)
                       (setf (process-queue.end queue) last)))
                   (unless (setf (process-queue.start queue) (cdr current))
                     (setf (process-queue.end queue) nil)))
                 (free-cons current)
                 (when (fixnump (process-queue.positions-left queue))
                   (incf (the fixnum (process-queue.positions-left queue))))
                 (return t))
               (setq last current
                     current (cdr current)))))
    (when error-p
      (error "~s is not on ~s" queue-value queue))))

(defun reset-process-queue (queue)
  (let (list)
    (without-interrupts
     (setf list (process-queue.start queue)
           (process-queue.start queue) nil
           (process-queue.end queue) nil))
    (while list
      (let ((l list))
        (pop list)
        (free-cons l)))))

(defun process-wait (whostate function &rest args)
  (declare (dynamic-extent args))
  (if *always-process-poll-p*
    (apply 'process-poll whostate function args)
    (or (apply function args)
        (let* ((p *current-process*)
               (old-whostate (process.whostate p)))
          (if *in-process-wait-function*
            (recursive-process-wait *in-process-wait-function*)
            (unwind-protect
              (progn
                (setf (process.wait-function p) (require-type function 'function)
                      (process.wait-argument-list p) args
                      (process.wait-finished p) nil)   ; for *new-processes*
                (suspend-current-process whostate))
              (setf (process.wait-function p) nil
                    (process.wait-argument-list p) nil
                    (process.whostate p) old-whostate)
              (when *new-processes*
                (when (not (process.wait-finished p))
                  (setf (process.wait-finished p)(get-tick-count)))
                ))))))
  nil)

(defun process-wait-with-timeout (whostate time function &rest args)
  (declare (dynamic-extent args))  
  (cond ((null time)  (apply #'process-wait whostate function args) t)
        (t (require-type time 'fixnum)
           (let* ((win nil)
                  (when (%tick-sum (get-tick-count) time))
                  (f #'(lambda () (let ((val (apply function args)))
                                    (if val
                                      (setq win val)
                                      (> (%tick-difference (get-tick-count) when) 0))))))
             (declare (dynamic-extent f))
             (process-wait whostate f)
             win))))

(defun clear-process-polling ()
  (without-interrupts
   (when *process-polling-p*
     (setq *active-processes-tail* nil)
     (dolist (p *active-processes*)
       (when (eq (process.wait-function p) :polled)
         (setf (process.wait-function p) :polling)))
     (setq *process-polling-p* nil))))

(defun process-poll (whostate function &rest args)
  (declare (dynamic-extent args))
  (or (apply function args)
      (let* ((p *current-process*))
        (if *in-process-wait-function*
          (recursive-process-wait *in-process-wait-function*)
          (unwind-protect
            (progn
              (setf (process.wait-function p) :polling)
              (loop
                (suspend-current-process whostate)
                (when (apply function args)
                  (clear-process-polling)
                  (return))
                (setf (process.wait-function p) :polled
                      *process-polling-p* t
                      *active-processes-tail* (cdr (memq p *active-processes*)))))
            (setf (process.wait-function p) nil
                  (process.wait-argument-list p) nil)
            (when *new-processes*
              (when (not (process.wait-finished p))
                (setf (process.wait-finished p)(get-tick-count))))))))
  nil)

(defun process-poll-with-timeout (whostate time function &rest args)
  (declare (dynamic-extent args))
  (cond ((null time)  (apply #'process-wait whostate function args) t)
        (t (let* ((win nil)
                  (when (%tick-sum (get-tick-count) time))
                  (f #'(lambda () (if (apply function args) 
                                    (setq win t)
                                    (> (%tick-difference (get-tick-count) when) 0)))))
             (declare (dynamic-extent f))
             (process-poll whostate f)
             win))))

(defun process-interrupt (process function &rest args)
  (declare (dynamic-extent args))
  (let* ((p (require-type process 'process)))
    (if (eq p *current-process*)
      (apply function args)
      (without-interrupts
       (let* ((wait (process.wait-function p))
              (wait-args (process.wait-argument-list p))
              (whostate (process.whostate p))
              (sg (process-stack-group p))
              (args (cheap-copy-list args)))
         (when (%stack-group-exhausted-p sg)
           (error "process-interrupt run on exhausted ~s" p))
         #-ppc-target                            ; for %primitive
         (let ((list (cheap-list #'(lambda (list function args p wait wait-args whostate)
                                     (unwind-protect
                                       (apply function args)
                                       (setf (process.wait-function p) wait
                                             (process.wait-argument-list p) wait-args
                                             (process.whostate p) whostate)
                                       (cheap-free-list list)
                                       (cheap-free-list args)))
                                 nil     ; list
                                 function
                                 args
                                 p
                                 wait
                                 wait-args
                                 whostate)))
           (setf (%cadr list) list)       ; must be %cadr, not cadr, for bootstrapping
           (setf (process.wait-function p) nil
                 (process.wait-argument-list p) nil)
           (%primitive $sp-sg-interrupt 
                       :arg_y #'(lambda () (suspend-current-process (process.whostate *current-process*)))
                       :atemp0 (process.stack-group p)
                       :arg_z list
                       :acc)
           nil)
         #+ppc-target
         (progn
           (setf (process.wait-function p) nil
                 (process.wait-argument-list p) nil)                      
           (stack-group-interrupt
            sg nil
            #'(lambda (function args p wait wait-args whostate)
                (unwind-protect
                  (apply function args)
                  (setf (process.wait-function p) wait
                        (process.wait-argument-list p) wait-args
                        (process.whostate p) whostate)
                  (cheap-free-list args))
                (suspend-current-process (process.whostate p)))
            function args p wait wait-args whostate)))))))

(defun process-flush (process)
  (let* ((p (require-type process 'process)))
    (unless (eq p *current-process*)
      (setf (process.wait-function p) #'false
            (process.wait-argument-list p) nil))))

#| ; or this ??
(defun suspend-current-process (&optional (why "Suspended" why-p))
  (let* ((p *current-process*)
         (pevents *processing-events*))
    (when (or (not pevents)
              (and pevents (neq pevents p)))
      (without-interrupts
       (when (and why (or why-p (not (process.wait-function p))))
         (setf (process.whostate p) why))
       (deactivate-process p)
       (ensure-process-active p))
      (scheduler))))
|#

(defglobal *no-scheduling* nil)

(defun suspend-current-process (&optional (why "Suspended" why-p))
  (unless *no-scheduling*
    (let* ((p *current-process*))
      (without-interrupts
       (when (and why (or why-p (not (process.wait-function p))))
         (setf (process.whostate p) why))
       (deactivate-process p)
       (ensure-process-active p))
      (scheduler))))

; This one is in the Symbolics documentation
(defun process-allow-schedule ()
  (unless *in-scheduler*
    (suspend-current-process "Allow schedule")))

; something unique that users won't get their hands on
(defun process-reset-tag (process)
  (process.splice process))

(defun maybe-process-run-function (name-or-keywords function &rest args)
  (declare (dynamic-extent args))
  (if *single-process-p*
    (apply function args)
    (apply 'process-run-function name-or-keywords function args)))

(defun process-run-function (name-or-keywords function &rest args)
  (if (listp name-or-keywords)
    (%process-run-function name-or-keywords function args)
    (let ((keywords (list :name name-or-keywords)))
      (declare (dynamic-extent keywords))
      (%process-run-function keywords function args))))

(defun %process-run-function (keywords function args)
  (destructuring-bind (&key (name "Anonymous")
                            restart-after-reset
                            warm-boot-action
                            (priority 0)
                            (quantum *default-quantum*)
                            (stack-size *default-process-stackseg-size*)
                            background-p)
                      keywords
    (setq priority (require-type priority 'fixnum)
          quantum (require-type quantum 'fixnum))
    (let* ((process (make-process name
                                  :warm-boot-action warm-boot-action
                                  :priority priority
                                  :quantum quantum
                                  :stack-size stack-size
                                  :background-p background-p))
           (abort-message (if restart-after-reset
                            "Restart process"
                            "Exit from process")))
      (process-preset 
       process
       #'(lambda (restart-after-reset process function args abort-message)
           (loop
             (let* ((tag (process-reset-tag process))
                    (kill (catch tag
                            (with-standard-abort-handling abort-message
                              (apply function args))
                            (process-reset process :always :kill :force))))
               (when (and (neq kill :toplevel)
                          (or (unless restart-after-reset
                                (setq kill t))
                              kill))
                 (throw tag kill)))))
       restart-after-reset process function args abort-message)
      (process-enable process)
      process)))

(defun process-reset (process &optional unwind-option kill without-aborts)
  (setq process (require-type process 'process))
  (unless (memq unwind-option '(:unless-current nil :always t))
    (setq unwind-option (require-type unwind-option '(member :unless-current nil :always t))))
  (unless (memq kill '(nil :kill :shutdown))
    (setq kill (require-type kill '(member nil :kill :shutdown))))
  (without-interrupts
   (setf (process.wait-function process) nil
         (process.wait-argument-list process) nil)
   (unless (eq unwind-option t)
     (if (eq process *current-process*)
       (if (eq (process.initial-stack-group process) *current-stack-group*)
         (unless (or (null unwind-option) (eq unwind-option :unless-current))
           (%process-reset process kill))
         ; The process has switched to another stack group.
         ; Need to restore the initial stack group, then do the reset.
         (let ((resetter #'(lambda (process unwind-option kill without-aborts)
                             (setf (process.stack-group process)
                                   (process.initial-stack-group process))
                             (process-reset process unwind-option kill without-aborts))))
           (if (eq process *initial-process*)   ; I hope this never happens
             (process-run-function "Resetter" resetter
                                   process unwind-option kill without-aborts)
             (process-interrupt *initial-process* resetter
                                process unwind-option kill without-aborts))
           (suspend-current-process)))
       (if (%stack-group-exhausted-p (process.stack-group process))
         (maybe-finish-process-kill process kill)
         (progn
           (setf (process.stack-group process) (process.initial-stack-group process))
           (process-interrupt process '%process-reset process kill)
           (suspend-current-process)))))))

(defun %process-reset (process kill)
  (unless (eq process *current-process*)
    (error "*current-process* ~s ­ ~s" *current-process* process))
  (ignore-errors
   (throw (process-reset-tag process) kill))
  ; The throw didn't happen. Must have been executing in another stack group
  (maybe-finish-process-kill process kill))

(defun process-kill (process &optional (without-aborts :ask))
  (process-reset process :always :kill without-aborts))

(defun process-kill-and-wait (process &key
                                      (without-aborts :ask)
                                      (wait-ticks 300))
  (process-kill process without-aborts)
  (unless (process-wait-with-timeout
           "Deathwatch"
           wait-ticks
           #'(lambda (process) (not (memq process *all-processes*)))
           process)
    (let ((ans
           (y-or-n-dialog (format nil "Terminate ~s with extreme prejudice?"
                                 process)
                          :cancel-text (if *quitting* "Cancel"))))
      (if (eq t ans)
        (maybe-finish-process-kill process t)
        (if ans (cancel))))))


;; Process Blocking

; may need to use verify-functions, if real priorities are implemented

(defglobal *blocked-processes* nil "List of (process . timeout) pairs")

; Note: Symbolcs' block-process takes a verify-function
(defun process-block (process whostate)
  (without-interrupts
   (deactivate-process (require-type process 'process))
   (setf (process.whostate process) whostate))
  (when (eq process *current-process*)
    (scheduler))
  process)

; Note: Symbolcs' block-with-timeout takes a verify-function
(defun process-block-with-timeout (process time whostate)
  (without-interrupts
   (push (cons process (%tick-sum (get-tick-count) time))
         *blocked-processes*)
   (setf (process.whostate process) whostate))
  (when (eq process *current-process*)
    (scheduler)))

(defun %process-blocked-p (process)
  "If process is unblocked, returns nil; if blocked and timed out, unblocks
and returns nil; else returns true."
  (let ((info (assq process *blocked-processes*)))
    (declare (cons info))
    (and info
         (let ((timeout (cdr info)))
           (cond ((%i< (get-tick-count) timeout) t)
                 (t (setq *blocked-processes* (delq info *blocked-processes*))
                    (setf (process.whostate process) "Unblocked")
                    nil))))))

; Note: like Symbolics' force-wakeup
(defun process-unblock (process)
  (let ((info (assq (require-type process 'process) *blocked-processes*)))
    (cond (info (setq *blocked-processes* (delq info *blocked-processes*)))
          ((memq process *active-processes*)
           (error "Process ~S is not blocked" process))))
  (setf (process.whostate process) "Unblocked")
  (ensure-process-active process))

(defun process-abort (process &optional condition)
  (process-interrupt process
                     #'(lambda ()
                         (abort condition))))

(defun process-reset-and-enable (process)
  (process-reset process)
  (process-enable process))


#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
