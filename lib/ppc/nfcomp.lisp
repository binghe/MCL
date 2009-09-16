;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: nfcomp.lisp,v $
;;  Revision 1.12  2006/02/04 21:11:45  alice
;;   add macho-entry-point to *istruct-make-load-form-types*
; fcomp-read-loop - skip utf8 BOM if it exists
;;
;;  Revision 1.11  2005/02/02 01:05:42  alice
;;  ; fcomp-read-loop deal with utf-16 files
;;
;;  Revision 1.10  2004/11/25 20:37:30  alice
;;  include ppc-subtag-bytes here
;;
;;  Revision 1.9  2004/11/24 03:55:32  alice
;;  ; fix call to fasl-out-ivect for double-float-vector, fix ppc-subtag-bytes
; ---- 5.1 final
;;
;;  Revision 1.8  2003/12/08 08:15:45  gtbyers
;;  Change the fasl version.  Define more MAKE-LOAD-FORM stuff here; don't
;;  bend over backwards to signal TYPE-ERROR in missing MAKE-LOAD-FORM cases.
;;
;;  Revision 1.7  2003/12/01 17:56:04  gtbyers
;;  recover pre-MOP changes
;;
;;  Revision 1.5  2003/02/11 19:52:47  alice
;;  CVS is not my friend
;;
;;  Revision 1.4  2003/02/11 19:41:03  alice
;;  stuff for unix eol
;;
;;  Revision 1.3  2003/02/06 19:34:19  gtbyers
;;  FCOMP-INCLUDE passes NIL as external-format arg to FCOMP-READ-LOOP.  (Better than not passing enough args, but may need to be thought out more.)
;;
;;  18 9/4/96  akh  maybe no change
;;  14 1/28/96 akh  %compile-file only back-translate-pathname to "ccl" or "home" - not things that may not exist at load time
;;  12 12/22/95 gb  ppc-target changes
;;  8 11/13/95 akh  fasl-scan-dispatch for ppc - needs more work
;;                  #-ppc-target some stuff
;;  7 11/9/95  akh  add fasl-dump-ppc-bignum
;;  2 10/6/95  gb   :ppc-target on *FEATURES* when :target :PPC.
;;  9 3/2/95   akh  fcomp-read-loop says element-type 'base-character
;;  8 2/17/95  akh  let *loading-file-source-file* be logical
;;  7 2/6/95   akh  mumbled a few comments
;;  6 2/3/95   akh  merge leibniz patches
;;  5 2/2/95   akh  merge leibniz patches
;;  4 1/30/95  akh  nothing really
;;  (do not edit before this line!!)

;; :lib:nfcomp.lisp - New fasl compiler.
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

;; Modification History
;
; add macho-entry-point to *istruct-make-load-form-types*
; fcomp-read-loop - skip utf8 BOM if it exists
; fcomp-read-loop deal with utf-16 files
; fix call to fasl-out-ivect for double-float-vector, fix ppc-subtag-bytes
; ---- 5.1 final
; fcomp-include passes *loading-external-format* along, fcomp-file binds it
; -------- 5.0b4
; stuff for unix files
; ------ 5.0b3
; akh no mo *cl-types*
; ------- 4.3f1c1
;05/08/99 akh  defvar *compile-time-symbol-macros*, bind it
; ------------ 4.3b1
; 01/13/99 from slh - fixes for long lists
; 08/31/98 akh - don't try to scan or dump non nil cdrs of class-cells - see refs to %find-classes%
; 03/05/97 gb   ff31.
; -------- 4.0
; 07/20/96 gb   fcomp-include: output a $fasl-src after inclusion.
; 06/16/96 bill ff30
; 06/13/96 gb   ff29
; ------------  3.9
; 01/10/96 gb   more ppc-target changes
; 12/13/95 gb   progv rides again
; 11/03/95 bill *istruct-make-load-form-types*
; ------------  3.0
; 3/31/95 slh   compile-file 'force' key (for MCL-Alice mechanism)
;-------------  3.0d18
; 3/02/95 slh   report file name in warnings
;-------------  3.0d17
; let *loading-file-source-file* be logical
;-------------  3.0d16
;09/15/93 bill  Bob Cassell's patch for fasl-scan-user-form that bypasses the compiler
;               if the form is simple enough.
;-------------  3.0d13
;09/01/93 bill  fasl-dump-cons now works correctly for circular lists, e.g. '#1=(1 . #1#)
;07/29/93 bill  fasl-scan-forms-and-dump-file comes out of line from %compile-file
;               It binds *fcomp-locked-hash-tables*, which is used to store info about
;               hash tables that have been locked before they were scanned so that
;               they can be unlocked when dumping is done. This allows users code to
;               reference/modify hash tables that are being dumped but protects the
;               hash table vector from modification between the time we start scanning
;               it and when we're done dumping it.
;07/21/93 bill  (setq read-package *package*) in fcomp-read-loop.
;               This makes the file compiler less eager to output an lfun and was, I believe,
;               what Gary intended on 6/14/90.
;               fcomp-compile-toplevel-forms forces toplevel forms containing load-time-value
;               calls to be output in their own lfun.
;06/29/93 bill  fasl-dump-block errors if the EQness table has more than 65535 entries.
;               This is necessary since indices are stored as 2 bytes.
;-------------- 3.0d12
;07/13/93 alice %compile-file call full-pathname with no-errorp nil!
;06/19/93 alice fcomp-read-loop tells us file positions of compiler death for any reason.
;06/06/93 alice new op $fasl-xchar, changed fasl-dump-char, fasl-dump-ivector, fasl-out-string (wrong)
;-------------- 3.0d9
;11/20/92 gb    compiler-let: process outstanding toplevel forms before processing body.  Walk & dump
;               new vectors.  Pass &env to fcomp-signal-or-defer-warnings.
;-------------- 2.0
;01/26/92 gb    fix EVAL-WHEN.
;12/21/91 gb    make (declaim notinline ...) work again.
;--------------- 2.0b4
;11/17/91 alice compile-file less physical w.r.to output file
;11/08/91 gb    bind *loading-file-source-file* when including.  Handle
;               some declamations better.
;10/09/91 gb    define-compile-time-constant warns if evaluation errs.  Use %compile-time-eval.
;               Flush *cross-compiling* stuff, warning suppression stuff; use compilation policies.
;09/30/91 gb    call make-load-form for lexical-environments.
;---------------- 2.0b3
;08/30/91 gb    fix compile-time-proclamation.
;07/31/91 bill  call make-load-form for hash tables.
;07/21/91 gb    Pass env, local variables vice some specials.  Expect defining forms to
;               use (eval-when ...) for compile-time magic. FF24.  Don't use link maps
;               to dump lfunvs.
;06/13/91 alice %compile-file use merge-pathnames less aggressively to get type in orig-src
;----------------- 2.0b2
;05/28/91 bill  rehash-threshold becomes 0.9 vice NIL in fasl-scan
;05/15/91 bill  complete make-load-form
;05/20/91 gb    dump short floats. New doc string/macro arglist scheme.
;               always package-qualify interned symbols.
;02/18/91 gb    %uvsize -> uvsize.
; 02/04/91 bill errors after the FASL file is opened cause it to be deleted.
;02/08/91 alice bind *compile-file-pathname* and *compile-file-truename*, no more @!%& fcomp-standard-source
;               (truename is currently a string - supposed to be pathname)
;---------- 2.0b1
; 01/23/91 alice change to %compile-file for source and fasl both relative
; ---- 2.0a5
;12/12/90 bill *fcomp-inside-eval-always*, *fcomp-eval-always-functions*
;11/15/90 gb  fix macrolet; fcomp-named-function in *fcomp-lexical-environment* 
;             vice *fcomp-definition-environment*
;11/05/90 gb  symbol-macrolet.
;10/27/90 gb  macrolet, locally.
;10/24/90 gb  $fasl-timm.
;10/16/90 gb  no more %str-length; no more short vectors.
;09/20/9  gb   un-comment *fcomp-print-handler-plist* initialization.
;09/14/90 bill bind *package* in fcomp-include
;09/11/90 bill finally restarts for compile-file
;09/07/90 bill stream-writer
;08/13/90  gb Fully qualify %define-package.
;08/10/90  gb FF21.  Try to get symbol-locative stuff right.
;
;08/06/90  gz Cons up a link map for closures so can dump closures...
;07/05/90 gsb New *compile-print* stuff
;07/03/90  gz call cheap-eval-in-environment in the #+bccl case as well.
;06/23/90  gb  forget about $symbol-header.  
;06/20/90  gb COMPILE-TIME-EVAL calls CHEAP-EVAL-IN-ENVIRONMENT.  WITH-COMPILATION-UNIT
;             mucks with definition environment, or vice versa.
;6/14/90   gz The no-initform case of make-load-form.
;06/08/90 alice added compile-file-pathname (another practically useless Steele-2 thing)
;---------- 2.0a1
;06/14/90  gb read-loop: init read-package to NIL vice *package* (force it to change
;             on any compile-time assignment to *package*.)  Flush outstanding toplevel
;             forms after a toplevel call to SET-PACKAGE.
;06/12/90  gb Fasl-dump-symbol dumps symbols on *fasl-package-qualified-symbols* via
;             $fasl-pkg-intern (so that IN-PACKAGE works from packages other than ccl: .)
;             Error when dumping STANDARD-INSTANCEs, for now.
;06/11/90  gb bind *readtable* in compile-file.
;------- 2.0d45
; 05/29/90 gb stop using %immediate accessors.
; 05/22/90 gb no more symtagp or special handling of defvar/defparameter.
; 04/14/90 gz %substr now takes start/end args.
;             *logical-pathname-alist* -> *logical-directory-alist*.
;             pathname-directory -> directory-namestring.
; 04/30/90 gb new warnings, lexical environment scheme.  Bind some CL vars.
;             FF20.
; 01/01/89 gb use if# vice if in lap.
; 12/29/89 gz print compiler warnings to *error-output*.
; 12/27/89 gz FF1F
; 11/27/89 gb No compiler warnings until CL loaded.
; 11/14/89 gz %find-linkmap now returns vector.
; 11/06/89 gb About time for FF1E.
; 10/16/89 gz no more %defobfun.
; 09/27/89 gb repeat after me: *nx-outer-funs*, *nx-outer-funs* ...
;             For a good laugh, think about why this used to work.
;             Always pass macroexpansion environment explicitly.
;             Forget about object/instance vars.
; 09/05/89 gz handle proclaim notspecial
; 08/04/89 gz Linkmap offsets are unsigned, %uvref ain't...
; 05/31/89 gz Use nilreg-cell-symbol.
; 05/07/89 gb find-symbol-offsets thing walks new pages.
; 05/01/89 gz FF1D, lfun link maps.
; 04/27/89 gb FF1C (new JTAB), macroexpand random defsetfs.
; 04/14/89 gz Newfangled fn size overflow handling.
; 03/25/89 gz FF1B, new vcells.
; 03/08/89 gz Reset source file after include.
; 7-apr-89 as %str-cat takes rest arg
; 02/08/89 gb use kernel-function-p.
; 01/03/89 gz removed %vect-subtype, %vect-byte-size, now in level-2.
; 12/28/88 gz compile-time structure predicates.  No more %schar.
; 12/13/88 gz use require-type.
; 11/21/88 gb stop setting bit 14 in lfun "attributes" word.  Compile-time type
;             proclamations.
; 10/25/88 gb fix global map dumping, char-code -> %char-code.
; 10/23/88 gb 8.9 upload.
; 9/20/88 gb  use %count-immrefs.
; 9/10/88 gz  compile-time-eval.
; 9/3/88  gb  introduce *fasl-cross-compiling*, *cross-compiling*, xfcomp (#-bccl)
;             FF17, increment  FASL-VERSION when *fasl-cross-compiling*.
; 8/20/88 gz  FF16 new simpler fasdumper with circular structure support.
;             Cleaned up read/compile stage as well.
; 6/28/88 jaj fixed cfasl-proclaim to work with new object-variable decl
; 6/26/88 jaj added cfasl-compiler-let
; 6/23/88 as  warnings defaults to *fasl-compiler-warnings*
; 6/21/88 jaj removed file-modeline-package stuff
; 6/8/88  jaj got rid of random warnings by passing correct value to print-warnings
; 6/06/88 jaj include is a synonym for %include
; 5/25/88 jaj put simple file-modeline-package here, real one in fred-execute
; 5/20/88 as  new y-or-n-dialog calling sequence
; 5/17/88 jaj if there is a package in a modline, dumps an in-package
; 5/11/88 jaj changed cfasl-dump-warning to use print-warnings

; 6/14/88 gb  FF13, more immoplfun bootstrapping
; 5/20/88 gb  horrible stuff to distinguish bound specials from others.
; 5/11/88 gb  FF12, immoplfun bootstrapping
;04/01/88 gz  New macptr scheme. Flushed pre-1.0 edit history.
;10/15/87 gb  Added special compiling-a-file-damnit, bound to t by compile-file.
;             Try to catch toplevel lfuns exceeding 32k; split them.

(eval-when (:compile-toplevel :load-toplevel :execute)
   (require 'level-2))

(require 'optimizers)


(require 'hash)

(eval-when (:compile-toplevel :execute)

(require 'backquote)
(require 'defstruct-macros)
#-ppc-target (require 'lapmacros)

(defmacro short-fixnum-p (fixnum)
  `(and (fixnump ,fixnum) (< (integer-length ,fixnum) 16)))




 (require "FASLENV" "ccl:xdump;faslenv")

 (require "PPC-ARCH" "ccl:compiler;ppc;ppc-arch")
) ;eval-when (:compile-toplevel :execute)

;File compiler options.  Not all of these need to be exported/documented, but
;they should be in the product just in case we need them for patches....
(defvar *fasl-save-local-symbols* nil)
(defvar *fasl-deferred-warnings* nil)
(defvar *fasl-non-style-warnings-signalled-p* nil)
(defvar *fasl-warnings-signalled-p* nil)
(defvar *compile-verbose* nil) ; Might wind up getting called *compile-FILE-verbose*
(defvar *fasl-save-doc-strings* #-bccl nil #+bccl t)
(defvar *fasl-save-definitions* nil)
(defvar *compile-file-pathname* nil) ; pathname of src arg to COMPILE-FILE
(defvar *compile-file-truename* nil) ; truename ...
(defvar *fasl-target* #-ppc-target :m68k #+ppc-target :ppc)

#-carbon-compat
(defparameter *.pfsl-pathname* (%cons-pathname nil nil "pfsl"))
#+carbon-compat
(defparameter *.pfsl-pathname* (%cons-pathname nil nil "cfsl"))


(defvar *compile-print* nil) ; Might wind up getting called *compile-FILE-print*

;Note: errors need to rebind this to NIL if they do any reading without
; unwinding the stack!
(declaim (special *compiling-file*)) ; defined in l1-init.

(defvar *fasl-source-file* nil "Name of file currently being read from.
Will differ from *compiling-file* during an INCLUDE")



(defparameter *fasl-package-qualified-symbols* '(*loading-file-source-file* set-package %define-package)
  "These symbols are always fasdumped with full package qualification.")

(defun compile-file-pathname (pathname &rest ignore &key output-file &allow-other-keys)
  (declare (ignore ignore))
  (setq pathname (merge-pathnames pathname))
  (merge-pathnames (if output-file
                     (merge-pathnames output-file *.fasl-pathname*)
                     *.fasl-pathname*) 
                   pathname))

(defun compile-file (src &key output-file
                         (verbose *compile-verbose*)
                         (print *compile-print*)
                         load
                         features
                         external-format
                         (target *fasl-target* target-p)
                         (save-local-symbols *fasl-save-local-symbols*)
                         (save-doc-strings *fasl-save-doc-strings*)
                         (save-definitions *fasl-save-definitions*)
                         force)
  (when (and target-p (not (memq target '(:m68k :ppc))))
    (warn "Unknown :TARGET : ~S.  Reverting to ~s ..." target *fasl-target*)
    (setq target *fasl-target*))
  (loop
    (restart-case
      (return (%compile-file src output-file verbose print load features external-format
                             save-local-symbols save-doc-strings save-definitions force target))
      (retry-compile-file ()
                          :report (lambda (stream) (format stream "Retry compiling ~s" src))
                          nil)
      (skip-compile-file ()
                         :report (lambda (stream) (format stream "Skip compiling ~s" src))
                         (return)))))

(defvar *the-definition-environment* nil)  ;; for ansi-make-load-form

(defun %compile-file (src output-file verbose print load features external-format
                          save-local-symbols save-doc-strings save-definitions force target 
			        &aux orig-src)
  (setq orig-src (merge-pathnames src))
  (let* ((output-default-type 
          #-ppc-target
          (if (eq target :m68k) *.fasl-pathname* *.pfsl-pathname*)
          #+ppc-target *.fasl-pathname*))
    (setq src (fcomp-find-file orig-src))
    (let* ((newtype (pathname-type src)))
      (when (and newtype (not (pathname-type orig-src)))
        (setq orig-src (merge-pathnames orig-src (make-pathname :type newtype :defaults nil)))))
    (setq output-file (merge-pathnames (if output-file ; full-pathname in case output-file is relative
                                         (full-pathname (merge-pathnames output-file output-default-type) :no-error nil) 
                                         output-default-type)
                                       orig-src))
    (when (physical-pathname-p orig-src) ; only back-translate to things likely to exist at load time
      (setq orig-src (back-translate-pathname orig-src '("home" "ccl"))))
    (let* ((*fasl-non-style-warnings-signalled-p* nil)
           (*fasl-warnings-signalled-p* nil))
      (when (and (not force)
                 (probe-file output-file)
                 (neq (mac-file-type output-file) (if (eq target :m68k) :fasl :pfsl)))
        (unless (y-or-n-dialog (format nil
                                       "Compile destination ~S is a ~A file!  Overwrite it?"
                                       output-file (mac-file-type output-file)))
          (return-from %compile-file nil)))
      (let* ((*features* (append (if (listp features) features (list features)) *features*))
             (*fasl-deferred-warnings* nil) ; !!! WITH-COMPILATION-UNIT ...
             (*fasl-save-local-symbols* save-local-symbols)
             (*fasl-save-doc-strings* save-doc-strings)
             (*fasl-save-definitions* save-definitions)
             (*fcomp-warnings-header* nil)
             (*compile-file-pathname* orig-src)
             (*compile-file-truename* src)
             (*package* *package*)
             (*readtable* *readtable*)
             (*compile-print* print)
             (*compile-verbose* verbose)
             (*fasl-target* target)
             (*compile-time-symbol-macros* *compile-time-symbol-macros*)
             (defenv (new-definition-environment))
             ;(*the-definition-environment* defenv)
             (lexenv (new-lexical-environment defenv))
             (*the-definition-environment* lexenv))
        #-ppc-target (when (eq target :ppc) (pushnew :ppc-target *features*))
        (let ((forms nil))
          (let* ((*outstanding-deferred-warnings* (%defer-warnings nil)))
            (rplacd (defenv.type defenv) *outstanding-deferred-warnings*)
            #+ignore
            (let ((*linefeed-equals-newline* *linefeed-equals-newline*))
              (when (and *do-unix-hack* (not (eql (mac-file-type orig-src) :TEXT)))
                (setq *linefeed-equals-newline* t))
              (setq forms (fcomp-file src orig-src lexenv external-format)))
            (setq forms (fcomp-file src orig-src lexenv external-format))
            (setf (deferred-warnings.warnings *outstanding-deferred-warnings*) 
                  (append *fasl-deferred-warnings* (deferred-warnings.warnings *outstanding-deferred-warnings*))
                  (deferred-warnings.defs *outstanding-deferred-warnings*)
                  (append (defenv.defined defenv) (deferred-warnings.defs *outstanding-deferred-warnings*)))
            (when *compile-verbose* (fresh-line))
            (multiple-value-bind (any harsh) (report-deferred-warnings)
              (setq *fasl-warnings-signalled-p* (or *fasl-warnings-signalled-p* any)
                    *fasl-non-style-warnings-signalled-p* (or *fasl-non-style-warnings-signalled-p* harsh))))
          (fasl-scan-forms-and-dump-file forms output-file)))
      (when load (load output-file :verbose (or verbose *load-verbose*)))
      (values (truename (pathname output-file)) 
              *fasl-warnings-signalled-p* 
              *fasl-non-style-warnings-signalled-p*))))


(defvar *fcomp-locked-hash-tables*)

; This is seperated out so that dump-forms-to-file can use it
(defun fasl-scan-forms-and-dump-file (forms output-file)
  (let ((*fcomp-locked-hash-tables* nil))
    (unwind-protect
      (multiple-value-bind (hash gnames goffsets) (fasl-scan forms)
        (fasl-dump-file gnames goffsets forms hash output-file))
      (fasl-unlock-hash-tables))))

#-bccl
(defun nfcomp (src &optional dest &rest keys)
  (when (keywordp dest) (setq keys (cons dest keys) dest nil))
  (apply #'compile-file src :output-file dest keys))

#-bccl
(%fhave 'fcomp #'nfcomp)

(defparameter *default-file-compilation-policy* (new-compiler-policy))

(defun current-file-compiler-policy ()
  *default-file-compilation-policy*)

(defun set-current-file-compiler-policy (&optional new-policy)
  (setq *default-file-compilation-policy* 
        (if new-policy (require-type new-policy 'compiler-policy) (new-compiler-policy))))

(defparameter *compile-time-evaluation-policy*
  (new-compiler-policy :force-boundp-checks t))

(defun %compile-time-eval (form env)
  (funcall (compile-named-function
            `(lambda () ,form) nil t env nil nil
            *compile-time-evaluation-policy*)))


;No methods by default, not even for structures.  This really sux.
(defgeneric make-load-form (object &optional env))

(defmethod make-load-form ((c class) &optional env)
  (let* ((name (class-name c))
         (class (and name (find-class name nil env))))
    (if (eq class c)
      (values `(find-class ',name))
      (error "Class ~s doesn't have a proper name, can't make load form for it" c))))

;;; There's no real requirement that these methods exist; all that's required is that
;;; an error of type ERROR (not necessarily of type TYPE-ERROR) be signaled if there's
;;; no applicable method, so getting a NO-APPLICABLE-METHOD error is just fine (but
;;; perhaps more confusing than this.)

(define-condition no-make-load-form-error (error)
  ((object :initarg :object :accessor no-make-load-form-error-object))
  (:report (lambda (c s)
             (let* ((o (no-make-load-form-error-object c)))
               (format s "Can't reference ~s as a constant: no specialized MAKE-LOAD-FORM method is defined for objects of type ~s"
                       o (class-of o))))))

     
(defmethod make-load-form ((c standard-object) &optional env)
  (declare (ignore env))
  (error 'no-make-load-form-error :object c))

(defmethod make-load-form ((c structure-object) &optional env)
  (declare (ignore env))
  (error 'no-make-load-form-error :object c))

(defmethod make-load-form ((c condition) &optional env)
  (declare (ignore env))
  (error 'no-make-load-form-error :object c))


  

;;;;          FCOMP-FILE - read & compile file
;;;;          Produces a list of (opcode . args) to run on loading, intermixed
;;;;          with read packages.

(defparameter *fasl-eof-forms* nil)

(defparameter cfasl-load-time-eval-sym (make-symbol "LOAD-TIME-EVAL"))
(%macro-have cfasl-load-time-eval-sym
    #'(lambda (call env) (declare (ignore env)) (list 'eval (list 'quote call))))
;Make it a constant so compiler will barf if try to bind it, e.g. (LET #,foo ...)
(define-constant cfasl-load-time-eval-sym cfasl-load-time-eval-sym)


(defparameter *reading-for-cfasl* nil "Used by the reader for #,")



(declaim (special *nx-compile-time-types*
;The following are the global proclaimed values.  Since compile-file binds
;them, this means you can't ever globally proclaim these things from within a
;file compile (e.g. from within eval-when compile, or loading a file) - the
;proclamations get lost when compile-file exits.  This is sort of intentional
;(or at least the set of things which fall in this category as opposed to
;having a separate compile-time variable is sort of intentional).
                    *nx-proclaimed-inline*    ; inline and notinline
                    *nx-proclaimed-ignore*    ; ignore and unignore
                    *nx-known-declarations*   ; declaration
                    *nx-speed*                ; optimize speed
                    *nx-space*                ; optimize space
                    *nx-safety*               ; optimize safety
                    *nx-cspeed*))             ; optimize compiler-speed

(defvar *fcomp-load-time*)
(defvar *fcomp-inside-eval-always* nil)
(defvar *fcomp-eval-always-functions* nil)   ; used by the LISP package
(defvar *fcomp-output-list*)
(defvar *fcomp-toplevel-forms*)
(defvar *fcomp-warnings-header*)
(defvar *fcomp-indentation*)
(defvar *fcomp-print-handler-plist* nil)
(defvar *fcomp-last-compile-print*
  '(INCLUDE (NIL . T)
    DEFSTRUCT ("Defstruct" . T) 
    DEFCONSTANT "Defconstant" 
    DEFSETF "Defsetf" 
    DEFTYPE "Deftype" 
    DEFCLASS "Defclass" 
    DEFGENERIC "Defgeneric"
    DEFMETHOD "Defmethod"
    DEFMACRO "Defmacro" 
    DEFPARAMETER "Defparameter" 
    DEFVAR "Defvar" 
    DEFUN ""))



(setf (getf *fcomp-print-handler-plist* 'defun) ""
      (getf *fcomp-print-handler-plist* 'defvar) "Defvar"
      (getf *fcomp-print-handler-plist* 'defparameter) "Defparameter"
      (getf *fcomp-print-handler-plist* 'defmacro) "Defmacro"
      (getf *fcomp-print-handler-plist* 'defmethod) "Defmethod"  ; really want more than name (use the function option)
      (getf *fcomp-print-handler-plist* 'defgeneric) "Defgeneric"
      (getf *fcomp-print-handler-plist* 'defclass) "Defclass"
      (getf *fcomp-print-handler-plist* 'deftype) "Deftype"
      (getf *fcomp-print-handler-plist* 'defsetf) "Defsetf"
      (getf *fcomp-print-handler-plist* 'defconstant) "Defconstant"
      (getf *fcomp-print-handler-plist* 'defstruct) '("Defstruct" . t)
      (getf *fcomp-print-handler-plist* 'include) '(nil . t))


(defun fcomp-file (filename orig-file env external-format)  ; orig-file is back-translated
  (let* ((*package* *package*)
         (*compiling-file* filename)
         (*nx-compile-time-types* *nx-compile-time-types*)
         (*nx-proclaimed-inline* *nx-proclaimed-inline*)
         (*nx-known-declarations* *nx-known-declarations*)
         (*nx-proclaimed-ignore* *nx-proclaimed-ignore*)
         (*nx-speed* *nx-speed*)
         (*nx-space* *nx-space*)
         (*nx-debug* *nx-debug*)
         (*nx-safety* *nx-safety*)
         (*nx-cspeed* *nx-cspeed*)
         (*fcomp-load-time* t)
         (*fcomp-output-list* nil)
         (*fcomp-indentation* 0)
         (*fcomp-last-compile-print* (cons nil (cons nil nil)))
         (*loading-external-format* external-format))
    (when (eq *fasl-target* :ppc)       ; eventually, always do this.
      (push (list $fasl-arch 1) *fcomp-output-list*))
    (fcomp-read-loop filename orig-file env :not-compile-time external-format)
    (nreverse *fcomp-output-list*)))

(defun fcomp-find-file (file &aux path)
  (unless (or (setq path (probe-file file))
              (setq path (probe-file (merge-pathnames file *.lisp-pathname*))))
    (error "File ~S not found" file))
  (namestring path))

; orig-file is back-translated when from fcomp-file
; when from fcomp-include it's included filename merged with *compiling-file*
; which is not back translated
(defun fcomp-read-loop (filename orig-file env processing-mode external-format )
  (when *compile-verbose*
    (format t "~&;~A ~S..."
            (if (eq filename *compiling-file*) "Compiling" " Including")
            filename))  
  (when (and (fboundp 'utf-something-p)(fboundp 'fsopen))
    (let ((utf-p (utf-something-p filename)))
      (if (eq utf-p :utf-16)(setq external-format :|utxt|)
          (if (eq utf-p :utf-8)(setq external-format :utf8)))))
  (with-open-file (stream filename 
                          :element-type (if (eq external-format :|utxt|) 'extended-character 'base-character)
                          :external-format external-format)   
    (cond ((eq external-format :|utxt|)   ;; assume has bom and skip it
           (let ((first-char (stream-tyi stream)))
             (if (neq (char-code first-char) #xFEFF)  ;; well if not BOM don't skip it - probably silly precaution
               (stream-untyi stream first-char)))) 
          ((eq external-format :utf8)  ;; does have bom cause that's the only way we know
           (dotimes (i 3)(%ftyi-sub (slot-value stream 'fblock)))))
    (let* ((old-file (and (neq filename *compiling-file*) *fasl-source-file*))           
           (*fasl-source-file* filename)
           (*fcomp-toplevel-forms* nil)
           (*fasl-eof-forms* nil)
           (*loading-file-source-file* (namestring orig-file)) ; why orig-file???
           (eofval (cons nil nil))
           (read-package nil)
           form)
      (declare (special *fasl-eof-forms* *fcomp-toplevel-forms* *fasl-source-file*))
      ;This should really be something like `(set-loading-source ,filename)
      ;but then couldn't compile level-1 with this...
 ;-> In any case, change this to be a fasl opcode, so don't make an lfun just
 ;   to do this... 
; There are other reasons - more compelling ones than "fear of tiny lfuns" -
; for making this a fasl opcode.
      (fcomp-output-form $fasl-src env *loading-file-source-file*)
      (loop
        (unless (eq read-package *package*)
          (fcomp-compile-toplevel-forms env)
          (setq read-package *package*))
        (let ((*reading-for-cfasl*
               (and *fcomp-load-time* cfasl-load-time-eval-sym)))
          (declare (special *reading-for-cfasl*))
          (let ((pos (file-position stream)))
            (handler-bind
               ((error #'(lambda (c) ; we should distinguish read errors from others?
                          (format *error-output* "~&Read error between positions ~a and ~a in ~a." pos (file-position stream) filename)
                          (signal c))))
              (setq form (read stream nil eofval)))))
        (when (eq eofval form) (return))
        (fcomp-form form env processing-mode))
      (while (setq form *fasl-eof-forms*)
        (setq *fasl-eof-forms* nil)
        (fcomp-form-list form env processing-mode))
      (when old-file
        (fcomp-output-form $fasl-src env (namestring *compile-file-pathname*)))
      (fcomp-compile-toplevel-forms env))))

#|
;Gross me out...  Hope this isn't the final scheme!
(defun fcomp-standard-source (name &aux (len (length name)) str slen)
   (dolist (log.phys *logical-directory-alist*)
       (setq str (cdr log.phys) slen (length str))
       (when (and (%i<= slen len) (string-equal str name :end2 slen))
         (return-from fcomp-standard-source
                      (%str-cat (car log.phys)
                                ";"
                                (%substr name slen len)))))
   name)
|#


(defun fcomp-form (form env processing-mode
                        &aux print-stuff 
                        (load-time (and processing-mode (neq processing-mode :compile-time)))
                        (compile-time-too (or (eq processing-mode :compile-time) 
                                              (eq processing-mode :compile-time-too))))
  (let* ((*fcomp-indentation* *fcomp-indentation*)
         (*compile-print* *compile-print*))
    (when *compile-print*
      (cond ((and (consp form) (setq print-stuff (getf *fcomp-print-handler-plist* (car form))))
             (rplaca (rplacd (cdr *fcomp-last-compile-print*) nil) nil)
             (rplaca *fcomp-last-compile-print* nil)         
             (let ((print-recurse nil))
               (when (consp print-stuff)
                 (setq print-recurse (cdr print-stuff) print-stuff (car print-stuff)))
               (cond ((stringp print-stuff)
                      (if (equal print-stuff "")
                        (format t "~&~vT~S~%" *fcomp-indentation* (second form))
                        (format t "~&~vT~S [~A]~%" *fcomp-indentation* (second form) print-stuff)))
                     ((not (null print-stuff))
                      (format t "~&~vT" *fcomp-indentation*)
                      (funcall print-stuff form *standard-output*)
                      (terpri *standard-output*)))
               (if print-recurse
                 (setq *fcomp-indentation* (+ *fcomp-indentation* 4))
                 (setq *compile-print* nil))))
            (t (unless (and (eq load-time (car *fcomp-last-compile-print*))
                            (eq compile-time-too (cadr *fcomp-last-compile-print*))
                            (eq *fcomp-indentation* (cddr *fcomp-last-compile-print*)))
                 (rplaca *fcomp-last-compile-print* load-time)
                 (rplaca (rplacd (cdr *fcomp-last-compile-print*) compile-time-too) *fcomp-indentation*)
                 (format t "~&~vTToplevel Forms...~A~%"
                         *fcomp-indentation*
                         (if load-time
                           (if compile-time-too
                             "  (Compiletime, Loadtime)"
                             "")
                           (if compile-time-too
                             "  (Compiletime)"
                             "")))))))
    (fcomp-form-1 form env processing-mode)))
           
(defun fcomp-form-1 (form env processing-mode &aux sym body)
  (if (consp form) (setq sym (%car form) body (%cdr form)))
  (case sym
    (progn (fcomp-form-list body env processing-mode))
    (eval-when (fcomp-eval-when body env processing-mode))
    (compiler-let (fcomp-compiler-let body env processing-mode))
    (locally (fcomp-locally body env processing-mode))
    (macrolet (fcomp-macrolet body env processing-mode))
    ((%include include) (fcomp-include form env processing-mode))
    (t
     ;Need to macroexpand to see if get more progn's/eval-when's and so should
     ;stay at toplevel.  But don't expand if either the evaluator or the
     ;compiler might not - better safe than sorry... 
     ; Good advice, but the hard part is knowing which is which.
     (cond 
      ((and (non-nil-symbol-p sym)
            (macro-function sym env)            
	      (not (evaluator-special-form-p sym))
	      (not (compiler-macro-function sym env))
            (not (eq sym '%defvar-init))        ;  a macro that we want to special-case
	      (multiple-value-bind (new win) (macroexpand-1 form env)
	        (if win (setq form new))
	        win))
       (fcomp-form form env processing-mode))
      ((and (not *fcomp-inside-eval-always*)
            (memq sym *fcomp-eval-always-functions*))
       (let* ((*fcomp-inside-eval-always* t))
         (fcomp-form-1 `(eval-when (:execute :compile-toplevel :load-toplevel) ,form) env processing-mode)))
      (t
       (when (or (eq processing-mode :compile-time) (eq processing-mode :compile-time-too))
         (%compile-time-eval form env))
       (when (and processing-mode (neq processing-mode :compile-time))
         (case sym
           ((%defconstant) (fcomp-load-%defconstant form env))
           ((%defparameter) (fcomp-load-%defparameter form env))
           ((%defvar %defvar-init) (fcomp-load-defvar form env))
           ((%defun) (fcomp-load-%defun form env))
           ((set-package %define-package)
            (fcomp-random-toplevel-form form env)
            (fcomp-compile-toplevel-forms env))
           ((%macro) (fcomp-load-%macro form env))
           ;      ((%deftype) (fcomp-load-%deftype form))
           ;      ((define-setf-method) (fcomp-load-define-setf-method form))
           (t (fcomp-random-toplevel-form form env)))))))))

(defun fcomp-form-list (forms env processing-mode)
  (dolist (form forms) (fcomp-form form env processing-mode)))

(defun fcomp-compiler-let (form env processing-mode &aux vars varinits)
  (fcomp-compile-toplevel-forms env)
  (dolist (pair (pop form))
    (push (nx-pair-name pair) vars)
    (push (%compile-time-eval (nx-pair-initform pair) env) varinits))
  (progv (nreverse vars) (nreverse varinits)
                 (fcomp-form-list form env processing-mode)
                 (fcomp-compile-toplevel-forms env)))

(defun fcomp-locally (body env processing-mode)
  (fcomp-compile-toplevel-forms env)
  (multiple-value-bind (body decls) (parse-body body env)
    (let* ((env (augment-environment env :declare (decl-specs-from-declarations decls))))
      (fcomp-form-list body env processing-mode)
      (fcomp-compile-toplevel-forms env))))

(defun fcomp-macrolet (body env processing-mode)
  (fcomp-compile-toplevel-forms env)
  (let ((outer-env (augment-environment env 
                                        :macro
                                        (mapcar #'(lambda (m)
                                                    (destructuring-bind (name arglist &body body) m
                                                      (list name (enclose (parse-macro name arglist body env)
                                                                          env))))
                                                (car body)))))
    (multiple-value-bind (body decls) (parse-body (cdr body) outer-env)
      (let* ((env (augment-environment 
                   outer-env
                   :declare (decl-specs-from-declarations decls))))
        (fcomp-form-list body env processing-mode)
        (fcomp-compile-toplevel-forms env)))))

(defun fcomp-symbol-macrolet (body env processing-mode)
  (fcomp-compile-toplevel-forms env)
  (let* ((outer-env (augment-environment env :symbol-macro (car body))))
    (multiple-value-bind (body decls) (parse-body (cdr body) env)
      (let* ((env (augment-environment outer-env 
                                       :declare (decl-specs-from-declarations decls))))
        (fcomp-form-list body env processing-mode)
        (fcomp-compile-toplevel-forms env)))))
                                                               
(defun fcomp-eval-when (form env processing-mode &aux (eval-times (pop form)))
  (when (or (atom eval-times) (eq (%car eval-times) 'quote))
    (report-bad-arg eval-times 'list))
  (let* ((compile-time-too  (eq processing-mode :compile-time-too))
         (compile-time-only (eq processing-mode :compile-time))
         (at-compile-time nil)
         (at-load-time nil)
         (at-eval-time nil))
    (dolist (when eval-times)
      (if (or (eq when 'compile) (eq when :compile-toplevel))
        (setq at-compile-time t)
        (if (or (eq when 'eval) (eq when :execute))
          (setq at-eval-time t)
          (if (or (eq when 'load) (eq when :load-toplevel))
            (setq at-load-time t)
            (warn "Unknown EVAL-WHEN time ~s in ~S while compiling ~S."
                  when eval-times *fasl-source-file*)))))
    (fcomp-compile-toplevel-forms env)        ; always flush the suckers
    (cond (compile-time-only
           (if at-eval-time (fcomp-form-list form env :compile-time)))
          (at-load-time
           (fcomp-form-list form env (if (or at-compile-time (and at-eval-time compile-time-too))
                                       :compile-time-too
                                       :not-compile-time)))
          ((or at-compile-time (and at-eval-time compile-time-too))
           (fcomp-form-list form env :compile-time))))
  (fcomp-compile-toplevel-forms env))

(defun fcomp-include (form env processing-mode &aux file)
  (fcomp-compile-toplevel-forms env)
  (verify-arg-count form 1 1)
  (setq file (nx-transform (%cadr form) env))
  (unless (constantp file) (report-bad-arg file '(or string pathname)))
  (let ((actual (merge-pathnames (eval-constant file)
                                 (directory-namestring *compiling-file*))))
    (when *compile-print* (format t "~&~vTIncluding file ~A~%" *fcomp-indentation* actual))
    (let ((*fcomp-indentation* (+ 4 *fcomp-indentation*))
          (*package* *package*))
      (fcomp-read-loop (fcomp-find-file actual) actual env processing-mode *loading-external-format*)
      (fcomp-output-form $fasl-src env *loading-file-source-file*))
    (when *compile-print* (format t "~&~vTFinished included file ~A~%" *fcomp-indentation* actual))))

(defun remove-global-symbol-macro (symbol)
  (setq *nx-symbol-macros* (delete symbol *nx-symbol-macros* :key #'(lambda (x)(var-name x)))))

(defun remove-compile-time-symbol-macro (symbol)
  (setq *compile-time-symbol-macros* (delete symbol *compile-time-symbol-macros* :key #'(lambda (x)(var-name x)))))

(defun define-compile-time-constant (symbol initform env)
  (when (find-compile-time-symbol-macro symbol)
    (warn "Redefining the compile-time symbol macro ~s as a constant." symbol)
    (remove-compile-time-symbol-macro symbol))
  (note-variable-info symbol t env)
  (let ((definition-env (definition-environment env)))
    (when definition-env
      (multiple-value-bind (value error) 
                           (ignore-errors (values (%compile-time-eval initform env) nil))
        (when error
          (warn "Compile-time evaluation of DEFCONSTANT initial value form for ~S while ~
                 compiling ~S signalled the error: ~&~A" symbol *fasl-source-file* error))
        (push (cons symbol (if error (%unbound-marker-8) value)) (defenv.constants definition-env))))
    symbol))

;; this is also in l0-def without the global symbol macro business - doesn;t boot there
(defun %proclaim-special (sym &optional initp)
  (when (find-global-symbol-macro sym)
    (warn "Redefining global symbol macro ~s as a special" sym)
    (remove-global-symbol-macro sym))
  (let* ((oldbits (%symbol-bits sym)))
    (declare (fixnum oldbits))
    (%symbol-bits sym (bitset $sym_vbit_special oldbits))
    initp))


(defun fcomp-load-%defconstant (form env)
  (destructuring-bind (sym valform &optional doc) (cdr form)
    (unless *fasl-save-doc-strings*
      (setq doc nil))
    (if (quoted-form-p sym)
      (setq sym (%cadr sym)))
    (if (and (typep sym 'symbol) (or (numberp valform) (quoted-form-p valform) (null valform) (eq valform t)))
      (fcomp-output-form $fasl-defconstant env sym (eval-constant valform) (eval-constant doc))
      (fcomp-random-toplevel-form form env))))

(defun fcomp-load-%defparameter (form env)
  (destructuring-bind (sym valform &optional doc) (cdr form)
    (unless *fasl-save-doc-strings*
      (setq doc nil))
    (if (quoted-form-p sym)
      (setq sym (%cadr sym)))
    (let* ((fn (fcomp-function-arg valform env)))
      (if (and (typep sym 'symbol) (or fn (constantp valform)))
        (fcomp-output-form $fasl-defparameter env sym (or fn (eval-constant valform)) (eval-constant doc))
        (fcomp-random-toplevel-form form env)))))

; Both the simple %DEFVAR and the initial-value case (%DEFVAR-INIT) come here.
; Only try to dump this as a special fasl operator if the initform is missing
;  or is "harmless" to evaluate whether needed or not (constant or function.)
; Hairier initforms could be handled by another fasl operator that takes a thunk
; and conditionally calls it.
(defun fcomp-load-defvar (form env)
  (destructuring-bind (sym &optional (valform nil val-p) doc) (cdr form)
    (unless *fasl-save-doc-strings*
      (setq doc nil))
    (if (quoted-form-p sym)             ; %defvar quotes its arg, %defvar-init doesn't.
      (setq sym (%cadr sym)))
    (let* ((sym-p (typep sym 'symbol)))
      (if (and sym-p (not val-p))
        (fcomp-output-form $fasl-defvar env sym)
        (let* ((fn (if sym-p (fcomp-function-arg valform env))))
          (if (and sym-p (or fn (constantp valform)))
            (fcomp-output-form $fasl-defvar-init env sym (or fn (eval-constant valform)) (eval-constant doc))
            (fcomp-random-toplevel-form (macroexpand-1 form env) env)))))))
      
(defun define-compile-time-macro (name lambda-expression env)
  (let ((definition-env (definition-environment env)))
    (if definition-env
      (push (list* name 
                   'macro 
                   (compile-named-function lambda-expression name t env)) 
            (defenv.functions definition-env)))
    name))





(defun fcomp-proclaim-type (type syms)
  (dolist (sym syms)
    (if (symbolp sym)
    (push (cons sym type) *nx-compile-time-types*)
      (warn "~S isn't a symbol in ~S type declaration while compiling ~S."
            sym type *fasl-source-file*))))

(defun compile-time-proclamation (specs env &aux  sym (defenv (definition-environment env)))
  (when defenv
    (dolist (spec specs)
      (setq sym (pop spec))
      (case sym
        (type
         (fcomp-proclaim-type (car spec) (cdr spec)))
        (special
         (dolist (sym spec)
           (push (cons (require-type sym 'symbol) nil) (defenv.specials defenv))))
        (notspecial
         (let ((specials (defenv.specials defenv)))
           (dolist (sym spec (setf (defenv.specials defenv) specials))
             (let ((pair (assq sym specials)))
               (when pair (setq specials (nremove pair specials)))))))
        (optimize
         (%proclaim-optimize spec))
        (inline
         (dolist (sym spec)
           (push (cons (maybe-setf-function-name sym) (cons 'inline 'inline)) (lexenv.fdecls defenv))))
        (notinline
         (dolist (sym spec)
           (unless (compiler-special-form-p sym)
             (push (cons (maybe-setf-function-name sym) (cons 'inline 'notinline)) (lexenv.fdecls defenv)))))
        (declaration
         (dolist (sym spec)
           (pushnew (require-type sym 'symbol) *nx-known-declarations*)))
        (ignore
         (dolist (sym spec)
           (push (cons (require-type sym 'symbol) t) *nx-proclaimed-ignore*)))
        (unignore
         (dolist (sym spec)
           (push (cons (require-type sym 'symbol) nil) *nx-proclaimed-ignore*)))
        (ftype 
         (let ((ftype (car spec))
               (fnames (cdr spec)))
           ;; ----- this part may be redundant, now that the lexenv.fdecls part is being done
           (if (and (consp ftype)
                    (consp fnames)
                    (eq (%car ftype) 'function))
             (dolist (fname fnames)
               (note-function-info fname nil env)))
           (dolist (fname fnames)
             (push (list* (maybe-setf-function-name fname) sym ftype) (lexenv.fdecls defenv)))))
        (otherwise 
         (if (type-specifier-p (if (consp sym) (%car sym) sym)) ; *cl-types*)
           (fcomp-proclaim-type sym spec)       ; A post-cltl2 cleanup issue changes this
           nil)                         ; ---- probably ought to complain
         )))))

(defun fcomp-load-%defun (form env)
  (destructuring-bind (fn &optional doc) (cdr form)
    (unless *fasl-save-doc-strings*
      (if (consp doc)
        (if (and (eq (car doc) 'quote) (consp (cadr doc)))
          (setf (car (cadr doc)) nil))
        (setq doc nil)))
    (if (and (constantp doc)
             (setq fn (fcomp-function-arg fn env)))
      (progn
        (setq doc (eval-constant doc))
        (fcomp-output-form $fasl-defun env fn doc))
      (fcomp-random-toplevel-form form env))))

(defun fcomp-load-%macro (form env &aux fn doc)
  (verify-arg-count form 1 2)
  (if (and (constantp (setq doc (caddr form)))
           (setq fn (fcomp-function-arg (cadr form) env)))
    (progn
      (setq doc (eval-constant doc))
      (fcomp-output-form $fasl-macro env fn doc))
    (fcomp-random-toplevel-form form env)))

(defun define-compile-time-structure (sd refnames predicate env)
  (let ((defenv (definition-environment env)))
    (when defenv
      (setf (defenv.structures defenv) (alist-adjoin (sd-name sd) sd (defenv.structures defenv)))
      (let* ((structrefs (defenv.structrefs defenv)))
        (when (and (null (sd-type sd))
                   predicate)
          (setq structrefs (alist-adjoin predicate (sd-name sd) structrefs)))
        (dolist (slot (sd-slots sd))
          (unless (fixnump (ssd-name slot))
            (setq structrefs
                (alist-adjoin (if refnames (pop refnames) (ssd-name slot))
                              (ssd-type-and-refinfo slot)
                              structrefs))))
        (setf (defenv.structrefs defenv) structrefs)))))


; call NX-TRANSFORM, but with the appropriate set of compiler-macros for the target.
; Cross-compilation-bootstrapping-nonsense.

(defun fcomp-transform (form env)
  (let* #-ppc-target ((*target-compiler-macros* (if (eq *fasl-target* :m68k)
                                     *68k-target-compiler-macros*
                                     *ppc-target-compiler-macros*)))
        #+ppc-target ()
    (nx-transform form env)))

(defun fcomp-random-toplevel-form (form env)
  (unless (constantp form)
    (unless (or (atom form) (compiler-special-form-p (%car form)))
      ;Pre-compile any lfun args.  This is an efficiency hack, since compiler
      ;reentering itself for inner lambdas tends to be more expensive than
      ;top-level compiles.
      ;This assumes the form has been macroexpanded, or at least none of the
      ;non-evaluated macro arguments could look like functions.
      (let (lfun (args (%cdr form)))
        (while args
          (multiple-value-bind (arg win) (fcomp-transform (%car args) env)
            (when (or (setq lfun (fcomp-function-arg arg env))
                      win)
              (when lfun (setq arg `',lfun))
              (labels ((subst-l (new ptr list)
                         (if (eq ptr list) (cons new (cdr list))
		             (cons (car list) (subst-l new ptr (%cdr list))))))
                (setq form (subst-l arg args form))))
            (setq args (%cdr args))))))
    (push form *fcomp-toplevel-forms*)))

(defun fcomp-function-arg (expr env)
  (when (consp expr)
    (if (and (eq (%car expr) 'nfunction)
             (symbolp (car (%cdr expr)))
             (lambda-expression-p (car (%cddr expr))))
      (fcomp-named-function (%caddr expr) (%cadr expr) env)
      (if (and (eq (%car expr) 'function)
               (lambda-expression-p (car (%cdr expr))))
        (fcomp-named-function (%cadr expr) nil env)))))

(defun fcomp-compile-toplevel-forms (env)
  (when *fcomp-toplevel-forms*
    (let* ((forms (nreverse *fcomp-toplevel-forms*))
           (lambda (if (null (cdr forms))
                     `(lambda () (progn ,@forms))
                     `(lambda ()
                        (macrolet ((load-time-value (value)
                                     (declare (ignore value))
                                     (compiler-function-overflow)))
                          ,@forms)))))
      (setq *fcomp-toplevel-forms* nil)
      ;(format t "~& Random toplevel form: ~s" lambda)
      (handler-case (fcomp-output-form
                     $fasl-lfuncall
                     env
                     (fcomp-named-function lambda nil env))
        (compiler-function-overflow ()
          (if (null (cdr forms))
            (error "Form ~s cannot be compiled - size exceeds compiler limitation"
                   (%car forms))
            ; else compile each half :
            (progn
              (dotimes (i (floor (length forms) 2))
                (declare (fixnum i))
                (push (pop forms) *fcomp-toplevel-forms*))
              (fcomp-compile-toplevel-forms env)
              (setq *fcomp-toplevel-forms* (nreverse forms))
              (fcomp-compile-toplevel-forms env))))))))

(defun fcomp-output-form (opcode env &rest args)
  (when *fcomp-toplevel-forms* (fcomp-compile-toplevel-forms env))
  (push (cons opcode args) *fcomp-output-list*))

;Compile a lambda expression for the sole purpose of putting it in a fasl
;file.  The result will not be funcalled.  This really shouldn't bother
;making an lfun, but it's simpler this way...
(defun fcomp-named-function (def name env)
  (let* ((env (new-lexical-environment env)))
    (multiple-value-bind (lfun warnings)
                         (funcall 
                          #+ppc-target
                          #'compile-named-function
                          #-ppc-target
                          (if (eq *fasl-target* :m68k) #'compile-named-function #'ppc-compile-named-function)
                          def name t
                          env
                          *fasl-save-definitions*
                          *fasl-save-local-symbols*
                          *default-file-compilation-policy*
                          cfasl-load-time-eval-sym)
      (fcomp-signal-or-defer-warnings warnings env)
      lfun)))

; For now, defer only UNDEFINED-FUNCTION-REFERENCEs, signal all others via WARN.
; Well, maybe not WARN, exactly.
(defun fcomp-signal-or-defer-warnings (warnings env)
  (let ((init (null *fcomp-warnings-header*))
        (some *fasl-warnings-signalled-p*)
        (harsh *fasl-non-style-warnings-signalled-p*))
    (dolist (w warnings)
      (setf (compiler-warning-file-name w) *fasl-source-file*)
      (if (and (typep w 'undefined-function-reference) 
               (eq w (setq w (macro-too-late-p w env))))
        (push w *fasl-deferred-warnings*)
        (progn
          (multiple-value-setq (harsh some *fcomp-warnings-header*)
                               (signal-compiler-warning w init *fcomp-warnings-header* harsh some))
          (setq init nil))))
    (setq *fasl-warnings-signalled-p* some
          *fasl-non-style-warnings-signalled-p* harsh)))

; If W is an UNDEFINED-FUNCTION-REFERENCE which refers to a macro (either at compile-time in ENV
; or globally), cons up a MACRO-USED-BEFORE-DEFINITION warning and return it; else return W.

(defun macro-too-late-p (w env)
  (let* ((args (compiler-warning-args w))
         (name (car args)))
    (if (or (macro-function name)
            (let* ((defenv (definition-environment env))
                   (info (if defenv (assq name (defenv.functions defenv)))))
              (and (consp (cdr info))
                   (eq 'macro (cadr info)))))
      (make-instance 'macro-used-before-definition
        :file-name (compiler-warning-file-name w)
        :function-name (compiler-warning-function-name w)
        :warning-type ':macro-used-before-definition
        :args args)
      w)))


              
;;;;          fasl-scan - dumping reference counting
;;;;
;;;;
;These should be constants, but it's too much trouble when need to change 'em.
(defparameter FASL-FILE-ID #xFF00)  ;Overall file format, shouldn't change much
(defparameter FASL-VERSION #xFF40)  ;Fasl block format.

(defvar *fasdump-hash*)
(defvar *fasdump-read-package*)
(defvar *fasdump-global-offsets*)
(defvar *make-load-form-hash*)

;Return a hash table containing subexp's which are referenced more than once.
(defun fasl-scan (forms)
  (let* ((*fasdump-hash* (make-hash-table :size (length forms)          ; Crude estimate
                                          :rehash-threshold 0.9
                                          :test 'eq))
         (*make-load-form-hash* (make-hash-table :test 'eq))
         (*fasdump-read-package* nil)
         (*fasdump-global-offsets* nil)
         (gsymbols nil))
    (dolist (op forms)
      (if (packagep op) ; old magic treatment of *package*
        (setq *fasdump-read-package* op)
        (dolist (arg (cdr op)) (fasl-scan-form arg))))
    #-ppc-target
    (when *fasdump-global-offsets*
      (setq 
       gsymbols (fasl-offset-symbols *fasdump-global-offsets*)
       *fasdump-global-offsets* (coerce *fasdump-global-offsets* '(vector (signed-byte 16))))
      (fasl-scan-form gsymbols))
    #-bccl (when (eq *compile-verbose* :debug)
             (format t "~&~S forms, ~S entries -> "
                     (length forms)
                     (hash-table-count *fasdump-hash*)))
    (maphash #'(lambda (key val)
                 (when (%izerop val) (remhash key *fasdump-hash*)))
             *fasdump-hash*)
    #-bccl (when (eq *compile-verbose* :debug)
             (format t "~S." (hash-table-count *fasdump-hash*)))
    (values *fasdump-hash*
            gsymbols
            *fasdump-global-offsets*)))

;During scanning, *fasdump-hash* values are one of the following:
;  nil - form hasn't been referenced yet.
;   0 - form has been referenced exactly once
;   T - form has been referenced more than once
;  (load-form scanning-p referenced-p initform)
;     form should be replaced by load-form
;     scanning-p is true while we're scanning load-form
;     referenced-p is nil if unreferenced,
;                     T if referenced but not dumped yet,
;                     0 if dumped already (fasl-dump-form uses this)
;     initform is a compiled version of the user's initform
(defun fasl-scan-form (form)
  (when form
    (let ((info (gethash form *fasdump-hash*)))
      (cond ((null info)
             (fasl-scan-dispatch form))
            ((eql info 0)
             (puthash form *fasdump-hash* t))
            ((listp info)               ; a make-load-form form
             (when (cadr info)
               (error "Circularity in ~S for ~S" 'make-load-form form))
             (let ((referenced-cell (cddr info)))
               (setf (car referenced-cell) t)   ; referenced-p
               (setf (gethash (car info) *fasdump-hash*) t)))))))




(defun fasl-scan-dispatch (exp)
  (let ((type-code (ppc-typecode exp)))
    (declare (fixnum type-code))
    (case type-code
      (#.ppc::tag-fixnum
       (fasl-scan-fixnum exp))
      (#.ppc::tag-list (fasl-scan-list exp))
      (#.ppc::tag-imm)
      (t
       (if (= (the fixnum (logand type-code ppc::full-tag-mask)) ppc::fulltag-immheader)            
           (case type-code
             ((#.ppc::subtag-macptr #.ppc::subtag-dead-macptr) (fasl-unknown exp))
             (t (fasl-scan-ref exp)))
           (case type-code
             ((#.ppc::subtag-pool #.ppc::subtag-weak #.ppc::subtag-lock) (fasl-unknown exp))
             (#.ppc::subtag-symbol (fasl-scan-ppc-symbol exp))
             ((#.ppc::subtag-instance #.ppc::subtag-struct)
              (fasl-scan-user-form exp))
             (#.ppc::subtag-package (fasl-scan-ref exp))
             (#.ppc::subtag-istruct
              (if (memq (uvref exp 0) *istruct-make-load-form-types*)
                (progn
                  (if (hash-table-p exp)
                    (fasl-lock-hash-table exp))
                  (fasl-scan-user-form exp))
                (fasl-scan-gvector exp)))
             (t (fasl-scan-gvector exp))))))))
              

(defun fasl-scan-ref (form)
  (puthash form *fasdump-hash* 0))

(defun fasl-scan-fixnum (fixnum)
  (unless (short-fixnum-p fixnum) (fasl-scan-ref fixnum)))

(defparameter *istruct-make-load-form-types*
  '(macho-entry-point lexical-environment shared-library-descriptor shared-library-entry-point
    ctype unknown-ctype class-ctype foreign-ctype union-ctype member-ctype 
    array-ctype numeric-ctype hairy-ctype named-ctype constant-ctype args-ctype
    hash-table))


(defun fasl-scan-gvector (vec)
  (fasl-scan-ref vec)
  (dotimes (i (uvsize vec)) 
    (declare (fixnum i))
    (fasl-scan-form (%svref vec i))))

(defun funcall-lfun-p (form)
  (and (listp form)
       (eq (%car form) 'funcall)
       (listp (%cdr form))
       (or (functionp (%cadr form))
           #-ppc-target
           (and (uvectorp (%cadr form))
                (eq (%vect-subtype (%cadr form))
                    52)))                 ; 52 = $xppc-function-vector
       (null (%cddr form))))

(defun fasl-scan-list (list)
  (cond ((eq (%car list) cfasl-load-time-eval-sym)
         (let ((form (car (%cdr list))))
           (fasl-scan-form (if (funcall-lfun-p form)
                             (%cadr form)
                             form))))
        (t (when list
             (fasl-scan-ref list)
             (fasl-scan-form (%car list))
             (unless (and (not (listp (cdr list)))(eq list (gethash (car list) %find-classes%)))
               (fasl-scan-form (%cdr list)))))))

(defun fasl-scan-user-form (form &optional (env *the-definition-environment*))
  (multiple-value-bind (load-form init-form) (make-load-form form env)
    (labels ((simple-load-form (form)
               (or (atom form)
                   (let ((function (car form)))
                     (or (eq function 'quote)
                         (and (symbolp function)
                              ;; using fboundp instead of symbol-function
                              ;; see comments in symbol-function
                              (or (functionp (fboundp function))
                                  (eq function 'progn))
                              ;; (every #'simple-load-form (cdr form))
                              (dolist (arg (cdr form) t)
                                (unless (simple-load-form arg)
                                  (return nil))))))))
             (load-time-eval-form (load-form form type)
               (cond ((quoted-form-p load-form)
                      (%cadr load-form))
                     ((self-evaluating-p load-form)
                      load-form)
                     ((simple-load-form load-form)
                      `(,cfasl-load-time-eval-sym ,load-form))
                     (t (multiple-value-bind (lfun warnings)
                                             (or
                                              (gethash load-form *make-load-form-hash*)
                                              (fcomp-named-function `(lambda () ,load-form) nil env))
                          (when warnings
                            (cerror "Ignore the warnings"
                                    "Compiling the ~s ~a form for~%~s~%produced warnings."
                                    'make-load-form type form))
                          (setf (gethash load-form *make-load-form-hash*) lfun)
                          `(,cfasl-load-time-eval-sym (funcall ,lfun)))))))
      (declare (dynamic-extent #'simple-load-form #'load-time-eval-form))
      (let* ((compiled-initform
              (and init-form (load-time-eval-form init-form form "initialization")))
             (info (list (load-time-eval-form load-form form "creation")
                         T              ; scanning-p
                         nil            ; referenced-p
                         compiled-initform  ;initform-info
                         )))
        (puthash form *fasdump-hash* info)
        (fasl-scan-form (%car info))
        (setf (cadr info) nil)        ; no longer scanning load-form
        (when init-form
          (fasl-scan-form compiled-initform))))))

(defun fasl-scan-ppc-symbol (form)
  (fasl-scan-ref form)
  (fasl-scan-form (symbol-package form)))
  
#-ppc-target
(defun fasl-scan-symbol-type (form &aux pkg)
  (fasl-scan-ref form)
  (if (symbolp form)
    (when (setq pkg (symbol-package form))
      (fasl-scan-form pkg))
    (fasl-scan-form (%symbol-locative-symbol form))))

#-ppc-target
(defun fasl-offset-symbols (offsetlist)
  (let* ((len (length offsetlist))
         (symbols (make-array len)))
    (dotimes (i len)
      (declare (fixnum i))
      (setf (svref symbols i) (nilreg-cell-symbol (pop offsetlist))))
    symbols))

;;;;          Pass 3 - dumping
;;;;
;;;;
(defvar *fasdump-epush*)
(defvar *fasdump-stream*)
(defvar *fasdump-writer*)
(defvar *fasdump-writer-arg*)
(defvar *fasdump-eref*)

(defun fasl-dump-file (gnames goffsets forms hash filename)
  (let ((opened? nil)
        (finished? nil))
    (unwind-protect
      (with-open-file (*fasdump-stream* filename :direction :output
                                        :element-type 'base-character ; huh
                                        :if-exists :supersede
                                        :if-does-not-exist :create
                                        :external-format (if (eq *fasl-target* :m68k) :fasl :pfsl))
        (setq opened? t)
        (multiple-value-bind (*fasdump-writer* *fasdump-writer-arg*) (stream-writer *fasdump-stream*)
          ;(set-mac-file-type filename :fasl)
          (fasl-set-filepos 0)
          (fasl-out-word 0)             ;Will become the ID word
          (fasl-out-word 1)             ;One block in the file
          (fasl-out-long 12)            ;Block starts at file pos 12
          (fasl-out-long 0)             ;Length will go here
          (fasl-dump-block gnames goffsets forms hash)  ;Write the block
          (let ((pos (fasl-filepos)))
            (fasl-set-filepos 8)        ;Back to length longword
            (fasl-out-long (- pos 12))) ;Write length
          (fasl-set-filepos 0)          ;Seem to have won, make us legal
          (fasl-out-word FASL-FILE-ID)
          (setq finished? t)
          filename))
      (when (and opened? (not finished?))
        (delete-file filename)))))

(defun fasl-dump-block (gnames goffsets forms hash)
  (let ((etab-size (hash-table-count hash)))
    (when (> etab-size 65535)
      (error "Too many multiply-referenced objects in fasl file.~%Limit is ~d. Were ~d." 65535 etab-size))
    (fasl-out-word FASL-VERSION)          ; Word 0
    (fasl-out-long #-ppc-target (%get-long (%currentA5) $verslong) #+ppc-target 0)
    (fasl-out-byte $fasl-etab-alloc)
    (fasl-out-long etab-size)
    (fasl-dump gnames goffsets forms hash)
    (fasl-out-byte $fasl-end)))

(defun fasl-dump (gnames goffsets forms hash)
  (let* ((*fasdump-hash* hash)
         (*fasdump-read-package* nil)
         (*fasdump-epush* nil)
         (*fasdump-eref* -1)
         #+ppc-target (*fasdump-code-buffer* nil)
         (*fasdump-global-offsets* goffsets))
    #+ppc-target (declare (special *fasdump-code-buffer*))
    (when gnames
      (fasl-out-byte $fasl-globals)
      (fasl-dump-form gnames))
    (dolist (op forms)
      (if (packagep op)
        (setq *fasdump-read-package* op)
        (progn
          (fasl-out-byte (car op))
          (dolist (arg (cdr op)) (fasl-dump-form arg)))))))

;During dumping, *fasdump-hash* values are one of the following:
;   nil - form has no load form, is referenced at most once.
;   fixnum - form has already been dumped, fixnum is the etab index.
;   T - form hasn't been dumped yet, is referenced more than once.
;  (load-form . nil) - form should be replaced by load-form.
(defun fasl-dump-form (form)
  (let ((info (gethash form *fasdump-hash*)))
    (cond ((fixnump info)
           (fasl-out-byte $fasl-eref)
           (fasl-out-word info))
          ((consp info)
           (fasl-dump-user-form form info))
          (t
           (setq *fasdump-epush* info)
           (fasl-dump-dispatch form)))))

(defun fasl-dump-user-form (form info)
  (let* ((load-form (car info))
         (referenced-p (caddr info))
         (initform (cadddr info)))
    (when referenced-p
      (unless (gethash load-form *fasdump-hash*)
        (error "~s was not in ~s.  This shouldn't happen." 'load-form '*fasdump-hash*)))
    (when initform
      (fasl-out-byte $fasl-prog1))      ; ignore the initform
    (fasl-dump-form load-form)
    (when referenced-p
      (setf (gethash form *fasdump-hash*) (gethash load-form *fasdump-hash*)))
    (when initform
      (fasl-dump-form initform))))

(defun fasl-out-opcode (opcode form)
  (if *fasdump-epush*
    (progn
      (setq *fasdump-epush* nil)
      (fasl-out-byte (fasl-epush-op opcode))
      (fasl-dump-epush form))
    (fasl-out-byte opcode)))

(defun fasl-dump-epush (form)
  #-bccl (when (fixnump (gethash form *fasdump-hash*))
           (error "Bug! Duplicate epush for ~S" form))
  (puthash form *fasdump-hash* (setq *fasdump-eref* (1+ *fasdump-eref*))))

#-ppc-target
(defun fasl-dump-dispatch (exp)
  (if (eq *fasl-target* :m68k)
    (fasl-dump-dispatch-m68k exp)
    (fasl-dump-dispatch-ppc exp)))

#-ppc-target
(defun fasl-dump-dispatch-m68k (&lap #x100) ;(exp)
  (old-lap
   (ttag arg_z da)
   (add.w da da)
   (jmp (pc da.w 2))
   (bra fasl-dump-fixnum)
   (bra fasl-dump-uvector-type)
   (bra fasl-dump-symbol-type)
   (bra fasl-dump-float)
   (bra fasl-dump-list)
   (bra fasl-timm)
   (bra fasl-dump-lfun)
   (if# (or (eq (cmp.b ($ #x0f) arg_z)) (eq (cmp.b ($ $t_imm_char) arg_z)))
     (jmp #'fasl-dump-char))
   fasl-timm (jmp #'fasl-dump-T_imm)
   fasl-dump-fixnum (jmp #'fasl-dump-fixnum)
   fasl-dump-uvector-type (jmp #'fasl-dump-uvector-type)
   fasl-dump-symbol-type (jmp #'fasl-dump-symbol-type)
   fasl-dump-float (jmp #'fasl-dump-float)
   fasl-dump-list (jmp #'fasl-dump-list)
   fasl-dump-lfun (jmp #'fasl-dump-lfun)))

#-ppc-target
(progn                                  
; This is all stuff about how to cross-dump a PPC fasl file
; from a 68K world.  We only need it when bootstrapping, e.g.,
; before the code in this file works.  Paradoxical.

(defparameter *m68k-to-ppc-ivector-subtypes-alist*
  `(( 0 . nil)
    (, $v_bignum . , ppc::subtag-bignum)
    (, $v_macptr . , ppc::subtag-macptr)
    (, $v_badptr . nil)
    (, $v_nlfunv . nil)
    (10 . , ppc::subtag-code-vector)
    (, $v_xstr . , ppc::subtag-simple-general-string)
    (, $v_ubytev . , ppc::subtag-u8-vector)
    (, $v_uwordv . , ppc::subtag-u16-vector)
    (, $v_floatv . , ppc::subtag-double-float-vector)
    (, $v_slongv . , ppc::subtag-s32-vector)
    (, $v_ulongv . , ppc::subtag-u32-vector)
    (, $v_bitv . , ppc::subtag-bit-vector)
    (, $v_sbytev . , ppc::subtag-s8-vector)
    (, $v_swordv . , ppc::subtag-s16-vector)
    (, $v_sstr . , ppc::subtag-simple-base-string)))

(defparameter *m68k-to-ppc-gvector-subtypes-alist*
  `((, $v_genv . , ppc::subtag-simple-vector)
    (, $v_arrayh . (, ppc::subtag-arrayH , ppc::subtag-vectorH))
    (, $v_struct . , ppc::subtag-struct)
    (, $v_mark . , ppc::subtag-mark)
    (, $v_pkg . , ppc::subtag-package)
    (, $v_lock . , ppc::subtag-lock)
    (, $v_istruct . , ppc::subtag-istruct)
    (, $v_ratio . , ppc::subtag-ratio)
    (, $v_complex . , ppc::subtag-complex)
    (, $v_instance . , ppc::subtag-instance)
    ( 52 . , ppc::subtag-function)
    (54 . nil)
    (, $v_sgbuf . nil)
    (, $v_weakh . , ppc::subtag-weak)
    (, $v_poolfreelist . , ppc::subtag-pool)
    (, $v_nhash . , ppc::subtag-hash-vector)))

(defun fasl-dump-dispatch-ppc (exp)
  (flet ((cant-xdump (thing) (error "Can't dump ~S to PPC-targeted fasl file. " thing)))
    (typecase exp
      ((signed-byte 30)
       (if (typep exp '(signed-byte 16))
         (progn
           (fasl-out-opcode $fasl-word-fixnum exp)
           (fasl-out-word exp))
         (progn
           (fasl-out-opcode $fasl-fixnum exp)
           (fasl-out-long exp))))
      (double-float (fasl-dump-float exp))
      (function (cant-xdump exp))
      (character (fasl-dump-char exp))
      (package (fasl-dump-package exp))
      (list (fasl-dump-list exp))
      (symbol (fasl-dump-symbol exp))
      (t
       (if (uvectorp exp)
         (fasl-dump-ppc-uvector exp)
         (cant-xdump exp))))))

(defun fasl-dump-ppc-uvector (exp)
  (let* ((68k-subtype (%vect-subtype exp)))
    (declare (fixnum 68k-subtype))
    (if (logbitp $vnodebit 68k-subtype)
      (fasl-dump-ppc-gvector 68k-subtype exp)
      (fasl-dump-ppc-ivector 68k-subtype exp))))

(defun fasl-dump-ppc-gvector (68k-subtype gv)
  (let* ((ppc-subtag (cdr (assoc 68k-subtype *m68k-to-ppc-gvector-subtypes-alist*))))
    (unless ppc-subtag (error "Can't dump ~S to PPC-targeted fasl file. " gv))
    (if (atom ppc-subtag)
      (let* ((n (uvsize gv)))
        (declare (fixnum n))
        (fasl-out-opcode $fasl-gvec gv)         ; maybe special-case ppc::subtag-function ?
        (fasl-out-byte ppc-subtag)
        (fasl-out-size n)
        (dotimes (i n)
          (fasl-dump-form (%svref gv i))))
      (error "Complex arrays confuse me - ~s. " gv))))
        

; This special-cases simple-base-strings. and bignums
; Otherwise, the general idea is to dump the $fasl-ivec opcode, the PPC subtag,
;  the (logical) length of the object, and the ivector's contents.  If the
;  ivector is a simple-bit-vector, we skip the first (size-correction) byte of
;  its contents, since that isn't needed on the PPC.
;  The loader knows how many bytes to read from the subtag and the element-count.
(defun fasl-dump-ppc-ivector (68k-subtype iv)
  (let* ((ppc-subtag (cdr (assoc 68k-subtype *m68k-to-ppc-ivector-subtypes-alist*))))
    (unless ppc-subtag (error "Can't dump ~S to PPC-targeted fasl file. " iv))
    
    (let* ((n (uvsize iv))
           (nb (%vect-byte-size iv)))
      (declare (fixnum n nb))
      (if (typep iv 'bignum)
        (fasl-dump-ppc-bignum iv ppc-subtag)
        (progn
          (if (typep iv 'simple-base-string)
            (fasl-out-opcode $fasl-str iv)
            (progn
              (fasl-out-opcode $fasl-ivec iv)
              (fasl-out-byte ppc-subtag)))
          (fasl-out-size n)
          (if (typep iv 'simple-bit-vector)
            (fasl-out-ivect iv 1 (1- nb))
            (fasl-out-ivect iv 0 nb)))))))


; transform from sign magnitude, 16 bit digits, forward order
; to 2's complement, 32 bit digits, reverse order
; looks like if neg we have to fill sign to MSB in high digit.

; version 2 - slop is in high order bigit of last long word
(defun fasl-dump-ppc-bignum (num ppc-subtag)
  (flet (#|(fasl-out-opcode (a b))
         (fasl-out-size (a))
         (fasl-out-word (a) (print (logand a #xffff)))
         (fasl-out-byte (n) (print (logand n #xff)))|#)
    (let* ((n16 (uvsize num))) ; size in 16 bit bytes
      (fasl-out-opcode $fasl-ivec num)
      (fasl-out-byte ppc-subtag)
      (fasl-out-size (ceiling n16 2)) ; num longs
      ; seems to think the darn things are signed
      (if (not (minusp num))
        (let ((end (1- n16)))
          (loop
            (let ((bigit (if (eq end 0) 0 (uvref num (1- end)))))
              (fasl-out-word bigit)
              (setq bigit (uvref num end))
              (fasl-out-word bigit))
            (setq end (- end 2))
            (if (< end 0) (return))))
        (let ((end (1- n16))
              (carry 1)
              (sign-fix (sign-thing (uvref num 0))))
          (loop
            (let ((high-bigit (if (eq end 0) #XFFFF (%ilogand #xffff (uvref num (1- end)))))
                  (low-bigit (%ilogand (uvref num end) #xffff)))
              (setq low-bigit (+ (logand #xffff (lognot low-bigit)) carry))
              (setq carry (if (%ilogbitp 16 low-bigit) 1 0))
              (setq high-bigit (+ (logand #xffff (lognot high-bigit)) carry))
              (setq carry (if (%ilogbitp 16 high-bigit) 1 0))
              (if (eq end 0)
                (setq low-bigit (logior sign-fix low-bigit))
                (if (eq end 1)
                  (setq high-bigit (logior sign-fix high-bigit))))
              (if (eq end 0)
                (fasl-out-word #xffff)
                (fasl-out-word high-bigit))
              (fasl-out-word low-bigit))
            (setq end (- end 2))
            (if (< end 0) (return))))))))

(defun sign-thing (bigit) ; thing to extend minus sign to first 1 in bigit
  (let ((mask #x8000))
    (do* ((i 14 (1- i)))
        ((< i 0))
      (when (logbitp i bigit)(return))
      (setq mask (bitset i mask)))
    mask))

)

#+ppc-target
(progn
;Write to a PPC fasl file from a PPC host.

(defun fasl-dump-dispatch (exp)
  (let* ((typecode (ppc-typecode exp)))
    (declare (fixnum typecode))
    (case typecode
      (#.ppc::tag-fixnum (fasl-dump-fixnum exp))
      (#.ppc::tag-list (fasl-dump-list exp))
      (#.ppc::tag-imm (if (characterp exp) (fasl-dump-char exp) (fasl-dump-t_imm exp)))
      (t
       (if (= (the fixnum (logand typecode ppc::fulltagmask)) ppc::fulltag-immheader)
         ; Double-floats and simple-base-strings get special treatment.  For everything else,
         ; dump a $fasl-imm opcode, the subtag (typecode), and the raw data.  (For
         ; double-float vectors, skip the first 4 bytes of raw data.)
         ; Code vectors have to be dumped in "normalized" form.
         (if (= typecode ppc::subtag-double-float)
           (fasl-dump-dfloat exp)
           (let* ((n (uvsize exp))
                  (nb (ppc-subtag-bytes typecode n)))
             (declare (fixnum n nb))
             (if (= typecode ppc::subtag-simple-base-string)
               (fasl-out-opcode $fasl-str exp)
               (progn
                 (fasl-out-opcode $fasl-ivec exp)
                 (fasl-out-byte typecode)))
             (fasl-out-size n)
             (if (= typecode ppc::subtag-double-float-vector)
               ; Account for alignment word - done now by ppc-subtag-bytes
               (fasl-out-ivect exp 0 nb)
               (if (= typecode ppc::subtag-code-vector)
                 (fasl-out-codevector exp nb)
                 (fasl-out-ivect exp 0 nb)))))
         (if (= typecode ppc::subtag-package)
           (fasl-dump-package exp)
           (if (= typecode ppc::subtag-symbol)
             (fasl-dump-symbol exp)
             (let* ((n (uvsize exp)))
               (declare (fixnum n))
               (fasl-out-opcode $fasl-gvec exp)
               (fasl-out-byte typecode)
               (fasl-out-size n)
               (dotimes (i n)
                 (fasl-dump-form (%svref exp i)))))))))))

;; this is also in level-0;ppc;ppc-array.lisp - here so don't have to rebuild level-0
(defun ppc-subtag-bytes (subtag element-count)
  (declare (fixnum subtag element-count))
  (unless (= #.ppc::fulltag-immheader (logand subtag #.ppc::fulltagmask))
    (error "Not an ivector subtag: ~s" subtag))
 (let* ((element-bit-shift
          (if (<= subtag ppc::max-32-bit-ivector-subtag)
            5
            (if (<= subtag ppc::max-8-bit-ivector-subtag)
              3
              (if (<= subtag ppc::max-16-bit-ivector-subtag)
                4
                (if (= subtag ppc::subtag-double-float-vector)
                  6
                  0)))))
         (total-bits (ash element-count element-bit-shift))
         (fudge (if (= subtag ppc::subtag-double-float-vector) 4 0)))
    (+ fudge (ash (+ 7 total-bits) -3))))

(defun fasl-out-codevector (codevector size-in-bytes)
  (declare (special *fasdump-code-buffer*) (fixnum size-in-bytes))
  (if (> size-in-bytes (length *fasdump-code-buffer*))
    (setq *fasdump-code-buffer* (make-array (the fixnum (+ size-in-bytes 512)) 
                                            :element-type '(unsigned-byte 32))))
  (%copy-ivector-to-ivector codevector 0 *fasdump-code-buffer* 0 size-in-bytes)
  (normalize-code-vector codevector *fasdump-code-buffer*)
  (fasl-out-ivect *fasdump-code-buffer* 0 size-in-bytes))
           
)

(defun fasl-dump-t_imm (imm)
  (fasl-out-opcode $fasl-timm imm)
  (fasl-out-long (%address-of imm)))

(defun fasl-dump-char (char)     ; << maybe not
  (let ((code (%char-code char)))
    (cond ((%i> code #xff)
           (fasl-out-opcode $fasl-xchar char)
           (fasl-out-word code))
          (t (fasl-out-opcode $fasl-char char)
             (fasl-out-byte code)))))

(defun fasl-dump-fixnum (fixnum)
  (if (short-fixnum-p fixnum)
    (progn
      (fasl-out-opcode $fasl-word-fixnum fixnum)
      (fasl-out-word fixnum))
    (progn
      (fasl-out-opcode $fasl-fixnum fixnum)
      (fasl-out-long fixnum))))
 
#-ppc-target
(defun fasl-dump-float (float)
  (fasl-out-opcode $fasl-float float)
  (old-lap-inline (float)
    (with-preserved-registers #(asave0 asave1)
      (lea #'fasl-out-word asave1)
      (move.l arg_z asave0)
      (moveq 0 arg_z)
      (move.w (asave0 (- $t_dfloat)) arg_z)
      (mkint arg_z)
      (set_nargs 1)
      (jsr @asave1)
      (move.w (asave0 (- 2 $t_dfloat)) arg_z)
      (mkint arg_z)
      (set_nargs 1)
      (jsr @asave1)
      (move.w (asave0 (- 4 $t_dfloat)) arg_z)
      (mkint arg_z)
      (set_nargs 1)
      (jsr @asave1)
      (move.w (asave0 (- 6 $t_dfloat)) arg_z)
      (mkint arg_z)
      (set_nargs 1)
      (jsr @asave1))))

#+ppc-target
(defun fasl-dump-dfloat (float)
  (fasl-out-opcode $fasl-float float)
  (fasl-out-ivect float 4 8))
                                                    
                 
  
#-ppc-target
(defun fasl-dump-uvector-type (uv)
  (cond ((packagep uv) (fasl-dump-package uv))
        ((eq (%type-of uv) 'lfun-vector) (fasl-dump-lfun-vector uv))
        ((%ilogbitp $vnodebit (%vect-subtype uv))
         (fasl-dump-gvector uv))
        (t (fasl-dump-ivector uv))))

#-ppc-target
(defun fasl-dump-ivector (iv)
  (if (simple-base-string-p iv)
    (fasl-out-opcode $fasl-str iv)  ; <<
    (progn
      (fasl-out-opcode $fasl-ivec iv)
      (fasl-out-byte (%vect-subtype iv))))
  (fasl-out-size (%vect-byte-size iv))
  (fasl-out-ivect iv))

(defun fasl-dump-package (pkg)
  (let ((name (package-name pkg)))
    (if (simple-base-string-p name)
      (progn
        (fasl-out-opcode $fasl-pkg pkg)
        (fasl-out-string name))
      (progn
        (fasl-out-opcode $fasl-xpkg pkg)
        (fasl-out-xstring name)))))

#-ppc-target
(defun fasl-dump-lfun-vector (lfunv)
  (let* ((uvsize (uvsize lfunv))
         (numimms (%count-immrefs lfunv))
         (immvect (make-array numimms))
         (immno -1))
    (declare (fixnum numimms immno uvsize) 
             (dynamic-extent immvect))
    (fasl-out-opcode $fasl-nlfvec lfunv)
    (fasl-out-size (+ uvsize uvsize))
    (fasl-out-word (uvref lfunv 0))
    (decf uvsize)
    (do* ((i 0 (1+ i))
          (j 1 (1+ j)))
         ((= i uvsize))
      (declare (fixnum i j))
      (if (%immref-p i lfunv)
        (progn
          (fasl-out-word 0)
          (multiple-value-bind (imm offset) (%nth-immediate lfunv (incf immno))
            (setf (svref immvect immno) imm)
            (fasl-out-word (or offset 0))
            (incf i)
            (incf j)))
        (fasl-out-word (uvref lfunv j))))
    (dotimes (i numimms)
      (declare (fixnum i))
      (fasl-dump-form (svref immvect i)))))

#-ppc-target
(defun fasl-global-offset-index (offset)
  (let ((idx (position offset *fasdump-global-offsets*)))
    (if (%i< offset 0) (%ilognot idx) idx)))

#-ppc-target
(defun fasl-dump-lfun (lfun &aux (lfunv (%lfun-vector lfun)))
  (let ((info (gethash lfunv *fasdump-hash*)))
    (cond ((fixnump info)
           (fasl-out-opcode $fasl-eref-lfun lfun)
           (fasl-out-word info))
          (*fasdump-epush*
           (fasl-out-byte (fasl-epush-op $fasl-lfun))
           (fasl-dump-form lfunv)
           (fasl-dump-epush lfun))
          (t
           (fasl-out-byte $fasl-lfun)
           (fasl-dump-form lfunv)))))

#-ppc-target
(defun fasl-dump-gvector (vec &aux (n (uvsize vec)))
  (fasl-out-opcode $fasl-gvec vec)
  (fasl-out-byte (%vect-subtype vec))
  (fasl-out-size n)
  (dotimes (i n) 
    (declare (fixnum i))
    (fasl-dump-form (%svref vec i))))

(defun fasl-dump-list (list)  
  (cond ((null list) (fasl-out-opcode $fasl-nil list))
        ((eq (%car list) cfasl-load-time-eval-sym)
         (let* ((form (car (%cdr list)))
                (opcode $fasl-eval))
           (when (funcall-lfun-p form)
             (setq opcode $fasl-lfuncall
                   form (%cadr form)))
           (if *fasdump-epush*
             (progn
               (fasl-out-byte (fasl-epush-op opcode))
               (fasl-dump-form form)
               (fasl-dump-epush list))
             (progn
               (fasl-out-byte opcode)
               (fasl-dump-form form)))))
        (t (if (and (not (listp (cdr list)))(eq list (gethash (car list) %find-classes%)))    
             (progn (setq list (cons cfasl-load-time-eval-sym `((find-class-cell ',(car list) t))))
                    (fasl-dump-list list))
             (fasl-dump-cons list)))))

; use $fasl-list*, $fasl-list if necessary
(defun fasl-dump-cons (cons &aux (end cons) (cdr-len 0))
  (declare (fixnum cdr-len))
  (while (and (consp (setq end (%cdr end)))
              (null (gethash end *fasdump-hash*)))
    (incf cdr-len))
  (cond ((eql 0 cdr-len)
         (fasl-out-opcode $fasl-cons cons))
        ((> cdr-len 65535)
         (fasl-out-opcode (if end $fasl-xlist* $fasl-xlist) cons)
         (fasl-out-long cdr-len))
        (t (fasl-out-opcode (if end $fasl-list* $fasl-list) cons)
           (fasl-out-word cdr-len)))
  (dotimes (i (the fixnum (1+ cdr-len)))
    (fasl-dump-form (%car cons))
    (setq cons (%cdr cons)))
  (when (or (eql 0 cdr-len) end)      ;cons or list*
    (fasl-dump-form end)))


#-ppc-target
(defun fasl-dump-symbol-type (exp)
  (if (symbolp exp) (fasl-dump-symbol exp) (fasl-dump-symbol-locative exp)))

(defun fasl-dump-symbol (sym &aux (pkg (symbol-package sym))
                                  (name (symbol-name sym))
                                  (base (simple-base-string-p name)))
  (cond ((null pkg) 
         (if base
           (progn 
             (fasl-out-opcode $fasl-mksym sym)
             (fasl-out-string name))
           (progn
             (fasl-out-opcode $fasl-mkxsym sym)
             (fasl-out-xstring name))))

        (*fasdump-epush*
         (if base
           (progn
             (fasl-out-byte (fasl-epush-op $fasl-pkg-intern))
             (fasl-dump-form pkg)
             (fasl-dump-epush sym)
             (fasl-out-string name))
           (progn
             (fasl-out-byte (fasl-epush-op $fasl-pkg-xintern))
             (fasl-dump-form pkg)
             (fasl-dump-epush sym)
             (fasl-out-xstring name))))
        (t
         (if base
           (progn
             (fasl-out-byte $fasl-pkg-intern)
             (fasl-dump-form pkg)
             (fasl-out-string name))
           (progn
             (fasl-out-byte $fasl-pkg-xintern)
             (fasl-dump-form pkg)
             (fasl-out-xstring name))))))

#-ppc-target
(defun fasl-dump-symbol-locative (locative)
  (fasl-unknown locative))

(defun fasl-unknown (exp)
  (error "Can't dump ~S - unknown type" exp))

(defun fasl-out-string (str)
  (fasl-out-size (length str))
  (fasl-out-ivect str))

(defun fasl-out-xstring (str) 
  ; really the same as fasl-out-string wherein byte-size = length
  ; could save 40 bytes or so by exploiting that
  (fasl-out-size #-ppc-target (%vect-byte-size str) 
                 #+ppc-target (ppc-subtag-bytes ppc::subtag-simple-general-string (length str)))
  (fasl-out-ivect str))



(defun fasl-out-size (size)
  (if (%i< size #xFF) (fasl-out-byte size)
      (progn (fasl-out-byte #xFF)
             (if (%i< size #xFFFF) (fasl-out-word size)
                 (progn (fasl-out-word #xFFFF) (fasl-out-long size))))))

(defun fasl-out-ivect (iv &optional 
                          (start 0) 
                          (nb 
                           #-ppc-target (%vect-byte-size iv)
                           #+ppc-target (ppc-subtag-bytes (ppc-typecode iv) (uvsize iv))))
  (%fwrite-from-vector (cdr *fasdump-writer-arg*) iv start nb))


(defun fasl-out-long (long)
  (fasl-out-word (ash long -16))
  (fasl-out-word (logand long #xFFFF)))

(defun fasl-out-word (word)
  (fasl-out-byte (%ilsr 8 word))
  (fasl-out-byte word))

(defun fasl-out-byte (byte)
;  (tyo (%code-char (%ilogand2 byte #xFF)) *fasdump-stream*))
   (funcall *fasdump-writer* *fasdump-writer-arg* (%code-char (%ilogand2 byte #xFF))))

(defun fasl-filepos ()
  (file-position *fasdump-stream*))

(defun fasl-set-filepos (pos)
  (file-position *fasdump-stream* pos)
  #-bccl (unless (eq (file-position *fasdump-stream*) pos)
           (error "Unable to set file position to ~S" pos)))


(provide 'nfcomp)

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
