

;;	Change History (most recent first):
;;  3 3/14/97  akh  more like I like it
;;  5 11/22/95 bill directory-getnewer fix
;;  4 10/27/95 bill see below
;;  4 10/26/95 bill :overwrite -> :supersede
;;                  update-from-directory & anarchie-update-from-directory create the to-directory if necessary.
;;  3 10/25/95 bill directory-categorize-modified-files handles new files correctly.
;;  2 10/24/95 bill Fix bugs in remote-download code
;;  (do not edit before this line!!)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;;  local-update.lisp
;;;  Files to support updating from a directory of files instead of a projector database.
;;;
;;; 05/24/96 bill  update-from-directory-dialog uses mac-namestring on result of choose-directory-dialog
;;; -------------  MCL-PPC 3.9
;;; 11/22/95 bill  directory-getnewer no longer overwrites modified files or
;;;                files with no CKID resource.
;;; 10/27/95 bill  directory-categorize-modified-files warns about and says to move to
;;;                the merge directory any unmodro files whose local version is greater
;;;                than the remote one.
;;; 10/24/95 bill  directory-categorize-modified-files treats non-projector local files
;;;                like modro'd projector files with a guaranteed-not-to-match version.
;;;                This forces them to be moved to the merge directory & downloaded.
;;;                directory-getnewer handles non-existent files when unconditional-p is false.
;;; 10/19/95 bill  New file
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :ccl)

; (setq *warn-if-redefine* nil)

(defun make-relative-pathname (pathname relative-to)
  (let ((path-dir (or (pathname-directory pathname) '(:absolute)))
        (rel-dir (or (pathname-directory relative-to) '(:absolute))))
    (unless (and (eq (pop path-dir) :absolute)
                 (eq (pop rel-dir) :absolute))
      (error "Both pathnames must be absolute"))
    (loop
      (when (null rel-dir) (return))
      (unless (equalp (pop path-dir) (pop rel-dir))
        (error "relative-to must be relative to pathname")))
    (make-pathname :host nil
                   :directory `(:relative ,@path-dir)
                   :name (pathname-name pathname)
                   :type (pathname-type pathname))))

; Returns two values: version & modrop
(defun file-local-version (file)
  (multiple-value-bind (projector-file-p name modrop checked-out-p comment user version)
                       (projector-local-file-info nil file :local-version-request t)
    (declare (ignore projector-file-p name comment user))
    (values version modrop checked-out-p)))

; Return an alist of (pathname . version) pairs for
; all the files in the given directory that have a CKID resource.
; The pathnames will be relative.
(defun projector-directory-version-numbers (directory-pathname)
  (let* ((physical-directory (truename directory-pathname))
         (files (directory (merge-pathnames ":**:*.*" physical-directory)))
         (res nil))
    (dolist (file files)
      (let ((local-version (file-local-version file)))
        (when local-version
          (push (cons (make-relative-pathname file physical-directory)
                      local-version)
                res))))
    (coerce (nreverse res) 'vector)))

(defvar *projector-file-versions* nil)

(defparameter *projector-versions-filename*
  "projector-file-versions.lisp")

(defun make-projector-versions-file (directory-pathname 
                                     &key
                                     (versions-file *projector-versions-filename*)
                                     (if-exists :supersede))
  (let ((path (merge-pathnames versions-file directory-pathname)))
    (with-open-file (stream path
                            :direction :output
                            :if-does-not-exist :create
                            :if-exists if-exists)
      (when stream                      ; user may have said :if-exists nil
        (let ((versions (projector-directory-version-numbers directory-pathname)))
          (format stream "(cl:in-package :ccl)~%")
          (with-standard-io-syntax
            (let ((*package* *ccl-package*))
              (prin1 `(setq *projector-file-versions* ',versions) stream)
              (terpri stream)))
          (values path versions))))))

(defun read-projector-versions-file (directory-pathname
                                     &key
                                     (versions-file *projector-versions-filename*)
                                     (create-p nil))
  (let ((path (if directory-pathname 
                (merge-pathnames versions-file directory-pathname)
                versions-file)))
    (cond ((probe-file path)
           (let ((*projector-file-versions* nil))
             (load path)
             *projector-file-versions*))
          (create-p
           (nth-value 1 (make-projector-versions-file
                         directory-pathname
                         :versions-file versions-file)))
          (t (error "Can't find ~s" path)))))

#| ; Moved to "projector-utilities.lisp"

(defvar *last-root-dirs* nil)
(defvar *last-merge-dirs* nil)

; This is a patch of the version in projector-utilities.lisp
(defun choose-and-merge-directories ()
  (declare (special *last-root-dir* *last-merge-dir*))
  (flet ((get-next-dirs ()
           (setq *last-root-dir* (or (pop *last-root-dirs*) "")
                 *last-merge-dir* (or (pop *last-merge-dirs*) ""))))
    (when (and (equal "" *last-root-dir*)
               (equal "" *last-merge-dir*))
      (get-next-dirs))
    (prog1
      (make-instance 'merge-directory-dialog
        :main-dir *last-root-dir*
        :merge-dir *last-merge-dir*)
      (get-next-dirs))))

; This is a patch of the version in projector-utilities.lisp
(defun move-files-to-merge-directory (paths &optional (partial-name " Merge"))
  (setq paths (mapcar 'translate-logical-pathname paths))
  (let ((volume (and paths (second (pathname-directory (car paths))))))
    (dolist (path paths)
      (let ((dir (pathname-directory path)))
        (unless (and (eq :absolute (first dir))
                     (equalp volume (second dir)))
          (error "All pathnames must be absolute and on the same volume"))))
    (let* ((merge-dir (new-merge-dir (make-pathname :directory `(:absolute ,volume ,volume)
                                                    :defaults nil)
                                     partial-name))
           (root-dir (make-pathname :directory `(:absolute ,volume)
                                    :defaults nil)))
      (setq *last-merge-dirs* (nconc *last-merge-dirs* (list merge-dir))
            *last-root-dirs* (nconc *last-root-dirs* (list root-dir)))
      (labels ((path->merge-dir (path)
                 (let* ((local-dir (make-pathname :name nil :type nil :defaults path))
                        (merge-dir (find-corresponding-path local-dir root-dir merge-dir)))
                   (unless (probe-file merge-dir)
                     (create-file merge-dir))
                   merge-dir)))
        (dolist (path paths)
          (let ((new-path (merge-pathnames (path->merge-dir path) path)))
            (format t "Moving ~s~%    to ~s~&" path new-path)
            (rename-file path new-path)
            (remove-filename-from-projector-menu path))))
      (list (cons root-dir merge-dir)))))

|#

#| ; Moved to "projector-ui.lisp"

; Theses are patches of the versions in projector-ui.lisp
(defun checkoutNewerAll ()
  (check-out-projects *mounted-projects*))

(defun CheckoutNewerCur ()
  (check-out-projects (list *current-project*)))


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

|#

(defun directory-getnewer (base-directory from-directory version-alist &key anarchie-p verbose unconditional-p)
  (declare (ignore unconditional-p))
  (setq base-directory (truename base-directory))
  (unless anarchie-p
    (setq from-directory (truename from-directory)))
  (flet ((getter (file.version)
           (let* ((file (car file.version))
                  (version (cdr file.version))
                  (local-file (merge-pathnames file base-directory))
                  (same-version-p nil))
             (if (multiple-value-bind (local-version modrop) (file-local-version local-file)
                   (and (not modrop)
                        (if (null local-version)
                          (not (probe-file local-file))
                          (not (setq same-version-p (string-equal version local-version))))))
               (let ((remote-file (merge-pathnames file from-directory)))
                 (when verbose
                   (format t "~&Copying ~s~%     to ~s~%" remote-file local-file))
                 (if anarchie-p
                   (anarchie-copy-file remote-file local-file :if-exists :supersede)
                   (copy-file remote-file local-file :if-exists :supersede)))
               (when (and verbose (not same-version-p))
                 (format t "~&Not overwriting ~s~%" local-file))))))
    (declare (dynamic-extent #'getter))
    (map nil #'getter version-alist)))

(defun directory-newer-files (base-directory version-alist)
  (setq base-directory (truename base-directory))
  (let (file-list)
    (flet ((mapper (file.version)
             (let* ((file (car file.version))
                    (version (cdr file.version))
                    (local-file (merge-pathnames file base-directory)))
               (let ((local-version (file-local-version local-file)))
                 (when (or (null local-version) (not (string-equal version local-version)))
                   (push local-file file-list))))))
      (declare (dynamic-extent #'mapper))
      (map nil #'mapper version-alist))
    file-list))

(defun directory-categorize-modified-files (base-directory version-alist)
  (setq base-directory (truename base-directory))
  (let ((check-in-files ())
        (check-out-and-in-files ())
        (merge-in-files ())
        (wedge-files ())
        (changed-wedge-files ())
        (newer-file-version-alist ()))
    (format t "~&Categorizing files...")
    (map
     nil
     #'(lambda (file.version)
         (let* ((file (car file.version))
                (version (cdr file.version))
                (path (merge-pathnames file base-directory)))
           ;(format t "~&Checking ~s" path)
           (if (not (probe-file path))
             (push file.version newer-file-version-alist)
             (multiple-value-bind (projector-file-p name modrop local-checked-out-p comment user local-version)
                                  (projector-local-file-info nil path :local-version-request t)
               (declare (ignore name comment user))
               (unless projector-file-p
                 ; non-projector local files behave like modro files with a version that can't match
                 (setq modrop t
                       local-version "-1"))
               (if local-checked-out-p
                 (push path check-in-files)
                 (if modrop
                   (multiple-value-bind (remote-checked-out-p remote-user remote-version)
                                        (values nil *user* version)
                     (let ((same-version (string-equal local-version remote-version)))
                       (if remote-checked-out-p
                         ; remote-checked-out-p is never true here. Keep this
                         ; code around to mirror categorize-project-modified-files
                         (let ((user-me (string-equal *user* remote-user)))
                           (if same-version
                             (if (not user-me)
                               (push path changed-wedge-files)   ; somebody else checked it out
                               (push path check-in-files)) ; I checked it out - so check it in
                             (progn
                               (when user-me ; maybe this cant happen
                                 (cerror "Call it wedged."
                                         "File ~p was checked out by me and now has a different version"))
                               (push path changed-wedge-files))))
                         (if same-version  ; wtf is this doing
                           (push path check-out-and-in-files)  ; just check in
                           (progn (push path merge-in-files)
                                  (push file.version newer-file-version-alist))))))
                   (unless (string-equal local-version version)
                     (push file.version newer-file-version-alist)
                     (when (> (parse-integer local-version :radix 10.)
                              (parse-integer version :radix 10.))
                       (format t "~&Warning: Local version of ~s is greater than server version"
                               path)
                       (push path merge-in-files)))))))))
      version-alist)
    (format t "~%")
    (values (nreverse check-in-files)
            (nreverse check-out-and-in-files)
            (nreverse merge-in-files)
            (nreverse wedge-files)
            (nreverse changed-wedge-files)
            (nreverse newer-file-version-alist))))

(defvar *update-from-directory-source* "")
(defvar *update-from-directory-target* "ccl:")

(defun update-from-directory (&key (from-directory *update-from-directory-source* fdp)
                                   (to-directory *update-from-directory-target*) tdp)
  (unless (and fdp tdp)
    (multiple-value-setq (from-directory to-directory)
      (update-from-directory-dialog from-directory to-directory nil))
    (setq *update-from-directory-source* from-directory
          *update-from-directory-target* to-directory))
  (setq from-directory (truename from-directory)
        to-directory (or (probe-file to-directory) 
                         (create-directory to-directory)))
  (let ((versions-alist (read-projector-versions-file from-directory)))
    (check-out-projects nil to-directory from-directory versions-alist)))

(defvar *anarchie-from-directory*
  "Abode:ccl 3.0x:")

(defun anarchie-update-from-directory (&key (from-directory *anarchie-from-directory* fdp)
                                            (to-directory *update-from-directory-target* tdp))
  (unless (and fdp tdp)
    (multiple-value-setq (from-directory to-directory)
      (update-from-directory-dialog from-directory to-directory t))
    (setq *anarchie-from-directory* from-directory
          *update-from-directory-target* to-directory))
  (setq to-directory 
        (or (probe-file to-directory) (create-directory to-directory)))
  (let ((local-versions-file (translate-logical-pathname "ccl:remote-versions.lisp"))
        (remote-versions-file (merge-pathnames *projector-versions-filename* from-directory)))
    (anarchie-copy-file remote-versions-file local-versions-file
                        :if-exists :supersede)
    (let ((versions-alist (read-projector-versions-file nil :versions-file local-versions-file)))
      (check-out-projects nil to-directory from-directory versions-alist t))))

(defun update-from-directory-dialog (from-directory to-directory anarchie-p
                                                    &key
                                                    (window-title "Choose update directories")
                                                    (from-dir-title "Remote (source) dir:")
                                                    (to-dir-title "Local (destination) dir:")
                                                    (new-to-dir-p nil))
  (modal-dialog
   (make-instance 'dialog
     :window-title window-title
     :window-type :movable-dialog
     :view-size #@(340 140)
     :view-subviews
     `(,(make-dialog-item 'static-text-dialog-item
                          #@(10 10)
                          #@(150 16)
                          from-dir-title)
       ,(make-dialog-item 'editable-text-dialog-item
                          #@(10 36)
                          #@(250 16)
                          (namestring from-directory)
                          nil
                          :view-nick-name :from-dir)
       ,@(unless anarchie-p
           (list (make-dialog-item 'button-dialog-item
                                   #@(270 36)
                                   #@(60 16)
                                   "Choose"
                                   #'(lambda (item)
                                       (let ((from-dir (find-named-sibling item :from-dir)))
                                         (set-dialog-item-text
                                          from-dir
                                          (mac-namestring
                                           (choose-directory-dialog
                                            :directory (dialog-item-text from-dir)))))))))
       ,(make-dialog-item 'static-text-dialog-item
                          #@(10 62)
                          #@(150 16)
                          to-dir-title)
       ,(make-dialog-item 'editable-text-dialog-item
                          #@(10 88)
                          #@(250 16)
                          (namestring to-directory)
                          nil
                          :view-nick-name :to-dir)
       ,(make-dialog-item 'button-dialog-item
                          #@(270 88)
                          #@(60 16)
                          "Choose"
                          #'(lambda (item)
                              (let* ((to-dir (find-named-sibling item :to-dir))
                                     (to-dir-text (dialog-item-text to-dir)))
                                (set-dialog-item-text
                                 to-dir
                                 (mac-namestring
                                  (if new-to-dir-p
                                    (choose-new-directory-dialog)
                                    (choose-directory-dialog
                                     :directory (and (probe-file to-dir-text) to-dir-text))))))))
       ,(make-dialog-item 'button-dialog-item
                          #@(200 114)
                          #@(60 16)
                          "Cancel"
                          #'(lambda (item) item (return-from-modal-dialog :cancel)))
       ,(make-dialog-item 'default-button-dialog-item
                          #@(270 114)
                          #@(60 16)
                          "OK"
                          #'(lambda (item)
                              (return-from-modal-dialog
                               (values (dialog-item-text (find-named-sibling item :from-dir))
                                       (dialog-item-text (find-named-sibling item :to-dir))))))))))

(defun create-upload-directory (&key (from-dir *update-from-directory-target* from-dirp)
                                     (to-dir nil)
                                     (verbose t))
  (unless (and from-dirp to-dir)
    (unless to-dir
      (let* ((dir (cdr (pathname-directory (truename from-dir))))
             (volume (car dir))
             (upload-dir (car (last dir))))
        (setq to-dir (new-merge-dir (make-pathname :directory `(:absolute ,volume ,upload-dir)
                                                   :defaults nil)
                                     " upload"))))
    (multiple-value-setq (from-dir to-dir)
      (update-from-directory-dialog from-dir to-dir nil
                                    :window-title "Create upload directory"
                                    :from-dir-title "Source directory:"
                                    :to-dir-title "Destination (upload) directory:"
                                    :new-to-dir-p t))
    (setq *update-from-directory-target* from-dir))
  (setq from-dir (truename from-dir))
  (setq to-dir
        (or (probe-file to-dir)
            (create-directory to-dir)))
  (format t "~&Gathering files...")
  (let* ((from-wild (merge-pathnames ":**:*.*" from-dir))
         (to-wild (merge-pathnames ":**:*.*" to-dir))
         (files (directory from-wild))
         (checkin-files nil))
    (when verbose
      (format t "~&Looking for modified files..."))
    (dolist (file files)
      (multiple-value-bind (version modro-p checked-out-p) (file-local-version file)
        (declare (ignore version))
        (when (or modro-p checked-out-p)
          (push file checkin-files))))
    (dolist (from-file checkin-files)
      (let ((to-file (translate-pathname from-file from-wild to-wild)))
        (when verbose
          (format t "~&Copying ~s~%     to ~s" from-file to-file))
        (copy-file from-file to-file)))
    (when verbose
      (format t "~&Done.~%"))))

#| ; Moved to "sourceserver:projector-menus.lisp"

(defclass enqueue-action-menu-item (menu-item) ())

(defmethod menu-item-action ((item enqueue-action-menu-item))
  (eval-enqueue `(funcall ',(menu-item-action-function item))))

(let ((menu *projector-menu*))
  (let ((old-menu (find-menu-item menu "Update from directory")))
    (when old-menu
      (let* ((items (menu-items menu))
             (pos (position old-menu items))
             (separator (nth (1- pos) items)))
        (remove-menu-items menu separator old-menu))))
  (let ((update-menu (find-menu-item menu "Unmount current project"))
        (new-menus
         (list (make-instance 'menu :menu-title "-")
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
                                     :menu-item-action 'create-upload-directory)))))
        (items (menu-items menu)))
    (unless update-menu
      (error "Can't find unmount menu"))
    (apply 'remove-menu-items menu items)
    (let* ((pos (1+ (position update-menu items)))
           (head (subseq items 0 pos))
           (tail (subseq items pos)))
      (apply 'add-menu-items menu (nconc head new-menus tail)))))

|#
;;;;;;;;;;;;;;;;;;
;; utilities that alice uses




; after checkin put the checked in versions in ccl back into the update dir
(defun update-update-from-ccl (update-dir &optional (fork :both))
  (when (and (stringp update-dir)(not (eql #\: (char update-dir (1- (length update-dir))))))
    (setq update-dir (%str-cat update-dir ":")))
  (let ((files (directory (merge-pathnames ":**:*.*" update-dir)))
        (dirlen (length (pathname-directory update-dir))))
    (dolist (file files)
      (let ((source (make-pathname :host "ccl"
                                 :directory (cons :absolute (nthcdr dirlen (pathname-directory file)))
                                 :name (pathname-name file)
                                 :type (pathname-type file))))
        (format t "~%Copying ~s to ~s" source file)
        (copy-file source file :if-exists :supersede :fork fork)  ; want ckid and checkin comments
        ))))

; for local machine - having gotten an update from someone else (presumably all checked in)
; copy from update to ccl if ccl is not modro or checked out
; else copy move from ccl to a newly created merge directory then copy from update to ccl.

(defun copy-update-to-ccl-with-merge-check (update-dir)
  (copy-update-to-ccl update-dir t))

; on remote machine move the update dir into ccl heirarchy preparing for checkin
; or on local machine move the presumably newly checked in files to local ccl dir.
; maybe do merge-check by default.

(defun copy-update-to-ccl (update-dir &optional (merge-check t))
  (when (and (stringp update-dir)(not (eql #\: (char update-dir (1- (length update-dir))))))
    (setq update-dir (%str-cat update-dir ":")))
  (let ((files (directory (merge-pathnames ":**:*.*" update-dir)))
        (dirlen (length (pathname-directory update-dir)))
        (merge-files))
    (when merge-check
      (dolist (file files)
        (let ((dest (make-pathname :host "ccl"
                                   :directory (cons :absolute (nthcdr dirlen (pathname-directory file)))
                                   :name (pathname-name file)
                                   :type (pathname-type file))))
          (when (and (probe-file dest)(file-is-modifiable-p dest)) ; file-is-mod-p returns true for nonexistant file
            (push dest merge-files)))))
    (when merge-files 
      (when (y-or-n-p "~&Move files ~s to merge directory?" merge-files)
        (terpri t)
        (move-files-to-merge-directory merge-files)) ; this renames the files
      ) ; 
    (dolist (file files)
      (let ((dest (make-pathname :host "ccl"
                                 :directory (cons :absolute (nthcdr dirlen (pathname-directory file)))
                                 :name (pathname-name file)
                                 :type (pathname-type file))))
        (when (or (null merge-check)(not (and (probe-file dest)(file-is-modifiable-p dest))))
          ; don't overwrite modified files.
          (format t "~&Copying ~s to ~s" file dest)
          (copy-file file dest :if-exists :supersede)
          )))))

#| 
assuming local hierarchy is up to date (no merges necessary), ditto remote
1) sourceserver/update from directory/create upload directory to make an upload directory
2) move that to bill.digitool.com, run the ccl there with up to date full heirarchy
3) use copy-update-to-ccl (update-dir) ; put my modified files in the ccl dir 
4) sourceserver/mount-projects, sourceserver/checkin all projects  ; check em in
5) update-update-from-ccl (update-dir) ; get the checked in versions to update dir
6) move update dir back to local machine
7) copy-update-to-ccl (update-dir NIL) on local machine to get the checked in versions

to merge with someone elses update
1) get the update directory to local machine
2) copy-update-to-ccl (update-dir)
3) merge as before

|#

   

; (setq *warn-if-redefine* t)
