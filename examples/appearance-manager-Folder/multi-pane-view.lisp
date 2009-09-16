;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; multi-pane-view.lisp
;;;
;;; A VIEW WITH MULTIPLE PANES AND A TAB BAR TO SWITCH AMONG THEM.
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
;;; Authors: Eric Russell <eric-r@nwu.edu> (ER), Terje Norderhaug <terje@in-progress.com>  (TN)
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CHANGE HISTORY
;;;
;;; Nov-9-1998 ER Change select-pane->view-select-pane & selected-pane->get-selected-pane to avoid package conflicts
;;; Nov-9-1998 ER Moved to ccl package and integrated with the appearance-manager module
;;; Nov-7-1998 TN Added select-pane method to allow specialization
;;;
;;; TN = Terje Norderhaug <terje@in-progress.com>

(in-package :ccl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :appearance-manager "ccl:examples;appearance-manager-folder;appearance-manager")
  (require :appearance-globals)
  (require :tab-bar-view "ccl:examples;appearance-manager-folder;tab-bar-view"))

(export '(multi-pane-view 
          add-pane
          remove-pane
          get-pane  
          view-select-pane
          size-pane
          get-selected-pane 
          set-selected-pane))

;;;----------------------------------------------------------------------
;;; The class

(defclass multi-pane-view (view)
  ((active-pane :accessor active-pane :initform nil)
   (tab-bar :accessor tab-bar :initform nil)
   (pane-title-alist :accessor pane-title-alist :initform nil)))  

;;;----------------------------------------------------------------------
;;; Add the tab bar when we're initialized

(defmethod initialize-instance ((view multi-pane-view)
                                &rest initargs
                                &key
                                (tab-font '("Geneva" 9 :bold))
                                (tab-bar-height 20))
  (declare (ignore initargs))
  (call-next-method)
  (let ((tab-bar (make-instance 'tab-bar-view
                   :view-position #@(0 0)
                   :view-size     (make-point (point-h (view-size view))
                                              tab-bar-height)
                   :view-font      tab-font)))
    (setf (tab-bar view) tab-bar)
    (set-view-container tab-bar view)))

;;;----------------------------------------------------------------------
;;; Adding or removing a pane to/from the view

(defmethod add-pane ((view multi-pane-view) pane title)
  (add-tab (tab-bar view) 
           title
           #'(lambda ()
               (view-select-pane view pane)))
  (push (cons pane title) (pane-title-alist view))
  (unless (active-pane view)
    (view-select-pane view pane)))

(defmethod view-select-pane ((view multi-pane-view) pane)
  (let ((active-pane (active-pane view)))
    (when active-pane
      (set-view-container active-pane nil))
    (size-pane view pane)
    (setf (active-pane view) pane)
    (set-view-container pane view)))

(defmethod get-pane ((view multi-pane-view) title)
  (car (rassoc title (pane-title-alist view) :test #'string=)))

(defmethod remove-pane ((view multi-pane-view) &key pane title)
  (let* ((pane-title (if title
                       title
                       (cdr (assoc pane (pane-title-alist view))))))
    (remove-tab (tab-bar view) pane-title)
    (setf (pane-title-alist view)
          (delete pane-title
                  (pane-title-alist view)
                  :test #'string=
                  :key  #'cdr))))

(defmethod get-selected-pane ((view multi-pane-view))
  (let ((button (find-if #'selected-p (view-subviews (tab-bar view)))))
    (when button
      (dialog-item-text button))))

(defmethod set-selected-pane ((view multi-pane-view) title)
  (let ((button (find title 
                      (view-subviews (tab-bar view))
                      :test #'string=
                      :key  #'dialog-item-text)))
    (when button
      (dialog-item-action button))))

;;;----------------------------------------------------------------------
;;; Sizing our parts

(defmethod set-view-size ((view multi-pane-view) h &optional v)
  (declare (ignore h v))
  (prog1 (call-next-method)
    (let ((tab-bar     (tab-bar view))
          (active-pane (active-pane view)))
      (when tab-bar
        (set-view-size tab-bar
                       (point-h (view-size view))
                       (point-v (view-size tab-bar))))
      (when active-pane
        (size-pane view active-pane)))))

(defmethod size-pane ((view multi-pane-view) pane)
  (let ((size (view-size view))
        (tab-height (point-v (view-size (tab-bar view)))))
    (set-view-position pane 2 tab-height)
    (set-view-size pane 
                   (- (point-h size) 2)
                   (- (point-v size)
                      tab-height
                      2))))

;;;----------------------------------------------------------------------
;;; Drawing

(defmethod view-draw-contents ((view multi-pane-view))
  (call-next-method)
  (let ((top (point-v (view-size (tab-bar view))))
        (botright (subtract-points (view-size view) #@(1 1))))
    (with-fore-color *black-color*
      (#_MoveTo :word 0 :word top)
      (#_LineTo :word 0 :word (point-v botright))
      (#_LineTo :long botright)
      (#_LineTo :word (point-h botright) :word top))
    (with-fore-color *white-color*
      (#_MoveTo :word 1 :word top)
      (#_LineTo :word 1 :word (1- (point-v botright))))
    (with-fore-color +shadow-color+
      (#_LineTo :long (subtract-points botright #@(1 1)))
      (#_LineTo :word (1- (point-h botright)) :word top))))

;;;----------------------------------------------------------------------

(provide :multi-pane-view)

;;;----------------------------------------------------------------------
;;; Testing

#|

(unless (boundp '*w*)
  (defvar *w*))

(defun test-mpv ()
  (setq *w* (make-instance 'window
              :back-color ccl::+background-color+))
  (let ((pane-1 (make-instance 'view
                  :view-subviews (list 
                                  (make-instance 'static-text-dialog-item
                                    :view-position #@(10 10)
                                    :dialog-item-text "Foo"))))
        (pane-2 (make-instance 'view
                  :view-subviews (list
                                  (make-instance 'static-text-dialog-item
                                    :view-position #@(32 10)
                                    :dialog-item-text "Bar"))))
        (pane-3 (make-instance 'view
                  :view-subviews (list
                                  (make-instance 'static-text-dialog-item
                                    :view-position #@(54 10)
                                    :dialog-item-text "Baz"))))
        (view   (make-instance 'multi-pane-view
                  :view-position #@(10 10)
                  :view-size     #@(300 120)
                  :tab-font      '("Chicago" 12)
                  :tab-bar-height 22)))
    (add-pane view pane-1 "Page One")
    (add-pane view pane-2 "Page Two")
    (add-pane view pane-3 "Page Three")
    (set-view-container view *w*)))

(test-mpv)

|#