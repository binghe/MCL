;; (c) 2002 Brendan Burns bburns@cs.umass.edu
;; You are free to redistribute, modify, delete, cuddle with, and otherwise 
;; harass this code.

;; 20 apr 2007 - akh - add ability to select a button by typing first char of button title
;; 15 Mar 2007 - akh - timer works, callback fn takes 2 args

(in-package :ccl)

(eval-when (:execute :compile-toplevel :load-toplevel)
  (export '(create-standard-sheet sheet-callback-cleanup) :ccl))

(defstruct sheet-info
  sheet
  callback-fn
  keystrokes)

;;;(add-pascal-upp-alist 'SheetEventHandler.p #'(lambda (procptr) (#_NewEventHandlerUPP procptr)))
(add-pascal-upp-alist-macho 'SheetEventHandler.p "NewEventHandlerUPP")

(defpascal SheetEventHandler.p (:ptr $inRef :ptr $inEvent :ptr $userData :osstatus)
  (declare (ignore $inRef $userData))
  (let ((result #$eventNotHandledErr))
    (rlet ((control-id :ostype)
           (control :controlref)
           (parent :ptr))
      (errchk (#_GetEventParameter $inEvent #$kEventParamDirectObject #$typeControlRef 
               (%null-ptr) (record-length :controlref) (%null-ptr) control))
      (errchk (#_GetControlCommandID (%get-ptr control) control-id))
      (let ((which-control (%get-ostype control-id)))
        ;; 0 happens when mouse click not in any button
        (when (neq which-control #.(ff-long-to-ostype 0)) ; (memq which-control '(#.#$kHICommandOther #.#$kHICommandOK #.#$kHICommandCancel :|help|))
          ;; :|help| probably doesn't want to close the sheet
          (with-macptrs ((sheet (#_GetControlOwner (%get-ptr control))))
            (let ((err (#_GetSheetWindowParent sheet parent)))
              (when (eq err #$noerr) ;; maybe somebody detached it
                (with-macptrs ((wptr (%get-ptr parent)))  ;; wptr is a null-ptr if sheet got detached
                  (let* ((the-window (window-object wptr))
                         (sheet-info (if the-window (view-get the-window 'sheet-callback))))
                    (setq result #$noerr)
                    (if (not sheet-info)
                      (progn (#_HideSheetWindow sheet)
                             (#_DisposeWindow sheet))
                      (funcall (sheet-info-callback-fn sheet-info) which-control the-window)))))))))
    result)))


;;; the symbol callback is used in OpenGL - so call it something else here - 2002-12-25TA - why??

;;; alert-type specifies the alert icon to display - one of :stop, :caution, :note, :plain or the equivalents
;;;  #$kAlertStopAlert, #$kAlertCautionAlert, #$kAlertNoteAlert, #$kAlertPlainAlert.
;;;  (some of us think this arg should be a keyword arg defaulting to :caution)
;;;
;;; the-callback, if provided, should be a function accepting 2 arguments: 
;;;   1) the command button that was selected (will be one of #$kHICommandOK #$kHICommandCancel #$kHICommandOther or :|help|),
;;;   2) the parent window.
;;;   the-callback is responsible for disposing of the sheet via sheet-callback-cleanup if so desired
;;;   the-callback defaults to 'sheet-callback-cleanup
;;;
;;; default-text, cancel-text, and other-text are the titles of the corresponding buttons
;;;  cancel-text and other-text may be NIL to omit the corresponding button.
;;;
;;; help, if true, will include a help button.
;;; explanation may be a string to be displayed below the message string.
;;; do-keystrokes,if true, will cause typing the first character of a button title to select the button.
;;;  (typing #\escape #\enter or #\return will work independent of the value of do-keystrokes)
;;; transparent, if true, the sheet will be transparent

(defmethod create-standard-sheet (alert-type (window window) (message string)
                                             &key (the-callback 'sheet-callback-cleanup)
                                             (default-text "OK") (cancel-text "Cancel")
                                             other-text explanation
                                             (do-keystrokes t)
                                             help transparent)
  (when (view-get window 'sheet-callback)  ;; would anyone want two?
    (error "Window ~s already has a sheet" window))
  (with-cfstrs ((default-str default-text)
                (cancel-str cancel-text)
                (message-str message)
                (explanation-str explanation)
                (other-str other-text))        
    (rlet ((param :AlertStdCFStringAlertParamRec)
           (the-alert-ptr :ptr))
      (#_GetStandardAlertDefaultParams param #$kStdCFStringAlertVersionOne) 
      (if help
        (setf (pref param :AlertStdCFStringAlertParamRec.helpButton) T))
      (if default-text
        (setf (pref param :AlertStdCFStringAlertParamRec.defaultText) default-str))
      (when cancel-text
        (setf (pref param :AlertStdCFStringAlertParamRec.cancelText) cancel-str)
        (setf (pref param :AlertStdCFStringAlertParamRec.cancelButton) #$kAlertStdAlertCancelButton))  ;; makes escape key work
      (if other-text
        (setf (pref param :AlertStdCFStringAlertParamRec.otherText) other-str))     
      (#_CreateStandardSheet (get-alert-type alert-type) message-str (if explanation explanation-str *null-ptr*)
       param (#_GetWindowEventTarget (wptr window)) the-alert-ptr)
      (let* ((the-dialog-wptr (#_GetDialogWindow (%get-ptr the-alert-ptr)))
             (keys nil))
        (install-control-event-handler the-dialog-wptr SheetEventHandler.p)
        (install-mouse-detector the-dialog-wptr)
        (when do-keystrokes
          (flet ((first-char (text)(if (characterp text) text (char text 0))))
            (if cancel-text 
              (push (cons (char-downcase (first-char cancel-text)) #$kHICommandCancel) keys))
            (if other-text
              (push (cons (char-downcase (first-char other-text)) #$kHICommandOther) keys))
            (if default-text
              (push (cons (char-downcase (first-char default-text)) #$kHICommandOk) keys))
            (install-sheet-key-detector the-dialog-wptr)))
        (if transparent  ;; ugh ugly
          (#_SetThemeWindowBackground the-dialog-wptr #$kThemeBrushSheetBackgroundTransparent t))
        (view-put window 'sheet-callback 
                  (make-sheet-info :sheet the-dialog-wptr 
                                   :callback-fn (or the-callback 'sheet-callback-cleanup)
                                   :keystrokes keys)) 
        (#_ShowSheetWindow the-dialog-wptr (wptr window)))
      (when (eq window (front-window))(set-cursor *arrow-cursor*))
      window)))

(defun sheet-callback-cleanup (command window)
  (let* ((sheet-info (view-get window 'sheet-callback)))
    (when sheet-info
      (let ((sheet (sheet-info-sheet sheet-info)))
        (when (and (macptrp sheet)(#_isvalidwindowptr sheet))
          (#_HideSheetWindow sheet)
          (#_DisposeWindow sheet))
        (view-remprop window 'sheet-callback)))
    command))


(defun install-control-event-handler (wptr handler)
  (rlet ((event-spec :eventtypespec
                     :eventclass #$kEventClassControl
                     :eventkind #$kEventControlHit))
    (errchk (#_InstallEventHandler (#_GetWindowEventTarget wptr)
             handler 1 event-spec (%null-ptr)(%null-ptr)))))

(add-pascal-upp-alist-macho 'sheet-mouse-proc "NewEventHandlerUPP")

(defpascal sheet-mouse-proc (:ptr targetref :ptr eventref :ptr userdata :osstatus)
  (declare (ignore userdata))
  (let ()
    (with-periodic-task-mask ($ptask_event-dispatch-flag t)
      (with-timer
        (let ((*interrupt-level* 0)) ;; defpascal binds to -1
          (errchk (#_CallNextEventHandler targetref eventref))))) 
    #$noerr))

(defun install-mouse-detector (wptr)
  (rlet ((event-spec :eventtypespec
                     :eventclass #$keventClassMouse
                     :eventkind #$keventMouseDown))
    (errchk (#_InstallEventHandler (#_GetWindowEventTarget wptr)
             sheet-mouse-proc
             1 event-spec (%null-ptr) (%null-ptr)))))

(add-pascal-upp-alist-macho 'sheet-key-proc "NewEventHandlerUPP")

(defpascal sheet-key-proc (:ptr targetref :ptr eventref :ptr userdata :word)
  (declare (ignore targetref userdata))
  (let* ((res #$eventNotHandledErr)
         (window (front-window))
         (sheet-info (view-get window 'sheet-callback))
         (keys (if sheet-info (sheet-info-keystrokes sheet-info))))
    (when keys
      (rlet ((mods :uint32)
             (size :uint32))
        (errchk (#_geteventparameter eventref
                 #$kEventParamKeyModifiers
                 #$typeuint32
                 (%null-ptr) (record-length :uint32) size mods))
        (when (or (eq 0 (%get-unsigned-long size))                
                  (eq 0 (logand (%get-unsigned-long mods)
                                (logior #$cmdKey  #$controlKey #$rightControlKey))))          
          (%stack-block ((ustuff 4))
            #+ignore
            (errchk (#_geteventparameter eventref #$kEventParamKeyMacCharCodes #$typeChar
                     (%null-ptr) (record-length :byte) (%null-ptr)  what))
            (errchk (#_geteventparameter eventref #$kEventParamKeyUnicodes #$typeUnicodeText
                     (%null-ptr ) 4 size ustuff))              
            (let* ((key (if (eq (%get-unsigned-long size) 2)  ;; size is bytes - i.e. 2X # unicode chars
                          (%get-unsigned-word ustuff)))) ;; phooey if 2 chars long
              (when key
                (setq key (char-downcase (%code-char key)))
                (let ((it (assq key keys)))
                  (when it
                    (setq res #$noerr)
                    (funcall (sheet-info-callback-fn sheet-info) (cdr it) window)))))))))
    res))


(defun install-sheet-key-detector (wptr)
  (rlet ((event-spec :eventtypespec
                     :eventclass #$keventClasskeyboard
                     :eventkind #$keventRawKeyDown))
    (errchk (#_InstallEventHandler (#_GetWindowEventTarget wptr)
             sheet-key-proc
             1 event-spec (%null-ptr) (%null-ptr)))))

(if (not (fboundp 'get-alert-type))
  ;; its in dialogs.lisp
  (defun get-alert-type (type)
    (cond ((fixnump type) type)
          ((eq :stop type) #$kalertstopalert)  ;; 0 - app icon 
          ((eq :caution type) #$kalertcautionalert) ;; 2 - caution sign with app icon
          ((eq :note type) #$kalertnotealert)   ;; 1 - app icon
          ((eq :plain type) #$kalertplainalert)  ;; 3 - no icon
          (t (error "Unknown alert type ~S" type))))
  )

(advise (:method window-close (window)) (sheet-post-close (car arglist))
        :when :after :name sheet-close)

;; in case a window  parenting a sheet is closed programatically - without the sheet having been disposed by sheet-callback
(defun sheet-post-close (window)
  (let ((sheet-stuff (view-get window 'sheet-callback)))
    (when sheet-stuff (sheet-callback-cleanup nil window))))

#|
(defun find-sheets ()
  (do-wptrs wptr
    (rlet  ((what :uint32))
      (#_getwindowclass wptr what)
      (let ((type (%get-unsigned-long what)))
        (when (eql type #$kSheetWindowClass)
          (rlet ((parent-ptr :ptr))
            (let ((err (#_getSheetWindowParent wptr parent-ptr)))
              (print err)
              (when (eq err #$noerr)
                (let ((parent (window-object (%get-ptr parent-ptr))))
                  (print (list 'parent parent wptr))
                  (when (not parent)
                    (map-windows #'(lambda (w)
                                     (let ((zz (view-get w 'sheet-callback)))
                                       (if (and zz (%ptr-eql wptr (sheet-info-sheet zz)))
                                         (view-remprop w 'sheet-callback)))))
                    (#_HideSheetWindow wptr)
                    (#_disposeWindow wptr)
                    ))))))))))
|#



#| ;; example

(let ((win (ed)))
  (create-standard-sheet :caution
                         win "This is a test" 
                         :other-text "§else" :help t
                         :explanation "For Thursday"
                         :the-callback #'(lambda (command window)
                                            (unless (eq command :|help|)
                                              (sheet-callback-cleanup command window))
                                            (case command
                                              (#.#$kHICommandOK (window-close window))
                                              (#.#$kHICommandCancel (ed-beep))
                                              (t (print command window)
                                                 (view-draw-contents window)
                                                 )))))
|#




