;;;-*- Mode: Lisp; Package: CCL -*-
;;;
;;; bevel-button-dialog-item.lisp
;;;
;;; THE BEVEL BUTTON CONTROL
;;;
;;; Copyright ©1997-1999
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
;;; Author: Eric Russell <eric-r@nwu.edu>
;;;

(in-package :ccl)

(export '(bevel-button-dialog-item
          bevel-button-menu set-bevel-button-menu
          bevel-button-menu-arrow-direction set-bevel-button-menu-arrow-direction
          selected-item-index set-selected-item-index
          bevel-button-icon-suite-id set-bevel-button-icon-suite-id
          bevel-button-cicon-id set-bevel-button-cicon-id
          bevel-button-pict-id set-bevel-button-pict-id
          bevel-button-transform set-bevel-button-transform
          bevel-button-text-alignment set-bevel-button-text-alignment
          bevel-button-text-offset set-bevel-button-text-offset
          bevel-button-text-placement set-bevel-button-text-placement
          bevel-button-graphic-alignment set-bevel-button-graphic-alignment
          bevel-button-graphic-offset set-bevel-button-graphic-offset
          bevel-button-bevel-size set-bevel-button-bevel-size
          bevel-button-behavior set-bevel-button-behavior))

;;;----------------------------------------------------------------------
;;; Requirements

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :appearance-globals)
  (require :appearance-utile "ccl:examples;appearance-manager-folder;appearance-utils")
  (require :new-control-dialog-item "ccl:examples;appearance-manager-folder;new-control-dialog-item"))

;;;----------------------------------------------------------------------
;;; The class

(defclass bevel-button-dialog-item (new-control-dialog-item)
  ((procid :initarg :procid :initform #$kControlBevelButtonSmallBevelProc :allocation :class)
   (menu :initarg :menu :initform nil :accessor bevel-button-menu)
   (arrow-direction :initarg :arrow-direction :initform :down :reader bevel-button-menu-arrow-direction)
   (icon-suite :initarg :icon-suite-id :initform nil :reader bevel-button-icon-suite-id)
   (cicon :initarg :cicon-id :initform nil :reader bevel-button-cicon-id)
   (pict :initarg :pict-id :initform nil :reader bevel-button-pict-id)
   (transform :initarg :transform :initform :none :reader bevel-button-transform)
   (text-alignment :initarg :text-alignment :initform :default :reader bevel-button-text-alignment)
   (text-offset :initarg :text-offset :initform 0 :reader bevel-button-text-offset)
   (text-placement :initarg :text-placement :initform :default :reader bevel-button-text-placement)
   (graphic-alignment :initarg :graphic-alignment :initform :default :reader bevel-button-graphic-alignment)
   (graphic-offset :initarg :graphic-offset :initform 0 :reader bevel-button-graphic-offset)
   (bevel-size :initarg :bevel-size :initform :normal :reader bevel-button-bevel-size)
   (behavior :initarg :behavior :initform :pushbutton :reader bevel-button-behavior)))

;;;----------------------------------------------------------------------
;;; Arg functions

(defun arrow-direction-arg (direction)
  (ecase direction
    (:down 0)
    (:right #$kControlBevelButtonMenuOnRight)))

(defun behavior-arg (behavior)
  (ecase behavior
    (:pushbutton #$kControlBehaviorPushbutton)
    (:toggle #$kControlBehaviorToggles)
    (:sticky #$kControlBehaviorSticky)))

(defun bevel-size-arg (size)
  (ecase size 
    (:small #$kControlBevelButtonSmallBevelVariant)
    (:normal #$kControlBevelButtonNormalBevelVariant)
    (:large #$kControlBevelButtonLargeBevelVariant)))

(defun graphic-alignment-arg (placement)
  (ecase placement
    (:default #$kControlBevelButtonAlignSysDirection)
    (:center #$kControlBevelButtonAlignCenter)
    (:left #$kControlBevelButtonAlignLeft)
    (:right #$kControlBevelButtonAlignRight)
    (:top #$kControlBevelButtonAlignTop)
    (:bottom #$kControlBevelButtonAlignBottom)
    (:top-left #$kControlBevelButtonAlignTopLeft)
    (:bottom-left #$kControlBevelButtonAlignBottomLeft)
    (:top-right #$kControlBevelButtonAlignTopRight)
    (:bottom-right #$kControlBevelButtonAlignBottomRight)))

(defun text-placement-arg (placement)
  (ecase placement
    (:default #$kControlBevelButtonPlaceSysDirection)
    (:normal #$kControlBevelButtonPlaceNormally)
    (:right #$kControlBevelButtonPlaceToRightOfGraphic)
    (:left #$kControlBevelButtonPlaceToLeftOfGraphic)
    (:below #$kControlBevelButtonPlaceBelowGraphic)
    (:above #$kControlBevelButtonPlaceAboveGraphic)))

(defun transform-arg (transform)
  (ecase transform
    (:none #$ttNone)
    (:disabled #$ttDisabled)
    (:offline #$ttOffline)
    (:open #$ttOpen)
    (:label-1 #$ttLabel1)
    (:label-2 #$ttLabel2)
    (:label-3 #$ttLabel3)
    (:label-4 #$ttLabel4)
    (:label-5 #$ttLabel5)
    (:label-6 #$ttLabel6)
    (:label-7 #$ttLabel7)
    (:selected #$ttSelected)
    (:selected-disabled #$ttSelectedDisabled)
    (:selected-offline #$ttSelectedOffline)))

;;;----------------------------------------------------------------------
;;; Initialization methods

(defmethod make-control-handle ((item bevel-button-dialog-item) wptr)
  (let* ((behavior (behavior-arg (bevel-button-behavior item)))
         (bevel-size-variant (bevel-size-arg (bevel-button-bevel-size item)))
         (arrow-direction-variant (arrow-direction-arg
                                   (bevel-button-menu-arrow-direction
                                    item))) 
         (res-id 0)
         (content-type #$kControlContentTextOnly)
         (menu (bevel-button-menu item))
         (menu-id 0))
    (cond ((bevel-button-icon-suite-id item)
           (setq res-id (bevel-button-icon-suite-id item)
                 content-type #$kControlContentIconSuiteRes))
          ((bevel-button-cicon-id item)
           (setq res-id (bevel-button-cicon-id item)
                 content-type #$kControlContentCIconRes))
          ((bevel-button-pict-id item)
           (setq res-id (bevel-button-pict-id item)
                 content-type #$kControlContentPictRes)))
    (when menu
      (unless (menu-installed-p menu)
        (menu-install menu))
      (setq menu-id (menu-id menu)))
    (with-focused-view (view-container item)
      (with-item-rect (rect item)
        (with-pstrs ((title-pstr (dialog-item-text item)))
          (setf (dialog-item-handle item)
                (#_NewControl
                 wptr
                 rect
                 title-pstr
                 nil
                 menu-id
                 (+ behavior content-type)
                 res-id
                 (+ (control-dialog-item-procid item)
                    bevel-size-variant
                    arrow-direction-variant)
                 0)))))
    (let ((handle (dialog-item-handle item)))
      (rlet ((transform :word (transform-arg (bevel-button-transform item)))
             (text-alignment :word (alignment-arg (bevel-button-text-alignment item)))
             (text-offset :word (bevel-button-text-offset item))
             (text-placement :word (text-placement-arg (bevel-button-text-placement item)))
             (graphic-alignment :word (graphic-alignment-arg (bevel-button-graphic-alignment item)))
             (graphic-offset :word (bevel-button-graphic-offset item))
             (selected-item :word (if menu (pop-up-menu-default-item menu) 0)))
        (#_SetControlData handle 0 #$kControlBevelButtonTransformTag 2 transform)
        (#_SetControlData handle 0 #$kControlBevelButtonTextAlignTag 2 text-alignment)
        (#_SetControlData handle 0 #$kControlBevelButtonTextOffsetTag 2 text-offset)
        (#_SetControlData handle 0 #$kControlBevelButtonTextPlaceTag 2 text-placement)
        (#_SetControlData handle 0 #$kControlBevelButtonGraphicAlignTag 2 graphic-alignment)
        (#_SetControlData handle 0 #$kControlBevelButtonGraphicOffsetTag 2 graphic-offset)
        (#_SetControlData handle 0 #$kControlBevelButtonMenuValueTag 2 selected-item)))))

;;;----------------------------------------------------------------------
;;; Menu property methods

(defmethod set-bevel-button-menu-arrow-direction ((item bevel-button-dialog-item)
                                                  direction)  
  (unless (eql direction (bevel-button-menu-arrow-direction item)) 
    (setf (slot-value item 'arrow-direction) direction)
    (when (bevel-button-menu item)
      (maybe-reinstall-item item)))
  direction)

(defmethod (setf bevel-button-menu-arrow-direction) (direction (item bevel-button-dialog-item))
  (set-bevel-button-menu-arrow-direction item direction))

(defmethod set-bevel-button-menu ((item bevel-button-dialog-item) menu)
  (unless (eql menu (bevel-button-menu item))
    (setf (slot-value item 'menu) menu)
    (maybe-reinstall-item item))
  menu)

(defmethod (setf bevel-button-menu) (menu (item bevel-button-dialog-item))
  (set-bevel-button-menu item menu))

(defmethod set-selected-item-index ((item bevel-button-dialog-item) index)
  (when (bevel-button-menu item)
    (set-control-data item
                      #$kControlBevelButtonMenuValueTag
                      :word
                      index))
  index)

(defmethod (setf selected-item-index) (index (item bevel-button-dialog-item))
  (set-selected-item-index item index))

(defmethod selected-item-index ((item bevel-button-dialog-item))
  (when (and (installed-item-p item)
             (bevel-button-menu item))
    (rlet ((menu-item-ptr :word)
           (size :long))
      (if (eq #$noErr (#_GetControlData 
                       (dialog-item-handle item)
                       0
                       #$kControlBevelButtonMenuValueTag
                       2
                       menu-item-ptr
                       size))
        (%get-word menu-item-ptr)
        0))))

;;;----------------------------------------------------------------------
;;; Menu updating and action methods

(defmethod dialog-item-action ((item bevel-button-dialog-item))
  (let ((menu (bevel-button-menu item)))
    (if menu
      (menu-item-action (nth (1- (selected-item-index item)) (menu-items menu)))
      (call-next-method))))

(defmethod view-click-event-handler :before ((item bevel-button-dialog-item) where)
  (declare (ignore where))
  (when (bevel-button-menu item)
    (menu-update (bevel-button-menu item))))

(defmethod maybe-reinstall-item ((item bevel-button-dialog-item))
  (let ((selected-item (selected-item-index item)))
    (call-next-method)
    (set-selected-item-index item selected-item)))

;;;----------------------------------------------------------------------
;;; Property-setting methods

(defmethod set-bevel-button-icon-suite-id ((item bevel-button-dialog-item) new-id)
  (unless (eql new-id (bevel-button-icon-suite-id item))
    (setf (slot-value item 'cicon) nil)
    (setf (slot-value item 'pict) nil)
    (setf (slot-value item 'icon-suite) new-id)
   (maybe-reinstall-item item))
  new-id)

(defmethod (setf bevel-button-icon-suite-id) (new-id (item bevel-button-dialog-item))
  (set-bevel-button-icon-suite-id item new-id))

(defmethod set-bevel-button-cicon-id ((item bevel-button-dialog-item) new-id)
  (unless (eql new-id (bevel-button-cicon-id item))
    (setf (slot-value item 'icon-suite) nil)
    (setf (slot-value item 'pict) nil)
    (setf (slot-value item 'cicon) new-id)
    (maybe-reinstall-item item))
  new-id)

(defmethod (setf bevel-button-cicon-id) (new-id (item bevel-button-dialog-item))
  (set-bevel-button-cicon-id item new-id))

(defmethod set-bevel-button-pict-id ((item bevel-button-dialog-item) new-id)
  (unless (eql new-id (bevel-button-pict-id item))
    (setf (slot-value item 'icon-suite) nil)
    (setf (slot-value item 'cicon) nil)
    (setf (slot-value item 'pict) new-id)
    (maybe-reinstall-item item))
  new-id)

(defmethod (setf bevel-button-pict-id) (new-id (item bevel-button-dialog-item))
  (set-bevel-button-pict-id item new-id))

(defmethod set-bevel-button-transform ((item bevel-button-dialog-item) transform)
  (unless (eql transform (bevel-button-transform item))
    (setf (slot-value item 'transform) transform)
    (set-control-data item 
                      #$kControlBevelButtonTransformTag
                      :word
                      (transform-arg transform)))
  transform)

(defmethod (setf bevel-button-transform) (transform (item bevel-button-dialog-item))
  (set-bevel-button-transform item transform))

(defmethod set-bevel-button-text-alignment ((item bevel-button-dialog-item) text-alignment)
  (unless (eql text-alignment (bevel-button-text-alignment item))
    (setf (slot-value item 'text-alignment) text-alignment)
    (set-control-data item
                      #$kControlBevelButtonTextAlignTag
                      :word
                      (alignment-arg text-alignment)))
  text-alignment)

(defmethod (setf bevel-button-text-alignment) (alignment (item bevel-button-dialog-item))
  (set-bevel-button-text-alignment item alignment))

(defmethod set-bevel-button-text-offset ((item bevel-button-dialog-item) text-offset)
  (unless (eql text-offset (bevel-button-text-offset item))
    (setf (slot-value item 'text-offset) text-offset)
    (set-control-data item
                      #$kControlBevelButtonTextOffsetTag
                      :word
                      text-offset))
  text-offset)

(defmethod (setf bevel-button-text-offset) (offset (item bevel-button-dialog-item))
  (set-bevel-button-text-offset item offset))

(defmethod set-bevel-button-text-placement ((item bevel-button-dialog-item) text-placement)
  (unless (eql text-placement (bevel-button-text-placement item))
    (setf (slot-value item 'text-placement) text-placement)
    (set-control-data item
                      #$kControlBevelButtonTextPlaceTag
                      :word
                      (text-placement-arg text-placement)))
  text-placement)

(defmethod (setf bevel-button-text-placement) (placement (item bevel-button-dialog-item))
  (set-bevel-button-text-placement item placement))

(defmethod set-bevel-button-graphic-alignment ((item bevel-button-dialog-item) graphic-alignment)
  (unless (eql graphic-alignment (bevel-button-graphic-alignment item))
    (setf (slot-value item 'graphic-alignment) graphic-alignment)
    (set-control-data item
                      #$kControlBevelButtonGraphicAlignTag
                      :word
                      (graphic-alignment-arg graphic-alignment)))
  graphic-alignment)

(defmethod (setf bevel-button-graphic-alignment) (alignment (item bevel-button-dialog-item))
  (set-bevel-button-graphic-alignment item alignment))

(defmethod set-bevel-button-graphic-offset ((item bevel-button-dialog-item) graphic-offset)
  (unless (eql graphic-offset (bevel-button-graphic-offset item))
    (setf (slot-value item 'graphic-offset) graphic-offset)
    (set-control-data item
                      #$kControlBevelButtonGraphicOffsetTag
                      :word
                      graphic-offset))
  graphic-offset)

(defmethod (setf bevel-button-graphic-offset) (offset (item bevel-button-dialog-item))
  (set-bevel-button-graphic-offset item offset))

(defmethod set-bevel-button-bevel-size ((item bevel-button-dialog-item) new-size)
  (unless (eql new-size (bevel-button-bevel-size item))
    (setf (slot-value item 'bevel-size) new-size)
    (maybe-reinstall-item item))
  new-size)

(defmethod (setf bevel-button-bevel-size) (size (item bevel-button-dialog-item))
  (set-bevel-button-bevel-size item size))

(defmethod set-bevel-button-behavior ((item bevel-button-dialog-item) behavior)
  (unless (eql behavior (bevel-button-behavior item))
    (setf (slot-value item 'behavior) behavior)
    (maybe-reinstall-item item))
  behavior)

(defmethod (setf bevel-button-behavior) (behavior (item bevel-button-dialog-item))
  (set-bevel-button-behavior item behavior))

;;;----------------------------------------------------------------------

(provide :bevel-button-dialog-item)

#|

(defvar bevel-button)
(defvar menu)
(setq w (make-instance 'window))
(setq b (make-instance 'bevel-button-dialog-item :view-container w 
                       :view-position #@(10 10) :view-size #@(100 23) 
                       :dialog-item-text "crud suds"))
(setq bevel-button (make-instance 'bevel-button-dialog-item
                        :view-position #@(125 30)
                        :view-size #@(130 48)
                        :view-font '("Geneva" 9 :bold)
                        :dialog-item-text "A Bevel Button"
                        :icon-suite-id #$genericApplicationIconResource
                        :text-placement :right
                        :text-alignment :right
                        :view-container w
                        :graphic-alignment :center))

(setq menu (make-instance 'pop-up-menu))

(add-menu-items menu
                      (make-instance 'menu-item
                        :menu-item-title "Application"
                        :menu-item-action #'(lambda ()
                                              (set-bevel-button-icon-suite-id 
                                               bevel-button
                                               #$genericApplicationIconResource)))
                      (make-instance 'menu-item
                        :menu-item-title "Document"
                        :menu-item-action #'(lambda ()
                                              (set-bevel-button-icon-suite-id
                                               bevel-button
                                               #$genericDocumentIconResource)))
                      (make-instance 'menu-item
                        :menu-item-title "Folder"
                        :menu-item-action #'(lambda ()
                                              (set-bevel-button-icon-suite-id
                                               bevel-button
                                               #$genericFolderIconResource))))
      (setf (bevel-button-menu bevel-button) menu)

(make-instance 'chasing-arrows-dialog-item
                      :view-position #@(244 160)
                      :view-container w
                      :view-size #@(16 16))

(setq little-arrows-box (make-instance 'example-static-text-item
                             :view-position #@(244 45)
                             :view-size #@(23 15)
                             :VIEW-CONTAINER W
                             :view-font (system-font-spec)
                             :dialog-item-text "0"))
|#