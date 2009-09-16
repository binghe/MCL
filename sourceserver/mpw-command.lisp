
;;	Change History (most recent first):
;;  2 5/23/95  akh  make-file-and-version-name - use mac-namestring
;;  3 1/11/95  akh  conditionalize let-globally
;;  (do not edit before this line!!)

;;; 04/27/93 swd mpw-projectinfo now handles :revision-dates and :file-dates keys.
;;; 03/24/92 jaj mpw-command now checks MPW status
;;; 01/21/92 jaj added restart around sending appleevent
;;; 01/15/92 gz  In case of multiple MPW processes, prefer the *mpw-path* one.
; 1/3/92   jaj   added current-application-pathname, chooser-name
;;; 11/05/91 gz  Convert to new traps.
;16-sep-91 jaj  handle aborts during mpw error
;12-sep-91 alms/jaj  fix to speed up processing of MPW commands
;15-aug-91 jaj  add *mpw-path*, use or set *user-initials*.  turn #\return into ¶n
; 6-aug-91 jaj  put up watch cursor and disable event processing while doing mpw-command


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; 01/17/96 bill  New trap names
;;

(in-package :ccl)

(eval-when (eval compile load)
  (require 'appleevent-toolkit))

(defparameter *mpw-target* nil)
(defparameter *mpw-name* nil)
(defparameter *mpw-comm-file* nil)
(defparameter *mpw-error-file* nil)
(defparameter *mpw-status-file* nil)
(defparameter *mpw-done-file* nil)
(defvar *mpw-path* nil)
;(defvar *user-initials*)

(defun mpw-comm-file ()
  (or *mpw-comm-file*
      (setq *mpw-comm-file*
            (mac-namestring (merge-pathnames "mpw-to-mcl" (or (find-folder "temp") "ccl:"))))))

(defun mpw-error-file ()
  (or *mpw-error-file*
      (setq *mpw-error-file*
            (mac-namestring (merge-pathnames "mpw-errors" (or (find-folder "temp") "ccl:"))))))

(defun mpw-status-file ()
  (or *mpw-status-file*
      (setq *mpw-status-file*
            (mac-namestring (merge-pathnames "mpw-status" (or (find-folder "temp") "ccl:"))))))

(defun mpw-done-file ()
  (or *mpw-done-file*
      (setq *mpw-done-file*
            (mac-namestring (merge-pathnames "mpw-done" (or (find-folder "temp") "ccl:"))))))

(def-load-pointers clear-mpw-comm-vars ()
  (setq *mpw-comm-file* nil
        *mpw-error-file* nil
        *mpw-status-file* nil
        *mpw-done-file* nil
        *mpw-target* nil
        *mpw-name* nil))

(defun choose-mpw-target ()
  (loop
    (with-simple-restart
      (nil "Try connecting to ~S again." *mpw-path*)
      (labels ((try-to-connect ()
                 (multiple-value-bind (psnhigh psnlow path) (find-mpw-process)
                   (when psnhigh
                     (verify-mpw-version path)
                     (return-from choose-mpw-target (set-mpw-psn-target psnhigh psnlow))))))
        (try-to-connect)
        (let ((path *mpw-path*))
          (unless (and path (probe-file path))
            (message-dialog "Please locate MPW Shell (3.3 or later)")
            (setq path (choose-file-dialog :button-string "Launch"
                                           :mac-file-type :APPL
                                           :mac-file-creator :|MPS |)
                  *mpw-path* path))
          (verify-mpw-version path)
          (loop
            (handler-case (return (sublaunch path nil t))
              (simple-error (c)
               (if (string= (simple-condition-format-string c)
                            "Not enough room in heap zone.")
                 (cerror (format nil "Try launching ~S again." path)
                         "Not enough system memory to launch ~S." path)
                 (signal c)))))
          (loop 
            (event-dispatch)
            (if (mpw-idle-p) (return)))
        (if (and (boundp '*user-initials*) *user-initials*)
          (old-mpw-command (concatenate 'string "set user '" *user-initials* "'")))))))
  (unless (and (boundp '*user-initials*) *user-initials*)
    (let ((str (old-mpw-command "echo {user}")))
      (setq *user-initials* (subseq str 0 (1- (length str)))))))

(defun verify-mpw-target ()
  (unless *mpw-target*
    (choose-mpw-target)))

#|
(defun current-zone ()
  (let ((servers (old-mpw-command "choose -list")))
    (string-trim '(#\') (subseq servers 0 (position #\: servers)))))
|#

(defun verify-mpw-version (path)
  (unless (and (eq :|MPS | (mac-file-creator path))
               (eq :|APPL| (mac-file-type path)))
    #|
               (let ((resh (get-resource-from-file path "vers" 1)))
                 (prog1
                   (with-dereferenced-handles ((r resh))
                     (print-db path (%get-byte r) (%get-byte r 1))
                     (and (>= (%get-byte r) 3) (>= (%get-byte r 1) 3)))
                   (#_DisposeHandle resh))))
|#

    (error "~s is not an MPW Shell version 3.3 or later" path))
  (setq *mpw-name* (mac-file-namestring path)))

#+unused
(defun get-resource-from-file (path sig num)
  (with-pstrs ((pp (mac-namestring path)))
    (let* ((resh (%null-ptr))
           (curfile (#_CurResFile))
           (refnum (#_OpenResFile pp)))
      (#_UseResFile refnum)
      (%setf-macptr resh (#_Get1Resource sig num))
      (#_UseResFile curfile)
      (#_DetachResource resh)
      (#_CloseResFile refnum)
      resh)))

(defun forget-mpw-target ()
  (when *mpw-target*
    (dispose-record *mpw-target* :aeaddressdesc)
    (setq *mpw-target* nil)))

(defun set-mpw-psn-target (psnhigh psnlow)
  (let ((success nil))
    (unless *mpw-target*
      (setf *mpw-target* (make-record (:aeaddressdesc :clear t))))
    (unwind-protect
      (progn
        (create-psn-target *mpw-target* psnhigh psnlow)
        (setq success t))
      (unless success
        (forget-mpw-target)))))

(defun delete-file-until-not-busy (filename)
   ;; Delete a file.  It's okay if the file doesn't exist; if it does, and it's still
   ;; busy, try forever until it's released.  Used by mpw-command for synchronization.
   (loop
      (handler-case (delete-file filename)
         (file-error (condition)
           ;; The string= is a terrible, terrible kludge.  It wants a condition system that
           ;; includes different file errors or at least has a slot for the error code in
           ;; order to do better
           (if (string= (slot-value condition 'ccl::error-type)
                             "File ~^~S is busy or locked.")
               (event-dispatch t)
               (error condition)))
         (:no-error (value)
           (declare (ignore value))
           (return)))))

(defun mpw-basic-send (str)
   (with-aedescs (ae reply)
       (create-appleevent ae :|MPS | :|scpt| *mpw-target*)
       (ae-put-parameter-char ae #$keyDirectObject str)
       (with-simple-restart
           (retry-send-appleevent "Send AppleEvent again.")
           (send-appleevent ae reply))))

(defun old-mpw-command (command-line)
  (verify-mpw-target)
  (let* ((temp-file (mpw-comm-file))
         (err-file (mpw-error-file))
         (status-file (mpw-status-file))
         (done-file (mpw-done-file)))
    (when (probe-file done-file)
          (%stack-block ((p 18))
            (get-next-event p t 0 60))
          (delete-file-until-not-busy done-file))
    (#+processes let-globally #-processes let ((*processing-events* t))         
      (with-cursor *watch-cursor*
                (mpw-basic-send (format nil "~a > ~A ³ ~A"
                         command-line (mpw-quote temp-file) (mpw-quote err-file)))
                (mpw-basic-send (format nil "echo {status} > ~A; echo > ~A"
                         (mpw-quote status-file) (mpw-quote done-file)))
        (loop
          (%stack-block ((p 18))
            (get-next-event p t 0 60))
          (if (probe-file done-file) (return)))))
    (let ((status (read-from-string (file-to-string status-file))))
      (if (eq status 0)
        (if (neq 0 (file-size temp-file))
          (file-to-string temp-file)
          nil)
        (let ((message (if (eq 0 (file-size err-file)) "No Message" (file-to-string err-file))))
          (error "MPW Error status: ~a message:~a" status message))))))

(defun file-size (path)
  (%stack-iopb (pb np)
    (%path-to-iopb path pb :errchk)
    (#_PBHGetFInfoSync pb)
    (%get-long pb $ioFlLgLen)))

(defun file-to-string (path)
  (let ((size (file-size path)))
    (%stack-iopb (pb np)
      (%path-to-iopb path pb :errchk)
      (%vstack-block (buff size)
        (#_PBHOpenSync :errchk pb)
        (%put-ptr pb buff $ioBuffer)
        (%put-long pb size $ioReqCount)
        (%put-word pb #$fsAtMark $ioPosMode)
        (#_PBReadSync pb)
        (#_PBCloseSync pb)
        (%str-from-ptr buff size)))))

(defun find-mpw-process ()
  (let ((mpw-path (full-pathname *mpw-path*))
        last-high last-low last-path)
    (rlet ((pinfo ProCessInfoRec)
           (fss fsspec)
           (psn ProcessSerialNumber)
           (procname (:string 32)))
      (rset pinfo :pRocessInfoRec.proCessNamE procname)
      (rset pinfo :ProcessInfoRec.processAppSpec fss)
      (rset psn :ProceSsSerialNumber.highLongOfPSN #$kNoProcess)
      (rset psn :ProceSsSerialNumber.lowLongOfPSN #$kNoProcess)
      (loop
        (unless (eql #$NoErr (#_GetNextProcess psn)) (return))
        (rset pinfo :processInfoRec.ProcessInfoLength #x3c)
        (unless (eql #$NoErr (#_GetProcessInformation psn pinfo)) (return))
        (when (eq  :|MPS | (rref pinfo :ProcessInfoRec.processSignature))
          (setq last-high (rref psn :ProceSsSerialNumber.highLongOfPSN)
                last-low (rref psn :ProceSsSerialNumber.lowLongOfPSN)
                last-path (%path-from-fsspec (rref pinfo :ProcessInfoRec.processAppSpec)))
          (when (equalp last-path mpw-path)
            (return)))))
    (values last-high last-low last-path)))

(defun current-application-pathname ()
  (rlet ((pinfo ProcessInfoRec)
         (fss fsspec)
         (psn ProcessSerialNumber))
    (%stack-block ((procname 33))
      (#_GetCurrentProcess psn)
      (rset pinfo :processInfoRec.processName procname)
      (rset pinfo :processInfoRec.processAppSpec fss)
      (rset pinfo :processInfoRec.processInfoLength #x3c)
      (#_GetProcessInformation psn pinfo)
      (%path-from-fsspec (rref pinfo :ProcessInfoRec.processAppSpec)))))

(defun chooser-name ()
  "returns macintosh name, else chooser name, else \"unspecified\""
  (let ((h (#_GetString -16096)))
    (unless (or (%null-ptr-p h) (%null-ptr-p (%get-ptr h)) (eql 0 (%get-byte (%get-ptr h))))
      (%get-string h))))

(defun mpw-idle-p (&optional (transaction-id #$kAnyTransactionID))
  (verify-mpw-target)
  (with-aedescs (ae reply)
    (create-appleevent ae :|MPS | :|stat| *mpw-target* :transaction-id transaction-id)
    (send-appleevent ae reply :reply-mode :wait-reply)
    (ae-error (get-error-number reply))
    (equalp *mpw-name* (ae-get-parameter-char reply :|who |))))

;;; Functions beneath here are from my own Projector system.
;;; I haven't tried to integrate them with the functions above;
;;; I've only added them where the functions above weren't doing
;;; the right thing.  I'll probably migrate towards something like this
;;; that splits out talking-to-mpw functionality and knowledge of MPW
;;; command strings from Projector functionality, to make it easier
;;; to replace the latter with POGO as a first step towards database
;;; migration. -- ows 3/5/92

(export '(mpw-quote mpw-unquote mpw-command))

(defvar *mpw-trace* nil)
(defvar *mpw-magic-characters* "\"'#\\/{}[]`?Å*+ÇÈ<>³·É¶")
(defvar *mpw-quotable-characters*
   #.(concatenate 'simple-string '(#\¶ #\' #\Newline)))


(defparameter *mpw-quotable-characters*
   #.(concatenate 'simple-base-string '(#\' #\Newline)))

(defun mpw-quote (name)
   "Quote a string for MPW"
   (let ((needs-quoting
          (or (string= name "")
              (find-if #'(lambda (char)
                           (or (find char *mpw-magic-characters*)
                               (find char '(#\Space #\Tab))
                               ))
                       name)))
           (needs-character-quoting
             (find-if #'(lambda (char) (find char *mpw-quotable-characters*))
                         name)))
      (flet ((quote-quotables (string)
                  (with-output-to-string (output)
                      (with-input-from-string (input string)
                          (do (char)
                                ((null (setq char (read-char input nil))))
                             (if (find char *mpw-quotable-characters*)
                                (write-char #\¶ output))
                             (write-char char output)))))
               (quote-whole-string (string)
                  (concatenate 'simple-string "\"" string "\"")))
        (cond (needs-character-quoting
               (quote-whole-string (quote-quotables name)))
              (needs-quoting
               (quote-whole-string name))
              (t name)))))

(defun mpw-unquote-stream (stream)
   "Unquote a stream that's returned by MPW"
   (with-output-to-string (output)
       (let ((quoted nil))
          (do (char)
                ((or (null (setq char (read-char stream nil)))
                       (and (not quoted) (member char '(#\Space #\Tab #\Newline)))))
             (case char
                (#\¶ (write-char (read-char stream) output))
                (#\' (while (char/= (setq char (read-char stream)) #\')
                            (write-char char output)))
                (t (write-char char output)))))))

(defun mpw-unquote (string)
   "Unquote a string that's returned by MPW"
   (with-input-from-string (stream string)
       (mpw-unquote-stream stream)))

(defun append-mpw-args (&rest args)
   "Paste the arguments together with spaces in between.  Each
argument can either be nil, in which case it's ignored, a list, in
which case each of its elements is recursively pasted into the stream,
or any other item, which is simply printed."
   (with-output-to-string (stream)
       (labels ((print-args (args)
                       (when args
                           (let ((arg (first args)))
                              (typecase arg
                                 (null)
                                 (list (print-args arg))
                                 (t (princ #\Space stream)
                                     (princ (first args) stream))))
                           (print-args (rest args)))))
          (print-args args))))

(defun mpw-command (&rest args)
   "Send a list of arguments to MPW, and wait for a reply.  Return the reply string,
or nil if it's empty.  If an error occurred, signal that instead.  If *mpw-trace* is
non-nil, echo the command."
   (let ((send-text (append-mpw-args args)))
      (when *mpw-trace* (print send-text))
      (loop
         (restart-case
            (handler-case (return (old-mpw-command send-text))
              (appleevent-error (c)
               (when (eq (slot-value c 'ccl::oserr) #$procNotFound)
                 (progn
                   (cerror "Reconnect to MPW." "The MPW process was not found.")
                   (invoke-restart 'reconnect-to-mpw))
                 (signal c))))
           (resend-mpw-command ()
           :report (lambda (stream) (princ "Send MPW command again." stream)))
           (reconnect-to-mpw ()
            :report (lambda (stream) (princ "Reconnect to MPW." stream))
            (choose-mpw-target))))))

;;;
;;; Projector primitives
;;;

(export '(mpw-mount-volume mpw-projectinfo mpw-checkout mpw-checkin mpw-mountproject))

(defun mpw-argument (switch setting)
  "If setting is non-nil, return it as an MPW argument of type switch."
  (and setting (list switch (mpw-quote setting))))

(defun make-file-and-version-name (file version)
  "Construct a Projector-style name for the specified version, if any, of the file."
  (let ((name (mac-namestring file)))
    (mpw-quote (if version
                 (format nil "~A,~A" name version)
                 name))))

(defun mpw-mount-volume (path &key user password)
  "Mount a volume with MPW."
  (assert (or password (not user)) nil "Password required")
  (mpw-command "Choose"
               (mpw-argument "-pw" password)
               (mpw-argument "-u" user)
               (and (not user) (not password) "-guest")
               (mpw-quote path)))

#|
(defun mpw-projectinfo (&key file version checked-out comments latest log newer project recursive short)
  "Low-level access to the ProjectInfo command."
  (mpw-command "ProjectInfo"
               (mpw-argument "-project" project)
               (and comments "-comments")
               (and latest "-latest")
               (and newer "-newer")
               ; (and file-info "-f")
               (and recursive "-r")
               (and short "-s")
               ; (and only "-only")
               (and checked-out "-m")
               (and log "-log")
               ; (mpw-argument "-f" revised-by)
               ; (mpw-argument "-af" created-by)
               ; (mpw-argument "-d" revision-dates)
               ; (mpw-argument "-df" file-dates)
               ; (mpw-argument "-c" revision-pattern)
               ; (mpw-argument "-cf" file-pattern)
               ; (mpw-argument "-t" task-pattern)
               ; (mpw-argument "-n" name)
               ; (and update "-update")
               (and file
                    (make-file-and-version-name file version))))
|#


(defun mpw-projectinfo (&key file version checked-out comments latest log 
                             newer project recursive short 
                             revision-dates
                             file-dates
                             )
  "Low-level access to the ProjectInfo command."
  (mpw-command "ProjectInfo"
               (mpw-argument "-project" project)
               (and comments "-comments")
               (and latest "-latest")
               (and newer "-newer")
               ; (and file-info "-f")
               (and recursive "-r")
               (and short "-s")
               ; (and only "-only")
               (and checked-out "-m")
               (and log "-log")
               ; (mpw-argument "-f" revised-by)
               ; (mpw-argument "-af" created-by)
               ; (mpw-argument "-d" revision-dates)
               ;; 04/27/93: SWD: Added.
               (if revision-dates 
                 (list "-d" revision-dates))
               ; (mpw-argument "-df" file-dates)
               (if file-dates
                 (list "-df" file-dates))
               ; (mpw-argument "-c" revision-pattern)
               ; (mpw-argument "-cf" file-pattern)
               ; (mpw-argument "-t" task-pattern)
               ; (mpw-argument "-n" name)
               ; (and update "-update")
               (and file
                    (make-file-and-version-name file version))))


(defun mpw-checkout (file &key comment directory modifiable version project newer progress cancel
                          yes-to-dialogs)
  "Medium-level access to the Checkout command."
  (mpw-command "CheckOut"
               ; (and all "-a")
               ; (and branch "-b")
               ; (and cancel-conflict-dialog "-c")
               (and cancel "-cancel")
               ; (and comment-file "-cf")
               ; (and close-window "-close")
               (mpw-argument "-cs" comment)
               (mpw-argument "-d" directory)
               (and modifiable "-m")
               ; (and no-to-dialogs "-n")
               (and newer "-newer")               
               ; (and notouch "-noTouch")
               ; (and open "-open")
               (and progress "-p")
               (mpw-argument "-project" project)
               ; (and recursive "-r")
               ; (mpw-argument "-t" task)
               ; (mpw-argument "-u" user)
               ; (and update "-update")
               ; (and open-window "-w")
               (and yes-to-dialogs "-y")               
               (if (listp file)
                 file
                 (make-file-and-version-name file version))))

(defun mpw-checkin (file &key project comment new yes-to-dialogs)
  (mpw-command "CheckIn"
               (and new "-new")
               (and yes-to-dialogs "-y")
               (mpw-argument "-cs" comment)
               (mpw-argument "-project" project)
               (mpw-quote file)))

(defun mpw-delete (file &key project (yes-to-dialogs t))
  (mpw-command "deleterevisions"
               (mpw-quote file)
               "-file"
               (mpw-argument "-project" project)
               (and yes-to-dialogs "-y")))
               

(defun mpw-mountproject (path &key project-paths recursive short)
  (mpw-command "MountProject"
               (and project-paths "-pp")
               (and recursive "-r")
               (and short "-s")
               (when path
                 (mpw-quote (namestring path)))))

#|
	Change History (most recent last):
	2	9/12/91	alms	allow better background processing during mpw-command
	7	3/12/92	ows	bring over some functions from my own system
	8	3/24/92	jaj	fix bugs
	9	3/25/92	ows	Fixed a bug where mpw-command errored because it was trying to delete the "done" file before MPW had closed it.
				Moved the code to add the Leibniz-version menu item to projector-menus.
				Switch over to the new mpw-command format.
	10	4/3/92	ows	add restarts
				look for the "done" file in a separate command
	11	4/3/92	ows	move the mpw-xxx commands here
	12	4/7/92	ows	mpw-quote quotes empty strings too
	13	4/14/92	ows	allow continuing from the case that there wasn't enough memory to launch MPW
				add yes-to-dialogs as an option to mpw-checkin
	14	5/5/92	ows	add some restarts and some more error detection
	1	9/28/93	HW	Now it's in RSTAR SourceServer.
	2	5/3/94	akh	added mpw-delete
	2	12/22/94	akh	let-globally *processing-events*
|# ;(do not edit past this line!!)
