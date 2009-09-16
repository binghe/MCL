;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  33 1/22/97 akh   %multiply-and-add-harder-loop, %multiply-and-add-loop do it all
;;                   add %normalize-bignum-2 does the whole business in lap
;;                   add %floor-loop-quo and no-quo for truncate of bignum and fixnum or single-digit bignum
;;                  no more %floor => %floor-sub, its all together now.
;;                  ; spell bignnum-minusp right in inline decl
;;                  ; bignum-ashift-left-unaligned does everything in the lap loop
;;                  tweeks and twiddles
;;  32 10/6/96 akh  check for n2 0 before calling fixnum-gcd
;;  31 9/26/96 akh  add integer-gcd, lose bignum-gcd and support
;;  30 7/18/96 akh  do-truncate - do it on the stack first, only cons if necessary ditto bignum-truncate-single-digit
;;  28 6/16/96 akh  alternate commented out ldb32
;;  27 6/7/96  akh  bignum-truncate no quo and no rem
;;  25 5/20/96 akh  truncate-by-fixnum error if fixnum 0
;;  23 3/29/96 akh  fix bignum-shift-right-loop-1 - srAw at the end
;;  22 3/27/96 akh  lots of bug fixes, truncate and multiply-bignums use with-negated-bignum-buffers (dynamic-extent)
;;  20 3/16/96 akh  remove typechecking shift-right-loop
;;  18 3/9/96  akh  lots of inner loops in lap
;;  17 2/19/96 akh  fix remainder sign in bignum-truncate and ..by-fixnum
;;                  truncate-by-fixnum optimization was wrong if negative
;;  14 1/2/96  akh  fix bignum-replace if from-end = T
;;  13 12/24/95 akh add bignum-truncate-by-fixnum, change multiply-fixnums.
;;                  bignum-replace uses %copy-ivector-to-ivector,
;;                  with-bignum-buffers are dynamic-extent
;;  12 12/22/95 gb  digits-sign-bits fix per Alice
;;  8 11/22/95 akh  see below, normalize-bignum-buffer, %floor etc
;;  7 11/19/95 gb   
;;  6 11/14/95 gb   %BIGNUM-SET-LENGTH ends with a blr
;;  5 11/13/95 akh  fix bignum-integer-length
;;                  add %digits-sign-bits
;;                  shift-y-for-truncate uses digits-sign-bits
;;                  add load-byte
;;  (do not edit before this line!!)


; Modification History
;
;; once-only now in ccl package
;;----- 5.2 b6
; akh fix multiply-bignum-and-fixnum for fixnum being most-negative-fixnum
;; ------------- 5.0 final
; 09/19/99 akh add and subtract don't cons if result is a fixnum
;; -------- 4.3f1c1
; 03/03/99 akh bignum-ashift-right - dont cons if result is a fixnum
; 01/31/97 bill  Alice's fixes to %subtract-with-borrow & truncate-guess-loop
; %multiply-and-add-harder-loop, %multiply-and-add-loop do it all
; add %normalize-bignum-2 does the whole business in lap
; add %floor-loop-quo and no-quo for truncate of bignum and fixnum or single-digit bignum
; no more %floor => %floor-sub, its all together now.
; spell bignnum-minusp right in inline decl
; bignum-ashift-left-unaligned does everything in the lap loop
; tweeks and twiddles
; akh do-truncate - do it on the stack first, only cons if necessary ditto bignum-truncate-single-digit
; 06/22/96 bill Better stack overflow hysteresis in:
;                 %fixnum-to-digit, %ashr, %ashl, %digit-logical-shift-right
; 06/04/96 bill Alice's version of %ldb-fixnum-from-bignum
; 05/30/96 bill ldb32 says (%i- (%ilsl size 1) 1) instead of (1- (%ilsl size 1))
;               so that it will get a fixnum instead of a bignum if size is 29.
; 05/09/96 bill %ldb-fixnum-from-bignum handles a position off the end of
;               the bignum, e.g. (load-byte 16 100 #x123456789) => 0
; 04/28/96 alice truncate-by-fixnum error if fixnum 0
; 04/10/96 bill Some fixes from Alice
; 04/07/96 akh fix bignum-buffer-ashift-right to clear high order digits vacated
;                fix %normalize-bignum-buffer to clear to actual bignum-len vs provided len
;		 add normalize-bignum-loop, fix %ldb-fixnum-from-bignum for negative
; 03/29/96 akh fix bignum-shift-right-loop-1
; 03/20/96 bill bignum-truncate-by-fixnum no longer conses to negate a negative dividend
;               unless necessary.
; 03/12/96 gb   Alice's bignum-shift fixes; one big eval-when.
; 02/05/96 bill fix bignum-truncate & bignum-truncate-by-fixnum.
;               Add double-colons where necessary.
;               bignum-truncate-by-fixnum doesn't cons unless necessary.
; 01/05/96 bill Gary's fix to %logcount
; 12/07/95 bill ensure that *32x16-truncate-x* is heap-consed so we don't get an access error on setting it.
; 10/20/95 akh  simpler normalize-bignum-buffer, %floor takes six args, 32X16-truncate-guess trying to dtrt
; 10/19/95 slh   compose-digit -> ppc-lapmacros.lisp
; 10/12/95 slh   minor cleanup
;  8/29/95 slh   finish conversion; include 32x16-divide routines
;  8/28/95 slh   append rest of bignum.lisp, started updating
;  8/26/95 slh   misc. fixes
;  8/25/95 slh   Gary's fix to %logcount
;  8/24/95 slh   added %multiple-and-add

;(in-package "CCL")

;(defconstant maximum-bignum-length (1- (ash 1 24)))
;(deftype bignum-index () `(integer 0 ,(1- (ash 1 24))))

(eval-when (:compile-toplevel :execute)
  (require "PPC-ARCH" "ccl:compiler;ppc;ppc-arch")
  (require "PPC-LAPMACROS")
  (require "NUMBER-MACROS")
  
  (defconstant digit-size 32)
  (defconstant half-digit-size (/ digit-size 2))
  
  (defconstant maximum-bignum-length (1- (ash 1 24)))

  (deftype bignum-index () `(integer 0 (,maximum-bignum-length)))
  (deftype bignum-element-type () `(unsigned-byte ,digit-size))
  (deftype bignum-half-element-type () `(unsigned-byte ,half-digit-size))
  (deftype bignum-type () 'bignum)
  (defmacro %bignum-digits (bignum)`(uvsize ,bignum))

  (defmacro digit-bind ((&rest digits) form &body body)
    `(multiple-value-bind ,digits
                          ,form
       (declare (type bignum-half-element-type ,@digits))
       ,@body))

  (defmacro digit-set ((&rest digits) form)
    `(multiple-value-setq ,digits
                          ,form))

  (defmacro digit-zerop (h l)
    `(and (zerop ,h) (zerop ,l)))
 


  ;;;; BIGNUM-REPLACE and WITH-BIGNUM-BUFFERS.

  ;;; BIGNUM-REPLACE -- Internal.
  ;;;
  (defmacro bignum-replace (dest src &key (start1 '0) end1 (start2 '0) end2
                                 from-end)
    (once-only ((n-dest dest)
                     (n-src src))
      (if (and (eq start1 0)(eq start2 0)(null end1)(null end2)(null from-end))
        ; this is all true for some uses today <<
        `(%copy-ivector-to-ivector ,n-src 0 ,n-dest 0 (%ilsl 2 (min (the fixnum (%bignum-length ,n-src))
                                                                    (the fixnum (%bignum-length ,n-dest)))))
        (let* ((n-start1 (gensym))
               (n-end1 (gensym))
               (n-start2 (gensym))
               (n-end2 (gensym)))
          `(let ((,n-start1 ,start1)
                 (,n-start2 ,start2)
                 (,n-end1 ,(or end1 `(%bignum-length ,n-dest)))
                 (,n-end2 ,(or end2 `(%bignum-length ,n-src))))
             ,(if (null from-end)            
                `(%copy-ivector-to-ivector
                  ,n-src (%i* 4 ,n-start2) 
                  ,n-dest (%i* 4 ,n-start1)
                  (%i* 4 (min (%i- ,n-end2 ,n-start2) 
                              (%i- ,n-end1 ,n-start1))))
                `(let ((nwds (min (%i- ,n-end2 ,n-start2)
                                  (%i- ,n-end1 ,n-start1))))
                   (%copy-ivector-to-ivector
                    ,n-src (%ilsl 2 (%i- ,n-end2 nwds))
                    ,n-dest (%ilsl 2 (%i- ,n-end1 nwds))
                    (%i* 4 nwds)))))))))
;; also in ppc-numbers
(defmacro fixnum-to-bignum-set (fix big)
  (once-only ((fixv fix))
    `(%bignum-set ,big 0 (%ilogand (%iasr 16 ,fixv) #xffff) (%ilogand ,fixv #xffff)))) 
;; this is also in ppc-numbers.lisp
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
  

  ;;;; Shifting.
  
  (defconstant all-ones-half-digit #xFFFF)  
  
 (defmacro %logand (h1 l1 h2 l2)
    (once-only ((h1v h1)(l1v l1)(h2v h2)(l2v l2)) ; export this plz
      `(values (%ilogand ,h1v ,h2v)(%ilogand ,l1v ,l2v))))
  
  (defmacro %logior (h1 l1 h2 l2)
    (once-only ((h1v h1)(l1v l1)(h2v h2)(l2v l2))
      `(values (%ilogior ,h1v ,h2v)(%ilogior ,l1v ,l2v))))
  
  (defmacro %logxor (h1 l1 h2 l2)
    (once-only ((h1v h1)(l1v l1)(h2v h2)(l2v l2))
      `(values (%ilogxor ,h1v ,h2v)(%ilogxor ,l1v ,l2v))))
  
  
  (defmacro %lognot (h l)
    (once-only ((h1v h)(l1v l))
      `(values (%ilognot ,h1v)(%ilognot ,l1v))))

  (defmacro %allocate-bignum (ndigits)
    `(%alloc-misc ,ndigits ppc::subtag-bignum))

  (defmacro %normalize-bignum-macro (big)
    `(%normalize-bignum-2 t ,big))

  (defmacro %mostly-normalize-bignum-macro (big)
    `(%normalize-bignum-2 nil ,big))


;;; %ALLOCATE-BIGNUM must zero all elements.
;;;
  (declaim (inline  %bignum-length))
  (declaim (inline %digit-0-or-plusp %bignum-0-or-plusp bignum-minusp %digit-compare %bignum-minusp))

)
;(defun %allocate-bignum (ndigits)
;  (%alloc-misc ndigits ppc::subtag-bignum))

;;; Extract the length of the bignum.
;;; 
(defun %bignum-length (bignum)
  (uvsize bignum)) 

(defun %digit-0-or-plusp (high)
  (declare (fixnum high))
  (not (logbitp (1- half-digit-size) high))) 

(defun %bignum-0-or-plusp (bignum len)
  (declare (fixnum len))
  (not (%ilogbitp (1- half-digit-size) (%bignum-ref-hi bignum (the fixnum (1- len))))))

(defun %bignum-minusp (bignum len)
  (declare (fixnum len))
  (%ilogbitp (1- half-digit-size) (%bignum-ref-hi bignum (the fixnum (1- len)))))

(defun bignum-minusp (big)
  (%ilogbitp (1- half-digit-size) (%bignum-ref-hi big (1- (%bignum-length big)))))
  


;;; %BIGNUM-REF needs to access bignums as obviously as possible, and it needs
;;; to be able to return 32 bits somewhere no one looks for real objects.
;;;
;;; The easiest thing to do is to store the 32 raw bits in two fixnums
;;; and return multiple values.

(defppclapfunction %bignum-ref ((bignum arg_y) (i arg_z))
  (vref32 imm0 bignum i imm1)
  (digit-h temp0 imm0)
  (digit-l temp1 imm0)
  (vpush temp0)
  (vpush temp1)
  (la temp0 8 vsp)                      ; ?? why not (mr temp0 vsp) before vpushing?
  (set-nargs 2)                         ; that doesn't make any difference.  And, in this case,
                                        ; we can get away without setting nargs (since the caller
                                        ; called us with 2 args, but that's horrible style.)
  (ba .SPvalues))

(defppclapfunction %bignum-ref-hi ((bignum arg_y) (i arg_z))
  (la imm1 ppc::misc-data-offset i)
  (lhzx imm0 bignum imm1)
  (box-fixnum arg_z imm0)
  (blr))


(defppclapfunction %bignum-set ((bignum 0) (i arg_x) (high arg_y) (low arg_z))
  (compose-digit imm0 high low)
  (lwz arg_z bignum vsp)
  (vset32 imm0 arg_z i imm1)
  (la vsp 4 vsp)
  (blr))



; for oddp, evenp
(defun %bignum-oddp (bignum)
  (%ilogbitp 0 (the fixnum (nth-value 1 (%bignum-ref bignum 0)))))


;;; %ADD-WITH-CARRY -- Internal.
;;;
;;; This should be in assembler, and should not cons intermediate results.  It
;;; returns a 32bit digit (split in half) and a carry resulting from adding 
;;; together the a, b, and an incoming carry.
;;;

#|
(defppclapfunction %add-with-carry ((a-h 4) (a-l 0) (b-h arg_x) (b-l arg_y) (carry-in arg_z))
  (let ((a imm0)
        (b imm1)
        (temp imm2)
        (c imm3))
    (lwz temp0 a-h vsp)
    (lwz temp1 a-l vsp)
    (compose-digit a temp0 temp1)
    (compose-digit b b-h b-l)
    (unbox-fixnum c carry-in)
    (li temp -1)
    (addc temp c temp)
    (adde a a b)
    (addze c rzero)
    (box-fixnum c c)
    (digit-h temp0 a)
    (digit-l temp1 a)
    (vpush temp0)
    (vpush temp1)
    (vpush c)
    (la temp0 20 vsp)
    (set-nargs 3)
    (ba .SPvalues)))
|#

; this is silly 
(defppclapfunction %add-the-carry ((b-h arg_x) (b-l arg_y) (carry-in arg_z))
  (let ((a imm0)
        (b imm1)
        (temp imm2)
        (c imm3))    
    (compose-digit b b-h b-l)
    (unbox-fixnum c carry-in)
    (add b c b)
    (digit-h temp0 b)
    (digit-l temp1 b)
    (vpush temp0)
    (vpush temp1)
    (la temp0 8 vsp)
    (set-nargs 2)
    (ba .SPvalues)))


;;; %SUBTRACT-WITH-BORROW -- Internal.
;;;
;;; This should be in assembler, and should not cons intermediate results.  It
;;; returns a 32bit digit and a borrow resulting from subtracting b from a, and
;;; subtracting a possible incoming borrow.
;;;
;;; We really do:  a - b - 1 + borrow, where borrow is either 0 or 1.
;;; 

(defppclapfunction %subtract-with-borrow ((a-h 4) (a-l 0) (b-h arg_x) (b-l arg_y) (borrow-in arg_z))
  (let ((a imm0)
        (b imm1)
        (temp imm2)
        (c imm3))
    (lwz temp0 a-h vsp)
    (lwz temp1 a-l vsp)
    (compose-digit a temp0 temp1)
    (compose-digit b b-h b-l)
    (unbox-fixnum c borrow-in)
    (li temp -1)
    (addc temp c temp)
    (subfe a b a)
    (addze c rzero)
    (box-fixnum c c)
    (digit-h temp0 a)
    (digit-l temp1 a)
    (vpush temp0)
    (vpush temp1)
    (vpush c)
    (la temp0 20 vsp)
    (set-nargs 3)
    (ba .SPvalues)))

(defppclapfunction %subtract-one ((a-h arg_y)(a-l arg_z))
  (let ((a imm0))
    (compose-digit a a-h a-l)
    (subi a a 1)
    (digit-h temp0 a)
    (vpush temp0)
    (digit-l temp0 a)
    (vpush temp0)
    (la temp0 8 vsp)
    (set-nargs 2)
    (ba .spvalues)))
    

 
;;; %MULTIPLY -- Internal.
;;;
;;; This multiplies two digit-size (32-bit) numbers, returning a 64-bit result
;;; split into two 32-bit quantities.
;;; Or, as fate would have it, into 4 16-bit quantities
;;;
#|
(defppclapfunction %multiply ((x-h 0) (x-l arg_x) (y-h arg_y) (y-l arg_z))
  (let ((x imm0)
        (y imm1)
        (res-h imm2)
        (res-l imm3))
    (lwz temp0 x-h vsp)
    (compose-digit x temp0 x-l)
    (compose-digit y y-h y-l)
    (mullw res-l x y)
    (mulhwu res-h x y)
    (digit-h temp0 res-h)
    (digit-l temp1 res-h)
    (digit-h temp2 res-l)
    (digit-l temp3 res-l)
    (vpush temp0)
    (vpush temp1)
    (vpush temp2)
    (vpush temp3)
    (set-nargs 4)
    (la temp0 20 vsp)
    (ba .SPvalues)))

(defun %multiply-signed-fixnums (x y)
  (let ((res (* x y)))
    (values (logand #xffff (ash res -48))
            (logand #xffff (ash res -32))
            (logand #xffff (ash res -16))
            (logand #xffff res))))
|#

; given 2 fixnums, returns product as 4 16 bit dohickies
(defppclapfunction %multiply-signed-fixnums ((x arg_y)(y arg_z))
  (let ((x-un imm0)
        (y-un imm1)
        (res-h imm2)
        (res-l imm3))
    (unbox-fixnum x-un x)
    (unbox-fixnum y-un y)
    (mullw res-l x-un y-un)
    (mulhw res-h x-un y-un)  ; vs mulhwu
    (digit-h temp0 res-h)
    (digit-l temp1 res-h)
    (digit-h temp2 res-l)
    (digit-l temp3 res-l)
    (vpush temp0)
    (vpush temp1)
    (vpush temp2)
    (vpush temp3)
    (set-nargs 4)
    (la temp0 16 vsp)
    (ba .SPvalues)))


;;; %MULTIPLY-AND-ADD  --  Internal.
;;;
;;; This multiplies x-digit and y-digit, producing high and low digits
;;; manifesting the result.  Then it adds the low digit, res-digit, and
;;; carry-in-digit.  Any carries (note, you still have to add two digits at a
;;; time possibly producing two carries) from adding these three digits get
;;; added to the high digit from the multiply, producing the next carry digit.
;;; Res-digit is optional since two uses of this primitive multiplies a single
;;; digit bignum by a multiple digit bignum, and in this situation there is no
;;; need for a result buffer accumulating partial results which is where the
;;; res-digit comes from.
;;; [slh] I assume that the returned carry "digit" can only be 0, 1 or 2

#|
(defun %multiply-and-add (x-h x-l y-h y-l carry-in-h carry-in-l
                              &optional res-h res-l)
  (declare (type bignum-half-element-type x-h x-l y-h y-l
                 carry-in-h carry-in-l res-h res-l))
  (digit-bind (prod3 prod2 prod1 prod0)
              (%multiply x-h x-l y-h y-l)
    (let (carry carry2)
      (declare (fixnum carry carry2)) ; uh now they are nil
      (multiple-value-setq (prod1 prod0 carry)
        ; add carry in to prod-lo - propagate that carry to prod-hi
        (%add-with-carry prod1 prod0 carry-in-h carry-in-l 0))
      (when res-h
        (multiple-value-setq (prod1 prod0 carry2)
          ; add res to prod-lo - propagate that carry to prod-hi
          (%add-with-carry prod1 prod0 res-h res-l 0))
        (incf carry carry2))
      (unless (zerop carry)
        (multiple-value-setq (prod3 prod2 carry)
          (%add-with-carry prod3 prod2 0 0 carry)))
      (values prod3 prod2 prod1 prod0))))

; multiply x times y - add carry to lo part, propagate carry out to hi part
; return 2 digits of hi part and 2 digits of lo part
(defppclapfunction %multiply-and-add-easy ((xhi 8) (xlo 4) (yhi 0) (ylo arg_x)
                                           (carryhi arg_y)(carrylo arg_z))
  (let ((x imm0)
        (y imm1)
        (prod-h imm2)
        (prod-l imm3))
    (lwz y yhi vsp)
    (rlwinm y y 14 0 15)
    (rlwimi y ylo 30 16 31)
    (lwz x xlo vsp)
    (rlwinm x x 30 16 31)
    (lwz imm2 xhi vsp)
    (rlwimi x imm2 14 0 15)
    (mullw prod-l x y)
    (mulhwu prod-h x y)
    (rlwinm x carryhi 14 0 15)  ; add carry to prod-l
    (rlwimi x carrylo 30 16 31)    
    (addc prod-l prod-l x)         ; check these adds
    (adde prod-h prod-h rzero)      ; carry out to prod-h
    (digit-h temp0 prod-h)
    (vpush temp0)
    (digit-l temp0 prod-h)
    (vpush temp0)
    (digit-h temp0 prod-l)
    (vpush temp0)
    (digit-l temp0 prod-l)
    (vpush temp0)
    (la temp0 28 vsp)
    (set-nargs 4)
    (ba .SPvalues)
    ))
|#

; return carry-hi carry-lo (= halves of prod-h) - no don't just store it at len
(defppclapfunction %multiply-and-add-loop ((Bignum 0)(res arg_x)(len arg_y) (x-box arg_z))
  (let ((x imm0)
        (idx imm1)
        (big temp0)
        ;(res temp1)
        (count temp2)
        (prod-h imm2)
        (prod-l imm3)
        (y imm4))
    (unbox-fixnum x x-box)
    (li idx ppc::misc-data-offset)
    (li count 0)
    (lwz big bignum vsp)
    (li prod-h 0) ; init de carry
    @loop
    (lwzx y big idx)               ; get digit
    (mullw prod-l x y)             ; times x to prod-l
    (addc prod-l prod-l prod-h)    ; add last prod-h with carry out
    (mulhwu prod-h x y)            ; high times x to prod-h    
    (adde prod-h prod-h rzero)     ; add carry out to prod-h    
    (stwx prod-l res idx)    
    (addi count count '1)
    (cmpw count len)
    (addi idx idx '1)
    (blt @loop)
    (stwx prod-h res idx)
    (la vsp 4 vsp)
    (blr)))

#|
(defppclapfunction %multiply-and-add-harder-loop-2 ((x-ptr 4) (y-ptr 0)
                                                    (resptr arg_x)(residx arg_y) (count arg_z))  
  (let ((tem imm0)
        (y imm1)
        (prod-h imm2)
        (prod-l imm3)
        (mumble imm4)
        (xptr temp2)
        (yidx temp1)
        (yptr temp0))
    (lwz xptr x-ptr vsp)
    (addi tem residx ppc::misc-data-offset)
    (lwzx tem xptr tem)
    (stw tem -4 sp) ; thats x    
    (lwz yptr y-ptr vsp)
    (li yidx 0) ; init yidx 0   
    (addc mumble rzero rzero) ; init carry 0, mumble 0
    @loop
    (addi tem yidx ppc::misc-data-offset)   ; get yidx
    (lwzx y yptr tem)    
    (lwz tem -4 sp)  ; thats x
    (mullw prod-l tem y)
    (mulhwu prod-h tem y)
    (addc prod-l prod-l mumble)
    (adde prod-h prod-h rzero)
    (addi tem residx ppc::misc-data-offset)
    (lwzx y resptr tem)    
    (addc prod-l prod-l y)
    (adde prod-h prod-h rzero)
    (stwx prod-l resptr tem)    
    (subic. count count '1)
    (mr mumble prod-h)
    (addi residx residx '1)
    (addi yidx yidx '1)
    (bgt @loop)
    (addi tem residx ppc::misc-data-offset)
    (stwx mumble resptr tem)
    (la vsp 8 vsp)
    (blr)))
|#

;; multiply i'th digit of x by y and add to result starting at digit i
(defppclapfunction %multiply-and-add-harder-loop-2 ((x-ptr 4) (y-ptr 0)
                                                    (resptr arg_x)(residx arg_y) (count arg_z))  
  (let ((tem imm0)
        (y imm1)
        (prod-h imm2)
        (prod-l imm3)
        (x imm4)
        (xptr temp2)
        (yidx temp1)
        (yptr temp0))
    (lwz xptr x-ptr vsp)
    (addi tem residx ppc::misc-data-offset)
    (lwzx x xptr tem)
    (lwz yptr y-ptr vsp)
    (li yidx 0) ; init yidx 0 
    (addc prod-h rzero rzero) ; init carry 0, mumble 0
    @loop
    (addi tem yidx ppc::misc-data-offset)   ; get yidx
    (lwzx y yptr tem) 
    (mullw prod-l x y)
    (addc prod-l prod-l prod-h)
    (mulhwu prod-h x y) ; do we know for sure that this doesn't clobber carry?
    (adde prod-h prod-h rzero)
    (addi tem residx ppc::misc-data-offset)
    (lwzx y resptr tem)    
    (addc prod-l prod-l y)
    (adde prod-h prod-h rzero)
    (stwx prod-l resptr tem)    
    (subic. count count '1)
    (addi residx residx '1)
    (addi yidx yidx '1)
    (bgt @loop)
    (addi tem residx ppc::misc-data-offset)
    (stwx prod-h resptr tem)
    (la vsp 8 vsp)
    (blr)))

(defppclapfunction %logcount ((high arg_y) (low arg_z))
  (let ((arg imm0)
        (shift imm1)
        (temp imm2))
    (compose-digit arg high low)
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

    
;;; %ASHR -- Internal.
;;;
;;; Do an arithmetic shift right of data even though bignum-element-type is
;;; unsigned.
;;;
#|
(defppclapfunction %ashr ((high arg_x) (low arg_y) (count arg_z))
  (let ((c imm1)
        (digit imm0))
    (unbox-fixnum c count)
    (compose-digit digit high low)
    (sraw digit digit c)
    (digit-h high digit)
    (digit-l low digit)
    (vpush high)
    (vpush low)
    (la temp0 8 vsp)
    (set-nargs 2)
    (ba .SPvalues)))

;;; %ASHL -- Internal.
;;;
;;; This takes a 32-bit quantity and shifts it to the left, returning a 32-bit
;;; quantity.
(defppclapfunction %ashl ((high arg_x) (low arg_y) (count arg_z))
  (let ((c imm1)
        (digit imm0))
    (unbox-fixnum c count)
    (compose-digit digit high low)
    (slw digit digit c)
    (digit-h high digit)
    (digit-l low digit)
    (vpush high)
    (vpush low)
    (la temp0 8 vsp)
    (set-nargs 2)
    (ba .SPvalues)))


;;; %DIGIT-LOGICAL-SHIFT-RIGHT  --  Internal
;;;
;;;    Do an unsigned (logical) right shift of a digit by Count.
;;;
(defppclapfunction %digit-logical-shift-right ((high arg_x) (low arg_y) (count arg_z))
  (let ((c imm1)
        (digit imm0))
    (unbox-fixnum c count)
    (compose-digit digit high low)
    (srw digit digit c)
    (digit-h high digit)
    (digit-l low digit)
    (vpush high)
    (vpush low)
    (la temp0 8 vsp)
    (set-nargs 2)
    (ba .SPvalues)))
|#

;;; %BIGNUM-SET-LENGTH -- Internal.
;;;
;;; Change the length of bignum to be newlen.  Newlen must be the same or
;;; smaller than the old length, and any elements beyond newlen must be zeroed.
;;; 
#|
(defppclapfunction %bignum-set-length ((bignum arg_y) (newlen arg_z))
  (let ((header imm0))
    (li header ppc::subtag-bignum)
    (rlwimi header newlen (- ppc::num-subtag-bits ppc::fixnumshift) 0 (- 31 ppc::num-subtag-bits))
    (stw header ppc::misc-header-offset bignum)
    (blr)))
|#

#|
;;; %SIGN-DIGIT -- Internal.
;;;
;;; This returns 0 or "-1" depending on whether the bignum is positive.  This
;;; is suitable for infinite sign extension to complete additions,
;;; subtractions, negations, etc.  This cannot return a -1 represented as
;;; a negative fixnum since it would then have to low zeros.
;;;
(defun %sign-digit (bignum len)
  (declare (fixnum len))
  (let* ((high (%bignum-ref-hi bignum (the fixnum (1- len)))))
    (declare (fixnum high))
    (if (logbitp (1- half-digit-size) high)
      (values (1- (ash 1 half-digit-size)) (1- (ash 1 half-digit-size)))
      (values 0 0))))

;;; %DIGIT-COMPARE and %DIGIT-GREATER -- Internal.
;;;
;;; These take two 32 bit quantities and compare or contrast them without
;;; wasting time with incorrect type checking.
;;;

(defun %digit-compare (x-h x-l y-h y-l)
  (declare (fixnum x-h x-l y-h y-l))
  (and (= x-h y-h)
       (= x-l y-l)))

(defun %digit-greater (x-h x-l y-h y-l)
  (declare (fixnum x-h x-l y-h y-l))
  (if (= x-h y-h)
    (> x-l y-l)
    (> x-h y-h)))
|#


;;;; Addition.
#|
(defun add-bignums (a b)
  (declare (type bignum-type a b))
  (let ((len-a (%bignum-length a))
	(len-b (%bignum-length b)))
    (declare (type bignum-index len-a len-b))
    (multiple-value-bind (a len-a b len-b)
			 (if (> len-a len-b)
                           (values a len-a b len-b)
                           (values b len-b a len-a))
      (declare (type bignum-type a b)
	       (type bignum-index len-a len-b))
      (let* ((len-res (1+ len-a))
	     (res (%allocate-bignum len-res))
	     (carry 0))
	(declare (type bignum-index len-res)
		 (type bignum-type res)
		 (type (mod 2) carry))
        #|
	(dotimes (i len-b)
	  (declare (type bignum-index i))
	  (digit-bind (v-h v-l k)
                      (digit-bind (a-h a-l) (%bignum-ref a i)
                        (digit-bind (b-h b-l) (%bignum-ref b i)
                          (%add-with-carry a-h a-l b-h b-l carry)))
            (declare (type (mod 2) k))
            (%bignum-set res i v-h v-l)
            (setf carry k)))|#
        (setq carry (bignum-add-loop a b res len-b))
        (digit-bind (b-digit-h b-digit-l) (%sign-digit b len-b)
          (if (/= len-a len-b)
            (finish-add a res carry b-digit-h b-digit-l len-b len-a)
            (digit-bind (a-digit-h a-digit-l) (%sign-digit a len-a)
              (digit-bind (res-h res-l)
                          (%add-with-carry a-digit-h a-digit-l b-digit-h b-digit-l carry)
                (%bignum-set res len-a res-h res-l)))))
	(%normalize-bignum res len-res)))))
|#

(defun add-bignums (a b)
  (declare (type bignum-type a b))
  (let* ((len-a (%bignum-length a))
	 (len-b (%bignum-length b))
         (aplus (bignum-plus-p a))
         (bplus (bignum-plus-p b))
         (res-len (if (> len-a len-b)
                    (the fixnum (1+ len-a))
                    (the fixnum (1+ len-b)))))
    (declare (type bignum-index len-a len-b res-len))
    (if (eq aplus bplus)
      (let ((res (%allocate-bignum res-len)))        
        (bignum-add-loop-2 a b res)        
        (%normalize-bignum-macro res))
      (with-bignum-buffers ((res res-len))
        (bignum-add-loop-2 a b res)
        (let ((nres (%normalize-bignum-macro res)))
          (if (fixnump nres) nres (copy-bignum nres)))))))
        

; return res
(defppclapfunction bignum-add-loop-2 ((aptr arg_x)(bptr arg_y) (result arg_z))
  (let ((idx imm0)
        (count imm1)
        (x imm2)
        (y imm3)        
        (len-a temp0)
        (len-b temp1)
        (tem temp2))
    (li idx ppc::misc-data-offset)    
    (lwz imm4 ppc::misc-header-offset aptr)
    (header-length len-a imm4)
    (lwz imm4 ppc::misc-header-offset bptr)
    (header-length len-b imm4)
    ; make a be shorter one
    (cmpw len-a len-b)
    (li count 0)
    ; initialize carry 0
    (addc x rzero rzero)
    (ble @loop)
    ; b shorter - swap em
    (mr tem len-a)
    (mr len-a len-b)
    (mr len-b tem)
    (mr tem aptr)
    (mr aptr bptr)
    (mr bptr tem)    
    @loop
    (lwzx y aptr idx)
    (lwzx x bptr idx)    
    (addi count count '1)
    (cmpw count len-a)
    (adde x x y)
    (stwx x result idx)
    (addi idx idx '1)
    (blt @loop)
    ; now propagate carry thru longer (b) using sign of shorter    
    ;(SUBI imm4 idx '1) ; y has hi order word of a
    ;(lwzx y aptr imm4)
    (cmpw len-a len-b)
    (adde imm4 rzero rzero) ; get carry
    (srawi y y 31)  ; p.o.s clobbers carry 
    (addic imm4 imm4 -1)  ; restore carry
    (beq @l3)  ; unless equal
    @loop2
    (lwzx x bptr idx)
    (adde x x y)
    (stwx x result idx)
    (addi count count '1)
    (cmpw count len-b)
    (addi idx idx '1)
    (blt @loop2)
    ; y has sign of shorter - get sign of longer to x
    @l3
    (subi imm4 idx '1)
    (lwzx x bptr imm4)
    (adde imm4 rzero rzero) ; get carry
    (srawi x x 31)  ; clobbers carry 
    (addic imm4 imm4 -1)
    (adde x x y)
    (stwx x result idx)
    (blr)))

;; same as above but with initial a index and finishes
(defppclapfunction bignum-add-loop-+ ((init-a 0)(aptr arg_x)(bptr arg_y)(length arg_z))
  (let ((idx imm0)        
        (count imm1)
        (x imm2)
        (y imm3)
        (aidx imm4))
    (li idx ppc::misc-data-offset)
    (lwz aidx init-a vsp)
    (addi aidx aidx ppc::misc-data-offset)
    (li count 0)
    ; initialize carry 0
    (addc x rzero rzero)
    @loop
    (lwzx x aptr aidx)
    (lwzx y bptr idx)
    (adde x x y)
    (stwx x aptr aidx)
    (addi count count '1)
    (cmpw count length)
    (addi idx idx '1)
    (addi aidx aidx '1)
    (blt @loop)
    (lwzx x aptr aidx)  ; add carry into next one
    (adde x x  rzero)
    (stwx x aptr aidx)
    (la vsp 4 vsp)
    (blr)))




;;;; Subtraction.

(defun subtract-bignum (a b)
  (declare (type bignum-type a b))
  (let* ((len-a (%bignum-length a))
	 (len-b (%bignum-length b))
	 (len-res (1+ (max len-a len-b)))
         (aplusp (bignum-plus-p a))
         (bplusp (bignum-plus-p b)))
    (declare (type bignum-index len-a len-b len-res)) ;Test len-res for bounds?
    (if (eq aplusp bplusp)
      (with-bignum-buffers ((res len-res))
        (bignum-subtract-loop a len-a (if (bignum-minusp a) -1 0)
                          b len-b (if (bignum-minusp b) -1 0)
                          res len-res)    
        (setq res (%normalize-bignum-macro res))
        (if (fixnump res) res (copy-bignum res)))
      (let ((res (%allocate-bignum len-res)))
        (bignum-subtract-loop a len-a (if (bignum-minusp a) -1 0)
                          b len-b (if (bignum-minusp b) -1 0)
                          res len-res)
        (%normalize-bignum-macro res)))))
        


(defppclapfunction bignum-subtract-loop ((a 16)(len-a 12)(sa 8)
                                         (b 4) (len-b 0) (sb arg_x)
                                         (result arg_y) (length arg_z))
  (let ((idx imm0)
        (count temp1)
        (x imm2)
        (y imm3)
        (aptr temp0)
        (tlen-a temp2)
        (bptr temp3)
        (sign-a imm1)
        (sign-b imm4)
        (tlen-b arg_x))
    (li idx ppc::misc-data-offset)
    (li count 0)
    (lwz sign-a sa vsp)
    (unbox-fixnum sign-a sign-a)
    (lwz aptr a vsp)
    (lwz bptr b vsp)
    (lwz tlen-a len-a vsp)    
    (unbox-fixnum sign-b sb)  ; get arg_x to imm reg
    (lwz tlen-b len-b vsp)  ; tlen-b is arg_x
    ;(unbox-fixnum sign-b sb)
    ; initialize carry 1
    (li x -1)
    (addic x x 1)
    ;(addc x rzero rzero)  ; or zero?
    ; this could be faster - count down len-a and len-b and use more cr's
    @loop    
    (cmpw count tlen-a)
    (mr x sign-a)
    (bge @a1)
    (lwzx x aptr idx)
    @a1
    (cmpw count tlen-b)
    (mr y sign-b)
    ;(unbox-fixnum y sign-b) ; p.o.s clobbers carry
    (bge @b1)    
    (lwzx y bptr idx)
    @b1
    (subfe x y x)
    (stwx x result idx)
    (addi count count '1)
    (cmpw count length)
    (addi idx idx '1)
    (blt @loop)
    ; return carry
    (li x 0)
    (addze x  rzero)
    (box-fixnum arg_z x)
    (la vsp 20 vsp)
    (blr)))






;;;; Multiplication.

#|
(defun multiply-bignums (a b)
  (declare (type bignum-type a b))
  (let* ((a-plusp (%bignum-0-or-plusp a (%bignum-length a)))
	 (b-plusp (%bignum-0-or-plusp b (%bignum-length b)))
	 (a (if a-plusp a (negate-bignum a)))
	 (b (if b-plusp b (negate-bignum b)))
	 (len-a (%bignum-length a))
	 (len-b (%bignum-length b))
	 (len-res (+ len-a len-b))
	 (res (%allocate-bignum len-res))
	 (negate-res (not (eq a-plusp b-plusp))))
    (declare (type bignum-index len-a len-b len-res))
    (dotimes (i len-a)
      (declare (type bignum-index i))
      (let ((carry-digit-h 0)
            (carry-digit-l 0)
	    (k i))
	(declare (type bignum-index k)
		 (type bignum-half-element-type carry-digit-h carry-digit-l))
        (digit-bind (x-h x-l) (%bignum-ref a i)
          (dotimes (j len-b)
	    (digit-bind (big-carry-h big-carry-l res-digit-h res-digit-l)
                        (digit-bind (y-h y-l) (%bignum-ref b j)
                          (digit-bind (c-h c-l) (%bignum-ref res k)
                            (%multiply-and-add-harder x-h x-l
                                               y-h y-l
                                               c-h c-l
                                               carry-digit-h carry-digit-l)))
	      (%bignum-set res k res-digit-h res-digit-l)
	      (setf carry-digit-h big-carry-h
                    carry-digit-l big-carry-l)
	      (incf k)))
	  (%bignum-set res k carry-digit-h carry-digit-l))))
    (when negate-res (negate-bignum-in-place res))
    (%normalize-bignum res len-res)))
|#

(defun multiply-bignums (a b)
  (declare (type bignum-type a b))
  (let* ((negate-res (neq (bignum-minusp a)(bignum-minusp b))))
    (flet ((do-it (a b)
             (let* ((len-a (%bignum-length a))
                    (len-b (%bignum-length b))
                    (len-res (+ len-a len-b))
	            (res (%allocate-bignum len-res)))
               (declare (type bignum-index len-a len-b len-res))
               (dotimes (i len-a)
                 (declare (type bignum-index i))
                 (%multiply-and-add-harder-loop-2 a b res i len-b))
               res)))
      (declare (dynamic-extent do-it))
      (let ((res (with-negated-bignum-buffers a b do-it)))
        (when negate-res
          (negate-bignum-in-place res))
        (%normalize-bignum-macro res )))))

(defun multiply-bignum-and-fixnum (bignum fixnum)
  (declare (type bignum-type bignum) (fixnum fixnum))
  (if (eq fixnum most-negative-fixnum)
    (with-small-bignum-buffers ((bf fixnum))
      (multiply-bignums bignum bf))
    (let* ((bignum-len (%bignum-length bignum))
           (bignum-plus-p (%bignum-0-or-plusp bignum bignum-len))
	   (fixnum-plus-p (not (minusp fixnum)))
           (negate-res (neq bignum-plus-p fixnum-plus-p)))
      (declare (type bignum-type bignum)
	       (type bignum-index bignum-len))
      (flet ((do-it (bignum fixnum  negate-res)
               (let* ((bignum-len (%bignum-length bignum))
                      (result (%allocate-bignum (the fixnum (1+ bignum-len)))))
                 (declare (type bignum-type bignum)
	                  (type bignum-index bignum-len))
                 (%multiply-and-add-loop bignum result bignum-len fixnum)
                 (when negate-res
                   (negate-bignum-in-place result))
                 (%normalize-bignum-macro result ))))
        (declare (dynamic-extent do-it))
        (if bignum-plus-p
          (do-it bignum (if fixnum-plus-p fixnum (- fixnum))  negate-res)
          (with-bignum-buffers ((b1 (the fixnum (1+ bignum-len))))
            (negate-bignum bignum nil b1)
            (do-it b1 (if fixnum-plus-p fixnum (- fixnum))  negate-res)))))))

;; assume we already know result won't fit in a fixnum
;; only caller is fixnum-*-2
;;

(defun multiply-fixnums (a b)
  (declare (fixnum a b))
  (multiple-value-bind (p1 p2 p3 p4)(%multiply-signed-fixnums a b)
    (declare (fixnum p1 p2 p3 p4))
    (let* ((res-len (if (and (= p1 p2)
                             (or (and (= 0 p2)(not (%ilogbitp 15 p3)))  ; plus - no need hi
                                 (and (= #xffff p2)(%ilogbitp 15 p3)))) ; or minus ditto
                      1
                      2))
           (res (%allocate-bignum res-len)))
      (%bignum-set res 0 p3 p4)  ; least significant
      (if (eq res-len 2)
        (%bignum-set res 1 p1 p2)) ; most significant if needed
      res)))

;;;; GCD.


; holy cow - its 50 times faster
(defun integer-gcd (n1 n2)
  (if (> n1 n2)(integer-gcd-sub n1 n2)(integer-gcd-sub n2 n1)))

(defun integer-gcd-sub (n1 n2) 
  (if (eql n2 0)
    n1
    (if (and (fixnump n1)(fixnump n2))
      ; beware fixnum-gcd go lala land if n2 is 0
      (%fixnum-gcd n1 n2)  ; this makes it a teeeny bit faster.
      (integer-gcd-sub n2 
                       (if (> n2 n1)
                         (rem n2 n1)
                         (rem n1 n2))))))           



;;; NEGATE-BIGNUM -- Public.
;;;
;;; Fully-normalize is an internal optional.  It cause this to always return
;;; a bignum, without any extraneous digits, and it never returns a fixnum.
;;;
(defun negate-bignum (x &optional (fully-normalize t) res)
  (declare (type bignum-type x))
  (let* ((len-x (%bignum-length x))
	 (len-res (1+ len-x))
         (minusp (%bignum-minusp x len-x)))
    (declare (type bignum-index len-x len-res))
    (if (not res) (setq res (%allocate-bignum len-res))) ;Test len-res for range?
    (let ((carry (bignum-negate-loop-really x len-x res)))  ; i think carry is always 0
      (if (eq carry 0)
        (if minusp (%bignum-set res len-x 0 0)(%bignum-set res len-x #xffff #xffff))
        (digit-bind (h l)
                    (if minusp 
                      (%add-the-carry 0 0 carry)
                      (%add-the-carry #xffff #xffff carry))
                    
          (%bignum-set res len-x h l))))
    (if fully-normalize
      (%normalize-bignum-macro res)
      (%mostly-normalize-bignum-macro res))))

;;; NEGATE-BIGNUM-IN-PLACE -- Internal.
;;;
;;; This assumes bignum is positive; that is, the result of negating it will
;;; stay in the provided allocated bignum.
;;;
(defun negate-bignum-in-place (bignum)
  (bignum-negate-loop-really bignum (%bignum-length bignum) bignum)
  bignum)

(defppclapfunction bignum-negate-loop-really ((big arg_x) (len arg_y) (result arg_z))
  (let ((idx imm0)
        (one imm1)
        (x imm2))
    (li idx ppc::misc-data-offset)
    (li one '1)
    ; initialize carry 1
    (li x -1)
    (addic x x 1)
    @loop        
    ;(addi count count '1)    
    ;(cmpw count len)
    (subf. len one len)
    (lwzx x big idx)
    (not x x)
    (adde x x rzero)
    (stwx x result idx)    
    (addi idx idx '1)
    (bgt @loop)
    ; return carry
    (li x 0)
    (adde x x  rzero)
    (box-fixnum arg_z x)
    (blr)))
  

(defun copy-bignum (bignum)
  (let ((res (%allocate-bignum (%bignum-length bignum))))
    (bignum-replace res bignum)
    res))



;;; BIGNUM-ASHIFT-RIGHT -- Public.
;;;
;;; First compute the number of whole digits to shift, shifting them by
;;; skipping them when we start to pick up bits, and the number of bits to
;;; shift the remaining digits into place.  If the number of digits is greater
;;; than the length of the bignum, then the result is either 0 or -1.  If we
;;; shift on a digit boundary (that is, n-bits is zero), then we just copy
;;; digits.  The last branch handles the general case which uses a macro that a
;;; couple other routines use.  The fifth argument to the macro references
;;; locals established by the macro.
;;;
#|
(defun bignum-ashift-right (bignum x)
  (declare (type bignum-type bignum)
	   (fixnum x))
  (let ((bignum-len (%bignum-length bignum)))
    (declare (type bignum-index bignum-len))
    (multiple-value-bind (digits n-bits)
			 (truncate x digit-size)
      (declare (type bignum-index digits))
      (cond
       ((>= digits bignum-len)
	(if (%bignum-0-or-plusp bignum bignum-len) 0 -1))
       ((zerop n-bits)
	(bignum-ashift-right-digits bignum digits))
       (t
	(shift-right-unaligned bignum digits n-bits (- bignum-len digits)
			       ((= j res-len-1)
                                ;(print (list i j))
                                (digit-bind (h l) (%bignum-ref bignum i)
                                  (digit-set (h l) (%ashr h l n-bits))
				  (%bignum-set res j h l))
				(%normalize-bignum res res-len))
			       res))))))
|#

(defun bignum-ashift-right (bignum x)
  (declare (type bignum-type bignum)
           (fixnum x))
  (let ((bignum-len (%bignum-length bignum)))
    (declare (type bignum-index bignum-len))
    (multiple-value-bind (digits n-bits) (truncate x digit-size)
      (declare (type bignum-index digits)(fixnum n-bits))
      (cond
       ((>= digits bignum-len)
        (if (%bignum-0-or-plusp bignum bignum-len) 0 -1))
       ((eql 0 n-bits)
        (bignum-ashift-right-digits bignum digits))
       (t
        (let* ((res-len (- bignum-len digits))
               ;(res (%allocate-bignum res-len))
               (len-1 (1- res-len)))
          (declare (fixnum res-len len-1))
          (with-bignum-buffers ((res res-len))
            (bignum-shift-right-loop-1 n-bits res bignum len-1 digits)
            (let ((the-res (%normalize-bignum-macro res)))
              (if (fixnump the-res) the-res (copy-bignum the-res))))))))))

			       



;;; BIGNUM-ASHIFT-RIGHT-DIGITS -- Internal.
;;;
(defun bignum-ashift-right-digits (bignum digits)
  (declare (type bignum-type bignum)
	   (type bignum-index digits))
  (let* ((res-len (- (%bignum-length bignum) digits))
	 ;(res (%allocate-bignum res-len))
         )
    (declare (type bignum-index res-len)
	     (type bignum-type res))
    (with-bignum-buffers ((res res-len))      
      (bignum-replace res bignum :start2 digits)
      (let ((the-res (%normalize-bignum-macro res)))
        (if (fixnump the-res) the-res (copy-bignum the-res))))))



;;; BIGNUM-ASHIFT-LEFT -- Public.
;;;
;;; This handles shifting a bignum buffer to provide fresh bignum data for some
;;; internal routines.  We know bignum is safe when called with bignum-len.
;;; First we compute the number of whole digits to shift, shifting them
;;; starting to store farther along the result bignum.  If we shift on a digit
;;; boundary (that is, n-bits is zero), then we just copy digits.  The last
;;; branch handles the general case.
;;;
(defun bignum-ashift-left (bignum x &optional bignum-len)
  (declare (type bignum-type bignum)
	   (fixnum x)
	   (type (or null bignum-index) bignum-len))
  (multiple-value-bind (digits n-bits)
		       (truncate x digit-size)
    (declare (fixnum digits n-bits))
    (let* ((bignum-len (or bignum-len (%bignum-length bignum)))
	   (res-len (+ digits bignum-len 1)))
      (declare (fixnum bignum-len res-len))
      (when (> res-len maximum-bignum-length)
	(error "Can't represent result of left shift."))
      (if (zerop n-bits)
        (bignum-ashift-left-digits bignum bignum-len digits)
        (bignum-ashift-left-unaligned bignum digits n-bits res-len)))))

;;; BIGNUM-ASHIFT-LEFT-DIGITS -- Internal.
;;;
(defun bignum-ashift-left-digits (bignum bignum-len digits)
  (declare (type bignum-index bignum-len digits))
  (let* ((res-len (+ bignum-len digits))
	 (res (%allocate-bignum res-len)))
    (declare (type bignum-index res-len))
    (bignum-replace res bignum :start1 digits :end1 res-len :end2 bignum-len
		    :from-end t)
    res))

;;; BIGNUM-ASHIFT-LEFT-UNALIGNED -- Internal.
;;;
;;; BIGNUM-TRUNCATE uses this to store into a bignum buffer by supplying res.
;;; When res comes in non-nil, then this foregoes allocating a result, and it
;;; normalizes the buffer instead of the would-be allocated result.
;;;
;;; We start storing into one digit higher than digits, storing a whole result
;;; digit from parts of two contiguous digits from bignum.  When the loop
;;; finishes, we store the remaining bits from bignum's first digit in the
;;; first non-zero result digit, digits.  We also grab some left over high
;;; bits from the last digit of bignum.
;;;

#| 
(defun bignum-ashift-left-unaligned (bignum digits n-bits res-len
				     &optional (res nil resp))
  (declare (type bignum-index digits res-len)
	   (type (mod #.digit-size) n-bits))
  (let* ((remaining-bits (- digit-size n-bits))
	 (res-len-1 (1- res-len))
	 (res (or res (%allocate-bignum res-len))))
    (declare (type bignum-index res-len res-len-1))
    (do ((i 0 i+1)
	 (i+1 1 (1+ i+1))
	 (j (1+ digits) (1+ j)))
	((= j res-len-1)
         (digit-bind (h l) (%bignum-ref bignum 0)
           (digit-set (h l) (%ashl h l n-bits))
	   (%bignum-set res digits h l))
         (digit-bind (h l) (%bignum-ref bignum i)
           (digit-set (h l) (%ashr h l remaining-bits))
	   (%bignum-set res j h l))
	 (if resp
           (%normalize-bignum-buffer res res-len)
           (%normalize-bignum res res-len)))
      (declare (type bignum-index i i+1 j))
      (digit-bind (h l)
                  (digit-bind (a-h a-l) (%bignum-ref bignum i)
                    (digit-set (a-h a-l) (%digit-logical-shift-right a-h a-l remaining-bits))
                    (digit-bind (b-h b-l) (%bignum-ref bignum i+1)
                      (digit-set (b-h b-l) (%ashl b-h b-l n-bits))
                      (%logior a-h a-l b-h b-l)))
        (%bignum-set res j h l)))))
|#
#|
(defun bignum-ashift-left-unaligned (bignum digits n-bits res-len
                                              &optional (res nil resp))
  (declare (type bignum-index digits res-len)
           (type (mod #.digit-size) n-bits))
  (let* ((remaining-bits (- digit-size n-bits))
         (res-len-1 (1- res-len))
         (res (or res (%allocate-bignum res-len))))
    (declare (type bignum-index res-len res-len-1))
    (Unless (= 0 res-len-1)
      (bignum-shift-left-loop n-bits res bignum res-len-1 (1+ digits)))
    (digit-bind (h l) (%bignum-ref bignum 0) ; do first (lo)
      (digit-set (h l) (%ashl h l n-bits))
      (%bignum-set res digits h l))
    (let* ((i (- res-len-1 (1+ digits)))
           (j res-len-1))
      (declare (fixnum i j))
      (digit-bind (h l) (%bignum-ref bignum i) ; do last (hi)
        (digit-set (h l) (%ashr h l remaining-bits))
        (%bignum-set res j h l)))
    (if resp
      (%normalize-bignum-buffer res res-len)
      (%normalize-bignum res res-len))))
|#

(defun bignum-ashift-left-unaligned (bignum digits n-bits res-len
                                              &optional (res nil resp))
  (declare (type bignum-index digits res-len)
           (type (mod #.digit-size) n-bits))
  (let* (;(remaining-bits (- digit-size n-bits))
         (res-len-1 (1- res-len))
         (res (or res (%allocate-bignum res-len))))
    (declare (type bignum-index res-len res-len-1))
    (bignum-shift-left-loop n-bits res bignum res-len-1 (the fixnum (1+ digits)))
    ; if resp provided we don't care about returned value
    (if (not resp) (%normalize-bignum-macro res))))

;; she do tolerate len = jidx
(defppclapfunction bignum-shift-left-loop ((nbits 4)(result 0) (bignum arg_x) (len arg_y) (jidx arg_z))
  (let ((y imm0)
        (idx imm1)
        (bits imm2)
        (rbits imm3)
        (x imm4)
        (iidx temp0)
        (resptr temp1))
    (li iidx 0)
    (lwz bits nbits vsp)
    (lwz resptr result vsp)
    (unbox-fixnum bits bits)
    (subfic rbits bits 32)    
    ;(dbg)
    (lwz imm4 ppc::misc-data-offset bignum)
    (slw imm4 imm4 bits)
    (la y (+ ppc::misc-data-offset -4) jidx)  
    (stwx imm4 y resptr) 
     
    (cmpw len jidx)
    (beq @done)
    @loop
    (addi idx iidx ppc::misc-data-offset)
    (lwzx x bignum idx)
    (srw x x rbits)
    (addi idx idx '1)
    (lwzx y bignum idx)
    (slw y y bits)
    (or x x y)
    (addi idx jidx ppc::misc-data-offset)
    (stwx x resptr idx)
    (addi jidx jidx '1)    
    (cmpw jidx len)
    (addi iidx iidx '1)
    (blt @loop)    
    @done
    ; do first - lo order
       
    ; do last - hi order    
    (addi idx iidx ppc::misc-data-offset)
    ;(dbg t)
    (lwzx y bignum idx)
    (sraw y y rbits)
    (addi idx len ppc::misc-data-offset)
    (stwx y resptr idx)
    (la vsp 8 vsp)
    (blr)))

#|
(defun bignum-shift-right-loop (bits res big len iidx)
  ;(print (list bits res big len iidx))
  (require-type bits 'fixnum)
  (require-type len 'fixnum)
  (require-type iidx 'fixnum)
  (bignum-shift-right-loop-1 bits res big len iidx))
|#


(defppclapfunction bignum-shift-right-loop-1 ((nbits 4)(result 0) (bignum arg_x) (len arg_y) (iidx arg_z))
  (let ((y imm0)
        (idx imm1)
        (bits imm2)
        (rbits imm3)
        (x imm4)
        (jidx temp0)
        (resptr temp1))
    (li jidx 0)
    (lwz bits nbits vsp)
    (lwz resptr result vsp)
    (unbox-fixnum bits bits)
    (cmpw jidx len)
    (subfic rbits bits 32)    
    (bge @done)
    @loop
    (addi idx iidx ppc::misc-data-offset)
    (lwzx x bignum idx)
    (srw x x bits)
    (addi idx idx '1)
    (lwzx y bignum idx)
    (slw y y rbits)
    (or x x y)
    (addi idx jidx ppc::misc-data-offset)
    (stwx x resptr idx)
    (addi jidx jidx '1)    
    (cmpw jidx len)
    (addi iidx iidx '1)
    (blt @loop)
    @done
    (addi idx iidx ppc::misc-data-offset)
    (lwzx x bignum idx)
    (sraw x x bits)
    (addi idx jidx ppc::misc-data-offset)
    (stwx x resptr idx)
    (la vsp 8 vsp)
    (blr)))


;;;; Relational operators.

;;; BIGNUM-PLUS-P -- Public.
;;;
;;; Return T iff bignum is positive.
;;; 
(defun bignum-plus-p (bignum)
  (declare (type bignum-type bignum))
  (let ((len (%bignum-length bignum)))
    (declare (fixnum len))
    (not (%ilogbitp (1- half-digit-size) (%bignum-ref-hi bignum (the fixnum (1- len)))))))

;;; BIGNUM-COMPARE -- Public.
;;;
;;; This compares two bignums returning -1, 0, or 1, depending on whether a
;;; is less than, equal to, or greater than b.
;;;
;(proclaim '(function bignum-compare (bignum bignum) (integer -1 1)))
(defun bignum-compare (a b &optional (len-a (%bignum-length a)) (len-b (%bignum-length b)))
  (declare (type bignum-type a b))
  (let* (;(len-a (%bignum-length a))
	 ;(len-b (%bignum-length b))
	 (a-plusp (%bignum-0-or-plusp a len-a))
	 (b-plusp (%bignum-0-or-plusp b len-b)))
    (declare (type bignum-index len-a len-b))
    (cond ((not (eq a-plusp b-plusp))
	   (if a-plusp 1 -1))
	  ((= len-a len-b)
           (bignum-compare-loop a b len-a))
          #|
	   (do ((i (1- len-a) (1- i)))
	       (())
	     (declare (type bignum-index i))
	     (digit-bind (a-digit-h a-digit-l) (%bignum-ref a i)
               (digit-bind (b-digit-h b-digit-l) (%bignum-ref b i)
	         (when (%digit-greater a-digit-h a-digit-l b-digit-h b-digit-l)
		   (return 1))
	         (when (%digit-greater b-digit-h b-digit-l a-digit-h a-digit-l)
		   (return -1))))
	     (when (zerop i) (return 0)))) |#
	  ((> len-a len-b)
	   (if a-plusp 1 -1))
	  (t (if a-plusp -1 1)))))

(defppclapfunction bignum-compare-loop ((a arg_x) (b arg_y) (len arg_z))
  (let ((x imm0)
        (y imm1)
        (idx imm2))
    (addi idx len (- ppc::misc-data-offset 4))
    @loop
    (lwzx x a idx)
    (lwzx y b idx)
    (cmpl :cr1 x y)
    (subic. len len '1)
    (subi idx idx '1)
    (bgt :cr1 @gt)
    (blt :cr1 @lt)    
    (bgt :cr0 @loop)
    (li arg_z 0)   ; was all =
    (blr)
    @gt
    (li arg_z '1)
    (blr)
    @lt
    (li arg_z '-1)
    (blr)))




;;;; Integer length and logcount

#|
(defun bignum-integer-length (bignum)
  (declare (type bignum-type bignum))
  (let* ((len (%bignum-length bignum))
	 (len-1 (1- len)))
    (digit-bind (digit-h digit-l) (%bignum-ref bignum len-1)
      (declare (type bignum-index len len-1))
      (+ (integer-length (%fixnum-digit-with-correct-sign digit-h digit-l))
         (* len-1 digit-size)))))
|#

(defun bignum-integer-length (big)
  (let ((ndigits (uvsize big)))
    (declare (fixnum ndigits))
    (multiple-value-bind (most-hi most-lo)(%bignum-ref big (1- ndigits))
      (declare (fixnum most-hi most-lo))
      (%i- (ash ndigits 5)
           (%digits-sign-bits most-hi most-lo)))))


;; returns number of bits in digit-hi,digit-lo that are sign bits
;; 32 - digits-sign-bits is integer-length

(defppclapfunction %digits-sign-bits ((hi arg_y) (lo arg_z))
  (rlwinm. imm1 hi (- 16 ppc::fixnumshift) 0 15)
  (rlwimi imm1 lo (- 32 ppc::fixnumshift) 16 31)
  (not imm1 imm1)
  (blt @wasneg)
  (not imm1 imm1)
  @wasneg
  (cntlzw imm1 imm1)
  (box-fixnum arg_z imm1)
  (blr))


; (not (zerop (logand integer1 integer2)

(defun bignum-logtest (num1 num2)
  (let* ((length1 (%bignum-length num1))
         (length2 (%bignum-length num2))
         (n1-minusp (%bignum-minusp num1 length1))
         (n2-minusp (%bignum-minusp num2 length2)))
    (declare (fixnum length1 length2))
    (if (and n1-minusp n2-minusp) ; both neg, get out quick
      T        
      (let ((val (bignum-logtest-loop (min length1 length2) num1 num2)))
                 #|(do* ((index 0 (1+ index)))
	              ((= index (min length1 length2)) nil)
                   ; maybe better to start from high end of shorter?
                   (multiple-value-bind (hi1 lo1)(%bignum-ref num1 index)
                     (multiple-value-bind (hi2 lo2)(%bignum-ref num2 index)
                       (when (or (not (zerop (%ilogand hi1 hi2)))
                                 (not (zerop (%ilogand lo1 lo2))))
                         (return t)))))))|#
        (or val
            (when (not (eql length1 length2)) ; lengths same => value nil
              (if (< length1 length2)
                n1-minusp
                n2-minusp)))))))

(defppclapfunction bignum-logtest-loop ((count arg_x) (s1 arg_y) (s2 arg_z))  
  (addi imm1 rzero ppc::misc-data-offset)
  @loop
  (lwzx imm2 s1 imm1)
  (lwzx imm3 s2 imm1)
  (and. imm2 imm3 imm2)  
  (addi imm1 imm1 4)
  (bne @true)
  (subic. count count 4)
  (bgt  @loop)
  (mr arg_z rnil)
  (blr)
  @true
  (addi arg_z rnil ppc::t-offset)
  (blr))

(defun logtest-fix-big (fix big)
  (declare (fixnum fix))
  (if (eql 0 (the fixnum fix))
    nil
    (if (> (the fixnum fix) 0) 
      (let ()
        (multiple-value-bind (hi lo)(%bignum-ref big 0)
          (declare (fixnum hi lo))
          (or (not (zerop (logand fix lo)))
              (not (zerop (logand (ash fix (- 16)) hi))))))
      t)))


(defun bignum-logcount (bignum)
  (declare (type bignum-type bignum))
  (let* ((length (%bignum-length bignum))
	 (plusp (%bignum-0-or-plusp bignum length))
	 (result 0))
    (declare (type bignum-index length)
	     (fixnum result))
    (do ((index 0 (1+ index)))
	((= index length) result)
      (declare (fixnum index))
      (digit-bind (digit-h digit-l) (%bignum-ref bignum index)
        (unless plusp
          (digit-set (digit-h digit-l) (%lognot digit-h digit-l)))
	(incf result (%logcount digit-h digit-l))))))


;;;; Logical operations.

;;; NOT.
;;;

;;; BIGNUM-LOGICAL-NOT -- Public.
;;;
(defun bignum-logical-not (a)
  (declare (type bignum-type a))
  (let* ((len (%bignum-length a))
	 (res (%allocate-bignum len)))
    (declare (type bignum-index len))
    (bignum-not-loop len a res)
    #|
    (dotimes (i len res)
      (declare (type bignum-index i))
      (digit-bind (h l) (%bignum-ref a i)
        (%bignum-set res i (%ilognot h) (%ilognot l))))|#
    ))

(defppclapfunction bignum-not-loop ((count arg_x) (s1 arg_Y) (dest arg_z))
  ;(lwz imm0 count vsp)
  (addi imm1 rzero ppc::misc-data-offset)
  @loop
  (lwzx imm2 s1 imm1)
  (not imm2 imm2)
  (subic. count count 4)
  (stwx imm2 dest imm1)
  (addi imm1 imm1 4)
  (bgt @loop)
  @out  
  (blr))


;;; AND.
;;;

;;; BIGNUM-LOGICAL-AND -- Public.
;;;
(defun bignum-logical-and (a b)
  (declare (type bignum-type a b))
  (let* ((len-a (%bignum-length a))
	 (len-b (%bignum-length b))
	 (a-plusp (%bignum-0-or-plusp a len-a))
	 (b-plusp (%bignum-0-or-plusp b len-b)))
    (declare (type bignum-index len-a len-b))
    (cond
     ((< len-a len-b)
      (if a-plusp
	  (logand-shorter-positive a len-a b (%allocate-bignum len-a))
	  (logand-shorter-negative a len-a b len-b (%allocate-bignum len-b))))
     ((< len-b len-a)
      (if b-plusp
	  (logand-shorter-positive b len-b a (%allocate-bignum len-b))
	  (logand-shorter-negative b len-b a len-a (%allocate-bignum len-a))))
     (t (logand-shorter-positive a len-a b (%allocate-bignum len-a))))))

;;; LOGAND-SHORTER-POSITIVE -- Internal.
;;;
;;; This takes a shorter bignum, a and len-a, that is positive.  Because this
;;; is AND, we don't care about any bits longer than a's since its infinite 0
;;; sign bits will mask the other bits out of b.  The result is len-a big.
;;;
(defun logand-shorter-positive (a len-a b res)
  (declare (type bignum-type a b res)
	   (type bignum-index len-a))
  (bignum-and-loop len-a a b res)
  #|
  (dotimes (i len-a)
    (declare (type bignum-index i))
    (digit-bind (a-h a-l) (%bignum-ref a i)
     (digit-bind (b-h b-l) (%bignum-ref b i)
      (%bignum-set res i (%ilogand a-h b-h)(%ilogand a-l b-l)))))|#
  (%normalize-bignum-macro res))

;;; LOGAND-SHORTER-NEGATIVE -- Internal.
;;;
;;; This takes a shorter bignum, a and len-a, that is negative.  Because this
;;; is AND, we just copy any bits longer than a's since its infinite 1 sign
;;; bits will include any bits from b.  The result is len-b big.
;;;
(defun logand-shorter-negative (a len-a b len-b res)
  (declare (type bignum-type a b res)
	   (type bignum-index len-a len-b))
  (bignum-and-loop len-a a b res)
  #|
  (dotimes (i len-a)
    (declare (type bignum-index i))
    (digit-bind (a-h a-l) (%bignum-ref a i)
     (digit-bind (b-h b-l) (%bignum-ref b i)
      (%bignum-set res i (%ilogand a-h b-h)(%ilogand a-l b-l)))))|#
  (bignum-replace res b :start1 len-a :start2 len-a :end1 len-b :end2 len-b)
  (%normalize-bignum-macro res))

(defppclapfunction bignum-and-loop ((count 0) (s1 arg_x) (s2 arg_y) (dest arg_z))
  (lwz imm0 count vsp)
  (addi imm1 rzero ppc::misc-data-offset)
  @loop
  (lwzx imm2 s1 imm1)
  (lwzx imm3 s2 imm1)
  (and imm2 imm3 imm2)
  (subic. imm0 imm0 4)
  (stwx imm2 dest imm1)
  (addi imm1 imm1 4)
  (bgt @loop)
  @out
  (la vsp 4 vsp)
  (blr))

;;;
;;;
;;; bignum-logandc2

(defun bignum-logandc2 (a b)
  (declare (type bignum-type a b))
  (let* ((len-a (%bignum-length a))
	 (len-b (%bignum-length b))
	 (a-plusp (%bignum-0-or-plusp a len-a))
	 (b-plusp (%bignum-0-or-plusp b len-b)))
    (declare (type bignum-index len-a len-b))
    (cond
     ((< len-a len-b)
      (logandc2-shorter-any a len-a b len-b (if a-plusp (%allocate-bignum len-a) (%allocate-bignum len-b))))
     ((< len-b len-a) ; b shorter 
      (logandc1-shorter-any b len-b a len-a (if b-plusp (%allocate-bignum len-a)(%allocate-bignum len-b))))
     (t (logandc2-shorter-any a len-a b len-b (%allocate-bignum len-a))))))

(defun logandc2-shorter-any (a len-a b len-b res)
  (declare (type bignum-type a b res)
           (type bignum-index len-a len-b))
  (bignum-andc2-loop len-a a b res)
  #|
  (dotimes (i len-a)
    (declare (type bignum-index i))
    (digit-bind (ah al) (%bignum-ref a i)
      (digit-bind (bh bl) (%bignum-ref b i)
        (%bignum-set res i (%ilogand ah (%ilognot bh ))(%ilogand al (%ilognot bl))))))|#
  (if (bignum-minusp a)
    (progn
      (do ((i len-a (1+ i)))
          ((= i len-b))
        (declare (type bignum-index i))
        (digit-bind (h l) (%bignum-ref b i)
          (%bignum-set res i (%ilognot h) (%ilognot l))))
      (%normalize-bignum-macro res))
    (%normalize-bignum-macro res)))

(defppclapfunction bignum-andc2-loop ((count 0) (s1 arg_x) (s2 arg_y) (dest arg_z))
  (lwz imm0 count vsp)
  (addi imm1 rzero ppc::misc-data-offset)
  @loop
  (lwzx imm2 s1 imm1)
  (lwzx imm3 s2 imm1)
  (andc imm2 imm2 imm3)
  (subic. imm0 imm0 4)
  (stwx imm2 dest imm1)
  (addi imm1 imm1 4)
  (bgt @loop)
  @out
  (la vsp 4 vsp)
  (blr))

(defun logandc1-shorter-any (a len-a b len-b res)
  (declare (type bignum-type a b res)
           (type bignum-index len-a len-b))
  (bignum-andc1-loop len-a a b res)
  #|
  (dotimes (i len-a)
    (declare (type bignum-index i))
    (digit-bind (ah al) (%bignum-ref a i)
      (digit-bind (bh bl) (%bignum-ref b i)
        (%bignum-set res i (%ilogand (%ilognot ah) bh )(%ilogand (%ilognot al)  bl)))))|#
  (if (%bignum-0-or-plusp a len-a)
    (progn
      (if (neq len-a len-b)
        (bignum-replace res b :start1 len-a :start2 len-a :end1 len-b :end2 len-b))      
      (%normalize-bignum-macro res))
    (%normalize-bignum-macro res)))

(defppclapfunction bignum-andc1-loop ((count 0) (s1 arg_x) (s2 arg_y) (dest arg_z))
  (lwz imm0 count vsp)
  (addi imm1 rzero ppc::misc-data-offset)
  @loop
  (lwzx imm2 s1 imm1)
  (lwzx imm3 s2 imm1)
  (andc imm2 imm3 imm2)
  (subic. imm0 imm0 4)
  (stwx imm2 dest imm1)
  (addi imm1 imm1 4)
  (bgt @loop)
  @out
  (la vsp 4 vsp)
  (blr))

(defun fix-big-logand (fix big)
  (let* ((len-b (%bignum-length big))
         (res (if (< fix 0)(%allocate-bignum len-b))))
    (declare (fixnum fix len-b))        
    (let ((val (fix-digit-logand fix big res)))
      (if res
        (progn
          (bignum-replace res big :start1 1 :start2 1 :end1 len-b :end2 len-b)
          (%normalize-bignum-macro res))
        val))))
  

(defun fix-big-logandc2 (fix big)
  (let* ((len-b (%bignum-length big))
         (res (if (< fix 0)(%allocate-bignum len-b))))
    (declare (fixnum fix len-b))        
    (let ((val (fix-digit-logandc2 fix big res)))
      (if res
        (progn
          (do ((i 1 (1+ i)))
              ((= i len-b))
            (declare (type bignum-index i))
            (digit-lognot-move i big res))
          (%normalize-bignum-macro res))
        val))))

(defun fix-big-logandc1 (fix big)
  (let* ((len-b (%bignum-length big))
         (res (if (>= fix 0)(%allocate-bignum len-b))))
    (declare (fixnum fix len-b))        
    (let ((val (fix-digit-logandc1 fix big res)))
      (if res
        (progn  
          (bignum-replace res big :start1 1 :start2 1 :end1 len-b :end2 len-b)
          (%normalize-bignum-macro res))
        val))))

(defppclapfunction digit-lognot-move ((index arg_x) (source arg_y) (dest arg_z))
  (let ((scaled-index imm1))
    (vref32 imm0 source index scaled-index) ; imm1 has c(index) + data-offset
    (not imm0 imm0)
    (stwx imm0 dest scaled-index)
    (blr)))

; if dest not nil store unboxed result in dest(0), else return boxed result
(defppclapfunction fix-digit-logandc2 ((fix arg_x) (big arg_y) (dest arg_z)) ; index 0
  (let ((w1 imm0)
        (w2 imm1))
    (unbox-fixnum  w1 fix)
    (lwz w2 ppc::misc-data-offset big)
    (cmpw dest rnil)
    (not w2 w2)
    (and w1 w1 w2)
    (bne @store)
    (box-fixnum arg_z w1)
    (blr)
    @store
    (stw w1 ppc::misc-data-offset dest)
    (blr)))

(defppclapfunction fix-digit-logand ((fix arg_x) (big arg_y) (dest arg_z)) ; index 0
  (let ((w1 imm0)
        (w2 imm1))
    (unbox-fixnum  w1 fix)
    (lwz w2 ppc::misc-data-offset big)
    (cmpw dest rnil)
    (and w1 w1 w2)
    (bne @store)
    (box-fixnum arg_z w1)
    (blr)
    @store
    (stw w1 ppc::misc-data-offset dest)
    (blr)))

(defppclapfunction fix-digit-logandc1 ((fix arg_x) (big arg_y) (dest arg_z)) ; index 0
  (let ((w1 imm0)
        (w2 imm1))
    (unbox-fixnum  w1 fix)
    (lwz w2 ppc::misc-data-offset big)
    (cmpw dest rnil)
    (not w1 w1)
    (and w1 w1 w2)
    (bne @store)
    (box-fixnum arg_z w1)
    (blr)
    @store
    (stw w1 ppc::misc-data-offset dest)
    (blr)))



;;; IOR.
;;;

;;; BIGNUM-LOGICAL-IOR -- Public.
;;;
(defun bignum-logical-ior (a b)
  (declare (type bignum-type a b))
  (let* ((len-a (%bignum-length a))
	 (len-b (%bignum-length b))
	 (a-plusp (%bignum-0-or-plusp a len-a))
	 (b-plusp (%bignum-0-or-plusp b len-b)))
    (declare (type bignum-index len-a len-b))
    (cond
     ((< len-a len-b)
      (if a-plusp
	  (logior-shorter-positive a len-a b len-b (%allocate-bignum len-b))
	  (logior-shorter-negative a len-a b len-b (%allocate-bignum len-b))))
     ((< len-b len-a)
      (if b-plusp
	  (logior-shorter-positive b len-b a len-a (%allocate-bignum len-a))
	  (logior-shorter-negative b len-b a len-a (%allocate-bignum len-a))))
     (t (logior-shorter-positive a len-a b len-b (%allocate-bignum len-a)))))) ;;; LOGIOR-SHORTER-POSITIVE -- Internal.
;;;
;;; This takes a shorter bignum, a and len-a, that is positive.  Because this
;;; is IOR, we don't care about any bits longer than a's since its infinite
;;; 0 sign bits will mask the other bits out of b out to len-b.  The result
;;; is len-b long.
;;;
(defun logior-shorter-positive (a len-a b len-b res)
  (declare (type bignum-type a b res)
	   (type bignum-index len-a len-b))
  (bignum-ior-loop len-a a b res)
  #|
  (dotimes (i len-a) ; <<
    (declare (type bignum-index i))
    (digit-bind (a-h a-l) (%bignum-ref a i)
      (digit-bind (b-h b-l) (%bignum-ref b i)
      (%bignum-set res i (%ilogior a-h b-h) (%ilogior a-l b-l)))))|#
  
  (if (not (eql len-a len-b))
    (bignum-replace res b :start1 len-a :start2 len-a :end1 len-b :end2 len-b))
  (%normalize-bignum-macro res))

;;; LOGIOR-SHORTER-NEGATIVE -- Internal.
;;;
;;; This takes a shorter bignum, a and len-a, that is negative.  Because this
;;; is IOR, we just copy any bits longer than a's since its infinite 1 sign
;;; bits will include any bits from b.  The result is len-b long.
;;;
(defun logior-shorter-negative (a len-a b len-b res)
  (declare (type bignum-type a b res)
	   (type bignum-index len-a len-b))
  #|
  (dotimes (i len-a)
    (declare (type bignum-index i)) ; <<
    (digit-bind (a-h a-l) (%bignum-ref a i)
      (digit-bind (b-h b-l) (%bignum-ref b i)
      (%bignum-set res i (%ilogior a-h b-h) (%ilogior a-l b-l)))))|#
  (bignum-ior-loop len-a a b res)
  ; silly to propagate sign and then normalize it away
  ; but may need to do at least once - but we are only normalizing from len-a?
  ; ah but the sign needs to be correct
  (do ((i len-a (1+ i)))
      ((= i len-b))
    (declare (type bignum-index i))
    (%bignum-set res i #xffff #xffff))
  (%normalize-bignum-macro res))


(defppclapfunction bignum-ior-loop ((count 0) (s1 arg_x) (s2 arg_y) (dest arg_z))
  (lwz imm0 count vsp)
  ;(cmpw imm0 rzero)
  (addi imm1 rzero ppc::misc-data-offset)
  ;(beq @out)
  @loop
  (lwzx imm2 s1 imm1)
  (lwzx imm3 s2 imm1)
  (or imm2 imm3 imm2)
  (subic. imm0 imm0 4)
  (stwx imm2 dest imm1)
  (addi imm1 imm1 4)
  (bgt @loop)
  @out
  (la vsp 4 vsp)
  (blr))

;;; XOR.
;;;

;;; BIGNUM-LOGICAL-XOR -- Public.
;;;
(defun bignum-logical-xor (a b)
  (declare (type bignum-type a b))
  (let ((len-a (%bignum-length a))
	(len-b (%bignum-length b)))
    (declare (type bignum-index len-a len-b))
    (if (< len-a len-b)
	(bignum-logical-xor-aux a len-a b len-b (%allocate-bignum len-b))
	(bignum-logical-xor-aux b len-b a len-a (%allocate-bignum len-a)))))

;;; BIGNUM-LOGICAL-XOR-AUX -- Internal.
;;;
;;; This takes the the shorter of two bignums in a and len-a.  Res is len-b
;;; long.  Do the XOR.
;;;
(defun bignum-logical-xor-aux (a len-a b len-b res)
  (declare (type bignum-type a b res)
	   (type bignum-index len-a len-b))
  (bignum-xor-loop len-a a b res)
  #|
  (dotimes (i len-a)  ; <<
    (declare (type bignum-index i))
    (digit-bind (a-h a-l) (%bignum-ref a i)
      (digit-bind (b-h b-l) (%bignum-ref b i)
      (%bignum-set res i (%ilogxor a-h b-h)(%ilogxor a-l b-l)))))|#
  (if (neq len-a len-b)
    (let ((sign (if (bignum-minusp a) #xffff 0)))
      (do ((i len-a (1+ i)))
          ((= i len-b))
        (declare (type bignum-index i))
        (digit-bind (h l) (%bignum-ref b i)
          (%bignum-set res i (%ilogxor sign h)(%ilogxor sign l))))))
  (%normalize-bignum-macro res))

(defppclapfunction bignum-xor-loop ((count 0) (s1 arg_x) (s2 arg_y) (dest arg_z))
  (lwz imm0 count vsp)
  (addi imm1 rzero ppc::misc-data-offset)
  @loop
  (lwzx imm2 s1 imm1)
  (lwzx imm3 s2 imm1)
  (xor imm2 imm3 imm2)
  (subic. imm0 imm0 4)
  (stwx imm2 dest imm1)
  (addi imm1 imm1 4)
  (bgt @loop)
  @out
  (la vsp 4 vsp)
  (blr))



;;;; LDB (load byte)

; [slh] 'twas all commented out - thank gawd


;;;; TRUNCATE.

;;; This is the original sketch of the algorithm from which I implemented this
;;; TRUNCATE, assuming both operands are bignums.  I should modify this to work
;;; with the documentation on my functions, as a general introduction.  I've
;;; left this here just in case someone needs it in the future.  Don't look
;;; at this unless reading the functions' comments leaves you at a loss.
;;; Remember this comes from Knuth, so the book might give you the right general
;;; overview.
;;; 
;;;
;;; (truncate x y):
;;;
;;; If X's magnitude is less than Y's, then result is 0 with remainder X.
;;;
;;; Make x and y positive, copying x if it is already positive.
;;;
;;; Shift y left until there's a 1 in the 30'th bit (most significant, non-sign
;;;       digit)
;;;    Just do most sig digit to determine how much to shift whole number.
;;; Shift x this much too.
;;; Remember this initial shift count.
;;;
;;; Allocate q to be len-x minus len-y quantity plus 1.
;;;
;;; i = last digit of x.
;;; k = last digit of q.
;;;
;;; LOOP
;;;
;;; j = last digit of y.
;;;
;;; compute guess.
;;; if x[i] = y[j] then g = #xFFFFFFFF
;;; else g = x[i]x[i-1]/y[j].
;;;
;;; check guess.
;;; %UNSIGNED-MULTIPLY returns b and c defined below.
;;;    a = x[i-1] - (logand (* g y[j]) #xFFFFFFFF).
;;;       Use %UNSIGNED-MULTIPLY taking low-order result.
;;;    b = (logand (ash (* g y[j-1]) -32) #xFFFFFFFF).
;;;    c = (logand (* g y[j-1]) #xFFFFFFFF).
;;; if a < b, okay.
;;; if a > b, guess is too high
;;;    g = g - 1; go back to "check guess".
;;; if a = b and c > x[i-2], guess is too high
;;;    g = g - 1; go back to "check guess".
;;; GUESS IS 32-BIT NUMBER, SO USE THING TO KEEP IN SPECIAL REGISTER
;;; SAME FOR A, B, AND C.
;;;
;;; Subtract g * y from x[i - len-y+1]..x[i].  See paper for doing this in step.
;;; If x[i] < 0, guess is fucked.
;;;    negative g, then add 1
;;;    zero or positive g, then subtract 1
;;; AND add y back into x[len-y+1..i].
;;;
;;; q[k] = g.
;;; i = i - 1.
;;; k = k - 1.
;;;
;;; If k>=0, goto LOOP.
;;;
;;;
;;; Now quotient is good, but remainder is not.
;;; Shift x right by saved initial left shifting count.
;;;
;;; Check quotient and remainder signs.
;;; x pos y pos --> q pos r pos
;;; x pos y neg --> q neg r pos
;;; x neg y pos --> q neg r neg
;;; x neg y neg --> q pos r neg
;;;
;;; Normalize quotient and remainder.  Cons result if necessary.
;;;



;;; These are used by BIGNUM-TRUNCATE and friends in the general case.
;;;
(defvar *truncate-x* nil)
(defvar *truncate-y* nil)

;;; BIGNUM-TRUNCATE -- Public.
;;;
;;; This divides x by y returning the quotient and remainder.  In the general
;;; case, we shift y to setup for the algorithm, and we use two buffers to save
;;; consing intermediate values.  X gets destructively modified to become the
;;; remainder, and we have to shift it to account for the initial Y shift.
;;; After we multiple bind q and r, we first fix up the signs and then return
;;; the normalized results.
;;;


(defun bignum-truncate (x1 y1 &optional no-rem)
  (declare (type bignum-type x1 y1))
  (let* ((x-plusp (%bignum-0-or-plusp x1 (%bignum-length x1)))
	 (y-plusp (%bignum-0-or-plusp y1 (%bignum-length y1))))
    (flet 
      ((do-it (x y) 
         (let* ((len-x (%bignum-length x))
                (len-y (%bignum-length y)))
           (declare (fixnum len-x len-y))
           
           (let ((c (bignum-compare y x len-y len-x)))
             (cond 
              ((eql c 1)  ; >
               (return-from bignum-truncate (values 0 x1)))
              ((eql c 0)(values 1 0))  ; =  might as well since did compare anyway
              ((< len-y 2)
               (multiple-value-bind (q r)
                                    (bignum-truncate-single-digit x len-x y no-rem)
                 (values q
                         (unless no-rem
                           (cond (x-plusp r)
                                 ((typep r 'fixnum) (the fixnum (- (the fixnum r))))
                                 (t (negate-bignum-in-place r)
                                    (%normalize-bignum-macro r )))))))
              (t
               (let* ((len-x+1 (1+ len-x)))
                 (declare (fixnum len-x+1))
                 (with-bignum-buffers ((*truncate-x* len-x+1)
                                       (*truncate-y* (the fixnum (1+ len-y))))
                   (let ((y-shift (shift-y-for-truncate y)))
                     (shift-and-store-truncate-buffers x len-x y len-y y-shift)
                     (values (do-truncate len-x+1 len-y)
                             ;; DO-TRUNCATE must execute first.
                             (when (not no-rem)                               
                               (when (not (eql 0 y-shift))                                  
                                 (let* ((res-len-1 (1- len-y)))
                                   (declare (fixnum res-len-1))
                                   (bignum-shift-right-loop-1 y-shift *truncate-x* *truncate-x* res-len-1 0)))                                
                               (let ((the-res (%normalize-bignum-macro *truncate-x* )))
                                 (if (not (fixnump the-res))
                                   (if x-plusp (copy-bignum the-res) (negate-bignum the-res))
                                   (if x-plusp the-res (the fixnum (- (the fixnum the-res)))))
                                     ))))))))))))
      (multiple-value-bind (q r)(with-negated-bignum-buffers x1 y1 do-it)
        (let ((quotient (cond ((eq x-plusp y-plusp) q)
                              ((typep q 'fixnum) (the fixnum (- (the fixnum q))))
                              (t (negate-bignum-in-place q)
                                 (%normalize-bignum-macro q )))))
          (if no-rem
            quotient            
            (values quotient r)))))))

(defun bignum-rem (x1 y1)
  (declare (type bignum-type x1 y1))  
  (let* ((x-plusp (%bignum-0-or-plusp x1 (%bignum-length x1)))
	 ;(y-plusp (%bignum-0-or-plusp y1 (%bignum-length y1)))
         )
    (flet 
      ((do-it (x y) 
         (let* ((len-x (%bignum-length x))
                (len-y (%bignum-length y)))
           (declare (fixnum len-x len-y))           
           (let ((c (bignum-compare y x len-y len-x)))
             (cond 
              ((eql c 1) (return-from bignum-rem x1))
              ((eql c 0) 0)  ; =  might as well since did compare anyway
              ((< len-y 2)
               (let ((r (bignum-truncate-single-digit-no-quo x len-x y)))  ; phooey 
                 (cond (x-plusp r)
                       ((typep r 'fixnum) (the fixnum (- (the fixnum r))))
                       (t (negate-bignum-in-place r)
                          (%normalize-bignum-macro r )))))
              (t
               (let* ((len-x+1 (1+ len-x)))
                 (declare (fixnum len-x+1))
                 (with-bignum-buffers ((*truncate-x* len-x+1)
                                       (*truncate-y* (the fixnum (1+ len-y))))
                   (let ((y-shift (shift-y-for-truncate y)))
                     (shift-and-store-truncate-buffers x len-x y len-y y-shift)
                     (do-truncate-no-quo len-x+1 len-y)
                     (when (not (eql 0 y-shift))                                 
                       (let* ((res-len-1 (1- len-y)))
                         (declare (fixnum res-len-1))
                         (bignum-shift-right-loop-1 y-shift *truncate-x* *truncate-x* res-len-1 0)))
                     (let ((the-res (%normalize-bignum-macro *truncate-x*)))
                       (if (not (fixnump the-res))
                         (if x-plusp (copy-bignum the-res) (negate-bignum the-res))
                         (if x-plusp the-res (the fixnum (- (the fixnum the-res)))))))))))))))
      (declare (dynamic-extent do-it))
      (with-negated-bignum-buffers x1 y1 do-it))))



;;; BIGNUM-TRUNCATE-SINGLE-DIGIT -- Internal.
;;;
;;; This divides x by y when y is a single bignum digit.  BIGNUM-TRUNCATE fixes
;;; up the quotient and remainder with respect to sign and normalization.
;;;
;;; We don't have to worry about shifting y to make its most significant digit
;;; sufficiently large for %FLOOR to return 32-bit quantities for the q-digit
;;; and r-digit.  If y is a single digit bignum, it is already large enough
;;; for %FLOOR.  That is, it has some bits on pretty high in the digit.
;;;
;;; x is positive
(defun bignum-truncate-single-digit (x len-x y &optional no-rem)
  (declare (type bignum-index len-x))
  (let* ((maybe-q (%allocate-bignum 2))
         (q (if (<= len-x 2) maybe-q (%allocate-bignum len-x)))
	 (r-h 0)
         (r-l 0))
    (declare (dynamic-extent maybe-q))
    (digit-bind (y-h y-l) (%bignum-ref y 0)
      (multiple-value-setq (r-h r-l)(%floor-loop-quo x q y-h y-l))      
      (if (eq q maybe-q)
        (progn 
          (setq q (%normalize-bignum-macro q))
          (if (not (fixnump q)) (setq q (copy-bignum q))))
        (setq q (%normalize-bignum-macro q )))
      ; might as well make a fixnum if possible
      (if no-rem
        q
        (if (> (%digits-sign-bits r-h r-l)  ppc::fixnumshift)
          (values q (%ilogior (%ilsl 16 r-h) r-l))
          (let ((rem (%allocate-bignum 1)))
            (%bignum-set rem 0 r-h r-l)
            (values q rem)))))))

; aka rem
(defun bignum-truncate-single-digit-no-quo (x len-x y)
  (declare (type bignum-index len-x))
  (declare (ignore len-x))
  (let (;(q (%allocate-bignum len-x))
	(r-h 0)
        (r-l 0))
    (progn
      (digit-bind (y-h y-l) (%bignum-ref y 0)
        (multiple-value-setq (r-h r-l)(%floor-loop-no-quo x y-h y-l))
        #|
        (do ((i (1- len-x) (1- i)))
	    ((minusp i))
          (declare (fixnum i))
          (digit-bind (q-digit-h q-digit-l r-digit-h r-digit-l)
                      (digit-bind (x-h x-l) (%bignum-ref x i)
                        (%floor r-h r-l x-h x-l y-h y-l))
            (declare (ignore q-digit-h q-digit-l))
            ;(%bignum-set q i q-digit-h q-digit-l)
	    (setf r-h r-digit-h
                  r-l r-digit-l)))
         |#
        ; might as well make a fixnum if possible
        (if (> (%digits-sign-bits r-h r-l)  ppc::fixnumshift)
          (%ilogior (%ilsl 16 r-h) r-l)
          (let ((rem (%allocate-bignum 1)))
            (%bignum-set rem 0 r-h r-l)
            rem))))))

;; so big deal - we save a one digit bignum for y 
;; and bigger deal if x is negative - we copy or negate x, computing result destructively
;;  - thus avoiding making a negated x in addition to result
;; 
(defun bignum-truncate-by-fixnum (x y)
  (declare (fixnum y))
  (WHEN (eql Y 0)(ERROR (MAKE-CONDITION 'DIVISION-BY-ZERO :OPERATION 'TRUNCATE :OPERANDS (LIST X Y))))
  (let* ((len-x (%bignum-length x))
         (x-minus (%bignum-minusp x len-x))
         (maybe-q (%allocate-bignum 3))
         (q (if x-minus
              (if (<= len-x 2)
                (dotimes (i 3 (negate-bignum-in-place maybe-q))
                  (if (< i len-x)
                    (multiple-value-bind (hi lo) (%bignum-ref x i)
                      (%bignum-set maybe-q i hi lo))
                    (%bignum-set maybe-q i 65535 65535)))
                (negate-bignum x))
              (if (<= len-x 2) ; this was broken if negative because bignum-replace just copies min len-a len-b digits
                (progn
                  (bignum-replace maybe-q x)                
                  maybe-q)
                (%allocate-bignum len-x))))      ;  q is new big or -x
         ;(len-q (%bignum-length q))
         (y-minus (minusp y))         
         (y (if y-minus (- y) y)))
    (declare (fixnum y))
    (declare (type bignum-index len-x len-q))
    (declare (dynamic-extent maybe-q))
    (let* ((r-h 0)
           (r-l 0)
           (y-h (%ilogand #xffff (%iasr 16 y)))
           (y-l (%ilogand #xffff y)))
      (multiple-value-setq (r-h r-l)(%floor-loop-quo (if x-minus q x) q y-h y-l))      
      (let* ((r (%ilogior (%ilsl 16 r-h) r-l)))
        (declare (fixnum r))
        (when (neq x-minus y-minus)(negate-bignum-in-place q))
        (setq q (%normalize-bignum-macro q ))
        (values (if (eq q maybe-q) (copy-bignum q) q)
                (if x-minus (the fixnum (- r)) r))))))

(defun bignum-truncate-by-fixnum-no-quo (x y)
  (declare (fixnum y))
  (WHEN (eql Y 0)(ERROR (MAKE-CONDITION 'DIVISION-BY-ZERO :OPERATION 'TRUNCATE :OPERANDS (LIST X Y))))
  (let* ((len-x (%bignum-length x))
         (x-minus (%bignum-minusp x len-x))
         (y-minus (minusp y))         
         (y (if y-minus (- y) y)))
    (declare (fixnum y))
    (declare (type bignum-index len-x len-q))
      (let* (;(LEN-Q (%BIGNUM-LENGTH Q))
             (r-h 0)
             (r-l 0)
             (y-h (%ilogand #xffff (%iasr 16 y)))
             (y-l (%ilogand #xffff y)))
        (if x-minus
          (with-bignum-buffers ((q (the fixnum (1+ len-x))))
            (negate-bignum x nil q)
            (multiple-value-setq (r-h r-l)(%floor-loop-no-quo q y-h y-l)))
          (multiple-value-setq (r-h r-l)(%floor-loop-no-quo x y-h y-l)))        
        (let* ((r (%ilogior (%ilsl 16 r-h) r-l)))
          (declare (fixnum r))
          (if x-minus (the fixnum (- r)) r)))))


;;; DO-TRUNCATE -- Internal.
;;;
;;; This divides *truncate-x* by *truncate-y*, and len-x and len-y tell us how
;;; much of the buffers we care about.  TRY-BIGNUM-TRUNCATE-GUESS modifies
;;; *truncate-x* on each interation, and this buffer becomes our remainder.
;;;
;;; *truncate-x* definitely has at least three digits, and it has one more than
;;; *truncate-y*.  This keeps i, i-1, i-2, and low-x-digit happy.  Thanks to
;;; SHIFT-AND-STORE-TRUNCATE-BUFFERS.
;;;


(defun do-truncate (len-x len-y)
  (declare (type bignum-index len-x len-y))
  (let* ((len-q (- len-x len-y))
	 ;; Add one for extra sign digit in case high bit is on.
         (len-res (1+ len-q))
         (maybe-q (%allocate-bignum 2))         
	 (q (if (<= len-res 2) maybe-q (%allocate-bignum len-res)))
	 (k (1- len-q))
	 (i (1- len-x))
	 (low-x-digit (- i len-y)))
    (declare (type bignum-index len-q len-res k i  low-x-digit))
    (declare (dynamic-extent maybe-q))
    (loop
      (digit-bind (h l)
                  (digit-bind (guess-h guess-l)
                              (bignum-truncate-guess-2 *truncate-x* i *truncate-y* (the fixnum (1- len-y)))                                  
                    (try-bignum-truncate-guess guess-h guess-l len-y low-x-digit))
        (%bignum-set q k h l))
      (cond ((zerop k) (return))
            (t (decf k)
               (decf low-x-digit)
               (setq i (1- i)))))
    (if (eq q maybe-q)
      (progn 
        (setq q (%normalize-bignum-macro q))
        (if (fixnump q) q (copy-bignum q)))
      (%normalize-bignum-macro q))))

(defun do-truncate-no-quo (len-x len-y)
  (declare (type bignum-index len-x len-y))
  (let* ((len-q (- len-x len-y))
	 (k (1- len-q))
	 (i (1- len-x))
	 (low-x-digit (- i len-y)))
    (declare (type bignum-index len-q k i  low-x-digit))
    (loop
      (digit-bind (guess-h guess-l) (bignum-truncate-guess-2 *truncate-x* i *truncate-y* (the fixnum (1- len-y)))                                 
        (try-bignum-truncate-guess guess-h guess-l len-y low-x-digit)
        (cond ((zerop k) (return))
              (t (decf k)
                 (decf low-x-digit)
                 (setq i (1- i))))))
    nil))

;;; TRY-BIGNUM-TRUNCATE-GUESS -- Internal.
;;;
;;; This takes a digit guess, multiplies it by *truncate-y* for a result one
;;; greater in length than len-y, and subtracts this result from *truncate-x*.
;;; Low-x-digit is the first digit of x to start the subtraction, and we know x
;;; is long enough to subtract a len-y plus one length bignum from it.  Next we
;;; check the result of the subtraction, and if the high digit in x became
;;; negative, then our guess was one too big.  In this case, return one less
;;; than guess passed in, and add one value of y back into x to account for
;;; subtracting one too many.  Knuth shows that the guess is wrong on the order
;;; of 3/b, where b is the base (2 to the digit-size power) -- pretty rarely.
;;;
(defun try-bignum-truncate-guess (guess-h guess-l len-y low-x-digit)
  (declare (type bignum-index low-x-digit len-y))
  (let (;(carry-digit-h 0)
        ;(carry-digit-l 0)
	;(borrow 1)
	(i low-x-digit))
    (declare (type bignum-index i)
	     (fixnum borrow))
    ;; Multiply guess and divisor, subtracting from dividend simultaneously.
    (try-guess-loop-1 guess-h guess-l len-y low-x-digit *truncate-x* *truncate-y*)
    ;; See if guess is off by one, adding one Y back in if necessary.
    (setq i (+ low-x-digit len-y))
    (cond ((%digit-0-or-plusp (%bignum-ref-hi *truncate-x* i))
	   (values guess-h guess-l))
	  (t 
	   ;; If subtraction has negative result, add one divisor value back
	   ;; in.  The guess was one too large in magnitude.
           ;; hmm - happens about 1.6% of the time
           (bignum-add-loop-+ low-x-digit *truncate-x* *truncate-y* len-y)
           (%subtract-one guess-h guess-l)
	   ;(%subtract-with-borrow guess-h guess-l 0 1 1)
           ))))


(defppclapfunction try-guess-loop-1 ((guess-h 8)(guess-l 4)(len-y 0)
                                     (xidx arg_x) (xptr arg_y) (yptr arg_z))
  (let ((guess imm0)
        (carry imm1)
        (y imm2)
        (x imm2)
        (prod-l imm3)
        (prod-h imm4)
        (tem imm4)
        (yidx temp0)
        (end-y temp1)
        (carry-bit temp2))
    (lwz x guess-h vsp)
    (lwz tem guess-l vsp)
    (compose-digit guess x tem)
    (lwz end-y len-y vsp)
    (li yidx 0)
    (li carry 0) 
    (li carry-bit '1)
    @loop
    ; multiply guess by ydigit, add carry to lo, hi is new carry
    ; then get an xdigit subtract prod-lo from it and store result in x (remember carry)
    (addi tem yidx ppc::misc-data-offset)   ; get yidx
    (lwzx y yptr tem)
    (mullw prod-l guess y)
    (mulhwu prod-h guess y)    
    (addc prod-l prod-l carry) 
    (adde carry prod-h rzero)
    ; get back saved carry
    (li tem '-1)
    (addc tem carry-bit tem)
    (addi tem xidx ppc::misc-data-offset)
    (lwzx x xptr tem)    
    (subfe x prod-l x)        
    (stwx x xptr tem)
    ; save carry
    (adde prod-l rzero rzero)
    (box-fixnum carry-bit prod-l)
    (addi yidx yidx '1)
    (cmpw yidx end-y)
    (addi xidx xidx '1)
    (blt @loop)
    ; finally subtract carry from last x digit
    @done
    (li prod-l '-1)  ; get back saved carry again - box clobbered it?
    (addc prod-l carry-bit prod-l)
    (addi tem xidx ppc::misc-data-offset) ; maybe still there - nope
    (lwzx x xptr tem)
    (subfe x carry x)
    (stwx x xptr tem)
    (la vsp 12 vsp)
    (blr)))


;;; BIGNUM-TRUNCATE-GUESS -- Internal.
;;;
;;; This returns a guess for the next division step.  Y1 is the highest y
;;; digit, and y2 is the second to highest y digit.  The x... variables are
;;; the three highest x digits for the next division step.
;;;
;;; From Knuth, our guess is either all ones or x-i and x-i-1 divided by y1,
;;; depending on whether x-i and y1 are the same.  We test this guess by
;;; determining whether guess*y2 is greater than the three high digits of x
;;; minus guess*y1 shifted left one digit:
;;;    ------------------------------
;;;   |    x-i    |   x-i-1  | x-i-2 |
;;;    ------------------------------
;;;    ------------------------------
;;; - | g*y1 high | g*y1 low |   0   |
;;;    ------------------------------
;;;                ...                   <   guess*y2     ???
;;; If guess*y2 is greater, then we decrement our guess by one and try again.
;;; This returns a guess that is either correct or one too large.
;;;
;;; the y's come from *truncate-y*, x's from *truncate-x*
;;; doing this in lap is not screamingly difficult - x's at i, i-1, i-2
#|
(defun bignum-truncate-guess (y1-h y1-l y2-h y2-l x-i-h x-i-l x-i-1-h x-i-1-l x-i-2-h x-i-2-l)
  (declare (type bignum-half-element-type y1-h y1-l y2-h y2-l x-i-h x-i-l x-i-1-h x-i-1-l x-i-2-h x-i-2-l))
  (digit-bind (guess-h guess-l)
              (if (%digit-compare x-i-h x-i-l y1-h y1-l)
                (values all-ones-half-digit all-ones-half-digit)
                ; probably pays to use the remainder vals of floor too? 
                (%floor x-i-h x-i-l x-i-1-h x-i-1-l y1-h y1-l)) ; wants 6 vals?? - assume rh, rl 0
    (loop
      (digit-bind (high-guess*y1-h high-guess*y1-l low-guess*y1-h low-guess*y1-l)
                  (%multiply guess-h guess-l y1-h y1-l) ; hi 0 lo #x40000000
	(digit-bind (high-guess*y2-h high-guess*y2-l low-guess*y2-h low-guess*y2-l)
                    (%multiply guess-h guess-l y2-h y2-l)  ; 0 0
	  (multiple-value-bind (middle-digit-h middle-digit-l borrow)
			       (%subtract-with-borrow x-i-1-h x-i-1-l low-guess*y1-h low-guess*y1-l 1)
            ; mid 0,0 borrow 1 ?
	    (declare (type bignum-half-element-type middle-digit-h middle-digit-l)
		     (fixnum borrow))(print (list 'borrow borrow))
	    ;; Supplying borrow of 1 means there was no borrow, and we know
	    ;; x-i-2 minus 0 requires no borrow.
	    (digit-bind (high-digit-h high-digit-l)
                        (%subtract-with-borrow x-i-h x-i-l high-guess*y1-h high-guess*y1-l borrow)
              (print (list high-digit-h high-digit-l guess-h guess-l))
              (print 
               (%digit-greater high-guess*y2-h high-guess*y2-l middle-digit-h middle-digit-l)) ; nil
              (print 
               (%digit-compare middle-digit-h middle-digit-l high-guess*y2-h high-guess*y2-l)) ; t
              (print 
               (%digit-greater low-guess*y2-h low-guess*y2-l x-i-2-h x-i-2-l)) ; nil
              (if (and (%digit-compare high-digit-h high-digit-l 0 0) ; true
                       (or (%digit-greater high-guess*y2-h high-guess*y2-l
                                           middle-digit-h middle-digit-l)  ; false
                           (and (%digit-compare middle-digit-h middle-digit-l 
                                                high-guess*y2-h high-guess*y2-l)  ; true
                                (%digit-greater low-guess*y2-h low-guess*y2-l x-i-2-h x-i-2-l)))) ; nil
                (digit-set (guess-h guess-l) (%subtract-with-borrow guess-h guess-l 0 1 1))
                (return (values guess-h guess-l))))))))))
|#

#+obsolete
(defun bignum-truncate-guess-2 (x xidx y yidx)
  (digit-bind (guess-h guess-l)
   (digit-bind (x0-h x0-l) (%bignum-ref x xidx) ; could do this better too.
    (digit-bind (y1-h y1-l) (%bignum-ref y yidx)
     (if (%digit-compare x0-h x0-l y1-h y1-l)
       (values all-ones-half-digit all-ones-half-digit)
       (digit-bind (x1-h x1-l)(%bignum-ref x (1- xidx))
        (%floor x0-h x0-l x1-h x1-l y1-h y1-l)))))
    ;(print (list guess-h guess-l))
    ;(print (%floor-99 x xidx y yidx))
    ;(print (list 'g1 guess-h guess-l))   
    (truncate-guess-loop guess-h guess-l x xidx y yidx)))


(defun bignum-truncate-guess-2 (x xidx y yidx)
  (digit-bind (guess-h guess-l)
              (%floor-99 x xidx y yidx)
    (truncate-guess-loop guess-h guess-l x xidx y yidx)))

;; x0 is at index, x1 at index-1, x2 at index-2
;; y1 is at index, y2 at index-1
;; this doesnt help much
(defppclapfunction truncate-guess-loop ((guess-h 8)(guess-l 4)(x 0)
                                        (xidx arg_x)(yptr arg_y) (yidx arg_z))
  (let ((guess imm0)
        (y1 imm1)
        (y2 imm1)
        (gy1-lo imm2) ; look out below
        (gy1-hi imm2)
        (gy2-lo imm2)
        (gy2-hi imm2)
        (xptr temp0)
        (m imm3)
        (tem imm4)
        (y1-idx -4)
        (y2-idx -8)
        (x0-idx -12)
        (x1-idx -16)
        (x2-idx -20))
    (lwz y1 guess-h vsp)
    (lwz tem guess-l vsp)
    (compose-digit guess y1 tem)
    (addi tem yidx ppc::misc-data-offset)
    (lwzx y1 yptr tem)
    (stw y1 y1-idx sp)
    (subi tem tem 4)
    (lwzx y2 yptr tem)
    (stw y2 y2-idx sp)
    (lwz xptr x vsp)
    (addi tem xidx ppc::misc-data-offset)
    (lwzx y1 xptr tem) ; its x0
    (stw y1 x0-idx sp)
    (subi tem tem 4)
    (lwzx y1 xptr tem)
    (stw y1 x1-idx sp)
    (subi tem tem 4)
    (lwzx y1 xptr tem)
    (stw y1 x2-idx sp)
    @loop
    (lwz y1 y1-idx sp)     ; get y1
    (mullw gy1-lo guess y1)
    (lwz m x1-idx sp)      ; get x1
    (subc m m gy1-lo)      ; x1 - gy1-lo => m
    (mulhwu gy1-hi guess y1)
    (lwz tem x0-idx sp)    ; get x0
    (subfe. tem gy1-hi tem)      ; - val not used just cr
    (lwz y2 y2-idx sp)     ; get y2
    (mulhwu gy2-hi guess y2)   ; does it pay to do this now even tho may not need?
    (bne @done)
    (cmpl :cr0 gy2-hi m)       ; if > or = and foo then more - L means logical means unsigned
    (blt @done)           ; if < done
    (bne @more)           ; if = test lo
    (mullw gy2-lo guess y2)
    (lwz tem x2-idx sp) ; get x2
    (cmpl :cr0 gy2-lo tem)
    (ble @done)
    @more
    (subi guess guess 1)
    (b @loop)
    @done
    (digit-h temp0 guess)
    (vpush temp0)
    (digit-l temp0 guess)
    (vpush temp0)
    (la temp0 20 vsp)
    (set-nargs 2)
    (ba .spvalues)))

    

;;; SHIFT-Y-FOR-TRUNCATE -- Internal.
;;;
;;; This returns the amount to shift y to place a one in the second highest
;;; bit.  Y must be positive.  If the last digit of y is zero, then y has a
;;; one in the previous digit's sign bit, so we know it will take one less
;;; than digit-size to get a one where we want.  Otherwise, we count how many
;;; right shifts it takes to get zero; subtracting this value from digit-size
;;; tells us how many high zeros there are which is one more than the shift
;;; amount sought.
;;;
;;; Note: This is exactly the same as one less than the integer-length of the
;;; last digit subtracted from the digit-size.
;;; 
;;; We shift y to make it sufficiently large that doing the 64-bit by 32-bit
;;; %FLOOR calls ensures the quotient and remainder fit in 32-bits.
;;;
(defun shift-y-for-truncate (y)
  (let* ((len (%bignum-length y)))
    (declare (type bignum-index len))
    (multiple-value-bind (last-h last-l) (%bignum-ref y (1- len))
      (1- (%digits-sign-bits last-h last-l)))))

;;; SHIFT-AND-STORE-TRUNCATE-BUFFERS -- Internal.
;;;
;;; Stores two bignums into the truncation bignum buffers, shifting them on the
;;; way in.  This assumes x and y are positive and at least two in length, and
;;; it assumes *truncate-x* and *truncate-y* are one digit longer than x and y.
;;;
(defun shift-and-store-truncate-buffers (x len-x y len-y shift)
  (declare (type bignum-index len-x len-y)
	   (type (integer 0 (#.digit-size)) shift))
  (cond ((eql 0 shift)
	 (bignum-replace *truncate-x* x :end1 len-x)
	 (bignum-replace *truncate-y* y :end1 len-y))
	(t
	 (bignum-ashift-left-unaligned x 0 shift (the fixnum (1+ len-x)) *truncate-x*)
	 (bignum-ashift-left-unaligned y 0 shift (the fixnum (1+ len-y)) *truncate-y*))))




;;;; General utilities.


;;; %NORMALIZE-BIGNUM-BUFFER -- Internal.
;;;
;;; Internal in-place operations use this to fixup remaining digits in the
;;; incoming data, such as in-place shifting.  This is basically the same as
;;; the first form in %NORMALIZE-BIGNUM, but we return the length of the buffer
;;; instead of shrinking the bignum.
;;;


; if the purpose is to nuke extra sign words then try this
; not used any longer
#|
(defun %normalize-bignum-buffer (result len)
  (declare (type bignum-type result)
	   (type bignum-index len))
  (declare (optimize (speed 3)(safety 0)))  
  (let* ((minusp (%bignum-minusp result len)))
    (normalize-bignum-loop (if minusp -1  0) result len)))

(defppclapfunction normalize-bignum-loop ((sign arg_x)(res arg_y)(len arg_z))
  (let ((idx imm0)
        (usign imm1)
        (val imm2))      
    (unbox-fixnum usign sign)
    (cmpwi len 0)
    (addi idx len (- ppc::misc-data-offset 4))  
    (beqlr) ; huh - can this ever happen?
    @loop
    (lwzx val res idx)
    (cmpw  val usign)    
    (subi idx idx '1)
    (bne @neq)    
    (subic. len len '1)
    (bgt @loop)
    ; fall through - its all sign - return 1
    (li arg_z '1)
    (blr)
    @neq
    (rlwinm usign usign 0 0 0) ; hi bit
    (rlwinm val val 0 0 0)
    (cmpw usign val)  ; is hi bit = sign, if so then done   
    (beqlr)
    (addi len len '1) ; if not, need 1 more
    (blr)))
|#
    




;;; %NORMALIZE-BIGNUM -- Internal.
;;;
;;; This drops the last digit if it is unnecessary sign information.  It
;;; repeats this as needed, possibly ending with a fixnum.  If the resulting
;;; length from shrinking is one, see if our one word is a fixnum.  Shift the
;;; possible fixnum bits completely out of the word, and compare this with
;;; shifting the sign bit all the way through.  If the bits are all 1's or 0's
;;; in both words, then there are just sign bits between the fixnum bits and
;;; the sign bit.  If we do have a fixnum, shift it over for the two low-tag
;;; bits.
;;;
#|
(defun %normalize-bignum (result &optional (len (%bignum-length result)))
  (declare (type bignum-type result)
	   (type bignum-index len))
  (let* ((minusp (%bignum-minusp result len))
         (newlen (normalize-bignum-loop (if minusp -1  0) result len)))
    (declare (type bignum-index newlen))    
    (when (= newlen 1)
      (multiple-value-bind (digit-h digit-l)
                           (%bignum-ref result 0)
        (declare (type bignum-half-element-type digit-h digit-l))
        (if (> (the fixnum (%digits-sign-bits digit-h digit-l))  ppc::fixnumshift)
          (return-from %normalize-bignum (%ilogior (%ilsl 16 digit-h) digit-l)))))
    (unless (= newlen len)
      (%bignum-set-length result newlen)
      (when minusp
        (do ((i newlen (1+ i)))
            ((>= i len)) ; paranoid
          (declare (fixnum i))
          (%bignum-set result i 0 0))))
    result))
|#

(defun %normalize-bignum (res)
  (declare (ignore len))
  ;(declare (optimize (speed 3)(safety 0)))
  (%normalize-bignum-2 t res))

;;; %MOSTLY-NORMALIZE-BIGNUM -- Internal.
;;;
;;; This drops the last digit if it is unnecessary sign information.  It
;;; repeats this as needed, possibly ending with a fixnum magnitude but never
;;; returning a fixnum.
;;;
#|
(defun %mostly-normalize-bignum (result &optional (len (%bignum-length result)))
  (declare (type bignum-type result)
	   (type bignum-index len))
  (let* ((minusp (%bignum-minusp result len))
         (newlen (normalize-bignum-loop (if minusp -1 0) result len)))
    (declare (type bignum-index newlen))
    (unless (= newlen len)
      (%bignum-set-length result newlen)
      (when minusp
        (do ((i newlen (1+ i)))
            ((>= i len)) ; paranoid
          (declare (fixnum i))
          (%bignum-set result i 0 0))))
    result))
|#

(defun %mostly-normalize-bignum (res &optional len)
  (declare (ignore len))
  (%normalize-bignum-2 nil res))

(defppclapfunction %normalize-bignum-2 ((fixp arg_y)(res arg_z))
  (let ((idx imm0)
        (usign imm1)
        (val imm2)
        (len arg_x)
        (oldlen temp0))
    (lwz imm4 (- ppc::fulltag-misc) res)
    (header-length len imm4)
    (cmpwi len 0)
    (mr oldlen len)
    (addi idx len (- ppc::misc-data-offset 4))  
    (beqlr) ; huh - can this ever happen?
    (lwzx val res idx) ; high order word
    (srawi usign val 31) ; get sign
    @loop
    (lwzx val res idx)
    (cmpw  val usign)    
    (subi idx idx '1)
    (bne @neq)    
    (subic. len len '1)
    (bgt @loop)
    ; fall through - its all sign - return 1
    (li len '1)
    (rlwinm usign usign 0 0 0) ; hi bit
    (b @more)
    @neq
    (rlwinm usign usign 0 0 0) ; hi bit
    (rlwinm val val 0 0 0)
    (cmpw usign val)  ; is hi bit = sign, if so then done   
    (beq @more)
    (addi len len '1) ; if not, need 1 more
    (b @big)
    @more
    (cmpw :cr1 fixp rnil)
    (cmpwi len '1)
    (beq :cr1 @big)  ; dont return fixnum
    (bgt @big)
    ;; stuff for maybe fixnum
    ;(dbg t)
    (lwz val ppc::misc-data-offset res)
    (rlwinm imm4 val 0 0 2) ; hi 3 bits same? - we assume fixnumshift is 2
    (srawi usign usign 2)
    (cmpw usign imm4)
    (bne @big)    
    (box-fixnum arg_z val)
    (blr)
    @big
    (cmpw oldlen len)
    (beqlr) ; same length - done
    (li imm4 ppc::subtag-bignum) ; set new length
    (rlwimi imm4 len (- ppc::num-subtag-bits ppc::fixnumshift) 0 (- 31 ppc::num-subtag-bits))
    (stw imm4 ppc::misc-header-offset res)
    ; 0 to tail if negative
    (cmpwi usign 0)
    (beqlr) 
     ; zero from len inclusive to oldlen exclusive
    ;(dbg t)
    (addi idx len ppc::misc-data-offset)
    @loop2
    (stwx rzero idx res)
    (addi len len '1)
    (cmpw len oldlen)
    (addi idx idx '1)
    (blt @loop2)
    (blr)))


; think its ok
(defun ldb32 (hi-data lo-data size pos)
  (declare (fixnum hi-data lo-data size pos))
  (let* ((hi-bit (+ pos size))
         (mask (%i- (%ilsl size 1) 1)))
    (declare (fixnum hi-bit mask))    
    (%ilogand mask (if (< hi-bit 16)
                     (%iasr pos lo-data)
                     (if (>= pos 16)
                       (%ilsr (the fixnum (- pos 16)) hi-data)
                       (%ilogior 
                         (%iasr pos lo-data)
                         (%ilsl (the fixnum (- 16 pos)) hi-data)))))))

#|
(defun ldb32 (hi-data lo-data size pos)
  (declare (fixnum hi-data lo-data size pos))
  (let* ((hi-bit (+ pos size))
         (mask (%i- (%ilsl size 1) 1)))
    (declare (fixnum hi-bit mask))    
    (%ilogand mask (if (< hi-bit 16)
                     (ash lo-data (- pos))
                     (if (>= pos 16)
                       (%ilsr (- pos 16) hi-data)
                       (%ilogior 
                         (ash lo-data (- pos))
                         (%ilsl (- 16 pos) hi-data)))))))
|#

#|
(defun %bignum-ref (v i)
  (values (uvref v (+ i i 1))(uvref v (+ i i))))
(defun %bignum-set (v i h lo)
  (setf (uvref v (+ i i 1)) h (uvref v (+ i i) lo)))
(defun bignum-minusp (v)
  (logbitp 15 (uvref v (1- (uvsize v)))))
(defun %bignum-length (v)(* 2 (uvsize v)))
(setq big (make-array 4 :element-type '(unsigned-byte 16)))
|#


; this was wrong for negative bigs when byte includes or exceeds sign
(defun %ldb-fixnum-from-bignum (bignum size position)
  (declare (fixnum size position))
  (let* ((low-idx (ash position -5))
         (low-bit (logand position 31))
         (hi-bit (+ low-bit size))
         (len (%bignum-length bignum))
         (minusp (bignum-minusp bignum)))
    (declare (fixnum size position low-bit hi-bit low-idx len))
    (if (>= low-idx len)
      (if minusp (1- (ash 1 size)) 0)      
      (multiple-value-bind (hi lo)(%bignum-ref bignum low-idx)
        (let ((chunk-lo (ldb32 hi lo (min size (%i- 32 low-bit)) low-bit)))
          (let ((val
                 (if (< hi-bit 32) 
                   chunk-lo
                   (progn
                     (setq low-idx (1+ low-idx))
                     (multiple-value-setq (hi lo)
                       (if (>= low-idx len)
                         (if minusp (values #xffff #xffff)(values 0 0))
                         (%bignum-ref bignum low-idx)))
                     (let ((chunk-hi (ldb32 hi lo (%i- size (%i- 32 low-bit)) 0)))
                       (%ilogior (ash chunk-hi (%i- 32 low-bit)) chunk-lo))))))
            val))))))

(defun load-byte (size position integer)
  (if (and (bignump integer)
           (<= size (- 31 ppc::fixnumshift)) #|#.(integer-length most-positive-fixnum))|#
           (fixnump position))
    (%ldb-fixnum-from-bignum integer size position)
    (let ((mask (byte-mask size)))
      (if (and (fixnump mask) (fixnump integer)(fixnump position)) ;(<= position (- 31 ppc::fixnumshift)))
        ; %iasr was busted when count > 31 - maybe just shouldn't use it
        (%ilogand mask (%iasr position integer))
        (logand mask (ash integer (- position)))))))    

; End of ppc-bignum.lisp
