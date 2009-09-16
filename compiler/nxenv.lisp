;-*- Mode: Lisp; Package: CCL -*-

;; $Log: nxenv.lisp,v $
;; Revision 1.5  2003/12/08 08:21:54  gtbyers
;; Operators for %SLOT-UNBOUND-MARKER, %SLOT-REF.
;;
;; Revision 1.4  2003/12/01 17:56:05  gtbyers
;; recover pre-MOP changes
;;
;; Revision 1.2  2002/11/18 05:35:13  gtbyers
;; Add CVS log marker
;;
;;	Change History (most recent first):
;;  4 7/4/97   akh  short float stuff
;;  3 6/16/96  akh  %%ineq
;;  2 5/20/96  akh  add double-float-2! foos to *next-nx-operators*
;;  10 3/14/96 bill 3.1d77
;;  8 1/22/96  gb   3.0x61
;;  7 1/5/96   bill 3.0x58
;;  6 1/2/96   gb   3.0x57
;;  5 12/22/95 gb   some PPC-TARGET changes.  Don't include subprims-8
;;  2 10/14/95 gb   New operator for double-float comparisons.
;;  3 2/3/95   akh  merge with leibniz patches
;;  (do not edit before this line!!)

; Compile-time environment for the compiler.

; Modification Hsitory
;
; 06/26/99 akh   values decl (does nothing) - ????
; --------- 4.3b3
; 03/30/99 akh   destructive decl
; 12/31/98 akh   add operators for 2d-float-aref/aset
; 03/21/97 gb    $return, $mvpass, etc.: #-ppc-target.
; -------------- 4.1b1
; 02/14/97 gb    short-float stuff.
; 01/24/97 bill  point-h & point-v => integer-point-h & integer-point-v
; -------------- 4.0
; 06/20/96 gb    %debug-trap.
; akh double-float-2! foos to *next-nx-operators*
; 03/01/96 bill add ff-call-slep to *next-nx-operators*
; 03/10/96 gb   double-float ops
; 01/19/96 gb   $numargregs isn't needed for PPC.  Add
;               %setf-double-float operator.
; 01/04/96 bill $numargregs is needed for PPC
; 12/27/95 gb  conditionalize for ppc
; 12/13/95 gb   builtin-call operator
; 11/14/95 slh   mods. for PPC target
; 10/14/93 bill  add types to def-accessors for inspector
;--------------  3.0d13
; 06/02/93 alice %set-scharcode
; 05/16/93 alice add %sbchar and %sechar and %scharcode to *next-nx-operators*
; 08/26/91 bill  no more compiler support for with-port
; 02/21/91 alice compiler; => ccl:compiler;
;-------------- 2.0b1
;07/05/90 bill $fbitnextmethargsp
;04/30/90 gb   lotsa changes.
;18-Nov-89 gb $undoprotect => $undonotail
;09/27/89 gb progv a special form.
;09/17/89 gb forget ask & usual.
;05/23/89 gb %f+,%f-,%f* (sort of.)
;4/20/89  gz lambda-bind.
;4/14/89  gz added $lea-atemp0, $cmpi.l, ea-modereg.
;03/10/89 gz record source files for defnx[12]. $fbitmethodp.
;12/29/88 gz added %schar, %set-schar.
;12/04/88 gz added %primitive, removed memq, assq, etc.
;11/15/88 gz added %new-ptr, removed %vstack-block.
; 8/25/88 gb added $undomvexpect
; 9/2/88  gz no more list-reverse, no more with-macptrs.
; 8/23/88 gz removed inherited-blocks/tags, added warnings.  Removed some
;            constants now in lispequ.
; 8/20/88 gz new scheme for distinguishing real special forms.
; 8/16/88 gz eql.
; 8/13/88 gb %function, set.
; 8/3/88 gz bind *nx-compile-time-object-variables* in with-declarations.

(in-package :ccl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (proclaim '(declaration destructive)))


(eval-when (:compile-toplevel :load-toplevel :execute)
  (proclaim '(declaration values)))


(eval-when (:execute :compile-toplevel)
  (require'backquote)
  (require 'lispequ)
  #-ppc-target (require 'lapmacros))

(defconstant $afunc-size 
  (def-accessors (afunc) %svref
    ()                                    ; 'afunc
    afunc-acode
    afunc-parent
    afunc-vars
    afunc-inherited-vars
    afunc-blocks
    afunc-tags
    afunc-inner-functions
    afunc-name
    afunc-bits
    afunc-lfun
    afunc-environment
    afunc-lambdaform
    afunc-argsword
    afunc-ref-form
    afunc-warnings
    afunc-fn-refcount
    afunc-fn-downward-refcount
    afunc-all-vars
    afunc-callers
    afunc-vcells
    afunc-fcells
    afunc-fwd-refs
    afunc-lfun-info
    afunc-linkmap
))

;

(def-accessors (compiler-policy) uvref
  nil                                   ; 'compiler-policy
  policy.allow-tail-recursion-elimination
  policy.inhibit-register-allocation
  policy.trust-declarations
  policy.open-code-inline
  policy.inhibit-safety-checking
  policy.inhibit-event-checking
  policy.inline-self-calls
  policy.allow-transforms
  policy.force-boundp-checks
  policy.allow-constant-substitution
  policy.misc)

(defconstant $vbitareg 16)   ; Would prefer an address register, if possible.
(defconstant $vbitreg 17)          ; really wants to live in a register.
(defconstant $vbitnoreg 18)        ; something inhibits register allocation
(defconstant $vbitdynamicextent 19)
(defconstant $vbitparameter 20)    ; iff special
(defconstant $vbitpunted 20)       ; iff lexical
(defconstant $vbitignoreunused 21)
(defconstant $vbitcloseddownward 22)  
(defconstant $vbitsetq 23)
(defconstant $vbitpuntable 24)
(defconstant $vbitclosed 25)
(defconstant $vbitignore 26)
(defconstant $vbitreffed 27)
(defconstant $vbitspecial 28)
(defconstant $vbitdestructive 29)  ;; can be bashed ??
(defconstant $vsetqmask #xff00)
(defconstant $vrefmask #xff)

(defconstant $decl_optimize (%ilsl 16 0))
(defconstant $decl_tailcalls (%ilsl 16 1))
(defconstant $decl_noforcestk (%ilsl 16 2))
(defconstant $decl_opencodeinline (%ilsl 16 4))
(defconstant $decl_eventchk (%ilsl 16 8))
(defconstant $decl_unsafe (%ilsl 16 16))
(defconstant $decl_trustdecls (%ilsl 16 32))

(defconstant $regnote-ea 1)

(defmacro nx-null (x)
 `(eq ,x *nx-nil*))

(defmacro nx-t (x)
 `(eq ,x *nx-t*))

(eval-when (:compile-toplevel :load-toplevel :execute)

(defconstant operator-id-mask (1- (%ilsl 10 1)))
(defconstant operator-acode-subforms-bit 10)
(defconstant operator-acode-subforms-mask (%ilsl operator-acode-subforms-bit 1))
(defconstant operator-acode-list-bit 11)
(defconstant operator-acode-list-mask (%ilsl operator-acode-list-bit 1))
(defconstant operator-side-effect-free-bit 12) ; operator is side-effect free; subforms may not be ...
(defconstant operator-side-effect-free-mask 
  (%ilsl operator-side-effect-free-bit 1))
(defconstant operator-single-valued-bit 13)
(defconstant operator-single-valued-mask
  (%ilsl operator-single-valued-bit 1))
(defconstant operator-assignment-free-bit 14)
(defconstant operator-assignment-free-mask
  (%ilsl operator-assignment-free-bit 1))
(defconstant operator-cc-invertable-bit 15)
(defconstant operator-cc-invertable-mask (ash 1 operator-cc-invertable-bit))
(defconstant operator-boolean-bit 16)
(defconstant operator-boolean-mask (ash 1 operator-boolean-bit))
(defconstant operator-returns-address-bit 17)
(defconstant operator-returns-address-mask (ash 1 operator-returns-address-bit))

)


(defparameter *next-nx-operators*
 (reverse
  '((%primitive . 0)
    (progn . #.(logior operator-acode-list-mask operator-assignment-free-mask operator-side-effect-free-mask))
    (not . #.(logior operator-single-valued-mask operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-cc-invertable-mask))
    (%i+ . #.(logior operator-single-valued-mask operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%i- . #.(logior operator-single-valued-mask operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (cxxr . #.(logior operator-single-valued-mask operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%dfp-combine . 0)
    (%ilsl . #.(logior operator-single-valued-mask operator-assignment-free-mask operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%ilogand2 . #.(logior operator-single-valued-mask operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%ilogior2 . #.(logior operator-single-valued-mask operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%ilogbitp . #.(logior operator-single-valued-mask operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-cc-invertable-mask))
    (eq . #.(logior operator-single-valued-mask operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-cc-invertable-mask))
    (neq . #.(logior operator-single-valued-mask operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-cc-invertable-mask))
    (list . #.(logior operator-single-valued-mask operator-assignment-free-mask operator-acode-list-mask operator-side-effect-free-mask))
    (values . #.(logior operator-acode-list-mask operator-assignment-free-mask operator-side-effect-free-mask))
    (if . #.(logior operator-acode-subforms-mask operator-side-effect-free-mask))
    (or . 0)
    (without-interrupts . 0)
    (strap-selector-save . #.operator-single-valued-mask)
    (strap-selector-last . #.operator-single-valued-mask)
    (%register-trap . #.operator-single-valued-mask)
    (%stack-trap . #.operator-single-valued-mask)
    (multiple-value-prog1 . 0)
    (multiple-value-bind . 0)
    (multiple-value-call . 0)
    (put-xxx . #.operator-single-valued-mask)
    (get-xxx . #.operator-single-valued-mask)
    (typed-form . 0)
    (let . 0)
    (let* . 0)
    (tag-label . 0)
    (local-tagbody . #.operator-single-valued-mask)
    (spushw . #.operator-single-valued-mask)
    (spushl . #.operator-single-valued-mask)
    (spushp . #.operator-single-valued-mask)
    (simple-function . #.operator-single-valued-mask)
    (closed-function . #.operator-single-valued-mask)
    (setq-lexical . #.operator-single-valued-mask)
    (lexical-reference . #.(logior operator-assignment-free-mask operator-single-valued-mask))
    (free-reference . #.(logior operator-assignment-free-mask operator-single-valued-mask))
    (immediate . #.(logior operator-assignment-free-mask operator-single-valued-mask))
    (fixnum . #.(logior operator-assignment-free-mask operator-single-valued-mask ))
    (call . #.operator-side-effect-free-mask)
    (local-go . 0)
    (local-block . 0)
    (local-return-from . 0)
    (%car . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%cdr . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%rplaca . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (%rplacd . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (cons . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask))
    (aref2 . #.(logior operator-acode-subforms-mask operator-assignment-free-mask operator-single-valued-mask))
    (setq-free . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (prog1 . 0)
    (catch . 0)
    (throw . 0)
    (unwind-protect . 0)
    (characterp . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-cc-invertable-mask))
    (multiple-value-list . 0)
    (%izerop . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-cc-invertable-mask))
    (%immediate-ptr-to-int . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%immediate-int-to-ptr . #.(logior operator-returns-address-mask operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (immediate-get-xxx . 0)
    (immediate-put-xxx . 0)
    (setq-special . 0)
    (special-ref . 0)
    (1+ . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (1- . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (add2 . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (sub2 . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (numeric-comparison . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-cc-invertable-mask))
    (num= . #.(logior operator-assignment-free-mask operator-acode-subforms-mask operator-single-valued-mask operator-cc-invertable-mask))
    (struct-ref . 0)
    (struct-set . 0)
    (%aref1 . #.(logior operator-acode-subforms-mask operator-assignment-free-mask operator-single-valued-mask))
    (embedded-nlexit . 0)
    (embedded-conditional . 0) 
    (%word-to-int . #.(logior operator-assignment-free-mask operator-single-valued-mask))
    (%svref . #.(logior operator-acode-subforms-mask operator-assignment-free-mask operator-single-valued-mask))
    (%svset . #.(logior operator-acode-subforms-mask operator-single-valued-mask))
    (%consmacptr% . 0)
    (%macptrptr% . 0)
    (%ptr-eql . #.operator-cc-invertable-mask)
    (%setf-macptr . 0)
    (bound-special-ref . 0)
    (%char-code . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%code-char . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (lap . 0)
    (lap-inline . 0)
    (%function . #.operator-single-valued-mask)
    (%ttagp . #.(logior operator-cc-invertable-mask operator-single-valued-mask))
    (%ttag . #.operator-single-valued-mask)  
    (uvsize . #.operator-single-valued-mask)
    (endp . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-cc-invertable-mask))
    (sequence-type . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-cc-invertable-mask))
    (fixnum-overflow . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (vector . #.(logior operator-assignment-free-mask operator-single-valued-mask))
    (%immediate-inc-ptr . #.(logior operator-returns-address-mask operator-single-valued-mask))
    (2d-simple-aref . 0)
    (2d-simple-aset . 0)
    (%new-ptr . 0)
    (%schar . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%set-schar . #.(logior operator-single-valued-mask operator-acode-subforms-mask))  ;??
    (debind . 0)
    (lambda-bind . 0)
    (%f+ . 0)
    (%f- . 0)
    (%f* . 0)
    (nth-value . 0)
    (progv . 0)
    (svref . #.(logior operator-assignment-free-mask operator-single-valued-mask))
    (svset . #.operator-single-valued-mask)
    (make-list . #.(logior operator-assignment-free-mask operator-single-valued-mask))  ; exists only so we can stack-cons
    (%badarg1 . 0)
    (%badarg2 . 0)
    (newblocktag . 0)
    (newgotag . 0)
    (flet . 0)       ; may not be necessary - for dynamic-extent, mostly
               ; for dynamic-extent, forward refs, etc.
    (labels . 0) ; removes 75% of LABELS bogosity
    (lexical-function-call . 0) ; most of other 25%
    (with-downward-closures . 0)
    (self-call . 0)
    (inherited-arg . #.operator-single-valued-mask)
    (ff-call . 0)
    (commutative-subprim-binop . 0)
    (%immediate-set-xxx . #.(logior operator-acode-subforms-mask operator-side-effect-free-mask))
    (symbol-name . #.(logior operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (memq . #.(logior operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (assq . #.(logior operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (aset2 . #.(logior operator-acode-subforms-mask operator-single-valued-mask))
    (consp . #.(logior operator-cc-invertable-mask operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-boolean-mask))
    (aset1 . #.(logior operator-acode-subforms-mask))
    (embedded-call . 0)
    (car . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (cdr . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (length . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (list-length . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (ensure-simple-string . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%ilsr . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (set . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (eql . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-boolean-mask))
    (%iasr . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    
    (logand2 . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (logior2 . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (logxor2 . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%i<> . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-cc-invertable-mask))
    (set-car . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (set-cdr . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (rplaca . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (rplacd . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%vreflet . 0)
    (uvref . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (uvset . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%temp-cons . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%temp-List . #.(logior operator-single-valued-mask operator-side-effect-free-mask))
    (%make-uvector . #.(logior operator-assignment-free-mask operator-single-valued-mask  operator-side-effect-free-mask))
    (%decls-body . 0)
    (%gvector . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%typed-uvref . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%typed-uvset . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (schar . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (set-schar . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (code-char . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (char-code . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (list* . #.(logior operator-assignment-free-mask operator-single-valued-mask  operator-side-effect-free-mask))
    (append . #.(logior operator-assignment-free-mask operator-single-valued-mask  operator-side-effect-free-mask))
    (symbolp . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-boolean-mask))
    (integer-point-h . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (integer-point-v . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (int>0-p . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-cc-invertable-mask))
    (dtagp . #.operator-cc-invertable-mask)
    (with-stack-double-floats . 0)
    (short-float . #.operator-single-valued-mask)
    (struct-typep . 0)
    (%ilogxor2 . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%err-disp . 0)
    (%quo2 . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (minus1 . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%ineg . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%i* . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (logbitp . #.(logior operator-single-valued-mask operator-assignment-free-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-boolean-mask))
    (%sbchar . 0)
    (%sechar . 0)
    (%set-sbchar . 0)
    (%scharcode . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%set-scharcode . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (lambda-list . 0)
    (ppc-lap-function . 0)
    (ppc-lisptag . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (ppc-fulltag . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (ppc-typecode . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (require-simple-vector . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (require-simple-string . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (require-integer . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (require-fixnum . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (require-real . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (require-list . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (require-character . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (require-number . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (require-symbol . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (base-character-p . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-cc-invertable-mask))
    (%vect-subtype . #.operator-single-valued-mask)
    (%unbound-marker . #.operator-single-valued-mask)
    (%illegal-marker . #.operator-single-valued-mask)
    (%ppc-gvector . #.(logior operator-assignment-free-mask operator-single-valued-mask))
    (immediate-get-ptr . #.operator-returns-address-mask)
    (%lisp-word-ref . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (%lisp-lowbyte-ref . #.(logior operator-single-valued-mask operator-acode-subforms-mask))
    (native-ff-call . 0)
    (double-float-compare . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask operator-cc-invertable-mask))
    (builtin-call . #.operator-side-effect-free-mask)
    (%setf-double-float . 0)
    (%double-float+-2 . 0)
    (%double-float--2 . 0)
    (%double-float*-2 . 0)
    (%double-float/-2 . 0)
    (%double-float+-2! . 0)
    (%double-float--2! . 0)
    (%double-float*-2! . 0)
    (%double-float/-2! . 0)    
    (ff-call-slep . 0)
    (%debug-trap . 0)
    (%%ineg . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%setf-short-float . 0)
    (%short-float+-2 . 0)
    (%short-float--2 . 0)
    (%short-float*-2 . 0)
    (%short-float/-2 . 0)
    (short-float-compare . 0)
    (%short-float+-2! . 0)
    (%short-float--2! . 0)
    (%short-float*-2! . 0)
    (%short-float/-2! . 0)    
    (%TYPED-2D-FLOAT-AREF . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%TYPED-2D-FLOAT-Aset . #.(logior operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%fixnum-shift-left-right . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
    (%slot-unbound-marker . #.operator-single-valued-mask)
    (%slot-ref . #.(logior operator-assignment-free-mask operator-single-valued-mask operator-acode-subforms-mask operator-side-effect-free-mask))
)))


(defmacro %nx1-operator (sym)
  (let ((op (assq sym *next-nx-operators*)))
    (if op (logior (%cdr op) (length (%cdr (memq op *next-nx-operators*))))
        (error "Bug - operator not found for ~S" sym))))

(declaim (special *nx1-alphatizers* *nx1-operators*))


(defmacro %nx1-default-operator ()
 #-bccl
 `(nx1-default-operator)
 #+bccl
 `(gethash *nx-sfname* *nx1-operators*))

(defmacro defnx1 (name sym arglist &body forms)
  (let ((fn `(nfunction ,name ,(parse-macro name arglist forms)))
        (theprogn ())
        (ysym (gensym)))
    `(let ((,ysym ,fn))
       ,(if (symbolp sym)
          `(progn
             (setf (gethash ',sym *nx1-alphatizers*) ,ysym)
             ;(proclaim '(inline ,sym))
             (pushnew ',sym *nx1-compiler-special-forms*))
          (dolist (x sym `(progn ,@(nreverse theprogn)))
            (if (consp x)
              (setq x (%car x))
              (push `(pushnew ',x *nx1-compiler-special-forms*) theprogn))
            ;(push `(proclaim '(inline ,x)) theprogn)
            (push `(setf (gethash ',x *nx1-alphatizers*) ,ysym) theprogn)))
       (record-source-file ',name 'function)
       ,ysym)))

(defmacro next-nx-num-ops ()
  (length *next-nx-operators*))


(defmacro next-nx-defops (&aux (ops (gensym)) 
                                (num (gensym)) 
                                (flags (gensym)) 
                                (op (gensym)))
  `(let ((,num ,(length *next-nx-operators*)) 
         (,ops ',*next-nx-operators*) 
         (,flags nil)
         (,op nil))
     (while ,ops
       (setq ,op (%car ,ops)  ,flags (cdr ,op))
       (setf (gethash (car ,op) *nx1-operators*) 
             (logior ,flags (setq ,num (%i- ,num 1))))
       (setq ,ops (cdr ,ops)))))

(defconstant $fbitnextmethargsp 0)
(defconstant $fbitmethodp 1)
(defconstant $fbitnextmethp 2)
(defconstant $fbitnoregs 3)
(defconstant $fbitdownward 4)
(defconstant $fbitresident 5)
(defconstant $fbitbounddownward 6)
(defconstant $fbitembeddedlap 7)
(defconstant $fbitruntimedef 8)
(defconstant $fbitnonnullenv 9)

(defconstant $eaclosedbit 24)

; condition codes :
; These are 68K condition code values, but the frontend uses them and
; both backends need to understand them.
; They're really backend-specific; it wouldn't hurt to have the frontend
; use a more "neutral" representation.
(defconstant $ccT 0)
(defconstant $ccEQ 7)
(defconstant $ccNE 6)
(defconstant $ccVC 8)
(defconstant $ccMI 11)
(defconstant $ccPL 10)
(defconstant $ccGE 12)
(defconstant $ccLT 13)
(defconstant $ccGT 14)
(defconstant $ccLE 15)


#-ppc-target
(progn

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; cmp2 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



; registers:
(defconstant $d0 #o00)
(defconstant $d1 #o01)
(defconstant $d2 #o02)
(defconstant $d3 #o03)
(defconstant $d4 #o04)
(defconstant $d5 #o05)
(defconstant $d6 #o06)
(defconstant $d7 #o07)

(defconstant $a0 #o10)
(defconstant $a1 #o11)
(defconstant $a2 #o12)
(defconstant $a3 #o13)
(defconstant $a4 #o14)
(defconstant $a5 #o15)
(defconstant $a6 #o16)
(defconstant $a7 #o17)

; Pet names for registers.

; Volatile data registers.
(defconstant $dtemp0 $d0)
(defconstant $arg_z $d0)
(defconstant $acc $d0)

(defconstant $dtemp1 $d1)
(defconstant $arg_y $d1)

(defconstant $dtemp2 $d2)
(defconstant $arg_x $d2) ; 

(defconstant $dtemp3 $d3)

(defconstant $nargs8 $d4)

; nonvolatile, marked data registers.
(defconstant $dsave0 $d5)
(defconstant $dsave1 $d6)
(defconstant $dsave2 $d7)

; Volatile address registers:

(defconstant $atemp0 $a0)

(defconstant $atemp1 $a1)


; Nonvolatile, marked address registers:

(defconstant $asave0 $a2)

(defconstant $asave1 $a3)


; Nonvolatile, unmarked address registers:



; Dedicated address registers:

(defconstant $nilreg $a4)

(defconstant $ra5 $a5)

(defconstant $vsp $a6)

(defconstant $sp $a7)

(defconstant $numargregs 3)


(defconstant non-volatile-registers-save-mask
  (+ (ash 1 (- 15 $dsave0))
     (ash 1 (- 15 $dsave1))
     (ash 1 (- 15 $dsave2))
     (ash 1 (- 15 $asave0))
     (ash 1 (- 15 $asave1))))

(defconstant non-volatile-registers-restore-mask
  (+ (ash 1 $dsave0)
     (ash 1 $dsave1)
     (ash 1 $dsave2)
     (ash 1 $asave0)
     (ash 1 $asave1)))

(defconstant $numsaveregs 5)

(defconstant $scratch-registers-mask
  (logior (ash 1 $dtemp0)
          (ash 1 $dtemp1)
          (ash 1 $dtemp2)
          (ash 1 $dtemp3)
          (ash 1 $nargs8)
          (ash 1 $atemp0)
          (ash 1 $atemp1)))

; Effective addresses are encoded in 22 bits, like so:
; bits 0-2 register number 0-7
; bits 3-5 mode number 0-7
; bits 6-21 16-bit displacement, 0x8000-0x7fff

(defmacro ea-reg (ea)
  `(%ilogand2 ,ea 7))

(defmacro ea-mode (ea)
  `(%ilsr 3 (%ilogand2 ,ea #o70)))

(defmacro ea-modereg (ea)
  `(%ilogand2 ,ea #o77))

(defmacro ea-dreg-p (ea)
  `(eq ,ea (ea-reg ,ea)))

(defmacro ea-areg-p (ea)
  `(eq (ea-mode ,ea) 1))

(defmacro ea-reg-p (ea)
  `(%i< ,ea #o20))

(defmacro ea-displacement (ea)
  `(%ilsr 6 (%ilogand2 ,ea #o17777700)))

(defmacro ea-displacement-if-indexed (ea)
  `(if (%i> (ea-mode ,ea) 4)
     (ea-displacement ,ea)))

(defmacro address-reg (regnum)
  `(%ilogior2 #o10 (ea-reg ,regnum)))

(defmacro indirect (areg)
  `(%ilogior2 #o20 (ea-reg ,areg)))

(defmacro indirect-displaced-mode (areg)
  `(%ilogior2 #o50 (ea-reg ,areg)))
  
(defmacro indirect-displaced (areg &optional (displacement 0))
  (if (eq displacement 0)
    `(indirect ,areg)
    `(indirect-with-displacement ,areg ,displacement)))

(defmacro indirect-with-displacement (areg displacement)
  `(%ilogior2 (%ilsl 6 (%ilogand2 ,displacement #xffff)) 
              (indirect-displaced-mode ,areg)))

; register/mode/vd things
(defconstant $eatempbit 25)
(defconstant $eamacptrbit 26)
(defconstant $eamacptropenbit 27)

; Bit 28 (sign bit) can't be used in an ea ! (used to encode labels)
; Could either punt $eatempbit or encode labels with mode/reg 7/2, extension = lblnum.
; Some future civilization will probably find this difficult to understand ...

(defconstant $FPU-fadd-opcode #o042)
(defconstant $FPU-fsub-opcode #o040)
(defconstant $FPU-fmul-opcode #o043)

(defconstant $eamacptrmask (%ilsl $eamacptrbit 1))
(defconstant $eamacptropenmask (logior (%ilsl $eamacptrbit 1) (%ilsl $eamacptropenbit 1)))

(defmacro fpu-reg (n)
  `(logior $eaFPUregmask ,n))

(defconstant $spush #o47)
(defconstant $vpush #o46) ; push on value stack
(defconstant $cmploc #o77)
(defconstant $cmpimmaddr #o76)  ; immediate long
(defconstant $cmpimmvalue #o75) ; contents of immediate long
(defconstant $spop #o37)
(defconstant $vpop #o36)  ; pop from value stack
(defconstant $abs.w #o70)
(defconstant $abs.l #o71)
(defconstant $imm #o74)
(defconstant $pcrel #o72)
(defconstant $movelpcrel #o20072)
(defconstant $vspregnum (ea-reg $vsp))
(defconstant $spregnum (ea-reg $sp))
(defconstant $t-ea (indirect-displaced $nilreg (+ $t_val $sym.gvalue)))
(defconstant $db_link-ea (indirect-displaced $ra5 $db_link))
(defconstant $csarea-ea (indirect-displaced $ra5 $csarea))
(defconstant $nilreg-relative (indirect-displaced-mode $nilreg))

; handy opcodes :

(defconstant $jsr #o47200)
(defconstant $jmp #o47300)
(defconstant $jsrA5 (logior $jsr (indirect-displaced-mode $a5)))
(defconstant $jmpA5 (logior $jmp (indirect-displaced-mode $a5)))
(defconstant $jmp.l #x4ef9)
(defconstant $jsr.l #x4eb9)
(defconstant $compare-dreg #o130200)
(defconstant $lea-atemp0 #o40700)
(defconstant $lea #o040700)
(defconstant $cmpi.l #o6200)
(defconstant $compare-areg #o130700)
(defconstant $addq.l #o050200)
(defconstant $chk.w #o040600)
(defconstant $pea #o044100)
(defconstant $add-ea-dn.w #o150100)
(defconstant $addq.w #o050100)
(defconstant $subq.w #o050500)
(defconstant $add-ea-dn.l #o150200)
(defconstant $add-ea-An.w #o150300)
(defconstant $add-ea-An.l #o150700)
(defconstant $add-dn-ea.l #o150600)
(defconstant $stm.l #o044300)
(defconstant $ldm.l #o046300)

(defconstant $moveq #x7000)
(defconstant $trapv #o47166)

(defconstant $movelong #x2000)
(defconstant $moveword #x3000)
(defconstant $movebyte #x1000)

(defmacro reg9-instr (instr regno)
  `(%ilogior2 ,instr (%ilsl 9 ,regno)))

(defmacro imm9-instr (instr immval)
  `(%ilogior2 ,instr (%ilsl 9 (%ilogand 7 ,immval))))

(defmacro instr-ea (instr ea)
  `(%ilogior2 ,instr ,ea))


(defmacro compare-dreg (ea dreg)
  `(reg9-instr (%ilogior2 $compare-dreg (%ilogand2 #o77 ,ea)) ,dreg))

(defmacro compare-areg (ea areg)
  `(reg9-instr (%ilogior2 $compare-areg (%ilogand2 #o77 ,ea)) ,areg))

(defconstant $fixnum_shift $fixnumshift)


(defconstant $test -1)
(defconstant $return #xfff)
(defconstant $mvretn #xffe)
(defconstant $mvpass #xffd)
(defconstant $mvpassbit 25)
(defconstant $mvpassmask (%ilsl $mvpassbit 1))
) ; #-ppc-target

(defmacro %temp-push (value place &environment env)
  (if (not (consp place))
    `(setq ,place (%temp-cons ,value ,place))
    (multiple-value-bind (dummies vals store-var setter getter)
                         (get-setf-method place env)
      (let ((valvar (gensym)))
        `(let* ((,valvar ,value)
                ,@(mapcar #'list dummies vals)
                (,(car store-var) (%temp-cons ,valvar ,getter)))
           ,@dummies
           ,(car store-var)
           ,setter)))))

; undo tokens :

(defconstant $undocatch 0)  ; do some nthrowing
(defconstant $undovalues 1) ; flush pending multiple values
(defconstant $undostkblk 2) ; discard "variable stack block"
(defconstant $undospecial 3) ; restore dynamic binding
(defconstant $undonotail 4) ; inhibit tail recursion
(defconstant $undomvexpect 5) ; stop expecting values
(defconstant $undoregs 6)   ; allocated regs when dynamic extent var bound.

; Stuff having to do with lisp:\



(defmacro make-acode (operator &rest args)
  `(%temp-list ,operator ,@args))

(defmacro make-acode* (operator &rest args)
  `(%temp-cons ,operator (mapcar #'nx1-form ,@args)))

; More Bootstrapping Shit.
(defmacro acode-operator (form)
  ; Gak.
  `(%car ,form))

(defmacro acode-operand (n form)
  ; Gak. Gak.
  `(nth ,n (the list ,form)))

(defmacro acode-p (x)
  " A big help this is ..."
  `(consp ,x))

(defmacro defnx2 (name locative arglist &body forms)
  (multiple-value-bind (body decls)
                       (parse-body forms nil t)
    (let ((fn `(nfunction ,name (lambda ,arglist ,@decls (block ,name .,body)))))
    `(progn
       (record-source-file ',name 'function)
       (svset *nx2-specials* (%ilogand operator-id-mask (%nx1-operator ,locative)) ,fn)))))

(defmacro defnxdecl (sym lambda-list &body forms)
  (multiple-value-bind (body decls) (parse-body forms nil t)
    `(setf (getf *nx-standard-declaration-handlers* ',sym )
           (function (lambda ,lambda-list
                       ,@decls
                       ,@body)))))

(defmacro with-declarations (&body body)
  `(let* ((*nx-new-p2decls* nil)
          (*nx-inlined-self* *nx-inlined-self*)
          (*nx-new-fdecls* nil)
          (*nx-new-vdecls* nil)
          (*nx-new-mdecls* nil)
          (*nx2-noforcestk* nil)
          (*nx-lexical-environment* (nx-new-lexical-environment *nx-lexical-environment*)))
     ,@body))

(defmacro with-p2-declarations (declsform &body body)
  `(let* ((*nx2-noforcestk* *nx2-noforcestk*)
          (*nx2-tail-allow* *nx2-tail-allow*)
          (*nx2-reckless* *nx2-reckless*)
          (*nx2-inhibit-eventchecks* *nx2-inhibit-eventchecks*)
          (*nx2-open-code-inline* *nx2-open-code-inline*)
          (*nx2-trust-declarations* *nx2-trust-declarations*))
     (nx2-decls ,declsform)
     ,@body))

(eval-when (:compile-toplevel :load-toplevel :execute)

(declaim (inline 
          nx-decl-set-fbit
          nx-adjust-setq-count
          nx-init-var
          nx1-sysnode
          ))

(defun nx-init-var (Node)
  (let* ((sym (var-name node))
         (env *nx-lexical-environment*)
         (bits (%i+
                (if (nx-proclaimed-special-p sym)
                  (if (nx-proclaimed-parameter-p sym)
                    (%ilogior #+ignore (ash -1 $vbitspecial)
                              #-ignore (%ilsl $vbitspecial 1)
                              (%ilsl $vbitparameter 1))
                    #+IGNORE (ash -1 $vbitspecial)
                    #-ignore (%ilsl $vbitspecial 1))
                  0)
                (if (proclaimed-ignore-p sym) (%ilsl $vbitignore 1) 0))))
    (push node (lexenv.variables env))
    (%temp-push node *nx-all-vars*)
    (setf (var-binding-info node) *nx-bound-vars*)
    (%temp-push node *nx-bound-vars*)
    (dolist (decl (nx-effect-vdecls sym env) (setf (var-bits node) bits))
      ;; SOMETHING IS FUKT HERE
      (if (and (eq (car decl) 'type)(eq  (cdr decl) 'destructive))
        (progn (setq bits (%ilogior bits (%ilsl $vbitdestructive 1)))))
      (case (car decl)
        (special (setq bits (%ilogior bits 
                              #+ignore (ash -1 $vbitspecial)
                              #-ignore (%ilsl $vbitspecial 1)
                              (%ilsl $vbitparameter 1))))
        (ignore (setq bits (%ilogior bits (%ilsl $vbitignore 1))))
        (ignore-if-unused (setq bits (%ilogior bits (%ilsl $vbitignoreunused 1))))
        (dynamic-extent (setq bits (%ilogior bits (%ilsl $vbitdynamicextent 1))))
        (destructive (when (nx-trust-declarations env)(setq bits (%ilogior bits (%ilsl $vbitdestructive 1))))))
      ())
    node))

(defun nx-decl-set-fbit (bit)
  (when *nx-parsing-lambda-decls*
    (let* ((afunc *nx-current-function*))
      (setf (afunc-bits afunc)
            (%ilogior (%ilsl bit 1)
                      (afunc-bits afunc))))))

(defun nx-adjust-setq-count (var &optional (by 1) catchp)
  (let* ((bits (nx-var-bits var))
         (new (%i+ (%ilsr 8 (%ilogand2 $vsetqmask bits)) by)))
    (if (%i> new 255) (setq new 255))
    (setq bits (nx-set-var-bits var (%ilogior (%ilogand (%ilognot $vsetqmask) bits) (%ilsl 8 new))))
; If a variable is setq'ed from a catch nested within the construct that
; bound it, it can't be allocated to a register. *
; * unless it can be proved that the variable isn't referenced
;   after that catch construct has been exited. **
; ** or unless the saved value of the register in the catch frame 
;    is also updated.
    (when catchp
      (nx-set-var-bits var (%ilogior2 bits (%ilsl $vbitnoreg 1))))
    new))


(defun nx1-sysnode (form)
  (if form
    (if (eq form t)
      *nx-t*)
    *nx-nil*))
)

(provide "NXENV")

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
