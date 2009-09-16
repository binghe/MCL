;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  5 9/4/96   akh  pathnamep moves to l1-files
;;  4 6/7/96   akh  dont remember
;;  3 5/20/96  akh  bootstrapping defs for builtin-typep, class-cell-find-class etc.
;;  2 10/6/95  gb   EQUAL, other changes.
;;  (do not edit before this line!!)


;;; 09/07/96  gb  move pathnamep back here - it's called too early.

;; Non-portable type-predicates & such.


;; bootstrapping defs - real ones in l1-typesys, l1-clos, sysutils

(defun find-builtin-cell (type &optional create)
  (declare (ignore create))
  (cons type nil))

(defun find-class-cell (type create?)
  (declare (ignore create?))
  (cons type nil))

(defun builtin-typep (form cell)
  (typep form (car cell)))

(defun class-cell-typep (arg class-cell)
  (typep arg (car class-cell)))

(defun class-cell-find-class (class-cell errorp)
  (declare (ignore errorp)) ; AARGH can't be right
  ;(dbg-paws #x100)
  (let ((class (cdr class-cell)))
    (or class 
        (if  (fboundp 'find-class)
          (find-class (car class-cell) nil)))))

(defun %require-type-builtin (form foo)
  (declare (ignore foo))
  form)

(defun %require-type-class-cell (form cell)
  (declare (ignore cell))
  form)
  
(defun non-nil-symbol-p (x)
  (if (symbolp x) x))



(defun pathnamep (thing)
  (or (istruct-typep thing 'pathname) (istruct-typep thing 'logical-pathname)))



(defun compiled-function-p (form)
  (and (functionp form)
       (not (logbitp $lfbits-trampoline-bit (the fixnum (lfun-bits form))))))














; all characters are no longer base-characters.
(defun extended-character-p (c)
  (if (characterp c)
    (not (base-character-p c))))



    






















