;;;-*-Mode: LISP; Package: ccl -*-

;;	Change History (most recent first):
;;  $Log: ppc-stack-groups.lisp,v $
;;  Revision 1.11  2006/02/03 03:28:22  alice
;;  ;; dont remember
;;
;;  Revision 1.10  2005/07/02 10:31:07  alice
;;  ; add %remove-tmtask and %restore-tmtask, use in stack-group-resume because tmtask may barf on 10.4 with dual-processor
;;
;;  Revision 1.9  2003/11/14 16:55:44  alice
;;  no change
;;
;;  Revision 1.8  2003/07/10 18:46:54  alice
;;  tweaks to bogus-thing-p
;;
;;  Revision 1.7  2003/07/01 04:10:04  alice
;;  fix bogus-thing-p etal
;;
;;  Revision 1.6  2003/02/27 11:59:06  gtbyers
;;  Don't lock binding stack on return from xYieldToThread in STACK-GROUP-RESUME (now happnns in kernel)
;;
;;  Revision 1.5  2003/02/25 22:32:39  gtbyers
;;  More (slight) binding-stack locking changes.  Zero db-link global when saving outgoing stack-group context.
;;
;;  Revision 1.4  2003/02/13 00:46:40  gtbyers
;;  Binding stack locking changes.
;;
;;  27 1/22/97 akh  make-stack-group has optional args for all 3 stack sizes
;;  15 3/19/96 bill 3.1d82
;;  1 11/16/95 bill New file
;;  (do not edit before this line!!)


; l1-ppc-stack-groups.lisp
; low-level support for PPC stack groups and stack-backtrace printing
; Copyright 1995-2001, Digitool, Inc.

;; comment out unused unhold-current-hold-next
;; --------- 5.2b6
;; add %remove-tmtask and %restore-tmtask, use in stack-group-resume because tmtask may barf on 10.4 with dual-processor
;;    -- not sure if it helps
;; ----------- 5.1 final
;; nth-value-in-frame - let's not crash on OSX, bogus-thing-p ditto
;; ------------- 5.0 final
;; min and initial tsp and vsp sizes also bigger if osx-p
;; ------- 4.4b4
;; bump *cs-segment-size* if osx-p, also *min-sp-stack-size*, lose "sucks" in initialize-sg-cs-area
;;-------------- 4.4b3
;; 08/11/01 better crock response for os 9.1
;; 07/05/01 akh see do-9.1-crock
;; 05/15/01 akh bottom-of-stack-p re osx
;; 04/24/01 akh see initialize-sg-cs-area re osx-p sucks
;; 04/11/01 akh see gaak re osx-p in new-stack-group-thread
;; 02/26/01 akh tweak re threadslib
;; 03/30/00 akh no mo threadslib if carbon - TWAS NOT THE REAL PROBLEM
;;12/01/99 akh nth-value-in-frame - ignore-errors, fix set-nth-value-in-frame too
;; 11/13/99 akh nth-value-in-frame dtrt with value cells, bogus-thing-p re value-cells
;; ------------ 4.3f1c1
;; 03/13/97 bill Bump *cs-segment-size* to 32768.
;;               A new segment costs 40K of overflow space, so using just 8K is ridiculous.
;; 03/12/97 bill Mucho changes to %cs-overflow-callback & friends.
;;               Make the savevsp the same as the one in the overflow frame in the other stack segment.
;;               Copy loc-pc from the xframe so that lexpr entry frame overflow will work.
;;               Push a dummy TSP frame. If the user code pops it, splice out the TSP frame below
;;               the unwind-protect frame pushed by %cs-overflow-callback.
;;               Splice the lexpr entry frames that are copied into the new stack area out of
;;               the linked list in the old stack area.
;;               Properly deal with overflow function expected to return multiple values or not.
;;               %ptr-in-area-p allows (>= area.high ptr) not just (> area.high ptr).
;; 03/07/97 bill Stop the debugging code in %copy-throw-context-to-exception-frame from
;;               clobbering arg_z.
;; 03/07 97 bill cfp-lfun returns nil in the case where the LR is not inside the function vector.
;;               For a fake-stack-frame, this has already been determined and is denoted
;;               by a macptr instead of a fixnum in fake-stack-frame.lr.
;; 03/09/97 gb   define-ppc-pascal-function -> define-ppc-pascal-function-2.
;; 02/23/97 bill cs-overflow-callback & friends.
;; 02/19/97 bill stack-group-preset stores the threadid in the cs-area structure.
;;               So does (def-ccl-pointers *initial-stack-group* ...)
;; 02/13/97 bill *cs-segment-size*, *ts-segment-size*, *vs-segment-size*
;; 01/23/97 bill last-frame-ptr passes the stack-group to %get-frame-ptr
;; ------------- 4.0
;; 10/11/96 bill add 8K to each of *cs-soft-overflow-size* & *cs-hard-overflow-size*
;;               This stops (defun foo (&rest args) (declare (dynamic-extent args)) (apply #'foo args))
;;               in an init file from crashing the machine when called with (foo 1 2 3 4 5 6 7).
;; ------------- 4.0f1
;; 08/21/96 bill remove an absolete comment from before handle-stack-group-interrupts
;; ------------- 4.0b1
;; 07/31/96 bill (def-ccl-pointers *initial-stack-group* ...) says (upp-transition-vector ...)
;;               instead of (pref ...)
;; 07/26/96 bill sg-nested-interrupt installs the old-fn.args in sg.interrupt-fn.args
;;               after instead of before applying fn to args. This aborts the pending
;;               interrupts if an interrupt throws out.
;; 07/11/96 bill vsp-limits special cases the unwind-protect cleanup frame and the frame it will return to.
;; 07/09/96 bill memoize the symbol value store in %reverse-special-bindings,
;;               unmemoize the db-link store (it's a fixnum).
;; 07/05/96 bill count-db-links-in-frame works with segmented VSP stack.
;; 06/26/96 bill make-stack-group sets the sg.maxsize slot.
;;               stack-group-maximum-size, (setf stack-group-maximum-size)
;; 06/25/96 bill threadEntry does (set-global rzero xframe)
;; 06/19/96 bill vsp-limits ensures that the returned parent-vsp is in the same stack segment as
;;               the returned vsp.
;; 06/18/96 bill %ptr-to-vstack-p and %on-tsp-stack use (new) %active-area and %ptr-in-area-p
;;               to find the relevant stack segment.
;; 06/17/96 bill stack-group-resume calls %ensure-vsp-stack-space to prevent a
;;               stack overflow error on its call to YieldToThread.
;;               %save-stack-group-context searches for current vs-area and ts-area.
;;               terminate-stack-groups calls delete-unused-stack-areas.
;; 05/17/96 bill (def-ccl-pointers *thread-manager-present-p* ...) ignores the
;;               #$gestaltThreadsLibraryPresent bit. It assumes the library is present
;;               if it succeeds in opening it. This makes machines work that need to use
;;               the ThreadsLib that we provide.
;; ------------- MCL-PPC 3.9
;; 04/10/96 gb   don't enable underflow.
;; 04/08/96 bill Reverse last two args in %fixnum-set so that (setf (%fixnum-ref ...) ...) will work.
;;               (%fixnum-set ...) -> (setf (%fixnum-ref ...) ...) throughout.
;; 04/04/96 bill do-db-links & map-db-links
;; 03/27/96 bill count-values-in-frame and nth-value-in-frame-loc ignore
;;               stack consed value cells.
;;               New functions:
;;                 count-stack-consed-value-cells-in-frame
;;                 in-stack-consed-value-cell-p
;;                 %value-cell-header-at-p
;;                 %fixnum-address-of
;; 03/21/96 gb   bogus-thing-p checks for bogus headers.
;; 03/18/96 bill bogus-thing-p recognizes stack consed value cells on the vsp stack.
;;               Make sure that ThreadsLib exists before setting *thread-manager-present-p*
;; 03/17/96 gb   memoize the setf in threadEntry
;; 03/14/96 bill %catch-top returns nil instead of 0 if there is no catch frame
;; 03/06/96 bill db-link signals an error if the stack group is exhausted.
;; 03/01/96 bill do-unexhausted-stack-groups
;; 03/01/96 gb   threadEntry initializes FPSCR
;; 02/28/96 bill sg.next & sg.prev are no more.
;;               *stack-group-population* is now terminatable and terminate-stack-groups
;;               handles the termination.
;; 02/27/96 bill terminate-when-unreachable and friends.
;; 02/20/96 bill eliminate uses of execute-in-stack-frame; it seems to get interrupted
;;               at bad times causing the stack backtrace window to freeze up.
;;               stack-group-preset kills the stack group before sampling (sg.prev current)
;;               to ensure that the stack group is not its own previous stack group
;; 02/16/96 bill handle fake-stack-frame's. Look for them on the *fake-stack-frames* list.
;; 02/15/96 bill next-lisp-frame. bottom-of-stack-p allows one more frame.
;; 02/13/96 bill in stack-group-resume, the %reverse-special-bindings calls go inside
;;               the catch in case it causes a tsp stack overflow.
;;               %reverse-special-bindings takes a new set-db-link-p, passed as NIL
;;               when swapping out of a stack group and true when swapping back in.
;;               If NIL, set db-link to 0 before reversing the bindings to prevent
;;               the VBL task from mucking with the wrong *interrupt-level* binding.
;;               If true, set db-link after the bindings have been reversed to prepare
;;               it for the throw out of the catch in stack-group-resume.
;;               It would be nice to have some sort of flag for the VBL task so
;;               that it would know to muck with the other end of the binding chain,
;;               but db-link is only 0 for a hundred microseconds so a 60hz interrupt
;;               isn't going to be missed very often.
;; 02/07/96 bill stack-group-preset passes in old value of *top-listener* so that
;;               (toplevel) won't cause a new listener to pop up.
;; 02/06/96 bill sg.initial-function.args so that we can restart stack groups after save-application
;;               shutdown-stack-groups
;; 02/05/96 bill lower minimum stack sizes.
;; 01/31/96 bill *intentional-single-process-p*.
;;               *single-process-p* moves here from l1-boot.
;; 01/31/96 bill stack group implementation complete.
;; 01/24/96 bill ppc-defun -> defun throughout.
;; 01/23/96 bill %fixnum-ref & %fixnum-set take an optional (byte) offset arg.
;; 02/02/96 gb   double-colon on ppc::t-offset
;; 01/17/96 bill *thread-manager-present-p*
;; 01/16/96 bill fencepost in nth-value-in-frame-loc
;; 01/05/96 bill add and ignore optional child arg to count-values-in-frame.
;;               frame-vsp, %stack<
;; 01/04/96 bill parent-frame needs to include kernel frames or stack backtrace doesn't work.
;;               We'll remove these at a higher level.
;; 01/01/96 gb   add important clarification.
;; 12/19/95 bill *current-sgbuf*, sg-buffer
;;               parent-frame ignores catch frames & frames with unknown saved fn
;; 12/18/95 bill set-nth-value-in-frame
;; 12/13/95 bill count-values-in-frame & nth-value-in-frame use new
;;               vsp-limits function which accounts for "dummy" stack frames.
;;               count-values-in-frame returns two extra values and
;;               count-values-in-frame accepts two additional optional args
;;               to avoid walking the stack every time.
;;               New %dummy-frame-p function identifies a dummy frame.
;; 12/08/95 bill last-frame-ptr takes an optional stack-group arg
;;               %frame-savevsp clears the lsb to eliminate the "dummy frame" marker
;;               Say "check-nargs" instead of "twnei nargs"
;;               Dummy stack-group-p for %lfun-name-string's benefit
;; 12/06/95 bill *current-stack-group*, %stack-group-exhausted-p,
;;               symbol-value-in-stack-group move here from l1-processes.
;;               dummy (setf symbol-value-in-stack-group) so quit can work.
;;               parent-frame compares frame-size properly.
;;               %frame-backlink interprets bits 0 & 1 of backlink
;; 11/30/95 bill last-frame-ptr, child-frame

(in-package :ccl)

; To keep me from inadvertently overwriting the 68K defs while debugging.
; And to keep meta-. from ever finding anything.
(defmacro ppc-defun (name args &body body)
  (let* ((setf-p (and (consp name) (eq (car name) 'setf)))
         (real-name (if (ppc-target-p) 
                     name
                     (ppc::form-symbol (if setf-p (cadr name) name) "/PPC"))))
    (when (and setf-p (neq name real-name))
      (setq real-name `(setf ,real-name)))
    `(defun ,real-name ,args ,@body)))

#+ppc-target
(progn

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Stack groups
;;;

; A stack group is tagged as a function.
; It's code vector trampolines to code that switches stack groups
(def-accessors (stack-group) %svref
  sg.code-vector                        ; The trampoline code
  sg.%funcall-stack-group               ; #'%funcall-stack-group
  ;-- Above here fixed due to code requirements
  sg.name                               ; a string
  sg.resumer                            ; my resumer, another stack group
  sg.cs-area                            ; control stack area
  sg.vs-area                            ; value stack area
  sg.ts-area                            ; temp stack area
  sg.cs-overflow-limit                  ; control stack overflow limit
  sg.threadID                           ; thread manager ID or #$kNoThreadID
  sg.cs-size                            ; initial control stack size
  sg.vs-size                            ; initial value stack size
  sg.ts-size                            ; initial temp stack size
  sg.maxsize                            ; unused, allow for stack segmentation
  sg.interrupt-function.args            ; for stack-group-interrupt
  sg.initial-function.args              ; so we can startup after save-application
  sg.vs-overflow-limit
  sg.ts-overflow-limit
  ;-- sg.lfun-bits must be last
  sg.lfun-bits                          ; lfun-bits
  sg.element-count
  )

; Set to true to make the Lisp startup with a single process.
; That process will be both event processor and the initial listener.
(defparameter *intentional-single-process-p* nil)

(defloadvar *held-threads* nil)

; This is true if *intentional-single-process-p* is true or the thread manager is not present.
; It is initialized by the def-ccl-pointers below.
(defvar *single-process-p* nil)

; It already has a value of NIL when this code runs.
(defvar *thread-manager-present-p* nil)

(def-ccl-pointers *thread-manager-present-p* ()
  #-Carbon-compat
  (progn
    (install-a78)                         ; make "g @a78" work in MacsBug
    (let ((attr (gestalt #$gestaltThreadMgrAttr)))
      (setq *thread-manager-present-p*
            (and attr
                 (fixnump attr)
                 (locally (declare (fixnum attr))
                   (and
                    (logbitp #$gestaltThreadMgrPresent attr)
                    ; This is not true on some machines that really have the library
                    (or (logbitp #$gestaltThreadsLibraryPresent attr)
                        #-carbon-compat
                        (get-shared-library "ThreadsLib" :error-p nil))))))
      (setq *single-process-p*
            (or *intentional-single-process-p*
                (not *thread-manager-present-p*)))
      #-carbon-compat
      (when *thread-manager-present-p*
        (add-to-shared-library-search-path "ThreadsLib"))))
  #+carbon-compat
  (progn
    (setq *thread-manager-present-p* t)
    (setq *single-process-p* (or *intentional-single-process-p*))))


; Allocate a tstack area with at least useable-bytes
; Returns a fixnum encoding the address of an area structure.
(defun allocate-tstack (useable-bytes)
  (with-macptrs ((tstack (ppc-ff-call (%kernel-import ppc::kernel-import-allocate_tstack)
                                      :unsigned-fullword (logand (+ useable-bytes 4095) -4096)
                                      :address)))
    (when (%null-ptr-p tstack)
      (error "Can't allocate tstack"))
    (%fixnum-from-macptr tstack)))

; Allocate a vstack area with at least useable-bytes
; Returns a fixnum encoding the address of an area structure.
(defun allocate-vstack (useable-bytes)
  (with-macptrs ((vstack (ppc-ff-call (%kernel-import ppc::kernel-import-allocate_vstack)
                                      :unsigned-fullword (logand (+ useable-bytes 4095) -4096)
                                      :address)))
    (when (%null-ptr-p vstack)
      (error "Can't allocate vstack"))
    (%fixnum-from-macptr vstack)))

; Create a new, empty control stack area
; Returns a fixnum encoding the address of an area structure.
(defun new-cstack-area ()
  (with-macptrs ((cstack (ppc-ff-call (%kernel-import ppc::kernel-import-register_cstack)
                                      :unsigned-fullword 0   ; address
                                      :unsigned-fullword 0   ; size
                                      :address)))
    (when (%null-ptr-p cstack)
      (error "Can't allocate cstack"))
    ; Prevent stack overflow of infant stack group
    ; (Actually, I don't think this is necessary)
    (setf (pref cstack :gc-area.softlimit) (%null-ptr)
          (pref cstack :gc-area.hardlimit) (%null-ptr))
    (%fixnum-from-macptr cstack)))

; Free the result of allocate-tstack, allocate-vstack, or register-cstack
(defun free-stack-area (stack-area)
  (with-macptrs ((area-ptr (%null-ptr)))
    (%setf-macptr-to-object area-ptr stack-area)
    (ppc-ff-call (%kernel-import ppc::kernel-import-condemn-area)
                 :address area-ptr
                 :void))
  nil)

(defppclapfunction %get-kernel-global-from-offset ((offset arg_z))
  (check-nargs 1)
  (unbox-fixnum imm0 offset)
  (lwzx arg_z imm0 rnil)
  (blr))

(defppclapfunction %set-kernel-global-from-offset ((offset arg_y) (new-value arg_z))
  (check-nargs 2)
  (unbox-fixnum imm0 offset)
  (stwx new-value imm0 rnil)
  (blr))

(defun %kernel-global-offset (name-or-offset)
  (if (fixnump name-or-offset)
    name-or-offset
    (ppc::%kernel-global name-or-offset)))

(defun %kernel-global-offset-form (name-or-offset-form)
  (cond ((and (listp name-or-offset-form)
              (eq 'quote (car name-or-offset-form))
              (listp (cdr name-or-offset-form))
              (symbolp (cadr name-or-offset-form))
              (null (cddr name-or-offset-form)))
         (ppc::%kernel-global (cadr name-or-offset-form)))
        ((fixnump name-or-offset-form)
         name-or-offset-form)
        (t `(%kernel-global-offset ,name-or-offset-form))))

; This behaves like a function, but looks up the kernel global
; at compile time if possible. Probably should be done as a function
; and a compiler macro, but we can't define compiler macros yet,
; and I don't want to add it to "ccl:compiler;optimizers.lisp"
(defmacro %get-kernel-global (name-or-offset)
  `(%get-kernel-global-from-offset ,(%kernel-global-offset-form name-or-offset)))

(defmacro %set-kernel-global (name-or-offset new-value)
  `(%set-kernel-global-from-offset
    ,(%kernel-global-offset-form name-or-offset)
    ,new-value))

; If you change this, you need to change the ppc::%sg.funcall-stack-group
; slot in all stack groups, or they won't get the new definition.
(defun %funcall-stack-group (stack-group arg)
  (setf (sg.resumer stack-group) *current-stack-group*)
  (stack-group-resume stack-group arg))

(defppclapfunction %stack-group-trampoline ((arg arg_z))
  (check-nargs 1)
  (mr arg_y nfn)
  (set-nargs 2)
  (lwz temp0 2 nfn)
  (ba .SPfuncall))

(setf (sg.%funcall-stack-group #'%stack-group-trampoline) #'%funcall-stack-group)

(defvar *stack-group-code-vector*
  (%svref #'%stack-group-trampoline 0))

(defun %cons-stack-group (name)
  (let ((sg (make-uvector sg.element-count ppc::subtag-function
                          :initial-element nil)))
    (setf (sg.code-vector sg) *stack-group-code-vector*
          (sg.%funcall-stack-group sg) #'%funcall-stack-group
          (sg.name sg) name
          (sg.threadID sg) #$kNoThreadID
          (sg.lfun-bits sg) (logior (ash 1 $lfbits-trampoline-bit)
                                         (dpb 1 $lfbits-numreq 0)))
    sg))

(defun stack-group-p (sg)
  (and (functionp sg)
       (eq (%svref sg 0) *stack-group-code-vector*)))

(setf (type-predicate 'stack-group) 'stack-group-p)

(defmethod print-object ((sg stack-group) stream)
  (print-stack-group sg stream nil))

(defun print-stack-group (sg stream suppress-address)
  (print-unreadable-object (sg stream :type t :identity (not suppress-address))
    (format stream "~s" (sg.name sg))))

(defppclapfunction %fixnum-ref ((fixnum arg_y) #| &optional |# (offset arg_z))
  (cmpi cr2 nargs '1)
  (check-nargs 1 2)
  (bne cr2 @2-args)
  (mr fixnum offset)
  (li offset 0)
  @2-args
  (unbox-fixnum imm0 offset)
  (lwzx arg_z imm0 fixnum)
  (blr))

(defppclapfunction %fixnum-set ((fixnum arg_x) (offset arg_y) #| &optional |# (new-value arg_z))
  (cmpi cr2 nargs '2)
  (check-nargs 2 3)
  (bne cr2 @3-args)
  (mr fixnum offset)
  (li offset 0)
  @3-args
  (unbox-fixnum imm0 offset)
  (stwx new-value imm0 fixnum)
  (mr arg_z new-value)
  (blr))

; Sure would be nice to have &optional in defppclapfunction arglists
(let ((bits (lfun-bits #'(lambda (x &optional y) (declare (ignore x y))))))
  (lfun-bits #'%fixnum-ref
             (dpb (ldb $lfbits-numreq bits)
                  $lfbits-numreq
                  (dpb (ldb $lfbits-numopt bits)
                       $lfbits-numopt
                       (lfun-bits #'%fixnum-ref)))))

(let ((bits (lfun-bits #'(lambda (x y &optional z) (declare (ignore x y z))))))
  (lfun-bits #'%fixnum-set
             (dpb (ldb $lfbits-numreq bits)
                  $lfbits-numreq
                  (dpb (ldb $lfbits-numopt bits)
                       $lfbits-numopt
                       (lfun-bits #'%fixnum-set)))))

; The number of bytes in a consing (or stack) area
(defun %area-size (area)
  (ash (- (%fixnum-ref area ppc::area.high)
          (%fixnum-ref area ppc::area.low))
       2))

(defvar *current-stack-group*)

(unless *current-stack-group*
  (setq *current-stack-group* (%cons-stack-group "Initial")))

(defvar *initial-stack-group* *current-stack-group*)

; The stack group that will be active on "return" from #_YieldToThread
(defvar *next-stack-group* nil)

; The argument passed to stack-group-resume
(defvar *resume-stack-group-arg* nil)

; 32K fails to compile this file
(defparameter *min-sp-stack-size* (ash 1 20))
(defparameter *min-vsp-stack-size* (ash 1 20))
(defparameter *min-tsp-stack-size* (ash 1 19))

(def-ccl-pointers min-sp ()
  (if (osx-p)
    (progn 
      (setq *min-sp-stack-size* (* 1024 1024))
      (setq *min-vsp-stack-size* (* 1024 1024))  ;; or bigger yet ?
      (setq *min-tsp-stack-size* (* 512 1024)))
      
    (progn
      (setq *min-sp-stack-size* (ash 16 10))
      (setq *min-vsp-stack-size* (ash 16 10))
      (setq *min-tsp-stack-size* (ash 32 10)))))



(defvar *stack-group-population*
  (%cons-population (list *initial-stack-group*) $population_weak-list t))

(defun terminate-stack-groups ()
  (let ((population *stack-group-population*)
        list)
    (loop
      (without-interrupts
       (setq list (population-termination-list population))
       (unless list (return))
       (setf (population-termination-list population) (cdr list)
             (cdr list) nil))
      (kill-stack-group (car list)))
    (delete-unused-stack-areas)))

; This needs to be in LAP so that it won't vpush anything
(defun %db-link-chain-in-area-p (area &optional (sg *current-stack-group*))
  (let ((db (db-link sg))
        (high (%fixnum-ref area ppc::area.high))
        (low (%fixnum-ref area ppc::area.low)))
    (declare (fixnum db high low))
    (loop
      (when (eql 0 db) (return nil))
      (when (and (<= low db) (< db high))
        (return t))
      (setq db (%fixnum-ref db)))))

; This version is in LAP so that it won't vpush anything
(defppclapfunction %db-link-chain-in-current-sg-area ((area arg_z))
  (check-nargs 1)
  (let ((db imm0)
        (high imm1)
        (low imm2))
    (lwz high ppc::area.high area)
    (lwz low ppc::area.low area)
    (ref-global db db-link)
    (cmpwi cr0 db 0)
    (b @test)
    @loop
    (cmplw cr1 db low)
    (cmplw cr2 db high)
    (lwz db 0 db)
    (cmpwi cr0 db 0)
    (blt cr1 @test)
    (bge cr2 @test)
    (la arg_z ppc::t-offset rnil)
    (blr)
    @test
    (bne cr0 @loop)
    (mr arg_z rnil)
    (blr)))

; Don't free stack oreas that contain part of the db_link chain.
(defun delete-unused-stack-areas ()
  (without-interrupts
   (do-unexhausted-stack-groups (sg)
     (macrolet ((do-area (sg.area &optional check-db-link)
                  `(let* ((current-p (eq sg *current-stack-group*))
                          area younger ,@(and check-db-link '(a)))
                     ; It's important that if sg is the current stack group,
                     ; then this code does no vsp or tsp pushes until the free-stack-area call.
                     (when current-p
                       (%normalize-areas))
                     (setq area (,sg.area sg)
                           younger (%fixnum-ref area ppc::area.younger))
                     (unless (eql younger 0)
                       (unless ,(when check-db-link
                                  `(progn
                                     (setq a younger)
                                     (loop
                                       (when (if current-p
                                               (%db-link-chain-in-current-sg-area a)
                                               (%db-link-chain-in-area-p a sg))
                                         (return t))
                                       (setq a (%fixnum-ref a ppc::area.younger))
                                       (when (eql a 0)
                                         (return nil)))))
                         (%fixnum-set area ppc::area.younger 0)
                         (%fixnum-set younger ppc::area.older 0)
                         (free-stack-area younger))))))
       (do-area sg.ts-area)
       (do-area sg.vs-area t)
       (%free-younger-cs-areas (sg.cs-area sg))
       ))))

; This makes a stack group only.
; Allocating the stacks and creating the thread is done by stack-group-preset
; now we have 3 optional args stack-size args
(defun make-stack-group (name &optional (stack-size (ash 1 20))(vstack-size stack-size)
                              (tstack-size (ash stack-size -1)))
  (setq name (require-type name 'string))
  (unless (and (fixnump stack-size) (> (the fixnum stack-size) 0))
    (setq stack-size (require-type stack-size '(and fixnum (integer 0 *)))))
  (unless *thread-manager-present-p*
    (error "The thread manager is not present"))
  (let* ((sg (%cons-stack-group name)))
         ;(each-stack-size (ceiling stack-size 3)))    
    (setf (sg.cs-size sg) (max *min-sp-stack-size* stack-size)
          (sg.vs-size sg) (max *min-vsp-stack-size* vstack-size)
          (sg.ts-size sg) (max *min-tsp-stack-size* tstack-size)
          (sg.maxsize sg) (+ (sg.cs-size sg) (sg.vs-size sg) (sg.ts-size sg)))
    (push sg (population-data *stack-group-population*))
    sg))

; This is mostly for compatibility, but is a useful way to type-check a stack-group arg
(defun sg-buffer (sg)
  (unless (stack-group-p sg)
    (setq sg (require-type sg 'stack-group)))
  sg)

; Maybe this should return the real size of the areas, not the
; allocation request size (which gets rounded up to the real size)
(defun stack-group-size (&optional (stack-group *current-stack-group*))
  (sg-buffer stack-group)               ; type check
  (if (%stack-group-exhausted-p stack-group)
    (sg.maxsize stack-group)
    (multiple-value-call '+ (%stack-group-stack-space *current-stack-group*))))

(defun stack-group-maximum-size (&optional (sg *current-stack-group*))
  (sg-buffer sg)                        ; type check
  (sg.maxsize sg))

(defun (setf stack-group-maximum-size) (value &optional (sg *current-stack-group*))
  (sg-buffer sg)                        ; type check
  (setq value (require-type value 'fixnum))
  (setf (sg.maxsize sg) value))

(defparameter *initial-tsp-stack-segment-size* (* 8 1024))
(defparameter *initial-vsp-stack-segment-size* (* 4 1024))

(def-ccl-pointers init-stack-sz ()
  (if (osx-p)
    (progn
      (setq *initial-tsp-stack-segment-size* (* 128 1024))
      (setq *initial-vsp-stack-segment-size* (* 128 1024)))
    (progn
      (setq *initial-tsp-stack-segment-size* (* 8 1024))
      (setq *initial-vsp-stack-segment-size* (* 4 1024)))))

 

(defmacro with-area-macptr ((var area) &body body)
  `(with-macptrs (,var)
     (%setf-macptr-to-object ,var ,area)
     ,@body))

; Store the threadid in the threshold slot of the area structure.
(defun gc-area.threadid (area)
  (with-area-macptr (p area)
    (%get-signed-long p ppc::area.threshold)))

(defun (setf gc-area.threadid) (threadid area)
  (with-area-macptr (p area)
    (setf (%get-signed-long p ppc::area.threshold)
          threadid)))

(defun gc-area.return-sp (area)
  (%fixnum-ref area ppc::area.gc-count))

(defun (setf gc-area.return-sp) (return-sp area)
  (setf (%fixnum-ref area ppc::area.gc-count) return-sp))

(defun stack-group-preset (sg function &rest args)
  (declare (dynamic-extent args))
  (sg-buffer sg)                        ; type check
  (when (eq sg *initial-stack-group*)
    (error "Can't preset initial stack group"))
  (unless (eq sg *current-stack-group*)
    (setq function (require-type function 'function))
    (without-interrupts
      (let ((top-listener nil))
        (unless (eql #$kNoThreadID (sg.threadID sg))
          (setq top-listener (symbol-value-in-stack-group '*top-listener* sg))
          (%kill-stack-group sg))       ; easier than trying to munge the active state
        (let* ((vs-area nil)
               (ts-area nil)
               (cs-area nil)
               (thread-id nil)
               (fn.args (cheap-cons function (cheap-copy-list args))))
          (unwind-protect
            (progn
              (setq vs-area (allocate-vstack *initial-vsp-stack-segment-size*))
              (setq ts-area (allocate-tstack *initial-tsp-stack-segment-size*))
              (setq cs-area (new-cstack-area))
              (setq thread-id (new-stack-group-thread (sg.cs-size sg)))
              (setf (gc-area.threadid cs-area) thread-id)
              (setf (sg.threadID sg) thread-id
                    (sg.vs-area sg) vs-area
                    (sg.ts-area sg) ts-area
                    (sg.cs-area sg) cs-area
                    (sg.cs-overflow-limit sg) 0
                    (sg.vs-overflow-limit sg) 0
                    (sg.ts-overflow-limit sg) 0
                    (sg.initial-function.args sg) fn.args))
            (unless thread-id
              (when vs-area
                (free-stack-area vs-area))
              (when ts-area
                (free-stack-area ts-area))
              (when cs-area
                (free-stack-area cs-area))))
          ; Start it up. This runs the threadEntry function.
          (funcall sg (cheap-cons top-listener fn.args))
          (setf (sg.resumer sg) nil))))))

(defun kill-stack-group (stack-group)
  (when (eq stack-group *current-stack-group*)
    (error "Attempt to kill *current-stack-group*"))
  (when (eq stack-group *initial-stack-group*)
    (error "Attempt to kill *initial-stack-group*"))
  (unless (%stack-group-exhausted-p stack-group)
    (%kill-stack-group stack-group)))    

; Kill a stack group.
; Kill its thread.
; Unlink it from the *current-stack-group* chain.
; Free its stack areas.
; Only called on a stack group with an active thread.
; Assumes sg is not *current-stack-group*
(defun %kill-stack-group (sg &optional shutdown-p)
  (without-interrupts
   (let ((ts-area (sg.ts-area sg))
         (vs-area (sg.vs-area sg))
         (cs-area (sg.cs-area sg))
         (fn.args (sg.initial-function.args sg)))
     ; Clear state
     (setf (sg.ts-area sg) nil
           (sg.vs-area sg) nil
           (sg.cs-area sg) nil
           (sg.threadID sg) #$kNoThreadID
           (sg.resumer sg) nil)
     (unless shutdown-p
       (setf (sg.initial-function.args sg) nil)
       (when fn.args
         (cheap-free-list fn.args)))
     (free-stack-area ts-area)
     (free-stack-area vs-area)
     (let (older-cs-area)
       (loop
         (setq older-cs-area (%fixnum-ref cs-area ppc::area.older))
         (when (eql 0 older-cs-area)
           (return))
         (setq cs-area older-cs-area)))
     (%free-younger-cs-areas cs-area t))))

(defun %free-younger-cs-areas (cs-area &optional (free-cs-area-too nil))
  (let (younger-cs-area)
    (loop
      (setf younger-cs-area (%fixnum-ref cs-area ppc::area.younger)
            (%fixnum-ref cs-area ppc::area.younger) 0)
      (when free-cs-area-too
        #+ignore
        (when (do-9.1-crock)            
          (let ((threadid (gc-area.threadID cs-area)))
            (when (member threadid *held-threads*)
              (let* ((low (%fixnum-ref cs-area ppc::area.low))
                     (high (%fixnum-ref cs-area ppc::area.high)))              
                (setq *held-threads* (delete threadid *held-threads*))
                (errchk (#_UnholdMemory (%int-to-ptr (ash low 2)) (ash (- high low) 2)))))))
        (errchk (ppc-ff-call (%kernel-import ppc::kernel-import-xdisposethread)
                             :signed-fullword (gc-area.threadID cs-area)
                             :address (%null-ptr) 
                             :signed-byte 0
                             :signed-halfword))
        #+ignore
        (with-pstrs ((p (format nil "dispose ~X" (gc-area.threadID cs-area))))
          (#_debugstr p))
        (setf (%fixnum-ref cs-area ppc::area.older) 0)          ; free-stack-area frees the whole younger/older chain
        (free-stack-area cs-area))
      (when (eql 0 younger-cs-area) (return))
      (setq cs-area younger-cs-area)
      (setq free-cs-area-too t))))

(defun shutdown-stack-groups ()
  (dolist (sg (population-data *stack-group-population*))
    (unless (or (eq sg *initial-stack-group*)
                (eq sg *current-stack-group*)
                (%stack-group-exhausted-p sg))
      (%kill-stack-group sg t))))

; The UPP for callback to #'threadEntry below
(defvar threadEntry)

; The callback-transition-vector for the threadEntry UPP
; #_NewThread takes a transition vector, not a UPP
; Initialized by (def-ccl-pointers *initial-stack-group* ...) below.
(defvar *stack-group-startup-function*)

; Here's the function that starts up a stack group.
; It never returns. Instead, we kill the thread.
; Expects *next-stack-group* to contain the stack group being started.
; If you redefine this, remember to reevaluate the define-ppc-pascal-function
; form below.
(defppclapfunction threadEntry ((arg-ptr arg_z))
  (let ((sg arg_y)
        (temp arg_x))
    (set-global rzero catch-top)
    (set-global rzero db-link)
    (set-global rzero xframe)
    (lwz temp '*next-stack-group* nfn)
    (lwz sg ppc::symbol.vcell temp)
    (stw rnil ppc::symbol.vcell temp)
    (lwz temp '*current-stack-group* nfn)
    (la loc-g ppc::symbol.vcell temp)
    (stw sg 0 loc-g)
    (bla .SPwrite-barrier)
    (svref temp sg.cs-area sg)
    (set-global temp current-cs)
    (svref temp sg.vs-area sg)
    (set-global temp current-vs)
    (lwz vsp ppc::area.high temp)
    (svref temp sg.ts-area sg)
    (set-global temp current-ts)
    (lwz tsp ppc::area.high temp)
    ; Ensure that the stack pointer is properly aligned
    ; push a stack frame in the process.
    (clrrwi imm0 sp 4)
    (subi imm0 imm0 16)
    (sub imm0 imm0 sp)
    (stwux sp sp imm0)
    (stw fn ppc::lisp-frame.savefn sp)
    (mflr loc-pc)
    (stw loc-pc ppc::lisp-frame.savelr sp)
    (stw vsp ppc::lisp-frame.savevsp sp)
    (mr fn nfn)
    (li imm0 #xd0)                      ; Overflow, invalid, divide-by-zero enabled.
    (stw imm0 -4 sp)
    (lfd fp0 -8 sp)
    (mtfsf #xff fp0)
    (zero-fp-reg fp0)
    ; (%run-stack-group-function sg sp)
    (mr arg_z sp)
    (set-nargs 2)
    (lwz temp0 '%run-stack-group-function fn)
    (bla .SPfuncall)
    (lwz temp0 'error fn)
    (lwz arg_z '"%run-stack-group-function returned!" fn)
    (bla .SPfuncall)))


(defun add-pascal-upp-alist (name fn)
  (let ((thing (assq name defpascal-upp-alist)))
    (if thing (rplacd thing fn)(push (cons name fn) defpascal-upp-alist))))

#+carbon-compat
;; see also upp-transition-vector
(eval-when (:compile-toplevel :load-toplevel :execute)

#|
(add-pascal-upp-alist 'THREADENTRY #'(lambda (procptr) 
                                       ;;just returns procptr if carbon but if truly osx may do something else more obscure
                                       (#_newthreadentryupp procptr)))
|#

(add-pascal-upp-alist-macho 'THREADENTRY "NewThreadEntryUPP")
)


 
; This does (set 'threadEntry UPP) ;; or procptr
(define-ppc-pascal-function-2 #'threadEntry #.(make-proc-info '(:ptr) :ptr))


; This code is called when we reenter the Lisp after a control stack overflow.
; We are operating on a new thread, and the kernel has initialized the
; saved registers.
; We need to install the new cs_area and initialize its contents,
; then set up an unwind-protect to handle returning to the other thread.
; Then we can enable interrupts and continue execution at the point
; where stack overflow exception occurred.
#|
(defpascal cs-overflow-callback (:without-interrupts nil :void)
  (%cs-overflow-callback))
|#

; This is just like the commented out code above except
; it doesn't leave anything on the VSP stack during the call to
; %cs-overflow-callback.
; This is in LAP so it doesn't VPUSH anything.
; VPUSHing might cause a value stack overflow.
(defppclapfunction cs-overflow-callback ((arg-macptr arg_z))
  (check-nargs 1)
  (lwz fname '%cs-overflow-callback nfn)
  (set-nargs 0)
  (ba .SPjmpsym))

(define-ppc-pascal-function-2 #'cs-overflow-callback 0 nil nil)

(defparameter *debug-cs-overflow-code* nil)

(defvar *cs-overflow-vsp* 0)
(declaim (type fixnum *cs-overflow-vsp*))

; Copy the preceding frame's savevsp to this one
(defppclapfunction %fix-savevsp ()
  (let ((temp imm0))
    (lwz temp 0 sp)
    (lwz temp ppc::lisp-frame.savevsp temp)
    (stw temp ppc::lisp-frame.savevsp sp)
    (blr)))


; Same as %fix-savevsp, but fixes the top 2 frames
; It's important that this doesn't check or change nargs.
(defppclapfunction %fix-savevsp-2 ()
  (let ((temp imm0)
        (temp-2 imm1))
    (lwz temp 0 sp)
    (lwz temp-2 0 temp)
    (lwz temp-2 ppc::lisp-frame.savevsp temp-2)
    (stw temp-2 ppc::lisp-frame.savevsp temp)
    (stw temp-2 ppc::lisp-frame.savevsp sp)
    (blr)))

; This is split out of the body of cs-overflow-callback
; so that the unwind-protect below will be sure to throw multiple values.
; This code computes (%current-xp) more than once to avoid any variable bindings:
; the vsp stack pointer at entry to this function needs to be
; the same as its value at the call to %restart-user-code-after-cs-overflow.

(defun %cs-overflow-callback ()
  (declare (optimize (debug 3)))                ; no saved register usage.
  (locally (declare (optimize (debug 0)))       ; but still do fixnum optimizations
    (setq *cs-overflow-vsp* (%current-vsp))
    (let* ((old-cs-area (%get-kernel-global 'current-cs))
           (cs-area (%fixnum-ref old-cs-area ppc::area.younger))
           (sg *current-stack-group*))
      (%set-kernel-global 'current-cs cs-area)
      (setf (sg.cs-area sg) cs-area
            (sg.threadID sg) (gc-area.threadid cs-area))
      ; Initialize the cs-area.
      ; Add 8 to the frame pointer so that none of the frames appear to be off the bottom of the stack
      (initialize-sg-cs-area sg (+ (%current-frame-ptr) 8))
      (setf (gc-area.return-sp cs-area) (%current-frame-ptr)))
    (let* ((sp (with-area-macptr (xp (%current-xp)) (xp-gpr-lisp xp ppc::sp)))
           (vsp (%fixnum-ref sp ppc::lisp-frame.savevsp)))
      (setf (%fixnum-ref (%current-frame-ptr) ppc::lisp-frame.savevsp) vsp))
    (%set-current-vsp *cs-overflow-vsp*)          ; in case VSP overflowed
    (unwind-protect
      (progn
        ; It's important that nothing gets pushed on the VSP stack here
        ; until after the (%current-vsp) call for the first arg to %restart-user-code-after-cs-overflow
        (%fix-savevsp)
        ; Reenable stack overflow errors
        (bitclrf $gc-allow-stack-overflows-bit (the fixnum *gc-event-status-bits*))
        ; Restore *interrupt-level* to its value before the callback
        ; cs_stack_switch_startup in "ccl:pmcl;lisp-exceptions.c" decrements it by 2.
        (setq *interrupt-level* (%i+ *interrupt-level* 2))
        ; And reenter the user code
        (when *debug-cs-overflow-code*
          (dbg "Restarting after cs overflow"))
        (multiple-value-prog1
          ; vsp here must be the same as at function entry
          (%restart-user-code-after-cs-overflow
           (%current-vsp)
           (%current-xp)
           (%count-cs-overflow-stack-frames-to-copy (%current-xp)))
          (setf (gc-area.return-sp (%get-kernel-global 'current-cs)) 0)))
      (let* ((cs-area (%get-kernel-global 'current-cs))
             (old-cs-area (%fixnum-ref cs-area ppc::area.older))
             (old-threadID (gc-area.threadid old-cs-area))
             (sg *current-stack-group*))
        ; From here out needs to be uninterruptable.
        (decf *interrupt-level* 2)
        (setf (sg.cs-area sg) old-cs-area
              (sg.threadID sg) old-threadID))
      ; VSP here must be the same as it was when the unwind-protect cleanup form was entered.
      (%copy-throw-context-to-exception-frame
       (%current-xp)
       (gc-area.return-sp (%get-kernel-global 'current-cs))))))


(defun %current-xp ()
  (let ((xframe (%get-kernel-global 'xframe)))
    (when (eql xframe 0)
      (error "No current exception frame"))
    (%fixnum-ref xframe
                 (get-field-offset :xframe-list.this))))

(defun %count-cs-overflow-stack-frames-to-copy (xp-fixnum)
  (with-macptrs (xp)
    (%setf-macptr-to-object xp xp-fixnum)
    (let ((sp (xp-gpr-lisp xp ppc::sp))
          (count 0)
          (sg *current-stack-group*))
      (loop
        (unless (%lexpr-entry-frame-p sp) (return))
        (unless (lisp-frame-p sp sg) (return))
        (incf count)
        (setq sp (%%frame-backlink sp)))
      count)))

(defun %lexpr-entry-frame-p (sp-ptr)
  (let ((savelr (%fixnum-ref sp-ptr ppc::lisp-frame.savelr))
        (lexpr-return (%get-kernel-global 'lexpr-return))
        (lexpr-return1v (%get-kernel-global 'lexpr-return1v))
        (ret1valn (%get-kernel-global 'ret1valaddr)))
    (or (eq savelr lexpr-return1v)
        (eq savelr lexpr-return)
        (and (eq savelr ret1valn)
             (eq (%fixnum-ref (%fixnum-ref sp-ptr ppc::lisp-frame.backlink)
                              ppc::lisp-frame.savelr)
                 lexpr-return)))))

(eval-when (:compile-toplevel :execute)
  (assert (eql ppc::lisp-frame.size 16)))

(defun vsp-mismatch-error (sb was)
  (error "VSP mismatch after control stack overflow~%SB: #x~x, was: #x~x"
         (ash sb ppc::fixnum-shift)
         (ash was ppc::fixnum-shift)))

(defun %handle-sp-stack-overflow (xp-fixnum)
  (with-area-macptr (xp xp-fixnum)
    (handle-stack-overflow xp (xp-gpr-lisp xp ppc::fn) ppc::sp)))


(defppclapfunction %restart-user-code-after-cs-overflow ((current-vsp arg_x) (xp arg_y) (frame-count arg_z))
  (check-nargs 3)
  (mflr loc-pc)
  (bla .spsavecontextvsp)
  (call-symbol %fix-savevsp-2)
  (stwu tsp -8 tsp)                     ; push a dummy TSP frame in case user code wants to pop one
  (stw tsp 4 tsp)                       ; "raw" block
  (load-constant temp0  %%restart-user-code-after-cs-overflow)
  (bla .SPmvpass)
  ; Fix up TSP, if user code popped a frame
  (let ((temp imm0))
    (lwz temp 4 tsp)
    (cmpwi temp 0)
    (bne @no-user-pop)
    ; User code popped a TSP frame. Need to splice out the frame below the top one.
    ; That frame is guaranteed to be a lisp frame, so we don't need to clear its contents
    (lwz temp 0 tsp)
    (lwz temp 0 temp)
    (stw temp 0 tsp)
    (b @done)
    @no-user-pop
    ; The user code didn't pop the tsp frame we pushed, so pop it ourself
    (lwz tsp 0 tsp)
    @done
    (ba .spnvalret)))


(defppclapfunction %%restart-user-code-after-cs-overflow ((current-vsp arg_x) (xp arg_y) (frame-count arg_z))
  (let ((temp imm0)
        (sp-bytes imm1)
        (sp-ptr imm2)
        (ms imm3)
        (temp-2 imm4)
        (temp-3 temp0)
        (ri nargs))                     ; must be nargs since nargs is overwritten last below
    (check-nargs 3)
    (mr vsp current-vsp)
    (mflr loc-pc)
    (bla .spsavecontextvsp)
    (call-symbol %fix-savevsp-2)
    ; Copy frame-count frames onto the current stack.
    (lwi temp #.(ash ppc::lisp-frame.size (- ppc::fixnum-shift)))
    (mullw. sp-bytes frame-count temp)
    (xp-register-image ri xp)
    (ri-gpr temp ri ppc::vsp)
    (cmpw cr1 temp vsp)
    (beq cr1 @ok)
    (mr arg_y temp)
    (mr arg_z vsp)
    (set-nargs 2)
    (call-symbol vsp-mismatch-error)
    @ok
    (ri-gpr sp-ptr ri ppc::sp)
    (add sp-ptr sp-bytes sp-ptr)
    (beq @nostack)
    (set-ri-gpr sp-ptr ri ppc::sp)
    (lwz temp ppc::lisp-frame.savevsp sp-ptr)
    (mr temp-2 sp)
    ; Update the savevsp entries in the stack frames between here and the stack overflow frame
    @copy-savevsp-loop
    (stw temp ppc::lisp-frame.savevsp temp-2)
    (la temp-3 ppc::lisp-frame.size temp-2)
    (lwz temp-2 0 temp-2)
    (cmpw temp-2 temp-3)
    (beq @copy-savevsp-loop)
    ; Copy the lexpr-entry frames from the old stack area
    @copy-sp-loop
    (stwu sp (- ppc::lisp-frame.size) sp)
    (la sp-ptr (- ppc::lisp-frame.size) sp-ptr)
    (lwz temp 4 sp-ptr)
    (stw temp 4 sp)
    (addi frame-count frame-count '-1)
    (lwz temp 8 sp-ptr)
    (stw temp 8 sp)
    (cmpwi frame-count 0)
    (lwz temp 12 sp-ptr)
    (stw temp 12 sp)
    (bne @copy-sp-loop)
    (lwz temp-2 0 sp)
    @splice-out-frames-loop
    (mr temp temp-2)
    (lwz temp-2 0 temp)
    (cmpw temp-2 sp-ptr)
    (bne @splice-out-frames-loop)
    (ri-gpr sp-ptr ri ppc::sp)
    (stw sp-ptr 0 temp)
    @nostack
    ; Possibly signal an error
    (vpush xp)
    (mr arg_z xp)
    (set-nargs 1)
    (call-symbol %handle-sp-stack-overflow)
    (vpop xp)
    (xp-register-image ri xp)
    (xp-machine-state ms xp)
    ; Restore arg_N, tempN, immN, fn, lr, pc->ctr, cr, xer
    (ri-gpr vsp ri ppc::vsp)
    (ri-gpr arg_x ri ppc::arg_x)
    (ri-gpr arg_y ri ppc::arg_y)
    (ri-gpr arg_z ri ppc::arg_z)
    (ri-gpr temp0 ri ppc::temp0)
    (ri-gpr temp1 ri ppc::temp1)
    (ri-gpr temp2 ri ppc::temp2)
    (ri-gpr temp3 ri ppc::temp3)
    (ri-gpr fn ri ppc::fn)
    (ri-gpr loc-pc ri ppc::loc-pc)
    ; I don't think we really need to restore the CR or XER here, but it can't hurt.
    (ms-lr temp ms)
    (mtlr temp)
    (ms-pc temp ms)
    (addi temp temp 4)                  ; skip the trap instruction that detected the original stack overflow
    (mtctr temp)
    (ms-cr temp ms)
    (mtcrf #xff temp)
    (ms-xer temp ms)
    (mtxer temp)
    (ri-gpr imm0 ri ppc::imm0)
    (ri-gpr imm1 ri ppc::imm1)
    (ri-gpr imm2 ri ppc::imm2)
    (ri-gpr imm3 ri ppc::imm3)
    (ri-gpr imm4 ri ppc::imm4)
    (ri-gpr nargs ri ppc::nargs)
    (bctr)))

    
; This is called from the unwind-protect cleanup form in %cs-overflow-callback.
; The control stack at that point contains two frames of interest:
;
;  1) Return to nthrowvalues or nthrow1value subprim.
;  2) Return to end of unwind-protect body in %cs-overflow-callback
;       or
;     Return to .spTHROW subprim if return-sp is non-zero
;
; We move frame 1 into the exception frame,
; Copy the rest of the relevant machine state into the exceptions frame,
; Then return no values to frame 2.
; If the return-sp param is non-zero, then we copy frame 2 to the top
; stack frame on the other stack group and then return to the frame in return-sp.
; %cs-overflow-callback will return normally to the kernel code,
; which will switch to the other thread and return from the exception.
; This will continue the throw that we aborted here.
; Clever, huh?
(defppclapfunction %copy-throw-context-to-exception-frame ((xp arg_y) (return-sp arg_z))
  (let ((ri imm0)
        (ms imm1)
        (temp imm2)
        (other-sp imm3)
        (temp-2 imm4))
    (check-nargs 2)
    (xp-register-image ri xp)
    (xp-machine-state ms xp)
    ; I don't think it's necessary move the save registers, but it can't hurt.
    (set-ri-gpr save0 ri ppc::save0)
    (set-ri-gpr save1 ri ppc::save1)
    (set-ri-gpr save2 ri ppc::save2)
    (set-ri-gpr save3 ri ppc::save3)
    (set-ri-gpr save4 ri ppc::save4)
    (set-ri-gpr save5 ri ppc::save5)
    (set-ri-gpr save6 ri ppc::save6)
    (set-ri-gpr save7 ri ppc::save7)
    (set-ri-gpr freeptr ri ppc::freeptr)
    (set-ri-gpr initptr ri ppc::initptr)
    (set-ri-gpr tsp ri ppc::tsp)
    (set-ri-gpr vsp ri ppc::vsp)
    (set-ri-gpr 0 ri ppc::nargs)
    ; Set return address and fn in exception frame from frame 1
    (lwz temp ppc::lisp-frame.savelr sp)
    (set-ms-lr temp ms)
    (lwz temp
         '#.#'(lambda (&lap 0)
                ; this is lap so that it won't check for stack overflow
                ; It's only here to provide a debugger hook so that I can
                ; inspect the machine state right when the old thread restarts.
                ; This code is basically equivalent to: (when *debug-cs-overflow-code* (dbg "..."))
                (ppc-lap-function nil ()
                 (vpush arg_z)
                 (lwz arg_z '*debug-cs-overflow-code* nfn)
                 (lwz arg_z ppc::symbol.vcell arg_z)
                 (cmpw arg_z rnil)
                 (beq @ret)
                 (lwz arg_z '"Reentering old thread after CS overflow" nfn)
                 (dbg t)
                 @ret
                 (vpop arg_z)
                 (lwz vsp ppc::lisp-frame.savevsp sp)
                 (blr)))
         nfn)
    (set-ri-gpr temp ri ppc::nfn)
    (svref temp 0 temp)
    (la temp (- ppc::misc-data-offset 4) temp)
    (set-ms-pc temp ms)
    (lwz temp ppc::lisp-frame.savefn sp)        ; I think this is guaranteed to be 0, but be safe
    (set-ri-gpr temp ri ppc::fn)
    (cmpwi return-sp 0)
    (la sp ppc::lisp-frame.size sp)
    (ri-gpr other-sp ri ppc::sp)
    (bne @throw)
    ; Regular return. May need to insert a ret1valn frame to
    ; convert the multiple values from the throw to a single value.
    (lwz temp ppc::lisp-frame.savelr other-sp)
    (ref-global temp-2 ret1valaddr)
    (cmpw temp temp-2)
    (beq @mv)
    ; Single value return expected, so push a frame to change the multiple values to a single value
    (lwz temp ppc::lisp-frame.savevsp other-sp)
    (stwu other-sp (- ppc::lisp-frame.size) other-sp)
    (stw temp ppc::lisp-frame.savevsp other-sp)
    (lwz temp-2 '#.#'(lambda (&lap 0)
                       (ppc-lap-function nil ()
                         (cmpwi nargs 0)
                         (mr arg_z rnil)
                         (add vsp vsp nargs)
                         (beq @ret)
                         (lwz arg_z -4 vsp)
                         @ret
                         (ba .SPpopj)))
         nfn)
    (stw temp-2 ppc::lisp-frame.savefn other-sp)
    (svref temp-2 0 temp-2)
    (stw temp-2 ppc::lisp-frame.savelr other-sp)
    (set-ri-gpr other-sp ri ppc::sp)
    (b @return)
    @mv
    ; Multiple value return expected. Pop the ret1valn frame.
    (lwz other-sp 0 other-sp)
    (set-ri-gpr other-sp ri ppc::sp)
    (b @return)
    @throw
    (lwz temp ppc::lisp-frame.savefn sp)
    (stw temp ppc::lisp-frame.savefn other-sp)
    (lwz temp ppc::lisp-frame.savelr sp)
    (stw temp ppc::lisp-frame.savelr other-sp)
    (mr sp return-sp)
    @return
    ; Return to frame 2
    (restore-full-lisp-context temp)    ; dont' restore VSP
    (mr arg_z rnil)
    (li nargs 0)                        ; 0 values for return from %cs-overflow-callback
    (blr)))


; the size of the active portion of a control stack segment
(defparameter *cs-segment-size* 32768)
(def-ccl-pointers cs-cize ()
  (if (osx-p) 
    (setq *cs-segment-size* (* 32768 8))
    (setq *cs-segment-size* 32768)))

; the size of the active portion of a value stack segment
(defparameter *vs-segment-size* 8192)

; the size of the active portion of a temp stack segment
(defparameter *ts-segment-size* 8192)

; How much space to leave for overflow on the control stack
(defparameter *cs-hard-overflow-size* 65536)
(defparameter *cs-soft-overflow-size* 65536)

(defparameter *max-heap-size* nil)

(declaim (fixnum *cs-segment-size* *cs-hard-overflow-size* 
                 *cs-soft-overflow-size* *vs-soft-overflow-size* *ts-soft-overflow-size*))
;(defvar cruddo 1.0)
;(defvar crud)

; Create a new Thread Manager thread
(defun new-stack-group-thread (cs-size)
  (let ((stack-size (+ (logand (+ cs-size 4095) -4096)          ; round up to 4K multiple
                       *cs-hard-overflow-size*
                       *cs-soft-overflow-size*)))
    (rlet ((threadMade :threadid))
      (errchk (ppc-ff-call (%kernel-import ppc::kernel-import-xnewthread)
                           :signed-fullword #$kCooperativeThread        ; threadStyle
                           :address *stack-group-startup-function*      ; threadEntry
                           :address (%null-ptr)        		; threadParam
                           :signed-fullword stack-size        		; stackSize
                           :signed-fullword #$kCreateIfNeeded   	; options
                           :address (%null-ptr)         		; threadResult
                           :address threadmade          		; threadMade
                           :signed-fullword))
      (%get-long threadMade))))

#+carbon-compat
(progn


(defppclapfunction get-fp-zero ()
  (ref-global arg_z short-float-zero)
  (blr))

)



(defmacro with-self-bound-io-control-vars (&body body)
  `(let (; from CLtL2, table 22-7:
         (*package* *package*)
         (*print-array* *print-array*)
         (*print-base* *print-base*)
         (*print-case* *print-case*)
         (*print-circle* *print-circle*)
         (*print-escape* *print-escape*)
         (*print-gensym* *print-gensym*)
         (*print-length* *print-length*)
         (*print-level* *print-level*)
         (*print-lines* *print-lines*)
         (*print-miser-width* *print-miser-width*)
         (*print-pprint-dispatch* *print-pprint-dispatch*)
         (*print-pretty* *print-pretty*)
         (*print-radix* *print-radix*)
         (*print-readably* *print-readably*)
         (*print-right-margin* *print-right-margin*)
         (*read-base* *read-base*)
         (*read-default-float-format* *read-default-float-format*)
         (*read-eval* *read-eval*)
         (*read-suppress* *read-suppress*)
         (*readtable* *readtable*))
     ,@body))

; Enter here from the LAP startup code to apply the user function
; to the user args specified in stack-group-preset.
(defun %run-stack-group-function (sg sp)
  ; First we need to fix up the sg.cs-area and set the global cs-overflow-limit.
  (initialize-sg-cs-area sg sp)
  #-carbon-compat
  (set-gworld %temp-port%)
  #+carbon-compat
  (set-gworld-from-wptr %temp-port%)
  (let ((*top-listener* nil))
    (flet ((call-initial-stack-group-function ()
             (let* ((top-listener.fn.args *resume-stack-group-arg*)
                    (fn (cadr top-listener.fn.args))
                    (args (cddr top-listener.fn.args)))
               (setq *resume-stack-group-arg* nil)
               (setq sg nil)            ; So this stack group can be garbage collected
               (setq *top-listener* (car top-listener.fn.args))
               (free-cons top-listener.fn.args)
               (setq top-listener.fn.args nil)
               (stack-group-return nil)         ; return to stack-group-preset
               (setq *interrupt-level* 0)       ; was negative from stack-group-preset
               (handle-stack-group-interrupts)  ; may get interrupts before user startup
               (apply fn args))))
      (let* ((value (if *bind-io-control-vars-per-process*
                      (with-self-bound-io-control-vars
                        (call-initial-stack-group-function))
                      (call-initial-stack-group-function))))
        ; This stack group is exhausted.
        ; Let the initial stack group deallocate everything, and return the value to our resumer.
        (without-interrupts
         
         (stack-group-interrupt *initial-stack-group* nil
                                #'%stack-group-exit *current-stack-group* value)
         ; pass value here in case the resumer is the initial stack group
         (stack-group-resume *initial-stack-group* value)
         (error "This stack group should have been killed before it got here"))))))

; This runs in the *initial-stack-group* when a stack group is dying.
; It is responsible for killing the stack group and returning
; the value to its resumer.
(defun %stack-group-exit (sg value)
  (let ((resumer (sg.resumer sg)))
    (%kill-stack-group sg)
    (when resumer
      (stack-group-resume resumer value))))


#|
(defun initialize-sg-cs-area (sg sp)
  (declare (fixnum sp))
  (rlet ((stack-space-ptr :long))
    (#_ThreadCurrentStackSpace #$kCurrentThreadID stack-space-ptr)
    (setf (%get-byte stack-space-ptr 3)
          (logand #xfc (%get-byte stack-space-ptr)))    ; ensure tagged as fixnum
    (let* ((stack-space (%get-object stack-space-ptr 0))
           (limit (- sp stack-space))
           (hard-limit (+ limit (the fixnum (ash *cs-hard-overflow-size* -2))))
           (soft-limit (+ hard-limit (the fixnum (ash *cs-soft-overflow-size* -2))))
           (cs-area (sg.cs-area sg))
           (ndwords (ash stack-space -1)))      ; longwords -> doublewords
      (declare (fixnum stack-space limit hard-limit soft-limit))
      (setf (%fixnum-ref cs-area ppc::area.low) limit)
      (setf (%fixnum-ref cs-area ppc::area.high) sp)
      (setf (%fixnum-ref cs-area ppc::area.softlimit) soft-limit)
      (setf (%fixnum-ref cs-area ppc::area.hardlimit) hard-limit)
      (with-macptrs (cs-area-ptr)
        (%setf-macptr-to-object cs-area-ptr cs-area)
        (setf (%get-long cs-area-ptr ppc::area.ndwords) ndwords))
      (%set-kernel-global 'ppc::cs-overflow-limit soft-limit))))
|#

(defun initialize-sg-cs-area (sg sp)
  (declare (fixnum sp))
  (rlet ((stack-space-ptr :long))
    (ppc-ff-call (%kernel-import ppc::kernel-import-xthreadcurrentstackspace)
                 :signed-fullword (sg.threadid sg)
                 :address stack-space-ptr
                 :signed-halfword)
    (setf (%get-byte stack-space-ptr 3)
          (logand #xfc (%get-byte stack-space-ptr 3)))    ; ensure tagged as fixnum - shouldnt there be a 3 here?
    (let* ((stack-space (%get-object stack-space-ptr 0))
           (real-stack-space (if nil ;(osx-p) ;; IN THEIR INFINITE WISDOM THEY GIVE US LOTS MORE THAN WE ASK FOR IN NEWTHREAD
                                         ;; SO LETS MAKE BELIEVE WE GOT WHAT WE ASKED FOR - THIS SUCKS
                               (ash (min (%get-long stack-space-ptr)
                                       (+ (logand (+ (sg.cs-size sg) 4095) -4096)          ; round up to 4K multiple
                                          *cs-hard-overflow-size*
                                          *cs-soft-overflow-size*))
                                    (- ppc::fixnum-shift))
                               STACK-SPACE)) 
           (limit (- sp real-stack-space))
           (hard-limit (+ limit (the fixnum (ash *cs-hard-overflow-size* -2))))
           (soft-limit (+ hard-limit (the fixnum (ash *cs-soft-overflow-size* -2))))
           (cs-area (sg.cs-area sg))
           (ndwords (ash real-stack-space -1)))      ; longwords -> doublewords
      (declare (ignore-if-unused stack-space))
      (declare (fixnum stack-space limit hard-limit soft-limit))
       
      (setf (%fixnum-ref cs-area ppc::area.low) limit)
      (setf (%fixnum-ref cs-area ppc::area.high) sp)
      (setf (%fixnum-ref cs-area ppc::area.softlimit) soft-limit)
      (setf (%fixnum-ref cs-area ppc::area.hardlimit) hard-limit)
      (with-macptrs (cs-area-ptr)
        (%setf-macptr-to-object cs-area-ptr cs-area)
        (setf (%get-long cs-area-ptr ppc::area.ndwords) ndwords))      
      (%set-kernel-global 'ppc::cs-overflow-limit soft-limit)
      (let* ((vs-area (sg.vs-area sg))
             (ts-area (sg.ts-area sg))
             (vs-soft (%fixnum-ref vs-area ppc::area.softlimit))
             (ts-soft (%fixnum-ref ts-area ppc::area.softlimit)))
        (setf (sg.vs-overflow-limit sg) vs-soft
              (sg.ts-overflow-limit sg) ts-soft)
        (%set-kernel-global 'ppc::vs-overflow-limit vs-soft)
        (%set-kernel-global 'ppc::ts-overflow-limit ts-soft))      
      #+ignore
      (with-pstrs ((p (format nil "sp ~X stack-space ~X real ~X thread-id ~X soft ~x hard ~x" 
                              (ash sp 2) (ash stack-space 2)(ash real-stack-space 2) (sg.threadid sg) (ash soft-limit 2)(ash hard-limit 2))))
        (#_debugstr p))
      ;; incomprehensible workaround - they say stack must be resident to handle exceptions - oh my goodness!
      (when nil ;(do-9.1-crock)
        (let ((stkptr (%int-to-ptr (ash limit 2))))
          #-ignore
          (let ((threadid (sg.threadid sg)))
            (when (not (member threadid *held-threads*))
              (setq *held-threads* (cons threadid *held-threads*))
              (#_holdmemory stkptr (* ndwords 8))))
          #+ignore
          (dotimes (i ndwords)
            (Let* ((addr (ash i 3))
                   (val (%get-word stkptr addr)))
              (declare (ignore-if-unused val))
              #+ignore
              (%put-word stkptr val addr)))
          #+ignore
          (with-pstrs ((p (format nil "low ~X nbytes ~X" (* limit 4) (* ndwords 8))))
            (#_debugstr p)))))))

#+ignore
(defun do-9.1-crock ()
  (and (not (osx-p))
       (not (bbox-p))  ;; udf in 4.3.1
       (let ((sysv (gestalt "sysv")))
         (and (>= sysv #x910)(< sysv #x1000)))  ;; it will not be fixed, its a sad fact of life due to brain dead VM implementation.
       ;; this is false if bbox-p - today anyway
       (gestalt #$gestaltVMAttr #$gestaltVMPresent)))

#+ignore ;; testing 1 2 3
(defun fact (n) (if (= n 1) 1 (* n (fact (1- n))))) 

(defmacro saving-graphics-port (&body body)
  (let ((gworld (gensym))
        (gdevice (gensym)))
    `(with-macptrs (,gworld ,gdevice)
       (unwind-protect
         (progn
           (get-gworld ,gworld ,gdevice)
           ,@body)
         (set-gworld ,gworld ,gdevice)))))



(defun %lock-binding-stack ()
  (declare (optimize (speed 3) (safety 0)))     ;  no event-poll
  (ppc-ff-call (%kernel-import ppc::kernel-import-lock-binding-stack) :void))

(defun %unlock-binding-stack ()
  (declare (optimize (speed 3) (safety 0)))     ;  no event-poll
  (ppc-ff-call (%kernel-import ppc::kernel-import-unlock-binding-stack) :void))


(defun %remove-tmtask ()
  (declare (optimize (speed 3) (safety 0)))     ;  no event-poll
  (ppc-ff-call (%kernel-import ppc::kernel-import-remove-tmtask) :void))

(defun %restore-tmtask ()
  (declare (optimize (speed 3) (safety 0)))     ;  no event-poll
  (ppc-ff-call (%kernel-import ppc::kernel-import-restore-tmtask) :void))

#| ;; a failed experiment
(defun %start-vbl ()
  (declare (optimize (speed 3) (safety 0)))     ;  no event-poll
  (ppc-ff-call (%kernel-import ppc::kernel-import-start-vbl) :void))
|#



  
  

; This is the ONLY way to switch stack groups.
; If anyone else calls #_YieldToThread, things will break.
; C code can have its own threads, but it must call back
; to MCL from the same thread that called it, and it must
; not switch to an MCL thread.
(defun stack-group-resume (stack-group arg)
  (sg-buffer stack-group)               ; type check
  (when (eq stack-group *current-stack-group*)
    (return-from stack-group-resume arg))
  (when (%stack-group-exhausted-p stack-group)
    (error "Attempt to resume exhausted ~s" stack-group))
  (let (result)
    (without-interrupts
     (saving-graphics-port
       (catch '*inactive-stack-group-catch*
         (%ensure-vsp-stack-space)      ; make sure there's room for ppc-ff-call to save the saved registers
         (setq *next-stack-group* stack-group
               *resume-stack-group-arg* arg
               arg nil)                        ; allow GC
         ;(if (osx-p)(%remove-tmtask))
         (%remove-tmtask)
         (%lock-binding-stack)
         (%reverse-special-bindings nil)
         (%normalize-areas)
         (%save-stack-group-context *current-stack-group*)
         (%unlock-binding-stack)
         ; (#_YieldToThread (sg.threadID stack-group))
         ; Do it explicitly to be doubly sure that it's resolved
         ; Calling back to resolve-slep-address in the current context is a bad idea
         ; unhold current, hold next?? - doesn't work
         ;(unhold-current-hold-next *current-stack-group* stack-group)
         (ppc-ff-call (%kernel-import ppc::kernel-import-xYieldToThread)
                      :signed-fullword (sg.threadID stack-group) 
                      :signed-halfword)
         ;; xYieldToThread locks the binding stack here: we can't reliably do
         ;; an ff-call to %LOCK-BINDING-STACK until the incoming thread's context
         ;; is restored, but we don't want a timer interrupt to mess with anything
         ;; yet either.
         ;;(%lock-binding-stack)
         (%restore-stack-group-context *next-stack-group*)
         (%reverse-special-bindings t)
         (%unlock-binding-stack)
         ;(if (osx-p)(%restore-tmtask))
         (%restore-tmtask)
         )
       (setq result *resume-stack-group-arg*
             *current-stack-group* *next-stack-group*
             *next-stack-group* nil
             *resume-stack-group-arg* nil)))
      (multiple-value-bind (value value-p) (handle-stack-group-interrupts)
        (when value-p
          (setq result value)))
      result))
#|
(defun unhold-current-hold-next (current-sg next-sg)
  (when (do-9.1-crock)
    (let* ((current-cs-area (sg.cs-area current-sg))
           (next-cs-area (sg.cs-area next-sg))
           (current-thread (sg.threadid current-sg))
           (next-thread (sg.threadid next-sg)))
      (when (not (member next-thread *held-threads*))
        (Setq *held-threads*  (cons next-thread *held-threads*))
        (let* ((low (%fixnum-ref next-cs-area ppc::area.low))
               (high (%fixnum-ref next-cs-area ppc::area.high)))
          (errchk (#_HoldMemory (%int-to-ptr (ash low 2)) (ash (- high low) 2)))))
      (when (member current-thread *held-threads*)
        (setq *held-threads* (delete current-thread *held-threads*))
        (let* ((low (%fixnum-ref current-cs-area ppc::area.low))
               (high (%fixnum-ref current-cs-area ppc::area.high)))
          (errchk (#_UnholdMemory (%int-to-ptr (ash low 2)) (ash (- high low) 2))))))))
|#
    

(defun handle-stack-group-interrupts ()
  (let (interrupt-function.args
        (current *current-stack-group*)
        result result-p)
    (loop
      (without-interrupts               ; paranoia
       (setq interrupt-function.args (sg.interrupt-function.args current))
       (unless interrupt-function.args
         (return))
       (setf (sg.interrupt-function.args current) nil))
      (let* ((resumer.err (car interrupt-function.args))
             (fn (cadr interrupt-function.args))
             (args (cddr interrupt-function.args))
             (done? (not resumer.err))          ; non-immediate interrupts can throw through here
             (value (block nil
                      (unwind-protect
                        (prog1
                          (apply fn args)
                          (setq done? t))
                        (unless done?
                          (return (cdr resumer.err)))))))
        (when resumer.err
          (progn
            (setq result (stack-group-resume (car resumer.err) value)
                  result-p t)
            (free-cons resumer.err))))
      (cheap-free-list interrupt-function.args))
    (values result result-p)))

(defun stack-group-return (arg)
  (let ((resumer (sg.resumer *current-stack-group*)))
    (unless resumer
      (error "~s has no resumer" *current-stack-group*))
    (stack-group-resume resumer arg)))

(defun previous-stack-group (sg)
  (sg.resumer (require-type sg 'stack-group)))

; If now-p is true, calls the function right away and returns
; what it returns. It will explicitly resume the caller.
; If an error occurs, it will be signalled and any attempt to
; throw out will cause now-p to be returned to the calling stack group.
; If now-p is false, queues up the function for running
; next time the scheduler schedules its process.
; In neither case should the function explicitly switch stack
; groups.
(defun stack-group-interrupt (sg now-p function &rest args)
  (declare (dynamic-extent args))
  (sg-buffer sg)                        ; type check
  (unless (functionp function)
    (setq function (require-type function 'function)))
  (if (eq sg *current-stack-group*)
    (apply function args)
    (without-interrupts
     (let-globally ((*in-scheduler* now-p))
       (let* ((old-fn.args (sg.interrupt-function.args sg))
              (resumer.err (and now-p (cheap-cons *current-stack-group* now-p)))
              (new-fn.args (cheap-cons resumer.err (cheap-cons function (cheap-copy-list args)))))
         (when old-fn.args
           (setq new-fn.args
                 (cheap-list resumer.err #'sg-nested-interrupt sg new-fn.args old-fn.args)))
         (setf (sg.interrupt-function.args sg) new-fn.args)
         (when now-p
           (stack-group-resume sg nil)))))))

(defun sg-nested-interrupt (sg new-fn.args old-fn.args)
  (let* ((fn (cadr new-fn.args))
         (args (cddr new-fn.args)))
    (prog1
      (apply fn args)
      (setf (sg.interrupt-function.args sg) old-fn.args)
      (cheap-free-list new-fn.args))))

; This is called just before exiting lisp context to be sure that
; there is enough space on the VSP stack for ppc-ff-call (ffcalladdress) to
; vpush_saveregs.
(defppclapfunction %ensure-vsp-stack-space ()
  (vpush rzero)   ; 1
  (vpush rzero)   ; 2
  (vpush rzero)   ; 3
  (vpush rzero)   ; 4
  (vpush rzero)   ; 5
  (vpush rzero)   ; 6
  (vpush rzero)   ; 7
  (vpush rzero)   ; 8
  (la vsp 32 vsp)
  (blr))

; Reverse special bindings, but don't mess with *interrupt-level*
; A special binding is [link, symbol, value]
(defppclapfunction %reverse-special-bindings ((set-db-link-p arg_z))
  (let ((last-db imm0)
        (db imm1)
        (sym imm2)
        (next-db imm2)
        (value imm3)
        (sym-value imm4)
        (*interrupt-level*-sym temp0)
        (top-catch arg_y))
    (cmp cr1 set-db-link-p rnil)
    (lwz *interrupt-level*-sym '*interrupt-level* nfn)
    (la top-catch (+ 8 ppc::fulltag-misc) tsp)
    (bne cr1 @dont-zero)
    (set-global rzero db-link)          ; Prevent interrupt from modifying wrong binding
  @dont-zero
    (svref db ppc::catch-frame.db-link-cell top-catch)
    (li last-db 0)
    (b @test)

  @loop
    (lwz sym 4 db)
    (cmp cr0 sym *interrupt-level*-sym)
    (beq @skip)
    (lwz value 8 db)
    (lwz sym-value ppc::symbol.vcell sym)
    (svset value ppc::symbol.vcell-cell sym t)
    (stw sym-value 8 db)
  @skip
    (lwz next-db 0 db)
    (stw last-db 0 db)
    (mr last-db db)
    (mr db next-db)
  @test
    (cmpwi cr0 db 0)
    (bne cr0 @loop)
  
    (svset last-db ppc::catch-frame.db-link-cell top-catch t)
    (beq cr1 @return)
    (set-global last-db db-link))
  @return
  (blr))

; Save the global state in a stack group
; %normalize-areas has already done most of the work.
(defppclapfunction %save-stack-group-context ((sg arg_z))
  (let ((address imm0)
        (data imm1))

    ; Update active pointer for vsp area to include the 8 words pushed by .SPffcall
    (ref-global address current-vs)
    (la data (- (* 4 8)) vsp)           ; .SPffcall pushes the 8 saved registers on the VSP
    (stw data ppc::area.active address)

    (ref-global data cs-overflow-limit)
    (svset data sg.cs-overflow-limit sg t)
    (ref-global data vs-overflow-limit)
    (svset data sg.vs-overflow-limit sg t)
    (ref-global data ts-overflow-limit)
    (svset data sg.ts-overflow-limit sg t)
    ;; Prevent stack overflow when we reenter this code (may not be necessary)
    (set-global rzero cs-overflow-limit)
    (set-global rzero vs-overflow-limit)
    (set-global rzero ts-overflow-limit)
    (set-global rzero db-link))
  (blr))

; Initialize the global vars from a stack group.
; This is the first thing that happens when a stack group switches in.
; Assumes that a catch frame is on the top of the tsp.
; The vsp has already been restored by .SPffcall
(defppclapfunction %restore-stack-group-context ((sg arg_z))
  (let ((temp imm0))
    (svref temp sg.cs-area sg)
    (set-global temp current-cs)
    (svref temp sg.vs-area sg)
    (set-global temp current-vs)
    (svref temp sg.ts-area sg)
    (set-global temp current-ts)
    (lwz tsp ppc::area.active temp)
    (svref temp sg.cs-overflow-limit sg)
    (set-global temp cs-overflow-limit)
    (svref temp sg.vs-overflow-limit sg)
    (set-global temp vs-overflow-limit)
    (svref temp sg.ts-overflow-limit sg)
    (set-global temp ts-overflow-limit)
    (la temp (+ 8 ppc::fulltag-misc) tsp)
    (set-global temp catch-top))
  (blr))

(def-ccl-pointers *initial-stack-group* ()
  ; Acces the transition vector from the PPC
  (setq *stack-group-startup-function* (upp-transition-vector threadEntry))
  (let ((sg *initial-stack-group*)
        (current-cs (%get-kernel-global 'current-cs))
        (current-vs (%get-kernel-global 'current-vs))
        (current-ts (%get-kernel-global 'current-ts)))
    (setf (sg.resumer sg) sg
          (sg.cs-area sg) current-cs
          (sg.vs-area sg) current-vs
          (sg.ts-area sg) current-ts
          (sg.cs-overflow-limit sg) (%get-kernel-global 'cs-overflow-limit)
          (sg.threadID sg) #$kApplicationThreadID
          (gc-area.threadid current-cs) #$kApplicationThreadID
          (sg.cs-size sg) (%area-size current-cs)
          (sg.vs-size sg) (max *min-vsp-stack-size* (%area-size current-vs))
          (sg.ts-size sg) (max *min-tsp-stack-size* (%area-size current-ts))
          (sg.maxsize sg) (+ (sg.cs-size sg) (sg.vs-size sg) (sg.ts-size sg)))))

(defun %stack-group-exhausted-p (sg)
  (eql (sg.threadID (sg-buffer sg)) #$kNoThreadID))

; This has been known to cause problems due to the interrupt
; being interrupted by the scheduler. How I don't know, but
; it isn't used anymore.
(defmacro execute-in-stack-group ((stack-frame) &body body)
  (let ((thunk (gensym)))
    `(let ((,thunk #'(lambda () ,@body)))
       (declare (dynamic-extent ,thunk))
       (%funcall-in-stack-group ,stack-frame ,thunk))))

(defvar *canonical-error-value*
  '(*canonical-error-value*))

(defun %funcall-in-stack-group (sg thunk)
  (sg-buffer sg)                        ; type check
  (if (eq sg *current-stack-group*)
    (funcall thunk)
    (without-interrupts
     (let* ((sg-thunk #'(lambda (thunk)
                          (let ((values (multiple-value-list (funcall thunk))))
                            (declare (dynamic-extent values))
                            (cheap-copy-list values))))
            (values (let-globally ((*in-scheduler* t))
                      (stack-group-interrupt
                       sg *canonical-error-value* sg-thunk thunk))))
       (if (eq values *canonical-error-value*)
         (error "Error in stack-group-interrupt on ~s" sg)
         (multiple-value-prog1
           (apply 'values values)
           (cheap-free-list values)))))))

#|  ; obsolete version.
(defun symbol-value-in-stack-group (sym sg)
  (unless (symbolp sym)
    (setq sym (require-type sym 'symbol)))
  (let* ((unbound-marker (list nil))
         (res (execute-in-stack-group (sg)
                (if (boundp sym)
                  (symbol-value sym)
                  unbound-marker))))
    (declare (dynamic-extent unbound-marker))
    (if (eq res unbound-marker)
      (error "~s is unbound in ~s" sym sg)
      res)))

(defun (setf symbol-value-in-stack-group) (value sym sg)
  (unless (symbolp sym)
    (setq sym (require-type sym 'symbol)))
  (execute-in-stack-group (sg)
    (setf (symbol-value sym) value)))
|#

(defun symbol-value-in-stack-group (sym sg)
  (let ((loc (%symbol-value-locative-in-stack-group sym sg)))
    (if (null loc)
      (symbol-value sym)
      (let ((val (%fixnum-ref loc)))
        (when (eq val (%unbound-marker-8))
          (error "~s is unbound in ~s" sym sg))
        val))))

(defun (setf symbol-value-in-stack-group) (value sym sg)
  (let ((loc (%symbol-value-locative-in-stack-group sym sg)))
    (if (null loc)
      (setf (symbol-value sym) value)
      (setf (%fixnum-ref loc) value))))

(defun %symbol-value-locative-in-stack-group (sym sg)
  (sg-buffer sg)                        ; type check
  (if (eq sg *current-stack-group*)
    nil
    (or (%last-symbol-value-locative-in-db-chain
         sym (db-link sg))
        (%last-symbol-value-locative-in-db-chain
         sym (db-link)))))

(defun %last-symbol-value-locative-in-db-chain (sym db)
  (let ((last-found nil))
    (loop
      (when (eql 0 db) (return))
      (when (eq sym (%fixnum-ref db 4))
        (setq last-found db))
      (setq db (%fixnum-ref db 0)))
    (and last-found (%i+ last-found 2))))

; energized is the opposite of exhausted, right?
(defmacro do-unexhausted-stack-groups ((s) &body body)
  `(dolist (,s (population-data *stack-group-population*))
     (unless (%stack-group-exhausted-p ,s)
       ,@body)))

(defmacro do-inactive-stack-groups ((s) &body body)
  (let* ((current (gensym)))
    `(let ((,current *current-stack-group*))
       (do-unexhausted-stack-groups (,s)
         (unless (eq ,s ,current)
           ,@body)))))

(defvar *ram-size-macptr* (%null-ptr))
(declaim (type macptr *ram-size-macptr*))

; Start up the stack groups that were active at save-application time.
(def-ccl-pointers stack-groups ()
  (setq *ram-size-macptr* (%int-to-ptr (gestalt #$GestaltLogicalRAMSize)))
  (do-inactive-stack-groups (s)
    (unless (eq s *initial-stack-group*)
      (let* ((fn.args (sg.initial-function.args s)))
        (when (and (listp fn.args) (functionp (car fn.args)))
          (apply 'stack-group-preset s (car fn.args) (cdr fn.args)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Backtrace support
;;;

; Linked list of fake stack frames.
; %frame-backlink looks here
(defvar *fake-stack-frames* nil)

(def-accessors (fake-stack-frame) %svref
  nil                           ; 'fake-stack-frame
  %fake-stack-frame.sp          ; fixnum. The stack pointer where this frame "should" be
  %fake-stack-frame.next-sp     ; Either sp or another fake-stack-frame
  %fake-stack-frame.fn          ; The current function
  %fake-stack-frame.lr          ; fixnum offset from fn (nil if fn is not functionp)
  %fake-stack-frame.vsp         ; The value stack pointer
  %fake-stack-frame.link        ; next in *fake-stack-frames* list
  )
  
(defmacro %cons-fake-stack-frame (&optional sp next-sp fn lr vsp link)
  `(%istruct 'fake-stack-frame ,sp ,next-sp ,fn ,lr ,vsp ,link))

(defun fake-stack-frame-p (x)
  (istruct-typep x 'fake-stack-frame))

(set-type-predicate 'fake-stack-frame 'fake-stack-frame-p)

(defmacro do-db-links ((db-link &optional var value) &body body)
  (let ((thunk (gensym))
        (var-var (or var (gensym)))
        (value-var (or value (gensym))))
    `(block nil
       (let ((,thunk #'(lambda (,db-link ,var-var ,value-var)
                         (declare (ignorable ,db-link))
                         ,@(unless var (list `(declare (ignore ,var-var))))
                         ,@(unless value (list `(declare (ignore ,value-var))))
                         ,@body)))
         (declare (dynamic-extent ,thunk))
         (map-db-links ,thunk)))))

(defun map-db-links (f)
  (without-interrupts
   (let ((db-link (%fixnum-ref (%get-kernel-global 'db-link))))         ; skip the without-interrupts binding
     (loop
       (when (eql 0 db-link) (return))
       (funcall f db-link (%fixnum-ref db-link 4) (%fixnum-ref db-link 8))
       (setq db-link (%fixnum-ref db-link))))))

(defun %get-frame-ptr (&optional (stack-group *current-stack-group*))
  (sg-buffer stack-group)               ; type check
  (if (eq stack-group *current-stack-group*)
    (%current-frame-ptr)
    (%fixnum-ref (sg.cs-area stack-group) ppc::area.active)))

(defun %stack< (index1 index2 &optional (sg *current-stack-group*))
  (declare (ignore stackseg))
  (cond ((fake-stack-frame-p index1)
         (let ((sp1 (%fake-stack-frame.sp index1)))
           (declare (fixnum sp1))
           (if (fake-stack-frame-p index2)
             (or (%stack< sp1 (%fake-stack-frame.sp index2) sg)
                 (eq index2 (%fake-stack-frame.next-sp index1)))
             (%stack< sp1 (%i+ index2 1) sg))))
        ((fake-stack-frame-p index2)
         (%stack< index1 (%fake-stack-frame.sp index2)))
        (t (let* ((cs-area (sg.cs-area sg)))
             (loop
               (when (%ptr-in-area-p index1 cs-area)
                 (return))
               (setq cs-area (%fixnum-ref cs-area ppc::area.older))
               (when (eql 0 cs-area)
                 ; Should we signal an error here?
                 (return-from %stack< nil)))
             (if (%ptr-in-area-p index2 cs-area)
               (%i< index1 index2)
               (loop
                 (setq cs-area (%fixnum-ref cs-area ppc::area.older))
                 (when (eql 0 cs-area)
                   (return nil))
                 (when (%ptr-in-area-p index2 cs-area)
                   (return t))))))))

(defppclapfunction %current-frame-ptr ()
  (check-nargs 0)
  (mr arg_z sp)
  (blr))

(defppclapfunction %current-vsp ()
  (check-nargs 0)
  (mr arg_z vsp)
  (blr))

(defppclapfunction %set-current-vsp ((new-vsp arg_z))
  (check-nargs 1)
  (mr vsp new-vsp)
  (blr))

(defppclapfunction %current-tsp ()
  (check-nargs 0)
  (mr arg_z tsp)
  (blr))

(defppclapfunction %set-current-tsp ((new-tsp arg_z))
  (check-nargs 1)
  (mr tsp new-tsp)
  (blr))

; This assumes that bit 0 being set in a back pointer can be ignored.
; I believe the system uses that to denote a mode change from
; PPC to/from 68K.
; It also assumes that if bit 1 is set we're at the bottom of the stack;
; it returns 0 in that case.
(defun %frame-backlink (p &optional (sg *current-stack-group*))
  (cond ((fake-stack-frame-p p)
         (%fake-stack-frame.next-sp p))
        ((fixnump p)
         (let ((backlink (%%frame-backlink p))
               (fake-frame (symbol-value-in-stack-group '*fake-stack-frames* sg)))
           (loop
             (when (null fake-frame) (return backlink))
             (when (eq backlink (%fake-stack-frame.sp fake-frame))
               (return fake-frame))
             (setq fake-frame (%fake-stack-frame.link fake-frame)))))
        (t (error "~s is not a valid stack frame" p))))

(defppclapfunction %%frame-backlink ((p arg_z))
  (check-nargs 1)
  (lwz arg_z ppc::lisp-frame.backlink arg_z)
  (rlwinm imm0 arg_z 30 0 0)            ; Bit 1 -> sign bit
  (srawi imm0 imm0 31)                  ; copy sign bit to rest of word
  (andc arg_z arg_z imm0)               ; arg_z = 0 if bit 1 was set
  (rlwinm arg_z arg_z 0 0 29)           ; clear low two bits
  (blr))

(defun %frame-savefn (p)
  (if (fake-stack-frame-p p)
    (%fake-stack-frame.fn p)
    (%%frame-savefn p)))

(defppclapfunction %%frame-savefn ((p arg_z))
  (check-nargs 1)
  (lwz arg_z ppc::lisp-frame.savefn arg_z)
  (blr))

(defppclapfunction %frame-savelr ((p arg_z))
  (check-nargs 1)
  (lwz arg_z ppc::lisp-frame.savelr arg_z)
  (blr))

(defun %frame-savevsp (p)
  (if (fake-stack-frame-p p)
    (%fake-stack-frame.vsp p)
    (%%frame-savevsp p)))

(defppclapfunction %%frame-savevsp ((p arg_z))
  (check-nargs 1)
  (lwz imm0 ppc::lisp-frame.savevsp arg_z)
  (rlwinm imm0 imm0 0 0 30)             ; clear lsb
  (mr arg_z imm0)
  (blr))

(defun frame-vsp (frame &optional parent-vsp sg)
  (declare (ignore parent-vsp sg))
  (%frame-savevsp frame))

(eval-when (:compile-toplevel :execute)
  (assert (eql ppc::t-offset #x11)))

(defppclapfunction %uvector-data-fixnum ((uv arg_z))
  (check-nargs 1)
  (trap-unless-uvector arg_z)
  (la arg_z ppc::misc-data-offset arg_z)
  (blr))

(defun bottom-of-stack-p (p sg)
  (and (fixnump p)
       (locally (declare (fixnum p))
         (or ;;(if (not (osx-p))(<= p 0))  ;; what is this about? - sure wrong if osx, stack can be anywhere 
                                         ;; including way high which is negative in fixnum land
             (let ((cs-area (sg.cs-area sg)))
               (loop
                 (when (%ptr-in-area-p p cs-area)
                   (return nil))
                 (setq cs-area (%fixnum-ref cs-area ppc::area.older))
                 (when (eql 0 cs-area)
                   (return t))))))))

(defun lisp-frame-p (p stack-group)
  (or (fake-stack-frame-p p)
      (locally (declare (fixnum p))
        (let ((next-frame (%frame-backlink p stack-group)))
          (when (fake-stack-frame-p next-frame)
            (setq next-frame (%fake-stack-frame.sp next-frame)))
          (locally (declare (fixnum next-frame))
            (if (bottom-of-stack-p next-frame stack-group)
              (values nil t)
              (eql (ash ppc::lisp-frame.size (- ppc::fixnum-shift))
                   (the fixnum (- next-frame p)))))))))

(defppclapfunction %catch-top ((stack-group arg_z))
  (check-nargs 1)
  (lwz temp0 '*current-stack-group* nfn)
  (lwz temp0 ppc::symbol.vcell temp0)
  (cmp cr0 stack-group temp0)
  (bne cr0 @not-current)

  ; stack-group = *current-stack-group*
  (ref-global arg_z catch-top)
  (cmpwi cr0 arg_z 0)
  (bne @ret)
  (mr arg_z rnil)
 @ret
  (blr)

@not-current
  (svref imm0 sg.ts-area stack-group)
  (lwz imm0 ppc::area.active imm0)
  (la arg_z (+ 8 ppc::fulltag-misc) imm0)
  (blr))

(defun next-catch (catch)
  (let ((next-catch (uvref catch ppc::catch-frame.link-cell)))
    (unless (eql next-catch 0) next-catch)))

(defun catch-frame-sp (catch)
  (uvref catch ppc::catch-frame.csp-cell))

(defun catch-csp-p (p stack-group)
  (let ((catch (%catch-top stack-group)))
    (loop
      (when (null catch) (return nil))
      (let ((sp (catch-frame-sp catch)))
        (when (eql sp p)
          (return t)))
      (setq catch (next-catch catch)))))

; @@@ this needs to load early so errors can work
(defun next-lisp-frame (p stack-group)
  (let ((frame p))
    (loop
      (let ((parent (%frame-backlink frame stack-group)))
        (multiple-value-bind (lisp-frame-p bos-p) (lisp-frame-p parent stack-group)
          (if lisp-frame-p
            (return parent)
            (if bos-p
              (return nil))))
        (setq frame parent)))))

(defun parent-frame (p stack-group)
  (loop
    (let ((parent (next-lisp-frame p stack-group)))
      (when (or (null parent)
                (not (catch-csp-p parent stack-group)))
        (return parent))
      (setq p parent))))

; @@@ this needs to load early so errors can work
(defun cfp-lfun (p stack-group &optional child)
  (declare (ignore stack-group child))
  (if (fake-stack-frame-p p)
    (let ((fn (%fake-stack-frame.fn p))
          (lr (%fake-stack-frame.lr p)))
      (when (and (functionp fn) (fixnump lr))
        (values fn (%fake-stack-frame.lr p))))
    (without-interrupts                   ; Can't GC while we have lr in our hand
     (let ((fn (%frame-savefn p))
           (lr (%frame-savelr p)))
       (declare (fixnum lr))
       (when (functionp fn)
         (let* ((function-vector (%svref fn 0))
                (pc-words (- lr (the fixnum (%uvector-data-fixnum function-vector)))))
           (declare (fixnum pc-words))
           (when (and (>= pc-words 0) (< pc-words (uvsize function-vector)))
             (values fn
                     (the fixnum (ash pc-words ppc::fixnum-shift))))))))))

(defun last-frame-ptr (&optional (stack-group *current-stack-group*))
  (let* ((current (%get-frame-ptr stack-group))
         (last current))
    (loop
      (setq current (parent-frame current stack-group))
      (if current
        (setq last current)
        (return last)))))

(defun child-frame (p sg)
  (let* ((current (%get-frame-ptr sg))
         (last nil))
    (loop
      (when (null current)
        (return nil))
      (when (eq current p) (return last))
      (setq last current
            current (parent-frame current sg)))))

; Used for printing only.
(defun index->address (p)
  (when (fake-stack-frame-p p)
    (setq p (%fake-stack-frame.sp p)))
  (ash p ppc::fixnumshift))

; This returns the current head of the db-link chain.
; The db-link chain is reversed for other than the *current-stack-group*
(defun db-link (&optional (stack-group *current-stack-group*))
  (sg-buffer stack-group)               ; type check
  (if (eq stack-group *current-stack-group*)
    (%get-kernel-global 'db-link)
    (progn
      (when (%stack-group-exhausted-p stack-group)
        (error "~s is exhausted" stack-group))
      (%svref (%catch-top stack-group) ppc::catch-frame.db-link-cell))))

(defun previous-db-link (db-link start &optional (stack-group *current-stack-group*))
  (declare (fixnum db-link start))
  (if (eq stack-group *current-stack-group*)
    (let ((prev nil))
      (loop
        (when (or (eql db-link start) (eql 0 start))
          (return prev))
        (setq prev start
              start (%fixnum-ref start 0))))
    (let ((prev (%fixnum-ref db-link)))
      (unless (eql prev 0) prev))))

(defun count-db-links-in-frame (vsp parent-vsp &optional (stack-group *current-stack-group*))
  (declare (fixnum vsp parent-vsp))
  (let ((db (db-link stack-group))
        (count 0)
        (first nil)
        (last nil)
        (current? (eq stack-group *current-stack-group*)))
    (declare (fixnum db count))
    (loop
      (cond ((eql db 0)
             (unless current?
               (rotatef first last))
             (return (values count (or first 0) (or last 0))))
            ((and (>= db vsp) (< db parent-vsp))
             (unless first (setq first db))
             (setq last db)
             (incf count)))
      (setq db (%fixnum-ref db)))))

; Same as %address-of, but doesn't cons any bignums
; It also left shift fixnums just like everything else.
(defppclapfunction %fixnum-address-of ((x arg_z))
  (check-nargs 1)
  (box-fixnum arg_z x)
  (blr))

(defun %value-cell-header-at-p (cur-vsp)
  (eql ppc::value-cell-header (%fixnum-address-of (%fixnum-ref cur-vsp))))

(defun count-stack-consed-value-cells-in-frame (vsp parent-vsp sg)
  (declare (ignore sg))                 ; use when we have multiple stack segments
  (let ((cur-vsp vsp)
        (count 0))
    (declare (fixnum cur-vsp count))
    (loop
      (when (>= cur-vsp parent-vsp) (return))
      (when (and (evenp cur-vsp) (%value-cell-header-at-p cur-vsp))
        (incf count)
        (incf cur-vsp))                 ; don't need to check value after header
      (incf cur-vsp))
    count))

; stack consed value cells are one of two forms:
;
; nil             ; n-4
; header          ; n = even address (multiple of 8)
; value           ; n+4
;
; header          ; n = even address (multiple of 8)
; value           ; n+4
; nil             ; n+8

(defun in-stack-consed-value-cell-p (arg-vsp vsp parent-vsp sg)
  (declare (ignore sg))                 ; use when we have multiple stack segments
  (declare (fixnum arg-vsp vsp parent-vsp))
  (if (evenp arg-vsp)
    (%value-cell-header-at-p arg-vsp)
    (or (and (> arg-vsp vsp)
             (%value-cell-header-at-p (the fixnum (1- arg-vsp))))
        (let ((next-vsp (1+ arg-vsp)))
          (declare (fixnum next-vsp))
          (and (< next-vsp parent-vsp)
               (%value-cell-header-at-p next-vsp))))))

; Return two values: the vsp of p and the vsp of p's "parent" frame.
; The "parent" frame vsp might actually be the end of p's segment,
; if the real "parent" frame vsp is in another segment.
(defun vsp-limits (p stack-group)
  (let* ((vsp (%frame-savevsp p))
         parent)
    (when (eql vsp 0)
      ; This frame is where the code continues after an unwind-protect cleanup form
      (setq vsp (%frame-savevsp (child-frame p stack-group))))
    (flet ((grand-parent (frame)
             (let ((parent (parent-frame frame stack-group)))
               (when (and parent (eq parent (%frame-backlink frame)))
                 (let ((grand-parent (parent-frame parent stack-group)))
                   (when (and grand-parent (eq grand-parent (%frame-backlink parent)))
                     grand-parent))))))
      (declare (dynamic-extent #'grand-parent))
      (let* ((frame p)
             grand-parent)
        (loop
          (setq grand-parent (grand-parent frame))
          (when (or (null grand-parent) (not (eql 0 (%frame-savevsp grand-parent))))
            (return))
          (setq frame grand-parent))
        (setq parent (parent-frame frame stack-group)))
      (let ((parent-vsp (if parent (%frame-savevsp parent) vsp))
            (vsp-area (%active-area (sg.vs-area stack-group) vsp)))
        (if (eql 0 parent-vsp)
          (values vsp vsp)              ; p is the kernel frame pushed by an unwind-protect cleanup form
          (progn
            (unless vsp-area
              (error "~s is not a stack frame pointer for ~s" p stack-group))
            (unless (%ptr-in-area-p parent-vsp vsp-area)
              (setq parent-vsp (%fixnum-ref vsp-area ppc::area.high)))
            (values vsp parent-vsp)))))))

(defun count-values-in-frame (p stack-group &optional child)
  (declare (ignore child))
  (multiple-value-bind (vsp parent-vsp) (vsp-limits p stack-group)
    (values
     (- parent-vsp 
        vsp
        (* 2 (count-db-links-in-frame vsp parent-vsp stack-group))
        (* 3 (count-stack-consed-value-cells-in-frame vsp parent-vsp stack-group))))))

(defun nth-value-in-frame-loc (sp n sg lfun pc child-frame vsp parent-vsp)
  (declare (ignore child-frame))        ; no ppc function info yet
  (declare (fixnum sp))
  (setq n (require-type n 'fixnum))
  (unless (or (null vsp) (fixnump vsp))
    (setq vsp (require-type vsp '(or null fixnum))))
  (unless (or (null parent-vsp) (fixnump parent-vsp))
    (setq parent-vsp (require-type parent-vsp '(or null fixnum))))
  (unless (and vsp parent-vsp)
    (multiple-value-setq (vsp parent-vsp) (vsp-limits sp sg)))
  (locally (declare (fixnum n vsp parent-vsp))
    (multiple-value-bind (db-count first-db last-db)
                         (count-db-links-in-frame vsp parent-vsp sg)
      (declare (ignore db-count))
      (declare (fixnum first-db last-db))
      (let ((arg-vsp (1- parent-vsp))
            (cnt n)
            (phys-cell 0)
            db-link-p)
        (declare (fixnum arg-vsp cnt phys-cell))
        (loop
          (if (eql (the fixnum (- arg-vsp 2)) last-db)
            (setq db-link-p t
                  arg-vsp last-db
                  last-db (previous-db-link last-db first-db sg)
                  phys-cell (+ phys-cell 2))
            (setq db-link-p nil))
          (unless (in-stack-consed-value-cell-p arg-vsp vsp parent-vsp sg) ;; is this ever true?
            (when (< (decf cnt) 0)
              (return
               (if db-link-p
                 ; Really ought to find the next binding if not the current sg, but
                 ; noone has complained about this bug before, so why fix it?
                 (values (+ 2 arg-vsp)
                         :saved-special
                         (%fixnum-ref (1+ arg-vsp)))
                 (multiple-value-bind (type name) (find-local-name phys-cell lfun pc)
                   (values arg-vsp type name))))))
          (incf phys-cell)
          (when (< (decf arg-vsp) vsp)
            (error "n out of range")))))))

(defun nth-value-in-frame (sp n sg &optional lfun pc child-frame vsp parent-vsp)
  (multiple-value-bind (loc type name)
                       (nth-value-in-frame-loc sp n sg lfun pc child-frame vsp parent-vsp)
    (let ((the-val (%fixnum-ref loc)))
      ;; might really be bogus-object in which case typep errors - or crashes on OSX
      (when (not (bogus-thing-p the-val)) 
        (when (ignore-errors (typep the-val 'value-cell))
          (setq the-val (uvref the-val ppc::value-cell.value-cell))))
      (values the-val type name))))

(defun set-nth-value-in-frame (sp n sg new-value &optional child-frame vsp parent-vsp)
  (let ((loc (nth-value-in-frame-loc sp n sg nil nil child-frame vsp parent-vsp)))
    (let ((the-val (%fixnum-ref loc)))
      (if (and (not (bogus-thing-p the-val))(ignore-errors (typep the-val 'value-cell)))
        (setf (uvref the-val ppc::value-cell.value-cell) new-value)
        (setf (%fixnum-ref loc) new-value)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; bogus-thing-p support
;;;

(defun %ptr-in-area-p (ptr area)
  (declare (fixnum ptr area))
  (and (<= (the fixnum (%fixnum-ref area ppc::area.low)) ptr)
       (>= (the fixnum (%fixnum-ref area ppc::area.high)) ptr)))

(defun %active-area (area active)
  (or (do ((a area (%fixnum-ref a ppc::area.older)))
          ((eql a 0))
        (when (%ptr-in-area-p active a)
          (return a)))
      (do ((a (%fixnum-ref area ppc::area.younger) (%fixnum-ref a ppc::area.younger)))
          ((eql a 0))
        (when (%ptr-in-area-p active a)
          (return a)))))

(defun %ptr-to-vstack-p (sg idx)
  (declare (fixnum idx))
  (sg-buffer sg)                        ; type check
  (let* ((vs-area (%active-area (sg.vs-area sg) idx)))
    (when vs-area
      (let ((active (if (and (eq sg *current-stack-group*)
                             (%ptr-in-area-p (%current-vsp) vs-area))
                      (%current-vsp)
                      (%fixnum-ref vs-area ppc::area.active)))
            (high (%fixnum-ref vs-area ppc::area.high)))
        (declare (fixnum active high))
        (and (< active idx)
             (< idx high))))))

(defun %on-tsp-stack (sg object)
  (declare (fixnum object))             ; lie
  (sg-buffer sg)                        ; type check
  (let* ((ts-area (%active-area (sg.ts-area sg) object)))
    (when ts-area
      (let ((active (if (and (eq sg *current-stack-group*)
                             (%ptr-in-area-p (%current-tsp) ts-area))
                      (%current-tsp)
                      (%fixnum-ref ts-area ppc::area.active)))
            (high (%fixnum-ref ts-area ppc::area.high)))
        (declare (fixnum active high))
        (and (< active object)
             (< object high))))))

(defun on-any-tsp-stack (object)
  (or (%on-tsp-stack *current-stack-group* object)
      (do-inactive-stack-groups (sg)
        (when (%on-tsp-stack sg object)
          (return t)))))

(defun on-any-vstack (idx)
  (or (%ptr-to-vstack-p *current-stack-group* idx)
      (do-inactive-stack-groups (sg)
        (when (%ptr-to-vstack-p sg idx)
          (return t)))))

; This MUST return either T or NIL.
(defun temporary-cons-p (x)
  (and (consp x)
       (not (null (or (on-any-vstack x)
                      (on-any-tsp-stack x))))))

(defmacro do-gc-areas ((area) &body body)
  (let ((initial-area (gensym)))
    `(let* ((,initial-area (%get-kernel-global 'all-areas))
            (,area ,initial-area))
       (declare (fixnum ,initial-area ,area))
       (loop
         (setq ,area (%fixnum-ref ,area ppc::area.succ))
         (when (eql ,area ,initial-area)
           (return))
         ,@body))))

(defmacro do-consing-areas ((area) &body body)
  (let ((code (gensym)))
  `(do-gc-areas (,area)
     (let ((,code (%fixnum-ref ,area ppc::area.code)))
       (when (or (eql ,code ppc::area-readonly)
                 (eql ,code ppc::area-staticlib)
                 (eql ,code ppc::area-static)
                 (eql ,code ppc::area-dynamic))
         ,@body)))))

(defppclapfunction %get-freeptr ()
  (check-nargs 0)
  (mr arg_z freeptr)
  (blr))

; True if the object is in one of the heap areas
(defun %in-consing-area-p (x area)
  (declare (fixnum x))                  ; lie
  (let* ((low (%fixnum-ref area ppc::area.low))
         (high (%fixnum-ref area ppc::area.high))
         (active (%fixnum-ref area ppc::area.active))
         (freeptr (%get-freeptr))
         (curptr (if (and (<= low freeptr)
                          (<= freeptr high))
                   freeptr
                   active)))
    (declare (fixnum low high active freeptr curptr))
    (and (<= low x) (< x curptr))))

(defun in-any-consing-area-p (x)
  (do-consing-areas (area)
    (when (%in-consing-area-p x area)
      (return t))))  

(defun valid-subtag-p (subtag)
  (declare (fixnum subtag))
  (let* ((tagval (ldb (byte (- ppc::num-subtag-bits ppc::ntagbits) ppc::ntagbits) subtag)))
    (declare (fixnum tagval))
    (case (logand subtag ppc::fulltagmask)
      (#. ppc::fulltag-immheader (not (eq (%svref *immheader-types* tagval) 'bogus)))
      (#. ppc::fulltag-nodeheader (not (eq (%svref *nodeheader-types* tagval) 'bogus)))
      (t nil))))

(defun valid-header-p (thing)
  (let* ((fulltag (ppc-fulltag thing)))
    (declare (fixnum fulltag))
    (case fulltag
      (#.ppc::fulltag-misc (valid-subtag-p (ppc-typecode thing)))
      ((#.ppc::fulltag-immheader #.ppc::fulltag-nodeheader) nil)
      (t t))))

(defvar *total-heap-allocated* (total-heap-allocated))

(def-ccl-pointers tha ()
  (setq *total-heap-allocated* (total-heap-allocated)))

(defun bogus-thing-p (x)
  (when x
    (or ;(and (not (osx-p))(not (valid-header-p x)))
        (let ((tag (ppc-lisptag x)))
          (unless (or (eql tag ppc::tag-fixnum)
                      (eql tag ppc::tag-imm)
                      (in-any-consing-area-p x))
            ; Might be in Multifinder heap.  Hard to tell.
            ; Make sure it's in RAM somewhere, more or less.
            ;; how bout its in RAM we own!
            (or (< (the fixnum x) 0)
                (if t ;(osx-p)
                  (or 
                   (not
                    (or (< #x1000 (%address-of x) *total-heap-allocated*)
                        (ON-any-tsp-stack x)(on-any-vstack x)))
                   (not (valid-header-p x))))
                ; This is terribly complicated, should probably write some LAP - spare us the agony
                (and nil ; (not (osx-p))
                     (with-macptrs ((x-ptr (%null-ptr)))
                       (%setf-macptr-to-object x-ptr x)
                       (macptr<= *ram-size-macptr* x-ptr)))
                (let ((typecode (ppc-typecode x)))
                  (not (case typecode
                         (#.ppc::tag-list
                          (temporary-cons-p x))
                         ((#.ppc::subtag-symbol #.ppc::subtag-code-vector)
                          t)              ; no stack-consed symbols or code vectors
                         (#.ppc::subtag-value-cell
                          (or (on-any-vstack x)(on-any-tsp-stack  x)))
                         (t
                          (on-any-tsp-stack x)))))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; terminate-when-unreachable
;;;

#|
Message-Id: <v02130502ad3e6a2f1542@[205.231.144.48]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 7 Feb 1996 10:32:55 -0500
To: pmcldev@digitool.com
From: bitCraft@taconic.net (Bill St. Clair)
Subject: terminate-when-unreachable

I propose that we add a general termination mechanism to PPC MCL.
We need it to properly terminate stack groups, it would be
a nicer way to do the termination for macptrs than the current
ad-hoc mechanism (which BTW is not yet part of PPC MCL), and
it is a nice addition to MCL. I don't think it's hard to make
the garbage collector support this, and I volunteer to do the
work unless Gary really wants to.

I see two ways to support termination:

1) Do termination for hash tables. This was our plan for
   2.0, but Gary got confused about how to mark the objects at
   the right time (or so I remember).

2) Resurrect weak alists (they're not part of the PPC garbage
   collector) and add a termination bit to the population type.
   This allows for termination of weak lists and weak alists,
   though the termination mechanism really only needs termination
   for a single weak alist.

I prefer option 2, weak alists, since it avoids the overhead
necessary to grow and rehash a hash table. It also uses less space,
since a finalizeable hash table needs to allocate two cons cells
for each entry so that the finalization code has some place to
put the deleted entry.

I propose the following interface (slightly modified from what
Apple Dylan provides):

terminate-when-unreachable object &optional (function 'terminate)
  When OBJECT becomes unreachable, funcall FUNCTION with OBJECT
  as a single argument. Each call of terminate-when-unreachable
  on a single (EQ) object registers a new termination function.
  All will be called when the object becomes unreachable.

terminate object                                         [generic function]
  The default termination function

terminate (object t)                                     [method]
  The default method. Ignores object. Returns nil.

drain-termination-queue                                  [function]
  Drain the termination queue. I.e. call the termination function
  for every object that has become unreachable.

*enable-automatic-termination*                           [variable]
  If true, the default, drain-termination-queue will be automatically
  called on the first event check after the garbage collector runs.
  If you set this to false, you are responsible for calling
  drain-termination-queue.

cancel-terminate-when-unreachable object &optional function
  Removes the effect of the last call to terminate-when-unreachable
  for OBJECT & FUNCTION (both tested with EQ). Returns true if
  it found a match (which it won't if the object has been moved
  to the termination queue since terminate-when-unreachable was called).
  If FUNCTION is NIL or unspecified, then it will not be used; the
  last call to terminate-when-unreachable with the given OBJECT will
  be undone.

termination-function object
  Return the function passed to the last call of terminate-when-unreachable
  for OBJECT. Will be NIL if the object has been put in the
  termination queue since terminate-when-unreachable was called.

|#


(defvar *termination-population*
  (%cons-terminatable-alist))

(defvar *enable-automatic-termination* t)

(defun terminate-when-unreachable (object &optional (function 'terminate))
  (let ((new-cell (list (cons object function)))
        (population *termination-population*))
    (without-interrupts
     (setf (cdr new-cell) (population-data population)
           (population-data population) new-cell))
    function))

(defmethod terminate ((object t))
  nil)

(defun drain-termination-queue ()
  (let ((cell nil)
        (population *termination-population*))
    (loop
      (without-interrupts
       (let ((list (population-termination-list population)))
         (unless list (return))
         (setf cell (car list)
               (population-termination-list population) (cdr list))))
      (funcall (cdr cell) (car cell)))))

(defun cancel-terminate-when-unreachable (object &optional (function nil function-p))
  (let ((found-it? nil))
    (flet ((test (object cell)
             (and (eq object (car cell))
                  (or (not function-p)
                      (eq function (cdr cell)))
                  (setq found-it? t))))
      (declare (dynamic-extent #'test))
      (without-interrupts
       (setf (population-data *termination-population*)
             (delete object (population-data *termination-population*)
                     :test #'test
                     :count 1)))
      found-it?)))

(defun termination-function (object)
  (cdr (assq object (population-data *termination-population*))))

(defun do-automatic-termination ()
  (when *enable-automatic-termination*
    (drain-termination-queue)))

(queue-fixup
 (add-gc-hook 'do-automatic-termination :post-gc)
 (add-gc-hook 'terminate-stack-groups :post-gc))


) ; end of progn


