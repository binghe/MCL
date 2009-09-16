;;;-*- Mode: Lisp; Package: CCL -*-

;; $Log: ppc-vinsns.lisp,v $
;; Revision 1.6  2003/12/08 08:25:21  gtbyers
;; Backend changes for %SLOT-REF, %SLOT-UNBOUND-MARKER.
;;
;; Revision 1.5  2003/12/01 17:56:06  gtbyers
;; recover pre-MOP changes
;;
;; Revision 1.3  2003/11/17 21:03:52  alice
;; ; 11/14/03 Replacing the MCRXR with (MTXER rzero)
;;
;; Revision 1.2  2002/11/18 05:36:40  gtbyers
;; Add CVS log marker
;;
;;	Change History (most recent first):
;;  32 6/16/96 akh  negate-no-ovf
;;  30 6/7/96  akh  %iasr, %ilsl, %ilsr, %schar etc
;;  28 4/19/96 akh  from gb
;;  27 4/17/96 akh  gary's fix for negate-fixnum
;;  26 4/11/96 bill 3.1d97
;;  24 4/9/96  Bill St. Clair 3.1d95
;;  21 2/19/96 akh  fix vinsn used by (setf (sbit ....)) xx-bit-bit0
;;  13 11/19/95 gb  &lexpr fixes
;;  12 11/15/95 gb  fix subtract-from-fixnum, thing used in point-v
;;  11 11/14/95 gb  fix gt->bit31
;;  6 10/26/95 gb   srwi vice slwi in unbox-[base-]character
;;  3 10/12/95 slh  missing label added
;;  2 10/6/95  gb   Additions & fixes.
;;  (do not edit before this line!!)

; Modification History
;
;negate-fisnum, u32->integer and s32->integer eliminate use of slow uuo's at some cost in verbosity
; ditto fixnum-add-overflow and fixnum-sub-overflow 
; ------- 5.2b6
; fix misc-ref-c-bit[fixnum] and friend 
; --- 5.2b1
; 11/14/03 Replacing the MCRXR with (MTXER rzero) 
; -------- 5.0 final
; alloc-c-frame multiple 16 bytes
; ---------- 4.4b3 
; 04/01/99 akh add vinsn for fixnum ash
; ---------- 4.3b1
; 12/31/98 AKH add misc-ref-data-vector and 2d-array-index
; 12/18/98 akh make-tsp-sFLOAT say lfs, stfs. add misc-set-c-single-float and misc-set-single-float
; 03/01/97 gb    lotsa changes.
; -------------  4.0
; 10/07/96 bill  from Gary: call-label
; -------------  4.0b2
; 07/16/96 bill  save-argregs' entry-vsp computation works with a segmented VSP stack.
; 07/03/96 bill  from Gary: %debug-trap is (bla .SPbreakpoint)
; 06/16/96 bill  comment out %stack-cons, no longer used.
;                temp-pop-unboxed-word, temp-pop-double-float, temp-pop-single-float
;                restore TSP with a load, not an add.
; 06/20/96 gb   compare: no restriction on operand types.  %debug-trap.  
;                don't force (:crf 0) when :crf will do.
; akh %iasr, %ilsl, %ilsr, %schar etc
; 05/07/96 bill  add-immediate works correctly when upper is non-zero
; -------------  MCL-PPC 3.9
; 04/18/96 gb    clear-FPU-exceptions: use zeroed FP temp reg to clear more bits.
;                negate-fixnum: uuo_fixnum_overflow if overflow.
; 04/11/96 alice require-number signals ppc::error-object-not-number
; 04/02/96 bill  alloc-c-frame does the right thing for more than 8 args
; 03/14/96 bill  clear-fpu-exceptions from GB
; 03/10/96 gb    some FP stuff
; 01/19/96 bill  (fixup-vinsn-templates) at end.
; 02/02/96 gb    package typo in trap-unless-numeric-type.
; 01/19/96 gb    fixnum-overflow arithmetic simpler; restore-context
;                reloads lr itself (so subprim doesn't juggle it).  add
;                COPY-FPR.  LWI split in half (less bignum consing.)
; 12/27/95 gb    new vinsns, some have attributes (needs more work.)
; 12/13/95 gb    csp overflow check after alloc frame. more vinsns
; 11/15/95 gb    s32-highword; fix thing that does subfic.
; 11/10/95 gb    s32-highword; imm vice :lisp when boxing/unboxing fixnums.
; 11/04/95 gb    stack-probes when building frames.
; 10/26/95 slh   Gary's %ilsr fix

; Copyright 1995-1999 Digitool, Inc.

(cl:in-package "CCL")

(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (require "VINSN"))


; Index "scaling" and constant-offset misc-ref vinsns.

(define-vinsn scale-32bit-misc-index (((dest :u32))
                                      ((idx :imm)      ; A fixnum
                                       )
                                      ())
  (addi dest idx ppc::misc-data-offset))

(define-vinsn scale-16bit-misc-index (((dest :u32))
                                      ((idx :imm)      ; A fixnum
                                       )
                                      ())
  (srwi dest idx 1)
  (addi dest dest ppc::misc-data-offset))

(define-vinsn scale-8bit-misc-index (((dest :u32))
                                     ((idx :imm)      ; A fixnum
                                      )
                                      ())
  (srwi dest idx 2)
  (addi dest dest ppc::misc-data-offset))

(define-vinsn scale-64bit-misc-index (((dest :u32))
                                     ((idx :imm)      ; A fixnum
                                      )
                                      ())
  (slwi dest idx 1)
  (addi dest dest ppc::misc-dfloat-offset))

(define-vinsn scale-1bit-misc-index (((word-index :u32)
                                      (bitnum :u8))     ; (unsigned-byte 5)
                                     ((idx :imm)      ; A fixnum
                                      )
                                     )
  ; Logically, we want to:
  ; 1) Unbox the index by shifting it right 2 bits.
  ; 2) Shift (1) right 5 bits
  ; 3) Scale (2) by shifting it left 2 bits.
  ; We get to do all of this with one instruction
  (rlwinm word-index idx (- ppc::nbits-in-word 5) 5 (- ppc::least-significant-bit ppc::fixnum-shift))
  (addi word-index word-index ppc::misc-data-offset)     ; Hmmm. Also one instruction, but less impressive somehow.
  (extrwi bitnum idx 5 (- ppc::nbits-in-word (+ ppc::fixnum-shift 5))))



(define-vinsn misc-ref-u32  (((dest :u32))
                             ((v :lisp)
                              (scaled-idx :u32))
                             ())
  (lwzx dest v scaled-idx))

(define-vinsn misc-ref-c-u32  (((dest :u32))
                               ((v :lisp)
                                (idx :u32const))
                               ())
  (lwz dest (:apply + ppc::misc-data-offset (:apply ash idx 2)) v))

(define-vinsn misc-ref-s32 (((dest :s32))
                             ((v :lisp)
                              (scaled-idx :u32))
                             ())
   (lwzx dest v scaled-idx))

(define-vinsn misc-ref-c-s32  (((dest :s32))
                               ((v :lisp)
                                (idx :u32const))
                               ())
  (lwz dest (:apply + ppc::misc-data-offset (:apply ash idx 2)) v))


(define-vinsn misc-set-c-u32 (()
                              ((val :u32)
                               (v :lisp)
                               (idx :u32const)))
  (stw val (:apply + ppc::misc-data-offset (:apply ash idx 2)) v))

(define-vinsn misc-set-u32 (()
                              ((val :u32)
                               (v :lisp)
                               (scaled-idx :u32)))
  (stwx val v scaled-idx))

                              
(define-vinsn misc-ref-single-float  (((dest :single-float))
                                     ((v :lisp)
                                      (scaled-idx :u32))
                                     ())
  (lfsx dest v scaled-idx))

(define-vinsn misc-ref-c-single-float  (((dest :single-float))
                                       ((v :lisp)
                                        (idx :u32const))
                                       ())
  (lfs dest (:apply + ppc::misc-data-offset (:apply ash idx 2)) v))

(define-vinsn misc-ref-double-float  (((dest :double-float))
                                      ((v :lisp)
                                       (scaled-idx :u32))
                                      ())
  (lfdx dest v scaled-idx))


(define-vinsn misc-ref-c-double-float  (((dest :double-float))
                                        ((v :lisp)
                                         (idx :u32const))
                                        ())
  (lfd dest (:apply + ppc::misc-dfloat-offset (:apply ash idx 3)) v))

(define-vinsn misc-set-c-double-float (((val :double-float))
                                       ((v :lisp)
                                        (idx :u32const)))
  (stfd val (:apply + ppc::misc-dfloat-offset (:apply ash idx 3)) v))

(define-vinsn misc-set-c-single-float (((val :single-float))
                                       ((v :lisp)
                                        (idx :u32const)))
  (stfs val (:apply + ppc::misc-data-offset (:apply ash idx 2)) v))

(define-vinsn misc-set-double-float (()
                                     ((val :double-float)
                                      (v :lisp)
                                      (scaled-idx :u32)))
  (stfdx val v scaled-idx))

(define-vinsn misc-set-single-float (()
                                     ((val :single-float)
                                      (v :lisp)
                                      (scaled-idx :u32)))
  (stfsx val v scaled-idx))




(define-vinsn misc-ref-u16  (((dest :u16))
                             ((v :lisp)
                              (scaled-idx :u32))
                             ())
  (lhzx dest v scaled-idx))

(define-vinsn misc-ref-c-u16  (((dest :u16))
                               ((v :lisp)
                                (idx :u32const))
                               ())
  (lhz dest (:apply + ppc::misc-data-offset (:apply ash idx 1)) v))

(define-vinsn misc-set-c-u16  (((val :u16))
                               ((v :lisp)
                                (idx :u32const))
                               ())
  (sth val (:apply + ppc::misc-data-offset (:apply ash idx 1)) v))

(define-vinsn misc-set-u16 (((val :u16))
                            ((v :lisp)
                             (scaled-idx :s32)))
  (sthx val v scaled-idx))

(define-vinsn misc-ref-s16  (((dest :s16))
                             ((v :lisp)
                              (scaled-idx :u32))
                             ())
  (lhax dest v scaled-idx))

(define-vinsn misc-ref-c-s16  (((dest :s16))
                               ((v :lisp)
                                (idx :u32const))
                               ())
  (lha dest (:apply + ppc::misc-data-offset (:apply ash idx 1)) v))

(define-vinsn misc-ref-u8  (((dest :u8))
                             ((v :lisp)
                              (scaled-idx :u32))
                             ())
  (lbzx dest v scaled-idx))

(define-vinsn misc-ref-c-u8  (((dest :u8))
                               ((v :lisp)
                                (idx :u32const))
                               ())
  (lbz dest (:apply + ppc::misc-data-offset idx) v))

(define-vinsn misc-set-c-u8  (((val :u8))
                               ((v :lisp)
                                (idx :u32const))
                               ())
  (stb val (:apply + ppc::misc-data-offset idx) v))

(define-vinsn misc-set-u8  (((val :u8))
                            ((v :lisp)
                             (scaled-idx :u32))
                            ())
  (stbx val v scaled-idx))

(define-vinsn misc-ref-s8  (((dest :s8))
                            ((v :lisp)
                             (scaled-idx :u32))
                            ())
  (lbzx dest v scaled-idx)
  (extsb dest dest))

(define-vinsn misc-ref-c-s8  (((dest :s8))
                               ((v :lisp)
                                (idx :u32const))
                               ())
  (lbz dest (:apply + ppc::misc-data-offset idx) v)
  (extsb dest dest))


(define-vinsn misc-ref-c-bit (((dest :u8))
                              ((v :lisp)
                               (idx :u32const))
                              ())
  (lwz dest (:apply + ppc::misc-data-offset (:apply ash (:apply ash idx -5) 2)) v)
  (rlwinm dest dest (:apply 1+ (:apply logand idx #x1f)) 31 31))

(define-vinsn misc-ref-c-bit[fixnum] (((dest :imm))
                                      ((v :lisp)
                                       (idx :u32const))
                                      ((temp :u32)))
  (lwz temp (:apply + ppc::misc-data-offset (:apply ash (:apply ash idx -5) 2)) v)  ;;<<< fix
  (rlwinm dest 
          temp
          (:apply + 1  ppc::fixnumshift (:apply logand idx #x1f)) 
          (- ppc::least-significant-bit ppc::fixnumshift)
          (- ppc::least-significant-bit ppc::fixnumshift)))


(define-vinsn misc-ref-node  (((dest :lisp))
                              ((v :lisp)
                               (scaled-idx :s32))
                              ())
  (lwzx dest v scaled-idx))

(define-vinsn misc-set-node (()
                             ((val :lisp)
                              (v :lisp)
                              (scaled-idx :s32))
                             ())
  (stwx val v scaled-idx))

(define-vinsn (misc-set-node& :call :subprim-call) (()
                                                    ((val :lisp)
                                                     (v :lisp)
                                                     (scaled-idx :s32))
                                                    ())
  (add ppc::loc-g v scaled-idx)
  (stw val 0 ppc::loc-g)
  (bla .SPwrite-barrier))


(define-vinsn misc-ref-c-node (((dest :lisp))
                              ((v :lisp)
                               (idx :s16const))
                              ())
  (lwz dest (:apply + ppc::misc-data-offset (:apply ash idx 2)) v))

(define-vinsn misc-set-c-node (()
                               ((val :lisp)
                                (v :lisp)
                                (idx :s16const))
                               ())
  (stw val (:apply + ppc::misc-data-offset (:apply ash idx 2)) v))

(define-vinsn (misc-set-c-node& :call :subprim-call) (()
                                                      ((val :lisp)
                                                       (v :lisp)
                                                       (idx :s16const))
                                                      ())
  (la ppc::loc-g (:apply + ppc::misc-data-offset (:apply ash idx 2)) v)
  (stw val 0 ppc::loc-g)
  (bla .SPwrite-barrier))

; We should rarely need to do this; more often interested in
; the element-count or subtag than in the "whole" header.
(define-vinsn misc-ref-header (((dest :u32))
                               ((v :lisp))
                               ())
  (lwz dest ppc::misc-header-offset v))

(define-vinsn misc-element-count[fixnum] (((dest :imm))
                                          ((v :lisp))
                                          ((temp :u32)))
  (lwz temp ppc::misc-header-offset v)
  (rlwinm dest 
          temp 
          (- ppc::nbits-in-word (- ppc::num-subtag-bits ppc::fixnumshift))
          (- ppc::num-subtag-bits ppc::fixnumshift) 
          (- ppc::least-significant-bit ppc::fixnumshift)))

(define-vinsn check-misc-bound (()
                                ((idx :imm)
                                 (v :lisp))
                                ((temp :u32)
                                 (crf :crf)))
  (lwz temp ppc::misc-header-offset v)
  (rlwinm temp 
          temp 
          (- ppc::nbits-in-word (- ppc::num-subtag-bits ppc::fixnumshift))
          (- ppc::num-subtag-bits ppc::fixnumshift) 
          (- ppc::least-significant-bit ppc::fixnumshift))
  (cmplw crf idx temp)
  (blt crf :ok)
  (bla .SPuuovectorbounds)
  (uuo_vector_bounds idx v)
  :ok)
 

  
(define-vinsn misc-element-count[u32] (((dest :u32))
                                       ((v :lisp))
                                       ())
  (lwz dest ppc::misc-header-offset v)
  (srwi dest dest ppc::num-subtag-bits))

(define-vinsn misc-subtag[fixnum] (((dest :imm))
                                   ((v :lisp))
                                   ((temp :u32)))
  (lbz temp ppc::misc-subtag-offset v)
  (slwi dest temp ppc::fixnumshift))

(define-vinsn misc-subtag[u32] (((dest :u32))
                                ((v :lisp))
                                ())
  (lbz dest ppc::misc-subtag-offset v))

(define-vinsn header->subtag[u32] (((dest :u32))
                                   ((header :u32))
                                   ())
  (clrlwi dest header (- ppc::nbits-in-word ppc::num-subtag-bits)))

(define-vinsn header->subtag[fixnum] (((dest :imm))
                                      ((header :u32))
                                      ())
  (rlwinm dest 
          header 
          ppc::fixnumshift 
          (- ppc::nbits-in-word (+ ppc::nfixnumtagbits ppc::num-subtag-bits)) 
          (- ppc::least-significant-bit ppc::nfixnumtagbits)))

(define-vinsn header->element-count[u32] (((dest :u32))
                                          ((header :u32))
                                          ())
  (srwi dest header ppc::num-subtag-bits))

  
(define-vinsn node-slot-ref  (((dest :lisp))
                              ((node :lisp)
                               (cellno :u32const)))
  (lwz dest (:apply + ppc::misc-data-offset (:apply ash cellno 2)) node))

(define-vinsn slot-ref (((dest :lisp))
                         ((instance (:lisp (:ne dest)))
                          (index :lisp))
                         ((scaled :s32)
                          (crf :crf)))
  (la scaled ppc::misc-data-offset index)
  (lwzx dest instance scaled)
  (cmpwi crf dest ppc::slot-unbound-marker)
  (bne crf :ok)
  (bla .SPuuoslot-unbound)
  (uuo_slot_unbound dest instance index)
  :ok)



(define-vinsn node-slot-set (()
                             ((node :lisp)
                              (cellno :u32const)
                              (newval :lisp)))
  (stw newval (:apply + ppc::misc-data-offset (:apply ash cellno 2)) node))


(define-vinsn (node-slot-set& :call :subprim-call) (()
                                                    ((node :lisp)
                                                     (cellno :u32const)
                                                     (newval :lisp)))
  (la ppc::loc-g (:apply + ppc::misc-data-offset (:apply ash cellno 2)) node)
  (stw newval 0 ppc::loc-g)
  (bla .SPwrite-barrier))


; Untagged memory reference & assignment.

(define-vinsn mem-ref-c-fullword (((dest :u32))
                                  ((src :address)
                                   (index :s16const)))
  (lwz dest index src))

(define-vinsn mem-ref-fullword (((dest :u32))
                                ((src :address)
                                 (index :s16)))
  (lwzx dest src index))

(define-vinsn mem-ref-c-u16 (((dest :u16))
                             ((src :address)
                              (index :s16const)))
  (lhz dest index src))

(define-vinsn mem-ref-u16 (((dest :u16))
                           ((src :address)
                            (index :s16)))
  (lhzx dest src index))


(define-vinsn mem-ref-c-s16 (((dest :s16))
                             ((src :address)
                              (index :s16const)))
  (lha dest src index))

(define-vinsn mem-ref-s16 (((dest :s16))
                           ((src :address)
                            (index :s16)))
  (lhax dest src index))

(define-vinsn mem-ref-c-u8 (((dest :u8))
                            ((src :address)
                             (index :s16const)))
  (lbz dest index src))

(define-vinsn mem-ref-u8 (((dest :u8))
                          ((src :address)
                           (index :s16)))
  (lbzx dest src index))

(define-vinsn mem-ref-c-s8 (((dest :s8))
                            ((src :address)
                             (index :s16const)))
  (lbz dest index src)
  (extsb dest dest))

(define-vinsn mem-ref-s8 (((dest :s8))
                          ((src :address)
                           (index :s16)))
  (lbzx dest src index)
  (extsb dest dest))


(define-vinsn mem-set-c-fullword (()
                                  ((val :u32)
                                   (src :address)
                                   (index :s16const)))
  (stw val index src))

(define-vinsn mem-set-fullword (()
                                 ((val :u32)
                                  (src :address)
                                  (index :s32)))
  (stwx val src index))

(define-vinsn mem-set-c-halfword (()
                                  ((val :u16)
                                   (src :address)
                                   (index :s16const)))
  (sth val index src))

(define-vinsn mem-set-halfword (()
                                 ((val :u16)
                                  (src :address)
                                  (index :s32)))
  (sthx val src index))

(define-vinsn mem-set-c-byte (()
                              ((val :u16)
                               (src :address)
                               (index :s16const)))
  (stb val index src))

(define-vinsn mem-set-byte (()
                            ((val :u16)
                             (src :address)
                             (index :s32)))
  (stbx val src index))


; Tag and subtag extraction, comparison, checking, trapping ...

(define-vinsn extract-tag (((tag :u8)) 
                           ((object :lisp)) 
                           ())
  (clrlwi tag object (- ppc::nbits-in-word ppc::nlisptagbits)))

(define-vinsn extract-tag[fixnum] (((tag :imm))
                                   ((object :lisp)))
  (rlwinm tag 
          object 
          ppc::fixnum-shift 
          (- ppc::nbits-in-word 
             (+ ppc::nlisptagbits ppc::fixnum-shift)) 
          (- ppc::least-significant-bit ppc::fixnum-shift)))

(define-vinsn extract-fulltag (((tag :u8))
                               ((object :lisp))
                               ())
  (clrlwi tag object (- ppc::nbits-in-word ppc::ntagbits)))


(define-vinsn extract-fulltag[fixnum] (((tag :imm))
                                       ((object :lisp)))
  (rlwinm tag 
          object 
          ppc::fixnum-shift 
          (- ppc::nbits-in-word 
             (+ ppc::ntagbits ppc::fixnum-shift)) 
          (- ppc::least-significant-bit ppc::fixnum-shift)))

(define-vinsn extract-typecode (((code :u8))
                                ((object :lisp))
                                ((crf :crf)))
  (clrlwi code object (- ppc::nbits-in-word ppc::nlisptagbits))
  (cmpwi crf code ppc::tag-misc)
  (bne crf :not-misc)
  (lbz code ppc::misc-subtag-offset object)
  :not-misc)

(define-vinsn extract-typecode[fixnum] (((code :imm))
                                        ((object (:lisp (:ne code))))
                                        ((crf :crf) (subtag :u8)))
  (rlwinm code 
          object 
          ppc::fixnum-shift 
          (- ppc::nbits-in-word 
             (+ ppc::nlisptagbits ppc::fixnum-shift)) 
          (- ppc::least-significant-bit ppc::fixnum-shift))
  (cmpwi crf code (ash ppc::tag-misc ppc::fixnum-shift))
  (bne crf :not-misc)
  (lbz subtag ppc::misc-subtag-offset object)
  (slwi code subtag ppc::fixnum-shift)
  :not-misc)


(define-vinsn require-fixnum (()
                              ((object :lisp))
                              ((crf0 (:crf 0))
                               (tag :u8)))
  :again
  (clrlwi. tag object (- ppc::nbits-in-word ppc::nlisptagbits))
  (beq crf0 :got-it)
  (bla .SPxuuo-intcerr)
  (uuo_intcerr ppc::error-object-not-fixnum object)
  (b :again)
  :got-it)

(define-vinsn require-integer (()
                               ((object :lisp))
                               ((crf0 (:crf 0))
                                (tag :u8)))
  :again
  (clrlwi. tag object (- ppc::nbits-in-word ppc::nlisptagbits))
  (beq crf0 :got-it)
  (cmpwi crf0 tag ppc::tag-misc)
  (bne crf0 :no-got)
  (lbz tag ppc::misc-subtag-offset object)
  (cmpwi crf0 tag ppc::subtag-bignum)
  (beq crf0 :got-it)
  :no-got
  (bla .SPxuuo-intcerr)
  (uuo_intcerr ppc::error-object-not-integer object)
  (b :again)
  :got-it)

(define-vinsn require-simple-vector (()
                                     ((object :lisp))
                                     ((tag :u8)
                                      (crf :crf)))
  :again
  (clrlwi tag object (- ppc::nbits-in-word ppc::nlisptagbits))
  (cmpwi crf tag ppc::tag-misc)
  (bne crf :no-got)
  (lbz tag ppc::misc-subtag-offset object)
  (cmpwi crf tag ppc::subtag-simple-vector)
  (beq crf :got-it)
  :no-got
  (bla .SPxuuo-intcerr)
  (uuo_intcerr ppc::error-object-not-simple-vector object)
  (b :again)
  :got-it)

(define-vinsn require-simple-string (()
                                     ((object :lisp))
                                     ((tag :u8)
                                      (crf :crf)
                                      (crf2 :crf)))
  :again
  (clrlwi tag object (- ppc::nbits-in-word ppc::nlisptagbits))
  (cmpwi crf tag ppc::tag-misc)
  (bne crf :no-got)
  (lbz tag ppc::misc-subtag-offset object)
  (cmpwi crf tag ppc::subtag-simple-base-string)
  (cmpwi crf2 tag ppc::subtag-simple-general-string)
  (beq crf :got-it)
  (beq crf2 :got-it)
  :no-got
  (bla .SPxuuo-intcerr)
  (uuo_intcerr ppc::error-object-not-simple-string object)
  (b :again)
  :got-it)

  
(define-vinsn require-real (()
                            ((object :lisp))
                            ((crf0 (:crf 0))
                             (tag :u8)))
  :again
  (clrlwi. tag object (- ppc::nbits-in-word ppc::nlisptagbits))
  (beq crf0 :got-it)
  (cmpwi crf0 tag ppc::tag-misc)
  (bne crf0 :no-got)
  (lbz tag ppc::misc-subtag-offset object)
  (cmplwi crf0 tag ppc::max-real-subtag)
  (ble crf0 :got-it)
  :no-got
  (bla .SPxuuo-intcerr)
  (uuo_intcerr ppc::error-object-not-real object)
  (b :again)
  :got-it)

(define-vinsn require-number (()
                              ((object :lisp))
                              ((crf0 (:crf 0))
                               (tag :u8)))
  :again
  (clrlwi. tag object (- ppc::nbits-in-word ppc::nlisptagbits))
  (beq crf0 :got-it)
  (cmpwi crf0 tag ppc::tag-misc)
  (bne crf0 :no-got)
  (lbz tag ppc::misc-subtag-offset object)
  (cmplwi crf0 tag ppc::max-numeric-subtag)
  (ble crf0 :got-it)
  :no-got
  (bla .SPxuuo-intcerr)
  (uuo_intcerr ppc::error-object-not-number object)
  (b :again)
  :got-it)


(define-vinsn require-list (()
                            ((object :lisp))
                            ((tag :u8)
                             (crf :crf)))
  :again
  (clrlwi tag object (- ppc::nbits-in-word ppc::nlisptagbits))
  (cmpwi crf tag ppc::tag-list)
  (beq crf :got-it)
  (bla .SPxuuo-intcerr)
  (uuo_intcerr ppc::error-object-not-list object)
  (b :again)
  :got-it)

(define-vinsn require-symbol (()
                              ((object :lisp))
                              ((tag :u8)
                               (crf :crf)))
  :again
  (cmpw crf object ppc::rnil)
  (clrlwi tag object (- ppc::nbits-in-word ppc::nlisptagbits))
  (beq crf :got-it)
  (cmpwi crf tag ppc::tag-misc)
  (bne crf :no-got)
  (lbz tag ppc::misc-subtag-offset object)
  (cmpwi crf tag ppc::subtag-symbol)
  (beq crf :got-it)
  :no-got
  (bla .SPxuuo-intcerr)
  (uuo_intcerr ppc::error-object-not-symbol object)
  (b :again)
  :got-it)

(define-vinsn require-character (()
                                 ((object :lisp))
                                 ((tag :u8)
                                  (crf :crf)))
  :again
  (clrlwi tag object (- ppc::nbits-in-word ppc::num-subtag-bits))
  (cmpwi crf tag ppc::subtag-character)
  (beq crf :got-it)
  (bla .SPxuuo-intcerr)
  (uuo_intcerr ppc::error-object-not-character object)
  (b :again)
  :got-it)


(define-vinsn require-u16 (()
                           ((object :lisp))
                            ((crf0 (:crf 0))
                             (tag :u32)))
  :again
  ; The bottom ppc::fixnumshift bits and the top (- 32 (+ ppc::fixnumshift 16)) must all be zero.
  (rlwinm. tag object 0 (- ppc::nbits-in-word ppc::fixnumshift) (- ppc::least-significant-bit (+ ppc::fixnumshift 16)))
  (beq crf0 :got-it)
  (bla .SPxuuo-intcerr)
  (uuo_intcerr ppc::error-object-not-unsigned-byte-16 object)
  (b :again)
  :got-it)

(define-vinsn box-fixnum (((dest :imm))
                          ((src :s32)))
  (slwi dest src ppc::fixnumshift))

(define-vinsn fixnum->s32 (((dest :s32))
                           ((src :imm)))
  (srawi dest src ppc::fixnumshift))

(define-vinsn fixnum->u32 (((dest :u32))
                           ((src :imm)))
  (srwi dest src ppc::fixnumshift))

; An object is of type (UNSIGNED-BYTE 32) iff
;  a) it's of type (UNSIGNED-BYTE 30) (e.g., an unsigned fixnum)
;  b) it's a bignum of length 1 and the 0'th digit is positive
;  c) it's a bignum of length 2 and the sign-digit is 0.

(define-vinsn unbox-u32 (((dest :u32))
                         ((src :lisp))
                         ((crf0 (:crf 0))
                          (header :u32)))
  ; The bottom ppc::fixnumshift bits and the top bit must all be zero.
  (rlwinm. dest src 0 (- ppc::nbits-in-word ppc::fixnumshift) 0)
  (srwi dest src ppc::fixnumshift)
  (beq crf0 :got-it)
  (clrlwi dest src (- ppc::nbits-in-word ppc::nlisptagbits))
  (cmpwi crf0 dest ppc::tag-misc)
  (bne crf0 :bad)
  (lwz header ppc::misc-header-offset src)
  (lwz dest ppc::misc-data-offset src)
  (cmpwi crf0 header (logior (ash 1 ppc::num-subtag-bits) ppc::subtag-bignum))
  (bne crf0 :maybe-two)
  (cmpwi crf0 dest 0)
  (bgt crf0 :got-it)
  :bad
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-unsigned-byte-32 src)
  :maybe-two
  (cmpwi crf0 header (logior (ash 2 ppc::num-subtag-bits) ppc::subtag-bignum))
  (bne crf0 :bad)
  (lwz header (+ ppc::misc-data-offset 4) src)
  (cmpwi crf0 header 0)
  (bne crf0 :bad)
  :got-it)

; an object is of type (SIGNED-BYTE 16) iff
; a) it's a fixnum
; b) it's a bignum with exactly one digit.

(define-vinsn unbox-s32 (((dest :s32))
                         ((src :lisp))
                         ((crfx :crf)
                          (crfy :crf)
                          (tag :u32)))
  (clrlwi tag src (- ppc::nbits-in-word ppc::nlisptagbits))
  (cmpwi crfx tag ppc::tag-fixnum)
  (cmpwi crfy tag ppc::tag-misc)
  (srawi dest src ppc::fixnumshift)
  (beq crfx :got-it)
  (bne crfy :bad)
  (lwz tag ppc::misc-header-offset src)
  (cmpwi crfx tag (logior (ash 1 ppc::num-subtag-bits) ppc::subtag-bignum))
  (lwz dest ppc::misc-data-offset src)
  (beq crfx :got-it)
  :bad
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-signed-byte-32 src)
  :got-it)

; For the sake of argument, "dest" is u32.
; Return dest if src is either (signed-byte 32) or (unsigned-byte 32).
; Say that it's not (signed-byte 32) if neither.
(define-vinsn unbox-x32 (((dest :u32))
                         ((src :lisp))
                         ((crfx :crf)
                          (crfy :crf)
                          (tag :u32)))
  (clrlwi tag src (- ppc::nbits-in-word ppc::nlisptagbits))
  (cmpwi crfx tag ppc::tag-fixnum)
  (cmpwi crfy tag ppc::tag-misc)
  (srawi dest src ppc::fixnumshift)
  (beq crfx :got-it)
  (bne crfy :bad)
  (lwz tag ppc::misc-header-offset src)
  (cmpwi crfx tag (logior (ash 1 ppc::num-subtag-bits) ppc::subtag-bignum))
  (cmpwi crfy tag (logior (ash 2 ppc::num-subtag-bits) ppc::subtag-bignum))
  (lwz dest ppc::misc-data-offset src)
  (beq crfx :got-it)
  (lwz tag (+ 4 ppc::misc-data-offset) src)
  (cmpwi crfx tag 0)
  (bne crfy :bad)
  (beq crfx :got-it)
  :bad
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-signed-byte-32 src)
  :got-it)

(define-vinsn unbox-u16 (((dest :u16))
                         ((src :lisp))
                         ((crf0 (:crf 0))))
  ; The bottom ppc::fixnumshift bits and the top (- 31 (+ ppc::fixnumshift 16)) must all be zero.
  (rlwinm. dest src 0 (- ppc::nbits-in-word ppc::fixnumshift) (- ppc::least-significant-bit (+ ppc::fixnumshift 16)))
  (rlwinm dest src (- 32 ppc::fixnumshift) 16 31)
  (beq crf0 :got-it)
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-unsigned-byte-16 src)
  :got-it)

(define-vinsn unbox-s16 (((dest :s16))
                         ((src :lisp))
                         ((crf :crf)))
  (slwi dest src (- 16 ppc::fixnumshift))
  (srawi dest dest (- 16 ppc::fixnumshift))
  (cmpw crf dest src)
  (clrlwi dest src (- ppc::nbits-in-word ppc::nlisptagbits))
  (bne crf :bad)
  (cmpwi crf dest ppc::tag-fixnum)
  (srawi dest src ppc::fixnumshift)
  (beq crf :got-it)
  :bad
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-signed-byte-16 src)
  :got-it)

  
  
(define-vinsn unbox-u8 (((dest :u8))
                         ((src :lisp))
                         ((crf0 (:crf 0))))
  ; The bottom ppc::fixnumshift bits and the top (- 31 (+ ppc::fixnumshift 8)) must all be zero.
  (rlwinm. dest src 0 (- ppc::nbits-in-word ppc::fixnumshift) (- ppc::least-significant-bit (+ ppc::fixnumshift 8)))
  (rlwinm dest src (- 32 ppc::fixnumshift) 24 31)
  (beq crf0 :got-it)
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-unsigned-byte-8 src)
  :got-it)

(define-vinsn unbox-s8 (((dest :s8))
                         ((src :lisp))
                         ((crf :crf)))
  (slwi dest src (- ppc::nbits-in-word (+ 8 ppc::fixnumshift)))
  (srawi dest dest (- ppc::nbits-in-word (+ 8 ppc::fixnumshift)))
  (cmpw crf dest src)
  (clrlwi dest src (- ppc::nbits-in-word ppc::nlisptagbits))
  (bne crf :bad)
  (cmpwi crf dest ppc::tag-fixnum)
  (srawi dest src ppc::fixnumshift)
  (beq crf :got-it)
  :bad
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-signed-byte-16 src)
  :got-it)

(define-vinsn unbox-base-character (((dest :u32))
                                    ((src :lisp))
                                    ((crf :crf)))
  (rlwinm dest src 8 16 31)
  (cmpwi crf dest (ash ppc::subtag-character 8))
  (srwi dest src ppc::charcode-shift)
  (beq crf :got-it)
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-base-character src)
  :got-it)

(define-vinsn unbox-character (((dest :u32))
                               ((src :lisp))
                               ((crf :crf)))
  (clrlwi dest src 24)
  (cmpwi crf dest ppc::subtag-character)
  (srwi dest src ppc::charcode-shift)
  (beq crf :got-it)
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-character src)
  :got-it)

(define-vinsn unbox-bit (((dest :u32))
                         ((src :lisp))
                         ((crf :crf)))
  (cmplwi crf src (ash 1 ppc::fixnumshift))
  (srawi dest src ppc::fixnumshift)
  (ble crf :got-it)
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-bit src)
  :got-it)

(define-vinsn unbox-bit-bit0 (((dest :u32))
                              ((src :lisp))
                              ((crf :crf)))
  (cmplwi crf src (ash 1 ppc::fixnumshift))
  (rlwinm dest src (- 32 (1+ ppc::fixnumshift)) 0 0)
  (ble crf :got-it)
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-bit src)
  :got-it)

(define-vinsn fixnum->fpr (((dest :double-float))
                           ((src :lisp))
                           ((imm :s32)))
  (stfd ppc::fp-s32conv -8 ppc::sp)
  (srawi imm src ppc::fixnumshift)
  (xoris imm imm #x8000)
  (stw imm -4 ppc::sp)
  (lfd dest -8 ppc::sp)
  (fsub dest dest ppc::fp-s32conv))


(define-vinsn shift-right-variable-word (((dest :u32))
                                         ((src :u32)
                                          (sh :u32)))
  (srw dest src sh))

(define-vinsn u32logandc2 (((dest :u32))
                           ((x :u32)
                            (y :u32)))
  (andc dest x y))

(define-vinsn u32logior (((dest :u32))
                         ((x :u32)
                          (y :u32)))
  (or dest x y))

(define-vinsn rotate-left-variable-word (((dest :u32))
                                         ((src :u32)
                                          (rot :u32)))
  (rlwnm dest src rot 0 31))

(define-vinsn complement-shift-count (((dest :u32))
                                      ((src :u32)))
  (subfic dest src 32))

(define-vinsn extract-lowbyte (((dest :u32))
                               ((src :lisp)))
  (clrlwi dest src (- ppc::nbits-in-word ppc::num-subtag-bits)))

; Set DEST to the difference between the low byte of SRC and BYTEVAL.
(define-vinsn extract-compare-lowbyte (((dest :u32))
                                       ((src :lisp)
                                        (byteval :u8const)))
  (clrlwi dest src (- ppc::nbits-in-word ppc::num-subtag-bits))
  (subi dest dest byteval))


; Set the "EQ" bit in condition-register field CRF if object is
; a fixnum.  Leave the object's tag in TAG.
; This is a little easier if CRF is CR0.
(define-vinsn eq-if-fixnum (((crf :crf)
                             (tag :u8))
                            ((object :lisp))
                            ())
  ((:eq crf 0)
   (clrlwi. tag object (- ppc::nbits-in-word ppc::nlisptagbits)))
  ((:not (:eq crf 0))
   (clrlwi tag object (- ppc::nbits-in-word ppc::nlisptagbits))
   (cmpwi crf tag ppc::tag-fixnum)))

(define-vinsn trap-unless-uvector (()
                                  ((object :lisp))
                                  ((crf :crf)
                                   (tag :u8)))
  (clrlwi tag object (- ppc::nbits-in-word ppc::nlisptagbits))
  (cmpwi crf tag ppc::tag-misc)
  (beq crf :ok)
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-uvector object)
  :ok)
  
(define-vinsn trap-unless-list (()
                                  ((object :lisp))
                                  ((crf :crf)
                                   (tag :u8)))
  (clrlwi tag object (- ppc::nbits-in-word ppc::nlisptagbits))
  (cmpwi crf tag ppc::tag-list)
  (beq crf :ok)
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-list object)
  :ok)

(define-vinsn trap-unless-fixnum (()
                                  ((object :lisp))
                                  ((crf (:crf 0))
                                   (tag :u8)))
  (clrlwi. tag object (- ppc::nbits-in-word ppc::nlisptagbits))
  (beq crf :ok)
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-fixnum object)
  :ok)


(define-vinsn trap-unless-cons (()
                                ((object :lisp))
                                ((crf :crf)
                                 (tag :u8)))
  (clrlwi tag object (- ppc::nbits-in-word ppc::ntagbits))
  (cmpwi crf tag ppc::fulltag-cons)
  (beq crf :ok)
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-cons object)
  :ok)


(define-vinsn trap-unless-character (()
                                     ((object :lisp))
                                     ((crf :crf)
                                      (tag :u8)))
  (clrlwi tag object (- ppc::nbits-in-word 8))
  (cmpwi crf tag ppc::subtag-character)
  (beq crf :ok)
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-character object)
  :ok)


(define-vinsn trap-unless-typecode= (()
                                     ((object :lisp)
                                      (tagval :u16const))
                                     ((tag :u8)
                                      (crf :crf)))
  (clrlwi tag object (- ppc::nbits-in-word ppc::nlisptagbits))
  (cmpwi crf tag ppc::tag-misc)
  (bne crf :do-trap)
  (lbz tag ppc::misc-subtag-offset object)
  (cmpwi crf tag tagval)
  (beq crf :ok)
  :do-trap
  (bla .SPxuuo-interr)
  (uuo_interr (:apply logior ppc::error-subtag-error tagval) object)
  :ok)
  
(define-vinsn subtract-constant (((dest :imm))
                                 ((src :imm)
                                  (const :s16const)))
  (subi dest src const))




;; Bit-extraction & boolean operations

(eval-when (:compile-toplevel :execute)
  (assert (= ppc::t-offset #b10001)))         ; PPC-bits 31 and 27 set

;; For some mind-numbing reason, IBM decided to call the most significant
;; bit in a 32-bit word "bit 0" and the least significant bit "bit 31"
;; (this despite the fact that it's essentially a big-endian architecture
;; (it was exclusively big-endian when this decision was made.))
;; We'll probably be least confused if we consistently use this backwards
;; bit ordering (letting things that have a "sane" bit-number worry about
;; it at compile-time or run-time (subtracting the "sane" bit number from
;; 31.))

(define-vinsn extract-variable-bit (((dest :u8))
                                    ((src :u32)
                                     (bitnum :u8))
                                    ())
  (rotlw dest src bitnum)
  (extrwi dest dest 1 0))


(define-vinsn extract-variable-bit[fixnum] (((dest :imm))
                                            ((src :u32)
                                             (bitnum :u8))
                                            ((temp :u32)))
  (rotlw temp src bitnum)
  (rlwinm dest
          temp 
          (1+ ppc::fixnumshift) 
          (- ppc::least-significant-bit ppc::fixnumshift)
          (- ppc::least-significant-bit ppc::fixnumshift)))


;; Sometimes we try to extract a single bit from some source register
;; into a destination bit (typically 31, sometimes fixnum bit 0 = 29).
;; If we copy bit 0 (whoops, I mean "bit 31") to bit 4 (aka 27) in a
;; given register, we get a value that's either 17 (the arithmetic difference
;; between T and NIL) or 0.

(define-vinsn bit31->truth (((dest :lisp)
                             (bits :u32))
                            ((bits :u32))
                            ())
  (rlwimi bits bits (- ppc::least-significant-bit 27) 27 27)    ; bits = 0000...X000X
  (add dest ppc::rnil bits))

(define-vinsn invert-bit31 (((bits :u32))
                            ((bits :u32))
                            ())
  (xori bits bits 1))

                           

;; Some of the obscure-looking instruction sequences - which map some relation
;; to PPC bit 31 of some register - were found by the GNU SuperOptimizer.
;; Some of them use extended-precision instructions (which may cause interlocks
;; on some superscalar PPCs, if I remember correctly.)  In general, sequences
;; that GSO found that -don't- do extended precision are longer and/or use
;; more temporaries.
;; On the 604, the penalty for using an instruction that uses the CA bit is
;; "at least" one cycle: it can't complete execution until all "older" instructions
;; have.  That's not horrible, especially given that the alternative is usually
;; to use more instructions (and, more importantly, more temporaries) to avoid
;; using extended-precision.


(define-vinsn eq0->bit31 (((bits :u32))
                          ((src (t (:ne bits)))))
  (cntlzw bits src)
  (srwi bits bits 5))                  ; bits = 0000...000X

(define-vinsn ne0->bit31 (((bits :u32))
                          ((src (t (:ne bits)))))
  (cntlzw bits src)
  (slw bits src bits)
  (srwi bits bits 31))                ; bits = 0000...000X

(define-vinsn lt0->bit31 (((bits :u32))
                          ((src (t (:ne bits)))))
  (srwi bits src 31))                   ; bits = 0000...000X


(define-vinsn ge0->bit31 (((bits :u32))
                          ((src (t (:ne bits)))))
  (srwi bits src 31)       
  (xori bits bits 1))                   ; bits = 0000...000X


(define-vinsn le0->bit31 (((bits :u32))
                          ((src (t (:ne bits)))))
  (neg bits src)
  (orc bits bits src)
  (srwi bits bits 31))                  ; bits = 0000...000X

(define-vinsn gt0->bit31 (((bits :u32))
                          ((src (t (:ne bits)))))
  (subi bits src 1)       
  (nor bits bits src)
  (srwi bits bits 31))                  ; bits = 0000...000X

(define-vinsn ne->bit31 (((bits :u32))
                         ((x t)
                          (y t))
                         ((temp :u32)))
  (subf temp x y)
  (cntlzw bits temp)
  (slw bits temp bits)
  (srwi bits bits 31))                ; bits = 0000...000X

(define-vinsn fulltag->bit31 (((bits :u32))
                              ((lispobj :lisp)
                               (tagval :u8const))
                              ())
  (clrlwi bits lispobj (- ppc::nbits-in-word ppc::ntagbits))
  (subi bits bits tagval)
  (cntlzw bits bits)
  (srwi bits bits 5))


(define-vinsn eq->bit31 (((bits :u32))
                         ((x t)
                          (y t)))
  (subf bits x y)
  (cntlzw bits bits)
  (srwi bits bits 5))                  ; bits = 0000...000X

(define-vinsn ne->bit31 (((bits :u32))
                         ((x t)
                          (y t)))
  (subf bits x y)
  (cntlzw bits bits)
  (srwi bits bits 5)
  (xori bits bits 1))

(define-vinsn lt->bit31 (((bits :u32))
                         ((x (t (:ne bits)))
                          (y (t (:ne bits)))))

  (xor bits x y)
  (srawi bits bits 31)
  (or bits bits x)
  (subf bits y bits)
  (srwi bits bits 31))              ; bits = 0000...000X

(define-vinsn le->bit31 (((bits :u32))
                         ((x (t (:ne bits)))
                          (y (t (:ne bits)))))

  (xor bits x y)
  (srawi bits bits 31)
  (nor bits bits y)
  (add bits bits x)
  (srwi bits bits 31))              ; bits = 0000...000X


(define-vinsn gt->bit31 (((bits :u32))
                         ((x (t (:ne bits)))
                          (y (t (:ne bits)))))

  (eqv bits x y)
  (srawi bits bits 31)
  (and bits bits x)
  (subf bits bits y)
  (srwi bits bits 31))              ; bits = 0000...000X

(define-vinsn ge->bit31 (((bits :u32))
                         ((x (t (:ne bits)))
                          (y (t (:ne bits)))))
  (eqv bits x y)
  (srawi bits bits 31)
  (andc bits bits x)
  (add bits bits y)
  (srwi bits bits 31))              ; bits = 0000...000X



; there are big-time latencies associated with MFCR on more heavily
; pipelined processors; that implies that we should avoid this like
; the plague.
; GSO can't find anything much quicker for LT or GT, even though
; MFCR takes three cycles and waits for previous instructions to complete.
; Of course, using a CR field costs us something as well.
(define-vinsn crbit->bit31 (((bits :u32))
                            ((crf :crf)
                             (bitnum :crbit))
                            ())
  (mfcr bits)                           ; Suffer.
  (rlwinm bits bits (:apply + 1  bitnum (:apply ash crf 2)) 31 31))    ; bits = 0000...000X


(define-vinsn compare (((crf :crf))
                       ((arg0 t)
                        (arg1 t))
                       ())
  (cmpw crf arg0 arg1))

(define-vinsn double-float-compare (((crf :crf))
                                    ((arg0 :double-float)
                                     (arg1 :double-float))
                                    ())
  (fcmpo crf arg0 arg1))
              

(define-vinsn double-float+-2 (((result :double-float))
                                ((x :double-float)
                                 (y :double-float))
                                ((crf (:crf 4))))
  (fadd. result x y)
  (ble crf :no)
  (bla .SPfpu-exception)
  (fadd. result x y)
  :no)

(define-vinsn double-float--2 (((result :double-float))
                                ((x :double-float)
                                 (y :double-float))
                                ((crf (:crf 4))))
  (fsub. result x y)
  (ble crf :no)
  (bla .SPfpu-exception)
  (fsub. result x y)
  :no)

(define-vinsn double-float*-2 (((result :double-float))
                                ((x :double-float)
                                 (y :double-float))
                                ((crf (:crf 4))))
  (fmul. result x y)
  (ble crf :no)
  (bla .SPfpu-exception)
  (fmul. result x y)
  :no)

(define-vinsn double-float/-2 (((result :double-float))
                                ((x :double-float)
                                 (y :double-float))
                                ((crf (:crf 4))))
  (fdiv. result x y)
  (ble crf :no)
  (bla .SPfpu-exception)
  (fdiv. result x y)
  :no)

(define-vinsn single-float+-2 (((result :single-float))
                                ((x :single-float)
                                 (y :single-float))
                                ((crf (:crf 4))))
  (fadds. result x y)
  (ble crf :no)
  (bla .SPfpu-exception)
  (fadds. result x y)
  :no)

(define-vinsn single-float--2 (((result :single-float))
                               ((x :single-float)
                                (y :single-float))
                               ((crf (:crf 4))))
  (fsubs. result x y)
  (ble crf :no)
  (bla .SPfpu-exception)
  (fsubs. result x y)
  :no)

(define-vinsn single-float*-2 (((result :single-float))
                               ((x :single-float)
                                (y :single-float))
                               ((crf (:crf 4))))
  (fmuls. result x y)
  (ble crf :no)
  (bla .SPfpu-exception)
  (fmuls. result x y)
  :no)

(define-vinsn single-float/-2 (((result :single-float))
                                ((x :single-float)
                                 (y :single-float))
                                ((crf (:crf 4))))
  (fdivs. result x y)
  (ble crf :no)
  (bla .SPfpu-exception)
  (fdivs. result x y)
  :no)

#| ;; put this back if they ever fix OSX re preserving fpr's
(define-vinsn clear-fpu-exceptions (()
                                    ((freg :double-float)))
  (mtfsf #xfc freg))
|#


(define-vinsn clear-fpu-exceptions (()
                                    ((freg :double-float)))
  (lfs freg (ppc::kernel-global short-float-zero) ppc::rnil)
  (mtfsf #xfc freg))


;; There's no easy way to preserve an unboxed float across
;; nthrow, so we have to split it into multiple (boxed) values.
;; We could use 3 fixnum-tagged registers to represent the 64
;; bits, but there's less shifting involved if we use 4 of them.

(define-vinsn double-float->values (()
                                    ((src :double-float))
                                    ((t0 :u32)
                                     (t1 :u32)
                                     (t2 :u32)
                                     (t3 :u32)))
  (stfd src -8 ppc::sp)
  (lwz t0 -8 ppc::sp)
  (lwz t2 -4 ppc::sp)
  (clrlslwi t1 t0 16 ppc::fixnumshift)
  (clrlslwi t3 t2 16 ppc::fixnumshift)
  (clrrwi t0 t0 16)
  (clrrwi t2 t2 16)
  (stwu t3 -4 ppc::vsp)
  (stwu t2 -4 ppc::vsp)
  (stwu t1 -4 ppc::vsp)
  (stwu t0 -4 ppc::vsp)
  (li ppc::nargs (ash 4 ppc::fixnumshift)))

(define-vinsn values->double-float (((dest :double-float))
                                    ()
                                    ((t0 :u32)
                                     (t1 :u32)
                                     (t2 :u32)
                                     (t3 :u32)))
  (lwz t0 0 ppc::vsp)
  (lwz t1 4 ppc::vsp)
  (lwz t2 8 ppc::vsp)
  (lwz t3 12 ppc::vsp)
  (la ppc::vsp 16 ppc::vsp)
  (rlwimi t0 t1 (- 32 ppc::fixnumshift) 16 31)
  (rlwimi t2 t3 (- 32 ppc::fixnumshift) 16 31)
  (stw t2 -4 ppc::sp)
  (stw t1 -8 ppc::sp)
  (lfd dest -8 ppc::sp))



(define-vinsn compare-unsigned (((crf :crf))
                                ((arg0 :imm)
                                 (arg1 :imm))
                                ())
  (cmplw crf arg0 arg1))

(define-vinsn compare-signed-s16const (((crf :crf))
                                       ((arg0 :imm)
                                        (imm :s16const))
                                       ())
  (cmpwi crf arg0 imm))

(define-vinsn compare-unsigned-u16const (((crf :crf))
                                         ((arg0 :imm)
                                          (imm :u16const))
                                         ())
  (cmplwi crf arg0 imm))



;; Extract a constant bit (0-31) from src; make it be bit 31 of dest.
;; Bitnum is treated mod 32.
(define-vinsn extract-constant-ppc-bit (((dest :u32))
                                        ((src :imm)
                                         (bitnum :u16const))
                                        ())
  (rlwinm dest src (:apply + 1 bitnum) 31 31))


(define-vinsn set-constant-ppc-bit-to-variable-value (((dest :u32))
                                                      ((src :u32)
                                                       (bitval :u32)      ; 0 or 1
                                                       (bitnum :u8const)))
  (rlwimi dest bitval (:apply - 31 bitnum) bitnum bitnum))

(define-vinsn set-constant-ppc-bit-to-1 (((dest :u32))
                                         ((src :u32)
                                          (bitnum :u8const)))
  ((:pred < bitnum 16)
   (oris dest src (:apply ash #x8000 (:apply - bitnum))))
  ((:pred >= bitnum 16)
   (ori dest src (:apply ash #x8000 (:apply - (:apply - bitnum 16))))))

(define-vinsn set-constant-ppc-bit-to-0 (((dest :u32))
                                         ((src :u32)
                                          (bitnum :u8const)))
  (rlwinm dest src 0 (:apply logand #x1f (:apply 1+ bitnum)) (:apply logand #x1f (:apply 1- bitnum))))

  
(define-vinsn insert-bit-0 (((dest :u32))
                            ((src :u32)
                             (val :u32)))
  (rlwimi dest val 0 0 0))
  
; The bit number is boxed and wants to think of the least-significant bit as 0.
; Imagine that.
; To turn the boxed, lsb-0 bitnumber into an unboxed, msb-0 rotate count,
; we (conceptually) unbox it, add ppc::fixnumshift to it, subtract it from
; 31, and add one.  This can also be done as "unbox and subtract from 28",
; I think ...
; Actually, it'd be "unbox, then subtract from 30".
(define-vinsn extract-variable-non-insane-bit (((dest :u32))
                                               ((src :imm)
                                                (bit :imm))
                                               ((temp :u32)))
  (srwi temp bit ppc::fixnumshift)
  (subfic temp temp (- 32 ppc::fixnumshift))
  (rlwnm dest src temp 31 31))
                                               
; Operations on lists and cons cells

(define-vinsn %cdr (((dest :lisp))
                    ((src :lisp)))
  (lwz dest ppc::cons.cdr src))

(define-vinsn %car (((dest :lisp))
                    ((src :lisp)))
  (lwz dest ppc::cons.car src))

(define-vinsn %set-car (()
                        ((cell :lisp)
                         (new :lisp)))
  (stw new ppc::cons.car cell))

(define-vinsn (%set-car& :call :subprim-call) (()
                         ((cell :lisp)
                          (new :lisp)))
  (la ppc::loc-g ppc::cons.car cell)
  (stw new 0 ppc::loc-g)
  (bla .SPwrite-barrier))

(define-vinsn %set-cdr (()
                        ((cell :lisp)
                         (new :lisp)))
  (stw new ppc::cons.cdr cell))

(define-vinsn (%set-cdr& :call :subprim-call) (()
                                               ((cell :lisp)
                                                (new :lisp)))
  (la ppc::loc-g ppc::cons.cdr cell)
  (stw new 0 ppc::loc-g)
  (bla .SPwrite-barrier))


(define-vinsn set-nargs (()
                         ((n :s16const)))
  (li ppc::nargs (:apply ash n ppc::word-shift)))

(define-vinsn scale-nargs (()
                           ((nfixed :s16const)))
  ((:pred > nfixed 0)
   (la ppc::nargs (:apply - (:apply ash nfixed ppc::word-shift)) ppc::nargs)))
                           


(define-vinsn (vpush-register :push :node :vsp)
              (()
               ((reg :lisp)))
  (stwu reg -4 ppc::vsp))

(define-vinsn (vpush-register-arg :push :node :vsp :outgoing-argument)
              (()
               ((reg :lisp)))
  (stwu reg -4 ppc::vsp))

(define-vinsn (vpop-register :pop :node :vsp)
              (((dest :lisp))
               ())
  (lwz dest 0 ppc::vsp)
  (la ppc::vsp 4 ppc::vsp))

;; Caller has ensured that source & dest differ.
;; Worse things could happen ...
(define-vinsn copy-node-gpr (((dest :lisp))
                             ((src :lisp)))
  (mr dest src))

(define-vinsn copy-gpr (((dest t))
                        ((src t)))
  (mr dest src))


(define-vinsn copy-fpr (((dest t))
                        ((src t)))
  (fmr dest src))

(define-vinsn vcell-ref (((dest :lisp))
                         ((vcell :lisp)))
  (lwz dest ppc::misc-data-offset vcell))

(define-vinsn vcell-set (()
                         ((vcell :lisp)
                          (value :lisp)))
  (stw value ppc::misc-data-offset vcell))

(define-vinsn (vcell-set& :call :subprim-call) (()
                          ((vcell :lisp)
                           (value :lisp)))
  (la ppc::loc-g ppc::misc-data-offset vcell)
  (stw value 0 ppc::loc-g)
  (bla .SPwrite-barrier))

(define-vinsn make-vcell (((dest :lisp))
                          ((closed :lisp))
                          ((header :u32)
                           (crf6 (:crf 24))))
  (lwz ppc::extra (ppc::kernel-global heap-limit) ppc::rnil)
  (la ppc::freeptr ppc::value-cell.size ppc::freeptr)
  (cmplw crf6 ppc::freeptr ppc::extra)
  (ble crf6 :ok)
  (bla .SPfinish-alloc)
  :ok
  (li header ppc::value-cell-header)
  (stw header 0 ppc::initptr)
  (stw closed 4 ppc::initptr)
  (la dest ppc::fulltag-misc ppc::initptr)
  (mr ppc::initptr ppc::freeptr))

(define-vinsn make-tsp-vcell (((dest :lisp))
                              ((closed :lisp))
                              ((header :u32)))
  (li header ppc::value-cell-header)
  (stwu ppc::tsp -16 ppc::tsp)
  (la ppc::initptr (+ 8 ppc::fulltag-misc) ppc::tsp)
  (stw ppc::rzero 4 ppc::tsp)
  (stw header ppc::value-cell.header ppc::initptr)
  (stw closed ppc::value-cell.value ppc::initptr)
  (mr dest ppc::initptr)
  (mr ppc::initptr ppc::freeptr)
  (bla .SPtscheck))

(define-vinsn make-tsp-cons (((dest :lisp))
                             ((car :lisp) (cdr :lisp))
                             ())
  (stwu ppc::tsp -16 ppc::tsp)
  (la ppc::initptr (+ 8 ppc::fulltag-cons) ppc::tsp)
  (stw ppc::rzero 4 ppc::tsp)
  (stw car ppc::cons.car ppc::initptr)
  (stw cdr ppc::cons.cdr ppc::initptr)
  (mr dest ppc::initptr)
  (mr ppc::initptr ppc::freeptr)
  (bla .SPtscheck))

(define-vinsn make-tsp-DFLOAT (((dest :lisp))
                               ((init :lisp))
                               ((header :u32)))
  (stwu ppc::tsp (- (+ 8 ppc::double-float.size)) ppc::tsp)
  (la ppc::initptr (+ 8 ppc::fulltag-MISC) ppc::tsp)
  (li header ppc::double-float-header)
  (stw header ppc::double-float.header ppc::initptr)
  (stw ppc::rzero 4 ppc::tsp)
  (lfd ppc::fp0 ppc::double-float.value init)
  (stfd ppc::fp0 ppc::double-float.value ppc::initptr)
  (mr dest ppc::initptr)
  (mr ppc::initptr ppc::freeptr)
  (bla .SPtscheck))

(define-vinsn make-tsp-DFLOAT-from-fpr (((dest :lisp))
                               ((init :lisp))
                               ((header :u32)))
  (stwu ppc::tsp (- (+ 8 ppc::double-float.size)) ppc::tsp)
  (la ppc::initptr (+ 8 ppc::fulltag-MISC) ppc::tsp)
  (li header ppc::double-float-header)
  (stw header ppc::double-float.header ppc::initptr)
  (stw ppc::rzero 4 ppc::tsp)
  ;(lfd ppc::fp0 ppc::double-float.value init)
  (stfd init ppc::double-float.value ppc::initptr)
  (mr dest ppc::initptr)
  (mr ppc::initptr ppc::freeptr)
  (bla .SPtscheck))


  

(define-vinsn make-tsp-sFLOAT (((dest :lisp))
                               ((init :lisp))
                               ((header :u32)))
  (stwu ppc::tsp (- (+ 8 ppc::single-float.size)) ppc::tsp)
  (la ppc::initptr (+ 8 ppc::fulltag-MISC) ppc::tsp)
  (li header ppc::single-float-header)
  (stw header ppc::single-float.header ppc::initptr)
  (stw ppc::rzero 4 ppc::tsp)
  (lfs ppc::fp0 ppc::single-float.value init)
  (stfs ppc::fp0 ppc::single-float.value ppc::initptr)
  (mr dest ppc::initptr)
  (mr ppc::initptr ppc::freeptr)
  (bla .SPtscheck))

(define-vinsn make-tsp-sFLOAT-from-fpr (((dest :lisp))
                               ((init :lisp))
                               ((header :u32)))
  (stwu ppc::tsp (- (+ 8 ppc::single-float.size)) ppc::tsp)
  (la ppc::initptr (+ 8 ppc::fulltag-MISC) ppc::tsp)
  (li header ppc::single-float-header)
  (stw header ppc::single-float.header ppc::initptr)
  (stw ppc::rzero 4 ppc::tsp)
  ;(lfs ppc::fp0 ppc::single-float.value init)
  (stfs init ppc::single-float.value ppc::initptr)
  (mr dest ppc::initptr)
  (mr ppc::initptr ppc::freeptr)
  (bla .SPtscheck))




(define-vinsn %closure-code% (((dest :lisp))
                             ())
  (lwz dest (+ ppc::symbol.vcell (ppc::nrs-offset %closure-code%)) ppc::rnil))


(define-vinsn (call-subprim :call :subprim-call) (()
                                                  ((spno :s16const)))
  (bla spno))

(define-vinsn (jump-subprim :jumpLR) (()
                            ((spno :s16const)))
  (ba spno))

; Same as "call-subprim", but gives us a place to 
; track args, results, etc.
(define-vinsn (call-subprim-0 :call :subprim-call) (((dest t))
                                                     ((spno :s16const)))
  (bla spno))

(define-vinsn (call-subprim-1 :call :subprim-call) (((dest t))
                                                    ((spno :s16const)
                                                     (z t)))
  (bla spno))
  
(define-vinsn (call-subprim-2 :call :subprim-call) (((dest t))
                                                    ((spno :s16const)
                                                     (y t)
                                                     (z t)))
  (bla spno))

(define-vinsn (call-subprim-3 :call :subprim-call) (((dest t))
                                                     ((spno :s16const)
                                                      (x t)
                                                      (y t)
                                                      (z t)))
  (bla spno))

(define-vinsn event-poll (()
                          ())
  (bla .SPtrap-intpoll))

                         
; Unconditional (pc-relative) branch
(define-vinsn (jump :jump)
              (()
               ((label :label)))
  (b label))

(define-vinsn (call-label :jump)
              (()
               ((label :label)))
  (bl label))

; just like JUMP, only (implicitly) asserts that the following 
; code is somehow reachable.
(define-vinsn (non-barrier-jump :xref) (()
                                ((label :label)))
  (b label))

; Sometimes, the condition is known or easy to express ...

(define-vinsn (blt :branch)
              (()
               ((crf :crf)
                (label :label)))
  (blt crf label))

(define-vinsn (bnl :branch)
              (()
               ((crf :crf)
                (label :label)))
  (bnl crf label))

(define-vinsn (bgt :branch)
              (()
               ((crf :crf)
                (label :label)))
  (bgt crf label))

(define-vinsn (bng :branch)
              (()
               ((crf :crf)
                (label :label)))
  (bng crf label))

(define-vinsn (beq :branch)
              (()
               ((crf :crf)
                (label :label)))
  (beq crf label))

(define-vinsn (bne :branch)
              (()
               ((crf :crf)
                (label :label)))
  (bne crf label))

; Most of the time, it isn't.

(define-vinsn (branch-true :branch)
              (()
               ((crf :crf)
                (crbit :u8const)
                (label :label)))
  (bt (:apply + crf crbit) label))

(define-vinsn (branch-false :branch)
              (()
               ((crf :crf)
                (crbit :u8const)
                (label :label)))
  (bf (:apply + crf crbit) label))


(define-vinsn check-trap-error (()
                                ())
  (beq 0 :no-error)
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-reg-regnum ppc::arg_z)
  :no-error)

; We don't have much control over section alignment, so we
; can't depend on bits that may differ between T and NIL.
(define-vinsn invert-boolean (((dest :lisp))
                              ((src :lisp))
                              ((diff :u32)))
  (subf diff ppc::rnil src)
  (subfic diff diff ppc::t-offset)
  (add dest ppc::rnil diff))
                              

(define-vinsn lisp-word-ref (((dest :lisp))
                             ((base :imm)
                              (offset :imm)))
  (lwzx dest base offset))

(define-vinsn lisp-word-ref-c (((dest :lisp))
                               ((base :imm)
                                (offset :s16const)))
  (lwz dest offset base))

  

;; Load an unsigned, 32-bit constant into a destination register.
(define-vinsn lwi (((dest :imm))
                   ((intval :u32const))
                   ())
  ((:or (:pred = (:apply ash intval -15) #x1ffff)
        (:pred = (:apply ash intval -15) #x0))
   (li dest (:apply %word-to-int (:apply logand #xffff intval))))
  ((:not                                ; that's :else to you, bub.
    (:or (:pred = (:apply ash intval -15) #x1ffff)
        (:pred = (:apply ash intval -15) #x0)))
   ((:pred = (:apply ash intval -15) 1)
    (ori dest ppc::rzero (:apply logand intval #xffff)))
   ((:not (:pred = (:apply ash intval -15) 1))
    (lis dest (:apply ash intval -16))
    ((:not (:pred = 0 (:apply logand intval #xffff)))
     (ori dest dest (:apply logand intval #xffff))))))

; Exactly the same thing, but take a signed integer value
(define-vinsn lwi-s32 (((dest :imm))
                       ((intval :s32const))
                       ())
  ((:or (:pred = (:apply ash intval -15) -1)
        (:pred = (:apply ash intval -15) #x0))
   (li dest (:apply %word-to-int (:apply logand #xffff intval))))
  ((:not                                ; that's :else to you, bub.
    (:or (:pred = (:apply ash intval -15) -1)
        (:pred = (:apply ash intval -15) #x0)))
   ((:pred = (:apply ash intval -15) 1)
    (ori dest ppc::rzero (:apply logand intval #xffff)))
   ((:not (:pred = (:apply ash intval -15) 1))
    (lis dest (:apply ash intval -16))
    ((:not (:pred = 0 (:apply logand intval #xffff)))
     (ori dest dest (:apply logand intval #xffff))))))

(define-vinsn discard-temp-frame (()
                                  ())
  (lwz ppc::tsp 0 ppc::tsp))

(define-vinsn alloc-c-frame (()
                             ((n-c-args :u16const)))
  ; Always reserve space for at least 8 args and space for a lisp
  ; frame (for the kernel) underneath it.
  ; Do a stack-probe ...  Or maybe not
  ;(lwz ppc::nargs (ppc::kernel-global cs-overflow-limit) ppc::rnil)
  ;(twllt ppc::sp ppc::nargs)
  ; Zero the c-frame's savelr field, not that the GC cares ..
  ((:pred <= n-c-args 8)
   ;; round up to multiple 16 bytes
   (stwu ppc::sp (- (logand (+ ppc::c-frame.size ppc::lisp-frame.size 15) (lognot 15))) ppc::sp))
  ((:pred > n-c-args 8)
   ; A normal C frame has room for 8 args. Add enough double words to accomodate the remaining args
   (stwu ppc::sp (:apply - (:apply logand                                   
                                   (:apply + 
                                           (+ ppc::c-frame.size ppc::lisp-frame.size)
                                           (:apply ash
                                                   (:apply logand
                                                           (lognot 1)
                                                           (:apply
                                                            1+
                                                            (:apply - n-c-args 8)))
                                                   2)
                                           15)
                                   (lognot 15)))
                                           
         ppc::sp))
  (stw ppc::rzero ppc::c-frame.savelr ppc::sp))

; We should rarely have to do this.  It's easier to just generate code
; to do the memory reference than it would be to keep track of the size
; of each frame.
(define-vinsn discard-c-frame (()
                               ())
  (lwz ppc::sp 0 ppc::sp))

(define-vinsn set-c-arg (()
                         ((argval :u32)
                          (argnum :u16const)))
  (stw argval (:apply + ppc::c-frame.param0 (:apply ash argnum ppc::word-shift)) ppc::sp))

(define-vinsn set-single-c-arg (()
                                ((argval :single-float)
                                 (argnum :u16const)))
  (stfs argval (:apply + ppc::c-frame.param0 (:apply ash argnum ppc::word-shift)) ppc::sp))

(define-vinsn set-double-c-arg (()
                                ((argval :double-float)
                                 (argnum :u16const)))
  (stfd argval (:apply + ppc::c-frame.param0 (:apply ash argnum ppc::word-shift)) ppc::sp))

(define-vinsn reload-single-c-arg (((argval :single-float))
                                   ((argnum :u16const)))
  (lfs argval (:apply + ppc::c-frame.param0 (:apply ash argnum ppc::word-shift)) ppc::sp))

(define-vinsn reload-double-c-arg (((argval :double-float))
                                   ((argnum :u16const)))
  (lfd argval (:apply + ppc::c-frame.param0 (:apply ash argnum ppc::word-shift)) ppc::sp))

(define-vinsn load-nil (((dest :lisp))
                        ())
  (mr dest ppc::rnil))

(define-vinsn load-t (((dest :lisp))
                      ())
  (la dest ppc::t-offset ppc::rnil))

(define-vinsn ref-constant (((dest :lisp))
                            ((src :s16const)))
  (lwz dest (:apply + ppc::misc-data-offset (:apply ash (:apply 1+ src) 2)) ppc::fn))

(define-vinsn ref-indexed-constant (((dest :lisp))
                                    ((idxreg :s32)))
  (lwzx dest ppc::fn idxreg))


(define-vinsn cons (((dest :lisp))
                    ((newcar :lisp)
                     (newcdr :lisp))
                    ((crf6 (:crf 24))))
  (lwz ppc::extra (ppc::kernel-global heap-limit) ppc::rnil)
  (la ppc::freeptr ppc::cons.size ppc::freeptr)
  (cmplw crf6 ppc::freeptr ppc::extra)
  (ble crf6 :ok)
  (bla .SPfinish-alloc)
  :ok
  (stw newcdr (+ ppc::fulltag-cons ppc::cons.cdr) ppc::initptr)
  (stw newcar (+ ppc::fulltag-cons ppc::cons.car) ppc::initptr)
  (la dest ppc::fulltag-cons ppc::initptr)
  (mr ppc::initptr ppc::freeptr))



;; subtag had better be a PPC-NODE-SUBTAG of some sort!
(define-vinsn %ppc-new-gvector (((dest :lisp))
                                ((Rheader :u32) 
                                 (nbytes :u32const))
                                ((immtemp0 :u32)                   
                                 (nodetemp :lisp)
                                 (crf (:crf 24))))
  (lwz ppc::extra (ppc::kernel-global heap-limit) ppc::rnil)
  (la ppc::freeptr (:apply logand (lognot 7) (:apply + (+ 7 4) nbytes)) ppc::freeptr)
  (cmplw crf ppc::freeptr ppc::extra)
  (ble crf :ok)
  (bla .SPfinish-alloc)
  :ok
  (stw Rheader 0 ppc::initptr)
  (la dest ppc::fulltag-misc ppc::initptr)
  ((:not (:pred = nbytes 0))
   (la ppc::initptr (:apply + ppc::misc-data-offset nbytes) dest)
   (li immtemp0 (:apply ash nbytes (- ppc::word-shift)))
   :loop
   (subi immtemp0 immtemp0 1)
   (cmpwi crf immtemp0 0)
   (lwz nodetemp 0 ppc::vsp)
   (la ppc::vsp 4 ppc::vsp)
   (stwu nodetemp -4 ppc::initptr)
   (bne crf :loop))
  (mr ppc::initptr ppc::freeptr))

;; allocate a small (phys size <= 32K bytes) misc obj of known size/subtag
(define-vinsn %new-alloc-misc-fixed (((dest :lisp))
                                     ((Rheader :u32) (nbytes :u32const))
                                     ((crf6 (:crf 24))))
  (lwz ppc::extra (ppc::kernel-global heap-limit) ppc::rnil)
  (la ppc::freeptr (:apply logand (lognot 7) (:apply + (+ 7 4) nbytes)) ppc::freeptr)
  (cmplw crf6 ppc::freeptr ppc::extra)
  (ble crf6 :ok)
  (bla .SPfinish-alloc)
  :ok
  (stw Rheader 0 ppc::initptr)
  (la dest ppc::fulltag-misc ppc::initptr)
  (mr ppc::initptr ppc::freeptr))

(define-vinsn vstack-discard (()
                              ((nwords :u32const)))
  ((:not (:pred = nwords 0))
   (la ppc::vsp (:apply ash nwords ppc::word-shift) ppc::vsp)))


(define-vinsn lcell-load (((dest :lisp))
                          ((cell :lcell)
                           (top :lcell)))
  (lwz dest (:apply - 
                    (:apply - (:apply calc-lcell-depth top) 4)
                    (:apply calc-lcell-offset cell)) ppc::vsp))

(define-vinsn vframe-load (((dest :lisp))
                           ((frame-offset :u16const)
                            (cur-vsp :u16const)))
  (lwz dest (:apply - (:apply - cur-vsp 4) frame-offset) ppc::vsp))

(define-vinsn lcell-store (()
                          ((src :lisp)
                           (cell :lcell)
                           (top :lcell)))
  (stw src (:apply - 
                   (:apply - (:apply calc-lcell-depth top) 4)
                   (:apply calc-lcell-offset cell)) ppc::vsp))

(define-vinsn vframe-store (()
                            ((src :lisp)
                             (frame-offset :u16const)
                             (cur-vsp :u16const)))
  (stw src (:apply - (:apply - cur-vsp 4) frame-offset) ppc::vsp))

(define-vinsn load-vframe-address (((dest :imm))
                                   ((offset :s16const)))
  (la dest offset ppc::vsp))

(define-vinsn copy-lexpr-argument (()
                                   ()
                                   ((temp :lisp)))
  (lwzx temp ppc::vsp ppc::nargs)
  (stwu temp -4 ppc::vsp))

; Boxing/unboxing of integers.

; Treat the low 8 bits of VAL as an unsigned integer; set RESULT to the equivalent fixnum.
(define-vinsn u8->fixnum (((result :imm)) 
                          ((val :u8)) 
                          ())
  (rlwinm result val ppc::fixnumshift (- ppc::nbits-in-word (+ 8 ppc::fixnumshift)) (- ppc::least-significant-bit ppc::fixnumshift)))

; Treat the low 8 bits of VAL as a signed integer; set RESULT to the equivalent fixnum.
(define-vinsn s8->fixnum (((result :imm)) 
                          ((val :s8)) 
                          ())
  (extlwi result val 8 (- ppc::nbits-in-word 8))
  (srawi result result (- (- ppc::nbits-in-word 8) ppc::fixnumshift)))


; Treat the low 16 bits of VAL as an unsigned integer; set RESULT to the equivalent fixnum.
(define-vinsn u16->fixnum (((result :imm)) 
                           ((val :u16)) 
                           ())
  (rlwinm result val ppc::fixnumshift (- ppc::nbits-in-word (+ 16 ppc::fixnumshift)) (- ppc::least-significant-bit ppc::fixnumshift)))

; Treat the low 16 bits of VAL as a signed integer; set RESULT to the equivalent fixnum.
(define-vinsn s16->fixnum (((result :imm)) 
                           ((val :s16)) 
                           ())
  (extlwi result val 16 (- ppc::nbits-in-word 16))
  (srawi result result (- (- ppc::nbits-in-word 16) ppc::fixnumshift)))

(define-vinsn fixnum->s16 (((result :s16))
                           ((src :imm)))
  (srawi result src ppc::fixnumshift))

; A signed 32-bit untagged value can be at worst a 1-digit bignum.
; There should be something very much like this that takes a stack-consed
; bignum result ...

(define-vinsn s32->integer (((result :lisp))
                            ((src :s32))
                            ((crf (:crf 0))     ; a casualty
                             (crf6 (:crf 24))
                             (temp :s32)))
  (mtxer ppc::rzero) ;(mcrxr 0) could insist that XER[ov,so] and CR0[so] are always 0
  (addo temp src src)
  (addo. result temp temp)
  (bns+ :done)
  (lwz ppc::extra (ppc::kernel-global heap-limit) ppc::rnil)
  (la ppc::freeptr (+ 4 4) ppc::freeptr)
  (cmplw crf6 ppc::freeptr ppc::extra)
  (ble crf6 :ok)
  (bla .SPfinish-alloc)
  :ok
  (li temp ppc::one-digit-bignum-header)
  (la result ppc::fulltag-misc ppc::initptr)
  (stw temp ppc::one-digit-bignum.header result)
  (stw src ppc::one-digit-bignum.value result)
  (mr ppc::initptr ppc::freeptr)
  :done)

;;; An unsigned 32-bit untagged value can be either a 1 or a 2-digit bignum.

(define-vinsn u32->integer (((result :lisp))
                            ((src :u32))
                            ((crf (:crf 0))     ; a casualty
                             (crf6 (:crf 24))
                             (crf1 :crf)
                             (temp :s32)))
  (clrrwi. temp src (- ppc::least-significant-bit ppc::nfixnumtagbits))
  (cmpwi crf1 src 0)
  (slwi result src ppc::fixnumshift)
  (beq crf :done)
  (lwz ppc::extra (ppc::kernel-global heap-limit) ppc::rnil)
  (blt crf1 :two)
  ;; Make a one-digit bignum.
  (la ppc::freeptr 8 ppc::freeptr)
  (li temp ppc::one-digit-bignum-header)
  (b :common)
  :two
  (la ppc::freeptr 16 ppc::freeptr)
  (li temp ppc::two-digit-bignum-header)
  :common
  (cmplw crf6 ppc::freeptr ppc::extra)
  (ble crf6 :ok)
  (bla .SPfinish-alloc)
  :ok
  (stw temp 0 ppc::initptr)
  (stw src 4 ppc::initptr)
  (la result ppc::fulltag-misc ppc::initptr)
  (mr ppc::initptr ppc::freeptr)
  :done)

(define-vinsn u16->u32 (((dest :u32))
                        ((src :u16)))
  (clrlwi dest src 16))

(define-vinsn u8->u32 (((dest :u32))
                       ((src :u8)))
  (clrlwi dest src 24))


(define-vinsn s16->s32 (((dest :s32))
                        ((src :s16)))
  (extsh dest src))

(define-vinsn s8->s32 (((dest :s32))
                       ((src :s8)))
  (extsb dest src))


; ... of floats ...

; Heap-cons a double-float to store contents of FPREG.  Hope that we don't do
; this blindly.
(define-vinsn double->heap (((result :lisp))    ; tagged as a double-float
                            ((fpreg :double-float)) 
                            ((header-temp :u32)
                             (crf6 (:crf 24))))
  (lwz ppc::extra (ppc::kernel-global heap-limit) ppc::rnil)
  (la ppc::freeptr ppc::double-float.size ppc::freeptr)
  (cmplw crf6 ppc::freeptr ppc::extra)
  (ble crf6 :ok)
  (bla .SPfinish-alloc)
  :ok
  (li header-temp (ppc::make-vheader ppc::double-float.element-count ppc::subtag-double-float))
  (stw header-temp 0 ppc::initptr)
  (la result  ppc::fulltag-misc ppc::initptr)
  (mr ppc::initptr ppc::freeptr)
  (stfd fpreg ppc::double-float.value result))


; This is about as bad as heap-consing a double-float.  (In terms of verbosity).
; Wouldn't kill us to do either/both out-of-line, but need to make visible to
; compiler so unnecessary heap-consing can be elided.
(define-vinsn single->heap (((result :lisp))    ; tagged as a single-float
                            ((fpreg :single-float))
                            ((header-temp :u32)
                             (crf6 (:crf 24))))
  (li header-temp (ppc::make-vheader ppc::single-float.element-count ppc::subtag-single-float))
  (lwz ppc::extra (ppc::kernel-global heap-limit) ppc::rnil)
  (la ppc::freeptr ppc::single-float.size ppc::freeptr)
  (cmplw crf6 ppc::freeptr ppc::extra)
  (ble crf6 :ok)
  (bla .SPfinish-alloc)
  :ok
  (stw header-temp 0 ppc::initptr)
  (la result ppc::fulltag-misc ppc::initptr)
  (mr ppc::initptr ppc::freeptr)
  (stfs fpreg ppc::single-float.value result))


; "dest" is preallocated, presumably on a stack somewhere.
(define-vinsn store-double (()
                            ((dest :lisp)
                             (source :double-float))
                            ())
  (stfd source ppc::double-float.value dest))

(define-vinsn get-double (((target :double-float))
                          ((source :lisp))
                          ())
  (lfd target ppc::double-float.value source))

;;; Extract a double-float value, typechecking in the process.
;;; IWBNI we could simply call the "trap-unless-typecode=" vinsn here,
;;; instead of replicating it ..

(define-vinsn get-double? (((target :double-float))
                           ((source :lisp))
                           ((tag :u8)
                            (crf :crf)))
  (clrlwi tag source (- ppc::nbits-in-word ppc::nlisptagbits))
  (cmpwi crf tag ppc::tag-misc)
  (bne crf :do-trap)
  (lbz tag ppc::misc-subtag-offset source)
  (cmpwi crf tag ppc::subtag-double-float)
  (beq crf :ok)
  :do-trap
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-object-not-double-float source)
  :ok
  (lfd target ppc::double-float.value source))
  

(define-vinsn store-single (()
                            ((dest :lisp)
                             (source :single-float))
                            ())
  (stfs source ppc::single-float.value dest))

(define-vinsn get-single (((target :single-float))
                          ((source :lisp))
                          ())
  (lfs target ppc::single-float.value source))

; ... of characters ...
(define-vinsn charcode->u16 (((dest :u16))
                             ((src :imm))
                             ())
  (srwi dest src ppc::charcode-shift))

(define-vinsn character->fixnum (((dest :lisp))
                                 ((src :lisp))
                                 ())
  (rlwinm dest
          src
          (- ppc::nbits-in-word (- ppc::charcode-shift ppc::fixnumshift))
          (- ppc::nbits-in-word (+ ppc::charcode-shift ppc::fixnumshift)) 
          (- ppc::least-significant-bit ppc::fixnumshift)))

(define-vinsn character->code (((dest :u32))
                               ((src :lisp)))
  (rlwinm dest src ppc::charcode-shift ppc::charcode-shift ppc::least-significant-bit))

(define-vinsn charcode->fixnum (((dest :lisp))
                                ((src :imm))
                                ())
  (rlwinm dest 
          src 
          (+ ppc::charcode-shift ppc::fixnumshift)  
          (- ppc::nbits-in-word (+ ppc::charcode-shift ppc::fixnumshift))  
          (- ppc::least-significant-bit ppc::fixnumshift)))

(define-vinsn fixnum->char (((dest :lisp))
                            ((src :imm))
                            ())
  (rlwinm dest src (- ppc::charcode-shift ppc::fixnumshift) 0 (1- ppc::charcode-shift))
  (addi dest dest ppc::subtag-character))

(define-vinsn u16->char (((dest :lisp))
                         ((src :u16))
                         ())
  (rlwinm dest src ppc::charcode-shift 0 (1- ppc::charcode-shift))
  (addi dest dest ppc::subtag-character))

;; ... Macptrs ...

(define-vinsn deref-macptr (((addr :address))
                            ((src :lisp))
                            ())
  (lwz addr ppc::macptr.address src))

(define-vinsn set-macptr-address (()
                                  ((addr :address)
                                   (src :lisp))
                                  ())
  (stw addr ppc::macptr.address src))


(define-vinsn macptr->heap (((dest :lisp))
                            ((address :address))
                            ((header :u32)
                             (crf6 (:crf 24))))
  (lwz ppc::extra (ppc::kernel-global heap-limit) ppc::rnil)
  (la ppc::freeptr ppc::macptr.size ppc::freeptr)
  (li header (ppc::make-vheader ppc::macptr.element-count ppc::subtag-macptr))
  (cmplw crf6 ppc::freeptr ppc::extra)
  (ble crf6 :ok)
  (bla .SPfinish-alloc)
  :ok
  (stw header 0 ppc::initptr)
  (la dest ppc::fulltag-misc ppc::initptr)
  (stw address ppc::macptr.address dest)
  (mr ppc::initptr ppc::freeptr))

(define-vinsn macptr->stack (((dest :lisp))
                             ((address :address))
                             ((header :u32)))
  (li header ppc::macptr-header)
  (stwu ppc::tsp (- (+ 8 ppc::macptr.size)) ppc::tsp)
  (la ppc::initptr (+ 8 ppc::fulltag-misc) ppc::tsp)
  (stw ppc::rzero 4 ppc::tsp)
  (stw header ppc::macptr.header ppc::initptr)
  (stw address ppc::macptr.address ppc::initptr)
  (mr dest ppc::initptr)
  (mr ppc::initptr ppc::freeptr)
  (bla .SPtscheck))

  
(define-vinsn adjust-stack-register (()
                                     ((reg t)
                                      (amount :s16const)))
  (la reg amount reg))

;; Arithmetic on fixnums & unboxed numbers

(define-vinsn u32-lognot (((dest :u32))
                          ((src :u32))
                          ())
  (not dest src))

(define-vinsn fixnum-lognot (((dest :imm))
                             ((src :imm))
                             ((temp :u32)))
  (not temp src)
  (clrrwi dest temp ppc::nfixnumtagbits))

;; beware dest = src
;; is this worth the trouble for one case (- most-negative-fixnum)
;; but it is 600X faster in that case
(define-vinsn (negate-fixnum :call :subprim-call)
    (((dest :lisp))
     ((src :imm))
     ((crf0 (:crf 0))))
  (mtxer ppc::rzero)                    ;(mcrxr crf0)
  (nego. dest src)
  (bns+ :no-overflow)
  ((:pred /= (:apply ppc::%hard-regspec-value dest) ppc::arg_z)
   (mr ppc::arg_z dest))
  (bla .SPfixnum-overflow)
  ((:pred /= (:apply ppc::%hard-regspec-value dest) ppc::arg_z)
   (mr dest ppc::arg_z))  
  :no-overflow)
  
(define-vinsn negate-fixnum-no-ovf (((dest :lisp))
                                    ((src :imm)))
  
  (neg dest src))
  

(define-vinsn logior-high (((dest :imm))
                           ((src :imm)
                            (high :u16const)))
  (oris dest src high))

(define-vinsn logior-low (((dest :imm))
                           ((src :imm)
                            (low :u16const)))
  (ori dest src low))

                           
                           
(define-vinsn %logior2 (((dest :imm))
                        ((x :imm)
                         (y :imm))
                        ())
  (or dest x y))

(define-vinsn logand-high (((dest :imm))
                           ((src :imm)
                            (high :u16const))
                           ((crf0 (:crf 0))))
  (andis. dest src high))

(define-vinsn logand-low (((dest :imm))
                           ((src :imm)
                            (low :u16const))
                           ((crf0 (:crf 0))))
  (andi. dest src low))


(define-vinsn %logand2 (((dest :imm))
                        ((x :imm)
                         (y :imm))
                        ())
  (and dest x y))

(define-vinsn logxor-high (((dest :imm))
                           ((src :imm)
                            (high :u16const)))
  (xoris dest src high))

(define-vinsn logxor-low (((dest :imm))
                           ((src :imm)
                            (low :u16const)))
  (xori dest src low))

                           

(define-vinsn %logxor2 (((dest :imm))
                        ((x :imm)
                         (y :imm))
                        ())
  (xor dest x y))

(define-vinsn %ilsl (((dest :imm))
                     ((count :imm)
                      (src :imm))
                     ((temp :u32)
                      (crx :crf)))
  (cmpwi crx count (ash 31 ppc::fixnumshift))
  (srwi temp count ppc::fixnumshift)
  (slw dest src temp)
  (ble crx :foo)
  (li dest 0)
  :foo)

#|
;; src is fixnum, res is fixnum, if count is pos go left, else go right
(define-vinsn %fixnum-shift-left-right (((dest :lisp))
                     ((src :lisp)
                      (count :lisp))
                     ((temp :u32)
                      (crx :crf)))
  (cmpwi crx count 0)
  (srawi temp count ppc::fixnumshift)  
  (bge crx :foo)
  (neg temp temp)
  (sraw temp src temp)  
  (b :done)
  :foo (slw temp src temp)
  :done
  (clrrwi dest temp ppc::fixnumshift))
|#


(define-vinsn %fixnum-shift-left-right (((dest :lisp))
                     ((src :lisp)
                      (count :lisp))
                     ((temp :u32)
                      
                      (crx :crf)))
  (srawi. temp count ppc::fixnumshift)
  (bge  :left) 
  (neg temp temp)
  (sraw temp src temp)
  (clrrwi dest temp ppc::nfixnumtagbits)
  (b :done)
  :left (slw dest src temp)
  :done
  )

  
  

(define-vinsn %ilsl-c (((dest :imm))
                       ((count :u8const)
                        (src :imm)))
  ; Hard to use ppcmacroinstructions that expand into expressions involving variables.
  (rlwinm dest src count 0 (:apply - ppc::least-significant-bit count)))


(define-vinsn %ilsr-c (((dest :imm))
                       ((count :u8const)
                        (src :imm)))
  (rlwinm dest src (:apply - ppc::nbits-in-word count) count (- ppc::least-significant-bit
                                                                ppc::fixnumshift)))



; 68k did the right thing for counts < 64 - fixnumshift but not if greater
; so load-byte fails in 3.0 also


(define-vinsn %iasr (((dest :imm))
                     ((count :imm)
                      (src :imm))
                     ((temp :s32)
                      (crx :crf)))
  (cmpwi crx count (ash 31 ppc::fixnumshift))
  (srawi temp count ppc::fixnumshift)
  (sraw temp src temp)
  (ble crx :foo)
  (srawi temp src 31)
  :foo
  (clrrwi dest temp ppc::fixnumshift))

(define-vinsn %iasr-c (((dest :imm))
                       ((count :u8const)
                        (src :imm))
                       ((temp :s32)))
  (srawi temp src count)
  (clrrwi dest temp ppc::fixnumshift))

(define-vinsn %ilsr (((dest :imm))
                     ((count :imm)
                      (src :imm))
                     ((temp :s32)
                      (crx :crf)))
  (cmpwi crx count (ash 31 ppc::fixnumshift))
  (srwi temp count ppc::fixnumshift)
  (srw temp src temp)
  (clrrwi dest temp ppc::fixnumshift)
  (ble crx :foo)
  (li dest 0)
  :foo  
  )

(define-vinsn %ilsr-c (((dest :imm))
                       ((count :u8const)
                        (src :imm))
                       ((temp :s32)))
  (rlwinm temp src (:apply - 32 count) count 31)
  (clrrwi dest temp ppc::fixnumshift))


(define-vinsn sign-extend-halfword (((dest :imm))
                                    ((src :imm)))
  (slwi dest src (- 16 ppc::fixnumshift))
  (srawi dest dest (- 16 ppc::fixnumshift)))

(define-vinsn s32-highword (((dest :imm))
                            ((src :s32))
                            ((temp :s32)))
  (srawi temp src 16)
  (slwi dest temp ppc::fixnumshift))

                            

(define-vinsn fixnum-add (((dest t))
                          ((x t)
                           (y t)))
  (add dest x y))

#|
(define-vinsn fixnum-add-overflow (((dest :imm))
                                   ((x :imm)
                                    (y :imm))
                                   ((cr0 (:crf 0))))
  (mtxer ppc::rzero) ;(mcrxr 0)
  (addo. dest x y)
  (bns+ cr0 :no-overflow)
  (uuo_fixnum_overflow dest dest)
:no-overflow)
|#

(define-vinsn fixnum-add-overflow (((dest :imm))
                                   ((x :imm)
                                    (y :imm))
                                   ((cr0 (:crf 0))))
  (mtxer ppc::rzero) ;(mcrxr 0)
  (addo. dest x y)
  (bns+ cr0 :no-overflow)
  (stwu ppc::rzero ppc::one-digit-bignum.size ppc::freeptr)
  (srawi dest dest ppc::fixnumshift)
  (xoris dest dest (ash ppc::fixnummask (- 16 ppc::nfixnumtagbits))) ;; aka #xc000
  (stw dest 4 ppc::initptr)
  (li dest ppc::one-digit-bignum-header)
  (stw dest 0 ppc::initptr)  
  (la dest ppc::fulltag-misc ppc::initptr)  
  (mr ppc::initptr ppc::freeptr)
  :no-overflow)

;  (setq dest (- x y))
(define-vinsn fixnum-sub (((dest t))
                          ((x t)
                           (y t)))
  (subf dest y x))

(define-vinsn fixnum-sub-from-constant (((dest :imm))
                                        ((x :s16const)
                                         (y :imm)))
  (subfic dest y (:apply ash x ppc::fixnumshift)))


#|
(define-vinsn fixnum-sub-overflow (((dest :imm))
                                   ((x :imm)
                                    (y :imm))
                                   ((cr0 (:crf 0))))
  (mtxer ppc::rzero) ;(mcrxr 0)
  (subo. dest x y)
  (bns+ cr0 :no-overflow)
  (uuo_fixnum_overflow dest dest)
:no-overflow)
|#

;; beware dest = x or y
(define-vinsn fixnum-sub-overflow (((dest :imm))
                                   ((x :imm)
                                    (y :imm))
                                   ((cr0 (:crf 0))))
  (mtxer ppc::rzero) ;(mcrxr 0)
  (subo. dest x y)
  (bns+ cr0 :no-overflow)
  (stwu ppc::rzero ppc::one-digit-bignum.size ppc::freeptr)
  (srawi dest dest ppc::fixnumshift)
  (xoris dest dest (ash ppc::fixnummask (- 16 ppc::nfixnumtagbits)))    ;; aka #xc000 
  (stw dest 4 ppc::initptr)
  (li dest ppc::one-digit-bignum-header)
  (stw dest 0 ppc::initptr)  
  (la dest ppc::fulltag-misc ppc::initptr)  
  (mr ppc::initptr ppc::freeptr)
  :no-overflow)

; This is, of course, also "subtract-immediate."
(define-vinsn add-immediate (((dest t))
                             ((src t)
                              (upper :u32const)
                              (lower :u32const)))
  ((:not (:pred = upper 0))
   (addis dest src upper)
   ((:not (:pred = lower 0))
    (addi dest dest lower)))
  ((:and (:pred = upper 0) (:not (:pred = lower 0)))
   (addi dest src lower)))

;This must unbox one reg, but hard to tell which is better.
;(The one with the smaller absolute value might be)
(define-vinsn multiply-fixnums (((dest :imm))
                                ((a :imm)
                                 (b :imm))
                                ((unboxed :s32)))
  (srawi unboxed b ppc::fixnumshift)
  (mullw dest a unboxed))

(define-vinsn multiply-immediate (((dest :imm))
                                  ((boxed :imm)
                                   (const :s16const)))
  (mulli dest boxed const))

; Mask out the code field of a base character; the result
; should be EXACTLY = to subtag-base-character
(define-vinsn mask-base-character (((dest :u32))
                                   ((src :imm)))
  (rlwinm dest src 0 (1+ (- ppc::least-significant-bit ppc::charcode-shift)) (1- (- ppc::nbits-in-word (+ ppc::charcode-shift 8)))))

                                    

                             
;; Boundp, fboundp stuff.
(define-vinsn symbol-value (((val :lisp))
                            ((sym (:lisp (:ne val))))
                            ((crf :crf)))
  (lwz val ppc::symbol.vcell sym)
  (cmpwi crf val ppc::unbound-marker)
  (bne crf :ok)
  (bla .SPuuounbound)
  (uuo_unbound val sym)
  :ok)

(define-vinsn symbol-function (((val :lisp))
                               ((sym (:lisp (:ne val))))
                               ((crf :crf)
                                (tag :u32)))
  (lwz val ppc::symbol.fcell sym)
  (clrlwi tag val (- 32 ppc::nlisptagbits))
  (cmpwi crf tag ppc::tag-misc)
  (bne crf :bad)
  (lbz tag ppc::misc-subtag-offset val)
  (cmpwi crf tag ppc::subtag-function)
  (beq crf :good)
  :bad 
  (bla .SPxuuo-interr)
  (uuo_interr ppc::error-udf sym)
  :good)

(define-vinsn (temp-push-unboxed-word :push :word :tsp)
              (()
               ((w :u32)))
  (stwu ppc::tsp -16 ppc::tsp)
  (stw ppc::tsp 4 ppc::tsp)
  (stw w 8 ppc::tsp)
  (bla .SPtscheck))

(define-vinsn (temp-pop-unboxed-word :pop :word :tsp)
              (((w :u32))
               ())
  (lwz w 8 ppc::tsp)
  (lwz ppc::tsp 0 ppc::tsp))

(define-vinsn (temp-push-double-float :push :doubleword :tsp)
              (((d :double-float))
               ())
  (stwu ppc::tsp -16 ppc::tsp)
  (stw ppc::tsp 4 ppc::tsp)
  (stfd d 8 ppc::tsp)
  (bla .SPtscheck))

(define-vinsn (temp-pop-double-float :pop :doubleword :tsp)
              (()
               ((d :double-float)))
  (lfd d 8 ppc::tsp)
  (lwz ppc::tsp 0 ppc::tsp))

(define-vinsn (temp-push-single-float :push :word :tsp)
              (((s :single-float))
               ())
  (stwu ppc::tsp -16 ppc::tsp)
  (stw ppc::tsp 4 ppc::tsp)
  (stfs s 8 ppc::tsp)
  (bla .SPtscheck))

(define-vinsn (temp-pop-single-float :pop :word :tsp)
              (()
               ((s :single-float)))
  (lfs s 8 ppc::tsp)
  (lwz ppc::tsp 0 ppc::tsp))


(define-vinsn (save-nvrs :push :node :vsp :multiple)
              (()
               ((first :u8const)))
  ((:pred <= first ppc::save3)
   (subi ppc::vsp ppc::vsp (:apply * 4 (:apply - 32 first)))
   (stmw first 0 ppc::vsp))
  ((:pred >= first ppc::save2)
   (stwu ppc::save0 -4 ppc::vsp)
   ((:pred <= first ppc::save1)
    (stwu ppc::save1 -4 ppc::vsp)
    ((:pred = first ppc::save2)
     (stwu ppc::save2 -4 ppc::vsp)))))


(define-vinsn (restore-nvrs :pop :node :vsp :multiple)
              (()
               ((firstreg :u8const)
                (basereg :imm)
                (offset :s16const)))
  ((:pred <= firstreg ppc::save3)
   (lmw firstreg offset basereg))
  ((:pred = firstreg ppc::save2)
   (lwz ppc::save2 offset basereg)
   (lwz ppc::save1 (:apply + offset 4) basereg)
   (lwz ppc::save0 (:apply + offset 8) basereg))
  ((:pred = firstreg ppc::save1)
   (lwz ppc::save1 offset basereg)
   (lwz ppc::save0 (:apply + offset 4) basereg))
  ((:pred = firstreg ppc::save0)
   (lwz ppc::save0 offset basereg)))

(define-vinsn (dpayback :call :subprim-call) (()
                                              ((n :s16const))
                                              ((temp (:u32 #.ppc::imm0))))
  ((:pred > n 1)
   (li temp n)
   (bla .SPunbind-n))
  ((:pred = n 1)
   (bla .SPunbind)))

(define-vinsn zero-double-float-register 
              (((dest :double-float))
               ())
  (fmr dest ppc::fp-zero))

(define-vinsn zero-single-float-register 
              (((dest :single-float))
               ())
  (fmr dest ppc::fp-zero))

(define-vinsn load-double-float-constant
              (((dest :double-float))
               ((high t)
                (low t)))
  (stw high -8 ppc::sp)
  (stw low -4 ppc::sp)
  (lfd dest -8 ppc::sp))

(define-vinsn load-single-float-constant
              (((dest :single-float))
               ((src t)))
  (stw src -4 ppc::sp)
  (lfs dest -4 ppc::sp))

(define-vinsn load-indexed-node (((node :lisp))
                                 ((base :lisp)
                                  (offset :s16const)))
  (lwz node offset base))

(define-vinsn recover-saved-vsp (((dest :imm))
                                 ())
  (lwz dest ppc::lisp-frame.savevsp ppc::sp))

(define-vinsn check-exact-nargs (()
                                 ((n :u16const))
                                 ((crf :crf)) )
  (cmpwi crf ppc::nargs (:apply ash n 2))
  (beq crf :ok)
  (mflr ppc::loc-pc)
  (bla .SPtrap-wrongnargs)
  :ok)

(define-vinsn check-min-nargs (()
                               ((min :u16const))
                               ((crf :crf)))
  (cmplwi crf ppc::nargs  (:apply ash min 2))
  (bge crf :ok)
  (mflr ppc::loc-pc)
  (bla .SPtrap-toofewargs)
  :ok)



(define-vinsn check-max-nargs (()
                              ((max :u16const))
                              ((crf :crf)))
  (cmplwi crf ppc::nargs (:apply ash max 2))
  (ble crf :ok)
  (mflr ppc::loc-pc)
  (bla .SPtrap-toomanyargs)
  :ok)

; Save context and establish FN.  The current VSP is the the
; same as the caller's, e.g., no arguments were vpushed.
(define-vinsn save-lisp-context-vsp (()
                                     ()
                                     ((imm :u32)))
  (stwu ppc::sp (- ppc::lisp-frame.size) ppc::sp)
  (stw ppc::fn ppc::lisp-frame.savefn ppc::sp)
  (stw ppc::loc-pc ppc::lisp-frame.savelr ppc::sp)
  (stw ppc::vsp ppc::lisp-frame.savevsp ppc::sp)
  (mr ppc::fn ppc::nfn)
  ; Do a stack-probe ...
  (bla .SPcscheck))

; Do the same thing via a subprim call.
(define-vinsn (save-lisp-context-vsp-ool :call :subprim-call) (()
                                                               ()
                                                               ((imm (:u32 #.ppc::imm0))))
  (bla .SPsavecontextvsp))

(define-vinsn save-lisp-context-offset (()
                                        ((nbytes-vpushed :u16const))
                                        ((imm :u32)))
  (la imm nbytes-vpushed ppc::vsp)
  (stwu ppc::sp (- ppc::lisp-frame.size) ppc::sp)
  (stw ppc::fn ppc::lisp-frame.savefn ppc::sp)
  (stw ppc::loc-pc ppc::lisp-frame.savelr ppc::sp)
  (stw imm ppc::lisp-frame.savevsp ppc::sp)
  (mr ppc::fn ppc::nfn)
  ; Do a stack-probe ...
  (bla .SPcscheck))

(define-vinsn save-lisp-context-offset-ool (()
                                            ((nbytes-vpushed :u16const))
                                            ((imm (:u32 #.ppc::imm0))))
  (li imm nbytes-vpushed)
  (bla .SPsavecontext0))


(define-vinsn save-lisp-context-lexpr (()
                                       ()
                                       ((imm :u32)))
  (stwu ppc::sp (- ppc::lisp-frame.size) ppc::sp)
  (stw ppc::rzero ppc::lisp-frame.savefn ppc::sp)
  (stw ppc::loc-pc ppc::lisp-frame.savelr ppc::sp)
  (stw ppc::vsp ppc::lisp-frame.savevsp ppc::sp)
  (mr ppc::fn ppc::nfn)
  ; Do a stack-probe ...
  (bla .SPcscheck))
  
(define-vinsn save-cleanup-context (()
                                    ())
  ; SP was this deep just a second ago, so no need to do a stack-probe.
  (mflr ppc::loc-pc)
  (stwu ppc::sp (- ppc::lisp-frame.size) ppc::sp)
  (stw ppc::rzero ppc::lisp-frame.savefn ppc::sp)
  (stw ppc::loc-pc ppc::lisp-frame.savelr ppc::sp)
  (stw ppc::vsp ppc::lisp-frame.savevsp ppc::sp))

;; Vpush the argument registers.  We got at least "min-fixed" args;
;; that knowledge may help us generate better code.
(define-vinsn (save-lexpr-argregs :call :subprim-call)
              (()
               ((min-fixed :u16const))
               ((crfx :crf)
                (crfy :crf)
                (entry-vsp (:u32 #.ppc::imm0))
                (arg-temp :u32)))
  ((:pred >= min-fixed $numppcargregs)
   (stwu ppc::arg_x -4 ppc::vsp)
   (stwu ppc::arg_y -4 ppc::vsp)
   (stwu ppc::arg_z -4 ppc::vsp))
  ((:pred = min-fixed 2)                ; at least 2 args
   (cmplwi crfx ppc::nargs (ash 2 ppc::word-shift))
   (beq crfx :yz2)                      ; skip arg_x if exactly 2
   (stwu ppc::arg_x -4 ppc::vsp)
   :yz2
   (stwu ppc::arg_y -4 ppc::vsp)
   (stwu ppc::arg_z -4 ppc::vsp))
  ((:pred = min-fixed 1)                ; at least one arg
   (cmplwi crfx ppc::nargs (ash 2 ppc::word-shift))
   (blt crfx :z1)                       ; branch if exactly one
   (beq crfx :yz1)                      ; branch if exactly two
   (stwu ppc::arg_x -4 ppc::vsp)
   :yz1
   (stwu ppc::arg_y -4 ppc::vsp)
   :z1
   (stwu ppc::arg_z -4 ppc::vsp))
  ((:pred = min-fixed 0)
   (cmplwi crfx ppc::nargs (ash 2 ppc::word-shift))
   (cmplwi crfy ppc::nargs 0)
   (beq crfx :yz0)                      ; exactly two
   (beq crfy :none)                     ; exactly zero
   (blt crfx :z0)                       ; one
   ; Three or more ...
   (stwu ppc::arg_x -4 ppc::vsp)
   :yz0
   (stwu ppc::arg_y -4 ppc::vsp)
   :z0
   (stwu ppc::arg_z -4 ppc::vsp)
   :none
   )
  ((:pred = min-fixed 0)
   (stwu ppc::nargs -4 ppc::vsp))
  ((:not (:pred = min-fixed 0))
   (subi arg-temp ppc::nargs (:apply ash min-fixed ppc::word-shift))
   (stwu arg-temp -4 ppc::vsp))
  (add entry-vsp ppc::vsp ppc::nargs)
  (la entry-vsp 4 entry-vsp)
  (bla .SPlexpr-entry))


(define-vinsn (jump-return-pc :jumpLR)
              (()
               ())
  (blr))

(define-vinsn (restore-full-lisp-context :lispcontext :pop :csp :lrRestore)
              (()
               ())
  (lwz ppc::loc-pc ppc::lisp-frame.savelr ppc::sp)
  (mtlr ppc::loc-pc)
  (lwz ppc::vsp ppc::lisp-frame.savevsp ppc::sp)
  (lwz ppc::fn ppc::lisp-frame.savefn ppc::sp)
  (la ppc::sp ppc::lisp-frame.size ppc::sp))

(define-vinsn (restore-full-lisp-context-ool :lispcontext :pop :csp :lrRestore)
              (()
               ())
  (bla .SPrestorecontext)
  (mtlr ppc::loc-pc))

(define-vinsn (popj :lispcontext :pop :csp :lrRestore :jumpLR)
              (() 
               ())
  (ba .SPpopj))

; Exiting from an UNWIND-PROTECT cleanup is similar to
; (and a little simpler than) returning from a function.
(define-vinsn restore-cleanup-context (()
                                       ())
  (lwz ppc::loc-pc ppc::lisp-frame.savelr ppc::sp)
  (mtlr ppc::loc-pc)
  (la ppc::sp ppc::lisp-frame.size ppc::sp))



(define-vinsn default-1-arg (()
                             ((min :u16const))
                             ((crf :crf)))
  (cmplwi crf ppc::nargs (:apply ash min 2))
  (bne crf :done)
  ((:pred >= min 3)
   (stwu ppc::arg_x -4 ppc::vsp))
  ((:pred >= min 2)
   (mr ppc::arg_x ppc::arg_y))
  ((:pred >= min 1)
   (mr ppc::arg_y ppc::arg_z))
  (mr ppc::arg_z ppc::rnil)
  :done)

(define-vinsn default-2-args (()
                             ((min :u16const))
                             ((crf :crf)))
  (cmplwi crf ppc::nargs (:apply ash (:apply 1+ min) 2))
  (bgt crf :done)
  (beq crf :one)
  ; We got "min" args; arg_y & arg_z default to nil
  ((:pred >= min 3)
   (stwu ppc::arg_x -4 ppc::vsp))   
  ((:pred >= min 2)
   (stwu ppc::arg_y -4 ppc::vsp))
  ((:pred >= min 1)
   (mr ppc::arg_x ppc::arg_z))
  (mr ppc::arg_y ppc::rnil)
  (b :last)
  :one
  ; We got min+1 args: arg_y was supplied, arg_z defaults to nil.
  ((:pred >= min 2)
   (stwu ppc::arg_x -4 ppc::vsp))
  ((:pred >= min 1)
   (mr ppc::arg_x ppc::arg_y))
  (mr ppc::arg_y ppc::arg_z)
  :last
  (mr ppc::arg_z ppc::rnil)
  :done)

(define-vinsn default-3-args (()
                              ((min :u16const))
                              ((crfx :crf)
                               (crfy :crf)))
  (cmplwi crfx ppc::nargs (:apply ash (:apply + 2 min) 2))
  (cmplwi crfy ppc::nargs (:apply ash min 2))
  (bgt crfx :done)
  (beq crfx :two)
  (beq crfy :none)
  ; The first (of three) &optional args was supplied.
  ((:pred >= min 2)
   (stwu ppc::arg_x -4 ppc::vsp))
  ((:pred >= min 1)
   (stwu ppc::arg_y -4 ppc::vsp))
  (mr ppc::arg_x ppc::arg_z)
  (b :last-2)
  :two
  ; The first two (of three) &optional args were supplied.
  ((:pred >= min 1)
   (stwu ppc::arg_x -4 ppc::vsp))
  (mr ppc::arg_x ppc::arg_y)
  (mr ppc::arg_y ppc::arg_z)
  (b :last-1)
  ; None of the three &optional args was provided.
  :none
  ((:pred >= min 3)
   (stwu ppc::arg_x -4 ppc::vsp))
  ((:pred >= min 2)
   (stwu ppc::arg_y -4 ppc::vsp))
  ((:pred >= min 1)
   (stwu ppc::arg_z -4 ppc::vsp))
  (mr ppc::arg_x ppc::rnil)
  :last-2
  (mr ppc::arg_y ppc::rnil)
  :last-1
  (mr ppc::arg_z ppc::rnil)
  :done)

(define-vinsn save-lr (()
                       ())
  (mflr ppc::loc-pc))

;; "n" is the sum of the number of required args + 
;; the number of &optionals.  "spno" is probably
;; the subprim offset of .SPdefault-optional-args.
(define-vinsn (default-optionals :call :subprim-call) (()
                                                       ((n :u16const)))
  (li ppc::imm0 (:apply ash n 2))
  (bla .SPdefault-optional-args))

; fname contains a known symbol
(define-vinsn (call-known-symbol :call) (()
                                         ())
  (lwz ppc::nfn ppc::symbol.fcell ppc::fname)
  (lwz ppc::temp0 ppc::misc-data-offset ppc::nfn)
  (la ppc::loc-pc ppc::misc-data-offset ppc::temp0)
  (mtctr ppc::loc-pc)
  (bctrl))

(define-vinsn (jump-known-symbol :jumplr) (()
                                           ())
  (lwz ppc::nfn ppc::symbol.fcell ppc::fname)
  (lwz ppc::temp0 ppc::misc-data-offset ppc::nfn)
  (la ppc::loc-pc ppc::misc-data-offset ppc::temp0)
  (mtctr ppc::loc-pc)
  (bctr))

(define-vinsn (call-known-function :call) (()
                                           ())
  (lwz ppc::temp0 ppc::misc-data-offset ppc::nfn)
  (la ppc::loc-pc ppc::misc-data-offset ppc::temp0)
  (mtctr ppc::loc-pc)
  (bctrl))

(define-vinsn (jump-known-function :jumplr) (()
                                             ())
  (lwz ppc::temp0 ppc::misc-data-offset ppc::nfn)
  (la ppc::loc-pc ppc::misc-data-offset ppc::temp0)
  (mtctr ppc::loc-pc)
  (bctr))

(define-vinsn %schar (((char :imm))
                      ((str :lisp)
                       (idx :imm))
                      ((imm :u32)
                       (cr0 (:crf 0))))
  (lbz imm ppc::misc-subtag-offset str)
  (cmpwi cr0 imm ppc::subtag-simple-general-string)
  (srwi imm idx ppc::fixnumshift)
  (addi imm imm ppc::misc-data-offset)
  (bne :bstr)
  (srwi imm idx (1- ppc::fixnumshift))
  (addi imm imm ppc::misc-data-offset)
  (lhzx imm str imm)
  (b :tagit)
  :bstr  
  (lbzx imm str imm)
  :tagit
  (rlwinm imm imm ppc::charcode-shift 0 (1- ppc::charcode-shift))
  (addi char imm ppc::subtag-character))

(define-vinsn %set-schar (()
                          ((str :lisp)
                           (idx :imm)
                           (char :imm))
                          ((imm :u32)
                           (imm1 :u32)
                           (cr0 (:crf 0))))
  (lbz imm ppc::misc-subtag-offset str)
  (cmpwi cr0 imm ppc::subtag-simple-general-string)
  (srwi imm idx ppc::fixnumshift)
  (addi imm imm ppc::misc-data-offset)
  (srwi imm1 char ppc::charcode-shift)
  (bne :bstr)
  (srwi imm idx (1- ppc::fixnumshift))
  (addi imm imm ppc::misc-data-offset)
  (sthx imm1 str imm)
  (b :done)
  :bstr  
  (stbx imm1 str imm)
  :done
  )

(define-vinsn %set-scharcode (()
                          ((str :lisp)
                           (idx :imm)
                           (code :imm))
                          ((imm :u32)
                           (imm1 :u32)
                           (cr0 (:crf 0))))
  (lbz imm ppc::misc-subtag-offset str)
  (cmpwi cr0 imm ppc::subtag-simple-general-string)
  (srwi imm idx ppc::fixnumshift)
  (addi imm imm ppc::misc-data-offset)
  (srwi imm1 code ppc::fixnumshift)
  (bne :bstr)
  (srwi imm idx (1- ppc::fixnumshift))
  (addi imm imm ppc::misc-data-offset)
  (sthx imm1 str imm)
  (b :done)
  :bstr  
  (stbx imm1 str imm)
  :done
  )


(define-vinsn %scharcode (((code :imm))
                          ((str :lisp)
                           (idx :imm))
                          ((imm :u32)
                           (cr0 (:crf 0))))
  (lbz imm ppc::misc-subtag-offset str)
  (cmpwi cr0 imm ppc::subtag-simple-general-string)
  (srwi imm idx ppc::fixnumshift)
  (addi imm imm ppc::misc-data-offset)
  (bne :bstr)
  (srwi imm idx (1- ppc::fixnumshift))
  (addi imm imm ppc::misc-data-offset)
  (lhzx imm str imm)
  (b :tagit)
  :bstr  
  (lbzx imm str imm)
  :tagit
  (slwi code imm ppc::fixnumshift))

; Clobbers LR
(define-vinsn (%debug-trap :call :subprim-call) (()
                                                 ())
  (bla .SPbreakpoint)
  )

(define-vinsn misc-ref-data-vector (()
                                    ((dest :lisp)
                                     (src :lisp))
                                    )
  (lwz dest (+ ppc::misc-data-offset (ash ppc::arrayH.data-vector-cell ppc::word-shift)) src))

(define-vinsn 2d-array-index (()
                                ((idx0 :lisp)
                                 (idx1 :lisp)
                                 (v :lisp)
                                 (res-idx :lisp))
                                ((temp :u32)
                                 (temp1 :u32)))
  (lwz temp (+ ppc::misc-data-offset (ash ppc::arrayH.dim0-cell ppc::word-shift)) v) ; dim0 
  (cmplw  idx0 temp) 
  (blt :ok0)
  ;; now how do we get this error right
  ;(uuo_interr ppc::error-object-not-fixnum idx0)
  (mr ppc::arg_y idx0)
  (b :bad1)  
  :ok0  
  (lwz temp1 (+ ppc::misc-data-offset (ash (1+ ppc::arrayH.dim0-cell) ppc::word-shift)) v) ; dim1 
  (cmplw idx1 temp1)
  (blt :ok1)
  ;(uuo_interr ppc::error-object-not-fixnum idx1)
  (mr ppc::arg_y idx1)
  :bad1
  (li ppc::arg_x (ash $XARROOB ppc::word-shift))
  (mr ppc::arg_z v)  
  (li ppc::nargs (ash 3 ppc::word-shift))
  (bla .spksignalerr)  ;; hope we never return
  :ok1  
  (srawi temp1 temp1 ppc::fixnumshift) ;; unbox dim1
  (mullw temp idx0 temp1)
  (add res-idx temp idx1))

(define-vinsn 2d-array-index-no-bounds-check (()
                                              ((idx0 :lisp)
                                               (idx1 :lisp)
                                               (v :lisp)
                                               (res-idx :lisp))
                                              ((temp :u32)
                                               (temp1 :u32)))
  (lwz temp (+ ppc::misc-data-offset (ash ppc::arrayH.dim0-cell ppc::word-shift)) v) ; dim0   
  (lwz temp1 (+ ppc::misc-data-offset (ash (1+ ppc::arrayH.dim0-cell) ppc::word-shift)) v) ; dim1   
  (srawi temp1 temp1 ppc::fixnumshift) ;; unbox dim1
  (mullw temp idx0 temp1)
  (add res-idx temp idx1))

  
                 

; In case ppc::*ppc-opcodes* was changed since this file was compiled.
(queue-fixup
 (fixup-vinsn-templates))

(ccl::provide "PPC-VINSNS")
