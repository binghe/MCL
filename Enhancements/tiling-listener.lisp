;;-*- mode: lisp; package: ccl -*-
;; Tiling listener
;;
; Terje Norderhaug, July 2009. 
;; Public domain, no copyright nor warranty. Use as you please and at your own risk.


#|
Terje, Feb 2010: In MCL 5.2.x, the method window-make-parts on fred-window finds its default window position by calling #'new-window-number instead of view-default-position. This creates problems for subclasses such as the listener, which will get their positions depending on the editor windows, without ability to override with view-default-position.

It would be better if window-make-parts on fred-window called a view-default-position containing the same new-window-number functionality. That way, subclasses can have their own positioning mechanisms. Implementation below.
|# 


(in-package :ccl)

(defmethod window-make-parts ((w fred-window) &rest initargs
                              &key
                              filename
                              buffer
                              scratch-p
                              window-title wptr
                              view-position
                              view-font                                       
                              track-thumb-p
                              h-pane-splitter
                              v-pane-splitter
                              save-buffer-p
                              wrap-p
                              word-wrap-p
                              justification
                              line-right-p
                              (buffer-chunk-size #x1000)
                              copy-styles-p
                              text-edit-sel-p
                              history-length
                              part-color-list
                              comtab
                              (h-scrollp t)
                              (v-scrollp t)
                              (mini-buffer-p t)
                              (fred-item-class *default-fred-item-class*)
                              &aux win-p)
  (declare (dynamic-extent initargs))
  ; :SCRATCH-P means never "needs saving", i.e. don't offer to save, don't
  ;            show modified marker in title.
  (let* ((wptr-arg wptr)
         (file filename)) ; huh?
    (unwind-protect
      (progn
        (apply #'call-next-method
               w
               :window-title
               (or window-title
                   (unless file (new-window-title)))
               initargs)
        (setq wptr (wptr w))
        (let* ((w-size (view-size w))
               (h (point-h w-size))
               (v (point-v w-size))
               (mini-height 15)
               )          
          (setf 
           (ordered-subviews w)
           (list*
            (prog1
            (make-instance 'scrolling-fred-view
              :view-container w
              :view-size (make-point (+ h 2) (+ v 2 0)) ; (add-points w-size #@(0 0)) ; huh
              :view-position #@(-1 -1)
              ;:margin 3
              ;:draw-outline nil
              ;:draw-scroller-outline t
              :grow-box-p (null mini-buffer-p)
              :view-font view-font
              :filename filename
              :buffer buffer
              :h-scroll-fraction 4
              :fred-item-class fred-item-class
              :track-thumb-p track-thumb-p
              :bar-dragger  nil ;(if v-scrollp :vertical)
              :h-pane-splitter h-pane-splitter
              :v-pane-splitter v-pane-splitter
              :comtab comtab  ; or here
              :save-buffer-p save-buffer-p
              :wrap-p wrap-p
              :word-wrap-p word-wrap-p
              :justification justification
              :line-right-p line-right-p
              :buffer-chunk-size buffer-chunk-size
              :copy-styles-p copy-styles-p
              :history-length history-length
              :text-edit-sel-p text-edit-sel-p
              :part-color-list part-color-list
              :h-scrollp h-scrollp
              :v-scrollp v-scrollp)
              )
            (when mini-buffer-p
              (list
               (make-instance 'new-mini-buffer
                 :view-nick-name 'mini-buffer
                 :view-container w
                 :view-font *mini-buffer-font-spec*
                 :view-size (make-point (+ h 2 (- (max 64 (truncate h 4)))) (+ mini-height 1))
                 :view-position (make-point -1 (- v mini-height))
                 ;:draw-scroller-outline t
                 ;:fred-item-class 'fred-item
                 ;:draw-outline -1
                 :h-scrollp nil     
                 :v-scrollp nil                 
                 ;:h-scroll-fraction 4
                 :grow-box-p t ; leave room for poof button or grow-box
                 :poof-button t
                 :history-length 2
                 :buffer-chunk-size 256
                 :view-font view-font
                 :track-thumb-p t))))))
        (when file
          (set-window-filename w (setq file (window-filename w)))
          (set-file-external-format w (utf-something-p filename)))
        (when scratch-p
          (setf (slot-value (current-key-handler w) 'file-modcnt) t))          
        (when  (and file *save-fred-window-positions*)
          (view-restore-position (window-key-handler w) file))
        (when (and (not file) (not view-position))
          (set-view-position w (view-default-position w))
          (window-ensure-on-screen w)
          #+ignore
          (let () ;(title (window-title w)))
            (when t ;(string-equal "new" title )
              (multiple-value-bind (idx pos)(new-window-number)
                (when (not (eql idx 0))
                  (set-view-position w (+ (point-h pos) 10)(+ (point-v pos) 15))
                  ; ok so they stop tiling after 12 on rgb monitor
                  (window-ensure-on-screen w))))))
        (setq win-p t))

      (unless win-p
        (unless wptr-arg (window-close w)))
      )))

;; new:

(defmethod view-default-position ((w fred-window))
  (multiple-value-bind (idx pos)(new-window-number)
    (or
     (when (not (eql idx 0))
       (make-point (+ (point-h pos) 10)(+ (point-v pos) 15)))
     (call-next-method))))

;; new:

(defparameter *window-tiling* #@(20 20))

;; in l1-listener.lisp


(defmethod view-default-position ((w listener) &aux (front (front-window :class 'listener)))
  (if (and *window-tiling* front)
    (loop 
      with top = (view-position front)
      with listeners = (windows :class 'listener)
      for i from 1 to 100
      for pos = (add-points top (make-point (* i (point-h *window-tiling*))
                                            (* i (point-v *window-tiling*))))
      unless (find pos listeners :key #'view-position :test #'eql)
      return (or pos *listener-window-position*))
    *listener-window-position*))

#+ignore ; works, but maybe too clever
(defmethod view-default-position ((w listener))
  (if *window-tiling*
    (let ((listeners (windows :class 'listener))
          (top (front-window :class 'listener)))
      (flet ((rightmost (w1 w2)
               (if (> (point-h (view-position w1))
                      (point-h (view-position w2)))
                 w1 w2))
             (available (position)
               (unless (find position listeners :key #'view-position :test #'eql)
                 position)))
        (or (available (when top (add-points (view-position top) *window-tiling*)))
            (let ((best (reduce #'rightmost listeners)))
              (when best
                (add-points (view-position best)
                            *window-tiling*)))
            *listener-window-position*)))
    *listener-window-position*))
