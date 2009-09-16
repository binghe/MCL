;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  3 6/9/97   akh  ldef-proc re tables gone
;;  17 5/20/96 akh  no more *window-object-hash*
;;  16 4/24/96 akh  remove some #-ppc-target stuff that made dialog not work
;;  10 2/23/96 akh  bill's fix to restore-pascal-functions
;;  2 10/17/95 akh  merge patches
;;  18 7/27/95 akh  merge patches
;;  16 7/7/95  akh  in kill-lisp-pointers - check fboundp kill-frec-list
;;  11 5/22/95 akh  error if size too small
;;  9 5/9/95   akh  save-application size defaults to current.
;;  8 5/1/95   akh  made default min size be 3584 (for CCL so building MCL should provide it.)
;;  2 4/4/95   akh  nullify *event-error-dialog*
;;  7 3/20/95  akh  put back old def of toplevel-function
;;  5 3/2/95   akh  use application-file-creator
;;  4 2/17/95  akh  clear *window-object-hash*
;;  (do not edit before this line!!)

; Dumplisp.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2001 Digitool, Inc.

;; Modification History
;
; new variable *use-app-resources*, used by open-dumplisp-file
; ------ 5.2b6
; restore-lisp-pointers calls initialize-bundles
; some changes for new interfaces
; set *uchar-encoding-table* nil
; ------- 5.1 final
; set *recent-files* to NIL
;; -------- 5.1b3
; new versions of open-dumplisp-file and save-library use fsrefs - what a thrill - but only for dir, not name
; --------- 5.0 final
; akh lose-cmd-q loses the separator too
; ------- 5.0b5
; akh add lose-cmd-q to *save-exit-functions*
; -------- 5.0b3
; akh bugger cfrg resource so hopefully unique - jaquar misguided optimization??
;;;; 4.4b4
; akh add crock for possible contextual-menu-cursor
; akh carbon-compat restore-pascal-functions
; akh carbon-compat for openresfile etal
; no mo lmgettime
; set displaymanageaware bit in size resource - I sure hope it's right
;; ----------- 4.3b2
; 06/24/98 akh  %save-application-internal - call volume-number with directory-namestring vs mac-directory-namestring
;11/18/97 akh   excise-compiler for 68K actually does something
;06/06/97 akh   no mo ldef-proc-handle
;02/27/97 bill  Fix %save-application-internal so that passing an explicit
;               :init-file of NIL to save-application will result in no
;               init file.
;-------------  4.0
;10/04/96 bill  kill-lisp-pointers clears *window-object-alist* via
;               repeated calls to remove-window-object. This both ensures
;               that the cache is clear and that remove-lisp-wdef gets
;               called on each one.
;10/02/96 bill  save-image sets *interrupt-level* negative after, not before,
;               throwing to toplevel to eliminate the possiblity of restoring
;               a saved binding. This makes it work to call save-application
;               from within an event processing function (e.g. a menu or dialog-item
;               action function).
;08/05/96 bill  Add :errchk to #_NewHandle call in get-app-resources &
;               #_NewHandleClear call in create-lib-cfrg-handle.
;07/16/86 gb    save-library: append timestamp to fragment name.
;05/21/96 bill  eliminate the undeclared free variable warning for
;               the reference to *window-object-hash* in kill-lisp-pointers.
;05/04/96 bill  slh's fixes to load-and-detach-no-error and get-app-resources
;-------------  MCL-PPC 3.9
; 5/03/96 slh   %save-application-internal: use application-init-file
;04/10/96 gb    revive :EXCISE-COMPILER.
;03/26/96 gb    lowmem accessors.
;03/17/96 gb    save-library writes version info to cfrg after data fork written.
;03/14/96 bill  unconditionalize calls to new-version-resource and process-lsiz-options
;03/01/96 gb    save-library
;01/11/96 gb    ppc-target changes (some of them wrong.)
;12/27/95 gb    trap-pointer stuff is #-ppc-target.
;12/20/95 bill  restore some of the file for the PPC
;11/29/95 bill  New trap names. (#_PBxxx :errchk ...) -> (errchk (#_PBxxx ...))
;11/14/95 bill  restore-pascal-functions comes out-of-line from restore-lisp-pointers.
;               Separate versions for ppc & 68k.
;11/01/95 bill  initialize-shared-libraries in restore-lisp-pointers.
;               clear-shared-library-caches in kill-lisp-pointers
;10/20/95 slh   disabled for PPC
; 7/12/95 slh   Need patches here as well as patch file:
;               - restore-lisp-pointers calls initialize-ff-traps-pointer directly
;               - pass creator to create-file
;               - use _Get1IndResource; don't confuse index with id
; 6/09/95 slh   don't nuke *ff-traps* table
; 6/01/95 slh   kill-lisp-pointers: call save-trap-pointer-to-array
; 5/31/95 slh   consistently use 3.5M/4M for min/pref sizes
; 5/12/95 slh   new traps mods.
; 4/30/95 akh   increase image minimum size, remove all size resources > -1
; 4/28/95 slh   clear *module-file-alist*
; 4/27/95 slh   toplevel-function methods moved to public file
; 4/16/95 slh   require :resources at load time too; get-app-resources: check for "" -
;                (probe-file "") is returning a directory!
; 4/11/95 slh   get-app-resources here (needed during application load-for-dump)
; 3/10/95 slh   Bill's new toplevel-function has init file output go to first listener
;-------------- 3.0d17
;10/04/93 bill  save-image disables high level events in *event-mask*.
;               Will be reenabled by startup-ccl
;-------------- 3.0d13
;07/19/93 bill  kill-frec-list replaces more intimiate knowledge of %frec-list%
;-------------- 3.0d12
;07/11/93 alice *script-char...tables* => nil
;05/01/93 alice hide-listener arg to save-application is history
;05/04/93 bill  pass vrefnum to $sp-saveappl
;               toplevel-function (application) does print-application-document
;04/29/93 bill  all-processes & friends -> *all-processes* & friends
;04/24/93 bill  terminate-standin-event-processor in save-application
;04/21/93 bill  no args to event-dispatch - new *idle* handling.
;               (setq *non-idle-processes* nil) in kill-lisp-pointers
;-------------- 2.1d5
;04/29/93 alice toplevel-function (application) does open-application-document on finder-parameters.
;-------------- 2.1d4
;03/??/93 alice more options to save-application - hide-listener isn't right yet
;11/04/92 alice excise-compiler - don't die if called twice
;01/21/93 bill toplevel-function method called by default toplevel-function arg to save-application.
;12/09/92 bill In kill-lisp-pointers: remove redundant (setq *last-choose-file-directory* nil)
;------------- 2.0
;01/07/92 gb   don't require RECORDS.
;12/12/91 bill #_LoadResource after #_Get1Resource
;------------- 2.0b4
;11/24/91 bill open-dumplisp-file sets the bundle bit if there is a ('BNDL 128) resource.
;              If one of the resources passed to save-application is not a list, it
;              is funcalled by open-dumplisp-file with a single arg: the name of the new file.
;              This gives users a hook to copy another resource file into the application
;              (or do whatever they want).
;11/15/91 gb   :memory-options for setting LSIZ resource.  *patched-resources*.
;11/06/91 bill  run *save-exit-functions* before kill-lisp-pointers.
;               Run *lisp-startup-functions* before running the user toplevel function.
;               All the startup function lists get run by restore-lisp-pointers.
;10/29/91 alice nuke *restore-lisp-functions*, catch errors in *lisp-user-pointer-functions*
;10/21/91 gb   no more #_PB.
;10/10/91 gb   Deprecate :compress option a little more completely.
;------------ 2.0b3
;08/24/91 gb   KILL-OLD-TRAP-SYNTAX.
;08/14/91 gb   KILL-LISP-POINTERS: setq *help-manager-present* nil.
;07/21/91 gb   Give up on DUMPLISP.  DIsable *COMPILE-DEFINITIONS* when excising compiler.
;06/20/91 bill KILL-LISP-POINTERS: no more *grow-bm*.  Clear *event-dispatch-task*
;------------- 2.0b2
;05/20/91 gb   set *%periodic-tasks%* to nil in kill-lisp-pointers.
;04/15/91 bill /,  //, ///, %saved-ioVRefnum%, %saved-directory-path%, *open-file-streams*
;              are now initialized in kill-lisp-pointers
;03/28/91 alice save-application may change version resource
;03/05/91 bill set *selected-window* NIL in kill-lisp-pointers.
;------------ 2.0b1
;01/29/91 bill clear-killed-strings moves from save-application to kill-lisp-pointers.
;              Clear the scrap stuff in kill-lisp-pointers.
;01/02/91 gb   don't restore woi state of %pascal-functions in restore-, kill-lisp-pointers.
;              :excise-compiler, :size, :resources options to save-application.
;12/31/90 bill kill-lisp-pointers saves the without-interrupts status of defpascal
;              functions and restore-lisp-functions restores it.
;              save-application's default toplevel-function always calls startup-ccl
;12/28/90 gb   :size, :resources args to SAVE-APPLICATION & OPEN-DUMPLISP-FILE.
;12/10/90 bill *fast-help* initialization
;12/07/90 bill kill-lisp-pointers: init *fast-help*
;10/16/90 bill Remove (setq *inspect-history-items* nil) from kill-lisp-pointers.
;08/28/90 bill *%saved-method-var%* no longer exists as a variable:  it's a setfable function.
;07/23/90 gb   try letting :compress default to T, new magic compress flags, watch cursor around open-dumplisp-file.
;06/27/90 bill clear *%saved-method-var%* in kill-lisp-pointers
;06/18/90 bill in save-application: new clear-clos-caches parameter, add clear-killed-strings.
;05/04/90 bill restore-lisp-pointers sets *foreground* to T.
;03/31/90 bill kill-lisp-pointers kills frecs
;03/16/90 bill prepare-to-quit replaces in-line window closing in save-application & dumplist
;2/5/90   gz   compress lives again.
;12/26/89 bill Add t second parameter to all windows calls: must deallocate
;              ALL windows, visible or not.
;12/27/89 gz   Split off save-image...
;12/21/89 gz   Don't use lfun-name to restore %pascal-functions%.  Rely on
;              the identity of macptrs instead.
;11/14/89 gz   Don't worry about *record-types* info.
;11/06/89 gb   zap managed vector space.
;10/14/89 gz   Split off open-dumplisp-file
;10/13/89 bill Call *lisp-cleanup-functions* in save-application before
;              closing windows.
;09/25/89 gz   Reserve room for header before calling $sp-saveappl.
;11/10/89 gb? def of *lisp-system-pointer-functions* moved to l1-init
;09/16/89 bill Remove the last vestiges of object-lisp windows
;07/25/89 bill kill-lisp-pointers, dumplisp & save-application:
;              close the CLOS windows, too. This is a temporary fix while
;              CLOS and object-lisp windows need to co-exist.
;07/09/89 gz  $sp-saveappl no longer sets toplevel function.
;04/07/89 gb  $sp8 -> $sp.
;4/4/89   gz  Try to dump new defpascals.
;03/25/89 gz  No more lfundefs resource to remove. toplevel closures ok now.
;             *inest-ptr* -> *interrupt-level*
;03/15/89 gb  %save-application now a kprim.
;02/10/89 gb  :creator arg in save-application.
;01/04/89 gz  (clear-input *terminal-io*) -> (setq *eval-queue* nil)
;11/22/88 gb  restore *record-types* info.
;10/23/88 gb  new restart protocol.
;8/30/88  gb  function made by make-restart-closure sets interrupt-level after without-interrupts.
;8/29/88  gz  new filesys fns.
;8/25/88  gz  $inest-ptr-8 -> $inest, require subprims8.
;8/18/88  gb  screw pushing :stand-alone onto *features*.
;8/8/88   gb  %hput-long -> %hput-ptr ldef-proc-handle ... in restore-lisp-pointers.
;8/8/88   gb  8.1
;7/30/88  gz  new macptr scheme (sort of).
;6/23/88  jaj #-bccl save-application
;6/22/88  jaj (setq %doc-string-file nil) in restore-lisp-pointers
;6/21/88  jaj nillify *window-object-alist* in kill-lisp-pointers
;             moved exports to ccl-export-syms
;6/20/88  jaj save-application creates files of type APPL
;6/10/88  jaj (ask *terminal-io* (stream-clear-input)) in kill-lisp-pointers
;6/02/88  as  expand some logical pathnames in dumplisp and save-application
;5/26/88  jaj merged in stuff from pearl
;4/25/88  jaj reset *screen-height* and *screen-width* in restore-lisp-pointers
;             close windows first in save-application and dumplisp
;4/21/88  jaj save-application pushes :stand-alone onto *features* set
;             +,++,+++,- to nil
;4/11/88  jaj for save-application and dumplisp: simplified keywords, added watch-cursor
;             use :if-exists :supersede. In kill-lisp-pointers setq *, **, *** to nil.
;             restore-lisp-pointers calls init-logical-directories. re-init random
;4/9/88   jaj kill-lisp-pointers disposes style handles
;4/6/88   as  kill-lisp-pointers sets %doc-string-file to nil
;4/6/88   jaj Beanified save-application
;4/1/88   jaj Beanified

(in-package :ccl)

(eval-when (:compile-toplevel :execute)
  (require :sysequ)
  ;(require :toolequ)
  #-ppc-target (require :subprims8)
  (require :hide-listener-support)
  )

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :resources))

(defvar *save-exit-functions* nil 
  "List of (0-arg)functions to call before saving memory image")

(defvar *restore-lisp-functions* nil
  "List of (0-arg)functions to call after restoring saved image")

(defvar *old-menubar*)

(declaim (special *lisp-system-pointer-functions*)) ; defined in l1-init.

(defparameter *patched-resources* nil)

(defun kill-lisp-pointers ()
  (declare (special *environment-dialog*  *apropos-dialog*))
#|
  (when (simple-vector-p %pascal-functions%)
    (dotimes (i (length %pascal-functions%))
      (declare (fixnum i))
      (let* ((cons (%svref %pascal-functions% i)))
        (when (consp cons)
          (let ((macptr (%car cons)))
            (setf (%car cons) 
                  (cons macptr
                        (defpascal-trampoline-without-interrupts-p macptr))))))))
|#
  (do-all-windows w
    (window-close w))
  (update-windows-menu *windows-menu*) ; just in case
  (if (fboundp 'kill-frec-list)
    (kill-frec-list))
  (setq %doc-string-file nil)
  (if *fast-help* (setq *fast-help* t))
;  (setq ccl::*grow-bm* nil)
;  (setq ccl::*big-rgn* nil)
;  (setq ccl::*big-rect* nil)
;  (setq ccl::*control-x-cursor* nil)
; (let ((c (find-class 'table-dialog-item nil)))
;    (if c (set-class-slot-value c 'ldef-proc-handle (%unbound-marker-8))))
  (if (boundp '*environment-dialog*)
    (setq *environment-dialog* nil))
  #|
  (if (boundp '*print-options-dialog*)
    (setq *print-options-dialog* nil))
  |#
  (if (boundp '*apropos-dialog*)
    (setq *apropos-dialog* nil))
  (dolist (pair *scrap-handler-alist*)
    (set-internal-scrap (cdr pair) nil))
  (clear-killed-strings)
  (setq *last-choose-file-directory* nil)
  (setq * nil ** nil *** nil + nil ++ nil +++ nil - nil
        / nil // nil /// nil
        %saved-ioVRefnum% nil %saved-directory-path% nil
        *open-file-streams* nil
        *scrap-state* nil *external-scrap* nil @ nil)
  (setq *script-char-byte-tables* nil)
  ;(setq *script-char-sort-tables* nil)
  ;(setq *script-char-equal-sort-tables* nil)
  ;(setq *script-char-up-tables* nil)
  ;(setq *script-char-down-tables* nil)
  (setq *old-menubar* (menubar))
  (setq *uchar-encoding-table* nil)
  (set-menubar nil)
  (setq *patched-resources* nil)
  (setq *event-error-dialog* nil)
  (setq *help-manager-present* nil)
  (setq *alias-manager-present* nil)
;  (%clear-temp-vector-space)
  (setq *eval-queue* nil)
  (loop
    (let ((cell (car *window-object-alist*)))
      (unless cell (return))
        (remove-window-object (car cell))))
  (if (boundp '*window-object-hash*)
    (clrhash (symbol-value '*window-object-hash*)))
  (setq *selected-window* nil)
  (setf (*%saved-method-var%*) nil)
  (setq *%periodic-tasks%* nil)
  (setq *event-dispatch-task* nil)
  (setq *module-file-alist* nil)        ; nuke paths to lisp files
  (#_FlushEvents (logand #$EveryEvent #xffff) 0)
  #+(and interfaces-2 (not ppc-target))
  (progn
    (save-trap-pointer-to-array)
    ;;(setq *ff-traps* nil)
    (setq *ff-trap-pointer* nil))
  (clear-shared-library-caches))


(defun process-lsiz-options (option-list)
  (when option-list
    (destructuring-bind (&key (mac-heap-minimum (ash 100 10) macmin-p)
                              (mac-heap-maximum (ash 400 10) macmax-p)
                              (mac-heap-percentage 5 macpct-p)
                              (low-memory-threshold (ash 6 12) lowmem-p)
                              (copying-gc-threshold (ash 1 31) cgc-threshold-p)
                              (stack-maximum (ash 180 10) stackmax-p)
                              (stack-minimum (ash 32 10) stackmin-p)
                              (stack-percentage 6 stackpct-p))
                        option-list
      (if macmin-p (setq mac-heap-minimum (require-type mac-heap-minimum '(unsigned-byte 31))))
      (if macmax-p (setq mac-heap-maximum (require-type mac-heap-maximum '(unsigned-byte 31))))
      (if macpct-p (setq mac-heap-percentage (require-type mac-heap-percentage '(integer 0 (100))))) ; Right ...
      (if lowmem-p (setq low-memory-threshold 
                         (logand (lognot 4095) (+ 4095 (require-type low-memory-threshold '(unsigned-byte 31))))))
      (if cgc-threshold-p (setq copying-gc-threshold (require-type copying-gc-threshold '(unsigned-byte 31))))
      (if stackmax-p (setq stack-maximum (require-type stack-maximum '(unsigned-byte 31))))
      (if stackmin-p (setq stack-minimum (require-type stack-minimum '(unsigned-byte 31))))
      (if stackpct-p (setq stack-percentage (require-type stack-percentage '(integer 0 (100)))))
      (if (> mac-heap-minimum mac-heap-maximum)
        (error "~s (~s) can't be greater than ~s (~s)." 
               :mac-heap-minimum mac-heap-minimum
               :mac-heap-maximum mac-heap-maximum))
      (if (> stack-minimum stack-maximum)
        (error "~s (~s) can't be greater than ~s (~s)."
               :stack-minimum stack-minimum
               :stack-maximum stack-maximum))
      (let* ((handle (#_NewHandle :errchk 28)))
        (with-dereferenced-handles ((h handle))
          (setf (%get-long h 0) mac-heap-minimum
                (%get-long h 4) mac-heap-maximum
                (%get-word h 8) mac-heap-percentage
                (%get-long h 10) low-memory-threshold
                (%get-long h 14) copying-gc-threshold
                (%get-long h 18) stack-minimum
                (%get-long h 22) stack-maximum
                (%get-word h 26) stack-percentage))
        (list handle "LSIZ" 1)))))

; should really just get all the resources in the file - oh well another day!
; That day has come! Hallellujah.
; P.S. if you don't provide FREF goo your app will accept MCL docs
(defun get-app-resources (res-file sig)
  (let (resources)
    (when (and (stringp res-file)
               (string/= res-file "")
               (probe-file res-file)
               (neq 0 (file-resource-size res-file)))
      (with-open-resource-file (f res-file)
        (dolist (type (get-resource-types))
          (let ((nres (#_Count1Resources type)))
            (reserrchk)
            (do* ((index 1 (1+ index)))
                 ((> index nres))
              (multiple-value-bind (res id name)
                                   (load-and-detach-no-error type index)
                (when res
                  (push (if name
                          (list res type id name)
                          (list res type id))
                        resources))))))))
    ; We don't want a "CCL2" resource ...
    (let ((ccl-sig (string *ccl-file-creator*)))
      (unless (and (stringp sig)
                   (string= sig ccl-sig))                
        (push (list nil ccl-sig 0) resources)
        ; We -do- want a resource of type sig ...
        (push (list (#_NewHandle :errchk 0) sig 0 "MCL Application") resources)))
    resources))

(defun get-resource-types ()
  (let ((resources nil)
        (ntypes (#_Count1Types)))
    (reserrchk)
    (rlet ((type :OSType))
      (do ((index 1 (1+ index)))
          ((> index ntypes))
        (#_Get1IndType type index)
        (unless (zerop (%get-long type))
          (push (string (%get-ostype type)) resources))))
    resources))

(defun load-and-detach-no-error (type index)
  (let ((res (#_Get1IndResource type index)))
    (#_LoadResource res)
    (unless (%null-ptr-p res)
      (rlet ((theID :signed-integer)
             (theType :ostype)
             (name (:string 255)))
        (#_GetResInfo res theID theType name)
        (#_DetachResource res)
        (#_HNoPurge res)
        (values res
                (%get-signed-word theID)
                (if (not (eq (%get-byte name) 0))
                  (%get-string name)))))))


; this needs work for the new world order
(defun save-application (filename
                         &rest rest
                         &key init-file toplevel-function menubar
                         error-handler application-class creator excise-compiler
                         SIZE resources clear-clos-caches memory-options)
  (declare (ignore init-file toplevel-function creator excise-compiler size
                   hide-listener menubar error-handler application-class
                   resources clear-clos-caches memory-options))
  (let ((listener *top-listener*))
    ;(if (not size) 
     ; (setq rest  (list* ':size (list (* 4096 1024)  (* 3584 1024))  rest)))
    (terminate-standin-event-processor
     #'(lambda ()
         (apply #'process-interrupt
                *initial-process*
                #'%save-application-internal
                listener
                filename
                rest)))))

(defun %save-application-internal (listener filename &key
                                            (init-file nil init-file-p)
                                            toplevel-function  ;????                                             
                                            ;hide-listener 
                                            menubar
                                            error-handler ; meaningless unless application-class or *application* not lisp-development..
                                            application-class
                                            creator 
                                            excise-compiler                                            
                                            resources
                                            (clear-clos-caches t)
                                            memory-options
                                            size)  
  (when (and application-class (neq  (class-of *application*)
                                     (if (symbolp application-class)
                                       (find-class application-class)
                                       application-class)))
    (setq *application* (make-instance application-class)))
  (when (not creator)(setq creator (application-file-creator *application*)))
  (when (not toplevel-function)
    (setq toplevel-function 
          #'(lambda ()
              (toplevel-function *application* 
                                 (if init-file-p
                                   init-file
                                   (application-init-file *application*))))))
  (when error-handler
    (require :hide-listener-support)
    (make-application-error-handler *application* error-handler))
  (when menubar (set-menubar menubar))
  #+ignore
  (when size
    (if (integerp size)
      (setq size (list size size)))
    (unless (and (listp size) 
                 (= (length size) 2) 
                 (integerp (car size))                    
                 (integerp (cadr size))
                 (>= (car size) (cadr size) 0))
      (error "Invalid ~S argument : ~S" :size size)))
  (when size 
    (if (fixnump size)  ;; its size in kb
      (setq *max-heap-size* size)
      (error "Invalid ~S argument : ~S" :size size)))      
  (setq resources (append resources *patched-resources*))
  (let* ((nv (new-version-resource)))
    (when nv (push nv resources)))
   ;; try again for OSX
  (let ((cfrg (new-cfrg-resource)))
    (when cfrg (push cfrg resources)))
  (let* ((lsiz (process-lsiz-options memory-options)))
    (when lsiz (push lsiz resources)))
  (prepare-to-quit listener)
  (setq *recent-files* nil)
  (if clear-clos-caches (clear-clos-caches))
  (if excise-compiler (excise-compiler))
  (save-image (let ((vrefnum (require-type
                              (volume-number (directory-namestring filename))
                              'fixnum))
                    (refnum (open-dumplisp-file filename creator size resources)))
                #'(lambda () (%save-application vrefnum #xc0 refnum)))
              ;This is a bit bogus.  Specifying an init-file arg means requesting
              ;the usual lisp startup actions (load init file, print greeting and
              ;run *lisp-startup-functions*).  Really should have some more
              ;explicit arguments for specifying this stuff.
              #'(lambda ()
                  (%set-toplevel #'event-processing-loop)
                  (when toplevel-function
                    (if *single-process-p*
                      (funcall toplevel-function)
                      (process-run-function "Startup" toplevel-function))))))

(defun save-image (save-function toplevel-function)
  (with-cursor *watch-cursor*
    (let ((toplevel (%set-toplevel)))
      (%set-toplevel #'(lambda ()
                         (setq *interrupt-level* -1
                               *event-mask* (logand (lognot #$highLevelEventMask) #$everyEvent))
                         (%set-toplevel toplevel)       ; in case *save-exit-functions* error
                         (dolist (f *save-exit-functions*)
                           (funcall f))
                         (kill-lisp-pointers)
                         (%set-toplevel
                          #'(lambda ()
                              (%set-toplevel toplevel-function)
                              (restore-lisp-pointers)))   ; do startup stuff
                         (funcall save-function)))
      (toplevel))))

;(defparameter *contextual-menu-cursor* nil)
;(defparameter +contextual-menu-cursor-id+ nil)

; "size" arg is list of (preferred size, minsize) or NIL.
; "resources" arg is list of resource specs: (<handle to data> <type> <id> &optional <name-string>)





(defparameter *use-app-resources* t)

;; for new headers
;; well at least the containing dir can have a funky name - the file itself cannot
;; somebody's refnums don't agree
#+interfaces-3
(defun open-dumplisp-file (filename creator &optional size resources &aux refnum resrefnum finished?)
  (setq filename (create-file filename :if-exists :supersede :mac-file-creator creator
                              :mac-file-type "APPL"))
  (let* ((bndl (#_Get1Resource "BNDL" 128))
         (bndl-p (not (%null-ptr-p bndl))))
    ;(when bndl-p (#_loadresource bndl))
    (unwind-protect
      (with-cursor *watch-cursor*
        
        (rletz ((fsref :fsref)
                (fsspec :fsspec))
          (path-to-fsref filename fsref)
          (#_fsgetcataloginfo fsref 0 (%null-ptr) (%null-ptr) fsspec (%null-ptr))
          (%stack-block ((pb (record-length :hparamblockrec) :clear t))
            (with-pstrs ((s (pref fsspec :fsspec.name)))                
              (setf (pref pb :hparamblockrec.fileparam.iovrefnum)(pref fsspec :fsspec.vrefnum)
                    (pref pb :hparamblockrec.fileparam.iodirid) (pref fsspec :fsspec.parid)
                    (pref pb :hparamblockrec.fileparam.ionameptr) s)
              (setf (pref pb :hparamblockrec.ioparam.iopermssn) #$fswrperm)
              (errchk (#_PBHOpenSync pb))
              (setq refnum (pref pb :hparamblockrec.fileparam.iofrefnum))
              (setf (pref pb :hparamblockrec.ioparam.iomisc) 0)  ;; (%put-long pb 0 $ioLEOF)??
              (errchk (#_PBSetEOFSync pb))))            
          ; Copy the resource fork
          (cond 
           (*use-app-resources*
            (copy-file (get-app-pathname) filename :fork :resource :blocksz 1024)
            
            (setq resrefnum (open-resource-file-from-fsref fsref #$fsRdWrPerm)) ;?          
            (when (neq resrefnum -1)  ;(or size resources)
              (dolist (resource resources)  ;; includes new cfrg
                (if (listp resource)
                  (destructuring-bind (data type id &optional (name "")) resource
                    (let ((oldh (#_Get1Resource type id)))  ;; is that from currently open resource file?
                      (unless (%null-ptr-p oldh)
                        (#_RemoveResource oldh)))
                    (when data
                      (with-pstrs ((namep name))
                        (#_Addresource data type id namep))))
                  (funcall resource filename)))
              #+ignore
              (when (and (boundp '*contextual-menu-cursor*)(boundp '+contextual-menu-cursor-id+) *contextual-menu-cursor*)
                ;; is there a better place to do this??? surely there must be - now there is
                (with-pstrs ((namep ""))
                  (#_addresource *contextual-menu-cursor* "CURS" +contextual-menu-cursor-id+ namep)))
              (when t ;size
                (let ((preferred-size (car size))
                      (min-size (cadr size)))
                  ; no size provided - take from current app
                  ; if size is provided use it with sanity check - perhaps warn
                  (if (and preferred-size (< preferred-size (* 1024 4096)))
                    (cerror "Use minimum recommended size."
                            "Preferred size ~s is below recommended preferred size ~s.~&Sizes are in bytes, not kilobytes."
                            preferred-size (* 1024 4096)))
                  (if preferred-size (setq preferred-size (max (* 1024 4096) preferred-size)))
                  (if min-size (setq min-size (max (* 1024 3584) min-size)))
                  (let ((i 0)
                        sizeh cur-psize cur-msize)
                    ; take current sizes from last size resource
                    (while (not (%null-ptr-p (setq sizeh (#_get1resource "SIZE" i))))
                      (setq cur-psize (%hget-long sizeh 2))
                      (setq cur-msize (%hget-long sizeh 6))
                      (#_RemoveResource sizeh)
                      (setq i (1+ i)))             
                    (unless (%null-ptr-p (setq sizeh (#_Get1Resource "SIZE" -1)))
                      (#_LoadResource sizeh)
                      (%hput-word sizeh (logior #$modedisplaymanageraware (%hget-word sizeh 0)) 0)
                      (%hput-long sizeh 
                                  (or preferred-size cur-psize (%hget-long sizeh 2))
                                  2)
                      (%hput-long sizeh
                                  (or min-size  cur-msize (%hget-long sizeh 6)) 
                                  6)
                      (#_ChangedResource sizeh)))))))
           (t (let* ()                
                (with-open-resource-file (refnum filename :if-does-not-exist :create)
                  ;; cfrg vers and bndl - icons?
                  (using-resource-file refnum
                    (with-pstr (namep "")
                      (when bndl-p
                        ;; (#_addresource bndl "BNDL" 128 namep)  ;; doesn't work - err -54
                        )
                      (#_AddResource (#_newhandle 0) "carb" 0 namep)) ;; need for not open in classic
                    (dolist (res resources)
                      (when (listp res)
                        (destructuring-bind (data type id &optional (name "")) res
                          (when (or (eq type :|cfrg|)(eq type :|vers|))
                            (with-pstrs ((namep name))
                              (#_Addresource data type id namep)))))))))))
          (let* ()
            (rletZ ((catinfo :fscataloginfo))
              (fsref-get-cat-info fsref catinfo #$kFSCatInfoFinderInfo)
              (let ((flags (pref catinfo :FSCataloginfo.FinderInfo.finderflags)))
                (declare (fixnum flags))
                (setf (pref catinfo :FSCataloginfo.FinderInfo.finderflags)
                      (if (or bndl-p (not *use-app-resources*)) ;; ??
                        (logior flags #$kHasBundle)
                        (logand flags (lognot #$kHasBundle))))
                (fsref-set-cat-info fsref catinfo #$kFSCatInfoFinderInfo))))
          (setq finished? t)))
    ; unwind-protect cleanup forms
      
    (When (and resrefnum (neq resrefnum -1)) (#_CloseResFile resrefnum))
    ;(print finished?)
    (unless finished?
      (when refnum        
        (rletZ ((pb :hparamblockrec))
          (setf (pref pb :hparamblockrec.ioparam.iorefnum) refnum)
          (errchk (#_PBCloseSync pb)))))))
  refnum)


#+ppc-target
(progn
 

#+interfaces-3  ;; for new headers
(progn
  #+notyet
(defun save-library (pathname cfrg-name &optional firstobj lastobj)
    (setq cfrg-name (format nil "~A@~9,'0X" cfrg-name (get-time-unsigned-long)))
    (setq pathname (create-file pathname :if-exists :supersede :mac-file-type #$kCFragLibraryFileType))
    (set-mac-file-type pathname #$kCFragLibraryFileType)          ; CREATE-FILE won't always. - it better
    (rletZ ((fsref :fsref)
            (fsspec :fsspec))
      (let* () ;(fname (data-fork-name)))
        (path-to-fsref pathname fsref)
        (#_fsgetcataloginfo fsref 0 (%null-ptr) (%null-ptr) fsspec (%null-ptr))
        (%stack-block ((pb (record-length :hparamblockrec) :clear t))
          (with-pstrs ((s (pref fsspec :fsspec.name)))            
            (setf (pref pb :hparamblockrec.fileparam.iovrefnum)(pref fsspec :fsspec.vrefnum)
                  (pref pb :hparamblockrec.fileparam.iodirid) (pref fsspec :fsspec.parid)
                  (pref pb :hparamblockrec.fileparam.ionameptr) s)
            (setf (pref pb :hparamblockrec.ioparam.iopermssn) #$fswrperm)
            (errchk (#_PBHOpenSync pb))
            
            #|
        (rletZ ((paramBlock :FSForkIOParam))          
          (setf (pref paramblock :FSForkIOParam.ref) fsref
                (pref paramblock :FSForkIOParam.forkNameLength) (pref fname :hfsunistr255.length)
                (pref paramblock :FSForkIOParam.forkName)       (pref fname :hfsunistr255.unicode)
                (pref paramblock :FSForkIOParam.permissions) #$fswrperm)
          (errchk (#_PBOpenForkSync paramblock))
          |#
            (multiple-value-bind (err version)
                                 (%save-library 
                                  (pref pb :hparamblockrec.fileparam.iofrefnum)
                                  cfrg-name firstobj lastobj)
              (unless (eql err #$noErr)
                (%err-disp err))
              (let ((resrefnum (%open-res-file2 pathname)))
                (when (not resrefnum)(error "cant create resfile ~S" pathname))
                (#_UseResFile resrefnum)
                (let* ((cfrg (create-lib-cfrg-handle cfrg-name version)))
                  (with-pstrs ((resname ""))
                    (#_AddResource cfrg #$kCFragResourceType #$kCFragResourceID resname)))
                (#_CloseResfile resrefnum))            
              ))))))
)

#-interfaces-3 ;; for old headers
(defun save-library (pathname cfrg-name &optional firstobj lastobj)
    (setq cfrg-name (format nil "~A@~9,'0X" cfrg-name (get-time-unsigned-long)))
    (setq pathname (create-file pathname :if-exists :supersede :mac-file-type #$kCFragLibraryFileType))
    (set-mac-file-type pathname #$kCFragLibraryFileType)          ; CREATE-FILE won't always. - it better
    (rletZ ((fsref :fsref)
            (fsspec :fsspec))
      (let* () ;(fname (data-fork-name)))
        (path-to-fsref pathname fsref)
        (#_fsgetcataloginfo fsref 0 (%null-ptr) (%null-ptr) fsspec (%null-ptr))
        (%stack-block ((pb (record-length :hparamblockrec) :clear t))
          (with-pstrs ((s (pref fsspec :fsspec.name)))            
            (setf (pref pb :hparamblockrec.iovrefnum)(pref fsspec :fsspec.vrefnum)
                  (pref pb :hparamblockrec.iodirid) (pref fsspec :fsspec.parid)
                  (pref pb :hparamblockrec.ionameptr) s)
            (setf (pref pb :hparamblockrec.iopermssn) #$fswrperm)
            (errchk (#_PBHOpenSync pb))
            
            #|
        (rletZ ((paramBlock :FSForkIOParam))          
          (setf (pref paramblock :FSForkIOParam.ref) fsref
                (pref paramblock :FSForkIOParam.forkNameLength) (pref fname :hfsunistr255.length)
                (pref paramblock :FSForkIOParam.forkName)       (pref fname :hfsunistr255.unicode)
                (pref paramblock :FSForkIOParam.permissions) #$fswrperm)
          (errchk (#_PBOpenForkSync paramblock))
          |#
            (multiple-value-bind (err version)
                                 (%save-library 
                                  (pref pb :hparamblockrec.iorefnum)
                                  cfrg-name firstobj lastobj)
              (unless (eql err #$noErr)
                (%err-disp err))
              (let ((resrefnum (%open-res-file2 pathname)))
                (when (not resrefnum)(error "cant create resfile ~S" pathname))
                (#_UseResFile resrefnum)
                (let* ((cfrg (create-lib-cfrg-handle cfrg-name version)))
                  (with-pstrs ((resname ""))
                    (#_AddResource cfrg #$kCFragResourceType #$kCFragResourceID resname)))
                (#_CloseResfile resrefnum))            
              ))))))

(defun create-lib-cfrg-handle (component-name version)
  (let* ((cnamelen (length component-name))
         (prefix-size 32)
         (var-size (* 4 (ceiling (+ 42 1 cnamelen) 4)))
         (hsize (+ prefix-size var-size))
         (h (#_NewHandleClear :errchk hsize)))
    (setf (ccl::%hget-long h 8) 1)      ; cfrg version
    (setf (ccl::%hget-long h 28) 1)     ; count
    (setf (ccl::%hget-ostype h (+ prefix-size 0)) #$kPowerPCCFragArch)
    (setf (ccl::%hget-long h (+ prefix-size 8))
          (setf (ccl::%hget-long h (+ prefix-size 12))
                version))
    (setf (ccl::%hget-byte h (+ prefix-size 23)) 1)  ;; #$kOnDiskFlat - it's an oldRoutineName
    (setf (ccl::%hget-word h (+ prefix-size 40)) var-size)
    (setf (ccl::%hget-byte h (+ prefix-size 42)) cnamelen)
    (dotimes (i cnamelen)
      (setf (ccl::%hget-byte h (+ prefix-size 43 i)) (char-code (schar component-name i))))
    h))

)
; Doesn't really belong here, but.

            
#+ppc-target
(defun excise-compiler ()
   (if *nx1-alphatizers* (clrhash *nx1-alphatizers*))
   (%init-misc 0 *ppc2-specials*)
   (setq *compile-definitions* nil)
   (flet ((remove-startup-function (name)
            (setq *lisp-system-pointer-functions*
                  (delete name *lisp-system-pointer-functions*
                          :key #'function-name))))
     (dolist (f '(*ppc-operand-vector-freelist*
                  *ppc-lap-instruction-freelist*
                  *ppc-lap-label-freelist*
                  *vinsn-varparts*
                  *vinsn-label-freelist*
                  *vinsn-freelist*))
       (remove-startup-function f)))
   (ppc-ff-call (%kernel-import ppc::kernel-import-excise-library)
                :unsigned-fullword 2    ; magic number
                :void))

        


#+ppc-target
(progn
(defun %save-application (vrefnum cflags refnum)
  (declare (ignore vrefnum cflags))
  (let* ((err (%%save-application refnum)))
    (unless (eql err #$noErr)
      (%err-disp err))))
  

(defppclapfunction %%save-application ((refnum arg_z))  (check-nargs 1)  (save-lisp-context)  (bla .SPxalloc-handler)
  (uuo_xalloc rzero rnil arg_z)
  (ba .SPpopj))

)

(defun restore-lisp-pointers ()
  (initialize-shared-libraries)   ; This must happen first
  ;(dbg 4)
  #-ppc-target (initialize-ff-traps-pointer)
  (initialize-bundles)  
  (restore-pascal-functions)
  ;(dbg 8)
  (dolist (f (reverse *lisp-system-pointer-functions*))
    (funcall f))
  (setq *foreground* t)                 ; Necessary if you save a world under MultiFinder and run it in UniFinder.
  ;(dbg 9)
  (set-menubar *old-menubar*)
  ;(dbg 10)
  (setq *system-script* nil)
  (let ((restore-lisp-fns *restore-lisp-functions*)
        (user-pointer-fns *lisp-user-pointer-functions*)
        (lisp-startup-fns *lisp-startup-functions*))
    (unwind-protect
      (with-simple-restart (abort "Abort (possibly crucial) startup functions.")
        (let ((call-with-restart
               #'(lambda (f)
                   (with-simple-restart 
                     (continue "Skip (possibly crucial) startup function ~s."
                               (if (symbolp f) f (function-name f)))
                     (funcall f)))))
          (dolist (f restore-lisp-fns) (funcall call-with-restart f))
          (dolist (f (reverse user-pointer-fns)) (funcall call-with-restart f))
          (dolist (f (reverse lisp-startup-fns)) (funcall call-with-restart f))))
      (setq *interrupt-level* 0)))
  ;(dbg 11)
  nil)


#-carbon-compat
(defun  restore-pascal-functions ()
  (setq *call-universal-proc-address* nil)
  (when (simple-vector-p %pascal-functions%)
    (dotimes (i (length %pascal-functions%))
      (let ((pfe (%svref %pascal-functions% i)))
        (when (vectorp pfe)
          (let ((routine-descriptor (make-routine-descriptor i (pfe.proc-info pfe)))
                (name (pfe.sym pfe)))
            (setf (pfe.routine-descriptor pfe) routine-descriptor)
            (when name
              (set name routine-descriptor))))))))

#+carbon-compat
(defun  restore-pascal-functions ()
  (setq *call-universal-proc-address* nil)
  (when (simple-vector-p %pascal-functions%)
    (dotimes (i (length %pascal-functions%))
      (let ((pfe (%svref %pascal-functions% i)))
        (when (vectorp pfe)
          (let ((routine-descriptor (make-routine-descriptor i (pfe.proc-info pfe) #$kPowerPCISA (pfe.sym pfe)))
                (name (pfe.sym pfe)))
            (setf (pfe.routine-descriptor pfe) routine-descriptor)
            (when name
              (set name routine-descriptor))))))))

#+ignore
(defun lose-cmd-q ()
  (when (not (osx-p))
    (let ((item (find-menu-item *file-menu* "Quit")))
      (when item 
        (let ((items (menu-items *file-menu*)))
          ;; lose the separator too
          (apply 'remove-menu-items *file-menu*
                 (last items 2)))))))

;(pushnew 'lose-cmd-q *save-exit-functions*)

(eval-when (load eval)
  ;(setq *save-exit-functions* (list #'kill-lisp-pointers))
  ;(setq *restore-lisp-functions* (list #'restore-lisp-pointers))
)

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
