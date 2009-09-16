;;; -*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;; $Log: ppc-def.lisp,v $
;; Revision 1.2  2003/12/08 07:57:29  gtbyers
;; LFUN-VECTOR-NAME handles new GFs.
;;
;;  8 12/22/95 gb   normalize-code-vector
;;  5 10/26/95 akh  damage control
;;  5 10/26/95 gb   macro stuff; %MAKE-CODE-EXECUTABLE
;;  3 10/12/95 slh  lfun-name fix lfun -> fun
;;  (do not edit before this line!!)

;;;
;;; level-0;ppc;ppc-def.lisp

;; 01/10/96 gb normalize-code-vector: header on subprims now.
;; 11/11/95 gb %make-code-executable: stop at opcode of 0 (tbt follows.)
;(in-package "CCL")

#| MISSING
(defun %lfun-vector (lfun &optional (load-p t))
; Note that any code which uses %lfun-vector on the PPC is suspect.
|#

; There are three kinds of things which can go in the function
; cell of a symbol:
; 1) A function.
; 2) The thing which is the value of %unbound-function%: a 1-element
;    vector whose 0th element is a code vector which causes an "undefined function"
;    error to be signalled.
; 3) A macro or special-form definition, which is a 2-element vector whose 0th
;    element is a code vector which signals a "can't apply macro or special form"
;    error when executed and whose 1st element is a macro or special-operator name.
; It doesn't what type of vector cases 2 and 3 are.  Once that's decided, it wouldn't
; hurt if %FHAVE typechecked its second arg.

(defun %fhave (name def)
  (if (consp name)
    (let* ((sym (%car name)))
      (if (eq sym 'setf)
        (%fhave (setf-function-name (cadr name)) def)
        (funcall (function-spec-handler name) name def)))
    (setf (%svref (%symbol->symptr name) ppc::symbol.fcell-cell) def)))

; FBOUNDP is true of any symbol whose function-cell contains something other
; than %unbound-function%; we expect FBOUNDP to return that something.
(defun fboundp (name)
  (if (consp name)
    (let* ((sym (%car name)))
      (if (eq sym 'setf)
        (fboundp (setf-function-name (cadr name)))
        (funcall (function-spec-handler name) name)))
    (let* ((def (%svref (%symbol->symptr name) ppc::symbol.fcell-cell)))
      (unless (eq def %unbound-function%)
        def))))

; %UNFHAVE doesn't seem to want to deal with SETF names or function specs.
; Who does ?

(defun %unfhave (sym)
  (let* ((symptr (%symbol->symptr sym))
         (old (%svref symptr ppc::symbol.fcell-cell)))
    (setf (%svref symptr ppc::symbol.fcell-cell) %unbound-function%)
    (not (eq old %unbound-function%))))

; It's guaranteed that lfun-bits is a fixnum.  Might be a 30-bit fixnum ...
(defun lfun-bits (function &optional new)
  (unless (functionp function)
    (setq function (require-type function 'function)))
  (let* ((idx (1- (the fixnum (uvsize function))))
         (old (%svref function idx)))
    (declare (fixnum idx))
    (if new
      (setf (%svref function idx) new))
    old))


; Remember that %DEFUN calls this and that it calls %nth-immediate (defined in
;  the compiler) in the case where its argument isn't compiled-function-p.

(defun closure-function (fun)
  (while (and (functionp fun)  (not (compiled-function-p fun)))
    (setq fun (%svref fun 1))           ; 0 is %closure-code% or something.
    (when (vectorp fun)
      (setq fun (svref fun 0))))
  fun)

(defun lfun-vector-name (fun &optional (new-name nil set-name-p))
  (let* ((bits (lfun-bits fun)))
    (declare (fixnum bits))
    (if (and (logbitp $lfbits-gfn-bit bits)
	     (not (logbitp $lfbits-method-bit bits)))
      (if set-name-p
	(%gf-name fun new-name)
	(%gf-name fun))
      (let* ((has-name-cell (not (logbitp $lfbits-noname-bit bits))))
	(if has-name-cell
	  (let* ((name-idx (- (the fixnum (uvsize fun)) 2))
		 (old-name (%svref fun name-idx)))
	    (declare (fixnum name-idx))
	    (if (and set-name-p (not (eq old-name new-name)))
	      (setf (%svref fun name-idx) new-name))
	    old-name))))))

(defun lfun-name (fun &optional (new-name nil set-name-p))
  (multiple-value-bind (stored-name stored?) (lookup-lfun-name fun)
    (unless stored?
      (setq stored-name (lfun-vector-name fun)))
    (when (and set-name-p (neq new-name stored-name))
      (if (and stored? (eq new-name (lfun-vector-name fun)))
        (remhash fun *lfun-names*)
        (if (logbitp 29 (the fixnum (lfun-bits fun)))   ; no name-cell in function vector.
          (puthash fun *lfun-names* new-name)
          (lfun-vector-name fun new-name))))
    stored-name))

;;; Fix a code vector so that its subprim references are relative to (this image's) subprims-base.
;;; Then, do an FF-CALL to MakeDataExecutable so that the data cache gets flushed.
;;; This needs to be called inside a WITHOUT-INTERRUPTS.
(defppclapfunction %make-code-executable ((codev arg_z))
  (let ((len temp2))
    (let ((word-offset imm0)
          (unmasked-word imm1)
          (masked-word imm2)
          (ba-mask imm3)
          (ba-val imm4)
          (sp-base temp0)           ; tagged as a fixnum
          (i temp1))
      (save-lisp-context)
      (li i '0)
      (getvheader word-offset codev)
      (header-length len word-offset)
      (lwi ba-mask #.(dpb #x3f (byte 6 26) (ash 1 1)))
      (lwi ba-val  #.(dpb #x12 (byte 6 26) (ash 1 1)))
      (ref-global sp-base subprims-base)
      (li word-offset ppc::misc-data-offset)
      @nextword
      (addi i i '1)
      (cmpw cr0 i len)
      (lwzx unmasked-word codev word-offset)
      (cmpwi cr2 unmasked-word 0)       ; traceback table follows ?
      (and masked-word unmasked-word ba-mask)
      (cmpw cr1 masked-word ba-val)
      (bne+ cr1 @nofix)
      (add unmasked-word unmasked-word sp-base)
      (stwx unmasked-word codev word-offset)
      @nofix
      (addi word-offset word-offset 4)
      (beq cr2 @done)                   ; don't relocate traceback table ...
      (bne cr0 @nextword))
    @done
  ;;; This is going to have to pass a lisp object to a foreign function.
  ;;; If we ever have a preemptive scheduler, we'd better hope that
  ;;; WITHOUT-INTERRUPTS refuses to run lisp code from a callback.
  (stwu sp (- (+ ppc::c-frame.minsize ppc::lisp-frame.size)) sp)      ; make an FFI frame.
  (la imm0 ppc::misc-data-offset codev)
  (stw imm0 ppc::c-frame.param0 sp)
  (stw len ppc::c-frame.param1 sp)
  (ref-global imm3 kernel-imports)
  (lwz arg_z ppc::kernel-import-MakeDataExecutable imm3)
  (bla .SPffcalladdress)
  (mr arg_z rnil)
  (restore-full-lisp-context)
  (blr)))

; Except for a brief moment (before the compiler/fasloader has called
; %make-code-executable), a heap-consed code-vector has had the runtime
; value of subprims-base added to any of its subprim call instructions.
; A code-vector that's been copied to a read-only section makes PC-relative
; calls to a copy of the subprims library that sits at the beginning of
; that section.
; Some things (the fasdumper & disassembler, at least) would find it easier
; to deal with a copy of the code-vector in which all subprim calls are in
; a "normalized" (absolute 16-bit target address) form.  Normalizing a "pure"
; code vector means replacing pc-relative branches with absolute ones; normalizing
; a relocatable code-vectors means adjusting the absolute branch instructions.
; In both cases, "dest" should be some vector which contains at least as many
; bytes as are in the code vector.  Some things (the fasdumper for instance) may
; find it more efficient to re-use the same vector.

; This assumes that any pc-relative branch whose target is before the code-vector's
; entrypoint is a branch to a subprim.
(defppclapfunction %normalize-pure-code-vector ((prefix-words arg_x) (codev arg_y) (dest arg_z))
  (let ((len temp2))
    (let ((word-offset imm0)
          (unmasked-word imm1)
          (masked-word imm2)
          (brel-mask imm3)
          (brel-val imm4)
          (disp temp0)
          (i temp1)
          (curpc temp3)
          (target imm2))
      (li i '0)
      (mr curpc prefix-words)
      (getvheader word-offset codev)
      (header-length len word-offset)
      (lwi brel-mask #.(dpb #x3f (byte 6 26) (dpb 1 (byte 1 25) (ash 1 1))))    ; opcode, LI sign, BA bit
      (lwi brel-val  #.(dpb #x12 (byte 6 26) (dpb 1 (byte 1 25) (ash 0 1))))    ; negative relative branch
      (li word-offset ppc::misc-data-offset)
      @nextword
      (addi i i '1)
      (cmpw cr0 i len)
      (lwzx unmasked-word codev word-offset)
      (cmpwi cr2 unmasked-word 0)       ; traceback table follows ?
      (and masked-word unmasked-word brel-mask)
      (cmpw cr1 masked-word brel-val)
      (bne+ cr1 @nofix)
      (extlwi disp unmasked-word 24 6)
      (srawi disp disp 6)
      (add target curpc disp)
      (cmpw cr1 target prefix-words)
      (rlwimi unmasked-word target 0 6 29)
      (ori unmasked-word unmasked-word (ash 1 1))       ; turn on AA bit
      (bge+ cr1 @nofix)
      (stwx unmasked-word dest word-offset)
      @nofix
      (addi word-offset word-offset 4)
      (addi curpc curpc '1)
      (beq cr2 @done)                   ; don't relocate traceback table ...
      (bne cr0 @nextword))
    @done
    (blr)))

(defppclapfunction %normalize-heap-code-vector ((codev arg_y) (dest arg_z))
  (let ((len temp2))
    (let ((word-offset imm0)
          (unmasked-word imm1)
          (masked-word imm2)
          (ba-mask imm3)
          (ba-val imm4)
          (sp-base temp0)           ; tagged as a fixnum
          (i temp1))
      (li i '0)
      (getvheader word-offset codev)
      (header-length len word-offset)
      (lwi ba-mask #.(dpb #x3f (byte 6 26) (ash 1 1)))
      (lwi ba-val  #.(dpb #x12 (byte 6 26) (ash 1 1)))
      (ref-global sp-base subprims-base)
      (li word-offset ppc::misc-data-offset)
      @nextword
      (addi i i '1)
      (cmpw cr0 i len)
      (lwzx unmasked-word codev word-offset)
      (cmpwi cr2 unmasked-word 0)       ; traceback table follows ?
      (and masked-word unmasked-word ba-mask)
      (cmpw cr1 masked-word ba-val)
      (bne+ cr1 @nofix)
      (sub unmasked-word unmasked-word sp-base)
      (stwx unmasked-word dest word-offset)
      @nofix
      (addi word-offset word-offset 4)
      (beq cr2 @done)                   ; don't relocate traceback table ...
      (bne cr0 @nextword))
    @done
  (blr)))

(defun normalize-code-vector (code-vector 
                              &optional (dest 
                                         (let* ((size (uvsize code-vector))
                                                                  (v (make-array (the fixnum size)
                                                                                 :element-type '(unsigned-byte 32))))
                                                             (declare (fixnum size))
                                           (%copy-ivector-to-ivector code-vector 0 v 0 (the fixnum (ash size 2))))))
  (let* ((readonly-prefix (%readonly-area-word-offset code-vector 2)))
    (if readonly-prefix
      (%normalize-pure-code-vector readonly-prefix code-vector dest)
      (%normalize-heap-code-vector code-vector dest))))
    
(defun %macro-have (symbol macro-function)
  (declare (special %macro-code%))      ; magically set by xloader.
  (%fhave symbol (vector %macro-code% macro-function)))

(defun special-form-p (symbol) 
  "CL. Given a symbol returns non-nil if the symbol defines one of the forms
   designated special by CLtL or by this implementation.
   The non-nil value returned is not functionp."
  (let ((def (fboundp symbol)))
    (and (typep def 'simple-vector)
         (not (lfunp (svref def 1))))))

    


; end of ppc-def.lisp
