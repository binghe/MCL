;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  4 4/1/97   akh  see below
;;  3 3/18/97  akh  no more *ccl-version* for 68K
;;  19 9/3/96  akh  startup-aevents not ppc specific?
;;  18 9/3/96  akh  break out replace-base-translation, conditionalizations
;;  15 7/26/96 akh  maybe no change
;;  14 7/18/96 akh  event-processing-loop - handler just catches errors vs all conditions
;;  11 3/27/96 akh  finder-parameters
;;  9 3/9/96   akh  cursors for poof-button and bar-draggers
;;  6 12/22/95 gb   load "ccl:l1f;nx.pfsl" on ppc
;;  2 10/13/95 bill ccl3.0x25
;;  11 6/6/95  akh  dont setq *loading-file-source-file* to level-1
;;  4 4/4/95   akh  add some catches to after-error-event-processing-loop, use a dialog if no room for another listener
;;  12 3/20/95 akh  *initialization-output* tweeks
;;  11 3/14/95 akh  added weird stuff for printing from init file
;;  9 3/2/95   akh  maybe-create-standin-event-processor not longer sets *eventhook* to nil ???
;;  8 1/25/95  akh  again
;;  7 1/25/95  akh  pane splitter cursors are not in a separate file any more
;;  6 1/13/95  akh  none really
;;  5 1/11/95  akh  move modeline
;;  4 1/11/95  akh  forget *top-listener* when "no longer active
;;  (do not edit before this line!!)

;; L1-boot.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2000 Digitool, Inc.

;; Modification History
;

; no change
; cursors done in l1-edfrec
; ----- 5.2b6
; get-app-pathname - more modern
;; ---- 5.2b5
; change lisp-implementation-version
; ---- 5.2b3
; just hardwire lisp-implementation-version rather than looking in resource-fork
; --- 5.1 final
; akh boot-directory moved to l1-files
; -------- 5.0 final
; 04/16/97 bill  tail of file moved to "l1-boot-2.lisp" & "l1-boot-3.lisp"
; -------------- 4.1b2
; 03/29/97 akh   event-processing-loop wait function returns original priority if *new-processes*
;                priority of standin event processor is 10 if *new-processes*
; 03/17/97 akh   lose *ccl-version* forever I hope. It's nothing but trouble.
; 02/26/97 bill  finder-parameters passes #$everyEvent to %event-dispatch instead of
;                binding *event-mask*. This prevents the Lisp from prematurely quitting
;                when started by the Finder's print command.
; -------------  4.0
; 08/20/96 bill  *finder-parameters-timeout-ticks* controls how long finder-parameters
;                will wait for *startup-aevents* to become nil.
;                finder-parameters now loops until either *startup-aevents* becomes
;                nil or *finder-parameters-timeout-ticks* have passed. It will also
;                return the same result every time it's called. Before it would return
;                NIL on all but the first time.
;                Both are initialized by (def-ccl-pointers finder-parameters ...)
; -------------  4.0b1
; 07/31/96 bill  event-processing-loop catches serious-condition instead of error.
; 05/22/96 bill  event-processing-loop now initializes its binding of
;                *top-listener* to the global value (possibly set by
;                user startup functions). It also remembers the value
;                across throws to toplevel. No more duplicate *initial-process*
;                listeners!
; 05/04/96 bill  slh's fix to finder-parameters (as suggested by alice)
;  5/03/96 slh   boot-directory: use _LMGetBootDrive
;                finder-parameters: check events twice, as per Alice's advice
; 03/25/96 bill "home:boot-init.fasl" => "home:boot-init.pfsl" for ppc target
; -------------  MCL-PPC 3.9
; 03/26/96 gb    lowmem accessors.
; 01/29/96 bill  indentation
; 01/13/96 gb    just look at resource (better be there) in ppc-target
;                LISP-IMPLEMENTATION-VERSION.
; 11/13/95 gb    hide .pfsl/.fasl; avoid A5 reffing functions.
; 11/08/95 bill  PBGetFCBInfo -> PBGetFCBInfoSync
; 10/20/95 slh   de-lapified: startup-directory
; 10/12/95 bill  lisp-implementation-version mixes in *ccl-version*
; 10/11/95 bill  new variable, *single-process-p*.
;                if *single-process-p* is true, maybe-create-standin-event-processor
;                won't create a standin process and the startup-code won't create
;                a new Listener process. Also, the startup code will end up with
;                the initial-process running toplevel-loop instead of event-processing-loop.
;  5/05/95 slh   after-error-event-processing-loop: bind *break-on-signals* nil
;                (Kalman/Bill)
;  4/28/95 slh   Bill's polling fn change
;  4/27/95 slh   event-processing-loop: don't print "no longer active" message,
;                break-loop does that now
;  4/20/95 slh   check for ccl:L1f;nx.fasl" then "ccl:compiler.fasl"
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
;  3/07/95 slh   use *main-listener-process-name*
; -------------- 3.0d17
; maybe-create-standin-event-processor sets *modal-dialog-on-top* and *eventhook* to nil
; 10/04/93 bill  startup-ccl now calls open-application-document & print-application-document
;                instead of doing everything itself. It also calls startup-finished, which
;                sets *event-mask* to #$everyEvent so that AppleEvents will be reenabled
;                after startup-ccl has processed the initial ones.
; -------------- 3.0d13
; 05/01/93 alice event-processing-loop muffles warnings - do we like this?
;--------- 2.1d6
; 04/29/93 bill all-processes & friends -> *all-processes* & friends
; 04/26/93 bill no more ed-beep in after-error-event-processing-loop
;               set *event-processor* before killing standin in event-processing-loop
;               catch *event-processing-loop-tag* in event-processing-loop
; 04/22/93 bill abort-message arg to with-standard-abort-handling
; 04/21/93 bill no args to %event-dispatch: new *idle* handling.
;-------------- 2.1d4
; ??	   alice add loading cursors - move to the .r file someday
; 03/24/93 bill maybe-create-standin-event-processor
; 01/17/93 bill event-processing-loop, make-mcl-listener-process
; 12/17/92 bill the *event-processor* calls %event-dispatch instead of event-dispatch
; 12/09/92 bill lisp-implementation-version: don't need princ-to-string. " Version " -> "Version "
; 07/31/92 bill remove *machine-instance*. It's no longer used.
;-------------- 2.0
;03/05/92 bill  Handle abort during loading of init file in startup-ccl properly
;               (don't load it yet again)
;-------------- 2.0f3
;12/04/91 alice replace-base-translation deal with multiple occurrences of physical base
;12/10/91 gb    no %signal-error.
;12/12/91 bill  #_LoadResource after #_Get1Resource
;-------------  2.0b4
;11/14/91 (bill) Don't (setq *readtable* (copy-readtable %initial-readtable%))
;11/13/91 bill  (setq *readtable* (copy-readtable %initial-readtable%))
;11/06/91 bill  save-image calls restore-lisp-pointers which does most of the startup stuff.
;10/23/91 alice startup-ccl only loads fasl files, startup-ccl2 ed's text files
;-------------- 2.0b3
;06/28/91 bill Do *lisp-startup-functions* in order pushed (reverse order of the list)
;06/26/91 alice copy-list in replace-base-translation
;------------ 2.0b2
;05/29/91 gb   read 'vers' from curaprefnum.
;05/23/91 bill open-doc-string-file in startup-ccl2
;04/04/91 bill init-logical-directories only changes the mappings for
;              "home:**;*.*" & "ccl:**;*.*".  The other logical directories
;              are added once only.
;04/02/91 alice add boot-directory
;03/28/91 bill $appparmhandle may be null in home-directory
;              also, home-directory has no side-effects, hence it doesn't
;              belong on *lisp-system-pointer-functions*
;02/07/91 alice init-logical-directories for logical host
;01/21/91 gb   forget *startup-init-file* stuff, here and elsewhere. Get finder-parameters
;              from a5 global (where left by kernel.)
;------------2.0b1
;12/31/90 gb   only load :TEXT or :FASL files.
;12/13/90 bill bind *startup-init-file* in startup-ccl for appleEvents code
;12/8/90  joe added support for AEvents. Split up startup-ccl into a few components
;08/23/90 gb  lisp-implementation-version reads the brief-format string out of the 'vers' 
;              resource.
;06/25/90 bill remove initialization of *scrap-count* from startup-ccl.
;05/05/90 bill Update for new scrap-handler.
;04/30/90 gb   make CL-USER package.  *gensym-counter*.
;04/04/90 gz  pathname-directory -> directory-namestring,
;             *logical-pathname-alist* -> *logical-directory-alist*.
;12/30/89 bill Hair up startup-ccl.  Add restarts and make sure boot-init only
;              gets loaded once.
;12/27/89 bill Add *lisp-startup-functions* to startup-ccl
;12/27/89 gz Remove obsolete #+/-bccl conditionalizations.  Load init before
;            entering toplevel-loop & try for "boot-init" first.
;12/22/89 gz set ccl; from startup directory.
;11/23/89 gz moved *logical-pathname-alist* to l1-files.
;9/3/89  gb back to using 'vers' resource for lisp-implementation-version.
;           Tired of Lucid; should really use randomizer here.
;5/4/89  gz No more ccl;code:/fasls:
;4/18/89 as   changed name Allegro to something else
;4/14/89 gz set toplevel even if errors loading compiler/sysutils.
;4/04/89 Final level-1 startup stuff here now.


(defparameter *gensym-counter* 0)

(defparameter *inhibit-greeting* nil)

;(defparameter *using-new-fasload* t) ;; testing 1 2 3

;the below 3 variables are expected to be redefined in the user's init file
(defparameter *short-site-name* nil)
(defparameter *long-site-name* nil)
#|
(defparameter *machine-instance* nil)
|#

(defun lisp-implementation-type () "Macintosh Common Lisp")

#+ignore
(defun lisp-implementation-version ()
  (let ((res-version (let* ((resh (%null-ptr))
                            (curfile (#_CurResFile)))
                       (unwind-protect
                         (progn
                           (#_UseResFile (#_LMGetCurApRefNum))
                           (%setf-macptr resh (#_Get1Resource :|vers| 1)))
                         (#_UseResFile curfile))
                       (unless (or (%null-ptr-p resh)
                                   (progn
                                     (#_LoadResource resh)
                                     (eql 0 (%ptr-to-int (%get-ptr resh)))))
                         (with-dereferenced-handles ((r resh))
                           (%str-from-ptr (%incf-ptr r 7) (%get-byte r -1)))))))
    (%str-cat "Version "
              #+ppc-target (or res-version "UNKNOWN?")
              #-ppc-target res-version
              )))

(defun lisp-implementation-version ()
  "Version 5.2.1")



#| to heck with this
a) it means you have to remember to set *ccl-version* prior to saving the application
to match whatever you may put in resversion prior to shipping the application
b) the colon in the version confuses the test suites
other than that ...
              (if (equalp res-version *ccl-version*)
                res-version
                (%str-cat *ccl-version* ", kernel: " res-version)))))
|#

; Handle is now el-bizarro appparamhandle/fsspec hybrid thing.
#-ppc-target
(defun finder-parameters ()
  (with-dereferenced-handle (params (%get-ptr (%currentA5) $finder_paramH))
    (let ((msg (%get-word params))
          (count (%get-word params 2))
          (offset 4)
          (file)
          (files))
      (push (if (eq msg 0) :open :print) files)
      (%stack-block ((pb $ioFQElSize))
        (dotimes (i count (nreverse files))
          (declare (fixnum i))
          (%put-word pb (%get-word params offset) $ioVRefNum)
          (%put-long pb (%get-long params (+ offset 2)) $ioDirID)
          (%put-ptr pb (%inc-ptr params (%i+ offset 6)) $ioFileName)
          (setq file (%path-from-iopb pb))
          (push file files)
          (setf (logical-pathname-translations "home")
                `(("**;*.*.*" ,(merge-pathnames ":**:*.*.*" file))))
          (setq offset (%i+ offset (+ 2 4 64))))))))

(defvar *finder-parameters* nil)
(defvar *startup-aevents* nil)

; Whatever this turns out to be, it won't involve the A5 register ...
#+ppc-target
(progn
;(defvar *finder-parameters* nil)
;(defvar *startup-aevents* nil)
(defparameter *finder-parameters-timeout-ticks* 60)

(def-ccl-pointers finder-parameters ()
  (setq *finder-parameters* nil
        *startup-aevents* t))

(defun finder-parameters ()
  (when *startup-aevents*
    (let ((start-time (get-tick-count)))
      ; dropping doc on app: info is in first apple-event
      ; double-clicking doc: info is in second apple-event (sometimes)
      (loop
        (%event-dispatch nil 0 #$everyEvent)
        (when (null *startup-aevents*) (return))
        (when (%i>= (%tick-difference (get-tick-count) start-time)
                    *finder-parameters-timeout-ticks*)
          (setq *startup-aevents* nil)
          (return)))
      (when (eq (car *finder-parameters*) :open)
        (dolist (file (cdr *finder-parameters*))
          (setf (logical-pathname-translations "home")
                `(("**;*.*.*" ,(merge-pathnames ":**:*.*.*" file))))))))
  *finder-parameters*)
)


(defconstant $FCBSPtr #x34E)
(defconstant $fcbDirID 58)
(defconstant $fcbVPtr 20)
(defconstant $vcbVRefNum 78)

#+ignore ; moved to l1-files
(defun boot-directory ()
  (drive-name #-ppc-target (%get-signed-word (%int-to-ptr #$BootDrive))
              #+ppc-target (#_LMGetBootDrive)))

; returns nil for failure
#+ignore ; moved to l1-files
(defun get-app-fsspec (fsspec)
  (cond ((gestalt #$gestaltOSAttr)      ; Process Manager available?
         (rlet ((psn  :ProcessSerialNumber
                      :highLongOfPSN 0
                      :lowLongOfPSN  #$kCurrentProcess)
                (info :ProcessInfoRec
                      :processInfoLength (record-length :ProcessInfoRec)
                      :processName (%null-ptr)
                      :processAppSpec fsspec))
           (eql 0 (#_GetProcessInformation psn info))))
        (t #+ignore
           (rlet ((fcbPB :FCBPBRec) ;; i dunno so to heck with it
                  (handle :ptr))
             (let ((name-ptr (%inc-ptr fsspec #.(get-field-offset :FSSpec.name))))
               (#_GetAppParms
                name-ptr
                (%inc-ptr fcbPB  #.(get-field-offset :FCBPBRec.ioRefNum))
                handle)
               (setf (pref fcbPB :FCBPBRec.ioNamePtr) name-ptr
                     (pref fcbPB :FCBPBRec.ioVRefNum) 0
                     (pref fcbPB :FCBPBRec.ioFCBIndx) 0)
               (when (eql 0 (#_PBGetFCBInfoSync fcbPB))
                 (setf (pref fsspec :FSSpec.vRefNum) (pref fcbPB :FCBPBRec.ioFCBVRefNum)
                       (pref fsspec :FSSpec.parID)   (pref fcbPB :FCBPBRec.ioFCBparID))))))))

#|
(defun get-app-pathname ()
  (rlet ((fsspec :FSSpec))
    (if (get-app-fsspec fsspec)
      (%path-from-params (pref fsspec :FSSpec.vRefNum)
                         (pref fsspec :FSSpec.parID)
                         (%inc-ptr fsspec #.(get-field-offset :FSSpec.name))))))
|#



;; more P.C. - I think we only care about the directory
#|
(defun get-app-pathname ()
  (merge-pathnames (get-app-name) (get-app-directory))) 
|#

;; unused - see mac-default-directory
#|
(defun get-app-directory ()
  (rlet ((fsspec :fsspec)
         (fsref :fsref))
    (when (get-app-fsspec fsspec)
      (setf (pref fsspec :fsspec.name) "")) 
    (#_FSPMakeFSRef fsspec fsref)
    (%path-from-fsref fsref t)))
|#

;; just gets the name part - unused
;; may not be filename
(defun get-app-name ()
  (rlet ((psn  :ProcessSerialNumber
               :highLongOfPSN 0
               :lowLongOfPSN  #$kCurrentProcess)
         (cfstr :pointer))
    (unwind-protect
      (progn 
        (#_CopyProcessName psn cfstr) ;; requires CarbonLib 1.5 or later   
        (get-cfstr (%get-ptr cfstr)))
      (#_CFRelease (%get-ptr cfstr)))))

;; not used either but is the name&type part of filename
(defun get-app-name-from-path ()
  (let* ((path (get-app-pathname))
         (name (%pathname-name path))
         (type (%pathname-type path)))
    (if (stringp type)
      (%str-cat name type)
      name)))



#| ;; moved to l1-files
(defun get-app-pathname ()
  (rlet ((psn  :ProcessSerialNumber
               :highLongOfPSN 0
               :lowLongOfPSN  #$kCurrentProcess)
         (fsref :fsref))
    (#_getprocessbundleLocation psn fsref)
    (%path-from-fsref fsref)))
|#

    
    

; returns nil for failure - similar to mac-default-directory
(defun startup-directory (&optional (path (get-app-pathname)))
  (if path
    (make-pathname :directory (pathname-directory path))
    (old-startup-directory)))



#-ppc-target
(defun home-directory ()
  (with-dereferenced-handles ((params (%get-ptr (%currentA5) $finder_paramH)))
    (if (eq 0 (%get-word params 2)) ;count of params
      nil
      (%stack-block ((pb $ioPBSize))
        (%put-word pb (%get-word params 4) $ioVRefNum)
        (%put-long pb (%get-long params 6) $ioDirID)
        (%dir-path-from-iopb pb)))))

#+ppc-target
(defun home-directory () ())

(defun replace-base-translation (host-dir new-base-dir)
  (let* ((host (pathname-host host-dir))
         (host-dir (full-pathname host-dir))
         (trans (logical-pathname-translations host))
         (host-wild (merge-pathnames ":**:*.*" host-dir)))
    (setq host-dir (pathname-directory host-dir))
    (setq new-base-dir (pathname-directory new-base-dir))
    (setf 
     (logical-pathname-translations host)
     (mapcar
      #'(lambda (pair)
          (let ((rhs (cadr pair)))
            (if (and (physical-pathname-p rhs)
                     (pathname-match-p rhs host-wild))
              (list (car pair)
                    (merge-pathnames 
                     (make-pathname 
                      :defaults nil 
                      :directory (append new-base-dir
                                         (nthcdr (length host-dir) 
                                                 (pathname-directory rhs))))
                     rhs))
              pair)))
      trans))))

; only do these if exist
(defun init-logical-directories ()  
  (let ((startup (startup-directory)))
    (replace-base-translation "home:" (or (home-directory) startup))
    (replace-base-translation "ccl:" startup)
    ))

(push #'init-logical-directories *lisp-system-pointer-functions*)

#|
(def-ccl-pointers cursors ()  
    (let ()
      (unwind-protect 
        ; it isnt really necessary to load these is it?
        (flet ((get-and-detach (type num)
                 (let ((r (#_getresource type num)))
                   (#_loadresource r)
                   (#_detachresource r)
                   r)))
          (setq *vertical-ps-cursor* (get-and-detach :curs 128))  ; has 2 arrows - is used
          (setq *horizontal-ps-cursor* (get-and-detach :curs 129))          
          (setq *top-ps-cursor* (get-and-detach :curs 130))
          (setq *bottom-ps-cursor* (get-and-detach :curs 131))
          (setq *left-ps-cursor* (get-and-detach :curs 132))
          (setq *right-ps-cursor* (get-and-detach :curs 133))))))
|#


(catch :toplevel
  (setq *loading-file-source-file* nil)  ;Reset from last %fasload...
  (init-logical-directories)
  )

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
	3	1/2/95	akh	no change
|# ;(do not edit past this line!!)
