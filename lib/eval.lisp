;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  14 9/3/96  akh  conditionalization
;;  12 8/14/96 bill 4.0d23
;;  10 7/18/96 akh   no mo glip-glop for *trampoline-code-vect*, no mo warnings
;;  9 3/27/96  akh  don't error in %special-declare. it's OK.
;;  8 3/17/96  akh  remove a print, fix some more
;;  7 3/16/96  akh  make it work enough to pass the test suites
;;  6 2/23/96  akh  more ppc specific stuff
;;  5 2/19/96  akh  start on ppc specific stuff
;;  4 11/13/95 akh  comment out stuff that won't ppc compile -
;;  2 10/17/95 akh  %%invoke - dont blow stack
;;  3 4/24/95  akh  not so many blocks in munch-lambda
;;  (do not edit before this line!!)


(in-package "CCL")

;; Copyright 1987-1988 Coral Software Corp.
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995-1999 Digitool, Inc.

; Modification History
;
; 09/11/99 akh no require nxenv
; 08/14/99 akh munch-decls knows about ignorable, and warns about some unknown decls
; ---------- 4.3f1c1
; 05/19/99 akh deffexpr the - fix for values
; 05/09/99 akh munch-form does global symbol macros (PPC only)
;----------- 4.3b1
; 03/30/99 akh add find-interpreted-slot-name - called from method-slot-name, don't uncompile reader methods
; 10/28/97 akh  uncompile-for-stepping - given gf uncompiles all the methods if possible
; 10/08/96 bill Alice's fix to process-supplied-args
; ------------- 4.0b2
; 08/27/96 bill tc sets the $lfbits-keys-bit when there is any key vector, even an empty one.
; ------------- 4.0b1
; 08/14/96 bill My fix to Alice's fix to my fix of process-supplied-args
; 07/24/96 bill gb's fix to %bind-special, memoize store into variable value cell.
; akh - no mo glip-glop for *trampoline-code-vect*, no mo warnings
;10/26/95 slh   %gvector -> %istruct
;04/13/95 alice well 2 years later munch-lambda needs block iff not there already
;04/17/93 alice *step-commands* is global
;04/04/93 alice munch-lambda needed  (block name ...)
;01/20/93 bill  in evp-arglist: copy-list -> copy-arglist: Needed to copy deeper.
;06/02/92 alice fix fix to destructuring bind
;----------- 2.0
;01/08/92 alice non-null-env bit was wrong, fix uncompile-for-stepping
;01/01/92 alice set the nonnullenv-bit when applicable
;12/15/91 alice destructuring-bind deals with a . b as a special case
;12/14/91 alice uncompile-for-stepping doesn't install anything, to do check ralph bit, tc set it
;----------- 2.0b4
; 11/19/91 bill  munch-lambda's disgusting-accessors-constant keeps up with defmethod
; 08/29/91 alice fix for (... &key) and &method => &allow-other-keys
; 08/24/91 gb    use new trap syntax in commented-out _debugger call.
; 08/16/91 alice load-time-value
; 07/16/91 alice fix methods declaring specials (acct for magic next method arg)
; 07/15/91 alice fix some overzealous cars and cdrs in munch-lambda re slot readers/writers
; 05/29/91 alice &restv, fbind, and fix slot reader/writer methods AGAIN
; 05/28/91 alice Adapt to new next-method regime. Eval'd methods always cons & close the magic next method arg 
; 04/29/91 alice munch-lambda - fix for slot readers and writers
; 03/25/91 bill compute-applicable-methods no longer takes a rest arg.
; 03/07/91 alice warn about undefined functions - no dont
; 02/28/91 alice make warnings like compiler, errors are subclass of program-error where appropriate,
;          the error strings are !&*? resources
; 02/11/91 alice compiled-for-evaluation - check that its lfunp
; 02/08/91 alice eval-prep dont error if form not consp
;--------------- 2.0b1.
;02/06/91 bill evp-arglist & eval-prep patches from patch2.0b1p3
; 02/04/91 akh fix macrolet for new regime, error msg for bad car form should not be "Yikes"
; 01/11/91 akh EVP-ARGLIST fix for let's in initforms, add function OPTIONAL-SUPPLIED-P
;              needed a change to ev-opt-sup-org as well
; 01/11/91 akh fix so can nuke environment from closed vars (less space hogging)
; 01/11/91 akh find-symbol-value-closed - no error if find unclosed name - keep going
;;; -------------- 2.0a5 (d83)
; 01/10/91 akh macrolet was brain damaged.
; 01/08/91 akh WITH-STACK-VECTOR use new dynamic-extent uvectors
; 01/08/91 akh fix MUNCH-FORM to error if given any special form it doesnt understand
;          instead of thinking it knows what special forms it doesnt understand.
; 01/06/91 akh no more compiler required. Had a bug re &aux now fixed.
; 01/05/90 akh try with-stack-vector for specials, fix for closed vars in stepper
; 01/04/90 akh in TC break fixnums into 2 pieces cause fixnums arent legal immediates.
;           Closed block was broken.
; 01/04/90 akh in TC mention all the args so compiler wont toss away my rest args
; 01/03/90 akh next-meth-with-args wants next-meth bit toooo!, note-symbol-ignored ignore specials
; 01/02/91 gb some ill-advised usage of (declare (resident))
; 01/02/91 akh progn=>ignore-errors in ev-prep, cant cope has string and args
;          lap-inline instead of old-lap-inline else get magic method var on vsp always
; this one works - leave it alone
; remember to nuke all the breaks and prints - try closing over symbol macro
; 12/28/90 dont use assq in stash-lexical-fref (nil as name is ambiguous)
; 12/21/90 compiled-function-p of interpreted fn is T - should it be nil?
; 12/21/90 BUG - inspector abhors interpreted lexical closures
; 12/20/90 make evaluated function smaller, repair labels + closures
; 12/17/90 use one array for runtime values & names
; 12/14/90 handle locally at top level correctly - should also do for macrolet
; 12/03/90 akh change initform methodology 
;---------- 2.0a4p1
; 12/02/90 akh symbol-referenced-p T for specials, %special-bind ignore non bound specials
;               fix %special-declare and some callers thereof
; 12/02/90 akh evp-arglist fix for optional supplied-p being special (yech)
; 12/01/90 akh make special bindings really work
; 11/29/90 akh make (the (values ...) foo) work
; 11/28/90 akh distinguish between eval-cant-cope (e.g. with lap) and real program errors
; 11/27/90 akh fix add-symbol-referencer, note-symbol-closed, note-symbol-special for ignore-if-unused
; 09/21/90 akh Lots of new stuff
;------------------- 2.0

#-ppc-target
(eval-when (:execute :compile-toplevel)
 (require 'lap)
 (require 'lapmacros)
)

#||
(eval-when (:compile-toplevel :execute)
  (require :nxenv))
||#

(eval-when (:load-toplevel)
  (if (not (fboundp 'parse-body))
    (require :nx-basic "ccl:compiler;nx-basic")))

(defparameter *special-form-fns*
  (make-hash-table :test #'eq :rehash-size 2 :size 50))
(defparameter *step-mapsize* 50)

(defvar %evalenv% nil)  ; runtime evalenv has local "stack" blocks, tags, etal
(defvar *stepping* nil)
(defglobal *step-commands* nil)
; means we are eval'ing something munched with an env containing "stack(s)"
;(defvar *compiled-for-evaluation* nil)  ; maybe obsolete  
(defparameter %special-marker% (gensym))
(defparameter %closed-marker% (gensym))
;(defparameter %method-var-name% '%method-var%)

(define-condition eval-cant-cope (simple-condition error))

(defun eval-cant-cope (string &rest args)
  ;(declare (ignore string args))
  (error (make-condition 'eval-cant-cope :format-string string :format-arguments args)))

;;; FEXPRP determines whether a fsymbol names a FEXPR.

(eval-when (:compile-toplevel :execute :load-toplevel)

(defmacro fexprp (sym)
  `(gethash ,sym *special-form-fns*))
)

(eval-when (eval compile)
  (defmacro deffexpr (name arglist &body body)
    (unless (symbolp name) (report-bad-arg name 'symbol))
    (unless (consp arglist) (report-bad-arg arglist 'cons))
    (multiple-value-bind (body decls doc)
                         (parse-body body nil t)
      (declare (ignore doc))
      (let ((call (gensym))
            (ignore (gensym)))
        `(%deffexpr 
          ',name
          (nfunction ,name 
                     (lambda (,call)
                       (debind
                         (,ignore ,@arglist)  ,call
                         (declare (ignore ,ignore))
                         ,@decls 
                         (block ,name ,@body))))))))

  (defmacro with-stack-vector ((array n) &body body)
    (let ((nsym (gensym)))
      `(let* ((,nsym ,n)
              (,array #-ppc-target(%make-uvector ,nsym $v_genv)
                      #+ppc-target(%alloc-misc ,nsym ppc::subtag-simple-vector nil)))
         (declare (dynamic-extent ,array))
         ,@body)))
  
  ) ; end eval-when


; things to worry about
; 9. When stepping whaddya do about lexical environment when user "types a form to eval ..."
;     (i.e. if its a closure, we only have the closed over lexical vars - not complete set)
; 11. Eventually uncompile-for-stepping should try to find the def with meta-.
; 14. Teach backtrace about eval (next month) - it's halfway decent as is.
; 16. Its yucky that the window for eval in stepper allows only one line
; 17. Should unstepping an interpreted thing ask if you wish to compile it now? - probably not
; 18. How can we make function-lambda-expression know that a fn uses some fns in lexical env
;     (we know about vars cause then its a closure)


; weird forms introduced (%local-ref name idx), (%closure-ref name -idx) .. do we need both? - yeah 
; (%local-fref  def), (%special-bind (x 0)(y 3) ...) actually means bind whether or not special
; (%with-specials .....) and (%init&bind var form supp-p)
; (%special-declare idx . specials)  for specials declared but not bound

#||
(def-accessors %svrefs
  ()					; 'lexical-environment
  lexenv.parent-env
  lexenv.functions
  lexenv.variables
  lexenv.fdecls				; function-binding decls, e.g., [NOT]INLINE, FTYPE
  lexenv.vdecls				; variable-binding decls, e.g., SPECIAL, TYPE
  lexenv.mdecls				; misc decls, e.g., OPTIMIZE
  lexenv.lambda				; unique id (e.g., afunc) of containing lambda expression.
  )
||#

; this should shadow or include lexenv thingie
; will variable (name t) confuse macro expand?
(def-accessors  uvref ;%svref
  ()
  evalenv-parent-env
  evalenv-functions     ; list of (name type . body) type is 'function or 'macro
  evalenv-variables     ; a list of var structures containing name etc.
  evalenv-fdecls
  evalenv-vdecls
  evalenv-mdecls
  evalenv-lambda
  evalenv-vp            ; current stack depth
  evalenv-maxvp         ; max ditto
  evalenv-values        ; stack consed vector for interpreter "stack frame"
  evalenv-names         ; ditto for variable names - maybe nuke this in runtime (change kernel too)
  evalenv-name          ; for debugging - maybe nuke it  
 ; evalenv-mapping       ; eq hash table mapping from munched forms to original forms - nuke
 ; evalenv-specials      ; list of arrays for special bindings - nuke 
                        ; below be munch time only
  evalenv-form          ; original form (this also shows up in "closure-def" later
  evalenv-closure-def   ; contains a "closure-def" structure which contains the expanded form
  ;evalenv-closed-used   ; alist of bindings needed in this env bound in prior
  evalenv-bits          ; (has method-bit next-method-bit and next-method-with-args)
  evalenv-binders       ; keep  binders to adjust for nclosed (all the vars we ever made)
  evalenv-frefs         ; alist of alists of alists for labels (who calls who)
  evalenv-fnentry       ; hold the stuff to pass to fnentry generator
                         ; list of  nreq nopt optional-init restp keyvect 
                         ; (or allow-other-p (and keyp method-var-name) restv-p                    
)
; note that some knowledge of the shape of this is built into the kernel (yech)

(defparameter evalenv-runtime-size 20) ; or something

(defparameter *save-source-mapping* t)

(defparameter *source-mapping-table* 
  (make-hash-table :test #'eq :size *step-mapsize* :weak t))

(defstruct (closure-def)
  name
  form
  expanded-form
  extra-vars
  compiled-form)

(defun make-evalenv (&optional parent (closure-def (make-closure-def)))
  ; gotta be a better way  
  (let ((env (%istruct 'lexical-environment parent nil nil nil nil nil nil
                       -1 -1 nil nil nil
                       nil closure-def 0 nil nil nil nil)))
    env))

(defmacro make-runtime-evalenv (&optional parent (vp -1) (maxvp -1) values names name)
  `(%istruct 'lexical-environment ,parent nil nil nil nil nil nil
            ,vp ,maxvp ,values ,names ',name))

(defun make-barrier (env)
  (let ((newenv (make-evalenv env nil)))
    (setf (evalenv-variables newenv) 'barrier)
    newenv))

(defun eval-error (string env &rest args)
  (error (make-condition 'eval-program-error
                         :context (or (evalenv-name env) "an anonymous function")
                         :format-string (if (fixnump string) (%rsc-string string) string)
                         :format-arguments args)))

(defun eval-warn (about env &rest args)
  (declare (special *eval-warnings*))
  (push (make-condition  'compiler-warning
                        :function-name (evalenv-nested-name env) ;(list (evalenv-name env)) ; here could make a list of nested foos
                        :warning-type about
                        :args args)
        *eval-warnings*))

(defun evalenv-nested-name (env)
  (let (val)
    (while (and env (%i> (uvsize env) 8))
      (push (evalenv-name env) val)
      (setq env (evalenv-parent-env env)))
    ; somebody else reverses it
    val))


;(defconstant $lfbits-evaluated-bit 25)

(defun evalenv-next-method (env &optional value)
  (let ((bits (evalenv-bits env)))
    (if value
      (progn (setf (evalenv-bits env)
                   (logior (%ilsl $lfbits-nextmeth-bit 1) bits))
             T)
      (logbitp $lfbits-nextmeth-bit bits))))

(defsetf evalenv-next-method evalenv-next-method)

(defun evalenv-next-method-with-args (env &optional value)
  (let ((bits (evalenv-bits env)))
    (if value
      (progn (setf (evalenv-bits env)
                   (logior (+ (%ilsl $lfbits-nextmeth-with-args-bit 1)
                              (%ilsl $lfbits-nextmeth-bit 1))
                           bits))
             T)
      (logbitp $lfbits-nextmeth-with-args-bit bits))))

(defsetf evalenv-next-method-with-args evalenv-next-method-with-args)

(defun evalenv-method-p (env &optional value)
  (let ((bits (evalenv-bits env)))
    (if value
      (progn (setf (evalenv-bits env)
                   (logior (%ilsl $lfbits-method-bit 1) bits))
             T)
      (logbitp $lfbits-method-bit bits))))

(defsetf evalenv-method-p evalenv-method-p)

(defparameter %step-evalenv% (make-evalenv))



;;;;;;;;;;;;;;;;;;
;;; some dumb little functions/macros that partially hide the representation of variable info
;;;
;;; this week variable is a structure containing  name, idx & referencer)
;;; referencer is T for special or sometimes idx is t for special
;;;               (&local-ref name idx)
;;;               (%closure-ref name idx)
;;; if referencer is missing the variable is unused (HA!)
;;; now its cons-var (sym bits)
;;; if symbol-macro var-ea is a cons whose car is :symbol-macro
;;; use var-decls for the referencer
;;; tags something like name = (%tag name . body) idx is obvious, reffer is like vars

;(defparameter %not-a-variable '(%tag %closed-tag %block %closed-block))

(defun make-symbol-info (sym idx env &optional reffer)
  (let ((info (cons-var sym idx)))
    (when (and env (fixnump idx))(push info (evalenv-binders env)))
    (when reffer (setf (var-decls info) reffer))
    info))

(defun note-symbol-closed (info env)
  (let ((reffer (var-decls info)))
    (case reffer
      (ignore
       (eval-warn :ignore env (var-name info)) ; "Variable ~S not ignored")
       (setq reffer nil))
      (ignore-if-unused
       (setq reffer nil)))
    (cond ((or (eq reffer t)(eq (var-bits info) t))
           (error "some nut thinks we can close over a special"))
          ((consp reffer)
           (case (car reffer)
             (%local-ref (rplaca reffer (fexprp '%closure-ref)))
             (%tag (rplaca reffer '%closed-tag))
             (%symbol-macro (error "Eval cant close over a symbol-macro")) ; huh - one can
             (t (cond ((consp (car reffer))
                       (rplaca reffer (fexprp '%closure-ref)))))))          
          (t (let ((name (var-name info)))
               (when (consp name)
                 (setq name (var-name (car name))))
               (setf (var-decls info)
                   (list (fexprp '%closure-ref) name (var-bits info)))))))
  info)

(defun note-symbol-special (info which env)
  (let ((reffer (var-decls info)))
    (case reffer
      (ignore
       (eval-warn :ignore env (var-name info)) ; "Variable ~S not ignored")
       (setq reffer nil))
      (ignore-if-unused
       (setq reffer nil)))
    (cond ((eq reffer t))
          ((eq (var-bits info) t)
           (setf (var-decls info) t)
           (setf (var-bits info) 0))
          ((consp reffer)
           (error "Some nut thinks closed var or symbol macro can be special"))
          (t (setf (var-decls info) t)))
    (setf (var-bits info)(dpb which (byte 16 16) (var-bits info)))
  info))

(defun note-symbol-ignored (sym env &optional if-uu)
  (let ((info (ev-symbol-info sym env)))
    (when (and info (not (symbol-special-p info)))
      (let ((reffer (symbol-referencer info)))
        (cond ((and reffer (neq reffer 'ignore-if-unused)(neq reffer 'ignore))
               (when (not if-uu)
                 (eval-warn :ignore env sym))) ; "Variable ~S not ignored" sym)))
              ((null reffer)
               (setf (var-decls info) (if if-uu 'ignore-if-unused 'ignore))))))))

(defun symbol-special-idx (info)
  (ldb (byte 16 16)(var-bits info)))

(defun symbol-idx (info)
  (ldb (byte 16 0)(var-bits info)))



(defun symbol-closed-p (info)
  (let ((reffer (var-decls  info)))
     (and (consp reffer)(eq (caar reffer) '%closure-ref))))

(defun symbol-special-p (info)
  (or (not (fixnump (var-bits  info)))
      (eq t (var-decls info))))

(defun add-symbol-referencer (info &optional env type)
  ; assume not called for specials? or tags
  (let ((reffer (var-decls info))(name (var-name info)))
    (when (consp name)
      (setq name (var-name (car name))))
    (if (or (eq reffer t)(not (fixnump (var-bits info))))
      (error "we lied about specials"))
    (case reffer 
      (ignore
       (eval-warn :ignore env name) ; "Variable ~S not ignored" name)
       (setq reffer nil))
      (ignore-if-unused
       (setq reffer nil)))
    (cond ((not reffer)
           (setq reffer (list (or (and type (fexprp type)) (fexprp '%local-ref)) name (var-bits info)))
           (setf (var-decls info) reffer))
          (type (rplaca reffer (fexprp type))))
    reffer))

(defun symbol-referencer (info)
  (var-decls info))

(defun symbol-referenced-p (info)
  ; not right for symbol macros (do we care?)
  (or (not (fixnump  (var-bits info))) (var-decls info)))

(defun make-symbol-macro-info (sym def)
  (let ((info (cons-var sym 0)))
    (setf (var-ea info)(cons :symbol-macro def))
    info))
                       

(defun symbol-macro-def-p (info)
  (let ((thing (var-ea info)))
    (and (consp thing)
         (eq (car thing) :symbol-macro))))

; assume caller has checked that it has one - 
(defun symbol-macro-def (info)
  (let ((thing (var-ea info)))
    (and (consp thing)
         (eq (car thing) :symbol-macro)
         (cdr thing))))

(defun ev-symbol-info (sym env)
  (dolist (info  (if (listp env) env (evalenv-variables env)))
    (when (eq (var-name info) sym)
      (return info))))



(defun ev-lexical-binding (sym env)
  ; only look above env
  ; this week we will heap cons all closed over values
  (when env
    (let ((in-env env) info barrier-p)
      (when in-env
        (while (and (setq in-env (evalenv-parent-env in-env))
                    (neq (%svref in-env 0) 'definition-environment))
          (if (eq (evalenv-variables in-env) 'barrier)
            (setq barrier-p t)
            (progn
              (setq info (ev-symbol-info sym in-env))
              ; here is the place to tell the variable entry that he is closed upon
              (when info 
                (when (not (symbol-special-p info))
                  (when barrier-p (eval-error $Xnolexvar env sym)) ;(macrolet-error))
                  (note-symbol-closed info env))
                (return-from ev-lexical-binding (values info in-env))))))))))
#|||

; return the thing and a second value of non-nil if its a new one
(defun ev-add-closed-used (sym env)
  ; index -n .. -2, -1
  (let* ((cdef (evalenv-closure-def env))
         (vars (closure-def-extra-vars cdef)) val n)
    (when (not (setq val (ev-symbol-info sym vars)))
      ;(print (list 'adding sym (evalenv-name env)))
      (setq n (if (null vars) -1 (1- (var-bits (car vars)))))
      (setf (closure-def-extra-vars cdef)
            (cons (setq val (make-symbol-info sym n env)) vars))
      (note-symbol-closed val))
    (values val n)))
||#

(defun ev-add-closed-used-2 (env var bindenv)
  ; env has def that uses, var is a var structure, bindenv where var is bound (not inherited)
  ; index -n .. -2, -1
  (let* ((cdef (evalenv-closure-def env))
         (vars (closure-def-extra-vars cdef)) val n)
    (dolist (oldvar vars)
      (when (eq (car (var-name oldvar)) var)
        (return (setq val oldvar))))    
    (when (not val)
      ;(print (list 'adding (var-name var)(or (evalenv-name env) env)))
      (setq n (if (null vars) -1 (1- (var-bits (car vars)))))
      (setf (closure-def-extra-vars cdef)
            (cons (setq val (make-symbol-info (cons var bindenv) n env)) vars))
      (note-symbol-closed val env)
      (note-symbol-closed var bindenv))
    (values val n)))

(defun find-closed-var (var env)
  (let* ((cdef (evalenv-closure-def env))
         (vars (closure-def-extra-vars cdef)))
    (dolist (oldvar vars)
      (when (eq (car (var-name oldvar)) var)
        (return oldvar)))))

; find env in which sym is fbound
; or return def 
#|| 
(defun ev-lexical-fbinding-p (sym env &optional def)
  (let ((inenv env))
    (while (and inenv (neq (%svref inenv 0) 'definition-environment))
      (let ((res (assq sym (evalenv-functions inenv))))
        (when res (return-from ev-lexical-fbinding-p (if def res inenv))))
      (setq inenv (evalenv-parent-env inenv)))))
||#


; remember reference in env of fbinder, return reffer
; called-env is env in which called is bound/created
; (caller-env (name-called . reffer) ... )
(defun ev-stash-lexical-fref (caller-env name def)
  (let* ((top-env (env-top-env caller-env))
         (frefs (evalenv-frefs top-env))
         (caller-alist (assq caller-env frefs))
         reffer)
    ; if stashed higher up just remember that we called somebody
    ; cause if we didnt then we can finish early
    (cond 
     ((null caller-alist)
      (setq reffer `(%local-fref ,def)) ; place holder for def
      (push `(,caller-env (,name ,@reffer)) (evalenv-frefs top-env)))
     (t  (let (name-thing) ; (assq name (cdr caller-alist)))) ; look out if name is NIL
           (dolist (blah (cdr caller-alist))
               (when (eq def (caddr blah))
                 (setq name-thing blah)
                 (return)))
           (cond
            ((null name-thing)
             (setq reffer `(%local-fref ,def))
             (rplacd caller-alist (cons `(,name ,@reffer)
                                        (cdr caller-alist))))
            (t (setq reffer (cdr name-thing)))))))
    reffer))

(defun env-top-env (env)
  (let ((inenv env))
    (while (and inenv 
                (neq (%svref inenv 0)'definition-environment)
                (> (uvsize inenv) 8)
                (neq (evalenv-variables inenv) 'barrier))
      (setq env inenv)
      (setq inenv (evalenv-parent-env inenv)))
    env))
      


                     
    
; caller responsible for dealing with macros vs. functions
; returns 2 values - the definition e.g. (name 'function . def) or (name gensym)
;                     reffer for call to sym from env - iff function
(defun ev-lexical-fbinding (sym env)
  ; look in env and above
  (let ((inenv env) reffer barrier-p)
    (while (and inenv (neq (%svref inenv 0) 'definition-environment))
      (if (eq (evalenv-variables inenv) 'barrier)
        (setq barrier-p t)            
        (let ((res (assq sym (evalenv-functions inenv))))
          (when res
            (when (eq (cadr res) 'function)
              (when barrier-p (eval-error $Xnolexfunc env sym)) ;(macrolet-error))
              (setq reffer (ev-stash-lexical-fref env sym (cddr res))))
            (return-from ev-lexical-fbinding (values res reffer)))))
      (setq inenv (evalenv-parent-env inenv)))))


; find the var info for the tagbody "name"
; and the tag&body for tag
(defun ev-find-tag (name env &optional no-error)
  (let ((in-env env) tag&body barrier-p)
    (while (and in-env (neq (%svref in-env 0) 'definition-environment))
      (if (eq (evalenv-variables in-env) 'barrier)
        (setq barrier-p t)
        (dolist (info (evalenv-variables in-env))
          (let ((reffer (var-decls info)))
            (when (and (consp reffer)
                       (memq (car reffer) '(%tag %closed-tag))
                       (setq tag&body (assq name (cdddr reffer))))
              (when (neq in-env env)
                (when barrier-p (eval-error $xnolextag env name)) ;(macrolet-error))
                (setq info (ev-add-closed-used-2 env info in-env))
                (rplaca (var-decls info) '%closed-tag))
              (return-from ev-find-tag (values info tag&body))))))
      (setq in-env (evalenv-parent-env in-env)))
    (if (not no-error)(eval-error $xnotag env name)))) ;  "Cant find tag ~S" name)))) ; $xnotag

(defun ev-add-tagbody (idx env)
  (let (info (name (gensym)))
    (setq info (make-symbol-info name idx env))
    (setf (var-decls info) `(%tag ,name ,idx))
    (push info (evalenv-variables env))
    info))

(defun ev-add-tag (tag&body info env)
  (let ((reffer (symbol-referencer info))(tag (car tag&body)))
    (when (assq tag (cdddr reffer))
      (eval-error $xduplicatetag env tag)) ;"Duplicate tag ~S"
    (nconc (symbol-referencer info) (list (cons (car tag&body)(cdr tag&body)))))) 



(defun ev-find-block (name env &optional no-error)
  (let ((in-env env) barrier-p)
    (while (and in-env (neq (%svref in-env 0) 'definition-environment))
      (if (eq (evalenv-variables in-env) 'barrier)
        (setq barrier-p t)
        (dolist (info (evalenv-variables in-env))
          (let ((reffer (var-decls info)))
            (when (and (consp reffer)(eq (cadr reffer) name)(memq (car reffer) '(%block %closed-block)))
              (when (neq in-env env)
                (when barrier-p (eval-error $XNoLexBlock env name))   ;macrolet-error))
                (setq info (ev-add-closed-used-2 env info in-env))
                (rplaca (var-decls info) '%closed-block))
              (return-from ev-find-block info)))))
      (setq in-env (evalenv-parent-env in-env)))
    (if (not no-error)(eval-error $xnoBlock env name)))) ;"Cant find block ~S" name))))

(defun ev-add-block (name idx env)
  (let (info)
    (setq info (make-symbol-info (if (and (symbolp name) name (not (symbol-package name)))
                                   name 
                                   (gensym))
                                 idx env))
    (setf (var-decls info) `(%block ,name ,idx))
    (push info (evalenv-variables env))
    info))      


;;;;;;;;;;;;;;;;;;;;;
;;; eval preprocessor munches a definition by expanding all the macros,
;;; figuring out where local variables and vars passed to closures will
;;; live in a pseudo stack frame and eventually keeping a mapping from
;;; original to munched and/or vice versa
;;; Pseudo compiles all the functions, closures etc. so that the compiler
;;; gets to do all the arglist processing. Currently "eval" will process 
;;; non constant init forms so that one can see them in the stepper.

(defparameter *step-mapsize* 50)

; eventually want to know that this aint a real compiled lexical closure
#-ppc-target
(defun make-lexical-closure (def values)
  (when (> (length values) 200)
    (cerror "Live dangerously." "Interpreted closure with ~s values may crash."
            (length values)))
  (let* ((c (lap-inline (def (require-type values 'list))
              (move.l ($ 4) nargs)
              (move.l arg_z atemp0) ; values
              (vpush arg_y)         ; def
              (prog#
               (cmp.l atemp0 nilreg)
               (beq (exit#))
               (vpush atemp0)
               ;(dc.w #_debugger)
               ;(jsr_subprim $sp-stkcheck) ; fat lotta good that does
               (vpop atemp0)
               (vpush (car atemp0))
               (cdr atemp0 atemp0)
               (add.l ($ 4) nargs)
               (bra (top#)))
              (jsr_subprim $sp-mkclosure)
              (move.l atemp0 acc))))
    (lfun-bits c (logior (ash 1 $lfbits-evaluated-bit) (the fixnum (lfun-bits c))))
    c))

#+ppc-target
(progn

; surely there is a better way to do this - and there was
(defparameter %closure-code% %closure-code%)

(defparameter *trampoline-code-vect* %closure-code%)




; closure looks like trampoline-code-vect | closed function | closed vals ....| name | bits 

(defun make-lexical-closure (def values) 
  (when (> (length values) 200)
    (cerror "Live dangerously." "Interpreted closure with ~s values may crash."
            (length values)))
  (let ((newdef (%alloc-misc (+ 4 (length values)) ppc::subtag-function)))
    (setf (uvref newdef 0) *trampoline-code-vect*)
    (setf (uvref newdef 1) def)
    (do* ((i 2 (1+ i))
          (lis values (cdr lis)))
         ((null lis))
      (setf (uvref newdef i)(car lis)))
    (lfun-bits newdef (logior (ash 1 $lfbits-evaluated-bit)
                              (ash 1 $lfbits-trampoline-bit)
                              (the fixnum (lfun-bits def))))
    (lfun-name newdef (lfun-name def))
    newdef))



)

(defun make-vcell (value)
  ; dummy def - whats the real funky car?
  (cons %closed-marker% value))


; how bout methods??
; seems we might get handed something like (nfunction name (lambda (args)(declare stuff)(block name . body)))
; if method, instead of args we get (&method . args)


(defun eval-prep (form &optional name env (real-compile-if-error nil)(warn nil))
  (let (newenv disgusting-accessors-constant *eval-warnings*)
    (declare (special disgusting-accessors-constant *eval-warnings*))
    (cond ((consp form)
           (case (car form)
             (lambda)
             (nfunction
              (setq name (cadr form))
              (setq form (caddr form)))
             (function
              (setq form (cadr form)))
             (t (setq form `(lambda () ,form)))))
          (t (setq form `(lambda () ,form))))
    ; if env exists but isn't one of my biggies - extend it or copy it or something 
    (if (or real-compile-if-error warn)
      (multiple-value-bind
        (ignore err)
        (progn ;ignore-errors
           (setq newenv (munch-lambda form env name)))
        (declare (ignore ignore))
        (if err
          (progn
            (when warn
              (format *error-output* "Cannot step ~S because: ~A" name err)
              (when (not real-compile-if-error)(return-from eval-prep nil)))
            (cond ((and real-compile-if-error (typep err 'eval-cant-cope))
                   (return-from eval-prep
                     (compile-user-function form name env)))
                  (t (error err))))))
      (progn
        (setq newenv (munch-lambda form env name))))
    (let ((warnings (merge-compiler-warnings *eval-warnings*))
          (first t))
      (dolist (w warnings)
        (signal-compiler-warning w first nil nil nil t)
        (setq first nil)))
        
    (values
     (closure-def-compiled-form (evalenv-closure-def newenv))
     newenv)))
#||
(defun list-to-vector (list vect)
  (let ((n (/ (length vect) 2)))
    (dolist (x list)
      (uvset vect n x)
      (setq n (+ n 1)))
    vect))
||#

#||
(defun tc (env)
  (let ((form (evalenv-expanded-form env)) name xvars)
    (declare (special disgusting-accessors-constant))
    (when (typep form 'closure-def)
      (setq name (closure-def-name form))
      (setq xvars (closure-def-extra-vars form))
      (setq form (closure-def-expanded-form form)))
    (let* ((arglist (cadr form))
           (body (cddr form))
           (maxvp (evalenv-maxvp env))
           (names (evalenv-names env))
           (nargs (list-length names))
           (fudge 0)
           (arraysize (+ 1 maxvp))
           (ncv (list-length xvars))
           ;(g1 (gensym))
           (g2 (gensym))
           (g3 (gensym))
           first-arg
           def
           move-it
           xvar-names)
      ; names has closure-vars glommed on - arglist does not
      (when xvars
        (setq xvar-names (mapcar #'(lambda (e)(var-name e)) xvars))
        (setq arglist (nconc xvar-names arglist)))
      
      ; arg in arglist may not be same as names (proclaimed specials have aliases)
      (when (> nargs 0)
        (dolist (arg arglist)
          (when (not (memq arg '(&rest &optional &key &aux &allow-other-keys)))          ; AKA lambda-list-keywords ...
            (setq first-arg (cond ((not (consp arg)) arg)
                                  ((not (consp (car arg)))(car arg))
                                  (t (cadr (car arg)))))
            (return))))
      (when (or (evalenv-next-method env)(evalenv-next-method-with-args env))
        (setq arglist (cons '&method arglist))  ; need this?? - YES
        (setq fudge 1)
        (setq arraysize (1+ arraysize))
        (setq move-it `(;(setq barf0 (%cons-magic-next-method-arg (*%saved-method-var%*)))
                        (uvset ,g2 ,nargs (*%saved-method-var%*))
                        (uvset ,g2 ,(+ nargs  nargs) ',%method-var-name%))))
      ; compile appears to return the name if it got one not the def????
      ; and furthermore it makes the def be global which AINT what we want
      (setq def
            (compile-named-function 
             `(lambda ,arglist
                ;(declare (ignore ,@(nthcdr ncv names))) ; ??
                ,@(when disgusting-accessors-constant
                    ; make it be the first constant
                    `((old-lap-inline () (move.l ,disgusting-accessors-constant atemp0))))
                (let* ((,g2 (make-array ,(+ arraysize arraysize))) ; values & names
                       (,g3 (make-runtime-evalenv
                             nil
                             ,(1- (+ nargs fudge))
                             ,(1- arraysize)  ; not necessary - could look in the arrays
                             ,g2
                             nil
                             ,name)))
                  (declare (dynamic-extent  ,g2 ,g3))                  
                  ; get the stack to the value vector
                  ,@(when (neq nargs 0)
                      `((old-lap-inline ()
                          (lea (varg ,first-arg) atemp0)
                          (add.l ($ 4) atemp0)
                          (move.l ($ (* ,nargs 4)) nargs)
                          (move.l (varg ,g2) atemp1)
                          (add.l ($ $v_data) atemp1)
                          lp
                          (sub.l ($ 4) nargs)
                          (blt done)
                          (move.l -@atemp0 atemp1@+)
                          (bra lp)
                          done)))
                  ,@move-it
                  ,@(if xvars `((list-to-vector ',names ,g2))) ; not necessary today (except for closed vars)
                  (eval-lambda-body ',body ,g3)))
               (evalenv-name env) ; does it need the environment at this point - no
             nil nil (evalenv-form env) *save-local-symbols*))
        (let* ((bits (lfun-bits def))(nreq (ldb $lfbits-numreq bits)))
          (when xvars ; fix nrequired  nclosed
            (setq bits (dpb ncv $lfbits-numinh bits))
            (setq bits (dpb (- nreq ncv) $lfbits-numreq bits)))
          (setq bits (logior bits (evalenv-bits env)))
          #||
          (when (evalenv-next-method env)
            (setq bits (logior bits (ash 1 $lfbits-nextmeth-bit))))
          (when (evalenv-next-method-with-args env)
            (setq bits (logior bits (ash 1 $lfbits-nextmeth-with-args-bit))))
          ||#
          (setq bits (logior bits (%ilsl $lfbits-evaluated-bit 1)))
          (lfun-bits def bits))
      def)))
||#

#||
(defun tc (env)
  (let ((def (evalenv-closure-def env)) name xvars form)
    (declare (special disgusting-accessors-constant))
    (when (typep def 'closure-def)
      (setq name (closure-def-name def))
      (setq xvars (closure-def-extra-vars def))
      (setq form (closure-def-expanded-form def)))
    (let* ((arglist (cadr form))           
           (body (cddr form))
           (maxvp (evalenv-maxvp env))
           (names (evalenv-names env))
           (nargs (list-length names))
           (fudge 0)
           (arraysize (+ 1 maxvp))
           (ncv (list-length xvars))
           def
           warns
           move-it
           xvar-names)
      (declare (ignore-if-unused warns))
      ; names has closure-vars glommed on - arglist does not      
      (when xvars
        (setq xvar-names (mapcar #'(lambda (e)
                                     (declare (ignore e))
                                     (gensym))
                                 xvars))
        (setq arglist (append xvar-names arglist))
       ; this may have some nils in it to all0cate space for optional supplied-p's
        ; names for the compiler where we lied about closed names
        (setq names (append xvar-names (nthcdr ncv names)))
        ; store the real names in the values array
        (setq xvar-names (mapcar #'(lambda (e)
                                     (let ((name (var-name e)))
                                       (if (consp name)(var-name (car name)) name)))
                                 xvars)))
      #||
      (print (list 'tc name xvar-names (mapcar #'(lambda (e)
                                                   (let ((name (var-name e)))
                                                     (if (symbolp name) name
                                                         (var-name (car name)))))
                                                   xvars)
                   names  env))
      ||#
      ; arg in arglist may not be same as names (proclaimed specials have aliases)      
      (when (or (evalenv-next-method env)(evalenv-next-method-with-args env))
        (setq arglist (cons '&method arglist))  ; need this?? - YES
        (setq fudge 1)
        (setq arraysize (1+ arraysize))
        (setq move-it %method-var-name%))
      (let ((vp (1- (+ nargs fudge))))
        (multiple-value-setq (def warns)
          (compile-named-function 
           `(lambda ,arglist 
              ;(declare (ignore ,@(nthcdr ncv names))) ; ??
              ,@(when (and disgusting-accessors-constant (neq name (cadr disgusting-accessors-constant)))
                  ; make it be the first constant unless it will be anyway
                  `((lap-inline () 
                      (bra @foo)
                      (dc.l ,(cadr disgusting-accessors-constant))
                      @foo)))
              ,@names ; mention them so my rest args dont get nuked
              (lap ;lap-inline ()
                (jsr_subprim $sp-evalsetup)
                (dc.l ,name)
                (dc.w ,(ash arraysize -13)) (dc.w ,(ash arraysize 3)) ;(dc.l ,arraysize)  
                (dc.w ,(ash vp -13)) (dc.w ,(ash vp 3))                ;(dc.l ,(1- (+ nargs fudge)))
                (dc.w ,(ash nargs -13)) (dc.w ,(ash nargs 3))           ;(dc.l ,nargs)              
                (dc.l ,body)
                (dc.l ,xvar-names)
                (dc.l ,move-it)))
           (evalenv-name env)
           nil nil (evalenv-form env) *save-local-symbols*)))
      ;(when warns (mapcar #'warn warns))      
      (let* ((bits (lfun-bits def))(nreq (ldb $lfbits-numreq bits)))
        (when xvars ; fix nrequired  nclosed
          (setq bits (dpb ncv $lfbits-numinh bits))
          (setq bits (dpb (- nreq ncv) $lfbits-numreq bits)))
        (setq bits (logior bits (evalenv-bits env)))
        (setq bits (logior bits (%ilsl $lfbits-evaluated-bit 1)))
        (lfun-bits def bits))
      def)))
||#

#-ppc-target
(progn
; the third one - needs to set the ralph-bit if (%non-null-environment-p env)
(defun tc (env)
  (let ((def (evalenv-closure-def env)) name xvars form)
    (declare (special disgusting-accessors-constant))
    (when (typep def 'closure-def)
      (setq name (closure-def-name def))
      (setq xvars (closure-def-extra-vars def))
      (setq form (closure-def-expanded-form def)))
    (let* ((arglist (cadr form))           
           (body (cddr form))
           (maxvp (evalenv-maxvp env))
           ;(names (evalenv-names env))
           (nargs (list-length (evalenv-names env)))
           (fudge 0)
           (arraysize (+ 1 maxvp))
           (ncv (list-length xvars))
           def
           warns
           move-it
           xvar-names)
      (declare (ignore-if-unused warns))
      ; names has closure-vars glommed on - arglist does not
      (when xvars
        (setq xvar-names (mapcar #'(lambda (e)
                                     (declare (ignore e))
                                     (gensym))
                                 xvars))
       ; this may have some nils in it to all0cate space for optional supplied-p's
        ; I think this names thing is not used
        ;(setq names (append xvar-names (nthcdr ncv names)))
        ; store the real names in the values array
        (setq xvar-names (mapcar #'(lambda (e)
                                     (let ((name (var-name e)))
                                       (if (consp name)(var-name (car name)) name)))
                                 xvars)))
      #||
      (print (list 'tc name xvar-names (mapcar #'(lambda (e)
                                                   (let ((name (var-name e)))
                                                     (if (symbolp name) name
                                                         (var-name (car name)))))
                                                   xvars)
                   names  env))
      ||#
      ; arg in arglist may not be same as names (proclaimed specials have aliases)      
      (when (or (evalenv-next-method env)(evalenv-next-method-with-args env))
        ;(setq arglist (cons '&method arglist))  ; need this?? - YES - NO
        (setq fudge 1)
        (setq arraysize (1+ arraysize))
        (setq move-it 
              (let ((name (var-name (car (last (evalenv-variables env))))))
                (if (consp name)(var-name (car name)) name))))
      (let ((vp (1- (+ nargs fudge)))
            (fnentry (evalenv-fnentry env))
            (attr-bits (ash 1  $lfatr-symmap-bit))) ; saving form always????
        (let ((foo (memq '&aux arglist)))
          (when foo (setq vp (+ vp (list-length (cdr foo))))))
        (multiple-value-bind (imm-vector code-vector linkmap-vector lfun-bits)
                             (apply #'generate-fnentry-code
                                    arglist
                                    (+ ncv (car fnentry))
                                    (cdr fnentry))
          (when (%non-empty-environment-p (lexenv.parent-env env))
            (setq lfun-bits (logior lfun-bits (%ilsl $lfbits-nonnullenv-bit 1))))
          (setq def
                (generate-setup-code     
                 imm-vector code-vector linkmap-vector
                 disgusting-accessors-constant name arraysize vp nargs body xvar-names move-it (evalenv-form env)
                 (logior lfun-bits (evalenv-bits env)(%ilsl $lfbits-evaluated-bit 1))
                 (logior attr-bits (if (null name)(ash 1 $lfatr-noname-bit) 0))))))  ; what should the attributes be - where do the name and saved def go???
      def)))

(defun generate-setup-code (vimm vcode vmap
                                 dac name arraysize vp nargs body xnames move-it form
                                 bits attributes)
  (let ((pc (* 2 (length vcode)))(nimms (length vimm)))
    (flet ((push-immed (imm)
                       (vector-push-extend 0 vcode)
                       (vector-push-extend nimms vcode)
                       (vector-push-extend imm vimm)
                       (setq nimms (+ nimms 1))
                       (vector-push-extend pc vmap)
                       (vector-push-extend #.$lm_longimm vmap)
                       (setq pc (+ pc 4)))
           (push-long (n)
                      (vector-push-extend (ash n -13) vcode)
                      (vector-push-extend (ash n 3) vcode)
                      (setq pc (+ pc 4))))
      (declare (dynamic-extent #'push-immed #'push-long))
      (when (> pc 32000)(error "phooey"))
      (when (and dac (neq dac name))
        (vector-push-extend 24580 vcode) ; (bra over 4 bytes)
        (setq pc (+ pc 2))
        (push-immed dac))
      (vector-push-extend 20141 vcode)   ; jsr_subprim
      (vector-push-extend  #.$sp-evalsetup vcode)             ; the subprim
      (setq pc (+ pc 4))
      (push-immed name)
      (push-long arraysize)
      (push-long vp)
      (push-long nargs)
      (push-immed body)
      (push-immed xnames)
      (push-immed move-it)
      (push-immed (list 'function-lambda-expression form))
      (when name
        (push-immed name))
      (%make-lfun
       vimm
       vcode
       vmap
       bits
       attributes))))

(defun generate-fnentry-code (lambda-list nreq nopt initopt restp keyvect allowotherkeys restv-p)
  (let* ((code-vector (make-array 8 
                                 :element-type '(signed-byte 16)
                                 :adjustable t
                                 :fill-pointer 0))
         (imm-vector (make-array 8
                                 :element-type t
                                 :adjustable t
                                 :fill-pointer 0))
         (linkmap-vector (make-array 8
                                 :element-type '(signed-byte 16)
                                 :adjustable t
                                 :fill-pointer 0)))
    (labels ((gen-code (&rest words)
               (declare (dynamic-extent words))
               (dolist (w words)
                 (if w
                   (vector-push-extend (%word-to-int w) code-vector))))
             (gen-jsrA5 (subprim &rest words)
               (declare (dynamic-extent words))
               (apply #'gen-code $jsrA5 subprim words))
             (gen-immref (constant &optional instr)
               (when instr (gen-code instr))
               (let* ((immno (length imm-vector))
                      (pc (* 2 (length code-vector))))
                 (vector-push-extend pc linkmap-vector)
                 (vector-push-extend $lm_longimm linkmap-vector)
                 (vector-push-extend constant imm-vector)
                 (gen-code 0 immno))))
      (cond ((and (eql 0 nopt) (not (or restp keyvect)))
           ; Required only.
             (if (<= nreq 3)
               (gen-jsrA5
                (if (eql nreq 0)
                  $sp-noargs
                  (if (eql nreq 1)
                    $sp-one-arg-vpush
                    (if (eql nreq 2)
                      $sp-two-args-vpush
                      $sp-three-args-vpush))))
               (if (< (setq nreq (ash nreq 2)) 128)
                 (gen-code (logior #x7600 nreq) $jsra5 $sp-da-req-args-vpush)
                 (gen-jsrA5 $sp-n-req-args nreq))))
            ((not (or restp keyvect))
             (if initopt
               (gen-jsrA5 $sp-req-initopt (ash nreq 2) (ash nopt 2))
               (if (> (+ nreq nopt) 3)
                 (gen-jsrA5 $sp-req-opt (ash nreq 2) (ash nopt 2))
                 (gen-jsrA5
                  (if (eql 0 nreq)
                    (if (eql 1 nopt)
                      $sp-one-opt-arg-vpush
                      (if (eql 2 nopt)
                        $sp-two-opt-args-vpush
                        $sp-three-opt-args-vpush))
                    (if (eql 1 nreq)
                      (if (eql 1 nopt)
                        $sp-one-req-one-opt-vpush
                        $sp-one-req-two-opt-vpush)
                      $sp-two-req-one-opt-vpush))))))
            ((null keyvect)             ; &rest, but no &key.
             (if (eql 0 (+ nreq nopt))
               (gen-jsrA5 (if restv-p $sp-restv-arg $sp-rest-arg)) ; <<
               (if (eql 0 nopt)
                 (gen-jsrA5 (if restv-p $sp-n-req-restv $sp-n-req-rest) (ash nreq 2))
                 (gen-jsrA5 (if initopt 
                              (if restv-p $sp-n-req-initopt-restv $sp-n-req-initopt-rest)
                              (if restv-p $sp-n-req-opt-restv $sp-n-req-opt-rest))
                            (ash nreq 2) (ash nopt 2)))))
            (t                          ; &key
             (gen-immref keyvect #x227c)   ; move.l #keyvect,atemp1
             (if restp
               (if (eql 0 (+ nreq nopt))
                 (gen-jsrA5 (if restv-p $sp-restv-keys $sp-rest-keys))
                 (gen-jsrA5 (if (eql 0 nopt) 
                              $sp-req-rest-keys
                              (if initopt
                                (if restv-p $sp-req-initopt-restv-keys $sp-req-initopt-rest-keys)
                                (if restv-p $sp-req-opt-restv-keys $sp-req-opt-rest-keys)))
                            (ash nreq 2) (unless (eql 0 nopt) (ash nopt 2))))
               (gen-jsrA5 (if (eql 0 nopt) 
                            $sp-kreqkeys 
                            (if initopt $sp-req-initopt-keys $sp-req-opt-keys))
                          (ash nreq 2) (unless (eql 0 nopt) (ash nopt 2))))
             (gen-code (+ (ash (length keyvect) 2) (if allowotherkeys 1 0)))))
      (values imm-vector code-vector linkmap-vector (encode-lambda-list lambda-list)))))
) ; end -ppc-target

#+ppc-target

(progn
(defun interpreted-proto (&lexpr args)
  (let* ((env #(1))  ; 1st literal - watch out - dont call something lots of times or it becomes first lit
         (maxvp (evalenv-maxvp env))
         (arraysize (+ 1 maxvp))
         (runtime-env (%alloc-misc evalenv-runtime-size ppc::subtag-simple-vector nil))
         ; its twice as big cause vals come first, then names (whats the 1?)
         (values (%alloc-misc (* 2 arraysize) ppc::subtag-simple-vector nil))
         (nargs (list-length (evalenv-names env)))
         vp)
    (declare (dynamic-extent runtime-env))
    (declare (ignore nargs))
    (setq vp (evalenv-vp env))
    ;(setq vp (1- nargs))
    ; we really want (1- nargs) but that fails for call-next-method and next-method-p because
    ; :next-method-context is in names but is also counted as a closed var
    ;(if (memq (evalenv-name env) '(call-next-method next-method-p))
     ; (setq vp (1- vp)))    
    (setf (evalenv-parent-env runtime-env) (evalenv-parent-env env)) ; ??    
    ;(setf (evalenv-functions runtime-env) (evalenv-functions env))     ; list of (name type . body) type is 'function or 'macro
    ;(setf (evalenv-variables  runtime-env) (evalenv-variables env))    ; a list of var structures containing name etc.
    (setf (evalenv-vp runtime-env) vp)
    (setf (evalenv-maxvp runtime-env) maxvp)
    (setf (evalenv-values runtime-env) values)
    (let ((def (evalenv-closure-def env)) name xvars form)
      (when (typep def 'closure-def)
        (setq name (closure-def-name def))
        (setq xvars (closure-def-extra-vars def))
        (setq form (closure-def-expanded-form def)))
      (setf (evalenv-name runtime-env) name)
      (let* (;(arglist (cadr form))           
             (body (cddr form))
             ;(names (evalenv-names env))
             ;(nargs (list-length (evalenv-names env)))
             ;(fudge 0)
             (ncv (list-length xvars))
             (fnentry (evalenv-fnentry env))
             ;def
             ;move-it
             ;xvar-names
             )
        (apply #'process-supplied-args args values (+ ncv (car fnentry))(cdr fnentry))
        (incf (evalenv-vp runtime-env) ncv)  ; this shouldn't be necessary?
        (apply-evaluated-function body runtime-env)))))

(defun interpreted-method-proto (&method next-method-context &lexpr args)
  (let* ((env #(1))  ; 1st literal - watch out - dont call something lots of times or it becomes first lit
         (maxvp (evalenv-maxvp env))
         (fudge (if (or (evalenv-next-method env)(evalenv-next-method-with-args env)) 1 0))
         (arraysize (+ 1 1 maxvp))  ; 1 extra?
         (runtime-env (%alloc-misc evalenv-runtime-size ppc::subtag-simple-vector nil))
         ; its twice as big cause vals come first, then names (whats the 1?)
         (values (%alloc-misc (* 2 arraysize) ppc::subtag-simple-vector nil))
         (nargs (list-length (evalenv-names env)))
         vp)
    (declare (dynamic-extent runtime-env))
    (declare (ignore fudge nargs))
    ; also move magic from parent env to this env
    ;(setq vp (1- (+ nargs fudge)))
    (setq vp (evalenv-vp env))
    (setf (evalenv-parent-env runtime-env) (evalenv-parent-env env)) ; ??    
    ;(setf (evalenv-functions runtime-env) (evalenv-functions env))     ; list of (name type . body) type is 'function or 'macro
    ;(setf (evalenv-variables  runtime-env) (evalenv-variables env))    ; a list of var structures containing name etc.
    (setf (evalenv-vp runtime-env) vp)
    (setf (evalenv-maxvp runtime-env) maxvp)
    (setf (evalenv-values runtime-env) values)
    (let ((def (evalenv-closure-def env)) name xvars form)
      (when (typep def 'closure-def)
        (setq name (closure-def-name def))
        (setq xvars (closure-def-extra-vars def))
        (setq form (closure-def-expanded-form def)))
      (setf (evalenv-name runtime-env) name)
      (let* (;(arglist (cadr form))           
             (body (cddr form))
             ;(names (evalenv-names env))
             ;(nargs (list-length (evalenv-names env)))
             ;(fudge 0)
             (ncv (list-length xvars))
             (fnentry (evalenv-fnentry env))
             ;def
             ;move-it
             ;xvar-names
             )                
        ;(if next-method-context (print next-method-context))
        (apply #'process-supplied-args args values (+ ncv (car fnentry))(cdr fnentry))
        (incf (evalenv-vp runtime-env) ncv)   ; this shouldn't be necessary?
        ; shouldn't this be first?
        (setf (uvref values (evalenv-vp runtime-env)) next-method-context)
        ;(describe values)
        (apply-evaluated-function body runtime-env)))))

; this returns the function that actually gets executed
(defun tc (env)
  (let ((foo (copy-uvector (if (or (evalenv-next-method env)(evalenv-next-method-with-args env))
                             (fboundp 'interpreted-method-proto)
                             (fboundp 'interpreted-proto)))))
    ; a poor man's closure
    (setf (uvref foo 1) env)
    (let* ((def (evalenv-closure-def env))
           (bits (evalenv-bits env))
           (fnentry (evalenv-fnentry env))
           name xvars)
      (setq bits (dpb (car fnentry) $lfbits-numreq bits))
      (setq bits (dpb (cadr fnentry) $lfbits-numopt bits))
      (if (fourth fnentry) (setq bits (logior bits (%ilsl $lfbits-rest-bit 1))))
      (let ((keys (fifth fnentry)))
        (when keys
          (setq bits (logior bits (%ilsl $lfbits-keys-bit 1)))))
      (when (typep def 'closure-def)
        (setq name (closure-def-name def))
        (setq xvars (closure-def-extra-vars def))     
        (when xvars ; fix nrequired  nclosed
          (setq bits (dpb (length xvars)  $lfbits-numinh bits))))
      (lfun-name foo name)
      (lfun-bits foo (logior bits (%ilsl $lfbits-evaluated-bit 1)))
      foo)))

; nreq includes closed 
(defun process-supplied-args (args values nreq nopt optional-init restp keyvect weird restvp)
  (declare (ignore restvp))
  (let* ((nargs (%lexpr-count args))
         (nreq+nopt (+ nreq nopt)))
    (if (> nreq nargs) (error "Too few args"))
    (if (and (or (null keyvect)(eq 0 (uvsize keyvect)))
             (null restp)
             (> nargs nreq+nopt))
      (error "Too many args"))
    (dotimes (i (min (+ nreq nopt) nargs))
      (setf (uvref values i)(%lexpr-ref args nargs i)))
    (when restp
      (let ((rest (collect-lexpr-args args nreq+nopt)))
        (setf (uvref values nreq+nopt) rest)))     
    (when (and keyvect (neq 0 (uvsize keyvect)) (> nargs nreq+nopt))
      (let* ((vorg (+ nreq+nopt (if restp 1 0)))
             bad-key bad-key-p)
        (if (oddp (- nargs nreq+nopt)) (error "Odd number of keyword args"))
        (do* ((i nreq+nopt (+ i 2)))
             ((= i nargs))
          (let* ((key (%lexpr-ref args nargs i))
                 (pos (vector-position key keyvect)))
            (if (eq key :allow-other-keys)
              (setq weird t)
              (if pos
                (when (not (uvref values (+ vorg pos pos 1))) 
                ; apparently supposed to stick with the first one
                  (setf (uvref values (+ vorg pos pos)) (%lexpr-ref args nargs (1+ i)))
                  (setf (uvref values (+ vorg pos pos 1)) t))              
                (unless bad-key-p
                  (setq bad-key key
                        bad-key-p t))))))
        (when (and bad-key-p (not weird))
          (error "Ilegal keyword arg ~S" bad-key))))
    (when optional-init ; put supplied-p vals after keys
      (let* ((r (if restp 1 0))
            (org (+ nreq+nopt r (* 2 (length keyvect)))))
        (dotimes (i (min nopt (- nargs nreq)))
            (setf (uvref values (+ org i)) t))))
    nargs))  
) ; end +ppc-target
    


(defun compiled-for-evaluation (def)
  (when (lfunp def)
    (let ((bits (lfun-bits def)))
      (logbitp $lfbits-evaluated-bit bits))))

(defun lfun-lambda (def)
  (let ((info (%lfun-info def)))
    (getf info 'function-lambda-expression)))

#||
(defun set-lfun-lambda (def)  ; this won't work if info is nil
  (let ((info (%lfun-info def)))
    (if (and (consp info)(not (getf info 'function-lambda-expression)))
      (rplacd (last info) (list 'function-lambda-expression idef))
||#
      
  

(defun lfun-processed-lambda (def)
  (let ((info (%lfun-info def)))
    (getf info 'function-processed-lambda-expression)))

; is it evil to bash this "constant"
(defun set-lfun-processed-lambda (def idef)
  (let ((info (%lfun-info def)))
    (if (and (consp info)(not (getf info 'function-processed-lambda-expression)))
      (rplacd (last info) (list 'function-processed-lambda-expression idef)))))
  
#||
; this should be elsewhere or nowhere
(defun set-closure-function (fun newfun)
  (while (and (functionp fun)  (not (compiled-function-p fun)))
    (setq fun (%nth-immediate (%lfun-vector fun) 0))
    (when (vectorp fun)
      (setf (svref fun 0) newfun)))
  newfun)

(defsetf closure-function set-closure-function)


(defun ev-compile-for-evaluation (env)
  (let ((thing (evalenv-expanded-form env)))
    (when (not (ev-compiled-for-evaluation-p thing))
      (cond ((typep thing 'closure-def)
             (setf (closure-def-compiled-form thing) (tc env)))
            (t (error "Huh"))))
    (evalenv-expanded-form env)))
||#

(defun ev-compiled-for-evaluation-p (thing)
  ; thing is form or closure-def - only closure-def this week
  (cond ((typep thing 'closure-def)
         (closure-def-compiled-form thing))))

; returns a new environment!
(defun munch-lambda (form env &optional name (newenv (make-evalenv env)))
  (let ((arglist (cadr form))
        (body (cddr form))
        specials ignores
       method-var-name)
    (declare (special disgusting-accessors-constant))
    (setf (evalenv-form newenv) form)
    (setf (evalenv-name newenv) name)
    (multiple-value-bind (body decls doc) (parse-body body newenv T)
      (declare (ignore doc))
      (multiple-value-setq (decls ignores) (munch-decls decls newenv))
      (when decls 
        (setf (evalenv-vdecls newenv) decls)
        (setq specials (cdr (cadar decls))))
      (when (eq (car arglist) '&method)
        (setf (evalenv-method-p newenv) t) 
        (setq method-var-name (cadr arglist))
        (setq arglist (cddr arglist)) ; because verify-lambda-list abhors &method
        #-PPC-TARGET
        (let ((thing (third (car body))))
          ; deduce whether this is an accessor method in which case the
          ; slot name must be the first constant in the function - TRULY GROSS!
          (when  (and (consp thing) (cddr thing) (cdddr thing) (null (cddddr thing)))
            (setq thing (fourth thing))
            (when (consp thing)
              (case (car thing)
                (slot-value (setq disgusting-accessors-constant (third thing)))
                (setf
                 (setq thing (second thing))
                 (when (and (consp thing)(eq (car thing) 'slot-value))
                   (setq disgusting-accessors-constant (third thing)))))
              (cond ((not (constantp disgusting-accessors-constant))
                     (setq disgusting-accessors-constant nil))
                    (t (setq disgusting-accessors-constant (cadr disgusting-accessors-constant)))))))
        )
      (multiple-value-bind (arglist initcode newvars nspecials)
                           (evp-arglist arglist newenv specials method-var-name)
        (when method-var-name
          (let ((nargs (list-length (evalenv-names newenv))))
            (fudge-indices newenv 1 nargs)
            (ev-inc-vp newenv)
            ; note - the magic var is on variables but not on names
            (let ((info (make-symbol-info method-var-name nargs newenv)))
              (setf (evalenv-variables newenv)(nconc (evalenv-variables newenv) (list info)))))
          (setf (evalenv-next-method newenv) t
                (evalenv-next-method-with-args newenv) t))
        ; initcode is already munched  - so it better not call next method
        (when ignores (ev-ignore ignores newenv))
        (let* ((newform (munch-form 
                         (if (and (consp body) (null (cdr body))
                                  (consp (car body))(eq (caar body) 'block))
                           (car body)
                           `(block ,name ,@body))
                         newenv))
               (def (evalenv-closure-def newenv)))
          (dolist (info newvars)
            (when (not (symbol-referenced-p info))
              (eval-warn :unused newenv (var-name info)))) ;"Lexical variable ~S in ~A is unused."
          (setf (closure-def-expanded-form def)
                (if (> nspecials 0)
                  `(lambda ,arglist (,(fexprp '%with-specials) ,nspecials ,@initcode ,newform))
                  `(lambda ,arglist ,@initcode ,newform)))
          (when (not (assq newenv (evalenv-frefs (env-top-env newenv))))
            ; i.e. we call nobody local
            (make-closure-def-from-env newenv name))
          (finish-frefs newenv)
          ))
        newenv)))

(defun ev-ignore (lst env)
  (dolist (ign (car lst))
    (note-symbol-ignored ign env))
  (dolist (ign (cdr lst))
    (note-symbol-ignored ign env t)))
  


(defun make-closure-def-from-env (newenv &optional (name (evalenv-name newenv)))
  (let* ((def (evalenv-closure-def newenv))
         (xvars  (closure-def-extra-vars def)))
      (setf (closure-def-name def) name)
      (setf (closure-def-form def) (evalenv-form newenv))
    ; glom closed-used on the front of names
    (when (and (closure-def-expanded-form def)               
               ;(not (ev-pred newenv name))
               (not (ev-compiled-for-evaluation-p def)))
      (when xvars
        (let ((ncv (list-length xvars)))
          (setf (evalenv-names newenv)
                (nconc (mapcar #'(lambda (info)
                                   (let ((name (var-name info)))
                                     (if (consp name)(var-name (car name)) name)))
                               xvars)
                       (evalenv-names newenv)))
          ; fudge maxvp
          (setf (evalenv-maxvp newenv)(+ ncv (evalenv-maxvp newenv)))
          ; fudge the indices
          (fudge-indices newenv ncv)))
      (setf (closure-def-compiled-form def) (tc newenv))    
      newenv)))

#||
(defun ev-pred (caller-env name)
  (declare (ignore name))
  ; are there any calls from caller-env to functions bound here or higher
  (let ((env caller-env))
    (while (and env (neq (%svref env 0) 'definition-environment))
      (let ((fns (evalenv-functions env)))
        (when fns       
          ;(print-em env)
          (dolist (caller-alist (evalenv-frefs env))
            ;(print (evalenv-name (car caller-alist)))
            (when (eq caller-env (car caller-alist))
              (return-from ev-pred t)))))
      (setq env (evalenv-parent-env env)))))
    
||#  
  
         

(defun fudge-indices (env ncv &optional above)
  (dolist (info (evalenv-binders env))
    (let ((idx (var-bits info)))      
      (when (and (fixnump idx)(or (not above)(>= (ldb (byte 16 0) idx) above)))
        (setq idx (+ ncv idx))
        (setf (var-bits info) idx)
        (let ((rest (symbol-referencer info)))
          (when (consp rest)
            (rplaca (cddr rest) idx)))))))
  ;(print (mapcar #'(lambda (i)(list (var-name i)(var-bits i))) (evalenv-binders env))))
  

; remember - if any optional has an init form all get supplied-p
; order is opt-1 opt-2 suppl-1 suppl-2 (actually optional supplied-p's go after keys)
; whereas keys have key-1 suppl-1 key-2 suppl-2

(defun copy-arglist (arglist)
  (let ((res nil))
    (dolist (arg arglist)
      (if (atom arg)
        (push arg res)
        (push (copy-list arg) res)))
    (nreverse res)))

(defun evp-arglist (args env &optional specials method-var-name)
  ; figure out size of locals array(s)
  (declare (resident))
  (multiple-value-bind (ok required tail) (verify-lambda-list args)
    (if (not ok)(eval-error $xbadLambdaList env args)) ;"Bad lambda list  ~S." args))
    (let ((newvars ())
          (names ())
          (osp-names ())
          (initcode ())
          (vp (evalenv-vp env))
          vp-after-args
          (nspecials 0)
          (nreq 0)
          restp
          restv-p
          keyp    ; in case (.. &key)
          keyvect
          allow-other-p
          (nopt 0)
          optional-init)
      (let (state optional init-p proclaimed-special-p)
        (when required
          (let (thing)
            (dolist (arg required)
              (setq nreq (1+ nreq))
              (push arg names)
              (setq vp (+ vp 1))
              (setq thing (make-symbol-info arg vp env))
              (when (or (memq arg specials)(and (proclaimed-special-p arg)(setq proclaimed-special-p t)))
                (setq specials (delq arg specials))
                (note-symbol-special thing nspecials env)
                (setq nspecials (1+ nspecials)))
              (push thing  newvars))
            (when newvars  ;special-bind
              (setq newvars (nreverse newvars))              
              (push (cons (fexprp '%special-bind)  newvars) initcode)))
          (ev-inc-vp env vp)
          (setf (evalenv-variables env)(append newvars (evalenv-variables env))))
        (multiple-value-setq (nopt optional-init)
          (optional-supplied-p tail))
        (setq vp-after-args (ev-opt-sup-org tail vp))
        (when (> nopt 0)
          (setq optional vp-after-args)
          (when optional-init (setq vp-after-args (+ nopt vp-after-args))))
        (let ((foo (memq '&aux tail)))
          (when foo (setq vp-after-args (+ vp-after-args (list-length (cdr foo))))))
        (dolist (arg tail)
          (case arg
            ((&rest)
             (setq state '&rest)
             (setq restp t))
            (&aux
             (setq state arg)
             (when (and  optional optional-init)
               (setq names (nconc osp-names names))
               (ev-inc-vp env (setq vp optional))))
            (&key (setq keyp t)(setq state arg))
            (&optional
             (setq state arg))
            (&allow-other-keys
             (setq allow-other-p t))
            (t (ev-inc-vp env (setq vp (+ vp 1)))
               (let (name initform supplied-p info sinfo bound)
                 (cond ((consp arg)
                        (setq name (car arg) initform (cadr arg) supplied-p (caddr arg)))
                       (t (setq name arg)))
                 (when (eq state '&key)
                   (cond ((consp name)
                          (push (car name) keyvect)
                          (setq name (cadr name)))
                         (t (push (make-keyword name) keyvect))))
                 (when initform (setq init-p t))
                 (when (neq state '&aux)(push name names))
                 (setq info (make-symbol-info name vp env))
                 (when (or (memq name specials)
                           (and (proclaimed-special-p name)(setq proclaimed-special-p t)))
                   (when (or (eq state '&key)(eq state '&aux) optional)
                   (setq specials (delq name specials))
                   (note-symbol-special info nspecials env)
                   (setq nspecials (1+ nspecials))))
                 (when (and (not (eq state '&aux))
                            (or (not (null initform)) supplied-p))
                   (setq sinfo (make-symbol-info supplied-p (+ 1 vp) env))
                   (when (and supplied-p 
                              (or (memq supplied-p specials)
                                  (and (proclaimed-special-p supplied-p)(setq proclaimed-special-p t))))
                     ; u gotta be nuts to have a special supplied-p
                     (note-symbol-special sinfo nspecials env)
                     (setq nspecials (1+ nspecials)))
                   (when (not (null initform))
                     (setq bound t)
                     (push `(,(fexprp '%init&bind)
                             ,info
                             ,(let ((old-vp (evalenv-vp env)))
                                (setf (evalenv-vp env) vp-after-args)
                                (prog1 
                                  (munch-form initform env)
                                  (setf (evalenv-vp env) (setq vp old-vp))))
                             ,sinfo)
                           initcode)))
                 (case state
                  (&aux
                     (when initform
                       (setq bound t)
                       (push `(,(fexprp '%init&bind) ,info ,(munch-form initform env)) initcode)))                       
                  (&key
                   (push supplied-p names)
                   ; always leave room for supplied-p
                   (ev-inc-vp env (setq vp (+ vp 1))))
                  ((&rest))
                  (&optional
                   (setq optional (1+ optional))
                   (push supplied-p osp-names)
                   (when (or (not (null initform)) supplied-p)
                     (let ((r2 (symbol-referencer sinfo)))
                       (if (consp r2) (rplaca (cddr r2) optional))
                       (setf (var-bits sinfo)(dpb optional (byte 16 0) (var-bits sinfo))))))
                  (t (error "Shouldnt 3")))
                 (push info (evalenv-variables env))
                 (push info newvars)
                 (when supplied-p
                   (push sinfo (evalenv-variables env))
                   (push sinfo newvars))
                 (when (not bound)
                   (push (list  (fexprp '%special-bind) info) initcode)
                   (when sinfo (push (list  (fexprp '%special-bind) sinfo) initcode)))))))                 
        (when (and (neq state '&aux) optional optional-init)
          (setq names (nconc osp-names names))
          (ev-inc-vp env (setq vp optional))) ; +/- 1 
        (setf (evalenv-names env)(nreverse names))
        (when specials
          (dolist (sp specials) ; these are the guys who are declared special but not bound here
            (push (make-symbol-info sp t env)(evalenv-variables env)))
          (ev-inc-vp env (+ vp (list-length specials)))
          (push `(,(fexprp '%special-declare) ,(if method-var-name (1+ vp) vp) ,@specials) initcode))
        (setq initcode (nreverse initcode))
        ;(when (> nspecials 0)
        ;  (push `(,(fexprp '%special-bind) ,nspecials) initcode))
        (when (or init-p proclaimed-special-p)
          ; nuke init forms so compiler wont compile them
          ; give proclaimed specials aliases so compiler wont bind em
          (setq args (copy-arglist args))
          (do ((rest args (cdr rest)))
              ((null rest))
            (let ((arg (car rest)))              
              (cond ((symbolp arg)
                     (when (and (not (memq arg '(&rest &aux &optional &key &allow-other-keys)))
                                (proclaimed-special-p arg))
                     (rplaca rest (gensym))))
                    ((consp arg) ; lie about arg names for specials
                     (let ((it (if (consp (car arg))(cadr (car arg)) (car arg)))) ; also (caddr)
                       (when (proclaimed-special-p it)
                         (rplaca arg (gensym))))
                     (let ((it (caddr arg)))
                       (when (and it (proclaimed-special-p it))
                         (setf (caddr arg)(gensym))))
                     (if (not (null (cadr arg)))
                       (rplaca (cdr arg) nil)))))))
        (setf (evalenv-fnentry env)
              (list nreq nopt optional-init restp 
                    (when keyp (if keyvect (coerce (nreverse keyvect) 'vector) (vector)))
                    (or allow-other-p (and keyp method-var-name))
                    restv-p))
        (when allow-other-p 
          (setf (evalenv-bits env) (logior (evalenv-bits env)(%ilsl $lfbits-aok-bit 1))))
        (values args initcode newvars nspecials)))))

; returns # of optionals and t if any have supplied-p or non-nil initform
(defun optional-supplied-p (tail)
  (let ((n 0) p)
    (when (eq (car tail) '&optional)
      (dolist (thing (cdr tail))
        (case thing
          ((&key &aux &rest)
           (return (values n p)))
          (t (when (and (consp thing)
                        (or (cddr thing) ; supplied-p
                            (cadr thing))) ; non-nil initform
               (setq p t))
             (setq n (+ n 1))))))
    (values n p)))
                       
    

(defun ev-opt-sup-org (tail vp)
  ; tail may start with &optional - count 1 for &opt, 1 for &rest, 2 for each key, quit at &aux
  (let ((n vp) key rest)
    (dolist (thing tail)
      (case thing
        (&optional)
        (&key (setq key t))
        ((&rest) (setq rest t))
        (&aux (return n))
        (&allow-other-keys)
        (t (cond (rest (setq rest nil)
                       (setq n (+ n 1)))
                 (key (setq n (+ n 2)))
                 (t (setq n (+ n 1)))))))
     n))

(defun munch-decls (decls env)
  (let ((specials ())(ignores ())(ignore-if-uu ()))
    (dolist (decl decls)
      (dolist (spec (cdr decl))
        (when (consp spec)
          (case (car spec)
            (special
             (dolist (sym (cdr spec))
               (when (and (not (memq sym specials))
                          (not (proclaimed-special-p sym)))
                 (push sym specials))))
            (ignore
             (setq ignores (append (cdr spec) ignores)))
            ((ignore-if-unused ignorable)
             (setq ignore-if-uu (append (cdr spec) ignore-if-uu)))
            (type 
             (when (not (type-specifier-p (second spec) env))
               (eval-warn :unknown-declaration env spec)))
            (t (when (not (or (memq (car spec) *nx-known-declarations*)
                               (type-specifier-p (car spec) env)))
                 (eval-warn :unknown-declaration env spec)))))))
    ; we bash specials so it must be newly consed    
    (values 
     (when specials 
       `((declare (special ,@specials))))
     (if (or ignores ignore-if-uu)(cons ignores ignore-if-uu)))))

; callers are responsible for pulling out the decls
(defun munch-body (forms env &optional tagbody)  
  (let ((copied nil))
    (let ((cforms forms)(i 0))
      (while (consp cforms)
        (let* ((form (car cforms))(newform form))
          (cond ((or (consp form)(and (null tagbody)(symbolp form))) 
                 (setq newform (munch-form form env))))
          (when (neq newform form)
            (when (not copied)
              (setq copied t)
              (setq forms (copy-list forms))
              (setq cforms (nthcdr i forms)))
            (rplaca cforms newform))
          (setq i (1+ i))
          (setq cforms (cdr cforms)))))
  forms))

#|| compiler special forms
(TAGBODY MAKE-LIST MULTIPLE-VALUE-LIST IF EVAL-WHEN MACROLET GO
 OR PROG1 LET* LET MULTIPLE-VALUE-CALL PROGV PROGN THE LOCALLY FLET
 QUOTE MULTIPLE-VALUE-PROG1 DECLARE LABELS SETQ UNWIND-PROTECT FUNCTION
 SYMBOL-MACROLET MULTIPLE-VALUE-BIND RETURN-FROM BLOCK THROW CATCH COMPILER-LET
 NFUNCTION WITHOUT-INTERRUPTS WITH-PORT LAP OLD-LAP-INLINE %DEFUN LAP-INLINE OLD-LAP
 MACRO-BIND %PRIMITIVE %FUNCTION
 WITH-INVISIBLE-REFERENCES %STRUCT-REF %STRUCT-SET %NEWGOTAG DEBIND)

||# 
(defvar *special-forms-eval-understands* ; which are not fexprp
  '(declare LOAD-TIME-VALUE NFUNCTION WITH-INVISIBLE-REFERENCES MACRO-BIND DEBIND))

(defun munch-form (form env)
  (declare (resident))
  (let ((newform form) fn vref-p)
      (cond ;((constantp form))
            ((consp form)
             (setq fn (%car form))
             (cond
              ((consp fn)
               (case (%car fn) 
                 (lambda ; vanilla lambda
                   (setq newform (munch-vanilla-lambda form env)))
                 ((%local-ref %closure-ref %local-fref %special-ref %special-bind %special-declare))
                 (t (eval-error $XNOTsymlam env (car form))))) ;"~S is not a symbol or lambda expression"
              ((symbolp fn)
               (setq newform
                   (case fn
                       (function (munch-function form env))
                       (nfunction (munch-nfunction form env))
                       (setq (munch-setq form env))
                       (let (munch-let form env))
                       (with-invisible-references
                         (if (cdddr form)
                           (munch-form (cons 'progn (cddr form)) env)
                           (munch-form (caddr form) env)))
                       (let*  (munch-let* form env))
                       (quote (verify-arg-count form 1 1) form)
                       (the
                        (let ((newthing (munch-form (caddr form) env)))
                          (if (eq newthing (caddr form))
                            form
                            (list fn (cadr form) newthing))))                       
                       (eval-when
                         (let ((newbody (munch-body (cddr form) env)))
                           (if (eq newbody (cddr form))
                             form
                             (list* fn (cadr form) newbody))))
                       (block (munch-block form env))
                       (return-from (munch-return-from form env))
                       (tagbody
                         (munch-tagbody form env))
                       (go (munch-go form env))
                       (macrolet (munch-macrolet form env))
                       (flet  (munch-flet form env))
                       (labels (munch-labels form env))
                       (fbind (munch-fbind form env))
                       (fbind-2 (munch-fbind-2 form env))
                       (symbol-macrolet (munch-symbol-macrolet form env))
                       (compiler-let (munch-compiler-let form env))
                       ((with-added-methods)
                        (error "~S not implemented" fn))
                       (load-time-value
                        (let ((foo (caddr form)))                          
                          (when (and foo (neq foo t))(report-bad-arg foo '(member t nil)))
                          (eval (cadr form))))
                       ((progn progv catch throw unwind-protect without-interrupts)
                         (let ((newbody (munch-body (cdr form) env)))
                           (if (eq newbody (cdr form))
                             form
                             (cons fn newbody))))                       
                       (if (munch-if form env))
                       (declare
                        ; guys who expect decls are supposed to weed them out
                        (eval-error $XDeclPos env form)) ;"Declaration ~S in unexpected position"
                       (locally (munch-locally form env))
                       (multiple-value-call (munch-mv-call form env))
                       (multiple-value-prog1 (munch-mv-prog1 form env))
                       ; below be brain death
                       (macro-bind (munch-debind `(debind ,(cadr form) (cdr ,(caddr form)) ,@(cdddr form)) env))
                       (debind (munch-debind form env))
                       (lambda 
                         #-bccl (warn "Do you really want to call a function named LAMBDA")
                         ; above is for me - dont release it
                         (munch-regular-form form env))
                       ;((call-next-method next-method-p) (munch-call-next-method form env))
                       (t  (cond ((and (special-form-p fn)
                                       (not 
                                        (or (fexprp fn)
                                            (memq fn *special-forms-eval-understands*))))
                                  (eval-cant-cope "Interpreter can't deal with ~S" form))
                                 (t (munch-regular-form form env)))))))
              (t (eval-error  $xnotsymlam env (car form))))) ;"~S is not a symbol or lambda expression" 
            ((symbolp form)
             ; forget not symbol-macros - ok I remembered             
             (let ((info (ev-symbol-info form env)) what)
               (cond 
                (info 
                 (cond ((not (symbol-special-p info))
                        (setq what (add-symbol-referencer info env)))
                       (t (setq what (list (fexprp '%special-ref) form)))))  ;                
                (t (let (bindenv)
                     (multiple-value-setq (info bindenv) (ev-lexical-binding form env))
                     (cond (info
                            (cond ((not (symbol-special-p info))
                                   (setq what (add-symbol-referencer
                                               (ev-add-closed-used-2 env info bindenv)
                                               env
                                               '%closure-ref)))
                                  (t (setq what (list (fexprp '%special-ref) form)))))
                           ((or (keywordp form)(null form)(eq form t)))
                           (t (let ((sym-mac #+ppc-target (find-global-symbol-macro form)
                                       #-ppc-target nil))
                                (if sym-mac
                                  (setq info sym-mac)
                                  (progn
                                    (when (not (or (proclaimed-special-p form)(constantp form)))
                                      (eval-warn :special env form)) ;"Undeclared free variable ~S in ~A." form (ev-env-name env)))
                                    (setq what (list (fexprp '%special-ref) form))))))))))
               (when (or what info)
                 (setq newform
                       (cond ((and info (symbol-macro-def-p info))
                              ; its a symbol macro
                              (munch-form (symbol-macro-def info) env))
                             (what (setq vref-p t) what)
                             (t form)))))))
      (when (and (not (constantp newform))(consp newform))
        (let ((fexpr (fexprp (car newform))))
          (when fexpr
            (when (eq newform form)(setq newform (copy-list form)))
            (rplaca newform fexpr))))
      (when (neq form newform)
        (let ((map *source-mapping-table*))
          ; dont store %local-ref and %closure-ref because we know what they were
          (when (and map (not vref-p))
            (setf (gethash newform map) form)))) 
      newform))

; where car is a symbol, not special-form

(defun munch-regular-form (form env)
  (let ((fn (car form)) (newform form))
    (multiple-value-bind (info  fref) (ev-lexical-fbinding fn env)      
      (cond ((or (and info (eq (cadr info) 'macro))
                 (and (not info)(macro-function fn nil)))
             (setq newform (macroexpand form env)) 
             (setq newform (munch-form newform env)))
            (t ;(setq newform (munch-vanilla form env))               
               (cond (info  ; its locally bound
                      (cond (fref  ; and its (function ..)
                             (setq newform (munch-vanilla form env))
                             (when (eq newform form)
                               (setq newform (copy-list newform)))
                             (rplaca newform fref))
                            (t (setq newform (munch-form (list* 'funcall (cadr info) (cdr form)) env)))))
                     (t (setq newform (munch-vanilla form env))
                        (ev-check-undefined fn env))))))
    newform))

(defun ev-check-undefined (fn env)
  (declare (ignore-if-unused fn env))
  (when nil ; dont do it this week
    (flet ((me-p (name env)
                 (while (and env (> (uvsize env) 8))
                   (when (eq name (evalenv-name env))
                     (return-from me-p t))
                   (setq env (evalenv-parent-env env)))))
      (when (and (not (fboundp fn))
                 (not (me-p fn env)))
        (eval-warn :undefined-function env fn)))))
    



(defun munch-setq (form env)
  (let ((result ())(rest (cdr form)) car)
    (while (consp rest)
      (when (not (consp (cdr rest)))
        (eval-error $xoddsetq form)) ;"Odd number of forms to setq in ~S"
      (setq car (car rest))
      (cond ((constantp car)
             (eval-error $xsetconstant env car)) ;"Can't setq constant ~S"
            ((or (symbolp car)
                 (and (consp car)(consp (car car))(memq (caar car) '(%local-ref %closure-ref %special-ref))))
             (let* ((thing (munch-form car env)) ; like maybe its a symbol macro
                    (val (munch-form (cadr rest) env)))                      
               (cond ((or (and (consp thing)
                               (consp (car thing))
                               (memq (caar thing) '(%local-ref %closure-ref %special-ref)))
                          (symbolp thing))
                      (push (list (fexprp 'setq) thing val) result))
                     (t (push (munch-form (list 'setf thing val) env) result)))))
             (t (eval-error $xbadsetq env car))) ;"Illegal arg to setq ~S"
      (setq rest (cddr rest)))
    (cond ((null (cdr result))
           (setq result (car result))
           (if (equal result form) form result))
          (t (cons 'progn (nreverse result))))))

; testing
#||
(setq *compile-definitions* nil)
(setq *compile-definitions* t)
(defun boo (x)
  (generic-flet ((blob (b a)
                   (declare (fixnum a))
                   (:documentation "asdf")
                   (:method ((b stream) a) (print a) b)))
    (blob x 3)))

(defun blob (a &optional (b (let ((baz 3)) baz))) b)

(defun boo ()
  (flet ((foo (a)(list a)))
    #'foo))

(defun bb (x y)
  (labels ((f (i)
              (labels ((g (j)
                          (list j i)))
                (list (h 4)(g x))))
           (h (l)
               (list l y)))
    (list (f x)(h y))))

(defun aa (y z)
  (labels ((f (i)
              (print (list 'f i y))
              (if (consp i)(g (cdr i)) y))
           (g (j)
              (print (list 'g j z)) 
              (if (consp j)(f (cdr j)) z)))
    (list (f z)(g y))))

(defun cc (x y)
  (labels ((l (a)
              (labels ((f ()
                          (g y))
                       (g (d)
                          (m d)))
                (g y)))
           (m (e)
              (list e x)))
    (list (l x)(m y))))

(defun ff (x y)
  (labels ((m (a)
              (cons a x))
           (n (b)
              (labels ((m (c)
                          (list c x)))
              (m b))))
    (list (n x)(m y))))

    
    

(defun dd (x y)
  (labels
    ((f ()
        (flet ((mumble ()
                       (g 2 3)))
          (mumble)))
     (g (j k)
        (list j k x y)))
    (g x y)))

(defun ee (y z)
  (labels ((f (i)
              (print (list 'f i y))
              (if (consp i)(g (cdr i)) y))
           (g (j)
              (print (list 'g j z)) 
              (if (consp j)(f (cdr j)) z)))
    ((lambda (x y)(list (f y)(g x))) y z)))

       


(progn
  (defvar b nil)
  (defvar d nil)
  (defun zz ()
    (equal
     ((lambda (&optional (a 2 b)(c 3 d) &rest x)
        (list a b c d x))
      6 3 8)
     '(6 T 3 T (8)))))

(defun blob (a b c d)
  (list a b c d))

(defun frob (&optional (a b b)(c 3 d) &rest x)
  (list a b c d x))

(defun zz ()
  (tagbody
    (multiple-value-bind
      (a b)
      (block bar
        (unwind-protect
          (progn
            (values 1 2)
            (go baz))
          (return-from bar 10)))
      (print a)
      (print b))
    baz))

(defun blob (x y)
  (declare (special yyy x))
  (list x yyy y))

(defun blip (a b)
  (declare (special a))
  (let ((x a)(y b))
    (declare (special yyy x))
    (list x a b yyy)))

(defun puke (a &optional (b 3) &rest dp &key (puke b) barf)
  (list a b puke dp))

(locally (declare (special yyy))
         (print yyy))

; this and below fail in the beta candidate
(defun boo (a)
  (macrolet ((foo (&optional ((a b) '(1 2)) &rest (c d))
                  `(list ,a ,b ,c ,d)))
    (foo (5 6) 7 8)))

; this appears to cause death (in compiler) - s.b.fixed soon
(defun bob (a)
  (macrolet ((baz (a)
                  (labels ((frob ()
                               (gob 7))
                           (gob (x)
                                (if (neq x 7) (frob))))
                    `(,a ,(gob 6)))))
    (baz list)))
                    

(debind (&optional ((a b) '(1 2)) &rest (c d e f) &key y z)'((1 2) :y 3 :z 4)
   (list a b c d e f y z))

(debind (&optional ((a b) '(1 2)) &rest c &key y z)'((1 2) :y 3 :z 4)
   (list a b c y z))

(debind (&key ((secret (p q))) amount) '(secret (4 5) :amount 100)
    (list p q amount))

(debind (a &optional ((b c) '(1 2)) &rest d &key ((secret (e f)) '(5 6)) z)
        '(1 (2 3) secret (7 8) :z 9)
  (list a b c d e f z))

(defun zz ()(EQUAL (LET* ((V1 #(0 1 2 3 4))
                          (V2 (MAKE-ARRAY 3
                                          :DISPLACED-TO V1
                                          :DISPLACED-INDEX-OFFSET 2)))
                         (COERCE V2 'LIST))
                   '(2 3 4)))

(defun zz () (equal 
           ((lambda (x y &aux (a (car x)) (b 2) c)(list x y a b c))
            '(1) 2)
           ((lambda (x y )(let* ((a (car x)) (b 2) c)(list x y a b c)))
            '(1) 2)))

(defun zz ()(equal (symbol-macrolet ((pollyanna 'goody))
                  (list pollyanna (let ((pollyanna 'two-shoes)) pollyanna)))
                `(goody two-shoes)))

(defun zz ()(symbol-macrolet ((pollyanna 'goody))
              ;(declare (special yyy))
              (list pollyanna (let ((pollyanna 'two-shoes)) pollyanna) yyy)))

(defun zz () (EQUAL (MULTIPLE-VALUE-LIST (VALUES)) NIL))

(defun zz () (equal ((lambda (&optional (a 2 b)(c 3 d) &rest x)
                      (list a b c d x)))
                    '(2 nil 3 nil nil)))

(defun zz () (equal ((lambda (&optional (a 2 b)(c 3 d) &rest x)
                       (list a b c d x)) 6)
                    '(6 t 3 nil nil)))

(defun zz () (equal ((lambda (&key ((secret password) nil) amount)
                       (list password amount)) :amount 100)
                    '(nil 100)))

(defun zz (&key ((secret password) nil) amount)
  (list password amount))


(defun zz () (EQUAL (LET ((OK NIL))
                         (DO ()
                             (TRUE OK)
                           (DECLARE (SPECIAL OK))))
                       nil))
(PROGN
  (SETQ X '(100 200 300) Y '(1 2 3) Z '(A B C D E F))
  (DEFVAR G )
  (defun zz ()
    (EQUAL (LET ((G NIL)) (MAPC #'(LAMBDA (&REST A) (PUSH A G)) X)
                (NREVERSE G))
           '((100) (200) (300)))))
(progn
  (defvar xxx)
  (defvar yyy)
  (defvar zzz)
  (defun zz ()
    (EQUAL (MULTIPLE-VALUE-BIND (Xxx Yyy Zzz) '(1 2 3) (LIST Xxx Yyy Zzz))
           '((1 2 3) NIL NIL))))


  (setq class-name
                (defclass c ()
                  ((slot-1)
                   (slot-2 :initform "slot-2")
                   (slot-3 :initarg :slot-3)
                   (slot-4 :allocation :class)
                   (slot-5 :reader r-slot-5)
                   ;(slot-6 :writer w-slot-6)
                   ;(slot-7 :accessor a-slot-7)
                   ))
                sub-class-name
                (defclass sub-c (c)
                  ((sub-slot-5)))
                sister-to-c
                (defclass b ()
                  ((slot-b1)))
                i1
                (make-instance 'c :slot-3 9)
                i2
                (make-instance 'c))
; the slot-name of the reader method for r-slot-5 is wrong
; little wonder - below is the definition of slot-name
;(defmethod slot-name ((m standard-accessor-method))
;  (values (%nth-immediate (%lfun-vector (%method-function m)) 0)))
; Writer (LAMBDA (&METHOD #:C #:NEW-VALUE)
;            (DECLARE (IGNORE-IF-UNUSED #:C)) NIL 
;            (BLOCK W-SLOT-6 (SETF (SLOT-VALUE #:C 'SLOT-6) #:NEW-VALUE)))
; Reader (LAMBDA (&METHOD #:C) 
;          (DECLARE (IGNORE-IF-UNUSED #:C)) NIL 
;          (BLOCK R-SLOT-5 (SLOT-VALUE #:C 'SLOT-5)))

(let (x) #'(lambda (y)(list x y)))



(progn
  (setf (slot-value i1 'slot-5) 'foo)
  (r-slot-5 i1))
(defun bbb ()(r-slot-5 i1))

(setq *compile-definitions* nil)

(setq *compile-definitions* t)

(eval-prep  '(lambda (x y)
                   (flet ((mumble (z)(foo z x)))
                     (flet ((g (w)(list (mumble y) w)))
                       (g 3)))))


(eval-prep  '(lambda (a b c)
                   (zap #'(lambda (x)
                           (mumble x a b)
                           #'(lambda (y)
                               (mumble x y a b c))))))

(eval-prep '(lambda (a)
              (block blob
                (block baz
                  (return-from blob a)))))

(eval-prep '(lambda (a)
              (tagbody
                (flet ((mumble (zz)(if (> zz a)(go exit))))
                  (mumble 5))
                (print 3)
                exit (print "I exit"))))

(eval-prep '(lambda (a)
              (tagbody
                (funcall
                 #'(lambda (c)
                     (funcall #'(lambda (d) (if a (go exit))
                                 (print d)) 7))
                 6)
                exit (print :exit))))
(setq yuck
      (let ((y 6))
        (defmethod f :around ((x foo))
          (format t "(method f :around (foo)): ~s~%" x)
          (print y)
          (buzz #'call-next-method)
          (call-next-method))))

(defun bb (a x &optional (d (+ a 2))
                       (b (let ((c (* a a d)))
                            (* c 4))))
              (declare (special a b))
              b)
                             

(eval-prep  '(lambda (a b c)
                   (labels ((f (x)(g x a))(g (y z)(mumble y  x z b))) (f c))))

(defun bb (x y)
  (labels ((f (i)
              (labels ((g (j)
                          (list j i)))
                (list (h 4)(g x))))
           (h (l)
               (list l y)))
    (list (f x)(h y))))  ; (((y y)(x x))(y y))

(defun bb (y z)
  (labels ((f (i)
              (if (consp i)(g (cdr i)) y))
           (g (j)
              (if (consp j)(f (cdr j)) z)))
    (list (f z)(g y)))) ; (y z)


(munch-form '(let (a b)
               (LET* ((alist (MULTIPLE-VALUE-LIST (BLOB)))
                    (first (POP alist)) (second (POP alist)))
               (SETQ B second A first))) (make-evalenv))

 

(eval-prep '(let* ((a 1) (b a)(c (+ a b)))(print c)))

(eval-prep '(lambda (a b)
              (let ((c (barf)))
                (flet ((fum (x)(+ x a c)))(fum 3)))
              (flet ((foo (y)(= y b))) (foo 4))))              


 

||# 



(defun munch-vanilla (form env)
  ; j random function call - yum
  (let ((copied nil))
    (let ((cform (cdr form))(n 1))
      (while (consp cform)
        (let ((a (car cform)))
            (let ((newa (munch-form a env)))
              (when (neq newa a)
                (when (not copied)
                  (setq form (copy-list form))
                  (setq cform (nthcdr n form))
                  (setq copied t))
                (rplaca cform newa))))
        (setq cform (cdr cform))
        (setq n (+ n 1)))))
  form)

(defun munch-name-check (name env)
  (when (not (symbolp name))(eval-error  $xnotsym env name)) ;"~S is not a symbol."
  (when (constantp name)(eval-error $xisconstant env name))  ; "~S is a constant."
  name)

(defun munch-let (form env)
  (let* ((ivp (evalenv-vp env))
         (ilocals (evalenv-variables env))
         (idecls (evalenv-vdecls env))
         (vp ivp)
         (arglist (cadr form))
         (cargs arglist)
         (n 0)
         newvars
         newargs
         newbody
         special-bind
         (nspecials 0)
         specials
         ignores)
    (multiple-value-bind (body decls)(parse-body (cddr form) env nil)
      (multiple-value-setq (decls ignores) (munch-decls decls env))
      (when decls
        (setf (evalenv-vdecls env) (nconc decls idecls))
        (setq specials (cdr (cadar decls))))
      (while (consp cargs)        
        (let ((bnd (car cargs)) name val info newval)
          (if (consp bnd) 
            (progn
              (setq name (car bnd) val (cadr bnd))
              (when (cddr bnd)(eval-error  $xbadinit env bnd))) ; "Bad initialization form: ~S" bnd))) ;
            (setq name bnd val nil))
          (munch-name-check name env)
          (when val (setq newval (munch-form (cadr bnd) env)))
          (ev-inc-vp env (setq vp (+ 1 vp)))
          (setq info (make-symbol-info name vp env))
          (when (or (memq name specials)(proclaimed-special-p name))
            (note-symbol-special info nspecials env)
            (setq nspecials (1+ nspecials))
            (setq specials (delq name specials)))
          (push info newvars)
          (push (list info newval) newargs)
          (when (neq (evalenv-vp env) vp)
            (error "Interpreter stack ~S is confused" env)))          
        (setq cargs (cdr cargs))
        (setq n (+ n 1)))
      (when newvars (setq newvars (nreverse newvars))(setq newargs (nreverse newargs)))
      (setf (evalenv-variables env)(append newvars ilocals))
      (when specials
        (dolist (sp specials)
          (push (make-symbol-info  sp t env) (evalenv-variables env)))
        (ev-inc-vp env (+ vp (list-length specials))))
      (when ignores (ev-ignore ignores env))
      (setq newbody (munch-body body env))
      (dolist (info newvars)
        (when (not (symbol-referenced-p info))
          (eval-warn :unused env (var-name info))))
      (when (> nspecials 0)
        (push nspecials newargs))
      (setf (evalenv-vp env) ivp 
              (evalenv-variables env) ilocals
              (evalenv-vdecls env) idecls))
    (if specials (push `(,(fexprp '%special-declare) ,(+ ivp n) ,@specials) newbody))    
    `(let ,newargs ,@special-bind  ,@newbody)))


(defun munch-symbol-macrolet (form env)
  (let ((oldvars (evalenv-variables env))
        (ivp (evalenv-vp env))
        (idecls (evalenv-vdecls env))
        (newvars ())
        specials ignores)
    (multiple-value-bind (body decls)(parse-body (cddr form) env nil)
      (multiple-value-setq (decls ignores) (munch-decls decls env))
      (when decls
        (setf (evalenv-vdecls env)(nconc decls idecls))
        (setq specials (cdr (cadar decls))))
      (dolist (arg (cadr form))
        (let ((name (car arg)))
          (when (not (symbolp name))(eval-error $xnotsym env name)) ;"~S is not a symbol" name)) 
          (when (or (memq name specials)
                    (proclaimed-special-p name)) ; Is this correct?
            (eval-error $Xsmacspec env name)) ;"Symbol macro ~S is declared or proclaimed special"
          (when (cddr arg)(eval-error $x2manyargs env arg)) ;"Too many arguments in ~S"
          (push (make-symbol-macro-info (car arg) (cadr arg)) newvars))) ; huh - wrong fix it
      (setq newvars (nreverse newvars))
      (setf (evalenv-variables env) (append newvars oldvars))
      (when specials
        (dolist (sp specials)
          (push (make-symbol-info sp t env) (evalenv-variables env)))
        (setq specials `((,(fexprp '%special-declare) ,ivp ,@specials))))
      (when ignores (ev-ignore ignores env))
      (ev-inc-vp env (+ ivp (list-length specials)))   ; not sure whether these need to be on the runtime "stack"
      
      ; Can symbol-macrolettd vars be special? NO
      (prog1  `(symbol-macrolet ,newvars ,@specials . ,(munch-body body env))
        (setf (evalenv-vp env) ivp)
        (setf (evalenv-variables env) oldvars
              (evalenv-vdecls env) idecls)))))
      
; this guy has to deal with the decls - not let body
(defun munch-let* (form env)
  (let* ((ivp (evalenv-vp env))
         (ilocals (evalenv-variables env))
         (idecls (evalenv-vdecls env))
         (vp ivp)
         (arglist (cadr form))
         (newargs ())
         newbody
         specials
         (nspecials 0)
         ignores)
    (multiple-value-bind (body decls)(parse-body (cddr form) env nil)
      (multiple-value-setq (decls ignores) (munch-decls decls env))
      (when decls
        (setf (evalenv-vdecls env) (nconc decls idecls))
        (setq specials (cdr (cadar decls))))
      (dolist (bnd arglist)
        (let (name val info)
          (if (consp bnd) 
            (progn
              (setq name (car bnd) val (cadr bnd))
              (when (cddr bnd)(eval-error $xbadinit env bnd))) ;"Bad initialization form: ~S"
            (setq name bnd val nil))
          (munch-name-check name env)
          (when val (setq val (munch-form val env)))
          (ev-inc-vp env (setq vp (+ 1 vp)))
          (setq info (make-symbol-info name vp env))
          (when (or (proclaimed-special-p name)
                    (memq name specials))
            (setq specials (delq name specials))
            (note-symbol-special info nspecials env)
            (setq nspecials (1+ nspecials)))
          (push info (evalenv-variables env))
          (push (list info val) newargs)  ; pass the whole info thing as the name!
          (when (neq (evalenv-vp env) vp)
            (error "Interpreter stack ~S is confused" env))))
      (setq newargs (nreverse newargs))
      (when specials
        (dolist (sp specials)
          (push (make-symbol-info sp t env) (evalenv-variables env)))
        (ev-inc-vp env (+ vp (list-length specials)))
        (setq specials (list `(,(fexprp '%special-declare) ,vp ,@specials))))
      (when ignores (ev-ignore ignores env))
      (setq newbody (munch-body body env))
      (dolist (binding newargs)
          (when (not (symbol-referenced-p (car binding)))
            (eval-warn :unused env (var-name (car binding)))))
      (when (> nspecials 0) (push nspecials newargs))
      (prog1 `(let* ,newargs ,@specials ,@newbody)
        (setf (evalenv-vp env) ivp 
              (evalenv-variables env) ilocals
              (evalenv-vdecls env) idecls)))))

(defun munch-locally (form env)
  (let ((ivars (evalenv-variables env))
        (idecls (evalenv-vdecls env))
        (vp (evalenv-vp env))
        newvars
        specials
        ignores)
    (multiple-value-bind (body decls)(parse-body (cdr form) env nil)
      (multiple-value-setq (decls ignores) (munch-decls decls env))  ; might put some specials on vars
      (when decls
        (setf (evalenv-vdecls env) (nconc decls idecls))
        (setq specials (cdr (cadar decls)))
        (when ignores (ev-ignore ignores env))
        (when specials
          (dolist (svar specials)
            (push (make-symbol-info svar t env) newvars))
          (ev-inc-vp  env (+ vp (list-length specials)))
          (setq specials `((,(fexprp '%special-declare) ,vp ,@specials)))
          (setf (evalenv-variables env)(nconc newvars ivars))))
      (let ((newbody (munch-body body env)))
        (when (or decls (neq newbody body))
          (setq form `(locally  ,@specials ,@newbody)))
        (setf (evalenv-variables env) ivars
              (evalenv-vdecls env) idecls
              (evalenv-vp env) vp)
        form))))
  

(defun munch-macrolet (form env)
  (let ((old-functions (evalenv-functions env))
        (idecls (evalenv-vdecls env))
        (morefns ()))
    (multiple-value-bind (body decls)(parse-body (cddr form) env T)
      (setq decls (munch-decls decls env))
      (when decls
        (setf (evalenv-vdecls env) (nconc decls idecls)))
      (dolist (fn (cadr form))
        (let ((name (car fn)))
          (multiple-value-bind (lambda-form doc)                             
                               (parse-macro-1 name (cadr fn)(cddr fn) env)            
            (declare (ignore doc)) ;  - where does doc go?
            (let* ((newenv (make-evalenv (make-barrier env)))
                   (newdef (evalenv-closure-def newenv)))
              (setf (evalenv-form newenv) lambda-form)
              (munch-lambda lambda-form env name newenv)
              (when nil ;(or (closure-def-extra-vars newdef) (macrolet-fn-check newenv))
                (error "Local macro ~S cannot refer to variables, blocks, tags, ~%or functions in the enclosing environment" name))
              (push `(,name macro . ,(closure-def-compiled-form newdef)) morefns)))))
      (setq morefns (nreverse morefns))
      (setf (evalenv-functions env)(append morefns old-functions))
      (prog1 `(macrolet ,morefns ,@(munch-body body env))
        ; keep the macros for eval in stepper
        (setf (evalenv-vdecls env) idecls)
        (setf (evalenv-functions env) old-functions)))))

#||
(defun macrolet-error () ; compiler breaks this into 3 cases (and I need env and name)
  (error "Local macro cannot refer to variables, blocks, tags, ~%or functions in the enclosing environment"))


; make sure it doesnt call any "higher" lexical fns - make this work too
(defun macrolet-fn-check (env)
  (let* ((topenv (env-top-env env))
         (frefs (evalenv-frefs topenv)))
    (when frefs
      (let ((caller-alist (assq env frefs)))
        (when caller-alist
          (dolist (called-thing (cdr caller-alist))
            (let ((called-def (caddr called-thing)))
              (when (and (typep called-def 'closure-def)
                         (closure-def-name called-def)
                         (null (closure-def-compiled-form called-def)))
                (return t)))))))))
||#
            


(defun munch-tagbody (form env)
  (let* ((ivp (evalenv-vp env))
         (ivars (evalenv-variables env))
         (vp (1+ ivp))
         info)
    ; below fails if body contains a macro that expands into a tag
    ; but the compiler doesnt like it either
    (ev-inc-vp env)
    (setq info (ev-add-tagbody vp env))    
    (do ((b (cdr form) (cdr b)))
        ((atom b))
      (let ((e (car b)))
        (when (or (integerp e)(symbolp e))
          (ev-add-tag b info env))))
    (let ((newbody (munch-body (cdr form) env T)))
      (dolist (pair (cdddr (symbol-referencer info)))
        (let ((tag (car pair)))
          (rplacd pair (cdr (memq tag newbody)))))
      (setf (evalenv-vp env) ivp 
            (evalenv-variables env) ivars)
      (list* 'tagbody info newbody))))

 
(defun munch-go (form env)
  (let ((tag (cadr form)) info tag&body)
    (multiple-value-setq (info tag&body) (ev-find-tag tag env))
    (when (not info)
      (eval-error $xnotag env tag)) ;"Can't find tag ~S"
    `(go ,info ,@tag&body)))

(defun munch-block (form env)  
  (let* ((ivp (evalenv-vp env))
         (ivars (evalenv-variables env))
         (name (cadr form))
         info)
    (when (null (symbolp name))(eval-error $xnotsym env name)) ; "~s is not a symbol"
    (ev-inc-vp env)
    (setq info (ev-add-block name (1+ ivp) env))
    (let ((newbody (munch-body (cddr form) env)))
      (setf (evalenv-vp env) ivp 
            (evalenv-variables env) ivars)
      (list* 'block (var-name info) newbody))))

(defun munch-return-from (form env)
  (let ((name (cadr form)) info)
    (when (null (symbolp name))(eval-error $xnotsym env name)) ;"~s is not a symbol" name)) ; 
    (when (null (setq info (ev-find-block name env)))
      (eval-error $xnoblock env name)) ;"Can't find block ~S" name)) ; 
    (let ((newthing (munch-form (caddr form) env)))
        (list 'return-from (var-decls info) newthing))))

(defun munch-compiler-let (form env)
  (let ((let-list (cadr form))
        (vars ()))
    (dolist (bnd let-list)
      (let ((name (if (consp bnd)(%car bnd) bnd)))
        (munch-name-check name env)
        (push name vars)))
    (munch-let `(let ,(cadr form) (declare (special ,@(nreverse vars))) ,@(cddr form)) env)))


; in order that defs only live in one place, the arglist passed to %eval
; looks like ((name 'function . lambda args def)) instead of (name args . def)
 
(defun munch-labels (form env)
  (let ((old-functions (evalenv-functions env))
        (idecls (evalenv-vdecls env))
        (morefns ())
        newenvs)
    (multiple-value-bind (body decls)(parse-body (cddr form) env T)
      (setq decls (munch-decls decls env))
      (when decls
        (setf (evalenv-vdecls env) (nconc decls idecls)))
      (dolist (fn (cadr form))
        (let ((name (car fn))
              (newdef (cons 'lambda (cdr fn)))
              (newenv (make-evalenv env)))
          (when (not (symbolp name))(eval-error $xnotsym env name)) ;"~S is not a symbol"
          (let ((cdef (evalenv-closure-def newenv)))
            (setf (evalenv-form newenv) newdef)
            (setf (evalenv-name newenv) name)
            (push `(,name function . ,cdef) morefns)
            (push newenv newenvs))))
      (setq morefns (nreverse morefns))
      (setq newenvs (nreverse newenvs))
      (setf (evalenv-functions env)(append morefns old-functions))
      (dolist (newenv newenvs)
        (let* ((form (evalenv-form newenv))
               (name (evalenv-name newenv)))
          (munch-lambda form env name newenv)))
      (prog1
        `(labels ,morefns ,@(munch-body  body env))
        ;(print-em env)
        (setf (evalenv-vdecls env) idecls)
        (setf (evalenv-functions env) old-functions)))))

; does its job when exiting the topmost environment
(defun finish-frefs (env)
  ; first make sure everybody gets required closed vars
  (when (and env (neq (%svref env 0) 'definition-environment)
             (> (uvsize env) 8))            
    (let ((frefs (evalenv-frefs env)))
      (when (consp frefs)
        (loop
          (let (any)
            (dolist (caller-alist frefs)
              (dolist (called-thing (cdr caller-alist))                
                (when (add-closed-vars (car caller-alist) (car (cddr called-thing)))
                  (setq any t))))
            (when (null any)(return))))        
        ; now make the closure mappings
        (dolist (caller-alist frefs)
          ;(when (eq caller-alist stop)(return))
          (dolist (called-thing (cdr caller-alist))
            (let* ((def (car (cddr called-thing)))
                   (xvars (make-local-fref-sub def (car caller-alist))))
              ;(print (%address-of (cdr called-thing)))
              (rplacd (cddr called-thing) xvars))))
        ; then compile em - gets all the indices right
        (dolist (caller-alist frefs)
          (make-closure-def-from-env (car caller-alist)(evalenv-name (car caller-alist))))
        (dolist (x frefs)
          (when t 
            (dolist (called-thing (cdr x))              
              (let* ((def (caddr called-thing))
                     (xvars (cdddr called-thing))
                     (compdef (closure-def-compiled-form def)))
                (if compdef
                  (progn
                    (rplaca (cddr called-thing) compdef)
                    (mapc #'(lambda (var)
                              (let ((name (var-name var)))
                                (when (consp name)
                                  (setf (var-name var)(var-name (car name))))))
                          xvars))
                  (break "maybe shouldnt"))))))))))

    

; return t if any new ones get added - caller gets used of called
(defun add-closed-vars (caller-env called-def)
  ; thing is (name %local-fref cdef)
  (let* ((used-by-called (closure-def-extra-vars called-def))
         any)
      (dolist (var used-by-called)
        (let* ((name (var-name var))
               (real-used (car name))
               (bindenv (cdr name)))
          (when (neq bindenv caller-env)
            (when (nth-value 1 (ev-add-closed-used-2  caller-env real-used bindenv))
              (setq any t)))))
      any))
  
    
#||
(defun print-em (env)
  (flet ((p1 (refs)
             (print (mapcar #'(lambda (thing)
                                (list (evalenv-name (car thing))                           
                                      (mapcar #'(lambda (inner)
                                                  (car inner))
                                              (cdr thing))))
                            refs))))
    
  (print (list 'frefs (evalenv-name env)))
  (p1 (evalenv-frefs env))))
||#



(defun munch-flet (form env)
  (let ((old-functions (evalenv-functions env))
        (idecls (evalenv-vdecls env))
        (morefns ()))
    (multiple-value-bind (body decls)(parse-body (cddr form) env T)
      (setq decls (munch-decls decls env))
      (when decls
        (setf (evalenv-vdecls env) (nconc decls idecls)))
      (dolist (fn (cadr form))
        (let ((name (car fn))
              (newform (cons 'lambda (cdr fn)))
              (newenv (make-evalenv env)))
          (when (not (symbolp name))(eval-error  $xnotsym newenv name)) ;"~S is not a symbol" name)) ;
          (let ((cdef (evalenv-closure-def newenv)))
            (setf (evalenv-form newenv) newform)
            (munch-lambda newform env name newenv)
            (setf (evalenv-name newenv) name)
            (push `(,name function . ,cdef) morefns))))
      (setq morefns (nreverse morefns))
      (setf (evalenv-functions env)(append morefns old-functions))
      (prog1 
        `(flet ,morefns ,@(munch-body  body env))
        (setf (evalenv-vdecls env) idecls)
        (setf (evalenv-functions env) old-functions)))))

(defun munch-fbind (form env)
  (let (letlist fbindlist ignorelist)
    (multiple-value-bind (body decls)(parse-body (cddr form) env T)
    (dolist (bind (cadr form))
      (let ((name (car bind))
            (val (cadr bind))
            (let-sym (gensym)))
        (when (not (symbolp name))(eval-error  $xnotsym env name)) ;"~S is not a symbol" name))
        (push (list let-sym val) letlist)
        (push let-sym ignorelist)
        (push (list name let-sym) fbindlist)))
    (munch-form `(let ,letlist
                   ,@decls
                   (declare (ignore-if-unused ,@ignorelist))
                   (fbind-2 ,fbindlist
                            ,@body))
                env))))

(defun munch-fbind-2 (form env)
  (let ((old-functions (evalenv-functions env))
        (morefns (cadr form)))
    (setf (evalenv-functions env) (append morefns old-functions))
    (prog1 `(progn ,@(munch-body (cddr form) env))
      (setf (evalenv-functions env) old-functions))))


(defun munch-nfunction (form env)
  (verify-arg-count form 2 2)
  (let ((name (cadr form)) (fn (caddr form)))
    (cond ((and (consp fn)(eq (car fn) 'lambda))
           (make-local-fref (list* name 'function fn) env))
          (t (eval-error $xbadLambda env fn))))) ; "Illegal function ~S" fn))))) ; 

(defun munch-function (form env)
  (verify-arg-count form 1 1)
  (let ((fn (cadr form)))
    (cond ((symbolp fn)
           (multiple-value-bind (info fref) (ev-lexical-fbinding fn env)
             (when (and info (eq (cadr info) 'macro))
               (eval-error  $XFuncLexMacro env fn)) ;"FUNCTION can't reference lexically defined macro ~S" fn)) ; $XFuncLexMacro
             (cond (info
                    (cond (fref fref)
                          (t (cadr info))))
                   (t (ev-check-undefined fn env)
                      form))))
          ((consp fn)
           (case (car fn)
             (lambda (make-local-fref (list* nil 'function fn) env))
             (setf form)
             (t (eval-error $xBadLambda env fn))))
          (t (eval-error $xBadLambda  env fn)))))

; should we turn this into (funcall (%local-fref ...) 3 5) ??
(defun munch-vanilla-lambda (form env)
  ; vanilla ((lambda (a b) ..) 3 5)
  (let ((fn (make-local-fref (list* nil 'function (car form)) env))
        (args ()))
    (let ()
      (dolist (arg (cdr form))
        (push (munch-form arg env) args))
      (list* fn (nreverse args)))))

; called iff fn is not locally bound i.e. (function (lambda .. ))
; or ((lambda (a b) ...) 3 5) 
(defun make-local-fref (info env)
  (let ((def (cddr info))(name (car info)))
    (let* ((newenv (make-evalenv env))
           (reffer (ev-stash-lexical-fref env nil (evalenv-closure-def newenv))))
      (munch-lambda def env name newenv)
      reffer)))


(defun make-local-fref-sub (def caller-env)
  ; env is that of caller - figure out what caller needs in order to call def
  (when (typep def 'closure-def)
    (add-closed-vars caller-env def)
      (let ((extra-vars  (closure-def-extra-vars def)) to-from)
        (dolist (to-info extra-vars)
          ; where the vars that called needs reside in caller env
          (let* ((funny-name (var-name to-info))
                 (var-used (car funny-name))
                 (bindenv (cdr funny-name))
                 from-info)
            (cond ((eq bindenv caller-env)
                   (setq from-info var-used))
                  (t (setq from-info (find-closed-var var-used caller-env))))
            (if from-info (push from-info to-from))))
        #||
        (print (list (closure-def-name def)(or (evalenv-name caller-env) caller-env)
                     (mapcar #'(lambda (i)
                                 (let ((name (var-name i)))
                                   (list (if (consp name)(var-name (car name)) name)(var-bits i))))
                             to-from))) ||#        
        (setq to-from (nreverse to-from)))))

(defun ev-env-name (env) 
    ; for error messages - try to find a name
    (let ((env env) name)
      (while (and env (neq (%svref env 0) 'definition-environment)
                  (> (uvsize env) 8))   ; yuck
        (when (setq name (evalenv-name env))
          (return-from ev-env-name name))
        (setq env (evalenv-parent-env env)))
      "an anonymous lambda form"))
      

(defun munch-if (form env)
  (debind (test true &optional false)(cdr form)
    (let ((ntest (munch-form test env))
          (ntrue (munch-form true env))
          (nfalse (munch-form false env)))
      (if (and (eq test ntest)
               (eq true ntrue)
               (eq false nfalse))
        form
        (list 'if ntest ntrue nfalse)))))

(defun munch-mv-call (form env)  
  (let ((newfn (munch-form (cadr form) env))
         newargs)
    (setq newargs (munch-body (cddr form) env))
    (if  (or (neq newfn (cadr form))
             (neq newargs (cddr form)))
      `(multiple-value-call ,newfn ,@newargs)
      form)))

(defun munch-mv-prog1 (form env)
  (let ((forms (cdr form))
        (copied nil)
        (n 1)
        newform)
    (while forms
      (setq newform (munch-form (car forms) env))
      (when (neq newform (car forms))
        (when (not copied)
          (setq copied t)
          (setq form (copy-list form))
          (setq forms (nthcdr n form)))
        (rplaca forms newform))
      (setq forms (cdr forms)))
    form))

#||
; should be an error if we aint in a method - how can we know?
; We dont care if this is called when it shouldn't be
(defun note-call-next-method (form env)
  (let ((fn (car form))(args (cdr form)))
    (when  (evalenv-method-p env)
        (when (not (or (evalenv-next-method env)(evalenv-next-method-with-args env)))
          (let ((nargs (list-length (evalenv-names env))))
            (fudge-indices env 1 nargs)
            (ev-inc-vp env)
            ; note - the magic var is on variables but not on names
            (let ((info (make-symbol-info %method-var-name% nargs env)))
              (setf (evalenv-variables env)(nconc (evalenv-variables env) (list info)))))))
        (if args 
          (setf (evalenv-next-method-with-args env) t)
          (setf (evalenv-next-method env) t))))
||#

#||
; no error, no count
(defun my-butlast (list)
  (when (consp list)
    (let (it tail)
      (do ((l list (cdr l)))
          ((not (consp (cdr l))) it)
        (declare (list l))
        (let ((newtail (list (car l))))
          (cond (tail (rplacd (the cons tail) newtail))
                (t (setq it newtail)))
          (setq tail newtail))))))
||#

; macro-bind wants a function to throw at &whole - feex it - done
(defun munch-debind (form env)
  (declare (resident))
  (let ((arglist (cadr form))
        (thing (caddr form))
        (body (cdddr form))
        oldthing
        result)
    (multiple-value-bind 
      (ok required tail resttail keytail auxtail copy whole struct)
      (verify-lambda-list arglist t t)
      (if (not ok)(eval-error $xbadLambdaList env arglist)) ;"Bad lambda list  ~S~%." arglist)) ; $xbadLambdaList        
      (setq arglist copy)   ; has dot replaced by &rest, &whole removed, &environment removed
      (when (and whole (not (constantp thing)))
        (setq oldthing thing)
        (setq thing (gensym)))
      (when auxtail ; get rid of these
        (let ((auxlen (length auxtail)))
          (setq resttail (butlast resttail auxlen))
          (setq tail (butlast tail auxlen))
          (setq arglist (butlast arglist auxlen))
          (setq keytail (butlast keytail auxlen))
          (setq body
                `((let* ,(cdr auxtail)
                    ,@body)))))
      (let ()
        (cond 
         ((not struct)
          (let ((foo (memq '&body arglist)))
                (when foo (rplaca foo '&rest)))
          ; verify-lambda-list abhors &body
          (if (and resttail (not keytail)) ; rest, no keys
            (setq result
                  (debind-maybe-dotted arglist required tail resttail body thing))
            (setq result  `(apply #'(lambda ,arglist ,@body)
                               ,thing))))
         (t (prog ((args arglist)(state 'required) arg sofar)
              LP 
              (cond ((consp args)
                     (setq arg (car args)))
                    (t (return)))
              (cond 
               ((symbolp arg)
                (case arg
                  (&aux (return))
                  (&allow-other-keys)
                  (&body (setq state (setq arg '&rest)))
                  ((&key &rest &optional)
                   (setq state arg))))
               ((consp arg)
                (case state
                  (&rest
                   (let ((rest (gensym)))
                     (setq sofar (nreverse sofar))                     
                     (setq result
                           (debind-do-it
                            `(,@sofar ,rest)
                            `((debind ,arg ,rest
                                ,@(munch-db-inner (cdr args) rest body)))
                            thing)))
                     (return))
                  (&key
                   (when (and (consp (car arg))(consp (cadr (car arg))))
                     (let* ((keykey (caar arg))
                            (keygen (gensym))
                            (key (cons `(,keykey ,keygen) (cdr arg)))
                            (arg (cadr (car arg)))
                            rest)
                           (setq sofar (nreverse  sofar))
                           (cond ((memq (car resttail) '(&rest))
                                  (setq rest (cadr resttail)))
                                 (t (setq rest (gensym))
                                    (setq sofar
                                          (mapcan #'(lambda (e)
                                                (cond ((eq e '&key)
                                                       `(&rest ,rest ,e))
                                                      (t (list e))))
                                            sofar))))
                           ; shove an &rest rest in sofar prior to first key
                           ; this maybe fukt
                           (setq result
                                 (debind-do-it
                                  `(,@sofar ,key &allow-other-keys)
                                  `((debind ,arg ,keygen
                                               ,@(munch-db-inner (nconc (cdr args) '(&allow-other-keys))
                                                                 rest body state)))
                                  thing))
                         (return))))                  
                  (required
                   (let ((this (gensym))
                         (rest (gensym)))
                     (setq sofar (nreverse sofar))
                     (setq result
                           (debind-do-it `(,@sofar ,this &rest ,rest)
                                         `((debind ,arg ,this
                                          ,@(munch-db-inner (cdr args) rest body)))
                                         thing))
                     (return)))                   
                  (&optional
                   (when (consp (car arg))
                     (let* ((this (gensym))
                            (opt (cons this (cdr arg)))
                            (arg (car arg))
                            (rest (gensym)))
                           (setq sofar (nreverse sofar))
                           (setq result
                                 (debind-do-it
                                  `(,@sofar ,opt &rest ,rest)
                                  `((debind ,arg ,this
                                               ,@(munch-db-inner (cdr args) rest body state)))
                                  thing))
                         (return)))))))
               (push arg sofar)
               NEXT
               (setq args (cdr args))
               (go LP)))))
    (if whole
      (let (letlist)
        (setq letlist `((,whole ,thing)))
        (if oldthing (setq letlist `((,thing ,oldthing) ,@letlist)))
        (setq result `(let*  ,letlist  ,result))))
    (munch-form result env))))

(defun debind-maybe-dotted (arglist required tail resttail body thing)
  ; called if rest, no keys - don't apply cause thing may be dotted!
  ; produce (let ((rest (cdr mumble))) ,@body)
  (let* ((nopt (do ((n 0)
                    (l tail (cdr l)))
                   ((eq (car l) '&rest) n)
                 (when (neq (car l) '&optional)(setq n (1+ n)))))
         (req-plus-opt (+ (length required) nopt)))
    (if (zerop req-plus-opt)
      `(let ((,(cadr resttail) ,thing))
         ,@body)
      (let* ((arglist-less-last (butlast arglist 2)) ; lop off &rest rest-arg  
             (arg (gensym))
             (butlast (gensym))
             (last (gensym))             
             (newbody `(let ((,(cadr resttail) (cdr ,last)))
                         ,@body)))      
        `(let* ((,arg ,thing)
                (,butlast 
                 (let ((n (- (alt-list-length ,arg) ,req-plus-opt)))
                   (if (>= n 0)
                     (butlast ,arg n)
                     ,arg)))
                (,last (nthcdr ,(1- req-plus-opt) ,arg)))           
              (debind ,arglist-less-last ,butlast
                ,newbody))))))

(defun debind-do-it (arglist body thing)
  (multiple-value-bind 
    (ok required tail resttail keytail auxtail copy whole struct)
    (verify-lambda-list arglist t t)
    (declare (ignore whole auxtail))
    ; error shouldn't happen
    (if (not ok)(eval-error $xbadLambdaList nil arglist)) ;"Bad lambda list  ~S~%." arglist)) ; $xbadLambdaList        
    (setq arglist copy)    
    (when struct (error "evaluated destructuring bind is confused"))
    (if (and resttail (not keytail)) ; rest, no keys
      (debind-maybe-dotted arglist required tail resttail body thing)
      `(apply #'(lambda ,arglist ,@body)
              ,thing))))

(defun munch-db-inner (args rest body &optional state)
  (if args 
    `((debind ,(if (and state (neq (car args) '&rest)) (cons state args) args) ,rest
        ,@body))
    body))                            





     


;;;; Assorted Utilities






(defun %deffexpr (name fn &optional doc)
 (declare (ignore doc)) ; no dont ignore it
 (setf (gethash name *special-form-fns*) (cons name fn)) 
 name)


(defvar *compile-definitions* t
  "When non-NIL and the evaluator's lexical environment contains no
  lexical entities, causes FUNCTION and NFUNCTION forms to be compiled.")




;;; %FENV% is the current lexical environment for functions and macros.
;;; The format of each entry is (name type . fn), where type is either
;;; FUNCTION or MACRO and fn is the actual definition to be used.
;;; Entries of type function are created by FLET and LABELS.  Entries of
;;; type macro are created by MACROLET.

;;; %BENV% is the current lexical environment for block names.  Each entry
;;; is (name).  The cons cell is used as a catch tag by return-from.  If
;;; the entry has been clobbered to look like (NAME . INVALID), then the
;;; block has been exited and a return from that block is in error.





;;; %INVOKE is a function that evals the ARGS and applies FN to them.
;;; Check for applyhook before doing this.

(defvar *skip-applyhook* nil
  "Used with non-null *APPLYHOOK* to suppress the use of the hook function
  for one level of eval.")


; lapify this someday ?
(defun %invoke (fn args)
  (let ((hooked (and *applyhook*
                     (not (prog1 *skip-applyhook*
                            (setq *skip-applyhook* nil))))))
    (if (not hooked)
      (%%invoke fn args)
      (let ((newargs (make-list (list-length args))))
        (declare (dynamic-extent newargs))
        (do ((rold args (%cdr rold))
             (rnew newargs (%cdr rnew)))
            ((not (consp rold)))
          (%rplaca rnew (%eval (%car  rold))))        
        (let* ((hookfun *applyhook*) (*applyhook* nil))
          (funcall hookfun fn newargs))))))
#||
; evil because doesnt tail call
(defun %%invoke (fn args)
  (lap-inline ()
    (:variable fn args)
    (with-preserved-registers  #(asave0 dsave0)
      (move.l arg_z asave0) ; args
      (vpush arg_y)  ; fn
      (move.l '1 dsave0)
      @foo
      (if# (ne (cmp.l asave0 nilreg))  
        (if# (eq (ttagp ($ $t_cons) asave0 da))
          (ccall %eval (car asave0))
          (vpush acc)
          (add.l '1 dsave0)
          (move.l (cdr asave0) asave0)
          (bra @foo)))
      (move.l dsave0 nargs)
      (asr nargs)
      (vpop_argregs_nz)
      (jsr #'funcall))))
||#



; maybe get fn off the stack too so tfuncallgen doesnt need to slide args

(defun %%invoke (fn args)
  (let ((argslen (length args)))
    (if (> argslen 50)  ; s.b. fn of something - dont stack overflow - but if called fn
      ; rets many values, will still puke.
      (let ((newargs (make-list argslen)))  ; need kernel patch
        (declare (dynamic-extent newargs))
        (do ((oldargs args (cdr oldargs))
             (nargs newargs (cdr nargs)))
            ((null oldargs))
          (rplaca nargs (%eval (car oldargs))))
        ; this way no tail call
        (apply fn newargs))
      (%%%invoke fn args))))

#-ppc-target
(defun %%%invoke (fn args)  ; stupid to make a separate function
  ; this way do tail call
  (lap ()     
    (vpop atemp0)  ;args - now fn is tos
    (move.l '0 dtemp1)
    (vpop atemp1) ; fn
    @foo
    (if# (ne (cmp.l atemp0 nilreg))  
      (if# (eq (ttagp ($ $t_cons) atemp0 da))
        (movem.l #(atemp0 atemp1 dtemp1) -@vsp)
        (ccall %eval (car atemp0))
        (movem.l vsp@+ #(atemp0 atemp1 dtemp1))
        (vpush acc)
        (add.l '1 dtemp1)
        (move.l (cdr atemp0) atemp0)
        (bra @foo)))
    (move.l dtemp1 nargs)
    ;(dc.w #_debugger)
    (asr.l nargs)
    (move.l atemp1 atemp0) ; get him from somewhere else - YES
    (vpop_argregs)  ; put args in regs
    (jmp_subprim $sp-tfuncallgen)))

#+ppc-target ; for now
(defun %%%invoke (fn  args)
  ;(declare (dynamic-extent args))
  (let* ((argslen (length args))
         (newargs (make-list argslen)))  ; need kernel patch
    (declare (dynamic-extent newargs))
    (do ((oldargs args (cdr oldargs))
         (nargs newargs (cdr nargs)))
        ((null oldargs))
      (rplaca nargs (%eval (car oldargs))))
    ; this way no tail call
    (if (or (eq fn 'apply)(eq fn #'apply))
      (if (> argslen 2) 
        ;; aargh
        ; 1 2 (3 4) => 1 2 3 4 
        (let* ((last (car (last newargs)))
               (moreargs (make-list (+ (length last) argslen -2))))
          (declare (dynamic-extent moreargs))
          (do* ((targs (cdr newargs) (cdr targs))
                (more moreargs (cdr more)))
              ((null (cdr targs))
               (dolist (foo last)
                 (rplaca more foo)
                 (setq more (cdr more))))
            (setf (car  more) (car targs)))          
          (apply (car newargs) moreargs))
        (apply (car newargs)(cadr newargs)))
      (apply fn newargs))))

#||
; no tail call again - do stack overflow check
(defun %%invoke (fn &rest args)
  (declare (dynamic-extent args))
  (do ((args1 args (cdr args1)))
      ((null args1))
    (rplaca args1 (%eval (car args1))))
  (apply fn args))
||#


 
  
;;;; EVAL and friends.

(defvar *evalhook* nil
  "Used to substitute another function for EVAL, for use by STEP, etc.
  If *EVALHOOK* is not NIL, its value must be a function of the two
  arguments, the form to evaluate and the environment to evaluate in.
  This function does the evaluation instead of EVAL.")

(defvar *applyhook* nil
  "Used to substitute another function for the implicit APPLY normally done
  within EVAL.  If *APPLYHOOK* is not NIL, its value must be a function 
  which takes as arguments the function to be applied, the list of arguments
  it is to be applied to, and the lexical environment.  This function does
  the application instead of EVAL.")

(defvar *skip-evalhook* nil
  "Used with non-null *EVALHOOK* to suppress the use of the hook-function
  for one level of eval.")


(defun evalhook (form evalhookfn applyhookfn &optional env)
  "Evaluates Form with *Evalhook* bound to Evalhookfn and *Applyhook* bound
  to applyhookfn.  Ignores these hooks once, for the top-level evaluation
  of Form."
  (let ((*evalhook* evalhookfn) (*skip-evalhook* t)
        (*applyhook* applyhookfn) (*skip-applyhook* nil))
    (if env
      (let ((%evalenv% env))
        (%eval form))
      (eval form))))

(defun applyhook (function args evalhookfn applyhookfn)
  "Applies Function to Args, with *Evalhook* bound to Evalhookfn and with
  *Applyhook* bound to Applyhookfn.  Ignores the hook function once, for the
  top-level application of Function to Args."
    (let ((*evalhook* evalhookfn) (*skip-evalhook* nil)
          (*applyhook* applyhookfn) (*skip-applyhook* t))
      (apply function args)))



(defun %eval (exp)
  ;(declare (optimize (debug 3)))
  "Internal evaluation routine.  Gets lexical environment from special %evalenv%
    Evaluates form and returns the result or results."
  (cond ((and *evalhook*
              (not (prog1 *skip-evalhook* (setq *skip-evalhook* nil))))
         (let ((hookfn *evalhook*) (*evalhook* nil))
           (funcall hookfn exp %evalenv%)))
        ((or (null exp)(not (listp exp))) exp)        
        (t (let ((car (%car exp)))
             (cond 
              ((listp car)
               (cond ((eq (%car car) '%local-fref)
                      (%invoke (%local-fref (%cadr car)(%cddr car))(%cdr exp)))
                     (t (funcall (%cdr car) exp))))
              (t (case car
                   (quote (cadr exp)) ; this should probably not be a special case
                   (%local-fref
                    (%local-fref (%cadr exp)(%cddr exp)))
                   (t (if (not *applyhook*)
                        (%%invoke car (%cdr exp)) 
                        (%invoke car (%cdr exp)))))))))))

(defun %local-fref (def xvars)
  ; def is a "compiled-for-evaluation" definition or a closure-def
  (make-minimal-closure def xvars %evalenv%))

(deffexpr %local-ref (name idx)
  (declare (ignore name))
  ;(print (list 'local-ref idx))
  ;(describe (evalenv-values %evalenv%))
  (uvref (evalenv-values %evalenv%) idx))

(deffexpr %special-ref (name)
  (symbol-value name))

(deffexpr %closure-ref (name idx)
  (declare (ignore name))
  (let* ((env %evalenv%)
         (val (uvref (evalenv-values env) idx)))
    ; or check that val looks like a vcell
    (when (not (consp val))(error "shouldnt"))
    ;(when (neq name (uvref (evalenv-values env) (+ 1 (evalenv-maxvp env) idx)))
    ;  (break))
    (if (eq (car val) %closed-marker%)  ; next-method-context is not in a vcell!!
      (cdr val)
      val)))


(defun find-symbol-value-slow (sym env)
  ; so maybe its local and maybe it aint
  (when env
    (let ((vp (evalenv-vp env))
          ;(names (evalenv-names env))
          (max (+ 1 (evalenv-maxvp env)))
          (values (evalenv-values env)))
      (while (>= vp 0)
        (when (eq sym (uvref values (+ vp max)))
          (return-from find-symbol-value-slow
            (let ((val (uvref values vp)))
              (cond ((and (consp val)(eq (car val) %closed-marker%))
                     (setq val (cdr val)))
                    ((eq %special-marker% val)
                     (symbol-value sym))
                    (t val)))))
        (setq vp (1- vp)))))
  (symbol-value sym))

(defun set-symbol-value-slow (sym value env)
  (when env
    (let ((vp (evalenv-vp env))
          ;(names (evalenv-names env))
          (max (+ 1 (evalenv-maxvp env)))
          (values (evalenv-values env)))
      (while (>= vp 0)
        (when (eq sym (uvref values (+ vp max)))
          (return-from set-symbol-value-slow
            (let ((old (uvref values vp)))
              (cond ((and (consp old)(eq (car old) %closed-marker%))
                     (rplacd old value)
                     value)
                    ((eq %special-marker% old)
                     (set sym value))
                    (t (uvset values vp value))))))
        (setq vp (1- vp)))))
  (set sym value))
            
; this used to be called eval-lambda-body which is what it does
(defun apply-evaluated-function (body env)
  ;(describe env)
  (let ((%evalenv% env)) ; (*compiled-for-evaluation* t))
    (eval-as-progn body)))


(defun ev-inc-vp (env &optional newval)
  (when (null newval)(setq newval (+ 1 (evalenv-vp env))))
  (setf (evalenv-vp env) newval)
  (when (> newval (evalenv-maxvp env))
    (setf (evalenv-maxvp env) newval))
  newval)
    

;;;; Random special forms.



(deffexpr quote (x)
  "Returns its single argument without evaluating it."
 x)

; only called when there are no specials!!
(deffexpr %init&bind (var value &optional supplied-p)
  (let* ((env %evalenv%)
         (values (evalenv-values env))
         (var-idx (ldb (byte 16 0)(var-bits var))))
    (cond (supplied-p
           (let ((sup-idx (ldb (byte 16 0) (var-bits supplied-p))))
             (if (not (uvref values sup-idx))
               (uvset values var-idx (%eval value)))
             (%%special-bind-1 supplied-p nil env)))
          (t (uvset values var-idx (%eval value))))
    (%%special-bind-1 var nil env)))

(defun %%init&bind (thing array)
  (debind (var value &optional supplied-p) thing
    (let* ((env %evalenv%)
           (values (evalenv-values env))
           (var-idx (ldb (byte 16 0)(var-bits var))))
    (cond (supplied-p 
           (let ((sup-idx (ldb (byte 16 0) (var-bits supplied-p))))
             (if (not (uvref values sup-idx))
               (uvset values var-idx (%eval value)))
             (%%special-bind-1 supplied-p array env)))
          (t (uvset values var-idx (%eval value))))
    (%%special-bind-1 var array env))))
    
    
; a misnomer - make a vcell or special if appropriate
; never called when there are specials bound
(deffexpr %special-bind (&rest vars)
  ; this week its ((name idx) ...) probably will change to (name1 name2 ..)(idx ...) 
  ; maybe nspecials is kinda like man optional? 
  (declare (dynamic-extent vars))
  (let* ((env %evalenv%))
    #||
    (when (and vars (fixnump (car vars)))      
      (let ((nspecials (car vars)))
        (setq vars (cdr vars))
        (when (> nspecials 0)
          (rplaca specials (make-uarray-1 $v_genv (* nspecials 3) nil nil nil nil nil nil T nil)))))
    ||#
    (dolist (info vars)
      (%%special-bind-1 info nil env))))


(defun %%special-bind-1 (info array env)
  (let* ((values (evalenv-values env))
         ;(names (evalenv-names env))
         )
    
      (when (fixnump (var-bits info)) ; ignore not bound specials - why are they here anyway?
        (let ((name (var-name info))
              (idx (ldb (byte 16 0) (var-bits info)))
              (mark (symbol-referencer info)))
          (uvset values (+ idx (evalenv-maxvp env) 1) name)
          (when mark
            (cond ((eq mark t)
                   (let ((sidx (ldb (byte 16 16) (var-bits info))))
                     (%bind-special name (uvref values idx) array (+ (* sidx 12) 12))
                     ;(print (list 'set idx %special-marker%))
                     (uvset values idx %special-marker%))) ; necessary?
                  ((symbol-closed-p info) ; not if its a tag - this wont get called for tags
                   ;(print (list 'set idx 'puke))
                   (uvset values idx (make-vcell (uvref values idx))))))))))

; used by lambda body iff specials bound
(deffexpr %with-specials (nspecials &rest body)
  (declare (dynamic-extent body))
  (let* ((env %evalenv%))
    (with-stack-vector (array (* nspecials 3))
      (unwind-protect
        (progn
          (when body
            (while (cdr body)
              (let ((form (pop body)))
                (cond ((and (consp form)(consp (car form)))
                       (case (caar form)
                         (%init&bind
                          (%%init&bind (cdr form) array))
                         (%special-bind
                          (dolist (info (cdr form))
                            (%%special-bind-1 info array env)))
                         (t (%eval form))))
                      (t (%eval form)))))
            (%eval (car body))))
        (progn  ; so compiler wont optimize away the unwind-protect
          )))))    
                 

(deffexpr %special-declare (idx &rest specials)
  ; really only need to do this when stepping in case eval in stepper (true?)
  ; maybe not what about the existence of (step mumble) inside another evaluated fn - Yuck
  ; for find/set-symbol-value-slow
  (declare (dynamic-extent specials))
  (let* ((env %evalenv%)
         ;(vp (evalenv-vp env))
         ;(names (evalenv-names env))
         (max (+ 1 (evalenv-maxvp env)))
         (values (evalenv-values env)))
    ;(when (neq idx vp)(error "Internal stack is confused. Expect ~S got ~S" idx vp))
    (dolist (spec specials)
      (setq idx (+ 1 idx))
      (uvset values (+ idx max) spec) ; name
      (uvset values idx %special-marker%))
    (setf (evalenv-vp env) idx)))
         

(deffexpr eval-when  (time &rest forms)
  "Syntax is (EVAL-WHEN control-list forms).  If the control list contains
  the symbol EVAL, the forms are evaluated by the interpreter.  If the
  control list contains COMPILE, the forms are evaluated within the compiler.
  If the control list contains LOAD, the compiler arranges for the forms to
  be evaluated when the compiled file is loaded."
  (declare (dynamic-extent forms))
  (if (or (memq 'eval time)
          (memq :execute time))
      (eval-as-progn forms)))

(defun eval-as-progn (x)
  (when x
   (while (cdr x)
    (%eval (pop x)))
   (%eval (%car x))))

(deffexpr progn  (&rest x)
  "Evaluates the forms in order, returning the value(s) of the last one."
  (declare (dynamic-extent x))
  (eval-as-progn x))

(deffexpr progv (names values &rest body)
  (declare (dynamic-extent body))
  (progv (%eval names)(%eval values)(eval-as-progn body)))


; if the let knew where his args began then we wouldnt need to keep
; the vp in env up to date - but maybe its helpful for backtrace etal
; N.B. The let-list "name" contains the full variable descriptor
; stack cons an array 3*number of specials
; put oldvalue value-cell ptr-to-head of dbinding stack
; need to know how many specials the let* is gonna bind
 
(deffexpr let* (let-list &rest body)
  "First sub-form is a list of (variable initialization) pairs.
  Initializes the variables left to right, then executes the
  remaining forms as in a PROGN."
  (declare (dynamic-extent body))
  (let* ((env  %evalenv%)
         (values (evalenv-values env))
         (nspecials 0)
         (ivp (evalenv-vp env))
         (vp ivp))
    (when (fixnump (car let-list))
      (setq nspecials (pop let-list)))
    (with-stack-vector (array (* nspecials 3))
      (unwind-protect
        (progn
          (dolist (bnd let-list)
            (let ((info (car bnd)) (val (cadr bnd)))
              (setq val (%eval val))
              (setf (evalenv-vp env)(setq vp (+ 1 vp)))
              (let ((idx (ldb (byte 16 0)(var-bits info))))
                (when (neq idx vp)(error "shouldnt 4"))
                (uvset values idx val)
                (%%special-bind-1 info array env))))
          (eval-as-progn body))                
      (progn
        (setf (evalenv-vp env) ivp))))))
#-ppc-target
(defun %bind-special (sym newval vector index)
  ; index points to "byte past end" of triplet
  (lap-inline ()
    (:variable sym newval vector index)
    (move.l (varg sym) atemp0)
    (btst.b ($ $sym_vbit_indirect) (atemp0 $sym.vbits))
    (add.l ($ $sym.gvalue) atemp0)
    (if# ne (move.l @atemp0 atemp0)) ; if indirect - get contents
    (move.l (varg vector) atemp1)
    (move.l (varg index) db)
    (getint db)
    (lea (atemp1 db.l $v_data) atemp1)
    (move.l (varg newval) acc)
    (move.l @atemp0 -@atemp1)    ; move contents of vcell to vect
    (move.l atemp0 -@atemp1)     ; move vcell to vect
    (move.l (a5 $db_link) -@atemp1) ; move dblink to vect (ref-global imm0 ppc::db_link)
    (move.l atemp1 (a5 $db_link))   ; move addr to dblink (set-global blah ppc::db_link)
    (move.l acc @atemp0)))          ; move newval to vcell

#+ppc-target
(defppclapfunction %bind-special ((sym 0) (newval arg_x) (vector arg_y) (index arg_z))
  ; index is a byte index
  (lwz temp0 sym vsp)  ; get sym
  (lwz temp1 ppc::symbol.vcell temp0) ; get old value
  (unbox-fixnum imm0 index)
  (addi imm0 imm0 ppc::misc-data-offset)
  (add imm0 imm0 vector)
  (push temp1 imm0)  ; old value
  (push temp0 imm0)  ; symbol 
  (ref-global imm1 ppc::db-link)
  (push imm1 imm0)   ; dblink
  (set-global imm0 ppc::db-link)
  (svset newval ppc::symbol.vcell-cell temp0 t) ; store new val
  (mr arg_z newval)
  (la vsp 4 vsp)
  (blr))


  


(deffexpr let (let-list &rest body)
  (declare (dynamic-extent body))
  (let* ((env %evalenv%)
         (nspecials 0)
         (values (evalenv-values env))
         ;(names (evalenv-names env))
         (max (evalenv-maxvp env))
         (ivp (evalenv-vp env))
         (vp ivp))
    (when (fixnump (car let-list))
      (setq nspecials (pop let-list)))    
    (with-stack-vector (array (* 3 nspecials))
      (unwind-protect
        (progn
          (dolist (name let-list)
            (let ((val nil))
              (when (consp name)
                (setq val (%eval (cadr name))))
              (setf (evalenv-vp env) (setq vp (+ vp 1)))
              (uvset values (+ vp max) nil) ; name
              (uvset values vp val)))
          (dolist (info let-list)
            (when (consp info)(setq info (car info)))
            (%%special-bind-1 info array env))
          (eval-as-progn body))
        (progn 
          (setf (evalenv-vp env) ivp))))))


(deffexpr locally (&rest body)
  (declare (dynamic-extent body))
  (let* ((env %evalenv%)
         (ivp (evalenv-vp env)))
    (unwind-protect 
      (eval-as-progn body)
      (setf (evalenv-vp env) ivp))))

(deffexpr if (test true &optional false)
  (%eval (if (%eval test)
           true
           false)))

(deffexpr the (type obj)
  (cond ((and (consp type)(eq (car type) 'values))
         (setq type (cdr type))
         (let* ((values (multiple-value-list (%eval obj)))
                (orig-values values))
           (loop
             (when (or (null type)(null values))
               (return))
             (let ((type1 (pop type)) (value (pop values)))
               (when (not (typep value type1))
                 (error "Object ~S is not of type ~S." value type1))))
           (values-list orig-values)))
        ((typep (setq obj (%eval obj)) type)
          obj)
        (t (error "Object ~S is not of type ~S." obj type))))

;;;; Block, Tagbody, and friends.

(deffexpr block (name &rest body)
  (declare (dynamic-extent body))
  (let* ((env %evalenv%)
         (values (evalenv-values env))
         ;(names (evalenv-names env))
         (max (+ 1 (evalenv-maxvp env)))
         (ivp (evalenv-vp env))
         (vp (1+ ivp))
         (mark (list name)))
    (setf (evalenv-vp env) vp)
    (uvset values (+ vp max) name)
    (uvset values vp mark)
    (unwind-protect
      (catch mark
        (eval-as-progn body))
      (setf (evalenv-vp env) ivp))))

(deffexpr return-from (name &optional value)
  (let* ((env  %evalenv%)
         (idx (caddr name))
         (mark (uvref (evalenv-values env) idx)))
    (cond ((null mark)           
           (eval-error $xNOBlock env name))
          (t (throw mark (if value (%eval value)))))))

; takes prescanned tags from preprocessor - perhaps it should be %tagbody
(deffexpr tagbody (info &rest body)
  "The body is executed and returns NIL if it falls off the end."
  ;; Pre-scan to find all the tags.  Saves time in loops.
  ;; actually could find em in the preprocessor
  (declare (dynamic-extent body))
  (let* ((env  %evalenv%)
         (values (evalenv-values env))
         ;(names (evalenv-names env))
         (max (+ 1 (evalenv-maxvp env)))
         (ivp (evalenv-vp env))
         (vp (1+ ivp))
         (marker (list 1.5)))
    (setf (evalenv-vp env) vp)
    (uvset values (+ vp max)(var-name info)) ; change below
    (uvset values vp marker)
    ;; Now execute the body.
    ;(print (list names values))    
    (unwind-protect
      (prog ()
        LOOP
        (setq body (catch marker
                     (do ((b body (cdr b)))
                         ((atom b) nil) 
                       (let ((e (car b)))
                         (or (integerp e)(symbolp e)(%eval e))))))
        (when body (go loop)))
      (setf (evalenv-vp env) ivp))))

;(go ,info ,@tag&body))
; so maybe we dont need %tag and var-name
(deffexpr go (info &rest tag&body)
  "Go to the specified tag in the lexically surrounding tagbody."
  (let ((env %evalenv%)
        marker)      
      (setq marker (uvref (evalenv-values env) (var-bits info)))
      ;(print (list (cadr tag) idx))
      (throw marker (cdr tag&body))))






;;; Catch and friends.

(deffexpr catch (tag &rest forms)
  "Used to set up dynamic gotos.  See manual for details."
  (declare (dynamic-extent forms))
  (catch (%eval tag)
    (eval-as-progn forms)))

(deffexpr unwind-protect (protected-form &rest cleanup-forms)
  (unwind-protect
    (%eval protected-form)
    (eval-as-progn cleanup-forms)))

(deffexpr throw (tag value)
  (throw (%eval tag) (%eval value)))

(deffexpr multiple-value-call (fn &rest args)
  "Calls Function with the values of all of the Forms as arguments."
  (declare (dynamic-extent args))
  (do* ((function (%eval fn))
        (forms args (cdr forms))
        (arglist ()))
       ((atom forms)
        (apply function arglist))
    (setq arglist
          (nconc arglist (multiple-value-list (%eval (car forms)))))))

(deffexpr multiple-value-list (arg)
 (multiple-value-list (%eval arg)))

(deffexpr multiple-value-prog1 (valform &rest other-forms)
  "Evaluates the first Form, saves the values returned, then evaluates the
   rest of the forms, discarding their values.  Returns the results of the
   first form."
  (declare (dynamic-extent other-forms))
   (multiple-value-prog1 (%eval valform)
     (eval-as-progn other-forms)))

;;;; FUNCTION and friends.



; How come the muncher didnt do this for us when stepping? 
(defun make-minimal-closure (def xvars env)
 (let ((compdef (when (typep def 'closure-def)
                  (closure-def-compiled-form def))))   
   (when nil ;(not (compiled-for-evaluation (or compdef def)))
     (error "Interpreter has erroneous definitiion ~s" (or compdef def)))
   (cond ((not xvars)
          (cond 
           (compdef ; ie def is closure-def
            (cond 
             ((closure-def-extra-vars def)
              ; must be in eval in stepper
              (cond 
               ((not *stepping*) (error "Shouldnt"))
               (t 
                (let ((myvalues
                       (mapcar #'(lambda (d)
                                   (let ((name (var-name d)))
                                     (if (consp name)(setq name (var-name (car name))))
                                     (find-symbol-value-closed name env)))
                               (closure-def-extra-vars def))))
                  (make-lexical-closure compdef myvalues)))))
             (t compdef)))
           (t def)))
          (t 
           (let ((myvalues (make-list (list-length xvars))))
             (declare (dynamic-extent myvalues))
             (let ((vp (evalenv-vp env))
                   ;(names (evalenv-names env))
                   (values (evalenv-values env))
                   (rest myvalues))
               (dolist (desc xvars)
                 (let ((name (var-name desc))(sidx (var-bits desc)))
                   (when sidx ; maybe its magic
                     (when (> sidx vp)(error "Shouldnt 1"))
                     ;(when (neq name (uvref values (+ sidx sidx)))(error "Shouldnt 2"))
                     (let ((val (uvref values sidx)))
                       (when (method-var-name-p name) 
                         (setq val (%cons-magic-next-method-arg val)))
                       ;(when (or (not (consp val))(neq (car val) %closed-marker%))
                       ;  (break))
                       (rplaca rest val)))
                   (setq rest (cdr rest)))))
             ; somehow gotta tell the compiler about the extra args this here closure
             ; might want - HOW!! - glom names on front of arglist I guess?             
             (make-lexical-closure (or compdef def) myvalues))))))

; Huge crock
(defun method-var-name-p (name)
   (and ;(not (symbol-package name))
        (string= (symbol-name name) "NEXT-METHOD-CONTEXT")))

(defun find-symbol-value-closed (sym env)
  (when env
    (let ((vp (evalenv-vp env))
          (max (+ 1 (evalenv-maxvp env)))
          (values (evalenv-values env)))
      (while (>= vp 0)
        (when (eq sym (uvref values (+ vp max)))
          (let ((val (uvref values vp)))
            (when (and (consp val)(eq (car val) %closed-marker%))
              (return-from find-symbol-value-closed val))))
        (setq vp (1- vp)))
      (error "~S is not a closed over variable in this environment" sym))))

#||
; returns list of values needed to make a real closure - used?
(defun find-evalenv-values (needed env)
  (let ((vp (evalenv-vp env))
        (names (evalenv-names env))
        (values (evalenv-values env))
        (delta (list-length needed))
        (myvalues ()))
    (dolist (desc needed)
      (debind (name didx sidx) desc
        (declare (ignore didx))
        (when sidx ; maybe its magic
          (when (> sidx vp)(error "shouldnt 5"))
          (when (neq name (uvref names (+ delta sidx)))(error "shouldnt 6"))
          (push (uvref values (+ delta sidx)) myvalues))))
    (nreverse myvalues)))
||#
  

                                   

#||
; belongs in l1-utils
;(defun %make-function (name fn env)
  (if (not *compile-definitions*)
    ; bad things will probably occur if env contains unmunched function bindings
    ; but enclose says the behavior in that case is "undefined"
    (make-evaluated-function name fn env)
    (compile-user-function fn name env)))
||#

(defun make-evaluated-function (name fn env)
  (multiple-value-bind (compiled-fn newenv)(eval-prep fn name env T nil)
    (if newenv 
      (make-minimal-closure (evalenv-closure-def newenv) nil newenv) ; is that nil correct? - no
      compiled-fn)))


;;;; Labels and friends.
;;;; if we are stepping, push the defs in case user enters a new form to evaluate

(deffexpr flet (defs &rest body)
  "First arg is list of function definitions in form (name lambda-list . body).
  This list is followed any number of additional forms to be evaluated as a
  Progn with the local function definitions in effect.  The scope of
  the locally defined functions does not include the function definitions
  themselves, so they can reference externally defined functions of the same
  name."
  (declare (dynamic-extent body))
  (let ((idefs (evalenv-functions %evalenv%)))
    (if *stepping*
      (unwind-protect
        (progn (setf (evalenv-functions %evalenv%)(append defs idefs))
               (eval-as-progn body))
        (setf (evalenv-functions %evalenv%) idefs))
      (eval-as-progn body))))



(deffexpr labels (defs &rest body)
  "First arg is list of function definitions in form (name lambda-list . body).
  This list is followed any number of additional forms to be evaluated as a
  Progn with the local function definitions in effect.  The scope of
  the locally defined functions includes the function definitions
  themselves, so they can reference one another."
  (declare (dynamic-extent body))
  (let ((idefs (evalenv-functions %evalenv%)))
    (if *stepping*
      (unwind-protect
        (progn (setf (evalenv-functions %evalenv%)(append defs idefs))
               (eval-as-progn body))
        (setf (evalenv-functions %evalenv%) idefs))
      (eval-as-progn body))))


(deffexpr macrolet (defs &rest body)
  "First arg is list of macro definitions in form (name varlist . body),
  analogous to the varlist and body of a defmacro.  This list of definitions
  is followed by the Macrolet form's body.  This is evaluated as a
  progn, but with the local macro definitions in effect."
  (declare (dynamic-extent body))
  (let ((idefs (evalenv-functions %evalenv%)))
    (if *stepping*
      (unwind-protect
        (progn (setf (evalenv-functions %evalenv%)(append defs idefs))
               (eval-as-progn body))
        (setf (evalenv-functions %evalenv%) idefs))
      (eval-as-progn body))))

(deffexpr symbol-macrolet (defs &rest body)
  ; defs is really a list of var things
  (declare (dynamic-extent body))
  (let* ((env %evalenv%)
         (ivars (evalenv-variables env)))
    (unwind-protect
      (let ()
        (if *stepping*
          (setf (evalenv-variables env)(append defs (evalenv-variables env))))
        (eval-as-progn body))
      (progn (setf (evalenv-variables env) ivars)))))          


(deffexpr compiler-let (binds &rest body)
  "In the interpreter, works just like a LET with all variables implicitly
  declared special.  In the compiler, processes the forms in the body
  with the variables rebound in the compiler environment. No declarations
  are allowed."
  (declare (dynamic-extent body))
    (progv (mapcar #'(lambda (bind) (if (listp bind) (car bind) bind)) binds)
           (mapcar #'(lambda (bind) (if (listp bind) (%eval (cadr bind)) nil)) binds)
      (eval-as-progn body)))

;;;; Setq.

(deffexpr setq (&rest things)
  "The first arg is not evaluated and must be a symbol.  The second arg is
  an expression which is evaluated to get a new value for that symbol.
  Additional alternating symbols and values may be present.  These are
  evaluated left-to-right.  The final value is returned from the SETQ."
  (declare (dynamic-extent things))
  ; in reality we only see a single pair
  (let ((env %evalenv%) value)
    (when (consp things)
        (let ((var (%car things)))
          (setq value (%eval (cadr things)))
          (cond ((consp var)
                 (let ((idx  (caddr var)))
                   (case (%caar var) 
                     (%local-ref (uvset (evalenv-values env) idx value))
                     (%closure-ref
                      (rplacd (uvref (evalenv-values env) idx) value)
                      value)
                     (%special-ref
                      (set (cadr var) value))
                     (t (error "Shouldnt 7")))))
                (t (set var value)))))
                 #||(if *compiled-for-evaluation*
                   (set var value)
                   (set-symbol-value-slow var value env)))))
                  ||#
      value))

(deffexpr function (fn)
  "If argument is a lambda expression, create a closure of it in the
  current lexical environment.  If it is a symbol that names a function,
  return that function."
  (cond ((symbolp fn)
         (%function fn))
        ((and (consp fn) (eq (%car fn) 'setf) (consp (%cdr fn)) (null (%cddr fn)))
         (%function (setf-function-name (%cadr fn))))
        (t (eval-error $xnotSymLam fn))))


                          
#||
(deffexpr %stack-block (vars &rest body)
 (let* ((%venv% %venv%)
        (size 0)
        (lengths ()))
  (or
   (dolist (spec vars t)
    (let ((len (cadr spec)))
     (if (symbolp len)
      (if (constant-symbol-p len) 
       (setq len (symbol-value len))
       (return)))
     (unless (and (fixnump len) (%i>= len 0))
      (return))
     (setq size (%i+ size (%i+ len (%ilogand2 len 1))))
     (push len lengths)))
   (error "Bad form in %STACK-BLOCK: ~S." vars))
  (let ((offset 0)
        len)
   (setq lengths (nreverse lengths))
   (%vstack-block (s size)
    (dolist (spec vars)
     (bind-var (%car spec) (%int-to-ptr (%i+ s offset)) nil)
     (setq len (pop lengths) offset (%i+ offset (%i+ len (%ilogand2 len 1)))))
    (eval-as-progn body)))))
||#



(deffexpr without-interrupts (&rest forms)
 (without-interrupts
  (eval-as-progn forms)))

; here because used by both trace and step 
; we already know its defined - not if called from step-evalhook
; returns preprocessed def
; how can methods work?? - use compute applicable methods to get the first, bugger %call-next-method for rest
; or bugger all the method-functions & when our apply returns unbugger them - use much stack? 

(defun uncompile-for-stepping (name/def &optional args errchk)
  ;(declare (ignore args))
  ;; this was once commented out - now its back somewhat improved
  (when (symbolp name/def)
    (let ((fn (fboundp name/def)))
      (when (typep fn 'standard-generic-function)
        (let ((foo (if args 
                     (compute-applicable-methods fn args)
                     (generic-function-methods fn))))
          ;; install permanently the "interpreted" defs if they can be created from saved lambda's
          (if foo (mapc #'(lambda (meth)
                              (unless (typep meth 'standard-reader-method)
                                (let* ((fn (method-function meth)))
                                  (multiple-value-bind (real-def holder)(find-unencapsulated-definition fn)
                                    (let ((new-def (uncompile-for-stepping real-def args errchk)))                                      
                                      (if (eq real-def fn)
                                        (setf (%method-function meth) new-def)
                                        (if (symbolp holder)
                                          (setf (symbol-function holder) new-def))))))))
                          foo))
          (return-from uncompile-for-stepping name/def)))))
   
  ; should refuse to make-evaluated-fn if non-null-env bit
  (multiple-value-bind (real-def holder) (find-unencapsulated-definition name/def)
    (declare (ignore holder))
    (cond ((or (compiled-for-evaluation real-def)
               (typep real-def 'interpreted-lexical-closure))
           real-def)
          (t 
           (if (logbitp $lfbits-nonnullenv-bit (lfun-bits (closure-function real-def)))
             (progn 
               (when errchk (error "~S was defined in a non empty lexical-environment" name/def))
               real-def)
             (let ((munched-def (lfun-processed-lambda real-def)))
               (or munched-def                 
                   (let ((idef (uncompile-function real-def))
                         (processed-idef)
                         (name (if (symbolp name/def)
                                 name/def
                                 (lfun-name real-def))))
                     (when (not (listp idef))(error "shouldnt ~S" idef))
                     (cond ((null idef)
                            (if errchk
                              (error "Cant find uncompiled definition for ~S" name)
                              real-def))                          
                           ((setq processed-idef
                                  (make-evaluated-function name idef nil))
                            ;(set-lfun-lambda processed-idef idef) ; nah
                            (set-lfun-processed-lambda real-def processed-idef)
                            processed-idef)
                           (errchk
                            (error "Interpreter cant deal with function ~S" name))
                           (t real-def))))))))))

;; gag puke - may not be necessary now that we don't uncompile reader-methods
;; unless the darn thing was compiled with compile-definitions = nil
(defun find-interpreted-slot-name (m)
  (let* ((fun (%inner-method-function m))
         ;(env (uvref fun 1))
         ;(def (evalenv-closure-def env))
         ;(form (closure-def-form def))
         (form (function-lambda-expression fun))
         it)
    (setq it (car (last (car (last (car (last form)))))))
    (if (eq (car it) 'slot-value)
      (second (car (last it)))
      (if (eq (car it) 'setf)
        (progn
          (setq it (second it))
          (if (eq (car it) 'slot-value)
            (second (car (last it)))
            (error "Can't find slot-name for ~s ~s" m it)))
        (error "Can't find slot-name for ~s ~s" m it)))))
  

(provide 'eval) 