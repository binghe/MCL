

;;	Change History (most recent first):
;;  3 10/27/95 bill see below
;;  2 10/23/95 bill Remote download support
;;  5 2/6/95   akh  change categorize mumble to not whine about files checked out by me.
;;  4 2/3/95   akh  in project-file-cancel-checkout - dont be so quick to error
;;  (do not edit before this line!!)
;;;; Most of this used to be projector.lisp.  The change history from that life is at
;;;; the end of the file.

;; 10/27/95 bill  project-categorize-modified-files warns about and says to move to
;;                the merge directory any unmodro files whose local version is greater
;;                than the remote one.
;; 10/25/95 bill  with-open-res-file does probe-file to resolve aliases.
;; 10/20/95 bill  remove the eval-when from around bind-file-info

(in-package :ccl)
;(require "PROJECT")
;(require "MPW-COMMAND")

;;;
;;; Projector class and conditions
;;;

(defclass mpw-project (projector)
  ((remote-pathname :reader project-remote-pathname :initarg :remote-pathname)
   (projector-name :reader projector-name :initarg :projector-name)))

; fixed for logical pathnames
(defun project-volume (project)
  (concatenate 'string (second (pathname-directory (full-pathname (project-remote-pathname project))))
               ":"))

;;;
;;; old Projector primitives
;;;

(defun break-string-into-list (str &optional (ch #\return))
  (let ((list nil))
    (do* ((start 0 (1+ pos))
          (pos (position ch str :start start) (position ch str :start start)))
         ((null pos) (when (neq start (length str)) (push (subseq str start) list)))
      (push (subseq str start pos) list))
    (nreverse list)))

(defun mpw-mounted-projects ()
  (let ((str (mpw-mountproject nil :short t :recursive t :project-paths t)))
    (when str
      (mapcar #'mpw-unquote
              (break-string-into-list str #\return)))))

;;;
;;; file info utilities
;;;

;; @@@ this ought to check that the resource file is not already open before closing it.
;; I'm not sure how to do this, but it could at least check that the refnum isn't
;; the system refnum (from SysMap), the current file (CurResNum), or the application
;; (some undocumented lowmem, although it's likely to be CurResNum).
;;
;; This used to be called WITH-OPEN-RESOURCE-FILE.  That conflicted with the
;; similarly-named function that gets exported from CCL when help-manager file
;; is loaded.  Since UPDATE-CURSOR loads help-manager inside an ignore-errors,
;; ballon help simply didn't work.
(eval-when (:compile-toplevel :execute)
(defmacro with-open-res-file (file &body body)
  (let ((str (gensym "STR"))
        (cur-refnum (gensym "CUR-REFNUM"))
        (refnum (gensym "REFNUM")))
    `(let ((,str (probe-file ,file)))
       (when ,str
         (with-pstrs ((,str (mac-namestring ,str)))
           (let ((,cur-refnum (#_CurResFile))
                 (,refnum (#_HOpenResFile 0 0  ,str #$fsrdwrperm)))
             (unless (eql ,refnum -1)
               (unwind-protect
                 (progn ,@body)
                 (unless (= ,refnum ,cur-refnum)
                   (#_CloseResFile ,refnum))))))))))

(defmacro with-1resource ((resource resType resID) &body body)
  `(let ((,resource (#_Get1Resource ,resType ,resID)))
     (when (%null-ptr-p ,resource)
       (setq ,resource nil))
     ,@body))
) ; end eval-when

(defun projector-local-file-info (project path &key project-name-request local-comment-request
                                                    local-user-request local-version-request
                                               &aux projector-file-p modrop projector-name
                                                    local-comment local-checked-out-p
                                                    local-user local-version)
  (with-open-res-file path
    (with-1resource (ckid :|ckid| 128)
      (when ckid 
        (setq projector-file-p t)
        (unless (= 4 (rref ckid ckid.version))
          (signal-project-error 'simple-project-error project
                                "Unknown 'ckid' version in ~A."
                                path))
        (with-dereferenced-handles ((p ckid))
          (setq local-checked-out-p (not (zerop (rref p ckid.readonly :storage :pointer))))
          (setq modrop (rref p ckid.modifyreadonly :storage :pointer))
          (let ((str-ptr (%inc-ptr p 40)))
            (labels ((get-str ()
                       (let* ((len (%get-unsigned-byte str-ptr))
                              (str (ccl::%str-from-ptr (%inc-ptr str-ptr 1) len)))
                         (setq str-ptr (%inc-ptr str-ptr (+ 2 len)))
                         str))
                     (skip-str ()
                       (setq str-ptr (%inc-ptr str-ptr (+ 2 (%get-unsigned-byte str-ptr))))
                       nil)
                     (maybe-get-str (flag)
                       (if flag (get-str) (skip-str))))
              (setq projector-name (maybe-get-str project-name-request)
                    local-user (maybe-get-str local-user-request)
                    local-version (maybe-get-str local-version-request))
              (skip-str)
              (skip-str)
              (setq local-comment (maybe-get-str local-comment-request))))))))
  (values projector-file-p projector-name modrop
          local-checked-out-p local-comment local-user local-version))

(defun name-and-version (string)
  (let* ((comma-pos (position #\, string))
         (length (length string))
         (last-char (char string (1- length))))
    (labels ((return-state (state)
               (values (subseq string 0 comma-pos)
                       (subseq string (1+ comma-pos) (and state (1- length)))
                       (or state :checked-in))))
      (case last-char
        (#\+ (return-state :checked-out))
        (#\* (return-state :checked-in))
        (t (return-state nil))))))

(defun parse-projector-file-info (info-lines
                                  &key (remote-comment-request t)
                                       (remote-user-request t) (remote-version-request t)
                                  &aux remote-checked-out-p remote-comment
                                       remote-user remote-version)
  (declare (ignore remote-version-request))
  (labels ((lookup-field (field-name &aux (field-length (+ (length field-name) 4)))
             (let ((line
                    (find-if #'(lambda (line)
                                 (and (> (length line) field-length)
                                      (string-equal line field-name
                                                    :start1 4
                                                    :end1 field-length)))
                             info-lines)))
               (when line
                 (subseq line (1+ field-length))))))
    (multiple-value-bind (name version state)
                         (name-and-version (mpw-unquote (first info-lines)))
      (declare (ignore name))
      (setq remote-version version)
      (setq remote-checked-out-p (eq state :checked-out)))
    (when remote-user-request
      (setq remote-user (or (lookup-field "Owner:") (lookup-field "Author:"))))
    (when remote-comment-request
      (setq remote-comment
            (with-output-to-string (stream)
              (let (separator)
                (dolist (line info-lines)
                  (when (>= (or (position-if-not #'(lambda (char) (char= char #\Space)) line) 0)
                            8)
                    (write-string (subseq line 8) stream)
                    (when separator
                      (princ #\Newline stream))
                    (setq separator t))))))))
  (values remote-checked-out-p remote-comment remote-user remote-version))

(defun projector-remote-file-info (projector-name path &rest requests
                                                       &key remote-comment-request
                                                       &allow-other-keys)
  (declare (dynamic-extent requests))
  (apply #'parse-projector-file-info
         (break-string-into-list
          (mpw-projectinfo :file (file-namestring path)
                           :project projector-name
                           :latest t :comments remote-comment-request))
         requests))

;;requests is a list of keywords of the specifies requested information
;;information is returned as multiple-values in the same order as requests
;;valid keywords: projector-file-p projector-name modrop 
;;                local-checked-out-p  local-user local-version local-comment
;;                remote-checked-out-p remote-user remote-version remote-comment
;;if any remote info is available, that implies that the project is accessible
(defun projector-file-info (project path requests)
  (let (read-local-info read-remote-info need-not-exist
        (projector-name (and project (projector-name project)))
        projector-file-p modrop (exists-locally-p t)
        local-checked-out-p  local-user  local-version  local-comment
        remote-checked-out-p remote-user remote-version remote-comment)
    (dolist (request requests)
      (ecase request
        ((:projector-file-p :projector-name :modrop :local-checked-out-p :local-user :local-version :local-comment)
         (setq read-local-info t))
        ((:remote-checked-out-p :remote-user :remote-version :remote-comment)
         (setq read-local-info t read-remote-info t))
        (:exists-locally-p
         (setq need-not-exist t))))
    (unless (probe-file path)
      (if need-not-exist
        (setq exists-locally-p nil
              read-local-info nil)
        (error "Non-existent ~A." path)))
    ;; @@@ this can go away when nil projects are disallowed
    (unless project
      (when read-remote-info
        (setq read-local-info exists-locally-p)))
    (when read-local-info
      (multiple-value-setq (projector-file-p projector-name modrop local-checked-out-p local-comment local-user local-version)
        (projector-local-file-info project path
                                   :project-name-request t
                                   :local-comment-request (memq :local-comment requests)
                                   :local-user-request (memq :local-user requests)
                                   :local-version-request (memq :local-version requests)))
      (unless projector-file-p
        (file-not-in-a-project path))
      ;; @@@ passing nil for the project is an ugly hack.  Something is wrong with the protocol.
      (assert (or (null project) (string-equal projector-name (projector-name project))) nil
              "File ~S thinks it's in project ~S, but the system thinks it's in project ~S."
              path projector-name (projector-name project)))
    (when read-remote-info
      (unless (project-mounted-p project)
        (restart-case (project-not-accessible project)
          (project-has-been-mounted ())))
      (multiple-value-setq (remote-checked-out-p remote-comment remote-user remote-version)
        (projector-remote-file-info projector-name path
                                    :remote-comment-request (memq :remote-comment requests)
                                    :remote-user-request (memq :remote-user requests)
                                    :remote-version-request (memq :remote-version requests))))
    (let ((return-values nil))
      (dolist (request requests)
        (push (case request
                    (:projector-file-p projector-file-p) (:projector-name projector-name) 
                    (:modrop modrop)
                    (:local-checked-out-p local-checked-out-p) (:local-user local-user)
                    (:local-version local-version) (:local-comment local-comment)
                    (:remote-checked-out-p remote-checked-out-p) (:remote-user remote-user)
                    (:remote-version remote-version) (:remote-comment remote-comment)
                    (:exists-locally-p exists-locally-p))
              return-values))
      (values-list (nreverse return-values)))))

(defmacro bind-file-info ((&rest requests) project path &body body)
  `(multiple-value-bind ,requests
                        (projector-file-info ,project ,path
                                             ',(mapcar #'ccl::make-keyword requests))
     ,@body))

;;;
;;; File operations
;;;

(defun temporary-file-name (path)
  (pathname (concatenate 'string (namestring path) "~")))

(defun project-file-checkout (project path &key comment)
  (bind-file-info (local-checked-out-p remote-checked-out-p remote-user modrop
                   local-version remote-version projector-name exists-locally-p)
                  project path
    (declare (ignore exists-locally-p))
    (cond
     (local-checked-out-p
      (signal-project-error 'project-file-already-checked-out project
                           "You already have ~/pp-path/ checked out."
                           path))
     (remote-checked-out-p
      (project-file-checked-out remote-user
                                "~/pp-path/ can't be checked out because ~s has it checked out."
                                path remote-user))
     (modrop
      (let ((remote-is-newer (not (string-equal local-version remote-version))))
        (when remote-is-newer
          (restart-case
            (signal-project-error 'project-remote-is-newer project
                                 "~/pp-path/ has been modified and a newer version has been checked in."
                                 path)
            (checkout-newer-file ())))
        (unless remote-is-newer
          ;;checkout modro
          ;; @@@ consolidate this with the code in project-cancel-checkout
          (let ((temp-name (temporary-file-name path)))
            (rename-file path temp-name)
            (unwind-protect
              (progn
                (mpw-checkout (mac-namestring path) :yes-to-dialogs t :project projector-name)
                (transfer-ckid path temp-name)
                (delete-file path))
              (rename-file temp-name path)))))))
    (mpw-checkout (mac-namestring path) :modifiable t :project projector-name :comment comment)))

(defun project-file-checkin (project path &key comment)
  (bind-file-info (local-checked-out-p modrop local-version projector-name)
                  project path
    (unless local-checked-out-p
      (unless modrop
        (signal-project-error 'simple-project-error project
                              "~/pp-path/ is not checked out for modification."
                              path))
      (bind-file-info (remote-checked-out-p remote-version remote-user)
                      project path
        (when remote-checked-out-p
          (project-file-checked-out remote-user
                                    "~/pp-path/ can't be checked in because it is checked out by ~s."
                                    path remote-user))
        (unless (string-equal local-version remote-version)
          (signal-project-error 'project-remote-is-newer project
                                "~/pp-path/ can't be checked in until it is merged because there is a newer version in the database."
                                path))))
    ;;check it in
    (loop
      (mpw-checkin (mac-namestring path) :project projector-name :comment comment
                   :yes-to-dialogs t)
      (if (eq (project-file-local-state project path) :checked-in)
        (return)
        (cerror "Try to check ~/pp-path/ into ~A again."
                (format nil "~/pp-path/ in project ~A wasn't actually checked in, even though MPW said it was. ~
                             Please send mail about this to Internet address dylan-implementors@cambridge.apple.com."
                        path project)
                path project)))))

(defun project-file-add (project path &key comment)
  (progn ;bind-file-info (projector-file-p exists-locally-p) project path
    (if t ;(not projector-file-p)
      (progn
        (remove-pathname-from-cache path)
        (mpw-checkin (mac-namestring path) :new t :project (projector-name project) :comment comment
                     :yes-to-dialogs t)
        (set-path-windows-readonly-state path :read-only "checked in")
        (update-projector-file-state path))
      (cerror "Ignore error" "File ~s already exists in project ~s." path (projector-name project)))))

(defun project-file-delete (project path)
  (bind-file-info (projector-file-p) project path
    (if  projector-file-p
      (progn
        (remove-pathname-from-cache path)
        (mpw-delete (mac-file-namestring path) :project (projector-name project)))
      (cerror "Ignore error" "File ~s is not in project ~s." path (projector-name project)))))
  

(defun project-file-modro (project path)
  (bind-file-info (local-checked-out-p modrop) project path
    (cond
     (local-checked-out-p
      (signal-project-error 'project-file-already-checked-out project
                           "~/pp-path/ can't be made ModifyReadOnly because it is already checked out."
                           path))
     (modrop
      (signal-project-error 'simple-project-error project
                           "~/pp-path/ can't be made ModifyReadOnly because it is already ModifyReadOnly."
                           path))
     (t (set-file-modify-read-only path)))))

(defun project-file-orphan (project path)
  (declare (ignore project))
  (remove-pathname-from-cache path)
  (remove-ckid-resource path))

(defun project-file-cancel-checkout (project path &key convert-to-modro)
  (bind-file-info (local-checked-out-p projector-name remote-checked-out-p remote-user)
                  project path
    (declare (ignore local-checked-out-p remote-user remote-checked-out-p))
#|
    (unless local-checked-out-p
      (signal-project-error 'simple-project-error project
                            "Can't cancel checkout because ~/pp-path/ is not checked out."
                            path))
    (when remote-checked-out-p
      (restart-case
        (project-file-checked-out remote-user
                                  "Can't cancel checkout because ~/pp-path/ is checked out to: ~s."
                                  path remote-user)
        (cancel-remote-checkout ())))
|#
    (if (not convert-to-modro)
      
      ;;throw away changes and retrieve latest version
      (mpw-checkout path :cancel t :yes-to-dialogs t :project projector-name)
      
      ;;keep changes and convert to modro
      ;; @@@ consolidate this with the code in project-cancel-checkout
      (let ((temp-name (temporary-file-name path)))
        ;;kludge around projector limitations -- can't cancel checkout without getting new version
        (copy-file path temp-name)
        (mpw-checkout (mac-namestring path) :cancel t :yes-to-dialogs t :project projector-name)
        (delete-file path)
        (rename-file temp-name path)
        (set-file-local-checked-out-p path nil)
        (set-file-modify-read-only path)))))

(defun project-file-cancel-modro (project path)
  (bind-file-info (modrop projector-name local-version)
                  project path
    (unless modrop
      (signal-project-error 'simple-project-error project
                           "Can't cancel ModifyReadOnly because ~/pp-path/ is not ModifyReadOnly."
                           path))
    (delete-file path)
    (mpw-checkout (mac-namestring path) :project projector-name :version local-version)))

#|
(defun project-file-versions (project path)
  (mapcan #'(lambda (line)
              (unless (string= line "")
                (multiple-value-bind (name version state)
                                     (name-and-version (mpw-unquote line))
                  (declare (ignore name))
                  (when (eq state :checked-in)
                    (list version)))))
          (break-string-into-list
           (mpw-projectinfo :file (file-namestring path) :project (projector-name project)
                            :short t))))
|#


(defun project-file-get (project path &key version directory)
  (mpw-checkout (file-namestring path) :project (projector-name project)
                :version version :directory (and directory (mac-namestring directory))))

;;;
;;; File information
;;;

(defun projector-file-project-name (path)
  (nth-value 1
             (projector-local-file-info nil path :project-name-request t)))

(defun project-file-local-info (project path)
  (bind-file-info (projector-file-p projector-name modrop
                   local-checked-out-p local-comment local-user local-version)
                  project path
    (when projector-file-p
      (list :projector-name projector-name
            :state (cond (modrop :modro)
                               (local-checked-out-p :checked-out)
                               (t :checked-in))
            :comment local-comment
            :user local-user
            :version local-version
            :allow-other-keys t))))

(defun project-file-remote-info (project path)
  (bind-file-info (remote-checked-out-p remote-comment remote-user remote-version)
                  project path
    (list :state (if remote-checked-out-p :checked-out :checked-in)
          :comment remote-comment
          :user remote-user
          :version remote-version
          :allow-other-keys t)))

(defun project-file-local-state (project path)
  (bind-file-info (projector-file-p modrop local-checked-out-p)
                  project path
    (when projector-file-p
      (cond (modrop :modro)
            (local-checked-out-p :checked-out)
            (t :checked-in)))))

(defun project-file-local-comment (project path)
  (bind-file-info (local-comment) project path
    local-comment))

(defun project-file-local-version (project path)
  (bind-file-info (local-version) project path
    local-version))

(defun project-file-in-project (project path)
  (projector-local-file-info project path))

(defun project-file-versions (project path)
  (let (versions lines)
    (dolist (line (break-string-into-list
                   (mpw-projectinfo :file (file-namestring path)
                                    :project (projector-name project)
                                    :comments t))
                  (nreverse versions))
      (cond ((and (> (length line) 0)
                  (char= (char line 0) #\Space))
             (push line lines))
            (t
             (when lines
               (multiple-value-bind (checked-out-p comment user version)
                                    (parse-projector-file-info (nreverse lines))
                 (push `(:version ,version
                                  :state ,(if checked-out-p :checked-out :checked-in)
                                  :user ,user :comment ,comment) versions)))
             (setq lines (list line)))))))
;;;
;;; Projector name operations
;;;

(defun find-projector-name (projector-name)
  (dolist (project *projects* nil)
    (and (typep project 'mpw-project)
         (string-equal projector-name (projector-name project))
         (return project))))

(defun projector-name-parent-name (projector-name)
  (let ((position (position #\บ projector-name :from-end t
                            :end (- (length projector-name) 2))))
    (when position
      (subseq projector-name 0 (1+ position)))))

(defun projector-name-leaf-name (projector-name)
  (let* ((length (length projector-name))
         (position (position #\บ projector-name :from-end t :end (- length 2))))
    (subseq projector-name (1+ (or position -1)) (1- length))))

;; @@@ this ought to be split into some find-or-make thingy, and
;; an initialize-instance method on mpw-project
(defun intern-projector-name (local-dir projector-name remote-pathname &optional parent)
    (or (find-projector-name projector-name)        
        (make-instance 'mpw-project
          :local-dir local-dir
          :projector-name projector-name
          :remote-pathname remote-pathname
          :parent
          (or parent
              (let ((parent-name (projector-name-parent-name projector-name)))
                (when parent-name
                  (intern-projector-name
                   (make-pathname :host (pathname-host local-dir) :defaults nil
                                  :directory (butlast (pathname-directory local-dir)))
                   parent-name
                   (make-pathname
                    :host (pathname-host remote-pathname)
                    :defaults nil
                    :directory (butlast (pathname-directory remote-pathname))))))))))


;;;
;;; Project operations
;;;

(defun project-getnewer (project &key verbose)
  (let ((result (mpw-checkout nil :progress t :newer t :project (projector-name project))))
    ;(format t "~%~A" result)
    (and verbose result
         (format t "~%~A" result))))

(defun project-info-text (project &rest options &key file &allow-other-keys)
  (apply #'mpw-projectinfo :project (projector-name project)
         :file (and file (file-namestring file))
         options))

(defun mpw-project-mount (project)
  (when (project-root-p project)
    (let* ((remote-dir (project-remote-pathname project))
           (local-dir (namestring (truename (project-local-dir project))))
           (local-dir-len (length local-dir))
           (cur-app-path (mac-namestring (ccl::current-application-pathname))))
      ;; For some unknown reason, Projector crashes when trying to
      ;; checkout all into a directory that contains a running application.
      ;;
      ;; Actually, I bet the reason is that Leibniz at some point does a
      ;; projector-local-file-info, on the files in the directory, which involves
      ;; opening its resource fork in order to get the ckid, and then closing it
      ;; again regardless of whether it had been open before the OpenResource
      ;; call was made.
      ;; @@@ this should be fixed.
      (assert (or (< (length cur-app-path) local-dir-len)
                  (not (string-equal local-dir cur-app-path :end1 local-dir-len)))
              nil
              "The running application: ~s cannot be in a directory or subdirectory of a ~
               project directory: ~s." cur-app-path local-dir)
      (do ()
        ((probe-file remote-dir))
        (restart-case
          (signal-project-error 'project-volume-not-available project
                                "Project ~A requires volume ~S to be mounted."
                                project (project-volume project))
          ;; @@@ add a :report for this condition
          (volume-mounted ())))
      (mpw-mountproject (truename remote-dir))
      (mpw-command "CheckoutDir" "-r" (mpw-quote local-dir)))))

(defun refresh-mpw-projects (mpw-projects)
  (dolist (project *mounted-projects*)
    (when (and (typep project 'mpw-project)
               (project-parent project))
      (project-unmounted project)))
  (dolist (projector-name mpw-projects)
    (let ((project
           (or (find-projector-name projector-name)
               (let* ((parent-name (projector-name-parent-name projector-name))
                      (parent (and parent-name (find-projector-name parent-name))))
                 (when parent
                   (let ((leaf-list (list (projector-name-leaf-name projector-name))))
                     (intern-projector-name
                      (make-pathname
                       :host (pathname-host (project-local-dir parent))
                       :defaults nil
                       :directory (append (pathname-directory (project-local-dir parent))
                                          leaf-list))
                      projector-name
                      (make-pathname
                       :host (pathname-host (project-remote-pathname parent))
                       :defaults nil
                       :directory (append (pathname-directory (project-remote-pathname parent))
                                          leaf-list))
                      parent)))))))
      (when project
        (project-mounted project)))))

(defun mpw-projects-mount (projects &aux (mpw-projects (mpw-mounted-projects)) refresh)
  (dolist (project projects)
    (if (member (projector-name project) mpw-projects :test #'string-equal)
      (project-mounted project)
      (progn
        (project-unmounted project)
        (mpw-project-mount project)
        (setq refresh t))))
  (refresh-mpw-projects (if refresh (mpw-mounted-projects) mpw-projects)))

(defmethod project-mount ((project mpw-project))
  (when (project-root-p project)
    (mpw-project-mount project))
  (apply #'refresh-mpw-projects project)) ; was (refresh-mpw-projects))

(defmethod project-name ((project mpw-project))
  (projector-name project))

(defmethod project-unmount ((project mpw-project))
  (when (project-root-p project)
    (mpw-command "UnmountProject" (mpw-quote (projector-name project))))
  (call-next-method)
  (mapc #'project-unmounted (project-children project)))

(defmethod project-new-project ((project mpw-project))
  (let ((pdir (project-remote-pathname project)))
    (format t "~%Creating project ~a." project)
    (mpw-command  "NewProject" (mpw-quote (mac-directory-namestring pdir)) ; ??
                  "-u" (or *user* "Unknown"))
    (dolist (subproj (project-children project))
      (when (not (probe-file (project-remote-pathname subproj)))
        (project-new-project subproj)))))

;;;
;;; Utility functions
;;;

(defun project-newer-files (project)
  (do* ((file-list nil)
        (ckoutdir (namestring (project-local-dir project)))
        (newer-str (project-info-text project :newer t :short t))
        (cur-pos (position #\return newer-str)))
       ((null cur-pos) file-list)
    (let* ((start-pos (position-if-not #'(lambda (char) (memq char '(#\space #\'))) newer-str :start (1+ cur-pos)))
           (end-pos (position #\, newer-str :start cur-pos)))
      (when (and start-pos end-pos)
        ;; @@@ merge-pathnames
        (let ((path (concatenate 'string ckoutdir (subseq newer-str start-pos end-pos))))
          (when (probe-file path)
            (bind-file-info (modrop) project path
              (unless modrop (push path file-list))))))
      (setq cur-pos (position #\return newer-str :start (1+ cur-pos))))))

(defun project-categorize-modified-files (project)
  (let ((check-in-files ())
        (check-out-and-in-files ())
        (merge-in-files ())
        (wedge-files ())
        (changed-wedge-files ()))
    (do-project-files
     project
     #'(lambda (path)
         (bind-file-info (local-checked-out-p modrop local-version)
                         project path
           (if local-checked-out-p
             (push path check-in-files)
             (bind-file-info (remote-checked-out-p remote-user remote-version) project path
               (if modrop
                 (let ((same-version (string-equal local-version remote-version)))
                   (if remote-checked-out-p
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
                       (push path merge-in-files)))))
               (when (> (parse-integer local-version :radix 10.)
                        (parse-integer remote-version :radix 10.))
                 (format t "~&Warning: Local version of ~s is greater than projector database version"
                         path)
                 (push path merge-in-files)))))))
    (values check-in-files check-out-and-in-files merge-in-files wedge-files changed-wedge-files)))

;;; Old change history from projector.lisp:
;;; 03/24/92 jaj  if MPW fails to check in file, warn and keep trying.
;;;               fixed bug in check-in-projects
;;; 02/24/92 jaj  find-latest-leibniz-version works, search for ~~ from end,
;;;               cancel-checkout-dialog is centered, checkout modro passes -y
;;; 02/12/92 alms use y-or-n-dialog function, rather than class.
;;; 1/21/92  jaj  got rid of "foo", use chooser name as default in user-mount-volume,
;;;               error in mount-projects if current app is in project (sub)dir,
;;;               bigger "add to current project" dialog, don't select listener in project-info,
;;;               add-change saves selection and scroll-position, cancel-checkout puts up a
;;;               dialog.  add ccl::*save-all-old-projector-versions*
;;; 01/07/92  gz  correct args to message-dialog.  'fred-window -> *default-editor-class*
;;; 12/6/91  jaj  add missing parameter to warn
;;; 12/5/91  jaj  don't overwrite old comments that have ~~
;;; 11/7/91  jaj  minor cleanup for adding comments
;;; 11/06/91 gz  Don't mess around with *restore-lisp-functions*, it's going away.
;;; 11/05/91 gz  Convert to new traps.
;;;6-nov-91  alms remove center-size-in-screen, don't move selection before saving
;;;6-nov-91  jaj  fix last fix
;;;5-nov-91  jaj  fix stupidity in check-out-file (not getting newer versions)
;;;1-nov-91  jaj  added projector icons to mini-buffer
;;;23-oct-91 jaj  fixed find-project-check-out-dir, simplified logical hosts,
;;;               don't delete buffer in check-out-file
;;;18-oct-91 jaj  almost a complete rewrite
;;;23-sep-01 jaj  incorporated Tom Vrhel's patches
;;;21-aug-91 jaj  many bug fixes and enhancements
;;;14-aug-91 alms don't redefine view-key-event-handler for window
;;;               comment-dialog allows returns
;;;06-aug-91 jaj  fix bugs in cancel-checkout and aux functions

#|
;;; Old change history from projector.lisp:
	Change History (most recent last):
	1	4/29/91	JRM	'add entry to change log in check out active'
	2	4/29/91	lak	'Add in ProjectInfo menu item.'
	3	4/30/91	grf	changed mount-all-projects to accept \"home;\"
				forms... now *my-projects* can include pathnames
				like: \"home;newton:\".
        4	4/30/91	pjp	working on facility that auotmatically appends
        			comments to bottom of file.  Also fixed various
        			bugs
	5	4/30/91	pjp	Fixing the numbering
        			of thse comments at the bottom of the file.
	6	5/6/91	jcg	0.2.5 changes: new pathname form
	7	5/9/91	jcg	+ changing load of ff to use requires
				+ save file after checkout
	8	5/10/91	jcg	ff, ProjectorLib.o loads commented out;
				now part of bootstrapping phase to make
				image
	9	5/10/91	jcg	more fixes
	10	5/14/91	pjp	add new items to the projectinfo menu item:
				"Modifiable on my disk"
				"History of Active window"
				Also added new hierarchical menu "Rarely used stuff":
				"Cancel Checkout Active"
	4	5/30/91	ads	Adding comments to "Currently Checked Out"
                                Modifying ProjectInfo-Active Window
                                Fixing bug in Cancel Active Checkout
	5	5/31/91	tv 	Added user protections before asking for comments
				
	6	5/31/91	tv 	fixing checkinActive free variable
				
	7	6/3/91	tv 	Changed MakeCurProjectMenu to protect from double entries
				
	8	6/3/91	jcg	moving over to Leibniz 1.0:
				  + file goes in ralphdebug package (adbg)
	11	6/6/91	   	more bug fixes
	12	6/6/91	   	changing menu updates, layouts
	13	6/6/91	   	testing cancel active
	14	6/10/91	tv 	fixing word wrap in static-text-dialog-item
	15	6/10/91	tv 	testing checkin/checkout for 1.1d06
	17	6/17/91	tv 	menu deletion hack
	18	6/17/91	tv 	testing menu hack
	19	6/17/91	tv 	testing menu hack
	20	6/17/91	tv 	testing before release
	21	6/17/91	tv 	Fix for updating with checkin all and checkin current project
	22	6/25/91	tv 	fixing for ralph opens
	23	6/25/91	tv 	Fixed current-project switch
	24	6/25/91	tv 	changing to be compatible with new menubars
	25	6/25/91	tv 	fixing menubars
	26	6/25/91	tv 	sanity check - 1.1d15 release
	27	7/17/91	jaj 	*user-initials* and *my-projects* are retrieved by functions
        0       8/05/91 gz      Use symbolic names for read-only states.
	2	9/12/91	alms	Fix bug in unquoted project names
	4	10/18/91	jaj	test
	4	10/18/91	jaj	test
	1	10/18/91	jaj	many changes
	2	10/18/91	jaj	test2, in
	3	10/18/91	jaj	test2, in
	4	10/18/91	jaj	fix to update-leibniz-version
	6	10/23/91	jaj	minor fix in update-leibniz-version
	8	10/31/91	gsb	Don't produce ratios when computing screen positions
	8	10/31/91	gsb	yes
	10	11/5/91	jaj	fix stupidity in check-out-file (not getting newer
				versions)
	11	11/6/91	jaj	fix to last fix
	14	11/8/91	gsb	Put correct newlines in auto-inserted comments.
	14	11/8/91	gsb	Don't insert comment lines without a newline.
	16	1/6/92	jh	Fix dependency on logical pathname
	19	2/19/92	alms	fix y-or-n-dialog.
	20	2/24/92	jaj	bug fixes
	22	3/12/92	ows	only ignore projects that aren't in *my-projects*
	23	3/13/92	ows	compare directory names with string-equal, for case-independence
	24	3/24/92	jaj	fix bugs
	25	3/24/92	jaj	bug fix
	26	3/24/92	jaj	test
	27	3/24/92	jaj	test
	28	3/25/92	ows	switched use of fprojector to new-style mpw-command
				made cancel dialog bigger
	29	3/27/92	ows	(my-projects) updates the "Update Leibniz Version" menu item now.
				Fixed the ธีs menu item.
|# ;(do not edit past this line!!)

#|
trying to make pathnames be logical in project objects
|#

#|
	Change History (most recent last):
	1	4/3/92	ows	split from projector.lisp
	2	4/3/92	ows	split from projector.lisp
	4	4/3/92	ows	fix some problems with checkout and cancel-checkout
	6	4/7/92	ows	changed the bug address
	10	4/24/92	ows	allow file-checkout of files that dont exist locally
	11	4/29/92	ows	with-open-resource-file -> with-open-res-file (see note)
	1	9/28/93	HW	Now it's in RSTAR SourceServer.
	2	2/25/94	akh	intern-projector-name takes a remote-pathname and refresh-mpw-projects calls it with one
	3	2/28/94	akh	Trivia
	2	3/29/94	akh	Get1Resource when looking for file CKID resources else may get some unexpected CKID resource from another open resfile
	3	4/7/94	akh	Logical pathnames in project objs
	4	4/7/94	akh	get pathname-host in subprojects
	5	5/3/94	akh	added delete to other-file-menu - removes file from project
	2	12/20/94	akh	project-file-add gets makes window read only if exists
	3	12/22/94	akh	project-new-project creates children too
|# ;(do not edit past this line!!)
