;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  6 8/14/96  bill 4.0d23
;;  5 7/31/96  slh  
;;  2 4/24/96  akh  3.0 version was more modern
;;  12 6/26/95 akh  some changes to make "Other" menubar work sensibly - e.g. don't ask in do-save-application.
;;                  Pass menubar to save-application - else get wrong menubar in saved app.
;;                  Reinstate some rotate-menubars stuff if ift is loaded.
;;  10 5/25/95 akh  excise => disable in dialog
;;  4 4/10/95  akh  content-color for dialog
;;  (do not edit before this line!!)

;; save-application-dialog.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

(in-package :ccl)

; TO DO: close all open rsrc files before saving (ask user)

;; Modification History
;
; lose size stuff from dialog
; -------- 5.2b5
; say :format-list nil in get-app-path
; ----- 5.2b4
; "cancel" button is a cancel-button
; ----------- 5.1b2
; rename get-app-name
; ------- 5.0 final
; dialog gets theme-background, save image button bigger if OSX
;----------- 4.4b3
; 01/30/99 akh   find-all-subclasses deletes duplicates - use steve's version
;  9/18/96 slh   use declaim ftype to avoid warnings
;  8/13/96 bill  add init-file to :allow-empty-strings arg in save-application-dialog
;  5/03/96 slh   added init file field; updated for PPC
;  4/25/96 bill  in load-build-app, "ccl:library;build-application.fasl" => #.(merge-pathnames *.fasl-pathname* ...)
;  ------------  MCL-PPC 3.9
;  7/07/95 slh   generate & add app popup items after dialog is created
;                added load-build-app, better than using ignore-errors
;  7/05/95 slh   toplevel-function -> appgen-patches.lisp; use error-modes-alist
;  6/30/95 slh   switch-class: set app name
;  6/28/95 slh   exports; coerce sizes values to numbers for fields
;                switch-class: allow list for application-sizes
;                do-save-application: reverse sizes arg (see save-application doc)
;  6/27/95 slh   switch-class: set toplevel function field, menubar popup, error mode
;                make-application-class-items: call switch-class on default item
;                make-menubar-item-list: add application & default menubars; warn about
;                 application-menubar override
;                save-application-dialog: remove "ccl::", extend some popup/edit
;                 controls; added Methods button; error popup mods.
;                do-save-application: pass toplevel function to  build-application;
;                 call get-app-name before CNFD; better warning messages
;                added new application methods, app pathname alist
;  6/06/95 slh   help specs
;  5/04/95 slh   excise compiler defaults to off for LDS
;  4/16/95 slh   qualify toplevel-function name in dialog
;  4/11/95 slh   remove obsolete export; split off build-app functions
;                check for IFT-fbindings instead of defining default fns
;                get-app-resources -> dumplisp, needed by app loader
;  3/15/95 slh   new from save-application-dialog.lisp
;                get-app-resources gets ALL resources from file



(eval-when (:compile-toplevel :execute)
  (require :lispequ)
  (require :resources))
(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :hide-listener-support))

(declaim (ftype (function (&rest t) t)
                application-menubar
                rotate-menubars-until
                modules-dialog
                dump-app-methods
                build-application))

(defconstant min-partition-size 2000)

(defvar *save-application-dialog* nil)
(defvar *mcl-menubar* nil)              ; set in save-application-dialog

(defvar *app-name* nil)
(defvar *app-class-name* 'lisp-development-system       ; defaults to popup's default
  "Name of class to eventually bind to *application*")
(defvar *app-pathname-alist* nil)
(defvar *app-params-inited* nil)
(defvar *menubar-list* nil)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (fboundp 'menubar-list)
    (defun menubar-list ()
      (or *menubar-list*
          (setq *menubar-list* (list *mcl-menubar*))))
    (defun count-menubars ()
      (length (menubar-list)))
    (defun ift-add-menubar (z)
      (unless (member z (menubar-list) :test #'equal)
        (push z *menubar-list*)))))


(defun make-application-class-items ()
  (let ((app-class (find-class 'application))
        (lds-class (find-class 'lisp-development-system)))
    (prog1
      (mapcar #'(lambda (class)  
                  (let ((class-name (class-name class)))
                    (make-instance 'menu-item
                      :menu-item-title (string-upcase (string class-name))
                      :menu-item-action #'(lambda ()
                                            (switch-class class-name class)))))
              `(,lds-class
                ,@(delete lds-class (find-all-subclasses app-class) :test #'eq)
                ,app-class))
      (switch-class 'lisp-development-system lds-class))))

(defun switch-class (class-name class)
  (unless (eq *app-class-name* class-name)
    (setq *app-class-name* class-name
          *app-params-inited* nil)
    (let ((dialog *save-application-dialog*)
          (proto (class-prototype class)))
      (flet ((set-text (name method &optional value null-string &aux view)
               (when (and (cond ((null method) value)
                                ((fboundp method)
                                 (setq value (or (funcall method proto) null-string)))
                                (t nil))
                          (setq view (view-named name dialog)))
                 (set-dialog-item-text view (princ-to-string value))))
             (set-item (popup title)
               (when popup
                 (set-pop-up-menu-default-item popup
                                               (menu-item-number
                                                (find-menu-item popup title))))))
        (set-app-name (or (application-name proto) *app-name*))
        (set-text 'creator 'application-file-creator)
        (set-text 'res-file 'application-resource-file)
        ;(set-text 'toplevel-function 'application-toplevel-function)
        (set-text 'init-file 'application-init-file nil "")
        (multiple-value-bind (min pref)
                             (application-sizes proto)
          (when (consp min)
            (setq pref (second min)
                  min  (first  min)))
          (when min
            (set-text 'min-size  nil (round min  1024)))
          (when pref
            (set-text 'pref-size nil (round pref 1024))))
        (when (and (fboundp 'application-menubar)
                   (application-menubar proto))
          (set-item (view-named 'menubar-popup dialog) "APPLICATION-MENUBAR"))
        (set-item (view-named 'error-popup dialog) "APPLICATION-ERROR-MODE")))))

#|
(defun find-all-subclasses (c)
  (delete-duplicates (find-all-subclasses0 c)))

(defun find-all-subclasses0 (c)
  (when (symbolp c) (setq c (find-class c)))
  (let ((s (copy-list (class-direct-subclasses c))))
    (when s (nconc s (mapcan #'find-all-subclasses0 s)))))
|#

;; slh's version
(defmethod find-all-subclasses ((class symbol))
  (find-all-subclasses (find-class class)))

(defmethod find-all-subclasses ((class standard-object))
  (find-all-subclasses (class-direct-subclasses class)))

(defmethod find-all-subclasses ((subclasses list))
  (delete-duplicates
   (nconc (nreverse (copy-list subclasses))
          (mapcan #'find-all-subclasses subclasses))))

(defmethod find-all-subclasses ((subs null))
  nil)

(defvar *other-item* nil)
(defvar *other-menubar* nil) ; ugh

(defun make-menubar-item-list (build-app-p-fn)
  ; make each items update-function contain the actual menubar
  ; or define a subclass of menu-item that has a slot for the menubar
  (let ((n (count-menubars))        
        other-string
        res)
    (push (setq *other-item*
                (make-instance 'menu-item
                  :menu-item-title "OtherÉ"
                  :menu-item-action 
                  #'(lambda ()
                      (let* ((x (catch-cancel
                                  (get-string-from-user 
                                   "Enter the name of a variable whose value is the desired menubar."
                                   :initial-string other-string)))
                             (y (if (stringp x)
                                  (ignore-errors 
                                   (let ((*package* *package*)) ;(find-package :cl-user))) 
                                     (read-from-string x)))))
                             z)
                        (unless (eq x :cancel)
                          (cond ((and y (boundp y)
                                      (consp (setq z (symbol-value y))))
                                 (set-menu-item-title *other-item* x)
                                 (menu-update (menu-item-owner *other-item*))
                                 (setq other-string x
                                       *other-menubar* z)
                                 (set-menubar z))
                                (t (message-dialog
                                    (format nil (if (boundp y)
                                                  "The value of ~s is not a menubar."
                                                  "~s is unbound.")
                                            y)))))))))
          res)
    (flet ((what-title (menubar n)
             (cond ((equal menubar *mcl-menubar*) "MCL menubar")
                   ((eq n 1) "Custom")
                   (t (format nil "Custom ~D" (1- n)))))
           (app-menu-warn ()
             (when (funcall build-app-p-fn *save-application-dialog*)
               (message-dialog "Note: selecting this menubar from the popup will not work for MCL-AppGen unless you application-menubar also returns the same menubar."
                               :size #@(360 120)))))
      (cond ((fboundp 'rotate-menubars-until)
             (do ((i 0 (1+ i))
                  (l (menubar-list) (cdr l)))
                 ((= i n))
               (let ((zit (cons *apple-menu* (cdr (car l)))))
                 (push (make-instance 'menu-item
                         :menu-item-title (what-title zit (- n i)) ; slightly backwards - dont care
                         :menu-item-action
                         #'(lambda ()
                             (rotate-menubars-until zit)
                             (app-menu-warn)))
                       res)))
             (let ((zit (menubar)))
               (push (make-instance 'menu-item
                       :menu-item-title (what-title zit n)
                       :menu-item-action
                       #'(lambda () 
                           (rotate-menubars-until zit)
                           (app-menu-warn)))
                     res)))
            (t (ift-add-menubar (menubar))
               (let ((mlist (menubar-list)))
                 (do ((i (- (length mlist) 1) (1- i))
                      (l mlist (cdr l)))
                     ((null l))
                   (let ((zit (car l)))
                     (push (make-instance 'menu-item
                             :menu-item-title (what-title zit i)
                             :menu-item-action
                             #'(lambda ()
                                 (set-menubar zit)
                                 (app-menu-warn)))
                           res))))))

      ; insert applic & default menubars after first (current) menubar
      (push (make-instance 'menu-item
              :menu-item-title "APPLICATION-MENUBAR"
              :menu-item-action
              #'(lambda ()
                  (let ((menubar (if (fboundp 'application-menubar)
                                   (application-menubar
                                    (class-prototype
                                     (find-class *app-class-name*))))))
                    (when (and menubar (verify-menubar menubar))
                      (set-menubar menubar)))))
            (cdr res))
      (unless (equal (menubar) *default-menubar*)
        (push (make-instance 'menu-item
                :menu-item-title "*DEFAULT-MENUBAR*"
                :menu-item-action
                #'(lambda () 
                    (set-menubar *default-menubar*)))
              (cdr res))))
    res))

(defun verify-menubar (menubar)
  (let ((warning
         (cond ((not (and (listp menubar)
                          (every #'(lambda (item)
                                     (typep item 'menu))
                                 menubar)))
                "Bad menubar: ~S is not a list of menus.")
               ((not (typep (car menubar) 'apple-menu))
                "Bad menubar: the first menu in ~S is not an APPLE-MENU.")
               ((not (equal menubar (remove-duplicates menubar :test #'eq)))
                "Bad menubar: ~S contains duplicate menus.")
               (t nil))))
    (cond (warning
           (warn warning menubar)
           nil)
          (t t))))


(defun load-build-app ()
  (handler-case (let ((*warn-if-redefine* nil)
                      (*warn-if-redefine-kernel* nil))
                  (require 'build-application #.(merge-pathnames *.fasl-pathname* "ccl:library;build-application")))
    (file-error () (return-from load-build-app nil)))
  (fboundp 'build-application))

; With Paige's input
(defun save-application-dialog ()
  (setq *app-params-inited*  nil
        *app-pathname-alist* nil        ; else user can't change it
        *mcl-menubar* (menubar))
  (unless (and *save-application-dialog*
               (wptr *save-application-dialog*))
    (let* ((original-menubar (menubar))
           (build-p (load-build-app))
           ;(min-size  0)
           ;(pref-size 0)
           (delta 32)  ;; was 26
           (vorg  (if build-p 56 12))
           (vorg2 (- vorg 3))
           (l-align 20)
           (r-align 174)
           (e-align (+ r-align 3))
           (lds-doit-label "Save ImageÉ")
           (app-doit-label "Build AppÉ")
           app-popup)
      (flet ((close-me (dialog)
               (if (fboundp 'rotate-menubars-until)
                 (rotate-menubars-until original-menubar)
                 (set-menubar original-menubar))
               (window-close dialog))
             (update-mode (item doit-label modules-p &optional (dialog (view-window item)))
               (set-dialog-item-enabled-p (view-named 'modules-button dialog) modules-p)
               (set-dialog-item-enabled-p (view-named 'excise dialog) (not modules-p))
               (set-dialog-item-text (view-named 'do-it dialog) doit-label))
             (build-app-p (dialog)
               (and build-p
                    (radio-button-pushed-p
                     (view-named 'applic-rb dialog)))))
        #+ignore
        (let ((sizeh (#_Get1Resource "SIZE" -1)))
          (unless (%null-ptr-p sizeh)
            (#_LoadResource sizeh)
            (setq pref-size (truncate (%hget-long sizeh 2) 1024)
                  min-size  (truncate (%hget-long sizeh 6) 1024))))
        (setq *save-application-dialog*          
              (make-instance 'string-dialog
                :back-color *tool-back-color*
                :content-color *tool-back-color*  ; because of check boxes
                :theme-background t
                :WINDOW-TYPE :movable-dialog
                :allow-empty-strings '(res-file init-file)
                :WINDOW-TITLE "Save Application"
                :VIEW-POSITION '(:top 50)
                ; way too big for a mac plus screen 338, 506
                :VIEW-SIZE (if build-p #@(408 348) #@(408 304))
                :VIEW-FONT (sys-font-spec) ;'("Chicago" 12 :SRCOR :PLAIN)
                :help-spec 15180
                :VIEW-SUBVIEWS
                `(,@(if build-p
                      `(,(make-dialog-item 'radio-button-dialog-item
                                           #@(98 4)
                                           #@(108 16)
                                           "MCL Image"
                                           #'(lambda (item)
                                               (let ((dialog (view-window item)))
                                                 (check-box-uncheck (view-named 'excise dialog))
                                                 (update-mode item lds-doit-label nil dialog)))
                                           :radio-button-pushed-p t
                                           :view-nick-name 'image-rb)
                        ,(make-dialog-item 'radio-button-dialog-item
                                           #@(98 25)
                                           #@(116 16)
                                           "Application"
                                           #'(lambda (item)
                                               (let ((dialog (view-window item)))
                                                 (check-box-check (view-named 'excise dialog))
                                                 (update-mode item app-doit-label t dialog)))
                                           :view-nick-name 'applic-rb)
                        ,(make-dialog-item 'button-dialog-item
                                           #@(210 24)
                                           #@(91 18)
                                           "ModulesÉ"
                                           #'(lambda (item)
                                               (declare (ignore item))
                                               (modules-dialog))
                                           :dialog-item-enabled-p nil
                                           :view-nick-name 'modules-button
                                           :default-button nil)))
                  
                  ,(make-dialog-item 'static-text-dialog-item
                                     (make-point l-align vorg)
                                     #@(119 16)
                                     "Application class:")
                  ,(setq app-popup (make-instance 'pop-up-menu
                                     :view-position (make-point r-align vorg2)
                                     :view-size     #@(214 22)
                                     :menu-items nil
                                     :help-spec 15181))
                  
                  ,(make-dialog-item 'static-text-dialog-item
                                     (make-point l-align (incf vorg delta))
                                     #@(150 16)
                                     "Menubar:")                    
                  ,(make-instance 'pop-up-menu
                     :view-position (make-point r-align (incf vorg2 delta))
                     :view-size     #@(214 22)
                     :view-nick-name 'menubar-popup                                      
                     :menu-items (make-menubar-item-list #'build-app-p)
                     :help-spec 15182)
                  
                  ,(make-dialog-item 'static-text-dialog-item
                                     (make-point l-align (incf vorg delta))
                                     #@(150 16)
                                     "Error handler:")                    
                  ,(make-instance 'pop-up-menu
                     :view-position (make-point r-align (incf vorg2 delta))
                     :view-size #@(214 22)   
                     :help-spec 15183                                   
                     :menu-items
                     `(,@(mapcar #'(lambda (pair)
                                     (make-instance 'menu-item                                       
                                       :menu-item-title (cdr pair)
                                       :menu-item-action #'(lambda () (car pair))))
                                 error-modes-alist)
                       ,(make-instance 'menu-item
                          :menu-item-title "APPLICATION-ERROR-MODE")
                       )
                     :view-nick-name 'error-popup)
                                    
                  ,(make-dialog-item 'static-text-dialog-item 
                                     (make-point l-align (incf vorg delta))
                                     #@(122 16)
                                     "Toplevel function:")
                  ,(make-dialog-item 'editable-text-dialog-item
                                     (make-point e-align (+ 3 (incf vorg2 delta)))
                                     #@(208 16)
                                     "TOPLEVEL-FUNCTION"
                                     nil
                                     :help-spec 15184
                                     :view-nick-name 'toplevel-function
                                     :allow-returns nil)

                  ,(make-dialog-item 'static-text-dialog-item 
                                     (make-point l-align (incf vorg delta))
                                     #@(122 16)
                                     "Init File:")
                  ,(make-dialog-item 'editable-text-dialog-item
                                     (make-point e-align (+ 3 (incf vorg2 delta)))
                                     #@(208 16)
                                     "init"
                                     nil
                                     :help-spec 15194
                                     :view-nick-name 'init-file
                                     :allow-returns nil)
                  #|

                  ,(make-dialog-item 'static-text-dialog-item
                                     (make-point l-align (incf vorg delta))
                                     #@(150 16)
                                     "Minimum size (KB):"
                                     nil)
                  ,(make-dialog-item 'editable-text-dialog-item
                                     (make-point e-align (+ 3 (incf vorg2 delta)))
                                     #@(116 16)
                                     (format nil "~D" min-size)
                                     nil
                                     :help-spec 15185
                                     :view-nick-name 'min-size)
                  
                  ,(make-dialog-item 'static-text-dialog-item
                                     (make-point l-align (incf vorg delta))
                                     #@(150 16)
                                     "Preferred size (KB):"
                                     nil)
                  ,(make-dialog-item 'editable-text-dialog-item
                                     (make-point e-align (+ 3 (incf vorg2 delta)))
                                     #@(116 16)
                                     (format nil "~D" pref-size)
                                     nil
                                     :help-spec 15186
                                     :view-nick-name 'pref-size)
                  |#          
                  
                  ,(make-dialog-item 'static-text-dialog-item
                                     (make-point l-align (incf vorg delta))
                                     #@(250 16)
                                     "Application signature:")
                  ,(make-dialog-item 'editable-text-dialog-item
                                     (make-point e-align (+ 3 (incf vorg2 delta)))
                                     #@(64 16)
                                     (string *ccl-file-creator*)
                                     nil
                                     :help-spec 15187
                                     :view-nick-name 'creator
                                     :allow-returns nil)
                  
                  ,(make-dialog-item 'check-box-dialog-item
                                     (make-point l-align (incf vorg delta))
                                     #@(150 16)
                                     "Disable compiler"
                                     nil
                                     :help-spec 15188
                                     :check-box-checked-p nil
                                     :view-nick-name 'excise)
                  ,(make-dialog-item 'check-box-dialog-item
                                     (make-point (- r-align 2) vorg)
                                     #@(150 16)
                                     "Clear CLOS caches"
                                     nil
                                     :help-spec 15189
                                     :check-box-checked-p t
                                     :view-nick-name 'caches)
                  
                  ,(make-dialog-item 'button-dialog-item
                                     (make-point l-align (incf vorg (- delta 2)))
                                     #@(122 20)
                                     "Resource fileÉ"
                                     #'(lambda (item)
                                         (catch-cancel
                                           (let ((path (choose-file-dialog :button-string "Choose")))                                          
                                             (set-dialog-item-text 
                                              (view-named 'res-file (view-window item))
                                              (namestring path)))))
                                     :help-spec 15190)
                  ,(make-dialog-item 'editable-text-dialog-item
                                     (make-point e-align (+ vorg 2))
                                     #@(208 16)
                                     ""
                                     nil
                                     :help-spec 15191
                                     :view-nick-name 'res-file)
                  
                  ,(make-dialog-item 'button-dialog-item
                                     (make-point (if build-p 40 110)
                                                 (incf vorg (+ delta 7)))
                                     #@(80 20)
                                     "Cancel"
                                     #'(lambda (item)
                                         (close-me (view-window item)))
                                     :cancel-button t
                                     :default-button nil
                                     :help-spec 15192)
                  ,(make-dialog-item 'button-dialog-item 
                                     (make-point (if build-p 154 218)
                                                 vorg)
                                     (if (not (osx-p)) #@(100 20) #@(104 20))
                                     lds-doit-label
                                     #'(lambda (item)
                                         (let ((dialog (view-window item)))
                                           (unless (eq (do-save-application
                                                        dialog
                                                        (build-app-p dialog))
                                                       :cancel)
                                             (close-me dialog))))
                                     :default-button t
                                     :help-spec 15193
                                     :view-nick-name 'do-it)
                  ,@(if build-p
                      `(,(make-dialog-item 'button-dialog-item
                                           (make-point 288 vorg)
                                           #@(80 20)
                                           "Methods"
                                           #'(lambda (item)
                                               (dump-app-methods (view-window item)))
                                           :default-button nil
                                           ;:help-spec 15192
                                           )))
                  )))
        (apply #'add-menu-items app-popup (make-application-class-items)))))
  (window-select *save-application-dialog*))

;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; stuff for extended save-application

(defun get-save-app-name ()
  (if *app-name*
    (string *app-name*)
    (set-app-name (get-string-from-user "Application name:"))))

; redefined by build-application.lisp
(defun set-app-name (name &optional app-info)
  (declare (ignore app-info))
  (setq *app-name* name))

(defun get-app-path (applic-p)
  (when applic-p
    (get-save-app-name))
  (cdr (or (assoc *app-name* *app-pathname-alist* :test #'string-equal)
           (car (push (cons *app-name*
                            (choose-new-file-dialog
                             :prompt (if applic-p
                                       "Build application as:"
                                       "Save new image as:")
                             :format-list nil
                             :button-string (if applic-p "Build" "Save")
                             :directory (format nil "home:~A" (or *app-name* ""))))
                      *app-pathname-alist*)))))

; returns (min pref) for size (OK for application-sizes, reverse for save-application)
(defun get-app-params (d applic-p)
  (labels ((item-text (name)
             (dialog-item-text (view-named name d)))
           (read-item-text (name)
             (ignore-errors
              (read-from-string (item-text name))))
           (save-app-warn (msg &rest args)
             (declare (dynamic-extent args))
             (message-dialog (apply #'format nil msg args))
             nil)
           (verify-size (size)
             (cond ((not (and (realp size)
                              (> size 0)))
                    (save-app-warn "Partiton size ~S is not a positive real number." size))
                   ((< size min-partition-size)
                    (save-app-warn "Partition size ~AK is below the minimum recommended size of ~AK."
                                   size min-partition-size))
                   (t t))))
    (let* ((toplevel  (let ((*package* *ccl-package*))
                        (read-item-text 'toplevel-function)))
           (init-file (item-text 'init-file))
           (sig       (item-text 'creator))
           ;(min-size  (read-item-text 'min-size))
           ;(pref-size (read-item-text 'pref-size))
           (res-file  (item-text 'res-file))
           (error-popup   (view-named 'error-popup d))
           (error-handler (menu-item-action (nth (1- (pop-up-menu-default-item error-popup))
                                                 (menu-items error-popup)))))
      (cond #|((not (and (verify-size min-size)
                       (verify-size pref-size)))
             nil)
            ((not (>= pref-size min-size))
             (save-app-warn "Preferred size ~S is less than minimum size ~S." pref-size min-size))
            |#
            ((not (or (null toplevel)
                      (functionp toplevel)
                      (and (symbolp toplevel)
                           (fboundp toplevel))))
             (save-app-warn "Toplevel function ~S is not a defined function or NIL." toplevel))
            ((not (and (stringp sig)
                       (= (length sig) 4)))
             (save-app-warn "Application signature ~S is not a 4 character string." sig))
            (t (catch-cancel
                 (when applic-p
                   (get-save-app-name))
                 (return-from get-app-params
                   (values t            ; status OK
                           res-file
                           (intern sig (find-package :keyword))
                           #+ignore
                           (list (* min-size  1024)
                                 (* pref-size 1024))
                           #-ignore
                           nil
                           toplevel
                           error-handler
                           (if (string/= init-file "") init-file))))
               nil)))))

(defun do-save-application (d applic-p)
  (multiple-value-bind (status res-file sig sizes toplevel error-handler init-file)
                       (get-app-params d applic-p)
    (when status
      (catch-cancel
        (let ((file (get-app-path applic-p)))
          (if applic-p
            (build-application file res-file sig sizes toplevel error-handler init-file)
            (let* ((menubar-popup (view-named 'menubar-popup d))
                   (item-num  (pop-up-menu-default-item menubar-popup))
                   (item (nth (1- item-num) (menu-items menubar-popup))))
              (if (and (eq item *other-item*) *other-menubar*)
                (set-menubar *other-menubar*)
                (menu-item-action item))
              (let ((menubar (menubar)))
                (eval-enqueue         ; see comment below
                 #'(lambda ()
                     (save-application
                      file
                      :application-class (find-class *app-class-name*)
                      ; have to pass in menubar because upon return from do-save-application
                      ; close-me resets menubar to original
                      :menubar menubar 
                      :error-handler error-handler
                      :toplevel-function (if (neq toplevel 'toplevel-function)
                                           toplevel)
                      :init-file init-file
                      :size (if sizes (reverse sizes))
                      :resources (get-app-resources res-file sig)
                      :clear-clos-caches (check-box-checked-p (view-named 'caches d))
                      :excise-compiler   (check-box-checked-p (view-named 'excise d))                                              
                      :creator sig)))))))))))

#| eval-enqueue for save-application:
This used to fail (though would work if eval-enqueued) because
throwing to toplevel in save-application caused 
the unwind-protect in toplevel-read to make a new
listener in order to print "busy" in its mini-buffer
Now it fails for some other reason. Assuming there is an eval-queue.
Without eval-enqueue:
On Quadra 7.1 never gets to a dbg before close the listener
 in prepare-to-quit
but the listener is gone, appears to "return"with no disk activity
On pb with 7.0.1 does get to dbg before and after closing listener
disk activity begins (I think it ate some more disk space)
|#

; End of save-application-dialog.lisp
