;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: l1-readloop.lisp,v $
;;  Revision 1.5  2003/12/08 08:31:36  gtbyers
;;  No more #-ansi-make-load-form.
;;
;;  6 8/25/97  akh  cancel modal?
;;  4 4/1/97   akh  see below
;;  2 2/13/97  akh  #+ppc-target get-save-register-values
;;  22 10/3/96 akh  find-restart-in-process and startup-finish move here for Appgen
;;  14 12/1/95 gb   cheap-eval (setq <symbol-macro> ...) bug
;;  11 10/31/95 akh in read schar => %schar
;;  8 10/27/95 akh  fix read of extended-string
;;                  gvector/istruct stuff
;;  7 10/27/95 akh  damage control
;;  6 10/26/95 gb   ppc-target: call-check-regs does call even if no check-
;;                  regs ...
;;
;;  3 10/17/95 akh  merge patches
;;  18 5/22/95 akh  eval-enqueue calls method application-eval-enqueue
;;                  commented out the clause that prevents abort in idle listeners?
;;  10 4/24/95 akh  some little thing
;;  6 4/6/95   akh  %real-err-fn-name avoids call-check-regs
;;  4 4/4/95   akh  call-check-regs no rest arg, cheap-eval-in-env no apply
;;  16 3/2/95  akh  add method application-file-creator
;;                  break-loop sets *modal-dialog-on-top* to nil
;;  15 2/9/95  akh  process-to-abort - if 2 processes choose main unless option-key-p
;;  14 2/7/95  akh  prepare-to-quit - dont bind *quitting* to nil
;;  13 2/6/95  akh  break and error tell us process name if not "main".
;;  12 2/3/95  slh  copyright thang
;;  11 1/31/95 akh  break-loop-handle-error sets *processing-events* nil
;;  10 1/30/95 akh  fix readtable-case :invert in package token
;;                  add support for command-/, \, and b menu items
;;  8 1/25/95  akh  cancel text conditional on *quitting* in some dialogs
;;                  *modal-dialog-on-top* is a list now
;;  7 1/17/95  akh  with and without event processing moved to l1-events
;;                  Try the invert changes again
;;                  use without-event-processing
;;  6 1/12/95  akh  revert - something is wrong with :invert changes
;;  5 1/11/95  akh  aargh
;;  4 1/11/95  akh  move modeline
;;  3 1/11/95  akh  fix readtable-case :invert when escaped chars
;;  (do not edit before this line!!)
;; break-loop resets *modal-dialog-on-top* and *eventhook* - hmm needs more thought re hook

(in-package "CCL")

;L1-readloop.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

;; Modification History
;; 11/10/09 terje  new application-version-string method; ------------ 5.2.1
; process-to-abort - don't do *no-scheduling* - use without-event-processing instead
; ------------ 5.0 final
; 06/13/00 akh another fix in macroexpand-1
; 04/20/00 akh fix for define-symbol-macro in macroexpand-1, simplify cheap-eval as a result
; ---------- 4.3.1b1
; 07/19/99 akh process-to-abort - *no-scheduling* t
;--------- 4.3f1c1
; 06/26/99 akh interactive-abort-in-process accomodates CLIM patch that doesn't know about new *modal-dialog-on-top*
; ------------ 4.3b3
; 06/02/99 akh changes for new form of *modal-dialog-on-top*
; -------------- 4.3b2
; 05/09/99 akh cheap-eval does global symbol-macro for PPC
; --------- 4.3b1
; akh  - bill's cancel-modal-dialog patch
; 05/28/97 bill  make QUIT work from inside a modal-dialog.
; 04/24/97 bill  (method application-about-dialog (application)) properly computes
;                the dialog height.
; -------------  4.1f1
; 03/22/97 akh   interactive-abort checks option-key-p
; 02/26/97 bill  startup-finished calls event-dispatch so that starting
;                MCL via the Finder's print command will quit before bringing up a listener.
; 02/04/97 bill  toplevel throws to process-preset-tag instead of doing process-preset.
; 01/15/97 bill  *printing-break-message* is no more.
; -------------  4.0
; 06/22/96 bill  get-saved-register-values has better stack segment overflow hysteresis
;  5/03/96 slh   application-init-file
; 04/22/96 slh   removed obsolete lisp-development-system/application-about-dialog
;                added back application/application-about-dialog
; 03/25/96 bill  Change copyright in application-about-dialog
; -------------  MCL-PPC 3.9
; 03/14/96 bill  call-check-regs now does what it name implies.
; 03/07/96 bill  interactive-abort correctly aborts the *modal-dialog-on-top* process
; 02/06/96 bill  Add (shutdown-stack-groups) to prepare-to-quit
; 01/12/96 gb    toplevel-function/lisp-development system
;                does something wrong, but doesn't try to make process.
; 12/13/95 gb    remove cmulisp hack in macroexpand-1
; 11/21/95 bill  make toplevel do the right thing in a non-initial process
; 10/20/95 slh   de-lapified
; 10/16/95 gb    explict element type in %PARSE-STRING% init form.
; 02/21/95 gb    remove lap; use new package hashtable stuff.
;  6/09/95 slh   LDS about box moved out
;  6/08/95 slh   help-specs; about box update
;  5/04/95 slh   process-to-abort: ignore idling listeners
;  4/27/95 slh   toplevel-function methods here
;                process-to-abort: reverse process list, so most recent (?) is first
;  4/26/95 slh   application-about-dialog stuff here
;  4/16/95 slh   add licensor thingy to about dialog
;  4/11/95 slh   application-overwrite-dialog -> l1-files.lisp, inline in only place
;                used; about dialog stuff -> app method
;  4/04/95 slh   application-file-creator: use *ccl-file-creator*
;  4/01/95 akh   call-check-regs -no more rest arg - twas silly though exposed a bug
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
; 3/07/95 slh   error-header, uses *main-listener-process-name*
; 2/27/95 slh   %break-message: space after "Error:"
;-------------  3.0d17
;01/30/95 alice fix package part of readtable-case :invert, command-/ and-\ somewhat better
;-------------  3.0d16
;01/05/94 bill  bug in call-check-regs error form: reported dsave0's value 3 times,
;               omitted dsave1 & dsave2.
;-------------  3.0d13
;08/18/93 bill  interactive-abort doesn't query for process if *modal-dialog-on-top*.
;-------------  3.0d12
;07/22/93 bill  %error now does the right thing if application-error returns.
;               Nobody expects %error to return.
;06/11/93 alice %read-form-internal tries to keep his chars and bytes straight.
;		and calls new-numtoken instead of %%numtkn which is gonesville
;06/05/93 alice read calls %%find-pkg (in fasload.lisp) not %find-package
;05/29/93 alice read now supposedly deals with fat chars and is smart enuf to make
;		a fat pname  or string if one of the chars is actually fat, not otherwise.
;05/26/93 alice read calls %find-package vice %%findpkg ???
;07/01/93 alice simple-condition format-arguments initform nil
;05/22/93 alice interactive-abort chooses front window if window-process & *break-level* neq 0.
;05/21/93 alice interactive-abort and break do front window process iff *current-process* else ask
;		at least there's a good chance a user can get at a looping process
;05/15/93 alice %%name-char do #\nnn as word not byte 
;05/08/93 alice interactive-abort and break do the obvious for 1 process, ask if more.
;-------------- 2.1d7
;05/01/93 alice %break-message binds a bunch more printing vars - maybe too many
;04/29/93 bill process-is-listener-p, process-is-toplevel-listener-p
;              read-loop binds *eval-queue*, so that eval-enqueue gets the top listener, not
;              just whichever one gets around to looking at *eval-queue* first.
;              all-processes & friends -> *all-processes* & friends
;04/26/93 bill prepare-to-quit shuts down *active-processes* and waits for each shutdown to complete.
;04/23/93 bill with-background-process in toplevel-read.
;04/21/93 bill the new abort-break made <command>-<period> do nothing if typed at top-level in the Listener
;              (after fixing a bug in process-preset)
;              It should clear-input and print "Aborted".
;              Go back to the old way.
;              with-non-background-process in read-loop
;04/21/93 bill %read-form handles %parse-string% in a way that is compatible with multiple processes.
;04/02/93 bill restore missing arg to (format nil "...close it with extreme prejudice" ...)
;03/31/93 bill quit handles cancel correctly.
;-------------- 2.1d5
;04/29/93 alice break application-error (lisp-dev-envir) into 2 parts - nuke noop overwrite dialog
;------------- 2.1d4
;03/04.93 alice *error-print-circle* initially nil, reset to T in pprint.lisp
;02/13/93 alice add #\dot and #\altCheckMark to *name-char-alist*
;01/12/92 alice *listener-indent* option kludge
;11/04/92 alice read-loop has one restart instead of two - makes choose-restart look less cluttered with redundancies
;		changed abort-break - do we like it?
;10/29/92 alice toplevel-read protected-form - don't make a listener - causes save-application to fail when invoked via menu or dialog
;10/15/92 alice don't use format ~a to print a condition - may contain circles
;08/09/92 gb 	break-loop binds %handlers% to nil
;07/22/92 alice %error heed *debugger-hook*
;06/23/92 alice let things on *eval-queue* be functions.
;-------------- 2.1d3
;03/24/93 bill bind *quitting* in prepare-to-quit
;02/19/93 bill signal binds *break-on-signals* nil around the break loop
;              entered due to *break-on-signals* being non-nil.
;02/17/93 bill def-kernel-restart $xstkover
;02/16/93 bill cerror no longer gets "Too many arguments" error if given a condition
;              instead of a string as its second arg and a non-empty list of additional args.
;              (typep x 'condition) -> (condition-p x) 
;01/28/93 bill eval-enqueue does funcall-in-top-listener-process
;01/27/93 bill call-check-regs prints more info
;01/25/93 bill %read-form now signals an end-of-file error instead of a simple-error
;01/24/93 bill user-break arg to break-loop & cbreak-loop no longer necessary
;              as we can't break in the middle of processing events anymore.
;              break-loop no longer binds *processing-events*.
;11/20/92 gb   #+/#- in lisp;  move some stack accessors to backtrace.lisp; change
;              r/e/p loop for stack groups; new application class with some methods.
;              pass *current-stack-group* to stack walkers.  Backtrace context in
;              a vector.
; 10/26/92 bill without-event-processing, with-event-processing-enabled.
; 08/24/92 bill in prepare-to-quit: close windows from back to front & bring windows that
;               need saving to the front before closing them.
; 06/02/92 bill break-loop no longer binds *eventhook* to nil.
;               Instead, process-event is smarter about not reentering *eventhook* functions.
; 05/18/92 bill break-loop now has a SIGNAL firewall.
;-------- 2.0
;02/21/92 (gb from bootpatch0)  ABORT takes &optional condition arg.
;-------- 2.0f2
;01/08/92 gb    mumble more clearly.
;12/27/91 gb    mumble something about stack overflow in TOPLEVEL-LOOP.
;12/24/91 gb    don't retain lambda expressions if &LAP, &METHOD, &RESTV involved.
;12/18/91 gb    simple-storage-condition, package-name-conflict error.
;12/16/91 gb    %signal-error -> %err-disp; more hair in %err-disp.
;-------- 2.0b4
;11/14/91 gb    (per bill) queue-fixup not a nop, copies correct readtable.
;11/13/91 bill  queue-fixup for setting *readtable* is a NOP as the fixups are run when *readtable* is bound.
;11/11/91 bill  shadow -> shadow-1 so we don't need to cons.  Fix argument order in one call to unintern
;               GB's fix to the fix of #+ & #-
;11/11/91 gb    read-features even when *read-suppress* true; fix use-package restarts;
;               retain-lambda-expression sometimes does.
;10/27/91 gb    resolve-export-conflicts.
;10/10/91 gb    BREAK-LOOP binds *RERD-SUPPRESS*. CHEAP-EVAL-IN-ENV tries to resolve compile-time
;               constants.  Try to handle type errors when :datum is #<unbound>.  No-such-package
;               restart more careful about *package*.
;09/30/91 gb    make-load-form on LEXICAL-ENVIRONMENT. 
;09/16/91 bill  Don't ignore CANCEL button on request to save a window during QUIT
; ------- 2.0b3
;09/06/91 alice file-error can have args besides pathname
;09/05/91 bill  Alice's patch to print-listener-prompt
;08/24/91 gb    fix macroexpand.  Use new trap syntax.
;08/19/91 bill  let LOAD-TRAP-CONSTANT do the work for #$
;08/01/91 bill  interactive-abort honors *inhibit-abort*
;07/26/91 bill  make QUIT ignore some errors and throw to toplevel before
;               doing PREPARE-TO-QUIT
;08/19/91 gb    use %type-error-type in $xwrongtype restart.
;07/21/91 gb    fix wtaerrs.  Defconstant wimpiness. #'TYPE-ERROR -> #'SIGNAL-TYPE-ERROR.
;               Fix some restarts.  Use %type-error-type mechanism.  Applicable-restart-p
;               applies restart-test, used in find-,compute-restarts.
;07/03/91 alice break-loop do restart window too - add it to list on *backtrace-dialogs*
;07/02/91 bill  no more (declare (downward-function ...)) in READ
;06/27/91 bill  selection-eval changes the buffer's package if a single-selection
;               is evaluated which changes *package*.  Add evalp optional arg.
;06/24/91 alice if *backtrace-on-break* do it after the break message
;06/17/91 alice now #\177 is "DEL"
;---------- 2.0b2
;05/30/91 bill  for #_ & #$ - in *traps-package* only for reading.
;05/28/91 alice *name-char-alist* ForwardDelete <= #\177, Delete <= backspace
;05/21/91 alice add *error-print-circle* = what *print-circle* is bound to by %break-message & break-loop
;05/20/91 gb    "check-error-global" scheme: needs some work.  Typecheck *readtable*, *package* in %READ-FORM.
;               UNINTERN-CONFLICT class, restart handler.  One scheme of handling changes to *package* during
;               selection eval.  Rename #'PROGRAM-ERROR to #'SIGNAL-PROGRAM-ERROR.  Add %SYMBOL-MACROEXPAND;
;               should be used more often than it is.
;04/16/91 alice *name-char-alist* add home, end etc.
;04/04/91 bill  close *open-file-streams* in prepare-to-quit
;03/14/91 bill  bind *print-readably* to NIL in the break-loop
;02/28/91 bill  Bind *idle* around event-dispatch call in toplevel-read
;02/12/91 bill  cheap-eval-in-environment does UNWIND-PROTECT explicitly to avoid an extra compile from window-enqueue-region
;03/04/91 alice %break-message - if it is a simple-program-error with a non null context, omit "while executing foo"
;02/26/91 alice function type-error, %signal-error knows about type-error
;02/11/91 alice cheap-eval-in-env - special case step macro (blech), bind *compile-definitions* nil
;----------------- 2.0b1
;01/28/91 bill  in toplevel-print: set *, **, ***, /, //, /// just before starting to print.
;01/14/91 gb    let last arg default in ensure-value-of-type.
;01/07/91 gb    use *autoload-lisp-package* in no-package restart.  Make ceie handle locally, (symbol-)macrolet.
;12/31/90 gb    scatter some (declare (resident))'s around indiscriminately.  Comment-out call-check-regs.
;               print CONTINUE format string with *PRINT-ARRAY* off and *PRINT-CIRCLE* on.  Make sure that
;               %initial-readtable% and *readtable* are disjoint.  %cfp-lfun identifies swappable functions
;               by jumptable address.
;12/14/90 alice cheap-eval-in-environment - handle locally at top level correctly in interpreter
;12/12/90 bill require-lisp-package restart for no-such-package error.
;              invoke-restart-interactively prints the restart before doing anything.
;12/8/90  joe   rearrange read-loop so that *eval-queue* is looked at first. This is a
;               purely cosmetic change so that an extra prompt isn't printed under AEvents.
;11/27/90 bill  get-next-queued-form
;11/19/90 gb    muffle-warning.  Bootstrap backtrace; use new package functions in reader.
;10/23/90 bill  interactive-abort does abort-break if *in-read-loop*, abort just invokes the restart.
;10/20/90 bill  fix bad interaction of selection-eval with new setting of *, **, ***, etc in toplevel-print.
;10/16/90 gb    stack-cons restarts.  Make sure toplevel loop doesn't set * unless
;               toplevel-print returns.
;10/12/90 bill  Let one error happen in %break-message before disabling *signal-printing-errors*
;10/10/90 bill  add user-break arg to cbreak-loop & break-loop so that event-abort
;               restart is skipped if user interrupts event processing.
;10/05/90 bill  fix %readtab-fn2spec
;09/28/90 bill  Bind *signal-printing-errors* to NIL in %break-message
;09/25/90 bill  add child-frame optional arg to cfp-lfun & count-values-in-frame
;09/12/90 bill  bind *signal-printing-errors* to NIL in break-loop
;09/07/90 bill  #_ & #$ dispatch-macro-characters,
;               stream-tyi-guaranteed-function-and-args
;08/27/90 bill  break-loop binds *modal-dialog-on-top* in just the right place.
;08/25/90 bill  *single-defvar-is-defparameter* -> *always-eval-user-defvars*
;08/23/90 bill  :none -> :unspecific from GZ, "~s" -> "~:s" for undefined-function-call
;               report.
;08/11/90 bill  process-single-selection in selection-eval
;08/02/90 gb   (clear-input *debug-io*) only when we're about to read from it,
;              not when we write to it.  (Among other things, type-ahead shouldn't
;              get flushed by redefinition warnings.) %uvref -> uvref.
;07/31/90 bill  New get-string-from-user arglist.
;07/18/90 alice bind *print-circle* and *print-array* in %break-message
;------ 2.0d48
;07/13/90 alice garys fix to cfp-lfun
;06/19/90 gb   macroexpand-1 returns (values nil nil) when non symbol-macro binding
;              encountered.
;06/25/90 bill Restore normal cursor during break-loop.
;06/18/90 bill remove window-ensure-on-screen before printing listener prompt.
;07/09/90 alice calls to get-string-from-user supply 2 args
;06/14/90 alice #P-reader take 4 as flags - why do we have these here flags?
; ------ 2.0d46
;06/14/90 bill macroexpand-1 checks for (symbolp (car form)) before looking for
;              a macro-function (e.g. ((lambda (x) x) 1))
;06/12/90 bill make note-function-info do the right thing for (setf foo)
;              make ::foo read as :foo, not :\:foo
;              keyword:<new-symbol> same as keyword::<new-symbol> (used to error)
;06/08/90 gb   print-unreadable-object: keyword name is :identity, not :id.
;06/07/90 bill *read-eval -> *read-eval*
;06/05/90 bill ensure listener prompt appears even when *print-level* = 0
;06/05/90 gb  $xnopkg restart.  (clear-input *debug-io*) in %break-message, %break-loop.
;06/05/90 gb  add storage-condition, stack-overflow-condition.  Start to classify
;             errors signalled from kernel.
;05/30/90 gb  print-not-readable-error.  Use print-unreadable-object.
;05/27/90 gb  macroexpand-1 symbol-macros.
;05/22/90 gb  note-variable-info.
;05/16/90 gb  compiler-warning-nrefs. *READ-EVAL*.
;5/9/90   gb  note & retrieve function information.
;5/7/90   gz  New improved file-error condition.
;05/05/90 bill new scrap handler.
;05/04/90 gb   some more nils in new-{definition,lexical}-environment.
;05/02/90 bill prepare-to-quit comes out of line from quit.
;04/30/90 gb   reaadtable-case.  Newer condition stuff.  Still need to fix ABORT,
;              foo-case macros.  Need also to make primitive errors be of right
;              condition class.  Stack-walkers pass fixnums (distance from NIL
;              in longwords) around.
;04/20/90 gz  Fix in %read-form for the read-delimited-list case.
;             Fix in %readtab-fn2spec to deref closure wrappers.
;04/02/90 gz  write-a-restart -> print-object
;02/14/90 bill in selection-eval: make sure we print in the listener's package,
;              or people will get very confused.
;2/13/90  gz  in cheap-eval: don't use compile-user-function if it's just
;             going to apply the result.
;             Flushed *did-startup* and (startup-ccl) in top-level-loop.
;02/02/90 gz  Prefetch stream-tyi combined method in %read-form.
;01/13/90 gz  Pass idle arg to event-dispatch in toplevel-read.
;01/03/89 gz  In %signal-error, look up nilreg cells for $xfunbnd as well.
;12/29/89 gz  Made read go through stream-rubout-handler.
;             Changed get-[dispatch]-macro-character to treat NIL readtable as
;             the initial readtable, as per x3j13/GET-MACRO-CHARACTER-READTABLE.
;01/29/90 bill in cheap-eval: compile the lambda expr in ((lambda (...) ...) ...)
;              Add *break-loop-when-uninterruptable* to break-loop
;              Make ESC the preferred name for the Escape character
;01/16/90 bill Make quit close windoids and invisible windows.
;01/13/90 bill window-ensure-on-screen before printing prompt in listener.
;12/30/89 bill Restore *did-startup* and (startup-ccl) to top-level-loop.
;12/30/89 gb  cheap eval-when (:execute).
;12/28/89 gz  No more catch/throw-error.
;12/27/89 gz  Rearrange obsolete #-bccl conditionals.  Bind *compiling-file* to nil
;             in break loops.  Don't do startup in toplevel-loop.  Handle setf
;             function names in cheap-eval.
;12/22/89  gb  slowed down the reader some more (cl:readtable-case nonsense.)
;11/14/89 gz  Make cheap-eval not use compile-user-function if it's just
;             going to funcall the result.
;             No more %write.
;12-Dec-89 Mly In %read-form, no need to call eofp since stream-tyi returns nil if so
;              Moved *name-char-alist* here from l1-io.  I hope this isn't a screw...
;              write-a-restart
;11/5/89  gz   Do not ignore errors in cleanup functions.
;10/13/89 bill funcall *lisp-cleanup-functions* in QUIT before closing windows.
;10/13/89 bill Make cheap-eval always use compile-user-function to generate warnings.
;09/30/89 gb make selection-eval bind *package*.  I have no idea whether or not
;            this is right.
;09/17/89 gb flushed a little more of object lisp.
;09/16/89 bill Removed the last vestiges of object-lisp windows.
;9/14/89 bill Update for CLOS listener: top-level-read, print-listener-prompt
;9/13/89  gz in %signal-error, special-case $xvunbnd to allow nilreg offset
;            instead of symbol.
;8/29/89  gb no more #'function-binding.
;4/10/89  gz clos conditions.
;04/07/89 gb  $sp8 -> $sp.
;3/30/89  gz *inest-ptr* -> *interrupt-level*. %parse-number-token to l1-numbers.
;	     $sp-numtkn -> %%numtkn.
;3/23/89  gz no more kernel lfuns, no more $sp-findextsym.
;03/03/89 gz macro-function to l1-utils.
;            made %read-form be object system independent.
;2/24/89  gz one-arg %make-uvector -> $sp-allocgv.
;2/12/89  gz Added %parse-number-token, new arg to numtkn
; 2/13/89 gz read-feature (and ...) fix.
; 1/30/89 gb vstack starts at (a5 $vstackbase) vice nilreg.
;01/09/89 gz New error system.
;01/04/89 gz New read-loop, new eval queue scheme.
;01/03/89 gz The reader.
; 1/1/89 gb heap, a5, lfuns ...
;12/11/88 gz mark-position -> buffer-position
;12/2/88 gz partial 1.3 merge:
  ;10/19/88 jaj bind and declare special *processing-events* in break-loop
  ; 9/28/88 jaj in read-loop don't set - + ++ +++ if source is :eval-queue
; 11/27/88 gb forget %toplink, %%next-cfp magic numbers.
; 11/23/88 gb %caller here.
; 9/11/88  gb stack-walkers changed some.  Error calls break-loop non-continuably.
; 9/2/88   gz no more list-nreverse
; 9/8/88   gb no cfp. Some stack-walkers changed, others need to.
; 9/1/88   gb self-evaluate non-symbol atoms in cheap-eval.
; 8/23/88  gz cheap-eval calls compile-user-function for nfunction.
; 8/13/88  gb unbound-marker vice int-to-ptr in readloop.
; 8/9/88  gb  macro-function (env arg), macroexpand, -1, *hook*.
; 7/31/88 gb  Add stack frame accessors, fix %last-fn-on-stack (Right...) Backtrace setup.
;             Cheap-eval compiles iff compiler-special-form-p, not function-binding/macro-
;             function.
; 6/23/88 jaj fixed some catch/throw bugs, toplevel-loop is now a loop
; 6/22/88 as  quit doesn't bother to close doc-string file
; 6/22/88 jaj throw-error arg is optional
; 6/21/88 jaj catch-error returns two values, added catch-error-quietly
;             *backtrace-on-errors* -> *backtrace-on-break* 
;             changes to read-loop and break-loop, added *listener-break-
;             level*, print-listener-prompt prints if neq *break-level*,
;             print-compiler-warnings before printing error
; 6/20/88 jaj catching abort clears-input. print-listener-prompt prints
;             if read-position is zero
; 6/10/88 jaj abort throws :abort-break if *in-read-loop*
; 6/9/88  jaj quit closes %doc-string-file
;             added added [catch/throw]-[toplevel/error/cancel/break]
;             read-loop cleaned up
; 5/8/88  jaj added *save-local-symbols* to cheap-eval
; 5/31/88 as  %error -> :error, %toplevel -> :toplevel
;             abort does'nt print when *inhibit-error*
; 5/23/88 as  error doesn't hang on attempts to print to non-streams
; 5/13/88 as  quit closes windows in reverse order
; 5/11/88 jaj cheap-eval uses *warn-hook*
; 2/27/88 jaj bind *, **, *** etc. in toplevel-loop and break-loop
;             instead of read-loop (fixes for evaling from buffer)
;             added continuablep to break-loop and callers, added
;             *continuablep*

; 6/5/88  gb  Pass *save-local-symbols* into compile-named-function.
; 4/01/88 gz  New macptr scheme.  Flushed pre-1.0 edit history.
;10/26/87 jaj abort throws to (or *break-loop-tag* '%toplevel)
;10/25/87 jaj changed C-/, C-. to Command-/, Command-. (bug report by Ruben)
;10/23/87 jaj added print-listener-prompt to error
;10/21/87 jaj "resume" -> "continue"
;10/19/87 jaj added abort
;10/18/87 jaj removed tyo, added optional force arg to print-listener-prompt
;             call it after catching a break.
;10/14/87 jaj tyo space to *terminal-io*
;10/13/87 jaj added *print-package*, use it in read-loop
;10/04/87 gb  tyo a space (to any old stream !?) in abort-break.
;9/15/87 jaj  print symbol 'continue using ~s for entering break-loop
;             added %real-err-fn-name to skip over event-dispatch
;-------------------------------Version 1.0-----------------------------------


(defvar *break-on-signals* nil)
(defvar *break-on-warnings* nil)
(defvar *break-on-errors* t "Not CL.")
(defvar *debugger-hook* nil)
(defvar *backtrace-on-break* nil)
(defvar *** nil)
(defvar ** nil)
(defvar * nil)
(defvar /// nil)
(defvar // nil)
(defvar / nil)
(defvar +++ nil)
(defvar ++ nil)
(defvar + nil)
(defvar - nil)

(defvar *continuablep* nil)
(defvar *in-read-loop* nil 
 "Not CL. Is T if waiting for input in the read loop")
(defvar *listener-p* nil
  "Bound true by READ-LOOP. This is how we tell if a process is a Listener")

(defparameter *inhibit-error* nil "If non-nil, ERROR just throws")
(defvar *did-startup* nil)

(defvar *eval-queue* nil)

(defun process-is-listener-p (process)
  (symbol-value-in-process '*listener-p* process))

(defun process-is-toplevel-listener-p (process)
  (and (symbol-value-in-process '*in-read-loop* process)
       (eql 0 (symbol-value-in-process '*break-level* process))))


  

(defun get-next-queued-form ()
  (pop *eval-queue*))

#|
(defmacro without-event-processing (&body body)
  `(let-globally ((*processing-events* t))
     ,@body))


(defmacro with-event-processing-enabled (&body body)
  `(let ((*interrupt-level* 0))
     (let-globally ((*processing-events* nil))
        ,@body)))
|#

(defmacro catch-cancel (&body body)
  `(catch :cancel ,@body))

(defmacro throw-cancel (&optional value)
  `(throw :cancel ,value))

(defun toplevel ()
  (let ((p *current-process*))
    (if (eq p *initial-process*)
      (throw :toplevel nil)
      (throw (process-reset-tag p) :toplevel))))

; This is the old way we did this.
; It has the drawback that it doesn't throw out,
; just restarts the process without cleaning up.
#|
      (progn
        (process-interrupt *initial-process*
                           #'(lambda (p)
                               (let ((function.args (process.initial-form p)))
                                 (apply #'process-preset
                                        p
                                        (car function.args)
                                        (cdr function.args))))
                           p)
        (loop
          (suspend-current-process))))))
|#
#|
(defun cancel ()
 (throw :cancel :cancel))
|#

(defun cancel ()
  (if (and *modal-dialog-on-top*
           (eq *current-process* *event-processor*)
           (let* ((dialog.process (car *modal-dialog-on-top*))
                  (dialog (car dialog.process))
                  (process (modal-dialog-process dialog.process)))
             (and (typep dialog 'window)
                  (wptr dialog)
                  (typep process 'process)
                  (not (process-exhausted-p process)))))             
    (return-from-modal-dialog :cancel)
    (throw :cancel :cancel)))

; It's not clear that this is the right behavior, but aborting CURRENT-PROCESS -
; when no one's sure just what CURRENT-PROCESS is - doesn't seem right either.
(defun interactive-abort ()
  (let* ((w (front-window))
         (p (if w (window-process w))))
    (interactive-abort-in-process
     (or (if (or (and (eq w (caar *modal-dialog-on-top*))
                      (setq p (modal-dialog-process (car *modal-dialog-on-top*))))
                 (and p (not (option-key-p))
                      (or (eq p *current-process*)
                          (lds
                           (and (not (process-exhausted-p p))
                                (neq 0 (symbol-value-in-process '*break-level* p)))))))
           p)
         (process-to-abort "Abort Process")))))

(defun interactive-abort-in-process (p)
  (if (consp p)(setq p (car p))) ;; for CLIM
  (if p (process-interrupt p 
                           #'(lambda ()
                               (unless *inhibit-abort*
                                 (lds (if *in-read-loop* 
                                        (abort-break)
                                        (abort))
                                      (abort))
                                 )))))


; What process-to-abort does now (5/5/95):
; - all processes idling: cmd-. & opt-cmd-. abort event-processor
; - one process busy: cmd-. aborts the busy process; opt-cmd-. gives dialog
; - two or more processes busy: cmd-. & opt-cmd-. gives dialog
; (a busy process is a non-idling listener, or any other that's not event-processor)

(defun process-to-abort (what)
  (without-event-processing
    (let ((l (mapcan #'(lambda (x)
                         (unless (or (%stack-group-exhausted-p (process-stack-group x))
                                     (not (find-restart-in-process 'abort x))
                                     ; idling listeners:
                                     #|
                                   (and (symbol-value-in-process '*in-read-loop* x)
                                        (eq 0 (symbol-value-in-process '*break-level* x)))|#
                                     )
                           (list x)))
                     (reverse *active-processes*))))
      (cond
       ((null (cdr l)) (car l)) ; *current-process*
       ((and (null (cddr l))
             (not (option-key-p)))
        (if (eq (car l) *event-processor*) (cadr l) (car l)))
       (t (let ((p (catch-cancel
                     (select-item-from-list l
                                            :window-title what
                                            :help-spec 15010
                                            :list-spec 15011
                                            :button-spec 15013))))
            (if (neq p :cancel) (car p))))))))

(defun abort (&optional condition)
  (invoke-restart-no-return (find-restart 'abort condition)))

(defun continue (&optional condition)
  (let ((r (find-restart 'continue condition)))
    (if r (invoke-restart r))))

#|  ;; a kludge that has no effect on the muffle-warning in event-processing-loop
(defun muffle-warning (&optional condition)  
  (if (find-restart 'muffle-warning condition)
    (invoke-restart-no-return (find-restart 'muffle-warning condition))))
|#

(defun muffle-warning (&optional condition)
   (invoke-restart-no-return (find-restart 'muffle-warning condition)))

(defun abort-break ()
  (invoke-restart-no-return 'abort-break))

#| Doing it this way prevents abort from clearing input in the listener
(defun abort-break ()
  (let ((res (find-restart-2 'abort)))
    (if  res (invoke-restart-no-return res) (abort))))

; find second restart
(defun find-restart-2 (name &aux res)
  (dolist (cluster %restarts% res)
    (dolist (restart cluster)
      (when (eq (restart-name restart) name)                 
	(if res (return-from find-restart-2 restart)(setq res restart))))))
|#

(defun quit ()
  (let ((listener *top-listener*))
    (when (and (null listener)
               *modal-dialog-on-top*)
      (let ((process (modal-dialog-process (car *modal-dialog-on-top*))))
        (when process
          (do-all-windows w
            (when (eq process (window-process w))
              (return (setq listener w)))))))
    (terminate-standin-event-processor
     #'(lambda () (finish-quit listener)))))

(defun finish-quit (listener)
  (let ((cancelled-p (list nil)))
    (declare (type cons cancelled-p))
    (process-interrupt *initial-process*
                       #'(lambda (cancelled-p)
                           (unwind-protect
                             (progn
                               (prepare-to-quit listener 0)
                               (%set-toplevel #'(lambda () 
                                                  (%set-toplevel nil)
                                                  (ignore-errors (prepare-to-quit nil 1))
                                                  (throw :toplevel nil)))
                               (throw :toplevel nil))
                             (setf (car cancelled-p) t)))
                       cancelled-p)
    (process-wait "Quit" #'(lambda (cancelled-p) (car cancelled-p)) cancelled-p)
    nil))

; Kill the standin event processor, then funcall thunk with no args.
; Cons up a new process to do this if the current process is the
; standin event processor.
(defun terminate-standin-event-processor (thunk)
  (let ((standin-process *event-processor*))
    (unless (eq standin-process *initial-process*)
      (if (or (eq *current-process* standin-process)
              (eq *current-process* *initial-process*))
        (return-from terminate-standin-event-processor
          (process-run-function "Standin event processor killer"
                                #'(lambda (thunk)
                                    (terminate-standin-event-processor thunk))
                                thunk))
        (progn
          (let ((initial-form (process-initial-form standin-process)))
            (without-interrupts
             (setf (car initial-form) #'process-wait
                   (cdr initial-form) (list "Death wait" #'(lambda () nil)))))
          (process-reset standin-process)
          (process-interrupt *initial-process*
                             #'(lambda ()
                                 (throw (or *event-processing-loop-tag* :toplevel) nil)))
          (process-wait-with-timeout "Standin event processor termination"
                                     300
                                     #'(lambda ()
                                         (eq *event-processor*
                                             *initial-process*)))
          (unless (eq (setq standin-process *event-processor*)
                      *initial-process*)
            (setq *event-processor* *initial-process*)
            (process-kill-and-wait standin-process))))))
  (when thunk (funcall thunk)))

(defvar *quitting* nil)

; Called by quit, save-application & dumplisp
(defun prepare-to-quit (&optional listener part)
  (without-event-processing ; ((*processing-events* t)        ; just process aborts
    (let-globally ((*quitting* (or listener t)))
      (when (or (null part) (eql 0 part))
        (dolist (f *lisp-cleanup-functions*)
          (funcall f))
        (let (windows)
          (do-all-windows w (push w windows))
          (dolist (w windows)
            (when (neq w listener)
              (window-close-nicely w))))
        (when listener
          (window-close listener)))
      (unless (eql part 0)
        (dolist (p (without-interrupts (copy-list *active-processes*)))
          (unless (or (eq p *event-processor*) (eq p *initial-process*)
                      (without-interrupts (not (memq p *active-processes*))))
            (process-reset p :unless-current :shutdown :ask)
            (unless (process-wait-with-timeout
                     "Shutdown wait"
                     300
                     #'(lambda (p)
                         (or (memq p *shutdown-processes*)
                             (not (memq p *all-processes*))))
                     p)
              (let ((ans (y-or-n-dialog
                          (format nil "~s refuses to shut down. Terminate it with extreme prejudice?"
                                  p)
                          :cancel-text (if *quitting* "Cancel"))))
                (if (eq ans nil) (abort)
                    (if (neq ans t)(cancel))))
              (maybe-finish-process-kill p :kill))))
        #+ppc-target
        (shutdown-stack-groups)
        (while *open-file-streams*
          (close (car *open-file-streams*)))
        (setq *interrupt-level* -1)       ; can't abort after this
        (put-external-scrap)))))

(defmethod window-close-nicely ((w window))
  (when (and (method-exists-p #'window-needs-saving-p w)
             (window-needs-saving-p w))
    (ignore-errors (window-select w)))
  (multiple-value-bind (res errorp)
                       (ignore-errors (values (window-close w)))
    (declare (ignore res))
    (when errorp
      (if (eq t (y-or-n-dialog 
                 (format nil "Error closing ~s.~%Close it with extreme prejudice?" w)
                 :cancel-text (if *quitting* "Cancel")))
        (ignore-errors (window-close-internal w))
        (cancel)))))





;; Application classes

(defconstant default-app-creator :|????|)

(defclass application ()
  ())


(defun eval-enqueue (form)
  (application-eval-enqueue *application* form))

(defmethod application-eval-enqueue ((app application) form)
  (if (functionp form)
    (funcall form)
    (if (and (consp form)(functionp (car form)))
      (apply (car form) (cdr form))
      (eval form))))

; an example method to base a specialization on
(defmethod toplevel-function ((a application) init-file)
  (declare (ignore init-file))
  (let* ((file-list (finder-parameters))
         (spec (cdr file-list)))
    (case (car file-list)
      (:open
        (if spec
          (dolist (f spec)
            (open-application-document *application* f t))
          (open-application a t)))
      (:print
       (dolist (f spec)
         (print-application-document *application* f t))))
    (startup-finished)
    (catch :toplevel
      (loop (event-dispatch)))))


(defun startup-finished ()
  (setq *event-mask* #$everyEvent)
  (event-dispatch))                     ; quit right away if started to print

(defun find-restart-in-process (name p)
  (without-interrupts
   (let ((restarts (symbol-value-in-process '%restarts% p)))
     (dolist (cluster restarts)
       (dolist (restart cluster)
         (when (and (or (eq restart name) (eq (restart-name restart) name)))
           (return-from find-restart-in-process restart)))))))


; specialize this for your application
(defmethod print-application-document ((a application) path &optional startup)
  (declare (ignore path startup)))

; specialize this for your application
(defmethod open-application ((self application) startup)
  (declare (ignore startup))
  nil)
  
; specialize this for your application
(defmethod open-application-document ((a application) path &optional startup)
  (declare (ignore path startup)))

(defmethod application-file-creator  ((app application)) default-app-creator)
(defmethod application-name          ((app application)) nil)
(defmethod application-resource-file ((app application)) nil)
(defmethod application-sizes         ((app application)) nil)
(defmethod application-init-file     ((app application)) nil)(defmethod application-version-string ((app application)) NIL)

(defmethod application-about-view ((app application))
  (make-dialog-item 'static-text-dialog-item
                    #@(15 20)
                    nil
                    (application-name app)))

(defmethod application-about-dialog ((app application))
  (let* ((about-view (application-about-view app))
         (view-size (view-size about-view))
         (next-y (if view-size
                   (+ (point-v (view-position about-view))
                      (point-v view-size)
                      15)
                   50))
         (dialog-width  (if view-size
                          (max (point-h view-size) 350)
                          350))
         (dialog-height (max (+ next-y 100)
                             150)))
    (make-instance 'dialog
      :auto-position :centermainscreen
      :view-size (make-point dialog-width dialog-height)
      :window-type :double-edge-box
      :window-show nil
      :view-subviews
      (list
       about-view
       (make-dialog-item 'static-text-dialog-item
                         (make-point 15 next-y)
                         #@(300 60)
                         "Written in Macintosh Common Lisp."
                         nil
                         :view-font '("Geneva" 9))
       (make-dialog-item 'default-button-dialog-item
                         (make-point (ash (- dialog-width 70) -1)
                                     (incf next-y 70))
                         #@(70 18)
                         "OK"
                         #'(lambda (item)
                             (declare (ignore item))
                             (return-from-modal-dialog t)))))))

(defclass lisp-development-system (application) 
  ())

(defmethod toplevel-function ((a lisp-development-system) init-file)
  (startup-ccl init-file)
  (if *single-process-p*                ; not really right, but ...
    (progn
      (%set-toplevel #'(lambda ()
                          (unless *inhibit-greeting* 
                            (format t "~&Welcome to ~A ~A!~%"
                                    (lisp-implementation-type)
                                    (lisp-implementation-version)))
                          (toplevel-loop)))
      (toplevel))
    (progn (make-mcl-listener-process)
           )))

(defmethod application-file-creator ((app lisp-development-system))
  *ccl-file-creator*)

(defmethod application-init-file ((app lisp-development-system))
  "init")


; redefined by hide-listener-support
(defmethod application-error ((a application) condition error-pointer)
  (declare (ignore condition error-pointer))
  (quit))

(defun error-header (kind)
  (let ((pname (process-name *current-process*)))
    (if (and pname (not (string-equal pname *main-listener-process-name*)))
      (format nil "~A in process ~A" kind pname)
      (format nil "~A" kind))))

(defun signal (condition &rest args)
  (setq condition (condition-arg condition args 'simple-condition))
  (lds
   (when (typep condition *break-on-signals*)
     (let ((*break-on-signals* nil))
       (cbreak-loop "Signal" "Signal the condition." condition (%get-frame-ptr)))))
  (let ((%handlers% %handlers%))
    (while %handlers%
      (do* ((tag (pop %handlers%)) (handlers tag (cddr handlers)))
           ((null handlers))
        (when (typep condition (car handlers))
          (let ((fn (cadr handlers)))
            (cond ((null fn) (throw tag condition))
                  ((fixnump fn) (throw tag (cons fn condition)))
                  (t (return (funcall fn condition))))))))))

(defvar *error-print-circle* nil)   ; reset to T when we actually can print-circle

(defun release-locked-windows (&optional (process *current-process*))
  (let ((res nil))
    (do-all-windows w
      (let ((q (window-process-queue w)))
        (when (and q (eq process (process-queue-locker q)))
          (push q res)
          (process-dequeue q process))))
    res))

;;;***********************************
;;;Mini-evaluator
;;;***********************************

(defun new-lexical-environment (&optional parent)
  (%istruct 'lexical-environment parent nil nil nil nil nil nil))

(defmethod make-load-form ((e lexical-environment) &optional env)
  (declare (ignore env))
  nil)

(defun new-definition-environment (&optional (type 'compile-file))
  (%istruct 'definition-environment (list type)  nil nil nil nil nil nil nil nil nil nil nil))

(defun definition-environment (env &optional clean-only &aux parent)
  (if (and env (not (istruct-typep env 'lexical-environment))) (report-bad-arg env 'lexical-environment))
  (do* () 
       ((or (null env) 
            (listp (setq parent (lexenv.parent-env env)))
            (and clean-only (or (lexenv.variables env) (lexenv.functions env)))))
    (setq env parent))
  (if (consp parent)
    env))

(defvar *macroexpand-hook* 'funcall) ; Should be #'funcall. 
;(queue-fixup (setq *macroexpand-hook* #'funcall)) ;  No it shouldn't.

(defun macroexpand-1 (form &optional env &aux fn (expansion form) win boundp)
  (declare (resident))
  (if (and (consp form)
           (symbolp (%car form))
           (setq fn (macro-function (%car form) env)))
    (setq expansion (funcall *macroexpand-hook* fn form env)
          win t)
    (when (and form (symbolp form))
      (if env
        (if (istruct-typep env 'lexical-environment)
          (do* ((env env (lexenv.parent-env env)))
               ((or win (null env) (eq (%svref env 0) 'definition-environment)) (setq win (not (null win))))
            (let ((vars (lexenv.variables env)))
              (when (consp vars)
                (let ((info (dolist (var vars)
                              (if (eq (var-name var) form)
                                (return var)))))            
                  (when info
                    (setq boundp t)
                    (when (and (consp (setq info (var-expansion info)))
                               (eq (%car info) :symbol-macro))
                      (setq win t expansion (%cdr info)))
                    (unless win (return)))))))
          (report-bad-arg env 'lexical-environment)))
      (if (and (not win)(not boundp))
        (let ((it (find-compile-time-or-global-symbol-macro form)))
          (if it (setq expansion (cdr (var-expansion it)) win t))))))
  (values expansion win))

(defun macroexpand (form &optional env)
  (declare (resident))
  (multiple-value-bind (new win) (macroexpand-1 form env)
    (do* ((won-at-least-once win))
         ((null win) (values new won-at-least-once))
      (multiple-value-setq (new win) (macroexpand-1 new env)))))

(defun %symbol-macroexpand (form env &aux win won)
  ; Keep expanding until no longer a symbol-macro or no longer a symbol.
  (loop
    (unless (and form (symbolp form)) (return))
    (multiple-value-setq (form win) (macroexpand-1 form env))
    (if win (setq won t) (return)))
  (values form won))

(defun retain-lambda-expression (name lambda-expression env)
  (if (and (let* ((lambda-list (cadr lambda-expression)))
             (and (not (memq '&lap lambda-list))
                  (not (memq '&method lambda-list))
                  (not (memq '&lexpr lambda-list))))
           (nx-declared-inline-p name env)
           (not (gethash name *nx1-alphatizers*))
           ; A toplevel definition defined inside a (symbol-)macrolet should
           ; be inlineable.  It isn't; call DEFINITION-ENVIRONMENT with a
           ; "clean-only" argument to ensure that there are no lexically
           ; bound macros or symbol-macros.
           (definition-environment env t))
    lambda-expression))

; This is different from AUGMENT-ENVIRONMENT.
; If "info" is a lambda expression, then
;  record a cons whose CAR is (encoded-lfun-bits . keyvect) and whose cdr
;  is the lambda expression iff the function named by "name" is 
;  declared/proclaimed INLINE in env
(defun note-function-info (name lambda-expression env)
  (let ((definition-env (definition-environment env)))
    (if definition-env
      (let* ((already (assq (setq name (maybe-setf-function-name name))
                            (defenv.defined definition-env)))
             (info nil))
        (when (lambda-expression-p lambda-expression)
          (multiple-value-bind (lfbits keyvect) (encode-lambda-list lambda-expression t)
            (setq info (cons (cons lfbits keyvect) 
                             (retain-lambda-expression name lambda-expression env)))))
          (if already
            (if info (%rplacd already info))
            (push (cons name info) (defenv.defined definition-env)))))
    name))

; And this is different from FUNCTION-INFORMATION.
(defun retrieve-environment-function-info (name env)
 (let ((defenv (definition-environment env)))
   (if defenv (assq (maybe-setf-function-name name) (defenv.defined defenv)))))

(defun maybe-setf-function-name (name)
  (if (and (consp name) (eq (car name) 'setf))
    (setf-function-name (cadr name))
    name))

; Must differ from -something-, but not sure what ... 
(defun note-variable-info (name info env)  ;; this is a compile-time thing
  (when (find-compile-time-symbol-macro name)
    (warn "Redefining compile time symbol macro ~S as a special, global, etc." name)
    (remove-compile-time-symbol-macro name))
  (let ((definition-env (definition-environment env)))
    (if definition-env (push (cons name info) (defenv.specials definition-env)))
    name))

(defun compile-file-environment-p (env)
  (let ((defenv (definition-environment env)))
    (and defenv (eq 'compile-file (car (defenv.type defenv))))))

(defun cheap-eval (form)
  (cheap-eval-in-environment form nil))

; used by nfcomp too
; Should preserve order of decl-specs; it sometimes matters.
(defun decl-specs-from-declarations (declarations)
  (let ((decl-specs nil))
    (dolist (declaration declarations decl-specs)
      ;(unless (eq (car declaration) 'declare) (say "what"))
      (dolist (decl-spec (cdr declaration))
        (setq decl-specs (nconc decl-specs (list decl-spec)))))))

(defun cheap-eval-in-environment (form env &aux sym)
  (declare (resident))
  (flet ((progn-in-env (body&decls parse-env base-env)
           (multiple-value-bind (body decls) (parse-body body&decls parse-env)
             (setq base-env (augment-environment base-env :declare (decl-specs-from-declarations decls)))
             (while (cdr body)
               (cheap-eval-in-environment (pop body) base-env))
             (cheap-eval-in-environment (car body) base-env))))
    (if form
      (cond ((symbolp form) 
             (multiple-value-bind (expansion win) (macroexpand-1 form env)
               (if win 
                 (cheap-eval-in-environment expansion env) 
                 (let* ((defenv (definition-environment env))
                        (constant (if defenv (assq form (defenv.constants defenv))))
                        (constval (%cdr constant)))
                   (if constant
                     (if (neq (%unbound-marker-8) constval)
                       constval
                       (error "Can't determine value of constant symbol ~s" form))                     
                     (symbol-value form))))))
            ((atom form) form)
            ((eq (setq sym (%car form)) 'quote)
             (verify-arg-count form 1 1)
             (%cadr form))
            ((eq sym 'function)
             (verify-arg-count form 1 1)
             (cond ((symbolp (setq sym (%cadr form)))
                    (%function sym))
                   ((and (consp sym) (eq (%car sym) 'setf) (consp (%cdr sym)) (null (%cddr sym)))
                    (%function (setf-function-name (%cadr sym))))
                   (t (%make-function nil sym env))))
            ((eq sym 'nfunction)
             (verify-arg-count form 2 2)
             (%make-function (%cadr form) (%caddr form) env))
            ((eq sym 'progn) (progn-in-env (%cdr form) env env))
            ((eq sym 'setq)
             (if (not (%ilogbitp 0 (list-length form)))
               (verify-arg-count form 0 0)) ;Invoke a "Too many args" error.
             (let* ((sym nil)
                    (val nil))
               (while (setq form (%cdr form))
                 (setq sym (require-type (pop form) 'symbol))
                 (multiple-value-bind (expansion expanded)
                                      (macroexpand-1 sym env)
                   (if expanded
                     (setq val (cheap-eval-in-environment `(setf ,expansion ,(%car form)) env))
                     (set sym (setq val (cheap-eval-in-environment (%car form) env))))))
               val))
            ((eq sym 'eval-when)
             (destructuring-bind (when . body) (%cdr form)
               (when (or (memq 'eval when) (memq :execute when)) (progn-in-env body env env))))
            ((eq sym 'if)
             (destructuring-bind (test true &optional false) (%cdr form)
               (cheap-eval-in-environment (if (cheap-eval-in-environment test env) true false) env)))
            ((eq sym 'locally) (progn-in-env (%cdr form) env env))
            ((eq sym 'symbol-macrolet)
             (progn-in-env (cddr form) env (augment-environment env :symbol-macro (cadr form))))
            ((eq sym 'macrolet)
             (let ((temp-env (augment-environment env
                                                  :macro 
                                                  (mapcar #'(lambda (m)
                                                              (destructuring-bind (name arglist &body body) m
                                                                (list name (enclose (parse-macro name arglist body env)
                                                                                    env))))
                                                          (cadr form)))))
               (progn-in-env (cddr form) temp-env temp-env)))
            ((and (symbolp sym) 
                  (compiler-special-form-p sym)
                  (not (functionp (fboundp sym))))
             (if (eq sym 'unwind-protect)
               (destructuring-bind (protected-form . cleanup-forms) (cdr form)
                 (unwind-protect
                   (cheap-eval-in-environment protected-form env)
                   (progn-in-env cleanup-forms env env)))
               (funcall (%make-function nil `(lambda () (progn ,form)) env))))
            ((and (symbolp sym) (macro-function sym env))
             (if (eq sym 'step)
               (let ((*compile-definitions* nil))
                     (cheap-eval-in-environment (macroexpand-1 form env) env))
               (cheap-eval-in-environment (macroexpand-1 form env) env)))
            ((or (symbolp sym)
                 (and (consp sym) (eq (%car sym) 'lambda)))
             (let ((args nil))
               (dolist (elt (%cdr form)) (push (cheap-eval-in-environment elt env) args))
               (apply #'call-check-regs (if (symbolp sym) sym (%make-function nil sym env))
                      (nreverse args))))
            (t (signal-simple-condition 'simple-program-error "Car of ~S is not a function name or lambda-expression." form))))))


(%fhave 'eval #'cheap-eval)

#+ppc-target
(defppclapfunction get-saved-register-values ()
  (vpush save0)
  (vpush save1)
  (vpush save2)
  (vpush save3)
  (vpush save4)
  (vpush save5)
  (vpush save6)
  (vpush save7)
  (la temp0 32 vsp)
  (set-nargs 8)
  (ba .SPvalues))

#+ppc-target
(defun call-check-regs (fn &rest args)
  (declare (dynamic-extent args)
           (optimize (debug 3)))        ; don't use any saved registers
  (let ((old-regs (multiple-value-list (get-saved-register-values))))
    (declare (dynamic-extent old-regs))
    (multiple-value-prog1 (apply fn args)
      (let* ((new-regs (multiple-value-list (get-saved-register-values)))
             (new-regs-tail new-regs))
        (declare (dynamic-extent new-regs))
        (unless (dolist (old-reg old-regs t)
                  (unless (eq old-reg (car new-regs-tail))
                    (return nil))
                  (pop new-regs-tail))
          (apply 'error "Registers clobbered applying ~s to ~s~%~@{~a sb: ~s, Was: ~s~%~}"
                 fn args
                 (mapcan 'list
                         (let ((res nil))
                           (dotimes (i (length old-regs))
                             (push (format nil "save~d" i) res))
                           (nreverse res))
                         old-regs
                         new-regs)))))))

#-ppc-target
(defun call-check-regs (fn &rest args)
  (declare (dynamic-extent args))
  (declare (optimize (debug 3))) ; no register allocation
  (let* ((dsave0 (lap-inline () (move.l dsave0 acc)))
         (dsave1 (lap-inline () (move.l dsave1 acc)))
         (dsave2 (lap-inline () (move.l dsave2 acc)))
         (asave0 (lap-inline () (move.l asave0 acc)))
         (asave1 (lap-inline () (move.l asave1 acc))))
    (multiple-value-prog1 (apply fn args)
      (let* ((ndsave0 (lap-inline () (move.l dsave0 acc)))
             (ndsave1 (lap-inline () (move.l dsave1 acc)))
             (ndsave2 (lap-inline () (move.l dsave2 acc)))
             (nasave0 (lap-inline () (move.l asave0 acc)))
             (nasave1 (lap-inline () (move.l asave1 acc))))
        (unless (and (eq dsave0 ndsave0)
                     (eq dsave1 ndsave1)
                     (eq dsave2 ndsave2)
                     (eq asave0 nasave0)
                     (eq asave1 nasave1))
          (error "Registers clobbered applying ~S to ~S~%~@{~s SB: ~s, Was: ~s~%~}"
                 fn args
                 'dsave0 dsave0 ndsave0
                 'dsave1 dsave1 ndsave1
                 'dsave2 dsave2 ndsave2
                 'asave0 asave0 nasave0
                 'asave1 asave1 nasave1))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Stack frame accessors.

; Kinda scant, wouldn't you say ?


;end of L1-readloop.lisp

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
