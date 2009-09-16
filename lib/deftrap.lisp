;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: deftrap.lisp,v $
;;  Revision 1.9  2006/03/13 00:38:10  alice
;;  ; load-interface-files just warns when unhappy, load-all-traps does not work! 
; reindex-interfaces binds *read-default-float-format* to 'double-flaot because of 1.0e150 somewhere in interfaces
;;
;;  Revision 1.8  2006/03/08 20:44:19  alice
;;  ;; print-object of macho-entry-point prints the framework name too
; ---- 5.2b1
;;
;;  Revision 1.7  2006/02/03 22:19:00  alice
;;  ;12/27/05 add some macho-entry-point stuff
; lose expand-trap-internal
; interface-definition-p - don't need to find in e.g. (gethash other-sym %record-descriptors%) - just look in *records-index-file*
;;
;;  Revision 1.6  2004/06/09 00:37:40  alice
;;  ; make *traps-index-directory* a directory name
;;
;;  Revision 1.5  2004/02/26 20:31:08  alice
;;  ; expand-trap-internal on OS9 warns if found in InterfaceLib
;;
;;  Revision 1.4  2003/12/08 08:05:54  gtbyers
;;  No more #-ansi-make-load-form.
;;
;;  3 4/1/97   akh  see below
;;  4 11/9/95  bill Fix :d0 selector bug in trap-args-and-return
;;  6 3/2/95   akh  say 'base-character
;;  5 2/16/95  slh  bind *warn-if-redefine-kernel*
;;  4 2/2/95   akh  undo last change - so can run 2 lisps in same directory
;;  3 1/30/95  akh  open index file :io - from a patch
;;  (do not edit before this line!!)

; Deftrap.lisp
; Copyright 1990-1994 Apple Computer, Inc.
; Copyright 1995-2006 Digitool, Inc.

; Change log
;
;; expand-trap-internal heeds *dont-use-cfm*
;; ------- 5.2b5
; put back define-entry-point and things it depends on - though MCL doesn't use it users may
; ------ 5.2b2
; load-all-traps just warns if error
; provide-interface - behaves like %require-interface
;; load-framework-bundle - redef allows frameworks in places other than system/library/frameworks
; lose defctbtrap
; load-interface-files just warns when unhappy, load-all-traps does not work because some records contain undefined components! 
; reindex-interfaces binds *read-default-float-format* to 'double-flaot because of 1.0e150 somewhere in interfaces
; print-object of macho-entry-point prints the framework name too
; ---- 5.2b1
; ignore a bunch of obsolete stuff
;12/27/05 add some macho-entry-point stuff
; lose expand-trap-internal
; interface-definition-p - don't need to find in e.g. (gethash other-sym %record-descriptors%) - just look in *records-index-file*
; %require-interface deals with posix name
; add sint8 etal to *mactype-name=>ppc-ff-call-type* list, also add fourcharcode
;; ------- 5.1 final
; make *traps-index-directory* a directory name
; ---------- 5.1b2
; expand-trap-internal on OS9 warns if found in InterfaceLib
;; -------- 5.1b1
; dont even think about trap emulator on OSX
; -------- 4.4b2
; 08/02/01 akh make one "using trap emulator" warning stronger
; change make-trap-symbol for list arg to compensate for change below
; no mo remove-underbar in trap-string
; ---------- 4.3
; 04/02/97 bill In parse-traps-file, the defconstant clause now says self-evaluting-p instead
;               of constantp. This is another attempt to prevent getting $callingconventionwidth
;               instead of its value as the value of $kResultSizePhase in the constants index.
; 03/22/97 akh  gary's fix to parse-traps-file for defconstant
; 03/05/97 gb   CHECK-TRAP-ARG reported a very strange type in error.
; ------------- 4.0
; 09/30/96 bill The *type-check-trap-p* lambda returns true on the ppc-target if
;               safety-optimize-quantity is unbound or excised.
; ------------- 4.0b2
; 08/20/96 bill call-accessing-index-stream now grabs the *index-stream-lock* so
;               that multiple processes won't interfere with each other.
; ------------- 4.0b1
; 06/03/96 bill add :single-float to *mactype-name=>ppc-ff-call-type*
; 05/10/96 bill trap expansion may now generate a "Can't find shared library..." warning
;               for every trap expansion.
;               define-entry-point "traps" always generate the same code.
;               They get warnings at compile time and errors at run time if
;               the library or entry point can't be found.
;               Changes to define-entry-point, expand-trap-internal
; 05/02/96 bill make (deftrap (foo nil) ...) specify that the trap has no corresponding shared
;               library entry point, hence there should be no warning.
;               make-trap-symbol returns NIL for this syntax.
;               trap-string returns NIL if it finds NIL in the %trap-strings% table.
;               expand-trap-internal doesn't lookup the shared library entry point if the string is NIL.
; ------------- 3.9
; 03/29/96 bill define-entry-point, break deftrap-shared out from deftrap.
;               New, optional, intern-in-traps-package? arg to make-trap-symbol.
; 03/11/96 bill DTRT for :immed, :async, :sys, & :clear modifiers on the PPC (append to trap name).
;               Allow :errchk and friends in all PPC trap calls.
;               deftrap supports syntax for specifying the shared library name:
;                 (deftrap name ...)
;                 (deftrap (name real-name) ...)
;                 (deftrap (name (library-name) ...)
;                 (deftrap (name (library-name real-name) ...)
;               defctbtrap supports the new deftrap syntax.
;               reindex-interfaces writes and load-trap reads the trap-string
;               which specifies the library name and remapping for a simple trap.
;               (reindex-interfaces :which :traps) parses just the traps again.
; 03/09/96 bill memerror-check & reserror-check macros.
;               translate-explicit-mactypes handles return types.
; 03/07/96 bill expand-simple-trap gives more info in "using emulator" error message.
;               pass env to expand-ff-trap
; 03/05/96 bill defctbtrap expands into deftrap on the PPC if a library entry point can be found.
;               It accepts a string for the trap name to preserve case.
;               make-trap takes a new may-be-simple-p keyword arg, default true.
;               %deftrap uses (new) string-equal-modulo-leading-underbar to determine
;               the value for the may-be-simple-p arg.
;               reindex-interfaces & friends handle the new (deftrap (lisp-name library-name) ...) syntax.
; 01/23/96 bill Eliminate the #+interfaces-2 version of reindex-interfaces.
;               It came from an older source base and was missing the 8/10/92
;               and later changes that allowed you to merge a subset of the
;               files into the existing indices.
; 01/03/96 gb   translate :double-float mactype to :double-float ppc-ff-call keyword
; 11/28/95 bill translate-explicit-mactypes for PPC
; 11/23/95 bill errchk macro
; 11/08/95 bill For the PPC, expand-simple-trap calls expand-ff-trap to generate a ppc-ff-call.
;               ff-trap-args-from-simple-trap-args parses the trap-bits into what expand-ff-trap expects
; 11/07/95 bill simple traps remember their case in %trap-strings%
; 10/31/95 bill %trap-strings%
;               The cfm support that couldn't go in l0-cfm-support.
;               All but simple traps generate (ppc-ff-call ...) on the PPC.
;               Doesn't yet check for unsupported multiple return values.
;               Bind *print-base* & *read-base* to 10. where it matters.
;               expand-trap-internal does the work for expand-trap macro so that
;               I can change it without fmakunbound'ing all the trap symbols.
; 10/26/95 slh  %gvector -> %istruct
;  5/25/95 slh  new interfaces-2 changes
;  5/17/95 slh  added *trap-synonyms*, modified load-trap
;  5/12/95 slh  interfaces-2 mods; find-interface-entry: bind *package* to TRAPS around other READ
;  2/16/95 slh  eval-deftrap-for-indexing, load-interface-files: bind *warn-if-redefine-kernel*
;-------------- 3.0d17
; 02/01/95 lose below - prevents running multiple lisps in same dir
; 01/25/95 open-index-file does :io per reindex-stream-patch
;-------------- 3.0d16
; 09/01/93 bill add some line breaks.
; ------------- 3.0d12
; 02/25/93 bill reindex-interfaces now returns NIL instead of a very long list.
; 01/28/93 bil  reindex-interfaces doesn't bother to parse & resave an index if there are
;               no new entries.
; 08/10/92 bill reindex-interfaces now takes :which & :files keywords.
;               More docs before its definition.
; 08/05/92 bill The :case register-trap keyword had the wrong value.
;               expand-trap needed to copy-tree the implementation, not copy-list
; 07/03/92 bill in %deftrap-internal: don't attempt to define-constant if the value isn't constant.
; 05/28/92 bill accessing-index-stream to prevent event processing from messing up
;               compilation by changing an index stream's file-position
; 05/15/92 bill documentation works again for traps (make trap-args-and-return track
;               the change in representation of a trap).
;-------------- 2.0
; 03/09/92 bill Don't signal file open errors on attempting to open an index file.
;-------------  2.0f3
; 02/21/92 (bill from bootpatch0)   Expand-simple-trap now works correctly for stack traps with
;               a :d0 selector when safety is 3.
;               Also make it work for :boolean args when safety is 3.
;-------- 2.0f2
; 12/20/91 bill Prevent expand-simple-trap error when safety is set to 3
;-------- 2.0b4
; 11/07/91 bill find-interface-entry's error message references "ccl:library;interfaces.lisp"
; 11/04/91 bill load-trap saves arglists if (or *save-arglist-info* *save-local-symbols*)
; 10/04/91 bill add :resolve-aliases to the (directory ...) calls here.
; 10/01/91 bill with-standard-io-syntax in parse-traps-file.
;               Clarify comments output by reindex-interfaces.
; 09/23/91 bill run-time type checking now works correctly for character & boolean arg types.
; 09/18/91 bill trap-args-and-return for use by show-trap-documentation
; 09/11/91 bill in expand-explicit-simple-stack-trap - expand properly when end-selector is a :long
;-------- 2.0b3
; 09/05/91 bill GB's fix to parse-trap-args-modifiers, no :check-error for stack traps in expand-trap
; 08/28/91 bill in %deftrap-internal - check for auto-pop bit
;               load-all-records, load-all-mactypes
; 08/24/91 bill Keep track of errors and non-simple traps in REINDEX-INTERFACES
;               1333 of 1668 traps can be recorded entirely in the index file.
; 08/23/91 bill make-simple-trap now checks for trap call arglist longer
;               than trap arglist and handles :d0 selectors for register
;               traps.  Also expands :signed-integer & :unsigned-integer
;               returns from register traps correctly.
;               defctbtrap converts record argument types to :pointer
;               :REGISTER-TRAP is not yet obsolete.  The following CALL
;               was mistaken for a stack trap: (:REGISTER-TRAP #XA04D :D0 CBNEEDED)
; 08/18/91 bill expand-simple-trap complete.
; 08/17/91 bill 1347 of 1390 traps stored in index now.
; 08/14/91 bill Constant values stored in the index now.  Source file info for traps & constants
;               looked up in the index, not stored in %source-files%
; 08/19/21 gb   really add DEFCTBTRAP; make it work a bit better.
; 07/21/91 gb   add DEFCTBTRAP; support macroexpand-time modifiers in EXPAND-TRAP.  Use def-accessors for
;               trap structure.  Make :no-trap work.
; 07/18/91 bill klugey fix to DEFTRAP cloberring its arguments
; 06/10/91 bill in expand-trap: don't be so eager to call mactype-p
; 06/11/91 joe  Baschy's fix in process trap call 
; 06/06/91 joe  Incorporate Bill's fixes to load-record & load-mactype
; 06/04/91 joe  no longer require stack or register trap to be specified at
;               deftrap time. We figure it out ourselves & define the right
;               thing which is possibly a gen-trap. Allow :undefined-trap
;               which creates a trap number but won't compile.
;-------------- 2.0b2
; 05/30/91 bill put some sanity checks in the auto-load stuff.
; 05/21/91 gb  %require-interface from "ccl:interfaces;".
; 4/15/91  joe   remove trailing ; from *traps-index-directory*. ANSI pathname hell
; 4/8/91  joe   fix some ccl:interfaces; pathname screws
; 02/19/91 bill require-trap-constant was bogus, require-trap was ugly.
; 03/04/91 alice report-bad-arg gets 2 args
; 02/07/91 alice preface dir names with ccl:
;----------- 2.0b1
; 01/17/91 bill EXPAND-TRAP doesn't generate a LET if it doesn't need to.
;               It also declare's dynamic-extent if it knows it can.
; 01/08/91 bill Move (defpackage traps ...) & *traps-package* to l1-init.
;               require-trap, require-trap-constant
;               trap-expansion does type checking only if SAFETY is 3.
;               If *type-check-trap-p* is a function, funcall is with a single
;               arg of the macroexpansion environment, otherwise, it is a boolean.
; 01/07/90 bill Prevent consing of symbols in PARSE-TRAPS-FILE
; 12/22/90 joe  Imported def-mactype and find-mactype to traps package.
;               Eliminated passing keyword args to a trap call. Move $true & $false to types.lisp
;               interface file. make-traps-directory -> reindex-interfaces. removed
;               add-definition-type so this could be part of the *env-modules*
; 10/24/90 bill :check-error, :errchk, :error-check all allowed in traps.
; 09/28/90 bill alanr's fix to expand-trap
; 09/27/90 bill LOAD-RECORD,
;               Call LOAD with "interfaces;foo", not "interfaces;foo.lisp"
; 09/10/90 bill make deftrap compileable.  deftrap includes defconstant.
;               *autoload-traps*, *roving-mini-buffer* output while autoloading.
;               require-interface, provide-interface, $true, $false.
; 09/08/90 bill always quote keywords in macro-expansions in case they aren't.
; 09/07/90 bill *traps-package*
; 7/90  joe new
;


(in-package :ccl)

; This would like to be in l0-cfm-support, but it was too early then.

(defvar *shared-library-descriptor-class*
  (make-built-in-class 'shared-library-descriptor *istruct-class*))

(defvar *shared-library-entry-point-class*
  (make-built-in-class 'shared-library-entry-point *istruct-class*))

(defvar *macho-entry-point-class*
  (make-built-in-class 'macho-entry-point *istruct-class*))

(setf (type-predicate 'shared-library-descriptor) 'shared-library-descriptor-p)
(setf (type-predicate 'shared-library-entry-point) 'shared-library-entry-point-p)
(setf (type-predicate 'macho-entry-point) 'macho-entry-point-p)

(defmethod print-object ((sld shared-library-descriptor) stream)
  (print-unreadable-object (sld stream :type t :identity t)
    (format stream "~s" (sld.name sld))))

(defmethod print-object ((slep shared-library-entry-point) stream)
  (print-unreadable-object (slep stream :type t :identity t)
    (format stream "~s ~s" (slep.name slep) (sld.name (slep.sld slep)))))

(defmethod print-object ((macho macho-entry-point) stream)
  (print-unreadable-object (macho stream :type t :identity t)
    (format stream "~s ~S" (macho.name macho) (macho.framework macho) )))

(defmethod make-load-form ((sld shared-library-descriptor)  &optional env)
  (declare (ignore env))
  `(get-shared-library-descriptor ,(sld.name sld)))


(defmethod make-load-form ((slep shared-library-entry-point) &optional env)
  (declare (ignore env))
  `(load-shared-library-entry-point ,(slep.name slep) ,(sld.name (slep.sld slep))))


; Trap definitions
(defvar %traps% (make-hash-table :test #'eq))
(defvar %trap-strings% (make-hash-table :test #'eq))

(defun trap-string (name &optional dont-lookup)
  (let ((name (if dont-lookup
                name
                (multiple-value-bind (string found-p) (gethash name %trap-strings%)
                  (if found-p 
                    (or string (return-from trap-string nil))
                    name)))))
    (if (and name (listp name))
      (values (second name) (first name))      
      (string name))))
 #| ;; evil
      (remove-leading-underbar (string name))))) |#

; List of loaded interface files
(defvar *interfaces* '("TRAPS"))  ;; what the heck is that about? very obsolete.

(defun clear-traps ()
  (let ((traps (find-package :traps)))
    (when traps
      (do-external-symbols (s traps)
        (when (eq traps (symbol-package s))
          (unintern s traps)))))
  (setq %traps% (make-hash-table :test #'eq))
  (setq *interfaces* '("TRAPS"))
  t)

(require 'mactypes)
(require 'simple-db)


(defun make-trap (&key args return implementation call (may-be-simple-p t))
  (or (and may-be-simple-p (make-simple-trap args return implementation call))
      (%istruct 'trap args return implementation call)))


(eval-when (:compile-toplevel :execute)
  (defconstant $simple-trap-type-size 2)          ; bits per type spec
  (defconstant $simple-trap-type-mask (1- (expt 2 $simple-trap-type-size)))
  (defconstant $simple-trap-normal-type 0)
  (defconstant $simple-trap-boolean-type 1)
  (defconstant $simple-trap-character-type 2)
  (defconstant $simple-trap-handle-type 3)
  (defconstant $simple-trap-argcnt-size 4)        ; bits for argcnt
  (defconstant $max-simple-trap-args (1- (expt 2 $simple-trap-argcnt-size)))
  )  ; end of eval-when


#| not needed no more
(defvar *trap-synonyms*
  '((,#_catsearch . ,#_pbcatsearch)
    (,#_close . ,#_pbclose)
    (,#_createfileidref . ,#_pbcreatefileidref)
    (,#_delete . ,#_pbdelete)
    (,#_deletefileidref . ,#_pbdeletefileidref)
    (,#_dtaddappl . ,#_pbdtaddappl)
    (,#_dtaddicon . ,#_pbdtaddicon)
    (,#_dtclosedown . ,#_pbdtclosedown)
    (,#_dtdelete . ,#_pbdtdelete)
    (,#_dtflush . ,#_pbdtflush)
    (,#_dtgetappl . ,#_pbdtgetappl)
    (,#_dtgetcomment . ,#_pbdtgetcomment)
    (,#_dtgeticon . ,#_pbdtgeticon)
    (,#_dtgeticoninfo . ,#_pbdtgeticoninfo)
    (,#_dtgetinfo . ,#_pbdtgetinfo)
    (,#_dtgetpath . ,#_pbdtgetpath)
    (,#_dtopeninform . ,#_pbdtopeninform)
    (,#_dtremoveappl . ,#_pbdtremoveappl)
    (,#_dtremovecomment . ,#_pbdtremovecomment)
    (,#_dtreset . ,#_pbdtreset)
    (,#_dtsetcomment . ,#_pbdtsetcomment)
    (,#_exchangefiles . ,#_pbexchangefiles)
    (,#_flushfile . ,#_pbflushfile)
    (,#_getcatinfo . ,#_pbgetcatinfo)
    (,#_getfcbinfo . ,#_pbgetfcbinfo)
    (,#_getforeignprivs . ,#_pbgetforeignprivs)
    (,#_getvolmountinfo . ,#_pbgetvolmountinfo)
    (,#_getvolmountinfosize . ,#_pbgetvolmountinfosize)
    (,#_hcopyfile . ,#_pbhcopyfile)
    (,#_hgetdiraccess . ,#_pbhgetdiraccess)
    (,#_hgetlogininfo . ,#_pbhgetlogininfo)
    (,#_hgetvinfo . ,#_pbhgetvinfo)
    (,#_hgetvolparms . ,#_pbhgetvolparms)
    (,#_hmapid . ,#_pbhmapid)
    (,#_hmapname . ,#_pbhmapname)
    (,#_hmoverename . ,#_pbhmoverename)
    (,#_hopendeny . ,#_pbhopendeny)
    (,#_hopenrfdeny . ,#_pbhopenrfdeny)
    (,#_hsetdiraccess . ,#_pbhsetdiraccess)
    (,#_lockrange . ,#_pblockrange)
    (,#_makefsspec . ,#_pbmakefsspec)
    (,#_mountvol . ,#_pbmountvol)
    (,#_offline . ,#_pboffline)
    (,#_open . ,#_pbopen)
    (,#_read . ,#_pbread)
    (,#_resolvefileidref . ,#_pbresolvefileidref)
    (,#_setcatinfo . ,#_pbsetcatinfo)
    (,#_setforeignprivs . ,#_pbsetforeignprivs)
    (,#_setfvers . ,#_pbsetfvers)
    (,#_setvinfo . ,#_pbsetvinfo)
    (,#_unlockrange . ,#_pbunlockrange)
    (,#_volumemount . ,#_pbvolumemount)
    (,#_write . ,#_pbwrite)
    ))
|#

; Returns a simple trap descriptor if the trap is simple: e.g. if it
; expands into %register-trap or %stack-trap with args in the same order
; as they're passed to the macro.  Return values:
;
; NIL                         ; not a simple trap
; (trap-bits . arg-bits)      ; The usual case
; (d0 trap-bits . arg-bits)   ; Stack trap with a D0 dispatch arg (an integer)
; trap-bits                   ; the usual case, but arg-bits is 0
;
;
; trap-bits is allocated as follows:
;   bit 0     set for %stack-trap, clear for %register-trap
;   bits 1-4  Number of args for the trap
;   bits 5-x  the second argument to %stack-trap or %register-trap
;
; arg-bits is allocated as follows:
;   bits 0-1  0: no special result, 1: boolean result, 2: character result
;   bits 2-x  2 bits for each arg:
;               0: not special, 1: boolean, 2: character, 3: handle

(defun make-simple-trap (args return implementation call)
  (let (d0
        end-selector)
    (when (and (null implementation)
               (listp call) (memq (car call) '(:register-trap :stack-trap))
               ; Check that ARGS and CALL use all args in the same order
               (let* ((as args)
                      (cs (cddr call))
                      c
                      (d0-pair (rassoc :d0 cs :test 'eq)))
                 (when (and d0-pair
                            (or (eq (car call) :stack-trap)
                                (integerp (car d0-pair))))
                   (if (eq d0-pair (car cs))
                     (pop cs)
                     (setq cs (remove d0-pair cs :test 'eq)
                           call (list* (car call) (cadr call) d0-pair cs)))
                   (setq d0 (car d0-pair)))
                 (and (dolist (a as t)
                        (when (null cs) (return nil))
                        (setq c (pop cs))
                        (unless (eq (car a) (car c)) (return nil)))
                      (or (null cs)
                          (and (eq (car call) :stack-trap)
                               (listp (setq c (pop cs)))
                               (null cs)
                               (or (integerp (setq end-selector (car c)))
                                   (integerp (setq end-selector
                                                   (ignore-errors (eval end-selector)))))))
                      (not (and d0 end-selector)))))
      (multiple-value-bind (args modifiers check-error) (parse-trap-args-modifiers args)
        (let ((argcnt (length args)))
          (when (and (eql 0 modifiers)          ; always true, but I'm paranoid
                     (<= argcnt $max-simple-trap-args))
            (let ((expansion (let ((*fasl-target* :M68k))       ; ugly, ugly, ugly
                               (expand-trap-call call return check-error 0 nil))))
              ; expansion is (%xxx-trap trapnum trap-bits [D0] . args)
              (when (memq (car expansion) '(%stack-trap %register-trap))
                (let ((stack-trap-p (eq (car expansion) '%stack-trap))
                      (trap-bits (third expansion))
                      (arg-types 0)
                      return-type)
                  (when (and (integerp trap-bits)
                             (or (null d0) 
                                 (and (or (integerp d0)
                                          (integerp (setq d0 (ignore-errors (eval d0)))))
                                      (>= d0 0)))
                             (or (null end-selector)
                                 (> 0 (setq d0 (- end-selector)))))
                    (flet ((type-bits (type)
                             (cond ((and (listp type) (eq :handle (car type)))
                                    $simple-trap-handle-type)
                                   ((eq type :character) $simple-trap-character-type)
                                   ((eq type :boolean) $simple-trap-boolean-type)
                                   (t $simple-trap-normal-type))))
                      (let ((i 0)
                            (shift 0))
                        (declare (fixnum i shift))
                        (dolist (arg args)
                          (incf arg-types (ash (type-bits (cdr arg)) shift))
                          (incf i)
                          (incf shift $simple-trap-type-size)))
                      (setq return-type (type-bits (cdr return)))
                      (if (eql return-type $simple-trap-handle-type)
                        (setq return-type $simple-trap-normal-type)))
                    (let ((res (+ (if stack-trap-p 1 0)
                                  (ash argcnt 1)
                                  (ash trap-bits (1+ $simple-trap-argcnt-size))))
                          (arg-bits (+ return-type
                                       (ash arg-types $simple-trap-type-size))))
                      (when (or d0 (not (eql 0 arg-bits)))
                        (setq res (cons res arg-bits)))
                      (if d0
                        (cons d0 res)
                        res))))))))))))


; Used by show-trap-documentation

(defun trap-args-and-return (name &optional trap)
  (declare (ignore name trap))
  nil)

#|
(defun trap-args-and-return (name &optional (trap (gethash name %traps%)))
  (when trap
    (if (uvectorp trap)
      (values (trap-args trap) (trap-return trap) t)
      (let* ((d0 (and (listp trap) (listp (cdr trap)) (pop trap)))
             (end-selector (if (and d0 (< d0 0))
                             (prog1 (- d0) (setq d0 nil))))
             (argcnt&trap-bits (if (listp trap) (car trap) trap))
             (arg-bits (if (listp trap) (cdr trap) 0))
             (stack-trap-p (logbitp 0 argcnt&trap-bits))
             (argcnt (logand $max-simple-trap-args (ash argcnt&trap-bits -1)))
             (trap-bits (ash argcnt&trap-bits (- -1 $simple-trap-argcnt-size)))
             (return-type (logand $simple-trap-type-mask arg-bits))
             (arg-types (ash arg-bits (- $simple-trap-type-size)))
             (shift (- (the fixnum (if stack-trap-p *stack-code-width* *register-code-width*))))
             (mask (1- (the fixnum (ash 1 (- shift)))))
             (arglist (or (arglist name)
                          (let (res)
                            (dotimes (i argcnt (nreverse res))
                              (declare (fixnum i))
                              (push (make-arg "ARG" i) res)))))
             res)
        (declare (fixnum argcnt mask stack-trap-p))
        (when d0
          (setq trap-bits (ash trap-bits shift)))
        (flet ((argtype (arg-types trap-bits mask stack-trap-p)
                 (let ((arg-type (logand $simple-trap-type-mask arg-types))
                       (trap-type (logand mask trap-bits)))
                   (if (eql arg-type $simple-trap-normal-type)
                     (if stack-trap-p
                       (car (rassoc trap-type *stack-trap-arg-keywords*))
                       (if (>= trap-type 8) :ptr :long))
                     (cdr (assoc arg-type
                                 '((#.$simple-trap-boolean-type . :boolean)
                                   (#.$simple-trap-character-type . :character)
                                   (#.$simple-trap-handle-type . :handle))))))))
          (dolist (arg arglist)
            (push (list arg (argtype arg-types trap-bits mask stack-trap-p)) res)
            (setq trap-bits (ash trap-bits shift))
            (setq arg-types (ash arg-types (- $simple-trap-type-size)))))
        (values (nreverse res)
                (cons
                 (if stack-trap-p :stack :register)
                 (progn
                   (when end-selector (setq trap-bits (ash trap-bits shift)))
                   (setq arg-types (logand (1+ (the fixnum (ash mask 1))) trap-bits))
                   (if (eql return-type $simple-trap-normal-type)
                     (if stack-trap-p 
                       (car (rassoc arg-types *stack-trap-output-keywords*))
                       (if (< arg-types #x10)
                         :novalue
                         (if (>= arg-types #x17)
                           :ptr
                           (case (ash trap-bits (- (+ *register-code-width* 2)))
                             (1 :unsigned-integer)
                             (3 :signed-integer)
                             (t :long)))))
                     (cond ((eql return-type $simple-trap-boolean-type) :boolean)
                           ((eql return-type $simple-trap-character-type) :character)
                           ((eql return-type $simple-trap-handle-type) :handle)))))
                t)))))
|#

; Save a string
(eval-when (:compile-toplevel :execute)
  (defmacro check-error-not-allowed-message ()
    "Error checking not allowed for stack traps: ~S"))

#|
(ppc-ff-call <address-exp> {<argpsec>}* <resultspec>)
; What the world needs: Yet Another MCL FF/Trap Syntax

where <address-exp> is something tagged as a fixnum, as PPC entry point
  addresses are guaranteed to be
each <argspec> is of the form (<type-keyword> <expression>)
  where <type-keyword> is one of:
    :DOUBLE-FLOAT, :SINGLE-FLOAT, :ADDRESS, :UNSIGNED-FULLWORD,
    :SIGNED-FULLWORD, :UNSIGNED-HALFWORD, :SIGNED-HALFWORD,
    :UNSIGNED-BYTE, or :SIGNED-BYTE
  and <expression> is some lisp form that'll return a value of
   the indicated type (or something close);
and <resultspec> is NIL, :VOID, or any of the <argspec> keywords.
(The FP stuff is there so that we can call the transcendental routines
in "MathLib")
|#

(defparameter *mactype-name=>ppc-ff-call-type*
  '((:record-longint . :signed-fullword)
    (:handle . :address)
    (:signed-long . :signed-fullword)
    (:unsigned-byte . :unsigned-byte)
    (:point . :signed-fullword)
    (:character . :unsigned-byte)
    (:record-integer . :signed-halfword)
    (:string . :address)
    (:pointer . :address)
    (:ostype . :unsigned-fullword)
    (:fourcharcode . :unsigned-fullword)
    (:signed-integer . :signed-halfword)
    (:boolean . :signed-byte)
    (:signed-byte . :signed-byte)
    (:invalid-type . nil)
    (:unsigned-integer . :unsigned-halfword)
    (:unsigned-long . :unsigned-fullword)
    (:double-float . :double-float)
    (:single-float . :single-float)
    (:sint8 . :signed-byte)
    (:uint8 . :unsigned-byte)
    (:sint16 . :signed-halfword)
    (:uint16 . :unsigned-halfword)
    (:sint32 . :signed-fullword)
    (:uint32 . :unsigned-fullword)))

(defun mactype=>ppc-ff-call-type (mactype)
  (or (cdr (assq (if (symbolp mactype) mactype (mactype-name mactype))
                 *mactype-name=>ppc-ff-call-type*))
      (error "No ppc-ff-call type for ~s" mactype)))

; name is a symbol: the name of the trap
; trap is the value returned by make-simple-trap
; args is the macro argument forms
; env is the macroexpansion envrironment
;#-interfaces-3
(defun expand-simple-trap (name trap args env &optional ppc-string ppc-library)
  (let* ((trapnum (symbol-value name))
         (original-trap trap)
         (d0 (and (listp trap) (listp (cdr trap)) (pop trap)))
         (end-selector (if (and d0 (< d0 0))
                         (prog1 (- d0) (setq d0 nil))))
         (argcnt&trap-bits (if (listp trap) (car trap) trap))
         (arg-bits (if (listp trap) (cdr trap) 0))
         (stack-trap-p (logbitp 0 argcnt&trap-bits))
         (argcnt (logand $max-simple-trap-args (ash argcnt&trap-bits -1)))
         (trap-bits (ash argcnt&trap-bits (- -1 $simple-trap-argcnt-size)))
         (return-type (logand $simple-trap-type-mask arg-bits))
         (arg-types (ash arg-bits (- $simple-trap-type-size)))
         (type-check-trap-p (*type-check-trap-p* env)))
    (multiple-value-bind (processed-args modifiers check-error modifier-suffix) (parse-trap-args-modifiers args)
      (when (and ppc-string (not (eql 0 modifiers)))
        (when modifier-suffix
          (let ((real-trap (intern (concatenate 'string (string name) (string-upcase modifier-suffix)) 
                                   (symbol-package name))))
            (when (ignore-errors (load-trap real-trap))
              (return-from expand-simple-trap
                (macroexpand-1 `(,real-trap ,@processed-args) env)))))
        (if nil ;(not (osx-p))
          (warn "Unrecognized modifiers for PPC. Using trap emulator.~%~s"
                `(,name ,@args))
          (error "Unrecognized modifiers for PPC. No can do on OSX.~%~s"
                 `(,name ,@args)))
        
        (setq ppc-string nil))
      (if stack-trap-p
        (progn
          (when (find-if #'register-p args)
            (error "Trap ~s cannot be called with explicit registers." name))
          (when (and (not ppc-string) (find-if #'fast-mactype-p args))
            (when check-error
              (error (check-error-not-allowed-message) (cons name args)))
            (return-from expand-simple-trap
              (expand-explicit-simple-stack-trap 
               name processed-args trapnum modifiers d0 end-selector argcnt trap-bits))))
        (when (find-if #'register-p args)
          (when ppc-string
            (if nil ;(not (osx-p))
              (warn "Explicit registers specified. Using trap emulator.~%~s"
                    `(,name ,@args))
              (error "Explicit registers specified. No can do on OSX.~%~s"
                    `(,name ,@args))))
          (when d0
            (if (memq :d0 processed-args)
              (error ":d0 specified in trap call"))
            (setq processed-args `(:d0 ,d0 ,@processed-args)))
          (return-from expand-simple-trap
            (encode-trap '%register-trap (+ trapnum modifiers)
                         processed-args *register-trap-arg-keywords* 4
                         *register-trap-output-keywords* check-error))))
      (when ppc-string
        (multiple-value-bind (inline-args return-cons) (trap-args-and-return name original-trap)
          (let ((return-type (cdr return-cons))
                (wrapper-function nil))
            (when (eql 0 (cdr (assq return-type *stack-trap-output-keywords*)))
              (setq return-type nil))
            (when (find-if 'fast-mactype-p args)
              (multiple-value-setq (args wrapper-function return-type)
                (translate-explicit-mactypes
                 args
                 (mapcar #'(lambda (name&type)
                             (let ((type (second name&type)))
                               (if (atom type) type (car type))))
                         inline-args)
                 return-type)))
            (when check-error (push :errchk args))
            (let ((form (expand-ff-trap name args '(0) inline-args return-type t ppc-string ppc-library env)))
              (return-from expand-simple-trap
                (if wrapper-function (funcall wrapper-function form) form))))))
      (when (and check-error stack-trap-p)
        (error (check-error-not-allowed-message) (cons name args)))
      (when check-error
        (incf trap-bits (ash 1 (1+ (* (+ argcnt (if d0 2 1)) *register-code-width*)))))
      (flet ((type-bits-mactype (type-bits)
               (let ((name (case (logand $simple-trap-type-mask type-bits)
                             (#.$simple-trap-boolean-type :boolean)
                             (#.$simple-trap-character-type :character)
                             (#.$simple-trap-handle-type :handle))))
                 (and name (find-mactype name t nil)))))
        (when (or type-check-trap-p (neq 0 arg-types))
          (let* ((type-bits arg-types)
                 (args processed-args)
                 (trap-bits trap-bits)
                 (shift (- *stack-code-width*))
                 (mask (1- (ash 1 *stack-code-width*))))
            (declare (fixnum shift mask))
            (setq processed-args nil)
            (when d0
              (setq trap-bits (ash trap-bits shift)))
            (dolist (arg args)
              (let ((mactype (type-bits-mactype type-bits)))
                (when type-check-trap-p
                  (unless (or mactype (not stack-trap-p))
                    (setq mactype
                          (car (rassoc (logand trap-bits mask) *stack-trap-arg-keywords*)))
                    (setq mactype
                          (if (eq :d0 mactype)
                            nil
                            (find-mactype mactype t nil))))
                  (when mactype
                    (let ((type-checker (mactype-type-check-expand mactype)))
                      (when type-checker
                        (setq type-checker (funcall type-checker arg))
                        (if (constantp arg)
                          (eval type-checker)     ; look Ma, compile time type checking
                          (setq arg type-checker))))))
                (push (if mactype
                        (funcall (mactype-encode-expand mactype) arg)
                        arg)
                      processed-args))
              (setq type-bits (ash type-bits (- $simple-trap-type-size))
                    trap-bits (ash trap-bits shift))))
          (setq processed-args (nreverse processed-args)))
        (check-trap-argcnt argcnt name processed-args)
        (when (and end-selector (not ppc-string) (ppc-target-p))
          (error "Can't emulate trap with end-selector.~%~S"
                 `(,name ,@args)))
        (let ((res `(,(if stack-trap-p '%stack-trap '%register-trap)
                     ,(logior trapnum modifiers)
                     ,trap-bits
                     ,@(and d0 (list d0))
                     ,@processed-args
                     ,@(and end-selector (list end-selector))))
              (return-mactype (type-bits-mactype return-type)))
          (if return-mactype
            (funcall (mactype-decode-expand return-mactype) res)
            res))))))

; These numbers are in-lines below.
(eval-when (compile eval)
  (assert (and (eq 2 *stack-code-width*)
               (eq 0 (cdr (assq :ptr *stack-trap-arg-keywords*)))
               (eq 1 (cdr (assq :long *stack-trap-arg-keywords*)))
               (eq 2 (cdr (assq :d0 *stack-trap-arg-keywords*)))
               (eq 3 (cdr (assq :word *stack-trap-arg-keywords*)))
               (eq 4 (cdr (assq :ptr *stack-trap-output-keywords*)))
               (eq 5 (cdr (assq :long *stack-trap-output-keywords*)))
               (eq 7 (cdr (assq :word *stack-trap-output-keywords*))))))

; Here when user overrides the default argument types for a stack trap
;#+ignore
(defun expand-explicit-simple-stack-trap (name args trapnum modifiers d0 end-selector argcnt trap-bits)
  (let ((bits trap-bits)
        (arg-byte-count 0)
        return-type
        (return-byte-count 0)
        (end-selector-byte-count 0)
        (end-selector-type 0))
    (declare (fixnum byte-count return-byte-count end-selector-byte-count end-selector-type))
    (dotimes (i (+ argcnt (if d0 1 0) (if end-selector 1 0)))
      ; bit assignments agree with NX1-%STACK-TRAP
      (incf arg-byte-count 
            (setq end-selector-byte-count
                  (the fixnum (case (setq end-selector-type (logand bits 3))
                                ((0 1) 4) (2 0) (3 2)))))
      (setq bits (ash bits -2)))
    (when (logbitp 2 (setq return-type bits))
      (setq return-byte-count
            (case (logand bits 3) ((0 1) 4) (t 2))))
    (when end-selector (decf arg-byte-count end-selector-byte-count))
    (let ((bits 0)
          (shift 0)
          (args-tail args)
          (arglist nil)
          (user-arg-byte-count 0)
          (return-expander #'identity))
      (declare (fixnum shift user-arg-byte-count))
      (when d0 (setq bits 2 shift 2))
      (loop
        (when (null (cdr args-tail))
          (when end-selector
            (incf bits (ash end-selector-type shift))
            (incf shift 2))
          (unless (eql user-arg-byte-count arg-byte-count)
            (error "Trap ~s requires ~d bytes of args, you specified ~d bytes."
                   name arg-byte-count user-arg-byte-count))
          (if (null args-tail)
            (unless (eql 0 return-byte-count)
              (incf bits (ash return-type shift)))
            (let ((mactype (find-mactype (car args-tail))))
              (unless (eql return-byte-count (mactype-stack-size mactype))
                (error "Illegal return type: ~s for trap ~a~%Should be ~s"
                       (car args-tail) name
                       (case return-type (0 :none) (4 :ptr) (5 :long) (7 :word) (t :unknown))))
              (incf bits (ash (mactype-stack-return-code mactype) shift))
              (setq return-expander (mactype-decode-expand mactype))))
          (return
           (funcall return-expander
                    `(%stack-trap 
                      ,(+ trapnum modifiers)
                      ,bits
                      ,@(if d0 `(,d0))
                      ,@(nreverse arglist)
                      ,@(if end-selector `(,end-selector))))))
        (let ((mactype (find-mactype (pop args-tail)))
              (arg (pop args-tail)))
          (incf bits (ash (mactype-stack-arg-code mactype) shift))
          (incf shift 2)
          (incf user-arg-byte-count (mactype-stack-size mactype))
          (push (funcall (mactype-encode-expand mactype) arg) arglist))))))

(defun find-trap (name)
  (or
   (gethash name %traps%)
   (error "Undefined trap ~s" name)))

#|
(defun make-trap-symbol (sym-or-string)
  (let ((name (string sym-or-string)))
    (if (eq (char name 0) #\_)
      (if (and (symbolp sym-or-string) (eq (symbol-package sym-or-string) *traps-package*))
        sym-or-string
        (intern name  *traps-package*))
      (intern (%str-cat "_" name) *traps-package*))))
|#

(defun remove-leading-underbar (string)
  (if (and (> (length string) 0) (eql #\_ (char string 0)))
    (subseq string 1)
    string))

(defun make-trap-symbol (sym-or-string &optional (intern-in-traps-package? t))
  (cond ((listp sym-or-string)
         (destructuring-bind (sym string) sym-or-string
           (if (listp string)
             (let ((len (length string)))
               (cond ((eql len 0) nil)
                     ((eql len 1) (setq string (list (string (car string)) (remove-leading-underbar (string sym)))))
                     ((eql len 2) (setq string (list (string (car string)) (string (cadr string)))))
                     (t (error "Trap renaming spec must be rename-string, (library-name), or (library-name rename-string)"))))
             (setq string (string string)))
           (values (make-trap-symbol sym intern-in-traps-package?) 
                   (if (stringp string) (remove-leading-underbar string) string))))  ;; << was just string
        ((and (symbolp sym-or-string)
              (or (not intern-in-traps-package?) (eq (symbol-package sym-or-string) *traps-package*)))
         (values sym-or-string
                 (if intern-in-traps-package?
                   (remove-leading-underbar (string sym-or-string))
                   (string sym-or-string))))
        (t (let* ((string (string sym-or-string))
                  (name (string-upcase string))
                  (package (if intern-in-traps-package? *traps-package* *package*)))
             (values (intern name package) (remove-leading-underbar string))))))

; (add-definition-type 'function "TRAP")

(defmacro errchk (form)
  (let ((res (gensym)))
    `(let ((,res ,form))
       (unless (eql 0 ,res) (%err-disp ,res))
       ,res)))

(defmacro memerror-check (form)
  (let ((error (gensym)))
    `(prog1 ,form
       (let ((,error (require-trap #_MemError)))
         (unless (eql 0 ,error)
           (%err-disp ,error))))))

(defmacro reserror-check (form)
  (let ((error (gensym)))
    `(prog1 ,form
       (let ((,error (require-trap #_ResError)))
         (unless (eql 0 ,error)
           (%err-disp ,error))))))

#-interfaces-3
(defmacro deftrap (name args return &body implementation)
  ;  (import name :traps)
  (let ((string name))
    (multiple-value-setq (name string) (make-trap-symbol name))
    (deftrap-shared name string args return implementation)))

;#-interfaces-3
(defun deftrap-shared (name string args return implementation)
  (setq implementation (copy-tree implementation))       ; Too many setf's below
  (let (call)
    ; pull out the call from the implementation
    (setq call (process-trap-implementation implementation))
    ; check call & call args
    (ecase (car call)
      (:no-trap
       (when return
         (unless (eq (car return) :no-trap)
           (error "No-trap cannot return value in ~s" (car return)))
         (find-arg-mactype (cadr return))         ; check the return type
         (setq return (cons :no-trap (cadr return))))
       (setq args (process-trap-args args)))
      (:undefined-trap
       (setq call `(:undefined-trap ,(cadr call))
             args nil
             return nil
             implementation nil))
      ((:trap :register-trap :stack-trap) ; reg & stack for bwd compat.
       ; check & process args
       (when (null (cddr call))         ; if left off, we use the args for the whole trap
         (setf (cddr call) args))
       (setq args (process-trap-args args))
       (setq call (process-trap-call call args return))
       (if (consp (car return)) ; multiple values
         (setq return (mapcar #'process-trap-return return))
         (setq return (process-trap-return return)))))
    (when (equal implementation '(:call)) (setq implementation nil))
    `(%deftrap ',name ',args ',return ',call ',implementation ',string)))


;#-interfaces-3
(defmacro define-entry-point (name args &optional return)
  (unless (listp return)                ; works as intended for NIL
    (setq return `(:no-trap ,return)))
  (let ((string name))
    (multiple-value-setq (name string) (make-trap-symbol name nil))
    (deftrap-shared name string args return `((:no-trap :dont-emulate)))))


(defun cant-emulate (&rest call)
  (error "Can't emulate: ~s" call))

(defun string-equal-modulo-leading-underbar (s1 s2)
  (let* ((s1 (string s1))
         (s2 (string s2))
         (s1-len (length s1))
         (s2-len (length s2))
         (s1-index 0)
         (s2-index 0))
    (declare (fixnum s1-len s2-len s1-index s2-index))
    (when (and (> s1-len 0) (eql #\_ (char s1 0)))
      (decf s1-len) (incf s1-index))
    (when (and (> s2-len 0) (eql #\_ (char s2 0)))
      (decf s2-len) (incf s2-index))
    (and (eql s1-len s2-len)
         (dotimes (i s1-len t)
           (unless (char-equal (char s1 s1-index) (char s2 s2-index))
             (return nil))
           (incf s1-index)
           (incf s2-index)))))

;#-interfaces-3
(defun %deftrap (name args return call implementation &optional (string (string name)))
  (let* ((trap-string (if (listp string) (second string) string))
         (may-be-simple-p (string-equal-modulo-leading-underbar name trap-string)))
    (%deftrap-internal
     name 
     (unless (eq (car call) :no-trap) (cadr call))
     (make-trap :args args :return return :call call :implementation implementation
                :may-be-simple-p may-be-simple-p)
     (mapcar 'car args)
     string)))

(defun %deftrap-internal (name trapnum trap arglist &optional (string (string name)))
  (when trapnum
    #-interfaces-2
    (when (and (integerp trapnum)
               (logbitp 11 trapnum)
               (logbitp 10 trapnum))
      (warn "Unsetting the autopop bit (bit 10) from trap: ~a" name)
      (setq trapnum (bitclr 10 trapnum)))
    (when (constantp trapnum)
      (define-constant name trapnum)))
  (setf (gethash name %traps%) trap
        (gethash name %trap-strings%) string)
  (export name (symbol-package name))
  (record-source-file name 'function)
  (record-arglist name arglist)
  (setf (macro-function name)
        (macro-function 'expand-trap))
  name)

(defun process-trap-args (args)
  (do* ((arglist args (cdr arglist))
        (symbol (caar arglist) (caar arglist))
        (type (cadar arglist) (cadar arglist))
        temp)
       ((null arglist) (nreverse temp))
    (unless (symbolp symbol)
      (%badarg (caar arglist) 'symbol))
    ;      (find-arg-mactype type)
    (push (cons symbol type) temp)))

(defun process-trap-implementation (imp)
  (do* ((list imp (cdr list))
        (item (car list) (car list)))
       ((null list))
    (when (consp item)
      (when (memq (car item) 
                  '(:no-trap :stack-trap :register-trap :trap
                    :undefined-trap))
        (setf (car list) :call)
        (return item))
      (setq item (process-trap-implementation item))
      (when item (return item)))))


(defun process-trap-call (call processed-args return)
  (let* 
    ((stack-args nil)
     (register-args (eq (car call) :register-trap))
     (stack-return nil)
     (register-return nil)
     (multiple-return nil)
     (call-args
      (do* ((arglist (cddr call) (cdr arglist))
            (item (car arglist) (car arglist))
            (result nil))
           ((null arglist) (nreverse result))
        (cond ((register-p item)            ; register argument??
               (unless (eq item :d0)
                 (setq register-args t))
               (setq arglist (cdr arglist))
               (check-trap-arg (car arglist))
               (push (cons (car arglist) item) result))
              ((consp item)                 ; stack arg with a type
               (setq stack-args t)
               (check-trap-arg (car item))
               (find-arg-mactype (cadr item))
               (push (cons (car item) (cadr item)) result))
              (t                            ; untyped stack arg - must name a passed arg
               (setq stack-args t)
               (let ((arg (assoc item processed-args)))
                 (unless arg
                   (error "No mactype specified for trap call argument ~s" item))
                 (push arg result)))))))
    (cond ((null return))
          ((consp (car return))
           (setq multiple-return t))
          ((eq (car return) :stack)
           (setq stack-return t))
          (t
           (setq register-return t)))
    `(,(cond ((and (not multiple-return) (not register-args) (not register-return))
              :stack-trap)
             ((and (not multiple-return) (not stack-args) (not stack-return))
              :register-trap)
             (t :general-trap))
      ,(second call)
      ,@call-args)))


(defun check-trap-arg (arg)
  (or (symbolp arg) (numberp arg) (consp arg)
      (report-bad-arg arg '(or symbol number cons))))

(defun process-trap-return (return)
  (when return
    (let ((place (car return)))
      (unless (or (eq place :stack)
                  (register-p place))
        (%badarg place 'return-specifier))
      (find-arg-mactype (cadr return))
      (cons (car return) (cadr return))))) ; make it a simple cons

; Returns three values:
; 1) args-without-modifiers
; 2) the modifiers (a fixnum)
; 3) check-error
;#+ignore
(defun parse-trap-args-modifiers (args &aux check-error (modifiers 0) modifier-suffix)
  (while (memq (car args) '(:check-error :errchk :error-check :immed :newhfs
	 :async :clear :sys :marks :case :new :os :tool :newtool :newos))
    (let* ((arg (pop args))
           (weight (cdr (assq arg '((:immed . #x0200) (:async . #x0400) 
                                    (:clear . #x0200) (:sys . #x0400)
                                    (:marks . #x0200) (:case . #x0400)
                                    (:new . #x0200) 
                                    (:os . #x0000) (:newOS . #x0200)
                                    (:tool . #x0400) (:newTool . #x0600)
                                    (:newhfs . #x0200))))))
      (if weight
        (progn
          (setq modifiers (logior modifiers weight))
          (if modifier-suffix
            (unless (eq modifier-suffix arg)
              (if (or (and (eq modifier-suffix :clear)
                           (eq arg :sys))
                      (and (eq modifier-suffix :sys)
                           (eq arg :clear)))
                (setq modifier-suffix :sysclear)
                (setq modifier-suffix :none)))
            (setq modifier-suffix
                  (or (cdr (assq arg '((:immed . :sync) (:async . :async)
                                       (:clear . :clear) (:sys . :sys))))
                      :none))))
        (setq check-error t))))
  (values args modifiers check-error (unless (eq modifier-suffix :none) modifier-suffix)))

  
(defmacro expand-trap (&whole whole &environment env &rest args)
  (expand-trap-internal whole env args))


; args is alternating mactypes and argument forms.
; canonical-types is a list of mactypes.
; Returns two arguments:
; 1) The args to be passed on to expand-ff-trap
; 2) A wrapper-function that will wrap initialization code around
;    The result of expand-ff-trap, or NIL if this is unnecessary.
;
; The basic idea is to generate:
;
; (%stack-block ((temp-space n))
;   (let (var1 ... varn)
;     ...
;     (setq vari formj)     ; doesn't need coercion
;     ...
;     (setf (%get-xxx temp-space x) (decode-function formk))   ; does need coercion
;     ...
;     (#_trap ... vari ... (encode-function (%get-xxx temp-space y)) ...)))
;
; 
; For example: (#_SetRectRgn :ptr rgn :long tl :long br) expands into:
;
; (%stack-block ((temp-space 8))
;    (let (rgn-temp)
;      (setq rgn-temp rgn)
;      (setf (%get-long temp-space 0) tl)
;      (setf (%get-long temp-space 4) br)
;      (#_SetRectRgn rgn-temp
;                    (%get-word temp-space 0) (%get-word temp-space 2)
;                    (%get-word temp-space 4) (%get-word temp-space 6)))
;
;
; That's the general idea. In reality, we intersperse the stores into
; the temp-space with dynamic-extent let bindings to prevent consing macptrs.
;
(defun translate-explicit-mactypes (args canonical-types return-type)
  (let (stack-block-size
        (need-stack-block? nil)
        (stack-block-var (gensym))
        output-ptr input-ptr
        (let-vars nil)
        (initialization-forms nil)
        (output-args nil)
        (size-diff 0)
        (arg-sizes nil)
        (arg-mactypes nil)
        (arg-forms nil)
        original-arg-forms
        (canonical-sizes nil)
        (canonical-mactypes nil)
        (new-return-type return-type))
    (loop
      (when (null args) (return))
      (let* ((arg-type (pop args))
             (arg-form (if args
                         (pop args)
                         ; End of args means that arg-type is the return type
                         (progn
                           (unless (cond ((null arg-type) (null return-type))
                                         ((null return-type) (null arg-type))
                                         (t (eql (mactype-stack-size (find-mactype arg-type))
                                                 (mactype-stack-size (find-mactype return-type)))))
                             (error "Explicitly specified return type of ~s~%~
                                    is not compatible with trap specified return type of ~s"
                                    arg-type return-type))
                           (setq new-return-type arg-type)
                           (return))))
             (arg-mactype (find-mactype arg-type)))
        (push arg-mactype arg-mactypes)
        (push (mactype-record-size arg-mactype) arg-sizes)
        (push arg-form arg-forms)))
    (dolist (type canonical-types)
      (let ((mactype (find-mactype type)))
        (push mactype canonical-mactypes)
        (push (mactype-record-size mactype) canonical-sizes)))
    (setq arg-sizes (nreverse arg-sizes)
          arg-mactypes (nreverse arg-mactypes)
          arg-forms (nreverse arg-forms)
          original-arg-forms arg-forms
          canonical-sizes (nreverse canonical-sizes)
          canonical-mactypes (nreverse canonical-mactypes))
    ; Could do one more pass to minimize stack-block-size, but it's not worth it.
    (setq stack-block-size (reduce '+ arg-sizes)
          input-ptr stack-block-size
          output-ptr stack-block-size)
    (unless (eql stack-block-size (reduce '+ canonical-sizes))
      (error "Explicit mactypes specify wrong number of bytes"))
    ; The args are parsed and we've got a byte match. Generate some code
    (flet ((mactype-equiv (m1 m2)
             (or (eq m1 m2)
                 ; Maybe signed and unsigned word, byte & long should be equivalent
                 (let ((equiv-class (load-time-value (list (find-mactype :ptr) (find-mactype :handle)))))
                   (and (memq m1 equiv-class)
                        (memq m2 equiv-class))))))
      (loop
        (cond ((and (null arg-sizes) (null canonical-sizes))
               (assert (eql size-diff 0))
               (return))
              ((and (eql size-diff 0) (mactype-equiv (car arg-mactypes) (car canonical-mactypes)))
               ; Same mactype and same byte ofset. Can just copy this parameter.
               (let ((var (gensym)))
                 (push var let-vars)
                 (push `(setq ,var ,(pop arg-forms)) initialization-forms)
                 (push var output-args)
                 (pop arg-sizes)
                 (pop arg-mactypes)
                 (pop canonical-sizes)
                 (pop canonical-mactypes)))
              (t (let ((target-size (car canonical-sizes)))
                   (setq need-stack-block? t)
                   ; accumulate args until we've got enough bytes for the next canonical arg
                   (loop
                     (let* ((size (pop arg-sizes))
                            (mactype (pop arg-mactypes))
                            (form (pop arg-forms))
                            (encoder (mactype-encode-expand mactype))
                            (accessor (mactype-access-operator mactype)))
                       (push `(setf (,accessor ,stack-block-var ,(decf input-ptr size))
                                    ,(funcall encoder form))
                             initialization-forms)
                       (incf size-diff size)
                       (when (>= size-diff target-size) (return))))
                   ; access canonical args until we need some more args
                   (loop
                     (let* ((size (pop canonical-sizes))
                            (mactype (pop canonical-mactypes))
                            (decoder (mactype-decode-expand mactype))
                            (accessor (mactype-access-operator mactype)))
                       (push (funcall decoder `(,accessor ,stack-block-var ,(decf output-ptr size)))
                             output-args)
                       (decf size-diff size)
                       (when (or (null canonical-sizes)
                                 (< size-diff (car canonical-sizes)))
                         (return)))))))))
    (setq let-vars (nreverse let-vars)
          initialization-forms (nreverse initialization-forms)
          output-args (nreverse output-args))
    (if (not need-stack-block?)
      (values original-arg-forms nil new-return-type)
      ; to prevent consing macptrs, instead of LETting all the vars at
      ; once and then SETQing them, we'll let bind them as we go with dynamic-extent
      (let ((lets-and-forms nil)
            (lets nil)
            (forms nil))
        (dolist (form initialization-forms)
          (if (eq (car form) 'setq)
            (progn
              (when forms
                (push (cons (nreverse lets) (nreverse forms)) lets-and-forms)
                (setq lets nil forms nil))
              (push (cdr form) lets))
            (push form forms)))
        (push (cons (nreverse lets) (nreverse forms)) lets-and-forms)
        (setq lets-and-forms (nreverse lets-and-forms))
        (values output-args
                #'(lambda (form)
                    (labels ((expand (lets-and-forms form)
                               (if (null lets-and-forms)
                                 form
                                 (let* ((lets.forms (car lets-and-forms))
                                        (lets (car lets.forms))
                                        (forms (cdr lets.forms)))
                                   `(,(if lets 'let* 'progn)
                                     ,@(when lets
                                         `(,lets
                                           (declare (dynamic-extent ,@(mapcar 'car lets)))))
                                     ,@forms
                                     ,(expand (cdr lets-and-forms) form))))))
                      `(%stack-block ((,stack-block-var ,stack-block-size))
                         ,(expand lets-and-forms form))))
                new-return-type)))))

(defun trap-string-and-library (name &optional dont-lookup)
  (multiple-value-bind (trap-string library-name) (trap-string name dont-lookup)
    (values trap-string
            (and library-name (get-shared-library-descriptor library-name)))))


(defun expand-trap-internal (whole env args &aux name check-error modifiers modifier-suffix)
  (block expand-trap
    (setq name (car whole))
    (let ((trap (find-trap name))
          (ppc-p (and (ppc-target-p)
                      ; kluge until we can load make-load-form's in level-0 fasl files.
                      (or (null *compile-file-truename*)
                          (not (member "level-0" (pathname-directory *compile-file-truename*)
                                       :test 'equalp))))))
      (flet ((no-slep-warning (string)
               (if nil ;(not (osx-p))
                 (warn "While expanding: ~:w~%Can't find shared library entry for ~s, using trap emulator (will crash if OSX native)"
                       whole string)
                 (error "While expanding: ~:w~%Can't find shared library entry for ~s. Trap emulator does not work OSX native"
                        whole string))))
               
        (declare (inline no-slep-warning))
        (when (or (integerp trap) (listp trap))
          (when (and *compile-file-truename*
                     (member "level-0" (pathname-directory *compile-file-truename*)
                                       :test 'equalp))
            (Warn "We are doing something abysmally stupid here (using trap emulator) which means that one cannot use this stuff under OSX"))
          (when ppc-p
            (multiple-value-bind (string library) (trap-string-and-library name)
              (when string
                (let (slep)
                  (declare (ignore-if-unused slep))
                  (if (setq slep (get-shared-library-entry-point string library nil t))
                    (progn
                      (when (and nil #|(not (osx-p))|# (eq (interfacelib-sld) (slep.sld slep)))
                        (warn "While expanding: ~:w~% ~s, is in InterfaceLib. Won't work OSX native."
                              whole string))
                      (return-from expand-trap (expand-simple-trap name trap args env string library)))
                    (no-slep-warning string))))))
          (return-from expand-trap (expand-simple-trap name trap args env)))
        (multiple-value-setq (args modifiers check-error modifier-suffix) (parse-trap-args-modifiers args))
        (when (and ppc-p (not (eql modifiers 0)))
          (when modifier-suffix
            (let ((real-trap (intern (concatenate 'string (string name) (string-upcase modifier-suffix))
                                     (symbol-package name))))
              (when (ignore-errors (load-trap real-trap))
                (when check-error (push :errchk args))
                (return-from expand-trap-internal
                  (macroexpand-1 `(,real-trap ,@args) env))))))
        (let* ((these-trap-args (trap-args trap))
               (implementation (copy-tree (trap-implementation trap)))
               (call (trap-call trap))
               (call-args (cddr call)))
          (when ppc-p
            (if (not (eql modifiers 0))     ; support modifiers later
              (if nil ;(not (osx-p))
                (warn "Unrecognized modifiers for PPC. Using trap emulator.~%  ~s" whole)
                (error "Unrecognized modifiers for PPC. no work on OSX.~%  ~s" whole))
              (multiple-value-bind (string library) (trap-string-and-library name)
                (let ((these-trap-args (mapcar #'(lambda (x)
                                                   (if (and (listp x) (atom (cdr x)))
                                                     (list (car x) (cdr x))
                                                     x))
                                               these-trap-args))
                      (wrapper-function nil)
                      (dont-emulate (and (listp call)
                                         (eq (car call) :no-trap)
                                         (eq (cadr call) :dont-emulate))))
                  (flet ((cant-translate-mactypes-warning ()
                           (if nil ;(not (osx-p))
                             (warn "Can't translate explicit mactypes, using trap emulator")
                             (error "Can't translate explicit mactypes, No work on OSX"))))
                    (when string 
                      (if (or *dont-use-cfm* (get-shared-library-entry-point string library dont-emulate (not dont-emulate)))  ;; <<
                        (if (find-if #'register-p args)
                          (cant-translate-mactypes-warning)
                          (let ((return-type (cdr (trap-return trap))))
                            (when (find-if #'fast-mactype-p args)
                              (multiple-value-setq (args wrapper-function return-type)
                                (translate-explicit-mactypes args (mapcar 'second these-trap-args) return-type)))
                            (when check-error (push :errchk args))
                            (let ((expansion (expand-ff-trap
                                              name args '(0) these-trap-args return-type t string library env)))
                              (return-from expand-trap
                                (if wrapper-function
                                  (funcall wrapper-function expansion)
                                  expansion)))))
                        (no-slep-warning string))))))))
          (case (car call)
            (:no-trap)
            (:general-trap
             (when (or (find-if #'register-p args)
                       (find-if #'fast-mactype-p args))
               (error "Trap: ~s cannot be called with explicit types or registers."
                      name)))
            (:undefined-trap
             (error "The deftrap of ~s is incomplete. Make this call with the low-level interface"
                    trap))
            (:register-trap
             (when (find-if #'register-p args) ; explicit registers in call
               (when (and (oddp (length args))   ; this should be better
                          (register-p (car (last args))))
                 (setq args (nbutlast args 1)))
               (flet ((explicit-register-error 
                          ()
                        (error "Explicit registers: ~s not compatible with: ~s in trap ~s."
                               args call-args name)))
                 ; the basic idea here is to rearrange the args in the correct order
                 ; making sure that everything is accounted for. We find the register in
                 ; call-args and then find the matching argument in these-trap-args and re-arrange
                 ; the order of call-args!
                 (unless (and (null implementation)
                              (= (length call-args) (length these-trap-args)))
                   (error "Trap: ~s cannot be called with explicit registers" name))
                 (do* ((arglist args (cdr arglist))
                       (arg (car arglist) (car arglist))
                       (new-args (make-array (length these-trap-args) :initial-element nil)))
                      ((null arglist)
                       (when (find-if #'null new-args)
                         (explicit-register-error))
                       (setq args (coerce new-args 'list)))
                   (declare (dynamic-extent new-args))
                   (unless (register-p arg)
                     (error "You must specify all or no registers: ~s" args))
                   (let ((the-call-arg (find-if #'(lambda (pair) (eq (cdr pair) arg)) call-args)))
                     (unless the-call-arg
                       (explicit-register-error))
                     (let ((pos (position-if #'(lambda (pair) (eq (car the-call-arg) (car pair)))
                                             these-trap-args)))
                       (unless (and pos (null (svref new-args pos)))
                         (explicit-register-error))
                       (pop arglist)
                       (setf (svref new-args pos)
                             (car arglist))))))))
            (:stack-trap
             (when check-error
               (error (check-error-not-allowed-message) whole))
             (when (find-if #'fast-mactype-p args)    ; explicitly typed args
               ;; alanr get rid of return value
               (when (and (oddp (length args))   ; this should check the stack-sizes
                          (fast-mactype-p (car (last args))))
                 (setq args (nbutlast args 1)))
               (flet ((explicit-discipline-error
                          ()
                        (error "Explicit discipline: ~s not compatible with: ~s in trap ~s."
                               args (mapcar #'cdr these-trap-args) name)))
                 (do* ((arglist args (cdr arglist))
                       (arg (car arglist) (car arglist))
                       (trap-arglist these-trap-args)
                       (balance 0)           ; this is the running balance of bytes
                       (new-trap-args nil)
                       (new-args nil)
                       (new-call-args (cddr call))
                       (replaced nil)
                       (replacers nil))
                      ((null arglist) 
                       (progn (unless (zerop balance)
                                (explicit-discipline-error))
                              (setq these-trap-args (append (nreverse new-trap-args) trap-arglist)
                                    args (nreverse new-args)
                                    call (nconc (list (car call) (cadr call)) new-call-args))))
                   (cond
                    ((fast-mactype-p arg)     ; found a typed arg
                     (pop arglist)            ; eat the following symbol (the real arg)
                     (setq arg (cons (gensym) arg))   ; make a (arg . type) thingy
                     (push arg new-trap-args)
                     (push arg replacers) ; this is going to replace something in call-args
                     (push (car arglist) new-args)
                     (incf balance (mactype-stack-size (find-arg-mactype (cdr arg))))
                     (let ((trap-arg-size 0))   ; figure out what needs to be replaced...
                       (loop
                         (when (null trap-arglist) (return))
                         (setq trap-arg-size (mactype-stack-size 
                                              (find-arg-mactype (cdar trap-arglist))))
                         (when (> trap-arg-size balance) (return))
                         (push (pop trap-arglist) replaced)
                         (decf balance trap-arg-size)))
                     (when (zerop balance) ; got an exact replacement... Do it!
                       (setq replaced (nreverse replaced)
                             replacers (nreverse replacers))
                       (let ((index (search replaced new-call-args :key #'car)))
                         (unless index
                           (explicit-discipline-error))
                         (setf new-call-args 
                               (nconc (subseq new-call-args 0 index)
                                      replacers
                                      (subseq new-call-args
                                              (+ index (length replaced))))))
                       (setq replacers nil
                             replaced nil)))
                    ((not (zerop balance))  ; if there's a balance but no typed arg it's an error
                     (explicit-discipline-error))
                    (t
                     (unless (null trap-arglist)
                       (push (pop trap-arglist) new-trap-args))
                     (push arg new-args))))))))
          
          ; At this point we have the calling args in args & the trap args (possibly messed
          ; with in the explicit type code) in these-trap-args
          (check-trap-argcnt (length these-trap-args) name args)
          (let* ((constants-checked
                  (mapcar #'(lambda (arg trap-arg &aux ct-check)
                              (if (and (constantp arg)
                                       (setq ct-check
                                             (mactype-ct-type-check 
                                              (find-arg-mactype (cdr trap-arg)))))
                                (if (funcall ct-check (eval arg))
                                  t
                                  (error "Argument ~s (~s) to trap ~a is not of type ~s"
                                         arg (car trap-arg) name (cdr trap-arg)))
                                nil))
                          args these-trap-args))
                 (let-code
                  (mapcar #'(lambda (trap-arg arg)
                              `(,(car trap-arg)
                                ,(funcall (mactype-encode-expand 
                                           (find-arg-mactype (cdr trap-arg)))
                                          arg)))
                          these-trap-args args))
                 (rt-type-check-code 
                  (expand-trap-rt-type-check constants-checked these-trap-args env))
                 (call-code (expand-trap-call call (trap-return trap) check-error modifiers))
                 (can-use-dynamic-extent (null implementation))
                 (call-code-prefix-length (max 0 (- (length call-code) (length args))))
                 (dont-need-let (and can-use-dynamic-extent
                                     (null rt-type-check-code)
                                     (memq (car call-code) '(%stack-trap %register-trap))
                                     (do ((calls (nthcdr call-code-prefix-length call-code) (cdr calls))
                                          (args these-trap-args (cdr args)))
                                         ((or (null calls) (null args))
                                          (and (null calls) (null args)))
                                       (unless (eq (car calls) (caar args)) (return nil))))))
            (if dont-need-let
              (progn (setf (nthcdr call-code-prefix-length call-code) (mapcar 'cadr let-code))
                     call-code)
              (progn
                (when (null implementation)
                  (setq implementation (list :call)))
                `(let ,let-code
                   ,@(if can-use-dynamic-extent
                       `((declare (dynamic-extent ,@(mapcar 'car let-code)))))
                   ,@rt-type-check-code
                   ,@(nsubst call-code :call implementation))))))))))


(defun check-trap-argcnt (argcnt name args)
  (unless (= (length args) argcnt)
    (error "Wrong number of arguments (~d/~d) to trap ~a" (length args) argcnt name)))


(defvar *type-check-trap-p*
  #'(lambda (env)
      (declare (special %excised-code%))
      (let (#+ppc-target(f (fboundp 'safety-optimize-quantity)))
        (or #+ppc-target (not f)
            #+ppc-target (eq (uvref f 0) %excised-code%)
            (>= (safety-optimize-quantity env) 3)))))

(defun *type-check-trap-p* (env)
  (let ((f *type-check-trap-p*))
          (if (functionp f) (funcall f env) f)))


(defun expand-trap-rt-type-check (constants-checked these-trap-args env)
  (when (*type-check-trap-p* env)
    (mapcan #'(lambda (checked arg)
                (unless checked
                  (let* ((check-expand (mactype-type-check-expand 
                                        (find-arg-mactype (cdr arg)))))
                    (when check-expand
                      `((setq ,(car arg) ,(funcall check-expand (car arg))))))))
            constants-checked these-trap-args)))

;#+ignore
(defun expand-trap-call (call return check-error modifiers &optional (decode-return-p return)
                              &aux (these-trap-args (cddr call)))
  (cond 
   ((eq (car call) :general-trap)
    (expand-general-trap-call call return check-error modifiers))
   (t
    (let ((decode (if decode-return-p
                    (mactype-decode-expand (find-arg-mactype (cdr return)))
                    #'identity))
          (call-code 0)
          (current-bit 0)
          (call-vars))
      (funcall decode
               (ecase (car call)
                 (:no-trap 
                  (let ((form (cadr call)))
                    (if (eq form :dont-emulate)
                      '(cant-emulate)
                      form)))
                 (:register-trap
                  (dolist (call-arg these-trap-args)
                    (push (car call-arg) call-vars)
                    (incf call-code (lsh (cdr (assoc (cdr call-arg) 
                                                     *register-arg-codes*))
                                         current-bit))
                    (incf current-bit *register-code-width*))
                  (when return
                    (incf call-code (lsh (cdr (assoc (car return) 
                                                     *register-return-codes*))
                                         current-bit)))
                  (incf current-bit (1+ *register-code-width*))
                  (when check-error
                    (incf call-code (lsh 1 current-bit)))
                  (incf current-bit)
                  (let ((return-type (find-mactype (cdr return) nil nil)))
                    (when return-type
                      (cond ((eq return-type (find-mactype :unsigned-integer))
                             (incf call-code (lsh 1 current-bit)))
                            ((eq return-type (find-mactype :signed-integer))
                             (incf call-code (lsh 3 current-bit))))))
                  (let ((trapnum (cadr call)))
                    (when (neq 0 modifiers) (setq trapnum `(logior ,modifiers ,trapnum)))
                  `(%register-trap ,trapnum ,call-code ,@(nreverse call-vars))))
                 (:stack-trap
                  (when check-error
                    (error "Error code checking not allowed for stack traps: ~S"
                           call))
                  (dolist (call-arg these-trap-args)
                    (push (car call-arg) call-vars)
                    (incf call-code (lsh (if (eq (cdr call-arg) :d0) ; hack for :d0
                                           *d0-stack-arg-code*
                                           (mactype-stack-arg-code
                                            (find-arg-mactype (cdr call-arg))))
                                         current-bit))
                    (incf current-bit *stack-code-width*))
                  (when return
                    (incf call-code (lsh (mactype-stack-return-code 
                                          (find-arg-mactype (cdr return)))
                                         current-bit)))
                  (incf current-bit (1+ *stack-code-width*))
                  (when check-error
                    (incf call-code (lsh 1 current-bit)))
                  `(%stack-trap ,(cadr call) ,call-code ,@(nreverse call-vars)))))))))


;#+ignore
(defun expand-general-trap-call (call return check-error modifiers)
  (declare (ignore check-error))
  (let* ((call-list nil)
         (trap-num (if (neq modifiers 0) `(logior ,modifiers ,(cadr call)) (cadr call))))
    (dolist (call-arg (cddr call))
      (let ((type (find-arg-mactype (cdr call-arg) nil)))
        (push (if type 
                (mactype-ff-type type)
                (cdr call-arg))
              call-list))
      (push (car call-arg) call-list))
    (cond 
     ((null return)
      `(%gen-trap ,trap-num ,@(nreverse call-list)))
     ((consp (car return))              ; multiple values returned
      (let ((stack-size 0)
            (extractors nil)
            (return-list)
            (from-stack nil)
            (ret-block-sym (gensym)))
        (dolist (return-spec return)
          (cond
           ((eq (car return-spec) :stack)
            (when from-stack
              (error "Can only return one value from the stack"))
            (setq from-stack t)
            (let ((mactype (find-arg-mactype (cdr return-spec))))
              (push (funcall (mactype-decode-expand mactype)
                             (list (mactype-access-operator mactype)
                                      ret-block-sym stack-size))
                    extractors)
              (incf stack-size (mactype-stack-size mactype))
              (push (mactype-ff-type mactype) return-list)))
           (t
            (let ((register (car return-spec))
                  (mactype (find-arg-mactype (cdr return-spec))))
              (unless (register-p register)
                (error "Illegal trap return specification ~s" return))
              (push (funcall (mactype-decode-expand mactype) 
                             (list (mactype-access-operator mactype)
                                      ret-block-sym stack-size))
                    extractors)
              (incf stack-size 4)
              (push register return-list)))))
        (push :return-block call-list)
        (push ret-block-sym call-list)
        (push `(quote ,(nreverse return-list)) call-list)
        `(%stack-block ((,ret-block-sym ,stack-size))
           (%gen-trap ,trap-num ,@(nreverse call-list))
           (values ,@(nreverse extractors)))))
     (t
      `(%gen-trap ,trap-num ,@(nreverse call-list)
                  ,(if (eq (car return) :stack)
                     (mactype-ff-type (find-arg-mactype (cdr return)))
                     (car return)))))))
;;;;;;
;;
;; Special require & provide for traps so all the interface file names
;; don't need to be in the REQUIRE/PROVIDE namespace
;;
; This is a macro so that the trap files can omit the eval-when
(defmacro require-interface (name)
  `(eval-when (eval compile load)
     (%require-interface ,name)))



(defun %require-interface (name)
  (if (symbolp name)(setq name (string name)))
  (when (%str-member #\/ name)
    (setq name (posix-name-to-mac-relative-name name))
    )
  (let* ((path (pathname name))
         (path-name (pathname-name path)))
    (unless (member path-name *interfaces* :test #'string-equal) ;; #'equal?
      (push path-name *interfaces*)
      (let ((fullname  (merge-pathnames (concatenate 'string path-name ".lisp") *traps-directory*)))
        (if (not (probe-file fullname))
          (warn "File ~S does not exist" fullname)
          (load fullname))))
    path-name))

(defun posix-name-to-mac-relative-name (name)
  (if (position #\/ name)
    (let* ((res (substitute #\; #\/ name))
           (len (length res))
           (dot-pos (position #\. res)))
      (when (and dot-pos (< dot-pos (- len 3)))
        (when (eq (schar res (1+ dot-pos)) #\.)
          (setf (schar res dot-pos) #\*)
          (setf (schar res (1+ dot-pos)) #\*)))
      res)
    name))

(defun posix-name-to-mac-absolute-name (name)
  (let ((pos (position #\/ name :from-end t)))
    (if pos
      (ccl::%substr name (1+ pos) (length name))
      name)))
  

(defun provide-interface (name)
  (let ((name (string name)))
    (when (%str-member #\/ name)
      (setq name (posix-name-to-mac-relative-name name)))
    (let ((path-name (pathname-name name)))
      (unless (member path-name *interfaces* :test #'string-equal) ;; maybe should be #'equal
        (push path-name  *interfaces*))
      path-name)))

;;;;;;;
;;
;; Support #_ and #$
;;
(defparameter *traps-directory* "ccl:interfaces;")
(defparameter *traps-directory-lisp-pathname* "ccl:interfaces;*.lisp")
(defparameter *traps-index-directory* "ccl:interfaces;index;")
(defparameter *traps-index-file* "ccl:interfaces;index;traps.idx")
(defparameter *records-index-file* "ccl:interfaces;index;records.idx")
(defparameter *constants-index-file* "ccl:interfaces;index;constants.idx")
(defparameter *mactypes-index-file* "ccl:interfaces;index;mactypes.idx")

(defvar *error-traps* nil)
(defvar *non-simple-traps* nil)
(defvar *no-trap-traps* nil)

(defun reparse-index-file (filename alist &optional dotted-value-p)
  (let ((hash (make-hash-table :test 'equalp))
        (string (make-array 100 :fill-pointer 0 :adjustable t :element-type 'character))
        new-alist)
    (dolist (entry alist)
      (let ((name (car entry)))
        (when (symbolp name) (setq name (symbol-name name)))
        (unless (stringp name) (setq name (require-type name 'string)))
        (setf (gethash name hash) t)))
    (with-open-file (stream filename :element-type 'base-character)
      ; Check for validity and position stream after directory.
      (index-file-p stream t)
      (multiple-value-bind (reader arg) (stream-reader stream)
        (loop
          (when (stream-eofp stream) (return))
          (let (name char)
            (setf (fill-pointer string) 0)
            (loop
              (setq char (funcall reader arg))
              (when (or (null char) (char-eolp char)) (return))
              (vector-push-extend char string))
            (setq name (copy-seq string))
            (if (gethash name hash)
              (skip-past-double-newline stream reader arg)
              (progn
                (setf (fill-pointer string) 0)
                (loop
                  (setq char (funcall reader arg))
                  (when (null char) (return))
                  (when (char-eolp char)
                    (setq char (funcall reader arg))
                    (if (or (null char) (char-eolp char)) (return))
                    (vector-push-extend #\return string))
                  (vector-push-extend char string))
                (push (if dotted-value-p
                        (list name (copy-seq string))
                        (cons name (copy-seq string)))
                      new-alist)))))))
    (nreconc new-alist alist)))

; Valid values for :which keyword
;   nil        the default. Parse all definitions
;   :traps     parse only trap definitions
;   :no-traps  parse only non-trap definitions (constants, mactypes, records)
;
; Valid values for :files keyword
;   nil        the default. Parse all files in "ccl:interfaces;*.lisp"
;   T          Parse all files that are newer than the oldest index file.
;   string     same as (list string)
;   list       parse all files in the list. Wildcards are allowed.
;              The directory defaults to "ccl:interfaces;".
;              The file type defaults to ".lisp".
(defun reindex-interfaces (&key which (files nil files-p))
  (create-directory *traps-index-directory* :if-exists nil)
  (let ((*read-default-float-format* 'double-float)  ;; there is 1.0e150 in some interface file
        traps records constants mactypes file-traps)
    ;(set-fpu-mode :overflow nil)  ;; why needed ???
    (if files-p
      (if (eq files t)
        (let ((date (or (ignore-errors
                         (apply 'min (mapcar 'file-write-date
                                             (list *traps-index-file*
                                                   *constants-index-file*
                                                   *mactypes-index-file*
                                                   *records-index-file*))))
                        0))
              new-files)
          (dolist (file (directory *traps-directory-lisp-pathname* :resolve-aliases t))
            (when (> (file-write-date file) date)
              (push file new-files)))
          (setq files (nreverse new-files)))
        (let ((res nil))
          (unless (listp files) (setq files (list files)))
          (dolist (file files)
            (let ((dir (directory (merge-pathnames file *traps-directory-lisp-pathname*)
                                  :resolve-aliases t)))
              (unless dir (cerror "Continue."
                                  "No files match ~s" file))
              (setq res (nconc res dir))))
          (setq files res)))
      (setq files (directory *traps-directory-lisp-pathname* :resolve-aliases t)))
    (unless files (return-from reindex-interfaces nil))
    (flet ((close-index-stream (sym)
             (let ((stream (symbol-value sym)))
               (when stream (close stream))
               (set sym nil))))
      (flet ((save-index-file (name entries index-file index-stream-var &optional dotted-value-p value-writer)
               (cond ((and files-p (null entries))
                      (format t "~&No new ~a definitions" name)
                      (set-file-write-date index-file (get-universal-time)))
                     (t (close-index-stream index-stream-var)
                        (when files-p
                          (format t "~&Parsing old ~a index" name)
                          (setq entries (reparse-index-file index-file entries dotted-value-p)))
                        (format t "~&Saving ~a index" name)
                        (close-index-stream index-stream-var)
                        (make-index-file index-file entries dotted-value-p value-writer)))
               entries))

        (unless (eq which :traps)
          (dolist (file files)
            (let ((string (pathname-name file)))
              (format t "~&Parsing \"~a~a.lisp\"" *traps-directory* string)
              (multiple-value-setq (traps records constants mactypes)
                (parse-traps-file
                 file string traps records constants mactypes :no-traps))))
          
          (save-index-file "records" records  *records-index-file* '*records-index-stream*)
          (save-index-file "constants" constants  *constants-index-file* '*constants-index-stream* t)
          (save-index-file "mactypes" mactypes  *mactypes-index-file* '*mactypes-index-stream*))
          
        ; We parse the files a second time to save space.
        ; Small machines won't be able to store the source for all
        ; 1600+ traps in memory at one time. well its more like 14000+ traps
        (unless (eq which :no-traps)
          (close-index-stream '*traps-index-stream*)
          (format t "~&Evaluating traps")
          (let ((simple-count 0)
                (count 0)
                non-simple-traps error-traps no-trap-traps)
            (dolist (file files)
              (let ((string (pathname-name file)))
                (format t "~&Parsing \"~a~a.lisp\"" *traps-directory* string)
                (setq file-traps (parse-traps-file file string nil nil nil nil :traps)))
              (do* ((the-traps file-traps (cdr the-traps))
                    (trap))
                   ((null the-traps))
                (incf count)
                (setq trap (car the-traps))
                (when (listp (car trap))
                  (unless (memq (caar trap) '(deftrap deftrap-inline))
                    (error "Inconsistency."))
                  (multiple-value-bind (name def args errorp no-trap-p trap-string)
                                       (eval-deftrap-for-indexing (car trap))
                    (if def
                      (progn
                        ; This trap was encoded "simply"
                        (setf (car the-traps) `(,name ,(cdr trap) ,def ,trap-string ,@args))
                        (incf simple-count))
                      (progn
                        (if errorp
                          (push (list name (read-line (make-string-input-stream (cdr trap))))
                                error-traps)
                          (push name non-simple-traps))
                        (if no-trap-p (push name no-trap-traps))
                        (setf (car trap) name))))))
              (setq traps (nconc file-traps traps)))
            (format t "~&~d traps indexed.~%~d simple traps.~%" count simple-count)
            (labels ((sort-key (x) (if (atom x) x (car x)))
                     (sort-key-of-car (x) (sort-key (car x))))
              (declare (dynamic-extent #'sort-key #'sort-key-of-car))
              (when non-simple-traps
                (setq *non-simple-traps* (sort non-simple-traps #'string-lessp :key #'sort-key))
                (format t "~&~d ~a~%"
                        (length *non-simple-traps*) '*non-simple-traps*)
                (when no-trap-traps
                  (setq *no-trap-traps* (sort no-trap-traps #'string-lessp :key #'sort-key))
                  (format t "~&~d ~a~%" (length *no-trap-traps*) '*no-trap-traps*)))
              (when error-traps
                (setq *error-traps* (sort error-traps #'string-lessp :key #'sort-key-of-car))
                (format t "~&~d ~a~%" (length *error-traps*) '*error-traps*))))
          
          (save-index-file "traps" traps  *traps-index-file* '*traps-index-stream* nil
                           #'(lambda (stream value)
                               (if (listp value)    ; "simple" trap
                                 (let ((*package* *traps-package*)
                                       (*print-base* 10.))
                                   ; value = ("file~%pos" (trap-num . trap) trap-string . args)
                                   (destructuring-bind (name (trap-num . trap) trap-string . args) value
                                     (write-string name stream)
                                     (print trap-num stream)
                                     (print trap stream)
                                     (print args stream)
                                     (when trap-string
                                       (print trap-string stream))))
                                 (write-string value stream))))))))
  nil)


#|
(defun edit-trap-list (&optional (trap-list *non-simple-traps*))
  (dolist (trap trap-list)
    (when (y-or-n-p "~&Edit ~s?" trap)
      (let ((trap-def (gethash trap %traps%)))
        (unwind-protect
          (progn
            (unless trap-def
              (setf (gethash trap %traps%) (gethash (load-trap '#_newptr) %traps%)))
            (edit-definition trap))
          (unless trap-def
            (remhash trap %traps%)))))))
|#

; Returns 6 values:
; 1) name
; 2) (trapnum . trap)
; 3) arglist
; 4) error-trap-p
; 5) no-trap-trap-p
; 6) trap-string
(defun eval-deftrap-for-indexing (form)
  (let* ((string (cadr form))
         (index-string (if (listp string) (car string) string))
         (name (make-trap-symbol index-string))
         (was-defined? (macro-function name))
         (was-bound? (boundp name))
         no-trap-trap?)
    (let ((*record-source-file* nil)
          (*save-arglist-info* nil)
          (*warn-if-redefine* nil)
          (*warn-if-redefine-kernel* nil))
      (when (ignore-errors
             (destructuring-bind (deftrap name args return &rest body) form
               (declare (ignore deftrap name args return))
               (eq (caar body) :no-trap)))
        (setq no-trap-trap? t))
      (unless (ignore-errors (eval form))
        (return-from eval-deftrap-for-indexing (values index-string nil nil t)))
      (let ((trap (gethash name %traps%))
            (trapnum (and (boundp name) (symbol-value name)))
            (trap-string (gethash name %trap-strings%)))
        (unless was-defined?
          (remhash name %traps%)
          (remhash name %trap-strings%)
          (fmakunbound name))
        (unless was-bound?
          (makunbound name))
        (if (and trap (integerp trapnum) (or (integerp trap) (listp trap)))
          (values index-string (cons trapnum trap) (mapcar 'car (third form)) nil nil trap-string)
          (values index-string nil nil nil no-trap-trap?))))))

(defun parse-traps-file (file string traps records constants mactypes which)
  (loop
    (with-simple-restart (retry "Retry parsing ~s" file)
      (return
       (progn
         (with-open-file (stream file :direction :input :element-type 'base-character)
           (with-standard-io-syntax
             (unwind-protect
               (let ((*package* *traps-package*)
                     (*read-default-float-format* 'double-float)  ;; in case standard-io-syntax does otherwise
                     (*autoload-traps* nil)     ; Make sure the reader doesn't load any traps
                     (*read-base* 10.))
                 (until (eofp stream)
                   (let ((entry (format nil "~a~%~d" string (file-position stream)))
                         (form (read stream nil nil)))
                     (when (consp form)
                       (let* ((type (and (consp (cdr form)) (cadr form)))
                              (value (and (consp (cdr form)) (consp (cddr form)) (caddr form))))
                         (when (symbolp type) (setq type (symbol-name type)))
                         (unless (eq which :no-traps)
                           (case (car form)
                             (deftrap (push (cons form entry) traps))
                             #+ignore
                             (defctbtrap (push (cons type entry) traps))
                             #+interfaces-2
                             (deftrap-inline (push (cons form entry) traps))))
                         (unless (eq which :traps)
                           (case (car form)
                             ((defrecord %define-record)
                              (when (consp type)
                                (setq type (car type))
                                (when (symbolp type) (setq type (symbol-name type))))
                              (push (cons type entry) records))
                             (defconstant 
                               (push (cons type 
                                           (cons entry 
                                                 (if (and (constant-symbol-p value)
                                                          (boundp value))
                                                   (symbol-value value)
                                                   (if (self-evaluating-p value) value)))) constants))
                             (def-mactype (push (cons type entry) mactypes))))))))))))
         (values traps records constants mactypes))))))

(defvar *traps-index-stream* nil)
(defvar *constants-index-stream* nil)
(defvar *records-index-stream* nil)
(defvar *mactypes-index-stream* nil)

(eval-when (:compile-toplevel :load-toplevel :execute)

(defmacro saving-stream-position (stream &body body)
  (let ((pos-var (gensym))
        (stream-var (gensym)))
    `(let* ((,stream-var ,stream)
            (,pos-var (and (open-stream-p ,stream-var)
                           (stream-position ,stream-var))))
       (unwind-protect
         (progn ,@body)
         (when (open-stream-p ,stream-var)
           (stream-position ,stream-var ,pos-var))))))

(defmacro accessing-index-stream (index-stream &body body)
  (let ((thunk (gensym)))
    `(let ((,thunk #'(lambda () ,@body)))
       (declare (dynamic-extent ,thunk))
       (call-accessing-index-stream ,index-stream ,thunk))))

)

(defun open-index-file (file stream-var &optional (if-does-not-exist :error))
  (let ((stream (symbol-value stream-var)))
    (if (and stream (open-stream-p stream))
      stream
      (let ((new-stream (open file
                              :element-type 'base-character
                              :direction :input
                              :if-exists :overwrite
                              :if-does-not-exist if-does-not-exist)))
        (without-interrupts
         (setq stream (symbol-value stream-var))
         (if (and stream (neq stream new-stream) (open-stream-p stream))
           (progn
             (close new-stream)
             stream)
           (setf (symbol-value stream-var) new-stream)))))))

(defvar *accessing-index-stream* nil)

(defvar *index-stream-lock*
  (make-lock))

(declaim (type lock *index-stream-lock*))

(defun call-accessing-index-stream (index-stream thunk)
  (let* ((lock-value *current-process*)
         (lock *index-stream-lock*)
         (flag nil))
    (declare (type lock lock))
    (unwind-protect
      (progn
        (if (store-conditional lock nil lock-value)
          (setq flag t)
          (unless (eq (lock.value lock) lock-value)
            (process-lock lock lock-value)
            (setq flag t)))
        (handler-bind ((serious-condition
                        #'(lambda (c)
                            (declare (ignore c))
                            (when flag
                              (process-unlock lock lock-value)
                              (setq flag nil))
                            nil)))
          (if (eq index-stream *accessing-index-stream*)
            (saving-stream-position index-stream
              (funcall thunk))
            (let ((*accessing-index-stream* index-stream))
              (funcall thunk)))))
      ; unwind-protect cleanup
      (when flag
        (process-unlock lock lock-value)))))

(defun traps-file-pathname (index-stream &optional position)
  (when position
    (stream-position index-stream position))
  (merge-pathnames ".lisp" (merge-pathnames (read-line-raw index-stream t nil) *traps-directory*)))

; meta-. interface
(defun interface-definition-p (sym &optional (type t))
  (when (symbolp sym)
    (flet ((find-path (sym file stream-var)
               (let ((stream (open-index-file file stream-var nil)))
                 (accessing-index-stream stream
                   (when (and stream (search-index-stream stream sym))
                     (traps-file-pathname stream))))))
      (let* ((name (symbol-name sym))
             (other-sym (find-symbol (symbol-name sym) :traps))
             (t-type (eq type t))
             path)
        (or
         (and other-sym
              (or (and (or t-type (eq type 'function))
                       ;(gethash other-sym %traps%)
                       (setq path (find-path sym *traps-index-file* '*traps-index-stream*))
                       (return-from interface-definition-p (values path 'function)))
                  (and (or t-type (eq type 'constant))
                       (boundp other-sym)
                       (setq path (find-path sym *constants-index-file* '*constants-index-stream*))
                       (return-from interface-definition-p (values path 'constant)))))
         (and (setq other-sym (find-symbol name :keyword))
              (or (and (or t-type (eq type 'mactype))
                       ;(gethash other-sym %mactypes%)
                       (setq path (find-path sym *mactypes-index-file* '*mactypes-index-stream*))
                       (return-from interface-definition-p (values path 'mactype)))
                  (and (or t-type (eq type 'record))
                       ;(gethash other-sym %record-descriptors%)
                       (setq path (find-path sym *records-index-file* '*records-index-stream*))
                       (return-from interface-definition-p (values path 'record))))))))))

; Return 4 values: : (found value value-found key-position)
; if VALUE-IN-INDEX-P is true and there is a value in the index file.
; Otherwise, return one value: found
(defun find-interface-entry (symbol file stream value-in-index-p &optional car cadr cadr-predicate (errorp t))
  (multiple-value-bind (pos start-pos) (and stream (search-index-stream stream symbol))
    (unless pos
      (when errorp
        (cerror "Ignore the error."
                "Can't find ~s in ~s.~%Consider (~s)~:[~; or look in \"ccl:library;interfaces.lisp\"~]"
                symbol file 'reindex-interfaces (eq file *traps-index-file*)))
      (return-from find-interface-entry nil))
    (let (path position)
      (let ((*package* *traps-package*)
            (*read-base* 10.))
        
        (when value-in-index-p
          (skip-past-newline stream)
          (skip-past-newline stream)
          (unless (char-eolp (stream-peek stream))
            (return-from find-interface-entry
              (values t
                      (read stream)
                      t
                      start-pos)))
          (stream-position stream pos))
        (setq path (traps-file-pathname stream)
              position (read stream)))
      (with-open-file (s path :element-type 'base-character)
        (file-position s position)
        (let ((form (let ((*package* *traps-package*)
                          (*read-base* 10.))
                      (ignore-errors (read s)))))
          (unless (and form
                       (listp form)
                       (or (null car) 
                           (if (listp car)
                             (memq (car form) car)
                             (eq (car form) car)))
                       (or (null cadr) (and (listp (cdr form))
                                            (if cadr-predicate
                                              (funcall cadr-predicate cadr (cadr form))
                                              (eq cadr (cadr form))))))
            (error "Unexpected interface files entry.~%Was:      ~s~%Expected: (~s ~s ...)~%~
                    Consider (~s)"
                   form car cadr 'reindex-interfaces))
          (let ((*loading-file-source-file* path))
            (or (eval form) t)))))))

(eval-when (eval compile)

(defmacro interface-not-defined (type symbol)
  `(cerror "Ignore the error."
           "Failed attempt to load ~a ~s.~%Consider (~s)" ,type ,symbol 'reindex-interfaces))

)  ; end of eval-when


; Called by #_ reader-macro
; Must return the symbol.
(defun load-trap (symbol &optional reader-stream)
  (declare (ignore reader-stream))
  #| not needed no more
  (let ((acons (assq symbol *trap-synonyms*)))
    (when acons
      (setq symbol (cdr acons))))
  |#
  (unless (or (not *autoload-traps*)
              (macro-function symbol))
    (let* ((file *traps-index-file*)
           (stream (open-index-file *traps-index-file* '*traps-index-stream*)))
      (accessing-index-stream stream
        (multiple-value-bind (found value value-found string-pos)
                             (find-interface-entry symbol file stream t
                                                   '(deftrap defctbtrap #+interfaces-2 deftrap-inline)
                                                   symbol
                                                   #'(lambda (symbol trap-name)
                                                       (string-equal symbol
                                                                     (if (listp trap-name)
                                                                       (car trap-name)
                                                                       trap-name))))
          (if value-found
            ; value is trap-num, next two lines contain trap & arglist
            (let* ((stream *traps-index-stream*)
                   (trap (let ((*read-base* 10.)) (read stream)))
                   (arglist-p (or *save-arglist-info* *save-local-symbols*))
                   (arglist (let ((arglist (read stream)))
                              (and arglist-p arglist)))
                   (string (if (progn (skip-past-newline stream)
                                      (not (char-eolp (peek-char nil stream nil))))
                             (read stream)
                             (progn
                               (stream-position stream string-pos)
                               (remove-leading-underbar (read-line stream)))))
                   (*record-source-file* nil))
              (%deftrap-internal symbol value trap arglist string))
            (when (and found (not (macro-function symbol)))
              (interface-not-defined "trap" symbol)))))))
  symbol)

; Called by #$ reader-macro
; Must return the symbol.
(defun load-trap-constant (symbol &optional reader-stream)
  (declare (ignore reader-stream))
  (unless (or (not *autoload-traps*) (boundp symbol))
    (let* ((file *constants-index-file*)
           (stream (open-index-file file '*constants-index-stream*)))
      (accessing-index-stream stream
        (multiple-value-bind (found value value-found)
                             (find-interface-entry symbol file stream t 'defconstant symbol)
          (when found
            (if value-found
              ; The value was in the index file
              (let ((*record-source-file* nil))
                (%defconstant symbol value))
              (when (and found (not (boundp symbol)))
                (interface-not-defined "constant" symbol))))))))
  symbol)

; Called by find-record-descriptor if it doesn't find it in the hash table.
(defun load-record (name)
  (when *autoload-traps*
    (let* ((file *records-index-file*)
           (stream (open-index-file file '*records-index-stream*)))
      (accessing-index-stream stream
        (find-interface-entry name file stream nil
                              '(defrecord define-record %define-record)
                              name
                              #'(lambda (x y)
                                  (when (listp y) (setq y (car y)))
                                  (string-equal x y))
                              nil)))))

(defun load-mactype (name)
  (when *autoload-traps*
    (let* ((file *mactypes-index-file*)
           (stream (open-index-file file '*mactypes-index-stream*)))
      (accessing-index-stream stream
        (find-interface-entry name file stream nil 'def-mactype name #'string-equal nil)))))

(defun load-all-records ()
  (load-interface-files 'defrecord))

(defun load-all-mactypes ()
  (load-interface-files 'def-mactype))

(defun load-interface-files (&rest cars-of-forms)
  (declare (dynamic-extent cars-of-forms))
  (let ((*read-default-float-format* 'double-float))  ;; 1.0e150 
    (with-cursor *watch-cursor*
      (dolist (file (directory "ccl:interfaces;*.lisp" :resolve-aliases t))
        (with-open-file (stream file :element-type  'base-character)
          (let ((*loading-file-source-file* file)
                (*warn-if-redefine* nil)
                (*warn-if-redefine-kernel* nil))
            (loop
              (let ((form (let ((*package* *traps-package*)
                                (*read-base* 10.))
                            (read stream nil))))
                (unless form (return))
                (when (and (listp form) (memq (car form) cars-of-forms))
                  (let ((foo (ignore-errors (eval form))))
                    (when (null foo)
                      (warn "error in file ~s for (~a ~a ...)" file (car form)(cadr form)))))))))))))

#| ; not used
(defun maybe-listener-mini-buffer (stream)
  (and (or (typep stream 'listener)
           (typep stream 'string-input-stream))
       *top-listener*
       (view-mini-buffer *top-listener*)))
|#

#| - This isn't particularly useful anymore
(defun compile-traps (&optional force?)
  (dolist (f (directory "interfaces;*.lisp"))
    (let ((fasl (merge-pathnames ".fasl" f)))
      (when (or force? (not (probe-file fasl))
                (< (file-write-date fasl) (file-write-date f)))
        (compile-file f :output-file fasl :verbose t)))))
|#

#| ;; hopefully no longer used
(defmacro defctbtrap (function-name (&rest argspecs) selector &optional result-type)
  (multiple-value-bind (trap-symbol trap-string-spec) (make-trap-symbol function-name)
    (multiple-value-bind (trap-string library) (trap-string-and-library trap-string-spec t)
      (if (and (ppc-target-p)
               (get-shared-library-entry-point trap-string library nil t))
        `(deftrap ,function-name
                  ,argspecs
                  ,(and result-type `(:no-trap ,result-type))
           (:no-trap))
        (let* ((result-type-form nil)
               (result-mactype-name nil))
          (when result-type
            (setq result-type-form 
                  (case (setq result-mactype-name (mactype-name (find-mactype result-type)))
                    ((:boolean :signed-integer) '((:signed-integer :d0)))
                    (t '(:d0)))))
          (let ((accessors nil)
                (sizes nil)
                (names nil))
            (dolist (spec (reverse argspecs))
              (destructuring-bind (name type) spec
                (let* ((mactype (or (find-mactype type nil)
                                    (and (find-record-descriptor type)
                                         (find-mactype :pointer))))
                       (size (mactype-stack-size mactype)))
                  (push mactype accessors)
                  (push name names)
                  (push size sizes))))
            (let* ((pbsize (apply #'+ 2 sizes))
                   (offset pbsize)
                   (body nil))
              (dolist (name names)
                (setq offset (%i- offset (pop sizes)))
                (let* ((accessor (pop accessors))
                       (access-form `(list ',(mactype-access-operator accessor) pbname ,offset))
                       (store-coercion (mactype-store-coercion accessor)))
                  (push ``(setf ,,access-form ,,(if store-coercion `(funcall ,store-coercion ,name) name)) body)))
              (let ((trapcall `(list* 'register-trap #xA08B :a0 pbname ,@(if result-type `(',result-type-form) '(())))))
                (setq trapcall
                      (case result-mactype-name
                        ((:pointer :handle) ``(%int-to-ptr ,,trapcall))
                        (:boolean ``(logbitp 8 (the fixnum ,,trapcall)))
                        (t trapcall)))
                (push trapcall body))
              `(defmacro ,trap-symbol ,names
                 (let ((pbname (gensym)))
                   `(%stack-block ((,pbname ,,pbsize))
                      (setf (%get-word ,pbname 0) ,,selector)
                      ,,@(nreverse body)))))))))))
|#

(defun load-all-traps ()
  (dolist (f (directory "ccl:interfaces;*.lisp" :resolve-aliases t))
    (let ((foo (ignore-errors (require-interface (pathname-name f)))))
      (when (not foo)(warn "Can't load interface file ~s" (pathname-name f)))
      foo)))

; These macros are useful in macro-expansions
; (defmacro newptr-12 ()
;    `(require-trap #_newptr 12))
; Will autoload the trap at macroexpand time as well as read time.
(defmacro require-trap (trap-name &rest rest)
  (setq trap-name (require-type trap-name 'symbol))
  (load-trap trap-name)
  `(,trap-name ,@rest))

(defmacro require-trap-constant (name)
  (setq name (require-type name 'symbol))
  (load-trap-constant name)
  name)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; framework-descriptor

(def-accessor-macros %svref
  nil                                   ; 'framework-descriptor
  framework.name
  framework.findfolderargs
  framework.pathname
  framework.url)

(defun %cons-framework-descriptor (name &optional findfolderargs pathname)
  (%istruct 'framework-descriptor name findfolderargs pathname nil))

(defun framework-descriptor-p (x)
  (istruct-typep x 'framework-descriptor))




(defvar *framework-descriptors* (make-hash-table :test 'equalp))  ;; aka string-equal

;; pathname if provided should be a lisp pathname to the folder containing the framework
;; findfolder-args if provided should be a list of 2 elements the vrefnum and foldertype to pass to #_fsfindfolder
;; it is illegal to specifly both pathname and findfolder-args
;; if neither provided the default is to use (#_FSFindFolder #$kOnAppropriateDisk #$kFrameworksFolderType ...
;; if add-to is true then add pathname or findfolder-args to a list of places to look for the framework

(export 'add-framework-bundle :ccl) 

(defun add-framework-bundle (framework-name &key pathname findfolder-args add-to)
  (let (descriptor)
    (declare  (ignore-if-unused descriptor))
    (when (or pathname findfolder-args)
      (setq descriptor (make-framework-descriptor framework-name :pathname pathname :findfolder-args findfolder-args :add-to add-to)))  
    (when (not (member framework-name *bundles* :test #'(lambda (x y) (string-equal x (cdr y)))))  ;; or equal ??
           (setq *bundles*
                 (append *bundles*
                         (list (cons nil framework-name)))))))

(defun make-framework-descriptor (framework-name &key pathname findfolder-args add-to)
  (when findfolder-args
    (setq findfolder-args (canonicalize-findfolder-arg findfolder-args))    
    (when pathname (error "Can't specify both pathname and findfolder-args")))
  (when (and pathname (not (or (pathnamep pathname)(stringp pathname)))) (error "Illegal pathname ~S" pathname))
  (let ((desc (%cons-framework-descriptor framework-name findfolder-args pathname)))
    (cond ((not add-to)
           (setf (gethash framework-name *framework-descriptors*) desc))
          (t (let ((current (gethash framework-name *framework-descriptors*)))
               (setf (gethash framework-name *framework-descriptors*)
                     (if (not current) 
                       desc
                       (if (consp current) 
                         (nconc current (list desc))
                         (list current desc)))))))))

(defun remove-framework-bundle (framework-name)
  (remhash framework-name *framework-descriptors*)
  (setq *bundles* (delete framework-name *bundles* :test #'(lambda (x y) (string-equal x (cdr y)))))) 

;; redefinition of version in l0-cfm-support because building ppc-boot doesn't work today - WHY? - fixed now
(defun get-macho-entry-point (name &optional framework)
  (or (gethash name (macho-entry-points))
      (setf (gethash name *macho-entry-points*) (%cons-macho-entry-point nil framework name))))


;; redefine the load-framework-bundle in l1-init.lisp

(defun load-framework-bundle (Framework-name)
  (let ((descriptor (if (framework-descriptor-p framework-name)
                      (let ((desc framework-name))
                        (setq framework-name (framework.name desc))
                        desc)
                      (gethash framework-name *framework-descriptors*))))
    (if (not descriptor)
      (load-framework-bundle-simple framework-name (frameworks-url)) ;; this is important - else a saved application doesn't get off the ground
      (if (consp descriptor)
        (load-framework-bundle-hairy framework-name descriptor)
        (load-framework-bundle-given-descriptor framework-name descriptor t)))))


(defun load-framework-bundle-given-descriptor (framework-name descriptor &optional (error-p t))
  (let (url)
    (progn 
      ;(setq url (framework.url descriptor))
      (when (null url)     ;; clear these on startup - or don't bother to cache em
        (rlet ((fsref :fsref))
          (let ((args (framework.findfolderargs descriptor)))
            (if args
              (let ((loc (car args))
                    (type (second args)))                                   
                (let* ((err (#_FSFindFolder loc type t fsref)))
                  (if (eq #$noErr err)
                    (progn
                      (setq url (#_CFURLCreateFromFSRef (%null-ptr) fsref))
                      (if (%null-ptr-p url)
                        (if error-p
                          (error "Failed to create URL for args ~S" args)
                          (return-from load-framework-bundle-given-descriptor nil)))
                      (setf (framework.url descriptor) url))
                    (if error-p
                      (error "Couldn't findfolder for args ~S" args)
                      (return-from load-framework-bundle-given-descriptor nil)))))
              (let ((path (framework.pathname descriptor)))
                (if path
                  (progn
                    (let ((found (path-to-fsref path fsref)))
                      (when (not found) 
                        (if error-p
                          (error "Path does not exist ~S" path)
                          (return-from load-framework-bundle-given-descriptor nil))))
                    (setq url (#_CFURLCreateFromFSRef (%null-ptr) fsref))
                    (if (%null-ptr-p url)
                      (if error-p
                        (error "Failed to create URL for path ~S" path)
                        (return-from load-framework-bundle-given-descriptor nil)))
                    (setf (framework.url descriptor) url))
                  (progn (setq url (frameworks-url)))))))))) 
      (unwind-protect
        (with-cfstrs ((cfname framework-name))  ;; let em have a name hairier than latin1 - else could just call load-framework-bundle-simple     
          (with-macptrs ((bundle-url (#_CFURLCreateCopyAppendingPathComponent
                                      (%null-ptr)
                                      url
                                      cfname
                                      nil)))
            (if (%null-ptr-p bundle-url)
              (if error-p 
                (error "Can't create URL for ~s" framework-name)
                (return-from load-framework-bundle-given-descriptor nil))
              (let* ((bundle (#_CFBundleCreate (%null-ptr) bundle-url)))
                (#_cfrelease bundle-url)                
                (if (%null-ptr-p bundle)
                  (if error-p 
                    (error "Can't create bundle for ~s" framework-name)
                    nil)
                  (if (null (#_CFBundleLoadExecutable bundle))
                    (if error-p
                      (error "Couldn't load bundle for ~s" framework-name)
                      nil)
                    bundle))))))
        (when (and descriptor (framework.url descriptor))
          (#_cfrelease (framework.url descriptor))  ;; if not caching
          (setf (framework.url descriptor) nil))
        ))) 


(defun load-framework-bundle-hairy (framework-name descriptor-list)
  (or
   (dolist (desc descriptor-list nil)
     (let ((bundle (load-framework-bundle-given-descriptor framework-name  desc nil)))
       (if bundle (return bundle))))
   (error "Can't find bundle for ~S" framework-name)))

(defun canonicalize-findfolder-arg (findfolder-arg)
  (let ((loc (car findfolder-arg))
        (type (second findfolder-arg))
        fixit)
    (cond 
     ((keywordp loc)
      (let ((inloc loc))
        (setq loc (cdr (assq loc *supported-framework-locations*)))
        (when (not loc) (error "invalid framework location: ~s." inloc)))
      (setq fixit t))
     (t (when (not (rassoc loc *supported-framework-locations*))(error "Unknown framework location ~S" loc))))
    (when (keywordp type)  ;; weird - because the right ones are also keywords
      (let ((foo (cdr (assq type *supported-framework-folder-types*))))
        (when foo 
          (setq type foo)
          (setq fixit t))))
    (when (and (keywordp type) (not (rassoc type *supported-framework-folder-types*))) (error "Unknown framework folder type ~S" type))
    (when fixit (setq findfolder-arg (list loc type)))
    findfolder-arg))

;; something like this - untested
(defun add-framework-bundle-with-locations (framework-name &rest locations)
  (declare (dynamic-extent locations))  
  (cond 
   ((null locations)
    (add-framework-bundle framework-name))
   (t 
    (handler-bind ((error #'(lambda (c)
                              (remove-framework-bundle framework-name)  ;;??
                              (signal c))))
      (let ((where (car locations)))
        (add-framework-bundle framework-name
                              (if (consp where)                              
                                :findfolder-args
                                :pathname)
                              where))
      (dolist (where (cdr locations))
        (add-framework-bundle framework-name
                              (if (consp where)
                                :findfolder-args
                                :pathname)
                              where
                              :add-to t))))))


#|
so do something like

(add-framework-bundle "FOO.framework" :pathname "ccl:frameworks;" )

or
(add-framework-bundle-with-locations "foo.framework"
                                         "ccl:blah;" "ccl:mumble;" '(:appropriate-disk :PRIVATE-FRAMEWORKS))


(rlet ((major :pointer)Ê
Ê Ê Ê (minor :pointer))Ê 
  (#_aglGetVersion major minor)  ;; its in AGL.frameworkÊ 
  (values (%get-long major) 
          (%get-long minor))) 

|#

#|
(defun print-url (url)
  (rlet ((fsref :fsref))
    (let ((huh (#_CFURLGetFSref url fsref)))
      (when huh
        (let ((path (%path-from-fsref fsref))) ;; #P"macintosh-hd:System:Library:Frameworks:" 
          (print path))))))

(defun print-url2 (url)
  (with-macptrs ((foo (#_CFURLGetString url)))  ;; "file://localhost/System/Library/Frameworks/"
    (print (get-cfstr foo))
    (#_cfrelease foo)))
        
    
|#


;; do we really need this stuff
;; is :appropriate-disk any easier to remember/type than #$kOnAppropriateDisk
;; well at least it provides info about what the legal arguments are.
(defparameter *supported-framework-locations*
  ; from Folders.lisp - value is a vRefNum (a signed-integer)
  `((:system-disk . ,#$kOnSystemDisk)
    (:appropriate-disk . ,#$kOnAppropriateDisk) ;  Generally, the same as kOnSystemDisk, but it's clearer that this isn't always the 'boot' disk.
    
    (:system . ,#$kSystemDomain) ;  Read-only system hierarchy.
    (:local . ,#$kLocalDomain) ;  All users of a single machine have access to these resources.
    (:network . ,#$kNetworkDomain) ;  All users configured to use a common network server has access to these resources.
    (:user . ,#$kUserDomain) ;  Read/write. Resources that are private to the user.
    (:classic . ,#$kClassicDomain))) ;  Domain referring to the currently configured Classic System Folder

(defparameter *supported-framework-folder-types*
  ; from Folders.lisp - value is a foldertype (an ostype)
  ; the following is an auto generated exhaustive list of all know folder-types - gee whiz forgot #$kMagicTemporaryItemsFolderType
  ;; many of these have nothing to do with frameworks as far as i know - e.g. moviedocuments ??
  `((:DOMAIN-TOP-LEVEL . ,#$kDomainTopLevelFolderType)
    (:DOMAIN-LIBRARY . ,#$kDomainLibraryFolderType)
    (:COLOR-SYNC . ,#$kColorSyncFolderType)
    (:COLOR-SYNC-CMM . ,#$kColorSyncCMMFolderType)
    (:COLOR-SYNC-SCRIPTING . ,#$kColorSyncScriptingFolderType)
    (:PRINTERS . ,#$kPrintersFolderType)
    (:SPEECH . ,#$kSpeechFolderType)
    (:CARBON-LIBRARY . ,#$kCarbonLibraryFolderType)
    (:DOCUMENTATION . ,#$kDocumentationFolderType)
    (:DEVELOPER-DOCS . ,#$kDeveloperDocsFolderType)
    (:DEVELOPER-HELP . ,#$kDeveloperHelpFolderType)
    (:ISS-DOWNLOADS . ,#$kISSDownloadsFolderType)
    (:USER-SPECIFIC-TMP . ,#$kUserSpecificTmpFolderType)
    (:CACHED-DATA . ,#$kCachedDataFolderType)
    (:FRAMEWORKS . ,#$kFrameworksFolderType) ; typically used when framework in folder /system/library/frameworks ;  Contains MacOS X Framework folders 
    (:PRIVATE-FRAMEWORKS . ,#$kPrivateFrameworksFolderType) ;  Contains MacOS X Private Framework folders
    (:CLASSIC-DESKTOP . ,#$kClassicDesktopFolderType)
    (:DEVELOPER . ,#$kDeveloperFolderType)
    (:SYSTEM-SOUNDS . ,#$kSystemSoundsFolderType)
    (:COMPONENTS . ,#$kComponentsFolderType)
    (:QUICK-TIME-COMPONENTS . ,#$kQuickTimeComponentsFolderType)
    (:CORE-SERVICES . ,#$kCoreServicesFolderType)
    (:PICTURE-DOCUMENTS . ,#$kPictureDocumentsFolderType)
    (:MOVIE-DOCUMENTS . ,#$kMovieDocumentsFolderType)
    (:MUSIC-DOCUMENTS . ,#$kMusicDocumentsFolderType)
    (:INTERNET-SITES . ,#$kInternetSitesFolderType)
    (:PUBLIC . ,#$kPublicFolderType)
    (:AUDIO-SUPPORT . ,#$kAudioSupportFolderType)
    (:AUDIO-SOUNDS . ,#$kAudioSoundsFolderType)
    (:AUDIO-SOUND-BANKS . ,#$kAudioSoundBanksFolderType)
    (:AUDIO-ALERT-SOUNDS . ,#$kAudioAlertSoundsFolderType)
    (:AUDIO-PLUG-INS . ,#$kAudioPlugInsFolderType)
    (:AUDIO-COMPONENTS . ,#$kAudioComponentsFolderType)
    (:KERNEL-EXTENSIONS . ,#$kKernelExtensionsFolderType)
    (:DIRECTORY-SERVICES . ,#$kDirectoryServicesFolderType)
    (:DIRECTORY-SERVICES-PLUG-INS . ,#$kDirectoryServicesPlugInsFolderType)
    (:INSTALLER-RECEIPTS . ,#$kInstallerReceiptsFolderType)
    (:FILE-SYSTEM-SUPPORT . ,#$kFileSystemSupportFolderType)
    (:APPLE-SHARE-SUPPORT . ,#$kAppleShareSupportFolderType)
    (:APPLE-SHARE-AUTHENTICATION . ,#$kAppleShareAuthenticationFolderType)
    (:MIDI-DRIVERS . ,#$kMIDIDriversFolderType)
    (:LOCALES . ,#$kLocalesFolderType)
    (:FIND-BY-CONTENT-PLUGINS . ,#$kFindByContentPluginsFolderType)
    (:USERS . ,#$kUsersFolderType)
    (:CURRENT-USER . ,#$kCurrentUserFolderType) ; typically used when framework in user's home directory
    (:CURRENT-USER-REMOTE . ,#$kCurrentUserRemoteFolderType)
    (:SHARED-USER-DATA . ,#$kSharedUserDataFolderType)
    (:VOLUME-SETTINGS . ,#$kVolumeSettingsFolderType)
    (:APPLESHARE-AUTOMOUNT-SERVER-ALIASES . ,#$kAppleshareAutomountServerAliasesFolderType)  ;; some of these ain't ostypes
    (:PRE-MAC-OS91-APPLICATIONS . ,#$kPreMacOS91ApplicationsFolderType)  ;; pre macOS91 - just what we always needed
    (:PRE-MAC-OS91-INSTALLER-LOGS . ,#$kPreMacOS91InstallerLogsFolderType)
    (:PRE-MAC-OS91-ASSISTANTS . ,#$kPreMacOS91AssistantsFolderType)
    (:PRE-MAC-OS91-UTILITIES . ,#$kPreMacOS91UtilitiesFolderType)
    (:PRE-MAC-OS91-APPLE-EXTRAS . ,#$kPreMacOS91AppleExtrasFolderType)
    (:PRE-MAC-OS91-MAC-OS-READ-MES . ,#$kPreMacOS91MacOSReadMesFolderType)
    (:PRE-MAC-OS91-INTERNET . ,#$kPreMacOS91InternetFolderType)
    (:PRE-MAC-OS91-AUTOMOUNTED-SERVERS . ,#$kPreMacOS91AutomountedServersFolderType)))
          
                        
                      
            
            
     


(provide :deftrap)


#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
