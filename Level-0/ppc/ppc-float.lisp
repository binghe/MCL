;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  7 6/2/97   akh  stuff re Nans
;;  6 4/1/97   akh  see below
;;  5 3/17/97  akh  %bignum-sfloat and %short-float of ratio - don't dfloat first
;;  4 3/14/97  akh  see below
;;  33 1/22/97 akh  optimizations
;;  31 9/13/96 akh  expt again - (expt 0 0.0) IS supposed to be an error
;;  29 5/20/96 akh  fix %double-float of ratio
;;  28 4/19/96 akh  see below
;;  27 4/17/96 akh  see below
;;  25 4/1/96  akh  fsqrt catch underflow and compensate, %double-float of ratio will work even if num or den too big.
;;  23 3/27/96 akh  require number-macros, bignum-dfloat uses with-one-negated-bignum-buffer
;;  21 3/9/96  akh  add function %floor-sub - uses fpu for two 48X32 divides
;;  20 2/19/96 akh  fix exp to return heap-consed (vs stack) result
;;  19 2/6/96  akh  see below - fixes mostly for 0 and denormalized floats
;;  17 1/28/96 Alice Hartley check type before require-type in %double-float - why bother?
;;  15 1/2/96  akh  %double-float of a ratio makes less garbage
;;  14 12/24/95 akh added fsqrt, fix bug in fixnum-decode-float
;;  13 12/22/95 gb  %int-to-dfloat already in number-macros
;;  12 12/12/95 akh define expt for integers at least, move lap macro for int-to-freg back here
;;  9 11/22/95 akh  fix %make-float-from-fixnums, add fixnum-decode-float
;;  8 11/14/95 akh  fix %copy-double-float - was brain dead
;;  7 11/13/95 akh  comment out cmuCL stuff - not needed yet
;;                  move lapmacro int-to-freg here
;;                  scale-float does denormalized too
;;                  %double-float does ratios
;;  5 11/9/95  akh  decode-float, scale-float ...
;;  4 11/7/95  akh  moved integer-decode-double-float here and made it dtrt (hopefully)
;;                  float-sign, double-float preds, etc
;;  3 11/6/95  akh  add make-float-from-fixnums - used by float reader
;;  (do not edit before this line!!)

;;;
;;; level-0;ppc;ppc-float.lisp

; Modification History
; fix short-float-ratio and double-float-ratio for case of either num or den bignum that can't be floated
; include stuff from patch fp-formats.lisp
; fix cos of complex from Adnah Kostenbauder thanks - i assume he understands trig better than I do
; ------- 5.0 final
; osx-p  really defined here from gb
; -------- 4.4b5
; remove some obsolete stuff from fsqrt
; ------- 4.4b4
; akh see disgusting re osx
;; 4.4b1
; 03/10/o1 akh get-fpu-mode fix for inexact
; 01/15/01 akh fix sqrt for NaN so no recurse ad nauseum (perhaps minusp of NaN is also wrong - is it < 0 yes is it minusp no??)
; 01/24/00 AKH fix typo in expt for short-float
; also use #_log10
; 07/26/99 akh fp-condition-from-fpscr - use common-lisp condition names
; ------- 4.3f1c1
; 07/07/99 akh log uses #_log2 when appropriate in dfloat case
; --------- 4.3b3
; 11/16/98 akh log stack-conses intermediate results in some cases, log-e of bignum conses less
; 03/25/98 akh decode-float - fix sign of significand
;-------- 4.2
; 05/03/97 akh integer-decode-double-float errors for NaN/inf and invalid-exception enabled
; 03/16/97 akh %bignum-sfloat the hard way to avoid double round, ditto %short-float of ratio
; 03/13/97 akh decode-float, scale-float, float-precision  for short, %short-float of ratio
;            add fixnum-decode-short-float, change %truncate-short-float, %short-float-zero-p gets a blr
;           from gb fsqrt, asin, acos, log, expt, atan, %fatan2  for short
; 03/12/97 akh fix %short-float-exp, add infinity-p for shorts
; 03/01/97 gb   lots of changes for SHORT-FLOATs.
; --- 4.0
;  9/17/96 slh  Alice's latest EXPT
; 08/24/96 gb   slh's fix to EXPT.
; --- 4.0b1
; akh fix float-precision for denormalized
; 04/26/96 akh %double-float for rats < 1, expt - don't do integer-power if b is float
; 04/18/96 gb    Alice's fixes to expt, %double-float-atan2!, %fixnum-dfloat, %double-float.
; 04/16/96 akh  fix  %double-float of ratio for result 0 or denorm
; 04/14/96 akh  add nan-or-infinity-p, infinity-p, comments at double-float-abs, 
;                fix log for neg x when b, also neg b
;		 expt was wrong for zero b and float zero e (3.0 too)
;		 scale-float check type of int arg
; 04/07/96 akh   double-float-abs was wrong,
;                 fix double-float of ratio to make more garbage and work more often e.g. when top and bot not floatable.
;		  some errors make floating-point conditions
;		  set-fpu-mode defaults rounding-mode to nearest - not that it matters
;		  simpler fsqrt - just turn off underflow
; 03/27/96 bill  %copy-float again takes one arg which may be a double-float or a macptr
; 03/10/96 gb    exception, FPSCR stuff; use #_sqrt (exceptions)
; 01/24/96 bill  (unless (null x) (require-type x 'double-float)) becomes
;                (require-null-or-double-float-sym x)
; 02/03/96 akh   scale-float of 0.0 is 0.0, underflow returns 0.0 as in MCL3.0
;                 %%scale-dfloat puts exp where it belongs
;                 fix integer-decode-double-float exponent value for denormalized floats
;		  fix decode-float for zero and denormalized
;                 delete redundant %set-double-exp
; 01/19/96 gb    ppc-transcendentals (double-float, no exception handling).
;                fix "sign" return in %integer-decode-double-float.
; 12/06/95 slh   use number-macros, it's checked in now

#+allow-in-package
(in-package "CCL")

(eval-when (:compile-toplevel :execute)
  (require "NUMBER-MACROS")
  (require :number-case-macro) 
  

; see "Optimizing PowerPC Code" p. 156
; Note that the constant #x4330000080000000 is now in fp-s32conv
  (defppclapmacro int-to-freg (int freg imm)
    `(let ((temp -8)
           (temp.h -8)
           (temp.l -4))
       
       (stfd ppc::fp-s32conv temp sp)
       (unbox-fixnum ,imm ,int)
       (xoris ,imm ,imm #x8000)       ; invert sign of unboxed fixnum
       (stw ,imm temp.l sp)
       (lfd ,freg temp sp)
       (fsub ,freg ,freg ppc::fp-s32conv)))
 

  (defppclapmacro 48x32-divide (x-hi16 x-lo y freg temp-freg freg2 immx)
    `(let ((temp -8)
           (temp.h -8)
           (temp.l -4)
           (zero -16)
           (zero.h -16)
           (zero.l -12))
       (lwi ,immx #x43300000)  ; 1075 = 1022+53 
       ;(lwi ,immy #x80000000)
       ;(stw ,immx temp.h sp)
       (stw ,immx zero.h sp)
       (stw rzero zero.l sp)
       (lfd ,temp-freg zero sp)
       (rlwimi ,immx ,x-hi16 0 16 31)           
       (stw ,immx temp.h sp)
       (stw ,x-lo temp.l sp)
       (lfd ,freg temp sp)
       
       (fsub ,freg ,freg ,temp-freg)
       (lwi ,immx #x43300000)
       (stw ,immx temp.h sp)
       (stw ,y temp.l sp)
       (lfd ,freg2 temp sp)
       ;(lfd ,temp-freg zero sp)
       (fsub ,freg2 ,freg2 ,temp-freg)
       (fdiv ,freg ,freg ,freg2)
       ))
 ; doesn't work - the fadd of zero doesn't normalize
 (defppclapmacro 48x32-divide2 (x-hi16 x-lo y freg temp-freg freg2 immx)
    `(let ((temp -8)
           (temp.h -8)
           (temp.l -4)
           (zero -16)
           (zero.h -16)
           (zero.l -12))
       (lwi ,immx #x43300000)  ; 1075 = 1022+53 
       ;(lwi ,immy #x80000000)
       (stw ,immx zero.h sp)
       ;(stw rzero zero.h sp)
       (stw rzero zero.l sp)
       (rlwimi ,immx ,x-hi16 0 16 31)           
       (stw ,immx temp.h sp)
       (stw ,x-lo temp.l sp)
       (lfd ,freg temp sp)
       (lfd ,temp-freg zero sp)
       (fadd ,freg ,freg ,temp-freg)
       (lwi ,immx #x43300000)
       (stw ,immx temp.h sp)
       (stw ,y temp.l sp)
       (lfd ,freg2 temp sp)
       (fadd ,freg2 ,freg2 ,temp-freg)
       (fdiv ,freg ,freg ,freg2)
       ))  
)    




#|
; just rets a fixnum (better fit) - fix divide would be faster when y1 and x1 are zero
(defppclapfunction 32x16-truncate-guess ((y1 4)(y2 0)(x1 arg_x)(x2 arg_y)(x3 arg_z))
  (rlwinm imm0 x2 14 0 15)
  (rlwimi imm0 x3 30 16 31)
  ;(lwz imm1 x1 vsp)
  (unbox-fixnum imm1 x1)  ; x-hi16
  (lwz imm2 y2 vsp)
  (rlwinm imm2 imm2 30 16 31)
  (lwz imm3 y1 vsp)
  (rlwimi imm2 imm3 14 0 15)
  (48x32-divide imm1 imm0 imm2 fp0 fp1 fp2 imm3)
  (fctiwz fp0 fp0)
  (stfd fp0 -8 sp)
  (lwz imm0 (+ -8 4) sp)
  (box-fixnum arg_z imm0)  
  (la vsp 8 vsp)
  (blr))
|#

#|
(defun %floor (ah al bh bl ch cl)
  (declare (type bignum-digit ah al bh bl ch cl))
  (let ((32x16-truncate-x  (make-array 4 :element-type '(unsigned-byte 16))))
    (declare (optimize (speed 3)(safety 0))
             (type (simple-array (unsigned-byte 16) (4)) 32x16-truncate-x)) 
    (declare (dynamic-extent 32x16-truncate-x))
    ;;
    ;; Setup *32x16-truncate-x* buffer from a and b.
    (setf (aref 32x16-truncate-x 0) ah)
    (setf (aref 32x16-truncate-x 1) al)
    (setf (aref 32x16-truncate-x 2) bh)
    (setf (aref 32x16-truncate-x 3) bl)
    (%floor-sub ch cl 32x16-truncate-x)))

; a comes from xidx in x, b comes from 1- xidx in x, y comes from yidx in y
(defppclapfunction %floor ((ah 8)(al 4)(bh 0)(bl arg_x)(yhi arg_y)(ylo arg_z))
  (let ((a imm1)
        (b imm2)
        (y imm3)
        (quo imm0))    
    (lwz a ah vsp)
    (unbox-fixnum a a)
    (lwz b al vsp)
    (rlwinm b b (- 16 ppc::fixnumshift) 0 15) ; b gets al
    (lwz imm4 bh vsp)
    (rlwimi b imm4 (- ppc::fixnumshift) 16 31) ; with bh glomed in
    (compose-digit y yhi ylo)
    (48x32-divide a b y fp0 fp1 fp2 imm4)
    (fctiwz fp0 fp0)
    (stfd fp0 -24 sp)
    (lwz quo (+ -24 4) sp) ; 16 quo bits above stuff used by 48x32
    ; now mul quo by y
    (mullw imm4 y quo)
    ; and subtract from a,b
    (subfc b imm4 b)
    ; and do it again on low 3 digits
    (rlwinm a b -16 16 31)
    (rlwinm b b 16 0 15)
    (unbox-fixnum imm4 bl)
    (or b b imm4)
    (48x32-divide a b y fp0 fp1 fp2 imm4)
    (fctiwz fp0 fp0)
    (stfd fp0 -16 sp)  ; quo lo
    ; screw - just return 2 values    
    (lwz quo (+ -24 4) sp) ; quo-hi
    (box-fixnum temp0 quo)
    (vpush temp0)
    (lwz quo (+ -16 4) sp) ; quo lo
    (box-fixnum temp0 quo)
    (vpush temp0)
    (la temp0 8 vsp)
    (set-nargs 2)
    (ba .SPvalues)))
|#

; get xidx thing from x, yidx thing from y
; if same return #xffff #xffff
; otherwise get another thing from x and 1- xidx and do as %floor of xthing otherx ything
(defppclapfunction %floor-99 ((x-stk 0)(xidx arg_x)(yptr arg_y)(yidx arg_z))
  (let ((xptr temp0)
        (a imm1)
        (b imm2)
        (y imm3)
        (quo imm0)) 
    (vpop xptr)
    (la imm4 ppc::misc-data-offset XIDX)
    (lwzx a xptr imm4)
    (la imm4 ppc::misc-data-offset YIDX)
    (lwzx y yptr imm4)
    (cmpw a y)
    (bne @more)
    (li imm4 #xffff)
    (rlwinm imm4 imm4 ppc::fixnumshift (- 16 ppc::fixnumshift) (- 31 ppc::fixnum-shift))
    (vpush imm4)
    (vpush imm4)
    (la temp0 8 vsp)
    (set-nargs 2)
    (ba .spvalues)
    @MORE
    ;  a has 16 bits from ahi, bhi gets alo blo gets bhi
    (la imm4 (- ppc::misc-data-offset 4) xidx)
    (lwzx b xptr imm4)
    (rlwinm b b 16 16 31)  ; bhi to blo 
    (rlwimi b a 16 0 15)   ; alo to bhi
    (rlwinm a a 16 16 31)  ; a gets alo 
    (48x32-divide a b y fp0 fp1 fp2 imm4)
    (fctiwz fp0 fp0)
    (stfd fp0 -24 sp)
    (lwz quo (+ -24 4) sp) ; 16 quo bits above stuff used by 48x32
    ; now mul quo by y
    (mullw imm4 y quo)
    ; and subtract from a,b
    (subfc b imm4 b)
    ; AND AGAIN
    (rlwinm a b -16 16 31) ; a gets b hi
    (rlwinm b b 16 0 15)   ; b lo to b hi
    (la imm4 (- ppc::misc-data-offset 4) xidx) 
    (lwzx imm4 imm4 xptr)
    (rlwimi b imm4 0 16 31)
    (48x32-divide a b y fp0 fp1 fp2 imm4)
    (fctiwz fp0 fp0)
    (stfd fp0 -16 sp)  ; quo lo
    (lwz quo (+ -24 4) sp) ; quo-hi
    (box-fixnum temp0 quo)
    (vpush temp0)
    (lwz quo (+ -16 4) sp) ; quo lo
    (box-fixnum temp0 quo)
    (vpush temp0)    
    (la temp0 8 vsp)
    (set-nargs 2)
    (ba .SPvalues)))
    
    
    

; for truncate-by-fixnum etal
; doesnt store quotient - just returns rem in 2 halves
(defppclapfunction %floor-loop-no-quo ((q arg_x)(yhi arg_y)(ylo arg_z))
  (let ((a imm1)
        (b imm2)
        (y imm3)
        (quo imm0)
        (qidx temp0)
        (qlen temp1))
    (lwz imm4 (- ppc::fulltag-misc) q)
    (header-length qlen imm4)
    (subi qidx qlen 4)
    (mr b rzero)
    (compose-digit y yhi ylo)
    @loop
    (rlwinm a b -16 16 31)
    (rlwinm b b 16 0 15)
    (la imm4 ppc::misc-data-offset q)
    (lwzx imm4 qidx imm4) ; q contents
    (rlwimi b imm4 16 16 31) ; hi 16 to lo b
    ;(dbg)         
    (48x32-divide a b y fp0 fp1 fp2 imm4)
    (fctiwz fp0 fp0)
    (stfd fp0 -24 sp)
    (lwz quo (+ -24 4) sp) ; 16 quo bits above stuff used by 48x32
    ; now mul quo by y
    (mullw imm4 y quo)
    ; and subtract from a,b
    (subfc b imm4 b)
    ; new a and b are low 2 digits of this (b) and last digit in array
    ; and do it again on low 3 digits
    ;(dbg)
    (rlwinm a b -16 16 31)
    (rlwinm b b 16 0 15)
    (la imm4 ppc::misc-data-offset q)
    (lwzx imm4 qidx imm4)
    (rlwimi b imm4 0 16 31)
    (48x32-divide a b y fp0 fp1 fp2 imm4)
    (fctiwz fp0 fp0)
    (stfd fp0 -16 sp)  ; quo lo
    (subi qidx qidx 4)
    (cmpwi :cr1 qidx 0)
    (lwz quo (+ -16 4) sp)
    (mullw imm4 y quo)
    (subfc b imm4 b)  ; b is remainder
    (bge :cr1 @loop)
    (digit-h temp0 b)
    (vpush temp0)
    (digit-l temp0 b)
    (vpush temp0)
    (la temp0 8 vsp)
    (set-nargs 2)
    (ba .SPvalues)))

; store result in dest, return rem in 2 halves
(defppclapfunction %floor-loop-quo ((q-stk 0)(dest arg_x)(yhi arg_y)(ylo arg_z))
  (let ((a imm1)
        (b imm2)
        (y imm3)
        (quo imm0)
        (qidx temp0)
        (qlen temp1)
        (q temp2))
    (vpop q)
    (lwz imm4 (- ppc::fulltag-misc) q)
    (header-length qlen imm4)
    (subi qidx qlen 4)
    (mr b rzero)
    (compose-digit y yhi ylo)
    @loop
    (rlwinm a b -16 16 31)
    (rlwinm b b 16 0 15)
    (la imm4 ppc::misc-data-offset q)
    (lwzx imm4 qidx imm4) ; q contents
    (rlwimi b imm4 16 16 31) ; hi 16 to lo b        
    (48x32-divide a b y fp0 fp1 fp2 imm4)
    (fctiwz fp0 fp0)
    (stfd fp0 -24 sp)
    (lwz quo (+ -24 4) sp) ; 16 quo bits above stuff used by 48x32
    ; now mul quo by y
    (mullw imm4 y quo)
    ; and subtract from a,b
    (subfc b imm4 b)
    ; new a and b are low 2 digits of this (b) and last digit in array
    ; and do it again on low 3 digits
    ;(dbg)
    (rlwinm a b -16 16 31)
    (rlwinm b b 16 0 15)
    (la imm4 ppc::misc-data-offset q)
    (lwzx imm4 qidx imm4)
    (rlwimi b imm4 0 16 31)
    (48x32-divide a b y fp0 fp1 fp2 imm4)
    (fctiwz fp0 fp0)
    (stfd fp0 -16 sp)  ; quo lo
    (lwz quo (+ -16 4) sp)
    (mullw imm4 y quo)
    (subfc b imm4 b)  ; b is remainder    
    (lwz quo (+ -24 4) sp) ; quo-hi
    (rlwinm quo quo 16 0 15)
    (lwz imm4 (+ -16 4) sp) ; quo lo
    (rlwimi quo imm4 0 16 31)    
    (la imm4 ppc::misc-data-offset dest)
    (stwx quo qidx imm4)
    (subic. qidx qidx 4)
    (bge @loop)
    (digit-h temp0 b)
    (vpush temp0)
    (digit-l temp0 b)
    (vpush temp0)
    (la temp0 8 vsp)
    (set-nargs 2)
    (ba .SPvalues)))


; used by float reader
(defun make-float-from-fixnums (hi lo exp sign &optional result)
  ;(require-null-or-double-float-sym result)
  ; maybe nuke all these require-types?
  ;(setq hi (require-type hi 'fixnum))
  ;(setq lo (require-type lo 'fixnum))
  ;(setq exp (require-type exp 'fixnum))
  ;(setq sign (require-type sign 'fixnum))
  (let ((the-float (or result (%make-dfloat))))
    (%make-float-from-fixnums the-float hi lo exp sign)
    the-float))

; make a float from hi - high 24 bits mantissa (ignore implied higher bit)
;                   lo -  low 28 bits mantissa
;                   exp  - take low 11 bits
;                   sign - sign(sign) => result
; hi result - 1 bit sign: 11 bits exp: 20 hi bits of hi arg
; lo result - 4 lo bits of hi arg: 28 lo bits of lo arg
; no error checks, no tweaks, no nuthin 

(defppclapfunction %make-float-from-fixnums ((float 4)(hi 0) (lo arg_x) (exp arg_y) (sign arg_z))
  (rlwinm imm0 sign 0 0 0)  ; just leave sign bit 
  (rlwimi imm0 exp (- 20 ppc::fixnumshift)  1 11) ;  exp left 20 right 2 keep 11 bits
  (lwz imm1 hi vsp)
  (srawi imm1 imm1 ppc::fixnumshift)   ; fold into below? nah keep for later
  (rlwimi imm0 imm1 (- 32 4) 12 31)   ; right 4 - keep  20 - stuff into hi result
  (rlwinm imm1 imm1 28 0 3)  ; hi goes left 28 - keep 4 hi bits
  (rlwimi imm1 lo (- 32 ppc::fixnumshift) 4 31) ; stuff in 28 bits of lo
  (lwz temp0 float vsp)         ; the float
  (stw imm0 ppc::double-float.value temp0)
  (stw imm1 ppc::double-float.val-low temp0)
  (la vsp 8 vsp)
  (blr))

(defppclapfunction %make-short-float-from-fixnums ((float 0) (sig arg_x) (exp arg_y) (sign arg_z))
  (unbox-fixnum imm0 sig)
  (rlwimi imm0 exp (- 29 8) 1 8)
  (inslwi imm0 sign 1 0)
  (vpop arg_z)
  (stw imm0 ppc::single-float.value arg_z)
  (blr))

(defun make-short-float-from-fixnums (significand biased-exp sign &optional result)
  (%make-short-float-from-fixnums (or result (%make-sfloat)) significand biased-exp sign))

  

(defun float-sign (n1 &optional n2) ; second arg silly
  (if (and n2 (not (typep n2 'float)))
    (setq n2 (require-type n2 'float)))
  (number-case n1
    (double-float                       
     (if (%double-float-sign n1) 
       (if n2
         (if (if (typep n2 'double-float) (%double-float-minusp n2) (%short-float-minusp n2)) n2 (- n2))
         -1.0d0)
       (if n2
         (if (if (typep n2 'double-float) (%double-float-minusp n2) (%short-float-minusp n2)) (- n2) n2)
         1.0d0)))
    (short-float
     (if (%short-float-sign n1)
       (if n2
         (if (if (typep n2 'double-float) (%double-float-minusp n2) (%short-float-minusp n2)) n2 (- n2))
         -1.0s0)
       (if n2
         (if (if (typep n2 'double-float) (%double-float-minusp n2) (%short-float-minusp n2)) (- n2) n2)
         1.0s0)))))

(defun %double-float-minusp (n)
  (and (%double-float-sign n)(not (%double-float-zerop n))))

(defun %short-float-minusp (n)
  (and (%short-float-sign n) (not (%short-float-zerop n))))

; t/nil - could as well be 1/0
(defppclapfunction %double-float-sign ((n arg_z))
  (lwz imm1 ppc::double-float.value n)
  (rlwinm. imm1 imm1 0 0 0)  ; or or.
  (setpred arg_z :cr0 :lt) 
  (blr))

(defppclapfunction %short-float-sign ((n arg_z))
  (lwz imm1 ppc::single-float.value n)
  (rlwinm. imm1 imm1 0 0 0)  ; or or.
  (setpred arg_z :cr0 :lt) 
  (blr))
 

; also in ppc-numbers using fpu - don't know which is better
; Well, this was wrong ..
; this does not (obviously) set anything in fpscr, wheras doing fcmpo with 0.0 will
; set fex & invalid-operation if n is a NAN
(defppclapfunction %double-float-zerop ((n arg_z))
  (lwz imm1 ppc::double-float.value n)
  (clrlwi imm1 imm1 1)  ; nuke sign
  (lwz imm0 ppc::double-float.val-low n)
  (or imm1 imm1 imm0 )
  (eq0->boolean arg_z imm1 imm0)
  (blr))

(defppclapfunction %short-float-zerop ((n arg_z))
  (lwz imm1 ppc::single-float.value n)
  (clrlwi imm1 imm1 1)
  (eq0->boolean arg_z imm1 imm0)
  (blr))
    
(defun %double-float-abs (n)
  (if (not (%double-float-sign n))
    n 
    (%%double-float-abs n (%make-dfloat))))

(defun %short-float-abs (n)
  (if (not (%short-float-sign n))
    n 
    (%%short-float-abs n (%make-sfloat))))


; this is also wrong - it doesn't check for invalid-operation
; same is true for double-float-negate
(defppclapfunction %%double-float-abs ((n arg_y)(val arg_z))
  (get-double-float fp1 n)
  (fabs fp1 fp1)
  (put-double-float fp1 val)
  (blr))

; Likewise.
(defppclapfunction %%short-float-abs ((n arg_y) (val arg_z))
  (get-single-float fp1 n)
  (fabs fp0 fp1)
  (put-single-float fp0 val)
  (blr))

#|

(defppclapfunction x%%double-float-abs ((n arg_y)(val arg_z))
  (lfd fp1 ppc::double-float.value n)
  (fabs fp1 fp1)
  (stfd fp1 ppc::double-float.value val)
  (bgt cr1 @bad)  ; what do we check here? - also gotta clear it/them first
  (blr)
  @bad
  (save-lisp-context)
  (set-nargs 2)
  (mr arg_z arg_y)
  (lwz arg_y 'abs fn)
  (call-symbol %df-check-exception-1)
  (blr))
|#


; rets hi (25 bits) lo (28 bits) exp sign
(defppclapfunction %integer-decode-double-float ((n arg_z))
  (lwz imm0  ppc::double-float.value n)
  (rlwinm imm1 imm0 (+ 1 ppc::fixnumshift) (- 32 ppc::fixnumshift 1) ; sign boxed
          				   (- 32 ppc::fixnumshift 1))
  (add imm1 imm1 imm1)  ; imm1 = (fixnum 2) (neg) or 0 (pos)
  (subfic temp0 imm1 '1)  ; sign boxed
  (rlwinm. imm2 imm0 (- 32 20)  21  31)   ; right 20, keep 11 bits exp - test for 0
  ;(subi imm2 imm2 (+ 53 1022))            ; unbias and scale
  (slwi imm2 imm2 ppc::fixnumshift)      ; box
  (mr temp1 imm2)                        ; boxed unbiased exponent
  (rlwinm imm0 imm0 12  0 19)            ; 20 bits of hi float left 12
  (beq @denorm)                          ; cr set way back
  (addi imm0 imm0 1)                     ;  add implied 1
  @denorm
  (rlwinm imm0 imm0 (+ (- 32 12) 4 ppc::fixnumshift) 0 31)
  (lwz imm1 ppc::double-float.val-low n) ; 
  (rlwimi imm0 imm1 (+ 4 ppc::fixnumshift)
                    (1+ (- 31 4 ppc::fixnumshift))
                    (- 31 ppc::fixnumshift))  ; high 4 bits in fixnum pos
  (rlwinm imm1 imm1 (- 4 ppc::fixnumshift) 
                    (- 4 ppc::fixnumshift)
                    (- 31 ppc::fixnum-shift)) ; 28 bits  thats 2 2 29
  (vpush imm0)   ; hi 25 bits of mantissa (includes implied 1)
  (vpush imm1)   ; lo 28 bits of mantissa
  (vpush temp1)  ; exp
  (vpush temp0)  ; sign
  (set-nargs 4)
  (la temp0 16 vsp)
  (ba .SPvalues))

(defun fixnum-decode-float (n)
  (etypecase n
    (double-float (%integer-decode-double-float n))))

(defun nan-or-infinity-p (n)
  (etypecase n
    (double-float (eq 2047 (%double-float-exp n)))
    (short-float (eq 255 (%short-float-exp n)))))

; not sure this is right
(defun infinity-p (n)
  (etypecase n
    (double-float (multiple-value-bind (hi lo exp)(fixnum-decode-float n)
                    (and (eq 2047 exp)
                         (eq #x1000000 hi)
                         (eq 0 lo))))
    (short-float (multiple-value-bind (high low)(%sfloat-hwords n)
                  (let*  ((mantissa (%ilogior2 low (%ilsl 16 (%ilogand2 high #x007F))))
                          (exp (%ilsr 7 (%ilogand2 high #x7F80))))
                    (and (eq exp 255)
                         (eq 0 mantissa)))))))

(defun fixnum-decode-short-float (float)
  (multiple-value-bind (high low)(%sfloat-hwords float)
    (let*  ((mantissa (%ilogior2 low (%ilsl 16 (%ilogand2 high #x007F))))
            (exp (%ilsr 7 (%ilogand2 high #x7F80))))
      (if (and (neq exp 0)#|(neq exp 255)|#)(setq mantissa (%ilogior mantissa #x800000))) ; ???
      (values mantissa exp (%ilsr 15 high)))))
  
                   
                      

(defun integer-decode-double-float (n)
  (multiple-value-bind (hi lo exp sign)(%integer-decode-double-float n)
    (if (eq exp 2047)
      (let ((flags (%get-fpscr-control)))
        (if (logbitp (- 31 ppc::fpscr-ve-bit) flags)
          (error (make-condition 'floating-point-invalid-operation :operation 'integer-decode-float
                                 :operands (list n))))))
    ; is only 53 bits and positive so should be easy
    ;(values (logior (ash hi 28) lo) exp sign)))
    ; if denormalized, may fit in a fixnum
    (setq exp (- exp (if (< hi #x1000000) 
                       (+ IEEE-double-float-mantissa-width IEEE-double-float-bias)
                       (+ IEEE-double-float-mantissa-width (1+ IEEE-double-float-bias)))))
    (if (< hi (ash 1 (1- ppc::fixnumshift))) ; aka 2
      (values (logior (ash hi 28) lo) exp sign)
      ; might fit in 1 word?
      (let ((big (%alloc-misc 2 ppc::subtag-bignum)))
        (make-big-53 hi lo big)
        (if (< hi #x1000000) (%normalize-bignum big))
        (values big exp sign)))))

;; actually only called when magnitude bigger than a fixnum
(defun %truncate-double-float (n)
  (multiple-value-bind (hi lo exp sign)(%integer-decode-double-float n)
    (if (< exp (1+ IEEE-double-float-bias)) ; this is false in practice
      0
      (progn
        (setq exp (- exp (+ IEEE-double-float-mantissa-width (1+ IEEE-double-float-bias))))
        (if (eq sign 1)  ; positive
          (logior (ash hi (+ 28 exp))(ash lo exp))
          (if (<= exp 0) ; exp positive - negate before shift - else after
            (let ((poo (logior (ash hi (+ 28 exp))(ash lo exp))))
              (- poo))
            (let ((poo (logior (ash hi 28) lo)))
              (ash (- poo) exp))))))))

; actually only called when bigger than a fixnum
(defun %truncate-short-float (n)
  (multiple-value-bind (mantissa exp sign)(fixnum-decode-short-float n)
    (if (< exp (1+ IEEE-single-float-bias)) ; is magnitude less than 1 - false in practice
      0
      (progn
        (setq exp (- exp (+ IEEE-single-float-mantissa-width (1+ IEEE-single-float-bias))))
        (ash (if (eq sign 0) mantissa (- mantissa)) exp)))))


; hi is 25 bits lo is 28 bits
; big is 32 lo, 21 hi right justified
(defppclapfunction make-big-53 ((hi arg_x)(lo arg_y)(big arg_z))
  (rlwinm imm0 lo (- 32 ppc::fixnumshift) 4 31)
  (rlwimi imm0 hi (- 32 4 ppc::fixnumshift) 0 3)
  (stw imm0 (+ ppc::misc-data-offset 0) big)   ; low goes in 1st wd
  (rlwinm imm0 hi (- 32 (+ ppc::fixnumshift 4)) 11 31)  ; high in second
  (stw imm0 (+ ppc::misc-data-offset 4) big)
  (blr))


(defun decode-float (n)
  (number-case n
    (double-float
     (let* ((old-exp (%double-float-exp n))
            (sign (if (%double-float-sign n) -1.0d0 1.0d0)))    
       (if (eq 0 old-exp)
         (if  (%double-float-zerop n)
           (values 0.0d0 0 sign)
           (let* ((val (%make-dfloat))
                  (zeros (dfloat-significand-zeros n)))
             (%%double-float-abs n val)
             (%%scale-dfloat val (+ 2 IEEE-double-float-bias zeros) val) ; get it normalized
             (set-%double-float-exp val IEEE-double-float-bias)      ; then bash exponent
             (values val (- old-exp zeros IEEE-double-float-bias) sign )))
         (if (> old-exp 2046)
           (error "Can't decode NAN or infinity ~s" n)
           (let ((val (%make-dfloat)))
             (%%double-float-abs n val)
             (set-%double-float-exp val IEEE-double-float-bias)
             (values val (- old-exp IEEE-double-float-bias) sign))))))
    (short-float
     (let* ((old-exp (%short-float-exp n))
            (sign (if (%short-float-sign n) -1.0s0 1.0s0)))
       (if (eq 0 old-exp)
         (if  (%short-float-zerop n)
           (values 0.0s0 0 sign)
           (let* ((val (%make-sfloat))
                  (zeros (sfloat-significand-zeros n)))
             (%%short-float-abs n val)
             (%%scale-sfloat val (+ 2 IEEE-single-float-bias zeros) val) ; get it normalized
             (set-%short-float-exp val IEEE-single-float-bias)      ; then bash exponent
             (values val (- old-exp zeros IEEE-single-float-bias) sign )))
         (if (> old-exp IEEE-single-float-normal-exponent-max)
           (error "Can't decode NAN or infinity ~s" n)
           (let ((val (%make-sfloat)))
             (%%short-float-abs n val)
             (set-%short-float-exp val IEEE-single-float-bias)
             (values val (- old-exp IEEE-single-float-bias) sign)))))
     )))


(defppclapfunction dfloat-significand-zeros ((dfloat arg_z))
  (lwz imm1 ppc::double-float.value dfloat)
  (rlwinm. imm1 imm1 12 0 19)
  (cntlzw imm1 imm1)
  (beq @golo)
  (box-fixnum arg_z imm1)
  (blr)
  @golo
  (lwz imm1 ppc::double-float.val-low dfloat)
  (cntlzw imm1 imm1)
  (addi imm1 imm1 20)
  (box-fixnum arg_z imm1)
  (blr))

(defppclapfunction sfloat-significand-zeros ((sfloat arg_z))
  (lwz imm1 ppc::single-float.value sfloat)
  (rlwinm imm1 imm1 9 0 22)
  (cntlzw imm1 imm1)
  (box-fixnum arg_z imm1)
  (blr))


; (* float (expt 2 int))
(defun scale-float (float int)  
  (unless (fixnump int)(setq int (require-type int 'fixnum)))
  (number-case float
    (double-float
     (let* ((float-exp (%double-float-exp float))
            (new-exp (+ float-exp int)))
       (if (eq 0 float-exp) ; already denormalized?
         (if (%double-float-zerop float)
           float 
           (let ((result (%make-dfloat)))
             (%%scale-dfloat float (+ (1+ IEEE-double-float-bias) int) result)))
         (if (<= new-exp 0)  ; maybe going denormalized        
           (if (<= new-exp (- IEEE-double-float-digits))
             0.0d0 ; should this be underflow? - should just be normal and result is fn of current fpu-mode
             ;(error "Can't scale ~s by ~s." float int) ; should signal something                      
             (let ((result (%make-dfloat)))
               (%copy-double-float float result)
               (set-%double-float-exp result 1) ; scale by float-exp -1
               (%%scale-dfloat result (+ IEEE-double-float-bias (+ float-exp int)) result)              
               result))
           (if (> new-exp IEEE-double-float-normal-exponent-max) 
             (error (make-condition 'floating-point-overflow
                                    :operation 'scale-float
                                    :operands (list float int)))
             (let ((new-float (%make-dfloat)))
               (%copy-double-float float new-float)
               (set-%double-float-exp new-float new-exp)
               new-float))))))
    (short-float
     (let* ((float-exp (%short-float-exp float))
            (new-exp (+ float-exp int)))
       (if (eq 0 float-exp) ; already denormalized?
         (if (%short-float-zerop float)
           float 
           (let ((result (%make-sfloat)))
             (%%scale-sfloat float (+ (1+ IEEE-single-float-bias) int) result)))
         (if (<= new-exp 0)  ; maybe going denormalized        
           (if (<= new-exp (- IEEE-single-float-digits)) 
             0.0s0 ; should this be underflow? - should just be normal and result is fn of current fpu-mode
             ;(error "Can't scale ~s by ~s." float int) ; should signal something                      
             (let ((result (%make-sfloat)))
               (%copy-short-float float result)
               (set-%short-float-exp result 1) ; scale by float-exp -1
               (%%scale-sfloat result (+ IEEE-single-float-bias (+ float-exp int)) result)              
               result))
           (if (> new-exp IEEE-single-float-normal-exponent-max) 
             (error (make-condition 'floating-point-overflow
                                    :operation 'scale-float
                                    :operands (list float int)))
             (let ((new-float (%make-sfloat)))
               (%copy-short-float float new-float)
               (set-%short-float-exp new-float new-exp)
               new-float))))))))

#|
 (make-float-from-fixnums 0 1 0 0)
5.0E-324
? (scale-float 1.5 -1022)
3.337610787760802E-308
? (scale-float 1.5 -1023)
1.668805393880401E-308
? (scale-float 1.5 -1055)
3.88549E-318
? (scale-float 1.5 -1070)
1.2E-322
? (scale-float 1.5 1000)
1.607262910779401E+301
|#


(defppclapfunction %%scale-dfloat ((float arg_x)(int arg_y)(result arg_z))
  (let ((fl.h -8)
        (fl.l -4)
        (sc.h -16)
        (sc.l -12))
    (clear-fpu-exceptions)
    (lwz imm0 ppc::double-float.value float)
    (lwz imm1 ppc::double-float.val-low float)
    (stw imm0 fl.h sp)
    (stw imm1 fl.l sp)
    (unbox-fixnum imm0 int)
    ;(addi imm0 imm0 1022)  ; bias exponent - we assume no ovf
    (slwi imm0 imm0 20)     ; more important - get it in right place
    (stw imm0 sc.h sp)
    (stw rzero sc.l sp)
    (lfd fp0 fl.h sp)
    (lfd fp1 sc.h sp)
    (fp-check-binop-exception (fmul. fp2 fp0 fp1))
    (stfd fp2 ppc::double-float.value result)
    (blr)))

(defppclapfunction %%scale-sfloat ((float arg_x)(int arg_y)(result arg_z))
  (let ((sc.h -4))
    (clear-fpu-exceptions)
    (lfs fp0 ppc::single-float.value float)
    (unbox-fixnum imm0 int)
    (slwi imm0 imm0 IEEE-single-float-mantissa-width)
    (stw imm0 sc.h sp)
    (lfs fp1 sc.h sp)
    (fp-check-binop-exception (fmuls. fp2 fp0 fp1))
    (stfs fp2 ppc::single-float.value result)
    (blr)))
                   

(defun %copy-float (f)
  ;Returns a freshly consed float.  float can also be a macptr.
  (cond ((double-float-p f) (%copy-double-float f (%make-dfloat)))
        ((macptrp f)
         (let ((float (%make-dfloat)))
           (%copy-ptr-to-ivector f 0 float (* 4 ppc::double-float.value-cell) 8)
           float))
        (t (error "Ilegal arg ~s to %copy-float" f))))


(defppclapfunction %copy-double-float ((f1 arg_y) (f2 arg_z))
  (lfd fp0 ppc::double-float.value f1)
  (stfd fp0 ppc::double-float.value f2)
  (blr))
                   

(defppclapfunction %copy-short-float ((f1 arg_y) (f2 arg_z))
  (lfs fp0 ppc::single-float.value f1)
  (stfs fp0 ppc::single-float.value f2)
  (blr))

(defppclapfunction %double-float-exp ((n arg_z))
  (lwz imm1 ppc::double-float.value n)
  (rlwinm arg_z imm1 (- 32 (- 20 ppc::fixnumshift)) 19  29) ; right 20 left 2 = right 18 = left 14
  (blr))

(defppclapfunction set-%double-float-exp ((float arg_y) (exp arg_z))
  (lwz imm1 ppc::double-float.value float)
  (rlwimi imm1 exp (- 20 ppc::fixnumshift) 1 11)
  (stw imm1 ppc::double-float.value float) ; hdr - tag = 8 - 2
  (blr))


(defppclapfunction %short-float-exp ((n arg_z))
  (lwz imm1 ppc::single-float.value n)
  (rlwinm arg_z imm1 (- 32 (- 23 ppc::fixnumshift)) 22 29)
  (blr))

(defppclapfunction set-%short-float-exp ((float arg_y) (exp arg_z))
  (lwz imm1 ppc::single-float.value float)
  (rlwimi imm1 exp (- 23 ppc::fixnumshift) 1 8)
  (stw imm1 ppc::single-float.value float)
  (blr))

  
(defppclapfunction %short-float->double-float ((src arg_y) (result arg_z))
  (get-single-float fp0 src)
  (put-double-float fp0 result)
  (blr))

(defppclapfunction %double-float->short-float ((src arg_y) (result arg_z))
  (clear-fpu-exceptions)
  (get-double-float fp0 src)
  (fp-check-unaryop-exception (frsp. fp1 fp0))
  (put-single-float fp1 result)
  (blr))
  
(defun float-precision (float)     ; not used - not in cltl2 index ? 
  (number-case float
     (double-float
      (if (eq 0 (%double-float-exp float))
        (if (not (%double-float-zerop float))
        ; denormalized
          (- IEEE-double-float-mantissa-width (dfloat-significand-zeros float))
          0)
        IEEE-double-float-digits))
     (short-float 
      (if (eq 0 (%short-float-exp float))
        (if (not (%short-float-zerop float))
        ; denormalized
          (- IEEE-single-float-mantissa-width (sfloat-significand-zeros float))
          0)
        IEEE-single-float-digits))))

(defun %double-float (number &optional result)
  ;(require-null-or-double-float-sym result)
  ; use number-case when macro is common
  (number-case number
    (double-float
     (if result 
       (%copy-double-float number result)
         number))
    (short-float
     (%short-float->double-float number (or result (%make-dfloat))))
    (fixnum
     (%fixnum-dfloat number (or result (%make-dfloat))))
    (bignum (%bignum-dfloat number result))
    (ratio 
     (if (not result)(setq result (%make-dfloat)))
     (let* ((num (%numerator number))
            (den (%denominator number)))
       ; dont error if result is floatable when either top or bottom is not.
       ; maybe do usual first, catching error
       (if (not (or (bignump num)(bignump den)))
         (with-ppc-stack-double-floats ((fnum num)
                                        (fden den))       
             (%double-float/-2! fnum fden result))
         (let* ((numlen (integer-length num))
                (denlen (integer-length den))
                (exp (- numlen denlen))
                (minusp (minusp num)))
           (if (and (<= numlen IEEE-double-float-bias)
                    (<= denlen IEEE-double-float-bias)
                    #|(not (minusp exp))|# 
                    (<= (abs exp) IEEE-double-float-mantissa-width))
             (with-ppc-stack-double-floats ((fnum num)
                                            (fden den))
       
               (%double-float/-2! fnum fden result))
             (if (> exp IEEE-double-float-mantissa-width)
               (progn  (%double-float (round num den) result))               
               (if (>= exp 0)
                 ; exp between 0 and 53 and nums big
                 (let* ((shift (- IEEE-double-float-digits exp))
                        (num (if minusp (- num) num))
                        (int (round (ash num shift) den)) ; gaak
                        (intlen (integer-length int))
                        (new-exp (+ intlen (- IEEE-double-float-bias shift))))
                   
                   (when (> intlen IEEE-double-float-digits)
                     (setq shift (1- shift))
                     (setq int (round (ash num shift) den))
                     (setq intlen (integer-length int))
                     (setq new-exp (+ intlen (- IEEE-double-float-bias shift))))
                   (when (> new-exp 2046)
                     (error (make-condition 'floating-point-overflow
                                            :operation 'double-float
                                            :operands (list number))))
                   ;(print (list 'horse int minusp shift intlen new-exp))
                   (if nil ;(fixnump int)
                     (%double-float (if minusp (- int) int)  result) 
                     (make-float-from-fixnums (ldb (byte 25 (- intlen 25)) int)
                                              (ldb (byte 28 (max (- intlen 53) 0)) int)
                                              new-exp ;(+ intlen (- IEEE-double-float-bias 53))
                                              (if minusp -1 1)
                                              result)))
                 ; den > num - exp negative
                 (progn  
                   (float-rat-neg-exp num den (if minusp -1 1) result)))))))))))

(defun %short-float-ratio (number &optional result)
  (if (not result)(setq result (%make-sfloat)))
  (let* ((num (%numerator number))
         (den (%denominator number)))
    ; dont error if result is floatable when either top or bottom is not.
    ; maybe do usual first, catching error
    (if (not (or (bignump num)(bignump den)))
      (with-ppc-stack-short-floats ((fnum num)
                                    (fden den))       
        (%short-float/-2! fnum fden result))
      (let* ((numlen (integer-length num))
             (denlen (integer-length den))
             (exp (- numlen denlen))
             (minusp (minusp num)))
        (if (and (<= numlen IEEE-single-float-bias)
                 (<= denlen IEEE-single-float-bias)
                 #|(not (minusp exp))|# 
                 (<= (abs exp) IEEE-single-float-mantissa-width))
          (with-ppc-stack-short-floats ((fnum num)
                                        (fden den))
            
            (%short-float/-2! fnum fden result))
          (if (> exp IEEE-single-float-mantissa-width)
            (progn  (%short-float (round num den) result))               
            (if (>= exp 0)
              ; exp between 0 and 53 and nums big
              (let* ((shift (- IEEE-single-float-digits exp))
                     (num (if minusp (- num) num))
                     (int (round (ash num shift) den)) ; gaak
                     (intlen (integer-length int))
                     (new-exp (+ intlen (- IEEE-single-float-bias shift))))
                
                (when (> intlen IEEE-single-float-digits)
                  (setq shift (1- shift))
                  (setq int (round (ash num shift) den))
                  (setq intlen (integer-length int))
                  (setq new-exp (+ intlen (- IEEE-single-float-bias shift))))
                (when (> new-exp IEEE-single-float-normal-exponent-max)
                  (error (make-condition 'floating-point-overflow
                                         :operation 'short-float
                                         :operands (list number))))
                ;(print (list 'horse int minusp shift intlen new-exp))
                (if nil ; (fixnump int) < bad bad
                  (%short-float (if minusp (- int) int)  result)
                  (make-short-float-from-fixnums 
                   (ldb (byte IEEE-single-float-digits  (- intlen  IEEE-single-float-digits)) int)
                   new-exp
                   (if minusp -1 1)
                   result)))
              ; den > num - exp negative
              (progn  
                (float-rat-neg-exp num den (if minusp -1 1) result t)))))))))

(defun %short-float (number &optional result)
  (number-case number
    (short-float
     (if result (%copy-short-float number result) number))
    (double-float
     (%double-float->short-float number (or result (%make-sfloat))))
    (fixnum
     (%fixnum-sfloat number (or result (%make-sfloat))))
    (bignum
     (%bignum-sfloat number (or result (%make-sfloat))))
    (ratio
     (%short-float-ratio number result))))
#|
     (with-ppc-stack-double-floats
       ((df))
       (%double-float number df)  ; this is a bad thing cause it may round twice
       (%double-float->short-float df (or result (%make-sfloat)))))))
|#

(defun float-rat-neg-exp (integer divisor sign &optional result short)
  (if (minusp sign)(setq integer (- integer)))       
  (let* ((integer-length (integer-length integer))
         ;; make sure we will have enough bits in the quotient
         ;; (and a couple extra for rounding)
         (shift-factor (+ (- (integer-length divisor) integer-length) (if short 28 60))) ; fix
         (scaled-integer integer))
    (if (plusp shift-factor)
      (setq scaled-integer (ash integer shift-factor))
      (setq divisor (ash divisor (- shift-factor)))  ; assume div > num
      )
    ;(pprint (list shift-factor scaled-integer divisor))
    (multiple-value-bind (quotient remainder)(floor scaled-integer divisor)
      (unless (zerop remainder) ; whats this - tells us there's junk below
        (setq quotient (logior quotient 1)))
      ; why do it return 2 values?
      (values (float-and-scale-and-round sign quotient (- shift-factor)  short result)))))

      


#| ; unused
(defppclapfunction %move-big-digit ((from arg_x)(to arg_y)(idx arg_z))
  (unbox-fixnum imm0 arg_z)
  (la imm0 ppc::misc-data-offset imm0)
  (lwzx imm1 from imm0)
  (stwx imm1 to imm0)
  (blr))
|#



#| ; dummies
(defun bignum-integer-length (b)(integer-length b))
(defun bignum-minusp (b)(minusp b))
(defun negate-bignum (b)(- b))
|#
;; when is (negate-bignum (bignum-ashift-right big)) ; can't negate in place cause may get bigger
;; cheaper than (negate-bignum big) - 6 0r 8 digits ; 8 longs so win if digits > 7
;; or negate it on the stack

(defun %bignum-dfloat (big &optional result)  
  (let* ((minusp (bignum-minusp big)))
    (flet 
      ((doit (new-big)
         (let* ((int-len (bignum-integer-length new-big)))
           (when (>= int-len (- 2047 IEEE-double-float-bias)) ; args?
             (error (make-condition 'floating-point-overflow 
                                    :operation 'float :operands (list big))))
           (if (> int-len 53)
             (let* ((hi (ldb (byte 25  (- int-len  25)) new-big))
                    (lo (ldb (byte 28 (- int-len 53)) new-big)))
               ;(print (list new-big hi lo))
               (when (and (logbitp (- int-len 54) new-big)  ; round bit
                          (or (%ilogbitp 0 lo)    ; oddp
                              ; or more bits below round
                              (%i< (one-bignum-factor-of-two new-big) (- int-len 54))))
                 (if (eq lo #xfffffff)
                   (setq hi (1+ hi) lo 0)
                   (setq lo (1+ lo)))
                 (when (%ilogbitp 25 hi) ; got bigger
                   (setq int-len (1+ int-len))
                   (let ((bit (%ilogbitp 0 hi)))
                     (setq hi (%ilsr 1 hi))
                     (setq lo (%ilsr 1 lo))
                     (if bit (setq lo (%ilogior #x8000000 lo))))))
               (make-float-from-fixnums hi lo (+ IEEE-double-float-bias int-len)(if minusp -1 1) result))
             (let* ((hi (ldb (byte 25  (- int-len  25)) new-big))
                    (lobits (min (- int-len 25) 28))
                    (lo (ldb (byte lobits (- int-len (+ lobits 25))) new-big)))
               (if (< lobits 28) (setq lo (ash lo (- 28 lobits))))
               (make-float-from-fixnums hi lo (+ IEEE-double-float-bias int-len) (if minusp -1 1) result))))))
      (declare (dynamic-extent #'doit))
      (with-one-negated-bignum-buffer big doit))))

(defun %bignum-sfloat (big &optional result)  
  (let* ((minusp (bignum-minusp big)))
    (flet 
      ((doit (new-big)
         (let* ((int-len (bignum-integer-length new-big)))
           (when (>= int-len (- 255 IEEE-single-float-bias)) ; args?
             (error (make-condition 'floating-point-overflow 
                                    :operation 'float :operands (list big 1.0s0))))
           (if t ;(> int-len IEEE-single-float-digits) ; always true
             (let* ((lo (ldb (byte IEEE-single-float-digits  (- int-len  IEEE-single-float-digits)) new-big)))
               (when (and (logbitp (- int-len 25) new-big)  ; round bit
                          (or (%ilogbitp 0 lo)    ; oddp
                              ; or more bits below round
                              (%i< (one-bignum-factor-of-two new-big) (- int-len 25))))
                 (setq lo (1+ lo))
                 (when (%ilogbitp 24 lo) ; got bigger
                   (setq int-len (1+ int-len))
                   (setq lo (%ilsr 1 lo))))
               (make-short-float-from-fixnums  lo (+ IEEE-single-float-bias int-len)(if minusp -1 1) result))
             ))))
      (declare (dynamic-extent #'doit))
      (with-one-negated-bignum-buffer big doit))))

#|
;; This should probably try to trap the short-float overflow, and hide
;; the temporary double-float from the error message.
(defun %bignum-sfloat (big &optional result)
  (with-ppc-stack-double-floats ((d))
    (%bignum-dfloat big d) ; bad because may round twice
    (%short-float d result)))
|#

#|
(defun %bignum-dfloat-inverse (big &optional (result (%make-dfloat)))
  ; big is really big - somewhere between (rational most-positive-df) and (denominator (rationalize least-positive-df))
  ; doesn't round right but I dont care.
  ; also makes lots of garbage and I dont care about that either.
  (let* ((minusp (bignum-minusp big)))
    (flet 
      ((doit (new-big)
         (let* ((int-len (integer-length new-big)))
           (when (> new-big #.(denominator (rationalize least-positive-double-float)))
             (error (make-condition 'floating-point-overflow 
                                    :operation '%bignum-dfloat-inverse :operands (list big))))
           (let ((frob (ash new-big -53)))
             (if (logbitp (- int-len 54) new-big)(setq frob (1+ frob)))
             (%double-float/-2! (if minusp -1.0d0 1.0d0) (%double-float frob result) result)
             (scale-float result -53)))))
      (declare (dynamic-extent doit))
      (with-one-negated-bignum-buffer big doit))))
|#

;; also in l1-events
(defppclapfunction fix-fpr31 ()
  (lwi imm0 #x43300000)  ;; dont know whether this is clobbered too, be paranoid - paranoia reigns - tis clobbered
  (stw imm0  -8 sp)
  (lwi imm0  #x80000000)
  (stw imm0 -4 sp)
  (lfd ppc::fp-s32conv -8 sp)
  (lwi imm0 0)
  (stw imm0 -4 sp)
  (lfs ppc::fp-zero -4 sp)
  (blr)
  )


(defppclapfunction osx-p ()
  (ref-global imm0 appmain)
  (cntlzw imm0 imm0)
  (srwi imm0 imm0 5)
  (xori imm0 imm0 1)
  (rlwimi imm0 imm0 4 27 27)
  (add arg_z rnil imm0)
  (blr))


(defun %fixnum-dfloat (fix &optional result)  
  (if (eq 0 fix) 
    (if result (%copy-double-float 0.0d0 result) 0.0d0)
    (progn
      (when (not result)(setq result (%make-dfloat)))
      ; it better return result      
      (if nil ;(osx-p)
        (without-interrupts 
         (fix-fpr31)  ;; actually fix fpr30 - disgusting 
         (%int-to-dfloat fix result))
        (%int-to-dfloat fix result)))))

(defun %fixnum-sfloat (fix &optional result)
  (if (eq 0 fix)
    (if result (%copy-short-float 0.0s0 result) 0.0s0)
    (progn
      (when (not result)(setq result (%make-sfloat))) 
      (if nil ;(osx-p)
        (without-interrupts
         (fix-fpr31)  ;; see above
         (%int-to-sfloat fix result))        
        (%int-to-sfloat fix result)))))


(defppclapfunction %int-to-sfloat ((int arg_y) (sfloat arg_z))
  (int-to-freg int fp0 imm0)
  (stfs fp0 ppc::single-float.value sfloat)
  (blr))

(defppclapfunction %int-to-dfloat ((int arg_y) (dfloat arg_z))
  (int-to-freg int fp0 imm0)
  (stfd fp0 ppc::double-float.value dfloat)
  (blr))

;;; Transcendental functions.

(defun sin (x)
  (if (complexp x)
    (let* ((r (%make-dfloat))
           (i (%make-dfloat)))
      (declare (dynamic-extent r i))
      (%double-float (realpart x) r)
      (%double-float (imagpart x) i)
      (complex (* (sin r) (cosh i))
               (* (cos r) (sinh i))))
    (if (typep x 'short-float)
      (with-ppc-stack-double-floats ((dx x)
                                     (dres))
        (%short-float (%double-float-sin! dx dres) (%make-sfloat)))
      (let* ((x1 (%make-dfloat)))
        (declare (dynamic-extent x1))      
        (%double-float-sin! (%double-float x x1) (%make-dfloat))))))

(defun cos (x)
  (if (complexp x)
    (let* ((r (%make-dfloat))
           (i (%make-dfloat)))
      (declare (dynamic-extent r i))
      (%double-float (realpart x) r)
      (%double-float (imagpart x) i)
      (complex (* (cos r) (cosh i))
               (- (* (sin r) (sinh i)))))
    (if (typep x 'short-float)
      (with-ppc-stack-double-floats ((dx x)
                                     (dres))
        (%short-float (%double-float-cos! dx dres) (%make-sfloat)))
      (let* ((x1 (%make-dfloat)))
        (declare (dynamic-extent x1))      
        (%double-float-cos! (%double-float x x1) (%make-dfloat))))))

(defun tan (x)
  (if (complexp x)
    (/ (sin x) (cos x))
    (if (typep x 'short-float) 
      (with-ppc-stack-double-floats ((dx x)
                                     (dres))
        (%short-float (%double-float-tan! dx dres) (%make-sfloat)))
      (let* ((x1 (%make-dfloat)))
        (declare (dynamic-extent x1))
        (%double-float-tan! (%double-float x x1) (%make-dfloat))))))



(defun atan (y &optional (x nil x-p))
  (let* ((sf-y (typep y 'short-float))
         (rat-y (typep y 'rational)))
    (if x-p
      (let* ((sf-x (typep x 'short-float))
             (rat-x (typep x 'rational)))
        (with-ppc-stack-double-floats ((dy y)
                                       (dx x))
          (if (or (and sf-y (or sf-x rat-x))
                  (and sf-x rat-y))
            (with-ppc-stack-double-floats ((dres))
              (%fatan2 dy dx dres)
              (%double-float->short-float dres (%make-sfloat)))
            (%fatan2 dy dx (%make-dfloat)))))
      (if (typep y 'complex)
        (let* ((iy (* (sqrt -1) y)))
             (/ (- (log (+ 1 iy)) (log (- 1 iy)))
                #c(0 2)))
        (with-ppc-stack-double-floats ((dy y))
          (if sf-y
            (with-ppc-stack-double-floats ((dres))
              (%double-float-atan! dy dres)
              (%double-float->short-float dres (%make-sfloat)))
            (%double-float-atan! dy (%make-dfloat))))))))

#|
(defun log (x &optional (b nil b-p))
  (if b-p
    (if (zerop b)
      (if (zerop x)
        (report-bad-arg x '(not (satisfies zerop) ))
        (if (floatp x) (float 0.0d0 x) 0))
      (/ (log-e x) (log-e b)))
    (log-e x)))
|#



(defun log (x &optional (b nil b-p))
  (if b-p
    (if (zerop b)
      (if (zerop x)
        (report-bad-arg x '(not (satisfies zerop) ))
        (if (floatp x) (float 0.0d0 x) 0))
      (if (and (or (fixnump x)(double-float-p x))
               (or (fixnump b)(double-float-p b)))
        (if (and (= b 2)(not (minusp x)))
          (with-ppc-stack-double-floats ((xx x))
            (%double-float-log2! xx (%make-dfloat)))
          (if (and (= b 10)(not (minusp x)))
            (with-ppc-stack-double-floats ((xx x))
              (%double-float-log10! xx (%make-dfloat)))            
            (with-ppc-stack-double-floats ((xres)(bres))
              (/ (log-e-to-res x xres)(log-e-to-res b bres)))))
        (if (and (or (short-float-p x) (fixnump x))
                 (or (short-float-p b) (Fixnump b)))
          (with-ppc-stack-double-floats  ((xres) (bres))
            (let ((xx (log-e-to-res x xres))
                  (bb (log-e-to-res b bres)))
              (if (and (eq xx xres)(eq bb bres))
                (progn 
                  (%double-float/-2! xx bb xres)
                  (coerce xres 'short-float))
                (/ xx bb))))
          (/ (log-e x)(log-e b)))))
    (log-e x)))

;; x is fixnum "small" bignum or dfloat
(defun log-e-to-res (x result)
  (with-ppc-stack-double-floats ((dx x))
    (if (minusp x)
      (complex (%double-float-log! (%%double-float-abs dx dx) (or result (%make-dfloat))) pi)
      (%double-float-log! dx (or result (%make-dfloat))))))

(defun log-e (x)
  (cond 
   ((bignump x)
    (if (minusp x)
      (complex (log-e (- x)) pi)
      (if (>= (integer-length x) #.(integer-length (truncate most-positive-double-float)))
        #+ignore
        (let* ((base1 3)
               (guess (floor (1- (integer-length x))
                             (log base1 2)))
               (guess1 (* guess (log-e base1))))
          (+ guess1 (log-e (/ x (expt base1 guess)))))
        #-ignore
        (log-e-super-big x)
        (log-e-to-res x (%make-dfloat)))))
   ((and (ratiop x)  
         (or (> x most-positive-double-float)
             (< x most-negative-double-float)))
    (- (log-e (%numerator x)) (log-e (%denominator x))))
   ((typep x 'complex)
    (complex (log-e (abs x)) (phase x)))
   ((typep x 'short-float)
    (with-ppc-stack-double-floats ((dx x)
                                   (dres))
      (if (minusp x)
        (complex (%double-float->short-float 
                  (%double-float-log! (%%double-float-abs dx dx) dres) (%make-sfloat))
                 #.(coerce pi 'short-float))
        (%double-float->short-float (%double-float-log! dx dres) (%make-sfloat)))))
   (t
    (with-ppc-stack-double-floats ((dx x))
      (if (minusp x)
        (complex (%double-float-log! (%%double-float-abs dx dx) (%make-dfloat)) pi)
        (%double-float-log! dx (%make-dfloat)))))))


;;  cool from gsb


(eval-when (:execute :compile-toplevel)
  
  (defconstant $significant-bits-to-log (+ IEEE-DOUBLE-FLOAT-DIGITS 5))
)
(defun log-e-super-big (big)
  (let* ((n (integer-length big))
	 (scale (- n $significant-bits-to-log))
	 (bits (ash big (- scale)))
	 )
    ;; big == bits * 2^scale
    ;; log(big) == log(bits) + log(2 ^ scale)
    ;;          == log(bits) + log(2) * scale
    (+ (log-e bits)
       (* #.(log-e 2) scale))))


(defun exp (x)
  (let* ((x1 (%make-dfloat)))
    (declare (dynamic-extent x1))    
    (if (complexp x)
      (* (%double-float-exp! (%double-float (realpart x) x1) x1) (cis (imagpart x)))
          (if (typep x 'short-float)
            (with-ppc-stack-double-floats ((dx x)
                                           (dres))
              (%short-float (%double-float-exp! dx dres) (%make-sfloat)))
            (%double-float-exp! (%double-float x x1) (%make-dfloat))))))

(defun expt (b e)
  (cond ((integerp e)
         (if (minusp e) (/ 1 (%integer-power b (- e))) (%integer-power b e)))
        ((zerop b)
         (if (plusp (realpart e)) b (report-bad-arg e '(number (0) *))))
        ((and (realp b) (plusp b) (realp e))
         (with-ppc-stack-double-floats ((b1 b)
                                        (e1 e))
           (let* ((b-short (typep b 'short-float))
                  (b-rational (typep b 'rational))
                  (e-short (typep e 'short-float))
                  (e-rational (typep e 'rational)))
             (if (or (and b-short (or e-short e-rational))
                     (and b-rational e-short))
               (with-ppc-stack-double-floats ((dres))
                 (%double-float-expt! b1 e1 dres)
                 (%double-float->short-float dres (%make-sfloat)))
               (%double-float-expt! b1 e1 (%make-dfloat))))))
        (t (exp (* e (log b))))))

(defun sqrt (x &aux a b)
  (cond ((zerop x) x)
        ((complexp x) (* (sqrt (abs x)) (cis (/ (phase x) 2))))          
        ((and (floatp x)(nan-or-infinity-p x)(not (infinity-p x)))
         (fsqrt x))
        ((minusp x) (complex 0 (sqrt (- x))))
        ((floatp x)
         (fsqrt x))
        ((and (integerp x) (eql x (* (setq a (isqrt x)) a))) a)
        ((and (ratiop x)
              (let ((n (numerator x))
                    d)
                (and (eql n (* (setq a (isqrt n)) a))
                     (eql (setq d (denominator x))
                          (* (setq b (isqrt d)) b)))))
         (/ a b))          
        (t (with-ppc-stack-double-floats ((f1))
             (fsqrt (%double-float x f1))))))

(defun asin (x)
  (if (typep x 'short-float)
    (locally
      (declare (type short-float x))
      (if (and (<= -1.0s0 x)
               (<= x 1.0s0))
        (with-ppc-stack-double-floats ((dx x)
                                       (dres))
          (%double-float-asin! dx dres)
          (%double-float->short-float dres (%make-sfloat)))
        (let* ((temp (+ (complex -0.0s0 x) (sqrt (- 1.0s0 (the short-float (* x x)))))))
          (complex (phase temp) (- (log (abs temp)))))))
    (let* ((x1 (%make-dfloat)))
      (declare (dynamic-extent x1))
      (if (and (realp x) 
               (<= -1.0 (setq x (%double-float x x1)))
               (<= x 1.0))
        (%double-float-asin! x (%make-dfloat))
        (progn
          (setq x (+ (complex (- (imagpart x)) (realpart x))
                     (sqrt (- 1 (* x x)))))
          (complex (phase x) (- (log (abs x)))))))))

(eval-when (:execute :compile-toplevel)
  (defconstant half-pi (asin 1.0d0))  ;Not CL.  ; what kind of half-pi?
)

(defun acos (x)
  (if (typep x 'short-float)
    (locally
      (declare (type short-float x))
      (if (and (<= -1.0s0 x)
               (<= x 1.0s0))
        (with-ppc-stack-double-floats ((dx x)
                                       (dres))
          (%double-float-acos! dx dres)
          (%double-float->short-float dres (%make-sfloat)))
        (with-ppc-stack-short-floats ((shalf-pi half-pi))
          (- shalf-pi (asin x)))))
    (let* ((x1 (%make-dfloat)))
      (declare (dynamic-extent x1))
      (if (and (realp x)
               (<= -1.0 (setq x (%double-float x x1)))
               (<= x 1.0))
        (%double-float-acos! x (%make-dfloat))
        (- half-pi (asin x))))))

#|
(defun fsqrt (x)  
  (etypecase x
    (double-float    
     (let* ((result (%make-dfloat))
            (flags (%get-fpscr-control)))
       (unwind-protect
         (progn
           ;; Disable underflow, which should be disabled in most cases anyhow.
           ;(%set-fpscr-control (logand (lognot #x20) flags))  ; this is/was necessary on 6100 with sys 7.5 (doesn't seem to happen on 9500 w 7.5.2)
           (%double-float-sqrt! x result))
         (%set-fpscr-status 0)
         (%set-fpscr-control flags))))
    (short-float
     (with-ppc-stack-double-floats ((dx x)
                                    (dresult))
       (let* ((flags (%get-fpscr-control)))
         (unwind-protect
           (progn
             (%set-fpscr-control (logand (lognot #x20) flags))
             (%double-float-sqrt! dx dresult))
           (%set-fpscr-status 0)
           (%set-fpscr-control flags)))
       (%double-float->short-float dresult (%make-sfloat))))))
|#

(defun fsqrt (x)  
  (etypecase x
    (double-float    
     (let* ((result (%make-dfloat)))
       (%double-float-sqrt! x result)))
    (short-float
     (with-ppc-stack-double-floats ((dx x)
                                    (dresult))         
       (%double-float-sqrt! dx dresult)
       (%double-float->short-float dresult (%make-sfloat))))))


(defun %fatan2 (y x &optional result)
  ;; x any y may be stack-consed (are from only caller)
  (if (and (not result)(zerop x))
    (if (zerop y)
      (if (plusp (float-sign x))
        y
        (float-sign y pi))
      (float-sign y half-pi))
    (%double-float-atan2! y x (or result (%make-dfloat)))))

(defun %fsinh (x)
 (%double-float-sinh! x (%make-dfloat)))

(defun %fcosh (x)
  (%double-float-cosh! x (%make-dfloat)))

(defun %ftanh (x)
  (%double-float-tanh! x (%make-dfloat)))

(defun %fasinh (x)
  (%double-float-asinh! x (%make-dfloat)))

(defun %facosh (x)
  (%double-float-acosh! x (%make-dfloat)))

(defun %fatanh (x)
  (%double-float-atanh! x (%make-dfloat)))


; Manipulating the FPSCR.
; This  returns the bottom 8 bits of the FPSCR
(defppclapfunction %get-fpscr-control ()
  (mffs fp0)
  (stfd fp0 -8 sp)
  (lbz imm0 -1 sp)
  (box-fixnum arg_z imm0)
  (blr))

; Returns the high 24 bits of the FPSCR
(defppclapfunction %get-fpscr-status ()
  (mffs fp0)
  (stfd fp0 -8 sp)
  (lwz imm0 -4 sp)
  (clrrwi imm0 imm0 8)
  (srwi arg_z imm0 (- 8 ppc::fixnumshift))
  (blr))

; Set the high 24 bits of the FPSCR; leave the low 8 unchanged
(defppclapfunction %set-fpscr-status ((new arg_z))
  (slwi imm0 new (- 8 ppc::fixnumshift))
  (stw imm0 -4 sp)
  (lfd fp0 -8 sp)
  (mtfsf #xfc fp0)                      ; set status fields [0-5]
  (blr))

; Set the low 8 bits of the FPSCR; leave the high 24 unchanged
(defppclapfunction %set-fpscr-control ((new arg_z))
  (unbox-fixnum imm0 new)
  (stw imm0 -4 sp)
  (lfd fp0 -8 sp)
  (mtfsf #x03 fp0)                      ; set control fields [6-7]
  (blr))


; See if the binary double-float operation OP set any enabled
; exception bits in the fpscr
(defun %df-check-exception-2 (operation op0 op1)
   (let* ((fp-status (logior (the fixnum (%get-fpscr-status)) (the fixnum (ash (the fixnum (%get-kernel-global 'ffi-exception)) -8)))))
     (declare (type (unsigned-byte 24) fp-status))
     (when (logbitp (- 23 ppc::fpscr-fex-bit) fp-status)
       (%set-fpscr-status 0)
       ; Ensure that operands are heap-consed
       (%fp-error-from-status fp-status 
                              (%get-fpscr-control)
                              operation 
                              (%copy-double-float op0 (%make-dfloat)) 
                              (%copy-double-float op1 (%make-dfloat))))))

(defun %df-check-exception-1 (operation op0)
   (let* ((fp-status (logior (the fixnum (%get-fpscr-status)) (the fixnum (ash (the fixnum (%get-kernel-global 'ffi-exception)) -8)))))
     (declare (type (unsigned-byte 24) fp-status))
     (when (logbitp (- 23 ppc::fpscr-fex-bit) fp-status)
       (%set-fpscr-status 0)
       ; Ensure that operands are heap-consed
       (%fp-error-from-status fp-status 
                              (%get-fpscr-control)
                              operation 
                              (%copy-double-float op0 (%make-dfloat))))))

(defun fp-condition-from-fpscr (status-bits control-bits)
  (cond 
   ((and (logbitp (- 23 ppc::fpscr-vx-bit) status-bits)
         (logbitp (- 31 ppc::fpscr-ve-bit) control-bits)) 'floating-point-invalid-operation)
   ((and (logbitp (- 23 ppc::fpscr-ox-bit) status-bits)
         (logbitp (- 31 ppc::fpscr-oe-bit) control-bits)) 'floating-point-overflow)
   ((and (logbitp (- 23 ppc::fpscr-ux-bit) status-bits)
         (logbitp (- 31 ppc::fpscr-ue-bit) control-bits)) 'floating-point-underflow)
   ((and (logbitp (- 23 ppc::fpscr-zx-bit) status-bits)
         (logbitp (- 31 ppc::fpscr-ze-bit) control-bits)) 'division-by-zero)
   ((and (logbitp (- 23 ppc::fpscr-xx-bit) status-bits)
         (logbitp (- 31 ppc::fpscr-xe-bit) control-bits)) 'floating-point-inexact)))

; This assumes that the FEX and one of {VX OX UX ZX XX} is set.
; Ignore 
(defun %fp-error-from-status (status-bits control-bits operation &rest operands)
  (declare (type (unsigned-byte 16) status-bits))
  (let* ((condition-class (fp-condition-from-fpscr status-bits control-bits)))
    (if condition-class
      (error (make-instance condition-class
               :operation operation
               :operands operands)))))

(defun fp-minor-opcode-operation (minor-opcode)
  (case minor-opcode
    (25 '*)
    (18 '/)
    (20 '-)
    (21 '+)
    (t 'unknown)))

; Don't we already have about 20 versions of this ?
(defppclapfunction %double-float-from-macptr! ((ptr arg_x) (byte-offset arg_y) (dest arg_z))
  (lwz imm0 ppc::macptr.address ptr)
  (unbox-fixnum imm1 byte-offset)
  (lfdx fp1 imm0 imm1)
  (put-double-float fp1 dest)
  (blr))


(defvar *rounding-mode-alist*
  '((:nearest . 0) (:zero . 1) (:positive . 2) (:negative . 3)))

(defun get-fpu-mode ()
  (let* ((flags (%get-fpscr-control)))
    `(:rounding-mode ,(car (nth (logand flags 3) *rounding-mode-alist*))
                     :overflow ,(logbitp 6 flags)
                     :underflow ,(logbitp 5 flags)
                     :division-by-zero ,(logbitp 4 flags)
                     :invalid ,(logbitp 7 flags)
                     :inexact ,(logbitp 3 flags))))

;; did we document this?
(defun set-fpu-mode (&key (rounding-mode :nearest rounding-p)
                          (overflow t overflow-p)
                          (underflow t underflow-p)
                          (division-by-zero t zero-p)
                          (invalid t invalid-p)
                          (inexact t inexact-p))
  (let* ((mask (logior (if rounding-p #x03 #x00)
                       (if invalid-p #x80 #x00)
                       (if overflow-p #x40 #x00)
                       (if underflow-p #x20 #x00)
                       (if zero-p #x10 #x00)
                       (if inexact-p #x08 #x00)))
         (new (logior (or (cdr (assoc rounding-mode *rounding-mode-alist*))
                          (error "Unknown rounding mode: ~s" rounding-mode))
                      (if invalid #x80 0)
                      (if overflow #x40 0)
                      (if underflow #x20 0)
                      (if division-by-zero #x10 0)
                      (if inexact #x08 0))))
    (declare (type (unsigned-byte 8) new mask))
    (%set-fpscr-control (logior (logand new mask)
                                (logandc2 (%get-fpscr-control) mask)))
    (get-fpu-mode)))


