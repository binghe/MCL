;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  1 7/18/96  akh  new file - from fred-additions
;;  (do not edit before this line!!)


(in-package :ccl)

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History
;;;
;;; $Log: list-definitions.lisp,v $
;;; Revision 1.6  2004/07/26 21:05:33  alice
;;; ;;; editable-text taller.
;;;
;;; Revision 1.5  2003/12/08 08:12:05  gtbyers
;;; Use WITH-SLOTS, not WITH-SLOT-VALUES.
;;;
;;; with-slots is silly
;;; ----- 5.2b6
;;; editable-text taller. 
;;; ----- 5.1b2
;;; window-defs-dialog - title may be encoded string
;;; --------- 5.0 final
;;; dialog gets theme-background
;;; ----- 4.4b3
;;; 02/28/02 let button sizes default - better for OSX
;;; ----------------- 4.4b2
;;; 05/07/97 bill  Specify true value of :table-vscrollp for the filtered-arrow-dialog-item
;;; -------------  4.1
;;;


; moved here from fred-additions

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(eval-when (eval compile #-bccl load)
  (defconstant %def-string "
(def"))


; this finds things inside #||#  - bug or feature?
(defun list-definitions (w &aux 
                           (b (fred-buffer w)) alist item)
  "Returns a list of all calls to DEF starting in column 0 with their starting
   positions. Each element of the list is a cons of 2 elements:
    the string of the name being defined and the starting position in the
    buffer of the open paren of the call.
   DEF is case insensitive."
  ;must special case def at pos 0
  (when (buffer-substring-p b "(def" 0)
    (if (setq item (top-form-position-item b 4))
      (setq alist (list item))))
  (do ((result-pos (buffer-forward-search b %def-string 0) ;will not hit if there's
                                                           ;a def starting at pos 0
                   (buffer-forward-search b %def-string result-pos)))
      ((not result-pos) (nreverse alist))
    (setq item (top-form-position-item b result-pos))
    (when item      
      (setq alist (cons item alist)))))

(defun top-form-position-item (w start-pos &aux 
                                 after-def-pos result-pos end-pos string methodp)
  (setq result-pos (- start-pos 4))
  (setq after-def-pos start-pos)
  (cond ((setq start-pos (buffer-fwd-sexp w start-pos))
         (setq methodp (and (eq 6 (- start-pos after-def-pos))
	                    (buffer-substring-p w "method" after-def-pos)))
         (setq start-pos (buffer-fwd-skip-wsp w start-pos))
         (cond ((setq end-pos (buffer-fwd-sexp w start-pos))
                (setq string (buffer-substring w start-pos end-pos))
                (if methodp
                  (setq string (method-position-item w string end-pos))
                  (cond ((setq end-pos (position #\return string))
                         (setq string (%substr string 0 end-pos)))))
                (cons string result-pos))))))

#| too slow
(defun method-position-item (w fn-name-string pos &aux
                               (end-pos pos) args types qualifiers)
  (block method-position-item
    (flet ((read-args ()
                      (when (setq end-pos (buffer-fwd-sexp w end-pos))
                        (setq pos (buffer-bwd-sexp w end-pos))
                        (ignore-errors 
                         (read-from-string (buffer-substring w pos end-pos))))))
      (cond ((setq args (read-args))
             (while (and args (atom args))
               (push args qualifiers)
               (setq args (read-args)))
             (when (null args)
               (print "returning because args is null")
               (return-from method-position-item (fn-name-string)))
             (setq fn-name-string 
                   (or (ignore-errors (read-from-string fn-name-string))
                       fn-name-string))
             (if (stringp fn-name-string)
               (return-from method-position-item fn-name-string))
             (dolist (arg args)
               (cond ((listp arg) (push (or (second arg) t) types))
                     ((memq arg '(&optional &rest &key &aux)) (return))
                     (t (push t types))))
             (format nil "~s"
                     `(,fn-name-string ,@(nreverse qualifiers) ,(nreverse types))))
            (t fn-name-string)))))
|#

(defun method-position-item (w fn-name-string pos &aux
                               (end-pos pos) args-end-pos
                               (types "") (qualifiers "")
                               char (buffer-length (buffer-size w)))
    (flet ((read-args () (when (and (setq pos (buffer-skip-fwd-wsp&comments
                                               w end-pos buffer-length))
                                    (setq end-pos (buffer-fwd-sexp w pos)))
                           (buffer-char w pos)))
           (arg-specializer (p ep)
                            (or (and (setq p (buffer-fwd-sexp w (1+ p)))
                                     (setq p (buffer-skip-fwd-wsp&comments 
                                              w p buffer-length))
                                     (< p (1- end-pos))
                                     (setq ep (buffer-fwd-sexp w p))
                                     (buffer-substring w p ep))
                                "t"))
           (my-string-append (s1 s2)
                             (if (eq 0 (length s1))
                               s2
                               (%str-cat s1 " " s2))))
      (macrolet ((add-string (var string)
                             `(setq ,var (my-string-append ,var ,string))))
        (cond ((setq char (read-args))
               (while (and char (neq char #\( ))
                 (add-string qualifiers (buffer-substring w pos end-pos))
                 (setq char (read-args)))
               (when (null char)
                 (return-from method-position-item fn-name-string))
               (setq args-end-pos (1- end-pos))
               (setq end-pos (1+ pos))
               (loop
                 (setq char (read-args))
                 (unless (<= end-pos args-end-pos) (return))
                 (cond ((eq char #\( ) 
                        (add-string types (arg-specializer pos end-pos)))
                       ((and (eq char #\&)
                             (member (buffer-substring w pos end-pos)
                                '("&optional" "&rest" "&key" "&aux")
                                :test #'string-equal))
                        (return))
                       (t (add-string types "t"))))
               (unless (eq 0 (length qualifiers))
                 (setq qualifiers (%str-cat " " qualifiers)))
               (%str-cat
                "(" fn-name-string  qualifiers " (" types "))"))
              (t fn-name-string)))))

(defclass menu-of-defs-dialog (dialog)
  ((my-window :initarg :my-window :initform nil)
   (items :initform nil)
   (alpha-items :initform nil))
  (:default-initargs :help-spec 14060
    :view-font *fred-default-font-spec*
    :grow-icon-p t))


(defmethod window-close :after ((d menu-of-defs-dialog))
  (let* ((w (slot-value d 'my-window))
         (frob (assq w *defs-dialogs*)))
    (when frob (setq *defs-dialogs* (delq frob *defs-dialogs*)))))


; should we nuke the filter button and always use the filter? - yeah
; also disable d button when list empty
(defmethod initialize-instance :after ((d menu-of-defs-dialog) &rest initargs)
  (declare (ignore initargs))
  ; Leave pointer so I go away if my window goes away. 
  (let* ((my-window (slot-value d 'my-window))
         (frob (assq my-window *defs-dialogs*)))
    (if frob
      (rplacd frob d)
      (setq *defs-dialogs* (cons (cons my-window d) *defs-dialogs*))))
  (add-subviews
    d
    (make-instance 'editable-text-dialog-item
      :view-nick-name 'string-item
      ; :view-font '("monaco" 9)
      :view-position #@(74 9) ;#@(9 9)
      :view-size #@(204 16)
      :dialog-item-action
      #'(lambda (item)
          (let ((w (view-window item)))
            (refilter-table w (view-named 'table w))))
      :help-spec 14065)
    (make-instance 'static-text-dialog-item
      :view-position #@(6 8)
      :dialog-item-text "Contains:"
      ;:view-nick-name 'filter-button
      )
    (make-instance 'filtered-arrow-dialog-item
      :view-nick-name 'table
      :view-position #@(8 62)
      :table-sequence ()
      :table-print-function #'(lambda (item &optional (stream t))
                                (princ (car item) stream))
      :cell-to-string-function #'car     
      :table-dimensions #@(0 1)
      :table-vscrollp t
      ;:table-hscrollp nil
      :view-size #@(270 188)
      :help-spec 14060)
    (make-instance 'default-button-dialog-item
      :dialog-item-text "Go To Definition"
      :view-position #@(137 268)
      ;:view-size #@(120 20)
      :help-spec 14063
      :dialog-item-action
      #'(lambda (item)
          (let* ((my-dialog (view-container item))
                 (my-table (view-named 'table my-dialog))
                 (selected-def (selected-cell-contents my-table))
                 (my-window (slot-value my-dialog 'my-window))) 
            (when selected-def
              (window-scroll my-window (cdr selected-def))
              (window-select my-window)))))
    (make-instance 'button-dialog-item
      :view-nick-name 'rescan-button
      :dialog-item-text "Rescan"
      :view-position #@(6 268)
      ;:view-size #@(76 20)
      :help-spec 14064
      :dialog-item-action
      #'(lambda (item)
          (let* ((my-dialog (view-container item))
                 (my-window (slot-value my-dialog 'my-window))
                 (my-table (view-named 'table my-dialog))
                 (the-items (list-definitions my-window))
                 (buffer-order-button
                  (view-named 'buffer-order-button my-dialog)))
            (setf (slot-value my-dialog 'items) the-items)
            (setf (original-table-sequence my-table) the-items)
            (setf (slot-value my-dialog 'alpha-items) nil)
            (if (radio-button-pushed-p buffer-order-button)
              (dialog-item-action buffer-order-button)
              (dialog-item-action 
               (view-named 'alpha-order-button my-dialog)))
            (let ((dbutton (default-button my-dialog)))
              (cond
               (the-items
                (set-current-key-handler my-dialog my-table)
                (refilter-table my-dialog my-table) ;(dialog-item-enable dbutton)
                )
               (t (dialog-item-disable dbutton))))
            ;(menu-update (edit-menu))
            )))
    (make-instance 'static-text-dialog-item
      :view-position #@(4 36)
      :view-size #@(56 16)
      :dialog-item-text "Sort:")
    (make-instance 'radio-button-dialog-item
      ; these things are drawn by the rom which doesnt dtrt with window back color
      :view-nick-name 'buffer-order-button
      :dialog-item-text "Buffer"
      :view-position #@(59 36)
      :view-size #@(68 16) ; was 102
      :radio-button-pushed-p t
      :help-spec 14061
      :dialog-item-action
      #'(lambda (item)
          (let* ((my-dialog (view-container item))
                 (table (view-named 'table my-dialog)))
            (setf (original-table-sequence table) (slot-value my-dialog 'items))
            (refilter-table my-dialog table))))             
    (make-instance 'radio-button-dialog-item
      :view-nick-name 'alpha-order-button
      :dialog-item-text "Alphabetical"
      :view-position #@(155 36) 
      :view-size #@(104 16) ; was 141
      :help-spec 14062
      :dialog-item-action
      #'(lambda (item)
          (let* ((my-dialog (view-container item))
                 (alpha-items (slot-value my-dialog 'alpha-items)))
            (unless alpha-items
              (setf (slot-value my-dialog 'alpha-items)
                    (setq alpha-items
                          (sort (copy-list (slot-value my-dialog 'items))
                                #'string-lessp
                                :key #'car))))
            (let* ((table (view-named 'table my-dialog)))
              (setf (original-table-sequence table) alpha-items)
              (refilter-table my-dialog table))))))
  (dialog-item-action (view-named 'rescan-button d)))

(defun refilter-table (dialog table)
  (let ((debutton (default-button dialog)))    
    (filter-table-sequence table (view-named 'string-item dialog))
    (if (< 0 (length (table-sequence table)))
      (progn        
        ;(set-current-key-handler dialog table)
        (dialog-item-enable debutton))
      (dialog-item-disable debutton))))
    

(defmethod set-view-size ((d menu-of-defs-dialog) h &optional v)
  (let* ((v1 (view-named 'string-item d))  ; wider
         (v3 (view-named 'table d))  ; wider and higher
         (v4 (view-named 'rescan-button d))  ; down
         (v5 (default-button d))      ; down right
         (old-size (view-size d))
         (dh (- (if v h (point-h h)) (point-h old-size)))
         (dv (- (if v v (point-v h)) (point-v old-size)))
         (ds (make-point dh dv)))
    (call-next-method)
    (set-view-size v1 (add-points (view-size v1)(make-point dh 0)))    
    (set-view-size v3 (add-points (view-size v3) ds))
    (set-view-position v4 (add-points (view-position v4)(make-point 0 dv)))
    (set-view-position v5 (add-points (view-position v5) ds))
    ))
    
#|
(defvar %last-menu-of-defs-keystroke 0)
(defvar %menu-of-defs-string (make-array 8 :element-type 'base-character
                                         :adjustable t :fill-pointer 0))


(defun find-thing-with-string (my-table char)  
  (let* ((new-time (rref *current-event* eventrecord.when))
         (string %menu-of-defs-string)
         (the-def-list (table-sequence my-table))
         (selected-cell (first-selected-cell my-table))
         (rest-of-list the-def-list))
    (when (> (- new-time %last-menu-of-defs-keystroke)
             (#_GetDblTime))      
      (setf (fill-pointer string) 0))
    (vector-push-extend char string)
    (setq %last-menu-of-defs-keystroke new-time)
    (let* ()                    
      (setq rest-of-list
            (member string
                    the-def-list
                    :test #'(lambda (a-string a-list &aux (b-string (car a-list)))                                
                              (string-equal a-string b-string
                                            :end2 (min (length a-string)
                                                       (length b-string)))
                              )))      
      (when rest-of-list
        (if selected-cell (cell-deselect my-table selected-cell))
        (let* ((new-cell-count (- (length the-def-list)
                                  (length rest-of-list)))
               (new-selected-cell (make-point 0 new-cell-count))
               (cell-to-scroll-to (make-point 0 (max 0 (- new-cell-count 5)))))
          (when 
            (or (null (cell-position my-table new-selected-cell))
                (null (cell-position my-table 
                                     (index-to-cell my-table (1+ new-cell-count)))))
            (scroll-to-cell my-table cell-to-scroll-to))
          (cell-select my-table new-selected-cell))))))
|#


; a method because the list definitions menu item will be dim for
; top-windows not having this method
(defmethod window-defs-dialog  ((w fred-window))
  (let ((defs-dialog (cdr (assq w *defs-dialogs*))))
    (if (and defs-dialog (wptr defs-dialog))
      (progn
        (window-select defs-dialog)
        (dialog-item-action (view-named 'rescan-button defs-dialog))
        defs-dialog)
      (let ((title (maybe-encoded-strcat  "Definitions in "
                                          (window-title w))))
        (window-select
         (make-instance
           'menu-of-defs-dialog
           :window-title title
           :view-position #@(223 44)
           :view-size #@(296 300)  ; was 386 411 -100 -100
           ;:back-color *tool-back-color*
           ;:content-color *tool-back-color*  ; because of radio buttons
           :theme-background t
           :window-show nil
           :my-window w))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;