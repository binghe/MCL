;;-*- Mode: Lisp; Package: CCL -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; view-example.lisp
;; Copyright 1990-1994, Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

; Simple example of views.
; Sets up a window with some views in it.
; Dragging a view moves it around.
; Draggin a view's lower right-hand corner changes its size.
; <command>-clicking creates a new view with the upper-left corner in
;   the mouse-down position and the lower-right corner in the mouse-up position.
; <command><option>-clicking creates a new simple-view.
; <control>-clicking deletes a view.
; <shift>-clicking selects the pointed view for furthur operations and makes it blink.
;    Clicking while a view is blinking changes that views container and
;      position to the clicked location.
;    While a view is blinking the "Opaque", "Bring to Front", & "Send to Back"
;      menu items on the "View Example" menu will operate on that view.
; The "About" menu item on the "View Example" menu is not yet implemented.
; Evaluate the commented-out form at the bottom of this file to create a window.

;;;;;;;
;
; Change history
;
; 05/11/01 akh carbon-compat
; 03/04/91 bill Listify *eventhook* before pushing on it.

(in-package :ccl)

(defclass r-view-mixin ()
  ((view-opaque-p :initform nil :reader view-opaque-p)))
(defclass simple-r-view (r-view-mixin simple-view) ())
(defclass r-view (simple-r-view view) ())
(defclass r-view-window (r-view-mixin window)
  ((blinker :initform nil)
   last-blink-time
   last-blink-state))

(defun port-set-pen-state (&key location size mode pattern)
  (rlet ((ps :PenState))
    (#_GetPenState ps)
    (when location
      (rset ps PenState.pnLoc location))
    (when size
      (rset ps PenState.pnSize size))
    (when mode
      (rset ps PenState.pnMode (position mode *pen-modes*)))
    (when pattern
      (rset ps PenState.pnPat pattern))
    (#_SetPenState ps)))

(defmacro with-pen-state ((&rest states) &body body)
  (let ((ps (gensym)))
    `(rlet ((,ps :PenState))
       (require-trap #_GetPenState ,ps)
       (unwind-protect
         (progn
           (port-set-pen-state ,@states)
           ,@body)
         (require-trap #_SetPenState ,ps)))))

(defmethod view-focus-and-draw-contents ((v simple-r-view) &optional visrgn cliprgn)
  (declare (ignore visrgn cliprgn))
  (with-focused-view v
    (view-draw-contents v)))

(defmethod view-draw-contents ((v simple-r-view))
  (draw-r-view-inside v)
  (call-next-method)
  (draw-r-view-outline v))

(defmethod draw-r-view-outline ((v simple-r-view))
  (let ((topleft (view-scroll-position v)))
    (rlet ((rect :rect :topleft topleft
                 :bottomright (add-points topleft (view-size v))))
      (#_FrameRect rect))))

(defun make-pattern (&rest bytes)
  (let ((res (#_NewPtr 8))
        (i 0))
    (dolist (b bytes)
      (%put-byte res b i)
      (if (>= (incf i) 8) (return)))
    (loop 
      (unless (< i 8) (return))
      (%put-byte res 0 i)
      (incf i))
    res))

(defvar *r-view-pattern* nil)
(def-load-pointers r-view-pattern ()
  (setq *r-view-pattern* (make-pattern 128 0 0 0 8 0 0 0)))

(defmethod draw-r-view-inside ((v r-view) &optional pattern)
  (if (or pattern (setq pattern (and (view-opaque-p v) *r-view-pattern*)))
    (call-next-method v pattern)))

(defmethod draw-r-view-inside ((v simple-r-view) &optional pattern)
  (let ((topleft (add-points (view-scroll-position v) #@(1 1)))
        (size (subtract-points (view-size v) #@(2 2))))
    (rlet ((rect :rect :topleft topleft
                 :bottomright (add-points topleft size)))
      (unless pattern
        (setq pattern (if (view-opaque-p v) *gray-pattern* *light-gray-pattern*)))
      (with-pen-state (:pattern pattern :mode (if (view-opaque-p v) :patcopy :pator))
        (#_PaintRect rect)))))


(defmethod set-view-size :before ((view simple-r-view) h &optional v)
  (declare (ignore h v))
  (inval-r-view-sides view))

(defmethod set-view-size :after ((view simple-r-view) h &optional v)
  (declare (ignore h v))
  (inval-r-view-sides view))

(defvar *r-view-temp-region* nil)
(def-load-pointers r-view-temp-region ()
  (setq *r-view-temp-region* (#_NewRgn)))

(defmethod inval-r-view-sides ((view simple-r-view) &optional top&left?)
  (when (wptr view)
    (let* ((pos (view-scroll-position view))
           (size (view-size view))
           (end-pos (add-points pos size))
           (rgn *r-view-temp-region*))
      (unless top&left?
        (setq pos (subtract-points pos #@(1 1))))
      (#_SetRectRgn :ptr rgn :long pos :long end-pos)
      (#_InsetRgn :ptr rgn :long #@(1 1))
      (#_DiffRgn :ptr (view-clip-region view) :ptr rgn :ptr rgn)
      (with-focused-view view
        (#_EraseRgn :ptr rgn)
        #-carbon-compat
        (#_InvalRgn :ptr rgn)
        #+carbon-compat
        (inval-window-rgn (wptr view) rgn)))))

(defmethod set-view-scroll-position ((view r-view) h &optional v scroll-visibly?)
  (declare (ignore scroll-visibly?))
  (without-interrupts
   (let ((old-scroll (view-scroll-position view)))
     (call-next-method)
     (let ((pos (view-position view)))
       (unwind-protect
         (setf (slot-value view 'view-position)
               (add-points pos (subtract-points old-scroll (make-point h v))))
         (inval-r-view-sides view t))
       (setf (slot-value view 'view-position) pos)))
   (inval-r-view-sides view t)))

(defmethod view-click-event-handler ((view r-view-mixin) where)
  (when (eq view (call-next-method))
    (unless (typep view 'view)
      (setq where (convert-coordinates where (view-container view) view)))
    (with-focused-view view
      (cond ((command-key-p) (new-r-view view where))
            ((control-key-p) (delete-r-view view where))
            ((shift-key-p) (new-r-view-container view where))
            (t (move-r-view view where))))))

(defmethod new-r-view ((view r-view-mixin) where)
  (if (not (typep view 'view))
    (#_sysbeep 5)                  ; User chose a simple-r-view
    (let ((new (make-instance (if (option-key-p) 'simple-r-view 'r-view)
                              :view-container view
                              :view-position where
                              :view-size #@(3 3))))
      (move-r-view new #@(0 0)))))

(defmethod delete-r-view ((view r-view-mixin) where)
  (declare (ignore where)))

(defmethod delete-r-view ((view simple-r-view) where)
  (declare (ignore where))
  (set-view-container view nil))

(defmethod new-r-view-container ((view r-view-mixin) where)
  (declare (ignore where)))

(defmethod new-r-view-container ((view simple-r-view) where)
  (declare (ignore where))
  (start-r-view-blinking view))

(defmethod view-click-event-handler ((w r-view-window) where)
  (with-slot-values (blinker) w
    (if blinker
      (let ((new-container (find-view-containing-point w where)))
        (if (or (eq blinker new-container)
                (view-contains-p blinker new-container)
                (not (typep new-container 'view)))
          (#_sysbeep 5)
          (progn
            (invalidate-view blinker)
            (preserving-update-region (wptr blinker)
              (set-view-position
               blinker (convert-coordinates where w new-container))
              (set-view-container blinker new-container))
            (invalidate-view blinker)))
        (stop-r-view-blinking blinker))
      (call-next-method))))

(defvar *blinking-r-view-windows* nil)

(defun r-view-eventhook ()
  (let ((time (rref *current-event* eventRecord.when)))
    (dolist (w *blinking-r-view-windows*)
      (maybe-blink w time))))

(let ((h *eventhook*))
  (setq *eventhook*
        (adjoin 'r-view-eventhook
                (and h (if (atom h) (list h) h)))))

(defmethod maybe-blink ((w r-view-window) time)
  (with-slot-values (blinker last-blink-time) w
    (when (> time (+ last-blink-time 15))
      (setf (slot-value w 'last-blink-time) time)
      (with-focused-view blinker
        (with-pen-state (:mode :srcxor)
          (draw-r-view-outline blinker))))))

(defun start-r-view-blinking (view)
  (let* ((w (view-window view))
         (blinker (slot-value w 'blinker)))
    (when blinker
      (stop-r-view-blinking blinker))
    (setf (slot-value w 'blinker) view)
    (setf (slot-value w 'last-blink-time) (rref *current-event* eventRecord.when))
    (pushnew w *blinking-r-view-windows*)))


(defun stop-r-view-blinking (view)
  (let* ((w (view-window view))
         (blinker (slot-value w 'blinker)))
    (when (eq blinker view)
      (setq *blinking-r-view-windows* (delq w *blinking-r-view-windows*))
      (setf (slot-value w 'blinker) nil)
      (with-focused-view view
        (view-draw-contents view)))))

; Catch method for an r-view-window
(defmethod move-r-view ((view r-view-mixin) where)
  (declare (ignore where)))

(defmethod move-r-view ((view simple-r-view) where)
  (let* ((container (view-container view))
         (last-mp (view-mouse-position container))
         (delta where)
         (w (view-window view))
         (from-end (subtract-points (view-size view) where))
         (change-size? (and (< (abs (point-h from-end)) 5)
                            (< (abs (point-v from-end)) 5))))
    ;      (format t "change-size? = ~S~%" change-size?)
    (if change-size?
      (setq delta from-end
            container view
            last-mp where))
    (loop
      (unless (mouse-down-p) (return))
      (let ((mp (view-mouse-position container)))
        (unless (eql mp last-mp)
          (setq last-mp mp)
          (if change-size?
            (set-view-size view (add-points mp delta))
            (set-view-position view (subtract-points mp delta)))
          (window-update-event-handler w))))))

(defparameter *r-view-menu*
  (make-instance 'menu :menu-title "View Example"))

(defvar *r-view-new-views-opaque-menu-item*)
(defvar *r-view-opaque-menu-item*)
(defvar *r-view-bring-to-front-menu-item*)
(defvar *r-view-send-to-back-menu-item*)

(let ((menu *r-view-menu*))
  (add-new-item menu "AboutÉ" 'about-view-example)
  (setq *r-view-new-views-opaque-menu-item*
        (add-new-item menu "New Views Opaque" 'view-example-new-views-opaque))
  (add-new-item menu "-" nil :disabled t)
  (setq *r-view-opaque-menu-item*
        (add-new-item menu "Opaque" 'change-blinking-r-view-opaque-p))
  (setq *r-view-bring-to-front-menu-item*
        (add-new-item menu "Bring to Front" 'bring-blinking-r-view-to-front))
  (setq *r-view-send-to-back-menu-item*
        (add-new-item menu "Send to Back" 'send-blinking-r-view-to-back)))

(defmethod view-activate-event-handler :after ((w r-view-window))
  (unless (find-menu "View Example")
    (menu-install *r-view-menu*)))

(defmethod view-deactivate-event-handler :after ((w r-view-window))
  (when (not (listp *eventhook*))(setq *eventhook* (list *eventhook*)))
  (push 'maybe-deinstall-r-view-menu *eventhook*))

(defun maybe-deinstall-r-view-menu ()
  (unless (typep (front-window) 'r-view-window)
    (menu-deinstall *r-view-menu*))
  (unless (atom *eventhook*)
    (setq *eventhook* (nremove 'maybe-deinstall-r-view-menu *eventhook*)))
  nil)

(defmethod window-close :after ((w r-view-window))
  (menu-deinstall *r-view-menu*))

(defmethod menu-update ((item (eql *r-view-menu*)))
  (let ((w (front-window)))
    (when (typep w 'r-view-window)      ; should always be
      (let ((blinker (slot-value w 'blinker)))
        (if blinker
          (progn
            (menu-item-enable *r-view-opaque-menu-item*)
            (menu-item-enable *r-view-bring-to-front-menu-item*)
            (menu-item-enable *r-view-send-to-back-menu-item*)
            (set-menu-item-check-mark *r-view-opaque-menu-item*
                                      (view-opaque-p blinker)))
          (progn
            (menu-item-disable *r-view-opaque-menu-item*)
            (menu-item-disable *r-view-bring-to-front-menu-item*)
            (menu-item-disable *r-view-send-to-back-menu-item*)))))))

(defun about-view-example ()
  (#_SysBeep 5))

(defun view-example-new-views-opaque ()
  (let* ((menu-item  *r-view-new-views-opaque-menu-item*)
         (opaque-p (not (menu-item-check-mark menu-item))))
    (set-menu-item-check-mark menu-item opaque-p)))

(defmethod initialize-instance :after ((v simple-r-view) &rest initargs)
  (declare (ignore initargs))
  (when (menu-item-check-mark *r-view-new-views-opaque-menu-item*)
    (set-view-opaque-p v t)))  

(defmethod set-view-opaque-p ((v simple-r-view) opaque-p)
  (let ((was-opaque (view-opaque-p v)))
    (unless (eq was-opaque opaque-p)
      (setf (slot-value v 'view-opaque-p) opaque-p)
      (invalidate-view v t))))

(defun change-blinking-r-view-opaque-p ()
  (let ((w (front-window)))
    (when (typep w 'r-view-window)
      (let ((blinker (slot-value w 'blinker)))
        (when blinker
          (set-view-opaque-p blinker (not (view-opaque-p blinker)))
          (stop-r-view-blinking blinker))))))

(defun bring-blinking-r-view-to-front ()
  (let ((w (front-window)))
    (when (typep w 'r-view-window)
      (let ((blinker (slot-value w 'blinker)))
        (when blinker
          (view-bring-to-front blinker)
          (stop-r-view-blinking blinker))))))

(defun send-blinking-r-view-to-back ()
  (let ((w (front-window)))
    (when (typep w 'r-view-window)
      (let ((blinker (slot-value w 'blinker)))
        (when blinker
          (view-send-to-back blinker)
          (stop-r-view-blinking blinker))))))


#|
(setq w (make-instance 'r-view-window :view-size #@(200 200)))
|#