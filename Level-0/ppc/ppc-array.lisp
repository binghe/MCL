;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: ppc-array.lisp,v $
;;  Revision 1.4  2006/03/08 20:37:14  alice
;;  ; element-type-subtype - single-float = short-float
; ---- 5.2b1
;;
;;  Revision 1.3  2004/11/25 20:39:21  alice
;;  fix ppc-subtag-bytes
;;
;;  Revision 1.2  2003/02/28 21:21:56  gtbyers
;;  PPC-SUBTAG-BYTES: element-bit-shift should be 0 for bitvectors.
;;
;;  27 1/22/97 akh  fix element-type-subtype crock re 'character
;;  24 6/7/96  akh  maybe no change
;;  22 2/19/96 akh  fix array-dimension for vectors
;;                  vector-push returns new fill
;;                  %simple-string= - fix 68k vestiges
;;  21 2/19/96 akh  gary's array-data-and-offset fixes
;;  18 12/22/95 gb  %init-misc, vector-push-extend, %array-index, & Bill's fix to aset
;;  16 12/14/95 akh no more %set-schar & %schar - they are macros today
;;  14 11/29/95 akh %init-misc - fix for 8 bit strings, bytes too
;;  12 11/19/95 gb  -cell, %extend-vector
;;  10 11/18/95 akh %set-simple-array-p moves here
;;                  no % on array-data-offset-subtype
;;  9 11/15/95 slh  move in ppc thingie from l0-array
;;  8 11/14/95 akh  add %arh-bits and %set-arh-bits
;;  5 10/27/95 akh  added element-type-subtype
;;  4 10/26/95 gb   %pool, %population, %instance
;;  (do not edit before this line!!)

;; Copyright 1995-2000 Digitool, Inc.


; Modification History
;
; element-type-subtype - single-float = short-float
; ---- 5.2b1
; fix ppc-subtag-bytes for double-float-vector to account for 4 bytes alignment slop
; ------ 5.1 final
; AKH %array-index - better error if not fixnum - 2d should do that too
;04/12/99 akh fix array-dimensions and array-dimension to use logsize vs. physsize -- DONT EVEN THINK ABOUT IT
;------------ 4.3b1
; 03/03/99 akh element-type-subtype for base-char
; 03/15/98 akh %aref1 and %aset1 detect out of bounds for displaced array
; 04/16/97 bill  Gary's fix to %init-misc
; -------------  4.1b2
; 02/11/97 gb    ELEMENT-TYPE-SUBTYPE : short-float stuff
; 11/15/96 akh   fix element-type-subtype crock re 'character
; 07/18/96 gb    use %array-header-data-and-offset when we know we have a
;                non-simple array.  Do some dereferencing manually, rather than
;                via AREF/ASET.
;  5/21/96 slh   Gary's change to vector-push-extend
; 03/22/96 gb    extended-character->character in *ppc-immheader-array-types;
;                some fixnum decls & some lap in array guts; %aref2/%aset2
; 01/22/96 gb    add :regsave pseudo-op.
; 01/04/96 gb    array-element-subtype & %set-fill-pointer.
; 12/23/95 bill  aset indentation
; 12/13/95 gb    add %misc-ref & %misc-set
; 11/29/95 bill  %init-misc: use unbox-base-character to get character code (instead of left shifting)
;                            Propagate low 8 bits to low 16 correctly.
;                            max-32-bit-ivector-subtag is subtag-s32-vector, not subtag-sfloat-vector.
; 11/21/95 bill  array-total-size doesn't need to multiply the dimensions.
;                That's what the arrayH.physsize slot is for.
; 11/15/95 slh   temp. #+/-lexprs conds. to get around compiler bug
; 11/11/95 fix   %extend-vector; add ARRAY-ELEMENT-TYPE.

(eval-when (:compile-toplevel :execute)
  (require "PPC-ARCH" "ccl:compiler;ppc;ppc-arch")
  (require "PPC-LAPMACROS" "ccl:compiler;ppc;ppc-lapmacros"))


; Users of this shouldn't make assumptions about return value.
(defun %vect-subtype (v) (ppc-typecode v))

; Assumptions made by %init-misc
(eval-when (:compile-toplevel :execute)
  (assert (and (< ppc::max-32-bit-ivector-subtag
                  ppc::max-8-bit-ivector-subtag
                  ppc::max-16-bit-ivector-subtag)
               (eql ppc::max-32-bit-ivector-subtag ppc::subtag-s32-vector)
               (eql ppc::max-16-bit-ivector-subtag ppc::subtag-s16-vector)
               (eql ppc::max-8-bit-ivector-subtag ppc::subtag-simple-base-string))))

(defppclapfunction %init-misc ((val arg_y)
                               (miscobj arg_z))
  (getvheader imm0 miscobj)
  (header-size imm3 imm0)
  (cmpwi cr3 imm3 0)
  (extract-fulltag imm1 imm0)
  (cmpwi cr0 imm1 ppc::fulltag-nodeheader)
  (extract-lowbyte imm2 imm0)
  (beqlr cr3)                           ; Silly 0-length case
  (li imm4 ppc::misc-data-offset)
  (bne cr0 @imm)
  ; Node vector.  Don't need to memoize, since initial value is
  ; older than vector.
  @node-loop
  (cmpwi cr0 imm3 1)
  (subi imm3 imm3 1)
  (stwx val miscobj imm4)
  (la imm4 4 imm4)
  (bne cr0 @node-loop)
  (blr)
  @imm
  (cmpwi cr0 imm2 ppc::subtag-double-float-vector)
  (cmpwi cr1 imm2 ppc::max-32-bit-ivector-subtag)
  (cmpwi cr2 imm2 ppc::max-8-bit-ivector-subtag)
  (cmpwi cr3 imm2 ppc::max-16-bit-ivector-subtag)
  (extract-typecode imm0 val :CR6)		; don't clobber CR0
  (cmpwi cr7 imm0 ppc::tag-fixnum)
  (beq cr0 @dfloat)
  (ble cr1 @32)
  (ble cr2 @8)
  (ble cr3 @16)
  ; Bit vector.
  (cmplwi cr0 val '1)
  (la imm3 31 imm3)
  (srwi imm3 imm3 5)
  (unbox-fixnum imm0 val)
  (neg imm0 imm0)
  (ble+ cr0 @set-32)
  @bad
  (li arg_x '#.$xnotelt)
  (save-lisp-context)
  (set-nargs 3)
  (call-symbol %err-disp)
  @dfloat
  (cmpwi cr0 imm0 ppc::subtag-double-float)
  (li imm4 ppc::misc-dfloat-offset)
  (bne- cr0 @bad)
  (lfd fp0 ppc::double-float.value val)
  @dfloat-loop
  (cmpwi cr0 imm3 1)
  (subi imm3 imm3 1)
  (stfdx fp0 miscobj imm4)
  (la imm4 8 imm4)
  (bne cr0 @dfloat-loop)
  (blr)
  @32
  (cmpwi cr0 imm2 ppc::subtag-single-float-vector)
  (cmpwi cr2 imm0 ppc::subtag-bignum)
  (beq cr1 @s32)                     ; ppc::max-32-bit-ivector-subtag
  (bne cr0 @u32)
  ;@sfloat
  (cmpwi cr0 imm0 ppc::subtag-single-float)
  (bne- cr0 @bad)
  (lwz imm0 ppc::single-float.value val)
  (b @set-32)
  @s32
  (unbox-fixnum imm0 val)
  (beq+ cr7 @set-32)
  (bne- cr2 @bad)
  (getvheader imm0 val)
  (cmpwi cr0 imm0 (logior (ash 1 ppc::num-subtag-bits) ppc::subtag-bignum))
  (lwz imm0 ppc::misc-data-offset val)
  (beq+ cr0 @set-32)
  (b @bad)
  @u32
  (extract-unsigned-byte-bits. imm0 val 30)
  (unbox-fixnum imm0 val)
  (beq cr0 @set-32)
  (bne- cr2 @bad)
  ; a one-digit bignum is ok if that digit is positive.
  ; a two-digit bignum is ok if the sign-digit is 0.
  (getvheader imm0 val)
  (cmpwi cr2 imm0 (logior (ash 2 ppc::num-subtag-bits) ppc::subtag-bignum))
  (lwz imm0 ppc::misc-data-offset val)
  (cmpwi cr3 imm0 0)
  (bgt- cr2 @bad)                       ; more than two digits.
  (beq cr2 @two-digits)
  (bgt+ cr3 @set-32)
  (b @bad)
  @two-digits
  (lwz imm1 (+ 4 ppc::misc-data-offset) val)
  (cmpwi cr0 imm1 0)
  (bne- cr0 @bad)
  (b @set-32)
  @16
  (cmpwi cr0 imm2 ppc::subtag-u16-vector)
  (la imm3 1 imm3)
  (srwi imm3 imm3 1)
  (beq cr3 @s16)                        ; ppc::max-16-bit-ivector-subtag
  (bne cr0 @char16)
  (extract-unsigned-byte-bits. imm0 val 16)
  (unbox-fixnum imm0 val)
  (beq+ cr0 @set-16)
  (b @bad)
  @s16
  (slwi imm0 val (- 32 (+ 16 ppc::fixnumshift)))
  (srawi imm0 imm0 (- 32 (+ 16 ppc::fixnumshift)))
  (cmpw cr0 imm0 val)
  (unbox-fixnum imm0 val)
  (bne- cr7 @bad)
  (beq+ cr0 @set-16)
  (b @bad)
  @char16
  (clrlwi imm0 val 24)
  (cmpwi cr0 imm0 ppc::subtag-character)
  (srwi imm0 val ppc::charcode-shift)
  (beq+ cr0 @set-16)
  (b @bad)
  @8
  (cmpwi cr0 imm0 ppc::subtag-s8-vector)
  (la imm3 3 imm3)
  (srwi imm3 imm3 2)
  (beq cr2 @char8)                      ; ppc::max-8-bit-ivector-subtag
  (beq cr0 @s8)
  (extract-unsigned-byte-bits. imm0 val 8)
  (unbox-fixnum imm0 val)
  (beq+ cr0 @set-8)
  (b @bad)
  @s8
  (slwi imm0 val (- 32 (+ 8 ppc::fixnumshift)))
  (srawi imm0 imm0 (- 32 (+ 8 ppc::fixnumshift)))
  (cmpw cr0 imm0 val)
  (unbox-fixnum imm0 val)
  (bne- cr7 @bad)
  (beq+ cr0 @set-8)
  (b @bad)
  @char8
  (unbox-base-character imm0 val cr0)   ; this type checks val
  @set-8                                ; propagate low 8 bits into low 16
  (rlwimi imm0 imm0 8 (- 32 16) (- 31 8))
  @set-16                               ; propagate low 16 bits into high 16
  (rlwimi imm0 imm0 16 0 (- 31 16))
  @set-32
  (cmpwi cr0 imm3 1)
  (subi imm3 imm3 1)
  (stwx imm0 miscobj imm4)
  (la imm4 4 imm4)
  (bne cr0 @set-32)
  (blr))

; Make a new vector of size newsize whose subtag matches that of oldv-arg.
; Blast the contents of the old vector into the new one as quickly as
; possible; leave remaining elements of new vector undefined (0).
; Return new-vector.
(defppclapfunction %extend-vector ((start-arg arg_x) (oldv-arg arg_y) (newsize arg_z))
  (let ((oldv save0)
        (oldsize save1)
        (oldsubtag save2)
        (start-offset save3))
    (save-lisp-context)
    (:regsave save3 0)
    (vpush save0)
    (vpush save1)
    (vpush save2)
    (vpush save3)
    (mr oldv oldv-arg)
    (mr start-offset start-arg)
    (getvheader imm0 oldv)
    (header-length oldsize imm0)
    (header-subtag[fixnum] oldsubtag imm0)
    (mr arg_y newsize)
    (mr arg_z oldsubtag)
    (bla .SPmisc-alloc)
    (extrwi imm0 oldsubtag ppc::ntagbits (- 32 (+  ppc::fixnumshift ppc::ntagbits)))
    (cmpwi cr0 oldsize 0)
    (cmpwi cr1 imm0 ppc::fulltag-nodeheader)
    (cmpwi cr2 oldsubtag '#.ppc::max-32-bit-ivector-subtag)
    (la imm1 ppc::misc-data-offset start-offset)
    (li imm3 ppc::misc-data-offset)
    (beq cr0 @done)
    (bne cr1 @imm)
    ; copy nodes.  New vector is "new", so no memoization required.
    @node-loop
    (cmpwi cr0 oldsize '1)
    (lwzx temp0 oldv imm1)
    (addi imm1 imm1 4)
    (subi oldsize oldsize '1)
    (stwx temp0 arg_z imm3)
    (addi imm3 imm3 4)
    (bne cr0 @node-loop)
    ;Restore registers.  New vector's been in arg_z all this time.
    @done
    (lwz save3 0 vsp)
    (lwz save2 4 vsp)
    (lwz save1 8 vsp)
    (lwz save0 12 vsp)
    (restore-full-lisp-context)
    (blr)
    @imm
    (unbox-fixnum imm2 oldsize)
    (unbox-fixnum imm3 start-offset)
    (li imm1 ppc::misc-data-offset)
    (la imm4 ppc::misc-data-offset start-offset)
    (cmpwi cr1 oldsubtag '#.ppc::max-8-bit-ivector-subtag)
    (cmpwi cr0 oldsubtag '#.ppc::max-16-bit-ivector-subtag)
    (ble cr2 @fullword-loop)
    (cmpwi cr2 oldsubtag '#.ppc::subtag-bit-vector)
    (ble cr1 @8-bit)
    (ble cr0 @16-bit)
    (beq cr2 @1-bit)
    ; 64-bit (double-float) vectors.  There's a different
    ; initial offset, but we're always word-aligned, so that
    ; part's easy.
    (li imm1 ppc::misc-dfloat-offset)   ; scaled destination pointer
    (slwi imm2 imm2 1)                  ; twice as many fullwords
    (slwi imm3 imm3 3)                  ; convert dword count to byte offset
    (la imm4 ppc::misc-dfloat-offset imm3)      ; scaled source pointer
    (b @fullword-loop)
    ; The bitvector case is hard if START-OFFSET isn't on an 8-bit boundary,
    ;  and can be turned into the 8-bit case otherwise.
    ; The 8-bit case is hard if START-OFFSET isn't on a 16-bit boundary, 
    ;  and can be turned into the 16-bit case otherwise.
    ; The 16-bit case is hard if START-OFFSET isn't on a 32-bit boundary, 
    ;  and can be turned into the 32-bit case otherwise.
    ; Hmm.
    @1-bit
    (clrlwi. imm0 imm3 (- 32 3))
    (bne- cr0 @hard-1-bit)
    (srwi imm3 imm3 3)                  ; bit offset to byte offset
    (addi imm2 imm2 7)
    (srwi imm2 imm2 3)                  ; bit count to byte count
    @8-bit
    ; If the byte offset's even, copy half as many halfwords
    (clrlwi. imm0 imm3 (- 32 1))
    (bne- cr0 @hard-8-bit)
    (addi imm2 imm2 1)
    (srwi imm2 imm2 1)                  ; byte count to halfword count
    (srwi imm3 imm3 1)                  ; byte offset to halfword offset
    @16-bit
    ; If the halfword offset's even, copy half as many fullwords
    (clrlwi. imm0 imm3 (- 32 1))
    (bne- cr0 @hard-16-bit)
    (addi imm2 imm2 1)
    (srwi imm2 imm2 1)                  ; halfword count to fullword count
    (li imm1 ppc::misc-data-offset)   
    @fullword-loop
    (cmpwi cr0 imm2 1)
    (lwzx imm0 oldv imm4)
    (addi imm4 imm4 4)
    (subi imm2 imm2 1)
    (stwx imm0 arg_z imm1)
    (addi imm1 imm1 4)
    (bne cr0 @fullword-loop)
    (b @done)
    ;;; This can just do a uvref/uvset loop.  Cases that can
    ;;; cons (x32, double-float) have already been dealt with.
    @hard-1-bit
    @hard-8-bit
    @hard-16-bit
    (let ((newv save3)
          (outi save4))
      (vpush save3)
      (vpush save4)
      (mr newv arg_z)
      (li outi 0)
      @hard-loop
      (mr arg_y oldv)
      (mr arg_z start-offset)
      (bla .SPmisc-ref)
      (mr arg_x newv)
      (mr arg_y outi)
      (bla .SPmisc-set)
      (la outi '1 outi)
      (cmpw cr0 outi oldsize)
      (la start-offset '1 start-offset)
      (bne @hard-loop)
      (mr arg_z newv)
      (vpop save4)
      (vpop save3)
      (b @done))))

; Return T if array or vector header, NIL if (simple-array * (*)), else
; error.

(defun %array-is-header (array)
  (let* ((typecode (ppc-typecode array)))
    (declare (fixnum typecode))
    (if (< typecode ppc::min-array-subtag)
      (report-bad-arg array 'array)
      (or (= typecode ppc::subtag-arrayH)
          (= typecode ppc::subtag-vectorH)))))

(defun %set-fill-pointer (vectorh new)
  (setf (%svref vectorh ppc::vectorh.logsize-cell) new))

(defun %array-header-subtype (header)
  (the fixnum 
    (ldb ppc::arrayH.flags-cell-subtag-byte (the fixnum (%svref header ppc::arrayH.flags-cell)))))

(defun array-element-subtype (array)
  (if (%array-is-header array)
    (%array-header-subtype array)
    (ppc-typecode array)))
  

(defconstant *ppc-immheader-array-types*
  '#(short-float
    (unsigned-byte 32)
    (signed-byte 32)
    (unsigned-byte 8)
    (signed-byte 8)
    base-character
    character
    (unsigned-byte 16)
    (signed-byte 16)
    double-float
    bit))

(defun array-element-type (array)
  (let* ((subtag (if (%array-is-header array)
                   (%array-header-subtype array)
                   (ppc-typecode array))))
    (declare (fixnum subtag))
    (if (= subtag ppc::subtag-simple-vector)
      t                                 ; only node CL array type
      (svref *ppc-immheader-array-types*
             (ash (the fixnum (- subtag ppc::min-cl-ivector-subtag)) -3)))))



(defun adjustable-array-p (array)
  (let* ((typecode (ppc-typecode array)))
    (declare (fixnum typecode))
    (if (< typecode ppc::min-array-subtag)
      (report-bad-arg array 'array)
      (if (or (= typecode ppc::subtag-arrayH)
              (= typecode ppc::subtag-vectorH))
        (logbitp $arh_adjp_bit (the fixnum (%svref array ppc::arrayH.flags-cell)))))))

(defun array-data-and-offset (array)
  (let* ((typecode (ppc-typecode array)))
    (declare (fixnum typecode))
    (if (< typecode ppc::min-array-subtag)
      (report-bad-arg array 'array)
      (if (<= typecode ppc::subtag-vectorH)
        (%array-header-data-and-offset array)
        (values array 0)))))

;; argument is a vector header or an array header.  Or else.
(defppclapfunction %array-header-data-and-offset ((a arg_z))
  (let ((offset arg_y)
        (disp arg_x)
        (temp temp0))
    (li offset 0)
    (mr temp a)
    @loop
    (lwz a ppc::arrayH.data-vector temp)
    (lbz imm0 ppc::misc-subtag-offset a)
    (cmpwi cr0 imm0 ppc::subtag-vectorH)
    (lwz disp ppc::arrayH.displacement temp)
    (mr temp a)
    (add offset offset disp)
    (ble cr0 @loop)
    (vpush a)
    (vpush offset)
    (set-nargs 2)
    (la temp0 8 vsp)
    (ba .SPvalues)))
    
(defun array-data-offset-subtype (array)
  (let* ((typecode (ppc-typecode array)))
    (declare (fixnum typecode))
    (if (< typecode ppc::min-array-subtag)
      (report-bad-arg array 'array)
      (if (<= typecode ppc::subtag-vectorH)
        (do* ((header array data)
              (offset (%svref header ppc::arrayH.displacement-cell)
                      (+ offset 
                         (the fixnum 
                              (%svref header ppc::arrayH.displacement-cell))))
              (data (%svref header ppc::arrayH.data-vector-cell)
                    (%svref header ppc::arrayH.data-vector-cell)))
             ((> (the fixnum (ppc-typecode data)) ppc::subtag-vectorH)
              (values data offset (ppc-typecode data)))
          (declare (fixnum offset)))
        (values array 0 typecode)))))
  

(defun array-has-fill-pointer-p (array)
  (let* ((typecode (ppc-typecode array)))
    (declare (fixnum typecode))
    (if (>= typecode ppc::min-array-subtag)
      (and (= typecode ppc::subtag-vectorH)
             (logbitp $arh_fill_bit (the fixnum (%svref array ppc::vectorH.flags-cell))))
      (report-bad-arg array 'array))))


(defun fill-pointer (array)
  (let* ((typecode (ppc-typecode array)))
    (declare (fixnum typecode))
    (if (and (= typecode ppc::subtag-vectorH)
             (logbitp $arh_fill_bit (the fixnum (%svref array ppc::vectorH.flags-cell))))
      (%svref array ppc::vectorH.logsize-cell)
      (%err-disp $XNOFILLPTR array))))

(defun set-fill-pointer (array value)
  (let* ((typecode (ppc-typecode array)))
    (declare (fixnum typecode))
    (if (and (= typecode ppc::subtag-vectorH)
             (logbitp $arh_fill_bit (the fixnum (%svref array ppc::vectorH.flags-cell))))
      (let* ((vlen (%svref array ppc::vectorH.physsize-cell)))
        (declare (fixnum vlen))
        (if (eq value t)
          (setq value vlen)
          (unless (and (fixnump value)
                     (>= (the fixnum value) 0)
                     (<= (the fixnum value) vlen))
            (%err-disp $XARROOB value array)))
        (setf (%svref array ppc::vectorH.logsize-cell) value))
      (%err-disp $XNOFILLPTR array))))

(eval-when (:compile-toplevel)
  (assert (eql ppc::vectorH.physsize-cell ppc::arrayH.physsize-cell)))

(defun array-total-size (array)
  (let* ((typecode (ppc-typecode array)))
    (declare (fixnum typecode))
    (if (< typecode ppc::min-array-subtag)
      (report-bad-arg array 'array)
      (if (or (= typecode ppc::subtag-arrayH)
              (= typecode ppc::subtag-vectorH))
        (%svref array ppc::vectorH.physsize-cell)
        (uvsize array)))))

(defun array-dimension (array axis-number)
  (unless (typep axis-number 'fixnum) (report-bad-arg axis-number 'fixnum))
  (locally
    (declare (fixnum axis-number))
    (let* ((typecode (ppc-typecode array)))
      (declare (fixnum typecode))
      (if (< typecode ppc::min-array-subtag)
        (report-bad-arg array 'array)
        (if (= typecode ppc::subtag-arrayH)
          (let* ((rank (%svref array ppc::arrayH.rank-cell)))
            (declare (fixnum rank))
            (unless (and (>= axis-number 0)
                         (< axis-number rank))
              (%err-disp $XNDIMS array axis-number))
            (%svref array (the fixnum (+ ppc::arrayH.dim0-cell axis-number))))
          (if (neq axis-number 0)
            (%err-disp $XNDIMS array axis-number)
            (if (= typecode ppc::subtag-vectorH)
              (%svref array ppc::vectorH.physsize-cell)
              (uvsize array))))))))

(defun array-dimensions (array)
  (let* ((typecode (ppc-typecode array)))
    (declare (fixnum typecode))
    (if (< typecode ppc::min-array-subtag)
      (report-bad-arg array 'array)
      (if (= typecode ppc::subtag-arrayH)
        (let* ((rank (%svref array ppc::arrayH.rank-cell))
               (dims ()))
          (declare (fixnum rank))        
          (do* ((i (1- rank) (1- i)))
               ((< i 0) dims)
            (declare (fixnum i))
            (push (%svref array (the fixnum (+ ppc::arrayH.dim0-cell i))) dims)))
        (list (if (= typecode ppc::subtag-vectorH)
                (%svref array ppc::vectorH.physsize-cell)
                (uvsize array)))))))


(defun array-rank (array)
  (let* ((typecode (ppc-typecode array)))
    (declare (fixnum typecode))
    (if (< typecode ppc::min-array-subtag)
      (report-bad-arg array 'array)
      (if (= typecode ppc::subtag-arrayH)
        (%svref array ppc::arrayH.rank-cell)
        1))))

(defun vector-push (elt vector)
  (let* ((fill (fill-pointer vector))
         (len (%svref vector ppc::vectorH.physsize-cell)))
    (declare (fixnum fill len))
    (when (< fill len)
      (multiple-value-bind (data offset) (%array-header-data-and-offset vector)
        (declare (fixnum offset))
        (setf (%svref vector ppc::vectorH.logsize-cell) (the fixnum (1+ fill))
              (uvref data (the fixnum (+ fill offset))) elt)
        fill))))

(defun vector-push-extend (elt vector &optional (extension nil extp))
  (when extp
    (unless (and (typep extension 'fixnum)
                 (> (the fixnum extension) 0))
      (setq extension (require-type extension 'unsigned-byte))))
  (let* ((fill (fill-pointer vector))
         (len (%svref vector ppc::vectorH.physsize-cell)))
    (declare (fixnum fill len))
    (multiple-value-bind (data offset) (%array-header-data-and-offset vector)
      (declare (fixnum offset))
      (if (= fill len)
        (progn
          (unless (logbitp $arh_adjp_bit (the fixnum (%svref vector ppc::arrayH.flags-cell)))
            (%err-disp $XMALADJUST vector))
          (let* ((new-size (+ len (the fixnum (or extension
                                                  (the fixnum (1+ (ash (the fixnum len) -1)))))))
                 (new-vector (%extend-vector offset data new-size)))
            (setf (%svref vector ppc::vectorH.data-vector-cell) new-vector
                  (%svref vector ppc::vectorH.displacement-cell) 0
                  (%svref vector ppc::vectorH.physsize-cell) new-size
                  (uvref new-vector fill) elt)))
        (setf (uvref data (the fixnum (+ offset fill))) elt))
      (setf (%svref vector ppc::vectorH.logsize-cell) (the fixnum (1+ fill))))
    fill))

; Could avoid potential memoization somehow
(defun vector (&lexpr vals)
  (let* ((n (%lexpr-count vals))
         (v (%alloc-misc n ppc::subtag-simple-vector)))
    (declare (fixnum n))
    (dotimes (i n v) (setf (%svref v i) (%lexpr-ref vals n i)))))


(defun %ppc-gvector (subtag &lexpr vals)
  (let* ((n (%lexpr-count vals))
         (v (%alloc-misc n subtag)))
    (declare (fixnum n))
    (dotimes (i n v) (setf (%svref v i) (%lexpr-ref vals n i)))))

(defun %aref1 (v i)
  (let* ((typecode (ppc-typecode v)))
    (declare (fixnum typecode))
    (if (> typecode ppc::subtag-vectorH)
      (%typed-miscref typecode v i)
      (if (= typecode ppc::subtag-vectorH)
        (progn
          (let ((flags (%svref v ppc::vectorH.flags-cell)))
            (declare (fixnum flags))
            (when (and (not (logbitp $arh_simple_bit flags))
                       (not (logbitp $arh_fill_bit flags)))
              (unless (and (fixnump i)
                           (>= (the fixnum i) 0)
                           (< (the fixnum i)(the fixnum (%svref v ppc::vectorH.logsize-cell))))
                (%err-disp $XARROOB i v))))          
          (multiple-value-bind (data offset)
                               (%array-header-data-and-offset v)
            (uvref data (+ offset i))))
        (if (= typecode ppc::subtag-arrayH)
          (%err-disp $XNDIMS v 1)
          (report-bad-arg v 'array))))))

(defun %aset1 (v i new)
  (let* ((typecode (ppc-typecode v)))
    (declare (fixnum typecode))
    (if (> typecode ppc::subtag-vectorH)
      (%typed-miscset typecode v i new)
      (if (= typecode ppc::subtag-vectorH)
        (progn
          (let ((flags (%svref v ppc::vectorH.flags-cell)))
            (declare (fixnum flags))
            (when (and (not (logbitp $arh_simple_bit flags))
                       (not (logbitp $arh_fill_bit flags)))
              (unless (and (fixnump i)
                           (>= (the fixnum i) 0)
                           (< (the fixnum i)(the fixnum (%svref v ppc::vectorH.logsize-cell))))
                (%err-disp $XARROOB i v))))
          (multiple-value-bind (data offset)
                               (%array-header-data-and-offset v)
            (setf (uvref data (+ offset i)) new)))
        (if (= typecode ppc::subtag-arrayH)
          (%err-disp $XNDIMS v 1)
          (report-bad-arg v 'array))))))

; Validate the N indices in the lexpr L against the
; array-dimensions of L.  If anything's out-of-bounds,
; error out (unless NO-ERROR is true, in which case
; return NIL.)
; If everything's OK, return the "row-major-index" of the array.
; We know that A's an array-header of rank N.

(defun %array-index (a l n &optional no-error)
  (declare (fixnum n))
  (let* ((count (%lexpr-count l)))
    (declare (fixnum count))
    (do* ((axis (1- n) (1- axis))
          (chunk-size 1)
          (result 0))
         ((< axis 0) result)
      (declare (fixnum result axis chunk-size))
      (let* ((index (%lexpr-ref l count axis))
             (dim (%svref a (the fixnum (+ ppc::arrayH.dim0-cell axis)))))
        (declare (fixnum dim))
        (unless (and (typep index 'fixnum)
                     (>= (the fixnum index) 0)
                     (< (the fixnum index) dim))
          (if no-error
            (return-from %array-index nil)
            (IF (NOT (TYPEP INDEX 'FIXNUM))
              (SETQ INDEX (REQUIRE-TYPE INDEX `(INTEGER 0 (,DIM))))
              (%err-disp $XARROOB index a))))
        (incf result (the fixnum (* chunk-size (the fixnum index))))
        (setq chunk-size (* chunk-size dim))))))

(defun aref (a &lexpr subs)
  (let* ((n (%lexpr-count subs)))
    (declare (fixnum n))
    (if (= n 1)
      (%aref1 a (%lexpr-ref subs n 0))
      (if (= n 2)
        (%aref2 a (%lexpr-ref subs n 0) (%lexpr-ref subs n 1))
        (let* ((typecode (ppc-typecode a)))
          (declare (fixnum typecode))
          (if (>= typecode ppc::min-vector-subtag)
            (%err-disp $XNDIMS a n)
            (if (< typecode ppc::min-array-subtag)
              (report-bad-arg a 'array)
              ;  This typecode is Just Right ...
              (progn
                (unless (= (the fixnum (%svref a ppc::arrayH.rank-cell)) n)
                  (%err-disp $XNDIMS a n))
                (let* ((rmi (%array-index a subs n)))
                  (declare (fixnum rmi))
                  (multiple-value-bind (data offset) (%array-header-data-and-offset a)
                    (declare (fixnum offset))
                    (uvref data (the fixnum (+ offset rmi)))))))))))))

(defun %2d-array-index (a x y)
  (let* ((dim0 (%svref a ppc::arrayH.dim0-cell))
         (dim1 (%svref a (1+ ppc::arrayH.dim0-cell))))
      (declare (fixnum dim0 dim1))
      (unless (and (typep x 'fixnum)
                   (>= (the fixnum x) 0)
                   (< (the fixnum x) dim0))
        (%err-disp $XARROOB x a))
      (unless (and (typep y 'fixnum)
                   (>= (the fixnum y) 0)
                   (< (the fixnum y) dim1))
        (%err-disp $XARROOB y a))
       (the fixnum (+ (the fixnum y) (the fixnum (* dim1 (the fixnum x)))))))

(defun %aref2 (a x y)
  (let* ((a-type (ppc-typecode a)))
    (declare (fixnum a-type))
    (unless (>= a-type ppc::subtag-arrayH)
      (report-bad-arg a 'array))
    (unless (and (= a-type ppc::subtag-arrayH)
                 (= (the fixnum (%svref a ppc::arrayH.rank-cell)) 2))
      (%err-disp $XNDIMS a 2))
    (let* ((rmi (%2d-array-index a x y)))
      (declare (fixnum rmi))
      (multiple-value-bind (data offset) (%array-header-data-and-offset a)
        (declare (fixnum offset))
        (uvref data (the fixnum (+ rmi offset)))))))

(defun aset (a &lexpr subs&val)
  (let* ((count (%lexpr-count subs&val))
         (nsubs (1- count)))
    (declare (fixnum nsubs count))
    (if (eql count 0)
      (%err-disp $xneinps)
      (let* ((val (%lexpr-ref subs&val count nsubs)))
        (if (= nsubs 1)
          (%aset1 a (%lexpr-ref subs&val count 0) val)
          (if (= nsubs 2)
            (%aset2 a (%lexpr-ref subs&val count 0) (%lexpr-ref subs&val count 1) val)
            (let* ((typecode (ppc-typecode a)))
              (declare (fixnum typecode))
              (if (>= typecode ppc::min-vector-subtag)
                (%err-disp $XNDIMS a nsubs)
                (if (< typecode ppc::min-array-subtag)
                  (report-bad-arg a 'array)
                  ;  This typecode is Just Right ...
                  (progn
                    (unless (= (the fixnum (%svref a ppc::arrayH.rank-cell)) nsubs)
                      (%err-disp $XNDIMS a nsubs))
                    (let* ((rmi (%array-index a subs&val nsubs)))
                      (declare (fixnum rmi))
                      (multiple-value-bind (data offset) (%array-header-data-and-offset a)
                        (setf (uvref data (the fixnum (+ offset rmi))) val)))))))))))))

(defun %aset2 (a x y new)
  (let* ((a-type (ppc-typecode a)))
    (declare (fixnum a-type))
    (unless (>= a-type ppc::subtag-arrayH)
      (report-bad-arg a 'array))
    (unless (and (= a-type ppc::subtag-arrayH)
                 (= (the fixnum (%svref a ppc::arrayH.rank-cell)) 2))
      (%err-disp $XNDIMS a 2))
    (let* ((rmi (%2d-array-index a x y)))
      (declare (fixnum rmi))
      (multiple-value-bind (data offset) (%array-header-data-and-offset a)
        (declare (fixnum offset))
        (setf (uvref data (the fixnum (+ rmi offset))) new)))))

(defun schar (s i)
  (let* ((typecode (ppc-typecode s)))
    (declare (fixnum typecode))
    (if (= typecode ppc::subtag-simple-base-string)
      (%typed-miscref ppc::subtag-simple-base-string s i)
      (if (= typecode ppc::subtag-simple-general-string)
        (%typed-miscref ppc::subtag-simple-general-string s i)
        (report-bad-arg s 'simple-string)))))


#| ; these are macros today
(defun %schar (s i)
  (let* ((typecode (ppc-typecode s)))
    (declare (fixnum typecode))
    (if (= typecode ppc::subtag-simple-base-string)
      (locally
        (declare (optimize (speed 3) (safety 0)))
        (%typed-miscref ppc::subtag-simple-base-string s i))
      (if (= typecode ppc::subtag-simple-general-string)
        (locally
          (declare (optimize (speed 3) (safety 0)))
          (%typed-miscref ppc::subtag-simple-general-string s i))
        (report-bad-arg s 'simple-string)))))
|#


(defun %scharcode (s i)
  (let* ((typecode (ppc-typecode s)))
    (declare (fixnum typecode))
    (if (= typecode ppc::subtag-simple-base-string)
      (locally
        (declare (optimize (speed 3) (safety 0)))
        (%typed-miscref ppc::subtag-u8-vector s i))
      (if (= typecode ppc::subtag-simple-general-string)
        (locally
          (declare (optimize (speed 3) (safety 0)))
          (%typed-miscref ppc::subtag-u16-vector s i))
        (report-bad-arg s 'simple-string)))))


(defun set-schar (s i v)
  (let* ((typecode (ppc-typecode s)))
    (declare (fixnum typecode))
    (if (= typecode ppc::subtag-simple-base-string)
      (setf (%typed-miscref ppc::subtag-simple-base-string s i) v)
      (if (= typecode ppc::subtag-simple-general-string)
        (setf (%typed-miscref ppc::subtag-simple-general-string s i) v)
        (report-bad-arg s 'simple-string)))))

#|
(defun %set-schar (s i v)
  (let* ((typecode (ppc-typecode s)))
    (declare (fixnum typecode))
    (if (= typecode ppc::subtag-simple-base-string)
      (locally
        (declare (optimize (speed 3) (safety 0)))
        (setf (%typed-miscref ppc::subtag-simple-base-string s i) v))
      (if (= typecode ppc::subtag-simple-general-string)
        (locally
          (declare (optimize (speed 3) (safety 0)))
          (setf (%typed-miscref ppc::subtag-simple-general-string s i) v))
        (report-bad-arg s 'simple-string)))))
|#

 
(defun %set-scharcode (s i v)
  (let* ((typecode (ppc-typecode s)))
    (declare (fixnum typecode))
    (if (= typecode ppc::subtag-simple-base-string)
      (locally
        (declare (optimize (speed 3) (safety 0)))
        (setf (%typed-miscref ppc::subtag-u8-vector s i) v))
      (if (= typecode ppc::subtag-simple-general-string)
        (locally
          (declare (optimize (speed 3) (safety 0)))
          (setf (%typed-miscref ppc::subtag-u16-vector s i) v))
        (report-bad-arg s 'simple-string)))))
  

; Strings are simple-strings, start & end values are sane.
(defun %simple-string= (str1 str2 start1 start2 end1 end2)
  (declare (fixnum start1 start2 end1 end2))
  (when (= (the fixnum (- end1 start1))
           (the fixnum (- end2 start2)))
    ; 2^2 different loops.
    (locally (declare (optimize (speed 3) (safety 0)))
      (if (= (the fixnum (ppc-typecode str1)) ppc::subtag-simple-base-string)
        (if (= (the fixnum (ppc-typecode str2)) ppc::subtag-simple-base-string)
          (locally (declare (type simple-base-string str1 str2))
            (do* ((i1 start1 (1+ i1))
                  (i2 start2 (1+ i2)))
                 ((= i1 end1) t)
              (declare (fixnum i1 i2))
              (unless (eq (schar str1 i1) (schar str2 i2))
                (return))))
          (locally (declare (type simple-base-string str1)
                            (type simple-extended-string str2))
            (do* ((i1 start1 (1+ i1))
                  (i2 start2 (1+ i2)))
                 ((= i1 end1) t)
              (declare (fixnum i1 i2))
              (unless (eq (schar str1 i1) (schar str2 i2))
                (return)))))
        (if (= (the fixnum (ppc-typecode str2)) ppc::subtag-simple-base-string)
          (locally (declare (type simple-base-string str2)
                            (type simple-extended-string str1))
            (do* ((i1 start1 (1+ i1))
                  (i2 start2 (1+ i2)))
                 ((= i1 end1) t)
              (declare (fixnum i1 i2))
              (unless (eq (schar str1 i1) (schar str2 i2))
                (return))))
          (locally (declare (type simple-extended-string str1 str2))
            (do* ((i1 start1 (1+ i1))
                  (i2 start2 (1+ i2)))
                 ((= i1 end1) t)
              (declare (fixnum i1 i2))
              (unless (eq (schar str1 i1) (schar str2 i2))
                (return)))))))))

(defun copy-uvector (src)
  (%extend-vector 0 src (uvsize src)))

(defun ppc-subtag-bytes (subtag element-count)
  (declare (fixnum subtag element-count))
  (unless (= #.ppc::fulltag-immheader (logand subtag #.ppc::fulltagmask))
    (error "Not an ivector subtag: ~s" subtag))
 (let* ((element-bit-shift
          (if (<= subtag ppc::max-32-bit-ivector-subtag)
            5
            (if (<= subtag ppc::max-8-bit-ivector-subtag)
              3
              (if (<= subtag ppc::max-16-bit-ivector-subtag)
                4
                (if (= subtag ppc::subtag-double-float-vector)
                  6
                  0)))))
         (total-bits (ash element-count element-bit-shift))
         (fudge (if (= subtag ppc::subtag-double-float-vector) 4 0)))
    (+ fudge (ash (+ 7 total-bits) -3))))

(defun element-type-subtype (type)
  "Convert element type specifier to internal array subtype code"
  (cond ((or (eq type t)(null type)) ppc::subtag-simple-vector)
        ((memq type '(extended-character character extended-char)) 
         ppc::subtag-simple-general-string)
        ((or (eq type 'base-character)(eq type 'base-char)) ppc::subtag-simple-base-string)
        ((eq type 'bit) ppc::subtag-bit-vector)
        ((memq type '(long-float  double-float)) ppc::subtag-double-float-vector)
        ((memq type '(short-float single-float)) ppc::subtag-single-float-vector)
        ((and (consp type)
              (if (eq (%car type) 'signed-byte)
                (let ((size (car (%cdr type))))
                  (and (null (%cddr type))
                       (fixnump size)
                       (%i< 0 size)
                       (cond ((%i<= size 8) ppc::subtag-s8-vector)
                             ((%i<= size 16) ppc::subtag-s16-vector)
                             ((%i<= size 32) ppc::subtag-s32-vector)
                             (t ppc::subtag-simple-vector))))
                (if (eq (%car type) 'unsigned-byte)
                  (let ((size (car (%cdr type))))
                    (and (null (%cddr type))
                         (fixnump size)
                         (%i< 0 size)
                         (cond ((%i<= size 8) ppc::subtag-u8-vector)
                               ((%i<= size 16) ppc::subtag-u16-vector)
                               ((%i<= size 32) ppc::subtag-u32-vector)
                               (t ppc::subtag-simple-vector))))))))
        ((subtypep type 'bit) PPC::subtag-bit-vector)
        ((subtypep type '(signed-byte 8)) PPC::subtag-s8-vector)
        ((subtypep type '(unsigned-byte 8)) PPC::subtag-u8-vector)
        ((subtypep type '(signed-byte 16)) PPC::subtag-s16-vector)
        ((subtypep type '(unsigned-byte 16)) PPC::subtag-u16-vector)
        ((subtypep type '(signed-byte 32)) PPC::subtag-s32-vector)
        ((subtypep type '(unsigned-byte 32)) PPC::subtag-u32-vector)
        ((subtypep type 'double-float) ppc::subtag-double-float-vector)
        ((subtypep type 'short-float) ppc::subtag-single-float-vector)
        ((subtypep type 'base-character) ppc::subtag-simple-base-string)
        ((subtypep type 'character) ppc::subtag-simple-general-string)
        ((subtypep type nil) nil)
        ((not (type-specifier-p type)) nil)
        (t ppc::subtag-simple-vector)))

(defun %set-simple-array-p (array)
  (setf (%svref array  ppc::arrayh.flags-cell)
        (bitset  $arh_simple_bit (%svref array ppc::arrayh.flags-cell))))

(defun  %array-header-simple-p (array)
  (logbitp $arh_simple_bit (%svref array ppc::arrayh.flags-cell)))

(defun %misc-ref (v i)
  (%misc-ref v i))

(defun %misc-set (v i new)
  (%misc-set v i new))
                
                     

