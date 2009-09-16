
;;	Change History (most recent first):
;;  2 10/23/95 bill Remote download support
;;  3 1/11/95  akh  dont menu-install here - it wont work yet
;;  (do not edit before this line!!)

;projector-menus
;; 10/23/95 bill  enqueue-action-menu-item class, "Update from directory" sub-menu.
;; 01/10/95 alice move menu-install of *projector-menu* to projector-ui when it will work.
;; 01/23/92 gz   Don't bother eval-enqueing modify-read-only-file.
;;               Do bother eval-enqueing project unmounting.
;; 10/18/91 jaj  reorged and added a few menu items.  Dim menus when inappropriate.
;; 9/23/91 jaj  added unmount project menu-items
;; 8/23/91 jaj  minor changes to some names, call correct fns for checking in/out files

(in-package :ccl)

;; use a defvar so the user can set it in her preferences file

(defparameter *make-projects-menu* T)
(defvar *projector-menu*)
(defvar *projects-menu*)

(ignore-errors (menu-deinstall *projects-menu*))
(setq *projects-menu* (make-instance 'menu :menu-title "∏’s"))

(declaim (special ccl::*my-projects*))

(defclass enqueue-action-menu-item (menu-item) ())

(defmethod menu-item-action ((item enqueue-action-menu-item))
  (eval-enqueue `(funcall ',(menu-item-action-function item))))

(defun front-window-projector-file (&aux (window (front-window)))
  (typecase window
    (listener)
    (fred-window (window-filename window))
    (projector-file-info-window (gf-pathname window))))

(defclass projector-menu-item (menu-item)
  ((need-project :initarg :need-project :initform nil)
   (need-active :initarg :need-active :initform nil)
   (need-local-state :initarg :need-local-state :initform nil)
   (check-on-local-state :initarg :check-on-local-state :initform nil)))

(defun make-projector-menu-item (title action &rest rest &key need-local-state &allow-other-keys)
  (declare (dynamic-extent rest))
  (apply #'make-instance 'projector-menu-item
         :menu-item-title title :menu-item-action action
         :need-local-state (if
                             (keywordp need-local-state)
                             (list need-local-state)
                             need-local-state)
         rest))

(defun update-projector-menu (menu)
  (declare (special *mounted-projects*))
  (let* ((projects-mounted-p *mounted-projects*)
         (pathname (front-window-projector-file))
         (project (and pathname (pathname-project-p pathname)))
         (potential (and pathname (or project (guess-pathname-project pathname))))
         (state (and (or project potential)
                     (handler-case
                               (project-file-local-state project pathname)
                               (file-not-in-a-project ()
                                (setq project nil)
                                nil)))))
    (labels ((enable-menu-items (items)
               (dolist (item items)
                 (typecase item
                   (menu (enable-menu-items (menu-items item)))
                   (projector-menu-item
                    (with-slots (need-project need-active need-local-state check-on-local-state)
                                item
                      (if (macrolet ((implies (a b) `(or (not ,a) ,b)))
                            (and (implies need-project projects-mounted-p)
                                 (implies need-active project)
                                 (implies need-local-state potential)
                                 (implies need-local-state
                                          (memq state need-local-state))))
                        (menu-item-enable item)
                        (menu-item-disable item))
                      #+never
                      (when check-on-local-state
                        (set-menu-item-check-mark item (eq state check-on-local-state)))))))))
      (enable-menu-items (menu-items menu)))))


(defun enqueued-active-window-action (fn)
  (enqueued-action ((pathname (front-window-projector-file)))
    (funcall fn pathname)))

(defun enqueued-choose-file-action (fn string)
  (enqueued-action ((file (choose-file-dialog :button-string string)))
    (funcall fn file)))


(defparameter *other-active-menu*
  (make-instance
    'menu
    :menu-title "Other Active"
    :menu-items
    (list
     (make-projector-menu-item "File Info"
                               (enqueued-active-window-action 'show-file-info)
                               :command-key #\I
                               :need-active t)
     (make-projector-menu-item "Local Info"
                               (enqueued-active-window-action 'show-local-file-info)
                               :need-active t)
     (make-projector-menu-item "Checkout Info"
                               (enqueued-active-window-action 'show-remote-file-info)
                               :need-project t :need-active t)
     (make-instance 'menu-item :menu-item-title "-")
     (make-projector-menu-item "Cancel Checkout"
                               (enqueued-active-window-action 'file-cancel-checkout)
                               :need-local-state :checked-out :need-project t)
     (make-projector-menu-item "Cancel ModifyReadOnly"
                               (enqueued-active-window-action 'file-cancel-modro)
                               :need-local-state :modro :need-project t)
     (make-projector-menu-item "Orphan"
                               (enqueued-active-window-action 'file-orphan)
                               :need-active t)
     (make-instance 'menu-item :menu-item-title "-")
     (make-projector-menu-item "Get Latest Version"
                               (enqueued-active-window-action 'file-get-latest)
                               :need-local-state :checked-in :need-project t)
     (make-projector-menu-item "Get Other Version…"
                               (enqueued-active-window-action 'file-get-version)
                               :need-local-state :checked-in :need-project t)
     (make-instance 'menu-item
       :menu-item-title "Compare/Merge to File…"
       :menu-item-action (enqueued-action (merge-active-lisp-window-and-file))))))

(defparameter *project-info-menu*
  (make-instance 
    'menu
    :menu-title "ProjectInfo"
    :menu-items
    (list
     (make-projector-menu-item "Newer"
                               (enqueued-action (print-project-info :newer t :comments t))
                               :need-project t)
     (make-projector-menu-item "Latest with Comments"
                               (enqueued-action (print-project-info :latest t :comments t))
                               :need-project t)
     (make-projector-menu-item "Currently Checked Out"
                               (enqueued-action (print-project-info :checked-out t  :comments t))
                               :need-project t)
     (make-projector-menu-item "Short Latest"
                               (enqueued-action (print-project-info :short t :latest t))
                               :need-project t)
     (make-projector-menu-item "Project Log"
                               (enqueued-action (print-project-info :log t))
                               :need-project t)
     ;;; get info on all modifiable files in user checkout out directories
     (make-projector-menu-item "Modifiable on my disk"
                               (enqueued-action (describe-modifiable-files)))
     ;; get comments between a period of time. Hai Wang 7/7/93
     (make-projector-menu-item "Report…"
                               (enqueued-action (make-report)))
     )))

(defparameter *other-file-menu*
  (make-instance 
    'menu 
    :menu-title "Other File"
    :menu-items
    (list
     (make-projector-menu-item "File Info…"
                               (enqueued-choose-file-action 'show-file-info "File Info")
                               :need-project t)
     (make-projector-menu-item "Local Info…"
                               (enqueued-choose-file-action
                                'show-local-file-info "Local Info"))
     (make-projector-menu-item "Checkout Info…"
                               (enqueued-choose-file-action
                                'show-remote-file-info "Checkout Info")
                               :need-project t)
     (make-instance 'menu-item :menu-item-title "-")
     (make-projector-menu-item "Checkout…"
                               (enqueued-choose-file-action 'file-checkout "Check Out")
                               :need-project t)
     (make-projector-menu-item "Checkin…"
                               (enqueued-choose-file-action 'file-checkin "Check In")
                               :need-project t)
     (make-projector-menu-item "Checkin No Comment…"
                               (enqueued-choose-file-action 
                                #'(lambda (file)
                                    (file-checkin file :no-comment t))
                                "Check In")
                               :need-project t)
     
     (make-projector-menu-item "New Project Files…"
                               (enqueued-action (checkin-new))
                               :need-project t)
     (make-projector-menu-item "ModifyReadOnly…"
                               (enqueued-choose-file-action 'file-modro "ModRO"))
     (make-instance 'menu-item :menu-item-title "-")
     (make-projector-menu-item "Cancel Checkout…"
                               (enqueued-choose-file-action 'file-cancel-checkout "UnCheckout")
                               :need-project t)
     (make-projector-menu-item "Cancel ModifyReadOnly…"
                               (enqueued-choose-file-action 'file-cancel-modro "UnModRO")
                               :need-project t)
     (make-projector-menu-item "Orphan…"
                               (enqueued-choose-file-action 'file-orphan "Orphan"))
     (make-projector-menu-item "Delete…"
                               (enqueued-choose-file-action 'file-delete "Delete")
                               :need-project t)
     (make-instance 'menu-item :menu-item-title "-")
     (make-projector-menu-item "Get Latest Version…"
                               (enqueued-choose-file-action 'file-get-latest "Get Latest")
                               :need-project t)
     (make-projector-menu-item "Get Other Version…"
                               (enqueued-choose-file-action 'file-get-version "Version…")
                               :need-local-state :checked-in :need-project t))))

(defparameter *scan-project-files-menu-item*
  (make-instance 'menu-item :menu-item-title "Scan Project Files"
                 :menu-item-action (enqueued-action (scan-project-files))))

(ignore-errors (menu-deinstall *projector-menu*))
(setq *projector-menu*
  (make-instance 'menu
    :update-function 'update-projector-menu
    :menu-title "Sourceserver"
    :menu-items
    (list
     (make-projector-menu-item "Checkout Active"
                               (enqueued-active-window-action 'file-checkout)
                               :need-local-state '(:checked-in :modro) :need-project t
                               :check-on-local-state :checked-out)
     (make-projector-menu-item "Checkin Active"
                               (enqueued-active-window-action 'file-checkin)
                               :need-local-state '(:checked-out :modro nil) :need-project t
                               :check-on-local-state :checked-in)
     (make-projector-menu-item "ModifyReadOnly Active"
                               #'(lambda () (let ((path (window-filename (front-window))))
                                              (file-modro path)))
                               ;:need-active t
                               :need-local-state  :checked-in
                               :check-on-local-state :modro)
     *other-active-menu*
     (make-instance 'menu-item :menu-item-title "-")
     
     ;; Want to be able to mount selected projects or all of them. Modification is done 
     ;; in #'mount-all-projects.  Hai Wang 7/8/93
     (make-projector-menu-item "Mount projects…"
                               (enqueued-action (mount-all-projects)))
     (make-projector-menu-item "New Project"
                               (enqueued-action (new-project)))
     (make-projector-menu-item "Update All Projects"
                               (enqueued-action (checkoutNewerAll))
                               :need-project t)
     (make-projector-menu-item "Checkin All Projects"
                               (enqueued-action (check-in-all))
                               :need-project t)
     (make-projector-menu-item "Unmount All Projects"
                               (enqueued-action (unmount-all-projects))
                               :need-project t)
     (make-instance 'menu-item :menu-item-title "-")
     (make-projector-menu-item "Update Current Project"
                               (enqueued-action (CheckoutNewerCur))
                               :need-project t)
     (make-projector-menu-item "Checkin Current Project"
                               (enqueued-action (check-in-current-project))
                               :need-project t)
     (make-projector-menu-item "Unmount Current Project"
                               (enqueued-action (unmount-current-project))
                               :need-project t)
     (make-instance 'menu-item :menu-item-title "-")
     (make-instance 'menu
       :menu-title "Update from directory"
       :menu-items (list (make-instance 'enqueue-action-menu-item
                           :menu-item-title "via AppleTalk…"
                           :menu-item-action 'update-from-directory)
                         (make-instance 'enqueue-action-menu-item
                           :menu-item-title "via FTP (Anarchie)…"
                           :menu-item-action 'anarchie-update-from-directory)
                         (make-instance 'enqueue-action-menu-item
                           :menu-item-title (format nil "Create ~s…" *projector-versions-filename*)
                           :menu-item-action
                           #'(lambda ()
                               (make-projector-versions-file
                                (choose-directory-dialog
                                 :directory *update-from-directory-target*))))
                         (make-instance 'enqueue-action-menu-item
                           :menu-item-title "Create upload directory…"
                           :menu-item-action 'create-upload-directory)))
     (make-instance 'menu-item :menu-item-title "-")
     *project-info-menu*
     *other-file-menu*
     (make-instance 'menu-item :menu-item-title "-")
     (make-instance 'menu-item
       :menu-item-title "Merge Directories"
       ::menu-item-action 'choose-and-merge-directories)
     *scan-project-files-menu-item*
     ;(make-instance 'menu-item :menu-item-title "-")
     )))


;(menu-install *projector-menu*)

#|
	Change History (most recent last):
	4	1/23/92	gz	non-blocking Modro Active
	5	3/12/92	ows	use enqueued-command to set up dialogs immediately; factor out code
	6	3/25/92	ows	Adds the Leibniz-version menu item here, not in mpw-command
				Decide whether you're a Leibniz implementor according to *my-projects*, not the current zone.
				Change the scheme for updating menu items
	7	3/27/92	ows	no longer require ccl::*my-projects* to be bound when this file is loaded
	8	4/3/92	ows	call the new checkin/checkout commands
				remove the menus before adding them again (for loading the file twice)
	9	4/3/92	ows	make the menu items smarter
	10	4/3/92	ows	fix menu update routine for unlabeled front-windows
	10	4/4/92	ows	new windows confused the menu update fn
	12	4/7/92	ows	cleaned up directory scanning
				removed confusing check marks
	14	4/16/92	ows	fix update for non-project windows
	1	9/28/93	HW	Now it's in RSTAR SourceServer.
	2	2/28/94	akh	No :recursive arg to print-project-info.
	2	3/28/94	akh	Make ModifyReadOnlyActive work when project not mounted.
	3	3/29/94	akh	Again
	4	4/11/94	akh	Remove the dash at the end of the menu
	5	5/3/94	akh	added delete to other files menu - deletes file from project
	2	12/22/94	akh	none
|# ;(do not edit past this line!!)
