;;; -*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  14 6/7/96  akh  print-bignum-2 - declare optimize
;;  13 5/20/96 akh  no specify dir in require number-macros
;;  12 4/17/96 akh  %pr-integer - don't lose sign of most-negative-fixnum
;;  9 3/9/96   akh  better bignum printer
;;  7 12/1/95  akh  lsh was wrong
;;  6 11/13/95 akh  lsh
;;  4 11/9/95  akh  add token2int, %integer-to-string
;;  3 11/7/95  akh  add %pr-integer, bignum case is pessimal, fixnum fine
;;  (do not edit before this line!!)

;;;
;;; level-0;ppc;ppc-int.lisp

;; declare fixnum charcode in token2int
;; ------- 5.1 final
;; 04/14/98 akh   from duncan smith %pr-integer  - get size-vect and index in sync
;; 09/30/96 bill  Alice's fix to %pr-integer makes most-negative-fixnum print correctly.
;; -------------  4.0b2
;; 04/26/96 akh   use stack for negated bignum
;; 04/07/96 akh   %pr-integer - deal with the fact that (- fixnum) may not be a fixnum!
;; 12/07/95 bill  token2int handles lower-case hex digits

#+allow-in-package
(in-package "CCL")

(eval-when (:compile-toplevel :execute)
  (require "NUMBER-MACROS")
 
)



#|

; in ppc-bignum.lisp:
(defun %ldb-fixnum-from-bignum (bignum size position)
(defun logtest (integer1 integer2)
(defun logcount (integer)
(defun logorc1 (integer1 integer2)
(defun logandc1 (integer1 integer2)
(defun lognor (integer1 integer2)
(defun lognand (integer1 integer2)
(defun lognot (integer)
(defun %integer-signum (i)
(defun oddp (integer)
(defun evenp (integer)
(defun integer-length (integer)
(defun ash (int count)
(defun byte-mask (size)
|#

(defun lsh (fixnum count)
  (require-type fixnum 'fixnum)
  (require-type count 'fixnum)
  (if (> count 0) 
    (%ilsl count fixnum)
    (%ilsr (- count) fixnum)))


; this called with fixnum
(defun %iabs  (n)
  (declare (fixnum n))
  (if (minusp  n) (- n) n))

; called with any integer - is there a cmu version of integer/bignum-abs?
(defun %integer-abs (n)
  (if (minusp n) (- n) n))

(eval-when (:compile-toplevel :execute)
  (assert (< (char-code #\9) (char-code #\A) (char-code #\a))))

(defun token2int (string start len radix)
  ; simple minded in case you hadn't noticed
  (let* ((n start)
         (end (+ start len))
         (char0 (schar string n))
         (val 0)
         minus)
    (declare (fixnum n end start len radix)) ; as if it mattered
    (when (or (eq char0 #\+)(eq char0 #\-))
      (setq n (1+ n))
      (if (eq char0 #\-)(setq minus t)))
    (while (< n end)
      (let ((code (%scharcode string n)))
        (declare (fixnum code))
        (if (<= code (char-code #\9)) 
          (setq code (- code (char-code #\0)))
          (progn
            (when (>= code (char-code #\a))
              (setq code (- code (- (char-code #\a) (char-code #\A)))))
            (setq code (- code (- (char-code #\A) 10)))))
        (setq val (+ (* val radix) code))
        (setq n (1+ n))))
    (if minus (- val) val)))
  

(defun %integer-to-string (int &optional (radix 10))
  (%pr-integer int radix nil t))

; it may be hard to believe, but this is much faster than the lap version (3 or 4X)
; for fixnums that is 
; (stream-write-string vs stream-tyo ???)

(defun %pr-integer (int &optional (radix 10) (stream *standard-output*) return-it  negate-it)
  (declare (fixnum radix)) ; assume caller has checked
  (if stream 
    (if (eq stream t) (setq stream *terminal-io*))
    (setq stream *standard-output*))
  (let ((digit-string "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"))    
    (cond ((fixnump int)  ; ugh                      
           ; 29 bits max magnitude (base 2) + 1 for sign
           (let ((temstring (make-string (- 32 ppc::fixnumshift) :element-type 'base-character))
                 (i (- 32 ppc::fixnumshift 1))
                 (neg (< int 0))
                 (rem 0))
             (declare (fixnum i rem))
             (declare (dynamic-extent temstring))
             (when neg (setq int (- int)))
             (when (not (fixnump int))
               (return-from %pr-integer (%pr-integer int radix stream return-it t)))
             (locally (declare (fixnum int))  
               (loop
                 (multiple-value-setq  (int rem) (%fixnum-truncate int radix))                 
                 (setf (%schar temstring i)(%schar digit-string rem))
                 (when (eq 0 int)
                   (return))
                 (setq i (1- i)))
               (when neg 
                 (setf (%schar temstring (setq i (1- i))) #\-))
               (if return-it
                 (%substr temstring i (- 32 ppc::fixnumshift))
                 (stream-write-string stream temstring i (- 32 ppc::fixnumshift))))))          
          (t (let* ((size-vect '#(NIL NIL 32 21 16 14 13 12
                                      11 11 10 10 9 9 9 9
                                      8 8 8 8 8 8 8 8 7 7 7 7 7 7 7 7
                                      7 7 7 7 7))
                    ; overestimate # digits by a little for weird radix
                    (bigwords (uvsize int))
                    (strlen (1+ (* bigwords (svref size-vect radix))))
                    (temstring (make-string strlen :element-type 'base-character))
                    (i (1- strlen))
                    (neg (< int 0))
                    ;(rem 0)
                    ;better-bignum-print?
                    )  ; warn
               (declare (dynamic-extent temstring)
                        (fixnum i strlen rem))
               (flet ((do-it (newbig)
                        (print-bignum-2 newbig radix temstring digit-string)))
                 (declare (dynamic-extent #'do-it))
                 (setq i (with-one-negated-bignum-buffer int do-it)))                            
               (when (or neg negate-it) 
                 (setf (%schar temstring (setq i (1- i))) #\-))
               (if return-it
                 (%substr temstring i strlen)
                 (stream-write-string stream temstring i strlen)))))))

;;; *BASE-POWER* holds the number that we keep dividing into the bignum for
;;; each *print-base*.  We want this number as close to *most-positive-fixnum*
;;; as possible, i.e. (floor (log most-positive-fixnum *print-base*)).
;;; 
(defparameter *base-power* #(NIL NIL 268435456 387420489 268435456 244140625 362797056 
 282475249 134217728 387420489 100000000 214358881 429981696 62748517
  105413504 170859375 268435456 410338673 34012224 47045881 64000000
  85766121 113379904 148035889 191102976 244140625 308915776 387420489
  481890304 20511149 24300000 28629151 33554432 39135393 45435424 52521875 60466176))

;;; *FIXNUM-POWER--1* holds the number of digits for each *print-base* that
;;; fit in the corresponding *base-power*.
;;; 
(defparameter *fixnum-power--1* #(NIL NIL 27 17 13 11 10 9 8 8 7 7 7
                                      6 6 6 6 6 5 5 5 5 5 5 5 5 5 5 5 4 4 4 4 4 4 4 4))


(defun print-bignum-2 (big radix string digit-string)
  (declare (optimize (speed 3) (safety 0))
           (simple-base-string string digit-string)) 
  (let* ((divisor (aref *base-power* radix))
         (power (aref *fixnum-power--1* radix))
         (index (1- (length string)))
         (rem 0))
    (declare (fixnum index divisor power))
    ;(print index)
    (loop
      (multiple-value-setq (big rem) (truncate big divisor))
      (let* ((int rem)
             (rem 0)
             (final-index (- index power 1)))
        (loop
          (multiple-value-setq (int rem) (%fixnum-truncate int radix))
          (setf (schar string index)(schar digit-string rem))
          (when (eq 0 int)
            (return index))
          (setq index (1- index)))
        (if (zerop big) (return index)        
            (dotimes (i (- index final-index) index)
              (declare (fixnum i))
              (setq index (1- index))
              (setf (schar string index) #\0)))))))
               

                                 
           

; end of ppc-int.lisp
