; -*- Mode:Lisp; Package:CCL; -*-

;;	Change History (most recent first):
;;  7 2/19/96  akh  result-bit-array returned wrong one
;;                  %displace-array sets sizes and offset
;;                  fix array-in-bounds-p and array-row-major-index
;;  6 2/19/96  akh  fixes for 0 rank and other test suite failures
;;  4 11/13/95 akh  #-ppc-target boole and something called but adjust array
;;  (do not edit before this line!!)


;; Copyright 1987-1988 Coral Software Corp.
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

; Modification History
;
; 04/16/99 akh add array-displacement, ANSI thing
; 03/03/99 akh from slh - fix error msg in result-bit-array
; 02/22/96 bill Better error message in array-row-major-index
; 01/28/96 gb   revive bit-boole & %displace-array.
; 10/25/95 slh   Bill's better array-row-major-index
; 10/24/95 slh   de-lapified sbit, %sbitset, array-row-major-index, array-in-bounds-p.
; 11/14/91 gb    fix %SBITSET some more.
; 11/05/91 gb    fix &lap arglists, "real" (realer) SBIT, %SBITSET.
;---------------2.0b3
; 07/21/91 gb  wtaerr fixes.
; 07/16/91 alice adjust array- error if total size < (or new-fill-pointer old-fill-pointer)
; 03/04/91 alice call report-bad-arg with a second arg
;--------------- 2.0b1
;08/27/90 gb  %uvfoo -> uvfoo, for suitable foo.
;08/09/90 akh fix adjust-array with initial-element
;07/24/90 akh make adjust-array work per Steele 2 (some of us think allowing adjust-array
;             on a non-adjustable array is a crock)
;05/30/90 gb aref-1d.
;04/17/90 gb (rts) vice rts at end of %%array-bounds.  Easy to make lap check for
;            label = defined operator/opcode; worth it ?
;            lap while -> while#.
;03/25/90 gz  Use array-element-subtype in adjust-array.
;04/07/89 gb  $sp8 -> $sp.
;02/23/89 gz added bit-boole, array-row-major-index, array-in-bounds-p.
;12/25/88 gz lapified %displace-array.
; 10/19/88 as %shrink-vector takes advantage of fill-pointers
; 8/7/88  gb tried to lisp-8-ize %displace-array bits.  Maybe succeeded.
; 8/12/88 gz new macptr scheme
; 8/03/87 gb eschew displacing arrays to themselves, don't let displaced-index-
;            offset be negative in adjust-array.
; 8/02/87 gb debogusificivication of sbit, bit, setf-inverses.
; 7/08/87 gz misparenthesizifivication in sbit.
; 7/06/87 gb commented-out make-similar-array, which is not called anymore
;            and seems not to understand the transitivity of array displacement.
;            made bit-vector accessors typecheck array args.
; 6/20/87 gb moved array-data-and-offset to level-1 (to bootsrap printer.)
;            What is bootsrapping, anyway?
;            NOTE: bit, sbit, etc. seem to work on any aref-able vector!
; 5/17/87 gz removed defconstants now initialized in the kernel.
; 19 05 87 cfry fixed %shrink-vector
; 4/3/87 gz made some of the defvar's into defconstants as per CLtL.
;           added adjust-array.

(in-package "CCL")

(defun bit (bit-array &rest subscripts)
  "Returns the bit from the Bit-Array at the specified Subscripts."
  (declare (dynamic-extent subscripts))
  (unless (eq (array-element-type bit-array) 'bit)
    (report-bad-arg bit-array '(array bit)))
  (apply #'aref bit-array subscripts))

(defun %bitset (bit-array &rest stuff)
  (declare (dynamic-extent stuff))
  (unless (eq (array-element-type bit-array) 'bit)
    (report-bad-arg bit-array '(array bit)))
  (apply #'aset bit-array stuff))

(defun sbit (v &optional sub0 &rest others)
  (declare (dynamic-extent others))
  (if (or (null sub0) others)
    (apply #'bit v sub0 others)
     (#+ppc-target sbit 
      #-ppc-target uvref (require-type v 'simple-bit-vector) sub0)))

(defun %sbitset (v sub0 &optional (newval nil newval-p) &rest newval-was-really-sub1)
  (declare (dynamic-extent newval-was-really-sub1))
  (if newval-p
    (if newval-was-really-sub1
      (apply #'%bitset v sub0 newval newval-was-really-sub1)
      (progn
        (unless (typep v 'simple-bit-vector)
          (report-bad-arg v 'simple-bit-vector))
        (uvset v sub0 newval)))
    (%bitset v)))

(defun bit-and (bit-array1 bit-array2 &optional result-bit-array)
  "Performs a bit-wise logical AND on the elements of Bit-Array1 and Bit-Array2
  putting the results in the Result-Bit-Array."
   (bit-boole boole-and bit-array1 bit-array2 result-bit-array))

(defun bit-ior (bit-array1 bit-array2 &optional result-bit-array)
  "Performs a bit-wise logical IOR on the elements of Bit-Array1 and Bit-Array2
  putting the results in the Result-Bit-Array."
  (bit-boole  boole-ior bit-array1 bit-array2 result-bit-array))

(defun bit-xor (bit-array1 bit-array2 &optional result-bit-array)
  "Performs a bit-wise logical XOR on the elements of Bit-Array1 and Bit-Array2
  putting the results in the Result-Bit-Array."
   (bit-boole  boole-xor bit-array1 bit-array2 result-bit-array))

(defun bit-eqv (bit-array1 bit-array2 &optional result-bit-array)
  "Performs a bit-wise logical EQV  on the elements of Bit-Array1 and Bit-Array2
  putting the results in the Result-Bit-Array."
   (bit-boole boole-eqv bit-array1 bit-array2 result-bit-array))

(defun bit-nand (bit-array1 bit-array2 &optional result-bit-array)
  "Performs a bit-wise logical NAND  on the elements of Bit-Array1 and Bit-Array2
  putting the results in the Result-Bit-Array."
  (bit-boole boole-nand bit-array1 bit-array2 result-bit-array))

(defun bit-nor (bit-array1 bit-array2 &optional result-bit-array)
  "Performs a bit-wise logical NOR  on the elements of Bit-Array1 and Bit-Array2
  putting the results in the Result-Bit-Array."
  (bit-boole boole-nor bit-array1 bit-array2 result-bit-array))

(defun bit-andc1 (bit-array1 bit-array2 &optional result-bit-array)
  "Performs a bit-wise logical ANDC1 on the elements of Bit-Array1 and Bit-Array2
  putting the results in the Result-Bit-Array."
  (bit-boole boole-andc1 bit-array1 bit-array2 result-bit-array))

(defun bit-andc2 (bit-array1 bit-array2 &optional result-bit-array)
  "Performs a bit-wise logical ANDC2 on the elements of Bit-Array1 and Bit-Array2
  putting the results in the Result-Bit-Array."
  (bit-boole boole-andc2 bit-array1 bit-array2 result-bit-array))

(defun bit-orc1 (bit-array1 bit-array2 &optional result-bit-array)
  "Performs a bit-wise logical ORC1 on the elements of Bit-Array1 and Bit-Array2
  putting the results in the Result-Bit-Array."
  (bit-boole boole-orc1 bit-array1 bit-array2 result-bit-array))

(defun bit-orc2 (bit-array1 bit-array2 &optional result-bit-array)
  "Performs a bit-wise logical ORC2 on the elements of Bit-Array1 and Bit-Array2
  putting the results in the Result-Bit-Array."
  (bit-boole boole-orc2 bit-array1 bit-array2 result-bit-array))

(defun bit-not (bit-array &optional result-bit-array)
  "Performs a bit-wise logical NOT in the elements of the Bit-Array putting
  the results into the Result-Bit-Array."
  (bit-boole boole-nor bit-array bit-array result-bit-array))

#+ppc-target
(progn
(defun result-bit-array (bit-array-1 bit-array-2 result)
  ; Check that the two bit-array args are bit-arrays with
  ; compatible dimensions.  If "result" is specified as T,
  ; return bit-array-1.  If result is unspecified, return
  ; a new bit-array of the same dimensions as bit-array-2.
  ; Otherwise, make sure that result is a bit-array of the
  ; same dimensions as the other two arguments and return
  ; it.
  (let* ((typecode-1 (ppc-typecode bit-array-1))
         (typecode-2 (ppc-typecode bit-array-2)))
    (declare (fixnum typecode-1 typecode-2))
    (flet ((bit-array-dimensions (bit-array typecode)
             (declare (fixnum typecode))
             (if (= typecode ppc::subtag-bit-vector)
               (uvsize bit-array)
               (let* ((array-p (= typecode ppc::subtag-arrayH))
                      (vector-p (= typecode ppc::subtag-vectorH)))
                 (if (and (or array-p vector-p) 
                          (= (the fixnum (%array-header-subtype bit-array)) ppc::subtag-bit-vector))
                   (if vector-p
                     (length bit-array)
                     (array-dimensions bit-array))
                   (report-bad-arg bit-array '(array bit))))))
           (check-matching-dimensions (a1 d1 a2 d2)
             (unless (equal d1 d2)
               (error "~s and ~s have different dimensions."  a1 a2))
             a2))
      (let* ((dims-1 (bit-array-dimensions bit-array-1 typecode-1))
             (dims-2 (bit-array-dimensions bit-array-2 typecode-2)))
        (check-matching-dimensions bit-array-1 dims-1 bit-array-2 dims-2)
        (if result
          (if (eq result t)
            bit-array-1
            (check-matching-dimensions bit-array-2 dims-2 result (bit-array-dimensions result (ppc-typecode result))))
          (make-array dims-2 :element-type 'bit :initial-element 0))))))

; If the bit-arrays are all simple-bit-vectorp, we can do the operations
; 32 bits at a time.  (other case have to worry about alignment/displacement.)
(defppclapfunction %simple-bit-boole ((op 0) (b1 arg_x) (b2 arg_y) (result arg_z))
  (la imm0 4 vsp)
  (save-lisp-context imm0)
  (vector-size imm4 result imm4)
  (srwi. imm3 imm4 5)
  (clrlwi imm4 imm4 27)
  (bl @get-dispatch)
  (cmpwi cr1 imm4 0)
  (mflr loc-pc)
  (lwz temp0 op vsp)
  (add loc-pc loc-pc temp0)
  (add loc-pc loc-pc temp0)
  (mtctr loc-pc)
  (li imm0 ppc::misc-data-offset)
  (b @testw)
  @nextw
  (cmpwi cr0 imm3 1)
  (subi imm3 imm3 1)
  (lwzx imm1 b1 imm0)
  (lwzx imm2 b2 imm0)
  (bctrl)
  (stwx imm1 result imm0)
  (addi imm0 imm0 4)
  @testw
  (bne cr0 @nextw)
  (beq cr1 @done)
  ; Not sure if we need to make this much fuss about the partial word
  ; in this simple case, but what the hell.
  (lwzx imm1 b1 imm0)
  (lwzx imm2 b2 imm0)
  (bctrl)
  (lwzx imm2 result imm0)
  (slw imm2 imm2 imm4)
  (srw imm2 imm2 imm4)
  (subfic imm4 imm4 32)
  (srw imm1 imm1 imm4)
  (slw imm1 imm1 imm4)
  (or imm1 imm1 imm2)
  (stwx imm1 result imm0)
  @done
  (restore-full-lisp-context)
  (blr)

  @get-dispatch 
  (blrl)
  @disptach
  (li imm1 0)                           ; boole-clr
  (blr)
  (li imm1 -1)                          ; boole-set
  (blr)
  (blr)                                 ; boole-1
  (blr)                             
  (mr imm1 imm2)                        ; boole-2
  (blr)
  (not imm1 imm1)                       ; boole-c1
  (blr)
  (not imm1 imm2)                       ; boole-c2
  (blr)
  (and imm1 imm1 imm2)                  ; boole-and
  (blr)
  (or imm1 imm1 imm2)                   ; boole-ior
  (blr)
  (xor imm1 imm1 imm2)                  ; boole-xor
  (blr)
  (eqv imm1 imm1 imm2)                  ; boole-eqv
  (blr)
  (nand imm1 imm1 imm2)                 ; boole-nand
  (blr)
  (nor imm1 imm1 imm2)                  ; boole-nor
  (blr)
  (andc imm1 imm2 imm1)                 ; boole-andc1
  (blr)
  (andc imm1 imm1 imm2)                 ; boole-andc2
  (blr)
  (orc imm1 imm2 imm1)                  ; boole-orc1
  (blr)
  (orc imm1 imm1 imm2)                  ; boole-orc2
  (blr))
  
(defun bit-boole (opcode array1 array2 result-array)
  (unless (eql opcode (logand 15 opcode))
    (setq opcode (require-type opcode '(mod 16))))
  (let* ((result (result-bit-array array1 array2 result-array)))
    (if (and (typep array1 'simple-bit-vector)
             (typep array2 'simple-bit-vector)
             (typep result 'simple-bit-vector))
      (%simple-bit-boole opcode array1 array2 result)
      (multiple-value-bind (v1 i1) (array-data-and-offset array1)
        (declare (simple-bit-vector v1) (fixnum i1))
        (multiple-value-bind (v2 i2) (array-data-and-offset array2)
          (declare (simple-bit-vector v2) (fixnum i2))
          (multiple-value-bind (v3 i3) (array-data-and-offset result)
            (declare (simple-bit-vector v3) (fixnum i3))
            (let* ((e3 (+ i3 (the fixnum (array-total-size result)))))
              (declare (fixnum e3))
              (do* ( )
                   ((= i3 e3) result)
                (setf (sbit v3 i3) 
                      (logand (boole opcode (sbit v1 i1) (sbit v2 i2)) 1))
                (incf i1)
                (incf i2)
                (incf i3)))))))))
)

          
          
#-ppc-target
(defun bit-boole (opcode array1 array2 result-array)
  (old-lap
   (preserve_regs #(asave0 asave1 dsave0 dsave1 dsave2 nilreg)) (equate _vtop 24)
   (ccall array-total-size arg_y)       ; array2
   (move.l acc dsave2)
   (move.l (varg array2 _vtop) atemp0)
   (bsr bitarrarg)
   (move.l atemp0 asave1)
   (move.l db dsave1)
   (move.l (varg array1 _vtop) atemp0)
   (add.w ($ 1) da)
   (spush da)
   (vpush arg_y)
   (bsr bitarrarg)
   (move.l atemp0 asave0)
   (move.l db dsave0)
   (vpop arg_z)
   (spop db)
   (sub.w ($ 1) db)
   (move.l (varg array2 _vtop) atemp0)
   (bsr cmparr)

   (move.l (varg result-array _vtop) atemp0)
   (if# (eq 'T atemp0)
     (move.l asave0 atemp0)
     (move.l dsave0 db)
    elseif# (eq nilreg atemp0)
     (move.l dsave2 acc)                  ; array total size
     (move.l ($ $v_bitv) da)
     (if# (eq (tst.w db))
       (jsr_subprim $sp-uvd1alloc)
      else#
       (vpush atemp1)
       (jsr_subprim $sp-uvd1alloc)
       (vpop atemp1)
       (vpush atemp0)
       (clr.l (-@ vsp))			;arh.rank4 & bits
       (move.b ($ $v_bitv) (vsp $arh_type))
       (clr.l (-@ vsp))			;arh.offs - fixnumzero
       (vpush atemp0)			;arh.vect
       (set_nargs 3)
       (move.l ($ 0) acc)
       (move.w (svref atemp1 arh.fixnum $arh_rank4) acc)
       (move.w acc (vsp (+ 8 $arh_rank4)))
       (add.l acc nargs)
       (lea (svref atemp1 arh.dims) atemp1)
       (prog# (vpush (@+ atemp1)) (until# (eq (sub.w ($ 4) acc))))
       (jsr_subprim $sp-vector)            ; atemp0 = acc = array
       (set_vsubtype ($ $v_arrayh) atemp0 da)
       (vpop atemp0))           ; atemp0 = vector
     (move.l acc (varg result-array _vtop))
     (move.l '0 db)
    else#
     (add.w ($ 1) db)
     (spush db)
     (vpush acc)
     (bsr bitarrarg)
     (vpop acc)
     (vpush atemp0) (vpush db)
     (spop db)
     (sub.w ($ 1) db)
     (move.l (varg array2 (+ 8 _vtop)) atemp0)
     (bsr cmparr)
     (vpop db) (vpop atemp0))
   (getint db)
   (move.l db da)
   (lsr.l ($ 3) db)
   (lea (atemp0 db.l (1+ $v_data)) atemp0)
   (getint dsave0)
   (move.l dsave0 db)
   (lsr.l ($ 3) db)
   (lea (asave0 db.l (1+ $v_data)) asave0)
   (getint dsave1)
   (move.l dsave1 db)
   (lsr.l ($ 3) db)
   (lea (asave1 db.l (1+ $v_data)) asave1)
   ;asave0/dsave0 = arg1 vector,offset asave1/dsave1=arg2 vector,offset, atemp0/da = result,offset
   ;dsave2 = size (boxed)
   (move.l (varg opcode _vtop) acc)
   (lsr.w ($ (1- $FIXNUMSHIFT)) acc)
   (and.w ($ #x1E) acc)
   (move.w acc db)
   (add.w acc acc)
   (add.w db acc)
   (lea (^ booleops) atemp1) (add.w acc atemp1)   ;(lea (^ booleops acc.w) atemp1)
   (lea (^ @masks) nilreg) (equate @lomask 0 @himask 8)     ; *** All inline after this point
   (move.l dsave2 dy)
   (getint dy)
   (move.l ($ 7) acc)
   (and.w acc dsave0)
   (and.w acc dsave1)
   (and.w da acc)
   (beq @even)
   (move.b (nilreg dsave0.w @lomask) da)
   (if# (gt (sub.w acc dsave0))
     (and.b (@+ asave0) da)
     (move.b (nilreg dsave0.w @himask) dsave2)
     (and.b (asave0) dsave2)
     (or.b dsave2 da)
     (rol.b dsave0 da)
    else#
     (and.b (asave0) da)
     (move.w dsave0 dsave2)
     (neg.w dsave2)
     (lsr.b dsave2 da)
     (add.w ($ 8) dsave0))
   (move.b (nilreg dsave1.w @lomask) db)
   (if# (gt (sub.w acc dsave1))
     (and.b (@+ asave1) db)
     (move.b (nilreg dsave1.w @himask) dsave2)
     (and.b (asave1) dsave2)
     (or.b dsave2 db)
     (rol.b dsave1 db)
    else#
     (and.b (asave1) db)
     (move.w dsave1 dsave2)
     (neg.w dsave2)
     (lsr.b dsave2 db)
     (add.w ($ 8) dsave1))
   (jsr (atemp1))
   (and.b (nilreg acc.w @lomask) da)
   (move.b (nilreg acc.w @himask) db)
   (and.b db (atemp0))
   (or.b da (@+ atemp0))
   (sub.l ($ 8) dy)
   (add.l acc dy)
   @even
   (move.l ($ 7) acc)
   (and.w dy acc)
   (lsr.l ($ 3) dy)
   (bra @next)
	
   @masks
   (dc.w #xFF7F #x3F1F #x0F07 #x0301)
   (dc.w #x0080 #xC0E0 #xF0F8 #xFCFE)

   @loop
   (move.b da (@+ atemp0))
   @next
   (move.b (nilreg dsave0.w @lomask) da)
   (and.b (@+ asave0) da)
   (move.b (nilreg dsave0.w @himask) dsave2)
   (and.b (asave0) dsave2)
   (or.b dsave2 da)
   (rol.b dsave0 da)
   (move.b (nilreg dsave1.w @lomask) db)
   (and.b (@+ asave1) db)
   (move.b (nilreg dsave1.w @himask) dsave2)
   (and.b (asave1) dsave2)
   (or.b dsave2 db)
   (rol.b dsave1 db)
   (jsr (atemp1))
   (sub.l ($ 1) dy)
   (bpl @loop)
   @done
   (and.b (nilreg acc.w @himask) da)
   (move.b (nilreg acc.w @lomask) db)
   (and.b db (atemp0))
   (or.b da (atemp0))
   (restore_regs)
   (move.l (varg result-array) acc)
   (lfret)

;bitarrarg (atemp0)
;On exit: atemp0/vector, db/offset (boxed),
;         atemp1/original array, da=rank4-4, dy/size(boxed) if da=0.
bitarrarg
   (move.l atemp0 atemp1)               ; original array
   (bif (ne (ttagp ($ $t_vector) atemp0 da)) @bad)
   (vsubtype atemp0 da)
   (move.l '0 db)
   (if# (eq (cmp.b ($ $v_arrayh) da))   ; array header
     (bif (ne (cmp.b ($ $v_bitv) (svref atemp1 arh.fixnum $arh_type))) @bad)
     (prog#
      (add.l (svref atemp0 arh.offs) db)
      (btst ($ $arh_disp_bit) (svref atemp0 arh.fixnum $arh_bits))
      (move.l (svref atemp0 arh.vect) atemp0)
      (until# eq))
     (move.w (svref atemp1 arh.fixnum $arh_rank4) da)
     (sub.w ($ 4) da)
     (bne @ret)
     (move.l (svref atemp1 arh.vlen) dy)
    else#                               ; simple vector
     (bif (ne (sub.b ($ $v_bitv) da)) @bad)
     (vsize atemp0 dy)
     (if# (ne (sub.l ($ 1) dy))
       (sub.l ($ 1) dy)
       (lsl.l ($ 3) dy)
       (move.b (atemp0 $v_data) da)
       (ext.w da)
       (ext.l da)
       (add.l da dy)
       (mkint dy)))
   (move.l ($ 0) da)
   @ret
   (rts)
   @bad (twtaerr atemp1 'bit-vector)


   cmparr
   (bif (ne (cmp.w db da)) @mismatch)
   (if# (eq (tst.w da))
     (bif (ne (cmp.l acc dy)) @mismatch)
     (rts))
   (prog#
    (move.l (atemp1 da.w (+ $v_data (* 4 arh.dims))) dy)
    (bif (ne (atemp0 da.w (+ $v_data (* 4 arh.dims))) dy) @mismatch)
    (until# (mi (sub.w ($ 4) da))))
   (rts)
   @mismatch
   (signal_error (fixnum $XDIFDIM))


   booleops
   (move.l ($ 0) da)		;clr
   (rts)
   (illegal)
   (move.l ($ -1) da)		;set
   (rts)
   (illegal)
   (rts)			;1
   (illegal)
   (illegal)
   (move.w db da)		;2
   (rts)
   (illegal)
   (not.w da)                   ;c1
   (rts)
   (illegal)
   (move.w db da)		;c2
   (not.w da)
   (rts)
   (and.w db da)		;and
   (rts)
   (illegal)
   (or.w db da)                 ;or
   (rts)
   (illegal)
   (eor.w db da)		;xor
   (rts)
   (illegal)
   (eor.w db da)		;eqv
   (not.w da)
   (rts)
   (and.w db da)		;nand
   (not.w da)
   (rts)
   (or.w db da)                 ;nor
   (not.w da)
   (rts)
   (not.w da)                   ;andc1
   (and.w db da)
   (rts)
   (not.w db)                   ;andc2
   (and.w db da)
   (rts)
   (not.w da)                   ;orc1
   (or.w db da)
   (rts)
   (not.w db)                   ;orc2
   (or.w db da)
   (rts)

))



; shrink-vector is called only in sequences-2. None of the calls depend on
; the side affect of setting the passed-in symbol to the [possibly new]
; returned vector
; Since there hasn't been such a thing as sequences-2 in about 7 years,
; this is especially puzzling.
(eval-when (:compile-toplevel :execute :load-toplevel)
  (defmacro shrink-vector (vector to-size)
    `(setq ,vector (%shrink-vector ,vector ,to-size)))
  )

#| old and faulty def
(defun %shrink-vector (vector to-size)
  "NOT Correct.  This is just a temporary patch that may COPY the vector."
  (when (> (length vector) to-size)
        (if (eq (%type-of vector) 'complex-array)
            (uvset vector 3 (if (array-has-fill-pointer-p vector)
                                 (min to-size (fill-pointer vector))
                                 to-size))
            (let ((new-vec (make-array to-size)))
                 (setq vector (dotimes (i to-size new-vec)
		                      (declare (fixnum i))
                                      (aset new-vec i (aref vector i)))))))
 vector)
|#

; new and faulty def
(defun %shrink-vector (vector to-size)
  (cond ((eq (length vector) to-size)
         vector)
        ((array-has-fill-pointer-p vector)
         (setf (fill-pointer vector) to-size)
         vector)
        (t (subseq vector 0 to-size))))



; this could be put into print-db as it was in ccl-pr-4.2
; Or it (and print-db) could just be flushed ... tough one.
(defun multi-dimension-array-to-list (array)
  "Produces a nested list of the elements in array."
  (mdal-aux array (array-dimensions array) nil 
            (array-dimensions array)))

(defun mdal-aux (array all-dimensions use-dimensions 
                       remaining-dimensions)
  (if (= (length all-dimensions) (length use-dimensions))
    (apply 'aref array use-dimensions)
    (do ((index 0 (1+ index))
         (d-length (car remaining-dimensions))
         (result nil))
        ((= d-length index) result)
      (setq result 
            (append result (list (mdal-aux array all-dimensions
                                           (append use-dimensions 
                                                   (list index))
                                           (cdr remaining-dimensions))))))))

(defun adjust-array (array dims
                     &key (element-type nil element-type-p)
                          (initial-element nil initial-element-p)
                          (initial-contents nil initial-contents-p)
                          (fill-pointer nil fill-pointer-p)
                          displaced-to
                          displaced-index-offset
                     &aux (subtype (array-element-subtype array)))
  (when (and element-type-p
             (neq (element-type-subtype element-type) subtype))
    (error "~S is not of element type ~S" array element-type))
  (when (integerp dims)(setq dims (list dims))) ; because %displace-array wants the list
  (if (neq (list-length dims)(array-rank array))
    (error "~S has wrong rank for adjusting to dimensions ~S" array dims))
  (let ((size 1))    
    (dolist (dim dims)
      (when (< dim 0)(report-bad-arg dims '(integer 0 *)))
      (setq size (* size dim)))
    (when (and (neq fill-pointer t)
               (array-has-fill-pointer-p array)
               (< size (or fill-pointer (fill-pointer array))))
      (error "Cannot adjust array ~S to size less than fill pointer ~S"
             array (or fill-pointer (fill-pointer array))))
    (when (and fill-pointer (not (array-has-fill-pointer-p array)))
        (error "~S does not have a fill pointer" array))
    (when (and displaced-index-offset (null displaced-to))
      (error "Cannot specify ~S without ~S" :displaced-index-offset :displaced-to))
    (when (and initial-element-p initial-contents-p)
        (error "Cannot specify both ~S and ~S" :initial-element :initial-contents))
    (cond 
     ((not (adjustable-array-p array))
      (let ((new-array (make-array-1  dims 
                                       (array-element-type array) T
                                       displaced-to
                                       displaced-index-offset
                                       nil
                                       fill-pointer
                                       initial-element initial-element-p
                                       initial-contents initial-contents-p
                                       size)))
                     
        (when (and (null initial-contents-p)
                   (null displaced-to))
          (multiple-value-bind (array-data offs) (array-data-and-offset array)
            (let ((new-array-data (array-data-and-offset new-array))) 
              (cond ((null dims)
                     (uvset new-array-data 0 (uvref array-data offs)))
                    (T
                   (init-array-data array-data offs (array-dimensions array) 
                                    new-array-data 0 dims))))))
        (setq array new-array)))
     (T (cond 
         (displaced-to
          (if (and displaced-index-offset 
                   (or (not (fixnump displaced-index-offset))
                       (< displaced-index-offset 0)))
            (report-bad-arg displaced-index-offset '(integer 0 #.most-positive-fixnum)))
          (when (or initial-element-p initial-contents-p)
            (error "Cannot specify initial values for displaced arrays"))
          (unless (eq subtype (array-element-subtype displaced-to))
            (error "~S is not of element type ~S"
                   displaced-to (array-element-type array)))
          (do* ((vec displaced-to (displaced-array-p vec)))
               ((null vec) ())
            (when (eq vec array)
              (error "Array cannot be displaced to itself."))))
         (T
          (setq displaced-to (#-ppc-target %make-uvector
                              #+ppc-target %alloc-misc size subtype))      
          (cond (initial-element-p
                 (dotimes (i (the fixnum size)) (uvset displaced-to i initial-element)))
                (initial-contents-p
                 (if (null dims) (uvset displaced-to 0 initial-contents)
                     (init-uvector-contents displaced-to 0 dims initial-contents))))
          (cond ((null dims)
                 (uvset displaced-to 0 (aref array)))
                ((not initial-contents-p)
                 (multiple-value-bind (vec offs) (array-data-and-offset array)
                   (init-array-data vec offs (array-dimensions array) displaced-to 0 dims))))))
        (%displace-array array dims size displaced-to (or displaced-index-offset 0))))
    (when fill-pointer-p
      (cond
        ((eq fill-pointer t)
         (set-fill-pointer array size))
        (fill-pointer
         (set-fill-pointer array fill-pointer))))
    array))

(defun array-dims-sizes (dims)
   (if (or (atom dims) (null (%cdr dims))) dims
     (let ((ndims (array-dims-sizes (%cdr dims))))
       (cons (* (%car dims) (%car ndims)) ndims))))

(defun init-array-data (vec off dims nvec noff ndims)
   (init-array-data-aux vec off dims (array-dims-sizes (cdr dims))
                        nvec noff ndims (array-dims-sizes (cdr ndims))))

(defun init-array-data-aux (vec off dims siz nvec noff ndims nsiz)
   (when (null siz)
      (return-from init-array-data-aux
         (init-vector-data vec off (car dims) nvec noff (car ndims))))
   (let ((count (pop dims))
         (size (pop siz))
         (ncount (pop ndims))
         (nsize (pop nsiz)))
     (dotimes (i (if (%i< count ncount) count ncount))
        (declare (fixnum i))
        (init-array-data-aux vec off dims siz nvec noff ndims nsiz)
        (setq off (%i+ off size) noff (%i+ noff nsize)))))

(defun init-vector-data (vec off len nvec noff nlen)
  (dotimes (i (if (%i< len nlen) len nlen))
     (declare (fixnum i))
     (uvset nvec noff (uvref vec off))
     (setq off (%i+ off 1) noff (%i+ noff 1))))

; only caller is adjust-array
#-PPC-target
(defun %displace-array (array dims size data offset)
  (unless (eq (%type-of array) 'complex-array)
    (error "Array ~S cannot be displaced" array))
  (unless (fixnump offset) (report-bad-arg offset '(integer 0 #.most-positive-fixnum)))
  (unless (adjustable-array-p data)
    (multiple-value-bind (ndata noffset) (displaced-array-p data)
      (if ndata (setq data ndata offset (%i+ offset noffset)))))
  (unless (and (fixnump size) (%i<= (%i+ offset size) (array-total-size data)))
    (error "Offset ~S + size ~S must be less than size of array displaced-to" offset size))
  (lap-inline ()
    (:variable array data offset dims size)
    (move.l (varg array) atemp0)
    (move.l (varg data) atemp1)
    (move.l atemp1 (svref atemp0 arh.vect))
    (bclr ($ $arh_disp_bit) (svref atemp0 arh.fixnum $arh_bits))
    (if# (eq (vsubtypep ($ $v_arrayh) atemp1 da))
      (bset ($ $arh_disp_bit) (svref atemp0 arh.fixnum $arh_bits)))
    (move.l (varg offset) (svref atemp0 arh.offs))
    (lea (svref atemp0 arh.dims) atemp0)
    (move.l (varg dims) atemp1)
    (while# (ne atemp1 nilreg)
            (move.l (car atemp1) (@+ atemp0))
            (move.l (cdr atemp1) atemp1))
    (move.l (varg array) atemp0)
    (if# (and (eq (cmp.w ($ $arh_one_dim) (svref atemp0 arh.fixnum $arh_rank4)))
              (or (eq (btst ($ $arh_fill_bit) (svref atemp0 arh.fixnum $arh_bits)))
                  (gt (progn (move.l (svref atemp0 arh.fill) da)
                             (cmp.l (varg size) da)))))
      (move.l (varg size) (svref atemp0 arh.fill)))
    (move.l atemp0 acc)))

#+ppc-target
(defun %displace-array (array dims size data offset)
  (let* ((typecode (ppc-typecode array))
         (array-p (eql typecode ppc::subtag-arrayH))
         (vector-p (eql typecode ppc::subtag-vectorH)))
    (unless (or array-p vector-p)
      (error "Array ~S cannot be displaced" array))
    (unless (fixnump offset) (report-bad-arg offset '(integer 0 #.most-positive-fixnum)))
    (unless (adjustable-array-p data)
      (multiple-value-bind (ndata noffset) (displaced-array-p data)
        (if ndata (setq data ndata offset (%i+ offset noffset)))))
    (unless (and (fixnump size) (%i<= (%i+ offset size) (array-total-size data)))
      (error "Offset ~S + size ~S must be less than size of array displaced-to" offset size))
    (let* ((flags (%svref array ppc::vectorH.flags-cell)))
      (declare (fixnum flags))
      (setf (%svref array ppc::vectorH.flags-cell)
            (if (> (the fixnum (ppc-typecode data)) ppc::subtag-vectorH)
              (bitclr $arh_disp_bit flags)
              (bitset $arh_disp_bit flags)))
      (setf (%svref array ppc::arrayH.data-vector-cell) data)
      (if array-p
        (progn
          (do ((i ppc::arrayH.dim0-cell (1+ i)))
              ((null dims))
            (declare (fixnum i))
            (setf (%svref array i) (pop dims)))
          (setf (%svref array ppc::arrayH.physsize-cell) size)
          (setf (%svref array ppc::arrayH.displacement-cell) offset))
        (progn
          (if (or (not (logbitp $arh_fill_bit flags))
                  (> (the fixnum (%svref array ppc::vectorH.logsize-cell)) size))
            (setf (%svref array ppc::vectorH.logsize-cell) size))
          (setf (%svref array ppc::vectorH.physsize-cell) size)
          (setf (%svref array ppc::vectorH.displacement-cell) offset)))
      array)))

#-ppc-target
(defun array-row-major-index (&lap array &rest subscripts)
  (old-lap
   (klexpr 1)
   (jsr #'%%array-bounds)
   (if# (eq nilreg acc) (signal_error (fixnum $XARROOB) db atemp0))
   (lfret)))

#+ppc-target
(defun array-row-major-index (array &lexpr subscripts)
  (let ((rank  (array-rank array))
        (nsubs (%lexpr-count subscripts))
        (sum 0))
    (declare (fixnum sum rank))
    (unless (eql rank nsubs)
      (%err-disp $xndims array nsubs))    
      (if (eql 0 rank)
        0
        (do* ((i (1- rank) (1- i))
              (dim (array-dimension array i) (array-dimension array i))
              (last-size 1 size)
              (size dim (* dim size)))
             (nil)
          (declare (fixnum i last-size size))
          (let ((s (%lexpr-ref subscripts nsubs i)))
            (unless (fixnump s)
              (setq s (require-type s 'fixnum)))
            (when (or (< s 0) (>= s dim))
              (%err-disp $XARROOB (%apply-lexpr 'list subscripts) array))
            (incf sum (the fixnum (* s last-size)))
            (when (eql i 0) (return sum)))))))

#+ppc-target
(defun array-in-bounds-p (array &lexpr subscripts)
  (let ((rank  (array-rank array))
        (nsubs (%lexpr-count subscripts)))
    (declare (fixnum sum rank))    
    (if (not (eql nsubs rank))
      (%err-disp $xndims array nsubs)
      (if (eql 0 rank)
        0
        (do* ((i (1- rank) (1- i))
              (dim (array-dimension array i) (array-dimension array i)))
             (nil)
          (declare (fixnum i))
          (let ((s  (%lexpr-ref subscripts nsubs i)))
            (require-type s 'fixnum)
            (if (or (< s 0)(>= s dim)) (return nil))
            (when (eql i 0) (return t))))))))

(defun row-major-aref (array index)
  (multiple-value-bind (displaced-to offset) (displaced-array-p array)
    (aref (or displaced-to array) (+ index offset))))

(defun row-major-aset (array index new)
  (multiple-value-bind (displaced-to offset) (displaced-array-p array)
    (setf (aref (or displaced-to array) (+ index offset)) new)))

(defsetf row-major-aref row-major-aset)

;(export '(array-displacement) (find-package :ccl))

(declaim (inline array-displacement))

(defun array-displacement (array) ;; ANSI thing
  (displaced-array-p array))
             
#-ppc-target
(defun array-in-bounds-p (&lap array &rest subscripts)
  (old-lap
   (klexpr 1)
   (jsr #'%%array-bounds)
   (lfret)))



#-ppc-target
(defun %%array-bounds (&lap 0)
  (old-lap
   (lea (vsp nargs.w) atemp1)
   (move.l (atemp1) atemp0)
   (if# (eq (jsr_subprim $sp-arrayarg))   ; preserves atemp1, nargs
     (jsr_subprim $sp-arridx)
     (bmi @nil)
     (rts))
   (if# (ne (cmp.w ($ 4) nargs))
     (move.l ($ 0) acc)
     (move.w nargs acc)
     (vunscale.l acc)
     (signal_error (fixnum $xndims) atemp0 acc))
   (jsr_subprim $sp-uvd1siz)
   (move.l acc dy)
   (move.l (vsp) acc)
   (if# (ne (ttagp ($ $t_fixnum) acc da))
     (Twtaerr acc 'fixnum))
   (cmp.l dy acc)
   (if# geu
     (move.l acc db)
     @nil (move.l nilreg acc))   ; db has the bad index
   (rts)))

; end
