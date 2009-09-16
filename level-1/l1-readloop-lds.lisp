;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  3 10/5/97  akh  see below
;;  11 1/22/97 akh  print-listener-prompt updates edit-menu iff disabled.
;;  10 10/3/96 akh  find-restart-in-process to l1-readloop
;;  3 10/17/95 akh  merge patch to print-listener-prompt
;;  2 10/13/95 bill ccl3.0x25
;;  12 5/23/95 akh  add a comment
;;  11 5/22/95 akh  close restart windows when closing backtrace window
;;                  Add application-eval-enqueue method
;;                  Make eval-enqueue work from modal dialog
;;  5 4/10/95  akh  fboundp => boundp in eval-enqueue
;;  3 4/6/95   akh  make eval-enqueue work in init file
;;  (do not edit before this line!!)


; l1-readloop-lds.lisp
; Copyright 1995-1999 Digitool, Inc. 

; Modification History
;
; 07/15/99 akh break-loop prints a message about modal-dialog-on-top on exit.
; ----------- 4.3f1c1
; 07/10/99 akh break-loop enables menus if modal dialog was on top.
;; ---------- 4.3b3
; 05/10/98 akh   break-loop looks at (caar old-modal) vs (car ..)
; 09/25/97 akh    Application-eval-enqueue ((app lisp-development-system) - just do it if no listener
; 03/04/97 bill  break-loop ensures that the backtrace-info vector
;                does not have any null stack frame entries.
; 01/15/97 bill  %break-message unconditionally binds *signal-printing-errors* to NIL.
; 11/19/96 bill  slh's change to cbreak-loop to stop it from
;                popping up an empty listener when *autoclose-inactive-listeners*
;                it true.
; 12/09/96 akh  print-listener-prompt updates edit-menu iff disabled.
; -------------  4.0
;;<end of added text>
; 07/20/96 bill  dummy definitions of databases-locked-p & funcall-with-databases-unlocked.
;                Real definition of with-databases-unlocked.
;                Add database lock detection to break-loop.
; 06/04/96 bill  in read-loop - Initial binding of *eval-queue* comes from global value.
; -------------  MCL-PPC 3.9
; 04/01/96 bill  interactive-break binds *interrupt-level* to 0 to avoid
;                confusing break loop message.
; 01/17/96 gb    bind *interrupt-level* to 0 vice 2.
; 01/16/96 bill  on the PPC, break-loop-handle-error doesn't do parent-frame
;                before passing the error-pointer to break-loop.
; 12/05/95 bill  break-loop sets *error-reentry-count* to 0.
; 10/11/95 bill  %break-message doesn't print the standin event processor
;                if no standin event processor was created.
;                read-loop sets *processing-events* to NIL if it is non-NIL
;                and the current process is the event processor.
;                toplevel-loop continues throwing to the real toplevel
;                if the current process is the initial process.
;  6/08/95 slh   help-specs
;  5/05/95 slh   break-loop: "is no longer" -> "may no longer be" (because a
;                break-on-signal loop can exit on cmd-/ to a break-on-error loop)
;                "Dead" -> "inactive"; added *autoclose-inactive-listeners*
;                %break-message: space after prefix char
;  4/26/95 slh   toplevel-read: bail out of process if listener is unuseable
;                break-loop: check for listener process in unwind-cleanup
;  4/24/95 slh   break: obey *break-loop-when-uninterruptable*
;  4/18/95 slh   require inspector done inline
;  4/05/95 slh   select-backtrace: require 'new-backtrace

(in-package :ccl)

(defmethod Application-eval-enqueue ((app lisp-development-system) form)
  (let ((p (find-top-live-listener-process)))
    (if (eq p *current-process*)
      (setq *eval-queue* (nconc *eval-queue* (cons form nil)))
      (if p
        (progn 
          (setf (symbol-value-in-process '*eval-queue* p)
                (nconc (symbol-value-in-process '*eval-queue* p) (cons form nil))))
        (call-next-method)))))

  
#|
(defun eval-enqueue (form)
  (let ((p (find-top-live-listener-process)))
    (if p
      (progn 
        (setf (symbol-value-in-process '*eval-queue* p)
              (nconc (symbol-value-in-process '*eval-queue* p) (cons form nil))))
      (if (boundp '*eval-queue*)
        (setq *eval-queue* (nconc *eval-queue* (cons form nil)))
        ; else do nothing??
        ; or application-eval-enqueue *ap form
        (if (functionp form)(funcall form)
            (if (and (consp form)(functionp (car form)))
              (apply (car form) (cdr form))
              (eval form)))))))
|#

#| ; to l1-readloop
(defun find-restart-in-process (name p)
  (without-interrupts
   (let ((restarts (symbol-value-in-process '%restarts% p)))
     (dolist (cluster restarts)
       (dolist (restart cluster)
         (when (and (or (eq restart name) (eq (restart-name restart) name)))
           (return-from find-restart-in-process restart)))))))
|#

(defun continuable-process-p ()
  (without-interrupts
   (dolist (p *active-processes*)
     (let ((sg (process-stack-group p)))
       (when (symbol-value-in-stack-group '*continuablep* sg)
         (return p))))))

(defun continuable-processes ()
  (without-interrupts
   (let ((result))
     (dolist (process *active-processes*)
         (when  (symbol-value-in-process '*continuablep* process)
           (push process result)))
     result)))

; this isnt quite right but requiring *in-read-loop* isnt right either.
(defun restartable-process-p ()
  (without-interrupts
   (dolist (p *active-processes*)
     (when (neq 0 (symbol-value-in-process '*break-level* p))
       (return p)))))

(defun restartable-processes ()
  (without-interrupts
   (let ((result))
     (dolist (process *active-processes*)
       (when (neq 0 (symbol-value-in-process '*break-level* process))
         (push process result)))
     result)))

(defun process-to-continue ()
  (let ((ps (continuable-processes)))
    (case (length ps)
      (0 nil)
      (1 (car ps))
      (t (let ((p (catch-cancel (select-item-from-list ps :window-title "Continue Process"))))
           (if (neq p :cancel) (car p)))))))

(defun process-to-restart (&optional (string "Restart Process"))
  (let ((ps (restartable-processes)))
    (case (length ps)
      (0 nil)
      (1 (car ps))
      (t (let ((p (catch-cancel (select-item-from-list ps :window-title string))))
           (if (neq p :cancel) (car p)))))))


(defun interactive-break ()
  (let* ((w (front-window))
         (p (if w (window-process w))))
    (when (or (not p)(neq p *current-process*)) (setq p (process-to-abort "Break in Process")))
    (if p (process-interrupt p 
                             #'(lambda ()
                                 (let ((*interrupt-level* 0))
                                   (break)))))))

(defun toplevel-loop ()
  (loop
    (if (eq (catch :toplevel 
              (read-loop 0)) $xstkover)
      (format t "~&;[Stacks reset due to overflow.]")
      (when (eq *current-process* *initial-process*)
        (toplevel)))))

;This is the part common to toplevel loop and inner break loops.
(defun read-loop (level)
  (declare (resident))
  "Never returns"
  (when (and *processing-events*
             (eq *current-process* *event-processor*))
    (setq *processing-events* nil))
  (if *listener-p*
    (read-loop-internal level)
    (let ((*listener-p* t)
          (*eval-queue* (prog1 *eval-queue* (setq *eval-queue* nil))))
      (unwind-protect
        (read-loop-internal level)
        (when (and *eval-queue*
                   (y-or-n-dialog "Evaluate queued forms before exiting?"
                                  :cancel-text nil))
          (loop
            (unless *eval-queue* (return))
            (eval-next-queued-form)))))))

(defun eval-next-queued-form ()
  (with-non-background-process
    (let ((thing (pop *eval-queue*)))
      (if (functionp thing)(funcall thing)
          (if (and (consp thing)(functionp (car thing)))
            (apply (car thing) (cdr thing))
            (eval thing))))))

(defun read-loop-internal (level)
  (let* ((*break-level* level)
         (*last-break-level* level)
         *loading-file-source-file*
         *in-read-loop*
         (*listener-p* t)
         *** ** * +++ ++ + /// // / -
         form)
    (loop
      (restart-case
        (catch :abort ;last resort...
          (loop
            (catch-cancel
              (loop
                (when *eval-queue*
                  (eval-next-queued-form))
                (setq *loading-file-source-file* nil
                      *in-read-loop* nil
                      *break-level* level)
                (setq form (toplevel-read))
                (unless (eq form *eof-value*)
                  (with-non-background-process
                    (toplevel-print
                     (toplevel-eval form))))))
            (format *terminal-io* "~&Cancelled")))
        (abort () :report (lambda (stream)
                            (if (eq level 0)
                              (format stream "Return to toplevel.")
                              (format stream "Return to break level ~D." level)))
               #| ; Handled by interactive-abort
                ; go up one more if abort occurred while awaiting/reading input               
                (when (and *in-read-loop* (neq level 0))
                  (abort))
                |#
               )
        (abort-break () 
                     (unless (eq level 0)
                       (abort))))
      (setq *eval-queue* nil)
      (clear-input *terminal-io*)
      (format *terminal-io* "~&Aborted"))))

;Read a form from *terminal-io*, unless something appears on *eval-queue*
;in which case immediately return *eof-value*.

(defun toplevel-read ()
  (declare (resident))
  (let* ((*in-read-loop* t) 
         (shown-idle-p nil)
         (listener (current-listener)))
    (if (slot-boundp listener 'read-mark)       ; slot will cause error if closed
      (let ((wait-function #'(lambda () (stream-listen listener))))
        (declare (dynamic-extent wait-function))
        (unwind-protect
          (with-background-process
            (loop
              (when *eval-queue* (return *eof-value*))
              (force-output *terminal-io*)
              (event-poll)
              (print-listener-prompt)
              (when (process-wait-with-timeout "Input" 10 wait-function)
                (let* ((*in-read-loop* nil)  ;So can abort out of buggy reader macros...
                       (form))
                  (catch '%re-read
                    (set-mark (listener-start-mark listener)
                              (listener-read-mark listener))
                    (unless (eq (setq form (read listener nil *eof-value*)) *eof-value*)
                      (let ((ch)) ;Trim whitespace
                        (while (and (listen listener) (whitespacep (setq ch (tyi listener))))
                          (setq ch nil))
                        (when ch (untyi ch listener)))
		      (when *listener-indent* 
                        (stream-tyo listener #\space)
                        (stream-tyo listener #\space))
                      (return (process-single-selection form))))))
              (unless shown-idle-p
                (setq shown-idle-p t)
                (set-mini-buffer listener "~&Idle"))))
          (when shown-idle-p ;Somebody else should really do this...
            (set-mini-buffer listener "~&Busy"))))
      (let ((p (window-process listener)))
        (process-disable p)
        (throw (process-reset-tag p) t)))))

;This doesn't close the stream, but then neither does it get closed in case
;of errors in preceeding selections, so it better be a stream that doesn't
;need closing anyhow...
(defun selection-eval (stream &optional single-selection? evalp)
 (let* ((package *package*)
        (*loading-file-source-file* (stream-pathname stream))
         (*package* (or (slot-value stream 'read-package) *package*))                          
         form values)
    (with-compilation-unit (:override t)
      (let ((env (new-lexical-environment (new-definition-environment 'eval))))
        (%rplacd (defenv.type (lexenv.parent-env env)) *outstanding-deferred-warnings*)
        (loop
          (setf (slot-value stream 'read-package) *package*)
          (setq form (read stream nil *eof-value*))
          (when (eq *eof-value* form) 
            (unless *verbose-eval-selection*
              (let ((*package* package))
                (toplevel-print values)))
            (return values))
          (when single-selection?
            (setq form (process-single-selection form)))
          (let ((old-package *package*))
            (setq values
                  (if evalp
                    (let ((*compile-definitions* (eq evalp :compile)))
                      (toplevel-eval form env))
                    (toplevel-eval form env)))
            (if (and single-selection? (neq old-package *package*))
              (buffer-putprop (buffer-mark stream) 'package *package*)))
          (when *verbose-eval-selection*
            (let ((*package* package))
              (toplevel-print values))))))))

(defvar *always-eval-user-defvars* nil)

(defun process-single-selection (form)
  (if (and *always-eval-user-defvars*
           (listp form) (eq (car form) 'defvar) (cddr form))
    `(defparameter ,@(cdr form))
    form))

(defun toplevel-eval (form &optional env &aux values)
   (declare (resident))
  (setq +++ ++ ++ + + - - form)
  (setq values (multiple-value-list (cheap-eval-in-environment form env)))
  values)

(defun toplevel-print (values)
  (declare (resident))
  (setq /// // // / / values)
  (setq *** ** ** * * (if (neq (%car values) (%unbound-marker-8)) (%car values)))
  (when values
    (fresh-line)
    (dolist (val values) (write val) (terpri))))

(defun print-listener-prompt (&optional force &aux temp)
    (when (or force
              (let ((l (current-listener)))
                (or (eq 0 (setq temp (buffer-position (listener-read-mark l))))
                    (neq (buffer-position (listener-prompt-mark l)) temp)))
              (neq *break-level* *last-break-level*))
      (let* ((*listener-indent* nil)
             (l (current-listener))
             (fred (fred-item l))
             (buf (fred-buffer fred)))                  
          (let ((pos (buffer-position  buf)))
            (fresh-line *terminal-io*)            
            (if (%izerop *break-level*)
              (%write-string "?" *terminal-io*)
              (format *terminal-io* "~s >" *break-level*))
            ; why needed? - Because stream-write-string provides font '(:plain)
            (when (neq #$smRoman (ff-script (buffer-char-font-codes buf)))
              (multiple-value-bind (ff ms)(buffer-empty-font-codes buf)
                (buffer-set-font-codes buf ff ms pos (buffer-position buf))))
            ) 
        (set-view-font fred '(:bold))
        (write-string " " *terminal-io*)        
        (let ((em (edit-menu)))
          (when (not (menu-enabled-p em))(menu-update em)))
        
        (setq *last-break-level* *break-level*)
        (set-mark (listener-prompt-mark l) 
                  (buffer-position (listener-read-mark l))))
      (force-output *terminal-io*)))

; You may want to do this anyway even if your application
; does not otherwise wish to be a "lisp-development-system"
(defmethod application-error ((a lisp-development-system) condition error-pointer)
  (break-loop-handle-error condition error-pointer))

(defun break-loop-handle-error (condition error-pointer)
  (multiple-value-bind (bogus-globals newvals oldvals) (%check-error-globals)
    (dolist (x bogus-globals)
      (set x (funcall (pop newvals))))
    (when (and *debugger-hook* *break-on-errors*)
      (let ((hook *debugger-hook*)
            (*debugger-hook* nil))
        (funcall hook condition hook)))
    (setq *eval-queue*        nil
          *processing-events* nil)
    (%break-message (error-header "Error") condition error-pointer)
    (let* ((s *error-output*))
      (dolist (bogusness bogus-globals)
        (let ((oldval (pop oldvals)))
          (format s "~&;  NOTE: ~S was " bogusness)
          (if (eq oldval (%unbound-marker-8))
            (format s "unbound")
            (format s "~s" oldval))
          (format s ", was reset to ~s ." (symbol-value bogusness)))))
    (if *break-on-errors*
      (break-loop condition
                  #-ppc-target (parent-frame error-pointer *current-stack-group*)
                  #+ppc-target error-pointer)
      (abort))))

(defun break (&optional string &rest args &aux (fp (%get-frame-ptr)))
  (flet ((do-break-loop ()
           (let ((c (make-condition 'simple-condition
                                    :format-string (or string "")
                                    :format-arguments args)))
             (cbreak-loop (error-header "Break") "Return from BREAK." c fp))))
    (cond ((%i> *interrupt-level* -1)
           (do-break-loop))
          (*break-loop-when-uninterruptable*
           (format *error-output* "Break while *interrupt-level* less than zero; binding to 0 during break-loop.")
           (let ((*interrupt-level* 0))
             (do-break-loop)))
          (t (format *error-output* "Break while *interrupt-level* less than zero; ignored.")))))

(defun invoke-debugger (&optional string &rest args &aux (fp (%get-frame-ptr)))
  (let ((c (condition-arg (or string "") args 'simple-condition)))
    (when *debugger-hook*
      (let ((hook *debugger-hook*)
            (*debugger-hook* nil))
        (funcall hook c hook)))
    (setq *eval-queue* nil)
    (%break-message "Debug" c fp)
    (break-loop c fp)))

(defun %break-message (msg condition error-pointer &optional (prefixchar #\>))
 #|
  (with-pstrs ((str "barf"))
    (#_debugstr str))
  (with-pstrs ((str msg))
    (#_debugstr str))
  (with-pstrs ((str "barf2"))
    (#_debugstr str))
  (with-pstrs ((str (format nil "~A" condition)))
    (#_debugstr str))
  (with-pstrs ((str "barf3"))
    (#_debugstr str))
  |#
  (maybe-create-standin-event-processor)
  (let ((*print-circle* *error-print-circle*)
        ;(*print-pretty* nil)
        (*print-array* nil)
        (*print-escape* t)
        (*print-gensym* t)
        (*print-length* nil)  ; ?
        (*print-level* nil)   ; ?
        (*print-lines* nil)
        (*print-miser-width* nil)
        (*print-readably* nil)
        (*print-right-margin* nil)
        (*signal-printing-errors* nil)
        (s (make-instance 'indenting-string-output-stream :indent-prefix prefixchar)))
    (when (and (eql 0 *break-level*)
               (eq *current-process* *initial-process*)
               (neq *current-process* *event-processor*))
      (format *error-output*
              "~&*** Break during event processing! Standin event processor created. ***~%~
                 **** Original event processor will continue when break loop exits. ****~%"))
    (format s "~A ~A: " prefixchar msg)
    (setf (slot-value s 'indent) (stream-column s))
    ;(format s "~A" condition) ; evil if circle
    (report-condition condition s)
    (if (not (and (typep condition 'simple-program-error)
                  (simple-program-error-context condition)))
      (format *error-output* "~&~A~%~A While executing: ~S~%"
              (get-output-stream-string s) prefixchar (%real-err-fn-name error-pointer))
      (format *error-output* "~&~A~%"
              (get-output-stream-string s)))
  (force-output *error-output*)))   ; returns NIL

(defun cbreak-loop (msg cont-string condition error-pointer)
  (let* ((*print-readably* nil))
    (%break-message msg condition error-pointer)
    (let ((eval-queue *eval-queue*))
      (setq *eval-queue* nil)
      (restart-case (break-loop condition error-pointer *backtrace-on-break*)
        (continue () :report (lambda (stream) (write-string cont-string stream))))
      (setq *eval-queue* eval-queue)
      (when (or *top-listener*
                (not (typep *error-output* 'pop-up-terminal-io)))
        (fresh-line *error-output*))
      nil)))

(defun warn (format-string &rest args)
  (let ((fp (%get-frame-ptr))
        (c (require-type (condition-arg format-string args 'simple-warning) 'warning)))
    (when *break-on-warnings*
      (cbreak-loop "Warning" "Signal the warning." c fp))
    (restart-case (signal c)
      (muffle-warning () :report "Skip the warning" (return-from warn nil)))
    (%break-message (if (typep c 'compiler-warning) "Compiler warning" "Warning") c fp #\;)
    ))

(declaim (notinline select-backtrace))

(defmacro new-backtrace-info (dialog youngest oldest stack-group)
  `(vector ,dialog ,youngest ,oldest ,stack-group nil))

(defun select-backtrace ()
  (declare (notinline select-backtrace))
  (require 'new-backtrace)
  (require :inspector)
  (select-backtrace))

(defvar *break-condition* nil "condition argument to innermost break-loop.")

(defvar *break-loop-when-uninterruptable* t)
(defvar *autoclose-inactive-listeners* nil)

(defun bt-child-windows (w)
  (view-get w :child-windows))

(eval-when (:compile-toplevel :execute :load-toplevel)

(unless (fboundp 'databases-locked-p)

; Redefined by Wood
(defun databases-locked-p (&optional by-locker)
  (declare (ignore by-locker))
  nil)

)  ; end of unless

(unless (fboundp 'funcall-with-databases-unlocked)

; Redefined by Wood
(defun funcall-with-databases-unlocked (thunk)
  (funcall thunk))

))  ; end of unless and eval-when

(defmacro with-databases-unlocked (&body body)
  (let ((thunk (gensym)))
    `(let ((,thunk #'(lambda () ,@body)))
       (declare (dynamic-extent ,thunk))
       (funcall-with-databases-unlocked ,thunk))))

(defvar %last-continue% nil)
(defun break-loop (condition frame-pointer
                             &optional (backtracep *backtrace-on-break*))
  "Never returns"
  (when (and (%i< *interrupt-level* 0) (not *break-loop-when-uninterruptable*))
    (abort))
  (let* ((dialog (new-backtrace-info
                  ()  
                  frame-pointer
                  (if *backtrace-dialogs*
                    (or (child-frame (bt.youngest (car *backtrace-dialogs*)) *current-stack-group*)
                        (last-frame-ptr))
                    (last-frame-ptr))
                  *current-stack-group*))
         (old-modal *modal-dialog-on-top*)
         window-queue-list)
    (setq *modal-dialog-on-top* nil)  ; Otherwise window-close below fails.
    ;(setq *eventhook* nil)
    (if old-modal (update-menus :enable *first-menustate*)(update-menus)) ;; <<
    (unwind-protect
      (let* ((%handlers% nil)           ; firewall
             (databases-locked-p (databases-locked-p *current-process*))
             (*break-condition* condition)
             (*eval-queue* nil)
             (*compiling-file* nil)
             (*backquote-stack* nil)
             (continue (find-restart 'continue))
             (*continuablep* (unless (eq %last-continue% continue) continue))
             (%last-continue% continue)
             (*backtrace-dialogs* (cons dialog *backtrace-dialogs*))
             (*standard-input* *debug-io*)
             (*standard-output* *debug-io*)
             (*interrupt-level* 0)
             (*signal-printing-errors* nil)
             (*read-suppress* nil)
             (*print-readably* nil))
        (setq window-queue-list (release-locked-windows))
        (with-databases-unlocked
          (with-cursor 'cursorhook
            (if *continuablep*
              (let* ((*print-circle* *error-print-circle*)
                     ;(*print-pretty* nil)
                     (*print-array* nil))
                (format t "~&> Type Command-/ to continue, Command-. to abort.
> If continued: ~A~%" continue))
              (format t "~&> Type Command-. to abort.~%"))
            (format t "~&See the RestartsÉ menu item for further choices.")
            (terpri)
            (when databases-locked-p
              (format t "> WARNING: The WOOD database lock was locked.~@
                           > Use caution or you might damage your database.~%"))
            (force-output)
            (when backtracep
              (select-backtrace))
            (clear-input *debug-io*)
            (setq *error-reentry-count* 0)        ; succesfully reported error
            (read-loop (1+ *break-level*)))))        
      (relock-windows window-queue-list)
      (let ((w (bt.dialog dialog)))
        (when w 
          (window-close w)
          (let ((kids (bt-child-windows w)))
            (dolist ( kid kids)
              (when (wptr kid)(window-close kid))))))
      (when (bt.restarts dialog) (window-close (bt.restarts dialog)))
      (when old-modal
        (setq *modal-dialog-on-top* (if (and (wptr (caar old-modal))
                                             (window-shown-p (caar old-modal)))
                                      old-modal
                                      (cdr old-modal))))
      (when (and *top-listener*
                 (null (symbol-value-in-process '*listener-p*
                                                *current-process*)))
        (cond (*autoclose-inactive-listeners*
               (window-close *top-listener*))
              (t (format *top-listener* "~&Process aborted or resumed. This Listener may no longer be active.~%~%")
                 (when *modal-dialog-on-top* 
                   (format *top-listener* "~%There is a modal dialog. Type Command-. to exit/cancel the dialog.~%"))
                 (set-mini-buffer *top-listener* "~&Inactive")))))))

(defun relock-windows (queue-list &optional (process *current-process*))
  (dolist (q queue-list)
    (process-enqueue q process)))

; unused?
(defun display-restarts (&optional (condition *break-condition*))
  (let ((i 0))
    (format t "~&[Pretend that these are buttons.]")
    (dolist (r (compute-restarts condition) i)
      (format t "~&~a : ~A" i r)
      (setq i (%i+ i 1)))
    (fresh-line nil)))

(defun select-restart (n &optional (condition *break-condition*))
  (let* ((restarts (compute-restarts condition)))
    (invoke-restart-interactively
     (nth (require-type n `(integer 0 (,(length restarts)))) restarts))))

;;; This shouldn't be modal or as badly vulnerable to timing screws as it is.
;;; well its not modal

(defun choose-restart ()
  (let* ((d (car *backtrace-dialogs*)))
    (when d
      (let ((window (bt.restarts d))
            (process *current-process*))
        (if (or (null window) (null (wptr window)))
          (without-interrupts
           (setq window 
                 (select-item-from-list
                  (delete-if #'(lambda (restart)
                                 (null (%restart-report restart)))
                             (compute-restarts *break-condition*))
                  :window-title "Pick a restart, any restart:"
                  :modeless T
                  :default-button-text "Do it"
                  :help-spec 15020
                  :list-spec 15021
                  :button-spec 15022
                  :action-function
                  #'(lambda (list)
                      (process-interrupt process #'invoke-restart-interactively (car list))
                      (window-close window))))
           (setf (bt.restarts d) window))
          (window-select window))))))

; End of l1-readloop-lds.lisp
