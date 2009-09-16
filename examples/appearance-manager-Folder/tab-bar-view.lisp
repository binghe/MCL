;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; tab-bar-view.lisp
;;;
;;; A VIEW WITH TABS FOR A MULTI-PANE VIEW
;;;
;;; Copyright ©1996-1999
;;; Supportive Inquiry Based Learning Environments Project
;;; Learning Sciences Program
;;; School of Education & Social Policy
;;; Northwestern University
;;;
;;; Use and copying of this software and preparation of derivative works
;;; based upon this software are permitted, so long as this copyright 
;;; notice is included intact.
;;;
;;; This software is made available AS IS, and no warranty is made about 
;;; the software or its performance. 
;;;
;;; Authors: Eric Russell <eric-r@nwu.edu>, Terje Norderhaug <terje@in-progress.com> 
;;;
;;; Version: 1.1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CHANGE HISTORY
; jun 16 2006 #_drawstring -> grafport-write-string
; Dec-3-1998 ER Modify draw-tab-view and draw-tab-side to look more like real OS controls
; Nov-9-1998 ER Changed tab-side-width to constant
; Nov-9-1998 ER Mixed-in the appearance-activity-mixin for more OS-like behavior
; Nov-9-1998 ER Moved to ccl package and integrated with the appearance-manager module
; Nov-6-1998 ER Moved initial max-tab-h value to constant, since it was referenced in 2 places. 
; Nov-6-1998 ER Changed order of arguments in draw-tab-view to preserve ordering by category.
; Nov-5-1998 TN Added a width-correction to tab-view and increased its value for OS8 look.
; Nov-5-1998 TN view-default-size method instead of calculating tab-view size in add-tab
; Nov-5-1998 TN max-tab-h starts at 5 for OS8 look
; Nov-5-1998 TN view-draw-contents for tab-bar-view draw a short horizontal line before tabs
; Nov-5-1998 TN substituted font-codes-height with MCL's font-codes-line-height
; Nov-5-1998 TN substituted font-codes-ascent with MCL's font-codes-info
; Nov-5-1998 TN fill bottom line of selected tab for aestehtics
; Nov-5-1998 TN eliminated redundant code by adding a view-draw-tab method
;
; TN = Terje Norderhaug <terje@in-progress.com> 
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :appearance-utile "ccl:examples;appearance-manager-folder;appearance-utils")
  (require :appearance-manager "ccl:examples;appearance-manager-folder;appearance-manager")
  (require :appearance-activity-mixin "ccl:examples;appearance-manager-folder;appearance-activity-mixin"))

(in-package :ccl)

(export '(tab-bar-view add-tab remove-tab))

;;;----------------------------------------------------------------------
;;; Classes

(defclass tab-bar-view (view)
  ((max-tab-h :accessor max-tab-h :initform +initial-tab-h+)
   (active-tab :accessor active-tab :initform nil)))

(defclass tab-view (appearance-activity-mixin dialog-item)
  ((selected-p :accessor selected-p :initform nil)
   (ccl::width-correction :allocation :class
                          :initform +default-tab-width-correction+)))

;;;----------------------------------------------------------------------
;;; Methods for tab-view

;;;
;;; Drawing
;;;

(defmethod view-draw-contents ((view tab-view))
  (call-next-method)
  (view-draw-tab view nil (draw-active-p view)))

(defmethod hilite-view ((view tab-view) hilite-p)
  (view-draw-tab view hilite-p))

(defmethod view-draw-tab ((view tab-view) &optional hilite-p (active-p t))
  (multiple-value-bind (ff ms) (view-font-codes view)
    (with-font-codes ff ms
      (multiple-value-bind (topleft botright) (view-corners view)
        (let ((selected-p (selected-p view)))
          (draw-tab-view topleft
                         (subtract-points botright #@(1 1))
                         +default-tab-side-width+
                         (dialog-item-width-correction view)                       
                         (if hilite-p
                           *dark-gray-color*
                           (if selected-p
                             +background-color+
                             +dark-background-color+))
                         (if hilite-p
                           *dark-gray-color*
                           (if selected-p
                             +hilight-color+
                             +background-color+))
                         (if hilite-p
                           *dark-gray-color*
                           (if selected-p
                             +light-shadow-color+
                             +shadow-color+))
                         *black-color*
                         (if hilite-p
                           *dark-gray-color*
                           (if selected-p
                             +background-color+
                             *black-color*))
                         (if hilite-p
                           *white-color*
                           (if active-p
                             *black-color*
                             +shadow-color+))
                         (dialog-item-text view)
                         ff
                         ms))))))

(defun draw-tab-view (topleft
                      botright
                      tab-side-width
                      width-correction
                      back-color
                      hilight-color
                      shadow-color
                      border-color
                      baseline-color
                      text-color
                      text
                      ff
                      ms)
  (let ((left   (point-h topleft))
        (top    (point-v topleft))
        (right  (point-h botright))
        (bottom (point-v botright)))              
    (with-back-color back-color
      (let ((poly (#_OpenPoly)))
        (#_MoveTo :word (1+ left) :word (1- bottom))
        (#_LineTo :word (+ left (- tab-side-width 3)) :word (+ top 1))
        (#_LineTo :word (- right (- tab-side-width 3)) :word (+ top 1))
        (#_LineTo :word right :word bottom)
        (#_LineTo :word (1+ left) :word bottom) 
        (#_ClosePoly)
        (#_ErasePoly poly)
        (#_KillPoly poly))
      (with-fore-color shadow-color
        (draw-tab-side (1- right)
                       top
                       (- right tab-side-width 1)
                       (1- bottom))
        (draw-tab-side (1- right)
                       (1+ top)
                       (- right tab-side-width 1)
                       (1+ bottom)))
      (with-fore-color hilight-color
        (draw-tab-side (1+ left) 
                       top
                       (+ left tab-side-width 1)
                       (1- bottom))
        (#_MoveTo :word (+ left tab-side-width 1) :word (1+ top))
        (#_LineTo :word (- right tab-side-width 1) :word (1+ top))
        (draw-tab-side (1+ left)
                       (1+ top)
                       (+ left tab-side-width 1)
                       (1+ bottom)))
      (with-fore-color border-color
        (draw-tab-side left 
                       top
                       (+ left tab-side-width)
                       (1- bottom)) 
        (#_MoveTo :word (+ left tab-side-width) :word top)
        (#_Lineto :word (- right tab-side-width) :word top)
        (draw-tab-side right
                       top
                       (- right tab-side-width)
                       (1- bottom)))
      (with-fore-color baseline-color
        (#_MoveTo :word left :word bottom)
        (#_LineTo :word right :word bottom))
      (with-fore-color text-color
        #+ignore
        (with-pstrs ((text-pstr text))
          (with-font-codes ff ms
            (#_MoveTo :word (+ left width-correction) :word (+ top (font-codes-info ff ms) 4))
            (#_DrawString text-pstr)))
        #-ignore
        (with-font-codes ff ms
          (#_MoveTo :word (+ left width-correction) :word (+ top (font-codes-info ff ms) 4))
          (grafport-write-string text 0 (length text) ff ms text-color))
          ))))

(defun draw-tab-side (start-x top end-x bottom)
  (let ((arc-width (round (abs (- start-x end-x)) 3/2)))
    (rlet ((r :rect
              :left (- end-x arc-width)
              :top top
              :right (+ end-x arc-width)
              :bottom  (+ top (ash arc-width 1) 2)))
      (#_FrameArc r 0 (if (< start-x end-x) -90 90)))
    (#_MoveTo 
     :word (if (< start-x end-x)
             (- end-x arc-width)
             (+ end-x arc-width -1))
     :word (+ top arc-width -1))
    (#_LineTo start-x bottom)))

;;;
;;; Clicking
;;; 

(defmethod view-click-event-handler ((view tab-view) where)
  (declare (ignore where))
  (when (track-button-click view)
    (call-next-method)))

;;;
;;; Calculating the proper size
;;;

(defmethod view-default-size ((view tab-view))
  (tab-view-size :view view))

(defun tab-view-size (&key
                      view 
                      (text (dialog-item-text view))
                      (font (view-font view)))
  (multiple-value-bind (ff ms) (font-codes font)
    (make-point (+ (font-codes-string-width text ff ms)
                   (* 2 (dialog-item-width-correction view)))
                (+ (font-codes-line-height ff ms) 6))))

;;;----------------------------------------------------------------------
;;; Methods on tab-bar-view

;;;
;;; Drawing
;;;

(defmethod view-draw-contents ((view tab-bar-view))
  (call-next-method)
  (let* ((view-size (view-size view))
         (line-v (1- (point-v view-size))))
    (#_MoveTo :word 0 :word line-v)
    (#_LineTo :word (1- +initial-tab-h+) :word line-v)
    (#_MoveTo :word (max-tab-h view) :word line-v)
    (#_LineTo :word (1- (point-h view-size)) :word line-v)))

;;;
;;; Adding a tab
;;;

(defmethod add-tab ((view tab-bar-view) 
                    title
                    action
                    &optional (font (view-font view)))
  (let* ((tab-action #'(lambda (item)
                         (let ((old-tab (active-tab view)))
                           (when (neq old-tab item)
                             (when old-tab
                               (setf (selected-p old-tab) nil)
                               (invalidate-view old-tab))
                             (setf (selected-p item) t)
                             (setf (active-tab view) item)
                             (invalidate-view item)
                             (funcall action)))))
         (tab-view   (make-instance 'tab-view
                       :view-font font
                       :dialog-item-text title
                       :dialog-item-action tab-action)))
    (set-view-size tab-view (view-default-size tab-view))
    (set-view-position tab-view 
                       (max-tab-h view)
                       (- (point-v (view-size view))
                          (point-v (view-size tab-view))))
    (set-view-container tab-view view)
    (unless (active-tab view)
      (setf (active-tab view) tab-view)
      (setf (selected-p tab-view) t))
    (incf (max-tab-h view) (point-h (view-size tab-view)))
    tab-view))

;;;
;;; Removing a tab
;;;

(defmethod remove-tab ((view tab-bar-view) title)
  (let ((tab (find title 
                   (view-subviews view)
                   :test #'string=
                   :key  #'dialog-item-text))
        (subviews (view-subviews view)))
    (when tab
      (let ((width (point-h (view-size tab)))
            (pos (position tab subviews :test #'eq))
            (limit (1- (length subviews))))
        (when (eq tab (active-tab view))
          (let ((new-active-tab (find tab subviews :test #'neq)))
            (when new-active-tab
              (dialog-item-action new-active-tab))))
        (set-view-container tab nil)
        (do ((i pos (1+ i)))
            ((= i limit))
          (let ((other-tab (aref subviews i)))
            (set-view-position other-tab
                               (- (point-h (view-position other-tab))
                                  width)
                               (point-v (view-position other-tab)))))
        (setf (max-tab-h view) (- (max-tab-h view) width)))
      tab)))

;;;----------------------------------------------------------------------

(provide :tab-bar-view)

#|;----------------------------------------------------------------------
;;; Testing/Example

(defvar *w*)

(defun test-tv ()
  (setq *w* (make-instance 'window :back-color *lighter-gray-color*))
  (let ((bar (make-instance 'tab-bar-view
               :view-position #@(10 10)
               :view-size     #@(350 22)
               :view-font    '("Chicago" 12))))
    (add-tab bar "Protocol" #'(lambda ()))
    (add-tab bar "Connection" #'(lambda ()))
    (add-tab bar "Dialing" #'(lambda ()))
    (set-view-container bar *w*)))

(test-tv)

|#