;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  4 5/20/96  akh  no dir in require number-macros
;;  (do not edit before this line!!)

;;;
;;; level-0;ppc;ppc-complex.lisp

; Modification History
;
; 12/06/95 slh   coerce-to-complex-type from Lib;numbers.lisp

#| MISSING - see ppc-numbers.lisp
(defun complex (realpart &optional imagpart)

;(coerce num 'complex)
(defun coerce-to-complex (num)

;(coerce num '(complex float))
(defun coerce-to-complex-float (tags num)
|#

#+allow-in-package
(in-package "CCL")

(eval-when (:compile-toplevel :execute)
  (require "NUMBER-MACROS"))

;(coerce num '(complex <type>))
(defun coerce-to-complex-type (num type)
  (cond ((complexp num)
         (let ((real (%realpart num))
               (imag (%imagpart num)))
           (if (and (typep real type)
                    (typep imag type))
             num
             (complex (coerce real type)
                      (coerce imag type)))))
        (t (complex (coerce num type)))))

; end of ppc-complex.lisp
