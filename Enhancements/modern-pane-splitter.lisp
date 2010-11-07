;;-*- mode: lisp; package: ccl -*-
;; xcode and Terminal style pane splitter, although nicer...
;;
; Terje Norderhaug, November 2010
;; Public domain, no copyright nor warranty. Use as you please and at your own risk.

;; Note: Do NOT load modern-mcl afterwards as it redefines these methods.

(in-package :ccl)

(defmethod view-draw-contents ((item pane-splitter))
  (let* ((active-p (window-active-p (view-window item)))
         (direction (scroll-bar-direction item))
         (len (ecase direction
                      (:horizontal (point-h (view-size item)))
                      (:vertical (point-v (view-size item)))))
         (compact-p (< len 12))
         (margin (max 1 (1- (floor (- len 8) 2))))
         (*white-color* #xF8F8F8)
         (*dark-gray-color* #x505050)
         (*gray-color* #xA0A0A0))
    (flet ((set-pen (brush &optional inactive-brush)
             (#_setThemePen (if (draw-active-p item) brush (or inactive-brush  brush))
              (view-pixel-depth item) (view-color-p item)))) 
      (with-item-rect (r item)
        (ecase direction
          (:horizontal
           (decf (pref r :rect.bottom)))
          (:vertical
           (decf (pref r :rect.right))))
        (cond
         (compact-p
          (with-fore-color (if active-p *dark-gray-color* *gray-color*)
            (set-pen #$kThemeBrushBevelActiveDark #$kThemeBrushBevelInactiveDark) ;; #$kThemeBrushFocusHighlight ; <- nice!
            (#_paintrect r)))
         (T
          (#_DrawThemePlacard r (appearance-theme-state item))
          (inset-rect r 1 1)
          (incf (pref r :rect.right))
          (with-fore-color *dark-gray-color*
            (set-pen #$kThemeBrushBevelActiveDark #$kThemeBrushBevelInactiveDark) 
            (inset-rect r margin margin)
            (#_paintrect r))
          (with-fore-color *gray-color*
            (set-pen #$kThemeBrushDocumentWindowBackground) 
            (inset-rect r 1 1)
            (ecase (scroll-bar-direction item)
              (:horizontal
               (incf (pref r :rect.top))
               (setf (pref r :rect.right)
                     (+ (pref r :rect.left) 3))
               (#_paintrect r)
               (offset-rect r 4 0)
               (#_paintrect r))
              (:vertical        
               (incf (pref r :rect.top))
               (setf (pref r :rect.bottom)
                     (+ (pref r :rect.top) 2))
               (#_paintrect r)
               (offset-rect r 0 3)
               (#_paintrect r))))))))))

(defparameter *pane-splitter-length* 14)

(defmethod initialize-instance ((item scroll-bar-dialog-item) &rest initargs
                                &key (min 0) 
                                (max (if t 10000 100))  ;; was + $scroll-bar-max $scroll-bar-max
                                (setting 0)
                                width
                                (direction :vertical) length scrollee
                                pane-splitter-cursor pane-splitter-class
                                pane-splitter (pane-splitter-length *pane-splitter-length*) view-size
                                view-position view-container)
  (declare (dynamic-extent initargs))
  (setq max (max min max)
        setting (min (max setting min) max))
  (if (and view-size (or length width))
    (error "Both ~s and ~s were specified."
           ':view-size (if length :length :width)))
  (unless length
    (setq length
          (if view-size
            (ecase direction
              (:vertical (point-v view-size))
              (:horizontal (point-h view-size)))
            100)))
  (unless width
    (setq width
          (if view-size
            (ecase direction
              (:vertical (point-h view-size))
              (:horizontal (point-v view-size)))
            16)))
  (when pane-splitter
    (when (not pane-splitter-cursor)
      (setq pane-splitter-cursor
            (case direction
              (:vertical
               (case pane-splitter
                 (:top *top-ps-cursor*)
                 (t *bottom-ps-cursor*)))
              (t
               (case pane-splitter
                 (:left *left-ps-cursor*)
                 (t *right-ps-cursor*))))))
    (let* ((splitter (make-instance (or pane-splitter-class 'pane-splitter) 
                                    :direction direction
                                    :width width
                                    :cursor pane-splitter-cursor
                                    :length (or pane-splitter-length *pane-splitter-length*)
                                    :scroll-bar item
                                    :scrollee scrollee))
           (size (view-size splitter))
           (h (point-h size))
           (v (point-v size)))
      (setf (pane-splitter item) splitter)
      (if (eq direction :vertical)
        (progn
          (decf length v)
          (when view-position
            (let ((p-h (point-h view-position))
                  (p-v (point-v view-position)))
              (if (eq pane-splitter :top)
                (progn
                  (set-view-position splitter view-position)
                  (setq view-position (make-point p-h (+ p-v v))))
                (progn
                  (set-view-position splitter p-h (+ p-v length)))))))
        (progn
          (decf length h)
          (when view-position
            (let ((p-h (point-h view-position))
                  (p-v (point-v view-position)))
              (if (eq pane-splitter :left)
                (progn
                  (set-view-position splitter view-position)
                  (setq view-position (make-point (+ p-h h) p-v)))
                (progn
                  (set-view-position splitter (+ p-h length) p-v)))))))))  
  (apply #'call-next-method
         item
         :min min
         :max max
         :setting setting
         :direction direction
         :length length
         :view-container nil
         :view-position view-position
         :view-size
         (case direction
           (:vertical (make-point width length))
           (:horizontal (make-point length width))
           (t (error "illegal :direction ~a (must be :vertical or :horizontal)."
                     direction)))
         initargs)
  (when (and pane-splitter view-container (not view-position))
    (set-default-size-and-position item view-container)
    ;(set-view-position item (view-position item))
    )
  (when view-container
    (set-view-container item view-container))
  (when scrollee
    (add-view-scroll-bar scrollee item)))
