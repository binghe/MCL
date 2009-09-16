;;;-*- Mode: Lisp; Package: CCL -*-

;; l1-boot-3.lisp
;; Third part of l1-boot

;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; $Log: l1-boot-3.lisp,v $
;; Revision 1.9  2006/02/03 00:37:34  alice
;; ;; 12/10/05 maybe-create-standin-event-processor - reset *periodic-task-mask*
;;
;; Revision 1.8  2004/10/03 06:07:32  alice
;; probably no change
;;
;; Revision 1.7  2004/03/25 08:17:01  alice
;; probably no change
;;
;; Revision 1.6  2004/02/27 06:26:15  svspire
;; boot-init.pfsl -> .cfsl
;;
;; Revision 1.5  2003/12/08 08:34:24  gtbyers
;; Turn off %FASLOAD-VERBOSE.
;;

;; 12/10/05 maybe-create-standin-event-processor - reset *periodic-task-mask*
;; ------ 5.1 final
;; 07/10/99 akh  maybe-create-standin-event-processor doesn't set modal-dialog-on-top nil
;----------- 4.3b3
;; 04/16/97 bill  New file. Broken out of l1-boot.lisp
;;

(catch :toplevel
    (setq *scrap-count* -1)
    (or (find-package "COMMON-LISP-USER")
        (make-package "COMMON-LISP-USER" :use '("COMMON-LISP" "CCL") :NICKNAMES '("CL-USER")))
)

;(defvar *event-processor-priority* 1)  ;; in l1-processes now

(set-periodic-task-interval 1)

(defun event-processing-loop ()
  (let* ((global-top-listener *top-listener*))
    (flet ((valid-window (w)
             (and w
                  (typep w 'window)
                  (wptr w)
                  w)))
      (setq *top-listener* nil)
      ;(huh "loop")
      (unwind-protect
        (let ((*top-listener* (valid-window global-top-listener))
              (tag (list nil)))
          (unwind-protect
            (let-globally ((*event-processing-loop-tag* tag))
              (loop
                (catch tag
                  (with-standard-abort-handling "Continue event processing"
                    (let ((handler #'(lambda (condition)
                                       (declare (ignore condition))
                                       
                                       (maybe-create-standin-event-processor)
                                       nil)))
                      (declare (dynamic-extent handler))
                      (handler-bind (;(warning #'muffle-warning)
                                     (serious-condition handler))
                        (loop
                          (if (eq *current-process* *event-processor*)
                            (progn
                              ;(huh "loop2")
                              (process-wait "Event-poll" 
                                            (if *new-processes* 
                                              #'(lambda ()
                                                   (and (event-available-p)
                                                        (process.priority *event-processor*)))
                                              #'event-available-p))
                              (%event-dispatch))
                            (without-interrupts
                             ;(huh "loop3")
                             (process-wait "Standin process" #'(lambda () (not *processing-events*)))
                             (let ((p *event-processor*)
                                   (me *current-process*))
                               (unless (eq p me)
                                 (setq *event-processor* me)
                                 (setf (process.priority me) (if *new-processes* 10 *event-processor-priority*)) ; s.b *max-priority*
                                 (process-kill-and-wait p))))))))))))
            ; unwind-protect cleanup
            (setq global-top-listener *top-listener*)))
          ; unwind-protect cleanup
        ;(huh "loopend")
        (setq *top-listener* (valid-window global-top-listener))))))

(defvar *event-error-dialog* nil)

; called from above and from %break-message
(defun maybe-create-standin-event-processor ()
  (When (and (not *single-process-p*)
             (eq *event-processor* *initial-process*)
             (eq *current-process* *initial-process*))
    (setq *processing-events* nil)
    (when (and *timer-interval* (neq 0 *periodic-task-mask*)) ;; <<
      (setq *periodic-task-mask* 0)
      (do ((x *periodic-task-masks* (cdr x)))
          ((null x))
        (rplaca x 0)))
    ;(setq *modal-dialog-on-top* nil) ; do this help?  ;; << dont do that yet
    ;(setq *eventhook* nil) ; this do help    
    (if (room-for-new-listener-p)
      (let ((p (make-process "Event processing standin"
                             :priority (if *new-processes* 10 *event-processor-priority*) ; s.b. *max-priority*
                             :background-p t)))
        (process-preset p #'after-error-event-processing-loop)
        (setq *event-processor* p)
        (release-locked-windows)
        (process-enable p)
        
        (setf (process.priority *current-process*) 0))
      ; ugh now what - kill the original? kill other listeners?
      (progn
        ; this is not doing what I mean - i.e. errors still happen
        (ed-beep)
        (ignore-errors (release-locked-windows)); ??
        (if *event-error-dialog* (window-select *event-error-dialog*))
        (process-interrupt *initial-process* #'after-error-event-processing-loop)
        ;(ed-beep)(ed-beep)
        ;(process-enable *initial-process*)
        ;(ed-beep)(ed-beep)(ed-beep)
        ))))

(defun after-error-event-processing-loop ()
  (loop
    (catch :toplevel
      (catch :cancel
        (handler-case
          (loop
            ; used to be just #'event-available-p
            (process-wait "Event-poll"
                          #'(lambda (process)
                              (and (event-available-p)
                                   (eq process *event-processor*)))
                          *current-process*)
            (let ((*break-on-signals* nil))
              (%event-dispatch)))
          (t () nil))))))


(%set-toplevel
 #'(lambda ()
     (%set-toplevel
      #'(lambda ()
          (lds (progn
                 (let ((p (if *single-process-p*
                            *current-process*
                            (make-mcl-listener-process))))
                   (process-interrupt
                    p
                    #'(lambda ()
                        (startup-ccl (if (or (probe-file "home:boot-init.lisp")
                                             (probe-file #-ppc-target "home:boot-init.fasl"
                                                         #+ppc-target "home:boot-init.cfsl"))
                                       "home:boot-init"
                                       "home:init")))))
                 (%set-toplevel (if *single-process-p*
                                  #'toplevel-loop
                                  #'event-processing-loop)))
               (%set-toplevel (symbol-function 'app-loader-toplevel)))
          (toplevel)))))




(setq *interrupt-level* 0)

(setq *warn-if-redefine* t)

(setq *level-1-loaded* t)

;(setq *loading-file-source-file* "ccl:l1;level-1.lisp") ;reset from last %fasload...

(setq *%fasload-verbose* nil)


;End of Level-1.lisp
