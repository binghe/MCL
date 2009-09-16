;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  5 1/22/97  akh  dont remember
;;  4 7/18/96  akh  execute buffer => execute all
;;  2 10/17/95 akh  merge patches
;;  9 5/7/95   slh  balloon help mods.
;;  6 4/28/95  akh  fix list definitions
;;  5 4/24/95  akh  undo some merge damage
;;  4 4/24/95  akh  no list-definitions if listener is frontmost
;;  2 4/4/95   akh  add room-for-new-listener-p and make-new-listener call it
;;  (do not edit before this line!!)
 

; l1-initmenus-lds.lisp
; Copyright 1995-2001 Digitool, Inc. The 'tool rules!

; Modification History
;
; add search-window-dialog to the tools menu
; ---- 5.1 final
; don't add preferences to tools menu here - done elsewhere
;; 5.1b2
; config-info tells physicalramsize if OSX rather that logical which is a useless constant
; --- 4.4b5
; 12/18/01 config-info for system version being bcd
;12/10/01 see config-info re osx
; 05/05/01 akh osx has usurped command-h - tant pis - see comments - maybe a future OSX version wont usurp our keys (from erics)
; 04/17/97 bill  create-bug-report, config-info, "Create Bug Report" tools menu item
; -------------  4.1b2
; akh execute buffer => execute all
;  1/29/96 bill  ppc-target version of room-for-new-listener-p
;  5/04/95 slh   fix List Definitions item updating
;  4/20/95 slh   room-for-new-listener-p: don't dispose null ptr.
;                require-inspector -> (require :inspector)


(in-package :ccl)

; still needed cause the throw in kernel has no catcher in event-processor
; and the dialog is more informative anyway
; maybe make-stack-group should do this too?
#-ppc-target
(defun room-for-new-listener-p (&optional (stack-size *default-process-stackseg-size*))
  ; this isn't really right
  (let* ((free (free-stackseg))
         (next (if (neq 0 free) (next-stackseg free) 0)))
    (or (and (neq 0 free)(neq 0 next))  
        (not (let (p1 nullp)
               (unwind-protect
                 ; it does need nearly all of this tho some may be for the window
                 (setq p1 (#_NewPtr (* (if (neq 0 free) 1 2)
                                       (+ stack-size 2058)))   ; #(2*SOFTSTACKLIMIT)+4 + 6
                       nullp (%null-ptr-p p1))
                 (unless nullp
                   (#_DisposePtr p1))))))))

#+ppc-target
; This knows how "ccl:l1;ppc-stack-groups" allocates stacks
(defun room-for-new-listener-p (&optional (stack-size *default-process-stackseg-size*))
  (let* ((each-size  stack-size)
         (ts-size (+ each-size 4095 (* 12 1024)))
         (vs-size (+ each-size 4095 (* 12 1024)))
         (cs-size (+ each-size *cs-hard-overflow-size* *cs-soft-overflow-size*)))
    (with-macptrs (tstack vstack cstack)
      (rlet ((result-code :long))
        (unwind-protect
          (progn
            (%setf-macptr tstack (#_TempNewHandle ts-size result-code))
            (%setf-macptr vstack (#_TempNewHandle vs-size result-code))
            (%setf-macptr cstack (#_TempNewHandle cs-size result-code))
            (and (not (%null-ptr-p tstack))
                 (not (%null-ptr-p vstack))
                 (not (%null-ptr-p cstack))))
          (unless (%null-ptr-p tstack)
            (#_DisposeHandle tstack))
          (unless (%null-ptr-p vstack)
            (#_DisposeHandle vstack))
          (unless (%null-ptr-p cstack)
            (#_DisposeHandle cstack)))))))

(defun make-new-listener ()
  (if (room-for-new-listener-p *listener-process-stackseg-size*)
    (progn (make-instance *default-listener-class*))
    (message-dialog "There is not enough memory available to make a new listener.")))

(defun front-window-process ()
  (let* ((w (get-window-event-handler)))
    (and w (window-process w))))

(defun create-bug-report (&optional (process (process-to-restart "Bug Report for Process")))
  (when process
    (eval-enqueue #'(lambda ()
                      (let* ((w (make-instance
                                  'fred-window :scratch-p t
                                  
                                  :window-title "Bug Report"))
                             (item (fred-item w))
                             (*debug-io* item))
                        (format item "Send this report to bug-mcl@digitool.com~%~%~
                                      ---------------- cut here --------------~%")
                        (without-interrupts
                         (format item "~%~a"
                                 (hc-current-date-str))
                         (format item "~&~%Describe the bug, including how to reproduce it if you can:~%~%~%")
                         (config-info item)
                         (fred-update w)
                         (format item "~%~%")
                         (let ((condition (symbol-value-in-process '*break-condition* process))
                               (dialogs (symbol-value-in-process '*backtrace-dialogs* process))
                               (error-pointer nil)
                               (frame-number 0)
                               (sg (process-stack-group process)))
                           (when (and condition
                                      (typep condition 'serious-condition)
                                      (vectorp (car dialogs))
                                      (> (length (car dialogs)) 2)
                                      (setq error-pointer (elt (car dialogs) 1)))
                             (let ((*error-output* item))
                               (%break-message "Error" condition error-pointer)
                               (format item "~%")))
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

(defun config-info (&optional (stream *standard-output*))
  (format stream "~%~a" (machine-version))
  (terpri stream)
  (format stream "~%~dK Ram" (truncate 
                              (if (osx-p)
                                (gestalt #$gestaltPhysicalRAMSize)
                                (gestalt #$gestaltLogicalRAMSize))
                              1024))
  (terpri stream)
  (flet ((hex-with-dots (N)
           (multiple-value-bind (n1 n2)(truncate n #x100)
             (multiple-value-bind (n2 n3)(truncate n2 #x10)
               (format nil "~a.~a.~a" n1 n2 n3))))
         (bcd-with-dots (n)
           (multiple-value-bind (n1 n2)(truncate n #x100)
             (multiple-value-bind (n2 n3)(truncate n2 #x10)
               (format nil "~x.~x.~x" n1 n2 n3)))))

    (format stream "~%MCL ~A~%~%Rom Version ~x(hex)~%~%System Version: ~a~%~%"
            (lisp-implementation-version)
            (let ((romv (gestalt "romv")))  ;; oh foo - is nil on Osx
              (if romv (%integer-to-string romv 16)
                  "OOPs OSX doesn't know romv"))
            (bcd-with-dots (gestalt #$gestaltSystemVersion))))


  (terpri stream)
  ;(terpri stream)
  (flet ((show-ruler ()
           (format stream "Gestalt
Bits:~16T10987654321098765432109876543210~%"))
         (show-rules (c)
           (format stream "~16T~c|||||||~c|||||||~c|||||||~c|||||||~%" c c c c))
         (show-gestalt (label attr &optional (radix-idx 0))     ; dec, hex, bin
           (format stream "~A~16T~[~12D~;~12X(hex)~;~32,'0B~]~%" label
radix-idx (gestalt attr))))
    (show-ruler)
    (show-rules #\v)
    #-ppc-target
    (show-gestalt "AddressingMode" #$gestaltAddressingModeAttr 2)
    ;(show-gestalt "FPUType"        #$gestaltFPUType 2)
    #-ppc-target
    (show-gestalt "MMUType"        #$gestaltMMUType 2)
    ;(show-gestalt "Hardware"       #$gestaltHardwareAttr 2)
    (show-gestalt "OSAttributes"   #$gestaltOSAttr 2)
    (show-rules #\^)
    (show-ruler)
    (terpri stream)
    ;(show-gestalt "LogRAMSize"     #$gestaltLogicalRAMSize)
    (show-gestalt "QDVersion"      #$gestaltQuickdrawVersion 1)
    (show-gestalt "ScriptMgrVers"  #$gestaltScriptMgrVersion 1)
    (show-gestalt "ScriptCount"    #$gestaltScriptCount))
  (format stream "~%EGC:      ~A/~A (available/active)"

          (egc-mmu-support-available-p)
          (egc-active-p))
  #-ppc-target
  (format stream "~%PTable:   ~:[not ~;~]in Extensions~%"
          (not (null (probe-file (merge-pathnames
                                  (findfolder -1 #$kextensionfoldertype)
                                  "PTable")))))
  (let ((num 0))
    (do-screens (screen)
      (format stream "~&Screen ~D: ~D bits, ~:[B/W~;color~]~%"
              (incf num)
              (screen-bits screen)
              (screen-color-p screen))))
  (format stream "~&Windows:  ~D~%" (length (windows)))
  ;(let ((run-ticks (get-internal-run-time)))
  ;  (format stream "~&Run time: ~D ticks (~D secs)~%"
  ;          run-ticks (round run-ticks 60)))
  (let ((*standard-output* stream))
    (terpri stream)
    (room t))
  (values))

(defparameter *execute-item* nil)
(let ((menu *lisp-menu*))
  (add-new-item menu "Execute Selection" 'window-eval-selection :class 'window-menu-item
                :command-key #\E :help-spec '(1301 1 2)
                :update-function
                #'(lambda (item) (edit-menu-item-update item 'execute-selection)))
  (setq *execute-item*
        (add-new-item menu "Execute All" 'window-eval-whole-buffer
                :command-key #\H
                :class 'window-menu-item
                :help-spec '(1302 1 2)
                :update-function
                #'(lambda (item) (edit-menu-item-update item 'execute-whole-buffer))))
    
  
  (add-new-item menu "-" nil :disabled t)
  (add-new-item menu "Abort" 'interactive-abort
                :command-key #\. :help-spec 1305)
  (add-new-item menu "Break" #'(lambda ()
                                 (#_HiliteMenu 0)
                                 (interactive-break))
                :command-key #\, :help-spec 1306)
  (add-new-item menu "Continue" #'(lambda ()
                                    (let ((p (process-to-continue)))
                                      (when p
                                        (process-interrupt p #'continue))))                                          
                                    
                :command-key #\/
                :update-function #'(lambda (item)
                                     (set-menu-item-enabled-p
                                      item (continuable-process-p)))
                :help-spec '(1307 1 2))
  (add-new-item menu "Restarts…" #'(lambda ()
                                     (let ((p (process-to-restart)))
                                       (when p
                                         (process-interrupt p #'choose-restart))))
                :command-key #\\
                :update-function #'(lambda (item)
                                     (set-menu-item-enabled-p
                                      item (restartable-process-p)))
                :help-spec '(1308 1 2)))

#+ignore
(def-ccl-pointers bugger-cmd-h ()
 (set-command-key *execute-item* #\H)) ;(if (not (osx-p)) #\H '(:shift #\H)))) ;; problem fixed in 5G15

(let ((menu *tools-menu*))
  (add-new-item menu "Apropos…" 'apropos-dialog :help-spec 1401)
  (add-new-item menu "Get Info…" #|'documentation-dialog|#
                #'(lambda ()
                    (edit-anything-dialog))
                :command-key #\I
                :help-spec 1402)
  #|
  (add-new-item menu "Edit Definition…" 'edit-definition-dialog :help-spec 1403)
  (add-new-item menu "Inspect…" 'inspect-system-data :help-spec 1404)
  |#
  (add-new-item menu "Processes" 'inspect-processes :help-spec 1420)
  (add-new-item menu "List Definitions" 'window-defs-dialog :class 'window-menu-item
                :update-function #'(lambda (item)
                                     (if (typep (front-window) 'listener)
                                       (menu-item-disable item)
                                       (dim-if-undefined item 'window-defs-dialog)))
                :help-spec '(1405 1 2))
  (add-new-item menu "Search Files…" #'(lambda ()
                                         (search-file-dialog))
                :help-spec 1406)
  (add-new-item menu "Trace…" 'trace-dialog :help-spec 1422)
  (add-new-item menu "Search/Replace…" 'search-window-dialog)
  (add-menu-items menu (make-instance 'menu :menu-title "Inspector" :help-spec 1404))
  (add-new-item menu "Save Application…" #'(lambda ()
                                             (require 'save-application-dialog)
                                             (funcall 'save-application-dialog))
                :help-spec 1423)
  (add-new-item menu "-" nil :disabled t)
  (add-new-item menu "Backtrace" #'(lambda ()
                                     (let ((process (process-to-restart "Backtrace Process")))
                                       (if process
                                         (process-interrupt process #'select-backtrace))))
                :command-key #\B
                :update-function #'(lambda (item)
                                     (set-menu-item-enabled-p item (restartable-process-p)))
                :help-spec '(1407 1 2))
  (add-new-item menu "Create Bug Report" 'create-bug-report

                ;:command-key #\B
                :update-function #'(lambda (item)
                                     (set-menu-item-enabled-p item (restartable-process-p)))
                :help-spec '(1411 1 2)
                )
  (add-new-item menu "-" nil :disabled t)
  (add-new-item menu "Fred Commands" 'ed-help :help-spec 1408)
  (add-new-item menu "Listener Commands" 'ed-listener-help :help-spec 1411)
  ;(add-new-item menu "-" nil :disabled t)
  ;(add-new-item menu "Print Options…" 'print-options-dialog :help-spec 1409)
  ;(add-new-item menu "Preferences…" 'environment-dialog :help-spec 1410)

  (dolist (item (slot-value menu 'item-list))
    (menu-item-disable item))
  )

(declaim (notinline inspect-system-data inspect))

(defun inspect-system-data ()
  (require :inspector)
  (inspect-system-data))

(defun inspect (object)
  (require :inspector)
  (inspect object))

; End of l1-initmenus-lds.lisp
