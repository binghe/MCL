;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  6 10/5/97  akh  see below
;;  5 6/2/97   akh  maybe nothing
;;  19 7/26/96 akh  memeql used %cdr when it shouldn't have
;;  18 7/18/96 akh  alanr's suggestion for optimization of asseql etal if eq == eql for item.
;;
;;  16 5/20/96 akh  member-test special case test eq or eql
;;  10 2/19/96 akh  adjoin applys key to item too
;;  8 11/13/95 akh  get-sstring - no vect-byte-length
;;  5 10/27/95 akh  damage control
;;  5 10/26/95 gb   isolate low-level macro stuff
;;  3 10/17/95 akh  merge patches
;;  7 2/6/95   akh  add some functions that are called early due to new compiler optimizers.
;;  6 2/3/95   akh  add adjoin-eq and adjoin-eql for bootstrapping reasons
;;  5 2/3/95   akh  fixes so MCL will build from scratch
;;  4 1/31/95  akh  put back old handlep - new one may not work says bill
;;  3 1/30/95  akh  added handlep from patch
;;  (do not edit before this line!!)


; L1-utils.lisp
; Copyright 1986-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-2004 Digitool, Inc.

;This file is %included into Level-1.lisp
;This file has miscellaneous utilities including objects and defpascal

; Modification History
;; pointerp = macptrp
;; declare not special-operator-p ??
;; yet another handlep
;; %defvar sets doc even if already bound - dietz test
;; similar-as-constants-p again - 1.0 aint same as 1
;; ----- 5.2b6
;; similar-as-constants-p - 1.0s0 aint the same as 1.0d0
;; ---- 5.2b2
;; total-heap-allocated sync with kernel - agin
;; --- 5.2b1
;; another try for handlep
;; *default-character-type* is extended-character
;; output of room more readable - from Toomas Altosaar
;; change total-heap-allocated
;; ----- 5.1final
;; set-preferred-size-resource change >= to >
;; string-string-equal -> string-equal
;; ------ 5.1b1
;; rsc-string uses %get-string-from-handle
;; total-heap-allocated adjustment
;; zone-pointerp filters out windowptrs and ports on osx - must be a better more inclusive way!
;; %str-assoc uses string-string-equal
;; constantp fix from slh
;; --------- 5.0 final
;; gensym whines if Nil provided
;; room stop telling lies when OSX
;; ------ 5.0b3<<<<<<< l1-utils-ppc.lisp
;;=======
;;=======
;;>>>>>>> 1.8
;; 12/24/02 ss moved %get-cfstring to lib:misc.lisp since CARBON-COMPAT doesn't seem to be defined yet here.
;;<<<<<<< l1-utils-ppc.lisp
;;>>>>>>> 1.5=======
;;>>>>>>> 1.8
;; 12/6/02 ss added %get-cfstring because machine-instance and friends need it.
;; fix mis-parens in handlep for non osx-p case - caused crash in classic mode but not on plain os 9
;; add set-preferred-size-resource
;; fix preferred-size-from-size-resource
;; fiddle with handlep for osx but still nonsense, zone-pointerp more likely true on OSX - mostly to avoid crashes
;;  no mo consing in pointerp - though is pretty silly on osx - nearly always true for any macptr
;; --------- 4.4b4
;; room says unknown for used mac heap if OSX
;; --------- 4.4b3
;; 12/27/01 akh fix handlep and pointer-size for osx and #_isvalidcontrolhandle
;; ----------- 4.4b2
;; 05/29/00 akh some dubious stuff to avoid LMGetxxxZone when osx
; 04/25/00 akh %define-compile-time-symbol-macro, fix misparens from Kim Barrett
; --------------- 4.3.1b1
; 09/02/99 akh %get-ostype - dont cons if sym already exists in keyword package - from Terje N. somewhat modified
; 07/27/99 akh proclaim uses type-specifier-p vs *cl-types*
; ---------- 4.3f1c1
; 05/08/99 akh define-symbol-macro support
; 05/08/99 akh constantp takes &optional env
; ---------- 4.3b1
; 05/09/98 akh fixes to asseql and memeql from duncan smith
; 09/05/97 akh  %put-string-segment-contents for extended string given start!
; 05/07/97 bill boundp moved to "ccl:level-0;l0-symbol.lisp
; 04/26/97 bill %set-single-float no longer conses for double-float values.
;               %hset-single-float works the same way.
; 04/25/97 bill %set-single-float DWIM for double-float value
; ------------- 4.1f1
; 03/26/97 gb   %single-float accessors return/require SHORT-FLOATs.
; ------------- 4.1b1
; 03/01/97 gb   define CLEAR-TYPE-CACHE for bootstrapping.
; 01/27/97 bill getf-test, remprop-test
; ------------- 4.0
; 10/04/96 slh  set-function-info back to lib
; 10/03/96 slh  set-function-info here from lib;misc.lisp, for early inlines
; 09/30/96 bill %put-double-float, %hput-double-float, %put-single-float, %hput-single-float
; 09/23/96 bill %get-double-float, %get-single-float and friends.
; ------------- 4.0b2
; 09/17/96 bill %dereference-handle
; ------------- 4.0b1
; akh fix source-file-or-files for setf function 
; akh - alanr's suggestion for optimization of asseql etal if eq == eql for item.
; 05/09/96 bill Will Fitzgerald's fix to make record-source-file resolve aliases
; akh member-test special case test eq or eql
; 04/95/96 gb   PPC-LAP-FUNCTION is a special form. I mean special operator.
; 03/26/96 gb   ZONE-POINTERP, HANDLEP move here, use #_LM accessors.
; 03/07/96 bill define %put-ostype recursively; the compiler inlines it.
; 03/07/96 bill ostype-p
; 02/20/96 gb   cpu-number returns native CPU id
; 02/22/96 bill Get rid of bold font style
; 12/13/95 gb   remove cmulisp hack in macro-function
; 11/06/95 bill  EQ moves to "ccl:level-0;ppc;ppc-pred" for PPC
; 10/20/95 slh   de-lapified
; 01/26/95 alice new handlep from handlep-patch
;------------- 3.0d16
;10/03/93 alice record-source-file uses window-title (front-window) when no file - better than nothing
;-----------
;;start of added text
;01/05/93 bill  lfun-bits now always returns a fixnum
;-------------- 3.0d13
;07/28/93 bill  getindstring moves here from "ccl:library;interfaces.lisp"
;-------------- 3.0d11
;07/02/93 alice added %put-string-segment-contents
;06/19/93 alice %get-string and %put-string and %put-cstring take script arg.
;06/14/93 alice %get-string and %get-cstring  know about system script.

;05/17/93 bill  handlep no longer knows deep dark secrets of the Mac memory manager.
;               macptr<= & macptr-evenp move here from level-2.lisp.
;               (This doesn't work yet, so the old code is still there.
;                new-handlep is the attempt at a new way).
;-------------- 3.0d8
;05/16/93 alice %type-of has simple-base-string and simple-extended-string
;05/03/93 alice %type-of distinguishes base from extended on basis of high byte 
;		rather than byte above type 
;-------------- 2.1d6
;10/20/92 alice record-source-file - (namestring (back-translate
; 02/11/93 bill in %get-cstring: %inc-ptr -> %incf-ptr - less consing.
; 02/05/93 bill asseql & memeql call $sp-assq or $sp-memq if EQ is the same as EQL for the item.
; 12/29/92 bill (member 1 '((1) (2)) :key #'first :test-not #'eql) no longer jsr's to '0
;11/20/92 gb    Everything you know is wrong: flip car & cdr, change lfun bits location, new headers,
;               etc.  #'TRUE & #'FALSE moved here.
;--------------- 2.0
;04/03/92 bill fix Engber's typo in %put-string's error message.
;03/18/92 bill  Since, it's used as a setf inverse, %set-ostype needs to
;               return its STR argument.
;03/13/92 bill  gb's %set-string fix so that (setf (%get-string foo) bar)
;               works correctly.
;-------------  2.0f3
;12/10/91 gb    no ralph bit.
;12/06/91 gb    coerce-to-function simpler; coerce uses something hairier.
;-------- 2.0b4
;11/20/91 bill  GB's patch to %defun, *nx-globally-inline*
;11/01/91 gb    nuke "with-invisible-references".
;09/12/91 alice coerce-to-function for '(lambda ) wants arg_z not arg_y
;---------------- 2.0b2
;08/24/91 gb    (%un)fhave clears a line or two of cache.  Forget about (PCL) funcallable-instances.
;08/24/91 gb    use new trap syntax.
;08/14/91 bill  require-null-or-handlep
;07/19/91 bill  gensym post-increments *gensym-counter*
;08/19/91 gb    define %SET-STRING.
;07/21/91 alice record-source-file don't bitch if function and undefined (i.e. someone did fmakunbound)
;07/21/91 gb    new vector subtypes, badarg scheme.  Remove "full long" support, define some
;               things open-coded by compiler.  %defparameter (for fasloader, NYI.)
;               Leave similar constants alone (this is a mess.)  cl-types here, defun is a
;               macro and thus in level-2.  No more %(f)unhave, make (f)makunbound do it.
;07/09/91 bill  optimize make-keyword
;07/01/91 bill  %get-cstr moves here from l1-edcmd & changes its name to %get-cstring
;               %store-cstr moved here from ff & changes its name to %put-cstring.
;06/13/91 alice record-source-file minimize retention of back-translated pathnames
; 		and dont backtranslate unless we are recording source files!
;--------------- 2.0b2
;05/23/91 bill make special-form-p know about fbind
;05/20/91 gb   add ARRAY-DATA-OFFSET-SUBTYPE.  %PUT-STRING allows non-simple strings.  New RECORD-ARGLIST
;              scheme in %MACRO.  New type stuff for short-floats.
;03/05/91 alice report-bad-arg gets 2 args, bad named arg had its IF clauses backwards (maybe dont use?)
;03/04/91 alice record-source-file - back-translate-pathname if given a physical pathname - do we like this?
;01/17/91 gb   handlep checks sign bit of (a5 $memflags).
;--------------------- 2.0b1
;01/08/91 gb   add %vreflet, %primitive to special forms
;12/05/90 gb   new-lap a special form.  Compiler now needs to know what is syntactically
;              a special form.  %lfun-vector loads by default.
;11/26/90 akh  %make-function heed *compile-definitions*, %type-of knows interpreted
;11/20/90 gb   load-time-value is a special form.
;11/06/90 bill null-or-handlep (called by DEFTRAP type-checking code)
;10/25/90 akh  get-sstring requires string
;10/25/90 gz   unsigned long vectors.
;10/16/90 gb   new lap stuff; new type-predicate scheme.
;10/04/90 bill bootstrapping-fmakunbound handles (setf foo)
;10/03/90 bill %class-cpl -> %inited-class-cpl
;09/24/90 bill type-check the list in position.
;09/18/90 alice fix source-file-or-files
;08/29/90 alice record-source-file take a method object for methods - try to save space
;09/06/90 bill *%saved-method-var%* &  set-*%saved-method-var%*
;08/25/90 bill in %type-of: Check for trampoline bit before method-function
;              bit so that closures can have the next-method-bits set.
;08/24/90 bill (setf (assq ...) ...).  %macro's second arg can be
;              (doc body-pos) to record position of &body in
;              *fred-special-indent-alist*.
;08/23/90 bill break closure-function out of function-name
;08/02/90 gb   plist accessors for new symbols.
;08/01/90 alice record-source-file remember class for methods (s.b. classes) & other good stuff
;07/25/90 alice record-source-file bitch when redefining by any means (not just loading)
;07/04/90 bill new type checking for generic-functions & combined-methods.
;06/26/90 bill nremove made me wince.
;06/13/90 gb   macro-function is defined on symbols only.
;06/08/90 gb   Locally is a special form.
;05/30/90 gb   eval-redef set-car, set-cdr, rplaca, rplacd. Remove %immediate accessors.
;05/28/90 gb   Don't use %move-vect in %put-string.
;05/25/90 alice bugger %defun for encapsulations
;05/23/90 gb   flush calls to symtagp.
;05/22/90 gb   flush proclaimed{parameter,bound}-p.
;05/09/90 gb   misguided paren in %assoc-test-not.
;05/04/90 gb   note-function-info when compiling defun.
;05/04/90 gz   Improved similar-as-constants-p a bit in case someday never comes...
;04/30/90 gb   new, not-so-sticky gensym.  New macroexpansion environment stuff.
;03/15/90 bill Remove function entry from %get-full-long & %put-full-long:
;              they must be uninterruptable as they are called by rref expansion
;              with dereferenced handles.
;03/13/90 gz   (setf (%get-point)).
;01/17/90 gz   Changed lfun-name to check hash table, $lfatr-noname-bit.
;12/29/89 gz   Made self-evaluating-p more accurate.
;              Made %unfhave preserve the indirect bit.
;12/27/89 bill Simplified and corrected inherit-from-p
;12/27/89 gz   Added %ostype-ptr.  Accept non-simple strings in %put-ostype.
;              Added add-to-alist.  Moved redefine-kernel-function, fmakunbound elsewhere,
;              don't call it, assume fset takes care of it.
;              Watch out for swappable functions in %type-of, %lfun-vector.
;              Low level support for function specs/setf functions (%fhave, fboundp,
;              symbol-function).  Moved high-level function spec stuff elsewhere.
;12/15/89 gz   Added nfunction and without-interrupts to special forms.
;12/05/89 gb   new &laps for old.  Defun expands into "global-function-name" decl.
;11/22/89 gb   32-bit handlep, %strip-address.
;11/18/89 gz   (macro ... -> (defmacro ...  Moved qlfun to level-2.
;              non-nil-symbol-p.
;              define-constant uses EQUALP (for now) and continuable error.
;              %lambda-list property -> hash table.
;              Use set-documentation to set documentation.
;              Moved init-list-default to level-2 (why was it here???)
;              Made %macro (i.e. defmacro) go through set-macro-function.
;              Bootstrapping store-setf-method.
;              Don't use plists for source files.
;              Flushed 'object and 'flavors-instance from %type-of.
;13-Nov-89 Mly (per GB) _SysBeep wants 16 bits on tha'stack
;10/31/89 bill Test $lfbits-ralph-bit for generic-function, method-function,
;              and combined-method in %type-of.
;10/22/89 bill add combined-method to %type-of
;10/19/89 bill %type-of returns 'method-function for the function inside a method.
;              instead of standard-method.
;10/13/89 gb  function-name doesn't descend named trampolines.
;10/4/89 gz   fset-globally -> fset.
;9/30/89 gz   %lfun-vector, use it in lfun-bits, lfun-name.
;9/28/89 gb  unsigned short, byte vectors.
;09/27/89 gb simple-string -> ensure-simple-string.  Don't default
;             macroexpansion environment anymore.  Forget macroexpansion-
;             object-p (bootstrapping artifact.)  %defvar records source always.
;             no instance/object variables.
;9/17/89 gb   removed (ask nil ...). Moved object lisp code to lib;objects. No
;             $sym.gfunc (defunct.)
;9/14/89 bill Add *level-1-loaded* flag to prevent full-pathname call from
;             inside of record-source-file until level-1 is loaded.
;9/13/89 gz   Made %unhave pay attention to indirect bit.
;9/11/89 gz   No more %sym-fn-loc, %sym-value-loc.
;             (%cdr (%sym-fn-loc x)) -> fboundp, (%cdr (%sym-value-loc x)) -> %sym-value.
;9/09/89 bill Add beep function. A cheap output-device at boot time.
;09/05/89 gz  proclaim-notspecial
;8/30/89 bill record-source-file: always record methods as methods; old code
;             sometimes recorded them as functions.
;             get-source-files-with-types: added
;8/24/89 gb   Macros aren't on plist anymore, aren't functionp.
;             juggled function binding stuff a bit.
;             Pass vector subtype in arg_y when creating vectors.
;7/25/89 bill expand inherit-from-p to work with clos objects & classes
;7/20/89  gz  moved set-part-color-loop to color.lisp.
;5/19/89  gz  Don't give redefinition warnings for methods.  All this stuff really
;             needs to be redone.
;5/3/89   gz  Moved indirect cell initialization to level-1.lisp
;4/4/89   gz  Moved export, find-package to l1-symhash, purge-functions to misc.
;             Flushed this define-pascal-function.  No more kernel lfuns.
;             watch out for indirect bit in define-constant.  Allow for bignum
;             lfun bits, just in case.  Initialize indirect value/fn cells for
;             kernel.
;03/17/89 as  bootstrap support for color menus, delete, position
;             rassoc moved here from lists
;03/15/89 gb  verify-call-count uses $xtoofew, $xtoomany.
;14-apr-89 as  record-arglist for the sake of defmacro
;03/09/89 gz  symbolic names for lfunish things. lfun bits can be bignums.
;             Bootstrapping record-source-file, require-type.
;	      macro-function.
;7-apr-89  as  %str-cat takes rest arg
;03/03/89 gb  Moved SIMPLE-STRING, here; should rename it.  Added export, find-package.
;02/28/89  gz  Added lfun-name
;02/19/89  gz  removed xx-closure as vector subtypes, added standard-instance.
;              Don't use %uvref/%uvset here.
;02/10/89  gz  Added proclaimed-notinline-p
; 2/15/89  gb  Adjust sp vice add in ASSOC.
; 2/02/89  gb  Handlep.  Damn.
;01/03/89  gz  moved #@ to l1-readloop.
;12/29/88  gb  a5, heap, lfuns. Added KERNEL-FUNCTION-P.
;12/26/88  gz  subtype in array headers.  Float and longword vectors.
;              Added istruct-typep. mark -> buffer-mark. full-namestring -> full-pathname.
;12/16/88  gz flushed %str-mem-bak,%str-member-i,%str-mem-esc,%str-mem-esc-bak
;             Moved get-properties, gentemp, copy-symbol to misc.
;12/13/88 gz  %defvar returns nil if unbound.  Flush redundant cmp.b in %type-of
;12/08/88 gb  try not recording source when defvar re-defined. Right ?
;11/27/88 gz  added eq, eql.
;11/24/88 gz  put record-source-file here!
;11/23/88 gb restore_regs mumbo-jumbo.
;11/19/88 gb  no trampolines in fhave, new functionp, compiled-function-p.
;10/25/88 gb  Moved identity, assoc, member, adjoin here.
;10/23/88 gb  8.9 upload.
; 9/27/88 gz   Mods to point fns to handle bignums. Added %get-point, %put-point.
;              lapified %strip-address.
; 9/22/88 gb   new immediate map in %fhave.
; 9/13/88 gb   nilreg is an address register.
; 9/8/88  gb   no cfp.
; 9/02/88 gz   Use arrayarg subprim in array-data-and-offset. Make macptr a
;              built-in type.
; 8/28/88 gz   added array-data-and-offset, get-sstring, bad-named-arg.
; 8/20/88 gz   #'eq -> 'eq for bootstrapping reasons.
;              Pay attention to compile-time instance variables.
;              Split up proclaim into transformable pieces, err out on bad spec,
;               handle [not]inline differently.
;              Don't incidentally proclaim variables bound.
;              proclaimed-parameter-p checks special as well.
;              Added alist-adjoin.
;              %fhave and %proclaim-special here from level-1.lisp, added %type-of
; 8/17/88 gz   Flushed libfasl.
; 8/18/88 gb   funcallable-instances are functionp.
; 8/16/88 gb   some lap from bindings.a
; 8/2/88  gb   %ptr accessors moved to l1-aprims; introduced some lap.
; 6/27/88 jaj  proclaim instance-variable -> object-variable <list>
; 6/23/88 jaj  #+bccl (%unfhave '%save-application)
; 6/23/88 as   removed %doc-string-file
; 6/9/88  jaj  check for %doc-string-file in %rsc-string
; 6/8/88  jaj  added proclaim ignore, unignore
; 5/20/88 jaj  check for *read-suppress* in #@. init-list-default uses
;              a gensym instead of "the-init-list"
; 5/9/88  jaj  added proclaim instance-variable
; 2/25/88 jaj  %global-to-local and %local-to-global changed to use traps
;              (so that they work with color grafports)

; 7/28/88 gb   %inc-ptr a macro; continue to seek magic incantations for other
;              -ptr accessors.
; 6/02/88 gb   Stop using %sym-plist-loc.  Use kernel (%set-)symbol-plist.
;              Use %symbol-bits.
; 5/20/88 gb   %proclaim-special passes init-p flag.  Added 
;              proclaimed-parameter-p. use %ndefvar to pass init-p flag.
; 3/29/88 gz   New macptr scheme. Removed %pstr-len. Flushed pre-1.0 edit history.
; 2/16/88 jaj  removed %pstr-pointer (now in kernel), %pstr-len simplified
;              (almost gone)
; 1/26/88 cfry I set *save-doc-strings* to T to be CL compatable.
; 10/21/87 jaj redefine-kernel-function only cerrors if sym-pkg is ccl or lisp
; 10/15/87 jaj check for *warn-if-redefine-kernel* in redefine-kernel-function
; 10/15/87 cfry fixed gentemp to be able to take a non-simple string
; 10/14/87 cfry init-list-default changed from a defun to a defmacro
; 10/6/87 gb  function-spec stuff for flavors.
;----------------------------Version 1.0------------------------------

#+allow-in-package
(in-package "CCL")



;The following forms (up thru defn of %DEFUN) must come before any DEFUN's.
;Any (non-kernel) functions must be defined before they're used! 
;In fact, ALL functions must be defined before they're used!  How about that ?



(setq %lisp-system-fixups% nil)

(setq *lfun-names* (make-hash-table :test 'eq :weak t))



(setq *warn-if-redefine-kernel* nil)

(%include "ccl:l1;l1-utils.lisp")   ; record source file etal





(eval-when (:compile-toplevel :execute)
  (defmacro need-use-eql-macro (key)
    (if (ppc-target-p)
    `(let* ((typecode (ppc-typecode ,key)))
       (declare (fixnum typecode))
       (or (= typecode ppc::subtag-macptr)
           (and (>= typecode ppc::min-numeric-subtag)
                (<= typecode ppc::max-numeric-subtag))))
    `(dtagp ,key (logior (ash 1 $t_dfloat) (ash 1 $t_vector)))))
(require "NUMBER-MACROS")
)


;; moved here from l0-utils
(defun pointer-size (macptr)
  (setq macptr (require-type macptr 'macptr))
  (cond (#+carbon-compat (control-handlep macptr) #-carbon-compat nil
         nil)
        ((handlep macptr)
         (#_GetHandleSize  macptr))        
        ((zone-pointerp macptr) (#_GetPtrSize macptr))
        (t nil)))


;; moved here from level-0;ppc-misc
(defun object-in-application-heap-p (address)
  ;; osx-p case is silly here
  (if nil ;(not (osx-p))
    (with-macptrs ((app-zone (#_LMGetApplZone))
                   (app-lim (pref app-zone :zone.bkLim))
                   (address-ptr (%null-ptr)))
      (%setf-macptr-to-object address-ptr address)
      (let ((res
             (and (macptr<= app-zone address-ptr)
                  (macptr<= address-ptr app-lim))))
        res))
    (let ((res
            (and (> address 0)(< address (total-heap-allocated)))))
      res)))

;; for OSX - 
(defun preferred-size-from-size-resource ()
  (let* ((curfile (#_CurResFile))
         (psize 0))
    (unwind-protect
      (progn        
        (#_UseResFile (#_LMGetCurApRefNum))
        (let* ((index (#_count1resources "SIZE")))
          ;(print index)
          (with-macptrs ((h (#_Get1IndResource "SIZE" index)))
            (setq psize
                  (if (%null-ptr-p h)
                    0
                    (progn (#_loadresource h)
                           (%hget-unsigned-long h 2)))))))
      (#_UseResFile curfile))
    psize))

;; this will make ROOM lie! - wont take till reboot - maybe don't really do till quitting time
(defun set-preferred-size-resource (psize)
  (when (<  psize (* 8 1024 1024))(error "Size ~s too small." psize))
  (when (> psize (* 1024 1024 1024)) (error "Size ~s too big." psize))
  (let* ((curfile (#_CurResFile)))
    (unwind-protect
      (progn        
        (#_UseResFile (#_LMGetCurApRefNum))
        (let* ((index (#_count1resources "SIZE")))
          ;(print index)
          (with-macptrs ((h (#_Get1IndResource "SIZE" index)))
                  (if (%null-ptr-p h)
                    (error "Can't find 'SIZE' resource.")
                    (progn (#_loadresource h)
                           (%hput-long h psize 2)
                           (#_changedresource h)
                           (#_writeresource h)
                           (reserrchk))))))
      (#_UseResFile curfile))
    psize))
  


(defun total-heap-allocated ()
  1073000000) ;; keep in sync with kernel

#|
(def-load-pointers whine ()
  (when (osx-p)
    (when (< (total-heap-allocated)(preferred-size-from-size-resource))
      (warn "Requested ~D bytes of heap. Got ~D bytes." (preferred-size-from-size-resource) (total-heap-allocated)))))
|#


#|
;; moved here from level-0;ppc-misc
(defun room (&optional (verbose :default))
  (let* ((freebytes (%freebytes))
         (heapspace (#_FreeMem))  ;; wrong if osx
         )
    (if (not (osx-p))
    (format t "~&There are at least ~:D bytes of available RAM.~%"
            (+ freebytes heapspace)))
    (when verbose
      (multiple-value-bind (usedbytes static-used staticlib-used) (%usedbytes)
        (let* ((lispheap  (+ freebytes usedbytes))
               (static (+ static-used staticlib-used))
               (applzone (if (not (osx-p))(#_LMGetApplZone)))
               (macheap   (- (if (osx-p) (total-heap-allocated) (%get-long applzone))
                             (if (osx-p) 0 (%ptr-to-int applzone))
                             static
                             lispheap)))
          (flet ((k (n) (round n 1024)))
            (princ "
                  Total Size             Free                 Used")
            (if (not (osx-p))
              (format t "~&Mac Heap:  ~12T~10D (~DK)  ~33T~10D (~DK)  ~54T~10D (~DK)"
                      macheap
                      (floor macheap 1024)
                      heapspace
                      (floor heapspace 1024)
                      (- macheap heapspace)
                      (ceiling (- macheap heapspace) 1024))
              (format t "~&Mac Heap:  ~12T Unknown on OSX  ~37T Unknown on OSX  ~56T  Unknown on OSX"
                      ;macheap
                      ;(floor macheap 1024)
                      ;heapspace
                      ;(floor heapspace 1024)
                      ))
            
            (format t "~&Lisp Heap: ~12T~10D (~DK)  ~33T~10D (~DK)  ~54T~10D (~DK)"
                    lispheap (k lispheap)
                    freebytes (k freebytes)
                    usedbytes (k usedbytes))
            (multiple-value-bind (stack-total stack-used stack-free)
                                 (%stack-space)
              (format t "~&Stacks:    ~12T~10D (~DK)  ~33T~10D (~DK)  ~54T~10D (~DK)"
                      stack-total (k stack-total)
                      stack-free (k stack-free)
                      stack-used (k stack-used)))
            (format t "~&Static: ~12T~10D (~DK)  ~33T~10D (~DK) ~54T~10D (~DK)"
                    static (k static)
                    0 0
                    static (k static))
            (unless (eq verbose :default)
              (terpri)
              (dolist (sg-info (%stack-space-by-stack-group))
                (destructuring-bind (sg sp-free sp-used vsp-free vsp-used tsp-free tsp-used)
                                    sg-info
                  (let ((sp-total (+ sp-used sp-free))
                        (vsp-total (+ vsp-used vsp-free))
                        (tsp-total (+ tsp-used tsp-free)))
                    (format t "~%~a~%  cstack:~12T~10D (~DK)  ~33T~10D (~DK)  ~54T~10D (~DK)~
                               ~%  vstack:~12T~10D (~DK)  ~33T~10D (~DK)  ~54T~10D (~DK)~
                               ~%  tstack:~12T~10D (~DK)  ~33T~10D (~DK)  ~54T~10D (~DK)"
                            (sg.name sg)
                            sp-total (k sp-total) sp-free (k sp-free) sp-used (k sp-used)
                            vsp-total (k vsp-total) vsp-free (k vsp-free) vsp-used (k vsp-used)
                            tsp-total (k tsp-total) tsp-free (k tsp-free) tsp-used (k tsp-used)))))))))))
  (values))

|#

(defun room (&optional (verbose :default))
    (let* ((freebytes (%freebytes))
           ;(heapspace (#_FreeMem))  ;; wrong if osx
           (cs "~&~a~12T~10D (~a)~35T~10D (~a)~58T~10D (~a)"))
      (if nil ;(not (osx-p))
        (format t "~&There are at least ~:D bytes of available RAM.~%"
                (+ freebytes heapspace)))
      (when verbose
        (multiple-value-bind (usedbytes static-used staticlib-used) (%usedbytes)
          (let* ((lispheap  (+ freebytes usedbytes))
                 (static (+ static-used staticlib-used))
                 ;(applzone (if (not (osx-p))(#_LMGetApplZone)))
                 #+ignore
                 (macheap   (- (if (osx-p) (total-heap-allocated) (%get-long applzone))
                               (if (osx-p) 0 (%ptr-to-int applzone))
                               static
                               lispheap)))
            (flet ((k (n) (let ((k (round n 1024)))
                            (cond ((<= k (*   1 1024)) (format nil "~d kB" k))              ; < 1 MB show as kB
                                  ((<= k (*  10 1024)) (format nil "~,3f MB" (/ k 1024.0))) ; < 10 MB
                                  ((<= k (* 100 1024)) (format nil "~,2f MB" (/ k 1024.0))) ; < 100 MB
                                  (t (format nil "~,1f MB" (/ k 1024.0)))))))               ; > 100 MB
              
              (princ "
                 Total Size                Free                   Used")
              #+ignore
              (if nil ;(not (osx-p))
                (format t "~&Mac Heap:  ~12T~10D (~Dk)  ~35T~10D (~Dk)  ~58T~10D (~Dk)"
                        macheap
                        (floor macheap 1024)
                        heapspace
                        (floor heapspace 1024)
                        (- macheap heapspace)
                        (ceiling (- macheap heapspace) 1024))
                (format t "~&Mac Heap:  ~12T   Unknown on OSX  ~35T   Unknown on OSX  ~58T   Unknown on OSX"))
              (format t cs "Lisp Heap: "
                      lispheap (k lispheap)
                      freebytes (k freebytes)
                      usedbytes (k usedbytes))
              (multiple-value-bind (stack-total stack-used stack-free)
                                   (%stack-space)
                (format t cs "Stacks:    "
                        stack-total (k stack-total)
                        stack-free (k stack-free)
                        stack-used (k stack-used)))
              (format t cs "Static: "
                      static (k static)
                      0 0
                      static (k static))
              (unless (eq verbose :default)
                (terpri)
                (dolist (sg-info (%stack-space-by-stack-group))
                  (destructuring-bind (sg sp-free sp-used vsp-free vsp-used tsp-free tsp-used)
                                      sg-info
                    (let ((sp-total (+ sp-used sp-free))
                          (vsp-total (+ vsp-used vsp-free))
                          (tsp-total (+ tsp-used tsp-free)))
                      (format t "~%~a~%" (sg.name sg))
                      (format t cs "  cstack:"  sp-total  (k sp-total)  sp-free  (k sp-free)  sp-used (k sp-used))
                      (format t cs "  vstack:" vsp-total (k vsp-total) vsp-free (k vsp-free) vsp-used (k vsp-used))
                      (format t cs "  tstack:" tsp-total (k tsp-total) tsp-free (k tsp-free) tsp-used (k tsp-used))
                      (format t "~%"))))))))))
    (values))



(defun loading-file-source-file ()
  *loading-file-source-file*)

(setq *save-local-symbols* t)

(%fhave 'require-type (nfunction bootstrapping-require-type
                                 (lambda (thing type)
                                   (declare (ignore type))
                                   thing)))
(%fhave '%require-type 
        (nfunction bootstrapping-%require-type
                   (lambda (thing predicate)
                     (declare (ignore predicate))
                     thing)))

(setf (type-predicate 'macptr) 'macptrp)

(defun null-or-handlep (arg)
  (and (macptrp arg)
       (or (%null-ptr-p arg)
           (handlep arg))))

(defun require-null-or-handlep (arg)
  (if (null-or-handlep arg)
    arg
    (require-type arg '(satisfies null-or-handlep))))


(%fhave 'set-macro-function #'%macro-have)   ; redefined in sysutils.

; Define special forms.
(dolist (sym '(block catch compiler-let #|declare|# eval-when
               flet function go if labels let let* macrolet
               multiple-value-call multiple-value-prog1
               progn progv quote return-from setq tagbody
               the throw unwind-protect locally load-time-value
; These are implementation-specific special forms :
	       nfunction without-interrupts
               macro-bind debind symbol-macrolet lap lap-inline
               old-lap old-lap-inline new-lap %vreflet
               fbind new-lap-inline ppc-lap-function))
  (%macro-have sym sym))



(locally (declare (special *fred-special-indent-alist*))
   (setq *fred-special-indent-alist* nil))
  
(defun %macro (named-fn &optional doc &aux body-pos arglist)
  ; "doc" is either a string or a list of the form :
  ; (doc-string-or-nil . (body-pos-or-nil . arglist-or-nil))
  (if (listp doc)
    (setq body-pos (cadr doc)
          arglist (cddr doc)
          doc (car doc)))
  (let* ((name (function-name named-fn)))
    (record-source-file name 'function)
    (set-macro-function name named-fn)
    (when (and doc *save-doc-strings*)
      (set-documentation name 'function doc))
    (when body-pos
      (setf (assq name *fred-special-indent-alist*) body-pos))
    (when arglist
      (record-arglist name arglist))
    (when *fasload-print* (format t "~&~S~%" name))
    name))

(defun %define-symbol-macro (name expansion)
  (let ()
    ;; check for special - should do vv too
    (when (or (nx-proclaimed-special-p name)(constantp name))
      ;; what to do here - should just warn and remove old def info??
      (cerror "Symbol macro will be ignored." 
                (make-program-error "Can't define symbol macro for special variable or constant ~S ." name))
      (return-from %define-symbol-macro nil))
    (record-source-file name 'symbol-macro)
    (let ((var (find name *nx-symbol-macros* :Key #'(lambda (x)(var-name x)))))
      (if var 
        (setf (var-ea var)(cons :symbol-macro expansion))
        (progn (setq var (make-symbol-macro-info name expansion))
               (push var *nx-symbol-macros*)))
      name)))

(defun %define-compile-time-symbol-macro (name expansion env)  
  (let ()   
    ;; check for special - should do vv too
    (let ((*nx-lexical-environment* env))
      (when (nx-proclaimed-parameter-p name)  ;; looks for specials and constants, global or in env
        (cerror "Symbol macro will be ignored." 
                (make-program-error "Can't define symbol macro for special variable or constant ~S ." name))
        (return-from %define-compile-time-symbol-macro nil)))
    (push (make-symbol-macro-info name expansion) *compile-time-symbol-macros*)
    name))


#|
(defun find-global-symbol-macro (form)
  (or 
   (find form *compile-time-symbol-macros* :key
         #'(lambda (x)(var-name x)))
   (find form *nx-symbol-macros* :key
         #'(lambda (x)(var-name x)))))
|#

(defun find-global-symbol-macro (form)
  (find form *nx-symbol-macros* :key
        #'(lambda (x)(var-name x))))

(defun find-compile-time-symbol-macro (form)
  (find form *compile-time-symbol-macros* :key
         #'(lambda (x)(var-name x))))

(defun find-compile-time-or-global-symbol-macro (form)
  (let ((var (find-compile-time-symbol-macro form)))
    (if var (values var t)
      (values (find-global-symbol-macro form) nil))))
  

(defun find-global-symbol-macro-def (form)
  (let ((var (find-global-symbol-macro form)))
    (if var (values (cdr (var-ea var)) t))))

(defun find-compile-time-or-global-symbol-macro-def (form)
  (let ((var (find-compile-time-or-global-symbol-macro form)))
    (if var (cdr (var-ea var)))))

#+ignore                                ; moved to "ccl:level-0;l0-symbol.lisp"
(defun boundp (sym)
  (not (eq (%sym-value sym) (%unbound-marker)))) ; undefinedp


(defun %defvar (var &optional doc)
  "Returns boundp"
  (%proclaim-special var)
  (record-source-file var 'variable)
  (when (and doc *save-doc-strings*)
    (set-documentation var 'variable doc))
  (cond ((not (boundp var))
         (when *fasload-print* (format t "~&~S~%" var))
         nil)
        (t t)))

(defun %defparameter (var value &optional doc)
  (%proclaim-special var)
  (record-source-file var 'variable)
  (when (and doc *save-doc-strings*)
    (set-documentation var 'variable doc))
  (when *fasload-print* (format t "~&~S~%" var))
  (set var value)
  var)

(defun %defglobal (var value &optional doc)
  (%symbol-bits var (logior (ash 1 $sym_vbit_global) (the fixnum (%symbol-bits var))))
  (%defparameter var value doc))

;Needed early for member etc.
#-ppc-target (defun eq (x y) (eq x y))          ; in level-0 on PPC
#-ppc-target (defun eql (x y) (eql x y))        ; in level-0 on PPC.
(defun identity (x) x)

(%fhave 'find-unencapsulated-definition #'identity)

(defun coerce-to-function (arg)
  (if (functionp arg)
    arg
    (if (symbolp arg)
      (%function arg)
      (report-bad-arg arg 'function))))

; takes arguments in arg_x, arg_y, arg_z, returns "multiple values" 
; Test(-not) arguments are NOT validated beyond what is done
; here.
; if both :test and :test-not supplied, signal error.
; if test provided as #'eq or 'eq, return first value 'eq.
; if test defaulted, provided as 'eql, or provided as #'eql, return first value 'eql.
; if test-not provided as 'eql or provided as #'eql, return second value 'eql.
; if key provided as either 'identity or #'identity, return third value nil.
(defun %key-conflict (test-fn test-not-fn key)
  (let* ((eqfn #'eq)
         (eqlfn #'eql)
         (idfn #'identity))
    (if (or (eq key 'identity) (eq key idfn))
      (setq key nil))
    (if test-fn
      (if test-not-fn
        (%err-disp $xkeyconflict ':test test-fn ':test-not test-not-fn)
        (if (eq test-fn eqfn)
          (values 'eq nil key)
          (if (eq test-fn eqlfn)
            (values 'eql nil key)
            (values test-fn nil key))))
      (if test-not-fn
        (if (eq test-not-fn eqfn)
          (values nil 'eq key)
          (if (eq test-not-fn eqlfn)
            (values nil 'eql key)
            (values nil test-not-fn key)))
        (values 'eql nil key)))))




;;; Assoc.

; (asseql item list) <=> (assoc item list :test #'eql :key #'identity)

(defun asseql (item list)
  (when (not (listp list))(setq list (%kernel-restart $xwrongtype list 'list)))
  (locally (declare (list list))
    (if (need-use-eql-macro item)
      (dolist (pair list)
        (if (and pair (eql item (car pair)))
          (return pair)))
      (dolist (pair list)        
        (when (and pair (eq item (car pair)))
          (return pair))))))

; (assoc-test item list test-fn) 
;   <=> 
;     (assoc item list :test test-fn :key #'identity)
; test-fn may not be FUNCTIONP, so we coerce it here.
(defun assoc-test (item list test-fn)
  (dolist (pair list)
    (if (and pair (funcall test-fn item (car pair)))
      (return pair))))



; (assoc-test-not item list test-not-fn) 
;   <=> 
;     (assoc item list :test-not test-not-fn :key #'identity)
; test-not-fn may not be FUNCTIONP, so we coerce it here.
(defun assoc-test-not (item list test-not-fn)
  (dolist (pair list)
    (if (and pair (not (funcall test-not-fn item (car pair))))
      (return pair))))

(defun assoc (item list &key test test-not key)
  (multiple-value-bind (test test-not key) (%key-conflict test test-not key)
    (if (null key)
      (if (eq test 'eq)
        (assq item list)
        (if (eq test 'eql)
          (asseql item list)
          (if test
            (assoc-test item list test)
            (assoc-test-not item list test-not))))
      (if test
        (dolist (pair list)
          (when pair
            (if (funcall test item (funcall key (car pair)))
              (return pair))))
        (dolist (pair list)
          (when pair
            (unless (funcall test-not item (funcall key (car pair)))
              (return pair))))))))


;;;; Member.

; (memeql item list) <=> (member item list :test #'eql :key #'identity)

#|
;nil or error - supposed to error if not proper list?
(defun memeql (item list)
  (when (not (listp list))(setq list (%kernel-restart $xwrongtype list 'list)))
  (if (need-use-eql-macro item)
    (do* ((l list (cdr l)))
         ((null l))
      (when (eql (%car l) item) (return l)))
    (do* ((tail list (cdr tail)))
         ((null tail))
      (if (eq item (%car tail))
        (return tail)))))
|#

(defun memeql (item list)  
  (when (not (listp list))(setq list (%kernel-restart $xwrongtype list 'list)))
  (if (need-use-eql-macro item)
    (do* ((l list (%cdr l)))                ;Was CDR
         ((null l))
      (when (eql (car l) item) (return l))) ;Was %CAR
    (do* ((tail list (%cdr tail)))          ;Was CDR
         ((null tail))
      (if (eq item (car tail))              ;Was %CAR
        (return tail)))))

; (member-test item list test-fn) 
;   <=> 
;     (member item list :test test-fn :key #'identity)
(defun member-test (item list test-fn)
  (if (or (eq test-fn 'eq)(eq test-fn  #'eq)
          (and (or (eq test-fn 'eql)(eq test-fn  #'eql))
               (not (need-use-eql-macro item))))
    (do* ((l list (cdr l)))
         ((null l))
      (when (eq item (car l))(return l)))
    (if (or (eq test-fn 'eql)(eq test-fn  #'eql))
      (do* ((l list (cdr l)))
           ((null l))
        (when (eql item (car l))(return l)))    
      (do* ((l list (cdr l)))
           ((null l))
        (when (funcall test-fn item (car l)) (return l))))))


; (member-test-not item list test-not-fn) 
;   <=> 
;     (member item list :test-not test-not-fn :key #'identity)
(defun member-test-not (item list test-not-fn)
  (do* ((l list (cdr l)))
       ((null l))
    (unless (funcall test-not-fn item (car l)) (return l))))

(defun member (item list &key test test-not key)
  (multiple-value-bind (test test-not key) (%key-conflict test test-not key)
    (if (null key)
      (if (eq test 'eq)
        (memq item list)
        (if (eq test 'eql)
          (memeql item list)
          (if test
            (member-test item list test)
            (member-test-not item list test-not))))
      (if test
        (do* ((l list (cdr l)))
             ((null l))
          (if (funcall test item (funcall key (car l)))
              (return l)))
        (do* ((l list (cdr l)))
             ((null l))
          (unless (funcall test-not item (funcall key (car l)))
              (return l)))))))

(defun adjoin (item list &key test test-not key)
  (if (and (not test)(not test-not)(not key))
    (if (not (memeql item list))(cons item list) list)
    (multiple-value-bind (test test-not key) (%key-conflict test test-not key)
      (if
        (if (null key)
          (if (eq test 'eq)
            (memq item list)
            (if (eq test 'eql)
              (memeql item list)
              (if test
                (member-test item list test)
                (member-test-not item list test-not))))
          (if test
            (member (funcall key item) list :test test :key key)
            (member (funcall key item) list :test-not test-not :key key)))
        list
        (cons item list)))))

(defun adjoin-eq (elt list)
  (if (memq elt list)
    list
    (cons elt list)))

(defun adjoin-eql (elt list)
  (if (memeql elt list)
    list
    (cons elt list)))

(defun union-eq (list1 list2)
  (let ((res list2))
    (dolist (elt list1)
      (unless (memq elt res)
        (push elt res)))
    res))

(defun union-eql (list1 list2)
  (let ((res list2))
    (dolist (elt list1)
      (unless (memeql elt res)
        (push elt res)))
    res))

; Fix this someday.  Fix EQUALP, while you're at it ...
(defun similar-as-constants-p (x y)
  (or (eq x y)                          ; Redefinition of constants to themselves.
      (if (and (stringp x) (stringp y)) ;The most obvious case where equalp & s-a-c-p need to differ...
        (string= x y)
        (if (and (numberp x)(numberp y))  ;; was floatp
          (equal x y)
          (equalp x y)))))

(defun define-constant (var value)
  (block nil
    (if (constant-symbol-p var)
      (if (similar-as-constants-p (%sym-value var) value)
        (return)
        ;This should really be a cell error, allow options other than redefining (such
        ; as don't redefine and continue)...
        (cerror "Redefine ~S anyway"
                "Constant ~S is already defined with a different value"
                var)))
    (%symbol-bits var 
                  (%ilogior (%ilsl $sym_bit_special 1) (%ilsl $sym_bit_const 1)
                            (%symbol-bits var)))
    (%set-sym-value var value))
  var)

(defun %defconstant (var value &optional doc)  
  (%proclaim-special var)
  (record-source-file var 'constant)
  (define-constant var value)
  (when (and doc *save-doc-strings*)
    (set-documentation var 'variable doc))
  (when *fasload-print* (format t "~&~S~%" var))
  var)

(defparameter *nx1-compiler-special-forms* ())
(defparameter *nx-proclaimed-types* ())
(defparameter *nx-proclaimed-ftypes* nil)

(defun compiler-special-form-p (sym)
  (or (eq sym 'quote)
      (if (memq sym *nx1-compiler-special-forms*) t)))

(defun evaluator-special-form-p (sym)
  (declare (ignore sym))
 '(get sym 'special-in-evaluator)
 nil)

(defparameter *nx-known-declarations* ())
(defparameter *nx-proclaimed-inline* ())
(defparameter *nx-proclaimed-ignore* ())
(defparameter *nx-globally-inline* ())



(defconstant *cl-types* '(
array
atom
base-character 
bignum
bit
bit-vector 
character
#|
lisp:common
|#
compiled-function 
complex 
cons                    
double-float
extended-character
fixnum
float
function
hash-table
integer
keyword
list 
long-float
nil 
null
number  
package
pathname 
random-state  
ratio
rational
readtable
real
sequence 
short-float
signed-byte 
simple-array
simple-bit-vector
simple-string 
simple-base-string
simple-extended-string 
simple-vector 
single-float
standard-char
stream  
string
#|
lisp:string-char
|#
symbol
t
unsigned-byte 
vector
))

(defun proclaim (spec)
  (case (car spec)
    (special (apply #'proclaim-special (%cdr spec)))
    (notspecial (apply #'proclaim-notspecial (%cdr spec)))
    (optimize (%proclaim-optimize (%cdr spec)))
    (inline (apply #'proclaim-inline t (%cdr spec)))
    (notinline (apply #'proclaim-inline nil (%cdr spec)))
    (declaration (apply #'proclaim-declaration (%cdr spec)))
    (ignore (apply #'proclaim-ignore t (%cdr spec)))
    (unignore (apply #'proclaim-ignore nil (%cdr spec)))
    (type (apply #'proclaim-type (%cdr spec)))
    (ftype (apply #'proclaim-ftype (%cdr spec)))
    ;(function (proclaim-ftype (cons 'function (cddr spec)) (cadr spec)))
    (t (unless (memq (%car spec) *nx-known-declarations*) ;not really right...
         (if (type-specifier-p (%car spec)) ;(memq (%car spec) *cl-types*)
           (apply #'proclaim-type spec)
           (warn "Unknown declaration specifier(s) in ~S" spec))))))

(defun proclaim-type (type &rest vars)
  (declare (dynamic-extent vars))
  (dolist (var vars)
    (if (symbolp var)
      (let ((spec (assq var *nx-proclaimed-types*)))
        (if spec
          (rplacd spec type)
          (push (cons var type) *nx-proclaimed-types*)))
      (warn "Invalid type declaration for ~S" var))))

#| redefined from nfcomp
(defun proclaim-ftype (type &rest names)
  (declare (ignore type names))
  ;remember to accept (setf name)'s when implement this.
  nil)
|#

(defun proclaim-ftype (ftype &rest names)
  (declare (dynamic-extent names))
  (unless *nx-proclaimed-ftypes*
    (setq *nx-proclaimed-ftypes* (make-hash-table :test #'eq)))
  (dolist (name names)
    (setf (gethash (ensure-valid-function-name name) *nx-proclaimed-ftypes*) ftype)))

(defun proclaimed-ftype (name)
  (when *nx-proclaimed-ftypes*
    (gethash (ensure-valid-function-name name) *nx-proclaimed-ftypes*)))

(defun proclaim-special (&rest vars)
  (declare (dynamic-extent vars))
  (dolist (sym vars) (%proclaim-special sym)))

(defun proclaim-notspecial (&rest vars)
  (declare (dynamic-extent vars))
  (dolist (sym vars) (%proclaim-notspecial sym)))

(defun proclaim-inline (t-or-nil &rest names)
  (declare (dynamic-extent names))
  ;This is just to make it more likely to detect forgetting about the first arg...
  (unless (or (eq nil t-or-nil) (eq t t-or-nil)) (report-bad-arg t-or-nil '(member t nil)))
  (dolist (name names)
    (setq name (ensure-valid-function-name name))
    (if (listp *nx-proclaimed-inline*)
      (setq *nx-proclaimed-inline*
          (alist-adjoin name
                        (or t-or-nil (if (compiler-special-form-p name) t))
                        *nx-proclaimed-inline*))      
      (setf (gethash name *nx-proclaimed-inline*)
            (or t-or-nil (if (compiler-special-form-p name) t))))))

(defun proclaim-declaration (&rest syms)
  (declare (dynamic-extent syms))
  (dolist (sym syms)
    (setq *nx-known-declarations* 
          (adjoin sym *nx-known-declarations* :test 'eq))))

(defun proclaim-ignore (t-or-nil &rest syms)
  (declare (dynamic-extent syms))
  ;This is just to make it more likely to detect forgetting about the first arg...
  (unless (or (eq nil t-or-nil) (eq t t-or-nil)) (report-bad-arg t-or-nil '(member t nil)))
  (dolist (sym syms)
    (setq *nx-proclaimed-ignore*
          (alist-adjoin sym t-or-nil *nx-proclaimed-ignore*))))

(queue-fixup
 (when (listp *nx-proclaimed-inline*)
  (let ((table (make-hash-table :size 100 :test #'eq)))
    (dolist (x *nx-proclaimed-inline*)
      (let ((name (car x)) (value (cdr x)))
        (when (symbolp name)
          (setf (gethash name table) value))))
    (setq *nx-proclaimed-inline* table))))

(defun proclaimed-special-p (sym)
  (%ilogbitp $sym_vbit_special (%symbol-bits sym)))

(defun proclaimed-inline-p (sym)
  (if (listp *nx-proclaimed-inline*)
    (%cdr (assq sym *nx-proclaimed-inline*))
    (gethash sym *nx-proclaimed-inline*)))

(defun proclaimed-notinline-p (sym)
  (if (listp *nx-proclaimed-inline*)
    (and (setq sym (assq sym *nx-proclaimed-inline*))
         (null (%cdr sym)))
    (null (gethash sym *nx-proclaimed-inline* t))))



(defun self-evaluating-p (form)
;   (or (numberp form)
;       (characterp form)
;       (null form)
;       (eq form t)
;       (keywordp form)
;       (arrayp form) ; making the following redundant
;       ;(stringp form)
;       ;(bit-vector-p form)
;       )
  (and (atom form)
       (or (not (non-nil-symbol-p form))
           (eq form t)
           (keywordp form)))
  )

#|
(defun constantp (form &optional env)
  (or (self-evaluating-p form)
      (quoted-form-p form)
      (constant-symbol-p form)
      (when (and env (symbolp form))
        (let ((defenv (definition-environment env)))
          (when defenv            
            (not (null (assq form (defenv.constants env)))))))))
|#

;; patch: (defenv.constants env) -> (defenv.constants defenv)
(defun constantp (form &optional env)
  (or (self-evaluating-p form)
      (quoted-form-p form)
      (constant-symbol-p form)
      (when (and env (symbolp form))
        (let ((defenv (definition-environment env)))
          (when defenv            
            (not (null (assq form (defenv.constants defenv)))))))))


(defun eval-constant (form)
  (if (quoted-form-p form) (%cadr form)
      (if (constant-symbol-p form) (symbol-value form)
          (if (self-evaluating-p form) form
              (report-bad-arg form '(satsifies constantp))))))

; SETQ'd above before we could DEFVAR.
(defvar *fred-special-indent-alist*)
; avoid hanging onto beezillions of pathnames
(defvar *last-back-translated-name* nil)
(defvar *default-character-type* 'extended-character)  ; god help you if you change this - well I did
(defvar *lfun-names*)
(defvar *compile-time-symbol-macros* nil)

(defvar %lambda-lists% ())


(%fhave 'record-arglist
        (qlfun bootstrapping-record-arglist (name args)
          "only used by defmacro"
          ; Bootstrapping: always save macro arglists, nuke-em before saving released image.
            (let ((pair (assq name %lambda-lists%)))
              (if pair
                (rplacd pair args)
                (push (cons name args) %lambda-lists%))
              args)))

;Support the simple case of defsetf.
(%fhave 'store-setf-method
        (qlfun bootstrapping-store-setf-method (name fn &optional doc)
          (declare (ignore doc))
          (put name 'bootstrapping-setf-method (require-type fn 'symbol))))
(%fhave '%setf-method
        (qlfun bootstrapping-%setf-method (name)
          (get name 'bootstrapping-setf-method)))

#-ppc-target (%fhave 'symbolp #'(lambda (x) (symbolp x)))
(%fhave 'function-spec-p #'symbolp)     ; redefined later


;;; Lisp Development System/Application Module Loading

(defvar *lds* t
  "True to load all Lisp Development System modules")
(defvar *app-optional-modules* nil
  "Optional modules to load into application and keys to control contents")
(defvar *app-modules* nil
  "Custom modules to load into application")

#| *app-modules* keys:
:unbind-macros
:unintern-macros
:unbind-constants
:unintern-constants
:clear-vars
|#

; (lds <lds-form>)
; (lds <lds-form> <else-form> ...)
; (lds <lds-form> :module <module(s)>)
; (lds <lds-form> :module <module(s)> <else-form> ...)

(defmacro lds (form &rest base-forms &aux modules)
  (when (eq (first base-forms) :module)
    (setq modules (second base-forms)
          base-forms (cddr base-forms)))
  `(if ,(if (null modules)
          '*lds*
          `(or *lds* (,(if (listp modules) 'intersection 'memq)
                      ',modules *app-modules*)))
     ,form
     ,@(if base-forms `((progn ,@base-forms)))))

(defun lds-key-aux (test keys forms)
  `(,test (,(if (listp keys) 'intersection 'memq)
           ',keys *app-modules*)
          ,@forms))

(defmacro lds-key (keys &rest forms)
  (lds-key-aux 'when keys forms))

(defmacro lds-not-key (keys &rest forms)
  (lds-key-aux 'unless keys forms))

#| tests
(lds (print "included"))
(lds (print "included")
     (print "other") (print "another"))
(lds (print "included") :module :eval)
(lds (print "included") :module :eval
     (print "other") (print "another"))
(lds (print "included") :module (:eval :compiler))
(lds (print "included") :module (:eval :compiler)
     (print "other") (print "another"))

(setq *lds* nil)
(setq *lds* t)
(setq *app-modules* nil)
(setq *app-modules* '(:eval))
(setq *app-modules* '(:compiler))

(lds-key :uno (foo))
(lds-key :uno (foo)(bar))
(lds-key (:uno :dos) (foo))
(lds-key (:uno :dos) (foo) (bar))
(lds-not-key :uno (foo))
(lds-not-key :uno (foo) (bar))
(lds-not-key (:uno :dos) (foo))
(lds-not-key (:uno :dos) (foo) (bar))
|#


; defmacro uses (setf (assq ...) ...) for &body forms.
(defun adjoin-assq (indicator alist value)
  (let ((cell (assq indicator alist)))
    (if cell 
      (setf (cdr cell) value)
      (push (cons indicator value) alist)))
  alist)

(defmacro setf-assq (indicator place value)
  (let ((res (gensym)))
    `(let (,res)
       (setf ,place (adjoin-assq ,indicator ,place (setq ,res ,value)))
       ,res)))

(defsetf assq setf-assq)
(defsetf %typed-miscref %typed-miscset)

(defun quoted-form-p (form)
   (and (consp form)
        (eq (%car form) 'quote)
        (consp (%cdr form))
        (null (%cdr (%cdr form)))))

(defun lambda-expression-p (form)
  (and (consp form)
       (eq (%car form) 'lambda)
       (consp (%cdr form))
       (listp (%cadr form))))

;;;;;FUNCTION BINDING Functions

; A symbol's entrypoint contains:
;  1) something tagged as $t_lfun if the symbol is
;     not fbound as a macro or special form;
;  2) a cons, otherwise, where the cdr is a fixnum
;     whose value happens to be the same bit-pattern
;     as a "jsr_subprim $sp-apply-macro" instruction.
;     The car of this cons is either:
;     a) a function -> macro-function;
;     b) a symbol: special form not redefined as a macro.
;     c) a cons whose car is a function -> macro function defined
;        on a special form.


(defun macro-function (form &optional env)
  (setq form (require-type form 'symbol))
  (when env
    ; A definition-environment isn't a lexical environment, but it can
    ; be an ancestor of one.
    (unless (istruct-typep env 'lexical-environment)
        (report-bad-arg env 'lexical-environment))
      (let ((cell nil))
        (tagbody
          top
          (if (setq cell (%cdr (assq form (lexenv.functions env))))
            (return-from macro-function 
              (if (eq (car cell) 'macro) (%cdr cell))))
          (unless (listp (setq env (lexenv.parent-env env)))
            (go top)))))
      ; Not found in env, look in function cell.
  (%global-macro-function form))

(defun symbol-function (name)
  "Returns the definition of name, even if it is a macro or a special form.
   Errors if name doesn't have a definition."
  (or (fboundp name) ;Our fboundp returns the binding
      (prog1 (%err-disp $xfunbnd name))))

(%fhave 'fdefinition #'symbol-function)


(defun kernel-function-p (f)
  (declare (ignore f))
  nil)

(defun %make-function (name fn env)
  (let ((compile-it *compile-definitions*))
    (when (and compile-it (neq compile-it t))
      (setq compile-it (funcall compile-it env)))
    (if (not compile-it)
      ; bad things will probably occur if env contains unmunched function bindings
      ; but enclose says the behavior in that case is "undefined"
      (make-evaluated-function name fn env)
      (compile-user-function fn name env))))
    
;;;;;;;;; VAULE BIDNING Functions

(defun gensym (&optional (string-or-integer nil supp))
  "Behaves just like Common Lisp. Imagine that."
  (let ((prefix "G")
        (counter nil))
    (if (integerp string-or-integer)
      (setq counter string-or-integer) ; & emit-style-warning
      (if (stringp string-or-integer)
        (setq prefix (ensure-simple-string string-or-integer))
        (if (or string-or-integer supp) ;not string or index or NIL
          (report-bad-arg string-or-integer '(or string integer #|(eql nil)|#)))))
    (unless counter
      (setq *gensym-counter* (1+ (setq counter *gensym-counter*))))
    (make-symbol (%str-cat prefix (%integer-to-string counter)))))

(defun make-keyword (name)
  (if (and (symbolp name) (eq (symbol-package name) *keyword-package*))
    name
    (values (intern (string name) *keyword-package*))))




; destructive, removes first match only
(defun remove-from-alist (thing alist)
 (let ((start alist))
  (if (eq thing (%caar alist))
   (%cdr alist)
   (let* ((prev start)
          (this (%cdr prev))
          (next (%cdr this)))
    (while this
     (if (eq thing (%caar this))
      (progn
       (%rplacd prev next)
       (return-from remove-from-alist start))
      (setq prev this
            this next
            next (%cdr next))))
    start))))

;destructive
(defun add-to-alist (thing val alist &aux (pair (assq thing alist)))
  (if pair
    (progn (%rplacd pair thing) alist)
    (cons (cons thing val) alist)))

;non-destructive...
(defun alist-adjoin (thing val alist &aux (pair (assq thing alist)))
  (if (and pair (eq (%cdr pair) val))
    alist
    (cons (cons thing val) alist)))

(defun %str-assoc (str alist)
  (assoc str alist :test #'string-equal))

; what if this is the first byte of some 2 byte char in some script?
(defvar *pathname-escape-character* #\266
  "Not CL.  A Coral addition for compatibility between CL spec and the Mac.
   The initial value for this variable is the character with ascii number 182,
   made by the option-d key, or with the form #\266.
   Inspired by mpw's use of this character as escape.")

(defun caar (x)
 (car (car x)))

(defun cadr (x)
 (car (cdr x)))

(defun cdar (x)
 (cdr (car x)))

(defun cddr (x)
 (cdr (cdr x)))

(defun caaar (x)
 (car (car (car x))))

(defun caadr (x)
 (car (car (cdr x))))

(defun cadar (x)
 (car (cdr (car x))))

(defun caddr (x)
 (car (cdr (cdr x))))

(defun cdaar (x)
 (cdr (car (car x))))

(defun cdadr (x)
 (cdr (car (cdr x))))

(defun cddar (x)
 (cdr (cdr (car x))))

(defun cdddr (x)
 (cdr (cdr (cdr x))))

(defun cadddr (x)
 (car (cdr (cdr (cdr x)))))

(%fhave 'type-of #'%type-of)

(defun handle-locked-p (h)
   (%ilogbitp 7 (#_HGetState h)))


(defun %global-to-local (Port point)  ;; port sb a wptr
  (%stack-block ((pt 4))
    (%put-point pt point)
    (with-port port  ;; with-port takes a wptr
      (#_GlobalToLocal pt))
    (%get-point pt)))

(defun %local-to-global (port point)
  (%stack-block ((pt 4))
    (%put-point pt point)
    (with-port port
      (#_LocalToGlobal pt))
    (%get-point pt)))

(defun cpu-number ()
  "Returns the cpu number, ie 68000, 68020, ..."
  (let* ((new-processor (gestalt #$gestaltNativeCPUtype)))
    (if (and new-processor (logbitp 8 new-processor))
      (+ 600 (logand #xff new-processor))
      (+ 68000 (* (#_LMGetCpuFlag) 10)))))


(defun pointerp (thing &optional errorp)
  (if (and (macptrp thing)
           ;; or perhaps use macptr<=
           #+ignore
           (with-macptrs ((mystery (#_LMGetbufptr))) ;; #xffffffff on osx  so pointerp always true of any macptr
                 (macptr<= thing mystery)))
           ;(> (%ptr-to-int (#_LMGetBufPtr)) (%ptr-to-int thing)))
      t
      (if errorp (error "~S is not a pointer" thing) nil)))

(defun zone-pointerp (thing &aux (flags-offset #+ppc-target -12 #-ppc-target (if (%ilogbitp 7 (%get-byte (%currentA5) $memflags)) -12 -8)))
  (declare (ignore-if-unused flags-offset))
  (when (macptrp thing)
    (with-macptrs ((bigger (%int-to-ptr #x2000)))
      (and (macptr-evenp thing)
           (not (macptr< thing bigger))
           (NOT (or (#_isvalidwindowptr thing)  ;; and what else?
                    (#_isvalidport thing)))
           (macptr< thing *ram-size-macptr*)))))


;; ignore sys zone if osx - still won't work if getapplzone disappears - she stays in Carbon, goes in OSX
;; could also ignore zones entirely ? in which case would be true for tempnewhandle, and why not
#|
(defun handlep (p)
  (when (and (macptrp p)(#_isvalidcontrolhandle p))
    (return-from handlep t))
  (and (macptrp p)
       (macptr-evenp p)
       (if nil ;(osx-p)
         (neq 0 (#_gethandlesize p)) ;; ??? - can crash
         (flet ((%ptr-in-zone-p (p zone lim)
                  (declare (type macptr p zone lim))
                  (and (macptr<= zone p) (macptr< p lim))))
           (declare (inline %ptr-in-zone-p))
           (flet ((%handle-in-zone-p (p zone lim sys-p)
                    (declare (type macptr p zone lim))
                    (with-macptrs ((ptr (%get-ptr p)))
                      (and (if nil #|(not (osx-p))|# (macptr-evenp ptr) t)
                           (%ptr-in-zone-p ptr zone lim)
                           (if sys-p
                             (and (> 0 (the fixnum (%get-signed-byte ptr -12)))
                                  (eql p (%setf-macptr ptr (%inc-ptr zone (%get-long ptr -4)))))
                             ;(eql p (%setf-macptr ptr (#_RecoverHandleSys ptr)))  ;; oh foo - this is in interfacelib
                             (eql p (%setf-macptr ptr (#_RecoverHandle ptr))))))))
             (declare (inline %handle-in-zone-p))
             (if nil ; (not (osx-p))             
               (with-macptrs ((app-zone (#_LMGetApplZone))
                              (app-lim (pref app-zone :zone.bkLim)))
                 (if (%ptr-in-zone-p p app-zone app-lim)
                   (%handle-in-zone-p p app-zone app-lim nil)
                   (with-macptrs ((sys-zone (#_LMGetSysZone))
                                  (sys-lim (pref sys-zone :zone.bkLim)))
                     (and (%ptr-in-zone-p p sys-zone sys-lim)
                          (%handle-in-zone-p p sys-zone sys-lim t)))))
               ;(#_ishandlevalid p)
              ; #+ignore
               (with-macptrs ((app-zone (%int-to-ptr #x2000))  ;; guessing
                              (app-lim *ram-size-macptr*))
                 (if (%ptr-in-zone-p p app-zone app-lim)
                   (%handle-in-zone-p p app-zone app-lim nil)
                   ))))))))
|#

(defun handlep (p)
  (when (macptrp p)
   (or 
    (#_isvalidcontrolhandle p)
    (and     
     (macptr-evenp p)       
     (flet ((%ptr-in-zone-p (p zone lim)
              (declare (type macptr p zone lim))
              (and (macptr<= zone p) (macptr< p lim))))
       (declare (inline %ptr-in-zone-p))
       (flet ((%handle-in-zone-p (p zone lim)
                (declare (type macptr p zone lim))
                (with-macptrs ((ptr (%get-ptr p)))
                  (and 
                   (%ptr-in-zone-p ptr zone lim)
                   (eql p (%setf-macptr ptr (#_RecoverHandle ptr)))))))
         (declare (inline %handle-in-zone-p))           
         (with-macptrs ((app-zone (%int-to-ptr #x2000))  ;; guessing
                        (app-lim *ram-size-macptr*))
           (if (%ptr-in-zone-p p app-zone app-lim)
             (%handle-in-zone-p p app-zone app-lim)
             ))))))))

#|
(defun handlep (p)
  (when (macptrp p)
    (if (#_isvalidcontrolhandle p) 
      t
      (and (macptr-evenp p)
           ;; this can crash too given e.g. (%int-to-ptr 2000) - so lets assume nobody does that?
           (> 0 (nth-value 1 (macptr-to-fixnums p)))
           (#_ishandlevalid p)))))
|#


;; also in level-0
(defun macptr< (p1 p2)
  (multiple-value-bind (p1-low p1-high) (macptr-to-fixnums p1)
    (declare (fixnum p1-low p1-high))
    (multiple-value-bind (p2-low p2-high) (macptr-to-fixnums p2)
      (declare (fixnum p2-low p2-high))
      (or (< p1-high p2-high)
          (and (eql p1-high p2-high)
               (< p1-low p2-low))))))



(defun %get-ostype (pointer &optional (offset 0))
  (let ((string (make-string 4 :element-type 'base-character))
        (pkg (find-package :keyword)))
    (declare (dynamic-extent string))
    (%copy-ptr-to-ivector pointer offset string 0 4)
    (values
     (or (find-symbol string pkg)
         (let ((real-string (%substr string 0 4)))
           (intern real-string pkg))))))

(defun %hget-ostype (handle &optional (offset 0))
  (with-dereferenced-handle (p handle offset)
    (%get-ostype p 0)))
     
(defun %put-ostype (pointer str &optional (offset 0))
  (%put-ostype pointer str offset))     ; gets compiled inline

(defun %set-ostype (pointer offset &optional (str (prog1 offset
                                                   (setq offset 0))))
  (%put-ostype pointer str offset)
  str)

(defsetf %get-ostype %set-ostype)

(defun %hset-ostype (handle offset &optional (str (prog1 offset
                                                   (setq offset 0))))
  (with-dereferenced-handle (p handle offset)
    (%put-ostype p str 0)))

(defsetf %hget-ostype %hset-ostype)

(defun %hput-ostype (handle val &optional (offset 0))
  (%hset-ostype handle offset val)
  nil)

(defun %ostype-ptr (str)
  (%stack-block ((type 4))
    (%put-ostype type str)
    (%get-ptr type)))

(defun ostype-p (x)
  (if (symbolp x)(setq x (symbol-name x)))
  (or (and (integerp x)(<= (integer-length x) 32))
      (and (stringp x)
           (eql 4 (length x))
           (or (eq 'base-character (array-element-type x))
               (dotimes (i 4 t)
                 (unless (< (the fixnum (char-code (char x i))) 256)
                   (return nil)))))))

;from  pointer to new string - perhaps he should have a script arg
(defun %get-string (pointer &optional (offset 0) script)
  ;(if (handlep pointer)(error "barf")) ;; temp
  (new-with-pointers ((p pointer offset))  ;Can be a handle... - better not be!
    (%str-from-ptr-in-script (%incf-ptr p 1)(%get-byte p -1) script)))

(defun %get-string-from-handle (handle &optional (offset 0) script)
  (with-dereferenced-handle (hp handle)
    (%get-string hp offset script)))

;; not used by us today
(defun getindstring (resourceID index &optional script)
  (declare (fixnum resourceID index))
  (let* ((strH (#_GetResource "STR#" resourceID)))
    (declare (dynamic-extent strH))
    (unless (or (ccl:%null-ptr-p strH) (<= index 0))
      (without-interrupts
       (#_LoadResource strH)
       (let* ((offset 2)
              (nstrings (ccl::%hget-unsigned-word strH 0)))
         (declare (fixnum offset nstrings))
         (unless (> index nstrings)
           (dotimes (i (the fixnum (1- index))       ; index is "1-origin".
                       (ccl::%str-from-ptr-in-script
                        (%inc-ptr (%get-ptr strH) (the fixnum (1+ offset)))
                        (ccl::%hget-unsigned-byte strH offset)
                        script))
             (declare (fixnum i))
             (setq offset (+ offset 1 (ccl::%hget-unsigned-byte strH offset))))))))))

(defun %get-cstring (pointer &optional (offset 0) (end offset))
  ;(if (handlep pointer)(error "barf"))  ; temp
  (new-with-pointers ((p pointer))
    (loop (if (%izerop (%get-byte p end))
            (return)
            (setq end (%i+ end 1))))
    (%str-from-ptr-in-script (%incf-ptr p offset) (%i- end offset))))

(defun %put-rect (pointer top left bot right &optional (offset 0))
  (%put-word pointer top offset)
  (%put-word pointer left (%i+ offset 2))
  (%put-word pointer bot (%i+ offset 4))
  (%put-word pointer right (%i+ offset 6)))

;Add an item to a dialog items list handle.
#|
(defun %rsc-string (n)
  (with-macptrs (strh)
    (%setf-macptr strh (#_GetString n))
    (if (and (not (%null-ptr-p strh)) (not (%null-ptr-p (%get-ptr strh))))
      (%get-string-from-handle strh)
      (%str-cat "Error #" (%integer-to-string n)))))
|#

(defun %rsc-string (n)
  (or (cdr (assq n *error-format-strings*))
  (%str-cat "Error #" (%integer-to-string n))))

(defun string-arg (arg)
 (or (string-argp arg) (error "~S is not a string" arg)))

(defun string-argp (arg)
 (if (symbolp arg) (symbol-name arg)
   (if (stringp arg) (ensure-simple-string arg)
     nil)))

(defun symbol-arg (arg)
  (unless (symbolp arg)
    (report-bad-arg arg 'symbol))
  arg)


;Sets locked-ptr and returns original if needs to be unlocked.  For use
;in with-pointer.
(defun %thing-pointer (pointer offset locked-ptr)

  (cerror "OK" "With-pointer(s) may not work. Use new-with-pointer(s).")
  (if (macptrp pointer)
    (let ((unlock-ptr nil))
      (if (handlep pointer)
        (progn         
          (unless (handle-locked-p pointer)
            (setq unlock-ptr pointer)
            (#_HLock :errchk pointer))
          (%setf-macptr locked-ptr (%get-ptr pointer))
          (%strip-address locked-ptr))
        (%setf-macptr locked-ptr pointer))
      (%incf-ptr locked-ptr offset)
      unlock-ptr)
    (report-bad-arg pointer '(satisfies macptrp))))

; Sets locked-ptr and returns original if it needs to be unlocked.
; For use in with-dereferenced-handles
(defun %dereference-handle (handle offset locked-ptr)
  (unless (macptrp handle)
    (report-bad-arg handle 'macptr))
  (let ((unlock-handle nil))
    (unless (handle-locked-p handle)
      (setq unlock-handle handle)
      (#_HLock :errchk handle))
    (%setf-macptr locked-ptr (%get-ptr handle))
    (unless (eql offset 0)
      (%incf-ptr locked-ptr offset))
    unlock-handle))

(defun %put-string (pointer str &optional (offset 0) (maxsize 255) script)
  (new-with-pointers ((p pointer (1+ offset)))
    (setf (%get-byte p -1) (%put-string-contents p str  maxsize script))))

(defun %put-string-contents (p str &optional maxsize script)
  (declare (ignore script))
  (setq str (require-type str 'string))
  (flet ((err () (error "String too big to fit in record")))
    (let ((size (length str)))
      (if (and maxsize (%i> size maxsize))
        (err)
        (multiple-value-bind (v start) (array-data-and-offset str)
            (cond
             ((simple-base-string-p v)
              (%copy-ivector-to-ptr v start p 0 size)              
              size)
             (t (let (; (table (get-char-byte-table script))
                    (j 0))
                (when (not maxsize)(setq  maxsize most-positive-fixnum))
                (dotimes (i size)
                  (let ((c (%scharcode v i)))
                    (if (and #|table|# (%i> c #xff)) #|(eq (svref table (%ilsr 8 c)) 1))|#
                      (progn 
                        (when  (%i>= j (%i- maxsize 1))(err))
                        (%put-word p c j)
                        (setq j (%i+ j 2)))
                      (progn
                        (when (%i>= j maxsize)(err))
                        (%put-byte p c j)
                        (setq j (%i+ j 1))))))
                j))))))))

; start and end are character positions
; maxsize is a byte count.
(defun %put-string-segment-contents (p str start end &optional maxsize script)
  (declare (ignore script))
  (multiple-value-setq (str start end)(string-start-end str start end))
  (flet ((err () (error "String too big to fit in record")))
    (let ((size (- end start)))
      (if (and maxsize (%i> size maxsize))
        (err)
        (cond
         ((simple-base-string-p str)
          (%copy-ivector-to-ptr str start p 0 size)
          size)
         (t (let ((j 0))
              (when (not maxsize)(setq  maxsize most-positive-fixnum))
              (dotimes (i size)                
                (let ((c (%scharcode str  (%i+ i start))))  ;; <<                 
                  ;(cerror "b" "foo ~s ~s ~S" i j C)
                  (if (%i> c #xff) 
                    (progn 
                      (when  (%i>= j (%i- maxsize 1))(err))
                      (%put-word p c j)
                      (setq j (%i+ j 2)))
                    (progn
                      (when (%i>= j maxsize)(err))
                      (%put-byte p c j)
                      (setq j (%i+ j 1))))))
              j)))))))

(defun %set-string (pointer offset &optional (string (prog1 offset (setq offset 0))))
  (%put-string pointer string offset)
  string)

(defun %put-cstring (pointer str &optional (offset 0) maxsize script)
  (new-with-pointers ((p pointer offset))
    (setf (%get-byte p (%put-string-contents p str (if maxsize (1- maxsize)) script)) 0)))

(defun %get-double-float (macptr &optional (offset 0) (res (%copy-float 0.0d0)))
  (unless (macptrp macptr)
    (setq macptr (require-type macptr 'macptr)))
  (unless (typep res 'double-float)
    (setq res (require-type res 'double-float)))
  (%copy-ptr-to-ivector macptr offset res (* 4 ppc::double-float.value-cell) 8)
  res)

(defun %hget-double-float (handle &optional (offset 0) (res (%copy-float 0.0d0)))
  (unless (macptrp handle)
    (setq handle (require-type handle 'macptr)))
  (unless (typep res 'double-float)
    (setq res (require-type res 'double-float)))
  (with-macptrs ((pointer (%get-ptr handle)))
    (%copy-ptr-to-ivector pointer offset res (* 4 ppc::double-float.value-cell) 8))
  res)

(defun %set-double-float (macptr offset &optional (value nil value-p))
  (unless value-p
    (setq value offset
          offset 0))
  (unless (macptrp macptr)
    (setq macptr (require-type macptr 'macptr)))
  (unless (typep value 'double-float)
    (setq value (require-type value 'double-float)))
  (%copy-ivector-to-ptr value (* 4 ppc::double-float.value-cell) macptr offset 8)
  value)

(defun %hset-double-float (handle offset &optional (value nil value-p))
  (unless value-p
    (setq value offset
          offset 0))
  (unless (macptrp handle)
    (setq handle (require-type handle 'macptr)))
  (unless (typep value 'double-float)
    (setq value (require-type value 'double-float)))
  (with-macptrs ((pointer (%get-ptr handle)))
    (%copy-ivector-to-ptr value (* 4 ppc::double-float.value-cell) pointer offset 8))
  value)

(defun %put-double-float (macptr value &optional (offset 0))
  (%set-double-float macptr offset value))

(defun %hput-double-float (handle value &optional (offset 0))
  (%hset-double-float handle offset value))
  
(defun %get-single-float (macptr &optional (offset 0) (res (%make-sfloat)))
  (unless (macptrp macptr)
    (setq macptr (require-type macptr 'macptr)))
  (unless (fixnump offset)
    (setq offset (require-type offset 'fixnum)))
  (unless (typep res 'short-float)
    (setq res (require-type res 'short-float)))
  (locally (declare (fixnum offset)) 
    (with-macptrs ((single (%inc-ptr macptr offset)))
      (%ref-ieee-single-float single res))))

(defun %hget-single-float (handle &optional (offset 0) (res (%make-sfloat)))
  (unless (macptrp handle)
    (setq handle (require-type handle 'macptr)))
  (unless (fixnump offset)
    (setq offset (require-type offset 'fixnum)))
  (unless (typep res 'short-float)
    (setq res (require-type res 'short-float)))
  (locally (declare (fixnum offset)) 
    (with-macptrs ((pointer (%get-ptr handle))
                   (single (%inc-ptr pointer offset)))
      (%ref-ieee-single-float single res))))

(defun %set-single-float (macptr offset &optional (value nil value-p))
  (unless value-p
    (setq value offset
          offset 0))
  (unless (macptrp macptr)
    (setq macptr (require-type macptr 'macptr)))
  (unless (fixnump offset)
    (setq offset (require-type offset 'fixnum)))
  (locally (declare (fixnum offset))
    (cond ((typep value 'short-float)
           (with-macptrs ((single (%inc-ptr macptr offset)))
             (%set-ieee-single-float value single)))
          ((typep value 'double-float)
           (with-macptrs ((single (%inc-ptr macptr offset)))
             (%set-ieee-single-float-from-double value single)))
          (t (return-from %set-single-float
               (%set-single-float
                macptr offset (require-type value 'short-float))))))
  value)

(defun %hset-single-float (handle offset &optional (value nil value-p))
  (unless value-p
    (setq value offset
          offset 0))
  (unless (macptrp handle)
    (setq handle (require-type handle 'macptr)))
  (unless (fixnump offset)
    (setq offset (require-type offset 'fixnum)))
  (locally (declare (fixnum offset))
    (cond ((typep value 'short-float)
           (with-macptrs ((pointer (%get-ptr handle))
                          (single (%inc-ptr pointer offset)))
             (%set-ieee-single-float value single)))
          ((typep value 'double-float)
           (with-macptrs ((pointer (%get-ptr handle))
                          (single (%inc-ptr pointer offset)))
             (%set-ieee-single-float-from-double value single)))
          (t (return-from %hset-single-float
               (%set-single-float
                handle offset (require-type value 'short-float))))))
  (unless (typep value 'short-float)
    (setq value (require-type value 'short-float)))
  (locally (declare (fixnum offset)) 
    (with-macptrs ((pointer (%get-ptr handle))
                   (single (%inc-ptr pointer offset)))
      (%set-ieee-single-float value single)))
  value)

(defun %put-single-float (macptr value &optional (offset 0))
  (%set-single-float macptr offset value))

(defun %hput-single-float (handle value &optional (offset 0))
  (%hset-single-float handle offset value))
  
; Single float is sign, 8 bits of exponent, 23 bits of mantissa
; Double float is sign, 11 bits of exponent, 52 bits of mantissa
#|
(defun %single-float-ptr->double-float-ptr (single double)
  (let* ((hi (%get-word single))
         (low (%get-word single 2))
         (negative (logbitp 16 hi))
         (expt (logand #xff (the fixnum (ash hi -7))))
         (normalized-expt (- expt #x7f))
         (double-expt (+ normalized-expt #x3ff))
         (double-expt-with-sign
          (if negative 
            (the fixnum (+ (ash 1 11) double-expt))
            double-expt))
         (mantissa (+ low (the fixnum (logand hi #x7f))))
         (word0 (+ (the fixnum (ash double-expt-with-sign 4))
                   (the fixnum (ash mantissa -19))))
         (word1 (logand (the fixnum (ash mantissa -3)) #xffff))
         (word2 (ash (the fixnum (logand mantissa 7)) 13)))
    (declare (fixnum hi low expt normalized-expt double-expt
                     double-expt-with-sign mantissa word0 word1 word2))
    (setf (%get-word double) word0
          (%get-word double 2) word1
          (%get-word double 4) word2
          (%get-word double 6) 0)
    double))
|#

; Copy a single float pointed at by the macptr in single
; to a double float pointed at by the macptr in double
#+ppc-target
(defppclapfunction %single-float-ptr->double-float-ptr ((single arg_y) (double arg_z))
  (check-nargs 2)
  (lwz imm0 ppc::macptr.address single)
  (lfs fp0 0 imm0)
  (lwz imm0 ppc::macptr.address double)
  (stfd fp0 0 imm0)
  (blr))

; Copy a double float pointed at by the macptr in double
; to a single float pointed at by the macptr in single.
#+ppc-target
(defppclapfunction %double-float-ptr->single-float-ptr ((double arg_y) (single arg_z))
  (check-nargs 2)
  (lwz imm0 ppc::macptr.address double)
  (lfd fp0 0 imm0)
  (lwz imm0 ppc::macptr.address single)
  (stfs fp0 0 imm0)
  (blr))

; Copy an IEEE-single (aka "short") float from a macptr to a lisp short float
#+ppc-target
(defppclapfunction %ref-ieee-single-float ((macptr arg_y) (dest arg_z))
  (check-nargs 2)
  (lwz imm0 ppc::macptr.address macptr)
  (lfs fp1 0 imm0)
  (put-single-float fp1 dest)
  (blr))

#+ppc-target
(defppclapfunction %set-ieee-single-float ((src arg_y) (macptr arg_z))
  (check-nargs 2)
  (lwz imm0 ppc::macptr.address macptr)
  (get-single-float fp1 src)
  (stfs fp1 0 imm0)
  (blr))

(defppclapfunction %set-ieee-single-float-from-double ((src arg_y) (macptr arg_z))
  (check-nargs 2)
  (lwz imm0 ppc::macptr.address macptr)
  (get-double-float fp1 src)
  (stfs fp1 0 imm0)
  (blr))
                              

;Returns a simple string and adjusted start and end, such that
; 0<= start <= end <= (length simple-string).
(defun get-sstring (str &optional (start 0) (end (length (require-type str 'string))))
  (multiple-value-bind (sstr offset) (array-data-and-offset (string str))
    (setq start (+ start offset) end (+ end offset))
    (when (< (length sstr) end)(setq end (length sstr)))
    (when (< end start) (setq start end))
    (values sstr start end)))

;e.g. (bad-named-arg :key key 'function)
(defun bad-named-arg (name arg &optional (type nil type-p))
  (if type-p
    (%err-disp $err-bad-named-arg-2 name arg type)
    (%err-disp $err-bad-named-arg name arg)))

(defun verify-arg-count (call min &optional max)
  "If call contains less than MIN number of args, or more than MAX
   number of args, error. Otherwise, return call.
   If Max is NIL, the maximum args for the fn are infinity."
 (or (verify-call-count (car call) (%cdr call) min max) call))

(defun verify-call-count (sym args min &optional max &aux argcount)
  (if (%i< (setq argcount  (list-length args)) min)
    (%err-disp $xtoofew (cons sym args))
    (if (if max (%i> argcount max))
      (%err-disp $xtoomany (cons sym args)))))

(defun getf (place key &optional (default ()))
  (let ((p (pl-search place key))) (if p (%cadr p) default)))

(defun remprop (symbol key)
  (do* ((prev nil plist)
        (plist (symbol-plist symbol) tail)
        (tail (cddr plist) (cddr tail)))
       ((null plist))
    (when (eq (car plist) key)
      (if prev
        (rplacd (cdr prev) tail)
        (setf (symbol-plist symbol) tail))
      (return t))))



; If this returns non-nil, safe to do %rplaca of %cdr to update.
(defun pl-search (plist key)
  (unless (plistp plist)
    (report-bad-arg plist '(satisfies plistp)))
  (%pl-search plist key))




(defun point-string (point)
  (%str-cat "#@("
            (%integer-to-string (point-h point))
            " "
            (%integer-to-string (point-v point))
            ")"))


(defun position (item sequence &rest ignored-keys)
  (declare (ignore ignored-keys)
           (dynamic-extent ignored-keys))
  (xposition item sequence))

(defun xposition (item sequence)
  (if (listp sequence)
    (do* ((list sequence (%cdr list))
          (count 0 (1+ count)))
         ((endp list) nil)
      (when (eql (car list) item) (return count)))
    (dotimes (i (length sequence))
      (declare (fixnum i))
      (when (eql (aref sequence i) item) (return i)))))

(defun position-positional-test-key (item sequence test key)
  (declare (ignore test key))
  (xposition item sequence))

(defun delete (item list &rest ignored-keys)
  (declare (ignore ignored-keys)
           (dynamic-extent ignored-keys)
           (inline delete))
  (if list
      (if (eq item (car list))
          (delete item (%cdr list))
          (%rplacd list (delete item (%cdr list))))))

(defun rassoc (item alist &key (test #'eql test-p) test-not (key #'identity))
  (declare (list alist))
  "Returns the cons in alist whose cdr is equal (by a given test or EQL) to
   the Item."
  (if (or test-p (not test-not))
    (progn
      (if test-not (error "Cannot specify both :TEST and :TEST-NOT."))
      (dolist (pair alist)
        (if (atom pair)
          (if pair (error "Invalid alist containing ~S: ~S" pair alist))
          (when (funcall test item (funcall key (cdr pair))) (return pair)))))
    (progn
      (unless test-not (error "Must specify at least one of :TEST or :TEST-NOT"))
      (dolist (pair alist)
        (if (atom pair)
          (if pair (error "Invalid alist containing ~S: ~S" pair alist))
          (unless (funcall test-not item (funcall key (cdr pair))) (return pair)))))))

(defun *%saved-method-var%* ()
  (declare (special %saved-method-var%))
  %saved-method-var%)

(defun set-*%saved-method-var%* (new-value)
  (declare (special %saved-method-var%))
  (setq %saved-method-var% new-value))

(defsetf *%saved-method-var%* set-*%saved-method-var%*)

(defun beep (&optional (times 1) idlecount)
  (dotimes (i times) (declare (fixnum i)) (#_sysbeep 10))
  (when idlecount (dotimes (i idlecount) (declare (fixnum i)))))



(defun true (&rest p) (declare (ignore p)) t)
(defun t-p (x) (declare (ignore x)) t)
(defun false (&rest p) (declare (ignore p)) nil)

(setf (symbol-function 'clear-type-cache) #'false)      ; bootstrapping

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; these functions also appear in level-0;nfasload.lisp and are reproduced here because
;; files compiled in the level-0 directory somehow manage to use the pig trap emulator which is deadsville in OSX
;; and should have been dead long ago - see expand-trap-internal for the kludge - fasload etal fixed now

(eval-when (:compile-toplevel :execute)
  (require "FASLENV" "ccl:xdump;faslenv"))

#| 
(defun %fasload (string &optional (table *fasl-dispatch-table*)
                        start-faslops-function
                        stop-faslops-function)
  ;(dbg string)
  ; WITH-PSTRS now calls something called BYTE-LENGTH.
  ; Presumably, %vect-byte-size isn't good enough for it...
  #|
  (%stack-block ((name 256))
    (let* ((len (length string)))
      (declare (fixnum len))
      (dotimes (i len (setf (%get-byte name) len))
        (setf (%get-byte name (the fixnum (1+ i))) (char-code (schar string i)))))
  |#
  (with-pstrs ((name string)) ; there is a bootstrapping version of byte length now
    (let* ((s (%istruct
               'faslstate
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil
               nil)))
      (declare (dynamic-extent s))
      (setf (faslstate.faslfname s) string)
      (setf (faslstate.fasldispatch s) table)
      (setf (faslstate.faslversion s) 0)
      (%stack-block ((pb #.(record-length :hparamblockrec) :clear t)
                     (buffer (+ 4 $fasl-buf-len)))
        (setf (faslstate.fasliopb s) pb
              (faslstate.iobuffer s) buffer)
        (let* ((old %parse-string%))
          (setq %parse-string% nil)    ;  mark as in use
          (setf (faslstate.oldfaslstr s) old
                (faslstate.faslstr s) (or old (make-string 255 :element-type 'base-character)))
          
          (flet ((%fasl-open (s)
                   (let* ((ok nil)
                          (pb (faslstate.fasliopb s))
                          (err #$noErr))
                     (setf (%get-ptr pb $iofilename) name
                           (%get-long pb $ioCompletion) 0
                           (%get-byte pb $ioFileType) 0
                           (%get-word pb $ioVrefNum) 0
                           (%get-byte pb $ioPermssn) $fsrdperm
                           (%get-long pb $ioOwnBuf) 0)
                     (if (and (eql #$noErr (setq err (#_PBHOpenSync pb)))                              
                              (eql #$noErr (setq err (#_PBGetEOFSync pb))))
                       (if (< (the fixnum (%get-long pb $ioLEOF)) 4)
                         (setq err $xnotfasl)
                         (progn
                           (setf (faslstate.bufcount s) 0
                                 (%get-long pb $ioposoffset) 0)
                           (let* ((signature (%fasl-read-word s)))
                             (declare (fixnum signature))
                             (if (= signature $fasl-file-id)
                               (setq ok t)
                               (if (= signature $fasl-file-id1)
                                 (progn
                                   (%fasl-set-file-pos s (%fasl-read-long s))
                                   (setq ok t))
                                 (setq err $xnotfasl)))))))
                     (unless (eql err #$noErr) (setf (faslstate.faslerr s) err))
                     ok)))
            (unwind-protect
              (when (%fasl-open s)
                (let* ((nblocks (%fasl-read-word s))
                       (*pfsl-library-base* nil)
                       (*pfsl-library* nil))
                  (declare (fixnum nblocks))
                  (declare (special *pfsl-library-base* *pfsl-library*))
                  (unless (= nblocks 0)
                    (let* ((pos (%fasl-get-file-pos s)))
                      (dotimes (i nblocks)
                        (%fasl-set-file-pos s pos)
                        (%fasl-set-file-pos s (%fasl-read-long s))
                        (incf pos 8)
                        (when start-faslops-function (funcall start-faslops-function s))
                        (let* ((version (%fasl-read-word s)))
                          (declare (fixnum version))
                          (if (or (> version (+ #xff00 $fasl-vers))
                                  (< version (+ #xff00 $fasl-min-vers)))
                            (%err-disp (if (>= version #xff00) $xfaslvers $xnotfasl))
                            (progn
                              (setf (faslstate.faslversion s) version)
                              (%fasl-read-word s) 
                              (%fasl-read-word s)       ; Ignore kernel version stuff
                              (setf (faslstate.faslevec s) nil
                                    (faslstate.faslecnt s) 0)
                              (do* ((op (%fasl-read-byte s) (%fasl-read-byte s)))
                                   ((= op $faslend))
                                (declare (fixnum op))
                                (%fasl-dispatch s op))
                              (when stop-faslops-function (funcall stop-faslops-function s))
                              ))))))))
              (setq %parse-string% (faslstate.oldfaslstr s))
              (#_PBCloseSync pb))
            (let* ((err (faslstate.faslerr s)))
              (if err
                (values nil err)
                (values t nil)))))))))

(defun %fasl-read-buffer (s)
  (let* ((pb (faslstate.fasliopb s))
         (buffer (faslstate.iobuffer s))
         (bufptr (%get-ptr buffer)))
    (declare (dynamic-extent bufptr)
             (type macptr buffer bufptr pb))
    (%setf-macptr bufptr (%inc-ptr buffer 4))
    (setf (%get-ptr buffer) bufptr)
    (setf (%get-long pb $iobytecount) $fasl-buf-len)
    (setf (%get-ptr pb $iobuffer) bufptr)
    (setf (%get-word pb $ioPosMode) $fsatmark)
    (#_PBReadSync  pb)
    (if (= (the fixnum (setf (faslstate.bufcount s)
                             (%get-unsigned-long pb $ioNumDone)))
           0)
      (%err-disp (%get-signed-word pb $ioResult)))))

(defun %fasl-set-file-pos (s new)
  (let* ((pb (faslstate.fasliopb s))
         (posoffset (%get-long pb $ioposoffset)))
    (if (>= (decf posoffset new) 0)
      (let* ((count (faslstate.bufcount s)))
        (if (>= (decf count posoffset ) 0)
          (progn
            (setf (faslstate.bufcount s) posoffset)
            (incf (%get-long (faslstate.iobuffer s)) count)
            (return-from %fasl-set-file-pos nil)))))
    (progn
      (setf (%get-long pb $ioPosOffset) new
            (%get-word pb $ioPosMode) $fsFromStart)
      (setf (faslstate.bufcount s) 0)
      (#_PBSetFPosSync :errchk pb))))
|#



;end of L1-utils.lisp

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
