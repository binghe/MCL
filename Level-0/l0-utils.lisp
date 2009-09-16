; -*- Mode: Lisp;  Package: CCL; -*-

;;	Change History (most recent first):
;;  9 6/7/96   akh  optimize ensure-simple-string some
;;  8 5/20/96  akh  ensure-simple-string - base-string-p vs typep (but typep fixed too)
;;  3 10/30/95 bill handlep no longer calls #_RecoverHandle; it crashes too often.
;;  2 10/26/95 akh  damage control
;;  2 10/26/95 gb   fixes in ENSURE-SIMPLE-STRING
;;  (do not edit before this line!!)


; l0-utils.lisp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; add macptr<
;; -------- 4.4b4
;; akh ensure-simple-string - base-string-p vs typep (but typep fixed too)
;; 03/26/96 gb    move ZONE-POINTERP, HANDLEP to level-1.
;; 03/10/96 gb    typo in ENSURE-SIMPLE-STRING
;; 01/29/96 bill  macptr<= & macptr-evenp use new macptr-to-fixnums to avoid consing
;;

#+allow-in-package
(in-package "CCL")

(defun %proclaim-notspecial (sym)
  (%symbol-bits sym (logandc2 (%symbol-bits sym) (ash 1 $sym_bit_special))))





#| ;; move to l1-utils-ppc
;; Return the size of a pointer or handle, or NIL if it can't be determined
(defun pointer-size (macptr)
  (setq macptr (require-type macptr 'macptr))
  (cond ((handlep macptr) (#_GetHandleSize  macptr))
        ((zone-pointerp macptr) (#_GetPtrSize macptr))
        (t nil)))
|#


(defun ensure-simple-string (s)
  (cond ((simple-string-p s) s)
        ((stringp s)
         (let* ((len (length s))
                (base (base-string-p s))
                (new (if base
                       (make-string len :element-type 'base-character)
                       (make-string len :element-type 'extended-character))))
           (declare (fixnum len)(optimize (speed 3)(safety 0)))
           (multiple-value-bind (ss offset) (array-data-and-offset s)
             (if base
               (locally (declare (type (simple-array (unsigned-byte 8)(*)) new ss))
                 (dotimes (i len new)
                   (setf (aref new i) (aref ss (%i+ offset i))))) 
               (locally (declare (type (simple-array (unsigned-byte 16)(*)) new ss))
                 (dotimes (i len new)
                   (setf (aref new i) (aref ss (%i+ offset i)))))))
           new))
        (t (report-bad-arg s 'string))))

; Returns two fixnums: low, high
(defppclapfunction macptr-to-fixnums ((macptr arg_z))
  (check-nargs 1)
  (trap-unless-typecode= macptr ppc::subtag-macptr)
  (lwz imm0 ppc::macptr.address macptr)
  (rlwinm imm1 imm0 2 14 29)
  (vpush imm1)
  (rlwinm imm1 imm0 18 14 29)
  (vpush imm1)
  (set-nargs 2)
  (la temp0 8 vsp)
  (ba .SPvalues))

(defun macptr<= (p1 p2)
  (multiple-value-bind (p1-low p1-high) (macptr-to-fixnums p1)
    (declare (fixnum p1-low p1-high))
    (multiple-value-bind (p2-low p2-high) (macptr-to-fixnums p2)
      (declare (fixnum p2-low p2-high))
      (or (< p1-high p2-high)
          (and (eql p1-high p2-high)
               (<= p1-low p2-low))))))

(defun macptr< (p1 p2)
  (multiple-value-bind (p1-low p1-high) (macptr-to-fixnums p1)
    (declare (fixnum p1-low p1-high))
    (multiple-value-bind (p2-low p2-high) (macptr-to-fixnums p2)
      (declare (fixnum p2-low p2-high))
      (or (< p1-high p2-high)
          (and (eql p1-high p2-high)
               (< p1-low p2-low))))))



(defun macptr-evenp (p)
  (let ((low (macptr-to-fixnums p)))
    (declare (fixnum low))
    (evenp low)))

; end
