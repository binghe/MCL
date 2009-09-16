;;-*- Mode: Lisp; Package: CCL -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; windoid-key-events.lisp
;; Copyright 1990-1994, Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.
;;
;;  How to make a windoid handle key events and null events
;;
;;
;; DO-EVENT calls WINDOW-EVENT on the front window for events that
;; do not include a window as part of their message.
;; The WINDOW-EVENT method for the WINDOW class then dispatches to:
;; VIEW-KEY-EVENT-HANDLER, WINDOW-NULL-EVENT-HANDLER, 
;; WINDOW-KEY-UP-EVENT-HANDLER, or WINDOW-MOUSE-UP-EVENT-HANDLER
;; If the front window is a WINDOID, the default method for each
;; of these generic functions, passes the event to the WINDOW-UNDER
;; the window. If you want to have one of your WINDOIDs handle these events
;; you need to provide an ACCEPT-KEY-EVENTS method for it and handle
;; enabling/disabling of the cursor blinker.

(in-package :ccl)

(eval-when (:execute :compile-toplevel :load-toplevel)
  (export '(click-to-type-windoid x-windoid mouse-window fix-blinkers)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Change History
;;
;; 03/24/93 bill Oddmund Mogedal's fix to
;;               (method window-hide :before (click-to-type-windoid)) to
;;               make it work after windoid-close-patch has been loaded.
;; 04/21/92 bill (provide "WINDOID-KEY-EVENTS")
;; ------------- 2.0
;; 11/05/91 bill Don't enable blinkers if a windoid is not active
;; 01/16/91 bill New file.

; A CLICK-TO-TYPE-WINDOID accepts key events if it was the
; last window the user clicked in.
(defclass click-to-type-windoid (windoid) ())
 
(defvar *active-window* nil)

; If ACCEPT-KEY-EVENTS returns true, then windoid events are handled
; locally instead of being passed to the next window.
(defmethod accept-key-events ((w click-to-type-windoid))
  (unless (eq *active-window* *last-mouse-click-window*)
    (fix-blinkers (setq *active-window* *last-mouse-click-window*)))
  (and (eq w *last-mouse-click-window*)
       (current-key-handler w)))

; FIX-BLINKERS is an auxiliary function that we define.
; It calls TOGGLE-BLINKERS to enable the blinker for the
; active window and disable the blinkers for other windows.
(defun fix-blinkers (window)
  (flet ((fixit (w)
            (toggle-blinkers w (and (eq w window) (window-active-p w)))))
    (declare (dynamic-extent #'fixit))
    (map-windows #'fixit :include-windoids t)))

; Need to make sure that the blinker is off when a click-to-type-windoid is shown
(defmethod window-show :after ((w click-to-type-windoid))
  (toggle-blinkers w nil))

; And that another window is selected when a click-to-type-windoid is hidden
; (or closed)
(defmethod window-hide :after ((w click-to-type-windoid))
  (when (or (eq w *last-mouse-click-window*)
            (null *last-mouse-click-window*))
    (fix-blinkers (setq *last-mouse-click-window* (front-window)))))

; Blinkers in subviews normally get turned on.
(defmethod view-activate-event-handler :after ((w click-to-type-windoid))
  (unless (eq w *last-mouse-click-window*)
    (toggle-blinkers w nil)))

; Another auxiliary function to make a windoid with a single fred-dialog-item.
(defun make-example-windoid (&key (class 'click-to-type-windoid)
                                  position size
                                  (window-show t))
  (let ((w (make-instance class :window-show nil)))
    (if position (set-view-position w position))
    (if size (set-view-size w size))
    (make-instance 'fred-dialog-item
                   :view-container w
                   :view-size #@(100 16)
                   :view-position #@(5 5))
    (if window-show (window-show w))
    w))

#|
; Make two example click-to-type-windoids.
; Play with clicking in them and in this window.
(let* ((w (make-example-windoid))
       (pos (view-position w))
       (size (view-size w)))
  (make-example-windoid :position (add-points pos (make-point (point-h size) 0))))
|#

; An X-WINDOID behaves like a window in the X-WINDOWS system:
; it is active if the mouse is in it.
(defclass x-windoid (windoid) ())
 
; Return the window that is under the mouse.
(defun mouse-window ()
  (rlet ((wptr :pointer))
    (#_FindWindow (view-mouse-position nil) wptr)
    (%setf-macptr wptr (%get-ptr wptr))
    (window-object wptr)))

; This variable is bound by the first windoid to call MOUSE-WINDOW, so
; that MOUSE-WINDOW needs to be called only once per event.
(defvar *mouse-window* nil)

(defvar *active-x-windoid* nil)

; WINDOW-EVENT binds *MOUSE-WINDOW* so that it needs to be computed only
; once per event.
(defmethod window-event :around ((w x-windoid))
  (let* ((*mouse-window* (or (mouse-window) t)))
    (call-next-method)))

(defmethod accept-key-events ((w x-windoid))
  (let* ((mouse-window (or *mouse-window* (mouse-window)))
         (new-active (if (typep mouse-window 'x-windoid)
                       (if (eq w mouse-window) w *active-x-windoid*)
                       (front-window))))
    (unless (eq new-active *active-x-windoid*)
      (fix-blinkers (setq *active-x-windoid* new-active)))
    (eq w mouse-window)))

(defmethod window-hide :after ((w x-windoid))
  (if (eq w *active-x-windoid*)
    (fix-blinkers (setq *active-x-windoid*
                        (setq *last-mouse-click-window* (front-window))))))

; Blinkers in subviews normally get turned on.
(defmethod view-activate-event-handler :after ((w x-windoid))
  (unless (eq w *active-x-windoid*)
    (toggle-blinkers w nil)))

(provide "WINDOID-KEY-EVENTS")

#|
; Make two example X-WINDOIDs.
; Play with moving the mouse in and out of them.
; Note that if the mouse is in one of the windoids, it will respond to typing.
(let* ((w (make-example-windoid :class 'x-windoid :window-show nil))
       (size (view-size w))
       (pos (+ (view-position w) (make-point 0 (point-v size)))))
  (set-view-position w pos)
  (window-show w)
  (make-example-windoid 
   :class 'x-windoid
   :position (add-points pos (make-point (point-h size) 0))))
|#