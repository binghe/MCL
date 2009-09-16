;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  15 4/19/96 akh  atan2
;;  14 4/17/96 akh  change the transcendentals to put result in a temp in case it returns a Nan if error.
;;  10 11/19/95 gb  &lexpr rides again
;;  9 11/17/95 akh  ldb fixnum size fn(target)
;;  8 11/15/95 slh  temp lexpr regression
;;  7 11/13/95 akh  dont remember
;;  4 10/26/95 Alice Hartley random state %istruct
;;  2 10/7/95  slh  n-ary /=, logeqv, ppc-target conds.
;;  3 2/6/95   akh  how quickly they forget. Maybe no change.
;;  (do not edit before this line!!)

; Modification History
;
; move init-random-state-seeds here from level-0
; 07/06/99 akh add %double-float-log2! and log10!
; ----- 4.3b3
;06/15/96 bill  random-state uses ppc::fixnum-shift instead of $fixnushift for ppc-target
;04/18/96 gb    from alice: fix typo in %double-float-atan2!.
;03/01/96 gb    mathlib exception checking.
;01/19/96 gb    ppc mathlib calls (can't do ff-calls from level-0 yet.)
;11/15/95 slh   temp. #+/-lexprs conds. to get around compiler bug
;10/12/95 slh   minor cleanup
;09/14/95 gb    Considered &LEXPR.
;03/10/95 gb    machine-dependent code to level-0.  Use dynamic-extent arglists for n-ary
;               functions; slower (consider lexpr ?)
;07/07/93 bill  most of the random-state stuff moves here from numbers.lisp.
;               It's used now by "l1-clos.lisp".
;-------------- 3.0d11
;06/09/93 alice %parse-number-token calls new-numtoken and new-numtoken replaces %%numtkn (I hope)
;04/12/93 bill  fix brain damage in %ldb-fixnum-from-bignum
;-------------- 2.1d5
;04/08/93 alice %ldb-fixnum-from-bignum incr offset, decr #bits not vv
;01/14/92 bill  ldb, dpb, & friends move here from "ccl:lib;numbers.lisp".
;               load-byte & ldb don't cons when loading a fixnum from
;               a bignum.
;12/01/92 bill  truncate, floor, ceiling, & round now check for multiple
;               values and don't cons a second return value unless it's expected.
;11/20/92 gb    new vectors; logbitp a subprim
;--------- 2.0
;01/29/92 gb    %%numdiv uses set_fpcr vice immediate operand.
;---------- f2c3
;01/22/91 alice %%numdiv all double sane or not, except for fint, where sane fails
;---------- f1c2
;11/26/91 alice comment out the rest of float reader
;------------------- 2.0b4
;11/17/91 alice %%numdiv round precision double 
;11/09/91 alice %%numtkn switch sane from double to extended and back, detect overflow
;11/05/91 alice&gary lets use SANE for reading floats (use extended precision)
;07/21/91 gb   fix &lap arglists so compiler can complain more.
;06/01/91 gb   Fix long numeric string overflow nonsense.
;05/31/91 gb   %%NumTkn tries harder ...
;05/30/91 gb   %ftanh was jsring to symbols vice lfuns.  Screw. %%NumTkn 
;              tries to parse short floats with SANE.
;05/08/91 gb   supposed to be short-float-clean.
;03/05/91 alice report-bad-arg gets 2 args
;-------------- 2.0b1
;12/13/90 gb   punt float printer.
;11/28/90 bill byte-mask handles a size of 0.
;11/12/90 bill GZ's fix to LOGNOT
;10/16/90 gb   stack-discipine bug in %%numdiv.
;09/06/90 bill GZ'z patch to %%numtkn
;08/20/90 bill movem -> movem.l in %%numdiv
;08/02/90 (gz) cons perm ints per the New Order.
;06/29/90 bill Missing unuse_regs in (defun = ...)
;04/30/90 gb  flush %iash.  Use newer lap control structures.  Changed
;             logxor, logior, logand to call new subprims.
;03/20/90 gz  Added realp.
;10/3/89  gz  Remove assumptions about bignums being < 32k.
;05/07/89 gb    allocvect,reservevect calls pass subtype in arg_y.
;04/07/89 gb  $sp8 -> $sp.
; 04/01/89 gz Split off from l1-aprims and elsewhere.

(eval-when (:compile-toplevel :execute)
  (require "NUMBER-MACROS" "ccl:compiler;ppc;number-macros")
 
)



(defun %parse-number-token (string &optional start end radix)
  (if end (require-type end 'fixnum)(setq end (length string)))
  (if start (require-type start 'fixnum)(setq start 0))
  (multiple-value-bind (string offset)(array-data-and-offset string)
    (new-numtoken string (+ start offset)(- end start) (%validate-radix (or radix 10)))))

(defun new-numtoken (string start len radix &optional no-rat)
  (declare (fixnum start len radix))
  (if (eq 0 len)
    nil
    (let ((c (%scharcode string start))
          (nstart start)
          (end (+ start len))
          (hic (if (<= radix 10)
                 (+ (char-code #\0) (1- radix))
                 (+ (char-code #\A) (- radix 11))))
          dot dec dgt)
      (declare (fixnum nstart end hic))
      (when (or (eq c (char-code #\+))(eq c (char-code #\-)))
        (setq nstart (1+ nstart)))
      (when (eq nstart end)(return-from new-numtoken nil)) ; just a sign
      (do ((i nstart (1+ i)))
          ((eq i end))
        (let ()
          (setq c (%scharcode string i))
          (cond
           ((eq c (char-code #\.))
            (when dot (return-from new-numtoken nil))
            (setq dot t)
            (when dec (return-from new-numtoken nil))
            (setq hic (char-code #\9)))
           ((< c (char-code #\0)) 
            (when (and (eq c (char-code #\/))(not dot)(not no-rat))
              (let ((top (new-numtoken string start (- i start) radix)))
                (when top 
                  (let ((bottom (new-numtoken string (+ start i 1) (- len i 1) radix t)))
                    (when bottom 
                      (return-from new-numtoken (/ top bottom)))))))
            (return-from new-numtoken nil))
           ((<= c (char-code #\9))
            (when (> c hic)
              ; seen a decimal digit above base.
              (setq dgt t)))
           (t (when (>= c (char-code #\a))(setq c (- c 32)))
              (cond ((or (< c (char-code #\A))(> c hic))
                     (when (and (not dec)(eq radix 10)  ; floats make no sense in other bases I hope?
                                (neq i nstart) ; need some digits first
                                (memq c '#.(list (char-code #\E)(char-code #\F)(char-code #\D)
                                                 (char-code #\L)(char-code #\S))))
                       (return-from new-numtoken (parse-float string len start)))
                      (return-from new-numtoken nil))
                     (t ; seen a "digit" in base that ain't decimal
                      (setq dec t)))))))
      (when (and dot (or (and (neq nstart start)(eq len 2))
                         (eq len 1)))  ;. +. or -.
        (return-from new-numtoken nil))
      (when dot 
        (if (eq c (char-code #\.))
          (progn (setq len (1- len) end (1- end))
                 (when dec (return-from new-numtoken nil))
                 ; make #o9. work (should it)
                 (setq radix 10 dgt nil))
          (return-from new-numtoken (parse-float string len start))))
      (when dgt (return-from new-numtoken nil)) ; so why didnt we quit at first sight of it?
      ; and we ought to accumulate as we go until she gets too big - maybe
      (cond (nil ;(or (and (eq radix 10)(< (- end nstart) 9))(and (eq radix 8)(< (- end nstart) 10)))
             (let ((num 0))
               (declare (fixnum num))
               (do ((i nstart (1+ i)))
                   ((eq i end))
                 (setq num (%i+ (%i* num radix)(%i- (%scharcode string i) (char-code #\0)))))
               (if (eq (%scharcode string start) (char-code #\-)) (setq num (- num)))
               num))                         
            (t (token2int string start len radix))))))


;; Will Clingers number 1.448997445238699
;; Doug Curries numbers 214748.3646, 1073741823/5000
;; My number: 12.
;; Your number:

#-ppc-target ; ppc version in l0;ppc;ppc-numbers.lisp
(defun realpart (number)
   (if (complexp number) (complex.real number)
       (if (numberp number) number (report-bad-arg number 'number))))

#-ppc-target ; ppc version in l0;ppc;ppc-numbers.lisp
(defun imagpart (number)
   (if (complexp number) (complex.imag number)
       (if (floatp number) (float 0.0 number)
           (if (rationalp number) 0
               (report-bad-arg number 'number)))))

#-ppc-target ; ppc version in l0;ppc;ppc-numbers.lisp
(defun zerop (number)
  (numeric-dispatch number
    (integer (eq number 0))
    (short-float (%short-float-zerop number))
    (double-float (%double-float-zerop number))
    (((complex short-float)) (and (%short-float-zerop (complex.real number))
                                  (%short-float-zerop (complex.imag number))))
    (((complex double-float)) (and (%double-float-zerop (complex.real number))
                                   (%double-float-zerop (complex.imag number))))
    (t nil)))

#-ppc-target ; ppc version in l0;ppc;ppc-numbers.lisp
(defun plusp (number)
  (numeric-dispatch number    
    (integer (> number 0))
    (short-float (%short-float-plusp number))
    (double-float (%double-float-plusp number))
    (ratio (> (ratio.num number) 0))
    (t (report-bad-arg number 'real))))

#-ppc-target ; ppc version in l0;ppc;ppc-numbers.lisp
(defun minusp (number)
  (numeric-dispatch number
    (integer (< number 0))
    (short-float (%short-float-minusp number))
    (double-float (%double-float-minusp number))
    (ratio (< (ratio.num number) 0))
    (t (report-bad-arg number 'real))))




(defun logand (&lexpr numbers)
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
            (setq n0 (logand (%lexpr-ref numbers count i) n0))))))))


(defun logior (&lexpr numbers)
  (let* ((count (%lexpr-count numbers)))
    (declare (fixnum count))
    (if (zerop count)
      0
      (let* ((n0 (%lisp-word-ref numbers count)))
        (if (= count 1)
          (require-type n0 'integer)
          (do* ((i 1 (1+ i)))
               ((= i count) n0)
            (declare (fixnum i))
            (declare (optimize (speed 3) (safety 0)))
            (setq n0 (logior (%lexpr-ref numbers count i) n0))))))))

(defun logxor (&lexpr numbers)
  (let* ((count (%lexpr-count numbers)))
    (declare (fixnum count))
    (if (zerop count)
      0
      (let* ((n0 (%lisp-word-ref numbers count)))
        (if (= count 1)
          (require-type n0 'integer)
          (do* ((i 1 (1+ i)))
               ((= i count) n0)
            (declare (fixnum i))
            (declare (optimize (speed 3) (safety 0)))
            (setq n0 (logxor (%lexpr-ref numbers count i) n0))))))))

(defun logeqv (&lexpr numbers)
  (let* ((count (%lexpr-count numbers))
         (result (if (zerop count)
                   0
                   (let* ((n0 (%lisp-word-ref numbers count)))
                     (if (= count 1)
                       (require-type n0 'integer)
                       (do* ((i 1 (1+ i)))
                            ((= i count) n0)
                         (declare (fixnum i))
                         (declare (optimize (speed 3) (safety 0)))
                         (setq n0 (logxor (%lexpr-ref numbers count i) n0))))))))
    (declare (fixnum count))
    (if (evenp count)
      (lognot result)
      result)))

#-ppc-target ; ppc version in l0;ppc;ppc-numbers.lisp
(defun rem (number divisor)
  (%numdiv 
   1                                    ; Truncate
   -1                                   ; Need remainder only
   number
   divisor))

#-ppc-target ; ppc version in l0;ppc;ppc-numbers.lisp
(defun mod (number divisor)
  (%numdiv
   3                                    ; Floor
   -1                                   ; Need remainder only
   number
   divisor))


(defun = (num &lexpr more)
  (let* ((count (%lexpr-count more)))
    (declare (fixnum count))
    (if (zerop count)
      (progn
        (require-type num 'number)
        t)
      (dotimes (i count t)
        (unless (=-2 (%lexpr-ref more count i) num) (return))))))

(defun /= (num &lexpr more)
  (let* ((count (%lexpr-count more)))
    (declare (fixnum count))
    (if (zerop count)
      (progn
        (require-type num 'number)
        t)
      (dotimes (i count t)
        (declare (fixnum i))
        (do ((j i (1+ j)))
            ((= j count))
          (declare (fixnum j))
          (when (=-2 num (%lexpr-ref more count j))
            (return-from /= nil)))
        (setq num (%lexpr-ref more count i))))))

(defun - (num &lexpr more)
  (let* ((count (%lexpr-count more)))
    (declare (fixnum count))
    (if (zerop count)
      (- num)
      (dotimes (i count num)
        (setq num (--2 num (%lexpr-ref more count i)))))))

(defun / (num &lexpr more)
  (let* ((count (%lexpr-count more)))
    (declare (fixnum count))
    (if (zerop count)
      (%quo-1 num)
      (dotimes (i count num)
        (setq num (/-2 num (%lexpr-ref more count i)))))))

(defun + (&lexpr numbers)
  (let* ((count (%lexpr-count numbers)))
    (declare (fixnum count))
    (if (zerop count)
      0
      (let* ((n0 (%lisp-word-ref numbers count)))
        (if (= count 1)
          (require-type n0 'number)
          (do* ((i 1 (1+ i)))
               ((= i count) n0)
            (declare (fixnum i))
            (setq n0 (+-2 (%lexpr-ref numbers count i) n0))))))))



(defun * (&lexpr numbers)
  (let* ((count (%lexpr-count numbers)))
    (declare (fixnum count))
    (if (zerop count)
      1
      (let* ((n0 (%lisp-word-ref numbers count)))
        (if (= count 1)
          (require-type n0 'number)
          (do* ((i 1 (1+ i)))
               ((= i count) n0)
            (declare (fixnum i))
            (declare (optimize (speed 3) (safety 0)))
            (setq n0 (*-2 (%lexpr-ref numbers count i) n0))))))))


(defun < (num &lexpr more)
  (let* ((count (%lexpr-count more)))
    (declare (fixnum count))
    (if (zerop count)
      (progn
        (require-type num 'real)
        t)
      (dotimes (i count t)
        (declare (optimize (speed 3) (safety 0)))
        (unless (< num (setq num (%lexpr-ref more count i)))
          (return))))))

(defun <= (num &lexpr more)
  (let* ((count (%lexpr-count more)))
    (declare (fixnum count))
    (if (zerop count)
      (progn
        (require-type num 'real)
        t)
      (dotimes (i count t)
        (declare (optimize (speed 3) (safety 0)))
        (unless (<= num (setq num (%lexpr-ref more count i)))
          (return))))))


(defun > (num &lexpr more)
  (let* ((count (%lexpr-count more)))
    (declare (fixnum count))
    (if (zerop count)
      (progn
        (require-type num 'real)
        t)
      (dotimes (i count t)
        (declare (optimize (speed 3) (safety 0)))
        (unless (> num (setq num (%lexpr-ref more count i)))
          (return))))))

(defun >= (num &lexpr more)
  (let* ((count (%lexpr-count more)))
    (declare (fixnum count))
    (if (zerop count)
      (progn
        (require-type num 'real)
        t)
      (dotimes (i count t)
        (declare (optimize (speed 3) (safety 0)))
        (unless (>= num (setq num (%lexpr-ref more count i)))
          (return))))))

(defun max-2 (n0 n1)
  (if (> n0 n1) n0 n1))

(defun max (num &lexpr more)
  (let* ((count (%lexpr-count more)))
    (declare (fixnum count))
    (if (zerop count)
      (require-type num 'real)
      (dotimes (i count num)
        (declare (optimize (speed 3) (safety 0)))
        (setq num (max-2 (%lexpr-ref more count i) num))))))

(defun min-2 (n0 n1)
  (if (< n0 n1) n0 n1))

(defun min (num &lexpr more)
  (let* ((count (%lexpr-count more)))
    (declare (fixnum count))
    (if (zerop count)
      (require-type num 'real)
      (dotimes (i count num)
        (declare (optimize (speed 3) (safety 0)))
        (setq num (min-2 (%lexpr-ref more count i) num))))))
 


;Not CL. Used by transforms.
(defun deposit-byte (value size position integer)
  (let ((mask (byte-mask size)))
    (logior (ash (logand value mask) position)
            (logandc1 (ash mask position) integer))))

(defun deposit-field (value bytespec integer)
  (logior (logandc1 bytespec integer) (logand bytespec value)))

;;;;;;;;;;  Byte field functions ;;;;;;;;;;;;;;;;

(defun byte (size position)
  (unless (and (integerp position) (not (minusp position))) (report-bad-arg position 'unsigned-byte))
  (ash (byte-mask size) position))



(defun byte-size (bytespec) (logcount bytespec))

(defun ldb (bytespec integer)
  (if (and (fixnump bytespec) (fixnump integer))
    (%ilsr (byte-position bytespec) (%ilogand bytespec integer))
    (let ((size (byte-size bytespec))
          (position (byte-position bytespec)))
      (if (and (bignump integer)
               (<= size #+ppc-target (- 31 ppc::fixnumshift)
                        #-ppc-target (- 31 $fixnumshift))
               (fixnump position))
        (%ldb-fixnum-from-bignum integer size position)
        (ash (logand bytespec integer) (- position))))))

(defun mask-field (bytespec integer)
  (logand bytespec integer))

(defun dpb (value bytespec integer)
  (if (and (fixnump value) (fixnump bytespec) (fixnump integer))
    (%ilogior (%ilogand bytespec (%ilsl (byte-position bytespec) value))
              (%ilogand (%ilognot bytespec) integer))
    (deposit-field (ash value (byte-position bytespec)) bytespec integer)))

(defun ldb-test (bytespec integer)
  (logtest bytespec integer))

; random associated stuff except for the print-object method which is still in
; "lib;numbers.lisp"
(defun random-state (seed-1 seed-2)
  (unless (and (fixnump seed-1) (%i<= 0 seed-1) (%i< seed-1 #x10000))
    (report-bad-arg seed-1 '(unsigned-byte 16)))
  (unless (and (fixnump seed-2) (%i<= 0 seed-2) (%i< seed-2 #x10000))
    (report-bad-arg seed-2 '(unsigned-byte 16)))
  (let ((shift (%i- 16
                    #+ppc-target ppc::fixnum-shift
                    #-ppc-target $fixnumshift)))
    (gvector :istruct
             'random-state
             (%ilsl shift seed-1)
             (%ilsl shift seed-2))))

(defparameter *random-state* (random-state #xFBF1 9))

#+ignore
(defun init-random-state-seeds ()
  (let ((high (%get-word (%int-to-ptr #$ticks)))
        (low (%get-word (%int-to-ptr (+ #$ticks 2)))))
    (declare (fixnum high low))
    (values (the fixnum (ash high (- 16 ppc::fixnum-shift)))
            (the fixnum (ash low (- 16 ppc::fixnum-shift))))))
#-ignore
(defun init-random-state-seeds ()
  (let* ((it (#_TickCount))
         (high (logand #xffff (ash it -16)))
         (low (logand it #xffff)))
    (declare (fixnum high low))
    (values (the fixnum (ash high (- 16 ppc::fixnum-shift)))
            (the fixnum (ash low (- 16 ppc::fixnum-shift))))))

(defun make-random-state (&optional state &aux (seed-1 0) (seed-2 0))
  (if (eq state t)
    (multiple-value-setq (seed-1 seed-2) (init-random-state-seeds))
    (progn
      (setq state (require-type (or state *random-state*) 'random-state))
      (setq seed-1 (random.seed-1 state) seed-2 (random.seed-2 state))))
  (gvector :istruct 'random-state seed-1 seed-2))

(defun random-state-p (thing) (istruct-typep thing 'random-state))

#+ppc-target
(progn
;;; PPC transcendental stuff.  Should go in level-0;ppc;ppc-float,
;;; but shleps don't work in level-0.  Or do they ?
; Destructively set z to x^y and return z.
  (defun %double-float-expt! (b e result)
    (declare (double-float b e result))
    (with-ppc-stack-double-floats ((temp))
      (%setf-double-float temp (#_pow b e))
      (%df-check-exception-2 'expt b e)
      (%setf-double-float result TEMP)))

(defun %double-float-sin! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_sin n))
    (%df-check-exception-1 'sin n)
    (%setf-double-float result TEMP)))

(defun %double-float-cos! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_cos n))
    (%df-check-exception-1 'cos n)
    (%setf-double-float result TEMP)))

(defun %double-float-acos! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_acos n))
    (%df-check-exception-1 'acos n)
    (%setf-double-float result TEMP)))

(defun %double-float-asin! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_asin n))
    (%df-check-exception-1 'asin n)
    (%setf-double-float result TEMP)))


(defun %double-float-cosh! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_cosh n))
    (%df-check-exception-1 'cosh n)
    (%setf-double-float result TEMP)))


(defun %double-float-log! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_log n))
    (%df-check-exception-1 'log n)
    (%setf-double-float result TEMP)))

(defun %double-float-log2! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_log2 n))
    (%df-check-exception-1 'log2 n)
    (%setf-double-float result TEMP)))

(defun %double-float-log10! (n result)
  (declare (double-float n result)) 
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_log10 n))
    (%df-check-exception-1 'log10 n)
    (%setf-double-float result TEMP)))


(defun %double-float-tan! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_tan n))
    (%df-check-exception-1 'tan n)
    (%setf-double-float result TEMP)))


(defun %double-float-atan! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_atan n))
    (%df-check-exception-1 'atan n)
    (%setf-double-float result TEMP)))


(defun %double-float-atan2! (x y result)
  (declare (double-float x y result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_atan2 x y))
    (%df-check-exception-2 'atan2 x y)
    (%setf-double-float result TEMP)))



(defun %double-float-exp! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_exp n))
    (%df-check-exception-1 'exp n)
    (%setf-double-float result TEMP)))


(defun %double-float-sinh! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_sinh n))
    (%df-check-exception-1 'sinh n)
    (%setf-double-float result TEMP)))

(defun %double-float-cosh! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_cosh n))
    (%df-check-exception-1 'cosh n)
    (%setf-double-float result TEMP)))


(defun %double-float-tanh! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_tanh n))
    (%df-check-exception-1 'tanh n)
    (%setf-double-float result TEMP)))


(defun %double-float-asinh! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_asinh n))
    (%df-check-exception-1 'asinh n)
    (%setf-double-float result TEMP)))


(defun %double-float-acosh! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_acosh n))
    (%df-check-exception-1 'acosh n)
    (%setf-double-float result TEMP)))



(defun %double-float-atanh! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_atanh n))
    (%df-check-exception-1 'atanh n)
    (%setf-double-float result TEMP)))


(defun %double-float-sqrt! (n result)
  (declare (double-float n result))
  (with-ppc-stack-double-floats ((temp))
    (%setf-double-float TEMP (#_sqrt n))
    (%df-check-exception-1 'sqrt n)
    (%setf-double-float result TEMP)))
)

  




#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
