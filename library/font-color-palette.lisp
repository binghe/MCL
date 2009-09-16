(in-package :ccl)

;;; font-color-palette.lisp
;;; Toomas.Altosaar@hut.fi
;;; 1999-07-08

;;; Idea: Allow for quick editing of FRED color by including a windoid
;;; accessible via the fonts menu. Similar to Appleworks.

;;;============================================================================================
;;; One mini-color-view for each entry in the palette

(require :quickdraw)

(defclass mini-color-view (view)
  ((palette-index :initarg :palette-index :initform nil :accessor palette-index)
   (color-attribute :initarg :color-attribute :initform nil :accessor color-attribute)
   (palette-color :initarg :palette-color :initform nil :accessor palette-color)))

(defun create-mini-colur-views (w &key (palette *fred-palette*)
                                      (edge-space 1) (width 10) (space 1))
  ;;; creates the subviews
  ;;; note the special case: FRED uses palette index 0 as black
  (rlet ((rgb :RGBColor))
    (loop with r and g and b
          with x-off = edge-space and y-off = edge-space
          with x-width = width and y-width = width
          with x-space = space and y-space = space
          for i from 0 below (href palette :palette.PMEntries)
          for x = (mod i 16)
          for x-pix = (+ x-off (* x x-width) (* (max 0 x) x-space))
          for y = (floor i 16)
          for y-pix = (+ y-off (* y y-width) (* (max 0 y) y-space))
          for mini-color-view = (make-instance 'mini-color-view
                                   :palette-index i
                                   :color-attribute (list (list :color-index i))
                                   :view-size (make-point x-width y-width))
          do (#_GetEntryColor palette i rgb)
          do (setq r (pref rgb :RGBColor.red)
                   g (pref rgb :RGBColor.green)
                   b (pref rgb :RGBColor.blue))
          do (setf (palette-color mini-color-view)
                   (if (zerop i) *black-color* (make-color r g b)))
          do (set-view-position mini-color-view (make-point x-pix y-pix))
          do (add-subviews w mini-color-view)))
  w)

(defmethod view-draw-contents ((v mini-color-view))
  (with-focused-view v
    (with-fore-color (palette-color v)
      (paint-rect v 0 (view-size v)))
    (frame-rect v 0 (view-size v))))

(eval-when (:execute :compile-toplevel :load-toplevel)
  (defmacro with-pen-mode (view new-mode &body body)
    (let* ((mode (gensym)))
      `(let ((,mode (pen-mode ,view)))
         (unwind-protect
           (progn (set-pen-mode ,view ,new-mode)
                  ,@body)
           (set-pen-mode ,view ,mode)))))
  )

(defmethod external-hilite ((v view) &key)
  (let* ((vc (view-container v))
         (vp (view-position v))
         (vs (view-size v))
         (vp-h (point-h vp))
         (vp-v (point-v vp))
         (width (point-h vs))
         (height (point-v vs)))
    (with-focused-view vc
      (with-pen-mode v :patxor
        (frame-rect
         vc
         (make-point (1- vp-h) (1- vp-v))
         (make-point (+ vp-h width 1) (+ vp-v height 1)))))))

(defmethod view-mouse-enter-event-handler :after ((v mini-color-view))
  (external-hilite v))

(defmethod view-mouse-leave-event-handler :after ((v mini-color-view))
  (external-hilite v))

(defmethod view-click-event-handler ((v mini-color-view) where)
  (declare (ignore where))
  (let ((w (front-window)))
    (when w
      (let* ((attribute (color-attribute v))
             (key-handler (or (current-key-handler w) w)))
        (ed-set-view-font key-handler attribute)))))

;;;============================================================================================

(defclass font-color-palette-windoid (windoid) ())

(defvar *font-color-palette-windoid* nil)

;;;============================================================================================

(defun show-font-color-palette-windoid (&key (w *font-color-palette-windoid*))
  (when w (window-show w)))

(defun hide-font-color-palette-windoid (&key (w *font-color-palette-windoid*))
  (when w (window-hide w)))

(defun make-font-color-palette-windoid (&key (color-box-width 10))
  (when *font-color-palette-windoid*
    (hide-font-color-palette-windoid :w *font-color-palette-windoid*))
  (setq *font-color-palette-windoid*
        (let* ((NxN 256) ;palette has 256 entries
               (N (sqrt NxN))
               (edge-space 1)
               (width color-box-width)
               (space 1)
               (size (+ edge-space (* (1- N) (+ width space)) width edge-space))
               (new-w (make-instance 'font-color-palette-windoid
                        :GROW-ICON-P nil
                        :COLOR-P t
                        :CLOSE-BOX-P t
                        :WINDOW-TITLE "Text Color"
                        :CONTENT-COLOR *white-color*
                        :BACK-COLOR *white-color*
                        :view-size (make-point size size)
                        :window-show nil
                        :direction :left)))
          (create-mini-colur-views
           new-w :edge-space edge-space :width width :space space)
          new-w))
  (show-font-color-palette-windoid))

;(make-font-color-palette-windoid)
;(inspect (windows))
;(show-font-color-palette-windoid)
;(hide-font-color-palette-windoid)

;;;============================================================================================

(defvar *font-color-palette-windoid-menu*
  (make-instance 'window-menu-item
    :menu-item-title "Font Color Palette"
    :menu-item-action
    #'(lambda (w)
        (declare (ignore w))
        (make-font-color-palette-windoid))
    :update-function nil))

(unless (find-menu-item *edit-menu* "Font Color Palette")
  (add-menu-items *edit-menu*
                  (make-menu-item "-")
                  *font-color-palette-windoid-menu*))

;;;============================================================================================

(provide :font-color-palette)
  




