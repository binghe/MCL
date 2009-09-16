(in-package :ccl)
;; subset just does the compare/merge to file item in the tools menu
(defparameter *user-initials* (machine-owner))
; called by merge-files
(defun pathname-project-p (path)(declare (ignore path)) nil)
(defun project-file-local-state (project path)(declare (ignore project path)) nil)
(defun file-checkout-or-modro (path) (declare (ignore path)) nil) ;; ??
(let ((files 
       '("ccl:Sourceserver;compare-buffers.lisp"
         ;"ccl:Sourceserver;mpw-command.lisp"         
         "ccl:sourceserver;compare.lisp"
         "ccl:sourceserver;find-folder.lisp"
         ;"ccl:sourceserver;projector-ui.lisp"
         "ccl:sourceserver;merge.lisp"
         "ccl:sourceserver;read-only.lisp"
         ;"ccl:sourceserver;sourceserver-command.lisp"
         "ccl:sourceserver;ui-utilities.lisp"
         )))
  (dolist (f files)(compile-load f)))
(provide :sourceserver-subset)