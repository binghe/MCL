;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  3 7/4/97   akh  dont know
;;  2 4/1/97   akh  see below
;;  3 5/31/95  akh  mouse copy uses physical command key - from alanr
;;  2 5/22/95  akh  fix for read only buffer

;;  2 2/16/95  slh  fix give-text typo
;;  (do not edit before this line!!)

;; Copyright 1989-1994 Apple COmputer, Inc.
;; Copyright 1995 Digitool, Inc.

;; ****************************************************************
;; code to implement command-click.
;; Command Click copies what you are pointing to where you are typing.

;; Implementation:

;; Each type of view which wants to be able to contribute text defines two methods
;; (give-text? view)   -> t if you can supply text
;; (give-text view)    -> The text which is to be copied.

;; Additionally the view-click-event-handler should arrange to call
;; (maybe-click-to-copy from-window to-window position continuation)
;; where continuation is called if the click wasn't a command click,
;; or if it was but there was no text to copy.

;; Currently the methods for editable-text, dialog-item, sequence-dialog-item, and
;; fred-mixin do this by advising the around method for view-click-event-handler.
;; Also, the window-select-event-handler is also advised, so that you can command click
;; another to copy from another window.

;; ****************************************************************

;; Change log
;;
;; fix give-text for basic-editable-text-dialog-item
;; -------- 5.2b5
;; (method ...) -> (reference-method ...) ???
;; ------- 5.1b1
;; 03/21/97 akh   buffer-insert-carefully, add spaces when fred-word-constituent vs alphanumericp
;;  9/17/96 bill  Fix view-insertion-font.
;;  9/06/96 slh   buffer-insert-carefully forces :bold (from AlanR)
;;  2/16/95 slh   typo in give-text/menu-of-defs-dialog (thanks Doug Currie)
;; -------------- 3.0d17
;; 03/27/92 alice update-default-button in maybe-click-to-copy if appropriate
;; 03/19/93 bill  forgot a close paren at the end of MC's fix of 7/29/92
;; 07/29/92 mc    Fixed menu-of-defs-dialog's give-text to handle null
;;                window-package (mc = Matt Cornell, cornell@cs.umass.edu)
;; -------------- 2.0
;; 03/17/92 bill  the menu-of-defs-dialog code no longer replaces
;;                the sequence-dialog-item code.
;; -------------- 2.0f3
;; 10/04/91 alanr Support the list definitions dialog
;; 09/13/91 alice make buffer-insert-carefully undo aware
;; 04/18/91 wkf  Fix to avoid error when you click where there is no text.
;; 01/01/91 bill  Prettify, remove LOOP
;; 12/11/90 alice fix calls to advise for changed arglist
;; 11/05/90 bill Remove reliance on (declaim (ignore ignore))

(in-package :ccl)

(defmethod give-text ((v t)) nil)
(defmethod give-text? ((v t)) nil)

(defmethod insert-text ((v t) ignore)
  (declare (ignore ignore))
  nil)
(defmethod insert-text ((v fred-mixin) string)
  (buffer-insert-carefully v string)
  (fred-update v))

(defmethod view-insertion-font ((w simple-view))
  (let ((w (view-window w)))
    (and w
         (view-insertion-font (view-window w)))))

; A method that is always applicable.
(defmethod view-insertion-font ((w t))
  nil)

; No special insertion font for normal windows
(defmethod view-insertion-font ((w window))
  nil)

(when (find-class 'listener)
  (defmethod view-insertion-font ((w listener))
    '(:bold)))

(defmethod buffer-insert-carefully ((w fred-mixin) string
                                    &aux (mark (fred-buffer w)) position append)
  "Insert spaces around insertion, if absent"
  (let ((font (view-insertion-font w)))
    (handler-case
      (progn
        (multiple-value-bind (s e) (selection-range w)
          (when (collapse-selection w t)
            (setq append t)
            (ed-delete-with-undo w e s)))
        (setq position (buffer-position mark))
        (unless (or (eql position (buffer-line-start mark position))                    
                    (not (position (buffer-char mark (1- position)) *fred-word-constituents*)))
          (ed-insert-with-undo w " " position append font)
          (setq append t)
          (incf position))
        (unless (or (eql position (buffer-line-end mark position))
                    (not (position (buffer-char mark  position) *fred-word-constituents*)))
          (ed-insert-with-undo  w " " position append font)
          (setq append t))
        (ed-insert-with-undo w string position append font))
      (modify-read-only-buffer (c)
                               (declare (ignore c))
                               (buffer-whine-read-only w)))))

; from alanr - more like 2.0 if *control-key-mapping* not nil
; Also: Here is a patch so that mouse copy always uses the physical
; command key, as it did in 2.0.
(defun maybe-click-to-copy (from to where &optional (continue 'identity))
  (let* ((w (view-window to))
         (insert-into (or (current-key-handler (view-window to)) 
                          (and (typep w 'fred-window)
                               w))))
    (if (and insert-into
             (let ((method (method-exists-p #'insert-text insert-into)))
               (and method (not (eq method (reference-method insert-text (t t)))))))  ;; <<
      (if (and (case *control-key-mapping*
                 (:command (and (control-key-p)
                                (not (or (command-key-p) (shift-key-p) (option-key-p)))))
                 ((nil :command-shift) (and (command-key-p) (not (or (control-key-p) (shift-key-p) (option-key-p)))))))
        (let ((give-text (deepest-give-text-below-mouse from where)))
          (if (and insert-into give-text)
            (progn 
              (insert-text insert-into give-text)
              (when (method-exists-p 'update-default-button w)
                (update-default-button w)))
            (funcall continue)))
        (funcall continue))
      (funcall continue))))                             

#| ; old version
(defun maybe-click-to-copy (from to where &optional (continue 'identity))
  (handler-case    
    (let* ((w (view-window to))
           (insert-into (or (current-key-handler (view-window to))  (and (typep (view-window to) 'fred-window) w))))
      (if insert-into
        (if (and (command-key-p) (not (or (control-key-p) (shift-key-p) (option-key-p))))
          (let ((give-text (deepest-give-text-below-mouse from where)))
            (if (and insert-into give-text)
              (progn 
	        (insert-text insert-into give-text)
	        (when (method-exists-p 'update-default-button w)
                  (update-default-button w)))
              (funcall continue)))
          (funcall continue))
        (funcall continue)))
    (modify-read-only-buffer (c)
     (declare (ignore c))
     (buffer-whine-read-only to))))
|#
    

(defmethod current-key-handler ((view t)) nil)

(unless
  (ignore-errors (find-method #'view-click-event-handler '(:around) (mapcar 'find-class '(fred-mixin t))))
  (defmethod view-click-event-handler :around ((view fred-mixin) ignore)
    (declare (ignore ignore))
    (when (next-method-p) (call-next-method))))

(unless
  (ignore-errors (find-method #'view-click-event-handler '(:around) (mapcar 'find-class '(dialog-item t))))
  (defmethod view-click-event-handler :around ((view dialog-item) ignore)
    (declare (ignore ignore))
    (when (next-method-p) (call-next-method))))

(advise window-select-event-handler
        (maybe-click-to-copy (car arglist) (front-window)
                             (view-mouse-position (car arglist)) #'(lambda ()(:do-it)))
        :when :around :name maybe-copy)

(advise (:method view-click-event-handler :around (fred-mixin t))
        (destructuring-bind (v where) arglist
          (maybe-click-to-copy v v where #'(lambda() (:do-it))))
        :when :around :name maybe-click-to-copy)

(advise (:method view-click-event-handler :around (dialog-item t))
        (destructuring-bind (v where) arglist
          (maybe-click-to-copy v v (convert-coordinates where (view-container v) v) #'(lambda () (:do-it))))
        :when :around :name maybe-click-to-copy)

(defmethod deepest-give-text-below-mouse ((v simple-view) position &aux w)
  (declare (optimize (speed 3) (safety 0)))
  (setq w (view-window v))
  (setq position (convert-coordinates position v w))
  (rlet ((r :rect))
    (labels ((deepest 
              (v^)
              (rset r rect.topleft (convert-coordinates #@(0 0) v^ w))
              (rset r rect.bottomright (convert-coordinates (view-size v^) v^ w))
              (let ((res (and (#_ptinrect position r)
                              (let ((lower (do-subviews (s v^)
                                             (let ((d (deepest s)))
                                               (when d (return d))))))
                                (or lower
                                    (and (give-text? v^) v^))))))
                res
                )))
      (give-text (deepest w)))))

;; ****************************************************************
;; support for some view types

;; fred mixins

(defmethod give-text? ((v fred-mixin)) t)
(defmethod give-text ((v fred-mixin))
  (let ((buffer (fred-buffer v)))
    (multiple-value-bind (start end) 
                         (buffer-current-sexp-bounds
                          buffer
                          (fred-point-position v (view-mouse-position v) ))
      (if start
        (buffer-substring buffer start end)
        ""))))

;; sequence dialog items
(defmethod give-text? ((v sequence-dialog-item))
  (not (typep (view-container v) 'menu-of-defs-dialog)))
(defmethod give-text ((v sequence-dialog-item))
  (let ((cell (point-to-cell v (view-mouse-position (view-container v)))))
    (when cell
      (setq * (cell-contents v cell))
      (format nil "~s" (cell-contents v cell)))))

;; editable-text-dialog-items
(defmethod give-text? ((v basic-editable-text-dialog-item)) t)
#|
(defmethod give-text ((v basic-editable-text-dialog-item))
  (let ((buffer (fred-buffer v)))
    (multiple-value-bind 
      (start end) 
      (buffer-current-sexp-bounds buffer (fred-point-position v (view-mouse-position v) ))
      (buffer-substring buffer start end))))
|#

(defmethod give-text ((v basic-editable-text-dialog-item))
  (call-next-method))

;; dialog items return their text

(defmethod give-text? ((v dialog-item)) t)
(defmethod give-text ((v dialog-item)) 
  (dialog-item-text v))

;; get the right line from the inspector

(defmethod clicked-on-selection ((view inspector::inspector-view) where)
  (let ((v (point-v where))
        (line-positions (inspector::line-positions view))
        temp
        new-selection)
    (when line-positions
      (setq temp (aref line-positions 0))
      (dotimes (i (1- (length line-positions)))
        (when (and (<= temp v)
                   (< v (setq temp (aref line-positions (1+ i)))))
          (let ((selection (+ (inspector::start-line view) i)))
            (unless (eq (inspector::cached-type-n view selection) :comment)
              (setq new-selection selection)
              (return))))))
    new-selection))

(defmethod give-text ((view inspector::inspector-view))
  (let ((object (inspector::cached-line-n view (clicked-on-selection view (view-mouse-position view)))))
    (setq * object)
    (prin1-to-string object)
    ))

(defmethod view-click-event-handler :around ((v inspector::inspector-view) where)
  (maybe-click-to-copy v v where #'(lambda() (when (next-method-p) (call-next-method)))))

(defmethod give-text? ((v inspector::inspector-view)) t)

; Support the list definitions dialog
(defmethod give-text? ((v menu-of-defs-dialog))
  (let ((seq (do-subviews (sv v 'sequence-dialog-item) (return sv))))
    (and seq
         (view-contains-point-p seq (view-mouse-position v)))))

(defmethod give-text ((w menu-of-defs-dialog))
  (let* ((v (do-subviews (sv w 'sequence-dialog-item) (return sv)))
         (cell (point-to-cell v (view-mouse-position w)))
         (package (or (window-package (slot-value w 'my-window)) *package*))
         (contents (let ((*package* package))
                     (read-from-string (car (cell-contents v cell))))))
    (when cell
      (let ((function (if (consp contents) (car contents) contents)))
        (when (fboundp function)
          (setq function (symbol-function function))
          (setq * function)
          (if (consp contents)
            (let ((method (ignore-errors
                           (nth-value 
                            1 (%trace-function-spec-p
                               (cons :method contents))))))
              (when method (setq * method)))))))
    (when (consp contents) (setq contents (car contents)))
    (when cell
      (format nil "~a" contents))))

; End of mouse-copy.lisp

