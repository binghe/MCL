;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  6 9/18/96  slh  remove spurious PRINTs
;;  3 10/23/95 bill Remote download support
;;  2 10/13/95 bill ccl3.0x25
;;  7 2/9/95   akh  delete some obsolete comments
;;  (do not edit before this line!!)
;;;This file is used to load a stand alone sourceserver interface into MCL

;;; Copyright 1995-2000 Digitool, Inc.

;; Modification History
;
; some stuff about .cfsl for carbon/osx
;; ---------
; 01/17/96 bill don't require lapmacros
;               don't load plot-icon, it's in the interfaces directory now.
; 10/21/95 bill add anarchie-interface & local-update
; 10/12/95 bill add compare-buffers
; 3/09/95 slh   call projector-target to launch app & push quitter function

(in-package :ccl)

; (mapcar #'compile-file *projector-files*) ; SWD
; (compile-file "sourceserver:sysequ")   
; (compile-file "sourceserver:ui-utilities")
; (compile-file "sourceserver:plot-icon")


;;;
;; a few miscellanies needed by projector files

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))
  (defconstant wsp&cr
    (coerce '(#\space #\^M #\^I #\^L #\^@ #\^J #\312) 'string))
  )

(defconstant $AppParmHandle #xAEC)	 ; handle to hold application parameters



(defparameter *projector-files*
  '(;"anarchie-interface"
    "ui-utilities"
    ;"plot-icon"
    "find-folder"
    "sublaunch"
    "projector-utilities"
    "mpw-command"
    "sourceserver-command"
    "compare" 
    "compare-buffers"
    "merge"    
    "read-only"
    "projector"
    "mpw-project"
    "local-update"
    "projector-menus"
    "projector-ui"
    ))

(eval-when (:load-toplevel :execute)
  (let* ((source *loading-file-source-file*))
    (if (not (physical-pathname-p source))
      (unless (string-equal (pathname-host source) "sourceserver") ; if we got here its ok
        (let ((host (pathname-host source))
              (dir (directory-namestring source)))
          (setf (logical-pathname-translations "sourceserver")
                `(("**;*.fasl" ,(make-pathname :host host
                                               :directory 
                                               (pathname-directory
                                                (merge-pathnames ";fasls;**;" dir))
                                               :name "*"
                                               :type "fasl"
                                               :defaults nil))
                  ("**;*.pfsl" ,(make-pathname :host host
                                               :directory 
                                               (pathname-directory
                                                (merge-pathnames ";fasls;**;" dir))
                                               :name "*"
                                               :type "pfsl"
                                               :defaults nil))
                  ("**;*.cfsl" ,(make-pathname :host host
                                               :directory 
                                               (pathname-directory
                                                (merge-pathnames ";fasls;**;" dir))
                                               :name "*"
                                               :type "cfsl"
                                               :defaults nil))
                  ("**;*.*" ,(make-pathname :host host
                                            :directory (pathname-directory
                                                        (merge-pathnames ";**;" dir))
                                            :name "*"
                                            :type "*"
                                            :defaults nil))))))
      ; this way the translations are as of load time - not run time - yuck for meta-.
      (let* ((bk-source (back-translate-pathname source))
             (bk-host (pathname-host bk-source)))
        (unless (and bk-host (string-equal bk-host "sourceserver") (probe-file bk-source))
          (setf (logical-pathname-translations "sourceserver")
                `(("**;*.fasl" ,(merge-pathnames ":fasls:**:*.fasl" source))
                  ("**;*.pfsl" ,(merge-pathnames ":fasls:**:*.pfsl" source))
                  ("**;*.cfsl" ,(merge-pathnames ":fasls:**:*.cfsl" source))
                  ("**;*.*" ,(merge-pathnames ":**:*.*" source)))))))
     (let* ((pkg  (find-package :mk))
            (sym (if pkg (intern "OPERATE-ON-SYSTEM" pkg))))
       (if (and pkg
                (fboundp sym) ; this is RSTAR specific
                (full-pathname "system-defs:sourceserver.system")
                (probe-file "system-defs:sourceserver.system"))
         (apply sym "SourceServer" :compile :verbose t)
         (let ((*load-verbose* t)
               (*compile-verbose* t))
           (require :lispequ)
           ;(require :lapmacros)
           (require :sysequ)   ; ?? - is someplace on 2.0.1 heirarchy - include in main distrib
           (mapc #'(lambda (file)
                     (compile-load (merge-pathnames file "sourceserver:")))
                 *projector-files*))))))

; *my-projects* is a list of 2 element lists. In each sublist
; first is the directory containing the project database, 
; second is directory containing the local files.
; If you do not have any projects, set *my-projects* to nil, and
; use New Project on the source server menu to create a new project.

(defparameter *all-projects* nil)
;;;
;;; Use a simple list to keep track of the projects to mount. This function will
;;; set the variable *my-projects* to the correct form the system needs. So we don't
;;; have to type in a lot when adding a new project. Hai Wang. 7/7/93
;;;
(defun translate-to-my-projects (projects)
  (let ((my-projects projects))
    (setf *my-projects*
          (mapcar 
           #'(lambda (project)
               (let* ((remote (merge-pathnames project "SSRemote:"))
                      (local  (merge-pathnames project "SSLocal:"))
                      (local-folder (filepath-to-dirpath (full-pathname local))))
                 (create-file local-folder :if-exists nil)
                 (list (namestring remote)(namestring local)) ; can they be pathnames?
                 ))
           my-projects))
    t))


(mapc #'(lambda (file)
          (load file))
      '("sourceserver:initialize-user" "sourceserver:initialize-projects"))

(setq *projector-path* "SourceServer:SourceServer")

(projector-target)

#|

;;;;;;;;;;;;;;;;;;;;
;;; stuff for creating projects and adding files to projects & ccl specific junk

(defun make-new-project (pdir)
  (mpw-command "NewProject" (directory-namestring pdir)
               "-u" (or *user* "akh")))

(defun make-projs-maybe ()
  ; big ffing hammer to create projects if dont exist - pretty slow
  ; make a smaller hammer - really just some probe-files of remote dohickey
  ; which maybe we dont want to do at load time - when do we? - when mount projects.
  ; see mount-all-projects in projector-ui
  (handler-bind ((error #'(lambda (c)
                            (declare (ignore c))
                            (throw :poo nil))))
    (dolist (x *all-projects*)
      (catch :poo
        (make-new-project (full-pathname (make-pathname :host "ssremote" :directory x)))))))
    

; or if projects dont exist - create them
(defun make-ccl-projs ()
  (dolist (x *all-projects*)
    (make-new-project (full-pathname (make-pathname :host "ssremote" :directory x)))))

(defun checkin-ccl-files ()
  (dolist (x *all-projects*)
    (let* ((ldir (full-pathname (make-pathname :host "sslocal" :directory x :defaults nil)))
           (files (nconc (directory (merge-pathnames "*.lisp" ldir))
                         (directory (merge-pathnames "*.a" ldir))
                         (directory (merge-pathnames "*.h" ldir))
                         (directory (merge-pathnames "*.c" ldir))
                         (directory (merge-pathnames "*.s" ldir))
                         (directory (merge-pathnames "*.r" ldir)))) ; ???
           (pdir (file-path-to-project-path x)))
      (dolist (file files)
        ;(project-file-add pdir file :comment "New CCL project hierarchy")
        ;))))


        (mpw-command "CheckIn" "-new" NIL '("-cs" "\"New project hierarchy\"")
                     `("-project"  ,pdir) (mac-namestring file))))))


(defun file-path-to-project-path (path)
  ; this is stupid but we only do it once a year. Assume logical path. No quoted ; 
  (let* ((spath (if (stringp path) (concatenate 'string path)(directory-namestring path)))
         (len (length spath))
         pos)
    (loop 
      (setq pos (ccl::%str-member #\; spath (if pos (1+ pos))))
      (if pos 
        (setf (schar spath pos) #\º)
        (return))
      (if (eq pos (1- len)) (return)))
    (if (not (eql (schar spath (1- len)) #\º))
      (concatenate 'string spath "º")
      spath)))

; maybe do this to each file  
(defun nuke-ckid (pathname)
  (let ((refnum (with-pstrs ((np (mac-namestring pathname))) (#_HOpenResFile 0 0  np #$fsrdwrperm))))
    (unwind-protect
      (or (file-locked-p pathname)
          (and refnum 
                (not (eql refnum -1))
                (with-macptrs ((rsrc (#_Get1Resource  "ckid" 128)))
                  (when (not (%null-ptr-p rsrc))
                    (#_rmveresource rsrc)))))
      (unless (eq refnum -1)
          (#_CloseResFile refnum)))))      
     

; ldir is local directory pdir is project name 
; e.g. "swib-clientsºswib-interfacesº"  thats ctl-q meta-b in case you forgot
(defun checkin-dir (ldir pdir &optional (name-ext "*.lisp"))
  (let ((foo (directory (merge-pathnames name-ext ldir))))
    (dolist (f foo)
      (mpw-command "CheckIn" "-new" NIL '("-cs" "\"New project hierarchy\"")
                   `("-project"  ,pdir) (mac-namestring f)))))

; file e.g. "foo.lisp" project e.g. "swib-clientsÄswib-interfacesÄ"
(defun remove-pfile (file project)
  (mpw-command "deleterevisions" file "-file" `("-project" ,project) "-y"))

;;;;;;;;;;;;;;;;
;; ccl projects 

(defparameter *all-projects*        
        '("build"
          "build;asms"
          "level-1"
          "lib"
          "library"
          "library;inspector folder"
          "library;interfaces" ; and index ?
          "Sourceserver"
          "compiler"
          "examples"
          "examples;binhex"
          "examples;ff examples"
          "examples;notinrom"
          "interface tools"))          
(translate-to-my-projects *all-projects*)
(reset-projects)
|#

#|
Use the defsystem if defsystem is loaded
|#

#|
trying to make pathnames be logical in project objects
 
|#



#|
	Change History (most recent last):
	1	9/28/93	HW	Now it's in RSTAR SourceServer.
	2	9/28/93	HW	In #'Translate-To-My-Projects, added code for creating folders for the projects if the local folders do not exist.
	2	3/30/94	akh	SSlocal root is (boot-directory) - nah is rstarSource
	3	4/4/94	akh	sslocal same as rstarSource
	4	4/7/94	akh	Logical pathnames in *my-projects*
	5	4/11/94	akh	USE operate-on-system iff the sourceserver.system exists
	2	12/20/94	akh	require scrolling-fred..
	3	12/22/94	akh	fancier logical-pathname-translations
	4	12/22/94	akh	no require scrolling-fred-dialog-item
	5	12/23/94	akh	*compile-verbose* t when loading
  6   1/6/95   akh   no change
|# ;(do not edit past this line!!)
