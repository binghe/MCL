;;;-*-Mode: LISP; Package: INSPECTOR -*-


;;	Change History (most recent first):
;;  2 4/12/95  akh  use 3d-buttons
;;  2 3/2/95   akh  use application-file-creator
;;  (do not edit before this line!!)

(in-package "INSPECTOR")

; backtrace-lds.lisp
; low-level support for stack-backtrace dialog (Lisp Development System)
; Copyright 1987-1988, Coral Software Corp.
; Copyright 1989-1994, Apple Computer, Inc.
; Copyright 1995-1999, Digitool, Inc.

;; Modification History
;; window-save-as passes on chosen-format from choose-new-file-dialog
;; scrolling-fred-view - fred-item-class just fred-item
;; ------ 5.2b5
;; window-save-as accepts and ignores external-format
;------- 5.1 final
; 03/03/99 akh some darn thing re trying to quit when an empty step window exists
; use 3d-buttons
; 04/17/93 alice lost the inspect button in merge
; 11/22/92 alice use scrolling-fred-view
; 03/30/91 alice window-close - throw iff closing the current step window
; 05/08/92 bill  step-inspector
;--------------  2.0
; 10/15/91 bill  window-font -> view-font
; 10/06/91 alice nuke *trace-step-window* on close
; 09/20/91 alice fix horizontal scrolling
;-------------- 2.0b3
; 03/28/91 alice - lets have a horizontal scroll bar, fix the off-by-one bug
;----------- 2.0b1
; 01/08/91 remove in:: (was redundant anyway)
; 11/05/90 fix call to buffer-line-start
; 10/29/90 get this back in ccl package by exporting what we need from
; inspector package (command-pane add-command-pane-items inspector-view
;    make-and-size-dialog-item more??)

(defclass step-window (window)
  ((selected-pane :initform nil :accessor selected-pane)
   (user-title :accessor user-title))
  (:default-initargs :window-title nil))

;; has a command pane and a view containing a fred-dialog-item and a scroll bar
(defclass step-pane (view)
  ((grow-box-p :initform nil :initarg :grow-box-p :reader grow-box-p)
   (step-command-pane :initform nil :initarg :command-pane :accessor step-command-pane))
  (:default-initargs :view-size #@(500  200)
                     :view-position #@(0 0)))

(defclass step-command-pane (command-pane)
  ())


(defmethod add-command-pane-items ((pane step-command-pane) &optional foo)
  (declare (ignore foo))
  (let* ((font '("geneva" 10 :bold))
         ;(width (+ 8 (string-width "Commands" font)))
         ;(height (+ 5 (font-line-height  font)))
         ;(menu-size (make-point width height))
         (step-over-button (make-and-size-dialog-item
                            '3d-button ;'button-dialog-item
                           :view-nick-name 'step-over-button
                           :dialog-item-text "Step over"
                           :frame-p t
                           :view-font font
                           :help-spec 15135
                           :dialog-item-action
                           #'(lambda (item)
                               (declare (ignore item))
                               (push :step-over ccl::*step-commands*))))
         (button-size (view-size step-over-button)))
    ;(set-view-size step-over-button button-size)
    (add-subviews pane
                  (make-instance
                    '3d-button ;'button-dialog-item
                    :frame-p t
                    :default-button t
                    :view-size button-size
                    :view-nick-name 'step-button
                    :dialog-item-text "Step"
                    :view-font font
                    :help-spec 15136
                    :dialog-item-action
                    #'(lambda (item)
                        (declare (ignore item))
                        (push :step ccl::*step-commands*)))
                  step-over-button
                  (make-instance
                    '3d-button ;'button-dialog-item
                    :frame-p t
                    :view-size button-size
                    :view-nick-name 'go-button
                    :dialog-item-text "Go"
                    :view-font font
                    :help-spec 15134
                    :dialog-item-action
                    #'(lambda (item)
                        (declare (ignore item))
                        (push :go ccl::*step-commands*)))                  
                  (make-instance
                    '3d-button ;'button-dialog-item
                    :frame-p t
                    :view-size button-size
                    :view-nick-name 'eval-button
                    :dialog-item-text "Eval"
                    :view-font font
                    :help-spec 15133
                    :dialog-item-action
                    #'(lambda (item)
                        (declare (ignore item))
                        (push :eval ccl::*step-commands*)))
                  (make-instance '3d-button ;'button-dialog-item
                    :view-size button-size
                    :frame-p t
                    :dialog-item-text "Inspect"
                    :view-font font
                    :help-spec 15132
                    :dialog-item-action
                    #'(lambda (item)
                        (declare (ignore item))
                        (push :inspect ccl::*step-commands*)))
                  (make-instance
                    '3d-button ;'button-dialog-item
                    :frame-p t
                    :view-size button-size
                    :view-nick-name 'quit-button
                    :dialog-item-text "Quit"
                    :view-font font
                    :help-spec 15131
                    :dialog-item-action
                    #'(lambda (item)
                        (declare (ignore item))
                        (push :quit ccl::*step-commands*)))
                  )))

(defmethod initialize-instance ((pane step-pane) ; &rest initargs
                                &key #|pane-splitter|# &allow-other-keys)
  ;(declare (dynamic-extent initargs))
  (call-next-method)
  (let* ((size (view-size pane))
         (fred (make-instance 'ccl::scrolling-fred-view
                 :view-size (add-points size #@(2 1)) ; huh
                 :view-position #@(-1 -1)
                 :draw-scroller-outline nil
                 :fred-item-class 'fred-item
                 :view-nick-name 'fred-dialog-item
                 :view-container pane
                 :help-spec 15137))
         (buffer (fred-buffer fred)))
    (multiple-value-bind (ff ms) (ccl::buffer-font-codes buffer) ; gets codes of cfont
      (multiple-value-bind (ff ms) (font-codes '(:bold) ff ms)
        (ccl::add-buffer-font buffer ff ms)))))
           
    

(defmethod initialize-instance ((w step-window) &rest initargs &key
                                (window-show t) 
                                (view-font *fred-default-font-spec*)
                                window-title)
  (declare (dynamic-extent initargs))
  (apply #'call-next-method w 
         :window-show nil
         :view-font view-font
         :window-title (or window-title "")
         initargs)
  (setf (user-title w) window-title)
  (let* ((command-pane (make-instance 'step-command-pane
                                      :view-container w
                                      :view-nick-name 'command-pane))
         (size (view-size w))
         (width (point-h size))
         (height (point-v size))
         (pane-top (point-v (view-size command-pane))))
    (adjust-subview-positions command-pane)
    (setf (selected-pane w)
          (make-instance 'step-pane
                         :command-pane command-pane
                         :grow-box-p t
                         :view-container w
                         :view-nick-name 'step-pane
                         :view-position (make-point 0 pane-top)
                         :view-size (make-point width 
                                                (- height pane-top -1))))
    ; so we need our own method for install-commands cause bills needs an inspector
    ;(in::install-commands command-pane)
    ;(in::set-initial-stuff w)
    ;(update command-pane w)
    )
  ;(set-initial-scroll (inspector w))
  (when window-show
    (window-show w))
  w)



(defmethod fred-dialog-item ((pane step-pane))
  (view-named 'fred-dialog-item pane))

(defmethod fred-dialog-item ((w step-window))
  (let ((fred-di (fred-dialog-item (view-named 'step-pane w))))
    (if fred-di
      (ccl::fred-item fred-di))))

(defmethod step-pane ((w step-window))
  (view-named 'step-pane w))


(defmethod step-command-pane ((w step-window))
  (view-named 'command-pane w))

(defmethod inspector-view ((pane step-command-pane))
  (declare (ignore pane))
  nil) ; we dont have one

(defmethod inspector ((pane step-pane))
  (declare (ignore pane))
  nil)

(defmethod inspector-view ((thing step-window))
  (declare (ignore thing))
  nil) ; nor do we



(defmethod window-size-parts ((w step-window))
  (let* ((size (view-size w))
         (width (point-h size))
         (height (point-v size))
         (command-pane (or (step-command-pane w)
                           (return-from window-size-parts nil)))
         (v (point-v (view-size command-pane)))
         (bottom (1+ height))
         (step-pane (car (subviews w 'step-pane))))
    (set-view-size command-pane width v)
    (set-view-position step-pane 0 v)
    (set-view-size step-pane width (- bottom v))
    (set-view-size (fred-dialog-item step-pane) (+ width 2) (+ (- bottom v) 1))
    size))



(defmethod window-show-cursor ((w step-window) &optional pos scrolling)
  (window-show-cursor (fred-dialog-item w) pos scrolling))





(defmethod window-close ((w step-window))
  (call-next-method)
  (when (eq w ccl::*trace-step-window*)(setq ccl::*trace-step-window* nil))
  (if (and ccl::*stepping*
           (eq (fred-dialog-item w) ccl::*step-output*))
    (throw ccl::*step-output* (values))))

; do we need this?
(defmethod ccl::window-needs-saving-p ((w step-window))
  (ignore-errors  ;; this only errored when there had been an error creating the step window
   (not (zerop (buffer-size (fred-buffer (fred-dialog-item w)))))))

(defmethod window-save-as ((w step-window) &optional external-format)
  (declare (ignore-if-unused external-format))
  (multiple-value-bind (name chosen-format)
                       (choose-new-file-dialog
                        :directory (format nil "Step-output.~a" 
                                           (pathname-type *.lisp-pathname*))
                        :prompt "Save File AsÉ")
    (setq name (buffer-write-file 
                (fred-buffer (fred-dialog-item w))
                name :if-exists :overwrite :external-format chosen-format))
    (ccl::set-mac-file-type-and-creator name :text (ccl::application-file-creator *application*))
    name))

(defmethod select-all ((w step-window))
  (select-all (fred-dialog-item w)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Inspector for stepper stack frames
;;;

(defclass step-inspector (inspector::inspector)
  ((name-value-pairs :initform nil :accessor name-value-pairs)))

(defmethod compute-line-count ((in step-inspector))
  (let* ((env (inspector-object in))
         (count (if (and env (not (ccl::bogus-thing-p env)) (uvectorp env))
                  (1+ (ccl::evalenv-vp env))
                  0))
         (pairs (name-value-pairs in)))
    (when (> count 0)
      (unless (>= (length pairs) count)
        (setq pairs
              (setf (name-value-pairs in)
                    (make-array count)))
        (dotimes (i count)
          (setf (aref pairs i) (cons nil nil))))
    (if (or (ccl::bogus-thing-p pairs)
            (not (uvectorp pairs)))
      (setq count 0)
      (let ((p 0)
            (name-p (1+ (ccl::evalenv-maxvp env)))
            (values (ccl::evalenv-values env)))
        (declare (fixnum p name-p))
        (dotimes (i count)
          (let ((sym (uvref values name-p)))
            (let ((pair (aref pairs i))
                  (val (uvref values p)))
              (cond ((and (consp val)(eq (car val) ccl::%closed-marker%))
                     (setq val (cdr val)))
                    ((eq ccl::%special-marker% val)
                     (set val (symbol-value sym))))
              (setf (car pair) sym
                    (cdr pair) val))
            (incf p)
            (incf name-p))))))
    count))

(defmethod line-n ((in step-inspector) n)
  (let* ((pair (aref (name-value-pairs in) n))
         (name (car pair))
         (value (cdr pair)))
    (values value name :colon)))

(defmethod (setf line-n) (value (in step-inspector) n)
  (let* ((pair (aref (name-value-pairs in) n))
         (name (car pair))
        (env (inspector-object in)))
    (ccl::step-eval-cheat `(setq ,name ',value) env)
    (setf (cdr pair) value)))

(defvar *step-inspector* nil)

(defun ccl::update-step-inspector (env)
  (let* ((inspector *step-inspector*)
         (view (and inspector (inspector-view inspector))))
    (when (and view (wptr view))
      (if env
        (ccl::step-inspect env nil)
        (setf (inspector-object inspector) nil)))))

(defun ccl::step-inspect (env &optional (select? t))
  (let* ((in *step-inspector*)
         (view (and in (inspector-view in)))
         (resample? t))
    (unless (and view (wptr view))
      (setq *step-inspector*
            (setq in (make-instance 'step-inspector :object env))
            resample? nil
            select? t))
    (unless (eq (inspector-object in) env)
      (setf (inspector-object in) env
            resample? t))
    (when select?
      (make-inspector-window in :window-title "Stepper Stack Frame"))
    (when (and resample? view (wptr view))
      (resample view))))

(defun close-step-inspector ()
  (let* ((inspector *step-inspector*)
         (view (and inspector (inspector-view inspector))))
    (when (and view (wptr view))
      (window-close (view-window view))))
  (setq *step-inspector* nil))

(ccl::provide 'step-window)
