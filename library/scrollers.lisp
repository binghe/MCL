; -*- Mode:Lisp; Package:CCL; -*-

;;	Change History (most recent first):
;;  2 10/5/97  akh  see below
;;  (do not edit before this line!!)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  scrollers.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  code for views with scroll bars.
;;

;;;;;;;;;;;;;
;;
;; Modification History
;;
;; 10/18/98 akh add grow-icon-p to scroller-mixin - from Terje Norderhaug
;; -------------- 4.2
;; 09/16/97 akh  view-contains-point-p ((dialog-item box-dialog-item) return nil - from Terje N.
;; 05/03/93 bill add scroll-bar-pane. Export symbols.
;;               To do. Remove necessity for the scroller of a scroller-pane
;;               to have scroller-mixin mixed in (assuming this is possible)
;; ------------- 2.1d5
;; 02/25/93 bill add scroll-bar-scroll-size method and use it in update-scroll-bar-limits
;;               (thanx to Jeffrey B Kane)
;; ------------- 2.0
;; 01/06/92 bill fix bug in reposition-scroll-bars.
;;               scroll-bar-limits now positions, at full scroll, the lower
;;               right-hand corner of the field-size at the lower
;;               right-hand corner of the display. It used to place the
;;               lower right-hand corner of the field-size at the
;;               upper left-hand corner of the display.
;;               Scroll bars are now disabled when the entire
;;               field-size is visible and the view is scrolled to 0.
;; 07/29/91 bill set-view-scroll-position does update-thumbs (thanks to Christopher Owens)
;;

(in-package :ccl)

(export '(scroller-mixin scroller scroller-pane
          scroll-bar-limits normal-scroll-bar-limits
          scroll-bar-page-size scroll-bar-scroll-size
          update-scroll-bars update-scroll-bar-limits
          update-thumbs reposition-scroll-bars scroll-bar-changed))

(require 'scroll-bar-dialog-items)

(defclass box-dialog-item (simple-view) ())

(defmethod point-in-click-region-p ((self box-dialog-item) point)
  (declare (ignore point))
   nil)

(defmethod view-contains-point-p ((dialog-item box-dialog-item) point)
  "Hide the box dialog item from attention"
  (declare (ignore  point)))

(defmethod view-draw-contents ((self box-dialog-item))
  (let* ((pos (view-position self))
        (end (add-points pos (view-size self))))
    (rlet ((r :rect
              :topleft pos
              :bottomright end))
      (#_FrameRect r))))

(defclass scroller-mixin ()
  ((v-scroller :accessor v-scroller)
   (h-scroller :accessor h-scroller)
    ;; ## GROW-ICON-P ADDED:
   (grow-icon-p :reader grow-icon-p :initarg :grow-icon-p :initform NIL)
   (field-size :initarg :field-size :initform nil :reader field-size)
   (scroller-outline :accessor scroller-outline)
   (scroll-bar-correction :accessor scroll-bar-correction)))

(defclass scroller (scroller-mixin view) ())

(defmethod initialize-instance ((self scroller-mixin) &rest initargs &key
                                view-container (v-scrollp t) (h-scrollp t)
                                (draw-scroller-outline t)
                                track-thumb-p
                                (scroll-bar-class 'scroll-bar-dialog-item)
                                h-scroll-class v-scroll-class)
  (declare (dynamic-extent initargs))
  (setf (v-scroller self) nil)          ; fix start-up transient.
  (setf (h-scroller self) nil)
  (apply #'call-next-method self :view-container nil initargs)   ; delay the set-view-container
  (let* ((v-scroll (if v-scrollp
                     (make-instance (or v-scroll-class scroll-bar-class)
                                    :scrollee self
                                    :direction :vertical
                                    :track-thumb-p track-thumb-p)))
         (h-scroll (if h-scrollp
                     (make-instance (or h-scroll-class scroll-bar-class)
                                    :scrollee self
                                    :direction :horizontal
                                    :track-thumb-p track-thumb-p)))
         (outline (if draw-scroller-outline
                    (make-instance 'box-dialog-item))))
    (setf (scroll-bar-correction self) (make-point (if v-scroll 17 2)
                                             (if h-scroll 17 2)))
    (setf (v-scroller self) v-scroll)
    (setf (h-scroller self) h-scroll)
    (setf (scroller-outline self) outline)
    (if (and (view-position self) (view-size self))
      (update-scroll-bars self :length t :position t))
    (when view-container
      (set-view-container self view-container))))

;; This is how a view communicates it's scroll bar limits to a scroller.
;; Returns two points, the limits for the horizontal & vertical scroll bars
;; This is the coordinate system passed to set-view-scroll-position

(defmethod scroll-bar-limits ((view scroller-mixin))
  (let ((field-size (field-size view))
        (size (view-size view))
        (h-scroller (h-scroller view))
        (v-scroller (v-scroller view)))
    (if field-size
      (values (make-point 0 (max (if h-scroller (scroll-bar-setting h-scroller) 0)
                                 (- (point-h field-size) (point-h size))))
              (make-point 0 (max (if v-scroller (scroll-bar-setting v-scroller) 0)
                                 (- (point-v field-size) (point-v size)))))
      (let ((size (view-size view)))
        (normal-scroll-bar-limits view (add-points size size))))))

(defmethod normal-scroll-bar-limits ((view scroller-mixin) max-h &optional max-v)
  (let ((size (view-size view))
        (max (make-point max-h max-v)))
    (values (make-point 0 (max 0 (- (point-h max) (point-h size))))
            (make-point 0 (max 0 (- (point-v max) (point-v size)))))))

;; And here's how a view communicates it's page size
;; Returns a point.
(defmethod scroll-bar-page-size ((view scroller-mixin))
  (view-size view))

(defmethod scroll-bar-scroll-size ((self scroller-mixin))
  (let ((h-scroller (h-scroller self))
        (v-scroller (v-scroller self)))
    (make-point (if h-scroller (scroll-bar-scroll-size h-scroller) 0)
                (if v-scroller (scroll-bar-scroll-size v-scroller) 0))))

(defmethod set-view-container ((self scroller-mixin) new-container)
  (let ((need-to-update? (not (and (view-position self) (view-size self)))))
    (call-next-method)
    (when (v-scroller self)  (set-view-container (v-scroller self) new-container))
    (when (h-scroller self)  (set-view-container (h-scroller self) new-container))
    (when (scroller-outline self)  
      (set-view-container (scroller-outline self) new-container))
    (when need-to-update?
      (update-scroll-bars self :length t :position t))
    new-container))

(defmethod set-view-position ((self scroller-mixin) h &optional v)
  (declare (ignore h v))
  (without-interrupts
   (prog1
     (call-next-method)
     (update-scroll-bars self :position t))))

(defmethod set-view-size ((self scroller-mixin) h &optional v)
  (declare (ignore h v))  
  (without-interrupts
   (prog1
     (call-next-method)
     (update-scroll-bars self :length t :position t))))

(defmethod update-scroll-bars ((self scroller-mixin) &key length position)
  (let* ((pos (view-position self))
         (size (view-size self))
         (h-scroller (h-scroller self))
         (v-scroller (v-scroller self))
         (outline (scroller-outline self)))
    (when (and pos size)                ; auto-sizing may not have happenned yet 
      (without-interrupts
       (reposition-scroll-bars self h-scroller v-scroller :length length :position position)
       (when length
         (update-scroll-bar-limits self h-scroller v-scroller))
       (when outline
         (setq pos (subtract-points pos #@(1 1))
               size (add-points size (scroll-bar-correction self)))
         (set-view-position outline pos)
         (set-view-size outline size))))))

(defmethod update-scroll-bar-limits ((self scroller-mixin) &optional
                                     (h-scroller (h-scroller self))
                                     (v-scroller (v-scroller self)))
  (multiple-value-bind (h-limits v-limits) (scroll-bar-limits self)
    (let ((page-size (scroll-bar-page-size self))
          (scroll-size (scroll-bar-scroll-size self)))
      (when  h-scroller
        (set-scroll-bar-min h-scroller (point-h h-limits))
        (set-scroll-bar-max h-scroller (point-v h-limits))
        (setf (scroll-bar-page-size h-scroller) (point-h page-size))
        (setf (scroll-bar-scroll-size h-scroller) (point-h scroll-size)))
      (when v-scroller
        (set-scroll-bar-min v-scroller (point-h v-limits))
        (set-scroll-bar-max v-scroller (point-v v-limits))
        (setf (scroll-bar-page-size v-scroller) (point-v page-size))
        (setf (scroll-bar-scroll-size v-scroller) (point-v scroll-size))))))

;; Call this whenever the thumb position changes.
(defmethod update-thumbs ((self scroller-mixin))
  (let ((pos (view-scroll-position self))
        (h-scroller (h-scroller self))
        (v-scroller (v-scroller self))
        (update-limits? nil))
    (when (and h-scroller
               (not (eql (scroll-bar-setting h-scroller) (point-h pos))))
      (when (eql (scroll-bar-min h-scroller)
                 (set-scroll-bar-setting h-scroller (point-h pos)))
        (setq update-limits? t)))
    (when (and v-scroller
               (not (eql (scroll-bar-setting v-scroller) (point-v pos))))
      (when (eql (scroll-bar-min v-scroller)
                 (set-scroll-bar-setting v-scroller (point-v pos)))
        (setq update-limits? t)))
    (when update-limits? (update-scroll-bar-limits self))))

; Seperate from update-scroll-bars so that users can specialize it.
(defmethod reposition-scroll-bars ((self scroller-mixin) h-scroller v-scroller &key length position)
  (let* ((pos (view-position self))
         (size (view-size self))
         (width (point-h size))
         (height (point-v size))
         (grow-icon-p (grow-icon-p self)))
    (when (and pos size)                ; auto-sizing may not have happenned yet 
      (without-interrupts
       (when h-scroller
         (when position
           (set-view-position h-scroller (add-points pos (make-point -1 height))))
         (when length
           (set-scroll-bar-length h-scroller
            ;; ## WIDTH ADJUSTED IF A GROW ICON:
             (+ 2 width (if (and grow-icon-p (not v-scroller)) -14 0)))))
       (when v-scroller
         (when position
           (set-view-position v-scroller (add-points pos (make-point width -1))))
         (when length
           (set-scroll-bar-length v-scroller
                                  ;; height ADJUSTED IF A GROW ICON:
              (+ 2 height (if (and grow-icon-p (not h-scroller)) -14 0)))))))))
 
(defmethod scroll-bar-changed ((view scroller-mixin) scroll-bar)
  (let* ((new-value (scroll-bar-setting scroll-bar))
         (horizontal-p (eq (scroll-bar-direction scroll-bar) :horizontal))
         (old-pos (view-scroll-position view)))
    (set-view-scroll-position 
     view
     (if horizontal-p
       (make-point new-value (point-v old-pos))
       (make-point (point-h old-pos) new-value)))
    (when (eql new-value (scroll-bar-min scroll-bar))
      (update-scroll-bar-limits view)))
  (window-update-event-handler (view-window view)))

(defmethod set-view-scroll-position ((view scroller-mixin) h &optional v scroll-visibly)
  (declare (ignore h v scroll-visibly))
  (prog1
    (call-next-method)
    (update-thumbs view)))

;;;;;;;;;;;;;;;;;;;;;
;;
;; scroller-pane is the easiest way to use a scroller
;; It packages up a scroller and two scroll bars into a single
;; view. The scroller should have scroll-bar-mixin mixed in.
;;
(defclass scroller-pane (view)
  ((scroller :accessor scroller)
   (scroller-outline :accessor scroller-outline :initarg :scroller-outline)
   (draw-scroller-outline
    :accessor draw-scroller-outline
    :initarg :draw-scroller-outline)))

(defmethod v-scroller ((pane scroller-pane))
  (v-scroller (scroller pane)))

(defmethod h-scroller ((pane scroller-pane))
  (h-scroller (scroller pane)))

(defmethod field-size ((pane scroller-pane))
  (field-size (scroller pane)))

(defmethod initialize-instance ((self scroller-pane) &rest initargs &key
                                ; These args are used locally
                                view-position view-size view-container
                                view-nick-name
                                (draw-scroller-outline t)
                                (scroller-class 'scroller)
                                ; The rest of the args are passed through
                                ; to the scroller
                                (v-scrollp t) (h-scrollp t)
                                track-thumb-p
                                scroll-bar-class h-scroll-class v-scroll-class)
  (declare (dynamic-extent initargs))
  (declare (ignore track-thumb-p scroll-bar-class h-scroll-class v-scroll-class))
  (call-next-method
   self
   :view-container nil                  ; set container later
   :draw-scroller-outline draw-scroller-outline
   (if view-position :view-position :ignore) view-position
   (if view-size :view-size :ignore) view-size
   (if view-nick-name :view-nick-name :ignore) view-nick-name)
  (multiple-value-bind (scroller-size scroller-position)
                       (scroller-size-and-position self h-scrollp v-scrollp)
    (remf initargs :scroller-class)
    (setf (scroller self)
          (apply #'make-instance
                 scroller-class
                 :view-position scroller-position
                 :view-size scroller-size
                 :draw-scroller-outline nil
                 :view-container self
                 :view-nick-name nil
                 initargs)))
  (when view-container
    (set-view-container self view-container))
  self)
    
(defmethod scroller-size-and-position ((self scroller-pane) h-scrollp v-scrollp)
  (let ((scroller-size (view-size self))
        (scroller-position #@(0 0)))
    (when scroller-size
      (when h-scrollp
        (setq scroller-size (subtract-points scroller-size #@(15 0))))
      (when v-scrollp
        (setq scroller-size (subtract-points scroller-size #@(0 15)))))
    (when (draw-scroller-outline self)
      (setq scroller-position #@(1 1)
            scroller-size (and scroller-size
                               (subtract-points scroller-size #@(2 2)))))
    (values scroller-size scroller-position)))

(defmethod scroll-bar-limits ((self scroller-pane))
  (scroll-bar-limits (scroller self)))

(defmethod scroll-bar-page-size ((self scroller-pane))
  (scroll-bar-page-size (scroller self)))

(defmethod scroll-bar-scroll-size ((self scroller-pane))
  (scroll-bar-scroll-size self))

(defmethod view-draw-contents :before ((self scroller-pane))
  (when (draw-scroller-outline self)
    (rlet ((rect :rect
                 :topleft #@(0 0)
                 :botright (view-size self)))
      (#_FrameRect rect))))

(defmethod set-view-size ((self scroller-pane) h &optional v)
  (declare (ignore h v))  
  (when (draw-scroller-outline self)
    (let* ((old-size (view-size self))
           (h (point-h old-size))
           (v (point-v old-size)))
      (invalidate-corners self (make-point 0 (1- v)) (make-point h v) t)
      (invalidate-corners self (make-point (1- h) 0) (make-point h v) t)))
  (prog1
    (call-next-method)
    (set-view-size (scroller self)
                   (scroller-size-and-position
                    self (h-scroller self) (v-scroller self)))))

(defmethod update-scroll-bars ((self scroller-pane) &key length position)
  (update-scroll-bars (scroller self) :length length :position position))

(defmethod update-scroll-bar-limits ((self scroller-pane) &optional
                                     (h-scroller (h-scroller self))
                                     (v-scroller (v-scroller self)))
  (update-scroll-bar-limits (scroller self) h-scroller v-scroller))

(defmethod update-thumbs ((self scroller-pane))
  (update-thumbs (scroller self)))

(defmethod scroll-bar-changed ((self scroller-pane) scroll-bar)
  (scroll-bar-changed (scroller self) scroll-bar))

(defmethod set-view-scroll-position ((view scroller-pane) h &optional v scroll-visibly)
  (set-view-scroll-position (scroller view) h v scroll-visibly))

(provide 'scrollers)   

#|
(require 'quickdraw)


;;;;;;;;;;;;;;;;;;;;;;
;;
;;  a dialog with a scroller in it
;;

(setq foo (make-instance 'dialog))

(defclass scroller1 (scroller) ())

(defmethod scroll-bar-limits ((view scroller1))
  (normal-scroll-bar-limits view 200 200))

(defmethod view-draw-contents ((self scroller1))
  (frame-rect self 10 10 50 50)
  (paint-oval self 30 30 200 200)
  (erase-oval self 30 30 70 70)
  (call-next-method))

(setq bar (make-instance 'scroller1
                 :view-container foo
                 :view-size #@(125 125)
                 :track-thumb-p t))

(set-view-position bar 30 30)
(set-view-position bar 00 00)
(set-view-position bar 05 05)

(set-view-size bar 150 150)

; How to make the same thing with a scroller-pane 
(setq pane (make-instance 'scroller-pane
             :scroller-class 'scroller1
             :view-size #@(125 125)
             :view-position #@(150 0)
             :track-thumb-p t
             :view-container foo))

;;;;;;;;;;;;;;;;;;;;;;
;;
;;  nested scrollers
;;

(setq dial (make-instance 'dialog))

(defclass scroller2 (scroller) ())

(defmethod scroll-bar-limits ((view scroller2))
  (normal-scroll-bar-limits view 300 300))

(defmethod view-draw-contents ((self scroller2))
  (frame-rect self 110 10 170 170)
  (call-next-method))

(setq first-scroller (make-instance 'scroller2
                            :view-container dial
                            :view-size #@(180 180)
                            :view-position #@(5 5)
                            :track-thumb-p t))


(defclass scroller3 (scroller) ())

(defmethod scroll-bar-limits ((view scroller3))
  (normal-scroll-bar-limits view 170 170))

(defmethod view-draw-contents ((self scroller3))
  (paint-oval self 10 10 70 70)
  (paint-oval self 70 70 170 170)
  (call-next-method))

(setq second-scroller (make-instance 'scroller3
                             :view-container first-scroller
                             :view-size #@(75 155)
                             :view-position #@(10 10)
                             :track-thumb-p t))


;;;;;;;;;;;;;;;;;;;;;;
;;
;;  scrollers with only one scroll bar
;;

(setq foo1 (make-instance 'dialog))

(defclass scroller4 (scroller) ())

(defmethod scroll-bar-limits ((view scroller4))
  (normal-scroll-bar-limits view 200 200))

(defmethod view-draw-contents ((self scroller4))
  (frame-rect self 10 10 50 50)
  (paint-oval self 30 30 200 200)
  (erase-oval self 30 30 70 70)
  (call-next-method))

(setq bar1 (make-instance 'scroller4 :grow-icon-p t
                 :view-container foo1
                 :h-scrollp nil))

(set-view-position bar1 50 50)
(set-view-size bar1 150 150)



(setq foo2 (make-instance 'dialog))
(setq bar2 (make-instance 'scroller4
                 :view-container foo2
                 :v-scrollp nil))

(set-view-position bar2 50 50)
(set-view-size bar2 125 125)

|#
