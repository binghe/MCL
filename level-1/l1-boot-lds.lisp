;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: l1-boot-lds.lisp,v $
;;  Revision 1.5  2004/09/01 19:50:49  svspire
;;  Don't load the designated init file on bootup of a development system if the shift key is down. Makes the rebuild process much easier.
;;
;;  Revision 1.4  2003/12/08 08:35:11  gtbyers
;;  Claim that *LISP-CAN-HANDLE-ERRORS* after listener banner prints.
;;
;;  10 1/22/97 akh  dont remember
;;  9 10/3/96  akh  queue-fixup for arglist-on-space, startup-finished -> l1-readloop.lisp (for MCL-AppGen)
;;  6 3/27/96  akh  probably no change
;;  3 11/9/95  akh  maybe no change
;;  2 10/17/95 akh  merge patches
;;  7 5/8/95   akh  make initialization-output do window show cursor in stream-tyo
;;  6 4/28/95  akh  startup-ccl does window-show-cursor of initialization-output
;;  5 4/24/95  akh  added a comment
;;  3 4/6/95   akh  bind *eval-queue* in startup-ccl
;;  (do not edit before this line!!)


; l1-boot-lds.lisp
; Copyright 1995-2000 Digitool, Inc.

(in-package :ccl)

; Modification History
;
; 08/20/98 akh   startup-ccl does *query-io* too
; 08/20/96 bill  make-mcl-listener-process binds *listener-p* true so that
;                (method initialize-window :after (listener)) will know it is a listener process.
; -------------  4.0b1
; 05/23/96 bill  startup-ccl disables *load-verbose* while loading the init file.
;                This prevents the "Initialization Output" window from appearing.
; 05/02/96 bill  startup-ccl binds *eval-queue* to its global value (and clears the global value).
; 03/06/96 bill  (load-preferences-file) in startup-ccl
; 11/15/95 bill  If you save-application from the boot-init file, *initialization-output*
;                gets left set. Don't try to write to it if it has no wptr.
;  6/08/95 slh   bye-bye beta notice
;  4/16/95 slh   make-mcl-listener-process: added beta notice

(queue-fixup 
 (setq *arglist-on-space* t))


; make eval-enqueue work in an init file.
; set up stuff so that if an init file prints, the user will be less confused.
; Print to a fred-window called "initialization output" instead of creating
; a 0'th dead listener.

(defvar *initialization-output* nil)

(defun *initialization-output* ()
  (let ((io *initialization-output*))
    (when io
      (if (wptr io)
        io
        (setq *initialization-output* nil)))))

(defclass initialization-output-stream (output-stream)())

(defun init-stream () 
  (or (*initialization-output*)
      (setq *initialization-output*
            (make-instance 'fred-window 
              :window-title "Initialization Output"  ; or Init File Output?
              :scratch-p t))))

(defmethod  stream-tyo ((stream initialization-output-stream) char)
  (let ((stream (init-stream)))
    (stream-tyo stream char)
    (if (char-eolp char)
      (window-show-cursor stream))))

(defmethod stream-force-output ((stream initialization-output-stream))
  (let ((io (*initialization-output*)))
    (when io (stream-force-output io))))

; in case the init file does pprint, define these
(defmethod stream-column ((stream initialization-output-stream))
  (stream-column (init-stream)))

(defmethod stream-line-length ((stream initialization-output-stream))
  (stream-line-length (init-stream)))

; Bootstrapping. Real version is in "ccl:lib;ccl-menus-lds.lisp"
(unless (fboundp 'load-preferences-file)
  (%fhave 'load-preferences-file (nfunction load-preferences-file (lambda ()))))

; NOTE: this function gets re-entered when making a swapping image!
(defun startup-ccl (&optional init-file)
  (unwind-protect
    (let ((file-list (finder-parameters)) 
          loaded)
      (with-simple-restart (abort "Abort startup.")
        (load-preferences-file)
        (when 
          (and (eq (car file-list) :open)
               (dolist (f (cdr file-list) loaded)
                 (when (open-application-document *application* f t)
                   (setq loaded t))))
          (setq init-file nil))
        (when *arglist-on-space*
          (when (open-doc-string-file nil nil)
            (maybe-load-help-map)))
        (when (and init-file (not (shift-key-p)))
          (let ((old-output *standard-output*)
                (old-tio *terminal-io*)
                (old-query-io *query-io*)
                (old-error-output *error-output*)
                (*eval-queue* (prog1 *eval-queue* (setq *eval-queue* nil))))
            ; should do terminal-io too
            (unwind-protect
              (progn            
                (when (typep old-output 'terminal-io)
                  ; if its not the normal thing, assume user knows what he is doing.
                  (setq *standard-output* (make-instance 'initialization-output-stream))
                  (when (typep old-tio 'terminal-io)
                    (setq *terminal-io* *standard-output*))
                  (when (typep old-error-output 'terminal-io)
                    (setq *error-output* *standard-output*)))
                  (when (typep old-query-io 'terminal-io)
                    (setq *query-io* *standard-output*))
                  
                (with-simple-restart (continue "Skip loading init file.")
                  (load init-file :if-does-not-exist nil :verbose nil))              
                (while *eval-queue*
                  (eval-next-queued-form)))
              (let ((init-out (*initialization-output*)))
                (when (and init-out (wptr init-out))
                  (stream-force-output init-out)  ; both needed? maybe not.
                  (window-show-cursor init-out)))
              (when (typep *standard-output* 'initialization-output-stream)
                ; restore unless initfile set it to something else
                (setq *standard-output* old-output))
              (when (typep *terminal-io* 'initialization-output-stream)
                  (setq *terminal-io* old-tio))
              (when (typep *error-output* 'initialization-output-stream)
                  (setq *error-output* old-error-output))
              (when (typep *query-io* 'initialization-output-stream)
                (setq *query-io* old-query-io))
                
              ; let her be gc'd
              (setq *initialization-output* nil)
              )))
        (when (eq (car file-list) :print)
          (dolist (f (cdr file-list))
            (when (eq :text (mac-file-type f))
              (print-application-document *application* f t))))
        #+no
        (unless t *inhibit-greeting* 
                (format t "~&Welcome to ~A ~A!~%"
                        (lisp-implementation-type) (lisp-implementation-version)))
        ))
    (startup-finished)))

#| ; to l1-readloop
(defun startup-finished ()
  (setq *event-mask* #$everyEvent))
|#

(defun make-mcl-listener-process ()
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
                              (format t "~&Welcome to ~A ~A!~%"
                                      (lisp-implementation-type)
                                      (lisp-implementation-version)))
                            (setq *lisp-can-handle-errors* t)   ; I'll believe it when I see it.
                            #+carbon-compat (check-carbonlib-version) ;; surely there is a better place to do this
                            (toplevel-loop))))
    (process-enable p)
    p))


; End of l1-boot-lds.lisp
