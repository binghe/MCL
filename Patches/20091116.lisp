
(in-package :ccl)

;;; it had required an initial access keyword

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))
  
  (defmacro with-package-iterator ((mname package-list &rest other-types)
                                   &body body)
    (setq mname (require-type mname 'symbol))
    (let ((state (make-symbol "WITH-PACKAGE-ITERATOR_STATE"))
          (types 0))
      (declare (fixnum types))
      (dolist (type other-types)
        (case type
          (:external (setq types (bitset $pkg-iter-external types)))
          (:internal (setq types (bitset $pkg-iter-internal types)))
          (:inherited (setq types (bitset $pkg-iter-inherited types)))
          (t (%badarg type '(member :internal :external :inherited)))))
      `(let ((,state (%cons-pkg-iter ,package-list ',types)))
         (declare (dynamic-extent ,state))
         (macrolet ((,mname () `(funcall (%svref ,',state #.pkg-iter.state) ,',state)))
           ,@body))))
  )
