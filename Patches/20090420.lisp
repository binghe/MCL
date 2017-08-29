;;; -*- Package: ccl; -*-

(in-package :ccl)

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))
  (defun directory-pathname-p (path)
    (let ((name (pathname-name path))(type (pathname-type path)))
      (and  (or (null name) (eq name :unspecific) (%izerop (length name)))
            (or (null type) (eq type :unspecific)))))

  )
