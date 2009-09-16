;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  6 12/22/95 gb   %global-macro-function, %function fixes
;;  3 10/26/95 akh  damage control
;;  3 10/26/95 gb   %global-macro-function
;;  (do not edit before this line!!)

; 12/23/95 bill check-nargs in %function
; 12/21/95 gb  fix %global-macro-function for the first time
; 12/14/95 gb  fix %function (again ?)
; 12/13/95 gb  fix %function (again ?)

(eval-when (:compile-toplevel :execute)
  (require "PPC-ARCH" "ccl:compiler;ppc;ppc-arch")
  (require "PPC-LAPMACROS" "ccl:compiler;ppc;ppc-lapmacros"))

; This assumes that macros & special-operators
; have something that's not FUNCTIONP in their
; function-cells.
(defppclapfunction %function ((sym arg_z))
  (check-nargs 1)
  (cmpw cr1 sym rnil)
  (let ((symptr temp0)
        (symbol temp1)
        (def arg_z))
    (la symptr ppc::nilsym-offset rnil)
    (mr symbol sym)
    (if (:cr1 :ne)
      (progn
        (trap-unless-typecode= sym ppc::subtag-symbol)
        (mr symptr sym)))
    (lwz def ppc::symbol.fcell symptr)
    (extract-typecode imm0 def)
    (cmpwi cr0 imm0 ppc::subtag-function)
    (beqlr+)
    (bla .SPxuuo-interr)
    (uuo_interr ppc::error-udf symbol)))

(defun make-symbol (name)
  (%ppc-gvector ppc::subtag-symbol
                (require-type name 'simple-string) ; pname
                (%unbound-marker)       ; value cell
                %unbound-function%      ; function cell
                nil                     ; package&plist
                0))                     ; flags

(defun %symbol-bits (sym &optional new)
  (let* ((p (%symbol->symptr sym))
         (bits (%svref p ppc::symbol.flags-cell)))
    (if new
      (setf (%svref p ppc::symbol.flags-cell) new))
    bits))

; Traps unless sym is NIL or some other symbol.
(defppclapfunction %symbol->symptr ((sym arg_z))
  (cmpw cr0 arg_z rnil)
  (if (:cr0 :eq)
    (progn
      (la arg_z ppc::nilsym-offset rnil)
      (blr)))
  (trap-unless-typecode= arg_z ppc::subtag-symbol)
  (blr))

; Traps unless symptr is a symbol; returns NIL if symptr is NILSYM.
(defppclapfunction %symptr->symbol ((symptr arg_z))
  (la imm1 ppc::nilsym-offset rnil)
  (cmpw cr0 imm1 symptr)
  (if (:cr0 :eq)
    (progn 
      (mr arg_z rnil)
      (blr)))
  (trap-unless-typecode= symptr ppc::subtag-symbol imm0)
  (blr))

(defun %sym-value (name)
  (%svref (%symbol->symptr name) ppc::symbol.vcell-cell))

(defun %set-sym-value (name val)
  (setf (%svref (%symbol->symptr name) ppc::symbol.vcell-cell) val))

(defun %symbol-package-plist (sym)
  (%svref (%symbol->symptr sym) ppc::symbol.package-plist-cell))

(defun %set-symbol-package-plist (sym new)
  (setf (%svref (%symbol->symptr sym) ppc::symbol.package-plist-cell) new))

(defun symbol-name (sym)
  (%svref (%symbol->symptr sym) ppc::symbol.pname-cell))


(defun %global-macro-function (symbol)
  (let* ((fbinding (fboundp symbol)))
    (if (and (typep fbinding 'simple-vector)
             (= (the fixnum (uvsize fbinding)) 2))
      (let* ((fun (%svref fbinding 1)))
        (if (functionp fun) fun)))))

    




