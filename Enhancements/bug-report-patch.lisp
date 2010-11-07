;; Customize the MCL bug report to avoid bothering Digitool
;; Terje Norderhaug, february 2010

(in-package :ccl)

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))

; ripped from MCL 5.2
(defun create-bug-report (&optional (process (process-to-restart "Bug Report for Process")))
  (when process
    (eval-enqueue #'(lambda ()
                      (let* ((w (make-instance
                                  'fred-window :scratch-p t
                                  
                                  :window-title "Bug Report"))
                             (item (fred-item w))
                             (*debug-io* item))
                        (format item " ---------------- cut here --------------~%")
                        (without-interrupts
                         (format item "~%~a"
                                 (hc-current-date-str))
                         (format item "~&~%Describe the problem, including how to reproduce it if you can:~%~%~%")
                         (config-info item)
                         (fred-update w)
                         (format item "~%~%")
                         (let ((condition (symbol-value-in-process '*break-condition* process))
                               (dialogs (symbol-value-in-process '*backtrace-dialogs* process))
                               (error-pointer nil)
                               (frame-number 0)
                               (sg (process-stack-group process)))
                           (if (and condition
                                      (typep condition 'serious-condition)
                                      (vectorp (car dialogs))
                                      (> (length (car dialogs)) 2)
                                      (setq error-pointer (elt (car dialogs) 1)))
                             (let ((*error-output* item))
                               (%break-message "Error" condition error-pointer)
                               (format item "~%"))
                             (when condition
                               (format item "~&~A: ~A~&~%" (type-of condition) condition)))
                           (format item "Backtrace:~%~%")
                           (when error-pointer
                             (let ((p (%get-frame-ptr)))
                               (loop
                                 (when (eql p error-pointer)
                                   (return))
                                 (when (null p)
                                   (setq frame-number 0)
                                   (return))
                                 (setq p (parent-frame p sg))
                                 (incf frame-number))))
                           (print-call-history :stack-group sg :start-frame frame-number)
                           (fred-update w))))))))

)