;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  2 10/6/95  gb   I forget.
;;  (do not edit before this line!!)

;; akh change %defun to whine if already gf, and fix that for bootstrapping


; primitives that manipulate function & variable definitions.





(defun functionp (arg)
  (functionp arg))

(defun lfunp (arg)
  (functionp arg))


(defun %proclaim-special (sym &optional initp)  
  (let* ((oldbits (%symbol-bits sym)))
    (declare (fixnum oldbits))
    (%symbol-bits sym (bitset $sym_vbit_special oldbits))
    initp))

(setq *lfun-names* (make-hash-table :test 'eq :weak t))

(defun lookup-lfun-name (lfun) 
  (gethash lfun *lfun-names*))


(defun function-name (fun)
  (or (and (functionp fun) (lfun-name fun))
      (if (compiled-function-p (setq fun (closure-function fun)))
        (lfun-name fun)
        (if (and (consp fun) (eq (%car fun) 'lambda))
          (dolist (x (cddr fun))
            (when (and (consp x) (eq (%car x) 'block))
              (return (car (%cdr x)))))))))


(defun bootstrapping-fmakunbound (name)
  (when (consp name)
    (unless (eq (%car name) 'setf)
      (error "Function spec handler not loaded yet"))
    (setq name (setf-function-name (cadr name))))
  (%unfhave name)
  name)

; redefined in sysutils.
(%fhave 'fmakunbound #'bootstrapping-fmakunbound)

(defun bootstrapping-fset (name fn)
  (fmakunbound name)
  (%fhave name fn)
  fn)

;Redefined in sysutils.
(%fhave 'fset #'bootstrapping-fset)

(defun bootstrapping-record-source-file (fn &optional type)
  (declare (ignore fn type))
  nil)

;Redefined in l1-utils.
(%fhave 'record-source-file #'bootstrapping-record-source-file)


(setq *fasload-print* nil)
(setq *save-doc-strings* nil)

(defun bootstrapping-set-documentation (symbol doc-type string)
  (declare (ignore symbol doc-type))
  string)

(%fhave 'set-documentation #'bootstrapping-set-documentation)


(%fhave '%defun-encapsulated-maybe ;Redefined in encapsulate
        (qlfun bootstrapping-defun-encapsulated (name fn)
          (declare (ignore name fn))
          nil))

(%fhave 'encapsulated-function-name  ;Redefined in encapsulate - used in l1-io
        (qlfun bootstrapping-encapsulated-function-name (fn)
          (declare (ignore fn))
          nil))

(%fhave '%traced-p  ;Redefined in encapsulate - used in l1-io
        (qlfun bootstrapping-%traced-p (fn)
          (declare (ignore fn))
          nil))

(%fhave '%advised-p  ;Redefined in encapsulate used in l1-io
        (qlfun bootstrapping-%advised-p (fn)
          (declare (ignore fn))
          nil))

(%fhave 'set-function-info (qlfun set-function-info  (name info) (declare (ignore info)) name))

(defun %defun (named-fn &optional info &aux (name (function-name named-fn)))
  (when (fboundp 'typep) ;; bootstrapping
    (let* ((fbinding (fboundp name))
         (gf (if (functionp fbinding) fbinding))
         (already-gf (and gf (typep gf 'standard-generic-function))))
    (when already-gf
      (cerror "Replace it with a function"
              "~S is a generic function" name))))
  (record-source-file name 'function)
  (if (not (%defun-encapsulated-maybe name named-fn))
    (fset name named-fn))
  (set-function-info name info)
  (when *fasload-print* (format t "~&~S~%" name))
  name)

; end of l0-def.lisp
