;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  8 9/13/96  akh  stream-tyo, -write-string, -tyi methods for fred-delegattion-mixin
;;  6 7/18/96  akh  dont remember
;;  5 3/9/96   akh  cursors for poof-button and bar-draggers
;;  4 1/28/96  akh  track-scroll-bar - ok if frec-pos-point is NIL
;;  3 11/19/95 gb   undo conditionalization of ADD-SCROLLER
;;  12 5/23/95 akh  find-frec-prev-page has another argument
;;  11 5/22/95 akh  v-scroll-bar in thumb sets start mark to line beginning - prevents bouncing up when scrolling down
;;  10 5/19/95 akh  take out debugging stuff
;;  9 5/19/95  akh  dont claim that buffer-size * scroll-bar-max is a fixnum
;;  8 5/5/95   akh  :direction => :split-view-direction
;;  6 4/28/95  akh  modify a comment
;;  4 4/24/95  akh  more initargs, do edit menu in window-show-cursor
;;  3 4/10/95  akh  default-comtab method
;;  2 4/4/95   akh  fred-delegation-mixin stuff
;;  4 3/20/95  akh  window-show-cursor is without-interrupts
;;  3 3/14/95  akh  use with-text-colors in more places
;;  2 3/2/95   akh  probably no change
;;  (do not edit before this line!!)

;; scrolling-fred-view.lisp
;; Copyright 1992-1994, Apple Computer, Inc.
;; Copyright 1995-2007 Digitool, Inc.
;;
;; 

;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; A SCROLLING-FRED-VIEW is a view containing one or 2 scrollbars and
;; a FRED-ITEM which is a subclass of fred-mixin and key-handler-mixin.
;;
;;
;;

;; Modification History
;;
;;
;; use a fred-item class with tsm-document-mixin
;; class scrolling-fred-view-with-frame includes focus-rect-mixin
;; view-click-event-handler of fred-v-scroll-bar do scrollup/downbutton in bigger chunks as time goes by
;; install-view-in-window sets bf.owner to window
;; ------ 5.2b5
;; (#_line :long #@(6 0)) -> (#_line 6 0) - lost a feature
;; frame-scrolling-fred-view uses draw-nil-theme-focus-rect
;; don't invalidate-view in activate/deactivate after methods
;; frame-scrolling-fred-view - lose kludge
;; lose duplicate def of set-view-position for dialog-item
;; add set-view-size/position methods for scrolling-fred-view-with-frame so works better when live resize window
;; fiddle with frame-scrolling-fred-view when in inactive window
;; bar-dragger draws gray if inactive
;; fix error in previous change
;; fudge scroll-bar-sizes for scrolling-fred-view-with-frame if osx-p
;; ------- 5.1b2
;; draw frame with-back-color
;; add class scrolling-fred-view-with-frame
;; bar-dragger gets gray background
;; 02/22/04 *fred-track-thumb-p* initially T.
;; 02/04/04 view-draw-contents - lose kludge
;; --- 5.1b1
;; 10/28/03 theme things don't require osx-p
;; _QDFlushPortBuffer in dialog-item-action for h and v scrollbars 
;; ------------ 5.0b3
;; fred-delegation-mixin is an input-stream
;; -------- 4.4b4
;; 06/01/02 view-draw-contents ((view scrolling-fred-view)) - kludge for theme-background
;; 05/17/02 add stream-read-sequence for fred-delegation-mixin from shannon spires
;; 05/06/02 another osx-p fix in track-scroll-bar for fred-h-scroll-bar
;; --------- 4.4b3
;; 05/11/01 akh track-scroll-bar fred-h-scroll-bar for osx crock
;; put back allow-other-keys for fred-item
;; ------- 4.3b1
;; 12/14/99 akh fred-item class default text-edit-sel-p t
;; -------- 4.3f1c1
;; 05/31/98 akh set-dialog-item-text does fred-update
;; 10/31/97 akh    initialize-instance :after ((item fred-item) - no more &allow-other-keys
;; 08/19/96 bill  (method set-view-size (scrolling-fred-view)) now returns the new size.
;; -------------  MCL-PPC 3.9
;;  4/25/95 slh   need in-package for file-compiler; require :fredenv
;;----
;; find-frec-previous-page quits at pos = 0
;; part-color-list for scrolling-fred-view delegates.
;; view-activate/deactivate for bar-dragger just invalidate-view
;; fred-update of fred-item calls fred-mixin method
;; draw-vertical-dragger factored out
;; fred-update calls window-update-event-handler if non-empty window-erase-region
;; dialog-item-action and track-scroll-bar for v-scroller use set-fred-display-start-mark
;; view-size-parts make fred-item full width when h-scroller, no v-scroller
;; bar-dragger size 1 pixel smaller, position 1 pixel lower, righter
;; no more allow-other-keys in initialize-instance scrolling-fred-view
;; no more default save-buffer-p t in fred-item - (maybe its ok)
;; 11/03/93 alice validate-view in view-activate-event-handler of bar-dragger
;; 10/17/93 alice view-activate-event-handler for scrolling-fred-view and fred-item not necessary.
;; 10/17/93 alice color-list slot moves to fred-mixin
;; 10/14/93 alice view-click-event-handler, view-key-event-handler, key-handler-idle,
;;		 set-view-size  move from fred-item to fred-mixin
;; 09/30/93 alice fred-item IS a simple view and fred-mixin is not (so key-handler-mixin precedes simple-view in cpl)
;;----
;; 07/15/93 alice fred-item gets copy-styles-p default per bill
;; 07/14/93 alice fred-class -> fred-item-class to correspond with doc
;; 07/13/93 alice rename this file and the class to be scrolling-fred-view
;; 07/10/93 alice nuke view-click-event-event-handler of scrolling-fdi. it was a noop.
;; 06/26/93 alice initialize-instance scrolling-fdi passes view-font to fred-item
;;		  rather than set-view-font later which had evil effects.
;; 05/05/93 bill  indentation
;; -------------- 2.1d5
;; 04/14/93 alice view-click-event-handler ((view scrolling-fred-view)
;;		dont change key handler ?? along with
;;		view-deactivate-event-handler ((item fred-item))
;;		don't deactivate scroll bars unless window is inactive
;; 02/xx/93 alice radically changed for UI makeover



(in-package :ccl) 

(eval-when (eval compile)
  (require :fredenv))

(export '(scrolling-fred-view fred-item) :ccl)
; currently need to provide a view-size or find-view-vacant-mumble for the scrollbars errors

(export '(*fred-track-thumb-p*) :ccl)

(defvar *fred-track-thumb-p* T)


(defclass fred-item (fred-mixin key-handler-mixin simple-view)
  ()
  (:default-initargs
    :text-edit-sel-p t
    :copy-styles-p t))

(defmethod default-comtab ((item fred-item))
  *comtab*)

(defclass fred-delegation-mixin (input-stream)())

(defclass scrolling-fred-view (fred-delegation-mixin view)
  ((scroll-bar-correction :initform #@(17 17) :accessor scroll-bar-correction)
   (grow-box-p :initarg :grow-box-p :initform nil :reader grow-box-p) ; just means leave room for it!
   (h-scroll-fraction :initform nil :initarg :h-scroll-fraction :accessor h-scroll-fraction) 
   (draw-scroller-outline :initarg :draw-scroller-outline :initform t :accessor draw-scroller-outline))   
  (:default-initargs
    ;:view-size nil
    :view-position nil
    :h-scroll-class 'fred-h-scroll-bar
    :v-scroll-class 'fred-v-scroll-bar
    :track-thumb-p *fred-track-thumb-p*
    :h-scrollp t
    :v-scrollp t
    :bar-dragger nil
    :h-pane-splitter nil
    :v-pane-splitter nil
    :view-font *fred-default-font-spec*
    :allow-returns t
    :allow-tabs t
    :margin 3   
    :text-edit-sel-p t  ; what is that?
    ;:save-buffer-p t    ; or else the darn text disappears when swapping containers (is fixed)
    ))

(defmethod view-deactivate-event-handler ((view scrolling-fred-view))
  (if (not (window-active-p (view-window view)))
    (call-next-method)
    (view-deactivate-event-handler (fred-item view))))

#|
(defmethod view-activate-event-handler ((view scrolling-fred-view))
  (view-activate-event-handler (fred-item view)))

(defmethod view-deactivate-event-handler ((item fred-item))
  (call-next-method)
  (when (not (window-active-p (view-window item)))  ; maybe?? - dont deactivate scroll bars
    (do-subviews (s (view-container item))
      (when (neq s item)
        (view-deactivate-event-handler s)))))

(defmethod view-activate-event-handler ((item fred-item))
  (call-next-method)
  (let ((c (view-container item)))
    (when c
      (do-subviews (s c)
        (when (neq s item)
          ;(print s)
          (view-activate-event-handler s))))))
|#

; &allow-other-keys because it gets all the initargs of scrolling-fred-view
; Scrolling-fred-view accepts all the initargs of fred-item 
#|
(defmethod initialize-instance :after ((item fred-item) &rest initargs
                                       &key dialog-item-text &allow-other-keys)
  (declare (ignore initargs))
  (when dialog-item-text (set-dialog-item-text item dialog-item-text)))
|#

;;; no mo &allow-other-keys - now we accept the initargs of scrolling-fred-view which we otherwise would not
(defmethod initialize-instance :after ((item fred-item) ;&rest initargs
                                       &key dialog-item-text
                                       ;; ignored ones
                                       h-scroll-fraction grow-box-p track-thumb-p
                                       fred-item-class h-scrollp v-scrollp h-scroll-class v-scroll-class
                                       bar-dragger h-pane-splitter v-pane-splitter
                                       POOF-BUTTON draw-scroller-outline view-scroll-position &allow-other-keys)
  ;(declare (ignore initargs))
  (declare (ignore h-scroll-fraction grow-box-p track-thumb-p
                   fred-item-class h-scrollp v-scrollp h-scroll-class v-scroll-class
                   bar-dragger h-pane-splitter v-pane-splitter POOF-BUTTON draw-scroller-outline
                   view-scroll-position))
  (when dialog-item-text (set-dialog-item-text item dialog-item-text)))


(defmethod initialize-instance :after ((item scrolling-fred-view) &key dialog-item-text)
  (when dialog-item-text (set-dialog-item-text item dialog-item-text)))

(defmethod frec ((view fred-delegation-mixin))
  (frec (fred-item view)))

(defmethod part-color-list ((view fred-delegation-mixin))
  (part-color-list (fred-item view)))

(defmethod set-dialog-item-text ((view scrolling-fred-view) text)
  (set-dialog-item-text (fred-item view) text))


(defmethod set-dialog-item-text ((view fred-item) text)
  (let ((buf (fred-buffer view)))
      (buffer-delete buf (buffer-size buf) 0)
      (buffer-insert-substring buf text)
      (fred-update view)
      text))

(defmethod dialog-item-text ((view scrolling-fred-view))
  (let ((buf (fred-buffer (fred-item view))))
    (buffer-substring buf 0 (buffer-size buf))))


(defmethod fred-wrap-p ((view fred-delegation-mixin))
  (fred-wrap-p (fred-item view)))

; huh
(defmethod (setf fred-wrap-p) (p (view fred-delegation-mixin))
  (setf (fred-wrap-p (fred-item view)) p))

(defmethod part-color ((view fred-delegation-mixin) key)
  (part-color (fred-item view) key))

(defmethod set-part-color ((view scrolling-fred-view) key val)
  (set-part-color (fred-item view) key val))

(defmethod view-font-codes ((view fred-delegation-mixin))
  (view-font-codes (fred-item view)))

(defmethod set-view-font ((view fred-delegation-mixin) val)
  (let ((fred (fred-item view)))
    (when fred
      (set-view-font fred val))))

(defmethod stream-tyo ((f fred-delegation-mixin) char)
  (stream-tyo (fred-item f) char))

(defmethod stream-write-string ((f fred-delegation-mixin) string start end)
  (stream-write-string (fred-item f) string start end))

(defmethod STREAM-TYI ((f fred-delegation-mixin))
  (stream-tyi (fred-item f)))

(defmethod STREAM-unTYI ((f fred-delegation-mixin) char)
  (stream-untyi (fred-item f) char))

(defmethod STREAM-eofp ((f fred-delegation-mixin))
  (stream-eofp (fred-item f)))

(defmethod STREAM-force-output ((f fred-delegation-mixin))
  (stream-force-output (fred-item f)))

(defmethod STREAM-fresh-line ((f fred-delegation-mixin))
  (stream-fresh-line (fred-item f)))

(defclass bar-dragger (simple-view)
  ((split-view-direction :initarg :split-view-direction :accessor dragger-direction)
   ;(active-p :initform nil :accessor dragger-active-p)
   ))

;; from shannon spires
(defmethod stream-read-sequence ((input-stream fred-delegation-mixin) sequence &key (start 0) end)
  (stream-read-sequence (fred-item input-stream) sequence :start start
                        :end end))


(defmethod view-cursor ((view bar-dragger) where)
  (declare (ignore where))
  (if (eq (dragger-direction view) :vertical)
    *vertical-ps-cursor*
    *horizontal-ps-cursor*))

(defmethod view-draw-contents ((view bar-dragger))
  (let ((active-p (window-active-p (view-window view))))
    (with-focused-view view
      (with-back-color (if active-p *lighter-gray-color* nil)
        (rlet ((rect :rect
                     :topleft #@(1 1)
                     :bottomright (view-size view)))
          (#_eraserect rect))
        (with-fore-color (if active-p *black-color* *gray-color*)
          (case (dragger-direction view)
            (:horizontal
             (#_moveto 6 4)
             (#_line 0 6)
             (#_line -3 -3)
             (#_line 2 -2)
             (#_line 0 3)
             (#_line -1 -1)
             (#_moveto 9 4)
             (#_line 0 6)
             (#_line 3 -3)
             (#_line -2 -2)
             (#_line 0 3)
             (#_line 1 -1))
            (:vertical
             (draw-vertical-dragger))))))))        

(defun draw-vertical-dragger ()
  (#_moveto 5 6)
  (#_line 6 0)
  (#_line -3 -3)
  (#_line -2 2)
  (#_line 3 0)
  (#_line -1 -1)
  (#_moveto 5 9)
  (#_line 6 0)
  (#_line -3 3)
  (#_line -2 -2)
  (#_line 3 0)
  (#_line -1 1))

(defmethod view-activate-event-handler ((view bar-dragger))
  (invalidate-view view))

(defmethod view-deactivate-event-handler ((view bar-dragger))
  (invalidate-view view))
  
(defmethod fred-buffer ((view fred-delegation-mixin))
  (fred-buffer (fred-item view)))


; these 5 are copies of fred-dialog-item methods
#|
(defmethod view-click-event-handler ((item fred-item) where)
  (declare (ignore where))  
  (with-focused-view item
    (with-text-colors item
      (let ((my-dialog (view-window item)))
        (without-interrupts
         (if (neq item (current-key-handler my-dialog))
           (with-quieted-view item   ; prevents flashing (no flashers allowed)
             (set-current-key-handler my-dialog item nil))))
          (call-next-method)))))


(defmethod key-handler-idle ((item fred-item) &optional dialog)
  (declare (ignore dialog))
  (with-focused-view item
    (with-text-colors item
    (frec-idle (frec item)))))

(defmethod view-key-event-handler ((item fred-item) char)
  (declare (ignore char))
  (with-focused-view item
    (with-text-colors item
      (call-next-method))))


(defmethod set-view-size ((item fred-item) h &optional v
                          &aux (new-size (make-point h v)))
  (unless (eql new-size (view-size item))
    (without-interrupts
     (call-next-method)
     (frec-set-size (frec item) new-size)))
  new-size)
|#
 
(defmethod view-draw-contents ((item fred-item))
  (unless (view-quieted-p item)
    (with-focused-view item
      (with-text-colors item
        (frec-draw-contents (frec item)))      
      (#_SetClip (view-clip-region (view-container item))))))


#|
(defmethod view-click-event-handler ((view scrolling-fred-view) where)
  (declare (ignore where))
  (let* (;(w (view-window view))
         ;(fred (fred-item view))
         ;(key (current-key-handler w))
         )
    (when nil ; (neq fred key)   ;maybe - lets you scroll without changing keyhdlr     
      (set-current-key-handler w fred nil))
    (with-focused-view view
      (call-next-method))))
|#

(defmethod view-draw-contents ((view scrolling-fred-view))
  (progn ;with-focused-view view    
    (call-next-method) ; its the one for view - does the subviews    
    (when (draw-scroller-outline view)
      (rlet ((r :rect
                :topleft 0
                :bottomright (view-size view))) ; (subtract-points (view-size view) #@(1 1))))
        (#_FrameRect r)))))
#|
(defmethod scroll-bar-limits ((view scrolling-fred-view))
  (values #@(0 511) #@(0 30000)))
|#

(defclass fred-h-scroll-bar (scroll-bar-dialog-item) ()
  (:default-initargs
    :direction :horizontal))

(defclass fred-v-scroll-bar (scroll-bar-dialog-item) ()
  (:default-initargs
    :direction :vertical))


(defmethod track-scroll-bar ((item fred-v-scroll-bar) value part)
  (if (eq part :in-thumb)
    (progn
      (setf (scroll-bar-setting item) value)
      (dialog-item-action item))
    (let* ((view (scroll-bar-scrollee item))
           (frec (frec view))
           (mark (fred-display-start-mark view)))
      (when (memq part '(:in-up-button :in-down-button :in-page-up :in-page-down))        
        (set-fred-display-start-mark
         view
         (case part
           (:in-up-button (frec-screen-line-start frec mark -1))
           (:in-down-button (frec-screen-line-start frec mark 1))
           (:in-page-up (find-frec-prev-page frec mark))                  
           (:in-page-down
            (let* ((sm (fred-display-start-mark view))
                   (point (frec-pos-point frec sm)))    ; can be NIL today - 96
              (or (when point
                    (frec-point-pos frec (make-point (point-h point) (point-v (fr.size frec)))))
                  (buffer-size (fr.buffer frec)))))))))))

(defvar *v-delta* nil)
(defmethod view-click-event-handler ((item fred-v-scroll-bar) where)
  (let* ((sb-handle (dialog-item-handle item))
         (part (#_TestControl sb-handle where)))
    (cond
     ((memq part '(#.#$kControlUpButtonPart #.#$kControlDownButtonPart))
      (let ((*scroll-bar-item* item)
            (*v-delta* 1))
        (with-timer
          (#_TrackControl sb-handle where fred-v-scroll-bar-proc))))
     (t (call-next-method)))))

(add-pascal-upp-alist-macho 'fred-v-scroll-bar-proc "NewControlActionUPP")

(defpascal fred-v-scroll-bar-proc (:ptr sb-handle :word part)
  (declare (ignore sb-handle))
  (let* ((item *scroll-bar-item*)
         (view (scroll-bar-scrollee item))
         (frec (frec view))
         (mark (fred-display-start-mark view)))
    (set-fred-display-start-mark 
     view 
     (frec-screen-line-start frec mark (if (eq part #$kControlDownButtonPart)
                                         *v-delta*
                                         (- *v-delta*))))
    #+ignore
    (with-port-macptr port  ;; do this help? - nope
      (#_QDFlushPortBuffer port (%null-ptr)))
    (if (< *v-delta* 5)(incf *v-delta*))))

; this is silly because the redisplay is going to do the same thing again, caching
; results of compute-screen-line
; when is it too slow? when wrapped.
; lazy means go up one line too few in some sense
(defun find-frec-prev-page (frec pos &optional lazy)
  (when (not (fixnump pos))(setq pos (buffer-position pos)))
  (let* ((vsize (point-v (fr.size frec)))
         (height 0)
         tpos)
    (declare (fixnum height vsize))
    (loop
      (when (not (setq tpos (frec-screen-line-start frec pos 0)))(return))
      (setq height (+ height (nth-value 3 (%compute-screen-line frec tpos))))
      (when (eq tpos 0)(return (setq pos 0)))
      (when (>= height vsize) (return (if lazy (setq pos (1+ pos)) (setq pos tpos))))
      (setq pos (1- tpos)))
    pos))

(defmethod track-scroll-bar ((item fred-h-scroll-bar) value part)
  (if (eq part :in-thumb)
    (progn
      (setf (scroll-bar-setting item) value)
      (dialog-item-action item)
      (if t #|(osx-p)|# (view-draw-contents (scroll-bar-scrollee item))))
    (let* ((view (scroll-bar-scrollee item))
           (hscroll (fred-hscroll view)))
      (declare (fixnum hscroll))
      (when (memq part '(:in-up-button :in-down-button :in-page-up :in-page-down))
        (set-fred-hscroll view
                          (+ hscroll
                             (case part
                               (:in-up-button -6)
                               (:in-down-button (if (eql 0 hscroll)
                                                  (fred-margin view) 6))
                               (:in-page-up (- (ash (point-h (view-size view)) -1)))
                               (:in-page-down (ash (point-h (view-size view)) -1)))))
        (fred-update view)
        (when (and #|(osx-p)|# (memq part '(:in-up-button :in-down-button)))
          ;; work around crock - wish I knew why needed
          (view-draw-contents view))))))

; This handles the case when the user drags the thumb.
(defmethod dialog-item-action ((item fred-v-scroll-bar))
  (let* ((setting (scroll-bar-setting item))
         (view (scroll-bar-scrollee item))
         (max (scroll-bar-max item))
         (size (buffer-size (fred-buffer view)))
         (new-pos (round (* setting size) max)))    
    (set-fred-display-start-mark view (frec-screen-line-start (frec view) new-pos))
    (when t ; (osx-p)  ;; aargh
      (with-port-macptr port
        (#_QDFlushPortBuffer port (%null-ptr))))))

(defmethod dialog-item-action ((item fred-h-scroll-bar))
  (let* ((view (scroll-bar-scrollee item)))
    ; set-fred-hscroll wants pixels
    (set-fred-hscroll  
     view
     (let ((setting (scroll-bar-setting item)))
       (if (eq 0 setting) 0
           (round (* setting (frec-hmax (frec view)))(scroll-bar-max item)))))
    (fred-update view)
    (when t ;(osx-p)  ;; aargh
      (with-port-macptr port
        (#_QDFlushPortBuffer port (%null-ptr))))))

(defmethod fred-update ((view fred-delegation-mixin))
  (fred-update (fred-item view)))

(defmethod fred-update ((fred fred-item))
  (let ((frec (frec fred)))
    (unless  (or (view-quieted-p fred) (not (wptr fred)))
      (call-next-method))
    (let* ((view (view-container fred))
           (h-scroll (if view (h-scroller view)))
           (v-scroll (if view (v-scroller view))))
      (when v-scroll
        (let* ((max (scroll-bar-max v-scroll))
               (mark (fred-display-start-mark fred))
               (pos (buffer-position mark))
               (size (buffer-size mark)))
          (set-scroll-bar-setting v-scroll (if (eq 0 size) 0 (round (* pos max) size)))))
      ; pfooey
      (when h-scroll       
        (let* (;(hmax (frec-hmax frec)) ; toooo slow for daily use
               (h (fr.hscroll frec)))
          ; still slow if h > 0 - really don't want to do this here
          (set-scroll-bar-setting ; draws the scroll bar
           h-scroll 
           (if (eq 0 h)
             0
             (let ((hpos (- (fr.margin frec) (fr.hpos frec))))
               (round (* hpos (scroll-bar-max h-scroll)) (frec-hmax frec))))))))))

(defmethod window-show-cursor ((w fred-item) &optional pos scrolling)
  ; woi appears to fix listener output appearing in wrong place - dont know why!
  ; happened during call to stream-force-output in event-poll (never did like that)
  (without-interrupts
   (with-focused-view w
     (with-text-colors w
       ;(fred-update w)  ; get backcolor right ?? 
       (frec-show-cursor (frec w) pos scrolling)
       ; now get scrollbars right
       (with-quieted-view w (fred-update w))
       (let ((em (edit-menu)))
         (when (not (menu-enabled-p em))(menu-update em)))))))
   

(defmethod v-scroller ((view scrolling-fred-view)) 
  (view-named 'v-scroller view))

(defmethod h-scroller ((view scrolling-fred-view))
  (view-named 'h-scroller view))

(defmethod fred-item ((view scrolling-fred-view))
  (view-named 'fred-item view))

(defmethod bar-dragger ((view scrolling-fred-view))
  (view-named 'bar-dragger view))

(defmethod set-view-size ((view scrolling-fred-view) h &optional v)
  (declare (ignore h v))
  (without-interrupts
   (call-next-method)
   (view-size-parts view)
   (view-size view)))

(defmethod view-size-parts ((view scrolling-fred-view))
   (let* ((pt (view-size view))
          (frac (h-scroll-fraction view))) ; 4 means 1/4
     (when pt 
       (let* ((sbc (scroll-bar-correction view))
              (h-scroller (h-scroller view))
              (v-scroller (v-scroller view))
              (grow-box-p (grow-box-p view))
              (bar-dragger (bar-dragger view))
              (h (- (point-h pt) (point-h sbc)))
              (v (- (point-v pt) (point-v sbc)))
              (fred-item (fred-item view)))
         ; scroll-bar-correction tells us how to adjust size of frec
        (when fred-item (set-view-size (fred-item view) 
                                       (if (and grow-box-p h-scroller (not v-scroller))
                                         (+ h 17) h)
                                       v))
        (when bar-dragger
           (set-view-position bar-dragger (1+ h) (1+ v)))
         (when v-scroller
           (set-view-position v-scroller (1+ h) 0)
           (setf (scroll-bar-length v-scroller)
                 ; adjust for grow-box when v-scroller but no h-scroller
                 (if (or h-scroller (not grow-box-p)) (+ 2 v)(+ -13 v))))
         (when h-scroller
           (cond ((not frac)
                  (set-view-position h-scroller 0 (1+ v))
                  (setf (scroll-bar-length h-scroller) (+ 2 h)))
                 (t 
                  (let ((len (max 64 (truncate h frac))))
                    ; wrong if draw-outline
                    (setf (scroll-bar-length h-scroller) len)
                    (set-view-position h-scroller (+ 2 (- h len)) (1+ v))))))))))


(defmethod initialize-instance  ((view scrolling-fred-view)
                                       &rest initargs
                                       &key                                       
                                       (fred-item-class 'fred-item)                                      
                                       view-container
                                       (view-font *fred-default-font-spec*)                                       
                                       track-thumb-p
                                       h-pane-splitter
                                       v-pane-splitter
                                       bar-dragger
                                       (h-scroll-class 'fred-h-scroll-bar)
                                       (v-scroll-class 'fred-v-scroll-bar)
                                       (h-scrollp t) 
                                       (v-scrollp t)
                                       allow-tabs
                                       allow-returns
                                       ;draw-outline
                                       text-edit-sel-p
                                       save-buffer-p
                                       margin
                                       filename
                                       ;dialog-item-text
                                       history-length
                                       buffer-chunk-size
                                       wrap-p
                                       word-wrap-p
                                       justification
                                       line-right-p
                                       part-color-list
                                       copy-styles-p
                                       comtab
                                       buffer)
  (declare (ignore allow-tabs allow-returns draw-outline margin filename
                   dialog-item-text wrap-p word-wrap-p buffer text-edit-sel-p save-buffer-p
                   history-length buffer-chunk-size part-color-list copy-styles-p comtab
                   justification line-right-p))
  (declare (dynamic-extent initargs))
  (apply #'call-next-method view :view-container nil initargs) ; prevents it from appearing at default size first 
  (let* ((grow-box-p (grow-box-p view))
         (sbc (make-point (if (or v-scrollp grow-box-p) 17 2)
                          (if (or h-scrollp #|grow-box-p|#) 17 2)))
         fred)
    (setf (scroll-bar-correction view) sbc)
    (setq fred
          (apply #'make-instance fred-item-class 
                 :view-position #@(1 1)
                 :view-nick-name 'fred-item
                 :view-font view-font
                 :view-container view 
                 initargs))
    ;(setf (fr.position (frec view)) #@(0 0))
    (when h-scrollp
      (make-instance h-scroll-class
        :direction :horizontal  ; don't assume
        :view-container view
        :view-nick-name 'h-scroller
        :view-position #@(0 0) ; else view-find-vacant-position may error because view has no size yet
        :pane-splitter h-pane-splitter        
        :scrollee fred        
        :track-thumb-p track-thumb-p))
    (when v-scrollp
      (make-instance v-scroll-class
        :direction :vertical
        :view-container view
        :view-position #@(0 0)
        :view-nick-name 'v-scroller
        :pane-splitter v-pane-splitter        
        :scrollee fred        
        :track-thumb-p track-thumb-p))
    (when bar-dragger
      (make-instance 'bar-dragger
        :split-view-direction bar-dragger
        :view-container view
        :view-nick-name 'bar-dragger
        :view-position #@(0 0)))
    ; gets the scroll bars in the right places
    (view-size-parts view)
    (when view-container (set-view-container view view-container))
    ))


(defmethod install-view-in-window ((item scrolling-fred-view) dialog)
  (declare (ignore dialog))
  (let ((container (view-container item)))
    (set-default-size-and-position item container))
  (call-next-method)
  #+ignore
  (let ((fred-item (fred-item item))
        (buffer (fred-buffer item)))
    (when (and fred-item buffer)
      (setf (bf.owner (mark.buffer buffer)) fred-item)))
  ;(view-size-parts item)
  )


(defmethod remove-scroller ((view scrolling-fred-view) which)
  (let* ((v-scroll (v-scroller view))
         (h-scroll (h-scroller view))
         (grow-p (grow-box-p view))
         scroller)    
    (case which
      (:vertical
       (setq scroller v-scroll)
       (setq v-scroll nil))
      (:horizontal
       (setq scroller h-scroll)
       (setq h-scroll nil)))
    (when scroller (set-view-container scroller nil))
    (setf (scroll-bar-correction view) (make-point (if (or v-scroll grow-p) 17 2)
                                                   (if (or h-scroll #|grow-p|#) 17 2)))
    (view-size-parts view)))
        
(defmethod add-scroller ((view scrolling-fred-view) which &key pane-splitter)
  (let* ((scroller (make-instance (case which
                                    (:horizontal 'fred-h-scroll-bar)
                                    (:vertical 'fred-v-scroll-bar))
                     :pane-splitter pane-splitter
                     :direction which
                     :view-position #@(-30000 -30000) ; else it shows up first in wrong place
                     :scrollee (fred-item view)
                     :view-nick-name (case which
                                       (:horizontal 'h-scroller)
                                       (:vertical 'v-scroller))))
         (grow-p (grow-box-p view)))
    (unless (case which
              (:horizontal (h-scroller view))
              (:vertical (v-scroller view)))
      (set-view-container scroller view)      
      (setf (scroll-bar-correction view)(make-point (if (or grow-p (v-scroller view)) 17 2)
                                                    (if (or #|grow-p|# (h-scroller view)) 17 2)))
      (view-size-parts view))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; methods for bar-dragger

(defmethod initialize-instance ((item bar-dragger) &rest initargs
                                &key (width 15) (direction :vertical))
  (declare (dynamic-extent initargs))
  (let ((size (make-point width width)))
    (apply #'call-next-method
           item
           :view-size size
           :direction direction
           initargs)))
#|

; could give him an enabled-p slot so we know how to draw him?
; otherwise he keeps reappearing when we drag a split
(defmethod view-draw-contents ((view bar-dragger))
  (when (window-active-p (view-window view))
    (with-focused-view view
      (when (dragger-active-p view)
        (let ((icon (case (dragger-direction view)
                      (:horizontal *horizontal-dragger-icon*)
                      (:vertical *vertical-dragger-icon*))))
          (simple-plot-icon icon #@(2 2) (view-size view)))))))


(defmethod view-deactivate-event-handler ((view bar-dragger))  
  (with-focused-view (view-container view)
    (let ((pos (add-points (view-position view) #@(2 2))))
      (rlet ((rect :rect
                   :topleft pos
                   :botright (add-points pos (subtract-points (view-size view) #@(2 2)))))
        (#_Eraserect rect)))
    ;(setf (dragger-active-p view) nil)
    (multiple-value-bind (tl br)(view-corners view)
      (validate-corners (view-container view) tl br))))

(defmethod view-activate-event-handler ((view bar-dragger))
  (view-draw-contents view)
  (setf (dragger-active-p view) t)
  (multiple-value-bind (tl br)(view-corners view)
    (validate-corners (view-container view) tl br)))
|#

#|
(defclass pie (fred-window) ())
(defparameter *w* (make-instance 'poo :view-size #@(500 200)))

(defparameter *f* (make-instance 'scrolling-fred-view
                                 :view-container *w*
                                 :view-position #@(10 10)
                                 :v-pane-splitter :top
                                 :h-pane-splitter :left                                 
                                 :view-size #@(450 180)))

(defmethod view-click-event-handler ((w poo) where)
  (if (double-click-p)
    (let ((v (find-view-containing-point w where)))
      (when v (set-view-container v nil)))
    (call-next-method)))


(defmethod window-update-event-handler ((w poo))
  (with-focused-view w
    (when (neq 0 (length (view-subviews w)))
      (let ((v (elt (view-subviews w) 0)))
        (rlet ((r rect :topleft (view-position v) :bottomright (add-points (view-position v)
                                                                           (view-size v))))
          ;(#_fillrect r *black-pattern*)
          )))
    (call-next-method)))

|#

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; scrolling-fred-view with focusrect

(export '(scrolling-fred-view-with-frame) "CCL")



(defclass framed-view-fred-item (tsm-fred-item) ())  ;; tsm-fred-item that lives in a scrolling-fred-view-with-frame


(defclass scrolling-fred-view-with-frame (focus-rect-mixin scrolling-fred-view)()
   (:default-initargs
     :fred-item-class 'framed-view-fred-item))

;; needed because click in the fred-item activates fred-item but not container

(defmethod view-activate-event-handler :after ((view framed-view-fred-item))
  (let ((container (view-container view)))
    (when t ;(typep container 'scrolling-fred-view-with-frame)  ;; always true today
      ;(invalidate-view  container)
      (frame-key-handler container))))

(defmethod view-deactivate-event-handler :after ((view framed-view-fred-item))  
  (let ((container (view-container view)))
    (when t ; (typep container 'scrolling-fred-view-with-frame)
      ;(invalidate-view  container)
      (frame-key-handler container))))



#| ;; lose this??
(defmethod view-size-parts :after ((view scrolling-fred-view-with-frame))
  (when (osx-p)
    ;; because activate/deactivatecontrol of scroll bar draws outside it's rect on os-x - or size on os 9 is weird?
    (let ((v-scroller (v-scroller view)))
      (when v-scroller
        (let ((orig-size (view-size v-scroller))
              (orig-pos (view-position v-scroller)))
          (set-view-position v-scroller (point-h orig-pos)(1+ (point-v orig-pos)))
          (set-view-size v-scroller (point-h orig-size)(- (point-v orig-size) 2)))))
    (let ((h-scroller (h-scroller view)))
      (when h-scroller
        (let ((orig-size (view-size h-scroller))
              (orig-pos (view-position h-scroller)))
          (set-view-position h-scroller (1+ (point-h orig-pos)) (point-v orig-pos))
          (set-view-size h-scroller (- (point-h orig-size) 2) (point-v orig-size)))))))
|#






#|
(defmethod view-corners ((view scrolling-fred-view-with-frame))
  (multiple-value-call #'inset-corners (if (osx-p) #@(-3 -3) #@(-3 -3)) (call-next-method)))  ;; was -4 -4 for osx-p  
|#
;; better now
(defmethod frame-key-handler ((view scrolling-fred-view-with-frame))
  (with-focused-view (view-container view)
    (with-item-rect (rect view)      
      (let* ((w (view-window view))
             (fred-item (fred-item view))
             (window-active-p (window-active-p w)))         
        (if (and window-active-p (eq fred-item (current-key-handler w))(cdr (key-handler-list w))) ;; do iff more than one key-handler
          (progn 
            (#_insetrect rect 1 1) ;; overwrite the frame
            (#_drawthemefocusrect rect t))          
          ;; leaves 1 pixel gray rect on osx - fixed - see view-corners - no don't
          (progn 
            (with-fore-color (if (not window-active-p)
                               (if t #|(osx-p)|# *light-gray-color* *gray-color*)
                               (or (part-color fred-item :frame) *black-color*))
              (#_framerect rect))
            ;(IF (and (NOT (OSX-P)) )(#_INSETRECT  RECT 1 1))
            (draw-nil-theme-focus-rect w rect))          
          )))))

#|
(defmethod set-view-size ((item scrolling-fred-view-with-frame) h &optional v)
  (declare (ignore h v))
  (with-focused-view (view-container item)
    (multiple-value-bind (tl br)(view-corners item)
      (rlet ((rect :rect :topleft tl :botright br))          
        (#_eraserect rect))  ;; maybe not needed?
      (call-next-method)
      (invalidate-view item t))))
|#

          

#|
(setq w (make-instance 'window :view-subviews
                       (list (make-instance 'editable-text-dialog-item
                               :view-size #@(100 20) :view-position #@(10 10))
                             (make-instance 'scrolling-fred-view-with-frame))))
|#
  


#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
