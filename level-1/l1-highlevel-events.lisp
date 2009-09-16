;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  3 10/22/97 akh  resume-application-event-handler
;;  2 3/14/97  akh  launch app etal from bill
;;  13 9/19/96 slh  removed comment
;;  9 3/27/96  akh  changes for finder-parameters
;;  7 11/15/95 gb   comment out callback initialization
;;  4 2/2/95   akh  merge with leibniz patches
;;  3 1/31/95  akh  bill's fix to %free-aedesc
;;  2 1/17/95  akh  appleevent-idle uses without-event-processing
;;  (do not edit before this line!!)

;; highlevel-events.lisp - Do System 7 HighLevel Events

; Copyright 1990-1994 Apple Computer, Inc.
; Copyright 1995-2001 Digitool, Inc.

; Modification History
;; open-application-document handles type :|utxt|
;; %path-from-fsspec - simpler - result may still be wrong cause fsspecs are deficient.
;; ----- 5.2b6
;; quit-handler-proc - don't cons a bignum, %equal-ostype work for integer too
;; do-quit-dialog - position :main-screen 
;; ------ 5.2b5
;; dmnotify-proc may do stuff before sleep as well
; dmnotify-proc does *sleep-wakeup-functions*
;; --- 5.2b1
; use add-pascal-upp-alist-cfm - now try macho
; define some constants missing from new interfaces - OK now
; do-quit-dialog uses standard-alert-dialog if osx
; add %path-to-fsspec - used by some drag-and-drop stuff
;; ----- 5.1 final
; cmd-q "no" is cancel-text vs no-text
; don't heed the preferences command key either if apple/application menu is disabled
; don't heed cmd-q if apple/application menu is disabled - from Takehiko Abe
; quit-handler-proc handles preferences menu item too
;; ------- 5.1b2
; 03/05/04 open-application-document opens files with no mac-file-type (if not .cfsl) in fred - buyer beware 
; ------ 5.1b1
; 01/22/04 -define ff-long-to-ostype here too for booting
; appleevent "cnfg" no work on osx - see DMRegisterExtendedNotifyProc
; print and open-documents-handler use fsref
;; do quit with carbon event so detection of command key is reliable on OSX - from patches 5.0
; new %path-from-fsspec
;; -------- 5.0 final
; mess with open-application-document for OSX/Unix idiocy.
; change quit-application-handler if osx-p
; with-aedescs more P.C.
;; -------- 4.4b5
; add my-fsref-from-path also not used yet - this stuff probably belongs elsewhere
; add some more stuff for %path-from-fsref fixing non-low-ascii chars (its UTF-8!!) but still don't use it
; add noop appleevent handler for :|appr| :|thme|
; lose usage of %path-from-fsref
; add want-dir arg to %path-from-fsref
; fix %path-from-fsref if boot volume
;; 4.4b4
; 05/20/02 akh print-documents-handler uses carbonated print-style-dialog if carbon
; ------ 4.4b3
; 04/30/01 akh see %path-from-fsspec for osx
; 01/30/01 akh do aeinstalleventhandler for quit (crock in some versions of CarbonLib).
; 01/23/01 install-appleevent-handler :|pmgt| :|emsl|
;------------------ 4.4b1
; akh noop appleevent handlers for some appearance things
; akh carbon stuff
; ----------------- 4.3.1b1
; akh add noop appleevent handler for pmgt pmsd aka battery-going-dead.
; 01/24/00 akh remove appleevent-not-handled-error - bad idea
; 01/23/99 akh add noop appleevent handler for pmgt wake.
; 08/30/99 akh do-appleevent - move the quit business outside (when deferred-p ...)
;----------- 4.3f1c1
; 06/17/99 akh add appleevent handlers for changing screen resolution, and window-collapse.. (NOP) from T.A.
; 06/02/99 akh fix appleevent-not-handled-error from Toomas Altosaar
;; ---------- 4.3b2
; 02/22/98 AKH defmethod appleevent-not-handled-error ((application application) behavior depends on
;		the value of *signal-appleevent-not-handled-error*.
;                document this for users who might be debugging some appleevent stuff
; 10/22/97 akh   resume-application-handler from david lamkins
; 11/26/96 bill  do-appleevent-handler handles wildcard handler for both class and id
; -------------  4.0
;  9/04/96 slh   print-documents-handler: _SetCursor -> with-cursor
; 08/20/96 bill  do-appleevent sets *startup-aevents* to nil.
; -------------  4.0b1
; 05/06/96 bill  slh's fix to (method open-application-document (lisp-development-system t)).
;                Make it look for mac-file-type of :pfsl, not :fasl, on ppc-target
; 05/03/96 bill  %free-aedesc does (set-macptr-flags aedesc $flags_Normal) before calling #_AEDisposeDesc
; -------------  MCL-PPC 3.9
; 11/14/95 bill  AppleEvents are back for the PPC
; 11/10/95 bill  Temporarily disable for the PPC the call to #_AEProcessAppleEvent
;                in do-highlevel-event. Reenable it when callbacks work.
; 11/1/95  gb    %equal-ostype: %get-unsigned-byte-> %get-unsigned-word.
; 10/26/95 slh   de-lap: %equal-ostype
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
; 3/11/95 slh   use gestalt bitnum arg
;-------------- 3.0d17
; 06/16/93 alice ae-get-parameter-char uses %str-from-ptr-in-script, %path-from-fsspec
;		 uses %std-name-and-type so quotes the same as %path-from-iopb
; 05/19/93 bill Ed Lai's suggestion to make #_AEResumeTheCurrentEvent work with AppleScript.
; ------------- 2.1d6
; 04/24/93 bill don't eval-enqueue the call to ED in open-application-document
; 03/22/93 bill cheap-cons in install-queued-reply-handler, free-cons in queued-reply-handler
; 03/01/93 bill eliminate memory leak in ae-put-parameter-char
; 02/26/93 bill Howard Oakley's fix to do-appleevent (explicit _AeSend)
;               Also, a resource for AEDesc records so we don't cons macptrs.
; 12/17/92 bill cheap-cons and friends -> l1-streams
; 11/20/92 gb   *application* is a lisp-development-system.
; 08/24/92 bill  *signal-appleevent-errors*
;--------------  2.0
; 01/07/92 gb    don't require RECORDS.
;12/10/91 alice %err-disp => signal-file-error
;--------------- 2.0b4
; 11/19/91 bill  appleevent-idle calls %run-masked-periodic-tasks & process-event.
;                It also sets up the environment correctly so that event-dispatch won't do anything
;                defer-appleevent-handler processes the AppleEvent immediately if *inside-aesend* is true.
; 10/29/91 alice def-load-pointers => def-ccl-pointers
; 10/08/91 bill  Consing for every AppleEvent was evil.
;                self-addressed AppleEvents are not deferred so that they don't time out.
; 09/27/91 alice %path-from-fsspec needs to quote *'s etc.
;----------------- 2.0b3
;  08/30/91 bill in queued-reply-handler - (setf (gethash ...) nil) -> (remhash ...)
;  08/19/91 bill Don't repeat (quit) if aborted out
;  07/21/91 gb   move quit-event handling to where it works.  Use PREF, just to say
;                we did.
;  06/25/91 joe  deferred appleevent handling, queued reply handlers, add ae-get and
;                ae-put stuff. Add refcons to handlers (can be any lisp object)
;  06/04/91 joe  Get rid of *load-next-open-doc* since the kernel handles this stuff
;                revive open-application-handler since we should still probably accept
;                this event.
;  05/20/91 gb   No more select-process.  Kernel handles initial oapp, odoc, pdoc
;                for us.
;  5/20/91  joe  add unwind-protect in standard-ae-handler to prevent anyone from throwing
;                beyond the callback (naughty, naughty). Add *application* object & instance
;                & re-do the handlers to reflect.
;  5/8/91   joe  add deinstall-applevent-handler. initialize error-string = nil in appleevent-error
;  04/08/91 joe  CLOS handlers. Perform real event checking in interact-idle
;                function. appleevent-error condition. change to expect keyword ostypes. 
;  03/13/91 bill select-process in open-documents-handler
;------------ 2.0b1
;  03/05/91 bill ignore AppleEvent errors in do-event.  Assume that user
;                handlers do all that is necessary.
;  02/06/91 bill The system 7 folks changed FsSpec to a handle.
;  01/09/91 gb   open-documents-handler doesn't try to open the help file, etc.
;  12/31/90 gb   RESIDENT decl or two.
;  12/26/90 joe  removed (require-interface "EVENTS")
;  12/13/90 bill in open-application-handler: use *startup-init-file* vice home;init
;  11/17/90 joe new


#|
This is my understanding of the four basic AppleEvents:
When a user double clicks on an application, the Finder launches and
sends the OApp event. When a user double clicks on a document, and the
app hasn't been open, the Finder launches & sends an Odoc, but _not_ an
Oapp (weird huh?). The same is true of printing, i.e. you only get an Pdoc,
but that makes more sense I guess. The quit seems to happen only if the user
does a restart or shut-down from the finder. It appears that the launching
appleevents are available the second time event-dispatch is called.

Note that the documentation in IM VI is pretty bogus. The "tutorial" in the
beginning is not consistent with the more "reference" like material in the
second half. For example, you're supposed to call AEInteractWithUser before
throwing up any dialog boxes, but the "tutorial" ignores this. The beta1
CD says that one should look at the AEVTTESample, which seems to be mostly
there, except for some more bogus things like walking the event queue (i.e.
non-AU/X compatiblity). There are a lot of things which aren't really
explained, such as what the finder does under different circumstances, and
how the app is supposed to react.

OK. Here's how I did it:
The goal is an Apple Politically Correct implementation of AEvents, while
maintaining 6.0/7.0 compatibility and identical behavior between 1.3 & 2.0.
Whew!

Booting lisp is a weird thing. In our distributed lisp, startup-ccl is called
as part of the toplevel function (which also sets the toplevel-function
to #'toplevel-loop. Before this happens, restore-lisp-pointers is called, and
the sysenvirons restorer sets the :appleevents flag. If applevents are present,
startup-ccl doesn't do anything, because we can't tell what were supposed to do
yet. OApp assumes that the user double clicked on the app itself, so it tries to
loadinit.lisp (or fasl). Odoc checks to see if it's the very first AppleEvent
since launch time. It accomplishes this via the global *load-next-open-doc*
which is set to t by a def-load-pointers and nil by OApp. Thus if
*load-next-open-doc* is t when an Odoc event is handled, it means that the
user launched by double clicking on a document, and the document is loaded
instead of edited. Fasls are always loaded. One funny difference between 7.0
and 6.0 is that opening a doc from the finder when the app is already open
does not cause a major context switch. I guess that's the way its' supposed to
be.

Unresolved questions:
1. What's the right way to respond to errors. For example, what if the finder
asks to quit, windows need to be saved, but the interaction mode is set so
that no user interaction is allowed? (seems like no-interaction = ignore
the event). Do we print an error message in this case? What about if the user
cancels a print operation. Is that an error? What code should the handler return?

2. Why aren't we getting an activate event when we print from the finder?

3. What are the guarantees from the finder in terms of what events will come,
when, etc. Can you depend on the launching appleevents to be present the first
(seems to be second) time you look for them?

|#

(eval-when (:compile-toplevel :load-toplevel :execute)
  ;(defconstant traps::$typeLongInteger :|long|) ;; screwed up in new interfaces - fixed now
  ;(defconstant traps::$typeSint32  :|long|)
  ;(defconstant traps::$typeShortInteger :|shor|)  
  ;(defconstant traps::$typeSint16  :|shor|)  
  (DEFCONSTANT traps::$TRUE -1)  ;; missing in new interfaces - these should get lost
  (DEFCONSTANT traps::$FALSE 0)
)
(defvar *appleevent-quit* nil)          ; Mechanism for quitting via an appleevent
(defvar *highlevel-eventhook* nil)      ; allow users to put their own highlevel
                                        ; event handlers.

; compare a keyword to 4 bytes inside a pointer:
(defun %equal-ostype (pointer keyword &optional (offset 0))
  (if (integerp keyword)  ;; unlikely
    (and (eq (logand keyword #xffff) (%get-unsigned-word pointer (%i+ offset 2)))
         (eq (logand (ash keyword -16) #xffff) (%get-unsigned-word pointer offset)))
    (%equal-ostype-halfwords (symbol-name keyword) 
                             (%get-unsigned-word pointer offset)
                             (%get-unsigned-word pointer (%i+ offset 2)))))

(defun ff-long-to-ostype (long)
  (rlet ((ptr :ostype long))
    (%get-ostype ptr)))

; return T if the first two bytes of simple-base-string "STR" 
; match "high16" and the next two bytes match "low16".


(defppclapfunction %equal-ostype-halfwords ((string arg_x) (high arg_y) (low arg_z))
  (let ((stringbytes imm0)
        (highlow imm1))
    (compose-digit highlow high low)
    (lwz stringbytes ppc::misc-data-offset string)
    (subf imm0 stringbytes highlow)
    (cntlzw imm0 imm0)                  ; see if there are 32 "leading zeros" in the difference
    (srwi imm0 imm0 5)                  ; 1 if so, 0 otherwise
    (insrwi imm0 imm0 1 27)             ; ppc::t-offset = #x11
    (add arg_z rnil imm0)
    (blr)))

; appleevent-error condition
;
(define-condition appleevent-error (error)
  ((oserr :initarg :oserr :reader oserr)
   (error-string :initform nil :initarg :error-string :reader error-string))
  (:report
   (lambda (c s)
     (format s "~a (~d)~@[ - ~a~]" (%rsc-string (oserr c)) (oserr c) (error-string c)))))


; Define some useful functions & macros
;
(defmacro ae-error-str (error-string &body forms)
  (let ((errsym (gensym)))
    `(let ((,errsym (progn ,@forms)))
       (unless (eq ,errsym #.#$noErr)
         (error (make-condition 'appleevent-error :oserr ,errsym 
                                :error-string ,error-string))))))

; same as above, but no error string
(defmacro ae-error (&body forms)
  (let ((errsym (gensym)))
    `(let ((,errsym (progn ,@forms)))
       (unless (eq ,errsym #.#$noErr)
         (error (make-condition 'appleevent-error :oserr ,errsym))))))


; with-aedescs is like rlet except that it will call #_aedisposedesc on it if the
; datahandle is not a %null-ptr. Thus, you can use with-aedescs & not worry (so much)
; about cleaning up.
;

(defmacro with-aedescs (vars &body body)
  `(rlet ,(mapcar #'(lambda (var) `(,var :aedesc)) vars)
     (unwind-protect
       (progn ,@(mapcar #'(lambda (var) `(require-trap #_aeinitializedesc ,var)) vars) 
              ,@body)
       ,@(mapcar #'(lambda (var) `(require-trap #_aedisposedesc ,var)) vars))))


(defun check-required-params (error-string theAppleEvent)
  (rlet ((missed-keyword :ostype)
         (actual-type :ostype)
         (actual-size :signed-long))
    (let ((myerr (#_AEGetAttributePtr theAppleEvent #$keyMissedKeywordAttr
                  #$typeWildCard actual-type missed-keyword 4 actual-size)))
      (when (eq myerr $noErr)           ; missed a parameter!
        (error (make-condition 'appleevent-error :oserr #$errAEParamMissed 
                               :error-string error-string))))))


; getting and putting lisp objects into/outof appleevents

(defmacro ae-errorp-handler (errorp &body body)
  (let ((condition (gensym)))
    `(handler-case
       (progn ,@body)
       (appleevent-error (,condition)
                         (if ,errorp (error ,condition) nil)))))

(defun ae-get-attribute-longinteger (the-desc keyword &optional (errorp t))
  (rlet ((buffer :signed-long)
         (typecode :desctype)
         (actualsize :size))
    (ae-errorp-handler
     errorp
     (ae-error (#_aegetattributeptr the-desc keyword
                #$typeLongInteger typecode buffer
                (record-length :unsigned-long) actualsize))
     (%get-signed-long buffer))))

(defun ae-get-attribute-type (the-desc keyword &optional (errorp t))
  (rlet ((buffer :ostype)
         (typecode :desctype)
         (actualsize :size))
    (ae-errorp-handler
     errorp
     (ae-error (#_aegetattributeptr the-desc keyword #$typeType typecode
                buffer (record-length :ostype) actualsize))
     (%get-ostype buffer))))

(defun ae-get-parameter-longinteger (the-desc keyword &optional (errorp t))
  (rlet ((buffer :signed-long)
         (typecode :desctype)
         (actualsize :size))
    (ae-errorp-handler
     errorp
     (ae-error (#_aegetparamptr the-desc keyword
                #$typeLongInteger typecode buffer 
                (record-length :signed-long) actualsize))
     (%get-signed-long buffer))))

(defun ae-get-parameter-type (the-desc keyword &optional (errorp t))
  (rlet ((buffer :ostype)
         (typecode :desctype)
         (actualsize :size))
    (ae-errorp-handler
     errorp
     (ae-error (#_aegetparamptr the-desc keyword #$typeType typecode
                buffer (record-length :ostype) actualsize))
     (%get-ostype buffer))))

#-carbon-compat
(defun ae-get-parameter-char (the-desc keyword &optional (errorp t))
  (with-aedescs (buffer-desc)
    (ae-errorp-handler
     errorp
     (ae-error (#_aegetparamdesc the-desc keyword #$typeChar buffer-desc))
     (let ((datahandle (rref buffer-desc aedesc.datahandle)))
       (with-dereferenced-handles ((ptr datahandle))
         (%str-from-ptr-in-script ptr (#_GetHandleSize datahandle)))))))

#+carbon-compat
(defun ae-get-parameter-char (the-desc keyword &optional (errorp t))
  (with-aedescs (buffer-desc)
    (ae-errorp-handler
     errorp
     (ae-error (#_aegetparamdesc the-desc keyword #$typeChar buffer-desc))
     ;; not sure about this
     (let* ((size (#_AEGetDescDataSize buffer-desc)))
       (%stack-block ((ptr size))
         (#_aegetdescdata buffer-desc ptr size)
         (%str-from-ptr-in-script ptr size))))))

; putting
(defun ae-put-attribute-longinteger (the-desc keyword thing &optional (errorp t))
  (rlet ((buffer :signed-long))
    (%put-long buffer thing)
    (ae-errorp-handler
      errorp
      (ae-error (#_AEPutAttributePtr the-desc keyword #$typeLongInteger buffer
                 (record-length :signed-long))))))

(defun ae-put-attribute-type (the-desc keyword thing &optional (errorp t))
  (rlet ((buffer :ostype))
    (%put-ostype buffer thing)
    (ae-errorp-handler
      errorp
      (ae-error (#_AEPutAttributePtr the-desc keyword #$typeType buffer
                 (record-length :ostype))))))

(defun ae-put-parameter-longinteger (the-desc keyword thing &optional (errorp t))
  (rlet ((buffer :signed-long))
    (%put-long buffer thing)
    (ae-errorp-handler
      errorp
      (ae-error (#_AEPutParamPtr the-desc keyword #$typeLongInteger buffer
                 (record-length :signed-long))))))

(defun ae-put-parameter-type (the-desc keyword thing &optional (errorp t))
  (rlet ((buffer :ostype))
    (%put-ostype buffer thing)
    (ae-errorp-handler
      errorp
      (ae-error (#_AEPutParamPtr the-desc keyword #$typeType buffer
                 (record-length :ostype))))))

(defun ae-put-parameter-char (the-desc keyword string &optional (errorp t))
  (with-cstrs ((cstr string))
    (ae-errorp-handler
      errorp
      (ae-error (#_AEPutParamPtr the-desc keyword #$typeChar
                 cstr (length string))))))

; Here's the entry to the appleevent receiving system:
;
(defun do-highlevel-event (event)
  (unless (and *highlevel-eventhook*
               (if (consp *highlevel-eventhook*)
                 (dolist (item *highlevel-eventhook*)
                   (when (funcall item) (return t)))
                 (funcall *highlevel-eventhook*)))
    (#_aeprocessappleevent event)       ; Any errors that occur are reported by standard-appleevent-handler
    (when *appleevent-quit*
      (setq *appleevent-quit* nil)
      (quit))))                         ; Process quit sent from MCL to MCL as an AppleEvent


; We bypass the AppleEvent Manager's dispatch routine & do our own dispatching
; within lisp.

(defvar %appleevent-handlers% (make-hash-table :test #'eq :size 4))

(defun install-appleevent-handler (class id function &optional (refcon nil))
  (let ((id-table (gethash class %appleevent-handlers%)))
    (unless id-table
      (setq id-table (make-hash-table :test #'eq :size 1))
      (setf (gethash class %appleevent-handlers%) id-table))
    (setf (gethash id id-table) (cons function refcon))))

(defun deinstall-appleevent-handler (class id)
  (let ((id-table (gethash class %appleevent-handlers%)))
    (when id-table
      (setf (gethash id id-table) nil))))


; We make an application CLOS object, and appleevent handlers are methods of
; the instance *application*.
; is in l1-initmenus today
;(defparameter *application* (make-instance 'lisp-development-system))

(defvar *deferred-appleevents* nil)
(defvar *inside-aesend* nil)

(defresource *AEDesc-resource*
  :constructor
  (with-macptrs ((p (make-record :AEDesc)))
    (%setf-macptr (make-gcable-macptr $flags_disposptr) p)))

(defvar *null-ptr*)

(def-ccl-pointers *AEDesc-resource* ()
  (setf *null-ptr* (%null-ptr)
        (pool.data (resource.pool *AEDesc-resource*)) nil))

(defun copy-aedesc (aedesc)
  (if (%null-ptr-p aedesc)
    *null-ptr*
    (let ((res (allocate-resource *AEDesc-resource*)))
      (#_BlockMove aedesc res (record-length :AEDesc))
      res)))

(defun %free-aedesc (aedesc &optional (dispose-p t))
  (unless (%null-ptr-p aedesc)
    (if dispose-p
      (progn
          (set-macptr-flags aedesc $flags_Normal)
          (#_AEDisposeDesc aedesc))
      (free-resource *aedesc-resource* aedesc))))

; defer-appleevent-handler handles all appleevents & simply suspends the event
; and appends the cons of the event, reply, and refcon to *deferred-appleevents*
; If the event is from MCL itself, it handles it right away.

;; this sucks
#+carbon-compat
;(add-pascal-upp-alist 'defer-appleevent-handler  #'(lambda (procptr)(#_NewAEEventHandlerUPP procptr)))

(add-pascal-upp-alist-macho 'defer-appleevent-handler  "NewAEEventHandlerUPP")



(defpascal defer-appleevent-handler (:pointer theAppleEvent :pointer reply
                                              :long handlerRefcon :word)
  (declare (ignore handlerRefcon))
  (rlet ((source :word)
         (actualType :long)
         (actualSize :long))
    (if (or *inside-aesend*
            (and (eql #$noErr (#_AEGetAttributePtr
                               theAppleEvent #$keyEventSourceAttr #$TypeShortInteger actualType source 2 actualSize))
                 (let ((source (%get-word source)))
                   (or (eql #$kAESameProcess source)
                       (eql #$kAEDirectCall source)))))
      (do-appleevent theAppleEvent reply nil)
      (progn
        (ae-error (#_AESuspendTheCurrentEvent theAppleEvent))
        (setq *deferred-appleevents* (nconc *deferred-appleevents*
                                            (cheap-cons
                                             (cheap-cons 
                                              (copy-aedesc theAppleEvent)
                                              (copy-aedesc reply))
                                             nil)))
        #$noErr))))

; do-deferred-appleevent gets called at the end of event-dispatch when events
; are turned back on.
(defvar *doing-deferred-appleevents* nil)       ; make things reentrant


#|
(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(*signal-appleevent-not-handled-error* appleevent-not-handled-error)
          :ccl))


;; no longer used  - bad idea - event needs to be replied to by the error handler
;; get desired effect by setting *signal-appleevent-errors* nil and *report-appleevent-errors* t
(defvar *signal-appleevent-not-handled-error* :warn)

(defmethod appleevent-not-handled-error ((application application) CLASS ID)
    (if *signal-appleevent-not-handled-error*
      (let ((condition (make-condition 'appleevent-error :oserr #$errAEEventNotHandled
                                       :error-string (format nil "No Lisp Handler for '~a' '~a'"
                                                             class id))))
        (if (eq *signal-appleevent-not-handled-error* :warn)
          (warn (error-string condition))
          (error condition)))    
      nil))
|#

;;; Whenever the display resolution is changed (e.g., via the Sounds & Monitors control panel) then
;;; catch the apple event and update *screen-size*, *screen-width* and *screen-height*
;;; as well as the single class-variable window-drag-rect
;;; 990317TA
;; from Toomas A.

(defmethod screen-display-update-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore theAppleEvent reply handlerRefcon) (resident))
  ;;; MCL errors sometimes when you change the initialization output window size while init.lisp is loading.
  ;;; Seems to be ok now. 990603TA
  ;;; also called on wake from sleep on OS9 -
  ;;; NOT sent on OSX
  ;(print 'zoe)
  (get-the-current-window-drag-rect nil)
  ; (format t "~%:|aevt| :|cnfg| handled by MCL. Screen dimensions are ~ax~a" *screen-width* *screen-height*)
  )

;;; The #$isDisplayManagerAware bit in the SIZE resource of the application must
;;; be set on (the bit after Text Edit Services)
;;; #$kAESystemConfigNotice is defined in ccl:interfaces;Displays.lisp => :|cnfg|
;;; 990317TA


(install-appleevent-handler :|aevt| :|cnfg| #'screen-display-update-handler)



(defun do-deferred-appleevents ()
  (unless *doing-deferred-appleevents*
    (let ((*doing-deferred-appleevents* t))
      (do ((event-info (pop-and-free *deferred-appleevents*) (pop-and-free *deferred-appleevents*)))
          ((null event-info))
        (let ((theAppleEvent (car (the list event-info)))
              (reply (cdr (the list event-info))))
          (free-cons event-info)
          ; Ed Lai suggested getting rid of this. Doing so made our code work with AppleScript installed.
;          (#_AESetTheCurrentEvent theAppleEvent)
          (do-appleevent theAppleEvent reply t))))))

(defvar *report-appleevent-errors* nil)
(defvar *signal-appleevent-errors* t)

(defun do-appleevent (theAppleEvent reply deferred-p)
  (let ((result #$noErr)
        (class nil)
        (id nil)
        (resumed? nil))
    (block buck-stops-here              ; don't throw past here unless (and deferred-p *signal-applevent-errors*)
      (labels ((resume-appleevent ()
                 (unless resumed?
                   (setq resumed? t)
                   ; try to put the result code in the reply (the reply may be null)
                   ; if the event is itself a reply!
                   (unless (eql result #$noErr)         ; otherwise Toy Surprise gets unhappy
                     (ae-put-parameter-longinteger reply #$keyErrorNumber result nil))
                   (when deferred-p
                     (#_AEResumeTheCurrentEvent theAppleEvent reply (%int-to-ptr #$kAENoDispatch) 0)
                     ; It seems that you can free theAppleEvent right away, but
                     ; need to wait until the client reads the reply before you can
                     ; dispose of it. The AppleEvent system is NOT disposing of the reply
                     ; or theAppleEvent as it is supposed to do.
                     ; Actually, even freeing theAppleEvent right away seems to cause
                     ; the heap to get scrambled so that (ROOM) will cause the next
                     ; send from Toy Surprise to crash.
                     ; Apparently, we need to wait until the server receives the
                     ; reply. Then we can dispose of the two AEDesc's
                     (%free-aedesc theAppleEvent nil)
                     (%free-aedesc reply nil))
                   (when *appleevent-quit*
                     (setq *appleevent-quit* nil)   ; don't repeat if aborted out
                     (quit))))
               (error-handler (c)
                 (ae-put-parameter-char reply #$keyErrorString
                                        (with-output-to-string (s)
                                          (report-condition c s))
                                        nil)
                 (if (typep c 'appleevent-error)
                   (setq result (oserr c))    ; return the error to the AppleEvent Manager
                   (setq result #$errAEEventNotHandled))
                 (resume-appleevent)
                 (unless (and deferred-p *signal-appleevent-errors*)
                   (when *report-appleevent-errors*
                     (format *error-output* "~%> Error while handling AppleEvent: '~a' '~a'~%> "
                             class id)
                     (report-condition c *error-output*))
                   (return-from buck-stops-here))))
        (declare (dynamic-extent #'resume-appleevent #'error-handler))
        (unwind-protect                     ; make sure we resume the AppleEvent if deferred-p
          (handler-bind ((error #'error-handler))
            (setq class (ae-get-attribute-type theAppleEvent #$keyEventClassAttr)
                  id (ae-get-attribute-type theAppleEvent #$keyEventIDAttr))
            (flet ((lookup (id id-table)
                     (and id-table
                          (or (gethash id id-table)
                              (gethash :|****| id-table)))))
              (let ((handler (or (lookup id (gethash class %appleevent-handlers%))
                                 (lookup id (gethash :|****| %appleevent-handlers%)))))
                ;; handler is queued-reply-handler for class :|aevt| id :|ansr|
                ;; it loses when we get this event - why do we get it from toolserver?
                ;; most of em  are (:MPS\  :|outp|)
                (if (not handler)
                  (error (make-condition 'appleevent-error :oserr #$errAEEventNotHandled
                                         :error-string (format nil "No Lisp Handler for '~a' '~a'"
                                                               class id)))                   
                  (funcall (car handler) *application* theAppleEvent reply (cdr handler))))))
          (setq *startup-aevents* nil)
          (resume-appleevent)
          (unless (and deferred-p *signal-appleevent-errors*)
            (return-from buck-stops-here)))))
    result))

; define our idle procedure for when we have to wait for something
;

;; this sucks
#+carbon-compat
;(add-pascal-upp-alist 'appleevent-idle #'(lambda (procptr)(#_NewAEIdleUPP procptr)))

(add-pascal-upp-alist-macho 'appleevent-idle "NewAEIdleUPP")

(defpascal appleevent-idle (:pointer event :pointer sleeptime :pointer mouseRgn
                                     :word)
  ; This is now implemented according to the latest spec (2/11/91).
  ;
  (declare (ignore mouseRgn))
  (without-interrupts
   (without-event-processing ;let-globally ((*processing-events* *current-process*))         ; Don't handle any events
     (let* ((*inhibit-abort* t)             ; only this code is allowed to look for aborts
            (*interrupt-level* *interrupt-level*))          ; I'm paranoid
       
       ; cruise down the event queue & see if there's a pending abort...
       (when (abort-event-pending-p)
         (setq *processing-events* nil)
         (return-from appleevent-idle #$true))   ; found an abort! run for the hills!
       
       ; Make sure user periodic tasks run.
       (%run-masked-periodic-tasks)
       
       ; We should set the value of sleeptime if it's a null event.
       ; Then we're supposed to handle the event "normally"
       (if (= #$nullevent (rref event eventRecord.What))
         (%put-long sleeptime (wait-next-event-sleep-ticks)))
       (process-event event)))
   #$false))


; Appleevent handlers...
; These are all methods of the class appliction & are called with four arguments:
; The application-object (bound to *application*), the appleevent, the reply and the
; refcon. If there are any problems, the handler should signal the appleevent-error
; condition (ae-error-str) which will do the appropriate thing automagically. 
; This is what happens in ae-error-str. Otherwise, just return & everything
; will be cool. Note that handlers are called at the end of event processing
; so that interrupts are enabled, so there are no worries.

; The refcon is any lisp object, not just a number. It's maintained entirely on 
; the Lisp side.
;

; implement queued reply handlers. These are handlers for when someone decided
; to receive the reply in the event queue. We keep a hashtable of return id's
; and methods to call on the application object.
;

(defvar %queued-reply-handlers% (make-hash-table :test #'eql))

(defun install-queued-reply-handler (appleevent-or-id function &optional (refcon nil))
  (when (macptrp appleevent-or-id)
    (setq appleevent-or-id
          (ae-get-attribute-longinteger appleevent-or-id #$keyReturnIDAttr)))
  (setf (gethash appleevent-or-id %queued-reply-handlers%)
        (cheap-cons function refcon)))

(defmethod queued-reply-handler ((a application) theAppleEvent reply handlerRefcon)
  (let* ((return-id (ae-get-attribute-longinteger theAppleEvent #$keyReturnIDAttr))
         (handler (gethash return-id %queued-reply-handlers%)))
    (if handler
      (progn
        (let ((f (car handler))
              (refcon (cdr handler)))
          (remhash return-id %queued-reply-handlers%)
          (free-cons handler)
          (funcall f *application* theAppleEvent reply refcon)))
      (no-queued-reply-handler a theAppleEvent reply handlerRefcon))))
    

(defmethod no-queued-reply-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore reply handlerRefcon))
  (let ((return-id (ae-get-attribute-longinteger theAppleEvent #$keyReturnIDAttr)))
    (error (make-condition 'appleevent-error :oserr #$errAEEventNotHandled
                           :error-string (format nil "No queued reply handler for id: ~d"
                                                 return-id)))))


; implement the four basic handlers
; here's a useful fsspec parsing tool:
; note that fssspecptr is a POINTER not a handle!
#+old
(defun %path-from-fsspec (fsspecptr &aux dir)
  (multiple-value-bind  (name type)(%std-name-and-type (pref fsspecptr fsspec.name))
    (rlet ((f2 :fsspec))
      (do ((result (#_fsmakefsspec (pref fsspecptr fsspec.vrefnum)
                    (pref fsspecptr fsspec.parid)
                    (%null-ptr)
                    f2)
                   (#_fsmakefsspec (pref f2 fsspec.vrefnum)
                    (pref f2 fsspec.parid)
                    (%null-ptr)
                    f2)))
          ((not (%izerop result))
           (unless  (or (eql result #$dirNFErr)(eql result #$nsverr)) ;; osx crap
             (signal-file-error result name)))
        (setq dir (cons (%path-std-quotes (pref f2 fsspec.name) nil ";*") dir))))
    (%cons-pathname (cons ':absolute dir) name type)))


;; will get parent rignt - rest wrong - perhaps just error instead?
(defun %path-from-fsspec-extra (my-fsspec)
  (multiple-value-bind  (name type)(%std-name-and-type (pref my-fsspec fsspec.name))
    (rlet ((fsspec-copy :fsspec)
           (parent-fsref :fsref))
      (copy-record my-fsspec :fsspec fsspec-copy)
      (setf (pref fsspec-copy fsspec.name) "")
      (errchk (#_FSpMakeFSRef fsspec-copy parent-fsref))
      (let ((parent-path (%path-from-fsref parent-fsref t)))
        (make-pathname :directory (pathname-directory parent-path) 
                       :name name :type type)))))


;; simpler - and more likely to dtrt if directory
(defun %path-from-fsspec (my-fsspec)  
  (rlet ((my-fsref :fsref))
    (let ((err (#_FSpMakeFSRef my-fsspec my-fsref)))
      (if (eq err #$noerr)  ;; errors if not found, possibly because name part is nonsense
        (%path-from-fsref my-fsref)
        (%path-from-fsspec-extra my-fsspec)))))

;; only use if absolutely needed - file namestring cannot be long & must be 7bit-ascii
;; path must exist
;; called from ccl:examples;drag-and-drop - probably should not be
(defun %path-to-fsspec (path fsspec &optional (resolution-policy :none))
  (rlet ((fsref :fsref)
         (catinfo :fscataloginfo))
    (let* ((*alias-resolution-policy* resolution-policy)
           (res (path-to-fsref path fsref)))  ;; alias-res ??
      (when (not res)(signal-file-error $fnferr path)))
    (let* ((full-path (%path-from-fsref fsref))
           (name (mac-file-namestring full-path)))      
      (errchk (#_FSGetCatalogInfo fsref (logior #$kFSCatInfoVolume #$kFSCatInfoParentDirID #$kFSCatInfoNodeID)
               catinfo (%null-ptr) (%null-ptr) (%null-ptr)))
      (setf (pref fsspec :fsspec.vrefnum)(pref catinfo :fscataloginfo.volume))
      (if (and name (neq (length name) 0))
        (progn 
          (setf (pref fsspec :fsspec.parid) (pref catinfo :fscataloginfo.parentdirid))
          (setf (pref fsspec :fsspec.name) name))
        (progn
          (setf (pref fsspec :fsspec.parid) (pref catinfo :fscataloginfo.nodeid))          
          (setf (pref fsspec :fsspec.name) ""))))))

;;;;;;;
;;;;; 
;; some fsref stuff - moved to l1-files


;;;;;;;;; end fsref stuff 


(defmethod open-application-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore reply handlerRefcon) (resident))
  (check-required-params "unexpected parameters in oapp" theAppleEvent)
  ; does nothing!
  )

(defmethod quit-application-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore reply handlerRefcon) (resident))
  (check-required-params "unexpected parameters in quit" theAppleEvent)
  (if nil ; (not (osx-p))
    (cond
     ((do-all-windows w                   ; see if we need to interact
        (when (and (method-exists-p #'window-needs-saving-p w)
                   (window-needs-saving-p w))
          (return t)))
      (ae-error-str "trying to quit"
        (#_AEInteractWithUser #$kNoTimeOut (%null-ptr) appleevent-idle))
      (unless (eq :cancel (catch :cancel
                            (let ((listener *top-listener*))
                              (do-all-windows w
                                (if (neq w listener)
                                  (window-close w))))))
        (setq *appleevent-quit* t)))
     (t
      (setq *appleevent-quit* t)))
    (let* ((cmd-key (let ((*current-event* nil))(command-key-p))))
      (cond
       ((or cmd-key
            (do-all-windows w                   ; see if we need to interact
              (when (and (method-exists-p #'window-needs-saving-p w)
                         (window-needs-saving-p w))
                (return t))))
        (ae-error-str "trying to quit"
          (#_AEInteractWithUser #$kNoTimeOut (%null-ptr) appleevent-idle))
        (when (and cmd-key 
                   (menu-enabled-p *apple-menu*)        ; <---
                   (null (do-quit-dialog)))
          (return-from quit-application-handler nil))
        (unless nil #+ignore (eq :cancel (catch :cancel  ;; why do this here? - quit does it better                          
                                           (let ((listener *top-listener*))
                                             (do-all-windows w
                                               (if (neq w listener)
                                                 (window-close w))))))
                (setq *appleevent-quit* t)))
       (t
        (setq *appleevent-quit* t))))))

#| ; in case move to application menu?
(defmethod quit-application-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore reply handlerRefcon) (resident))
  (check-required-params "unexpected parameters in quit" theAppleEvent)
  (let* ((cmd-key (let ((*current-event* nil))(command-key-p))))
    (cond
     ((or cmd-key
          (do-all-windows w                   ; see if we need to interact
            (when (and (method-exists-p #'window-needs-saving-p w)
                       (window-needs-saving-p w))
              (return t))))
      (ae-error-str "trying to quit"
        (#_AEInteractWithUser #$kNoTimeOut (%null-ptr) appleevent-idle))
      (when (and cmd-key
                 (null (y-or-n-dialog (format nil "Do you really want to quit from ~A ?"
                                                     (current-app-name))
                                             :yes-text "Quit"
                                             :cancel-text nil
                                             :window-type :double-edge-box
                                             :help-spec '(:dialog 11110 :yes-text 11111 :no-text 11112))))
        (return-from quit-application-handler nil))
      (unless nil #+ignore (eq :cancel (catch :cancel  ;; why do this here? - quit does it better                          
                              (let ((listener *top-listener*))
                                (do-all-windows w
                                  (if (neq w listener)
                                    (window-close w))))))
        (setq *appleevent-quit* t)))
     (t
      (setq *appleevent-quit* t)))))
|#

(defmethod open-documents-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore reply handlerRefcon) (resident))
  (with-aedescs (doclist)
    (rlet ((items :signed-long)
           (aekeyword :ostype)
           (actual-type :ostype)
           ;(my-fsspec :fsspec)
           (my-fsref :fsref)
           (actual-size :signed-long))
      (ae-error-str "trying to get the doclist in odoc"
        (#_AEGetParamDesc theAppleEvent #$keyDirectObject #$typeAEList doclist))
      (check-required-params "unexpected parameters in odoc" theAppleEvent)
      (ae-error-str "trying to count the items in odoc" 
        (#_AECountItems doclist items))
      (dotimes (i (%get-signed-long items))
        (ae-error-str "trying to get an item in odoc"
          (#_AEGetNthPtr doclist (+ i 1) #$typeFSref aekeyword actual-type my-fsref 
           (record-length :fsref) actual-size))
        (let* ((path (%path-from-fsref my-fsref)))
          (if *startup-aevents*
            (if (eq (car *finder-parameters*) :open)
              (setq *finder-parameters* (nconc *finder-parameters* (list path)))
              (setq *finder-parameters* (list :open path)))
            (open-application-document a path)))))))

(defmethod print-documents-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore reply handlerRefcon) (resident))
  (with-aedescs (doclist)
    (rlet ((items :signed-long)
           (aekeyword :ostype)
           (actual-type :ostype)
           ;(my-fsspec :fsspec)
           (my-fsref :fsref)
           (actual-size :signed-long))
      (ae-error-str "trying to get the doclist in odoc"
        (#_AEGetParamDesc theAppleEvent #$keyDirectObject #$typeAEList doclist))
      (check-required-params "unexpected parameters in pdoc" theAppleEvent)
      (ae-error-str "trying to count the items in pdoc"
        (#_AECountItems doclist items))
      ; deal with the whole interaction issue... If we can interact, then
      ; throw up the print dialog.
        (catch :cancel                  ; be prepared for a cancel
          (ae-error-str "trying to interact in pdoc"
            (#_AEInteractWithUser #$kNoTimeOut (%null-ptr) appleevent-idle))
          (unless *foreground*          ; workaround - someone isn't sending us the resume!
            (#_postevent (%int-to-ptr #$osEvt) (+ #x1000000 #$suspendResumeMessage)))
          #-carbon-compat
          (unwind-protect               ; make sure PrClose gets called
            (progn          ; do the print dialog
              (#_PrOpen)
              (prchk $err-printer-load)
              (let ((pRec (get-print-record)))
                (with-cursor *ARROW-CURSOR*
                  (unless (#_PrJobDialog pRec)
                    (throw :cancel :cancel)))))
            (#_PrClose))
          #+carbon-compat
          (print-style-dialog)          
          (dotimes (i (%get-signed-long items))
            (ae-error-str "trying to get an item in pdoc"
              (#_AEGetNthPtr doclist (+ i 1) #$typeFsref aekeyword actual-type my-fsref 
               (record-length :fsref) actual-size))
            (let ((path (%path-from-fsref my-fsref)))
              (if *startup-aevents*
                (if (eq (car *finder-parameters*) :print)
                  (setq *finder-parameters* (nconc *finder-parameters* (list path)))
                  (setq *finder-parameters* (list :print path)))
                (print-application-document a path))))))))

(defun hardcopy-file (path &optional (show-dialog t))
  "Uses Fred to print a file"
  (let ((window (pathname-to-window path)))
    (cond (window (window-hardcopy window show-dialog))
          (t (setq window (ed path))
             (window-hardcopy window show-dialog)
             (window-close window)))))
  
(defmethod print-application-document ((a lisp-development-system) path &optional startup)
  (declare (ignore startup))
  (hardcopy-file path nil))

(defmethod open-application-document ((a lisp-development-system) path &optional startup)
  (declare (ignore startup))
  (case (mac-file-type path)
    (#-ppc-target :fasl
     #+ppc-target :pfsl
     (with-simple-restart (continue "Skip loading finder-selected file.")
       (paranoid-load path)
       t))
    ((#.(ff-long-to-ostype 0) :????)
     (if (equalp (pathname-type path) (pathname-type *.PFSL-PATHNAME*))
       (with-simple-restart (continue "Skip loading finder-selected file.")
         (paranoid-load path)
         t)
       (when t ; (equalp (pathname-type path)(pathname-type *.lisp-pathname*))
         (ed path)
         nil)))
    
    ((:|TEXT| :|utxt|) (ed path)
     nil)))

(defparameter *paranoid* t)

(defun paranoid-load (p)
  (let* ((log-path (pathname (back-translate-pathname p)))
         (log-host (pathname-host log-path)))
    (if (or (not *paranoid*)
            (and (logical-pathname-p log-path)
                 (not (equalp log-host "home")))
            (eq t (catch-cancel 
                    (let ((message (format nil "Do you really want to load ~S ?" p)))
                        (standard-alert-dialog message :position :main-screen )))))
      (load p))))


; This is called when AppleScript does "launch application ..."
; open-application-handler gets called for "run application ..."
(defmethod launch-application-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore reply handlerRefcon) (resident))
  (check-required-params "Unexpected parameters in 'ascr' 'noop'" theAppleEvent)
  ; does nothing
  )

; This is called with AppleScript does "tell application ... to activate"
(defmethod activate-application-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore reply handlerRefcon) (resident))
  (check-required-params "Unexpected parameters in 'misc' 'actv'" theAppleEvent)
  (rlet ((psn :processSerialNumber
              :highLongOfPSN 0
              :lowLongOfPSN #$kCurrentProcess))
    (#_setFrontProcess psn)))

(install-appleevent-handler :|ascr| :|noop| #'launch-application-handler)
(install-appleevent-handler :|misc| :|actv| #'activate-application-handler)



;install our handlers
(install-appleevent-handler :|aevt| :|ansr| #'queued-reply-handler)
(install-appleevent-handler :|aevt| :|oapp| #'open-application-handler)
(install-appleevent-handler :|aevt| :|quit| #'quit-application-handler)
(install-appleevent-handler :|aevt| :|odoc| #'open-documents-handler)
(install-appleevent-handler :|aevt| :|pdoc| #'print-documents-handler)

(export 'resume-application-handler)

;;; This is called when the OS8 Finder resumes a running application
;;; via the user opening an already-active application.
(defmethod resume-application-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore reply handlerRefcon) (resident))
  (check-required-params "Unexpected parameters in 'aevt' 'rapp'" theAppleEvent)
  ;; does nothing
  )

(install-appleevent-handler :|aevt| :|rapp| #'resume-application-handler)

(defmethod window-collapse-show-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore theAppleEvent reply handlerRefcon) (resident))
  )

(defmethod sleep-wakeup-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore theAppleEvent reply handlerRefcon) )
  #+carbon-compat
  (dolist (f *sleep-wakeup-functions*)  ;; sure is simpler this way
    (funcall f))
  )

(defmethod battery-going-dead-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore theAppleEvent reply handlerRefcon) )
  )

(defmethod sysfont-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore theAppleEvent reply handlerRefcon) )
  (sys-font-spec)
  )

(defmethod viewfont-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore theAppleEvent reply handlerRefcon) )
  )
(defmethod theme-change-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore theAppleEvent reply handlerRefcon) )
  )

(install-appleevent-handler :|ApCC| :|erse| #'window-collapse-show-handler)

; os9 on pb g3 does this - ignore for now - the old sleepq way still works

(install-appleevent-handler :|pmgt| :|wake| #'sleep-wakeup-handler)
(install-appleevent-handler :|pmgt| :|pmsd| #'battery-going-dead-handler)  ; or pre menstrual syndrome
(install-appleevent-handler :|pmgt| :|emsl| #'battery-going-dead-handler)

(install-appleevent-handler :|appr| :|sysf| #'sysfont-handler)
(install-appleevent-handler :|appr| :|vfnt| #'viewfont-handler)
(install-appleevent-handler :|appr| :|thme| #'theme-change-handler)


  

(def-ccl-pointers highlevel-events ()
  (when (gestalt #$gestaltAppleEventsAttr #$gestaltAppleEventsPresent)
    ; install our handler into the real AppleEvent Manager dispatch table
    (#_AEInstallEventHandler #$typeWildCard #$typeWildCard
     defer-appleevent-handler 0 nil)
    ;; compensate for crock in some versions of CarbonLib
    (#_AEInstallEventHandler #$typeAppleEvent #$kAEQuitApplication
     defer-appleevent-handler 0 nil)))




;; do quit with carbon event so detection of command key is reliable on OSX

#|
- install an event handler for kEventClassCommand/kEventCommandProcess 
on the app target
- in your event handler, check the HICommand.commandID field for 
kHICommandQuit
- if it's the quit command, get the kEventParamMenuContext parameter
- if the menu context contains kMenuContextKeyMatching, then the 
command event was sent in response to a command key; otherwise, it was 
selected from the menu with the mouse

-eric
|#



;(add-pascal-upp-alist 'quit-handler-proc #'(lambda (procptr)(#_neweventhandlerupp procptr)))

(add-pascal-upp-alist-macho 'quit-handler-proc "NewEventHandlerUPP")


(defpascal quit-handler-proc (:ptr targetref :ptr eventref :word)
  (declare (ignore targetref))
  (let ((res #$eventNotHandledErr)
        (myerr nil))
    (rlet ((hicmd :hicommand)
           (menu-context :uint32))
      (setq myerr (#_geteventparameter eventref #$keventparamdirectobject #$typehicommand *null-ptr* (record-length :hicommand)  *null-ptr* hicmd))
      (when (eq myerr #$noerr) 
        (let ((offset (get-field-offset :hicommand.commandid) )) ;(poo (ff-long-to-ostype (pref hicmd hicommand.commandid))))
          (cond ((%equal-ostype hicmd #$khicommandquit offset) ;(eql poo #$khicommandquit) ;; got here on OSX
                 (setq res #$noerr)
                 (when (menu-enabled-p *apple-menu*)
                   (setq myerr (#_geteventparameter eventref #$keventparammenucontext #$typelonginteger *null-ptr* (record-length :uint32) *null-ptr* menu-context))
                   (when (eq myerr #$noerr)                     
                     (if (neq 0 (logand (%get-unsigned-long menu-context) #$kmenucontextkeymatching))                       
                       (when (do-quit-dialog)
                         (quit))
                       (progn (#_hilitemenu -1) ;; see comment below, -1 is magic mumbo jumbo
                              (quit))))))
                ((%equal-ostype hicmd #$kHICommandPreferences offset) ;(eql poo #$kHICommandPreferences)
                 (setq res #$noerr)
                 (when (menu-enabled-p *apple-menu*)                           
                   (#_hilitemenu -1) ; else the ffing menu stays hilited if chosen from menu vs via cmd-key - what??
                   (environment-dialog)))
                )))
      res)))

(defun do-quit-dialog ()
  (let ((message (format nil "Do you really want to quit from ~A ?"
                         (current-app-name))))
    (standard-alert-dialog message
                           :yes-text "Quit"
                           :cancel-text "No"
                           :no-text nil
                           :alert-type #$kalertcautionalert
                           :position :main-screen)))
  



(def-ccl-pointers qqquit2 ()
  (when (osx-p)
    (#_installeventhandler (#_getapplicationeventtarget) quit-handler-proc 1
     (make-record :eventtypespec 
                  :eventclass #$kEventClassCommand
                  :eventkind #$kEventCommandProcess)
     (%null-ptr) (%null-ptr))))



#|
(defun remove-notify ()
  (rlet ((psn :processserialnumber
              :highLongOfPSN 0
              :lowLongOfPSN #$kCurrentProcess))
    (#_dmremoveextendednotifyproc dmnotify-proc (%null-ptr) psn #$kfullnotify)))
(defun install-notify ()
  (rlet ((psn :processserialnumber
              :highLongOfPSN 0
              :lowLongOfPSN #$kCurrentProcess))
    (#_DMRegisterExtendedNotifyProc dmnotify-proc (%null-ptr) #$kFullNotify psn)))
|#
(defvar *sleep-begin-functions* nil)  

;(add-pascal-upp-alist 'dmnotify-proc #'(lambda (procptr) (#_NewDMExtendedNotificationUPP procptr)))

(add-pascal-upp-alist-macho 'dmnotify-proc "NewDMExtendedNotificationUPP")

(defpascal dmnotify-proc (:ptr userdata :signed-integer the-message :ptr notifydata)
  (declare (ignore userdata notifydata))
  ;; 11 on wake from sleep - include that too?
  ;  #$kDMNotifyDisplayDidWake       = 11,   /* Mac OS X only */ - not in our headers - is now
  (cond 
   ((eq the-message #$kDMNotifyDisplayWillSleep)
    (dolist (f *sleep-begin-functions*)
      (funcall f)))
   ((or (eq the-message #$kDMNotifyDisplayDidWake) (eq the-message #$kDMNotifyEvent)) ;; what is dependents = 6??
    (get-current-screen-size)
    (get-the-current-window-drag-rect nil)
    (when (eq the-message #$kDMNotifyDisplayDidWake)  ;; added this
      (dolist (f *sleep-wakeup-functions*)
        (funcall f))))))

#|
(defun sleep-beep ()
  (#_sysbeep 10)(sleepticks 60))
(pushnew 'sleep-beep *sleep-begin-functions*)
|#

    

(def-ccl-pointers dmnotify2 ()
  (if (osx-p)
    (rlet ((psn :processserialnumber
                :highLongOfPSN 0
                :lowLongOfPSN #$kCurrentProcess))
      (#_DMRegisterExtendedNotifyProc dmnotify-proc (%null-ptr) #$kFullNotify psn))))
   




    


; End of l1-highlevel-events.lisp 