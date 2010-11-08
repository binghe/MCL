(in-package :ccl)(dolist (file (directory (merge-pathnames "*.lisp" (loading-file-source-file))))  (unless (equal (full-pathname file)                 (full-pathname (loading-file-source-file)))    (load file))); #p"home:Level-0;l0-init.lisp"(add-feature :mcl-6.0); #p"home:Level-1;l1-boot-1.lisp"(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* NIL))
(defun lisp-implementation-version ()
  "Version 6.0")) ; end redefine(provide :mcl6)
