;;;-*-Mode: LISP; Package: (TURTLES) -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; turtles.lisp
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;;
;;
;;  this file implements a simple object-oriented turtle graphics package
;;

;; Change history
;;
;; 05/15/91 bill Move to TURTLES package to eliminate name conflicts.  Add modeline.

(defpackage :turtles
  (:export ;classes
   saving-window turtle)
  (:export ;Generic-functions
   hide show front-and-center erase die
   forward fwd backward bwd right left pen-up pen-down
   polygon square hexagon pentagon triangle))

(in-package :turtles)

(declaim (ftype (function (&rest t) t) ccl::move-to)
         (ftype (function (&rest t) t) ccl::line-to)
         (ftype (function (&rest t) t) ccl::set-pen-mode)
         (ftype (function (&rest t) t) ccl::pen-mode)
         (ftype (function (&rest t) t) ccl::erase-region))

(require :quickdraw)

;Haven't converted this yet.
;Hence, the turtle graphics window will not refresh itself.
;The next version of this file will have a display list for each turtle.
;(require 'saving-window "ccl;examples:saving-window")
(defclass saving-window (window) ())
(defmethod erase ((window saving-window))
  #-CARBON-COMPAT
  (with-macptrs ((rgn (rref (wptr window) :windowRecord.visrgn)))
    (ccl::erase-region window rgn))
  #+CARBON-COMPAT
  (LET ((RGN (#_NEWRGN)))  ;; SB UNWIND PROTECTED BUT FRANKLY SCARLETT ...
    (CCL::GET-WINDOW-VISRGN (WPTR WINDOW) RGN)
    (ccl::erase-region window rgn)
    (#_DISPOSERGN RGN)))
    

(defvar *turtle-window* (make-instance 'saving-window))
(defvar *last-turtle-to-draw* nil)
(defvar *all-turtles* nil)

(defclass turtle ()
  ((window :initform *turtle-window* :initarg :window :accessor turtle-window)
   (draw-self-function :initform 'normal-turtle-draw-self :initarg :draw-self-function
                       :accessor draw-self-function)
   (drawing-self? :initform nil :accessor turtle-drawing-self?)
   (x :accessor turtle-x)
   (y :accessor turtle-y)
   (angle :accessor turtle-angle)
   (pen-down? :accessor turtle-pen-down?)
   (visible? :initform nil :accessor turtle-visible?)))

;;;Here are the functions in the advertised interface

(defmethod initialize-instance :after ((turtle turtle) &key)
  (front-and-center turtle)
  (pushnew turtle *all-turtles*))

(defmethod die ((turtle turtle))
  (hide turtle)
  (setq *all-turtles* (delq turtle *all-turtles*)))

(defmethod front-and-center ((turtle turtle) &optional erase?)
  (hide turtle)
  (when erase? (erase turtle))
  (pen-down turtle)
  (let* ((window (turtle-window turtle))
         (c (window-center window))
         (x (point-h c))
         (y (point-v c)))
    (setf (turtle-x turtle) (coerce x 'float))
    (setf (turtle-y turtle) (coerce y 'float))
    (ccl::move-to window x y))
  (setf (turtle-angle turtle) 180)
  (show turtle))

(defmethod erase ((turtle turtle))
  (turtle-erase (turtle-window turtle)))

(defun turtle-erase (window)
  (erase window)
  (mapc #'(lambda (turtle)
             (if (and (eq window (turtle-window turtle)) (turtle-visible? turtle))
               (draw-self turtle)))
        *all-turtles*)
  t)

(defmethod pen-down ((turtle turtle))
  (setf (turtle-pen-down? turtle) t))

(defmethod pen-up ((turtle turtle))
  (setf (turtle-pen-down? turtle) nil))

(defmethod show ((turtle turtle))
  (unless (turtle-visible? turtle)
    (draw-self turtle)
    (setf (turtle-visible? turtle) t)))

(defmethod hide ((turtle turtle))
  (when (turtle-visible? turtle)
    (draw-self turtle)
    (setf (turtle-visible? turtle) nil)))

(defmethod right ((turtle turtle) delta-angle)
  (let ((visible? (turtle-visible? turtle)))
    (if visible? (draw-self turtle))
    (setf (turtle-angle turtle) (mod (- (turtle-angle turtle) delta-angle) 360))
    (if visible? (draw-self turtle))))

(defmethod left ((turtle turtle) delta-angle)
  (right turtle (- delta-angle)))

(defmethod forward ((turtle turtle) distance)
  (unless (eq turtle *last-turtle-to-draw*)
    (let ((ix (round (turtle-x turtle)))
          (iy (round (turtle-y turtle))))
      (ccl::move-to (turtle-window turtle) ix iy))
    (setq *last-turtle-to-draw* turtle))
  (if (turtle-visible? turtle) (draw-self turtle))
  (let* ((rads (deg-to-rad (turtle-angle turtle)))
         (delta-x (round (* distance (sin rads))))
         (delta-y (round (* distance (cos rads))))
         (x (incf (turtle-x turtle) delta-x))
         (y (incf (turtle-y turtle) delta-y))
         (ix (round x))
         (iy (round y))
         (window (turtle-window turtle)))
    (if (turtle-pen-down? turtle)
      (progn
        (ccl::line-to window ix iy)
        (if (turtle-drawing-self? turtle) (ccl::line-to window ix iy)))
      (ccl::move-to window ix iy))
    (if (turtle-visible? turtle) (draw-self turtle))))

(defmethod backward ((turtle turtle) distance)
  (forward turtle (- distance)))

(defmethod fwd ((turtle turtle) distance)
  (forward turtle distance))

(defmethod bwd ((turtle turtle) distance)
  (backward turtle distance))

;;; Here is an example draw-self function
(defmethod normal-turtle-draw-self ((turtle turtle))
  (right turtle 90)
  (forward turtle 5)
  (left turtle 120)
  (forward turtle 10)
  (left turtle 120)
  (forward turtle 10)
  (left turtle 120)
  (forward turtle 5)
  (left turtle 90))

(defmethod polygon ((turtle turtle) side-length number-of-sides)
  (let ((angle-increment (/ 360 number-of-sides)))
    (dotimes (i number-of-sides)
      (fwd turtle side-length)
      (right turtle angle-increment))))

(defmethod square ((turtle turtle) size)
  (polygon turtle size 4))

(defmethod hexagon ((turtle turtle) size)
  (polygon turtle size 6))

(defmethod pentagon ((turtle turtle) size)
  (polygon turtle size 5))

(defmethod triangle ((turtle turtle) size)
  (polygon turtle size 3))

;;; This is the internal part of the implementation

(defun deg-to-rad (angle)
  (* pi (/ angle 180)))

(defmethod window-center ((window window))
  (let ((s (view-size window)))
    (make-point (truncate (point-h s) 2)
                (truncate (point-v s) 2))))
  
  
(defmacro with-pen-mode (window mode &body body)
  (let ((old-mode (gensym)))
    `(let ((,old-mode (ccl::pen-mode ,window)))
       (unwind-protect
         (progn (ccl::set-pen-mode ,window ,mode)
                ,@body)
         (ccl::set-pen-mode ,window ,old-mode)))))

(defmacro with-xor-pen (window &body body)
  `(with-pen-mode ,window :patxor ,@body))
  

(defmethod draw-self ((turtle turtle))
  (let ((pen-was-down? (turtle-pen-down? turtle))
        (was-visible? (turtle-visible? turtle))
        (save-x (turtle-x turtle))
        (save-y (turtle-y turtle))
        (save-angle (turtle-angle turtle))
        (window (turtle-window turtle)))
    (unwind-protect
      (progn
        (pen-down turtle)
        (setf (turtle-visible? turtle) nil
              (turtle-drawing-self? turtle) t)
        (with-xor-pen window
          (funcall (draw-self-function turtle) turtle)))
      (unless pen-was-down? (pen-up turtle))
      (if was-visible? (setf (turtle-visible? turtle) t))
      (setf (turtle-x turtle) save-x
            (turtle-y turtle) save-y
            (turtle-angle turtle) save-angle
            (turtle-drawing-self? turtle) nil)
      (let ((ix (round save-x))
            (iy (round save-y)))
        (ccl::move-to window ix iy)))))

(provide :turtles)

#|
(defparameter *t1* (make-instance 'turtle))
(dotimes (i 12)
  (right *t1* 30)
  (hexagon *t1* 30))
|#
