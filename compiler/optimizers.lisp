

;; $Log: optimizers.lisp,v $
;; Revision 1.9  2004/12/02 01:35:03  alice
;; ; fix compiler-macro for coerce (complex ...)
;;
;; Revision 1.8  2003/12/29 04:24:14  gtbyers
;; Optimize SLOT-VALUE and SET-SLOT-VALUE using slot-ids.  Remove the whole concept of "super-optimized-primary-slot-access", since it was wrong (among other things).
;;
;; Revision 1.7  2003/12/08 08:22:23  gtbyers
;; Don't try to optimize SLOT-VALUE, SET-SLOT-VALUE (yet).
;;
;; Revision 1.6  2003/12/01 17:56:05  gtbyers
;; recover pre-MOP changes
;;
;; Revision 1.4  2002/11/22 10:14:56  gtbyers
;; Do keyword nuking a little differently.  Handle simple cases of MAKE-ARRAY before introducing any temporaries.
;;
;; Revision 1.3  2002/11/20 22:08:01  alice
;; akh 11/20/02
;;
;; Revision 1.2  2002/11/18 05:35:18  gtbyers
;; Add CVS log marker
;;
;;	Change History (most recent first):
;;  4 10/22/97 akh  mapc and mapcar eval function first
;;  3 10/5/97  akh  position etal and quote nonsense
;;  2 8/25/97  akh  see below
;;  8 1/22/97  akh  max and min for fixnums
;;  7 7/18/96  akh  macros for logorc2, lognand, lognor
;;  5 6/16/96  akh  fix truncate etal to disregard the declared result type when groveling over args
;;  4 6/7/96   akh  truncate, floor, ceiling, round, logandc2
;;  3 5/23/96  akh  add one for lognot
;;  2 5/20/96  akh  typep and require-type for bytes, integer range, optimizer for find-class
;;                  ;       +/- => %i+/- if res fixnum, all args fixnum
;;                  ;       optimizers for + - * go pairwise if type known else not
;;  12 3/28/96 bill 3.1d88
;;  11 3/13/96 gb   3.1d76
;;  10 12/23/95 bill 3.0x55
;;  9 12/22/95 gb   make-array not ppc-specific; use target-array-element-subtype
;;  6 10/31/95 bill CCL 3.0x33 (Gary)
;;  4 10/26/95 gb   compiler-macros for %istruct, %instance, %pool, %population
;;  2 10/6/95  gb   Coerce is (currently) 68k-specific.
;;
;;  7 2/6/95   akh  Egads. Constant foldable shouldn't imply inline.
;;  6 2/3/95   akh  more leibniz patches
;;  5 2/3/95   slh  lsh compiler macro, copyright thang
;;  4 2/2/95   akh  add optimizers for sequence functions from Leibniz patches
;;  (do not edit before this line!!)

; Optimizers.lisp - compiler optimizers
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2002 Digitool, Inc.

;; Modification History
;
; lose compiler macros for sbit and %sbitset  - actually need to lose them in ppc-optimizers
; ----- 5.2b1
; fix compiler-macro for coerce (complex ...)
; ------- 5.1 final
; fix make-array to evaluate dims before the rest.
; ----- 4.4b5
;; 03/31/02 akh - fix require-type for constant arg and as yet undefined type, or unknown now anyway
; --------- 4.4b3
; 06/28/01 akh lose minusp - wrong for float nans and being lost is also faster for any non-fixnum - hmm
; ------- 4.4b1
; 09/06/00 akh no change
;;;  4.3.1b2
; 12/18/99 akh add macro for logtest for fixnums, truncate round and rem can constant fold
; 08/24/99 akh position and find dynamic-extent item-var too.
; 08/03/99 akh + forgot to check whether result is declared fixnum
; ---------- 4.3f1c1
; 06/05/99 akh compiler macro for find-class - don't ignore environment
;--------- 4.3b2
; 10/03/98 akh coerce optimizer returns for PPC, abs can constant fold
; 04/11/98 akh bit, sbit and friends
; 10/20/97 akh  mapc and mapcar don't expect fn to be immediately a function
; 09/18/97 akh  position, some etal dont think e.g. '#(1 2) is a list 
;08/05/97 akh   dotimes get decl right for i when limit <= 0
;01/30/97 bill  Make slot-value and accessor optimizers notice unbound slots.
;01/15/97 bill  maybe-optimize-slot-accessor-form to optimize primary slot accessor calls.
;01/13/97 bill  Fix KAB's bug: (pprint (compiler-macroexpand '(position x '#(1 2 3 4))))
;01/03/97 bill  slot-value-optimizer for primary classes.
; ------------  4.0
; akh logorc2, lognand, lognor
; akh compiler macro for truncate, logandc2
; akh compiler macro for lognot
; akh typep and require-type for bytes, integer range, optimizer for find-class
;       +/- => %i+/- if res fixnum, all args fixnum
;       optimizers for + - * go pairwise if type known else not
;03/28/96 bill  store-conditional, process-lock, process-unlock
;03/01/96 gb    1-arg / -> %quo-1.
;12/21/95 bill  Don't parse keywords unless they are constant.
;10/26/95 slh   %lock, %sgbuf, %pkg
; 3/31/95 slh   adjoin & union macros from nfcomp
;-------------- 3.0d17
; 1/31/95 slh   added lsh compiler macro
; 2/02/95 alice incorporate mcl-optimizer-patches from leibnitz
;-------------- 3.0d16
;12/26/94 alice in define-compiler-macro typep call find-class-cell with 2 args
;09/15/93 bill  (typep x '<class-name>) -> (class-cell-typep x (load-time-value (find-class-cell '<class-name> t)))
;               This turns 38 microseconds into 10 microseconds on a Quadra 800.
;-------------- 3.0d13
;05/29/93 bill  typep now optimizes quoted lists as type specifiers
;-------------- 2.1d6
;04/07/93 alice but do reduce to load-byte if (byte constant constant)
;01/13/93 bill Don't optimize LDB unless it might be all inlined. LDB & LOAD-BYTE will often
;              do better than the "optimized" code.
;11/02/92 bill (can-constant-fold '(expt))
;09/16/92 bill (coerce x 'function) -> (coerce-to-function-1 x) instead of (coerce-to-function x)
;07/24/92 bill (make-instance 'foo ...) ->
;              (%make-instance (load-time-value (find-class-cell 'foo)) ...)
;07/06/92 bill ASH inlines one more case.
;------------ 2.0
;10/22/91 gb  logxor. Dotimes.
; ------- 2.0b3
;08/31/91 gb  Pass type mask to COERCE-TO-COMPLEX-FLOAT .
;08/28/91 gb  make-string -> %make-uvector.  Identity !
;02/19/91 gb  schar->%schar.
;01/15/91 gb  Uhh, don't funcall 'foo in typep.
;12/04/90 gb  call policy/hook things instead of ad hoc examination of optimize quantities.
;10/20/90 bill define-compiler-macro make-uarray-1 fix from GB
;09/15/90 gb  Don't optimize fixnum subtraction into addition.  No comment.
;08/06/90 gz  fixes in ash.
;07/25/90 akh changed compiler-macro for make-array
;07/25/90 gb  if transforms its subforms.  Jeesh ...
;06/08/90 gb  when/if in make-array.
;05/30/90 gb  mods to set-car, set-cdr.
;05/08/90 gb  Change all transforms to compiler macros.  Limit 1 per customer.
;5/2/90   gz  (require-type x 'real) -> $sp-req-realZ
;04/30/90 gb transforms get (& currently need) &environment arg.  Recursive calls
;             to nx-transform currently have to pass it back; may not work right
;             for nx-transform-symbol.  New restartable require-type things.
;04/01/90 gz  apply lambda -> destructuring-bind
;03/25/90  gz element-type-subtype may return nil.
;03/20/90  gz (require-type x 'real) -> $sp-real1chk.
;1/3/90    gz Don't return $sp-xx symbols in require-type :fold.
;             Added uvectorp %ttagp transform.
;11/14/89  gz %ilsr 0.
;10/04/89  gz ensure-simple-string.
;09/30/89  gb svref, svset.  Logand, logior return fixnums when both args 
;             believed to be fixnums.
;05/24/89  gb typo in %proclaim-special.
;4/24/89   gz transform for make-array.  Can do better.
;4/19/89   gz Use nx-form-typep.  Use defsynonym for functionp -> lfunp.
;             require-type -> nop if already of required type.
;             Transforms for make-sequence, coerce.
;4/13/89   gz constant-fold character, float.
;16-apr-89 as some, every, notany, notevery
;03/03/89 gz Be more careful in typep :fold.
;            New-style constant folding/synonyms.
;            ldb/dpb -> load-byte, deposit-byte.
;            (ash x 0) -> x (should be (integer-identity x) but...)
;02/20/89 gz A bunch of constant folding.
;02/12/89 gz float inline.
;02/11/89 gb rplac[ad] -> %rplac[ad].  Mapcar a transform; don't ask why.
;12/28/88 gz transforms for set-car, set-cdr
;12/04/88 gz A bunch of defprimitive's.  Transform for require-type.
;11/22/88 gb aref, aset -> svref, svset.
;11/11/88 gb no such animal as "fixnums remain fixnums."
;10/27/88 gb some more assoc, member transforms.
;10/26/88 gb deftransform -> old-deftransform, in anticipation ...
;10/23/88 gb 8.9 upload.
; 9/2/88  gz no more list-[n]reverse.
; 8/25/88 gb the.
;8/25/88  gz Transforms for (eq 0 x), zerop.  Don't require result to be fixnum
;            in fixnum transforms for =,<,>.  Made eql-iff-eq look at form type.
;            Removed now-redundant inline proclamations.
;	     call structure-class-p in typep transforms, to get the compile-time
;            defs as well.
;8/16/88  gz provide at end.  ":" -> "compiler;".
;04/02/88 gz Use %svref not %get-ptr for inline %struct-ref.
;            Added inline %struct-set again...
; 2/12/88 gz svref->%svref, svset->%svset
; 1/7/88  gb got rid of struct-set inline, say $bin_data vice 8 in %struct-ref.
; 7/29/87 gb generic-to-fixnum-2, eql transform fixes.  Removed /= -> (not =).
; 7/27/87 gb mods for generic-to-fixnum arithmetic, car/cdr -> %car/%cdr,
;            (+/- n 1) -> (1+/1- n)
; 7/20/87 gb Do %proclaim-special in proclaim/special.  Don't transform proclaim-
;            object-variable anymore.  struct-ref/set -> %struct-ref/set, 
;            inline the latter when *nx-safety* = 0.
; 7/16/87 gz Added (TYPEP x 'foo) => (foop x) for known foo.
; 7/12/87 gz consorama.
; 6/16/87 gz fix in proclaim object-variable
; 5/7/87  gz member->memq, assoc->assq, eql->eq.  Fix in memq one-elt-list.
;            (/= x y) -> (not (= x y))
;            cadr -> car cdr, etc.  nth and nthcdr will small first args.
;04/28/87 gb nc-<foo> -> nx-<foo>.
;04/15/87 gz removed nc-characterp (to the compiler).  Added a transform for
;            (append (list ...) ..). Added constant folding for +,-,*,/.
;03/10/87 gz constant folding for MAKE-POINT.  Made constant folding quote
;            result if necessary.  Added transform for (apply x (cons ...)).
;02/17/87 gz constant folding for BYTE.
;02/03/87 gz Added let->let* and cons/list/list* optimizers. %member -> memq


(eval-when (eval compile)
  (require'backquote)
  (require'lispequ))

(proclaim '(special *nx-can-constant-fold* *nx-synonyms*))

(defvar *dont-find-class-optimize* nil) ; t means dont

#|
;;; can-constant-fold had a bug in the way it called #'proclaim-inline
|#

;;; There seems to be some confusion about what #'proclaim-inline does.
;;; The value of the alist entry in *nx-proclaimed-inline* indicates
;;; whether or not the compiler is allowed to use any special knowledge
;;; about the symbol in question.  That's a necessary but not sufficient
;;; condition to enable inline expansion; that's governed by declarations
;;; in the compile-time environment.
;;; If someone observed a symptom whereby calling CAN-CONSTANT-FOLD
;;; caused unintended inline-expansion, the bug's elsewhere ...
;;; The bug is that nx-declared-inline-p calls proclaimed-inline-p
;;;  which looks at what proclaim-inline sets.  Presumably, that
;;;  means that someone fixed it because it showed evidence of
;;;  being broken.
;;; The two concepts (the compiler should/should not make assumptions about
;;;  the signature of known functions, the compiler should/should not arrange
;;;  to keep the lambda expression around) need to be sorted out.

(defun can-constant-fold (names &aux handler inlines)
  (dolist (name names)
    (if (atom name)
      (setq handler nil)
      (setq handler (cdr name) name (car name)))
    (when (and handler (not (eq handler 'fold-constant-subforms)))
      (warn "Unknown constant-fold handler : ~s" handler)
      (setq handler nil))
    (let* ((bits (%symbol-bits name)))
      (declare (fixnum bits))
      (%symbol-bits name (logior 
                          (if handler (logior (ash 1 $sym_fbit_fold_subforms) (ash 1 $sym_fbit_constant_fold))
                              (ash 1 $sym_fbit_constant_fold))
                          bits)))
     (push name inlines))
  '(apply #'proclaim-inline t inlines)
)

; There's a bit somewhere.
;This is very partial.  Should be a bit somewhere, there are too many of these
;to keep on a list.
(can-constant-fold '(specfier-type %ilsl %ilsr 1- 1+
                     byte make-point - / (+ . fold-constant-subforms) (* . fold-constant-subforms) ash character
                     char-code code-char lsh
                     (logior . fold-constant-subforms) (logand . fold-constant-subforms)
                     (logxor . fold-constant-subforms) logcount logorc2 listp consp expt
                     logorc1 logtest lognand logeqv lognor lognot logandc2 logandc1
                     numerator denominator ldb-test byte-position byte-size isqrt gcd
                     floor mod truncate rem round boole max min ldb dpb mask-field deposit-field
                     length aref svref char schar bit sbit getf identity list-length
                     car cdr cadr cddr nth nthcdr last load-byte deposit-byte byte-mask
                     member search count position assoc rassoc integer-length
		         float not null char-int expt abs))

(defun %binop-cassoc (call)
  (unless (and (cddr call) (null (cdr (%cddr call))))
    (return-from %binop-cassoc call))
  (let ((func (%car call))
        (arg1 (%cadr call))
        (arg2 (%caddr call))
        (val))
    (cond ((and (fixnump arg1) (fixnump arg2))
           (funcall func arg1 arg2))
          ((or (fixnump arg1) (fixnump arg2))
           (if (fixnump arg2) (psetq arg1 arg2 arg2 arg1))
           (if (and (consp arg2)
                    (eq (%car arg2) func)
                    (cddr arg2)
                    (null (cdr (%cddr arg2)))
                    (or (fixnump (setq val (%cadr arg2)))
                        (fixnump (setq val (%caddr arg2)))))
             (list func
                   (funcall func arg1 val)
                   (if (eq val (%cadr arg2)) (%caddr arg2) (%cadr arg2)))
             call))
          (t call))))

(defun fixnumify (args op &aux (len (length args)))
  #-bccl (when (%i< len 2) (error "Bogus fixnumify! ~S ~S" args op))
  (if (eq (length args) 2)
    (cons op args)
    (list op (%car args) (fixnumify (%cdr args) op))))

(defun generic-to-fixnum-n (call env op &aux (args (%cdr call)) targs)
  (block nil
    (if (and (%i> (length args) 1)
             (and (nx-trust-declarations env)
                  (or (neq op '%i+) (subtypep *nx-form-type* 'fixnum))))
      (if (dolist (arg args t)
            (if (nx-form-typep arg 'fixnum env)
              (push arg targs)
              (return)))
        (return 
         (fixnumify (nreverse targs) op))))
    call))

;True if arg is an alternating list of keywords and args,
; only recognizes keywords in keyword package.
; Historical note: this used to try to ensure that the
; keyword appeared at most once.  Why ? (Even before
; destructuring, pl-search/getf would have dtrt.)
(defun constant-keywords-p (keys)
  (when (plistp keys)
    (while keys
      (unless (keywordp (%car keys))
        (return-from constant-keywords-p nil))
      (setq keys (%cddr keys)))
    t))

; return new form if no keys (or if keys constant and specify :TEST {#'eq, #'eql} only.)
(defun eq-eql-call (x l keys eq-fn  eql-fn env)
  (flet ((eql-to-eq ()
           (or (eql-iff-eq-p x env)
               (and (or (quoted-form-p l) (null l))
                    (dolist (elt (%cadr l) t)
                      (when (eq eq-fn 'assq) (setq elt (car elt)))
                      (when (and (numberp elt) (not (fixnump elt)))
                        (return nil)))))))
    (if (null keys)
      (list (if (eql-to-eq) eq-fn eql-fn) x l)
      (if (constant-keywords-p keys)
        (destructuring-bind (&key (test nil test-p)
                                  (test-not nil test-not-p)
                                  (key nil key-p))
                            keys
          (declare (ignore test-not key))
          (if (and test-p 
                   (not test-not-p) 
                   (not key-p) 
                   (consp test) 
                   (consp (%cdr test))
                   (null (%cddr test))
                   (or (eq (%car test) 'function)
                       (eq (%car test) 'quote)))
            (let ((testname (%cadr test)))
              (if (or (eq testname 'eq)
                      (and (eq testname 'eql)
                           (eql-to-eq)))
                (list eq-fn x l)
                (if (and eql-fn (eq testname 'eql))
                  (list eql-fn x l))))))))))

(defun eql-iff-eq-p (thing env)
  (if (quoted-form-p thing) (setq thing (%cadr thing))
      (if (not (self-evaluating-p thing))
        (return-from eql-iff-eq-p
                     (nx-form-typep thing
                                     '(or fixnum
                                       character symbol ;redundant but subtypep
                                       ; doesn't know that...
                                       (and (not number) (not macptr))) env))))
  (or (fixnump thing) (and (not (numberp thing)) (not (macptrp thing)))))

(defun fold-constant-subforms (call env)
  (with-managed-allocation
    (let* ((constants nil)
           (forms nil))
      (declare (list constants forms))
      (dolist (form (cdr call))
        (setq form (nx-transform form env))
        (if (numberp form)
          (setq constants (%temp-cons form constants))
          (setq forms (%temp-cons form forms))))
      (if constants
        (let* ((op (car call))
               (constant (if (cdr constants) (handler-case (apply op constants)
                                               (error (c) (declare (ignore c)) 
                                                      (return-from fold-constant-subforms (values call t))))
                             (car constants))))
          (values (if forms (cons op (cons constant (reverse forms))) constant) t))
        (values call nil)))))

;;; inline some, etc. in some cases
;;; in all cases, add dynamic-extent declarations
(defun some-xx-transform (call env)
  (destructuring-bind (func predicate sequence &rest args) call
    (multiple-value-bind (func-constant end-value loop-test)
                         (case func
                           (some (values $some nil 'when))
                           (notany (values $notany t 'when))
                           (every (values $every t 'unless))
                           (notevery (values $notevery nil 'unless)))
      (if args
        (let ((func-sym (gensym))
              (seq-sym (gensym))
              (list-sym (gensym)))
          `(let ((,func-sym ,predicate)
                 (,seq-sym ,sequence)
                 (,list-sym (list ,@args)))
             (declare (dynamic-extent ,func-sym ,list-sym ,seq-sym))
             (some-xx-multi ,func-constant ,end-value ,func-sym ,seq-sym ,list-sym)))
        (let ((loop-function (nx-form-sequence-iterator sequence env)))
          ;; inline if we know the type of the sequence and if
          ;; the predicate is a lambda expression
          ;; otherwise, it blows up the code for not much gain
          (if (and loop-function
                   (function-form-p predicate)
                   (lambda-expression-p (second predicate)))
            (let ((elt-var (gensym)))
              (case func
                (some
                 `(,loop-function (,elt-var ,sequence ,end-value)
                                  (let ((result (funcall ,predicate ,elt-var)))
                                    (when result (return result)))))
                ((every notevery notany)
                 `(,loop-function (,elt-var ,sequence ,end-value)
                                  (,loop-test (funcall ,predicate ,elt-var)
                                              (return ,(not end-value)))))))
            (let ((func-sym (gensym))
                  (seq-sym (gensym)))
              `(let ((,func-sym ,predicate)
                     (,seq-sym ,sequence))
                 (declare (dynamic-extent ,func-sym ,seq-sym))
                 (some-xx-one ,func-constant ,end-value ,func-sym ,seq-sym)))))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; The new (roughly alphabetical) order.
; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Compiler macros on functions can assume that their arguments have already been transformed.


(defun transform-real-n-ary-comparision (whole binary-name)
  (destructuring-bind (n0 &optional (n1 0 n1-p) &rest more) (cdr whole)
    (if more
      whole
      (if (not n1-p)
        `(require-type ,n0 'real)
        `(,binary-name ,n0 ,n1)))))



(define-compiler-macro < (&whole whole &rest ignore)
  (declare (ignore ignore))
  (transform-real-n-ary-comparision whole '<-2))

(define-compiler-macro > (&whole whole &rest ignore)
  (declare (ignore ignore))
  (transform-real-n-ary-comparision whole '>-2))

(define-compiler-macro <= (&whole whole &rest ignore)
  (declare (ignore ignore))
  (transform-real-n-ary-comparision whole '<=-2))

(define-compiler-macro >= (&whole whole &rest ignore)
  (declare (ignore ignore))
  (transform-real-n-ary-comparision whole '>=-2))


(define-compiler-macro 1- (x)
  `(- ,x 1))

(define-compiler-macro 1+ (x)
  `(+ ,x 1))

(define-compiler-macro append  (&whole call 
                                       &optional arg0 
                                       &rest 
                                       (&whole tail 
                                               &optional (junk nil arg1-p) 
                                               &rest more))
  ;(append (list x y z) A) -> (list* x y z A)
  (if (and arg1-p
           (null more)
           (consp arg0)
           (eq (%car arg0) 'list))
    (cons 'list* (append (%cdr arg0) tail))
    (if (and arg1-p (null more))
      `(append-2 ,arg0 ,junk)
      call)))

(define-compiler-macro apply  (&whole call &environment env fn arg0 &rest args)
  (let ((original-fn fn))
    (if (and arg0 
             (null args)
             (consp fn)
             (eq (%car fn) 'function)
             (null (cdr (%cdr fn)))
             (consp (setq fn (%cadr fn)))
             (eq (%car fn) 'lambda))
      (destructuring-bind (lambda-list &body body) (%cdr fn)
        `(destructuring-bind ,lambda-list ,arg0 ,@body))
      (let ((last (%car (last (push arg0 args)))))
        (if (and (consp last) (memq (%car last) '(cons list* list)))
          (cons (if (eq (%car last) 'list) 'funcall 'apply)
                (cons
                 original-fn
                 (nreconc (cdr (reverse args)) (%cdr last))))
          call)))))

(define-compiler-macro ash (&whole call &environment env num amt)
  (cond ((eq amt 0) num)
        ((and (fixnump amt)
              (< amt 0)
              (nx-form-typep num 'fixnum env))
         `(%iasr ,(- amt) ,num))
        ((and (fixnump amt)
              (<= 0 amt 27)
              (or (nx-form-typep num `(signed-byte ,(- 28 amt)) env)
                  (and (nx-form-typep num 'fixnum env)
                       (nx-trust-declarations env)
                       (subtypep *nx-form-type* 'fixnum))))
         `(%ilsl ,amt ,num))
        ((and (nx-trust-declarations env)
              (subtypep *nx-form-type* 'fixnum)
              (nx-form-typep num 'fixnum env)
              (nx-form-typep amt 'fixnum env))
        #-ignore        
         `(%fixnum-shift-left-right ,num ,amt)
         #+ignore call
         )
        (t call)))

(define-compiler-macro lsh (&whole call &environment env num amt)
  (cond ((eq amt 0) num)
        ((and (fixnump amt)
              (< amt 0)
              (nx-form-typep num 'fixnum env))
         `(%ilsr ,(- amt) ,num))
        ((and (fixnump amt)
              (<= 0 amt 27)
              (or (nx-form-typep num `(unsigned-byte ,(- 28 amt)) env)
                  (and (nx-form-typep num 'fixnum env)
                       (nx-trust-declarations env)
                       (subtypep *nx-form-type* 'fixnum))))
         `(%ilsl ,amt ,num))
        (t call)))

(define-compiler-macro assoc (&whole call &environment env item list &rest keys)
  (or (eq-eql-call item list keys 'assq 'asseql env)
      call))

(define-compiler-macro caaar (form)
  `(car (caar ,form)))

(define-compiler-macro caadr (form)
  `(car (cadr ,form)))

(define-compiler-macro cadar (form)
  `(car (cdar ,form)))

(define-compiler-macro caddr (form)
  `(car (cddr ,form)))

(define-compiler-macro cdaar (form)
  `(cdr (caar ,form)))

(define-compiler-macro cdadr (form)
  `(cdr (cadr ,form)))

(define-compiler-macro cddar (form)
  `(cdr (cdar ,form)))

(define-compiler-macro cdddr (form)
  `(cdr (cddr ,form)))





(define-compiler-macro coerce (&whole call &environment env object typespec &aux type)
  (cond ((eq typespec t) object)
        ((eq typespec nil)  `(require-type ,object nil))
        ((not (quoted-form-p typespec)) call)
        (t
         (setq type (specifier-type (cadr typespec)))
         (cond 
               ((csubtypep type (specifier-type 'list))
                `(coerce-to-list ,object))
               ((csubtypep type (specifier-type 'short-float))
                `(float ,object 1.0s0))
               ((csubtypep type (specifier-type 'double-float))
                `(float ,object 1.0d0))
               ((csubtypep type (specifier-type 'complex))
                `(coerce-to-complex ,object ,typespec)) ;; <<<
               ((eq typespec 'compiled-function)
                `(coerce-to-compiled-function ,object))
               ((csubtypep type (specifier-type 'function))
                `(coerce-to-function-1 ,object))               
               ((csubtypep type (specifier-type 'string))                
                (let ((length (array-ctype-length type)))
                  (if length 
                    call
                    `(coerce-to-string ,object (specifier-type ',(cadr typespec)))  ;; boot problem if say ,type
                    #+ignore
                    `(coerce-to-uarray ,object ,(if (csubtypep type (specifier-type 'base-string))
                                                 (type-keyword-code :base-string (target-platform))
                                                 (type-keyword-code :extended-string (target-platform)))
                                       t))))                          
               ((csubtypep type (specifier-type 'vector))
                (let* (#+ignore (subtype (type-specifier (array-ctype-element-type type)))
                       (length (array-ctype-length type)))
                  (if (or length #+ignore (eq subtype '*))
                    call
                    `(coerce-to-uarray ,object ,(element-type-subtype (type-specifier (array-ctype-element-type type))) t))))
               ((csubtypep type (specifier-type 'array))
                (let* ((dims (array-ctype-dimensions type)))
                  (when (consp dims)
                    (when (not (null (cdr dims)))(error "~s is not a sequence type." typespec))))
                (let ((length (array-ctype-length type)))
                  (if length
                    call          
                    `(coerce-to-uarray ,object ,(element-type-subtype (type-specifier (array-ctype-element-type type))) t))))
               (t call)))))


(define-compiler-macro cons (&whole call &environment env x y &aux dcall ddcall)
   (if (consp (setq dcall y))
     (cond
      ((or (eq (%car dcall) 'list) (eq (%car dcall) 'list*))
       ;(CONS A (LIST[*] . args)) -> (LIST[*] A . args)
       (list* (%car dcall) x (%cdr dcall)))
      ((or (neq (%car dcall) 'cons) (null (cddr dcall)) (cdddr dcall))
       call)
      ((null (setq ddcall (%caddr dcall)))
       ;(CONS A (CONS B NIL)) -> (LIST A B)
       `(list ,x ,(%cadr dcall)))
      ((and (consp ddcall)
            (eq (%car ddcall) 'cons)
            (eq (list-length ddcall) 3))
       ;(CONS A (CONS B (CONS C D))) -> (LIST* A B C D)
       (list* 'list* x (%cadr dcall) (%cdr ddcall)))
      (t call))
     call))

(define-compiler-macro dotimes (&whole call (i n &optional result) 
                                       &body body
                                       &environment env)
  (multiple-value-bind (body decls) (parse-body body env)
    (if (nx-form-typep (setq n (nx-transform n env)) 'fixnum env)
        (let* ((limit (gensym))
               (upper (if (constantp n) n most-positive-fixnum))
               (top (gensym))
               (test (gensym)))
          `(let* ((,limit ,n) (,i 0))
             ,@decls
             (declare (fixnum ,limit)
                      (type (integer 0 ,(if (<= upper 0) 0 `(,upper))) ,i)
                      (unsettable ,i))
             (block nil
               (tagbody
                 (go ,test)
                 ,top
                 ,@body
                 (locally
                   (declare (settable ,i))
                   (setq ,i (1+ ,i)))
                 ,test
                 (when (< ,i ,limit) (go ,top)))
               ,result)))
        call)))

(define-compiler-macro dpb (&whole call &environment env value byte integer)
  (cond ((integerp byte)
         (if (integerp value)
           `(logior ,(dpb value byte 0) (logand ,(lognot byte) ,integer))
           `(deposit-field (ash ,value ,(byte-position byte)) ,byte ,integer)))
        ((and (consp byte)
              (eq (%car byte) 'byte)
              (eq (list-length (%cdr byte)) 2))
         `(deposit-byte ,value ,(%cadr byte) ,(%caddr byte) ,integer))
        (t call)))

(define-compiler-macro eql (&whole call &environment env v1 v2)
  (if (or (eql-iff-eq-p v1 env) (eql-iff-eq-p v2 env))
    `(eq ,v1 ,v2)
    call))

(define-compiler-macro every (&whole call &environment env &rest nil)
  (some-xx-transform call env))


(define-compiler-macro identity (form) form)

(define-compiler-macro if (&whole call test true &optional false &environment env)
  (multiple-value-bind (test test-win) (nx-transform test env)
    (multiple-value-bind (true true-win) (nx-transform true env)
      (multiple-value-bind (false false-win) (nx-transform false env)
        (if (or (quoted-form-p test) (self-evaluating-p test))
          (if (eval test) 
            true
            false)
          (if (or test-win true-win false-win)
            `(if ,test ,true ,false)
            call))))))

(define-compiler-macro %ilsr (&whole call &environment env shift value)
  (if (eql shift 0)
    value
    (if (eql value 0)
      `(progn ,shift 0)
      call)))



(define-compiler-macro ldb (&whole call &environment env byte integer)
   (cond ((integerp byte)
          (let ((size (byte-size byte))
                (position (byte-position byte)))
            (cond ((nx-form-typep integer 'fixnum env)
                   `(logand ,(byte-mask size)
                            (ash ,integer ,(- position))))
                  (t `(load-byte ,size ,position ,integer)))))
         ((and (consp byte)
               (eq (%car byte) 'byte)
               (eq (list-length (%cdr byte)) 2))
          (let ((size (%cadr byte))
                (position (%caddr byte)))
            (if (and (nx-form-typep integer 'fixnum env) (fixnump position))
              ; I'm not sure this is worth doing
              `(logand (byte-mask ,size) (ash ,integer ,(- position)))
              ; this IS worth doing
              `(load-byte ,size ,position ,integer))))
         (t call)))

(define-compiler-macro length (&whole call &environment env seq)
  (if (nx-form-typep seq '(simple-array * (*)) env)
    `(uvsize ,seq)
    call))

(define-compiler-macro bit (&whole call &environment env seq &rest subs)
  (if (and (car subs)(null (cdr subs)))
    (let ((idx (car subs)))           
      (if (and (nx-form-typep seq '(simple-array bit (*)) env)
               (nx-form-typep idx 'fixnum env))
        `(aref ,seq ,idx)
        call))
    call))

#+ignore
(define-compiler-macro sbit (&whole call &environment env seq &rest subs)
  (if (and (car subs)(null (cdr subs)))
    (let ((idx (car subs)))           
      (if (and (nx-form-typep seq '(simple-array bit (*)) env)
               (nx-form-typep idx 'fixnum env))
        `(aref ,seq ,idx)
        call))
    call))

(define-compiler-macro %bitset (&whole call &environment env seq &rest stuff)
  (if (nx-form-typep seq '(simple-array bit (*)) env)
    `(%sbitset ,seq ,@stuff)
    call))

#+ignore
(define-compiler-macro %sbitset (&whole call &environment env seq &rest stuff)
  (if (and (car stuff)(null (cddr stuff)))
    (let ((idx (car stuff))
          (val (cadr stuff)))
      (if (and (nx-form-typep seq '(simple-array bit (*)) env)
               (nx-form-typep idx 'fixnum env))
        `(aset ,seq ,idx ,val)
        call))
    call))

(define-compiler-macro let (&whole call (&optional (first nil first-p) &rest rest) &body body)
  (if first-p
    (if rest
      call
      `(let* (,first) ,@body))
    `(locally ,@body)))

(define-compiler-macro let* (&whole call (&rest bindings) &body body)
  (if bindings
    call
    `(locally ,@body)))

(define-compiler-macro list* (&whole call &environment env &rest rest  &aux (n (list-length rest)) last)
  (cond ((%izerop n) nil)
        ((null (setq last (%car (last call))))
         (cons 'list (nreverse (cdr (reverse (cdr call))))))
        ((and (consp last) (memq (%car last) '(list* list cons)))
         (cons (if (eq (%car last) 'cons) 'list* (%car last))
                                 (nreconc (cdr (reverse (cdr call))) (%cdr last))))
        ((eq n 1) (list 'values last))
        ((eq n 2) (cons 'cons (%cdr call)))
        (t call)))



;(CONS X NIL) is same size as (LIST X) and faster.
(define-compiler-macro list  (&whole call &optional (first nil first-p) &rest more)
  (if more
    call
    (if first-p
      `(cons ,first nil))))


(define-compiler-macro locally (&whole call &body body &environment env)
  (multiple-value-bind (body decls) (parse-body body env nil)
    (if decls
      call
      `(progn ,@body))))

#-ppc-target
(defun target-element-type-subtype (subtype)
  (if (eq *target-compiler-macros* *ppc-target-compiler-macros*)
    (xppc-element-type-subtype subtype)
    (element-type-subtype subtype)))

#+ppc-target
(defun target-element-type-subtype (subtype)
  (element-type-subtype subtype))

(define-compiler-macro make-array (&whole call &environment env dims &rest keys)
  (if (constant-keywords-p keys)
    (destructuring-bind (&key (element-type t element-type-p)
                              (displaced-to () displaced-to-p)
                              (displaced-index-offset () displaced-index-offset-p)
                              (adjustable () adjustable-p)
                              (fill-pointer () fill-pointer-p)
                              (initial-element () initial-element-p)
                              (initial-contents () initial-contents-p)) 
                        keys
      (declare (ignore-if-unused element-type element-type-p
                                 displaced-to displaced-to-p
                                 displaced-index-offset displaced-index-offset-p
                                 adjustable adjustable-p
                                 fill-pointer fill-pointer-p
                                 initial-element initial-element-p
                                 initial-contents initial-contents-p))
      (cond ((and initial-element-p initial-contents-p)
             (nx1-whine 'illegal-arguments call)
             call)
            (displaced-to-p
             (if (or initial-element-p initial-contents-p element-type-p)
               (comp-make-array-1 dims keys)
               (comp-make-displaced-array dims keys)))
            ((or displaced-index-offset-p 
                 (not (constantp element-type))
                 (null (setq element-type (target-element-type-subtype (eval element-type)))))
             (comp-make-array-1 dims keys))
            ((and (typep element-type 'fixnum) 
                  (nx-form-typep dims 'fixnum env) 
                  (null (or adjustable fill-pointer initial-contents 
                            initial-contents-p))) 
             (if 
               (or (null initial-element-p) 
                   (cond ((eql element-type ppc::subtag-double-float-vector) 
                          (eql initial-element 0.0d0)) 
                         ((eql element-type ppc::subtag-single-float-vector) 
                          (eql initial-element 0.0s0)) 
                         ((or (eql element-type ppc::subtag-simple-base-string) 
                              (eql element-type ppc::subtag-simple-general-string)) 
                          (eql initial-element #\Null))
                         (t (eql initial-element 0))))
               `(%alloc-misc ,dims ,element-type) 
               `(%alloc-misc ,dims ,element-type ,initial-element))) 
	     (t ;Should do more here
             (comp-make-uarray dims keys element-type))))
    call))

(defun comp-make-displaced-array (dims keys)
  (let* ((call-list (make-list 4 :initial-element nil))
	 (dims-var (make-symbol "DIMS"))
         (let-list (comp-nuke-keys keys
                                   '((:displaced-to 0)
                                     (:fill-pointer 1)
                                     (:adjustable 2)
                                     (:displaced-index-offset 3))
                                   call-list
				   `((,dims-var ,dims)))))

    `(let ,let-list
       (%make-displaced-array ,dims-var ,@call-list))))

(defun comp-make-uarray (dims keys subtype)
  (let* ((call-list (make-list 6))
	 (dims-var (make-symbol "DIMS"))
         (let-list (comp-nuke-keys keys
                                   '((:adjustable 0)
                                     (:fill-pointer 1)
                                     (:initial-element 2 3)
                                     (:initial-contents 4 5))
                                   call-list
				   `((,dims-var ,dims)))))
    `(let ,let-list
       (make-uarray-1 ,subtype ,dims-var ,@call-list nil nil))))

(defun comp-make-array-1 (dims keys)
  (let* ((call-list (make-list 10 :initial-element nil))
	 (dims-var (make-symbol "DIMS"))
         (let-list (comp-nuke-keys keys                                   
                                   '((:element-type 0 1)
                                     (:displaced-to 2)
                                     (:displaced-index-offset 3)
                                     (:adjustable 4)
                                     (:fill-pointer 5)
                                     (:initial-element 6 7)
                                     (:initial-contents 8 9))
                                   call-list
				   `((,dims-var ,dims)))))
    `(let ,let-list
       (make-array-1 ,dims-var ,@call-list nil))))

(defun comp-nuke-keys (keys key-list call-list &optional required-bindings)
  ; side effects call list, returns a let-list
  (let ((let-list (reverse required-bindings)))
    (do ((lst keys (cddr lst)))
        ((null lst) nil)
      (let* ((key (car lst))
             (val (cadr lst))
             (ass (assq key key-list))
             (vpos (cadr ass))
             (ppos (caddr ass)))
        (when ass
          (when (not (constantp val))
            (let ((gen (gensym)))
              (setq let-list (cons (list gen val) let-list)) ; reverse him
              (setq val gen)))
          (rplaca (nthcdr vpos call-list) val)
          (if ppos (rplaca (nthcdr ppos call-list) t)))))
    (nreverse let-list)))

(define-compiler-macro make-instance (&whole call class &rest initargs)
  (if (and (listp class)
           (eq (car class) 'quote)
           (symbolp (cadr class))
           (null (cddr class)))
    `(%make-instance (load-time-value (find-class-cell ,class t))
                     ,@initargs)
    call))
                                 

(define-compiler-macro mapc  (&whole call fn lst &rest more)
  (if more
    call
    (let* ((temp-var (gensym))
           (elt-var (gensym))
           (fn-var (gensym)))
       `(let* ((,fn-var ,fn)
               (,temp-var ,lst))
          (dolist (,elt-var ,temp-var ,temp-var)
            (funcall ,fn-var ,elt-var))
          ))))

(define-compiler-macro mapcar (&whole call fn lst &rest more)
  (if more
    call
    (let* ((temp-var (gensym))
           (result-var (gensym))
           (elt-var (gensym))
           (fn-var (gensym)))
      `(let* ((,temp-var (cons nil nil))
              (,result-var ,temp-var)
              (,fn-var ,fn))
         (declare (dynamic-extent ,temp-var)
                  (type cons ,temp-var ,result-var))
         (dolist (,elt-var ,lst (cdr ,result-var))
           (setq ,temp-var (setf (cdr ,temp-var) (list (funcall ,fn-var ,elt-var)))))))))

(define-compiler-macro member (&whole call &environment env item list &rest keys)
  (or (eq-eql-call item list keys 'memq 'memeql env)
      call))

(define-compiler-macro memq (&whole call &environment env item list)
   ;(memq x '(y)) => (if (eq x 'y) '(y))
   ;Would it be worth making a two elt list into an OR?  Maybe if
   ;optimizing for speed...
   (if (and (or (quoted-form-p list)
                (null list))
            (null (cdr (%cadr list))))
     (if list `(if (eq ,item ',(%caadr list)) ,list))
     call))

;; this is wrong for float nans  I think
#|
(define-compiler-macro minusp (x)
  `(< ,x 0))
|#

(define-compiler-macro notany (&whole call &environment env &rest nil)
  (some-xx-transform call env))

(define-compiler-macro notevery (&whole call &environment env &rest nil)
  (some-xx-transform call env))

(define-compiler-macro nth  (&whole call &environment env count list)
   (if (and (fixnump count)
            (%i>= count 0)
            (%i< count 3))
     `(,(svref '#(car cadr caddr) count) ,list)
     call))

(define-compiler-macro nthcdr (&whole call &environment env count list)
  (if (and (fixnump count)
           (%i>= count 0)
           (%i< count 4))  
     (if (%izerop count)
       list
       `(,(svref '#(cdr cddr cdddr) (%i- count 1)) ,list))
     call))

(define-compiler-macro plusp (x)
  `(> ,x 0))

(define-compiler-macro progn (&whole call &optional (first nil first-p) &rest rest)
  (if first-p
    (if rest call first)))

;This isn't quite right... The idea is that (car (require-type foo 'list))
;can become just (<typechecking-car> foo) [regardless of optimize settings],
;but I don't think this can be done just with optimizers... For now, at least
;try to get it to become (%car (<typecheck> foo)).
(define-compiler-macro require-type (&whole call &environment env arg type)
  (cond ((and (quoted-form-p type))
         (setq type (%cadr type))
         (cond ((nth-value 0 (ignore-errors (nx-form-typep arg type env))) ; << 03/31/02
                arg)
               ((eq type 'simple-vector)
                `(the simple-vector (require-simple-vector ,arg)))
               ((eq type 'simple-string)
                `(the simple-string (require-simple-string ,arg)))
               ((eq type 'integer)
                `(the integer (require-integer ,arg)))
               ((eq type 'fixnum)
                `(the fixnum (require-fixnum ,arg)))
               ((eq type 'real)
                `(the real (require-real ,arg)))
               ((eq type 'list)
                `(the list (require-list ,arg)))
               ((eq type 'character)
                `(the character (require-character ,arg)))
               ((eq type 'number)
                `(the number (require-number ,arg)))
               ((eq type 'symbol)
                `(the symbol (require-symbol ,arg)))
               ((and (consp type)(memq (car type) '(signed-byte unsigned-byte integer)))
                `(the ,type (%require-type-builtin ,arg 
                                                   (load-time-value (find-builtin-cell ',type)))))
               ((and (symbolp type)
                     (let ((simpler (type-predicate type)))
                       (if simpler `(the ,type (%require-type ,arg ',simpler))))))
               ((and (symbolp type)(find-class type nil env))
                  `(%require-type-class-cell ,arg (load-time-value (find-class-cell ',type t))))
               (t call)))
        (t call)))

(define-compiler-macro proclaim (&whole call decl)
   (if (and (quoted-form-p decl)
            (eq (car (setq decl (%cadr decl))) 'special))
       (do ((vars (%cdr decl) (%cdr vars)) (decls ()))
           ((null vars)
            (cons 'progn (nreverse decls)))
         (unless (and (car vars)
                      (neq (%car vars) t)
                      (symbolp (%car vars)))
            (return call))
         (push (list '%proclaim-special (list 'quote (%car vars))) decls))
       call))





(define-compiler-macro some (&whole call &environment env &rest nil)
  (some-xx-transform call env))

(define-compiler-macro struct-ref (&whole call &environment env struct offset)
   (if (nx-inhibit-safety-checking env)
    `(%svref ,struct ,offset)
    call))

;;; expand find-if and find-if-not

(define-compiler-macro find-if (&whole call &environment env
                                       test sequence &rest keys)
  `(find ,test ,sequence
        :test #'funcall
        ,@keys))

(define-compiler-macro find-if-not (&whole call &environment env
                                           test sequence &rest keys)
  `(find ,test ,sequence
        :test-not #'funcall
        ,@keys))

;;; inline some cases, and use a positional function in others

(define-compiler-macro find (&whole call &environment env
                                    item sequence &rest keys)
  (if (constant-keywords-p keys)
    (destructuring-bind (&key from-end test test-not (start 0) end key) keys
      (if (and (eql start 0)
               (null end)
               (null from-end)
               (not (and test test-not)))
        (let ((find-test (or test test-not '#'eql))
              (loop-test (if test-not 'unless 'when))
              (loop-function (nx-form-sequence-iterator sequence env)))
          (if loop-function
            (let ((item-var (unless (or (constantp item)
                                        (and (equal find-test '#'funcall)
                                             (function-form-p item)))
                              (gensym)))
                  (elt-var (gensym)))
              `(let (,@(when item-var `((,item-var ,item))))
                 (,loop-function (,elt-var ,sequence)
                                 (,loop-test (funcall ,find-test ,(or item-var item)
                                                      (funcall ,(or key '#'identity) ,elt-var))
                                             (return ,elt-var)))))
            (let ((find-function (if test-not 'find-positional-test-not-key 'find-positional-test-key))
                  (item-var (gensym))
                  (sequence-var (gensym))
                  (test-var (gensym))
                  (key-var (gensym)))
              `(let ((,item-var ,item)
                     (,sequence-var ,sequence)
                     (,test-var ,(or test test-not))
                     (,key-var ,key))
                 (declare (dynamic-extent ,item-var ,sequence-var ,test-var ,key-var))
                 (,find-function ,item-var ,sequence-var ,test-var ,key-var)))))
        call))
      call))

;;; expand position-if and position-if-not

(define-compiler-macro position-if (&whole call &environment env
                                           test sequence &rest keys)
  `(position ,test ,sequence
             :test #'funcall
             ,@keys))

(define-compiler-macro position-if-not (&whole call &environment env
                                               test sequence &rest keys)
  `(position ,test ,sequence
             :test-not #'funcall
             ,@keys))

;;; inline some cases, and use positional functions for others

(defun quoted-form-not-list (x)
  (or (not (quoted-form-p x))
      (not (listp (cadr x)))))

(define-compiler-macro position (&whole call &environment env
                                        item sequence &rest keys)
  (if (constant-keywords-p keys)
    (destructuring-bind (&key from-end test test-not (start 0) end key) keys
      (if (and (eql start 0)
               (null end)
               (null from-end)
               (not (and test test-not)))
        (let ((position-test (or test test-not '#'eql))
              (loop-test (if test-not 'unless 'when)))
          ;; make it elide funcall - more general fix in nx1-funcall (if I didn't blow it somehow)
          (if (equal position-test ''eq)
            (setq position-test '#'eq)
            (if (equal position-test ''eql)(setq position-test '#'eql)))
          (cond ((and (nx-form-typep sequence 'list env)
                      (not (quoted-form-not-list sequence)))
                 (let ((item-var (unless (or (constantp item)
                                             (and (equal position-test '#'funcall)
                                                  (function-form-p item)))
                                   (gensym)))
                       (elt-var (gensym))
                       (position-var (gensym)))
                   `(let (,@(when item-var `((,item-var ,item)))
                          (,position-var 0))
                      ,@(when item-var `((declare (dynamic-extent ,item-var))))
                      (dolist (,elt-var ,sequence)
                        (,loop-test (funcall ,position-test ,(or item-var item)
                                             (funcall ,(or key '#'identity) ,elt-var))
                                    (return ,position-var))
                        (incf ,position-var)))))
                ((nx-form-typep sequence 'vector env)
                 (let ((item-var (unless (or (constantp item)
                                             (and (equal position-test '#'funcall)
                                                  (function-form-p item)))
                                   (gensym)))
                       (sequence-var (gensym))
                       (position-var (gensym)))
                   `(let (,@(when item-var `((,item-var ,item)))
                          (,sequence-var ,sequence))
                      (declare (dynamic-extent ,sequence-var ,@(when item-var `(,item-var))))
                      ,@(let ((type (nx-form-type sequence env)))
                          (unless (eq type t)
                            `((declare (type ,type ,sequence-var)))))
                      (dotimes (,position-var (length ,sequence-var))
                        (,loop-test (funcall ,position-test ,(or item-var item)
                                             (funcall ,(or key '#'identity)
                                                      (locally (declare (optimize (speed 3) (safety 0)))
                                                        (aref ,sequence ,position-var))))
                                    (return ,position-var))))))
                (t
                 (let ((position-function (if test-not
                                            'position-positional-test-not-key
                                            'position-positional-test-key))
                       (item-var (gensym))
                       (sequence-var (gensym))
                       (test-var (gensym))
                       (key-var (gensym)))
                   `(let ((,item-var ,item)
                          (,sequence-var ,sequence)
                          (,test-var ,(or test test-not))
                          (,key-var ,key))
                      (declare (dynamic-extent ,item-var ,sequence-var ,test-var ,key-var))
                      (,position-function ,item-var ,sequence-var ,test-var ,key-var))))))
        call))
    call))

;;; inline some cases of remove-if and remove-if-not

(define-compiler-macro remove-if (&whole call &environment env &rest nil)
  (remove-if-transform call env))

(define-compiler-macro remove-if-not (&whole call &environment env &rest nil)
  (remove-if-transform call env))

(defun remove-if-transform (call env)
  (destructuring-bind (function test sequence &rest keys) call
    (if (constant-keywords-p keys)
      (destructuring-bind (&key from-end (start 0) end count (key '#'identity)) keys
        (if (and (eql start 0)
                 (null end)
                 (null from-end)
                 (null count)
                 (nx-form-typep sequence 'list env)
                 (not (quoted-form-not-list sequence)))
          ;; only do the list case, since it's hard to collect vector results
          (let ((temp-var (gensym))
                (result-var (gensym))
                (elt-var (gensym))
                (loop-test (ecase function (remove-if 'unless) (remove-if-not 'when))))
            `(the list
               (let* ((,temp-var (cons nil nil))
                      (,result-var ,temp-var))
                 (declare (dynamic-extent ,temp-var))
                 (dolist (,elt-var ,sequence (%cdr ,result-var))
                   (,loop-test (funcall ,test (funcall ,key ,elt-var))
                               (setq ,temp-var 
                                     (%cdr 
                                      (%rplacd ,temp-var (list ,elt-var)))))))))
          call))
      call)))



(define-compiler-macro struct-set (&whole call &environment env struct offset new)
  (if (nx-inhibit-safety-checking env)
    `(%svset ,struct ,offset ,new)
    call))

(define-compiler-macro the (&whole call &environment env typespec form &aux win)
  (if (and (self-evaluating-p (multiple-value-setq (form win) (nx-transform form env)))
           (typep form typespec))
    form
    (if win
      `(the ,typespec ,form)
      call)))





(define-compiler-macro zerop (arg)
  `(= ,arg 0))


(define-compiler-macro = (&whole w n0 &optional (n1 nil n1p) &rest more)
  (if (not n1p)
    `(require-type ,n0 'number)
    (if more
      w
      `(=-2 ,n0 ,n1))))

(define-compiler-macro /= (&whole w n0 &optional (n1 nil n1p) &rest more)
  (if (not n1p)
    `(require-type ,n0 'number)
    (if more
      w
      `(/=-2 ,n0 ,n1))))

(define-compiler-macro + (&whole w  &environment env &optional (n0 nil n0p) (n1 nil n1p) &rest more)
  
  (if more
    (if (and (subtypep *nx-form-type* 'fixnum)
             (nx-trust-declarations env)
             (nx-form-typep n0 'fixnum env)
             (nx-form-typep n1 'fixnum env)
             (dolist (x more t)
               (if (not (nx-form-typep x 'fixnum env))(return nil))))
      `(%i+ ,n0 ,n1 ,@more)
      (let ((type (nx-form-type w env)))
        (if (and type (numeric-type-p type))
          `(+-2 ,n0 (+ ,n1 ,@more))
          w)))
    (if n1p
      `(+-2 ,n0 ,n1)
      (if n0p
        `(require-type ,n0 'number)
        0))))

(define-compiler-macro - (&whole w &environment env n0 &optional (n1 nil n1p) &rest more)
  (if more
    (if (and (subtypep *nx-form-type* 'fixnum)
             (nx-trust-declarations env)
             (nx-form-typep n0 'fixnum env)
             (nx-form-typep n1 'fixnum env)
             (dolist (x more t)
               (if (not (nx-form-typep x 'fixnum env))(return nil))))
      `(%i- ,n0 (%i+ ,n1 ,@more))
      (let ((type (nx-form-type w env)))
        (if (and type (numeric-type-p type)) ; go pairwise if type known, else not
          `(--2 ,n0 (+ ,n1 ,@more))
          w)))
    (if n1p
      `(--2 ,n0 ,n1)
      `(%negate ,n0))))

(define-compiler-macro * (&whole w &environment env &optional (n0 nil n0p) (n1 nil n1p) &rest more)
  (if more
    (let ((type (nx-form-type w env)))
      (if (and type (numeric-type-p type)) ; go pairwise if type known, else not
        `(*-2 ,n0 (* ,n1 ,@more))
        w))
    (if n1p
      `(*-2 ,n0 ,n1)
      (if n0p
        `(require-type ,n0 'number)
        1))))

(define-compiler-macro / (&whole w n0 &optional (n1 nil n1p) &rest more)
  (if more
    w
    (if n1p
      `(/-2 ,n0 ,n1)
      `(%quo-1 ,n0))))

; beware of limits - truncate of most-negative-fixnum & -1 ain't a fixnum - too bad
(define-compiler-macro truncate (&whole w &environment env n0 &optional (n1 nil n1p))
  (let ((*nx-form-type* t))
    (if (nx-form-typep n0 'fixnum env)
      (if (not n1p)
        n0
        (if (nx-form-typep n1 'fixnum env)
          `(%fixnum-truncate ,n0 ,n1)
          w))
      w)))

(define-compiler-macro floor (&whole w &environment env n0 &optional (n1 nil n1p))
  (let ((*nx-form-type* t))
    (if (nx-form-typep n0 'fixnum env)
      (if (not n1p)
        n0
        (if (nx-form-typep n1 'fixnum env)
          `(%fixnum-floor ,n0 ,n1)
          w))
      w)))

(define-compiler-macro round (&whole w &environment env n0 &optional (n1 nil n1p))
  (let ((*nx-form-type* t)) ; it doesn't matter what the result type is declared to be
    (if (nx-form-typep n0 'fixnum env)
      (if (not n1p)
        n0
        (if (nx-form-typep n1 'fixnum env)
          `(%fixnum-round ,n0 ,n1)
          w))
      w)))

(define-compiler-macro ceiling (&whole w &environment env n0 &optional (n1 nil n1p))
  (let ((*nx-form-type* t))
    (if (nx-form-typep n0 'fixnum env)
      (if (not n1p)
        n0
        (if (nx-form-typep n1 'fixnum env)
          `(%fixnum-ceiling ,n0 ,n1)
          w))
      w)))

(define-compiler-macro oddp (&whole w &environment env n0)
  (if (nx-form-typep n0 'fixnum env)
    `(logbitp 0 (the fixnum ,n0))
    w))

(define-compiler-macro evenp (&whole w &environment env n0)
  (if (nx-form-typep n0 'fixnum env)
    `(not (logbitp 0 (the fixnum ,n0)))
    w))
  

(define-compiler-macro logandc2 (n0 n1)
  (let ((n1var (gensym))
        (n0var (gensym)))
    `(let ((,n0var ,n0)
           (,n1var ,n1))
       (logandc1 ,n1var ,n0var))))

(define-compiler-macro logorc2 (n0 n1)
  (let ((n1var (gensym))
        (n0var (gensym)))
    `(let ((,n0var ,n0)
           (,n1var ,n1))
       (logorc1 ,n1var ,n0var))))

(define-compiler-macro lognand (n0 n1)
  `(lognot (logand ,n0 ,n1)))

(define-compiler-macro lognor (n0 n1)
  `(lognot (logior ,n0 ,n1)))


(defun transform-logop (whole identity binop)
  (destructuring-bind (op &optional (n0 nil n0p) (n1 nil n1p) &rest more) whole
    (if (and n1p (eql n0 identity))
      `(,op ,n1 ,@more)
      (if (and n1p (eql n0 (lognot identity)))
        `(progn
           (,op ,n1 ,@more)
           ,(lognot identity))
        (if more
          (if (cdr more)
            whole
            `(,binop ,n0 (,binop ,n1 ,(car more))))
          (if n1p
            `(,binop ,n0 ,n1)
            (if n0p
              `(require-type ,n0 'integer)
              identity)))))))
          
(define-compiler-macro logand (&whole w &rest all)
  (declare (ignore all))
  (transform-logop w -1 'logand-2))

(define-compiler-macro logior (&whole w &rest all)
  (declare (ignore all))
  (transform-logop w 0 'logior-2))

(define-compiler-macro logxor (&whole w &rest all)
  (declare (ignore all))
  (transform-logop w 0 'logxor-2))

(define-compiler-macro lognot (&whole w &environment env n1)
  (if (nx-form-typep n1 'fixnum env)
    `(%ilognot ,n1)
    w))

(define-compiler-macro logtest (&whole w &environment env n1 n2)
  (if (and (nx-form-typep n1 'fixnum env)
           (nx-form-typep n2 'fixnum env))
    `(not (eql 0 (logand ,n1 ,n2)))
    w))
  

(defmacro defsynonym (from to)
  ;Should maybe check for circularities.
  `(progn
     (setf (compiler-macro-function ',from) nil)
     (let ((pair (assq ',from *nx-synonyms*)))
       (if pair (rplacd pair ',to) 
           (push (cons ',from ',to) 
                 *nx-synonyms*))
       ',to)))

(defsynonym first car)
(defsynonym second cadr)
(defsynonym third caddr)
(defsynonym fourth cadddr)
(defsynonym rest cdr)

(defsynonym byte-size logcount)
(defsynonym ldb-test logtest)
(defsynonym mask-field logand)

(defsynonym functionp lfunp)
(defsynonym null not)
(defsynonym char-int char-code)

;;; Improvemets file by Bob Cassels
;;; Just what are "Improvemets", anyway ?

;;; Optimize some CL sequence functions, mostly by inlining them in simple cases
;;; when the type of the sequence is known.  In some cases, dynamic-extent declarations are
;;; automatically inserted.  For some sequence functions, if the type of the
;;; sequence is known at compile time, the function is inlined.  If the type
;;; isn't known but the call is "simple", a call to a faster (positional-arg)
;;; function is substituted.


(defun nx-form-sequence-iterator (sequence-form env)
  (cond ((nx-form-typep sequence-form 'vector env) 'dovector)
        ((and (nx-form-typep sequence-form 'list env)
              (not (quoted-form-not-list sequence-form))
              'dolist))))

(defun function-form-p (form)
   ;; c.f. quoted-form-p
   (and (consp form)
        (eq (%car form) 'function)
        (consp (%cdr form))
        (null (%cdr (%cdr form)))))

(defun optimize-typep (thing type env)
  ;; returns a new form, or nil if it can't optimize
  (cond ((symbolp type)
         (let ((typep (type-predicate type)))
           (cond ((and typep
                       (symbolp typep))
                  `(,typep ,thing))
                 ((%deftype-expander type)
                  ;; recurse here, rather than returning the partially-expanded form
                  ;; mostly since it doesn't seem to further optimize the result otherwise
                  (let ((expanded-type (type-expand type)))
                    (or (optimize-typep thing expanded-type env)
                        ;; at least do the first expansion
                        `(typep ,thing ',expanded-type))))
                 ((structure-class-p type env)
                  `(structure-typep ,thing ',type))
                 ((find-class type nil env)
                  `(class-cell-typep ,thing (load-time-value (find-class-cell ',type t))))
                 ((info-type-builtin type) ; bootstrap troubles here?
                  `(builtin-typep ,thing (load-time-value (find-builtin-cell ',type))))
                 (t nil))))
        ((consp type)
         (cond 
          ((info-type-builtin type)  ; byte types
           `(builtin-typep ,thing (load-time-value (find-builtin-cell ',type))))
          (t 
           (case (%car type)
             (satisfies `(funcall ',(cadr type) ,thing))
             (eql `(eql ,thing ',(cadr type)))
             (member `(not (null (member ,thing ',(%cdr type)))))
             (not `(not (typep ,thing ',(cadr type))))
             ((or and)
              (let ((thing-sym (gensym)))
                `(let ((,thing-sym ,thing))
                   (,(%car type)
                    ,@(mapcar #'(lambda (type-spec)
                                  (or (optimize-typep thing-sym type-spec env)
                                      `(typep ,thing-sym ',type-spec)))
                              (%cdr type))))))
             ((signed-byte unsigned-byte integer mod)  ; more byte types
              `(builtin-typep ,thing (load-time-value (find-builtin-cell ',type))))
             (t nil)))))
        (t nil)))

(define-compiler-macro typep  (&whole call &environment env thing type)
  (if (quoted-form-p type)
    (or (optimize-typep thing (%cadr type) env)
        call)
    call))



(define-compiler-macro find-class (&whole call type &optional (errorp t) env)
  ;(declare (ignore env))
  (if (and (quoted-form-p type)(not *dont-find-class-optimize*)(not env))
      `(class-cell-find-class (load-time-value (find-class-cell ,type t)) ,errorp)
    call))


(define-compiler-macro gcd (&whole call &optional (n0 nil n0-p) (n1 nil n1-p) &rest rest)
  (if rest
    call
    (if n1-p
      `(gcd-2 ,n0 ,n1)
      (if n0-p
        `(%integer-abs ,n0)
        0))))

(define-compiler-macro lcm (&whole call &optional (n0 nil n0-p) (n1 nil n1-p) &rest rest)
  (if rest
    call
    (if n1-p
      `(lcm-2 ,n0 ,n1)
      (if n0-p
        `(%integer-abs ,n0)
        1))))

(define-compiler-macro max (&whole call &environment env n0 &optional (n1 nil n1-p) &rest rest)
  (if rest
    call
    (if n1-p
      (if (and (nx-form-typep n0 'fixnum env)(nx-form-typep n1 'fixnum env))
        `(imax-2 ,n0 ,n1)
        `(max-2 ,n0 ,n1))
      `(require-type ,n0 'real))))

(define-compiler-macro max-2 (n0 n1)
  (let* ((g0 (gensym))
         (g1 (gensym)))
   `(let* ((,g0 ,n0)
           (,g1 ,n1))
      (if (> ,g0 ,g1) ,g0 ,g1))))

(define-compiler-macro imax-2 (n0 n1)
  (let* ((g0 (gensym))
         (g1 (gensym)))
   `(let* ((,g0 ,n0)
           (,g1 ,n1))
      (if (%i> ,g0 ,g1) ,g0 ,g1))))




(define-compiler-macro min (&whole call &environment env n0 &optional (n1 nil n1-p) &rest rest)
  (if rest
    call
    (if n1-p
      (if (and (nx-form-typep n0 'fixnum env)(nx-form-typep n1 'fixnum env))
        `(imin-2 ,n0 ,n1)
        `(min-2 ,n0 ,n1))
      `(require-type ,n0 'real))))

(define-compiler-macro min-2 (n0 n1)
  (let* ((g0 (gensym))
         (g1 (gensym)))
   `(let* ((,g0 ,n0)
           (,g1 ,n1))
      (if (< ,g0 ,g1) ,g0 ,g1))))

(define-compiler-macro imin-2 (n0 n1)
  (let* ((g0 (gensym))
         (g1 (gensym)))
   `(let* ((,g0 ,n0)
           (,g1 ,n1))
      (if (%i< ,g0 ,g1) ,g0 ,g1))))


(defun eq-test-p (test)
  (or (equal test ''eq) (equal test '#'eq)))

(defun eql-test-p (test)
  (or (equal test ''eql) (equal test '#'eql)))

(define-compiler-macro adjoin (&whole whole elt list &rest keys)
  (if (constant-keywords-p keys)
    (destructuring-bind (&key (test ''eql) test-not key) keys
      (or (and (null test-not)
               (null key)
               (cond ((eq-test-p test)
                      `(adjoin-eq ,elt ,list))
                     ((eql-test-p test)
                      `(adjoin-eql ,elt ,list))
                     (t nil)))
          whole))
    whole))

(define-compiler-macro union (&whole whole list1 list2 &rest keys)
  (if (constant-keywords-p keys)
    (destructuring-bind (&key (test ''eql) test-not key) keys
      (or (and (null test-not)
               (null key)
               (cond ((eq-test-p test)
                      `(union-eq ,list1 ,list2))
                     ((eql-test-p test)
                      `(union-eql ,list1 ,list2))
                     (t nil)))
          whole))
    whole))

; This will need a without-interrupts if we ever go to a preemptive scheduler
(define-compiler-macro store-conditional (&whole whole &environment env
                                                 lock old new)
  (if (nx-form-typep lock 'lock env)
    (let ((lock-var (gensym))
          (old-var (gensym))
          (new-var (gensym)))
      `(let ((,lock-var ,lock)
             (,old-var ,old)
             (,new-var ,new))
         (when (eq (lock.value ,lock-var) ,old-var)
           (setf (lock.value ,lock-var) ,new-var)
           t)))
    whole))

(define-compiler-macro process-lock (&whole whole &environment env
                                            lock &optional
                                            lock-value (whostate "Lock")
                                            interlock-function)
  (if (and (null interlock-function)
           (nx-form-typep lock 'lock env))
    (let ((lock-var (gensym))
          (lock-value-var (gensym)))
      `(let ((,lock-var ,lock)
             (,lock-value-var ,(or lock-value '*current-process*)))
         (declare (type lock ,lock-var))
         (if (store-conditional ,lock-var nil ,lock-value-var)
           ,lock-value-var
           (if (eq ,lock-value-var (lock.value ,lock-var))
             ,lock-value-var
             (funcall 'process-lock ,lock-var ,lock-value-var ,whostate)))))
    whole))

(define-compiler-macro process-unlock (&whole whole &environment env
                                              lock &optional lock-value (error-p t))
  (if (nx-form-typep lock 'lock env)
    (let ((lock-var (gensym))
          (lock-value-var (gensym)))
      `(let ((,lock-var ,lock)
             (,lock-value-var ,(or lock-value '*current-process*)))
         (declare (type lock ,lock-var))
         (unless (store-conditional ,lock-var ,lock-value-var nil)
           (funcall 'process-unlock ,lock-var ,lock-value-var ,error-p))))
    whole))


(define-compiler-macro slot-value (&whole whole &environment env
                                          instance slot-name-form)
  (declare (ignore env))
  (let* ((name (and (quoted-form-p slot-name-form)
                    (typep (cadr slot-name-form) 'symbol)
                    (cadr slot-name-form))))
    (if name
      `(slot-id-value ,instance (load-time-value (ensure-slot-id ',name)))
      whole)))

(define-compiler-macro set-slot-value (&whole whole &environment env
                                          instance slot-name-form value-form)
  (declare (ignore env))
  (let* ((name (and (quoted-form-p slot-name-form)
                    (typep (cadr slot-name-form) 'symbol)
                    (cadr slot-name-form))))
    (if name
      `(set-slot-id-value
        ,instance
        (load-time-value (ensure-slot-id ',name))
        ,value-form)
      whole)))


(provide "OPTIMIZERS")


#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
	3	1/2/95	akh	call find-class-cell with second arg t in typep
|# ;(do not edit past this line!!)
