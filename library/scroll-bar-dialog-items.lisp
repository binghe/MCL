;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  2 10/5/97  akh  see below
;;  5 3/9/96   akh  cursors for poof-button and bar-draggers
;;  2 3/2/95   akh  view-draw-contents for inactive bar assures background is white
;;  (do not edit before this line!!)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  scroll-bar-dialog-items.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  the code in this file implements a scroll-bar class of dialog-items
;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; install-view-in-window more modern ?
;; track-scroll-bar-thumb only calls wait-mouse-up-or-moved if the mouse hasn't moved
;; use add-pascal-upp-alist-cfm - now try macho
;; #$inthumb => kincontrolIndicatorPart etc.
;; ----- 5.2b1
;; ------ 5.1 final
;; v-d-c of pane-splitter - use paintrect so works when not *color-available*
;; fiddle with color of active pane-splitter
;; fix view-draw-contents of scroll-bar - fixes opening a bunch of fred windows in rapid succession
;; view-activate-event-handler does #_showcontrol again
;; view-activate and deactivate event-handlers less clunky more P.C., change v-d-c of pane-splitter, lose nonsense in v-d-c of scroll-bar
;; ------- 5.1b2
;; 04/08/04 use wait-mouse-up-or-moved vs mouse-down-p
;; 2/23/2004 ss some fixes to re-enable mousewheel scrolling in databrowsers
;; 02/22/04 give up - if track-thumb-p is true things work - so make it default to T
;; 02/21/04 more to the kludge than meets the eye, scroll-bar-max 10000  vs 32768 if not supplied.
;; 01/10/04 kludge in outside-scroll-bar-setting for osx
;; with-timer stuff
;; use activate/deactive control - 
;; 11/21/03 akh lose with-periodic-task-mask in track-scroll-bar-thumb
;; simplify scroll wheel stuff a little bit - fixes a bug
;; find-scroll-bar-controlling-point checks enabled-p
;; dialog-item-action does QDFlushPortBuffer
;; --------- 5.0final
;; 02-13-03 ss    make mouse wheel scrolling faster (instantaneous) on vertical Fred scrollers.
;;                *wheel-scroll-factor* is now ignored because it's not
;;                needed. Use the scrolling speed setting in the mouse preference pane instead.
;; 12-14-02 ss    modifify Waldemar's mouse wheel handler to be more consistent with Finder windows
;;                by allowing hover-scrolling--using the wheel to scroll windows that
;;                are not frontmost, but that the mouse is currently above.
;;                See http://www.osxfaq.com/dailytips/10-2002/10-22.ws for more info.
;;
;; initialize-instance - change default max to 32768 if osx. Yet another crock to make #_trackcontrol DWIM.
;;    actually do always - makes track-...-thumb a little better for vertical scroll.
;; ----------- 4.4b5
;; support for mouse wheel maybe?
;; --------- 4.4b4
;; track-scroll-bar-thumb for osx-p
;; ---------- 4.4b2
;; see view-click-event-handler for horiz scroll-bar-di re osx crock - nah just fix track-scroll-bar for fred
;; carbon-compat
;;------------ 4.3.1
;; 10/01/97 akh   set-view-container - don't invalidate unless container changed
;; 09/26/96 bill  new pane-splitter-handle-double-click generic function.
;;                Call it from (method view-click-event-handler (pane-splitter t)).
;;                The default method does nothing.
;; -------------  4.0b2
;; 05/17/96 bill  update-scroll-bar-max-min-setting sets the values in
;;                the control record directly rather than calling traps.
;;                This delays drawing until the next update and stops
;;                Leibniz from leaving turds on project window pane resize.
;; -------------  MCL-PPC 3.9
;; 04/03/96 bill  track-scroll-bar-thumb uses with-periodic-task-mask instead
;;                of let binding *periodic-task-mask*.
;; 11/29/95 bill  new trap names to avoid trap emulator
;; 11/14/95 bill  scroll-bar-proc returns
;;  4/25/95 slh   need in-package for file-compiler
;; remove-view-from-window :before focuses on container - else garbage erase region
;; 10/17/93 alice view-click-event-handler for pane-splitter dont resample mouse
;;-------------
;; 07/01/93 alice set-scroll-bar-length sets pane-splitter-position if
;		  vertical :bottom or t or horizontal :right or t.
;; 08/18/93 bill  with-clip-rect -> with-clip-rect-intersect
;; 06/22/93 bill  add a comment about *XXX-ps-cursor* initialization.
;; -------------- 3.0d12
;; 07/01/93 alice set-scroll-bar-length sets pane-splitter-position if
;;		  vertical :bottom or t or horizontal :right or t.
;; -------------- 3.0d8
;; 03/09/93 alice pane-splitter-outline-position is a point.
;;   ??	    alice added pane-splitter-cursor and some other stuff
;; 12/08/92 alice set-scroll-bar-length changed to make :top or :left splitters work
;; 07/17/92 bill Do the right thing for :view-size initarg and
;;               no :length or :width initarg.
;; 06/04/92 bill Do not ignore the :setting initarg
;; ------------  2.0
;; 03/20/92 bill fix completely bogus conversions in mac-scroll-bar-setting
;;               and outside-scroll-bar-setting.
;; ------------- 2.0f3
;; 01/06/92 bill Fix a bug in the ROM that enables a scroll bar on exiting
;;               #_TrackControl. This allows user dialog-item-action functions
;;               to disable the scroll bar while it is being tracked.
;;               Adjust initial mouse position for scroll-position in
;;               track-scroll-bar-thumb.
;;               install-view-in-window disables the scroll bar if appropriate.
;;               New mapping of user-visible min & max to what the ROM sees so
;;               that the scroll bar will be disabled when max=min.
;; 12/30/91 bill :pane-splitter should be :left or :right for a
;;               horizontal scroll bar (vice :top or :bottom)
;;               set-scroll-bar-width works correctly for inactive scroll bars.
;;               inactive scroll bars get drawn after set-view-container.
;;               :srcxor -> :patxor
;;               Window.updateRgn -> WindowRecord.updateRgn
;;               Remove %pane-splitter-outline-position.
;;               Thanx to STEVE.M
;; ------------- 2.0b4
;; 11/12/91 bill (from dds)
;;               :control.vis -> :controlRecord.ContrlVis
;;               :control.owner -> :controlRecord.ContrlOwner
;; 10/17/91 bill Use #_TrackControl vice track-scroll-bar-thumb if
;;               not doing real time scrolling.  Disable periodic tasks
;;               that draw during real time scrolling.
;; 10/15/91 bill #_ShowControl & #_HideControl add to the invalid region.
;;               Add a #_ValidRect in view-(de)activate-event-handler
;; -------------- 2.0b3
;; 08/26/91 bill no more (require 'traps)
;; 08/25/91 gb   use new trap syntax.
;; 08/08/91 bill set-view-container now handles the view-deactivate-event-handler
;;               that was in install-view-in-window here.
;; 07/18/91 bill Prevent divide by zero in mac-scroll-bar-setting
;; 04/16/91 bill pane-splitter-outline-position
;; 03/22/91 bill make scroll bars & pane-splitters disappear when the 
;;               window is not active.
;; 03/11/91 bill WRS's pane-splitter-corners fix.
;; 03/04/91 bill increase setting range to beyond [-32768 32767]
;; 02/22/91 bill make the scroll bar initially invisible so
;;               we don't need to focus-view in install-view-in-window.
;;--------------- 2.0b1
;; 01/28/91 bill event.where -> eventRecord.where
;;

(in-package :ccl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(scroll-bar-dialog-item scroll-bar-setting
            scroll-bar-min scroll-bar-max scroll-bar-length scroll-bar-width
            scroll-bar-page-size  scroll-bar-scroll-size scroll-bar-scrollee
            set-scroll-bar-setting set-scroll-bar-min set-scroll-bar-max
            set-scroll-bar-length set-scroll-bar-width set-scroll-bar-scrollee
            scroll-bar-changed track-scroll-bar
	    scroll-bar-track-thumb-p set-scroll-bar-track-thumb-p
            pane-splitter split-pane pane-splitter-corners
            pane-splitter-position set-pane-splitter-position
            draw-pane-splitter-outline pane-splitter-outline-position
            pane-splitter-handle-double-click
            view-scroll-bars)
          :ccl))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;scroll-bar-dialog-item
;;

(defclass scroll-bar-dialog-item (control-dialog-item)
  ((procid :allocation :class :initform #$scrollBarProc)
   (direction :initarg :direction :reader scroll-bar-direction)  
   (min :initarg :min :reader scroll-bar-min)
   (max :initarg :max :reader scroll-bar-max)
   (setting :initarg :setting :reader scroll-bar-setting)
   (track-thumb-p :initarg :track-thumb-p :initform t
                  :accessor scroll-bar-track-thumb-p)
   (page-size :initarg :page-size :initform 5 :accessor scroll-bar-page-size)
   (scroll-size :initarg :scroll-size :initform 1 :accessor scroll-bar-scroll-size)
   (scrollee :initarg :scrollee :initform nil :reader scroll-bar-scrollee)
   (pane-splitter :initform nil :accessor pane-splitter)
   (pane-splitter-position :initform nil :initarg :pane-splitter 
                           :reader pane-splitter-position)))

(defclass pane-splitter (simple-view)
  ((scrollee :initarg :scrollee 
             :reader scroll-bar-scrollee)
   (direction :initarg :direction :reader scroll-bar-direction)
   (cursor :initarg :cursor :initform *arrow-cursor* :accessor pane-splitter-cursor)
   (scroll-bar :initarg :scroll-bar :initform nil :reader scroll-bar)))

; Args would be in wrong order if these were defined as :writer's
(defmethod set-scroll-bar-track-thumb-p ((item scroll-bar-dialog-item) value)
  (setf (scroll-bar-track-thumb-p item) value))

(defmethod set-scroll-bar-scrollee ((view pane-splitter) value)
  (setf (slot-value view 'scrollee) value))

; These are initialized for real by a def-ccl-pointers in l1-boot
(defparameter *top-ps-cursor* *arrow-cursor*)
(defparameter *bottom-ps-cursor* *arrow-cursor*)
(defparameter *left-ps-cursor* *arrow-cursor*)
(defparameter *right-ps-cursor* *arrow-cursor*)
(defparameter *vertical-ps-cursor* *arrow-cursor*)
(defparameter *horizontal-ps-cursor* *arrow-cursor*)



(defmethod view-cursor ((p pane-splitter) where)
  (declare (ignore where))
  (pane-splitter-cursor p))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;initialize-instance
;;
;;initargs:
;;   length
;;   width
;;   direction
;;   setting
;;   min
;;   max
;;   page-size
;;   track-thumb-p
;;
;;in addition, the standard dialog-item initargs can be used
;;Size can be specified by either the view-size initarg or
;;the length & width initargs, but not both.
;;

(defmethod initialize-instance ((item scroll-bar-dialog-item) &rest initargs
                                &key (min 0) 
                                (max (if t 10000 100))  ;; was + $scroll-bar-max $scroll-bar-max
                                (setting 0)
                                width
                                (direction :vertical) length scrollee
                                pane-splitter-cursor pane-splitter-class
                                pane-splitter (pane-splitter-length 7) view-size
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
                                    :length (or pane-splitter-length 7)
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

(defun view-scroll-bars (view)
  (view-get view 'scroll-bars))

(defun add-view-scroll-bar (view scroll-bar)
  (pushnew scroll-bar (view-get view 'scroll-bars)))

(defun delete-view-scroll-bar (view scroll-bar)
  (setf (view-get view 'scroll-bars)
        (delete scroll-bar (view-get view 'scroll-bars))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;install-view-in-window
;;
;;  this is when we actually create the control (when the item
;;  is added to a window)

(defconstant $scroll-bar-max 16384)

(defun mac-scroll-bar-min-max (min max &aux dif)
  (unless (>= max min) (setq max min))
  (cond ((and (>= min (- $scroll-bar-max)) (<= max $scroll-bar-max))
         (values min max))
        ((< (setq dif (- max min)) (+ $scroll-bar-max $scroll-bar-max))
         (let ((min-return
                (max (- $scroll-bar-max)
                     (min min (- $scroll-bar-max dif)))))
           (values min-return (+ min-return dif))))
        (t (values (- $scroll-bar-max) $scroll-bar-max))))

(defun mac-scroll-bar-setting (setting min max &optional mac-min mac-max)
  (if (<= max min)
    min
    (progn
      (unless (and mac-min mac-max)
        (multiple-value-setq (mac-min mac-max) (mac-scroll-bar-min-max min max)))
      (min mac-max
           (+ mac-min
              (round (* (- setting min) (- mac-max mac-min)) (- max min)))))))

(defun outside-scroll-bar-setting (scroll-bar handle)
  (let ((mac-setting (#_GetControlValue handle))
        (mac-min (#_GetControlMinimum handle))
        (mac-max (#_GetControlMaximum handle))
        (min (scroll-bar-min scroll-bar))
        (max (scroll-bar-max scroll-bar)))    
    (declare (fixnum mac-min mac-max))
    (when (and #|(osx-p)|# (not (scroll-bar-track-thumb-p scroll-bar))) ;(> (- mac-max mac-min) 3000)) ;; total kludge because osx sucks
      (if (and (neq 0 mac-setting)(> (truncate (- mac-max mac-min) mac-setting) 100))(progn (setq mac-setting mac-min))))
    (if (eql mac-min mac-max)
      mac-min
      (+ min (round (* (- mac-setting mac-min) (- max min)) (- mac-max mac-min))))))

#|
(defmethod install-view-in-window :after ((item scroll-bar-dialog-item) view)
  (declare (ignore view))
  (let* ((window (view-window item))
         (my-size (view-size item))
         (my-position (view-position item))
         (setting (scroll-bar-setting item))
         (min (scroll-bar-min item))
         (max (scroll-bar-max item))
         (mac-setting (mac-scroll-bar-setting setting min max)))
    (multiple-value-bind (mac-min mac-max) (mac-scroll-bar-min-max min max)
      (when window
        (rlet ((scroll-rect :rect))
          (rset scroll-rect rect.topleft my-position)
          (rset scroll-rect rect.bottomright (add-points my-position my-size))
          (let ((handle (dialog-item-handle item)))
            (setf (dialog-item-handle item) nil)          ; I'm paranoid
            (when handle
              (#_DisposeControl handle)))
          (setf (dialog-item-handle item)
                (#_NewControl 
                 (wptr item)            ;window
                 scroll-rect            ;item rectangle
                 (%null-ptr)            ;title
                 nil                    ;visible-p: invisible initially.
                 mac-setting            ;initial value
                 mac-min                ;min value
                 mac-max                ;max value
                 #$scrollbarproc        ;type of control
                 0)))                   ;refcon
        (unless (dialog-item-enabled-p item)
          (#_deactivatecontrol (dialog-item-handle item)))
        
        ; Make sure the pane splitter is in the right place
        (when nil ; (pane-splitter item)
          (set-view-position item (view-position item)))))))
|#

;; any reason to prefer this?
(defmethod install-view-in-window :after ((item scroll-bar-dialog-item) view)
  (declare (ignore view))
  (let* ((window (view-window item))
         (my-size (view-size item))
         (my-position (view-position item))
         (setting (scroll-bar-setting item))
         (min (scroll-bar-min item))
         (max (scroll-bar-max item))
         (mac-setting (mac-scroll-bar-setting setting min max)))
    (multiple-value-bind (mac-min mac-max) (mac-scroll-bar-min-max min max)
      (when window
        (rlet ((scroll-rect :rect :topleft my-position :bottomright (add-points my-position my-size)))
          (let ((handle (dialog-item-handle item)))
            (setf (dialog-item-handle item) nil)          ; I'm paranoid
            (when handle
              (#_DisposeControl handle)))
          (rlet ((res :ptr))
            (errchk
             (#_CreateScrollBarControl
              (wptr item)            ;window
              scroll-rect            ;item rectangle
              mac-setting            ;initial value
              mac-min                ;min value
              mac-max                ;max value
              0                     ; view size  ?? what is that for
              T                      ; live tracking
              scroll-bar-proc                     ; live trackingproc
              res                    ; out control
              ))
            (setf (dialog-item-handle item) (%get-ptr res))))
        (unless (dialog-item-enabled-p item)
          (#_deactivatecontrol (dialog-item-handle item)))
        ))))



    
(defmethod remove-view-from-window :before ((item scroll-bar-dialog-item))
  (let ((handle (dialog-item-handle item)))
    (when handle
      (with-focused-view (view-container item)
        (#_DisposeControl handle)
        (setf (dialog-item-handle item) nil)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;view-draw-contents
;;
;;this function is called whenever the item needs to be drawn
;;
;;to draw the dialog-item, we just call _Draw1Control
;;unless we just created it and it's still invisible.
;;

 
(defmethod view-draw-contents ((item scroll-bar-dialog-item))
  (let* ((handle (dialog-item-handle item))
         (window (view-window item)))
    (when handle
      (if (#_iscontrolvisible handle)
            (#_Draw1Control handle)
            (#_ShowControl handle))
      (if (window-active-p window)
        (progn          
          (if (dialog-item-enabled-p item)
            (#_activatecontrol handle)
            (#_deactivatecontrol handle)))        
        (progn
          #+ignore
          (multiple-value-bind (tl br) (scroll-bar-and-splitter-corners item)          
            (rlet ((rect :rect :topLeft tl :botRight br))            
              (#_FrameRect rect)))          
          (#_deactivatecontrol handle)
          )))))

(defun scroll-bar-and-splitter-corners (scroll-bar)
  (multiple-value-bind (tl br) (view-corners scroll-bar)
    (let ((splitter (pane-splitter scroll-bar)))
      (if splitter
        (multiple-value-bind (stl sbr) (view-corners splitter)
          (values (make-point (min (point-h tl) (point-h stl))
                              (min (point-v tl) (point-v stl)))
                  (make-point (max (point-h br) (point-h sbr))
                              (max (point-v br) (point-v sbr)))))
        (values tl br)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;view-deactivate-event-handler
;;
;;this function is called whenever the scrollbar needs to be deactivated
;;

(defmethod view-deactivate-event-handler ((item scroll-bar-dialog-item))
  (let ((handle (dialog-item-handle item))
        (container (view-container item)))
    (when handle
      (with-focused-view container
        (unless (window-active-p (view-window item))
          (let ((splitter (pane-splitter item)))
            (when splitter
              (view-draw-contents splitter))))            
        (#_deactivatecontrol handle)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;view-activate-event-handler
;;
;;this function is called whenever the scrollbar needs to be activated - gee I never would have guessed
;;


(defmethod view-activate-event-handler ((item scroll-bar-dialog-item))
  (let ((w (view-window item)))
    (when (and w (window-active-p w))
      (let ((handle (dialog-item-handle item))
            (container (view-container item)))
        (with-focused-view container
          (if (not (#_iscontrolvisible handle))
            ; #_ShowControl is similarly naughty - why needed  when opening a bunch of fred windows quickly ?
            (progn 
              (#_showcontrol handle)
              #+ignore
              (multiple-value-bind (tl br) (scroll-bar-and-splitter-corners item)          
                (rlet ((rect :rect :topLeft tl :botRight br))            
                  (#_FrameRect rect))))
            ;(#_draw1control handle)
            ) 
          (if (dialog-item-enabled-p item)
            (#_activatecontrol handle)
            (#_deactivatecontrol handle))
          (let ((splitter (pane-splitter item)))
            (when splitter (view-draw-contents splitter))))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;dialog-item-enable
;;
;; Need to patch the system-supplied method for control-dialog-item
;; scroll bars are not visibly enabled unless the window they're on
;; is the top window.

(defmethod dialog-item-enable ((item scroll-bar-dialog-item))
  (unless (dialog-item-enabled-p item)
    (setf (dialog-item-enabled-p item) t)
    (view-activate-event-handler item)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;dialog-item-disable
;;
;; Patch the control-dialog-item method to delay
;; the actual disable during scrolling.
;; This gets around a bug in the Mac ROM where the scroll
;; a control is enabled just before #_TrackControl returns.

; This is bound to the scroll bar that is currently being tracked.
(defvar *scroll-bar-item* nil)

(defmethod dialog-item-disable ((item scroll-bar-dialog-item))
  (if (eq item *scroll-bar-item*)
    (setf (dialog-item-enabled-p item) nil)
    (call-next-method)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;scroll-bar-proc
;;
;;this is the hook function which is passed to _TrackControl.  The toolbox
;;  will call this function periodically as the control is clicked.
;;
;; It calls track-scroll-bar every time the ROM calls it.
;; The default version of track-scroll-bat updates the
;; scroll bar position according to the scroll-bar-scroll-size or
;; scroll-bar-page-size and calls dialog-item-action.
;; User's may shadow the default method if they need custom behavior.


#+carbon-compat  ;; this sucks
(add-pascal-upp-alist-macho 'scroll-bar-proc "NewControlActionUPP")

(defpascal scroll-bar-proc (:ptr sb-handle :word part)
  "This procedure adjusts the control value, and calls dialog-item-action."
  (let ((item *scroll-bar-item*))
    (track-scroll-bar
     item
     (if (eq part #.#$kcontrolIndicatorPart)  ;; thumb
       (outside-scroll-bar-setting item sb-handle)
       (scroll-bar-setting item))
     (case part
       (#.#$kControlUpButtonPart :in-up-button)
       (#.#$kControlDownButtonPart :in-down-button)
       (#.#$kControlPageUpPart :in-page-up)
       (#.#$kControlPageDownPart  :in-page-down)
       (#.#$kcontrolIndicatorPart :in-thumb)
       (t nil)))))

(eval-when (:compile-toplevel :execute)
  (require "LISPEQU"))                  ; for $ptask_draw-flag


(defun track-scroll-bar-thumb (item)
  (let* ((old-setting (scroll-bar-setting item))
         (min (scroll-bar-min item))
         (max (scroll-bar-max item))
         (horizontal? (eq (scroll-bar-direction item) :horizontal))
         (position (view-position item))
         (last-mouse (rref *current-event* :eventRecord.where))
         (size (view-size item))
         (real-time-tracking (scroll-bar-track-thumb-p item))
         width length old-mouse left right mouse setting)
    ; disable periodic tasks that draw
    ;; I have no idea why we need the osx-p thing here! akh
    (progn ;with-periodic-task-mask ((if (osx-p) 0 $ptask_draw-flag) t)
      (setq last-mouse
            ; global-to-local
            (add-points (view-origin item)
                        (subtract-points last-mouse (view-position (view-window item)))))
      (if horizontal?
        (setq width (point-v size)
              length (- (point-h size) width width width)
              left (+ (round (* width 3) 2) (point-h position))
              old-mouse (point-h last-mouse))
        (setq width (point-h size)
              length (- (point-v size) width width width)
              left (+ (round (* width 3) 2) (point-v position))
              old-mouse (point-v last-mouse)))
      (setq right (+ left length))
      (loop
        (when (not (#_stilldown))          
          (return))
        (setq mouse (view-mouse-position item))
        (when (eql mouse last-mouse)
          (when (not (wait-mouse-up-or-moved))            
            (return))
          (setq mouse (view-mouse-position item)))
        (unless (eql mouse last-mouse)
          (setq last-mouse mouse)
          (setq mouse (if horizontal? (point-h mouse) (point-v mouse)))
          (setq setting (min max
                             (max min
                                  (+ old-setting
                                     (round (* (- mouse old-mouse) (- max min))
                                            (- right left))))))
          (if real-time-tracking
            (track-scroll-bar item setting :in-thumb)
            (set-scroll-bar-setting item setting))))
      (unless (or real-time-tracking (not setting))
        (track-scroll-bar item setting :in-thumb)))))

; Returns the new value for the scroll bar
(defmethod track-scroll-bar ((item scroll-bar-dialog-item) value part)
  (set-scroll-bar-setting 
   item
   (case part
     (:in-up-button (- value (scroll-bar-scroll-size item)))
     (:in-down-button (+ value (scroll-bar-scroll-size item)))
     (:in-page-up (- value (scroll-bar-page-size item)))
     (:in-page-down (+ value (scroll-bar-page-size item)))
     (t value)))
  (dialog-item-action item))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;view-click-event-handler
;;
;;this is the function which is called when the user clicks in the scroll-bar
;;
;;It checks the scroll-bar part, and calls _TrackControl
;;  If appropriate, it passes a hook function to _TrackControl
;;
;;During tracking, dialog-item-action is repeatedly called.
;;


(defmethod view-click-event-handler ((item scroll-bar-dialog-item) where)
  (let* ((sb-handle (dialog-item-handle item))
         (part (#_TestControl sb-handle where)))
    (with-timer      
      (cond ((eq part #.#$kcontrolIndicatorPart)  ;; thumb
             (if (scroll-bar-track-thumb-p item)
               (track-scroll-bar-thumb item)
               (progn
                 (let ((*scroll-bar-item* item))
                   (#_TrackControl sb-handle where (%null-ptr)))
                 (track-scroll-bar
                  item (outside-scroll-bar-setting item sb-handle) :in-thumb))))
            ((memq part '(#.#$kControlUpButtonPart #.#$kControlDownButtonPart
                          #.#$kControlPageUpPart #.#$kControlPageDownPart))
             (let ((was-enabled (dialog-item-enabled-p item)))
               (let ((*scroll-bar-item* item))
                 (#_TrackControl sb-handle where scroll-bar-proc))
               ; The ROM enables on its way out
               (when (and was-enabled (not (dialog-item-enabled-p item)))
                 (#_deactivatecontrol sb-handle))))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;dialog-item-action
;;
;;The default dialog-item-action for a scroll bar calls
;;scroll-bar-changed on the scrollee
;;
(defmethod dialog-item-action ((item scroll-bar-dialog-item))
  (let ((f (dialog-item-action-function item)))
    (if f
      (funcall f item)
      (let ((scrollee (scroll-bar-scrollee item)))
        (when scrollee
          (scroll-bar-changed scrollee item))))
    (when t ;(osx-p)  ;; aargh
      (with-port-macptr port
        (#_QDFlushPortBuffer port (%null-ptr))))))

(defmethod scroll-bar-changed (view scroll-bar)
  (declare (ignore view scroll-bar)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(setf scroll-bar-setting)
;;
;;a nice safe Lisp-level function for changing the value of the scroll-bar
;;The accessor is defined by the DEFCLASS
;;

(defmethod (setf scroll-bar-setting) (new-value (item scroll-bar-dialog-item))
  (set-scroll-bar-setting item new-value))

(defmethod set-scroll-bar-setting ((item scroll-bar-dialog-item) new-value)
  (setq new-value (require-type new-value 'fixnum))
  (%set-scroll-bar-setting item new-value t))

(defun %set-scroll-bar-setting (item new-value only-if-new-value)
  (setq new-value (max (scroll-bar-min item) (min (scroll-bar-max item) new-value)))
  (unless (and only-if-new-value (eql new-value (scroll-bar-setting item)))
    (let ((handle (dialog-item-handle item)))
      (when handle
        (with-focused-view (view-container item)
          (#_SetControlValue 
           handle 
           (mac-scroll-bar-setting 
            new-value 
            (scroll-bar-min item) 
            (scroll-bar-max item))))))
    (setf (slot-value item 'setting) new-value))
  new-value)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;scroll-bar-min is a :reader for the class
;;here's the setter
;;
(defmethod (setf scroll-bar-min) (new-value (item scroll-bar-dialog-item))
  (set-scroll-bar-min item new-value))

(defmethod set-scroll-bar-min ((item scroll-bar-dialog-item) new-value)
  (setq new-value (require-type new-value 'fixnum))
  (unless (eql new-value (scroll-bar-min item))
    (setf (slot-value item 'min) new-value)
    (update-scroll-bar-max-min-setting item))
  new-value)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;scroll-bar-max is a :reader for the class
;;here's the setter
;;
(defmethod (setf scroll-bar-max) (new-value (item scroll-bar-dialog-item))
  (set-scroll-bar-max item new-value))

(defmethod set-scroll-bar-max ((item scroll-bar-dialog-item) new-value)
  (setq new-value (require-type new-value 'fixnum))
  (unless (eql new-value (scroll-bar-max item))
    (setf (slot-value item 'max) new-value)
    (update-scroll-bar-max-min-setting item))
  new-value)

(defun update-scroll-bar-max-min-setting (item)
  (let ((handle (dialog-item-handle item)))
    (when handle
      (with-focused-view (view-container item)
        (let ((max (scroll-bar-max item))
              (min (scroll-bar-min item))
              (setting (scroll-bar-setting item)))
          (multiple-value-bind (mac-min mac-max) (mac-scroll-bar-min-max min max)
            (let ((mac-setting (mac-scroll-bar-setting setting min max mac-min mac-max)))
              #-carbon-compat
              (setf (href handle :controlrecord.contrlmin) mac-min
                    (href handle :controlrecord.contrlmax) mac-max
                    (href handle :controlrecord.contrlvalue) mac-setting)
              #+carbon-compat
              (progn
                (#_Setcontrolminimum handle mac-min)
                (#_setcontrolmaximum handle mac-max)
                (#_Setcontrolvalue handle mac-setting))
              (invalidate-view item))))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;scroll-bar-length
;;
;;this is a variation of view-size
;;
;;It only used one dimension, since scroll-bars almost always have a width
;;  of 16 pixels.
;;

(defmethod scroll-bar-length ((item scroll-bar-dialog-item))
  (let* ((size (view-size item))
         (splitter (pane-splitter item))
         (splitter-size (and splitter (view-size splitter))))
    (if (eq (scroll-bar-direction item) :horizontal)
      (+ (point-h size) (if splitter (point-h splitter-size) 0))
      (+ (point-v size) (if splitter (point-v splitter-size) 0)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;set-scroll-bar-length
;;
;;sets the length of the scroll-bar
;;
;;Note that because of the way this is implemented, you MUST
;;change the length of a scroll bar with a splitter with
;;set-scroll-bar-length, not by calling set-view-size directly
;;

(defun (setf scroll-bar-length) (new-length scroll-bar-dialog-item)
  (set-scroll-bar-length scroll-bar-dialog-item new-length))

(defmethod set-scroll-bar-length ((item scroll-bar-dialog-item) new-length)
  (let ((splitter (pane-splitter item))
        (direction (scroll-bar-direction item))
        (inner-length new-length))
    (when splitter
      (let ((size (view-size splitter)))
        (decf inner-length
              (min inner-length
                   (if (eq direction :horizontal) (point-h size) (point-v size))))))
    (set-view-size item (if (eq direction :horizontal)
                          (make-point inner-length (scroll-bar-width item))
                          (make-point (scroll-bar-width item) inner-length)))
    (when splitter
      (let ((dir (scroll-bar-direction splitter))
            (pos (pane-splitter-position item))
            (bar-pos (view-position item)))
        (cond ((and (eq dir :vertical) (memq pos '(:bottom  t)))
               (set-view-position splitter  (make-point (point-h bar-pos)
                                                        (+ (point-v bar-pos)
                                                           inner-length))))
              ((and (eq dir :horizontal) (memq pos '(:right t)))
               (set-view-position splitter (make-point (+ (point-h bar-pos)
                                                          inner-length)
                                                       (point-v bar-pos))))))))              
  new-length)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;scroll-bar-width
;;
;; Sometimes you want a different width
;;
(defmethod scroll-bar-width ((item scroll-bar-dialog-item))
  (let ((size (view-size item)))
    (if (eq (scroll-bar-direction item) :horizontal)
      (point-v size)
      (point-h size))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;set-scroll-bar-width
;;
;;sets the width of the scroll-bar
;;
;;Note that because of the way this is implemented, you MUST
;;change the width of a scroll bar with a splitter with
;;set-scroll-bar-width, not by calling set-view-size directly
;;

(defun (setf scroll-bar-width) (new-length scroll-bar-dialog-item)
  (set-scroll-bar-width scroll-bar-dialog-item new-length))

(defmethod set-scroll-bar-width ((item scroll-bar-dialog-item) new-width)
  (let ((size (view-size item)))
    (set-view-size item (if (eq (scroll-bar-direction item) :horizontal)
                          (make-point (point-h size) new-width)
                          (make-point new-width (point-v size)))))
  (let ((splitter (pane-splitter item)))
    (if splitter
      (let ((size (view-size splitter)))
        (set-view-size splitter (if (eq (scroll-bar-direction splitter) :horizontal)
                              (make-point (point-h size) new-width)
                              (make-point new-width (point-v size)))))))
  new-width)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(setf scroll-bar-scrollee)
;;
;;Change the scrollee of a scroll-bar
;;
(defun (setf scroll-bar-scrollee) (new-scrollee scroll-bar-dialog-item)
  (set-scroll-bar-scrollee scroll-bar-dialog-item new-scrollee))

(defmethod set-scroll-bar-scrollee ((item scroll-bar-dialog-item) new-scrollee)
  (let ((old-scrollee (scroll-bar-scrollee item)))
    (when old-scrollee
      (delete-view-scroll-bar old-scrollee item)))
  (add-view-scroll-bar new-scrollee item)
  (let ((splitter (pane-splitter item)))
    (if splitter (set-scroll-bar-scrollee splitter new-scrollee)))
  (setf (slot-value item 'scrollee) new-scrollee))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pass set-view-container and set-view-position
;; to the pane-splitter
;;
(defmethod set-view-container ((item scroll-bar-dialog-item) new-container)
  (let ((splitter (pane-splitter item))
        (old-container (view-container item)))
    (when splitter
      (set-view-container splitter new-container))
    (call-next-method)
    (when (and new-container (neq old-container new-container)) 
      (multiple-value-bind (tl br) (scroll-bar-and-splitter-corners item)
        (invalidate-corners new-container tl br)))))

(defmethod set-view-position ((item scroll-bar-dialog-item) h &optional v)  
  (let ((pos (make-point h v))
        (splitter (pane-splitter item))
        (splitter-position (pane-splitter-position item)))
    (setq h (point-h pos) v (point-v pos))
    (when splitter
      (let ((size (view-size item))
            (s-size (view-size splitter)))
        (if (eq (scroll-bar-direction item) :horizontal)
          (if (eq splitter-position :left)
            (progn (set-view-position splitter pos)
                   (incf h (point-h s-size)))
            (set-view-position splitter (+ h (point-h size)) v))
          (if (eq splitter-position :top)
            (progn (set-view-position splitter pos)
                   (incf v (point-v s-size)))
            (set-view-position splitter h (+ v (point-v size)))))))
  (call-next-method item h v)))
    
(defmethod corrected-view-position ((item scroll-bar-dialog-item))
  (let ((splitter (pane-splitter item)))
    (if (and splitter (memq (pane-splitter-position item) '(:top :left)))
      (view-position splitter)
      (view-position item))))

; Change the relative position of a scroll bar's pane splitter.
;  :top <-> :bottom
; :left <-> :right
(defmethod set-pane-splitter-position ((item scroll-bar-dialog-item) pos)
  (let ((position (corrected-view-position item)))
    (setf (slot-value item 'pane-splitter-position) pos)
    (set-view-position item position))
  pos)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; set-view-size needs to invalidate the entire scroll bar
;; if it is inactive.
;;
(defmethod set-view-size ((view scroll-bar-dialog-item) h &optional v)
  (declare (ignore h v))
  (without-interrupts
   (prog1
     (call-next-method)
     (let ((w (view-window view)))
       (when w
         (unless (window-active-p w)
           (multiple-value-bind (tl br) (scroll-bar-and-splitter-corners view)
             (invalidate-corners 
              (view-container view) (add-points tl #@(1 1)) br t))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Methods for pane-splitter
;;
(defmethod initialize-instance ((item pane-splitter) &rest initargs
                                &key (width 16) (length 5) (direction :vertical))
  (declare (dynamic-extent initargs))
  (let ((size (if (eq direction :vertical)
                (make-point width length)
                (make-point length width))))
    (apply #'call-next-method
           item
           :view-size size
           :direction direction
           initargs)))

(defparameter *gray-color* #x808080) ;; from color.lisp - boot prob
(defparameter *dark-gray-color* #x404040) ;; ditto
(defmethod view-draw-contents ((item pane-splitter))
  (let ((active-p (window-active-p (view-window item))))
    (let* ((tl (view-position item))
           (br (add-points tl (view-size item))))
      (rlet ((r :rect :topleft tl :botright br))
        (with-fore-color (if active-p *dark-gray-color* *gray-color*)
          (#_paintrect r))))))


(defmethod pane-splitter-limiting-container ((scrollee simple-view))
  (view-window scrollee))

(defmethod view-click-event-handler ((item pane-splitter) where)
  ;(declare (ignore where))
  (let* ((scrollee (or (scroll-bar-scrollee item) (view-window item)))
         (container (pane-splitter-limiting-container scrollee))
         (scroll-bar (scroll-bar item)))
    (when container
      (when (double-click-p)
        (when (pane-splitter-handle-double-click scrollee item where)
          (return-from view-click-event-handler)))
      (multiple-value-bind (s-tl s-br)
                           (pane-splitter-corners scrollee scroll-bar)
        (let* ((direction (scroll-bar-direction item))
               (mouse-pos (convert-coordinates where (view-container item) container)) ;(view-mouse-position container))
               min max min-pos max-pos drawn pos-accessor line-direction delta pos)
          (if (eq direction :vertical)
            (setq min (1+ (point-h s-tl))
                  max (- (point-h s-br) 2)
                  min-pos (1+ (point-v s-tl))
                  max-pos (- (point-v s-br) 2) 
                  pos-accessor #'point-v
                  line-direction :horizontal)
            (setq min (1+ (point-v s-tl))
                  max (- (point-v s-br) 2)
                  min-pos (1+ (point-h s-tl))
                  max-pos (- (point-h s-br) 2)
                  pos-accessor #'point-h
                  line-direction :vertical))
          ; Compute the initial position for the outline.
          ; All this rigamarole is to convert from the window's coordinate system
          ; to the scrollee's and back again.
          (setq pos
                (let ((pos (pane-splitter-outline-position 
                            scrollee scroll-bar
                            (convert-coordinates mouse-pos container scrollee))))
                  (funcall pos-accessor
                           (convert-coordinates
                            pos
                            scrollee
                            container)))
                delta (- pos (funcall pos-accessor mouse-pos)))
          ; Now loop until mouse up.
          (flet ((draw-line (pos)
                    (draw-pane-splitter-outline
                     scrollee scroll-bar pos min max line-direction)))
            (declare (dynamic-extent #'draw-line))
            (multiple-value-setq (pos drawn)
             (track-and-draw container #'draw-line pos direction delta min-pos max-pos)))
          ; Convert back to scrollee's coordinate system
          (setq pos (funcall pos-accessor (convert-coordinates 
                                           (if (eq direction :horizontal)
                                             (make-point pos 0)
                                             (make-point 0 pos))
                                           container 
                                           scrollee)))
          ; And call the user method to actually do something.
          (split-pane scrollee scroll-bar pos direction drawn))))))

; This controls the position of the outline when the mouse is first clicked.
; mouse-position is the position of the mouse in the coordinate system of
; the scrollee.
; The default method draws the outline right where the mouse is.
(defmethod pane-splitter-outline-position (scrollee scroll-bar mouse-position)
  (declare (ignore scrollee scroll-bar))
  mouse-position)

(defmethod draw-pane-splitter-outline (scrollee scroll-bar pos min max direction)
  (declare (ignore scrollee scroll-bar))
  (if (eq direction :horizontal)
    (progn (#_MoveTo min pos)
           (#_LineTo max pos))
    (progn (#_MoveTo pos min)
           (#_LineTo pos max))))

; Some users may want to specialize on this
(defmethod pane-splitter-corners ((scrollee simple-view) scroll-bar)
  (declare (ignore scroll-bar))
  (let* ((window (view-window scrollee))
         (container (view-container scrollee)))
    (multiple-value-bind (tl br) (view-corners scrollee)
      (when (and container (neq container window))
        (setq tl (convert-coordinates tl container window)
              br (convert-coordinates br container window)))
      (values tl br))))

; This is the method that all users will specialize on if they
; want a pane-splitter to do anything but draw a line.
(defmethod split-pane ((scrollee simple-view) scroll-bar pos direction inside-limits)
  (declare (ignore scroll-bar pos direction inside-limits)))

; Users need to specialize this if they want double clicks to do anything
; It should return true to denote that it handled the double click.
; Otherwise, the double click will be treated just like a single click.
(defmethod pane-splitter-handle-double-click ((scrollee simple-view) pane-splitter where)
  (declare (ignore pane-splitter where))
  nil)

;;;;;;;;;;;;;;;
;; support for mouse wheel maybe?


;; point is in window coordinates
#+carbon-compat
(defun find-scroll-bar-controlling-point (view direction point)
  (let ((window (view-window view)))
    (do-subviews (s view)
      (if (and (typep s 'scroll-bar-dialog-item)
               (dialog-item-enabled-p s)
               (eq (scroll-bar-direction s) direction))
        (progn
          (when (view-contains-point-p
                 s 
                 (convert-coordinates point window (view-container s)))
            (return s))
          (let ((scrollee (scroll-bar-scrollee s)))
            (when (view-contains-point-p 
                   scrollee 
                   (convert-coordinates point window (view-container scrollee)))
              (return s))))
        (let ((found (find-scroll-bar-controlling-point s direction point)))
          (if found (return found)))))))

#+carbon-compat
;(add-pascal-upp-alist 'scroll-wheel-handler-proc #'(lambda (procptr)(#_neweventhandlerupp procptr)))
(add-pascal-upp-alist-macho 'scroll-wheel-handler-proc "NewEventHandlerUPP")


#|
(defpascal scroll-wheel-handler-proc (:ptr targetref :ptr eventref :word)
  (declare (ignore targetref))
  (let ((res #$eventnotHandledErr) direction delta)
    (rlet ((axis :unsigned-integer)
           ;(out-type :ptr)
           (wherep :point))
      (errchk (#_GetEventParameter eventref #$keventParamMouseWheelAxis  #$typeMouseWheelAxis *null-ptr* 2 *null-ptr* axis))
      (let* ((the-axis (%get-word axis)))
        (setq direction
              (if (eql the-axis #$kEventMouseWheelAxisX)
                :horizontal
                (if (eql the-axis #$kEventMouseWheelAxisY)
                  :vertical))))
      (when direction        
        (errchk (#_GetEventParameter eventref #$kEventParamMouseLocation #$typeQDPoint *null-ptr*
         (record-length :point) *null-ptr* wherep))
        (rlet ((deltap :signed-long))
          (errchk (#_GetEventParameter eventref #$kEventParamMouseWheelDelta #$typeLongInteger *null-ptr*
           (record-length :signed-long)  *null-ptr* deltap))
          (setq delta (%get-signed-long deltap)))
        (let (( w (front-window)))
          (WHEN (and W (view-contains-point-p w (%get-point wherep)))
            (with-port (wptr w)
              (let ((window-pos))
                (setq window-pos (%GET-point (#_globaltolocal whereP)))
                (let ((scroll-bar (find-scroll-bar-controlling-point w direction window-pos)))
                  (when scroll-bar
                    (let ((by-page (>= (abs delta)(scroll-bar-page-size scroll-bar))))
                      (track-scroll-bar scroll-bar (scroll-bar-setting scroll-bar)
                                        (if (minusp delta) 
                                          (if by-page :in-page-up :in-up-button)
                                          (if by-page :in-page-down :in-down-button)))
                      (setq res #$noerr))))))))))
    ; res
    #$noerr  ;; ??
    ))
|#

;; screwed up in new header translations - also used in l1-highlevel-events - fixed now
#+ignore
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defconstant traps::$typeLongInteger :|long|)
  (defconstant traps::$typeSint32  :|long|)  
  )
;; from Waldemar

(defvar *wheel-scroll-factor* nil "Integer multiplier for both horizontal and vertical scrolling in case
  you need additional speed beyond that provided by the 'Scrolling Speed' item in the Mouse preference
  pane, or in cases where that option is not provided. Set to nil or 1 for no effect.")

(defvar *horizontal-wheel-scroll-factor* 10 "Quantum for horizontal wheel scrolling. Essentially
   the minimum number of pixels to shift when horizontal scrolling. This value is multiplied
   by *wheel-scroll-factor* (if non-nil) for horizontal speed adjustment, thus this value is
   allowed to be a float <1 so you can slow down horizontal scrolling if necessary. Set to nil
   or 1 for no effect. It is meaningful to have a non-nil value here even if *wheel-scroll-factor*
   is nil.")

; If you have a 'Scrolling Speed' item in your Mouse preference pane, use it. The defaults above should suffice.
; If you don't have this preference, the defaults may feel too slow. Try setting both to 4 and go from there.
; Set *wheel-scroll-factor* to 0 to globally disable mouse wheel scrolling.

(defmethod adjust-horizontal-wheel-speed ((w t) delta)
  "Specialize if needed for different types of windows."
  (if (numberp *horizontal-wheel-scroll-factor*)
    (round (* delta *horizontal-wheel-scroll-factor*))
    delta))

(defmethod scroll-wheel-handler ((w t) delta direction wherep)
  ; belt and suspenders
  (declare (ignore delta direction wherep))
  ;(format t "Attempting to wheel scroll ~S" w)
  #$noerr)

(defmethod scroll-wheel-handler ((w simple-view) delta direction wherep)
  "Default method for any viewlike thing that doesn't have its own specialized handler. Just
   punt back out to the handler for the enclosing window."
  ;(format t "Attempting to wheel scroll ~S" w)
  (setf w (view-window w))
  (if w
    (scroll-wheel-handler w delta direction wherep)
    #$noerr))

(defmethod scroll-wheel-handler ((w window) delta direction wherep)
  "Default handler for Fred windows and most everything else. Now makes
   both horizontal (shift-wheel) and vertical scrolling in Fred windows instantaneous."
  (declare (ignore-if-unused wherep))
  (let ((res #$eventNotHandledErr))
    (progn ;with-port (wptr w)
      (let ((window-pos))
        ;(#_globaltolocal wherep)
        ;(setq window-pos (%get-point wherep))
        (setq window-pos (view-mouse-position w))
        (let ((scroll-bar (find-scroll-bar-controlling-point w direction window-pos)))
          (when scroll-bar
            (cond ((and (typep scroll-bar 'fred-v-scroll-bar) ; this is essential
                        (eq direction :vertical))             ; but this may be redundant?
                   ; Don't use a loop on the commonest and most speed-sensitive cases
                   (let* ((view (scroll-bar-scrollee scroll-bar))
                          (frec (frec view)) ; meaningless for non fred-v-scroll-bars
                          (mark (fred-display-start-mark view))
                          )
                     (set-fred-display-start-mark
                      view
                      (frec-screen-line-start frec mark (- delta))
                      )))
                  ((and (typep scroll-bar 'fred-h-scroll-bar)
                        (eq direction :horizontal))            ; ditto
                   (let* ((view (scroll-bar-scrollee scroll-bar))
                          (hscroll (fred-hscroll view)))
                     (declare (fixnum hscroll))
                     (set-fred-hscroll view
                                       (if (and (= 0 hscroll)
                                                (< delta 0))
                                         (fred-margin view)
                                         (- hscroll (adjust-horizontal-wheel-speed w delta))))
                     (fred-update view)
                     #+ignore
                     (when (osx-p)
                       ;; work around crock - wish I knew why needed
                       ;(view-draw-contents scroll-bar) ; doesn't seem needed here
                       )
                     ))
                  (t ; do it the old way on all other cases
                   (when delta
                     (dotimes (count (abs delta)) 
                       (track-scroll-bar scroll-bar (scroll-bar-setting scroll-bar)
                                         (if (minusp delta) :in-down-button :in-up-button))))))
            (setq res #$noerr)))))
    res))

#|
(defun tstit ()
  (let ((w (find-view-containing-point nil (view-mouse-position nil) nil t))) ;; just get the window
    (when w
      (print w)
      (let* ((window-pos (view-mouse-position w))
             (scroll-bar (find-scroll-bar-controlling-point w :vertical window-pos)))
        (when scroll-bar (list scroll-bar (scroll-bar-scrollee scroll-bar)))))))
|#

(defpascal scroll-wheel-handler-proc (:ptr targetref :ptr eventref :word)
  (declare (ignore targetref))
  (let ((res #$eventNotHandledErr) direction delta)
    (rlet ((axis :unsigned-integer)
           ;(out-type :ptr)
           (wherep :point))
      (#_GetEventParameter eventref #$keventParamMouseWheelAxis #$typeMouseWheelAxis (%null-ptr) 2 (%null-ptr) axis)
      (let* ((the-axis (%get-word axis)))
        (setq direction
              (if (eq the-axis #$kEventMouseWheelAxisX)
                :horizontal
                (if (eq the-axis #$kEventMouseWheelAxisY)
                  :vertical))))
      (when direction
        ;#+ignore ;; wherep not used?
        (#_GetEventParameter eventref #$kEventParamMouseLocation #$typeQDPoint (%null-ptr)
         (record-length :point) (%null-ptr) wherep)
        (rlet ((deltap :signed-long))
          (#_GetEventParameter eventref #$kEventParamMouseWheelDelta #$typeLongInteger (%null-ptr)
           (record-length :signed-long)  (%null-ptr) deltap)
          (setq delta (%get-signed-long deltap)))
        (when (integerp *wheel-scroll-factor*)
          (setq delta (* delta *wheel-scroll-factor*)))
        ; NB: delta is affected both by how fast you spin the wheel and by the Scrolling Speed setting
        ;     in the Mouse preference pane.
        (let ((w (find-view-containing-point nil (%get-point wherep) ))) ; Look for deepest view first.
                                                                         ; If it doesn't have its own handler, bounce back up to the window handler.
          (when w
            (setq res (scroll-wheel-handler w delta direction wherep))
            ))))
    res     
    ))

#+carbon-compat
(def-ccl-pointers wheel ()
  (#_installeventhandler (#_getapplicationEventTarget) scroll-wheel-handler-proc 1
   (make-record :eventtypespec 
                :eventclass #$kEventClassMouse
                :eventkind #$kEventMouseWheelMoved)
   (%null-ptr) (%null-ptr)))




(provide 'scroll-bar-dialog-items)

#|
;; a simple example.
;; Shows what the :track-thumb-p initarg does.
;; Also shows two different ways to make the scroll bar work:
;; 1) scroll bar's dialog-item-action does the work
;; 2) scrollee's scroll-bar-changed method does the work.

(defclass scroll-bar-display (static-text-dialog-item) ())

(defmethod scroll-bar-changed ((scrollee scroll-bar-display)
                               scroll-bar)
  (set-dialog-item-text
   scrollee (format nil "~3d" (scroll-bar-setting scroll-bar)))
  (view-focus-and-draw-contents scrollee))

(defun scroll-bar-example ()
  (let* ((dialog (make-instance 'dialog
                   :view-size #@(250 145)
                   :window-title "Scroll Bar Example"))
         (display (make-instance 'scroll-bar-display
                    :view-position #@(25 80)
                    :dialog-item-text "000"
                    :view-container dialog)))
    ; This scroll bar gets its work done via scroll-bar-changed
    ; And will update immediately when you drag its thumb.
    (make-instance 'scroll-bar-dialog-item
      :view-position #@(25 120)
      :direction :horizontal
      :length 200
      :scrollee display
      :view-container dialog
      :track-thumb-p t)

    ; this scroll bar does it's work itself
    ; and will respond to a thumb drag only after you're done.
    (make-instance 'static-text-dialog-item
      :view-position #@(25 10)
      :dialog-item-text "000"
      :view-nick-name 'display-text
      :view-container dialog)
    (make-instance 'scroll-bar-dialog-item
      :view-position #@(25 50)
      :direction :horizontal
      :length 200
      :view-container dialog
      :track-thumb-p nil
      :dialog-item-action
      #'(lambda (item &aux (setting (format nil "~a"
                                            (scroll-bar-setting item))))
          (set-dialog-item-text
           (find-named-sibling item 'display-text)
           setting)
          (window-update-event-handler (view-window item))))))

(scroll-bar-example)


|#

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
