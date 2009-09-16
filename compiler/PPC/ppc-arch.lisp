;;;-*- Mode: Lisp; Package: (PPC :use CL) -*-

;; $Log: ppc-arch.lisp,v $
;; Revision 1.10  2006/02/05 16:42:47  alice
;; ; add some more kernel-imports-  CFURLCreateFromFSRef etc
;;
;; Revision 1.9  2005/06/25 21:29:48  alice
;; ; 06/08/05 add remove-tmtask & restore-tmtask
;;
;; Revision 1.8  2003/12/08 08:23:33  gtbyers
;; Lose SGBUF subtag; gain SLOT-VECTOR subtag, SLOT-UNBOUND constants.
;;
;; Revision 1.7  2003/12/01 17:56:05  gtbyers
;; recover pre-MOP changes
;;
;; Revision 1.5  2003/02/12 21:42:06  gtbyers
;; Declare lock/unlock entrypoints
;;
;; Revision 1.4  2003/01/13 20:05:53  gtbyers
;; Add NATIVE-KERNEL-VERSION kernel global.  Remove MP-* kernel globals.
;;
;; Revision 1.3  2002/11/25 05:34:57  gtbyers
;; Define vector register names.
;;
;; Revision 1.2  2002/11/18 05:36:11  gtbyers
;; Add CVS log marker
;;
;;	Change History (most recent first):
;;  28 9/12/96 slh  
;;  10 12/2/95 gb   add %INIT-MISC nrs
;;  5 10/26/95 gb   %gcable-pointers% not a symbol; %macro-code% is.  Go figure.  Some other globals, kernel-imports.
;;  4 10/23/95 gb   added %gcable-macptrs% to nrs
;;  2 10/6/95  gb   Minor changes.
;;  (do not edit before this line!!)

; Modification History
;
; add *gc-cursor* to nilreg symbols
; add some more kernel-imports
;  collect, once-only, iterate defined elsewhere
; ------ 5.2 b6
; fix max-1-bit-constant-index
; ------- 5.2b1
; add some more kernel-imports-  CFURLCreateFromFSRef etc
; 06/08/05 add remove-tmtask & restore-tmtask
; ------ 5.1 final
; 05/25/02 round up c-frame.size
; ----- 4.4b3
; 03/13/97 bill  error-fpu-exception-single from Gary.
; 02/14/97 gb    fp_s32conv
; 02/13/97 bill  Add to *ppc-nilreg-relative-symbols* :
;                ccl::*cs-segment-size*, ccl::*vs-segment-size*,
;                ccl::*ts-segment-size*, ccl::*cs-hard-overflow-size*,
;                ccl::*cs-soft-overflow-size*, ccl::cs-overflow-callback
; 10/22/96 bill  error-too-many-values
; ------------   4.0
; 09/02/96 gb    vsp comment was lying: stacks grow towards 0.
;  8/28/96 slh   nrs *current-cursor*
; --- 4.0b1
; 07/25/96 gb    kernel-import lisp-bug.
; 07/08/96 bill  protected-area storage layout
; 06/14/96 bill  Add %new-gcable-ptr to *ppc-nilreg-relative-symbols*
; 06/20/96 gb    fp-zero (= fp31).  area.nextref-> area.threshold, area.gc-count.
;                kernel-globals oldest-ephemeral, tenured-area.  Import egc-control.
; --- 3.9 release ---
; 04/10/96 gb    error-memory-full.
; 04/08/96 gb    define subtag-go-tag & subtag-block-tag; nrs %excised-code%,
;                error-excised-function-call, kernel-import excise-library.
; 04/08/96 bill  add exception-saved-registers to *ppc-kernel-globals*
; 03/25/96 bill  error-divide-by-0 => error-throw-tag-missing to agree
;                with "ccl:pmcl;errors.s".
; 03/01/96 bill  More cross-reference comment for *ppc-kernel-globals*
;                Add resolve-slep-address to *ppc-nilreg-relative-symbols*
; 03/10/96 gb    new globals & import; creole; fp error, fpscr bits
; 03/01/96 gb    new AREA fields
; 01/22/96 bill  add ndwords to (define-storage-layout area ...)
;                Add comment about gc-area record definition.
; 02/01/96 gb    kernel-import-condemn-area.  Area stuff (missing ndwords!)
;                lexpr-return, lexpr-return1v.
; 01/22/96 gb    error-stack-overflow, error-alloc-failed.
; 12/27/95 gb    remove pad words from ratio, complex; add gc nilreg globals.
; 12/13/95 gb    add %builtin-functions% nrs, builtin-function-name-offset
; 12/09/95 bill  add to kernel imports: allocate_tstack, allocate_vstack, register_cstack
; 12/09/95 bill  gb: add nilreg-globals current-cs, current-vs,
;                current-ts, cs-overflow-limit, all-areas.
; 11/30/95 bill  comments on error numbers
; 11/10/95 gb    new type-error numbering.
; 10/30/95 bill  Add some cross-references to "ccl:pmcl;"
; 10/25/95 slh   updated *ppc-kernel-globals*

;; This file matches "ccl:pmcl;constants.h" & "ccl:pmcl;constants.s"

(defpackage "PPC" (:use "CL"))

(in-package "PPC")

; Some of these macros were stolen from CMUCL.  Sort of ...

#|
(defmacro iterate (name binds &body body)
  "Iterate Name ({(Var Initial-Value)}*) Declaration* Form*
  This is syntactic sugar for Labels.  It creates a local function Name with
  the specified Vars as its arguments and the Declarations and Forms as its
  body.  This function is then called with the Initial-Values, and the result
  of the call is return from the macro."
  (dolist (x binds)
    (unless (and (listp x)
                 (= (length x) 2))
      (error "Malformed iterate variable spec: ~S." x)))

  `(labels ((,name ,(mapcar #'first binds) ,@body))
     (,name ,@(mapcar #'second binds))))

(defmacro once-only (specs &body body)
  "Once-Only ({(Var Value-Expression)}*) Form*
  Create a Let* which evaluates each Value-Expression, binding a temporary
  variable to the result, and wrapping the Let* around the result of the
  evaluation of Body.  Within the body, each Var is bound to the corresponding
  temporary variable."
  (iterate frob
           ((specs specs)
            (body body))
    (if (null specs)
        `(progn ,@body)
        (let ((spec (first specs)))
          (when (/= (length spec) 2)
            (error "Malformed Once-Only binding spec: ~S." spec))
          (let ((name (first spec))
                (exp-temp (gensym)))
            `(let ((,exp-temp ,(second spec))
                   (,name (gensym)))
               `(let ((,,name ,,exp-temp))
                  ,,(frob (rest specs) body))))))))
|#


(eval-when (:compile-toplevel :load-toplevel :execute)
(defun form-symbol (first &rest others)
  (intern (apply #'concatenate 'simple-base-string (string first) (mapcar #'string others)) (find-package "PPC")))
)


#|
;;;; The Collect macro:

;;; Collect-Normal-Expander  --  Internal
;;;
;;;    This function does the real work of macroexpansion for normal collection
;;; macros.  N-Value is the name of the variable which holds the current
;;; value.  Fun is the function which does collection.  Forms is the list of
;;; forms whose values we are supposed to collect.
;;;
(eval-when (:compile-toplevel :load-toplevel :execute)


(defun collect-normal-expander (n-value fun forms)
  `(progn
     ,@(mapcar #'(lambda (form) `(setq ,n-value (,fun ,form ,n-value))) forms)
     ,n-value))

;;; Collect-List-Expander  --  Internal
;;;
;;;    This function deals with the list collection case.  N-Tail is the pointer
;;; to the current tail of the list, which is NIL if the list is empty.
;;;
(defun collect-list-expander (n-value n-tail forms)
  (let ((n-res (gensym)))
    `(progn
       ,@(mapcar #'(lambda (form)
                     `(let ((,n-res (cons ,form nil)))
                        (cond (,n-tail
                               (setf (cdr ,n-tail) ,n-res)
                               (setq ,n-tail ,n-res))
                              (t
                               (setq ,n-tail ,n-res  ,n-value ,n-res)))))
                 forms)
       ,n-value)))
)

;;;
;;;    The ultimate collection macro...
;;;
(defmacro collect (collections &body body)
  "Collect ({(Name [Initial-Value] [Function])}*) {Form}*
  Collect some values somehow.  Each of the collections specifies a bunch of
  things which collected during the evaluation of the body of the form.  The
  name of the collection is used to define a local macro, a la MACROLET.
  Within the body, this macro will evaluate each of its arguments and collect
  the result, returning the current value after the collection is done.  The
  body is evaluated as a PROGN; to get the final values when you are done, just
  call the collection macro with no arguments.

  Initial-Value is the value that the collection starts out with, which
  defaults to NIL.  Function is the function which does the collection.  It is
  a function which will accept two arguments: the value to be collected and the
  current collection.  The result of the function is made the new value for the
  collection.  As a totally magical special-case, the Function may be Collect,
  which tells us to build a list in forward order; this is the default.  If an
  Initial-Value is supplied for Collect, the stuff will be rplacd'd onto the
  end.  Note that Function may be anything that can appear in the functional
  position, including macros and lambdas."
  
  
  (let ((macros ())
        (binds ()))
    (dolist (spec collections)
      (unless (<= 1 (length spec) 3)
        (error "Malformed collection specifier: ~S." spec))
      (let ((n-value (gensym))
            (name (first spec))
            (default (second spec))
            (kind (or (third spec) 'collect)))
        
        (push `(,n-value ,default) binds)
        (if (eq kind 'collect)
          (let ((n-tail (gensym)))
            (if default
              (push `(,n-tail (last ,n-value)) binds)
              (push n-tail binds))
            (push `(,name (&rest args)
                          (collect-list-expander ',n-value ',n-tail args))
                  macros))
          (push `(,name (&rest args)
                        (collect-normal-expander ',n-value ',kind args))
                macros))))
    `(macrolet ,macros (let* ,(nreverse binds) ,@body))))
|#


;;; DEFENUM -- Internal Interface.
;;;
(defmacro defenum ((&key (prefix "") (suffix "") (start 0) (step 1))
                   &rest identifiers)
  (let ((results nil)
        (index 0)
        (start (eval start))
        (step (eval step)))
    (dolist (id identifiers)
      (multiple-value-bind
        (root docs)
        (if (consp id)
          (values (car id) (cdr id))
          (values id nil))
        (push `(defconstant ,(intern (concatenate 'simple-base-string
                                                  (string prefix)
                                                  (string root)
                                                  (string suffix)))
                 ,(+ start (* step index))
                 ,@docs)
              results))
      (incf index))
    `(eval-when (:compile-toplevel :load-toplevel :execute)
       ,@(nreverse results))))


(defmacro define-storage-layout (name origin &rest cells)
  `(progn
     (defenum (:start ,origin :step 4)
       ,@(mapcar #'(lambda (cell) (form-symbol name "." cell)) cells))
     (defconstant ,(form-symbol name ".SIZE") ,(* (length cells) 4))))
 
(defmacro define-lisp-object (name tagname &rest cells)
  `(define-storage-layout ,name ,(- (symbol-value tagname)) ,@cells))

(defmacro define-subtag (name tag subtag)
  `(defconstant ,(form-symbol "SUBTAG-" name) (logior ,tag (ash ,subtag ntagbits))))


(defmacro define-imm-subtag (name subtag)
  `(define-subtag ,name fulltag-immheader ,subtag))

(defmacro define-node-subtag (name subtag)
  `(define-subtag ,name fulltag-nodeheader ,subtag))

(defmacro define-fixedsized-object (name  &rest non-header-cells)
  `(progn
     (define-lisp-object ,name fulltag-misc header ,@non-header-cells)
     (defenum ()
       ,@(mapcar #'(lambda (cell) (form-symbol name "." cell "-CELL")) non-header-cells))
     (defconstant ,(form-symbol name ".ELEMENT-COUNT") ,(length non-header-cells))))



;; PPC-32 stuff and tags.
(eval-when (:compile-toplevel :load-toplevel :execute)
(defconstant nbits-in-word 32)
(defconstant least-significant-bit 31)
(defconstant nbits-in-byte 8)
(defconstant ntagbits 3)                ; But non-header objects only use 2
(defconstant nlisptagbits 2)
(defconstant nfixnumtagbits 2)          ; See ?
(defconstant num-subtag-bits 8)         ; tag part of header is 8 bits wide
(defconstant fixnumshift nfixnumtagbits)
(defconstant fixnum-shift fixnumshift)          ; A pet name for it.
(defconstant fulltagmask (1- (ash 1 ntagbits)))         ; Only needed by GC/very low-level code
(defconstant full-tag-mask fulltagmask)
(defconstant tagmask (1- (ash 1 nlisptagbits)))
(defconstant tag-mask tagmask)
(defconstant fixnummask (1- (ash 1 nfixnumtagbits)))
(defconstant fixnum-mask fixnummask)
(defconstant subtag-mask (1- (ash 1 num-subtag-bits)))
(defconstant ncharcodebits 16)
(defconstant charcode-shift (- nbits-in-word ncharcodebits))
(defconstant word-shift 2)

;; Tags.
;; There are two-bit tags and three-bit tags.
;; A FULLTAG is the value of the low three bits of a tagged object.
;; A TAG is the value of the low two bits of a tagged object.
;; A TYPECODE is either a TAG or the value of a "tag-misc" object's header-byte.

;; There are 4 primary TAG values.  Any object which lisp can "see" can be classified 
;; by its TAG.  (Some headers have FULLTAGS that are congruent modulo 4 with the
;; TAGS of other objects, but lisp can't "see" headers.)
(defenum ()
  tag-fixnum                            ; All fixnums, whether odd or even
  tag-list                              ; Conses and NIL
  tag-misc                              ; Heap-consed objects other than lists: vectors, symbols, functions, floats ...
  tag-imm                               ; Immediate-objects: characters, UNBOUND, other markers.
)

;; And there are 8 FULLTAG values.  Note that NIL has its own FULLTAG (congruent mod 4 to tag-list),
;; that FULLTAG-MISC is > 4 (so that code-vector entry-points can be branched to, since the low
;; two bits of the PC are ignored) and that both FULLTAG-MISC and FULLTAG-IMM have header fulltags
;; that share the same TAG.
;; Things that walk memory (and the stack) have to be careful to look at the FULLTAG of each
;; object that they see.
(defenum ()
  fulltag-even-fixnum                   ; I suppose EVENP/ODDP might care; nothing else does.
  fulltag-cons                          ; a real (non-null) cons.  Shares TAG with fulltag-nil.
  fulltag-nodeheader                    ; Header of heap-allocated object that contains lisp-object pointers
  fulltag-imm                           ; a "real" immediate object.  Shares TAG with fulltag-immheader.
  fulltag-odd-fixnum                    ; 
  fulltag-nil                           ; NIL and nothing but.  (Note that there's still a hidden NILSYM.)
  fulltag-misc                          ; Pointer "real" tag-misc object.  Shares TAG with fulltag-nodeheader.
  fulltag-immheader                     ; Header of heap-allocated object that contains unboxed data.
)


;;; Lisp registers.
(eval-when (:compile-toplevel :execute)
  (defmacro defregs (&body regs)
    `(progn
       (defenum () ,@regs)
       (defparameter *gpr-register-names* ,(coerce (mapcar #'string regs) 'vector))))
  (defmacro deffpregs (&body regs)
    `(progn
       (defenum () ,@regs)
       (defparameter *fpr-register-names* ,(coerce (mapcar #'string regs) 'vector))))
  (defmacro defvregs (&body regs)
    `(progn
      (defenum () ,@regs)
      (defparameter *vector-register-names* ,(coerce (mapcar #'string regs) 'vector)))))

(defregs
  rzero                                 ; Always contains 0; not as handy as it sounds.
  sp                                    ; The control stack.  Aligned on 16-byte boundary.
  rnil                                  ; Keep NIL here; don't use TOC.
  imm0                                  ; Unboxed, volatile registers.
  imm1 
  imm2 
  imm3 
  imm4
  nargs                                 ; Volatile.  SHOULDN'T be used for tag extraction. (TWI handler confusion.)
  freeptr                               ; Heap free pointer. Shared among lisp threads.
  initptr                               ; Heap initialization pointer.  Can't take an interrupt while consing.
  extra                                 ; Spare imm reg.
  tsp                                   ; Temp-stack pointer.
  vsp                                   ; Value stack pointer; grows towards 0.
  loc-g                                 ; Node locative
  loc-pc                                ; For return PC only.
  fn                                    ; Current function (constants vector).
  temp3                                 ; Boxed, volatile registers.  Some may be defined on function entry.
  temp2 
  temp1 
  temp0 
  arg_x                                 ; Next-to-next-to-last function argument.
  arg_y                                 ; Next-to-last function argument.
  arg_z                                 ; Last function argument.
  save7                                 ; Boxed, nonvolatile registers.
  save6
  save5
  save4 
  save3 
  save2 
  save1 
  save0
)

(deffpregs 
  fp0
  fp1
  fp2
  fp3
  fp4
  fp5
  fp6
  fp7
  fp8
  fp9
  fp10
  fp11
  fp12
  fp13
  fp14
  fp15
  fp16
  fp17
  fp18
  fp19
  fp20
  fp21
  fp22
  fp23
  fp24
  fp25
  fp26
  fp27
  fp28
  fp29
  fp30
  fp31)

(defvregs
  vr0					; General temp vector register
  vr1					; Most-significant quadword when word-aligning
  vr2					; Least-significant quadword when word-aligning
  vr3					; Operand A resulting from word-aligning
  vr4					; Operand B resulting from word-aligning
  vr5					; Result from operations on A and B
  vr6
  vr7
  vr8
  vr9
  vr10
  vr11
  vr12
  vr13
  vr14
  vr15
  vr16
  vr17
  vr18
  vr19
  ;;By convention, registers after this point are considered non-volatile. Callee should save.
  vr20
  vr21
  vr22
  vr23
  vr24
  vr25
  vr26
  vr27					; Permutation control register A for loads
  vr28					; Permutation control register B for stores
  vr29					; mask register
  vr30					; All zeros
  vr31					; All ones
  )

(defconstant fname temp3)

; Calling sequence may pass additional arguments in temp registers.
; "nfn" (new function) is always passed; it's the new value of "fn".
(defconstant nfn temp2)

; CLOS may pass the context for, e.g.., CALL-NEXT-METHOD in 
; the "next-method-context" register.
(defconstant next-method-context temp1)

; Closures receive a vector of "inherited arguments" in the
; "closure data" register.  The callee knows the inherited 
; arguments' locations within this vector and whether or not
; "value cells" are involved.
(defconstant closure-data temp0)

; It's handy to have 0.0 in an fpr.
(defconstant fp-zero fp31)

; Also handy to have #x4330000080000000 in an fpr, for s32->float conversion.
(defconstant fp-s32conv fp30)

; Order of CAR and CDR doesn't seem to matter much - there aren't
; too many tricks to be played with predecrement/preincrement addressing.
; Keep them in the confusing MCL 3.0 order, to avoid confusion.
(define-lisp-object cons tag-list 
  cdr 
  car)


(defconstant misc-header-offset (- fulltag-misc))
(defconstant misc-subtag-offset (+ misc-header-offset 3))
(defconstant misc-data-offset (+ misc-header-offset 4))
(defconstant misc-dfloat-offset (+ misc-header-offset 8))

(defconstant max-64-bit-constant-index (ash (+ #x7fff misc-dfloat-offset) -3))
(defconstant max-32-bit-constant-index (ash (+ #x7fff misc-data-offset) -2))
(defconstant max-16-bit-constant-index (ash (+ #x7fff misc-data-offset) -1))
(defconstant max-8-bit-constant-index (+ #x7fff misc-data-offset))
(defconstant max-1-bit-constant-index (ash (+ #x7fff misc-data-offset) 3))  ;; was 5


; T is almost adjacent to NIL: since NIL is a misaligned CONS, it spans
; two doublewords.  The arithmetic difference between T and NIL is
; such that the least-significant bit and exactly one other bit is
; set in the result.

(defconstant t-offset (+ 8 (- 8 fulltag-nil) fulltag-misc))
(assert (and (logbitp 0 t-offset) (= (logcount t-offset) 2)))


; The order in which various header values are defined is significant in several ways:
; 1) Numeric subtags precede non-numeric ones; there are further orderings among numeric subtags.
; 2) All subtags which denote CL arrays are preceded by those that don't,
;    with a further ordering which requires that (< header-arrayH header-vectorH ,@all-other-CL-vector-types)
; 3) The element-size of ivectors is determined by the ordering of ivector subtags.
; 4) All subtags are >= fulltag-immheader .


; Numeric subtags.
(define-imm-subtag bignum 0)
(defconstant min-numeric-subtag subtag-bignum)
(define-node-subtag ratio 1)
(defconstant max-rational-subtag subtag-ratio)

(define-imm-subtag single-float 1)          ; "SINGLE" float, aka short-float in the new order.
(define-imm-subtag double-float 2)
(defconstant min-float-subtag subtag-single-float)
(defconstant max-float-subtag subtag-double-float)
(defconstant max-real-subtag subtag-double-float)

(define-node-subtag complex 3)
(defconstant max-numeric-subtag subtag-complex)

; CL array types.  There are more immediate types than node types; all CL array subtags must be > than
; all non-CL-array subtags.  So we start by defining the immediate subtags in decreasing order, starting
; with that subtag whose element size isn't an integral number of bits and ending with those whose
; element size - like all non-CL-array fulltag-immheader types - is 32 bits.
(define-imm-subtag bit-vector 31)
(define-imm-subtag double-float-vector 30)
(define-imm-subtag s16-vector 29)
(define-imm-subtag u16-vector 28)
(define-imm-subtag simple-general-string 27)
(defconstant min-16-bit-ivector-subtag subtag-simple-general-string)
(defconstant max-16-bit-ivector-subtag subtag-s16-vector)
(defconstant max-string-subtag subtag-simple-general-string)

(define-imm-subtag simple-base-string 26)
(define-imm-subtag s8-vector 25)
(define-imm-subtag u8-vector 24)
(defconstant min-8-bit-ivector-subtag subtag-u8-vector)
(defconstant max-8-bit-ivector-subtag subtag-simple-base-string)
(defconstant min-string-subtag subtag-simple-base-string)

(define-imm-subtag s32-vector 23)
(define-imm-subtag u32-vector 22)
(define-imm-subtag single-float-vector 21)
(defconstant max-32-bit-ivector-subtag subtag-s32-vector)
(defconstant min-cl-ivector-subtag subtag-single-float-vector)

(define-node-subtag vectorH 21)
(define-node-subtag arrayH 20)
(assert (< subtag-arrayH subtag-vectorH min-cl-ivector-subtag))
(define-node-subtag simple-vector 22)   ; Only one such subtag
(assert (< subtag-arrayH subtag-vectorH subtag-simple-vector))
(defconstant min-vector-subtag subtag-vectorH)
(defconstant min-array-subtag subtag-arrayH)

; So, we get the remaining subtags (n: (n > max-numeric-subtag) & (n < min-array-subtag))
; for various immediate/node object types.

(define-imm-subtag macptr 3)
(defconstant min-non-numeric-imm-subtag subtag-macptr)
(assert (> min-non-numeric-imm-subtag max-numeric-subtag))
(define-imm-subtag dead-macptr 4)
(define-imm-subtag code-vector 5)
(define-imm-subtag creole-object 6)

(defconstant max-non-array-imm-subtag (logior (ash 19 ntagbits) fulltag-immheader))

(define-node-subtag catch-frame 4)
(defconstant min-non-numeric-node-subtag subtag-catch-frame)
(assert (> min-non-numeric-node-subtag max-numeric-subtag))
(define-node-subtag function 5)
(define-node-subtag slot-vector 6)
(define-node-subtag symbol 7)
(define-node-subtag lock 8)
(define-node-subtag hash-vector 9)
(define-node-subtag pool 10)
(define-node-subtag weak 11)
(define-node-subtag package 12)
(define-node-subtag mark 13)
(define-node-subtag instance 14)
(define-node-subtag struct 15)
(define-node-subtag istruct 16)
(define-node-subtag value-cell 17)

(defconstant max-non-array-node-subtag (logior (ash 19 ntagbits) fulltag-nodeheader))


; The objects themselves look something like this:

(define-fixedsized-object ratio
  numer
  denom)

(define-fixedsized-object single-float
  value)

(define-fixedsized-object double-float
  pad
  value
  val-low)

(define-fixedsized-object complex
  realpart
  imagpart
)

(define-fixedsized-object one-digit-bignum
  value)

(defconstant two-digit-bignum.size 16)


; There are two kinds of macptr; use the length field of the header if you
; need to distinguish between them
(define-fixedsized-object macptr
  address
)

(define-fixedsized-object xmacptr
  address
  flags
  link
)

; Catch frames go on the tstack; they point to a minimal lisp-frame
; on the cstack.  (The catch/unwind-protect PC is on the cstack, where
; the GC expects to find it.)
(define-fixedsized-object catch-frame
  catch-tag                             ; #<unbound> -> unwind-protect, else catch
  link                                  ; tagged pointer to next older catch frame
  mvflag                                ; 0 if single-value, 1 if uwp or multiple-value
  csp                                   ; pointer to control stack
  db-link                               ; value of dynamic-binding link on thread entry.
  save-save7                            ; saved registers
  save-save6
  save-save5
  save-save4
  save-save3
  save-save2
  save-save1
  save-save0
  xframe                                ; exception-frame link
  tsp-segment                           ; mostly padding, for now.
)



  
(define-fixedsized-object lock
  _value
)

#|
(define-fixedsized-object sgbuf
  next
  prev
  name
  sg
  resumer
  csbuf
  vsbuf
  tempvbuf
  cslimit
  maxsize
)
|#

(define-fixedsized-object symbol
  pname
  vcell
  fcell
  package-plist
  flags
)

(defconstant nilsym-offset (+ t-offset symbol.size))


(define-fixedsized-object vectorH
  logsize                               ; fillpointer if it has one, physsize otherwise
  physsize                              ; total size of (possibly displaced) data vector
  data-vector                           ; object this header describes
  displacement                          ; true displacement or 0
  flags                                 ; has-fill-pointer,displaced-to,adjustable bits; subtype of underlying simple vector.
)

(define-lisp-object arrayH fulltag-misc
  header                                ; subtag = subtag-arrayH
  rank                                  ; NEVER 1
  physsize                              ; total size of (possibly displaced) data vector
  data-vector                           ; object this header describes
  displacement                          ; true displacement or 0  
  flags                                 ; has-fill-pointer,displaced-to,adjustable bits; subtype of underlying simple vector.
 ;; Dimensions follow
)

(defconstant arrayH.rank-cell 0)
(defconstant arrayH.physsize-cell 1)
(defconstant arrayH.data-vector-cell 2)
(defconstant arrayH.displacement-cell 3)
(defconstant arrayH.flags-cell 4)
(defconstant arrayH.dim0-cell 5)

(defconstant arrayH.flags-cell-bits-byte (byte 8 0))
(defconstant arrayH.flags-cell-subtag-byte (byte 8 8))


(define-fixedsized-object value-cell
  value)

(define-storage-layout lisp-frame 0
  backlink
  savefn
  savelr
  savevsp
)

(define-storage-layout c-frame 0
  backlink
  crsave
  savelr
  unused-1
  unused-2
  savetoc
  param0
  param1
  param2
  param3
  param4
  param5
  param6
  param7
  slop-1
  slop-2
)

(defconstant c-frame.minsize c-frame.size)

;;; The kernel uses these (rather generically named) structures
;;; to keep track of various memory regions it (or the lisp) is
;;; interested in.
;;; The gc-area record definition in "ccl:interfaces;mcl-records.lisp"
;;; matches this.
(define-storage-layout area 0
  pred                                  ; pointer to preceding area in DLL
  succ                                  ; pointer to next area in DLL
  low                                   ; low bound on area addresses
  high                                  ; high bound on area addresses.
  active                                ; low limit on stacks, high limit on heaps
  softlimit                             ; overflow bound
  hardlimit                             ; another one
  code                                  ; an area-code; see below
  markbits                              ; bit vector for GC
  ndwords                               ; "active" size of dynamic area or stack
  older                                 ; in EGC sense
  younger                               ; also for EGC
  h                                     ; Handle or null pointer
  softprot                              ; protected_area structure pointer
  hardprot                              ; another one.
  owner                                 ; fragment (library) which "owns" the area
  refbits                               ; bitvector for intergenerational refernces
  threshold                             ; for egc
  gc-count                              ; generational gc count.
)

(defenum (:prefix "AREA-")
  void                                  ; list header
  cstack                                ; a control stack
  vstack                                ; a value stack
  tstack                                ; (dynamic-extent) temp stack
  readonly                              ; readonly section
  staticlib                             ; static data in library
  static                                ; static data in application
  dynamic                               ; dynmaic (heap) data in application
)

(define-storage-layout protected-area 0
  next
  start                                 ; first byte (page-aligned) that might be protected
  end                                   ; last byte (page-aligned) that could be protected
  nprot                                 ; Might be 0
  protsize                              ; number of bytes to protect
  why)

; areas are sorted such that (in the "succ" direction) codes are >=.
; If you think that you're looking for a stack (instead of a heap), look
; in the "pred" direction from the all-areas header.
(defconstant max-stack-area-code area-tstack)
(defconstant min-heap-area-code area-readonly)

(define-subtag unbound fulltag-imm 6)
(defconstant unbound-marker subtag-unbound)
(defconstant undefined unbound-marker)

(define-subtag slot-unbound fulltag-imm 13)
(defconstant slot-unbound-marker subtag-slot-unbound)

(define-subtag character fulltag-imm 9)
(define-subtag vsp-protect fulltag-imm 7)
(define-subtag illegal fulltag-imm 10)
(defconstant illegal-marker subtag-illegal)
(define-subtag go-tag fulltag-imm 12)
(define-subtag block-tag fulltag-imm 24)

(defenum ()
  regclass-gpr                          ; 32 general-purpose registers
  regclass-fpr                          ; 32 floating-point registers
  regclass-crf                          ; 8 fields in CR register
  regclass-misc                         ; CR,XER,LR,CTR,FPSCR, ...
)

(defenum ()
  storage-class-lisp                    ; General lisp objects
  storage-class-imm                     ; Fixnums, chars, NIL: not relocatable
  storage-class-wordptr                 ; "Raw" (fixnum-tagged) pointers to stack,etc
  storage-class-u8                      ; Unsigned, untagged, 8-bit objects
  storage-class-s8                      ; Signed, untagged, 8-bit objects
  storage-class-u16                     ; Unsigned, untagged, 16-bit objects
  storage-class-s16                     ; Signed, untagged, 16-bit objects
  storage-class-u32                     ; Unsigned, untagged, 8-bit objects
  storage-class-s32                     ; Signed, untagged, 8-bit objects
  storage-class-address                 ; "raw" (untagged) 32-bit addresses.
  storage-class-single-float            ; 32-bit single-float objects
  storage-class-double-float            ; 64-bit double-float objects
  storage-class-pc                      ; pointer to/into code vector
  storage-class-locative                ; pointer to/into node-misc object
  storage-class-crf                     ; condition register field
  storage-class-crbit                   ; condition register bit: 0-31
  storage-class-crfbit                  ; bit within condition register field : 0-3
)
)

(defmacro make-vheader (element-count subtag)
  `(logior ,subtag (ash ,element-count 8)))

;; The PPC thinks that the most significant bit of an integer is bit 0
;; and the least significant bit is bit 31.  Sheesh.
(defmacro ppc-bitnum (bit)
  `(- 31 ,bit))

(defmacro ppc-fixnum (val)
  `(ash ,val fixnum-shift))

(defmacro unbox-ppc-fixnum (f)
  `(ash ,f (- fixnum-shift)))


; Kernel globals are allocated "below" nil.  This list (used to map symbolic names to
; rnil-relative offsets) must (of course) exactly match the kernel's notion of where 
; things are.
; The order here matches "ccl:pmcl;lisp_globals.h" & the lisp_globals record
; in "ccl:pmcl;constants.s"
(defparameter *ppc-kernel-globals*
  '(catch-top                           ; pointer to active catch frame
    db-link                             ; head of special-binding linked-list.
    save-freeptr                        ; someplace to keep freeptr when in foreign context
    kernel-imports                      ; some things we need to have imported for us.
    xframe                              ; head of exception frame list.
    emulator-registers                  ; Where the 68K registers are kept.
    appmain                             ; application's (c-runtime) main() function
    subprims-base                       ; start of dynamic subprims jump table
    ret1valaddr                         ; magic multiple-values return address.
    save-vsp                            ; where ff-call puts this thread's vsp.
    save-tsp                            ; where ff-call puts this thread's tsp.
    save-memo                           ; memo stack pointer when not in some lisp thread.
    go-tag-counter        		; counter for (immediate) go tag
    block-tag-counter                   ; counter for (immediate) block tag
    os-trap-base                        ; os trap table
    tb-trap-base                        ; TB trap table
    os-trap-call                        ; callostrapunivesalproc's descriptor
    tb-trap-call                        ; CallUniversalProc's descriptor
    subprims-end                          ; end of subprims
    fwdnum                              ; fixnum: GC "forwarder" call count.
    gc-count                            ; fixnum: GC call count.
    gcable-pointers                     ; linked-list of weak macptrs.
    heap-start                          ; start of lisp heap
    heap-end                            ; end of lisp heap
    current-cs                          ; current control-stack area
    current-vs                          ; current value-stack area
    current-ts                          ; current temp-stack area
    cs-overflow-limit                   ; limit for control-stack overflow check
    all-areas                           ; doubly-linked area list
    lexpr-return                        ; multiple-value lexpr return address
    lexpr-return1v                      ; single-value lexpr return address
    in-gc                               ; non-zero when GC-ish thing active
    metering-info                       ; kernel metering structure
    doh-head                            ; creole
    short-float-zero                    ; low half of 1.0d0
    double-float-one                    ; high half of 1.0d0
    ffi-exception                       ; ffi fpscr[fex] bit
    exception-saved-registers           ; saved registers from exception frame
    oldest-ephemeral                    ; doubleword address of oldest ephemeral object or 0
    tenured-area                        ; the tenured_area.
    native-kernel-version               ; OSX native kernel version or 0.
    refbits
    heap-limit
    j-extend-heap
    oldspace-dnode-count
    ts-overflow-limit
    vs-overflow-limit   
    ))

(defun %kernel-global (sym)
  (let* ((pos (position sym *ppc-kernel-globals* :test #'string=)))
    (if pos
      (- (+ fulltag-nil (* (1+ pos) 4)))
      (error "Unknown kernel global : ~s ." sym))))

(defmacro kernel-global (sym)
  (let* ((pos (position sym *ppc-kernel-globals* :test #'string=)))
    (if pos
      (- (+ fulltag-nil (* (1+ pos) 4)))
      (error "Unknown kernel global : ~s ." sym))))

(defenum (:prefix "PPC-" :suffix "-BIT")
  lt
  gt
  eq
  so
)

; The kernel imports things that are defined in various other libraries for us.
; The objects in question are generally fixnum-tagged; the entries in the
; "kernel-imports" vector are 4 bytes apart.
(defenum (:prefix "KERNEL-IMPORT-" :start 0 :step 4)
  read                                  ; MPW runtime I/O functions
  write
  open
  close
  ioctl
  MakeDataExecutable
  GetSharedLibrary
  FindSymbol
  CountSymbols
  GetIndSymbol
  allocate_tstack
  allocate_vstack
  register_cstack
  condemn-area
  metering-control
  excise-library
  egc-control
  lisp-bug
  xNewThread
  xYieldToThread
  xThreadCurrentStackSpace
  xDisposeThread
  lock-binding-stack
  unlock-binding-stack
  remove-tmtask
  restore-tmtask
  start-vbl
  __CFStringMakeConstantString
  CFBundleGetFunctionPointerForName
  FSFindFolder
  CFURLCreateFromFSRef
  CFURLCreateCopyAppendingPathComponent
  CFBundleCreate
  CFBundleLoadExecutable
  CFStringCreateWithCString
  CFRelease
  CFBundleGetBundleWithIdentifier
  PBHOpenSync        ;; for fasload
  PBGetEOFSync
  PBCloseSync
  PBReadSync
  PBSetFPosSync
)

(defmacro define-header (name element-count subtag)
  `(defconstant ,name (logior (ash ,element-count num-subtag-bits) ,subtag)))

(define-header single-float-header single-float.element-count subtag-single-float)
(define-header double-float-header double-float.element-count subtag-double-float)
(define-header one-digit-bignum-header 1 subtag-bignum)
(define-header two-digit-bignum-header 2 subtag-bignum)
(define-header symbol-header symbol.element-count subtag-symbol)
(define-header value-cell-header value-cell.element-count subtag-value-cell)
(define-header macptr-header macptr.element-count subtag-macptr)


;; Error numbers, as used in UU0s and such.
;; These match "ccl:pmcl;errors.h" & "ccl:pmcl;errors.s"

(defconstant error-reg-regnum 0)        ; "real" error number is in RB field of UU0.
                                        ; Currently only used for :errchk in emulated traps
                                        ; The errchk macro should expand into a check-trap-error vinsn, too.
(defconstant error-udf 1)               ; Undefined function (reported by symbol-function)
(defconstant error-udf-call 2)          ; Attempt to call undefined function
(defconstant error-throw-tag-missing 3)
(defconstant error-alloc-failed 4)      ; can't allocate (largish) vector
(defconstant error-stack-overflow 5)    ; some stack overflowed.
(defconstant error-excised-function-call 6)     ; excised function was called.
(defconstant error-too-many-values 7)   ; too many values returned
(defconstant error-cant-call 17)        ; Attempt to funcall something that is not a symbol or function.

(defconstant error-unbound 18)
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defconstant error-type-error 64)
  (defconstant error-subtag-error 256)
)

(defconstant error-fpu-exception-double 1024)   ; FPU exception, binary double-float op
(defconstant error-fpu-exception-single 1025)

(defconstant error-memory-full 2048)

;; These are now supposed to match (mod 64) the %type-error-typespecs%
;; array that %err-disp looks at.
(defenum (:start  error-type-error :prefix "ERROR-OBJECT-NOT-")
  array
  bignum
  fixnum
  character
  integer
  list
  number
  sequence
  simple-string
  simple-vector
  string
  symbol
  macptr
  real
  cons
  unsigned-byte
  radix
  float  
  rational
  ratio
  short-float
  double-float
  complex
  vector
  simple-base-string
  function
  unsigned-byte-16
  unsigned-byte-8
  unsigned-byte-32
  signed-byte-32
  signed-byte-16
  signed-byte-8
  base-character
  bit
  unsigned-byte-24
  uvector
  )

; The order here matches "ccl:pmcl;lisp_globals.h" and the nrs record
; in "ccl:pmcl;constants.s".
(defparameter *ppc-nilreg-relative-symbols*
  '(t nil ccl::%err-disp ccl::cmain eval ccl::apply-evaluated-function error ccl::%defun 
    ccl::%defvar ccl::%defconstant ccl::%macro ccl::%kernel-restart *package* 
    ccl::*interrupt-level* :allow-other-keys ccl::%toplevel-catch% ccl::%toplevel-function% 
    ccl::%pascal-functions% ccl::*all-metered-functions* ccl::*%dynvfp%* ccl::*%dynvlimit%*
    ccl::%unbound-function% ccl::*foreground* ccl:*background-sleep-ticks* 
    ccl:*foreground-sleep-ticks* ccl::*window-update-wptr* ccl::*gc-event-status-bits* 
    ccl::*pre-gc-hook* ccl::*post-gc-hook* ccl::%handlers% ccl::%parse-string% 
    ccl::%all-packages% ccl::*keyword-package* ccl::%saved-method-var% 
    ccl::%finalization-alist% ccl::*current-stack-group* ccl::%closure-code%
    ccl::%macro-code% ccl::%init-misc ccl::%builtin-functions%
    ccl::*total-gc-microseconds* ccl::*total-bytes-freed*
    ccl::resolve-slep-address ccl::%excised-code% ccl::%new-gcable-ptr
    ccl::*current-cursor* ccl::*cs-segment-size* ccl::*vs-segment-size*
    ccl::*ts-segment-size* ccl::*cs-hard-overflow-size* ccl::*cs-soft-overflow-size*
    ccl::cs-overflow-callback ccl::*gc-cursor*))

(defmacro nrs-offset (name)
  (let* ((pos (position name *ppc-nilreg-relative-symbols* :test #'eq)))
    (if pos (+ t-offset (* pos symbol.size)))))

(defun builtin-function-name-offset (name)
  (and name (position name ccl::%builtin-functions% :test #'eq)))

(defenum (:prefix "FPSCR-" :suffix "-BIT")
  fx
  fex
  vx
  ox
  ux
  zx
  xx
  vxsnan
  vxisi
  vxidi
  vxzdz
  vximz
  vxvc
  fr
  fi
  fprfc
  fl
  fg
  fe
  fu
  nil
  vxsoft
  vxsqrt
  vxcvi
  ve
  oe
  ue
  ze
  xe
  ni
  rn0
  rn1
)


(ccl::provide "PPC-ARCH")
