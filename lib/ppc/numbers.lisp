;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  6 3/17/97  akh  tanh and float-and-scale-and-round
;;  5 3/14/97  akh  see below
;;  15 7/18/96 akh  tweaks to 5-to-e
;;  13 5/20/96 akh  float-and-scale-and-round takes opt result
;;  10 4/1/96  akh  isqrt dont use int>0-p - is broken today
;;  9 2/19/96  akh  read 1.0s0 as double vs error for now
;;  8 12/22/95 gb   Something ... unforgivable
;;  7 12/12/95 akh  logandc2 stays here
;;  5 12/1/95  akh  %i+ in parse-float
;;  4 11/15/95 slh  just changed a bogus comment
;;  3 11/13/95 akh  #-ppc-target short float stuff
;;  2 4/6/95   akh  Use Kalman's rationalize
;;  (do not edit before this line!!)

;; Lib;numbers.lisp - Lisp arithmetic code.
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

; Edit History
;; *read-default-float-format* - single-float means same as short-float 
;; try-harder fix for underflow negative 0, 
;; try-harder and float-and-scale-and-round - don't cerror if get-fpu-mode-underflow/overflow nil - do plain error if t
;; 5.2b1
; include some float stuff pulled from ff-source
; -------- 5.0 final
; akh small optimization in %integer-power, also special case b = 10
; --------- 4.3f1c1
; 03/17/97 akh fix tanh per 70's music
; 03/16/97 akh float-and-scale-and-round passes result to make-short-float-from-fixnums
; 03/13/97 bill (require :number-macros) per Alice.
; 03/12/97 akh  fide and friends paramaterized for short/double conditialized for ppc/68k
; 03/01/97 gb   lotsa short-float changes.  Still some magic numbers in, e.g., FIDE.
; ------- 4.0
; 07/22/96 gb   make float reader power tables.
; 06/15/96 bill (method print-object (random-state t)) uses ppc::fixnum-shift instead
;               of $fixnumshift for ppc-target.
; float-and-scale-and-round takes opt result
; 04/28/96 akh  rationalize -dont work so hard for denorm and powers of 2 - was neither more pleasant to view nor simpler to compute with
;  3/28/96 slh  %fabs -> 68k-float.lisp
; 12/06/95 slh  cond. out some level-0 fns
; 11/11/95 slh  fide: confusing buggy comment updated
; 10/12/95 slh  cleanup re l1-numbers.lisp
; 09/14/95 gb   use &lexpr, fix /= (my bad.)
; 01/12/93 bill Bob Cassel's patch to sqrt: move complex test earlier so
;               the minusp doesn't error.
; ------------- 3.0d13
;07/07/93 bill  random-state stuff except for the print-object method moves to l1-numbers
;-------------- 3.0d11
;06/25/93 alice float reader (try-harder) - error before trying to compute (expt 5 100000).
;05/28/93 bill  a random-state can no longer get "stuck" at 0.
;-------------- 3.0d8
;04/20/93 alice messed with short float reader some more
; 04/19/93 alice fix short float reader (finally) so fix below is not necessary
; 04/19/93 alice float-5-to-e don't die if e > 23
; 08/10/92 alice sqrt - check for floatp early - twice as fast if true.
; 07/13/92 alice float - faster, shorter, fceiling, fround, ftruncate, ffloor
;01/13/93 bill  ldb, dpb, & friends move to l1-numbers
;11/20/92 gb    new temp-float-consing syntax.  Not sure about mods to ffloor, etc.
;07/13/92 bill  (ffloor 3) no longer signals an error (neither do fceiling, fround, or ftruncate)
;-------------- 2.0
;02/22/92 (alice from "post 2.0f2c5:default-float-patch") don't rts from MAKE-SHORT-FLOAT-FROM-FIXNUMS;
;               dtrt with *read-default-float-format* in PARSE-FLOAT;
;               do short floats the sloppy way - instead of totally broken - in FIDE.
;-------------- 2.0f2c5
;11/25/91 alice #\f and #\F are also exponent markers
;-------------- 2.0b4
;11/21/91 alice allow a dude to types 200 digits and e-500
;11/18/91 alice new float reader - hope we dont need to read floats sooner
;09/08/91 alice log of bignum or big ratio doesnt try to float it, sqrt fancier for bignum & ratio
;------------- 2.0b3
;08/31/91 gb    fix complex/short-float stuff.
;08/24/91 gb    use new trap syntax; don't _Debugger in %%decode-sfloat.
;07/21/91 gb    &lap arglists, error checking & signalling.  Naive ATAN still loses, place
;               blame elsewhere.
;06/07/91 bill  isqrt type-checks its argument.
;-------------- 2.0b2
;05/30/91 gb    Do assume FMOVE.L emulated.
;05/30/91 gb    Don't assume FMOVE.L emulated.
;05/23/91 bill  gb's fixes for acos, asin, & %fatan2
;05/20/91 gb    Short-floats more-or-less work, modulo some "complex" cases.
;01/15/91 alice add fixnum-decode-float and make-float-from-fixnums
;---------------- 2.0a5 d83
;11/28/90 alice byte-position allow 0 size
;09/27/90 bill  Akira KURIHARA's (Newton's) isqrt
;04/02/90  gz   write-a-random-state -> print-object.
;03/20/90  gz   Change %fatan2 and atan as per X3J13/IEEE-ATAN-BRANCH-CUT:SPLIT.  Make
;               it cons less while at it.
;               atemp0 -> atemp1 in ABS.
;03/01/90  gz   Split off %%scale-float, so don't have to cons a float just to
;               scale it.
;12-Nov-89 Mly  Important optimisation: speed up /= by 40%.  Use *write-istruct-alist*
;10/30/89 bill  Rename pr-%print-random-state to write-a-random-state and add
;               stream arg
;10/03/89  gz   Remove assumption that bignums are less than 32k.
;05/07/89 gb    allocvect,reservevect calls pass subtype in arg_y.
;04/19/89 gz    Coerce to complex fns.
;04/07/89 gb  $sp8 -> $sp.
;4/4/89    gz   $narithtemps -> $xfp0. Moved lap macros to lapmacros.
;03/08/89  gz   [integer]-decode-float, float-precision, scale-float, random,
;               gcd, abs, boole et. al.
;               No more %fexpt. Moved store_float to lapmacros.
;03/03/89  gz   Bytefield functions. Made byte not cons for fixnum fields.
;02/12/89  gz   Added %copy-float, float, complex, float-sign, random-state-p, make-random-state.
;               Flushed real-arg.  Do float stuff inline.
;01/03/89  gz   #C
;11/18/88  gz   Lapified LCM, made (LCM) => 1 instead of error.
; 9/02/88  gz   Added number-arg, real-arg, logcount
;               dynamic extent &rest in /=.
; 8/27/88  gz   random state printing.  No more hitypes!
; 8/15/88  gz   added float-digits, float-radix.
; 7/30/87  gb   sneak /= past defun.
; 7/24/87  gz   fix in complex sqrt.
; 7/12/87  gb   Provide thyself; some stuff to sysutils.
; 6/17/87  gb   1+, 1- : moved to level-2.
; 5/17/87  gz   removed defconstants (in kernel now). Fix in %fatanh.
; 3/27/87  gz   avoid recursive &rest arg consing in min, max, /=.
; 03/02/87 gz   Use defconstant for constants, compute values at compile time,
;               move to top so can use them within.  Added real rationalize.
; 01/18/87 gz   Added byte-field fns. %apply -> apply. Added fake
;               ffloor, fceiling, ftruncate, fround, rational, rationalize.
; 01/29/87 gz   %put -> put
; GZ, 27-Jan-87 Removed uses of type-of
; GZ, 4-Jan-87  Removed fixnump, integerp, numberp, floatp, complex.
;               Made half-pi compile-time only.
; GZ, 1-Sep-86  Added LCM, made stuff use ash now that it works for bignums,
;               use define-constant for constants.
; GZ, 27-Jul-86	Added transcendental fns, pi (Chapter 12.5 of CLtL).
;               Made type predicates return t/nil.
;               changed defconstants to home-baked defconst to get around
;               cfasl limitation.
; GZ, 29-May-86 Removed stuff in kernel now.
; GZ, 26-May-86 Added %put of version so can tell if loaded
; GZ, 3-May-86  New for lisp 4.16
; GZ, 27-Mar-86 New

(in-package "CCL")

(eval-when (:compile-toplevel :execute)
 (require :number-macros))

(defun parse-float (str len off)  
  ; we cant assume this really is a float but dont call with eg s1 or e1
  (let ((integer 0)(expt 0)(sign 0)(done 0)(digits 0) point-pos type) 
    (setq integer
          (do ((n off (1+ n))
               (first t nil)
               (maxn  (+ off len)))
              ((>= n maxn) integer)
            (declare (fixnum n maxn))
            (let ((c (%schar str n)))
              (cond ((eq c #\.)
                     (setq point-pos digits))
                    ((and first (eq c #\+)))
                    ((and first (eq c #\-))
                     (setq sign -1))
                    ((memq c '(#\s #\S #\f #\F))
                     (setq type 'short-float)
                     (return integer))
                    ((memq c '(#\d #\l  #\D #\L))
                     (setq type 'double-float)
                     (return integer))
                    ((memq c '(#\e #\E))
                     (return integer))
                    ((setq c (digit-char-p c))
                     (setq digits (1+ digits))
                     (setq integer (+ c (* 10 integer))))                  
                    (t (return-from parse-float nil)))
              (setq done (1+ done)))))
    (when point-pos
      (setq expt  (%i- point-pos digits)))
    (when (null type)
      (setq type *read-default-float-format*)
      ;; ugh
      (if (eq type 'single-float)(setq type 'short-float)))
    (when (> len done)
      (let ((eexp nil) (esign 1) c)
        (do ((n (%i+ off done 1) (1+ n))
             (first t nil))
            ((>= n (+ off len)))
          (declare (fixnum n))
          (setq c (%schar str n))
          (cond ((and first (or (eq c #\+)(eq c #\-)))
                 (when (eq c #\-)(setq esign -1)))
                ((setq c (digit-char-p c))
                 (setq eexp (+ c (* (or eexp 0) 10))))
                (t (return-from parse-float nil))))
        (when (not eexp)(return-from parse-float nil))
        (setq expt (%i+ expt (* esign eexp)))))
    ; if ppc read s as double vs error
    (fide sign integer expt (eq type 'short-float))))

;; an interesting test case: 1.448997445238699
;; The correct result is 6525704354437805 x 2^-52
;; Incorrect is          6525704354437806 x 2^-52
;; (from Will Clinger, "How to Read Floating Point Numbers Accurately",
;;  ACM SIGPLAN'90 Conference on Programming Language Design and Implementation")
;; Doug Curries numbers 214748.3646, 1073741823/5000


;; Sane read losers
;; 15871904747836473438871.0e-8
;; 3123927307537977993905.0-13
;; 17209940865514936528.0e-6
;; "13.60447536e132" => adds some gratuitous drech
;; "94824331561426550.889e182"
;; "1166694.64175277e-150" => 1.1666946417527701E-144
;; "3109973217844.55680988601e-173"
;; "817332.e-184" => 8.173320000000001E-179
;; "2695.13e-180" => 2.6951300000000002E-177
;; "89.85345789e-183" => 8.985345789000001E-182
;; "0864813880.29e140" => 8.648138802899999E+148
;; "5221.e-193" => 5.2209999999999995E-190
;; "7.15628e-175" => 7.156280000000001E-175

(defparameter float-powers-of-5  nil)
(defparameter integer-powers-of-5 nil)

(defun 5-to-e (e)
  (declare (fixnum e)(optimize (speed 3)(safety 0)))
  (if (> e 335)
    (* (5-to-e 335)(5-to-e (- e 335))) ; for the dude who types 200 digits and e-500
    (if (< e 12)
      (svref integer-powers-of-5 e)
      (multiple-value-bind (q r) (truncate e 12) ; was floor
        (declare (fixnum q r))        
        (if (eql r 0)
          (svref integer-powers-of-5 (%i+ q 11))
          (* (svref integer-powers-of-5 r)
             (svref integer-powers-of-5 (%i+ q 11))))))))

(defun float-5-to-e (e)
  (if (> e 22)  ; shouldnt happen
    (expt 5.0 e)
    (svref float-powers-of-5 e)))

(defparameter a-short-float nil)

(eval-when (:compile-toplevel :execute)
  ; number of bits for mantissa before rounding
  (defconstant *short-float-extended-precision* 28)
  (defconstant *double-float-extended-precision* 60)
  ; number of mantissa bits including hidden bit
  (defconstant *double-float-precision* (1+ IEEE-double-float-mantissa-width))
  (defconstant *short-float-precision* (1+ IEEE-single-float-mantissa-width))
  (defconstant *double-float-bias* IEEE-double-float-bias)
  (defconstant *double-float-max-exponent* (1+ IEEE-double-float-normal-exponent-max))
  (defconstant *double-float-max-exact-power-of-5* 23)
  ;(defconstant *short-float-max-exact-integer-length* 24)
  (defconstant *double-float-max-exact-integer-length* 53)
)

#-ppc-target
(eval-when (:compile-toplevel :execute)
  (defconstant *short-float-max-exact-power-of-5* 5)
  (defconstant *short-float-bias* 30)
  (defconstant *short-float-max-exact-integer-length* 17)  ; why 17 vs 24??? - max integer that can be converted to a short exactly and without overflow
  (defconstant *short-float-max-exponent* (+ *short-float-bias* 18)) ; huh
  
)

#+ppc-target
(eval-when (:compile-toplevel :execute)
  (defconstant *short-float-max-exact-power-of-5* 10)
  (defconstant *short-float-bias* IEEE-single-float-bias)
  (defconstant *short-float-max-exact-integer-length* 24)
  (defconstant *short-float-max-exponent* (1+ IEEE-single-float-normal-exponent-max))
)

#|
(defun get-fpu-overflow-underflow ()
  (let ((flags (%get-fpscr-control)))
    (values (logbitp 6 flags)  ;; overflow
            (logbitp 5 flags)  ;; underflow
            )))
|#

(defun get-fpu-mode-overflow ()
  (let ((flags (%get-fpscr-control)))
    (logbitp 6 flags)))

(defun get-fpu-mode-underflow ()
  (let ((flags (%get-fpscr-control)))
    (logbitp 5 flags)))



  
;; this stuff  could be in a shared file

(defun fide #|float-integer-with-decimal-exponent|# (sign integer power-of-10 &optional short)
  ;; take care of the zero case
  (when (zerop integer)
    (return-from fide ;float-integer-with-decimal-exponent
       (if short
         (if (minusp sign) -0.0s0 0.0s0)
         (if (minusp sign) -0.0d0 0.0d0))))
  (let ((abs-power (abs power-of-10))
        (integer-length (integer-length integer)))
    ;; this doesn't work for the above example, so arithmetic must be done wrong
    ;; This does work if set FPCR precision to double
    ;; now see if the conversion can be done simply:
    ;; if both the integer and the power of 10 can be floated exactly, then
    ;; correct rounding can be done by the multiply or divide
    (when (or;short
           (and (<= integer-length  
                    ;; was (if short 17 53) why 17? see above
                    (if short *short-float-max-exact-integer-length* *double-float-max-exact-integer-length*)) 
                ;; (integer-length (expt 5 23)) => 54
                ;; was (if short 5 23)
                (< abs-power  (if short 
                                *short-float-max-exact-power-of-5*
                                *double-float-max-exact-power-of-5*)))) ; we mean < 23 not <=
      ;; if you care about consing, this could be done in assembly language or whatever,
      ;; since all integers fit in 53 bits
      (return-from fide ;float-integer-with-decimal-exponent
        (let* ((signed-integer (prog1 (if (minusp sign) (- integer) integer)))
               (float (float signed-integer (if short 0.0s0 0.0d0)))
               (10-to-power (scale-float (float-5-to-e abs-power) abs-power)))
          ; coerce to short-float does not whine about undeflow, but does re overflow
          (when short (setq 10-to-power (coerce 10-to-power 'short-float)))
          (if (zerop abs-power)
            float
            (if (minusp power-of-10)
              (/ float  10-to-power)
              (* float  10-to-power))))))
    (try-harder sign integer power-of-10 short)))

#|
(defun try-harder (sign integer power-of-10 short)
  (flet ((ovf (&optional under)
           (if under
             (when (get-fpu-mode-underflow)(cerror "Use float 0 instead." "Exponent underflow."))
             (when (get-fpu-mode-overflow)(cerror "Use largest value instead." "Exponent overflow.")))
           (return-from try-harder
             (if under
               (if short
                 (if (minusp sign) -0.0s0 0.0s0)                 
                 (if (minusp sign) -0.0d0 0.0d0))  ;; <<  we said 0.0d0 when meant -0.0d0
               (if short
                 (if (minusp sign) most-negative-short-float most-positive-short-float)              
                 (if (minusp sign) most-negative-double-float most-positive-double-float))))))
  (let* ((integer-length (integer-length integer)) new-int power-of-2)
    (if (minusp power-of-10)
      (progn 
        ; avoid creating enormous integers with 5-to-e only to error later
        (when (< power-of-10 -335)
          (let ((poo (+ (round integer-length 3.2) power-of-10)))
            ; overestimate digits in integer
            (when (< poo -335) (ovf t))
            ; this case occurs if 600+ digits 
            (when (> poo 335)(ovf))))
        (let* ((divisor (5-to-e (- power-of-10)))
               ;; make sure we will have enough bits in the quotient
               ;; (and a couple extra for rounding)
               (shift-factor (+ (- (integer-length divisor) integer-length)
                                (if short *short-float-extended-precision* *double-float-extended-precision*)))
               (scaled-integer integer))
          (if (plusp shift-factor)
            (setq scaled-integer (ash integer shift-factor))
            (setq divisor (ash divisor (- shift-factor))))
          (multiple-value-bind (quotient remainder)(floor scaled-integer divisor)
            (unless (zerop remainder) ; whats this - tells us there's junk below
              (setq quotient (logior quotient 1)))
            (setq new-int quotient)
            (setq power-of-2  (- power-of-10 shift-factor)))))
      (progn
        (when (> power-of-10 335)(ovf))
        (setq new-int (* integer (5-to-e power-of-10)))
        (setq power-of-2 power-of-10)))
    (float-and-scale-and-round sign new-int power-of-2 short))))
|#

(defun try-harder (sign integer power-of-10 short)
  (flet ((ovf (&optional under)
           (if under
             (when (get-fpu-mode-underflow)
               (error ;"Use float 0 result."
                       (make-condition 'floating-point-underflow
                                      :operation 'fide
                                      :operands (list sign integer power-of-10 short)))) ;(cerror "Use float 0 instead." "Exponent underflow."))
             (when (get-fpu-mode-overflow)
               (error ;"Use largest float value result."
                       (make-condition 'floating-point-overflow
                                     :operation 'fide
                                     :operands (list sign integer power-of-10 short))))) ;(cerror "Use largest value instead." "Exponent overflow.")))
           (return-from try-harder
             (if under
               (if short
                 (if (minusp sign) -0.0s0 0.0s0)                 
                 (if (minusp sign) -0.0d0 0.0d0))  ;; <<  we said 0.0d0 when meant -0.0d0
               (if short
                 (if (minusp sign) most-negative-short-float most-positive-short-float)              
                 (if (minusp sign) most-negative-double-float most-positive-double-float))))))
  (let* ((integer-length (integer-length integer)) new-int power-of-2)
    (if (minusp power-of-10)
      (progn 
        ; avoid creating enormous integers with 5-to-e only to error later
        (when (< power-of-10 -335)
          (let ((poo (+ (round integer-length 3.2) power-of-10)))
            ; overestimate digits in integer
            (when (< poo -335) (ovf t))
            ; this case occurs if 600+ digits 
            (when (> poo 335)(ovf))))
        (let* ((divisor (5-to-e (- power-of-10)))
               ;; make sure we will have enough bits in the quotient
               ;; (and a couple extra for rounding)
               (shift-factor (+ (- (integer-length divisor) integer-length)
                                (if short *short-float-extended-precision* *double-float-extended-precision*)))
               (scaled-integer integer))
          (if (plusp shift-factor)
            (setq scaled-integer (ash integer shift-factor))
            (setq divisor (ash divisor (- shift-factor))))
          (multiple-value-bind (quotient remainder)(floor scaled-integer divisor)
            (unless (zerop remainder) ; whats this - tells us there's junk below
              (setq quotient (logior quotient 1)))
            (setq new-int quotient)
            (setq power-of-2  (- power-of-10 shift-factor)))))
      (progn
        (when (> power-of-10 335)(ovf))
        (setq new-int (* integer (5-to-e power-of-10)))
        (setq power-of-2 power-of-10)))
    (float-and-scale-and-round sign new-int power-of-2 short))))


#|
(defun float-and-scale-and-round (sign integer power-of-2 short &optional result)
  (let* ((length (integer-length integer))
         (lowbits 0)
         (prec (if short *short-float-precision* *double-float-precision*))
         (ep (if short *short-float-extended-precision* *double-float-extended-precision*)))
    (when (<= length prec)
      ;; float can be done exactly, so do it the easy way
      (return-from float-and-scale-and-round
        (scale-float (float (if (minusp sign) (- integer) integer) (if short a-short-float))
                     power-of-2)))    
    (let* ((exponent (+ length power-of-2))
           ; 68K short float biased by 30 rather than 14 for reasons too complicated
           ; to explain having to do with the format allowing easy conversion to IEEE single float
           (biased-exponent (+ exponent (if short *short-float-bias* *double-float-bias*)))
           (sticky-residue nil))
      (cond
       #-ppc-target
       ((and short (< biased-exponent 16))
        ; there is one number that becomes zero without telling you.
        ; Although we are friendly here, we can over/underflow above without friendliness
        (cerror
         "Use short float 0 instead" "Exponent under flow")
        (return-from float-and-scale-and-round (if (zerop sign) 0.0s0 -0.0s0)))
       ((<= biased-exponent 0)
        ;; denormalize the number
        (setf sticky-residue (not (zerop (ldb integer (byte (- 1 biased-exponent) 0)))))
        (setf integer (ash integer (- biased-exponent 1)))
        (setf biased-exponent 0)))
      (let ((lowest (min ep length)))
        (when (and (> length ep)(not (zerop (ldb (byte (- length ep) 0) integer))))
          (setq integer (logior integer (ash 1 (- length ep)))))
        ; somewhere between 1 and (- ep prec) bits
        (setq lowbits (ash (ldb (byte (- lowest prec) (- length lowest)) integer) (- ep lowest))))
      (let* ((significand (ldb (byte (1- prec) (- length prec)) integer)))
        ;(break)
        (when (and (not (zerop (ldb (byte 1 (- length (1+ prec))) integer)))   ; round bit
                   (or sticky-residue (oddp significand)
                       (not (zerop (ldb (byte (- ep prec 1) 0) lowbits)))))
          ;; round up
          (setf significand (ldb (byte (1- prec) 0) (+ significand 1)))
          (when (zerop significand)
            (incf biased-exponent)))
        (cond ((and (zerop biased-exponent)
                    (zerop significand))
               (when (get-fpu-mode-underflow)
                 (cerror "Use a zero result" "Complete loss of significance in floating point read")))
              ((>= biased-exponent (if short *short-float-max-exponent* *double-float-max-exponent*))
               (cond #-ppc-target
                     (short
                      (cerror "Use largest magnitude short float" "Exponent overflow")
                      (return-from float-and-scale-and-round
                        (if (zerop sign) most-positive-short-float
                            most-negative-short-float)))
                     (t
                      (when (get-fpu-mode-overflow)
                        (cerror "Use a floating infinity result" "Exponent overflow"))
                      (setf significand 0)                      
                      (setq biased-exponent (if short *short-float-max-exponent* *double-float-max-exponent*))))))
        (values
         (if short 
           (make-short-float-from-fixnums (ldb (byte 23 0) significand)
                                          biased-exponent
                                          ; on ppc result makes sense but not on 68K
                                          sign result)
           (make-float-from-fixnums (ldb (byte 24 28) significand)
                                    (ldb (byte 28 0) significand)
                                    biased-exponent
                                    sign result))
         lowbits)))))
|#

(defun float-and-scale-and-round (sign integer power-of-2 short &optional result)
  (let* ((length (integer-length integer))
         (lowbits 0)
         (prec (if short *short-float-precision* *double-float-precision*))
         (ep (if short *short-float-extended-precision* *double-float-extended-precision*)))
    (when (<= length prec)
      ;; float can be done exactly, so do it the easy way
      (return-from float-and-scale-and-round
        (scale-float (float (if (minusp sign) (- integer) integer) (if short a-short-float))
                     power-of-2)))    
    (let* ((exponent (+ length power-of-2))
           ; 68K short float biased by 30 rather than 14 for reasons too complicated
           ; to explain having to do with the format allowing easy conversion to IEEE single float
           (biased-exponent (+ exponent (if short *short-float-bias* *double-float-bias*)))
           (sticky-residue nil))
      (cond
       #-ppc-target
       ((and short (< biased-exponent 16))
        ; there is one number that becomes zero without telling you.
        ; Although we are friendly here, we can over/underflow above without friendliness
        (cerror
         "Use short float 0 instead" "Exponent under flow")
        (return-from float-and-scale-and-round (if (zerop sign) 0.0s0 -0.0s0)))
       ((<= biased-exponent 0)
        ;; denormalize the number
        (setf sticky-residue (not (zerop (ldb integer (byte (- 1 biased-exponent) 0)))))
        (setf integer (ash integer (- biased-exponent 1)))
        (setf biased-exponent 0)))
      (let ((lowest (min ep length)))
        (when (and (> length ep)(not (zerop (ldb (byte (- length ep) 0) integer))))
          (setq integer (logior integer (ash 1 (- length ep)))))
        ; somewhere between 1 and (- ep prec) bits
        (setq lowbits (ash (ldb (byte (- lowest prec) (- length lowest)) integer) (- ep lowest))))
      (let* ((significand (ldb (byte (1- prec) (- length prec)) integer)))
        ;(break)
        (when (and (not (zerop (ldb (byte 1 (- length (1+ prec))) integer)))   ; round bit
                   (or sticky-residue (oddp significand)
                       (not (zerop (ldb (byte (- ep prec 1) 0) lowbits)))))
          ;; round up
          (setf significand (ldb (byte (1- prec) 0) (+ significand 1)))
          (when (zerop significand)
            (incf biased-exponent)))
        (cond ((and (zerop biased-exponent)
                    (zerop significand))
               (when (get-fpu-mode-underflow)
                 (error ;"Use float zero result."
                         (make-condition 'floating-point-underflow
                                        :operation 'float-and-scale-and-round
                                        :operands (list sign integer power-of-2 short)))))
                 ;(cerror "Use a zero result" "Complete loss of significance in floating point read")))
              ((>= biased-exponent (if short *short-float-max-exponent* *double-float-max-exponent*))
               (cond #-ppc-target
                     (short
                      (cerror "Use largest magnitude short float" "Exponent overflow")
                      (return-from float-and-scale-and-round
                        (if (zerop sign) most-positive-short-float
                            most-negative-short-float)))
                     (t
                      (when (get-fpu-mode-overflow)
                        (error ;"Use float infinity result."
                                (make-condition 'floating-point-overflow
                                               :operation 'float-and-scale-and-round
                                               :operands (list sign integer power-of-2 short))))
                        ;(cerror "Use a floating infinity result" "Exponent overflow"))
                      (setf significand 0)                      
                      (setq biased-exponent (if short *short-float-max-exponent* *double-float-max-exponent*))))))
        (values
         (if short 
           (make-short-float-from-fixnums (ldb (byte 23 0) significand)
                                          biased-exponent
                                          ; on ppc result makes sense but not on 68K
                                          sign result)
           (make-float-from-fixnums (ldb (byte 24 28) significand)
                                    (ldb (byte 28 0) significand)
                                    biased-exponent
                                    sign result))
         lowbits)))))


(defparameter a-short-float 1.0s0)


(defmethod print-object ((rs random-state) stream)
  ;;Besides #.grossness, this is buggy because cl:random-state
  ;;is not allowed to have a function definition...
  (let ((shift (%i- 16
                    #+ppc-target ppc::fixnum-shift
                    #-ppc-target $fixnumshift)))
    (format stream "#.(~S ~S ~S)"   ;>> #.GAG!!!
            'random-state
            (%ilsr shift (%svref rs 1))
            (%ilsr shift (%svref rs 2)))))

(defun float-radix (float)
  (require-type float 'float)
  2)

(defun float-digits (float)
  (if (typep (require-type float 'float) 'short-float)
    IEEE-single-float-digits
    IEEE-double-float-digits))

(defun number-arg (arg)
  (if (numberp arg) arg (%badarg arg 'number)))



#-ppc-target 
(progn  ; defined in level-0

;(coerce num '(complex <type>))
(defun coerce-to-complex-type (num type)
  (if (complexp num)
    (if (and (typep (complex.real num) type) (typep (complex.imag num) type))
      num
      (complex (coerce (complex.real num) type)
               (coerce (complex.imag num) type)))
    (complex (coerce num type))))

(defun conjugate (number)
   (if (complexp number)
      (complex (complex.real number) (- (complex.imag number)))
     (if (numberp number) number
         (report-bad-arg number 'number))))

(defun numerator (rational)
  (if (ratiop rational) (ratio.num rational)
    (if (integerp rational) rational
      (report-bad-arg rational 'rational))))

(defun denominator (rational)
  (if (ratiop rational) (ratio.den rational)
    (if (integerp rational) 1
      (report-bad-arg rational 'rational))))

(defun abs (number)
  (numeric-dispatch number
    (integer (%integer-abs number))
    (short-float (%short-float-abs number))
    (double-float (%double-float-abs number))
    (ratio 
     (let* ((numer (ratio.num number))
            (abs-numer (%integer-abs numer)))
       (declare (integer numer abs-numer))
       (if (= numer abs-numer)
         number
         (%make-ratio abs-numer (ratio.den number)))))
    (((complex short-float) 
      (complex double-float)
      (complex rational))               ; Screw: this conses again
     (let* ((r (complex.real number))
            (i (complex.imag number)))
       (sqrt (+ (* r r) (* i i)))))))
)

;==> Needs a transform...
(defun logandc2 (integer1 integer2) (logandc1 integer2 integer1))

(defun logorc2 (integer1 integer2) (logorc1 integer2 integer1))



; Figure that the common (2-arg) case is caught by a compiler transform anyway.
(defun gcd (&lexpr numbers)
  (let* ((count (%lexpr-count numbers)))
    (declare (fixnum count))   
    (if (zerop count)
      0
      (let* ((n0 (%lexpr-ref numbers count 0)))
        (if (= count 1)
          (%integer-abs n0)
          (do* ((i 1 (1+ i)))
               ((= i count) n0)
            (declare (fixnum i))
            (setq n0 (gcd-2 n0 (%lexpr-ref numbers count i)))))))))

(defun lcm-2 (n0 n1)
  (let* ((small (if (< n0 n1) n0 n1))
         (large (if (eq small n0) n1 n0)))
    (* (truncate large (gcd n0 n1)) small)))

(defun lcm (&lexpr numbers)
  (let* ((count (%lexpr-count numbers)))
    (declare (fixnum count))    
    (if (zerop count)
      1
      (let* ((n0 (%lexpr-ref numbers count 0)))
        (if (= count 1)
          (%integer-abs n0)
          (do* ((i 1 (1+ i)))
               ((= i count) n0)
            (declare (fixnum i))
            (setq n0 (lcm-2 n0 (%lexpr-ref numbers count i)))))))))


#|
(defun rationalize (number)
  (cond ((not (floatp number)) (rational number))
        ((minusp number) (- (rationalize (- number))))
        ((zerop number) 0)
        (t (let ((onum 1) (oden 0) num (den 1) rem)
             (multiple-value-setq (num rem) (truncate number))
             (until (<= (abs (/ (- number (/ (float num) den)) number))
                        single-float-epsilon)
               (multiple-value-bind (q r) (truncate 1.0 rem)
                 (setq rem (/ r rem))
                 (let ((nnum (+ (* q num) onum)))
                   (setq onum num num nnum))
                 (let ((nden (+ (* q den) oden)))
                   (setq oden den den nden))))
             (/ num den)))))
;Rationalize failed. Input 1.9998229581607005 Rational 70903515/35454896 Float 1.9998229581607008
; also gets overflow and underflow sometimes
|#
; Kalman's more better one
(defun rationalize (number)
  (if (floatp number)
    (labels ((simpler-rational (less-predicate lonum loden hinum hiden
                                               &aux (trunc (if (eql less-predicate #'<=)
                                                             #'ceiling
                                                             #'(lambda (n d) (1+ (floor n d)))))
                                               (term (funcall trunc lonum loden)))
               ;(pprint (list lonum loden hinum hiden))
               (if (funcall less-predicate (* term hiden) hinum)
                 (values term 1)
                 (multiple-value-bind 
                   (num den)
                   (simpler-rational less-predicate hiden (- hinum (* (1- term) hiden))
                                     loden (- lonum (* (1- term) loden)))
                   (values (+ den (* (1- term) num)) num)))))                           
      (multiple-value-bind (fraction exponent sign) (integer-decode-float number)
        ; the first 2 tests may be unnecessary - I think the check for denormalized
        ; is compensating for a bug in 3.0 re floating a rational (in order to pass tests in ppc-test-arith).
        (if (or (and (typep number 'double-float)  ; is it denormalized
                     (eq exponent #.(nth-value 1 (integer-decode-float least-positive-double-float)))) ; aka -1074))
                (and nil ;(typep number 'short-float) ; was needed to pass tests but bug was elsewhere
                     ; this won't cross compile but I assume we don't worry about that any more.
                     (eq exponent #.(nth-value 1 (integer-decode-float least-positive-short-float)))) ; aka -149))
                (zerop (logand fraction (1- fraction)))) ; or a power of two
          (rational number)
          (if (minusp exponent)
	    ;;less than 1
            (let ((num (ash fraction 2))
	          (den (ash 1 (- 2 exponent))))
	      (multiple-value-bind 
                (n d)
                (simpler-rational (if (evenp fraction) #'<= #'<)
                                  (- num 2) ;(if (zerop (logand fraction (1- fraction))) 1 2))
                                  den  (+ num 2) den)
	        (when (minusp sign)
	          (setq n (- n)))
	        (/ n d)))
            ;;greater than 1
            (ash (if (minusp number) (- fraction) fraction) exponent)))))
    (rational number)))
#|
(defun testrat (&optional (n 1000))
  (dotimes (i n)
    (let* (( numerator (random (ash 1 63)))
          (denominator (random (ash 1 63)))
          (sign  (if (zerop (random 2)) 1 -1))
          (trial (float (/ (* sign numerator) denominator)))
          (rat (rationalize trial)))
      (when (not (= (float rat) trial))
        (error "Rationalize failed. Input ~s Rational ~s Float ~s" trial rat (float rat))))))

; smallest fails in 3.0 - powers of 2 - works here but we cheat a bit
(defun testrat2 ()
  (let ((f least-positive-double-float))
    (dotimes (i 100)
      (when (not (= (float (rationalize f)) f))
        (cerror "a" "rat failed ~s ~s" f i))
      (setq f (* f 2)))))

; fails a lot in 3.0 - not powers of 2 - works here
(defun testrat3 ()
  (let ((f least-positive-double-float))
    (dotimes (i 1000)
      (let ((f2 (* (+ i i 1) f)))
        (when (not (= (float (rationalize f2)) f2))
          (cerror "a" "rat failed ~s ~s" f2 i)))))
  (let ((f least-negative-double-float))
    (dotimes (i 1000)
      (let ((f2 (* (+ i i 1) f)))
        (when (not (= (float (rationalize f2)) f2))
          (cerror "a" "rat failed ~s ~s" f2 i))))))

(defun testrat31 ()
  (let ((f least-positive-short-float))
    (dotimes (i 1000)
      (let ((f2 (* (+ i i 1) f)))
        (when (not (= (float (rationalize f2)) f2))
          (cerror "a" "rat failed ~s ~s" f2 i)))))
  (let ((f least-negative-short-float))
    (dotimes (i 1000)
      (let ((f2 (* (+ i i 1) f)))
        (when (not (= (float (rationalize f2)) f2))
          (cerror "a" "rat failed ~s ~s" f2 i))))))

; works in 3.0 - and here
(defun testrat4 ()
  (let ((f least-positive-normalized-double-float))
    (dotimes (i 1000)
      (let ((f2 (* (+ i i 1) f)))
        (when (not (= (float (rationalize f2)) f2))
          (cerror "a" "rat failed ~s ~s" f2 i)))))
  (let ((f least-negative-normalized-double-float))
    (dotimes (i 100)
      (let ((f2 (* (+ i i 1) f)))
        (when (not (= (float (rationalize f2)) f2))
          (cerror "a" "rat failed ~s ~s" f2 i))))))
        
    
|#

#| now in l1-numbers.lisp
(defun logeqv (&lexpr numbers)
  (let* ((count (%lexpr-count numbers)))
    (declare (fixnum count))
    (if (zerop count)
      -1
      (let* ((n0 (%lisp-word-ref numbers count)))
        (if (= count 1)
          (require-type n0 'integer)
          (do* ((i 1 (1+ i)))
               ((= i count) n0)
            (declare (fixnum i))
            (declare (optimize (speed 3) (safety 0)))
            (setq n0 (logeqv-2 (%lexpr-ref numbers count i) n0))))))))
|#


(defparameter *boole-ops* 
  (vector
   #'(lambda (i1 i2) (declare (ignore i1 i2)) 0)
   #'(lambda (i1 i2) (declare (ignore i1 i2)) -1)
   #'(lambda (i1 i2) (declare (ignore i2)) i1)
   #'(lambda (i1 i2) (declare (ignore i1)) i2)
   #'(lambda (i1 i2) (declare (ignore i2)) (lognot i1))
   #'(lambda (i1 i2) (declare (ignore i1)) (lognot i2))
   #'(lambda (i1 i2) (logand i1 i2))
   #'(lambda (i1 i2) (logior i1 i2))
   #'(lambda (i1 i2) (logxor i1 i2))
   #'(lambda (i1 i2) (logeqv i1 i2))
   #'(lambda (i1 i2) (lognand i1 i2))
   #'(lambda (i1 i2) (lognor i1 i2))
   #'(lambda (i1 i2) (logandc1 i1 i2))
   #'(lambda (i1 i2) (logandc2 i1 i2))
   #'(lambda (i1 i2) (logorc1 i1 i2))
   #'(lambda (i1 i2) (logorc2 i1 i2))))
 


;===> Change these constants to match maclisp!!
(defun boole (op integer1 integer2)
  (unless (and (typep op 'fixnum)
               (locally (declare (fixnum op))
                 (and (>= op 0)
                      (<= op 15))))
    (report-bad-arg op '(integer 0 16)))
  (funcall (%svref *boole-ops* op) integer1 integer2))


(defun %integer-power (b e)
  (declare (type unsigned-byte e))
  (if (zerop e)
    (+ 1 (* b 0))
    (if (eql b 2)
      (ash 1 e)
      (if (and (eql b 10)(fixnump e))
        (let ((res (10-to-e e)))
          (if (and (bignump res)(< e 335))(copy-bignum res) res))  ;; do we need the copy?
        (do* ((next (ash e -1) (ash e -1))
              (oddexp (oddp e) (oddp e))
              (total (if oddexp b 1)(if oddexp (if (eq total 1) b (* b total)) total)))
             ((zerop next) total)
          (declare (type unsigned-byte next))
          (setq b (* b b) e next))))))

(defun signum (x)
  (cond ((complexp x) (cis (phase x)))
        ((rationalp x) (if (plusp x) 1 (if (zerop x) 0 -1)))
        ((zerop x) (float 0.0 x))
        (t (float-sign x))))



; Thanks to d34676@tansei.cc.u-tokyo.ac.jp (Akira KURIHARA)
(defun isqrt (n &aux n-len-quarter n-half n-half-isqrt
                init-value iterated-value)
  "argument n must be a non-negative integer"
  (cond
   ((eql n 0) 0)
   ; this fails sometimes - do we care? 70851992595801818865024053174 or #x80000000
   ; maybe we do - its used by dotimes
   ;((not (int>0-p n)) (report-bad-arg n '(integer 0))) ;'unsigned-byte)) ; Huh?
   ((or (not (integerp n))(minusp n))(report-bad-arg n '(integer 0)))
   ((> n 24)		; theoretically (> n 7) ,i.e., n-len-quarter > 0
    (setq n-len-quarter (ash (integer-length n) -2))
    (setq n-half (ash n (- (ash n-len-quarter 1))))
    (setq n-half-isqrt (isqrt n-half))
    (setq init-value (ash (1+ n-half-isqrt) n-len-quarter))
    (loop
      (setq iterated-value (ash (+ init-value (floor n init-value)) -1))
      (if (not (< iterated-value init-value))
        (return init-value)
        (setq init-value iterated-value))))
   ((> n 15) 4)
   ((> n  8) 3)
   ((> n  3) 2)
   (t 1)))


(defun sinh (x)
  (if (complexp x) 
    (/ (- (exp x) (exp (- x))) 2)
    (with-ppc-stack-double-floats ((dx x))
      (if (typep x 'short-float)
        (with-ppc-stack-double-floats ((res))
          (%double-float-sinh! dx res)
          (%short-float res (%make-sfloat)))
        (%double-float-sinh! dx (%make-dfloat))))))


(defun cosh (x)
  (if (complexp x) 
    (/ (+ (exp x) (exp (- x))) 2) 
    (with-ppc-stack-double-floats ((dx x))
      (if (typep x 'short-float)
        (with-ppc-stack-double-floats ((res))
          (%double-float-cosh! dx res)
          (%short-float res (%make-sfloat)))
        (%double-float-cosh! dx (%make-dfloat))))))

(defun tanh (x)
  (if (complexp x) 
    (/ (sinh x) (cosh x)) 
    (with-ppc-stack-double-floats ((dx x))
      (if (typep x 'short-float)
        (with-ppc-stack-double-floats ((res))
          (%double-float-tanh! dx res)
          (%short-float res (%make-sfloat)))
        (%double-float-tanh! dx (%make-dfloat))))))

(defun asinh (x)
  (if (complexp x) 
    (log (+ x (sqrt (+ 1 (* x x))))) 
    (with-ppc-stack-double-floats ((dx x))
      (if (typep x 'short-float)
        (with-ppc-stack-double-floats ((res))
          (%double-float-asinh! dx res)
          (%short-float res (%make-sfloat)))
        (%double-float-asinh! dx (%make-dfloat))))))

(defun acosh (x)
  (if (and (realp x) (<= 1.0 x)) 
    (with-ppc-stack-double-floats ((dx x))
      (if (typep x 'short-float)
        (with-ppc-stack-double-floats ((res))
          (%double-float-acosh! dx res)
          (%short-float res (%make-sfloat)))
        (%double-float-acosh! dx (%make-dfloat))))
    (* 2 (log (+ (sqrt (/ (1+ x) 2)) (sqrt (/ (1- x) 2)))))))

(defun atanh (x)
  (if (and (realp x) (<= -1.0 (setq x (float x)) 1.0)) 
    (with-ppc-stack-double-floats ((dx x))
      (if (typep x 'short-float)
        (with-ppc-stack-double-floats ((res))
          (%double-float-atanh! dx res)
          (%short-float res (%make-sfloat)))
        (%double-float-atanh! dx (%make-dfloat))))
    (/ (log (/ (+ 1 x) (- 1 x))) 2)))


(defun ffloor (number &optional divisor)
  (multiple-value-bind (q r) (floor number divisor)
    (values (float q (if (floatp r) r 0.0)) r)))

(defun fceiling (number &optional divisor)
  (multiple-value-bind (q r) (ceiling number divisor)
    (values (float q (if (floatp r) r 0.0)) r)))

(defun ftruncate (number &optional divisor)
  (multiple-value-bind (q r) (truncate number divisor)
    (values (float q (if (floatp r) r 0.0)) r)))

(defun fround (number &optional divisor)
  (multiple-value-bind (q r) (round number divisor)
    (values (float q (if (floatp r) r 0.0)) r)))

(defun rational (number)
  (if (floatp number)
      (multiple-value-bind (s e sign) (integer-decode-float number)
         (if (eq sign -1) (setq s (- s)))
         (if (%iminusp e) (/ s (ash 1 (%i- 0 e))) (ash s e)))
    (if (rationalp number) number
      (report-bad-arg number 'real))))

; make power tables for floating point reader
(progn
  (setq float-powers-of-5 (make-array 23))
  (let ((array float-powers-of-5))
    (dotimes (i 23)
      (setf (svref array i)  (float (expt 5 i)))))
  (setq integer-powers-of-5 (make-array (+ 12 (floor 324 12))))
  (let ((array integer-powers-of-5))
    (dotimes (i 12)
      (setf (svref array i)  (expt 5 i)))
    (dotimes (i (floor 324 12))
      (setf (svref array (+ i 12)) (expt 5 (* 12 (1+ i)))))))

;;;  from patch fp-formats.lisp
;;; 2003-03-17TA - Pulled out from old ff-source.lisp file 
;;; these work - the rest of ff-source does not



(defun %float2x (float ptr)
  (rlet ((float-ptr :double-float))
    (%put-double-float float-ptr float)
    (#_dtox80 float-ptr ptr))
  ptr)



(defun %x2float (ptr float-ptr)
  (let ((float (%make-dfloat)))
    (declare (dynamic-extent float))
    (%x2float-internal ptr float)
    (%put-double float float-ptr))
  float-ptr)

(defun %get-x2float (ptr)
  (%x2float-internal ptr (%make-dfloat)))

(defun %x2float-internal (ptr float)
  (%setf-double-float float (#_x80tod ptr))
  (%df-check-exception-1 '%x2float ptr)
  float)

; Copies the full 12 bytes of an extended to a pointer.
(defun %float2x12 (float ptr)
  (%float2x float ptr)
  (setf (%get-word ptr 10) (%get-word ptr 8)
        (%get-word ptr 8) (%get-word ptr 6)
        (%get-word ptr 6) (%get-word ptr 4)
        (%get-word ptr 4) (%get-word ptr 2)
        (%get-word ptr 2) 0)
  ptr)




(defun %put-double (flt ptr)
  (%copy-ivector-to-ptr flt (* 4 ppc::double-float.value-cell) ptr 0 8))

; Sounds like a bad idea to me ...
(defun %get-double (ptr flt)
  (%copy-ptr-to-ivector ptr 0 flt (* 4 ppc::double-float.value-cell) 8))












    


(provide 'numbers)

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
