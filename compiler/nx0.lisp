;; -*- Mode: Lisp; Package: CCL -*-

;; $Log: nx0.lisp,v $
;; Revision 1.2  2002/11/18 05:34:41  gtbyers
;; Add CVS log marker
;;
;;	Change History (most recent first):
;;  3 7/4/97   akh  short float stuff
;;  4 6/7/96   akh  inner-most-lfun-bits-keyvect - fix for interpreted
;;
;;  3 5/23/96  akh  nx-form-type knows about logical ops
;;  2 5/20/96  akh  crude stuff in nx-form-type for double-floats so we know that (+ float float) is float
;;                  add *nx-operator-result-types* for some double-float things
;;                  nx1-form sets *nx-form-type* if form is (the mumble ...)
;;  10 12/22/95 gb  some ppc-target changes
;;
;;  8 12/3/95  bill CCL 3.0x44
;;  7 12/1/95  gb   use allocate-typed-vector in make-afunc
;;  5 11/24/95 Bill St. Clair 3.0x43
;;  2 10/6/95  gb   musta done something ...
;;
;;  5 2/3/95   akh  merge with leibniz patches
;;  4 1/30/95  akh  nothing really
;;  (do not edit before this line!!)


(in-package :ccl)

;; :compiler:nx0.lisp - part of the compiler
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

;; Modification History
; nx-tag-info - handles bignum tags - boy is that stupid
; ----- 5.2b6
; 07/06/01 akh nx-inline-expansion from slh for fns both inlined and fletted
; ------ 4.4b1
; 05/23/00 AKH nx-transform-symbol - beware global symbol-macro
; ------ 4.3.1b1 
; AKH PASS ENV TO TYPE-SPECIFIER-P 
; export destructive
; -------- 4.3f1c1
; 07/03/99 akh add *nx1-without-interrupts*, bound t in scope of nx1-without-interrupts, checked in nx1-call.
;              calls in scope do not suppress event check in outer loops
; 06/26/99 akh warn if a decl references an unknown type
;--------------- 4.3b3
; 05/08/99 akh nx1-check-call-args does gf's too, but no keyword checking etc.
; 05/07/99 akh aware of define-symbol-macro in nx1-form 
; ----------- 4.3b1
; 03/27/99 akh  nx-form-type does car/cdr - ??
; 02/24/99 akh  nx1-call - do not assume that builtin functions will do event-check
; 12/31/98 akh  nx-form-type considers type of aset as well
; 07/08/98 akh  define-compiler-macro remembers doc string if any
; 05/31/98 akh  nx-form-type considers type of aref for numeric types of element-type, also constant-symbol-p 
; 06/14/97 akh   grovel-numeric-type kludge knows about short-floats
; 02/14/97 gb    short-float treated as immediate.
; 01/15/97 bill  nx-transform calls maybe-optimize-slot-accessor-form.
;                Bootstrapping version of maybe-optimize-slot-accessor-form.
;                Real one is in "ccl:compiler;optimizers.lisp"
; -------------  4.0
; 10/10/96 slh   nx-declared-type, *nx-compile-time-types*, *nx-proclaimed-types*,
;                *nx-method-warning-name*, *compiler-warning-formats*, report-compiler-warning,
;                *nx1-alphatizers*, environment-structref-info -> nx-basic.lisp
; 10/07/96 bill nx1-type-intersect no longer attempts to call type-specifier with a non ctype.
; ------------  4.0b2
; 07/30/96 gb   dbg -> bug.
; 07/18/96 gb   stop calling %make-uarray-1, whatever that is.
; 06/20/96 gb   merge-compiler-warnings, nx-declared-inline-p ->  nx.lisp
; akh inner-most-lfun-bits-keyvect - fix for interpreted
; akh - grovel for logical ops in nx-form-type
; akh - crude stuff in nx-form-type for double-floats so we know that (+ float float) is float
;        add *nx-operator-result-types* for some double-float things
;        nx1-form sets *nx-form-type* if form is (the mumble ...)
; 04/10/96 gb   move PARSE-BODY to lambda-list.lisp
; 02/20/06 gb   less bogus NX1-TYPE-INTERSECT
; 01/19/96 gb   add %setf-double-float.
; 01/10/96 gb   unknown declarations become implicit type declarations.
; 01/04/96 gb   $numargregs/$numppcargregs conditionalization; init *target-compiler-macros*
;               per target.
; 12/13/95 gb   recognize, generate builtin-calls on PPC
; 12/11/95 bill Ignore 68K compiler macros when compiling for PPC
; 12/01/95 bill Fix merge error in make-afunc
; 11/17/95 bill when ppc-target-p, nx1-whine doesn't whine about :undefined-function's
;               in *ppc-functions-not-on-68k*.
; 11/14/95 slh  mods. for PPC target
; 11/12/95 gb   allow (fake) %temp-cons/%temp-list on PPC.
; 5/12/95 slh   nx-constant-fold: back to warning about compile-time folding errors
; 3/30/95 slh   merge in base-app changes
;-------------  3.0d18
; 1/27/95 slh   gb's new nx1-transitively-punt-bindings
; 1/25/95 akh   comment out warning about overzealous elimination
;------------- 3.0d16
;11/30/92 alice nx1-compile-lambda may let *nx-cur-func-name* be *nx-method-warning-name*
;09/18/92 bill  innermost-lfun-bits-keyvect no longer calls find-unencapsulated-definition
;               for generic functions. This makes it work correctly on traced
;               generic functions.
;06/19/92 bill  Make arg checking of a call to a generic function work except for keys.
;               Also, check for even length tail when calling a function that
;               accepts keys, even if &allow-other-keys was specified
;06/01/92 bill  Check for %call-next-method-with-args that was in nx1-note-fcell-ref
;               has moved to pass 2. *nx-call-next-method-with-args-p* is no more.
;------------- 2.0
;02/26/92 bill  innermost-lfun-bits-keyvect always says generic-functions have no keys.
;               This prevents bogus warnings.
;11/20/91 bill  gb's patch to nx-inline-expansion
;05/23/91 bill  nx1-call supports fbind
;04/29/91 bill  from GB: check $fbitruntimedef in nx1-call
;02/28/91 alice define a fn merge-compiler-warnings so eval can use it too.
;02/26/91 alice add type-error and file-error to *nx-never-tail-call*
;------------ 2.0b1
;02/06/91 bill nx-lex-info & nx-lexical-finfo patches from patch2.0b1p0
;02/04/91 bill (nx1-whine :declaration ...) -> (nx1-whine :unknown-declaration ...)
;01/24/91 bill compiler-function-overflow inherits from condition.
;              compiler-function-overflow function.
;01/31/91 gb nx-inline-decl erroneosly paren'd if 
; ------- 2.0a5
;10/20/90 bill GB's nx-tag-info fix
; 6/21/90 gb  nx-lex-info can get called with null *nx-lexical-environment* (via nx-declared-type, others?)
;             it shouldn't be called this way, but it also shouldn't %svref NIL ...
;07/06/90 bill *nx-call-next-method-with-args-p*
;06/22/90 bill in nx1-call-result-type: *nx-cur-func-name* -> *nx-global-function-name* per GB.
;06/18/90 bill nx-lex-info: symbol-macrolet expansion is (%caddr info), not (%cddr info)
;06/14/90 bill check for symbolp before compiler-macro-function in compiler-macroexpand-1
;06/08/90 gb  nx-proclaimed-parameter-p is your friend.  It's not like the others.
;04/30/90 gb   lotsa changes.
;03/06/90 bill nx-transform: changed next-method-p to conform to new magic next-methods arg.
;12/28/89  gz  support for setf functions in nx1-func-name, nx-inline-decl.
;              added nxenv-local-function-p for use by ansi setf.
;29-Nov-89 Mly Don't blow out on (declare (type (or null unknown-type) foo))
;25-Nov-89 gb *nx2-inhibit-register-allocation*
;11/18/89  gz  '%structure-ref -> %structure-refs%.
;              put 'setf-inverse -> defsetf.
;12-Nov-89 Mly Unknown type isn't fatal error; just warn
;09/05/89 gz (push 'notspecial  *nx-known-declarations*)
;7/26/89  gz change call-next-method handling, make 'em funcallable.
;            added nx-new-temp-var, use it.
;04/19/89 gz Added nx-form-typep.  nx-form-type knows about require-type.
;            No more lambda-to-let, was buggy.  Support lambda binding directly.
;03/10/89 gz &method.
;03/03/89 gz Handle constant folding and synonyms directly in nx-transform.
;            Transform '23 to 23, so callers don't need to check...
;11/25/88 gz Obey *inhibit-error* in nx-error.
;8/20/88 gz ok to check proclaimed-parameter-p now.
;           Changed inline stuff a bit, proclaimed-ignore.
;           changed how warnings are done.
;           Made afuncs into istructs.  Transform compile-time defstruct refs.
;           check type declarations.
;8/13/88 gb *nx-warning-hook* bound.
;8/3/88 gz Removed declaration from known-declarations (legal in proclaim only).
;	   nx-tranform macroexpands notinline pseudospecials.
; 8/2/88  gb  stop parsing &lexpr, parse dynamic-extent decls.



; Phony AFUNC "defstruct":
(defun make-afunc (&aux (v (allocate-typed-vector :istruct $afunc-size nil)))
  (setf (%svref v 0) 'afunc)
  (setf (afunc-fn-refcount v) 0)
  (setf (afunc-fn-downward-refcount v) 0)
  (setf (afunc-bits v) 0)
  v)

(defvar *nx-blocks* nil)
(defvar *nx-tags* nil)
(defvar *nx-parent-function* nil)
(defvar *nx-current-function* nil)
(defvar *nx-lexical-environment* nil)
(defvar *nx-symbol-macros* nil)
(defvar *compile-time-symbol-macros* nil)
(defvar *nx-inner-functions* nil)
(defvar *nx-cur-func-name* nil)
(defvar *nx-form-type* t)
(defvar *nx-nlexit-count* 0)
(defvar *nx-event-checking-call-count* 0)
;(defvar *nx-proclaimed-inline* nil)
;(defvar *nx-proclaimed-inline* (make-hash-table :size 400 :test #'eq))
(defvar *nx-proclaimed-ignore* nil)
(defvar *nx-parsing-lambda-decls* nil) ; el grosso.
(defparameter *nx-standard-declaration-handlers* nil)
(defparameter *nx-hoist-declarations* t)
(defvar *nx1-without-interrupts* nil)

(defvar *nx1-vcells* nil)
(defvar *nx1-fcells* nil)

(defvar *nx1-operators* (make-hash-table :size 160 :test #'eq))

; Things which have "alphatizers* which shouldn't be used on the indicated target.

; Don't extract PPC tags on the 68K.
(defparameter *nx1-68k-target-inhibit* '(ppc-lisptag ppc-fulltag ppc-typecode
                                         ppc-lap-function %alloc-misc %ppc-gvector ppc-ff-call 
                                         %typed-miscref %typed-misc-set))

; This is a longer list, 'cause we don't want to use subprims to implement 
; nearly as many functions.
(defparameter *nx1-ppc-target-inhibit* 
  '(%ttag %ttagp dtagp lap lap-inline old-lap-inline  with-stack-double-floats
   %make-uvector %gvector ff-call %gen-trap %typed-uvref %typed-uvset))

(defparameter *nx1-target-inhibit* 
  #-ppc-target *nx1-68k-target-inhibit*
  #+ppc-target *nx1-ppc-target-inhibit*)

                                         

; The compiler can (generally) use temporary vectors for VARs.
(defun nx-cons-var (name &optional (bits 0))
  (%istruct 'var name bits nil nil nil nil))

(defun nx-new-lexical-environment (&optional parent)
  (%istruct 'lexical-environment parent nil nil nil nil nil nil))


(defvar *nx-lambdalist* (make-symbol "lambdalist"))
(defvar *nx-nil* (list (make-symbol "nil")))
(defvar *nx-t* (list (make-symbol "t")))

(defparameter *nx-current-compiler-policy* (%default-compiler-policy))

(defvar *nx-next-method-var* nil)
(defvar *nx-call-next-method-function* nil)

(defvar *nx-sfname* nil)
(defvar *nx-operators* ())
(defvar *nx-warnings* nil)

(defvar *nx1-compiler-special-forms* nil "Real special forms")

(defvar *nx-never-tail-call* '(error cerror break warn type-error file-error
                               #-bccl %get-frame-pointer
                               #-bccl break-loop)
 "List of functions which never return multiple values and
   should never be tail-called.")

(eval-when (:load-toplevel)
  (when (not (fboundp 'type-specifier-p))
    (defun type-specifier-p (form)  ;; redefined later
      (declare (ignore form))
      t)))

#-bccl (defvar *cross-compiling* nil "bootstrapping")



(defparameter *nx-operator-result-types*
  '((#.(%nx1-operator list) . list)
    (#.(%nx1-operator memq) . list)
    (#.(%nx1-operator %temp-list) . list)
    (#.(%nx1-operator assq) . list)
    (#.(%nx1-operator cons) . cons)
    (#.(%nx1-operator rplaca) . cons)
    (#.(%nx1-operator %rplaca) . cons)
    (#.(%nx1-operator rplacd) . cons)
    (#.(%nx1-operator %rplacd) . cons)
    (#.(%nx1-operator %temp-cons) . cons)
    (#.(%nx1-operator %i+) . fixnum)
    (#.(%nx1-operator %i-) . fixnum)
    (#.(%nx1-operator %i*) . fixnum)
    (#.(%nx1-operator %ilsl) . fixnum)
    (#.(%nx1-operator %ilsr) . fixnum)
    (#.(%nx1-operator %iasr) . fixnum)
    
    (#.(%nx1-operator %ilogior2) . fixnum)
    (#.(%nx1-operator %ilogand2) . fixnum)
    (#.(%nx1-operator %ilogxor2) . fixnum)
    (#.(%nx1-operator %code-char) . character)
    (#.(%nx1-operator schar) . character)
    (#.(%nx1-operator length) . fixnum)
    (#.(%nx1-operator uvsize) . fixnum)
    (#.(%nx1-operator %double-float/-2) . double-float)
    (#.(%nx1-operator %double-float/-2!) . double-float) ; no such operator
    (#.(%nx1-operator %double-float+-2) . double-float)
    (#.(%nx1-operator %double-float+-2!) . double-float)
    (#.(%nx1-operator %double-float--2) . double-float)
    (#.(%nx1-operator %double-float--2!) . double-float)
    (#.(%nx1-operator %double-float*-2) . double-float)
    (#.(%nx1-operator %double-float*-2!) . double-float)
    (#.(%nx1-operator %short-float/-2) . short-float)
    (#.(%nx1-operator %short-float/-2!) . short-float)
    (#.(%nx1-operator %short-float+-2) . short-float)
    (#.(%nx1-operator %short-float+-2!) . short-float)
    (#.(%nx1-operator %short-float--2) . short-float)
    (#.(%nx1-operator %short-float--2!) . short-float)
    (#.(%nx1-operator %short-float*-2) . short-float)
    (#.(%nx1-operator %short-float*-2!) . short-float)
    (#.(%nx1-operator  %fixnum-shift-left-right) . fixnum)
   ))

(defparameter *nx-operator-result-types-by-name*
  '((%ilognot . fixnum)
    (%ilogxor . fixnum)
    (%ilogand . fixnum)
    (%ilogior . fixnum)))

(setq *nx-known-declarations*
  '(special inline notinline type ftype function ignore optimize dynamic-extent ignorable
    ignore-if-unused settable unsettable
    %noforcestk notspecial global-function-name debugging-function-name resident))

(defun find-optimize-quantity (name env)
  (let ((pair ()))
    (loop
      (when (listp env) (return))
      (when (setq pair (assq name (lexenv.mdecls env)))
        (return (%cdr pair)))
      (setq env (lexenv.parent-env env)))))
    
(defun debug-optimize-quantity (env)
  (or (find-optimize-quantity 'debug env)
      *nx-debug*))

(defun space-optimize-quantity (env)
  (or (find-optimize-quantity 'space env)
      *nx-space*))

(defun safety-optimize-quantity (env)
  (or (find-optimize-quantity 'safety env)
      *nx-safety*))

(defun speed-optimize-quantity (env)
  (or (find-optimize-quantity 'speed env)
      *nx-speed*))

(defun compilation-speed-optimize-quantity (env)
  (or (find-optimize-quantity 'compilation-speed env)
      *nx-cspeed*))

(defvar *nx-speed* 1)
(defvar *nx-space* 1)
(defvar *nx-safety* 1)
(defvar *nx-cspeed* 1)
(defvar *nx-debug* 1)
(defvar *nx2-noforcestk* nil)  ; mostly for lap's benefit, so far.
(defvar *nx-ignore-if-unused* ())
(defvar *nx-new-p2decls* ())
(defvar *nx-inlined-self* t)
(defvar *nx-all-vars* nil)
(defvar *nx-bound-vars* nil)
(defvar *nx-punted-vars* nil)
(defvar *nx-inline-expansions* nil)
(defparameter *nx-compile-time-compiler-macros* nil)
(defvar *nx-global-function-name* nil)
(defvar *nx-new-fdecls* nil) ; in the function namespace, canonicalized
(defvar *nx-new-vdecls* nil) ; in the variable namespace.
(defvar *nx-new-mdecls* nil) ; declarations not associated with functions/variables, e.g., OPTIMIZE.
(defvar *nx-can-constant-fold* ())
(defvar *nx-synonyms* ())
(defvar *nx-load-time-eval-token* ())

(define-condition compiler-function-overflow (condition) ())

(defun compiler-function-overflow ()
  (signal 'compiler-function-overflow)
  (error "Function size exceeds compiler limitation."))

(defvar *compiler-macros* (make-hash-table :size 100 :test #'eq))

; Just who was responsible for the "FUNCALL" nonsense ?
; Whoever it is deserves a slow and painful death ...

#|
(defmacro define-compiler-macro  (name arglist &body body &environment env)
  (unless (symbolp name) (report-bad-arg name 'symbol))
  (let ((body (parse-macro-1 name arglist body env)))
    `(eval-when (:compile-toplevel :load-toplevel :execute)
       (setf (compiler-macro-function ',name)
             (nfunction (compiler-macro-function ,name) ,body))         
       ',name)))
|#

(defmacro define-compiler-macro  (name arglist &body body &environment env)
  (unless (symbolp name) (report-bad-arg name 'symbol))
  (multiple-value-bind (body doc) (parse-macro-1 name arglist body env)
    `(eval-when (:compile-toplevel :load-toplevel :execute)
       (setf (compiler-macro-function ',name)
             (nfunction (compiler-macro-function ,name) ,body))
       (when ,doc
         (setf (documentation ',name 'compiler-macro) ,doc))
       ',name)))

; This is silly (as may be the whole idea of actually -using- compiler-macros).
; Compiler-macroexpand-1 will return a second value of  NIL if the value returned
; by the expansion function is EQ to the original form.
; This differs from the behavior of macroexpand-1, but users are not encouraged
; to write macros which return their &whole args (as the DEFINE-COMPILER-MACRO
; issue encourages them to do ...)
; Cheer up! Neither of these things have to exist!
(defun compiler-macroexpand-1 (form &optional env)
  (let ((expander nil)
        (newdef nil))
    (if (and (consp form)
             (symbolp (car form))
             (setq expander (compiler-macro-function (car form) env)))
      (values (setq newdef (funcall *macroexpand-hook* expander form env)) (neq newdef form))
      (values form nil))))

; ... If this exists, it should probably be exported.
(defun compiler-macroexpand (form &optional env)
  (multiple-value-bind (new win) (compiler-macroexpand-1 form env)
    (do* ((won-at-least-once win))
         ((null win) (values new won-at-least-once))
      (multiple-value-setq (new win) (compiler-macroexpand-1 new env)))))

#-ppc-target (defvar *68k-target-compiler-macros* (make-hash-table :test #'eq))
(defvar *ppc-target-compiler-macros* (make-hash-table :test #'eq))

(defvar *target-compiler-macros* #-ppc-target *68k-target-compiler-macros* #+ppc-target *ppc-target-compiler-macros*)

#-ppc-target
(eval-when (:compile-toplevel :load-toplevel :execute)


(defun (setf 68k-compiler-macro-function) (new name)
  (unless (symbolp name) (report-bad-arg name 'symbol))
  (if new
    (setf (gethash name *68k-target-compiler-macros*) new)
    (remhash name *68k-target-compiler-macros*))
  new)

(defmacro define-68k-compiler-macro  (name arglist &body body &environment env)
  (unless (symbolp name) (report-bad-arg name 'symbol))
  (unless (ppc-target-p)
    (let ((body (parse-macro-1 name arglist body env)))
      `(eval-when (:compile-toplevel :load-toplevel :execute)
         (setf (68k-compiler-macro-function ',name)
               (nfunction (68k-compiler-macro-function ,name) ,body))         
         ',name))))

)

#+ppc-target
(defmacro define-68k-compiler-macro (&whole w name arglist &body body)
  (declare (ignore w name arglist body))
  "huh?")

(defun compiler-macro-function (name &optional env)
  (unless (nx-lexical-finfo name env)
    (or (cdr (assq name *nx-compile-time-compiler-macros*))
        ; Look at target-specific macros first
        (values (gethash name *target-compiler-macros*))
        (values (gethash name *compiler-macros*)))))

(defun set-compiler-macro-function (name def)
  (unless (symbolp name) (report-bad-arg name 'symbol))
  (if def
    (setf (gethash name *compiler-macros*) def)
    (remhash name *compiler-macros*))
  def)

(defsetf compiler-macro-function set-compiler-macro-function)

(defun nx-apply-env-hook (hook env &rest args)
  (declare (dynamic-extent args))
  (when (fixnump hook) (setq hook (uvref *nx-current-compiler-policy* hook)))
  (if hook
    (if (functionp hook)
      (apply hook env args)
      t)))

(defun nx-self-calls-inlineable (env)
  (nx-apply-env-hook policy.inline-self-calls env))

(defun nx-allow-register-allocation (env)
  (not (nx-apply-env-hook policy.inhibit-register-allocation env)))

(defun nx-trust-declarations (env)
  (unless (eq (safety-optimize-quantity env) 3)
    (nx-apply-env-hook policy.trust-declarations env)))

(defun nx-open-code-in-line (env)
  (nx-apply-env-hook policy.open-code-inline env))

(defun nx-inline-car-cdr (env)
  (unless (eq (safety-optimize-quantity env) 3)
    (nx-apply-env-hook policy.inhibit-safety-checking env)))

(defun nx-inhibit-safety-checking (env)
  (unless (eq (safety-optimize-quantity env) 3)
    (nx-apply-env-hook policy.inhibit-safety-checking env)))

(defun nx-tailcalls (env)
  (nx-apply-env-hook policy.allow-tail-recursion-elimination env))

(defun nx-allow-transforms (env)
  (nx-apply-env-hook policy.allow-transforms env))

(defun nx-inhibit-eventchecks (env)
  (unless (eq (safety-optimize-quantity env) 3)
    (nx-apply-env-hook policy.inhibit-event-checking env)))

(defun nx-force-boundp-checks (var env)
  (or (eq (safety-optimize-quantity env) 3)
      (nx-apply-env-hook policy.force-boundp-checks var env)))

(defun nx-substititute-constant-value (symbol value env)
  (nx-apply-env-hook policy.allow-constant-substitution symbol value env))

#-bccl
(defun nx1-default-operator ()
 (or (gethash *nx-sfname* *nx1-operators*)
     (error "Bug - operator not found for  ~S" *nx-sfname*)))

(defun nx-new-temp-var (&optional (pname "COMPILER-VAR"))
  (let ((var (nx-new-var (make-symbol pname))))
    (nx-set-var-bits var (%ilogior (%ilsl $vbitignoreunused 1) (nx-var-bits var)))
    var))

(defun nx-new-vdecl (name class &optional info)
  (%temp-push (%temp-cons name (%temp-cons class info)) *nx-new-vdecls*))

(defun nx-new-fdecl (name class &optional info)
  (%temp-push (%temp-cons name (%temp-cons class info)) *nx-new-fdecls*))

(defun nx-new-var (sym &optional (check t))
  (nx-init-var (nx-cons-var (nx-need-var sym check) 0)))
                    
(defun nx-proclaimed-special-p (sym)
  (setq sym (nx-need-sym sym))
  (let* ((defenv (definition-environment *nx-lexical-environment*))
         (specials (if defenv (defenv.specials defenv))))
    (or (assq sym specials)
        (proclaimed-special-p sym))))

(defun nx-proclaimed-parameter-p (sym)
  (or (constantp sym)
      (multiple-value-bind (special-p info) (nx-lex-info sym t)
        (or 
         (and (eq special-p :special) info)
         (let* ((defenv (definition-environment *nx-lexical-environment*)))
           (if defenv 
             (or (%cdr (assq sym (defenv.specials defenv)))
                 (assq sym (defenv.constants defenv)))))))))

(defun nx-process-declarations (decls &optional (env *nx-lexical-environment*) &aux s f)
  (dolist (decl decls (values *nx-new-vdecls* *nx-new-fdecls* *nx-new-mdecls*))
    (dolist (spec (%cdr decl))
      (if (memq (setq s (car spec)) *nx-known-declarations*)
        (if (setq f (getf *nx-standard-declaration-handlers* s))
          (funcall f spec env))
        ; Any type name is now (ANSI CL) a valid declaration.
        ; We should probably do something to distinguish "type names" from "typo names",
        ; so that (declare (inliMe foo)) warns unless the compiler has some reason to
        ; believe that 'inliMe' (inlemon) has been DEFTYPEd.
        (progn  (if (not (type-specifier-p s ENV))(nx-bad-decls spec))
                (dolist (var (%cdr spec))
                  (if (symbolp var)
                    (nx-new-vdecl var 'type s))))))))

; Put all variable decls for the symbol VAR into effect in environment ENV.  Now.
; Returns list of all new vdecls pertaining to VAR.
(defun nx-effect-vdecls (var env)
  (let ((vdecls (lexenv.vdecls env))
        (own nil))
    (dolist (decl *nx-new-vdecls* (setf (lexenv.vdecls env) vdecls))
      (when (eq (car decl) var) 
        (when (eq (cadr decl) 'type)
          (let* ((newtype (cddr decl))
                 (merged-type (nx1-type-intersect var newtype (nx-declared-type var env))))
             (unless (eq merged-type newtype)
              (rplacd (cdr decl) merged-type))))
        (push decl vdecls)
        (push (cdr decl) own)))
    own))


(defun nx1-typed-var-initform (sym form &optional (env *nx-lexical-environment*))
  (let* ((type t)
         (*nx-form-type* (if (nx-trust-declarations env)
                           (dolist (decl *nx-new-vdecls* type)
                            (when (and (eq (car decl) sym) (eq (cadr decl) 'type))
                              (setq type (nx1-type-intersect sym type (cddr decl)))))
                           t)))
    (nx1-typed-form form env)))

; Guess.
(defun nx-effect-fdecls (var env)
  (let ((fdecls (lexenv.fdecls env))
        (own nil))
    (dolist (decl *nx-new-fdecls* (setf (lexenv.fdecls env) fdecls))
      (when (eq (car decl) var) 
        (push decl fdecls)
        (push (cdr decl) own)))
    own))

#-ppc-target
(progn
(defun nx-acode-form-typep (form type env)
  (let* ((*nx2-trust-declarations* (nx-trust-declarations env)))
    (nx2-form-typep form type)))

(defun nx-acode-form-type (form env)
  (let* ((*nx2-trust-declarations* (nx-trust-declarations env)))
    (nx2-form-type form)))

(defun nx-acode-fixnum-type-p (form env)
  (let* ((*nx2-trust-declarations* (nx-trust-declarations env)))
    (nx2-fixnum-type-p form)))
)

#+ppc-target
(progn
(defun nx-acode-form-typep (form type env)
  (let* ((*ppc2-trust-declarations* (nx-trust-declarations env)))
    (ppc2-form-typep form type)))

(defun nx-acode-form-type (form env)
  (let* ((*ppc2-trust-declarations* (nx-trust-declarations env)))
    (ppc2-form-type form)))

(defun nx-acode-fixnum-type-p (form env)
  (let* ((*ppc2-trust-declarations* (nx-trust-declarations env)))
    (ppc2-fixnum-type-p form)))
)

(defun nx-effect-other-decls (env)
  (flet ((merge-decls (new old)
                      (dolist (decl new old) (pushnew decl old :test #'eq))))
    (let ((vdecls *nx-new-vdecls*)
          (fdecls *nx-new-fdecls*)
          (mdecls *nx-new-mdecls*))
      (when vdecls
        (let ((env-vdecls (lexenv.vdecls env)))
          (dolist (decl vdecls (setf (lexenv.vdecls env) env-vdecls))
            (unless (memq decl env-vdecls)
              (when (eq (cadr decl) 'type)
                (let* ((var (car decl))
                       (newtype (cddr decl))
                       (merged-type (nx1-type-intersect var newtype (nx-declared-type var env))))
                  (unless (eq merged-type newtype)
                    (rplacd (cdr decl) merged-type))))
              (push decl env-vdecls)))))
      (when fdecls (setf (lexenv.fdecls env) (merge-decls fdecls (lexenv.vdecls env))))
      (when mdecls (setf (lexenv.mdecls env) (merge-decls mdecls (lexenv.mdecls env))))
      (setq *nx-inlined-self* (and (nx-self-calls-inlineable env) 
                                   (let ((name *nx-global-function-name*)) 
                                     (and name (not (nx-declared-notinline-p name env))))))
      (unless (nx-allow-register-allocation env)
        (nx-inhibit-register-allocation))
      (setq *nx-new-p2decls* 
            (%ilogior 
             (if *nx2-noforcestk* $decl_noforcestk 0)
             (if (nx-tailcalls env) $decl_tailcalls 0)
             (if (nx-inhibit-eventchecks env) $decl_eventchk 0)
             (if (nx-open-code-in-line env) $decl_opencodeinline 0)
             (if (nx-inhibit-safety-checking env) $decl_unsafe 0)
             (if (nx-trust-declarations env) $decl_trustdecls 0))))))

#|     
(defun nx-find-misc-decl (declname env)
  (loop
    (unless (and env (eq (uvref env 0) 'lexical-environment)) (return))
    (dolist (mdecl (lexenv.mdecls env))
      (if (atom mdecl)
        (if (eq mdecl declname)
          (return-from nx-find-misc-decl t))
        (if (eq (%car mdecl) declname)
          (return-from nx-find-misc-decl (%cdr mdecl)))))
    (setq env (lexenv.parent-env env))))
|#


(defun nx-bad-decls (decls)
  (nx1-whine :unknown-declaration decls))

(defnxdecl special (decl env)
  (declare (ignore env))
  (dolist (s (%cdr decl))
    (if (symbolp s) 
      (nx-new-vdecl s 'special)
      (nx-bad-decls decl))))

(defnxdecl destructive (decl env)
  (declare (ignore env))
  (dolist (s (%cdr decl))
    (if (symbolp s) 
      (progn (nx-new-vdecl s 'destructive))
      (nx-bad-decls decl))))

(export '(destructive))

(defnxdecl dynamic-extent (decl env)
  (declare (ignore env))
  (dolist (s (%cdr decl))
    (if (symbolp s) 
      (nx-new-vdecl s 'dynamic-extent t)
      (if (and (consp s)
               (eq (%car s) 'function)
               (consp (%cdr s))
               (symbolp (setq s (%cadr s))))
        (nx-new-fdecl s 'dynamic-extent t)
        (nx-bad-decls decl)))))

(defnxdecl ignorable (decl env)
  (declare (ignore env))
  (dolist (s (%cdr decl))
    (if (symbolp s) 
      (nx-new-vdecl s 'ignore-if-unused t)
      (if (and (consp s)
               (eq (%car s) 'function)
               (consp (%cdr s))
               (symbolp (setq s (%cadr s))))
        (nx-new-fdecl s 'ignore-if-unused t)
        (nx-bad-decls decl)))))

(defnxdecl ftype (decl env)
  (declare (ignore env))
  (destructuring-bind (type &rest fnames) (%cdr decl)
    (dolist (s fnames)
      (nx-new-fdecl s 'ftype type))))

(defnxdecl settable (decl env)
  (nx-settable-decls decl env t))

(defnxdecl unsettable (decl env)
  (nx-settable-decls decl env nil))

(defun nx-settable-decls (decl env val)
  (declare (ignore env))
  (dolist (s (%cdr decl))
    (if (symbolp s)
      (nx-new-vdecl s 'settable val)
      (nx-bad-decls decl))))

(defnxdecl type (decl env)
  ;(declare (ignore env))
  (labels ((kludge (type) ; 0 => known, 1 => unknown, 2=> illegal
             (cond ((type-specifier-p type ENV)
                    0)
                   ((and (consp type)
                         (member (car type) '(and or))
                         (not (null (list-length type))))
                    (do ((result 0 (max result (kludge (car tail))))
                         (tail (cdr type) (cdr tail)))
                        ((null tail)
                         result)))
                   ((not (symbolp type))
                    ;;>>>> nx-bad-decls shouldn't signal a fatal error!!!!
                    ;;>>>> Most callers of nx-bad-decls should just ignore the
                    ;;>>>> losing decl element and proceed with the rest
                    ;;>>>>  (ie (declare (ignore foo (bar) baz)) should
                    ;;>>>>   have the effect of ignoring foo and baz as well
                    ;;>>>>   as WARNING about the mal-formed declaration.)
                    (nx-bad-decls decl)
                    2)
                   (t 1))))
    (let* ((spec (%cdr decl))
           (type (car spec)))
      (case (kludge type)
        ((0)
         (dolist (sym (cdr spec))
           (if (symbolp sym)
             (nx-new-vdecl sym 'type type)
             (nx-bad-decls decl))))
        ((1)
         (nx-bad-decls decl) ;; <<
         (dolist (sym (cdr spec))
           (unless (symbolp sym)
             (nx-bad-decls decl))))
        ((2)
         (nx-bad-decls decl))))))

(defnxdecl %noforcestk (decl env)
  (declare (ignore env))
  (declare (ignore decl))
  (when *nx-parsing-lambda-decls*
    (setq *nx2-noforcestk* t)))

(defnxdecl global-function-name (decl env)
  (when *nx-parsing-lambda-decls*
    (let ((name (cadr decl)))
      (setq *nx-global-function-name* (setf (afunc-name *nx-current-function*) name))
      (setq *nx-inlined-self* (not (nx-declared-notinline-p name env))))))

(defnxdecl debugging-function-name (decl env)
  (declare (ignore env))
  (when *nx-parsing-lambda-decls*
    (setf (afunc-name *nx-current-function*) (cadr decl))))

(defnxdecl resident (decl env)
  (declare (ignore env))
  (declare (ignore decl))
  (nx-decl-set-fbit $fbitresident))


(defun nx-inline-decl (decl val &aux valid-name)
  (dolist (s (%cdr decl))
    (multiple-value-setq (valid-name s) (valid-function-name-p s))
    (if valid-name
      (progn
        (if (nx-self-call-p s nil t)
          (setq *nx-inlined-self* val))
        (nx-new-fdecl s 'inline (if val 'inline 'notinline)))
      (nx-bad-decls decl))))

(defnxdecl inline (decl env)
  (declare (ignore env))
  (nx-inline-decl decl t))

(defnxdecl notinline (decl env)
  (declare (ignore env))
  (nx-inline-decl decl nil))

(defnxdecl ignore (decl env)
  (declare (ignore env))
  (dolist (s (%cdr decl))
    (if (symbolp s) 
      (nx-new-vdecl s 'ignore t)
      (nx-bad-decls decl))))

(defnxdecl ignore-if-unused (decl env)
  (declare (ignore env))
  (dolist (s (%cdr decl))
    (if (symbolp s) 
      (nx-new-vdecl s 'ignore-if-unused)
      (nx-bad-decls decl))))

(defun nx-self-call-p (name &optional ignore-lexical (allow *nx-inlined-self*))
  (when (and name (symbolp name))
    (let ((current-afunc *nx-current-function*)
          (target-afunc (unless ignore-lexical (nth-value 1 (nx-lexical-finfo name)))))
      (or (eq current-afunc target-afunc)
          (and allow
               (eq name *nx-global-function-name*)
               (null target-afunc)
               (null (afunc-parent current-afunc)))))))

(defun nx-check-var-usage (var)
  (let* ((sym (var-name var))
         (bits (nx-var-bits var))
         (expansion (var-ea var))
         (setqed (%ilogbitp $vbitsetq bits))
         (reffed (%ilogbitp $vbitreffed bits))
         (closed (%ilogbitp $vbitclosed bits))
         (special (%ilogbitp $vbitspecial bits))
         (ignored (%ilogbitp $vbitignore bits))
         (ignoreunused (%ilogbitp $vbitignoreunused bits)))
    (if (or special reffed closed)
      (progn
        (if ignored (nx1-whine :ignore sym))
        (nx-set-var-bits var (%ilogand (nx-check-downward-vcell var bits) (%ilognot (%ilsl $vbitignore 1)))))
      (progn
        (if (and setqed ignored) (nx1-whine :ignore sym))
        (or ignored ignoreunused 
            (progn (and (consp expansion) (eq (car expansion) :symbol-macro) (setq sym (list :symbol-macro sym))) (nx1-whine :unused sym)))
        (when (%izerop (%ilogand bits (%ilogior $vrefmask $vsetqmask)))
          (nx-set-var-bits var (%ilogior (%ilsl $vbitignore 1) bits)))))))

; if an inherited var isn't setqed, it gets no vcell.  If it -is- setqed, but
; all inheritors are downward, the vcell can be stack-consed.  Set a bit so that
; the right thing happens when the var is bound.
; Set the bit for the next-method var even if it is not setqed.
(defun nx-check-downward-vcell (v bits)
  (if (and (%ilogbitp $vbitclosed bits)
           (or (%ilogbitp $vbitsetq bits)
               (eq v *nx-next-method-var*))
           (nx-afuncs-downward-p v (afunc-inner-functions *nx-current-function*)))
    (%ilogior (%ilsl $vbitcloseddownward 1) bits)
    bits))

; afunc is "downward wrt v" if it doesn't inherit v or if all refs to afunc
; are "downward" and no inner function of afunc is not downward with respect to v.
(defun nx-afunc-downward-p (v afunc)
  (or (dolist (i (afunc-inherited-vars afunc) t)
        (when (eq (nx-root-var i) v) (return nil)))
      (if (nx-afuncs-downward-p v (afunc-inner-functions afunc))
        (eq (afunc-fn-refcount afunc)
            (afunc-fn-downward-refcount afunc)))))

(defun nx-afuncs-downward-p (v afuncs)
  (dolist (afunc afuncs t)
    (unless (nx-afunc-downward-p v afunc) (return nil))))

(defun nx1-punt-bindings (vars initforms)
  (dolist (v vars)
    (nx1-punt-var v (pop initforms))))

; at the beginning of a binding construct, note which lexical variables are bound to other
; variables and the number of setqs done so far on the initform.
; After executing the body, if neither variable has been closed over,
; the new variable hasn't been setq'ed, and the old guy wasn't setq'ed
; in the body, the binding can be punted.
(defun nx1-note-var-bindings (vars initforms &aux alist)
  (dolist (var vars alist)
    (let* ((binding (nx1-note-var-binding var (pop initforms))))
      (if binding (%temp-push binding alist)))))

(defun nx1-note-var-binding (var initform)
  (let* ((init (nx-untyped-form initform))
         (inittype (nx-acode-form-type initform *nx-lexical-environment*))
         (bits (nx-var-bits var)))
    (when inittype (setf (var-inittype var) inittype))
    (when (and (not (%ilogbitp $vbitspecial bits))
               (consp init))
      (let* ((op (acode-operator init)))
        (if (eq op (%nx1-operator lexical-reference))
          (let* ((target (%cadr init))
                 (setq-count (%ilsr 8 (%ilogand $vsetqmask (nx-var-bits target)))))
            (unless (eq setq-count (%ilsr 8 $vsetqmask))
              (%temp-cons var (%temp-cons setq-count target))))
          (if (and (%ilogbitp $vbitdynamicextent bits)
                   (or (eq op (%nx1-operator closed-function))
                       (eq op (%nx1-operator simple-function))))
            (let* ((afunc (%cadr init)))
              (setf (afunc-fn-downward-refcount afunc)
                    (afunc-fn-refcount afunc)
                    (afunc-bits afunc) (logior (ash 1 $fbitdownward) (ash 1 $fbitbounddownward)
                                               (the fixnum (afunc-bits afunc))))
              nil)))))))
                      
(defun nx1-check-var-bindings (alist)
  (dolist (pair alist)
    (let* ((var (car pair))
           (target (cddr pair))
           (vbits (nx-var-bits var))
           (target-bits (nx-var-bits target)))
      (unless (or
               ; var can't be setq'ed or closed; target can't be setq'ed AND closed.
               (neq (%ilogand vbits (%ilogior (%ilsl $vbitsetq 1) (%ilsl $vbitclosed 1))) 0)
               (eq (%ilogior (%ilsl $vbitsetq 1) (%ilsl $vbitclosed 1)) 
                   (%ilogand
                     (%ilogior (%ilsl $vbitsetq 1) (%ilsl $vbitclosed 1))
                     target-bits))
               (neq (%ilsr 8 (%ilogand $vsetqmask target-bits)) (cadr pair)))
             (%temp-push (%temp-cons var target) *nx-punted-vars*)))))

(defun nx1-punt-var (var initform)
  (let* ((bits (nx-var-bits var))
         (mask (%ilogior (%ilsl $vbitsetq 1)
                 #+ignore (ash -1 $vbitspecial) #-ignore (%ilsl $vbitspecial 1)
                 (%ilsl $vbitclosed 1)))
         ;(count (%i+ (%ilogand $vrefmask bits) (%ilsr 8 (%ilogand $vsetqmask bits))))
         (nrefs (%ilogand $vrefmask bits))
         (val (nx-untyped-form initform))
         (op (if (acode-p val) (acode-operator val))))
    (when (%izerop (%ilogand mask bits))
      (if
        (or 
         ;(%izerop count)  ; unreferenced vars can still have side effects
         (nx-t val)
         (nx-null val)
         (and (eql nrefs 1) (#-ppc-target nx2-absolute-ptr-p #+ppc-target ppc2-absolute-ptr-p val t))
         (eq op (%nx1-operator fixnum))
         (eq op (%nx1-operator immediate)))
        (nx-set-var-bits var (%ilogior (%ilsl $vbitpuntable 1) bits))))
    (when (and (%ilogbitp $vbitdynamicextent bits)
               (or (eq op (%nx1-operator closed-function))
                   (eq op (%nx1-operator simple-function))))
      (let* ((afunc (cadr val)))
        (setf (afunc-bits afunc) (%ilogior (%ilsl $fbitbounddownward 1) (afunc-bits afunc))
              (afunc-fn-downward-refcount afunc) 1))) 
    nil))
            
(defnxdecl optimize (specs env)
  (declare (ignore env))
  (let* ((q nil)
         (v nil)
         (mdecls *nx-new-mdecls*))
    (dolist (spec (%cdr specs) (setq *nx-new-mdecls* mdecls))
      (if (atom spec)
        (setq q spec v 3)
        (setq q (%car spec) v (cadr spec)))
      (if (and (fixnump v) (<= 0 v 3) (memq q '(speed space compilation-speed safety debug)))
        (%temp-push (%temp-cons q v) mdecls)
        (nx-bad-decls specs)))))

(defun %proclaim-optimize (specs &aux q v)
 (dolist (spec specs)
  (if (atom spec)
   (setq q spec v 3)
   (setq q (%car spec) v (cadr spec)))
  (when (and (fixnump v) (<= 0 v 3))
   (if (eq q 'speed)
    (setq *nx-speed* v)
    (if (eq q 'space)
     (setq *nx-space* v)
     (if (eq q 'compilation-speed)
      (setq *nx-cspeed* v)
      (if (eq q 'safety)
       (setq *nx-safety* v)
       (if (eq q 'debug)
         (setq *nx-debug* v)))))))))

(defun nx-lexical-finfo (sym &optional (env *nx-lexical-environment*))
  (let* ((info nil)
         (barrier-crossed nil))
    (if env
      (loop
        (when (eq 'barrier (lexenv.variables env))
          (setq barrier-crossed t))
        (when (setq info (%cdr (assq sym (lexenv.functions env))))
          (return (values info (if (and (eq (car info) 'function)
                                        (consp (%cdr info)))
                                 (progn
                                   (when barrier-crossed
                                     (nx-error "Illegal reference to lexically-defined function ~S." sym))
                                   (%cadr info))))))
        (if (listp (setq env (lexenv.parent-env env)))
          (return (values nil nil))))
      (values nil nil))))

#|
(defun nx-inline-expansion (sym &optional (env *nx-lexical-environment*) global-only)
  (let* ((lambda-form nil)
         (containing-env nil)
         (token nil))
    (if (and (nx-declared-inline-p sym env)
             (not (gethash sym *nx1-alphatizers*)))
      (multiple-value-bind (info afunc) (unless global-only (nx-lexical-finfo sym env))
        (if info (setq token afunc 
                       containing-env (afunc-environment afunc)
                       lambda-form (afunc-lambdaform afunc)))
        (let* ((defenv (definition-environment env)))
          (if (cdr (setq info (if defenv (cdr (assq sym (defenv.defined defenv))))))
            (setq lambda-form (cdr info)
                  token sym
                  containing-env (nx-new-lexical-environment defenv))
            (unless info
              (setq info (assq sym *nx-globally-inline*))
              (if (cdr (setq info (assq sym *nx-globally-inline*)))
                (setq lambda-form (%cdr info)
                      token sym
                      containing-env (new-lexical-environment (new-definition-environment nil)))))))))
    (values lambda-form (nx-closed-environment env containing-env) token)))
|#

(defun nx-inline-expansion (sym &optional (env *nx-lexical-environment*) global-only)
  (let* ((lambda-form nil)
         (containing-env nil)
         (token nil))
    (if (and (nx-declared-inline-p sym env)
             (not (gethash sym *nx1-alphatizers*)))
      (multiple-value-bind (info afunc) (unless global-only (nx-lexical-finfo sym env))
        (if info (setq token afunc
                       containing-env (afunc-environment afunc)
                       lambda-form (afunc-lambdaform afunc)))
        (let* ((defenv (definition-environment env))
               (definfo (if defenv (cdr (assq sym (defenv.defined defenv))))))
          (if (cdr definfo)
            (setq lambda-form (cdr definfo)
                  token sym
                  containing-env (nx-new-lexical-environment defenv))
            (unless info
              ;(setq info (assq sym *nx-globally-inline*))
              (if (cdr (setq info (assq sym *nx-globally-inline*)))  ;; assq twice is silly
                (setq lambda-form (%cdr info)
                      token sym
                      containing-env (new-lexical-environment (new-definition-environment nil)))))))))
    (values lambda-form (nx-closed-environment env containing-env) token)))

(defun nx-closed-environment (current-env target)
  (when target
    (let* ((intervening-functions nil))
      (do* ((env current-env (lexenv.parent-env env)))
           ((or (eq env target) (null env) (eq (%svref env 0) 'definition-environment)))
        (let* ((fn (lexenv.lambda env)))
          (when fn (push fn intervening-functions))))
      (let* ((result target))
        (dolist (fn intervening-functions result)
          (setf (lexenv.lambda (setq result (nx-new-lexical-environment result))) fn))))))

(defun nx-root-var (v)
  (do* ((v v bits)
        (bits (var-bits v) (var-bits v)))
       ((fixnump bits) v)))

(defun nx-reconcile-inherited-vars (more)
  (let ((last nil)) ; Bop 'til ya drop.
    (loop
      (setq last more more nil)
      (dolist (callee last)
        (dolist (caller (afunc-callers callee))
          (unless (or (eq caller callee)
                      (eq caller (afunc-parent callee)))
            (dolist (v (afunc-inherited-vars callee))
              (let ((root-v (nx-root-var v)))
                (unless (dolist (caller-v (afunc-inherited-vars caller))
                          (when (eq root-v (nx-root-var caller-v))
                            (return t)))
                  ; caller must inherit root-v in order to call callee without using closure.
                  ; can't just bind afunc & call nx-lex-info here, 'cause caller may have
                  ; already shadowed another var with same name.  So:
                  ; 1) find the ancestor of callee which bound v; this afunc is also an ancestor
                  ;    of caller
                  ; 2) ensure that each afunc on the inheritance path from caller to this common
                  ;    ancestor inherits root-v.
                  (let ((ancestor (afunc-parent callee))
                        (inheritors (list caller)))
                    (until (eq (setq v (var-bits v)) root-v)
                      (setq ancestor (afunc-parent ancestor)))
                    (do* ((p (afunc-parent caller) (afunc-parent p)))
                         ((eq p ancestor))
                      (push p inheritors))
                    (dolist (f inheritors)
                      (setq v (nx-cons-var (var-name v) v))
                      (unless (dolist (i (afunc-inherited-vars f))
                                (when (eq root-v (nx-root-var i))
                                  (return (setq v i))))
                        (pushnew f more)
                        (push v (afunc-inherited-vars f))
                        ; change shared structure of all refs in acode with one swell foop.
                        (nx1-afunc-ref f))))))))))    
      (unless more (return)))))

(defun nx-inherit-var (var binder current)
  (if (eq binder current)
    (progn
      (nx-set-var-bits var (%ilogior2 (%ilsl $vbitclosed 1) (nx-var-bits var)))
      var)
    (let ((sym (var-name var)))
      (or (dolist (already (afunc-inherited-vars current))
            (when (eq sym (var-name already)) (return already)))
          (progn
            (setq var (nx-cons-var sym (nx-inherit-var var binder (afunc-parent current))))
            (push var (afunc-inherited-vars current))
            var)))))

(defun nx-lex-info (sym &optional current-only)
  (let* ((current-function *nx-current-function*)
         (catch nil)
         (barrier-crossed nil))
    (multiple-value-bind 
      (info afunc)
      (do* ((env *nx-lexical-environment* (lexenv.parent-env env))
            (continue env (and env (neq (%svref env 0) 'definition-environment)))
            (binder current-function (or (if continue (lexenv.lambda env)) binder)))
           ((or (not continue) (and (neq binder current-function) current-only)) 
            (values nil nil))
        (let ((vars (lexenv.variables env)))
          (if (eq vars 'catch) 
            (setq catch t)
            (if (eq vars 'barrier)
              (setq barrier-crossed t)
              (let ((v (dolist (var vars)
                         (when (eq (var-name var) sym) (return var)))))
                (when v (return (values v binder)))
                (dolist (decl (lexenv.vdecls env))
                  (when (and (eq (car decl) sym)
                             (eq (cadr decl) 'special))
                    (return-from nx-lex-info (values :special nil nil)))))))))
      (if info
        (if (var-expansion info)
          (values :symbol-macro (cdr (var-expansion info)) info)
          (if (%ilogbitp $vbitspecial (nx-var-bits info))
            (values :special info nil)
            (if barrier-crossed
              (nx-error "Illegal reference to lexically defined variable ~S." sym)
              (if (eq afunc current-function)
                (values info nil catch)
                (values (nx-inherit-var info afunc current-function) t catch)))))
        (values nil nil nil)))))


(defun nx-block-info (blockname &optional (afunc *nx-current-function*) &aux
  blocks
  parent
  (toplevel (eq afunc *nx-current-function*))
  blockinfo)
 (when afunc
  (setq
   blocks (if toplevel *nx-blocks* (afunc-blocks afunc))
   blockinfo (assq blockname blocks)
   parent (afunc-parent afunc))
  (if blockinfo
   (values blockinfo nil)
   (when parent
    (when (setq blockinfo (nx-block-info blockname parent))
     (values blockinfo t))))))

(defun nx-tag-info (tagname &optional (afunc *nx-current-function*) &aux
                            tags
                            parent
                            index
                            counter
                            (toplevel (eq afunc *nx-current-function*))
                            taginfo)
  (when afunc
    (setq
     tags (if toplevel *nx-tags* (afunc-tags afunc))
     taginfo (assoc tagname tags)
     parent (afunc-parent afunc))
    (if taginfo
      (values taginfo nil)
      (when (and parent (setq taginfo (nx-tag-info tagname parent)))
        (unless (setq index (cadr taginfo))
          (setq counter (caddr taginfo))
          (%rplaca counter (%i+ (%car counter) 1))
          (setq index (%car counter))
          (%rplaca (%cdr taginfo) index))
        (values taginfo index)))))

(defun nx1-transitively-punt-bindings (pairs) 
  (dolist (pair (nreverse pairs))
    (let* ((var         (%car pair))
           (boundto     (%cdr pair))
           (varbits     (nx-var-bits var))
           (boundtobits (nx-var-bits boundto)))
      (declare (fixnum varbits boundtobits))

      (unless (eq (%ilogior
                    (%ilsl $vbitsetq 1)
                    (%ilsl $vbitclosed 1))
                  (%ilogand
                    (%ilogior
                      (%ilsl $vbitsetq 1)
                      (%ilsl $vbitclosed 1))
                    boundtobits))
        ; Can't happen -
        (unless (%izerop (%ilogand (%ilogior
                                     (%ilsl $vbitsetq 1) 
                                     #+ignore (ash -1 $vbitspecial)
                                     #-ignore (%ilsl $vbitspecial 1)
                                     (%ilsl $vbitclosed 1)) varbits))
          (error "Bug-o-rama - \"punted\" var had bogus bits. ~ 
Or something. Right? ~s ~s" var varbits))
        (let* ((varcount     (%ilogand $vrefmask varbits)) 
               (boundtocount (%ilogand $vrefmask boundtobits)))
          (nx-set-var-bits var (%ilogior
                                 (%ilsl $vbitpuntable 1)
                                 (%i- varbits varcount)))
              (nx-set-var-bits
               boundto
               (%ilogior (%ilogand
                           (ash 1 $vbitareg)
                           (%ilogior varbits boundtobits))
                 (%i+ (%i- boundtobits boundtocount)
                      (%ilogand $vrefmask
                        (%i+ (%i- boundtocount 1) varcount))))))))))

(defun nx1-compile-lambda (name lambda-form &optional
                                 (p (make-afunc))
                                 q
                                 parent-env
                                 (policy *default-compiler-policy*)
                                 load-time-eval-token)
  (if q
     (setf (afunc-parent p) q))
  (setf (afunc-name p) name)
  (unless (lambda-expression-p lambda-form)
    (nx-error "~S is not a valid lambda expression." lambda-form))
  (let* ((*nx-current-function* p)
         (*nx-parent-function* q)
         (*nx-lexical-environment* (nx-new-lexical-environment parent-env))
         (*nx-load-time-eval-token* load-time-eval-token)
         (*nx-all-vars* nil)
         (*nx-bound-vars* nil)
         (*nx-punted-vars* nil)
         (*nx-current-compiler-policy* policy)
         (*nx-blocks* nil)
         (*nx-tags* nil)
         (*nx-inner-functions* nil)
         (*nx-global-function-name* nil)
         (*nx-warnings* nil)
         (*nx1-fcells* nil)
         (*nx1-vcells* nil)
         (*nx-nlexit-count* 0)
         (*nx-inline-expansions* nil)
         (*nx-event-checking-call-count* 0)
         (*nx-parsing-lambda-decls* nil)
         (*nx-next-method-var* (if q *nx-next-method-var*))
         (*nx-call-next-method-function* (if q *nx-call-next-method-function*))
         (*nx-cur-func-name* (or (and (method-lambda-p lambda-form) *nx-method-warning-name*)
                                name)))
    (if (%non-empty-environment-p *nx-lexical-environment*)
      (setf (afunc-bits p) (logior (ash 1 $fbitnonnullenv) (the fixnum (afunc-bits p)))))
    (multiple-value-bind (body decls)
                         (parse-body (%cddr lambda-form) *nx-lexical-environment* t)
      (setf (afunc-lambdaform p) lambda-form)
      (setf (afunc-acode p) (nx1-lambda (%cadr lambda-form) body decls))
      (nx1-transitively-punt-bindings *nx-punted-vars*)
      (setf (afunc-blocks p) *nx-blocks*)
      (setf (afunc-tags p) *nx-tags*)
      (setf (afunc-inner-functions p) *nx-inner-functions*)
      (setf (afunc-all-vars p) *nx-all-vars*)
      (setf (afunc-vcells p) *nx1-vcells*)
      (setf (afunc-fcells p) *nx1-fcells*)
      (let* ((warnings (merge-compiler-warnings *nx-warnings*))
             (name *nx-cur-func-name*))        
        (dolist (inner *nx-inner-functions*)
          (dolist (w (afunc-warnings inner))
            (push name (compiler-warning-function-name w))
            (push w warnings)))
        (setf (afunc-warnings p) warnings))
      p)))

(defun method-lambda-p (form)
  (and (consp form)
       (consp (setq form (%cdr form)))       
       (eq (caar form) '&method)))
         





(defun nx1-lambda (ll body decls &aux (l ll) methvar)
  (let ((old-env *nx-lexical-environment*)
        (*nx-bound-vars* *nx-bound-vars*))
    (with-declarations
      (let* ((*nx-parsing-lambda-decls* t))
        (nx-process-declarations decls))
      (when (eq (car l) '&lap)
        (let ((bits nil))
          (unless (and (eq (length (%cdr l)) 1) (fixnump (setq bits (%cadr l))))
            (unless (setq bits (encode-lambda-list (%cdr l)))
              (nx-error "invalid lambda-list  - ~s" l)))
          (return-from nx1-lambda
                       (%temp-list
                        (%nx1-operator lambda-list)
                        (%temp-list (%temp-cons '&lap bits))
                        nil
                        nil
                        nil
                        nil
                        (nx1-env-body body old-env)
                        *nx-new-p2decls*))))
      (when (eq (car l) '&method)
        (setf (afunc-bits *nx-current-function*)
              (%ilogior (%ilsl $fbitmethodp 1)
                        (afunc-bits *nx-current-function*)))
        (setq *nx-inlined-self* nil)
        (setq *nx-next-method-var* (setq methvar (let ((var (nx-new-var (%cadr ll))))
                                                   (nx-set-var-bits var (%ilogior 
                                                                          (%ilsl $vbitignoreunused 1) 
                                                                          ;(%ilsl $vbitnoreg 1) 
                                                                          (nx-var-bits var)))
                                                   var)))
                                                   
        (setq ll (%cddr ll)))
      (multiple-value-bind (req opt rest keys auxen lexpr)
                           (nx-parse-simple-lambda-list ll)
        (nx-effect-other-decls *nx-lexical-environment*)
        (setq body (nx1-env-body body old-env))
        (nx1-punt-bindings (%car auxen) (%cdr auxen))          
        (when methvar
          (%temp-push methvar req)
          (unless (eq 0 (%ilogand (%ilogior (%ilsl $vbitreffed 1)
                                            (%ilsl $vbitclosed 1)
                                            (%ilsl $vbitsetq 1))
                                  (nx-var-bits methvar)))
            (setf (afunc-bits *nx-current-function*)
                  (%ilogior 
                   (%ilsl $fbitnextmethp 1)
                   (afunc-bits *nx-current-function*)))))
        (make-acode
         (%nx1-operator lambda-list) 
         req
         opt 
         (if lexpr (list rest) rest)
         keys
         auxen
         body
         *nx-new-p2decls*)))))
  
(defun nx-parse-simple-lambda-list (ll &aux
                                       req
                                       opt
                                       rest
                                       keys
                                       lexpr
                                       sym)
  (multiple-value-bind (ok reqsyms opttail resttail keytail auxtail)
                       (verify-lambda-list ll)
    (unless ok (nx-error "Bad lambda list : ~S" ll))
    (dolist (var reqsyms)
      (%temp-push (nx-new-var var t) req))
    (when (eq (pop opttail) '&optional)
      (let* (optvars optinits optsuppliedp)
        (until (eq opttail resttail) 
          (setq sym (pop opttail))
          (let* ((var sym)
                 (initform nil)
                 (spvar nil))
            (when (consp var)
              (setq sym (pop var) initform (pop var) spvar (%car var)))
            (%temp-push (nx1-typed-var-initform sym initform) optinits)
            (%temp-push (nx-new-var sym t) optvars)
            (%temp-push (if spvar (nx-new-var spvar t)) optsuppliedp)))
        (if optvars
          (setq opt (%temp-list (nreverse optvars) (nreverse optinits) (nreverse optsuppliedp)))
          (nx1-whine :lambda ll))))
    (let ((temp (pop resttail)))
      (when (or (eq temp '&rest)
                (setq lexpr (eq temp '&lexpr)))
        (setq rest (nx-new-var (%car resttail) t))))
    (when (eq (%car keytail) '&key) 
      (setq keytail (%cdr keytail))
      (let* ((keysyms ())
             (keykeys ())
             (keyinits ())
             (keysupp ())
             (kallowother (not (null (memq '&allow-other-keys ll))))
             (kvar ())
             (kkey ())
             (kinit ())
             (ksupp))
        (until (eq keytail auxtail)
          (unless (eq (setq sym (pop keytail)) '&allow-other-keys)      
            (setq kinit *nx-nil* ksupp nil)
            (if (atom sym)
              (setq kvar sym kkey (make-keyword sym))
              (progn
                (if (consp (%car sym))
                  (setq kkey (%caar sym) kvar (%cadar sym))
                  (progn
                    (setq kvar (%car sym))
                    (setq kkey (make-keyword kvar))))
                (setq kinit (nx1-typed-var-initform kvar (%cadr sym)))
                (setq ksupp (%caddr sym))))
            (%temp-push (nx-new-var kvar t) keysyms)
            (%temp-push kkey keykeys)
            (%temp-push kinit keyinits)
            (%temp-push (if ksupp (nx-new-var ksupp t)) keysupp)))
        (setq 
         keys
         (%temp-list
          kallowother
          (nreverse keysyms)
          (nreverse keysupp)
          (nreverse keyinits)
          (apply #'vector (nreverse keykeys))))))
    (let (auxvals auxvars)
      (dolist (pair (%cdr auxtail))
        (let* ((auxvar (nx-pair-name pair))
               (auxval (nx1-typed-var-initform auxvar (nx-pair-initform pair))))
          (%temp-push auxval auxvals)
          (%temp-push (nx-new-var auxvar t) auxvars)))
      (values
       (nreverse req) 
       opt 
       rest
       keys
       (%temp-list (nreverse auxvars) (nreverse auxvals))
       lexpr))))

(defun nx-new-structured-var (sym)
  (if sym
    (nx-new-var sym t)
    (nx-new-temp-var)))

(defun nx-parse-structured-lambda-list (ll &optional no-acode whole-p &aux
                                           req
                                           opt
                                           rest
                                           keys
                                           sym)
  (multiple-value-bind (ok reqsyms opttail resttail keytail auxtail all whole structured-p)
                       (verify-lambda-list ll t whole-p nil)
    (declare (ignore all))
    (unless ok (nx-error "Bad lambda list : ~S" ll))
    (if (or whole (and whole-p structured-p)) (setq whole (nx-new-structured-var whole)))
    (dolist (var reqsyms)
      (%temp-push (if (symbolp var)
                    (nx-new-structured-var var)
                    (nx-structured-lambda-form var no-acode))
                  req))
    (when (eq (pop opttail) '&optional)
      (let* (optvars optinits optsuppliedp)
        (until (eq opttail resttail) 
          (setq sym (pop opttail))
          (let* ((var sym)
                 (initform nil)
                 (spvar nil))
            (when (consp var)
              (setq sym (pop var) initform (pop var) spvar (%car var)))
            (%temp-push (if no-acode initform (nx1-form initform)) optinits)
            (%temp-push (if (symbolp sym)
                          (nx-new-structured-var sym)
                          (nx-structured-lambda-form sym no-acode))
                        optvars)
            (%temp-push (if spvar (nx-new-var spvar)) optsuppliedp)))
        (if optvars
          (setq opt (list (nreverse optvars) (nreverse optinits) (nreverse optsuppliedp)))
          (nx1-whine :lambda ll))))
    (let ((var (pop resttail)))
      (when (or (eq var '&rest)
                (eq var '&body))
        (setq var (pop resttail)
              rest (if (symbolp var)
                     (nx-new-structured-var var)
                     (nx-structured-lambda-form var no-acode)))))
    (when (eq (%car keytail) '&key) 
      (setq keytail (%cdr keytail))
      (let* ((keysyms ())
             (keykeys ())
             (keyinits ())
             (keysupp ())
             (kallowother (not (null (memq '&allow-other-keys ll))))
             (kvar ())
             (kkey ())
             (kinit ())
             (ksupp))
        (until (eq keytail auxtail)
          (unless (eq (setq sym (pop keytail)) '&allow-other-keys)      
            (setq kinit *nx-nil* ksupp nil)
            (if (atom sym)
              (setq kvar sym kkey (make-keyword sym))
              (progn
                (if (consp (%car sym))
                  (setq kkey (%caar sym) kvar (%cadar sym))
                  (progn
                    (setq kvar (%car sym))
                    (setq kkey (make-keyword kvar))))
                (setq kinit (if no-acode (%cadr sym) (nx1-form (%cadr sym))))
                (setq ksupp (%caddr sym))))
            (%temp-push (if (symbolp kvar)
                          (nx-new-structured-var kvar)
                          (nx-structured-lambda-form kvar no-acode))
                        keysyms)
            (%temp-push kkey keykeys)
            (%temp-push kinit keyinits)
            (%temp-push (if ksupp (nx-new-var ksupp)) keysupp)))
        (setq 
         keys
         (%temp-list
          kallowother
          (nreverse keysyms)
          (nreverse keysupp)
          (nreverse keyinits)
          (apply #'vector (nreverse keykeys))))))
    (let (auxvals auxvars)
      (dolist (pair (%cdr auxtail))
        (let ((auxvar (nx-pair-name pair))
              (auxval (nx-pair-initform pair)))
          (%temp-push (if no-acode auxval (nx1-form auxval)) auxvals)
          (%temp-push (nx-new-var auxvar) auxvars)))
      (values
       (nreverse req) 
       opt 
       rest 
       keys
       (%temp-list (nreverse auxvars) (nreverse auxvals))
       whole))))

(defun nx-structured-lambda-form (l &optional no-acode)
  (multiple-value-bind (req opt rest keys auxen whole)
                       (nx-parse-structured-lambda-list l no-acode t)
    (%temp-list (%nx1-operator lambda-list) whole req opt rest keys auxen)))

#|
(defun nx1-form (form &optional (*nx-lexical-environment* *nx-lexical-environment*))
  (let* ((*nx-form-type* t))
    (when (and (consp form)(eq (car form) 'the))
      (setq *nx-form-type* (cadr form)))
    (prog1
      (nx1-typed-form form *nx-lexical-environment*))))
|#

(defun nx1-form (form &optional (*nx-lexical-environment* *nx-lexical-environment*))
  (let* ((*nx-form-type* t))
    (when (and (consp form)(eq (car form) 'the))
      (setq *nx-form-type* (cadr form)))
    (when (symbolp form)
      (let ((info (nx-lex-info form)))
        (when  (not info)
          (let ((global-symbol-macro (find-compile-time-or-global-symbol-macro form)))
            (when global-symbol-macro
               (return-from nx1-form (nx1-form (cdr (var-ea global-symbol-macro)))))))))
    (nx1-typed-form form *nx-lexical-environment*)))

(defun nx1-typed-form (original env)
  (nx1-transformed-form (nx-transform original env) env))

(defun nx1-transformed-form (form &optional (env *nx-lexical-environment*))
  (if (consp form)
    (nx1-combination form env)
    (let* ((symbolp (non-nil-symbol-p form))
           (constant-value (unless symbolp form))
           (constant-symbol-p nil))
      (if symbolp 
        (multiple-value-setq (constant-value constant-symbol-p) 
          (nx-transform-defined-constant form env)))
      (if (and symbolp (not constant-symbol-p))
        (nx1-symbol form env)
        (nx1-immediate (nx-unquote constant-value))))))

#-ppc-target
(defun nx1-prefer-areg (form env)
  (let* ((var (nx2-lexical-reference-p (setq form (nx1-form form env)))))
    (if var (nx-set-var-bits var (logior (ash 1 $vbitareg) (nx-var-bits var))))
    form))

#+ppc-target
(defun nx1-prefer-areg (form env)
  (nx1-form form env))


(defun nx1-immediate (form)
  (if (or (eq form t) (null form))
    (nx1-sysnode form)
    (make-acode 
     (if (fixnump form) 
       (%nx1-operator fixnum)
       (if #-ppc-target (short-float-p form) #+ppc-target nil
         (%nx1-operator short-float)
         (%nx1-operator immediate)))   ; Screw: chars
     form)))

(defun nx-constant-form-p (form)
  (setq form (nx-untyped-form form))
  (if form
    (or (nx-null form)
        (nx-t form)
        (and (consp form)
             (or (eq (acode-operator form) (%nx1-operator immediate))
                 (eq (acode-operator form) (%nx1-operator fixnum))
                 (eq (acode-operator form) (%nx1-operator simple-function)))))))

;; Reference-count vcell, fcell refs.
(defun nx1-note-vcell-ref (sym)
  (let ((there (assq sym *nx1-vcells*)))
    (if there
      (%rplacd there (%i+ (%cdr there) 1))
      (%temp-push (%temp-cons sym 1) *nx1-vcells*)))
  sym)

(defun nx1-note-fcell-ref (sym)
  (let ((there (assq sym *nx1-fcells*)))
    (if there
      (%rplacd there (%i+ (%cdr there) 1))
      (%temp-push (%temp-cons sym 1) *nx1-fcells*))
    sym))

; Note that "simple lexical refs" may not be; that's the whole problem ...
(defun nx1-symbol (form &optional (env *nx-lexical-environment*))
  (let* ((type (nx-declared-type form))
         (form
          (multiple-value-bind (info inherited-p more)
                               (nx-lex-info form)
            (if (and info (neq info :special))
              (if (eq info :symbol-macro)
                (progn
                  (nx-set-var-bits more (%ilogior (%ilsl $vbitreffed 1) (nx-var-bits more)))
                  (if (eq type t)
                    (nx1-form inherited-p)
                    (nx1-form `(the ,(prog1 type (setq type t)) ,inherited-p))))
                (progn
                  (when (not inherited-p)
                    (nx-set-var-bits info (%ilogior2 (%ilsl $vbitreffed 1) (nx-var-bits info)))
                    (nx-adjust-ref-count info))
                  (make-acode (%nx1-operator lexical-reference) info)))
              (make-acode
               (if (nx1-check-special-ref form info)
                 (if (and (not (nx-force-boundp-checks form env))
                          (or (nx-proclaimed-parameter-p form)
                              (assq form *nx-compile-time-types*)
                              (assq form *nx-proclaimed-types*)
                              (nx-open-code-in-line env)))
                   (%nx1-operator bound-special-ref)
                   (%nx1-operator special-ref))
                 (%nx1-operator free-reference))
               (nx1-note-vcell-ref form))))))
          (if (eq type t)
            form
            (make-acode (%nx1-operator typed-form) type form))))

(defun nx1-check-special-ref (form auxinfo)
  (or (eq auxinfo :special) 
      (nx-proclaimed-special-p form)
      (let ((defenv (definition-environment *nx-lexical-environment*)))
        (unless (and defenv (eq (car (defenv.type defenv)) :execute) (boundp form))
          (nx1-whine :special form))
        nil)))

(defparameter *ppc-functions-not-on-68k*
  '(%aref1 %aset1 %init-misc %negate))

(defun nx1-whine (about &rest forms)
  (unless (and (eq about :undefined-function)
               (ppc-target-p)
               (memq (car forms) *ppc-functions-not-on-68k*))
    (push (make-condition (or (cdr (assq about *compiler-whining-conditions*)) 'compiler-warning)
                          :function-name (list *nx-cur-func-name*)
                          :warning-type about
                          :args (or forms (list nil)))
          *nx-warnings*))
  nil)

(defun nx1-type-intersect (form type1 type2 &optional env)
  (declare (ignore env)) ; use it when deftype records info in env.  Fix this then ...
  (let* ((ctype1 (if (typep type1 'ctype) type1 (specifier-type type1)))
         (ctype2 (if (typep type2 'ctype) type2 (specifier-type type2)))
         (intersection (type-intersection ctype1 ctype2)))
    (if (eq intersection *empty-type*)
      (let ((type1 (if (typep type1 'ctype)
                     (type-specifier type1)
                     type1))
            (type2 (if (typep type2 'ctype)
                     (type-specifier type2)
                     type2)))
        (nx1-whine :type-conflict form type1 type2)))
    (type-specifier intersection)))
                 


(defun nx-declared-notinline-p (sym env)
  (setq sym (maybe-setf-function-name sym))
  (loop
    (when (listp env)
      (return (and (symbolp sym)
                   (proclaimed-notinline-p sym))))
    (dolist (decl (lexenv.fdecls env))
      (when (and (eq (car decl) sym)
                 (eq (cadr decl) 'inline))
         (return-from nx-declared-notinline-p (eq (cddr decl) 'notinline))))
    (setq env (lexenv.parent-env env))))



(defun nx1-combination (form env)
  (destructuring-bind (sym &rest args)
                      form
    (if (symbolp sym)
      (let* ((*nx-sfname* sym) special)
        (if (and (setq special (gethash sym *nx1-alphatizers*))
                 ;(not (nx-lexical-finfo sym env))
                 (not (memq sym *nx1-target-inhibit*))
                 (not (nx-declared-notinline-p sym *nx-lexical-environment*)))
          (funcall special form env) ; pass environment arg ...
          (progn
            (when (memq sym *nx1-target-inhibit*)
              (warn "Wrong platform for call to ~s in ~s ." sym form))
            (nx1-typed-call sym args))))
      (if (lambda-expression-p sym)
        (nx1-lambda-bind (%cadr sym) args (%cddr sym))
      (nx-error "~S is not a symbol or lambda expression in the form ~S ." sym form)))))

(defun nx1-treat-as-call (args)
  (nx1-typed-call (car args) (%cdr args)))

(defun nx1-typed-call (sym args)
  (let ((type (nx1-call-result-type sym args))
        (form (nx1-call sym args)))
    (if (eq type t)
      form
      (list (%nx1-operator typed-form) type form))))

; Wimpy.
(defun nx1-call-result-type (sym &optional (args nil args-p) spread-p)
  (let* ((env *nx-lexical-environment*)
         (global-def nil)
         (lexenv-def nil)
         (defenv-def nil)
         (somedef nil))
    (when (and sym 
               (symbolp sym)
               (not (find-ftype-decl sym env))
               (not (setq lexenv-def (nth-value 1 (nx-lexical-finfo sym))))
               (null (setq defenv-def (retrieve-environment-function-info sym env)))
               (neq sym *nx-global-function-name*)
               (not (functionp (setq global-def (fboundp sym)))))
      (nx1-whine :undefined-function sym))
    (when (and args-p (setq somedef (or lexenv-def defenv-def global-def)))
      (multiple-value-bind (deftype required max minargs maxargs)
                           (nx1-check-call-args somedef args spread-p)
        (when deftype
          (nx1-whine (if (eq deftype :lexical-mismatch) :environment-mismatch deftype)
                     sym required max minargs maxargs))))
    *nx-form-type*))

(defun find-ftype-decl (sym env)
  (setq sym (maybe-setf-function-name sym))
  (loop 
    (when (listp env)
      (return (and (symbolp sym)
                   (proclaimed-ftype sym))))
    (dolist (fdecl (lexenv.fdecls env))
      (declare (list fdecl))
      (when (and (eq (car fdecl) sym)
                 (eq (car (the list (cdr fdecl))) 'ftype))
        (return-from find-ftype-decl (cdr (the list (cdr fdecl))))))
    (setq env (lexenv.parent-env env))))

(defun innermost-lfun-bits-keyvect (def)
 (declare (notinline innermost-lfun-bits-keyvect))
  (let* ((gf-p (standard-generic-function-p def)))
    (unless gf-p
      (let ((inner-def (closure-function (find-unencapsulated-definition def))))
        (values (lfun-bits inner-def)(lfun-keyvect inner-def))))))

(defun innermost-gf-lfun-bits-keyvect (def)  
  (let ((inner-def (closure-function (find-unencapsulated-definition def))))
    (values (lfun-bits inner-def) nil)))


(defun nx1-check-call-args (def arglist spread-p)
          
  (let* ((deftype (if (functionp def) 
                    :global-mismatch
                    (if (istruct-typep def 'afunc)
                      :lexical-mismatch
                      :environment-mismatch)))
         (generic-function-p (standard-generic-function-p def)))
    
    (multiple-value-bind (bits keyvect)
                         (case deftype
                           (:global-mismatch (if generic-function-p
                                               (innermost-gf-lfun-bits-keyvect def) ;; <<
                                               (innermost-lfun-bits-keyvect def)))
                           (:environment-mismatch (values (caadr def) (cdadr def)))
                           (t (let* ((lambda-form (afunc-lambdaform def)))
                                (if (lambda-expression-p lambda-form)
                                  (encode-lambda-list (cadr lambda-form))))))      
      (when bits
        (unless (typep bits 'fixnum) (bug "Bad bits!"))
        (let* ((nargs (length arglist))
               (minargs (if spread-p (1- nargs) nargs))
               (maxargs (if spread-p nil nargs))
               (required (ldb $lfbits-numreq bits))
               (max (if (logtest (logior (ash 1 $lfbits-rest-bit) (ash 1 $lfbits-restv-bit) (ash 1 $lfbits-keys-bit)) bits)
                      nil
                      (+ required (ldb $lfbits-numopt bits)))))
          ;; If the (apparent) number of args in the call doesn't match the definition, complain.
          ;; If "spread-p" is true, we can only be sure of the case when more than the required number of
          ;; args have been supplied.
          (if (or (and (not spread-p) (< minargs required))
                  (and max (or (> minargs max)) (if maxargs (> maxargs max)))
                  (and (not generic-function-p)
                       (nx1-find-bogus-keywords arglist spread-p bits keyvect)))
            (values deftype required max minargs maxargs)))))))

(defun nx1-find-bogus-keywords (args spread-p bits keyvect)
  (declare (fixnum bits))
  (when (logbitp $lfbits-aok-bit bits)
    (setq keyvect nil))                 ; only check for even length tail
  (when (and (logbitp $lfbits-keys-bit bits) 
             (not spread-p))     ; Can't be sure, last argform may contain :allow-other-keys
    (do* ((key-args (nthcdr (+ (ldb $lfbits-numreq bits)  (ldb $lfbits-numopt bits)) args) (cddr key-args)))
         ((null key-args))
      (if (null (cdr key-args))
        (return t)
        (when keyvect
          (let* ((keyword (%car key-args)))
            (unless (constantp keyword)
              (return nil))
            (unless (eq keyword :allow-other-keys)
              (unless (position (nx-unquote keyword) keyvect)
                (return t)))))))))

; On the PPC, we can save some space by going through subprims to call
; "builtin" functions for us.
(defun nx1-builtin-function-offset (name)
  (and (eq *nx1-target-inhibit* *nx1-ppc-target-inhibit*)
       (ppc::builtin-function-name-offset name)))

(defun nx1-call-form (global-name afunc arglist spread-p)
  (if afunc
    (make-acode (%nx1-operator lexical-function-call) afunc (nx1-arglist arglist (if spread-p 1 #+ppc-target $numppcargregs #-ppc-target $numargregs)) spread-p)
    (let* ((builtin (unless spread-p (nx1-builtin-function-offset global-name))))
      (if builtin
        (make-acode (%nx1-operator builtin-call) 
                    (make-acode (%nx1-operator fixnum) builtin)
                    (nx1-arglist arglist))
        (make-acode (%nx1-operator call)
                     (if (symbolp global-name)
                       (nx1-immediate (nx1-note-fcell-ref global-name))
                       global-name)
                     (nx1-arglist arglist (if spread-p 1 #+ppc-target $numppcargregs #-ppc-target $numargregs))
                     spread-p)))))
  
; If "sym" is an expression (not a symbol which names a function), the caller has already
; alphatized it.
(defun nx1-call (sym args &optional spread-p global-only)
  (nx1-verify-length args 0 nil)
  (let ((args-in-regs (if spread-p 1 #+ppc-target $numppcargregs #-ppc-target $numargregs)))
    (if (nx-self-call-p sym global-only)
      ; Should check for downward functions here as well.
      (make-acode (%nx1-operator self-call) (nx1-arglist args args-in-regs) spread-p)
      (multiple-value-bind (lambda-form containing-env token) (nx-inline-expansion sym *nx-lexical-environment* global-only)
        (or (nx1-expand-inline-call lambda-form containing-env token args spread-p)
            (multiple-value-bind (info afunc) (if (and sym (symbolp sym) (not global-only)) (nx-lexical-finfo sym))
              (when (eq 'macro (car info))
                (nx-error "Can't call macro function ~s" sym))
              (if (and afunc (%ilogbitp $fbitruntimedef (afunc-bits afunc)))
                (let ((sym (var-name (afunc-lfun afunc))))
                  (nx1-form 
                   (if spread-p
                     `(,(if (eql spread-p 0) 'applyv 'apply) ,sym ,args)
                     `(funcall ,sym ,@args))))
                (let* ((nlexits *nx-nlexit-count*)
                       (val (nx1-call-form sym afunc args spread-p)))
                    (when afunc
                      (let ((callers (afunc-callers afunc))
                            (self *nx-current-function*))
                        (unless (or (eq self afunc) (memq self callers))
                          (setf (afunc-callers afunc) (%temp-cons self callers)))))
                    (unless (neq nlexits *nx-nlexit-count*)
                      (when (and (not *nx1-without-interrupts*)
                                 (not (nx1-builtin-function-offset sym))) ;(memq sym '(<-2 >-2 <=-2 >=-2 =-2 /=-2)) )
                        ;; builtin subprims may or may not event-check - very often not
                        (setq *nx-event-checking-call-count* (%i+ *nx-event-checking-call-count* 1))))
                    (if (and (null afunc) (memq sym *nx-never-tail-call*))
                      (make-acode (%nx1-operator values) (list val))
                      val)))))))))

(defun nx1-expand-inline-call (lambda-form env token args spread-p)
  (if (and (or (null spread-p) (eq (length args) 1)))
    (if (and token (not (memq token *nx-inline-expansions*)))
      (let* ((*nx-inline-expansions* (cons token *nx-inline-expansions*))
             (lambda-list (cadr lambda-form))
             (body (cddr lambda-form)))
        (if spread-p
          (nx1-destructure lambda-list (car args) nil nil body env)
          (nx1-lambda-bind lambda-list args body env))))))
             
; note that regforms are reversed: arg_z is always in the car
(defun nx1-arglist (args &optional (nregargs #+ppc-target $numppcargregs #-ppc-target $numargregs))
  (declare (fixnum nregargs))
  (let* ((stkforms nil)
         (regforms nil)
         (nstkargs (%i- (length args) nregargs))
         called
         exited
         calls
         exits)
    (declare (fixnum nstkargs))
    (let* ((*nx-event-checking-call-count* *nx-event-checking-call-count*)
           (*nx-nlexit-count* *nx-nlexit-count*))
      (list
       (dotimes (i nstkargs stkforms)
         (declare (fixnum i))
         (setq calls *nx-event-checking-call-count*
               exits *nx-nlexit-count*)
         (%temp-push (nx1-form (%car args)) stkforms)
        (unless called
          (unless (eq exits (setq exits *nx-nlexit-count*))
            (setq exited exits)))
        (unless exited
          (unless (eq calls (setq calls *nx-event-checking-call-count*))
            (setq called calls)))
         (setq args (%cdr args)))
       (dolist (arg args regforms)
         (%temp-push (nx1-form arg) regforms)
        (unless called
          (unless (eq exits (setq exits *nx-nlexit-count*))
            (setq exited exits)))
        (unless exited
          (unless (eq calls (setq calls *nx-event-checking-call-count*))
            (setq called calls))))))
    (%temp-list (nreverse stkforms) regforms)))

; Bind "event-checking-call" and "non-local-exit" counts, setq at most
; one of them to an incremented value (depending on which happened first.)
(defun nx1-formlist (args &aux a exited called)
  (let* ((*nx-event-checking-call-count* *nx-event-checking-call-count*)
         (*nx-nlexit-count* *nx-nlexit-count*))
    (dolist (arg args)
      (let ((calls *nx-event-checking-call-count*)
            (exits *nx-nlexit-count*))
        (%temp-push (nx1-form arg) a)
        (unless called
          (unless (eq exits (setq exits *nx-nlexit-count*))
            (setq exited exits)))
        (unless exited
          (unless (eq calls (setq calls *nx-event-checking-call-count*))
            (setq called calls))))))
  (if called
    (setq *nx-event-checking-call-count* called)
    (if exited
      (setq *nx-nlexit-count* exited)))
  (nreverse a))

(defun nx1-verify-length (forms min max &aux (len (list-length forms)))
 (if (or (null len)
         (%i> min len)
         (and max (%i> len max)))
     (nx-error "Wrong number of args in form ~S." (cons *nx-sfname* forms))
     len))

(defun nx-unquote (form)
 (if (nx-quoted-form-p form)
  (%cadr form)
  form))

(defun nx-quoted-form-p (form &aux (f form))
 (and (consp form)
      (eq (pop form) 'quote)
      (or
       (and (consp form)
            (not (%cdr form)))
       (nx-error "Illegally quoted form ~S." f))))

; Returns two values: expansion & win
; win is true if expansion is not EQ to form.
; This is a bootstrapping version.
; The real one is in "ccl:compiler;optimizers.lisp".
(unless (fboundp 'maybe-optimize-slot-accessor-form)

(defun maybe-optimize-slot-accessor-form (form environment)
  (declare (ignore environment))
  (values form nil))

)

(defun nx-transform (form &optional (environment *nx-lexical-environment*))
  (let* (sym transforms lexdefs changed enabled macro-function compiler-macro)
    (tagbody
      (go START)
      LOOP
      (setq changed t)
      (when (and (consp form)
                 (or (eq (%car form) 'the)
                     (and sym (eq (%car form) sym))))
        (go DONE))
      START
      (when (non-nil-symbol-p form)
        (multiple-value-bind (newform win) (nx-transform-symbol form environment)
          (unless win (go DONE))
          (setq form newform changed (or changed win))
          (go LOOP)))
      (when (atom form) (go DONE))
      (unless (symbolp (setq sym (%car form)))
        (go DONE))
      (when (nx-quoted-form-p form)
        (when (self-evaluating-p (%cadr form))
          (setq form (%cadr form)))
        (go DONE))
      (when (setq lexdefs (nx-lexical-finfo sym environment))
        (if (eq 'function (%car lexdefs))
          (go DONE)))
      (setq transforms (setq compiler-macro (compiler-macro-function sym environment))
            macro-function (macro-function sym environment)
            enabled (nx-allow-transforms environment))
      (unless macro-function
        (let* ((win nil))
          (when (and enabled (functionp (fboundp sym)))
            (multiple-value-setq (form win) (nx-transform-arglist form environment))
            (if win (setq changed t)))))
      (when (and enabled
                 (not (nx-declared-notinline-p sym environment)))
        (multiple-value-bind (value folded) (nx-constant-fold form environment)
          (when folded (setq form value changed t)  (unless (and (consp form) (eq (car form) sym)) (go START))))
        (when compiler-macro
          (multiple-value-bind (newform win) (compiler-macroexpand-1 form environment)
            (when win
              (when (and (consp newform) (eq (car newform) sym) (functionp (fboundp sym)))
                (setq sym nil))
              (setq form newform)
              (go LOOP))))
        (multiple-value-bind (newform win) (maybe-optimize-slot-accessor-form form environment)
          (when win
            (setq sym nil)
            (setq form newform)
            (go START)))
        (unless macro-function
          (when (setq transforms (or (environment-structref-info sym environment)
                                     (and #-bccl (boundp '%structure-refs%)
                                          (gethash sym %structure-refs%))))
            (setq form (defstruct-ref-transform transforms (%cdr form)) changed T)
            (go START))
          (when (setq transforms (assq sym *nx-synonyms*))
            (setq form (cons (%cdr transforms) (setq sym (%cdr form))))
            (go LOOP))))
      (when (and macro-function
                 (or lexdefs
                 (not (and (gethash sym *nx1-alphatizers*) (not (nx-declared-notinline-p sym environment))))))
        (setq form (macroexpand-1 form environment) changed t)
        (go START))
      DONE)
    (values form changed)))

; Transform all of the arguments to the function call form.
; If any of them won, return a new call form (with the same operator as the original), else return the original
; call form unchanged.

(defun nx-transform-arglist (callform env)
  (with-managed-allocation
    (let* ((any-wins nil)
           (transformed-call (%temp-cons (car callform) nil))
           (ptr transformed-call)
           (win nil))
      (declare (type cons ptr))
      (dolist (form (cdr callform) (if any-wins (values (copy-list transformed-call) t) (values callform nil)))
        (rplacd ptr (setq ptr (%temp-cons (multiple-value-setq (form win) (nx-transform form env)) nil)))
        (if win (setq any-wins t))))))

;This is needed by (at least) SETF.
(defun nxenv-local-function-p (name macro-env)
  (multiple-value-bind (type local-p) (function-information name macro-env)
    (and local-p (eq :function type))))

           
; This guy has to return multiple values.
; The arguments have already been transformed; if they're all constant (or quoted), try
; to evaluate the expression at compile-time.
(defun nx-constant-fold (original-call &optional (environment *nx-lexical-environment*) &aux 
                                       (fn (car original-call)) form mv foldable foldfn)
  (flet ((quotify (x) (if (self-evaluating-p x) x (list 'quote x))))
    (if (and (nx-allow-transforms environment)
             (let* ((bits (if (symbolp fn) (%symbol-bits fn) 0)))
               (declare (fixnum bits))
               (if (setq foldable (logbitp $sym_fbit_constant_fold bits))
                 (if (logbitp $sym_fbit_fold_subforms bits)
                   (setq foldfn 'fold-constant-subforms))
                 (setq foldable (assq fn *nx-can-constant-fold*)
                       foldfn (cdr foldable)))
               foldable))
      (if foldfn
        (funcall foldfn original-call environment)
        (progn
          (with-managed-allocation
            (let ((args nil))
              (dolist (arg (cdr original-call) (setq args (nreverse args)))
                (if (quoted-form-p arg)
                  (setq arg (%cadr arg))
                  (unless (self-evaluating-p arg) (return-from nx-constant-fold (values original-call nil))))
                (%temp-push arg args))
              (setq form (multiple-value-list 
                          (handler-case (apply fn args)
                            (error (condition)
                                   (warn "Error: \"~A\" ~&signalled during compile-time evaluation of ~S ."
                                         condition original-call)
                                   (return-from nx-constant-fold
                                     (values `(locally (declare (notinline ,fn))
                                                ,original-call)
                                             t))))))))
          (if form
            (if (null (%cdr form))
              (setq form (%car form))
              (setq mv (setq form (cons 'values (mapcar #'quotify form))))))
          (values (if mv form (quotify form)) T)))
      (values original-call nil))))

(defun nx-transform-symbol (sym &optional (env *nx-lexical-environment*))
; Gak.  Can't call NX-LEX-INFO without establishing *nx-lexical-environment*.
; NX-LEX-INFO should take env arg!.
  (let* ((*nx-lexical-environment* env))
    (multiple-value-bind (expansion win) (macroexpand-1 sym env)
      (if win
        (let ((type (nx-declared-type sym))
              (var (nth-value 2 (nx-lex-info sym))))
          (unless (eq t type) (setq expansion `(the ,type ,expansion)))
          (when var ;; maybe global-symbol-macro
            (nx-set-var-bits var (%ilogior (%ilsl $vbitreffed 1) (nx-var-bits var)))))
        (progn
          (multiple-value-setq (expansion win)
            (nx-transform-defined-constant sym env))
          (if win (setq win (neq sym expansion)))))
      (values expansion win))))

; if sym has a substitutable constant value in env (or globally), return
; (values <value> t), else (values nil nil)
(defun nx-transform-defined-constant (sym env)
  (let* ((defenv (definition-environment env))
         (val (if defenv (assq sym (defenv.constants defenv))))
         (constant-value-p val))
    (if val
      (setq val (%cdr val))
      (if (constant-symbol-p sym)
        (setq constant-value-p t val (symbol-value sym))))
    (if (and (neq val (%unbound-marker-8))
             constant-value-p 
             (nx-substititute-constant-value sym val env))
      (values (if (self-evaluating-p val) val (list 'quote val)) t)
      (values nil nil))))


(defun nx-var-bits (var)
  (do* ((var var bits)
        (bits (var-bits var) (var-bits var)))
       ((fixnump bits) bits)))

(defun nx-set-var-bits (var newbits)
  (do* ((var var bits)
        (bits (var-bits var) (var-bits var)))
       ((fixnump bits) (setf (var-bits var) newbits))))

(defun nx-adjust-ref-count (var &optional (by 1))
  (let* ((bits (nx-var-bits var))
         (new (%imin (%i+ (%ilogand2 $vrefmask bits) by) 255)))
    (nx-set-var-bits var (%ilogior (%ilogand (%ilognot $vrefmask) bits) new))
    new))

(defvar *use-hairy-cons-type* nil)

(defun nx-form-type (form &optional (env *nx-lexical-environment*))
  (if (self-evaluating-p form)
    (type-of form)
    (if (constant-symbol-p form)
      (type-of (eval form))
      (if (and (consp form)               ; Kinda bogus now, but require-type
               (eq (%car form) 'require-type) ; should be special some day
               (quoted-form-p (caddr form)))
        (%cadr (%caddr form))
        (if (nx-trust-declarations env)
          (if (symbolp form)
            (nx-declared-type form env)
            (if (consp form)
              (if (eq (%car form) 'the) 
                (cadr form)
                (if (eq (%car form) 'setq)
                  (nx-declared-type (cadr form) env)
                  (if (memq (%car form) '(aref aset))
                    (nx-form-array-element-type form env)
                    (if (and *use-hairy-cons-type* (memq (%car form) '(car cdr)))  ;; ??
                      (nx-form-car-cdr-type form env)
                      (let* ((op (gethash (%car form) *nx1-operators*)))
                        (or (and op (cdr (assq op *nx-operator-result-types*)))       ;
                            (and (not op)(cdr (assq (car form) *nx-operator-result-types-by-name*)))
                            (and (memq (car form) *numeric-ops*)
                                 (grovel-numeric-form form env))
                            (and (memq (car form) *logical-ops*)
                                 (grovel-logical-form form env))
                            t))))))
              t))
          t)))))


(defun nx-form-car-cdr-type (form env)
  (let ((a-type (nx-form-type (cadr form) env)))
    (if (neq a-type t)
      (let ((ctype (specifier-type a-type)))
        (if (typep ctype 'cons-ctype)
          (let ((type (case (%car form)
                        (car (cons-ctype-car-ctype ctype))
                        (cdr (cons-ctype-cdr-ctype ctype)))))
            (if (or (null type)(eq type '*)) t type))
          t))
      t)))



(defun nx-form-array-element-type (form env)
  (let ((a-type (nx-form-type (cadr form) env)))
    (if (neq a-type t)
      (let ((ctype (specifier-type a-type)))
        (or (array-or-union-ctype-element-type ctype)
            t))
      t)))

(defparameter *numeric-ops* '(+ -  / * +-2 --2 *-2 /-2))

(defparameter *logical-ops* '(logxor-2 logior-2 logand-2  lognot logxor))

(defun numeric-type-p (type &optional not-complex)
  (or (memq type '(fixnum integer double-float short-float))
      (let ((ctype (specifier-type type)))
        (and (numeric-ctype-p ctype)
             (or (not not-complex)
                 (neq (numeric-ctype-complexp ctype) :complex))))))


; doesn't do ranges so good 
; this is an adhoc piece of junk that deals with the following cases
; 1) if numeric op of known fixnums and result is known fixnum, just do it for any number args
; 2) if numeric op and any arg is known double-float, result is double-float
;      unless any arg is complex or not known numeric
; dealing specially with / - only know result if something known double-float
; then there's e.g. progn whose last form is known type......

(defun grovel-numeric-form (form env)
  (when (nx-trust-declarations env)
    (let ((op (car form))
          type)
      (dolist (arg (cdr form))
        (let ((it (nx-form-type arg env)))
          (if (or (eq it 'complex)(not (numeric-type-p it t)))
            (return (setq type nil))
            (if (or (eq it 'double-float)(eq type 'double-float))              
              (setq type 'double-float)
              (if (eq it 'short-float)
                (setq type it)
                (if type
                  (if (subtypep it type)
                    (setq type type)
                    (if (subtypep type it)
                      (setq type it)
                      (return (setq type nil))))
                  (setq type it)))))))
      (when type 
        (if (memq op '(/ /-2))
          (if (memq type '(short-float double-float)) type nil)
          ;  + of fixnum and fixnum not always fixnum
          (if (subtypep type 'fixnum)
            (if (and (memq op '(+ - +-2 --2))
                     (subtypep type '(signed-byte 28))(< (length form) 5)) ; or 29? - but form not always binary
              'fixnum
              (if (eq *nx-form-type* 'fixnum) 'fixnum 'integer))
            (if (memq type '(integer double-float short-float)) type)))))))

; now e.g. logxor of 3 known fixnums is inline as is (logior a (logxor b c))
; and (the fixnum (+ a (logxor b c)))

(defun grovel-logical-form (form env)
  (when (nx-trust-declarations env)
    (let (;(op (car form))
          type)
      (dolist (arg (cdr form))
        (let ((it (nx-form-type arg env)))          
          (if (not (subtypep it 'fixnum))
            (return (setq type nil))
            (setq type 'fixnum))))
      type)))

(defun nx-form-typep (arg type &optional (env *nx-lexical-environment*))
  (setq type (type-expand type))
  (if (constantp arg)
    (typep arg type)
    (subtypep (nx-form-type arg env) type)))


(defun nx-binary-fixnum-op-p (form1 form2 env &optional ignore-result-type)
  (and (nx-form-typep form1 'fixnum env)
       (nx-form-typep form2 'fixnum env)
       (or ignore-result-type
           (and (nx-trust-declarations env)
                (subtypep *nx-form-type* 'fixnum)))))

(defun nx-binary-boole-op (whole env arg-1 arg-2 fixop intop)
  (let* ((use-fixop (nx-binary-fixnum-op-p arg-1 arg-2 env t)))
    (if (or use-fixop intop)
      (make-acode (if use-fixop fixop intop) (nx1-form arg-1) (nx1-form arg-2))
      (nx1-treat-as-call whole))))

(defun nx-need-var (sym &optional (check-bindable t))
  (if (and (nx-need-sym sym)
           (not (constantp sym))
           (let* ((defenv (definition-environment *nx-lexical-environment*)))
             (or (null defenv)
                 (not (assq sym (defenv.constants defenv)))))) ; check compile-time-constants, too
    (if (and check-bindable (or 
                             (logbitp $sym_vbit_global (the fixnum (%symbol-bits sym)))
                             (let* ((defenv (definition-environment *nx-lexical-environment*)))
                               (if defenv 
                                 (eq :global (%cdr (assq sym (defenv.specials defenv))))))))            
      (nx-error "~S is global and can not be bound . " sym)
      sym)
    (nx-error "Can't bind or assign to constant ~S." sym)))

(defun nx-need-sym (sym)
  (if (symbolp sym)
    sym
    (nx-error "~S is not a symbol." sym)))

(defun nx-need-function-name (name)
  (multiple-value-bind (valid nm) (valid-function-name-p name)
    (if valid nm (nx-error "Invalid function name ~S" name))))

(defun nx-pair-name (form)
  (nx-need-sym (if (consp form) (%car form) form)))

(defun nx-pair-initform (form)
  (if (atom form)
    nil
    (if (and (listp (%cdr form)) (null (%cddr form)))
      (%cadr form)
      (nx-error "Bad initialization form: ~S." form))))

; some callers might assume that this guy errors out if it can't conjure up
; a fixnum.  I certainly did ...
(defun nx-get-fixnum (form &aux (trans (nx-transform form *nx-lexical-environment*)))
 (if (fixnump trans)
  trans
  form))
 
(defun nx1-func-name (gizmo)
  (and (consp gizmo)
       (or (eq (%car gizmo) 'function) (eq (%car gizmo) 'quote))
       (consp (%cdr gizmo))
       (null (%cddr gizmo))
       (nth-value 1 (valid-function-name-p (%cadr gizmo)))))

; distinguish between program errors & incidental ones.
(defun nx-error (format-string &rest args)
  (error (make-condition 'compile-time-program-error 
                :context (nx-error-context)
                :format-string format-string
                :format-arguments args)))

(defun nx-compile-time-error (format-string &rest args)
  (error (make-condition 'compile-time-program-error 
                :context (nx-error-context)
                :format-string format-string
                :format-arguments args)))

; Should return information about file being compiled, nested functions, etc. ...
(defun nx-error-context ()
  (or *nx-cur-func-name* "an anonymous function"))

;;;;;; define-symbol-macro ??? - kind of wimpy


#| ;; moved to l1-utils-ppc
(defun %define-symbol-macro (name expansion)
  (let ((info (make-symbol-macro-info name expansion)))
    ;; check for special - should do vv too
    (when (nx-proclaimed-special-p name)
      (error "Can't define symbol macro for special variable ~S ." name))
    (record-source-file name 'symbol-macro)
    (pushnew info
             *nx-symbol-macros* ;; these are global
             :test  #'(lambda (x y) 
                        (and (eq (var-name x)
                                 (var-name y))
                             (equal (var-ea x) (var-ea y)))))))
|#

#| ;; moved to level-2
(defmacro define-symbol-macro (name expansion)
  `(progn (eval-when (:compile-toplevel)
            (%define-compile-time-symbol-macro ',name ',expansion))
          (eval-when (:load-toplevel :execute)          
            (%define-symbol-macro ',name ',expansion))))
|#


#| ;; moved to nfcomp
;; need new version of nfcomp also
(defun %define-compile-time-symbol-macro (name expansion)  
  (let ((info (make-symbol-macro-info name expansion)))
    ;; check for special - should do vv too
    (when (nx-proclaimed-special-p name)
      (error "Can't define symbol macro for special variable ~S ." name))
    (pushnew info
             *compile-time-symbol-macros*
             :test  #'(lambda (x y) 
                        (and (eq (var-name x)
                                 (var-name y))
                             (equal (var-ea x) (var-ea y)))))))
|#
  
