; -*- Mode:Lisp; Package:INTERFACE-TOOLS; -*-

;;	Change History (most recent first):
;;  5 5/20/96  akh  content-color
;;  4 2/6/96   akh  change some calls to #_drawchar
;;  4 6/26/95  akh  be more defensive in set-part-color :around  (menu) - it is sometimes confused re %current-menubar-editor
;;  3 3/2/95   slh  :menu-item-style -> :style
;;  (do not edit before this line!!)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  menu-editor.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  the menu editor portion of the interface designer
;;


;;;;;;;;;;;;;;;;;
;;
;; Change history
;;
;; windows are :theme-background t
;; fix method ccl::draw-table-cell-new for arrow and key, 
;;  lose view-draw-contents for table-text-edit, do the job in ccl::frame-key-handler method
;;  add do nothing erase-focus-rect method 
;; ------ 5.2b6
;; use grafport-write-char, draw-string-in-rect, change key-handler-idle for CJK
;; ------ 5.2b5
;; draw-cell-contents ((table menu-editable-table) uses ccl::draw-theme-text-box 
;; --------- 5.1 final
;; update-cell - beware hierarchical menu
;; make update-cell have the change show up - look out for owner nil in initialize-instance :after ((item add-menu-item-menu-item) 
;; -------- 5.0 final
;; some fixes for *use-pop-up-control* true
;; --------- 5.0b3
;; 12/16/01 akh fix editing goof in draw-cell-contents ((table menu-editable-table)
;; 04/03/01 use getportBitMapForCopyBits
;; carbon-compat
;; --------- 4.3.1
;; 01/09/96 bill  eliminate explicit return types in trap calls
;; 12/28/95 slh   object-source-code for menu updated with :menu-title
;;  5/04/95 slh   use tool back color
;;  2/28/95 slh   :menu-item-style -> :style
;;--------------- 3.0d17
;;     ?    alice print menubar source fred-window is scratch-p
;; 09/19/93 alice menu editor does set-pop-up-menu-default-item when pop-up and check-mark is set so
;;                menu and editor are in sync, view-activate-event-handler of menu-editor syncs check-mark with menu
;;------------
;; 11/13/92 alice adding a new menu selects it.
;; 11/07/92 alice added an "Edit Menu" button to menubar editor - a la double click (getting crowded)
;; 11/05/92 alice return-key failed when option-close a bunch of "menu-editors"
;; 11/04/92 alice add pop-up-menus, adding a new menu item selects it (no longer = paste)
;; 11/03/92 bill pseudo-edit-menu-dialog now looks like a windoid, not a :document window.
;; ------------- 2.0
;; 03/23/92 bill function-definition now quotes symbols.
;; 03/19/92 bill function-definition makes a 0-arg function if it can't find source
;; ------------- 2.0f3
;; 11/11/91 alice nuke nfunction
;; 11/06/91 bill *restore-lisp-functions* -> def-load-pointers
;; 07/26/91 bill make editing titles active
;; 01/15/91 bill (method object-source-code (apple-menu)) had leftover object-lisp
;; 08/03/90 bill :parent -> :class
;;


;;;;;;;;;;;;;;;;;
;;
;; packages and symbols and classes
;;

(in-package :interface-tools)

(defvar *menu-scrap* nil)
(defparameter *menu-arrow-bitmap* nil)

(defclass menubar-editor (non-editable-dialog)
  ((current-menu :initform nil :accessor menubar-editor-menu))
  (:default-initargs
   :window-type :document
   :window-title "Menubar Editor"
   ;:back-color *tool-back-color*
   :theme-background t
   ;:content-color *tool-back-color*
   :view-position #@(6 59)
   :view-size #@(345 171)))

(defclass menu-editor (non-editable-dialog)
    ((current-item :initform nil :accessor menu-editor-current-item)
     (edited-menu :initform nil :initarg :menu :accessor menu-editor-edited-menu))
    (:default-initargs
     :view-position #@(186 60)
     :window-type :document
     :theme-background t
     ;:back-color *tool-back-color*
     ;:content-color *tool-back-color*
     :view-size #@(342 233)
     :window-show nil))

(defclass editable-table (sequence-dialog-item)
  ((my-text-editor :initform nil :accessor editable-table-text-editor)
   (edit-text-offset :allocation :class :accessor edit-text-offset)))

(defclass menubar-editable-table (editable-table)
  ((edit-text-offset :allocation :class :initform #@(2 1)))
  (:default-initargs
   :table-print-function #'(lambda (object stream)
                             (format stream (menu-title object)))))

(defclass menu-editable-table (editable-table)
  ((edit-text-offset :allocation :class :initform #@(12 1))))


(defclass table-text-edit (editable-text-dialog-item)
  ((current-cell :initform nil :accessor table-text-edit-current-cell)
   (my-table :initarg :table :initform nil :accessor table-text-edit-table)
   (my-offset :initarg :offset :initform #@(2 1) :accessor table-text-edit-offset)
   (full-size :initarg :full-size :accessor table-text-edit-full-size)
   (small-size :initarg :small-size :accessor table-text-edit-small-size))
  (:default-initargs
   ;:draw-outline nil   ;; unnoticed today
   :dialog-item-text ""
   :allow-returns t
   :view-position #@(0 0)
   :view-nick-name :table-text-edit))

(defclass pseudo-edit-menu-dialog (windoid non-editable-dialog)
  ()
  (:default-initargs
   :window-title "Edit"
   :view-size #@(133 87)))  

(defclass add-menu-item-menu-item (menu-item)
  ((my-class-choice :initarg :class-choice :initform nil :accessor add-menu-item-class-choice)))

(defvar *menubar-list* ())
(defvar %current-menubar-editor nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  patches for menubars, menus and menu-items
;;

(defmethod set-part-color :around ((menubar menubar) part new-color)
  (declare (ignore new-color))
  (call-next-method)
  (when (eq part :default-menu-title)
    (update-menubar-editor)))

(defmethod set-part-color :around ((menu menu) part new-color)
  (declare (ignore part))
  (call-next-method)
  (let* ((editor %current-menubar-editor)
         (pos (position menu (menubar))))
    (when (and editor pos)
      (let ((table  (view-named 'my-table editor)))
        (when (and table (cell-to-index table 0 pos))
          (set-part-color table
                          (make-point 0 pos)
                          new-color))))))

(defvar *menu-editor-hash* (make-hash-table :test 'eq :weak t))

(defun get-menu-editor (menu)
  (gethash menu *menu-editor-hash*))

(defun (setf get-menu-editor) (editor menu)
  (if editor
    (setf (gethash menu *menu-editor-hash*) editor)
    (remhash menu *menu-editor-hash*)))

;;*** this is pessimal, but it works      
(defmethod set-part-color :around ((menu-item menu-item) part new-color)
  (call-next-method)
  (let* ((owner (menu-item-owner menu-item))
         (editor (and owner (get-menu-editor owner))))
    (when (and editor
               (or (eq part :item-title)
                   (eq part :item-key)))
      (let* ((pos (make-point 0
                              (position menu-item (menu-items owner)))))
        (when (eq part :item-title)
          (set-part-color (view-named 'my-menu-table editor)  pos new-color))
        (update-items-for-new-selection editor pos)))))

;;;;;;;;;;;;;;;;
;;
;; global sets of menubars
;;

(defun init-menubar-list (&rest menubars)
  (setq *menubar-list* (rplacd (last menubars) menubars)))

(defun make-spec-from-menubar ()
  (cons (menu-items *apple-menu*)
        (cdr (menubar))))

(progn
  (init-menubar-list (make-spec-from-menubar))
  nil)

(defun rotate-menubars ()
  (update-list-from-menubar)
  (setq *menubar-list* (cdr *menubar-list*))
  (update-menubar-from-list))

(defun add-menubar ()
  (push nil (cdr *menubar-list*))
  (rotate-menubars))

(defun delete-menubar ()
  (setq *menubar-list* (carless-circle *menubar-list*))
  (update-menubar-from-list))

(defun carless-circle (c-list)
   (let ((start c-list))
     (until (eq (cdr c-list)
                start)
       (setq c-list (cdr c-list)))
     (setf (cdr c-list)
           (cddr c-list))))

(defun update-menubar-from-list ()
  (let* ((menubar-spec (car *menubar-list*))
         (apple-items (car menubar-spec))
         (rest-menus (cdr menubar-spec))
         (a-menu *apple-menu*)
         (*menubar-frozen* t))
    (update-list-from-menubar)
    (set-menubar nil)
    (apply #'remove-menu-items a-menu (menu-items a-menu))
    (apply #'add-menu-items a-menu apple-items)
    (set-menubar rest-menus)
    (update-menubar-editor))
  (draw-menubar-if))


(defun update-list-from-menubar ()
  (setf (car *menubar-list*) (make-spec-from-menubar)))

(defun update-menubar-editor ()
  (let ((the-win %current-menubar-editor))
    (when the-win
      (set-table-sequence (view-named 'my-table the-win) (menubar)))))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; used for indicating a heirarchical menu
;;

(def-load-pointers init-menu-arrow-bitmap ()
  (let ((pointer (#_NewPtr :errchk 36)))
    (%put-ptr pointer (%inc-ptr pointer 14))      ;BaseAddr
    (%put-word pointer 2 4)                        ;rowbytes
    (%put-long pointer #@(0 0) 6)                  ;rectangle topleft
    (%put-long pointer #@(16 11) 10)               ;rectangle bottomright
    (%put-word  pointer #b1000000000000000 14)
    (%put-word  pointer #b1100000000000000 16)
    (%put-word  pointer #b1110000000000000 18)
    (%put-word  pointer #b1111000000000000 20)
    (%put-word  pointer #b1111100000000000 22)
    (%put-word  pointer #b1111110000000000 24)
    (%put-word  pointer #b1111100000000000 26)
    (%put-word  pointer #b1111000000000000 28)
    (%put-word  pointer #b1110000000000000 30)
    (%put-word  pointer #b1100000000000000 32)
    (%put-word  pointer #b1000000000000000 34)
    (setq *menu-arrow-bitmap* pointer)))

;;;;;;;;;;;;;;;;;
;;; *table-text-edit*
;;
;; this is the editable-text item which appears on top of a table
;; to give the illusion of editing an element in a table

(defmethod initialize-instance ((item table-text-edit) &key table)
  (unless (typep table 'editable-table)
    (error "A :table of type ~s must be passed to initialize-instance for ~s"
           'editable-table 'table-text-edit))
  (call-next-method)
  (let ((size (view-size item)))
    (setf (table-text-edit-full-size item) size)
    (setf (table-text-edit-small-size item) (subtract-points size #@(23 0)))))

#|
(defmethod view-draw-contents ((item table-text-edit))
  (call-next-method)
  #+ignore
  (let* ((pos (view-position item))
         (size (add-points pos (view-size item))))
    (rlet ((rect :rect
                 :topleft pos
                 :bottomright size))
      (#_InsetRect rect -1 -1)
      (#_FrameRect rect))))
|#

(defmethod ccl::frame-key-handler ((item table-text-edit))
  (let* ((pos (view-position item))
         (size (add-points pos (view-size item))))
    (rlet ((rect :rect
                 :topleft pos
                 :bottomright size))
      (#_InsetRect rect -1 -1)
      (#_FrameRect rect))))

;; sigh
(defmethod ccl::erase-focus-rect ((item table-text-edit))
  )

(defmethod view-corners ((item table-text-edit))
  (multiple-value-call #'inset-corners #@(-1 -1) (call-next-method)))

(defmethod select-all ((item table-text-edit))
  (set-selection-range item 0 (buffer-size (fred-buffer item))))

(defmethod update-position ((item table-text-edit) &optional dont-set-current)
  (let* ((table (table-text-edit-table item))
         (table-bottom (point-v (add-points (view-position table) (view-size table))))
         (cell (table-text-edit-current-cell item))
         (cell-height (and cell (point-v (cell-size table))))
         (position (and cell (cell-position table cell)))
         (window (view-window table)))
    (if (and position (<= (+ (point-v position) cell-height) table-bottom))
      (let ((menu-item (cell-contents table cell)))
        (dialog-item-enable item)
        (set-view-size
         item
         (cond ((command-key menu-item)
                (table-text-edit-small-size item))
               ((typep menu-item 'menu)
                (subtract-points (table-text-edit-full-size item) #@(16 0)))
               (t (table-text-edit-full-size item))))
        (set-view-position item (add-points (table-text-edit-offset item) position))
        (set-view-container item window)
        (unless dont-set-current
          (set-current-key-handler window item)))
      (progn
        (set-view-container item nil)))))

;***also take color?
(defmethod set-link ((item table-text-edit) cell)
  (setf (table-text-edit-current-cell item) cell)
  (when cell
    (let* (text color)
      (let ((table (table-text-edit-table item)))
        (setq text (get-cell-text table cell)
              color (part-color table cell)))
      (set-dialog-item-text item text)
      (set-part-color item :text color)))
  (let ((dialog (view-container (table-text-edit-table item))))
    (unless cell
      (update-items-for-new-selection dialog cell))
    (update-position item)
    (when cell
      (select-all item))
    (when cell
      (update-items-for-new-selection dialog cell))))

(defmethod view-key-event-handler ((item table-text-edit) key)
  (let* ((cell (table-text-edit-current-cell item)))
    (when cell
      (if (char-eolp key)
        (return-key item)
        (flet ((modcnt (item)
                 (and (typep item 'fred-dialog-item)
                      (buffer-modcnt (fred-buffer item)))))
          (let* ((modcnt (modcnt item)))
            (call-next-method)
            (setf (view-get item 'update-cell)
                  (or (null modcnt) (not (eql modcnt (modcnt item)))))))))))

(defmethod key-handler-idle ((item table-text-edit) &optional dialog)
  (declare (ignore dialog))
  (cond 
   ((neq (ccl::get-key-script) #$smRoman)  ;; we usually don't get key-events if typing e.g. Japanese
    (let ((modcnt (view-get item 'update-cell))
          (nowcnt (buffer-modcnt (fred-buffer item))))
      (when (neq modcnt nowcnt)
        (update-cell (table-text-edit-table item)
                     (table-text-edit-current-cell item)
                     (dialog-item-text item))
        (setf (view-get item 'update-cell) nowcnt))))
   (t 
    (when (view-get item 'update-cell)
      (setf (view-get item 'update-cell) nil)
      (update-cell (table-text-edit-table item)
                   (table-text-edit-current-cell item)
                   (dialog-item-text item)))))
  (call-next-method))

(defmethod return-key ((item table-text-edit))
  (let* ((cell (table-text-edit-current-cell item))
         (text (dialog-item-text item))
         (window (view-window item)))
    (update-cell (table-text-edit-table item) cell text)
    (set-link item nil)
    (when window (window-update-event-handler window))))

(defmethod view-click-event-handler ((item table-text-edit) where)
  (declare (ignore where))
  (if (double-click-p)
    (let* ((cell (table-text-edit-current-cell item)))
      (and cell
           (setq cell (cell-contents (table-text-edit-table item) cell))
           (typep cell 'menu)
           (progn (return-key item)
                  (make-instance 'menu-editor :menu cell))))
    (call-next-method)))


;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; editable-table
;;
;; a table whose contents can be edited
;;
;; used as a parent-class for menubar-editable-table and menu-editable-table
;; subclasses must define get-cell-text, and update-cell

(defmethod initialize-instance :after ((table editable-table) &key)
  (let* ((edit-text-offset (edit-text-offset table)))
    (setf (editable-table-text-editor table)
          (make-instance 'table-text-edit
                         :view-size (subtract-points
                                     (cell-size table)
                                     (subtract-points edit-text-offset
                                                      #@(-1 1)))
                         :offset edit-text-offset
                         :table table))))

(defmethod view-click-event-handler ((table editable-table) where)
  (let ((text-editor (editable-table-text-editor table))
        (cell (point-to-cell table where))
        (window (view-window table)))
    (let ((old-editor-cell (table-text-edit-current-cell text-editor)))
      (if (not (eql old-editor-cell cell))
        (set-link text-editor nil)))
    (if cell
      (set-link text-editor cell)
      (progn
        (call-next-method)
        (update-position text-editor t)))
    (when (view-container text-editor)
      (view-focus-and-draw-contents text-editor)
      (validate-view text-editor))
    (window-update-event-handler window)))

(defmethod set-table-sequence ((table editable-table) new-sequence)
  (let ((old-v (point-v (scroll-position table))))
    (without-interrupts
     (call-next-method)
     (when (and (<= old-v (length new-sequence))
                (neq old-v (point-v (scroll-position table))))
       (scroll-to-cell table 0 old-v))
     (let ((text-editor (editable-table-text-editor table)))
     (when text-editor
       (set-link text-editor nil))))))

(defmethod set-part-color ((table editable-table) part new-color)
  (let ((text-editor (editable-table-text-editor table)))
    (when text-editor
      (when (eq part (table-text-edit-current-cell text-editor))
        (set-part-color text-editor :text new-color)))
    (call-next-method)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; menubar-editable-table
;;
;; an editable table designed to display a menubar
;;

(defmethod get-cell-text ((table menubar-editable-table) cell)
  (menu-title (cell-contents table cell)))

(defmethod update-cell ((table menubar-editable-table) cell text)
  (set-menu-title (cell-contents table cell) text))

(defmethod set-table-sequence ((table menubar-editable-table) new-sequence)
  (without-interrupts
   (call-next-method)
   (let ((default-color (part-color  *menubar* :default-menu-title)))
     (do* ((menu (pop new-sequence) (pop new-sequence))
           (cell #@(0 0) (add-points cell #@(0 1))))
          ((not menu))
       (set-part-color table
                       cell
                       (or (part-color (cell-contents table cell) :menu-title)
                           default-color))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; menu-editable-table
;;
;; an editable table designed to display menus
;;
(defmethod get-cell-text ((table menu-editable-table) cell)
  (menu-item-title (cell-contents table cell)))

(defmethod update-cell ((table menu-editable-table) cell text)
  (let ((item (cell-contents table cell)))
    (set-menu-item-title item text)
    (let ((owner (menu-item-owner item)))
      (when owner ; it may have been cut
        (update-menu-size owner)
        (menu-update owner)
        (when (typep owner 'pop-up-menu)(invalidate-view owner))))))

(defmethod set-table-sequence ((table menu-editable-table) new-sequence)
  (without-interrupts
   (call-next-method)
   (do* ((item (pop new-sequence) (pop new-sequence))
         (cell #@(0 0) (add-points cell #@(0 1))))
        ((not item))
     (set-part-color table
                     cell
                     (part-color-with-default (cell-contents table cell) :menu-item-title)))))


(defmethod ccl::draw-table-cell-new ((table menu-editable-table) h v rect selected-p)
  (let* ((item (cell-contents table h v))
         (wptr (wptr table))
         (desc (nth-value 1 (multiple-value-call #'font-codes-info (view-font-codes table))))
         (mark (menu-item-check-mark item))
         (title (menu-item-title item))
         (key (or (command-key item) (typep item 'menu)))
         mark-color title-color key-color)     
    (setq title-color (part-color-with-default item :item-title))    
    (when mark
      (setq mark-color (part-color-with-default item :item-mark))
      (#_moveto (pref rect :rect.left)(- (pref rect :rect.bottom) desc))
      (with-fore-color mark-color
        (grafport-write-char (code-char #x2713)))) ;;  #\3
    (#_offsetrect rect 11 0)   ;; was 10
    (with-fore-color title-color
      (draw-string-in-rect title rect))
    (#_offsetrect rect -11 0) ;; was 10
    (when key
      (setq key-color (part-color-with-default item :item-key))
      (with-fore-color key-color
        (if (eq key t)
          (rlet ((arrow-rect :rect :top (+ (pref rect :rect.top) 2) :left (- (pref rect :rect.right) 15)
                             :bottom (- (pref rect :rect.bottom) 3) :right (pref rect :rect.right)))              
            (with-macptrs ((portbits (#_getportBitMapForCopyBits (#_getwindowport wptr))))
              (#_CopyBits *menu-arrow-bitmap*
               portbits
               (%inc-ptr *menu-arrow-bitmap* 6)
               arrow-rect
               0
               (%null-ptr))))                  
          (progn  ;;is this good enuf
            (#_moveto (- (pref rect :rect.right) 26) (- (pref rect :rect.bottom) desc)) 
            ;(grafport-write-char (code-char #x2723)) ;; what should this be ?
            (#_drawchar #\commandmark)
            (grafport-write-char  key)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; add-menu-item-menu-items
;;

(defmethod initialize-instance :after ((item add-menu-item-menu-item) &key)
  (set-menu-item-title item (string-downcase (add-menu-item-class-choice item)))
  (when (menu-item-owner item)
    (menu-update (menu-item-owner item))))

(defmethod menu-item-action ((item add-menu-item-menu-item))
  (let* ((new (make-instance (add-menu-item-class-choice item)
                                      :menu-item-title "Untitled")))    
    (add-a-menu-item (front-window) new)))

(defvar *editable-menu-item-classes* ())

(defun add-editable-menu-item (class-or-name)
  (let* ((class (if (symbolp class-or-name) 
                  (find-class class-or-name)
                  class-or-name))
         (class-name (class-name class))
         (proto (class-prototype class)))
    (unless (or (typep proto 'menu-item)
                (typep proto 'menu))
      (error "~s does not name a subclass of menu or menu-item" class-or-name))
    (let ((classes *editable-menu-item-classes*))
      (unless (memq class-name classes)
        (setq *editable-menu-item-classes*
              (nconc classes (list class-name)))))))

(add-editable-menu-item 'menu-item)
(add-editable-menu-item 'menu)
(add-editable-menu-item 'window-menu-item)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; menubar editor
;;

(defmethod update-items-for-new-selection ((editor menubar-editor) cell)
  (setf (menubar-editor-menu editor)
        (if cell
          (cell-contents (view-named 'my-table editor) cell)))
  (if cell (dialog-item-enable (view-named 'edit-menu editor))
      (dialog-item-disable (view-named 'edit-menu editor))))

(defmethod initialize-instance :after ((editor menubar-editor) &key menubar)
  (add-subviews
   editor
   (make-dialog-item 'menubar-editable-table
                     #@(10 5) #@(150 133) "" nil
                     :cell-size #@(134 16)
                     :table-hscrollp nil
                     :table-vscrollp t
                     :table-sequence (or menubar (menubar))
                     :view-nick-name 'my-table)
   (make-dialog-item 'button-dialog-item
                     #@(9 145) #@(153 16) "Print Menubar Source"
                     #'(lambda (item)
                         (declare (ignore item))
                         (let* ((*print-length* nil)
                                (*print-level* nil)
                                (*print-array* t)
                                (*print-pretty* t)
                                (win (make-instance 'fred-window :scratch-p t))
                                (menus (menubar)))
                           (with-cursor *watch-cursor*
                             (format win "~s"
                                     `(progn ,(object-source-code (pop menus))
                                             (set-menubar (list ,@(mapcar
                                                                   #'(lambda (menu)
                                                                       (object-source-code menu))
                                                                   menus)))))
                             (fred-update win)))))
   (make-dialog-item 'button-dialog-item
                     #@(178 3) #@(153 16) "Add Menu"
                     #'(lambda (item)
                         (add-a-menu (front-window)
                                     (make-instance 'menu :menu-title "Untitled")
                                     (menubar-editor-menu (view-container item)))))
   (make-dialog-item 'button-dialog-item
                     #@(178 23) #@(153 16) "Edit Menu"
                        #'(lambda (item)                            
                            (let* ((editor (view-container item))
                                   (menu (menubar-editor-menu editor))
                                   (table (editable-table-text-editor 
                                           (view-named 'my-table editor))))
                              (when menu                                     
                                (return-key table)  ; unselects
                                (make-instance 'menu-editor :menu menu))))
                        :dialog-item-enabled-p nil
                        :view-nick-name 'edit-menu)
   (make-dialog-item 'title-box-dialog-item
                     #@(173 45) #@(164 117) "Menubar Operations" nil)
   (make-dialog-item 'button-dialog-item
                     #@(177 60) #@(153 16) "Rotate Menubars"
                     #'(lambda (item)
                         (declare (ignore item))
                         (rotate-menubars)))
   (make-dialog-item 'button-dialog-item
                     #@(177 82) #@(153 16) "Add New Menubar"
                     #'(lambda (item)
                         (declare (ignore item))
                         (add-menubar)))
   (make-dialog-item 'button-dialog-item
                     #@(177 104) #@(153 16) "Delete Menubar"
                     #'(lambda (item)
                         (declare (ignore item))
                         (delete-menubar)))
   (make-dialog-item 'color-part-pop-up
                     #@(177 130) #@(147 21) "Menubar Colors" nil
                     :colored-object *menubar*
                     :part-codes '(:default-menu-title
                                   :default-menu-background
                                   :default-item-title
                                   :menubar))))

(defmethod window-close :before ((editor menubar-editor))
  (map-windows #'(lambda (w) (window-close w)) :class 'pseudo-edit-menu-dialog)
  (setq %current-menubar-editor nil))

(defun edit-menubar ()
  (let* ((old-ed %current-menubar-editor)
         (old-pseudo (car (windows :class 'pseudo-edit-menu-dialog
                                   :include-invisibles t
                                   :include-windoids t))))
    (if old-ed
        (window-select old-ed)
        (setq %current-menubar-editor
              (setq old-ed (make-instance 'menubar-editor :menubar (menubar)))))
    (if old-pseudo
      (window-select old-pseudo)
      (let ((old-ed-pos (view-position old-ed))
            (old-ed-width (point-h (view-size old-ed))))
          (setq old-pseudo
                (make-instance 'pseudo-edit-menu-dialog
                               :view-position
                               (add-points old-ed-pos
                                           (make-point (+ 10 old-ed-width)
                                                       0))))))))


(defun add-a-menu (editor menu after)
  (insert-menu menu after)
  (update-menubar-editor)
  (let* ((table (view-named 'my-table editor))
         (table-editor (editable-table-text-editor table))
         (cell (make-point 0 (position menu (menubar)))))
    (scroll-to-cell table cell)  ; gotta do this first
    (set-link table-editor cell) 
    (update-items-for-new-selection editor cell)))

(defun insert-menu (menu after)
  (let ((menus (memq after (menubar)))
        (*menubar-frozen* t))
    (declare (special *menubar-frozen*))
    (dolist (1menu menus)
      (menu-deinstall 1menu))
    (menu-install menu)
    (dolist (1menu menus)
      (menu-install 1menu)))
  (draw-menubar-if))

(defmethod cut ((editor menubar-editor))
  (let* ((menu (menubar-editor-menu editor)))
    (when menu
      (setq *menu-scrap* menu)
      (menu-deinstall menu)
      (update-menubar-editor))))

(defmethod copy ((editor menubar-editor))
  (let* ((menu (menubar-editor-menu editor)))
    (when menu
      (setq *menu-scrap* (copy-instance menu)))))

(defmethod paste ((editor menubar-editor))
  (let* ((new-menu *menu-scrap*)
         (before-menu (menubar-editor-menu editor)))
    (when (typep new-menu 'menu)
      (insert-menu new-menu before-menu)
      (update-menubar-editor))))

(defmethod clear ((editor menubar-editor))
  (let* ((menu (menubar-editor-menu editor)))
    (when menu
      (menu-deinstall menu)
      (update-menubar-editor))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; menu-editor
;;

(defmethod menu-editor-title ((menu pop-up-menu))
  (let ((opt (menu-title menu)))  ; actually dialog-item-text!!!
    (concatenate 'string
                 (if (and (stringp opt) (neq (length opt) 0))
                   opt
                   (progn (setq opt (pop-up-menu-item-display menu))
                          (if (stringp opt) opt (string opt))))
                 " Menu")))

(defmethod menu-editor-title ((menu menu))
  (concatenate 'string (menu-title menu) " Menu"))

(defmethod initialize-instance :after ((editor menu-editor) &key menu &aux pop-up)
  (setf (get-menu-editor menu) editor)
  (setq pop-up (typep menu 'pop-up-menu))
  ; or use dialog-item-text if any ? which is displayed to left of popup
  ; FOr pop-ups the menu-title slot is not used - except you can set its colors???
  (set-window-title editor (menu-editor-title menu))
  (apply 
   #'add-subviews
   editor   
   `(,(make-dialog-item 'menu-editable-table
                     #@(8 25) #@(155 179) "" nil
                     :table-sequence (menu-items menu)
                     :cell-size #@(139 16)
                     :table-hscrollp nil
                     :table-vscrollp t
                     :view-nick-name 'my-menu-table)
   ,(make-dialog-item 'button-dialog-item
                     #@(7 209) #@(158 16) "Print Menu Source"
                     #'(lambda (item)
                         (let ((container (view-container item)))
                           (pprint-item-source (menu-editor-edited-menu container)))))
   ,(make-dialog-item 'pop-up-menu
                     (make-point 173 (if pop-up 4 24)) #@(160 20) nil nil
                     :item-display (if *use-pop-up-control* :selection "Add Menu Item")
                     :menu-items
                     (mapcar #'(lambda (class-sym)
                                 (make-instance 'add-menu-item-menu-item
                                                :class-choice class-sym))
                             *editable-menu-item-classes*))
   ,(make-dialog-item 'check-box-dialog-item
                     #@(172 89) #@(76 16) "Disabled"
                     #'(lambda (item)
                         (let* ((container (view-container item))
                                (current-item (menu-editor-current-item container)))
                           (when current-item
                             (if (check-box-checked-p item)
                               (menu-item-disable current-item)
                               (menu-item-enable current-item)))))
                     :view-nick-name 'my-disabled-check-box)   
   ,(make-dialog-item 'check-box-dialog-item
                     #@(172 109) #@(100 16) "Check Mark"
                     #'(lambda (item)
                         (let* ((container (view-container item))
                                (current-item (menu-editor-current-item container)))
                           (when current-item
                             (let* ((checked-p (check-box-checked-p item)))
                               (cond ((and checked-p pop-up (pop-up-menu-auto-update-default menu))
                                      (let ((old (pop-up-menu-default-item menu)))
                                        (when (and old (neq old 0))
                                          (invalidate-view (view-named 'my-menu-table container))))                                          
                                      (set-pop-up-menu-default-item
                                       menu 
                                       (1+ (position current-item (menu-items menu))))
                                      (invalidate-view menu))
                                     (t (set-menu-item-check-mark current-item checked-p))))
                             (invalidate-selected-table-cell container :left))))
                     :view-nick-name 'my-checked-check-box)
   ,(make-dialog-item 'static-text-dialog-item
                     #@(8 5) #@(89 16) "Menu Items:" nil)
   
   ,(make-dialog-item 'button-dialog-item
                     #@(173 132) #@(160 16) "Menu Item Action"
                     #'(lambda (item)
                         (let ((container (view-container item)))
                           (new-action-from-dialog (menu-editor-current-item container))))
                     :view-nick-name 'my-action-button)
   ,(make-dialog-item 'title-box-dialog-item
                     #@(173 162) #@(162 63) "Colors" nil)
   ,(make-dialog-item 'color-part-pop-up
                     #@(176 171) #@(155 19) (if *use-pop-up-control* "" "Menu Colors") nil
                     :colored-object menu
                     :part-codes '(:menu-title
                                   :menu-background
                                   :default-item-title))
   ,(make-dialog-item 'color-part-pop-up
                     #@(176 196) #@(155 20) (if *use-pop-up-control* "" "Menu Item Colors") nil
                     :view-nick-name 'my-item-color-menu
                     :colored-object nil
                     :part-codes '(:item-title
                                   :item-key
                                   :item-mark))
  ,@(when (not pop-up) ; really doesn't apply to submenus of pop-up either
    (list
     (make-dialog-item 'static-text-dialog-item
                     #@(173 69) #@(100 16) "Command Key:" nil
                     :view-nick-name 'my-command-item-title)
     (make-dialog-item 'one-char-box
                       #@(277 70) #@(18 16) ""
                       #'(lambda (item)
                           (let* ((container (view-container item))
                                  (current-item (menu-editor-current-item container))
                                  (string (dialog-item-text item))
                                  (new-char (if (> (length string) 0)
                                              (char string 0)
                                              nil)))
                             (when current-item
                               (set-command-key current-item new-char)
                               (invalidate-selected-table-cell container :right))))
                       :view-nick-name 'my-char-box
                       :allow-returns nil)))    
  ,@(when pop-up
    (list
     (make-dialog-item 'button-dialog-item
                       #@(173 28) #@(160 16)
                       "Item Display"
                       #'(lambda (item)
                           (declare (ignore item))
                           (let ((str (pop-up-menu-item-display menu)))
                             (when (symbolp str)
                               (setq str (concatenate 'string ":" (symbol-name str))))
                             (setq str (get-string-from-user "Item Display" 
                                                             :initial-string str
                                                             :allow-empty-strings t))                             
                             (when (and str (> (length str) 0)(eq (schar str 0) #\:))
                               (setq str (intern (string-upcase (ccl::%substr str 1 (length str)))
                                                 (find-package :keyword))))
                             (setf (pop-up-menu-item-display menu) str)
                             (set-view-size menu (view-default-size menu))
                             (set-window-title editor (menu-editor-title menu)))))
     (make-dialog-item 'button-dialog-item
                       #@(173 48) #@(160 16)
                       "Menu Title"
                       #'(lambda (item)
                           (declare (ignore item))
                           (let ((str (menu-title menu)))                             
                             (setq str (get-string-from-user "Menu Title" 
                                                             :initial-string str
                                                             :allow-empty-strings t))
                             (set-menu-title menu str)
                             (set-view-size menu (view-default-size menu))
                             (set-window-title editor (menu-editor-title menu)))))     
     (make-dialog-item 'check-box-dialog-item
                       #@(172 68) (make-point 150 (if (ccl::osx-p) 18 16))  ;; well not really either
                       "Auto Update Default"
                       #'(lambda (item)
                           (setf  (pop-up-menu-auto-update-default menu)
                                  (check-box-checked-p item)))
                       :check-box-checked-p t)))))
  
  (update-items-for-new-selection editor nil)
  (window-show editor))


(defmethod invalidate-selected-table-cell ((window menu-editor) &optional part)
  (let* ((table (view-named 'my-menu-table window))
         (editor (editable-table-text-editor table)))
    (when (view-container editor)
      (let* ((pos (view-position editor))
             (size (view-size editor))
             (left (point-h (view-position table)))
             (right (+ left (point-h (view-size table))))
             (top (point-v pos))
             (bottom (+ top (point-v size))))
        (cond ((null part))
              ((eq part :left)
               (setq right (- (point-h pos) 1)))
              ((eq part :right)
               (setq left (+ (point-h pos) (point-h size) 2))))
        (if (or (null part) (eq part :left))
          (update-position editor t))
        (invalidate-corners window (make-point left top) (make-point right bottom))))))

(defmethod window-close :before ((editor menu-editor))
  (return-key editor)
  (setf (get-menu-editor (menu-editor-edited-menu editor)) nil))

(defmethod return-key ((editor menu-editor))
  (let ((my-table (view-named 'my-menu-table editor)))
    (when my-table
      (let ((text-edit (editable-table-text-editor my-table)))
        (when (and text-edit (view-container text-edit))
          (return-key text-edit))))))

(defmethod view-activate-event-handler ((editor menu-editor))
  (call-next-method)
  (let* ((table (view-named 'my-menu-table editor))
         (cell (table-text-edit-current-cell (editable-table-text-editor table))))
    (if cell
      (let* ((checked-box (view-named 'my-checked-check-box editor))
             (item (cell-contents table cell))
             (check-mark (menu-item-check-mark item)))
        (if check-mark
          (check-box-check checked-box)
          (check-box-uncheck checked-box))
        (update-items-for-new-selection editor cell))
      (update-items-for-new-selection editor nil)))      
  ;(invalidate-view editor)
  ) 

(defmethod update-items-for-new-selection ((editor menu-editor) item)  
  (let* ((disabled-check-box (view-named 'my-disabled-check-box editor))
         (char-box (view-named 'my-char-box editor))
         (action-button (view-named 'my-action-button editor))
         (item-color-menu (view-named 'my-item-color-menu editor))
         (checked-box (view-named 'my-checked-check-box editor))
         (command-item-title (view-named 'my-command-item-title editor))
         (table (view-named 'my-menu-table editor)))    
    (if item
      (let* (enabled com-char com-char-color check-mark)        
        (setq item (cell-contents table item))
        (setf (menu-editor-current-item editor) item)
        (setq enabled (menu-item-enabled-p item)
              com-char (command-key item)
              com-char-color (part-color-with-default item :item-key)
              check-mark (menu-item-check-mark item))
        (dialog-item-enable disabled-check-box)
        (if enabled
          (check-box-uncheck disabled-check-box)
          (check-box-check disabled-check-box))
        (when char-box
          (if (not (typep item 'menu))
            (progn
              (dialog-item-enable char-box)
              (set-dialog-item-text char-box (if com-char
                                               (string com-char)
                                               ""))
              (set-part-color char-box :text com-char-color)
              (dialog-item-enable command-item-title))
            (progn (dialog-item-disable char-box)                   
                   (dialog-item-disable command-item-title))))
        (if (typep item 'menu)
          (progn (dialog-item-disable action-button)
                 (dialog-item-disable checked-box))
          (progn (dialog-item-enable action-button)
                 (dialog-item-enable checked-box)))
        (menu-enable item-color-menu)
        (set-colored-object item-color-menu item)
        (if check-mark
          (check-box-check checked-box)
          (check-box-uncheck checked-box)))
      (progn
        (setf (menu-editor-current-item editor) nil)
        (check-box-uncheck disabled-check-box)
        (dialog-item-disable disabled-check-box)
        (when char-box
          (set-dialog-item-text char-box "")
          (dialog-item-disable char-box)
          (dialog-item-disable command-item-title))
        (check-box-uncheck checked-box)
        (dialog-item-disable checked-box)        
        (dialog-item-disable action-button)
        (menu-disable item-color-menu)))))

(defmethod new-action-from-dialog ((item menu-item))
  (let ((*save-definitions* t))
    (setf (menu-item-action-function item)
           (eval (read-from-string
                  (get-text-from-user
                   "Please enter text for the menu-item-action:"
                   (menu-item-action-source item)))))))

(defmethod menu-item-action-source ((item menu-item) &aux old-fun)
  (let* ((*print-pretty* t))
    (format nil
            "(function  ~a)"
            (let ((f (menu-item-action-function item)))
              (if f
                (or (and (setq old-fun (uncompile-function f))
                         (format nil "~s" old-fun))
                    "(lambda ()
;The previous source code for the action could not be found.
;Perhaps the code for the menu was loaded from a fasl file,
;or was compiled with *SAVE-DEFINITIONS* bound to nil
)")
                "(lambda ()
;Enter action source code here.
)")))))

(defmethod new-action-from-dialog ((item window-menu-item))
  (let* ((old-action-symbol (menu-item-action-function item)))
    (setf (menu-item-action-function item)
          (read-from-string
           (get-string-from-user "Please enter the name of a window function to be called when this menu-item is selected."
                                 :initial-string (format nil "~s" old-action-symbol)
                                 :size #@(350 90))
           nil))))

 
(defmethod cut ((editor menu-editor))
  (let* ((item (menu-editor-current-item editor))
         (menu (menu-editor-edited-menu editor)))
    (if item
        (progn
          (setq *menu-scrap* item)
          (remove-a-menu-item menu item)
          (set-table-sequence (view-named 'my-menu-table editor) (menu-items menu)))
        (progn
          (ed-beep)
          (message-dialog "There is no selected menu-item to cut.")))))

(defmethod copy ((editor menu-editor))
  (let* ((item (menu-editor-current-item editor)))
    (if item
        (setq *menu-scrap* (copy-instance item))
        (progn
          (ed-beep)
          (message-dialog "There is no selected menu-item to copy.")))))

(defmethod paste ((editor menu-editor))
  (let* ((item *menu-scrap*)
         (menu (menu-editor-edited-menu editor))
         (before-item (menu-editor-current-item editor)))
    (cond ((not item)
           (ed-beep)
           (message-dialog "No menu-item has been copied or cut."))
          (t           
           (insert-menu-item menu item before-item)           
           (set-table-sequence (view-named 'my-menu-table editor) (menu-items menu))
           (setq *menu-scrap* (copy-instance item))
           ))))

(defmethod add-a-menu-item ((editor menu-editor) item)
  (let* ((menu (menu-editor-edited-menu editor))
         (before-item (menu-editor-current-item editor)))    
    (insert-menu-item menu item before-item)
    (let* ((table (view-named 'my-menu-table editor))
           (table-editor (editable-table-text-editor table)))
      (set-table-sequence table (menu-items menu))
      ; makes him be selected so we can type his title
      (let ((cell (index-to-cell table (position item (menu-items menu)))))
        (scroll-to-cell table cell)
        (set-link table-editor cell)      
      ))))

(defmethod insert-menu-item ((menu menu) item before-what)
  (let ((m-items (memq before-what (menu-items menu))))
    (apply #'remove-menu-items menu  m-items)
    (apply #'add-menu-items menu item m-items)))

(defmethod insert-menu-item ((menu pop-up-menu) item before-what)
  (declare (ignore item before-what))
  (call-next-method)
  ; ?? - this means the user can only set a non standard size after
  ; all the menu items are added
  ; and how bout when you change an item title  
  (set-view-size menu (view-default-size menu)))

;; added these - for attempt to add a menu to a pop-up-menu - ugh
(defmethod menu-item-icon-handle ((menu menu)) nil)
(defmethod menu-item-icon-num ((menu menu)) nil)

(defmethod remove-a-menu-item ((menu menu) item)
  (remove-menu-items menu item)
  (update-menu-size menu))

(defmethod update-menu-size ((menu menu))
  (declare (ignore menu)))

(defmethod update-menu-size ((menu pop-up-menu))
  (set-view-size menu (view-default-size menu)))

(defmethod clear ((editor menu-editor))
  (let* ((item (menu-editor-current-item editor))
         (menu (menu-editor-edited-menu editor)))
    (if item
        (progn
          (remove-a-menu-item menu item)
          (set-table-sequence (view-named 'my-menu-table editor) (menu-items menu)))
        (progn
          (ed-beep)
          (message-dialog "There is no selected menu-item to clear.")))))


;;;;;;;;;;;;;;;;;;;
;;
;; cut/copy/paste/clear dialog
;;

(defmethod initialize-instance :after ((dialog pseudo-edit-menu-dialog) &key)
  (add-subviews
   dialog
   (make-dialog-item 'button-dialog-item
                     #@(4 4)  #@(125 16) "Cut"
                     #'(lambda (item)
                         (declare (ignore item))
                         (cut (front-window))))
   (make-dialog-item 'button-dialog-item
                     #@(4 25) #@(125 16) "Copy"
                     #'(lambda (item)
                         (declare (ignore item))
                         (copy (front-window))))
   (make-dialog-item 'button-dialog-item
                     #@(4 45) #@(125 16) "Paste"
                     #'(lambda (item)
                         (declare (ignore item))
                         (paste (front-window))))
   (make-dialog-item 'button-dialog-item
                     #@(4 66) #@(125 16) "Clear"
                     #'(lambda (item)
                         (declare (ignore item))
                         (clear (front-window))))))



;;;;;;;;;;;;;;;;;;;;
;;
;; source code printing for menus and menu-items
;;

(defmethod object-source-code ((object t))
  `(make-instance ',(class-name (class-of object))))

(defmethod object-source-code ((menu menu))
  (let* ((colors (part-color-list menu))
         (items `(list ,@(mapcar #'(lambda (item)
                                     (object-source-code item))
                                 (menu-items menu)))))
    (nconc (call-next-method)
           `(
             :menu-title ,(menu-title menu)
             :menu-items ,items
             ,@(if colors
                 `(:menu-colors ',colors))
             ))))

(defmethod object-source-code ((menu apple-menu))
  `(let ((apple-menu *apple-menu*))
     (apply #'remove-menu-items apple-menu (menu-items apple-menu))
     (apply #'add-menu-items
            apple-menu
            (list ,@(mapcar #'(lambda (item)
                                (object-source-code item))
                            (menu-items menu))))))

(defun function-definition (f)
  (cond ((null f) nil)
        ((symbolp f) `',f)
        ((functionp f)
         (let ((name (function-name f)))
           (if (and (symbolp name) (fboundp name) (eq f (symbol-function name)))
             `',name
             (let ((def (uncompile-function f)))
               (if def
                 `(function ,def)
                 '(function (lambda () "Can't find definition")))))))))

(defmethod object-source-code ((item menu-item) &aux value)
  `(make-instance ',(class-name (class-of item))
                  :menu-item-title ,(menu-item-title item)
                  ,@(if (setq value (part-color-list item))
                      `(:menu-item-colors ',value))
                  ,@(if (setq value (function-definition (menu-item-action-function item)))
                      `(:menu-item-action ,value))
                  ,@(if (menu-item-enabled-p item)
                      ()
                      `(:disabled t))
                  ,@(if (setq value (command-key item))
                      `(:command-key ,value)
                      ())
                  ,@(if (neq (setq value (menu-item-style item)) :plain)
                      `(:style ',value)
                      ())
                  ,@(if (setq value (menu-item-check-mark item))
                      `(:menu-item-checked ,value)
                      ())))

(defmethod object-source-code ((item window-menu-item))
  (let* ((source (call-next-method))
         (f (function-definition (menu-item-action-function item))))
    (remf source :menu-item-action)
    (nconc source `(:menu-item-action ,f))))

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
