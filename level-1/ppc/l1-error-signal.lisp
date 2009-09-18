

;;	Change History (most recent first):
;;  $Log: l1-error-signal.lisp,v $
;;  Revision 1.4  2003/12/08 08:29:12  gtbyers
;;  Trap to debugger unless *LISP-CAN-HANDLE-ERRORS* is true.
;;
;;  1 11/13/95 gb   split off from l1-readloop.lisp
;;
;;  (do not edit before this line!!)

;; put error strings from resource fork here
;; ------- 5.2b6
;;; Functions that actually try to signal or handle errors.
;; bump minimum-stack-overflow-size if osx-p
;; -------- 4.4b3
;; 03/26/97 gb    (defpascal %err-disp) : recognize errors during FRSP as "can't coerce".
;; -------------  4.1b1
;; 03/13/97 bill  From Gary: (defpascal %err-disp ...) handles ppc::error-fpu-exception-single
;; 03/12/97 bill  handle-stack-overflow properly updates sg.maxsize
;; 03/04/97 bill  handle-stack-overflow supports *minimum-stack-overflow-size*
;; 12/30/97 bill  handle-udf-call no longer calls bug.
;; 12/30/96 bill  handle-udf-call temporarily calls bug to display the symbol name
;; 10/29/96 bill  (defpascal %err-disp ...) handles ppc::error-too-many-values
;; -------------  4.0
;; 10/11/96 bill  handle-stack-overflow increases stack size while signalling error
;;                so that recursive overflows are less likely.
;; -------------  4.0f1
;; 06/26/96 bill  handle-stack-overflow comes out-of-line from (defpascal %err-disp ...).
;;                It determines if the stack size has gotten too large and signals
;;                a continuable error if it has.
;; 06/25/96 bill  handle-udf-call comes out of line from %err-disp. It makes restarting work.
;; -------------- MCL-PPC 3.9
;; 04/10/96 gb    handle ppc::error-memory-full error.
;; 04/08/96 gb    handle ppc::error-excised-function-call uuo.
;; 03/25/96 bill  (defpascal %err-disp ...) handles ppc::error-throw-tag-missing instead
;;                of the non-existent (to the kernel) ppc::error-divide-by-zero.
;; 03/01/96 gb    %err-disp callback handles (some) FPU exceptions
;; 02/22/96 bill  %kernel-restart-internal passes the frame-ptr as the first arg to
;;                the restart functions.
;; 01/31/96 gb    no need for nilreg-cell-symbol since 3.0.
;; 01/22/96 gb   %err-disp callback recognizes stack-overflow & alloc-failed.
;; 01/17/96 bill  Get frame-ptr from with-xp-stack-frames and call new %err-disp-internal
;;                or %kernel-restart-internal instead of %err-disp & %kernel-restart.
;; 12/08/95 bill  xp-gpr-lisp & friends move from here to ppc-trap-support
;; 11/30/95 bill  Remove the #_DebugStr from error.
;;                (defpascal %err-disp ...) now handles the UUO error codes correctly.
;; 11/29/95 bill  with-error-reentry-detection moves from here to l1-events
;; 11/21/95 bill (defpascal %err-disp ...) to handle callback from handle-error
;;               in lisp-exceptions.c. Wrap with-error-reentry-detection around
;;               the body of %err-disp to prevent infinite %err-disp loops.

;; callback here from C exception handler
#+ppc-target

(defpascal %err-disp (:ptr xp :long fn-reg :long pc-or-index :long errnum :long rb :long continuable)
  (let ((fn (unless (eql fn-reg 0) (xp-gpr-lisp xp fn-reg)))
        (err-fn (if (eql continuable 0) '%err-disp-internal '%kernel-restart-internal)))
    (if (eql errnum ppc::error-stack-overflow)
      (handle-stack-overflow xp fn rb)
      (with-xp-stack-frames (xp fn frame-ptr)   ; execute body with dummy stack frame(s)
        (with-error-reentry-detection
          (let* ((rb-value (xp-gpr-lisp xp rb))
                 (res
                  (cond ((< errnum 0)
                         (%err-disp-internal errnum nil frame-ptr))
                        ((logtest errnum ppc::error-type-error)
                         (funcall err-fn 
                                  #.(car (rassoc 'type-error *kernel-simple-error-classes*))
                                  (list rb-value (logand errnum 63))
                                  frame-ptr))
                        ((eql errnum ppc::error-udf)
                         (funcall err-fn $xfunbnd (list rb-value) frame-ptr))
                        ((eql errnum ppc::error-throw-tag-missing)
                         (%err-disp-internal $xnoctag (list rb-value) frame-ptr))
                        ((eql errnum ppc::error-cant-call)
                         (funcall err-fn $xnotfun (list rb-value) frame-ptr))
                        ((eql errnum ppc::error-udf-call)
                         (return-from %err-disp
                           (handle-udf-call xp frame-ptr)))
                        ((eql errnum ppc::error-alloc-failed)
                         (%error (make-condition 
                                  'simple-storage-condition
                                  :format-string (%rsc-string $xmemfull))
                                 nil frame-ptr))
                        ((eql errnum ppc::error-memory-full)
                         (%error (make-condition 
                                  'simple-storage-condition
                                  :format-string (%rsc-string $xnomem))
                                 nil frame-ptr))
                        ((or (eql errnum ppc::error-fpu-exception-double) 
                             (eql errnum ppc::error-fpu-exception-single))
                         (let* ((code-vector (and fn fn (uvref fn 0)))
                                (instr (if code-vector 
                                         (uvref code-vector pc-or-index)
                                         (%get-long (%int-to-ptr pc-or-index)))))
                           (let* ((minor (ldb (byte 5 1) instr))
                                  (fra (ldb (byte 5 16) instr))
                                  (frb (ldb (byte 5 11) instr))
                                  (frc (ldb (byte 5 6) instr)))
                             (declare (fixnum minor fra frb frc))
                             (if (= minor 12)   ; FRSP
                               (%err-disp-internal $xcoerce (list (xp-double-float xp frc) 'short-float) frame-ptr)
                               (flet ((coerce-to-op-type (double-arg)
                                        (if (eql errnum ppc::error-fpu-exception-double)
                                          double-arg
                                          (handler-case (coerce double-arg 'short-float)
                                            (error (c) (declare (ignore c)) double-arg)))))
                                 (multiple-value-bind (status control) (xp-fpscr-info xp)
                                   (%error (make-condition (fp-condition-from-fpscr status control)
                                                           :operation (fp-minor-opcode-operation minor)
                                                           :operands (list (coerce-to-op-type 
                                                                            (xp-double-float xp fra))
                                                                           (if (= minor 25)
                                                                             (coerce-to-op-type 
                                                                              (xp-double-float xp frc))
                                                                             (coerce-to-op-type 
                                                                              (xp-double-float xp frb)))))
                                           nil
                                           frame-ptr)))))))
                        ((eql errnum ppc::error-excised-function-call)
                         (%error "~s: code has been excised." (list (xp-gpr-lisp xp ppc::nfn)) frame-ptr))
                        ((eql errnum ppc::error-too-many-values)
                         (%err-disp-internal $xtoomanyvalues (list rb-value) frame-ptr))
                        (t (%error "Unknown error #~d with arg: ~d" (list errnum rb-value) frame-ptr)))))
            (setf (xp-gpr-lisp xp rb) res)        ; munge register for continuation
            ))))))

(defun handle-udf-call (xp frame-ptr)
  #|
  (with-pstrs ((str "puile"))
    (#_debugstr str))
  (With-pstrs ((str (symbol-name (xp-gpr-lisp xp ppc::fname))))
    (#_debugstr str))|#
  (let* ((args (xp-argument-list xp))
         (values (multiple-value-list
                  (%kernel-restart-internal
                   $xudfcall
                   (list (xp-gpr-lisp xp ppc::fname) args)
                   frame-ptr)))
         (stack-argcnt (max 0 (- (length args) 3)))
         (vsp (%i+ (xp-gpr-lisp xp ppc::vsp) stack-argcnt))
         (f #'(lambda (values) (apply #'values values))))
    (setf (xp-gpr-lisp xp ppc::vsp) vsp
          (xp-gpr-lisp xp ppc::nargs) 1
          (xp-gpr-lisp xp ppc::arg_z) values
          (xp-gpr-lisp xp ppc::nfn) f)
    (with-macptrs ((machine-state (pref xp :ExceptionInformationPowerPC.machineState)))
      (let ((pc-offset (get-field-offset :MachineInformationPowerPC.PC.lo)))
        (without-interrupts
         (%set-object machine-state
                      pc-offset
                      (%i- (%misc-address-fixnum (uvref f 0))
                           1)))))))     ; handle_uuo will bump pc by 1

(defppclapfunction %misc-address-fixnum ((misc-object arg_z))
  (check-nargs 1)
  (la arg_z ppc::misc-data-offset misc-object)
  (blr))

(defun %stack-group-useable-size (&optional (sg *current-stack-group*))
  (multiple-value-bind (cf cu vf vu tf tu) (%stack-group-stack-space sg)
    (- (+ cf cu vf vu tf tu) (* 2 4096) *cs-hard-overflow-size* *cs-soft-overflow-size*)))


(defvar *allow-stack-overflows* t)

; This probably needs some tuning
(defvar *minimum-stack-overflow-size* (* 100 1024))
(def-ccl-pointers min-sov ()
  (if (osx-p) (setq *minimum-stack-overflow-size* (* 32768 32))))

; rb is the register number of the stack that overflowed.
; xp & fn are passed so that we can establish error context.
(defun handle-stack-overflow (xp fn rb)
  (flet ((stack-overflow-error ()
           (with-xp-stack-frames (xp fn frame-ptr)      ; execute body with dummy stack frame(s)
             (%error
              (make-condition
               'stack-overflow-condition 
               :format-string "Stack overflow on ~a stack.~@
                               To globally increase stack space,~@
                               increase ~s"
               :format-arguments (list
                                  (if (eql rb ppc::sp)
                                    "control"
                                    (if (eql rb ppc::vsp)
                                      "value"
                                      (if (eql rb ppc::tsp)
                                        "temp"
                                        "unknown")))
                                  '*minimum-stack-overflow-size*))
              nil frame-ptr))))
    (declare (dynamic-extent #'stack-overflow-error))
    (if (not (or (eql rb ppc::vsp)
                 (eql rb ppc::tsp)
                 (and (eql rb ppc::sp)
                      (let ((cs-area (%get-kernel-global 'current-cs)))
                        (> (%current-frame-ptr)
                           (%fixnum-ref cs-area ppc::area.softlimit))))))
      (stack-overflow-error)
      (unless *allow-stack-overflows*       ; startup
        (let* ((sg *current-stack-group*)
               (total-used (%stack-group-useable-size sg))
               (maxsize (sg.maxsize sg))
               (total-allowed (max maxsize *minimum-stack-overflow-size*))
               (delta (- total-used total-allowed))
               (diff (max (* 16 1024) (* 2 delta)))
               (continued? nil))
          (when (> delta 0)
            (unwind-protect
              (progn
                (setf (sg.maxsize sg) (+ total-allowed diff))
                (restart-case (stack-overflow-error)
                  (continue ()
                            :report (lambda (stream) 
                                      (format stream "Continue with a larger stack"))
                            (setq continued? t)
                            nil)))
              (unless continued?
                (setf (sg.maxsize sg) maxsize)))))))))

(queue-fixup
 (setq *allow-stack-overflows* nil))

(defun %kernel-restart (error-type &rest args)
  (%kernel-restart-internal error-type args (%get-frame-ptr)))

(defun %kernel-restart-internal (error-type args frame-ptr)
  ;(declare (dynamic-extent args))
  (dolist (f *kernel-restarts* (%err-disp-internal error-type args frame-ptr))
    (when (eq (car f) error-type)
      (return (apply (cdr f) frame-ptr args)))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defconstant pseudo-trap-min 512)
  (defconstant pseudo-trap-interr 512)
  (defconstant pseudo-trap-intcerr 513)
  (defconstant pseudo-trap-wrongnargs 514)
  (defconstant pseudo-trap-toofewargs 515)
  (defconstant pseudo-trap-toomanyargs 516)
  (defconstant pseudo-trap-event-poll 517)
  (defconstant pseudo-trap-unbound 518)
  (defconstant pseudo-trap-slot-unbound 519)
  (defconstant pseudo-trap-vector-bounds 520)
  (defconstant pseudo-trap-udf-call 521)
  (defconstant pseudo-trap-stack-overflow 522)
  (defconstant pseudo-trap-fpu-exception 523)
  
  ;;
  (defconstant pseudo-trap-max 767))


(defun pseudo-trap (trapnum errargs frame-ptr)
  (cond ((eql trapnum pseudo-trap-event-poll)
         (cmain))
        ((or (eql trapnum pseudo-trap-interr)
             (eql trapnum pseudo-trap-intcerr))
         (destructuring-bind (uuo xp-fixnum) errargs
           (with-macptrs (xp)
             (%setf-macptr-to-object xp xp-fixnum)
             (let* ((err-fn (if (eql trapnum pseudo-trap-interr) #'%err-disp-internal #'%kernel-restart-internal))
                    (rb (rb-field uuo))
                    (rb-value (xp-gpr-lisp xp rb))
                    (errnum (ldb (byte 10 16) uuo)))
               (cond ((and (>= errnum ppc::error-subtag-error)
                           (< errnum (* 2 ppc::error-subtag-error)))
                      (%error (make-condition 'type-error
                                              :datum rb-value
                                              :expected-type (%typecode-specifier (logand errnum 255)))
                              nil
                              frame-ptr))
                     ((logtest errnum ppc::error-type-error)
                      (funcall err-fn 
                               #.(car (rassoc 'type-error *kernel-simple-error-classes*))
                               (list rb-value (logand errnum 63))
                               frame-ptr))
                     ((eql errnum ppc::error-udf)
                      (funcall err-fn $xfunbnd (list rb-value) frame-ptr))
                     ((eql errnum ppc::error-throw-tag-missing)
                      (%err-disp-internal $xnoctag (list rb-value) frame-ptr))
                     ((eq errnum ppc::error-unbound)
                      (funcall err-fn $xvunbnd (list rb-value) frame-ptr))
                     (t (%error "Didn't handle pseudo-trap interr/intcerr ~d" (list errnum) frame-ptr)))))))
        ((eql trapnum pseudo-trap-unbound)
         (destructuring-bind (uuo xp-fixnum) errargs
           (with-macptrs (xp)
             (%setf-macptr-to-object xp xp-fixnum)
             (setf (xp-gpr-lisp xp (rs-field uuo))
                   (%kernel-restart-internal $xvunbnd (list (xp-gpr-lisp xp (ra-field uuo))) frame-ptr)))))        
        ((eql trapnum pseudo-trap-slot-unbound)
         (destructuring-bind (uuo xp-fixnum) errargs
           (with-macptrs (xp)
             (%setf-macptr-to-object xp xp-fixnum)
             (setf (xp-gpr-lisp xp (rs-field uuo))
                   (%slot-unbound-trap (xp-gpr-lisp xp (ra-field uuo))
                                       (xp-gpr-lisp xp (rb-field uuo))
                                       frame-ptr)))))
        ((eql trapnum pseudo-trap-vector-bounds)
         (destructuring-bind (uuo xp-fixnum) errargs
           (with-macptrs (xp)
             (%setf-macptr-to-object xp xp-fixnum)
             (%error (%rsc-string $xarroob)
                     (list (xp-gpr-lisp xp (ra-field uuo))
                           (xp-gpr-lisp xp (rb-field uuo)))
                     frame-ptr))))
        ((eql trapnum pseudo-trap-fpu-exception)
         (destructuring-bind (major instr xp-fixnum) errargs
           (with-macptrs (xp)
             (%setf-macptr-to-object xp xp-fixnum)
             (let* ((minor (ldb (byte 5 1) instr))
                    (fra (ldb (byte 5 16) instr))
                    (frb (ldb (byte 5 11) instr))
                    (frc (ldb (byte 5 6) instr)))
               (declare (fixnum minor fra frb frc))
               (if (= minor 12)         ; FRSP
                 (multiple-value-bind (status control) (xp-fpscr-info xp)
                   (%error (make-condition (fp-condition-from-fpscr status control)
                                           :operation 'coerce
                                           :operands (list (xp-double-float xp frc) 'short-float))
                           ()
                           frame-ptr))                 
                 (flet ((coerce-to-op-type (double-arg)
                          (if (eql major 63)
                            double-arg
                            (handler-case (coerce double-arg 'short-float)
                              (error (c) (declare (ignore c)) double-arg)))))
                   (multiple-value-bind (status control) (xp-fpscr-info xp)
                     (%error (make-condition (fp-condition-from-fpscr status control)
                                             :operation (fp-minor-opcode-operation minor)
                                             :operands
                                             (list (coerce-to-op-type 
                                                    (xp-double-float xp fra))
                                                   (if (= minor 25)
                                                     (coerce-to-op-type
                                                      (xp-double-float xp frc))
                                                     (coerce-to-op-type
                                                      (xp-double-float xp frb)))))
                             ()
                             frame-ptr))))))))
        ((eql trapnum pseudo-trap-stack-overflow)
         (let* ((stackreg (car errargs))
                (stack-name (cond ((eql stackreg ppc::vsp) "Value")
                                  ((eql stackreg ppc::tsp) "Temp")
                                  (t "Control"))))
           (%error "~a stack overflow" (list stack-name) frame-ptr)))
        ((eql trapnum pseudo-trap-udf-call)
         (with-macptrs (xp)
           (%setf-macptr-to-object xp (car errargs))
           #+later
           (handle-udf-call xp frame-ptr)
           #-later
           (%err-disp-internal $xudfcall (list (xp-gpr-lisp xp ppc::fname) (xp-argument-list xp)) frame-ptr)))
        ((eql trapnum pseudo-trap-wrongnargs)
         (%error "Wrong number of arguments." () frame-ptr))
        ((eql trapnum pseudo-trap-toofewargs)
         (%error "Too few arguments." () frame-ptr))
        ((eql trapnum pseudo-trap-toomanyargs)
         (%error "Too many arguments." () frame-ptr))
        (t
         (%error "Unknown trap number: ~d" (list trapnum)  frame-ptr))))
        
                   


; this is the def of %err-disp.
; Yup.  That was my first guess.
(defun %err-disp (err-num &rest errargs)
  (let* ((fp (%get-frame-ptr)))
    (if (and (>= err-num pseudo-trap-min)
             (< err-num pseudo-trap-max))
      (pseudo-trap err-num errargs fp)
      (%err-disp-internal err-num errargs fp))))


(defun %err-disp-internal (err-num errargs frame-ptr)
  (declare (fixnum err-num))
  ; The compiler (finally !) won't tail-apply error.  But we kind of
  ; expect it to ...
  (let* ((err-typ (max (ash err-num -16) 0))
         (err-num (%word-to-int err-num))
         (format-string (%rsc-string err-num))
         (condition-name (or (uvref *simple-error-types* err-typ)
                             (%cdr (assq err-num *kernel-simple-error-classes*)))))
    ;(dbg format-string)
    (if condition-name      
      (funcall '%error
               (case condition-name
                 (type-error (make-condition condition-name
                                             :format-string format-string
                                             :datum (car errargs)
                                             :expected-type (%type-error-type (cadr errargs))))
                 (file-error (make-condition condition-name
                                             :pathname (car errargs)
                                             :error-type format-string
                                             :format-arguments (cdr errargs)))
                 (undefined-function (make-condition condition-name
                                                     :name (car errargs)))
                 (simple-reader-error (make-condition condition-name
                                               :stream (car errargs)
                                               :format-string format-string
                                               :format-arguments (cdr errargs)))
                 (t (make-condition condition-name 
                                    :format-string format-string
                                    :format-arguments errargs)))
               nil
               frame-ptr)
      (funcall '%error format-string errargs frame-ptr))))


  

(defvar *lisp-can-handle-errors* nil)

(defun error (condition &rest args)
  (%error condition args (%get-frame-ptr)))

(defun cerror (cont-string condition &rest args)
  (let* ((fp (%get-frame-ptr))
         (eval-queue *eval-queue*))
    (restart-case (%error condition (if (condition-p condition) nil args) fp)
      (continue ()
                :report (lambda (stream) 
                            (apply #'format stream cont-string args))
                (setq *eval-queue* eval-queue)
                nil))))

(defun %error (condition args error-pointer)
  (unless *lisp-can-handle-errors*
    (bug "early error: DBG trap follows")
    (dbg condition))
  (setq condition (condition-arg condition args 'simple-error))
  (signal condition) 
  (application-error *application* condition error-pointer)
  (application-error
   *application*
   (condition-arg "~s returned. It shouldn't.~%If it returns again, I'll throw to toplevel."
                  '(application-error) 'simple-error)
   error-pointer)
  (toplevel))

(defparameter *error-format-strings* 
  '((1 . "Unbound variable: ~S .")
    (2 . "Can't take CDR of ~S.")
    (3 . "Too many arguments.")
    (4 . "Too few arguments.")
    (5 . "Argument ~S is not of the required type.")
    (6 . "Undefined function: ~S .")
    (7 . "Can't take CAR of ~S.")
    (8 . "Can't coerce ~S to ~S")
    (9 . "System version 6.04 or later, MacPlus ROMs or later required.")
    (10 . "Out of memory.")
    (11 . "Default image file not found.")
    (12 . "No translation for ~S")
    (13 . "~S can't be FUNCALLed or APPLYed.")
    (14 . "~S is not a symbol or lambda expression")
    (15 . "Declaration ~S in unexpected position")
    (16 . "Can't setq constant ~S")
    (17 . "Odd number of forms to setq in ~S")
    (18 . "Illegal arg to setq ~S")
    (19 . "~S is not a symbol.")
    (20 . "~S is a constant.")
    (21 . "Bad initialization form: ~S")
    (22 . "Symbol macro ~S is declared or proclaimed special")
    (23 . "Too many arguments in ~S")
    (24 . "Local macro cannot reference lexically defined variable ~S")
    (25 . "Local macro cannot reference lexically defined function ~S")
    (26 . "Local macro cannot reference lexically defined tag ~S")
    (27 . "Local macro cannot reference lexically defined block ~S")
    (28 . "Cant find tag ~S")
    (29 . "Duplicate tag ~S")
    (30 . "Cant find block ~S")
    (31 . "Bad lambda list  ~S.")
    (32 . "~S is not a valid lambda expression.")
    (33 . "Can't throw to tag ~S .")
    (34 . "Object ~S is not of type ~S.")
    (35 . "FUNCTION can't reference lexically defined macro ~S")
    (36 . "Unimplemented FPU instruction ~^~S.")
    (41 . "Unmatched ')'.")
    (42 . "~S and ~S must be on the same volume.")
    (43 . "Filename ~S contains illegal character ~S")
    (44 . "Illegal use of wildcarded filename ~S")
    (45 . "~S is not a FASL or TEXT file.")
    (46 . "Cannot rename directory to file ~S")
    (47 . "Found a directory instead of a file or vice versa ~S")
    (48 . "Cannot copy directories: ~S")
    (49 . "String too long for pascal record")
    (50 . "Cannot create ~S")
    (64 . "Floating point overflow")
    (66 . "Can't divide by zero.")
    (75 . "Stack overflow. Bytes requested: ~d")
    (76 . "Memory allocation request failed.")
    (77 . "~S exceeds array size limit of ~S bytes.")
    (94. "Printer error.")
    (95. "Can't load printer.")
    (96. "Can't get printer parameters.")
    (97. "Can't start up printer job.")
    (98. "Floating point exception.")
    (111 . "Unexpected end of file encountered.")
    (112 . "Array index ~S out of bounds for ~S .")
    (113 . "Reader error: ~S encountered.")
    (114 . "Reader error: Unknown reader macro character ~S .")
    (115 . "Can't redefine constant ~S .")
    (116 . "Reader error: Illegal character ~S .")
    (117 . "Reader error: Illegal symbol syntax.")
    (118 . "Reader error: Dot context error.")
    (119 . "Reader error: Bad value ~S for *READ-BASE*.")
    (120 . "Can't construct argument list from ~S.")
    (121 . "Wrong FASL version.")
    (122 . "Not a FASL file.")
    (123 . "Undefined function ~s called with arguments ~s.")
    (124 . "Image file incompatible with current version of Lisp.")
    (127 . "Using ~S in ~S ~%would cause name conflicts with symbols inherited by that package: ~%~:{~S  ~S~%~}")
    (128 . "Importing ~S to ~S would conflict with inherited symbol ~S ." )
    (129 . "Reader error: Malformed number in a #b/#o/#x/#r macro." )
    (130 . "There is no package named ~S ." )
    (131 . "Reader error: No external symbol named ~S in package ~S ." )
    (132 . "Bad FASL file: internal inconsistency detected." )
    (133 . "Importing ~S to ~S would conflict with symbol ~S ." )
    (134 . "Uninterning ~S from ~S would cause conflicts among ~S ." )
    (135 . "~S is not accessible in ~S ." )
    (136 . "Exporting ~S in ~S would cause a name conflict with ~S in ~S ." )
    (137 . "Using ~S in ~S ~%would cause name conflicts with symbols already present in that package: ~%~:{~S  ~S~%~}")
    (139 . "Reader macro function ~S called outside of reader." )
    (140 . "Reader error: undefined character ~S in a ~S dispatch macro." )
    (141 . "Reader dispatch macro character ~S doesn't take an argument." )
    (142 . "Reader dispatch macro character ~S requires an argument." )
    (143 . "Reader error: Bad radix in #R macro." )
    (144 . "Reader error: Duplicate #~S= label." )
    (145 . "Reader error: Missing #~S# label." )
    (146 . "Reader error: Illegal font number in #\\ macro." )
    (147 . "Unknown character name ~S in #\\ macro." )
    (148 . "~S cannot be accessed with ~S subscripts." )
    (149 . "Requested size is too large to displace to ~S ." )
    (150 . "Too many elements in argument list ~S ." )
    (151 .  "Arrays are not of the same size" )
    (152 . "Conflicting keyword arguments : ~S ~S, ~S ~S .")
    (153 . "Incorrect keyword arguments in ~S .")
    (154 . "Two few arguments in form ~S .")
    (155 . "Too many arguments in form ~S .")
    (157 . "value ~S is not of the expected type ~S.")
    (158 . "~S is not a structure.")
    (159 . "Access to slot ~S of structure ~S is out of bounds.")
    (160 . "Form ~S does not match lambda list ~A .")
    (161 . "Temporary number space exhausted.")
    (163 . "Illegal #+/- expression ~S.")
    (164 . "File ~S does not exist.")
    (165 . "~S argument ~S is not of the required type.")
    (166 . "~S argument ~S is not of type ~S.")
    (167 . "Too many arguments in ~S.")
    (168 . "Too few arguments in ~S.")
    (169 . "Arguments don't match lambda list in ~S.")
    (170 . "~S is not a proper list.")
    (171 . "~S is not an array with a fill pointer.")
    (172 . "~S is not an adjustable array.")
    (173 . "Can't access component ~D of ~S.")
    (174 . "~S doesn't match array element type of ~S.")
    (175 . "Stack group ~S is exhausted.")
    (176 . "Stack group ~S called with arguments ~:S; exactly 1 argument accepted.")
    (177 . "Attempt to return too many values.")
    (178 . "Can't dynamically bind ~S. ")
    (-41 . "Memory full.")
    (-47 . "File ~S is busy or locked.")
    (-48 . "File ~S already exists.")
))
