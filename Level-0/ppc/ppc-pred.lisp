;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: ppc-pred.lisp,v $
;;  Revision 1.5  2006/03/08 02:14:54  alice
;;  ;;; define single-float-p - same as short-float-p
;;; ------- 5.2b1
;;
;;  Revision 1.4  2003/12/08 07:59:30  gtbyers
;;  Replace SGBUF (never used) with SLOT-VECTOR.
;;
;;  14 5/20/96 akh  equal does cons-equal inline too
;;  12 4/1/96  akh  add value-cell to *nodeheader-types*
;;  10 3/9/96  akh  simple-general-string reverts to simple-extended-string
;;  9 2/8/96   akh  ppc:subtag-bignum => ppc::subtag-bignum
;;  8 12/12/95 akh  define base-character-p
;;  7 11/19/95 gb   EQL handles xmacptrs
;;  5 11/6/95  akh  finish %type-of
;;  (do not edit before this line!!)

;;; define single-float-p - same as short-float-p
;;; ------- 5.2b1
;;; 02/14/97 gb   short-float-p, short-float stuff in *IMMHEADER-TYPES*.
;;; ------------ 4.0
;;; 08/07/96 bill %type-of can distinguish a closed over method function
;;;               from a generic function or a combined method.
;;;               %type-of also recognizes a stack-group.
;;; 07/24/96 bill EQUAL sets nargs to 2 before calling EQL (from Alice)
;;; 07/08/96 bill EQL now maintains VSP stack discipline with segmented stacks
;;; 06/30/96 bill EQUAL now maintains VSP stack discipline with segmented stacks
;; equal do cons-equal inline too - could be more elegant
;;; ------------  MCL-PPC 3.9
;;; 04/10/96 gb   faster, better EQUAL.  Still slow ?
;;; 03/10/96 gb   creole-object
;;; 11/06/95 bill EQ moves here from l1-utils so that (make-hash-table :test 'equal) will work

(eval-when (:compile-toplevel :execute)
  (require "PPC-ARCH" "ccl:compiler;ppc;ppc-arch")
  (require "PPC-LAPMACROS" "ccl:compiler;ppc;ppc-lapmacros"))

; Some of these things are probably open-coded.
; The functions have to exist SOMEWHERE ...
(defun fixnump (x)
  (= (the fixnum (ppc-lisptag x)) ppc::tag-fixnum))

(defun bignump (x)
  (= (the fixnum (ppc-typecode x)) ppc::subtag-bignum))

(defun integerp (x)
  (let* ((typecode (ppc-typecode x)))
    (declare (fixnum typecode))
    (or (= typecode ppc::tag-fixnum)
        (= typecode ppc::subtag-bignum))))

(defun ratiop (x)
  (= (the fixnum (ppc-typecode x)) ppc::subtag-ratio))


(defun rationalp (x)
  (or (fixnump x)
      (let* ((typecode (ppc-typecode x)))
        (declare (fixnum typecode))
        (and (>= typecode ppc::min-numeric-subtag)
             (<= typecode ppc::max-rational-subtag)))))



(defun short-float-p (x)
  (= (the fixnum (ppc-typecode x)) ppc::subtag-single-float))

(defun single-float-p (x)
  (= (the fixnum (ppc-typecode x)) ppc::subtag-single-float))




(defun double-float-p (x)
  (= (the fixnum (ppc-typecode x)) ppc::subtag-double-float))

(defun floatp (x)
  (let* ((typecode (ppc-typecode x)))
    (declare (fixnum typecode))
    (and (>= typecode ppc::min-float-subtag)
         (<= typecode ppc::max-float-subtag))))

(defun realp (x)
  (let* ((typecode (ppc-typecode x)))
    (declare (fixnum typecode))
    (or (= typecode ppc::tag-fixnum)
        (and (>= typecode ppc::min-numeric-subtag)
             (<= typecode ppc::max-real-subtag)))))

(defun complexp (x)
  (= (the fixnum (ppc-typecode x)) ppc::subtag-complex))

(defun numberp (x)
  (let* ((typecode (ppc-typecode x)))
    (declare (fixnum typecode))
    (or (= typecode ppc::tag-fixnum)
        (and (>= typecode ppc::min-numeric-subtag)
             (<= typecode ppc::max-numeric-subtag)))))

(defun arrayp (x)
  (>= (the fixnum (ppc-typecode x)) ppc::min-array-subtag))

(defun vectorp (x)
  (>= (the fixnum (ppc-typecode x)) ppc::min-vector-subtag))


(defun stringp (x)
  (let* ((typecode (ppc-typecode x)))
    (declare (fixnum typecode))
    (if (= typecode ppc::subtag-vectorH)
      (setq typecode (ldb ppc::arrayH.flags-cell-subtag-byte (the fixnum (%svref x ppc::arrayH.flags-cell)))))
    (or (= typecode ppc::subtag-simple-base-string)
        (= typecode ppc::subtag-simple-general-string))))

(defun simple-string-p (x)
  (let* ((typecode (ppc-typecode x)))
    (declare (fixnum typecode))
    (or (= typecode ppc::subtag-simple-base-string)
        (= typecode ppc::subtag-simple-general-string))))

(defun simple-base-string-p (x)
  (= (the fixnum (ppc-typecode x)) ppc::subtag-simple-base-string))

(defun complex-array-p (x)
  (let* ((typecode (ppc-typecode x)))
    (declare (fixnum typecode))
    (if (or (= typecode ppc::subtag-arrayH)
            (= typecode ppc::subtag-vectorH))
      (not (%array-header-simple-p x)))))

(setf (type-predicate 'complex-array) 'complex-array-p)

(defun simple-array-p (thing)
  "Returns T if the object is a simple array, else returns NIL.
   That's why it's called SIMPLE-ARRAY-P.  Get it ?
   A simple-array may have no fill-pointer, may not be displaced,
   and may not be adjustable."
  (let* ((typecode (ppc-typecode thing)))
    (declare (fixnum typecode))
    (if (or (= typecode ppc::subtag-arrayH)
            (= typecode ppc::subtag-vectorH))
      (%array-header-simple-p thing)
      (> typecode ppc::subtag-vectorH))))

(defun macptrp (x)
  (= (the fixnum (ppc-typecode x)) ppc::subtag-macptr))


; Note that this is true of symbols and functions and many other
; things that it wasn't true of on the 68K.
(defun gvectorp (x)
  (= (the fixnum (logand (the fixnum (ppc-typecode x)) ppc::fulltagmask)) ppc::fulltag-nodeheader))

(defun miscobjp (x)
  (= (the fixnum (ppc-lisptag x)) ppc::tag-misc))

(defun simple-vector-p (x)
  (= (the fixnum (ppc-typecode x)) ppc::subtag-simple-vector))

(defun base-string-p (thing)
  (let* ((typecode (ppc-typecode thing)))
    (declare (fixnum typecode))
    (or (= typecode ppc::subtag-simple-base-string)
        (and (= typecode ppc::subtag-vectorh)
             (= (the fixnum 
                  (ldb ppc::arrayH.flags-cell-subtag-byte (the fixnum (%svref thing ppc::arrayH.flags-cell))))
                ppc::subtag-simple-base-string)))))

(defun simple-bit-vector-p (form)
  (= (the fixnum (ppc-typecode form)) ppc::subtag-bit-vector))

(defun bit-vector-p (thing)
  (let* ((typecode (ppc-typecode thing)))
    (declare (fixnum typecode))
    (or (= typecode ppc::subtag-bit-vector)
        (and (= typecode ppc::subtag-vectorh)
             (= (the fixnum 
                  (ldb ppc::arrayH.flags-cell-subtag-byte (the fixnum (%svref thing ppc::arrayH.flags-cell))))
                ppc::subtag-bit-vector)))))

(defun displaced-array-p (array)
  (if (%array-is-header array)
    (values (%svref array ppc::arrayH.data-vector-cell)
            (%svref array ppc::arrayH.displacement-cell))
    (values nil 0)))

(setf (type-predicate 'displaced-array) 'displaced-array-p)


(defun eq (x y) (eq x y))

(defppclapfunction eql ((x arg_y) (y arg_z))
  (check-nargs 2)
  @tail
  (cmpw cr0 x y)
  (extract-lisptag imm0 x)
  (extract-lisptag imm1 y)
  (cmpwi cr1 imm0 ppc::tag-misc)
  (cmpwi cr2 imm1 ppc::tag-misc)
  (beq cr0 @win)
  (bne cr1 @lose)
  (bne cr2 @lose)
  ; Objects are both of tag-misc.  Headers must match exactly;
  ; dispatch on subtag.
  (getvheader imm0 x)
  (getvheader imm1 y)
  (cmpw cr0 imm0 imm1)
  (extract-lowbyte imm1 imm1)
  (cmpwi cr1 imm1 ppc::subtag-macptr)
  (cmpwi cr2 imm1 ppc::max-numeric-subtag)
  (beq cr1 @macptr)
  (bne cr0 @lose)
  (bgt cr2 @lose)
  (cmpwi cr0 imm1 ppc::subtag-ratio)
  (cmpwi cr1 imm1 ppc::subtag-complex)
  (beq cr0 @node)
  (beq cr1 @node)
  ; A single-float looks a lot like a macptr to me.
  ; A double-float is simple, a bignum involves a loop.
  (cmpwi cr0 imm1 ppc::subtag-bignum)
  (cmpwi cr1 imm1 ppc::subtag-double-float)
  (beq cr0 @bignum)
  (bne cr1 @one-unboxed-word)                     ; single-float case
  ; This is the double-float case.
  (lwz imm0 ppc::double-float.value x)
  (lwz imm1 ppc::double-float.value y)
  (cmpw cr0 imm0 imm1)
  (lwz imm0 ppc::double-float.val-low x)
  (lwz imm1 ppc::double-float.val-low y)
  (cmpw cr1 imm0 imm1)
  (bne cr0 @lose)
  (bne cr1 @lose)
  @win
  (la arg_z ppc::t-offset rnil)
  (blr)
  @macptr
  (extract-lowbyte imm0 imm0)
  (cmpw cr0 imm1 imm0)
  (bne- cr0 @lose)
  @one-unboxed-word
  (lwz imm0 ppc::misc-data-offset x)
  (lwz imm1 ppc::misc-data-offset y)
  (cmpw cr0 imm0 imm1)
  (beq cr0 @win)
  @lose
  (mr arg_z rnil)
  (blr)
  @bignum
  ; Way back when, we got x's header into imm0.  We know
  ; that y's header is identical.  Use the element-count 
  ; from imm0 to control the loop.  There's no such thing
  ; as a 0-element bignum, so the loop must always execute
  ; at least once.
  (header-size imm0 imm0)
  (li imm1 ppc::misc-data-offset)
  @bignum-next
  (cmpwi cr1 imm0 1)                    ; last time through ?
  (lwzx imm2 x imm1)
  (lwzx imm3 y imm1)
  (cmpw cr0 imm2 imm3)
  (subi imm0 imm0 1)
  (la imm1 4 imm1)
  (bne cr0 @lose)
  (bne cr1 @bignum-next)
  (la arg_z ppc::t-offset rnil)
  (blr)
  @node
  ; Have either a ratio or a complex.  In either case, corresponding
  ; elements of both objects must be EQL.  Recurse on the first
  ; elements.  If true, tail-call on the second, else fail.
  (vpush x)
  (vpush y)
  (save-lisp-context)
  (lwz x ppc::misc-data-offset x)
  (lwz y ppc::misc-data-offset y)
  (bl @tail)
  (cmpw cr0 arg_z rnil)
  (restore-full-lisp-context)
  (vpop y)
  (vpop x)
  (beq cr0 @lose)
  (lwz x (+ 4 ppc::misc-data-offset) x)
  (lwz y (+ 4 ppc::misc-data-offset) y)
  (b @tail))
  

(defun cons-equal (x y)
  (declare (cons x y))
  (if (equal (car x) (car y))
    (equal (cdr x) (cdr y))))

(defun hairy-equal (x y)
  (declare (optimize (speed 3)))
  ; X and Y are not EQL, and are both of tag ppc::fulltag-misc.
  (let* ((x-type (ppc-typecode x))
                 (y-type (ppc-typecode y)))
            (declare (fixnum x-type y-type))
            (if (and (>= x-type ppc::subtag-vectorH)
                     (>= y-type ppc::subtag-vectorH))
              (let* ((x-simple (if (= x-type ppc::subtag-vectorH)
                                 (ldb ppc::arrayH.flags-cell-subtag-byte 
                                      (the fixnum (%svref x ppc::arrayH.flags-cell)))
                                 x-type))
                     (y-simple (if (= y-type ppc::subtag-vectorH)
                                 (ldb ppc::arrayH.flags-cell-subtag-byte 
                                      (the fixnum (%svref y ppc::arrayH.flags-cell)))
                                 y-type)))
                (declare (fixnum x-simple y-simple))
                (if (or (= x-simple ppc::subtag-simple-base-string)
                        (= x-simple ppc::subtag-simple-general-string))
                  (if (or (= y-simple ppc::subtag-simple-base-string)
                          (= y-simple ppc::subtag-simple-general-string))
                    (locally
                      (declare (optimize (speed 3) (safety 0)))
                      (let* ((x-len (if (= x-type ppc::subtag-vectorH) 
                                      (%svref x ppc::vectorH.logsize-cell)
                                      (uvsize x)))
                             (x-pos 0)
                             (y-len (if (= y-type ppc::subtag-vectorH) 
                                      (%svref y ppc::vectorH.logsize-cell)
                                      (uvsize y)))
                             (y-pos 0))
                        (declare (fixnum x-len x-pos y-len y-pos))
                        (when (= x-type ppc::subtag-vectorH)
                          (multiple-value-setq (x x-pos) (array-data-and-offset x)))
                        (when (= y-type ppc::subtag-vectorH)
                          (multiple-value-setq (y y-pos) (array-data-and-offset y)))
                        (%simple-string= x y x-pos y-pos (the fixnum (+ x-pos x-len)) (the fixnum (+ y-pos y-len))))))
                  ; Bit-vector case or fail.
                  (and (= x-simple ppc::subtag-bit-vector)
                       (= y-simple ppc::subtag-bit-vector)
                       (locally
                         (declare (optimize (speed 3) (safety 0)))
                         (let* ((x-len (if (= x-type ppc::subtag-vectorH) 
                                         (%svref x ppc::vectorH.logsize-cell)
                                         (uvsize x)))
                                (x-pos 0)
                                (y-len (if (= y-type ppc::subtag-vectorH) 
                                         (%svref y ppc::vectorH.logsize-cell)
                                         (uvsize y)))
                                (y-pos 0))
                           (declare (fixnum x-len x-pos y-len y-pos))
                           (when (= x-len y-len)
                             (when (= x-type ppc::subtag-vectorH)
                               (multiple-value-setq (x x-pos) (array-data-and-offset x)))
                             (when (= y-type ppc::subtag-vectorH)
                               (multiple-value-setq (y y-pos) (array-data-and-offset y)))
                             (do* ((i 0 (1+ i)))
                                  ((= i x-len) t)
                               (declare (fixnum i))
                               (unless (= (the bit (sbit x x-pos)) (the bit (sbit y y-pos)))
                                 (return))
                               (incf x-pos)
                               (incf y-pos))))))))
              (if (= x-type y-type)
                (if (= x-type ppc::subtag-istruct)
                  (and (let* ((structname (%svref x 0)))
                         (and (eq structname (%svref y 0))
                              (or (eq structname 'pathname)
                                  (eq structname 'logical-pathname))))
                       (locally
                         (declare (optimize (speed 3) (safety 0)))
                         (let* ((x-size (uvsize x)))
                           (declare (fixnum x-size))
                           (if (= x-size (the fixnum (uvsize y)))
                             (do* ((i 1 (1+ i)))
                                  ((= i x-size) t)
                               (declare (fixnum i))
                               (unless (equalp (%svref x i) (%svref y i))
                                 (return))))))))))))

(defppclapfunction equal ((x arg_y) (y arg_z))
  (check-nargs 2)
  @top
  (cmpw cr0 x y)
  (extract-fulltag imm0 x)
  (extract-fulltag imm1 y)
  (cmpw cr1 imm0 imm1)
  (cmpwi cr2 imm0 ppc::fulltag-cons)
  (cmpwi cr3 imm0 ppc::fulltag-misc)
  (beq cr0 @win)
  (bne cr1 @lose)
  (beq cr2 @cons)
  (bne cr3 @lose)
  (extract-typecode imm0 x)
  (extract-typecode imm1 y)
  (cmpwi cr0 imm0 ppc::subtag-macptr)
  (cmpwi cr2 imm0 ppc::subtag-istruct)
  (cmpwi cr1 imm0 ppc::subtag-vectorH)
  (cmpw cr3 imm0 imm1)
  (ble cr0 @eql)
  (cmplwi cr0 imm1 ppc::subtag-vectorH)
  (beq cr2 @same)
  (blt cr1 @lose)
  (bge cr0 @go)
  @lose
  (mr arg_z rnil)
  (blr)
  @same
  (bne cr3 @lose)
  @go
  (set-nargs 2)
  (lwz fname 'hairy-equal nfn)
  (ba .SPjmpsym)
  @eql
  (set-nargs 2)
  (lwz fname 'eql nfn)
  (ba .SPjmpsym)
  @cons
  (vpush x)
  (vpush y)
  (mflr loc-pc)
  ;(bla .spsavecontextvsp) ; is actually slower
  (save-lisp-context)
  (stack-overflow-check)
  (%car x x)
  (%car y y)
  (event-poll)
  (bl @top)
  (cmpw :cr0 arg_z rnil)  
  (mr nfn fn)
  (restore-full-lisp-context)           ; gets old fn to fn  
  (vpop y)
  (vpop x)
  (beq cr0 @lose)
  (%cdr x x)
  (%cdr y y)
  (b @top)
  @win
  (la arg_z ppc::t-offset rnil)
  (blr))


      





(defparameter *immheader-types*
  #(bignum                              ; 0
    short-float                         ; 1
    double-float                        ; 2
    macptr                              ; 3
    dead-macptr                         ; 4
    code-vector                         ; 5
    creole-object                       ; 6
    ;; 7-20 are unused
    bogus                               ; 7
    bogus                               ; 8
    bogus                               ; 9
    bogus                               ; 10
    bogus                               ; 11
    bogus                               ; 12
    bogus                               ; 13
    bogus                               ; 14
    bogus                               ; 15
    bogus                               ; 16
    bogus                               ; 17
    bogus                               ; 18
    bogus                               ; 19
    bogus                               ; 20
    simple-short-float-vector           ; 21
    simple-unsigned-long-vector         ; 22
    simple-signed-long-vector           ; 23
    simple-unsigned-byte-vector         ; 24
    simple-signed-byte-vector           ; 25
    simple-base-string                  ; 26
    simple-extended-string               ; 27 ; was general
    simple-unsigned-word-vector         ; 28
    simple-signed-word-vector           ; 29
    simple-double-float-vector          ; 30
    simple-bit-vector                   ; 31
    ))

(defparameter *nodeheader-types*
  #(bogus                               ; 0
    ratio                               ; 1
    bogus                               ; 2
    complex                             ; 3
    catch-frame                         ; 4
    function                            ; 5
    slot-vector                         ; 6  
    symbol                              ; 7
    lock                                ; 8
    hash-table-vector                   ; 9
    pool                                ; 10
    population                          ; 11
    package                             ; 12
    buffer-mark                         ; 13
    standard-instance                   ; 14
    structure                           ; 15
    internal-structure                  ; 16
    value-cell                          ; 17
    bogus                               ; 18
    bogus                               ; 19
    array-header                        ; 20
    vector-header                       ; 21
    simple-vector                       ; 22
    bogus                               ; 23
    bogus                               ; 24
    bogus                               ; 25
    bogus                               ; 26
    bogus                               ; 27
    bogus                               ; 28
    bogus                               ; 29
    bogus                               ; 30
    bogus                               ; 31
    ))

 
(defun %typecode-specifier (typecode)
  (declare (fixnum typecode))
  (let* ((tag-type (logand typecode ppc::full-tag-mask))
         (tag-val (ash typecode (- ppc::ntagbits))))
    (declare (fixnum tag-type tag-val))
    (cond ((eql tag-type ppc::fulltag-nodeheader)
           (svref *nodeheader-types* tag-val))
          ((eql tag-type ppc::fulltag-immheader)
           (svref *immheader-types* tag-val))
          ((or (eql tag-type ppc::fulltag-even-fixnum)
               (eql tag-type ppc::fulltag-odd-fixnum))
           'fixnum)
          ((eql typecode ppc::subtag-character) 'character)
          ((eql tag-val ppc::fulltag-cons) 'cons)
          ((eql tag-val ppc::fulltag-nil) 'null)
          (t 'immediate))))


(defun %type-of (thing)
  (let* ((typecode (ppc-typecode thing)))
    (declare (fixnum typecode))
    (if (= typecode ppc::tag-fixnum)
      'fixnum
      (if (= typecode ppc::tag-list)
        (if thing 'cons 'null)
        (if (= typecode ppc::tag-imm)
          (if (base-character-p thing)
            'base-character
            (if (extended-character-p thing)
              'extended-character
              'immediate))
          (let* ((tag-type (logand typecode ppc::full-tag-mask))
                 (tag-val (ash typecode (- ppc::ntagbits))))
            (declare (fixnum tag-type tag-val))
            ;; When we get to the point that we can differentiate between
            ;; different types of functions, do so.
            (if (/= tag-type ppc::fulltag-nodeheader)
              (%svref *immheader-types* tag-val)
              (let ((type (%svref *nodeheader-types* tag-val)))
                (if (neq type 'function)
                  type
                  (let ((bits (lfun-bits thing)))
                    (declare (fixnum bits))
                    (if (logbitp $lfbits-trampoline-bit bits)
                      ; stack-group or closure
                      (if (stack-group-p thing)
                        'stack-group
                        (if (logbitp $lfbits-evaluated-bit bits)
                          'interpreted-lexical-closure
                          (let ((inner-fn (closure-function thing)))
                            (if (neq inner-fn thing)
                              (let ((inner-bits (lfun-bits inner-fn)))
                                (if (logbitp $lfbits-method-bit inner-bits)
                                  'compiled-lexical-closure
                                  (if (logbitp $lfbits-gfn-bit inner-bits)
                                    'standard-generic-function ; not precisely - see class-of
                                    (if (logbitp  $lfbits-cm-bit inner-bits)
                                      'combined-method
                                      'compiled-lexical-closure))))
                              'compiled-lexical-closure))))
                      (if (logbitp $lfbits-evaluated-bit bits)
                        (if (logbitp $lfbits-method-bit bits)
                          'interpreted-method-function
                          'interpreted-function)
                        (if (logbitp  $lfbits-method-bit bits)
                          'method-function          
                          'compiled-function)))))))))))))

; real machine specific huh
(defun consp (x) (consp x))

(defun characterp (arg)
  (characterp arg))

(defun base-character-p (c)
  (base-character-p c))


(defun structurep (form)
  "True if the given object is a named structure, Nil otherwise."
  (= (the fixnum (ppc-typecode form)) ppc::subtag-struct))

(defun istructp (form)
  (= (the fixnum (ppc-typecode form)) ppc::subtag-istruct))

(defun structure-typep (thing type)
  (if (= (the fixnum (ppc-typecode thing)) ppc::subtag-struct)
    (if (memq type (%svref thing 0))
      t)))

(defun istruct-typep (thing type)
  (if (= (the fixnum (ppc-typecode thing)) ppc::subtag-istruct)
    (eq (%svref thing 0) type)))

(defun symbolp (thing)
  (if thing
    (= (the fixnum (ppc-typecode thing)) ppc::subtag-symbol)
    t))

(defun packagep (thing)
  (= (the fixnum (ppc-typecode thing)) ppc::subtag-package))

; 1 if by land, 2 if by sea.
(defun sequence-type (x)
  (unless (>= (the fixnum (ppc-typecode x)) ppc::min-vector-subtag)
    (or (listp x)
        (report-bad-arg x 'sequence))))

;; I'm really skeptical about anything that calls UVECTORP
;; (in that I'm afraid that it thinks that it knows what's
;; a "uvector" and what isn't.
(defun uvectorp (x)
  (= (the fixnum (ppc-lisptag x)) ppc::tag-misc))