

;;; -*- package: ccl -*-
;*********************************************************************
;*                                                                   *
;*    PROGRAM     A N T I C I P A T O R Y   SYMBOL COMPLETE          *
;*                                                                   *
;*********************************************************************
   ;* Author    : Alexander Repenning (alexander@agentsheets.com)    *
   ;*             http://www.agentsheets.com                         *
   ;* Copyright : (c) 1996-2006, AgentSheets Inc.                    *
   ;* Filename  : anticipatory-symbol-complete.lisp                  *
   ;* Updated   : 08/25/06                                           *
   ;* Version   :                                                    *
   ;*   1.0     : 06/19/04                                           *
   ;*   1.0.1   : 07/04/04 Peter Paine: custom -color*, nil wait     *
   ;*   1.0.2   : 07/07/04 correct position for fred-dialog-item     *
   ;*   1.1     : 09/08/04 don't get stuck; args and space on tab    *
   ;*   1.1.1   : 09/09/04 use *Package* if Fred has no package      *
   ;*   1.2     : 09/17/04 limited support Traps package, #_blabla   *
   ;*                      cannot find unloaded traps (most)         *
   ;*   1.3     : 09/29/04 save-exit function to be image friendly   *
   ;*   1.4     : 10/06/04 play nice with Glen Foy's Color-Coded     * 
   ;*   1.4.1   : 10/21/04 handle $updateEvt                         *
   ;*   1.4.2   : 12/14/04 XML "<..." and "</..." support            *
   ;*   1.5     : 10/21/05 proactive typo alert                      *
   ;*   1.5.1   : 08/25/06 use "..." instead of ellipsis char        *
   ;* HW/SW     : G4,  MCL 5.2, OS X 10.4.7                          *
   ;* Abstract  : Attempt symbol completion while user is typing.    *
   ;*             #\tab to complete, show arglist if possible        *
   ;*             #\esc to cancel                                    *
   ;* Status    : good to go                                         *
   ;* License   : LGPL                                               *
   ;******************************************************************

(in-package :ccl)


(defvar *Wait-Time-for-Anticipatory-Symbol-Complete* 0.2 "time in seconds to wait before anticipatory symbol complete begins to search.")

(defvar *Anticipatory-Symbol-Completion-Enabled-p* t)

(defvar *Anticipatory-Symbol-Completion-Font-Color* *Gray-Color*)

(defvar *Anticipatory-Symbol-Completion-Background-Color* (make-color 55000 55000 64000))

(defvar *Zero-Completion-Hook* #'ed-beep "Call this function if there are no completions: could be the sign of a typo. Typically replace with more subtle sound.")

;; Better enable these CCL compiler preferences to get more meaninglful arglists

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless *Save-Local-Symbols* (print "ANTICIPATORY SYMBOL COMPLETE hint: To get meaningful arglists for completed functions you should set *Save-Local-Symbols* to t"))
  (unless *Fasl-Save-Local-Symbols* (print "ANTICIPATORY SYMBOL COMPLETE hint: To get meaningful arglists for completed functions you should set *Fasl-Save-Local-Symbols* to t")))

;___________________________________ 
; Completion Overlay Window         |
;___________________________________ 

(defvar *Assistant* nil)

(defun COMPLETION-OVERLAY-WINDOW () "
  Return current overlay window used for symbol completion. 
  Create one if needed."
  (or *Assistant*
      (setq *Assistant*
            (rlet ((&window :pointer)
                   (&rect :rect :topleft #@(100 100) :bottomright #@(500 140)))
              (#_CreateNewWindow #$kOverlayWindowClass 0 &rect &window)
              (%get-ptr &window)))))


(defun WAIT-FOR-TIME-OR-KEY-EVENT (Time)
  (let ((Wakeup-Time (+ (get-internal-real-time) (* Time internal-time-units-per-second))))
    (without-interrupts   ;; don't allow other threads to steal events
     (loop
       ;; timeout
       (when (>= (get-internal-real-time) Wakeup-Time) (return))
       (when (mouse-down-p) (return))
       ;; poll for key events
       (rlet ((Event :eventrecord))
         (when (#_EventAvail #$everyEvent Event)
           (case (rref Event :eventrecord.what)
             ((#.#$keyDown #.#$keyUp #.#$autoKey)  ;; Key Event
              (let ((Char (code-char (logand #$charCodeMask (rref Event :eventrecord.message)))))
                (unless (char= Char #\null)
                  (return Char))))
             ((#.#$activateEvt #.#$osEvt #.#$mouseDown #.#$mouseUp #.#$updateEvt)  ;; Window activation or OS event
              (#_getNextEvent #$everyEvent Event))
             (t 
              ;; unexpected event: send email to Alex if this happens
              (ed-beep)
              (format t "unexpected event=~A (send email to Alex)" (rref Event :eventrecord.what))))))))))


(defun SHOW-IN-OVERLAY-WINDOW (Text Position) "
  in:  Text string, Position point.
  out: Char char.
  Show <Text> in overlay window at screen <Position>. 
  Wait for key event or timeout.
  In case of key event return char."
  (let ((Window (completion-overlay-window)))
    (#_MoveWindow Window (point-h Position) (point-v Position) t)
    (#_ShowWindow window) 
    (#_SetPort (#_GetWindowPort window))
    ;; size of string?
    (with-cfstrs ((string Text))
      (rlet ((&ioBounds :point)
             (&outBaseline :signed-integer))
        (#_GetThemeTextDimensions 
         String 
         #$kThemeSmallSystemFont
         #$kThemeStateActive
         nil
         &ioBounds
         &outBaseline)
        (let ((Text-Size (add-points (%get-point &ioBounds) #@(10 0))))
          ;; paint background
          (rlet ((&rect :rect :topleft #@(-10 1) :botright Text-Size))
            (with-fore-color *Anticipatory-Symbol-Completion-Background-Color*
              (#_PaintRoundRect &rect 12 12)))
          ;; text
          (rlet ((&rect :rect :topleft #@(1 0) :botright Text-Size))
            (with-fore-color *Anticipatory-Symbol-Completion-Font-Color*
              (#_DrawThemeTextBox
               String
               #$kThemeSmallSystemFont
               #$kThemeStateActive
               nil
               &rect
               #$teJustLeft
               (%null-ptr)))))))
    (#_QDFlushPortBuffer (#_GetWindowPort window) (%null-ptr))
    (prog1
      (wait-for-time-or-key-event 5)
      (#_HideWindow window))))

;___________________________________ 
; Symbol String functions           |
;___________________________________ 

(defun COMMON-PREFIX (String1 String2)
  ;; if one string is a complete substring then return it
  (let ((Short-String (if (< (length String1) (length String2)) String1 String2)))
    (dotimes (I (length Short-String) Short-String)
      (let ((Char1 (char String1 i)))
        (unless (char= Char1 (char String2 i))
          (return (subseq Short-String 0 i)))))))
    

(defun LONGEST-PREFIX (Symbols)
  (when Symbols
    (reduce #'common-prefix (mapcar #'symbol-name Symbols))))


;___________________________________ 
; Cursor HPOS/VPOS Position fixes   |
;___________________________________ 

(defmethod FRED-HPOS ((W listener-fred-item) &optional (Pos (buffer-position 
                                                          (fred-buffer w))))
  ;; Alice's listener HPOS fix
  (let* ((Buf (fred-buffer w))
         (Frec (frec w))
         (End (buffer-line-end buf pos)))
    (cond ((and (fr.wrap-p frec)
                (eql end (buffer-size buf))
                (> end 0))
           (let* ((Start (buffer-line-start buf pos))
                  (Res (%screen-line-hpos frec start pos end)))  ;; << was end end
             ;(push (list res (fred-hpos w pos)) cow)
             (+ res 0)))   ;; fudge epsilon
          (t (fred-hpos w pos)))))


(defmethod FRED-HPOS ((Self fred-dialog-item) &optional (Pos (buffer-position (fred-buffer Self))))
  ;; need to add dialog item in window offset
  (declare (ignore Pos))
  (+ (point-h (convert-coordinates #@(0 0) Self (view-window Self)))
     (call-next-method)))


(defmethod FRED-VPOS ((Self fred-dialog-item) &optional (Pos (buffer-position (fred-buffer Self))))
  ;; need to add dialog item in window offset
  (declare (ignore Pos))
  (+ (point-v (convert-coordinates #@(0 0) Self (view-window Self)))
     (call-next-method)))

;___________________________________ 
; Completion-Request class          |
;___________________________________ 

(defclass COMPLETION-REQUEST ()
  ((time-stamp :accessor time-stamp :initform (get-internal-real-time))
   (completion-string :accessor completion-string :initform "" :initarg :completion-string)
   (completion-name :accessor completion-name)
   (completion-package :accessor completion-package)
   (fred-instance :accessor fred-instance :initarg :fred-instance)
   (fred-buffer-start :accessor fred-buffer-start :initarg :fred-buffer-start)
   (fred-buffer-end :accessor fred-buffer-end :initarg :fred-buffer-end))
  (:documentation "captures what the request is, when it was made, and where is what made"))



(defmethod INITIALIZE-INSTANCE :after ((Self completion-request) &rest Args)
  (declare (ignore Args))
  (let ((String (completion-string Self)))
    ;; explore package clues
    (when String
      (setf (completion-name Self) 
            (case (char String 0)
              ((#\: #\#) (subseq (string-upcase String) 1))
              (t (string-upcase String))))
      (setf (completion-package Self) 
            (or (and (char= (char String 0) #\:) (find-package :keyword))
                (and (char= (char String 0) #\#) (find-package :traps))
                (window-package (fred-instance Self))
                *Package* )))))


(defun ADD-SPECIAL-PACKAGE-PREFIX (String Package)
  ;; some packages have a special prefix consisting of a single character
  (cond
   ((equal Package (find-package :keyword)) (format nil ":~A" String))
   ((equal Package (find-package :traps)) (format nil "#~A" String))
   (t String)))


(defmethod PROMISING-PREFIX ((Thing string))
  ;; heuristicly exclude
  (and
   (not (char-equal (char Thing 0) #\\))  ;; char names
   (not (char-equal (char Thing 0) #\"))  ;; beginning of strings
   (not (every ;; numbers
         #'(lambda (Item)
             (member Item '(#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\d #\D #\s #\S #\e #\E #\. #\/)))
         Thing))))


(defmethod ANTICIPATORY-SYMBOL-COMPLETE ((Self completion-request)) "
  in: Completion-Request completion-request.
  Explore the opportunity for symbol completion."
  ;; don't be too eager and wait first a little
  (sleep *Wait-Time-for-Anticipatory-Symbol-Complete*)
  ;; find matching symbols
  (let* ((Local-Symbols (apropos-list (completion-name Self) (completion-package Self)))
         (Symbols (matching-prefix-symbols (completion-name Self) Local-Symbols))
         (Fred (fred-instance Self)))
    ;; proactive typo alert
    (when (and *Zero-Completion-Hook*
               (= (length Local-Symbols) 0)
               (promising-prefix  (completion-name Self)))
      (funcall *Zero-Completion-Hook*))  ;; beep when the number has dropped to zero: usually a sign of a typo
    ;; completion attempt
    (let ((Prefix (longest-prefix Symbols)))
      (when (and (> (length Prefix) (length (completion-name Self)))
                 (view-window Fred) ;; window may be gone by now!
                 (wptr (view-window Fred)))
        (setq *Show-Cursor-P* nil)
        ;; if we made it this far we better complete things
        (let* ((Extension (string-downcase (subseq Prefix (length (completion-name Self)))))
               (Char (show-in-overlay-window
                      (if (find-symbol Prefix (completion-package Self))
                        Extension
                        (format nil "~A..." Extension))
                      (add-points (add-points (view-position (view-window Fred)) #@(0 -10))
                                  (make-point (fred-hpos Fred) (fred-vpos Fred))))))
          (case Char
            ;; Tab = accept completion but don't do Fred indentation spiel
            (#\tab
             (#_FlushEvents (logior #$keyDownMask #$keyUpMask) 0)   ;; avoid indentation
             (buffer-replace-string
              Fred
              (fred-buffer-start Self)
              (fred-buffer-end Self)
              (add-special-package-prefix Prefix (completion-package Self))
              (completion-string Self))
             (when (find-symbol Prefix (completion-package Self)) 
               (without-interrupts  ;; not sure this helps, found cases in which ed-arglist can hang MCL: WHY??
                (ed-arglist Fred)))  ;; show arglist if possible
             (fred-update Fred))))))))

;___________________________________ 
; Process Management                |
;___________________________________ 

(defvar *Completion-Process* nil "process used to complete symbols in anticipatory way")


(defun COMPLETION-PROCESS ()
  (or *Completion-Process*
      (setq *Completion-Process* (make-process "Anticipatory Symbol Complete" :priority 0 :quantum 1))))


(defun START-SYMBOL-COMPLETE-PROCESS (Request)
  (process-preset (completion-process) #'(lambda () (anticipatory-symbol-complete Request)))
  (process-reset-and-enable (completion-process)))

;___________________________________ 
; Symbol-Complete.lisp functions    |
;___________________________________ 

(defmethod BUFFER-REPLACE-STRING ((Self fred-mixin) Start End String &optional Old-String) "
  in:  Self {fred-mixin}, Start End {position}, String {string}, 
       &optional Old-String {string}.
  Delete the buffer content between <Start> and <End>, insert
  <String> and place insertion marker to <End> position."
  (let ((Mark (fred-buffer Self)))
    (buffer-delete Mark Start End)
    (buffer-insert 
     Mark
     (if Old-String
       (case (string-format Old-String)
         (:upper (string-upcase String))
         (:lower (string-downcase String))
         (:capital (string-capitalize String)))
       String)))
  ;; play nice with color-coded (when present)
  (let ((Color-Code-Update-Function (find-symbol "DYNAMICALLY-STYLE-BUFFER" (find-package :cc))))
    (when (fboundp Color-Code-Update-Function) (funcall Color-Code-Update-Function Self))))


(defun STRING-FORMAT (String) "
  in:  String {string}.
  out: Capitalization {keyword} :upper, :lower :capital.
  Return the capitalization status of a string"
  (case (length String)
    (0 :lower)
    (1 (if (lower-case-p (char String 0)) :lower :upper))
    (t (if (char= (char String 0) #\*)
         (string-format (subseq String 1))
         (if (upper-case-p  (char String 0))
           (if (upper-case-p (char String 1))
             :upper
             :capital)
           :lower)))))


(defun MATCHING-PREFIX-SYMBOLS (String Symbols) "
  in:  String {string}, Symbols {list of: {symbol}}.
  out: Symbols {list of: {symbol}}.
  Return only the symbols of which <String> is a prefix."
  (let ((L (length String)))
    (remove-if-not
     #'(lambda (Symbol) (string= String (symbol-name Symbol) :end1 L :end2 L))
     Symbols)))

;___________________________________ 
; FRED extensions                   |
;___________________________________ 

(defun BUFFER-CURRENT-STRING (Buffer Position)
  (when (< (buffer-size Buffer) 1) (return-from buffer-current-string))
  (unless (char= (buffer-char Buffer Position) #\space)
    (let ((Start Position)
          (End Position)) 
      ;; scan left for delimiter
      (loop
        (when (= Start 0) (return))
        (case (buffer-char Buffer Start)
          ((#\space #\return #\( #\) #\' #\<)
           ;; special treatment for "<" versus "</" XML prefix 
           (return (incf Start (if (char= (buffer-char Buffer (1+ Start)) #\/) 2 1)))))
        (decf Start))
      ;; scan right for delimiter
      (loop
        (when (= End (buffer-size Buffer)) (return))
        (incf End)
        (case (buffer-char Buffer End)
          ((#\space #\return #\( #\)) (return))))
      (values
       (buffer-substring Buffer Start End)
       Start
       End))))


(defmethod ED-INSERT-CHAR :after ((Self fred-mixin) Char) "  
  After typing a delimiter check if there is a link"
  (unless *Anticipatory-Symbol-Completion-Enabled-P* (return-from ed-insert-char))
  (case Char
    ;; user is done with current symbol: stop completion
    ((#\space #\return)
       (process-flush (completion-process)))
    ;; new character part of current symbol
    (t
     (multiple-value-bind (String Start End)
                          (buffer-current-string (fred-buffer Self) (- (buffer-position (fred-buffer Self)) 1))
       (when (> (length String) 1)
         (start-symbol-complete-process 
          (make-instance 'completion-request 
            :completion-string String
            :fred-instance Self
            :fred-buffer-start Start
            :fred-buffer-end End)))))))

;___________________________________ 
; save-application support          |
;___________________________________ 

(defun ANTICIPATORY-SYMBOL-COMPLETE-SAVE-EXIT-FUNCTION ()
  (setq *Assistant* nil)
  (when *Completion-Process*
    (process-kill *Completion-Process*)
    (setq *Completion-Process* nil)))
  

(eval-when (:compile-toplevel :load-toplevel :execute)
  (pushnew 'anticipatory-symbol-complete-save-exit-function *Save-Exit-Functions*))
 

#| Examples:

(time (common-prefix "WITH-OPEN-FILE" "WITH-CLOSED-HOUSE"))

(time (common-prefix "WITH-OPEN-FILE" "WITH-OPEN-FILENAME"))

(time (common-prefix "WITH-OPEN-FILE" "WITH-OPEN-FILE"))



|#

