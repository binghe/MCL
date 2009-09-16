;-*- Mode: Lisp; Package: (disclosure-control) -*-

;; Terje Norderhaug

;; don't say #_eraserect :ptr ..

(defpackage "DISCLOSURE-CONTROL"
  (:use :common-lisp :ccl #-carbon-compat :disclosure-triangle)
  (:export
     disclosure-control))




(in-package :disclosure-control)

(eval-when (:compile-toplevel :load-toplevel :execute) 
  
(require :appearance-manager "ccl:examples;appearance-manager-folder;appearance-manager")
(require :appearance-activity-mixin "ccl:examples;appearance-manager-folder;appearance-activity-mixin")
(require :new-control-dialog-item "ccl:examples;appearance-manager-folder;new-control-dialog-item")
)

;;;;;;;;;;;;;;;;;;;;;;;;
;; Provide a disclosure triangle a la OS8. Called Disclosure Control as this is a
;; more general term, allowing the control to have other appearances like e.g.
;; a button or checkbox if that is appropriate.

(defclass disclosure-control (#-carbon-compat dialog-item #+carbon-compat ccl::appearance-activity-mixin #+carbon-compat ccl::new-control-dialog-item )
  (#+carbon-compat
   (ccl::procid :initarg :procid :initform #$kControlTriangleProc 
                :allocation :class)
   (width-correction :allocation :class :initform 4)
   (text-justification :allocation :class :initform :left)
   (expanded :accessor expanded :initarg :expanded :initform NIL :type boolean) ; ## should be substituted with 'closed' as this is carbon...
   (show-text :reader show-text :initarg :show-text :initform "Show")
   (hide-text :reader hide-text :initarg :hide-text :initform "Hide")
   (collapsed-size :initarg :collapsed-size :initform NIL)   
   (expanded-size :accessor expanded-size :initarg :expanded-size :initform NIL))
  (:default-initargs
   :dialog-item-text "Information"))

(defmethod view-cursor ((item disclosure-control) where)
  (declare (ignore where))
  *arrow-cursor*)

(defmethod install-view-in-window :before ((item disclosure-control) dialog)
  (declare (ignore dialog))
  (update-dialog-item-text item)
  (when (and (expanded item)
             (null (slot-value item 'collapsed-size)))
    (setf (slot-value item 'collapsed-size) 
      (view-size (view-window item)))))

(defmethod remove-view-from-window :after ((item disclosure-control))
  (let ((h (dialog-item-handle item)))
    (when h
        (setf (slot-value item 'dialog-item-text)(dialog-item-text item)))
    (setf (dialog-item-handle item) nil)
    (when h (#_DisposeHandle :errchk h))))

(defmethod ccl::set-default-size-and-position ((view disclosure-control) &optional container)
  "Automatic view position"
    (unless (view-position view)
      (when (not container)(setq container (view-container view)))
      (when container
        (setf (slot-value view 'view-position)
          (make-point 5 (- (point-v (view-size container)) 16)))))
    (call-next-method))

(defmethod view-default-font ((view disclosure-control))
  #-carbon-compat '("Chicago" 12 :plain)
  #+carbon-compat (ccl::sys-font-spec))

(defmethod dialog-item-action ((view disclosure-control))
  (disclosure-control-toggle view)
  (call-next-method))

(defmethod set-dialog-item-text ((item disclosure-control) text)
  (setq text (ensure-simple-string text))
  (call-next-method)
  (update-dialog-item-text item)
  text)

(defmethod disclosure-control-text ((item disclosure-control))
  (let ((state-text 
              (if (expanded item)
                (hide-text item)
                (show-text item))))
    (concatenate 'string 
                 state-text
                 (when (and state-text (slot-value item 'dialog-item-text)) " ")
                 (slot-value item 'dialog-item-text))))  

(defmethod update-dialog-item-text ((item disclosure-control)) ;; # should be eliminated!
  "Ensure that the text displayed matches the current state"
  #-carbon-compat
  (let ((handle (or (dialog-item-handle item)
                    (setf (dialog-item-handle item) 
                      (ccl::%str-to-handle "")))))
    (ccl::%str-to-handle 
     (disclosure-control-text item)
     handle)
    (invalidate-view item)))

(defmethod view-draw-contents ((item disclosure-control))
  #+carbon-compat (call-next-method)
  #+carbon-compat ; lifted from ellipsed-dialog-item, could be from static-text-dialog-item; note that for OSX disclosure control can draw its own title...
  (when (ccl::installed-item-p item)
    (with-focused-dialog-item (item #-ccl-5.1(view-window item)) ; MCL after 5.0 focuses new-control-dialog-item on window!
      (let ((position (- (view-origin item))) ;(view-position item))
            (size (view-size item)))
        (let ((color-list (slot-value item 'ccl::color-list))
              (text-justification (slot-value item 'ccl::text-justification))
              (enabled-p (and (dialog-item-enabled-p item) (window-active-p (view-window item)))))
          (rlet ((rect :rect))
            (rset rect rect.topleft (subtract-points (add-points position #@(16 0)) #@(0 1)))
            (rset rect rect.bottomright (add-points position size))
            (with-fore-color (getf color-list :text nil)
              (cond
               ((getf color-list :text nil)
                (unless enabled-p
                  (#_TextMode #$grayishTextOr)))
               #+carbon-compat
               (T
                (#_SetThemeTextColor 
                 (if enabled-p #$kThemeTextColorDialogActive #$kThemeTextColorDialogInactive)
                 32 ;; need to be corrected
                 T)))
              (with-back-color (getf color-list :body nil)
                 (#_EraseRect rect)
                 (ccl::draw-theme-text-box (disclosure-control-text item) rect (or text-justification :left))
                ))))))
    ; for some reason this is needed, at least in os9, to avoid endless redraw...
   (validate-view item)
)
  #-carbon-compat (view-draw-disclosure-triangle item (expanded item))
  #-carbon-compat
  (when (ccl::installed-item-p item)
    (with-focused-dialog-item (item)
      (let ((position (+ (view-position item) #@(20 0)))
            (size (view-size item))
            (handle (dialog-item-handle item)))
        (ccl::with-slot-values (ccl::color-list text-justification 
                                  (enabled-p dialog-item-enabled-p))
          item
          (rlet ((rect :rect)
                 (ps :penstate))
            (rset rect rect.topleft position)
            (rset rect rect.bottomright (add-points position size))
            (setq text-justification
                  (or (cdr (assq text-justification
                                 '((:left . #.#$tejustleft)
                                   (:center . #.#$tejustcenter)
                                   (:right . #.#$tejustright))))
                      (require-type text-justification 'fixnum)))
            (with-dereferenced-handles ((tp handle))
              (with-fore-color (getf ccl::color-list :text nil)
                (with-back-color (getf ccl::color-list :body nil)
                  (#_TETextBox tp (#_GetHandleSize handle) rect text-justification))))
            (unless enabled-p
              (#_GetPenState ps)
              (#_PenPat *gray-pattern*)
              (#_PenMode 11)
              (#_PaintRect rect)
              (#_SetPenState ps))))))))

(defmethod install-view-in-window :after ((item disclosure-control) dialog)
  (declare (ignore-if-unused dialog))
  (with-macptrs ((handle (dialog-item-handle item)))
    (when handle
      (with-focused-dialog-item (item)
        (#_SetControlValue handle (if (expanded item) 1 0))))))

(defmethod (setf expanded) :after (expand (item disclosure-control))
  "Update the text in the dialog item"
  (with-macptrs ((handle (dialog-item-handle item)))
    (when handle
      (with-focused-dialog-item (item)
        (#_SetControlValue handle (if expand 1 0)))
      #+(and carbon-compat (not ccl-5.0))
      (unless (osx-p)
        (invalidate-view item))))
  (update-dialog-item-text item))

(defmethod disclosure-control-toggle ((item disclosure-control))
  "Toggles the control between open and closed states"
  (setf (expanded item) 
        (not (expanded item))) 
  (invalidate-view item)
)

(defmethod expanded-size ((view disclosure-control))
  "Calculate an expanded size that includes all items in the view"
  (etypecase (slot-value view 'expanded-size)
   (function (funcall (slot-value view 'expanded-size) view))
   (number (slot-value view 'expanded-size))
   (NULL
    (let* ((collapsed-size (collapsed-size view))
           (max-v (point-v collapsed-size))
           (max-h (point-h collapsed-size)))
      (assert (and max-v max-h))
      (dolist (subview (subviews (view-window view)))
        ;(write (+ (point-v (view-position subview))
        ;          (point-v (view-size subview))))
        ;(write-char #\newline)
        (setf max-v (max max-v (+ (point-v (view-position subview))
                                  (point-v (view-size subview)))))
        (setf max-h (max max-h (+ (point-h (view-position subview))
                                  (point-h (view-size subview))))))
        (setf (expanded-size view)
              (if (and max-h max-v)
                (make-point max-h max-v)
                (view-size (view-window view))))))))

(defmethod collapsed-size ((view disclosure-control))
  (or 
    (slot-value view 'collapsed-size)
    (setf (slot-value view 'collapsed-size)
      (view-size (view-window view)))))

(defmethod (setf expanded) :after (expand (view disclosure-control))
  "Update the text in the dialog item"
  (declare (ignore expand))
  (update-dialog-item-text view))

(defmethod (setf expanded) ((expand (eql T)) (view disclosure-control))
  (unless (expanded view)
    (call-next-method)
    (setf (slot-value view 'collapsed-size) (view-size (view-window view)))
    (set-view-size (view-window view) (expanded-size view))))

(defmethod (setf expanded) ((expand null) (view disclosure-control))
  (when (expanded view)
    (call-next-method)
    (unless (typep (slot-value view 'expanded-size) 'function)
      (setf (slot-value view 'expanded-size) (view-size (view-window view))))
    (set-view-size (view-window view) (collapsed-size view))))

#|

(in-package :disclosure-control)

(make-instance 'dialog
    :view-subviews
      (list 
        (make-dialog-item 'disclosure-control NIL #@(200 16) "Hidden Text" NIL)
        (make-dialog-item 'static-text-dialog-item #@(200 200) #@(100 16) "Hidden text" NIL)))

(let ((w (make-instance 'window :theme-background T)))
  (add-subviews w
    (make-instance 'disclosure-control :view-position #@(10 10) :view-size #@(200 20) :dialog-item-text "Text")))

;; These has a problem in 5.1b2...
(let ((w (make-instance 'window :theme-background T))
      (v (make-instance 'view :view-position #@(30 40))))
  (add-subviews w v)
  (add-subviews v
    (make-instance 'disclosure-control :view-position #@(10 10) :view-size #@(200 20) :dialog-item-text "Text")))


; (set-dialog-item-text control "test")

|#





