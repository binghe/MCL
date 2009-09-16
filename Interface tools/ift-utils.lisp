; -*- Mode:Lisp; Package:INTERFACE-TOOLS; -*-

;;	Change History (most recent first):
;;  3 3/9/96   akh  use *white-color* vs black for user-pick-color
;;  3 3/20/95  akh  change editing-dialogs-p to use view-window
;;  (do not edit before this line!!)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ift-utils.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  utility functions, variables, and classes used by both the dialog editor
;;  and menu-editor.

;;;;;;;;;
;;
;; Change History
;; adapt for new content of *font-list*
;; -------- 5.2b5
;; :outline and :shadow fonts disabled on osx for control-dialog-item because no work when cfstring
;; condense and extend are mutually exclusive
;; --------- 5.0 final
;; 06/01/01 akh grow-gray-rect for carbon/OSX - port aint a port
;; 11/10/97 akh    copy-instance ((item fred-dialog-item)) re history-length and buffer-empty-font-codes
;; 08/24/93 bill  get-next-event gets called more often in grow-gray-rect.
;;                (Suggested by ueda@shpcsl.sharp.co.jp (UEDA masaya))
;; -------------- 3.0d12
;; 11/13/92 alice modal dialogs are proper movable-dialog
;; 11/11/92 alice get-text-from-user has scroll bars. what a concept, font styles were totally bogus. 
;; 11/07/91 bill (setf (view-nick-name ...) ...) -> (set-view-nick-name ...)
;; 07/26/91 bill copy-instance needed to cons new view-alist &
;;               view-font-codes storage
;; 06/05/91 bill :srccopy -> :srcor
;; 05/29/91 bill copy-instance for standard-object defined by MCL
;; 02/07/91 bill ENTER key works like OK button in get-text-from-user 
;; *2.0a5*
;;

(in-package :interface-tools)


;;;;;;;;;
;;
;; in edit or use mode?
;;

(defvar *editing-dialogs* nil
  "determines whether dialogs are used or edited")

(defmethod ccl::editing-dialogs-p ((view simple-view))
  (and *editing-dialogs*
       (not *modal-dialog-on-top*)
       (ccl::editing-dialogs-p (view-window view))))

(defmethod ccl::editing-dialogs-p ((w window))
  (and *editing-dialogs*
       (not *modal-dialog-on-top*)))

; Make sure the user can still type at editor windows and the listener.
(defmethod ccl::editing-dialogs-p ((w fred-window))
  nil)

(defmethod ccl::editing-dialogs-p ((non-editable-dialog non-editable-dialog))
  nil)

;;;;;;;;;
;;
;;  color-part-pop-up
;;
;;  a class of pop-up-menus for setting the colors of objects

(defclass color-part-pop-up (ccl::pop-up-menu)
  ((colored-object :initarg :colored-object :accessor color-part-pop-up-object)))

(defclass color-part-menu-item (menu-item)
  ((part-symbol :initarg :part-code :reader color-part-menu-item-part-code)))

(defmethod initialize-instance :around ((menu color-part-pop-up) &rest initargs
                                        &key
                                        dialog-item-text colored-object part-codes)
  (declare (dynamic-extent initargs))
  (apply #'call-next-method
         menu
         :menu-colors `(:menu-background ,*white-color*)
         :item-display (if *use-pop-up-control* :selection dialog-item-text)
         :dialog-item-text ""
         initargs)
  (dolist (part part-codes)
    (add-menu-items menu (make-instance 'color-part-menu-item
                                        :part-code part
                                        :colored-object colored-object))))

(defmethod set-colored-object ((menu color-part-pop-up) new-object)
  (setf (color-part-pop-up-object menu) new-object)
  (dolist (item (menu-items menu))
    (let ((part (color-part-menu-item-part-code item)))
      (set-part-color item
                      :item-title
                      (part-color new-object part)))))

(defmethod initialize-instance :after ((item color-part-menu-item)
                                        &key part-code colored-object)
  (set-menu-item-title item (string-capitalize part-code))
  (when colored-object
    (let* ((color (part-color colored-object part-code)))
      (set-part-color item :item-title color))))

(defmethod menu-item-action ((item color-part-menu-item))
  (let* ((colored-object (color-part-pop-up-object (menu-item-owner item)))
         (part (color-part-menu-item-part-code item))
         (part-color (part-color colored-object part))
         (new-color (user-pick-color 
                     :color (if (or (null part-color)
                                    (= part-color *black-color*))
                              *white-color*
                              part-color))))
    (set-part-color colored-object part new-color)
    (set-part-color item :item-title new-color)))

(defmethod set-part-color ((item color-part-menu-item) part color)
  (when (and (eq part :item-title)
             (real-color-equal color *white-color*))
    (setq color *black-color*))
  (call-next-method item part color))


;;;;
;;code for duplicating items
;;The method for standard-object is provided by MCL

(defmethod copy-instance ((menu-item menu-item))
  (let* ((new-item (call-next-method)))
    (setf (slot-value new-item 'ccl::owner) nil)
    new-item))

; this fails for popups because they get the same
; menu-rect and title-rect
(defmethod copy-instance ((menu menu))
  (let* ((new-menu (call-next-method))
         (old-items nil))
    (setf old-items (slot-value menu 'ccl::item-list)
          (slot-value new-menu 'ccl::menu-handle) nil
          (slot-value new-menu 'ccl::item-list) nil
          (slot-value new-menu 'ccl::menu-id) nil)
    (apply #'add-menu-items
           new-menu
           (mapcar #'(lambda (item)
                       (copy-instance item))
                   old-items))
    new-menu))

(defmethod copy-instance ((menu pop-up-menu))
  (let ((new (call-next-method)))
    (setf (slot-value new 'ccl::menu-rect) nil)
    (setf (slot-value menu 'ccl::title-rect) nil)
    new))

(defmethod copy-instance ((item simple-view))
  (let* ((new-item (call-next-method)))
    (setf (slot-value new-item 'ccl::view-container) nil
          (slot-value new-item 'ccl::wptr) nil
          (ccl::view-alist new-item) (copy-alist (ccl::view-alist item)))
    (set-view-nick-name item nil)
    (let ((font-codes (view-get new-item 'view-font-codes)))
      (when font-codes
        (setf (view-get new-item 'view-font-codes) (copy-list font-codes))))
    new-item))

(defmethod copy-instance ((item dialog-item))
  (let* ((new-item (call-next-method)))
    (setf (slot-value new-item 'ccl::dialog-item-handle) nil)
    new-item))

(defmethod copy-instance ((item fred-dialog-item))
  (let* ((new-item (call-next-method)))
    (setf (slot-value new-item 'ccl::mark-ring) nil)
    (fred-initialize                    ; cons up a new buffer
     new-item
     :buffer-chunk-size (fred-chunk-size item)
     :text-edit-sel-p (fred-text-edit-sel-p item)
     :wrap-p (fred-wrap-p item)
     :history-length (ccl::history-length (ccl::fred-history item))
     :package (fred-package item)
     :view-size (view-size item))
    (let ((old-b (fred-buffer item))
          (new-b (fred-buffer new-item)))
      (multiple-value-bind (ff ms)(ccl::buffer-empty-font-codes old-b)
        (ccl::set-buffer-empty-font-codes new-b ff ms)))
    (let* ((buf (fred-buffer item))
           (size (buffer-size buf))
           (text (buffer-substring buf 0 size))
           (style (buffer-get-style buf 0 size)))
      (buffer-insert-with-style 
       (fred-buffer new-item) text style 0)
      (multiple-value-bind (s e) (selection-range item)
        (set-selection-range new-item s e)))                           
    new-item))

(defmethod copy-instance ((item static-text-dialog-item))
  (let* ((new-item (call-next-method))
         (my-text (dialog-item-text item)))
    (set-dialog-item-text new-item my-text)
    new-item))


;;;;;;;;;;;;;;;;
;;a char-choice dialog


(defclass one-char-box (editable-text-dialog-item) ())

(defmethod view-key-event-handler ((item one-char-box) char)
  (declare (ignore char))
  (set-dialog-item-text item "")
  (call-next-method)
  )

;;;;;;;;;;
;;
;; an object for printing out points
;;

(defclass point-printer ()
  ((point :initform #@(0 0) :initarg :point :accessor pp-point)))

(defmethod print-object ((pp point-printer) stream)
  (format stream "~a" (point-string (pp-point pp))))

(defun ppoint (point)
  (make-instance 'point-printer :point point))


;;;;;;;;;;;;;;;;;;;
;;
;; bigger than get-string-from-user
;;

(defun enter-key-event-p ()
  (let ((event *current-event*))
    (and event
         (eql #$KeyDown (rref event EventRecord.what))
         (eql (char-code #\enter)
              (%get-byte event 5)))))

(defun get-text-from-user (message old-text)
  (flet ((return (item)
            (return-from-modal-dialog
             (dialog-item-text item))))
    (modal-dialog
     (make-instance 'dialog
                    :window-type :movable-dialog
                    :window-title ""
                    :view-position '(:top 49)
                    :view-size #@(437 215)
                    :close-box-p nil
                    :window-show  nil
                    :view-subviews
                    (list
                     (make-dialog-item 'static-text-dialog-item
                                       #@(7 2) #@(310 21)
                                       message nil)
                     (make-instance 'ccl::scrolling-fred-view ;editable-text-dialog-item
                       :view-position #@(9 27)
                       :view-size #@(421 145)
                       :dialog-item-text old-text
                       :view-nick-name 'text-item
                       :view-font '("Monaco" 9))
                     (make-dialog-item 'button-dialog-item
                                       #@(332 188) #@(62 20) "OK"
                                       #'(lambda (item)
                                           (return (find-named-sibling item 'text-item)))
                                       :default-button t)
                     (make-dialog-item 'button-dialog-item
                                       #@(251 188) #@(62 20) "Cancel"
                                       #'(lambda (item)
                                           (declare (ignore item))
                                           (return-from-modal-dialog :cancel)))))
     t
     #'(lambda ()
         (when (enter-key-event-p)
           (return (view-named 'text-item (front-window))))))))

;;;;;;;;;;;;
;;
;; some window functions
;;

(defmethod window-centered-p ((window window))
  "returns an appropriate argument to set-view-position"
  (let* ((center-slop 30)
         (size (view-size window))
         (pos (view-position window))
         (win-h-center (+ (point-h pos) (ash (point-h size) -1)))
         (win-v-center (+ (point-v pos) (ash (point-v size) -1)))
         (screen-h-center (ash *screen-width* -1))
         (screen-v-center (ash *screen-height* -1))
         (h-centered (< (abs (- win-h-center screen-h-center)) center-slop))
         (v-centered (< (abs (- win-v-center screen-v-center)) center-slop)))
    (cond ((and h-centered v-centered)
           :centered)
          (h-centered
           (setq pos (point-v pos))
           (if (< win-v-center screen-v-center)
               `(:top ,pos)
               `(:bottom ,(- *screen-height* (+ pos (point-v size))))))
          (v-centered
           (setq pos (point-h pos))
           (if (< win-h-center screen-h-center)
               `(:left ,pos)
               `(:right ,(- *screen-width*
                            (+ pos (point-h size))))))
          (t pos))))
    


#+carbon-compat
(defun grow-gray-rect (anchor float port limit)
  (setq float (add-points float anchor))
  (let* ((old-mouse (view-mouse-position nil))
         (new-mouse old-mouse)
         (offset (subtract-points float old-mouse))
         (delta (add-points offset old-mouse)))
    (when limit
      (setq limit (add-points anchor
                              (make-point limit limit))))
    ;; PORT AINT A PORT - ITSA WINDOW
    (with-port port
      (with-pen-saved
        (RLET ((RECT :RECT))
          (#_GETPORTBOUNDS (#_GETWINDOWPORT PORT) RECT)
          (with-clip-rect rect
            (#_PenMode (position :patxor *pen-modes*))
            (#_PenPat *gray-pattern*)
            (rlet ((rect :rect :topleft anchor
                         :bottomright float)
                   (event :eventRecord))
              (#_frameRect rect)              ;draw the rectangle first time
              ;repeat while the button is down
              (while (mouse-down-p)
                (setq new-mouse (view-mouse-position nil))
                (unless (eq old-mouse new-mouse)  ;has the mouse moved?
                  (#_FrameRect :ptr rect)          ;erase the old rect
                  (setq delta (add-points offset new-mouse))
                  (when limit (setq delta (point-max delta limit)))
                  (#_pt2rect :long anchor
                   :long delta
                   :ptr rect)
                  (#_FrameRect :ptr rect)          ;draw the new rect
                  (setq old-mouse new-mouse))
                (get-next-event event nil 0 1))
              (#_FrameRect :ptr rect)              ;a final erasure
              delta)))))))

#-carbon-compat
(defun grow-gray-rect (anchor float port limit)
  (setq float (add-points float anchor))
  (let* ((old-mouse (view-mouse-position nil))
         (new-mouse old-mouse)
         (offset (subtract-points float old-mouse))
         (delta (add-points offset old-mouse)))
    (when limit
      (setq limit (add-points anchor
                              (make-point limit limit))))
    (with-port port
      (with-pen-saved
        (with-clip-rect (rref port :grafport.portrect)
          (#_PenMode :word (position :patxor *pen-modes*))
          (#_PenPat :ptr *gray-pattern*)
          (rlet ((rect :rect :topleft anchor
                       :bottomright float)
                 (event :eventRecord))
            (#_frameRect :ptr rect)              ;draw the rectangle first time
            ;repeat while the button is down
            (while (mouse-down-p)
              (setq new-mouse (view-mouse-position nil))
              (unless (eq old-mouse new-mouse)  ;has the mouse moved?
                (#_FrameRect :ptr rect)          ;erase the old rect
                (setq delta (add-points offset new-mouse))
                (when limit (setq delta (point-max delta limit)))
                (#_pt2rect :long anchor
                          :long delta
                          :ptr rect)
                (#_FrameRect :ptr rect)          ;draw the new rect
                (setq old-mouse new-mouse))
              (get-next-event event nil 0 1))
            (#_FrameRect :ptr rect)              ;a final erasure
            delta))))))

(defun point-max (point-1 point-2)
    (make-point (max (point-h point-1) (point-h point-2))
                (max (point-v point-1) (point-v point-2))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  a simple font dialog
;;


(defun choose-font-dialog (&optional (font-spec (ccl::sys-font-spec)) ditem ;'("chicago" 0 :plain))
                           &aux the-dialog
                                the-items
                                style-items
                                size-items
                                font-table)
  (setq the-dialog
        (make-instance 'dialog
               :window-type :movable-dialog
               :window-title "Select Font Attributes"
               :view-position '(:top 78)
               :view-size #@(321 228)
               :close-box-p nil
               :window-show nil)
        the-items
        (append (setq style-items (make-style-items))
                (setq size-items (make-size-items))
                (list
                 (make-dialog-item 'ccl::title-box-dialog-item
                              #@(3 130) #@(182 89) "Font Style")
                 (setq font-table
                       (make-dialog-item 'sequence-dialog-item
                                    #@(5 21) #@(178 96) "Untitled" nil
                                    :cell-size #@(162 16)
                                    :table-hscrollp nil
                                    :table-sequence (mapcar #'cadr *font-list*)))
                 (make-dialog-item 'ccl::title-box-dialog-item
                              #@(190 20) #@(120 98) "Font Size")
                 (make-dialog-item 'button-dialog-item
                              #@(229 176) #@(62 16) "OK"
                              #'(lambda (item)
                                  (return-from-modal-dialog
                                   (do-choose-font-ok (view-container item))))
                              :default-button t)
                 (make-dialog-item 'button-dialog-item
                              #@(229 199) #@(62 16) "Cancel"
                        #'(lambda (item)
                            (declare (ignore item))
                            (return-from-modal-dialog nil)))
                 (make-dialog-item 'static-text-dialog-item
                              #@(5 3) #@(56 16) "Font"))))
  (apply #'add-subviews the-dialog the-items)
  (view-put the-dialog 'style-items style-items)
  (view-put the-dialog 'font-table font-table)
  (if (and (osx-p) ditem (typep ditem 'ccl::control-dialog-item)) ;; << maybe
    (dolist (x style-items)
      (if (memq (dialog-item-attribute x) '(:outline :shadow))
        (dialog-item-disable x))))
  (dolist (attr font-spec)
    (cond ((assoc attr *style-alist* :test #'eq)
           (dolist (item style-items)
             (when (eq attr (dialog-item-attribute item))
               (dialog-item-action item))))
          ((typep attr 'fixnum)
           (if (zerop attr) (setq attr 12))
           (dolist (item size-items)
             (when (eq attr (dialog-item-attribute item))
               (dialog-item-action item))))
          ((typep attr 'string)
             (let ((pos (position attr (table-sequence font-table)
                                  :test #'equalp)))
               (when pos
                 (setq pos (make-point 0 pos))
                 (scroll-to-cell font-table pos)
                 (cell-select font-table pos))))))
  (modal-dialog the-dialog))

(defun do-choose-font-ok (the-dialog &aux temp)
  (let ((font-table (view-get the-dialog 'font-table))
        (style-items (view-get the-dialog 'style-items)))
    (list*
     (progn
       (setq temp (car (selected-cells font-table)))
       (if temp
         (cell-contents font-table temp)
         (car (ccl::sys-font-spec)))) ;"Chicago"))
     (dialog-item-attribute (pushed-radio-button the-dialog))
     :srcor
     (progn
       (setq temp ())
       (dolist (item style-items (nreverse temp))
         (when (check-box-checked-p item)
           (push (dialog-item-attribute item) temp)))))))

(defclass style-item (check-box-dialog-item)
  ((attribute :accessor dialog-item-attribute)))

(defmethod initialize-instance :before ((item style-item) &key dialog-item-text)
  (setf (dialog-item-attribute item)
        (find-symbol (string-upcase dialog-item-text) "KEYWORD")))


(defun make-style-items ()
  (flet ((plain-off (item) ; uncheck plain - assumes plain is first
           (let* ((checked (check-box-checked-p item)))
             (when checked
               (check-box-uncheck 
                (car (view-get (view-container item) 'style-items)))))))
    (flet ((extend-off (item)
             (let* ((checked (check-box-checked-p item)))
               (when checked
                 (plain-off item)
                 (check-box-uncheck 
                  (elt (view-get (view-container item) 'style-items) 7)))))
           (condense-off (item)
             (let* ((checked (check-box-checked-p item)))
               (when checked
                 (plain-off item)
                 (check-box-uncheck 
                  (elt (view-get (view-container item) 'style-items) 5))))))      
      
      (list (make-dialog-item
             ; choosing plain turns off all others
             'style-item #@(9 142) #@(72 16) "Plain"
             (item-lambda (item)
               (let* ((checked (check-box-checked-p item))
                      (dialog (view-container item)))
                 (dolist (other-item (view-get dialog 'style-items))
                   (unless (eq item other-item)
                     (if checked
                       (check-box-uncheck other-item)))))))
            ;; choosing anything else turns off plain
            (make-dialog-item 'style-item #@(96 142) #@(72 16) "Outline"
                              #'plain-off)
            (make-dialog-item 'style-item #@(9 160) #@(72 16) "Bold"
                              #'plain-off)
            (make-dialog-item 'style-item #@(96 160) #@(72 16) "Shadow"
                              #'plain-off)
            (make-dialog-item 'style-item #@(9 178) #@(72 16) "Italic"
                              #'plain-off)
            (make-dialog-item 'style-item #@(96 177) #@(84 17) "Condense"
                              #'extend-off)            
            (make-dialog-item 'style-item #@(9 196) #@(81 16) "Underline"
                              #'plain-off)            
            (make-dialog-item 'style-item #@(96 196) #@(72 16) "Extend"
                              #'condense-off)))))


(defclass size-item (radio-button-dialog-item)
  ((attribute :accessor dialog-item-attribute)))

(defmethod initialize-instance :before ((item size-item) &key dialog-item-text)
  (setf (dialog-item-attribute item)
        (read-from-string dialog-item-text)))

(defun make-size-items ()
  (list
   (make-dialog-item 'size-item #@(202 30) #@(34 16) "9")
   (make-dialog-item 'size-item #@(202 51) #@(41 16) "10")
   (make-dialog-item 'size-item #@(202 72) #@(40 16) "12")
   (make-dialog-item 'size-item #@(202 93) #@(41 16) "14")
   (make-dialog-item 'size-item #@(262 30) #@(37 16) "18")
   (make-dialog-item 'size-item #@(262 51) #@(42 16) "24")
   (make-dialog-item 'size-item #@(262 72)  #@(39 16) "36")
   (make-dialog-item 'size-item #@(262 93) #@(39 16) "48")))

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
