;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  3 4/1/97   akh  see below
;;  2 3/17/97  akh  add stuff for short  floats
;;  6 7/26/96  akh  more tests for compare ratio/int
;;  5 7/18/96  akh  add some more stuff to test-add
;;  4 6/7/96   akh  some tests neglected to error when failed
;;  3 5/20/96  akh  more rationalize stuff
;;  2 4/19/96  akh  add testrat
;;  1 4/17/96  akh  new file
;;  (do not edit before this line!!)

;; 03/14/97 akh adapt for short-float (some is wrong)
;; akh do more in test-add to catch reported bug re minus of real and complex. Barn door & horse?

(in-package :ccl)

(defun test-arith (&optional (n 100))
  ; missing: compare of ratio, trig, trans, some logical
  (dotimes (i n)(test-ash-types))
  (dotimes (i n)(test-div-types))
  (dotimes (i n)(test-add-types))
  (dotimes (i n)(test-mul-types))
  (dotimes (i n)(test-ffc))
  (dotimes (i n)(test-int-float-compare))
  (dotimes (i n)(test-int-ratio-compare))
  (dotimes (i n)(test-int-ratio-close))
  (dotimes (i n)(test-rational-ize))
  (dotimes (i n)(test-sqrt-types))
  (dotimes (i n)(test-/-types))
  (dotimes (i n)(test-negate-types))
  (dotimes (i n)(test-logical-types))
  (dotimes (i n)(test-logbitp))
  (testrat n)
  (testrat2)
  (testrat3)
  (testrat4)
  (testrat5)
  (test-scale-float))

(defun test-real-types (fn)
  (let ((which-typex (random 5))
        (which-typey (random 5)))
    (let ((x (case which-typex
               (0 (random-fixnum))
               (1 (random-bignum))
               (2 (random-float))
               (3 (random-ratio))
               (4 (random-sfloat))))
          (y (case which-typey
               (0 (random-fixnum))
               (1 (random-bignum))
               (2 (random-float))
               (3 (random-ratio))
               (4 (random-sfloat)))))
      (if (null (funcall fn x y))
        (cerror "OK" "~s failed on ~s ~s" fn x y))
      t)))

(defun test-rational-types (fn)
  (let ((which-typex (random 3))
        (which-typey (random 3)))
    (let ((x (case which-typex
               (0 (random-fixnum))
               (1 (random-bignum))
               (2 (random-ratio))))
          (y (case which-typey
               (0 (random-fixnum))
               (1 (random-bignum))
               (2 (random-ratio)))))
      (if (null (funcall fn x y))
        (cerror "OK" "~s failed on ~s ~s" fn x y))
      t)))
  

(defun test-div-types () ; really truncate & round not /
  (test-real-types 'test-div))

(defun test-/-types () (test-number-types 'test-/))

(defun test-number-types (fn)
  (let ((which-typex (random 5))
        (which-typey (random 5)))
    (let ((x (case which-typex
               (0 (random-fixnum))
               (1 (random-bignum))
               (2 (random-float))
               (3 (random-ratio))
               (4 (random-complex))))
          (y (case which-typey
               (0 (random-fixnum))
               (1 (random-bignum))
               (2 (random-float))
               (3 (random-ratio))
               (4 (random-complex)))))
      (if (null (funcall fn x y))
        (cerror "OK" "~s  failed on ~s ~s" fn x y))
      t)))

(defun test-unary-number-types (fn)
  (let ((which-typex (random 6)))       
    (let ((x (case which-typex
               (0 (random-fixnum))
               (1 (random-bignum))
               (2 (random-float))
               (3 (random-ratio))
               (4 (random-complex))
               (5 (random-sfloat)))))
      (if (null (funcall fn x))
        (cerror "OK" "~s  failed on ~s" fn x))
      t)))

(defun test-unary-real-types (fn)
  (let ((which-typex (random 5)))       
    (let ((x (case which-typex
               (0 (random-fixnum))
               (1 (random-bignum))
               (2 (random-float))
               (3 (random-ratio))
               (4 (random-sfloat)))))
      (if (null (funcall fn x))
        (cerror "OK" "~s  failed on ~s" fn x))
      t)))

(defun test-sqrt-types ()
  (test-unary-number-types 'test-sqrt))

; fails for 2.7456114088017254E-295 fixed
; now #c(-7.338750710967869E+207 2.4516661017517384E+18)
(defun test-sqrt (n)
  (handler-bind ((floating-point-underflow #'(lambda (c)
                                               (declare (ignore c))
                                               (or (and (floatp n)
                                                    (let ((exp (%double-float-exp n)))
                                                      (if (< exp 1)(return-from test-sqrt t))))
                                                   (and (complexp n)
                                                        ; to heck with it
                                                        (return-from test-sqrt t)))))
                                                        
                                                   
                 (floating-point-overflow #'(lambda (c)
                                               (declare (ignore c))
                                               (if (complexp n)(return-from test-sqrt t)))))
   
    (let ((sqrt (sqrt n)))
      (or (= (* sqrt sqrt) n)          
          (test-mul sqrt sqrt)))))

(defun test-negate-types ()
  (test-unary-number-types 'test-negate))

(defun test-negate (x)
  (let ((mx (- x)))
    (or (and (= x 0)(= mx 0))
        (and (/= mx x)
             (= 0 (+ x mx))
             (= (- mx) x)
             (or (not (integerp x))
                 (= (1+ (lognot x)) mx))))))

(defun test-logical-types ()
  (let ((x (random-integer))
        (y (random-integer))) 
    (or 
     (and (= (logandc1 x y)(logand (lognot x) y))
          (= (logandc2 x y)(logand x (lognot y)))
          (eq (logtest x y)(/= 0 (logand x y)))
          (= (logxor x y)(logand (logior x y) (lognot (logand x y)))))
     (cerror "ok" "logical-types failed ~s ~s" x y))))
    

(defun test-logbitp ()
  (let* ((bit (random 2000))
         (int (random-integer))
         (bitp (logbitp bit int)))
    (or 
     (and (eq bitp (= 1 (ldb (byte 1 bit) int)))
         (or (> bit 1000)
             (eq bitp (/= 0 (logand int (ash 1 bit))))))
     (cerror "ok" "logbitp failed ~s ~s" bit int))))
         

(defun test-sin-types ()
  (test-unary-number-types 'test-sin))

; (sin 1.58e8) = 0.05350381110537066 in 3.0 its .05350380495256184
;; (cos 1.58e8) = 0.9985676452785764 in 3.0 its .9985676456082473
;; is it doing single-precision? who's right?
;; try on an 040 with fpu 

;; #c(1.58e8 1.009E-30) sin-squared + cos-squared of that is
;; #c(1.0 2.1563207696376005E-31) in 3.0 its #c(1.0 0.0)
;; on the other hand (sin pi) = 0.0 and in 3.0 is 1.22xxxxe-16

;; (test-sin #c(-0.9786681561579589 -7.478950717453476)) fails in 3.0 as well

; 3.0
#|
? (setq x #c(3.1702875021387534E+196 1.0612252586788649))
#c(3.1702875021387534E+196 1.0612252586788649)
? (setq s (sin x))
#c(-1.4585703874582812 0.550518006472494)
? (setq c (cos x))
#c(0.7002866677097284 -1.1466293719819614)
? (setq it (+ (* c c)(* s s)))
#c(0.9999999999999998 -3.2118770480133847)

-------------------------
; 3.1
1 > (setq x #c(3.1702875021387534E+196 1.0612252586788649))
#c(3.1702875021387534E+196 1.0612252586788649)
1 > (setq s (sin x))
#c(1.6175047172922372 -0.030522611703180717)
1 > (setq c (cos x))
#c(-0.03882630138908333 1.2715727908055492)
|#
       
(defun test-sin (x)
  ; dunno when this is legit 
  (handler-bind ((floating-point-overflow #'(lambda (c)(declare (ignore c))
                                             (return-from test-sin t)))
                 (floating-point-underflow #'(lambda (c)(declare (ignore c))
                                              (return-from test-sin t))))
    
    (let* ((sin (sin x))
           (cos (cos x))
           (sum (+ (* sin sin) (* cos cos))))
      (or (= 1 sum)
          (nearly-float= 1.0 (float-or-complex-float sum))))))

(defun test-log-types ()
  (test-unary-real-types 'test-log)
  (test-real-types 'test-log-2))

#|
(Setq Y -452018924)
(Setq X -3.3154650437471525E-248)

 (log y) should be #c(19.929234604176735 3.141592653589793) it aint - fixed

(expt y x) should not error but it does - fixed
(EXP -154134219761134093625094983395164780682) ; underflow here, 0 in 3.0
(EXP -74120388) ; ditto
(EXP #c(7.38773376740858E-27 1.2096027325401183E-27))
(setq z -1.5413421976113408E+38)

|# 

; fails a lot but useful anyway - found a bunch of bugs
(defun test-log (x)
  (handler-bind ((floating-point-overflow #'(lambda (c)(declare (ignore c))
                                             (return-from test-log t)))
                 (floating-point-underflow #'(lambda (c)(declare (ignore c))
                                              (return-from test-log t))))
    (let ((res (log (exp x))))
      (or (= res x)
          (and (<= x 1.0e-16)(= (exp x) 1.0))
          (nearly-float= res (float x))))))

(defun test-log-2 (x b)
  (handler-bind ((floating-point-overflow #'(lambda (c)(declare (ignore c))
                                             (return-from test-log-2 t)))
                 (floating-point-underflow #'(lambda (c)(declare (ignore c))
                                              (return-from test-log-2 t))))
    (if (and (integerp x)(> x 2000)(not (floatp b)))(setq x (float x)))
    (let ((res (log (expt b x) b)))
      (or (= res x)
          (nearly-float= res (float x))))))  

(defun test-mul-types ()
  (test-number-types 'test-mul))

(defun test-add-types ()
  (test-number-types 'test-add))

(defun test-add-rational-types ()
  (test-rational-types 'test-add))  

(defun signed-random (n)
  (let* ((sign (random 2))
         (rand (random n)))
    (if (= sign 1) (- rand) rand)))   

(defun random-ratio ()
  (let ((which-top (random 2))
        (which-bot (random 2)))
    (/ (case which-top
         (0 (random-fixnum))
         (1 (random-bignum)))
       (case which-bot
         (0 (random-fixnum))
         (1 (random-bignum))))))

(defun random-real () 
  (let ((which (random 5)))
    (case which
      (0 (random-fixnum))
      (1 (random-bignum))
      (2 (random-ratio))
      (3 (random-float))
      (4 (random-sfloat)))))

(defun random-complex ()
  (let ((real (random-real))
        (imag (random-real)))
    (complex real imag)))

;; denormalized?
(defun random-float ()
  (let ((hi (random #x10000001))
        (lo (random #x1000000))
        (exp (random 2047))  ; no nans today
        (sign (random 2)))
    (make-float-from-fixnums hi lo exp (if (eq sign 0) 1 -1))))

(defun random-sfloat ()
  (let ((m (random #x800001))
        (exp (random 255))
        (sign (random 2)))
    (make-short-float-from-fixnums m exp (if (eq sign 0) 1 -1))))

(defun random-bignum ()
  (let ((bignum1 #x7fffffff)
        (bignum2 #x7fffffffffffffff)
        (bignum3 #x7fffffffffffffffffffffff)
        (bignum4 #x7fffffffffffffffffffffffffffffff))
    (let ((which (random 4)))
      (signed-random
       (case which
         (0 bignum1)
         (1 bignum2)
         (2 bignum3)
         (3 bignum4))))))

(defun random-fixnum ()
  (signed-random most-positive-fixnum))

(defun test-round (num div)
  (handler-bind ((floating-point-overflow #'(lambda (c)
                                              (declare (ignore c))
                                              (let ((what (if (or (typep num 'short-float)
                                                                  (typep div 'short-float))
                                                            1.0s0
                                                            1.0d0)))
                                                (setq num (float num what))
                                                (setq div (float div what))
                                                (let ((e1 (nth-value 1 (integer-decode-float num)))
                                                      (e2 (nth-value 1 (integer-decode-float div))))
                                                  (if (> (- e1 e2) (if (eql what 1.0d0) 1023 127))
                                                    (return-from test-round t))))))
                 (floating-point-underflow #'(lambda (c)
                                               (declare (ignore c))
                                               (let ((what (if (or (typep num 'short-float)
                                                                   (typep div 'short-float))
                                                             1.0s0
                                                             1.0d0)))
                                                 
                                                 (setq num (float num what))
                                                 (setq div (float div what))
                                                 (let ((e1 (nth-value 1 (integer-decode-float num)))
                                                       (e2 (nth-value 1 (integer-decode-float div))))
                                                   (if (<= (- e1 e2) 0)
                                                     (return-from test-round t)))))))
    (if (and (typep num 'double-float)(typep div 'short-float))
        (setq div (float div 1.0d0)))  ; num double, div short is weird cause the * overflows
    (multiple-value-bind (q r)(round num div)
      (let ((res (+ r (* q div))))
        (or (= res num)
            (and (or (floatp num)(floatp div))
                 (nearly-float= (float res)(float num))))))))

(defun test-trunc (num div)
  (handler-bind ((floating-point-overflow #'(lambda (c)
                                              (declare (ignore c))
                                              (let ((what (if (or (typep num 'short-float)
                                                                  (typep div 'short-float))
                                                            1.0s0
                                                            1.0d0)))
                                              (setq num (float num what))
                                              (setq div (float div what))
                                              (let ((e1 (nth-value 1 (integer-decode-float num)))
                                                    (e2 (nth-value 1 (integer-decode-float div))))
                                                (if (> (- e1 e2) (if (eql what 1.0d0) 1023 127))
                                                  (return-from test-trunc t))))))
                 (floating-point-underflow #'(lambda (c)
                                               (declare (ignore c))
                                               (let ((what (if (or (typep num 'short-float)
                                                                  (typep div 'short-float))
                                                            1.0s0
                                                            1.0d0)))
                                               
                                               (setq num (float num what))
                                               (setq div (float div what))
                                               (let ((e1 (nth-value 1 (integer-decode-float num)))
                                                     (e2 (nth-value 1 (integer-decode-float div))))
                                                 (if (<= (- e1 e2) 0)
                                                   (return-from test-trunc t)))))))
    (unless (= 0 div)
      (if (and (typep num 'double-float)(typep div 'short-float))
        (setq div (float div 1.0d0)))  ; num double, div short is weird cause the * overflows
      (setq tx num ty div)
      (multiple-value-bind (q r)(truncate num div)
        (let ((res (+ r (* q div))))
          (or (= res num)
              (and (or (floatp num)(floatp div))
                   (let ((what (if (or (typep num 'short-float)
                                       (typep div 'short-float))
                                 1.0s0
                                 1.0d0)))
                     (nearly-float= (float res what)(float num what))))))))))

(defun test-div (num div)
  (Unless (= 0 div)
    (and (test-trunc num div)
         (test-round num div))))

(defun test-/ (num div)
  (handler-bind ((floating-point-overflow #'(lambda (c)
                                              (declare (ignore c))
                                              (if (or (complexp num)(complexp div))
                                                ; dont bother
                                                (return-from test-/ t))
                                              (let ((what (if (or (typep num 'short-float)
                                                                  (typep div 'short-float))
                                                            1.0s0
                                                            1.0d0)))
                                              (setq num (float num what))
                                              (setq div (float div what))
                                              (let ((e1 (nth-value 1 (integer-decode-float num)))
                                                    (e2 (nth-value 1 (integer-decode-float div))))
                                                (if (> (- e1 e2) (if (eql what 1.0d0) 1023 127))
                                                  (return-from test-/ t))))))
                 (floating-point-underflow #'(lambda (c)
                                               (declare (ignore c))
                                               (if (or (complexp num)(complexp div))
                                                 ; dont bother
                                                 (return-from test-/ t))
                                               (let ((what (if (or (typep num 'short-float)
                                                                  (typep div 'short-float))
                                                            1.0s0
                                                            1.0d0)))
                                               (setq num (float num what))
                                               (setq div (float div what))
                                               (let ((e1 (nth-value 1 (integer-decode-float num)))
                                                     (e2 (nth-value 1 (integer-decode-float div))))
                                                 (if (<= (- e1 e2) 0)
                                                   (return-from test-/ t))))))
                 (division-by-zero #'(lambda (c)(declare (ignore c))
                                     (if (or (complexp num)(complexp div))
                                       (return-from test-/ t)))))
    (unless (= 0 div)
      
      (let* ((q (/ num div))
             (p (* q div))
             nn)
        (or (= p num)
            ; to heck with it if q denorm
            (and (typep q 'double-float)(eq (nth-value 2 (fixnum-decode-float q)) 0)
                     (print "denorm"))
            (and (typep q 'short-float)(eq (nth-value 1 (fixnum-decode-short-float q)) 0)
                     (print "denorm"))
            (progn 
              (if (or (floatp num)(floatp p)(complex-floatp num)(complex-floatp p))
                (setq nn (float-or-complex-float num) p (float-or-complex-float p)))
              (or (nearly-float= p nn)
                  (if (and *punt* (or (complexp num) (complexp div)))
                    (print "punt")
                    (progn (setq *x num *y div)(cerror "a" "b"))))))))))


;; and complex too
(defun test-mul (a b)
  ; handlers gotta deal with complex args too
  (let ((fpu-mode (get-fpu-mode)))
    (unwind-protect
      (progn 
        (set-fpu-mode :underflow t)
        
        (handler-bind ((floating-point-overflow #'(lambda (c)
                                                    (declare (ignore c))
                                                    ; could test that operands are right in c
                                                    ; but they are wrong today
                                                    (if (or (complexp a)(complexp b))
                                                      ; dont bother
                                                      (return-from test-mul t))
                                                    (let ((what (if (or (typep a 'short-float)
                                                                  (typep b 'short-float))
                                                            1.0s0
                                                            1.0d0)))
                                                    (setq a (float a what))
                                                    (setq b (float b what))
                                                    (let ((e1 (nth-value 1 (integer-decode-float a)))
                                                          (e2 (nth-value 1 (integer-decode-float b))))
                                                      (if (> (+ e1 e2) (if (eql what 1.0d0) (- 971 52) (- 104 23))) ; wrong?
                                                        (return-from test-mul t))))))
                       (floating-point-underflow #'(lambda (c)
                                                     (declare (ignore c))                                              
                                                     (if (or (complexp a)(complexp b))
                                                       ; dont bother
                                                       (return-from test-mul t))
                                                     (let ((what (if (or (typep a 'short-float)
                                                                  (typep b 'short-float))
                                                            1.0s0
                                                            1.0d0)))
                                                     (setq a (float a what))
                                                     (setq b (float b what))
                                                     (let ((e1 (nth-value 1 (integer-decode-float a)))
                                                           (e2 (nth-value 1 (integer-decode-float b))))                                                
                                                       ;(setq shit (list a b))
                                                       (if (< (+ e1 e2) (if (eql what 1.0d0) -1022 -126)) ; wrong
                                                         (return-from test-mul t)))))))
          
          (let ((prod (* a b)))
            (or
             (and (zerop a)(zerop prod))
             (and (zerop b)(zerop prod))
             (and (= (/ prod a) b)
                  (= (/ prod b) a))
             (and (or (floatp a)(floatp b)(complex-floatp a)(complex-floatp b))
                  (nearly*= a b prod))))))
      (apply 'set-fpu-mode fpu-mode))))

(defun complex-floatp (n)
  (and (complexp n)
       (or (floatp (imagpart n))(floatp (realpart n)))))

(defvar *punt* t)
(defun nearly*= (a b prod)
  (if (not (floatp a))(setq a (float-or-complex-float a)))
  (if (not (floatp b))(setq b (float-or-complex-float b)))
  (setq prod (* a b))
  (let ((bres (/ prod a))
        (ares (/ prod b)))
   (or (and (nearly-float= b bres)
             (nearly-float= a ares))
       (and (or (complexp a)(complexp b))            
            *punt*
            (progn (print (format nil "punt ~s ~s" a b))
                   t)))))

(defun float-or-complex-float (n)
  (if (complexp n)
    (canonical-complex (float (realpart n))(float (imagpart n)))
    (float n)))

#|
(TEST-MUL #c(-3.262406338337281E+28 30.810431483086976) #c(1.3412088595671892E-87 2.0266452366810228E-96))
|#


; this is ok for  mul but we still need a hack for add/sub
(defun nearly-float= (x y)
  (or (= x y)  ; for recursive call 0.0, -0.0
      (if (and (complexp x)(complexp y))
        (and (nearly-float= (realpart x)  (realpart y))
             (nearly-float= (imagpart x)  (imagpart y)))
        (if (and (complexp x)(not (complexp y)))
          (and (nearly-float= (realpart x) y)
               (nearly-complex-rat y))          
          (if (and (complexp y)(not (complexp x)))
            (and (nearly-float= (realpart y) x)
                 (nearly-complex-rat y))
            (progn
            (if (and (typep x 'short-float)(typep y 'double-float))
              (setq y (float y x)))
            (if (and (typep y 'short-float)(typep x 'double-float))
              (setq x (float x y)))
            (multiple-value-bind (xint xexp xsign) (integer-decode-float x)
              (multiple-value-bind (yint yexp ysign) (integer-decode-float y)
                (and (= xsign ysign)
                     (or (and (= xexp yexp)
                              (or (= xint yint)
                                  (= 1 (abs (- xint yint)))))
                         (and (= (abs (- xexp yexp)) 1)
                              ;(print (list xexp yexp xint yint))
                              (if (> xexp yexp)
                                (setq xint (ash xint 1))
                                (setq yint (ash yint 1)))
                              (or (= xint yint)
                                  (= 1 (abs (- xint yint)))))))))))))))

; is imag part pretty much 0 wrto real part
(defun nearly-complex-rat (x)
  (let* ((r (realpart x))
         (i (imagpart x))
         (er (nth-value 1 (integer-decode-float r)))
         (ei (nth-value 1 (integer-decode-float i))))
    (and (> er ei)
         (> (- er ei) (if (typep r 'double-float) 51 22)))))    

(defun test-add (a b)
  (handler-bind ((floating-point-overflow #'(lambda (c)
                                              (declare (ignore c))
                                              ; could test that operands are right in c
                                              ; but they are wrong today.
                                              (let ((what (if (or (typep a 'short-float)
                                                                  (typep b 'short-float))
                                                            1.0s0
                                                            1.0d0)))
                                              (setq a (float a what))
                                              (setq b (float b what))
                                              (let ((e1 (nth-value 1 (integer-decode-float a)))
                                                    (e2 (nth-value 1 (integer-decode-float b)))
                                                    (max (if (eql what 1.0d0) 970 103)))
                                                (if (or (>= e1 max)(>= e2 max))
                                                  (return-from test-add t)))))))
    (let ((sum (+ a b))
          (diff (- a b)))
      (or (and (= (- sum a) b)
               (= (- sum b) a)
               (= a (+ diff b))
               (= b (- a diff)))
          (and (or (floatp a)(floatp b)(complex-floatp a)(complex-floatp b))
            (nearly+= a b))))))

(defun nearly+= (a b)
  (if (not (or (complexp a)(complexp b)))
    (let* ((a (float a 0.0d0))
           (b (float b 0.0d0))
           (sum (+ a b)))
      (or (and (= b (- sum a))  ; for recursive call
               (= a (- sum b)))          
          (let* ((e1 (nth-value 2 (fixnum-decode-float a)))
                 (e2 (nth-value 2 (fixnum-decode-float b)))
                 (exp-diff (- e1 e2)))
            ;(print (list a b exp-diff))
            (if (> (abs exp-diff) 53)
              ; one disappears wrto other
              (or (= sum a)(= sum b))
              (if t ;(neq 0 exp-diff)
                (progn
                  (when (< exp-diff 0)(psetq a b b a)) ; a bigger magnitude
                  (and (or (= (- sum b) a)
                           (let ((x (integer-decode-float (- sum b)))
                                 (y (integer-decode-float a)))
                             ;(print (list 'cow x y))
                             (<= (abs (- x y)) 2))))
                  ;; can't win cause of round off
                  #|
                     (multiple-value-bind (int exp)(integer-decode-float b)
                       (let* ((lost-bits (logand int (1- (expt 2 (abs exp-diff)))))
                              (delta (* lost-bits (expt 2.0  exp))))
                       (print (list a b exp-diff delta))
                       (if (minusp b)(setq delta (- delta)))
                       (= (print (- (- sum a) delta)) b)))))))))|#
                  ))))))
    (if t ;(or (complex-floatp a)(complex-floatp b))
      (let ((reala (realpart a))
            (realb (realpart b))
            (imaga (imagpart a))
            (imagb (imagpart b)))
        (and (nearly+= reala realb)
             (nearly+= imaga imagb))))))

(defun test-rational-ize ()
  ; fails for -6.00733063264624E-310 - cause of assymetry of pos and neg exponent ranges
  ; will still fail - not exactly =, but won't error
  (let ((n (random-float)))
    (and (= n (float (rational n)))
         (= n (float (rationalize n)))))
  (let ((n (random-sfloat)))
    (and (= n (float (rational n)))
         (= n (float (rationalize n))))))

(defun test-ffc ()
  (let* ((int (random-fixnum))
         (float (random-float))
         (res (fixnum-dfloat-compare int float)))
    ;; use truncate or rational
    (let ((ok
           (if (eq res 0)
             (= int (rational float))
             (if (eq res 1)
               (> int (rational float))
               (< int (rational float))))))
      (if (not ok) (cerror "Go on" "Fix float compare failed for ~s ~s" int float)))))

; this only makes sense because we know that the compares dont use rational for float X integer
(defun test-int-float-compare ()
  (let* ((int (random-integer))
         (float (random-float))
         (rat-float (rational float))
         ok)
    (if (= int float)
      (setq ok (and (= float int)(= int rat-float)(not (/= int rat-float))))
      (if (> int float)
        (setq ok (and (< float int)(not (>= float int))(> int rat-float)(not (<= int rat-float))))
        (setq ok (and (> float int)(not (<= float int))(< int rat-float)(not (>= int rat-float))))))
    (if (not ok) (cerror "Go on" "Compare failed for ~s ~s" int float))))

(defun test-int-ratio-compare ()
  
  (let ((int (random-integer))
        (ratio (random-ratio)))
    (test-int-rat-comp1 int ratio)))

(defun test-int-rat-comp1 (int ratio)
    (flet ((bad ()
             (cerror "Go on" "Compare failed for ~s ~s" int ratio)))        
      (if (= int ratio) ; won't happen very often
        (when (not (and (= ratio int) (= 0 (int-ratio-compare int ratio))))(bad))
        (let ((comp (int-ratio-compare int ratio)))
          (if (>= int ratio)
            (when (not (and (<= ratio int)(neq -1 comp)))(bad))
            (when (not (and (> ratio int)(neq 1 comp)))(bad)))
          (if (> int ratio)
            (when (Not (and (< ratio int) (= 1 comp)))(bad))
            (when (not (and (>= ratio int) (= -1 comp)))(bad)))))
      t))

(defun test-int-ratio-close ()
  (let ((ratio (random-ratio)))
    (test-int-rat-comp1 (ceiling ratio) ratio)
    (test-int-rat-comp1 (floor ratio) ratio)
    (test-int-rat-comp1 (truncate ratio) ratio)))
    
    

; why not do compares this way? vs ceiling and floor
; mul is faster but  floor makes less garbage
; do product to stack allocated thing?
(defun int-ratio-compare (int ratio) ; ratio may be int
  (let ((prod (* int (denominator ratio)))
        (num (numerator ratio)))
    (if (= prod num) 0
        (if (> prod num) 1 -1))))

; get more fixnums than random-bignum
(defun random-integer ()
  (let ((which (random 2)))
    (case which
      (0 (random-fixnum))
      (1 (random-bignum)))))

; this assumes shift is positive
(defun test-ash (num shift)
  (let* ((left (ash num shift)))
    (if (neq shift 0)
      (let ((2p (expt 2 shift)))
        (and (> (abs left) (abs num))
             (= num (ash left (- shift)))
             (= (* num 2p) left)
             (= num (/ left 2p) )))
      (= left num))))

(defun test-ash-types ()  
  (let ((num (random-integer))
        (shift (random 4096)))
    ;(print (list num shift))
    (or (test-ash num shift)
        (cerror "OK" "test-ash failed on ~s ~s" num shift))))

(defun test-scale-float ()
  (or (and (= (scale-float 1.5 -1022) 3.337610787760802E-308)
           (= (scale-float 1.5 -1023) 1.668805393880401E-308)
           (= (scale-float 1.5 -1055) 3.88549E-318)
           (= (scale-float 1.5 -1070) 1.2E-322)
           (= (scale-float 1.5 1000) 1.607262910779401E+301))
      (cerror "OK" "scale-float failed")))

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
      (setq f (* f 2))))
  (let ((f least-positive-short-float))
    (dotimes (i 100)
      (when (not (= (float (rationalize f) f) f))
        (cerror "a" "rat failed ~s ~s" f i))
      (setq f (* f 2)))))

; fails a lot in 3.0 - not powers of 2 - works here
(defun testrat3 ()
  (let ((f least-positive-double-float))
    (dotimes (i 10000)
      (let ((f2 (* (+ i 1) f)))
        (when (not (= (float (rationalize f2)) f2))
          (cerror "a" "rat failed ~s ~s" f2 i)))))
  (let ((f least-negative-double-float))
    (dotimes (i 10000)
      (let ((f2 (* (+ i 1) f)))
        (when (not (= (float (rationalize f2)) f2))
          (cerror "a" "rat failed ~s ~s" f2 i)))))
  (let ((f least-positive-short-float))
    (dotimes (i 10000)
      (let ((f2 (* (+ i 1) f)))
        (when (not (= (float (rationalize f2) f) f2))
          (cerror "a" "rat failed ~s ~s" f2 i)))))
  (let ((f least-negative-short-float))
    (dotimes (i 10000)
      (let ((f2 (* (+ i 1) f)))
        (when (not (= (float (rationalize f2) f) f2))
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
          (cerror "a" "rat failed ~s ~s" f2 i)))))
  (let ((f least-positive-normalized-short-float)) ; we are failing here - OK now
    (dotimes (i 1000)
      (let ((f2 (* (+ i i 1) f)))
        (when (not (= (float (rationalize f2) f) f2))
          (cerror "a" "rat failed ~s ~s" f2 i)))))
  (let ((f least-negative-normalized-short-float))
    (dotimes (i 100)
      (let ((f2 (* (+ i i 1) f)))
        (when (not (= (float (rationalize f2) f) f2))
          (cerror "a" "rat failed ~s ~s" f2 i))))))

(defun testrat5 ()
  (let ((f 12345.4e99))
    (dotimes (i 1000)
      (let ((f2 (* (+ i i 1) f)))
        (when (not (= (float (rationalize f2)) f2))
          (cerror "a" "rat failed ~s ~s" f2 i)))))
  (let ((f -1.987e65))
    (dotimes (i 100)
      (let ((f2 (* (+ i i 1) f)))
        (when (not (= (float (rationalize f2)) f2))
          (cerror "a" "rat failed ~s ~s" f2 i)))))
  (let ((f 12345.4s20))
    (dotimes (i 1000)
      (let ((f2 (* (+ i i 1) f)))
        (when (not (= (float (rationalize f2) f) f2))
          (cerror "a" "rat failed ~s ~s" f2 i)))))
  (let ((f -1.987s23))
    (dotimes (i 100)
      (let ((f2 (* (+ i i 1) f)))
        (when (not (= (float (rationalize f2) f) f2))
          (cerror "a" "rat failed ~s ~s" f2 i))))))


; end test-arith