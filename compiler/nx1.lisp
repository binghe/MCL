;;;-*-Mode: LISP; Package: CCL -*-

;; $Log: nx1.lisp,v $
;; Revision 1.5  2003/12/08 08:21:35  gtbyers
;; Frontend stuff for %SLOT-UNBOUND-MARKER, %SLOT-REF.
;;
;; Revision 1.4  2003/12/01 17:56:05  gtbyers
;; recover pre-MOP changes
;;
;; Revision 1.2  2002/11/18 05:35:10  gtbyers
;; Add CVS log marker
;;
;;	Change History (most recent first):
;;  3 8/25/97  akh  backed out of change
;;  7 7/18/96  akh  nx-let - process decls before arg pairs
;;  5 6/16/96  akh  %negate does (the fixnum (- the fixnum foo))
;;  4 6/7/96   akh  schar, scharcode, and set-scharcode stuff
;;  3 5/23/96  akh  nx1-+ tests type of form vs tupe of acode
;;  2 5/20/96  akh  probably no change
;;  27 4/10/96 gb   
;;  23 2/22/96 Bill St. Clair 3.1d69
;;  22 2/19/96 akh  from gb nx1-lambda-bind - make-array initial-contents nil
;;  21 2/2/96  gb   3.1d63
;;  19 1/18/96 bill 3.0x60
;;  18 1/5/96  bill 3.0x58
;;  16 12/22/95 gb  lots of ppc-target changes
;;  13 12/1/95 gb   nx1-%alloc-misc changes; don't worry about missing progv
;;                   or 68k-specific constructs in 68k-specific forms ...
;;  11 11/19/95 gb  fix nx1-aset parenthesization
;;  10 11/15/95 gb  enable point-h/point-v on ppc
;;
;;  9 11/13/95 gb   3.0x38
;;  6 10/26/95 akh  damage control
;;  6 10/26/95 gb   expand WITHOUT-INTERRUPTS differently for PPC
;;  4 10/14/95 gb   Another LOAD-TIME-VALUE approach.  Do double-float
;;                  cases of relationals, binary ops.
;;  3 10/12/95 slh  load-time-value-lossage error from Gary
;;  2 10/6/95  gb   Straighten out *nx1-xxx-target-inhibit*; more things
;;                  to help cross-compilation.
;;  (do not edit before this line!!)


; Compiler for Coral Common Lisp.

; Copyright 1987-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

; Modification History
; 
; akh fix nx1-setq for dynamic-extent and declared type unknown for floats - don't do it - makes mess e.g. clobber 0.0
; dbg=>dbg-old - no
;; --------- 4.4b3
; 07/29/99 akh values decl
; ------------ 4.3f1c1
; 07/03/99 akh nx1-without-interrupts binds *nx1-without-interrupts*
; 05/09/99 akh  nx1-setq knows about global symbol-macros
; ---------- 4.3b1
;12/31/98 akh 2d-float-aref/aset stuff
;05/31/98 akh dynamic-extent double/short float vars are setq'd with %setf-xxx-float
;07/29/97 akh  nx1-funcall (funcall 'foo ...) == (funcall #'foo ...) - NOPE bad idea
;02/14/97 gb   some short-float and other changes.
;01/24/97 bill point-h & point-v => integer-point-h & integer-point-v
;------------- 4.0
;08/28/96 bill nx1-%new-ptr unconditionally creates acode.
;              It can no lonver generate a call to the %new-ptr function
;09/07/96 gb   handle %schar, %set-schar just to hoist the type decl.
;              [%]SET-SCHAR - open-code if declared as extended string.
;-----------   4.0b1
;07/18/96 gb   nx1-let: make sure initforms processed in old environment.
;06/20/96 gb   nx1-or, nx1-%debug-trap (aka dbg).
; --- 3.9
;04/08/96 gb   #-ppc-target (defnx1 nx1-%gvector ...), %lisp-lowbyte-ref.
;03/28/96 bill Gary's fix to nx1-aset
;03/01/96 bill nx1-ff-call-slep
;03/10/96 gb   double-float ops
;02/21/96 bill Gary's fix to nx1-schar
;01/17/96 bill nx1-aref never optimizes to (%nx1-operator schar) on the PPC, that
;              operator isn't yet implemented.
;01/17/96 gb   %setf-double-float.
;01/03/96 gb   no %primitive either.
;01/03/96 bill no nx1-reg-num for ppc-target
;12/27/95 gb   %type-misc-spelled: allow misc-spellings.  ppc-conditionalize
;              load-time-value.
;12/13/95 gb   add (ppc), use progv. %misc-ref.  Use call-builtin 
;11/15/95 gb   point-h, point-v.  Really.
;11/14/95 slh  mods. for PPC target
;11/11/95 gb   point-h, point-v.
;11/01/95 bill nx1-ppc-ff-call now accepts the syntax that Gary documented
; 3/10/95 slh  nx1-aset: array-element-type -> st-array-element-type here too
;------------- 3.0d17
;09/23/93 bill nx1-flet & nx1-labels allow doc strings.
;------------- 3.0d13
;06/02/93 aice nx1-%set-scharcode
;05/17/93 alice nx1-set-schar distinguishes %set-sbchar for base and %set-schar for either
;05/16/93 alice nx1-schar distinguishes %sbchar, %sechar and %schar for base, extended, either
;05/16/93 alice nx1-code-char unsigned-byte 8 -> 16. nx1-char-code base-character -> character
;04/28/93 bill %get-fixnum & %hget-fixnum added to nx1-get-xxx
;03/25/93 bill in nx1-aref - say st-array-element-type, not array-element-type
;02/08/93 bill maybe-warn-about-nx1-alphatizer-binding
;07/06/92 bill *nx-call-next-method-with-args-p* is no more. Remove it from apply & applyv
;------------- 2.0
;02/26/92 bill nx1-setq now disallows (setq nil 1) : need-sym -> need-var
;08/26/91 bill  no more compiler support for with-port
;05/22/91 bill GB's fix to nx1-aset
;02/06/91 bill nx1-macrolet patch from patch2.0b1p0
;01/22/91 bill nx1-function says var-name vice %car
;10/22/90 bill GB's nx1-setq fix.
;10/20/90 bill GB's nx1-go fix.
;07/06/90 bill *nx-call-next-method-with-args-p*
;06/18/90 bill nx1-symbol-macrolet : alist entry is (symbol bits expansion) vice (symbol bits . expansion)
;04/30/90 gb   lotsa changes.
;12/28/89 gz Support for setf functions in nx1-{flet,labels,function,funcall}.
;09/17/89 gb forget ask & usual.
;08/24/89 gb debind, macro-bind are special forms.
;07/27/89 gz #'call-next-method.
;05/07/89 gb %f+,%f-,%f* (sort of ...)
;04/21/89 gz nx1-lambda-bind.
;03/10/89 gz call-next-method, next-method-p.
;03/03/89 gz lookup synonyms for #'sym.
;12/29/88 gz %schar, %set-schar.
;12/04/88 gz %primitive
;11/15/88 gz %new-ptr, no %vstack-block.
;10/29/88 gb endp, length, list-length, sequence-type.
;9/2/88  gz no more list-reverse.
;           Handle the (%setf-macptr (%null-ptr) ..) idiom.
;           Don't handle with-macptrs.
;8/25/88 gb named blocks, functions for flet, labels.  Despice macrolet error messages.
;8/16/88 gz eql
;8/13/88 gb set, %function, remove unused vars.


(eval-when (:compile-toplevel :load-toplevel :execute)
  (proclaim '(declaration destructive)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (proclaim '(declaration values)))

#-ppc-target

(progn

(defnx1 nx1-%primitive %primitive (&whole whole spnum regnum &rest args &aux subprim revarglist)
  (unless (fixnump (setq subprim (nx-get-fixnum spnum)))
    (report-bad-arg spnum 'fixnum))
  (while args
    (let ((reg (nx1-reg-num regnum)))
      (%temp-push (%temp-cons (nx1-form (pop args)) reg) revarglist))
    (setq regnum (pop args)))
  (when (null regnum) (signal-program-error "Invalid syntax in ~s" whole))
  (make-acode (%nx1-operator %primitive)
              subprim
              revarglist
              (nx1-reg-num regnum)))

(defun nx1-reg-num (name)
  (or (%cdr (assq name '((:a0 . #.$a0) (:atemp0 . #.$atemp0)
                         (:a1 . #.$a1) (:atemp1 . #.$atemp1)
                         (:acc . #.$acc)
                         (:arg_z . #.$arg_z)
                         (:arg_y . #.$arg_y)
                         (:arg_x . #.$arg_x))))
      (dbg)))                           ; Internal error.
)

(defnx1 nx1-the the (&whole call typespec form &environment env)
; Wimp out, but don't choke on (the (values ...) form)
  (if (or (and (consp typespec) (eq (car typespec) 'values))
          (and (self-evaluating-p form)
               (not (typep form typespec))
               (progn (nx1-whine :type call) t)))
    (setq typespec t))
  (let* ((*nx-form-type* typespec))
    (make-acode
     (%nx1-operator typed-form)
     typespec
     (nx1-typed-form form env))))

(defnx1 nx1-struct-ref struct-ref (&whole whole structure offset)
  (if (not (fixnump (setq offset (nx-get-fixnum offset))))
    (nx1-treat-as-call whole)
    (make-acode (%nx1-operator struct-ref)
                (nx1-form structure)
                (nx1-form offset))))

(defnx1 nx1-struct-set struct-set (&whole whole structure offset newval)
  (if (not (fixnump (setq offset (nx-get-fixnum offset))))
    (nx1-treat-as-call whole)
    (make-acode
     (%nx1-operator struct-set)
     (nx1-form structure)
     (nx1-form offset)
     (nx1-form newval))))

(defnx1 nx1-make-list make-list (&whole whole size &rest keys &environment env)
  (if (and keys 
             (or 
              (neq (list-length keys) 2)
              (neq (nx-transform (%car keys) env) :initial-element)))
    (nx1-treat-as-call whole)
    (make-acode
     (%nx1-operator make-list)
     (nx1-form size)
     (nx1-form (%cadr keys)))))

; New semantics: expansion functions are defined in current lexical environment
; vice null environment.  May be meaningless ...
(defnx1 nx1-macrolet macrolet (defs &body body)
  (let* ((old-env *nx-lexical-environment*)
         (new-env (nx-new-lexical-environment old-env)))
    (dolist (def defs)
      (debind (name arglist &body mbody) def
        (%temp-push 
         (%temp-cons 
          name
          (%temp-cons
           'macro
           (multiple-value-bind (function warnings) (compile-named-function (parse-macro name arglist mbody old-env) name t old-env)
             (setq *nx-warnings* (append *nx-warnings* warnings))
             function)))
         (lexenv.functions new-env))))
    (let* ((*nx-lexical-environment* new-env))
      (with-declarations
        (multiple-value-bind (body decls) (parse-body body new-env)
          (nx-process-declarations decls)
          (nx1-progn-body body))))))

; Does SYMBOL-MACROLET allow declarations ?  Yes ...
(defnx1 nx1-symbol-macrolet symbol-macrolet (defs &body forms)
  (let* ((old-env *nx-lexical-environment*))
    (with-declarations
      (multiple-value-bind (body decls)
                           (parse-body forms old-env nil)
        (nx-process-declarations decls)
        (let ((env *nx-lexical-environment*)
              (*nx-bound-vars* *nx-bound-vars*))
          (dolist (def defs)
            (debind (sym expansion) def
              (let* ((var (nx-new-var sym))
                     (bits (nx-var-bits var)))
                (when (%ilogbitp $vbitspecial bits)
                  (nx-error "SPECIAL declaration applies to symbol macro ~s" sym))
                (nx-set-var-bits var (%ilogior (%ilsl $vbitignoreunused 1) bits))
                (setf (var-ea var) (cons :symbol-macro expansion)))))
          (nx-effect-other-decls env)
          (nx1-env-body body old-env))))))

(defnx1 nx1-progn progn (&body args)
  (nx1-progn-body args))

(defun nx1-progn-body (args)
  (if (null (cdr args))
    (nx1-form (%car args))
    (make-acode (%nx1-operator progn) (nx1-formlist args))))

(defnx1 nx1-unaryop ((%word-to-int) (uvsize) (integer-point-h) (integer-point-v) )
        (arg)
  (make-acode
   (%nx1-default-operator) (nx1-form arg)))

#-ppc-target
(defnx1 nx1-68k-unaryop ((%ttag)  (symbolp)
                         (length) (list-length) (ensure-simple-string)
                         (symbol-name)   (%vect-subtype))
        (&whole w arg)
  (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
    (make-acode
     (%nx1-default-operator) (nx1-form arg))
    (nx1-treat-as-call w)))

#-ppc-target
(defnx1 nx1-ppc-unaryop ((ppc-typecode) (ppc-lisptag) (ppc-fulltag))
        (&whole w arg)
  (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
    (nx1-treat-as-call w)
    (make-acode
     (%nx1-default-operator) (nx1-form arg))))

#+ppc-target
(defnx1 nx1-ppc-unaryop ((ppc-typecode) (ppc-lisptag) (ppc-fulltag))
        (arg)
  (make-acode
   (%nx1-default-operator) (nx1-form arg)))
        

(defnx1 nx1-code-char ((code-char)) (arg &environment env)
  (make-acode (if (nx-form-typep arg '(unsigned-byte 16) env)
                (%nx1-operator %code-char)
                (%nx1-operator code-char))
              (nx1-form arg)))

(defnx1 nx1-char-code ((char-code)) (arg &environment env)
  (make-acode (if (nx-form-typep arg 'character env)
                (%nx1-operator %char-code)
                (%nx1-operator char-code))
              (nx1-form arg)))

(defnx1 nx1-cXr ((car) (cdr)) (arg &environment env)
  (let* ((op (if (eq *nx-sfname* 'car) (%nx1-operator car) (%nx1-operator cdr)))
         (inline-op (if (eq op (%nx1-operator car)) (%nx1-operator %car) (%nx1-operator %cdr))))
    (make-acode (if (or (nx-inline-car-cdr env) (nx-form-typep arg 'list env))
                  inline-op
                  op)
                (nx1-prefer-areg arg env))))

(defnx1 nx1-rplacX ((rplaca) (rplacd)) (pairform valform &environment env)
  (let* ((op (if (eq *nx-sfname* 'rplaca) (%nx1-operator rplaca) (%nx1-operator rplacd)))
         (inline-op (if (eq op (%nx1-operator rplaca)) (%nx1-operator %rplaca) (%nx1-operator %rplacd))))
    (make-acode (if (or (nx-inline-car-cdr env)
                                 (and (nx-trust-declarations env)
                                      (or (subtypep *nx-form-type* 'cons)
                                          (nx-form-typep pairform 'cons env))))
                  inline-op
                  op)
                (nx1-prefer-areg pairform env)
                (nx1-form valform))))

(defnx1 nx1-set-cXr ((set-car) (set-cdr)) (pairform valform &environment env)
  (let* ((op (if (eq *nx-sfname* 'set-car) (%nx1-operator set-car) (%nx1-operator set-cdr)))
         (inline-op (if (eq op (%nx1-operator set-car)) (%nx1-operator %rplaca) (%nx1-operator %rplacd)))
         (inline-p (or (nx-inline-car-cdr env)
                            (and (nx-trust-declarations env)
                                 (or (subtypep *nx-form-type* 'cons)
                                     (nx-form-typep pairform 'cons env)))))
         (acode (make-acode (if inline-p inline-op op)
                            (nx1-prefer-areg pairform env)
                            (nx1-form valform))))
    (if inline-p
      (make-acode (if (eq op (%nx1-operator set-car)) (%nx1-operator %car) (%nx1-operator %cdr)) acode)
      acode)))

(defun nx1-cc-binaryop (op cc form1 form2)
  (make-acode op (nx1-immediate cc) (nx1-form form1) (nx1-form form2)))

(defnx1 nx1-ccEQ-unaryop ((characterp)  (endp) (consp) (base-character-p)) (arg)
  (make-acode (%nx1-default-operator) (nx1-immediate $ccEQ) (nx1-form arg)))

#-ppc-target
(defnx1 nx1-sequence-type ((sequence-type)) (&whole whole arg)
  (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
    (make-acode (%nx1-operator sequence-type) (nx1-immediate $ccEQ) (nx1-form arg))
    (nx1-treat-as-call whole)))

#-ppc-target
(defnx1 nx1-%ttagp ((%ttagp)) (form1 form2)
  (nx1-cc-binaryop (%nx1-operator %ttagp) $ccEQ form1 form2))

(defnx1 nx1-ccEQ-binaryop ( (%ptr-eql) (eq))
        (form1 form2)
  (nx1-cc-binaryop (%nx1-default-operator) $ccEQ form1 form2))

(defnx1 nx1-ccNE-binaryop ((neq))
        (form1 form2)
  (nx1-cc-binaryop (%nx1-default-operator) $ccNE form1 form2))

(defnx1 nx1-logbitp ((logbitp)) (&whole w bitnum int &environment env)
  (if (and (nx-form-typep bitnum (if (ppc-target-p)
                                   '(integer 0 29)
                                   '(integer 0 28)) 
                          env)
           (nx-form-typep int 'fixnum env))
    (nx1-cc-binaryop (%nx1-operator %ilogbitp) $ccNE bitnum int)
    (make-acode (%nx1-operator logbitp) (nx1-form bitnum) (nx1-form int))))


  
(defnx1 nx1-ccGT-unaryop ((int>0-p)) (arg)
  (make-acode (%nx1-default-operator) (nx1-immediate $ccGT) (nx1-form arg)))

(defnx1 nx1-macro-unaryop (multiple-value-list) (arg)
  (make-acode
   (%nx1-default-operator) (nx1-form arg)))

(defnx1 nx1-atom ((atom)) (arg)
  (nx1-form `(not (consp ,arg))))

(defnx1 nx1-locally locally (&body forms)
  (with-declarations
    (let ((env *nx-lexical-environment*))
      (multiple-value-bind (body decls) (parse-body forms env  nil)
        (nx-process-declarations decls)
        (nx-effect-other-decls env)
         (setq body (nx1-progn-body body))
         (if decls
           (make-acode (%nx1-operator %decls-body) body *nx-new-p2decls*)
           body)))))

(defnx1 nx1-%new-ptr (%new-ptr) (&whole whole size clear-p)
  (make-acode (%nx1-operator %new-ptr) (nx1-form size) (nx1-form clear-p)))

; This might also want to look at, e.g., the last form in a progn:
;  (not (progn ... x)) => (progn ... (not x)), etc.
(defnx1 nx1-negation ((not) (null)) (arg)
  (if (nx1-negate-form (setq arg (nx1-form arg)))
    arg
    (make-acode (%nx1-operator not) (nx1-immediate $ccEQ) arg)))

(defun nx1-negate-form (form)
  (let* ((subform (nx-untyped-form form)))
    (when (and (acode-p subform) (typep (acode-operator subform) 'fixnum))  
      (let* ((op (acode-operator subform)))
        (declare (fixnum op))
        (when (logbitp operator-cc-invertable-bit op)
          (%rplaca 
           (%cdr (%cadr subform))
           (%ilogxor2 (%cadr (%cadr subform)) 1))
          t)))))

; This is called from pass 1, and therefore shouldn't mess with "puntable bindings"
; (assuming, of course, that anyone should ...)
(defun nx-untyped-form (form)
  (while (and (consp form)
              (eq (%car form) (%nx1-operator typed-form)))
    (setq form (%caddr form)))
  form)

#-ppc-target
(defnx1 nx1-cxxr ((caar) (cadr) (cdar) (cddr)) (form)
  (let* ((op *nx-sfname*))
    (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
      (make-acode 
       (%nx1-operator cxxr)
       (make-acode 
        (%nx1-operator fixnum)
        (case op
          (caar #.$sp-caar)
          (cadr #.$sp-cadr)
          (cdar #.$sp-cdar)
          (t #.$sp-cddr)))
       (nx1-form form))
      (let* ((inner (case op 
                       ((cdar caar) 'car)
                       (t 'cdr)))
              (outer (case op
                       ((cdar cddr) 'cdr)
                       (t 'car))))
         (nx1-form `(,outer (,inner ,form)))))))

#+ppc-target
(defnx1 nx1-cxxr ((caar) (cadr) (cdar) (cddr)) (form)
  (let* ((op *nx-sfname*))
    (let* ((inner (case op 
                       ((cdar caar) 'car)
                       (t 'cdr)))
              (outer (case op
                       ((cdar cddr) 'cdr)
                       (t 'car))))
         (nx1-form `(,outer (,inner ,form))))))      

(defnx1 nx1-%int-to-ptr ((%int-to-ptr)) (int)
  (make-acode 
   (%nx1-operator %consmacptr%)
   (make-acode (%nx1-operator %immediate-int-to-ptr) 
               (nx1-form int))))

(defnx1 nx1-%ptr-to-int ((%ptr-to-int)) (ptr)
  (make-acode 
   (%nx1-operator %immediate-ptr-to-int)
   (make-acode (%nx1-operator %macptrptr%) 
               (nx1-form ptr))))

(defnx1 nx1-%null-ptr-p ((%null-ptr-p)) (ptr)
  (nx1-form `(%ptr-eql ,ptr (%int-to-ptr 0))))

(defnx1 nx1-binop ((uvref) (%ilsl) (%ilsr) (%iasr)
                   (cons) (%temp-cons))
        (arg1 arg2)
  (make-acode (%nx1-default-operator) (nx1-form arg1) (nx1-form arg2)))

(defnx1 nx1-binop ((uvref) (%fixnum-shift-left-right)
                   (cons) (%temp-cons))
        (arg1 arg2)
  (make-acode (%nx1-default-operator) (nx1-form arg1) (nx1-form arg2)))



#-ppc-target
(defnx1 nx1-%misc-ref ((%misc-ref)) (&whole w v i)
  (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
    (nx1-treat-as-call w)
    (make-acode (%nx1-operator uvref) (nx1-form v) (nx1-form i))))

#+ppc-target
(defnx1 nx1-%misc-ref ((%misc-ref)) (v i)
  (make-acode (%nx1-operator uvref) (nx1-form v) (nx1-form i)))

#-ppc-target
(defnx1 nx1-eql ((eql)) (&whole w arg1 arg2)
  (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
    (make-acode (%nx1-operator eql) (nx1-form arg1) (nx1-form arg2))
    (nx1-treat-as-call w)))


#-ppc-target
(defnx1 nx1-schar ((schar)) (&whole w s i &environment env)
  (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
    (make-acode (if (nx-inhibit-safety-checking env)
                  (if (nx-form-typep s 'simple-base-string env)  ; or base-string?
                    (%nx1-operator %sbchar)
                    (if (nx-form-typep s 'simple-extended-string env)
                      (%nx1-operator %sechar)
                      (%nx1-operator %schar)))
                  (%nx1-operator schar))
                (nx1-form s)
                (nx1-form i))
    (let* ((inline-op (if (nx-form-typep s 'simple-extended-string env)
                        (%nx1-operator %sechar)
                        (if (nx-form-typep s 'simple-base-string env)
                          (%nx1-operator %sbchar)))))
      (if inline-op
        (make-acode inline-op (nx1-form s) (nx1-form i))
        (nx1-treat-as-call w)))))

#+ppc-target
(defnx1 nx1-schar ((schar)) (&whole w s i &environment env)
  (let* ((inline-op (if (nx-form-typep s 'simple-extended-string env)
                      (%nx1-operator %sechar)
                      (if (nx-form-typep s 'simple-base-string env)
                        (%nx1-operator %sbchar)
                        (if (nx-inhibit-safety-checking env)
                          (%nx1-operator %schar))))))
    (if inline-op
      (make-acode inline-op (nx1-form s) (nx1-form i))
      (nx1-treat-as-call w))))


#+ppc-target
; This has to be ultra-bizarre because %schar is a macro.
; %schar shouldn't be a macro.
(defnx1 nx1-%schar ((%schar)) (&whole w arg idx &environment env)
  (let* ((arg (nx-transform arg env))
         (idx (nx-transform idx env))
         (argvar (make-symbol "STRING"))
         (idxvar (make-symbol "INDEX"))
         (decl (if (nx-form-typep arg 'simple-extended-string)
                 `((declare (simple-extended-string ,argvar)))                 
                 (if (nx-form-typep arg 'simple-base-string)
                   `((declare (simple-base-string ,argvar)))))))
    (nx1-form `(let* ((,argvar ,arg)
                      (,idxvar ,idx))
                 (declare (optimize (speed 3) (safety 0)))
                 ,@decl
                 (schar ,argvar ,idxvar)) env)))



#-ppc-target
(defnx1 nx1-%scharcode ((%scharcode)) (&whole w s i)
  (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
    (make-acode (%nx1-operator %scharcode)
                (nx1-form s)
                (nx1-form i))
    (nx1-treat-as-call w)))
        
#+ppc-target
(defnx1 nx1-%scharcode ((%scharcode)) (arg idx &environment env)
  (make-acode (%nx1-operator %scharcode) (nx1-form arg)(nx1-form idx)))
        
        

#|
(defnx1 nx1-%df+ ((%df+)) (form1 form2 &optional result)
  (make-acode (%nx1-operator %dfp-combine)
              #o42
              (nx1-form form1)
              (nx1-form form2)
              (nx1-form result)))

(defnx1 nx1-%df- ((%df-)) (form1 form2 &optional result)
  (make-acode (%nx1-operator %dfp-combine)
              #o50
              (nx1-form form1)
              (nx1-form form2)
              (nx1-form result)))
|#

(defnx1 nx1-svref ((svref) (%svref)) (&environment env v i)
  (make-acode (if (nx-inhibit-safety-checking env)
                (%nx1-operator %svref)
                (%nx1-default-operator))
              (nx1-prefer-areg v env)
              (nx1-form i)))



(defnx1 nx1-%slot-ref ((%slot-ref)) (instance idx)
  (make-acode (%nx1-default-operator) (nx1-form instance) (nx1-form idx)))

(defnx1 nx1-%err-disp ((%err-disp)) (&rest args)
  (make-acode (%nx1-operator %err-disp)
              (nx1-arglist args)))                       
              
(defnx1 nx1-macro-binop ((nth-value)) (arg1 arg2)
  (make-acode (%nx1-default-operator) (nx1-form arg1) (nx1-form arg2)))

#-ppc-target
(defnx1 nx1-%typed-uvref ((%typed-uvref)) (&whole whole subtype uvector index)
  (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
    (make-acode (%nx1-operator %typed-uvref) 
                (nx1-form subtype) 
                (nx1-form uvector) 
                (nx1-form index))
    (nx1-treat-as-call whole)))

#-ppc-target
(defnx1 nx1-%typed-miscref ((%typed-miscref) (%typed-misc-ref)) (&whole whole subtype uvector index)
  (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
    (nx1-treat-as-call whole)
    (make-acode (%nx1-operator %typed-uvref) 
                (nx1-form subtype) 
                (nx1-form uvector) 
                (nx1-form index))))

#+ppc-target
(defnx1 nx1-%typed-miscref ((%typed-miscref) (%typed-misc-ref)) (subtype uvector index)
  (make-acode (%nx1-operator %typed-uvref) 
                (nx1-form subtype) 
                (nx1-form uvector) 
                (nx1-form index)))

#-ppc-target
(defnx1 nx1-%typed-uvset ((%typed-uvset)) (&whole whole subtype uvector index newvalue)
  (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
    (make-acode (%nx1-operator %typed-uvset) 
                (nx1-form subtype) 
                (nx1-form uvector) 
                (nx1-form index) 
                (nx1-form newvalue))
    (nx1-treat-as-call whole)))

#-ppc-target
(defnx1 nx1-%typed-miscset ((%typed-miscset) (%typed-misc-set)) (&whole whole subtype uvector index newvalue)
  (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
    (nx1-treat-as-call whole)
    (make-acode (%nx1-operator %typed-uvset) 
                (nx1-form subtype) 
                (nx1-form uvector) 
                (nx1-form index) 
                (nx1-form newvalue))))

#+ppc-target
(defnx1 nx1-%typed-miscset ((%typed-miscset) (%typed-misc-set)) (subtype uvector index newvalue)
  (make-acode (%nx1-operator %typed-uvset) 
                (nx1-form subtype) 
                (nx1-form uvector) 
                (nx1-form index) 
                (nx1-form newvalue)))
 
#-ppc-target
(defnx1 nx1-dtagp ((dtagp)) (&whole whole form mask)
  (if (not (fixnump mask))
    (nx1-treat-as-call whole)
    (make-acode (%nx1-operator dtagp) (nx1-immediate $ccNE) (nx1-form form) mask)))

(defnx1 nx1-logior-2 ((logior-2)) (&whole w &environment env arg-1 arg-2)
  (nx-binary-boole-op w 
                      env 
                      arg-1 
                      arg-2 
                      (%nx1-operator %ilogior2)
                      (%nx1-operator logior2)))

(defnx1 nx1-logxor-2 ((logxor-2)) (&whole w &environment env arg-1 arg-2)
  (nx-binary-boole-op w 
                      env 
                      arg-1 
                      arg-2 
                      (%nx1-operator %ilogxor2)
                      (%nx1-operator logxor2)))

(defnx1 nx1-logand-2 ((logand-2)) (&whole w &environment env arg-1 arg-2)
  (nx-binary-boole-op w 
                      env 
                      arg-1 
                      arg-2 
                      (%nx1-operator %ilogand2)
                      (%nx1-operator logand2)))

(defnx1 nx1-require ((require-simple-vector) (require-simple-string) (require-integer) (require-list)
                     (require-fixnum) (require-real) (require-character) (require-number) (require-symbol))
        (arg)
  (make-acode (%nx1-default-operator) (nx1-form arg)))

(defnx1 nx1-%marker-marker ((%unbound-marker) (%illegal-marker) (%slot-unbound-marker)) ()
  (make-acode (%nx1-default-operator)))

(defnx1 nx1-throw (throw) (tag valuesform)
  (setq *nx-nlexit-count* (%i+ *nx-nlexit-count* 1))
  (make-acode (%nx1-operator throw) (nx1-form tag) (nx1-form valuesform)))

(defnx1 nx1-debind (debind) (lambda-list bindform &body forms)
  (nx1-destructure lambda-list bindform nil t forms))

(defun nx1-destructure (lambda-list bindform cdr-p &whole-allowed-p forms &optional (body-env *nx-lexical-environment*))
  (let* ((old-env body-env)
         (*nx-bound-vars* *nx-bound-vars*)
         (bindform (nx1-form bindform)))
    (if (not (verify-lambda-list lambda-list t &whole-allowed-p))
      (nx-error "Invalid lambda-list ~s" lambda-list)
      (let* ((*nx-lexical-environment* body-env))
        (with-declarations
          (multiple-value-bind (body decls)
                               (parse-body forms *nx-lexical-environment*)
            (nx-process-declarations decls)
            (multiple-value-bind (req opt rest keys auxen whole)
                                 (nx-parse-structured-lambda-list lambda-list nil &whole-allowed-p)
              (nx-effect-other-decls *nx-lexical-environment*)
              (make-acode
               (%nx1-operator debind)
               nil
               bindform
               req
               opt
               rest
               keys
               auxen
               whole
               (nx1-env-body body old-env)
               *nx-new-p2decls*
               cdr-p))))))))

(defnx1 nx1-macro-bind (macro-bind) (lambda-list bindform &body forms)
  (nx1-destructure lambda-list bindform t nil forms))

(defnx1 nx1-%setf-macptr ((%setf-macptr)) (ptr newval)
  (let* ((arg1 (nx1-form ptr))
         (arg2 (nx1-form newval)))
    (if (and (consp arg1) (eq (%car arg1) (%nx1-operator %consmacptr%)))
      ;e.g. (%setf-macptr (%null-ptr) <foo>)
      (make-acode (%nx1-operator %consmacptr%)
                  (make-acode (%nx1-operator progn)
                              (list arg1 (make-acode (%nx1-operator %macptrptr%) arg2))))
      (make-acode (%nx1-operator %setf-macptr) arg1 arg2))))

(defnx1 nx1-%setf-double-float ((%setf-double-float)) (double-node double-val)
  (make-acode (%nx1-operator %setf-double-float) (nx1-form double-node) (nx1-form double-val)))

(defnx1 nx1-%setf-short-float ((%setf-short-float)) (short-node short-val)
  (make-acode (%nx1-operator %setf-short-float) (nx1-form short-node) (nx1-form short-val)))

(defnx1 nx1-%inc-ptr ((%inc-ptr)) (ptr &optional (increment 1))
  (make-acode (%nx1-operator %consmacptr%)
              (make-acode (%nx1-operator %immediate-inc-ptr)
                          (make-acode (%nx1-operator %macptrptr%) (nx1-form ptr))
                          (nx1-form increment))))

(defnx1 nx1-svset ((svset) (%svset)) (&environment env vector index value)
  (make-acode (if (nx-inhibit-safety-checking env)
                (%nx1-operator %svset)
                (%nx1-default-operator))
              (nx1-prefer-areg vector env) (nx1-form index) (nx1-form value)))

(defnx1 nx1-+ ((+-2)) (&whole whole &environment env num1 num2)
  (let* ((f1 (nx1-form num1))
         (f2 (nx1-form num2)))
    (if (and (nx-form-typep num1 'fixnum env) ; (nx-acode-fixnum-type-p f1 env)
             (nx-form-typep num2 'fixnum env)) ;(nx-acode-fixnum-type-p f2 env))
      (let* ((fixadd (make-acode (%nx1-operator %i+) f1 f2))
             (small-enough '(signed-byte 28)))
        (if (or (and (nx-acode-form-typep f1 small-enough env)
                     (nx-acode-form-typep f2 small-enough env))
                (and (nx-trust-declarations env)
                     (subtypep *nx-form-type* 'fixnum)))
          fixadd
          (make-acode (%nx1-operator typed-form) 'integer (make-acode (%nx1-operator fixnum-overflow) fixadd))))
      (if (and (nx-form-typep num1 'double-float env)
               (nx-form-typep num2 'double-float env))
        (nx1-form `(%double-float+-2 ,num1 ,num2))
        (if (and (nx-form-typep num1 'short-float env)
                 (nx-form-typep num2 'short-float env))
          (nx1-form `(%short-float+-2 ,num1 ,num2))
          (make-acode (%nx1-operator typed-form) 'number 
                      (make-acode (%nx1-operator add2) f1 f2)))))))
  
(defnx1 nx1-%double-float-x-2 ((%double-float+-2) (%double-float--2) (%double-float*-2) (%double-float/-2 ))
        (f0 f1)
  (make-acode (%nx1-operator typed-form) 'double-float
              (make-acode (%nx1-default-operator) (nx1-form f0) (nx1-form f1))))

#+ppc-target
(defnx1 nx1-%short-float-x-2 ((%short-float+-2) (%short-float--2) (%short-float*-2) (%short-float/-2 ))
        (f0 f1)
  (make-acode (%nx1-operator typed-form) 'short-float
              (make-acode (%nx1-default-operator) (nx1-form f0) (nx1-form f1))))

#-ppc-target
(defnx1 nx1-*-2 ((*-2)) (&whole whole &environment env num1 num2)
  (if (nx-binary-fixnum-op-p num1 num2 env)
    (make-acode (%nx1-operator %i*) (nx1-form num1 env) (nx1-form num2 env))
    (if (and (nx-form-typep num1 'double-float env)
             (nx-form-typep num2 'double-float env))
      (nx1-form `(%double-float*-2 ,num1 ,num2))
      (if (eq *nx1-68k-target-inhibit* *nx1-target-inhibit*) 
        (make-acode (%nx1-operator commutative-subprim-binop) $sp-times2 (nx1-form num1 env) (nx1-form num2 env))
        (nx1-treat-as-call whole)))))

#+ppc-target
(defnx1 nx1-*-2 ((*-2)) (&whole whole &environment env num1 num2)
  (if (nx-binary-fixnum-op-p num1 num2 env)
    (make-acode (%nx1-operator %i*) (nx1-form num1 env) (nx1-form num2 env))
    (if (and (nx-form-typep num1 'double-float env)
             (nx-form-typep num2 'double-float env))
      (nx1-form `(%double-float*-2 ,num1 ,num2))
      (if (and (nx-form-typep num1 'short-float env)
               (nx-form-typep num2 'short-float env))
        (nx1-form `(%short-float*-2 ,num1 ,num2))
        (nx1-treat-as-call whole)))))

(defnx1 nx1-%negate ((%negate)) (&whole whole num &environment env)
  (if (nx-form-typep num 'fixnum env)
    (if (subtypep *nx-form-type* 'fixnum)
      (make-acode (%nx1-operator %%ineg)(nx1-form num))
      (make-acode (%nx1-operator %ineg) (nx1-form num)))
    (make-acode (%nx1-operator minus1) (nx1-form num))))

        
(defnx1 nx1--2 ((--2)) (&whole whole &environment env num0 num1)
  (if (and (nx-form-typep num0 'fixnum env) (nx-form-typep num1 'fixnum env))
      (let* ((f0 (nx1-form num0))
             (f1 (nx1-form num1))
             (fixsub (make-acode (%nx1-operator %i-) f0 f1))
             (small-enough '(signed-byte 28)))
        (if (or (and (nx-acode-form-typep f0 small-enough env)
                     (nx-acode-form-typep f1 small-enough env))
                (and (nx-trust-declarations env)
                     (subtypep *nx-form-type* 'fixnum)))
          fixsub
          (make-acode (%nx1-operator fixnum-overflow) fixsub)))
      (if (eq *nx1-68k-target-inhibit* *nx1-target-inhibit*) 
        (make-acode (%nx1-operator sub2) (nx1-form num0) (nx1-form num1))
        (if (and (nx-form-typep num0 'double-float env)
                 (nx-form-typep num1 'double-float env))
          (nx1-form `(%double-float--2 ,num0 ,num1))
          (if (and (nx-form-typep num0 'short-float env)
                   (nx-form-typep num1 'short-float env))
            (nx1-form `(%short-float--2 ,num0 ,num1))
            (nx1-treat-as-call whole))))))
      
(defnx1 nx1-/-2 ((/-2)) (num0 num1 &environment env)
  (if (and (nx-form-typep num0 'double-float env)
           (nx-form-typep num1 'double-float env))
    (nx1-form `(%double-float/-2 ,num0 ,num1))
    (if (and (nx-form-typep num0 'short-float env)
             (nx-form-typep num1 'short-float env))
      (nx1-form `(%short-float/-2 ,num0 ,num1))
      (make-acode (%nx1-operator %quo2) (nx1-form num0) (nx1-form num1)))))

#-ppc-target
(defnx1 nx1-numcmp ((<-2) (>-2) (<=-2) (>=-2)) (&whole whole &environment env num1 num2)
  (let* ((op *nx-sfname*)
         (both-fixnums (and (nx-form-typep num1 'fixnum env)
                            (nx-form-typep num2 'fixnum env)))
         (both-double-floats
          (and (nx-form-typep num1 'double-float env)
               (nx-form-typep num2 'double-float env)))
         (68k-target (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)))
    (if (or both-fixnums both-double-floats 68k-target)
      (make-acode
       (if both-fixnums
         (%nx1-operator %i<>)
         (if 68k-target
           (%nx1-operator numeric-comparison)
           (%nx1-operator double-float-compare)))
       (make-acode
        (%nx1-operator fixnum)
        (if (eq op '<-2)
          $ccGT
          (if (eq op '>=-2)
            $ccLE
            (if (eq op '<=-2)
              $ccGE
              $ccLT))))
       (nx1-form num1)
       (nx1-form num2))
      (nx1-treat-as-call whole))))

#+ppc-target
(defnx1 nx1-numcmp ((<-2) (>-2) (<=-2) (>=-2)) (&whole whole &environment env num1 num2)
  (let* ((op *nx-sfname*)
         (both-fixnums (and (nx-form-typep num1 'fixnum env)
                            (nx-form-typep num2 'fixnum env)))
         (both-double-floats
          (let* ((dfloat-1 (nx-form-typep num1 'double-float env))
                 (dfloat-2 (nx-form-typep num2 'double-float env)))
            (if dfloat-1 
              (or dfloat-2 (if (typep num2 'fixnum) (setq num2 (coerce num2 'double-float))))
              (if dfloat-2 (if (typep num1 'fixnum) (setq num1 (coerce num1 'double-float)))))))
         (both-short-floats
          (let* ((sfloat-1 (nx-form-typep num1 'short-float env))
                 (sfloat-2 (nx-form-typep num2 'short-float env)))
            (if sfloat-1 
              (or sfloat-2 (if (typep num2 'fixnum) (setq num2 (coerce num2 'short-float))))
              (if sfloat-2 (if (typep num1 'fixnum) (setq num1 (coerce num1 'short-float))))))))
    (if (or both-fixnums both-double-floats both-short-floats)
      (make-acode
       (if both-fixnums
         (%nx1-operator %i<>)
         (if both-double-floats
           (%nx1-operator double-float-compare)
           (%nx1-operator short-float-compare)))
       (make-acode
        (%nx1-operator fixnum)
        (if (eq op '<-2)
          $ccGT
          (if (eq op '>=-2)
            $ccLE
            (if (eq op '<=-2)
              $ccGE
              $ccLT))))
       (nx1-form num1)
       (nx1-form num2))
      (nx1-treat-as-call whole))))

(defnx1 nx1-num= ((=-2) (/=-2)) (&whole whole &environment env num1 num2 )
  (let* ((op *nx-sfname*)
         (2-rats (and (nx-form-typep num1 'rational env)
                      (nx-form-typep num2 'rational env)))
         (2-dfloats (let* ((dfloat-1 (nx-form-typep num1 'double-float env))
                           (dfloat-2 (nx-form-typep num2 'double-float env)))
                      (if dfloat-1 
                        (or dfloat-2 (if (typep num2 'fixnum) (setq num2 (coerce num2 'double-float))))
                        (if dfloat-2 (if (typep num1 'fixnum) (setq num1 (coerce num1 'double-float)))))))
         (2-sfloats (let* ((sfloat-1 (nx-form-typep num1 'short-float env))
                           (sfloat-2 (nx-form-typep num2 'short-float env)))
                      (if sfloat-1 
                        (or sfloat-2 (if (typep num2 'fixnum) (setq num2 (coerce num2 'short-float))))
                        (if sfloat-2 (if (typep num1 'fixnum) (setq num1 (coerce num1 'short-float)))))))
         (68k-target (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)))
    (if 2-rats
      (let* ((form `(eql ,num1 ,num2))) 
        (nx1-form (if (eq op '=-2) form `(not ,form))))
      (if (or 68k-target 2-dfloats 2-sfloats)
        (make-acode 
         (if 68k-target 
           (%nx1-operator num=)
           (if 2-dfloats
             (%nx1-operator double-float-compare)
             (%nx1-operator short-float-compare)))
         
         (make-acode
          (%nx1-operator fixnum)     
          (if (eq op '=-2)
            $ccEQ
            $ccNE))
         (nx1-form num1)
         (nx1-form num2))
        (nx1-treat-as-call whole)))))
             

(defnx1 nx1-uvset ((uvset) (%misc-set)) (vector index value)
  (make-acode (%nx1-operator uvset)
              (nx1-form vector)
              (nx1-form index)
              (nx1-form value)))

(defnx1 nx1-set-schar ((set-schar)) (&whole w s i v &environment env)
  (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
    (make-acode (if (nx-inhibit-safety-checking env)
                  (if (nx-form-typep s 'simple-base-string env)
                    (%nx1-operator %set-sbchar)
                    (%nx1-operator %set-schar))
                  (%nx1-operator set-schar))
                (nx1-form s)
                (nx1-form i)
                (nx1-form v))
    (if (nx-form-typep s 'simple-extended-string env)
      (make-acode (%nx1-operator %typed-uvset)
                      (make-acode (%nx1-operator fixnum) ppc::subtag-simple-general-string)
                      (nx1-form s) (nx1-form i) (nx1-form v))
      (if (nx-form-typep s 'simple-extended-string env)
        (make-acode (%nx1-operator %typed-uvset)
                      (make-acode (%nx1-operator fixnum) ppc::subtag-simple-general-string)
                      (nx1-form s) (nx1-form i) (nx1-form v))
    (let ((op (if (nx-form-typep s 'simple-base-string env)
                (%nx1-operator %set-sbchar)
                (if (nx-inhibit-safety-checking env)
                  (%nx1-operator %set-schar)))))
      (if op
        (make-acode op (nx1-form s) (nx1-form i) (nx1-form v))
            (nx1-treat-as-call w)))))))


#+ppc-target
(defnx1 nx1-%set-schar ((%set-schar)) (arg idx char &environment env)
  (let* ((arg (nx-transform arg env))
         (idx (nx-transform idx env))
         (char (nx-transform char env))
         (argvar (make-symbol "ARG"))
         (idxvar (make-symbol "IDX"))
         (charvar (make-symbol "CHAR"))
         (decl (if (nx-form-typep arg 'simple-extended-string)
                 `((declare (simple-extended-string ,argvar)))                 
                 (if (nx-form-typep arg 'simple-base-string)
                   `((declare (simple-base-string ,argvar)))))))
    (nx1-form `(let* ((,argvar ,arg)
                      (,idxvar ,idx)
                      (,charvar ,char))
                 (declare (optimize (speed 3) (safety 0)))
                 ,@decl
                 (setf (schar ,argvar ,idxvar) ,charvar))
              env)))

(defnx1 nx1-%set-scharcode ((%set-scharcode)) (&whole w s i v)
  (if t ;(eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
    (make-acode (%nx1-operator %set-scharcode)
                (nx1-form s)
                (nx1-form i)
                (nx1-form v))
    (nx1-treat-as-call w)))
              

(defnx1 nx1-list-vector-values ((list) (vector) (values) (%temp-list)) (&rest args)
  (make-acode (%nx1-default-operator) (nx1-formlist args)))

#-ppc-target
(defnx1 nx1-%gvector ((%gvector)) (&rest args)
  (make-acode (%nx1-operator %gvector) (nx1-arglist args)))

(defnx1 nx1-%ppc-gvector ((%ppc-gvector)) (&rest args)
  (make-acode (%nx1-operator %ppc-gvector) (nx1-arglist args)))

(defnx1 nx1-quote quote (form)
  (nx1-immediate form))

(defnx1 nx1-list* ((list*)) (first &rest rest)
  (make-acode (%nx1-operator list*) (nx1-arglist (cons first rest) 1)))


#|
(defnx1 nx1-append ((append)) (&rest args)
  (make-acode (%nx1-operator append) (nx1-arglist args 2)))


|#

(defnx1 nx1-or or (&whole whole &optional (firstform nil firstform-p) &rest moreforms)
  (if (not firstform-p)
    (nx1-form nil)
    (if (null moreforms)
      (nx1-form firstform)
      (progn
        (make-acode (%nx1-operator or) (nx1-formlist (%cdr whole)))))))

(defnx1 nx1-aref ((aref)) (&whole whole &environment env arr &optional (dim0 nil dim0-p)
                                    &rest other-dims)
  (let* ((68k-target (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)))
    (if (and dim0-p (null other-dims))
      (let* ((simple-vector-p (nx-form-typep arr 'simple-vector env))
             (string-p (unless simple-vector-p 
                         (if (nx-form-typep arr 'string env)
                           (or (nx-form-typep arr 'simple-string env)
                               (return-from nx1-aref (nx1-form `(char ,arr ,dim0)))))))
             (simple-1d-array-p (unless (or simple-vector-p string-p) 
                                  (nx-form-typep arr '(simple-array * (*)) env)))
             
             (element-type (if simple-1d-array-p (type-specifier (array-ctype-element-type (specifier-type  (nx-form-type arr env))))))
             (subtype (if element-type (if 68k-target 
                                         (element-type-subtype element-type)
                                         (xppc-element-type-subtype element-type)))))
        (if subtype
          (make-acode (%nx1-operator %typed-uvref) 
                      (nx1-immediate subtype)
                      (nx1-form arr)
                      (nx1-form dim0))
          (let* ((op (cond (simple-1d-array-p (%nx1-operator uvref))
                           #-ppc-target (string-p (%nx1-operator schar))
                           (simple-vector-p 
                            (if (nx-inhibit-safety-checking env) (%nx1-operator %svref) (%nx1-operator svref)))
                           (t (%nx1-operator %aref1)))))
            (make-acode op (nx1-form arr) (nx1-form dim0)))))
      (if 68k-target
        (nx2-2d-or-call env 3 (%nx1-operator 2d-simple-aref) whole)
        (progn
          (if (eq (length other-dims) 1)
            (let* ((simple-2d-array-p (nx-form-typep arr '(simple-array * (* *)) env))
                   (elt-type (if simple-2d-array-p 
                               (type-specifier (array-ctype-element-type (specifier-type  (nx-form-type arr env))))))
                   (subtype (if elt-type (xppc-element-type-subtype elt-type))))
              (if (memq elt-type '(double-float short-float))
                (make-acode (%nx1-operator %typed-2d-float-aref)
                            (nx1-immediate subtype)
                            (nx1-form arr)
                            (nx1-form dim0)
                            (nx1-form (car other-dims)))
                (nx1-treat-as-call (cons '%aref2 (cdr whole)))))
            
            (nx1-treat-as-call whole)))))))

(defun nx2-2d-or-call (env len op whole &aux (args (%cdr whole)))
  (if (not (eq len (length args)))
    (nx1-treat-as-call whole)
    (let ((type (nx-form-type (car args)))
          dim0)
      (if (and (nx-inhibit-safety-checking env)
               (subtypep type '(simple-array t (* *))) ; should account for array-element-type promotion
               )
        (make-acode
         op
         (if (fixnump (setq dim0 (cadr (caddr type)))) dim0)
         (nx1-arglist args))
        (make-acode* (if (eq len 3) (%nx1-operator aref2) (%nx1-operator aset2)) args)))))

(defnx1 nx1-aset ((aset)) (&whole whole 
                                  arr                                  
                                  &environment env
                                  &rest dims-and-newval)
  (let* ((68k-target (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)))
    (if (eq (length dims-and-newval) 2)
      (let* ((newval (cadr dims-and-newval))
             (dim0 (car dims-and-newval))
             (simple-vector-p (nx-form-typep arr 'simple-vector env))
             (string-p (unless simple-vector-p 
                         (if (nx-form-typep arr 'string env)
                           (or (nx-form-typep arr 'simple-string env)
                               (return-from nx1-aset (nx1-form `(set-char ,arr ,dim0 ,newval)))))))
             (simple-1d-array-p (unless (or simple-vector-p string-p) 
                                  (nx-form-typep arr '(simple-array * (*)) env)))
             (element-type (if simple-1d-array-p (array-ctype-element-type (specifier-type (nx-form-type arr env)))))
             (subtype (if element-type (if 68k-target 
                                         (element-type-subtype (type-specifier element-type))
                                         (xppc-element-type-subtype (type-specifier element-type))))))
        (if subtype
          (make-acode (%nx1-operator %typed-uvset) 
                      (nx1-immediate subtype)
                      (nx1-form arr)
                      (nx1-form dim0)
                      (nx1-form newval))
          (let* ((op (cond (simple-1d-array-p (%nx1-operator uvset))
                           (string-p (if 68k-target (%nx1-operator set-schar)))
                           (simple-vector-p (if (nx-inhibit-safety-checking env) (%nx1-operator %svset) (%nx1-operator svset)))
                           (t (if 68k-target (%nx1-operator aset1))))))
            (if op
              (make-acode
               op
               (nx1-form arr)
               (nx1-form dim0)
               (nx1-form newval))
              (nx1-form `(,(if string-p 'set-schar '%aset1) ,arr ,dim0 ,newval))))))
      (if 68k-target
        (nx2-2d-or-call env 4 (%nx1-operator 2d-simple-aset) whole)
        (progn
          (if (eq (length dims-and-newval) 3)
            (let* ((newval (caddr dims-and-newval))
                   (dim0 (car dims-and-newval))
                   (dim1 (cadr dims-and-newval))
                   (simple-2d-array-p (nx-form-typep arr '(simple-array * (* *)) env))
                   (elt-type (if simple-2d-array-p 
                               (type-specifier (array-ctype-element-type (specifier-type  (nx-form-type arr env))))))
                   (subtype (if elt-type (xppc-element-type-subtype elt-type))))
              (if (memq elt-type '(double-float short-float))
                (progn
                  (make-acode (%nx1-operator %typed-2d-float-aset)
                              (nx1-immediate subtype)
                              (nx1-form arr)
                              (nx1-form dim0)
                              (nx1-form dim1)
                              (nx1-form newval)))
                (nx1-treat-as-call (cons '%aset2 (cdr whole)))))
            
            (nx1-treat-as-call whole)))))))
            

(defnx1 nx1-prog1 (prog1 multiple-value-prog1) (save &body args 
                                                     &aux (l (list (nx1-form save))))
  (make-acode 
   (%nx1-default-operator) 
   (dolist (arg args (nreverse l))
     (%temp-push (nx1-form arg) l))))

(defnx1 nx1-if if (test true &optional false)
  (if (null true)
    (if (null false)
      (return-from nx1-if (nx1-form `(progn ,test nil)))
      (psetq test `(not ,test) true false false true)))
  (let ((testform nil)
        (trueform nil)
        (falseform nil)
        (called-in-test nil)
        (called-in-true)
        (called-in-false)
        (exited nil))
    (let* ((*nx-event-checking-call-count* *nx-event-checking-call-count*)
           (*nx-nlexit-count* *nx-nlexit-count*)
           (calls *nx-event-checking-call-count*)
           (exits *nx-nlexit-count*))
      (setq testform (nx1-form test))
      (if (neq calls (setq calls *nx-event-checking-call-count*))
        (setq called-in-test calls)
        (if (neq exits (setq exits *nx-nlexit-count*))
          (setq exited exits)))
      (setq trueform (nx1-form true))
      (unless (or called-in-test exited)
        (if (neq calls (setq calls *nx-event-checking-call-count*))
          (setq called-in-true calls)
          (if (neq exits (setq exits *nx-nlexit-count*))
            (setq exited exits))))
      (setq falseform (nx1-form false))
      (unless (or called-in-test exited)
        (if (neq calls (setq calls *nx-event-checking-call-count*))
          (setq called-in-false calls)
          (if (neq exits (setq exits *nx-nlexit-count*))
            (setq exited exits)))))
    (if exited 
      (setq *nx-nlexit-count* exited)
      (if (setq called-in-test (or called-in-test (and called-in-true called-in-false)))
        (setq *nx-event-checking-call-count* called-in-test)))  
    (make-acode (%nx1-operator if) testform trueform falseform)))

#-ignore
(defnx1 nx1-%debug-trap dbg (&optional arg)
  (make-acode (%nx1-operator %debug-trap) (nx1-form arg)))
#+ignore
(defnx1 nx1-%debug-trap dbg-old (&optional arg)
  (make-acode (%nx1-operator %debug-trap) (nx1-form arg)))
        
(defnx1 nx1-setq setq (&whole whole &rest args &environment env &aux res)
  (when (%ilogbitp 0 (length args))
    (nx-error "Odd number of forms in ~s ." whole))
  
  (while args
    (let ((sym (nx-need-var (%car args) nil))
          (val (%cadr args))
          sym-mac)
      (multiple-value-bind (info inherited catchp)
                           (nx-lex-info sym)
        (%temp-push
         (if (eq info :symbol-macro)
           (progn
             (nx-set-var-bits catchp (%ilogior (%ilsl $vbitsetq 1) (%ilsl $vbitreffed 1)  (nx-var-bits catchp)))
             (nx1-form `(setf ,inherited ,val)))
           (if (and (not info)(setq sym-mac (find-compile-time-or-global-symbol-macro-def (%car args))))
             (nx1-form `(setf ,sym-mac ,val))
             (let* ((valtype (nx-form-type val env))
                  (declared-type (nx-declared-type sym)))
             (let ((*nx-form-type* declared-type))
               (setq val (nx1-typed-form val env)))
             (if (and info (neq info :special))
               (let ((inittype (var-inittype info)))
                 ;(print (list 'cow0 inittype declared-type valtype))
                 
                 (nx1-check-assignment sym env)
                 (when (or (%ilogbitp $vbitdestructive (nx-var-bits info))
                           (%ilogbitp $vbitdynamicextent (nx-var-bits info)))
                   ;; the inittype/= declared type if we bind n to m but is = if bind n to (barf) - weird
                   ;; so we'll put it back
                   (when (and (not inittype)(memq declared-type '(double-float short-float)))
                     (setq inittype declared-type) (setf (var-inittype info) declared-type)))
                 (let ()
                   (if (and inittype (not (subtypep valtype inittype))
                            ;; added this cause we have to stack or heap allocate it in ppc2-seq-bind-var
                            ;; if we EVER %setf-float it.                            
                            (or (not (memq inittype '(double-float short-float)))
                                (not (eq inittype declared-type))  ;; or subtypep?
                                (and 
                                 (not (%ilogbitp $vbitdestructive (nx-var-bits info)))
                                 (not (%ilogbitp $vbitdynamicextent (nx-var-bits info))))))
                     (setq inittype (setf (var-inittype info) nil))))  ;; <<
                 ;(print (list 'cow1 inittype declared-type valtype))
                 (if inherited
                   (nx-set-var-bits info (%ilogior (%ilsl $vbitsetq 1)
                                           (%ilsl $vbitnoreg 1) ; I know, I know ... Someday ...
                                           (nx-var-bits info)))
                   (nx-set-var-bits info (%ilogior2 (%ilsl $vbitsetq 1) (nx-var-bits info))))
                 (nx-adjust-setq-count info 1 catchp) ; In the hope that that day will come ...
                 (if (and (eq inittype 'double-float)
                          ;(eq valtype 'double-float)  ;; put this back - no
                          (or (%ilogbitp $vbitdestructive (nx-var-bits info))
                              (%ilogbitp $vbitdynamicextent (nx-var-bits info))))
                   (progn
                     (make-acode (%nx1-operator %setf-double-float) (nx1-form sym env) val))
                   (if (and (eq inittype 'short-float)
                            ;(eq valtype 'short-float)  ;; and this
                            (or (%ilogbitp $vbitdynamicextent (nx-var-bits info))
                                (%ilogbitp $vbitdestructive (nx-var-bits info))))
                     (progn 
                       (make-acode (%nx1-operator %setf-short-float)(nx1-form sym env) val))
                     
                     (make-acode (%nx1-operator setq-lexical) info val))))
               (make-acode
                (if (nx1-check-special-ref sym info)
                  (%nx1-operator setq-special)
                  (%nx1-operator setq-free)) ; Screw: no object lisp.  Still need setq-free ? For constants ?
                (nx1-note-vcell-ref sym)
                val)))))
         res)))
    (setq args (%cddr args)))
  (make-acode (%nx1-operator progn) (nreverse res)))

; See if we're trying to setq something that's currently declared "UNSETTABLE"; whine if so.
; If we find a contour in which a "SETTABLE NIL" vdecl for the variable exists, whine.
; If we find a contour in which a "SETTABLE T" vdecl for the variable exists. or
;    the contour in which the variable's bound, return nil.
; Should find something ...
(defun nx1-check-assignment (sym env)
  (loop
    (unless (and env (istruct-typep env 'lexical-environment))
      (return))
    (dolist (decl (lexenv.vdecls env))
      (when (and (eq (car decl) sym)
               (eq (cadr decl) 'settable))
        (unless (cddr decl)
          (nx1-whine :unsettable sym))
        (return-from nx1-check-assignment nil)))
    (let ((vars (lexenv.variables env)))
      (unless (atom vars)
        (dolist (var vars)
          (when (eq (var-name var) sym) (return-from nx1-check-assignment nil)))))
    (setq env (lexenv.parent-env env))))

; The cleanup issue is a little vague (ok, it's a -lot- vague) about the environment in
; which the load-time form is defined, although it apparently gets "executed in a null
; lexical environment".  Ignoring the fact that it's meaningless to talk of executing
; something in a lexical environment, we can sort of infer that it must also be defined
; in a null lexical environment.
#-ppc-target
(defnx1 nx1-load-time-value (load-time-value) (&environment env form &optional read-only-p)
  ; Validate the "read-only-p" argument
  (if (and read-only-p (neq read-only-p t)) (require-type read-only-p '(member t nil)))
  ; Then ignore it.
  (if *nx-load-time-eval-token*
    (multiple-value-bind (function warnings)
                         (funcall (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
                                    'compile-named-function 'ppc-compile-named-function)
                          `(lambda () ,form) nil t nil nil nil nil *nx-load-time-eval-token*)
      (setq *nx-warnings* (append *nx-warnings* warnings))
      (nx1-immediate (list *nx-load-time-eval-token* `(funcall ,function))))
    (nx1-immediate (eval form))))

#+ppc-target
(defnx1 nx1-load-time-value (load-time-value) (&environment env form &optional read-only-p)
  ; Validate the "read-only-p" argument
  (if (and read-only-p (neq read-only-p t)) (require-type read-only-p '(member t nil)))
  ; Then ignore it.
  (if *nx-load-time-eval-token*
    (multiple-value-bind (function warnings)
                         (compile-named-function 
                          `(lambda () ,form) nil t nil nil nil nil *nx-load-time-eval-token*)
      (setq *nx-warnings* (append *nx-warnings* warnings))
      (nx1-immediate (list *nx-load-time-eval-token* `(funcall ,function))))
    (nx1-immediate (eval form))))

(defnx1 nx1-catch (catch) (operation &body body)
  (make-acode (%nx1-operator catch) (nx1-form operation) (nx1-catch-body body)))

(defnx1 nx1-%badarg ((%badarg)) (badthing right-type)
  (make-acode (%nx1-operator %badarg2) 
              (nx1-form badthing) 
              (nx1-form (or (if (quoted-form-p right-type) (%typespec-id (cadr right-type))) right-type))))

(defnx1 nx1-unwind-protect (unwind-protect) (protected-form &body cleanup-form)
  (if cleanup-form
    (make-acode (%nx1-operator unwind-protect) 
                (nx1-catch-body (list protected-form))
                (nx1-progn-body cleanup-form))
    (nx1-form protected-form)))

(defnx1 nx1-progv progv (symbols values &body body)
  (make-acode (%nx1-operator progv) 
              (nx1-form `(check-symbol-list ,symbols))
              (nx1-form values) 
              (nx1-catch-body body)))

(defun nx1-catch-body (body)
  (let* ((temp (nx-new-lexical-environment *nx-lexical-environment*)))
    (setf (lexenv.variables temp) 'catch)
    (let* ((*nx-lexical-environment* (nx-new-lexical-environment temp)))
      (nx1-progn-body body))))

#-ppc-target
(defnx1 nx1-without-interrupts without-interrupts (&body body)
  (make-acode (%nx1-operator without-interrupts)
              (if (eq *nx1-68k-target-inhibit* *nx1-target-inhibit*)
                (nx1-catch-body body)
                ; For now ...
                (nx1-form `(let* ((*interrupt-level* -1))
                             (declare (special *interrupt-level*))
                             ,@body)))))


#+ppc-target
(defnx1 nx1-without-interrupts without-interrupts (&body body)
  (let ((*nx1-without-interrupts* t))
    (make-acode (%nx1-operator without-interrupts)
                (nx1-form `(let* ((*interrupt-level* -1))
                             (declare (special *interrupt-level*))
                             ,@body)))))

(defnx1 nx1-apply ((apply)) (&whole call fn arg &rest args &aux (orig args) (spread-p t))
  (if (null (%car (last (push arg args))))
    (setq spread-p nil args (butlast args)))
  (let ((name (nx1-func-name fn))
        (global nil))
    (if name
      (if (eq (%car fn) 'quote)
        (setq global t name (nx1-form fn))
        (let*  ((afunc (nth-value 1 (nx-lexical-finfo name))))
          (when (and afunc (eq afunc *nx-call-next-method-function*))
            (setq name (if (or arg orig) 
                         '%call-next-method-with-args
                         '%call-next-method)
                         global t
                         args (cons (var-name *nx-next-method-var*) args)))))
      (setq name (nx1-form fn)))
    (nx1-call name args spread-p global)))

(defnx1 nx1-%apply-lexpr ((%apply-lexpr)) (&whole call fn arg &rest args &aux (orig args))
  (push arg args)
  (let ((name (nx1-func-name fn))
        (global nil))
    (if name
      (if (eq (%car fn) 'quote)
        (setq global t name (nx1-form fn))
        (let*  ((afunc (nth-value 1 (nx-lexical-finfo name))))
          (when (and afunc (eq afunc *nx-call-next-method-function*))
            (setq name (if (or arg orig) 
                         '%call-next-method-with-args
                         '%call-next-method)
                  global t
                  args (cons (var-name *nx-next-method-var*) args)))))
      (setq name (nx1-form fn)))
    (nx1-call name args 0 global)))

#-ppc-target
(defnx1 nx1-%defun %defun (&whole w def &optional (doc nil doc-p) &environment env)
  ; Pretty bogus.
  (if (and (consp def)
           (eq (%car def) 'nfunction)
           (consp (%cdr def))
           (symbolp (%cadr def)))
    (note-function-info (%cadr def) nil env))
  (if (eq *nx1-target-inhibit* *nx1-68k-target-inhibit*)
    (if (not doc-p)
      (make-acode (%nx1-operator %primitive) $sp-defun1
                  (%temp-list (%temp-cons (nx1-form def) $arg_z))
                  $acc)
      (make-acode (%nx1-operator %primitive) $sp-defun2
                  (nreverse (%temp-list (%temp-cons (nx1-form def) $arg_y) 
                                        (%temp-cons (nx1-form doc) $arg_z)))
                  $acc))
    (nx1-treat-as-call w)))

#+ppc-target
(defnx1 nx1-%defun %defun (&whole w def &optional (doc nil doc-p) &environment env)
  (declare (ignorable doc doc-p))
  ; Pretty bogus.
  (if (and (consp def)
           (eq (%car def) 'nfunction)
           (consp (%cdr def))
           (symbolp (%cadr def)))
    (note-function-info (%cadr def) nil env))
  (nx1-treat-as-call w))


(defnx1 nx1-function function (arg &aux fn afunc)
  (if (symbolp arg)
    (progn
      (when (macro-function arg *nx-lexical-environment*)
        (nx-error
         "~S can't be used to reference lexically visible macro ~S." 
         'function arg))
      (if (multiple-value-setq (fn afunc) (nx-lexical-finfo arg))
        (progn
          (when afunc 
            (incf (afunc-fn-refcount afunc))
            (when (%ilogbitp $fbitbounddownward (afunc-bits afunc))
              (incf (afunc-fn-downward-refcount afunc))))
          (nx1-symbol (%cddr fn)))
        (progn
          (while (setq fn (assq arg *nx-synonyms*))
            (setq arg (%cdr fn)))
          (nx1-form `(%function ',arg)))))
    (if (and (consp arg) (eq (%car arg) 'setf))
      (nx1-form `(function ,(nx-need-function-name arg)))
      (nx1-ref-inner-function nil arg))))

(defnx1 nx1-nfunction nfunction (name def)
 (nx1-ref-inner-function name def))

(defun nx1-ref-inner-function (name def &optional afunc)
  (setq afunc (nx1-compile-inner-function name def afunc))
  (setf (afunc-fn-refcount afunc) 1)
  (nx1-afunc-ref afunc))

(defun nx1-compile-inner-function (name def 
                                        &optional p (env *nx-lexical-environment*) 
                                        &aux (q *nx-current-function*))
  (unless p (setq p (make-afunc)))
  (setf (afunc-parent p) q)
  (setf (afunc-parent q) *nx-parent-function*)
  (setf (afunc-tags q) *nx-tags*)
  (setf (afunc-blocks q) *nx-blocks*)
  (setf (afunc-inner-functions q) (push p *nx-inner-functions*))
  (setf (lexenv.lambda env) q)
  (nx1-compile-lambda name def p q env *nx-current-compiler-policy* *nx-load-time-eval-token*)) ;returns p.

(defun nx1-afunc-ref (afunc)
  (let ((op (if (afunc-inherited-vars afunc)
              (%nx1-operator closed-function)
              (%nx1-operator simple-function)))
        (ref (afunc-ref-form afunc)))
    (if ref
      (%rplaca ref op) ; returns ref
      (setf (afunc-ref-form afunc)
            (make-acode
             op
             afunc)))))
    
(defnx1 nx1-%function %function (form &aux symbol)
  (let ((sym (nx1-form form)))
    (if (and (eq (car sym) (%nx1-operator immediate))
             (setq symbol (cadr sym))
             (symbolp symbol))
      (progn
        (nx1-call-result-type symbol)   ; misnamed.  Checks for (un-)definedness.
        (make-acode (%nx1-default-operator) symbol))
      (make-acode (%nx1-operator call) (nx1-immediate '%function) (list nil (list sym))))))

(defnx1 nx1-tagbody tagbody (&rest args)
  (let* ((newtags nil)
         (*nx-lexical-environment* (nx-new-lexical-environment *nx-lexical-environment*))
         (*nx-bound-vars* *nx-bound-vars*)
         (catchvar (nx-new-temp-var "tagbody-catch-tag"))
         (indexvar (nx-new-temp-var "tagbody-tag-index"))
         (counter (list 0))
         (looplabel (%temp-cons nil nil))
         (*nx-tags* *nx-tags*))
    (dolist (form args)
      (when (atom form)
        (if (or (symbolp form) (integerp form))
          (if (assq form newtags)
            (nx-error "Duplicate tag in TAGBODY: ~S." form)
            (%temp-push (%temp-list form nil counter catchvar nil nil) newtags))
          (nx-error "Illegal form in TAGBODY: ~S." form))))
    (dolist (tag (setq newtags (nreverse newtags)))
      (%temp-push tag *nx-tags*))
    (let* ((body nil) 
           (nlexit-count *nx-nlexit-count*)
           (call-count *nx-event-checking-call-count*))
      (dolist (form args (setq body (nreverse body)))
        (%temp-push 
         (if (atom form)
           (let ((info (nx-tag-info form)))
             (%rplaca (%cdr (%cdr (%cdr (%cdr info)))) t)
             (%temp-cons (%nx1-operator tag-label) info))
           (progn
             (setq form (nx1-form form))
             ; These are supposed to just be hints - pass 2 can (theoretically)
             ; walk the acode itself ...
             (if (neq call-count (setq call-count *nx-event-checking-call-count*))
               (setq form (make-acode (%nx1-operator embedded-call) form)))
             (if (neq nlexit-count (setq nlexit-count *nx-nlexit-count*))
               (setq form (make-acode (%nx1-operator embedded-nlexit) form)))
             form))
         body))
      (if (eq 0 (%car counter))
        (make-acode (%nx1-operator local-tagbody) newtags body)
        (progn
          (nx-inhibit-register-allocation)   ; There are alternatives ...
          (dolist (tag (reverse newtags))
            (when (%cadr tag)
              (%temp-push  
               (nx1-form `(if (eq ,(var-name indexvar) ,(%cadr tag)) (go ,(%car tag))))
               body)))
          (make-acode
           (%nx1-operator let*)
           (list catchvar indexvar)
           (list *nx-nil* *nx-nil*)
           (make-acode
            (%nx1-operator local-tagbody)
            (list looplabel)
            (list
             (cons (%nx1-operator tag-label) looplabel)
             (make-acode
              (%nx1-operator if)
              (make-acode 
               (%nx1-operator setq-lexical)
               indexvar
               (make-acode 
                (%nx1-operator catch)
                (nx1-form `(setq ,(var-name catchvar) (%newgotag)))  ;(make-acode (%nx1-operator newgotag))
                (make-acode
                 (%nx1-operator local-tagbody)
                 newtags
                 body)))
              (make-acode (%nx1-operator local-go) looplabel)
              *nx-nil*)))
           0))))))

(defnx1 nx1-%newgotag %newgotag ()
  (make-acode (%nx1-operator newgotag)))

(defnx1 nx1-go go (tag)
  (multiple-value-bind (info closed)
                       (nx-tag-info tag)
    (unless info (nx-error "Can't GO to tag ~S." tag))
    (if (not closed)
      (let ((defnbackref (cdr (cdr (cdr (cdr info))))))
        (if (car defnbackref) 
          (rplaca (cdr defnbackref) t)
          (setq *nx-nlexit-count* (%i+ *nx-nlexit-count* 1)))
        (make-acode (%nx1-operator local-go) info))
      (progn
        (setq *nx-nlexit-count* (%i+ *nx-nlexit-count* 1))
        (make-acode
         (%nx1-operator throw) (nx1-symbol (var-name (cadddr info))) (nx1-form closed))))))

(defnx1 nx1-%register-trap ((%register-trap)) (&whole whole trapnum bits &rest args &aux
                                                      reglist
                                                      reg)
  (if (and (fixnump (setq trapnum (nx-get-fixnum trapnum)))
           (fixnump (setq bits (nx-get-fixnum bits))))
    (locally
      (declare (fixnum trapnum bits))
      (while args
        (setq reg (logand 15 bits) 
              bits (%ilsr 4 bits)
              reglist (cons (cons reg (nx1-form (pop args))) reglist)))
      (let* ((form (make-acode (%nx1-operator %register-trap) (logior #xa000 (logand #x0fff trapnum)) bits (nreverse reglist))))
        (if (logbitp 6 bits)
          (make-acode (%nx1-operator typed-form) (if (%ilogbitp 7 bits) '(signed-byte 16) '(unsigned-byte 16)) form)
          (if (logbitp 3 bits)
            (make-acode (%nx1-operator %consmacptr%)
                        (make-acode (%nx1-operator %macptrptr%) 
                                    (rplaca form (logior (%nx1-operator %register-trap) operator-returns-address-mask))))
            form))))
    (nx1-treat-as-call whole)))
  
(defnx1 nx1-%stack-trap ((%stack-trap)) (&whole whole trapnum bits &rest args)
  (let* ((nwords 0)
         (origbits bits)
         pushlist)
    (if (and (fixnump (setq trapnum (nx-get-fixnum trapnum)))
             (fixnump (setq bits (nx-get-fixnum bits))))
      (progn
        (dolist (arg args pushlist)
          (let (( argspec (%ilogand2 3 bits)))
            (setq bits (%ilsr 2 bits) nwords (%i+ nwords 2))
            (%temp-push 
             (make-acode 
              (if (eq 0 argspec) 
                (%nx1-operator spushp)
                (if (eq 1 argspec)
                  (%nx1-operator spushl)
                  (if (eq 2 argspec)
                    (progn (setq nwords (%i- nwords 2))
                           (if (%cdr (memq arg args))
                             (%nx1-operator strap-selector-save)
                             (%nx1-operator strap-selector-last)))
                    (progn (setq nwords (%i- nwords 1)) (%nx1-operator spushw)))))
              (nx1-form arg))
             pushlist)))
        (let* ((acode (make-acode (%nx1-operator %stack-trap) 
                                  (%ilogior #xa000 (%ilogand #x0fff trapnum)) 
                                  bits 
                                  nwords 
                                  origbits 
                                  (nreverse pushlist))))
          (if (eq bits #b100)
            (make-acode (%nx1-operator %consmacptr%)
                        (make-acode (%nx1-operator %macptrptr%) 
                                    (rplaca acode (logior (%nx1-operator %stack-trap) operator-returns-address-mask))))
            acode)))
      (nx1-treat-as-call whole))))

#-ppc-target
(progn
(defnx1 nx1-ff-call ((ff-call)) (&whole whole fn &rest args &environment env)
  (nx1-ff-call-gen-trap nil whole fn args env))

(defnx1 nx1-%gen-trap ((%gen-trap)) (&whole whole trap &rest args &environment env)
  (nx1-ff-call-gen-trap t whole trap args env))

(defun nx1-ff-call-gen-trap (trap-p whole fn args env &aux retspec spec arglist retblk )
  (while (%cdr args)
    (unless (or (setq spec (assq (%car args)
                             '((:a5 . 13) ;a6/a7 not allowed
                               (:d0 . 0) (:d1 . 1) (:d2 . 2) (:d3 . 3)
                               (:d4 . 4) (:d5 . 5) (:d6 . 6) (:d7 . 7)
                               (:a0 . 8) (:a1 . 9) (:a2 . 10) (:a3 . 11)
                               (:a4 . 12)
                               (:word . #x13)
                               (:long . #x12) (:longword . #x12)
                               (:ptr . #x14) (:pointer . #x14))))
                (and (null retblk)
                     (eq (%car args) :return-block)
                     (setq retblk (setq spec '(:return-block . #x17)))))
      (when (keywordp (%car args))
        (nx-error "Invalid arg spec ~S ~S" (%car args) (%cadr args)))
      (return-from nx1-ff-call-gen-trap (nx1-treat-as-call whole)))
    (push (cons (%cdr spec) (%cadr args)) arglist)
    (setq args (%cddr args)))
  (unless (constantp (%car args))
    (return-from nx1-ff-call-gen-trap (nx1-treat-as-call whole)))
  (when trap-p
    (unless (typep (setq fn (nx-transform fn env)) 'fixnum)
      (return-from nx1-ff-call-gen-trap (nx1-treat-as-call whole))))
  (setq args (eval (%car args))) ;Allow (defconstant my-return '(:a0 :d0 :a1))...
  (if retblk
    (do* ((retlist (if (listp args) args (list args)) (%cdr retlist)))
         ((atom retlist) (setq retspec (if (null retlist) (nreverse retspec))))
      (unless (setq spec (assq (%car retlist)
                               '((:d0 . 0) (:d1 . 1) (:d2 . 2) (:d3 . 3)
                                 (:d4 . 4) (:d5 . 5) (:d6 . 6) (:d7 . 7)
                                 (:a0 . 8) (:a1 . 9) (:a2 . 10) (:a3 . 11)
                                 (:a4 . 12) ;a5/a6/a7 not allowed
                                 (:word . #x13)
                                 (:long . #x12) (:longword . #x12)
                                 (:ptr . #x14) (:pointer . #x14))))
        (return (setq retspec nil)))
      (push (%cdr spec) retspec))
    (setq retspec (%cdr (assq args
                              '((:novalue . #x10) (:none . #x10) (nil . #x10)
                                (:d0 . 0) (:d1 . 1) (:d2 . 2) (:d3 . 3)
                                (:d4 . 4) (:d5 . 5) (:d6 . 6) (:d7 . 7)
                                (:a0 . 8) (:a1 . 9) (:a2 . 10) (:a3 . 11)
                                (:a4 . 12) ;a5/a6/a7 not allowed
                                (:word . #x13)
                                (:long . #x12) (:longword . #x12)
                                (:ptr . #x14) (:pointer . #x14))))))
    (unless retspec (nx-error "Invalid value spec ~S" args))
    (let ((stackwords (if (eq retspec #x13) 1 (if (or (eq retspec #x12) (eq retspec #x14)) 2 0))))
      (when retblk
        (dolist (spec retspec)
          (if (eq spec #x13)
            (setq stackwords (%i+ stackwords 1))
            (if (%i> spec #x10)
              (setq stackwords (%i+ stackwords 2))))))
      (make-acode
       (%nx1-operator ff-call)
       trap-p
       (if trap-p
         fn
         (make-acode (%nx1-operator %macptrptr%) (nx1-form fn)))
       retspec
       (dolist (arg arglist (nreverse arglist))
         (let ((spec (%car arg)))
           (when (%i> spec #x10)
             (setq stackwords (%i+ stackwords (if (eq spec #x13) 1 2))))
           (%rplacd arg 
                    (make-acode
                     (if (or (%i< spec $a0) (eq spec #x12))
                       (%nx1-operator spushl)
                       (if (or (%i< spec #x10) (eq spec #x14) (eq spec #x17))
                         (%nx1-operator spushp)
                         (%nx1-operator spushw)))
                    (nx1-form (%cdr arg))))))
       stackwords)))
)

; address-expression should return a fixnum; that's our little secret.
; result spec can be NIL, :void, or anything that an arg-spec can be.
; arg-spec can be :double, :single, :address, :signed-fullword, :unsigned-fullword, 
;    :signed-halfword, :unsigned-halfword, :signed-byte, or :unsigned-byte

(defparameter *ppc-arg-spec-keywords*
  '(:double-float :single-float :address :signed-fullword :unsigned-fullword
    :signed-halfword :unsigned-halfword :signed-byte :unsigned-byte))


(defnx1 nx1-ff-call-slep ((ff-call-slep)) (address-expression &rest arg-specs-and-result-spec)
  (nx1-ppc-ff-call-internal
   address-expression arg-specs-and-result-spec (%nx1-operator ff-call-slep)))

(defnx1 nx1-ppc-ff-call ((ppc-ff-call)) (address-expression &rest arg-specs-and-result-spec)
  (nx1-ppc-ff-call-internal
   address-expression arg-specs-and-result-spec (%nx1-operator native-ff-call)))

(defun nx1-ppc-ff-call-internal (address-expression arg-specs-and-result-spec operator)
  (let* ((specs ())
         (vals ())
         (arg-specs (butlast arg-specs-and-result-spec))
         (result-spec (car (last arg-specs-and-result-spec))))
    (unless (evenp (length arg-specs))
      (error "odd number of arg-specs"))
    (loop
      (when (null arg-specs) (return))
      (let ((arg-keyword (pop arg-specs))
            (value (pop arg-specs)))
        (if (memq arg-keyword *ppc-arg-spec-keywords*)
          (progn 
            (push arg-keyword specs)
            (push value vals))
          (error "Unknown argument spec: ~s" arg-keyword))))
    (setq result-spec (if (null result-spec) 
                        :void 
                        (if (eq result-spec :void) 
                          result-spec
                          (if (memq result-spec *ppc-arg-spec-keywords*)
                            result-spec
                            (error "Unknown result spec: ~s" result-spec)))))
    (make-acode operator
                (nx1-form address-expression)
                (nreverse specs)
                (mapcar #'nx1-form (nreverse vals))
                result-spec)))
  
(defnx1 nx1-block block (blockname &body forms)
  (let* ((*nx-blocks* *nx-blocks*)
         (*nx-lexical-environment* (nx-new-lexical-environment *nx-lexical-environment*))
         (*nx-bound-vars* *nx-bound-vars*)
         (tagvar (nx-new-temp-var))
         (thisblock (%temp-cons (setq blockname (nx-need-sym blockname)) tagvar))
         (body nil))
    (%temp-push thisblock *nx-blocks*)
    (setq body (nx1-progn-body forms))
    (%rplacd thisblock nil)
    (let ((tagbits (nx-var-bits tagvar)))
      (if (not (%ilogbitp $vbitclosed tagbits))
        (if (neq 0 (%ilogand $vrefmask tagbits))
          (make-acode 
           (%nx1-operator local-block)
           thisblock
           body)
          body)
        (progn
          (nx-inhibit-register-allocation)   ; Could also set $vbitnoreg in all setqed vars, or keep track better
          (make-acode
           (%nx1-operator local-block)
           thisblock
           (make-acode
            (%nx1-operator let)
            (list tagvar)
            (list (make-acode (%nx1-operator newblocktag)))
            (make-acode
             (%nx1-operator catch)
             (list (%nx1-operator lexical-reference) tagvar)
             body)
            0)))))))

(defnx1 nx1-return-from return-from (blockname &optional value)
  (multiple-value-bind (info closed)
                       (nx-block-info (setq blockname (nx-need-sym blockname)))
    (unless info (nx-error "Can't RETURN-FROM block : ~S." blockname))
    (unless closed (nx-adjust-ref-count (cdr info)))
    (setq *nx-nlexit-count* (%i+ *nx-nlexit-count* 1))
    (make-acode 
     (if closed
       (%nx1-operator throw)
       (%nx1-operator local-return-from))
     (if closed
       (nx1-symbol (var-name (cdr info)))
       info)
     (nx1-form value))))

;; make e.g (funcall 'foo ...) act like (funcall #'foo ...) => (foo ...)
;; no way Jose - we hoped to pick up optimizers - but also can loop in em
(defnx1 nx1-funcall ((funcall)) (func &rest args)
  (let ((name func)
        kwote)
    (if (and (consp name)
             (or (eq (%car name) 'function)
                 ;(and (eq (%car name) 'quote) (setq kwote t))
                 )
             (consp (%cdr name))
             (null (%cddr name))
             (or
              (if (symbolp (setq name (%cadr name)))
                (or (not (macro-function name *nx-lexical-environment*))
                    (nx-error "Can't funcall macro function ~s ." name)))
              (and (consp name)(not kwote) 
                   (or (eq (%car name) 'lambda)
                       (setq name (nx-need-function-name name))))))
      (nx1-form (cons name args))  ; This picks up call-next-method evil.
      (nx1-call (nx1-form func) args nil t))))

(defnx1 nx1-multiple-value-call multiple-value-call (value-form &rest args)
  (make-acode (%nx1-default-operator)
              (nx1-form value-form)
              (nx1-formlist args)))

#|
(defun nx1-call-name (fn &aux (name (nx1-func-name fn)))
  (if (and name (or (eq (%car fn) 'quote) (null (nx-lexical-finfo name))))
    (make-acode (%nx1-operator immediate) name)
    (or name (nx1-form fn))))
|#

(defnx1 nx1-compiler-let compiler-let (bindings &body forms)
  (let* ((vars nil)
         (varinits nil))
    (dolist (pair bindings)
      (%temp-push (nx-pair-name pair) vars)
      (%temp-push (eval (nx-pair-initform pair)) varinits))
   (progv (nreverse vars) (nreverse varinits) (nx1-catch-body forms))))

(defnx1 nx1-fbind fbind (fnspecs &body body &environment old-env)
  (let* ((fnames nil)
         (vars nil)
         (vals nil))
    (dolist (spec fnspecs (setq vals (nreverse vals)))
      (destructuring-bind (fname initform) spec
        (%temp-push (setq fname (nx-need-function-name fname)) fnames)
        (%temp-push (nx1-form initform) vals)))
    (let* ((new-env (nx-new-lexical-environment old-env))
           (*nx-bound-vars* *nx-bound-vars*)
           (*nx-lexical-environment* new-env))
      (dolist (fname fnames)        
        (let ((var (nx-new-var (make-symbol (symbol-name fname)))))
          (nx-set-var-bits var (%ilogior (%ilsl $vbitignoreunused 1)
                                         (nx-var-bits var)))
          (let ((afunc (make-afunc)))
            (setf (afunc-bits afunc) (%ilsl $fbitruntimedef 1))
            (setf (afunc-lfun afunc) var)
            (%temp-push var vars)
            (%temp-push (%temp-cons fname (%temp-cons 'function (%temp-cons afunc (var-name var)))) (lexenv.functions new-env)))))
      (make-acode
       (%nx1-operator let)
       vars
       vals
       (nx1-env-body body old-env)
       *nx-new-p2decls*))))

(defun maybe-warn-about-nx1-alphatizer-binding (funcname)
  (when (and (symbolp funcname)
             (gethash funcname *nx1-alphatizers*))
    (nx1-whine :special-fbinding funcname)))

(defnx1 nx1-flet flet (defs &body forms)
  (with-declarations
    (let* ((env *nx-lexical-environment*)
           (*nx-lexical-environment* env)
           (*nx-bound-vars* *nx-bound-vars*)
           (new-env (nx-new-lexical-environment env))
           (names nil)
           (funcs nil)
           (pairs nil)
           (fname nil)
           (name nil))
      (multiple-value-bind (body decls) (parse-body forms env nil)
        (nx-process-declarations decls)
        (dolist (def defs (setq names (nreverse names) funcs (nreverse funcs)))
          (debind (funcname lambda-list &body flet-function-body) def
            (setq fname (nx-need-function-name funcname))
            (maybe-warn-about-nx1-alphatizer-binding funcname)
            (multiple-value-bind (body decls)
                                 (parse-body flet-function-body env)
              (let ((func (make-afunc)))
                (setf (afunc-environment func) env
                      (afunc-lambdaform func) `(lambda ,lambda-list
                                                     ,@decls
                                                     (block ,(if (consp funcname) (%cadr funcname) funcname)
                                                       ,@body)))
                (%temp-push func funcs)
                (when (and *nx-next-method-var*
                             (eq funcname 'call-next-method)
                             (null *nx-call-next-method-function*))
                    (setq *nx-call-next-method-function* func))             
                (%temp-push (cons funcname func) pairs)
                (if (consp funcname)
                  (setq funcname fname))
                (%temp-push (setq name (make-symbol (symbol-name funcname))) names)
                (%temp-push (%temp-cons funcname (%temp-cons 'function (%temp-cons func name))) (lexenv.functions new-env))))))
        (let ((vars nil)
              (rvars nil)
              (rfuncs nil))
          ;(setq *nx-ignore-if-unused* names)
          (dolist (sym names vars) (%temp-push (nx-new-var sym) vars))
          (nx-effect-other-decls new-env)
          (setq body (let* ((*nx-lexical-environment* new-env))
                       (nx1-dynamic-extent-functions vars new-env)
                       (nx1-env-body body env)))
          (dolist (pair pairs)
            (let ((afunc (cdr pair))
                  (var (pop vars)))
              (when (or (afunc-callers afunc)
                        (neq 0 (afunc-fn-refcount afunc))
                        (neq 0 (afunc-fn-downward-refcount afunc)))
                (%temp-push (nx1-compile-inner-function (%car pair)
                                                  (afunc-lambdaform afunc)
                                                  afunc
                                                  (afunc-environment afunc))
                      rfuncs)
                (%temp-push var rvars))))
          (nx-reconcile-inherited-vars rfuncs)
          (dolist (f rfuncs) (nx1-afunc-ref f))
          (make-acode
           (%nx1-operator flet)
           rvars
           rfuncs
           body
           *nx-new-p2decls*))))))

(defun nx1-dynamic-extent-functions (vars env)
  (let ((bits nil)
        (varinfo nil))
    (dolist (decl (lexenv.fdecls env))
      (let ((downward-guy (if (eq (cadr decl) 'dynamic-extent) (car decl))))
        (when downward-guy
          (multiple-value-bind (finfo afunc) (nx-lexical-finfo downward-guy)
            (when (and afunc 
                       (not (%ilogbitp $fbitdownward (setq bits (afunc-bits afunc))))
                       (setq varinfo (and (consp (%cdr finfo)) (nx-lex-info (%cddr finfo))))
                       (memq varinfo vars))
              (setf (afunc-bits afunc) 
                    (%ilogior 
                     bits 
                     (%ilsl $fbitdownward 1)
                     (%ilsl $fbitbounddownward 1)))
              (nx-set-var-bits varinfo (%ilogior (%ilsl $vbitdynamicextent 1) (nx-var-bits varinfo))))))))))
          
(defnx1 nx1-labels labels (defs &body forms)
  (with-declarations
    (let* ((env *nx-lexical-environment*)
           (old-env (lexenv.parent-env env))
           (*nx-bound-vars* *nx-bound-vars*)
           (func nil)
           (funcs nil)
           (funcrefs nil)
           (bodies nil)
           (vars nil)
           (blockname nil)
           (fname nil)
           (name nil))
      (multiple-value-bind (body decls) (parse-body forms env nil)
        (nx-process-declarations decls)
        (dolist (def defs (setq funcs (nreverse funcs) bodies (nreverse bodies)))
          (destructuring-bind (funcname lambda-list &body labels-function-body) def
            (maybe-warn-about-nx1-alphatizer-binding funcname)
            (%temp-push (setq func (make-afunc)) funcs)
            (setq blockname funcname)
            (setq fname (nx-need-function-name funcname))
            (when (consp funcname)
              (setq blockname (%cadr funcname) funcname fname))
            (let ((var (nx-new-var (setq name (make-symbol (symbol-name funcname))))))
              (nx-set-var-bits var (%ilsl $vbitignoreunused 1))
              (%temp-push var vars))
            (%temp-push func funcrefs)
            (multiple-value-bind (body decls)
                                 (parse-body labels-function-body old-env)
              (%temp-push (%temp-cons funcname (%temp-cons 'function (%temp-cons func name))) (lexenv.functions env))
              (let* ((expansion `(lambda ,lambda-list 
                                   ,@decls 
                                   (block ,blockname
                                     ,@body))))
                (setf (afunc-lambdaform func) expansion
                      (afunc-environment func) env)
                (%temp-push (%temp-cons funcname expansion)
                            bodies)))))
        (nx-effect-other-decls env)
        (nx1-dynamic-extent-functions vars env)
        (dolist (def bodies)
          (nx1-compile-inner-function (car def) (cdr def) (setq func (pop funcs))))
        (setq body (nx1-env-body body old-env))
        (nx-reconcile-inherited-vars funcrefs)
        (dolist (f funcrefs) (nx1-afunc-ref f))
        (make-acode
         (%nx1-operator labels)
         (nreverse vars)
         (nreverse funcrefs)
         body
         *nx-new-p2decls*)))))

(defnx1 nx1-put-xxx ((%put-ptr) (%put-long) (%put-full-long) (%put-point) (%put-ostype) (%put-word) (%put-byte)
                     (%hput-ptr) (%hput-long) (%hput-full-long) (%hput-point) (%hput-ostype) (%hput-word) (%hput-byte)) 
        (ptr newval &optional (offset 0) &aux (op *nx-sfname*))
  (make-acode
   (%nx1-operator immediate-put-xxx)
   (case op
     (%put-ptr 0)
     (%hput-ptr 16)
     (%put-word 2)
     (%hput-word 18)
     (%put-byte 3)
     (%hput-byte 19)
     ((%hput-long %hput-full-long %hput-point %hput-ostype) 17)
     (t 1))
   (make-acode (%nx1-operator %macptrptr%) (nx1-form ptr))
   (let ((valform (nx1-form newval)))
     (if (or (eq op '%put-ptr) (eq op '%hput-ptr))
       (make-acode (%nx1-operator %macptrptr%) valform)
       valform))
   (nx1-form offset)))
   
(defnx1 nx1-set-xxx ((%set-ptr) (%set-long)  (%set-word) (%set-byte)
                     (%hset-ptr) (%hset-long)   (%hset-word) (%hset-byte)) 
        (ptr offset &optional (newval nil new-val-p) &aux (op *nx-sfname*))
  (unless new-val-p (setq newval offset offset 0))
  (make-acode
   (%nx1-operator %immediate-set-xxx)
   (case op
     (%set-ptr 0)
     (%hset-ptr 16)
     (%set-word 2)
     (%hset-word 18)
     (%set-byte 3)
     (%hset-byte 19)
     (%hset-long 17)
     (t 1))
   (make-acode (%nx1-operator %macptrptr%) (nx1-form ptr))
   (nx1-form offset)
   (nx1-form newval)))


(defnx1 nx1-get-xxx ((%get-long) (%get-point) (%get-full-long)  (%get-signed-long)
                     (%hget-long) (%hget-point) (%hget-full-long)  (%hget-signed-long)
                     (%get-fixnum) (%hget-fixnum)
                     (%get-word) (%get-unsigned-word)
                     (%hget-word) (%hget-unsigned-word)
                     (%get-byte) (%get-unsigned-byte)
                     (%hget-byte) (%hget-unsigned-byte)
                     (%get-signed-word) (%hget-signed-word)
                     (%get-signed-byte) (%hget-signed-byte)
                     (%get-unsigned-long) (%hget-unsigned-long))
  (ptrform &optional (offset 0))
  (let* ((sfname *nx-sfname*)
         (flagbits (case sfname
                     ((%get-long %get-full-long %get-point %get-signed-long) 1)
                     (%get-fixnum 33)
                     ((%hget-long %hget-full-long %hget-point %hget-signed-long) 17)
                     (%hget-fixnum 49)
                     ((%get-word %get-unsigned-word) 2)
                     ((%hget-word %hget-unsigned-word) 18)
                     (%get-signed-word 6)
                     (%hget-signed-word 22)
                     ((%get-byte %get-unsigned-byte) 3)
                     ((%hget-byte %hget-unsigned-byte) 19)
                     (%get-signed-byte 7)
                     (%hget-signed-byte 23)
                     (%get-unsigned-long 9)
                     (%hget-unsigned-long 25))))
    (declare (fixnum flagbits))
    (make-acode (%nx1-operator typed-form)
                (case (logand 15 flagbits)
                  (1 (case sfname
                       ((%get-fixnum %hget-fixnum) 'fixnum)
                       (t '(signed-byte 32))))
                  (9 '(unsigned-byte 32))
                  (2 '(unsigned-byte 16))
                  (6 '(signed-byte 16))
                  (3 '(unsigned-byte 8))
                  (7 '(signed-byte 8)))
                (make-acode 
                 (%nx1-operator immediate-get-xxx)
                 flagbits
                 (make-acode (%nx1-operator %macptrptr%) (nx1-form ptrform))
                 (nx1-form offset)))))

(defnx1 nx1-%get-ptr ((%get-ptr) (%hget-ptr)) (ptrform &optional (offset 0))
  (make-acode
   (%nx1-operator %consmacptr%)
   (make-acode
    (%nx1-operator immediate-get-ptr)
    (if (eq *nx-sfname* '%get-ptr) 0 16)
    (make-acode (%nx1-operator %macptrptr%) (nx1-form ptrform))
    (nx1-form offset))))

(defnx1 nx1-let let (pairs &body forms &environment old-env)
  (let* ((vars nil)
         (vals nil)
         (varspecs nil))
    (with-declarations
      (multiple-value-bind (body decls)
                           (parse-body forms *nx-lexical-environment* nil)
        (nx-process-declarations decls)
        ; Make sure that the initforms are processed in the outer
        ; environment (in case any declaration handlers side-effected
        ; the environment.)
        (let* ((*nx-lexical-environment* old-env))
          (dolist (pair pairs)
            (%temp-push (nx-need-var (nx-pair-name pair)) vars)
            (%temp-push (nx1-typed-var-initform (car vars) (nx-pair-initform pair)) vals)))
        (let* ((*nx-bound-vars* (append vars *nx-bound-vars*))
               (varbindings (nx1-note-var-bindings
                             (dolist (sym vars varspecs)
                               (%temp-push (nx-new-var sym) varspecs))
                             (setq vals (nreverse vals))))
               (form 
                (make-acode 
                 (%nx1-operator let)
                 varspecs
                 vals
                 (progn
                   (nx-effect-other-decls *nx-lexical-environment*)
                   (nx1-env-body body old-env))
                 *nx-new-p2decls*)))
          (nx1-check-var-bindings varbindings)
          (nx1-punt-bindings varspecs vals)
          form)))))

(defnx1 nx1-struct-typep ((structure-typep) (istruct-typep)) (&whole w struct typename)
  (if (eq *nx1-68k-target-inhibit* *nx1-target-inhibit*)
    (make-acode (%nx1-operator struct-typep) (nx1-form struct) (nx1-form typename))
    (nx1-treat-as-call w)))

#-ppc-target
(defnx1 nx1-with-stack-double-floats with-stack-double-floats ((&rest vars) &body body)
  (let* ((old-env *nx-lexical-environment*)
         (*nx-bound-vars* *nx-bound-vars*)
         (*nx-lexical-environment* old-env))
    (with-declarations
      (multiple-value-bind (body decls) (parse-body body *nx-lexical-environment*)
        (nx-process-declarations decls)
        (if vars
          (make-acode (%nx1-operator with-stack-double-floats)
                      (mapcar #'nx-new-var vars)
                      (progn
                        (nx-effect-other-decls *nx-lexical-environment*)
                        (nx1-env-body body old-env))
                      *nx-new-p2decls*)
          (progn
            (setq body (nx1-progn-body body))
            (if decls
              (make-acode (%nx1-operator %decls-body) body *nx-new-p2decls*)
              body)))))))

;((lambda (lambda-list) . body) . args)
(defun nx1-lambda-bind (lambda-list args body &optional (body-environment *nx-lexical-environment*))
  (let* ((old-env body-environment)
         (arg-env *nx-lexical-environment*)
         (arglist nil)
         var-bound-vars
         vars vals vars* vals*)
    ; If the lambda list contains &LEXPR, we can't do it.  Yet.
    (multiple-value-bind (ok req opttail resttail) (verify-lambda-list lambda-list)
      (declare (ignore req opttail))
      (when (and ok (eq (%car resttail) '&lexpr))
        (return-from nx1-lambda-bind (nx1-call (nx1-form `(lambda ,lambda-list ,@body)) args))))
    (let* ((*nx-lexical-environment* body-environment)
           (*nx-bound-vars* *nx-bound-vars*))
      (with-declarations
        (multiple-value-bind (body decls) (parse-body body *nx-lexical-environment*)
          (nx-process-declarations decls)
          (multiple-value-bind (req opt rest keys auxen)
                               (nx-parse-simple-lambda-list lambda-list)
            (let* ((*nx-lexical-environment* arg-env))
              (setq arglist (nx1-formlist args)))
            (nx-effect-other-decls *nx-lexical-environment*)
            (setq body (nx1-env-body body old-env))
            (while req
              (when (null arglist)
                (nx-error "Not enough args in Lambda form: ~S ~S." lambda-list args))
              (let* ((var (pop req))
                     (val (pop arglist))
                     (binding (nx1-note-var-binding var val)))
                (%temp-push var vars)
                (%temp-push val vals)
                (when binding (%temp-push binding var-bound-vars))))
            (nx1-check-var-bindings var-bound-vars)
            (nx1-punt-bindings vars vals)
            (debind (&optional optvars inits spvars) opt
              (while optvars
                (if arglist
                  (progn
                    (%temp-push (%car optvars) vars) (push (%car arglist) vals)
                    (when (%car spvars) (%temp-push (%car spvars) vars) (%temp-push *nx-t* vals)))
                  (progn
                    (%temp-push (%car optvars) vars*) (%temp-push (%car inits) vals*)
                    (when (%car spvars) (%temp-push (%car spvars) vars*) (%temp-push *nx-nil* vals*))))
                (setq optvars (%cdr optvars) spvars (%cdr spvars) inits (%cdr inits)
                      arglist (%cdr arglist))))
            (if arglist
              (when (and (not keys) (not rest))
                (nx-error "Extra args in Lambda form: ~S ~S." lambda-list args))
              (when rest
                (%temp-push rest vars*) (%temp-push *nx-nil* vals*)
                (nx1-punt-bindings (%temp-cons rest nil) (%temp-cons *nx-nil* nil))
                (setq rest nil)))
            (when keys
              (let* ((punt nil))
                (destructuring-bind (kallowother keyvars spvars inits keyvect) keys
                  (do* ((pairs arglist (%cddr pairs)))
                       ((null pairs))
                    (let* ((keyword (car pairs)))
                      (when (or (not (acode-p keyword))
                                (neq (acode-operator keyword) (%nx1-operator immediate))
                                (eq (%cadr keyword) :allow-other-keys))
                        (return (setq punt t)))))
                  (do* ((nkeys (length keyvect))
                        (keyargs (make-sequence 'vector nkeys :initial-element nil))
                        (argl arglist (%cddr argl))
                        (n 0 (%i+ n 1))
                        idx arg hit)
                       ((null argl)
                        (unless rest
                          (while arglist
                            (%temp-push (%cadr arglist) vals)
                            (setq arglist (%cddr arglist))))
                        (dotimes (i (the fixnum nkeys))                      
                          (%temp-push (%car keyvars) vars*)
                          (%temp-push (or (%svref keyargs i) (%car inits)) vals*)
                          (when (%car spvars)
                            (%temp-push (%car spvars) vars*)
                            (%temp-push (if (%svref keyargs i) *nx-t* *nx-nil*) vals*))
                          (setq keyvars (%cdr keyvars) inits (%cdr inits) spvars (%cdr spvars)))
                        (setq keys hit))
                    (setq arg (%car argl))
                    (unless (and (not punt)
                                 (%cdr argl))
                      (let ((var (nx-new-temp-var)))
                        (when (or (null rest) (%ilogbitp $vbitdynamicextent (nx-var-bits rest)))
                          (nx-set-var-bits var (%ilogior (%ilsl $vbitdynamicextent 1) (nx-var-bits var))))
                        (setq body (make-acode
                                    (%nx1-operator debind)
                                    nil
                                    (make-acode 
                                     (%nx1-operator lexical-reference) var)
                                    nil 
                                    nil 
                                    rest 
                                    keys 
                                    auxen 
                                    nil 
                                    body 
                                    *nx-new-p2decls* 
                                    nil)
                              rest var keys nil auxen nil)
                        (return nil)))
                    (unless (or (setq idx (position (%cadr arg) keyvect))
                                (eq (%cadr arg) :allow-other-keys)
                                (and kallowother (symbolp (%cadr arg))))
                      (nx-error "Invalid keyword in Lambda form: ~S ~S."
                                lambda-list args))
                    (when (and idx (null (%svref keyargs idx)))
                      (setq hit t)
                      (%svset keyargs idx n))))))
            (debind (&optional auxvars auxvals) auxen
              (let ((vars!% (nreconc vars* auxvars))
                    (vals!& (nreconc vals* auxvals)))
                (make-acode (%nx1-operator lambda-bind)
                            (append (nreverse vals) arglist)
                            (nreverse vars)
                            rest
                            keys
                            (list vars!% vals!&)
                            body
                            *nx-new-p2decls*)))))))))

(defun nx-inhibit-register-allocation (&optional (why 0))
  (let ((afunc *nx-current-function*))
    (setf (afunc-bits afunc)
          (%ilogior (%ilsl $fbitnoregs 1)
                    why
                    (afunc-bits afunc)))))

#-ppc-target
(defnx1 nx1-lap (old-lap lap) (&body forms)
  (nx-inhibit-register-allocation (%ilsl $fbitembeddedlap 1))
  (make-acode
   (%nx1-operator lap)
   (let ((vars nil)
         (bits 0))
     (do* ((env *nx-lexical-environment* (lexenv.parent-env env)))
          ((or (null env) (eq (%svref env 0) 'definition-environment)) vars)
       (let ((env-vars (lexenv.variables env)))
         (unless (atom env-vars)
           (dolist (v env-vars)
             (setq bits (nx-var-bits v))
             (unless (%ilogbitp $vbitspecial bits)
               (%temp-push (cons (var-name v) v) vars)
               (when (eq bits (var-bits v))
                 (setf (var-bits v) (%ilogior bits 
                                             (%ilsl $vbitreffed 1)
                                             (%ilsl $vbitsetq 1))))))))))
   forms))

(defnx1 nx1-ppc-lap-function (ppc-lap-function) (name bindings &body body)
  (require "PPC-LAP" "ccl:compiler;ppc;ppc-lap")
  (setf (afunc-lfun *nx-current-function*) 
        (%define-ppc-lap-function name `((let ,bindings ,@body))
                                  (dpb (length bindings) $lfbits-numreq 0))))

#-ppc-target
(defnx1 nx1-new-lap (new-lap) (&body forms)
  (let ((vars nil)
        (bits nil)
        (decls nil))
    (while (and (consp (car forms)) (keywordp (caar forms)))
      (%temp-push (pop forms) decls))
    (dolist (decl (setq decls (nreverse decls)))
      (case (car decl)
        ((:vargs :variable)
         (dolist (v (%cdr decl))
           (if (symbolp v) 
             (let ((var (nx-lex-info v nil)))
               (when (istruct-typep var 'var)
                 (setq bits (nx-var-bits var))
                 (unless (%ilogbitp $vbitspecial bits)
                   (nx-set-var-bits var (%ilogior bits (%ilsl $vbitreffed 1) (%ilsl $vbitnoreg 1) (%ilsl $vbitsetq 1)))
                   (%temp-push (%temp-cons v var) vars)))))))))
    (make-acode
     (%nx1-operator lap)
     (nreverse vars)
     forms)))

#-ppc-target
(defnx1 nx1-lap-inline old-lap-inline (arglist &body forms)
  (nx-inhibit-register-allocation (%ilsl $fbitembeddedlap 1))
  (make-acode
   (%nx1-operator lap-inline)
   (nx1-arglist arglist)
   (nx1-form (cons 'old-lap forms))))

#-ppc-target
(defnx1 nx1-new-lap-inline (lap-inline new-lap-inline) (arglist &body forms)
  ;!! should allow arbitrary register/form pairs in "arglist"
  (make-acode
   (%nx1-operator lap-inline)
   (nx1-arglist arglist) ;; screw
   (nx1-form (cons 'new-lap forms))))

(defun nx1-env-body (body old-env)
  (do* ((form (nx1-progn-body body))
        (env *nx-lexical-environment* (lexenv.parent-env env)))
       ((or (eq env old-env) (null env)) form)
    (let ((vars (lexenv.variables env)))
      (if (consp vars)
        (dolist (var vars)
          (nx-check-var-usage var))))))

(defnx1 nx1-let* (let* %vreflet) (varspecs &body forms)
  (let* ((vars nil)
         (vals nil)
         (val nil)
         (var-bound-vars nil)
         (*nx-bound-vars* *nx-bound-vars*)
         (old-env *nx-lexical-environment*))
    (with-declarations
      (multiple-value-bind (body decls)
                           (parse-body forms *nx-lexical-environment* nil)
        (nx-process-declarations decls)
        (dolist (pair varspecs)          
          (let* ((sym (nx-need-var (nx-pair-name pair)))
                 (var (progn 
                        (%temp-push (setq val (nx1-typed-var-initform sym (nx-pair-initform pair))) vals)
                        (nx-new-var sym)))
                 (binding (nx1-note-var-binding var val)))
            (when binding (%temp-push binding var-bound-vars))
            (%temp-push var vars)))
        (nx-effect-other-decls *nx-lexical-environment*)
        (let* ((result
                (make-acode 
                 (%nx1-default-operator)
                 (setq vars (nreverse vars))
                 (setq vals (nreverse vals))
                 (nx1-env-body body old-env)
                 *nx-new-p2decls*)))
          (nx1-check-var-bindings var-bound-vars)
          (nx1-punt-bindings vars vals)
          result)))))

(defnx1 nx1-multiple-value-bind multiple-value-bind 
        (varspecs bindform &body forms)
  (if (= (length varspecs) 1)
    (nx1-form `(let* ((,(car varspecs) ,bindform)) ,@forms))
    (let* ((vars nil)
           (*nx-bound-vars* *nx-bound-vars*)
           (old-env *nx-lexical-environment*)
           (mvform (nx1-form bindform)))
      (with-declarations
        (multiple-value-bind (body decls)
                             (parse-body forms *nx-lexical-environment* nil)
          (nx-process-declarations decls)
          (dolist (sym varspecs)
            (%temp-push (nx-new-var sym t) vars))
          (nx-effect-other-decls *nx-lexical-environment*)
          (make-acode 
           (%nx1-operator multiple-value-bind)
           (nreverse vars)
           mvform
           (nx1-env-body body old-env)
           *nx-new-p2decls*))))))

#-ppc-target
(defnx1 nx1-%make-uvector ((%make-uvector)) (&whole whole &environment env len &optional (subtype $v_genv) (init nil init-p))
  (if (or (not (fixnump (setq subtype (nx-get-fixnum subtype))))
          (not (eq *nx1-68k-target-inhibit* *nx1-target-inhibit*)))
    (progn
      (unless (eq *nx1-68k-target-inhibit* *nx1-target-inhibit*)
        (warn "~& Call to 68K-specific function : ~s ." whole))
      (nx1-treat-as-call whole))
    (make-acode (%nx1-operator %make-uvector) 
                (make-acode (%nx1-operator fixnum) subtype) 
                (nx1-form len)
                (nx1-form (if init-p init (if (eql subtype $v_floatv) 0.0))))))

; This isn't intended to be user-visible; there isn't a whole lot of 
; sanity-checking applied to the subtag.
(defnx1 nx1-%alloc-misc ((%alloc-misc)) (element-count subtag &optional (init nil init-p))
  (if init-p                            ; ensure that "init" is evaluated before miscobj is created.
    (make-acode (%nx1-operator %make-uvector)
                (nx1-form element-count)
                (nx1-form subtag)
                (nx1-form init))
    (make-acode (%nx1-operator %make-uvector)
                (nx1-form element-count)
                (nx1-form subtag))))

(defnx1 nx1-%lisp-word-ref (%lisp-word-ref) (base offset)
  (make-acode (%nx1-operator %lisp-word-ref)
              (nx1-form base)
              (nx1-form offset)))

; This idea went nowhere
#+later
(defnx1 nx1-%lisp-lowbyte-ref (%lisp-lowbyte-ref) (base offset)
  (make-acode (%nx1-operator %lisp-lowbyte-ref)
              (nx1-form base)
              (nx1-form offset)))
        
(defun nx-badformat (&rest args)
 (nx-error "Bad argument format in ~S ." args))

(defnx1 nx1-eval-when eval-when (when &body body)
  (nx1-progn-body (if (or (memq 'eval when) (memq :execute when)) body)))

(defnx1 nx1-misplaced (declare) (&rest args)
  (nx-error "~S not expected in ~S." *nx-sfname* (cons *nx-sfname* args)))

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
