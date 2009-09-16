;;; -*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  5 11/15/95 slh  move out ppc thingie
;;  4 11/15/95 gb   (shouldn't be here) added %vect-subtype.
;;  (do not edit before this line!!)

;;;
;;; level-0;l0-array.lisp

;; 07/02/05 forget element-type fn of initial-element
; 01/20/99 akh character same as char p.o.s
;11/15/95 gb  add %vect-subtype; should go in ppc;ppc-arrays.lisp


; compiler-transforms
(defun make-string (size &key (initial-element () initial-element-p) (element-type 'character element-type-p))
  (declare (ignore-if-unused element-type-p))
  #+ignore
  (when (and initial-element-p (not element-type-p))
    ; perhaps we should whine if element type is base and initial element is extended
    (setq element-type (type-of initial-element) element-type-p t))
  (if (or (eq element-type 'base-character)
          (eq element-type 'base-char)  ;; p.o.s
          (eq element-type 'standard-char)
          (unless (or (eq element-type 'character)
                      (eq element-type 'extended-character)
                      (eq element-type 'extended-char))
            (subtypep element-type 'base-character)))
    (if initial-element-p
      (make-string size :element-type 'base-character :initial-element initial-element)
      (make-string size :element-type 'base-character))
    (if initial-element-p
      (make-string size :element-type 'extended-character :initial-element initial-element)
      (make-string size :element-type 'extended-character))))

; end of l0-array.lisp
