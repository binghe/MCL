;; Include revision in greeting.;; Terje Norderhaug, December 2010(in-package :ccl)(let ((*WARN-IF-REDEFINE-KERNEL* nil)      (*warn-if-redefine* nil))(defun make-mcl-listener-process ()
  (let ((p #+ppc-target
           (make-process *main-listener-process-name* :background-p t
                         :stack-size (truncate (* 4/3 *listener-process-stackseg-size*))
                         :vstack-size *listener-process-stackseg-size*
                         :tstack-size (ceiling *listener-process-stackseg-size* 3))
           #-ppc-target
           (make-process *main-listener-process-name* :background-p t
                         :stack-size  *listener-process-stackseg-size*)))
                         
    (process-preset p #'(lambda ()
                          (let ((*listener-p* t))
                            (unless *inhibit-greeting* 
                              (format t "~&Welcome to ~A ~A-~A!~%"
                                      (lisp-implementation-type)
                                      (lisp-implementation-version)                                      *mcl-revision*))
                            (setq *lisp-can-handle-errors* t)   ; I'll believe it when I see it.
                            #+carbon-compat (check-carbonlib-version) ;; surely there is a better place to do this
                            (toplevel-loop))))
    (process-enable p)
    p))) ; end redefine; (make-mcl-listener-process)