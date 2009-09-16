;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: apropos-dialog.lisp,v $
;;  Revision 1.13  2004/12/20 22:06:12  alice
;;  ; 12/10/04 eol stuff
;;
;;  Revision 1.12  2004/08/01 00:13:54  alice
;;  ; add view-minimum-size
;;
;;  Revision 1.11  2004/07/08 22:17:43  alice
;;  ; lose :content-color
;;
;;  Revision 1.10  2004/06/30 19:35:21  alice
;;  ; only do remembered view-size if creating new dialog. Set-view-size focuses thank you.
;;
;;  Revision 1.9  2004/06/20 23:01:27  alice
;;  ; undo default-button kludge - default-button in subview fixed now
;;
;;  Revision 1.8  2004/06/02 04:23:11  alice
;;  ; ignore-errors around window-package
;;
;;  Revision 1.7  2004/06/01 22:52:08  alice
;;  ; ignore-errors around window-package
;;
;;  Revision 1.6  2004/04/26 04:07:32  alice
;;  ;; don't error if  initargs-for-class is T
;;
;;  Revision 1.5  2003/12/08 08:00:53  gtbyers
;;  Look at CLASS-MAKE-INSTANCE-INITARGS.
;;
;;  6 9/4/96   akh  fix some size thing for new dialog size
;;  5 7/30/96  akh  added "external symbols only" checkbox
;;  4 7/26/96  akh  fixes for removed specifiers and qualifier popups
;;  3 7/18/96  akh  lose specializers and qualifier  pop-up
;;  2 6/7/96   akh  content-color
;;  8 5/15/95  akh  disable specializers and qualifier when not applicable
;;  6 5/8/95   akh  fix the package default business
;;  5 5/7/95   slh  balloon help mods.
;;  5 3/2/95   akh  *tool-back-color*, *tool-line-color*
;;  3 1/25/95  akh  left border-view more colorful
;;  (do not edit before this line!!)

; apropos-dialog.lisp
; Copyright 1987-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2001 Digitool, Inc.

; Modification History
;
; 12/10/04 eol stuff
; ------- 5.1 final
; add view-minimum-size
; lose :content-color
; only do remembered view-size if creating new dialog. Set-view-size focuses thank you.
; undo default-button kludge - default-button in subview fixed now
; ignore-errors around window-package - screw cvs
;; ------- 5.1b2
;; don't error if  initargs-for-class is T
; ----- 5.1b1
; apropos-dialog terminates selection at newline if any
; -------- 4.4b5
; move the default button to contained in window so it can throb and pulsate on OSX 
; -------- 4.4b4
; if osx use stripy themebrush (ugh)
; lose :view-font "chicago" - let it default to sys-font
; 05/17/01 buttons wider if osx
; 05/15/01 deal with osx terminal brain damage re default button - so there is no default button if osx
; initargs scrolls window to 0 
; use *apropos-types* when creating dialog
; --------- 4.3.1b1
; 12/24/99 akh shift the and/or menu left a little in case platinum pop-up
; 08/24/99 akh add initargs button - active when class
; 07/19/99 akh do-apropos - copy-list before sort
; ---------- 4.3f1c1
; 07/07/98 akh get package if any out of selected string
; 05/07/97 bill Specify a true value of :table-vscrollp for the arrow-dialog-item
; ------------- 4.1
; 01/27/97 bill Update (method set-view-size (apropos-dialog t)) for new
;               table-dialog-item implementation.
; 11/26/96 bill If (window-package (front-window)) is NIL, apropos-dialog
;               now uses the current *package* instead of the default for
;               the pop-up menu.
; ------------  4.0
; 9/26/96 slh   apropos-dialog-patch: update Package popup when clicked
; 5/02/95 slh   (copy of) vertical-labeled-item here - put in own file someday
;------------
; nuke *apropos-type-titles*
; do-subviews is porky - use do-vector
; add update-default-button method so cut etal will dtrt, nuke view-default-font method
; nuke window-can-do-operation method and *apropos-dialog*, dont need to cell-deselect and select
;------------
;02/12/93 alice lots of changes, the actual dialog is in ccl-menus
;01/07/92 gb   don't require RECORDS.
;------------- 2.0b4
;11/13/91 bill  help-spec's
;09/20/91 alice no more string-upcase
;------------- 2.0b3
;08/24/91 gb   use new trap syntax.
;07/26/91 alice window-can-do-operation
;06/29/91 alice disable default-button if text is empty, do arrows and select first
;--------- 2.0b2
;04/15/91 bill double-clicking on whitespace in apropos-dialog no longer
;              causes an error.
;02/27/91 bill set-cell-size needed to preserve the cell height.
;02/04/91 bill  Remove eval-enqueue from apropos-search (apropos-list now considered
;               fast enuf).
;01/21/91 alice use eval-enqueue in apropos-search
;------- 2.0a5
;11/09/90 bill *apropos-dialog-size&position*
;11/02/90 bill view-default-font for apropos-dialog: inherit it in the sequence-dialog-item
;06/25/90 bill :view-text -> :dialog-item-text
;05/24/90 bill window-click-event-handler -> view-click-event-handler
;              window-position -> view-position, window-size -> view-size
;05/02/90 bill :dialog-item-position -> :view-position
;04/10/90 gz  dialog-item-font -> view-font
;02/02/90 bill New dialogs.
;09/16/89 bill Removed the last vestiges of object-lisp windows.
; 09/01/89 bill Converted to CLOS
; 08/24/89 gz  use first-selected-cell when appropriate.
; 07/28/89 bill "dialog" => "dialog-object"
; 07/28/89 bill my-dialog => (objvar my-dialog)
;19-Apr-89 as *button-dialog-item* -> *default-button-dialog-item*
; 3/18/89  gz window-foo -> window-object-foo.
; 6/27/88 jaj added :table-print-function #'prin1
; 5/26/88 jaj fixed mis-parenthesization in apropos-dialog
; 5/13/88 jaj disable inspect button if nothing is selected
; 3/1/88  jaj removed :table-format-string init-list
; 2/16/88 gb  lambda-ized actions.
; 2/8/88  jaj don't call dialog-item-enable on double-click
;01/28/88 as  apropos-dialog takes an optional initial string
;10/25/87 jaj removed grow-icon special casing
;10/21/87 jaj *grow-rect* -> window-grow-rect
;10/14/87 jaj New "svelt" version

(in-package :ccl)

(eval-when (:compile-toplevel :execute)
  (require "DIALOG-MACROS"))
;(defvar *apropos-dialog* nil)
(defparameter *apropos-dialog-size&position* (cons #@(384 262) #@(148 82)))

(defparameter *apropos-types*
  '(function variable class macro t))

;; possible alist of functions for types
(defparameter *apropos-type-functions* nil)

(defun make-vertical-button-view (buttons size spacing &optional view-height)
  (let ((vpos (if nil 54 20))
        (container (make-instance 'left-border-view))
        (height (point-v size)))
    (dolist (button buttons)
      (destructuring-bind (title action &rest keys) button
        
        (apply #'make-dialog-item
               'button-with-update
               (make-point 20 vpos)
               size
               title
               action
               :view-container container
               :dialog-item-enabled-p nil
               keys))
      
      (setq vpos (+ vpos height spacing)))
    (set-view-size container (make-point (+ (point-h size) 30)
                                         (or view-height (+ vpos height 40))))
    container))


; replace a pop-up menu's items, maintaining the selected item
(defmethod replace-menu-items ((menu pop-up-menu) items)
  (let ((selected (menu-item-title (selected-item menu))))
    (apply #'remove-menu-items menu (menu-items menu))
    (apply #'add-menu-items menu items)
    (let ((pos (position (find-menu-item menu selected) items)))
      (when pos
        (set-pop-up-menu-default-item menu (1+ pos))))))

#|
(defun string-package-p (string)
  (let ((pos (position #\: string)))
    (when pos
      (let ((upstring (string-upcase (subseq string 0 pos))))
        (find-package upstring)))))

(defun string-less-package (string)
  (let ((pos (position #\: string)))
    (if pos
      (progn
        (if (and (< pos (1- (length string)))(eq #\: (schar string (1+ pos))))
          (setq pos (1+ pos)))
        (subseq string (1+ pos) (length string)))
      string)))
|#

(defun string-package-and-tail (string)
  (let ((pos (position #\: string))
        pkg)
    (when pos
      (if (eq pos 0)
        (setq pkg (find-package :keyword))
        (let ((upstring (string-upcase (%substr string 0 pos))))
          (setq pkg (find-package upstring)))))
    (when pkg
      (if (and (< pos (1- (length string)))(eq #\: (schar string (1+ pos))))
        (setq pos (1+ pos)))
      (setq string (%substr string (1+ pos) (length string))))
    (values pkg string)))
      
  
  

(defun apropos-dialog (&optional apropos-string)
  (let ((w (front-window))
        (pkg))
    (when (and (not apropos-string) w)
      (let ((key (window-key-handler w)))
        (when (typep key 'fred-mixin)
          (multiple-value-bind (b e) (selection-range key)
            (when (neq b e)
              (let ((np (buffer-forward-find-eol (fred-buffer key)  b e)))
                (when (and np (neq np b)) (setq e (1- np))))
              (setq apropos-string (buffer-substring (fred-buffer key) b e))             
              (multiple-value-setq (pkg apropos-string)
                (string-package-and-tail apropos-string)))))))
    (when (not pkg)
      (setq pkg (cond ((typep w 'fred-window)
                       (let ((p (ignore-errors (window-package w))))  ; perhaps even if no selection
                         (if (typep p 'package)
                           p
                           *package*)))
                      (t *package*))))
    (let ((d (front-window :class 'apropos-dialog))
          (next-y 0))
      (unless d
        (let*()           
          (setq d (make-instance 'apropos-dialog
                    :window-title "Apropos"
                    :view-position (cdr *apropos-dialog-size&position*)
                    :view-size #@(384 252) ;#@(400 316) ; height 240 without check-box
                    :window-type :document-with-grow
                    :window-show nil
                    :help-spec 14010
                    ;:content-color *tool-back-color*
                    ;:back-color *tool-back-color*
                    :theme-background t
                    :view-subviews                
                    (vertical-labeled-items 
                     :dialog-width 264 :col2 95 :delta 29 :lmargin 6 :vpos 10 :lastvar next-y
                     :items
                     (("type:" pop-up-menu type nil
                       :menu-items
                       (make-menu-items 
                        (mapcar #'(lambda (x) (if (neq x t)(symbol-name x) "All")) *apropos-types*))
                       :help-spec 14015)
                      ("package:" pop-up-menu package nil
                       :menu-items (make-package-items t)
                       :update-function #'(lambda (menu)
                                            (unless (equal (view-get (view-container menu) :packages)
                                                           (list-all-packages))
                                              (replace-menu-items menu (make-package-items t))
                                              (view-put d :packages (list-all-packages))))
                       :help-spec 14016)
                      ("contains:" editable-text-dialog-item string1 nil
                       :dialog-item-text (or apropos-string "")
                       :help-spec 14011)))))
          (view-put d :packages (list-all-packages))
          (add-subviews d (make-instance 'pop-up-menu
                            :view-position
                            (make-point (+ 26 -10) (+ next-y -5))
                            ;:view-size
                            ;nil ;#@(57 18)
                            ;:view-font '("chicago" 12) 
                            :view-nick-name 'operation
                            :menu-items 
                            (make-menu-items '("and" "or" "not"))
                            :help-spec 14017)
                        (make-dialog-item 'editable-text-dialog-item
                                          (make-point 95 (+ next-y -3))
                                          #@(158 16) "" nil
                                          :draw-outline -2
                                          :view-nick-name 'string2
                                          :help-spec 14018)
                        (make-dialog-item 'static-text-dialog-item
                                          (make-point 6 (+ next-y 25))
                                          nil ;#@(80 20)
                                          "name:")
                        (make-dialog-item 'arrow-dialog-item
                                          (make-point 10 (+ next-y 25 20))
                                          #@(244 78) "" nil 
                                          :view-nick-name 'table
                                          :view-font *fred-default-font-spec*
                                          :table-vscrollp t
                                          :table-sequence nil
                                          ; :table-hscrollp nil
                                          :table-print-function
                                          #'(lambda (item &optional (stream t))
                                              (maybe-print-package item stream d))
                                          :dialog-item-action
                                          #'(lambda (item)
                                              (if (double-click-p)
                                                (do-apropos item :inspect)))
                                          :help-spec 14014))
          #+not-anymore
          (apply #'add-subviews d
                 (vertical-labeled-items
                  :dialog-width 264 :col2 95 :delta 29 :lmargin 6 :vpos 234
                  :items
                  (("specializers:" typein-menu specializers nil
                    :menu-class 'spec-typein-menu
                    :menu-position :left                  
                    :view-nick-name 'specializers
                    :help-spec 14019)
                   ("qualifier:" pop-up-menu qualifier nil
                    :view-nick-name 'qualifier
                    :menu-items (make-qualifier-items)
                    :help-spec 14020))))
          (add-subviews d (make-dialog-item 'check-box-dialog-item
                                            #@(10 228)   ; pos
                                            #@(170 18)   ; size
                                            "external symbols only"
                                            nil
                                            :view-nick-name 'external))
          
          (let* ((button-view Nil) 
                 (the-buttons
                  
                  `(
                    ("inspect"
                     ,#'(lambda (item)
                          (do-apropos item :inspect))
                     :update-function
                     ,#'(lambda (item)
                          (apropos-update item :inspect))
                     :help-spec 14013)
                    ("source"
                     ,#'(lambda (item)
                          (do-apropos item :edit))
                     :update-function
                     ,#'(lambda (item)
                          (apropos-update item :edit))
                     :help-spec 14021)
                    ("callers"
                     ,#'(lambda (item)
                          (do-apropos item :callers))
                     :update-function
                     ,#'(lambda (item) (apropos-update item :callers))
                     :help-spec 14022)
                    ("doc"
                     ,#'(lambda (item) (do-apropos item :doc))
                     :update-function
                     ,#'(lambda (item) (apropos-update item :doc))
                     :help-spec 14023)
                    ("methods"
                     ,#'(lambda (item) (do-apropos item :methods))
                     :update-function
                     ,#'(lambda (item) (apropos-update item :methods))
                     :help-spec 14024)
                    ("initargs"
                     ,#'(lambda (item) (do-apropos item :initargs))
                     :update-function
                     ,#'(lambda (item) (apropos-update item :initargs))))))
            
            (setq the-buttons (cons `( "apropos"
                                       apropos-search                             
                                       :default-button t ;,(if (osx-p) nil t)
                                       :view-nick-name apropos-search
                                       :help-spec 14012)
                                    the-buttons))
            (setq button-view
                  (make-vertical-button-view the-buttons
                                             (if (osx-p) #@(74 20) #@(70 20))
                                             10
                                             236))
            (set-view-nick-name button-view 'button-box)
            (set-view-position button-view #@(274 8))
            (add-subviews d button-view)) 
          (set-view-size d (car *apropos-dialog-size&position*))))        
      #+foo
      (when (osx-p)  ;; draws over everything - fixed for some subview types
        (#_SetThemeWindowBackground (wptr d) #$kThemeBrushModelessDialogBackgroundActive t)
        (view-put d 'theme-background #$kThemeBrushModelessDialogBackgroundActive ))
      (let ((string1 (view-named 'string1 d)))
        (when pkg (set-default-package-item (view-named 'package d) pkg))
        (when apropos-string (set-dialog-item-text string1 apropos-string))
        (update-default-button d))
      (window-select d))))

(defun maybe-print-package (item stream dialog)
  (let ((pkg (get-default-package-item (view-named 'package dialog))))
    (if (null pkg)
      (prin1 item stream)
      (princ item stream))))


(defclass apropos-dialog (string-dialog)
  (;(window-grow-rect :allocation :class :initform nil)
   (last-thing :initform nil :accessor last-function-name)))

(defclass left-border-view (view)())

(defmethod view-draw-contents ((v left-border-view))
  (let ((color-p (color-or-gray-p (view-window v))))
    (call-next-method)
    (#_MoveTo 0 0)
    (with-fore-color (if color-p *white-color* *black-color*)
      (#_LineTo 0 (1- (point-v (view-size v)))))
    (when color-p
      (#_moveto 1 0)
      (with-fore-color *tool-line-color*
        (#_LineTo 1 (1- (point-v (view-size v))))))))

(defmethod view-key-event-handler :after ((d apropos-dialog) ch)
  (declare (ignore ch))
  ;(update-default-button d)
  (update-buttons d))

(defmethod update-default-button ((d apropos-dialog))
  (let ((debutton (default-button d)))
    (when debutton
      (if
        (or (neq 0 (dialog-item-text-length (view-named 'string1 d)))
            (neq 0 (dialog-item-text-length (view-named 'string2 d))))
        (dialog-item-enable debutton)
        (dialog-item-disable debutton)))))
    

(defmethod view-click-event-handler :after ((d apropos-dialog) where)
  (declare (ignore where))
  (when t ;(view-contains-point-p (view-named 'table d) where)
    (update-buttons d)))

(defclass button-with-update (button-dialog-item)
  ((update-function :initarg :update-function :initform nil :reader button-update-function)))

(defmethod update-buttons ((d apropos-dialog))
  (let* ((subviews (view-subviews (view-named 'button-box d))))
    (dovector (s subviews)
      (let ((fn (button-update-function s)))
        (when fn
          (funcall fn s))))))

(defmethod view-minimum-size ((w apropos-dialog))
  #@(300 220))

; We are better off just using the text item, else we get
; e.g copy will sometimes use text, sometimes arrow-dialog
#|
(defmethod window-can-do-operation ((d apropos-dialog) op &optional item)
  (let ((text (current-key-handler d)))
     (when text
         (cond ((method-exists-p 'window-can-do-operation text)
                (window-can-do-operation text op item))
               (t (method-exists-p op text))))))
|#
    

(defmethod apropos-search (button)
  (let* ((d (view-window button))
         (pkg (get-default-package-item (view-named 'package d))) ; also want to allow "ANY" => nil
         (str1 (dialog-item-text (view-named 'string1 d)))
         (str1-p (not (= 0 (length str1))))
         (str2 (dialog-item-text (view-named 'string2 d)))
         (table (view-named  'table d))
         (str2-p (not (= 0 (length str2))))
         (type (nth (1- (pop-up-menu-default-item (view-named 'type d)))
                    *apropos-types*))
         (external (check-box-checked-p (view-named 'external d)))
         op result)
    (when str2-p
      (setq op (nth (1- (pop-up-menu-default-item (view-named 'operation d))) 
                    '(:and :or :not))))
    (with-cursor *watch-cursor*
      (#_ShowCursor)
      (flet ((doit (sym)
               (when (case type
                       (function (fboundp sym))
                       (variable (boundp sym))
                       (macro (macro-function sym))
                       (class (find-class sym nil))                       
                       (t (let ((fn (assq type *apropos-type-functions*)))
                            (if fn
                              (funcall (cdr fn) sym)
                              t))))
                 (let ((name (symbol-name sym)))
                   (when 
                     (or (and str1-p                     
                              (if (%apropos-substring-p str1 name)
                                (or (not str2-p)
                                    (eq op :or)
                                    (let ((in-2 (%apropos-substring-p str2 name))) 
                                      (case op
                                        (:and in-2)
                                        (:not (not in-2))
                                        (t nil))))
                                (and str2-p (eq op :or)
                                     (%apropos-substring-p str2 name))))
                         (and str2-p (not str1-p)
                              (let ((in-2 (%apropos-substring-p str2 name)))
                                (case op
                                  ((:and :or) in-2)
                                  (:not (not in-2))
                                  (t nil)))))
                     (push sym result))))))
        (declare (dynamic-extent doit))
        (if pkg
          (if (not external)
            (do-symbols (sym pkg)
              (doit sym))
            (do-external-symbols (sym pkg)
              (doit sym)))
          (if (not external)
            (do-all-symbols (sym)
              (doit sym))
            (dolist (pkg %all-packages%)
              (do-external-symbols (sym pkg)
                (doit sym))))))
      (let* ((last 0)                      ; not a symbol
         (junk #'(lambda (item)
                   (declare (debugging-function-name nil))
                   (or (eq item last) (progn (setq last item) nil)))))
        (declare (dynamic-extent junk))
        (setq result  (delete-if junk (sort result #'string-lessp))))
      (set-table-sequence table result)
      #|(let* ((fp (and result (memq type '(function all t))))
             (spec (view-named 'specializers d))
             (qual (view-named 'qualifier d)))
        (cond (fp (menu-enable spec)
                  (menu-enable qual))
              (t (menu-disable spec)
                 (menu-disable qual))))|#
      (when  result
        ;(cell-select table (index-to-cell table 0))
        ;(scroll-to-cell table 0)
        (set-current-key-handler d table))
      (update-buttons d))))

(defmethod window-close :before ((d apropos-dialog))
  (setf (car *apropos-dialog-size&position*) (view-size d)
        (cdr *apropos-dialog-size&position*) (view-position d))
  ;(setq *apropos-dialog* nil)
  )

(defmethod set-view-size ((d apropos-dialog) h &optional v &aux pt)
  (with-focused-view d
    (setq pt (make-point h v)
          h (point-h pt)
          v (point-v pt))
    (let* ((old-size (view-size d))
           (dh (- h (point-h old-size)))
           (dv (- v (point-v old-size)))
           (table (view-named 'table d))
           (table-size (view-size table))
           table-v
           will-be-table-v
           (new-table-h (+ (point-h table-size) dh))
           (new-table-v (+ (setq will-be-table-v (point-v table-size)) dv)))
      (call-next-method)
      (dovector (s (view-subviews d))
        (let* ((ssize (view-size s))
               (name (view-nick-name s)))
          (case name
            (table (setq table-v will-be-table-v))
            (operation)
            #+ignore
            (the-stupid-default-button
             (let ((pos (view-position s)))
               (set-view-position s (+ (point-h pos) dh)(point-v pos))))
            (button-box 
             (let ((pos (view-position s)))
               (set-view-position s (+ (point-h pos) dh)(point-v pos))
               (set-view-size s (point-h ssize) (+ (point-v ssize) dv))))
            (t 
             (unless (typep s 'scroll-bar-dialog-item)
               (let ((pos (view-position s)))
                 (when (and table-v (> (point-v pos) table-v))
                   (set-view-position s (point-h pos)(+ (point-v pos) dv))))
               (when (and (not (typep s 'static-text-dialog-item))(neq name 'external))
                 (set-view-size s (+ (point-h ssize) dh)(point-v ssize))))))))
      ; This is done last so that invalidating the "External Symbols Only" checkbox
      ; doesn't cause flashing in the table.
      (set-view-size table new-table-h new-table-v))))

#|
(defmethod view-activate-event-handler :after ((w apropos-dialog))
  (key-handler-hammer w (current-key-handler w)))
|#

(defmethod thing-name-from-dialog ((d apropos-dialog))
  (selected-cell-contents (view-named 'table d)))

(defun apropos-update (button type)
  (let* ((d (view-window button))
         (thing (thing-name-from-dialog d))
         (po-type (nth (1- (pop-up-menu-default-item (view-named 'type d)))
                    *apropos-types*)))
    (if (not thing)
      (dialog-item-disable button)
      (if 
        (case type
          ((:inspect :callers) t)
          (:doc (documentation-p thing))
          (:methods (find-class thing nil))
          (:edit
           (let* ()
             (case po-type
               (function
                (let ((foo (thing-name-from-dialog d))) ;(get-spec-from-dialog d)))
                  (if (consp foo)
                    (edit-definition-p foo)
                    (let ((m (typep (fboundp thing) 'standard-generic-function)))                      
                      (edit-definition-p thing (if m 'method 'function))))))
               (macro
                (edit-definition-p thing 'function))
               (t (edit-definition-p thing po-type)))))
          (:initargs (let ((class (find-class thing nil)))
                       (and class (not (typep class 'built-in-class)))))
          (t nil))        
        (dialog-item-enable button)
        (dialog-item-disable button)))))

(defun do-apropos (item what)
  (let* ((d (view-window item))
         (table (view-named  'table d))
         (type (nth (1- (pop-up-menu-default-item (view-named 'type d)))
                    *apropos-types*))
         (thing (selected-cell-contents table)))
    (when thing
      (let ()
        (case what
          (:doc
           (show-documentation thing))
          (:callers (edit-callers thing))
          (:inspect
           (let ((it (case type
                       (function (fboundp thing))
                       (variable thing) ; ?
                       (class (find-class thing nil))
                       (macro (macro-function thing)))))
             (inspect (or it thing))))
          (:edit
           (setq type
                 (case type                   
                   (function
                    (let* ((foo (thing-name-from-dialog d))) ;(get-spec-from-dialog d)))
                      (if (consp foo)
                        (setq thing foo) ;(edit-definition foo)
                        (let ((m (typep (fboundp thing) 'standard-generic-function)))
                          (if m 'method 'function)))))
                   (macro 'function)
                   (t type)))
           (eval-enqueue
            `(edit-definition ',thing ',type)))
          (:methods
           (let ((class (find-class thing nil)))
             (when class
               (let ((methods (specializer-direct-methods class))
                     w)
                 (setq methods (sort (copy-list methods) #'edit-definition-spec-lessp))
                 (setq w
                       (select-item-from-list
                        methods
                        ;:view-size #@(400 140)
                        :window-title (format nil "Methods on ~A" thing)
                        :table-print-function #'edit-callers-print          
                        :modeless t
                        :default-button-text "Find It"
                        :action-function
                        #'(lambda (list)
                            (if (option-key-p) (window-close w))
                            (edit-definition-spec (car list)))))))))
          (:initargs
           (let ((vect (initargs-for-class thing)))
             (when (neq vect t)  ;; happens too often? clos bug?
               (setq vect (sort vect #'string-lessp :key #'symbol-name)))
             (let ((win (make-instance 'initargs-window :word-wrap-p t :window-title "Initargs"
                                       :scratch-p t)))
               (format win "Valid initargs for class ~s:~%" thing)
               (let ()
                 (pprint vect win) ;(format win "~A" vect)
                 (WINDOW-SCROLL WIN 0)
                 )))))))))

(defclass initargs-window (fred-window)())  ;; so can close all at once


(defun initargs-for-class (x)
  (let  ((class (find-class x)))
    (if (typep class 'built-in-class)
      nil
      (class-make-instance-initargs class))))


    
    
#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
