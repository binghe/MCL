;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Dynamic Views
;;;
;;; Theory:  Have you ever wanted to rearrange the controls in a window because
;;;          they're layed out in some less-than-optimal manner?  Here is some
;;;          code that shows you how to build a window that allows movable
;;;          views.  What is missing is more code that saves the views'
;;;          positions so they can be repositioned correctly.  But hey, this
;;;          is just an example.
;;;
;;;          All the controls work, but there are no actions to back them up,
;;;          and none of the controls have drag and drop capabilities
;;;          themselves.
;;;
;;;          Hold down both the Command and Control keys to drag the views to
;;;          different locations in the same window.
;;;
;;;          This example could have been implemented two different ways:
;;;          1) each moveable view is a separate drag-aware view that moves
;;;          itself when the time is right, or 2) the window is drag-aware
;;;          and allows you to manipulate things (views) inside of it.  The
;;;          second option was chosen, as it is somewhat easier to implement
;;;          (if not entirely intuitive).  In the first implementation, the
;;;          "recipient" of the drag -- the window -- would have had to have
;;;          been marginally drag-aware in order for the Drag Manager to allow
;;;          a drop.  Since the window needed to be drag-aware anyway the
;;;          second implementation is easier as only one view, the window,
;;;          needs to perform the drag functions.  The #'drag-proxy method
;;;          is used to bounce the Drag Manager's attention from the views
;;;          to the window.
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :drag-and-drop)
  (require :icon-dialog-item)
  
  (export '(dynamic-views))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Class Definitions
;;;

;; A subclass of a window that is drag-aware.  Note that we allow only moving
;; within the view, and the only drag flavor we accept is an internal-only
;; flavor we name :|view|.
(defclass dynamic-views-dialog (color-dialog drag-view-mixin)
  ()
  (:default-initargs
    :drag-allow-copy-p nil
    :drag-allow-move-p t
    :drag-auto-scroll-p nil
    :drag-accepted-flavor-list :|view|
    )
  )

;; A simple class that we can hang methods off of.  Everything that inherits
;; from this class is moveable.
(defclass moving-view-mixin ()
  ())

;; Moveable subclasses of the items in the window.
(defclass moving-icon-view (icon-dialog-item
                            moving-view-mixin)
  ())

(defclass moving-static-text-view (static-text-dialog-item
                                   moving-view-mixin)
  ())

(defclass moving-editable-text-view (editable-text-dialog-item
                                     moving-view-mixin)
  ())

(defclass moving-checkbox-view (check-box-dialog-item
                                moving-view-mixin)
  ())

(defclass moving-button-view (button-dialog-item
                              moving-view-mixin)
  ())

(defclass moving-pop-up-menu-view (pop-up-menu
                                   moving-view-mixin)
  ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Methods for the moveable views
;;;

;; Define the drag proxy so all drag actions are bounced to the window
(defmethod drag-proxy ((view moving-view-mixin))
  (view-window view))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; The Drag & Drop stuff
;;;

;; We can drag if the mouse is over a moveable view and both modifier keys
;; are held down.
(defmethod drag-selection-p ((view dynamic-views-dialog) local-mouse-position)
  (declare (ignore local-mouse-position))
  (and (typep *mouse-view* 'moving-view-mixin)
       (command-key-p)
       (control-key-p)))

;; Don't allow drops unless they originated from the same view
(defmethod drag-allow-drop-p ((view dynamic-views-dialog))
  (if (eql view (drag-get-source-view))
    (call-next-method)
    nil))

;; Add a flavor, which is an MCL object (the view) and the drag region
;; for the view.  In a real application, there would be another method to
;; perform the actual region-building for the view, since the view's position
;; and size parameters don't work exactly right for all types of views.
(defmethod drag-add-drag-contents ((view dynamic-views-dialog))
  (let* ((view-region (new-region))
         (the-view *mouse-view*)
         (position (view-position the-view))
         (size (view-size the-view))
         (bounds (add-points position size)))
    (drag-add-mcl-object-flavor 1 :|view| the-view)
    (unwind-protect
      (progn
        (set-rect-region view-region
                         (point-h position) (point-v position)
                         (point-h bounds) (point-v bounds))
        (drag-create-item-bounds view 1 view-region))
      (dispose-region view-region)))
  t)

;; Receiving the dragged view really means just resetting its view-position.
;; First calculate the difference between the old view position and the
;; position of the mouse when the drag started, then reposition the view
;; taking that difference into account.  Note that the 'data-ptr
;; argument really is the view object; we know this because of the 'flavor
;; argument.
(defmethod drag-receive-dropped-flavor ((view dynamic-views-dialog)
                                        (flavor (eql :|view|))
                                        (data-ptr t) (data-size integer)
                                        (item-reference integer))
  (declare (ignore data-size item-reference))
  (let* ((drag-pos (drag-mouse-original-position view))
         (drop-pos (drag-mouse-drop-position view))
         (old-view-pos (view-position data-ptr))
         (offset (subtract-points drag-pos old-view-pos)))
    (set-view-position data-ptr (subtract-points drop-pos offset)))
  t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Toss up the test window
;;;
(defun dynamic-views ()
  (make-instance 'dynamic-views-dialog
    :window-type :document-with-grow
    :window-title "Dynamic Views"
    :view-position #@(6 42)
    :view-size  #@(408 361)
    :view-font  '("Chicago" 12 :srcor :plain #+ccl-3 (:color-index 0)
                  )
    :view-subviews (list
                    (make-dialog-item 'moving-icon-view
                                      #@(23 19)
                                      #@(32 32)
                                      ""
                                      'nil
                                      :view-nick-name 'icon-thing
                                      :icon 1)
                    (make-dialog-item 'moving-static-text-view
                                      #@(73 29)
                                      #@(162 16)
                                      "Some Static Text Here..."
                                      'nil
                                      :view-nick-name 'static-text-thing)
                    (make-dialog-item 'moving-editable-text-view
                                      #@(24 75)
                                      #@(357 98)
                                      "Editable Text In This View..."
                                      'nil
                                      :view-nick-name 'editable-text-thing
                                      :allow-returns t)
                    (make-dialog-item 'moving-checkbox-view
                                      #@(258 199)
                                      #@(121 16)
                                      "First Checkbox"
                                      'nil
                                      :view-nick-name 'checkbox-thing-1)
                    (make-dialog-item 'moving-checkbox-view
                                      #@(258 215)
                                      #@(137 16)
                                      "Second Checkbox"
                                      'nil
                                      :view-nick-name  'checkbox-thing-2)
                    (make-dialog-item  'moving-checkbox-view
                                       #@(258 230)
                                       #@(123 16)
                                       "Third Checkbox"
                                       'nil
                                       :view-nick-name 'checkbox-thing-3)
                    (make-dialog-item 'moving-button-view
                                      #@(23 315)
                                      #@(66 18)
                                      "Button 1"
                                      'nil
                                      :view-nick-name 'button-thing-1
                                      :default-button nil)
                    (make-dialog-item 'moving-button-view
                                      #@(99 315)
                                      #@(66 18)
                                      "Button 2"
                                      'nil
                                      :view-nick-name 'button-thing-2
                                      :default-button nil)
                    (make-dialog-item 'moving-button-view
                                      #@(176 315)
                                      #@(66 18)
                                      "Button 3"
                                      'nil
                                      :view-nick-name 'button-thing-3
                                      :default-button t)
                    (make-instance 'moving-pop-up-menu-view
                      :view-position #@(47 201)
                      :view-size  #@(104 20)
                      :menu-title ""
                      :menu-items
                      (list (make-instance
                              'menu-item
                              :menu-item-title "Item 1"
                              :style 'nil
                              :menu-item-checked #\checkmark)
                            (make-instance 'menu-item :menu-item-title "Item 2" :style 'nil)
                            (make-instance 'menu-item :menu-item-title "Item 3" :style 'nil))
                      :view-size #@(104 20)
                      :view-position #@(47 201)
                      :auto-update-default  t
                      :item-display :selection)))
  t)