;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: l1-listener.lisp,v $
;;  Revision 1.6  2005/11/12 21:01:34  alice
;;  ;; eol stuff in stream-fresh-line
;;
;;  Revision 1.5  2003/12/08 08:39:01  gtbyers
;;  WITH-SLOTS, not WITH-SLOT-VALUES.
;;
;;  2 8/25/97  akh  fonts and colors
;;  11 1/22/97 akh  initialize-instance for listener uses *listener-process-stackseg-size* for each stack (sort of) instead of dividing by 3
;;  9 7/18/96  akh  move some methods here from elsewhere
;;  8 5/20/96  akh  call windows with class vs symbol
;;  4 1/28/96  akh  indentation
;;  2 10/17/95 akh  merge patches
;;  23 6/8/95  slh  abort-listener-input puts newline in mini-buffer before cancelled
;;  22 5/31/95 akh  no fred-update in stream-tyi-no-linemode
;;  21 5/24/95 akh  initialize mark slots before process is enabled
;;  20 5/22/95 akh  break function find-top-live-listener-process out of funcall-in-top-listener-process
;;  19 5/15/95 akh  fix stream-rubout-handler stuff - broke when moved mark slots
;;  16 5/2/95  akh  no more copy-styles-p nil - dont want to lose script
;;  15 5/1/95  akh  in ed-insert-with-style, dont ignore style if doing so would change the script
;;  14 4/26/95 akh  dont call reduce in level-1, moved some stuff back to l1-streams
;;  12 4/24/95 akh  get those parens right
;;  11 4/24/95 akh  move the marks to window - having 2 sets in split view was screwy
;;  9 4/10/95  akh  no dont
;;  8 4/10/95  akh  put back *listener-indent*
;;  6 4/10/95  akh  add default-comtab method
;;  4 4/7/95   akh  maybe no change
;;  3 4/4/95   akh  remove some nonsense from ed-insert-char
;;  8 3/2/95   akh  probably no change
;;  7 2/17/95  akh  probably no change
;;  6 2/7/95   akh  probably no change
;;  5 2/6/95   akh  probably no change
;;  4 1/31/95  akh  cancel text conditional on *quitting* in some y-or-n-dialog
;;  (do not edit before this line!!)

;L1-listener.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

;; Modification History
;
;; ed-grab-last-input - do font-face change vs. font-change
;; with-slots is silly
;; ----- 5.2b6
;; eol stuff in stream-fresh-line
; -------- 5.1 final
; view-font-codes - fix for negative font, style-other-scriptp ditto
; ---------- 5.0final
; bump *listener-process-stackseg-size* if osx-p
; ---------- 4.4b3
; 08/14/99 akh ed-yank-file beeps
; -------- 4.3f1c1
; 10/05/98 akh   ed-info-current-sexp - from Ralf Moeller
; 07/10/97 akh   ed-insert-char works with font menu, view-font-codes don't lose color
; 08/21/96 bill  (method initialize-window :after (listener)) implements Andrew Begel's
;                idea to put the process name in a Listener's window title if it is
;                a break loop Listener instead of an intentionally created Listener.
; -------------  4.0b1
; 03/25/96 bill  remove the fred-update from (method stream-tyi (terminal-io-rubout-handler))
; 03/05/96 bill  (method window-close :around (listener)) doesn't attempt to
;                access any state for a non-existing or exhausted process.
; 01/02/96 gb    dead-listener-p: not dead, just sleeping when *single-process-p*.
; akh fix reading from listener - broke when moved slots to window
;  5/04/95 slh   dead-listener-p: *initial-process* -> *event-processor*
;  4/23/05 slh   dead-listener-p: null process check
;  4/20/95 slh   use new slot my-number to number listeners
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
; 2/27/95 slh   window-menu-item: don't put command key on "dead" listener
;               new window-can-do-operation to screen execute-whole-buffer
;-------------- 3.0d17
;    ?    alice fix paste to be bold when appropriate
;               listener class gets wrap-p, history-length default initargs
;-------------- 3.0d12
;11/10/93 bill  stream-listen-no-linemode from Duncan Smith
;08/18/93 alice remove  view-font method for listener and listener-fred-item
;		add view-font-codes for listener-fred-item
;07/15/93 bill (:wrap-p t) default initarg to listener class.
;06/23/93 bill ed-grab-last-input handles negative args again
;-------------- 3.0d12
;07/14/93 alice fred-class -> fred-item-class and other renaming
;06/24/93 alice *listener-indent* is in preferences
;------------- 3.0d8
;04/29/93 bill be smarter about when to query about & kill a Listener's process.
;04/26/93 bill (method window-close :around (listener)) closes with no
;              complaints if (eq *quitting* w).
;              no more window-needs-saving-p method. Use the one for fred-window
;04/22/93 bill don't query about closing a listener if its process is exhausted.
;04/21/93 bill no args to event-dispatch - new *idle* handling
;              make a background-p process for a listener window.
;04/19/93 bill  window-needs-saving-p method
;04/16/93 bill  ed-enter-command yanks lines from above prompt-mark again.
;-------------- 2.1d5
;04/24/93 alice ed-yank and ed-yank-pop do font more simply, ed-copy-enter-command call
;		buffer-empty-font-index instead of current-buffer-font-index
;04/22/93 alice nuke default-initargs for pane splitters - inherit from fred-window
;-------------- 2.1d4
;01/21/93 alice *listener-indent* kludge
;11/08/92 alice Nuke absolute font numbers (use :bold or :plain), nuke set-view-font method for listener
;11/08/92 alice add ed-yank and ed-yank-pop which make things :bold if after read-mark
;10/10/92 alice new method for ed-insert-char, change stream-tyo stream-write-string ed-grab-last-input
;03/24/93 bill  (method window-menu-item (listener)) causes <command>-L to
;               select the topmost listener unless it is the (front-window),
;               in which case it selects the next listener.
;               Ask for confirmation if a Listener is not in its read loop when it is closed.
;12/17/92 bill  stream-tyi-no-linemode no longer calls event-dispatch.
;12/09/92 bill  (slot-value w 'process) -> (window-process w)
;11/20/92 gb    (make-instance 'listener :process ... /:process-function ...)
;12/04/92 bill  ed-grab-last-input now works correctly after (toplevel) when
;               there are two bold lines with only "? " between them.
;11/17/92 bill  fr.xxx -> accessor functions
;07/07/92 bill  ed-grab-last-input no longer errors when called too many times
;               with a negative argument
;04/22/92 bill  ed-grab-last-input (m-g) now handles negative arguments
;-------------- 2.0
;07/30/91 alice in listener-comtab c-? is listener help
;07/10/91 alice history-length is default initarg for listener
;05/29/91 bill reparse-modeline is a nop in the listener
;05/03/91 alice prefix-numeric-value => fred-prefix-numeric-value
;03/18/91 alice ed-beginning-of-line do it even if selection
;----------------- 2.0b1
;01/29/91 bill ed-grab-last-command now inserts into previous typing
;12/03/91 bill (view-font (current-listener)) now contains :plain.
;11/02/90 bill view-default-font for listener
;11/01/90 bill (slot-value w 'last-command) -> (fred-last-command w)
;10/10/90 bill speed up listener output by replacing slot-value with reader methods.
;08/29/90 joe  removed *listener-window-size* & *listener-window-position* from 
;              default-initargs
;              added specific methods for view-default-position & view-default-size
;08/23/90 bill stream-force-output tells window-show-cursor that we are
;              scrolling so that error messages will not scroll off
;              the top of the screen.
;08/21/90 bill the listener no longer copies styles on CUT or COPY.
;08/03/90 bill :parent -> :class
;07/30/90 bill :auto-purge-fonts-p nil default-initarg to listener class.
;07/05/90 bill buffer-insert-string -> buffer-insert-substring
;              keyword args to windows & front-window
;07/03/90 bill window-ensure-on-screen when listener opens.
;06/22/90 bill window-font -> view-font
;06/13/90 bill stream-tyo requires a character second arg
;06/12/90 bill window-update -> fred-update, window-buffer -> fred-buffer
;05/24/90 bill window-activate-event-handler -> view-activate-event-handler
;              :window-position & :window-size -> :view-position & :view-size
;03/20/90 bill initialize-instance -> instance-initialize.
;01/13/90  gz  Pass idle arg to event-dispatch in stream-tyi-no-linemode.
;12/31/89 bill Add (method initialize-instance :after (listener)) to make sure
;              that <Command>-L works before pulling down a menu.
;09/28/89 bill Add (method stream-write-string (listener))
;07/20/89  gz  clos menus
;05/20/89  gz window-update -> window-object-update
;05/02/89  gz  initialize *listener-comtab* here.
;3/18/89   gz  window-foo -> window-object-foo.
;3/17/89   gz  window-activate => window-activate-event-handler
;13-apr-89 as  ed-next/last-input-line
;03/10/89  gz  No more *dribble-input-mixin*.
;10-apr-89 as  ed-grab-last-input
;8-apr-89  as  new comtab scheme
;01/09/89  gz  Use prompt-mark to limit ^A/^B/rubout.
;01/04/89  gz  Don't inherit from selection-streams.
;12/30/88  gz  new buffers.
;12/11/88  gz  mark-position -> buffer-position
;11/25/88  gz  new fred windows
; 9/10/88  gz  tw8$ -> tw$
;8/15/88 gz  moved ed-abort-listener-input here from fred-additions.
;6/24/88 as  new syntax for ed-insert-with-style
;6/23/88 as  (ed-insert-with-style *listener*)
;4/9/88  as  fixed set-window-font for listeners
;3/31/88 gz  New macptr scheme.  Flushed pre-1.0 edit history.
;9/16/87 jaj added prompt-mark to listeners
;--------------------------Version 1.0--------------------------------------

(defparameter *listener-comtab*
  (let ((comtab (make-comtab)))
    (comtab-set-key comtab #\CR                            'ed-enter-command)
    (comtab-set-key comtab '(:control #\CR)                'ed-self-insert)
    (comtab-set-key comtab '(:meta #\CR)                   'ed-copy-enter-command)
    (comtab-set-key comtab #\Enter                         'ed-copy-enter-command)
    (comtab-set-key comtab '(:control :meta #\p)           'ed-last-input-line)
    (comtab-set-key comtab '(:control :meta #\n)           'ed-next-input-line)
    (comtab-set-key comtab '(:meta #\g)                    'ed-grab-last-input)
    (comtab-set-key comtab '(:control #\g)                 'ed-abort-listener-input)
    (comtab-set-key comtab '(:control #\?)		   'ed-listener-help)
    comtab))


(defclass listener-fred-item (window-fred-item input-stream)
  ((comtab :initform *listener-comtab*)
   (tyo-count :initform 0 :accessor listener-tyo-count)
   ;(read-mark :reader listener-read-mark)
   ;(eof-mark :reader listener-eof-mark)
   ;(start-mark :reader listener-start-mark)
   ;(prompt-mark :reader listener-prompt-mark)
   )
  (:default-initargs    
    :wrap-p t
    :history-length *listener-history-length*
    :copy-styles-p t
    :auto-purge-fonts-p nil))

(defmethod default-comtab ((item listener-fred-item))
  *listener-comtab*)
  

(defclass listener (fred-window)
  ((listener-num :allocation :class :initform 0)
   (my-number :initform 0 :accessor window-number)
   (read-mark :reader listener-read-mark)
   (eof-mark :reader listener-eof-mark)
   (start-mark :reader listener-start-mark)
   (prompt-mark :reader listener-prompt-mark))
  (:default-initargs
    :fred-item-class 'listener-fred-item
    :wrap-p t
    :history-length *listener-history-length*
    :copy-styles-p t
    :scratch-p t
    :window-title "Listener"))

#|
(defvar *default-listener-class* 'listener)

(defmethod stream-current-listener ((stream t))
  (or *top-listener*
      (setq *top-listener* (front-window :class *default-listener-class*))
      #|
      (setq *top-listener* (make-instance *default-listener-class*
                             :process *current-process*))
      |#
))


(defmethod stream-current-listener ((stream front-listener-terminal-io))
  (or *top-listener*
      (front-window :class *default-listener-class*)
      (call-next-method)))
|#


(defvar *front-listener-terminal-io* (make-instance 'front-listener-terminal-io))

(defmethod view-default-font ((view listener))
  *listener-default-font-spec*)

(defmethod view-default-position ((w listener))
  *listener-window-position*)

(defmethod view-default-size ((w listener))
  *listener-window-size*)

(defvar *default-listener-class* 'listener)

(defmethod initialize-window :before ((w listener) &key
                                      &aux (buf (fred-buffer w)))
  (multiple-value-bind (ff ms) (buffer-font-codes buf)    
    (add-buffer-font buf (logxor #x100 ff) ms))
  (let* ((max -1)
         (fn #'(lambda (ww)
                 (when (neq ww w)
                   (setq max (max  (window-number ww) max))))))
    (declare (dynamic-extent fn))
    (map-windows fn :class 'listener :include-invisibles t)
    (when (> max -1)
      (setf (window-number w) (1+ max)))))


(defmethod initialize-window :after ((w listener) &key PROCESS)
  (let ((my-number (window-number w)))
    (unless (zerop my-number)
      (set-window-title w (%str-cat "Listener "
                                    (%integer-to-string my-number)))))
  (when (and process
             (typep process 'process)
             (not *single-process-p*)
             (without-interrupts
              (or
               (process-exhausted-p process)
               (not (process-is-listener-p process)))))
    (set-window-title w (%str-cat (window-title w)
                                  " (Process \""
                                  (process-name process)
                                  "\")")))
  (let ((buf (fred-buffer w)))
    (setf (slot-value w 'read-mark) (make-mark buf t t))
    (setf (slot-value w 'eof-mark) (make-mark buf t t))
    (setf (slot-value w 'start-mark) (make-mark buf t t))
    (setf (slot-value w 'prompt-mark) (make-mark buf t t)))   
  (incf (slot-value w 'listener-num))
  ;    (fred-update w)
  )

(defvar *listener-process-stackseg-size* (* 4 16384))
(def-ccl-pointers listener-stack ()
  (if (osx-p) 
    (setq *listener-process-stackseg-size* (* 16 32768))
    (setq *listener-process-stackseg-size* (* 4 16384))))

(defmethod initialize-instance :after ((item listener)
                                       &key  (process-function #'(lambda ()
                                                                   (loop
                                                                     (catch :toplevel
                                                                       (toplevel-loop))))))
  (window-ensure-on-screen item)
  (let ((w (view-window item)))
    (unless (window-process w)
      (let* ((p 
              #+ppc-target
              (make-process (window-title w) :background-p t
                            ; this way (fact 5500) wins (vs 5600 in 3.0)
                            :stack-size *listener-process-stackseg-size*
                            :vstack-size *listener-process-stackseg-size*
                            ; *min-tstack-size* is 32K though
                            :tstack-size (ceiling *listener-process-stackseg-size* 3))
              #-ppc-target
              (make-process *main-listener-process-name* :background-p t
                         :stack-size  *listener-process-stackseg-size*)))
              
        (process-preset p #'(lambda ()
                              (setq *top-listener* w)
                              (funcall process-function)))
        (process-enable p)
        (setf (window-process w) p)))
    (menu-update *windows-menu*)))
  
#|    
(defmethod instance-initialize :after ((w listener) &rest initargs)
  (declare (ignore initargs))
  (window-ensure-on-screen w)
  (menu-update *windows-menu*))         ; make sure <command>-L works
|#
; Ask for confirmation if a Listener is not in its read loop when it is closed.
(defmethod window-close :around ((w listener))
  (let* ((p (window-process w))
         (exhausted-p (or (null p) (process-exhausted-p p))))
    (when (or exhausted-p
              (not (window-close-kills-process-p w p))
              (eq *quitting* w)
              (process-is-toplevel-listener-p p)
              (y-or-n-dialog
               (format nil "Close ~s and abort execution in progress?" w)
               :cancel-text (if *quitting* "Cancel" nil)))
      ; Hide errors in closing the window
      (window-hide w)
      (unless exhausted-p
        (setf (symbol-value-in-process '*top-listener* p) nil))
      (call-next-method))))

(defmethod window-close-kills-process-p ((w listener) process)
  (or (process-exhausted-p process)
      (process-is-listener-p process)))

(defun dead-listener-p (window)
  (let ((process (window-process window)))
    (or (null process)
        (process-exhausted-p process)
        (unless *single-process-p*
          (eq process *event-processor*)))))

(defmethod window-menu-item ((w listener))
  (let* ((item (call-next-method))
         first-listener second-listener
         (mapper #'(lambda (w)
                     (unless (dead-listener-p w)
                       (cond (first-listener
                              (setq second-listener w)
                              (throw item nil))
                             (t (setq first-listener w)))))))
    (declare (dynamic-extent mapper))
    (catch item
      (map-windows mapper :class  (find-class 'listener)))
    (set-command-key item 
                     (when (and (not (dead-listener-p w))
                                (if (eq (front-window) first-listener)
                                  (or (null second-listener)    ; we're only listener, in front
                                      (eq w second-listener))   ; we're behind front listener
                                  (eq w first-listener)))       ; we're frontmost listener
                       #\L))
    item))

(defmethod window-can-do-operation ((w listener) op &optional item)
  (case op
    (execute-whole-buffer nil)
    (t (call-next-method w op item))))

(defmethod ed-rubout-char ((view listener-fred-item))
  (let ((prompt-mark (listener-prompt-mark view)))
    (multiple-value-bind (b e) (selection-range view)
      (when (or (neq b e) (neq b (buffer-position prompt-mark)))
        (call-next-method)))))


(defmethod ed-backward-char ((view listener-fred-item))
  (let ((prompt-mark (listener-prompt-mark view))
        (buf (fred-buffer view)))
    (unless (collapse-selection view nil)
      (unless (eq (buffer-position buf) 
                  (buffer-position prompt-mark))
        (call-next-method)))))


(defmethod ed-beginning-of-line ((view listener-fred-item) &aux
                                 (buf (fred-buffer view)))
  (collapse-selection view nil)
  (let* ((begpos (buffer-line-start buf)) 
         (promptpos (buffer-position (listener-prompt-mark view))))
    (when (<= begpos promptpos (buffer-position buf))
      (setq begpos promptpos))
    (set-mark buf begpos)))


(defmethod ed-enter-command ((w listener-fred-item))
  (let ((prompt-mark (listener-prompt-mark w))
        (eof-mark (listener-eof-mark w)))
    (let* ((buf (fred-buffer w))
           (bold-font-index (multiple-value-bind (ff ms) (buffer-font-codes buf)
                              (multiple-value-setq (ff ms) (font-codes ':bold ff ms))
                              (buffer-font-index buf ff ms))))
      (cond ((< (buffer-position buf) (buffer-position prompt-mark))
             (multiple-value-bind (b e) (selection-range w)
               (when (eq b e)
                 (let ((ifont bold-font-index))
                   (when (and (not (%izerop b))
                              (eq ifont (buffer-char-font-index buf (%i- b 1))))
                     (setq b (or (buffer-previous-font-change buf b) 0)))
                   (when (and (not (buffer-end-p buf e))
                              (eq ifont (buffer-char-font-index buf e)))
                     (setq e (or (buffer-next-font-change buf e)
                                 (buffer-size buf)))))
                 (when (and (%i< b e)
                            (char-eolp (buffer-char buf (%i- e 1))))
                   (setq e (%i- e 1))))
               (let ((pos (%i+ (buffer-size buf) (%i- (buffer-position buf) b))))
                 (while (%i< b e)
                   (buffer-insert buf (buffer-char buf b) t bold-font-index)
                   (setq b (%i+ b 1)))
                 (unless (%i< pos (buffer-size buf)) (setq pos (buffer-size buf)))
                 (set-selection-range w pos pos))))
            (t (unless (or (buffer-start-p buf)
                           (char-eolp
                               (buffer-char buf (1- (buffer-position buf)))))
                 (buffer-insert buf (or *preferred-eol-character* #\return) t bold-font-index))
               (set-mark eof-mark t)
               (set-selection-range w  t t))))))

(defmethod ed-copy-enter-command ((w listener-fred-item))
  (when (< (buffer-position (fred-buffer w))
           (buffer-position (listener-prompt-mark w)))
    (ed-enter-command w))
  (ed-enter-command w))


(defmethod ed-last-input-line ((w listener-fred-item) &optional (reverse-p t))
  (let* ((buf (fred-buffer w))
         (start (buffer-position buf))
         (end start)
         (size (buffer-size buf))
         (*buffer-fold-bounds* t))
    (if reverse-p
        (unless (and (setq end (buffer-previous-font-change buf (1- start)))
                     (setq end (1- end))
                     (or (neq 0
                              (logand #.(cdr (assoc :bold *style-alist*))
                                      (ash (buffer-char-font-codes buf end) -8)))
                         (and (setq end (buffer-previous-font-change buf end))
                              (setq end (1- end)))))
          (ed-beep)
          (setq end 0))
        (unless (and (setq end (buffer-next-font-change buf (1+ start)))
                     (or (eq 0 (logand (buffer-char-font-codes buf end) #xFFFF)) ;plain
                         (and (setq end (buffer-next-font-change buf end))
                              (setq end (1- end)))))
          (setq end size)
          (ed-beep)))
    (set-mark buf end)
    (window-show-selection w)))


(defmethod ed-next-input-line ((w listener-fred-item))
  (ed-last-input-line w nil))

#|
(defmethod ed-grab-last-input ((w listener-fred-item) &aux
                                 (buffer (fred-buffer w))
                                 last start end insert end-insert appendp)
    "drops succesive input lines to the bottom of the listener"
    (let ((n (fred-prefix-numeric-value w))) ; two m-3g in a row get confused cause last command will be prefix
      (let ((read-mark (listener-read-mark w))
            (orig-start))
        ;    (buffer-delete buffer t read-mark)
        (if (and (setq last *last-command*)
                 (listp last)
                 (eq (car last) '%grab-last))
          (progn
            (setq start (cadr last)
                  insert (caddr last)
                  end-insert (cadddr last))
            
            (setq appendp (ed-delete-with-undo w insert end-insert)))
          ;(buffer-delete buffer end-insert insert))
          (setq start (buffer-position read-mark)
                insert (buffer-position buffer)))
        (when 
          (dotimes (i (abs n) end)
            (unless
              (if (> n 0)
                (and (> start 0)
                     (setq end (buffer-previous-font-change buffer start))
                     (setq start (buffer-previous-font-change buffer end)))
                (and (< start (buffer-size buffer))
                     (setq start (buffer-next-font-change buffer start))
                     (setq start (buffer-next-font-change buffer start))
                     (setq end (buffer-next-font-change buffer start))))
              (return nil)))
          (while (char-eolp (buffer-char buffer (1- end)))
            (setq end (1- end)))
          (when (eq (buffer-char buffer start) #\space)  ; <<
            (setq orig-start start)
            (setq start (1+ start)))
          ;(print (list start end))
          (ed-insert-with-undo w (buffer-substring buffer end start) insert appendp '(:bold))
          ;(buffer-insert buffer (buffer-substring buffer end start) insert 2)
          (setq end-insert (buffer-position buffer))
          (set-selection-range w  end-insert end-insert)
          (set-fred-last-command
           w (list '%grab-last (or orig-start start) insert end-insert))))))
|#



(defmethod ed-grab-last-input ((w listener-fred-item) &aux
                                 (buffer (fred-buffer w))
                                 last start end insert end-insert appendp)
    "drops succesive input lines to the bottom of the listener"
    (let ((n (fred-prefix-numeric-value w))) ; two m-3g in a row get confused cause last command will be prefix
      (let ((read-mark (listener-read-mark w))
            (orig-start))
        ;    (buffer-delete buffer t read-mark)
        (if (and (setq last *last-command*)
                 (listp last)
                 (eq (car last) '%grab-last))
          (progn
            (setq start (cadr last)
                  insert (caddr last)
                  end-insert (cadddr last))
            
            (setq appendp (ed-delete-with-undo w insert end-insert)))
          ;(buffer-delete buffer end-insert insert))
          (setq start (buffer-position read-mark)
                insert (buffer-position buffer)))
        (when 
          (dotimes (i (abs n) end)
            (unless
              (if (> n 0)
                (and (> start 0)
                     (setq end (buffer-previous-face-change buffer start))
                     (setq start (buffer-previous-face-change buffer end)))
                (and (< start (buffer-size buffer))
                     (setq start (buffer-next-face-change buffer start))
                     (setq start (buffer-next-face-change buffer start))
                     (setq end (buffer-next-face-change buffer start))))
              (return nil)))
          (while (char-eolp (buffer-char buffer (1- end)))
            (setq end (1- end)))
          (when (eq (buffer-char buffer start) #\space)  ; <<
            (setq orig-start start)
            (setq start (1+ start)))
          ;(print (list start end))
          (ed-insert-with-undo w (buffer-substring buffer end start) insert appendp '(:bold))
          ;(buffer-insert buffer (buffer-substring buffer end start) insert 2)
          (setq end-insert (buffer-position buffer))
          (set-selection-range w  end-insert end-insert)
          (set-fred-last-command
           w (list '%grab-last (or orig-start start) insert end-insert))))))

(defun buffer-next-face-change (buffer &optional pos)
  (setq pos (buffer-position buffer pos))
  (let* ((cur-face (logand #xff00 (buffer-char-font-codes buffer pos)))
         (size (buffer-size buffer)))
    (loop
      (setq pos (buffer-next-font-change buffer pos))
      (if (null pos)(return size))
      (when (neq cur-face (logand #xff00 (buffer-char-font-codes buffer  pos)))
        (return pos)))))

(defun buffer-previous-face-change (buffer &optional pos)
  (setq pos (buffer-position buffer pos))
  (when (> pos 0)      
    (let ((cur-face (logand #xff00 (buffer-char-font-codes buffer  (1- pos))))
          (next-pos (buffer-previous-font-change buffer pos)))
      (if (or (eq 0 next-pos)
              (and (neq pos next-pos)
                   (neq cur-face (logand #xff00 (buffer-char-font-codes buffer (1- next-pos))))))
        next-pos
        (loop
          (setq next-pos (buffer-previous-font-change buffer next-pos))
          (when (or (eq 0 next-pos)
                    (neq cur-face (logand #xff00 (buffer-char-font-codes buffer  (1- next-pos)))))
            (return next-pos)))))))



(defun listener-bold-p (w)
  (let* ((pos (selection-range w))
         (rpos (buffer-position (listener-read-mark w))))
    (when (>= pos rpos)
      (set-view-font w '(:bold)))))
  
(defmethod ed-yank ((w listener-fred-item))
  (listener-bold-p w)
  (call-next-method)
  ; in case nothing got inserted
  (set-view-font w nil))

(defmethod paste ((w listener-fred-item))
  (listener-bold-p w)
  (call-next-method)
  ; in case nothing got inserted
  (set-view-font w nil))


(defmethod ed-yank-pop ((w listener-fred-item))
  (listener-bold-p w)
  (call-next-method)
  ; in case nothing got inserted 
  (set-view-font w nil))
  

(defmethod ed-abort-listener-input ((w listener-fred-item))
  "ignores user input and prints a new listener prompt"
  (set-mark (listener-read-mark w) t)
  (set-selection-range w  t t)
  (set-mini-buffer w "~&Cancelled."))


(defmethod stream-tyo ((w listener-fred-item) char)
  (setq char (require-type char 'character))
  (without-interrupts
   (let ((read-mark (listener-read-mark w))
         (eof-mark (listener-eof-mark w)))
     (buffer-insert read-mark char nil '(:plain))
     (let ((pos (buffer-position read-mark)))
       ;Is this really needed?
       (when (eq pos (buffer-position eof-mark))
         (move-mark eof-mark 1))
       (move-mark read-mark 1))
     (incf (listener-tyo-count w)))
   (when (char-eolp char)
     (when *listener-indent*
       (stream-tyo w #\space)
       (stream-tyo w #\space))
     (stream-force-output w))))



(defmethod stream-write-string ((w listener-fred-item) string start end)
  (let ((len (- end start)))
    (without-interrupts
     (let ((read-mark (listener-read-mark w))
           (eof-mark (listener-eof-mark w)))
       (let ((n (if *listener-indent* (string-eol-position string start end)))) ;(position #\newline string :start start :end end :test #'eq))))
         (cond
          (n (when (neq n start)
               (stream-write-string w string start n))
             (stream-tyo w (or *preferred-eol-character* #\return))
             (when (neq n (1- end))
               (stream-write-string w string (1+ n) end)))
          (t (buffer-insert-substring read-mark string start end nil '(:plain)) ; <<
             (let ((pos (buffer-position read-mark)))
               ;Is this really needed?
               (when (eq pos (buffer-position eof-mark))
                 (move-mark eof-mark len))
               (move-mark read-mark len)
               )
             ;(stream-force-output w) ; slows things (e.g. disassemble) down by a factor of 2
             (incf (listener-tyo-count w) len))))))))


(defmethod stream-force-output ((w listener-fred-item))
  (unless (%izerop (listener-tyo-count w))
    (window-show-cursor w (listener-read-mark w) t)
    (setf (listener-tyo-count w) 0)))





(defmethod stream-fresh-line ((w listener-fred-item) &aux pos)
  (let ((read-mark (listener-read-mark w)))
    (when (not (%izerop (setq pos (buffer-position read-mark))))
      (cond
       (*listener-indent*
        (if (char-eolp (buffer-char read-mark (%i- pos 1)))
          (progn (stream-tyo w #\space)
                 (stream-tyo w #\space)
                 t)
          (when (and (> pos 2)(not (char-eolp (buffer-char read-mark (%i- pos 3)))))
            (stream-tyo w #\return)
            t)))
        ((not (char-eolp (buffer-char read-mark (%i- pos 1))))
         (stream-tyo w #\return)
         t)))))



(defmethod stream-column ((w listener-fred-item))
  (let ((read-mark (listener-read-mark w)))
    (let ((start (buffer-line-start read-mark)))
      (if (not *listener-indent*)
        (%i- (buffer-position read-mark) start)
        (%i- (buffer-position read-mark)(%i+ start 2))))))


(defmethod stream-tyi-no-linemode ((w listener))
  (stream-tyi-no-linemode (window-key-handler w)))

(defmethod stream-tyi-no-linemode ((w listener-fred-item))
  (stream-force-output w)
  (let ((read-mark (listener-read-mark w))
        (eof-mark (listener-eof-mark w)))
    (while (buffer-end-p read-mark)
      (when (%i< (buffer-position (fred-buffer w))
                 (buffer-position read-mark))
        (set-mark (fred-buffer w) t)
        (window-show-cursor w))
      ;(fred-update w)  ; take her out - causes weird flicker
      (event-dispatch t))
    (let ((char (without-interrupts
                 (when (mark-equal-p read-mark eof-mark)
                   (move-mark eof-mark 1))
                 (buffer-read-char read-mark))))
      (if *dribble-stream* (dribble-tyi char))
      char)))

(defmethod stream-listen-no-linemode ((w listener))
  (stream-listen-no-linemode (window-key-handler w)))

(defmethod stream-listen-no-linemode ((w listener-fred-item))
  (stream-force-output w)
  (not (buffer-end-p (listener-read-mark w))))

(defmethod stream-tyi ((w listener))
  (stream-tyi (window-key-handler w)))

(defmethod stream-tyi ((w listener-fred-item))
  (let ((read-mark (listener-read-mark w))
        (eof-mark (listener-eof-mark w))
        (start-mark (listener-start-mark w)))
    (if (%i< (buffer-position read-mark) (buffer-position eof-mark))
      (let ((char (buffer-read-char read-mark)))
        (if *dribble-stream* (dribble-tyi char))
        char)
      (progn
        (reset-input w (buffer-position start-mark))
        (throw '%re-read nil)))))

(defmethod stream-untyi ((w listener) char)
  (stream-untyi (current-key-handler w) char))

(defmethod stream-untyi ((w listener-fred-item) char)
  (declare (ignore char))
  (move-mark (listener-read-mark w) -1)
  (if *dribble-stream* (dribble-untyi)))


(defmethod stream-eofp ((w listener))
  (stream-eofp (window-key-handler w)))

(defmethod stream-eofp ((w listener-fred-item))
  (%i>= (buffer-position (listener-read-mark w))
        (buffer-position (listener-eof-mark w))))


(defmethod reset-input ((w listener-fred-item) &optional pos)
  (let ((read-mark (listener-read-mark w))
        (eof-mark (listener-eof-mark w)))
    (when (null pos)
      (setq pos (buffer-position read-mark)))
    (when (%i<= pos (buffer-position eof-mark))
      (set-mark read-mark pos)
      (set-mark eof-mark pos))))



#|
;(defmethod view-font ((w listener))
  (let* ((res (call-next-method))
         (bold (memq :bold res)))
    (if bold (setf (car bold) :plain))
    res))
|#

#|
(defmethod view-font-codes ((w listener-fred-item))
  (multiple-value-bind (ff ms)(call-next-method)
    (values (logand ff #xffff00ff) ms)))

;; or (logand ff (- (+ #Xff00 1)))
|#

(defmethod view-font-codes ((w listener-fred-item))
  (multiple-value-bind (ff ms)(call-next-method)
    (values (logand ff (- (+ #Xff00 1))) ; lose face, keep possible negative font
            ms)))

(defun style-other-scriptp (style script)
  (when (consp style)(setq style (car style)))
  (let ((nfonts (aref style 0)))
      (dotimes (i nfonts)
        (when (neq (font-2-script (font-in (aref style (+ i i 1)))) script)
          (return t)))))    

; keep style if removing it would change script of insertion
(defmethod ed-insert-with-style ((w listener-fred-item) string style &optional pos)
  (if style
    (let* ((buffer (fred-buffer w))
           (ff (buffer-char-font-codes buffer pos)) ; not quite right - need buffer-char-insert-font-codes
           (script (ff-script ff)))
      (if (style-other-scriptp style script)
        (progn (call-next-method))
        (call-next-method w string nil pos)))
    (call-next-method)))

(defmethod reparse-modeline ((w listener) &optional no-create)
  (declare (ignore no-create))
  nil)

(defmethod reparse-modeline ((w listener-fred-item) &optional no-create)
  (declare (ignore no-create))
  nil)



(defmethod ed-insert-char ((w listener-fred-item) char
                           &aux ;(frec (frec w))
                           (buf (fred-buffer w))
                           undo-cons)
  (multiple-value-bind (b e) (selection-range w)
    (when (neq b e)
      (setq undo-cons (ed-delete-with-undo w b e nil))      
      (fred-update w))
    (let ((pos (buffer-position buf)))
      (when nil (and (<= (fr.bwin frec) ;(frec-screen-line-start frec (fr.wposm frec))
                     pos)
                 (< pos
                    (buffer-position (fr.wposm frec))))
        (set-mark (fr.wposm frec) buf))
      (multiple-value-bind (ff ms)(buffer-font-codes buf)
        (multiple-value-bind (ff ms) (font-codes ':bold ff ms)
          (buffer-set-font-codes buf ff ms)))
      (cond ((fred-history w)
             ; used to pass '(:bold) to ed-insert-with-undo - didn't work with font menu
                          
             (ed-insert-with-undo w char pos 
                                  (or undo-cons (eq *last-command* ':self-insert))
                                  )
             ;(buffer-change-font-index buf 2 pos (1+ pos)) 
             (set-fred-undo-stuff w :self-insert "Typing"))
            (t (buffer-insert buf char))))))


(defmethod listener-read-mark ((w listener-fred-item))
  (listener-read-mark (view-window w)))

(defmethod listener-eof-mark ((w listener-fred-item))
  (listener-eof-mark (view-window w)))

(defmethod listener-prompt-mark ((w listener-fred-item))
  (listener-prompt-mark (view-window w)))

(defmethod listener-start-mark ((w listener-fred-item))
  (listener-start-mark (view-window w)))

; new versions  of some stuff from l1-streams

(defmethod stream-clear-input ((stream terminal-io))
  (let ((w *top-listener*))
    (when w
      (stream-clear-input w))))

(defmethod stream-clear-input ((w listener))
  (let ((item (window-key-handler w)))
    (set-mark (listener-read-mark item) t)
    (set-selection-range item t t)))

(defmethod stream-listen ((w listener))
  (stream-listen (window-key-handler w)))

;; also in l1-streams.lisp but slightly different - this is loaded later
(defmethod stream-tyi ((stream terminal-io-rubout-handler))
  (let ((buffer-modcnt (slot-value  stream 'buffer-modcnt))
        (start-mark (slot-value stream 'start-mark)))
    (loop
      (let* ((listener (current-listener))
             (read-mark (listener-read-mark listener))
             (eof-mark (listener-eof-mark listener)))
        ;This could really use some cooperation from ed-self-insert so
        ;that typing at end of buffer shouldn't cause reparsing...
        (unless (and (same-buffer-p start-mark  read-mark)
                     (eql buffer-modcnt (buffer-modcnt start-mark)))
          (throw start-mark nil))      ;re-read
        (unless (buffer-end-p read-mark)
          (return
           (without-interrupts
            (when (mark-equal-p read-mark eof-mark)
              (move-mark eof-mark 1))
            (stream-tyi listener))))
        ; This causes the cursor to blink rapidly
        ;(fred-update listener)
        (event-dispatch)))))

(defmethod stream-rubout-handler ((stream terminal-io) reader)
  (let ((rubout-stream (make-instance 'terminal-io-rubout-handler)))
    (loop
      (catch (let ((listener (current-listener)))
               (let* ((start (slot-value rubout-stream 'start-mark))
                      (read-mark (listener-read-mark listener)))
                 (unless (and start (same-buffer-p start read-mark))
                   (setq start (make-mark read-mark read-mark t))
                   (setf (slot-value rubout-stream 'start-mark) start)
                   ;Various editor commands look at this...
                   (set-mark (listener-prompt-mark listener) start))
                 (set-mark read-mark start)
                 (setf (slot-value rubout-stream 'buffer-modcnt)
                       (buffer-modcnt read-mark))
                 start))
        (return (funcall reader rubout-stream))))))

(defun find-top-live-listener-process ()
  (let* ((p nil)
         (q nil)
         (listeners (windows :class *default-listener-class*)))
    (unwind-protect
      (dolist (l listeners)
        (if (and (typep (setq q (window-process l)) 'process)
                 (process-active-p q)
                 (process-is-listener-p q))
          (return (setq p q))))
      (cheap-free-list listeners))
    p))

(defun funcall-in-top-listener-process (f &rest args)
  (declare (dynamic-extent args))
  (let* ((p (find-top-live-listener-process)))
    (apply #'process-interrupt (or p *current-process*) f args)))



(defmethod ed-start-top-level-sexp ((w listener) &optional select)
  (declare (ignore select))
  (let ((pos (listener-start-top-level-sexp w)))
    (if pos
      (frec-set-sel (frec w) pos pos)
      (ed-beep))))    

(defun listener-start-top-level-sexp (w &optional stationary)
  (let* ((buf (fred-buffer w))
         (pos (buffer-position buf))
         (prompt "
? ")
         (prompt-pos (buffer-backward-search buf prompt))
         (size (buffer-size buf)))
    (declare (fixnum pos size))
    (while (and prompt-pos
                (incf prompt-pos 3)
                (or (unless stationary (eql pos prompt-pos))
                    (and (< prompt-pos size)
                         (char-eolp (buffer-char buf prompt-pos)))))
      (setq prompt-pos (buffer-backward-search buf prompt (- prompt-pos 3))))
    (if (and (null prompt-pos) (> pos 2) (eql #\? (buffer-char buf 0)))
      (setq prompt-pos 2))
    prompt-pos))

(defmethod ed-end-top-level-sexp ((w listener) &optional select)
  (declare (ignore select))
  (let* ((buf (fred-buffer w))
         (pos (buffer-position buf))
         (size (buffer-size buf))
         start-pos end)
    (when (eql pos size)
      (ed-beep) (return-from ed-end-top-level-sexp))
    (setq start-pos (or (listener-start-top-level-sexp w t) pos))
    (setq end (or (buffer-next-font-change buf start-pos) (1+ size)))
    (when (<= (decf end) pos)
      (setq start-pos pos)
      (loop
        (setq start-pos (buffer-forward-search buf "
? " start-pos))
        (unless (and start-pos (< start-pos size))
          (setq end size) (return))
        (unless (char-eolp (buffer-char buf start-pos))
          (progn
            (setq end (or (buffer-next-font-change buf start-pos) (1+ size)))
            (if (eql (decf end) size) (return))
            (unless (eql end start-pos)
              (return))))))
    (frec-set-sel (frec w) end end)))

(defmethod ed-info-current-sexp ((w listener-fred-item))
  (multiple-value-bind (b e)
                       (ed-current-sexp-bounds w)
    (if (eq b e)
      (eval-enqueue '(inspect *))
      (inspect (ed-current-sexp w e)))))

(defmethod ed-yank-file ((w listener-fred-item))
  (ed-beep))

  

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
