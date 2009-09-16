;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  5 6/9/97   akh  see below
;;  32 1/22/97 akh  add with-font macro
;;  28 9/3/96  akh  fix defpascal-code for 68K, conditionalization
;;  26 5/20/96 akh  %i- takes > 2 args
;;  21 3/9/96  akh  apply-with-method-context macro moves here
;;  20 2/19/96 akh  copyright 1996
;;  17 12/22/95 gb  init *pascal-full-longs* for ppc-target
;;  15 12/12/95 akh #-ppc-target some eval-redefs.
;;  8 11/13/95 akh  fix ppc %clear-block
;;  3 10/17/95 akh  merge patches to with-pstrs and cstrs
;;  (do not edit before this line!!)


;;	Change History (most recent first, or maybe at the bottom):

;;    09/13/95 gb   %lexpr-count, %lexpr-ref.
;;  5 2/3/95   akh  merge leibniz patches
;;  4 2/2/95   akh  merge with leibniz patches for defstruct
;;  (do not edit before this line!!)

;; Level-2.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2001 Digitool, Inc. 

; This file must be loaded in order to be compiled.

;; Modification History
;
; $Log: level-2.lisp,v $
; Revision 1.36  2006/02/03 20:14:27  alice
; ;; upp-creator arg to defpascal invokes add-pascal-upp-alist-macho
;; --- 5.2b1 
;; add macros add-pascal-upp-alist-cfm, add-pascal-upp-alist-macho
;; don't even think about #_lmgetcurrenta5
;
; Revision 1.35  2005/06/25 23:50:55  alice
; ;; fix with-cfstrs macro
;
; Revision 1.34  2005/03/27 22:06:18  alice
; ;; dont warn about unused variable in e.g. (defmethod foo ((x baz) y) - from Gary King
;
; Revision 1.33  2005/03/09 19:45:01  alice
; ;; add macro copy-string-to-ptr
;
; Revision 1.32  2005/02/18 08:51:41  alice
; ;; create-cfstr2 takes start and end args as does with-cfstrs-hairy
;
; Revision 1.31  2005/02/04 05:16:24  alice
; ;; create-cfstr2 - assume extended-string is unicode
;
; Revision 1.30  2004/10/11 23:51:07  alice
; ;; add a couple mouse-position macros
;
; Revision 1.29  2004/09/19 01:20:15  alice
; ;; "after the fact"  fixup to a CLOS/MOP bug re :direct-slots - fix it right someday
;
; Revision 1.28  2004/09/15 04:28:57  alice
; ;; defclass knows about :documentation
;
; Revision 1.27  2004/09/07 02:23:48  alice
; ;; add macro with-pen-saved-simple
;
; Revision 1.26  2004/08/21 08:37:28  alice
; ;; add  :upp-creator arg to defpascal - e.g. (defpascal collapse-begin-proc (:upp-creator #_neweventhandlerupp ....) does add-pascal-upp-alist
;
; Revision 1.25  2004/07/26 21:03:40  alice
; ;; add with-cfstrs-hairy - accepts encoded strings
;
; Revision 1.24  2004/07/10 03:49:00  alice
; ;; with-pen-saved uses window-prior-theme-drawing-state vs. *is-normalized*
;
; Revision 1.23  2004/06/20 23:11:50  alice
; ;; lose with-timer - it's in l1-events.lisp
;
; Revision 1.22  2004/06/15 14:01:50  alice
; ;; with-pen-saved saves themedrawingstate
;
; Revision 1.21  2004/06/05 01:17:12  alice
; ; defclass does record-source-file for accessors etc with *warn-if-redefine* nil
;
; Revision 1.20  2004/04/16 22:08:35  alice
; ;; defpackage does record-source-file for package and nicknames
;
; Revision 1.19  2004/03/26 03:34:21  gtbyers
; DEFCLASS: use CDR (not CADR) of canonicalized unknown option.
;
; Revision 1.18  2004/03/03 22:47:35  svspire
; class-class-slots gets all of them, not just direct, to be consistent with MCL documentation. Similar legacy pseudo-MOP routines return single-level lists of slot-definition objects. Old code that used e.g. slot-definition-name on these things will still work.
;
; Revision 1.17  2004/03/03 19:35:22  gtbyers
; fix newline in checkin comment.
;
; Revision 1.16  2004/03/03 17:14:14  gtbyers
; DEFCLASS: get order of canonicalized :DIRECT-DEFAULT-INITARGS right.
; %eval-redef %SLOT-REF.
;
; Revision 1.15  2004/02/25 21:30:57  svspire
; comment about pascal-true
;
; Revision 1.14  2004/02/18 21:20:20  alice
; ;; reinstate record-source-file for slot names and accessors
;
; Revision 1.13  2004/02/15 09:25:47  alice
; ; put back class-xxx-slots
; export new-with-pointers
;
; Revision 1.12  2004/01/28 05:42:33  alice
; put back with-accessors
;
; Revision 1.11  2004/01/16 19:43:03  svspire
; method --> reference-method. ANSI says you can't redefine the symbol 'method in the CL package
;
; Revision 1.10  2003/12/29 04:32:19  gtbyers
; Revive WITH-SLOT-VALUES, which may be used in some code for some reason.
;
; Revision 1.9  2003/12/17 07:07:42  gtbyers
; Random DEFCLASS options pass the CADR (not CDR !) of the option form to
; ENSURE-CLASS.
;
; Revision 1.8  2003/12/08 08:11:26  gtbyers
; New DEFCLASS, DEFMETHOD.  Move WITH-SLOTS and METHOD macros here.

;; setf macro - fix values case i.e. not needed
;; in-package accepts character
;; case-key-tester - don't want to descend list structure more than once
;; dotimes and dolist put the block in right place
;; defpackage allows character as specifier for package name
;; typecase-aux - dont forbid T clause in etypecase (dietz test)
;; deflass - multiple slot options passed as a list vs. individually
;;  omit test for :allocation = :instance or :class, done elsewhere per MOP
;; ------ 5.2b6
;; remove remove-bogus-initarg, problem removed at source
;; defclass doesn't error re :allocation if :metaclass specified ? should test be more general
;; with-pen-saved uses with-theme-state-preserved rather than doing it inline
;; create-cfstr2 moved to sysutils
;; ----- 5.2b5
;; handler-bind allows '(lambda .. as well as '(function (lambda ... - from James Anderson
;; ------- 5.2b4
;; with-stack-double-floats slightly less useless
;; with-standard-io-syntax - *read-default-float-format* 'double-float please
;; ----- 5.2b2
;; with-stack-double-floats - say 0.0d0 - but the macro is useless
;; upp-creator arg to defpascal invokes add-pascal-upp-alist-macho
;; --- 5.2b1 
;; add macros add-pascal-upp-alist-cfm, add-pascal-upp-alist-macho
;; don't even think about #_lmgetcurrenta5
;; fix with-cfstrs macro
;; dont warn about unused variable in e.g. (defmethod foo ((x baz) y) - from Gary King
;; add macro copy-string-to-ptr
;; with-cfstrs == with-cfstrs-hairy
;; create-cfstr2 takes start and end args as does with-cfstrs-hairy
;; create-cfstr2 - assume any non encoded string is unicode
;; create-cfstr2 - assume extended-string is unicode
;; ------- 5.1 final
;; add a couple mouse-position macros
;; ---------- 5.1b3
;; "after the fact"  fixup to a CLOS/MOP bug re :direct-slots - fix it right someday
;; defclass knows about :documentation 
;; add macro with-pen-saved-simple
;; add  :upp-creator arg to defpascal - e.g. (defpascal collapse-begin-proc (:upp-creator #_neweventhandlerupp ....) does add-pascal-upp-alist
;; add with-cfstrs-hairy - accepts encoded strings
;; with-pen-saved uses window-prior-theme-drawing-state vs. *is-normalized*
;; lose with-timer - it's in l1-events.lisp
;; with-pen-saved saves themedrawingstate
;; defclass does record-source-file for accessors etc with *warn-if-redefine* nil
;; -------- 5.1b2
;; defpackage does record-source-file for package and nicknames
;; reinstate record-source-file for slot names and accessors
; put back class-xxx-slots
; export new-with-pointers
; 01/27/04 - put back with-accessors
; --------- 5.1b1
;; 12/02/03 define macro with-timer here too
; add new-with-pointers that doesn't take handles
;; fix with-stack-double-floats - from James Anderson
;; -------- 5.0 final
; do use new psetq
; added new psetq but not used yet
; change case-aux so e.g. (ecase x (t 4)) does not error at compile time
; -------- 4.4b5
; mod to with cfstrs for start end
; ------ 4.4b4
; 05/25/02 add with-cfstrs
; 04/17/02 akh fix defpackage :documentation
; -------- 4.4b3
; defun cerrors if is currently generic function.
; add macro with-port-macptr and use it in a few places (because (with-macptrs ((pp (%getport))) ...) conses
;--------- 4.4b2
; enforce type for initform in defclass if initform is constantp - no don't - do at make-instance time
; carbon-compat font stuff
; ------- 4.3.1b1
; 01/20/00 akh default-setf does pass env to type-specifier-p
; 08/24/99 akh default-setf doesn't do unknown types (avoid double warning)
; 07/24/99 akh add (setf (values ...) ...) per Ansi CL
; -------- 4.3f1c1
; 05/08/99 akh define-symbol-macro (PPC only), export with-lock
; ------------- 4.3b1
; 01/24/99 akh define-condition takes :default-initargs
; 01/19/99 akh defpackage takes :documentation
;10/22/98 add with-lock - for cl-http - like with-lock-grabbed but does multiple-reader-single-writer, takes key args
; 03/04/98 akh dolist frob was WRONG
; 11/17/97  akh dolist wraps forms in progn so e.g. (dolist (a x) nil nil  (print a)) doesn't error
; 06/05/97    akh  bill's fix for default-setf when *compile-definitions* is NIL
; 03/28/97 bill  fix defpascal-ppc so that AlanR's test case works:
;                (defpascal bmn (:long) (print 'hi) 0)
; 03/26/97 bill  defclass eats the :primary-p class option unless (ppc-target-p)
; -------------- 4.1b1
; 03/05/97 gb    defpascal expands to DEFINE-PPC-PASCAL-FUNCTION-2.
; 02/23/97 bill  The lisp function passed to define-pascal-function now takes
;                the stack pointer arg as a fixnum and copies it into a macptr
;                only if necessary.
; 02/17/97 bill  with-process-enqueued doesn't call process-dequeue
;                unless its call to process-enqueue returns. 
; 01/23/97 bill  point-h & point-v => integer-point-h & integer-point-v
;                Remove duplicate with-font definition.
; 01/14/97 bill  default-setf takes an environment arg which it uses to
;                pass any known types of the arguments through to the gensyms they're
;                bound to.
; 01/01/97 bill  defclass handles the new :primary-p option.
; 12/02/96 bill  AlanR's fix to defmacro, ~:a instead of ~:s in format.
; -------------  4.0
; 09/25/96 bill  defsetf's for %get-double-float & friends.
; -------------- 4.0b2
; 09/17/96 bill  with-dereferenced-handle is a copy of with-pointer except
;                it calls %dereference-handle instead of %thing-pointer
; 09/07/96 gb    restore int>0-p in DOTIMES, uncomment SEQ-DISPATCH.
; 08/27/96 bill  with-foreign-window
; -------------- 4.0b1
; akh %i- takes > 2 args
; 04/07/96 gb    a bunch of #+ppc-target eval-redef's.
; 04/03/96 bill  pfe.without-interrupts. Parse :without-interrupts argument in
;                defpascal-68k gets without-interrupts as the 4th value from defpascal-code
;                instead of by looking for a without-interrupts form.
;                PPC version of defpascal-code to prevent the compiler warning.
;                defpascal-ppc parses the :without-interrupts argument keyword and
;                passes the value in the generated call to define-ppc-pascal-function.
; 03/29/96 slh   a bit more tweaking to make-proc-info, defpascal-ppc, defccallable
; 03/29/96 bill  defccallable passes env arg to defpascal-ppc
;                slh's fixes to defpascal-ppc & make-proc-info
; 03/27/96 bill  defpascal & ppc-defpascal pass environment arg to defpascal-ppc.
;                defpascal-ppc does parse-body to properly relocate the declarations,
;                and passes the doc-string on to define-ppc-pascal-function.
; 01/05/96 gb    gz's init file now ANSI CL (lambda macro.)
; 12/27/95 gb    %typed-misc{ref,set} spelling.
; 12/13/95 gb    progv rides again
; 12/05/95 slh   update trap names
; 11/16/95 bill  bitsetf & bitclrf
; 11/15/95 bill  defpascal expands into target-specific code: defpascal-68k, defpascal-ppc
; 11/14/95 bill  warn about %currenta5 on the PPC.
; 11/14/95 gb    tweak to fix of %clear-block.
; 11/03/95 bill  def-accessor-macros, like def-accesors but generates no constants
; 10/26/95 slh   %gvector -> %istruct, vector
;  5/12/95 slh   handler-case: allow "shorthand" syntax for :no-error clause
;  5/05/95 slh   defclass: check for duplicate default initargs
;  4/26/95 slh   new ok-wptr; with-font-codes uses it
;                with-lock-grabbed: current-process -> *current-process*
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
; 2/17/95 slh   *pascal-full-longs* & defpascal-code changes for full 32-bit longs
; 1/25/95 slh   comments indicate what to change for full defpascal longwords
;-------------  3.0d16
; defun cerrors if redefining a generic function. Ancient bug.
;--------------
;12/01/93 bill  method qualifiers can now be any non-nil atom, as specified in CLtL2.
;09/16/93 bill  zone-pointer-p no longer bombs on address 2 or 0
;09/16/93 bill  dovector propogates the type of its vector arg to the temp holding it.
;08/18/93 bill  with-clip-rect-intersect moves here from "ccl:examples;grapher".
;08/09/93 bill  defpackage much faster: uses hash tables instead of MEMBER.
;07/27/93 bill  defmethod no longer attempts to eval EQL specializers at compile time.
;-------------- 3.0d12
;06/14/93 alice with-pstr and with-cstr use byte-length
;06/02/93 alice defsetf for %scharcode
;05/17/93 bill  macptr<= & macptr-evenp move from here to l1-utils.lisp
;-------------- 3.0d8
;05/16/93 alice %code-char unsigned-byte 8 -> 16 %char-code base-character -> character
;------------ 2.1d7
;04/30/93 bill  fix compiler-let inside of defmethod: qualifiers are NOT evaluated.
;04/29/93 bill  current-process -> *current-process*
;04/28/93 bill  %eval-redef's for %get-fixnum & %hget-fixnum
;04/24/93 bill  with-background-process, with-non-background-process
;04/22/93 bill  with-standard-abort-processing now takes an abort-message arg
;-------------  2.1d5
;11/26/92 alice defmethod binds *nx-method-warning-name*  for compiler warnings
;03/18/93 bill  with-standard-abort-handling
;03/10/93 bill  zone-pointerp no longer conses. Nor does it attempt to read a long at an odd address
;01/08/92 bill  with-lock-grabbed, with-process-enqueued
;11/17/92 bill  defresource, using-resource
;11/20/92 gb    turn a lot of traditional open-coded functions into macros.  Cons-cell ordering
;               in defpascal lap.
;08/12/92 bill  defun does the right thing for inline functions when ENV is NIL.
;07/08/92 bill  defun uses nx-declared-inline-p instead of proclaimed-inline-p
;07/01/92 bill  parse-defmethod puts user declarations for #'call-next-method and
;               #'next-method-p in the right place.
;-------------- 2.0
;01/16/92 gb  allow declarations again in WITH-OPEN-FILE.
;01/11/91 alice %stack-iopb clears for good measure
;12/23/91 bill  arglist-string for a macro with no args is "()" vice "NIL".
;12/10/91 gb    %signal-error -> %err-disp; the occasional FIXNUM declaration.
;-------------- 2.0b4
;11/20/91 bill  GB's patch to DEFUN
;11/19/91 bill  defccallable really has syntax similar to defpascal this time.
;11/12/91 bill  in restart-bind - ,restarts -> ,@restarts
;11/05/91 gb   %svref, %svset are macros; declare magic method functions INLINE.
;10/29/91 bill  check-generic-function-lambda-list in parse-defgeneric
;10/24/91 bill  defccallable now has syntax similar to defpascal
;10/11/91 bill  defmacro needed to consider &optional in computing the
;               position of &body.
;10/21/91 alice with-open-file returns the right thing
;10/18/91 alice add def-ccl-pointers
;10/03/91 alice with-open-file cares whether it completed
;10/02/91 gb   make ZONE-POINTERP a little harder to fool.
;09/27/91 gb   expand MACROLET-ed macros in SETF.
;------------- 2.0b3
;08/04/91 bill parse-defgeneric - handle multiple declarations.
;08/31/91 gb   DEFPACKAGE passes package name as string.
;08/26/91 bill with-port does gworld stuff
;08/24/91 gb   Use new trap syntax.
;07/21/91 gb   more use of (eval-when (:compile-toplevel) ...) Eval-redef every open-coded function not elswhere
;              defined.  Allow multiple store-vars in SETF, use MULTIPLE-VALUE-BIND to bind them.
;06/22/91 bill defloadvar neglected to setq the variable at def-load-pointers time.
;06/17/91 bill %setport uses _SetPort vice modifying memory itself
;------------- 2.0b2
;06/03/91 bill change destructuring-bind's arglist so Fred will know how to
;              indent it.
;05/25/91 bill %eval-redef's for %put-xxx were defined in terms of %hput-xxx
;05/22/91 bill GB's fix to TYPECASE-AUX
;05/20/91 gb   CALL-NEXT-METHOD, NEXT-METHOD-P now defined via FLET; less magic.
;              Fix broken RESTART-BIND.  Use NORMALIZE-LAMBA-LIST, new arglist
;              scheme in DEFMACRO.  DEFLOADVAR (barely worth it).  Stop pretending
;              that WITH-INVISIBLE-REFERENCES works.  DOTIMES no longer assumes
;              fixnum arithmetic - (DECLARE (FIXNUM I)) advised.  EVAL-REDEF more
;              stuff.
;04/15/91 bill #.$v_istruct in %cons-restart so that the symbol isn't necessary in the distributed lisp
;04/29/91 bill remove cff-call - it didn't preserve order of evaluation
;04/09/91 bill DEFCLASS specializers can be objects as well as names.
;04/04/91 bill add start and end args to with-cstr so it parallels with-pstr
;              cff-call (C Foreign-Function Call)
;04/03/91 bill generic-function, anonymous-method
;              defclass supports the :metaclass class option.
;03/22/91 bill @, -> ,@ in handler-case
;03/12/91 bill DEFMACRO handles &whole, &environment, &optional relative to &body position
;03/06/91 bill The top-level of the real define-method-combination.
;02/20/91 bill type-check method-qualifiers in defmethod
;02/12/91 bill with-pointers scoping bug
;02/08/91 bill %cons-restart moves here from lispequ.
;03/04/91 alice some report-bad-arg => program-error
;------------- 2.0b1
;02/06/91 bill in do-symbols: pkg.shadowed -> #.pkg-shadowed
;              in with-package-iterator (pkg-iter.state x) -> (%svref x #.pkg-iter.state)
;              %cons-pkg-iter moves here from lispequ
;01/31/91 bill with-package-iterator
;01/18/91 bill reverse order of args for a :writer in defclass.  standard-slot-setf-method => standard-writer-method
;01/15/91 gb   What the hell - do [C,E]TYPECASE here as well.
;01/14/91 gb   hair up case-aux so CCASE and ECASE can live normal lives.
;01/09/91 gb   stack-cons the horrible multiple-value-list in multiple-value-bind.
;              bogus DEFINE-METHOD-COMBINATION.
;01/08/91 bill require-trap in macros that use #_xxx
;01/07/91 bill DEFCLASS generates toplevel DEFMETHOD's
;              Use new traps package in macro expansions
;12/31/90 bill defpascal looks for without-interrupts wrapped around the body.
;              defccallable passes without-interrupts through to defpascal.
;12/31/90 gb   nail down DEFCLASS to make disk space.  A few missing %eval-redefs.
;12/12/90 bill record-accessor-methods in expansion of defclass.
;11/28/90 gb   I will not rely on Steele being accurate.  I will not rely on Steele being accurate.
;              with-hash-table-iterator.
;11/19/90 bill GB's patch for pascal-regcode-code
;11/09/90 bill add :documentation slot-option to defclass (ignored for now)
;10/24/90 gb   %unbound-marker-8 expands into $unbound.
;10/12/90 bill type-check slot-name's in defclass.
;10/11/90 akh  defparameter second time save doc string
;09/24/90 bill DEFMACRO's &BODY code handles dotted arglist correctly.
;09/21/90 bill add-accessor-types in def-accessors.
;10/16/90 gb   stack-cons restarts.
;09/26/90 gb   invert pushes in handler-case per gz.
;09/13/90 bill use  make-symbol vice gensym in defclass.
;09/06/90 bill ansi-loop
;09/05/90 bill add :method-class to defmethod
;08/24/90 bill defmacro passes the position of &body to %macro for *fred-special-indent-alist*
;08/23/90 joe  moved bunch of pointer stuff (zone-pointer-p, pointer-size, wptr-to-procid,
;              etc from defrecord. Added %clear-pointer which clears a pointer and
;              %clear-block which clears a block of memory of a given size.
;08/08/90 gb    defpackage errors out on duplicates.  Defpascal-code doesn't try to
;               nreverse &rest args in local macros.
;07/18/90 alice put missing comma in WITH-SIMPLE-RESTART
;07/13/90 gb   hoist-special-decls: suitable for splicing.
;07/05/90 akh  remove print stuff from defvar and defparameter
;07/04/90 bill add :argument-precedence-order to defgeneric
;06/22/90 bill def-aux-init-functions
;06/21/90 gb   complain about quoted args to IN-PACKAGE, but unquote them.
;06/20/90 gb   *compile-print* format strings for DEFVAR, DEFPARAMETER were bogus.
;06/20/90 bill bitset & bitclr
;06/19/90 bill add optional start & end args to with-returned-pstr
; ----- 2.0a1
;06/13/90 bill add note-function-info to defgeneric.
;06/10/90 gb   :USE effectively defaults to *make-package-use-defaults* in DEFPACKAGE.
;06/08/90 gb   print-unreadable-object: keyword name is :identity, not :id.
;06/06/90 bill include doc string in parse-macro-1 expansion per GZ
;06/01/90 bill defgeneric
;06/02/90 gb   with-compilation-unit.
;05/28/90 gb   Flush %immediate accessors, vector accessors defined on them.
;05/21/90 bill Remove doubled body in UNTIL macro.
;05/16/90 gb   type-predicates off of plists, onto an alist.  WITH-STANDARD-IO-SYNTAX.
;05/14/90 gb   them thar IN-PACKAGE and DEFPACKAGE macros.
;05/05/90 gb   locally a special form now.
;05/04/90 gb   defmethod notes function info at compile-time.
;5/3/90  gz    Fix %incf-ptr. Add specialv, remove defobject.
;04/30/90 gb   condition-restarts, define-condition, hairier restart-case, def-kernel-restart,
;              test at loop bottom in while, until, do, do*.  PARSE-MACRO.  Try to make
;              incidental references to loop counters, etc., invisible in dotimes.  Worked for
;              a while, may work again.
;04/11/90 bill add start & end arg to with-pstr
;02/28/90 bill %slot-missing-marker
;02/26/90 bill Wrap without-interrupts around with-port expansion ($sp-saveport does this, too).
;01/17/90  gz  Added with-restart.
;01/05/90  gz  Don't macroexpand into %currenta5.
;12/31/89 gb   newfangled macro-parsing stuff.
;12/25/89 gb   nest a tagbody in do-loop. NTH-VALUE macro.
;12/28/89  gz  defclass-generated setf methods have new value as first arg.
;              SETF macro ignores local functions, defaults to calling #'(setf foo), as per
;              x3j13.  *>>>* This is an incompatible change *<<<* but is needed to
;              make CLOS stuff like what's below work really right.
;29-Nov-89 Mly Make compiling
;              (defclass foo () ((bar :accessor foo-bar)))
;              (setf (foo-bar baz) 'foo)
;              SORT-OF-work.
;              CCL has absolutely NO (NONE, ZERO) model of a compile-time environment.
;12/08/89 bill ignoring-without-interrupts, store-generic-setf-function was brain-damaged.
;11/18/89 gz  Don't use plists for setf stuff.
;             init-list-default here from l1-utils.
;              %structure-refs% hash-table.
;11/10/89 gz  qlfun here from l1-utils. Don't use %izerop in macros. [(eql 0 x) transforms to it].
;10/28/89 gz  (macro -> (defmacro.  Added do-present-symbols.
;11/06/89 gb do,do*,loop : gratuitous mods.
;10/03/89 gz lambda-bind, pascal-true, pascal-false, with-interrupt-level,
;             with-clip-rect, with-new-full-port, with-font-codes, from l1-macros.
;09/30/89 bill Remove def-print-exception: new printer does not use.
;09/27/89 gb simple-string -> ensure-simple-string.  Parse-macro.
;              progv not a macro.  Remove push, pop, pushnew
;              (who can compile anything with "just level-2" loaded ?)
;              remove some (most, all) object-lisp macros.
;09/16/89 bill Remove the last vestiges of object-lisp windows
;              object-lisp itself still exists.
;09/08/89 bill Remove function-binding from store-generic-setf-function
;              Make defclass return the class object
;08/21/89  gz  with-cstr, tweak with-pstr
;07/28/89 Bill "Dialog" => "Dialog-Object"
;07/28/89  gz Support :default-initargs in defclass.
;7/5/89  bill Klugey addition of (defmethod (setf x) ...)
;5/8/89    gz use coerce, debind.
;6-apr-89  as ask-named-item
;23-mar-89 as dovector
;04/07/89 gb  $sp8 -> $sp.
;04/01/89  gz New defpascal syntax, implementation.
;03/24/89  gb Still in March of 89: archived spice macro, destructuring code to
;             lib;spicemacros.lisp.
;16-apr-89 as new CASE uses eq instead of memq
;14-apr-89 as defmacro does a record-arglist
; 03/02/89 gz defmethod, defclass macros.  setf-inverse for %car, %cdr, find-class.
;             queue-fixup, type-specifier.
;             Macroexpand form in setf to avoid useless bindings.
;             Moved get-setf-method back to setf.lisp, no longer used here.
; 01/09/89 gz handler/restart-case/bind, with-simple-restart.
; 12/30/88 gz flushed with-mark
; 12/28/88 gz %structure-ref's may be non-fixnum
; 12/26/88 gz flushed %hiword, %loword, %schar.
; 12/02/88 gz made with-pstr allow decls.
; 11/25/88 gz added def-load-pointers.  Moved eq, eql to l1-utils.
; 11/16/88 gz added def-accessors.  Flushed %get/put-full-long macros.
; 11/15/88 gz Different %[v]stack-block defs. eval-redef for %new-ptr.
;             Removed remaining &key* support.
; 11/09/88 gb &whole comes first in psetq macro and in analyze1.  Don't do
;             destructuring of &body into body, decls, doc; do this ourselves
;             in macros in this file.  Stop supporting &key*. %immediate-inc-ptr,
;             %inc-ptr eval-redeffed as functions.
; 11/03/88 gb define multiple-value-setq in terms of multiple-value-bind.
; 10/29/88 gb eval-redef length, list-length.
; 9/19/88 gb lispequ is compile-time-only now.
; 9/2/88  gz No more list-reverse. Real def for with-macptrs
; 8/25/88 gz %bin-size -> %vect-byte-size, %bin-subtype -> %vect-subtype,
;            punted %bin-address. setf looks at *compile-time-structure-refs*.
;            %get/put-full-long, formerly in l1-files.  pathname structure
;            accessors. %stack-iopb.
;8/21/88 gz  %ndefvar -> %defvar
;8/13/88 gb  %pl-search -> pl-search.
;8/10/88 gz  setf-inverses for aref, svref, %svref, char, schar, symbol-value,
;	     symbol-plist, fill-pointer.  Moved some constants to lispequ.
;	     eval defs for memq, assq, eql.
;8/7/88  gz  provide at end.
;8/4/88  gz  Made defconstant typecheck the sym.
;8/3/88  gz  Less skeletal pushnew.
;8/4/88  gb  %bin-subtype doesn't %ilogand with t.
;7/28/88 gz  Added skeletal pushnew.
;7/27/88 gz  Moved the string-matching functions to l1-files.

;5/17/88 jaj added optional wild-char to %str*=
;5/13/88 jaj added ignore-if-unused for gensyms in parse-defmacro

;6/24/88 gb   %stack-block now a macro.
;5/20/88 gb   make defvar, defparameter use %ndefvar to bootstrap.
;4/22/88 gb   dotimes, dolist test at bottom.
;4/02/88  gz  New macptr scheme. Removed %ind, nremove-from-alist, %rassoc.
;             report-bad-arg can take more than one arg.
;3/29/88  gz  Added %unbound-marker, %currenta5. Flushed pre-1.0 edit history.
;2/24/88  gz  added %svref, %svset
;2/16/88 jaj removed with-pstr calls length instead of %pstr-len
;2/13/88 gb   different or; return multiple values from last form.
;             different psetq; don't require nbutlast to macroexpand.
;             require alltraps at compile time; declare *processing-setf* special.
;2/8/88  jaj  new psetq
;1/28/88 jaj fix to defmacro for dotted arglists, new or
;1/26/88 cfry fixed dotimes & dolist to error check its first arg. dotimes is
;        in 2 places
;        fixed case-aux to check for > 1 T or OTHERWISE clause.
;        fixed defconstant, defparameter, defvar to check its 3rd arg.
;        fixed analyze1 for defmacr destructured lambda-list with &optional
;             default value. bug from isi tests
; 1/6/88 cfry conditionalized analyze-key to work with defsetf 
; 12/22/87 gz  added defccallable.  Made defpascal accept :reg!!!
; 11/20/87 gz  added %word-to-int
; 10/13/87 gb  Moral equivalent of (defsetf ccl::%uvref ccl::%uvset).
; 8/21/87  gz  Made with-dereferenced-handle not expand into trap macros, so it
;              can be used without alltraps.

(in-package :ccl)

(eval-when (eval compile)
  (require "LEVEL-2")
  (require "BACKQUOTE")
  (require "DEFSTRUCT-MACROS")
  (require "SYSEQU"))


;; Constants

(defmacro defconstant (sym val &optional (doc () doc-p) &environment env)
  (setq sym (require-type sym 'symbol)
        doc (if doc-p (require-type doc 'string)))
  `(progn
     (eval-when (:compile-toplevel)
       (define-compile-time-constant ',sym ',val ,env))
     (eval-when (:load-toplevel :execute)
       (%defconstant ',sym ,val ,@(if doc-p (list doc))))))

(eval-when (eval compile)
  (require "LISPEQU")
  (require "LAP")
  (require "LAPMACROS"))


;; Lists

(defmacro %car (x)
  `(car (the cons ,x)))

(defmacro %cdr (x)
  `(cdr (the cons ,x)))

(defmacro %caar (x)
 `(%car (%car ,x)))

(defmacro %cadr (x)
 `(%car (%cdr ,x)))

(defmacro %cdar (x)
 `(%cdr (%car ,x)))

(defmacro %cddr (x)
 `(%cdr (%cdr ,x)))

(defmacro %caaar (x)
 `(%car (%car (%car ,x))))

(defmacro %caadr (x)
 `(%car (%car (%cdr ,x))))

(defmacro %cadar (x)
 `(%car (%cdr (%car ,x))))

(defmacro %caddr (x)
 `(%car (%cdr (%cdr ,x))))

(defmacro %cdaar (x)
 `(%cdr (%car (%car ,x))))

(defmacro %cdadr (x)
 `(%cdr (%car (%cdr ,x))))

(defmacro %cddar (x)
 `(%cdr (%cdr (%car ,x))))

(defmacro %cdddr (x)
 `(%cdr (%cdr (%cdr ,x))))

(defmacro %rplaca (x y)
  `(rplaca (the cons ,x) ,y))

(defmacro %rplacd (x y)
  `(rplacd (the cons ,x) ,y))

; These are open-coded by the compiler to isolate platform
; dependencies.
#+ppc-clos
(progn
(defmacro %unbound-marker-8 ()
  `(%unbound-marker))

(defmacro %slot-missing-marker ()
  `(%illegal-marker))


)

#-ppc-clos
(progn 
(defmacro %unbound-marker-8 ()
  #.(%coerce-to-pointer $undefined))

(defmacro %slot-missing-marker ()
  `(lap-inline () (move.l ($ $illegal) acc)))
)

#-ppc-target
;;  the ppc definition of this won't boot for 68K.
;; the caller in subprims8.lisp ain't compiled.
;; Oh it needs the require-trap.
(defmacro %currenta5 ()
  (when nil ;(ppc-target-p)
    (warn "~s expanded" '(%currenta5)))
  '(%get-ptr (%int-to-ptr #.$currentA5)))

#+ppc-target
(defmacro %currenta5 ()
  #+carbon-compat  
  (warn "~s NOT expanded" '(%currenta5))
  
  ;'(require-trap #_lmgetcurrenta5)
  )

(defmacro %null-ptr () '(%int-to-ptr 0))

;;;Assorted useful macro definitions

(defmacro def-accessors (ref &rest names)
  (define-accessors ref names))

(defmacro def-accessor-macros (ref &rest names)
  (define-accessors ref names t))

(defun define-accessors (ref names &optional no-constants
                             &aux (arg (gensym)) (index 0) progn types)
  (when (listp ref)
    (setq types ref
          ref (pop names)))
  (dolist (name names)
    (when name
      (unless (listp name) (setq name (list name)))
      (dolist (sym name)
        (when sym
          (push `(defmacro ,sym (,arg) (list ',ref ,arg ,index)) progn)
          (unless no-constants
	    (push `(defconstant ,sym ,index) progn)))))
    (setq index (1+ index)))
 `(progn
    ,.(nreverse progn)
    ,@(if types `((add-accessor-types ',types ',names)))
    ,index))

(defmacro specialv (var)
  `(locally (declare (special ,var)) ,var))

(defmacro prog1 (valform &rest otherforms)
 (let ((val (gensym)))
 `(let ((,val ,valform))
   ,@otherforms
   ,val)))

(defmacro prog2 (first second &rest others)
 `(progn ,first (prog1 ,second ,@others)))

(defmacro prog (inits &body body &environment env)
  (multiple-value-bind (forms decls) (parse-body body env nil)
    `(block nil
       (let ,inits
         ,@decls
         (tagbody ,@forms)))))

(defmacro prog* (inits &body body &environment env)
  (multiple-value-bind (forms decls) (parse-body body env nil)
    `(block nil
       (let* ,inits
         ,@decls
         (tagbody ,@forms)))))


(defmacro %stack-block ((&rest specs) &body forms &aux vars lets)
  (dolist (spec specs)
    (destructuring-bind (var ptr &key clear) spec
      (push var vars)
      (push `(,var (%new-ptr ,ptr ,clear)) lets)))
  `(let* ,(nreverse lets)
     (declare (dynamic-extent ,@vars))
     (declare (type macptr ,@vars))
     (declare (unsettable ,@vars))
     ,@forms))

(defmacro %vstack-block (spec &body forms)
  `(%stack-block (,spec) ,@forms))

(defmacro %stack-iopb ((pb np) &rest body)
  `(%stack-block ((,pb $ioPBSize :clear t)
                  (,np 256))
     (%put-byte ,np 0)
     (%put-ptr ,pb ,np $ioFileName)
     ,@body))

(defmacro dolist ((varsym list &optional ret) &body body &environment env)
  (if (not (symbolp varsym)) (signal-program-error $XNotSym varsym))
  (let* ((toplab (gensym))
         (tstlab (gensym))
         (lstsym (gensym)))
    (multiple-value-bind (forms decls) (parse-body body env nil)
     `(block nil
       (let* ((,lstsym ,list) ,varsym)
        ,@decls
          (tagbody
            (go ,tstlab)
            ,toplab
            (setq ,lstsym (cdr (the list ,lstsym)))
            ,@forms
            ,tstlab
            (setq ,varsym (car ,lstsym))
            (if ,lstsym (go ,toplab)))
          ,@(if ret `((progn  ,ret))))))))

#|
(defmacro dolist ((varsym list &optional ret) &body body &environment env)
  (if (not (symbolp varsym)) (signal-program-error $XNotSym varsym))
  (let* ((toplab (gensym))
         (tstlab (gensym))
         (lstsym (gensym)))
    (multiple-value-bind (forms decls) (parse-body body env nil)
     `(let* ((,lstsym ,list) ,varsym)
        ,@decls
        (block nil
          (tagbody
            (go ,tstlab)
            ,toplab
            (locally (declare (type list ,lstsym))
              (setq ,varsym (car ,lstsym) ,lstsym (cdr ,lstsym)))
            ,@forms
            ,tstlab
            (if (not (endp ,lstsym)) (go ,toplab)))
          ,@(if ret `((progn (setq ,varsym nil) ,ret))))))))
|#

(defmacro dovector ((varsym vector &optional ret) &body body &environment env)
  (if (not (symbolp varsym))(signal-program-error $XNotSym varsym))
  (let* ((toplab (gensym))
         (tstlab (gensym))
         (lengthsym (gensym))
         (indexsym (gensym))
         (vecsym (gensym)))
    (multiple-value-bind (forms decls) (parse-body body env nil)
     `(let* ((,vecsym ,vector)
             (,lengthsym (length ,vecsym))
             (,indexsym 0)
             ,varsym)
        ,@decls
        ,@(let ((type (nx-form-type vector env)))
            (unless (eq type t)
              `((declare (type ,type ,vecsym)))))
        (block nil
          (tagbody
            (go ,tstlab)
            ,toplab
            (setq ,varsym (locally (declare (optimize (speed 3) (safety 0)))
                            (aref ,vecsym ,indexsym))
                  ,indexsym (%i+ ,indexsym 1))
            ,@forms
            ,tstlab
            (if (%i< ,indexsym ,lengthsym) (go ,toplab)))
          ,@(if ret `((progn (setq ,varsym nil) ,ret))))))))

(defmacro report-bad-arg (&rest args)
  `(values (%badarg ,@args)))

(defmacro %cons-restart (name action report interactive test)
 `(gvector :istruct 'restart ,name ,action ,report ,interactive ,test))

(defmacro restart-bind (clauses &body body)
  (let* ((restarts (mapcar #'(lambda (clause) 
                               (list (make-symbol (symbol-name (require-type (car clause) 'symbol)))
                                     `(%cons-restart nil nil nil nil nil)))
                           clauses))
         (bindings (mapcar #'(lambda (clause name)
                              `(make-restart ,(car name) ',(car clause)
                                             ,@(cdr clause)))
                           clauses restarts))
        (cluster (gensym)))
    `(let* (,@restarts)
       (declare (dynamic-extent ,@(mapcar #'car restarts)))
       (let* ((,cluster (list ,@bindings))
              (%restarts% (cons ,cluster %restarts%)))
         (declare (dynamic-extent ,cluster %restarts%))
         (progn
           ,@body)))))

(defmacro handler-bind (clauses &body body)
  (let* ((fns)
         (decls)         
         (bindings (mapcan #'(lambda (clause)
                               (debind (condition handler) clause
                                 (if (and (consp handler)
                                           (or (and (eq (car handler)  'function)
                                                    (consp (cadr  handler))
                                                    (eq (car (cadr  handler)) 'lambda))
                                               (eq (car handler)  'lambda)))  ;;;  <<<--- ? from janderson
                                   (let ((fn (gensym)))
                                     (push `(,fn ,handler) fns)
                                     (push `(declare (dynamic-extent ,fn)) decls)
                                     `(',condition ,fn))
                                   (list `',condition
                                         `(require-type ,handler 'function)))))
                           clauses))
        (cluster (gensym)))    
    `(let* (,@fns
            (,cluster (list ,@bindings))
            (%handlers% (cons ,cluster %handlers%)))
       (declare (dynamic-extent ,cluster %handlers%))
       ,@decls
       (progn
         ,@body))))

(defmacro restart-case (&environment env form &rest clauses)
  (let ((cluster nil))
    (when clauses (setq cluster (gensym) form (restart-case-form form env cluster)))
    (flet ((restart-case-1 (name arglist &rest forms)
             (let (interactive report test)
               (loop
                 (case (car forms)
                   (:interactive (setq interactive (cadr forms)))
                   (:report (setq report (cadr forms)))
                   (:test (setq test (cadr forms)))
                   (t (return nil)))
                 (setq forms (cddr forms)))
               (when (and report (not (stringp report)))
                 (setq report `#',report))
               (when interactive
                 (setq interactive `#',interactive))
               (when test
                 (setq test `#',test))
               (values (require-type name 'symbol) arglist report interactive test forms))))
      (cond ((null clauses) form)
            ((and (null (cdr clauses)) (null (cadr (car clauses))))
             (let ((block (gensym)) 
                   (restart-name (gensym)))
               (multiple-value-bind (name arglist report interactive test body)
                                    (apply #'restart-case-1 (car clauses))
                 (declare (ignore arglist))
                 `(block ,block
                    (let* ((,restart-name (%cons-restart ',name () ,report ,interactive ,test))
                           (,cluster (list ,restart-name))
                           (%restarts% (cons ,cluster %restarts%)))
                      (declare (dynamic-extent ,restart-name ,cluster %restarts%))
                      (catch ,cluster (return-from ,block ,form)))
                    ,@body))))
            (t
             (let ((block (gensym)) (val (gensym))
                   (index -1) restarts restart-names restart-name cases)
               (while clauses
                 (setq index (1+ index))
                 (multiple-value-bind (name arglist report interactive test body)
                                      (apply #'restart-case-1 (pop clauses))
                   (push (setq restart-name (make-symbol (symbol-name name))) restart-names)
                   (push (list restart-name `(%cons-restart ',name ,index ,report ,interactive ,test))
                         restarts)
                   (when (null clauses) (setq index t))
                   (push `(,index (apply #'(lambda ,arglist ,@body) ,val))
                         cases)))
               `(block ,block
                  (let ((,val (let* (,@restarts
                                     (,cluster (list ,@(reverse restart-names)))
                                     (%restarts% (cons ,cluster %restarts%)))
                                (declare (dynamic-extent ,@restart-names ,cluster %restarts%))
                                (catch ,cluster (return-from ,block ,form)))))
                    (case (pop ,val)
                      ,@(nreverse cases))))))))))


; Anything this hairy should die a slow and painful death.
; Unless, of course, I grossly misunderstand...
(defun restart-case-form (form env clustername)
  (let ((expansion (macroexpand form env))
        (head nil))
    (if (and (listp expansion)          ; already an ugly hack, made uglier by %error case ...
             (memq (setq head (pop expansion)) '(signal error cerror warn %error)))
      (let ((condform nil)
            (signalform nil)
            (cname (gensym)))
        (case head
          (cerror
           (destructuring-bind 
             (continue cond &rest args) expansion
             (setq condform `(condition-arg ,cond (list ,@args) 'simple-error)
                   signalform `(cerror ,continue ,cname))))
          ((signal error warn)
           (destructuring-bind
             (cond &rest args) expansion
             (setq condform `(condition-arg ,cond (list ,@args) ,(if (eq head 'warning)
                                                                   ''simple-warning
                                                                   (if (eq head 'error)
                                                                     ''simple-error
                                                                     ''simple-condition)))
                   signalform `(,head ,cname))))
          (t ;%error
           (destructuring-bind (cond args fp) expansion
             (setq condform `(condition-arg ,cond ,args 'simple-error)
                   signalform `(%error ,cname nil ,fp)))))
        `(let ((,cname ,condform))
           (with-condition-restarts ,cname ,clustername
             ,signalform)))
      form)))
      

(defmacro handler-case (form &rest clauses &aux last)
  (flet ((handler-case (type var &rest body)
           (when (eq type :no-error)
             (signal-program-error "The :no-error clause must be last."))
           (values type var body)))
    (cond ((null clauses) form)
          ((eq (car (setq last (car (last clauses)))) :no-error)
           (let ((error (gensym))
                 (block (gensym))
                 (var   (cadr last)))
             (if var
               `(block ,error
                  (multiple-value-call #'(lambda ,@(cdr last))
                                       (block ,block
                                         (return-from ,error
                                           (handler-case (return-from ,block ,form)
                                             ,@(butlast clauses))))))
               `(block ,error
                  (block ,block
                    (return-from ,error
                      (handler-case (return-from ,block ,form)
                        ,@(butlast clauses))))
                  (locally ,@(cddr last))))))
          ((null (cdr clauses))
           (let ((block   (gensym))
                 (cluster (gensym)))
             (multiple-value-bind (type var body)
                                  (apply #'handler-case (car clauses))
               (if var
                 `(block ,block
                    ((lambda ,var ,@body)
                      (let* ((,cluster (list ',type))
                            (%handlers% (cons ,cluster %handlers%)))
                       (declare (dynamic-extent ,cluster %handlers%))
                       (catch ,cluster (return-from ,block ,form)))))
                 `(block ,block
                    (let* ((,cluster (list ',type))
                           (%handlers% (cons ,cluster %handlers%)))
                      (declare (dynamic-extent ,cluster %handlers%))
                      (catch ,cluster (return-from ,block ,form)))
                    (locally ,@body))))))
          (t (let ((block (gensym)) (cluster (gensym)) (val (gensym))
                   (index -1) handlers cases)
               (while clauses
                 (setq index (1+ index))
                 (multiple-value-bind (type var body)
                                      (apply #'handler-case (pop clauses))                   
                   (push `',type handlers)
                   (push index handlers)
                   (when (null clauses) (setq index t))
                   (push (if var
                           `(,index ((lambda ,var ,@body) ,val))
                           `(,index (locally ,@body))) cases)))
               `(block ,block
                  (let ((,val (let* ((,cluster (list ,@(nreverse handlers)))
                                     (%handlers% (cons ,cluster %handlers%)))
                                (declare (dynamic-extent ,cluster %handlers%))
                                (catch ,cluster (return-from ,block ,form)))))
                    (case (pop ,val)
                      ,@(nreverse cases)))))))))

(defmacro with-simple-restart ((restart-name format-string &rest format-args)
                               &body body
                               &aux (cluster (gensym)) (temp (make-symbol (symbol-name restart-name))))
  (unless (and (stringp format-string)
               (null format-args)
               (not (%str-member #\~ (ensure-simple-string format-string))))
    (let ((stream (gensym)))
      (setq format-string `#'(lambda (,stream) (format ,stream ,format-string ,@format-args)))))
  `(let* ((,temp (%cons-restart ',restart-name
                                nil
                                ,format-string
                                nil
                                nil))
          (,cluster (list ,temp))
          (%restarts% (cons ,cluster %restarts%)))
     (declare (dynamic-extent ,temp ,cluster %restarts%))
     (catch ,cluster ,@body)))

;Like with-simple-restart but takes a pre-consed restart.  Not CL.
(defmacro with-restart (restart &body body &aux (cluster (gensym)))
  `(let* ((,cluster (list ,restart))
          (%restarts% (cons ,cluster %restarts%)))
     (declare (dynamic-extent ,cluster %restarts%))
     (catch ,cluster ,@body)))

(defmacro ignore-errors (&rest forms)
  `(handler-case (progn ,@forms)
     (error (condition) (values nil condition))))

(defmacro def-kernel-restart (&environment env errno name arglist &body body)
  (multiple-value-bind (body decls)
                       (parse-body body env)
    `(let* ((fn (nfunction ,name (lambda ,arglist ,@decls (block ,name ,@body))))
            (pair (assq ,errno ccl::*kernel-restarts*)))
       (if pair
         (rplacd pair fn)
         (push (cons ,errno fn) ccl::*kernel-restarts*))
       fn)))

;(rm:heading 2 "Generally useful macros")

;(rm:programmer's-comment 17 "rm:heading doesn't work anymore.  That's
; why the call above has been commented out.  If you remove that call,
; please be sure to leave this comment here, so that we'll know where to
; re-insert the call to rm:heading.
; Of course, since the low-level-system keeps changing, this advice may not be
; as winning as it sounds.")

;;; Setf.

;  If you change anything here, be sure to make the corresponding change
;  in get-setf-method .
(defmacro setf (&rest args &environment env)
  "Takes pairs of arguments like SETQ.  The first is a place and the second
  is the value that is supposed to go into that place.  Returns the last
  value.  The place argument may be any of the access forms for which SETF
  knows a corresponding setting form."
  (let ((temp (length args))
        (accessor nil))
    (cond ((eq temp 2)
           (let* ((form (car args)) 
                  (value (cadr args)))
             ;This must match get-setf-method .
             (if (atom form)
               (progn
                 (unless (symbolp form)(signal-program-error $XNotSym form))
                 `(setq ,form ,value))
               (if nil ; (eq (car form) 'values)
                 (setf-values form value)
                 (multiple-value-bind (ftype local-p)
                                      (function-information (setq accessor (car form)) ENV)
                   (if local-p
                     (if (eq ftype :function)
                       ;Local function, so don't use global setf definitions.
                       (default-setf form value env)
                       `(setf ,(macroexpand-1 form env) ,value))
                     (cond
                      ((setq temp (%setf-method accessor))
                       (if (symbolp temp)
                         `(,temp ,@(cdar args) ,value)
                         (multiple-value-bind (dummies vals storevars setter #|getter|#)
                                              (funcall temp form env)
                           (do* ((d dummies (cdr d))
                                 (v vals (cdr v))
                                 (let-list nil))
                                ((null d)
                                 (setq let-list (nreverse let-list))
                                 `(let* ,let-list
                                    (declare (ignorable ,@dummies))
                                    (multiple-value-bind ,storevars ,value
                                      #|,getter|#
                                      ,setter)))
                             (push (list (car d) (car v)) let-list)))))
                      ((and (type-and-refinfo-p (setq temp (or (environment-structref-info accessor env)
                                                               (and #-bccl (boundp '%structure-refs%)
                                                                    (gethash accessor %structure-refs%)))))
                            (not (refinfo-r/o (if (consp temp) (%cdr temp) temp))))
                       (if (consp temp)
                         ;; strip off type, but add in a require-type
                         (let ((type (%car temp)))
                           `(the ,type (setf ,(defstruct-ref-transform (%cdr temp) (%cdar args))
                                             (require-type ,value ',type))))
                         `(setf ,(defstruct-ref-transform temp (%cdar args))
                                ,value)))
                      (t
                       (multiple-value-bind (res win)
                                            (macroexpand-1 form env)
                         (if win
                           `(setf ,res ,value)
                           (default-setf form value env)))))))))))
          ((oddp temp)
           (error "Odd number of args to SETF."))
          (t (do* ((a args (cddr a)) (l nil))
                  ((null a) `(progn ,@(nreverse l)))
               (push `(setf ,(car a) ,(cadr a)) l))))))

#|
(setf-values '(values (aref foo (gag)) (aref zoo (bar))) '(values 1 2))
(setf (values (aref foo (gag)) (aref zoo (bar))) (values 1 2))
(setf (values x y) (values 1 3))


=>
(let* ((g1 foo)
       (g2 (gag))
       (g3 zoo)
       (g4 (bar)))
  (multiple-value-bind (g5 g6)
                       (values 1 2)
    (setf (aref g1 g2) g5)
    (setf (aref g2 g3) g6)
    (values g5 g6)))
|#

;;;  ;; wrong if within symbol-macrolet
#+ignore
(defun setf-values (form value)
  (let* ((nplaces (length (cdr form)))
        (val-gensyms)
        (place-binds)
        (n 0)
        (setters))  ;; i.e list (setf place1 gensym1)
    (dotimes (i nplaces)(push (gensym) val-gensyms))
    (setq val-gensyms (nreverse val-gensyms))
    (dolist (place (cdr form))  ;; the places     
      (push  
       (if (symbolp place)
         `(setf ,place ,(nth n val-gensyms))
         `(setf (,(car place) ,@(mapcar #'(lambda (arg) (let ((g (gensym)))
                                                     ;(push g place-gensyms)
                                                     (push `(,g ,arg) place-binds)
                                                     g))
                                          (cdr place)))
                   ,(nth n val-gensyms)))
            setters)
      (incf n)) 
    (setq setters (nreverse setters))   
    `(let* ,(nreverse place-binds)       
       (multiple-value-bind ,val-gensyms ,value
          ,@setters
          (values ,@val-gensyms)))))

(defun default-setf (setter value &optional env)
  (let* ((reader (car setter))
         (args (cdr setter))
         (gensyms (mapcar #'(lambda (sym) (declare (ignore sym)) (gensym)) args))
         types declares)
    (flet ((form-type (form)
             (if *compile-definitions*
               (nx-form-type form env)
               t)))
      (declare (dynamic-extent #'form-type))
      (setq types (mapcar #'form-type args)))
    (dolist (sym gensyms)
      (let ((sym-type (pop types)))
        (unless (or (eq sym-type t)(not (type-specifier-p sym-type env)))
          (push `(type ,sym-type ,sym) declares))))
    `(let ,(mapcar #'list gensyms args)
       ,@(and declares (list `(declare ,@(nreverse declares))))
       (funcall #'(setf ,reader) ,value ,@gensyms))))

(defsetf elt set-elt)
(defsetf car set-car)
(defsetf first set-car)
(defsetf cdr set-cdr)
(defsetf rest set-cdr)
(defsetf uvref uvset)
(defsetf aref aset)
(defsetf svref svset)
(defsetf %svref %svset)
(defsetf char set-char)
(defsetf schar set-schar)
(defsetf %scharcode %set-scharcode)
(defsetf symbol-value set)
(defsetf symbol-plist set-symbol-plist)
(defsetf fill-pointer set-fill-pointer)


; This incredibly essential thing is part of ANSI CL; put it in the
; right package someday.
; Like maybe when it says something about doc strings, or otherwise
; becomes useful.

(defun parse-macro (name arglist body &optional env)
  (values (parse-macro-1 name arglist body env)))

; Return a list containing a special declaration for SYM
; if SYM is declared special in decls.
; This is so we can be pedantic about binding &WHOLE/&ENVIRONMENT args
; that have been scarfed out of a macro-like lambda list.
; The returned value is supposed to be suitable for splicing ...
(defun hoist-special-decls (sym decls)
  (when sym
    (dolist (decl decls)
      (dolist (spec (cdr decl))
        (when (eq (car spec) 'special)
          (dolist (s (%cdr spec))
            (when (eq s sym)
              (return-from hoist-special-decls `((declare (special ,sym)))))))))))

(defun parse-macro-1 (name arglist body &optional env)
  (unless (verify-lambda-list arglist t t t)
    (error "Invalid lambda list ~s" arglist))
  (multiple-value-bind (lambda-list whole environment)
                       (normalize-lambda-list arglist t t)
    (multiple-value-bind (body local-decs doc)
                         (parse-body body env t)
      (unless whole (setq whole (gensym)))
      (unless environment (setq environment (gensym)))
      (values
       `(lambda (,whole ,environment)
          (declare (ignore-if-unused ,environment))
          ,@(hoist-special-decls whole local-decs)
          ,@(hoist-special-decls environment local-decs)
          (macro-bind ,lambda-list ,whole
                      ,@local-decs 
                      (block ,name ,@body)))
       doc))))

; This sux; it calls the compiler twice (once to shove the macro in the
; environment, once to dump it into the file.)
(defmacro defmacro  (name arglist &body body &environment env)
  (unless (symbolp name)(signal-program-error $XNotSym name))
  (unless (listp arglist) (signal-program-error "~S is not a list." arglist))
  (multiple-value-bind (lambda-form doc)
                       (parse-macro-1 name arglist body env)
    (let* ((normalized (normalize-lambda-list arglist t t))
           (body-pos (position '&body normalized))
           (argstring (let ((temp nil))
                        (dolist (arg normalized)
                          (if (eq arg '&aux)
                            (return)
                            (push arg temp)))
                        (format nil "~:a" (nreverse temp)))))
      (if (and body-pos (memq '&optional normalized)) (decf body-pos))
      `(progn
         (eval-when (:compile-toplevel)
           (define-compile-time-macro ',name ',lambda-form ',env))
         (eval-when (:load-toplevel :execute)
           (%macro 
            (nfunction ,name ,lambda-form)
            '(,doc ,body-pos . ,argstring))
           ',name)))))

;; ---- allow inlining setf functions
(defmacro defun (spec args &body body &environment env &aux global-name inline-spec)
  (unless (function-spec-p spec) (report-bad-arg spec '(satisfies function-spec-p)))
  (setq args (require-type args 'list))
  (setq body (require-type body 'list))
  (multiple-value-bind (forms decls doc) (parse-body body env t)
    (cond ((symbolp spec)
           (setq global-name spec)
           (setq inline-spec spec)
           (setq body `(block ,spec ,@forms)))
          ((and (consp spec) (eq 'setf (%car spec)))
           (setq inline-spec spec)
           (setq body `(block ,(cadr spec) ,@forms)))
          (t (setq body `(progn ,@forms))))
    #+ignore ; moved to %defun
    (let* ((fbinding (fboundp spec))
           (gf (if (functionp fbinding) fbinding))
           (already-gf (and gf (typep gf 'standard-generic-function))))
      (when already-gf
        (cerror "Replace it with a function"
                "~S is a generic function" spec)))
      
    (let* ((lambda-expression `(lambda ,args 
                                ,@(if global-name
                                    `((declare (global-function-name ,global-name))))
                                ,@decls ,body))
           (info (if (and inline-spec
                          (or (null env)
                              (definition-environment env t))
                          (nx-declared-inline-p inline-spec env)
                          (not (and (symbolp inline-spec)
                                    (gethash inline-spec *NX1-ALPHATIZERS*))))
                   (cons doc lambda-expression)
                   doc)))
      `(progn
         (eval-when (:compile-toplevel)
           (note-function-info ',spec ',lambda-expression ,env))
         (%defun (nfunction ,spec ,lambda-expression) ',info)
         ',spec))))

(defmacro %defvar-init (var initform doc)
  `(unless (%defvar ',var ,doc)
     (setq ,var ,initform)))

(defmacro defvar (&environment env var &optional (value () value-p) doc)
  (if (and doc (not (stringp doc))) (report-bad-arg doc 'string))
  (if (and (compile-file-environment-p env) (not *fasl-save-doc-strings*))
    (setq doc nil))
 `(progn
    (eval-when (:compile-toplevel)
      (note-variable-info ',var ,value-p ,env))
    ,(if value-p
       `(%defvar-init ,var ,value ,doc)
       `(%defvar ',var))
    ',var))
         

(defmacro defparameter (&environment env var value &optional doc)
  (if (and doc (not (stringp doc))) (signal-program-error "~S is not a string." doc))
  (if (and (compile-file-environment-p env) (not *fasl-save-doc-strings*))
    (setq doc nil))
  `(progn
     (eval-when (:compile-toplevel)
       (note-variable-info ',var t ,env))
     (%defparameter ',var ,value ,doc)))

(defmacro defglobal (&environment env var value &optional doc)
  (if (and doc (not (stringp doc))) (signal-program-error "~S is not a string." doc))
  (if (and (compile-file-environment-p env) (not *fasl-save-doc-strings*))
    (setq doc nil))
  `(progn
     (eval-when (:compile-toplevel)
       (note-variable-info ',var :global ,env))
     (%defglobal ',var ,value ,doc)))


(defmacro defloadvar (&environment env var value &optional doc)
  `(progn
     (defvar ,var ,@(if doc `(nil ,doc)))
     (def-ccl-pointers ,var ()
       (setq ,var ,value))
     ',var))


(defmacro qlfun (name args &body body)
  `(nfunction ,name (lambda ,args ,@body)))

(defmacro defpascal (name arglist &body body &environment env)
  (if t ;(ppc-target-p)
    (defpascal-ppc name arglist body env)
    #+ignore
    (defpascal-68k name arglist body env)))


#|
(defun defpascal-68k (name arglist body env)
  (multiple-value-bind (argnames code lfun-offset without-interrupts) (defpascal-code arglist)
    (multiple-value-bind (body decls) (parse-body body env)
        `(progn
           (declaim (special ,name))
           (define-pascal-function
             (nfunction 
              ,name
              (lambda ,argnames
                ,@decls
                (block
                  ,name
                  ,@body)))
             ',code
             ,lfun-offset
           ',without-interrupts)))))
|#


#+ppc-target
; The 68k version is below
(defun defpascal-code (arglist)
  (declare (ignore arglist))
  (error "Can't compile defpascal for 68K on the PPC"))

; Makes it easy to expand for testing in a 68K world
(defmacro ppc-defpascal (name args &body body &environment env)
  (defpascal-ppc name args body env))

#|
(add-pascal-upp-alist 'collapse-begin-proc #'(lambda (procptr)(#_neweventhandlerupp procptr)))

;; allow eliminating above by specifying :upp-creator to defpascal
(defpascal collapse-begin-proc00 (:upp-creator #_neweventhandlerupp :ptr targetref :ptr eventref :word)
  (with-timer
    (let ((*interrupt-level* 0)) ;; defpascal binds to -1
      (errchk (#_callnexteventhandler targetref eventref))))  
     #$noerr) 
|#

;; caller must "casify" the string correctly
;; (add-pascal-upp-alist-cfm 'control-color-proc "NewControlColorUPP")
(defmacro add-pascal-upp-alist-cfm (name upp-string)
  `(add-pascal-upp-alist  ,name                        
                        #'(lambda (procptr)
                            (ff-call-slep ,(get-shared-library-entry-point upp-string)
                                          :address procptr
                                          :address))))

(defmacro add-pascal-upp-alist-macho (name upp-string)  
  `(progn
     (pushnew ,name *macho-upps*)
     (add-pascal-upp-alist  ,name                        
                         #'(lambda (procptr)
                             (ppc-ff-call (macho-address ,(get-macho-entry-point upp-string))
                                          :address procptr
                                          :address)))))
     

(defun defpascal-ppc (name args body env &optional (based #$kPascalStackBased))
  (let ((stack-ptr-fixnum (gensym))
        (stack-ptr (gensym))
        (result (gensym))
        (arg-names nil)
        (arg-types nil)
        (return-type nil)
        (args args)
        (dynamic-extents nil)
        (upp-creator nil)
        (without-interrupts t))
    (loop
      (when (null args) (return))
      (when (null (cdr args))
        (setq return-type (car args))
        (return))
      (let ((type (pop args))
            (name (pop args)))
        (cond ((eq type :without-interrupts) (setq without-interrupts name))
              ((eq type :upp-creator)
               (setq upp-creator name))
              (t (push type arg-types)
                 (push name arg-names)))))
    (setq arg-names (nreverse arg-names)
          arg-types (nreverse arg-types))
    (let* ((offset 0)
           (need-stack-ptr (or arg-names (and return-type (neq return-type :void))))
           (lets
            (mapcar #'(lambda (name type)
                        (let* ((mactype (find-mactype type))
                               (mactype-name (mactype-name mactype)))
                          (prog1
                            (list name
                                  (funcall (or (mactype-access-coercion mactype) 'identity)
                                           `(,(mactype-access-operator mactype)
                                             ,stack-ptr
                                             ,(+ offset (- 4 (mactype-record-size mactype))))))
                            (when (eq mactype-name :pointer)
                              (push name dynamic-extents))
                            (incf offset 4))))
                    arg-names arg-types)))
      
      (multiple-value-bind (body decls doc-string) (parse-body body env)
        `(progn
           
           ,(if (memq :callback-testing *features*)
              (progn
                (warn "eliding special declamation in defpascal~%~
                       because :callback-testing is on *features*")
                nil)
              `(declaim (special ,name)))
           ,(if upp-creator
              (progn (if (symbolp upp-creator)(setq upp-creator (trap-string upp-creator)))
                     `(add-pascal-upp-alist-macho ',name ,upp-creator))
              #+ignore
              `(add-pascal-upp-alist ',name
                                     #'(lambda (procptr)
                                         (,upp-creator procptr))))                                   
           (define-ppc-pascal-function-2
             (nfunction ,name
                        (lambda (,stack-ptr-fixnum)
                          (declare (ignore-if-unused ,stack-ptr-fixnum))
                          (block ,name
                            (with-macptrs (,@(and need-stack-ptr (list `(,stack-ptr))))
                              ,(when need-stack-ptr
                                 `(%setf-macptr-to-object ,stack-ptr ,stack-ptr-fixnum))
                              (let ((,result (let ,lets
                                               (declare (dynamic-extent ,@dynamic-extents))
                                               ,@decls
                                               ,@body)))
                                (declare (ignore-if-unused ,result))
                                ,(when (and return-type (neq return-type :void))
                                   (let* ((mactype (find-mactype return-type))
                                          (store-coercion (mactype-store-coercion mactype)))
                                     (if (eq :pointer (mactype-name mactype))
                                       `(setf (%get-ptr ,stack-ptr)
                                              ,(if store-coercion
                                                 (funcall store-coercion result)
                                                 result))
                                       `(setf (%get-long ,stack-ptr)
                                              ,(if store-coercion
                                                 (funcall store-coercion result)
                                                 result))))))))))
             ,(make-proc-info arg-types return-type based)
             ,doc-string
             ,without-interrupts
             ))))))

(defmacro lfun-bits-known-function (f)
  (let* ((temp (gensym)))
    `(let* ((,temp ,f))
      (%svref ,temp (the fixnum (1- (the fixnum (uvsize ,temp))))))))

; %Pascal-Functions% Entry
; Used by "l1;ppc-callback-support" & "lib;dumplisp"
(def-accessor-macros %svref
  pfe.routine-descriptor
  pfe.proc-info
  pfe.lisp-function
  pfe.sym
  pfe.without-interrupts)

(defun bytes-to-size-code (bytes)
  (or (svref #(#.#$kNoByteCode #.#$kOneByteCode #.#$kTwoByteCode nil #.#$kFourByteCode)
             (or bytes 0))
      (error "No 3 byte code")))
    
; Eventually, this may want to take an arg for the calling-convention-code
(defun make-proc-info (arg-types return-type &optional (based #$kPascalStackBased))
  (when (> (length arg-types) 13)       ; should compute on #$kStackParameterMask
    (error "Routine descriptors can encode at most 13 arguments"))
  (let* ((calling-convention-code (ash based #$kCallingConventionPhase))
         (return-bytes (if (and return-type (neq return-type :void))
                         (mactype-record-size (find-mactype return-type))
                         0))
         (return-code (ash (bytes-to-size-code return-bytes) #$kResultSizePhase))
         (arg-types-code 0)
         (arg-types-shift #$kStackParameterPhase))
    (dolist (type arg-types)
      (let ((bytes (mactype-record-size (find-mactype type))))
        (incf arg-types-code (ash (bytes-to-size-code bytes) arg-types-shift))
        (incf arg-types-shift #$kStackParameterWidth)))
    (+ calling-convention-code return-code arg-types-code)))

;;  for debugging
#|
(defun unmake-proc-info (info)
  (let ((based nil)
        (res nil)
        (args nil))
    (setq based (logand (ash info #$kCallingConventionPhase)  #$kcallingconventionmask))
    (setq  res (ash (logand info  #$kResultSizeMask) (- #$kResultSizePhase)))
    (if (eq res 3)(setq res 4))
    (setq info (ash info (- #$kStackParameterPhase)))
    (loop
      (if (eq info 0) 
        (return)
        (progn
          (let ((crud (logand info (1- (ASH 1 #$kStackParameterWidth)))))
            (if (eq crud 3)(push 4 args)(push crud args)))
          (setq info (ash info (- #$kStackParameterWidth))))))    
    (values (reverse args) res based))
|#
    

#-ppc-target
(progn

(eval-when (eval compile)
  (let* ((code-1 (%lap-words '((sub ($ 4) sp)
                               (clr.l (-@ sp))
                               (pea (atemp1 (- (+ 4 2 64))))
                               (spush (header $v_macptr 8))
                               (move.l sp acc)
                               (add.w ($ $t_vector) acc)
                               (begin_csarea)
                               (set_nargs 1))))
         (code (append code-1
                       (list $jsr_absl 0 0)
                       (%lap-words '((spop_csarea) (lea (sp 16) sp) (rts)))
                       '(0 1))))
    (defmacro pascal-regcode-lfun-offset () (1+ (length code-1)))
    (defmacro pascal-regcode-code  () (coerce code '(vector (signed-byte 16))))))

(defvar *pascal-full-longs* nil "If true, use bignums to get full 32-bit Pascal arguments")

(defun defpascal-code (arglist)
  (let ((without-interrupts t)
        (arglist-tail arglist))
    (loop
      (when (null (cdr arglist-tail))
        (return))
      (when (eq (car arglist-tail) :without-interrupts)
        (setq without-interrupts (cdr arglist-tail))
        (return))
      (setq arglist-tail (cdr arglist-tail)))  ; aargh - or is it cddr?
  (when (and (eq (length arglist) 2) (eq ':reg (%car arglist)))
    (return-from defpascal-code
                 (values (list (%cadr arglist))
                         (pascal-regcode-code)
                (pascal-regcode-lfun-offset)
                without-interrupts)))
  (let* ((argsyms ()) lfun-offset (code ())
         (argtypes ()) (result 0) (numbytes 0) (numargs 0) (numptrs 0))
    (while (%cdr arglist)
      (let ((type (%cdr (assq (%car arglist) *stack-trap-arg-keywords*))))
        (when (null type) (signal-program-error "~S is not a stack trap argument keyword."(%cadr arglist)))
        (push (%cadr arglist) argsyms)
        (push type argtypes)
        (setq numbytes (%i+ numbytes (if (eq type 3) 2 4)))
        (when (eq type 0) (setq numptrs (%i+ numptrs 1)))
        (setq numargs (%i+ numargs 1)))
      (setq arglist (%cddr arglist)))
    (when arglist
      (unless (setq result (%cdr (assq (%car arglist) *stack-trap-output-keywords*)))
        (signal-program-error "~S is not a stack trap output keyword." (%car arglist))))
    (setq argsyms (nreverse argsyms) argtypes (nreverse argtypes))
    ;This is kinda silly, but I can't figure out a good way to interface to
    ;the compiler... Anyhow, it's simple enough.
    (macrolet ((lgen (&rest args)
                     `(setq code (list* ,@(reverse (%lap-words args)) code)))
               (wgen (&rest args) ;-> doesn't preserve evaluation order
                     `(setq code (list* ,@(reverse args) code)))
               (lreg (reg) (lap-reg-op reg)))
      (if (%i<= numbytes 4)               ; add.w #numbytes+4,a1
        (wgen (%i+ #o50111 (%ilsl 9 (%ilogand 7 (%i+ numbytes 4)))))
        (wgen #o151374 (%i+ numbytes 4)))
      (do ((n numargs (%i- n 1))
           reg regname)
          ((eql 0 n))
        (multiple-value-setq (reg regname)
          (case n
            (1 (values (lreg arg_z) 'arg_z))
            (2 (values (lreg arg_y) 'arg_y))
            (3 (values (lreg arg_x) 'arg_x))
            (t (values (lreg da)    'da))))
        (case (pop argtypes)
          (0                            ; :pointer
           (lgen (sub ($ 4) sp)
                 (clr.l (-@ sp))
                 (spush (-@ atemp1))
                 (move.l (header $v_macptr 8) (-@ sp)))
           (wgen
            (%i+ #o20017 (%ilsl 9 reg)) ;move.l sp,reg
            (%i+ (%i+ #o50100 (%ilsl 9 $t_vector)) reg))) ; addq.w #t_vector,reg
          (1                            ; :longword
           (if *pascal-full-longs*
             (setq code (nreconc (%lap-words
                                  `((move.l -@a1 ,regname)
                                    (spush ,regname)
                                    (if# (ne (and.l ($ #xE0000000) ,regname))
                                      (move.l ($ 2) dtemp0)     ; # bignum words
                                      (spush a1)
                                      ,@(case regname
                                          (arg_y `((vpush arg_x)))
                                          (arg_z `((vpush arg_x)
                                                   (vpush arg_y))))
                                      (begin_csarea)
                                      (jsr_subprim $sp-ConsBignum)      ; atemp0 <- bignum
                                      (spop_csarea)
                                      ,@(case regname
                                          (arg_y `((vpop arg_x)))
                                          (arg_z `((vpop arg_x)
                                                   (vpop arg_y))))
                                      (spop a1)
                                      (spop ,regname)
                                      (move.l ,regname (atemp0 $v_data))
                                      (move.l atemp0 ,regname)
                                      else#
                                      (spop ,regname)
                                      (mkint ,regname))
                                    ))
                                 code))
             (wgen
              (%i+ #o20041 (%ilsl 9 reg))       ; move.l -(a1),reg
              (%i+ #o163610 reg))))     ; mkint reg
          (3 (wgen                      ; :word
              (%i+ #o30041 (%ilsl 9 reg))   ; move.w -(a1),reg
              (%i+ #o44300 reg)     ; ext.l reg
              (%i+ #o163610 reg))))   ; mkint reg
        (when (eq reg (lreg da))          ; vpush reg
          (wgen (%i+ #o26400 (lreg da)))))
      (unless (eql 0 numbytes)
        (lgen (move.l -@a1 da))           ; relocate return address
        (if (%i<= numbytes 8)             ; add.w #numbytes,a1
          (wgen (%i+ #o50111 (%ilsl 9 (%ilogand 7 numbytes))))
          (wgen #o151374 numbytes))
        (wgen #o21511 (- (+ numbytes 4 2 4))) ; move.l a1,-numbytes-4-2-4(a1) [saved sp]
        (lgen (move.l da a1@+)))
      (unless (eq result 0)             ; save value pointer
        (lgen (spush a1)))
      (lgen (begin_csarea))
      (if (%i< numargs 32)                ; set_nargs numargs
        (wgen (%i+ (%i+ #o70000 (%ilsl 9 (lreg nargs))) (%ilsl 2 numargs)))
        (wgen (%i+ #o20074 (%ilsl 9 (lreg nargs))) (%ilsl 2 numargs)))
      (wgen $jsr_absl)
      (setq lfun-offset (length code))
      (wgen 0 0)
      (when (eq result 4)               ; :ptr
        (lgen (move.l acc atemp0)
              (jsr_subprim $sp-macptrptr)))
      (lgen (spop_csarea))
      (unless (eq result 0)
        (lgen (spop atemp1))
        (cond ((eq result 4)            ; :ptr
               (lgen (move.l atemp0 (atemp1))))
              ((eq result 5)            ; :long
               (lgen (getint acc) (move.l acc (atemp1))))
              (t                        ; :word
               (lgen (getint acc) (move.w acc (atemp1))))))
      (unless (eql 0 numptrs)
        (wgen #o157374 (%ilsl 4 numptrs)))   ; add.w #numptrs*16,sp
      (lgen (rts))
      (wgen 0 1))
    (values argsyms
            (coerce (mapcar #'%word-to-int (nreverse code)) '(vector (signed-byte 16)))
              lfun-offset
              without-interrupts))))

) ; #-ppc-target

#+ppc-target
(defvar *pascal-full-longs* t)

(defmacro defccallable (function-name arglist &body body &environment env)
  (if (ppc-target-p)
    (defpascal-ppc function-name arglist body env #$kCStackBased)
    (multiple-value-bind (body decls)
                         (parse-body body nil)
      (let* ((offset 4)
             (spsym (make-symbol "SP"))
             (regsym (make-symbol "REGBUF"))
             (result :void)
             (lets ())
             (without-interrupts (and (consp (car body)) (eq (%caar body) 'without-interrupts)))
             name size)
        (when without-interrupts (setf (%caar body) 'progn))
        (while arglist
          (setq size (pop arglist))
          (if (null arglist)
            (setq result size)
            (progn
              (setq name (pop arglist))
              (unless (and (symbolp name) (not (keywordp name)))
                (signal-program-error "~S is not a non-keyword symbol." name))
              (push `(,name ,(cond ((eq size :ptr) `(%get-ptr ,spsym ,offset))
                                   ((eq size :word) `(%get-word ,spsym ,(%i+ offset 2)))
                                   ((eq size :long) `(%get-long ,spsym ,offset))
                                   (t (signal-program-error "~S is not (member :ptr :word :long)." size))))
                    lets)
              (setq offset (%i+ offset 4)))))
        (when lets (setq lets (cons `(,spsym (%get-ptr ,regsym 60)) (nreverse lets))))
        (setq lets `(let* ,lets ,@decls ,@body))
        (cond ((eq result :ptr)
               (setq lets `(%put-ptr ,regsym ,lets)))
              ((eq result :long)
               (setq lets `(%put-long ,regsym ,lets)))
              ((eq result :word)
               (setq lets `(%put-long ,regsym (%word-to-int ,lets))))
              ((eq result :void)
               (setq lets `(progn ,lets (%put-long ,regsym 0))))
              (t (signal-program-error "~S is not (member :ptr :long :word :void)." result)))
        (when without-interrupts (setq lets `(without-interrupts ,lets)))
        `(defpascal ,function-name (:reg ,regsym) ,lets)))))


(defmacro cond (&rest args &aux clause)
  (when args
     (setq clause (car args))
     (if (cdr clause)         
         `(if ,(car clause) (progn ,@(cdr clause)) (cond ,@(cdr args)))
       (if (cdr args) `(or ,(car clause) (cond ,@(cdr args)))
                      `(values ,(car clause))))))

(defmacro and (&rest args)
  (if (null args) t
    (if (null (cdr args)) (car args)
      `(if ,(car args) (and ,@(cdr args))))))

(defmacro or (&rest args)
  (if args
    (if (cdr args)
      (do* ((temp (gensym))
            (handle (list nil))
            (forms `(let ((,temp ,(pop args)))
                      (if ,temp ,temp ,@handle))))
           ((null (cdr args))
            (%rplaca handle (%car args))
            forms)
        (%rplaca handle `(if (setq ,temp ,(%car args)) 
                           ,temp 
                           ,@(setq handle (list nil))))
        (setq args (%cdr args)))
      (%car args))))

#|
(defmacro case (key &body forms)
   " Last clause may have a test of t or OTHERWISE. as in CL." 
; That's because this IS CL.  Thank you.
   (let ((key-var (gensym)))
     `(let ((,key-var ,key))
        (cond ,@(case-aux forms key-var)))))

(defun case-aux (clauses key-var &optional t-or-otherwise-seen?)
   (if clauses
       (let* ((key-list (caar clauses))
              (test (if (memq key-list '(t otherwise)) 
                      (if t-or-otherwise-seen?
                        (error "More than 1 T or OTHERWISE clause. ~S" clauses)
                        (progn (setq t-or-otherwise-seen? t) t))
		      (if (atom key-list) `(eql ,key-var ',key-list)
		        (if (null (%cdr key-list)) `(eql ,key-var ',(%car key-list))
			 `(member ,key-var ',key-list)))))
              (consequent-list (or (%cdar clauses) '(nil))))
           (cons (cons test consequent-list)                                            
                  (case-aux (%cdr clauses) key-var t-or-otherwise-seen?
             )))))
|#

(defmacro case (key &body forms) 
   (let ((key-var (gensym)))
     `(let ((,key-var ,key))
        (declare (ignore-if-unused ,key-var))
        (cond ,@(case-aux forms key-var nil nil)))))

(defmacro ccase (keyplace &body forms)
  (let* ((key-var (gensym))
         (tag (gensym)))
    `(prog (,key-var)
       ,tag
       (setq ,key-var ,keyplace)
       (return (cond ,@(case-aux forms key-var tag keyplace))))))

(defmacro ecase (key &body forms)
  (let* ((key-var (gensym)))
    `(let ((,key-var ,key))
       (declare (ignore-if-unused ,key-var))
       (cond ,@(case-aux forms key-var 'ecase nil)))))
       
(defun case-aux (clauses key-var e-c-p placename &optional (used-keys (list (list '%case-core))))
  (if clauses
      (let* ((key-list (caar clauses))
             (stype (if e-c-p (if (eq e-c-p 'ecase) e-c-p 'ccase) 'case))
             (test (cond ((and (not e-c-p)
                               (or (eq key-list 't)
                                   (eq key-list 'otherwise))
                          t))
                         (key-list
                          (cons 'or
                                (case-key-testers key-var used-keys key-list stype)))))
             (consequent-list (or (%cdar clauses) '(nil))))
        (if (eq test t)
            (progn
              (if nil ;e-c-p
                (signal-program-error "~S clause not allowed in ~S statement." key-list stype))
              (when (and (%cdr clauses) (not e-c-p))
                (warn "~s or ~s clause in the middle of a ~s statement.  Subsequent clauses ignored."
                                         't 'otherwise 'case))
              (cons (cons t consequent-list) nil))
            (cons (cons test consequent-list)
                  (case-aux (%cdr clauses) key-var e-c-p placename used-keys))))
      (when e-c-p
        (setq used-keys `(member ,@(mapcar #'car (cdr used-keys))))
        (if (eq e-c-p 'ecase)
          `((t (values (%err-disp #.$XWRONGTYPE ,key-var ',used-keys))))
          `((t (setf ,placename (ensure-value-of-type ,key-var ',used-keys ',placename))
              (go ,e-c-p)))))))

#|
(defun case-key-testers (symbol used-keys atom-or-list statement-type)
  (if (atom atom-or-list)
      (progn
        (if (assoc atom-or-list used-keys)
            (warn "Duplicate keyform ~s in ~s statement." atom-or-list statement-type)
            (nconc used-keys (list (cons atom-or-list t))))
        `((,(if (typep atom-or-list '(and number (not fixnum)))
                'eql
                'eq)
           ,symbol ',atom-or-list)))
      (nconc (case-key-testers symbol used-keys (car atom-or-list) statement-type)
             (when (cdr atom-or-list)
               (case-key-testers symbol used-keys (%cdr atom-or-list) statement-type)))))
|#

;;; We don't want to descend list structure more than once (like this has
;;; been doing for the last 18 years or so.)
(defun case-key-testers (symbol used-keys atom-or-list statement-type &optional recursive)
  (if (or recursive (atom atom-or-list))
    (progn
      (if (assoc atom-or-list used-keys)
        (warn "Duplicate keyform ~s in ~s statement." atom-or-list statement-type)
        (nconc used-keys (list (cons atom-or-list t))))
      `((,(if (typep atom-or-list '(and number (not fixnum)))
              'eql
              'eq)
         ,symbol ',atom-or-list)))
    (nconc (case-key-testers symbol used-keys (car atom-or-list) statement-type t)
           (when (cdr atom-or-list)
             (case-key-testers symbol used-keys (%cdr atom-or-list) statement-type nil)))))



; generate the COND body of a {C,E}TYPECASE form
#|
(defun typecase-aux (key-var clauses &optional e-c-p keyform)
  (let* ((construct (if e-c-p (if (eq e-c-p 'etypecase) e-c-p 'ctypecase) 'typecase))
         (types ())
         (body ()))
    (flet ((bad-clause (c) 
             (error "Invalid clause ~S in ~S form." c construct)))
      (dolist (clause clauses)
        (if (atom clause)
          (bad-clause clause)
          (destructuring-bind (typespec &body consequents) clause
            (if (eq typespec 'otherwise)
              (setq typespec t))
            (if (and (eq typespec t) e-c-p)
              (bad-clause clause))
            (when
              (dolist (already types t)
                (when (subtypep typespec already)
                  (warn "Clause ~S ignored in ~S form - shadowed by ~S ." clause construct (assq already clauses))
                  (return)))
              (push typespec types)
              (unless (eq typespec t)
                (setq typespec `(typep ,key-var ',typespec)))
              (push `(,typespec nil ,@consequents) body)))))
      (when e-c-p
        (setq types `(or ,@(nreverse types)))
        (if (eq construct 'etypecase)
          (push `(t (values (%err-disp #.$XWRONGTYPE ,key-var ',types))) body)
          (push `(t (setf ,keyform (ensure-value-of-type ,key-var ',types ',keyform))
                    (go ,e-c-p)) body))))
    `(cond ,@(nreverse body))))
|#


;; etypecase allows T clause
(defun typecase-aux (key-var clauses &optional e-c-p keyform)
  (let* ((construct (if e-c-p (if (eq e-c-p 'etypecase) e-c-p 'ctypecase) 'typecase))
         (types ())
         (body ())
         otherwise-seen-p)
    (flet ((bad-clause (c) 
             (error "Invalid clause ~S in ~S form." c construct)))
      (dolist (clause clauses)
        (if (atom clause)
            (bad-clause clause))
        (if otherwise-seen-p
            (error "OTHERWISE must be final clause in ~S form." construct))
        (destructuring-bind (typespec &body consequents) clause
          (when (eq construct 'typecase)
            (if (eq typespec 'otherwise)
                (progn (setq typespec t)
                       (setq otherwise-seen-p t))))
          (unless
              (dolist (already types nil)
                (when (subtypep typespec already)
                  (warn "Clause ~S ignored in ~S form - shadowed by ~S ." clause construct (assq already clauses))
                  (return t)))
            (push typespec types)
            (setq typespec `(typep ,key-var ',typespec))
            (push `(,typespec nil ,@consequents) body))))
      (when e-c-p
        (setq types `(or ,@(nreverse types)))
        (if (eq construct 'etypecase)
            (push `(t (values (%err-disp #.$XWRONGTYPE ,key-var ',types))) body)
            (push `(t (setf ,keyform (ensure-value-of-type ,key-var ',types ',keyform))
                      (go ,e-c-p)) body))))
    `(cond ,@(nreverse body))))

(defmacro typecase (keyform &body clauses)
  (let ((key-var (gensym)))
    `(let ((,key-var ,keyform))
       (declare (ignore-if-unused ,key-var))
       ,(typecase-aux key-var clauses))))

(defmacro etypecase (keyform &body clauses)
  (let ((key-var (gensym)))
    `(let ((,key-var ,keyform))
       (declare (ignore-if-unused ,key-var))
       ,(typecase-aux key-var clauses 'etypecase))))

(defmacro ctypecase (keyform &body clauses)
  (let ((key-var (gensym))
        (tag (gensym)))
    `(prog (,key-var)
       ,tag
       (setq ,key-var ,keyform)
       (return ,(typecase-aux key-var clauses tag keyform)))))

(defmacro destructuring-bind (lambda-list expression &body body)
  `(debind ,lambda-list ,expression ,@body))

(defmacro lambda-bind (lambda-list arg-list &body body)
  `(debind ,lambda-list ,arg-list ,@body))

; This is supposedly ANSI CL.
(defmacro lambda (&whole lambda-expression (&rest paramlist) &body body)
  (unless (lambda-expression-p lambda-expression)
    (warn "Invalid lambda expression: ~s" lambda-expression))
  `(function (lambda ,paramlist ,@body)))

#|
; Like destructuring-bind.  In fact, A LOT like destructuring-bind ...
; This is kind of cheap - if any of the initforms reference any of
; the "previously assigned" vars in VAR-LIST, the result is arguably
; unintuitive.
; This is not (quite) the same as ZL:DESETQ.

(defmacro destructuring-setq (var-list lambda-list)
  (let* ((gensyms nil)
         (setqs nil)
         (g nil))
    (dolist (var var-list)
      (push var setqs)
      (push (setq g (gensym)) gensyms)
      (push g setqs))
    `(destructuring-bind ,(nreverse gensyms) ,lambda-list
       (setq ,@(nreverse setqs)))))
|#

(defmacro when (test &body body)
 `(if ,test
   (progn ,@body)))

(defmacro unless (test &body body)
 `(if (not ,test)
   (progn ,@body)))

(defmacro return (&optional (form nil form-p))
  `(return-from nil ,@(if form-p `(,form))))

; since they use tagbody, while & until BOTH return NIL
(defmacro while (test &body body)
  (let ((testlab (gensym))
        (toplab (gensym)))
    `(tagbody
       (go ,testlab)
      ,toplab
      (progn ,@body)
      ,testlab
      (when ,test (go ,toplab)))))

(defmacro until (test &body body)
  (let ((testlab (gensym))
        (toplab (gensym)))
    `(tagbody
       (go ,testlab)
      ,toplab
      (progn ,@body)
      ,testlab
      (if (not ,test)
        (go ,toplab)))))


(defmacro psetq (&whole call &body pairs &environment env)
   (if (evenp (length pairs))
     (progn
       (do ((x pairs (cddr x)))
           ((null x))
         (when (symbolp (car x))
           (multiple-value-bind (exp won)(%symbol-macroexpand (Car x) env)             
             (when (and won (not (symbolp exp))) (return-from psetq `(psetf ,@pairs ))))))
       (%pset 'setq pairs))
     (error "Uneven number of args in the call ~S" call)))

#+old
(defmacro psetq (&whole call &body pairs)
   (if (evenp (length pairs))
     (%pset 'setq pairs)
     (error "Uneven number of args in the call ~S" call)))

; generates body for psetq, psetf.
;This function is also called by psetf in CCL.
; "pairs" is a proper list whose length is not odd.
(defun %pset (setsym pairs)
 (when pairs
   (let (vars vals gensyms let-list var val sets)
      (loop
        (setq var (pop pairs)
              val (pop pairs))
        (if (null pairs) (return))
        (push var vars)
        (push val vals)
        (push (gensym) gensyms))
      (dolist (g gensyms)
        (push g sets)
        (push (pop vars) sets)
        (push (list g (pop vals)) let-list))
      (push val sets)
      (push var sets)
      `(progn
         (let ,let-list
           (,setsym ,@sets))
         nil))))

(unless (macro-function 'loop)
  (defmacro loop (&body body)
    (dolist (form body (let ((toptag (gensym))
                             (endtag (gensym)))
                         `(block nil
                            (tagbody
                              ,toptag
                              (macrolet ((loop-finish () `(go ,',endtag)))
                                ,@body)
                              (go ,toptag)
                              ,endtag))))
      (when (atom form) (return (ansi-loop body))))))

(defun ansi-loop (body)
  (let ((f (macro-function 'loop)))
    (require 'loop)
    (if (eq f (macro-function 'loop))
      (error "LOOP was not redefined.  This shouldn't happen.")))
  `(loop ,@body))

(eval-when (compile load eval)
(defun do-loop (binder setter env var-init-steps end-test result body)
  (let ((toptag (gensym))
        (testtag (gensym)))
    (multiple-value-bind (forms decls) (parse-body body env nil)
      `(block nil
         (,binder ,(do-let-vars var-init-steps)
                  ,@decls
                  (tagbody ; crocks-r-us.
                    (go ,testtag)
                    ,toptag
                    (tagbody
                      ,@forms)
                    (,setter ,@(do-step-vars var-init-steps))
                    ,testtag
                    (unless ,end-test
                      (go ,toptag)))
                  ,@result)))))
)

(defmacro do (&environment env var-init-steps (&optional end-test &rest result) &body body)
  (do-loop 'let 'psetq env var-init-steps end-test result body))

(defmacro do* (&environment env var-init-steps (&optional end-test &rest result) &body body)
  (do-loop 'let* 'setq env var-init-steps end-test result body))


(defun do-let-vars (var-init-steps)
  (if var-init-steps
      (cons (list (do-let-vars-var (car var-init-steps))
                  (do-let-vars-init (car var-init-steps)))
             (do-let-vars (cdr var-init-steps)))))

(defun do-let-vars-var (var-init-step)
  (if (consp var-init-step)
       (car var-init-step)
       var-init-step))

(defun do-let-vars-init (var-init-step)
   (if (consp var-init-step)
        (cadr var-init-step)
        nil))

(defun do-step-vars (var-init-steps)
    (if var-init-steps
        (if (do-step-vars-step? (car var-init-steps))
             (append (list (do-let-vars-var (car var-init-steps))
                           (do-step-vars-step (car var-init-steps)))
                     (do-step-vars (cdr var-init-steps)))
             (do-step-vars (cdr var-init-steps)))))

(defun do-step-vars-step? (var-init-step)
  (if (consp var-init-step)
       (cddr var-init-step)))

(defun do-step-vars-step (var-init-step)
  (if (consp var-init-step)
       (caddr var-init-step)))

#+nope
(defmacro dotimes ((i n &optional result) &body body &environment env)
  (multiple-value-bind (forms decls)
                       (parse-body body env)
  (if (not (symbolp i))
    (report-bad-arg i))
  (let* ((toptag (gensym))
         (testtag (gensym))
         (limit (gensym)))
      `(let ((,limit ,n) (,i 0))
         ,@decls
         (block nil
           (tagbody
             (go ,testtag)
             ,toptag
             ,@forms
             (with-invisible-references (,i) (setq ,i (%i+ ,i 1)))
             ,testtag
             (with-invisible-references (,i) 
               (if (%i< ,i ,limit) (go ,toptag))))
           ,result)))))


(defmacro dotimes ((i n &optional result) &body body &environment env)
  (multiple-value-bind (forms decls)
                       (parse-body body env)
    (if (not (symbolp i))(signal-program-error $Xnotsym i))
    (let* ((toptag (gensym))
           (limit (gensym)))
     `(block nil
        (let ((,limit ,n) (,i 0))
         ,@decls
         (declare (unsettable ,i))
           (if (int>0-p ,limit)
             (tagbody
               ,toptag
               ,@forms
               (locally
                (declare (settable ,i))
                (setq ,i (1+ ,i)))
               (unless (eql ,i ,limit) (go ,toptag))))
           ,result)))))
  
(defun do-syms-result (var resultform)
  (unless (eq var resultform)
    (if (and (consp resultform) (not (quoted-form-p resultform)))
      `(progn (setq ,var nil) ,resultform)
      resultform)))

#|
(defun expand-package-iteration-macro (iteration-function var pkg-spec resultform body env)
  (multiple-value-bind (body decls) (parse-body body env nil)
    (let* ((ftemp (gensym))
           (vtemp (gensym))
           (result (do-syms-result var resultform)))
      `(let* ((,var nil))
         ,@decls
         (block nil
           (flet ((,ftemp (,vtemp) (declare (debugging-function-name nil)) (setq ,var ,vtemp) ,@body))
             (declare (dynamic-extent #',ftemp))
             (,iteration-function ,pkg-spec #',ftemp))
           ,@(when result `(,result)))))))
|#

(defun expand-package-iteration-macro (iteration-function var pkg-spec resultform body env)
  (multiple-value-bind (body decls) (parse-body body env nil)
    (let* ((ftemp (gensym))
           (vtemp (gensym))
           (ptemp (gensym))
           (result (do-syms-result var resultform)))
      `(block nil
        (let* ((,var nil)
               (,ptemp ,pkg-spec))
          ,@decls
           (flet ((,ftemp (,vtemp) (declare (debugging-function-name nil)) (setq ,var ,vtemp) (tagbody ,@body)))
             (declare (dynamic-extent #',ftemp))
             (,iteration-function ,ptemp #',ftemp))
           ,@(when result `(,result)))))))

(defmacro do-symbols ((var &optional pkg result) &body body &environment env)
  (expand-package-iteration-macro 'iterate-over-accessable-symbols var pkg result body env))

(defmacro do-present-symbols ((var &optional pkg result) &body body &environment env)
  (expand-package-iteration-macro 'iterate-over-present-symbols var pkg result body env))

(defmacro do-external-symbols ((var &optional pkg result) &body body &environment env)
  (expand-package-iteration-macro 'iterate-over-external-symbols var pkg result body env))

(defmacro do-all-symbols ((var &optional resultform) 
                          &body body &environment env)
  (multiple-value-bind (body decls) (parse-body body env nil)
    (let* ((ftemp (gensym))
           (vtemp (gensym))
           (result (do-syms-result var resultform)))
      `(let* ((,var nil))
         ,@decls
         (block nil
           (flet ((,ftemp (,vtemp) (declare (debugging-function-name nil)) (setq ,var ,vtemp) ,@body))
             (declare (dynamic-extent #',ftemp))
             (iterate-over-all-symbols #',ftemp))
           ,@(when result `(,result)))))))

(defun apply-to-htab-syms (function pkg-vector)
  (let* ((sym nil)
         (foundp nil))
    (dotimes (i (uvsize pkg-vector))
      (declare (fixnum i))
      (multiple-value-setq (sym foundp) (%htab-symbol pkg-vector i))
      (when foundp (funcall function sym)))))

(defun iterate-over-external-symbols (pkg-spec function)
  (apply-to-htab-syms function (car (pkg.etab (pkg-arg (or pkg-spec *package*))))))

(defun iterate-over-present-symbols (pkg-spec function)
  (let ((pkg (pkg-arg (or pkg-spec *package*))))
    (apply-to-htab-syms function (car (pkg.etab pkg)))
    (apply-to-htab-syms function (car (pkg.itab pkg)))))

(defun iterate-over-accessable-symbols (pkg-spec function)
  (let* ((pkg (pkg-arg (or pkg-spec *package*)))
         (used (pkg.used pkg))
         (shadowed (pkg.shadowed pkg)))
    (iterate-over-present-symbols pkg function)
    (when used
      (if shadowed
        (flet ((ignore-shadowed-conflicts (var)
                 (unless (%name-present-in-package-p (symbol-name var) pkg)
                   (funcall function var))))
          (declare (dynamic-extent #'ignore-shadowed-conflicts))
          (dolist (u used) (iterate-over-external-symbols u #'ignore-shadowed-conflicts)))
        (dolist (u used) (iterate-over-external-symbols u function))))))

(defun iterate-over-all-symbols (function)
  (dolist (pkg %all-packages%)
    (iterate-over-present-symbols pkg function)))          

(defmacro multiple-value-list (form)
  `(multiple-value-call #'list ,form))

(defmacro multiple-value-bind (varlist values-form &body body &environment env)
  (multiple-value-bind (body decls)
                       (parse-body body env)
    (let ((ignore (make-symbol "IGNORE")))
      `(multiple-value-call #'(lambda (&optional ,@varlist &rest ,ignore)
                                (declare (ignore ,ignore))
                                ,@decls
                                ,@body)
                            ,values-form))))

#|
(defmacro multiple-value-setq (vars val)
  (if vars
    (let ((setqs nil)
          (gensyms nil)
          (g nil))
      (dolist (var vars)
        (push (setq g (gensym)) setqs)
        (push var setqs)
        (push g gensyms))
      `(multiple-value-bind (,@(nreverse gensyms)) ,val
         (setq ,@setqs)))
    `(prog1 ,val)))
|#

(defmacro multiple-value-setq (vars val)
  (if vars
    `(values (setf (values ,@(mapcar #'(lambda (s) (require-type s 'symbol)) vars))  ,val))
    `(prog1 ,val)))

(defmacro nth-value (n form)
  `(car (nthcdr ,n (multiple-value-list ,form))))

(defmacro %i> (x y)
  `(> (the fixnum ,x) (the fixnum ,y)))

(defmacro %i< (x y)
  `(< (the fixnum ,x) (the fixnum ,y)))

(defmacro %i<= (x y)
 `(not (%i> ,x ,y)))

(defmacro %i>= (x y)
 `(not (%i< ,x ,y)))

(defmacro bitset (bit number)
  `(logior (ash 1 ,bit) ,number))

(defmacro bitclr (bit number)
  `(logand (lognot (ash 1 ,bit)) ,number))

(defmacro bitopf ((op bit place) &environment env)
  (multiple-value-bind (vars vals stores store-form access-form)
                       (get-setf-method place env)
    (let* ((constant-bit-p (constantp bit))
           (bitvar (if constant-bit-p bit (gensym))))
      `(let ,(unless constant-bit-p `((,bitvar ,bit)))          ; compiler isn't smart enough
         (let* ,(mapcar #'list `(,@vars ,@stores) `(,@vals (,op ,bitvar ,access-form)))
           ,store-form)))))

(defmacro bitsetf (bit place)
  `(bitopf (bitset ,bit ,place)))

(defmacro bitclrf (bit place)
  `(bitopf (bitclr ,bit ,place)))

(defmacro %svref (v i)
  (let* ((vtemp (make-symbol "VECTOR"))
           (itemp (make-symbol "INDEX")))
      `(let* ((,vtemp ,v)
              (,itemp ,i))
         (locally (declare (optimize (speed 3) (safety 0)))
           (svref ,vtemp ,itemp)))))

(defmacro %svset (v i new)
  (let* ((vtemp (make-symbol "VECTOR"))
           (itemp (make-symbol "INDEX")))
      `(let* ((,vtemp ,v)
              (,itemp ,i))
         (locally (declare (optimize (speed 3) (safety 0)))
           (setf (svref ,vtemp ,itemp) ,new)))))


(defmacro %schar (v i)
  (let* ((vtemp (make-symbol "STRING"))
         (itemp (make-symbol "INDEX")))
    `(let* ((,vtemp ,v)
            (,itemp ,i))
       (locally (declare (optimize (speed 3) (safety 0)))
         (schar ,vtemp ,itemp)))))

(defmacro %set-schar (v i new)
  (let* ((vtemp (make-symbol "STRING"))
           (itemp (make-symbol "INDEX")))
      `(let* ((,vtemp ,v)
              (,itemp ,i))
         (locally (declare (optimize (speed 3) (safety 0)))
           (setf (schar ,vtemp ,itemp) ,new)))))

;Eval definitions for things open-coded by the compiler.
;Don't use DEFUN since it should be illegal to DEFUN compiler special forms...
;Of course, these aren't special forms.
(macrolet ((%eval-redef (name vars &rest body)
             (when (null body) (setq body `((,name ,@vars))))
             `(setf (symbol-function ',name)
                    (qlfun ,name ,vars ,@body))))
  (%eval-redef %ilsl (n x))
  (%eval-redef %ilsr (n x))
  (%eval-redef neq (x y))
  (%eval-redef not (x))
  (%eval-redef null (x))
  (%eval-redef rplaca (x y))
  (%eval-redef rplacd (x y))
  (%eval-redef set-car (x y))
  (%eval-redef set-cdr (x y))
  (%eval-redef int>0-p (x))
  (%eval-redef %get-byte (ptr &optional (offset 0)) (%get-byte ptr offset))
  (%eval-redef %get-word (ptr &optional (offset 0)) (%get-word ptr offset))
  (%eval-redef %get-signed-byte (ptr &optional (offset 0)) (%get-signed-byte ptr offset))
  (%eval-redef %get-signed-word (ptr &optional (offset 0)) (%get-signed-word ptr offset))
  (%eval-redef %get-long (ptr &optional (offset 0)) (%get-long ptr offset))
  (%eval-redef %get-fixnum (ptr &optional (offset 0)) (%get-fixnum ptr offset))
  (%eval-redef %get-point (ptr &optional (offset 0)) (%get-point ptr offset))
  (%eval-redef %get-signed-long (ptr &optional (offset 0)) (%get-signed-long ptr offset))
  (%eval-redef %get-unsigned-long (ptr &optional (offset 0)) (%get-unsigned-long ptr offset))
  (%eval-redef %get-ptr (ptr &optional (offset 0)) (%get-ptr ptr offset))
  (%eval-redef %put-byte (ptr val &optional (offset 0)) (%put-byte ptr val offset))
  (%eval-redef %put-word (ptr val &optional (offset 0)) (%put-word ptr val offset))
  (%eval-redef %put-long (ptr val &optional (offset 0)) (%put-long ptr val offset))
  (%eval-redef %put-point (ptr val &optional (offset 0)) (%put-point ptr val offset))
  (%eval-redef %put-ptr (ptr val &optional (offset 0)) (%put-ptr ptr val offset))
  (%eval-redef %hget-byte (ptr &optional (offset 0)) (%hget-byte ptr offset))
  (%eval-redef %hget-unsigned-byte (ptr &optional (offset 0)) (%hget-unsigned-byte ptr offset))
  (%eval-redef %hget-word (ptr &optional (offset 0)) (%hget-word ptr offset))
  (%eval-redef %hget-signed-byte (ptr &optional (offset 0)) (%hget-signed-byte ptr offset))
  (%eval-redef %hget-signed-word (ptr &optional (offset 0)) (%hget-signed-word ptr offset))
  (%eval-redef %hget-unsigned-word (ptr &optional (offset 0)) (%hget-unsigned-word ptr offset))
  (%eval-redef %hget-long (ptr &optional (offset 0)) (%hget-long ptr offset))
  (%eval-redef %hget-fixnum (ptr &optional (offset 0)) (%hget-fixnum ptr offset))
  (%eval-redef %hget-point (ptr &optional (offset 0)) (%hget-point ptr offset))
  (%eval-redef %hget-signed-long (ptr &optional (offset 0)) (%hget-signed-long ptr offset))
  (%eval-redef %hget-unsigned-long (ptr &optional (offset 0)) (%hget-unsigned-long ptr offset))
  (%eval-redef %hget-full-long (ptr &optional (offset 0)) (%hget-full-long ptr offset))
  (%eval-redef %hget-point(ptr &optional (offset 0)) (%hget-point ptr offset))
  (%eval-redef %hget-ptr (ptr &optional (offset 0)) (%hget-ptr ptr offset))
  (%eval-redef %hput-byte (ptr val &optional (offset 0)) (%hput-byte ptr val offset))
  (%eval-redef %hput-word (ptr val &optional (offset 0)) (%hput-word ptr val offset))
  (%eval-redef %hput-long (ptr val &optional (offset 0)) (%hput-long ptr val offset))
  (%eval-redef %hput-point (ptr val &optional (offset 0)) (%hput-point ptr val offset))
  (%eval-redef %hput-ptr (ptr val &optional (offset 0)) (%hput-ptr ptr val offset))
  (%eval-redef %get-full-long (ptr &optional (offset 0)) (%get-full-long ptr offset))
  (%eval-redef %put-full-long (ptr val &optional (offset 0)) (%put-full-long ptr val offset))
  (%eval-redef %hput-full-long (ptr val &optional (offset 0)) (%hput-full-long ptr val offset))
  (%eval-redef %int-to-ptr (int))
  (%eval-redef %ptr-to-int (ptr))
  (%eval-redef %ptr-eql (ptr1 ptr2))
  (%eval-redef %setf-macptr (ptr1 ptr2))
  (%eval-redef %null-ptr-p (ptr))

  #-ppc-target
  (%eval-redef sequence-type (s))
  (%eval-redef %newgotag ())
  (%eval-redef %iasr (x y))
  #-ppc-target
  (%eval-redef %temp-cons (x y))
  #-ppc-target
  (%eval-redef %ttagp (x tag))
  #-ppc-target
  (%eval-redef %ttag (x))
  
  (%eval-redef %set-byte (p o &optional (new (prog1 o (setq o 0))))
               (%set-byte p o new))
  (%eval-redef %set-word (p o &optional (new (prog1 o (setq o 0))))
               (%set-word p o new))
  (%eval-redef %set-long (p o &optional (new (prog1 o (setq o 0))))
               (%set-long p o new))
  (%eval-redef %set-ptr (p o &optional (new (prog1 o (setq o 0))))
               (%set-ptr p o new))
  (%eval-redef %hset-byte (p o &optional (new (prog1 o (setq o 0))))
               (%hset-byte p o new))
  (%eval-redef %hset-word (p o &optional (new (prog1 o (setq o 0))))
               (%hset-word p o new))
  (%eval-redef %hset-long (p o &optional (new (prog1 o (setq o 0))))
               (%hset-long p o new))
  (%eval-redef %hset-ptr (p o &optional (new (prog1 o (setq o 0))))
               (%hset-ptr p o new))
  
  (%eval-redef %word-to-int (word))
  (%eval-redef %inc-ptr (ptr &optional (by 1)) (%inc-ptr ptr by))
  
  (%eval-redef char-code (x))
  (%eval-redef code-char (x))
  (%eval-redef 1- (n))
  (%eval-redef 1+ (n))
  #-ppc-target
  (%eval-redef logbitp (x y))
  #-ppc-target
  (%eval-redef length (x))
  #-ppc-target
  (%eval-redef list-length (x))
  (%eval-redef uvref (x y))
  (%eval-redef uvset (x y z))
  (%eval-redef uvsize (x))
  #-ppc-target
  (%eval-redef schar (x y))
  #-ppc-target
  (%eval-redef %scharcode (x y))
  #-ppc-target
  (%eval-redef %set-scharcode (x y z))
  #-ppc-target
  (%eval-redef set-schar (x y z))
  (%eval-redef svref (x y))
  (%eval-redef svset (x y z))
  
  #-ppc-target
  (%eval-redef symbolp (x)) 
  (%eval-redef integer-point-h (x))
  (%eval-redef integer-point-v (x))
  
  (%eval-redef car (x))
  (%eval-redef cdr (x))
  (%eval-redef cons (x y))
  (%eval-redef endp (x))
  #-ppc-target
  (progn
  (%eval-redef %typed-uvref (s a i))
  (%eval-redef %typed-uvset (s a i v)))
  #+ppc-target
  (progn
    (%eval-redef %typed-miscref (s a i))
    (%eval-redef %typed-miscset (s a i v))
    (%eval-redef ppc-typecode (x))
    (%eval-redef ppc-lisptag (x))
    (%eval-redef ppc-fulltag (x))
    (%eval-redef %unbound-marker ())
    (%eval-redef %illegal-marker ())
    (%eval-redef %alloc-misc (x y))
    (%eval-redef %typed-misc-ref (x y z))
    (%eval-redef %typed-misc-set (w x y z))
    (%eval-redef %setf-double-float (x y))
    (%eval-redef %lisp-word-ref (x y))
    (%eval-redef %temp-cons (x y))
    (%eval-redef require-fixnum (x))
    (%eval-redef require-symbol (x))
    (%eval-redef require-list (x))
    (%eval-redef require-real (x))
    (%eval-redef require-simple-string (x))
    (%eval-redef require-simple-vector (x))
    (%eval-redef require-character (x))
    (%eval-redef require-number (x))
    (%eval-redef require-integer (x))
    (%eval-redef %slot-ref (slots index))
    )
  
  (%eval-redef listp (x))
               
)

; In the spirit of eval-redef ...
(defmacro with-stack-double-floats ((&rest vars) &body body &environment env)
  (multiple-value-bind (body decls) (parse-body body env)
    `(let* (,@(mapcar #'(lambda (v) `(,v (%alloc-misc PPC::double-float.element-count
                                                      PPC::subtag-double-float)))
                      vars))
       ,@decls
       (declare (double-float ,@vars))  ;; added
       (declare (dynamic-extent ,@vars))
       ,@body)))

(defmacro with-stack-single-floats ((&rest vars) &body body &environment env)
  (multiple-value-bind (body decls) (parse-body body env)
    `(let* (,@(mapcar #'(lambda (v) `(,v  (%alloc-misc PPC::single-float.element-count
                                                       PPC::subtag-single-float)))
                      vars))
       ,@decls
       (declare (single-float ,@vars)) 
       (declare (dynamic-extent ,@vars))
       ,@body)))


(defmacro %char-code (c) `(char-code (the character ,c)))
(defmacro %code-char (i) `(code-char (the (unsigned-byte 16) ,i)))

(defmacro %izerop (x) `(eq ,x 0))
(defmacro %iminusp (x) `(< (the fixnum ,x) 0))
(defmacro %i+ (&rest (&optional (n0 0) &rest others))
  (if others
    `(the fixnum (+ (the fixnum ,n0) (%i+ ,@others)))
    `(the fixnum ,n0)))
(defmacro %i- (x y &rest others) 
  (if (not others)
    `(the fixnum (- (the fixnum ,x) (the fixnum ,y)))
    `(the fixnum (- (the fixnum ,x) (the fixnum (%i+ ,y ,@others))))))


(defmacro %i* (x y) `(the fixnum (* (the fixnum ,x) (the fixnum ,y))))

(defmacro %ilogbitp (b i)
  (if (ppc-target-p)
    `(logbitp (the (integer 0 29) ,b) (the fixnum ,i))
    `(logbitp (the (integer 0 28) ,b) (the fixnum ,i))))

;;; Seq-Dispatch does an efficient type-dispatch on the given Sequence.

(defmacro seq-dispatch (sequence list-form array-form)
  `(if (sequence-type ,sequence)
       ,list-form
       ,array-form))



;; pointer hacking stuff (moved from defrecord)
;
;

; these defvars put here (didn't have a better place?)
(defvar *record-types* nil)
(defvar %record-descriptors% (make-hash-table :test #'eq))


; expands into compiler stuff
(lds (progn
       (defsynonym %get-unsigned-byte %get-byte)
       (defsynonym %get-unsigned-word %get-word)
       (defsynonym %get-signed-long %get-long))
     :module compiler)

(setf (symbol-function '%get-unsigned-byte) (symbol-function '%get-byte))
(setf (symbol-function '%get-unsigned-word) (symbol-function '%get-word))
(setf (symbol-function '%get-signed-long) (symbol-function '%get-long))

(defsetf %get-byte %set-byte)
(defsetf %get-unsigned-byte %set-byte)
(defsetf %get-signed-byte %set-byte)
(defsetf %get-word %set-word)
(defsetf %get-signed-word %set-word)
(defsetf %get-unsigned-word %set-word)
(defsetf %get-long %set-long)
(defsetf %get-signed-long %set-long)
(defsetf %get-unsigned-long %set-long)
(defsetf %get-full-long %set-long)
(defsetf %get-point %set-long)
(defsetf %get-string %set-string)
(defsetf %get-ptr %set-ptr)
(defsetf %get-double-float %set-double-float)
(defsetf %get-single-float %set-single-float)

(defsetf %hget-byte %hset-byte)
(defsetf %hget-unsigned-byte %hset-byte)
(defsetf %hget-signed-byte %hset-byte)
(defsetf %hget-word %hset-word)
(defsetf %hget-signed-word %hset-word)
(defsetf %hget-unsigned-word %hset-word)
(defsetf %hget-long %hset-long)
(defsetf %hget-signed-long %hset-long)
(defsetf %hget-unsigned-long %hset-long)
(defsetf %hget-full-long %hset-long)
(defsetf %hget-point %hset-long)
(defsetf %hget-string %hset-string)
(defsetf %hget-ptr %hset-ptr)
(defsetf %hget-double-float %hset-double-float)
(defsetf %hget-single-float %hset-single-float)


(defun %clear-pointer (pointer &aux pointer-size)
  (when (and (setq pointer-size (pointer-size pointer))
             (plusp pointer-size))
    (%clear-block pointer pointer-size)))

#-ppc-target
(defun %clear-block (pointer length)
  (old-lap-inline ()
    (getint arg_z)
    (move.l arg_y atemp0)
    (jsr_subprim $sp-macptrptr)
    (dbfloop.l arg_z (move.b ($ 0) atemp0@+)))
  pointer)

#+ppc-target
(defppclapfunction %clear-block ((pointer arg_y) (length arg_z))
  (unbox-fixnum imm0 length)
  (cmpwi cr0 imm0 0)  ; or unbox-fixnum. above  (this was missing its last operand.)
  (macptr-ptr imm1 pointer)
  (add imm1 imm1 imm0) ; point past last byte
  (beq @done)
  @loop  
  (cmpwi cr0 imm0 1)                    ; set cr0_eq if last time through
  (stbu rzero -1 imm1)
  (subi imm0 imm0 1)
  (bne @loop)
  @done
  (mr arg_z pointer)
  (blr))

(defun %new-ptr (size clear-p)
  (if clear-p
    (#_NewPtrClear size)
    (#_NewPtr size)))


#| ;; not used thank heaven - very evil re OSX - seems nuts in any case
(defun wptr-to-procid (a-wptr)
  "" "returns mod-16 of the procid, so an actual procid of 16 yields 0."
  (%ilogand2 #xf (%get-byte a-wptr 126)))
|#


; end of moved stuff


(defmacro %ilognot (int) `(%i- -1 ,int))

(defmacro %ilogior2 (x y) 
  `(logior (the fixnum ,x) (the fixnum ,y)))

(defmacro %ilogior (body &body args)
   (while args
     (setq body (list '%ilogior2 body (pop args))))
   body)

(defmacro %ilogand2 (x y)
  `(logand (the fixnum ,x) (the fixnum ,y)))

(defmacro %ilogand (body &body args)
   (while args
     (setq body (list '%ilogand2 body (pop args))))
   body)

(defmacro %ilogxor2 (x y)
  `(logxor (the fixnum ,x) (the fixnum ,y)))

(defmacro %ilogxor (body &body args)
   (while args
     (setq body (list '%ilogxor2 body (pop args))))
   body)


(defmacro %getport ()
  '(rlet ((it :pointer))
     (require-trap #_getport it)
     (%get-ptr it)))


(defmacro %setport (port)
  `(require-trap #_SetPort ,port))

(defmacro with-port (port &rest body)
  (let ((f (gensym)))
    `(let ((,f #'(lambda () ,@body)))
       (declare (dynamic-extent ,f))
       (call-with-port ,port ,f))))

(defmacro with-macptrs (varlist &rest body &aux decls inits)
  (dolist (var varlist)
    (if (consp var)
      (progn
        (push (car var) decls)
        (push (list (%car var)
                    (if (%cdr var)
                      `(%setf-macptr (%null-ptr) ,@(%cdr var))
                      '(%null-ptr))) inits))
      (progn
        (push var decls)
        (push (list var '(%null-ptr)) inits))))
  `(let* ,(nreverse inits)
     (declare (dynamic-extent ,@decls))
     (declare (type macptr ,@decls))
     ,@body))


(defmacro with-loading-file (filename &rest body)
   `(let ((*loading-files* (cons ,filename (locally (declare (special *loading-files*))
                                                    *loading-files*))))
      (declare (special *loading-files*))
      ,@body))

(defmacro with-open-file ((var . args) &body body &aux (stream (gensym))(done (gensym)))
  `(let (,stream ,done)
     (unwind-protect
       (multiple-value-prog1
         (let ((,var (setq ,stream (open ,@args))))
           ,@body)
         (setq ,done t))
       (when ,stream (close ,stream :abort (null ,done))))))

(defmacro with-compilation-unit ((&key override) &body body)
  `(let* ((*outstanding-deferred-warnings* (%defer-warnings ,override)))
     (multiple-value-prog1 (progn ,@body) (report-deferred-warnings))))

; Yow! Another Done Fun.
(defmacro with-standard-io-syntax (&body body &environment env)
  (multiple-value-bind (decls body) (parse-body body env)
    `(let ((*package* (find-package "CL-USER"))
           (*print-array* t)
           (*print-base* 10.)
           (*print-case* :upcase)
           (*print-circle* nil)
           (*print-escape* t)
           (*print-gensym* t)
           (*print-length* nil)
           (*print-level* nil)
           (*print-lines* nil) ; This doesn't exist as of 5/15/90 - does now
           (*print-miser-width* nil)
           (*print-pprint-dispatch* nil)
           (*print-pretty* nil)
           (*print-radix* nil)
           (*print-readably* t)
           (*print-right-margin* nil)
           (*read-base* 10.)
           (*read-default-float-format* 'double-float)
           (*read-eval* t) ; Also MIA as of 5/15/90
           (*read-suppress* nil)
           (*readtable* %initial-readtable%))
       ,@decls
       ,@body)))
           
(defmacro print-unreadable-object (&environment env (object stream &key type identity) &body forms)
  (multiple-value-bind (body decls) (parse-body forms env)
    (if body
      (let ((thunk (gensym)))
        `(let ((,thunk #'(lambda () ,@decls ,@body)))
           (declare (dynamic-extent ,thunk))
          (%print-unreadable-object ,object ,stream ,type ,identity ,thunk)))
      `(%print-unreadable-object ,object ,stream ,type ,identity nil))))


;; Pointers and Handles

;;Add function to lisp system pointer functions, and run it if it's not already
;; there.
(defmacro def-ccl-pointers (name arglist &body body &aux (old (gensym)))
  `(flet ((,name ,arglist ,@body))
     (let ((,old (member ',name *lisp-system-pointer-functions* :key #'function-name)))
       (if ,old
         (rplaca ,old #',name)
         (progn
           (push #',name *lisp-system-pointer-functions*)
           (,name))))))

(defmacro def-load-pointers (name arglist &body body &aux (old (gensym)))
  `(flet ((,name ,arglist ,@body))
     (let ((,old (member ',name *lisp-user-pointer-functions* :key #'function-name)))
       (if ,old
         (rplaca ,old #',name)
         (progn
           (push #',name *lisp-user-pointer-functions*)
           (,name))))))

;Queue up some code to run after ccl all loaded up, or, if ccl is already
;loaded up, just run it right now.
(defmacro queue-fixup (&rest body &aux (fn (gensym)))
  `(let ((,fn #'(lambda () ,@body)))
     (if (eq %lisp-system-fixups% T)
       (funcall ,fn)
       (push (cons ,fn *loading-file-source-file*) %lisp-system-fixups%))))

(defmacro %incf-ptr (p &optional (by 1))
  (if (symbolp p)  ;once-only
    `(%setf-macptr (the macptr ,p) (%inc-ptr ,p ,by))
    (let ((var (gensym)))
      `(let ((,var ,p)) (%setf-macptr (the macptr ,var) (%inc-ptr ,var ,by))))))

(defmacro with-new-handle (spec &body body &aux name size (hdl (gensym)))
  (if (symbolp spec) (setq name spec size 0)
      (setq name (car spec) size (or (cadr spec) 0)))
  `(with-macptrs (,hdl)
     (unwind-protect
       (let (,name ,hdl)
         (%setf-macptr ,hdl (require-trap #_NewHandle ,size))
         ,@body)
       (unless (%null-ptr-p ,hdl) (require-trap #_Disposehandle ,hdl)))))

(defmacro with-pointer (spec &rest body &environment env)
  (let* ((unlock-sym (gensym))
         (val-sym (gensym))
         (name (car spec))
         (val (cadr spec))
         (offset (if (eql 3 (list-length spec)) (caddr spec) 0)))
    (multiple-value-bind (forms decls) (parse-body body env nil)
      `(let ((,val-sym ,val)
             ,unlock-sym)
         (declare (dynamic-extent ,val-sym))
         (unwind-protect
           (with-macptrs (,name)
             ,@decls
             (setq ,unlock-sym (%thing-pointer ,val-sym ,offset ,name))
             ,@forms)
           (when ,unlock-sym
             (require-trap #_HUnlock ,unlock-sym)))))))

;; no more handles please
(defmacro new-with-pointer (spec &rest body &environment env)
  (let* (;(unlock-sym (gensym))
         (Val-sym (gensym))
         (name (car spec))
         (val (cadr spec))
         (offset (if (eql 3 (list-length spec)) (caddr spec) 0)))
    (multiple-value-bind (forms decls) (parse-body body env nil)
      `(let ((,val-sym ,val)
             ;,unlock-sym
             )
         (Declare (dynamic-extent ,val-sym))
         (progn ;unwind-protect
           (with-macptrs ((,name ,val-sym))
             ,@decls
             (unless (eql ,offset 0)(%incf-ptr ,name ,offset))             
             ,@forms))))))

(defmacro with-dereferenced-handle (spec &body body &environment env)
  (let ((unlock-sym (gensym))
        (val-sym (gensym))
        (name (car spec))
        (val (cadr spec))
        (offset (if (eql 3 (list-length spec)) (third spec) 0)))
    (multiple-value-bind (forms decls) (parse-body body env nil)
      `(let ((,val-sym ,val)
             ,unlock-sym)
         (unwind-protect
           (with-macptrs (,name)
             ,@decls
             (setq ,unlock-sym (%dereference-handle ,val-sym ,offset ,name))
             ,@forms)
           (when ,unlock-sym
             (require-trap #_HUnlock ,unlock-sym)))))))

(defmacro with-pstr ((sym str &optional start end script) &rest body &environment env)
    (multiple-value-bind (body decls) (parse-body body env nil)
      (if (and (base-string-p str) (null start) (null end)) ; byte-length of fat string not constant!
        (let ((strlen (%i+ (min 255 (length str)) 1)))
          `(%stack-block ((,sym ,strlen))
             ,@decls
             (%pstr-pointer ,str ,sym)
             ,@body))
        (let ((strname (gensym))
              (start-name (gensym))
              (end-name (gensym)))
          `(let* ((,strname ,str)
                  ,@(if (or start end)
                      `((,start-name ,(or start 0))
                        (,end-name ,(or end `(length ,strname))))))
             (%vstack-block (,sym (the fixnum (1+ (the fixnum ,(if (or start end)
                                                                 `(byte-length ,strname ,script
                                                                               ,start-name ,end-name)
                                                                 `(byte-length ,strname ,script))))))
               ,@decls
               ,(if (or start end )
                  `(%pstr-segment-pointer ,strname ,sym ,start-name ,end-name ,script)
                  `(%pstr-pointer ,strname ,sym ,script))
               ,@body))))))

(defmacro with-cstr ((sym str &optional start end script) &rest body &environment env)
  (multiple-value-bind (body decls) (parse-body body env nil)
    (if (and (base-string-p str) (null start) (null end))
      (let ((strlen (%i+ (length str) 1)))
        `(%stack-block ((,sym ,strlen))
           ,@decls
           (%cstr-pointer ,str ,sym)
           ,@body))
      (let ((strname (gensym))
            (start-name (gensym))
            (end-name (gensym)))
        `(let ((,strname ,str)
               ,@(if (or start end)
                   `((,start-name ,(or start 0))
                     (,end-name ,(or end `(length ,strname))))))
           (%vstack-block (,sym (the fixnum (1+ (the fixnum ,(if (or start end)
                                                               `(byte-length ,strname ,script
                                                                             ,start-name ,end-name)
                                                               `(byte-length ,strname ,script))))))
             ,@decls
             ,(if (or start end)
                `(%cstr-segment-pointer ,strname ,sym ,start-name ,end-name)
                `(%cstr-pointer ,strname ,sym ,script))
             ,@body))))))

(defmacro with-returned-pstr ((sym str &optional start end) &body body)
   `(%stack-block ((,sym 256))
      ,(if (or start end)
         `(%pstr-segment-pointer ,str ,sym ,start ,end)
         `(%pstr-pointer ,str ,sym))
      ,@body))

(export '(new-with-pointers))
(defmacro new-with-pointers (speclist &body body)
   (with-specs-aux 'new-with-pointer speclist body))

(defmacro with-pointers (speclist &body body)
   (with-specs-aux 'with-pointer speclist body))

(defmacro with-pstrs (speclist &body body)
   (with-specs-aux 'with-pstr speclist body))

(defmacro with-cstrs (speclist &body body)
   (with-specs-aux 'with-cstr speclist body))

(defmacro with-returned-pstrs (speclist &body body)
   (with-specs-aux 'with-returned-pstr speclist body))

(defmacro with-dereferenced-handles (speclist &body body)
  (with-specs-aux 'with-dereferenced-handle speclist body))

(defun with-specs-aux (name spec-list body)
  (setq body (cons 'progn body))
  (dolist (spec (reverse spec-list))
     (setq body (list name spec body)))
  body)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(with-cfstrs)))

;; from John Montbriand
;; maybe this should just be the same as with-cfstrs-hairy - no mo macroman
#|
(defmacro with-cfstrs ((&rest decl-list) &body body)
   (let ((string-decls nil)
         (cfvar-decls nil)
         (recover-decls nil)
         (tvar nil))
     (dolist (i decl-list)
       (setf tvar (gensym))
       (push `( ,tvar ,@(cdr i))
             string-decls)
       (push `(,(first i) (require-trap #_CFStringCreateWithCString (%null-ptr)
                           ,tvar (require-trap-constant #$kCFStringEncodingMacRoman)))
             cfvar-decls)
       (push `(require-trap #_CFRelease ,(first i))
             recover-decls))
     (setq string-decls (nreverse string-decls))                                  
     `(with-cstrs (,@string-decls)
       (let (,@cfvar-decls)
         (unwind-protect
           (progn ,@body)
           ,@recover-decls)))))
|#


(defmacro with-cfstrs (args &body body)
  `(with-cfstrs-hairy ,args ,@body))


;; accepts encoded strings, also accepts nil - now takes start and end args
(defmacro with-cfstrs-hairy ((&rest decl-list) &body body)
  (let ((string-decls nil)
        (cfvar-decls nil)
        (ptr-decls nil)
        (start-decls nil)
        (end-decls nil)
        (recover-decls nil)
        (tvar nil)
        (ptrvar nil)
        (startvar nil)
        (endvar nil))
    (dolist (i decl-list)
      (setf tvar (gensym))
      (setq ptrvar (gensym))
      (setq startvar (gensym))
      (setq endvar (gensym))      
      (push `( ,tvar ,(second i))
            string-decls) 
      (push `(,startvar ,(third i))
            start-decls)
      (push `(,endvar ,(fourth i))
            end-decls)      
      (push ptrvar ptr-decls) 
      (push `(,(first i) (if ,tvar (create-cfstr2 ,tvar ,ptrvar ,startvar ,endvar)))
            cfvar-decls)
      (push `(if ,tvar (require-trap #_CFRelease ,(first i)))
            recover-decls))
    (setq string-decls (nreverse string-decls))     
    (setq ptr-decls (nreverse ptr-decls))
    (setq cfvar-decls (nreverse cfvar-decls))
    (setq start-decls (nreverse start-decls))
    (setq end-decls (nreverse end-decls))
    `(with-macptrs (,@ptr-decls)
       (let* (,@string-decls 
              ,@start-decls
              ,@end-decls
              ,@cfvar-decls)
         (unwind-protect
           (progn ,@body)
           ,@recover-decls)))))
  

(defmacro copy-string-to-ptr (string start len ptr)
  (let ((bs (gensym))
        (ls (gensym))
        (str-sym (gensym)))    
    `(let ((,str-sym ,string)
           (,bs ,start)
           (,ls ,len))
       (if (extended-string-p ,str-sym)
         (%copy-ivector-to-ptr ,str-sym (%i+ ,bs ,bs) ,ptr 0 (%i+ ,ls ,ls))
         (dotimes (i ,ls)
           (setf (%get-unsigned-word ,ptr (%i+ i i)) (%scharcode ,str-sym (%i+ ,bs i))))))))




; Don't use these in new code. Use :boolean records instead.
(defmacro pascal-true (form)
 `(%ilogbitp 8 ,form))

(defmacro pascal-false (form)
 `(not (pascal-true ,form)))

(defmacro type-predicate (type)
  `(get-type-predicate ,type))

(defsetf type-predicate set-type-predicate)

(defmacro defmethod (name &rest args &environment env)
  (multiple-value-bind (function-form specializers-form qualifiers lambda-list documentation specializers)
                       (parse-defmethod name args env)
    
    `(progn
       (eval-when (:compile-toplevel)
         (note-function-info ',name nil ,env))
       (compiler-let ((*nx-method-warning-name* 
                       (list ',name
                             ,@(mapcar #'(lambda (x) `',x) qualifiers)
                             ',specializers)))
	 (ensure-method ',name ,specializers-form
                        :function ,function-form
                        :qualifiers ',qualifiers
                        :lambda-list ',lambda-list
                        ,@(if documentation `(:documentation ,documentation)))))))

(defun seperate-defmethod-decls (decls)
  (let (outer inner)
    (dolist (decl decls)
      (if (neq (car decl) 'declare)
        (push decl outer)
        (let (outer-list inner-list)
          (dolist (d (cdr decl))
            (if (and (listp d) (eq (car d) 'dynamic-extent))
              (let (in out)
                (dolist (fspec (cdr d))
                  (if (and (listp fspec)
                           (eq (car fspec) 'function)
                           (listp (cdr fspec))
                           (null (cddr fspec))
                           (memq (cadr fspec) '(call-next-method next-method-p)))
                    (push fspec in)
                    (push fspec out)))
                (when out
                  (push `(dynamic-extent ,@(nreverse out)) outer-list))
                (when in
                  (push `(dynamic-extent ,@(nreverse in)) inner-list)))
              (push d outer-list)))
          (when outer-list
            (push `(declare ,@(nreverse outer-list)) outer))
          (when inner-list
            (push `(declare ,@(nreverse inner-list)) inner)))))
    (values (nreverse outer) (nreverse inner))))

(defun parse-defmethod (name args env)
  (unless (function-spec-p name) (signal-program-error "Illegal arg ~S" name))
  (let (qualifiers lambda-list parameters specializers specializers-form refs types temp)
    (until (listp (car args))
      (push (pop args) qualifiers))
    (setq lambda-list (pop args))
    (while (and lambda-list (not (memq (car lambda-list) lambda-list-keywords)))
      (let ((p (pop lambda-list)))
        (cond ((consp p)
               (unless (and (consp (%cdr p)) (null (%cddr p)))
                 (signal-program-error "Illegal arg ~S" p))
               (push (%car p) parameters)
               (push (%car p) refs)
               (setq p (%cadr p))
               (cond ((and (consp p) (eq (%car p) 'eql)
                           (consp (%cdr p)) (null (%cddr p)))
                      (push `(list 'eql ,(%cadr p)) specializers-form)
                      (push p specializers))
                     ((or (setq temp (non-nil-symbol-p p))
                          (specializer-p p))
                      (push `',p specializers-form)
                      (push p specializers)
                      (unless (or (eq p t) (not temp))
                        ;Should be `(guaranteed-type ...).
                        (push `(type ,p ,(%car parameters)) types)))
                     (t (signal-program-error "Illegal arg ~S" p))))
              (t               
               (push p refs) ;;; PATCH
               (push p parameters)
               (push t specializers-form)
               (push t specializers)))))
    (setq lambda-list (nreconc parameters lambda-list))
    (multiple-value-bind (body decls doc) (parse-body args env t)
      (multiple-value-bind (outer-decls inner-decls) 
                           (seperate-defmethod-decls decls)
        (let* ((methvar (make-symbol "NEXT-METHOD-CONTEXT"))
               (cnm-args (gensym))
               (lambda-form `(lambda ,(list* '&method methvar lambda-list)
                               (declare ;,@types
                                (ignorable ,@refs))
                               ,@outer-decls
                               (block ,(if (consp name) (cadr name) name)
                                 (flet ((call-next-method (&rest ,cnm-args)
                                          (declare (dynamic-extent ,cnm-args))
                                          (if ,cnm-args
                                            (apply #'%call-next-method-with-args ,methvar ,cnm-args)
                                            (%call-next-method ,methvar)))
                                        (next-method-p () (%next-method-p ,methvar)))
                                   (declare (inline call-next-method next-method-p))
                                   ,@inner-decls
                                   ,@body)))))
          (values
           (if name `(nfunction ,name ,lambda-form) `(function ,lambda-form))
           `(list ,@(nreverse specializers-form))
           (nreverse qualifiers)
	   lambda-list
           doc
           (nreverse specializers)))))))


(defmacro anonymous-method (name &rest args &environment env)
  (multiple-value-bind (function-form specializers-form qualifiers method-class documentation)
                       (parse-defmethod name args env)
    
    `(%anonymous-method
      ,function-form
      ,specializers-form
      ',qualifiers
      ,@(if (or method-class documentation) `(',method-class))
      ,@(if documentation `(,documentation)))))


(defmacro defclass (class-name superclasses slots &rest class-options &environment env)
  (flet ((duplicate-options (where) (signal-program-error "Duplicate options in ~S" where))
         (illegal-option (option) (signal-program-error "Illegal option ~s" option))
         (make-initfunction (form)
           (cond ((or (eq form 't)
                      (equal form ''t))
                  '(function true))
                 ((or (eq form 'nil)
                      (equal form ''nil))
                  '(function false))
                 (t
                  `(function (lambda () ,form))))))
    (setq class-name (require-type class-name '(and symbol (not null))))
    (setq superclasses (mapcar #'(lambda (s) (require-type s 'symbol)) superclasses))
    (let* ((options-seen ())
           (signatures ())
           (slot-names))
      (flet ((canonicalize-defclass-option (option)
               (let* ((option-name (car option)))
                 (if (member option-name options-seen :test #'eq)
                   (duplicate-options class-options)
                   (push option-name options-seen))
                 (case option-name
                   (:default-initargs
                     (let ((canonical ()))
                       (let (key val (tail (cdr option)))
                         (loop (when (null tail) (return nil))
			       (setq key (pop tail)
				     val (pop tail))
			       (push ``(,',key ,',val ,,(make-initfunction val)) canonical))
                         `(':direct-default-initargs (list ,@(nreverse canonical))))))
                   (:metaclass
                    (unless (and (cadr option)
                                 (typep (cadr option) 'symbol))
                      (illegal-option option))
                    `(:metaclass (find-class ',(cadr option))))
                   (:documentation
                    `(:documentation ',(cadr option)))
                   (t
                    (list `',option-name `',(cdr option))))))
             (canonicalize-slot-spec (slot)
               (if (null slot) (signal-program-error "Illegal slot NIL"))
               (if (not (listp slot)) (setq slot (list slot)))
               (let* ((slot-name (require-type (car slot) 'symbol))
		      (initargs nil)
                      (other-options ())
		      (initform nil)
		      (initform-p nil)
		      (initfunction nil)
		      (type nil)
		      (type-p nil)
		      (allocation nil)
		      (allocation-p nil)
		      (documentation nil)
		      (documentation-p nil)
		      (readers nil)
		      (writers nil))
                 (when (memq slot-name slot-names)
                   (SIGNAL-PROGRAM-error "Duplicate slot name ~S" slot-name))
                 (push slot-name slot-names)
                 (do ((options (cdr slot) (cddr options))
                      name)
                     ((null options))
                   (when (null (cdr options)) (signal-program-error "Illegal slot spec ~S" slot))
                   (case (car options)
                     (:reader
                      (setq name (cadr options))
		      (push name signatures)
                      (push name readers))
                     (:writer                      
                      (setq name (cadr options))
                      (push name signatures)
                      (push name writers))
                     (:accessor
                      (setq name (cadr options))
                      (push name signatures)
                      (push name readers)
                      (push `(setf ,name) signatures)
                      (push `(setf ,name) writers))
                     (:initarg
                      (push (require-type (cadr options) 'symbol) initargs))
                     (:type
                      (if type-p
			(duplicate-options slot)
			(setq type-p t))
                      ;; openMCL omits this 
                      ;(when (null (cadr options)) (signal-program-error "Illegal options ~S" options))
                      (setq type (cadr options)))
                     (:initform
                      (if initform-p
			(duplicate-options slot)
			(setq initform-p t))
                      (let ((option (cadr options)))
                        (setq initform `',option
                              initfunction
                              (if (constantp option)
                                `(constantly ,option)
                                `#'(lambda () ,option)))))
                     (:allocation
                      (if allocation-p
			(duplicate-options slot)
			(setq allocation-p t))
                      #+ignore
                      (unless (member (cadr options) '(:instance :class))
                        (unless (assoc :metaclass class-options)  ;; <<  is this right or just omit test
                          (signal-program-error "Illegal allocation ~s" (cadr options))))
                      (setq allocation (cadr options)))
                     (:documentation
                      (if documentation-p
			(duplicate-options slot)
			(setq documentation-p t))
                      (setq documentation (require-type (cadr options) 'string)))
                     (t
                      (let* ((pair (or (assq (car options) other-options)
                                       (car (push (list (car options)) other-options)))))
                        (push (cadr options) (cdr pair)))
                      ;(push `',(car options) other-options)
                      ;(push `',(cadr options) other-options)
                      )))
                 `(list :name ',slot-name
		        ,@(when allocation `(:allocation ',allocation))
		        ,@(when initform-p `(:initform ,initform
					               :initfunction ,initfunction))
		        ,@(when initargs `(:initargs ',initargs))
		        ,@(when readers `(:readers ',readers))
		        ,@(when writers `(:writers ',writers))
		        ,@(when type-p `(:type ',type))
		        ,@(when documentation `(:documentation ,documentation))
                        ,@(mapcan #'(lambda (opt)
                                 `(',(car opt) ',(if (null (cddr opt))
                                                     (cadr opt)
                                                     (cdr opt)))) other-options)
                        ;,@(nreverse other-options)
                        ))))
	(let* ((direct-superclasses superclasses) ; (or superclasses '(standard-object))) ;done later
	       (direct-slot-specs (mapcar #'canonicalize-slot-spec slots))
	       (other-options (apply #'append (mapcar #'canonicalize-defclass-option class-options ))))
	  `(progn
	     (eval-when (:compile-toplevel)
	       (%compile-time-defclass ',class-name ,env)
	       (progn
		 ,@(mapcar #'(lambda (s) `(note-function-info ',s nil ,env))
			   signatures)))
             (let ((*warn-if-redefine* nil))
               ,@(mapcar #'(lambda (s) `(record-source-file ',s 'accessor)) signatures)  ;; make edit-definition smarter some day
               ,@(mapcar #'(lambda (s) `(record-source-file ',s 'slot-name)) slot-names))
             (record-source-file ',class-name 'class)
             (ensure-class ',class-name
                           :direct-superclasses ',direct-superclasses
                           :direct-slots ,`(list ,@direct-slot-specs)
                           ,@other-options)))))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; after the fact fixup to a CLOS/MOP bug 
;; remove this when the bug is truly fixed

;; should have been defined but isn't
(defmethod (setf slot-definition-initargs) (new-value
                                            (slotd standard-slot-definition))
  (setf (slot-value slotd 'ccl::initargs) new-value))


#|
(defun find-slot-definition-with-initarg (initarg slot-definitions)
  "Return the SLOT-DEFINITION object that contains INITARG in its
   initargs, or NIL."
  (find initarg slot-definitions
     :test #'(lambda (key slotd)
	       (member key (slot-definition-initargs slotd)))))

(defun remove-bogus-initarg (class initarg)
  (when (typep class 'standard-class)
    (let* ((eslotd (find-slot-definition-with-initarg
                    initarg
                    (class-slots class))))
      (when eslotd
	;; It's a good thing that we started all this by
        ;; defining that writer method ...
        (setf (slot-definition-initargs eslotd)
              (delete initarg (slot-definition-initargs eslotd)))
        ;; Is this the class that defined the initarg directly ?
        (let* ((dslotd (find-slot-definition-with-initarg
                        initarg
                        (class-direct-slots class))))
          (if dslotd
            ;; Yes, remove the initarg from the direct slot definition            
            (setf (slot-definition-initargs dslotd)
                  (delete initarg (slot-definition-initargs dslotd)))
            ;; No, recurse.
            (dolist (super (class-direct-superclasses class))
              (remove-bogus-initarg super initarg))))))))
;; its in slots-class
(remove-bogus-initarg (find-class 'standard-class) :direct-slots)
|# 

;;;;;;;;;;;;;;;;; end fixup


(defmacro define-method-combination (name &rest rest &environment env)
  (setq name (require-type name 'symbol))
  (cond ((or (null rest) (and (car rest) (symbolp (car rest))))
         `(short-form-define-method-combination ',name ',rest))
        ((listp (car rest))
         (destructuring-bind (lambda-list method-group-specifiers . forms) rest
           (long-form-define-method-combination 
            name lambda-list method-group-specifiers forms env)))
        (t (%badarg (car rest) '(or (and null symbol) list)))))

(defmacro defgeneric (function-name lambda-list &rest options-and-methods &environment env)
  (fboundp function-name)             ; type-check
  (multiple-value-bind (method-combination generic-function-class options methods)
                       (parse-defgeneric function-name t lambda-list options-and-methods)
    (let ((gf (gensym)))
      `(progn
         (eval-when (:compile-toplevel)
           (note-function-info ',function-name nil ,env))
         (let ((,gf (%defgeneric
                     ',function-name ',lambda-list ',method-combination ',generic-function-class 
                     ',(apply #'append options))))
           (%set-defgeneric-methods ,gf ,@methods)
           ,gf)))))

(defmacro generic-function (lambda-list &rest options-and-methods)
  (multiple-value-bind (method-combination generic-function-class options methods)
                       (parse-defgeneric nil nil lambda-list options-and-methods)
    `(%generic-function
      ',lambda-list ',method-combination ',generic-function-class 
      ',(apply #'append options)
      ,@methods)))

(defun parse-defgeneric (function-name global-p lambda-list options-and-methods)
  (check-generic-function-lambda-list lambda-list)
  (let ((method-combination '(standard))
        (generic-function-class 'standard-generic-function)
        options methods option-keywords method-class)
    (flet ((bad-option (o)
             (SIGNAL-PROGRAM-error "Bad option: ~s to ~s." o 'defgeneric)))
      (dolist (o options-and-methods)
        (let ((keyword (car o))
              (defmethod (if global-p 'defmethod 'anonymous-method)))
          (if (eq keyword :method)
            (push `(,defmethod ,function-name ,@(%cdr o)) methods)
            (cond ((memq keyword (prog1 option-keywords (push keyword option-keywords)))
                   (SIGNAL-PROGRAM-error "Duplicate option: ~s to ~s" keyword 'defgeneric))
                  ((eq keyword :method-name)    ; used by generic-flet
                   (if function-name (bad-option o))
                   (setq function-name (cadr o)))
                  ((eq keyword :method-combination)
                   (unless (symbolp (cadr o))
                     (bad-option o))
                   (setq method-combination (cdr o)))
                  ((eq keyword :generic-function-class)
                   (unless (and (cdr o) (symbolp (cadr o)) (null (%cddr o)))
                     (bad-option o))
                   (setq generic-function-class (%cadr o)))
                  ((eq keyword 'declare)
                   (push (list :declare (cdr o)) options))
                  ((eq keyword :argument-precedence-order)
                   (dolist (arg (cdr o))
                     (unless (and (symbolp arg) (memq arg lambda-list))
                       (bad-option o)))
                   (push (list keyword (cdr o)) options))
                  ((eq keyword :method-class)
                   (push o options)
                   (when (or (cddr o) (not (symbolp (setq method-class (%cadr o)))))
                     (bad-option o)))
                  ((eq keyword :documentation)
                   (push o options)
                   (when (or (cddr o) (not (stringp (%cadr o))))
                     (bad-option o)))
                  (t (bad-option o)))))))
    (when method-class
      (dolist (m methods)
        (push `(:method-class ,method-class) (cddr m))))
    (values method-combination generic-function-class options methods)))

                 
(defmacro def-aux-init-functions (class &rest functions)
  `(set-aux-init-functions ',class (list ,@functions)))

(defmacro generic-flet (bindings &body body)
  `(fbind ,(mapcar #'(lambda (x)
                       (destructuring-bind (name ll . options) x
                         `(,name (generic-function ,ll (:method-name ,name) ,@options))))
                   bindings)
     ,@body))

(defmacro generic-labels (bindings &body body)
  (flet ((extract-methods (binding)
           (let ((methods nil)
                 (name (car binding))
                 method-class)
             (setf (cddr binding)
                   (let ((temp #'(lambda (option)
                            (when (consp option)
                              (cond ((eq (car option) :method)
                                     (push `(anonymous-method ,name ,@(cdr option))
                                           methods)
                                     t)
                                    ((eq (car option) :method-class)
                                     (setq method-class (cadr option))
                                     nil))))))
                     (declare (dynamic-extent temp))
                   (delete-if temp (cddr binding))))
             (when method-class
               (dolist (m methods)
                 (push `(:method-class ,method-class) (cddr m))))
             (values binding (nreverse methods)))))
    (let (gflet-bindings methods-list)
      (dolist (b bindings)
        (multiple-value-bind (b methods) (extract-methods b)
          (push b gflet-bindings)
          (push (cons (car b) methods) methods-list)))
      `(generic-flet ,(nreverse gflet-bindings)
         ,@(mapcar #'(lambda (ms) `(%add-methods (function ,(car ms)) ,@(cdr ms)))
                   (nreverse methods-list))
         ,@body))))

; A powerful way of defining REPORT-CONDITION...
; Do they really expect that each condition type has a unique method on PRINT-OBJECT
; which tests *print-escape* ?  Scary if so ...

(defmacro define-condition (name (&rest supers) &optional ((&rest slots)) &body options)
  ; If we could tell what environment we're being expanded in, we'd
  ; probably want to check to ensure that all supers name conditions
  ; in that environment.
  (let ((classopts nil)
        (duplicate nil)
        (defi-p nil)
        (docp nil)
        (reporter nil))
    (dolist (option options)
      (unless (and (consp option)
                   (consp (%cdr option))
                   ;(null (%cddr option))
                   )
        (error "Invalid option ~s ." option))
      (ecase (%car option)
       (:documentation 
        (if docp
          (setq duplicate t)
          (push (setq docp option) classopts)))
       (:default-initargs
         (if defi-p (setq duplicate t)(push (setq defi-p option) classopts)))
       (:report 
        (if reporter
          (setq duplicate t)
          (progn
          (if (or (lambda-expression-p (setq reporter (%cadr option)))
                  (symbolp reporter))
            (setq reporter `(function ,reporter))
            (if (stringp reporter)
              (setq reporter `(function (lambda (c s) (declare (ignore c)) (write-string ,reporter s))))
              (error "~a expression is not a string, symbol, or lambda expression ." (%car option))))
          (setq reporter `((defmethod report-condition ((c ,name) s)
                            (funcall ,reporter c s))))))))
      (if duplicate (error "Duplicate option ~s ." option)))
    `(progn
       (defclass ,name ,(or supers '(condition)) ,slots ,@classopts)
       ,@reporter
       ',name)))

(defmacro with-condition-restarts (&environment env condition restarts &body body)
  (multiple-value-bind (body decls)
                       (parse-body body env)
    (let ((cond (gensym))
          (r (gensym)))
          `(let* ((*condition-restarts* *condition-restarts*))
             ,@decls
             (let ((,cond ,condition))
               (dolist (,r ,restarts) (push (cons ,r ,cond) *condition-restarts*))
               ,@body)))))
  
(defmacro setf-find-class (name arg1 &optional (arg2 () 2-p) (arg3 () 3-p))
  (cond (3-p ;might want to pass env (arg2) to find-class someday?
         `(set-find-class ,name (progn ,arg1 ,arg2 ,arg3)))
        (2-p
         `(set-find-class ,name (progn ,arg1 ,arg2)))
        (t `(set-find-class ,name ,arg1))))

(defsetf find-class setf-find-class)

;; undoes the effect of one enclosing without-interrupts during execution of body.
(defmacro ignoring-without-interrupts (&body body)
  `(let ((*interrupt-level* 0))   ; anything non-negative is ok
     ,@body))

(defmacro error-ignoring-without-interrupts (format-string &rest format-args)
  `(ignoring-without-interrupts
    (error ,format-string ,@format-args)))

#-ignore
;; too much hair below for e.g. blinking caret
(defmacro with-pen-saved-simple (&body body)
    "executes body and restores state of window pen"
    (let ((old-pen-state (gensym)))
      `(rlet ((,old-pen-state :penstate))
         (unwind-protect
           (progn
             (require-trap #_GetPenState ,old-pen-state)
             ,@body)
           (require-trap #_SetPenState ,old-pen-state)))))

#+ignore
(defmacro with-pen-saved (&body body)
  "save and restore pen around body being wary of SetThemePen."  
  (let ((old-pen-state (gensym))
        (old-state (gensym))
        (my-window (gensym)))
    `(let* ((,old-state nil)
            (,my-window (get-current-window)))       
       (rlet ((,old-pen-state :penstate))
         (when (and ,my-window (window-theme-background ,my-window)(not (window-prior-theme-drawing-state ,my-window))) ;*is-normalized*)
           (rlet ((old-statep :ptr))
             ;(setq *is-normalized* t)
             (require-trap #_getthemedrawingstate old-statep)
             (setq ,old-state (%get-ptr old-statep))
             (setf (window-prior-theme-drawing-state ,my-window) ,old-state)))        
         (require-trap #_getpenstate ,old-pen-state)             
         (unwind-protect
           (progn             
             ,@body)
           (when T
             (require-trap #_SETPENSTATE ,old-pen-state)
             (when ,old-state
               (setf (window-prior-theme-drawing-state ,my-window) nil)
               (require-trap #_setthemedrawingstate ,old-state t))
             ))))))

(defmacro with-pen-saved (&body body)
  "save and restore pen around body being wary of SetThemePen."  
  (let ((old-pen-state (gensym)))
    `(rlet ((,old-pen-state :penstate))
       (with-theme-state-preserved
         (require-trap #_getpenstate ,old-pen-state)
         (unwind-protect
           (progn
             ,@body)
           (require-trap #_SETPENSTATE ,old-pen-state))))))

(defmacro with-clip-rect (rect &body body)
  (let ((sym (gensym)))
   `(with-macptrs ((,sym (require-trap #_NewRgn)))
     (require-trap #_getclip ,sym)
     (unwind-protect
       (progn
         (require-trap #_cliprect ,rect)
        ,@body)
      (require-trap #_SetClip ,sym)
      (require-trap #_DisposeRgn ,sym)))))

(defmacro with-clip-rect-intersect (rect &rest body)
  (let ((old (gensym))
        (new (gensym)))
    `(with-macptrs ((,old (require-trap #_NewRgn))
                    (,new (require-trap #_NewRgn)))
       (require-trap #_getclip ,old)
       (require-trap #_rectrgn ,new ,rect)
       (require-trap #_SectRgn ,old ,new ,new)
       (require-trap #_SetClip ,new)
       (unwind-protect
         (progn ,@body)
         (require-trap #_SetClip ,old)
         (require-trap #_DisposeRgn ,old)
         (require-trap #_DisposeRgn ,new)))))

#+ignore ;; unused
(defmacro with-new-full-port (port &body body)
  (let ((rgn (gensym)))
    `(with-macptrs (,rgn)
       (with-port ,port
         (%setf-macptr ,rgn (require-trap #_NewRgn))
         (require-trap #_GetClip ,rgn)
         (unwind-protect
           (progn
             (require-trap #_SetClip *big-rgn*)
	     ,@body)
           (require-trap #_SetClip ,rgn)
           (require-trap #_DisposeRgn ,rgn))))))

(defmacro ok-wptr (wptr)
  `(and ,wptr (not (%null-ptr-p ,wptr))))

(defmacro with-port-macptr (port-name &rest body)
  (let ((it (gensym)))
    `(rlet ((,it :pointer))
       (require-trap #_getport ,it)
       (with-macptrs ((,port-name (%get-ptr ,it)))
         ,@body))))


(defmacro with-font-codes (ff-code ms-code &rest body)
  (let ((port-sym (gensym))
        (font-sym (gensym))
        (face-sym (gensym))
        (mask-sym (gensym))
        (size-sym (gensym)))
  `(with-port-macptr ,port-sym
    (let* ((,font-sym (require-trap #_getporttextfont ,port-sym))
           (,face-sym (require-trap #_getporttextface ,port-sym))
           (,mask-sym (require-trap #_getporttextmode ,port-sym))
           (,size-sym (require-trap #_getporttextsize ,port-sym)))
     (unwind-protect
       (progn
         (if ,ff-code (progn (require-trap #_textfont (ash ,ff-code -16))
                             (require-trap #_textface (logand (ash ,ff-code -8) #xff))))
         (if ,ms-code (progn 
                        (require-trap #_textmode (ash ,ms-code -16))
                        (require-trap #_textsize (logand ,ms-code #xffff))))
         ,@body)
       (when (ok-wptr ,port-sym)
         (require-trap #_textfont ,font-sym)
         (require-trap #_textface ,face-sym)
         (require-trap #_textmode ,mask-sym)
         (require-trap #_textsize ,size-sym)))))))

; JUST SET the font part, dont care about face or ms

(defmacro with-font (font &rest body)
  (let ((port-sym (gensym))
        (ff-hi-sym (gensym)))
  `(with-port-macptr ,port-sym
    (let* ((,ff-hi-sym (require-trap #_getporttextfont ,port-sym)))
     (unwind-protect
       (progn
         (require-trap #_textfont ,font)
         ,@body)
       (when (ok-wptr ,port-sym)
         (require-trap #_textfont ,ff-hi-sym)))))))

 

;init-list-default: if there is no init pair for <keyword>,
;    add a <keyword> <value> pair to init-list
;; not used, not documented, is exported - lose it?
(defmacro init-list-default (the-init-list &rest args)
  (let ((result)
       (init-list-sym (gensym)))
   (do ((args args (cddr args)))
       ((not args))
     (setq result 
           (cons `(if (eq '%novalue (getf ,init-list-sym ,(car args) 
                                          '%novalue))
                    (setq ,init-list-sym (cons ,(car args) 
                                               (cons ,(cadr args) 
                                                     ,init-list-sym))))
                 result)))                                                                                
   `(let ((,init-list-sym ,the-init-list))
      (progn ,@result)
      ,init-list-sym)
   ))

; This can only be partially backward-compatible: even if only
; the "name" arg is supplied, the old function would create the
; package if it didn't exist.
; Should see how well this works & maybe flush the whole idea.

(defmacro in-package (&whole call name &rest gratuitous-backward-compatibility)
  (let ((form nil))
    (cond (gratuitous-backward-compatibility
           (cerror "Macroexpand into a call to the old IN-PACKAGE function."
                   "Macro call ~S contains extra arguments." call )
           (setq form `(ccl::old-in-package ,name ,@gratuitous-backward-compatibility)))
        (t
         (when (quoted-form-p name)
           (warn "Unquoting argument ~S to ~S." name 'in-package )
           (setq name (cadr name)))    
         (unless (or (stringp name) (symbolp name)(characterp name))
           (setq name (require-type name '(or string symbol character))))
         (setq form `(set-package ,(string name)))))
         `(eval-when (:execute :load-toplevel :compile-toplevel)
            ,form)))

(defmacro defpackage (name &rest options)
  (let* ((size nil)
         (all-names-size 0)
         (intern-export-size 0)
         (shadow-etc-size 0)
         (all-names-hash (let ((all-options-alist nil))
                           (dolist (option options)
                             (let ((option-name (car option)))
                               (when (memq option-name
                                           '(:nicknames :shadow :shadowing-import-from
                                             :use :import-from :intern :export))
                                 (let ((option-size (length (cdr option)))
                                       (cell (assq option-name all-options-alist)))
                                   (declare (fixnum option-size))
                                   (if cell
                                     (incf (cdr cell) option-size)
                                     (push (cons option-name option-size) all-options-alist))
                                   (when (memq option-name '(:shadow :shadowing-import-from :import-from :intern))
                                     (incf shadow-etc-size option-size))
                                   (when (memq option-name '(:export :intern))
                                     (incf intern-export-size option-size))))))
                           (dolist (cell all-options-alist)
                             (let ((option-size (cdr cell)))
                               (when (> option-size all-names-size)
                                 (setq all-names-size option-size))))
                           (when (> all-names-size 0)
                             (make-hash-table :test 'equal :size all-names-size))))
         (intern-export-hash (when (> intern-export-size 0)
                               (make-hash-table :test 'equal :size intern-export-size)))
         (shadow-etc-hash (when (> shadow-etc-size 0)
                            (make-hash-table :test 'equal :size shadow-etc-size)))
         (external-size nil)
         (nicknames nil)
         (shadow nil)
         (shadowing-import-from-specs nil)
         (use :default)
         (import-from-specs nil)
         (intern nil)
         (export nil)
         (documentation nil))
    (declare (fixnum all-names-size intern-export-size shadow-etc-size))
    (labels ((string-or-name (s)(string s))
             (duplicate-option (o)
               (signal-program-error "Duplicate ~S option in ~S ." o options))
             (duplicate-name (name option-name)
               (signal-program-error "Name ~s, used in ~s option, is already used in a conflicting option ." name option-name))
             (all-names (option-name tail already)
               (when (eq already :default) (setq already nil))
               (when all-names-hash
                 (clrhash all-names-hash))
               (dolist (name already)
                 (setf (gethash (string-or-name name) all-names-hash) t))
               (dolist (name tail already)
                 (setq name (string-or-name name))
                 (unless (gethash name all-names-hash)          ; Ok to repeat name in same option.
                   (when (memq option-name '(:shadow :shadowing-import-from :import-from :intern))
                     (if (gethash name shadow-etc-hash)
                       (duplicate-name name option-name))
                     (setf (gethash name shadow-etc-hash) t))
                   (when (memq option-name '(:export :intern))
                     (if (gethash name intern-export-hash)
                       (duplicate-name name option-name))
                     (setf (gethash name intern-export-hash) t))
                   (setf (gethash name all-names-hash) t)
                   (push name already)))))
      (dolist (option options)
        (let ((args (cdr option)))
          ;;; Ecase sucks.  We should fix it. Cause we get a type-error vs program-error?
          (ecase (%car option)
                 (:size 
                  (if size 
                    (duplicate-option :size) 
                    (setq size (car args))))
                 (:external-size 
                  (if external-size 
                    (duplicate-option :external-size) 
                    (setq external-size (car args))))
                 (:nicknames (setq nicknames (all-names nil args nicknames)))
                 (:shadow (setq shadow (all-names :shadow args shadow)))
                 (:shadowing-import-from
                  (destructuring-bind (from &rest shadowing-imports) args
                    (push (cons (string-or-name from)
                                (all-names :shadowing-import-from shadowing-imports nil))
                          shadowing-import-from-specs)))
                 (:use (setq use (all-names nil args use)))
                 (:import-from
                  (destructuring-bind (from &rest imports) args
                    (push (cons (string-or-name from)
                                (all-names :import-from imports nil))
                          import-from-specs)))
                 (:intern (setq intern (all-names :intern args intern)))
                 (:export (setq export (all-names :export args export)))
                 (:documentation 
                  (if documentation (duplicate-option :documentation))
                  (setq documentation (car args))))))
      `(eval-when (:execute :compile-toplevel :load-toplevel)
         ;;;; new code here
                  
                  (record-source-file ',(intern (string-or-name name)) 'package)
                  ,@(let ((result nil))
                         (dolist (nickname nicknames)
                            (push `(record-source-file ',(intern (string-or-name nickname)) 'package)
                                     result))
                         (nreverse result))
                  
                  ;;; end of new code
         
         (%define-package ',(string-or-name name)
                          ',size 
                          ',external-size 
                          ',nicknames
                          ',shadow
                          ',shadowing-import-from-specs
                          ',use
                          ',import-from-specs
                          ',intern
                          ',export
                          ,@(if documentation `(',documentation)))))))


(defmacro %cons-pkg-iter (pkgs types)
  `(vector ,pkgs ,types #'%start-with-package-iterator
           nil nil nil nil))

(defmacro with-package-iterator ((mname package-list first-type &rest other-types)
                                 &body body)
  (setq mname (require-type mname 'symbol))
  (let ((state (make-symbol "WITH-PACKAGE-ITERATOR_STATE"))
        (types 0))
    (declare (fixnum types))
    (dolist (type (push first-type other-types))
      (case type
        (:external (setq types (bitset $pkg-iter-external types)))
        (:internal (setq types (bitset $pkg-iter-internal types)))
        (:inherited (setq types (bitset $pkg-iter-inherited types)))
        (t (%badarg type '(member :internal :external :inherited)))))
    `(let ((,state (%cons-pkg-iter ,package-list ',types)))
       (declare (dynamic-extent ,state))
       (macrolet ((,mname () `(funcall (%svref ,',state #.pkg-iter.state) ,',state)))
         ,@body))))

; Does NOT evaluate the constructor, but DOES evaluate the destructor & initializer
(defmacro defresource (name &key constructor destructor initializer)
  `(defparameter ,name (make-resource #'(lambda () ,constructor)
                                      ,@(when destructor
                                          `(:destructor ,destructor))
                                      ,@(when initializer
                                          `(:initializer ,initializer)))))

(defmacro using-resource ((var resource) &body body)
  (let ((resource-var (gensym)))
  `(let ((,resource-var ,resource)
         ,var)
     (unwind-protect
       (progn
         (setq ,var (allocate-resource ,resource-var))
         ,@body)
       (when ,var
         (free-resource ,resource-var ,var))))))

(defmacro with-lock-grabbed ((lock &optional
                                   (lock-value '*current-process*)
                                   (whostate "Lock"))
                             &body body)
  (let ((flag (gensym))
        (setter (gensym))
        (lock-var (gensym))
        (lock-value-var (gensym)))
    `(let* ((,flag nil)
            (,setter #'(lambda () (setq ,flag t)))
            (,lock-var ,lock)
            (,lock-value-var ,lock-value))
       (declare (dynamic-extent ,setter))
       (unwind-protect
         (progn
           (process-lock ,lock-var ,lock-value-var ,whostate ,setter)
           ,@body)
         (when ,flag
           (process-unlock ,lock-var ,lock-value-var))))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(with-lock)))
;; for cl-http does multiple-reader-single-writer maybe - requires bigger lock structure etal
(defmacro with-lock ((lock &key mode (lock-value '*current-process*) (whostate "Lock")) &body body)
  (let ((flag (gensym))
        (setter (gensym))
        (lock-var (gensym))
        (lock-value-var (gensym))
        (what-for-var (gensym))
        )
    `(let* ((,flag nil)
            (,setter #'(lambda () (setq ,flag t)))
            (,lock-var ,lock)
            (,lock-value-var ,lock-value)
            (,what-for-var ,mode))
       (declare (dynamic-extent ,setter))       
       (require-type ,what-for-var '(member nil :read :write))
       (require-type ,lock-var 'lock)
       (when (neq (lock-type ,lock-var) :multiple-reader-single-writer)
         (setq ,what-for-var nil))
       #+ignore
       (when (memq ,what-for-var '(:read :write))
         (when (neq (lock-type ,lock-var) :multiple-readers)
           (error "Lock ~s is not of type :multiple-readers" ,lock-var)))
       (unwind-protect
         (progn 
           (if (and (eq ,what-for-var :read)
                    (eq (lock.value ,lock-var) :read))
             ;; its already locked for reading so just do it
             (progn (incf (lock.nreaders ,lock-var))
                    (setq ,flag :not-first))
             (progn
               ;; can be interrupted on entry to process-lock
               (process-lock ,lock-var (if (eq ,what-for-var :read) :read ,lock-value-var) ,whostate ,setter)               
               ;; newly locked for reading
               (when (eq ,what-for-var :read)
                 (if ,flag
                   (setf (lock.nreaders ,lock-var) 1)
                   ;; if somebody else got there first??
                   (progn
                     (setq ,flag t)
                     (incf (lock.nreaders ,lock-var)))))))
           ,@body)
         (when ,flag  ;; flag is nil if already locked with this lock.value (unless not first read).             
           (if (or (null ,what-for-var)(eq ,what-for-var :write))                         
             (process-unlock ,lock-var ,lock-value-var)
             (if (eq ,what-for-var :read)
               (without-interrupts ;; too bad
                 (decf (lock.nreaders ,lock-var))
                 (when (<= (lock.nreaders ,lock-var) 0)
                   (process-unlock ,lock-var :read))))))))))

(defmacro with-process-enqueued ((queue &optional queue-value whostate (signal-dequeue-errors t sdq?))
                                 &body body)
  (let ((q (gensym))
        (qv (gensym))
        (queued? (gensym)))
    `(let ((,q ,queue)
           (,qv ,queue-value)
           (,queued? nil))
       (unwind-protect
         (progn
           (without-interrupts
            (process-enqueue ,q ,qv ,@(when whostate `(,whostate)))
            (setq ,queued? t))
           ,@body)
         (when ,queued?
           (process-dequeue ,q ,qv ,@(when sdq? `(,signal-dequeue-errors))))))))

(defmacro with-standard-abort-handling (abort-message &body body)
  (let ((stream (gensym)))
    `(restart-case
       (catch :abort
         (catch-cancel
           ,@body))
       (abort () ,@(when abort-message
                     `(:report (lambda (,stream)
                                 (write-string ,abort-message ,stream)))))
       (abort-break ()))))
       
(defmacro with-process-background-p-value (value &body body)
  (let ((p (gensym))
        (background-p (gensym)))
  `(let* ((,p *current-process*)
          (,background-p (process-background-p ,p)))
     (unwind-protect
       (progn
         (setf (process-background-p ,p) ,value)
         ,@body)
       (setf (process-background-p ,p) ,background-p)))))

; The Listener wraps this around its evaluation of user forms
(defmacro with-non-background-process (&body body)
  `(with-process-background-p-value nil
     (setq *idle* nil)
     ,@body))

; The break loop wraps this around its body to undo the
; without-background-process put there by the Listener
(defmacro with-background-process (&body body)
  `(with-process-background-p-value t ,@body))


(defmacro %lexpr-count (l)
  `(%lisp-word-ref ,l 0))

(defmacro %lexpr-ref (lexpr count i)
  `(%lisp-word-ref ,lexpr (%i- ,count ,i)))

; args will be list if old style clos
(defmacro apply-with-method-context (magic function args)
  (let ((m (gensym))
        (f (gensym))
        (as (gensym)))
    (if (not (ppc-target-p))
      `((lambda (,m ,f ,as)
          (set-%saved-method-var% ,m)
          (if (listp ,as)
            (apply ,f ,as)
            (%apply-lexpr ,f ,as))) ,magic ,function ,args)
      `((lambda (,m ,f ,as)
          (if (listp ,as)
            (%ppc-apply-with-method-context ,m ,f ,as)
            (%ppc-apply-lexpr-with-method-context ,m ,f ,as))) ,magic ,function ,args))))

(defmacro with-foreign-window (&body body)
  (let ((thunk (gensym)))
    `(let ((,thunk #'(lambda () ,@body)))
       (declare (dynamic-extent ,thunk))
       (funcall-with-foreign-window ,thunk))))

#| ;; its in l1-events.lisp
(defmacro with-timer (&body body)
    `(unwind-protect
       (progn (activate-timer)
              ,@body)
       (deactivate-timer)))
|#

#+ppc-target
(defmacro define-symbol-macro (name expansion &environment env)
  `(progn (eval-when (:compile-toplevel)
            (%define-compile-time-symbol-macro ',name ',expansion ',env))
          (eval-when (:load-toplevel :execute)          
            (%define-symbol-macro ',name ',expansion))))

; This used to be called 'method but ANSI says you can't redefine that symbol in the CL package
(defmacro reference-method (gf &rest qualifiers-and-specializers)
  (let ((qualifiers (butlast qualifiers-and-specializers))
        (specializers (car (last qualifiers-and-specializers))))
    (if (null specializers) (report-bad-arg qualifiers-and-specializers '(not null)))
    `(find-method #',gf ',qualifiers (mapcar #'find-specializer ',specializers))))


(defmacro with-slots (slot-entries instance-form &body body)
  (let ((instance (gensym)) var slot-name bindings)
    (dolist (slot-entry slot-entries)
      (cond ((symbolp slot-entry)
             (setq var slot-entry slot-name slot-entry))
            ((and (listp slot-entry) (cdr slot-entry) (null (cddr slot-entry))
                  (symbolp (car slot-entry)) (symbolp (cadr slot-entry)))
             (setq var (car slot-entry) slot-name (cadr slot-entry)))
            (t (error "Malformed slot-entry: ~a to with-slots.~@
                       Should be a symbol or a list of two symbols."
                      slot-entry)))
      (push `(,var (slot-value ,instance ',slot-name)) bindings))
    `(let ((,instance ,instance-form))
       ,@(unless bindings (list `(declare (ignore ,instance))))
       (symbol-macrolet ,(nreverse bindings)
         ,@body))))

(defmacro with-accessors (slot-entries instance-form &body body)
  (let ((instance (gensym)) var reader bindings)
    (dolist (slot-entry slot-entries)
      (cond ((and (listp slot-entry) (cdr slot-entry) (null (cddr slot-entry))
                  (symbolp (car slot-entry)) (symbolp (cadr slot-entry)))
             (setq var (car slot-entry) reader (cadr slot-entry)))
            (t (error "Malformed slot-entry: ~a to with-accessors.~@
                       Should be a list of two symbols."
                      slot-entry)))
      (push `(,var (,reader ,instance)) bindings))
    `(let ((,instance ,instance-form))
       ,@(unless bindings (list `(declare (ignore ,instance))))
       (symbol-macrolet ,(nreverse bindings)
         ,@body))))

;; should these be elsewhere?
(export '(class-instance-slots class-direct-instance-slots class-class-slots) :ccl)
(defmethod class-instance-slots ((class std-class))
  (loop for s in (class-slots class)
        when (eq :instance (slot-definition-allocation s))  
        collect s))

(defmethod class-direct-instance-slots ((class std-class))
  (class-direct-xxx-slots class :instance))

(defmethod class-class-slots ((class std-class))
  (loop for s in (class-slots class)
        when (eq :class (slot-definition-allocation s))  
        collect s))

(defmethod class-direct-class-slots ((class std-class))
    (class-direct-xxx-slots class :class))

(defun class-direct-xxx-slots (class allocation)
  (loop for s in (class-direct-slots class)
         when (eq allocation (slot-definition-allocation s))
         collect s))
  



;;; Simplified form of with-slots.  Expands into a let instead of a symbol-macrolet
;;; Thus, you can access the slot values, but you can't setq them.
(defmacro with-slot-values (slot-entries instance-form &body body)
  (let ((instance (gensym)) var slot-name bindings)
    (dolist (slot-entry slot-entries)
      (cond ((symbolp slot-entry)
             (setq var slot-entry slot-name slot-entry))
            ((and (listp slot-entry) (cdr slot-entry) (null (cddr slot-entry))
                  (symbolp (car slot-entry)) (symbolp (cadr slot-entry)))
             (setq var (car slot-entry) slot-name (cadr slot-entry)))
            (t (error "Malformed slot-entry: ~a to with-slot-values.~@
                       Should be a symbol or a list of two symbols."
                      slot-entry)))
      (push `(,var (slot-value ,instance ',slot-name)) bindings))
    `(let ((,instance ,instance-form))
       (let ,(nreverse bindings)
         ,@body))))

(defmacro %get-local-mouse-position ()
  `(rlet ((point :point))
     (require-trap #_GetMouse point)
     (%get-point point)))

(defmacro %get-global-mouse-position ()  
 `(rlet ((pt :point))
    (require-trap #_GetGlobalMouse pt)
    (%get-point pt)))


;; moved here from ppc-arch where was internal to ppc package

;;;; The Collect macro:

;;; Collect-Normal-Expander  --  Internal
;;;
;;;    This function does the real work of macroexpansion for normal collection
;;; macros.  N-Value is the name of the variable which holds the current
;;; value.  Fun is the function which does collection.  Forms is the list of
;;; forms whose values we are supposed to collect.
;;;
(eval-when (:compile-toplevel :load-toplevel :execute)



(defun collect-normal-expander (n-value fun forms)
  `(progn
     ,@(mapcar #'(lambda (form) `(setq ,n-value (,fun ,form ,n-value))) forms)
     ,n-value))



;;; Collect-List-Expander  --  Internal
;;;
;;;    This function deals with the list collection case.  N-Tail is the pointer
;;; to the current tail of the list, which is NIL if the list is empty.
;;;
(defun collect-list-expander (n-value n-tail forms)
  (let ((n-res (gensym)))
    `(progn
       ,@(mapcar #'(lambda (form)
                     `(let ((,n-res (cons ,form nil)))
                        (cond (,n-tail
                               (setf (cdr ,n-tail) ,n-res)
                               (setq ,n-tail ,n-res))
                              (t
                               (setq ,n-tail ,n-res  ,n-value ,n-res)))))
                 forms)
       ,n-value)))
)

;;;
;;;    The ultimate collection macro...
;;;
(defmacro collect (collections &body body)
  "Collect ({(Name [Initial-Value] [Function])}*) {Form}*
  Collect some values somehow.  Each of the collections specifies a bunch of
  things which collected during the evaluation of the body of the form.  The
  name of the collection is used to define a local macro, a la MACROLET.
  Within the body, this macro will evaluate each of its arguments and collect
  the result, returning the current value after the collection is done.  The
  body is evaluated as a PROGN; to get the final values when you are done, just
  call the collection macro with no arguments.

  Initial-Value is the value that the collection starts out with, which
  defaults to NIL.  Function is the function which does the collection.  It is
  a function which will accept two arguments: the value to be collected and the
  current collection.  The result of the function is made the new value for the
  collection.  As a totally magical special-case, the Function may be Collect,
  which tells us to build a list in forward order; this is the default.  If an
  Initial-Value is supplied for Collect, the stuff will be rplacd'd onto the
  end.  Note that Function may be anything that can appear in the functional
  position, including macros and lambdas."
  
  
  (let ((macros ())
        (binds ()))
    (dolist (spec collections)
      (unless (<= 1 (length spec) 3)
        (error "Malformed collection specifier: ~S." spec))
      (let ((n-value (gensym))
            (name (first spec))
            (default (second spec))
            (kind (or (third spec) 'collect)))
        
        (push `(,n-value ,default) binds)
        (if (eq kind 'collect)
          (let ((n-tail (gensym)))
            (if default
              (push `(,n-tail (last ,n-value)) binds)
              (push n-tail binds))
            (push `(,name (&rest args)
                          (collect-list-expander ',n-value ',n-tail args))
                  macros))
          (push `(,name (&rest args)
                        (collect-normal-expander ',n-value ',kind args))
                macros))))
    `(macrolet ,macros (let* ,(nreverse binds) ,@body))))

; Some of these macros were stolen from CMUCL.  Sort of ...

(defmacro iterate (name binds &body body)
  "Iterate Name ({(Var Initial-Value)}*) Declaration* Form*
  This is syntactic sugar for Labels.  It creates a local function Name with
  the specified Vars as its arguments and the Declarations and Forms as its
  body.  This function is then called with the Initial-Values, and the result
  of the call is return from the macro."
  (dolist (x binds)
    (unless (and (listp x)
                 (= (length x) 2))
      (error "Malformed iterate variable spec: ~S." x)))

  `(labels ((,name ,(mapcar #'first binds) ,@body))
     (,name ,@(mapcar #'second binds))))

(defmacro once-only (specs &body body)
  "Once-Only ({(Var Value-Expression)}*) Form*
  Create a Let* which evaluates each Value-Expression, binding a temporary
  variable to the result, and wrapping the Let* around the result of the
  evaluation of Body.  Within the body, each Var is bound to the corresponding
  temporary variable."
  (iterate frob
           ((specs specs)
            (body body))
    (if (null specs)
        `(progn ,@body)
        (let ((spec (first specs)))
          (when (/= (length spec) 2)
            (error "Malformed Once-Only binding spec: ~S." spec))
          (let ((name (first spec))
                (exp-temp (gensym)))
            `(let ((,exp-temp ,(second spec))
                   (,name (gensym)))
               `(let ((,,name ,,exp-temp))
                  ,,(frob (rest specs) body))))))))

(provide 'level-2)

;; end of level-2.lisp

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
