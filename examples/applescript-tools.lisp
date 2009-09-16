;;;-*- Mode: Lisp; Package: CCL -*-
(in-package :ccl)

;;  File: APPLESCRIPT TOOLS.LISP
;;  Written:
;;	T. Bonura
;;	©Apple Computer, Inc.
;;	File Written: 30 May 1995 15:55 PDT
;;____________________________________________________________
;;  Description:  A high level interface to executing applescript statements
;;  from within LISP.
;;____________________________________________________________
;;  Documentation:  AppleScript statements are encapsulated in an instance of
;;  the class SCRIPT-OBJ in the script slot.  When the method
;;  execute-applescript is called on an instance of the SCRIPT-OBJ, the script
;;  is compiled and executed.  Any returned values are stored in a couple of
;;  places in the script object, the returned.value slot (accessed by the
;;  accessor, returned-value) and the.result.string slot (accessed by the
;;  accessor, the-result-string).  The former stores an aedesc with
;; the data and
;;  the latter a string, as would appear in the "result" window in the script
;;  editor.  By calling the method EDIT-SCRIPT a mini script editor is built
;;  which allows easy viewing, editing and running of the script.
;;  Other methods on the script object allow for recording actions as
;;  AppleScripts so that if you have a recordable application, you can generate
;;  a script by turning recording on and doing the actions.
;;  There are other more esoteric capabilities built here, like the class
;;  action-script which is able to load a compiled script from the 'scpt'
;;  resource of an applescript applet and run the script from LISP, and a
;;  SCRIPT-PARAM class which allows one to pass things like appleevent records
;;  to other scripts.
;;____________________________________________________________
;;  Changes:
;; AS-LAUNCH-SCRIPT - if need to launch application use fsref - not sure if correct
;; ------ 5.2b6
;; new-with-pointers -> with-macptrs or let, don't compute returned-value of script-obj - not used 
;; use aedisposedesc in a couple of places
;; with-pointers -> new-with-pointers, pointerp and zone-pointerp -> macptrp
;; ------- 5.1 final
;; -------- 10/12/02 akh dont use aedesc.datahandle if carbon. 
;;  2/12/96 - Everything now in the CCL package.  Also removed any references to
;;  AEStuff.  THis required changing definitions in DECOMPILE-SCRIPT,
;;  HANDLE-RECEIVED-SCRIPT-TEXT, CLEANUP, EXTRACT-THE-RESULT.  Seems to generate
;;  16 bytes on the mac heap per call (which is less than the previous memory "leak")
;;  1/25/96  Remove requirement for :utilities and added the eval-when to define
;;  the macro make-literal-string and the function null-string-p
;;  11/27/95  Changes EXECUTE-APPLESCRIPT to take another parameter QUIETLY.  If
;;  T it will execute and ignore any appleevent errors.  This is useful if a
;;  script contains calls to a scripting addition which will tickle an event not
;;  handled error from MCL (this is the right behavior).  Probably best to pass
;;  in T when it is known that the script works, modulo the error
;;  generated from calling the scripting addition.
;;  11/27/95  Changed AS-ERROR-STR to ignore errors if the global
;;  ccl::*signal-appleevent-errors* is NIL.
;;  11/27/95  Changed OPEN-COMPONENT to test for dead macptr rather than a null
;;  ptr.  Thanks to Stefan Landvogt for the fix.
;;  9/8/95  Added macro WITH-APPLESCRIPT takes a script as a string, then
;;  executes the script, cleanup in an unwind protect.
;;  9/8/95   Edit script barfs because application-name slot was not defined in
;;  script-obj (I took it out at some point).  Added the application-name slot back.
;;  5/30/95  Don't use resource-utils.lisp.
;; 	     COMPILE-SCRIPT now takes a mode flag which is usually kOSAModeNull
;;	     Folded applescript.lisp, applescript editor.lisp and scriptrunner.lisp
;;		into one file.
;;____________________________________________________________

(require :resources)                    ; should be in ccl:library;
(require :appleevent-toolkit)           ; should be in ccl:examples;

(eval-when (:compile-toplevel :load-toplevel :execute)
   ;;  these should have been defined in my utilities file - but for anyone who
   ;;  doesn't have this file:
   (unless (fboundp 'MAKE-LITERAL-STRING)
     (defmacro MAKE-LITERAL-STRING (string)
       "takes a string and string quotes it."
       `(concatenate 'string "\"" ,string "\"")))
   (unless (fboundp 'NULL-STRING-P)
     (DEFUN NULL-STRING-P (STRING)
       "Return t if the string is "" otherwise nil"
       (UNLESS (STRINGP string)
         (ERROR nil (FORMAT nil "The arg to null-string-p, ~a, is not
a string.~%" string)))
       (zerop (length string)))
     )
   (unless (fboundp 'string-concat)
     (defun STRING-CONCAT (&rest strings)
       "Concatenate strings"
       (apply #'concatenate 'string strings)))
   (unless (fboundp 'string-concat-with-space)
     (defun STRING-CONCAT-WITH-SPACE (&rest strings)
       (if strings
         (if (= 1 (length strings))
           (car strings)
           (apply #'string-concat (string-concat (first strings) " ")
                  (append
                   (loop for string in (butlast (cdr strings))
                         collect
                         (string-concat string " "))
                   (last strings)))
           )
         )
       )
     )
   )

(export '(SCRIPT-PARAM SCRIPT-OBJ APPLESCRIPT-OBJECT as-get-string
           compile-applescript execute-applescript edit-script start-recording
           stop-recording display-result dispose-script cleanup script
           compiled-script extract-the-result the-result-string get-recorded-text
           execute-appleevent with-applescript with-scripting-addition
           script-aedesc))


(DEFVAR *multiple-component-instances* NIL "Allows for multiple instances of a
scripting component.  Set this using the function
(use-multiple-component-instances-p t) ")

(DEFVAR *AS-SCRIPT-EDITOR* NIL "Points to the applescript editor")

(DEFVAR *applescript-dispatcher* nil)

(DEFPARAMETER *current-scripting-component* NIL "A pointer to the current
scripting component if the application is only using a single
component instance"
   )
(DEFCONSTANT $AppleScript :|ascr| "The applescript scripting component")
(DEFCONSTANT $GeneralScriptingComponent :|cscr| "The general
scripting component")

(DEFINE-CONDITION APPLESCRIPT-ERROR (error)
                   ((oserr :initarg :oserr :reader oserr)
                    (error-string :initform nil :initarg :error-string
:reader error-string))
   (:report
    (lambda (c s)
      (format s "~a (~d)~@[ - ~a~]" (ccl::%rsc-string (oserr c))
(oserr c) (error-string c)))))

(DEFUN SCRIPT-ERROR (scriptingComponent)
   (with-aedescs (err)
     (if (/= (#_OSAScriptError scriptingComponent #$keyErrorString #$typeChar err) #$noErr)
       ""
       (as-get-string err))))

(DEFMACRO AS-ERROR-STR (scriptingComponent &body forms)
   (let ((errsym (gensym)))
     `(let ((,errsym (progn ,@forms)))
        (unless (or (not ccl::*signal-appleevent-errors*)
                    (eq ,errsym #.#$noErr))
          (error (make-condition 'AppleScript-error :oserr ,errsym
                                 :error-string (script-error ,scriptingComponent)))))))

;;____________________________________________________________
;;  UTILITY FUNCTIONS


(DEFUN CLOSE-SCRIPTING-COMPONENT ()
   (when (macptrp *current-scripting-component*)
     (#_closeComponent *current-scripting-component*)
     (setf *current-scripting-component* NIL)))

(pushnew #'close-scripting-component *lisp-cleanup-functions*)

(DEFUN USE-MULTIPLE-COMPONENT-INSTANCES-P (boolean)
   (cond (boolean
          (if (macptrp *current-scripting-component*)
            (#_closeComponent *current-scripting-component*))
          (setf *multiple-component-instances* t
                *current-scripting-component* nil))
         ))

(DEFUN NULL-AEDESC ()
  (let ((result (make-record :aedesc)))
    #+carbon-compat
    (#_aeinitializedesc result)
    #-carbon-compat
    (progn 
      (rset result :aedesc.descriptorType #$typeNull)
      (rset result :aedesc.dataHandle (%null-ptr)))
    result))

(DEFUN PRINT-TO-LISTENER (string)"
	Prints string to the listener
	"
   (format t "~A~%" string)
   )


(DEFUN EXTRACT-SCRIPT-TEXT (text)
   "Remove any tabs and linefeeds from the text if the script should be of short
form, otherwise if the script is of the type 'tell, end tell' just return the
whole thing"
   ;;  see if the last word of the text is "tell"
   (if (string= "tell" (last-word text))
     text
     (strip-lf&tab text)))


(DEFUN STRIP-LF&TAB (string)
   "Removes linefeeds and tabs from a copy of string"
   (substitute-if #\space #'(lambda (char)
                  (or (char= char #\return)
                      (char= char #\tab)))
              string))


#+carbon-compat
(DEFUN AS-GET-STRING (aedesc)
  (let ((data-size (#_aegetdescdatasize aedesc)))
    (%stack-block ((data-ptr data-size))
      (errchk (#_aegetdescdata aedesc data-ptr data-size))
      (%str-from-ptr data-ptr data-size))))

#-carbon-compat
(DEFUN AS-GET-STRING (aedesc)
   (let* ((datahandle (pref aedesc aedesc.datahandle))
          (size (#_GetHandleSize dataHandle))
          (text (make-string size)))
      (dotimes (i size)
         (setf (char text i) (code-char (%hget-byte datahandle i))))
      text))


(defun LAST-WORD (text)
   "Return the last word from text (downcased)"
   (let* ((txt (reverse (STRIP-LF&TAB text))))

     (if (whitespacep (char txt 0))      ; whitespace at end
       (last-word (subseq text 0 (1-  (length text))))
       (string-downcase (reverse (subseq txt 0 (position #\space txt)))))))

;;____________________________________________________________
;;
;;  Installing the handler for continuous recording
(defmethod receive-script-text ((a application) aevent reply handler-ref-con)
     (declare (ignore reply handler-ref-con))
     (if *applescript-dispatcher*
       (HANDLE-RECEIVED-SCRIPT-TEXT *applescript-dispatcher* aevent))
     )
(install-appleevent-handler #$kOSASuite #$kOSARecordedText
                             #'receive-script-text)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;	Class:  SCRIPT-OBJ
;;;	** ASO = AppleScriptObject **
;;;   INITIALIZE-INSTANCE ((ASO SCRIPT-OBJ) &rest initargs)
;;;   OPEN-COMPONENT ((ASO SCRIPT-OBJ)) "opens a scripting component
;;;	and sets the value of the component slot to a pointer"
;;;   LOAD-SCRIPT ((aso SCRIPT-OBJ) resfile scpt-res-id) "Load a script
;;;   from the indicated file with the indicated resource number"
;;;   COMPILE-APPLESCRIPT ((ASO SCRIPT-OBJ)) "compiles the script
;;;	which is in the script slot"
;;;   EXECUTE-APPLESCRIPT ((ASO SCRIPT-OBJ)) "What do you think?"
;;;   EDIT-SCRIPT ((ASO SCRIPT-OBJ))
;;;   CLEANUP ((ASO SCRIPT-OBJ))
;;;   DISPOSE-SCRIPT ((ASO SCRIPT-OBJ))
;;;   DISPLAY-RESULT ((ASO SCRIPT-OBJ))  - elided - TB 9/12
;;;   EXTRACT-THE-RESULT ((ASO SCRIPT-OBJ))
;;;	******  Recording *****
;;;   START-RECORDING ((ASO SCRIPT-OBJ))
;;;   STOP-RECORDING ((ASO SCRIPT-OBJ)) "When we
;;;   stop recording, we add the decompiled script to the script slot"
;;;   DECOMPILE-SCRIPT ((ASO SCRIPT-OBJ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(DEFCLASS SCRIPT-OBJ (cl-user::standard-object)
   ((script :initform NIL :initarg :script :accessor script)
    (scripting.component.type :initform NIL :initarg :scripting-component-type
                              :accessor scripting-component-type)
    (as.target :initform NIL :initarg :target :accessor as-target)
    ;;  the application we're talking to if any
       (application-name :initarg :application-name :initform NIL :accessor
                      application-name)
    (break.on.error :initarg :break-on-error :accessor break-on-error)
    (compiled.script :initform NIL :initarg NIL :accessor compiled-script)
    (compiled.script.id :initform NIL :initarg NIL :accessor compiled-script-id)
    (component :initform nil :initarg :component :accessor component)
    ;;  like almost always an AEDesc
       (returned.value :initarg :returned-value :accessor returned-value)
    ;;  this is what would appear in the applescript editor's result window
    (the.result.string :initarg the-result-string :accessor the-result-string)
    ;;  Governs whether to get incremental values for scripts when recording is
       ;;  on (like what the Script Editor normally does)
       (get-recorded-text :initarg :get-recorded-text :initform NIL :accessor
                         get-recorded-text )

    )
   (:default-initargs
     :scripting-component-type $AppleScript
     :break-on-error t
     :returned-value nil
     )
   )


(DEFMETHOD INITIALIZE-INSTANCE ((aso SCRIPT-OBJ) &rest initargs)
   (declare (ignore initargs))
   (call-next-method)
   (open-component aso)
   (unless *applescript-dispatcher*
     (setf *applescript-dispatcher*
           (make-instance 'script-dispatcher)))
   (if (get-recorded-text aso)
     (setf (active-script-object *applescript-dispatcher*) aso)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(DEFGENERIC OPEN-COMPONENT (SCRIPT-OBJ)
   (:documentation "Opens a scripting component.  We only open a new scripting
component if the global *multiple-component-instances* is t.  Otherwise all the
scripts use the same scripting component.")
   )

(DEFMETHOD OPEN-COMPONENT ((ASO SCRIPT-OBJ))
    ;;  changed to deal with either a single or multiple components
     (cond (*multiple-component-instances*
          (setf (component ASO)
                (#_OpenDefaultComponent #$kOSAComponentType
                 (scripting-component-type ASO))))
         ((or (null *current-scripting-component*)
              ;;  following was noted by S. Landvogt to be the cause of problems
              ;;  (presumably when an MCL image was saved referencing an invalid
              ;;  mac ptr.  The call to macptrp is a better test.
              ;; (%null-ptr-p *current-scripting-component*)
              (not (macptrp *current-scripting-component*))
              )
          (setf *current-scripting-component*
                (#_OpenDefaultComponent #$kOSAComponentType
                 (scripting-component-type ASO)))
          (setf (component ASO) *current-scripting-component*))
         (t (setf (component ASO) *current-scripting-component*))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defmethod LOAD-SCRIPT ((aso SCRIPT-OBJ) resfile scpt-res-id)
   ;;  loads a script from a resource file (any file which has a resource of res type
     ;;  'scpt' with number scpt-res-id.
   (let ((hres nil)
         (scriptingComponent (component aso)))
     (with-open-resource-file (refnum resfile)
       (progn
         (setf hres (get-resource :|scpt| scpt-res-id))
         (when (%null-ptr-p hres)
                (#_disposePtr hres)
                (error "~%Resource ~a not found" scpt-res-id))
         (load-resource hres)
         (detach-resource hres)))
     ;;  now hres handle is mine
     (with-dereferenced-handles ((scptPtr hres))
       (with-aedescs (scriptDesc)
         (rlet ((id :OSAID))
           (ae-error (#_AECreateDesc #$typeOSAGenericStorage scptPtr (#_getHandleSize hres)
            scriptDesc))
           (as-error-str scriptingComponent (#_OSALoad scriptingComponent scriptDesc #$kOSAModeNull id))
           (setf (compiled-script aso) t
                 (compiled-script-id ASO) (%get-long id)))))
     (#_disposeHandle hres)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(DEFMETHOD COMPILE-APPLESCRIPT ((ASO SCRIPT-OBJ) &optional (modeFlg #.#$kOSAModeNull))
   (with-macptrs ((scriptingComponent (component ASO)))
     (let ((text (script ASO)))
       (with-aedescs (source)
         (let ((size (length text)))
           (%vstack-block (buff size)
             (dotimes (i size)
               (%put-byte buff (char-code (char text i)) i))
             (#_AECreateDesc #$typeChar buff size source)))
         (rlet ((id :OSAID))
           (%put-long id #$kOSANullScript)
           (as-error-str scriptingComponent (#_OSACompile scriptingComponent source modeFlg id))
           (setf (compiled-script aso) t
                 (compiled-script-id ASO) (%get-long id))
           )
         )
       )
     )
   )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(DEFGENERIC EXECUTE-APPLESCRIPT (SCRIPT-OBJ &optional quietly)
   (:documentation "Execute the script on the target")
   )

;;; Typically returns an AEDesc that the user must dispose.  May return a
;;; string or nil if bad things happen.  The AEDESC is put in the returned-value
;;; slot of the object



;;  T.B.  8 Mar 1995  -  11.12
;;  this version of execute uses a new slot on the SCRIPT-OBJ called
;;  the.result.string.  The value of this slot should be the same as what the
;;  applescript editor shows in its result window.

#+ignore
(DEFMETHOD EXECUTE-APPLESCRIPT ((ASO SCRIPT-OBJ) &optional (quietly NIL))
   ;;  whenever the script is edited in the script editor, the value of
   ;;  compiled-script is set to nil
   (unless (compiled-script aso)
     (compile-applescript ASO))
   (let ((id (compiled-script-id ASO))
         (result nil)
         (scriptingComponent (component ASO))
         (*signal-appleevent-errors* (not quietly)))
      (rlet ((result-id :OSAID #$typeChar))
         (as-error-str scriptingComponent (#_OSAExecute scriptingComponent id 0 0 result-id))
         (unwind-protect
           (extract-the-result aso (%get-long result-id))
           (#_OSADispose scriptingComponent (%get-long result-id)))
         result
         )))

#+ignore
(DEFMETHOD EXTRACT-THE-RESULT ((aso SCRIPT-OBJ) result-id)
   (with-macptrs ((scriptingComponent (component aso)))
     (with-aedescs (resultDesc)
       (as-error-str scriptingComponent (#_OSACoerceToDesc
                                         scriptingComponent result-id #$typeWildCard #$kOSAModeNull
                                         resultDesc))
       (let ((final-result (null-aedesc))
             (old-value (returned-value aso)))
         (ae-error (#_AEDuplicateDesc resultDesc final-result))
         (when (macptrp old-value)
           (#_aedisposedesc old-value)
           (#_disposseptr old-value))
         (setf (returned-value aso) final-result)
          ;;  this is the string which would appear in the appleScript "result"
         ;;  window in the script editor
         (extract-string aso result-id)))))

(DEFMETHOD EXECUTE-APPLESCRIPT ((ASO SCRIPT-OBJ) &optional (quietly NIL))
   ;;  whenever the script is edited in the script editor, the value of
   ;;  compiled-script is set to nil
   (unless (compiled-script aso)
     (compile-applescript ASO))
   (let ((id (compiled-script-id ASO))
         (result nil)
         (scriptingComponent (component ASO))
         (*signal-appleevent-errors* (not quietly)))
      (rlet ((result-id :OSAID #$typeChar))
         (as-error-str scriptingComponent (#_OSAExecute scriptingComponent id 0 0 result-id))        
         (unwind-protect
           (setq result (extract-the-result aso (%get-long result-id))) ;; lets return the result
           (#_OSADispose scriptingComponent (%get-long result-id)))
         result
         )))

;; leak was here: lose final-result = returned-value - not used
;; why did this leak?
;; now macheap decreases which seems weird.
(DEFMETHOD EXTRACT-THE-RESULT ((aso SCRIPT-OBJ) result-id)
   (let ((scriptingComponent (component aso)))
     (declare (ignore-if-unused scriptingcomponent))
     (with-aedescs (resultDesc)
       ;; what is this for?
       #+ignore
       (as-error-str scriptingComponent (#_OSACoerceToDesc
                                         scriptingComponent result-id #$typeWildCard #$kOSAModeNull
                                         resultDesc))
       (let (;(final-result (null-aedesc))
             (old-value (returned-value aso)))
         ;(ae-error (#_AEDuplicateDesc resultDesc final-result))
         (when (macptrp old-value)
           (#_aedisposedesc old-value)
           (#_disposeptr old-value)
           (setf (returned-value aso) nil))
         ;(setf (returned-value aso) final-result)
          ;;  this is the string which would appear in the appleScript "result"
         ;;  window in the script editor
         (extract-string aso result-id)
         ))))

(DEFMETHOD EXTRACT-STRING ((aso SCRIPT-OBJ) result-id)
  (with-aedescs (source)
    (let ((err (#_OSADisplay (component aso) result-id #$typeChar 0 source)))
      (cond ((zerop err)
             (setf (the-result-string aso)
                   (as-get-string source)))
            (t (values nil err))))))


(DEFMETHOD DISPOSE-SCRIPT ((ASO SCRIPT-OBJ))
   (let ((as (component ASO))
         (id (compiled-script-id ASO)))
     (when (and as id
                (macptrp as))
       (as-error-str as (#_OSADispose as id)))
     )
   )


(DEFMETHOD CLEANUP ((ASO SCRIPT-OBJ))
   (dispose-script ASO)
   ;;  remove from the script-dispatcher
   (if (get-recorded-text aso)
     (setf (active-script-object *applescript-dispatcher*) nil))
   (when (macptrp (returned-value aso))
     (#_aedisposedesc (returned-value aso))
     (#_disposeptr (returned-value aso)))
   (setf (returned-value aso) nil)
   (when *multiple-component-instances*
     (#_CloseComponent (component aso))
     (setf (component aso) nil)
          )
         )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(DEFGENERIC EDIT-SCRIPT (SCRIPT-OBJ)
   (:documentation "Bring up a script editor on the script")
   )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  Methods for dealing with error conditions
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;
;;;		Recording From Recordable Applications
;;;  The following allows for recording to be turned on.
;;;  Actions are recorded to the compiled script in the
;;;  applescript object.
;;;	When recording, we have the option of taking the results incrementally.  By
;;;  default, we get the recorded text only when the applescript editor is open on
;;;  an applescript object.  If it is, we send the string to the script editor.
;;;  Otherwise if the value of the get-recorded-text slot on the
;;;object is t, we call handle-recorded-text method on the applescript object.
;;;Since LISP is informed only about a recorded-text
;;;event, there is no way to know what to do with the text.  It might just be
;;;displayed (as in the case of the script editor, or one might want to analyze
;;;the text for patterns (as in doing PBD).  So the question is which object
;;;should be informed about the incoming text.  To do this, we create an
;;;instance of a script-dispatcher. Any applescript object can register
;;; itself with the script-dispatcher.  The script dispatcher object then
;;;informs the applescript object about the current script text.  There is only
;;;one script dispatcher object and it is bound to the variable *applescript-dispatcher*
;;;  IMPORTANT:
;;  If you want to do some thing other than sending the recorded text output to
;;  the applescript editor or to the listener, then override the method called
;;  HANDLE-RECORDED-TEXT

(DEFCLASS SCRIPT-DISPATCHER (standard-object)
   ((active-script-object :initarg :active-script-object :initform nil
                           :accessor active-script-object))

   )

(DEFMETHOD HANDLE-RECEIVED-SCRIPT-TEXT ((self script-dispatcher) aevent)
   (let ((script-object (active-script-object self))
         (theText NIL))
     (when script-object
       (setf theText (ae-get-parameter-char aevent #$keyDirectObject nil))
       (handle-recorded-text script-object theText)
       )
     )
   )

(DEFMETHOD START-RECORDING ((aso SCRIPT-OBJ))
   (with-macptrs ((as (component aso)))  ;; duh - or let
       (rlet ((id :OSAID))
         (%put-long id #$KOSANullScript)
         (let ((oserr (#_OSAStartRecording as id)))
           (if (zerop oserr)
             (progn
               (format t "Recording is on.~%")
               (setf (compiled-script-id aso) (%get-long id)))
             (if (break-on-error ASO)
               (error (script-error as))))))))


(DEFMETHOD STOP-RECORDING ((aso SCRIPT-OBJ))
   (with-macptrs ((as (component aso)))
     (let ((oserr (#_OSAStopRecording as (compiled-script-id aso))))

       (cond ((zerop oserr)
              (decompile-script aso)
              (format t "Recording is off.~%"))
             (t
              (if (break-on-error ASO)
                (error (script-error as))))))))

(DEFMETHOD DECOMPILE-SCRIPT ((aso SCRIPT-OBJ))
   ;;  extract the script from the compiled script.  Most
   ;;  useful when doing recording
   (with-macptrs ((as (component aso)))
     (with-aedescs (descObj)
       (let* ((id (compiled-script-id aso))
            (err (#_OSAGetSource as id #$typeChar descObj)))
       (cond ((zerop err)
              ;;  extract the text from the descriptor, then
              ;;  add the script to the script slot of the
              ;;  object and inform the object that the
              ;;  script has changed
              (setf (script aso)
                    (ae-get-parameter-char descObj #$keyDirectObject nil)
                    (compiled-script aso) t))
             (t (if (break-on-error ASO)
                      (error (script-error as)))
                )
             )
       )
     )
   )
)

(DEFMETHOD HANDLE-RECORDED-TEXT ((aso SCRIPT-OBJ) string)
   "Tell the object to handle the recorded text.  THis usually means writing the text to the applescript editor."
   ;;  if there is an open applescript editor make sure that the current object
   ;;  is aso and send the string there, otherwise go to the lisp listener (or do
   ;;  some other thing overriden
   (cond ((and (boundp '*AS-SCRIPT-EDITOR*)
               *AS-SCRIPT-EDITOR*
               (wptr *AS-SCRIPT-EDITOR*))
          ;;  this appends to the end of the script
          (let ((input.buffer (view-named 'input-buffer *AS-SCRIPT-EDITOR*)))
            (setf (slot-value *AS-SCRIPT-EDITOR* 'current.object) aso)
            (set-dialog-item-text input.buffer
                                  (concatenate 'string
                                               (dialog-item-text input.buffer)
                                               (format nil "~a~%" string))))
          )
         (t
          (print-to-listener string)))
   )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  SCRIPT-PARAM  Instances of this class contain scripts that are passed to
;;  other scripts as data.  In particular, in order to pass an appleevent record
;;  of the form {slot: value, slot2: value} to a script which expects that
;;  record (for example an OPEN handler of an applescript applet), the record must
;;  itself be compiled into a script context before being passed to another script.
;;  This class makes doing this relatively easy.  See the "script examples.lisp" file
;;  for an example of how to use this functionality.

(DEFCLASS SCRIPT-PARAM (SCRIPT-OBJ)
   ((theAEDesc :initarg :theAEDesc :initform NIL :accessor script-aedesc))
   (:default-initargs
     :script "{}"                        ; an empty record
     )
   )

(DEFMETHOD CLEANUP ((ASO SCRIPT-PARAM))
  (when (and (script-aedesc aso)
             (macptrp (script-aedesc aso)))
    (#_aedisposedesc (script-aedesc aso))
    (#_disposeptr (script-aedesc aso)))
  (setf (script-aedesc aso) nil)
  (call-next-method)
  )

(DEFMETHOD EXECUTE-APPLEEVENT ((aso SCRIPT-PARAM))
   ;;  note that this is NOT the same as execute-applescript
   (unless (compiled-script aso)
     (compile-applescript aso #.#$kOSAModeCompileIntoContext))
   (let ((final-result (null-aedesc))
         (scriptingComponent (component aso))
         (scriptID (compiled-script-id aso))
         )

     (rlet ((ID :OSAID))

       (with-aedescs (paramDesc paramAE target)
         (create-self-target target)
         (create-appleevent paramAE #$kCoreEventClass #$kAEOpenApplication target)
         (as-error-str scriptingComponent (#_OSAExecuteEvent scriptingComponent paramAE scriptID #$kOSAModeNull ID))
         (as-error-str scriptingComponent (#_OSACoerceToDesc scriptingComponent (%get-long ID) #$typeWildCard #$kOSAModeNull final-result))
         (setf (script-aedesc aso) final-result))

       )
     )
   )


(DEFMETHOD ADD-FIELD-TO-RECORD ((aRecord SCRIPT-PARAM) field value)
   "Adds field value pair to the string representation for an applescript record."
   (setf (script aRecord)
         (string-concat "{"
                        (string-concat-with-space (string field) (string value) )
                        (if (> (length (script aRecord)) 2)
                          ", "
                          "")
                        (subseq (script aRecord) 1))))

(DEFMETHOD ADD-FIELDS-TO-RECORD ((aRecord SCRIPT-PARAM) field-value-list)
   (when (and field-value-list
              (consp field-value-list))
     (add-field-to-record aRecord (first field-value-list)
                          (make-literal-string (second field-value-list)))
     (if (> (length field-value-list) 2)
       (ADD-FIELDS-TO-RECORD aRecord (cddr field-value-list))))
   )



(defmethod RESET-ALL ((aRecord SCRIPT-PARAM))
   (setf (script aRecord) "{}"
         (compiled-script aRecord) nil)
   )


#|
(DEFMETHOD AS-LAUNCH-SCRIPT ((script-record SCRIPT-PARAM) scriptApplet)
  "Launch a script, passing the compiled record script context to the applet as
a high level event in the parameter block.  If the script is currently running
the odoc event is sent to the application with the script aedesc as
the direct parameter."
  ;;  make sure the script is there
  ;;  make sure the script has been compiled successfully (i.e. run
  ;;  execute-appleevent on the script)
  (let ((scriptAEDesc (script-aedesc script-record))
        ;; need to remove the extraneous #\266 char which sometimes appear in
        ;; filenames with periods
        (scriptName (remove-if-not #'standard-char-p (file-namestring scriptApplet))))
    (with-aedescs (AEvent paramDesc target reply)
      ;;  check to see if running and if so do AESend
      (cond ((ccl::find-named-process scriptName)
             (multiple-value-bind (hiLongOfPsn lowLongOfPsn)
                                  (ccl::find-named-process scriptName)
               ;;  create a target for the applet
               (rlet ((psn :ProcessSerialNumber
                           :highLongOfPSN hiLongOfPsn
                           :lowLongOfPSN lowLongOfPsn))
                 (ae-error
                   (#_AECreateDesc #$typeProcessSerialNumber psn #.(record-length ProcessSerialNumber)
                    target))
                 (ccl::create-appleevent AEvent #$kCoreEventClass #$kAEOpenDocuments target)
                 (ae-error (#_AEPutParamDesc AEvent #$keyDirectObject scriptAEDesc))
                 (ae-error (#_AESend AEvent reply #$kAENoReply #$kAENormalPriority
                            #$kAEDefaultTimeout  (%null-ptr)  (%null-ptr))))
               ))
            ;;  app isn't running so have to launch
            (t
             (ccl::create-self-target target)
             (ccl::create-appleevent AEvent #$kCoreEventClass #$kAEOpenDocuments target)
             (ae-error (#_AEPutParamDesc AEvent #$keyDirectObject scriptAEDesc))
             (ae-error (#_AECoerceDesc AEvent #$typeAppParameters paramDesc))
             (flet ((do-it (launchAppParam)
                      (if (macptrp launchAppParam)
                        (rlet ((fsspec :FSSpec))
                          (rlet ((pb :launchParamBlockRec
                                     :launchBlockID #$extendedBlock
                                     :launchEPBLength #$extendedBlockLen
                                     :launchControlFlags (+ #$launchContinue #$launchNoFileFlags)
                                     :launchAppSpec fsspec
                                     :launchAppParameters launchAppParam))
                            (with-pstrs ((name (mac-namestring (probe-file scriptApplet))))
                              (#_FSMakeFSSpec 0 0 name fsspec))
                            (when (eql 0 (#_LaunchApplication pb))
                              scriptApplet)))
                        (error "launchappparam not a pointer"))))
               (declare (dynamic-extent do-it))                
               #+carbon-compat
               (let ((data-size (#_aegetdescdatasize paramdesc)))
                 (%stack-block ((launchAppParam data-size))
                   (errchk (#_aegetdescdata paramdesc launchAppParam data-size))
                   (do-it launchAppParam)))
               #-carbon-compat                
               (with-dereferenced-handles ((launchAppParam (rref paramDesc AEDesc.dataHandle)))
                 (do-it launchAppParam)))))
      )))
|#


(DEFMETHOD AS-LAUNCH-SCRIPT ((script-record SCRIPT-PARAM) scriptApplet)
  "Launch a script, passing the compiled record script context to the applet as
a high level event in the parameter block.  If the script is currently running
the odoc event is sent to the application with the script aedesc as
the direct parameter."
  ;;  make sure the script is there
  ;;  make sure the script has been compiled successfully (i.e. run
  ;;  execute-appleevent on the script)
  (let ((scriptAEDesc (script-aedesc script-record))
        ;; need to remove the extraneous #\266 char which sometimes appear in
        ;; filenames with periods
        (scriptName (ccl::mac-file-namestring-1 scriptApplet))) ;;(remove-if-not #'standard-char-p (file-namestring scriptApplet))))
    (when (not (ccl::find-named-process scriptName))  ;; if not running launch it
      (let ((res (launch-application-simple scriptApplet t)))
        (if (not res)(error "Applet ~S not found" scriptapplet))))
    (with-aedescs (AEvent paramDesc target reply)
      ;;  check to see if running and if so do AESend            
      (multiple-value-bind (hiLongOfPsn lowLongOfPsn)
                           (ccl::find-named-process scriptName)
        ;;  create a target for the applet
        (rlet ((psn :ProcessSerialNumber
                    :highLongOfPSN hiLongOfPsn
                    :lowLongOfPSN lowLongOfPsn))
          (ae-error
            (#_AECreateDesc #$typeProcessSerialNumber psn #.(record-length ProcessSerialNumber)
             target))
          (ccl::create-appleevent AEvent #$kCoreEventClass #$kAEOpenDocuments target)
          (ae-error (#_AEPutParamDesc AEvent #$keyDirectObject scriptAEDesc))
          (ae-error (#_AESend AEvent reply #$kAENoReply #$kAENormalPriority
                     #$kAEDefaultTimeout  (%null-ptr)  (%null-ptr))))
        ))))

;; stay-in-background-p t causes crash unless add #$kLSLaunchDontAddToRecents 
(defun launch-application-simple (filename &optional stay-in-background-p)  
  (let ((result nil))
    (rlet ((fsref :FSref)
           (launchspec :LSlaunchFSRefSpec
                       :appref fsref))
      (let* ((res (path-to-fsref filename fsref)))
        (when res
          (progn            
            (setf (pref launchspec :LSlaunchFSRefSpec.itemrefs) (%null-ptr)))
            (setf (pref launchspec :lsLaunchFSRefspec.passthruparams) (%null-ptr))
            (setf (pref launchspec :LSLaunchFSRefspec.launchflags) 
                  (logior #$kLSLaunchDefaults  
                          (if stay-in-background-p (logior #$kLSLaunchDontAddToRecents #$kLSLaunchDontSwitch) 0)))  ;; ??
            (setf (pref launchspec :LSLaunchFSRefspec.asyncRefCon)(%null-ptr))
            (let ((err (#_LSOpenFromRefSpec launchspec (%null-ptr))))
              (if (eq err #$noerr)
                (setq result filename))))))
    result))

            
(defun LAUNCH-APPLET-WITH-RECORD (applet recordAsString)
   "Launches appleScript applet passing it the applescript record"
   (let ((asRecord (make-instance 'as-record :script recordAsString)))
     (execute-appleevent asRecord)
     (if (macptrp (script-aedesc asRecord))
       (as-launch-script asRecord applet)
       (error "script aedesc is not a pointer"))
     (cleanup asRecord)))


(provide :appleScript)

;;;______________________________________________________________________
;;;
;;;		An AppleScript Editor
;;;	Note:  This assumes that we are in MCL3.0 I removed the conditional code
;;;which would load scrolling-fred-dialog-item
;;;

(DEFVAR *BOGUS-SCRIPT*
   (concatenate 'string "tell application " (make-literal-string "applicationName")
                (format nil "~%") (format nil "~%")
                "end tell" (format nil "~%"))
   )

;;  THis is where the script is actually written
(DEFCLASS AS-INPUT-BUFFER (scrolling-fred-view)
   ()
   (:default-initargs
     :view-size #@(450 230)
     :view-nick-name 'input-buffer
     )
   )

(DEFCLASS AS-EDITOR-WINDOW (window)
   ((current.object :initarg :current-object :initform nil :accessor current-object)
    (result-window :initarg :result-window :initform nil :accessor result-window))
   (:default-initargs
     :window-type :document-with-grow
     :color-p t
     :window-title "AppleScript Editor"
     :view-position #@(50 100)
     :view-size #@(500 300)
     :close-box-p t
     :result-window (make-instance 'as-result-window :window-show nil)
     )
   )

(DEFCLASS RUN-SCRIPT-BTN (button-dialog-item)
   ()
   (:default-initargs
     :view-nick-name 'run-btn
     :default-button nil
     :dialog-item-text "Run Script"
     :view-size #@(100 20)
     :view-position #@(79 274)
     :view-font '("Chicago" 12 :SRCOR :PLAIN)
     )
   )

(DEFMETHOD DIALOG-ITEM-ACTION ((btn run-script-btn))
   ;;  enter the script into the applescript instance then compile and run the script.
   (let* ((dialog (view-container btn))
          (as-object (current-object dialog))
          (script (extract-script-text (dialog-item-text (view-named 'input-buffer dialog)))))
     ; set the script
     (setf (script as-object) script)
     (open-component as-object)
     (compile-applescript as-object)
     (execute-applescript as-object)
     (if (check-box-checked-p (view-named 'show-result (view-container btn)))
       (display-result-string (result-window dialog) (the-result-string as-object)))
     )
   )

(DEFCLASS ADD-SCRIPT-BTN (button-dialog-item)
   ()
   (:default-initargs
     :view-nick-name 'add-btn
     :default-button t
     :dialog-item-text "Set Script"
     :view-size #@(100 20)
     :view-position #@(183 273)
     :view-font '("Chicago" 12 :SRCOR :PLAIN)
     )
   )

(DEFMETHOD DIALOG-ITEM-ACTION ((btn add-script-btn))
   ;;  enter the script into the applescript instance then compile it.
   (let* ((dialog (view-container btn))
          (as-object (current-object dialog))
          (script (dialog-item-text (view-named 'input-buffer dialog))))
     ; set the script
     (setf (script as-object) script)
     ;; since we want to recompile the script set the compiled script id to nil
     (setf (compiled-script-id as-object) nil)
     ))

(DEFCLASS CANCEL-BTN (button-dialog-item)
   ()
   (:default-initargs
     :view-nick-name 'cancel-btn
     :default-button nil
     :dialog-item-text "cancel"
     :view-size #@(60 20)
     :view-position #@(301 275)
     :view-font '("Chicago" 12 :SRCOR :PLAIN)
     )
   )

(DEFMETHOD DIALOG-ITEM-ACTION ((btn cancel-btn))
   ;;  punt
   (let ((dialog (view-container btn)))
     ; set the script
     (set-dialog-item-text (view-named 'input-buffer dialog) "")
     (setf (current-object dialog) nil)
     ))

;;  the start and stop recording button's methods
(DEFCLASS START-RECORDING-BUTTON (button-dialog-item)
   ()
   (:default-initargs
     :default-button nil
     :view-size #@(118 16)
     :view-position #@(192 2)
     :dialog-item-text "Start recording"
     :view-nick-name 'start-recording)
   )

(DEFMETHOD DIALOG-ITEM-ACTION ((btn start-recording-button))
   (let ((script-object (current-object (view-container btn))))
     (if script-object
       (begin-recording btn script-object)
       (error "No script object")))
   )

(DEFMETHOD BEGIN-RECORDING ((btn start-recording-button) script-object)
   (unless *applescript-dispatcher*
     (setf *applescript-dispatcher*
           (make-instance 'script-dispatcher)))
   (setf (ACTIVE-SCRIPT-OBJECT *applescript-dispatcher*)
         script-object)
   (setf (get-recorded-text script-object) t)
   (dialog-item-enable (view-named 'end-recording (view-container btn)))
   (start-recording script-object)
   ;;  dim the button
   (dialog-item-disable btn)
   )

(DEFCLASS END-RECORDING-BUTTON (button-dialog-item)
   ()
   (:default-initargs
     :view-size #@(118 16)
     :view-position #@(319 2)
     :default-button nil
     :dialog-item-text "End recording"
     :view-nick-name 'end-recording)
   )

(DEFMETHOD DIALOG-ITEM-ACTION ((btn end-recording-button))
   (let ((script-object (current-object (view-container btn))))
     (if script-object
       (end-recording btn script-object)
       (error "No script object")))
   )

(DEFMETHOD END-RECORDING ((btn end-recording-button) script-object)
   (stop-recording script-object)
   ;;  maybe select everything in the editor buffer??
   ;;  changed for 3.0  select-all needs to be called on the fred-item of the fred-view
   (select-all (first (subviews (view-named 'input-buffer (view-container btn))
                                'fred-item)))
   (dialog-item-disable btn)
   (dialog-item-enable (view-named 'start-recording (view-container btn)))
   )

(DEFMETHOD SHOW-SCRIPT ((window AS-EDITOR-WINDOW) &optional (script *bogus-script*))
   ;;  shove the script in the AS-INPUT-BUFFER
   (let ((input.buffer (view-named 'input-buffer window)))
     (set-dialog-item-text input.buffer script)
     )
   )

(DEFUN MAKE-APPLESCRIPT-EDITOR (&optional as-object)
   (cond ((and *AS-SCRIPT-EDITOR*
               (wptr *AS-SCRIPT-EDITOR*))
          (window-select *AS-SCRIPT-EDITOR*)
          (setf (current-object *AS-SCRIPT-EDITOR*) as-object)
          )
         (t
          (setf *AS-SCRIPT-EDITOR*
                (make-instance 'as-editor-window))
          (setf (current-object *AS-SCRIPT-EDITOR*) as-object)
          (let* ((v-offset 20)
                 (h-offset 15)
                 (dialog-size (view-size *AS-SCRIPT-EDITOR*))
                 (dialog-width (point-h dialog-size))
                 (dialog-height (point-v dialog-size))
                 (reserve-for-button 50)
                 (button-margin (floor
                                 (/ (- (point-h dialog-width)
                                       280 ;sum of buttons
                                       ) 2)))
                 (run-button-position nil)
                 (add-button-position nil)
                 (cancel-button-position nil))
            (setf run-button-position
                  (make-point button-margin
                              (- dialog-height 25)))
            (setf add-button-position
                  (make-point (+ 10 (point-h run-button-position)
                                 100)
                              (point-v run-button-position)))
            (setf cancel-button-position
                  (make-point (+ 10 (point-h add-button-position) 100)
                              (point-v run-button-position)))
            (add-subviews *AS-SCRIPT-EDITOR*
                          (make-instance 'check-box-dialog-item
                            :view-position #@(0 0)
                            :dialog-item-text "Show The Result?"
                            :check-box-checked-p t
                            :view-nick-name 'show-result)
                          (make-instance 'start-recording-button
                            )
                          (make-instance 'end-recording-button)
                          (make-instance 'as-input-buffer
                            :view-position (make-point 0 v-offset)
                            :view-size (make-point
                                        (- dialog-width
                                           h-offset)
                                        (- dialog-height
                                           v-offset
                                           reserve-for-button)))
                            (make-instance 'run-script-btn
                              :view-position run-button-position)
                            (make-instance 'add-script-btn
                              :view-position add-button-position)
                            (make-instance 'cancel-btn
                              :view-position cancel-button-position)))))
         )

;;(make-applescript-editor)

(defmethod set-view-size ((window AS-EDITOR-WINDOW) h &optional v)
   ;;  do the regular thing
   (declare (ignore v))
   (call-next-method)
   ;;  resize the input-buffer proportionally

   (let* ((v-offset 20)
          (h-offset 15)
          (dialog-width (point-h h))
          (dialog-height (point-v h))
          (reserve-for-button 50)
          (button-margin (floor
                          (/ (- dialog-width
                                280 ;sum of buttons
                                ) 2)))
          (run-button-position (make-point button-margin
                                           (- dialog-height 25)))
          (add-button-position (make-point (+ 10 (point-h run-button-position)
                                              100)
                                           (point-v run-button-position)))
          (cancel-button-position (make-point (+ 10 (point-h add-button-position) 100)
                                              (point-v run-button-position))))

     (set-view-size (view-named 'input-buffer window)
                    (- dialog-width h-offset)
                    (- dialog-height  v-offset  reserve-for-button))
     (set-view-position (view-named 'run-btn window) (point-h run-button-position)
                    (point-v run-button-position))
     (set-view-position (view-named 'add-btn window) (point-h add-button-position)
                    (point-v add-button-position))
     (set-view-position (view-named 'cancel-btn window) (point-h cancel-button-position)
                    (point-v cancel-button-position))
     )
   )


(DEFCLASS AS-RESULT-WINDOW (window)
   ()
   (:default-initargs
     :view-size #@(200 300)
     :window-title "Result"
     :close-box-p nil
     :grow-icon-p nil)
   )

(DEFMETHOD INITIALIZE-INSTANCE ((win AS-RESULT-WINDOW) &rest initargs)
   (apply #'call-next-method win initargs)
   (add-subviews win (make-instance 'static-text-dialog-item
                       :view-position #@(10 10)
                       :view-size #@(180 255)
                       :view-nick-name 'the-result
                       :dialog-item-text ""
                       :view-font '("Helvetica" 12 :italic :bold))
                 (make-instance 'button-dialog-item
                   :view-position #@(70 280)
                   :dialog-item-text "Hide"
                   :dialog-item-action
                   #'(lambda (btn)
                       (window-hide (view-container btn))))))

(DEFMETHOD CLEAR-RESULT-VIEW ((win AS-RESULT-WINDOW))
   (set-dialog-item-text (view-named 'the-result win) ""))

(DEFMETHOD DISPLAY-RESULT-STRING ((win AS-RESULT-WINDOW) string)
   (clear-result-view win)
   (window-select win)
   (set-dialog-item-text (view-named 'the-result win)
                         string))

;; Method for editing scripts using the applescript-editor

(DEFMETHOD EDIT-SCRIPT ((ASO SCRIPT-OBJ))
   (declare (special  *AS-SCRIPT-EDITOR*))
   (let ((script (script ASO))
         (theApp (application-name ASO)))
     (make-applescript-editor ASO)
     (if (and script
              (not (null-string-p script)))
       (show-script *AS-SCRIPT-EDITOR* script)
       (if theApp
         (show-script *AS-SCRIPT-EDITOR*
                      (concatenate 'string "tell application"
                                   (make-literal-string theApp)
                                   " to "))))
     )
   )




(defmacro WITH-APPLESCRIPT (script &aux (scriptObj (gensym)))
   "Create and execute an applescript passing in script.  Dispose of the script 
and datastructures upon exit. Returns NIL"

   `(let ((,scriptObj (make-instance 'script-obj :script ,script)))
      (unwind-protect
        (execute-applescript ,scriptObj)
        (cleanup ,scriptObj)))
   )


(defmacro WITH-SCRIPTING-ADDITION (script &aux (scriptObj (gensym)))
   "Create and execute an applescript script to a scripting addition passing t to
the quietly parameter in execute-applescript so that lisp doesn't break."
   `(let ((,scriptObj (make-instance 'script-obj :script ,script))
          )
      (unwind-protect
        (execute-applescript ,scriptObj t)
        (cleanup ,scriptObj)))
   )

;;  for compatibility with previous versions

(defclass APPLESCRIPT-OBJECT (script-obj)
   ())

