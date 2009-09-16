;;;-*- Mode: Lisp; Package: CCL -*-

;; $Log: vfunc.lisp,v $
;; Revision 1.2  2002/11/18 05:37:01  gtbyers
;; Add CVS log marker
;;

(in-package "CCL")

(eval-when (:compile-toplevel :execute)
  (require "DLL-NODE" "ccl:compiler;ppc;dll-node"))

(defstruct (vfunc (:constructor %make-vfunc))
  afunc
  vregs
  lambda-blocks
  body-blocks
  generated-labels
  defined-labels
  active-vcode-list
)

(defun make-vfunc (afunc)
  (%make-vfunc :afunc afunc
               :lambda-blocks (make-dll-header)
               :body-blocks (make-dll-header)))

(defvar *current-vfunc*)

(defun new-vreg (v)
  (push v (vfunc-vregs *current-vfunc*))
  v)


(defstruct (label (:include dll-node))
  gen-num
  def-num
  id
  address
  refs                                  ; unordered list of vinsns
)

(defstruct (annotation (:include dll-node))
  type
  info)

(defmethod print-object ((l label) stream)
  (print-unreadable-object (l stream :type t)
    (let* ((handle (or (label-id l)
                       (label-gen-num l)
                       (label-def-num l))))
      (if handle (format stream "~s" handle))
      (let* ((address (label-address l)))
        (if address (format stream " @~d") address)))))

(defun gen-label (&optional id)
  (let* ((gens (vfunc-generated-labels *current-vfunc*))
         (lab (make-label :id id :gen-num (length gens))))
    (setf (vfunc-generated-labels *current-vfunc*) (cons lab gens))
    lab))

(defun emit-label (b l)
  (let* ((emitted (vfunc-defined-labels *current-vfunc*)))
    (when (member l emitted :test #'eq)
      (error "Label ~s has already been defined."))
    (setf (label-def-num l) (length emitted)
          (vfunc-defined-labels *current-vfunc*) (cons l emitted))
    (append-dll-node l b)
    l))

; Info will be filled-in by the backend, presumably.
(defun emit-annotation (b type &optional info)
  (let* ((note (make-annotation :type type :info info)))
    (append-dll-node note b)
    b))
