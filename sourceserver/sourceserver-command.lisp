
;;	Change History (most recent first):
;;  3 10/13/95 bill Don't error about checking out a modro file of the same verssion
;;  2 10/11/95 bill ae-get-parameter-integer can now return NIL if errorp is NIL
;;  6 3/16/95  slh  specify creator for finding SourceServer applic
;;  5 3/9/95   slh  projector-target pushes cleanup function
;;  4 1/17/95  akh  use without-event-processing
;;  3 1/11/95  akh  conditionalize let-globally
;;  (do not edit before this line!!)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#|
	sourceserver-command.lisp

	copyright © 1992, Apple Computer, Inc.

	Call sourceserver-command with a bunch of strings which are "tokens" that 
	SourceServer understands. It will retunr the reply, or error.

	Example:

	(sourceserver-command "NewProject" "-u" "derek" "-cs" "testing" "testProject")

	Impl. Notes:
	
	Note that the SourceServer documentation is wrong or misleading in many instances,
	and the interface itself is screwy (mostly for historical reasons). The part about
	the AppleEvent Error# being 2 bytes instead of 4 and strings needing nulls will
	probaly be fixed in future versions of SourceServer.
|#
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; 02/19/96 bill  quit-source-server no longer launches SourceServer just to quit it.
;;                projector-target takes a new, optional, launch-if-not-active parameter, default true. 
;;

(in-package :ccl)

(export '(sourceserver-command *projector-path* quit-source-server))

(eval-when (eval compile load)
  (require 'appleevent-toolkit))

(defconstant $projector-signature :|MPSP|)
(defconstant $projector-canonical-name "SourceServer")

(defconstant $projector-msg-class :|MPSP|)
(defconstant $projector-msg-id :|cmnd|)
(defconstant $projector-status :|stat|)
(defconstant $projector-diag :|diag|)

(defparameter *projector-target* nil)
;(defvar *user-initials* nil)  ; already defined in mpw-command
(defvar *projector-path* nil)

(def-load-pointers clear-projector-comm-vars ()
  (setq *projector-target* nil))

(defun find-appl (appl-name &optional creator)
  (message-dialog (concatenate 'string "Please locate " appl-name "."))
  (choose-file-dialog :button-string "Launch"
                      :mac-file-type :APPL
                      :mac-file-creator creator))

(defun find-and-launch-appl (appl-name &optional creator)
  (let ((path *projector-path*))
    (unless path 
      (setq path (find-appl appl-name creator)))
    (handler-case (sublaunch path nil t)
      (error () (progn
                   (setq path (find-appl appl-name creator))
                   (sublaunch path nil t))))))

(let ((*warn-if-redefine* nil))
  (defun chooser-name ()
    "returns macintosh name, else chooser name, else \"unspecified\""
    (let ((h (#_GetString -16096)))
      (unless (or (%null-ptr-p h) (%null-ptr-p (%get-ptr h)) (eql 0 (%get-byte (%get-ptr h))))
        (%get-string h))))
  
  (defun user-initials ()
    (or *user-initials*
        (setq *user-initials* (chooser-name))))
  )

(defun forget-projector-target ()
  (when *projector-target*
    (unless (%null-ptr-p (rref *projector-target* aedesc.datahandle))
      (require-trap #_aedisposedesc *projector-target*))
    (dispose-record *projector-target* :aeaddressdesc)
    (setq *projector-target* nil)))

(defun set-projector-psn-target (psnhigh psnlow)
  (forget-projector-target)
  (setf *projector-target* (make-record (:aeaddressdesc :clear t)))
  (create-psn-target *projector-target* psnhigh psnlow))

(defun projector-target (&optional (launch-if-not-active t))
  (or *projector-target*
      (progn
        (loop
          (multiple-value-bind (psnhigh psnlow) (find-process-with-signature $projector-signature)
            (cond (psnhigh
                   (set-projector-psn-target psnhigh psnlow)
                   (push #'(lambda ()
                             (ignore-errors
                              (quit-source-server)))
                         *lisp-cleanup-functions*)
                   (return))
                  (launch-if-not-active (find-and-launch-appl $projector-canonical-name
                                                              $projector-signature))
                  (t (return-from projector-target nil)))))
        (user-initials)
        *projector-target*)))

(defun parse-projector-reply (reply)
  "Returns output (text), status (number), errn (number), and diagnaostic (text)."
  (let ((output (ae-get-parameter-char reply #$keyDirectObject nil))
        (diag (ae-get-parameter-char reply $projector-diag nil)) 
        (errn (ae-get-parameter-some-integer reply #$keyErrorNumber nil))  ; SWD 4/21/93
        (status (ae-get-parameter-longinteger reply $projector-status nil)))
    (check-required-params "" reply)
    (values output status errn diag)))

(defun ae-replace-target (the-event the-target)
  (ae-error (#_AEPutAttributeDesc the-event #$keyAddressAttr the-target)))

(defun create-string-list (the-desc list-strings)
  (labels ((foo (more-strings)
             (dolist (str more-strings)
               (when str
                 (if (consp str)
                   (foo str)
                   (with-cstrs ((c-string str))
                     (#_AEPutPtr the-desc 0 #$typeChar c-string
                      (1+ (length str)))))))))                            
    (ae-error (#_AECreateList (%null-ptr) 0 nil the-desc))
    (dolist (a-str list-strings)
      (when a-str
        (if (consp a-str)
          (foo a-str)
          (with-cstrs ((c-string a-str))	; the nulls are gratuitous except that SourceServer from ETO#7 needs them.
            (#_AEPutPtr the-desc 0 #$typeChar c-string
             (1+ (length a-str))))))
      the-desc)))

; Hacked version of get-error-number that won't barf 
; because SourceServer sent a two-byte error code!

(defun ae-get-parameter-some-integer (the-desc keyword &optional (errorp t))
  (rlet ((buffer :signed-long)
         (typecode :desctype)
         (actualsize :size))
    (ae-errorp-handler
      errorp
      (ae-error (#_aegetparamptr the-desc keyword
                 #$typeLongInteger typecode buffer
                 (record-length :signed-long) actualsize))
      (ecase (%get-signed-long actualsize)
        (1 (%get-signed-byte buffer))
        (2 (%get-signed-word buffer))
        (4 (%get-signed-long buffer))))))

(let ((*warn-if-redefine* nil))
  (defun get-error-number (the-desc &optional (errorp t))
    (ae-get-parameter-some-integer the-desc #$keyErrorNumber errorp))
  )
;;; alice - kludge to ignore "no files in project" error
(defun sourceserver-command (&rest arg-strings)
  ;(format t "~&SourceServer command: ~a~%" arg-strings)
  (#+processes without-event-processing #-processes let #-processes ((*processing-events* t))		; why?
    (with-cursor *watch-cursor*
      (with-aedescs (ae reply ae-args)
        (create-appleevent ae $projector-msg-class $projector-msg-id (projector-target))
        
        (create-string-list ae-args arg-strings)
        (#_AEPutParamDesc ae #$keyDirectObject ae-args)
        (setq *idle* t)
        (handler-case
          (send-appleevent ae reply :reply-mode :wait-reply :timeout #$kNoTimeOut)
          (appleevent-error (the-error)
                            (case (oserr the-error) 
                              ((-600 -906) 			; -600 = procNotFound
                               (progn
                                 (forget-projector-target)
                                 (ae-replace-target ae (projector-target))
                                 (send-appleevent ae reply :reply-mode :wait-reply :timeout #$kNoTimeOut)))
                              (t (error "An Error ~D, ~A. " (oserr the-error) (error-string the-error))))))
        (setq *idle* nil)
        (multiple-value-bind (output status errno diagnostic) 
                             (parse-projector-reply reply)
          (setq diagnostic (remove-bogus-diagnostic-lines diagnostic))
          (unless (and (zerop status) (null diagnostic) (zerop errno))
            (if diagnostic
              (cerror "Ignore error" "~A (Status = ~D, Error = ~D)."
                      (string-right-trim '(#\newline) diagnostic) status errno)
              (cerror "Ignore error" "No diagnostic message (Status = ~D, Error = ~D)" status errno)))
          output)))))

(defvar *bogus-sourceserver-diagnostics*
  '("### CheckOut - There are no files in project"
    "is a modified read-only file--of the specified Revision!"))

(defun remove-bogus-diagnostic-lines (diagnostic)
  (when diagnostic
    (with-output-to-string (output-stream)
      (with-input-from-string (input-stream diagnostic)
        (let ((first-time? t)
              (did-something nil))
          (loop
            (let ((line (read-line input-stream nil nil)))
              (unless line (return))
              (unless (dolist (bogus-string *bogus-sourceserver-diagnostics*)
                        (when (search bogus-string line :test 'char-equal)
                          (return t)))
                (unless first-time?
                  (terpri output-stream)
                  (setq first-time? nil))
                (setq did-something t)
                (write-string line output-stream))))
          (unless did-something
            (return-from remove-bogus-diagnostic-lines nil)))))))

(defun quit-source-server ()
  (let ((target (projector-target nil)))
    (when target
      (with-aedescs (event reply)
        (create-quit event target)
        (send-appleevent event reply :reply-mode :no-reply)))))

(defvar *server-menu* (make-instance 'menu :menu-title "Projects"))
(defvar *my-projects* nil)
(defvar *source-directory* nil)
(defvar *user* nil)

#|
; here is a much simpler interface (than projector interface) which has a different notion
; of the contents of *my-projects*
(defun server-setup ()
  (let ((menu *server-menu*))
    (add-new-item menu "Mount Project…"
                  'server-mount)
    (add-new-item menu "CheckoutDir…"
                  'server-checkoutdir)
    (add-new-item menu "Checkout Modify…"
                  'server-checkout-m)
    (add-new-item menu  "Checkout RO…"
                  'server-checkout-ro)
    (add-new-item menu "CheckIn…"
                  'server-checkin)
    (menu-install menu)))


(defun server-mount ()
  (catch-cancel
    (let ((dir  (choose-directory-dialog)))
         (when (and dir (typep dir '(or pathname string)))
           (setq dir (mac-namestring dir))
           (push dir *projects*)
           (sourceserver-command "mountproject" dir)))))

(defun server-checkoutdir ()
  (catch-cancel
    (let ((dir  (choose-directory-dialog)))
      (when (and dir (typep dir '(or string pathname)))
        (setq *source-directory* (mac-namestring dir))
        (sourceserver-command "checkoutdir" *source-directory*)))))

(defun server-checkout-m ()
  (server-checkout "-m"))
(defun server-checkout-ro ()
  (server-checkout ""))

(defun server-checkout (option)
  (catch-cancel
    (let ((file  (choose-file-dialog :directory (car *my-projects*))))
      (when (and file (typep file '(or string pathname)))
        (setq file (mac-file-namestring file))
        (sourceserver-command "checkout" "-u" *user* "-project" (car *my-projects*) option file)))))

(defun server-checkin ()
  (catch-cancel 
    (let ((file (choose-file-dialog :directory (car *projects*))))
      (when (and file (typep file '(or string pathname)))
        (setq file (mac-file-namestring file))
        (sourceserver-command "checkin" "-u" *user* "-project" (car *my-projects*)  file)))))
|#

(let ((*warn-if-redefine* nil))
  (defun mpw-command (&rest args)
    (apply #'sourceserver-command args))

  (defun mpw-quote (name)
    "Quote a string for sourceserver"
    (let ((needs-character-quoting
           (find-if #'(lambda (char) (find char *mpw-quotable-characters*))
                    name)))
      (flet ((quote-quotables (string)
               (with-output-to-string (output)
                 (dotimes (i (length string))
                   (let ((char (schar string i)))
                     (if (find char *mpw-quotable-characters*)
                       (write-char #\∂ output))
                     (write-char char output))))))
        (cond (needs-character-quoting
               (quote-quotables name))
              (t name)))))
  )


;(unless (find-menu "Projects") (server-setup))

#|

(sourceserver-command "directory")
; sets the directory to receive the checked out files
(sourceserver-command "checkoutdir")
(sourceserver-command "MountProject")

(sourceserver-command "Project")
(sourceserver-command "ProjectInfo")


(sourceserver-command "NewProject" "-u" "derek" "-cs" "testing" "testProject")




(sourceserver-command "mountproject" "27B/6:Derek:Dyanmo:")
|#

(defun simple-mpw-project-mount (project-path dst-path)
  (sourceserver-command "MountProject" (mac-namestring project-path))
  (sourceserver-command "CheckoutDir" "-r" (mac-namestring dst-path)))

#|
	Change History (most recent last):
	1	9/28/93	HW	Now it's in RSTAR SourceServer.
	2	2/28/94	akh	Kludge to ignore error "no files in project" during checkout.
	2	12/22/94	akh	let-globally *processing-events*
|# ;(do not edit past this line!!)
