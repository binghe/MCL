; -*- Mode:Lisp; Package:INTERFACE-TOOLS; -*-

;;	Change History (most recent first):
;;  3 7/4/97   akh  see below
;;  2 6/9/97   akh  added an alternate update-windows-menu
;;  3 6/9/95   akh  no compiler warnings re *mcl-menubar*
;;  (do not edit before this line!!)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ift-menus.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  adds a menu to the menubar for controlling the interface designer.
;;

;;;;;;;;;;;;;;;;;;;;
;;
;; Change History
;;
;; 06/07/97 akh   added an alternative updater for a "Windows" menu.
;; 08/15/96 bill  (defparameter ccl::*mcl-menubar* ...) => (declaim (special ...)) (setq ...)
;;                This prevents a redefinition warning.
;;                *mcl-menubar* is now defined in "ccl:library;save-application-dialog.lisp".
;; -------------- MCL-PPC 3.9
;; new dialog always enabled (if selected sets *editing-dialogs* etc.) Its silly
;; to have to first choose "Design dialogs" then "New dialog" to make a new one.
;;--------------
;; 06/11/93 alice redefine some fns and vars here for save-application-dialog
;; 02/15/93 alice *edit-menu* => (edit-menu) 
;; 10/15/91 alice (menu-update *edit-menu*) when switching between using and designing
;; 09/06/91 bill break use-dialogs out from (method menu-item-action (use-dialogs-menu-item))
;;

(in-package :interface-tools)


(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))
(defun ccl::count-menubars ()
  (let ((l ift::*menubar-list*)
        (n 0))
    (when l
      (do ((ll (cdr l) (cdr ll)))
          ((eq ll l))
      (setq n (1+ n))))
    n))

(defun ccl::rotate-menubars-until (mb)
  (if (let ((*menubar-frozen* t))
        (dotimes (i (1+ (ccl::count-menubars)) t)
          (if (equal (menubar) mb)(return))
          (rotate-menubars)))
    (set-menubar mb)  ; didn't find it
    (draw-menubar-if)))

(defun ccl::ift-add-menubar (z)
  (add-menubar)
  (set-menubar z)
  (rotate-menubars))

(defun ccl::menubar-list ()
  *menubar-list*)
)


;;;;;;;;
;;
;; variables/objects
;;

(defclass editing-dialog-menu (menu) ())
(defclass editing-dialog-menu-item (window-menu-item) ())
(defclass use-dialogs-menu-item (menu-item) ())
(defclass design-dialogs-menu-item (menu-item) ())
(defclass new-dialog-menu-item (menu-item) ())

(defvar *design-menu* (make-instance 'menu :menu-title "Design"))


;;;;;;;;;;;;
;;
;; update functions
;;


(defmethod menu-item-update ((menu editing-dialog-menu))
  "called whenever the menu is seen"
  (let ((fw (front-window)))
    (if (and fw
             (ccl::editing-dialogs-p fw))
        (menu-enable menu)
        (menu-disable menu))))
  
(defmethod menu-item-update ((item editing-dialog-menu-item))
  "called whenever the menu is seen"
  (let ((fw (front-window)))
    (if (and fw (ccl::editing-dialogs-p fw))
        (call-next-method)
        (menu-item-disable item))))


;;;;;;;;;;;;;;;
;;
;; install the menu and add the items
;;

(menu-install *design-menu*)

; for save-application-dialog
(declaim (special ccl::*mcl-menubar*))
(setq ccl::*mcl-menubar* (menubar))

(defun init-design-menu ()
  (let ((menu *design-menu*))
    (apply #'remove-menu-items menu (menu-items menu))
    (add-edit-menu-item menu)
    (add-null-item menu)
    (add-mode-items menu)
    (add-null-item menu)
    (add-guide-items menu)
    (add-null-item menu)
    (add-window-item menu)
    (add-null-item menu)
    (add-print-item menu)))

(defmethod add-null-item ((menu menu))
  (add-menu-items
   menu
   (make-instance 'menu-item
                  :menu-item-title "-")))

(defmethod add-mode-items ((menu menu))
  (let* ((use-dialogs (make-instance 'use-dialogs-menu-item
                                     :menu-item-title "Use Dialogs"))
         (design-dialogs (make-instance 'design-dialogs-menu-item
                                        :menu-item-title "Design Dialogs"))
         (new-dialog (make-instance 'new-dialog-menu-item
                                    :menu-item-title "New Dialog…"
                                    :menu-item-action 'create-new-dialog
                                    :enabledp t)))
    (add-menu-items menu use-dialogs design-dialogs new-dialog)))

(defmethod menu-item-action ((item use-dialogs-menu-item))
  (use-dialogs))

(defun use-dialogs ()
  (let ((front (front-window)))
    (setq *editing-dialogs* nil)
    (menu-update (ccl::edit-menu))
    (draw-dialog-guides front)
    (highlight-selected-items front nil)
    (when *current-item-palette*
      (window-close *current-item-palette*))))

(defmethod menu-item-update ((menu use-dialogs-menu-item))
  (set-menu-item-check-mark menu (not *editing-dialogs*)))

#-carbon-compat
(defmethod menu-item-action ((item design-dialogs-menu-item))
  (let ((front (front-window)))
    (setq *editing-dialogs* t)
    (menu-update (ccl::edit-menu))
    (draw-dialog-guides front)
    (highlight-selected-items front t)
    (unless *current-item-palette*
      (make-instance 'item-palette))))


#+carbon-compat
; Handle the case where a non-editable (yet) window is already open and user selects "Design Dialogs"
(defmethod menu-item-action ((item design-dialogs-menu-item))
  (let ((front (front-window)))
    (setq *editing-dialogs* t)
    (maybe-become-ift-drag-target front) ; new
    (menu-update (ccl::edit-menu))
    (draw-dialog-guides front)
    (highlight-selected-items front t)
    (unless *current-item-palette*
      (make-instance 'item-palette))))

(defmethod menu-item-update ((item design-dialogs-menu-item))
  (set-menu-item-check-mark item *editing-dialogs*))

(defmethod menu-item-update ((item new-dialog-menu-item))
  (if t ;*editing-dialogs*
    (menu-item-enable item)
    (menu-item-disable item)))

(defmethod add-edit-menu-item ((menu menu))
  (add-menu-items
   menu
   (make-instance 'menu-item
                  :menu-item-title "Edit Menubar"
                  :menu-item-action #'(lambda ()
                                        (edit-menubar)))))

(defmethod add-guide-items ((menu menu))
  (add-menu-items
   menu
   (make-instance 'editing-dialog-menu-item
                  :menu-item-title "Add Horizontal Guide"
                  :menu-item-action 'add-horizontal-guide)
   (make-instance 'editing-dialog-menu-item
                  :menu-item-title "Add Vertical Guide"
                  :menu-item-action 'add-vertical-guide)))

(defmethod add-window-item ((menu menu))
  (add-menu-items
   menu
   (make-instance 'editing-dialog-menu-item
                  :menu-item-title "Edit Dialog"
                  :menu-item-action 'edit-dialog)))

(defmethod add-print-item ((menu menu))
  (add-menu-items
   menu
   (make-instance 'editing-dialog-menu-item
                  :menu-item-title "Print Dialog Source…"
                  :menu-item-action 'pprint-source)))


;; an alternative updater for a "Windows" menu.
;; sorts the windows alphabetically and puts a check-mark on the current front window.

; for now do this - maybe there should be different classes of windows-menu
#|
(defparameter *x-windows-menu* (make-instance 'menu :menu-title "Windows"
                                            :update-function 'ccl::alternate-update-windows-menu
                                            :help-spec '(values 1500 (1501 1 2 1 3))))

(menu-deinstall *windows-menu*)
(menu-install *x-windows-menu*)
OR 
(setf (menu-update-function *windows-menu*) 'ccl::alternate-update-windows-menu)
|#


(defun ccl::alternate-update-windows-menu (menu &aux menu-handle)
  (declare (optimize (speed 3)(safety 0)))
  (if *modal-dialog-on-top* 
    (menu-disable menu)
    (when (setq menu-handle (slot-value menu 'menu-handle))
      (menu-enable menu)
      (without-interrupts
       (let* ((nwins (length ccl::*window-object-alist*))
              (new-items (make-list nwins))
              (items (slot-value menu 'item-list))
              front)
         (declare (dynamic-extent new-items)(list new-items items))
         (let ((new-items new-items)
               (items items))
           (declare (list new-items items))
           (ccl::do-wptrs wptr
             (let* ((w (window-object wptr)))
               (when (and w (display-in-windows-menu w))
                 (let ((item (window-menu-item w)))
                   (when item
                     (if (window-shown-p w)
                       (progn 
                         (when (not front)
                           (setq front item))
                         (set-menu-item-style item :plain))
                       (progn (set-menu-item-style item :italic)
                              (menu-item-enable item)))
                     (rplaca new-items item)
                     (setq new-items (cdr new-items))
                     (setq items (cdr items))))))))
         (let ((sorted-new-items (delete-if #'null new-items)))
           (setq sorted-new-items (sort new-items #'string-lessp :key #'menu-item-title))
           (if (not (equal sorted-new-items items))
             (progn
               (dolist (item items)
                 (setf (slot-value item 'owner) nil)
                 ; always delete item 1 (they get "renumbered" !)
                 (#_DeleteMenuItem menu-handle 1))
               (setf (slot-value menu 'item-list) nil)
               (setq items nil)
               (dolist (item sorted-new-items)
                 (when item               ; windoid's & da-window's have no menu-item's
                   (add-menu-items menu item)
                   (when (eql #\CheckMark (menu-item-check-mark item))
                     (set-menu-item-check-mark item nil))
                   (if (not (slot-value item 'enabledp)) (menu-item-disable item))
                   )))
           (dolist (item sorted-new-items)
             (when (eql #\CheckMark (menu-item-check-mark item))
               (set-menu-item-check-mark item nil))))
         (when front 
           ;(setf (slot-value front 'enabledp) nil)
           (menu-item-enable front)
           (set-menu-item-check-mark front t))))))))


(init-design-menu)


#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
