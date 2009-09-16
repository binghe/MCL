;;;-*- Mode: Lisp; Package: CCL -*-

;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;; Compile this file to make a fasloadable copy the %source-files% hash
;; table.

(in-package :ccl)

(eval-when (:compile-toplevel :execute)
  (let ((*record-source-file* nil))

    (defmacro source-files-list ()
      (let ((method-marker (list 'method-marker))
            res)
        (labels ((replace-methods (x marker)
                   (if (atom x)
                     (if (typep x 'method)
                       (list* method-marker
                              (method-qualifiers x)
                              (mapcar #'(lambda (x)
                                          (and (typep x 'class) (class-name x)))
                                      (method-specializers x)))
                       x)
                     (cons (replace-methods (car x) marker)
                           (replace-methods (cdr x) marker)))))
          (maphash #'(lambda (key value)
                       (push (cons key (replace-methods value method-marker))
                             res))
                   %source-files%)
          `',(cons method-marker res))))

    )
)

; Add the "ccl:l1;" logical pathname
(unless
  (dolist (trans (logical-pathname-translations "ccl"))
    (when (equalp (pathname (car trans)) (pathname "ccl:l1;**;*.*"))
      (return t)))
  (add-logical-pathname-translation "ccl" '("l1;**;*.*" "ccl:level-1;**;*.*")))

; The record-source-file data structure is too complex.
(let* ((*warn-if-redefine* nil)
       (defs (source-files-list))
       (method-marker (pop defs)))
  (labels ((restore-method (x name)
             (if (and (listp x) (eq (car x) method-marker))
               (destructuring-bind (qualifiers . specializers) (cdr x)
                 (ignore-errors
                  (find-method (fboundp name) qualifiers
                               (mapcar 'find-class specializers))))
               x))
           (restore-methods (x name)
             (if (and (consp x) (eq x (setq x (restore-method x name))))
               (cons (restore-methods (car x) name)
                     (restore-methods (cdr x) name))
               x)))
    (dolist (def defs)
      (destructuring-bind (name . defs) def
        (labels ((foo (name defs)
                   (if (or (listp name) (gethash name %source-files%))
                     (if (atom defs)
                       (record-source-file name 'function defs)
                       (dolist (types defs)
                         (destructuring-bind (type . defs) types
                           (cond ((eq type 'setf)
                                  (foo `(setf ,name) defs))
                                 ((eq type 'method)
                                  (dolist (def defs)
                                    (destructuring-bind (m . files) def
                                      (when (typep (setq m (restore-method m name)) 'method)
                                        (if (atom files)
                                          (record-source-file m 'method files)
                                          (dolist (file files)
                                            (record-source-file m 'method file)))))))
                                 (t
                                  (if (atom defs)
                                    (record-source-file name type defs)
                                    (dolist (def defs)
                                      (record-source-file name type def))))))))
                     (setf (gethash name %source-files%)
                           (restore-methods defs name)))))
          (foo name defs))))))
