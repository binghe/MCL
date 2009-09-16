;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  6 10/3/96  slh  declaim ftype
;;  2 4/24/96  akh  3.0 version was more modern
;;  (do not edit before this line!!)


;; hide-listener-support.lisp - support error-handler option to save-application
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995 Digitool, Inc. The 'tool rules!

;; Modification History
;
;  9/25/96 slh   keep-trying: report stack group; use declaim ftype
;  8/22/96 slh   keep-trying: pass stack group to logger
;  8/21/96 slh   keep-trying: better formatting
;  8/10/96 slh   show loading file(s) in error message
;  8/01/96 slh   "Log To File" button; (throw :toplevel) -> (toplevel)
;  7/11/96 slh   use new *error-dialog-size*
;  7/05/95 slh   error-modes-alist here
;  6/27/95 slh   :listener = :dialog if not LDS
;  4/21/95 slh   simplified make-application-error-handler mechanism
;  4/18/95 slh   *application-name* -> current-app-name fn
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
;  3/08/95 slh   use *application-name*; various fixes
;      ?    ?    support for error-handler option to save-application
; 05/02/93 alice rip out lots of stuff. Modify for processes and application class


(in-package :ccl)

(eval-when (:execute :compile-toplevel :load-toplevel)
  (require :icon-dialog-item))

(defconstant error-modes-alist '((:listener . "Listener")
                                 (:dialog . "Dialog")
                                 (:quit . "Quit Dialog")
                                 (:quit-quietly . "Quit Quietly")))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; stuff for extended save-application

(defvar *app-error-handler-mode* :quit)

(defun make-application-error-handler (app option)
  (declare (ignore app))
  (setq *app-error-handler-mode* option))

(let ((*warn-if-redefine-kernel* nil)
      (*warn-if-redefine* nil))
  (defmethod application-error ((a application) condition error-pointer)
    (case *app-error-handler-mode*
      (:dialog (keep-trying condition))
      ; we need MCL menubar or can't do command-. or command-/
      (:listener
       (lds
        (let ((mb (menubar)))
          (unwind-protect
            (progn
              (set-menubar *default-menubar*)
              (break-loop-handle-error condition error-pointer))
            (set-menubar mb)))
        (keep-trying condition)))
      (:quit (quit-notice))
      (:quit-quietly (quit))
      ))
  )


(defun quit-notice ()
  ; command-. lets one escape from message-dialog
  ; The unwind protect assures that we always quit
  (unwind-protect
    ; it would be cool to quit after 2 minutes
    (modal-dialog
     (make-instance 'keystroke-action-dialog
       :window-type :movable-dialog
       :window-title "Error"
       :window-show t
       :view-position '(:top 100)
       :view-size  #@(339 139)
       :view-font '("Chicago" 12 :SRCOR :PLAIN)
       :view-subviews
       (list
        (make-dialog-item 'icon-dialog-item
                          #@(22 18)
                          #@(50 50)
                          ""
                          nil
                          :icon *stop-icon*)
        (make-dialog-item 'static-text-dialog-item
                          #@(94 18)
                          #@(217 98)
                          (format nil "A fatal error has occurred in application \"~A\"."
                                  (current-app-name)))
        (make-dialog-item 'button-dialog-item
                          #@(241 108)
                          #@(62 18)
                          "Quit"
                          #'(lambda (item)
                              (declare (ignore item))
                              (return-from-modal-dialog :quit))
                          :default-button t))))
    (quit)))

(defvar *error-dialog-size* #@(400 400))

(eval-when (:execute :compile-toplevel)
  (declaim (ftype (function (&rest t) t) log-application-error)))

(defun keep-trying (c &optional quit-only &aux what)  
  (unwind-protect
    (setq what (let ((dialog-w (point-h *error-dialog-size*))
                     (dialog-h (point-v *error-dialog-size*))
                     (sg *current-stack-group*))
                 (modal-dialog
                  (make-instance 'keystroke-action-dialog
                    :window-type :movable-dialog
                    :window-title "Error Notice"
                    :window-show t
                    :view-position '(:top 100)
                    :view-size  *error-dialog-size*
                    :view-font '("Chicago" 12 :SRCOR :PLAIN)
                    :view-subviews
                    `(,(make-dialog-item 'icon-dialog-item
                                         #@(22 18)
                                         #@(32 32)
                                         ""
                                         nil
                                         :icon *warn-icon*)
                      ,(make-dialog-item 'static-text-dialog-item
                                         #@(94 18)
                                         (make-point (- dialog-w 122)
                                                     (- dialog-h 42))
                                         (with-output-to-string (s)
                                           (format s "Error: ~A~%In stack group: ~S~%" c sg)
                                           (when *loading-files*
                                             (format s "~&While loading file ~S~{, inside ~S~}."
                                                     (car *loading-files*)
                                                     (cdr *loading-files*)))
                                           #+nah ; ugly
                                           (let ((*debug-io* s))
                                             (print-call-history :detailed-p nil))))
                      ,(make-dialog-item 'button-dialog-item
                                         (make-point (- dialog-w 198)
                                                     (- dialog-h 31))
                                         #@(62 18)
                                         "Quit"
                                         #'(lambda (item)
                                             (declare (ignore item))
                                             (return-from-modal-dialog :quit))
                                         :default-button nil)
                      ,@(unless quit-only
                          `(,(make-dialog-item 'button-dialog-item
                                               (make-point (- dialog-w 98)
                                                           (- dialog-h 31))
                                               #@(62 18)
                                               "OK"
                                               #'(lambda (item)
                                                   (declare (ignore item))
                                                   (return-from-modal-dialog :cancel))
                                               :default-button t)
                            ,@(if (fboundp 'log-application-error)
                                `(,(make-dialog-item 'button-dialog-item
                                                     (make-point (- dialog-w 318)
                                                                 (- dialog-h 31))
                                                     #@(82 18)
                                                     "Log To File"
                                                     #'(lambda (item)
                                                         (declare (ignore item))
                                                         (log-application-error *application* c
                                                                                :acknowledge t
                                                                                :stack-group sg)
                                                         (return-from-modal-dialog :cancel))))))))))))
    (if (eq what :quit)
      (quit)
      (toplevel))))

; End of hide-listener-support.lisp
