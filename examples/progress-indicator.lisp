; -*- Mode:Lisp; Package:CCL; -*-

;;	Change History (most recent first):
;;  3 4/24/95  akh  make it work
;;  2 4/12/95  akh  update for 3.0, put in package :ccl
;;  (do not edit before this line!!)

; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995 Digitool, Inc.

; Modification History
;
; #_drawstring -> grafport-write-string
;; ------ 5.2b4
;  9/19/96 slh    remove with-cursor *watch-cursor* - let caller specify it, doesn't
;                 make sense with an interactive dialog or multiple processes anyway
;  9/16/96 slh    new use-minibuffer option; fixed up documentation
; 09/13/96 bill   Remove class definition for ellipsized-text-dialog-item.
;                 It's part of MCL now.
; -------------   4.0b1
; -------------   3.9
;  5/19/95 slh   Updated for MCL 3.0 & processes.
;  7/06/92 straz folded into Leibniz, uses ows' fred minibuffers
;  6/22/92 straz fixed cosmetics, support :STEP, task arglist
;  6/20/92 straz sped up by caching info, added barber poles
;  6/19/92 created by straz
;;<end of added text>


(in-package :ccl)

(eval-when (:compile-toplevel :execute)
  (require :quickdraw)
  (require :scrolling-windows))

; progress-indicator.lisp
; 
; Provides a window which allows you to track the progress of 
; various operations. Although there is exactly one global list of tasks,
; multiple windows are supported in case you want to specialize their 
; views.
;
; show-progress-indicator-window
; Shows a progress indicator window, creating a new one if necessary.
; Progress information is also displayed in the Fred minibuffer.

; If your code runs slowly, and you want to inform users as to its progress,
; wrap your code with this form:

; with-shown-progress (task name &key denominator help-spec supertask delay use-minibuffer)
;                     &body body
; Evals BODY showing progress in a task identified by a string NAME. 
; TASK is a variable name, which can be passed to nested SHOW-PROGRESS calls.
; DENOMINATOR defaults to nil, or if non-nil must be a nonzero number.
; HELP-SPEC specifies the string shown by ballon-help in the indicator window.
; SUPERTASK specifies the parent task, i.e. TASK is a subtask of SUPERTASK.
;  This defaults to the closest containing value of WITH-SHOWN-PROGRESS.
; DELAY specifies the number of seconds to wait before showing the dialog.
; USE-MINIBUFFER specifies whether to display progress notes in the top mini-buffer.

; Then, at each point where you want to update the info, insert this:

; show-progress task &key (numerator 0) (denominator 1) (note "") (step t)
;                         help-spec delay
; This updates the progress bar for TASK with the info provided.
; TASK may be a real task, such as the value bound by WITH-SHOWN-PROGRESS,
; or a string, in which case a task of that name is used.
;
; If DENOMINATOR is nil, a a barber-pole progress bar is indicated 
; (e.g. FinderÕs find command), 
; Else DENOMINATOR should be a nonzero number, and a fractional bar is used.
;
; If STEP is non-nil (the default), this means to advance the progress.
; For a barberpole, any non-nil value advances the pole.
; For a fraction, a number should be provided, and NUMERATOR is increased
; by this amount. A non-numerical value for STEP is taken to be 1.
;
; For fractional bars, if NUMERATOR is provided, STEP is ignored
; and the fraction NUMERATOR/DENOMINATOR is displayed instead.
;
; HELP-SPEC specifies the string shown by ballon-help in the indicator window.

; Other useful functions are:

; format-progress task format-string &rest format-args
; Calls SHOW-PROGRESS with a formatted string as the :note argument.
;
; do-sequence-progress (var sequence) 
;                      (task name &key note-fn &rest rest)
;                      &body body
; A combination of DOLIST and WITH-SHOWN-PROGRESS, except this works on non-list
; sequences too.
; TASK and NAME are the same as WITH-SHOWN-PROGRESS. Any other keys provided
; in REST are passed along to SHOW-PROGRESS.
; NOTE-FN is applied to each item in SEQUENCE to compute the note.
; to be passed to SHOW-PROGRESS before the body is executed with VAR bound
; to that item.

;
; See end of this file for example code.
;
;----------------
;
; Future work:
; Make scroll bars work nicely.
; Provide convenient versions of MAPCAR, LOOP, DOLIST, etc.
; Support real multitasking.
; Support audio cues (grumbling or clicking) via speaker or MIDI.


;------------
; Global vars

(defvar *tasks* nil
  "The list of tasks to show in a progress indicator window.")

(defvar *taskmaster* nil
  "The parent task of the currently invoked task.")

(defparameter *progress-window-is-open?* nil
  "Indicates that the a graphical progress indicator window is open.")

(defvar *auto-pop-progress-windows* t)
(defvar *pending-progress-dialogs* (list nil))
(defvar *pending-task-updates* (list nil))

; Cosmetic preferences

(defvar *progress-indicator-default-view-position* '(:top 380))
(defvar *progress-indicator-view-position*
  *progress-indicator-default-view-position*)

(defparameter *progress-indicator-window-columns*
  '((:name 130) (:bar 120) (:note 500))
  "Specification of ordering and width (pixels) of columns in window.")

(defvar *fraction-bar-fore-color* *blue-color*)
(defvar *fraction-bar-back-color* *white-color*)

(defparameter *progress-indicator-default-font* '("geneva" 9)
  "Default font for the progress indicator window.")
(defparameter *barber-fore-color* *fraction-bar-fore-color*
  "Color to draw foreground of barber pole.")
(defparameter *barber-back-color* *fraction-bar-back-color*
  "Color to draw background of barber pole.")
   

;------------
; A task tracks some process' progress.

(defclass task ()
  ((name :initform "Untitled" :accessor name :initarg :name)
   (note :initform "doin' nuthin'" :accessor note :initarg :note)
   (supertask :initform nil :accessor supertask :initarg :supertask)
   (subtasks :initform nil :accessor subtasks :initarg :subtasks)
   (numerator :initform 0 :accessor task-numerator :initarg :numerator)
   (denominator :initform 1 :accessor task-denominator :initarg :denominator)
   (step :initform nil :accessor task-step)
   (prev-fract :initform 0 :accessor prev-fract)
   (rows :initform nil :accessor rows)
   (help-spec :initform nil :accessor help-spec :initarg :help-spec)
   (delay :initform nil :reader task-delay :initarg :delay)
   (process :initform nil :reader process :initarg :process)
   (use-minibuffer :initform nil :reader use-minibuffer :initarg :use-minibuffer)))

(defmethod initialize-instance :after ((self task) &rest ignore)
  (declare (ignore ignore))
  (add-task self)
  (when (supertask self)
    (push self (subtasks (supertask self)))))

(defmethod print-object ((self task) stream)
  (print-unreadable-object (self stream :identity t)
    (format stream "TASK ~s" (name self))))

(defmethod task-fraction ((task task))
  "If current status of TASK is a valid fraction,
    returns 2 values: the fraction, and a boolean
    which is T if the value has increased.
   Else, returns NIL."
  (let* ((n (task-numerator task))
         (d (task-denominator task))
         (prev (prev-fract task))
         (f (and d 
                 (min 1 (max 0 (/ n d))))))
    (if d
      (values f (> f prev))
      nil)))


;------------
; Tasks are displayed in ROWS within a PROGRESS-INDICATOR-WINDOW.
;

(defclass progress-indicator-scroller (ccl::scroller)
  ())

(defmethod initialize-instance :after ((self progress-indicator-scroller) &key &allow-other-keys)
  (let ((window (view-container self)))
    (setf (ccl::scroll-bar-scroll-size (ccl::h-scroller self)) 5)
    (setf (ccl::scroll-bar-scroll-size (ccl::v-scroller self))
          (+ (row-height window) (v-spacing window)))))

(defmethod ccl::field-size ((view progress-indicator-scroller))
  (let ((window (view-container view)))
    (if window
      (make-point 420
                  (* (length (rows window))
                     (+ (row-height window) (v-spacing window))))
      (call-next-method))))

(defclass progress-indicator-window (ccl::scrolling-window)
  ((rows :initform nil :accessor rows)
   (h-spacing :initform 4 :accessor h-spacing
              :documentation "Space between columns, in pixels.")
   (v-spacing :initform 4 :accessor v-spacing
              :documentation "Space between rows, in pixels.")
   (row-height :initform 12 :accessor row-height
               :documentation "Height of rows, in pixels.")
   (columns :initform *progress-indicator-window-columns*
            :documentation "Column ordering: type and width in pixels"
            :accessor columns)
   (first-row :initform (make-point 3 5) :accessor first-row
              :documentation "Upper-left corner of first row within window.")
   (ccl::scroller :accessor scroller))
  (:default-initargs :color-p t
    :scroller-class 'progress-indicator-scroller
    :view-font *progress-indicator-default-font*
    :window-title "Progress Indicator"
    :help-spec (format nil "This window indicates the progress of various tasks, as indicated ~
                            by the WITH-SHOWN-PROGRESS and SHOW-PROGRESS lisp functions.")))

(defmethod initialize-instance :after ((self progress-indicator-window) &rest ignore)
  (declare (ignore ignore))
  (setf (scroller self)
        (find-if #'(lambda (x) (typep x 'ccl::scroller)) (view-subviews self))) 
  (setf (view-get (scroller self) :help-spec)
        (help-spec self))
  (dolist (task *tasks*)
    (add-row task self))
  (setf *progress-window-is-open?* t))

(defmethod window-close :around ((self progress-indicator-window))
  "Keep track of any windows that might be open."
  (call-next-method)
  (if (windows :class 'progress-indicator-window)
    (setf *progress-window-is-open?* t)
    (setf *progress-window-is-open?* nil)))

(defclass progress-indicator-row (simple-view)
  ((window :accessor window :initarg :window)
   (task :accessor task :initarg :task)))


;------------
; Task management - global

(defun find-task (task)
  "NAME-OR-TASK may be a string, symbol, or a task object."
  (find task *tasks*))

(defmethod add-task ((task task))
  ;(cassert (null (find-task task)) "Task ~a already member of ~s" task '*tasks*)
  (pushnew task *tasks*)
  (dolist (window (windows :class 'progress-indicator-window))
    (add-row task window)))

(defmethod delete-task ((task task))
  ;(cassert (find-task task) "Task ~a not found in ~s" task '*tasks*)
  (let ((dialog (find-progress-dialog task))
        (supertask (supertask task)))
    (setq *tasks* (delete task *tasks*))
    (setf (supertask task) nil)
    (dolist (window (windows :class 'progress-indicator-window))
      (delete-row task window))
    (when dialog
      (if supertask
        (update-progress-dialog dialog t)
        (window-close dialog)))))

(defmethod (setf supertask) :around (new (task task))
  (let ((old (supertask task)))
    (call-next-method)
    (setf (subtasks task) (remove old (subtasks task)))
    (etypecase new
      (task (pushnew task (subtasks new)))
      (null nil))))


;------------
; Task management - adding rows to windows

(defmethod add-row ((task task) (window progress-indicator-window))
  (let ((row (make-instance 'progress-indicator-row 
               :task task
               :view-container (scroller window)
               :window window)))
    (setf (rows window) (append (rows window) (list row)))
    (pushnew row (rows task))
    (initialize-help-spec row)
    (update-geometry window)))

(defmethod delete-row ((task task) (window progress-indicator-window))
  (let ((row (find task (rows window) :key 'task)))
    (when row
      (set-view-container row nil)
      (setf (window row) nil)
      (setf (rows window) (remove row (rows window)))
      (setf (rows task) (remove row (rows task)))
      (update-geometry window))))

(defmethod window-close :after ((self progress-indicator-window))
  (dolist (row (rows self))
    (let ((task (task row)))
      (setf (rows task)
            (remove row (rows task))))))

(defmethod update-geometry ((window progress-indicator-window))
  (invalidate-view (scroller window) t)
  (let* ((pos (first-row window))
         (x (point-h pos))
         (y (point-v pos))
         (height (row-height window))
         (width (+ (reduce '+ (mapcar 'cadr (columns window)))
                   (* (h-spacing window) (length (columns window))))))
    (dolist (row (rows window))
      (set-view-size row width height)
      (set-view-position row x y)
      (incf y (+ height (v-spacing window)))))
  (ccl::update-scroll-bar-limits (scroller window))
  (event-dispatch))

(defmethod display-size ((self progress-indicator-window))
  "Returns a point indicating the total area of the window."
  (let* ((columns (columns self))
         (height (* (v-spacing self) (row-height self)))
         (width (+ (reduce '+ (mapcar 'cadr columns))
                   (* (h-spacing self) (length columns )))))
    (add-points (first-row self) (make-point width height))))

; Not used anymore.
(defmethod sort-rows ((self progress-indicator-window))
  "Sorts the rows displayed in a window alphabetically."
  (setf (rows self)
        (sort (rows self) #'(lambda (r1 r2)
                              (string< (name (task r1)) (name (task r2)))))))


;----------------
; Drawing

(defmethod view-draw-contents ((self progress-indicator-row))
  (let* ((window (window self))
         (task (task self))
         (h-spacing (h-spacing window))
         (x (point-h (view-position self)))
         (y (point-v (view-position self))))
    (without-interrupts
     (dolist (column (columns window))
       (let ((type (first column))
             (height (row-height window))
             (width (second column)))
         (ecase type
           (:name (row-draw-string (make-point x y) (make-point width height)
                                   (name task) nil))
           (:note (row-draw-string (make-point x y) (make-point width height)
                                   (note task) t))
           (:bar (row-draw-bar (make-point x y) (make-point width height)
                               self task)))
         (incf x (+ h-spacing width)))))))

(defun row-draw-string (pos size string erase?)
  (rlet ((r :rect :topleft pos
            :bottomright (add-points pos size)))
    (when erase? (#_eraserect r))
    (with-clip-rect-intersect r
      #+ignore
      (with-pstrs ((str string))
        (#_moveto (point-h pos) (+ 9 (point-v pos)))
        (#_drawstring str))
      #-ignore
      (progn
        (#_moveto (point-h pos) (+ 9 (point-v pos)))
        (grafport-write-string string 0 (length string)))
      )))

(defun row-draw-bar (pos size row task)
  (if (null (task-denominator task))
    (row-draw-barber-bar pos size row task)
    (row-draw-fraction-bar pos size row task)))

(defun row-draw-fraction-bar (pos size row task)
  "Draws a thermometer-style fractional bar.
   POS and SIZE are points, indicating the bar's location."
  (declare (ignore row))
  (let ((step (task-step task)))
    (when step                 ; Increment numerator
      (incf (task-numerator task) 
            (if (numberp step) step 1))
      (setf (task-step task) nil)))
  (let ((fract (task-fraction task)))
    ; To cut flicker, don't erase unless necessary
    ; (commented out since it also keeps the background color from drawing
    ; when the window is initially uncovered)
    (rlet ((r :rect :topleft pos :bottomright (add-points pos size)))
      (draw-fraction-bar r fract))  
    (setf (prev-fract task) fract)))


;;;
;;; Fraction Bar
;;;

(defparameter *fraction-bar-fore-color* #x444444
  "Color to draw fractional bar.")
(defparameter *fraction-bar-back-color* #xCCCCFF
  "Color to draw fractional bar.")

(defun draw-fraction-bar (rect fraction &aux
                                  (foreground-color *fraction-bar-fore-color*)
                                  (background-color *fraction-bar-back-color*))
  (#_FrameRect rect)
  (with-fore-color foreground-color
    (with-back-color background-color
      (rlet ((r :rect
                :topLeft (add-points (rref rect rect.topLeft) #@(1 1))
                :bottomRight (subtract-points (rref rect rect.bottomRight) #@(1 1))))
        (let* ((left (rref r rect.left))
               (right (rref r rect.right))
               (middle (+ left (round (* (- right left) fraction)))))
          (setf (rref r rect.right) middle)
          (#_PaintRect r)
          (setf (rref r rect.left) middle
                (rref r rect.right) right)
        (#_EraseRect r))))))

(defun row-draw-barber-bar (pos size row task)
  "Draws barber-pole style bar. If task's STEP slot is T,
   advance phase and move the stripes to indicate progress."
  (let ((height (point-v size))
        (thickness 12)                 ; Stripe thickness
        (phase (prev-fract task)))     ; Phase = (mod N 4)
    (when (task-step task)                  ; Increment phase
      (setf (task-step task) nil)
      (setf phase (mod (1- phase) 4))
      (setf (prev-fract task) phase))   ; Save phase in PREV-FRACT slot
    (let ((x (- (point-h pos)
                (* phase (round thickness 2))))
          (y (+ (point-v pos) height))
          (line-seg (make-point (- height) (- height)))
          (right (+ (point-h pos) (point-h size))))
      (rlet ((r :rect :topleft pos :bottomright (add-points pos size)))
        (#_framerect r)
        (#_insetrect r 1 1)
        (with-clip-rect-intersect r
          (with-fore-color *barber-fore-color*
            (with-back-color *barber-back-color*
              (#_eraserect r)
              (ccl:set-pen-size row thickness 1)
              (do ()                    ; Draw the stripes on the bar
                  ((> x (+ thickness right)))   ; from left to right
                (#_moveto :long (make-point x y))
                (#_line :long line-seg)
                (incf x (* 2 thickness)))
              (ccl:pen-normal row))))))))


;--------------
; Help-spec support, which should've been included normally.

(defmethod help-spec ((row progress-indicator-row))
  (view-get row :help-spec))

(defmethod (setf help-spec) (new (row progress-indicator-row))
  (setf (view-get row :help-spec) new))

(defmethod help-spec ((window progress-indicator-window))
  (view-get window :help-spec))

(defmethod (setf help-spec) (new (window progress-indicator-window))
  (setf (view-get window :help-spec) new))

(defmethod initialize-help-spec ((row progress-indicator-row))
  (let ((task (task row)))
    (cond ((help-spec task)
           (setf (help-spec row) (help-spec task)))
          ((null (task-denominator task))
           (setf (help-spec row)
                 (format nil "This indicates the progress of a task named ~s." 
                         (name task))))
          (t
           (setf (help-spec row)
                 (format nil "This indicates the progress of a task named ~s. ~
                              The size of the dark bar indicates the ~
                              portion of the task completed." (name task)))))))

(defun update-progress (task &key (numerator 0 n?) (denominator 1 d?)
                                     (note "" note?) (step (not n?)) help-spec
                                     &allow-other-keys)
  "This updates the progress bar for TASK with the info provided.

   If STEP is non-nil (the default), this means to advance the progress.
   For a barberpole, any non-nil value advances the pole.
   For a fraction, a number should be provided, and NUMERATOR is increased
   by this amount. A non-numerical value for STEP is taken to be 1.

   For fractional bars, if NUMERATOR is provided, STEP is ignored
   and the fraction NUMERATOR/DENOMINATOR is displayed instead."
  (declare (ignore numerator denominator))
  
  (unless (and (numberp step) (zerop step) (numberp (task-denominator task))
               (not (or note? n? d?)))        ; Don't refresh fract-bars on STEP 0
    (dolist (row (rows task))
      (view-focus-and-draw-contents row)))
  (when (and (use-minibuffer task) note?)
    (print-progress "~A" note))
  (when help-spec
    (setf (help-spec task) help-spec)
    (dolist (row (rows task))
      (initialize-help-spec row)))
  (let ((dialog (find-progress-dialog task)))
    (when dialog
      (update-progress-dialog dialog note?))))


;--------------
; Interface functions

(defun funcall-with-shown-progress (fn name &key denominator help-spec supertask delay process use-minibuffer)
  "Calls FN showing progress in a task identified by a string NAME. 
   DENOMINATOR defaults to nil, or if non-nil must be a nonzero number.
   HELP-SPEC specifies the string shown by ballon-help in the indicator window.
   SUPERTASK specifies the parent task, i.e. TASK is a subtask of SUPERTASK.
    This defaults to the closest containing value of WITH-SHOWN-PROGRESS.
   DELAY specifies the number of seconds to wait before showing the dialog.
   PROCESS is the process to abort via the Stop button, defaults to ccl:*current-process*.
   USE-MINIBUFFER specifies whether to display progress notes in the top mini-buffer."
  (let ((task nil)
        (s (or supertask *taskmaster*)))
    (unwind-protect 
      (progn
        (when s                     ; Advance parents if they're barberpoles
          (show-progress s :step 0))
        #+processes
        (unless process
          (setq process *current-process*))
        (setf task (make-progress name
                                  :numerator 0 
                                  :denominator denominator
                                  :supertask s
                                  :help-spec help-spec
                                  :delay delay
                                  :process process
                                  :use-minibuffer use-minibuffer))
        (let ((*taskmaster* task))
          (funcall fn task)))
      (when task
        (end-progress task use-minibuffer)))))

(defmacro with-shown-progress ((task name &rest rest
                                     &key denominator help-spec supertask delay
                                     process use-minibuffer) 
                               &body body)
  "Evals BODY showing progress in a task identified by a string NAME. 
   TASK is a variable name, which can be passed to nested SHOW-PROGRESS calls.
   DENOMINATOR defaults to nil, or if non-nil must be a nonzero number.
   HELP-SPEC specifies the string shown by ballon-help in the indicator window.
   SUPERTASK specifies the parent task, i.e. TASK is a subtask of SUPERTASK.
    This defaults to the closest containing value of WITH-SHOWN-PROGRESS.
   DELAY specifies the number of seconds to wait before showing the dialog.
   PROCESS is the process to abort via the Stop button, defaults to ccl:*current-process*.
   USE-MINIBUFFER specifies whether to display progress notes in the top mini-buffer."
  (declare (ignore denominator help-spec supertask delay process use-minibuffer))
  (let ((fn (gensym)))
    `(flet ((,fn (,task)
              (declare (ccl::ignore-if-unused ,task))
              ,@body))
       (declare (dynamic-extent ,fn #',fn))
       (funcall-with-shown-progress #',fn ,name ,@rest))))

(defun make-progress (name &rest rest &key (numerator 0) (denominator 1)
                           (note "") help-spec supertask delay process use-minibuffer)
  "This creates a new task named NAME, and updates it with the info provided.
 
   If DENOMINATOR is nil, a a barber-pole progress bar is indicated 
   (e.g. FinderÕs find command), 
   Else DENOMINATOR should be a nonzero number, and a fractional bar is used.

   HELP-SPEC specifies the string shown by ballon-help in the indicator window.
   DELAY specifies the number of seconds to wait before showing the dialog.
   PROCESS is the process to abort via the Stop button, defaults to ccl:*current-process*.
   SUPERTASK specifies the parent task, i.e. TASK is a subtask of SUPERTASK."
  
  (declare (dynamic-extent rest) (ignore help-spec))
  (let ((task
         (make-instance 'task :numerator numerator :denominator denominator
                        :name name :note note :supertask supertask :delay delay
                        :process process :use-minibuffer use-minibuffer)))
    (cond ((supertask task))
          ((null *auto-pop-progress-windows*))
          ((numberp delay)
           (when (null (supertask task))
             (schedule-progress-update *pending-progress-dialogs* task delay)))
          ((null delay)
           (make-instance 'progress-indicator-dialog :task task)))
    (apply #'update-progress task rest)
    task))                              ; Returns the task

(defun show-progress (task &rest rest &key (numerator 0 n?) (denominator 1 d?)
                              (note "" note?) (step (not n?)) help-spec delay)
  "This updates the progress bar for TASK with the info provided.

   If STEP is non-nil (the default), this means to advance the progress.
   For a barberpole, any non-nil value advances the pole.
   For a fraction, a number should be provided, and NUMERATOR is increased
   by this amount. A non-numerical value for STEP is taken to be 1.

   For fractional bars, if NUMERATOR is provided, STEP is ignored
   and the fraction NUMERATOR/DENOMINATOR is displayed instead."

  (declare (dynamic-extent rest))
  (if (or (not delay) n? d? note? help-spec)
    (progn
      (when note? (setf (note task) note))
      (when n? (setf (task-numerator task) numerator))
      (when d? (setf (task-denominator task) denominator))
      (when step (setf (task-step task) step))
      (apply #'update-progress task rest))
    (schedule-progress-update *pending-task-updates* task delay)))

(defun step-current-progress (&key (delay 1))
  (when *taskmaster*
    (show-progress *taskmaster* :delay delay)))

(defun end-progress (task &optional use-minibuffer)
  "Removes TASK, which may be either a task or a string naming one."
  (delete-task task)
  (when use-minibuffer
    (print-progress "Done ~a" (name task))))

;------------
(defun print-progress (format-string &rest format-args)
  (let ((window (front-window :class 'fred-window)))
    (when window
      (set-mini-buffer window "~&")
      (apply #'set-mini-buffer window format-string format-args))))

;------------
; Other useful functions

(defun format-progress (task format-string &rest format-args)
  "Calls SHOW-PROGRESS with a formatted string as the :note argument"
  (show-progress task :note (apply 'format nil format-string format-args)))


(defmacro do-sequence-progress ((var sequence)
                                    (task name &rest rest)
                                    &body body)
  "A combination of DOLIST and WITH-SHOWN-PROGRESS, except this works on non-list
   sequences too.
   TASK and NAME are the same as WITH-SHOWN-PROGRESS.
   NOTE-FN is applied to each item in SEQUENCE to compute the note
   to be passed to SHOW-PROGRESS before the body is executed with VAR bound
   to that item."
  (let ((_scanner (gensym)))
    `(flet ((,_scanner (,var ,task)
              (declare (ignore-if-unused ,task))
              ,@body))
       (declare (dynamic-extent ,_scanner))
       (map-with-shown-progress #',_scanner ,sequence ,name ,@rest))))

; This is called by the DO-SEQUENCE-PROGRESS macro.
;
(defun map-with-shown-progress (fn sequence name &rest rest &key note-fn &allow-other-keys)
  (declare (dynamic-extent rest))
  (remf rest :note-fn)
  (apply #'funcall-with-shown-progress
         #'(lambda (task)
             (flet ((scanner (var)
                      (apply #'show-progress task
                             :step t
                             (when note-fn (list :note (funcall note-fn var))))
                      (funcall fn var task)))
               (declare (dynamic-extent scanner))
               (map nil #'scanner sequence)))
         name
         :denominator (length sequence)
         rest))


;-----------
;

(defun show-progress-indicator-window ()
  "Shows a progress indicator window, creating a new one if necessary."
  (let* ((class 'progress-indicator-window)
         (window (front-window :class class)))
    (if window
      (window-select window)
      (make-instance class))))


;----------------
; Popup progress indicators

(defun schedule-progress-update (queue task delay)
  (unless (find task (cdr queue) :key #'car)
    (push (cons task (+ (get-internal-real-time) (* delay internal-time-units-per-second)))
          (cdr queue))))

(defun funcall-scheduled-progress-updates (queue fn)
  (when (cdr queue)
    (let ((now (get-internal-real-time)))
      (dolist (task.time (cdr queue))
        (destructuring-bind (task . time) task.time
          (when (>= now time)
            (when (memq task *tasks*)
              (funcall fn task))
            (setf (cdr queue) (delete task.time (cdr queue)))))))))

(defun popup-pending-progress-dialogs ()
  (labels ((make-task (task)
             (make-instance 'progress-indicator-dialog :task task))
           (step-task (task)
             (let ((dialog (find-progress-dialog task)))
               (when dialog
                 (update-progress-dialog dialog)))))
    (declare (dynamic-extent #'make-task #'step-task))
    (funcall-scheduled-progress-updates *pending-progress-dialogs* #'make-task)
    (funcall-scheduled-progress-updates *pending-task-updates* #'step-task)))

(defclass progress-indicator-dialog (window)
  ((task :reader progress-task :initarg :task))
  (:default-initargs :color-p t
    :view-font '("Chicago" 12)
    :view-position *progress-indicator-view-position*
    :view-size #@(#.(+ 14 210 14 59) #.(+ 7 15 14 15 14 15 14 -7))
    :window-type #$kMovableModalDialogVariantCode
    :grow-icon-p nil))

; Defined in "ccl:lib;search-files.lisp"
#|
(defclass ellipsized-text-dialog-item (fred-dialog-item)())
|#

(defmethod initialize-instance ((window progress-indicator-dialog) &rest rest
                                &key task (window-title (name task))
                                &allow-other-keys)
  (declare (dynamic-extent rest))
  (apply #'call-next-method window :window-title window-title rest)
  (add-subviews
   window
   (make-dialog-item 'ellipsized-text-dialog-item #@(8 7)
                     #@(#.(- 298 14 14) 15) "" nil
                     :view-nick-name 'top-line)
   (make-dialog-item 'ellipsized-text-dialog-item #@(8 #.(+ 7 15 14))
                     #@(#.(- 298 14 14) 15) "" nil
                     :view-nick-name 'center-line)
   (make-instance 'progress-thermometer
     :view-position #@(10 #.(+ 7 15 14 15 14))
     :view-size #@(210 12)
     :view-nick-name 'thermometer)
   (make-dialog-item 'button-dialog-item #@(#.(+ 10 210 14 -1) #.(+ 7 15 14 15 14 -4))
                     #@(59 20) "Stop"
                     #'(lambda (item)
                         (declare (ignore item))
                         #+processes (process-abort (process task))
                         #-processes (abort))))
  (update-progress-dialog window t)
  (window-ensure-on-screen window *progress-indicator-default-view-position*
                           (view-size window)))

(defmethod set-view-position :after ((window progress-indicator-dialog) h &optional v)
  (declare (ignore h v))
  (setf *progress-indicator-view-position* (view-position window)))

(defclass progress-thermometer (view)
  ((numerator :initform 0 :accessor task-numerator)
   (denominator :initform 1 :accessor task-denominator)
   (step :initform nil :accessor task-step)
   (prev-fract :initform 0 :accessor prev-fract)))

(defmethod task-fraction ((task progress-thermometer))
  "If current status of TASK is a valid fraction,
    returns 2 values: the fraction, and a boolean
    which is T if the value has increased.
   Else, returns NIL."
  (let* ((n (task-numerator task))
         (d (task-denominator task)))
    (if d
      (values (/ n d) (task-step task))
      nil)))

(defmethod view-draw-contents ((view progress-thermometer))
  (let ((task view)
        (pos #@(0 0))
        (size (view-size view))
        (row view))
    (if (null (task-denominator task))
      (row-draw-barber-bar pos size row task)
      (row-draw-fraction-bar pos size row task))))

(defmethod find-progress-dialog ((task task))
  (let ((supertask (supertask task)))
    (if supertask
      (find-progress-dialog supertask)
      (progn
        (map-windows #'(lambda (window)
                         (if (eq (progress-task window) task)
                           (return-from find-progress-dialog window)))
                     :class 'progress-indicator-dialog)
        nil))))

(defun update-progress-dialog (window &optional (text-changed t) &aux (task (progress-task window)))
  (when text-changed
    (let* ((note (note task))
           (string
            (cond ((string/=  note "")
                   note)
                  ((subtasks task)
                   (name (first (subtasks task))))
                  (t (name task))))
           (length (length string)))
      (set-dialog-item-text
       (view-named 'top-line window)
       (if (and (> length 0) (char= (char string (1- length)) #\É))
         string
         (concatenate 'string string "É")))))
  (labels ((last-task (task ratio denominator &aux (subtask (first (subtasks task))))
             (when denominator
               (let ((add (compute-ratio task)))
                 (when add
                   (incf ratio (/ add denominator)))))
             (if subtask
               (let ((subdenominator (task-denominator subtask)))
                 (last-task subtask ratio
                            (and denominator subdenominator
                                 (* denominator subdenominator))))
               (progn
                 (set-dialog-item-text (view-named 'center-line window)
                                       (if (supertask task)
                                         (note task)
                                         ""))
                 (let ((view (view-named 'thermometer window)))
                   (setf (task-numerator view) ratio
                         (task-denominator view) (and ratio 1)
                         (task-step view) (not ratio))
                   (incf (prev-fract task))
                   (invalidate-view view)))))
           (compute-ratio (task &aux (s (task-step task)))
             (when s
               (incf (task-numerator task) (if (numberp s) s 1))
               (setf (task-step task) nil))
             (let ((n (task-numerator task))
                   (d (task-denominator task)))
               (when d (/ n (1+ d))))))
    (if (task-denominator task)
      (last-task task 0 1)
      (last-task task nil nil)))
  (when ccl::*processing-events*
    (window-update-event-handler window)))

(pushnew 'popup-pending-progress-dialogs *eventhook*)


#|
; test code

(defun lookit ()
  (make-instance 'progress-indicator-window))

(defun test (&key delay use-mb)
  ;(show-progress "Doing backups" :denominator nil :note "This could take a while")
  (with-shown-progress (my-compile-task "My compile" :denominator 3
                                        :delay delay :use-minibuffer use-mb)
    (dotimes (j 3)
      (show-progress my-compile-task :step t :help-spec  "Start yer engines!"
                     :note (elt '("on your marks" "get set" "go!") j))
      (with-shown-progress (another-task "Another" :denominator 100 :use-minibuffer use-mb)
        (dotimes (i 101)
          (when (zerop (mod i 17)) 
            ;(show-progress "Doing backups" :step 1)
            )
          (format-progress another-task "~a% ~r" i i))))))

(defun test1 ()
  ;(show-progress "Doing backups" :denominator nil :note "This could take a while")
  (with-shown-progress (my-compile-task "My compile" :denominator nil)
    (dotimes (j 3)
      (with-shown-progress (another-task "Another" :denominator 100)
        (dotimes (i 101)
          (when (zerop (mod i 17)) 
            ;(show-progress "Doing backups" :step 1)
            )
          (format-progress another-task "~a% ~r" i i))))))


(defun test2 ()
  (do-sequence-progress (day #("Mon" "Tues" "Wed" "Thurs" "Fri" "Sat" "Sun"))
                        (task "Dayyyy-O!" :note-fn 
                              #'(lambda (x) (format nil "All day ~a" x)))
    (format t "~a.. " day)
    (force-output)
    (sleep .3)))

|#
#|
	Change History (most recent last):
	1	7/06/92	straz	Graphically indicates progress of activities
	2	7/06/92	straz	Sanitize for use with Leibniz
	3	7/06/92	straz	cosmetic fix to end-progress: use name of task, not task, when printing
~~	4	8/03/92	ows	fix for ~; use Finder colors
	5	8/14/92	ows	fix initial display; disable the scroll bars
	6	10/29/92	Moon	1.5d260
	6	10/29/92	Moon	1.5d260
	7	11/18/92	ows	makeover
	8	12/21/92	ows	move window lower; remember position; add STEP-CURRENT-PROGRESS
				compress and ellipsize text so it fits
	9	1/18/93	ows	call draw-fraction-bar; move *fraction-bar-Å-color* to views
|# ;(do not edit past this line!!)
