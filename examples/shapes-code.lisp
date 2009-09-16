;;-*- Mode: Lisp; Package: CL-USER -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; shapes-code.lisp
;; Copyright 1990-1994, Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;; 
;; Originally written in Object Lisp by Andrew Shalit
;; revised for CLOS by Sarah Smith
;;
;; This code creates a window containing a drawing area and two buttons,
;; "circles" and "squares" .  
;; Clicking in the drawing area draws a circle or square.
;; Clicking either button redraws all the circles to squares or vice versa.
;; A menu changes the color of all the circles or squares.
;; Note that loading this file will change your menubar.
;; To get back your old menubar: (set-menubar *user-menubar*)
;; or select "Original Menubar" from the edit menu

(in-package :cl-user) 

(require :scrollers)

(defvar *shape-color* *black-color*)

(defvar *user-menubar* (menubar))

(defclass shape-scroller (ccl::scroller) ())
   
(defclass shape-window (window)
  ((shape-list :initarg :shape-list :initform nil :accessor shape-list)
   (current-shape :initarg :current-shape :initform :circle :accessor current-shape)
   (my-scroller :initarg :my-scroller :initform nil :accessor my-scroller))
    (:default-initargs 
      :window-type :document-with-grow
      :window-title "Shapes"))

(defmethod initialize-instance ((window shape-window) &rest initargs)
  (apply #'call-next-method window 
         initargs)
  (setf (my-scroller window)
        (make-instance 'shape-scroller 
                             :view-position #@(0 30)
                             :view-size (subtract-points 
                                         (view-size window) #@(15 45))))
  (add-subviews window
                (make-instance 'radio-button-dialog-item
                               :view-position #@(100 10)
                               :dialog-item-text "Squares"
                               :dialog-item-action
                               #'(lambda (item)
                                   item
                                     (setf (current-shape (view-container item)) :square)
                                     (clean-slate (view-container item))))
                (make-instance 'radio-button-dialog-item
                               :view-position #@(10 10)
                               :dialog-item-text "Circles"
                               :dialog-item-action
                              #'(lambda (item)
                                   item
                                     (setf (current-shape (view-container item)) :circle)
                                     (clean-slate (view-container item)))
                               :radio-button-pushed-p t)
                (my-scroller window)))

(defmethod clean-slate ((window shape-window))
  (with-focused-view window
    (let ((scroll-position (view-scroll-position window)))
      (rlet ((rect :rect
                   :topLeft scroll-position
                   :botRight (add-points scroll-position (view-size window))))
        (#_EraseRect rect)))
    (view-draw-contents window)))

(defmethod set-view-size ((window shape-window) h &optional v)
  (call-next-method)
  (set-view-size (my-scroller window) (subtract-points (make-point h v) #@(15 45))))

(defmethod view-click-event-handler ((scroller shape-scroller) position)
  (let ((my-window (view-container scroller)))
    (setf (slot-value  my-window 'shape-list) 
                      (cons position (shape-list my-window)))
  (view-draw-contents scroller)))

(defmethod view-draw-contents ((scroller shape-scroller))
  (let ((my-window (view-container scroller)))
    (with-focused-view scroller
      (with-fore-color *shape-color*
        (dolist (s (shape-list my-window))
          (rlet ((rect :rect :topLeft s :botRight (add-points s #@(30 30))))
            (if (eq (current-shape my-window) :circle)
              (#_FrameOval rect)
              (#_FrameRect rect))))))))



(defparameter *littlebar*
  (list (car *default-menubar*)
        (make-instance 'menu
                       :menu-title "File"
                       :menu-items
                       (list (make-instance 'menu-item
                                            :menu-item-title "New Shape Window"
                                            :menu-item-action
                                            #'(lambda nil (make-instance 'shape-window))
                                            :command-key #\N)
                             (make-instance 'menu-item
                                            :menu-item-title "Open"
                                            :menu-item-action
                                            'choose-file-dialog
                                            :command-key #\O)
                             (make-instance 'menu-item
                                            :menu-item-title "Quit"
                                            :menu-item-action
                                            'quit)))
        (make-instance 'menu
                       :menu-title "Edit"
                       :menu-items
                       (list (make-instance 'menu-item
                                            :menu-item-title "Undo"
                                            :disabled t
                                            :command-key #\Z
                                            :menu-item-action 'undo)
                             (make-instance 'menu-item
                                            :menu-item-title "-"
                                            :disabled t)
                             (make-instance 'window-menu-item
                                            :menu-item-title "Cut"
                                            :command-key #\X
                                            :menu-item-action 'cut)
                             (make-instance 'window-menu-item
                                            :menu-item-title "Copy"
                                            :command-key #\C
                                            :menu-item-action 'copy)
                             (make-instance 'window-menu-item
                                            :menu-item-title "Paste"
                                            :command-key #\V
                                            :menu-item-action 'paste)
                             (make-instance 'window-menu-item
                                            :menu-item-title "Clear"
                                            :menu-item-action 'clear)
                             (make-instance 'menu-item
                                            :menu-item-title "-"
                                            :disabled t)
                             (make-instance 'menu-item
                                            :menu-item-title "Original Menubar"
                                            :menu-item-action #'(lambda ()
                                                                  (set-menubar *user-menubar*)))))
        (make-instance 'menu
                       :menu-title "Colors"
                       :menu-items
                       (list (make-instance 'menu-item
                                            :menu-item-title "Black"
                                            :menu-item-action
                                            #'(lambda nil
                                                (setq *shape-color* *black-color*)))
                             (make-instance 'menu-item
                                            :menu-item-title "Blue"
                                            :menu-item-action
                                            #'(lambda nil
                                                (setq *shape-color* *blue-color*)))
                             (make-instance 'menu-item
                                            :menu-item-title "Red"
                                            :menu-item-action
                                            #'(lambda nil
                                                (setq *shape-color* *red-color*)))
                             (make-instance 'menu-item
                                            :menu-item-title "Green"
                                            :menu-item-action
                                            #'(lambda nil
                                                (setq *shape-color* *green-color*)))))))

(set-menubar *littlebar*)
