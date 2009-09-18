;;-*- Mode: Lisp; Package: CCL -*-

;; $Log: ppc-lapmacros.lisp,v $
;; Revision 1.4  2003/11/17 21:01:49  alice
;; ;; 11/14/03 Replace MCRXR with (MTXER rzero)
;;
;; Revision 1.3  2002/11/25 05:39:46  gtbyers
;; Macros for saving/restoring vector registers, a la OpenMCL.
;;
;; Revision 1.2  2002/11/18 05:36:25  gtbyers
;; Add CVS log marker
;;
;;	Change History (most recent first):
;;  21 1/22/97 akh  dbg doesn't clobber imm0
;;  19 5/20/96 akh  add %car
;;  7 10/26/95 gb   not sure what changed
;;  4 10/13/95 bill ccl3.0x25
;;  3 10/7/95  slh  added arith/misc macros at end
;;  2 10/6/95  gb   new EVENT-POLL.
;;  (do not edit before this line!!)

;; Mod History
;;
;; box-signed/unsigned-byte-32 - no more use of uuo's
;; -------- 5.2b6
;; 11/14/03 Replace MCRXR with (MTXER rzero)
;; ------- 5.0 final
;; 03/01/97 gb    some fp stuff, eq->boolean.
;; 02/25/97 bill  xp-register-image, xp-machine-state, ri-grp, set-ri-gpr, ms-XX, set-ms-XX
;; 02/03/97 bill  Gary's fix to check-nargs: twlgt => twlgti
;; -------------- 4.0
;; akh add %car
;; 07/07/96 bill  dbg
;; 06/17/96 bill  no-memoize optional arg to svset
;; -------------  MCL-PPC 3.9
;; 03/27/96 bill  svset memoizes the modified address
;; 03/10/96 gb    FP stuff
;; 01/25/96 bill  svref, svset
;; 01/04/96 bill  fix box-signed-byte-32
;; 12/27/95 gb    vpush-argregs.
;; 12/13/95 gb    box-[signed,unsigned]-byte-32
;; 11/29/95 bill  unbox-base-character, unbox-character, box-character
;; 11/15/95 slh   no blr in make-int macro
;; 10/25/95 slh   make-int
;; 10/19/95 slh   compose-digit here
;; 10/12/95 bill  :loa-toplevel -> :load-toplevel
;;

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require "PPC-LAP"))

(defppclapmacro dbg (&optional save-lr?)
  (if save-lr?
    `(progn
       (mflr loc-pc)
       (stw imm0 -40 sp) ; better than clobbering imm0
       (bla .SPbreakpoint)
       (lwz imm0 -40 sp)
       (mtlr loc-pc))
    `(bla .SPbreakpoint)))

(defppclapmacro lwi (dest n)
  (setq n (logand n #xffffffff))
  (let* ((mask #xffff8000)
         (masked (logand n mask))
         (high (ash n -16))
         (low (logand #xffff n)))
    (if (or (= 0 masked) (= mask masked))
      `(li ,dest ,low)
      (if (= low 0)
        `(lis ,dest ,high)
        `(progn
           (lis ,dest ,high)
           (ori ,dest ,dest ,low))))))

(defppclapmacro set-nargs (n)
  (check-type n (unsigned-byte 13))
  `(li nargs ',n))

(defppclapmacro check-nargs (min &optional (max min))
  (let* ((ok (gensym)))
    (if (eq max min)
      `(progn
         (cmpwi nargs ',min)
         (beq ,ok)
         (mflr loc-pc)
         (bla .SPtrap-wrongnargs)
         ,ok)
      (if (null max)
        (unless (= min 0)
          `(progn
             (cmplwi nargs ',min)
             (bge ,ok)
             (mflr loc-pc)
             (bla .SPtrap-toofewargs)
             ,ok))
        (if (= min 0)
          `(progn
             (cmplwi nargs ',max)
             (ble ,ok)
             (mflr loc-pc)
             (bla .SPtrap-toomanyargs)
             ,ok)
          (let* ((enough (gensym)))
            `(progn
               (cmplwi nargs ',min)
               (mflr loc-pc)
               (bge ,enough)
               (bla .SPtrap-toofewargs)
               ,enough
               (cmplwi nargs ',max)
               (ble ,ok)
               (bla .SPtrap-toomanyargs)
               ,ok)))))))

; Event-polling involves checking to see if the value of *interrupt-level*
; is > 0.  For now, use nargs; this may change to "any register BUT nargs".
; (Note that most number-of-args traps use unsigned comparisons.)
(defppclapmacro event-poll ()
  `(bla .SPtrap-intpoll))

(defppclapmacro stack-overflow-check ()
  `(progn)
)



; There's no "else"; learn to say "(progn ...)".
; Note also that the condition is a CR bit specification (or a "negated" one).
; Whatever affected that bit (hopefully) happened earlier in the pipeline.
(defppclapmacro if (test then &optional (else nil else-p))
  (multiple-value-bind (bitform negated) (ppc-lap-parse-test test)
    (let* ((false-label (gensym)))
      (if (not else-p)
      `(progn
         (,(if negated 'bt 'bf) ,bitform ,false-label)
         ,then
         ,false-label)
      (let* ((cont-label (gensym)))
        `(progn
          (,(if negated 'bt 'bf) ,bitform ,false-label)
          ,then
          (b ,cont-label)
          ,false-label
          ,else
          ,cont-label))))))

(defppclapmacro save-pc ()
  `(mflr loc-pc))

; This needs to be done if we aren't a leaf function (e.g., if we clobber our
; return address or need to reference any constants.  Note that it's not
; atomic wrt a preemptive scheduler, but we need to pretend that it will be.)
; The VSP to be saved is the value of the VSP before any of this function's
; arguments were vpushed by its caller; that's not the same as the VSP register
; if any non-register arguments were received, but is usually easy to compute.

(defppclapmacro save-lisp-context (&optional (vsp 'vsp) (save-pc t))
  `(progn
     ,@(if save-pc 
         '((save-pc)))
     (stwu sp (- ppc::lisp-frame.size) sp)
     (stw fn ppc::lisp-frame.savefn sp)
     (mr fn nfn)
     (stw loc-pc ppc::lisp-frame.savelr sp)
     (stw ,vsp ppc::lisp-frame.savevsp sp)))

; There are a few cases to deal with when restoring: whether or not to restore the
; vsp, whether we need to saved LR back in the LR or whether it only needs to get
; as far as loc-pc, etc.  This fully restores everything (letting the caller specify
; some register other than the VSP, if that's useful.)  Note that, since FN gets restored,
; it's no longer possible to use it to address the current function's constants.
(defppclapmacro restore-full-lisp-context (&optional (vsp 'vsp))
  `(progn
     (lwz loc-pc ppc::lisp-frame.savelr sp)
     (lwz ,vsp ppc::lisp-frame.savevsp sp)
     (mtlr loc-pc)
     (lwz fn ppc::lisp-frame.savefn sp)
     (la sp ppc::lisp-frame.size sp)))

(defppclapmacro restore-pc ()
  `(mtlr loc-pc))

(defppclapmacro push (src stack)
  `(stwu ,src -4 ,stack))

(defppclapmacro vpush (src)
  `(push ,src vsp))

; You typically don't want to do this to pop a single register (it's better to
; do a sequence of loads, and then adjust the stack pointer.)

(defppclapmacro pop (dest stack)
  `(progn
     (lwz ,dest 0 ,stack)
     (la ,stack 4 ,stack)))

(defppclapmacro vpop (dest)
  `(pop ,dest vsp))

(defppclapmacro %cdr (dest node)
  `(lwz ,dest ppc::cons.cdr ,node))

(defppclapmacro %car (dest node)
  `(lwz ,dest ppc::cons.car ,node))

(defppclapmacro extract-lisptag (dest node)
  `(clrlwi ,dest ,node (- 32 ppc::nlisptagbits)))

(defppclapmacro extract-lisptag. (dest node)
  `(clrlwi. ,dest ,node (- 32 ppc::nlisptagbits)))

(defppclapmacro extract-fulltag (dest node)
  `(clrlwi ,dest ,node (- 32 ppc::ntagbits)))

(defppclapmacro extract-subtag (dest node)
  `(lbz ,dest ppc::misc-subtag-offset ,node))

(defppclapmacro extract-typecode (dest node &optional (crf :cr0))
  `(progn
     (extract-lisptag ,dest ,node)
     (cmpwi ,crf ,dest ppc::tag-misc)
     (if (,crf :eq)
       (extract-subtag ,dest ,node))))

(defppclapmacro trap-unless-fixnum (node &optional (immreg ppc::imm0))
  (let* ((ok (gensym)))
    `(progn
       (extract-lisptag. ,immreg ,node)
       (beq ,ok)
       (bla .SPxuuo-interr)
       (uuo_interr ppc::error-object-not-fixnum ,node)
       ,ok)))

(defppclapmacro trap-unless-uvector (node &optional (immreg ppc::imm0))
  (let* ((ok (gensym)))
    `(progn
       (extract-fulltag ,immreg ,node)
       (cmpwi ,immreg ppc::fulltag-misc)
       (beq ,ok)
       (bla .SPxuuo-interr)
       (uuo_interr ppc::error-object-not-fixnum ,node)
       ,ok)))




(defppclapmacro trap-unless-typecode= (node tag &optional (immreg ppc::imm0) (crf :cr0))
  (let* ((ok (gensym)))
    `(progn
       (extract-typecode ,immreg ,node ,crf)
       (cmpwi ,crf ,immreg ,tag)
       (beq ,crf ,ok)
       (bla .SPxuuo-interr)
       (uuo_interr ,(logior ppc::error-subtag-error (eval tag)) ,node)
       ,ok)))



(defppclapmacro load-constant (dest constant)
  `(lwz ,dest ',constant fn))

;; This is about as hard on the pipeline as anything I can think of.
(defppclapmacro call-symbol (function-name)
  `(progn
     (load-constant fname ,function-name)
     (lwz nfn ppc::symbol.fcell fname)
     (lwz temp0 ppc::misc-data-offset nfn)
     (la loc-pc ppc::misc-data-offset temp0)
     (mtctr loc-pc)
     (bctrl)))

(defppclapmacro sp-call-symbol (function-name)
  `(progn
     (load-constant fname ,function-name)
     (bla .SPjmpsym)))

(defppclapmacro getvheader (dest src)
  `(lwz ,dest ppc::misc-header-offset ,src))

;; "Size" is unboxed element-count.
(defppclapmacro header-size (dest vheader)
  `(srwi ,dest ,vheader ppc::num-subtag-bits))

;; "Length" is fixnum element-count.
(defppclapmacro header-length (dest vheader)
  `(rlwinm ,dest 
           ,vheader 
           (- ppc::nbits-in-word (- ppc::num-subtag-bits ppc::nfixnumtagbits))
           (- ppc::num-subtag-bits ppc::nfixnumtagbits)
           (- ppc::least-significant-bit ppc::nfixnumtagbits)))

(defppclapmacro header-subtag[fixnum] (dest vheader)
  `(rlwinm ,dest
           ,vheader
           ppc::fixnumshift
           (- ppc::nbits-in-word (+ ppc::num-subtag-bits ppc::nfixnumtagbits))
           (- ppc::least-significant-bit ppc::nfixnumtagbits)))


(defppclapmacro vector-size (dest v vheader)
  `(progn
     (getvheader ,vheader ,v)
     (header-size ,dest ,vheader)))

(defppclapmacro vector-length (dest v vheader)
  `(progn
     (getvheader ,vheader ,v)
     (header-length ,dest ,vheader)))


;; Reference a 32-bit miscobj entry at a variable index.
;; Make the caller explicitly designate a scratch register
;; to use for the scaled index.

(defppclapmacro vref32 (dest miscobj index scaled-idx)
  `(progn
     (la ,scaled-idx ppc::misc-data-offset ,index)
     (lwzx ,dest ,miscobj ,scaled-idx)))

;; The simple (no-memoization) case.
(defppclapmacro vset32 (src miscobj index scaled-idx)
  `(progn
     (la ,scaled-idx ppc::misc-data-offset ,index)
     (stwx ,src ,miscobj ,scaled-idx)))

(defppclapmacro extract-lowbyte (dest src)
  `(clrlwi ,dest ,src (- 32 8)))

(defppclapmacro unbox-fixnum (dest src)
  `(srawi ,dest ,src ppc::fixnumshift))

(defppclapmacro box-fixnum (dest src)
  `(slwi ,dest ,src ppc::fixnumshift))




; If crf is specified, type checks src
(defppclapmacro unbox-base-character (dest src &optional crf)
  (if (null crf)
    `(srwi ,dest ,src ppc::charcode-shift)
    (let ((label (gensym)))
      `(progn
         (rlwinm ,dest ,src 8 16 31)
         (cmpwi ,crf ,dest (ash ppc::subtag-character 8))
         (srwi ,dest ,src ppc::charcode-shift)
         (beq ,crf ,label)
         (bla .SPxuuo-interr)
         (uuo_interr ppc::error-object-not-base-character ,src)
         ,label))))

; If crf is specified, type checks src
(defppclapmacro unbox-character (dest src &optional crf)
  (if (null crf)
    `(srwi ,dest ,src ppc::charcode-shift)
    (let ((label (gensym)))
      `(progn
         (clrlwi ,dest ,src 24)
         (cmpwi ,crf ,dest ppc::subtag-character)
         (srwi ,dest ,src ppc::charcode-shift)
         (beq ,crf ,label)
         (uuo_interr ppc::error-object-not-character ,src)
         ,label))))

(defppclapmacro box-character (dest src)
  `(progn
     (li ,dest ppc::subtag-character)
     (rlwimi ,dest ,src 16 0 15)))

(defppclapmacro ref-global (reg sym)
  (let* ((offset (ppc::%kernel-global sym)))
    `(lwz ,reg ,offset rnil)))

(defppclapmacro set-global (reg sym)
  (let* ((offset (ppc::%kernel-global sym)))
    `(stw ,reg ,offset rnil)))

; Set "dest" to those bits in "src" that are other than those
; that would be set if "src" is a fixnum and of type (unsigned-byte "width").
; If no bits are set in "dest", then "src" is indeed of type (unsigned-byte "width").
(defppclapmacro extract-unsigned-byte-bits (dest src width)
  `(rlwinm ,dest ,src 0 (- 32 ppc::fixnumshift) (- 31 (+ ,width ppc::fixnumshift))))

; As above, but set (:CR0 :EQ) according to the result.
(defppclapmacro extract-unsigned-byte-bits. (dest src width)
  `(rlwinm. ,dest ,src 0 (- 32 ppc::fixnumshift) (- 31 (+ ,width ppc::fixnumshift))))


;;; from/blame slh:

; setpred depends on this
(eval-when (:compile-toplevel :execute :load-toplevel)
  (assert (= ppc::t-offset #x11)))

(defppclapmacro setpred (dest crf cc-bit &optional (temp 'imm0))
  (let ((shift (+ (* (position crf '(:cr0 :cr1 :cr2 :cr3 :cr4 :cr5 :cr6 :cr7)) 4)
                  (position cc-bit '(:lt :gt :eq :so))
                  1)))
    `(progn
       (mfcr ,temp)
       (rlwinm ,temp ,temp ,shift 31 31)    ; get  1 bit
       (rlwimi ,temp ,temp      4 27 27)    ; get 16 bit
       (add ,dest ,temp rnil))))

; You generally don't want to have to say "mfcr": it crosses functional
; units and forces synchronization (all preceding insns must complete,
; no subsequent insns may start.)
; There are often algebraic ways of computing ppc::t-offset:

(defppclapmacro eq0->boolean (dest src temp)
  `(progn
     (cntlzw ,temp ,src)                ; 32 leading zeros if (= rx ry)
     (srwi ,temp ,temp 5)               ; temp = (rx == ry), C-wise
     (rlwimi ,temp ,temp 4 27 27)       ; temp = ppc::t-offset or 0
     (add ,dest ppc::rnil ,temp)))      ; dest = (eq rx ry), lisp-wise

(defppclapmacro eq->boolean (dest rx ry temp)
  `(progn
     (sub ,temp ,rx ,ry)
     (eq0->boolean ,dest ,temp ,temp)))


  


(defppclapmacro get-single-float (dest node)
  `(lfs ,dest ppc::single-float.value ,node))

(defppclapmacro get-double-float (dest node)
  `(lfd ,dest ppc::double-float.value ,node))

(defppclapmacro put-single-float (src node)
  `(stfs ,src ppc::single-float.value ,node))

(defppclapmacro put-double-float (src node)
  `(stfd ,src ppc::double-float.value ,node))

#| ;; put this back if they ever fix OSX re preserving fpr's
(defppclapmacro clear-fpu-exceptions ()
  `(mtfsf #xfc #.ppc::fp-zero))

|#


(defppclapmacro clear-fpu-exceptions ()
  `(progn
     (lfs #.ppc::fp-zero (ppc::kernel-global short-float-zero) ppc::rnil)
     (mtfsf #xfc #.ppc::fp-zero)))




(defppclapmacro get-boxed-sign (dest src crf)
  `(progn
     (load-constant ,dest 1)               ; assume positive
     (mtcrf ,crf ,src)
     (if (,crf :lt)
       (load-constant ,dest -1))))

; from ppc-bignum.lisp
(defppclapmacro digit-h (dest src)
  `(rlwinm ,dest ,src (+ 16 ppc::fixnumshift) (- 16 ppc::fixnumshift) (- 31 ppc::fixnumshift)))

; from ppc-bignum.lisp
(defppclapmacro digit-l (dest src)
  `(clrlslwi ,dest ,src 16 ppc::fixnumshift))
  
; from ppc-bignum.lisp
(defppclapmacro compose-digit (dest high low)
  `(progn
     (rlwinm ,dest ,low (- ppc::nbits-in-word ppc::fixnumshift) 16 31)
     (rlwimi ,dest ,high (- 16 ppc::fixnumshift) 0 15)))

(defppclapmacro macptr-ptr (dest macptr)
  `(lwz ,dest ppc::macptr.address ,macptr))

(defppclapmacro svref (dest index vector)
  `(lwz ,dest (+ (* 4 ,index) ppc::misc-data-offset) ,vector))

; This evals its args in the wrong order.
; Can't imagine any code will care.
(defppclapmacro svset (new-value index vector &optional no-memoize)
  (if no-memoize
    `(stw ,new-value (+ (* 4 ,index) ppc::misc-data-offset) ,vector)
    `(progn
       (la loc-g (+ (* 4 ,index) ppc::misc-data-offset) ,vector)
       (stw ,new-value 0 loc-g)
      (bla .SPwrite-barrier))))



(defppclapmacro vpush-argregs ()
  (let* ((none (gensym))
         (two (gensym))
         (one (gensym)))
  `(progn
     (cmpwi cr1 nargs '2)
     (cmpwi cr0 nargs 0)
     (beq cr1 ,two)
     (beq cr0 ,none)
     (blt cr1 ,one)
     (vpush arg_x)
     ,two
     (vpush arg_y)
     ,one
     (vpush arg_z)
     ,none)))


; Set FP-reg to 0.0 . Using (fsub fp-reg fp-reg fpreg)
; doesn't work if fp-reg contains a NaN.

(defppclapmacro zero-fp-reg (fp-reg)
  (let* ((offset (ppc::kernel-global short-float-zero)))
    `(lfs ,fp-reg ,offset rnil)))

(defppclapmacro fp-check-binop-exception (insn)
  `(progn
     ,insn
     (if (:cr1 :gt)                     ; set if enabled exception has occurred
       (progn
         (bla .SPfpu-exception)
         ,insn))))

(defppclapmacro fp-check-unaryop-exception (insn)
  `(progn
    ,insn
     (if (:cr1 :gt)                     ; set if enabled exception has occurred
       (progn
         (bla .SPfpu-exception)
         ,insn))))


; Functions to access exception frames

(defppclapmacro xp-register-image (ri xp)
  `(lwz ,ri ,(get-field-offset :ExceptionInformationPowerPC.registerImage) ,xp))

(defppclapmacro ri-gpr (dest ri reg)
  `(lwz ,dest ,(xp-register-offset (eval reg)) ,ri))

(defppclapmacro set-ri-gpr (source ri reg)
  `(stw ,source ,(xp-register-offset (eval reg)) ,ri))

(defppclapmacro xp-machine-state (ms xp)
  `(lwz ,ms ,(get-field-offset :ExceptionInformationPowerPC.machineState) ,xp))

(defppclapmacro ms-lr (dest ms)
  `(lwz ,dest ,(get-field-offset :MachineInformationPowerPC.lr.lo) ,ms))

(defppclapmacro set-ms-lr (source ms)
  `(stw ,source ,(get-field-offset :MachineInformationPowerPC.lr.lo) ,ms))

(defppclapmacro ms-pc (dest ms)
  `(lwz ,dest ,(get-field-offset :MachineInformationPowerPC.pc.lo) ,ms))

(defppclapmacro set-ms-pc (source ms)
  `(stw ,source ,(get-field-offset :MachineInformationPowerPC.pc.lo) ,ms))

(defppclapmacro ms-cr (dest ms)
  `(lwz ,dest ,(get-field-offset :MachineInformationPowerPC.cr) ,ms))

(defppclapmacro set-ms-cr (source ms)
  `(stw ,source ,(get-field-offset :MachineInformationPowerPC.cr) ,ms))

(defppclapmacro ms-xer (dest ms)
  `(lwz ,dest ,(get-field-offset :MachineInformationPowerPC.xer) ,ms))

(defppclapmacro set-ms-xer (source ms)
  `(stw ,source ,(get-field-offset :MachineInformationPowerPC.xer) ,ms))


;;; Saving and restoring AltiVec registers.

;;; Note that under the EABI (to which PPCLinux conforms), the OS
;;; doesn't attach any special significance to the value of the VRSAVE
;;; register (spr 256).  Under some other ABIs, VRSAVE is a bitmask
;;; which indicates which vector registers are live at context switch
;;; time.  These macros contain code to maintain VRSAVE when the
;;; variable *ALTIVEC-LAPMACROS-MAINTAIN-VRSAVE-P* is true at
;;; macroexpand time; that variable is initialized to true if and only
;;; if :EABI-TARGET is not on *FEATURES*.  Making this behavior
;;; optional is supposed to help make code which uses these macros
;;; easier to port to other platforms.

;;; From what I can tell, a function that takes incoming arguments in
;;; vector registers (vr2 ... vr13) (and doesn't use any other vector
;;; registers) doesn't need to assert that it uses any vector
;;; registers (even on platforms that maintain VRSAVE.)  A function
;;; that uses vector registers that were not incoming arguments has to
;;; assert that it uses those registers on platforms that maintain
;;; VRSAVE.  On all platforms, a function that uses any non-volatile
;;; vector registers (vr20 ... vr31) has to assert that it uses these
;;; registers and save and restore the caller's value of these registers
;;; around that usage.

(defparameter *altivec-lapmacros-maintain-vrsave-p*
  #+apple t
  #-apple
  #-eabi-target t
  #+eabi-target nil)

(defun %vr-register-mask (reglist)
  (let* ((mask 0))
    (dolist (reg reglist mask)
      (let* ((regval (ppc-vector-register-name-or-expression reg)))
        (unless (typep regval '(mod 32))
          (error "Bad AltiVec register - ~s" reg))
        (setq mask (logior mask (ash #x80000000 (- regval))))))))



;;; Build a frame on the temp stack large enough to hold N 128-bit vector
;;; registers and the saved value of the VRSAVE spr.  That frame will look
;;; like:
;;; #x??????I0   backpointer to previous tstack frame
;;; #x??????I4   non-zero marker: frame doesn't contain tagged lisp data
;;; #x??????I8   saved VRSAVE
;;; #x??????IC   pad word for alignment
;;; #x??????J0   first saved vector register
;;; #x??????K0   second saved vector register
;;;   ...
;;; #x??????X0   last saved vector register
;;; #x??????Y0   (possibly) 8 bytes wasted for alignment.
;;; #x????????   UNKNOWN; not necessarily the previous tstack frame
;;;
;;;  Use the specified immediate register to build the frame.
;;;  Save the caller's VRSAVE in the frame.

(defppclapmacro %build-vrsave-frame (n tempreg)
  (if (or (> n 0) *altivec-lapmacros-maintain-vrsave-p*)
    (if (zerop n)
      ;; Just make room for vrsave; no need to align to 16-byte boundary.
      `(progn
	(stwu tsp -16 tsp)
	(stw tsp 4 tsp))
      `(progn
	(la ,tempreg ,(- (ash (1+ n) 4)) ppc::tsp)
	(clrrwi ,tempreg ,tempreg 4)	; align to 16-byte boundary
	(sub ,tempreg ,tempreg ppc::tsp) ; calculate (aligned) frame size.
	(stwux ppc::tsp ppc::tsp ,tempreg)
	(stw ppc::tsp 4 ppc::tsp)))	; non-zero: non-lisp
    `(progn)))

;;; Save the current value of the VRSAVE spr in the newly-created
;;; tstack frame.

(defppclapmacro %save-vrsave (tempreg)
  (if *altivec-lapmacros-maintain-vrsave-p*
    `(progn
      (mfspr ,tempreg 256)		; SPR 256 = vrsave
      (stw ,tempreg 8 tsp))
    `(progn)))



;;; When this is expanded, "tempreg" should contain the caller's vrsave.
(defppclapmacro %update-vrsave (tempreg mask)
  (let* ((mask-high (ldb (byte 16 16) mask))
         (mask-low (ldb (byte 16 0) mask)))
    `(progn
       ,@(unless (zerop mask-high) `((oris ,tempreg ,tempreg ,mask-high)))
       ,@(unless (zerop mask-low) `((ori ,tempreg ,tempreg ,mask-low)))
       (mtspr 256 ,tempreg))))

;;; Save each of the vector regs in "nvrs" into the current tstack 
;;; frame, starting at offset 16
(defppclapmacro %save-vector-regs (nvrs tempreg)
  (let* ((insts ()))
    (do* ((offset 16 (+ 16 offset))
          (regs nvrs (cdr regs)))
         ((null regs) `(progn ,@(nreverse insts)))
      (declare (fixnum offset))
      (push `(la ,tempreg ,offset ppc::tsp) insts)
      (push `(stvx ,(car regs) ppc::rzero ,tempreg) insts))))


;;; Pretty much the same idea, only we restore VRSAVE first and
;;; discard the tstack frame after we've reloaded the vector regs.
(defppclapmacro %restore-vector-regs (nvrs tempreg)
  (let* ((loads ()))
    (do* ((offset 16 (+ 16 offset))
          (regs nvrs (cdr regs)))
         ((null regs) `(progn
			,@ (when *altivec-lapmacros-maintain-vrsave-p*
			     `((progn
				 (lwz ,tempreg 8 ppc::tsp)
				 (mtspr 256 ,tempreg))))
			,@(nreverse loads)
			(lwz ppc::tsp 0 ppc::tsp)))
      (declare (fixnum offset))
      (push `(la ,tempreg ,offset ppc::tsp) loads)
      (push `(lvx ,(car regs) ppc::rzero ,tempreg) loads))))


(defun %extract-non-volatile-vector-registers (vector-reg-list)
  (let* ((nvrs ()))
    (dolist (reg vector-reg-list (nreverse nvrs))
      (let* ((regval (ppc-vector-register-name-or-expression reg)))
        (unless (typep regval '(mod 32))
          (error "Bad AltiVec register - ~s" reg))
        (when (>= regval 20)
          (pushnew regval nvrs))))))


;;; One could imagine something more elaborate:
;;; 1) Binding a global bitmask that represents the assembly-time notion
;;;    of VRSAVE's contents; #'ppc-vector-register-name-or-expression
;;;    could then warn if a vector register wasn't marked as active.
;;;    Maybe a good idea, but PPC-LAP would have to bind that special
;;;    variable to 0 to make things reentrant.
;;; 2) Binding a user-specified variable to the list of NVRs that need
;;;    to be restored, so that it'd be more convenient to insert one's
;;;    own calls to %RESTORE-VECTOR-REGS at appropriate points.
;;; Ad infinitum.  As is, this allows one to execute a "flat" body of code
;;;   that's bracketed by the stuff needed to keep VRSAVE in sync and
;;;   to save and restore any non-volatile vector registers specified.
;;;   That body of code is "flat" in the sense that it doesn't return,
;;;   tail-call, establish a catch or unwind-protect frame, etc.
;;;   It -can- contain lisp or foreign function calls.

(defppclapmacro %with-altivec-registers ((&key (immreg 'ppc::imm0)) reglist &body body)
  (let* ((mask (%vr-register-mask reglist))
         (nvrs (%extract-non-volatile-vector-registers reglist))
         (num-nvrs (length nvrs)))
    (if (or *altivec-lapmacros-maintain-vrsave-p* nvrs)
      `(progn
	(%build-vrsave-frame ,num-nvrs ,immreg)
	(%save-vrsave ,immreg)
	,@ (if *altivec-lapmacros-maintain-vrsave-p*
	     `((%update-vrsave ,immreg ,mask)))
	(%save-vector-regs ,nvrs ,immreg)
	(progn ,@body)
	(%restore-vector-regs ,nvrs ,immreg))
      `(progn ,@body))))


(defppclapmacro with-altivec-registers (reglist &body body)
  `(%with-altivec-registers () ,reglist ,@body))


;;; Create an aligned buffer on the temp stack, large enough for N vector
;;; registers.  Make base be a pointer to this buffer (base can be
;;; any available GPR, since the buffer will be fixnum-tagged.) N should
;;; be a constant.
;;; The intent here is that the register 'base' can be used in subsequent
;;; stvx/lvx instructions.  Any vector registers involved in such instructions
;;; must have their corresponding bits saved in VRSAVE on platforms where
;;; that matters.

(defppclapmacro allocate-vector-buffer (base n)
  `(progn
    (stwux tsp (- (ash (1+ ,n) 4)))	; allocate a frame on temp stack
    (stw tsp 4 tsp)			; temp frame contains immediate data
    (la ,base (+ 8 8) tsp)		; skip header, round up
    (clrrwi ,base ,base 4)))		; align (round down)

;;; Execute the specified body of code; on entry to that body, BASE
;;; will point to the lowest address of a vector-aligned buffer with
;;; room for N vector registers.  On exit, the buffer will be
;;; deallocated.  The body should preserve the value of BASE as long
;;; as it needs to reference the buffer.

(defppclapmacro with-vector-buffer (base n &body body)
  `(progn
    (allocate-vector-buffer ,base ,n)
    (progn
      (progn ,@body)
      (unlink tsp))))

#|

;;; This is just intended to test the macros; I can't test whether or not the code works.

(defppclapfunction load-array ((n arg_z))
  (check-nargs 1)
  (with-altivec-registers (vr1 vr2 vr3 vr27) ; Clobbers imm0
    (li imm0 ppc::misc-data-offset)
    (lvx vr1 arg_z imm0)		; load MSQ
    (lvsl vr27 arg_z imm0)		; set the permute vector
    (addi imm0 imm0 16)			; address of LSQ
    (lvx vr2 arg_z imm0)		; load LSQ
    (vperm vr3 vr1 vr2 vr27)		; aligned result appears in VR3
    (dbg t))				; Look at result in some debugger
  (blr))
|#




(ccl::provide "PPC-LAPMACROS")

; end of ppc-lapmacros.lisp
