;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; appearance-manager.lisp
;;;
;;; EXTENSIONS TO THE MCL EVENT MANAGER TO UTILIZE THE APPEARANCE MANAGER
;;;
;;; Copyright ©1997-1999
;;; Supportive Inquiry Based Learning Environments Project
;;; Learning Sciences Program
;;; School of Education & Social Policy
;;; Northwestern University
;;;
;;; Use and copying of this software and preparation of derivative works
;;; based upon this software are permitted, so long as this copyright 
;;; notice is included intact.
;;;
;;; This software is made available AS IS, and no warranty is made about 
;;; the software or its performance. 
;;;
;;; Author: Eric Russell <eric-r@nwu.edu>
;;;

(in-package :ccl)

(let* ((path (pathname *loading-file-source-file*))
       (dirpath (make-pathname :directory (pathname-directory path)
                               :host (pathname-host path)
                               :name nil
                               :type nil
                               :defaults nil)))
  (pushnew dirpath *module-search-path* :test #'equalp))

(export '(init-appearance-manager
          appearance-available-p
          appearance-compatibility-mode-p
          window-collapsable-p 
          window-collapsed-p 
          window-collapse
          window-uncollapse
          collapse-all-windows))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :appearance-globals))

;;;----------------------------------------------------------------------
;;;  Get the shared library

#-carbon-compat
(eval-when (:compile-toplevel :load-toplevel :execute)
  (ccl::add-to-shared-library-search-path "AppearanceLib" t))

;;;----------------------------------------------------------------------
;;; Check for availablility of appearance manager

(defun init-appearance-manager ()
  (let ((flags (gestalt #$gestaltAppearanceAttr))
        (errno nil))
    (declare (ignore-if-unused errno))
    (when (and flags (logbitp #$gestaltAppearanceExists flags))
      (setq *appearance-available-p* t
            *appearance-compatibility-mode-p*
            (logbitp #$gestaltAppearanceCompatMode flags))
      #-carbon-compat ;; not needed for Carbon - so they say
      (setq errno (#_RegisterAppearanceClient))  ;; rets error -30561
      t)))

(when (not (fboundp 'appearance-available-p))
  (defun appearance-available-p ()
    *appearance-available-p*))

(defun appearance-compatibility-mode-p ()
  (or (not *appearance-available-p*)
      *appearance-compatibility-mode-p*))

;;;----------------------------------------------------------------------
;;; Call the new _IdleControls trap on null event
;;;
;;; Can't make the method on class t, because "help-manager.lisp" defines
;;; a method on t that shows baloon help.

(defmethod window-null-event-handler :after ((thing standard-object))
  (when *appearance-available-p*
    (dolist (wptr-wob *window-object-alist*)
      (when #-carbon-compat (rref (car wptr-wob) windowrecord.visible) 
            #+carbon-compat (#_iswindowvisible (car wptr-wob))
        (#_IdleControls (car wptr-wob))))))

#|

;;;----------------------------------------------------------------------
;;; Alternative to the above: use eventhook so that controls continue
;;; to move when MCL is in the background. Provided by Terje Norderhaug.

(defun idle-controls-eventhook ()
  (when (and *appearance-available-p*
             (eq $nullEvt (%get-word *current-event*)))
    (dolist (wptr-wob *window-object-alist*)
      (when (rref (car wptr-wob) windowrecord.visible)
        (#_IdleControls (car wptr-wob))))))

(eval-when (:load-toplevel :execute)
  (pushnew 'idle-controls-eventhook *eventhook*))

|#

;;;----------------------------------------------------------------------
;;; Create a root control for a window if it doesn't already have one.

(defmethod install-view-in-window :around ((item control-dialog-item) dialog)
  (when (appearance-available-p)
    (rlet ((root-ptr :pointer))
      (unless (eq #$noErr (#_GetRootControl (wptr dialog) root-ptr))
        (#_CreateRootControl (wptr dialog) root-ptr))))
  (call-next-method))

;;;----------------------------------------------------------------------
;;; For reasons I don't quite understand, changing the view-position of
;;; a button-dialog-item in a window of type document-with-grow that
;;; has a root control will hose the window's erase-region. Redefining
;;; the validate-control-dialog-item on button-dialog-item to just
;;; call-next-method fixes that problem, but I'm not sure what other 
;;; problems it may cause, if any.

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))

#| ; I think these are bad things - akh  
  (defmethod validate-control-dialog-item ((item button-dialog-item))
    (call-next-method))


  (defmethod invalidate-view ((item button-dialog-item) &optional erase-p)
    (declare (ignore erase-p))
    (call-next-method))
|#
)

;;;----------------------------------------------------------------------
;;; Methods for colapsing windows

(defmethod window-collapsable-p ((window window))
  (and (wptr window) (#_IsWindowCollapsable (wptr window))))

(defmethod window-collapsed-p ((window window))
  (and (wptr window) (#_IsWindowCollapsed (wptr window))))

(defmethod window-collapse ((window window))
  (when (window-collapsable-p window)
    (#_CollapseWindow (wptr window) t)))

(defmethod window-uncollapse ((window window))
  (when (window-collapsable-p window)     
    (#_CollapseWindow (wptr window) nil)))

(defun collapse-all-windows (&optional (collapse-p t))
  (#_CollapseAllWindows collapse-p))

;;;----------------------------------------------------------------------

(provide :appearance-manager)