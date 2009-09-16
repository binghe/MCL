
;;	Change History (most recent first):
;;  8 10/31/95 Bill St. Clair Move *global-comment* before all uses
;;  6 10/24/95 bill Fix bugs in remote-download code
;;  5 10/23/95 bill Remote download support
;;  4 10/13/95 bill This time for sure
;;  3 10/13/95 bill ccl3.0x25
;;  2 10/13/95 bill 3.0x25
;;  4 5/15/95  akh  fix map-pathname-windows per Kalmans report
;;  3 4/11/95  akh  use *tool-back-color*, add :content-color where needed
;;  2 4/4/95   akh  stop trying to outsmart fred. Fred knows best.
;;  17 3/20/95 akh  dont remember - twas trivial
;;  16 2/9/95  akh  probably no change
;;  15 2/6/95  akh  check-in-projects does modro on local disk vs: checkout modifiable because we hate true checkout.
;;                  Default button for mount projects is "Mount All"
;;                  Default button for checkout or modro is modro.
;;  14 2/3/95  akh  in file-cancel-checkout - compare name with *user* not initials
;;  13 1/25/95 akh  add colors, newproject dialog somewhat less confusing
;;                  and doesnt ask if local directory already exists (in "sslocal:")
;;
;;  12 1/17/95 akh  we seem to have lost the "No comment" button
;;  11 1/17/95 akh  use without-event-processing
;;  10 1/11/95 akh  some merge was messed up
;;  8 1/11/95  akh  move (menu-install *projector-menu*) here, window-show nil for select-projects
;;  (do not edit before this line!!)

;; 
;; 11/3/95 bill   add "Global" button to comment-dialog. It sets *global-comment*, which
;;                causes check-in-projects to use that comment for the rest of the files.
;; 10/24/95 bill  set-checkin-categories-action enqueues its actions
;; 10/23/95 bill  update checkoutNewerAll & CheckoutNewerCur for new arglist to check-out-projects.
;;                check-out-projects now handles updating from a directory.
;; 10/13/95 bill  file-checkin preserves the write date across adding hte checking comment
;;                changed *lock-file-name* to "version".
;;                check-in-projects no longer deletes the *lock-file-name* from the files
;;                to be checked in. It does make it be checked in last, which was the
;;                code's intention.
;; 11/12/95 bill  file-checkout-or-modro can now return nil to mean "leave it read-only"
;; 3/24/94 akh 'character => 'base-character

;;;; The more user-interface oriented parts of the source code control system:
;;;; dialogs, menus, window manipulation functions, and the high-level
;;;; source code control functions that tie all these together with the
;;;; low-level functions (in project and projector).
;;;;
;;;; Parts of this used to live in projector.lisp
;;;;
;;;; @@@ perhaps there ought to be a project-ui mixin to the project class;
;;;; then there wouldn't need to be separate functions with separate names
;;;; for the versions of these that manipulate the user interface

(in-package :ccl)
;(require "PROJECT")
;(require "PROJECTOR")

;;;
;;; Global variables
;;;

(defvar ccl::*save-all-old-projector-versions* nil)
(defvar ccl::*scan-on-mount* t)
;;; Let the user choose scan or not. It is put in the dialog box when mounting.
;;; Hai Wang 7/9/93
(setf ccl::*scan-on-mount* nil)  ; Do NOT scan when mounting initially.

(defvar *current-project* nil)
(defvar *break-on-projector-errors* nil)
(declaim (special *projects-menu* *projector-menu* *scan-project-files-menu-item*
                   ccl::*my-projects*))

#|
;; the following parameter should be defined to the appropriate value in init.lisp
;;; e.g., a reasonable entry in your init.lisp might be:

(setf ccl::*my-projects*
  '(("Sources:Ralph:Projects:" "Newton:")
    ("Sources:Ralph:Environment:" "Environment:")))

|#

;; @@@ this is a terrible, terrible kludge
(defun my-projects ()
  (declare (special ccl::*my-projects*))
  (loop
    (when (boundp 'ccl::*my-projects*)      
      (return ccl::*my-projects*))
    (cerror "Use new value for ~s."
            "The variable ~s must be initialized."
            'ccl::*my-projects*)))

(defparameter *lockfile-name* "version.lisp")

(defvar *last-checkout-comment* "")


;;;
;;; Window utility functions
;;;

(defun map-pathname-windows (fn pathname)
  (setq pathname (full-pathname pathname))
  (map-windows #'(lambda (window &aux (window-filename (window-filename window)))
                   (and window-filename
                        (equalp (full-pathname window-filename) pathname)
                        (funcall fn window)))
               :class 'fred-window :include-invisibles t))



(defun pathname-window (path)
  (do-pathname-windows (window path) (return-from pathname-window window))
  nil)

(defun y-or-n-or-other-dialog (message &key (size #@(318 145))
                                       (position (list :top (+ 2 *menubar-bottom*)))
                                       (yes-text "Yes")
                                       (no-text "No")
                                       (other-text "Other")
                                       (cancel-text "Cancel")
                                       help-spec)
  (modal-dialog
   (make-instance 'ccl::keystroke-action-dialog
          :window-type :double-edge-box
          :view-size size
          :view-position position
          :window-show nil
          :help-spec (getf help-spec :dialog)
          :view-subviews
          `(
            ,(make-dialog-item 'static-text-dialog-item
               #@(20 12) (subtract-points size #@(38 72))
               message nil :help-spec (getf help-spec :dialog))
            ,(make-dialog-item 'default-button-dialog-item               
              (subtract-points size #@(102 27))
               #@(74 18) yes-text
               #'(lambda (item) 
                   (declare (ignore item))
                   (return-from-modal-dialog :yes))
               :help-spec (getf help-spec :yes-text))
            ,(make-dialog-item 'button-dialog-item
               (subtract-points size #@(102 53))
               #@(74 18) no-text
               #'(lambda (item)
                   (declare (ignore item))
                   (return-from-modal-dialog :no))
               :help-spec (getf help-spec :no-text))
            ,(make-dialog-item 'button-dialog-item
               (subtract-points size #@(200 27))
               #@(74 18) other-text
               #'(lambda (item)
                   (declare (ignore item))
                   (return-from-modal-dialog :other))
               :help-spec (getf help-spec :other-text))
            ,(make-dialog-item 'button-dialog-item
               (if cancel-text
                   ;(subtract-points size #@(102 77))
                 (make-point 25 (- (point-v size) 27))
                   #@(5000 5000))          ;off screen
               #@(74 18) (or cancel-text "")
               #'(lambda (item)
                   (declare (ignore item)) 
                   (return-from-modal-dialog :cancel))
               :help-spec (getf help-spec :cancel-text))))))
;(y-or-n-or-other-dialog "message")

(defun file-checkout-or-modro (path)
  (case (y-or-n-or-other-dialog
         (format nil "~/pp-path/ is not modifiable." path) :yes-text "ModRO"
         :no-text "CheckOut" :other-text "ReadOnly")
    (:no (file-checkout path) t)
    (:yes (file-modro path) t)
    (:other nil)))

;;let people know when they try to modify a read-only file
(defun help-on-attempt-to-modify-readonly-buffer (window)
  (let ((path (window-filename window)))
    (if (pathname-project-p path)
      (file-checkout-or-modro path "You are attempting to modify a read-only buffer controlled by Projector. The file should be checked out or set to ModifyReadOnly mode.")
      (ed-beep))))

(defun set-path-windows-readonly-state (path state message &key revert)
  (do-pathname-windows (window path)
    (when revert
      (setf (read-only-state window) #.$ckid-readwrite)
      (window-revert window t))
    (setf (read-only-state window)
          (getf '(:read-only #.$ckid-readonly
                  :modify-read-only #.$ckid-modifyreadonly
                  :read-write #.$ckid-readwrite) state))
    (when message
      (set-mini-buffer window message))))

#| ; let fred do this for you
(defmacro with-editor-excursion (window &body body)
  (let ((scroll-pos (gensym "SCROLL-POS"))
        (selection-start (gensym "SELECTION-START"))
        (selection-end (gensym "SELECTION-END")))
    `(let ((,scroll-pos (buffer-position (fred-display-start-mark ,window))))
       (multiple-value-bind (,selection-start ,selection-end)
                            (selection-range ,window)
         ,@body
         ;; @@@ check that these values are still in range
         (set-selection-range ,window ,selection-start ,selection-end) ; this should return to current pos
         (set-mark (fred-display-start-mark ,window) ,scroll-pos)))))
|#

;;;
;;; Projects menu
;;;

;; alice added
(defclass project-menu-item (menu-item)
  ((project :initarg :project :accessor menu-item-project)))

;; alice added
(defmethod menu-item-action ((item project-menu-item))
  (set-current-project (menu-item-project item)))

;; alice added
(defun find-projects-menu-item (menu project)
  (dolist (item (menu-items menu))
    (when (eq project (menu-item-project item))
      (return item))))

;;; put check-mark next to the current project
(defun projector-menu-update ()
  (let ((current *current-project*))
    (dolist (item (menu-items *projects-menu*))
      (set-menu-item-check-mark item nil))
    (when current
      (let ((item (find-projects-menu-item *projects-menu* current)))
        (when item ; if its not on menu maybe shouldnt be current either.
          (set-menu-item-check-mark item t))))))

;;; add items to the Projector menu that list each mounted project and selecting that item
;;; will set that as the current project.
;;; Now titles of subprojects are indented by depth (alice) 
(defun make-projects-menu ()
  (menu-install *projects-menu*)
  (apply #'remove-menu-items *projects-menu* (menu-items *projects-menu*))
  ;; @@@ ought to be able to use *projects*
  (dolist (project *mounted-projects*)
    (unless nil ;(find-menu-item *projects-menu* name)
      (add-new-item *projects-menu* 
                    (indented-project-name project)
                    nil
                    :class 'project-menu-item
                    :project project))))

;; alice added
(defun indented-project-name (project)
  (let* ((depth (project-depth project))
         (name (project-name project)))
    (if (eq depth 0) 
      name 
      (concatenate 'string (make-string depth :initial-element #\space)
                   name))))
    

;;;
;;; Filenames in Projector menu
;;;

(defun find-or-open-pathname (path)
  (let ((window (pathname-window path)))
    (if window
      (window-select window)
      (if (eq :TEXT (mac-file-type path))
        (make-instance *default-editor-class* :filename path)
        (message-dialog (format nil "~/pp-path/ is not a text file" path))))))

(defclass project-file-menu-item (menu-item)
  ((pathname :accessor menu-item-pathname :initarg :pathname)
  (checkout-state :accessor menu-item-checkout-state :initarg :checkout-state)))

(defmethod menu-item-title ((item project-file-menu-item))
  (concatenate 'string
               (case (menu-item-checkout-state item)
                 (:modro "* ")
                 (:checked-out "+ ")
                 (t "  "))
               (file-namestring (menu-item-pathname item))))

(defmethod initialize-instance ((item project-file-menu-item) &rest initargs)
  (apply #'call-next-method item initargs)
  (setf (slot-value item 'ccl::title) (menu-item-title item)))

(defmethod menu-item-action ((item project-file-menu-item))
  (find-or-open-pathname (menu-item-pathname item)))

(defun find-project-file-menu-item (path)
  (dolist (item (menu-items *projector-menu*) nil)
    (when (and (typep item 'project-file-menu-item)
               (equalp (menu-item-pathname item) path))
      (return item))))

(defun insert-menu-item (menu item position)
  (let* ((all-items (menu-items menu))
         (after-items (nthcdr position all-items)))
    (apply #'remove-menu-items menu after-items)
    (apply #'add-menu-items menu item after-items)))

(defun add-filename-to-projector-menu (path checkout-state)
  (unless (find-project-file-menu-item path)
    (let ((namestring (file-namestring path)))
      (insert-menu-item
       *projector-menu*
       (make-instance 'project-file-menu-item :pathname path :checkout-state checkout-state) 
       (1+ (position-if #'(lambda (item)
                            (let ((title (menu-item-title item)))
                              (or (string-equal "-" title)
                                  (string-greaterp namestring (subseq title 2)))))
                        (menu-items *projector-menu*) :from-end t))))))

(defun maybe-add-filename-menu (file)
  (let ((state (project-file-local-state (pathname-project file) file)))
    (when (and (pathname-project-p file)
               (member state '(:modro :checked-out)))
      (add-filename-to-projector-menu file state))))

(defun remove-filename-from-projector-menu (path)
  (remove-menu-items *projector-menu* (find-project-file-menu-item path)))

(defun update-projector-file-state (path &optional (remote-changed t))
  (remove-filename-from-projector-menu path)
  (maybe-add-filename-menu path)
  (close-checkin-categories-dialog)
  (let ((window (find-file-info-window path)))
    (when window
      (invalidate-view window)
      (update-file-info-window window remote-changed))))

(defun remove-all-filename-menus (&optional project)
  (apply #'remove-menu-items *projector-menu*
         (remove-if-not #'(lambda (item)
                            (and (typep item 'project-file-menu-item)
                                 (or (null project)
                                     (eq (pathname-project (menu-item-pathname item)) project))))
                        (menu-items *projector-menu*))))

;;;
;;; Dialogs
;;;

#|
;; Same as y-or-n-dialog, except only two buttons and one of them cancels.
(defun okay-or-cancel-dialog (message &key (size #@(250 200))
                                   (position (list :top (+ 2 *menubar-bottom*)))
                                   (okay-text "Okay")
                                   (cancel-text "Cancel")
                                   help-spec)
  (modal-dialog
   (make-instance 'ccl::keystroke-action-dialog
          :window-type :double-edge-box
          :view-size size
          :view-position position
          :window-show nil
          :help-spec (getf help-spec :dialog)
          :view-subviews
          `(
            ,(make-dialog-item 'static-text-dialog-item
               #@(20 12) (subtract-points size #@(38 72))
               message nil :help-spec (getf help-spec :dialog))
            ,(make-dialog-item 'default-button-dialog-item               
              (make-point 20 (- (point-v size) 30))
               #@(74 18) okay-text
               #'(lambda (item) 
                   (declare (ignore item))
                   (return-from-modal-dialog t))
               :help-spec (getf help-spec :okay-text))
            ,(make-dialog-item 'button-dialog-item
               (subtract-points size #@(#.(+ 20 74) 30))
               #@(74 18) cancel-text
               #'(lambda (item)
                   (declare (ignore item))
                   (return-from-modal-dialog :cancel))
               :help-spec (getf help-spec :cancel-text))))))
|#

;;;
;;; Hai made some changes on it because we are all farmiliar with the "OK" button
;;; on the right and the "Cancel" button on the left.
;;;
(defun okay-or-cancel-dialog (message &key (size #@(300 200))
                                   (position (list :top (+ 6 *menubar-bottom*)))
                                   (okay-text "OK")
                                   (cancel-text "Cancel")
                                   help-spec)
  (modal-dialog
   (make-instance 'ccl::keystroke-action-dialog
          :window-type :movable-dialog
          :window-title ""
          :back-color *tool-back-color*
          :view-size size
          :view-position position
          :window-show nil
          :help-spec (getf help-spec :dialog)
          :view-subviews
          `(
            ,(make-dialog-item 'static-text-dialog-item
               #@(20 12) (subtract-points size #@(38 72))
               message nil :help-spec (getf help-spec :dialog))
            ,(make-dialog-item 'default-button-dialog-item               
              (subtract-points size #@(#.(+ 20 74) 30))
               #@(72 20) okay-text
               #'(lambda (item) 
                   (declare (ignore item))
                   (return-from-modal-dialog t))
               :help-spec (getf help-spec :okay-text))
            ,(make-dialog-item 'button-dialog-item
               (make-point 20 (- (point-v size) 30))
               #@(72 20) cancel-text
               #'(lambda (item)
                   (declare (ignore item))
                   (return-from-modal-dialog :cancel))
               :help-spec (getf help-spec :cancel-text))))))

(defun cancel-checkout-dialog (path)
  (modal-dialog
   (make-instance 'dialog
     :window-type :movable-dialog
     :window-title ""
     :back-color *tool-back-color*
     :window-show nil
     :view-position '(:top 100)
     :view-size #@(428 150)
     :view-subviews
     (list (make-dialog-item 'static-text-dialog-item #@(16 7) #@(402 100)
                             (format nil "Cancel checkout for ~/pp-path/ and:~
                                          ~%¥ Keep changes and convert to ModifyReadOnly.~
                                          ~%¥ Throw away changes and retrieve latest version."
                                     path))
           (make-dialog-item 'button-dialog-item #@(16 120) #@(62 16)
                             "Cancel"
                             #'(lambda (item) (declare (ignore item))
                                (return-from-modal-dialog :cancel)))
           (make-dialog-item 'button-dialog-item #@(140 120) #@(110 16)
                             "Keep Changes" 
                             #'(lambda (item)
                                 (declare (ignore item))
                                 (return-from-modal-dialog t))
                             :default-button t)
           (make-dialog-item 'button-dialog-item #@(290 120) #@(120 16)
                             "Throw Away" 
                             #'(lambda (item) 
                                 (declare (ignore item))
                                 (return-from-modal-dialog nil)))))))

;(cancel-checkout-dialog (pathname (front-window)))
   
#|
(defun center-size-in-screen (size-point)
  (let* ((x (truncate (- *screen-width* (point-h size-point)) 2))
         (y (max 44 (- (truncate *screen-height* 3) (point-v size-point)))))
    (make-point x y)))
|#

#|
;;; Following code opens a dialog to ask user for a comment
(defun comment-dialog (file &optional (initial-comment ""))
  (let* ((view-size #@(362 172))
         (c-dialog
          (make-instance 'color-dialog
            :window-type :double-edge-box
            :window-title "Projector Comment"
            :view-position '(:top 44)
            :view-size view-size
            :window-show nil
            :view-subviews
            (list
             (make-dialog-item 'static-text-dialog-item
                               #@(10 10) #@(300 16)
                               "What are your changes to:")
             (make-dialog-item 'static-text-dialog-item
                               #@(10 26) nil (namestring file)
                               )
             (make-dialog-item 'editable-text-dialog-item
                               #@(10 50) #@(340 80) initial-comment nil
                               :view-nick-name 'replace-text-item
                               :allow-returns t :WRAP-P T)
             (make-dialog-item 'button-dialog-item
                               #@(90 145) #@(70 20)  "OK"
                               #'(lambda (item)
                                   (let ((my-dialog (view-container item)))
                                     (return-from-modal-dialog
                                      (dialog-item-text (view-named 'replace-text-item my-dialog)))))
                               ;; should not default if <CR> doesn't actuate
                               :default-button t  
                               )
             (make-dialog-item 'button-dialog-item
                               #@(180 145) #@(70 20)  "Cancel"
                               #'(lambda (item)
                                   (declare (ignore item))
                                   (return-from-modal-dialog :cancel)))))))
    (modal-dialog c-dialog)))
|#

(defvar *global-comment* nil)

;;;
;;; For the same reason, we put the "OK" button on the right.
;;; Hai Wang. 7/7/93
;;;
;;; Also added a field for the user to change the initials if modification is done somewhere
;;; else on another persons machine. The change is optional.
;;; Hai Wang. 7/7/93


;;;
(defun comment-dialog (file &optional (initial-comment ""))
  (let* ((view-size #@(400 205))
         (result)
         (c-dialog
          (make-instance 'color-dialog
            ;:window-type :double-edge-box
            :window-title "Projector Comment"
            :back-color *tool-back-color*
            :view-position '(:top 44)
            :view-size view-size
            :window-show nil
            :close-box-p nil
            :view-subviews
            (list
             (make-dialog-item 'static-text-dialog-item
                               #@(10 10) #@(300 16)
                               "What are your changes to:")
             (make-dialog-item 'static-text-dialog-item
                               #@(10 26) nil (namestring (back-translate-pathname file))
                               )
             (make-instance 'scrolling-fred-view
                               :view-position #@(10 50) 
                               :view-size #@(360 70) 
                               :dialog-item-text initial-comment
                               :view-nick-name 'replace-text-item
                               :allow-returns t :WRAP-P T)
             (make-dialog-item 'static-text-dialog-item
                               #@(10 143) #@(90 16)
                               "Your initials:")
             (make-dialog-item 'editable-text-dialog-item
                               #@(105 143) #@(245 16) *user-initials* 
                               #'(lambda (item)
                                   (setf *user-initials* (dialog-item-text item)))
                               :view-nick-name 'initials
                               :allow-returns nil :WRAP-P nil)
             (make-dialog-item 'button-dialog-item
                               #@(280 172) #@(70 20)  "OK"
                               #'(lambda (item)
                                   (let* ((my-dialog (view-container item))
                                          (text (dialog-item-text (view-named 'replace-text-item my-dialog))))
                                     (window-close my-dialog)                                     
                                     (setq result text)))
                               :default-button t)
             (make-dialog-item 'button-dialog-item
                               #@(200 172) #@(70 20)  "Cancel"
                               #'(lambda (item)
                                   (let ((w (view-window item)))
                                     (window-close w)
                                     ; <<<this is probably wrong - fix it later
                                     (setq result :cancel))))
             (make-dialog-item 'button-dialog-item
                                #@(90 172) #@(90 20)  "No Comment"
                               #'(lambda (item)
                                   (let ((w (view-window item)))
                                     (window-close w)
                                     ; <<<this is probably wrong - fix it later
                                     (setq result :no-comment))))
             (make-dialog-item 'button-dialog-item
                                #@(10 172) #@(70 20)  "Global"
                               #'(lambda (item)
                                   (let* ((my-dialog (view-container item))
                                          (text (dialog-item-text (view-named 'replace-text-item my-dialog))))
                                     (window-close my-dialog)
                                     (setq *global-comment* text)
                                     (setq result text))))))))
    (window-show  c-dialog)
    (with-event-processing-enabled ;let-globally ((*processing-events* nil))
        (loop 
          (event-dispatch t)
          (when result
            (return result))))))

(defclass secret-editable-text (editable-text-dialog-item)
  ((secret-string :accessor secret-string
               :initform (make-array '(0) :element-type 'base-character :fill-pointer t :adjustable t))))

(defmethod view-key-event-handler ((item secret-editable-text) char)
  (call-next-method item #\¥)
  (let ((string (secret-string item)))
    (if (eq char #\backspace)
      (setf (fill-pointer string) (max 0 (1- (fill-pointer string))))
      (vector-push-extend char string))))

(defun volume-server-alist ()
  (declare (special ccl::*volume-server-alist*))
  (and (boundp 'ccl::*volume-server-alist*)
       ccl::*volume-server-alist*))

#|
;;; Useful code from Guillame CartiŽr
(defconstant $zoneNameOffset      24)
(defconstant $serverNameOffset    57)
(defconstant $volNameOffset       89)
(defconstant $userNameOffset     117)
(defconstant $userPassWordOffset 147)
(defconstant $volPassWordOffset  158)

(defun remote-mount (zone server user password volume
                          &optional (volpass ""))
  (rlet ((afp :AFPVolMountInfo
              :length 167
              :media :|afpm|
              :flags 0
              :nbpInterval 5
              :nbpCount 10
              :uamType 6
              :zoneNameOffset     $zoneNameOffset
              :serverNameOffset   $serverNameOffset
              :volNameOffset      $volNameOffset
              :userNameOffset     $userNameOffset
              :userPassWordOffset $userPassWordOffset
              :volPassWordOffset  $volPassWordOffset))
    (%put-string afp zone     $zoneNameOffset)
    (%put-string afp server   $serverNameOffset)
    (%put-string afp volume   $volNameOffset)
    (%put-string afp user     $userNameOffset)
    (%put-string afp password $userPassWordOffset)
    (%put-string afp volpass  $volPassWordOffset)
    (rlet ((pb :ParamBlockRec
               :ioCompletion (%null-ptr)
               :ioBuffer afp))
      (#_PBVolumeMount pb))))
|#


(defun user-mount-volume (volume &key zone server)
  (declare (special ccl::*user-initials*))
  (let* ((guestp nil)
         (user-name (or (ccl::chooser-name)
                        (and (boundp 'ccl::*user-initials*) ccl::*user-initials*)
                        ""))
         (password "")
         (password-item
          (make-dialog-item 'secret-editable-text #@(104 205) #@(65 17) ""
                            #'(lambda (item) (setq password (secret-string item)))))
         (disappearing-items
          (list           
           (make-dialog-item 'static-text-dialog-item #@(26 179) #@(71 16) "Name:")
           (make-dialog-item 'static-text-dialog-item #@(26 206) #@(73 16) "Password:" nil)
           (make-dialog-item 'editable-text-dialog-item #@(104 178) #@(263 17) user-name
                             #'(lambda (item) (setq user-name (dialog-item-text item))))
           password-item)))
    (let ((ass (assoc volume (volume-server-alist) :test #'string-equal)))
      (setq zone (or zone (cadr ass) "")
            server (or server (caddr ass) "")))
    (let ((dialog
           (make-instance 'dialog
             :window-type :movable-dialog
             :window-title ""
             :back-color *tool-back-color*
             :content-color *tool-back-color*
             :view-position '(:top 150)
             :view-size #@(377 283)
             :close-box-p nil
             :view-font '("Chicago" 12 :srcor :plain)
             :window-show nil
             :view-subviews
             (append
              (list (make-dialog-item
                     'static-text-dialog-item #@(5 5) #@(255 16) "Connect to shared disk in:")
                    (make-dialog-item 'static-text-dialog-item #@(23 33) #@(48 16) "Zone:")
                    (make-dialog-item 'editable-text-dialog-item #@(81 33) #@(186 17) zone
                                      #'(lambda (item) (setq zone (dialog-item-text item))))
                    (make-dialog-item 'static-text-dialog-item #@(23 61) #@(51 16) "Server:")
                    (make-dialog-item 'editable-text-dialog-item #@(81 61) #@(186 17) server
                                      #'(lambda (item) (setq server (dialog-item-text item))))
                    (make-dialog-item 'static-text-dialog-item #@(23 88) #@(56 16) "Volume:")
                    (make-dialog-item 'editable-text-dialog-item #@(81 87) #@(186 17) volume
                                      #'(lambda (item) (setq volume (dialog-item-text item))))
                    (make-dialog-item 'radio-button-dialog-item #@(23 125) #@(72 16) "Guest"
                                      #'(lambda (item)
                                          (setq guestp t)
                                          (apply #'remove-subviews (view-container item) disappearing-items)))
                    (make-dialog-item 'radio-button-dialog-item #@(23 143) #@(167 16) "Registered User"
                                #'(lambda (item)
                                    (setq guestp nil)
                                    (apply #'add-subviews (view-container item) disappearing-items))
                                :radio-button-pushed-p t)
                    (make-dialog-item 'button-dialog-item #@(295 253) #@(62 16) "OK"
                                      #'(lambda (item) (declare (ignore item)) (return-from-modal-dialog t)) :default-button T)
              (make-dialog-item 'button-dialog-item #@(23 253) #@(62 16) "Cancel"
                                #'(lambda (item) (declare (ignore item)) (return-from-modal-dialog :cancel))))
              disappearing-items))))
      (set-current-key-handler dialog password-item)
      (modal-dialog dialog))
    (let ((place (concatenate 'string zone (if (or (eq 0 (length zone))(find #\: zone)) "" ":")
                              server (if (or (eq 0 (length server))(find #\: server)) "" ":")
                              volume)))
      ; this doesnt work for sourceserver - maybe sourceserver is broken
      (if guestp
        (mpw-mount-volume place)
        (mpw-mount-volume place :user user-name :password password))))
  (let ((time (get-universal-time)))
    (loop
      (if (probe-file volume) (return))
      (event-dispatch t)
      (if (> 10 (- (get-universal-time) time))
        (error "Timeout mounting volume: ~s" volume)))))


;;;
;;; This dialog is for the report of a project
;;; Hai Wang 7/7/93
;;;
(defun report-dialog ()
  (let* ((start-date "")
         (end-date "")
         (start-exclusive nil)
         (end-exclusive nil)
         (dialog
          (make-instance 'color-dialog
            :window-type :movable-dialog
            :window-title ""
            :back-color *tool-back-color*
            :content-color *tool-back-color*
            :view-position '(:top 60)
            :view-size #@(300 150)
            :close-box-p nil
            :view-font '("Chicago" 12 :srcor :plain)
            :view-subviews
            (list (make-dialog-item
                   'static-text-dialog-item
                   #@(13 46)
                   #@(40 16)
                   "From:"
                   'nil)
                  (make-dialog-item
                   'editable-text-dialog-item
                   #@(57 46)
                   #@(129 16)
                   ""
                   #'(lambda (item)
                       (setf start-date (dialog-item-text item)))
                   :allow-returns
                   nil)
                  (make-dialog-item
                   'check-box-dialog-item
                   #@(203 46)
                   #@(83 16)
                  "Exclusive"
                  #'(lambda (item)
                      (setf start-exclusive (check-box-checked-p item))))
                 (make-dialog-item
                  'static-text-dialog-item
                  #@(14 84)
                  #@(23 16)
                  "To:"
                  'nil)
                 (make-dialog-item
                  'editable-text-dialog-item
                  #@(57 84)
                  #@(128 16)
                  ""
                  #'(lambda (item)
                      (setf end-date (dialog-item-text item)))
                  :allow-returns
                  nil)
                 (make-dialog-item
                  'check-box-dialog-item
                  #@(204 84)
                  #@(80 16)
                  "Exclusive"
                  #'(lambda (item)
                      (setf end-exclusive (check-box-checked-p item))))
                 (make-dialog-item
                  'button-dialog-item
                  #@(130 120)
                  #@(70 20)
                  "Cancel"
                  #'(lambda (item)
                      (declare (ignore item))
                      (return-from-modal-dialog :cancel))
                  :default-button
                  nil)
                 (make-dialog-item
                  'button-dialog-item
                  #@(219 120)
                  #@(70 20)
                  "OK"
                  #'(lambda (item)
                      (declare (ignore item))
                      ;(format t "~&start: ~s end: ~s start-ex: ~s end-ex: ~s~%" start-date end-date start-exclusive end-exclusive)
                      (return-from-modal-dialog (values start-date end-date start-exclusive end-exclusive)))
                  :default-button
                  t)
                 (make-dialog-item
                  'static-text-dialog-item
                  #@(12 10)
                  #@(263 16)
                  "Please specify dates:"
                  'nil)))))
    (modal-dialog dialog)
    ))

(defun make-report ()
  (let ((project *current-project*)
        (args nil))
    (if project
      (progn
        (multiple-value-bind (start-date end-date start-exclusive end-exclusive)
                             (report-dialog)
          (cond
           ((and (string= start-date "") (string= end-date ""))
            (setf args (append args (list :comments t))))
           ((string= end-date "")
            (setf args (append args (list :revision-dates
                                          (concatenate 'string
                                                       (if start-exclusive ">" "³")
                                                       start-date)
                                          :comments t))))
           ((string= start-date "")
            (setf args (append args (list :revision-dates
                                          (concatenate 'string
                                                       (if end-exclusive "<" "²")
                                                       end-date)
                                          :comments t))))
           (t 
            (setf args (append args (list :revision-dates
                                          (concatenate 'string
                                                       start-date "-" end-date)
                                          :comments t))))))
        (setf args (cons project args))
        ;(format t "~&~s" args)
        (format t "~a" (apply #'project-info-text args)))
      (format t "~&No project to report."))
    ))

;;;
;;; Attempt to filter out other things than the comments. But failed. Hai Wang.
;;;
(defun filter-for-comments (string)
  (let ((search-string "Comment:")
        (start 0)
        (end 0)
        (end-of-comments 
         (concatenate
          'string
          "\""
          (make-sequence 'string 1 :initial-element #\newline)
          "   "))
        (temp string)
        (result-string ""))
    (loop
      (setf start (search search-string temp))
      (unless start (return result-string))
      (setf temp (subseq temp start))
      (setf end (search end-of-comments temp))
      (if end 
        (progn 
          (setf result-string 
                (concatenate 'string 
                             result-string " " 
                             (subseq temp 0 end)))
          (setf temp (subseq temp end)))
        (return result-string)))))


(defun comment-report (date-string)
  (dolist (project *mounted-projects*)
    (format t "~a" (project-info-text project :comments t :revision-dates date-string))))

;;;
;;; Project commands
;;;

(defun report-project-error (error)
  (when *break-on-projector-errors*
    (error error))
  (message-dialog (princ-to-string error))
  (cancel))

;; The syntax of handler-bind with the syntax of handler-case.
;; Mainly so that I can have a nice syntax for handlers that
;; have access to restarts, which handler-case doesn't do.
;; @@@ ought to declare the clauses dynamic-extent, I suppose
(defmacro with-handlers (form &body clauses)
  `(handler-bind
     ,(mapcar #'(lambda (clause)
                  (destructuring-bind (case arglist &rest body) clause
                    `(,case #'(lambda ,arglist ,@body))))
              clauses)
     ,form))

;; @@@ should add a clause here to automount the project
(defmacro project-handler-case (form &body clauses)
  `(handler-bind
     ((project-error #'report-project-error))
     (with-handlers ,form ,@clauses)))

#|
(defun user-mount-project (&optional project)
  (unless (and project (project-mounted-p project))
    (if *mounted-projects*
      (if (y-or-n-dialog (format nil "Project ~a not mounted - mount it now?" project)
                         :yes-text "Mount"
                         :no-text "Cancel"
                         :cancel-text nil)
        (mount-some-projects)
        (cancel))
      (if (y-or-n-dialog "No projects are mounted - mount all now?"
                         :yes-text "All"
                         :no-text "Select"
                         :cancel-text "Cancel")
        (Mount-All-Projects)
        (mount-some-projects))))
  (if project (project-mounted-p project)))
|#


;;;
;;; Checking out and in all
;;;

(defvar *close-checkin-categories-dialog* t)

(defclass file-list-dialog-item (sequence-dialog-item)
  ())

(defmethod cell-contents-string ((item file-list-dialog-item) cell)
  (ccl::pathname-to-window-title (cell-contents item cell)))

(defclass filelist-pane (view) ())

(defmethod set-view-size ((view filelist-pane) h &optional v)
  (call-next-method view h v)
  (let* ((size (view-size view))
         (margin 2)
         (label-height 20)
         (width (- (point-h size) (* 2 margin)))
         (height (point-v size))
         (views (view-subviews view))
         (label (elt views 0))
         (list (elt views 1)))
    (set-view-size label width label-height)
    (set-view-size list width (- height (* 3 margin) label-height))))

(defclass checkin-categories-dialog (dialog)
  ()
  (:default-initargs :grow-icon-p t :view-size #@(400 270)))

(defmethod initialize-instance ((dialog checkin-categories-dialog) &rest rest
                                &key (window-show t))
  (declare (dynamic-extent rest))
  (apply #'call-next-method dialog :window-show nil rest)
  (resize-subviews dialog)
  (when window-show
    (window-show dialog)))

(defmethod set-view-size ((dialog checkin-categories-dialog) h &optional v)
  (call-next-method dialog h v)
  (with-focused-view dialog
    (rlet ((rect :rect :topLeft 0 :bottomRight 0))
      (with-clip-rect rect
        (resize-subviews dialog)))
    (invalidate-view dialog t)))

(defun resize-subviews (dialog)
  (let* ((size (view-size dialog))
         (width (point-h size))
         (height (point-v size))
         (label-height 40)
         (button-height 20)
         (margin 4)
         (lower-pane-height (+ margin label-height margin button-height margin)))
    (labels ((empty-filelist (view)
               (zerop (length (table-sequence (elt (view-subviews view) 1))))))
      (let* ((views (remove-if-not #'(lambda (type) (eq type 'filelist-pane)) (view-subviews dialog)
                                   :key #'type-of))
             (filled (remove-if #'empty-filelist views))
             (count (length filled)))
        (map nil #'(lambda (view)
                     (when (empty-filelist view)
                       (set-view-position view -10000 0)))
             views)
        (unless (zerop count)
          (let ((subwidth (truncate (- (point-h size) (* margin (1+ count))) count))
                (left 0))
            (map nil #'(lambda (view &aux (top (point-v (view-position view))))
                         (set-view-position view (incf left margin) top)
                         (set-view-size view subwidth (- height top lower-pane-height))
                         (incf left subwidth))
                 filled)))))
    (let* ((message (view-named 'message dialog))
           (button1 (view-named 'button1 dialog))
           (button2 (view-named 'button2 dialog))
           (button-width 60)
           (button-top (- height margin button-height)))
      (set-view-position message 2 (- height lower-pane-height (- margin)))
      (set-view-size message (- width margin margin) label-height)
      (set-view-position button1 0 button-top)
      (set-view-position button2 0 button-top)
      (set-view-size button1 button-width button-height)
      (set-view-size button2 button-width button-height)))
  (set-button-positions dialog))

(defun set-button-positions (dialog)
  (let* ((button1 (view-named 'button1 dialog))
         (button2 (view-named 'button2 dialog))
         (button-top (point-v (view-position button1)))
         (button-width (point-h (view-size button1)))
         (view-width (point-h (view-size dialog))))
    (cond ((string= (dialog-item-text button1) "")
           (set-view-position button1 -1000 button-top)
           (set-view-position button2 -1000 0))
          ((string= (dialog-item-text button2) "")
           (set-view-position button1 (truncate (- view-width button-width) 2) button-top)
           (set-view-position button2 -1000 0))
          (t
           (let ((tween (truncate (- view-width button-width button-width) 3)))
             (set-view-position button1 tween button-top)
             (set-view-position button2 (+ tween button-width tween) button-top))))))

(defun remove-buttons (dialog)
  (let ((button1 (view-named 'button1 dialog))
        (button2 (view-named 'button2 dialog)))
    (set-view-position button1 -1000 0)
    (set-view-position button2 -1000 0)))

#|
(defun add-pathname-to-category (pathname category)
  (let ((dialog (front-window :class 'checkin-categories-dialog)))
    (when dialog
      (let* ((item (view-named category dialog))
             (sequence (table-sequence item)))
        (unless (member pathname sequence :test #'equal)
          (remove-buttons dialog)
          (set-table-sequence item (append sequence (list pathname)))
          (unless sequence
            (set-view-size dialog (view-size dialog))))))))

(defun remove-pathname-from-category (pathname category)
  (let ((dialog (front-window :class 'checkin-categories-dialog)))
    (when dialog
      (let* ((item (view-named category dialog))
             (sequence (table-sequence item)))
        (when (member pathname sequence :test #'equal)
          (remove-buttons dialog)
          (let ((sequence (remove pathname sequence)))
            (set-table-sequence item sequence)
            (unless sequence
              (set-view-size dialog (view-size dialog)))))))))
|#

(defun make-filelist-pane (label help-spec name contents)
  (make-instance 'filelist-pane
    :view-size #@(100 250)
    :view-position #@(2 2)
    :view-nick-name name
    :help-spec help-spec
    :view-subviews
    `(
      ,(make-dialog-item 'static-text-dialog-item
                         #@(2 2) #@(100 20) label nil
                         :help-spec help-spec)
      ,(make-instance 'sequence-dialog-item
         :view-size #@(96 200)
         :view-position #@(2 25)
         :view-font '("Geneva" 9)
         :help-spec help-spec
         :selection-type :disjoint
         :table-hscrollp nil
         :table-sequence contents
         :table-print-function #'(lambda (path stream)
                                   (princ (ccl::pathname-to-window-title path) stream))
         :dialog-item-action
         #'(lambda (item)
             (when (double-click-p)
               (dolist (cell (selected-cells item))
                 (let* ((path (cell-contents item cell))
                        (window (pathname-window path)))
                   (if window
                     (window-select window)
                     (fred path))))))))))

(defun close-checkin-categories-dialog ()
  (when *close-checkin-categories-dialog*
    (map-windows #'window-close :class 'checkin-categories-dialog)))

(defun make-checkin-categories-dialog (modified checkers mergers wedgers changed-wedgers)
  (make-instance 'checkin-categories-dialog
    :window-title "Changed File Categories"
    :view-position `(:top ,(+ 20 *menubar-bottom*))
    :view-subviews
    `(
      ,(make-filelist-pane "Out:" "Files that are checked out."
                           'checked-out modified)
      ,(make-filelist-pane "Modified:" "Files that are ModifyReadOnly and can be checked in without further ado."
                           'modify-read-only checkers)
      ,(make-filelist-pane "Merge:" "Files that are ModifyReadOnly and can be checked in after merging."
                           'merge mergers)
      ,(make-filelist-pane "Wedged:" "Files that are ModifyReadOnly and cannot be checked in because they have been checked out by someone else and they have the same versions as local files."
                           'wedge wedgers)
      ,(make-filelist-pane "Merge/Wedged:" "Files that are ModifyReadOnly and cannot be checked in because they have been checked out by someone else and they have the different versions from local files."
                           'changed-wedged changed-wedgers)
      ,(make-dialog-item 'static-text-dialog-item
                         #@(0 0) #@(10 10) "" nil
                         :view-nick-name 'message
                         :view-font '("Geneva" 9 :bold))
      ,(make-dialog-item 'button-dialog-item
                         #@(0 0) #@(10 10) "Okay" nil
                         :view-nick-name 'button1)
      ,(make-dialog-item 'button-dialog-item
                         #@(0 0) #@(10 10) "" nil
                         :view-nick-name 'button2)
      )))

(defun set-checkin-categories-action (dialog message-text &optional
                                             (button1-text "") button1-action
                                             (button2-text "") button2-action)
  (let ((message (view-named 'message dialog))
        (button1 (view-named 'button1 dialog))
        (button2 (view-named 'button2 dialog)))
    (set-dialog-item-text message message-text)
    (set-dialog-item-text button1 button1-text)
    (set-dialog-item-text button2 button2-text)
    (flet ((close-action (action)
             (when action
               #'(lambda (item)
                   (declare (ignore item))
                   (dialog-item-disable button1)
                   (dialog-item-disable button1)
                   (funcall (enqueued-action (funcall action)))))))
      (set-dialog-item-action-function button1 (close-action button1-action))
      (set-dialog-item-action-function button2 (close-action button2-action)))
    (dialog-item-enable button1)
    (dialog-item-enable button2))
  (set-button-positions dialog))

(defmacro if-checkin-category-query (dialog message-text &rest clauses)
  `(set-checkin-categories-action
    ,dialog
    ,message-text
    ,@(mapcan #'(lambda (clause)
                  (destructuring-bind (button-text &rest body) clause
                    `(,button-text #'(lambda () ,@body))))
              clauses)))

(defun print-a-and-b (a aname b bname &key (count t) first-word)
  (with-output-to-string (stream)
    (labels ((show (list name)
               (when list
                 (when count
                   (let* ((length (length list))
                          (text (with-output-to-string (stream)
                                  (format stream (if (<= length 10) "~R " "~D ") length))))
                     (format stream (if first-word "~@(~A~)" "~A") text)
                     (setq first-word nil)))
                 (princ name stream))))
    (show a aname)
    (and a b (princ " and " stream))
    (show b bname)
    (format stream " file~[~;~:;s~]"
            (length (or b a))))))

#|
(print-a-and-b '() "A" '(1) "B" :first-word t)
(print-a-and-b '() "A" '(1 2) "B")
(format nil "~:[~;~~(~]" t)

(multiple-value-setq (*mod* *check* *merge* *wedge* *change-wedge*)
  (categorize-project-modified-files *projects*))


(setq dialog (make-checkin-categories-dialog *mod* *check* *merge* *wedge* *change-wedge*))

(setq dialog (front-window :class 'checkin-categories-dialog))

(set-checkin-categories-action
 dialog
 (format nil "~:[~;Wedged~]~:[~; and ~]~:[~;Changed~] files cannot be uploaded, because they are checked out ~
              to other users.  Proceed with uploading the files that can be uploaded?"
         t (and t nil) nil)
 "Okay" #'(lambda () (print "Okay")))

(set-checkin-categories-action
 dialog
 (format nil "~:[~;Merge~]~:[~; and ~]~:[~;Changed~] files need merging. ~
              Move them to a new merge directory and check out the latest versions, ~
              or upload the Modified and Ready files?"
         t (and t nil) nil)
 "Merge" nil "Checkin" nil)

(make-checkin-categories-dialog '("Modified") '("Checkers") '("mergers")
                                '("wedgers") '("changed-wedgers"))
|#

;; @@@ fix these to use the high-level interface

;; @@@ race condition with the project.  Ought to find out everything that would
;; be checked out, deal with it, and then check out exactly those versions of those
;; files.  Better yet, check out everything with a certain stamp, unless told otherwise.
; Specify either projects or base-directory, from-directory, version-alist & anarchie-p.
; If base-directory is non-null, version-alist specifies the file versions.
(defun check-out-projects (projects &optional base-directory from-directory version-alist anarchie-p)
  (unless base-directory
    (setq projects (add-project-children projects)))
  (when ccl::*save-all-old-projector-versions*
    (report-progress "Saving unmodified files with newer versions...~%")
    (move-files-to-merge-directory
     (if base-directory
       (directory-newer-files base-directory version-alist)
       (mapcan #'project-newer-files projects))
     " Save"))
  (multiple-value-bind (modified checkers mergers wedgers changed-wedgers newer-file-version-alist)
                       (if base-directory
                         (directory-categorize-modified-files
                          base-directory version-alist)
                         (categorize-project-modified-files projects))
    (declare (ignore modified checkers wedgers))
    (close-checkin-categories-dialog)
    (flet ((get-newer-files (&optional use-newer-file-version-alist)
             (map-windows #'window-close :class 'projector-file-info-window)
             (if base-directory
               (progn
                 (report-progress "Copying newer files...")
                 (directory-getnewer base-directory from-directory
                                     (if use-newer-file-version-alist
                                       newer-file-version-alist
                                       version-alist )
                                     :anarchie-p anarchie-p
                                     :verbose t
                                     :unconditional-p use-newer-file-version-alist))
               (dolist (project projects)
                 (report-progress "Checking out newer files in project: ~A..." project)
                 (project-getnewer project :verbose t)))))
      (if (or mergers changed-wedgers)
        (let ((dialog (make-checkin-categories-dialog nil nil mergers nil changed-wedgers)))
          (if-checkin-category-query
           dialog
           (format nil "~A ~[~;has a newer version~:;have newer versions~] in the project database. ~
                        Move ~:*~[~;it~:;them~] to a new merge directory, ~
                        or continue with the update but don't overwrite local modified files?"
                   (print-a-and-b mergers "Merge" changed-wedgers "Merge/Wedged" :first-word t)
                   (+ (length mergers) (length changed-wedgers)))
           ("Move"
            (let ((move-files (append mergers changed-wedgers)))
              (dolist (file move-files)
                (map-pathname-windows #'window-close file))
              (move-files-to-merge-directory move-files)
              (window-close dialog))
            (get-newer-files t))
           ("Continue"
            (window-close dialog)
            (get-newer-files))))
        (get-newer-files t)))))

(defun all-project-children (p &optional first)
  (let ((v (mapcan #'all-project-children (project-children p))))
    (if (not first)  (cons p v) v)))

(defun add-project-children (projects)  
  (let ((new (mapcan #'(lambda (p)
                         (all-project-children p t))
                     projects)))
    (if new
      (sort-project-list (union new projects))
      projects)))

;;; alice - checking in a project checks in its children 
(defun check-in-projects (&rest projects)
  (setq *global-comment* nil)
  (setq projects (add-project-children projects))
  ; modified are files that are modRO and I checked out.
  ; checkers are ones that are modRO, same version, not checked out by someone else (or me either).
  ; mergers are ones that are modRO, different version, not checked out by someone else.
  ; changed-wedgers are modro and checked out by someone else.
  ; there are no wedgers today.
  (multiple-value-bind (modified checkers mergers wedgers changed-wedgers)
                       (categorize-project-modified-files projects)
    (close-checkin-categories-dialog)
    (let ((dialog (when (or wedgers changed-wedgers mergers changed-wedgers)
                    (make-checkin-categories-dialog modified checkers mergers wedgers changed-wedgers))))
      (labels
        ((look-for-wedgers ()
           (if (or wedgers changed-wedgers)
             (if-checkin-category-query
              dialog
              (format nil "~A cannot be uploaded, because ~[~;it is~:;they are~] checked out ~
                           to ~:*~[~;another user~:;other users~].  Proceed with uploading the ~A?"
                      (print-a-and-b wedgers "Wedged" changed-wedgers "Merge/Wedged" :first-word t)
                      (+ (length wedgers) (length changed-wedgers))
                      (print-a-and-b modified "Out" checkers "Modified" :count nil))
             ("Proceed"
              (look-for-mergers)))
             (look-for-mergers)))
         (look-for-mergers ()
           (if (or mergers changed-wedgers)
             (if-checkin-category-query
              dialog
              (format nil "~A need~[~;s~:;~] merging. ~
                           Move ~:*~[~;it~:;them~] to a new merge directory and check out the latest version~:*~[~;~:;s~], ~
                           or upload the ~A?"
                      (print-a-and-b mergers "Merge" changed-wedgers "Merge/Wedged" :first-word t)
                      (+ (length mergers) (length changed-wedgers))
                      (print-a-and-b modified "Out" checkers "Modified" :count nil))
              ("Merge"
               (let ((merge-files (append mergers changed-wedgers)))
                 (dolist (file merge-files)
                   (map-pathname-windows #'window-close file))
                 (let ((merge-dirs (move-files-to-merge-directory merge-files)))
                   ;;check out mergers for modification
                   (dolist (path mergers)
                     (report-progress "Checking out ~/pp-path/" path)                     
                     (let ((*close-checkin-categories-dialog* nil))
                       ; does this actually "check out" or just get it???
                       (mpw-checkout path :project (projector-name (pathname-project path)))
                       (file-modro path)
                       ;(file-checkout path)  ; dont ffing check it out- actually checkout vs modro should be an option
                       ))
                   ;;check out changed-wedgers read-only. - not really "check out"
                   (dolist (path changed-wedgers)
                     (report-progress "Checking out ~/pp-path/" path)
                     ;; @@@ change this to use the higher level interface, as soon as we
                     ;; @@@ add one to get the latest version of something that isn't
                     ;; @@@ already there
                     (mpw-checkout path :project (projector-name (pathname-project path)))
                     (update-projector-file-state path))
                   (okay-or-cancel-dialog "Merge directories?")
                   (dolist (pair merge-dirs)
                     (destructuring-bind (local-dir . merge-dir) pair
                       (merge-directories merge-dir local-dir)))
                   (checkin-files))))
              ("Checkin"
               (checkin-files)))
             (checkin-files)))
         (checkin-files ()
           (let* ((checkin (append modified checkers))
                  (lock-file (find *lockfile-name* checkin :key #'file-namestring :test #'string-equal)))
             (when lock-file
               (setq checkin (nconc (delete lock-file checkin) (list lock-file))))
             (dolist (file checkin)
               (report-progress "Checking in ~/pp-path/" file)
               (let ((*close-checkin-categories-dialog* nil))
                 ; we did the comment at checkout time?
                 (file-checkin file :no-comment (or (memq file modified) *global-comment*))
                 )))))
        (look-for-wedgers)))))

;;;
;;; File info
;;;

(defclass projector-file-info-window (dialog)
  ((pathname :accessor gf-pathname :initarg :pathname))
  (:default-initargs :color-p t))

(defmethod initialize-instance ((dialog projector-file-info-window) &key &allow-other-keys)
  (call-next-method)
  (update-file-info-window dialog))

(defmethod view-draw-contents ((dialog projector-file-info-window))
  (rlet ((rect :rect :topLeft #@(0 0) :bottomRight #@(32 32)))
    (#_OffsetRect rect 18 4)
    (#_PlotIconID rect 0 0 129))
  (labels ((frame-view (name &aux (view (view-named name dialog)))
             (multiple-value-bind (tl br) (view-corners view)
               (rlet ((rect :rect :topLeft tl :bottomRight (subtract-points br #@(1 1))))
                 (#_FrameRect rect)
                 #+never
                 (rlet ((rgb :rgbColor :red 32767 :green 32767 :blue 32767))
                   (#_RGBForeColor rgb)
                   (#_MoveTo (1- (point-h br)) (1+ (point-v tl)))
                   (#_LineTo (1- (point-h br)) (1- (point-v br)))
                   (#_LineTo (1+ (point-h tl)) (1- (point-v br))))
                 #+never
                 (rlet ((rgb :rgbColor :red 0 :green 0 :blue 0))
                   (#_RGBForeColor rgb))))))
    (call-next-method)
    (frame-view 'local)
    (frame-view 'remote)))

(defmethod view-click-event-handler ((dialog projector-file-info-window) where)
  (labels ((point-in-icon (&optional (where (view-mouse-position dialog)))
             (and (< 0 (- (point-h where) 18) 32)
                  (< 0 (- (point-v where) 4) 32)))
           (plot (state)
             (rlet ((rect :rect :topLeft #@(0 0) :bottomRight #@(32 32)))
               (#_OffsetRect rect 18 4)
               (#_PlotIconID rect 0 state 129)))
           (off ()
             (cond ((not (mouse-down-p)))
                   ((point-in-icon) (plot #$ttSelected) (on))
                   (t (off))))
           (on ()
             (cond ((not (mouse-down-p))
                    (plot #$ttNone)
                    (find-or-open-pathname (gf-pathname dialog)))
                   ((point-in-icon) (on))
                   (t (plot #$ttNone) (off)))))
    (when (point-in-icon where)
      (plot #$ttSelected)
      (on))))

(defun update-file-info-window (dialog &optional (remote-changed t)
                                       &aux (path (gf-pathname dialog))
                                       (project (pathname-project path)))
  (labels ((set-item (view name contents)
             (set-dialog-item-text (view-named name view) contents))
           (state-string (state)
             (getf '(:modro "ModifyReadOnly"
                     :checked-in "Checked In"
                     :checked-out "Checked Out")
                   state))
           (update-pane (name info-fn &aux (view (view-named name dialog)))
             (destructuring-bind (&key state version comment user)
                                 (funcall info-fn project path)
               (set-item view 'state (state-string state))
               (set-item view 'version version)
               (set-item view 'comment (if (string= comment "") "Ñ" comment))
               (set-item view 'user user)))
           (trim-to-pane (name)
             (set-view-size dialog (add-points (nth-value 1
                                                          (view-corners (view-named name dialog)))
                                               #@(1 1)))))
    (set-item dialog 'project-name (project-name project))
    (update-pane 'local #'project-file-local-info)
    (when remote-changed
      (if (project-mounted-p project)
        (with-cursor *watch-cursor*
          (window-update-event-handler dialog)
          (update-pane 'remote #'project-file-remote-info)
          (trim-to-pane 'remote))
        (trim-to-pane 'local)))))

(defun find-file-info-window (path)
  (map-windows #'(lambda (window)
                   (when (equalp (gf-pathname window) path)
                     (return-from find-file-info-window window)))
               :class 'projector-file-info-window))

(defclass static-justified-text-dialog-item (static-text-dialog-item)
  ((ccl::text-justification :allocation :instance)))

(defun show-file-info (path)
  (window-select
   (or (find-file-info-window path)
       (let ((current-y (+ 32 6))
             (plain-font '("Geneva" 9))
             (label-font '("Geneva" 9 :bold)))
         (make-instance 'projector-file-info-window
           :window-title (format nil "~A Info" (file-namestring path))
           :pathname path
           :view-size #@(200 282)
           :view-subviews
           (labels ((make-item (item-data)
                      (destructuring-bind (label name &optional (dy 12)) item-data
                        (prog1
                          (list
                           (make-dialog-item 'static-justified-text-dialog-item (make-point 2 current-y) #@(55 12)
                                             label nil
                                             :text-justification :right
                                             :view-font label-font)
                           (make-dialog-item 'static-text-dialog-item (make-point 62 current-y)
                                             (make-point 120 dy) "É" nil
                                             :text-justification :left
                                             :view-nick-name name
                                             :view-font plain-font))
                          (incf current-y dy))))
                    (make-items (list)
                      (mapcan #'make-item list))
                    (make-pane (label name top)
                      (setq current-y 14)
                      (make-instance 'view
                        :view-position (make-point 2 (+ top 2))
                        :view-size #@(197 101)
                        :view-nick-name name
                        :view-subviews
                        `(,(make-dialog-item 'static-text-dialog-item #@(2 2) #@(192 96)
                                             label nil
                                             :view-font '("Geneva" 9 :italic))
                          ,@(make-items '(("User:" user)
                                          ("State:" state)
                                          ("Version:" version)
                                          ("Comment:" comment 48)))))))
             (append
              (make-item '("Project:" project-name 36))
              (list
               (make-dialog-item 'static-text-dialog-item #@(60 12) #@(156 12)
                                 (file-namestring path) nil
                                 :view-font plain-font)
               (make-pane "Local" 'local 76)
               (make-pane "Remote" 'remote 178)))))))))


;;;
;;; File commands
;;;

(defun file-path-and-project (file &aux (path (pathname file)))
  ;; @@@ maybe ought to mount the project too
  (values path (pathname-project path)))

(defmacro with-file-path-and-project ((path project) file &body body)
  `(project-handler-case
     (multiple-value-bind (,path ,project)
                          (file-path-and-project ,file)
      ,@body)))

#|
;;; Orignial
(defun file-checkout (file &key no-comment)
  (with-file-path-and-project (path project) file
    (map-pathname-windows #'window-save path)
    (let ((comment (unless no-comment
                     (setq *last-checkout-comment*
                           (comment-dialog path *last-checkout-comment*)))))
      (with-handlers (project-file-checkout project path :comment comment)
        (project-remote-is-newer (error)
         (okay-or-cancel-dialog (format nil "~A  Move it to merge-directory and check out newer version?"
                                                error))
         (move-files-to-merge-directory (list path))
         (report-progress "Getting newer version of ~s.~%" path)
         (invoke-restart 'checkout-newer-file)))
      (update-projector-file-state path)
      ;(remove-pathname-from-category path 'modify-read-only)
      ;;do window hacking
      (multiple-value-bind (window existing-window)
                           (open-pathname-comment-log-window-p path)
        (let ((new-version (inc-projector-version (project-file-local-version project path))))
          (progn ;with-editor-excursion window
            (setf (read-only-state window) $ckid-checkedout)    ; set window to be writeable
            ;; always revert, because project-file-checkout only warns if the file
            ;; was newer on the server if it was also modreadonly locally
            (window-revert window t)               
            (unless no-comment
              (add-change window new-version comment nil)))  ; insert the comment line
          (window-save window)                 ; save the contents of the window
          (fred-update window)
          (set-mini-buffer window "checked out")
          (unless existing-window (window-close window)))))))
|#

;;;
;;; When checking out, #'window-revert checks the package. If the package is not yet defined,
;;; the code will break here. Well, what should we do?
;;;
(defun file-checkout (file &key no-comment)
  (with-file-path-and-project (path project) file
    (map-pathname-windows #'window-save path)    
    (let ((comment (unless no-comment                     
                     (comment-dialog path *last-checkout-comment*))))
      (when (eq comment :cancel) 
        (return-from file-checkout))
      (when (eq comment :no-comment) (setq no-comment t comment nil))
      (unless no-comment (setq *last-checkout-comment* comment))
      (with-handlers (project-file-checkout project path :comment comment)
        (project-remote-is-newer (error)
         (okay-or-cancel-dialog (format nil "~A  Move it to merge-directory and check out newer version?"
                                                error))
         (move-files-to-merge-directory (list path))
         (report-progress "Getting newer version of ~s.~%" path)
         (invoke-restart 'checkout-newer-file)))
      (update-projector-file-state path)
      ;(remove-pathname-from-category path 'modify-read-only)
      ;;do window hacking
      (multiple-value-bind (window existing-window)
                           (open-pathname-comment-log-window-p path)
        (let ((new-version (inc-projector-version (project-file-local-version project path))))
          (progn ;with-editor-excursion window
            (setf (read-only-state window) $ckid-checkedout)    ; set window to be writeable
            ;; always revert, because project-file-checkout only warns if the file
            ;; was newer on the server if it was also modreadonly locally
                       
            ;; However, this revert causes MCL to check the the package name of the file.
            ;; Don't need to check, just read it from the disk. Can we? Hai Wang.
            ;; After a few try, I give up. Why don't we simply continue when this error occurs.
            (handler-case 
              (window-revert window t)    
              (error (c) 
                     (format t "~&Error ~s occurred when trying to revert the window ~s. But we continue anyway." c window)))

            (unless no-comment
              (add-change window new-version comment nil)))  ; insert the comment line
          (window-save window)                 ; save the contents of the window
          (fred-update window)
          (set-mini-buffer window "checked out")
          (unless existing-window (window-close window)))))))

(defun file-checkin (file &key no-comment add &aux comment)
  ; no-comment can be a comment
  (project-handler-case
    (with-handlers      
      (multiple-value-bind (path project)
                           (file-path-and-project file)
        (unless no-comment
          (multiple-value-bind (window existing-window)
                               (open-pathname-comment-log-window-p path)
            (let ((new-version (inc-projector-version (if add
                                                        "0"
                                                        (project-file-local-version project path)))))
              (progn ;with-editor-excursion window
                (setq comment (comment-dialog path (or (find-comment-from-window window)
                                                       (unless add
                                                         (project-file-local-comment project path))
                                                       "")))
                (when (eq comment :cancel)(return-from file-checkin))
                (when (eq comment :no-comment)(setq comment nil))
                (let ((write-date (and (not (window-needs-saving-p window))
                                       (mac-file-write-date file))))
                  (when comment
                    (add-change window new-version comment t))
                  (window-save window)
                  (when write-date
                    (set-mac-file-write-date file write-date))))
              (fred-update window)
              (unless existing-window (window-close window)))))
        (if add
          (project-file-add project path :comment (or comment (and (stringp no-comment) no-comment)))
          (project-file-checkin project path :comment comment))
        ; This happens twice if add - maybe doesnt matter
        (set-path-windows-readonly-state path :read-only "checked in")
        (update-projector-file-state path))
      ;; this is the with-handlers clause
      (file-not-in-a-project (error)                            
       (let* ((path (project-error-filename error))
              (project (guess-pathname-project path)))
         (okay-or-cancel-dialog (format nil "~A  Add it to the project ~A?"
                                        error project)
                                :size #@(350 150))
         (setq add t)
         (invoke-restart 'add-file-to-project project))))))

(defun file-delete (file)
  (multiple-value-bind (path project)
                       (file-path-and-project file)
    (project-file-delete project path)))

;;; Hai added this to checkin a list of new files to the current new project
;;; 8/3/93
#|
(defun get-filename (pathname)
  (subseq (mac-namestring pathname)
          (1+
           (search ":" (mac-namestring pathname) :from-end t))))
|#

(defun checkin-new ()
  (let* ((wildcard "*")
         (dir (project-local-dir *current-project*))
         (comment "New file."))
    (progn  ; no longer modal so can continue from errors such as file already in project
     (make-instance 'color-dialog
       ;:window-type :movable-dialog
       :window-title "Checkin New"
       :back-color *tool-back-color*
       :view-position ':centered
       :view-size #@(300 338)
       :view-font '("Chicago" 12 :srcor :plain)
       :view-subviews
       (list (make-dialog-item 'static-text-dialog-item
                               #@(6 9) #@(42 16) "Filter:" 'nil)
             (make-dialog-item 'editable-text-dialog-item
                               #@(56 10) #@(161 16) wildcard 
                               #'(lambda (item)
                                   (setf wildcard (dialog-item-text item)))
                               :allow-returns nil)
             (make-dialog-item 'button-dialog-item
                               #@(227 10) #@(62 16) "Scan"
                               #'(lambda (item)
                                   (set-table-sequence 
                                    (view-named 'dir (view-window item))
                                    (directory (merge-pathnames wildcard dir))))
                               :default-button t)
             (make-dialog-item 'button-dialog-item
                               #@(157 311) #@(62 16) "Cancel"
                               #'(lambda (item)
                                   (window-close (view-window item)))
                               :default-button nil)
             (make-dialog-item 'button-dialog-item
                               #@(227 311) #@(62 16) "Checkin"
                               #'(lambda (item)
                                   (let* ((ditem (view-named 'dir (view-window item)))
                                          (cells (selected-cells ditem))
                                          (files (table-sequence ditem)))
                                     (if (not cells) ; do em all                                                                      (first-selected-cell ditem)))
                                       (mapc 
                                        #'(lambda (file)
                                            (format t "~&Checking in file ~s~%" file)
                                            (project-file-add *current-project*  file :comment comment))
                                        files)
                                       (dolist (cell cells)
                                         (let* ((i (cell-to-index ditem cell))
                                                (file (nth i files)))
                                            (format t "~&Checking in file ~s~%" file)
                                            (project-file-add *current-project*  file :comment comment)))))                                           
                                   (window-close (view-window item))
                                   ;(return-from-modal-dialog t)
                                   )
                               :default-button nil)
             (make-dialog-item 'editable-text-dialog-item
                               #@(10 37) #@(279 45) comment
                               #'(lambda (item)
                                   (setf comment (dialog-item-text item))))
             (make-dialog-item 'sequence-dialog-item
                               #@(10 90) #@(279 213) "Files"
                               'nil
                               :view-nick-name 'dir
                               :selection-type :disjoint ; it does  all if no selections
                               :table-print-function 
                               #'(lambda (obj stream)
                                   (princ (file-namestring obj) stream))
                               :view-font '("Monaco" 9 :srcor :plain)
                               :table-hscrollp nil
                               :table-vscrollp t
                               :table-sequence
                               (directory (merge-pathnames wildcard dir))))))))
;;;;;

(defun file-modro (file)
  (with-file-path-and-project (path project) file
    (project-handler-case (project-file-modro project path))
    (set-path-windows-readonly-state path :modify-read-only "buffer is ModifyReadOnly")
    (update-projector-file-state path nil)))

(defun file-orphan (file)
  (with-file-path-and-project (path project) file 
    (when (eq (project-file-local-state project path) :checked-out)
      (okay-or-cancel-dialog (format nil "~/pp-path/ is checked out to you.  Are you sure you want to orphan it?" path)))
    (project-file-orphan project path)
    (set-path-windows-readonly-state path :read-write "file is orphaned")
    (update-projector-file-state path nil)))

(defun file-cancel-checkout (file)
  (with-file-path-and-project (path project) file
    (let ((convert-to-modro (cancel-checkout-dialog path)))
      (with-handlers (project-file-cancel-checkout project path
                                                   :convert-to-modro convert-to-modro)
        (project-file-checked-out (error)
         (unless (string-equal ccl::*User* (project-error-remote-user error))
           (signal error))
         (invoke-restart 'cancel-remote-checkout)))
      (if convert-to-modro
        (set-path-windows-readonly-state path :modify-read-only "buffer is now ModifyReadOnly")
        (set-path-windows-readonly-state path :read-only "checkout cancelled" :revert t))
      (update-projector-file-state path))))

(defun file-cancel-modro (file)
  (with-file-path-and-project (path project) file
    (let* (#+never (local-version (project-file-local-version project path))
           #+never (remote-version (second (memq :version (project-file-remote-info project path))))
           #+never (version
                    (if (string= local-version remote-version)
                      (progn (okay-or-cancel-dialog (format nil "Cancel ModifyReadOnly to ~/pp-path/ by forgetting any modifications and retrieving the current version?"
                                                            path)
                                                    :size #@(318 165))
                             local-version)
                      (if (y-or-n-dialog (format nil "Cancel ModifyReadOnly to ~/pp-path/ by forgetting any modifications and:~%~%~
                                                      ¥ retrieving the latest version (~A)?~%~
                                                      ¥ retrieving the local version (~A)?"
                                                 path remote-version local-version)
                                         :yes-text "Local" :no-text "Latest"
                                         :size #@(350 200))
                local-version remote-version))))
      (okay-or-cancel-dialog (format nil "Cancel ModifyReadOnly to ~/pp-path/ by forgetting any modifications and retrieving the current version?"
                                     path)
                             :size #@(318 165))
      (project-file-cancel-modro project path)
      #+never (unless (string= version local-version)
                (project-file-get project path :version version))
      (set-path-windows-readonly-state path :read-only "ModifyReadOnly cancelled" :revert t)
      (update-projector-file-state path nil))))

(defun file-get-latest (file)
  (with-file-path-and-project (path project) file
    (unless (eq (project-file-local-state project path) :checked-in)
      (signal-project-error 'simple-project-error project
                            "Can't get a newer version of ~/pp-path/, because it is locally modifiable."
                            path))
    (project-file-get project path)
    (set-path-windows-readonly-state path :read-only "Latest version" :revert t)
    (update-projector-file-state path nil)))

(defun file-get-version (file)
  (with-file-path-and-project (path project) file
    (unless (eq (project-file-local-state project path) :checked-in)
      (signal-project-error 'simple-project-error project
                            "Can't get a different version of ~/pp-path/, because it is locally modifiable."
                            path))
    (let* ((local-version (project-file-local-version project path))
           (versions (remove local-version (project-file-versions project path)
                             :test #'string= :key #'(lambda (info) (getf info :version)))))
      (if versions
        (let ((version (first (select-item-from-list
                               versions
                               :window-title
                               (format nil "You have version ~S of ~S.  RetrieveÉ"
                                       local-version (file-namestring path))
                               :table-print-function
                               #'(lambda (info stream)
                                   (format stream "~3@A ~8A ~A"
                                           (getf info :version)
                                           (getf info :user)
                                           (getf info :comment)))))))
          (when version
            (let ((version-name (getf version :version)))
              (project-file-get project path :version version-name)
              (set-path-windows-readonly-state path :read-only (format nil "Version ~A" version-name) :revert t)
              (update-projector-file-state path nil))))
        (message-dialog (format nil "~S is the only version of ~/pp-path/" local-version path))))))

#|
(defun file-compare (file)
  (with-file-path-and-project (path project) file
    (let* ((local-version (project-file-local-version project path))
           (versions (remove (not local-version) (project-file-versions project path)
                             :test #'string= :key #'(lambda (info) (getf info :version)))))
      (when versions
        (let ((version (first (select-item-from-list
                               versions
                               :window-title
                               (format nil "Compare to versionÉ"
                                       local-version (file-namestring path))
                               :table-print-function
                               #'(lambda (info stream)
                                   (format stream "~3@A ~8A ~A"
                                           (getf info :version)
                                           (getf info :user)
                                           (getf info :comment)))))))
          (when version
            (let* ((version-name (getf version :version))
                   (directory (or (find-folder "temp") "ccl:"))
                   (other-file (merge-pathnames directory (file-namestring path))))
              (project-file-get project path :version version-name :directory directory)
              (ccl::compare-files-to-buffer other-file path))))))))

(defun compare-target ()
  (file-compare (window-filename (target))))

(file-compare #P"Tradecraft:Leibniz:Leibniz:Projector:mpw-command.lisp")
|#

;;;
;;; File information
;;;

(defun show-local-file-info (file)
  (with-file-path-and-project (path project) file
    (destructuring-bind (&key projector-name state version comment user)
                        (project-file-local-info project path)
      (format t "File: ~a,~a" (file-namestring path) version)
      (ecase state
        (:checked-out (format t "+~%    Checked out to: ~s~%" user))
        (:modro (format t "*~%    ModifyReadOnly~%"))
        (:checked-in (format t "~%    Read only~%")))
      (format t "    Project: ~a~%" projector-name)
      (unless (zerop (length comment))
        (format t "    Comment: ~s~%" comment)))))

(defun show-remote-file-info (file)
  (with-file-path-and-project (path project) file
    (print (project-info-text project :file path :comments t :latest t))))

;;this just outputs to the listener
(defun describe-modifiable-files ()
  (dolist (project *projects*)
    (unless *report-progress-to-listener* (report-progress "~A" project))
    (do-project-files 
     project
     #'(lambda (path)
         (destructuring-bind (&key state comment version)
                             (project-file-local-info project path)
           (unless (eq state :checked-in)
             (format T "~%FILE: ~a version: ~a ~a~%" 
                     path version (if (eq state :checked-out) "Checked Out" "ModifyReadOnly"))
             (unless (zerop (length comment))
               (format t "   Comments: ~a" comment))))))))

;;;
;;; Projector menu items
;;;

;;; Want to select some projects to mount from a list of all possible projects.
;;; Hai Wang 7/8/93
(defun mount-all-projects ()
  (unless (boundp 'ccl::*my-projects*)
    (my-projects))
  (unless *projects* (setup-initial-projects))   ; set-up-initial-projects is awful and wrong for subprojects
  (unless *projects*
    (message-dialog "There are no projects defined in *my-projects* to mount.")
    (cancel))
  (let ((projects (select-projects *projects*)))
    (when (LISTP projects )
      (menu-projects-mount projects)
      (set-current-project))))

;;; Select projects before mounting them.
;;; Hai Wang 7/8/93
;;; alice added some buttons for sub projects etal - maybe silly
(defun select-projects (projects)
  (let* ((selected-projects nil)
         (dialog 
          (make-instance 'color-dialog ; or arrow-dialog
            :window-type :movable-dialog
            :window-show nil
            :back-color *tool-back-color*
            :content-color *tool-back-color*
            :window-title "Mount Projects"
            :view-position ':centered
            :view-size #@(400 320)
            :close-box-p nil
            :view-font '("Chicago" 12 :srcor :plain)
            :view-subviews
            (list (make-dialog-item 'static-text-dialog-item
                   #@(13 13)
                   #@(174 16)
                   "Select projects to mount:"
                   'nil)
                  (make-dialog-item 'check-box-dialog-item
                   #@(200 11)
                   #@(120 20)
                   "Scan on Mount"
                   #'(lambda (item)
                       (setf ccl::*scan-on-mount* (check-box-checked-p item)))
                   :check-box-checked-p ccl::*scan-on-mount*)
                  (make-dialog-item 'button-dialog-item
                   #@(312 142) ; was 202
                   #@(75 20)
                   "Cancel"
                   #'(lambda (item)
                       (declare (ignore item))
                       (return-from-modal-dialog nil))
                   :default-button nil)
                  (make-dialog-item 'button-dialog-item
                   #@(302 172)  ; was 232
                   #@(95 20)
                   "Subprojects"
                   #'(lambda (item)
                       (let* ((table (view-named 'table (view-window item)))
                              (cells (selected-cells table))
                              (sel-projects (if cells 
                                              (mapcar #'(lambda (cell)
                                                          (nth (point-v cell) projects))
                                                      cells)
                                              projects)))
                         (set-table-sequence table (add-project-children sel-projects)))))
                  (make-dialog-item 'button-dialog-item
                   #@(302 202)  ; was 262
                   #@(95 20)
                   "Root Projects"
                   #'(lambda (item)
                       (let ((table (view-named 'table (view-window item))))
                         (set-table-sequence table (sorted-root-projects projects)))))
                  (make-dialog-item 'button-dialog-item
                   #@(302 232)
                   #@(95 20)
                   "*PROJECTS*"
                   #'(lambda (item)
                       (let ((table (view-named 'table (view-window item))))
                         (set-table-sequence table projects))))
                  (make-dialog-item 'button-dialog-item
                   #@(312 292)  ; was 322 
                   #@(75 20)
                   "Mount All"
                   #'(lambda (item)
                       (declare (ignore item))
                       (return-from-modal-dialog projects))
                   :default-button t)
                  (make-dialog-item 'button-dialog-item
                   #@(312 262)
                   #@(75 20)
                   "Mount"
                   #'(lambda (item)
                       (declare (ignore item))
                       (return-from-modal-dialog selected-projects))
                   :default-button nil)
                  (make-dialog-item 'sequence-dialog-item
                   #@(13 36)
                   #@(280 276)
                   "Untitled"
                   #'(lambda (item)
                       (let ((selections (selected-cells item))
                             (selection-indexes nil))
                         (when selections
                           (setf selection-indexes 
                                 (mapcar #'(lambda (cell) (cell-to-index item cell)) selections))
                           ;(format t "~&indexes = ~s~%" (reverse selection-indexes))
                           (setf selected-projects 
                                 (mapcar #'(lambda (index) (nth index projects)) 
                                         (reverse selection-indexes)))
                           ;(print selected-projects)
                           (when (double-click-p)
                             (return-from-modal-dialog selected-projects)))))
                   ;:cell-size #@(280 16)
                   :selection-type :disjoint   ; seems to be contiguous???
                   ; in install-view-in-window ((item table-dialog-item) make :disjoint be #x10 not 0!
                   ; IN file lib;dialogs #x10 aka #$lNoExtend (thats a lower case l)
                   :view-nick-name 'table
                   :table-hscrollp nil
                   :table-vscrollp t 
                   :table-sequence projects
                   :table-print-function #'(lambda (a s)(princ (indented-project-name a) s)) 
                   )))))
    (modal-dialog dialog)
    ;(WINDOW-SHOW DIALOG)
    ))

;; alice - changed to deduce local-dir if a subproject, 
;; and dont make the project until both dirs are supplied
(defun new-project ()
  (catch-cancel
    (let* ((pdir-cum-file (choose-new-file-dialog :prompt "Project Database Directory"
                                                  :directory (probe-file "ssremote:")
                                        :button-string "Create"))
          fdir pdir)
      (setq pdir (filepath-to-dirpath pdir-cum-file))
      (setq pdir (or (physical-to-logical pdir "ssremote:") pdir))
      (let* ((pdir-parent (make-pathname :host (pathname-host pdir)
                                         :directory (butlast (pathname-directory pdir))
                                         :defaults nil))
             (project-parent (guess-remote-pathname-project pdir-parent)))
        (if project-parent ; local
          (let ((par-dir (project-local-dir project-parent)))
            (setq fdir (make-pathname :host (pathname-host par-dir)
                                      :directory 
                                      (append (pathname-directory par-dir)
                                              (last (pathname-directory pdir)))
                                      :defaults nil)))
          (let ((fdir-maybe (merge-pathnames "SSlocal:" (directory-namestring pdir))))
            ;(print fdir-maybe)
            (if (probe-file fdir-maybe)
              (setq fdir fdir-maybe)
              (progn
                (setq fdir (filepath-to-dirpath
                            (choose-new-file-dialog :prompt "Local Files Directory"
                                                    :directory "SSlocal:"
                                                    :button-string "Create")))            
                (setq fdir (or (physical-to-logical fdir "sslocal:") fdir))))))
      (when (not (probe-file fdir))
        ; perhaps we should complain if already exists, but perhaps not.
        ; ie we are about to turn a directory of files into a project
        (create-directory fdir))
      (mpw-command "NewProject" (mac-directory-namestring pdir) ; ??
                   "-u" (or *user* "Unknown"))
      (when (y-or-n-dialog "Add to *projects*?" :cancel-text nil)
          ; wrong because pdir is physical
          (setq *my-projects* (nconc *my-projects*  (list (list  pdir fdir))))
          (let ((projector-name (concatenate 'string
                                             (if project-parent (projector-name project-parent) "")
                                             (car (last (pathname-directory pdir)))
                                             "º")))
            (intern-projector-name fdir projector-name pdir)))))))

; get pathname as particular host or nil
(defun physical-to-logical (path host)
  (let* ((host-dir (pathname-directory (full-pathname host)))
         (path-dir (pathname-directory (full-pathname path)))
         (plen (length path-dir))
         (hlen (length host-dir)))
    (when (>= plen hlen)
      (let ((sub (butlast path-dir (- plen hlen))))
        (when (equalp sub host-dir)
          (make-pathname :host (pathname-host host)
                         :defaults nil
                         :directory (cons :absolute (nthcdr hlen path-dir))))))))
    

(defun scan-project-files (&aux (item *scan-project-files-menu-item*)
                                (saved-text (menu-item-title item)))
  (remove-all-filename-menus)
  (menu-item-disable item)
  (unwind-protect
    (dolist (project *mounted-projects*)
      (set-menu-item-title item (format nil "Scanning ~AÉ" project))
      ;(define-logical-host-for-project project)
      (do-project-files project
                        #'(lambda (file)
                            (update-projector-file-state file))))
    (set-menu-item-title item saved-text)
    (menu-item-enable item)))

#|
(defun mount-some-projects ()
  (menu-projects-mount
   (select-item-from-list *projects*
                          :window-title "Project(s) to Mount"
                          :table-print-function
                          #'princ
                          :selection-type :disjoint)))
|#

(defun print-project-info (&rest options &key checked-out log &allow-other-keys)
  (flet ((print-it (project)
           (let ((result (apply #'project-info-text project :recursive (not checked-out) options)))
             (when result
               (if (< (position #\Return result) (1- (length result)))
                 (format t "~%~A" result)
                 (report-progress "~A" (project-name project)))))))
    (if (and checked-out (not log))
        (mapc #'print-it *mounted-projects*)
        (when (set-current-project)
          (print-it *current-project*)))))

(defun unmount-current-project ()
  (when *current-project*
    (menu-project-unmount *current-project*)
    (set-current-project)))

(defun unmount-all-projects ()
  (mapc #'menu-project-unmount *mounted-projects*)
  (setq ccl::*mpw-target* nil)
  (setq *current-project* nil))

(defun CheckoutNewerCur ()
  (check-out-projects (list *current-project*)))

(defun checkoutNewerAll ()
  (check-out-projects *mounted-projects*))

(defun check-in-current-project ()
  (check-in-projects *current-project*))

(defun check-in-all ()
  (apply #'check-in-projects *mounted-projects*))

#|
projector menu has these:
print-project-info :newer :comments :latest :checked-out :recursive :project :file
show-local-file-info filename
describe-modifiable-files
cancel-checkout-file
cancel-modro-file
orphan-file
check-in-file
check-out-file
modify-read-only-file
mount-all-projects
CheckoutNewerCur
CheckoutNewerAll
check-in-current-project
check-in-all
unmount-current-project
unmount-all-projects
merge-active-lisp-window-and-file
merge-directory-dialog
update-leibniz-version
|#

;;;
;;; Miscellaneous
;;;

(defun set-current-project (&optional (project *current-project*))
  ;; @@@ ought to be able to change to *projects*
  (unless (member project *mounted-projects*)
    (setq project (first *mounted-projects*)))
  (setq *current-project* project)
  
  ;; Hai Wang added this. When choosing a project, the dirtory will change to its local
  ;; directory. The function #'set-default-directory is define in the directory-menu.lisp.
  (when project
    (let ((local-dir (mac-namestring (project-local-dir project))))
      (create-file local-dir :if-exists nil)   ; if folder is missing, just create one.
      (set-mac-default-directory local-dir)
      (if *nav-services-available*
        (set-choose-file-default-directory-2 local-dir)
        #-carbon-compat
        (set-choose-file-default-directory local-dir))))
    (projector-menu-update))

;; @@@ this is specific to projector-projects; maybe it (and the relevant
;; slots) shouldn't be
(defun mount-project-volume (project &aux
                                     (remote (project-remote-pathname project))
                                     (alias (project-mount-alias project)))
  (when alias
    (probe-file alias))
  (unless (probe-file remote)
    (user-mount-volume (project-volume project)))
  (probe-file remote))

; it really only makes sense to mount root projects but this way we can
; get a subproject as current for check in etc.
(defun menu-projects-mount (projects)
 (let (vol)
   (dolist (project projects)
     (when (neq vol (setq vol (project-volume project)))
       (when (not (probe-file vol))
         (when (not (mount-project-volume project))
           (signal-project-error 'project-volume-not-available project
                                "Project ~A requires volume ~S to be mounted."
                                project (project-volume project)))))))
 (let (roots)
   (dolist (p projects)     
     (if (not (project-root-p p))
       (let ((root (project-root p)))
         (when (not (project-mounted-p root))
           (push root roots)
           (let ((pdir (project-remote-pathname root)))
             (when (not (probe-file pdir))
               (project-new-project root)))))
       (let ((pdir (project-remote-pathname p)))
         (when (not (probe-file pdir))
           (project-new-project p)))))
   (when roots (mount-projects roots))
   (mount-projects projects))
  (unless (menu-installed-p *projects-menu*)
    (menu-install *projects-menu*)
    #|(let ((pkg (find-package "ADBG")))
      (when pkg
        (let ((sym (intern "*BOTH-AFTER-MENUS*" pkg)))
          (when (boundp sym)
            (set sym (append (symbol-value sym) (list *projects-menu*)))))))|#
    )
  (remove-menu-items *projects-menu* (menu-items *projects-menu*))
  (when projects (set-current-project (car projects))) 
  (make-projects-menu)
  (projector-menu-update)  
  (when ccl::*scan-on-mount*
    (scan-project-files)))

;;; alice remove the children too
(defun menu-project-unmount (project)
  (let ((menu *projects-menu*))
    (project-unmount project)
    (remove-menu-items menu (find-projects-menu-item menu project))
    (let ((children (project-children project)))
      (dolist (child children)
        (remove-menu-items menu (find-projects-menu-item menu child))))) 
  (remove-all-filename-menus project) ;;@@@ should no longer be necessary
  ;(remove-logical-host-for-project project) ; what a rotten idea
  (when (eq *current-project* project)
    (set-current-project)))

;;; this failed miserably for subprojects!!!!
;;; (alice) <make it work as long as parent precedes sub in *my-projects*
(defun setup-initial-projects ()
  (when (boundp 'ccl::*my-projects*)
    (dolist (project-data ccl::*my-projects*)
      (destructuring-bind (remote-pathname local-dir &key alias)
                          project-data
        (flet ((add-colon (pathname &aux (name (namestring pathname)))
                 (and pathname
                      (if (find (elt name (1- (length name))) ";':")
                        name
                        (concatenate 'string name (if (ccl::physical-pathname-p pathname)
                                                    ":" ";"))))))
          (let* ((remote-pathname (add-colon remote-pathname))
                 (pdir-parent (make-pathname :host (pathname-host local-dir)
                                             :directory (butlast (pathname-directory remote-pathname))
                                         :defaults nil))                 
                 (project-parent (unless (null (cdr (pathname-directory pdir-parent)))
                                   (guess-pathname-project pdir-parent)))
                 (projector-name (concatenate 'string
                                              (if project-parent (projector-name project-parent) "")
                                              (first (last (pathname-directory remote-pathname)))
                                              "º"))
                 (project (or (find-projector-name projector-name)
                              (make-instance 'mpw-project
                                :remote-pathname remote-pathname
                                :local-dir (add-colon local-dir)
                                :projector-name  projector-name
                                :parent project-parent
                                :mount-alias alias))))
            ;(print (list remote-pathname pdir-parent project-parent projector-name project))
            ; Here is too much to print. Gone! Hai Wang. 7/9/93
            ;(format t "~& Project ~a project-data ~a" project project-data) 
            (when project
              (setf (slot-value project 'remote-pathname) remote-pathname)
              (setf (slot-value project 'mount-alias) alias))))))))

(defun reset-projects ()
  ;; remove menu items from the ¸'s menu
  ;; make sure that project menu is gone since projects must be remounted
  (menu-deinstall *projects-menu*)
  (apply #'remove-menu-items *projects-menu* (menu-items *projects-menu*))
  (remove-all-filename-menus)
  (setq *projects* nil *mounted-projects* nil)
  (reset-pathname-cache)
  (setup-initial-projects))

(def-load-pointers reset-projects-on-restart ()
  (reset-projects)
  (setup-initial-projects))

(menu-install *projector-menu*)


#|
trying to make pathnames be logical in project objects
no more define-logical-host-for-project
|#

#|
	Change History (most recent last):
	1	4/3/92	ows	split from projector.lisp
	2	4/3/92	ows	split from projector.lisp
	4	4/3/92	ows	fix a problem with file-cancel-checkout
	6	4/7/92	ows	cleaned up directory scanning
				added back the icon
				download closes windows, not files
	11	4/24/92	ows	fix some problems with check-in-all
	12	4/26/92	ows	check-in-all no longer closes its window too early
	13	4/29/92	ows	move fns to ui
				move help-desc to individual items
				enlarge the modreadonly cancel dialog
	14	7/7/93	hw	when choosing the project from the ¸ menu, the direcotry will change to the local directory of the proejct.
	1	9/28/93	HW	Now it's in RSTAR SourceServer.
	2	10/8/93	HW	Added new function for generating a report for all the comments after a certain date.
	3	2/28/94	akh	Setup-initial-projects does subprojects.
				Checkin and checkout do project-children.
				Indent subprojects in menu and dialog.
				New-project waits for both dirs before creating project.
				Added some buttons to mount dialog.
				menu-project-unmount removes subprojects from menu. (this dialog item should SCROLL!)
	4	3/1/94	akh	find-project-children finds all generations
	2	4/7/94	akh	Logical pathnames in project objects
	3	4/7/94	akh	unmount-all-projects sets *current-project* nil
	4	4/11/94	akh	no more define-logical-host-for-project
	5	4/13/94	akh	Make cancel work in comment-dialog
	
	
	
	6	4/13/94	akh	again
	7	4/13/94	HW	Removed the unmatched ')'.
	8	5/3/94	akh	added file-delete
	2	12/20/94	akh	dont remember
	3	12/22/94	akh	menu-projects-mount mounts roots
	4	12/22/94	akh	asdf
	5	12/22/94	akh	comment-dialog is a kludge, let-globally *processing-events*
	6	12/23/94	akh	cancel of comment dialog works now
	7	12/29/94	akh	remember last comment
|# ;(do not edit past this line!!)
