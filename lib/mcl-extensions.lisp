; -*- Mode: Lisp; Package: CCL; -*-

;;	Change History (most recent first):
;;  3 7/4/97   akh  ift loaded-p test
;;  2 4/1/97   akh  see below
;;  8 1/22/97  akh  add more :loaded-p-functions because module-loaded-p is not cheap
;;  (do not edit before this line!!)

;
; mcl-extensions.lisp - Extensions menu
;
; Copyright 1996-2000 Digitool, Inc.

;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; lose platinum pop up menus
;; ----- 5.1b2
;; replace source-server with compare/merge
;; ------- 5.0final
;; platinum-pop-up-menu just sets *use-pop-up-control* if osx-p
;; lose some if carbon
;; ------- 4.4b1
;; add font search and drag and drop
;; --------- 4.3
;; 12/24/99 akh cancel button is second for escape key
;; 12/05/99 akh add defsystem and font-color-palette
;; 06/26/99 akh  don't do new-file-dialogs when *nav-services-available*
;; ---------- 4.3b3
;; 06/20/97 akh   loaded-p fn for ift was wrong
;; 03/24/97 akh   add mouse-copy, make dialog movable
;; 12/09/96 akh   add more :loaded-p-functions because module-loaded-p is not cheap
;; 09/30/96 bill  add some :loaded-p-function's
;;  9/26/96 slh   only eval-enqueue the save-application call; with-loading-indication
;;  9/24/96 slh   remove ellipsis from Extensions item name
;;  9/23/96 slh   loaded-p-function key & support; export & document define-mcl-extension
;;                 remove-mcl-extensions; defvar *pre-extensions-room* -> defparameter
;;  9/18/96 slh   use declaim ftype to avoid warnings
;; 09/07/96 gb    missing arg in cerror call; defvar->defparameter
;;  9/04/96 slh   do-save-new-image: eval-enqueue the save-application
;; 08/28/96 bill  handler-bind instead of ignore-errors in load-mcl-extension
;;                Put GC & File thermometers together and push a form on *lisp-startup-functions*
;; -------------  4.0b1
;;

#| TO DO:
- add help strings
- save dialog configuration between sessions
- construct list from new "Extensions" folder
  (how to get help strings from them?)
|#

(in-package "CCL")

(export 'define-mcl-extension)

(defstruct mcl-extension
  title
  module
  load-fn
  menu-item
  dialog-item
  loaded-p
  loaded-p-fn)

(defparameter *mcl-extensions* nil)
(defvar *mcl-extensions-item* nil)
(defparameter *pre-extensions-room* nil)


(defun available-ram ()
  (gc)
  (+ (%freebytes) (#_FreeMem)))

(eval-when (:execute :compile-toplevel)
  (defmacro with-loading-indication ((title) &body body)
    (let ((listener (gensym)))
    `(with-cursor *watch-cursor*
       (let ((,listener (front-window :class *default-listener-class*))) 
         (when ,listener
           (set-mini-buffer ,listener "~&Loading \"~A\"… " ,title))
         (progn ,@body)
         (when ,listener
           (set-mini-buffer ,listener "Done.")))))))

(defun load-mcl-extension (ext)
  (unless *pre-extensions-room*
    (setq *pre-extensions-room* (available-ram)))
  (let ((title (mcl-extension-title ext)))
    (multiple-value-prog1
      (handler-bind ((serious-condition #'(lambda (error)
                                            (block error
                                              (block grant
                                                (catch-cancel
                                                  (y-or-n-dialog
                                                   (format nil "An error occurred trying to load extension \"~A\":~%~A~%~%~
                                                                Signal the error or cancel?"
                                                           title error)
                                                   :size #@(350 220)
                                                   :yes-text "Cancel"
                                                   :cancel-text "Signal"
                                                   :no-text nil)
                                                  (return-from grant))
                                                (return-from error nil))
                                              (cancel)))))
        (with-loading-indication (title)
          (funcall (mcl-extension-load-fn ext) (mcl-extension-module ext))))
      (extension-loaded ext))))

(defun extension-loaded (extension)
  (setf (mcl-extension-loaded-p extension) t)
  (menu-item-disable (mcl-extension-menu-item extension))
  (let ((dialog-item (mcl-extension-dialog-item extension)))
    (check-box-check dialog-item)
    (dialog-item-disable dialog-item)))

(defun module-loaded-p (module)
  "Returns true if the module named by the string or symbol MODULE is on the *MODULES* list."  
  (member (string module) *modules* :test #'string-equal))

(defun define-mcl-extension (title module &key (load-fn 'require) help-spec (loaded-p-function 'module-loaded-p))
  "Defines a module for the Tools/Extensions submenu and Load Multiple… dialog.
TITLE is a string describing the module.
MODULE is the module name as a keyword.
LOAD-FN, if specified, is a function (or symbol naming a function) which takes the module
 keyword as an argument and loads the module when FUNCALLed. It defaults to REQUIRE.
HELP-SPEC, if specified, is a string or ID that is associated with the dialog item in the Load Multiple… dialog.
LOADED-P-FUNCTION, is specified, is a function (or symbol naming a function) which takes the module
 keyword as an argument and returns true or NIL when FUNCALLed, depending on whether the module is already
 loaded or not. It defaults to MODULE-LOADED-P."
  (let ((old-module (find module *mcl-extensions* :test #'eq :key #'mcl-extension-module)))
    (when old-module
      (cerror "Replace the registered extension"
              "Extension ~S is already registered" module))
    (let* ((menu-item (make-menu-item title nil))
           (dialog-item (make-instance 'check-box-dialog-item
                          :dialog-item-text title))
           (extension (make-mcl-extension :title title
                                          :module module
                                          :load-fn load-fn
                                          :menu-item menu-item
                                          :dialog-item dialog-item
                                          :loaded-p-fn loaded-p-function)))
      (when help-spec
        (setf (view-get dialog-item :help-spec) help-spec))
      (if (funcall loaded-p-function module)
        (extension-loaded extension)
        (set-menu-item-action-function menu-item #'(lambda ()
                                                     ;(eval-enqueue )
                                                     (load-mcl-extension extension))))
      (setq *mcl-extensions* (sort (list* extension (remove old-module *mcl-extensions*))
                                   #'string-lessp
                                   :key #'mcl-extension-title))
      extension)))

(defun find-item-position (menu after-item-title before-item-title)
  (let ((item (find-menu-item menu after-item-title)))
    (if item
      (menu-item-number item)
      (if (setq item (find-menu-item menu before-item-title))
        (1- (menu-item-number item))
        (length (menu-items menu))))))

(defun install-mcl-extensions-item (&optional (menu *tools-menu*)
                                              (after-item-title "Save Application…")
                                              (before-item-title "-"))
  (unless *mcl-extensions-item*
    (setq *mcl-extensions-item*
          (make-instance 'menu
            :menu-title "Extensions"
            :menu-items (list (make-menu-item "Load Multiple…"
                                              'do-mcl-extensions-dialog)
                              (make-menu-item "Save Image…"
                                              'do-save-new-image)
                              (make-menu-item "-"))
            :update-function 'update-mcl-extensions-menu)))
  (unless (menu-owner *mcl-extensions-item*)
    (let* ((menu-items (menu-items menu))
           (position (find-item-position menu after-item-title before-item-title))
           (after-items (subseq menu-items position)))
      (apply #'remove-menu-items menu after-items)
      (unwind-protect
        (add-menu-items menu *mcl-extensions-item*)
        (apply #'add-menu-items menu after-items)))))

(defun remove-mcl-extensions (&optional (extensions *mcl-extensions*))
  (dolist (extension extensions *mcl-extensions*)
    (let ((menu-item (mcl-extension-menu-item extension)))
      (when menu-item
        (remove-menu-items *mcl-extensions-item* menu-item)))
    (setq *mcl-extensions* (delete extension *mcl-extensions*))))

(defun update-mcl-extensions-menu (menu)
  (when (find-if #'(lambda (ext)
                     (null (menu-item-owner (mcl-extension-menu-item ext))))
                 *mcl-extensions*)
    (apply #'remove-menu-items menu (cdddr (menu-items menu)))
    (apply #'add-menu-items menu (mapcar #'mcl-extension-menu-item *mcl-extensions*)))
  (dolist (extension *mcl-extensions*)
    (when (and (not (mcl-extension-loaded-p extension))
               (mcl-extension-loaded-p-fn extension)
               (funcall (mcl-extension-loaded-p-fn extension)
                        (mcl-extension-module extension))
      (extension-loaded extension)))))

(defun load-new-extensions ()
  (dolist (ext *mcl-extensions*)
    (when (and (not (mcl-extension-loaded-p ext))
               (check-box-checked-p (mcl-extension-dialog-item ext)))
      ;(eval-enqueue )
      (load-mcl-extension ext))))

(defun do-save-new-image (&aux ext-room size)
  (when (and *pre-extensions-room*
             (plusp (setq ext-room (- *pre-extensions-room*
                                      (available-ram)))))
    (let ((i 0)
          cur-psize
          cur-msize)
      (flet ((get-sizes (resnum)
               (let ((sizeh (#_Get1Resource "SIZE" resnum)))
                 (unless (%null-ptr-p sizeh)
                   (setq cur-psize (%hget-long sizeh 2)
                         cur-msize (%hget-long sizeh 6))))))
        (while (get-sizes i)
          (incf i))
        (unless cur-psize
          (get-sizes -1)))
      (when cur-psize
        (setq size `(,(+ cur-psize ext-room)
                     ,(+ cur-msize ext-room))))))
  (eval-enqueue
   `(save-application (choose-new-file-dialog :prompt "Save Image As…")
                      :init-file (application-init-file *application*)
                      :size ',size)))

(defun do-mcl-extensions-dialog ()
  (let* ((col-width 200)
         (row-height 20)
         (rows/col 5)
         (items (mapcar #'mcl-extension-dialog-item *mcl-extensions*))
         (num-items (length items))
         (columns (1+ (floor (1- num-items) rows/col)))
         (dialog-height (+ 85 (if (= columns 1)
                                (* num-items row-height)
                                (* row-height rows/col))))
         (dialog-width (max 340 (* columns col-width)))
         (dialog-1/6w (floor dialog-width 6))
         (buttons-y (- dialog-height 30))
         (ok-button (make-dialog-item 'default-button-dialog-item
                                      (make-point (- dialog-1/6w 35)
                                                  buttons-y)
                                      #@(70 20)
                                      "Load"
                                      #'(lambda (item)
                                          (declare (ignore item))
                                          (return-from-modal-dialog t))))
         (save-button (make-dialog-item 'button-dialog-item
                                        (make-point (- (* dialog-1/6w 3) 50)
                                                    buttons-y)
                                        #@(104 20)
                                        "Save Image…"
                                        #'(lambda (item)
                                            (declare (ignore item))
                                            (load-new-extensions)
                                            (do-save-new-image)
                                            (return-from-modal-dialog nil))))
         (cancel-button (make-dialog-item 'button-dialog-item
                                          (make-point (- (* dialog-1/6w 5) 35)
                                                      buttons-y)
                                          #@(70 20)
                                          "Cancel"
                                          #'(lambda (item)
                                              (declare (ignore item))
                                              (return-from-modal-dialog nil)))))
    (do* ((items items (cdr items))
          (item (car items) (car items))
          (index 0 (1+ index)))
         ((null items))
      (set-view-position item
                         (+ 5 (* col-width (floor index rows/col)))
                         (+ 40 (* row-height (mod index rows/col))))
      (set-view-size item (- col-width 10) row-height))        ; do at creation
    (when (modal-dialog (make-instance 'dialog
                          :auto-position :centermainscreen
                          :window-type :movable-dialog
                          :window-title "Load Extensions"
                          :view-size (make-point dialog-width dialog-height)
                          :view-subviews
                          `(,(make-dialog-item 'static-text-dialog-item
                                               #@(0 0)
                                               (make-point dialog-width 40)
                                               "Check the extensions you wish to load. \"Save Image…\" will load them before saving a new image."
                                               nil
                                               :view-font '("Geneva" 12)  ; or geneva 10 :bold?
                                               :text-justification :center)
                            ,@items
                            ,ok-button
                            ,cancel-button
                            ,save-button)))
      (load-new-extensions))))


(define-mcl-extension "Compare/Merge" :sourceserver-subset
  :loaded-p-function #'(lambda (module)
                         (declare (ignore module))
                         (fboundp 'merge-selected-files)))

(define-mcl-extension "Mouse Copy" :mouse-copy
  :loaded-p-function #'(lambda (module)
                         (declare (ignore module))
                         (fboundp 'give-text?)))

(define-mcl-extension "Interface Toolkit" :interface-tools)

#-carbon-compat
(define-mcl-extension "Help Manager" :help-manager
  :loaded-p-function #'(lambda (module)
                         (declare (ignore module))
                         (fboundp 'help-resource-string)))
#-carbon-compat
(define-mcl-extension "New File Dialogs" :new-file-dialogs
  :loaded-p-function #'(lambda (module)
                         (declare (ignore module))
                         (or
                          (boundp 'sf-choose-file-filter)
                          )))
(define-mcl-extension "Assorted Fred Commands" :assorted-fred-commands
  :loaded-p-function #'(lambda (module)
                         (declare (ignore module))
                         (fboundp 'ed-fill-paragraph)))
(define-mcl-extension "Query Replace" :query-replace
  :loaded-p-function #'(lambda (module)
                         (declare (ignore module))
                         (find-class 'qr-search-dialog nil)))
(define-mcl-extension "Fred Word Completion" :fred-word-completion
  :loaded-p-function #'(lambda (module)
                         (declare (ignore module))
                         (fboundp  'display-completion)))
(define-mcl-extension "Auto Fill" :auto-fill
  :loaded-p-function #'(lambda (module)
                         (declare (ignore module))
                         (fboundp 'auto-fill-mode)))

(declaim (ftype (function (&rest t) t) file-thermometer gc-thermometer))
(define-mcl-extension "GC & File Thermometers" :thermometer
  :load-fn #'(lambda (module)
               (declare (ignore module))
               (require "THERMOMETER")
               (flet ((make-thermometers ()
                        (file-thermometer)
                        (gc-thermometer)))
                 (pushnew #'make-thermometers *lisp-startup-functions* :key 'function-name)
                 (make-thermometers)))
  :loaded-p-function #'(lambda (module)
                         (declare (ignore module))
                         (and (fboundp 'gc-thermometer)
                              (fboundp 'file-thermometer))))

(define-mcl-extension "Defsystem" :defsystem
  :loaded-p-function #'(lambda (module)
                         (declare (ignore module))
                         (or (find-package "CL-DEFSYSTEM")
                             (find-package "CLIM-DEFSYSTEM")))) ;; ??

(define-mcl-extension "Font Color Palettte" :font-color-palette
  :loaded-p-function #'(lambda (module)
                         (declare (ignore module))
                         (fboundp 'make-font-color-palette-windoid)))

#+ignore
(define-mcl-extension "Platinum Pop Up Menus" :platinum-pop-up-menus
  :loaded-p-function #'(lambda (module)
                         (declare (ignore module))
                         (or *use-pop-up-control*  (fboundp 'new-draw-pop-up-menu)))
  :load-fn #'(lambda (module)
               (if (osx-p)
                 (setq *use-pop-up-control* t)
                 (require module))))

(define-mcl-extension "Font Search" :font-search
  :loaded-p-function #'(lambda (module)
                         (declare (ignore module))
                         (fboundp 'do-font-search)))

(define-mcl-extension "Drag and Drop" :drag-and-drop
  :loaded-p-function #'(lambda (module)
                         (declare (ignore module))
                         (fboundp 'init-drag-and-drop)))



;(define-mcl-extension "Project Window" :project-ui)
;(define-mcl-extension "ANSI Doc" :ansi-doc)
;(define-mcl-extension "Fred Keystroke Macros" :fred-keystroke-macros)
;(define-mcl-extension "Html Editor" :html-editor)
;(define-mcl-extension "Symbol Completion" :symbol-completion)
;(define-mcl-extension "Drag & Drop" :drag-n-drop)

(defvar *nav-services-available* nil)

(install-mcl-extensions-item)
(queue-fixup
 (def-ccl-pointers foobark ()
   (when (boundp '*nav-services-available*)
     (let ((it  (find :new-file-dialogs *mcl-extensions* :key 'mcl-extension-module)))
       (if *nav-services-available*      
         (when it (remove-mcl-extensions (list it)))
         (when (not it)
           (define-mcl-extension "New File Dialogs" :new-file-dialogs
             :loaded-p-function #'(lambda (module)
                                    (declare (ignore module))
                                    (or
                                     (boundp 'sf-choose-file-filter)
                                     )))))))))
nil


; end
