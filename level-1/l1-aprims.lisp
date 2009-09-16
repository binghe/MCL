;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: l1-aprims.lisp,v $
;;  Revision 1.32  2006/02/03 00:35:18  alice
;;  ;; char-upcase and char-downcase may return a second value if result is more than one char
;; delete some #-ppc-target stuff
;;
;;  Revision 1.31  2005/11/12 20:43:49  alice
;;  
;; #\newline -> #\return
;;
;;  Revision 1.30  2005/09/10 09:31:31  alice
;;  
;; fix char-upcase-vector for mu #\µ
;; add xwhitespace-p
;;
;;  Revision 1.29  2005/08/07 03:29:27  alice
;;  ;; add xwhitespace-p
;; put back %str-to-handle - is used in some examples
;;
;;  Revision 1.28  2005/07/24 18:45:20  alice
;;  ;; unicode-char-code-upcase and downcase - if result is more than 1 char, return 2 values, orig code and string of result
;;
;;  Revision 1.27  2005/07/17 20:23:01  alice
;;  ;; %str-cat - no more copy-string-arg
;; redefine make-string here. the def in level-0;l0-array.lisp is wrong
;;
;;  Revision 1.26  2005/03/09 19:34:03  alice
;;  ;; add xcontrol-char-p
;;
;;  Revision 1.25  2005/03/04 01:02:51  alice
;;  ;; alpha-char-table-1 now correct for unicode to 256, add char-upcase-vector, char-downcase-vector
;;
;;  Revision 1.23  2005/02/18 05:03:57  alice
;;  ;; change to unicode upcase and downcase so don't crash if result is multi-char
;;
;;  Revision 1.22  2005/02/08 04:50:43  alice
;;  ;; lose extended-string-font and relatives
;;
;;  Revision 1.21  2005/02/07 01:58:30  alice
;;  ;; alpha-char-p doesn't care about script, lose string-compare-script
;;
;;  Revision 1.20  2005/02/04 04:57:06  alice
;;  comment out an unused function
;;
;;  Revision 1.19  2005/02/01 07:13:00  alice
;;  ;; char-upcase and downcase assume char is unicode
;;
;;  Revision 1.18  2004/12/20 21:33:52  alice
;;  ;; eol stuff
;;
;;  Revision 1.17  2004/06/01 22:39:14  alice
;;  ;; fix error message in chkbounds
;;
;;  Revision 1.16  2003/12/29 04:07:56  gtbyers
;;  Define LISTP here.
;;
;;  Revision 1.15  2003/12/08 08:33:45  gtbyers
;;  Move GET-PROPERTIES here.  Remove some 68K lap; so much 68K lap, so
;;  little time ...
;;
;;  4 7/4/97   akh  see below
;;  3 6/9/97   akh  see below 
;;  2 6/2/97   akh  see below
;;  55 1/22/97 akh  optimizations for string and character comparisons
;;  48 6/7/96  akh  lfun-keyvect for interpreted funs
;;  46 5/20/96 akh  set-top-level - comment out require-type - dont rememeber why
;;  44 3/27/96 akh  fix itlb resource thing
;;  36 2/19/96 akh  fix element-type-subtype
;;                  get subtype right in make-displaced-array
;;  35 2/19/96 akh  %make-displaced-array - fix for rank 0
;;  34 2/6/96  akh  fix char-sort-table for roman script
;;  28 12/1/95 akh  simplify pstr/cstr segment-pointer
;;  27 11/24/95 bill 3.0x43
;;  25 11/20/95 slh 
;;  24 11/19/95 gb  %make-displaced-array, %make-gcable-macptr fixes
;;  22 11/15/95 gb  fix in make-displaced-array for PPC
;;  21 11/14/95 gb  %list-to-uvector: don't pass null subtype to %alloc-misc
;;  18 11/9/95 akh  delete ppc def of closure-function
;;  16 10/31/95 akh add a blr
;;                  put back 68k lap for move-string-bytes. The editor is slow enough already.
;;  13 10/27/95 bill see below
;;  12 10/27/95 akh %register trap and %stack trap aren't gonzo
;;  11 10/27/95 akh damage control
;;  10 10/26/95 gb  gcable-macptr changes
;;  9 10/23/95 akh  lots of ppc stuff
;;  8 10/17/95 akh  some delap, merge patches
;;  7 10/11/95 akh  some lap substitutes for some lfun stuff
;;  6 10/10/95 akh  move-string-bytes for PPC
;;  3 10/9/95  akh  merge patches
;;  (do not edit before this line!!)

;; L1-aprims.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc. 

; This file must be loaded in order to be compiled.

;; Modification History
;; unicode-char-code-downcase/upcase faster
;; ------ 5.2b6
;; char-upcase and char-downcase may return a second value if result is more than one char
;; delete some #-ppc-target stuff
;; #\newline -> #\return
;; added xdecimal-digit-p
;; fix char-upcase-vector for mu #\µ
;; add xwhitespace-p
;; put back %str-to-handle - is used in some examples
;; unicode-char-code-upcase and downcase - if result is more than 1 char, return 2 values, orig code and string of result
;; %str-cat - no more copy-string-arg
;; redefine make-string here. the def in level-0;l0-array.lisp is wrong
;; add xcontrol-char-p
;; alpha-char-table-1 now correct for unicode to 256, add char-upcase-vector, char-downcase-vector 
;; fix upcase and downcase to not mess with multiply and divide chars in latin1 range
;; change to unicode upcase and downcase so don't crash if result is multi-char
;; lose extended-string-font and relatives
;; alpha-char-p doesn't care about script, lose string-compare-script
;; char-upcase and downcase assume char is unicode
;; add line separator and paragraph separator to eol stuff
;; eol stuff
;; ------ 5.1final
;; fix error message in chkbounds
;; ----- 5.1b2
;; 12/03/03 string-compare-script again
;; 11/23/03 use new-with-pointers
;; akh 10/27/03 - undo CVS mangle for good I hope
;; see string-compare-script
;; make-char-equal-sort-table fix
;; ------- 5.0 final
;; no change
;; %str-cat deals with non simple strings
;; unmangle cvs mangle of char-up-string-1 and char-down-string-1
;; ------- 4.4b5
;; add convert-string for from-encoding to to-encoding - moved for boot reasons
;; ---------- 4.4b4
;; getscript -> getscriptvariable
;; iumagpstring -> comparetext
; uppertext => uppercasetext etc.
; 10/03/99 akh move-string-bytes uses copy-8-ivector-to-16-ivector
; akh xchar-up-down always does the slow way (fixes non-japanese 2 byte scripts).
;--------- 4.3f1c1
; 05/08/99 akh upgraded-array-element-type and upgraded-complex-part-type get optional ignored env args
; 05/06/99 akh fix alpha-char-p for  roman >= 128
;; -------------- 4.3b1
; 12/12/98 akh configure-egc and egc-configuration get generation-1 area right when egc is off
; 10/04/98 akh coerce-to-uvector - return-from in list case
; 05/01/97 akh real-xstring-p checks extended-string-p before groveling down the string
;----------- 4.1
; 11/11/96 bill ppc-ff-call, ff-call-slep, & ff-call declare the
;               foreign function call to be inline, just in case the
;               user proclaims them notinline.
; ------------- 4.0
; 10/07/96 bill #-ppc-target version of defpascal-callback-p
; 09/30/96 bill #-ppc-target version of ff-call doesn't use the compiler
; ------------  4.0b2
;  9/17/96 slh  supressed -> suppressed, but retain old names too
; 07/02/96 slh  don't require lap for ppc
; 06/22/96 bill %save-library has nicer stack overflow hysteresis.
;               Remove warning about set-periodic-task-interval;
;               it's neither documented nor referenced.
; 06/14/96 bill %new-gcable-ptr
; 06/20/96  gb  revive egc functions; *gc-event-status-bits* accessors.
; akh lfun-keyvect for interpreted frobs
; 06/04/96 bill fix apply
; ------------- MCL-PPC 3.9
; 04/08/96  gb  ensure %temp-cons and %apply-lexpr are fboundp.
; 03/26/96  gb  lowmem accessors.
; 03/20/96 bill quick and dirty applyv for Wood.
; 03/17/96 gb   %save-library returns (values error lib-version).
; 03/01/96 bill ff-call-slep
; 02/20/96 gb   %save-library
; 02/22/96 bill ff-call uses the compiler (invoking the ff-call compiler-macro).
; 02/15/96 bill %make-displaced-array checks its fill arg for in bounds.
;               Dummy versions of the EGC functions.
; 01/16/96 bill %pascal-functions% has :INITIAL-ELEMENT of NIL
; 01/03/96 gb   %make-displaced-array, element-subtype-type changes for PPC.
; 01/03/95 bill first pass ppc-ff-call definition (calls COMPILE).
; 12/21/95 bill PPC %lfun-vector now takes (and ignores) an optional second arg
; 12/13/95 gb   GC and FULL-GCCOUNT for PPC.
; 11/21/95 bill  make %set-toplevel do the right thing in a non-initial process.
; 11/21/95 bill in %make-displaced-array, (fixnum 0 *) -> (and fixnum (integer 0 *)) in
;               error case require-type (prevents an error in reporting the error).
; 11/21/95 bill fix brain-damage in PPC %make-displaced-array
; 11/16/95 bill dummy PPC versions of set-periodic-task-interval, periodic-task-interval,
;               gc, egc-mmu-support-available-p to get rid of %currenta5 references
; 11/17/95 slh   temp periodic-task stuff from Bill
; 11/16/95 slh   Gary's bitset fixes to %make-displaced-array
; 11/14/95 bill  Nuke the dummy PPC version of define-pascal-function.
; 11/15/95 gb    PPC make-displaced-array: ensure "offset" fixnump.
; 11/11/95 gb    gcable-macptr changes; allow use of %put-xx.
; 11/10/95 bill  temporary PPC version of define-pascal-function for use until callbacks work.
; 11/08/95 bill  #_getenvirons -> #_GetScriptManagerVariable
; 11/01/95 bill  re-enable gestalt for the PPC
; 10/26/95 slh   not-inline -> notinline
; 10/25/95 bill  ppc-target versions of %stack-trap & %register-trap call compile.
;                Need %stack-trap to compile "ccl:Library:new-file-dialogs.lisp"
; 08/01/95 gb    call $flush_code_cache vice clrcache in %make-lfun.
; 3/04/95 gb    %progvrestore didn't mean to say rplacd.
;  5/25/95 slh   add %stack-block, %gen-trap to traps pkg
;  5/22/95 slh   %str-to-handle: return handle from second clause
;                import %ptr-to-int to traps pkg
;  5/12/95 slh   added deftrap-inline to package frobs
;  4/18/95 slh   %str-from-ptr-in-script: use *default-base-character*, not extended-character
;                %cstr-segment-pointer: works for non-base strings (like pstr equivalent)
;  3/11/95 slh   gestalt takes optional bitnum arg
;  3/05/95 slh   gb's fix to %progvrestore
;  2/27/95 slh   string: better error for bad arg
;     ?    alice today error if string too long for pascal string
; 1/25/95 slh   comments indicate what to change for full defpascal longwords
;-------------  3.0d16
; 01/02/95 alice add char-word-break-p
; 07/15/93 bill  make-char-byte-table now returns its result.
;                char-byte-table entries are either 0 or 1, not #$smFirstByte
; 07/14/93 bill  pointer-char-length returns 3rd value: stopped-in-middle-of-2-byte-char-p
; -------------- 3.0d11
; 07/10/93 alice str-char-length => pointer-char-length
; 07/09/93 alice added pointer-to-string-in-script, some svref => aref
; 07/02/93 alice messing about with scripts and string comparisons
; 06/17/93 alice make-string heeds element type of initial element, string dtrt for chars
; 06/16/93 alice %str-to-handle does fat strings
; 06/14/93 alice added byte-length and str-char-length and %str-from-ptr-in-script
;		 char-byte-table stuff comes here from l1-edbuf
; 05/29/93 alice string-lessp return pos if true
; 05/26/93 alice string-lessp do fat strings; char-upcase and downcase don't die if fat
;----------------3.0d10
; 05/06/93 bill GC tries until it succeeds: *pre-gc-hook* can cause a delay.
;               full-gccount moves here from edit-callers.lisp
; -------------- 3.0d8
; 05/24/93 alice string, string= and string-equal and %pstr-pointer, %cstr-pointer, %pstr-segment-pointer
; 05/23/93 alice move-string-bytes moved here for %str-cat
; 05/22/93 alice %str-cat, %substr %str-member handle fat strings.
; 05/22/93 alice moved extended-character-p and base-character-p here from chars
; 05/08/93 alice added base-string-p and simple-base-string-p, and extended ditto
; 05/03/93 alice make-string knows about extended-character, make him know more someday.
;		 defaults to base-character which is not common lisp.
;		 and character means base-character - also not CL
; 		 stringp knows about extended-character strings
; ------------- 2.1d6
; 03/31/93 bill typo in equal-2 made it ignore lengths of bit-vectors.
;               In the process, speed up EQUAL on bit-vectors by a factor of 80.
; ------------ 2.1d5
; ??	   alice char-upcase, downcase and string-equal are smaller
; ------------ 2.1d4
; 03/11/93 bill %register-trap now clears the cache.
; 02/17/93 bill $sp-spreadX -> $sp-spreadX-vextend where appropriate.
; 12/16/92 bill GB's fixes to nreverse & bit-vector-p
; 12/02/92 bill %make-lfun no longer leaves an uninitialized byte at the beginning
;               of the immediates map.
; 11/25/92 bill gc-cursor-supressed-p & set-gc-cursor-supressed-p replace
;               using-gc-cursor-p & use-gc-cursor-p
; 10/09/92 bill set-fill-pointer calls tsignal_error with (fixnum $XNOFILLPTR)
;               instead of ($ $XNOFILLPTR)
; 07/06/92 bill GB's fix to EQUAL-2 makes EQUAL work for non-simple strings
;               and bit-vectors.
; 05/25/92 bill %stack-trap now handles up to 12 args. Used to do only 6.
;               Will also error if it gets a bignum for the type bits arg.
;------------- 2.0
;Miscellaneous lap stuff moved out of the kernel.
;01/03/92 gb   add EGC-CONFIGURATION.
;01/02/92 gb   require non-zero e0size in configure-egc.
;12/10/91 gb   fix %map-lfuns; add %non-empty-environment-p.  Change
;              function-lambda-expression.
;12/06/91 alice char-upcase, char-downcase, alpha-char-p deal with accented chars
;----------- 2.0b4
;11/20/91 bill debug ff-call & %gen-trap
;11/04/91 gb   map-lfuns doesn't walk what gets consed after it starts.
;10/14/91 bill (array-element-type (make-array 5 :element-type 'double-float))
;              is now DOUBLE-FLOAT, not FLOAT.
;10/11/91 bill %make-initialized-uvector for use by %cons-nhash-vector
;----------- 2.0b3
;09/05/91 bill gestalt moves here from sysutils
;08/30/91 gb   add configure-egc
;08/24/91 gb   use new trap syntax.
;08/07/91 bill bootstrapping #'(setf documentation)
;07/21/91 gb   flush page-type; add %gen-trap, ff-call, %temp-list, upgraded-complex-part-type.
;              wtaerr fixes.  Fixup &lap arglists.  No more *save-link-maps*.
;07/02/91 bill in %make-lfun - $lfatr-aplink-bit & $lfatr-aplink1-bit are no more
;----------- 2.0b2
;05/31/91 bill import some more stuff into the traps package
;05/29/91 gb   update egc*.  New cons-area equates.
;05/28/91 bill structurep moved here from sysutils.
;05/22/91 alice %str-member gets optional start, end
;05/20/91 gb   Allow 16-bit data register returns (:oserr) in %register-trap.
;              USE-, USING-GC-CURSOR-P.  Eval-redef some more.
;05/13/91 bill string-lessp comes here from lib;chars for bootstrapping l1-windows.
;04/04/91 bill %cstr-segment-pointer, equal works for logical-pathname's
;03/11/91 bill %%StringTwoArgs clobberred array arg for error message :end2 out of bounds.
;03/05/91 alice report-bad-arg gets 2nd arg
;03/04/91 bill add max-length arg to %str-to-handle
;02/18/91 gb   schar, set-schar, uvsize, svref. svset now eval-redef'ed in level-2.
;----------- 2.0b1
;01/24/91 bill GB's patch to %make-lfun to detect >32K-word lfun vectors.
;01/23/91 bill add optional new-value arg to lfun-attributes
;01/09/90 bill change format of *def-accessor-types*
;01/08/91 bill Move (defpackage traps ...) & *traps-package* here from lib;deftrap
;12/31/90 gb   change %lfun-vector-lfun.
;12/31/90 bill Add without-interrupts arg to define-pascal-function & defpascal-new-slot
;12/19/90 gb   define-pascal-function sets $lfatr-resident-bit.
;11/09/90 bill GB's fix to set-symbol-plist
;10/25/90 gz   unsigned long vectors.
;10/16/90 gb   call %%deref-sym-char-or-string here and there.
;10/05/90 bill (signal_error ($ ...) ...) -> (signal_error (fixnum ...) ...)
;09/21/90 bill add-accessor-types
;09/17/90 bill gc-event-check-enabled -> set-gc-event-check-enabled-p
;09/06/90 bill nilreg-offset
;08/27/90 gb  fix %map-lfuns again.
;08/23/90 gb  bill's fix to set-symbol-plist.
;08/10/90 gb   new package & plist accessors.  Fix symbol alignment assumptions
;              in %nth-immediate, %make-lfun.  Eschew use of $symbol-header.
;             %uvref/%uvset eval-redef'ed elsewhere.
;07/18/90 alice do two arg LAST per Steele 2
;07/04/90 bill new CLOS function type bits in lfun-keyvect
;06/27/90 bill make lfun-keyvect use %nth-immediate for new method format.
;06/22/90 bill %vector-member.
;06/21/90 bill lfun-keyvect returns NIL if the $lfbits-gfn-bit is set
;              (generic-function or combined-method).
;06/10/90 gb  gc-event-check-enabled-p & gc-enable-event-check.
;06/02/90 gb  %stack-trap handles :d0 selectors.
;06/01/90 bill macptr-flags, set-macptr-flags
;05/30/90 gb  Trap functions handle 32-bit values.
;05/29/90 gb %vect-subtype & %vect-byte-size defined as functions here.
;05/22/90 gb  No more symtagp.
;05/14/90 gb  Move %%derefstring & %%deref-sym-or-string to l1-symhash.
;04/14/90 gz  Made %substr take start/end args instead of start/length.
;03/24/90 gz  Added upgraded-array-element-type.
;04/30/90 gb  lap syntax; make-string accepts & ignores :element-type arg.
;             make temp uvectors.  array subtype -> typespec accessor.
;04/25/90 gb  they didn't end up as short branches in nreverse.
;04/11/90 bill %pstr-segment-pointer for updated with-pstr
;02/14/90 gz  Added %str-to-handle.
;01/17/90 gz  Pass through attrib bits in %make-lfun. Added lfun-attributes.
;             Check $lfatr-noname-bit in %lfun-vector-lfun-name-offset.
;01/03/89 gz  uvectorp.  type-predicate for 'lfun-vector so typep/require-type works.
;             %lfun-vector-lfun - note that this searches a5 space for swappable lfuns,
;             so use with care.
;01/05/89 bill defpascal-new-slot - Don't trust A5.
;12/27/89 gz  setf package to support setf function specs.
;12/21/89 gz  tweak in define-pascal-function for better dumping.
;12/05/89 gb new lap for old.
;12/04/89 gz  gvectorp.  Use %noforcestk in simple predicates.
;11/16/89 gb applyv.
;10/19/89 bill Added %lfun-vector-p
;9/30/89  gz moved %lfun-vector to l1-utils.
;9/28/89  gb unsigned short, byte vectors. 
;09/27/89 gb simple-string -> ensure-simple-string.
;09/21/89 bill in copy-uvector: (move.b (atemp1 $v_subtype) arg_y)
;              changed to:      (move.b (atemp0 $v_subtype) arg_y)
;9/14/89  gz $lfatr-slfunv-bit means there is an extra longword at end of lfun.
;            %lfun-vector requires an lfun arg.
;09/03/89 gz moved package accessors to l1-symhash.
;            Don't assume %nilreg-{f,v}cell-symbols% covers entire nilreg space.
;08/21/89 gz %cstr-pointer
;08/06/89 gz %lfun-vector-lfun-name-offset.
;05/31/89 gz added nilreg-cell-symbols
;05/07/89 gb    allocvect,reservevect calls pass subtype in arg_y.
;05/01/89 gb %stack-, %register- trap.
;05/01/89 gz lfun link maps.
;04/19/89 gz Added array-element-subtype, make-uvector,
;            function-lambda-expression, coerce-to-compiled-function.
;04/07/89 gb  $sp8 -> $sp.
;3/25/89  gz %toplevel-function%. Number fns to l1-numbers.
;            Added %immediate-offset. new defpascal stuff.
;03/09/89 gz ash, byte, floor etc. logxxx etc. fns.  lfun-keyvect. %map-lfuns.
;            Symbolic names for lfunish things.  %make-compiled-function takes
;            displaced arrays, allows bignum bits (for some day).
;03/03/89 gz min, max. %str-cat takes any number of args.
;03/02/89 gb Added %set-toplevel. Use consZnil here and there, add GC.
;02/23/89 gz Added %uvref, %uvset, %uvsize, array-dimension, array-dimensions,
;            array-total-size, vector-pop, elt, set-elt, aref, aset, %make-uvector
;            %make-compiled-function
;02/12/89 gz real-arg -> $sp-real1chk.
;01/03/89 gz %lfun-vector and %nth-immediate from compiler.
;01/01/89 gb a5, heap, lfuns.
;12/26/88 gz subtype in array headers. long and float arrays.
;            Do typechecks inline in schar, svref.
;12/7/88  gz pathnames are istructs now, in equal-2.
;12/06/88 gz made EQUAL descend macptrs.
;11/23/88 gb restore_regs mumbo-jumbo. lfun-bits -> l1-utils.
;11/16/88 gb signal error for arg_z in %%derefstring.
;11/12/88 gb removed ptr-accessors.
;10/27/88 gb added equal, copy-tree, set-event-ticks, event-ticks, char-upcase,
;            char-downcase.  Progv saves symbols, not locatives. $sp-xcxr ->$sp-ncxr.
;            Some string functions moved here. $sp-seqarg -> $sp-seqarg-atemp0.
;10/23/88 upload 8.9.
;9/4/88   gb no cfp.
; 8/27/88 gb %set-symbol-plist -> set-symbol-plist
;9/2/88  gz added nreverse, reverse, nreconc, append, copy-uvector,
;           %pstr-pointer, %str-from-ptr, %substr, %str-cat, make-string,
;           array-element-type, array-rank, arrayp, vectorp, simple-vector-p,
;           simple-string-p, stringp, bit-vector-p, displaced-array-p,
;           adjustable-array-p,array-has-fill-pointer-p,fill-pointer,
;           set-fill-pointer, %make-displaced-array, +,-,*,/,<,<=,>,>=,
;           integerp, numberp, oddp, evenp, integer-length, logbitp.
;           %SUBSTR now accepts non-simple strings.
;8/25/88 gz added %str-length, %str-member, last, nconc, nthcdr, nth, cons,
;	    page-type, %i*, svref, svset, schar, set-schar.
;8/19/88 gz added =.
;8/10/88 gz added %symbol-locative-symbol, package accessors, zerop, plusp, minusp
; 8/13/88  gb  bindings stuff.

(in-package :ccl)





(defun %badarg (arg type)
  (%err-disp $XWRONGTYPE arg type))

(defun atom (arg)
  (not (consp arg)))

(defun list (&rest args) args)

#+ppc-target (%fhave '%temp-list #'list)

(defun list* (arg &rest others)
  "Returns a list of the arguments with last cons a dotted pair"
  (cond ((null others) arg)
	((null (cdr others)) (cons arg (car others)))
	(t (do ((x others (cdr x)))
	       ((null (cddr x)) (rplacd x (cadr x))))
	   (cons arg others))))

(defun funcall (fn &rest args)
  (declare (dynamic-extent args))
  (apply fn args))


(defun apply (function arg &rest args)
  "Applies FUNCTION to a list of arguments produced by evaluating ARGS in
  the manner of LIST*.  That is, a list is made of the values of all but the
  last argument, appended to the value of the last argument, which must be a
  list."
  (declare (dynamic-extent args))
  (cond ((null args)
	 (apply function arg))
	((null (cdr args))
	 (apply function arg (car args)))
	(t (do* ((a1 args a2)
		 (a2 (cdr args) (cdr a2)))
		((atom (cdr a2))
		 (rplacd a1 (car a2))
		 (apply function arg args))))))



; This is not fast, but it gets the functionality that
; Wood and possibly other code depend on.
#+ppc-target
(defun applyv (function arg &rest other-args)
  (declare (dynamic-extent other-args))
  (let* ((other-args (cons arg other-args))
         (last-arg (car (last other-args)))
         (last-arg-length (length last-arg))
         (butlast-args (nbutlast other-args))
         (rest-args (make-list last-arg-length))
         (rest-args-tail rest-args))
    (declare (dynamic-extent other-args rest-args))
    (dotimes (i last-arg-length)
      (setf (car rest-args-tail) (aref last-arg i))
      (pop rest-args-tail))
    (apply function (nconc butlast-args rest-args))))

; This is slow, and since %apply-lexpr isn't documented either,
; nothing in the world should depend on it.  This is just being
; anal retentive.  VERY anal retentive.
#+ppc-clos
(defun %apply-lexpr (function arg &rest args)
  (cond ((null args) (%apply-lexpr function arg))
        (t (apply function arg (nconc (nbutlast args)
                                      (collect-lexpr-args (car (last args)) 0))))))


#+ppc-target
(defun values-list (arg)
  (apply #'values arg))




#+ppc-target
(defun make-list (size &key initial-element)
  (unless (and (typep size 'fixnum)
               (>= (the fixnum size) 0))
    (report-bad-arg size '(and fixnum unsigned-byte)))
  (locally (declare (fixnum size))
    (do* ((result '() (cons initial-element result)))
        ((zerop size) result)
      (decf size))))



; copy-list

(defun copy-list (list)
  (if list
    (let ((result (cons (car list) '()) ))
      (do ((x (cdr list) (cdr x))
           (splice result
                   (%cdr (%rplacd splice (cons (%car x) '() ))) ))
          ((atom x) (unless (null x)
                      (%rplacd splice x)) result)))))


; take two args this week
#+ppc-target
(defun last (list &optional (n 1))
  (unless (and (typep n 'fixnum)
               (>= (the fixnum n) 0))
    (report-bad-arg n '(and fixnum unsigned-byte)))
  (locally (declare (fixnum n))
    (do* ((checked-list list (cdr checked-list))
          (returned-list list)
          (index 0 (1+ index)))
         ((atom checked-list) returned-list)
      (declare (type index index))
      (if (>= index n)
	  (pop returned-list)))))




#+ppc-target    
(defun nthcdr (index list)
  (unless (and (typep index 'fixnum)
               (>= (the fixnum index) 0))
    (report-bad-arg index '(and fixnum unsigned-byte)))
  (locally (declare (fixnum index))
    (do* ()
         ((< (decf index) 0))
      (when (null (setq list (cdr list))) (return)))
    list))


(defun nth (index list) (car (nthcdr index list)))

#+ppc-target
(defun nconc (&rest lists)
  (declare (dynamic-extent lists))
  "Concatenates the lists given as arguments (by changing them)"
  (do* ((top lists (cdr top)))
       ((null top) nil)
    (let* ((top-of-top (car top)))
      (cond
       ((consp top-of-top)
        (let* ((result top-of-top)
               (splice result))
          (do* ((elements (cdr top) (cdr elements)))
	         ((endp elements))
            (let ((ele (car elements)))
              (typecase ele
                (cons (rplacd (last splice) ele)
                      (setf splice ele))
                (null (rplacd (last splice) nil))
                (atom (if (cdr elements)
                        (report-bad-arg ele 'list)
                        (rplacd (last splice) ele)))
                (t (report-bad-arg ele 'list)))))
          (return result)))
       ((null top-of-top) nil)
       (t
        (if (cdr top)
          (report-bad-arg top-of-top 'list)
          (return top-of-top)))))))




#+ppc-target
(defvar %setf-function-names% (make-hash-table :weak t :test 'eq))
#+ppc-target
(defun setf-function-name (sym)
   (or (gethash sym %setf-function-names%)
       (setf (gethash sym %setf-function-names%) (construct-setf-function-name sym))))


(defun string (thing)
  (if (stringp thing)
    thing
    (if (symbolp thing)
      (symbol-name thing)
      (if (characterp thing)
        (make-string 1 
                     :element-type (if (typep thing 'base-character) 'base-character 'character)
                     :initial-element thing)
        (report-bad-arg thing '(or string symbol character))))))
                     

(defconstant *setf-package* (or (find-package "SETF") (make-package "SETF" :use nil :external-size 1)))

(defun construct-setf-function-name (sym)
  (let ((pkg (symbol-package sym)))
    (setq sym (symbol-name sym))
    (if (null pkg)
      (gentemp sym *setf-package*)
      (values
       (intern
        ;I wonder, if we didn't check, would anybody report it as a bug?
        (if (not (%str-member #\: (setq pkg (package-name pkg))))
          (%str-cat pkg "::" sym)
          (%str-cat (prin1-to-string pkg) "::" (princ-to-string sym)))
        *setf-package*)))))

(defun valid-function-name-p (name)
  (if (symbolp name)                    ; Nil is a valid function name.  I guess.
    (values t name)
    (if (and (consp name)
             (consp (%cdr name))
             (null (%cddr name))
             (symbolp (%cadr name)))
      (values t (setf-function-name (%cadr name)))
      ; What other kinds of function names do we care to support ?
      (values nil nil))))

; Why isn't this somewhere else ?
(defun ensure-valid-function-name (name)
  (multiple-value-bind (valid-p nm) (valid-function-name-p name)
    (if valid-p nm (error "Invalid function name ~s." name))))

(defvar *string-compare-script* nil)
;these should not be saved with application! OK
(defvar *script-char-byte-tables* nil)
(defvar *system-script* nil)

(defun default-script (script)
  (if (or (null script) (eql script #$smSystemscript))
    (or *system-script* (setq *system-script* (#_GetScriptManagerVariable  #$smSysScript)))
    script))


(defvar *script-list* nil)

(defvar *input-file-script* nil)  ;  setting this to a 1 byte script - doesnt hurt, does nothing?



; is it an extended string that really needs to be extended?
(defun real-xstring-p (str)
  (multiple-value-bind (realstr strb)(array-data-and-offset str)
    (declare (fixnum strb))
    (if (extended-string-p realstr)
      (dotimes (i (the fixnum (length str)) nil)
        (when (> (%scharcode realstr (+ i strb)) #xff)(return t))))))

; cant make-array yet
; Of course, compiler-macros will eliminate the call to MAKE-ARRAY.
(defun make-char-byte-table (script)
  (let* ((font (#_getscriptvariable script #$smScriptAppFond))
        (result (make-array 256 :element-type '(signed-byte 8))))
    ; boy is this stupid - is it right
    (with-font font
      (rlet ((table (:array :character 256 :packed)))  ; was ((table :charbytetable)) - s.b. equiv?
        (#_Fillparsetable table script)
        (dotimes (i 256)
          (setf (aref result i) (%get-signed-byte table i)))))
    result))

(defun get-char-byte-table (&optional script)
  ; returns nil if 8 bit script
  (setq script (default-script script))
  (when (not (eql script #$smRoman))
    (unless (%ilogbitp #$smsfSingByte (#_getscriptvariable script #$smscriptflags))
      (when (null *script-char-byte-tables*)
        (setq *script-char-byte-tables* (make-array 34 :element-type t :initial-element nil)))  ; ?? ad hoc 34
      (if (< script 34)
        (or (%svref *script-char-byte-tables* script)
            (let ((res (make-char-byte-table script)))
              (setf (svref *script-char-byte-tables* script) res)
              res))))))



(defun make-unicode-char-sort-table ()  
  (let* ((result (make-array 256 :element-type '(unsigned-byte 8)))
         (clist (make-list 256)))
    (declare (dynamic-extent clist))
    (do* ((l clist (cdr l))
          (i 0 (1+ i)))
         ((= i 256))
      (rplaca l i))    
    (setq clist
          (%sort-list-no-key
           clist
           #'(lambda (a b)
               (let ((v (char-code-compare-hairy a b nil)))
                 (if (= v 1) nil t)))))
    (do* ((l clist (cdr l))
          (i 0 (1+ i)))
         ((= i 256))
      (setf (aref result (car l)) i))
    result))


(defun make-unicode-char-equal-sort-table ()  
  (let* ((result (make-array 256 :element-type '(unsigned-byte 8)))
         (stable (or unicode-char-sort-table (make-unicode-char-sort-table)))
         (down-vect char-downcase-vector))
    (dotimes (i 256)
      (let ((it (elt down-vect i)))
        (setf (aref result i)(aref stable it))))
    result))




; Returns index if char appears in string, else nil.

#+ppc-target
(defun %str-member (char string &optional start end)
  (if (not (typep string 'simple-string)) (setq string (require-type string 'simple-string)))
  (let* ((base-string-p (typep string 'simple-base-string)))    
    (unless (characterp char)
      (setq char (require-type char 'character)))
    (if base-string-p
      (do* ((i (or start 0) (1+ i))
            (n (or end (uvsize string))))
           ((= i n))
        (declare (fixnum i n) (optimize (speed 3) (safety 0)))
        (if (eq (schar (the simple-base-string string) i) char)
          (return i)))
      (do* ((i (or start 0) (1+ i))
            (n (or end (uvsize string))))
           ((= i n))
        (declare (fixnum i n) (optimize (speed 3) (safety 0)))
        (if (eq (schar (the simple-extended-string string) i) char)
          (return i))))))

(defun %str-eol-member (string &optional start end)
  (if (encoded-stringp string)(setq string (the-string string)))
  (if (not (typep string 'simple-string)) (setq string (require-type string 'simple-string)))
  (let* ((base-string-p (typep string 'simple-base-string)))       
    (if base-string-p
      (do* ((i (or start 0) (1+ i))
            (n (or end (uvsize string))))
           ((= i n))
        (declare (fixnum i n) (optimize (speed 3) (safety 0)))
        (if (char-eolp (schar (the simple-base-string string) i))
          (return i)))
      (do* ((i (or start 0) (1+ i))
            (n (or end (uvsize string))))
           ((= i n))
        (declare (fixnum i n) (optimize (speed 3) (safety 0)))
        (if (char-eolp (schar (the simple-extended-string string) i))
          (return i))))))      


; Returns index of elt in vector, or nil if it's not there.
#+ppc-target
(defun %vector-member (elt vector)
  (unless (typep vector 'simple-vector)
    (report-bad-arg vector 'simple-vector))
  (dotimes (i (the fixnum (length vector)))
    (when (eq elt (%svref vector i)) (return i))))


#+ppc-target
(progn
; It's back ...
(defun list-nreverse (list)
  (nreconc list nil))

; We probably want to make this smarter so that less boxing
; (and bignum/double-float consing!) takes place.

(defun vector-nreverse (v)
  (let* ((len (length v))
         (middle (ash (the fixnum len) -1)))
    (declare (fixnum middle len))
    (do* ((left 0 (1+ left))
          (right (1- len) (1- right)))
         ((= left middle) v)
      (declare (fixnum left right))
      (rotatef (aref v left) (aref v right)))))
    
(defun nreverse (seq)
  (seq-dispatch seq
   (list-nreverse seq)
   (vector-nreverse seq)))
)


#+ppc-target
(defun nreconc (x y)
  "Returns (nconc (nreverse x) y)"
  (do ((1st (cdr x) (if (atom 1st) 1st (cdr 1st)))
       (2nd x 1st)		;2nd follows first down the list.
       (3rd y 2nd))		;3rd follows 2nd down the list.
      ((atom 2nd) 3rd)
    (rplacd 2nd 3rd)))



#+ppc-target
(defun append (&lexpr lists)
  (let* ((n (%lexpr-count lists)))
    (declare (fixnum n))
    (if (> n 0)
      (if (= n 1)
        (%lexpr-ref lists n 0)
        (do* ((res (%lexpr-ref lists n 0) (append-2 res (%lexpr-ref lists n j)))
              (j 1 (1+ j)))
             ((= j n) res)
          (declare (fixnum j)))))))


#+ppc-target
(progn
(defun list-reverse (l)
  (do* ((new ()))
       ((null l) new)
    (push (pop l) new)))

; Again, it's worth putting more work into this when the dust settles.
(defun vector-reverse (v)
  (let* ((len (length v))
         (new (make-array (the fixnum len) :element-type (array-element-type v))))   ; a LOT more work ...
    (declare (fixnum len))
    (do* ((left 0 (1+ left))
          (right (1- len) (1- right)))
         ((= left len) new)
      (declare (fixnum left right))
      (setf (uvref new left)
            (aref v right)))))

(defun reverse (seq)
  (seq-dispatch seq (list-reverse seq) (vector-reverse seq)))
)

; The length in bytes of the packed equivalent of a fat string.
; this guy does not count fat chars that make no sense in script. actually does now
; And  %pstr-pointer will truncate fat chars that make no sense in script.
(defun byte-length (string &optional script start end)
  (declare (ignore script))
  (when (or start end)(chkbounds string start end))
  (if (not start) (setq start 0))
  (if (not end)(setq end (length string)))
  (let ((len (- end start)))
    (cond 
     ((base-string-p string)
      len)
     (t 
        (let () ;(table (get-char-byte-table script))) ; just is script fat??
          (cond 
           (nil (not table) len)
           (t (multiple-value-bind (str offset)(array-data-and-offset string)                
                (let* ((start (%i+ offset start))
                       (end (%i+ offset end))
                       (j 0))
                  (until (eq start end)
                    (let ((c (%scharcode str start)))
                      (if (and (%i> c #xff)) #|(eq (aref table (%ilsr 8 c)) 1))|#
                        (setq j (%i+ j 2))
                        (setq j (%i+ j 1))))
                    (setq start (%i+ start 1)))
                  j)))))))))

; the length in characters of a packed pstr
; second value is true if there are some fat chars in pointer
(defun pstr-char-length (pointer &optional script)
  (with-macptrs ((p pointer))
    (pointer-char-length (%incf-ptr p)(%get-byte p -1) script)))
  
; second value is true if actually contains fat chars
(defun pointer-char-length (pointer len &optional script)
  (let ((table (get-char-byte-table script)))
    (cond ((not table) len)
          (t (let ((i 0)
                   (j 0))
               (until (%i>= i len)
                 (let ((c (%get-byte pointer i)))
                   (if (eql 1 (aref table c))
                     (setq i (%i+ i 2))
                     (setq i (%i+ i 1)))
                   (setq j (%i+ j 1))))
               (values j (%i> i j) (%i> i len)))))))

; from string to pointer - used by with-pstrs 
; only transmits fat chars as such if they make sense in script
; ignores the possibility of a base-string containing bytes that are
; start of 2 byte chars in script.
#+ppc-target  
(defun %pstr-pointer (string pointer &optional script)  
  (if (> (length string) 255) (error "String ~s too long for pascal string." string))
  (if (base-string-p string)
    (multiple-value-bind (s o n) (dereference-base-string string)
      (declare (fixnum o n))
      (let* ((limit (min n 255)))
        (declare (fixnum limit))
        (setf (%get-byte pointer 0) limit) ; set length byte
        (do* ((o o (1+ o))
              (i 0 (1+ i))
              (j 1 (1+ j)))
             ((= i limit))
          (declare (fixnum o i j))
          (setf (%get-byte pointer j) (%scharcode s o)))))
    (%put-string pointer string 0 255 script))
  nil)



(defun %pstr-segment-pointer (string pointer start end &optional script)  
  (new-with-pointers ((p pointer 1))
    (setf (%get-byte p -1) (%put-string-segment-contents p string start end 255 script)))
  nil)

#+ppc-target   
(defun %cstr-pointer (string pointer &optional script)
  (if (base-string-p string)
    (multiple-value-bind (s o n) (dereference-base-string string)
      (declare (fixnum o n))
      (do* ((o o (1+ o))
            (i 0 (1+ i)))
           ((= i n) (setf (%get-byte pointer i) 0))
        (declare (fixnum o i))
        (setf (%get-byte pointer i) (%scharcode s o))))
    (%put-cstring pointer string 0 nil script))
  nil)



; used by with-cstr (used by help-manager.lisp)
(defun %cstr-segment-pointer (string pointer start end) 
  (setf (%get-byte pointer (%put-string-segment-contents pointer string start end)) 0)
  nil)

(defun %str-from-ptr-in-script (pointer len &optional script)
  (setq script (default-script script))
  (let ((table (get-char-byte-table script)))
    (if (not table)
      (%str-from-ptr pointer len)
      (multiple-value-bind (chars fatp) (pointer-char-length pointer len script)
        (cond
         ((not fatp) (%str-from-ptr pointer len))
         (t 
          (let ((new-string (make-string chars :element-type 'extended-character)))
            (pointer-to-string-in-script pointer new-string len script)
            new-string)))))))


(defun pointer-to-string-in-script (pointer string len script &optional start)
  (let* ((table (get-char-byte-table script))
         (i 0)
         (j (or start 0)))
    (until (%i>= i len)
      (let ((c (%get-byte pointer i)))
        (cond ((and table (eql 1 (aref table c)))
               (setq c (%ilogior (%ilsl 8 c)(%get-byte pointer (%i+ 1 i))))
               (setq i (%i+ i 2)))
              (t (setq i (%i+ i 1))))
        (setf (%scharcode string j) c)
        (setq j (%i+ j 1))))
    string))

(defun %str-from-ptr (pointer len)
  (%copy-ptr-to-ivector pointer 0 (make-string len :element-type 'base-character) 0 len))

; 2 callers - 2 static text dialog item things - which don't really need it 
;#+ignore  ;; used no more - is used in some examples
(defun %str-to-handle (str &optional hdl (max-length 32000))   ; truncates to max-length chars.  
  (let ((hlen (byte-length str)))
    (when (and max-length (> hlen max-length))(setq hlen max-length))
    (cond (hdl (#_SetHandleSize hdl hlen))
          (t (setq hdl (#_NewHandle :errchk hlen))))
    (with-dereferenced-handle (pointer hdl)
      (%put-string-contents pointer str hlen))
    hdl))


(defun extended-string-p (thing)
  (and (stringp thing)(not (base-string-p thing))))

(defun simple-extended-string-p (thing)
  (and (simple-string-p thing)(not (base-string-p thing))))

(setf (type-predicate 'extended-string) 'extended-string-p)

(setf (type-predicate 'simple-extended-string) 'simple-extended-string-p)

;; replace wrong def in level-0;l0-array.lisp - dunno how to build ppc-boot today
(defun make-string (size &key (initial-element () initial-element-p) (element-type 'character))
  (if (or (eq element-type 'base-character)
          (eq element-type 'base-char)
          (eq element-type 'standard-char)) 
    (if initial-element-p
      (make-string size :element-type 'base-character :initial-element initial-element)
      (make-string size :element-type 'base-character))
    (if (or (memq  element-type '(character extended-character extended-char))
            (subtypep element-type 'character))
      (if initial-element-p
        (make-string size :element-type 'extended-character :initial-element initial-element)
        (make-string size :element-type 'extended-character))
      (error "Unknown string element-type ~A" element-type))))

; allowable combos are source 8 dest 16, or matching
#+ppc-target
(defun move-string-bytes (source dest off1 off2 n)
  (declare (optimize (speed 3)(safety 0)))
  (declare (fixnum off1 off2 n))
  (let* ((base-source (typep source 'simple-base-string))
         (base-dest (typep dest 'simple-base-string)))
    (if (and base-dest base-source)
      (%copy-ivector-to-ivector source off1 dest off2 n)
      (if (and base-source (not base-dest))
        (%copy-8-ivector-to-16-ivector source off1 dest off2 n)
        (if (or base-dest base-source)
          (do* ((i 0 (1+ i))
                (j off1 (1+ j))
                (k off2 (1+ k)))
               ((= i n))
            (declare (fixnum i j k))
            (setf (%scharcode dest k) (%scharcode source j)))
          (%copy-ivector-to-ivector source 
                                    (the fixnum (+ off1 off1))
                                    dest
                                    (the fixnum (+ off2 off2))
                                    (the fixnum (+ n n))))))))


(defun %str-cat (s1 s2 &rest more)
  (declare (dynamic-extent more))
  (require-type s1 'string)
  (require-type s2 'string)
  (let* ((s1-org 0)
         (s2-org 0)
         (len1 (length s1))
         (len2 (length s2))
         (len (%i+ len2 len1))
         (base-p 'base-character))
    (declare (optimize (speed 3)(safety 0)))
    (when (not (typep s1 'simple-string))
      (multiple-value-setq (s1 s1-org) (array-data-and-offset s1)))
    (when (not (typep s2 'simple-string))
      (multiple-value-setq (s2 s2-org) (array-data-and-offset s2)))    
    (if (or (simple-extended-string-p s1)(simple-extended-string-p s2))
      (setq base-p nil))
    (dolist (s more)      
      (require-type s 'string)
      (when base-p (if (extended-string-p s)(setq base-p nil)))
      (setq len (+ len (length s))))
    (let ((new-string (make-string len :element-type (or base-p 'extended-character))))
      (move-string-bytes s1 new-string s1-org 0 len1)
      (move-string-bytes s2 new-string s2-org len1 len2)
      (dolist (s more)
        (setq len2 (%i+ len1 len2))
        (setq len1 (length s))
        (let ((s-org 0))
          (when (not (typep s 'simple-string))
            (multiple-value-setq (s s-org)(array-data-and-offset s)))
          (move-string-bytes s new-string s-org len2 len1)))
      new-string)))


(defun %substr (str start end)
  (require-type start 'fixnum)
  (require-type end 'fixnum)
  (require-type str 'string)
  (let ((len (length str)))
    (multiple-value-bind (str strb)(array-data-and-offset str)
      (let ((newlen (%i- end start)))
        (when (%i> end len)(error "End ~S exceeds length ~S." end len))
        (when (%i< start 0)(error "Negative start"))
        (let ((new (make-string newlen :element-type (array-element-type str))))
          (move-string-bytes str new (%i+ start strb) 0 newlen)
          new)))))

#+ppc-target
; dont really know what the subtype is here - assume type-code??
; does simple-p mean simple-vector or simple-array? - assume simple-array
; does subtype nil mean don't care or simple-vector?
(defun coerce-to-uvector (object subtype simple-p)  ; simple-p ?  
  (let ((type-code (ppc-typecode object)))
    ;(print (list type-code object))
    (cond ((eq type-code ppc::tag-list)
           (return-from coerce-to-uvector (%list-to-uvector subtype object)))
          ((>= type-code ppc::min-cl-ivector-subtag)  ; 175
           (if (or (null subtype)(= subtype type-code))
             (return-from coerce-to-uvector object)))
          ((>= type-code ppc::min-vector-subtag)     ; 170
           (if (= type-code ppc::subtag-simple-vector)
             (if (or (null subtype)
                     (= type-code subtype))
               (return-from coerce-to-uvector object))
             (if (and (null simple-p)
                      (or (null subtype)
                          (= subtype (ppc-typecode (array-data-and-offset object)))))
               (return-from coerce-to-uvector object))))
          (t (error "Can't coerce ~s to Uvector" object))) ; or just let length error
    (if (null subtype)(setq subtype ppc::subtag-simple-vector))
    (let* ((size (length object))
           (val (%alloc-misc size subtype)))
      (declare (fixnum size))
      (multiple-value-bind (vect offset) (array-data-and-offset object)
        (declare (fixnum offset))
        (dotimes (i size val)
          (declare (fixnum i)) 
          (uvset val i (uvref vect (%i+ offset i))))))))


; 3 callers
(defun %list-to-uvector (subtype list)   ; subtype may be nil (meaning $v_genv) - better not be
  (let* ((n (length list))
         (new #-ppc-target (%make-uvector n subtype)
              #+ppc-target (%alloc-misc n (or subtype ppc::subtag-simple-vector))))  ; yech
    (dotimes (i n)
      (declare (fixnum i))
      (uvset new i (%car list))
      (setq list (%cdr list)))
    new))


; appears to be unused
(defun upgraded-array-element-type (type &optional env)
  (declare (ignore env))
  (element-subtype-type (element-type-subtype type)))

(defun upgraded-complex-part-type (type &optional env)
  (declare (ignore type env))               ; Ok, ok.  So (upgraded-complex-part-type 'bogus) is 'REAL. So ?
  'real)



#+PPC-target
(progn
  ; we are making assumptions - put in ppc-arch? - almost same as *ppc-immheader-array-types
  (defparameter ppc-array-element-subtypes
    #(single-float 
      (unsigned-byte 32)
      (signed-byte 32)
      (unsigned-byte 8)
      (signed-byte 8)
      base-character
      extended-character
      (unsigned-byte 16)
      (signed-byte 16)
      double-float
      bit))
  
  ; given uvector subtype - what is the corresponding element-type
  (defun element-subtype-type (subtype)
    (declare (fixnum subtype))
    (if  (= subtype ppc::subtag-simple-vector) t
        (svref ppc-array-element-subtypes 
               (ash (- subtype ppc::min-cl-ivector-subtag) (- ppc::ntagbits)))))
  )


#+ppc-target
(defun %make-temp-uvector (len &optional subtype)
  ; that will be wrong too 
  (%alloc-misc len (or subtype ppc::subtag-simple-vector)))



;Used by transforms.
(defun make-uvector (length subtype &key (initial-element () initp))
  (if initp
    #-ppc-target (%make-uvector length subtype initial-element)
    #+ppc-target (%alloc-misc length subtype initial-element)
    #-ppc-target (%make-uvector length subtype)
    #+ppc-target (%alloc-misc length subtype)))

; %make-displaced-array assumes the following
#+ppc-target
(eval-when (:compile-toplevel)
  (assert (eql ppc::arrayH.flags-cell ppc::vectorH.flags-cell))
  (assert (eql ppc::arrayH.displacement-cell ppc::vectorH.displacement-cell))
  (assert (eql ppc::arrayH.data-vector-cell ppc::vectorH.data-vector-cell)))

#+PPC-target
(defun %make-displaced-array (dimensions displaced-to
                                         &optional fill adjustable offset temp-p)
  (declare (ignore temp-p))
  (if offset 
    (unless (and (fixnump offset) (>= (the fixnum offset) 0))
      (setq offset (require-type offset '(and fixnum (integer 0 *)))))
    (setq offset 0))
  (locally (declare (fixnum offset))
    (let* ((disp-size (array-total-size displaced-to))
           (rank (if (listp dimensions)(length dimensions) 1))
           (new-size (if (fixnump dimensions)
                       dimensions
                       (if (listp dimensions)
                         (if (eql rank 1)
                           (car dimensions)
                           (if (eql rank 0) 1 ; why not 0?
                           (apply #'* dimensions))))))
           (vect-subtype (%vect-subtype displaced-to))
           (target displaced-to)
           (real-offset offset)
           (flags 0))
      (declare (fixnum disp-size rank flags vect-subtype real-offset))
      (if (not (fixnump new-size))(error "Bad array dimensions ~s." dimensions)) 
      (locally (declare (fixnum new-size))
        ; (when (> (+ offset new-size) disp-size) ...), but don't cons bignums
        (when (or (> new-size disp-size)
                  (let ((max-offset (- disp-size new-size)))
                    (declare (fixnum max-offset))
                    (> offset max-offset)))
          (%err-disp $err-disp-size displaced-to))
        (if adjustable  (setq flags (bitset $arh_adjp_bit flags)))
        (when fill
          (if (eq fill t)
            (setq fill new-size)
            (unless (and (eql rank 1)
                         (fixnump fill)
                         (locally (declare (fixnum fill))
                           (and (>= fill 0) (<= fill new-size))))
              (error "Bad fill pointer ~s" fill)))
          (setq flags (bitset $arh_fill_bit flags))))
      ; If displaced-to is an array or vector header and is either
      ; adjustable or its target is a header, then we need to set the
      ; $arh_disp_bit. If displaced-to is not adjustable, then our
      ; target can be its target instead of itself.
      (when (or (eql vect-subtype ppc::subtag-arrayH)
                (eql vect-subtype ppc::subtag-vectorH))
        (let ((dflags (%svref displaced-to ppc::arrayH.flags-cell)))
          (declare (fixnum dflags))
          (when (or (logbitp $arh_adjp_bit dflags)
                    (progn
                      (setq target (%svref displaced-to ppc::arrayH.data-vector-cell)
                            real-offset (+ offset (%svref displaced-to ppc::arrayH.displacement-cell)))
                      (logbitp $arh_disp_bit dflags)))
            (setq flags (bitset $arh_disp_bit flags))))
        (setq vect-subtype (%array-header-subtype displaced-to)))
      ; assumes flags is low byte
      (setq flags (dpb vect-subtype ppc::arrayH.flags-cell-subtag-byte flags))
      (if (eq rank 1)
        (%ppc-gvector ppc::subtag-vectorH 
                      (if (fixnump fill) fill new-size)
                      new-size
                      target
                      real-offset
                      flags)
        (let ((val (%alloc-misc (+ ppc::arrayh.dim0-cell rank) ppc::subtag-arrayH)))
          (setf (%svref val ppc::arrayH.rank-cell) rank)
          (setf (%svref val ppc::arrayH.physsize-cell) new-size)
          (setf (%svref val ppc::arrayH.data-vector-cell) target)
          (setf (%svref val ppc::arrayH.displacement-cell) real-offset)
          (setf (%svref val ppc::arrayH.flags-cell) flags)
          (do* ((dims dimensions (cdr dims))
                (i 0 (1+ i)))              
               ((null dims))
            (declare (fixnum i)(list dims))
            (setf (%svref val (%i+ ppc::arrayH.dim0-cell i)) (car dims)))
          val)))))



#+ppc-target
(defun vector-pop (vector)
  (let* ((fill (fill-pointer vector)))
    (declare (fixnum fill))
    (if (zerop fill)
      (error "Fill pointer of ~S is 0 ." vector)
      (progn
        (decf fill)
        (%set-fill-pointer vector fill)
        (aref vector fill)))))



(defparameter *seq-err-string* "Sequence index ~s too large.")
#+ppc-target
(defun elt (sequence idx)
  (seq-dispatch
   sequence
   (let* ((cell (nthcdr idx sequence)))
     (declare (list cell))
     (if cell (car cell) (signal-type-error idx 'smaller *seq-err-string*)))
   
   (progn
     (unless (and (typep idx 'fixnum) (>= (the fixnum idx) 0))
       (report-bad-arg idx 'unsigned-byte))
     (locally 
       (declare (fixnum idx))
       (if (and (array-has-fill-pointer-p sequence)
                (>= idx (the fixnum  (fill-pointer sequence))))
         (signal-type-error idx 'smaller *seq-err-string*) ;(%err-disp $XACCESSNTH idx sequence)
         (aref sequence idx))))))


#+ppc-target                         
(defun set-elt (sequence idx value)
  (seq-dispatch
   sequence
   (let* ((cell (nthcdr idx sequence)))
     (if cell 
       (locally 
         (declare (cons cell))
         (setf (car cell) value))
       (signal-type-error idx 'smaller *seq-err-string*))) ;(%err-disp $XACCESSNTH idx sequence)))
   (progn
     (unless (and (typep idx 'fixnum) (>= (the fixnum idx) 0))
       (report-bad-arg idx 'unsigned-byte))
     (locally 
       (declare (fixnum idx))
       (if (and (array-has-fill-pointer-p sequence)
                (>= idx (the fixnum (fill-pointer sequence))))
         (signal-type-error idx 'smaller *seq-err-string*) ;(%err-disp $XACCESSNTH idx sequence)
         (setf (aref sequence idx) value))))))



(%fhave 'equalp #'equal)                ; bootstrapping

(defun copy-tree (tree)
  (if (atom tree)
    tree
    (locally (declare (type cons tree))
      (do* ((tail (cdr tree) (cdr tail))
            (result (cons (copy-tree (car tree)) nil))
            (ptr result (cdr ptr)))
           ((atom tail)
            (setf (cdr ptr) tail)
            result)
        (declare (type cons ptr result))
        (locally 
          (declare (type cons tail))
          (setf (cdr ptr) (cons (copy-tree (car tail)) nil)))))))

#|
(defun set-periodic-task-interval (n)
  (lap-inline ()
    (:variable n)
    (if# (not
          (and
           (ne (dtagp arg_z $t_fixnum))
           (pl (progn
                 (move.l arg_z da)
                 (getint da)
                 (move.w da db)))
           (eq (progn
                 (ext.l db)
                 (mkint db)
                 (cmp.l db arg_z)))))
      (wtaerr arg_z '(integer 0 32767)))
    (move.w da (a5 $vblwait1))))
|#



#+ppc-target
(defun set-periodic-task-interval (n)
  n)

#+ppc-target
(defun periodic-task-interval ()
  1)

  
;; derived by doing xalphabetic-p, true if is alpha-char-p in UNICODE
(defparameter alpha-char-table-1
  #(NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL 
        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
        NIL NIL NIL NIL T T T T T T T T T T T T T T T T T T T T T T T T T T NIL NIL NIL 
        NIL NIL NIL T T T T T T T T T T T T T T T T T T T T T T T T T T NIL NIL NIL NIL 
        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL 
        NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL 
        NIL NIL NIL T NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL T NIL NIL NIL NIL T NIL NIL
        NIL NIL NIL T T T T T T T T T T T T T T T T T T T T T T T NIL T T T T T T T T T T
        T T T T T T T T T T T T T T T T T T T T T NIL T T T T T T T T))

(defparameter char-downcase-vector
  #(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 
    33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 
    97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 
    122 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 
    117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 
    142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 
    167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 
    224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 215 248 
    249 250 251 252 253 254 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 
    242 243 244 245 246 247 248 249 250 251 252 253 254 255))

(defparameter char-upcase-vector
  #(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32
    33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64
    65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 65 66
    67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 123 124 125 126 127 128 129 130 
    131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 
    157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 924 182
    183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 
    209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 192 193 194 195 196 197 198 199 200 201 202 203  ;; OS sez upcase of #\§ is #\S ?? - changed here
    204 205 206 207 208 209 210 211 212 213 214 247 216 217 218 219 220 221 222 376))


(defun char-downcase (c)
  (let* ((code (char-code c)))
    (declare (optimize (speed 3)(safety 0)))
    (declare (fixnum code))
    (cond ((%i< code 256)
           (%code-char (uvref char-downcase-vector code)))
          (t 
           (multiple-value-bind (downcode str?)(unicode-char-code-downcase code)
             (let ((downchar (%code-char downcode)))
               (if str?
                 (values downchar str?)
                 downchar)))))))


(defun unicode-char-code-downcase (char-code)
  (declare ((unsigned-byte 16) char-code))  
  (if (not (xupper-case-p (code-char char-code)))  ;; do this help speed? yes a lot when it isn't - 40X
    char-code
    (%stack-block ((the-thing 4))
      (setf (%get-unsigned-word the-thing 0) char-code)
      (with-macptrs ((cfstr (#_cfstringcreatemutable (%null-ptr) 0)))
        (#_CFStringAppendCharacters cfstr the-thing 1)
        (#_CFStringLowerCase cfstr (%null-ptr))
        (let ((new-len (#_cfstringgetlength cfstr)))
          (%stack-block ((new-thing (%i+ new-len new-len)))
            (CFStringGetCharacters cfstr 0 new-len new-thing)
            (#_cfrelease cfstr)
            (if (neq new-len 1) ;; happens for one char out of 712 - uppercase I with a dot #x0130
              (let ((string (make-string new-len :element-type 'extended-character)))
                (%copy-ptr-to-ivector new-thing 0 string 0 (%i+ new-len new-len))
                ;; cheat a little
                (values (if (eq char-code #x0130)(char-code #\i) char-code) string))
              (%get-unsigned-word new-thing))))
        ))))


  

(defun digit-char-p (char &optional radix)
  (let* ((code (char-code char))
         (r (if radix (if (and (typep radix 'fixnum)
                               (%i>= radix 2)
                               (%i<= radix 36))
                        radix
                        (%validate-radix radix)) 10))
         (weight (if (and (<= code (char-code #\9))
                          (>= code (char-code #\0)))
                   (the fixnum (- code (char-code #\0)))
                   (if (and (<= code (char-code #\Z))
                            (>= code (char-code #\A)))
                     (the fixnum (+ 10 (the fixnum (- code (char-code #\A)))))
                   (if (and (<= code (char-code #\z))
                            (>= code (char-code #\a)))
                     (the fixnum (+ 10 (the fixnum (- code (char-code #\a))))))))))
    (declare (fixnum code r))
    (and weight (< (the fixnum weight) r) weight)))
      



#|
(defun char-upcase (c)
  (let* ((code (char-code c)))           
    (declare (optimize (speed 3)(safety 0)))
    (declare (fixnum code))
    (cond ((%i< code 128)
           (if (and (%i<= code (char-code #\z))(%i>= code (char-code #\a)))
             (%code-char (%i- code #.(- (char-code #\a)(char-code #\A))))
             c))
          ((and (<= code #xfe)(>= code #xc0) (neq code #xdf)) ;; latin1
           (if (and (>= code #x00e0)(neq code #x00f7))   ;; beware multiply and divide chars
             (%code-char (- code #x20))
             c))
          (t (%code-char (unicode-char-code-upcase code))))))
|#

(defun char-upcase (c)
  (let* ((code (char-code c)))
    (declare (optimize (speed 3)(safety 0)))
    (declare (fixnum code))
    (cond ((and (%i< code 256)(neq code #xdf))
           (%code-char (uvref char-upcase-vector code)))
          (t 
           (multiple-value-bind (upcode str?)(unicode-char-code-upcase code)
             (let ((upchar (%code-char upcode)))
               (if str?
                 (values upchar str?)
                 upchar)))))))


(defun unicode-char-code-upcase (char-code)
  (declare ((unsigned-byte 16) char-code))  
  (if (not (xlower-case-p (code-char char-code)))  ;; do this help speed? yes a lot when it isn't - 40X
    char-code
    (%stack-block ((the-thing 4))
      (setf (%get-unsigned-word the-thing 0) char-code)
      (with-macptrs ((cfstr (#_cfstringcreatemutable (%null-ptr) 0)))
        (#_CFStringAppendCharacters cfstr the-thing 1)
        (#_CFStringUpperCase cfstr (%null-ptr))
        (let ((new-len (#_cfstringgetlength cfstr)))
          (%stack-block ((new-thing (%i+ new-len new-len)))
            (CFStringGetCharacters cfstr 0 new-len new-thing)
            (#_cfrelease cfstr)
            (if (neq new-len 1) ;; happens for 75 chars out of 834 - some are 3 chars long - just punt
              (let ((string (make-string new-len :element-type 'extended-character)))
                (%copy-ptr-to-ivector new-thing 0 string 0 (%i+ new-len new-len))
                (values char-code string))                
              (%get-unsigned-word new-thing))))
        ))))

(defvar *alpha-numeric-set* nil)
(defvar *lower-case-set* nil)
(defvar *upper-case-set* nil)
(defvar *alpha-set* nil)
(defvar *punctuation-set* nil)
(defvar *whitespace-and-newline-set* nil)
(defvar *whitespace-set* nil)
(defvar *illegal-char-set* nil)
(defvar *control-char-set* nil)
(defvar *decimal-digit-set* nil)


(def-ccl-pointers charsets2 ()
  (setq *alpha-numeric-set* (#_CFCharacterSetGetPredefined #$kCFCharacterSetAlphaNumeric))
  (setq *lower-case-set* (#_CFCharacterSetGetPredefined #$kCFCharacterSetLowercaseLetter))
  (setq *upper-case-set* (#_cfCharacterSetGetPredefined #$kCFCharacterSetUppercaseLetter))
  (setq *alpha-set* (#_cfCharacterSetGetPredefined #$kCFCharacterSetLetter))
  (setq *punctuation-set* (#_CFCharacterSetGetPredefined #$kCFCharacterSetPunctuation))
  (setq *whitespace-set* (#_CFCharacterSetGetPredefined #$kCFCharacterSetWhitespace))
  (setq *whitespace-and-newline-set* (#_CFCharacterSetGetPredefined #$kCFCharacterSetWhitespaceAndNewline))
  (Setq *illegal-char-set* (#_CFCharacterSetGetPredefined #$kCFCharacterSetIllegal))
  (setq *control-char-set* (#_CFCharacterSetGetPredefined #$kCFCharacterSetControl))
  (setq *decimal-digit-set* (#_CFCharacterSetGetPredefined #$kCFCharacterSetDecimalDigit))
  )


;; not to be confused with xalpha-char-p
(defun xalphabetic-p (char)
  (#_CFCharacterSetIsCharacterMember *alpha-set* (char-code char)))

(defun xupper-case-p (char)
  (#_CFCharacterSetIsCharacterMember *Upper-case-set* (char-code char)))

(defun xlower-case-p (char)
  (#_CFCharacterSetIsCharacterMember *lower-case-set* (char-code char)))

;; not to be confused with xalphanumericp
(defun xalphanumeric-p (char)
  (#_CFCharacterSetIsCharacterMember *alpha-numeric-set* (char-code char)))

(defun xpunctuation-p (char)
  (#_CFCharacterSetIsCharacterMember *punctuation-set* (char-code char)))

(defun xillegal-char-p (char)
  (#_CFCharacterSetIsCharacterMember *illegal-char-set* (char-code char)))

(defun xwhitespace-or-eol-p (char)
  (#_CFCharacterSetIsCharacterMember *whitespace-and-newline-set* (char-code char)))

(defun xwhitespace-p (char)
  (#_CFCharacterSetIsCharacterMember *whitespace-set* (char-code char)))

(defun xcontrol-char-p (char)
  (#_CFCharacterSetIsCharacterMember *control-char-set* (char-code char)))

(defun xdecimal-digit-p (char)
  (#_CFCharacterSetIsCharacterMember *decimal-digit-set* (char-code char)))



(defun chkbounds (arr start end)
  (flet ((are (a i)(error "Array index ~S out of bounds for ~S." i a)))
    (let ((len (length arr)))
      (if (and end (> end len))(are arr end))
      (if (and start (or (< start 0)(> start len)))(are arr start))
      (if (%i< (%i- (or end len)(or start 0)) 0)
        (error "Start ~S exceeds end ~S for an array operation." start end)))))

(defun string-start-end (string &optional start end)
  (setq string (string string))
  (let ((len (length (the string string))))
    (flet ((are (a i)(error "Array index ~S out of bounds for ~S." i a)))    
      (if (and end (> end len))(are string end))
      (if (and start (or (< start 0)(> start len)))(are string start))
      (setq start (or start 0) end (or end len))
      (if (%i> start end)
        (error "Start ~S exceeds end ~S for a string operation." start end))
      (multiple-value-bind (str off)(array-data-and-offset string)
        (values str (%i+ off start)(%i+ off end))))))


(defun string= (string1 string2 &key start1 end1 start2 end2)
  (locally (declare (optimize (speed 3)(safety 0)))
    (multiple-value-setq (string1 start1 end1)(string-start-end string1 start1 end1))
    (multiple-value-setq (string2 start2 end2)(string-start-end string2 start2 end2))  
    (%simple-string= string1 string2 start1 start2 end1 end2)))


; redefined in chars 
(defun string-equal (string1 string2 &key start1 end1 start2 end2)
  (multiple-value-setq (string1 start1 end1)(string-start-end string1 start1 end1))
  (multiple-value-setq (string2 start2 end2)(string-start-end string2 start2 end2))
  (when (eq (%i- end2 start2) (%i- end1 start1))
    (let ((upvector char-upcase-vector))
      (declare (optimize (speed 3)(safety 0)))
      (do* ((i start1 (%i+ 1 i))
            (j start2 (%i+ 1 j)))
           ((%i>= j end2))
        (let* ((c1 (aref upvector (%scharcode string1 i)))
               (c2 (aref upvector (%scharcode string2 j))))
          (when (neq c1 c2)(return-from string-equal nil))))
      t)))
        
; ditto
(defun string-lessp (string1 string2 &key start1 end1 start2 end2)
  (multiple-value-setq (string1 start1 end1)(string-start-end string1 start1 end1))
  (multiple-value-setq (string2 start2 end2)(string-start-end string2 start2 end2))
  (let ((upvector char-upcase-vector))
    (declare (optimize (speed 3)(safety 0)))
    (do* ((i start1 (%i+ 1 i))
          (j start2 (%i+ 1 j)))
         ((or (eq j end2)(eq i end1))(if (< j end2) (- i start1) nil))
      (let* ((c1 (aref upvector (%scharcode string1 i)))
             (c2 (aref upvector (%scharcode string2 j))))
        (when (neq c1 c2)
          (if (> c1 c2)
            (return-from string-lessp nil)
            (return-from string-lessp (- i start1))))))))







#+ppc-target
(defun lfun-attributes (lfun &optional new-value)
  (declare (ignore lfun new-value))
  0)

#+PPC-target
(progn
  ; only returns 1 value
  (defun %nth-immediate (lfv i &optional (n (%count-immrefs lfv)))
    (declare (fixnum i n))
    (unless (and (>= i 0) (< i n))
      (report-bad-arg i `(integer 0 ,n)))
    (%svref lfv (the fixnum (1+ i))))
  
  (defun %count-immrefs (lfv)
    (- (uvsize lfv) 2)))




(setf (type-predicate 'lfun-vector) '%lfun-vector-p)


(defun lfun-keyvect (lfun)
  ;Don't bother with kernel fns, they're going away.
  (let ((lfv (%lfun-vector lfun)))
    (when lfv
      (let ((bits (lfun-bits lfun)))
        (declare (fixnum bits))
        (and (logbitp $lfbits-keys-bit bits)
             (or (logbitp $lfbits-method-bit bits)
                 (and (not (logbitp $lfbits-gfn-bit bits))
                      (not (logbitp $lfbits-cm-bit bits))))
             (if #+ppc-target (typep lfv 'interpreted-function) ; patch needs interpreted-method-function too
                 #-ppc-target nil
               (nth 4 (evalenv-fnentry (%nth-immediate lfv 0))) ; gag puke
               (%nth-immediate lfv 0)))))))

#+PPC-target
(progn  ; ???

(defun %lfun-vector-lfun (lfv) lfv)

(defun %lfun-vector (lfn &optional load-p)      ; this is in level-0;68k-def
  (declare (ignore load-p))
  lfn)

)



(defun function-lambda-expression (fn)
  ;(declare (values def env-p name))
  (let* ((bits (lfun-bits (setq fn (require-type fn 'function)))))
    (declare (fixnum bits))
    (if (logbitp $lfbits-trampoline-bit bits)
      (function-lambda-expression (%nth-immediate (%lfun-vector fn) 0))
      (values (uncompile-function fn)
              (logbitp $lfbits-nonnullenv-bit bits)
              (function-name fn)))))

; env must be a lexical-environment or NIL.
; If env contains function or variable bindings or SPECIAL declarations, return t.
; Else return nil
(defun %non-empty-environment-p (env)
  (loop
    (when (or (null env) (istruct-typep env 'definition-environment))
      (return nil))
    (when (or (consp (lexenv.variables env))
              (consp (lexenv.functions env))
              (dolist (vdecl (lexenv.vdecls env))
                (when (eq (cadr vdecl) 'special)
                  (return t))))
      (return t))
    (setq env (lexenv.parent-env env))))

;(coerce object 'compiled-function)
(defun coerce-to-compiled-function (object)
  (setq object (coerce-to-function object))
  (unless (typep object 'compiled-function)
    (multiple-value-bind (def envp) (function-lambda-expression object)
      (when (or envp (null def))
        (%err-disp $xcoerce object 'compiled-function))
      (setq object (compile-user-function def nil))))
  object)


;Map function over all heap lfuns - only caller is callers! - we can punt
; but remember need to do it


            
(defun native-mcl-kernel-version ()
  (let* ((vers (%get-kernel-global 'native-kernel-version)))
    (declare (fixnum vers))
    (if (zerop vers)
      (values nil nil)
      (values (ash vers -8) (logand #xff vers)))))


; Given nilreg relative symbol, return offset
; Return NIL for non-symbol or non-nilreg relative symbol
#+GONZO
(defun nilreg-offset (sym)
  (when (symbolp sym)
    (lap-inline (sym)
      (move.l arg_z atemp0)
      (move.l nilreg acc)
      (if# (ne (btst ($ $sym_bit_indirect) (atemp0 $sym.vbits)))
        (move.l (atemp0 $sym.gvalue) acc)
        (sub.l nilreg acc)
        (mkint acc)))))

#-ppc-target
(defvar %toplevel-function% nil)



(unless (fboundp 'call-toplevel-function)

(defun call-toplevel-function (fun)
  (funcall fun))

) ; end unless


(defun %set-toplevel (&optional (fun nil fun-p))
  ;(setq fun (require-type fun '(or symbol function)))
  (if (eq *current-process* *initial-process*)
    (prog1
      %toplevel-function%
      (when fun-p
        (setq %toplevel-function% fun)))
    (let* ((p *current-process*)
           (function.args (process.initial-form p)))
      (prog1
        (if (eq (car function.args) #'call-toplevel-function)
          (cadr function.args)
          (if (cdr function.args)
            (let ((function.args (copy-list function.args)))
              #'(lambda () (apply (car function.args) (cdr function.args))))
            (car function.args)))
        (when fun-p
          (without-interrupts
           (setf (car function.args) #'call-toplevel-function
                 (cdr function.args) (list fun))))))))

; Look! GC in Lisp !



#+ppc-target
(defppclapfunction full-gccount ()
  (ref-global arg_z tenured-area)
  (cmpwi cr0 arg_z 0)
  (if :eq
    (ref-global arg_z gc-count)
    (lwz arg_z ppc::area.gc-count arg_z))
  (blr))

#+ppc-target
(defun gccounts ()
  (let* ((total (%get-gc-count))
         (full (full-gccount))
         (g2-count 0)
         (g1-count 0)
         (g0-count 0))
    (when (egc-enabled-p)
      (let* ((a (%normalize-areas)))
        (setq g0-count (%fixnum-ref a ppc::area.gc-count) a (%fixnum-ref a ppc::area.older))
        (setq g1-count (%fixnum-ref a ppc::area.gc-count) a (%fixnum-ref a ppc::area.older))
        (setq g2-count (%fixnum-ref a ppc::area.gc-count))))
    (values total full g2-count g1-count g0-count)))

      
#+ppc-target
(defppclapfunction gc ()
  (check-nargs 0)
  (save-lisp-context)
  (bla .SPxalloc-handler)
  (uuo_xalloc rzero rzero rzero)
  (mr arg_z rnil)
  (ba .SPpopj))

#+ppc-target
(defppclapfunction purify ()
  (check-nargs 0)
  (save-lisp-context)
  (bla .SPxalloc-handler)
  (uuo_xalloc rzero rnil rzero)
  (mr arg_z rnil)
  (ba .SPpopj))

#+(and ppc-target notyet)
(defppclapfunction %save-library ((refnum 0) (libname arg_x) (firstobj arg_y) (lastobj arg_z))
  (vpop temp0)
  (unbox-fixnum imm0 temp0)
  (uuo_xalloc rzero vsp imm0)
  (box-fixnum arg_z imm0)
  (box-unsigned-byte-32 arg_y imm1 imm2)
  (vpush arg_z)
  (vpush arg_y)
  (la temp0 8 vsp)
  (set-nargs 2)
  (ba .SPvalues))

;;;Procedure for creating pascal callable functions


(defparameter %pascal-functions%
  (make-array 4 :initial-element nil))


; If name is already bound to a pascal-callable function, reuse the slot it occupies
; so that pointers buried in Mac data structures remain valid.




; Called by kill-lisp-pointers
(defun defpascal-trampoline-without-interrupts-p (code)
  (and (macptrp code) (not (%null-ptr-p code)) (neq 0 (%get-word code 6))))

; The least significant n bits of the bitmap contain register specifiers for
; each of n/4 arguments.
; Bit n+5 is set if error checking on the low half of D0 is requested.
; Bit n+4 is set if a value is to be returned: bits n thru n+3 specify the register to return.
; If this register is a data register, bit n+6 is set if its low halfword is to be extended, and
; bit n+7 is set when sign- (vice zero-) extension is required.
#+ppc-target
(defun %register-trap (trapword bitmap &rest args)
  (funcall (compile nil `(lambda () (%register-trap ,trapword ,bitmap ,@args)))))



#+ppc-target
(defun %stack-trap (&rest args)
  (funcall (compile nil `(lambda () (%stack-trap ,@args)))))



(defun ppc-ff-call (addr &rest args)
  (declare (dynamic-extent args))
  (funcall (compile nil `(lambda () 
                           (declare (inline ppc-ff-call))
                           (ppc-ff-call ,addr ,@args)))))

(defun ff-call-slep (slep &rest args)
  (declare (dynamic-extent args))
  (funcall (compile nil `(lambda () 
                           (declare (inline ff-call-slep))
                           (ff-call-slep ,slep ,@args)))))

#+ppc-target
(defun ff-call (addr &rest args)
  (declare (dynamic-extent args))
  (funcall (compile nil `(lambda ()
                           (declare (inline ff-call))
                           (ff-call ,addr ,@args)))))



(defun get-properties (place indicator-list)
  "Like GETF, except that Indicator-List is a list of indicators which will
  be looked for in the property list stored in Place.  Three values are
  returned, see manual for details."
  (do ((plist place (cddr plist)))
      ((null plist) (values nil nil nil))
    (cond ((atom (cdr plist))
	   (error "~S is a malformed proprty list."
		  place))
	  ((memq (car plist) indicator-list) ;memq defined in kernel
	   (return (values (car plist) (cadr plist) plist))))))


(defun car (x) (car x))
(defun cdr (x) (cdr x))

; Screw: should be a passive way of inquiring about enabled status.



#+ppc-target
(progn

(defun egc (arg)
  (not (eql 0 (the fixnum (ppc-ff-call (%kernel-import ppc::kernel-import-egc-control) 
                                       :unsigned-halfword (if arg 1 0)
                                       :unsigned-halfword)))))

(defun egc-active-p ()
  (and (egc-enabled-p)
       (not (eql 0 (%get-kernel-global 'oldest-ephemeral)))))

; this IS effectively a passive way of inquiring about enabled status.
(defun egc-enabled-p ()
  (not (eql 0 (%fixnum-ref (%normalize-areas) ppc::area.older))))



#|
(defvar *generation-1-area* nil)
(def-ccl-pointers g1 nil (setq *generation-1-area* nil))

;; the area structure doesn't move does it?

(defun get-generation-1-area (g0-area)
  (or *generation-1-area*
      (let ((enabled-p (egc-enabled-p)))
        (without-interrupts
         (if (not enabled-p)(egc t))
         (setq *generation-1-area* (%fixnum-ref g0-area ppc::area.older))
         (if (not enabled-p)(egc nil)))
        *generation-1-area*)))

(defun get-egc-generations ()
  (let* ((g0 (%normalize-areas))
         (g1 (%fixnum-ref g0 ppc::area.older)))
    (when (eql 0 g1)
      (setq g1 (get-generation-1-area g0)))
    (values g0 g1 (%fixnum-ref g1 ppc::area.older))))


|#

(defun get-egc-generations ()
  (let* ((g0 (%normalize-areas))
         (g1 (%fixnum-ref g0 ppc::area.older)))
    (when (eql 0 g1)
      (without-interrupts
       (egc t)
       (setq g1 (%fixnum-ref g0 ppc::area.older))
       (egc nil)))
    (values g0 g1 (%fixnum-ref g1 ppc::area.older))))
             

(defun egc-configuration ()
  (multiple-value-bind (g0 g1 g2)(get-egc-generations)    
    (values (ash (the fixnum (%fixnum-ref g0 ppc::area.threshold)) -8)
            (ash (the fixnum (%fixnum-ref g1 ppc::area.threshold)) -8)
            (ash (the fixnum (%fixnum-ref g2 ppc::area.threshold)) -8))))


(defun configure-egc (e0size e1size e2size)
  (unless (egc-active-p)
    (setq e2size (logand (lognot #x7fff) (+ #x7fff (ash (require-type e2size '(unsigned-byte 18)) 10)))
          e1size (logand (lognot #x7fff) (+ #x7fff (ash (require-type e1size '(unsigned-byte 18)) 10)))
          e0size (logand (lognot #x7fff) (+ #x7fff (ash (require-type e0size '(integer 1 #.(ash 1 18))) 10))))
    (multiple-value-bind (g0 g1 g2)(get-egc-generations)
      (%fixnum-set g0 ppc::area.threshold (ash e0size (- ppc::fixnumshift)))
      (%fixnum-set g1 ppc::area.threshold (ash e1size (- ppc::fixnumshift)))
      (%fixnum-set g2 ppc::area.threshold (ash e2size (- ppc::fixnumshift)))
      t)))


)  ; end of #+ppc-target



#+ppc-target
; The question doesn't make sense for the PPC garbage collector,
; but EGC is a good idea there, so return true
(defun egc-mmu-support-available-p ()
  t)

(defun macptr-flags (macptr)
  (if (eql (uvsize (setq macptr (require-type macptr 'macptr))) 1)
    0
    (uvref macptr PPC::XMACPTR.FLAGS-CELL)))

#|
(ppc::define-fixedsized-object xmacptr
  address
  flags
  link  ; where we get this from?
)
|#




#+PPC-target
(progn

(defppclapfunction set-%gcable-macptrs% ((ptr ppc::arg_z))
  (ref-global arg_y gcable-pointers)
  (stw arg_y ppc::xmacptr.link ptr)
  (set-global ptr gcable-pointers)
  (blr))

(defun make-gcable-macptr (flags)
  (let ((v (%alloc-misc ppc::xmacptr.element-count ppc::subtag-macptr)))
    (setf (uvref v PPC::XMACPTR.ADDRESS-CELL) 0)  ; ?? yup.
    (setf (uvref v PPC::XMACPTR.FLAGS-CELL) flags)
    (without-interrupts
     (set-%gcable-macptrs% v))
    v))


(defun %new-gcable-ptr (size &optional clear-p)
  (let ((p (make-gcable-macptr $flags_DisposPtr)))
    (if clear-p
      (%setf-macptr p (#_NewPtrClear :errchk size))
      (%setf-macptr p (#_NewPtr :errchk size)))
    p))
)


; This doesn't really make the macptr be gcable (now has to be
; on linked list), but we might have other reasons for setting
; other flag bits.
(defun set-macptr-flags (macptr value) 
  (unless (eql (uvsize (setq macptr (require-type macptr 'macptr))) 1)
    (setf (%svref macptr PPC::XMACPTR.FLAGS-CELL) value)
    value))

(defun gc-event-check-enabled-p ()
  (declare (special *gc-event-status-bits*))
  (%i>= *gc-event-status-bits* 0))

#|
(defun set-gc-event-check-enabled-p (flag)
  (declare (special *gc-event-status-bits*))
  (setq *gc-event-status-bits*
        (lap-inline (flag *gc-event-status-bits*)
          (if# (eq nilreg arg_y)
            (bset ($ 31) acc)
            else#
            (bclr ($ 31) acc))))
  flag)
|#


(defun set-gc-event-check-enabled-p (flag)
  (declare (special *gc-event-status-bits*)
           (fixnum  *gc-event-status-bits*))
  ; Polling is disabled when $gc-polling-enabled-bit is set.
  (setq *gc-event-status-bits*
        (if flag 
          (logand (lognot (ash -1 $gc-polling-enabled-bit)) *gc-event-status-bits*)
          (logior (ash -1 $gc-polling-enabled-bit) *gc-event-status-bits*)))
  flag)

(defun gc-cursor-suppressed-p ()
  (declare (special *gc-event-status-bits*)
           (fixnum *gc-event-status-bits*))
  (locally (declare (optimize (speed 3) (safety 0)))
    (logbitp $GC-USE-GC-CURSOR-BIT *gc-event-status-bits*)))

(defun set-gc-cursor-suppressed-p (flag)
  (declare (special *gc-event-status-bits*)
           (fixnum *gc-event-status-bits*))
  (setq *gc-event-status-bits*
        (locally (declare (optimize (speed 3) (safety 0)))      ; no $sp-specref
          (if flag
            (bitset $GC-USE-GC-CURSOR-BIT *gc-event-status-bits*)
            (bitclr $GC-USE-GC-CURSOR-BIT *gc-event-status-bits*))))
  flag)

; backwards compat.
(setf (symbol-function 'gc-cursor-supressed-p)     #'gc-cursor-suppressed-p
      (symbol-function 'set-gc-cursor-supressed-p) #'set-gc-cursor-suppressed-p)


;True for a-z - redefined in chars.lisp
(defun lower-case-p (c)
  (let ((code (char-code c)))
    (and (>= code (char-code #\a))
         (<= code (char-code #\z)))))

;True for a-z A-Z
(defun alpha-char-p (c)
  (let* ((code (char-code c)))
    (declare (fixnum code))
    (cond
     ((and (< code 256))
      (uvref alpha-char-table-1 code))
     (t (xalphabetic-p c)))))




; def-accessors type-tracking stuff.  Used by inspector
(defvar *def-accessor-types* nil)

(defun add-accessor-types (types names)
  (dolist (type types)
    (let ((cell (or (assq type *def-accessor-types*)
                    (car (push (cons type nil) *def-accessor-types*)))))
      (setf (cdr cell) (if (vectorp names) names (%list-to-uvector nil names))))))

; Real definition(s) in lib;misc.lisp
(defun (setf documentation) (string thing &optional doc-type)
  (declare (ignore  doc-type thing))
  string)

; Make sure the imported symbols below actually exist
(mapcar #'intern
        '("DEFTRAP" "DEFCTBTRAP" "DEFRECORD" "REQUIRE-INTERFACE"
          #+interfaces-2 "DEFTRAP-INLINE"
          "PROVIDE-INTERFACE" "RECORD-LENGTH" "DEF-MACTYPE" "FIND-MACTYPE"
          "%DEFINE-RECORD" "FIND-RECORD-DESCRIPTOR"
          "%INT-TO-PTR" "%INC-PTR" "%PTR-TO-INT"
          "%GET-BYTE" "%GET-WORD" "%GET-LONG" "%GET-PTR"
          "%HGET-BYTE" "%HGET-WORD" "%HGET-LONG" "%HGET-PTR"
          "%GET-SIGNED-BYTE" "%GET-SIGNED-WORD" "%GET-SIGNED-LONG"
          "%GET-UNSIGNED-BYTE" "%GET-UNSIGNED-WORD" "%GET-UNSIGNED-LONG"
          "%HGET-SIGNED-BYTE" "%HGET-SIGNED-WORD" "%HGET-SIGNED-LONG"
          "%PUT-BYTE" "%PUT-WORD" "%PUT-LONG" "%PUT-PTR"
          "%HPUT-BYTE" "%HPUT-WORD" "%HPUT-LONG" "%HPUT-PTR"
          "%STACK-BLOCK" "%GEN-TRAP"))

(defpackage :traps
  (:use common-lisp)            ; don't use CCL
  (:import-from :ccl
                deftrap defctbtrap defrecord require-interface 
                #+interfaces-2 deftrap-inline
                provide-interface record-length def-mactype find-mactype 
                %define-record find-record-descriptor
                %int-to-ptr %inc-ptr %ptr-to-int
                %get-byte %get-word %get-long %get-ptr
                %hget-byte %hget-word %hget-long %hget-ptr
                %get-signed-byte %get-signed-word %get-signed-long
                %get-unsigned-byte %get-unsigned-word %get-unsigned-long
                %hget-signed-byte %hget-signed-word %hget-signed-long
                %put-byte %put-word %put-long %put-ptr
                %hput-byte %hput-word %hput-long %hput-ptr
                %stack-block %gen-trap)
  (:export $true $false))

(defvar *traps-package* (find-package :traps))

(defun gestalt (selector &optional bitnum)
  (rlet ((res :longint))
    (if (eql 0 (#_Gestalt selector res))
      (let ((attr (%get-long res)))
        (if bitnum
          (logbitp bitnum attr)
          attr)))))
#|
(defun chartype (char &optional (script (string-compare-script)))
  (let* ((font (#_getscriptvariable script #$smScriptAppFond))
         (code (char-code char)))
    (declare (ignore-if-unused font))
    ; typemask #xf 0 means punct or number, anything else means alpha?
    ; classmask #xf00 100 is number, 0 is "normal" 300 is whitespace
    (%stack-block ((p 2))
      (if (%i< code #x100)(%put-byte p code)(%put-word p code))
      #-carbon-compat
      (with-FONT font
        (#_chartype p 0))
      #+carbon-compat ;; is in interfacelib - dunno when it arrived there
      (#_charactertype p 0 script))))


(defun xalpha-char-p (char &optional (script (string-compare-script)))
  (neq #$smcharpunct (logand #$smctypemask (chartype char script))))


; or maybe we mean not xalphanumericp
(defun char-word-break-p (char &optional (script (string-compare-script)))
  (if (eq script #$smRoman)
    (not (%str-member char *fred-word-constituents*))
    (not (xalphanumericp char script))))
|#

(defparameter *non-alpha-fred-word-constituents*  "!@$%^&*_+=<>.?|-")  ;; all 7bit ascii

(defun alphanumericp (c)
  (let* ((code (char-code c)))
    (declare (fixnum code))    
    (if (<= code #x7f)
      (or (and (>= code #.(char-code #\0))
               (<= code #.(char-code #\9)))
          (and (>= code #.(char-code #\a))
               (<= code #.(char-code #\z)))
          (and (>= code #.(char-code #\A))
               (<= code #.(char-code #\Z))))
      (xalphanumeric-p c))))

(defun new-char-word-break-p (char &optional script)
  (declare (ignore script))
  (and (not (alphanumericp char))
       (not (%str-member char *non-alpha-fred-word-constituents*))))
           

#|
(defun xalphanumericp (char &optional (script (string-compare-script)))
  (let ((type (chartype char script)))
    (or (neq #$smcharpunct (logand #$smctypemask type))
        (and ;(eq smcharpunct (logand #$smctypemask type))
         (eq #$smpunctnumber (logand #$smcClassmask type))))))

;; callers did japanese < 128
;; do the hairy one otherwise for "ascii" 2 byte chars

(defun xchar-up-down (char &optional down-p (script (string-compare-script)))    
    (if (and nil (neq script #$smRoman)  ; shouldn't be here if it is
             (neq script #$smJapanese)
             (let ((flags (get-script script #$smscriptflags)))
               (and ;(not (logbitp #$smsfsingbyte flags)) ; who cares if 2 or 1 byte
                (not (logbitp #$smsfNatCase flags)))))
      char
      (let* ((code (char-code char))
             ;(font (#_getscriptvariable script #$smScriptAppFond))
             (len (if (%i> code #xff) 2 1)))
        (progn ;with-font font
          (%stack-block ((p 2))
            (if (eq len 2) (%put-word p code)(%put-byte p code))
            (if down-p
              (#_lowercasetext p len script)
              (#_uppercasetext p len script))
            (code-char (if (eq len 1)(%get-byte p)(%get-word p))))))))
|#


; Support for defresource & using-resource macros
(defun make-resource (constructor &key destructor initializer)
  (%cons-resource constructor destructor initializer))

(defun allocate-resource (resource)
  (setq resource (require-type resource 'resource))
  (let ((pool (resource.pool resource))
        res)
    (without-interrupts
     (let ((data (pool.data pool)))
       (when data
         (setf res (car data)
               (pool.data pool) (cdr (the cons data)))
         (free-cons data))))
    (if res
      (let ((initializer (resource.initializer resource)))
        (when initializer
          (funcall initializer res)))
      (setq res (funcall (resource.constructor resource))))
    res))

(defun free-resource (resource instance)
  (setq resource (require-type resource 'resource))
  (let ((pool (resource.pool resource))
        (destructor (resource.destructor resource)))
    (when destructor
      (funcall destructor instance))
    (without-interrupts
     (setf (pool.data pool)
           (cheap-cons instance (pool.data pool)))))
  resource)      

(defun listp (x) (listp x))

(defPARAMETER eol-chars
  `(#\return #\linefeed ,(code-char #x2028) ,(code-char #x2029)))

(defPARAMETER eol-char-codes
  (list (char-code #\return)(char-code #\linefeed) #x2028 #x2029))

(defparameter eol-string
  #.(coerce eol-chars 'string))

(defun char-eolp (char)
  (memq char eol-chars))

(defun char-code-eolp (code)
  (memq code eol-char-codes))
  

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
	3	1/5/95	akh	added char-word-break-p
|# ;(do not edit past this line!!)
