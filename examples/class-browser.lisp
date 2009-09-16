;;;-*-Mode: LISP; Package: CCL -*-
;;;;============================================================================================
;;;; Class-Browser.lisp (V 1.2)
;;;; Author: Gilles Bisson (Gilles.Bisson@imag.fr)
;;;; Date:   9-2002
;;;; Tested with MCL 4.3.1 and above

;;;
;;; Use and copying of this software and preparation of derivative works
;;; based upon this software are permitted, so long as this copyright
;;; notice and the author's name are included intact in this file or the
;;; source code of any derivative work
;;;
;;; Digitool, Inc. is permitted to integrate parts or whole of this module
;;; into MCL without including the copyright notice, as long as the author's
;;; name is included in any file containing or derived from the contents
;;; of this file.
;;;
;;; This software is made available AS IS, and no warranty is made about
;;; the software or its performance.

;;;; What is Class Browser ?
;;;; =======================

;;; You guess it : a Class Browser ... It allows to explore the  hierarchy of MCL classes and to
;;; display some useful information concerning : Initargs, Methods, ...
;;;
;;; As Class-Browser is a good compagnon for Apropos and Get-Info, it  is added to the third
;;; position of the TOOLS menu.

;;;; How to use it ?
;;;; ===============

;;; First, open the Class Browser (third command of the TOOLS menu)
;;;
;;; The topleft list contains the "father" classes and the topright  list the children classes.
;;; Initially the leftmost list is initialized with the content of  the "favorites" bookmark (the
;;; topright pop-up menu). As you can imagine the + and - button  allows to add or suppress the
;;; currently selected class from the favorite bookmark.
;;;
;;; Commands to navigate within the hierarchy :
;;;   - a simple click on a father (or child) class displays the  children (or father) classes
;;;   - a double click on a father (or child) class allows to go to  the upper (lower) level
;;;   - the arrow keys (top & down) allow to navigate into the current list
;;; Important : the terminal classes (classes without child) are  displayed in blue
;;;
;;; The bottom area displays the information corresponding to the  option selected in the pop-up
;;; menu (initargs, methods, ...). When the bottom list contains a  class name (typically if the
;;; Precedence option is activated), a double-click set the father  list to this class.
;;;
;;; The buttons inspect, edit, doc are applied on the current  selected item (class, method, ...)
;;;
;;; It is easy to extend the class browser and to introduce some  other types of "inspectors"
;;; (i.e. new options allowing to explore the selected class), there  are two steps :
;;;     1) add the new inspector in *class-browser-inspector*
;;;     2) implement the corresponding CLASS-INSPECTOR method (look  at the existing ones)
;;;

;;;; Things to do
;;;; ============

;;;   - Save the content of *class-browser-favorites* (but where ??)
;;;   - Create automatically the *class-browser-inspector* list by  introspection
;;;   - Connect this browser with a grapher to have a graphic inspector :-)

;;; akh fix initialize-instance and ... in menu-item title


(in-package :ccl)
(export '(*class-browser* *class-browser-size&position* 
*class-browser-favorites* class-browser))

(when (osx-p) (setq *use-pop-up-control* t)) ; better no ?

;; the class-browser window can be resized when the module  autoscaled-views is loaded ...

;;; Variable containing the window pointer

(defparameter *class-browser* nil)
(defparameter *class-browser-size* #@(376 371))
(defparameter *class-browser-size&position* (cons 
*class-browser-size* #@(300 300)))
(defparameter *class-browser-favorites* '(dialog-item simple-view t 
view windoid window))
(defparameter *class-browser-inspector* '(initargs slots methods 
precedence documentation))

;;; definition of the CLASS-BROWSER class

(defclass class-browser (window)
   ((current-inspector  :initform nil :accessor current-inspector))
   (:documentation "implement a class browser window."))

(defmethod initialize-instance ((self class-browser) &rest initargs)
   (when *class-browser* (window-close *class-browser*))
   (setq *class-browser* self)
   (apply #'call-next-method
          self
          :window-type :document-with-grow
          :window-title "class browser"
          :window-show nil
          :view-position (cdr *class-browser-size&position*)
          :view-size     *class-browser-size*
          :back-color *tool-back-color*
          (if (ccl::osx-p) :theme-background :ignore) t  ; correct  background in osx
         ; :view-subviews (window-components self)
          initargs)
   (apply #'add-subviews self (window-components self))
   (set-view-size self (car *class-browser-size&position*)) ; to  resize the component if needed
   (window-show self))

;;; memorize the current size & position of the class-browser before closing

(defmethod window-close :before ((window class-browser))
   (setf (car *class-browser-size&position*) (view-size window)
         (cdr *class-browser-size&position*) (view-position window)))

(defmethod window-close ((window class-browser))
   (setq *class-browser* nil)
   (call-next-method))

;;; update the position and size of the subviews when the window's  size is modified

(defmethod set-view-size :before ((self class-browser) h &optional v)
    (let* ((new-size (make-point h v))
              (dh (- (point-h new-size) (point-h (view-size self))))
              (dv (- (point-v new-size) (point-v (view-size self)))))
     (dolist (view (subviews self))
       (case (view-nick-name view)
         (input (update-hv-position-and-size view 0 0 dh 0))
         ((book plus moins inspect edit docb)
          (update-hv-position-and-size view dh 0 0 0))
         ;; a little bit more complicated for father and children  since it is not a simple offset
         (father (set-view-size view (truncate (point-h new-size) 2) 
                                              (point-v (view-size view))))
         (children (set-view-position view (1+ (truncate (point-h new-size) 2)) 
                                                        (point-v (view-position view)))
                   (set-view-size view (- (point-h new-size) (point-h (view-position view))) 
                                           (point-v (view-size view))))
         (doc      (update-hv-position-and-size view 0 0 dh dv))
         (info     (update-hv-position-and-size view 0 0 dh dv))))))

(defmethod update-hv-position-and-size (view dph dpv dsh dsv)
   (set-view-position view (add-points (view-position view) (make-point dph dpv)))
   (set-view-size view (add-points (view-size view) (make-point dsh dsv))))

;;; Needed to erase the scroller outline which is (erroneously) drawn  when the documentation
;;; option is selected

(defmethod view-activate-event-handler ((window class-browser))
    (call-next-method)
    (let ((view (view-named 'doc window)))
       (when view
           (invalidate-view view))))

;;; This class is derived from ARROW-SEQUENCE-DIALOG-ITEM. It allows  to navigate in the list
;;; with the arrow keys but doesn't draw the frame around the activated list

(defclass key-sequence-dialog-item (key-handler-mixin sequence-dialog-item) ())

(defmethod view-key-event-handler ((item key-sequence-dialog-item) char)
   (let (delta)
     (when (setq delta (case char
                         (#\uparrow      #@(0 -1))
                         (#\downarrow    #@(0 1))))
       (let* ((cell (first-selected-cell item))
              (new-cell (add-points (or cell #@(0 0)) delta)))
         (when (point<= #@(0 0)
                        new-cell
                        (subtract-points (table-dimensions item) #@(1 1)))
           (deselect-cells item)
           (cell-select item new-cell)
           (unless (and (cell-position item new-cell)
                        (cell-position item (add-points new-cell delta))) ; cautious
             (scroll-to-cell item new-cell))
           (dialog-item-action item))))))

;;; to set the focus on the list

(defmethod view-click-event-handler ((item key-sequence-dialog-item) where)
   (declare (ignore where))
   (set-current-key-handler (view-window item) item)
   (call-next-method))

;;; to avoid a text cursor

(defmethod view-cursor ((item key-sequence-dialog-item) where)
   (declare (ignore where))
   *arrow-cursor*)

;;; to accept the return key as a (re)-validation of the string in  the input field

(defmethod view-key-event-handler :before ((self class-browser) char)
   (let ((active (current-key-handler self)))
     (when (and active
                (eq (view-nick-name active) 'input)
                (eq char #\Newline))
       (dialog-item-action active))))

;;; to easy the creation of a menu-item list

(defun make-menu-item-list (items action &optional checked-item)
   (mapcar #'(lambda (item)
               (MAKE-INSTANCE 'MENU-ITEM
                 :MENU-ITEM-TITLE (if (stringp item) item
                                      (STRING-CAPITALIZE (string item)))
                 :MENU-ITEM-CHECKED (eq item checked-item)
                 :MENU-ITEM-ACTION #'(LAMBDA () (funcall action item))))
           items))

;;; definition of all the components of the CLASS-BROWSER dialog box,  quite long :-/

(defmethod window-components ((self class-browser))
   (LIST
    ;; edit part
    (MAKE-DIALOG-ITEM 'static-text-dialog-item #@(6 9) #@(75 14) "Name:")
    (MAKE-DIALOG-ITEM 'EDITABLE-TEXT-DIALOG-ITEM #@(56 10) #@(96 14) ""
                      #'(lambda (item)
                          (let ((str (dialog-item-text item)) class result)
                            (do-all-symbols (symb)
                              (when (and (setq class (find-class symb nil))
                                         (ccl::%apropos-substring-p str (symbol-name symb)))
                                (push class result)))
                            (update-class-table (view-named 'father *class-browser*) result)
                            (update-class-table (view-named 'children *class-browser*) nil)))
                      :view-nick-name 'input
                      :VIEW-FONT '("Monaco" 9 :SRCOR (:COLOR-INDEX 0)))
    ;; favorites menu part
    (MAKE-INSTANCE 'POP-UP-MENU
      :VIEW-POSITION #@(170 6)
      :VIEW-SIZE #@(138 21)
      :view-nick-name 'book
      :VIEW-FONT '("Lucida grande" 12 :SRCOR (:COLOR-INDEX 0))
      :MENU-ITEMS (make-menu-item-list
                   *class-browser-favorites*
                   #'(lambda (item) (set-father-table *class-browser* item))))
    (MAKE-DIALOG-ITEM 'BUTTON-DIALOG-ITEM #@(315 8) #@(25 17) "+"
                      #'(lambda (item) item
                         (let ((class (currently-selected-content *class-browser*))
                               (book (view-named 'book *class-browser*)))
                           (when (and class (not (member class *class-browser-favorites*)))
                             (apply #'remove-menu-items (cons book (menu-items book))) ; remove menu
                             (setq *class-browser-favorites* 
                                       ; new list
                                   (sort (cons class *class-browser-favorites*)
                                         #'(lambda (x y) (string-lessp (symbol-name x) (symbol-name y)))))
                             (apply #'add-menu-items ; new menu
                                    (cons book (make-menu-item-list
                                                *class-browser-favorites*
                                                #'(lambda (item) 
                                                      (set-father-table *class-browser* item)))))
                             (set-pop-up-menu-default-item book (1+ (position class *class-browser-favorites*))))))
      :VIEW-FONT '("Lucida grande" 9 :SRCOR (:COLOR-INDEX 0))
      :view-nick-name 'plus)     ; doesn't work, but why ?
    (MAKE-DIALOG-ITEM 'BUTTON-DIALOG-ITEM #@(347 8) #@(25 17) " -"
                      #'(lambda (item) item
                         (let ((class (currently-selected-content *class-browser*))
                               (book (view-named 'book *class-browser*)))
                           (when (and class (member class *class-browser-favorites*))
                             (setq *class-browser-favorites*
                                   (remove class *class-browser-favorites*))
                             (remove-menu-items book (find-menu-item book (STRING-CAPITALIZE (string class))))
                             (menu-disable book)   ; to force the redraw
                             (menu-enable book))))
      :VIEW-FONT '("Lucida grande" 9 :SRCOR (:COLOR-INDEX 0))
                      :view-nick-name 'moins)     ; doesn't work, but why ?
    ;; the father and children list of classes
    (MAKE-DIALOG-ITEM 'key-sequence-dialog-item #@(0 35) #@(188 144) ""
                      #'(lambda (father)
                          (let ((class (selected-content father))
                                (children (view-named 'children *class-browser*)))
                            (when class
                              (if (double-click-p)
                                (let ((father-class (CLASS-DIRECT-SUPERCLASSES (find-class class))))
                                  (when father-class
                                    (update-class-table father father-class)
                                    (setq father-class (first (table-sequence father)))
                                    (update-class-table children (CLASS-DIRECT-SUBCLASSES (find-class father-class)))
                                    (select-cell-containing children class)
                                    (update-information-field *class-browser*)))
                                (progn
                                  (update-class-table children (CLASS-DIRECT-SUBCLASSES (find-class class)))
                                  (update-information-field *class-browser*))))))
                      :view-nick-name 'father
                      :VIEW-FONT '("monaco" 9 :SRCOR (:COLOR-INDEX 0))
                      :TABLE-HSCROLLP NIL :TABLE-VSCROLLP T :TRACK-THUMB-P T
                      :CELL-SIZE #@(173 11) :ROWS 16 :COLUMNS 1 :cell-colors :text
                      :TABLE-SEQUENCE *class-browser-favorites*)
    (MAKE-DIALOG-ITEM 'key-sequence-dialog-item #@(189 35) #@(188 144) ""
                      #'(lambda (children)
                          (let ((class (selected-content children))
                                (father (view-named 'father *class-browser*)))
                            (when class
                              (if (double-click-p)
                                (let ((children-class (CLASS-DIRECT-SUBCLASSES (find-class class))))
                                  (when children-class
                                    (update-class-table children children-class)
                                    (update-class-table father (list (find-class class)))
                                    (select-cell-containing father class)
                                    (update-information-field *class-browser*)))
                                (progn
                                  (update-class-table father (CLASS-DIRECT-SUPERCLASSES (find-class class)))
                                  (update-information-field *class-browser*))))))
                      :view-nick-name 'children
                      :VIEW-FONT '("monaco" 9 :SRCOR (:COLOR-INDEX 0))
                      :TABLE-HSCROLLP NIL :TABLE-VSCROLLP T :TRACK-THUMB-P T
                      :CELL-SIZE #@(173 11) :ROWS 16 :COLUMNS 1 :cell-colors :text
                      :TABLE-SEQUENCE "")
    ;; display options and commands
    (MAKE-INSTANCE 'POP-UP-MENU
      :VIEW-POSITION #@(6 186)
      :VIEW-SIZE #@(140 21)
      :VIEW-FONT '("Lucida grande" 12 :SRCOR (:COLOR-INDEX 0))
      :view-nick-name 'chooser
      :MENU-ITEMS (make-menu-item-list *class-browser-inspector*
                                       #'(lambda (item)
                                           (setf (current-inspector *class-browser*) item)
                                           (update-information-field *class-browser*))))
    (MAKE-DIALOG-ITEM 'BUTTON-DIALOG-ITEM #@(165 187)  #@(75 19) "Inspect"
                      #'(lambda (item)
                          (let ((info (currently-selected-info (view-window item)))
                                (name (currently-selected-content (view-window item))))
                            (if info (inspect info)
                                (when (and name (ignore-errors (find-class name)))
                                  (inspect (find-class name))))))
                      :view-nick-name 'inspect)
    (MAKE-DIALOG-ITEM 'BUTTON-DIALOG-ITEM #@(255 187)  #@(50 19) "Edit"
                      #'(lambda (item)
                          (let ((item (or (currently-selected-info (view-window item))
                                          (currently-selected-content (view-window item)))))
                            (when item
                              (unless (ccl::edit-definition item) (beep)))))
                      :view-nick-name 'edit)
    (MAKE-DIALOG-ITEM 'BUTTON-DIALOG-ITEM #@(314 187)  #@(50 19) "Doc"
                      #'(lambda (item)
                          (let ((item (or (currently-selected-info (view-window item))
                                          (currently-selected-content (view-window item)))))
                            (when item
                              ;; call edit-definition-p to deal with the function name
                              (multiple-value-bind (files name) (edit-definition-p item)
                                (declare (ignore files))
                                (show-documentation (or name item))))))
                      :view-nick-name 'docb)
    ;; create two views : one used for the textual information, the other for the sequences
    (MAKE-DIALOG-ITEM 'FRED-DIALOG-ITEM #@(2 217) #@(374 155) "" nil :view-nick-name 'doc)
    (MAKE-DIALOG-ITEM 'key-sequence-dialog-item #@(0 215) #@(376 157) "Untitled"
                      #'(lambda (info)
                          (deselect-cells (find-named-sibling info 'father))
                          (deselect-cells (find-named-sibling info 'children))
                          ;(SET-CURRENT-KEY-HANDLER *class-browser* nil)
                          (when (double-click-p)
                            (setq *multi-click-count* 1)   ; to clean-up the double click
                            (when (ignore-errors (ccl::classp (selected-content info)))
                              (set-father-table *class-browser* (class-name (selected-content info))))))
                      :view-nick-name 'info
                      :VIEW-FONT '("monaco" 9 :SRCOR (:COLOR-INDEX 0))
                      :TABLE-HSCROLLP NIL :TABLE-VSCROLLP T :TRACK-THUMB-P T
                      :CELL-SIZE #@(361 11) :ROWS 16 :COLUMNS 1
                      :TABLE-SEQUENCE ())))

;;; to update the TABLE of classes

(defmethod update-class-table ((table key-sequence-dialog-item) classes)
   (let ((row 0) idx
         (dark-blue (make-color 0 0 52000)))
     (deselect-cells table)
     (scroll-to-cell table 0)
     (setq classes (sort (mapcar #'class-name classes) #'STRING-LESSP))
     (set-table-sequence table classes)
     ;; to colorize the terminal classes
     (dolist (class (table-sequence table))
       (setq idx (make-point 0 row))
       (if  (CLASS-DIRECT-SUBCLASSES (find-class class))
         (set-part-color table idx *black-color*)
         (progn
           ;(format t "set ~A cell in blue" (%integer-to-string idx)) (terpri)
           (set-part-color table idx dark-blue)))    ;;;; color seems  broken in 4.4 ?!
       (incf row))))

;;; set the father list to one given classes, select it and refresh  the other views

(defmethod set-father-table ((view class-browser) class)
   (let ((father (view-named 'father *class-browser*)))
     (update-class-table father (list (find-class class)))
     (select-cell-containing father class)
     (dialog-item-action father)))

;;; To update the information field (there are 2 kinds of fields)

(defmethod update-information-field ((view class-browser))
   (let* ((item (currently-selected-content view))
          (class (and (ignore-errors (find-class item)) (find-class item)))
          (info (view-named 'info view)))
     (deselect-cells info)
     (setf (part-color-list info) nil)
     (scroll-to-cell info 0)
     (class-inspector view class (or (current-inspector view) (car *class-browser-inspector*)))))

;;; To select the field : namely to bring this field to front of the window

(defmethod select-information-field ((view class-browser) field)
   (unless (zerop (view-level field))
     (view-bring-to-front field)))

;;; definition of a generic (unspecialized) class inspector

(defmethod class-inspector ((view class-browser) class (option (eql T)))
   (let ((field (view-named 'info view)))     ; retrieve the display view
     (select-information-field view field)    ; to select this view
     (if class
       (set-table-sequence field '("This inspector is not implemented"))
       (set-table-sequence field nil))))      ; to empty the field if  no class is selected

;;; definition of the INITARGS inspector

(defmethod class-inspector ((view class-browser) class (option (eql 
'initargs)))
   (let ((field (view-named 'info view)) keywords)
     (select-information-field view field)
     (if (and class (method-exists-p #'ccl::CLASS-SLOT-INITARGS class))
       (progn
         ;; we can call this function without IGNORE-ERRORS since  CLASS-SLOT-INITARGS exists
         (setq keywords (CCL::CLASS-MAKE-INSTANCE-INITARGS class))
         (when (sequencep keywords)
           (setq keywords (sort (copy-seq keywords) #'string-lessp))
           (set-table-sequence field keywords)))
       (set-table-sequence field nil))))

;;; definition of the SLOTS inspector

(defmethod class-inspector ((view class-browser) class (option (eql 'slots)))
   (let ((field (view-named 'info view)))
     (select-information-field view field)
     (if (and class
              (method-exists-p #'ccl::CLASS-CLASS-SLOTS class)
              (method-exists-p #'ccl::CLASS-INSTANCE-SLOTS class))
       (progn
         (set-table-sequence field (append (ccl::CLASS-CLASS-SLOTS class)
                                           (ccl::CLASS-INSTANCE-SLOTS class)))
         ;; to colorize class-slots
         (dotimes (row (length (ccl::CLASS-CLASS-SLOTS class)))
           (set-part-color field (make-point 0 row) *brown-color*)))
       (set-table-sequence field nil))))

;;; definition of the METHODS inspector

(defmethod class-inspector ((view class-browser) class (option (eql 'methods)))
   (let ((field (view-named 'info view)))
     (select-information-field view field)
     (if class
       (set-table-sequence
        field
        (sort (specializer-direct-methods class) #'edit-definition-spec-lessp))
       (set-table-sequence field nil))))

;;; definition of the PRECEDENCE list inspector

(defmethod class-inspector ((view class-browser) class (option (eql 
'precedence)))
   (let ((field (view-named 'info view)))
     (select-information-field view field)
     (if class
       (set-table-sequence field (ccl::CLASS-PRECEDENCE-LIST class))
       (set-table-sequence field nil))))

;;; definition of the DOCUMENTATION inspector (use a fred-dialog-item field)

(defmethod class-inspector ((view class-browser) class (option (eql 'documentation)))
   (let ((field (view-named 'doc view)))
     (select-information-field view field)
     (if class
       (show-documentation (class-name class) field)
       (set-dialog-item-text field ""))))

;;; retrieval or selection of different items in the tables

(defmethod currently-selected-info ((view class-browser))
   (let* ((info     (view-named 'info view))
          (icell    (first-selected-cell info)))
     (when icell (cell-contents info icell))))

(defmethod currently-selected-content ((view class-browser))
   (let* ((active   (current-key-handler view)))
     (when (eq (type-of active)' key-sequence-dialog-item)
       (selected-content active))))

(defmethod selected-content ((table sequence-dialog-item))
   (let ((item (first-selected-cell table)))
     (when item (cell-contents table item))))

(defmethod select-cell-containing ((table sequence-dialog-item) object &key (test #'eq))
   (let ((pos (position object (table-sequence table) :test test)))
     (when pos
       (unless (<= 0 (- pos (point-v (scroll-position table))) (- (point-v (visible-dimensions table)) 2))
         (scroll-to-cell table 0 pos))                ; scroll only when needed
       (deselect-cells table)                         ; suppress the (maybe) current selection
       (cell-select table 0 pos)
       (window-update-event-handler (view-window table))   ; to force  the table redraw :-/
       (SET-CURRENT-KEY-HANDLER *class-browser* table)     ; key focus  on this table
       pos)))


;;; install (once) the CLASS-BROWSER command in the tools menu at the  third place ...

(without-interrupts
  (let ((copied-items (menu-items *tools-menu*))
        (browser-p (find-menu-item *tools-menu* "Class BrowserÉ")))
    ;; to empty the current tool menu
    (apply #'remove-menu-items (cons *tools-menu* (menu-items *tools-menu*)))
    ;; add the two first items
    (add-menu-items *tools-menu* (first  copied-items))  ; Apropos ...
    (add-menu-items *tools-menu* (second copied-items))  ; Get Info ...
    ;; the class browser
    (add-menu-items *tools-menu*
                    (make-instance 'menu-item
                      :menu-item-title "Class BrowserÉ"
                      :menu-item-action
                      #'(lambda ()
                          ;; first, we retrieve the current selection  if it exists
                          (let* ((window (front-window)) start end
                                 (key-handler (or (current-key-handler window) window))
                                 (buffer (ignore-errors (fred-buffer key-handler))))
                            (when buffer
                              (multiple-value-setq (start end) (selection-range key-handler)))
                            ;; second create or select the browser
                            (if *class-browser*
                              (window-select *class-browser*)
                              (make-instance 'class-browser))
                            ;; third we affect if the current symbol is a class
                            (when (and buffer (neq start end))
                              (set-dialog-item-text (view-named 'input *class-browser*)
                                                    (buffer-substring buffer start end))
                              (dialog-item-action (view-named 'input *class-browser*)))))
                      ))
    ;; and finally the remaining items of the TOOLS menu
    (if browser-p
      (apply #'add-menu-items (cons *tools-menu* (cdddr copied-items))) ; skip the old definition
      (apply #'add-menu-items (cons *tools-menu* (cddr copied-items))))))


