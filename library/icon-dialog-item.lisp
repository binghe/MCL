; -*- Mode:Lisp; Package:CCL; -*-

;;	Change History (most recent first):
;;  1 2/17/95  slh  new in project
;;  (do not edit before this line!!)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  icon-dialog-item.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  this file defines icon dialog items which work like buttons.
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  Change Log
;;  
;;
;; 06/18/94   bill    view-click-event-handler now works if the icon is not
;;                    a direct subview of its window.
;; ------------------ 3.0d13
;; 10/29/92   ????    view-draw-contents - heed enabled-p
;; 11/13/92   bill    "icon record" -> "icon handle" in plot-icon documentation   
;; 10/09/92   Cornell PLOT-ICON's first call to ERROR needed the icon argument.
;; ------------------ 2.0
;; 01/23/92   Matthew Cornell (cornell@cs.umass.edu): Defined an :after
;;                  method to (setf icon) that redraws the icon.
;; 12/18/91   bill  view-default-size, set-view-size
;; ---------------  2.0b4
;; 10/21/91   bill  New traps, :color-p initarg, don't cons macptr's
;;  8/22/90   Amy Bruckman         asb@media-lab.media.mit.edu
;;            Ported to 2.0.
;;           


(in-package :ccl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(*stop-icon* *note-icon* *warn-icon* icon-dialog-item)
          :ccl))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  plot-icon
;;
;;  a function for displaying icons.  It can be passed a pointer or a number
;;    if passed a pointer, it assumes this is a pointer to an icon handle.
;;    if passed a number, it assumes this is the resource id of an icon.
;;    Draws to the current grafport, so call it inside WITH-FOCUSED-VIEW.

(defun plot-icon (icon point size &optional color-p disabled-p)
  "draws icon at point with given size"
  (unless (or (typep icon 'fixnum)
              (pointerp icon))
    (error "~s is not a valid icon (not a resource-id or pointer" icon))
  (with-macptrs ((resource (%null-ptr)))        ; don't cons macptr's
    (without-interrupts
     (when (typep icon 'fixnum)
       (if color-p
         (%setf-macptr resource (#_getCicon icon))
         (%setf-macptr resource (#_geticon icon)))
       (when (%null-ptr-p resource)
         (error "no icon resource with id ~s ." icon))
       (setq icon resource))
     (rlet ((r :rect                         ;allocate a rectangle
               :topleft point
               :bottomright (add-points point size))
            (ps :penstate))         
       (if color-p
         (#_plotCicon r icon)
         (#_ploticon r icon))
       (when disabled-p
         (#_GetPenState ps)
         (#_PenPat *gray-pattern*)
         (#_PenMode 11)
         (#_PaintRect r)
         (#_SetPenState ps))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  read in the three icons from system file and bind them to global variables.
;;

(defconstant *stop-icon* 0)
(defconstant *note-icon* 1)
(defconstant *warn-icon* 2)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  icon-dialog-item
;;
;;  the new class inherits from dialog-item
;;
;;

(defclass icon-dialog-item (dialog-item)
  ((icon :initform *note-icon* :initarg :my-icon :initarg :icon :accessor icon)
   (color-p :initform nil :initarg :color-p :accessor color-p)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  (setf icon) :after
;;

(defmethod (setf icon) :after (icon (item icon-dialog-item))
  "Invalidates item so that the new icon is drawn."
  (declare (ignore icon))
  (invalidate-view item t))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  view-default-size
;;

(defmethod view-default-size ((view icon-dialog-item))
  #@(32 32))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  set-view-size
;;  The default method does not invalidate the old rectangle
;;

(defmethod set-view-size :before ((view icon-dialog-item) h &optional v)
  (declare (ignore h v))
  (invalidate-view view))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  view-draw-contents
;;
;;this is the function called by the system whenever it needs to draw the item
;;
;;

(defmethod view-draw-contents ((item icon-dialog-item)) 
  (plot-icon (icon item) (view-position item) 
             (view-size item) (color-p item)
             (not (dialog-item-enabled-p item))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  view-click-event-handler
;;  
;;
;;  this function is called whenever the user clicks in the dialog item.  It
;;  is called on mouse-down, not on mouse-up.
;;
;;  the version defined below tracks the mouse, inverting the icon as long
;;  as the mouse is over it.  If the user releases the mouse-button while the
;;  the mouse is over the icon, the icon's dialog-item-action is called.
;;
;;

(defmethod view-click-event-handler ((item icon-dialog-item) where)
  (declare (ignore where))
  (let* ((pos (view-position item))
         (inverted-p nil)               ;true when the mouse is over the icon
         (container (view-container item)))
    (with-focused-view container        ;Draw in the container's coordinates
      (rlet ((temp-rect :rect           ;temporarily allocate a rectangle
                        :topLeft pos
                        :botRight (add-points pos (view-size item))))
        (without-interrupts                
         (#_invertrect temp-rect)       ;initially invert the icon.
         (setq inverted-p t)
         (loop                          ;loop until the button is released
           (unless (mouse-down-p)
             (when inverted-p           ;if button released with mouse
                                        ;  over the icon, run the action
               (dialog-item-action item)
               (#_invertrect temp-rect)
               (setq inverted-p nil))
             (return-from view-click-event-handler))
           (if (#_PtInRect
                (view-mouse-position container)
                temp-rect)           ;is mouse over the icon's rect?
             (unless inverted-p              ;yes, make sure it's inverted.
               (#_invertrect temp-rect)
               (setq inverted-p t))    
             (when inverted-p                ;no, make sure it's not inverted.
               (#_invertrect temp-rect)
               (setq inverted-p nil)))))))))



(provide 'icon-dialog-item)
;(pushnew :icon-dialog-item *features*)


#|
;;a sample call

(make-instance 'dialog
       :view-size #@(244 84)
       :window-title "Icons"
       :view-position #@(150 125)
       :window-type :document
       :view-subviews
       (list
        (make-dialog-item 'icon-dialog-item
                          #@(10 10)
                          #@(32 32)
                          "Untitled"
                          #'(lambda (item)
                            item
                              (format *top-listener* "Hello stranger.")))
        (make-dialog-item 'icon-dialog-item
                          #@(60 10)
                          #@(32 32)
                          "Untitled"
                          #'(lambda (item)
                              item
                              (format *top-listener* "That tickles!"))
                          :icon *stop-icon*)
        (make-dialog-item 'icon-dialog-item
                          #@(110 10)
                          #@(32 32)
                          "Untitled"
                          #'(lambda (item)
                              item
                              (format *top-listener* "Wow!"))
                          :icon *warn-icon*)
        (make-dialog-item 'icon-dialog-item
                          #@(170 10)
                          #@(64 64)
                          "Untitled"
                          #'(lambda (item)
                              item
                              (format *top-listener* "Scaling icons doesn't always look great."))
                          :icon *note-icon*)))


|#

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
