;;;-*- Mode: Lisp; Package: CCL -*-

;; $Log: number-macros.lisp,v $
;; Revision 1.2  2002/11/18 05:36:08  gtbyers
;; Add CVS log marker
;;
;;	Change History (most recent first):
;;  9 5/20/96  akh  probably no change
;;  8 4/1/96   akh  add double-float decl to with-ppc-stack-double-floats
;;  7 3/27/96  akh  add with-negated-bignum-buffers
;;  5 1/2/96   Alice Hartley move with-ppc-stack-double-floats here
;;  4 12/24/95 akh  two-arg-+/- and support back to ppc-numbers
;;  3 12/24/95 akh  int-to-freg is in ppc-float
;;  (do not edit before this line!!)


; Modification History
;
;; collect is in ccl package now
; ----- 5.2 b6
; 02/14/97 gb    with-ppc-stack-short-floats.
; ---- 4.0 ----
; 07/20/96 gb    no TRULY-THE.
; ---- 3.9 ----
; 01/31/96 bill  require-null-or-double-float-sym
; 12/06/95 slh   updated from clieants and Checked In; %make-s/dfloat here


#+allow-in-package
(in-package "CCL")

(eval-when (:compile-toplevel :execute)
  (require "PPC-ARCH" )
  (require "PPC-LAPMACROS")
  (require "LISPEQU")
  )

;; also in ppc-bignum
(defconstant maximum-bignum-length (1- (ash 1 24)))
(deftype bignum-index () `(integer 0 ,(1- (ash 1 24))))

(defmacro %make-sfloat ()
  `(%alloc-misc ppc::single-float.element-count ppc::subtag-single-float))

(defmacro %make-dfloat ()
  `(%alloc-misc ppc::double-float.element-count ppc::subtag-double-float))

(defmacro require-null-or-double-float-sym (sym)
  (setq sym (require-type sym 'symbol))
  `(when (and ,sym (not (double-float-p ,sym)))
     (setq ,sym (require-type ,sym 'double-float))))




(defmacro %numerator (x)
  `(%svref ,x ppc::ratio.numer-cell))

(defmacro %denominator (x)
  `(%svref ,x ppc::ratio.denom-cell))

(defmacro %realpart (x)
  `(%svref ,x ppc::complex.realpart-cell))

(defmacro %imagpart (x)
  `(%svref ,x ppc::complex.imagpart-cell))


(defmacro with-ppc-stack-double-floats (specs &body body)
    (collect ((binds)
                   (inits)
                   (names))
      (dolist (spec specs)
        (let ((name (first spec)))
          (binds `(,name (%alloc-misc ppc::double-float.element-count ppc::subtag-double-float)))
          (names name)
          (let ((init (second spec)))
            (when init
              (inits `(%double-float ,init ,name))))))
      `(let* ,(binds)
         (declare (dynamic-extent ,@(names))
                  (double-float ,@(names)))
         ,@(inits)
         ,@body)))

(defmacro with-ppc-stack-short-floats (specs &body body)
    (collect ((binds)
                   (inits)
                   (names))
      (dolist (spec specs)
        (let ((name (first spec)))
          (binds `(,name (%alloc-misc ppc::single-float.element-count ppc::subtag-single-float)))
          (names name)
          (let ((init (second spec)))
            (when init
              (inits `(%short-float ,init ,name))))))
      `(let* ,(binds)
         (declare (dynamic-extent ,@(names))
                  (short-float ,@(names)))
         ,@(inits)
         ,@body)))


#| ; its in ppc-float - so there
; see "Optimizing PowerPC Code" p. 156
(defppclapmacro int-to-freg (int freg temp-freg immx immy)
  `(let ((temp -8)
         (temp.h -8)
         (temp.l -4)
         (zero -16)
         (zero.h -16)
         (zero.l -12))
     (lwi ,immx #x43300000)  ; 1075 = 1022+53 
     (lwi ,immy #x80000000)
     (stw ,immx temp.h sp) 
     (stw ,immx zero.h sp)
     (stw ,immy zero.l sp)     
     (unbox-fixnum ,immx ,int)
     (xor ,immx ,immx ,immy)          ; invert sign of int
     (stw ,immx temp.l sp)
     (lfd ,freg temp sp)
     (lfd ,temp-freg zero sp)
     (fsub ,freg ,freg ,temp-freg)))
|#

 ;;; WITH-BIGNUM-BUFFERS  --  Internal.
  ;;;
  ;;; Could do freelisting someday. NAH
  ;;;
(defmacro with-bignum-buffers (specs &body body)  ; <<
  "WITH-BIGNUM-BUFFERS ({(var size [init])}*) Form*"
  (collect ((binds)
                 (inits)
                 (names))
    (dolist (spec specs)
      (let ((name (first spec))
            (size (second spec)))
        (binds `(,name (%alloc-misc ,size ppc::subtag-bignum)))
        (names name)          
        (let ((init (third spec)))
          (when init
            (inits `(bignum-replace ,name ,init))))))
    `(let* ,(binds)
       (declare (dynamic-extent ,@(names)))
       ,@(inits)
       ,@body)))

  ; call fn on possibly stack allocated negative of a and/or b
  ; args better be vars - we dont bother with once-only
(defmacro with-negated-bignum-buffers (a b fn)
  `(let* ((len-a (%bignum-length ,a))
          (len-b (%bignum-length ,b))
          (a-plusp (%bignum-0-or-plusp ,a len-a))
          (b-plusp (%bignum-0-or-plusp ,b len-b)))
     (declare (type bignum-index len-a len-b))
     (if (and a-plusp b-plusp)
       (,fn ,a ,b )
       (if (not a-plusp)
         (with-bignum-buffers ((a1 (1+ len-a)))
           (negate-bignum ,a nil a1)
           (if b-plusp
             (,fn a1 ,b)
             (with-bignum-buffers ((b1 (1+ len-b)))
               (negate-bignum ,b nil b1)
               (,fn a1 b1))))
         (with-bignum-buffers ((b1 (1+ len-b)))
           (negate-bignum ,b nil b1)
           (,fn ,a b1))))))

(defmacro with-one-negated-bignum-buffer (a fn)
  `(let* ((len-a (%bignum-length ,a))
          (a-plusp (%bignum-0-or-plusp ,a len-a)))
     (declare (type bignum-index len-a))
     (if a-plusp
       (,fn ,a)
       (with-bignum-buffers ((a1 (1+ len-a)))
         (negate-bignum ,a nil a1)
         (,fn a1)))))

(defmacro without-float-invalid (&body body)
  (let ((flags (gensym)))
    `(let ((,flags (%get-fpscr-control)))
       (unwind-protect
         (progn (%set-fpscr-control (logand (lognot (ash 1 (- 31 ppc::fpscr-ve-bit))) ,flags))
                ,@body)
         (%set-fpscr-status 0) ; why do we need this? status bits get set in any case?
         (%set-fpscr-control ,flags)))))


(provide "NUMBER-MACROS")

; end of number-macros.lisp
