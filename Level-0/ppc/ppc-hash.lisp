;;; -*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  7 5/20/96  akh  added a function and didn't use it
;;  6 12/22/95 gb   need-use-eql true for macptrs
;;  5 10/26/95 gb   cons-hash-table in l0-hash.  Peek at gc counts.
;;  (do not edit before this line!!)

;;;
;;; level-0;ppc;ppc-hash.lisp

; 02/11/97 gb %sfloat-hash.
; ---- 4.0
; 06/01/96 gb ephemeral-p.
; ---- 3.9
; 10/16/95 gb fix to FAST-MOD.

;(in-package "CCL")

(eval-when (:compile-toplevel :execute)
  (require "HASHENV" "ccl:xdump;hashenv"))


(defun immediate-p (thing)
  (let* ((tag (ppc-lisptag thing)))
    (declare (fixnum tag))
    (or (= tag ppc::tag-fixnum)
        (= tag ppc::tag-imm))))

; This should stay in LAP so that it's fast
; Equivalent to cl:mod when both args are positive fixnums
(defppclapfunction fast-mod ((number arg_y) (divisor arg_z))
  (divwu imm0 number divisor)
  (mullw arg_z imm0 divisor)
  (subf arg_z arg_z number)
  (blr))

; not used today
(defppclapfunction fixnum-rotate ((number arg_y) (count arg_z))
  (unbox-fixnum imm0 count)
  (unbox-fixnum imm1 number)
  (rlwnm imm1 imm1 imm0 0 31)
  (box-fixnum arg_z imm1)
  (blr))



(defppclapfunction %dfloat-hash ((key arg_z))
  (lwz imm0 ppc::double-float.value key)
  (lwz imm1 ppc::double-float.val-low key)
  (add imm0 imm0 imm1)
  (box-fixnum arg_z imm0)
  (blr))

(defppclapfunction %sfloat-hash ((key arg_z))
  (lwz imm0 ppc::single-float.value key)
  (box-fixnum arg_z imm0)
  (blr))

(defppclapfunction %macptr-hash ((key arg_z))
  (lwz imm0 ppc::macptr.address key)
  (slwi imm1 imm0 24)
  (add imm0 imm0 imm1)
  (clrrwi arg_z imm0 ppc::fixnumshift)
  (blr))

(defppclapfunction %bignum-hash ((key arg_z))
  (let ((header imm3)
        (offset imm2)
        (ndigits imm1)
        (immhash imm0))
    (li immhash 0)
    (li offset ppc::misc-data-offset)
    (getvheader header key)
    (header-size ndigits header)
    (let ((next header))
      @loop
      (cmpwi cr0 ndigits 1)
      (subi ndigits ndigits 1)
      (lwzx next key offset)
      (addi offset offset 4)
      (rotlwi immhash immhash 13)
      (add immhash immhash next)
      (bne cr0 @loop))
    (clrrwi arg_z immhash ppc::fixnumshift)
    (blr)))

      
; Is KEY something which can be EQL to something it's not EQ to ?
; (e.g., is it a number or macptr ?)
; This can be more general than necessary but shouldn't be less so.
(defun need-use-eql (key)
  (let* ((typecode (ppc-typecode key)))
    (declare (fixnum typecode))
    (or (= typecode ppc::subtag-macptr)
        (and (>= typecode ppc::min-numeric-subtag)
             (<= typecode ppc::max-numeric-subtag)))))

(defppclapfunction %get-fwdnum ()
  (ref-global arg_z ppc::fwdnum)
  (blr))

(defun get-fwdnum (&optional hash)
  (let* ((res (%get-fwdnum)))
    (if hash
      (setf (nhash.fixnum hash) res))
    res))

(defppclapfunction %get-gc-count ()
  (ref-global arg_z ppc::gc-count)
  (blr))

(defun gc-count (&optional hash)
   (let ((res (%get-gc-count)))
    (if hash
      (setf (nhash.gc-count hash) res)
      res)))
      
; X is ephemeral if it's a cons or vector, the kernel global
; "OLDEST-EPHEMERAL" is non-zero, and X is between OLDEST-EPHEMERAL
; and the freeptr.
(defppclapfunction ephemeral-p ((x arg_z))
  (ref-global imm1 oldest-ephemeral)
  (cmpwi cr0 imm1 0)
  (extract-fulltag imm0 x)
  (cmpwi cr1 imm0 ppc::fulltag-cons)
  (cmpwi cr2 imm0 ppc::fulltag-misc)
  (cmplw cr3 x freeptr)
  (beq cr0 @no)
  (cmplw cr0 imm1 x)
  (beq cr1 @maybe)
  (bne cr2 @no)
  @maybe
  (bgt cr3 @no)
  (bgt cr0 @no)
  (la arg_z ppc::t-offset rnil)
  (blr)
  @no
  (mr arg_z rnil)
  (blr))



(defun %cons-nhash-vector (size &optional (flags 0))
  (declare (fixnum size))
  (let* ((vector (%alloc-misc (+ (+ size size) $nhash.vector_overhead) ppc::subtag-hash-vector (%unbound-marker-8))))
    (setf (nhash.vector.link vector) 0
          (nhash.vector.flags vector) flags
          (nhash.vector.free-alist vector) nil
          (nhash.vector.finalization-alist vector) nil
          (nhash.vector.weak-deletions-count vector) 0
          (nhash.vector.hash vector) nil
          (nhash.vector.deleted-count vector) 0
          (nhash.vector.cache-key vector) (%unbound-marker-8)
          (nhash.vector.cache-value vector) nil
          (nhash.vector.cache-idx vector) nil)
    vector))

; end of ppc-hash.lisp
