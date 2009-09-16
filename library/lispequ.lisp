;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;; $Log: lispequ.lisp,v $
;; Revision 1.6  2004/03/03 19:50:41  gtbyers
;; Fix VALUES-CTYPE def-accessors form.  This has been wrong for 10 years or so.  Recompilation will cause CERRORs as constants are redefined.
;;
;; Revision 1.5  2003/12/29 04:20:01  gtbyers
;; New class-wrapper stuff for slot lookup.  Remove training wheels: UVREF->%SVREF.
;;
;; Revision 1.4  2003/12/08 08:17:08  gtbyers
;; Remove 68K constants, accessors.  Define lots of new CLOS stuff.
;;
;;  6 8/25/97  akh  sleep wakeup
;;  5 4/1/97   akh  see below
;;  2 2/25/97  akh  mods for new scheduler
;;  20 10/3/96 slh  declaim special *fasl-target*
;;  19 9/4/96  akh  conditionalize more and fix some stuff for 3.0+
;;  15 5/20/96 akh  numeric-ctype-predicate
;;  11 12/1/95 gb   I meant to say "no longer inverts arguments".
;;  11 12/1/95 gb   allocate-typed-vector-form matches callers' expectations
;;  9 10/31/95 akh  change macro %cons-gf-dispatch-table
;;  7 10/26/95 akh  damage control
;;  7 10/26/95 gb   no %istruct-m: function has platform-specific
;;                  compiler-macros.  Use same idiom for %instance, %pool,
;;                  %population.
;;  5 10/23/95 akh  added macro %istruct-m, use it.
;;  4 10/17/95 akh  dispatch table macros return here
;;  3 10/10/95 akh  added lfbits-noname-bit
;;  2 10/8/95  akh  gf-dispatch-table accessors moved to l1-clos and l1-dcode
;;  3/7/95     gb   add fasloader, fasdumper stuff.
;;  3 2/3/95   slh  dflt-stackseg-size -> 16K; copyright thang
;;  (do not edit before this line!!)

;; LispEqu.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

; Supposed to mirror :build:asms:constants.i

;; Modification History
;
; add class-ctype-translation to class-ctype, add intersection-ctype and negation-ctype
; ------ 5.2b6
;10/22/98 akh lock has more slots for cl-http
;03/01/97 gb   IEEE-float constants.
;02/25/97 bill $gc-allow-stack-overflows-bit
;02/06/97 akh  conditionalize instance structures #+/-ppc-clos 
;01/15/97 bill %slot-accessor-info.xxx, %cons-slot-accessor-info
;11/11/96 bill lock.name
;10/22/96 bill $XSGEXHAUSTED, $XSGNARGS, $XTOOMANYVALUES
; ------------ 4.0
; 7/03/96 slh  ppc conditionals to allow use with 3.0
;07/26/96 bill $gc-redraw-window-frames-bit, $gc-fixed-bits-mask
;------------- MCL-PPC 3.9
;04/10/96 gb   revive $xnomem
;02/20/96 gb   conditionalize out lotsa 68k stuff
;02/27/96 bill More $gc-xxx bits
;02/26/96 bill %cons-terminatable-alist
;11/06/95 gb   :initial-element nil in %cons-gf-dispatch-table.
;10/25/95 slh  %istruct-m: ppc::subtype-istruct -> ppc::subtag-istruct
; 3/02/95 slh  $xarrlimit
; 1/25/95 slh  $default-stackseg-size -> 16K
;------------- 3.0d16
;03/16/94 bill $gc-integrity-check-bit
;01/05/93 bill comment before $lfbits-xxx definitions
;------------- 3.0d13
;04/28/93 bill process.creation-time, process.last-run-time, process.total-run-time
;04/21/93 bill process.background-p
;------------- 2.1d5
;03/10/93 bill $default-stackseg-size
;03/01/93 bill $sg.sgbuf
;02/05/93 bill $extended-vstack-marker
;01/28/93 bill sgbuf.maxsize, $stackseg.totalsize
;01/11/93 bill process-queue.xxx
;12/17/92 bill resource.xxx, %cons-resource
;11/20/92 gb   lots-o-changes.
;-------------- 2.0
;02/10/91 alice add $iofilename
;---------------
;12/10/91 gb   drop the ralph bit (... like a bad habit.)  Add some error
;              string constants.
;------------- 2.0b4
;11/08/91 gb   use %svref on VAR accessors.
;10/17/91 bill $gc-use-gc-cursor-bit, $gc-polling-enabled-bit,
;              $ptask_draw-flag, $ptask_event-dispatch-flag
;10/14/91 gb   add $flags_disposeGworld.
;------------- 2.0b3
;08/20/91 gb   add $cons-area.total.
;07/02/91 bill $lfatr-aplink-bit & $lfatr-aplink1-bit are no more.
;              replaced by $lfatr-kernel-bit and an unused lfatr bit.
;              %class-direct-methods -> %class-kernel-p.direct-methods
;------------- 2.0b2
;06/03/91 bill remove the #. from $macptr.ptr def so this file will compile
;              in the distributed Lisp
;05/29/91 gb   new cons-area equates.
;05/20/91 gb   $t_float -> $t_dfloat;  steal a bit from $lfbits-numopt, add $lfbits
;              restv-bit.  Periodic-task accessors.
;05/09/91 bill defenv.classes
;03/13/91 bill $t_xxx goes before all references.
;03/08/91 bill mci.*
;02/27/91 bill %gf-dispatch-table-instance
;02/08/91 bill %cons-restart -> level-2.lisp
;              Start of new slot-descriptor accessors (commented out)
;02/27/91 alice add a bunch of error numbers (not needed in constants.i)
;--------------- 2.0b1
;02/06/91 bill %cons-pkg-iter -> level-2.lisp
;01/31/91 bill pkg-iter.xxx & %cons-pkg-iter for with-package-iterator
;01/29/91 bill population-data
;01/11/91 bill (provide "LISPEQU"), in-package
;01/05/91 gb  $sym_fbit_frozen.
;11/21/90 gb  $fcell_base.
;11/20/90 bill %cons-pool pool.data
;10/26/90 akh  grab the last lfun bit for evaluated functions
;10/25/90 gz   $v_ulongv.
;09/21/90 bill add types to def-accessors forms.  class-wrapper becomes an $i_struct.
;09/19/90 bill %cons-built-in-class uses a wrapper instead of the symbol 'built-in-class
;              Also: built-in-class instances are instances, not istructs
;10/16/90 gb   var istructs.  No more $v_shortv
;09/05/90 bill %cons-method takes an optional method-class arg.
;08/30/90 bill comment out the tables slots from class wrappers until they get implemented.
;08/28/90 bill  $vc.saved_method_var
;07/13/90  gb   Needed to know about headers after all.  New symbols.  New consarea stuff.
;07/04/90 bill add $lfbits-cm-bit & $lfbits-nextmeth-with-args-bit
;06/30/90 bill store %method-name in the method, not as its method-function's name.
;06/26/90 bill move %class-direct-methods from standard-class to built-in-class.
;06/23/90  gb  forget about $symbol-header. add gclink to population..
;06/21/90 bill add %class-*-initargs slots for keeping track of valid initargs.
;06/14/90 bill %class-alist
; ----- 2.0a1
;06/01/90 bill $flags_*
;05/22/90 gb   What else but defenv.specials? $symbol-header.
;05/04/90 gb   defenv.defined.
;04/30/90 gb   new symbol format.  Slightly different lfun, attribute bits.  Lexenv, defenv.
;              new restart structure.  New catch frame format.  GC event bits, immediate tags.
;04/20/90 gz   logical pathnames
;03/29/90 bill %cons-population, population.type, population.data
;02/28/90 bill Added $illegal immediate.
;01/17/90 gz   $lfatr-noname-bit, $lfatr-resident-bit, $lfatr-aplink1-bit.
;              $lfbits-symbols-bit -> $lfatr-symmap-bit.  This leaves us one more fixnum
;              bit in lfun-bits!
;12/29/89 gz   Added pkgtab accessors.
;12/28/89 gz   new method accessors.  Cleaned up error number constants.
;12/04/89 bill More forwarding stuff.
;11/31/89 bill Add %wrapper-forwarding-info & friends.
;11/24/89 gz removed $v_flavor and $v_object.
;11/01/89 gz added $sym_vbit_* and $sym_fbit_*
;10/31/89 bill Added $lfbits-ralph-bit
;10/18/89 bill New method offsets.  Methods become lfun-vectors.
;10/04/89 gz added some constants formerly in l1-macros.
;10/14/89 bill Add slots to the class structure
;9/28/89  gb unsigned short, byte vectors.
;09/13/89 gz $lfatr-regs-mask, $lfatr-slfunv-bit
;09/03/89 gb $cons_area.foo.
;07/28/89 gz %class-default-initargs slots.
;05/31/89 gz $vc_base.
;05/01/89 gz link map bits
;04/19/89 gz $xcoerce error.
;03/23/89 gz $sym_size, $nil_val, $xt_base, $jmp_absl,$jsr_absl,$jsr_atemp0.
;            $v_pkg. $mac-time-offset.
;03/16/89 as quantifier constants
;03/03/89 gz toy clos defs.  Lfun defs. $floathi. accessors for ratios and complexes.
;02/28/89 gz $klfxxx constants.
;02/19/89 gz Flushed $v_cclosure, $v_iclosure, added $v_instance.
;01/09/89 gz restart istruct defs.
;01/02/89 gz readtable constants. $v_link.  pathname accessors.
;12/25/88 gz subtype in array headers. long and float arrays.
;12/13/88 gz char byte offsets
;11/21/88 gb catch frames.
;11/09/88 gb $v_poolfreelist.
;10/30/88 gb added error constants.
; 10/29/88 gz Use def-accessors for packages, objects, array headers
; 10/3/88 gz added $macptr.flags
; 9/2/88  gb added $v_heapvector
; 9/1/88  gz kprimtab. $err-disp-size
; 8/26/88 gz $err-no-file, $err-bad-named-arg, some file sys constants.
; 8/25/88 gz Added $v_weakh,$err-arroob. Removed $inest-ptr-8, $sstr_*, $bin_*.
;            New vector subtypes.
; 8/16/88 gz More constants.
; 8/13/88 gb More constants.

(in-package :ccl)

(declaim (special *fasl-target*))
(defun ppc-target-p ()
  (and (boundp '*fasl-target*)
       (eq *fasl-target* :ppc)))



(defconstant $RCVSCROLL 256)
(defconstant $RCHSCROLL 257)
(defconstant $HJUMP 4)

(defconstant $evtMessage 2)
(defconstant $evtMessage-w (%i+ $evtMessage 2))
(defconstant $evtMessage-b (%i+ $evtMessage 3))
(defconstant $evtPartCode 16)

(defconstant $BtnCtrlItem 4)  ;$BtnCtrl+$ctrlItem etc.
(defconstant $ChkCtrlItem 5)
(defconstant $radCtrlItem 6)
(defconstant $resCtrlItem 7)
(defconstant $userItemDisabled 128) ;$userItem+$itemDisable etc.
(defconstant $statTextDisabled 136)
(defconstant $editTextDisabled 144)
(defconstant $iconItemDisabled 160)
(defconstant $picItemDisabled 192)

(defconstant $ioPBSize 122)    ;Max. Who cares about a few extra bytes...

(defconstant $ioFileName #x12) ; file name pointer [pointer]

;Constants for word access to dirid's.
(defconstant $ioDirID1 48)
(defconstant $ioDirID2 50)
(defconstant $ioFlParID1 100)
(defconstant $ioFlParID2 102)
(defconstant $ioDrParID1 100)
(defconstant $ioDrParID2 102)
(defconstant $ioDrDirID1 48)
(defconstant $ioDrDirID2 50)
(defconstant $ioNewDirID1 36)
(defconstant $ioNewDirID2 38)

(defconstant $Mac-time-offset 126144000)



; These must agree with the values that are in-line at COMPACTVEC in MEM.A
(defconstant $flags_Normal 0)
(defconstant $flags_DisposHandle 1)
(defconstant $flags_DisposPtr 2)
(defconstant $flags_DisposWindow 3)
(defconstant $flags_DisposGworld 4)



;;; this stuff is really ppc specific at the moment
(defconstant $population_weak-list 0)
(defconstant $population_weak-alist 1)
(defconstant $population_termination-bit 16)

; type of 0 is a weak-list
; Note that this evals its args in the wrong order.
(defmacro %cons-population (data &optional (type 0) (termination? nil))
  (if termination?
    `(gvector :population 0 (logior (ash 1 $population_termination-bit) ,type) ,data nil)
    `(gvector :population 0 ,type ,data)))

(defmacro %cons-terminatable-alist (&optional data)
  `(%cons-population ,data $population_weak-alist t))

; The GC assumes that this structure is laid out exactly as below.
; It also assumes that if the $population_termination-bit is set in the
; population.type slot, the vector is of length 4, otherwise 3.
(def-accessors (population) %svref
  population.gclink
  population.type
  population.data
  population.termination-list)

(def-accessors () uvref
  nil
  nil
  population-data                      ; type-checked
  population-termination-list)

(defmacro %cons-pool (&optional data)
  `(gvector :pool ,data))

(def-accessors (pool) %svref
  pool.data)

(def-accessors (resource) %svref
  nil                                   ; 'resource
  resource.constructor
  resource.destructor
  resource.initializer
  resource.pool)

#+ppc-target
(defparameter *target-type-codes*
  '((:bignum #.ppc::subtag-bignum)
    (:ratio #.ppc::subtag-ratio)
    (:single-float #.ppc::subtag-single-float)
    (:double-float #.ppc::subtag-double-float)
    (:complex #.ppc::subtag-complex)
    (:symbol #.ppc::subtag-symbol)
    (:function #.ppc::subtag-function)
    (:code-vector #.ppc::subtag-code-vector)
    (:macptr #.ppc::subtag-macptr)
    (:catch-frame #.ppc::subtag-catch-frame)
    (:structure #.ppc::subtag-struct)
    (:istruct #.ppc::subtag-istruct)
    (:mark #.ppc::subtag-mark)
    (:pool #.ppc::subtag-pool)
    (:population #.ppc::subtag-weak)
    (:hash-vector #.ppc::subtag-hash-vector)
    (:slot-vector #.ppc::subtag-slot-vector)
    (:package #.ppc::subtag-package)
    (:value-cell #.ppc::subtag-value-cell)
    (:instance #.ppc::subtag-instance)
    (:lock #.ppc::subtag-lock)
    
    (:base-string #.ppc::subtag-simple-base-string)
    (:extended-string #.ppc::subtag-simple-general-string)
    (:bit-vector #.ppc::subtag-bit-vector)
    (:signed-8-bit-vector #.ppc::subtag-s8-vector)
    (:unsigned-8-bit-vector #.ppc::subtag-u8-vector)
    (:signed-16-bit-vector #.ppc::subtag-s16-vector)
    (:unsigned-16-bit-vector #.ppc::subtag-u16-vector)
    (:signed-32-bit-vector #.ppc::subtag-s32-vector)
    (:unsigned-32-bit-vector #.ppc::subtag-u32-vector)
    (:single-float-vector #.ppc::subtag-single-float-vector)
    (:double-float-vector #.ppc::subtag-double-float-vector)
    (:simple-vector #.ppc::subtag-simple-vector)))



; This isn't the most reliable thing in the world, but may be close enough.
(defun target-platform ()
  (if (ppc-target-p)
    :ppc
    :m68k))

(defun gvector-allocation-construct (platform)
  (ecase platform
    (:m68k '%gvector)
    (:ppc '%ppc-gvector)))

(defun typed-vector-alloc-construct (platform)
  (ecase platform
    (:m68k '%make-uvector)
    (:ppc '%alloc-misc)))

(defun type-keyword-code (type-keyword platform)
  (let* ((entry (assq type-keyword *target-type-codes*)))
    (if entry
      (let* ((code 
              (ecase platform
                (:ppc (cadr entry))
                (:m68k #+ppc-target (cddr entry) #-ppc-target (cdr entry)))))
        (or code (error "Vector type ~s invalid on target ~s" type-keyword platform)))
      (error "Unknown type-keyword ~s. " type-keyword))))

(defun gvector-form (type-keyword initial-values &optional (target (target-platform)))
  `(,(gvector-allocation-construct  target)
    ,(type-keyword-code type-keyword target)
    ,@initial-values))

(defmacro gvector (type-keyword &rest initial-values)
  (gvector-form type-keyword initial-values))

(defun allocate-typed-vector-form (type-keyword element-count initial-value init-p 
                                                 &optional (target (target-platform)))
  `(,(typed-vector-alloc-construct target)
    ,element-count
    ,(type-keyword-code type-keyword target)
    ,@(if init-p `(,initial-value))))

(defmacro allocate-typed-vector (type-keyword elements &optional (init nil init-p))
  (allocate-typed-vector-form type-keyword elements init init-p))

; it's BAAACK. sort of.

(defmacro %istruct (istruct-name &rest initial-values)
  `(gvector :ISTRUCT ,istruct-name ,@initial-values))


(defmacro %cons-resource (constructor &optional destructor initializer)
  `(%istruct 'resource ,constructor ,destructor ,initializer (%cons-pool)))

#|  `(%gvector $v_istruct 'resource ,constructor ,destructor ,initializer (%cons-pool))) |#



; Symbol [f,v]bits.

(defconstant $sym_bit_bound 0)		;Proclaimed bound.
(defconstant $sym_bit_const 1)
(defconstant $sym_bit_global 2)         ;Should never be lambda-bound.
(defconstant $sym_bit_special 4)
(defconstant $sym_vbit_typeppred 5)
(defconstant $sym_bit_indirect 6)
(defconstant $sym_bit_defunct 7)

(defconstant $sym_vbit_bound $sym_bit_bound)
(defconstant $sym_vbit_const $sym_bit_const)
(defconstant $sym_vbit_global $sym_bit_global)
(defconstant $sym_vbit_special $sym_bit_special)
(defconstant $sym_vbit_indirect $sym_bit_indirect)
(defconstant $sym_vbit_defunct $sym_bit_defunct)

(defconstant $sym_fbit_frozen (+ 8 $sym_bit_bound))
(defconstant $sym_fbit_special (+ 8 $sym_bit_special))
(defconstant $sym_fbit_indirect (+ 8 $sym_bit_indirect))
(defconstant $sym_fbit_defunct (+ 8 $sym_bit_defunct))

(defconstant $sym_fbit_constant_fold (+ 8 $sym_bit_const))
(defconstant $sym_fbit_fold_subforms (+ 8 $sym_bit_global))




;Lfun bits.
;Assumed to be a fixnum, so if you ever assign a bit number > 28,
;change lfun-bits and its callers.
(defconstant $lfbits-nonnullenv-bit 0)
(defconstant $lfbits-keys-bit 1)
(defconstant $lfbits-numopt (byte 5 2))
(defconstant $lfbits-restv-bit 7)
(defconstant $lfbits-numreq (byte 6 8))
(defconstant $lfbits-optinit-bit 14)
(defconstant $lfbits-rest-bit 15)
(defconstant $lfbits-aok-bit 16)
(defconstant $lfbits-numinh (byte 6 17))
#-ppc-target
(defconstant $lfbits-lap-bit 23)
#+ppc-target
(defconstant $lfbits-symmap-bit 23)
(defconstant $lfbits-trampoline-bit 24)
(defconstant $lfbits-evaluated-bit 25)
(defconstant $lfbits-cm-bit 26)         ; combined-method
(defconstant $lfbits-nextmeth-bit 26)   ; or call-next-method with method-bit
(defconstant $lfbits-gfn-bit 27)        ; generic-function
(defconstant $lfbits-nextmeth-with-args-bit 27)   ; or call-next-method-with-args with method-bit
(defconstant $lfbits-method-bit 28)     ; method function
; PPC only but want it defined for xcompile
(defconstant $lfbits-noname-bit 29)


(defconstant $lfbits-args-mask
  (%ilogior (dpb -1 $lfbits-numreq 0)
            (dpb -1 $lfbits-numopt 0)
            (%ilsl $lfbits-rest-bit 1)
            (%ilsl $lfbits-keys-bit 1)
            (%ilsl $lfbits-aok-bit 1)))

#-ppc-target
(progn
;lfun attributes.
;Bits 0-7 exist in both in slfun jtab entries and lfun vectors.
;Bits 8-15 exist only in lfun vectors.
(defconstant $lfatr-immmap-bit 0)
(defconstant $lfatr-linkmap-bit 1)
(defconstant $lfatr-symmap-bit 2)
(defconstant $lfatr-gc-bit 3)           ; Used by dws marker.
(defconstant $lfatr-kernel-bit 4)       ; set for kernel method-function's
;(defconstant $lfatr-unused-bit 5)
(defconstant $lfatr-nopurge-bit 6)
(defconstant $lfatr-preload-bit 7)
(defconstant $lfatr-slfunv-bit 8)       ; This is the lfun vector of a swappable lfun,
                                        ; i.e. it has an extra longword at end.
(defconstant $lfatr-regmap-bit 9)          ; has register map
(defconstant $lfatr-novpushed-args-bit 10)       ; not-so-easily parsed stack frame.
(defconstant $lfatr-noname-bit 11)       ; This lfun doesn't have a name immediate.
(defconstant $lfatr-resident-bit 12)    ; This lfun must stay resident
(defconstant $lfatr-uses-regs-bit 13)  ; binds some regs, may/may not have map as well.
(defconstant $lfatr-sg-bit 14)
(defconstant $lfatr-new-lfbits-bit 15)

(defconstant $lfregs-regs-mask (byte 5 11))
(defconstant $lfregs-simple-bit 10)
(defconstant $lfregs-simple-ea-mask (byte 5 0))
(defconstant $lfregs-simple-pc-mask (byte 5 5))


;Link map bits
(defconstant $lm_bit_pcrel 0)
(defconstant $lm_bit_branch 1)
(defconstant $lm_bit_shortbranch 2)     ; if $lm_bit_immref clear.
(defconstant $lm_bit_uniqimm 2)         ; if $lm_bit_immref set.
(defconstant $lm_bit_immref 3)
(defconstant $lm_bit_longimm 4)
(defconstant $lm_bit_indirect 5)        ; nilreg-space value/function cell
(defconstant $lm_bit_nrs 5)             ; nilreg-relative-symbol ref
(defconstant $lm_bit_slfun 6)           ; a5-space swappable lfun.
(defconstant $lm_bit_temp 7)            ;"Always zero" (used internally in fasloader)
(defconstant $lm_longimm (%ilogior (%ilsl $lm_bit_immref 1) (%ilsl $lm_bit_longimm 1)))

(def-accessors %svref
  arh.fixnum
  arh.offs
  arh.vect
  (arh.vlen arh.dims)
  arh.fill)

;byte offsets in arh.fixnum slot.
(defconstant $arh_rank4 0)		;4*rank
(defconstant $arh_type 2)		;vector subtype
(defconstant $arh_bits 3)		;Flags

(defconstant $arh_one_dim 4)		;arh.rank4 value of one-dim arrays

); #-ppc-target

;Bits in $arh_bits.
(defconstant $arh_adjp_bit 7)		;adjustable-p
(defconstant $arh_fill_bit 6)		;fill-pointer-p
(defconstant $arh_disp_bit 5)		;displaced to another array header -p
(defconstant $arh_simple_bit 4)		;not adjustable, no fill-pointer and
					; not user-visibly displaced -p

(def-accessors (lexical-environment) %svref
  ()					; 'lexical-environment
  lexenv.parent-env
  lexenv.functions
  lexenv.variables
  lexenv.fdecls				; function-binding decls, e.g., [NOT]INLINE, FTYPE
  lexenv.vdecls				; variable-binding decls, e.g., SPECIAL, TYPE
  lexenv.mdecls				; misc decls, e.g., OPTIMIZE
  lexenv.lambda				; unique id (e.g., afunc) of containing lambda expression.
  )

(def-accessors (definition-environment) %svref
  ()					; 'definition-environment
  defenv.type				; must be LIST, match lexenv.parent-env
  defenv.functions			; compile-time macros, same structure as lexenv.functions
  defenv.constants			; definition-time constants, shadows lexenv.variables
  defenv.fdecls				; shadows lexenv.fdecls
  defenv.vdecls				; shadows lexenv.vdecls
  defenv.mdecls				; shadows lexenv.mdecls
; extended info
  defenv.types				; compile-time deftype info, shadows lexenv.function
  defenv.defined			; functions defined in compilation unit.
  defenv.specials
  defenv.classes                        ; classed defined in compilation unit
  defenv.structrefs                     ; compile-time DEFSTRUCT accessor info
  defenv.structures                     ; compile-time DEFSTRUCT info
)

(def-accessors (var) %svref
  nil                                   ; 'var
  var-name                              ; symbol
  (var-bits var-parent)                 ; fixnum or ptr to parent
  (var-ea  var-expansion)               ; p2 address (or symbol-macro expansion)
  var-decls                             ; list of applicable decls
  var-inittype
  var-binding-info
)

(def-accessors (package) %svref
  pkg.itab
  pkg.etab
  pkg.used
  pkg.used-by
  pkg.names
  pkg.shadowed)



(defconstant $default-stackseg-size 16384)

(def-accessors () %svref
  bt.dialog
  bt.youngest
  bt.oldest
  bt.sg
  bt.restarts)

#|
(def-accessors (lock) %svref
  lock.value
  lock.name)
|#

;; for cl-http
(def-accessors (lock) %svref
  lock.value
  lock.name
  lock.type
  lock.nreaders
  ) 

(def-accessors (process-queue) %svref
  nil                                   ; 'process-queue
  process-queue.name
  process-queue.positions-left
  process-queue.start
  process-queue.end)

(defmacro %cons-process-queue (name size)
  `(%istruct 'process-queue ,name ,size nil nil))
#|
  `(%gvector $v_istruct 'process-queue ,name ,size nil nil))
|#

(def-accessors (process) %svref
  nil                                   ; 'process
  process.name
  process.stack-group
  process.initial-stack-group
  process.initial-form
  process.wait-function
  process.wait-argument-list
  process.run-reasons
  process.arrest-reasons
  process.priority
  process.quantum                       ; ticks remaining
  process.warm-boot-action              ; ???
  process.whostate
  process.nexttick                      ; n - when quantum expires
  process.splice                        ; a cons cell
  process.background-p
  process.creation-time                 ; reset to now by clear-process-run-time
  process.last-run-time			; tick count when last ran
  process.total-run-time		; reset to 0 by clear-process-run-time
  process.internal-priority            ; new
  process.timeout                      ; new for  blocked processes
  process.wait-finished                ; when a process-wait starts this is set to nil, when a wait function
                                       ; returns true and this value is nil this is set to (get-tick-count)
  process.run-times                    ; contains a list of length 2 of  (total-run-time time-sampled)
)
  
;contents of pkg.itab/pkg.etab.
(defmacro pkgtab-table (htab) `(car (the list ,htab)))
#|
(defmacro pkgtab-hcount (htab) `(car (the list (cdr (the list ,htab)))))                                            (mkint acc)))
(defmacro pkgtab-hlimit (htab) `(cdr (the list (cdr (the list ,htab)))))
|#

(def-accessors (trap) uvref
  nil                                   ; 'trap
  trap-args
  trap-return
  trap-implementation
  trap-call)

(def-accessors (pathname) %svref
  ()                                    ; 'pathname
  %pathname-directory
  %pathname-name
  %pathname-type
  %logical-pathname-host
  %logical-pathname-version)

(defmacro %cons-pathname (directory name type)
  `(%istruct 'pathname ,directory ,name ,type))
#|
  `(%gvector $v_istruct 'pathname ,directory ,name ,type))
|#

(defmacro %cons-logical-pathname (directory name type host version)
  `(%istruct 'logical-pathname ,directory ,name ,type ,host ,version))
#|
  `(%gvector $v_istruct 'logical-pathname ,directory ,name ,type ,host ,version))
|#

(def-accessors (restart) %svref
  ()                                    ; 'restart
  %restart-name
  %restart-action
  %restart-report
  %restart-interactive
  %restart-test)

; %cons-restart now in level-2.lisp


(def-accessors %svref
  nil                                   ; 'periodic-task
  ptask.state
  ptask.name
  ptask.function
)

;;;;;; CMU type system.

#+ppc-clos ; aka ppc-typesystem or something
(progn
(def-accessors (type-class) %svref
  nil                                   ; 'type-class
  type-class-name                       ; name

  ;; Dyadic type methods.  If the classes of the two types are EQ, then we call
  ;; the SIMPLE-xxx method.  If the classes are not EQ, and either type's class
  ;; has a COMPLEX-xxx method, then we call it.
  ;;
  ;; Although it is undefined which method will get precedence when both types
  ;; have a complex method, the complex method can assume that the second arg
  ;; always is in its class, and the first always is not.  The arguments to
  ;; commutative operations will be swapped if the first argument has a complex
  ;; method.
  ;;
  ;; Since SUBTYPEP is not commutative, we have two complex methods.  the ARG1
  ;; method is only called when the first argument is in its class, and the
  ;; ARG2 method is only called when called when the second type is.  If either
  ;; is specified, both must be.
  type-class-simple-subtypep
  type-class-complex-subtypep-arg1
  type-class-complex-subtypep-arg2
  ;;
  ;; SIMPLE-UNION combines two types of the same class into a single type of
  ;; that class.  If the result is a two-type union, then return NIL.
  ;; VANILLA-UNION returns whichever argument is a supertype of the other, or
  ;; NIL.
  type-class-simple-union
  type-class-complex-union
  ;; The default intersection methods assume that if one type is a subtype of
  ;; the other, then that type is the intersection.
  type-class-simple-intersection
  type-class-complex-intersection
  ;;
  type-class-simple-=
  type-class-complex-=
  type-class-unparse
) 

;; This istruct (and its subtypes) are used to define types.
(def-accessors (ctype) %svref
  nil                                   ; 'ctype or a subtype
  ctype-class-info                       ; a type-class
  ;; True if this type has a fixed number of members, and as such could
  ;; possibly be completely specified in a MEMBER type.  This is used by the
  ;; MEMBER type methods.
  ctype-enumerable
)

;; args-ctype is a subtype of ctype
(def-accessors (args-ctype) %svref
  nil                                   ; 'args-ctype
  nil                                   ; ctype-class-info              
  nil                                   ; ctype-enumerable
  ;; Lists of the type for each required and optional argument.
  args-ctype-required
  args-ctype-optional
  ;;
  ;; The type for the rest arg.  NIL if there is no rest arg.
  args-ctype-rest
  ;; True if keyword arguments are specified.
  args-ctype-keyp
  ;; List of key-info structures describing the keyword arguments.
  args-ctype-keywords
  ;; True if other keywords are allowed.
  args-ctype-allowp
)

(def-accessors (key-info) %svref
  nil                                   ; 'key-info
  key-info-name                         ; Name of &key arg
  key-info-type                         ; type (ctype) of this &key arg
)

; VALUES-ctype is a subtype of ARGS-ctype.
(def-accessors (values-ctype) %svref
  nil                                   ; 'values-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  ;; Lists of the type for each required and optional argument.
  values-ctype-required
  values-ctype-optional
  ;;
  ;; The type for the rest arg.  NIL if there is no rest arg.
  values-ctype-rest
  ;; True if keyword arguments are specified.
  values-ctype-keyp
  ;; List of key-info structures describing the keyword arguments.
  values-ctype-keywords
  ;; True if other keywords are allowed.
  values-ctype-allowp
)

; FUNCTION-ctype is a subtype of ARGS-ctype.
(def-accessors (args-ctype) %svref
  nil                                   ; 'function-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  function-ctype-required               ; args-ctype-required
  function-ctype-optional               ; args-ctype-optional
  function-ctype-rest                   ; args-ctype-rest
  function-ctype-keyp                   ; args-ctype-keyp
  function-ctype-keywords               ; args-ctype-keywords
  function-ctype-allowp                 ; args-ctype-allowp
;; True if the arguments are unrestrictive, i.e. *.
  function-ctype-wild-args
  ;;
  ;; Type describing the return values.  This is a values type
  ;; when multiple values were specified for the return.
  function-ctype-returns
)

;;; The CONSTANT-ctype structure represents a use of the CONSTANT-ARGUMENT "type
;;; specifier", which is only meaningful in function argument type specifiers
;;; used within the compiler.
;;;


(def-accessors (constant-ctype) %svref
  nil                                   ; 'constant-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  ;; The type which the argument must be a constant instance of for this type
  ;; specifier to win.
  constant-ctype-type
)

;;; The NAMED-ctype is used to represent *, T and NIL.  These types must be
;;; super or sub types of all types, not just classes and * & NIL aren't
;;; classes anyway, so it wouldn't make much sense to make them built-in
;;; classes.
;;;

(def-accessors (named-ctype) %svref
  nil                                   ; 'named-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  named-ctype-name
)

;;; The Hairy-ctype represents anything too wierd to be described reasonably or
;;; to be useful, such as AND, NOT and SATISFIES and unknown types.  We just
;;; remember the original type spec.
;;;

(def-accessors (hairy-ctype) %svref
  nil                                   ; 'hairy-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  ;; The type which the argument must be a constant instance of for this type
  ;; specifier to win.
  hairy-ctype-specifier
)

;;; An UNKNOWN-ctype is a type not known to the type system (not yet defined).
;;; We make this distinction since we don't want to complain about types that
;;; are hairy but defined.
;;;

; This means that UNKNOWN-ctype is a HAIRY-ctype.
(def-accessors (unknown-ctype) %svref
  nil                                   ; 'unknown-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  unknown-ctype-specifier
)

; NUMERIC-ctype is a subclass of CTYPE
(def-accessors (numeric-ctype) %svref
  nil                                   ; numeric-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  ;;
  ;; The kind of numeric type we have.  NIL if not specified (just NUMBER or
  ;; COMPLEX).
  numeric-ctype-class
  ;; Format for a float type.  NIL if not specified or not a float.  Formats
  ;; which don't exist in a given implementation don't appear here.
  numeric-ctype-format
  ;; Is this a complex numeric type?  Null if unknown (only in NUMBER.)
  numeric-ctype-complexp
  ;; The upper and lower bounds on the value.  If null, there is no bound.  If
  ;; a list of a number, the bound is exclusive.  Integer types never have
  ;; exclusive bounds.
  numeric-ctype-low
  numeric-ctype-high
  numeric-ctype-predicate
)

; ARRAY-ctype is a subclass of CTYPE.
(def-accessors (array-ctype) %svref
  nil                                   ; 'array-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  ;;
  ;; The dimensions of the array.  * if unspecified.  If a dimension is
  ;; unspecified, it is *.
  array-ctype-dimensions
  ;;
  ;; Is this not a simple array type?
  array-ctype-complexp
  ;;
  ;; The element type as originally specified.
  array-ctype-element-type
  ;;
  ;; The element type as it is specialized in this implementation.
  array-ctype-specialized-element-type
)

; MEMBER-ctype is a direct subclass of CTYPE.
(def-accessors (member-ctype) %svref
  nil                                   ; 'member-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  ;;
  ;; The things in the set, with no duplications.
  member-ctype-members
)

; UNION-ctype is a direct subclass of CTYPE.
(def-accessors (union-ctype) %svref
  nil                                   ; 'union-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  ;;
  ;; The types in the union.
  union-ctype-types
)

;;; INTERSECTION-ctype is a direct subclass of CTYPE.
(def-accessors (intersection-ctype) %svref
  nil                                   ; 'intersection-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  ;;
  ;; The types in the intersection
  intersection-ctype-types
)

(def-accessors (negation-ctype) %svref
  nil                                   ; 'negation-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  ;; The type of what we're not:
  negation-ctype-type
  )
  

; It'd be nice to integrate "foreign" types into the type system
(def-accessors (foreign-ctype) %svref
  nil                                   ; 'foreign-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  foreign-ctype-foreign-type
)

(def-accessors (cons-ctype) %svref
  nil                                   ; 'cons-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  ;; the type of the car in case you didn't know  
  cons-ctype-car-ctype 
  ;; ditto cdr
  cons-ctype-cdr-ctype)
  
; Most "real" CLOS objects have one of these in their class-wrapper's 
; %wrapper-type-info slot (or is it %class.ctype) slot

(def-accessors (class-ctype) %svref
  nil                                   ; 'class-ctype
  nil                                   ; ctype-class-info           
  nil                                   ; ctype-enumerable
  class-ctype-class                     ; backptr to class.
  class-ctype-translation               ; ctype for some built-in-classes.
)
) ; end #+ppc-clos


;;;;;;;
;;
;; state for with-package-iterator
;;
(def-accessors %svref
  pkg-iter.pkgs                         ; remaining packages to iterate over
  pkg-iter.types                        ; types user wants
  pkg-iter.state                        ; nil :internal, :external, or :inherited
  pkg-iter.pkg                          ; current pkg
  pkg-iter.used                         ; remaining used package when state is :inherited
  pkg-iter.tbl                          ; current pkg.itab or pkg.etab
  pkg-iter.index)                       ; index in table

; Bits for pkg-iter.types
(defconstant $pkg-iter-external 0)
(defconstant $pkg-iter-internal 1)
(defconstant $pkg-iter-inherited 2)

;;;;;;;;;;;;;

(defconstant $catch.tag 0)
(defconstant $catch.mvflag (+ $catch.tag 4))
(defconstant $catch.dblink (+ $catch.mvflag 4))
(defconstant $catch.vsp (+ $catch.dblink 4))
(defconstant $catch.regs (+ $catch.vsp 4))
(defconstant $catch.link (+ $catch.regs (* 4 5)))
(defconstant $catch.scgvll (+ $catch.link 4))
(defconstant $catch.cs_area (+ $catch.scgvll 4))
(defconstant $catch.pc (+ $catch.cs_area 4))
(defconstant $catchfsize (+ $catch.pc 4))


; Bits in *gc-event-status-bits*
(defconstant $gc-suspend-or-resume-bit 0)
(defconstant $gc-update-bit 1)
(defconstant $gc-integrity-check-bit 2)
(defconstant $gc-polling-allowed-bit 3)
(defconstant $gc-redraw-window-frames-bit 4)
(defconstant $gc-allow-stack-overflows-bit 5)
(defconstant $gc-sleep-wakeup-bit 6)
(defconstant $gc-post-egc-hook-bit 22)
(defconstant $gc-terminate-macptrs-bit 23)      ; no longer used
(defconstant $gc-poll-in-foreground-bit 24)
(defconstant $gc-pregc-pending-bit 25)
(defconstant $gc-postgc-pending-bit 26)
(defconstant $gc-use-gc-cursor-bit 27)
(defconstant $gc-polling-enabled-bit 28)

; A mask for the bits that aren't toggled dynamically by %event-dispatch
(defconstant $gc-fixed-bits-mask
  (lognot (bitset $gc-sleep-wakeup-bit
                  (bitset $gc-redraw-window-frames-bit
                          (bitset $gc-suspend-or-resume-bit
                                  (bitset $gc-update-bit 0))))))

; Values for the flags arg to %install-periodic-task
(defconstant $ptask_draw-flag 1)       ; set for tasks that do drawing
(defconstant $ptask_event-dispatch-flag 2)      ; set for tasks that do event processing



(def-accessors (readtable) %svref
  ()                                        ; 'readtable
  rdtab.ttab                                ; type table
  rdtab.alist                               ; macro-char alist
  rdtab.case)				    ; gratuitous braindeath

;character types in readtables
(defconstant $cht_ill 0)                ;Illegal char
(defconstant $cht_wsp 1)                ;Whitespace
(defconstant $cht_sesc 4)               ;Single escape (\)
(defconstant $cht_mesc 5)               ;Multiple escape (|)
(defconstant $cht_cnst 6)               ;Atom constituent
(defconstant $cht_tmac 8)               ;Terminating macro
(defconstant $cht_ntmac 9)              ;Non-terminating macro

(defconstant $cht_macbit 3)             ;This bit on in CHT_TMAC and CHT_NTMAC

; quantifiers

(defconstant $some 0)
(defconstant $notany 1)
(defconstant $every 2)
(defconstant $notevery 3)

; Error string constants.  As accurate as constants.i ...

(defconstant $xfilebusy -47)
(defconstant $xfileexists -48)
(defconstant $XVUNBND 1)
(defconstant $XNOCDR 2)
(defconstant $XTMINPS 3)
(defconstant $XNEINPS 4)
(defconstant $XWRNGINP 5)
(defconstant $err-bad-input 5)
(defconstant $XFUNBND 6)
(defconstant $err-fundefined 6)
(defconstant $XNOCAR 7)
(defconstant $xcoerce 8)
(defconstant $xnomem 10)
(defconstant $xnotranslation 12)
(defconstant $XNOTFUN 13)
(defconstant $XNOTsymlam 14)
(defconstant $Xdeclpos 15)
(defconstant $Xsetconstant 16)
(defconstant $Xoddsetq 17)
(defconstant $Xbadsetq 18)
(defconstant $Xnotsym 19)
(defconstant $Xisconstant 20)
(defconstant $Xbadinit 21)
(defconstant $Xsmacspec 22)
(defconstant $X2manyargs 23)
(defconstant $XNolexvar 24)
(defconstant $XNolexfunc 25)
(defconstant $XNolextag 26)
(defconstant $XNolexblock 27)
(defconstant $XNotag 28)
(defconstant $Xduplicatetag 29)
(defconstant $XNoblock 30)
(defconstant $XBadLambdaList 31)
(defconstant $XBadLambda 32)
(defconstant $XNOCTAG 33)
(defconstant $XOBJBadType 34)
(defconstant $XFuncLexMacro 35)
(defconstant $xumrpr 41)
(defconstant $xnotsamevol 42)
(defconstant $xbadfilenamechar 43)
(defconstant $xillwild 44)
(defconstant $xnotfaslortext 45)
(defconstant $xrenamedir 46)
(defconstant $xdirnotfile 47)
(defconstant $xnocopydir 48)
(defconstant $XBADTOK 49)
(defconstant $err-long-pstr 49)
(defconstant $xnocreate 50)
(defconstant $XFLOVFL 64)
(defconstant $XDIVZRO 66)
(defconstant $XFLDZRO 66)
(defconstant $XSTKOVER 75)
(defconstant $XMEMFULL 76)
(defconstant $xarrlimit 77)
(defconstant $err-printer 94)
(defconstant $err-printer-load 95)
(defconstant $err-printer-params 96)
(defconstant $err-printer-start 97)
(defconstant $XFLEXC 98)
(defconstant $XMFULL -41)
(defconstant $xfileof 111)
(defconstant $XARROOB 112)
(defconstant $err-arroob 112)
(defconstant $xunread 113)
(defconstant $xbadmac 114)
(defconstant $XCONST 115)
(defconstant $xillchr 116)
(defconstant $xbadsym 117)
(defconstant $xdoterr 118)
(defconstant $xbadrdx 119)
(defconstant $XNOSPREAD 120)
(defconstant $XFASLVERS 121)
(defconstant $XNOTFASL 122)
(defconstant $xudfcall 123)

(defconstant $xusecX 127)
(defconstant $ximprtcx 128)
(defconstant $xbadnum 129)	 ;Bad arg to #b/#o/#x/#r... 
(defconstant $XNOPKG 130)
(defconstant $xnoesym 131)
(defconstant $XBADFASL 132)
(defconstant $ximprtc 133)
(defconstant $xunintc 134)
(defconstant $XSYMACC 135)
(defconstant $XEXPRTC 136)
(defconstant $xusec 137)
(defconstant $xduppkg 138)
(defconstant $xrmactx 139)
(defconstant $xnordisp 140)
(defconstant $xrdnoarg 141)
(defconstant $xrdndarg 142)
(defconstant $xmacrdx 143)
(defconstant $xduprdlbl 144)
(defconstant $xnordlbl 145)
(defconstant $xrdfont 146)
(defconstant $xrdname 147)
(defconstant $XNDIMS 148)
(defconstant $err-disp-size 149)
(defconstant $XNARGS 150)
(defconstant $xdifdim 151)
(defconstant $xkeyconflict 152)
(defconstant $XBADKEYS 153)
(defconstant $xtoofew 154)
(defconstant $xtoomany 155)
(defconstant $XWRONGTYPE 157)
(defconstant $XBADSTRUCT 158)
(defconstant $XSTRUCTBOUNDS 159)
(defconstant $XCALLNOTLAMBDA 160)
(defconstant $XTEMPFLT 161)
(defconstant $xrdfeature 163)
(defconstant $err-no-file 164)
(defconstant $err-bad-named-arg 165)
(defconstant $err-bad-named-arg-2 166)
(defconstant $XCALLTOOMANY 167)
(defconstant $XCALLTOOFEW 168)
(defconstant $XCALLNOMATCH 169)
(defconstant $XIMPROPERLIST 170)
(defconstant $XNOFILLPTR 171)
(defconstant $XMALADJUST 172)
(defconstant $XACCESSNTH 173)
(defconstant $XNOTELT 174)
(defconstant $XSGEXHAUSTED 175)
(defconstant $XSGNARGS 176)
(defconstant $XTOOMANYVALUES 177)


  


(def-accessors (random-state) %svref
  ()
  random.seed-1
  random.seed-2)

;;; IEEE-floating-point constants.  Note that 68K MCL SHORT-FLOATs aren't IEEE SINGLE-FLOATS;
;;; some bits are stolen from the exponent of an IEEE single and used for tagging.

(defconstant IEEE-single-float-bias 126)
(defconstant IEEE-single-float-exponent-offset 23)
(defconstant IEEE-single-float-exponent-width 8)
(defconstant IEEE-single-float-mantissa-offset 0)
(defconstant IEEE-single-float-mantissa-width 23)
(defconstant IEEE-single-float-hidden-bit 23)
(defconstant IEEE-single-float-signalling-NAN-bit 22)
(defconstant IEEE-single-float-normal-exponent-min 1)
(defconstant IEEE-single-float-normal-exponent-max 254)
(defconstant IEEE-single-float-digits (1+ IEEE-single-float-mantissa-width))

;;; Double-floats are IEEE DOUBLE-FLOATs in both MCL implementations.

(defconstant IEEE-double-float-bias 1022)
(defconstant IEEE-double-float-exponent-offset 52)
(defconstant IEEE-double-float-exponent-width 11)
(defconstant IEEE-double-float-mantissa-offset 0)
(defconstant IEEE-double-float-mantissa-width 52)
(defconstant IEEE-double-float-hidden-bit 52)
(defconstant IEEE-double-float-signalling-NAN-bit 51)
(defconstant IEEE-double-float-normal-exponent-min 1)
(defconstant IEEE-double-float-normal-exponent-max 2046)
(defconstant IEEE-double-float-digits (1+ IEEE-double-float-mantissa-width))


;;;;;; clos instance and class layout.

;;; All standard-instances (classes, instances other than funcallable instances)
;;; consist of a vector of slot values and a pointer to the class wrapper.
(def-accessors (instance) %svref
  instance.hash				; a fixnum for EQ-based hashing
  instance.class-wrapper
  instance.slots			; a slot-vector
)
;;; Doing this via %SLOT-REF traps if the slot is unbound
(defmacro standard-instance-instance-location-access (instance location)
  `(%slot-ref (instance.slots ,instance) ,location))

;;; Get the "raw" contents of the slot, even if it's %SLOT-UNBOUND-MARKER.
(defmacro %standard-instance-instance-location-access (instance location)
  `(%svref (instance.slots ,instance) ,location))

(defmacro set-standard-instance-instance-location-access (instance location new)
  `(setf (%svref (instance.slots ,instance) ,location) ,new))

(defsetf standard-instance-instance-location-access
    set-standard-instance-instance-location-access)

(defmacro standard-generic-function-instance-location-access (sgf location)
  `(%slot-ref (gf.slots ,sgf) ,location))

(defmacro %standard-generic-function-instance-location-access (sgf location)
  `(%svref (gf.slots ,sgf) ,location))

(defmacro set-standard-generic-function-instance-location-access (sgf location new)
  `(setf (%svref (gf.slots ,sgf) ,location) ,new))

(defsetf standard-generic-function-instance-location-access
    set-standard-generic-function-instance-location-access)

;;; Slot vectors contain the instance they "belong" to (or NIL) in
;;; their 0th element, and the instance's slots in elements 1 .. n.

(def-accessors (slot-vector) %svref
  slot-vector.instance
  )

(def-accessors (class-wrapper) %svref
  nil                                   ; 'class-wrapper
  %wrapper-hash-index                   ; for generic-function dispatch tables
  %wrapper-class                        ; the class itself
  %wrapper-instance-slots               ; vector of instance slot names
  %wrapper-class-slots                  ; alist of (name . value-cell) pairs
  %wrapper-slot-id->slotd               ; map slot-id to slotd, or NIL
  %wrapper-slot-id-map                  ; (vector (mod nslots) next-slot-id-index)
  %wrapper-slot-definition-table        ; vector of nil || slot-definitions
  %wrapper-slot-id-value                ; "fast" SLOT-VALUE function
  %wrapper-set-slot-id-value            ; "fast" (SETF SLOT-VALUE) function
)

;; Use the wrapper-class-slots for info on obsolete & forwarded instances
;; Note: none of this xx-forwarding-xx or xx-forwarded-xx is valid unless
;; (%wrapper-instance-slots ...) is 0.
(defmacro %wrapper-forwarding-info (instance)
  `(%wrapper-class-slots ,instance))

(defmacro %forwarding-instance-slots (info)
  `(%car ,info))
(defmacro %forwarding-class-slots (info)
  `(%cdr ,info))


(defmacro %wrapper-forwarded-instance-slots (instance)
  `(%forwarding-instance-slots (%wrapper-forwarding-info ,instance)))
(defmacro %wrapper-forwarded-class-slots (instance)
  `(%forwarding-class-slots (%wrapper-forwarding-info ,instance)))


(defmacro %cons-forwarding-info (instance-slots class-slots)
  `(cons ,instance-slots ,class-slots))


(defmacro %cons-wrapper (class &optional 
                               (hash-index '(new-class-wrapper-hash-index)))
  `(%istruct 'class-wrapper ,hash-index ,class nil nil #'slot-id-lookup-no-slots nil nil #'%slot-id-ref-missing #'%slot-id-set-missing))


(defmacro %instance-class (instance)
  `(%wrapper-class (instance.class-wrapper ,instance)))

(def-accessors standard-instance-instance-location-access ;A specializer
    nil					; backptr
  specializer.direct-methods
)

(def-accessors (class) standard-instance-instance-location-access ;Slots of any class
  nil                                   ; backptr
  %class.direct-methods			; aka specializer.direct-methods
  %class.prototype			; prototype instance
  %class.name
  %class.cpl                            ; class-precedence-list
  %class.own-wrapper                    ; own wrapper (or nil)
  %class.local-supers                   ; class-direct-superclasses
  %class.subclasses                     ; class-direct-subclasses
  %class.dependents			; arbitrary dependents
  %class.ctype
)


(def-accessors () standard-instance-instance-location-access ; any standard class
  nil                                   ; slot-vector backptr
  nil                                   ; usual class stuff: direct-methods,
  nil					;   prototype,
  nil					;   name,
  nil					;   cpl,
  nil					;   own-wrapper,
  nil					;   local-supers,
  nil					;   subclasses,
  nil					;   dependents,
  nil					;   ctype.
  %class.direct-slots                   ; local slots
  %class.slots                          ; all slots
  %class.kernel-p			; true if a non-redefinable class
  %class.local-default-initargs         ; local default initargs alist
  %class.default-initargs               ; all default initargs if initialized.
  %class.alist                          ; other stuff about the class.
  %class.make-instance-initargs         ; (vector of) valid initargs to make-instance
  %class.reinit-initargs                ; valid initargs to reinitialize-instance
  %class.redefined-initargs             ; valid initargs to update-instance-for-redefined-class
  %class.changed-initargs               ; valid initargs to update-instance-for-changed-class
  )





(defmacro %instance-vector (wrapper &rest slots)
  (let ((instance (gensym))
	(slots-vector (gensym)))
    `(let* ((,instance (gvector :instance 0 ,wrapper nil))
	    (,slots-vector (gvector :slot-vector ,instance ,@slots)))
       (setf (instance.slots ,instance) ,slots-vector
	     (instance.hash ,instance) (strip-tag-to-fixnum ,instance))
       ,instance)))
 
(defmacro %cons-built-in-class (name)
  `(%instance-vector *built-in-class-wrapper* nil nil ,name nil nil nil nil nil nil))


(defmacro %cons-standard-class (name &optional
                                     (metaclass-wrapper '*standard-class-wrapper*))
  `(%instance-vector  ,metaclass-wrapper
                      nil nil ,name nil nil nil nil nil nil nil nil
                      nil nil nil nil nil nil nil nil)

)

(def-accessors () standard-instance-instance-location-access
  nil					; backptr
  standard-slot-definition.name
  standard-slot-definition.type
  standard-slot-definition.initfunction
  standard-slot-definition.initform
  standard-slot-definition.initargs
  standard-slot-definition.allocation
  standard-slot-definition.documentation
  standard-slot-definition.class
  )

(def-accessors () standard-instance-instance-location-access
  nil
  standard-effective-slot-definition.name
  standard-effective-slot-definition.type
  standard-effective-slot-definition.initfunction
  standard-effective-slot-definition.initform
  standard-effective-slot-definition.initargs
  standard-effective-slot-definition.allocation
  standard-effective-slot-definition.documentation
  standard-effective-slot-definition.class
  standard-effective-slot-definition.location
  standard-effective-slot-definition.slot-id
  standard-effective-slot-definition.type-predicate
  )


(def-accessors () standard-instance-instance-location-access
  nil
  standard-direct-slot-definition.name
  standard-direct-slot-definition.type
  standard-direct-slot-definition.initfunction
  standard-direct-slot-definition.initform
  standard-direct-slot-definition.initargs
  standard-direct-slot-definition.allocation
  standard-direct-slot-definition.documentation
  standard-direct-slot-definition.class
  standard-direct-slot-definition.readers
  standard-direct-slot-definition.writers  
  )

;; Methods
(defmacro %cons-method (name qualifiers specializers function &optional 
                             (class '*standard-method-class*))
  `(%instance-vector 
    (%class.own-wrapper ,class)
    ,qualifiers
    ,specializers
    ,function
    nil
    ,name))


(def-accessors standard-instance-instance-location-access ; method
  nil                                   ; backptr
  %method.qualifiers
  %method.specializers
  %method.function
  %method.gf
  %method.name
  %method.lambda-list)

;;; Painful, but seems to be necessary.
(def-accessors standard-instance-instance-location-access ; standard-accessor-method
  nil                                   ; backptr
  nil					;%method.qualifiers
  nil					;%method.specializers
  nil					;%method.function
  nil					;%method.gf
  nil					;%method.name
  nil					;%method.lambda-list
  %accessor-method.slot-definition)





;; Generic Function Dispatch tables.
;; These accessors are at the beginning of the table.
;; rest of the table is alternating wrappers & combined-methods.

(def-accessors %svref
    %gf-dispatch-table-methods		; List of methods
    %gf-dispatch-table-precedence-list	; List of argument numbers in precedence order
    %gf-dispatch-table-keyvect          ; keyword vector, set by E-G-F.
    %gf-dispatch-table-argnum		; argument number
    %gf-dispatch-table-gf		; back pointer to gf - NEW
    %gf-dispatch-table-mask		; mask for rest of table
    %gf-dispatch-table-first-data)	; offset to first data.  Must follow mask.
  
(defmacro %gf-dispatch-table-size (dt)
  `(%i- (uvsize ,dt) ,(+ 2 %gf-dispatch-table-first-data)))

(defmacro %gf-dispatch-table-ref (table index)
  `(svref ,table (%i+ ,index %gf-dispatch-table-first-data)))

(defmacro %cons-gf-dispatch-table (size)
  `(make-array (%i+ ,size ,(%i+ 2 %gf-dispatch-table-first-data))
               :initial-element nil))


; method-combination info
(def-accessors svref
  mci.class                             ; short-method-combination or long-method-combination
  mci.options                           ; short-form-options or long-form function
  mci.instances                         ; a population of instances
  mci.gfs                               ; a population of generic-functions
  )

(defmacro %cons-mci (&optional class options)
  `(vector ,class ,options (%cons-population nil) (%cons-population nil)))

; slot accessor info for primary classes
(def-accessors %svref
  %slot-accessor-info.class
  (%slot-accessor-info.accessor %slot-accessor-info.slot-name)
  %slot-accessor-info.offset
  )

(defmacro %cons-slot-accessor-info (class accessor-or-slot-name &optional offset)
  `(vector ,class ,accessor-or-slot-name ,offset))

(def-accessors (combined-method) %svref
  combined-method.code-vector		; trampoline code vector
  combined-method.thing			; arbitrary arg to dcode
  combined-method.dcode			; discriminator function
  combined-method.gf			; gf
  combined-method.bits			; lfun-bits
  )
;;; The structure of a generic-function object (funcallable instance).
(def-accessors (generic-function) %svref
  gf.code-vector			; trampoline code-vector
  gf.instance.class-wrapper		; instance class-wrapper
  gf.slots				; slots vector
  gf.dispatch-table			; effective-method cache
  gf.dcode				; discriminating code
  gf.hash				; hashing identity
  gf.bits				;
  )

;;; The slots of STANDARD-GENERIC-FUNCTION.
(def-accessors (standard-generic-function) standard-generic-function-instance-location-access
  nil					; backptr
  sgf.name				; generic-function-name
  sgf.method-combination		; generic-function-method-combination
  sgf.method-class			; generic-function-method-class
  sgf.methods				; generic-function-methods
  sgf.decls				; generic-function-declarations
  sgf.%lambda-list                      ; explicit lambda-list
  sgf.dependents			; dependents for MAP-DEPENDENTS et al.
  )

(def-accessors (slot-id) %svref
  nil                                   ;'slot-id
  slot-id.name                          ; slot name (symbol)
  slot-id.index                         ; index (integer)
  )

(provide "LISPEQU")

; End of lispequ.lisp
