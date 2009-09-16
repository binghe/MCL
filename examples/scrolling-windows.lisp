;;-*- Mode: Lisp; Package: CCL -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  scrolling-windows.lisp
;;
;;
;;  Copyright 1989-1994, Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.

;;
;;  A new class of windows which contain scroll-bars and a scrollable
;;  area.
;;

;;;;;;;;;;;;;
;;
;; Modification History
;;
;; 11/10/96 bill (provide :scrolling-windows)
;; ------------- 4.0f1
;; 01/06/92 bill initialize-instance allows defaults for the parameters
;;               that it passes through. Example at the bottom has a
;;               default :field-size

(in-package :ccl)

(require :scrollers)
(provide :scrolling-windows)

(defclass scrolling-window (window) ((my-scroller :accessor my-scroller)))

(defmethod initialize-instance ((self scrolling-window) &rest rest &key
                                (scroller-class 'scroller)
                                scroll-bar-class h-scroll-class v-scroll-class
                                track-thumb-p field-size)
  (declare (dynamic-extent rest))
  ; We use the values of these keywords by modifying the rest parameter
  (declare (ignore scroll-bar-class h-scroll-class v-scroll-class
                   track-thumb-p field-size))
  (call-next-method)
  ; Leave, in rest, only the four keywords we want to pass to the
  ; make-instance for scroller-class. This allows them to default
  ; as desired by scroll-class.
  (let* ((handle (cons nil rest)))
    (declare (dynamic-extent handle) (type cons handle))
    (do ((tail handle))
        ((null (cdr tail)) (setq rest (cdr handle)))
      (declare (type cons tail))
      (if (memq (cadr tail) 
                '(:scroll-bar-class :h-scroll-class :v-scroll-class
                  :track-thumb-p :field-size))
        (setq tail (cddr tail))
        (setf (cdr tail) (cdr (cddr tail))))))
  (setf (my-scroller self) (apply #'make-instance
                                  scroller-class
                                  :view-container self
                                  :view-size (subtract-points
                                              (view-size self) #@(15 15))
                                  :view-position #@(0 0)
                                  :draw-scroller-outline nil
                                  rest)))

(defmethod set-view-size ((self scrolling-window) h &optional v)
  (declare (ignore h v))
  (without-interrupts
   (call-next-method)
   (let* ((new-size (subtract-points (view-size self) #@(15 15))))    
       (set-view-size (my-scroller self) new-size))))

(defmethod window-zoom-event-handler ((self scrolling-window) message)
  (declare (ignore message))
  (without-interrupts
   (call-next-method)
   (let* ((new-size (subtract-points (view-size self) #@(15 15))))
       (set-view-size (my-scroller self) new-size))))

#|

(require 'quickdraw)

(defclass scrolling-window-scroller (scroller) ()
  (:default-initargs
    :field-size #@(220 220)))

(defmethod view-draw-contents ((self scrolling-window-scroller))
  (call-next-method)
  (paint-oval self 75 75 200 200)
  (frame-rect self 20 20 100 100)
  (erase-oval self 50 50 135 135))

(setq foo (make-instance 'scrolling-window
                         :scroller-class 'scrolling-window-scroller
                         :window-type :document-with-zoom
                         :view-size #@(200 200)
                         :track-thumb-p t))

|#