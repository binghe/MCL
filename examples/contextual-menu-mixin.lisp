;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; contextual-menu-mixin.lisp
;;;
;;; MIX-IN CLASS FOR GIVING VIEWS A CONTEXTUAL MENU
;;;
;;; Copyright ©1996-1998
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
 
;;;----------------------------------------------------------------------
;;; Important Note:
;;;
;;; If you are using Dan S. Camper's excellent drag-and-drop library, be 
;;; sure to load it *before* loading this file. You can do that by 
;;; un-commenting the following two lines:


;;; The above caveat no longer applies - akh

#|

(eval-when (:compile-toplevel :load-toplevel :execute) 
  (require :drag-and-drop))

|#
;;; *contextual-menu-cursor* is in MCL now
;;; ----- 5.2b6
;;; akh 01/30/03 = remove call to help-string since it isn't here anymore
;;; 09/03/01 akh dont call AEDisposeDesc on a null-ptr
;;; 02/09/00 some thing for new interfaces -  #$gestaltcontextualmenupresent is gonzo
;;; 12/10/99 akh@tiac.net 
;;; This version does not do anything with or to MCL's process-event function. 
;;; (Process-event differs between MCL versions. The modified copy previously used herein does not work in MCL 4.3)
;;; Basically this version hooks into the MCL event system differently but is otherwise almost the same as the original.
;;; We define a view-click-event-handler method for contextual-menu-mixin and advise the MCL functions
;;; window-do-first-click and cursorhook.
;;; We don't show the *contextual-menu-cursor* when *modal-dialog-on-top* unless the mouse is within
;;; a contextual-menu-mixin view contained in the top modal dialog.
;;; We do the initialization at load time and application startup time.
;;; We look for the  contextual-menu-cursor resource in this file where it now is, then in examples folder, then ask.
;;; Fix for contextual-menu-mixin view containing subviews.
;;; Change contextual-menu-key-p to be true for control-key with no other modifiers vs with other modifiers.
;;; Add and use method contextual-menu-cursor.
;;; Added some more example code in comment at the end of the file.




;;; Last Updated: 1/6/99
;;;
;;; Changes since previous version:
;;;
;;;  1. Change slot & accessor from menu to contextual-menu to prevent
;;;     possible name conflicts (thanks to Terje Norderhaug for the
;;;     suggestion).
;;;  2. Modify copyright to be less restrictive.
;;;  3. Minor formatting changes.
;;;
;;; Changes since previous version:
;;;
;;;   1. Return value of pre-contextual-menu-click is now ignored
;;;   2. New methods: show-help-p, show-help-title, and show-help-action
;;;      allow you to use the help menu item at the top of the menu.
;;;   3. The inBalloonAvailable parameter is now passed as true when 
;;;      the view has a help string, but no baloon help item appears 
;;;      in the menu. I think this is an OS bug.
;;;   4. In emulated mode, call pop-up-menu-select at 1 pixel below
;;;      current mouse loc, to look more like a real CM.
;;;   5. Included small example by David B. Lamkins.
;;;   6. Include the updated CMM 1.0.2 SDK and extension
;;;
;;;
;;; Changes since first version:
;;;
;;;   1. Change package from :cl-user to :ccl
;;;   2. Hook into process-event like drag-and-drop library does, instead
;;;      of using eventhook.
;;;   3. New method contextual-menu-view-p determines whether or not menu 
;;;      will be shown, instead of pre-contextual-menu-click.
;;;   4. Rename get-data => get-contextual-menu-data
;;;   5. Add emulation mode so contextual menus can be used even when
;;;      contextual menu extension is not present.

;;;
;;;  Exported symbols:
;;;
;;;
;;;   INIT-CONTEXTUAL-MENUS &optional emulate-if-unavailable   [function]
;;;
;;;     Should be called at initialization. If emulate-if-unavailable is
;;;   non-nil (the default) and the contextual menu extension is not 
;;;   present, contextual menu behavior will be emulated using a pop-up
;;;   menu. The behavior is the same, except that no plug-ins will
;;;   be used and there will be no help item at the top of the menu.
;;;
;;;
;;;   CONTEXTUAL-MENU-MIXIN                                       [class]
;;;
;;;     This mix-in class must appear _before_ any subclass of simple-view
;;;   in the precedence list in order for things to work properly. The
;;;   class contains a slot called menu (initarg :menu), which should 
;;;   contain either an instance of pop-up-menu or nil.
;;;
;;;
;;;   CONTEXTUAL-MENU-VIEW-P                           [generic-function]
;;; 
;;;     This function should return non-nil if the view is prepared to show
;;;   its contextual menu, and nil otherwise.
;;;
;;;
;;;   PRE-CONTEXTUAL-MENU-CLICK view where             [generic-function]
;;;
;;;     Called just before the contextual menu is shown, in case you want
;;;   to hilite the object which owns the menu. Return value is ignored.
;;;
;;;
;;;   GET-CONTEXTUAL-MENU-DATA view                    [generic-function]
;;;
;;;     This function should return three values: a mac pointer to the data,
;;;   the size of the data (in bytes), and the AppleEvent type of the
;;;   data. This information is used to pass the current selection to any
;;;   Contextual Menu plugins. If there is no selection, just 
;;;   call-next-method or return (values nil 0 #$typeNull). This function 
;;;   is only called when *contextual-menu-mode* is :real.
;;;
;;;
;;;   SHOW-HELP-P view                                 [generic-function]
;;;
;;;     Should return t if the help item in the contextual menu should
;;;   be enabled. Only called when *contextual-menu-mode* is :real.
;;;
;;;
;;;   SHOW-HELP-TITLE view                             [generic-function]
;;;
;;;     Accessor to a slot in the view which holds the title of the help
;;;   item at the top of the contextual menu. Only called when 
;;;   *contextual-menu-mode* is :real.
;;;
;;;
;;;   SHOW-HELP-ACTION view                            [generic-function]
;;;
;;;     This method is called when the user selects the help item from
;;;   the contextual menu. The default method calls the function in
;;;   the show-help-action-function slot, similar to dialog-item-action
;;;   and dialog-item-action-function.
;;;
;;;   CONTEXTUAL-MENU-CURSOR view                       [generic-function]
;;;
;;;    This method should return the cursor to show when the mouse is over view. 
;;;   A value of NIL means no cursor change. The default method returns 
;;;   *contextual-menu-cursor*. (akh -new generic function)
;;; 
;;;
;;;
;;; Init-contextual-menus attempts to load the contextual menu cursor,
;;; which is included in the file "contextual-menu-cursor.rsrc". Be sure 
;;; that the file (or another file containing that resource) is in the 
;;; current resource path before calling init-contextual-menus.

;;; akh - some of the above advice does not apply in this version.
;;; The cursor is now defined in MCL.
;;;
;;; Included with this package is the file "ContextualMenu.lisp". You
;;; should put that file in your "ccl:library;interfaces;" folder and
;;; call (reindex-interfaces) before compiling this file. The shared 
;;; library "ContextualMenu" should be put in the same folder as MCL 
;;; or in the extensions folder. Both these files can be found in the
;;; "SDK" folder

;;; akh -the interfaces file "ccl:interfaces;contextualmenu.lisp" is included 
;;;      and indexed in MCL 4.3 and later.

;;;----------------------------------------------------------------------

(in-package :ccl)

(export '(init-contextual-menus
          contextual-menu-mixin 
          contextual-menu-view-p
          pre-contextual-menu-click
          show-help-p
          show-help-title
          show-help-action
          get-contextual-menu-data
          contextual-menu-cursor))

;;;----------------------------------------------------------------------
;;; External requirements

#-carbon-compat
(eval-when (:compile-toplevel :load-toplevel :execute)
  ;; 68K gets warnings about mathlib & interfacelib - sigh
  #+(and PPC-TARGET (not CARBON-COMPAT))
  (add-to-shared-library-search-path "ContextualMenu" t)
  ;; perhaps don't do this since it's usage fails to work
  (require :help-manager))




;;;----------------------------------------------------------------------
;;; Constants & Variables

(defconstant +contextual-menu-cursor-id+ 6610)

(defvar *contextual-menu-mode*   nil)
;(defparameter *contextual-menu-cursor* nil)
;(defvar *original-cursorhook*    nil)

;;;----------------------------------------------------------------------
;;; Initialization and testing

(defun init-contextual-menus (&optional (emulate-if-unavailable-p t))
  (setq *contextual-menu-mode* nil)
  (let* ((flags (gestalt #$gestaltcontextualmenuattr)))
    (when (or (and flags
                   ;(logbitp #$gestaltcontextualmenupresent flags) ;; screw - is not defined in new interfaces
                   (logbitp #$gestaltcontextualmenutrapavailable flags)
                   (eq (#_initcontextualmenus) #$noerr)
                   (setq *contextual-menu-mode* :real))
              (and emulate-if-unavailable-p
                   (setq *contextual-menu-mode* :emulated)))
      (unless (and *contextual-menu-cursor*
                   ;(handlep *contextual-menu-cursor*)  ;; its a macptr not handle
                   )
        (setq *contextual-menu-cursor* (#_getcursor +contextual-menu-cursor-id+))
        (when (%null-ptr-p *contextual-menu-cursor*)
          (warn "unable to load contextual menus cursor (id ~d)" 
                +contextual-menu-cursor-id+)))
      t)))

;;;----------------------------------------------------------------------
;;; For compatability with Dan S. Camper's drag-and-drop library, we
;;; define a dummy %handle-drag-gesture function which we call in our
;;; pached process-event. If drag-and-drop has already been loaded, we
;;; use its version of %handle-drag-gesture.

#| ;; not needed here - we don't do anything with process-event now
(unless (fboundp '%handle-drag-gesture)
  
  (defun %handle-drag-gesture (event)
    (process-multi-clicks event)
    nil)

  )
|#


#| ;; see %handle-contextual-menu-click-for-view instead
(defun %handle-contextual-menu-click (event &aux wptr window view)
   (rlet ((wptr-ptr :WindowPtr))
     (when (and (or (and (eq *contextual-menu-mode* :real)
                         (#_IsShowContextualMenuClick event))
                    (and (eq *contextual-menu-mode* :emulated)
                         (contextual-menu-key-p)))
                ;;  process-multi-clicks has been done by process-event
                (not #|(and (%i< (%i- (rref event eventrecord.when) *last-mouse-down-time*)
                               (#_Getdbltime))
                          (double-click-spacing-p *last-mouse-down-position*
                                                  (rref event eventrecord.where))))|#
                     (double-click-p))
                (when (eq (#_FindWindow (rref event :EventRecord.where) wptr-ptr)
                          #$inContent)
                  (setq wptr (%get-ptr wptr-ptr))
                  (and (not (%null-ptr-p wptr))
                       (setq window (window-object wptr))
                       (setq view (find-view-containing-point 
                                   window
                                   (global-to-local window (rref event :EventRecord.where))))
                       (contextual-menu-view-p view))))
       (unless (or (%ptr-eql wptr (#_FrontWindow))
                   (eq window (front-window)))
         (window-select-event-handler window)
         (window-update-event-handler window))
       (contextual-menu-click-event-handler 
        view
        (global-to-local (focusing-view view) (rref event :EventRecord.where)))
       t)))
|#

(defun contextual-menu-click-p (event)
  ;; assume we know its a click event (esp when emulated)
  (or (and (eq *contextual-menu-mode* :real)
           (#_IsShowContextualMenuClick event))
      (and (eq *contextual-menu-mode* :emulated)
           (contextual-menu-key-p event))))

;; simpler because we know view and where now
(defun %handle-contextual-menu-click-for-view (view where event)
  (when (and (contextual-menu-click-p event)
             ;;  process-multi-clicks has been done by process-event
             (not #|(and (%i< (%i- (rref event eventrecord.when) *last-mouse-down-time*)
                               (#_LMGetdoubletime))
                          (double-click-spacing-p *last-mouse-down-position*
                                                  (rref event eventrecord.where))))|#
                  ;; a second click a) dismisses or choses from the menu and b) is not seen by us
                  ;; so below is only true if 3 quick clicks?
                  (double-click-p)))
    (contextual-menu-click-event-handler view where)
    t))
        

#| ;; Copying then modifying some version of process-event is not recommended. It differs between MCL versions.
;; In particular the code below breaks two things in MCL 4.3 (modal-dialogs will not be modal
;; and the eventhook argument to modal dialog will be ignored)
;; Advising cursorhook is pretty much the same as below.
(without-interrupts
 ;;
 ;; bad things can happen if process-event gets called in the middle of 
 ;; this business here.
 ;;

 (let ((*warn-if-redefine-kernel* nil)
       (*warn-if-redefine* nil))
   
   ;;;----------------------------------------------------------------------
   ;;; Hook into MCL's event system, in order to trap mouseDowns and check
   ;;; for contextual menu clicks.
   
   (defun process-event (event)
     (let ((e-code (rref event eventrecord.what))
           (handled-p nil))
       (when (eq e-code #$mouseDown)
         (setf handled-p (or (%handle-contextual-menu-click event) 
                             (%handle-drag-gesture event))))
       (let* ((*current-event* event))
         (declare (special *current-event* *processing-events*))
         (unless handled-p
           (block foo
             (with-restart *event-abort-restart*
               (let ((eventhook *eventhook*))
                 (unless (and eventhook
                              (flet ((process-eventhook (hook)
                                       (unless (memq hook *eventhooks-in-progress*)
                                         (let ((*eventhooks-in-progress*
                                                (cons hook *eventhooks-in-progress*)))
                                           (declare (dynamic-extent *eventhooks-in-progress*))
                                           (funcall hook)))))
                                (declare (inline process-eventhook))
                                (if (listp eventhook)
                                  (dolist (item eventhook)
                                    (when (process-eventhook item) (return t)))
                                  (process-eventhook eventhook))))
                   (return-from foo (catch-cancel (do-event)))))))
           e-code))))
   
   ;;;----------------------------------------------------------------------
   ;;; Hook into MCL's cursorhook, so we can set the cursor for windows that
   ;;; aren't in front
   
   (unless *original-cursorhook*
     (setq *original-cursorhook* (symbol-function 'cursorhook)))
   
   (defun cursorhook (&aux view)
     (if (and *contextual-menu-mode*
              (contextual-menu-key-p)
              (rlet ((pt :point)
                     (wptr-ptr :pointer))
                (#_GetMouse pt)
                (#_LocalToGlobal pt)
                (when (eq (#_FindWindow (%get-point pt) wptr-ptr)
                          #$inContent)
                  (with-macptrs ((wptr (%get-ptr wptr-ptr)))
                    (and (not (%null-ptr-p wptr))
                         (setq view (window-object wptr))
                         (setq view (find-view-containing-point
                                     view
                                     (global-to-local view (%get-point pt))))
                         (contextual-menu-view-p view))))))
       (set-cursor *contextual-menu-cursor*)
       (funcall *original-cursorhook*)))
   
   ) ; end of (*warn-if-redefine* nil)



 ) ; end of without-interrupts
|#

;;;----------------------------------------------------------------------
;;; Utility functions and methods for the above

#|
;; akh changed to control-key ONLY - no other mods
(defun contextual-menu-key-p ()
  (key-down-p 59))  
|#

;; could change this to do other key combos and forget #_IsShowContextualMenuClick.
;; Or is there some notion re "consistency with other applications"?
(defun contextual-menu-key-p (&optional event)
  (if event
    (let ((mods (rref event eventrecord.modifiers)))
      (declare (fixnum mods))
      (and (logtest #$controlkey mods)
           (eql 0 (logand mods (logior #$cmdkey #$optionkey #$shiftkey)))))
    (rlet ((p :keymap))
      (#_getkeys p)
      ;; #. because compiler generates extra code for e.g. (values 4 5) in %get-byte context
      (and (%ilogbitp (rem 59 8) (%get-byte p #.(truncate 59 8)))  ;; control
           (not (%ilogbitp (rem 55 8) (%get-byte p #.(truncate 55 8)))) ;; command
           (not (%ilogbitp (rem 58 8) (%get-byte p #.(truncate 58 8)))) ;; option
           (not (%ilogbitp (rem 56 8) (%get-byte p #.(truncate 56 8)))))))) ;; shift


(defmethod focusing-view ((view simple-view))
  (view-container view))

(defmethod focusing-view ((view view))
  view)

(defmethod contextual-menu-view-p ((view simple-view))
  nil)

;; these are also in quickdraw.lisp
(unless (fboundp 'local-to-global)  
  (defmethod local-to-global ((view simple-view) h &optional v)
    (with-focused-view view
      (rlet ((p :point))
        (%put-long p (make-point h v))
        (#_LocalToGlobal p)
        (%get-long p)))))

(unless (fboundp 'global-to-local)
  (defmethod global-to-local ((view simple-view) h &optional v)
    (with-focused-view view
      (rlet ((p :point))
        (%put-long p (make-point h v))
        (#_GlobalToLocal p)
        (%get-long p)))))

;;;----------------------------------------------------------------------
;;; The Class

(defclass contextual-menu-mixin ()
  ((contextual-menu :accessor contextual-menu :initarg :contextual-menu)
   (show-help-title :accessor show-help-title :initarg :show-help-title)
   (show-help-action-function :accessor  show-help-action-function
                              :initarg  :show-help-action))
  (:default-initargs
    :contextual-menu   nil
    :show-help-action  nil
    :show-help-title  "Help"))

;;; ---------------------------------------------------------------------
;;; New method for existing generic function

(defmethod view-click-event-handler ((view contextual-menu-mixin) where)
  (or (%handle-contextual-menu-click-for-view view where *current-event*)
      (call-next-method)))

;;;----------------------------------------------------------------------
;;; Exported methods

(defmethod get-contextual-menu-data ((view contextual-menu-mixin))
  (values nil 0 #$typeNull))

(defmethod pre-contextual-menu-click ((view contextual-menu-mixin) where)
  (declare (ignore where)))

(defmethod contextual-menu-view-p ((view contextual-menu-mixin))
  (not (null (contextual-menu view))))

(defmethod show-help-p ((view contextual-menu-mixin))
  (and (show-help-title view) (show-help-action-function view)))

(defmethod show-help-action ((view contextual-menu-mixin))
  (let ((fn (show-help-action-function view)))
    (when fn
      (funcall fn view))))

;; akh - new method
(defmethod contextual-menu-cursor ((view contextual-menu-mixin))
  *contextual-menu-cursor*)

;;;----------------------------------------------------------------------
;;; Private methods

(defmethod contextual-menu-click-event-handler ((view contextual-menu-mixin) 
                                                where)
  (let ((menu (contextual-menu view)))
    (unless menu
      (return-from contextual-menu-click-event-handler nil))
    (unless (menu-installed-p menu)
      (setf (pop-up-menu-auto-update-default menu) nil)
      (menu-install menu))
    (when (menu-items menu)
      (set-pop-up-menu-default-item menu 0))
    (pre-contextual-menu-click view where)
    (case *contextual-menu-mode*
      (:real (real-contextual-menu-click view menu where))
      (:emulated (emulated-contextual-menu-click view menu where)))))

(defmethod real-contextual-menu-click ((view contextual-menu-mixin)
                                       (menu pop-up-menu)
                                       where)
  (with-focused-view (focusing-view view)
    (menu-update menu)
    (multiple-value-bind (data-ptr data-size data-type) (get-contextual-menu-data view)
      (rlet ((data-desc      :AEDesc)
             (selection-type :unsigned-long)
             (menu-id        :signed-word)
             (menu-item      :unsigned-word))
        (let ((handle (menu-handle menu))
              (help-p (show-help-p view))
              result
              selected-menu
              selected-item)
          (if (and data-ptr (> data-size 0))
            (unless (eq (#_AECreateDesc data-type data-ptr data-size data-desc) 
                        #$noErr)
              (%setf-macptr data-desc (%null-ptr)))
            (%setf-macptr data-desc (%null-ptr)))
          (with-pstrs ((help-pstr (if help-p
                                    (show-help-title view)
                                    "")))
            (setq result (#_ContextualMenuSelect
                          handle
                          (local-to-global (focusing-view view)
                                           where)
                          nil ;(stringp (help-string view))
                          (if help-p
                            #$kCMHelpItemOtherHelp
                            #$kCMHelpItemNoHelp)
                          help-pstr
                          data-desc
                          selection-type
                          menu-id
                          menu-item)))
          (when (and data-desc (not (%null-ptr-p data-desc)))
            (#_AEDisposeDesc data-desc))
          (when (eq result #$noErr)
            (let ((type (%get-unsigned-long selection-type)))
              (cond ((eq type #$kCMMenuItemSelected)
                     (setq selected-menu (menu-object (%get-signed-word menu-id))
                           selected-item (%get-unsigned-word menu-item))
                     (when (and selected-menu (neq selected-item 0))
                       (with-event-processing-enabled 
                         (menu-item-action (nth (1- selected-item) 
                                                (menu-items selected-menu))))))
                    ((eq type #$kCMShowHelpSelected)
                     (with-event-processing-enabled 
                       (show-help-action view)))))))))))

(defmethod emulated-contextual-menu-click ((view contextual-menu-mixin)
                                           (menu pop-up-menu)
                                           where)
  (with-focused-view (focusing-view view)
    (menu-update menu)
    (let ((handle (menu-handle menu))
          (loc (local-to-global (focusing-view view) where))
          selection
          selected-menu
          selected-item)
      (with-cursor (window-cursor (view-window view))  ;; ?? lose the contextual menu cursor
        (setq selection (#_PopUpMenuSelect
                         :handle handle 
                         :word   (1+ (point-v loc))
                         :word   (point-h loc)
                         :word   0)
              selected-menu (menu-object (ash selection -16))
              selected-item (logand #xFFFF selection)))
      (when (and selected-menu (neq selected-item 0))
        (with-event-processing-enabled
          (menu-item-action (nth (1- selected-item) 
                                 (menu-items selected-menu))))))))

;;; some advice and support for it

(defun maybe-contextual-menu-cursor (&aux view window cursor)
  (declare (ignore-if-unused view))
  (if (and *contextual-menu-mode*
           (contextual-menu-key-p)
           (rlet ((pt :point)
                  (wptr-ptr :pointer))
             (#_GetMouse pt)
             (#_LocalToGlobal pt)
             (when (eq (#_FindWindow (%get-point pt) wptr-ptr)
                       #$inContent)
               (with-macptrs ((wptr (%get-ptr wptr-ptr)))
                 (and (not (%null-ptr-p wptr))
                      (setq window (window-object wptr))
                      (setq view (find-contextual-menu-view window (%get-point pt)))
                      (setq cursor (contextual-menu-cursor view))))))
           (or (not *modal-dialog-on-top*)(eq window (caar *modal-dialog-on-top*))))
    (progn (set-cursor cursor) t)))

;; just used as predicate - don't care where in heirarchy its found as long as the found view contains mouse pos 
;; and contextual-menu-view-p of it is true. The contextual-view may contain one or more subviews. (or overlap)

(defmethod find-contextual-menu-view ((view simple-view) where)  ;; where is container coords - or global if window
  (if (and (view-contains-point-p view where)
           (contextual-menu-view-p view))
    view
    (progn
      (setq where (if (view-container view)
                    (convert-coordinates where (view-container view) view)
                    (global-to-local view where)))
      (dovector (subview (view-subviews view))
        (let ((res (find-contextual-menu-view subview where)))
          (when res (return res)))))))    

(advise cursorhook (or (maybe-contextual-menu-cursor) (:do-it))
        :when :around :name contextual-cursor) 

;;; some more advice

(defun maybe-do-first-click (w)
  (when *contextual-menu-mode*
    (let* ((event *current-event*)
           (where (pref event eventrecord.where)))
      (and (contextual-menu-click-p event) (find-contextual-menu-view w where)))))

(advise window-do-first-click (or (maybe-do-first-click (car arglist))(:do-it))
        :when :around :name contextual-first-click)

;;;----------------------------------------------------------------------
;;;  more initialization
#|
(defun find-cursor-in-res-file (Res-file)
  (let* ((refnum (and res-file (open-resource-file res-file :direction :input)))
         cursor)
    (when refnum
      (unwind-protect
        (progn
          (setq cursor (#_getcursor +contextual-menu-cursor-id+))
          (when (and cursor (not (%null-ptr-p cursor)))
            (#_detachresource cursor)
            (setq *contextual-menu-cursor* cursor)))
        (close-resource-file refnum)))))
|#

(defvar *contextual-menu-source-file* nil)

;;;  do the initialization - first try to find the cursor then do the rest
#|
(def-load-pointers find-menu-cursor ()
  (require :resources)
  (block foo
    (flet ((got-it? ()
             (and *contextual-menu-cursor*
                  (handlep *contextual-menu-cursor*)))
           (get-it (file)
             (let* ((res-file (probe-file file)))
               (when res-file (find-cursor-in-res-file res-file)))))
      (let ((cursor))
        (setq cursor (#_getcursor +contextual-menu-cursor-id+))
        (when (and cursor (not (%null-ptr-p cursor)))
          (setq *contextual-menu-cursor* cursor)
          (return-from foo)))
      (when (and *loading-file-source-file*) ; (not *contextual-menu-source-file*))
        (setq *contextual-menu-source-file* *loading-file-source-file*))
      (unless (got-it?)
        (setq *contextual-menu-cursor* nil)
        (when *contextual-menu-source-file* (get-it *contextual-menu-source-file*))
        (unless (got-it?)
          (get-it "ccl:examples;contextual-menu-mixin.lisp")
          (unless (got-it?)
            (get-it "ccl:examples;contextual-menu-cursor.rsrc")
            (unless (got-it?)
              (get-it (choose-file-dialog :mac-file-type :|RSRC|)))))))))
|#

(def-load-pointers init-contextual-menus ()
  (init-contextual-menus))

;;;----------------------------------------------------------------------

(provide :contextual-menu-mixin)

#|
;;;----------------------------------------------------------------------
;;; Sample code - thanks to David B. Lamkins


;; Define a kind of window to show our contextual menu.
(defclass cm-window (contextual-menu-mixin window)())


;; Open the CM cursor's resource file, contextual-menu-cursor.rsrc. Its already done now.
;(INIT-CONTEXTUAL-MENUS)

;; Control-click in this window.
(setq w (make-instance 'cm-window
  :window-title "Control-click in this window"
  ;:window-show nil
  :show-help-title "Help Me?"
  :show-help-action #'(lambda (window)
                        (declare (ignore window))
                        (print "Did you ask for help?"))
  :contextual-menu
  (make-instance 'pop-up-menu
    :menu-items (list
                 (make-instance 'menu-item
                   :menu-item-title "Try a Foo"
                   :menu-item-action #'(lambda ()
                                         (print "Wouldn't you rather have a Bar?")))
                 (make-instance 'menu-item
                   :menu-item-title "Bar is better"
                   :menu-item-action #'(lambda ()
                                         (print "Stick with the Foo!")))))))
;(modal-dialog w)

;;; more sample code from akh - contextual-menu-views containing subviews

(defclass foo-view (view) ())

(defmethod view-click-event-handler ((view foo-view) where)
  ;(declare (ignore where))
  (if (eq view (find-clicked-subview view where))
    (print "FOOLISH")
    (call-next-method)))

(defmethod view-draw-contents ((view foo-view))
  (with-focused-view (view-container view) ;; need focus if foo-view is a view, but not if simple-view
    (with-item-rect (rect view)
      (#_framerect rect)))
  (call-next-method))

(defclass cm-foo-view (contextual-menu-mixin foo-view)())

;; didn't work because the contextual menu view has subviews which may not be contextual-menu-views
;;  - fixed now by using find-contextual-menu-view vs. find-view-containing-point
;; see also the fred-window example below

(make-instance 'window :window-title "Subview"
  :view-subviews
  (list (make-instance 'cm-foo-view
          :view-position #@(50 50)
          :view-size #@(100 100)
          :view-subviews (list (make-instance 'fred-dialog-item :allow-returns t
                                 :dialog-item-text "asdf" :view-size #@(40 60) :view-position #@(6 6)))
          :show-help-title "Help Me?"
          :show-help-action #'(lambda (window)
                                (declare (ignore window))
                                (print "Did you ask for help?"))
          :contextual-menu
          (make-instance 'pop-up-menu
            :menu-items (list
                         (make-instance 'menu-item
                           :menu-item-title "Try a Foo"
                           :menu-item-action #'(lambda ()
                                                 (print "Wouldn't you rather have a Bar?")))
                         (make-instance 'menu-item
                           :menu-item-title "Bar is better"
                           :menu-item-action #'(lambda ()
                                                 (print "Stick with the Foo!"))))))))

;;; stuff that makes pop-up titles vary with position in above view

;; don't mess with the menu for predicate - we assume it always has a contextual-menu
(defmethod contextual-menu-view-p ((view cm-foo-view)) t) 

;; menu item titles vary with mouse position
(defmethod contextual-menu ((view cm-foo-view))
  (let* ((pop-up (slot-value view 'contextual-menu))
         (mouse-pos (view-mouse-position view))
         (item (elt (menu-items pop-up) 0)))
    (if (eq view (find-view-containing-point view mouse-pos)) ;; is it this view or a subview?
      (set-menu-item-title item "Out of phase")
      (set-menu-item-title item "Try a Foo"))
    pop-up))

;;; just for fun - a fred-window with a contextual-menu that contains the enabled
;;; items of the edit menu for the current state of that fred-window.

(defparameter *fred-contextual-menu* (edit-menu))  ;; or *file-menu* or whatever
(defvar *fred-pop-up-menu*)
(defvar *fred-pop-up-items*)  ;; list of menu items matching those in *fred-contextual-menu* with different owner

(defun init-fred-pop-up ()
  (let* ((pop-up (make-instance 'pop-up-menu))
         (items (menu-items *fred-contextual-menu*))
         (new-items (copy-menu-items items)))
    ;(apply 'add-menu-items pop-up new-items)    
    (setq *fred-pop-up-menu* pop-up)
    (setq *fred-pop-up-items* new-items)
    pop-up))

(defmethod reinitialize-instance ((new-menu menu) &rest initargs)
  (declare (ignore initargs))
  (setf (slot-value new-menu 'item-list) nil)
  (setf (slot-value new-menu 'menu-handle) nil)
  (setf (slot-value new-menu 'owner) nil)
  (setf (slot-value new-menu 'menu-id) nil)
  (call-next-method))

(defmethod reinitialize-instance ((new-menu font-menu) &rest initargs)
  (declare (ignore initargs))
  (setf (slot-value new-menu 'selection-fonts) (make-array 2 :adjustable t :fill-pointer 0))
  (setf (slot-value new-menu 'attribute-values) (make-array 1 :adjustable t :fill-pointer 0))
  (call-next-method))

(defmethod copy-menu-element ((menu menu))
  (let* ((new-menu (copy-instance menu))
         (new-items (copy-menu-items (menu-items menu))))
    (reinitialize-instance new-menu)
    (apply 'add-menu-items new-menu new-items)
    new-menu))

(defmethod copy-menu-element ((item menu-item))
  (let ((new (copy-instance item)))
    (setf (slot-value new 'owner) nil)
    new)) 

(defun copy-menu-items (items)
  (let ((new-items ()))
    (dolist (item items)
      (let ((new (copy-menu-element item)))
        (push new new-items)))
    (nreverse new-items)))

(init-fred-pop-up)

(defclass cm-fred-window (contextual-menu-mixin fred-window)
  ((contextual-menu-items :initarg :contextual-menu-items :initform *fred-pop-up-items*))
  (:default-initargs :contextual-menu *fred-pop-up-menu*))

(make-instance 'cm-fred-window)

;; stuff below to just show enabled menu-items
;; we assume the original menu is in the menubar and may have something to do with the state of (front-window)
;; we assume desired window is now frontmost 

(defmethod contextual-menu-view-p ((w cm-fred-window)) t) ;; dont rebuild the menu for predicate 

(defmethod contextual-menu ((window cm-fred-window))
  (when (neq window (front-window)) (error "front window is ~s, expected ~s ." (front-window) window))
  (let ((items (menu-items *fred-contextual-menu*))
        (pop-up (slot-value window 'contextual-menu))
        (pop-up-items (slot-value window 'contextual-menu-items)))
    (menu-update *fred-contextual-menu*)    ;; get it in sync with state of front-window
    (apply 'remove-menu-items pop-up (menu-items pop-up))
    (do* ((f-items items (cdr f-items))
          (p-items pop-up-items (cdr p-items)))
         ((or (null f-items)(null p-items)))
      (let ((item (car f-items)))
        (when (or (menu-item-enabled-p item)(string-equal (menu-item-title item) "-"))
          (let ((new (car p-items)))
            (set-menu-item-title new (menu-item-title item))  ;; for open selection if using file-menu         
            (add-menu-items pop-up new)
            (when (menu-item-enabled-p item)(menu-item-enable new))))))
    pop-up))

;; could do below if one wishes - conflicts with drag-and-drop fred-drag example
;;  - also the cursor is disconcerting when control-key for reasons other than contextual-menu

;; (setq *default-editor-class* 'cm-fred-window)

;; possible usage of specializing contextual-menu-cursor
#+maybe
(defmethod contextual-menu-cursor ((view cm-fred-window))
  (if (eq (view-window view)(front-window)) nil (call-next-method)))
 

;;;----------------------------------------------------------------------
|#