;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;
;; float - leans toward single-float
;; fix truncate of most-negative-fixnum
;; collect is now in :ccl package
;; ----- 5.2b6
;; 11/14/03 Replacing MCRXR with (MTXER rzero)
;; fix truncate and truncate-no-rem for most-negative-fixnum
;; -------- 5.0 final
;; %bignum-random - lost the 1 bit holes on 32 bit boundaries
;; ------ 4.3.1
;; perhaps silly space optimization in byte-mask for a few values of size
;; 02/10/99 akh move init-random-state-seeds to l1;ppc;l1-numbers - to do lmgeticks the p.c. way
;; ------- 4.3
;;  7 6/2/97   akh  stuff re Nans
;;  5 3/17/97  akh  fix sign of integer-decode-short-float
;;  4 3/14/97  akh  integer-decode-float, truncate-no-rem from gb
;;  50 1/22/97 akh  fix fixnum-abs macro
;;                  (zerop foo) => (eql foo 0) when foo known fixnum, added (unused) hairy-rem
;;                  and lots more small optimizations
;;  48 9/26/96 akh  gcd-2 calls new integer-gcd
;;  45 7/18/96 akh  fix gcd-2 for most-negative-fixnum, two-arg-+/- for minus, x real, y complex
;;  43 6/16/96 akh  hookup truncate-no-rem with runtime test for multiple-values expected
;;  41 6/7/96  akh  no rem and no quo versions of truncate
;;                  %fixnum-round, floor, ceiling
;;                  rem calls no quo truncate for bignum
;;  40 5/20/96 akh  logbitp fixnum if count >= 28 or so, denominator (aargh)
;;  39 4/19/96 akh  ash fixnum right lots
;;  37 4/1/96  akh  phase too
;;  36 4/1/96  akh  log, exp, revert canonical-complex, fixnum-float-compare again
;;  35 3/29/96 akh  fix fixnum-float-compare
;;  33 3/27/96 akh  lots of bug fixes
;;  32 3/16/96 akh  fix fixnum-float-compare for big floats, negative
;;  30 3/9/96  akh  fix minusp for bignum
;;  29 2/19/96 akh  nuke uses of numeric-dispatch - it did wrong for complex
;;                  on &optional (divisor 1) - explicitly check for nil instead because sometimes nil is passed
;;  28 2/19/96 akh  fix *-2 when first arg is ratio
;;                  divide by zero - call error vs missing uuo
;;                  fix some complex stuff
;;  26 2/6/96  akh  dont need negate-complex, lose some number-dispatch, add %quo-1, %hypot
;;  25 1/28/96 Alice Hartley dfloat-rat and rat-dfloat pass new allocated result to %double-float
;;  22 1/2/96  akh  non consing logtest, logand, logandc1, logandc2 of fixnum and big for positive fixnum
;;                  Fix bug in bignum-replace if from-end
;;                  Fix gcd-2 - (abs n2) when n1 = 0.
;;                  two-arg+/- Make less garbage if one arg is a float
;;                  Truncate make less garbage if one arg is a float.
;;                  comparisons of float and rational no longer make a rational from the float.
;;  20 12/24/95 akh %floor and a caller thereof fixed. Logbitp more sensible.
;;                  fixnum-*-2 works. Added macros number-case, with-small-bignum-buffers
;;  19 12/12/95 akh fixnum-*-2 handles overflow to big itself - vs unimplemented or not working uuo
;;  16 11/22/95 akh see below, gcd-2, unary-round etc.
;;  15 11/19/95 gb  <=-2, >=-2 : different from >, <; abs parenthesization
;;  14 11/14/95 akh abs is more specific
;;  12 11/13/95 akh put back the macros because "ccl:compiler;ppc;number-macros" does not appear to exist
;;                  signum for bignum as well as fixnum
;;                  %double-float to ppc-float
;;                  rename something to %fixnum-intlen
;;  10 11/7/95 akh  move integer-decode-double-float to ppc-float
;;  7 10/26/95 akh  damage control
;;  7 10/26/95 gb   not sure what changed
;;  3 10/7/95  slh  merged in misc. changes
;;  (do not edit before this line!!)

; Modification History
; fix truncate for most-negative-fixnum/1
;; once-only, collect now in ccl package
; ----- 5.2b6
; 03/03/99 akh %bignum-random - NEVER return stack-allocated dividend
; 01/31/99 akh fixnum-sfloat-compare was brain dead
; 12/15/98 akh truncate-no-rem for short float again
; 07/31/98 akh random uses %bignum-random when n > 256 vs 65536    
; 11/30/97 akh  truncate-no-rem forgot about short floats for first arg
; 05/01/97 akh integer-decode-short-float - no error if nan and invalid-operation allowed so can print em (of dubious value?)
; 05/27/97 bill %next-random-seed now returns 0 <= x < 65536 instead of 0 <= x < 32768
; ------------  4.1
; 03/15/97 akh fix sign of integer-decode-short-float (1 and -1 vs 0 and 1)
; 03/14/97 akh /=-2 for short float by the simple expedient of (not (=-2 ..)) from gb
; 03/13/97 akh fix integer-decode-short-float, truncate-no-rem from gb
; 03/01/97 gb   lots-o-changes for short float; still some sins of omission.
; 02/04/97 bill Doug Currie's fix to %next-random-seed as sent out
;               by Duncan Smith.
; akh fix fixnum-abs macro
; akh some (zerop foo) => (eql foo 0) when foo known fixnum, added (unused) hairy-rem
;; and lots more small optimizations
; 10/28/96 bill random now signals an error if its arg is less than 0
; ------------- 4.0
; 08/28/96 bill init-random-state-seeds now left shifts its results appropriately
; ------------  4.0b1
; 07/22/96 gb   don't say truly-the anymore. Bill's fix to >=-2 fixnum/rat case.
; akh fix gcd-2 for most-negative-fixnum, two-arg-+/- for minus, x real, y complex
; 06/22/96 bill %dfloat-hwords no longer clobbers temp0 before using it.
; akh %fixnum-truncate of most-negative-fixnum and -1 gotta box a bignum 
; akh - logbitp fixnum if count >= 28 or so, denominator (aargh)
; -------------  MCL-PPC 3.9
; 04/19/96 akh  fix ash of fixnum right a lot.
; 04/07/96 akh  %fixnum-truncate returned bogus-object for remainder when x = (lognot (1- (ash 1 29)))
; 03/28/96 bill  from Alice: in canonical-complex: (eql imagpart 0) => (= imagpart 0)
;                in complex: %make-complex => canonical-complex
; 03/25/96 bill  call new divide-by-zero-error from %fixnum-truncate and the ratio/integer
;                case of /-2.
; 03/10/06 gb    use zero-fp-reg; some double-float stuff in lisp.
; 02/05/96 bill  Make %next-random-seed more like the old 68K random.
;                In particular, it now has a much larger period.
;                %bignum-random, %double-float-random
;                Cons less in %hypot.
; 01/19/96 gb    fixnum-float-compare (check this.) (>= bignum bignum) was wrong (check
;                others).
; 01/09/95 bill  fix %next-random-seed
; 12/27/95 gb    %make-complex/ratio: forget pad cell value.
; 12/06/95 slh   %make-complex/ratio: forgot pad cell value; %make-d/sfloat -> number-macros.lisp
;                 use number-macros, it's checked in now; don't need boole here
; 11/21/95 akh   gcd-2 defined - uses bignum-gcd for fixnums too! fix later, round don't make ratio foo/2 for thresh
; 11/20/95 akh   ash - don't say most-positive-fixnum, %unary-round - dont loop forever and don't say most-positive-fixnum
; 11/10/95 gb    minusp ratio typo; %fixnum-*-2.
; 11/02/95 slh   Gary's random fns & fixes to truncate, logbitp.
; 10/19/95 slh   cosmetic mod.
; 10/16/95 gb    several fixes
;;;
;;; level-0;ppc;ppc-numbers.lisp

; Copyright 1995-1999 Digitool, Inc.

;(in-package "CCL")

;(push (cons 'number-case 1) *fred-special-indent-alist*) do later

(eval-when (:compile-toplevel :execute)
  (require "PPC-ARCH")
  (defconstant ppc::nfulltagbits ppc::ntagbits)
  (require "PPC-LAPMACROS")
  (require "LISPEQU")
  (require "NUMBER-MACROS")
  (require "NUMBER-CASE-MACRO")

(defmacro fixnum-to-bignum-set (fix big)
  (once-only ((fixv fix))
    `(%bignum-set ,big 0 (%ilogand (%iasr 16 ,fixv) #xffff) (%ilogand ,fixv #xffff))))

(defmacro with-small-bignum-buffers (specs &body body)
  (collect ((binds)
            (inits)
            (names))
    (dolist (spec specs)
      (let ((name (first spec)))
        (binds `(,name (%alloc-misc 1 ppc::subtag-bignum)))
        (names name)
        (let ((init (second spec)))
          (when init
            (inits `(fixnum-to-bignum-set ,init ,name))))))
    `(let* ,(binds)
       (declare (dynamic-extent ,@(names)))
       ,@(inits)
       ,@body)))

(defvar *dfloat-dops* '((* . %double-float*-2!)(/ . %double-float/-2!)
                        (+ . %double-float+-2!)(- . %double-float--2!)))

(defvar *sfloat-dops* '((* . %short-float*-2!)(/ . %short-float/-2!)
                        (+ . %short-float+-2!)(- . %short-float--2!)))

(defmacro dfloat-rat (op x y &optional (destructive-op (cdr (assq op *dfloat-dops*))))
  (if destructive-op
    (let ((f2 (gensym)))
      `(let ((,f2 (%double-float ,y (%make-dfloat))))
         (,destructive-op ,x ,f2 ,f2)))          
    `(,op (the double-float ,x) (the double-float (%double-float ,y)))))

(defmacro rat-dfloat (op x y &optional (destructive-op (cdr (assq op *dfloat-dops*))))
  (if destructive-op
    (let ((f1 (gensym)))
      `(let ((,f1 (%double-float ,x (%make-dfloat)))) 
         (,destructive-op ,f1 ,y ,f1)))
    `(,op (the double-float (%double-float ,x)) (the double-float ,y))))

(defmacro sfloat-rat (op x y &optional (destructive-op (cdr (assq op *sfloat-dops*))))
  (if destructive-op
    (let ((f2 (gensym)))
      `(let ((,f2 (%short-float ,y (%make-sfloat)))) 
         (,destructive-op ,x ,f2 ,f2)))
    `(,op (the short-float ,x) (the short-float (%short-float ,y)))))

(defmacro rat-sfloat (op x y &optional (destructive-op (cdr (assq op *sfloat-dops*))))
  (if destructive-op
    (let ((f1 (gensym)))
      `(let ((,f1 (%short-float ,x (%make-sfloat)))) 
         (,destructive-op ,f1 ,y ,f1)))
    `(,op (the short-float (%short-float ,x)) (the short-float ,y))))


  
(defmacro two-arg-+/- (name op big-op)
  `(defun ,name (x y)     
     (number-case x
       (fixnum (number-case y
                 (fixnum (,op (the fixnum x) (the fixnum y)))
                 (double-float (rat-dfloat ,op x y))
                 (short-float (rat-sfloat ,op x y))
                 (bignum (with-small-bignum-buffers ((bx x))
                           (,big-op bx y)))
                 (complex (complex (,op x (%realpart y))
                                   ,(if (eq op '-)`(- (%imagpart y)) `(%imagpart y))))
                 (ratio (let* ((dy (%denominator y)) 
                               (n (,op (* x dy) (%numerator y))))
                          (%make-ratio n dy)))))
       (double-float (number-case y
                       (double-float (,op (the double-float x) (the double-float y)))
                       (short-float (with-ppc-stack-double-floats ((dy y))
                                      (,op (the double-float x) (the double-float dy))))
                       (rational (dfloat-rat ,op x y))
                       (complex (complex (,op x (%realpart y)) 
                                         ,(if (eq op '-)`(- (%imagpart y)) `(%imagpart y))))))
       (short-float (number-case y                                
                      (short-float (,op (the short-float x) (the short-float y)))
                      (double-float (with-ppc-stack-double-floats ((dx x))
                                      (,op (the double-float dx) (the double-float y))))
                      (rational (sfloat-rat ,op x y))
                      (complex (complex (,op x (%realpart y))
                                        ,(if (eq op '-) `(- (%imagpart y)) `(%imagpart y))))))
       (bignum (number-case y
                 (bignum (,big-op x y))
                 (fixnum (with-small-bignum-buffers ((by y))
                           (,big-op x by)))
                 (double-float (rat-dfloat ,op x y))
                 (short-float (rat-sfloat ,op x y))
                 (complex (complex (,op x (realpart y)) 
                                   ,(if (eq op '-)`(- (%imagpart y)) `(%imagpart y))))
                 (ratio
                  (let* ((dy (%denominator y))
                         (n (,op (* x dy) (%numerator y))))
                    (%make-ratio n dy)))))
       (complex (number-case y
                  (complex (canonical-complex (,op (%realpart x) (%realpart y))
                                              (,op (%imagpart x) (%imagpart y))))
                  ((rational float) (complex (,op (%realpart x) y) (%imagpart x)))))
       (ratio (number-case y
                (ratio
                 (let* ((nx (%numerator x))
                        (dx (%denominator x))
                        (ny (%numerator y))
                        (dy (%denominator y))
                        (g1 (gcd dx dy)))
                   (if (eql g1 1)
                     (%make-ratio (,op (* nx dy) (* dx ny)) (* dx dy))
                     (let* ((t1 (,op (* nx (truncate dy g1)) (* (truncate dx g1) ny)))
                            (g2 (gcd t1 g1))
                            (t2 (truncate dx g1)))
                       (cond ((eql t1 0) 0)
                             ((eql g2 1) (%make-ratio t1 (* t2 dy)))
                             (t
                              (let* ((nn (truncate t1 g2))
                                     (t3 (truncate dy g2))
                                     (nd (if (eql t2 1) t3 (* t2 t3))))
                                (if (eql nd 1) nn (%make-ratio nn nd)))))))))
                (integer
                 (let* ((dx (%denominator x)) (n (,op (%numerator x) (* y dx))))
                   (%make-ratio n dx)))
                (double-float (rat-dfloat ,op x y))
                (short-float (rat-sfloat ,op x y))
                (complex (complex (,op x (%realpart y)) 
                                  ,(if (eq op '-)`(- (%imagpart y)) `(%imagpart y)))))))))

(declaim (inline  %make-complex %make-ratio))
(declaim (inline canonical-complex))
(declaim (inline build-ratio))
(declaim (inline maybe-truncate))
)

(defun %make-complex (realpart imagpart)
  (gvector :complex realpart imagpart))

(defun %make-ratio (numerator denominator)
  (gvector :ratio numerator denominator))
 


; this is no longer used
(defun %integer-signum (num)
  (if (fixnump num)
    (%fixnum-signum num)
    ; there is no such thing as bignum zero we hope
    (if (bignum-minusp num) -1 1)))

(defppclapfunction %fixnum-signum ((number arg_z))
  (cmpwi :cr0 number '0)
  (li arg_z '0)
  (beqlr :cr0)
  (li arg_z '1)               ; assume positive
  (bgtlr :cr0)
  (li arg_z '-1)
  (blr))

; see %logcount (ppc-bignum.lisp)
(defppclapfunction %ilogcount ((number arg_z))
  (let ((arg imm0)
        (shift imm1)
        (temp imm2))
    (unbox-fixnum arg number)
    (mr. shift arg)
    (li arg_z 0)
    (if ne
      (progn
        @loop
        (la temp -1 shift)
        (and. shift shift temp)
        (la arg_z '1 arg_z)
        (bne @loop)))
    (blr)))

(defppclapfunction %iash ((number arg_y) (count arg_z))
  (unbox-fixnum imm0 number)
  (unbox-fixnum imm1 count)
  (neg. imm2 imm1)
  (blt @left)
  (sraw imm0 imm0 imm2)
  (box-fixnum arg_z imm0)
  (blr)
  @left
  (slw arg_z number imm1)
  (blr))

(defparameter *double-float-zero* 0.0d0)
(defparameter *short-float-zero* 0.0s0)

(defppclapfunction %short-float-plusp ((number arg_z))
  (get-single-float fp0 number)
  (fcmpo :cr1 fp0 ppc::fp-zero)
  (setpred arg_z :cr1 :gt)
  (blr))

(defppclapfunction %double-float-plusp ((number arg_z))
  (get-double-float fp0 number)
  (fcmpo :cr1 fp0 ppc::fp-zero)
  (setpred arg_z :cr1 :gt)
  (blr))

(defppclapfunction %sfloat-hwords ((sfloat arg_z))
  (lwz imm0 ppc::single-float.value sfloat)
  (digit-h temp0 imm0)
  (digit-l temp1 imm0)
  (vpush temp0)
  (vpush temp1)
  (la temp0 8 vsp)
  (set-nargs 2)
  (ba .SPvalues))

; used by fasl-dump-dfloat
(defppclapfunction %dfloat-hwords ((dfloat arg_z))
  (lwz imm0 ppc::double-float.value dfloat)
  (lwz imm1 ppc::double-float.val-low dfloat)
  (digit-h temp0 imm0)
  (digit-l temp1 imm0)
  (digit-h temp2 imm1)
  (digit-l temp3 imm1)
  (vpush temp0)
  (vpush temp1)
  (vpush temp2)
  (vpush temp3)
  (la temp0 16 vsp)
  (set-nargs 4)
  (ba .SPvalues))

; (integer-length arg) = (- 32 (cntlz (if (>= arg 0) arg (lognot arg))))
(defppclapfunction %fixnum-intlen ((number arg_z))  
  (unbox-fixnum imm0 arg_z)
  (cntlzw. imm1 imm0)  ; testing result of cntlzw? - ah no zeros if neg
  (bne @nonneg)
  (not imm1 imm0)
  (cntlzw imm1 imm1)
  @nonneg
  (subfic imm1 imm1 32)
  (box-fixnum arg_z imm1)
  (blr))

; Destructive primitives.
(macrolet ((defdestructive-df-op (non-destructive-name destructive-name op)
             `(progn
                (defun ,non-destructive-name (x y)
                  (,destructive-name x y (%make-dfloat)))
                (defun ,destructive-name (x y result)
                  (declare (double-float x y result))
                  (%setf-double-float result (the double-float (,op x y)))))))
  (defdestructive-df-op %double-float+-2 %double-float+-2! +)
  (defdestructive-df-op %double-float--2 %double-float--2! -)
  (defdestructive-df-op %double-float*-2 %double-float*-2! *)
  (defdestructive-df-op %double-float/-2 %double-float/-2! /))

(macrolet ((defdestructive-sf-op (non-destructive-name destructive-name op)
             `(progn
                (defun ,non-destructive-name (x y)
                  (,destructive-name x y (%make-sfloat)))
                (defun ,destructive-name (x y result)
                  (declare (short-float x y result))
                  (%setf-short-float result (the short-float (,op x y)))))))
  (defdestructive-sf-op %short-float+-2 %short-float+-2! +)
  (defdestructive-sf-op %short-float--2 %short-float--2! -)
  (defdestructive-sf-op %short-float*-2 %short-float*-2! *)
  (defdestructive-sf-op %short-float/-2 %short-float/-2! /))



(defppclapfunction %double-float-negate! ((src arg_y) (res arg_z))
  (get-double-float fp0 src)
  (fneg fp1 fp0)
  (put-double-float fp1 res)
  (blr))

(defppclapfunction %short-float-negate! ((src arg_y) (res arg_z))
  (get-single-float fp0 src)
  (fneg fp1 fp0)
  (put-single-float fp1 res)
  (blr))

(defun %negate (x)
  (number-case x
    (fixnum  (- (the fixnum x)))
    (double-float  (%double-float-negate! x (%make-dfloat)))
    (short-float (%short-float-negate! x (%make-sfloat)))
    (bignum (negate-bignum x))
    (ratio (%make-ratio (%negate (%numerator x)) (%denominator x)))
    (complex (%make-complex (%negate (%realpart X))(%negate (%imagpart X))) )))

; Caller guarantees that result fits in a fixnum.
(defppclapfunction %truncate-double-float->fixnum ((arg arg_z))
  (get-double-float fp0 arg)
  (fctiwz fp0 fp0)
  (stfd fp0 -8 sp)
  (lwz imm0 (+ -8 4) sp)
  (box-fixnum arg_z imm0)  
  (blr))

(defppclapfunction %truncate-short-float->fixnum ((arg arg_z))
  (get-single-float fp0 arg)
  (fctiwz fp0 fp0)
  (stfd fp0 -8 sp)
  (lwz imm0 (+ -8 4) sp)
  (box-fixnum arg_z imm0)  
  (blr))

; DOES round to even
(defppclapfunction %round-nearest-double-float->fixnum ((arg arg_z))
  (get-double-float fp0 arg)
  (fctiw fp0 fp0)
  (stfd fp0 -8 sp)
  (lwz imm0 (+ -8 4) sp)
  (box-fixnum arg_z imm0)  
  (blr))

(defppclapfunction %round-nearest-short-float->fixnum ((arg arg_z))
  (get-single-float fp0 arg)
  (fctiw fp0 fp0)
  (stfd fp0 -8 sp)
  (lwz imm0 (+ -8 4) sp)
  (box-fixnum arg_z imm0)  
  (blr))






; #-PPC IN L1-NUMBERS.LISP (single vs. short)


(defun zerop (number)
  (number-case number
    (integer (eq number 0))
    (short-float (%short-float-zerop number))
    (double-float (%double-float-zerop number))
    (ratio nil)
    (complex
     (number-case (%realpart number)
       (short-float (and (%short-float-zerop (%realpart number))
                         (%short-float-zerop (%imagpart number))))
       (double-float (and (%double-float-zerop (%realpart number))
                          (%double-float-zerop (%imagpart number))))
       (t (and (eql 0 (%realpart number))(eql 0 (%imagpart number))))))))
               


; #-PPC IN L1-NUMBERS.LISP (single vs. short)

(defun plusp (number)
  (number-case number
    (fixnum (%i> number 0))
    (bignum (bignum-plus-p number))
    (short-float (%short-float-plusp number))
    (double-float (%double-float-plusp number))
    (ratio (plusp (%numerator number)))))
    

; #-PPC IN L1-NUMBERS.LISP (single vs. short)
(defun minusp (number)
  (number-case number
    (fixnum (%i< number 0))
    (bignum (bignum-minusp number))
    (double-float (%double-float-minusp number))
    (short-float (%short-float-minusp number))
    (ratio (minusp (%numerator number)))))


(defun oddp (n)
  (case (ppc-typecode n)
    (#.ppc::tag-fixnum (logbitp 0 (the fixnum n)))
    (#.ppc::subtag-bignum (%bignum-oddp n))
    (t (report-bad-arg n 'integer))))

(defun evenp (n)
  (case (ppc-typecode n)
    (#.ppc::tag-fixnum (not (logbitp 0 (the fixnum n))))
    (#.ppc::subtag-bignum (not (%bignum-oddp n)))
    (t (report-bad-arg n 'integer))))



;; expansion slightly changed
(defun =-2 (x y)
  (number-case x
    (fixnum (number-case y
              (fixnum (eq x y))
              (double-float (eq 0 (fixnum-dfloat-compare x y)))
              (short-float (eq 0 (fixnum-sfloat-compare x y)))
              ((bignum ratio) nil)
              (complex (and (zerop (%imagpart y)) (= x (%realpart y))))))
    (double-float (number-case y ; x
                    (double-float (= (the double-float x)(the double-float y))) ;x 
                    (short-float (with-ppc-stack-double-floats ((dy y))
                                   (= (the double-float x) (the double-float dy))))
                    (fixnum (eq 0 (fixnum-dfloat-compare  y x)))
                    (bignum (eq 0 (bignum-dfloat-compare y x)))
                    (ratio (= (rational x) y))
                    (complex (and (zerop (%imagpart y)) (= x (%realpart y))))))
    (short-float (number-case y
                   (short-float (= (the short-float x) (the short-float y)))
                   (double-float (with-ppc-stack-double-floats ((dx x))
                                   (= (the double-float dx) (the double-float y))))
                   (fixnum (eq 0 (fixnum-sfloat-compare y x)))
                   (bignum (eq 0 (bignum-sfloat-compare y x)))
                   (ratio (= (rational x) y))
                   (complex (and (zerop (%imagpart y)) (= x (%realpart y))))))
    (bignum (number-case y 
              (bignum (eq 0 (bignum-compare x y)))
              ((fixnum ratio) nil)
              (double-float (eq 0 (bignum-dfloat-compare x y)))
              (short-float (eq 0 (bignum-sfloat-compare x y)))
              (complex (and (zerop (%imagpart y)) (= x (%realpart y))))))
    (ratio (number-case y
             (integer nil)
             (ratio
              (and (eql (%numerator x) (%numerator y))
                   (eql (%denominator x) (%denominator y))))
             (float (= x (rational y)))
             (complex (and (zerop (%imagpart y)) (= x (%realpart y))))))
    (complex (number-case y
               (complex (and (= (%realpart x) (%realpart y))
                             (= (%imagpart x) (%imagpart y))))
               ((float rational)
                (and (zerop (%imagpart x)) (= (%realpart x) y)))))))

(defun /=-2 (x y)
  (not (=-2 x y)))


; true iff (< x y) is false.
(defun >=-2 (x y)
  (not (< x y)))

(defun <=-2 (x y)
  (not (> x y)))

(defun <-2 (x y)
  (number-case x
    (fixnum (number-case y
              (fixnum (< (the fixnum x) (the fixnum y)))
              (double-float (eq -1 (fixnum-dfloat-compare x y)))
              (short-float (eq -1 (fixnum-sfloat-compare x y)))
              (bignum (bignum-plus-p y))
              (ratio (< x (ceiling (%numerator y)(%denominator y))))))
    (double-float (number-case y ; x
                    (double-float (< (the double-float x)(the double-float y))) ;x
                    (short-float (with-ppc-stack-double-floats ((dy y))
                                   (< (the double-float x) (the double-float dy))))
                    (fixnum (eq 1 (fixnum-dfloat-compare  y x)))
                    (bignum (eq 1 (bignum-dfloat-compare y x)))
                    (ratio (< (rational x) y))))
    (short-float (number-case y
                    (short-float (< (the short-float x) (the short-float y)))
                    (double-float (with-ppc-stack-double-floats ((dx x))
                                    (< (the double-float dx) (the double-float y))))
                    (fixnum (eq 1 (fixnum-sfloat-compare y x)))
                    (bignum (eq 1 (bignum-sfloat-compare y x)))
                    (ratio (< (rational x) y))))
    (bignum (number-case y 
              (bignum (EQ -1 (bignum-compare x y)))
              (fixnum (not (bignum-plus-p x)))
              (ratio (< x (ceiling (%numerator y)(%denominator y))))
              (double-float (eq -1 (bignum-dfloat-compare x y)))
              (short-float (eq -1 (bignum-sfloat-compare x y)))))
    (ratio (number-case y
             (integer (< (floor (%numerator x)(%denominator x)) y))
             (ratio
              (< (* (%numerator (the ratio x))
                    (%denominator (the ratio y)))
                 (* (%numerator (the ratio y))
                    (%denominator (the ratio x)))))
             (float (< x (rational y)))))))

(defun >-2 (x y)
  ;(declare (optimize (speed 3)(safety 0)))
  (number-case x
    (fixnum (number-case y
              (fixnum (> (the fixnum x) (the fixnum y)))
              (bignum (not (bignum-plus-p y)))
              (double-float (eq 1 (fixnum-dfloat-compare x y)))
              (short-float (eq 1 (fixnum-sfloat-compare x y)))
              ; or (> (* x denom) num) ?
              (ratio (> x (floor (%numerator y) (%denominator y))))))
    (double-float (number-case y
                    (double-float (> (the double-float x) (the double-float y)))
                    (short-float (with-ppc-stack-double-floats ((dy y))
                                   (> (the double-float x) (the double-float dy))))
                    (fixnum (eq -1 (fixnum-dfloat-compare  y x)))
                    (bignum (eq -1 (bignum-dfloat-compare y x)))
                    (ratio (> (rational x) y))))
    (short-float (number-case y
                    (short-float (> (the short-float x) (the short-float y)))
                    (double-float (with-ppc-stack-double-floats ((dx x))
                                   (> (the double-float dx) (the double-float y))))
                    (fixnum (eq -1 (fixnum-sfloat-compare  y x)))
                    (bignum (eq -1 (bignum-sfloat-compare y x)))
                    (ratio (> (rational x) y))))
    (bignum (number-case y
              (fixnum (bignum-plus-p x))
              (bignum (eq 1 (bignum-compare x y)))
              ; or (> (* x demon) num)
              (ratio (> x (floor (%numerator y) (%denominator y))))
              (double-float (eq 1 (bignum-dfloat-compare x y)))
              (short-float (eq 1 (bignum-sfloat-compare x y)))))
    (ratio (number-case y
             ; or (> num (* y denom))
             (integer (> (ceiling (%numerator x) (%denominator x)) y))
             (ratio
              (> (* (%numerator (the ratio x))
                    (%denominator (the ratio y)))
                 (* (%numerator (the ratio y))
                    (%denominator (the ratio x)))))
             (float (> x (rational y)))))))


;;;;;; fixnum and bignum compare with float without making a rational of the float
;;;
;;; only does double floats today

#|
(defun float-fraction-p (float exp)
  (multiple-value-bind (hi lo)(fixnum-decode-float float)
    (hi-lo-fraction-p hi lo exp)))
|#

; t if any bits set after exp (unbiased)
(defun hi-lo-fraction-p (hi lo exp)
  (declare (fixnum hi lo exp))
  (if (> exp 24)
    (not (eql 0 (%ilogand lo (%ilsr (- exp 25) #xfffffff))))
    (or (not (zerop lo))(not (eql 0 (%ilogand hi (%ilsr exp #x1ffffff)))))))

#|
(defun negate-hi-lo (hi lo)
  (let* ((nl (+ (lognot lo) 1))
         (nh (if (zerop lo) (+ (%ilognot hi) 1)(%ilognot hi))))
    (values (logand nh #x3ffffff) (logand #xfffffff nl))))
|#


(defun negate-hi-lo (hi lo)
  (setq hi (%ilogxor hi #x3ffffff))
  (if (eq 0 lo)    
    (setq hi (+ hi 1))
    (setq lo (+ (%ilogxor lo #xfffffff) 1)))
  (values hi lo))

(defun one-bignum-factor-of-two (a)  
  (declare (type bignum-type a))
  (let ((len (%bignum-length a)))
    (declare (fixnum len))
    (dotimes (i len)
      (multiple-value-bind (a-h a-l) (%bignum-ref a i)
        (declare (fixnum a-h a-l))
        (unless (and (= a-h 0)(= a-l 0))
          (return (+ (%ilsl 5 i)
                     (let* ((j 0)
                            (a a-l))
                       (declare (fixnum a j))
                       (if (= a-l 0) (setq j 16 a a-h))
                       (dotimes (i 16)            
                         (if (oddp a)
                           (return (%i+ j i))
                           (setq a (%iasr 1 a))))))))))))



#|
(defun fixnum-float-compare (int dfloat)
  (declare (fixnum int))
  (if (and (eq int 0)(= dfloat 0.0d0))
    0
    (let* ((fminus (%double-float-minusp dfloat))
           (iminus (< int 0))
           (exp (- (%double-float-exp dfloat) 1022)))
      (declare (fixnum exp))
      (if (neq fminus iminus)
        (if iminus -1 1)
        (if (and (<= 0 exp)
                 (<= exp (- 31 ppc::fixnumshift)))
          (let ((trunc-float (%truncate-double-float->fixnum dfloat)))
            (if (%i< int trunc-float) -1
                (if (%i> int trunc-float) 1                    
                    (if (not (float-fraction-p dfloat exp)) 0 (if iminus 1 -1)))))
          (if (<= exp 0) ; float little
            (if (or iminus (= 0 int)) -1 1)
            ; OR float big 
            (if fminus 1 -1)))))))
|#

;; gary's more better idea
(defun fixnum-dfloat-compare (int dfloat)
  (declare (double-float dfloat))
  (if (and (eq int 0)(eql dfloat 0.0d0))
    0
    (with-ppc-stack-double-floats ((tem int))
      (if (= tem dfloat)
        0
        (if (< tem dfloat) -1 1)))))

(defun fixnum-sfloat-compare (int sfloat)
  (declare (short-float sfloat))
  (if (and (eq int 0)(eql sfloat 0.0s0))
    0
    (with-ppc-stack-short-floats ((tem int))
      (if (= tem sfloat)
        0
        (if (< tem sfloat) -1 1)))))
        
; lotta stuff to avoid making a rational from a float
; returns -1 less, 0 equal, 1 greater
(defun bignum-dfloat-compare (int float)
  (cond 
   ((and (eq int 0)(= float 0.0d0)) 0)
   (t
    (let* ((fminus  (%double-float-minusp float))
           (iminus (minusp int))
           (gt (if iminus -1 1)))
      (declare (fixnum gt))
      (if (neq fminus iminus)
        gt  ; if different signs, done
        (let ((intlen (integer-length int)) 
              (exp (- (the fixnum (%double-float-exp float)) 1022)))
          (declare (fixnum intlen exp)) ; someday intlen may not be a fixnum - but is today
          ;(print (list intlen exp))
          (cond 
           ((and (not fminus) (< intlen exp)) -1)
           ((> intlen exp)  gt)   ; if different exp, done
           ((and fminus (or (< (1+ intlen) exp)
                            (and (= (1+ intlen) exp)
                                 (neq (one-bignum-factor-of-two int) intlen))))
            ;(print 'zow)
            (the fixnum (- gt)))  ; ; integer-length is strange for neg powers of 2            
           (t (multiple-value-bind (hi lo)(fixnum-decode-float float)
                (declare (fixnum hi lo)) 
                (when fminus (multiple-value-setq (hi lo)(negate-hi-lo hi lo)))
                (let* ((sz 26)  ; exp > 28 always
                       (pos (- exp 25))
                       (big-bits (%ldb-fixnum-from-bignum int sz pos)))
                  (declare (fixnum pos big-bits sz))
                  ;(print (list big-bits hi sz pos))
                  (cond 
                   ((< big-bits hi) -1)
                   ((> big-bits hi) 1)
                   (t (let* ((sz (min (- exp 25) 28))
                             (pos (- exp 25 sz)) ; ?
                             (ilo (if (< exp 53) (ash lo (- exp 53)) lo))                                    
                             (big-bits (%ldb-fixnum-from-bignum int sz pos)))
                        (declare (fixnum pos sz ilo big-bits))
                        ;(PRINT (list big-bits ilo))
                        (cond
                         ((< big-bits ilo) -1)
                         ((> big-bits ilo) 1)
                         ((eq exp 53) 0)
                         ((< exp 53)
                          (if (not (hi-lo-fraction-p hi lo exp)) 0 -1)) ; -1 if pos 
                         (t (if (%i< (one-bignum-factor-of-two int) (- exp 53)) 1 0)))))))
                )))))))))

; I don't know if it's worth doing a more "real" version of this.
(defun bignum-sfloat-compare (int float)
  (with-ppc-stack-double-floats ((df float))
    (bignum-dfloat-compare int df)))



;;;; Canonicalization utilities:

;;; CANONICAL-COMPLEX  --  Internal
;;;
;;;    If imagpart is 0, return realpart, otherwise make a complex.  This is
;;; used when we know that realpart and imagpart are the same type, but
;;; rational canonicalization might still need to be done.
;;;

(defun canonical-complex (realpart imagpart)
  (if (eql imagpart 0)
    realpart
    (%make-complex realpart imagpart)))


(two-arg-+/- +-2 + add-bignums)
(two-arg-+/- --2 - subtract-bignum)


;;; BUILD-RATIO  --  Internal
;;;
;;;    Given a numerator and denominator with the GCD already divided out, make
;;; a canonical rational.  We make the denominator positive, and check whether
;;; it is 1.
;;;

(defun build-ratio (num den)
  (if (minusp den)(setq num (- num) den (- den)))
  (if (eql den 1)
    num
    (%make-ratio num den)))


;;; MAYBE-TRUNCATE  --  Internal
;;;
;;;    Truncate X and Y, but bum the case where Y is 1.
;;;


(defun maybe-truncate (x y)
  (if (eql y 1)
    x
    (truncate x y)))

(defun %fixnum-*-2 (y z)
  (or (%%fixnum-*-2 y z)
      ; let this deal with making a 1 or 2 digit bignum
      (multiply-fixnums y z)))

; return fixnum if product fits else nil
(defppclapfunction %%fixnum-*-2 ((y arg_y) (z arg_z))
  (mtxer rzero) ;(mcrxr cr0)
  (unbox-fixnum imm0 z)
  (mullwo. imm1 y imm0)                 ; imm1 is fixnum-tagged
  (bso- cr0 @overflow)
  (mr arg_z imm1)
  (blr)
  @overflow
  (mr arg_z rnil)
  ;(uuo_multiply_fixnums arg_z y z)      ; NYI
  (blr))
  
(defun *-2 (x y)
  ;(declare (optimize (speed 3)(safety 0)))
  (flet ((integer*ratio (x y)
	   (if (eql x 0) 0
	       (let* ((ny (%numerator y))
		      (dy (%denominator y))
		      (gcd (gcd x dy)))
		 (if (eql gcd 1)
		     (%make-ratio (* x ny) dy)
		     (let ((nn (* (truncate x gcd) ny))
			   (nd (truncate dy gcd)))
		       (if (eql nd 1)
			   nn
			   (%make-ratio nn nd)))))))
	 (complex*real (x y)
	   (canonical-complex (* (%realpart x) y) (* (%imagpart x) y))))
    (number-case x
      (double-float (number-case y
                      (double-float (* (the double-float x)(the double-float y)))
                      (short-float (with-ppc-stack-double-floats ((dy y))
                                     (* (the double-float x) (the double-float dy))))
                      (rational (dfloat-rat * x y))
                      (complex (complex*real y x))))
      (short-float (number-case y
                      (double-float (with-ppc-stack-double-floats ((dx x))
                                     (* (the double-float dx) (the double-float y))))
                      (short-float (* (the short-float x) (the short-float y)))
                      (rational (sfloat-rat * x y))
                      (complex (complex*real y x))))
      (bignum (number-case y
                (fixnum (multiply-bignum-and-fixnum x y))
                (bignum (multiply-bignums x y))
                (double-float (dfloat-rat * y x))
                (short-float (sfloat-rat * y x))
                (ratio (integer*ratio x y))
                (complex (complex*real y x))))
      (fixnum (number-case y
                (bignum (multiply-bignum-and-fixnum y x))
                (fixnum (%fixnum-*-2 (the fixnum x) (the fixnum y)))
                (short-float (sfloat-rat * y x))
                (double-float (dfloat-rat * y x))
                (ratio (integer*ratio x y))
                (complex (complex*real y x))))
      (complex (number-case y
                 (complex (let* ((rx (%realpart x))
	                         (ix (%imagpart x))
	                         (ry (%realpart y))
	                         (iy (%imagpart y)))
	                    (canonical-complex (- (* rx ry) (* ix iy)) (+ (* rx iy) (* ix ry)))))
                 (real (complex*real x y))))
      (ratio (number-case y
               (ratio (let* ((nx (%numerator x))
	                     (dx (%denominator x))
	                     (ny (%numerator y))
	                     (dy (%denominator y))
	                     (g1 (gcd nx dy))
	                     (g2 (gcd dx ny)))
	                (build-ratio (* (maybe-truncate nx g1)
			                (maybe-truncate ny g2))
		                     (* (maybe-truncate dx g2)
			                (maybe-truncate dy g1)))))
               (integer (integer*ratio y x))
               (double-float (rat-dfloat * x y))
               (short-float (rat-sfloat * x y))
               (complex (complex*real y x)))))))

(defun integer*integer (x y &optional res)
  (declare (ignore res))
  (number-case x      
      (fixnum (number-case y
                (fixnum (%fixnum-*-2 (the fixnum x) (the fixnum y)))
                (t (multiply-bignum-and-fixnum y x))))
      (bignum (number-case y
                (fixnum (multiply-bignum-and-fixnum x y))
                (t (multiply-bignums x y))))))
  

;;; INTEGER-/-INTEGER  --  Internal
;;;
;;;    Divide two integers, producing a canonical rational.  If a fixnum, we
;;; see if they divide evenly before trying the GCD.  In the bignum case, we
;;; don't bother, since bignum division is expensive, and the test is not very
;;; likely to suceed.
;;;
(defun integer-/-integer (x y)
  (if (and (typep x 'fixnum) (typep y 'fixnum))
    (multiple-value-bind (quo rem) (%fixnum-truncate x y)
      (if (eql 0 rem)
        quo
        (let ((gcd (gcd x y)))
          (declare (fixnum gcd))
          (if (eql gcd 1)
            (build-ratio x y)
            (build-ratio (%fixnum-truncate x gcd) (%fixnum-truncate y gcd))))))
    (let ((gcd (gcd x y)))
      (if (eql gcd 1)
        (build-ratio x y)
        (build-ratio (truncate x gcd) (truncate y gcd))))))

(defun /-2 (x y)
  ;(%set-fpscr-control 0)
  (number-case x
    (double-float (number-case y
                    (double-float (/ (the double-float x) (the double-float y)))
                    (short-float (with-ppc-stack-double-floats ((dy y))
                                   (/ (the double-float x) (the double-float dy))))
                    (rational (dfloat-rat / x y))
                    (complex (let* ((ry (%realpart y))
                                    (iy (%imagpart y))
                                    (dn (+ (* ry ry) (* iy iy))))
                               (canonical-complex (/ (* x ry) dn) (/ (- (* x iy)) dn))))))
    (short-float (number-case y
                   (short-float (/ (the short-float x) (the short-float y)))
                   (double-float (with-ppc-stack-double-floats ((dx x))
                                   (/ (the double-float dx) (the double-float y))))
                   (rational (sfloat-rat / x y))
                   (complex (let* ((ry (%realpart y))
                                    (iy (%imagpart y))
                                    (dn (+ (* ry ry) (* iy iy))))
                               (canonical-complex (/ (* x ry) dn) (/ (- (* x iy)) dn))))))                   
    (integer (number-case y
               (double-float (rat-dfloat / x y))
               (short-float (rat-sfloat / x y))
               (integer (integer-/-integer x y))
               (complex (let* ((ry (%realpart y))
                               (iy (%imagpart y))
                               (dn (+ (* ry ry) (* iy iy))))
                          (canonical-complex (/ (* x ry) dn) (/ (- (* x iy)) dn))))
               (ratio
                (if (eql 0 x)
                  0
                  (let* ((ny (%numerator y)) 
                         (dy (%denominator y)) 
                         (gcd (gcd x ny)))
                    (build-ratio (* (maybe-truncate x gcd) dy)
                                 (maybe-truncate ny gcd)))))))
    (complex (number-case y
               (complex (let* ((rx (%realpart x))
                               (ix (%imagpart x))
                               (ry (%realpart y))
                               (iy (%imagpart y))
                               (dn (+ (* ry ry) (* iy iy))))
                          (canonical-complex (/ (+ (* rx ry) (* ix iy)) dn)
                                             (/ (- (* ix ry) (* rx iy)) dn))))
               ((rational float)
                (canonical-complex (/ (%realpart x) y) (/ (%imagpart x) y)))))
    (ratio (number-case y
             (double-float (rat-dfloat / x y))
             (short-float (rat-sfloat / x y))
             (integer
              (when (eql y 0)
                (divide-by-zero-error '/ x y))
              (let* ((nx (%numerator x)) (gcd (gcd nx y)))
                (build-ratio (maybe-truncate nx gcd)
                             (* (maybe-truncate y gcd) (%denominator x)))))
             (complex (let* ((ry (%realpart y))
                             (iy (%imagpart y))
                             (dn (+ (* ry ry) (* iy iy))))
                        (canonical-complex (/ (* x ry) dn) (/ (- (* x iy)) dn))))
             (ratio
              (let* ((nx (%numerator x))
                     (dx (%denominator x))
                     (ny (%numerator y))
                     (dy (%denominator y))
                     (g1 (gcd nx ny))
                     (g2 (gcd dx dy)))
                (build-ratio (* (maybe-truncate nx g1) (maybe-truncate dy g2))
                             (* (maybe-truncate dx g2) (maybe-truncate ny g1)))))))))

(defun divide-by-zero-error (operation &rest operands)
  (error (make-condition 'division-by-zero
           :operation operation
           :operands operands)))


(defun 1+ (number)
  "Returns NUMBER + 1."
  (+-2 number 1))

(defun 1- (number)
  "Returns NUMBER - 1."
  (--2 number 1))


(defun conjugate (number)
  (number-case number
    (complex (complex (%realpart number) (- (%imagpart number))))
    (number number)))

(defun numerator (rational)
  (number-case rational
    (ratio (%numerator rational))
    (integer rational)))

(defun denominator (rational)
  (number-case rational
    (ratio (%denominator rational))
    (integer 1)))

(defun abs (number)
  "Returns the absolute value of the number."
  (number-case number
   (fixnum
    (locally (declare (fixnum number))
      (if (minusp number) (- number) number)))
   (double-float
    (%double-float-abs number))
   (short-float
    (%short-float-abs number))
   (bignum
    (if (bignum-minusp number)(negate-bignum number) number))
   (ratio
    (if (minusp number) (- number) number))    
   (complex
    (let ((rx (%realpart number))
          (ix (%imagpart number)))
      (number-case rx
        (rational
         (sqrt (+ (* rx rx) (* ix ix))))
        (short-float
         (%short-float (%hypot (%double-float rx)
                               (%double-float ix))))
        (double-float
         (%hypot rx ix)))))))

(defun phase (number)
  "Returns the angle part of the polar representation of a complex number.
  For complex numbers, this is (atan (imagpart number) (realpart number)).
  For non-complex positive numbers, this is 0.  For non-complex negative
  numbers this is PI."
  (number-case number
    (rational
     (if (minusp number)
       (%double-float pi) ; is it (will it be) always double float?
       0.0f0))
    (double-float
     (if (minusp number)
       (%double-float pi)
       0.0d0))
    (complex
     (atan (%imagpart number) (%realpart number)))
    (short-float
     (if (minusp number)
       (%short-float pi)
       0.0s0))))

; from Lib;numbers.lisp, sort of
(defun float (number &optional other)
  (if (null other)
    (if (typep number 'float)
      number
      (%short-float number)) ;(%double-float number))
    (if (typep other 'double-float)
      (%double-float number)
      (if (typep other 'short-float)
        (%short-float number)
        (float number (require-type other 'float))))))



;;; If the numbers do not divide exactly and the result of (/ number divisor)
;;; would be negative then decrement the quotient and augment the remainder by
;;; the divisor.
;;;
(defun floor (number &optional divisor)
  "Returns the greatest integer not greater than number, or number/divisor.
  The second returned value is (mod number divisor)."
  (if (null divisor)(setq divisor 1))
  (multiple-value-bind (tru rem) (truncate number divisor)
    (if (and (not (zerop rem))
	     (if (minusp divisor)
               (plusp number)
               (minusp number)))
      (if (called-for-mv-p)
        (values (1- tru) (+ rem divisor))
        (1- tru))
      (values tru rem))))

(defun %fixnum-floor (number divisor)
  (declare (fixnum number divisor))
  (if (eq divisor 1)
    (values number 0)
    (multiple-value-bind (tru rem) (truncate number divisor)
      (if (eq rem 0)
        (values tru 0)
        (locally (declare (fixnum tru rem))
          (if (and ;(not (zerop rem))
	           (if (minusp divisor)
                     (plusp number)
                     (minusp number)))
            (values (the fixnum (1- tru)) (the fixnum (+ rem divisor)))
            (values tru rem)))))))

;;; If the numbers do not divide exactly and the result of (/ number divisor)
;;; would be positive then increment the quotient and decrement the remainder by
;;; the divisor.
;;;
(defun ceiling (number &optional divisor)
  "Returns the smallest integer not less than number, or number/divisor.
  The second returned value is the remainder."
  (if (null divisor)(setq divisor 1))
  (multiple-value-bind (tru rem) (truncate number divisor)
    (if (and (not (zerop rem))
	     (if (minusp divisor)
               (minusp number)
               (plusp number)))
      (if (called-for-mv-p)
        (values (+ tru 1) (- rem divisor))
        (+ tru 1))
      (values tru rem))))

(defun %fixnum-ceiling (number  divisor)
  "Returns the smallest integer not less than number, or number/divisor.
  The second returned value is the remainder."
  (declare (fixnum number divisor))
  (multiple-value-bind (tru rem) (%fixnum-truncate number divisor)
    (if (eq 0 rem)
      (values tru 0)
      (locally (declare (fixnum tru rem))
        (if (and ;(not (zerop rem))
	     (if (minusp divisor)
               (minusp number)
               (plusp number)))
          (values (the fixnum (+ tru 1))(the fixnum  (- rem divisor)))
          (values tru rem))))))



(defun integer-decode-short-float (sfloat)
  (multiple-value-bind (mantissa exp sign)(fixnum-decode-short-float sfloat)
    (if (eq exp 255) ;; ?? else printing short infinity errors - ought to print something that will read back?
      (let ((flags (%get-fpscr-control)))
        (if (logbitp (- 31 ppc::fpscr-ve-bit) flags)
          (error (make-condition 'floating-point-invalid-operation :operation 'integer-decode-float
                                 :operands (list sfloat))))))
    (setq exp (- exp (if (< mantissa #x800000)
                       (+ IEEE-single-float-mantissa-width IEEE-single-float-bias)
                       (+ IEEE-single-float-mantissa-width (1+ IEEE-single-float-bias)))))
    (values mantissa exp (if (eq sign 0) 1 -1))))
         

#| ; move to ppc-float
(defun integer-decode-double-float (dfloat) ; wrong
  (multiple-value-bind (hw3 hw2 hw1 hw0)
                       (%dfloat-hwords dfloat)
    (declare (type (fixnum hw3 hw2 hw1 hw0)))
    (values (logior hw0
                    (ash hw1 16)
                    (ash hw2 32)
                    (ash (%ilogand2 hw3 #x000F) 48))
            (%ilsr 4 (%ilogand2 hw3 #x7FF0))
            (if (%ilogbitp 15 hw3) -1 1))))
|#


;;; INTEGER-DECODE-FLOAT  --  Public
;;;
;;;    Dispatch to the correct type-specific i-d-f function.
;;;
(defun integer-decode-float (x)
  "Returns three values:
   1) an integer representation of the significand.
   2) the exponent for the power of 2 that the significand must be multiplied
      by to get the actual value.  This differs from the DECODE-FLOAT exponent
      by FLOAT-DIGITS, since the significand has been scaled to have all its
      digits before the radix point.
   3) -1 or 1 (i.e. the sign of the argument.)"
  (number-case x
    (short-float
     (integer-decode-short-float x))
    (double-float
     (integer-decode-double-float x))))

;;; %UNARY-TRUNCATE  --  Interface
;;;
;;;    This function is called when we are doing a truncate without any funky
;;; divisor, i.e. converting a float or ratio to an integer.  Note that we do
;;; *not* return the second value of truncate, so it must be computed by the
;;; caller if needed.
;;;
;;;    In the float case, we pick off small arguments so that compiler can use
;;; special-case operations.  We use an exclusive test, since (due to round-off
;;; error), (float most-positive-fixnum) may be greater than
;;; most-positive-fixnum.
;;;
(defun %unary-truncate (number)
  (number-case number
    (integer number)
    (ratio (truncate-no-rem (%numerator number) (%denominator number)))
    (double-float
     (if (and (< (the double-float number) 
                 (float (1- (ash 1 (- (1- ppc::nbits-in-word) ppc::fixnumshift))) 0.0d0))
              (< (float (ash -1 (- (1- ppc::nbits-in-word) ppc::fixnumshift)) 0.0d0)
	         (the double-float number)))
       (%truncate-double-float->fixnum number)
       (%truncate-double-float number)))
    (short-float
     (if (and (< (the short-float number) 
                 (float (1- (ash 1 (- (1- ppc::nbits-in-word) ppc::fixnumshift))) 0.0s0))
              (< (float (ash -1 (- (1- ppc::nbits-in-word) ppc::fixnumshift)) 0.0s0)
	         (the short-float number)))
       (%truncate-short-float->fixnum number)
       (%truncate-short-float number)))))

; cmucl:compiler:float-tran.lisp
(defun xform-truncate (x)
  (let ((res (%unary-truncate x)))
    (values res (- x res))))


;; maybe this could be smarter but frankly scarlett I dont give a damn
(defppclapfunction %fixnum-truncate ((dividend arg_y) (divisor arg_z))
  (let ((unboxed-quotient imm0)
        (unboxed-dividend imm1)
        (unboxed-divisor imm2)
        (unboxed-product imm3)
        (product temp0)
        (boxed-quotient temp1)
        (remainder temp2))
    (save-lisp-context)
    (mtxer rzero) ;(mcrxr cr0)
    (unbox-fixnum unboxed-dividend dividend)
    (unbox-fixnum unboxed-divisor divisor)
    (divwo. unboxed-quotient unboxed-dividend unboxed-divisor)          ; set OV if divisor = 0
    (box-fixnum boxed-quotient unboxed-quotient)
    (mullw unboxed-product unboxed-quotient unboxed-divisor)
    (bns+ @not-0)    
    (set-nargs 3)
    (lwz arg_x 'truncate fn)
    (call-symbol divide-by-zero-error)
    @not-0
    (unbox-fixnum imm2 boxed-quotient)  ; bashing unboxed divisor
    (cmpw cr0 imm2 unboxed-quotient)
    (beq+ @ok)
    (bla .SPensure-cons)
    (li unboxed-divisor ppc::one-digit-bignum-header)
    (stw unboxed-divisor 0 initptr)
    (stw unboxed-quotient 4 initptr)
    (la boxed-quotient ppc::fulltag-misc initptr)
    (mr initptr freeptr)
    @ok
    (subf imm0 unboxed-product unboxed-dividend)
    (vpush boxed-quotient)
    (box-fixnum remainder imm0)
    (vpush remainder)
    (set-nargs 2)
    (ba .SPnvalret)))

(defun truncate (number &optional divisor)
  "Returns number (or number/divisor) as an integer, rounded toward 0.
  The second returned value is the remainder."
  (if (null divisor)(setq divisor 1))
  (when (not (called-for-mv-p))
    (return-from truncate (truncate-no-rem number divisor)))
  (macrolet 
    ((truncate-rat-dfloat (number divisor)
       `(with-ppc-stack-double-floats ((fnum ,number)
                                      (f2))
         (let ((res (%unary-truncate (%double-float/-2! fnum ,divisor f2))))
           (values res 
                   (%double-float--2 fnum (%double-float*-2! (%double-float res f2) ,divisor f2))))))
     (truncate-rat-sfloat (number divisor)
       `(with-ppc-stack-short-floats ((fnum ,number)
                                      (f2))
         (let ((res (%unary-truncate (%short-float/-2! fnum ,divisor f2))))
           (values res 
                   (%short-float--2 fnum (%short-float*-2! (%short-float res f2) ,divisor f2)))))))            
  (number-case number
     (fixnum
       (if (eql number most-negative-fixnum)
         (if (zerop divisor)
           (error 'division-by-zero :operation 'truncate :operands (list number divisor))
           (with-small-bignum-buffers ((bn number))
             (multiple-value-bind (quo rem) (truncate bn divisor)
               (if (eq quo bn)
                 (values number rem)
                 (values quo rem)))))
         (number-case divisor
           (fixnum (if (eq divisor 1) (values number 0) (%fixnum-truncate number divisor)))
           (bignum (values 0 number))
           (double-float (truncate-rat-dfloat number divisor))
           (short-float (truncate-rat-sfloat number divisor))
           (ratio (let ((q (truncate (* number (%denominator divisor)) ; this was wrong
                                     (%numerator divisor))))
                    (values q (- number (* q divisor))))))))
    (bignum (number-case divisor
             (fixnum (if (eq divisor 1) (values number 0)
                         (if (eq divisor most-negative-fixnum)  ;; << aargh
                           (with-small-bignum-buffers ((bd divisor))
                             ;(print 'gag)
                             (bignum-truncate number bd))
                           (bignum-truncate-by-fixnum number divisor))))
              (bignum (bignum-truncate number divisor))
              (double-float  (truncate-rat-dfloat number divisor))
              (short-float (truncate-rat-sfloat number divisor))
              (ratio (let ((q (truncate (* number (%denominator divisor))  ; so was this
                               (%numerator divisor))))
                       (values q (- number (* q divisor)))))))
    (short-float (if (eql divisor 1)
                   (let* ((res (%unary-truncate number)))
                     (values res (- number res)))
                   (number-case divisor
                     (short-float
                      (with-ppc-stack-short-floats ((f2))
                         (let ((res (%unary-truncate (%short-float/-2! number divisor f2))))
                           (values res 
                                   (%short-float--2
                                    number 
                                    (%short-float*-2! (%short-float res f2) divisor f2))))))
                     ((fixnum bignum ratio)
                      (with-ppc-stack-short-floats ((fdiv divisor)
                                                      (f2))
                         (let ((res (%unary-truncate (%short-float/-2! number fdiv f2))))
                           (values res 
                                   (%short-float--2 
                                    number 
                                    (%short-float*-2! (%short-float res f2) fdiv f2))))))
                     (double-float
                      (with-ppc-stack-double-floats ((fnum number)
                                                    (f2))
                        (let* ((res (%unary-truncate (%double-float/-2! fnum divisor f2))))
                          (values res
                                  (%double-float--2
                                   fnum
                                   (%double-float*-2! (%double-float res f2) divisor f2)))))))))
    (double-float (if (eql divisor 1)
                    (let ((res (%unary-truncate number)))
                         (values res (- number res)))
                    (number-case divisor
                      ((fixnum bignum ratio short-float)
                       (with-ppc-stack-double-floats ((fdiv divisor)
                                                      (f2))
                         (let ((res (%unary-truncate (%double-float/-2! number fdiv f2))))
                           (values res 
                                   (%double-float--2 
                                    number 
                                    (%double-float*-2! (%double-float res f2) fdiv f2))))))                        
                      (double-float
                       (with-ppc-stack-double-floats ((f2))
                         (let ((res (%unary-truncate (%double-float/-2! number divisor f2))))
                           (values res 
                                   (%double-float--2
                                    number 
                                    (%double-float*-2! (%double-float res f2) divisor f2)))))))))
    (ratio (number-case divisor
                  (double-float (truncate-rat-dfloat number divisor))
                  (short-float (truncate-rat-sfloat number divisor))
                  (rational
                   (let ((q (truncate (%numerator number)
                                      (* (%denominator number) divisor))))
                     (values q (- number (* q divisor))))))))))

#|
(defppclapfunction called-for-mv-p ()
  (ref-global imm0 ret1valaddr)
  (lwz imm1 ppc::lisp-frame.savelr sp)
  (cmpw cr0 imm0 imm1)
  (mr arg_z rnil)
  (bnelr)
  (addi arg_z arg_z ppc::t-offset)
  (blr))
|#

(defppclapfunction called-for-mv-p ()
  (ref-global imm0 ret1valaddr)
  (lwz imm1 ppc::lisp-frame.savelr sp)
  (eq->boolean arg_z imm0 imm1 imm0)
  (blr))
  

(defun truncate-no-rem (number  divisor)
  "Returns number (or number/divisor) as an integer, rounded toward 0."
  (macrolet 
    ((truncate-rat-dfloat (number divisor)
       `(with-ppc-stack-double-floats ((fnum ,number)
                                      (f2))
         (%unary-truncate (%double-float/-2! fnum ,divisor f2))))
     (truncate-rat-sfloat (number divisor)
       `(with-ppc-stack-short-floats ((fnum ,number)
                                      (f2))
         (%unary-truncate (%short-float/-2! fnum ,divisor f2)))))
  (number-case number
   (fixnum
     (if (eql number most-negative-fixnum)
       (if (eq divisor 1)
         number
         (if (zerop divisor)
           (error 'division-by-zero :operation 'truncate :operands (list number divisor))
           (with-small-bignum-buffers ((bn number))
             (let* ((result (truncate-no-rem bn divisor)))
               (if (eq result bn)
                 number
                 result)))))
       (number-case divisor
         (fixnum (if (eq divisor 1) number (values (%fixnum-truncate number divisor))))
         (bignum 0)
         (double-float (truncate-rat-dfloat number divisor))
         (short-float (truncate-rat-sfloat number divisor))
         (ratio (let ((q (truncate (* number (%denominator divisor))
                                   (%numerator divisor))))
                  q)))))
    (bignum (number-case divisor
              (fixnum (if (eq divisor 1) number
                          (if (eq divisor most-negative-fixnum)
                            (with-small-bignum-buffers ((bd divisor))
                              (bignum-truncate number bd :no-rem))
                            (bignum-truncate-by-fixnum number divisor))))
              (bignum (bignum-truncate number divisor :no-rem))
              (double-float  (truncate-rat-dfloat number divisor))
              (short-float (truncate-rat-sfloat number divisor))
              (ratio (let ((q (truncate (* number (%denominator divisor))
                                        (%numerator divisor))))
                       Q))))
    (double-float
     (if (eql divisor 1)
       (let ((res (%unary-truncate number)))
         RES)
       (number-case divisor
                    ((fixnum bignum ratio)
                     (with-ppc-stack-double-floats ((fdiv divisor)
                                                    (f2))
                       (let ((res (%unary-truncate (%double-float/-2! number fdiv f2))))
                         RES)))
                    (short-float
                     (with-ppc-stack-double-floats ((ddiv divisor)
                                                    (f2))
                       (%unary-truncate (%double-float/-2! number ddiv f2))))
                    (double-float
                     (with-ppc-stack-double-floats ((f2))
                       (%unary-truncate (%double-float/-2! number divisor f2)))))))
    (short-float
     (if (eql divisor 1)
       (let ((res (%unary-truncate number)))
         RES)
       (number-case divisor
                    ((fixnum bignum ratio)
                     (with-ppc-stack-short-floats ((fdiv divisor)
                                                    (f2))
                       (let ((res (%unary-truncate (%short-float/-2! number fdiv f2))))
                         RES)))
                    (short-float
                     (with-ppc-stack-short-floats ((f2))
                       (%unary-truncate (%short-float/-2! number divisor f2))))
                    (double-float
                     (with-ppc-stack-short-floats ((sdiv divisor)
                                                   (f2))
                       (%unary-truncate (%short-float/-2! number sdiv f2)))))))
     
    
    (ratio (number-case divisor
                  (double-float (truncate-rat-dfloat number divisor))
                  (short-float (truncate-rat-sfloat number divisor))
                  (rational
                   (let ((q (truncate (%numerator number)
                                      (* (%denominator number) divisor))))
                     Q)))))))




;;; %UNARY-ROUND  --  Interface
;;;
;;;    Similar to %UNARY-TRUNCATE, but rounds to the nearest integer.  If we
;;; can't use the round primitive, then we do our own round-to-nearest on the
;;; result of i-d-f.  [Note that this rounding will really only happen with
;;; double floats, since the whole single-float fraction will fit in a fixnum,
;;; so all single-floats larger than most-positive-fixnum can be precisely
;;; represented by an integer.]
;;;
;;; returns both values today

(defun %unary-round (number)
  (number-case number
    (integer (values number 0))
    (ratio (let ((q (round (%numerator number) (%denominator number))))             
             (values q (- number q))))
    (double-float
     (if (and (< (the double-float number) 
                 (float (1- (ash 1 (- (1- ppc::nbits-in-word) ppc::fixnumshift))) 1.0d0))
              (< (float (ash -1 (- (1- ppc::nbits-in-word) ppc::fixnumshift)) 1.0d0)
                 (the double-float number)))
       (let ((round (%unary-round-to-fixnum number)))
         (values round (- number round)))
       (multiple-value-bind (trunc rem) (truncate number)         
         (if (not (%double-float-minusp number))
           (if (or (> rem 0.5d0)(and (= rem 0.5d0) (oddp trunc)))
             (values (+ trunc 1) (- rem 1.0d0))
             (values trunc rem))
           (if (or (> rem -0.5d0)(and (evenp trunc)(= rem -0.5d0)))
             (values trunc rem)
             (values (1- trunc) (+ 1.0d0 rem)))))))
    (short-float
     (if (and (< (the short-float number) 
                 (float (1- (ash 1 (- (1- ppc::nbits-in-word) ppc::fixnumshift))) 1.0s0))
              (< (float (ash -1 (- (1- ppc::nbits-in-word) ppc::fixnumshift)) 1.0s0)
                 (the double-float number)))
       (let ((round (%unary-round-to-fixnum number)))
         (values round (- number round)))
       (multiple-value-bind (trunc rem) (truncate number)         
         (if (not (%short-float-minusp number))
           (if (or (> rem 0.5s0)(and (= rem 0.5s0) (oddp trunc)))
             (values (+ trunc 1) (- rem 1.0s0))
             (values trunc rem))
           (if (or (> rem -0.5s0)(and (evenp trunc)(= rem -0.5s0)))
             (values trunc rem)
             (values (1- trunc) (+ 1.0s0 rem)))))))))

(defun %unary-round-to-fixnum (number)
  (number-case number
    (double-float
     (%round-nearest-double-float->fixnum number))
    (short-float
     (%round-nearest-short-float->fixnum number))))

                         
                                
         
; cmucl:compiler:float-tran.lisp
#|
(defun xform-round (x)
  (let ((res (%unary-round x)))
    (values res (- x res))))
|#

#|
(defun round (number &optional divisor)
  "Rounds number (or number/divisor) to nearest integer.
  The second returned value is the remainder."
  (if (null divisor)(setq divisor 1))
  (if (eql divisor 1)
    (xform-round number)
    (multiple-value-bind (tru rem) (truncate number divisor)
      (let ((thresh (if (integerp divisor) (ash (abs divisor) -1)(/ (abs divisor) 2)))) ; does this need to be a ratio?
        (cond ((or (> rem thresh)
                   (and (= rem thresh) (oddp tru)))
               (if (minusp divisor)
                 (values (- tru 1) (+ rem divisor))
                 (values (+ tru 1) (- rem divisor))))
              ((let ((-thresh (- thresh)))
                 (or (< rem -thresh)
                     (and (= rem -thresh) (oddp tru))))
               (if (minusp divisor)
                 (values (+ tru 1) (- rem divisor))
                 (values (- tru 1) (+ rem divisor))))
              (t (values tru rem)))))))
|#


(defun %fixnum-round (number divisor)
  (declare (fixnum number divisor))
  (multiple-value-bind (quo rem)(truncate number divisor) ; should => %fixnum-truncate
    (if (= 0 rem)
      (values quo rem)
      (locally (declare (fixnum quo rem))
        (let* ((minusp-num (minusp number))
               (minusp-div (minusp divisor))
               (2rem (* rem (if (neq minusp-num minusp-div) -2 2))))
          ;(declare (fixnum 2rem)) ; no way jose  
          ;(truncate (1- most-positive-fixnum) most-positive-fixnum)
          ; 2rem has same sign as divisor
          (cond (minusp-div              
                 (if (or (< 2rem divisor)
                         (and (= 2rem divisor)(logbitp 0 quo)))
                   (if minusp-num
                     (values (the fixnum (+ quo 1))(the fixnum (- rem divisor)))
                     (values (the fixnum (- quo 1))(the fixnum (+ rem divisor))))
                   (values quo rem)))
                (t (if (or (> 2rem divisor)
                           (and (= 2rem divisor)(logbitp 0 quo)))
                     (if minusp-num
                       (values (the fixnum (- quo 1))(the fixnum (+ rem divisor)))
                       (values (the fixnum (+ quo 1))(the fixnum (- rem divisor))))
                     (values quo rem)))))))))
#|
; + + => + +
; + - => - +
; - + => - -
; - - => + -
(defun %fixnum-round (number divisor)
  (declare (fixnum number divisor))
  "Rounds number (or number/divisor) to nearest integer.
  The second returned value is the remainder."
  (if (eq divisor 1)
    (values number 0)
    (multiple-value-bind (tru rem) (truncate number divisor)
      (if (= 0 rem)
        (values tru rem)
        (locally (declare (fixnum tru rem))
          (let* ((minusp-num (minusp number))
                 (minusp-div (minusp divisor))
                 (half-div (ash (if minusp-div (- divisor) divisor) -1))
                 (abs-rem (if minusp-num (- rem) rem)))           
            (declare (fixnum half-div abs-rem)) ; true of abs-rem?
            (if (or (> abs-rem half-div)
                    (and 
                     (not (logbitp 0 divisor))
                     (logbitp 0 tru) ; oddp
                     (= abs-rem half-div)))
              (if (eq minusp-num minusp-div)
                (values (the fixnum (+ tru 1))(the fixnum (- rem divisor)))
                (values (the fixnum (- tru 1))(the fixnum (+ rem divisor))))
              (values tru rem))))))))
|#



;; makes 1 piece of garbage instead of average of 2
(defun round (number &optional divisor)
  "Rounds number (or number/divisor) to nearest integer.
  The second returned value is the remainder."
  (if (null divisor)(setq divisor 1))
  (if (eql divisor 1)
    (%unary-round number)
    (multiple-value-bind (tru rem) (truncate number divisor)
      (if (= 0 rem)
        (values tru rem)
        (let* ((mv-p (called-for-mv-p))
               (minusp-num (minusp number))
               (minusp-div (minusp divisor))
               (2rem (* rem (if (neq minusp-num minusp-div) -2 2))))
          ; 2rem has same sign as divisor
          (cond (minusp-div              
                 (if (or (< 2rem divisor)
                         (and (= 2rem divisor)(oddp tru)))
                   (if mv-p
                     (if minusp-num
                       (values (+ tru 1)(- rem divisor))
                       (values (- tru 1)(+ rem divisor)))
                     (if minusp-num (+ tru 1)(- tru 1)))
                   (values tru rem)))
                (t (if (or (> 2rem divisor)
                           (and (= 2rem divisor)(oddp tru)))
                     (if mv-p
                       (if minusp-num
                         (values (- tru 1)(+ rem divisor))
                         (values (+ tru 1)(- rem divisor)))
                       (if minusp-num (- tru 1)(+ tru 1)))
                     (values tru rem)))))))))


;; #-PPC IN L1-NUMBERS.LISP (or implement %%numdiv)
;; Anyone caught implementing %%numdiv will be summarily executed.
(defun rem (number divisor)
  "Returns second result of TRUNCATE."
  (number-case number
    (fixnum
     (number-case divisor
       (fixnum (nth-value 1 (%fixnum-truncate number divisor)))
       (bignum number)
       (t (nth-value 1 (truncate number divisor)))))
    (bignum
     (number-case divisor
       (fixnum
        (if (eq divisor most-negative-fixnum)
          (nth-value 1 (truncate number divisor))
          (bignum-truncate-by-fixnum-no-quo number divisor)))
       (bignum
        (bignum-rem number divisor))
       (t (nth-value 1 (truncate number divisor)))))
    (t (nth-value 1 (truncate number divisor)))))

;; #-PPC IN L1-NUMBERS.LISP (or implement %%numdiv)
;; See above.
(defun mod (number divisor)
  "Returns second result of FLOOR."
  (let ((rem (rem number divisor)))
    (if (and (not (zerop rem))
	     (if (minusp divisor)
		 (plusp number)
		 (minusp number)))
	(+ rem divisor)
	rem)))

(defun cis (theta)
  "Return cos(Theta) + i sin(Theta), AKA exp(i Theta)."
  (if (complexp theta)
    (error "Argument to CIS is complex: ~S" theta)
    (complex (cos theta) (sin theta))))


(defun complex (realpart &optional (imagpart 0))
  "builds a complex number from the specified components."
  (number-case realpart
    (short-float
      (number-case imagpart
         (short-float (canonical-complex realpart imagpart))
         (double-float (canonical-complex (%double-float realpart) imagpart))
         (rational (canonical-complex realpart (%short-float imagpart)))))
    (double-float 
     (number-case imagpart
       (double-float (canonical-complex
                      (the double-float realpart)
                      (the double-float imagpart)))
       (short-float (canonical-complex realpart (%double-float imagpart)))
       (rational (canonical-complex
                              (the double-float realpart)
                              (the double-float (%double-float imagpart))))))
    (rational (number-case imagpart
                (double-float (canonical-complex
                               (the double-float (%double-float realpart))
                               (the double-float imagpart)))
                (short-float (canonical-complex (%short-float realpart) imagpart))
                (rational (canonical-complex realpart imagpart))))))  

;; #-PPC IN L1-NUMBERS.LISP
(defun realpart (number)
  (number-case number
    (complex (%realpart number))
    (number number)))

;; #-PPC IN L1-NUMBERS.LISP
(defun imagpart (number)
  (number-case number
    (complex (%imagpart number))
    (float (float 0.0 number))
    (rational 0)))

(defun logand-2 (x y)  
  (number-case x
    (fixnum (number-case y
              (fixnum
               (%ilogand (the fixnum x)(the fixnum y)))
              (bignum (fix-big-logand x y))))
    (bignum (number-case y
              (fixnum (fix-big-logand y x))
              (bignum (bignum-logical-and x y))))))

(defun logior-2 (x y)
  (number-case x
    (fixnum (number-case y
              (fixnum (%ilogior2 x y))
              (bignum
               (with-small-bignum-buffers ((bx x))
                 (bignum-logical-ior bx y)))))
    (bignum (number-case y
              (fixnum (with-small-bignum-buffers ((by y))
                        (bignum-logical-ior x by)))
              (bignum (bignum-logical-ior x y))))))

(defun logxor-2 (x y)
  (number-case x
    (fixnum (number-case y
              (fixnum (%ilogxor2 x y))
              (bignum
               (with-small-bignum-buffers ((bx x))
                 (bignum-logical-xor bx y)))))
    (bignum (number-case y
              (fixnum (with-small-bignum-buffers ((by y))
                        (bignum-logical-xor x by)))
              (bignum (bignum-logical-xor x y))))))

               

; see cmucl:compiler:srctran.lisp for transforms

(defun lognand (integer1 integer2)
  "Returns the complement of the logical AND of integer1 and integer2."
  (lognot (logand integer1 integer2)))

(defun lognor (integer1 integer2)
  "Returns the complement of the logical OR of integer1 and integer2."
  (lognot (logior integer1 integer2)))

(defun logandc1 (x y)
  "Returns the logical AND of (LOGNOT integer1) and integer2."  
  (number-case x
    (fixnum (number-case y               
              (fixnum (%ilogand (%ilognot x) y))
              (bignum  (fix-big-logandc1 x y))))    ; (%ilogand-fix-big (%ilognot x) y))))
    (bignum (number-case y
              (fixnum  (fix-big-logandc2 y x))      ; (%ilogandc2-fix-big y x))
              (bignum (bignum-logandc2 y x))))))    ;(bignum-logical-and (bignum-logical-not x)  y))))))


#| ; its in numbers
(defun logandc2 (integer1 integer2)
  "Returns the logical AND of integer1 and (LOGNOT integer2)."
  (logand integer1 (lognot integer2)))
|#

(defun logorc1 (integer1 integer2)
  "Returns the logical OR of (LOGNOT integer1) and integer2."
  (logior (lognot integer1) integer2))

#|
(defun logorc2 (integer1 integer2)
  "Returns the logical OR of integer1 and (LOGNOT integer2)."
  (logior integer1 (lognot integer2)))
|#

(defun logtest (integer1 integer2)
  "Predicate which returns T if logand of integer1 and integer2 is not zero."
 ; (not (zerop (logand integer1 integer2)))
  (number-case integer1
    (fixnum (number-case integer2
              (fixnum (not (= 0 (%ilogand integer1 integer2))))
              (bignum (logtest-fix-big integer1 integer2))))
    (bignum (number-case integer2
              (fixnum (logtest-fix-big integer2 integer1))
              (bignum (bignum-logtest integer1 integer2)))))) 

(defun logbitp (index integer)
  "Predicate returns T if bit index of integer is a 1."
  (number-case index
    (fixnum
     (if (minusp (the fixnum index))(report-bad-arg index '(integer 0))))
    (bignum
     ; assuming bignum cant have more than most-positive-fixnum bits (2 expt 24 longs)
     (if (bignum-minusp index)(report-bad-arg index '(integer 0)))
     ; should error if integer isn't
     (return-from logbitp (minusp (require-type integer 'integer)))))
  (number-case integer
    (fixnum
     (if (%i<= index 28)   ; could also be 29 but then change nx1-logbitp and %ilogbitp
       (%ilogbitp index integer)
       (minusp (the fixnum integer))))
    (bignum
     (let ((bidx (%iasr 5 index))
           (bbit (%ilogand index 31)))
       (declare (fixnum bidx bbit))
       (if (>= bidx (%bignum-length integer))
         (bignum-minusp integer)
         (multiple-value-bind (hi lo) (%bignum-ref integer bidx)
           (declare (fixnum hi lo))
           (if (> bbit 15)
             (%ilogbitp (%i- bbit 16) hi)
             (%ilogbitp bbit lo))))))))

(defun lognot (number)
  "Returns the bit-wise logical not of integer."
  (number-case number
    (fixnum (%ilognot number))
    (bignum (bignum-logical-not number))))

(defun logcount (integer)
  "Count the number of 1 bits if INTEGER is positive, and the number of 0 bits
  if INTEGER is negative."
  (number-case integer
    (fixnum
     (%ilogcount (if (minusp (the fixnum integer))
                   (%ilognot integer)
                   integer)))
    (bignum
     (bignum-logcount integer))))



(defun ash (integer count)
  "Shifts integer left by count places preserving sign.  - count shifts right."
  (number-case integer
   (fixnum
    (cond ((eql 0 integer)
           0)
          (t (number-case count
              (fixnum
               (if (eql count 0)
                 integer
                 (let ((length (integer-length (the fixnum integer))))
                   (declare (fixnum length count))
                   (cond ((and (plusp count)
                               (> (+ length count)
                                  (- 31 ppc::fixnumshift)))                          
                          (with-small-bignum-buffers ((bi integer))
                            (bignum-ashift-left bi count)))
                         ((and (minusp count) (< count -31))
                          (if (minusp integer) -1 0))
                         (t (%iash (the fixnum integer) count))))))
               (bignum
                (if (minusp count)
                  (if (minusp integer) -1 0)          
                  (error "Count ~s too large for ASH" count)))))))
    (bignum
     (number-case count
       (fixnum
        (if (eql count 0) 
          integer
          (if (plusp count)
            (bignum-ashift-left integer count)
            (bignum-ashift-right integer (- count)))))
       (bignum
        (if (minusp count)
          (if (minusp integer) -1 0)
          (error "Count ~s too large for ASH" count)))))))

(defun integer-length (integer)
  "Returns the number of significant bits in the absolute value of integer."
  (number-case integer
    (fixnum
     (%fixnum-intlen (the fixnum integer)))
    (bignum
     (bignum-integer-length integer))))


          
; not CL, used below
(defun byte-mask (size)    
  (case size
    (29 #x1fffffff)
    (30 #x3fffffff)
    (31 #x7fffffff)
    (32 #xffffffff)
    (t (1- (ash 1 (the fixnum size))))))

(defun byte-position (bytespec)
  (- (integer-length bytespec) (logcount bytespec)))


; CMU CL returns T.
(defun upgraded-complex-part-type (type)
  (declare (ignore type))
  'real)




#|
Date: Mon, 3 Feb 1997 10:04:08 -0500
To: info-mcl@digitool.com, wineberg@franz.scs.carleton.ca
From: dds@flavors.com (Duncan Smith)
Subject: Re: More info on the random number generator
Sender: owner-info-mcl@digitool.com
Precedence: bulk

The generator is a Linear Congruential Generator:

   X[n+1] = (aX[n] + c) mod m

where: a = 16807  (Park&Miller recommend 48271)
       c = 0
       m = 2^31 - 1

See: Knuth, Seminumerical Algorithms (Volume 2), Chapter 3.

The period is: 2^31 - 2  (zero is excluded).

What makes this generator so simple is that multiplication and addition mod
2^n-1 is easy.  See Knuth Ch. 4.3.2 (2nd Ed. p 272).

    ab mod m = ...

If         m = 2^n-1
           u = ab mod 2^n
           v = floor( ab / 2^n )

    ab mod m = u + v                   :  u+v < 2^n
    ab mod m = ((u + v) mod 2^n) + 1   :  u+v >= 2^n

What we do is use 2b and 2n so we can do arithemetic mod 2^32 instead of
2^31.  This reduces the whole generator to 5 instructions on the 680x0 or
80x86, and 8 on the 60x.

-Duncan

|#
; Use the two fixnums in state to generate a random fixnum >= 0 and < 65536
; Scramble those fixnums up a bit.
(defppclapfunction %next-random-seed ((state arg_z))
  (let ((seed0 imm0)
        (seed1 imm1)
        (temp imm2))
    (check-nargs 1)             ; check
    (lhz seed1 (+ ppc::misc-data-offset 4) state)
    (lwi temp #.(* 2 48271))      ; 48271 * 2
    (lhz seed0 (+ ppc::misc-data-offset 8) state)
    (rlwimi seed0 seed1 16 0 15)  ; combine into 32 bits, x
    (mullw  seed1 temp seed0)     ; seed1 = (x * 48271), lo, * 2
    (rlwinm temp temp 1 0 30)     ; 48271 * 2 * 2
    (mulhw  seed0 temp seed0)     ; seed0 = (x * 48271), hi, * 2
    (addc   seed0 seed0 seed1)    ; do mod 2^31-1
    (rlwinm seed0 seed0 31 1 31)
    (addze. seed0 seed0)
    (insrwi seed1 seed0 16 16)
    (sth seed1 (+ ppc::misc-data-offset 8) state)
    (rotlwi seed0 seed0 16)
    (bne @storehigh)
    (addi seed0 seed0 1)
    @storehigh
    (sth seed0 (+ ppc::misc-data-offset 4) state)
    (clrlwi temp seed1 16)
    (box-fixnum arg_z temp)
    (blr)))

(defppclapfunction %seed0 ((state arg_z))
  (let ((seed0 imm0))
    (lhz seed0 (+ ppc::misc-data-offset 4) state)
    (box-fixnum arg_z seed0)
    (blr)))

(defun random (number &optional (state *random-state*))
  (if (not (typep state 'random-state)) (report-bad-arg state 'random-state))
  ; below doesn't boot
  ;(setq state (require-type (or state *random-state*) 'random-state))
  (if (eql number 0)
    0
    (cond
     ((and (fixnump number) (>= (the fixnum number) 0))
      (locally (declare (fixnum number))
        (if (< number 256)  ;; was 65536. anything much bigger than 256 fails - don't ask me
          (rem (%next-random-seed state) number)
          (%bignum-random number state))))
     ((and (typep number 'double-float) (>= (the double-float number) 0.0))
      (%float-random number state))
     ((and (typep number 'short-float) (>= (the short-float number) 0.0s0))
      (%float-random number state))
     ((and (bignump number) (>= number 0))
      (%bignum-random number state))
     (t (report-bad-arg number '(or (integer 0) (float 0.0)))))))

;; version 3 - lose the one bit holes

(defun %bignum-random (number state)  ;; state isn't optional
  (let* ((bits (+ (the fixnum (integer-length number)) 8))
         (words (ash (the fixnum (+ bits 15)) -4))
         (long-words (ash (the fixnum (+ words 1)) -1))
         (dividend (%alloc-misc long-words ppc::subtag-bignum 0))
         (16-bit-dividend dividend)
         (index 1))
    (declare (fixnum long-words words bits index)
             (dynamic-extent dividend)
             (type (simple-array (unsigned-byte 16) (*)) 16-bit-dividend)       ; lie
             (optimize (speed 3) (safety 0)))
    (loop
      ; This had better inline due to the lie above, or it will error
      (setf (aref 16-bit-dividend index) (%next-random-seed state))
      (decf words)
      ;(when (<= words 0) (return))     
      (setf (aref 16-bit-dividend (the fixnum (1- index)))
            (if (<= words 1)
              ;; assure positive dividend. N.B. asking for 32 bits really only gets 31.
              ;; should 8 above be 9 instead?
              (progn (%seed0 state))
              (%next-random-seed state)))
      (decf words)
      (when (<= words 0) (return))
      (incf  index 2))
    ; The bignum code expects normalized bignums
    (let ((answer (rem dividend number)))
      ;; look out for rem returning dividend which it will do if dividend < number
      (if (and (eq answer dividend)(bignump answer)) (copy-bignum answer) answer))))

#|
(defun %bignum-random (number state)  ;; state isn't optional
  (let* ((bits (+ (the fixnum (integer-length number)) 8))
         (words (ash (the fixnum (+ bits 15)) -4))
         (long-words (ash (the fixnum (+ words 1)) -1))
         (dividend (%alloc-misc long-words ppc::subtag-bignum 0))
         (16-bit-dividend dividend)
         (index 1))
    (declare (fixnum long-words words bits index)
             (dynamic-extent dividend)
             (type (simple-array (unsigned-byte 16) (*)) 16-bit-dividend)       ; lie
             (optimize (speed 3) (safety 0)))
    (loop
      ; This had better inline due to the lie above, or it will error
      (setf (aref 16-bit-dividend index) (%next-random-seed state))
      (decf words)
      ;(when (<= words 0) (return))
      ;; use all 31 bits of the generated thing - leaves some 1 bit holes but
      ;; makes the period longer - I dunno.
      (setf (aref 16-bit-dividend (the fixnum (1- index)))
            (%seed0 state)  ;(%next-random-seed state)
            )
      (decf words)
      (when (<= words 0) (return))
      (incf  index 2))
    ; The bignum code expects normalized bignums
    (let ((answer (rem dividend number)))
      ;; look out for rem returning dividend which it will do if dividend < number
      (if (and (eq answer dividend)(bignump answer)) (copy-bignum answer) answer))))
|#

#|
;; so if the number is bigger than 2^31 we get something random in the high bits??
(defun %bignum-random-2 (number state)  ;; state isn't optional
  (let* ((bits (+ (the fixnum (integer-length number)) 8))
         (words (ash (the fixnum (+ bits 15)) -4))
         (long-words (ash (the fixnum (+ words 1)) -1))
         (dividend (%alloc-misc long-words ppc::subtag-bignum 0))
         (16-bit-dividend dividend)
         (index (1- (+ long-words long-words))))
    (declare (fixnum long-words words bits index)
             (dynamic-extent dividend)
             (type (simple-array (unsigned-byte 16) (*)) 16-bit-dividend)       ; lie
             (type (simple-array (unsigned-byte 16) (*)) state)
             (optimize (speed 3) (safety 0)))
    (print (list bits words long-words))
    (progn
      ; This had better inline due to the lie above, or it will error
      (setf (aref 16-bit-dividend index) (%next-random-seed state))
      ;(decf words)
      ;(when (<= words 0) (return))
      (setf (aref 16-bit-dividend (the fixnum (1- index)))
            (%seed0 state)  ;(%next-random-seed state)
            )
      ;(decf words)
      ;(when (<= words 0) (return))
      ;(incf  index 2)
      )
    ; The bignum code expects normalized bignums
    (mod dividend number)))
|#

(defun %float-random (number state)
  (if (zerop number)
    number
    (let ((ratio (gvector :ratio (random most-positive-fixnum state) most-positive-fixnum)))
      (declare (dynamic-extent ratio))
      (* number ratio))))

(eval-when (:compile-toplevel :execute)
  (defmacro bignum-abs (nexp)
    (let ((n (gensym)))
      `(let ((,n ,nexp))
         (if  (bignum-minusp ,n) (negate-bignum ,n) ,n))))
  
  (defmacro fixnum-abs (nexp)
    (let ((n (gensym)))
      `(let ((,n ,nexp))
         (if (minusp (the fixnum ,n))
           (if (eq ,n most-negative-fixnum)
             (- ,n)
             (the fixnum (- (the fixnum ,n))))
           ,n))))
  )
  

;;; TWO-ARG-GCD  --  Internal
;;;
;;;    Do the GCD of two integer arguments.  With fixnum arguments, we use the
;;; binary GCD algorithm from Knuth's seminumerical algorithms (slightly
;;; structurified), otherwise we call BIGNUM-GCD.  We pick off the special case
;;; of 0 before the dispatch so that the bignum code doesn't have to worry
;;; about "small bignum" zeros.
;;;
(defun gcd-2 (n1 n2)
  ;(declare (optimize (speed 3)(safety 0)))
  (cond 
   ((eql n1 0) (abs n2))
   ((eql n2 0) (abs n1))
   (t (number-case n1
        (fixnum 
         (number-case n2
          (fixnum
           (if (or (eq n1 most-negative-fixnum)(eq n2 most-negative-fixnum))
             (integer-gcd (abs n1)(abs n2))
             (locally
               (declare (optimize (speed 3) (safety 0))
                        (fixnum n1 n2))
               (if (minusp n1)(setq n1 (the fixnum (- n1))))
               (if (minusp n2)(setq n2 (the fixnum (- n2))))
               (%FIXNUM-GCD N1 N2)
               )))
           (bignum (integer-gcd-sub (bignum-abs n2)(fixnum-abs n1)))))
        (bignum (number-case n2
                  (fixnum
                   (integer-gcd-sub (bignum-abs n1)(fixnum-abs n2)))
                  (bignum (integer-gcd (bignum-abs n1) (bignum-abs n2)))))))))

#|
(defun fixnum-gcd (n1 n2)
  (declare (optimize (speed 3) (safety 0))
           (fixnum n1 n2))                    
  (do* ((k 0 (%i+ 1 k))
        (n1 n1 (%iasr 1 n1))
        (n2 n2 (%iasr 1 n2)))
       ((oddp (logior n1 n2))
        (do ((temp (if (oddp n1) (the fixnum (- n2)) (%iasr 1 n1))
                   (%iasr 1 temp)))
            (nil)
          (declare (fixnum temp))
          (when (oddp temp)
            (if (plusp temp)
              (setq n1 temp)
              (setq n2 (- temp)))
            (setq temp (the fixnum (- n1 n2)))
            (when (zerop temp)
              (let ((res (%ilsl k n1)))
                (return res))))))
    (declare (fixnum n1 n2 k))))
|#

; n1 and n2 must be positive (esp non zero)
(defppclapfunction %fixnum-gcd ((n1 arg_y)(n2 arg_z))
  (let ((k imm0)
        (n1u imm1)
        (n2u imm2)
        (temp imm3))
    (li k 0)
    (unbox-fixnum n1u n1)
    (unbox-fixnum n2u n2)
    @loop1   
    (or imm4 n1u n2u)
    (andi. imm4 imm4 1)
    (bne @oddior)
    (srawi n1u n1u 1)
    (srawi n2u n2u 1)
    (addi k k 1)
    (b @loop1)
    @oddior   
    (andi. imm4 n1u 1)
    (bne @n1odd)
    (srawi temp n1u 1)
    (b @loop2start)
    @n1odd
    (subfic temp n2u 0)
    @loop2start
    (andi. imm4 temp 1)
    (cmpwi :cr1  temp 0)
    (beq @AGN2)
    (ble :cr1 @tempminus)
    (mr n1u temp)
    (b @agn)
    @tempminus
    (subfic n2u temp 0)
    @agn
    (sub. temp n1u n2u)
    (bne @agn2)
    (slw n1u n1u k)
    (box-fixnum arg_z n1u)
    (blr)
    @agn2
    (srawi temp temp 1)
    (b @loop2start)))

(defun %quo-1 (n)
  (/ 1 n))

; x & y must both be double floats
(defun %hypot (x y)
  (with-ppc-stack-double-floats ((x**2) (y**2))
    (let ((res**2 x**2))
      (%double-float*-2! x x x**2)
      (%double-float*-2! y y y**2)
      (%double-float+-2! x**2 y**2 res**2)
      (fsqrt res**2))))


; End of ppc-numbers.lisp
