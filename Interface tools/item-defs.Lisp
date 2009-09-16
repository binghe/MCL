; -*- Mode:Lisp; Package:INTERFACE-TOOLS; -*-

;;	Change History (most recent first):
;;  4 6/2/97   akh  table-dialog-item stuff
;;  3 5/20/96  akh  content-color
;;  3 6/10/95  akh  print-source for scrolling-fred deals with possible consp style containing color vector
;;  6 3/20/95  akh  use *tool-back-color*, proto scrolling-fred smaller
;;  4 3/2/95   slh  pop-up-menu object-source-code outputs size & position
;;  (do not edit before this line!!)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  item-defs.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  definitions of object functions for particular classes of dialog-items, to
;;  support editing, printing, and copying.
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; Change History
;;
;; windows are :theme-background t
;;------ 5.2b6
;; fix "set item font" for scrolling-fred-view too
;; choose-font-dialog - pass the dialog-item so we can think different if control. The "set item font" dialog item now makes more sense to me
;; ------------ 5.0 final
;; item-display for pop-up is "" if *use-pop-up-control* is true
;; --------- 4.4b5
;; 08/03/01 fix add-editor-items for buttons being disabled when window is inactive, more space for "disabled" if osx-p
;; object-source-code for window uses getwindowattributes if carbon
;; carbon-compat
;;  -------- 4.3.1
;; 04/27/97 akh object-source-code for view and window doesn't include scroll bars of table-dialog-item in subviews
;; 04/23/97 bill (method object-source-code (pop-up-menu)) no longer
;;               includes :view-size or view-position; they are already
;;               included by the simple-view method.
;; ------------- 4.1f1
;; 02/28/97 akh  lose ed-set-view-font for T
;;  9/23/96 slh   :draw-outline key for source
;;  3/16/95 slh   object-source-code for simple-view, view, underlined-view
;;  2/28/95 slh   pop-up-menu object-source-code outputs size & position
;; ------------- 3.0d17
;; 12/30/94 alice "set item font" use ed-set-view-font and sets font in both places.
;;                object-source-code scrolling-fred-view - save-bufer-p t
;;                "pop up menu" => pop up "radio button" => radio etc. - making palette smaller, works better on a small screen
;;                inert-fred-item save-buffer-p t
;; 07/14/93 alice fred-class -> fred-item-class
;; 07/13/93 alice scrolling-fred-dialog-item -> scrolling-fred-view and fix color list in
;;		      in object-source-code thereof    
;; 12/21/92 alice no more i-beam cursors in palette 
;; 10/29/92 alice added icon-dialog-item's popups and scrolling fred to pallet/palette
;; 11/02/92 bill Be more explicit about the parameters for the prototype
;;               sequence dialog item.
;; ------------- 2.0
;; 03/05/92  wkf Changed "Print Item Source" button and "Print Dialog SourceÉ"
;;               menu item to make a Scratch Fred buffer.This is since one
;;               rarely saves these buffers and this makes throwing them away
;;               easier. One can always use "Save as" to keep them.
;; ------------- 2.0f3
;; 12/18/91 bill add package prefixes to commented out object-source-code
;;               method for array-dialog-item
;; ------------- 2.0b4
;; 07/26/91 bill editors for fred-dialog-item's now have check box for
;;               allow-tabs & draw-outline
;; 07/09/91 bill window-font -> view-font
;; 07/05/91 bill :srccopy -> :srcor
;; 04/24/91 bill ALMS's fix to (method object-source-code (dialog-item))

(in-package :interface-tools)

(defparameter *editor-items-start-pos* #@(180 20))

;;;;;;;;;;;;;;;;;;;;
;;
;; new classes

(defclass dialog-item-editor (non-editable-dialog)
  ((edited-item :accessor dialog-item-editor-item)))

(defclass scrolling-fred-view-editor (non-editable-dialog)
  ((edited-item :accessor edited-item)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; for editing scrolling-fred-view

(defmethod make-editor ((item scrolling-fred-view) pos)
  (make-instance 'scrolling-fred-view-editor :item item :view-position pos 
                 ;:back-color *tool-back-color*
                 :theme-background t
                 :content-color *tool-back-color* ))

(defmethod copy-instance ((view scrolling-fred-view))
  (let* ((h-scroller (ccl::h-scroller view))
         (v-scroller (ccl::v-scroller view))
         (new (make-instance (class-of view) ;'scrolling-fred-view
                :h-scrollp h-scroller
                :v-scrollp v-scroller
                :view-size (view-size view))))
    (when h-scroller
      (setf (part-color-list (ccl::h-scroller new))(part-color-list h-scroller)))
    (when v-scroller 
      (setf (part-color-list (ccl::v-scroller new))(part-color-list v-scroller)))    
    (let* ((fred (ccl::fred-item view))
           (buf (fred-buffer fred))
           (new-fred (ccl::fred-item new))
           (size (buffer-size buf))
           (text (buffer-substring buf 0 size))
           (style (buffer-get-style buf 0 size)))
      (set-view-font new-fred (view-font fred))
      (set-view-nick-name new (view-nick-name view))
      (setf (fred-wrap-p new-fred) (fred-wrap-p fred))
      (buffer-insert-with-style 
       (fred-buffer new-fred) text style 0)
      (setf (part-color-list new-fred)(part-color-list fred))
      (multiple-value-bind (s e) (selection-range fred)
        (set-selection-range new-fred s e)))
    new))


  

(defmethod initialize-instance ((editor scrolling-fred-view-editor) &rest initargs &key item)
  (declare (dynamic-extent initargs))
  (let ((position  *editor-items-start-pos*))
    (setf (edited-item editor) item)
    (apply #'call-next-method
           editor
           :view-size #@(344 200)
           :window-type :document
           :window-title "Editor for Scrolling Text"
           initargs)
    (add-subviews 
     editor
     (make-dialog-item 'static-text-dialog-item
                       #@(4 4) #@(125 16) "Dialog-item-text:")
     (make-dialog-item 'editable-text-dialog-item
                       #@(7 24) #@(148 80) (dialog-item-text item)
                       #'(lambda (x)
                           (let ((text (dialog-item-text x)))
                             (set-dialog-item-text item text)))
                       :allow-returns t
                       :view-font (view-font item)
                       :view-nick-name 'edt)
     (make-dialog-item 'button-dialog-item
                       #@(5 120) #@(125 16) "Set Item Font" ; was 158
                       #'(lambda (button)
                           (declare (ignore button))
                           (let* ((font (choose-font-dialog (view-font item)))
                                  (fred (fred-item item))
                                  (editable-di (view-named 'edt editor)))
                             (select-all fred)
                             ;(ccl::ed-set-view-font fred font)
                             (progn (ccl::ed-set-view-font fred '(:plain))  ;; get rid of existing face stuff
                                    (ccl::ed-set-view-font fred font))
                             (select-all editable-di)
                             ;(ccl::ed-set-view-font editable-di font)
                             (progn (ccl::ed-set-view-font editable-di '(:plain))
                                    (ccl::ed-set-view-font editable-di font))))) 
     (make-dialog-item 'button-dialog-item
                       #@(5 141) #@(125 16) "Set Item Name"
                       #'(lambda (button)
                           (declare (ignore button))
                           (set-item-nick-name item)))
     (make-dialog-item 'button-dialog-item
                       #@(5 162) #@(125 16) "Print Item Source"
                       #'(lambda (button)
                           (declare (ignore button))
                           (pprint-item-source item)))
     (make-dialog-item 'check-box-dialog-item
                       position #@(160 16) "Vertical Scroll Bar"
                       #'(lambda (box)
                           (if (check-box-checked-p box)
                             (ccl::add-scroller item :vertical)
                             (ccl::remove-scroller item :vertical)))
                       :check-box-checked-p (ccl::v-scroller item))
     (make-dialog-item 'check-box-dialog-item
                       (add-points position #@(0 24)) #@(160 16) "Horizontal Scroll Bar"
                       #'(lambda (box)
                           (if (check-box-checked-p box)
                             (ccl::add-scroller item :horizontal)
                             (ccl::remove-scroller item :horizontal)))
                       :check-box-checked-p (ccl::h-scroller item))
     (make-dialog-item 'check-box-dialog-item
                       (add-points position #@(0 48)) #@(160 16) "Wrap?"
                       #'(lambda (box)
                           (setf (fred-wrap-p item)
                                 (check-box-checked-p box)))
                       :check-box-checked-p (fred-wrap-p item))
     (make-dialog-item 'title-box-dialog-item
                     #@(173 124) #@(162 63) "Colors" nil)
     (make-dialog-item 'color-part-pop-up
                     #@(176 133) #@(155 19) "Scroll Bar Colors" nil
                     :colored-object (or (ccl::v-scroller item)(ccl::h-scroller item)) ; can come and go
                     :view-nick-name 'scroll-bar-colors
                     :part-codes '(:frame
                                   :body
                                   :thumb))
     (make-dialog-item 'color-part-pop-up
                     #@(176 158) #@(155 20) "Text Colors" nil
                     :view-nick-name 'fred-colors
                     :colored-object item
                     :part-codes '(:frame
                                   :text
                                   :body)))))
   

(defmethod window-close :before ((editor scrolling-fred-view-editor))
  (setf (get-dialog-item-editor (edited-item editor)) nil))
                

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  code for editing dialog-items
;;

(defmethod make-editor ((item dialog-item)  pos)
  (make-instance 'dialog-item-editor :item item :view-position pos 
                 ;:back-color *tool-back-color*
                 :theme-background t
                 :content-color *tool-back-color*))

(defmethod make-editor ((item pop-up-menu) pos)
  (make-instance 'menu-editor :menu item :view-position pos 
                 ;:back-color *tool-back-color*
                 :theme-background t
                 :content-color *tool-back-color*))

(defun edit-dialog-item (item &optional (wpos #@(7 44)))  
  (let ((my-ed (get-dialog-item-editor item)))
    (if (and my-ed (wptr my-ed))
      (window-select my-ed)
      (setf (get-dialog-item-editor item)
            (make-editor item wpos)))))

(defmethod initialize-instance ((editor dialog-item-editor) &rest initargs &key
                                (item (make-instance 'button-dialog-item)))
  (declare (dynamic-extent initargs))
  (setf (dialog-item-editor-item editor) item)
  (apply #'call-next-method
         editor
         :view-size (dialog-item-editor-size item)
         :window-type :document
         :window-title (format nil "Editor for ~s" (dialog-item-text item))
         initargs)
  (add-editor-items item editor))

(defmethod window-close :before ((editor dialog-item-editor))
  (setf (get-dialog-item-editor (dialog-item-editor-item editor)) nil))

(defmethod dialog-item-editor-size ((item dialog-item))
  #@(344 253))

(defmethod add-editor-items ((dialog-item dialog-item) editor)
  (let* ((enabled (or (dialog-item-enabled-p dialog-item)(and (ccl::osx-p)(typep dialog-item 'button-dialog-item)(view-get dialog-item 'ccl::was-enabled))))
         (text (dialog-item-text dialog-item)))
    (add-subviews
     editor
     (make-dialog-item 'static-text-dialog-item
                       #@(4 4) #@(125 16) "Dialog-item-text:")
     (make-dialog-item 'editable-text-dialog-item
                       #@(7 24) #@(148 80) text
                       #'(lambda (item)
                           (let ((text (dialog-item-text item)))
                             (set-dialog-item-text dialog-item text)
                             (set-window-title
                              editor (format nil "Editor for ~s" text))))
                       :view-nick-name 'edt
                       :allow-returns t)
     (make-dialog-item 'radio-button-dialog-item
                       #@(5 115) #@(72 16) "Enabled"
                       #'(lambda (item)
                           (declare (ignore item))
                           (dialog-item-enable dialog-item))
                       :radio-button-pushed-p enabled)
     (make-dialog-item 'radio-button-dialog-item
                       #@(85 115) (if (ccl::osx-p) #@(80 16) #@(72 16)) "Disabled"
                       #'(lambda (item)
                           (declare (ignore item))
                           (dialog-item-disable dialog-item))
                           ;(when (ccl::osx-p)(when (view-get dialog-item 'ccl::was-enabled)(view-put dialog-item 'ccl::was-enabled Nil))))
                       :radio-button-pushed-p (not enabled))
     (make-dialog-item 'button-dialog-item
                       #@(5 137) #@(125 16) "Set Item Action"
                       #'(lambda (item)
                           (declare (ignore item))
                           (new-action-from-dialog dialog-item)))
     (make-dialog-item 'button-dialog-item
                       #@(5 158) #@(125 16) "Set Item Font"
                       #'(lambda (item)
                           (declare (ignore item))
                           (let ((font (choose-font-dialog (view-font dialog-item) dialog-item))
                                 (editable-di (view-named 'edt editor)))
                             (select-all dialog-item)
                             ;(push (list font editable-di dialog-item) ccl::barf)
                             (multiple-value-bind (ff ms)(font-codes font) ;; don't merge just jam it in ??
                               ;; dialog-item is the thing we are getting the fonts for
                               (if (typep dialog-item 'fred-mixin)
                                 (progn (ccl::ed-set-view-font dialog-item '(:plain))  ;; get rid of existing face stuff
                                        (ccl::ed-set-view-font dialog-item font))                                 
                                 (set-view-font-codes dialog-item ff ms))
                               (select-all editable-di)
                               ;; editable-di is the thing in the editor window that contains the "text"                               
                               (progn (ccl::ed-set-view-font editable-di '(:plain))
                                      (ccl::ed-set-view-font editable-di font))
                               ;(set-view-font-codes editable-di ff ms)
                               ))))
     (make-dialog-item 'button-dialog-item
                       #@(5 179) #@(125 16) "Set Item Name"
                       #'(lambda (item)
                           (declare (ignore item))
                           (set-item-nick-name dialog-item)))
     (make-dialog-item 'color-part-pop-up
                       #@(4 201)  #@(119 21) "Set Color" nil
                       :part-codes '(:frame :text :body :thumb)
                       :colored-object dialog-item)
     (make-dialog-item 'button-dialog-item
                       #@(5 231) #@(125 16) "Print Item Source"
                       #'(lambda (item)
                           (declare (ignore item))
                           (pprint-item-source dialog-item))))))

(defmethod select-all (item)
  (declare (ignore item))
  nil)

#| its defined for simple view in font-menus - that's enough
 ; why is this busting things now?
(defmethod ed-set-view-font (view font)
  (declare (ignore view font))
  nil)
|#


;;;;;;;;;;;;;;;;;;;;
;;
;;  definitions for various dialog-items
;;

;;;; *button* ;;;;;

(add-editable-dialog-item (make-instance 'button-dialog-item
                                         :dialog-item-text "Button"))

(defmethod add-editor-items ((button button-dialog-item) editor)
  (let* ((default (default-button-p button))
         (position *editor-items-start-pos*))
    (call-next-method)
    (add-subviews 
     editor
     (make-dialog-item 'check-box-dialog-item
                       position #@(116 16) "Default Button"
                       #'(lambda (item)
                           (let ((checked (check-box-checked-p item))
                                 (dialog (view-window button))
                                 (old-editor (get-dialog-item-editor button)))
                             (setf (get-dialog-item-editor button) nil)
                             (if checked
                               (set-default-button dialog button)
                               (set-default-button dialog nil))
                             (setf (get-dialog-item-editor button) old-editor)))
                       :check-box-checked-p default))))


;;;; *static-text* ;;;;;

(add-editable-dialog-item (make-instance 'static-text-dialog-item
                                         :dialog-item-text "Static Text"))

;;;; *editable-text* ;;;;;



(defmethod view-cursor ((view proto-editable-text-dialog-item) where)
  (declare (ignore where))
  *arrow-cursor*)

(add-editable-dialog-item (make-instance 'proto-editable-text-dialog-item
                            :view-size #@(80 16)
                                         :dialog-item-text "Edit Text"))

(defmethod add-editor-items :after ((text-item fred-dialog-item) editor)
  (let* ((position *editor-items-start-pos*)
         (size #@(116 16))
         (delta (make-point 0 (+ (point-v size) 5))))
      (add-subviews
       editor
       (make-dialog-item 'check-box-dialog-item
                         position size "Allow Returns"
                         #'(lambda (item)
                             (setf (allow-returns-p text-item) 
                                   (check-box-checked-p item)))
                         :check-box-checked-p (allow-returns-p text-item))
       (make-dialog-item 'check-box-dialog-item
                         (setq position (add-points position delta))
                         size "Allow Tabs"
                         #'(lambda (item)
                             (setf (allow-tabs-p text-item) 
                                   (check-box-checked-p item)))
                         :check-box-checked-p (allow-tabs-p text-item))
       (make-dialog-item 'check-box-dialog-item
                         (setq position (add-points position delta))
                         size "Draw outline"
                         #'(lambda (item)
                             (invalidate-view text-item t)
                             (setf (slot-value text-item 'ccl::draw-outline) 
                                   (check-box-checked-p item))
                             (invalidate-view text-item))
                         :check-box-checked-p
                         (slot-value text-item 'ccl::draw-outline)))))

;;;; scrolling-editable-text

(defclass inert-fred-item (ccl::fred-item)
  ()
  (:default-initargs
    :wrap-p t
    :save-buffer-p t))

(defmethod view-cursor ((view inert-fred-item) where)
  (declare (ignore where))
  *arrow-cursor*)

(add-editable-dialog-item 
 (let ((it (make-instance 'ccl::scrolling-fred-view-with-frame
             :fred-item-class 'inert-fred-item :view-size #@(80 60))))
   (set-dialog-item-text it "scrolling
editable
text")
   it))


;;;; *check-box* ;;;;;

(add-editable-dialog-item (make-instance 'check-box-dialog-item
                                         :dialog-item-text "Check Box"))

(defmethod add-editor-items :after ((box-item check-box-dialog-item) editor)
  (let* ((checked (check-box-checked-p box-item))
         (position *editor-items-start-pos*))
    (add-subviews
       editor
       (make-dialog-item 'check-box-dialog-item
                         position #@(155 16) "Check Box Checked"
                         #'(lambda (item)
                             (if (check-box-checked-p item)
                               (check-box-check box-item)
                               (check-box-uncheck box-item)))
                         :check-box-checked-p checked))))



;;;; *radio-button* ;;;;;

(add-editable-dialog-item (make-instance 'radio-button-dialog-item
                                         :dialog-item-text "Radio"))

(defmethod add-editor-items :after ((radio radio-button-dialog-item) editor)
  (let* ((pushed (radio-button-pushed-p radio))
         (position *editor-items-start-pos*))
      (add-subviews
       editor
       (make-dialog-item 'check-box-dialog-item
                         position #@(160 16) "Radio Button Pushed"
                         #'(lambda (item)
                             (if (check-box-checked-p item)
                               (radio-button-push radio)
                               (radio-button-unpush radio)))
                         :check-box-checked-p pushed)
       (make-dialog-item 'button-dialog-item
                         (add-points position #@(0 24)) #@(150 16) "Set Item Cluster"
                         #'(lambda (item)
                             (declare (ignore item))
                             (setf (radio-button-cluster radio)
                                   (read-from-string
                                    (get-string-from-user
                                     "Please enter a new cluster for the radio button."
                                     :initial-string
                                     (format nil "~s" (radio-button-cluster radio))))))))))

;;;;; pop-up

(add-editable-dialog-item (make-instance 'pop-up-menu 
                            :item-display (if (not *use-pop-up-control*) 
                                            "Pop Up"
                                            "")
                                         :auto-update-default nil))
;;; icon

(add-editable-dialog-item (make-instance 'icon-dialog-item))


; what the do item text, font mean here? NOTHING!
 
(defmethod add-editor-items :after ((icon icon-dialog-item) editor)
  (let ((position *editor-items-start-pos*))    
    (add-subviews
     editor
     (MAKE-DIALOG-ITEM 'RADIO-BUTTON-DIALOG-ITEM
                       position #@(50 16)
                       "Stop"
                       #'(lambda (item)
                           (if (radio-button-pushed-p item)
                             (setf (ccl::icon icon) *stop-icon*))) ; change name?
                       :view-nick-name :quit
                       :RADIO-BUTTON-PUSHED-P nil
                       :RADIO-BUTTON-CLUSTER 1)
     (MAKE-DIALOG-ITEM 'RADIO-BUTTON-DIALOG-ITEM
                       (add-points position #@(0 25)) #@(50 16)
                       "Note"
                       #'(lambda (item)
                           (if (radio-button-pushed-p item)
                             (setf (ccl::icon icon) *note-icon*)))
                       :radio-button-pushed-p t
                       :RADIO-BUTTON-CLUSTER 1)
     (MAKE-DIALOG-ITEM 'RADIO-BUTTON-DIALOG-ITEM
                       (add-points position #@(0 50)) #@(55 16)
                                   "Warn"
                                   #'(lambda (item)
                                       (if (radio-button-pushed-p item)
                                         (setf (ccl::icon icon) *warn-icon*)))
                                   :RADIO-BUTTON-CLUSTER 1))))

;;;; *table* ;;;;;


(defmethod add-editor-items :after ((table table-dialog-item) editor)
  (let ((h-scrollp (table-hscrollp table))
        (v-scrollp (table-vscrollp table))
        (position *editor-items-start-pos*))
    (labels ((change-scroll (check-box which-bar)
               (let* ((checked (check-box-checked-p check-box))
                      (owning-dialog (view-window table))
                      (old-editor (get-dialog-item-editor table)))
                 (setf (get-dialog-item-editor table) nil)
                 (set-view-container table nil)
                 (ecase which-bar
                        (:vertical
                         (setf (table-vscrollp table) checked))
                        (:horizontal
                         (setf (table-hscrollp table) checked)))
                 (set-view-container table owning-dialog)
                 (setf (get-dialog-item-editor table) old-editor))))
      (add-subviews
       editor
       (make-dialog-item 'button-dialog-item
                         position #@(130 16) "Set Cell Size"
                         #'(lambda (item)
                             (declare (ignore item))
                             (set-cell-size
                              table
                              (read-from-string
                               (get-string-from-user
                                "Please enter a new Cell Size."
                                :initial-string
                                (format nil "~s" (ppoint (cell-size table))))))
                             (invalidate-view table)))
         (make-dialog-item 'check-box-dialog-item
                           (add-points position #@(0 22)) #@(175 16) "Horizontal Scrollbar"
                           #'(lambda (item)
                               (change-scroll item :horizontal))
                           :check-box-checked-p h-scrollp)
         (make-dialog-item 'check-box-dialog-item
                           (add-points position #@(0 44)) #@(175 16) "Vertical Scrollbar"
                           #'(lambda (item)
                               (change-scroll item :vertical))
                           :check-box-checked-p v-scrollp)))))

(defun get-new-table-data (old-data data-name)
  (let* ((*print-length* nil)
         (*print-level* nil))
    (read-from-string
     (get-text-from-user
      (format nil "Please enter a new ~a for the table." data-name)
      (format nil "~s" old-data)))))

;;sequence-dialog-item


(add-editable-dialog-item (make-instance 'sequence-dialog-item
                            :table-sequence '(1 2 3)
                            :view-size #@(29 63)
                            :table-hscrollp nil
                            :table-vscrollp nil))

(defmethod add-editor-items :after ((sequence sequence-dialog-item) editor)
  (let ((position (add-points *editor-items-start-pos* #@(0 66)))
        (orient (slot-value sequence 'ccl::sequence-order)))
    (add-subviews
     editor
     (make-dialog-item 'button-dialog-item
                       position #@(130 16) "Set Table Sequence"
                       #'(lambda (item)
                           (declare (ignore item))
                           (set-table-sequence
                            sequence
                            (get-new-table-data 
                             (table-sequence sequence) "sequence"))))
     (make-dialog-item 'button-dialog-item
                       (add-points position #@(0 22)) #@(130 16) "Set Wrap Length"
                       #'(lambda (item)
                           (declare (ignore item))
                           (setf (slot-value sequence 'ccl::sequence-wrap-length)
                                 (read-from-string
                                  (get-string-from-user
                                   "Please enter a new length."
                                   :initial-string
                                   (format nil "~a"
                                           (slot-value sequence 'ccl::sequence-wrap-length)))))
                           (set-table-sequence
                            sequence (table-sequence sequence))))
     (make-dialog-item 'static-text-dialog-item
                       (add-points position #@(0 44)) #@(130 16) "Orientation:")
     (make-dialog-item 'radio-button-dialog-item
                       (add-points position #@(30 60)) #@(100 16) "Vertical"
                       #'(lambda (item)
                           (declare (ignore item))
                           (setf (slot-value sequence 'ccl::sequence-order) :vertical)
                           (set-table-sequence
                            sequence (table-sequence sequence)))
                       :radio-button-pushed-p (eq orient :vertical))
     (make-dialog-item 'radio-button-dialog-item
                       (add-points position #@(30 76)) #@(100 16) "Horizontal"
                       #'(lambda (item)
                           (declare (ignore item))
                           (setf (slot-value sequence 'ccl::sequence-order) :horizontal)
                           (set-table-sequence
                            sequence (table-sequence sequence)))
                       :radio-button-pushed-p (eq orient :horizontal)))))
#|
;;array-dialog-item

(add-editable-dialog-item (make-instance 'array-dialog-item))

(defmethod add-editor-items :after ((array array-dialog-item) editor)
  (let ((position (add-points *editor-items-start-pos* #@(0 66))))
    (add-subviews
     editor
     (make-dialog-item 'button-dialog-item
                       position #@(130 16) "Set Table Array"
                       #'(lambda (item)
                           (declare (ignore item))
                           (let* ((*print-array* t))
                             (set-table-array
                              array
                              (get-new-table-data (table-array array)
                                                  "array"))))))))
|#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  definitions for printing the source code
;;

(defmethod pprint-source ((window window))
  (let* ((*print-length* nil)
         (*print-level* nil)
         (*print-array* t)
         ;(*package* "CL-USER") ; ??
         (win (make-instance 'fred-window :scratch-p t)))
    (pprint (object-source-code window) win)
    (force-output win)
    (fred-update win)))

; really should also bind *print-readably* t
(defun pprint-item-source (item)  
  (let* ((*print-length* nil)
         (*print-level* nil)
         (*print-array* t)
         ;(*package* "CL-USER")  ; ??
         (win (make-instance 'fred-window :scratch-p t)))
    (pprint (object-source-code item) win)
    (force-output win)
    (fred-update win)))

(defmethod object-source-code ((view simple-view))
  `(make-instance ',(class-name (class-of view))
                  :view-position ,(ppoint (view-position view))
                  :view-size ,(ppoint (view-size view))
                  ,@(let ((nick-name (view-nick-name view)))
                      (if nick-name
                        `(:view-nick-name ',nick-name)))
                  ; :view-alist
                  ))

(defmethod object-source-code ((view underlined-view))
  (nconc (call-next-method)
         `(:dialog-item-text ,(dialog-item-text view))))


(defmethod object-source-code ((view view))
  (let ((items-to-suppress nil)
        (items (view-subviews view)))
    (dovector (item items)
      (when (ccl::view-owner item) (push item items-to-suppress)))
    (when items-to-suppress
      (setq items (remove-if #'(lambda (it) (memq it items-to-suppress)) items)))  
    (nconc (call-next-method)
           `(; :view-valid
             :view-scroll-position ,(ppoint (view-scroll-position view))
             ; :view-origin
             :view-subviews (list ,@(map 'list  #'(lambda (item)
                                                    (object-source-code item))
                                         items))
           ; :view-clip-region
           ))))

(defmethod object-source-code ((window window) &aux my-font)
  (let ((items-to-suppress nil)
        (items (view-subviews window)))
    (dovector (item items)
      (when (ccl::view-owner item) (push item items-to-suppress)))
    (when items-to-suppress
      (setq items (remove-if #'(lambda (it) (memq it items-to-suppress)) items)))    
    `(make-instance ',(if (window-color-p window) 'color-dialog 'dialog)
       :window-type ,(window-type window)
       ,@(let ((title (window-title window)))
           (if (or (string-equal title "Untitled Dialog")
                   (string-equal title "Untitled"))
             nil
             `(:window-title ,title)))
       :view-position ,(let ((pos (window-centered-p window)))
                         (if (fixnump pos)
                           (ppoint pos)
                           (list 'quote pos)))
       :view-size ,(ppoint (view-size window))
       ,@(if #-carbon-compat (rref (wptr window) windowRecord.goawayflag)
             #+carbon-compat 
             (rlet ((attrs :unsigned-long))
               (#_getwindowattributes (wptr window) attrs)
               (neq 0 (LOGand #$kWindowCloseBoxAttribute (%GET-unsigned-long attrs)))) 
           nil
           '(:close-box-p nil))
       ,@(if (equal (setq my-font (view-font window))
                    ;'("Chicago" 0 :srcor :plain)
                    (ccl::sys-font-spec))
           nil
           `(:view-font ',my-font))
       :view-subviews (list ,@(map 'list  #'(lambda (item)
                                              (object-source-code item))
                                   items)))))

(defmethod object-source-code ((item dialog-item) &aux my-font)
  `(make-dialog-item  ',(class-name (class-of item))
                      ,(ppoint (view-position item))
                      ,(ppoint (view-size item))
                      ,(dialog-item-text item)
                      ,(let* ((f (dialog-item-action-function item))
                              (code (and (functionp f) (uncompile-function f))))
                         (cond ((symbolp f) `',f)
                               (code `#',code)
                               (t nil)))
                      ,@(let ((nick-name (view-nick-name item)))
                          (and nick-name
                               `(:view-nick-name ',nick-name)))
                      ,@(if (or (dialog-item-enabled-p item)
                                (view-get item 'ccl::was-enabled)) ; OSX
                          ()
                          '(:dialog-item-enabled-p nil))
                      ,@(if (equal (setq my-font (view-font item))
                                   (view-font (view-window item)))
                          ()
                          `(:view-font ',my-font))
                      ,@(let ((color-list (part-color-list item)))
                          (and color-list
                               `(:part-color-list ',color-list)))))


;;;;;;;;;;;;;;;;;;;;
;;
;;  definitions for various dialog-items
;;

;;;; *button* ;;;;;

(defmethod object-source-code ((item button-dialog-item))
  (nconc (call-next-method)
         `(:default-button ,(default-button-p item))))

;;;;;; icon

(defmethod object-source-code ((item icon-dialog-item))
  (nconc (call-next-method)
         `(:icon ,(ccl::icon item))))

;;;;; popup

(defmethod object-source-code ((item pop-up-menu))
  (nconc (call-next-method)         
         `(:auto-update-default ,(pop-up-menu-auto-update-default item)
           :item-display ,(pop-up-menu-item-display item)
           ,@(let ((default-item (pop-up-menu-default-item item)))
               (when (neq 1 default-item)
                 `(:default-item ,default-item))))))
           

;;;; *static-text* ;;;;;

;no additional defs needed


;;;; *editable-text* ;;;;;

(defmethod object-source-code ((item fred-dialog-item))
  (nconc (call-next-method)
         `(:allow-returns ,(allow-returns-p item)
           :draw-outline ,(slot-value item 'ccl::draw-outline))))

;;;;;; scrolling fred-view

(defmethod object-source-code ((item scrolling-fred-view))
  ; we don't do colors today
  (let* ((text (dialog-item-text item))
         (buf (fred-buffer item))
         (style (buffer-get-style buf  0 (buffer-size buf)))
         (fred-item (fred-item item))
         (color-list (part-color-list fred-item))
         (h-scroller (ccl::h-scroller item))
         (v-scroller (ccl::v-scroller item))
         (nick-name (view-nick-name item))
         (new (intern "NEW" *package*))) ; gag puke
    `(let ((,new (make-instance 'scrolling-fred-view-with-frame
                   ,@(when nick-name `(:view-nick-name ',nick-name))
                   ,@(when color-list `(:part-color-list ',color-list))
                  :save-buffer-p t
                  :h-scrollp ,(if h-scroller t nil)                  
                  :v-scrollp ,(if v-scroller t nil)
                  :wrap-p ,(if (fred-wrap-p item) t nil)
                  :view-size ,(ppoint (view-size item))
                  :view-position ,(ppoint (view-position item)))))
       ,(if (neq 0 (length text))
          `(buffer-insert-with-style 
            (fred-buffer ,new) ,text
            ,(if (consp style)  ; fix for possible color vector too 6/9/95
               `(cons 
                 (make-array ,(length (car style))
                             :element-type ',(array-element-type (car style))
                             :initial-contents ,(car style))
                 (make-array ,(length (cdr style))
                             :element-type ',(array-element-type (cdr style))
                             :initial-contents ,(cdr style)))
               `(make-array ,(length style) :element-type ',(array-element-type style)
                            
                            ; assume *print-readably* is nil today
                            :initial-contents ,style)))
          `(set-view-font ,new ',(view-font item)))       
       ,@(when (and h-scroller (setq h-scroller (part-color-list h-scroller)))
           `((setf (part-color-list (h-scroller ,new)) ',h-scroller)))
       ,@(when (and v-scroller (setq v-scroller (part-color-list v-scroller)))
           `((setf (part-color-list (v-scroller ,new)) ',v-scroller)))
       ,@(when color-list
           `((setf (part-color-list (fred-item ,new)) ',color-list)))
       
       ,new)))


;;;; *check-box* ;;;;;

(defmethod object-source-code ((item check-box-dialog-item))
  (nconc (call-next-method)
         (if (check-box-checked-p item)
             (list :check-box-checked-p t)
             ())))


;;;; *radio-button* ;;;;;

(defmethod object-source-code ((item radio-button-dialog-item))
  (nconc (call-next-method)
         `(,@(if (radio-button-pushed-p item)
                 '(:radio-button-pushed-p t)
                 nil)
           ,@(let ((cluster (radio-button-cluster item)))
               (if (eql 0 (radio-button-cluster item))
                 nil
                 `(:radio-button-cluster ,cluster))))))


;;;; *table* ;;;;;

(defun quote-a-symbol (thing)
  (if (and thing (symbolp thing)) `(quote ,thing) thing))

(defmethod object-source-code ((item table-dialog-item))    
  (nconc (call-next-method)
         `(:cell-size ,(ppoint (cell-size item))
           :selection-type ,(slot-value item 'ccl::selection-type)
           :table-hscrollp ,(table-hscrollp item)
           :table-vscrollp ,(table-vscrollp item)
           ,@(let ((pf (table-print-function item)))
               (if (neq pf #'princ)
                 `(:table-print-function ,(quote-a-symbol pf))))
           :rows ,(ccl::table-rows item)
           :columns ,(ccl::table-columns item)
           :track-thumb-p ,(scroll-bar-track-thumb-p item) 
           :separator-color ,(separator-color item)
           :separator-pattern ,(let ((slot (ccl::separator-pattern-slot item)))
                                 (quote-a-symbol slot))
           :separator-size ,(ppoint (separator-size item)))))
           


;;;; *sequence-table* ;;;;;

(defmethod object-source-code ((item sequence-dialog-item))
  (let* ((wrap (slot-value item 'ccl::sequence-wrap-length))
         (order (slot-value item 'ccl::sequence-order)))
    (nconc (call-next-method)
           `(:table-sequence ',(table-sequence item))
           (if (eq wrap most-positive-fixnum)
               nil
               `(:sequence-wrap-length ,wrap))
           (if (eq order :vertical)
               nil
               `(:sequence-order ,order)))))

#|
;;;; *array-table* ;;;;;

(defmethod object-source-code ((item ccl:array-dialog-item))
  (nconc (call-next-method)
         `(:table-array ',(ccl:table-array item)))) |#


;;all done
(provide 'item-defs)

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
	3	1/2/95	akh	set fonts correctly in editors for editable-text and scrolling ditto
|# ;(do not edit past this line!!)
