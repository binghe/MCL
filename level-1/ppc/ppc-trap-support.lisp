;; ppc-trap-support
;; Copyright 1995-2000 Digitool, Inc.
;;
;; Support for PPC traps, this includes the event-poll trap
;; and all the twxxx traps for type checks & arg count checks.

; Modification History
;
; $Log: ppc-trap-support.lisp,v $
; Revision 1.6  2003/12/08 08:26:19  gtbyers
; Learn about RB-field; handle SLOT-UNBOUND traps.
;
; lisp-reg-p includes ppc::rnil
; ------ 5.2b3
; add in-package
; --------- 5.0 final
; 03/25/97 bill  (defpascal cmain ...) sets *interrupt-level* to 0 before calling (defun cmain ...)
; ---- 4.1b1
; 03/01/97 gb    $xvunbnd traps establish restarts.
; ---- 4.0
; 07/30/96 gb    error-reporting-error via BUG.
; ---- 3.9
; 04/09/96 gb    (defpascal cmain ...) recognizes CHARACTERP check trap failures.
; 04/04/96 bill  (defpascal cmain ...) uses do-db-links to set the first saved value
;                of *interrupt-level* to >= 0.
; 03/22/96 gb    no binary constants, some fixes in DEFPASCAL CMAIN.
; 03/01/96 gb    FP exception stuff
; 02/27/96 bill  call (new) handle-gc-hooks from (defpascal cmain ...)
; 02/20/96 bill  funcall-with-xp-stack-frames never passes NIL as a frame-ptr
; 02/16/96 bill  Get rid of fixup-mask. It was wrong.
;                This eliminates some of the "Unknown trap from kernel ..." errors.
;                funcall-with-xp-stack-frames adds fake-stack-frame instances
;                to *fake-stack-frames* instead of pushing dummy frames on the control stack.
; 01/31/96 bill  in (defpascal cmain ...): unwind-protect the setting of
;                *interrupt-level* to 0. This fixes the bug that caused
;                it to become negative after an abort.
; 01/17/96 bill  with-xp-stack-frames takes a new optional arg that
;                is bound to the erroring stack frame. (defpascal cmain ...)
;                passes this argument to %error instead of letting error
;                assume that (%get-frame-ptr) will do the right thing.
; 01/16/96 bill  %scan-for-instr scans the right direction.
; 12/12/95 bill  (setf xp-gpr-lisp)
; 12/08/95 bill  New file, mostly to speed up compilation during development

(in-package :ccl)

(eval-when (:compile-toplevel :execute)
  (require "NUMBER-MACROS" "ccl:compiler;ppc;number-macros"))

; The #.'s are necessary below since (get-field-offset ..) expands into
; (values n type), and the compiler is not smart enough to notice that
; it's only going to use n, a constant fixnum.
(defun xp-register-offset (register-number)
  (unless (and (fixnump register-number)
               (<= 0 (the fixnum register-number))
               (< (the fixnum register-number) 32))
    (setq register-number (require-type register-number '(integer 0 31))))
  (the fixnum
    (+ (the fixnum 
         (* (the fixnum register-number)
            #.(- (get-field-offset :registerInformationPowerPC.R1.lo)
                 (get-field-offset :registerInformationPowerPC.R0.lo))))
       #.(get-field-offset :registerInformationPowerPC.R0.lo))))

(defmacro with-xp-registers-and-offset ((xp register-number) (registers offset) &body body)
  `(with-macptrs ((,registers (pref ,xp :ExceptionInformationPowerPC.registerImage)))
     (let ((,offset (xp-register-offset ,register-number)))
       ,@body)))

(defun xp-gpr-lisp (xp register-number)
  (with-xp-registers-and-offset (xp register-number) (registers offset)
    (values (%get-object registers offset))))

(defun (setf xp-gpr-lisp) (value xp register-number)
  (with-xp-registers-and-offset (xp register-number) (registers offset)
    (%set-object registers offset value)))

(defun xp-gpr-signed-long (xp register-number)
  (with-xp-registers-and-offset (xp register-number) (registers offset)
    (values (%get-signed-long registers offset))))

(defun xp-gpr-macptr (xp register-number)
  (with-xp-registers-and-offset (xp register-number) (registers offset)
    (values (%get-ptr registers offset))))

(defun xp-argument-list (xp)
  (let ((nargs (xp-gpr-lisp xp ppc::nargs))     ; tagged as a fixnum (how convenient)
        (arg-x (xp-gpr-lisp xp ppc::arg_x))
        (arg-y (xp-gpr-lisp xp ppc::arg_y))
        (arg-z (xp-gpr-lisp xp ppc::arg_z)))
    (cond ((eql nargs 0) nil)
          ((eql nargs 1) (list arg-z))
          ((eql nargs 2) (list arg-y arg-z))
          (t (let ((args (list arg-x arg-y arg-z)))
               (if (eql nargs 3)
                 args
                 (let ((vsp (xp-gpr-macptr xp ppc::vsp)))
                   (dotimes (i (- nargs 3))
                     (push (%get-object vsp (* i 4)) args))
                   args)))))))
    
(defun xp-fpscr-info (xp)
  (let* ((fpscr (pref (pref xp :ExceptionInformationPowerPC.FPUImage) :FPUInformationPowerPC.FPSCR)))
    (values (ldb (byte 24 8) fpscr) (ldb (byte 8 0) fpscr))))

(defun xp-double-float (xp fpr)
  (%double-float-from-macptr! (pref xp :ExceptionInformationPowerPC.FPUImage) (ash fpr 3) (%make-dfloat)))

(defmacro match-instr (instr mask bits-to-match)
  `(eql (logand ,instr ,mask) ,bits-to-match))

(defmacro RA-field (instr)
  `(ldb (byte 5 16) ,instr))

(defmacro RB-field (instr)
  `(ldb (byte 5 11) ,instr))

(defmacro D-field (instr)
  `(ldb (byte 16 0) ,instr))

(defmacro RS-field (instr)
  `(ldb (byte 5 21) ,instr))

(defmacro lisp-reg-p (reg)
  (let ((reg-sym (gensym)))
    `(let ((,reg-sym ,reg))
       (or (> ,reg-sym ppc::fn) (= ,reg-sym ppc::rnil)))))

(defmacro codevec-header-p (word)
  `(eql ppc::subtag-code-vector
        (logand ,word ppc::subtag-mask)))

(defparameter *trap-lookup-tries* 5)

(defmacro scan-for-instr (mask opcode fn pc-index &optional (tries *trap-lookup-tries*))
  `(%scan-for-instr ,mask ,opcode ,fn ,pc-index ,tries))

(defun %scan-for-instr (mask opcode fn pc-index tries)
  (let ((code-vector (and fn (uvref fn 0)))
        (offset 0))
    (declare (fixnum offset))
    (flet ((get-instr ()
             (if code-vector
               (let ((index (+ pc-index offset)))
                 (when (< index 0) (return-from %scan-for-instr nil))
                 (uvref code-vector index))
               (%get-long pc-index (the fixnum (* 4 offset))))))
      (declare (dynamic-extent #'get-instr))
      (dotimes (i tries)
        (decf offset)
        (let ((instr (get-instr)))
          (when (match-instr instr mask opcode)
            (return instr))
          (when (codevec-header-p instr)
            (return nil)))))))

(defmacro with-error-reentry-detection (&body body)
  (let ((thunk (gensym)))
    `(let ((,thunk #'(lambda () ,@body)))
       (declare (dynamic-extent ,thunk))
       (funcall-with-error-reentry-detection ,thunk))))

(defvar *error-reentry-count* 0)

(defun funcall-with-error-reentry-detection (thunk)
  (let* ((count *error-reentry-count*)
         (*error-reentry-count* (1+ count)))
    (cond ((eql count 0) (funcall thunk))
          ((eql count 1)  (error "Error reporting error"))
          (t (bug "Error reporting error")))))

(defmacro with-xp-stack-frames ((xp trap-function &optional stack-frame) &body body)
  (let ((thunk (gensym))
        (sf (or stack-frame (gensym))))
    `(let ((,thunk #'(lambda (&optional ,sf)
                       ,@(unless stack-frame `((declare (ignore ,sf))))
                       ,@body)))
       (declare (dynamic-extent ,thunk))
       (funcall-with-xp-stack-frames ,xp ,trap-function ,thunk))))

(defun return-address-offset (xp fn machine-state-offset)
  (with-macptrs ((machine-state (pref xp :ExceptionInformationPowerPC.machineState)))
    (if (functionp fn)
      (without-interrupts               ; can't GC while function locative is in our hands
       (let* ((lr (%get-object machine-state machine-state-offset))
              (function-vector (uvref fn 0))
              (fn-base (%uvector-data-fixnum function-vector))
              (offset (- lr fn-base)))
         (declare (fixnum lr fn-base offset offset-words))
         (if (and (>= offset 0)
                  (< offset (uvsize function-vector)))
           (ash offset ppc::fixnum-shift)
           (%get-ptr machine-state machine-state-offset))))
      (%get-ptr machine-state machine-state-offset))))

; When a trap happens, we may have not yet created control
; stack frames for the functions containing PC & LR.
; If that is the case, we add fake-stack-frame's to *fake-stack-frames*
; There are 4 cases:
;
; PC in FN
;   Push 1 stack frame: PC/FN
;   This might miss one recursive call, but it won't miss any variables
; PC in NFN
;   Push 2 stack frames:
;   1) PC/NFN/VSP
;   2) LR/FN/VSP
;   This might think some of NFN's variables are part of FN's stack frame,
;   but that's the best we can do.
; LR in FN
;   Push 1 stack frame: LR/FN
; None of the above
;   Push no new stack frames
;
; The backtrace support functions in "ccl:l1;ppc-stack-groups.lisp" know how
; to find the fake stack frames and handle them as arguments.
(defun funcall-with-xp-stack-frames (xp trap-function thunk)
  (cond ((null trap-function)
         ; Maybe inside a subprim from a lisp function
         (let* ((fn (xp-gpr-lisp xp ppc::fn))
                (lr (return-address-offset
                     xp fn (get-field-offset :MachineInformationPowerPC.LR.lo))))
           (if (fixnump lr)
             (let* ((sp (xp-gpr-lisp xp ppc::sp))
                    (vsp (xp-gpr-lisp xp ppc::vsp))
                    (frame (%cons-fake-stack-frame sp sp fn lr vsp *fake-stack-frames*))
                    (*fake-stack-frames* frame))
               (declare (dynamic-extent frame))
               (funcall thunk frame))
             (funcall thunk (xp-gpr-lisp xp ppc::sp)))))
        ((eq trap-function (xp-gpr-lisp xp ppc::fn))
         (let* ((sp (xp-gpr-lisp xp ppc::sp))
                (fn trap-function)
                (lr (return-address-offset
                     xp fn (get-field-offset :MachineInformationPowerPC.PC.lo)))
                (vsp (xp-gpr-lisp xp ppc::vsp))
                (frame (%cons-fake-stack-frame sp sp fn lr vsp *fake-stack-frames*))
                (*fake-stack-frames* frame))
           (declare (dynamic-extent frame))
           (funcall thunk frame)))
        ((eq trap-function (xp-gpr-lisp xp ppc::nfn))
         (let* ((sp (xp-gpr-lisp xp ppc::sp))
                (fn (xp-gpr-lisp xp ppc::fn))
                (lr (return-address-offset
                     xp fn (get-field-offset :MachineInformationPowerPC.LR.lo)))
                (vsp (xp-gpr-lisp xp ppc::vsp))
                (lr-frame (%cons-fake-stack-frame sp sp fn lr vsp))
                (pc-fn trap-function)
                (pc-lr (return-address-offset
                        xp pc-fn (get-field-offset :MachineInformationPowerPC.PC.lo)))
                (pc-frame (%cons-fake-stack-frame sp lr-frame pc-fn pc-lr vsp *fake-stack-frames*))
                (*fake-stack-frames* pc-frame))
           (declare (dynamic-extent lr-frame pc-frame))
           (funcall thunk pc-frame)))
        (t (funcall thunk (xp-gpr-lisp xp ppc::sp)))))

#+ppc-target
(eval-when (:compile-toplevel :execute)
(defmacro ppc-lap-word (instruction-form)
    (uvref (uvref (compile nil
                           `(lambda (&lap 0)
                              (ppc-lap-function () ((?? 0))
                                                ,instruction-form)))
                  
                  0) 0))

(defparameter *ppc-instruction-fields*
  `((:opcode . ,(byte 6 26))
    (:rt . ,(byte 5 21))
    (:to . ,(byte 5 21))
    (:ra . ,(byte 5 16))
    (:rb . ,(byte 5 11))
    (:d . ,(byte 16 0))
    (:mb . ,(byte 5 6))
    (:me . ,(byte 5 1))
    (:x-minor . ,(byte 10 1))
    (:fulltag . ,(byte ppc::ntagbits 0))
    (:lisptag . ,(byte ppc::nlisptagbits 0))))

(defun ppc-instruction-field (field-name)
  (or (cdr (assoc field-name *ppc-instruction-fields*))
      (error "Unknown PPC instruction field: ~s" field-name)))

(defun ppc-instruction-field-mask (field-spec)
  (let* ((name (if (atom field-spec) field-spec (car field-spec)))
         (value (if (atom field-spec) -1 (cadr field-spec))))
    (dpb value (ppc-instruction-field name) 0)))

(defmacro ppc-instruction-mask (&rest fields)
  `(logior ,@(mapcar #'ppc-instruction-field-mask (cons :opcode fields))))

         

)
;; Enter here from handle-trap in "lisp-exceptions.c".
;; xp is a pointer to an ExceptionInformationPowerPC record.
;; the-trap is the trap instruction that got us here.
;; fn-reg is either fn, nfn or 0. If it is fn or nfn, then
;; the trap occcurred in that register's code vector.
;; If it is 0, then the trap occurred somewhere else.
;; pc-index is either the index in fn-reg's code vector
;; or, if fn-reg is 0, the address of the PC at the trap instruction.
;; This code parallels the trap decoding code in
;; "lisp-exceptions.c" that runs if (symbol-value 'cmain)
;; is not a macptr.
;; Some of these could probably call %err-disp instead of error,
;; but I was too lazy to look them up.

#+ppc-target
(defpascal cmain (:ptr xp :long fn-reg :ptr pc-or-index :long the-trap
                       :long ignore-1 :long ignore-2)
  (declare (ignore ignore-1 ignore-2))
  ;; twgti nargs,0
  ;; time for event polling.
  ;; This happens a lot so we test for it first.
  (let ((fn (unless (eql fn-reg 0) (xp-gpr-lisp xp fn-reg))))
    (with-xp-stack-frames (xp fn frame-ptr)
      (if (eql the-trap (ppc-lap-word (twgti nargs 0)))
        (unwind-protect
          (progn
            (handle-gc-hooks)
            (setq *interrupt-level* 0)
            (cmain))
          ; Set the first binding of *interrupt-level* to >= 0
          ; This is the one saved by the without-interrupts in %pascal-functions%
          (do-db-links (db var val)
            (when (eq var '*interrupt-level*)
              (unless (>= (the fixnum val) 0)
                (setf (%fixnum-ref db 8) 0))
              (return))))
        (with-error-reentry-detection
          ;(huh "trap0")
          (let ((pc-index (if (eql fn-reg 0) pc-or-index (%ptr-to-int pc-or-index)))
                instr ra temp rs)
            ;(huh "trap")
            (cond
             
             ;; twnei RA,N; RA = nargs
             ;; nargs check, no optional or rest involved
             ((match-instr the-trap
                           (ppc-instruction-mask :opcode :rt :ra)
                           (ppc-lap-word (twnei nargs ??)))
              (%error (if (< (xp-GPR-signed-long xp ppc::nargs) (D-field the-trap))
                        "Too few arguments (no opt/rest)"
                        "Too many arguments (no opt/rest)" )
                      nil
                      frame-ptr))
             
             ;; twnei RA,N; RA != nargs, N = fulltag_node/immheader
             ;; type check; look for "lbz rt-imm,-3(ra-node)"
             ((and (or (match-instr the-trap
                                    (ppc-instruction-mask :opcode :rt :fulltag)
                                    (ppc-lap-word (twnei ?? ppc::fulltag-nodeheader)))
                       (match-instr the-trap
                                    (ppc-instruction-mask :opcode :rt :fulltag)
                                    (ppc-lap-word (twnei ?? ppc::fulltag-immheader))))
                   (setq instr (scan-for-instr (ppc-instruction-mask :opcode :d)
                                               (ppc-lap-word (lbz ?? ppc::misc-subtag-offset ??))
                                               fn pc-index))
                   (lisp-reg-p (setq ra (RA-field instr))))
              (let* ((typecode (D-field the-trap))
                     (type-tag (logand typecode ppc::fulltagmask))
                     (type-name (svref (if (eql type-tag ppc::fulltag-nodeheader)
                                         *nodeheader-types*
                                         *immheader-types*)
                                       (ldb (byte (- ppc::num-subtag-bits ppc::ntagbits) ppc::ntagbits) typecode))))
                (%error (make-condition 'type-error
                                        :format-string (%rsc-string $XWRONGTYPE)
                                        :datum (xp-GPR-lisp xp ra)
                                        :expected-type type-name)
                        nil
                        frame-ptr)))

             ;; twnei RA,N; RA != nargs, N = subtag_character
             ;; type check; look for "clrlwi rs-node,ra-imm,24" = "rlwinm rs,ra,0,24,31"
             ((and (match-instr the-trap
                                (ppc-instruction-mask :opcode :rt :d)
                                (ppc-lap-word (twnei ?? ppc::subtag-character)))
                   (setq instr (scan-for-instr (ppc-instruction-mask :opcode :rb :mb :me)
                                               (ppc-lap-word (rlwinm ?? ?? 0 24 31))
                                               fn pc-index))
                   (lisp-reg-p (setq rs (RS-field instr))))
              (%error (make-condition 'type-error
                                        :datum (xp-GPR-lisp xp rs)
                                        :expected-type 'character)
                        nil
                        frame-ptr))

             ;; twnei RA,N; RA != nargs, N != fulltag_node/immheader
             ;; type check; look for "clrlwi rs-node,ra-imm,29/30" = "rlwinm rs,ra,0,29/30,31"
             ((and (match-instr the-trap
                                (ppc-instruction-mask :opcode :rt)                                
                                (ppc-lap-word (twnei ?? ??)))
                   (setq instr (scan-for-instr (ppc-instruction-mask :opcode :rb (:mb 28) :me)
                                               (ppc-lap-word (rlwinm ?? ?? 0 28 31))                                               
                                               fn pc-index))
                   (or (eql (- 32 ppc::ntagbits) (setq temp (ldb #.(ppc-instruction-field :mb) instr)))
                       (eql (- 32 ppc::nlisptagbits) temp))
                   (setq rs (RS-field instr)))
              (let* ((tag (logand the-trap ppc::tagmask))
                     (type-name 
                      (case tag
                        (#.ppc::tag-fixnum 'fixnum)
                        (#.ppc::tag-list (if (eql temp (- 32 ppc::ntagbits)) 'cons 'list))
                        (#.ppc::tag-misc 'uvector)
                        (#.ppc::tag-imm 'immediate))))                                      
                (%error (make-condition 'type-error
                                        :datum (xp-GPR-lisp xp rs)
                                        :expected-type type-name)
                        nil
                        frame-ptr)))
             
             ;; twnei RA,N; RA != nargs, N = subtag_character
             ;; type check; look for "clrlwi rs-node,ra-imm,24" = "rlwinm rs,ra,0,24,31"
             ((and (match-instr the-trap
                                (ppc-instruction-mask :opcode :rt :d)
                                (ppc-lap-word (twnei ?? ppc::subtag-character)))
                   (setq instr (scan-for-instr (ppc-instruction-mask :opcode :rb :mb :me)
                                               (ppc-lap-word (rlwinm ?? ?? 0 24 31))
                                               fn pc-index))
                   (lisp-reg-p (setq rs (RS-field instr))))
              (%error (make-condition 'type-error
                                      :datum (xp-GPR-lisp xp rs)
                                      :expected-type 'character)
                      nil
                      frame-ptr))
             
             ;; twlgti RA,N; RA = nargs (xy = 01)
             ;; twllti RA,N; RA = nargs (xy = 10)
             ;; nargs check, optional or rest involved
             ((and (match-instr the-trap
                                (ppc-instruction-mask :opcode (:to #x1c) :ra)
                                (ppc-lap-word (twi ?? ppc::nargs ??)))
                   (or (eql #b01 (setq temp (ldb #.(ppc-instruction-field :to) the-trap)))
	               (eql #b10 temp)))
              (%error (if (eql temp #b10)
                        "Too few arguments (with opt/rest)"
                        "Too many arguments (with opt/rest)")
                      nil
                      frame-ptr))
             
             ;; tweqi RA,N; N = unbound
             ;; symeval boundp check; look for "lwz RA,symbol.vcell(nodereg)"
             ((and (match-instr the-trap
                                (ppc-instruction-mask :opcode :rt :d)                                
                                (ppc-lap-word (tweqi ?? ppc::unbound-marker)))
                   (setq instr (scan-for-instr (ppc-instruction-mask :opcode :d)
                                               (ppc-lap-word (lwz ?? ppc::symbol.vcell ??))                                               
                                               fn pc-index))
                   (lisp-reg-p (setq ra (RA-field instr))))
              (setf (xp-GPR-lisp xp (RA-field the-trap))
                    (%kernel-restart-internal $xvunbnd (list (xp-GPR-lisp xp ra)) frame-ptr)))
             
	     ;; tweqi RA,N: n = (%slot-unbound-marker)
	     ;; slot-unbound trap.  Look for preceding "lwzx RA,rx,ry".
	     ;; rx = slots-vector, ry = scaled index in slots vector.
	     ((and (match-instr the-trap
				(ppc-instruction-mask :opcode :rt :d)
				(ppc-lap-word (tweqi ?? ppc::slot-unbound-marker)))
		   (setq instr (scan-for-instr (ppc-instruction-mask
						:opcode :rt  :x-minor)
					       (dpb
						(RA-field the-trap)
						(byte 5 21)
						(ppc-lap-word
						 (lwzx ?? ?? ??)))
					       fn pc-index)))
              ;; %SLOT-UNBOUND-TRAP will decode the arguments further, then call
              ;; the generic function SLOT-UNBOUND.  That might return a value; if
              ;; so, set the value of the register that caused the trap to that
              ;; value.
              (setf (xp-gpr-lisp xp (ra-field the-trap))
                    (%slot-unbound-trap (xp-gpr-lisp xp (RA-field instr))
                                        (ash (- (xp-gpr-signed-long xp (RB-field instr))
                                                ppc::misc-data-offset)
                                             (- ppc::word-shift))
                                        frame-ptr)))
             ;; twlge RA,RB
             ;; vector bounds check; look for "lwz immreg, misc_header_offset(nodereg)"
             ((and (match-instr the-trap
                                (ppc-instruction-mask :opcode :to :x-minor)                                
                                (ppc-lap-word (twlge 0 0)))
                   (setq instr (scan-for-instr (ppc-instruction-mask :opcode :d)                                               
                                               (ppc-lap-word (lwz ?? ppc::misc-header-offset ??))
                                               fn pc-index))
                   (lisp-reg-p (setq ra (RA-field instr))))
              (%error (%rsc-string $xarroob)
                      (list (xp-GPR-lisp xp (RA-field the-trap))
                            (xp-GPR-lisp xp ra))
                      frame-ptr))
             
             ;; Unknown trap
             (t (%error "Unknown trap from kernel: #x~x~%xp: ~s, fn: ~s, pc: #x~x"
                        (list the-trap xp fn pc-index)
                        frame-ptr)))))))))

#+ppc-target
(defun handle-gc-hooks ()
  (let ((bits *gc-event-status-bits*))
    (declare (fixnum bits))
    (cond ((logbitp $gc-postgc-pending-bit bits)
           (setq *gc-event-status-bits*
                 (logand (lognot (+ (ash 1 $gc-pregc-pending-bit)
                                    (ash 1 $gc-postgc-pending-bit)))
                         bits))
           (let ((f *post-gc-hook*))
             (when (functionp f) (funcall f))))
          ((logbitp $gc-pregc-pending-bit bits)
           (setq *gc-event-status-bits* (bitclr $gc-pregc-pending-bit bits))
           (let ((f *pre-gc-hook*))
             (when (functionp f) (funcall f)))))))
