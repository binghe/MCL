;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  2 2/13/97  akh  moved some stuff to common file
;;  24 1/22/97 akh  maybe no change
;;  23 10/12/96 akh ctypep => %%typep in builtin-typep
;;  22 9/3/96  akh  font-codes-info here from l1-edbuf
;;  19 6/7/96  akh  maybe no change
;;  18 5/20/96 akh  base-string gets type-predicate, %require-type-builtin, type preds for some un/signed-byte
;;  15 3/1/96  bill 3.1d74
;;  14 2/19/96 akh  subtypep allows class objects as specifiers
;;  12 12/1/95 akh  %i+ in font-codes-xx
;;  10 11/18/95 akh set-array-simple-p moved to 68k/ppc-arrays
;;  9 11/14/95 akh  delete bogus ppc definitions of %arh-bits and %set-ditto
;;  7 11/6/95  akh  fix ppc %getpen
;;  6 11/2/95  akh  lose last little bits of lap for ppc
;;  4 10/26/95 Alice Hartley %istruct/ make-uvector stuff
;;  3 10/17/95 akh  merge patches - mainly machine types
;;  7 2/7/95   akh  string-width errors if string too long
;;  6 2/3/95   akh  merge leibniz patches
;;  5 2/2/95   akh  merge leibniz patches
;;  (do not edit before this line!!)

;; sysutils.lisp - things which have outgrown l1-utils
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

;; Modification History
;; new-mouse-down-p sleepticks 1 vs. 3
;; wait-mouse-up-or-moved - decrease time between #_stilldown and #_trackmouselocation
;; ------ 5.2b6
;; fix type-pred-pairs for single-float !!!
;; --- 5.2b1
;; fix sleepticks ?
;; ------ 5.1 final
;; wait-mouse-up-or-moved don't check for recursive call if not *the-timer*
;; new-mouse-down-p sets *processing-events* NIL
;; ----- 5.1b3
;; back to old wait-mouse-up-or-moved - but do use with-periodic-task-mask, also check for recursive call
;; new wait-mouse-up-or-moved
; 07/15/04 new version of new-mouse-down-p
;; ------ 5.1b2
; 04/19/04 mouse-down-p back to #_stilldown so as not to screw up existing user code.
;   Add new-mouse-down-p called by wait-mouse-up-or-moved in absence of timer. It enables scheduling.
; 04/16/04 mouse-down-p fix some more
; 04/09/04 mouse-down-p fix so scheduler will run
; 04/08/04 mouse-down-p reverts to #_stilldown, add new function wait-mouse-up-or-moved 
; 02/20/04 another fix to mouse-down-p - don't track if not down initially
; 02/17/04 mouse-down-p more timer friendly
; ------ 5.1b1
;; 11/21/03 mouse-down-p does #_waitmouseup
; ------- 5.0 final
; 05/08/99 akh typep, subtypep get &optional env (ignored)
; 05/01/99 akh describe-array (used by type-of) uses length vs array-dimension for 1d in case fill ptr?
; --------- 4.3b1
; 02/12/99 akh add set-type-predicate for  base-char and extended-char
; 08/21/96 bill Make some additions to *known-gestalt-machine-types*,
;               *known-gestalt-processor-types*, *known-gestalt-keyboard-types*,
;               and (def-ccl-pointers sysenvirons ...).
; ------------  4.0b1
; 06/27/96 bill string-width & font-codes-string-width work for strings longer than 255 chars
; akh base-string gets type-predicate, %require-type-builtin, type preds for some un/signed-byte
; ------------  MCL-PPC 3.9
;;<end of added text>
; 03/26/96 gb   describe-array returns a type-specifier (so (TYPEP FOO (TYPE-OF FOO))
;               isn't underconstrained.)
; 02/29/96 bill PPC preload-all-functions stub for backward compatibility.
; 01/30/96 bill structure-class-p no longer does (sd-type nil)
; 04/25/95 gb   cmucl type system.
; 5/16/95 slh   new improved trap-implemented-p
; 3/24/95 slh   complement: something bizarre (having to do with 'F' local?) caused
;               it to compile with F being special; so changed F to FN.
; 3/11/95 slh   use gestalt bitnum arg
; 3/02/95 slh   removed array-dimension-limit, array-total-size-limit checks
;-------------  3.0d17
; 1/25/95 slh   make-array-1 checks array-dimension-limit
;-------------  3.0d16
;01/05/95 alice dont say format nil - it doesnt boot. (fix this better later)
;12/26/94 alice class-cell-typep moved to l1-clos for boot reasons
;05/27/94 bill  (typep 1/2 '(complex rational)) no longer returns true.
;03/09/93 bill  font-codes-string-width now takes optional start & end parameters
;-------------  3.0d13
;07/29/93 bill  Use the #$kMachineNameStrID to get (machine-type).
;               Say "#n" instead of "Unknown" when we don't find *environs* values
;               in the number->name alists.
;07/28/93 bill  add Quadra 950, LC II, & PowerBook 145 to *known-gestalt-machine-types*
;-------------- 3.0d12
;06/21/93 alice init-uvector-contents error more grammatical?
;05/17/93 alice type predicates for simple-base-string, simple-extended-string, base-character and extended-character
;05/16/93 alice describe-array fewer foo-p's - make it work for simple-mumble-string etc. 
;05/04/93 alice St-Array-Element-Type distinquishes base-character from character
;02/03/93 alice added font-codes-string-width, font-codes-line-height 
;10/14/92 alice moved font-codes-info to l1-edbuf
;03/16/93 bill kill managed-vector-space. Nobody calls it and it no longer makes sense.
;01/29/93 bill *%dynvlimit%*
;---------- 2.1d1
;11/20/92 gb  don't cons temp-vector space.  Move #'TRUE & #'FALSE elsewhere.  Half-understand
;             fat strings.  New headers.  [Signal compiler-warnings, appleevent-detection from
;             earlier patches.]
; 09/11/92 bill (typep ar '(simple-array double-float (4 4))) now has a chance of
;               returning true. (dotimes (i rank) ...) -> (dotimes (i rank t) ...)
; 04/13/92 bill in redefine-kernel-function: CCL -> MCL
;-------- 2.0
;03/09/92 gb's fix to the :appleevents determination in *environs*
;---------- 2.0f3
;02/07/92 (gb from bootpatch0) ST-ARRAY-DIMENSIONS-ENCOMPASS got broken at some point.
;02/04/92 bill the ff & ms args to font-info are &aux, not &optional.
;---------- 2.0f2
;01/14/92 gb   Don't call SUB-SUBTYPE unless you're willing to let it decide the whole issue.
;12/27/91 bill remove ignored optional args from font-codes-info.
;12/06/91 gb   update *known-gestalt-machine,-keyboard-types* for 10/91 hardware.
;---------- 2.0b4
;11/04/91 gb   maybe more subtypep fixes.
;10/28/91 bill  GB's fix to (def-subtypep-specialist 1 or ...)
;10/29/91 alice def-load-pointers => def-ccl-pointers
;10/22/91 gb   *suppress-compiler-warnings*.
;10/11/91 gb   flush more of subtypep.
;---------- 2.0b3
;09/05/91 bill gestalt -> l1-aprims
;09/04/91 bill initialize *setgworld-available?* & *screen-gdevice*
;08/24/91 gb   use new trap syntax.
;08/01/91 gb   class objects are type specifiers.
;07/01/91 gb   (make-array :element-type 'float) == (make-array :element-type t), new badarg scheme,
;	       account for defconstant wimpiness, find structure class info in env, cl-types elsewhere,
;              use declaim now that it does something.
;06/24/91 bill font-info's ff & ms args should have been &optional not &aux
;---------- 2.0b2
;05/28/91 bill structurep -> l1-aprims
;05/20/91 gb   flush (Gensym) temp-number stuff.  Pathnames are equalp iff they're equal.
;              incorporate short-floats into type system.
;04/02/91 bill fix the integer subtypep specialists, signed-byte & unsigned-byte have symbol subtypes
;03/05/91 alice report-bad-arg usually gets 2 args, equalp call eql instead of eq
;02/28/91 alice add an eval-p optional arg to signal-compiler-warning
;02/18/91 gb   %uvsize -> uvsize.
;---------- 2.0b1
;02/06/91 bill  %alloc-temp-vector-space & %clear-temp-vector-space patches from patch2.0b1p0
;01/14/91 gb   flush *use-wait-next-event*.
;01/09/90 gb   :fpu is NIL when known to have no FPU in *environs*.
;01/01/91 gb   cerror when redefining functions as macros or vice versa.  Use FROZEN-DEFINITION-P
;              to identify functions which should cerror on redefinition when *warn-if-redefine-kernel*
;              is on.  Revive PRELOAD-ALL-FUNCTIONS.
;12/8/90  joe  Add :appleevents to sysenvirons
;11/30/90 bill font-codes defaults to :srcor vice :srccopy
;11/21/90 gb   16 bits.  Know about newer machine types.  Equalp compares hash tables.
;11/12/90 bill Make sysenvirons notice 8 or 32-bit quickdraw.
;              gb: gestalt checks only low 16 bits of d0 on first return.
;10/25/90 gz   $v_ulongv. Check for the common compound types in element-type-subtype.
;10/12/90 gb   new(er) lap.  No $v_shortv.  Make-array errs on bad typespecs.
;              %require-type.
;10/03/90 bill %class-cpl -> %inited-class-cpl.
;              subtypep now errors when given two class names and the first one can not be initialized.
;              It used to return (values nil nil), but CLtL 2 says this is not allowed.
;09/21/90 bill add type to def-accessors for deferred-warnings.
;09/12/90 gb   %temp-cons in compiler now.
;08/12/90 bill add ignored ff-mask, ms-mask args to font-codes-info
;08/10/90 bill with-temporary-consing, %temp-cons, %really-temp-cons
;08/02/90 gb   Use _gestalt vice _sysenvirons.  %uvref,-set -> uvref,uvset.
;07/24/90 akh  add make-array-1, and make-uarray-1 - no keyword args
;06/21/90 gb   typep checks %deftype-expander before special-casing structures
;              & classes.
; -------- 2.0a1
;06/10/90 gb   know about IIfx machine-type.
;06/02/90 gb   deferred warnings.
;05/30/90 bill (type-predicate 'structure-object) -> 'structurep
;05/29/90 bill Move %temp-port% to l1-windows.
;05/23/90 bill nil to font-codes for old-ff or olf-ms gets default of 0.
;05/19/90 gb   dispatch in *sysenvirons* initialization.
; 05/04/90 gz  Removed this upgraded-array-element-type, see l1-aprims.
;05/04/90 bill fron gb: in typep: add "type" arg to call to error.
;05/01/90 bill font-line-height
; 04/30/90 gb  constantly, complement.  New compiler warning stuff. flushed
;              lisp:common, string-char types.  Add base-character, (void)
;              extended-character, base-string, simple-base-string.  Macptr
;              is subtype of T; integrate REAL type into disgusting spice
;              subtypep alists.  Add UPGRADED-ARRAY-ELEMENT-TYPE.  Make-uarray
;              will cons arrays in temp vector space.  Really.  Set-macro-function
;              dtrt, %macro-have dtwt.  *lisp-package* et morte, vive 
;              *common-lisp-package*.
;04/19/90 gz   In font-codes, allow old-ff/ms to be nil.
;04/16/90 bill Update font-codes to return mask values for the updated codes.
;              font-info & real-font return values for the current port
;              if their font-spec arg is NIL.
;              Added merge-font-codes
;04/12/90 bill %getpen
;04/07/90 bill font-codes makes no changes for a null font-spec.
;03/31/90 gz   Use class-of in type-of.
;03/28/90 gz   Check dims in make-array.
;03/20/90 gz   realp is a type predicate for real.
;              Added EQL type specifier to TYPEP.
;              element-type-subtype returns nil for the empty type.
;03/05/90 bill *use-wait-next-event* T if _WaitNextEvent trap exists.
;02/21/90  mly %type-expander -> %deftype-expander.
;02/20/90 bill %temp-port% becomes a window.
;01/03/89  gz  Use uvectorp.
;              Made type-of return 'function instead of 'lfun.
;12/29/89  gz  print compiler warnings to *error-output* per x3j13/COMPILER-WARNING-STREAM
;12/27/89 bill %temp-port might get written to.  Set it's size to 0, so we don't
;              get garbage written on the screen.
;12/27/89  gz  Remove obsolete #-bccl conditionals.  Moved deftype et. al. elsewhere.
;              No more flavors-instance.  Delay calling type-expand in typep until
;              necessary.  Defstructs are in hash tables now.
;              Support function specs/setf functions.
;08-Dec-89 jaj Update sysenvirons for new machines & keyboards.
;11/25/89 gb  make-uarray can make temp vectors.  Can you say "with-compilation-unit" ?
;12-Nov-89 Mly Teach print-compiler-warnings-aux a few new tricks
;11/24/89 gz  structures now have superclasses in slot 0.
;11/06/89 gb  *%dynvfp%* now a value cell.  Unscramble temp-vector code.
;10/20/89 bill Remove streamp test from type-of (streams are all
;              standard-instance's).  Add standard-method-p test.
;10/4/89  gz  flush fhave, fset-globally -> fset.
;9/28/89  gb unsigned short, byte vectors.
;9/17/89  gb  punt on object lisp support in fset-*.
;9/11/89  gz  flush fwhere, where. Moved {software,machine}-{type,version} elsewhere.
;             Re-initialize *environs* when loading.
;8/29/89  gb  juggled function binding stuff a bit.
;8/24/89  gb  temporary vector consing.
;7/20/89  gz  moved color stuff to color.lisp.
;4/19/89  gz  make-uvector, for transforms.
;17-mar-89 as color stuff
;             use POSITION instead of rolling own
;4/19/89  gz  Added built-in-type-p, parse-array-type, flushed (buggy) array-typep.
;4/10/89  gz  Check class relationship first in subtypep.
;             No more object-lisp %class-object's.
;the Seventh of April 1989 gb  $sp8 -> $sp.  Space before colon when printing warnings.
;4/4/89   gz  $mac-time-offset defined elsewhere.  Moved number predicates
;             to l1-numbers.
; 03/24/89  gb   no more parse-defmacro.
;7-apr-89 as  %str-cat takes rest arg
;03/03/89 gz  Flushed list-to-array, array-to-list.  Moved copy-list to l1-aprims.
;             Moved byte field stuff to numbers.lisp, min/max to l1-aprims.
;             Changes for toy clos.
;03/02/89 gb  Muck around with function (sub)types.  Temp numbers ride again.
;12/26/88 gz  %%get-font-info from the editor (looks kinda like font-info, eh...)
;             Don't assume a valid curport in string-width, font-info, real-font.
;12/25/88 gz  $arh_simple -> $arh_simple_bit (changed location).
;12/20/88 gz  Fixes in make-array.
;12/15/88 gz  Fix in equalp for pathnames.
;12/05/88 gz  added require-type.
;12/02/88 gb  say "unbound-marker-8" in (broken) WHERE.
;11/22/88 gb  make, describe -array set, look at $arh_simple, as do complex/simple-array-p.
;10/27/88 gb  Equalp does (eq (char-upcase x) ...) vice (char-equal x ...); actually faster.
;             no-error-string-char-p unnecessary.
;10/25/88 gb  Moved identity to l1-utils.
;10/23/88 gb  8.9 upload.
;9/11/88 gb   Set correct bits ($Sym_bit_unshad) in fset-globally.
;9/02/88 gz  no more list-nreverse.
;9/01/88 gz  Integrated object lisp with the type system :-).
;8/28/88 gz  moved array-data-and-offset to l1-utils (needed by l1-files).
;8/23/88 gz  commented out function locking.  Print warning on one line
;            if there's only one.  Flushed read-structure-class-p,
;            sub-subtypep-structure-class-p. structure-class-p looks at
;            *compile-time-defstructs*.
;8/11/88 gz  Made *trace-print-level/length* default to NIL like all other
;            listener output.
;7/29/88 gz   Fixed up type-of
;6/21/88 jaj  removed call to print-listener-prompt
;6/7/88  jaj  moved string-width, font-info, real-font here from dialogs
;5/26/88 jaj  force a copy-str of " . " in *environs*
;5/23/88 jaj  compiler-warnings don't print for anonymous fns
;             added *multifinder* and *use-wait-next-event*
;5/20/88 jaj  added *environs* changed [machine|software]-[type|version]
;             added bootstrapping versions of mac-to-universal-time and
;             universal-to-mac-time
;5/19/88 as   keywordized a couple rlets
;5/13/88 jaj  type-of complex is either (complex float) or (complex rational)
;5/11/88 jaj  added print-compiler-warnings, print-warnings
;3/11/88 jaj  font-codes now merges properly with styles (added (%ilsr 8 ))
;6/02/88  gb  Use %symbol-bits.
;4/01/88  gz  New macptr scheme.  Flushed pre-1.0 edit history.
;             Fix the (type-of #C(1 3/4)) bug.
;2/14/88  gb  bugnum->bignum (count-temp-numbers), other typos in max-temp-numbers.
;             preload-all-functions bumps by 6 vice 8.
;2/8/88   jaj num-temp-floats/max-temp-floats -> count-temp-numbers/max-temp-numbers
;             and extended to return multiple values
;1/28/88 jaj  don't call position (so it works in level-1).
;12/22/87 gb  tempoary-floats -> temporary-numbers
;1/12/88 cfry fixed read-structure-class-p to permit random-states
;         so that they can be read back in since they are printed as structures
; 12/23/87 cfry added read-structure-class-p
;12/22/87 cfry fixed sub-subtypep for hash-tables, pathnames, random-states,
;                    readtable
;12/11/87 cfry fixed (equalp #\a 1)
;12/07/87 cfry  fixes to subtypep
;               require alltraps => traps, trap-support
;10/25/87 jaj added gb's temporary floats
;10/21/87 jaj changed fset to work with global only fns.  fset and fset-globally
;             now call %fhave instead of fhave.  They also error if redefining
;             special forms and warn and remove macrop property if redefining
;             macros.
;10/16/87 jaj fhave won't redefine globally defunned lfuns
;10/13/87 smh typep, structure-typep, and subtypep understand flavor instances
;10/13/87 smh type-of understands flavor instances
; 10/08/87 cfry fixed (subtypep 'array 'sequence) to return NIL NIL.
; 9/8/87  as  font-codes accepts optional args for default ff and ms
; 8/20/87 gz  Fix in equalp on structures.
;---------------------------release 1.0-----------------------------

(in-package :ccl)

(eval-when (:execute :compile-toplevel)
  (require 'level-2)
  (require 'sysequ)
  ;(require 'toolequ)
  (require 'defrecord)
  (require 'optimizers)
  (require 'backquote)
  (require 'fredenv)
  (require 'defstruct-macros)
  '(require 'lap)
  '(require 'lapmacros))

;;; things might be clearer if this stuff were in l1-typesys?
;;; Translation from type keywords to specific predicates.
(eval-when (eval compile)

(defconstant type-pred-pairs
  '((array . arrayp)
    (atom . atom)
    (base-string . base-string-p)
    (bignum . bignump)
    (bit . bitp)
    (bit-vector . bit-vector-p)
    (character . characterp)
    (compiled-function . compiled-function-p)
    (complex . complexp)
    (cons . consp)
    (double-float . double-float-p)
    (fixnum . fixnump) ;not cl
    (float . floatp)
    (function . functionp)
    (hash-table . hash-table-p)
    (integer . integerp)
    (real . realp)
    (keyword . keywordp)
    (list . listp)
    (long-float . double-float-p)
    (nil . false)
    (null . null)
    (number . numberp)
    (package . packagep)
    (pathname . pathnamep)
    (logical-pathname . logical-pathname-p)
    (random-state . random-state-p)
    (ratio . ratiop)
    (rational . rationalp)
    (readtable . readtablep)
    (sequence . sequencep)
    (short-float . short-float-p)
    (signed-byte . integerp)
    (simple-array . simple-array-p)
    (simple-base-string . simple-base-string-p)
    (simple-extended-string . simple-extended-string-p)
    (simple-bit-vector . simple-bit-vector-p)
    (simple-string . simple-string-p)
    (simple-vector . simple-vector-p)
    (single-float . short-float-p)    ;;; gag puke - was double-float-p
    (stream . streamp)
    (string . stringp)
    (extended-string . extended-string-p)
    (base-character . base-character-p)
    (base-char . base-character-p)
    (extended-character . extended-character-p)
    (structure-object . structurep)
    (symbol . symbolp)
    (t . t-p)
    (unsigned-byte . unsigned-byte-p) ;unsigned-byte-p is not cl.
    (vector . vectorp)
    ))

(defmacro init-type-predicates ()
  `(dolist (pair ',type-pred-pairs)
     (setf (type-predicate (car pair)) (cdr pair))
     (let ((ctype (info-type-builtin (car pair))))       
       (if (typep ctype 'numeric-ctype)
         (setf (numeric-ctype-predicate ctype) (cdr pair))))))

)

(init-type-predicates)

(defun unsigned-byte-8-p (n)
  (and (fixnump n)
       (locally (declare (fixnum n))
         (and 
          (>= n 0)
          (< n #x100)))))

(defun signed-byte-8-p (n)
  (and (fixnump n)
       (locally (declare (fixnum n))
         (and 
          (>= n -128)
          (<= n 127)))))

(defun unsigned-byte-16-p (n)
  (and (fixnump n)
       (locally (declare (fixnum n))
         (and 
          (>= n 0)
          (< n #x10000)))))

(defun signed-byte-16-p (n)
  (and (fixnump n)
       (locally (declare (fixnum n))
         (and 
          (>= n -32768)
          (<= n 32767)))))

(defun unsigned-byte-32-p (n)
  (and (integerp n)
       (>= n 0)
       (<= n #xffffffff)))

(defun signed-byte-32-p (n)
  (and (integerp n)
       (>= n  -2147483648)
       (<= n 2147483647)))

(eval-when (:load-toplevel :execute)
  (let ((more-pairs
         '(((unsigned-byte 8) . unsigned-byte-8-p)
           ((signed-byte 8) . signed-byte-8-p)
           ((unsigned-byte 16) . unsigned-byte-16-p)
           ((signed-byte 16) . signed-byte-16-p)
           ((unsigned-byte 32) . unsigned-byte-32-p)
           ((signed-byte 32) . signed-byte-32-p))))         
    (dolist (pair more-pairs)
      (let ((ctype (info-type-builtin (car pair))))       
        (if (typep ctype 'numeric-ctype) (setf (numeric-ctype-predicate ctype) (cdr pair))))))
  )


(defun specifier-type-known (type)  
  (let ((ctype (specifier-type type)))
    (if (typep ctype 'unknown-ctype)
      (error "Unknown type specifier ~s." type)
      (if (and (typep ctype 'numeric-ctype) ; complexp??
               (eq 'integer (numeric-ctype-class ctype))
               (not (numeric-ctype-predicate ctype)))
        (setf (numeric-ctype-predicate ctype)(make-numeric-ctype-predicate ctype))))
    ctype))


(defun find-builtin-cell (type  &optional (create t))
  (let ((cell (gethash type %builtin-type-cells%)))
    (or cell
        (when create
          (setf (gethash type %builtin-type-cells%)
                (cons type (or (info-type-builtin type)(specifier-type-known type))))))))


; for now only called for builtin types or car = unsigned-byte, signed-byte, mod or integer

(defun builtin-typep (form cell)
  (unless (listp cell)
    (setq cell (require-type cell 'list)))
  (locally (declare (type list cell))
    (let ((ctype (cdr cell))
          (name (car cell)))
      (when (not ctype)
        (setq ctype (or (info-type-builtin name)(specifier-type-known name)))
        (when ctype (setf (gethash (car cell) %builtin-type-cells%) cell))
        (rplacd cell ctype))
      (if ctype 
        (if (and (typep ctype 'numeric-ctype)
                 (numeric-ctype-predicate ctype))
          ; doing this inline is a winner - at least if true
          (funcall (numeric-ctype-predicate ctype) form)
          (%%typep form ctype))
        (typep form name)))))

#|
(defvar %find-classes% (make-hash-table :test 'eq))

(defun find-class-cell (name create?)
  (let ((cell (gethash name %find-classes%)))
    (or cell
        (and create?
             (setf (gethash name %find-classes%) (cons name nil))))))
|#

;(setq *type-system-initialized* t)


;; Type-of, typep, and a bunch of other predicates.

;;; Data type predicates.

;;; things might be clearer if this stuff were in l1-typesys?
;;; Translation from type keywords to specific predicates.




;necessary since standard-char-p, by definition, errors if not passed a char.
(setf (type-predicate 'standard-char)
      #'(lambda (form) (and (characterp form) (standard-char-p form))))

(defun type-of (form)
  (cond ((null form) 'null)
        ((arrayp form) (describe-array form))
        (t (let ((class (class-of form)))
             (if (eq class *istruct-class*)
               (uvref form 0)
               (let ((name (class-name class)))
                 (if name
                   (if (eq name 'complex)
                     (cond ((floatp (realpart form)) '(complex float))
                           (t '(complex rational)))
                     name)
                   (%type-of form))))))))


;;; Create the list-style description of an array.

;made more specific by fry. slisp used  (mod 2) , etc.
;Oh.
; As much fun as this has been, I think it'd be really neat if
; it returned a type specifier.
#-ppc-target
(defun describe-array (array)
  "Not CL. slisp. Used by type-of."
  (let ((type (%type-of array)))
    (if (eq (array-rank array) 1)
      (let ((length (length array)))
        (if (eq type 'complex-array)
          (let ((class (class-name (class-of array))))
            (if (eq class 'vector)
              `(vector ,(array-element-type array) ,length)
              (list class length)))
          (if (eq type 'simple-array)  ; i think it never is eq
            (let ((elt-type (array-element-type array)))
              (if (eq elt-type t)
                (list 'simple-vector length)
                `(simple-array ,(array-element-type array) (,length))))
            (list type length))))
      (let ()
        `(,type ,(array-element-type array) ,(array-dimensions array))))))

#|
#+ppc-target
(defun describe-array (array)
  (if (arrayp array)
    (type-specifier
     (specifier-type
      `(,(if (simple-array-p array) 'simple-array 'array) 
        ,(array-element-type array) 
        ,(array-dimensions array))))
    (report-bad-arg array 'array)))
|#

 ;; ?? this way (typep a (type-of a)) when a has fill-pointer is true
#+ppc-target
(defun describe-array (array)
  (if (arrayp array)
    (type-specifier
     (specifier-type
      `(,(if (simple-array-p array) 'simple-array 'array) 
        ,(array-element-type array) 
        ,(if (eq (array-rank array) 1) (list (length array)) (array-dimensions array)))))
    (report-bad-arg array 'array)))

  

;;;; TYPEP and auxiliary functions.



(defun type-specifier-p (form &OPTIONAL ENV &aux sym)
  (cond ((symbolp form)
         (or (type-predicate form)
             (structure-class-p form ENV)
             (%deftype-expander form)
             (find-class form nil ENV)
             ))
        ((consp form)
         (setq sym (%car form))
         (or (type-specifier-p sym)
             (memq sym '(member satisfies mod))
             (and (memq sym '(and or not))
                  (dolist (spec (%cdr form) t)
                    (unless (type-specifier-p spec) (return nil))))))
        (t (typep form 'class))))

(defun built-in-type-p (type)
  (if (symbolp type)
    (or (type-predicate type)
        (let ((class (find-class type nil)))
          (and class (typep class 'built-in-class))))
    (and (consp type)
         (or (and (memq (%car type) '(and or not))
                  (every #'built-in-type-p (%cdr type)))
             (memq (%car type) '(array simple-array vector simple-vector
                                 string simple-string bit-vector simple-bit-vector 
                                 complex integer mod signed-byte unsigned-byte
                                 rational float short-float single-float
                                 double-float long-float real member))))))

(set-type-predicate 'base-char 'base-character-p)
(set-type-predicate 'extended-char 'extended-character-p)


(defun typep (object type &optional env)
  (declare (ignore env))
  (let* ((pred (if (symbolp type) (type-predicate type))))
    (if (AND  pred) ;  (not (eql type 'ctype)))  ;; kludge
      (funcall pred object)
      (progn
        (%typep object type)))))



;This is like check-type, except it returns the value rather than setf'ing
;anything, and so can be done entirely out-of-line.
(defun require-type (arg type)  
  (if (typep  arg type)
    arg
    (%kernel-restart $xwrongtype arg type)))

; Might want to use an inverted mapping instead of (satisfies ccl::obscurely-named)
(defun %require-type (arg predsym)
    (if (funcall predsym arg)
    arg
    (%kernel-restart $xwrongtype arg `(satisfies ,predsym))))

(defun %require-type-builtin (arg type-cell)  
  (if (builtin-typep arg type-cell)
    arg
    (%kernel-restart $xwrongtype arg (car type-cell))))

#| moved to l1-clos
(defun %require-type-class-cell (arg class-cell)  
  (if (class-cell-typep arg class-cell)
    arg
    (%kernel-restart $xwrongtype arg (car class-cell))))
|#

;True if form is of given structure type or if it includes that type.
;Used by defstruct predicates.
#-ppc-target
(defun structure-typep (form type)
  (structure-typep form type))


; Subtypep.

(defun subtypep (type1 type2 &optional env)
  "Return two values indicating the relationship between type1 and type2:
  T and T: type1 definitely is a subtype of type2.
  NIL and T: type1 definitely is not a subtype of type2.
  NIL and NIL: who knows?"
  (declare (ignore env))
  ; not sure this is the right place for fix to subtypep
  ;(when (typep type1 'class)(setq type1 (class-name type1)))
  ;(when (typep type2 'class)(setq type2 (class-name type2)))  
  (csubtypep (specifier-type type1) (specifier-type type2)))


#|
(defun mouse-down-p ()
  (#_WaitMouseUp))
|#

;(setq *always-process-poll-p* t)   ;; does this bust anything - don't know but uses LOTS of CPU time!

(defun mouse-down-p ()
  (#_stilldown))

#|
(defun new-mouse-down-p ()
  (prog1 
    (#_Stilldown)
    (when (>= *interrupt-level* 0)
      (setq *processing-events* nil)
      (setq *in-scheduler* nil)  ;; egads - now frec-click reliably allows scheduling without timer
      ;;  - is above evil? N.B. timer also subverts intent of *in-scheduler* by calling suspend-current-process
      ;#+ignore ;; do if want processes with priority 0 to run - um processes with priority less than *current-process*
      (when (null *active-processes-tail*)
        (setq *active-processes-tail* *active-processes*)))))
|#

#|
(defun sleepticks (ticks)
  ;(when (minusp seconds) (report-bad-arg seconds '(number 0 *)))
  (let* ((end-time (+ (#_tickcount) ticks))
         (wait-function #'(lambda () (> (#_tickcount) end-time))))
    (declare (dynamic-extent wait-function))
    (process-wait "Sleeping" wait-function)))
|#

#|
(defun sleepticks (ticks)
  ;(when (minusp seconds) (report-bad-arg seconds '(number 0 *)))
  (let* ((end-time (%tick-sum  (get-tick-count) ticks))
         (wait-function #'(lambda () (%i> (get-tick-count) end-time))))
    (declare (dynamic-extent wait-function))
    (process-wait "Sleeping" wait-function)))
|#

(defun sleepticks (ticks)
  ;(when (minusp seconds) (report-bad-arg seconds '(number 0 *)))
  (let* ((end-time (%tick-sum  (get-tick-count) ticks))
         (wait-function #'(lambda () (> (%tick-difference (get-tick-count) end-time) 0))))
    (declare (dynamic-extent wait-function))
    (process-wait "Sleeping" wait-function)))


(defun new-mouse-down-p ()
  (declare (optimize (speed 3)(safety 0)))
  (if (not (#_stilldown))
    nil    
    (if (%i>= *interrupt-level* 0)
      (progn (setq *processing-events* nil) (sleepticks 1) (#_stilldown))
      t)))

(export '(wait-mouse-up-or-moved) :ccl)


(defglobal *in-wait-mouse-up-or-moved* nil)
#-ignore 
(defun wait-mouse-up-or-moved ()
  (declare (optimize (speed 3)(safety 0))) ;; avoid event check on entry  
  (if (not (and *the-timer* (%i> *timer-count* 0)))
    (new-mouse-down-p)
    (progn 
      (when *in-wait-mouse-up-or-moved* (error "Recursive call to wait-mouse-up-or-moved"))
      (let-globally ((*in-wait-mouse-up-or-moved* t))
        (with-periodic-task-mask ($ptask_event-dispatch-flag t)  ;; don't let the periodic-task or event-dispatch eat the mouse up event?
          (rlet ((outpt :point)
                 (out-res :uint16))    
            (If (not (#_stilldown))
              nil      
              (progn         
                (errchk (#_trackmouselocation (%null-ptr) outpt out-res))
                (let ((what (%get-unsigned-word out-res)))
                  ;; T if mouse moved, key modifiers changed or ... , NIL iff mouse up
                  (neq what #$kmousetrackingmouseup))))))))))

;   kMouseTrackingMouseMoved      = 9
;; often get this which is supposed to mean mouse is up and moved but it lies
#+ignore  ;; seems to cause more problems than it solves - ok now
(defun wait-mouse-up-or-moved ()
  (declare (optimize (speed 3)(safety 0)))
  (when *in-wait-mouse-up-or-moved* (error "Recursive call to wait-mouse-up-or-moved"))
  (let-globally ((*in-wait-mouse-up-or-moved* t))
    (if (not (and *the-timer* (%i> *timer-count* 0)))
      (new-mouse-down-p)
      (If (not (#_stilldown))
        nil
        (rlet ((outpt :point)
               (out-res :unsigned-integer)
               (outmods :unsigned-long))
          ;; do timeout in case mouse went up between stilldown test and entry to trackmouselocation
          ;; and something ate the mouse up event - very unlikely but ??
          (errchk (#_trackmouselocationWithOptions 
                   (%null-ptr) 
                   0      ;inoptions or  #$kTrackMouseLocationOptionDontConsumeMouseUp
                   0.2d0  ; intimeout 
                   outpt 
                   outmods ; outmodifiers
                   out-res))
          (let ((what (%get-unsigned-word out-res)))
            ;; T if mouse moved or whatever, NIL if mouse up
            (if (eq what #$kMouseTrackingTimedOut)              
              (#_stilldown)            
              ;; will also return t if keymodifiersshanged etc.
              (neq what #$kMouseTrackingMouseUp))))))))

#+ignore
(defun what-event ()
  (rlet ((junk eventrecord))
    (and (#_EventAvail *event-mask* junk)
         (pref junk :eventrecord.what))))





#+ppc-target
(defun preload-all-functions ()
  nil)




#+ppc-target ; used by arglist
(defun temp-cons (a b)
  (cons a b))



(declaim (special *%dynvfp%*))
(declaim (special *%dynvlimit%*))

(defmacro with-managed-allocation (&body body &environment env)
   (multiple-value-bind (body decls)
   	(parse-body body env nil)
     `(let ((*%dynvfp%* *%dynvfp%*)
            (*%dynvlimit%* *%dynvlimit%*))
        ,@decls
        ,@body)))



#+ppc-target
(defun copy-into-float (src dest)
  (%copy-double-float src dest))


; Return the location of the pen.
; Maybe this should check if the result will fit in a fixnum.
; It won't if the vertical coordinate is > 4095.

#+ppc-target
(defun %getpen () 
  (rlet ((foo :long))
    (#_getpen foo) 
    (%get-signed-long foo)))

(%include "ccl:level-1;sysutils.lisp")

(setq *type-system-initialized* t)
    

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
  3   1/5/95   akh   dont say format nil in def-ccl-pointers
|# ;(do not edit past this line!!)
