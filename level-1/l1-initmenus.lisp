;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  8 1/22/97  akh  find-edit-menu faster in the usual case
;;  6 5/20/96  akh  experimental & unused update-windows-menu
;;  2 10/26/95 Alice Hartley no change
;;  11 5/23/95 akh  use mac-file-write-date
;;  9 5/7/95   slh  balloon help mods.
;;  13 3/2/95  slh  misc changes
;;  12 2/21/95 slh  removed naughty word (file is public now)
;;  8 2/17/95  slh  search again, save application items
;;  7 2/7/95   akh  probably no change
;;  6 1/30/95  akh  command-/ command-\ and backtrace improved somewhat
;;  (do not edit before this line!!)

;; L1-initmenus.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2000 Digitool, Inc.

;; Modification History
;; remove some obsolete code
;; ------- 5.2b5
;; compile file menu item doesn't ask for format in choose-new-file-dialog for output-file
;; save-as gets command-key '(:shift #\S)
;; lose some save-as menu items - utf16 etc
;; lose compile unix file and load unix file
;; add save-as utf16 and utf8
;; -------- 5.1 final
;; confirmed-quit - no is cancel-button, always ask
;; undo more gets command key :shift #\Z - to drive everbody crazy
;; -------- 5.1b2
;; confirmed-quit dont ask if there is a window that needs saving - it will ask
;; ------------------- 5.1b1
;; 'Open Recent' menu item
;; command-key says do alphabetic sort in update-windows-menu - from Toomas Altosaar
;; akh restore optimization in update-windows-menu
;; ------- 5.0 final
;; akh lose the separator before the "Quit" item if osx
;; -------- 5.0b5
; akh unix file stuff in file menu
; --------- 5.0b3
; 1/13/03 ss add "Bring All to Front" item to Windows menu
; akh don't add the quit menu item to file-menu if osx - 
;--------- 4.4b5
; 06/01/01 see do-about-dialog - no dont - undid the change
; 08/08/00 akh save-menu-item-update less liberal
; menu-update-function for edit-menu is update-edit-menu-items
; ----------- 4.3b1
; 12/15/98 akh   print menu-item gets an update function
; 04/15/97 bill  update-windows-menu calls menu-item-enable vs (setf slot-value) on the
;                menu-items for invisible windows.
; -------------  4.1b2
;  4/29/96 slh   update-about-item: ignore startup process
;  4/22/96 slh   removed old credits dialog
; 12/14/95 slh   "FASL" or "PFSL"
; 11/29/95 bill  new trap names to avoid emulator
;  5/17/95 slh   revert-menu-item-update: don't blow up for deleted files
;  5/04/95 slh   check for fred-window before using fred methods
;                update-about-item: check *active-processes* list
;  4/27/95 slh   *lisp-menu* = *eval-menu*
;  4/20/95 slh   update-about-item: some fixes
;  4/18/95 slh   *application-name* -> current-app-name fn
;  4/11/95 slh   About item uses *app-name* & no updater if not LDS; new method
;                application-about-dialog
;  4/04/95 slh   use app-loader-class for base-apps; real class gets set later
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
; 3/08/95 slh  *application-name*
; 2/27/95 slh   update-about-item checks *in-read-loop* in (non-initial) processes
;               Execute Buffer item has update fn (to disable for listeners)
; 2/16/95 slh   added Search Again menu item
; 2/15/95 slh   added Save Application menu item
;-------------  3.0d17
; 1/29/95 slh   updated about box (still needs address, phone, email, icon...)
;-------------  3.0d16
; 12/28/93 alice execute selection is only enabled if there is a selection
; "save as" and "save-copy-as" get update functions
;-------------
; 05/08/93 alice abort and break  menu items are always enabled this week.
; 04/30/93 bill  (front-window) -> (get-window-event-handler) where appropriate
; 04/28/93 bill  "Processes" menu item on the "Tools" menu.
; 04/26/93 bill  save-menu-item-update enables when (null (window-filename w))
; 04/07/93 bill  Reinstate the "New Listener" menu item. Wanna fight?
;--------------- 2.1d5
; ??       alice "Eval" menu renamed to "Lisp"
; -------------- 2.1d4
; 03/10/93 alice inspector menu item is gone for now
; 02/21/93 alice make window-save-as and window-save-copy-as work for fred-dialog-items tooooo.
; 02/15/93 alice (edit-menu) finds the edit menu - deprecate *edit-menu*
; 01/19/93 alice use trace-dialog, get info, Compile => Execute
; 12/18/92 alice nuke some dead code
; 11/24/92 alice "Compile file" gets the right fasl dir, compile and load move to file menu
;		 "Eval" => "Lisp", "Eval" => "Compile"
; 10/15/92 alice close now calls window-close-event-handler for options (may screw up or?)
; 10/08/92 alice load... => load file...
;; 07/30/92 alice change the update function for edit-menu
;01/21/93 bill "Abort", "Break", "Continue", "Restarts…", & "Backtrace" menu items now
;              work correctly modulo multiple processes. Operate on (front-window-process)
;              Still need more of a protocol for this so that the yet-to-be-designed process
;              status window and the stack backtrace window can interact appropriately with
;              these menu items
;11/20/92 gb  BREAK menu item calls INTERACTIVE-BREAK.
;09/01/92 bill add ellisis at end of Apropos, Inspect, & Search Files menu items.
;------------- 2.0
;03/10/92 bill confirmed-quit no longer displays a cancel button in its dialog
;------------- 2.0f3
;01/14/92 gb   1992 in about-ccl.
;01/09/92 bill remove the turd in window-do-operation
;12/29/91 bill (defgeneric window-can-undo-p ...)
;12/30/91 alice nuke *undo-menu-item*, reinstate window-methods for cut etal
;12/19/91 gb   Use curapname when requesting confirmation.
;12/12/91 bill <Command>-Q now quits with confirmation
;------------- 2.0b4
;10/30/91 bill remove "-iv" on the end of slot names.  Add some help specs
;10/16/91 alice define window-can-do-operation for window so dialog editor can have an around method
;10/02/91 alice *save-exit-functions* - update *windows-menu* (so wont point at stack consed things)
;09/08/91 alice "open selected file" => "open selection"
;--------------- 2.0b3
;09/05/91 bill  menu-item-action-function's remain symbols
;               Remove redundant code from update-windows-menu
;               Alice's fix to *edit-menu*'s update-function
;09/04/91 alice do disable apple-menu, edit-menu update-function is just menu-enable
;08/26/91 alice apple menu not disabled by modal dialog - just about mcl
;08/24/91 gb    use new traps.
;08/13/91 alice edit-menu update function gets smarter
;08/12/91 alice all menus get disabled if *modal-dialog-on-top* unless have an :update-function
;08/06/91 alice nuke command-m?
;07/30/91 alice added listener commands to tools menu
;07/26/91 alice edit-menu-item-update for cut, clear, copy, paste, undo, undo-more
;07/21/91 gb    SAVE dimmed for read-only windows. ??? Fix SAVE-AS, -COPY ???
;07/10/91 alice command-m for undo more
;07/02/91 bill  Add :help-spec's.  <Command>D is Open Selected File.
;06/26/91 alice command-h for eval buffer, command-y for load
;--------- 2.0b2
;04/18/91 alice add undo more to edit menu
;02/14/91 bill "Revert" -> "Revert…"
;--------- 2.0b1
;01/09/91 bill "About MACL" -> "About Macintosh Common Lisp"
;01/07/91 bill Slightly prettify the about box.
;12/31/90 gb   You haven't -begun- to sigh until you've seen the new About box.
;              Needs work ...
;11/20/90 bill "About Coral Lisp" -> "About MACL" (sigh...)
;11/19/90 gb   Autoload inspector.
;10/23/90 bill ABORT menu-item calls INTERACTIVE-ABORT vice ABORT
;09/17/90 bill <Command>-R for "Revert", <Command>-B for backtrace.
;08/28/90 bill The inspect menu-item does inspect-system-data, not control-inspect
;08/20/90 bill Restore "-" menu-item in Apple menu.
;08/10/90 bill update-windows-menu handles hidden windows.
;07/25/90 bill "Print" -> "Print…"
;07/05/90 bill eql methods -> menu-item-update-function's
;06/25/90 bill remove :procid arg to make-instance in about-ccl
;06/08/90 gb   about-ccl: just give bug report address.
;06/07/90 bill #'window-defs-dialog -> 'window-defs-dialog to allow bootstrapping.
;06/04/90 bill in choose-**-dialog: :default -> :directory.
;05/24/90 bill window-position, window-size -> view-position, view-size
;05/23/90 bill Disable the "List Definitions" menu-item if it is not applicaable.
;04/30/90 gb   Restarts menu item.  It's 1990.
;04/10/90 gz  dialog-item-font -> view-font
;02/26/90 bill No longer need (or want) the "-" menu-item in the apple menu.
;02/20/90 bill print-options-dialog & environment-dialog functions replace in-line code
;              in *tools-menu* menu-items.
;02/07/90 bill Update for new dialogs.
;01/13/90 gz   WFind -> search-window-dialog.
;01/03/90 gz   enable print/page setup.
;              Made menu item actions be functions rather than symbols.
;12/27/89 gz   Rearranged obsolete #-bccl conditionalizations.
;              button -> default-button in about-ccl.
;              apple-menu-class -> apple-menu (another vestige of object lisp).
;09/16/89 bill Removed the last vestiges of object-lisp windows.
;09/13/89 bill (menu-item-update ((eql (find-menu-item item "Save"))):
;                window-object-save => window-save for clos window
;09/08/89 bill convert about-ccl and inside-scoop-dialog to CLOS dialogs.
;9/06/89  gb  make-dialog-OBJECT-item(s) in about-ccl.
;8/30/89 bill Added object-fboundp
;             Update all menu-item-update methods for CLOS windows
;8/25/89 bill menu-item-update: all methods: specialize for object-lisp windows
;             These still need to be updated to work for CLOS windows.
;7/28/89  gz  Don't need to pass menu-title for apple-menu.
;7/20/89  gz  clos menus
;6-apr-89 as  changes to "about ccl"
;4/4/89   gz  window-foo -> window-object-foo
;2-Mar-89 as  save-copy-as menu-item
;01/05/89 gz no more *read-level*
;01/01/89 gz my-file-name -> window-filename.
;12/2/88 gz partial 1.3 merge:
 ;10/31/88 as   nixed step/trace menu-items
 ;10/26/88 as   removed proclaim-special *help-menu*
 ;10/19/88 jaj  got rid of *action-window*
 ; 10/12/88 as  (oneof *dialog-item*) -->> (make-dialog-item)
 ; 10/6/88 as   punted franz from about box
;08/21/88 gz   declarations.
;08/07/88 gz   libfasl->require.
; 6/21/88 jaj  removed calls to print-listener-prompt
; 6/01/88 as   punted inside-scoop-dialog.  About-ccl uses auto-centering
; 5/20/88 as   added documentation menu-item, search-files menu-item
;              removed documents menu
;              shuffled some other menus
; 5/19/88 as   removed killed-strings and change-font menus
;              new about box
;              *apple-menu* inherits from *apple-menu-class*
;              added trace and step menus
; 3/10/88 jaj  add-item -> add-menu-items my-menu -> owner removed my-number
; 2/27/88 jaj  continue menu-item enables per *continuablep*
;04/01/88 gz   New macptr scheme.  Flush pre-1.0 edit history.
;03/02/88 gz   Eliminate compiler warnings.
;02/16/88 gb   compile-time action in inside-scoop dialog.
;01/28/88 as   removed ellipsis from Apropos menu-item-title
;10/19/87 jaj  added Franz to copyright, load menu always verbose, added
;               abort, break and continue
; 9/15/87 jaj  Made menu-install for *apple-menu* do _AddResMenu
;              load menu calls eval-enqueue, compile-file is now verbose
;----------------------------- Version 1.0 -------------------------------

;(dbg 1)
#-carbon-compat-2 ; this pukes - seems ok now
(progn
  (#_ClearMenuBar)
  (#_DrawMenuBar))
;(dbg 2)

#|
(eval-when (:compile-toplevel :execute)
  (deftrap "_LMGetCurApName" () 
    (:no-trap (:pointer (:string 255)))
    (:no-trap (%int-to-ptr #$CurApName)))
)
|#

(defparameter *application*
  (make-instance (lds 'lisp-development-system
                      'app-loader-class)))

(defun current-app-name ()
  (%get-string  (#_LMGetCurApName)))  ;; trap ain't defined - BUT IT IS



(defparameter *apple-menu* (make-instance 'apple-menu))

(defun update-about-item (item)
  (if *modal-dialog-on-top*
    (menu-item-disable item)
    (lds (progn
           (menu-item-enable item)
           (dolist (p *all-processes*)
             (unless (or (eq p *event-processor*)
                         (not (memq p *active-processes*))
                         ; process-active-p true for blocked processes
                         (symbol-value-in-process '*in-read-loop* p)
                         ; ignore startup process; see %save-application-internal
                         (equal (process-name p) "Startup"))
               (set-menu-item-check-mark item #\DiamondMark)
               (return-from update-about-item nil)))
           (set-menu-item-check-mark item nil)))))


#|
(defmethod add-hide-menu-item? ((application application) menu)
  (add-new-item menu (concatenate 'string "Hide " (current-app-name)) 'hide-mcl :command-key '(:shift #\H)))
  

(defun hide-mcl ()
  (rlet ((psn :processSerialNumber))
    (setf (pref psn :processserialnumber.HighLongOfPSN) 0
          (pref psn :processserialnumber.LowLongOfPSN) #$kcurrentprocess)
    (#_ShowHideProcess psn nil)))
|#

(let ((menu *apple-menu*))
  (declare (special *app-name*))        ; will be bound by AppGen.fasl if needed
  (add-new-item menu
                (%str-cat "About "
                          (lds "Macintosh Common Lisp"
                               *app-name*)
                          "…")
                'do-about-dialog
                :update-function (lds 'update-about-item)
                :help-spec '(1000 1 1 1 2))
  #+ignore
  (if (osx-p) (add-hide-menu-item? *application* menu))
  (add-new-item menu "-"))



(defun do-about-dialog ()
  (let ((dialog (application-about-dialog *application*)))
    (if dialog
      (progn (modal-dialog dialog))
      (ed-beep))))


(defun save-menu-item-update (item &aux (wob (front-window)))
  (if (and wob
           (or (non-window-method-exists-p 'window-save wob) ;(method-exists-p 'window-save wob)
               (and (setq wob (window-key-handler wob))
                    (method-exists-p 'window-save wob)))
           (or (not (method-exists-p 'window-needs-saving-p wob))
               (window-needs-saving-p wob)
               (and (method-exists-p 'window-filename wob)
                    (null (window-filename wob))
                    (typep wob 'fred-window)
                    (neq 0 (buffer-size (fred-buffer wob)))))
           (or (not (method-exists-p 'window-buffer-read-only-p wob))
               (not (window-buffer-read-only-p wob))))
    (menu-item-enable item)
    (menu-item-disable item)))

(defun revert-menu-item-update (item)
  (let* ((wob (front-window))
         (file (if (method-exists-p 'window-filename wob)
                 (window-filename wob)))
         date)
    (if (and wob
             (method-exists-p 'window-revert wob)           
             (or (not (method-exists-p 'window-needs-saving-p wob))
                 (and (or (not (method-exists-p 'window-filename wob))
                          file)
                      (window-needs-saving-p wob))
                 (and file
                      (probe-file file)
                      (typep wob 'fred-window)
                      (setq date (mac-file-write-date file))
                      (not (eql date (buffer-file-write-date (fred-buffer wob)))))))
      (menu-item-enable item)
      (menu-item-disable item))))

(defparameter *file-menu* (make-instance 'menu :menu-title "File" :help-spec 1100))

#|
(defun menu-disable-if-modal (m)
  (if *modal-dialog-on-top*
    (menu-item-disable  m)
    (menu-item-enable  m)))
|#

(defvar *do-unix-hack* nil)
(let ((menu *file-menu*))
  (add-new-item menu "New" 'fred :command-key #\N :help-spec 1101)
  (add-new-item menu "Open…" 'edit-select-file :command-key #\O :help-spec 1102)
  #+ignore
  (add-new-item *file-menu* "Open Unix…" #'(lambda nil 
                                             (let ((*do-unix-hack* t))
                                               (edit-select-file))))
  (add-menu-items menu (make-instance 'menu :menu-title "Open Recent"
                                     :update-function 'open-recent-menu-update))

  (add-new-item menu "Open Selection" 'open-selected-file :command-key #\D
                :update-function 'open-selected-file-menu-item-update
                :help-spec '(1103 1 2))
  (lds
   (add-new-item menu "New Listener" 'make-new-listener :help-spec 1120))
  (add-new-item menu "-" nil :disabled t)
  (add-new-item menu "Close" 'window-close-event-handler :class 'window-menu-item :command-key #\W
                :help-spec 1104)
  (add-new-item menu "Save" 'window-save
                :class 'window-menu-item :command-key #\S 
                :update-function #'save-menu-item-update
                :help-spec '(1105 1 2))
  (add-new-item menu "Save As…" #'(lambda (w)
                                           (window-do-operation w 'window-save-as))
                :class 'window-menu-item
                :command-key '(:shift #\S)
                :update-function #'(lambda (item)(edit-menu-item-update item 'window-save-as)) 
                :help-spec '(1106 1 2))  
  
  (add-new-item menu "Save Copy As…" #'(lambda (w) (window-do-operation w 'window-save-copy-as))
                :update-function #'(lambda (item)(edit-menu-item-update item 'window-save-copy-as))
                :class 'window-menu-item                
                :help-spec '(1107 1 2))
  (add-new-item menu "Revert…" 'window-revert
                :command-key #\R 
                :class 'window-menu-item :update-function #'revert-menu-item-update
                :help-spec '(1108 1 2))
  (add-new-item menu "-" nil :disabled t)
  (lds
   (progn
     (add-new-item menu "Load File…"                
                   #'(lambda (&aux (file (choose-file-dialog
                                          :mac-file-type '("TEXT"
                                                           #-ppc-target "FASL"
                                                           #+ppc-target "PFSL")
                                          :button-string "Load")))
                       (when file (eval-enqueue `(load ',file :verbose t))))
                   :command-key #\Y
                   :help-spec 1303)     
     (add-new-item *file-menu* "Compile File…"
                   #'(lambda () 
                       (let* ((file (choose-file-dialog :mac-file-type "TEXT"
                                                        :button-string "Compile"))
                              (output-file (choose-new-file-dialog
                                            :directory (merge-pathnames
                                                        *.fasl-pathname*
                                                        (back-translate-pathname file))
                                            :format-list nil
                                            :prompt "Destination File..."
                                            :button-string "Compile")))
                         (eval-enqueue `(compile-file ',file :verbose t
                                                      :output-file ',output-file))))
                   :help-spec 1304)    
     (add-new-item menu "-" nil :disabled t)))
  (add-new-item menu "Page Setup…" 'print-style-dialog :help-spec 1109)
  (add-new-item menu "Print…" 'window-hardcopy :class 'window-menu-item :command-key #\P
                :update-function 'print-menu-item-update
                :help-spec '(1110 1 2))  
  )

(defmethod window-needs-saving-p ((w window))
  nil)

#|
(defun confirmed-quit ()
  (cond ((command-key-p)
         (when (or #+ignore 
                   (and (eq *break-level* 0)
                        (do-all-windows w 
                          (when (window-needs-saving-p w)
                            (return T))))
                   (y-or-n-dialog (format nil "Do you really want to quit from ~A ?"
                                          (current-app-name))
                                  :yes-text "Quit"
                                  :cancel-text "No"
                                  :no-text nil
                                  :window-type :double-edge-box
                                  :help-spec '(:dialog 11110 :yes-text 11111 :no-text 11112)))
           (quit)))
        (t (quit))))
|#
  

;redefined later (make ppc-boot happy)
(defun open-recent-menu-update (item)(declare (ignore item)))

;redefined later
(defun open-selected-file-menu-item-update (item)(declare (ignore item)))

(defparameter *open-selected-file-menu-item* (nth 2 (slot-value *file-menu* 'item-list)))

(defun print-menu-item-update (item)
  (let ((w (get-window-event-handler)))
    (cond ((and w (method-exists-p 'window-hardcopy w))
           (menu-item-enable item))
          (t (menu-item-disable item)))))

(defun edit-menu-item-update (item op &aux (w (get-window-event-handler)))
  (cond
   ((and w
         (cond (t ;(method-exists-p 'window-can-do-operation w)
                ; above is now true for all windows
                (window-can-do-operation w op item))))
    (menu-item-enable item))
   (t (menu-item-disable item))))

(defun edit-menu (&optional (application *application*))
  (find-edit-menu application))

(defmethod find-edit-menu ((application application))
  (let ((menus (cdr %menubar)))
    (if (memq *edit-menu* menus)
      *edit-menu*
      (dolist (menu menus *edit-menu*)
        (dolist (item (slot-value menu 'item-list))
          (when (eq (command-key item) #\X)
            (return-from find-edit-menu menu)))))))

; window-do-operation needs a way to elide checking for
; a method on the window argument.
(defun window-do-operation (w op &optional (consider-window-method t))
  (when w
    (cond
     ((and consider-window-method (method-exists-p op w))
      (funcall op w))
     (t 
      (let ((handler (current-key-handler w)))
        (when handler
          (cond 
           ((method-exists-p op handler)
            (funcall op handler)))))))))

(queue-fixup
 ; Can't DEFGENERIC at level-1 time
 (defgeneric window-can-undo-p (window)))

; window-can-do-operation needs to check for an applicable primary
; method other than the one that is specialized on the class
; named window rather than just calling method-exists-p
(defmethod window-can-do-operation ((w window) op &optional item)
  (cond
   ((and (eq op 'undo)
         (method-exists-p 'window-can-undo-p w))
    (funcall 'window-can-undo-p w))
   ((non-window-method-exists-p op w))                          
   (t (let ((handler (current-key-handler w)))
        (when handler
          (cond ((method-exists-p 'window-can-do-operation handler)
                 (window-can-do-operation handler op item))
                (t (method-exists-p op handler))))))))

;; broken out of above
(defun non-window-method-exists-p (op w)
  (let* ((gf (and (symbolp op) (fboundp op)))
           (methods (and (standard-generic-function-p gf)
                         (generic-function-methods gf)))
           (class (class-of w))
           (window-class (find-class 'window))
           (cpl (class-precedence-list class)))
      (and methods
           (dolist (method methods)
             (when (and (null (method-qualifiers method))
                        (let ((spec (car (method-specializers method))))
                          (and (not (eq spec window-class))
                               (if (typep spec 'eql-specializer)
                                 (eql (eql-specializer-object spec) w)
                                 (memq spec cpl)))))
               (return t))))))

(defmethod cut ((w window))
  (window-do-operation w 'cut nil))

(defmethod clear ((w window))
  (window-do-operation w 'clear nil))

(defmethod copy ((w window))
  (window-do-operation w 'copy nil))

(defmethod paste ((w window))
  (window-do-operation w 'paste nil))

(defmethod undo ((w window))
  (window-do-operation w 'undo nil))

(defmethod undo-more ((w window))
  (window-do-operation w 'undo-more nil))

(defmethod select-all ((w window))
  (window-do-operation w 'select-all nil))

(eval-when (:execute :compile-toplevel :load-toplevel)
  (defvar search-item-name "Find…")
  (defvar search-again-item-name "Find Again"))

(defun search-dialog-text (search-dialog)
  (let ((text (dialog-item-text (view-named 'search-text-item search-dialog))))
    (when (and text (not (equal text "")))
      text)))

(defun front-window-that-isnt (evil-window)
  (let ((mapper #'(lambda (w)
                    (unless (eq w evil-window)
                      (return-from front-window-that-isnt w)))))
    (declare (dynamic-extent mapper))
    (map-windows mapper)))

(defun search-again-p (&aux search-dialog search-text search-target)
  (when (and (setq search-dialog (front-window :class (find-class 'search-dialog)))
             (setq search-text   (search-dialog-text search-dialog))
             (setq search-target (front-window-that-isnt search-dialog)))
    (values search-dialog search-text search-target)))

(defun do-search-again ()
  (multiple-value-bind (search-dialog search-text search-target)
                       (search-again-p)
    (when search-dialog
      (window-search search-target search-text)
      (enable-replace search-dialog))))

;(defclass edit-menu (menu)())

(defparameter *edit-menu* (make-instance 'menu :menu-title "Edit" 
                                         :update-function 'update-edit-menu-items
                                         :help-spec 1200))

(let ((menu *edit-menu*))       

  (add-new-item menu "Undo" #'undo
                :class 'window-menu-item :command-key #\Z
                :update-function #'(lambda (item)
                                     (edit-menu-item-update item 'undo))
                :help-spec #'(lambda (item)
                               (if (eql 0 (search "Redo" (menu-item-title item)
                                                  :test 'char-equal))
                                 '(1201 3 4) '(1201 1 2))))
  (add-new-item menu "Undo more" #'undo-more
                :class 'window-menu-item :command-key '(:shift #\Z)
                :update-function #'(lambda (item)
                                     (edit-menu-item-update item 'undo-more))
                :help-spec '(1202 1 2))
  (add-new-item menu "-" nil :disabled t)
  ; add update functions for these
  (add-new-item menu "Cut" #'cut
                :class 'window-menu-item :command-key #\X :help-spec '(1203 1 2)
                :update-function 
                #'(lambda (item) (edit-menu-item-update item 'cut)))
  (add-new-item menu "Copy" #'copy
                :class 'window-menu-item :command-key #\C :help-spec '(1204 1 2)
                :update-function 
                #'(lambda (item) (edit-menu-item-update item 'copy)))
  (add-new-item menu "Paste" #'paste
                :class 'window-menu-item :command-key #\V :help-spec '(1205 1 2)
                :update-function
                #'(lambda (item) (edit-menu-item-update item 'paste)))
  (add-new-item menu "Clear" #'clear
                :class 'window-menu-item :help-spec '(1206 1 2)
                :update-function 
                #'(lambda (item) (edit-menu-item-update item 'clear)))
  (add-new-item menu "Select All" #'select-all
                :update-function #'(lambda (item) (edit-menu-item-update item 'select-all))
                :class 'window-menu-item
                :command-key #\A :help-spec '(1207 1 2))
  (add-new-item menu "-" nil :disabled t)
  (add-new-item menu search-item-name #'(lambda ()
                                          (when (require 'dialogs)
                                            (search-window-dialog)))
                :update-function #'(lambda (item)
                                     (edit-menu-item-update item 'search))
                :command-key #\F :help-spec 1208)
  (add-new-item menu search-again-item-name #'do-search-again
                :command-key #\G :help-spec 1209)
  )

(queue-fixup
 (setf (slot-value (find-menu-item *edit-menu* search-item-name) 'menu-item-action)
       #'search-window-dialog
       (menu-item-update-function (find-menu-item *edit-menu* search-again-item-name))
       #'(lambda (item)
           (if (search-again-p)
             (menu-item-enable  item)
             (menu-item-disable item)))))

;(defparameter *undo-menu-item* (car (slot-value *edit-menu* 'item-list)))

(defparameter *lisp-menu*
  (lds (make-instance 'menu :menu-title "Lisp" :help-spec 1300)
       nil))

(defparameter *eval-menu* *lisp-menu*)          ; backwards compat.

(defparameter *tools-menu*
  (lds (make-instance 'menu :menu-title "Tools" :help-spec 1400)
       nil))

#| 
(defun update-windows-menu (menu &aux menu-handle)
  (if *modal-dialog-on-top* 
    (menu-disable menu)
    (when (setq menu-handle (slot-value menu 'menu-handle))
      (menu-enable menu)
      (without-interrupts
       (dolist (item (slot-value menu 'item-list))
         (setf (slot-value item 'owner) nil)
         ; always delete item 1 (they get "renumbered" !)
         (#_DeleteMenuItem menu-handle 1))
       (setf (slot-value menu 'item-list) nil)
       (do-all-windows window
         (when (display-in-windows-menu window)
           (let ((item (window-menu-item window)))
             (when item               ; windoid's & da-window's have no menu-item's
               (if (window-shown-p window)
                 (set-menu-item-style item :plain)
                 (progn (set-menu-item-style item :italic)
                        (setf (slot-value item 'enabledp) t)))
               (add-menu-items menu item)
               (if (not (slot-value item 'enabledp)) (menu-item-disable item))
               (if (slot-value item 'command-key)
                 (set-command-key item (slot-value item 'command-key)))
               (if (slot-value item 'checkedp)
                 (set-menu-item-check-mark item (slot-value item 'checkedp)))
               (if (neq (slot-value item 'style) :plain)
                 (set-menu-item-style item (slot-value item 'style)))))))))))
|#

(defun bring-all-windows-front ()
  (rlet ((psn :processSerialNumber
                    :highLongOfPSN 0
                    :lowLongOfPSN #$kCurrentProcess))
          (#_SetFrontProcess psn)))

(defvar *bring-windows-front-item* 
  (make-instance 'menu-item
    :menu-item-title "Bring All to Front"
    :menu-item-action 'bring-all-windows-front))

; if menu items are in the right order just leave them there
; conses less and  faster X 1.6 when order-ok, a bit slower when not ok
(defun update-windows-menu (menu &aux menu-handle)
  (declare (optimize (speed 3)(safety 0)))
  (if *modal-dialog-on-top* 
    (menu-disable menu)
    (when (setq menu-handle (slot-value menu 'menu-handle))
      (menu-enable menu)
      (without-interrupts
       (let* ((nwins (length *window-object-alist*))
              (new-items (make-list nwins))
              (items (slot-value menu 'item-list))
              (nitems 0)
              (order-ok t))
     
         (declare (fixnum nitems))
         (declare (dynamic-extent new-items)(list new-items items))
         (if t #|(osx-p)|# (setq items (cddr items)))
         (let ((new-items new-items)
               (items items))
           (declare (list new-items items))
           (do-wptrs wptr
             (let* ((w (window-object wptr)))
               (when (and w (display-in-windows-menu w))
                 (let ((item (window-menu-item w)))
                   (when item
                     (if (window-shown-p w)
                       (set-menu-item-style item :plain)
                       (progn (set-menu-item-style item :italic)
                              (menu-item-enable item)))
                     (rplaca new-items item)
                     (setq new-items (cdr new-items))
                     (incf nitems)
                     (when (and order-ok (neq item (car items)))
                       (setq order-ok nil))
                     (setq items (cdr items))))))))
         (when (or (not order-ok)(neq nitems (length items))(command-key-p))
           (dolist (item (slot-value menu 'item-list))
             (setf (slot-value item 'owner) nil)
             ; always delete item 1 (they get "renumbered" !)
             (#_DeleteMenuItem menu-handle 1))
           (setf (slot-value menu 'item-list) nil) 
           (when t ;(osx-p)
             (add-menu-items menu *bring-windows-front-item*)
             (add-menu-items menu (make-instance 'menu-item :menu-item-title "-")))
           (when (command-key-p)
             ;;; 2003-10-08TA - if command key is down then windows sorted alphabetically
             (let ((copy nil))
               (dolist (x new-items) (when x (push x copy)))
               (setq new-items (sort copy #'string-lessp :key #'ccl::menu-title))))
           (dolist (item new-items)
             (when item               ; windoid's & da-window's have no menu-item's                     
               (add-menu-items menu item)
               (if (not (slot-value item 'enabledp)) (menu-item-disable item))
               ))))))))



(defparameter *windows-menu* (make-instance 'menu :menu-title "Windows"
                                            :update-function 'update-windows-menu
                                            :help-spec '(values 1500 (1501 1 2 1 3))))

;(push #'(lambda () (update-windows-menu *windows-menu*)) *save-exit-functions*)

(defparameter *default-menubar*
  (lds (list *apple-menu* *file-menu* *edit-menu*
             *lisp-menu* *tools-menu* *windows-menu*)
       (list *apple-menu* *file-menu* *edit-menu* *windows-menu*)))
;(dbg 4)
;; something busted in menu-install??
(menu-install *apple-menu*)
;(dbg 5)

(set-menubar *default-menubar*)
;(dbg 6)

#|
(defun cruddo ()
  (when (not (osx-p))
    (when (not (find-menu-item *file-menu* "Quit"))
      (add-new-item *file-menu* "-" nil :disabled t)
      (add-new-item *file-menu* "Quit" 'confirmed-quit
                    :command-key #\Q
                    :help-spec 1111))))
(pushnew 'cruddo *lisp-startup-functions*)
|#
    

#|
(queue-fixup
 (labels ((update-menu (menu)
            (dolist (item (menu-items menu))
              (if (typep item 'menu)
                (update-menu item)
                (let ((action (slot-value item 'menu-item-action)))
                  (when (non-nil-symbol-p action)
                    (setf (slot-value item 'menu-item-action) (symbol-function action))))))))
 (dolist (menu (menubar))
   (update-menu menu))))
|#


#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
	3	1/2/95	akh	no change
|# ;(do not edit past this line!!)
