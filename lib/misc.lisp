;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: misc.lisp,v $
;;  Revision 1.19  2006/02/12 21:57:22  alice
;;  ;; lose sleepq stuff - not used
;;
;;  Revision 1.18  2006/02/04 01:05:43  alice
;;  ; call cfstringgetcharacters vs: #_ of same
;; function-spec-handler - error is type-error
;;
;;  Revision 1.17  2005/02/18 08:53:40  alice
;;  ;; machine-owner and machine-instance return unicode vs. macroman
;;
;;  Revision 1.16  2005/02/02 01:00:18  alice
;;  ;; forget usage of define-entry-point
;;
;;  Revision 1.15  2004/11/22 18:44:45  svspire
;;  Fix documentation method for packages not to error when package doesn't have documentation.
;;
;;  Revision 1.14  2004/10/19 01:04:52  alice
;;  ;; make documentation of standard-generic-function work if in help-file
;;
;;  Revision 1.13  2004/10/11 23:47:59  alice
;;  ;; add method documentation for slot-definition
;;
;;  Revision 1.12  2003/12/29 04:22:14  gtbyers
;;  Two definitions of EDIT-DEFINITION is one too many.  There was probably another change (involving treatment of method-specializers), but MacCVSPro's "commit comment" dialog is modal, so I can't see the diff window at the moment ...
;;
;;  Revision 1.11  2003/12/08 08:13:40  gtbyers
;;  GET-PROPERTIES moved elsewhere.
;;
;;  4 10/22/97 akh  see below
;;  3 8/25/97  akh  sleep wakeup
;;  2 3/18/97  akh  fix room for 68K
;;  9 7/18/96  akh  dont remember
;;  2 10/17/95 akh  merge patches
;;  3 4/26/95  akh  dont remember
;;  3 3/2/95   akh  open-doc-string-file says element-type 'base-character
;;  (do not edit before this line!!)

; Copyright 1986-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

; Modification History
;; lose sleepq stuff - not used
;; ----- 5.2b1
;; call cfstringgetcharacters vs: #_ of same
;; function-spec-handler - error is type-error
;; machine-owner and machine-instance return unicode vs. macroman
;; forget usage of define-entry-point
;; ------ 5.1 final
;; fix documentation method for packages not to error when package doesn't have documentation
;; make documentation of standard-generic-function work if in help-file
;; add method documentation for slot-definition
;; --------- 5.1b3
;; akh - forget sleepq stuff for OSX - causes problems with OpenTransport and should not be necessary
;; akh - revive old sleepq stuff for OSX, the appleevent is gone (sigh).
;; ---------- 5.0b3
;; better machine-type from Shannon Spires, forget fpu in machine-version
;; --------- 4.4b5
;; software-version fer oxs
;; 12-24-2002 ss %get-cfstring moved to here
;; 12-13-2002 ss *machine-type* so users can set themselves if desired
;; 12-11-2002 ss machine-type punt using #$gestaltUserVisibleMachineName.
;; 12-10-2002 ss machine-instance, machine-owner, software-type for OSX/Carbon. Still need to make machine-type,
;;            machine-version non-bogus. But (gestalt :|mach|) is not supported in Carbon, so whaddya gonna do?
;; ----- 4.4b4
;; forget sleepq stuff if carbon - use appleevent
; 04/20/00 use NewSleepQUPP if carbon
; --------- 4.3.1
; 04/02/99 akh - another software-type from David L.
; 03/19/99 akh deftype boolean for 68K
; ----------- 4.3b1
;07/08/98 akh documentation more like CL spec. Don't put nil values in %documentation hash-table
;03/31/98 akh add documentation for funcallable-standard-class
;11/24/97 akh software-version and type from David Lamkins
;10/22/97 akh sleep-q-install and remove depend on *can-powermanager-dispatch*
;10/04/96 slh   set-function-info back here
;10/03/96 slh   set-function-info -> l1;utils.lisp, for early inlines
;05/29/96 bill  buffer-current-symbol tries to do something reasanable if readtable-case is :preserve
;-------------  MCL-PPC 3.9
;03/29/96 bill  #+ppc-taret => #+ppc-target before purge-functions def
;03/26/96  gb   lowmem accessors.
;02/29/96 bill  PPC purge-functions stub for backward compatibility.
;02/27/96 bill  post-egc-hook-enabled-p and set-post-egc-hook-enabled-p
;11/30/95 slh   no purge-functions for PPC
; 6/06/95 slh   Bill's fix: pathname-to-window works if there is an alias in the pathname
; 4/06/95 slh   broke out doc-window.lisp
; 3/07/95 slh   ignore-errors in get-help-file-entry (help file may be corrupted)
;-------------- 3.0d17
;    ?          begin-doc-output fresh-line vs unconditional newline
;               nuke edit-anything-result-pos in begin-doc-output
;06/14/94 bill  report-time accounts for consing a bignum to sample initial-consed
;-------------- 3.0d13
;05/06/93 bill  add-gc-hook, remove-gc-hook
;-------------- 3.0d8
;01/28/93 alice added documentation-p
;11/19/92 alice changed doc stuff to take optional where arg
;12/30/92 bill show-documentation now shows DEFCLASS documentation
;12/14/92 bill some "~:D"'s in ROOM & REPORT-TIME.
;11/20/92 gb   some changes to ROOM (still need to report "stack usage" more intelligently or not at all.)
;09/07/92 bill show-documentation window now shows arglists for symbols not in the help file.
;07/31/92 bill machine-owner
;05/28/92 bill get-help-file-entry uses accessing-index-stream
;-------------  2.0
;03/10/92 bill  show-documentation now displays documentation for generic functions
;               with DEFGENERIC-supplied doc strings.
;------------- 2.0f3
;02/22/92 (bill from "post 2.0f2c5:trap-doc-patch")
;              Make c-x c-d work properly for trap definitions by fixing SHOW-TRAP-DOCUMENTATION.
;------------- 2.0f2c5
;12/24/91 gb   don't allow &LAP, etc. to inline in SET-FUNCTION-INFO.
;------------- 2.0b4
;11/20/91 bill (gb) set-function-info
;11/18/91 bill Fix bug in documentation of a macro or special form with no doc string
;11/15/91 gb   experiment with paying attention.
;11/05/91 gb   experiment with INLINE.
;10/29/91 alice def-load-pointers => def-ccl-pointers
;09/18/91 bill teach show-trap-documentation about simple traps
;08/24/91 gb   use new trap syntax.
;08/20/91 bill return $cons-area.total as third value from %cons-area-sizes
;08/07/91 bill documentation is a generic function.
;07/10/91 bill cons-area-sizes accepts :static
;07/21/91 gb   fix total-bytes-allocated.  Change TIME/REPORT-TIME to pass body as closure.
;              no buckets in hash-tables anymore.
;06/10/91 bill cons-area-sizes
;------------- 2.0b2
;05/29/91 bill only query for help-file if user explicitly says (documentation ...) or c-x c-d
;05/29/91 gb   New cons-area equates; call (GCTIME) in time macro.
;05/23/91 bill optional args to open-doc-string-file, get-doc-string-file, get-help-file-entry disable
;              user-interaction.  ignore-errors in maybe-load-help-map
;05/21/91 bill don't return null strings from MACHINE-INSTANCE
;05/20/91 gb   MACHINE-INSTANCE looks at name of mac before looking at name of user.
;              ROOM, etc. know about new heap layout.
;04/25/91 bill open-doc-string-stream checks for reindexing, then opens file for input (vice io)
;04/09/91 bill in open-doc-string-file - if open for :io fails, try :input
;04/04/91 bill keep *doc-string-stream* open
;04/04/91 bill maybe-load-help-map for use at startup.
;03/04/01 alice report-bad-arg gets 2 args
;02/07/91 alice ccl: => ccl;
;--------------- 2.0b1
;02/04/91 joe  show-trap-documentation
;01/28/91 bill prevent consing in get-help-file-entry when *fast-help* is not a hash table.
;              Also, open help file with :direction :io so that reindexing can happen.
;01/14/91 gb   use time-manager frobs in TIME, REPORT-TIME.
;01/09/91 bill "MACL Help" -> "MCL Help", "helpmap.fasl" -> "MCL Help Map.fasl"
;01/01/90 gb   mess with ROOM and TIME.
;12/13/90 bill documentation looks in the new help file.
;11/30/90 bill comment out old-describe.  New show-documentation mechanism
;09/14/90 bill describe -> old-describe: will disappear later.
;09/09/90 gb  stop using fixnum arithmetic in ROOM.
;08/23/90 bill fred-start-mark -> fred-display-start-mark
;08/17/90 akh revert def of ED so meta-. will work
;08/13/90 alms ED doesn't check pathname-to-window (it calls FRED, which checks)
;07/23/90 bill machine-instance looks up chooser name (doesn't work in System 7)
;07/13/90 gb  New ROOM.  You were warned.
;06/21/90 bill fred takes an optional new-window arg in ed.
;06/12/90 bill window-buffer -> fred-buffer, window-start-mark -> fred-start-mark
;06/04/90 bill in choose-**-dialog: :default -> :directory.
;05/30/90 gb make the world safe for democracy.
;05/24/90 bill window-position & window-size -> view-position & view-size
;5/4/90   gz Use built-in-type-p in %deftype.
;04/30/90 gb report run-time as well as real-time in TIME.
;01/05/89 gz Don't macroexpand into %currenta5.
;12/30/89 gb deftype uses newfangled macro-bind; deftype-arglist defaults &optionals to
;            * vice **.
;12/28/89 gz Allow function name lists in ED.  function specs, deftype.
;11/18/89 gz no more %doc-type-alist, all doc in hash table.
;            set-documentation clears documentation if last arg is nil.
;            sd-superclasses now include self.
;09/27/89 gb simple-string -> ensure-simple-string.
;09/11/89 bill Remove function-binding from copy-symbol
;09/11/89 gz {software,machine}-{type,version} from level-1.
;08/24/89 gb room, again.
;03/25/89 gz purge-functions from level-1.
;03/18/89 gz window-foo -> window-object-foo.
;02/28/89 gz %freepages from kernel.
;02/09/89 gb another room.
;12/30/88 gz New buffers.
;12/28/88 gz get-properties, gentemp, copy-symbol from l1-utils.
;12/11/88 gz mark-position -> buffer-position
;11/16/88 gz new fred windows
;            Changed DOCUMENTATION to return setf'ed string if there is one,
;            even if a system doc string exists.
;            Recompute *documentation-font-spec* when loading.
;            Changed *doc-output* stuff to maintain instance/class distinction.
;            Use hash tables.
;10/29/88 gb proclaimed *doc-output* special.
; 10/15/88 gb symbolic names in TIME macro.
; 9/14/88 gb  room rides again.
; 8/26/88 gz  no more sd-documentation.
; 6/28/88 jaj set-documentation returns string that was passed
; 6/27/88 jaj show documentation checks for symbol
; 6/23/88 as  fixed init-doc-string-file message, use geneva 10
;             instead of times 12 for *documentation-font-spec*
; 6/22/88 jaj removed %doc-file-refnum, close-doc-string-file
; 6/21/88 jaj fixed describe-symbol for uninterned symbols
; 6/10/88 as  handle-string -> handle-to-string
;             call buffer-set-style without length arg
; 6/9/88  as  documentation strings revamped
; 6/9/88  jaj moved defvar of %doc-string-file to l1-inits.lisp, set
;             %doc-file-refnum added close-doc-string-file
; 5/29/88 as  documentation returns a string (and other values)
; 5/25/88 jaj :pathname -> :directory in init-doc-string-file
; 5/24/88 jaj lisp heap size subtracted out of mac heap statistics in room
; 5/20/88 as doc-string stuff brought in from Pearl

; 4/11/88 gz new macptr scheme.
; 8/4/87  gz fix in room.
; 8/1/87  cfry FIXED (ed) . Also ED always returns the WINDOW or NIL
; 7/31/87 gz describe doesn't try to handle objects for now.
;            Checks for hash-table before structurep.  Fix in describe-symbol.
; 7/30/87 gb structure doc goes on plist, any symbol can have structure doc.
; 7/23/87 gz moved machine-instance, etc. to sysutils.
; 7/23/87 cfry fixed ED to accept mac-pathnames
; 7/15/87 gz Mods for new structures, fewer page types
; 7/7/87  gz try to print more stuff slashified in describe (prin1 vs. %print).
;            More informative verbose ROOM output.
;            Print gctime in TIME, not go thru EVAL.
; 6/25/87 gz removed (add-feature 'coral) and (add-feature 'logical-pathnames).
; 6/24/87 cfry describe changed call to no longer existant %pr-thing
; 6/20/87 gb time-aux returns multiple values.  Moved char, set-char to l1-utils.
; 6/08/87 gz fix in describe-symbol
; 5/27/87 gz added misc. string fns formerly in strings.lisp
; 5 19 87 cfry extended ED to edit buffer if it exists, and also to
;              do edit-definition as per CLtL.
; 4/18/87 cfry cleaned up ROOM's message
;4/14/87  gz  removed rm: symbols.
;87 04 08 am  removed identity.
;87 03 24 gb  print-plist terpri's to stream
;87 03 03 am  took out the rm: calls and added #'get-internal-run-time
;87 01 24 gz  lisp:xxx -> xxx, %put -> put, %member -> memq
;             DESCRIBE needs to be redone for Lisp-7 but I didn't bother.
;87 01 21 am took out the CL time functions.

(eval-when (eval compile)
  (require 'defstruct-macros))

#+CARBON-COMPAT
(defun %get-cfstring (cfstrref)
  ; Probably should do some error checking here
  (let ((len (#_CFStringGetLength cfstrref)))
    (%stack-block ((sb (+ len len)))
      (CFStringGetCharacters cfstrref 0 len sb)
      (#_cfrelease cfstrref)  ;;??
      (let ((str (make-string len :element-type 'extended-character)))
        (%copy-ptr-to-ivector sb 0 str 0 (+ len len))))))

(defun short-site-name  () (or *short-site-name* "unspecified"))
(defun long-site-name   () (or *long-site-name* "unspecified"))
(defun machine-instance ()
  "returns macintosh name, else chooser name, else \"unspecified\""
  #+CARBON-COMPAT
  (with-macptrs ((cfstr (#_CSCopyMachineName)))
    (%get-cfstring cfstr))
  #-CARBON-COMPAT
  (let ((h (#_GetString -16413)))
    (if (or (%null-ptr-p h) (%null-ptr-p (%get-ptr h)) (eql 0 (%get-byte (%get-ptr h))))
      (machine-owner)
      (%get-string h))))

(defun machine-owner ()
  "returns chooser name (Owner Name in Sharing Setup control panel), else \"unspecified\""
  #+CARBON-COMPAT
  (with-macptrs ((cfstr (#_CSCopyUserName nil)))  ; or T for short name
    (%get-cfstring cfstr))
  #-CARBON-COMPAT
  (let ((h (#_GetString -16096)))
    (if (or (%null-ptr-p h) (%null-ptr-p (%get-ptr h)) (eql 0 (%get-byte (%get-ptr h))))
      "unspecified"
      (%get-string h))))
#|
(defun machine-instance () (or *machine-instance* "unspecified"))
|#


(defvar *machine-type* nil "If non-nil, value will be returned by #'machine-type.")

(defun machine-type ()
  (or *machine-type* (%machine-type)))

; This one seems to work in Carbon, Classic, and OSX
(defun %machine-type ()
  (%get-string (%int-to-ptr (gestalt #$gestaltUserVisibleMachineName))))


(defun machine-version ()
  (let* ((name (machine-type)) ;(getf *environs* :machine-type))
         (comma " with ")
         temp)
    (when (setq temp (getf *environs* :processor))
      (setq name (%str-cat name comma (format nil "~d" temp))
            comma ", "))
    #-carbon-compat ;; or just lose it 
    (when (setq temp (getf *environs* :fpu))
      (setq name (%str-cat name comma (format nil "~d" temp))
            comma ", "))
    (when (setq temp (getf *environs* :keyboard))
      (setq name (%str-cat name comma temp)))
    name))



;; newer from David Lamkins
(defun software-type ()
  (if t ;(osx-p)
    "Macintosh OSX"
    (let* ((macsh (or (let ((h (#_GetResource :|STR | 0)))
                        (if (%null-ptr-p h)
                          nil
                          h))
                      (#_GetResource :|MACS| 0)))
           (macss (or (and (not (%null-ptr-p macsh))
                           (%get-string macsh))
                      "Unknown"))
           (pos (or (search "Macintosh" macss :test #'string=)
                    (position #\© macss)
                    0))
           (end (if (char= #\© (char macss pos))
                  (or (string-eol-position  macss pos)
                      (length macss))
                  (or
                   (search "version" macss
                           :start2 pos :test #'string-equal)
                   (let ((inc (search "Inc." macss
                                      :start2 pos :test #'string=)))
                     (when inc (+ 4 inc)))
                   (position #\Space macss)
                   (string-eol-position macss)
                   (length macss)))))
      (string-trim ", " (%substr macss pos end)))))

#+ignore
(defun software-version ()
  (%str-cat "Rom Version "
            (%integer-to-string (gestalt "romv") 16)
            ", System Version "
            (let ((sysv (gestalt "sysv")))
              (%str-cat (%integer-to-string (ldb (byte 4 8) sysv))
                        "."
                        (%integer-to-string (ldb (byte 4 4) sysv))
                        "."
                        (%integer-to-string (ldb (byte 4 0) sysv))))))

#|
(defun software-version ()
  (%str-cat "Rom Version "
            (let ((romv (gestalt "romv")))
              (if  romv (%integer-to-string romv 16)
                   "Unknown"))
            
            ", System Version "
            (let ((sysv (gestalt "sysv")))
              (%str-cat (%integer-to-string (ldb (byte 16 8) sysv) 16)
                        "."
                        (%integer-to-string (ldb (byte 4 4) sysv))
                        "."
                        (%integer-to-string (ldb (byte 4 0) sysv))))))
|#

(defun software-version ()
  (%str-cat
   "System Version "
   (let ((sysv (gestalt "sysv")))
     (%str-cat (%integer-to-string (ldb (byte 16 8) sysv) 16)
               "."
               (%integer-to-string (ldb (byte 4 4) sysv))
               "."
               (%integer-to-string (ldb (byte 4 0) sysv))))))



(defvar %doc-res-ids nil)

(defvar %documentation
  (make-hash-table :weak t :size 100 :test 'eq :rehash-threshold .95))

(defmethod documentation ((symbol symbol) &optional (doc-type nil doc-type-p))
  "returns a string or nil"
  (unless doc-type-p
    (doc-type-supplied-p-wrong t))
  (or (cdr (assoc doc-type (gethash symbol %documentation)))
      (let ((thing (case doc-type
                     (function (and ;(not (macro-function symbol))
                                    ;(not (special-form-p symbol))
                                    (fboundp symbol)))
                     (type (find-class symbol nil))
                     ;; and just where does one specify the documentation for a package?
                     (package (find-package symbol))
                     (compiler-macro 
                      (let ((fn (compiler-macro-function symbol)))
                        (if fn (function-name fn)))))))
        ;; this puts us in a loop if we already looked in the hash table and it ain't there
        ;(and thing (method-exists-p #'documentation thing) (documentation thing doc-type))
        (and thing (lookup-documentation thing nil))
        )
      (get-help-file-entry 
       symbol
       #'(lambda (reader arg)
           (skip-past-newline nil reader arg)   ; skip arglist
           (skip-past-newline nil reader arg)   ; skip past type
           ; Read to double newline ignoring font-change info
           (let (char last-char)
             (with-output-to-string (s)
               (loop
                 (setq char (funcall reader arg))
                 (cond ((null char) (return))
                       ((char-eolp char)
                        (if (char-eolp last-char) (return)))
                       ((eql char #\@)
                        (setq char (funcall reader arg))
                        (unless (eql char #\@) (setq char (funcall reader arg)))))
                 (when last-char
                   (stream-tyo s last-char))
                 (setq last-char char)))))
       t)))

; For compatibility
(defun set-documentation (symbol doc-type string)
  (if (or (symbolp symbol) (listp symbol))
    (setf (documentation symbol doc-type) string)
    (setf (documentation symbol) string)))

(defun set-function-info (symbol info)
  (let* ((doc-string (if (consp info) (car info) info)))
    (if (and *save-doc-strings* (stringp doc-string))
      (set-documentation symbol 'function doc-string)))
  (let* ((cons (assq symbol *nx-globally-inline*))
         (lambda-expression (if (consp info) (cdr info))))
    (if (and (proclaimed-inline-p symbol)
             (not (compiler-special-form-p symbol))
             (lambda-expression-p lambda-expression)
             (let* ((lambda-list (cadr lambda-expression)))
               (and (not (memq '&lap lambda-list))
                    (not (memq '&method lambda-list))
                    (not (memq '&lexpr lambda-list)))))
      (if cons 
        (%rplacd cons lambda-expression)
        (push (cons symbol lambda-expression) *nx-globally-inline*))
      (if cons (setq *nx-globally-inline* (delete cons *nx-globally-inline*)))))
  symbol)

(unless (standard-generic-function-p #'(setf documentation))
  (fmakunbound '(setf documentation)))

(defmethod (setf documentation) (string (symbol symbol) &optional (doc-type nil doc-type-p))
  (unless doc-type-p
    (doc-type-supplied-p-wrong t))
  (let* ((documentation (gethash symbol %documentation))
         (pair (assoc doc-type documentation)))
    (if pair 
      (if string
        (%rplacd pair string)
        (puthash symbol %documentation (delete pair documentation)))
      (when string
        (puthash symbol %documentation
                 (cons (cons doc-type string) documentation)))))
  string)

(defun doc-type-supplied-p-wrong (should-be-supplied)
  (error (if should-be-supplied "~s not supplied to ~s." "~s supplied to ~s.")
         'doc-type 'documentation))

(defun lookup-documentation (thing doc-type-p &optional (bad-doc-type nil bad-doc-type-p))
  (when doc-type-p (doc-type-supplied-p-wrong nil))
  (when bad-doc-type-p
    (error "Incorrect doc-type ~S for ~S" bad-doc-type thing))
  (gethash thing %documentation))

(defun (setf lookup-documentation) (documentation thing doc-type-p &optional (bad-doc-type nil bad-doc-type-p))
  (when doc-type-p (doc-type-supplied-p-wrong nil))  
  (when bad-doc-type-p
    (error "Incorrect doc-type ~S" bad-doc-type))
  (if documentation
    (setf (gethash thing %documentation) documentation)
    (remhash thing %documentation)))

(defmethod documentation ((package package) &optional (doc-type t))
  (if (or (eq doc-type t)(eq doc-type 'package))
    (lookup-documentation package nil)
    (lookup-documentation package nil doc-type)))

(defmethod (setf documentation) (documentation (package package) &optional (doc-type t))
  (if (or (eq doc-type t)(eq doc-type 'package))
    (setf (lookup-documentation package nil) documentation)
    (setf (lookup-documentation package nil doc-type) documentation)))

(defmethod documentation ((method standard-method) &optional (doc-type t doc-type-p))
  (declare (ignore doc-type-p))
  (if (or (eq doc-type t)(eq doc-type 'method))
    (lookup-documentation method nil)
    (lookup-documentation method nil doc-type)))

(defmethod (setf documentation) (documentation (method standard-method) &optional (doc-type t doc-type-p))
  (declare (ignore doc-type-p))
  (if (or (eq doc-type t)(eq doc-type 'method))
    (setf (lookup-documentation method nil) documentation)
    (setf (lookup-documentation method nil doc-type) documentation)))

(defmethod documentation ((generic-function standard-generic-function) &optional (doc-type t doc-type-p))
  (declare (ignore doc-type-p))
  (if (or (eq doc-type t)(eq doc-type 'function))
    (or (lookup-documentation generic-function nil)
        (documentation (function-name generic-function) 'function))
    (lookup-documentation generic-function nil doc-type)))

(defmethod (setf documentation) (documentation (generic-function standard-generic-function)
                                               &optional (doc-type t doc-type-p))
  (declare (ignore doc-type-p))
  (if (or (eq doc-type t)(eq doc-type 'function))
    (setf (lookup-documentation generic-function nil) documentation)
    (setf (lookup-documentation generic-function nil doc-type) documentation)))

(defmethod documentation ((class standard-class) &optional (doc-type t doc-type-p))
  (declare (ignore doc-type-p))
  (if (or (eq doc-type t)(eq doc-type 'type)) 
    (or (lookup-documentation class nil)
        (documentation (class-name class) 'type))
    (lookup-documentation class nil doc-type)))

(defmethod (setf documentation) (documentation (class standard-class) &optional (doc-type t doc-type-p))
  (declare (ignore doc-type-p))
  (if (or (eq doc-type t)(eq doc-type 'type))
    (setf (lookup-documentation class nil) documentation)
    (setf (lookup-documentation class nil doc-type) documentation)))

;;; why are there so many of these?
(defmethod documentation ((class funcallable-standard-class) &optional (doc-type t doc-type-p))
   (declare (ignore doc-type-p))
  (if (or (eq doc-type t)(eq doc-type 'type)) 
    (or (lookup-documentation class nil)
        (documentation (class-name class) 'type))
    (lookup-documentation class nil doc-type)))

(defmethod (setf documentation) (documentation (class funcallable-standard-class) &optional (doc-type t doc-type-p))
  (declare (ignore doc-type-p))
  (if (or (eq doc-type t)(eq doc-type 'type))
    (setf (lookup-documentation class nil) documentation)
    (setf (lookup-documentation class nil doc-type) documentation)))

(defmethod documentation ((class structure-class) &optional (doc-type t doc-type-p))
  (declare (ignore doc-type-p))
  (if (or (eq doc-type t)(eq doc-type 'type)) 
    (or (lookup-documentation class nil)
        (documentation (class-name  class) 'structure))
    (lookup-documentation class nil doc-type)))

(defmethod (setf documentation) (documentation (class structure-class) &optional (doc-type t doc-type-p))
  (declare (ignore doc-type-p))
  (if (or (eq doc-type t)(eq doc-type 'type))
    (setf (lookup-documentation class nil) documentation)
    (setf (lookup-documentation class nil doc-type) documentation)))



;; the method for symbol doesn't know about this
(defmethod documentation ((method-combination standard-method-combination) &optional (doc-type t doc-type-p))
   (declare (ignore doc-type-p))
  (if (or (eq doc-type t)(eq doc-type 'method-combination)) 
    (or (lookup-documentation method-combination nil)
        (documentation (method-combination-name method-combination) 'method-combination))
    (lookup-documentation method-combination nil doc-type)))

(defmethod (setf documentation) (documentation (method-combination standard-method-combination)
                                               &optional (doc-type nil doc-type-p))
  (declare (ignore doc-type-p))
  (if (or (eq doc-type t)(eq doc-type 'method-combination))
    ;; do these by name and obj - I'm too dumb to figure out how to get from name to thing
    ;; this is never called by us - we do by name
    (progn
      ;(setf (lookup-documentation method-combination nil) documentation)
      (setf (documentation (method-combination-name method-combination) 'method-combination)
          documentation))
    (setf (lookup-documentation method-combination nil doc-type) documentation)))

(defmethod documentation ((function function) &optional (doc-type t doc-type-p))
  (declare (ignore doc-type-p))
  (if (or (eq doc-type t)(eq doc-type 'function))
    (or (lookup-documentation function nil)
        (documentation (function-name function) 'function))
    (lookup-documentation function nil doc-type)))


(defmethod (setf documentation) (documentation (function function) &optional (doc-type t doc-type-p))
  (declare (ignore doc-type-p))
  (if (or (eq doc-type t)(eq doc-type 'function))
    (setf (lookup-documentation function nil) documentation)
    (setf (lookup-documentation function nil doc-type) documentation)))

(defmethod documentation ((slot slot-definition) &optional (doc-type t))
   ;(declare (ignore doc-type))  ;; error check it? ugh
   (if (or (eq doc-type t)(eq doc-type 'slot-definition))
     (slot-definition-documentation slot)
     (lookup-documentation slot nil doc-type)))

#| ;; not needed AMOP wise
(defmethod (setf documentation) (documentation (slot slot-definition) &optional (doc-type t))
  ;(declare (ignore doc-type))
  (if (or (eq doc-type t)(eq doc-type 'slot-definition)) ;; ugh
    (setf (slot-value slot 'documentation) documentation)
    (setf (lookup-documentation slot nil doc-type) documentation)))
|#


(defun compiler-macro-function-p (func)
  (and (functionp func)
       (let ((name (function-name func)))
         (and (consp  name)
              (eq (car name) 'compiler-macro-function)))))

;;; still missing structure-class (maybe ok now), compiler-macro, method-combination??
;;; error messages are better
;;; we are being a bit sleazy wrto spec by making doc-type optional in some cases - for back compatibility
                          

; We have no slot-description objects yet. Now we do.

(defmethod documentation ((list list) &optional doc-type)
  (if (and (eq doc-type 'compiler-macro) (eq (car list) 'compiler-macro-function))
    (documentation (cadr list) 'compiler-macro)
    (if (eq doc-type 'function)
      (progn
        (fboundp list)                        ; check for legal function spec
        (documentation (setf-function-spec-name list) doc-type))
      (error "Illegal doc-type ~s for type list" doc-type))))

(defmethod (setf documentation) (documentation (list list) &optional doc-type)
  (if (and (eq doc-type 'compiler-macro)(eq (car list) 'compiler-macro-function))
    (setf (documentation (cadr list) 'compiler-macro) documentation)
    (if (eq doc-type 'function)
      (progn
        (fboundp list)                        ; check for legal function spec
        (setf (documentation (setf-function-spec-name list) doc-type) documentation))
      (error "Illegal doc-type ~s for type list" doc-type))))



#|
(setf (documentation 'car 'variable) "Preferred brand of automobile")
(documentation 'car 'variable)
(setf (documentation 'foo 'structure) "the structure is grand.")
(documentation 'foo 'structure)
(setf (documentation 'foo 'variable) "the metasyntactic remarker")
(documentation 'foo 'variable)
(setf (documentation 'foo 'obscure) "no one really knows what it means")
(documentation 'foo 'obscure)
(setf (documentation 'foo 'structure) "the structure is solid")
(documentation 'foo 'function)
|#

#-ppc-target
(progn

(defun cons-area-sizes (area)
  (let ((a5offset (cdr (assq area '((:static . #.$PStatic_cons_area)
                                    (:dynamic . #.$PDynamic_cons_area)
                                    (0 . #.$Pe0cons_area)
                                    (1 . #.$Pe1cons_area)
                                    (2 . #.$Pe2cons_area))))))
    (and a5offset (%cons-area-sizes a5offset))))

(defun %cons-area-sizes (a5offset)
    (let ((gsize 0)
          (isize 0)
          (total-size 0))
      (lap-inline (a5offset)
        (:variable gsize isize total-size)
        (getint arg_z)
        (move.l (a5 arg_z.l) arg_z)
        (if# ne
          (cmp.l (a5 $Pdynamic_cons_area) arg_z)
          (if# ne
            (cmp.l (a5 $Pstatic_cons_area) arg_z)
            (if# ne                           ; ephemeral area, may be bogus
              (move.l (a5 $Pdefault_cons_area) da)
              (cmp.l (a5 $Pe0cons_area) da)))   ; EGC-active-p ?
          (if# eq
            (move.l arg_z atemp0)
            (cmp.l (a5 $Pdefault_cons_area) arg_z)
            (if# eq
              (move.l (a5 $gfree) arg_z)
              (move.l (a5 $ifree) db)
              else#
              (move.l (atemp0 $cons-area.gspace-end) arg_z)
              (move.l (atemp0 $cons-area.ispace-start) db))
            (sub.l (atemp0 $cons-area.gspace-start) arg_z)
            (spush atemp0)
            (vpush db)                          ; fixnum-tagged
            (jsr_subprim $sp-mkulong)
            (vpop db)
            (spop atemp0)
            (move.l acc (varg gsize))
            (move.l (atemp0 $cons-area.ispace-end) arg_z)
            (sub.l db arg_z)
            (spush atemp0)
            (jsr_subprim $sp-mkulong)
            (spop atemp0)
            (move.l acc (varg isize))
            (move.l (atemp0 $cons-area.total) arg_z)
            (jsr_subprim $sp-mkulong)
            (move.l acc (varg total-size)))))
      (values gsize isize total-size)))

(defun %freebytes ()
  (lap-inline ()
    (move.l (a5 $ifree) acc)
    (sub.l (a5 $gfree) acc)
    (jsr_subprim $sp-mkulong)))

(defun %dynamic-heap-size ()
  (lap-inline ()
    (move.l (a5 $Pdynamic_cons_area) atemp1)
    (move.l (atemp1 $cons-area.ispace-end) arg_z)
    (sub.l (atemp1 $cons-area.gspace-start) arg_z)
    (jsr_subprim $sp-mkulong)))

(defun total-bytes-allocated ()
  (lap-inline ()
    (move.l (a5 $Pdynamic_cons_area) atemp1)
    (move.l (a5 $bytes_freed) acc)
    (add.l (atemp1 $cons-area.ispace-end) acc)
    (sub.l (a5 $ifree) acc)
    (add.l (a5 $gfree) acc)
    (sub.l (atemp1 $cons-area.gspace-start) acc)
    (jsr_subprim $sp-mkulong)))


(defun room (&optional (verbose :default))
  (let* ((gaplen (%freebytes))
         (heaps-disjoint-p (neq 0 (%get-long (%currenta5) $macmmulen)))
         (heapspace (#_freemem))
         (moderate (eq verbose :default)))
    (format t "~&There are at least ~:D bytes of available RAM.~%"
            (+ gaplen heapspace))
    (when verbose
      (let ((macheap)
            (lispheap)
            (staticheap)
            (ispace)
            (gspace)
            (2space (neq 0 (%get-long (%currentA5) $Palt_dynamic_cons_area)))
            (static-gspace)
            (static-ispace))
        (lap-inline ()
          (:variable macheap lispheap ispace gspace static-gspace static-ispace staticheap)
          (move.l (a5 $Pdynamic_cons_area) atemp1)
          (move.l (@w $applzone) atemp0)
          (move.l @atemp0 dtemp0)
          (sub.l atemp0 dtemp0)
          (jsr_subprim $sp-mkulong)
          (move.l dtemp0 (varg macheap))
          (move.l (atemp1 $cons-area.ispace-end) dtemp0)
          (sub.l (atemp1 $cons-area.gspace-start) dtemp0)
          (jsr_subprim $sp-mkulong)
          (move.l dtemp0 (varg lispheap))
          (move.l (a5 $Pdynamic_cons_area) atemp1)
          (move.l (a5 $gfree) dtemp0)
          (sub.l (atemp1 $cons-area.gspace-start) dtemp0)
          (jsr_subprim $sp-mkulong)
          (move.l dtemp0 (varg gspace))
          (move.l (a5 $Pdynamic_cons_area) atemp1)
          (move.l (atemp1 $cons-area.ispace-end) dtemp0)
          (sub.l (a5 $ifree) dtemp0)
          (jsr_subprim $sp-mkulong)
          (move.l dtemp0 (varg ispace))
          (move.l (a5 $Pstatic_cons_area) dtemp0)
          (if# ne
            (move.l dtemp0 atemp0)
            (move.l (atemp0 $cons-area.gspace-end) arg_z)
            (sub.l (atemp0 $cons-area.gspace-start) arg_z)
            (jsr_subprim $sp-mkulong)
            (move.l acc (varg static-gspace))
            (move.l (a5 $Pstatic_cons_area) atemp0)
            (move.l (atemp0 $cons-area.ispace-end) arg_z)
            (sub.l (atemp0 $cons-area.ispace-start) arg_z)
            (jsr_subprim $sp-mkulong)
            (move.l acc (varg static-ispace))
            (move.l (a5 $Pstatic_cons_area) atemp0)
            (move.l (atemp0 $cons-area.ispace-end) arg_z)
            (sub.l (atemp0 $cons-area.gspace-start) arg_z)
            (jsr_subprim $sp-mkulong)
            (move.l acc (varg staticheap))))      
        (unless heaps-disjoint-p
          (setq macheap (- macheap (+ lispheap (if 2space lispheap 0) (or staticheap 0)))))
        (flet ((k (n) (floor n 1024)))
        (princ "
                  Total Size             Free                 Used")
        (format t "~&Mac Heap:  ~12T~10D (~DK)  ~33T~10D (~DK)  ~54T~10D (~DK)"
                macheap
                (floor macheap 1024)
                heapspace
                (floor heapspace 1024)
                (- macheap heapspace)
                (ceiling (- macheap heapspace) 1024))
        (format t "~&Lisp Heap: ~12T~10D (~DK)  ~33T~10D (~DK)  ~54T~10D (~DK)"
                lispheap
                (floor lispheap 1024)
                gaplen
                (floor gaplen 1024)
                (+ gspace ispace)
                (floor (+ gspace ispace) 1024))
        (when staticheap
          (format t "~& (Static):  ~10D (~DK)" staticheap (k staticheap)))
        (let ((size (-  (%get-long (%int-to-ptr $curstackbase))
                        (%get-long (%int-to-ptr $heapend)))))
          (format t "~&Stacks:    ~12T~10D (~DK)~%" size (k size)))
        (unless moderate
          (format t "~&Markable objects:  ~10D (~DK)" gspace (k gspace))
          (when staticheap
            (format t " dynamic, ~D (~DK) static." static-gspace (k static-gspace)))
          (format t "~&Immediate objects: ~10D (~DK)" ispace (k ispace))
          (when staticheap
            (format t " dynamic, ~D (~DK) static." static-ispace (k static-ispace))))
        (when 2space (format t "~& Copying GC in effect."))
        (values))))))

) ; #-ppc-target

(defmacro time (form)
  `(report-time ',form #'(lambda () (progn ,form))))

(defun report-time (form thunk)
  (let* ((initial-real-time (get-internal-real-time))
         (initial-run-time (get-internal-run-time))
         (initial-gc-time (gctime))
         (initial-consed (total-bytes-allocated)))
    (multiple-value-prog1 (funcall thunk)
      (let* ((s *trace-output*)
             (bytes-consed (- (total-bytes-allocated) initial-consed
                              (if (fixnump initial-consed) 0 16)))
             (elapsed-real-time (- (get-internal-real-time) initial-real-time))
             (elapsed-run-time (- (get-internal-run-time) initial-run-time))
             (elapsed-gc-time (- (gctime) initial-gc-time))
             (elapsed-mf-time (- elapsed-real-time elapsed-run-time)))
        (format s "~&~S took ~:D milliseconds (~,3F seconds) to run."
                form elapsed-real-time (/ elapsed-real-time internal-time-units-per-second))
        (when (> elapsed-mf-time 0)
          (format s "~%Of that, ~:D milliseconds (~,3F seconds) were spent in The Cooperative Multitasking Experience."
                  elapsed-mf-time (/ elapsed-mf-time internal-time-units-per-second)))
        (unless (eql elapsed-gc-time 0)
          (format s "~%")
          (unless (> elapsed-mf-time 0)
            (format *trace-output* "Of that, "))
          (format s
                  "~:D milliseconds (~,3F seconds) was spent in GC."
                  elapsed-gc-time (/ elapsed-gc-time internal-time-units-per-second)))
        (unless (eql 0 bytes-consed)
          (format s "~% ~:D bytes of memory allocated." bytes-consed))
        (format s "~&")))))

;(rm:heading 2 "Other Environment Inquiries")


; site names and machine-instance is in the init file.

(defun add-feature (symbol)
  "Not CL but should be."
  (if (symbolp symbol)
      (if (not (memq symbol *features*))
          (setq *features* (cons symbol *features*)))))

; (dotimes (i 5000) (declare (fixnum i)) (add-feature 'junk))

#-ppc-target
(progn
(defvar %deftype-expanders% (make-hash-table :test #'eq))

(defun %deftype (name fn doc)
  (cond ((null fn)
         (remhash name %deftype-expanders%))
        ((or (built-in-type-p name) (find-class name nil))
         (error "Cannot redefine type ~S" name))
        (t (setf (gethash name %deftype-expanders%) fn)
           (record-source-file name 'type)))
  (setf (documentation name 'type) doc)   ; nil clears it.
  name)

;(defun %deftype-expander (name)
;  (or (gethash name %deftype-expanders%)
;      (and *compiling-file* (%cdr (assq name *compile-time-deftype-expanders*)))))
(defun %deftype-expander (name)
  (gethash name %deftype-expanders%))

(defun process-deftype-arglist (arglist &aux (in-optional? nil))
  "Returns a NEW list similar to arglist except
    inserts * as the default default for &optional args."
  (mapcar #'(lambda (item)
              (cond ((eq item '&optional) (setq in-optional? t) item)
                    ((memq item lambda-list-keywords) (setq in-optional? nil) item)
                    ((and in-optional? (symbolp item)) (list item ''*))
                    (t item)))
          arglist))

(defmacro deftype (name arglist &body body &environment env)
  "Syntax like DEFMACRO, but defines a new type."
  (setq name (require-type name 'symbol))
   (multiple-value-bind (arglist whole)
                       (normalize-lambda-list arglist t nil)
    (setq arglist (process-deftype-arglist arglist)
          whole (or whole (gensym)))
    (multiple-value-bind (body local-decls doc) (parse-body body env t)
      `(eval-when (compile load eval)
         (%deftype ',name
                   (nfunction ,name 
                              (lambda (,whole)
                                ,@(hoist-special-decls whole local-decls)
                                (declare (ignore-if-unused ,whole))
                                (macro-bind ,arglist ,whole
                                  ,@local-decls
                                  (block ,name ,@body))))                             
                   ,doc)))))

(defun type-expand (form &aux def)
  (while (setq def (cond ((symbolp form)
                          (gethash form %deftype-expanders%))
                         ((and (consp form) (symbolp (%car form)))
                          (gethash (%car form) %deftype-expanders%))
                         (t nil)))
    (setq form (funcall def (if (consp form) form (list form)))))
  form)

; Actually, BOOLEAN is ANSI CL now.
(deftype boolean () '(member t nil))
)

(defvar *function-specs* ())

(defun function-spec-p (spec)
  (or (symbolp spec)
      (and (consp spec)
           (symbolp (setq spec (%car spec)))
           (neq spec 'lambda)
           (getf *function-specs* spec))))

(defun function-spec-handler (spec)
  (or (function-spec-p spec)
      (signal-type-error spec '(or symbol '(setf symbol)) "~s isn't a valid function name.")))

(defmacro def-function-spec-handler (keyword arglist &body body)
  `(setf (getf *function-specs* ',keyword)
         (nfunction ,keyword (lambda ,arglist ,@body))))

;(def-function-spec-handler :property (spec &optional (def nil def-p))
;  (debind (keyword sym property) spec
;    (declare (ignore keyword))
;    (if def-p
;      (put sym property def)
;      (get sym property))))

;This is often handled directly in critical sections, so it's not enough
;to just change this definition...
(def-function-spec-handler setf (spec &optional (def nil def-p))
  (debind (keyword sym) spec
    (declare (ignore keyword))
    (if def-p
      (fset spec def)
      (fboundp (setf-function-name sym)))))

; ed is a CL fn so it must get loaded before tools, but it
; should be able to take advantage of tools if tools are loaded. - what tools?

(defun ed (&optional namestring &aux window)
  (cond ((or (stringp namestring) 
             (pathnamep namestring))
         (if (setq window (pathname-to-window namestring))
           (progn (window-select window) window)
           (fred namestring t)))
        ((not namestring)
         (fred namestring))
        ((or (symbolp namestring) (consp namestring))
         (edit-definition namestring 'function))
        (t (report-bad-arg namestring '(or string pathname symbol list)))))


#|
; this is bogus
(defun ed (&optional namestring)
  (cond ((or (stringp namestring) (pathnamep namestring) (not namestring))
         (fred namestring))
        ((or (symbolp namestring) (consp namestring))
         (edit-definition namestring 'function))
        (t (report-bad-arg namestring))))
|#

; Misc string functions


(defun string-left-trim (char-bag string &aux end)
  "Given a set of characters (a list or string) and a string, returns
  a copy of the string with the characters in the set removed from the
  left end."
  (setq string (string string))
  (setq end (length string))
  (do ((index 0 (%i+ index 1)))
      ((or (eq index end) (not (find (aref string index) char-bag)))
       (subseq string index end))))

(defun string-right-trim (char-bag string &aux end)
  "Given a set of characters (a list or string) and a string, returns
  a copy of the string with the characters in the set removed from the
  right end."
  (setq string (string string))
  (setq end (length string))
  (do ((index (%i- end 1) (%i- index 1)))
      ((or (%i< index 0) (not (find (aref string index) char-bag)))
       (subseq string 0 (%i+ index 1)))))

(defun string-trim (char-bag string &aux end)
  "Given a set of characters (a list or string) and a string, returns a
  copy of the string with the characters in the set removed from both
  ends."
  (setq string (string string))
  (setq end (length string))
  (let ((left-end) (right-end))
     (do ((index 0 (%i+ index 1)))
	 ((or (eq index end) (not (find (aref string index) char-bag)))
	  (setq left-end index)))
     (do ((index (%i- end 1) (%i- index 1)))
	 ((or (%i< index left-end) (not (find (aref string index) char-bag)))
	  (setq right-end index)))
      (subseq string left-end (%i+ right-end 1))))



(defun copy-symbol (symbol &optional (copy-props nil) &aux new-symbol def)
  "Make and return a new uninterned symbol with the same print name
  as SYMBOL.  If COPY-PROPS is null, the new symbol has no properties.
  Else, it has a copy of SYMBOL's property list."
  (setq new-symbol (make-symbol (symbol-name symbol)))
  (when copy-props
      (when (boundp symbol)
            (set new-symbol (symbol-value symbol)))
      (when (setq def (fboundp symbol))
            ;Shouldn't err out on macros/special forms.
            (%fhave new-symbol def))
      (set-symbol-plist new-symbol (copy-list (symbol-plist symbol))))
  new-symbol)


(defvar %gentemp-counter 0
  "Counter for generating unique GENTEMP symbols.")

(defun gentemp (&optional (prefix "T") (package *package*))
  "Creates a new symbol interned in package Package with the given Prefix."
  (loop
    (let* ((new-pname (%str-cat (ensure-simple-string prefix) 
                                (%integer-to-string %gentemp-counter)))
           (sym (find-symbol new-pname package)))
      (if sym
        (setq %gentemp-counter (%i+ %gentemp-counter 1))
        (return (values (intern new-pname package))))))) ; 1 value.

#-ppc-target
(defun purge-functions (&optional (purge-em t purge-em-p))
  (when purge-em-p
    (%put-word (%currenta5) (if purge-em 0 -1) $purgefuns))
  (if (%izerop (%get-word (%currenta5) $purgefuns)) t))

#+ppc-target
(defun purge-functions (&optional purge-em)
  (declare (ignore purge-em))
  nil)

(export '(purge-functions))


(defun add-gc-hook (hook-function &optional (which-hook :pre-gc))
  (ecase which-hook
    (:pre-gc
     (pushnew hook-function *pre-gc-hook-list*)
     (setq *pre-gc-hook* #'(lambda ()
                             (dolist (hook *pre-gc-hook-list*)
                               (funcall hook)))))
    (:post-gc
     (pushnew hook-function *post-gc-hook-list*)
     (setq *post-gc-hook* #'(lambda ()
                             (dolist (hook *post-gc-hook-list*)
                               (funcall hook))))))
  hook-function)

(defun remove-gc-hook (hook-function &optional (which-hook :pre-gc))
  (ecase which-hook
    (:pre-gc
     (unless (setq *pre-gc-hook-list* (delq hook-function *pre-gc-hook-list*))
       (setq *pre-gc-hook* nil)))
    (:post-gc
     (unless (setq *post-gc-hook-list* (delq hook-function *post-gc-hook-list*))
       (setq *post-gc-hook* nil)))))

(defun post-egc-hook-enabled-p ()
  (declare (fixnum *gc-event-status-bits*))
  (logbitp $gc-post-egc-hook-bit *gc-event-status-bits*))

(defun set-post-egc-hook-enabled-p (value)
  (declare (fixnum *gc-event-status-bits*))
  (setq *gc-event-status-bits* 
        (if (setq value (not (null value)))
          (the fixnum (bitset $gc-post-egc-hook-bit *gc-event-status-bits*))
          (the fixnum (bitclr $gc-post-egc-hook-bit *gc-event-status-bits*))))
  value)


;; Functions from now-optional modules (wrt MCL-Alice)

(defun pathname-to-window (pathname &aux wpath)
  (setq pathname (or (probe-file pathname)
                     (probe-file (merge-pathnames pathname *.lisp-pathname*))
                     ;Default type to :unspecific, since that's what
                     ;a window-filename would have.
                     (let ((fpath (full-pathname pathname)))
                       (if (null fpath)
                         (file-namestring pathname) 
                         (merge-pathnames fpath #1P"")))))
  (dolist (w1 (windows :include-invisibles t))
    (if (and (setq wpath (window-filename w1))
             (or (equalp pathname wpath)
                 (equalp pathname (full-pathname wpath))
                 (equalp pathname (probe-file wpath))))
      (return w1))))

(defun find-method-by-names (name qualifiers specializers)
  (let ((gf (fboundp name)))
    (when gf
      (if (not (standard-generic-function-p gf))
        (error "~S is not a generic-function." gf)
        (let ((methods (%gf-methods gf)))
          (when methods
            (let* ((spec-len (length (%method-specializers (car methods))))
                   (new-specs (make-list spec-len :initial-element (find-class t))))
              (declare (dynamic-extent new-specs))
              (do ((specs specializers (cdr specs))
                   (nspecs new-specs (cdr nspecs)))
                  ((or (null specs) (null nspecs)))
                (let ((s (car specs)))
                  (rplaca nspecs (canonicalize-specializer s))))
              (find-method gf qualifiers new-specs nil))))))))


;; Fred functions from optional modules

;; ed-current-symbol gets the symbol and package surrounding the cursor.
;; it doesn't do any READing, so nothing gets prematurely interned
;; used by arglist/minibuffer stuff only
(defun ed-current-symbol (w &optional aux-find-symbol start end)
  "returns current symbol, t, and preceding character, or nil, nil and nil.
   Avoids interning the symbol.  Uses hairy sequence functions."
  (if start
    (unless end (setq end start))
    (multiple-value-setq (start end) (selection-range w)))
  (buffer-current-symbol
   (fred-buffer w) start end aux-find-symbol (or (window-package w) *package*)))

; used by buffer-first-in-package in l1-edcmd and above
(defun buffer-current-symbol (buffer &optional (start (buffer-position buffer))
                                               (end start)
                                               aux-find-symbol
                                               (package *package*))
    (let* (whole-string
           pre-char
           (*buffer-fold-bounds* t))
      (declare (special *buffer-fold-bounds*))
      (when (eq start end)
        (setq end (1- (or (buffer-forward-find-char
                           buffer atom-specials-with-quote start)
                          (1+ (buffer-size buffer))))
              start (1+ (or (buffer-backward-find-char
                             buffer atom-specials-with-quote start 0)
                            -1))))
      (let ((string (buffer-substring buffer end start))
            (preserve-case-p (eq (readtable-case *readtable*) :preserve)))
        (setq whole-string
              (if preserve-case-p
                string
                (nstring-upcase string)))
        (when (neq start 0)
          (setq pre-char (buffer-char buffer (1- start))))
        (let* ((colon-pos (position #\: whole-string))
               (double-colon (when (and colon-pos (< colon-pos (- end start 2))
                                        (eq (char-code #\:)(%scharcode whole-string (1+ colon-pos))))                           
                               t))
               (str-package (when colon-pos 
                              (if (eq colon-pos 0) ""
                                  (subseq whole-string 0  colon-pos))))
               (symbol-string (if colon-pos 
                                (subseq whole-string (if double-colon (+ colon-pos 2)(1+ colon-pos)))
                                whole-string)))
          (when str-package
            (when (not (setq str-package (find-package str-package)))
              (unless (and preserve-case-p (setq str-package (find-package (nstring-upcase str-package))))
                (return-from buffer-current-symbol (values nil nil pre-char)))))
          (let (sym foundp)
            (flet ((find-it (symbol-string)
                     (cond ((and aux-find-symbol
                                 (setq sym (funcall aux-find-symbol symbol-string  (or str-package package))))  ; s.b. whole string?
                            (values sym t pre-char))
                           (t
                            (multiple-value-setq (sym foundp)
                              (find-symbol symbol-string (or str-package package)))
                            (if foundp
                              (cond (str-package
                                     (cond ((or double-colon (eq foundp :external))
                                            (values sym t pre-char))
                                           (t (values nil nil pre-char))))
                                    (t (values sym t pre-char)))                    
                              (values nil nil pre-char))))))
              (declare (dynamic-extent #'find-it))
              (if preserve-case-p
                (multiple-value-bind (sym external pre-char) (find-it symbol-string)
                  (if sym
                    (values sym external pre-char)
                    (find-it (nstring-upcase symbol-string))))
                (find-it symbol-string))))))))

;;; moved here from windoids.lisp - but left in windoids.lisp as well

#|
#+ppc-target
(eval-when (:compile-toplevel :execute)
(let ((*warn-if-redefine* nil))
(define-entry-point "MakeDataExecutable" ((address :ptr) (bytes :unsigned-long))
         nil)
))
|#


(defun lfun-to-ptr (lfun)
  (unless (functionp lfun)
    (setq lfun (require-type lfun 'function)))
  (let* ((code-vector (uvref lfun 0))
         (words (uvsize code-vector))
         (bytes (* 4 words))
         (ptr (#_NewPtr :errchk bytes)))
    (%copy-ivector-to-ptr code-vector 0 ptr 0 bytes)
    (#_MakeDataExecutable ptr bytes)
    ptr))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; stuff about sleep and wakeup

(defvar *sleep-wakeup-functions* nil)


#|
#+ppc-target
(ppc::define-storage-layout sleep-toc 0
  nilreg                                ; NIL
  call-universal-proc                   ; Address of call-universal-proc transition vector - unused
  sleep-defpascal                        ; unused
)

;;  wakeup sets a bit for event system to check
;; sleeprequest returns 0 to accept

#+(and ppc-target) ;; (not carbon-compat))
(defppclapfunction sleep-proc-1 ()
  (let ((what 3)
        (tmp 7)
        (tmp2 8)
        (nilreg 9))
    ; by some sort of magic the contents of d0 end up in r3 and are returned to d0 from there
    (cmpwi what #$sleeprequest)
    (bne @more)
    (li 3 0)
    (blr)
    @more
    (cmpwi what #$sleepwakeup)
    (bnelr)
    (stw nilreg -40 sp)  ; this saving/restoring crap may be unnecessary - who knows - windoid thing doesn't
    (stw tmp -36 sp)
    (stw tmp2 -32 sp)
    (lwz nilreg sleep-toc.nilreg rnil)   ; rnil is the TOC, 0'th loc is our nil
    (la tmp (ppc::nrs-offset *gc-event-status-bits*) nilreg)
    (lwi tmp2 #.(ash 1 (+ $gc-sleep-wakeup-bit ppc::fixnum-shift)))
    (lwz 3 ppc::symbol.vcell tmp)
    (or 3 3 tmp2)
    (stw 3 ppc::symbol.vcell tmp)
    (lwz nilreg -40 sp)
    (lwz tmp -36 sp)
    (lwz tmp2 -32 sp)
    (blr)))


(defvar *sleep-wrapper* nil)



;;#-carbon-compat
(defun make-sleep-qrec ()
  (make-record sleepqrec :sleepqlink (%null-ptr) :sleepqtype #$sleepqtype
               :sleepqproc (make-sleep-ptr)
               :sleepqflags 0))



(defun sleep-q-install (sleepqrec)
  (declare (ignore-if-unused sleepqrec))
  ;;#-carbon-compat
  (when (and *can-powermanager-dispatch* #+carbon-compat (osx-p))
    (#_SleepQInstall sleepqrec)))

(defvar *sleep-q-rec*)


;; do this on quit
(defun sleep-q-remove (sleepqrec)
  (declare (ignore-if-unused sleepqrec))
  ;;#-carbon-compat
  (when (and *can-powermanager-dispatch* (osx-p))
    (#_sleepqremove sleepqrec)))

(def-ccl-pointers sleep-ptr ()
  (when (bbox-p) (setq *cpu-idle-p* nil))  ;; cpu-idle-p is fukt on 9.1
  ;;#-carbon-compat
  (when #+carbon-compat nil #-carbon-compat t
    (setq *sleep-wrapper* (lfun-to-ptr #'sleep-proc-1))
    (sleep-q-install (setq *sleep-q-rec* (make-sleep-qrec)))))

(defun sleep-q-lose () (sleep-q-remove *sleep-q-rec*))

;;#-carbon-compat
(when #+carbon-compat nil #-carbon-compat t
      (pushnew #'sleep-q-lose  *lisp-cleanup-functions* :key #'function-name :test #'eq))
|#



#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
