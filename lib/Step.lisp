; -*- Mode:Lisp; Package:CCL; -*-

;;	Change History (most recent first):
;;  2 2/19/96  akh  some eval-whens
;;  2 4/24/95  akh  probably no change
;;  (do not edit before this line!!)

;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

; Modification History:
;
;  6/08/95 slh   help-specs
; 04/24/93 alice current-buffer-font-index -> set-buffer-insert-font-index
; 04/17/93 alice *step-commands* is global
; 10/19/92 bill The stepper no longer hangs if invoked while
;               (or (< *interrupt-level* 0) *processing-events*)
; 05/06/92 bill add step-inspector & update-step-inspector calls
;-------- 2.0
;12/14/91 window-select not window-show; don't install interpreted defs
;--------------- 2.0b4
;10/06/91 alice make all trace output go to same window if there is one
;------------- 2.0b3
;07/21/91 gb  DECLAIM.
;06/04/91 bill alice's fix to step-evalhook
;02/18/91 gb   %uvsize -> uvsize.
; 03/22/91 alice step-prin1 bind *print-readably* nil
; 02/09/91  step-apply-simple - allow non symbol def,  step - uncompile (car form)
;------------ 2.0b1
; 01/08/90 in::=>inspector (why did the nickname go away?)
; 01/02/91 progn=>ignore-errors in step-evalhook
; 12/20/90 use values array for both names and values
; 12/12/90 put the catch in step macro in the correct place
; 12/06/90 make symbol-macros semi reasonable, make quote work
;          special case printing for %init&bind
; 12/05/90 use a global table for mapping
; 12/04/90 assure output at buffer end in case user mucks about with step window
; 12/04/90 change step macro 
; 12/01/90 show-form for %with-specials and %with-specials-2
; 11/30/90 bind accessors-constant in step-eval-cheat

; things to do
; 1) if one does (trace (bb :step t)), then redefine bb, then call bb again
;    two things happen - the source mapping is loused up and you crash!
;    Well I cant reproduce it but something of the sort did happen.
; 2) it would be nice if a top level call to step did not require
;    *compile-definitions* to be nil

(in-package :ccl)

; env is an execution environment - get the var alist for munching
; we are missing closed-used list (do we care? dont think so)
(defun evalenv-all-vars (env)
  (let ((vp (evalenv-vp env))
        ;(names (evalenv-names env))
        (values (evalenv-values env))
        (offset (+ 1 (evalenv-maxvp env)))
        (bindings ())
        (newnames ()))
    (while (>= vp 0)
      (let ((name (uvref values (+ offset vp)))
            (val (uvref values vp))
            reffer)
        (when name
          (cond ((eq val %special-marker%)
                 (setq reffer t))
                ((and (consp val)(eq (car val) %closed-marker%))
                 (setq reffer (list '%closure-ref name vp ))))           
          (push (make-symbol-info name vp nil reffer) bindings))
        (push name newnames)
        (setq vp (- vp 1))))
    (values (nreverse bindings)(nreverse newnames))))

; transform an execution environment into a pre-processing environment for eval while stepping
; (closed-used will be  wrong)
; if newmax is given we are gonna use it for running

(defun env-transform (env &optional (newenv (make-evalenv)) newmax)  
  (dotimes (i (1- (uvsize env)))
    (declare (fixnum i))
    (uvset newenv (+ 1 i) (uvref env (+ 1 i))))
  (if (null newmax)
    (multiple-value-bind (newvars newnames)(evalenv-all-vars env)    
      (setf (evalenv-variables newenv) newvars)
      (setf (evalenv-names newenv) newnames))
    (let ((an (make-array (1+ newmax)))
          (av (make-array (1+ newmax))))
      (dotimes (i (1+ (evalenv-vp env)))
        (declare (fixnum i))
        (uvset an i (uvref (evalenv-names env) i))
        (uvset av i (uvref (evalenv-values env) i)))
      (setf (evalenv-names newenv) an)
      (setf (evalenv-values newenv) av)))
  newenv)

;;;;;;;;;;;;;;;;;;;;;
;;; stepper
;;;

(defvar *step-print-level* 4
  "*Print-level* is bound to this when stepper prints forms.")

(defvar *step-print-length* 5
  "*Print-length* is bound to this when stepper prints forms.")
(defvar *step-output* *terminal-io*)

(declaim (special *step-level* *step-output*))
#|
(defmacro step (form)
  (let ((*compile-definitions* nil)
        (fn (eval-prep form)))
    `(step-apply-simple ,fn nil)))
|#

(eval-when (:compile-toplevel :load-toplevel :execute)
(defmacro step (form)
  `(cond ((null *stepping*)
          ;(when (consp ',form)
          ;(uncompile-for-stepping (car ',form) nil t))
          (let-globally ((*step-commands* nil))
            (let* ((w (make-instance 'inspector::step-window
                        :window-title "Stepper"
                        :help-spec 15130))
                   (*step-output* (fred-dialog-item w)))
              (catch *step-output*
                (let ((*evalhook* #'step-evalhook)
                      (*applyhook* #'step-applyhook)
                      (*step-level* -2)
                      (*stepping* t))
                  ,form)))))
         (t ,form)))
)

(defvar *trace-step-window* nil)

; def is a symbol - when called from thing produced by trace-global-def
(defun step-apply-simple (def args)
  ;(if (not (symbolp def))(error "Shouldnt 8"))
  ;(uncompile-for-step-apply def args) ; deal with redefinition (via compile) of stepped thing
  (let ((def (uncompile-for-step-apply def args)))
    (cond ((null *stepping*)
           (let ((w (or (and *trace-step-window* (progn (window-select *trace-step-window*)
                                                        *trace-step-window*))
                        (setq *trace-step-window*
                              (make-instance 'inspector::step-window :window-title "Trace Step")))))           
             (let-globally ((*step-commands* nil))
               (let ((*evalhook* #'step-evalhook)
                   (*applyhook* #'step-applyhook)
                   (*step-output* (fred-dialog-item w))
                   (*step-level* -2)
                   (*stepping* t))
               (catch *step-output*
                 (apply def args))))))
          (t (apply def args)))))


; we do install the interpreted def this week
(defun uncompile-for-step-apply (thing args)
  (if  (or (and (symbolp thing)(fboundp thing))
             (typep thing 'method)
             ;(typep thing 'compiled-lexical-closure)
             (functionp thing))
    (uncompile-for-stepping thing args)
    thing))

(defun step-evalhook (form env)
  (when (not *stepping*)(return-from step-evalhook (evalhook form nil nil env)))
  (unwind-protect
    (prog ((*step-level* (+ *step-level* 2))
           (count -1)
           (show-form form)
           (last-command nil))
      START
      (setq show-form (or (gethash form *source-mapping-table*) form))
      (when (and (consp form) (consp (car form)))
        (case (caar form)
          ((%special-bind %special-declare)
           (return-from step-evalhook (evalhook form nil nil env)))
          (%with-specials
           (setq *step-level* (- *step-level* 2))
           (return-from step-evalhook (evalhook form #'step-evalhook #'step-applyhook env)))
          ;(setq show-form '(progn ***)))
          (%init&bind ; put this in the mapping table at munch time
           ; wont see these when inside with-specials
           (setq show-form `(%init&bind ,(var-name (cadr form))
                                        ,(caddr form)
                                        ,@(if (cadddr form)(var-name (cadddr form))))))
          ((%local-ref %closure-ref %special-ref)
           (setq show-form (cadr form)))))
      (if (not (constantp form))(progn (step-show-form show-form env)))
      EVAL
      (setq count (%i+ count 1))
      (multiple-value-bind 
        (val err)
        (ignore-errors ; wrong for symbol-macros                        
         (when (and (or (symbolp show-form) (constantp form)) (%izerop count))
           (let (info)
             (cond ((and (symbolp show-form)
                         (setq info (ev-symbol-info show-form env))) ; true iff symbol macro
                    (step-prin1 (var-ea info) 1 " = ")
                    ; will its a little funky but at least it doesnt loop
                    (go eval))
                   ((not (constantp form)) 
                    (setq form (evalhook form nil nil env))                   
                    (step-prin1 form 1 " = "))
                   ((consp form) ; quote
                    (setq form (evalhook form nil nil env))))
             (return-from step-evalhook form)))
         (unless (eq last-command :inspect)
           (update-step-inspector env))
         (case (setq last-command (step-ask))
           (:step
            (setq form (multiple-value-list (evalhook form #'step-evalhook #'step-applyhook env)))
            (when *stepping* (step-show-values form))
            (return (values-list form)))
           (:step-over
            (setq form (multiple-value-list (evalhook form nil nil env)))
            (step-show-values form)
            (return (values-list form)))
           (:go
            (setq *stepping* nil *evalhook* nil)
            (return (evalhook form nil nil env)))
           (:quit
            ; maybe this should close the window too
            (throw *step-output* (values)))
           (:eval
            (catch-cancel
              (let* (;(*compiled-for-evaluation* nil) ; maybe can be T
                     (*evalhook* nil)
                     (*applyhook* nil)
                     (str (get-string-from-user "Type a form to evaluate in the current lexical environment:")))
                (when str
                  (let ((form (read-from-string str))
                        (*step-level* (+ *step-level* 2)))
                    (step-tab)
                    (step-prin1 form 2 "Eval: ")
                    (setq form
                          (multiple-value-list
                           (cond ((symbolp form) ; symbol macro?
                                  (find-symbol-value-slow form env))
                                 ((not (consp form)) form)
                                 (t (step-eval-cheat form env)))))
                    (if (and form (null (cdr form)))
                      (step-prin1 (car form) 1 " = ")
                      (step-show-values form)))
                  (progn (step-show-form show-form))))))
           (:inspect (step-inspect env)))
         (go eval))
        (declare (ignore val))
        (when (typep err 'error)
          (step-tab)
          (princ "Error >> " *step-output*)
          (format *step-output* "~A" err)
          (go start))))
    (update-step-inspector nil)))

(defun step-eval-cheat (form env)
  ; try to avoid calling compiler or making a new env for little things like setq
  ; perhaps this is not worth the trouble
  (cond (env
         (let* (disgusting-accessors-constant
                (form (munch-form form (env-transform env %step-evalenv%))))
           (declare (special disgusting-accessors-constant))
           (if (> (evalenv-maxvp %step-evalenv%)(evalenv-maxvp env))
             ; oh foo, it needs more stack than we have - also fails if attempt
             ; to close&setq some new vars (actually fails in any case) - who should bitch?
             (let ((newenv (env-transform env (make-evalenv) (evalenv-maxvp %step-evalenv%))))
               (values (evalhook form nil nil newenv)))
             (values (evalhook form nil nil env)))))
        (t (values (applyhook (eval-prep form) nil nil nil)))))

#|
(defun step-eval-cheat (form env)
  (let ((newenv (env-transform env (make-evalenv))))
    (cheap-eval-in-environment form newenv)))
|#


(defun step-applyhook (fn args)
  (setq fn (uncompile-for-step-apply fn args))
  (applyhook fn args *evalhook* #'step-applyhook)
  )

(defun step-prin1 (form font &optional prefix)
  (let ((*print-level* *step-print-level*)
        (*print-length* *step-print-length*)
        (*print-readably* nil)
        (*print-array* nil)
        (*print-case* :downcase))
    (set-buffer-insert-font-index (fred-buffer *step-output*) font)
    (when prefix (princ prefix *step-output*))
    (prin1 form *step-output*)
    (force-output *step-output*)
    ;(in::window-show-cursor (view-container *step-output*))
    ))

; step-output is a fred-dialog-item, force-output is a method on streams

(defun step-show-form (form &optional env)
  (declare (ignore env))
  (step-tab)
  (step-prin1 form 2))
#|
(defun step-ask ()
  (step-tab)
  (princ ">" *step-output*)
  (read))
|#

(defun step-ask ()
  (with-event-processing-enabled
    (prog ()
      agn  
      (cond (*step-commands* (return 
                              (cond ((null (cdr *step-commands*))
                                     (pop *step-commands*)) ; backwards - get the last!!
                                    (t (let ((foo (last *step-commands* 2)))
                                         (prog1 (cadr foo)
                                           (rplacd foo nil)))))))
            
            (t (event-dispatch)(go agn))))))

(defun step-show-values (forms)
  (dolist (form forms)
    (step-tab)
    (step-prin1 form 1)))

(defun step-tab (&aux (n (min *step-level* *trace-max-indent*)))
  (let ((buf (fred-buffer *step-output*)))
    (stream-position *step-output*  (buffer-size buf))
    (fresh-line *step-output*)
    (inspector::window-show-cursor  *step-output*)
    (set-buffer-insert-font-index (fred-buffer *step-output*) 1)
    (dotimes (i n)
      (declare (fixnum i))
      (tyo #\Space *step-output*))
    ))
  
(provide 'step)
