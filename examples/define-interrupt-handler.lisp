; -*- Mode:Lisp; Package:CCL; -*-

;;	Change History (most recent first):
;;  1 1/31/95  akh  new file from Bill St. Clair
;;  (do not edit before this line!!)

;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;;; define-interrupt-handler.lisp
;;;
;;; Support for interrupts in Lisp.
;;; One problem with MCL is that you can't write completion routines
;;; in Lisp. This used to mean that you needed to write them in C,
;;; Pascal, or assembler. This package adds support for completion
;;; routines written in Lisp.
;;;
;;; The latency for a Lisp completion routine may be too long for
;;; some applications. The interrupt won't be processed until the
;;; first function entry or backward branch after Lisp code exits
;;; all without-interrupts dynamic scopes. Also, the interrupt code
;;; won't run until the Mac process manager lets MCL run. The interrupt
;;; code calls #_WakeupProcess to ensure that this is will be soon,
;;; but since this is the Cooperative Multiprocessing Experience, it
;;; may take a while for other applications to give up the com.
;;;

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History
;;;
;;; 10/09/96 slh   move export to inside eval-when
;;; 07/26/96 bill  comment out lfun-to-ptr, it's in "ccl:lib;windoids.lisp" now.
;;; 07/25/96 bill  in PPC version of interrupt-code, #$ticks -> #.#$ticks
;;; 07/19/96 bill  :record-ptr & :timestamp argument types.
;;; -------------  MCL-PPC 3.9
;;; 04/05/96 bill  Make it work in MCL-PPC
;;; ------------- 1.0
;;; 12/12/95 bill  $nil renamed to $lisp_nil in MCL 3.0
;;; 10/12/93 bill  First released
;;;

#|
Documentation
-------------

DEFINE-INTERRUPT-HANDLER name&keys arglist &body body    { Macro }

  name&keys   either a symbol, name, or a list of the form:
                (name :queue-size queue-size)

  arglist     alternating types and argument names

  body        code to run when the interrupt happens

Similar to DEFPASCAL, but the resulting macptr can be called at
interrupt time. All that happens at interrupt time is that the
arguments are put into a queue. The body will be entered at the
first opportunity: as soon as your Lisp code does function entry
or a backward branch (after exiting all WITHOUT-INTERRUPTS).

Declares the name to be special and sets its value to a macptr that
can be used as the value for toolbox completion routines. You can
also FF-CALL this function, but see the warning in the example at the
end of this file. If queue-size is specified, it is the length of
the queue for values to this interrupt. That many interrupts can
happen before you process one of them. The default is 10.

The supported argument types are :word, :long, :ptr (or :pointer),
and the 16 register names as keywords (i.e. :d0 to :d7 and :a0 to :a7).
(Register args are not supported in MCL-PPC).
Data registers will be passed as integers. Address registers will be
passed as macptrs. :long parameters (e.g. data registers) may cons
bignums. No other consing will happen due to an interrupt unless your
body code conses. Macptr args passed to your body code have dynamic
extent. If you need to hold onto one of them beyond the dynamic
extent of the body code, copy it (with e.g. (%inc-ptr <macptr> 0)).

There are two special argument types.

(:record-ptr record-name-or-size)
  The argument at interrupt time is assumed to be a pointer to a record
containing the number of bytes specified by record-name-or-size, which
can be either the name of a record, in which case its record-length is
used, or an integer. The contents of the memory pointed at by the pointer
is sampled at interrupt time. In your code, this argument will be a pointer
to a dynamic-extent record containing that contents.

:timestamp
  Call #_Microseconds at interrupt time to sample the current time.
The :timestamp parameter in your code will be bound to a macptr pointing
to the 8 bytes returned from the #_Microseconds call.

Returns the name, as do DEFPASCAL and DEFUN.

In order to support dynamically created interrupt handlers (e.g.
WITH-INTERRUPT-HANDLERS), the return value is different if the NIL is
passed for the name. In this case two values are returned:

1) The interrupt routine: a macptr
2) The routine's number. This can be passed to DELETE-INTERRUPT-NUMBER
   when you are finished with the routine.

If you specify a name of NIL, the macro expansion will not include a
compile & execute time require of LAPMACROS. In that case, you'll need
to include the following at top level in your source file before the
form containing the DEFINE-INTERRUPT-HANDLER (68K MCL only):

(eval-when (:compile-toplevel :execute)
  (require "LAPMACROS"))

DEFINE-INTERRUPT with a non-NIL name includes this require for you.


INTERRUPT-OVERFLOW-COUNT                                 { Function }

Can be called from within the dynamic extent of the body of an interrupt
handler. Returns the number of interrupts that were missed since the
last time interrupt-overflow-count was called due to this interrupt's
queue being full. Will error if called from outside of the dynamic extent
of an interrupt handler. Note that this will return non-zero before
you get to the missed interrupts. There is currently no way to tell
where in the sequence of interrupts the missed ones fell. You will always
see the most recent interrupt, as the interrupt-time code overwrites
the last queue entry when the queue is full.


DELETE-INTERRUPT-HANDLER name &optional errorp           { Function }

name    a symbol naming the interrupt handler

errorp  true if an error should be signalled if there is no
        interrupt handler with the given name. The default is true.

Deletes the interrupt handler with the given name and frees all associated
Mac heap storage. It is a very bad idea to call delete-interrupt-handler
while there are outstanding interrupts on that handler (Crashville).


DELETE-INTERRUPT-NUMBER number &optional errorp          { Function }

same as DELETE-INTERRUPT-HANDLER, but takes an interrupt routine number
instead of a name. The number is returned as the second value from
DEFINE-INTERRUPT-HANDLER when the name is NIL.


WITH-INTERRUPT-HANDLERS handler-specs &body body         { Macro }

handler-specs  a list each of whose elements is of the form:
                 (name&keys args &body interrupt-body)

body           lisp forms to run in a context where the interrupt
               names are (lexically) bound to interrupt routines.

WITH-INTERRUPT-HANDLERS is to LET what DEFINE-INTERRUPT-HANDLER is to DEFVAR.
Conses some 240 bytes plus or minus for each binding (depends on how many args
there are).


See the example code at the end of this file.
                          
|#

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; to do
;;;
#|
Add and use some DEFRESOURCE's to make WITH-INTERRUPT-HANDLERS cons less.
|#

(in-package :ccl)

(eval-when (:compile-toplevel :execute :load-toplevel)
  (export '(define-interrupt-handler delete-interrupt-handler delete-interrupt-number
             with-interrupt-handlers interrupt-overflow-count)))

(eval-when (:compile-toplevel :execute)
  #-ppc-target
  (require "LAPMACROS")                 ; LAP spoken here
  (require "LISPEQU"))                  ; ptask.state

#-ppc-target
(progn

(eval-when (:compile-toplevel :execute :load-toplevel)

(unless (boundp '$nil)

(defconstant $nil #.$lisp_nil)

)  ; end of unless

(let ((*warn-if-redefine* nil))         ; the PREF lapop may eventually be part of LAP

(deflapop pref (reg record-accessor)
  `(,reg (get-field-offset ,record-accessor)))

))  ; end of let & eval-when

; This is totally evil, but the address of the interrupt pending
; flag is not exported to Lisp. This works for 2.0 & 3.0
(defconstant $ipending (+ $db_link 4))

; Here again, we know how MCL encodes the fact that there is an
; "interrupt" pending. If the word at (a5 $sp-eventch_jmp is not
; a NOP instruction, then periodic event processing will happen at
; the first backward branch or function entry.
(defconstant $nop-instruction #x4e75)

; should be #$invbl, but this seems to be an assembly-language-only constant
(defconstant $invbl-bit 6)

)  ; end of #-ppc-target progn

(defmacro define-interrupt-handler (name&keys arglist &body body)
  (let ((name name&keys)
        qsize)
    (unless (symbolp name)
      (destructuring-bind (nam &key queue-size) name
        (setq name nam qsize queue-size)))
    (multiple-value-bind (arg-encoding arg-count timestamp-p arg-names queue-filler-code
                                       stack-bytes entry-bytes decls)
                         (parse-interrupt-arglist arglist)
      `(progn
         ,@(when name
             `(#-ppc-target
               (eval-when (:compile-toplevel :execute)
                 ; Does this belong here. Probably yes, or some users will be confused.
                 (require "LAPMACROS"))
               (defvar ,name)))
         (%define-interrupt-handler
          ',name ,qsize ,arg-encoding ,arg-count ,timestamp-p ,stack-bytes ,entry-bytes
          (nfunction ,name (lambda ,arg-names 
                             (declare ,@decls)
                             ,@body))
          (function ,(make-interrupt-lfun queue-filler-code)))))))

; This array holds an INTERRUPT structure instance for each
; DEFINE-INTERRUPT-HANDLER that has been evaluated.
(defvar *interrupt-routines* (make-array 100 :initial-element nil))

; Our Process Serial Number
(defvar *ccl-psn* nil)

; The address of the #_WakeUpProcess trap (dispatcher)
(defvar *wakeup-process-address* nil)

; The address of the #_Microseconds routine
(defvar *microseconds-address* nil)

; Number of entries in *interrupt-routines*
(defvar *interrupt-routines-count* 0)

; This queue holds indices into *interrupt-routines*
(defvar *pending-interrupts* nil)

; Slots in *interrupt-routines* that are free due to delete-interrupt-handler
(defvar *free-interrupt-numbers* nil)

; Woe unto you if an interrupt happens for the routine that you remove here.
(defun delete-interrupt-handler (name &optional (errorp t))
  (let* ((interrupt (find-interrupt-named name)))
    (if (not interrupt)
      (when errorp
        (error "There is no interrupt named ~s" name))
      (%delete-interrupt-handler interrupt))))

(defun delete-interrupt-number (number &optional (errorp t))
  (let ((interrupt
         (and (< -1 number *interrupt-routines-count*)
              (svref *interrupt-routines* number))))
    (if (not interrupt)
      (when errorp
        (error "There is no interrupt number ~s" number))
      (%delete-interrupt-handler interrupt))))

(defun %delete-interrupt-handler (interrupt)
  (let* ((stub (interrupt-stub interrupt))
         (stub-ptr (interrupt-stub-pointer stub))
         (code (%get-ptr stub-ptr))
         (queue (interrupt-queue interrupt))
         (number (interrupt-routine-number interrupt)))
    (setf (svref *interrupt-routines* number) nil)
    (without-interrupts
     (if (eql (1+ number) *interrupt-routines-count*)
       (setq *interrupt-routines-count* number)
       (push number *free-interrupt-numbers*)))
    (dispose-interrupt-stub stub)
    (dispose-interrupt-code code)
    (#_DisposePtr queue))
  nil)

(defmacro with-interrupt-handler ((name&keys args &body interrupt-body)
                                  &body body)
  (let ((name name&keys)
        (number (gensym))
        keys)
    (when (listp name&keys)
      (setq name (car name&keys)
            keys (cdr name&keys)))
    `(let (,name ,number)
       (unwind-protect
         (progn
           (multiple-value-setq (,name ,number)
             (define-interrupt-handler (nil ,@keys) ,args
               ,@interrupt-body))
           ,@body)
       (delete-interrupt-number ,number nil)))))

; No telling how useful this will be. It conses 168 bytes.
(defmacro with-interrupt-handlers (handlers &body body)
  (if (null handlers)
    `(progn ,@body)
    `(with-interrupt-handler ,(car handlers)
       (with-interrupt-handlers ,(cdr handlers) ,@body))))

(defparameter *interrupt-encodings*
  '((:word . 0)
    (:long . 1)
    (:ptr . 2)
    (:record-ptr . 3)
    (:timestamp . 3)
    (:pointer . 2)))

(defparameter *address-register-names*
  #-ppc-target
  '(:a0 :a1 :a2 :a3 :a4 :a5 :a6 :a7)
  #+ppc-target
  nil)

(defparameter *register-names*
  #-ppc-target
  `(:d0 :d1 :d2 :d3 :d4 :d5 :d6 :d7 ,@*address-register-names*)
  #+ppc-target
  nil)

(defparameter *valid-interrupt-arg-types*
  (append (butlast (mapcar 'car *interrupt-encodings*)) *register-names*))

#-ppc-target
(defun parse-interrupt-arglist (arglist)
  (let ((args arglist)
        names code word-args macptr-args
        (arg-encoding 0)
        (arg-count 0)
        (shift 0)
        (skip-count 0)
        (stack-bytes 0)
        (entry-bytes 0)
        (timestamp-var nil))
    (loop
      (when (null args) (return))
      (let* ((type (pop args))
             (type-arg (when (listp type)
                         (prog1 (cadr type)
                           (setq type (car type)))))
             (name (pop args))
             (register-p (memq type *register-names*))
             (bytes (if (eq type :word) 2 4)))
        (unless (memq type *valid-interrupt-arg-types*)
          (error "~s is not one of ~s" type *valid-interrupt-arg-types*))
        (unless (or (listp name) (symbolp name))
          (setq name (require-type name '(or lisp symbol))))
        (if (eq type :timestamp)
          (if timestamp-var
            (error "Multiple :timestamp specs")
            (setq timestamp-var name))
          (progn
            (unless register-p
              (incf stack-bytes bytes))
            (if (listp name)
              ; Skip this arg
              (unless register-p
                (incf skip-count bytes))
              ; Don't skip this arg
              (let* ((arg-type (if register-p
                                 (if (memq type *address-register-names*)
                                   :pointer
                                   :long)
                                 type))
                     (arg-type-code (cdr (assq arg-type *interrupt-encodings*))))
                (incf entry-bytes bytes)
                (incf arg-encoding (ash arg-type-code shift))
                (incf shift 2)
                (incf arg-count)
                (push name names)
                (setq code
                      (append (if register-p
                                (progn
                                  (unless (eq arg-type :long)
                                    (push name macptr-args))
                                  (cond ((eq type :a5) '(move.l (sp 4) a6@+))
                                        ((eq type :a6) '(move.l @sp a6@+))
                                        (t `((move.l ,(intern (symbol-name type) :ccl) a6@+)))))
                                (progn
                                  (unless (eql skip-count 0)
                                    (push `(sub.w ($ ,skip-count) a5) code)
                                    (setq skip-count 0))
                                  (cond ((eq type :word)
                                         (push name word-args)
                                         '((move.w -@a5 a6@+)))
                                        ((eq type :record-ptr)
                                         (push name macptr-args)
                                         (multiple-value-bind (code bytes) (record-ptr-code-68k type-arg)
                                           (incf entry-bytes (- bytes 4))
                                           (nreverse code)))
                                        (t (unless (eq type :long)
                                             (push name macptr-args))
                                           '((move.l -@a5 a6@+))))))
                              code))))))))
    (when timestamp-var
      (incf arg-encoding (ash 3 shift))
      (push timestamp-var names)
      (push timestamp-var macptr-args)
      (multiple-value-bind (timestamp-code bytes) (timestamp-code-68k)
        (incf entry-bytes bytes)
        (setq code (nreconc timestamp-code code))))
    (values arg-encoding arg-count (not (null timestamp-var)) (nreverse names) (nreverse code)
            stack-bytes
            (max entry-bytes 1)         ; 1 byte for no args
            `((type fixnum ,@(nreverse word-args))
              (type macptr ,@(nreverse macptr-args))))))

#-ppc-target
(defun record-ptr-code-68k (record-name-or-bytes)
  (let* ((bytes (if (fixnump record-name-or-bytes)
                  record-name-or-bytes
                  (record-field-length record-name-or-bytes)))
         (even-bytes (if (oddp bytes) (1+ bytes) bytes))
         (longs (floor bytes 4))
         (extra-words (floor (- bytes (* 4 longs)) 2))
         (extra-bytes (- bytes (* 4 longs) (* 2 extra-words)))
         (code nil))
    (push `(move.w ($ ,even-bytes) a6@+) code)
    (push `(spush a5) code)
    (push `(move.l -@a5 a5) code)
    ; Maybe this should generate a loop if longs is sufficiently big
    (dotimes (i longs)
      (push '(move.l a5@+ a6@+) code))
    (dotimes (i extra-words)
      (push '(move.w a5@+ a6@+) code))
    (dotimes (i extra-bytes)
      (push '(move.b a5@+ a6@+) code))
    (when (oddp extra-bytes)
      (push '(clr.b a6@+) code))
    (push '(spop a5) code)
    (push '(sub.l ($ 4) a5) code)
    (values (nreverse code) (+ 2 even-bytes))))

#-ppc-target
(defun timestamp-code-68k ()
  (values `((move.w ($ 8) a6@+)
            (spush a6)
            (dc.w #xA193)               ; _Microseconds
            (spop a6)
            (move.l a0 a6@+)
            (move.l d0 a6@+))
          10))
    

; The code generated for the PPC expects r12 to point at the args area of the stack
; and r13 to point at the parameter block area for the interrupt.
; clobbers R3 and R11.
#+ppc-target
(defun parse-interrupt-arglist (arglist)
  (let ((args arglist)
        names code word-args macptr-args
        (arg-encoding 0)
        (arg-count 0)
        (shift 0)
        (stack-bytes 0)
        (entry-bytes 0)
        (arg-register 3)
        (offset 0)
        (timestamp-var nil))
    (loop
      (when (null args) (return))
      (let* ((type (pop args))
             (type-arg (when (listp type)
                         (prog1 (cadr type)
                           (setq type (car type)))))
             (name (pop args))
             (bytes (if (eq type :word) 2 4)))
        (unless (memq type *valid-interrupt-arg-types*)
          (error "~s is not one of ~s" type *valid-interrupt-arg-types*))
        (unless (or (listp name) (symbolp name))
          (setq name (require-type name '(or list symbol))))
        (if (eq type :timestamp)
          (if timestamp-var
            (error "Duplicate :timestamp spec")
            (setq timestamp-var name))
          (progn
            (incf stack-bytes bytes)
            (unless (listp name)
              (let* ((arg-type type)
                     (arg-type-code (cdr (assq arg-type *interrupt-encodings*)))
                     (temp-register (if (> arg-register 10) 3 arg-register)))
                (incf entry-bytes bytes)
                (incf arg-encoding (ash arg-type-code shift))
                (incf shift 2)
                (incf arg-count)
                (push name names)
                (unless (eql arg-register temp-register)
                  (push `(lwz ,temp-register ,(* (- arg-register 3) 4) 12) code))
                (cond ((eq type :word)
                       (push name word-args)
                       (push `(sth ,temp-register ,offset 13) code)
                       (incf offset 2))
                      ((eq type :record-ptr)
                       (push name macptr-args)
                       (multiple-value-bind (record-ptr-code new-offset) (record-ptr-code-ppc temp-register offset type-arg)
                         (setq code (nreconc record-ptr-code code))
                         (incf entry-bytes (- (- new-offset offset) 4))
                         (setq offset new-offset)))
                      (t (unless (eq type :long)
                           (push name macptr-args))
                         (push `(stw ,temp-register ,offset 13) code)
                         (incf offset 4)))))
            (incf arg-register)))))
    (when timestamp-var
      (incf arg-encoding (ash 3 shift))
      (push timestamp-var names)
      (push timestamp-var macptr-args)
      (multiple-value-bind (timestamp-code bytes) (timestamp-code-ppc offset)
        (incf entry-bytes bytes)
        (setq code (nreconc timestamp-code code))))
    (values arg-encoding arg-count (not (null timestamp-var)) (nreverse names) (nreverse code)
            stack-bytes
            (max entry-bytes 1)         ; 1 byte for no args
            `((type fixnum ,@(nreverse word-args))
              (type macptr ,@(nreverse macptr-args))))))

#+ppc-target
(defun record-ptr-code-ppc (temp-register offset record-name-or-bytes)
  (let* ((bytes (if (fixnump record-name-or-bytes)
                  record-name-or-bytes
                  (record-field-length record-name-or-bytes)))
         (even-bytes (if (oddp bytes) (1+ bytes) bytes))
         (longs (floor bytes 4))
         (extra-words (floor (- bytes (* 4 longs)) 2))
         (extra-bytes (- bytes (* 4 longs) (* 2 extra-words)))
         (code nil)
         (temp-register-offset 0))
    (push `(li 11 ,even-bytes) code)
    (push `(sth 11 ,offset 13) code)
    (incf offset 2)
    ; Maybe this should generate a loop when longs is sufficiently big
    (dotimes (i longs)
      (push `(lwz 11 ,temp-register-offset ,temp-register) code)
      (push `(stw 11 ,offset 13) code)
      (incf temp-register-offset 4)
      (incf offset 4))
    (dotimes (i extra-words)
      (push `(lhz 11 ,temp-register-offset ,temp-register) code)
      (push `(sth 11 ,offset 13) code)
      (incf temp-register-offset 2)
      (incf offset 2))
    (dotimes (i extra-bytes)
      (push `(lbz 11 ,temp-register-offset ,temp-register) code)
      (push `(stb 11 ,offset 13) code)
      (incf temp-register-offset 1)
      (incf offset 1))
    (when (oddp extra-bytes)
      (incf offset))
    (values (nreverse code) offset)))

#+ppc-target
(defun timestamp-code-ppc (offset)
  (values `((li 3 8)
            (sth 3 ,offset 13)
            (mflr 3)
            (stw 3 ppc::c-frame.savelr sp)
            (stwu sp (- ppc::c-frame.size) sp)
            (stw rnil ppc::c-frame.savetoc sp)
            (lwz 3 pending-interrupts-offset rnil)
            (lwz 3 (get-field-offset :pending-interrupts-queue.Microseconds) 3)
            (lwz rnil 4 3)
            (lwz 3 0 3)
            (mtctr 3)
            (la 3 ,(incf offset 2) 13)
            (bctrl)
            (lwz rnil ppc::c-frame.savetoc sp)
            (la sp ppc::c-frame.size sp)
            (lwz 3 ppc::c-frame.savelr sp)
            (mtlr 3))
          10))

(defrecord simple-queue
  (overflow-count :long)
  (in :pointer)
  (out :pointer)
  (end :pointer)
  (data (array long 0)))

(defrecord pending-interrupts-queue
  (WakeUpProcess :ptr)                  ; (#_GetToolTrapAddress #_WakeUpProcess)
  (Microseconds :ptr)                   ; (%resolve-slep-address (get-shared-library-entry-point "Microseconds"))
  (psn (:ptr :ProcessSerialNumber))
  (currenta5 :ptr)
  (ptaskstate (:ptr PTaskState))
  (q :simple-queue))

(defrecord interrupt-queue
  (entry-size :long)                    ; number of bytes per entry
  (stack-bytes :long)                   ; number of bytes to pop off the stack
  (routine-number :word)                ; index into *interrupt-routines*
  (pending-interrupts (:pointer :pending-interrupts-queue))
  (q :simple-queue))

(defstruct interrupt
  routine                               ; the user function
  routine-name                          ; its name
  arg-encoding                          ; 2 bits per arg, :word, :long, or :ptr
  arg-count                             ; number of args to routine
  timestamp-p                           ; true if :timestamp specified
  stub                                  ; interrupt code from make-interrupt-stub
  code-lfun                             ; pass this to make-interrupt-stub
  queue                                 ; an interrupt-queue record
  entry-size                            ; size of an entry in the queue
  stack-bytes                           ; size of stack on interrupt entry
  queue-size                            ; elements in queue
  routine-number)                       ; index of this record in *interrupt-routines*

; Here's where the interrupt time work happens.
; Check for overflow and increment the overflow-count if so.
; Overflow causes the most recent interrupt to get overwritten.
; I'd prefer to keep the n most recent interrupts, but this would
; require changing the output pointer, which could cause problems
; if we interrupt in the middle of the code below which pulls data out.
; The queue-filler-code is the third value returned by
; parse-interrupt-arglist above. It is a bunch of move instructions
; that expect the following setup (68k):
;   a5 points just beyond the args on the stack
;   a6 points at the queue entry for this interrupt
;   (sp) = saved value of a6
;   (sp 4) = saved value of a5
; Or (PPC):
;   R12 points at the stack location for the first argument (24 words beyond the sp at function entry)
;   R13 points at the queue entry for this interrupt.
#-ppc-target
(defmacro interrupt-code (&rest queue-filler-code)
  ; the PREF lapop is only defined at compile time above.
  ; I'm trying to avoid making it necessary to load LAP at run time.
  (unless (gethash 'pref *lapops*)
    (let ((*record-source-file* nil))
      (deflapop pref (reg record-accessor)
        `(,reg (get-field-offset ,record-accessor)))))
  `(new-lap
    interrupt-queue
    (dc.w 0 0)
    pending-interrupts
    (dc.w 0 0)
    ; Here's the entry point: 8 bytes into the lfun.
    (clr.l -@sp)                        ; for stack-bytes
    (spush a5)
    (spush a6)
    (spush d0)
    (move.l (^ interrupt-queue) a5)
    (move.l (pref a5 :interrupt-queue.stack-bytes) d0)
    (move.l d0 (sp 12))
    (move.l (pref a5 :interrupt-queue.q.in) a6)
    (move.l a6 d0)
    (add.l (pref a5 :interrupt-queue.entry-size) d0)
    (if# (eq (cmp.l (pref a5 :interrupt-queue.q.end) d0))
      (pea (pref a5 :interrupt-queue.q.data))
      (spop d0))
    (if# (ne (cmp.l (pref a5 :interrupt-queue.q.out) d0))
      (move.l d0 (pref a5 :interrupt-queue.q.in))
      ; Push on the *pending-interrupts* queue
      (spush a5)
      (spush a6)
      (move.w (pref a5 :interrupt-queue.routine-number) -@sp)
      (move.l (^ pending-interrupts) a5)
      (move.l (pref a5 :pending-interrupts-queue.q.in) a6)
      (move.l a6 d0)
      (add.l ($ 2) d0)
      (if# (eq (cmp.l (pref a5 :pending-interrupts-queue.q.end) d0))
        (pea (pref a5 :pending-interrupts-queue.q.data))
        (spop d0))
      (if# (eq (cmp.l (pref a5 :pending-interrupts-queue.q.out) d0))
        ; *pending-interrupts* queue is full.
        (add.l ($ 1) (pref a5 :pending-interrupts-queue.q.overflow-count))
        (add.w ($ 2) sp)
        (spop a6)
        (spop a5)
        (add.l ($ 1) (pref a5 :interrupt-queue.q.overflow-count))
        (move.l a6 (pref a5 :interrupt-queue.q.in))
        (spop d0)
        (bra @return)
        else#
        ; Put the routine-number in the *pending-interrupts* queue
        (move.l d0 (pref a5 :pending-interrupts-queue.q.in))
        (move.w sp@+ @a6)
        (move.l (pref a5 :pending-interrupts-queue.ptaskstate) a6)
        (move.l (@ #.#$ticks) (pref a6 ptaskstate.nexttick))
        ; Trust noone. Take no prisoners.
        (movem.l #(a0 a1 a2 a3 a4 d1 d2 d3 d4 d5 d6 d7) -@sp)
        (spush a5)                   ; save pending interrupts queue
        (move.l (pref a5 :pending-interrupts-queue.currenta5) a5)
        (move.w ($ #x4ef9) a6)       ; jmp absolute
        ; If necessary, call MCL's vbl routine to make the periodic-task
        ; code run as soon as possible.
        ; Without something like this, we may end up waiting a whole tick
        ; (16.6 milliseconds) if an interrupt happens during MCL without-interrupts.
        ; *interrupt-level* value cell is nilreg relative in 2.0
        (move.l (a5 $nil) nilreg)
        (lea (special *interupt-level*) nilreg)
        (tst.w @nilreg)
        (if# (eq (if# mi
                   (tst.w (a5 $ipending))
                   else#
                   (cmp.w ($ $nop-instruction) (a5 $eventch_jmp))))
          ; Fake a VBL interrupt, but only if either
          ; 1) Lisp interrupts are disabled and the $ipending flag is clear
          ; 2) or Lisp interrupts are enabled and there is not a
          ;    JMP instruction at $eventch_jmp
          (bset ($ $invbl-bit) (@ #.#$VBLQueue))
          (sne -@sp)
          (move.l (a5 $vbltask1) a0)
          (move.w (pref a0 :vblTask.vblcount) -@sp)
          (spush a0)
          (move.l (pref a0 :vblTask.vbladdr) a1)
          (jsr @a1)
          (spop a0)
          (move.w sp@+ (pref a0 :vblTask.vblcount))
          (if# (eq (tst.b sp@+))
            (bclr ($ $invbl-bit) (@ #.#$VBLQueue))))
        (spop a5)                    ; pending-interrupts-queue
        ; If supported, (#_WakeUpProcess (pref a5 :pending-interrupts-queue.psn))
        (move.l (pref a5 :pending-interrupts-queue.wakeupProcess) d0)
        (if# ne
          (spush (pref a5 :pending-interrupts-queue.psn))
          ; I don't think this is necessary, but it's certainly safe
          (move.l (pref a5 :pending-interrupts-queue.currenta5) a5)
          (move.w ($ 60) -@sp)
          (move.l d0 a0)
          (jsr @a0))
        (movem.l sp@+ #(a0 a1 a2 a3 a4 d1 d2 d3 d4 d5 d6 d7))
        (spop a6)
        (spop a5))
      else#
      (add.l ($ 1) (pref a5 :interrupt-queue.q.overflow-count))
      (move.l (pref a5 :interrupt-queue.entry-size) d0)
      (sub.l d0 a6)
      (pea (pref a5 :interrupt-queue.q.data))
      (if# (eq (cmp.l sp@+ a6))
        (move.l (pref a5 :interrupt-queue.q.end) a6)
        (sub.l d0 a6)))
    (move.l (sp 12) d0)              ; stack-bytes
    (lea (sp d0 20) a5)              ; 4 longs plus return address
    (spop d0)
    ,@queue-filler-code
    @return
    (spop a6)
    (lea (sp 8) a5)
    (add.l (a5 -4) a5)
    (move.l (sp 8) @a5)             ; return address
    (move.l @sp -@a5)                ; saved a5
    (move.l a5 sp)
    (spop a5)
    (rts)))

; The TOC (r2=rnil) points at 3 pointers: interrupt-queue, pending-interrupts, & nil
#+ppc-target
(defmacro interrupt-code (&rest queue-filler-code)
  `(ppc-lap-function nil ()
    (let ((interrupt-queue-offset 0)
          (pending-interrupts-offset 4)
          (nil-offset 8)
          (interrupt-queue 11)
          (arg-ptr 12)
          (routine-number 12)
          (db-link 12)
          (q-ptr 13)
          (temp 14)
          (temp2 15)
          (pending-q-ptr 16)
          (interrupt-level-sym 16))
      (stw interrupt-queue ppc::c-frame.param0 sp)
      (stw arg-ptr ppc::c-frame.param1 sp)
      (stw q-ptr ppc::c-frame.param2 sp)
      (stw temp ppc::c-frame.param3 sp)
      (stw temp2 ppc::c-frame.param4 sp)
      (stw pending-q-ptr ppc::c-frame.param5 sp)
      (lwz interrupt-queue interrupt-queue-offset rnil)
      (lwz q-ptr (get-field-offset :interrupt-queue.q.in) interrupt-queue)
      (lwz temp (get-field-offset :interrupt-queue.entry-size) interrupt-queue)
      (add temp temp q-ptr)
      (lwz temp2 (get-field-offset :interrupt-queue.q.end) interrupt-queue)
      (cmpw cr0 temp temp2)
      (if (:cr0 :eq)
        (la temp (get-field-offset :interrupt-queue.q.data) interrupt-queue))
      (lwz temp2 (get-field-offset :interrupt-queue.q.out) interrupt-queue)
      (cmpw cr0 temp temp2)
      (if (:cr0 :ne)
        ; Room in interrupt-queue. Add a queue-entry
        (progn
          (stw temp (get-field-offset :interrupt-queue.q.in) interrupt-queue)
          ; Push on the *pending-interrupts* queue
          (lhz routine-number (get-field-offset :interrupt-queue.routine-number) interrupt-queue)
          (lwz interrupt-queue pending-interrupts-offset rnil)
          (lwz pending-q-ptr (get-field-offset :pending-interrupts-queue.q.in) interrupt-queue)
          (la temp 2 pending-q-ptr)
          (lwz temp2 (get-field-offset :pending-interrupts-queue.q.end) interrupt-queue)
          (cmpw cr0 temp temp2)
          (if (:cr0 :eq)
            (la temp (get-field-offset :pending-interrupts-queue.q.data) interrupt-queue))
          (lwz temp2 (get-field-offset :pending-interrupts-queue.q.out) interrupt-queue)
          (cmpw cr0 temp temp2)
          (if (:cr0 :eq)
            ; *pending-interrupts* queue is full.
            (progn
              (lwz temp (get-field-offset :pending-interrupts-queue.q.overflow-count) interrupt-queue)
              (addi temp temp 1)
              (stw temp (get-field-offset :pending-interrupts-queue.q.overflow-count) interrupt-queue)
              (lwz interrupt-queue interrupt-queue-offset rnil)
              (lwz temp (get-field-offset :interrupt-queue.q.overflow-count) interrupt-queue)
              (addi temp temp 1)
              (stw temp (get-field-offset :interrupt-queue.q.overflow-count) interrupt-queue)
              (stw q-ptr (get-field-offset :interrupt-queue.q.in) interrupt-queue)
              (mflr temp)
              (mtctr temp)
              (b @return))
            ; Put the routine-number in the *pending-interrupts* queue
            (progn
              (stw temp (get-field-offset :pending-interrupts-queue.q.in) interrupt-queue)
              (sth routine-number 0 pending-q-ptr)
              (lwz temp (get-field-offset :pending-interrupts-queue.ptaskstate) interrupt-queue)
              (li temp2 #.#$ticks)
              (lwz temp2 0 temp2)         ; temp2 = (#_TickCount)
              (stw temp2 (get-field-offset :ptaskstate.nexttick) temp)
              ; Make the lisp interrupt by setting *interrupt-level* or one of its bindings > 0.
              (lwz temp nil-offset rnil)
              (la interrupt-level-sym (ppc::nrs-offset *interrupt-level*) temp)
              (lwz temp2 ppc::symbol.vcell interrupt-level-sym)
              (cmpi cr0 temp2 0)
              (if (:cr0 :eq)
                (progn
                  (li temp2 '1)
                  (stw temp2 ppc::symbol.vcell interrupt-level-sym))
                (if (:cr0 :lt)
                  (progn
                    (la db-link (ppc::kernel-global db-link) temp)
                    (b @next)
                    @loop
                    (lwz temp 4 db-link)
                    (cmpw cr0 temp interrupt-level-sym)
                    (if (:cr0 :eq)
                      (progn
                        (lwz temp 8 db-link)
                        (cmpi cr0 temp 0)
                        (if (:cr0 :ge)
                          (progn
                            (if (:cr0 :eq)
                              (progn
                                (li temp '1)
                                (stw temp 8 db-link)))
                            (b @done)))))
                    @next
                    (lwz db-link 0 db-link)
                    (cmpi cr0 db-link 0)
                    (bne @loop)
                    @done))))))
        ; interrupt-queue is full, increment overflow count and overwrite last entry.
        (progn
          (lwz temp (get-field-offset :interrupt-queue.q.overflow-count) interrupt-queue)
          (addi temp temp 1)
          (stw temp (get-field-offset :interrupt-queue.q.overflow-count) interrupt-queue)
          (lwz temp (get-field-offset :interrupt-queue.entry-size) interrupt-queue)
          (sub q-ptr q-ptr temp)
          (la temp2 (get-field-offset :interrupt-queue.q.data) interrupt-queue)
          (cmpw cr0 temp2 q-ptr)
          (if (:cr0 :eq)
            (lwz q-ptr (get-field-offset :interrupt-queue.q.end) interrupt-queue)
            (sub q-ptr q-ptr temp))))
      (la arg-ptr ppc::c-frame.param0 sp)
      ,@queue-filler-code               ; may clobber R3 - R11
      ; (#_WakeUpProcess (pref pending-interrupts :pending-interrupts-queue.psn))
      (lwz interrupt-queue pending-interrupts-offset rnil)
      (lwz 3 (get-field-offset :pending-interrupts-queue.psn) interrupt-queue)
      (lwz temp (get-field-offset :pending-interrupts-queue.wakeupProcess) interrupt-queue)
      (lwz rnil 4 temp)
      (lwz temp 0 temp)
      (mtctr temp)
      ; restore registers
      @return
      (lwz interrupt-queue ppc::c-frame.param0 sp)
      (lwz arg-ptr ppc::c-frame.param1 sp)
      (lwz q-ptr ppc::c-frame.param2 sp)
      (lwz temp ppc::c-frame.param3 sp)
      (lwz temp2 ppc::c-frame.param4 sp)
      (lwz pending-q-ptr ppc::c-frame.param5 sp)
      (bctr))))

; interrupt-code is a macro instead of in-line so that people who
; macro-expand a define-interrupt-handler form will have less
; code to look at.
(defun make-interrupt-lfun (queue-filler-code)
  `(lambda (&lap 0)
     (interrupt-code ,@queue-filler-code)))

#|  ; Moved to "ccl:lib;windoids.lisp"

#+ppc-target
(eval-when (:compile-toplevel :execute :load-toplevel)

(eval-when (:compile-toplevel :execute)

(define-entry-point "MakeDataExecutable" ((address :ptr) (bytes :unsigned-long))
         nil)

)

(unless (fboundp 'lfun-to-ptr)

(defun lfun-to-ptr (lfun)
  (unless (functionp lfun)
    (setq lfun (require-type lfun 'function)))
  (let* ((code-vector (uvref lfun 0))
         (words (uvsize code-vector))
         (bytes (* 4 words))
         (ptr (#_NewPtr :errchk bytes)))
    (%copy-ivector-to-ptr code-vector 0 ptr 0 bytes)
    (MakeDataExecutable ptr bytes)
    ptr))


))

|#

#-ppc-target
(progn

(defun make-interrupt-code (code-lfun interrupt-queue)
  (let ((p (lfun-to-ptr code-lfun)))
    (setf (%get-ptr p) interrupt-queue
          (%get-ptr p 4) *pending-interrupts*)
    (%incf-ptr p 8)))

(defun dispose-interrupt-code (interrupt-code)
  (#_DisposePtr (%inc-ptr interrupt-code -8)))

; This stub is what is actually passed as the completion routine.
; The level of indirection is so that people can redefine their
; lisp code and automagically redefine
(defun make-interrupt-stub (interrupt-code arg-count arg-encoding)
  (declare (ignore arg-count arg-encoding))
  (let ((stub (lfun-to-ptr #'(lambda (&lap 0)
                               (new-lap
                                 code (dc.w 0 0)
                                 ; Done this way so we don't need to clear the cache
                                 (spush (^ code))
                                 (rts))))))
    (setf (%get-ptr stub) interrupt-code)
    (%incf-ptr stub 4)))

(defun interrupt-stub-pointer (interrupt-stub)
  (%inc-ptr interrupt-stub -4))

(defun dispose-interrupt-stub (interrupt-stub)
  (#_DisposePtr (%inc-ptr interrupt-stub -4)))

)

#+ppc-target
(progn

(defun make-interrupt-code (code-lfun interrupt-queue)
  (let* ((p (lfun-to-ptr code-lfun))
         (transition-vector (#_NewPtr :errchk 20))
         (toc (%inc-ptr transition-vector 8)))
    (%set-object toc 8 nil)
    (setf (%get-ptr toc) interrupt-queue
          (%get-ptr toc 4) *pending-interrupts*
          (%get-ptr transition-vector 0) p
          (%get-ptr transition-vector 4) toc)
    transition-vector))

(defun dispose-interrupt-code (interrupt-code)
  (#_DisposePtr (%get-ptr interrupt-code))
  (#_DisposePtr interrupt-code))

(defun decode-arg-encoding (arg-count arg-encoding)
  (let ((res nil))
    (dotimes (i arg-count)
      (let ((arg-type (logand 3 arg-encoding)))
        (push
         (ecase arg-type
           (0 :word)
           (1 :long)
           (2 :ptr)
           (3 :ptr))
         res)))
    (nreverse res)))

; The PPC interrupt stub is a Universal Procedure Pointer
(defun make-interrupt-stub (interrupt-code arg-count arg-encoding)
  (let* ((arg-types (decode-arg-encoding arg-count arg-encoding))
         (proc-info (make-proc-info arg-types nil)))
    (cons-routine-descriptor interrupt-code proc-info)))

(defun interrupt-stub-pointer (interrupt-stub)
  (%inc-ptr interrupt-stub
            (+ (get-field-offset :RoutineDescriptor.routineRecords)
               (get-field-offset :RoutineRecord.procDescriptor))))

(defun dispose-interrupt-stub (interrupt-stub)
  #-carbon-compat
  (#_DisposeRoutineDescriptor interrupt-stub)
  #+carbon-compat
  (#_disposeptr interrupt-stub))

)  ; end of #+ppc-target progn

(defun find-interrupt-named (name)
  (dotimes (i *interrupt-routines-count*)
    (let ((ir (svref *interrupt-routines* i)))
      (when (eq name (interrupt-routine-name ir))
        (return ir)))))

(defun install-interrupt (interrupt)
  (let* ((entry-size (interrupt-entry-size interrupt))
         (stack-bytes (interrupt-stack-bytes interrupt))
         (routine-number (interrupt-routine-number interrupt))
         (queue-size (interrupt-queue-size interrupt))
         (queue-bytes (* entry-size (1+ queue-size)))
         (queue-record-bytes (+ (record-length :interrupt-queue) queue-bytes))
         (old-queue (interrupt-queue interrupt))
         (stub (interrupt-stub interrupt))
         (code-lfun (interrupt-code-lfun interrupt))
         (arg-encoding (interrupt-arg-encoding interrupt))
         (arg-count (interrupt-arg-count interrupt))
         ; Need to cons a new queue so we can atomically replace the old one.
         (new-queue (#_NewPtr queue-record-bytes)))
    (initialize-interrupt-queue
     new-queue queue-bytes entry-size stack-bytes routine-number)
    (let* ((interrupt-code (make-interrupt-code code-lfun new-queue))
           (new-stub (if (macptrp stub)
                       (let ((stub-ptr (interrupt-stub-pointer stub)))
                         (with-macptrs ((old-code (%get-ptr stub-ptr)))
                           (setf (%get-ptr stub-ptr) interrupt-code)
                           (dispose-interrupt-code old-code)
                           stub))
                       (setf (interrupt-stub interrupt)
                             (make-interrupt-stub interrupt-code arg-count arg-encoding))))
           (name (interrupt-routine-name interrupt)))
      (when name
        (set name new-stub)))
    (setf (interrupt-queue interrupt) new-queue)
    (when (macptrp old-queue)
      (#_DisposePtr old-queue))
    interrupt))

(defun initialize-interrupt-queue (iq q-bytes entry-size stack-bytes routine-number)
  (setf (pref iq :interrupt-queue.entry-size) entry-size
        (pref iq :interrupt-queue.stack-bytes) stack-bytes
        (pref iq :interrupt-queue.routine-number) routine-number
        (pref iq :interrupt-queue.pending-interrupts) *pending-interrupts*)
  (initialize-simple-queue (pref iq :interrupt-queue.q) q-bytes)
  iq)

(defun initialize-simple-queue (sq bytes)
  (let ((data (pref sq :simple-queue.data)))
    (setf (pref sq :simple-queue.overflow-count) 0
          (pref sq :simple-queue.in) data
          (pref sq :simple-queue.out) data
          (pref sq :simple-queue.end) (%incf-ptr data bytes)))
  sq)

(defun make-pending-interrupts-queue (periodic-task entry-count)
  (unless (eq (type-of periodic-task) 'periodic-task)
    ; can't use require-type as periodic-task is not a first class type
    (error "~s is not a ~s" periodic-task 'periodic-task))
  (let* ((q-bytes (* 2 (1+ entry-count)))
         (record-bytes (+ (record-length :pending-interrupts-queue) q-bytes))
         (q (#_NewPtr record-bytes)))
    (setf (pref q :pending-interrupts-queue.ptaskstate)
          (ptask.state periodic-task))
    #-ppc-target
    (setf (pref q :pending-interrupts-queue.currenta5) (%currenta5))
    (setf (pref q :pending-interrupts-queue.psn) (or *ccl-psn* (%null-ptr)))
    (setf (pref q :pending-interrupts-queue.wakeUpProcess)
          (or *wakeup-process-address* (%null-ptr)))
    #+ppc-target
    (setf (pref q :pending-interrupts-queue.Microseconds)
          *microseconds-address*)
    (initialize-simple-queue (pref q :pending-interrupts-queue.q) q-bytes)
    q))

(defun %define-interrupt-handler (name queue-size arg-encoding arg-count timestamp-p
                                       stack-bytes entry-size
                                       user-function code-lfun)
  (unless queue-size
    (setq queue-size 10))
  (without-interrupts
   (let ((interrupt (and name (find-interrupt-named name)))
         new-routine-number)
     (unless interrupt
       (setq interrupt (make-interrupt :routine-name name)
             new-routine-number (or (pop *free-interrupt-numbers*)
                                    *interrupt-routines-count*))
       (let ((routines *interrupt-routines*))
         (unless (> (length routines) new-routine-number)
           (let ((new-routines (make-array (ceiling (* new-routine-number 1.5)) :initial-element nil)))
             (dotimes (i new-routine-number)
               (setf (svref new-routines i) (svref routines i)))
             (setq *interrupt-routines*
                   (setq routines new-routines))))
         (setf (svref routines new-routine-number) interrupt
               (interrupt-routine-number interrupt) new-routine-number)))
     (setf (interrupt-routine interrupt) user-function
           (interrupt-arg-encoding interrupt) arg-encoding
           (interrupt-arg-count interrupt) arg-count
           (interrupt-timestamp-p interrupt) timestamp-p
           (interrupt-code-lfun interrupt) code-lfun
           (interrupt-entry-size interrupt) entry-size
           (interrupt-stack-bytes interrupt) stack-bytes
           (interrupt-queue-size interrupt) queue-size)
     (install-interrupt interrupt)
     (when (and new-routine-number 
                (>= new-routine-number *interrupt-routines-count*))
       (setq *interrupt-routines-count* (1+ new-routine-number)))
     (or name
         (values (interrupt-stub interrupt) 
                 (interrupt-routine-number interrupt))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Here's the periodic task that invokes the user code
;;;

(defvar *interrupt-task* nil)

(defmacro processing-queue-entry ((entry-var q entry-size) &body body)
  (let ((thunk (gensym))
        (queue (gensym)))
    `(let ((,thunk #'(lambda (,entry-var) ,@body)))
       (declare (dynamic-extent ,thunk))
       (with-macptrs ((,queue ,q))
         (call-processing-queue-entry ,queue ,entry-size ,thunk)))))

(defun call-processing-queue-entry (q entry-size thunk)
  (unless (fixnump entry-size)
    (setq entry-size (require-type entry-size 'fixnum)))
  (unless (macptrp q)
    (setq q (require-type q 'macptr)))
  (locally (declare (type macptr q))
    (without-interrupts
     ; All these with-macptrs are to prevent consing. Really.
     (with-macptrs ((in (pref q :simple-queue.in))
                    (out (pref q :simple-queue.out)))
       (unless (eql in out)
         (unwind-protect
           (with-macptrs ((out out))    ; protect against %set-macptr on out
             (funcall thunk out))
           (%incf-ptr out entry-size)
           (with-macptrs ((end (pref q :simple-queue.end)))
             (if (eql out end)
               (with-macptrs ((data (pref q :simple-queue.data)))
                 (setf (pref q :simple-queue.out) data))
               (setf (pref q :simple-queue.out) out)))))))))

(defresource *macptr-resource*
  :constructor (%null-ptr))

(defvar *current-interrupt-queue*)

(defun interrupt-overflow-count ()
  (let ((queue *current-interrupt-queue*))
    (declare (type macptr queue)
             (optimize (speed 3) (safety 0)))
    ; Get it as a macptr first so that we don't cons a bignum before clearing it.
    (with-macptrs ((count-ptr (%get-ptr queue (get-field-offset :interrupt-queue.q.overflow-count))))
      (setf (pref queue :interrupt-queue.q.overflow-count) 0)
      (%ptr-to-int count-ptr))))

(defun interrupt-task ()
  (declare (optimize (speed 3) (safety 0)))
  (let* ((q *pending-interrupts*)
         done)
    (declare (type macptr q))
    (when q                             ; startup transient
      (unless (eql 0 (pref q :pending-interrupts-queue.q.overflow-count))
        (unwind-protect
          (error "~s queue overflowed. Not good." '*pending-interrupts*)
          (setf (pref q :pending-interrupts-queue.q.overflow-count) 0)))
      (loop
        (setq done t)
        (processing-queue-entry (in
                                 (the macptr (pref q :pending-interrupts-queue.q))
                                 2)
          (declare (type macptr in))
          (setq done nil)
          (let* ((routine-number (%get-word in))
                 (interrupt (svref *interrupt-routines* routine-number))
                 (queue (interrupt-queue interrupt))
                 (*current-interrupt-queue* queue))
            (declare (type macptr queue))
            (processing-queue-entry (p
                                     (the macptr (pref queue :interrupt-queue.q))
                                     (interrupt-entry-size interrupt))
              (declare (type macptr p))
              (let* ((arg-encoding (interrupt-arg-encoding interrupt))
                     (arg-count (if (interrupt-timestamp-p interrupt)
                                  (1+ (interrupt-arg-count interrupt))
                                  (interrupt-arg-count interrupt)))
                     (args (make-array arg-count))
                     (pointers (make-array arg-count))
                     (pointer-count 0))
                (declare (dynamic-extent args pointers))
                (declare (fixnum arg-count pointer-count arg-encoding)
                         (type simple-vector args pointers))
                (dotimes (i arg-count)
                  (let ((type (logand arg-encoding 3)))
                    (setf (svref args i)
                          (ecase type
                            (0 (%get-word p))   ; :word
                            (1 (%get-long p))   ; :long
                            (2 (with-macptrs ((ptr (%get-ptr p)))       ; :ptr
                                 ; All this to avoid consing a macptr
                                 ; Maybe we should recurse instead
                                 (prog1
                                   (setf (svref pointers pointer-count)
                                         (%setf-macptr
                                          (allocate-resource *macptr-resource*)
                                          ptr))
                                   (incf pointer-count))))
                            (3 (let ((size (%get-unsigned-word p)))     ; (:record-ptr size)
                                 (declare (fixnum size))
                                 (%incf-ptr p 2)
                                 (prog1
                                   (setf (svref pointers pointer-count)
                                         (%setf-macptr
                                          (allocate-resource *macptr-resource*)
                                          p))
                                   (incf pointer-count)
                                   (%incf-ptr p size))))))
                    (setq arg-encoding (ash arg-encoding -2))
                    (%incf-ptr p (cond ((eql type 0) 2)
                                       ((eql type 3) 0)
                                       (t 4)))))
                (applyv (interrupt-routine interrupt) args)
                (dotimes (i pointer-count)
                  (free-resource *macptr-resource* (svref pointers i)))))))
        (when done (return))))))      

(defun install-define-interrupt-handler ()
  (let ((psn (make-record :ProcessSerialNumber))
        (failed t))
    (unwind-protect
      (progn
        (setq *ccl-psn* nil
              *wakeup-process-address* nil)
        (when (getf *environs* :appleevents)      ; good test for process manager?
          (unless (eql 0 (#_GetCurrentProcess psn))
            (error "#_GetCurrentProcess failed."))
          (setq *ccl-psn* psn
                *wakeup-process-address*
                #-ppc-target (#_GetToolTrapAddress #_WakeUpProcess)
                #+ppc-target (%int-to-ptr
                              (ash (%resolve-slep-address (get-slep "WakeUpProcess"))
                                   ppc::fixnum-shift))))
        (setq failed nil))
      (when failed
        (#_DisposePtr psn))))
  #+ppc-target
  (setq *microseconds-address* 
        (%int-to-ptr
         (ash (%resolve-slep-address (get-shared-library-entry-point "Microseconds"))
              ppc::fixnum-shift)))
  (setq *pending-interrupts* nil)
  (setq *interrupt-task*
        (%install-periodic-task 'interrupt-task 'interrupt-task 3600))
  (setq *pending-interrupts*
        (make-pending-interrupts-queue *interrupt-task* 200))
  (let ((routines *interrupt-routines*))
    (dotimes (i *interrupt-routines-count*)
      (install-interrupt (svref routines i)))))

(def-load-pointers install-define-interrupt-handler ()
  (install-define-interrupt-handler))

(provide :define-interrupt-handler)

#|

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Test interrupt latency
;;; Note that you should never ff-call an interrupt routine
;;; unless you know that no asynchronous interrupt can
;;; call it at the same time. If an interrupt goes off while the
;;; ff-call'ed interrupt code is running, the data structures
;;; will likely become inconsistent and your Lisp will likely crash.
;;;
;;; I timed this at 406 microseconds on a IIfx.
;;; Not blindingly fast, but 2463 interrupts/second is fast
;;; enough for many applications.
;;; Also, the latency depends on the time spent in the longest
;;; periodic task, as periodic tasks cannot be interrupted.
;;; The latency timed at 68 miscroseconds on a PowerMac 9500.
;;;
;;; Actual latency will be worse than this as this code doesn't need
;;; to wait long for a function entry, backward branch, or exiting from
;;; without-interrupts. MCL (especially Fred) has quite a bit of code that
;;; executes without-interrupts, and this will affect the real latency.
;;;
;;; Also, see the comment about the Macintosh process manager at
;;; the top of this file.
;;;

(defvar *x* nil)

(define-interrupt-handler latency-interrupt (:word x)
  (if (>= x 1000)
    (setq *x* x)
    (ff-call latency-interrupt :word (1+ x))))

; Return the interrupt latency in milliseconds
(defun compute-interrupt-latency ()
  (let ((start-time (get-internal-run-time)))
    (setq *x* nil)
    (ff-call latency-interrupt :word 1)
    (loop (when *x* (return)))
    (let ((end-time (get-internal-run-time)))
      (/ (- end-time start-time) 1000.0 internal-time-units-per-second))))

(compute-interrupt-latency)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Example of using the :record-ptr & :timestamp argument types
;;;

; Convert a wide time as returned by #_Microseconds to milliseconds.
; If wide-start-time is specified, it is subtracted before the division by 1000.
#+ppc-target
(defun wide-time-to-milliseconds (wide-time &optional wide-start-time)
  (when wide-start-time
    (#_WideSubtract wide-time wide-start-time))
  (rlet ((remainder :long))
    (#_WideWideDivide wide-time 1000 remainder)
    (let ((res (+ (ash (%get-unsigned-long wide-time) 32) (%get-unsigned-long wide-time 4))))
      (let ((rem (%get-long remainder)))
        (declare (fixnum rem))
        (if (or (> rem 500) (and (eql rem 500) (oddp res)))
          (values (1+ res) (- rem 1000))
          (values res rem))))))

; My PPC, running emulated, doesn't know how to do the #_WideWideDivide or #_WideSubtract traps.
; Hence, this function conses on the 68K.
; You may have better luck on a real 68K machine, but you'll have to change the
; return type for both traps to NIL instead of :wide, since MCL's trap code doesn't know
; how to deal with the :wide return type.
#-ppc-target
(defun wide-time-to-milliseconds (wide-time &optional wide-start-time)
  (let ((time (+ (ash (%get-unsigned-long wide-time) 32) (%get-unsigned-long wide-time 4)))
        (start-time (and wide-start-time 
                         (+ (ash (%get-unsigned-long wide-start-time) 32) (%get-unsigned-long wide-start-time 4)))))
    (when start-time
      (setq time (- time start-time)))
    (round time 1000)))

(defparameter *start-time*
  (let ((time (#_NewPtr 8)))
    (#_Microseconds time)
    time))

(define-interrupt-handler record-ptr-test (:word x (:record-ptr 100) p :word y :timestamp time)
  (format t "Time: ~s, x: ~s, y: ~s, p: ~s"
          (wide-time-to-milliseconds time *start-time*)
          x
          y
          (%get-string p)))

(with-pstrs ((p "It works, by golly!"))
  (ff-call record-ptr-test :word 5 :ptr p :word 10))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; A simple asynchronous file copy.
;;; Only copies the data fork.
;;; Always overwrites an existing file.
;;; Does not do double bufferring.
;;; Will not really run asynchronously except when copying
;;; to floppies (and network volumes?) until the file manager is
;;; updated to use the new reentrant SCSI manager (and even then
;;; it won't be really asynchronous except on IIfx'es and Quadras
;;; that have SCSI DMA).

;; This code calls DEFINE-INTERRUPT-HANDLER with a null name,
;; so we need to explicitly require LAPMACROS in 68K MCL.
#-ppc-target
(eval-when (:compile-toplevel :execute)
  (require "LAPMACROS"))

(defun async-copy-file (from-file to-file done-thunk &optional (buffer-size 1024)
                                  debug)
  (setq to-file (merge-pathnames to-file from-file))
  (let ((from-namestring (mac-namestring from-file))
        (to-namestring (mac-namestring to-file)))
    (when (or (> (length from-namestring) 255)
              (> (length to-namestring) 255))
      (error "One of the file names is too long"))
    (unless (probe-file to-file)
      (create-file to-file))
    (let ((next-step nil)
          (from-pb (make-record (:ParamBlockRec :clear t)))
          (to-pb (make-record (:ParamBlockRec :clear t)))
          (buf (#_NewPtr :errchk buffer-size))
          (name (#_NewPtr :errchk 256))
          (listener (and debug (front-window :class 'listener)))
          handler handler-number error-code
          from-file-open to-file-open)
      (labels
        ((msg (msg)
           (when debug
             (format listener "~&~a~%" msg)
             (force-output listener)))
         (open-from-file ()
           (msg "Opening from file")
           (setq next-step #'open-to-file)
           (%put-string name from-namestring)
           (setf (pref from-pb :paramBlockRec.ioCompletion) handler
                 (pref from-pb :paramBlockRec.ioNamePtr) name
                 (pref from-pb :paramBlockRec.ioPermssn) #$fsRdPerm
                 (pref from-pb :paramBlockRec.iovRefnum)
                 (volume-number (mac-directory-namestring from-file)))
           (#_PBOpenAsync from-pb))
         (open-to-file ()
           (unless (check-error (pref from-pb :paramBlockRec.ioResult))
             (msg "Opening to file")
             (setq from-file-open t)
             (setq next-step #'start-io)
             (%put-string name to-namestring)
             (setf (pref to-pb :paramBlockRec.ioCompletion) handler
                   (pref to-pb :paramBlockRec.ioNamePtr) name
                   (pref to-pb :paramBlockRec.ioPermssn) #$fsWrPerm
                   (pref to-pb :paramBlockRec.iovRefnum)
                   (volume-number (mac-directory-namestring to-file)))
             (#_PBOpenAsync to-pb)))
         (start-io ()
           (unless (check-error (pref to-pb :paramBlockRec.ioResult))
             (msg "Starting IO")
             (setq to-file-open t)
             (setf (pref from-pb :paramBlockRec.ioBuffer) buf
                   (pref from-pb :paramBlockRec.ioReqCount) buffer-size
                   (pref from-pb :paramBlockRec.ioPosMode) #$fsFromStart
                   (pref to-pb :paramBlockRec.ioBuffer) buf
                   (pref to-pb :paramBlockRec.ioReqCount) buffer-size
                   (pref to-pb :paramBlockRec.ioActCount) buffer-size     ; fake out read-from-file
                   (pref to-pb :paramBlockRec.ioPosMode) #$fsFromStart)
             (read-from-file)))
         (read-from-file ()
           (unless (check-error (pref to-pb :paramBlockRec.ioResult))
             (msg "Reading")
             (if (< (pref to-pb :paramBlockRec.ioActCount) buffer-size)
               (close-to-file)
               (progn
                 (setq next-step #'write-to-file)
                 (#_PBReadAsync from-pb)))))
         (write-to-file ()
           (unless (check-error (pref from-pb :paramBlockRec.ioResult))
             (msg "Writing")
             (let ((bytes (pref from-pb :paramBlockRec.ioActCount)))
               (when (< bytes buffer-size)
                 (when (eql 0 bytes)
                   (close-to-file))
                 (setf (pref to-pb :paramBlockRec.ioReqCount) bytes)))
             (setq next-step #'read-from-file)
             (#_PBWriteAsync to-pb)))
         (close-to-file ()
           (unless (check-error (pref from-pb :paramBlockRec.ioResult))
             (msg "Closing to file")
             (setq next-step #'flush-volume)
             (setq to-file-open nil)
             (#_PBCloseAsync to-pb)))
         (flush-volume ()
           (unless (check-error (pref to-pb :paramBlockRec.ioResult))
             (msg "Flushing to volume")
             (setq next-step #'close-from-file)
             (#_PBFlushVolAsync to-pb)))
         (close-from-file ()
           ; always called synchronously, so don't check-error
           (msg "Closing from file")
           (setq next-step #'finish-up)
           (setq from-file-open nil)
           (#_PBCloseAsync from-pb))
         (finish-up ()
           (unless (check-error (pref to-pb :paramBlockRec.ioResult))
             (msg "Finishing up")
             (#_DisposePtr from-pb)
             (#_DisposePtr to-pb)
             (#_DisposePtr buf)
             (#_DisposePtr name)
             (delete-interrupt-number handler-number)
             (funcall done-thunk error-code)))
         (check-error (code)
           ; Return non-NIL if there was an error
           (unless (or (eql code #$noErr) (eql code #$eofErr))
             (msg (format nil "Error code #~s" code))
             (unless error-code
               (setq error-code code))
             (setf (pref from-pb :paramBlockRec.ioResult) #$noErr
                   (pref to-pb :paramBlockRec.ioResult) #$noErr)
             (cond (to-file-open (close-to-file))
                   (from-file-open (close-from-file))
                   (t (finish-up)))
             t)))
        (multiple-value-setq (handler handler-number)
          (define-interrupt-handler nil ()
            (funcall next-step)))
        (when debug 
          (inspect (svref ccl::*interrupt-routines* handler-number))
          (locally (declare (special *open-from-file*))
            (setq *open-from-file* #'open-from-file)))
        (open-from-file)))))

(async-copy-file "ccl:examples;define-interrupt-handler.lisp"
                 ; double ";" means :UP. This file is "ccl:temp.lisp", and it will stay
                 ; that way through merge-pathnames
                 "ccl:examples;;temp.lisp"
                 #'(lambda (error-code)
                     (format (front-window :class 'listener)
                             "~&Done: ~s~%" error-code))
                 ;1024 t        ; uncomment to see progress reports
                 )

|#
