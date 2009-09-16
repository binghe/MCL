;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  3 2/19/96  akh  fix makunbound - don't make it special as a result.
;;  (do not edit before this line!!)


; 05/07/97 bill boundp moves here from "l1-utils-ppc" & "l1-utils-68k"
; ------------- 4.1
; 10/22/96 bill Add length checking to check-symbol-list to prevent the progvsave subprim
;               from attempting to allocate too big a TSP frame.
; ------------  4.0
; 12/13/95  gb  add check-symbol-list (so progv doesn't have to

; No error checking, no interrupts, no protect_caller, no nuthin.
; No error, no cons.  No problem.
(defun %progvrestore (saved)
  (declare (optimize (speed 3) (safety 0)))
  (dolist (pair saved)
    (%set-sym-value (car pair) (cdr pair))))

;; Check that something that's supposed to be a proper list of
;; symbols is; error otherwise.
;; This is called only by the compiler output of a PROGV form.
;; It checks for the maximum length that the progvsave subprim
;; can handle.
(defun check-symbol-list (l &optional (max-length
                                       #+ppc-target (floor (- 4096 20) (* 4 3))
                                       #-ppc-target nil))
  (let ((len (list-length l)))
    (if (and len
             (or (null max-length)
                 (< len max-length))
             (dolist (s l t) 
               (unless (and (symbolp s) (not (constant-symbol-p s)))
                 (return nil))))
      l
      (error "~s is not a proper list of bindable symbols~@[ of length < ~s~]." l max-length))))

; The type-checking done on the "plist" arg shouldn't be removed.
; (The new definition of SYMBOLP doesn't like the 16 lsbits of symbol plists
; to become 0.)
(defun set-symbol-plist (sym plist)
  (let* ((pp (%symbol-package-plist sym))
         (newpp pp))
    (let* ((len (list-length plist)))
      (unless (and len (evenp len))
        (error "Bad plist: ~s" plist)))
    (if (atom pp)
      (setq newpp (cons pp plist))
      (let* ((bits (%symbol-bits sym)))
        (declare (fixnum bits))
        (if (logbitp $sym_vbit_typeppred bits)
          (setf (cdr (cdr pp)) plist)
          (setf (cdr pp) plist))))
    (%set-symbol-package-plist sym newpp)
    plist))


(defun %pl-search (ok-plist key)
  (do* ((l ok-plist (cdr (the list (cdr l)))))
       ((or (null l) (eq (car l) key)) l)
    (declare (list l))))

(defun symbol-plist (sym)
  (let* ((pp (%symbol-package-plist sym)))
    (if (consp pp)
      (let* ((bits (%symbol-bits sym)))
        (declare (fixnum bits))
        (if (logbitp $sym_vbit_typeppred bits)
          (cddr pp)
          (cdr pp))))))


(defun get (sym key &optional default)
  (let* ((tail (%pl-search (symbol-plist sym) key)))
    (if tail (%cadr tail) default)))

(defun put (sym key value)
  (let* ((plist (symbol-plist sym))
         (tail (%pl-search plist key)))
    (if tail 
      (%rplaca (%cdr tail) value)
      (set-symbol-plist sym (cons key (cons value plist))))
    value))

; This is how things have traditionally been defined: if %sym_vbit_typeppred 
; is set in the symbol's %SYMBOL-BITS, it's assumed that it's safe to
; take the %CADR of the %SYMBOL-PACKAGE-PLIST.
(defun get-type-predicate (name)
  (let* ((bits (%symbol-bits name)))
    (declare (fixnum bits))
    (if (logbitp $sym_vbit_typeppred bits)
      (%cadr (%symbol-package-plist name)))))

(defun set-type-predicate (name function)
  (let* ((bits (%symbol-bits name))
         (spp (%symbol-package-plist name)))
    (declare (fixnum bits))
    (if (logbitp $sym_vbit_typeppred bits)
      (%rplaca (%cdr (%symbol-package-plist name)) function)
      (without-interrupts
        (%symbol-bits name (the fixnum (bitset $sym_vbit_typeppred bits)))
        (if (atom spp)
          (%set-symbol-package-plist name (cons spp (cons function nil)))
          (%rplacd spp (cons function (cdr spp))))))
    function))

(defun symbol-value (sym)
  (let* ((val (%sym-value sym)))
    (if (eq val (%unbound-marker))
      (%kernel-restart $xvunbnd sym)
      val)))

(defun set (sym value)
  (let* ((bits (%symbol-bits sym)))
    (declare (fixnum bits))
    (if (logbitp $sym_vbit_const bits)
      (%err-disp $XCONST sym)
      (%set-sym-value sym value))))

(defun constant-symbol-p (sym)
  (and (symbolp sym)
       (%ilogbitp $sym_vbit_const (%symbol-bits sym))))

; This leaves the SPECIAL and INDIRECT bits alone, clears the others.
(defun makunbound (sym)
  (if (and *warn-if-redefine-kernel*
           (constant-symbol-p sym))
    (cerror "Make ~S be unbound anyway."
            "~S is a constant; making it unbound might be a bad idea." sym))
  (%symbol-bits sym (the fixnum (logand (logior #xff00 (%ilsl $sym_bit_special 1))
                                        (the fixnum (%symbol-bits sym)))))
  (%set-sym-value sym (%unbound-marker))
  sym)

(defun non-nil-symbolp (x)
  "Returns symbol if true"
  (if (symbolp x) x))

(defun symbol-package (sym)
  (let* ((pp (%symbol-package-plist sym)))
    (if (consp pp) (car pp) pp)))

(defun boundp (sym)
  (not (eq (%sym-value sym) (%unbound-marker))))