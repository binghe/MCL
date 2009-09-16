;;; -*- package: ccl -*-
;*********************************************************************
;*                                                                   *
;*    PROGRAM      B E V E L   B U T T O N   D I A L O G   I T E M   *
;*                                                                   *
;*********************************************************************
   ;* Author    : Alexander Repenning (alexander@agentsheets.com)    *
   ;*             http://www.agentsheets.com                         *
   ;* Copyright : (c) 1996-2004, AgentSheets Inc.                    *
   ;* Filename  : bevel-button-dialog-item.lisp                      *
   ;* Updated   : 06/15/04                                           *
   ;* Version   :                                                    *
   ;*   1.0     :  06/03/03                                          *
   ;*   1.1     :  02/24/04 icons and added control                  * 
   ;*   1.1.1   :  06/15/04 is-turned-on -> turned-on-p              *
   ;* HW/SW     : G4,  MCL 5, OS X 10.3.2                            *
   ;* Abstract  : OS X Bevel buttons                                 *
   ;******************************************************************

(in-package :ccl)

(export '(bevel-button-dialog-item turn-on turn-off turned-on-p))




(defclass BEVEL-BUTTON-DIALOG-ITEM (control-dialog-item)
  ((is-round :accessor is-round :initform t :initarg :is-round)
   (resId :accessor resId :initform nil :initarg :resId :documentation "Cicon resource number")
   (iconRef :accessor iconRef :initform nil :initarg :iconRef)
   (thickness :accessor thickness :initform #$kControlBevelButtonNormalBevel :initarg :thickness 
              :documentation "$kControlBevelButtonSmallBevel, $kControlBevelButtonNormalBevel, or $kControlBevelButtonLargeBevel"))
  (:documentation "Bevel button"))


(defun HELP-ICON-REF () "Return a icon ref for the help icon used in help icon buttons"
  (rlet ((&iconRef :pointer))
    (#_GetIconRef #$kOnSystemDisk #$kSystemIconsCreator #$kHelpIcon &iconRef)
    (%get-ptr &iconRef)))


(defmethod HELP-SPEC ((view bevel-button-dialog-item))
  (view-get view :help-spec))


(defmethod TURNED-ON-P ((Self bevel-button-dialog-item))
  (= (#_getControlValue (dialog-item-handle Self)) 1))


(defmethod TURN-ON ((Self bevel-button-dialog-item))
  (#_SetControlValue (dialog-item-handle Self) 1))


(defmethod TURN-OFF ((Self bevel-button-dialog-item))
  (#_SetControlValue (dialog-item-handle Self) 0))
  


(defmethod INSTALL-VIEW-IN-WINDOW :before ((Self bevel-button-dialog-item) Window)
  (when (dialog-item-handle Self) (return-from install-view-in-window))
  (set-default-size-and-position Self (view-container Self))
  (with-item-rect (rect Self)
    (with-cfstrs ((Title (dialog-item-text Self)))
      (rlet ((&control :pointer))
        ;; do not use the more generic NewControl
        (#_CreateBevelButtonControl
         (wptr Window)
         rect
         Title
         (thickness Self)
         #$kControlBehaviorPushbutton
         ;; attach icon if needed
         (cond
          ((resId Self)  ;; color icon resource ID
           (make-record :ControlButtonContentInfo :contentType #$kControlContentCIconRes :resID (resId Self)))
          ((iconRef Self)  ;; Icon Ref
           (make-record :ControlButtonContentInfo :contentType #$kControlContentIconRef :IconRef (iconRef Self)))
          (t  (%null-ptr)))
         0
         0
         0
         &control)
        (setf (dialog-item-handle Self) (%get-ptr &control)))
      (unless (slot-value Self 'dialog-item-enabled-p)
        ;sync up what we believe with what the mac believes.
        (#_deactivatecontrol (dialog-item-handle Self) ))
      ;; optional rounding
      (when (is-round Self)
        (rlet ((&Data :word))
          (%put-word &Data #$kThemeRoundedBevelButton)
          (#_SetControlData (dialog-item-handle Self) #$kControlEntireControl #$kControlBevelButtonKindTag 2 &Data))))))



#| Examples:

(defparameter *Window* (make-instance 'window))

(defparameter *Button* 
  (make-dialog-item
   'bevel-button-dialog-item
   #@(20 20)
   #@(20 20)
   "OK"
   #'(lambda (Item) (print "help me now!"))
   :help-spec "Treat me like a button"))


(add-subviews *Window* *Button*)


(is-turned-on *Button*)

(turn-on *Button*)

(turn-off *Button*)


(add-subviews *Window*
  (make-dialog-item
   'bevel-button-dialog-item
   #@(20 20)
   #@(20 20)
   ""
   #'(lambda (Item) (print "help me now!"))
   :resId 14163
   :is-round nil
   :thickness #$kControlBevelButtonSmallBevel))

(add-subviews *Window*
  (make-dialog-item
   'bevel-button-dialog-item
   #@(20 59)
   #@(20 20)
   ""
   #'(lambda (Item) (print "help me now!"))
   :resId 5960
   :is-round nil
   :thickness #$kControlBevelButtonSmallBevel))


(add-subviews *Window*
  (make-dialog-item
   'bevel-button-dialog-item
   #@(20 40)
   #@(20 20)
   ""
   #'(lambda (Item) (print "help me now!"))
   :resId 0))


(add-subviews *Window*
  (make-dialog-item
   'bevel-button-dialog-item
   #@(20 60)
   #@(20 20)
   ""
   #'(lambda (Item) (print "help me now!"))
   :iconRef (help-icon-ref)))


(add-subviews *Window*
  (make-dialog-item
   'bevel-button-dialog-item
   #@(20 80)
   #@(20 20)
   ""
   #'(lambda (Item) (print "help me now!"))
   :iconRef (help-icon-ref)
   :thickness #$kControlBevelButtonSmallBevel))


(add-subviews *Window*
  (make-dialog-item
   'bevel-button-dialog-item
   #@(20 100)
   #@(20 20)
   ""
   #'(lambda (Item) (print "help me now!"))
   :iconRef (help-icon-ref)
   :thickness #$kControlBevelButtonLargeBevel))


(add-subviews *Window*
  (make-dialog-item
   'bevel-button-dialog-item
   #@(50 20)
   #@(40 40)
   ""
   #'(lambda (Item) (print "help me now!"))
   :resId 0
   :thickness #$kControlBevelButtonLargeBevel
   :is-round nil))


(add-subviews *Window*
  (make-dialog-item
   'bevel-button-dialog-item
   #@(50 60)
   #@(40 40)
   ""
   #'(lambda (Item) (print "help me now!"))
   :resId 0
   :thickness #$kControlBevelButtonSmallBevel
   :is-round t))
                        




|#

