;;;-*-Mode: LISP; Package: CCL -*-

;; $Log: nx.lisp,v $
;; Revision 1.2  2002/11/18 05:13:15  gtbyers
;; CVS mod history marker
;;
;;	Change History (most recent first):
;;  5 9/4/96   akh  not sure
;;  4 7/18/96  akh  move some things to nx-basic
;;  2 4/19/96  akh  from gb
;;  7 12/22/95 gb   reorged for PPC
;;  5 12/12/95 akh  defun new-compiler-policy enclosed again - works now
;;  3 12/1/95  gb   use %istruct; %immref-p shouldn't need to exist on ppc;
;;                  why not require optimizers ?
;;  (do not edit before this line!!)


; Copyright 1987-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995 Digitool, Inc. The 'tool rules!

;; Modification History
;
; 10/10/96 slh   *compiler-warning-formats*, report-compiler-warning -> nx-basic.lisp
;  9/20/96 slh   require defstruct here, not in dll-node.lisp
; 06/26/96 gb  merge-compiler-warnings, nx-declared-inline-p here.
; -------- 3.9
; 04/18/96 gb   reorganize so :excise-compiler doesn't nuke env accessors, ppc aux stuff.
; -------- 3.9f1c2
; 03/01/96 gb  *nx-start*, *nx-end*.
; 12/23/95 gb  don't need autoload ppc-compile; include ppc2 ok ?
; 11/14/95 slh  mods. for PPC target
;  3/30/95 slh  merge in base-app changes
;-------------- 3.0d18
;  2/28/95 slh  compile: no more warnigns
;-------------- 3.0d17
; 10/11/93 bill bring COMPILE up to ANSI spec.
;-------------- 3.0d13
; 02/08/93 bill add :special-fbinding to *compiler-warning-formats*
;11/20/91 bill (gb) (COMPILE 'FOO) shouldn't err if #'foo is already compiled.
;05/22/91 bill (per GB) cons-var defaults its second argument to 0
;05/20/91 gb  Open-code a few more things.  Warn on variables that are only
;             set (never reffed.)  Support &restv, don't choke on short-floats.
;             WITH-STACK-DOUBLE-FLOATS nonsense.
;02/06/91 bill compile-named-function patch from patch2.0b1p0
;05/31/90 bill Add optional return-keys? arg to encode-lambda-list
;04/30/90 gb lotsa changes, some still unfinished.
;02/22/90 gb it exists.  Should maybe be deprecated ...
;02/21/90 gz ignore downward-function decls until exist or replaced with
;            something better...
;01/17/90 gz In %lfun-info, symmap bit now in attributes, also check noname bit.
;01/03/90 gz slfunv bit in %immref-p.
;12/28/89 gz include the slfunv long in %lfun-vector-mapwords.
;            Function specs are handled by fboundp, so compile doesn't have to.
;11/14/89 gz Made %find-linkmap return vector.
;09/17/89 gb forget ask & usual.
;9/14/89  gz $lfatr-slfunv-bit means there is an extra longword at end of lfun.
;09/11/89 gz  (%cdr (%sym-fn-loc x)) -> (fboundp x)
; 03/09/89 gz symbolic names for some things.
; 01/03/89 gz moved %lfun-vector and %nth-immediate to l1-aprims.
; 8/23/88 gz compile-named-function defaults all args to NIL.
;            compile-user-function handles user options.
;            2-arg %nth-immediate, fix in %lfun-vector.
; 8/16/88 gz ":" -> "compiler;".  provide nx.
; 8/13/88 gb %unamep here.

(eval-when (:compile-toplevel)
  (require 'nxenv)
#-ppc-target (require 'subprims8 "ccl:compiler;subprims8.lisp")
  (require 'numbers)
  (require 'sequences)
  (require 'optimizers))

(eval-when (:load-toplevel :execute :compile-toplevel)
  (require 'numbers) ; just calls 'logcount' and 'integer-length'
  (require 'sort)    ; just calls '%sort-list-no-keys'
  (require 'hash))

(%include "ccl:compiler;nx-basic.lisp")

(eval-when (:load-toplevel :execute)
  (require "DEFSTRUCT"))

(defparameter *nx-start* (cons nil nil))

#+ppc-target
(eval-when (:load-toplevel :execute :compile-toplevel)
  (require "DLL-NODE")
  (require "PPC-ARCH")
  (require "VREG")
  (require "PPC-ASM")
  (require "VINSN")
  (require "PPC-VINSNS")
  (require "PPC-REG")
  (require "PPC-SUBPRIMS")
  (require "PPC-LAP")
)
(%include "ccl:compiler;nx0.lisp")
(%include "ccl:compiler;nx1.lisp")

; put this in nx-basic too
;(defvar *lisp-compiler-version* 666 "I lost count.")

; At some point, COMPILE refused to compile things that were defined
; in a non-null lexical environment (or so I remember.)   That seems
; to have been broken when the change of 10/11/93 was made.
; It makes no sense to talk about compiling something that was defined
; in a lexical environment in which there are symbol or function bindings
; present;  I'd thought that the old code checked for this, though it
; may well have botched it.
(defun compile (spec &optional def &aux (macro-p nil))
  (unless def
    (setq def (fboundp spec))
    (when (and (symbolp spec) (not (lfunp def)))
      (setq def (setq macro-p (macro-function spec)))))
  (when (typep def 'interpreted-function)
    (let ((lambda (function-lambda-expression def)))
      (when lambda (setq def lambda))))
  (unless def
    (nx-error "Can't find compilable definition for ~S." spec))
  (multiple-value-bind (lfun warnings)
                       (if (functionp def)
                         def
                         (compile-named-function def spec nil nil *save-definitions* *save-local-symbols*))
    (let ((harsh nil) (some nil) (init t))
      (dolist (w warnings)
        (multiple-value-setq (harsh some) (signal-compiler-warning w init nil harsh some))
        (setq init nil))
      (values
       (if spec
         (progn
           (if macro-p
             (setf (macro-function spec) lfun)
             (setf (fdefinition spec) lfun))
           spec)
         lfun)
       some
       harsh))))

(defparameter *default-compiler-policy* (new-compiler-policy))

(defun current-compiler-policy () *default-compiler-policy*)

(defun set-current-compiler-policy (&optional new-policy)
  (setq *default-compiler-policy* 
        (if new-policy (require-type new-policy 'compiler-policy) (new-compiler-policy))))

(defun compile-user-function (def name &optional env)
  (multiple-value-bind (lfun warnings)
                       (compile-named-function def name nil
                                               env
                                               *save-definitions*
                                               *save-local-symbols*)
    (signal-or-defer-warnings warnings env)
    lfun))

(defun signal-or-defer-warnings (warnings env)
  (let* ((defenv (definition-environment env))
         (init t)
         (defer (and defenv (cdr (defenv.type defenv)) *outstanding-deferred-warnings*)))
    (dolist (w warnings)
      (if (and defer (typep w 'undefined-function-reference))
        (push w (deferred-warnings.warnings defer))
        (progn
          (signal-compiler-warning w init nil nil nil)
          (setq init nil))))))

(defparameter *load-time-eval-token* nil)

#-ppc-target
(defun compile-named-function (def &optional 
                                name lfun-maker env keep-lambda keep-symbols policy *load-time-eval-token*)
  (setq def
        (let ((env (new-lexical-environment env)))
          (setf (lexenv.variables env) 'barrier)
          (with-managed-allocation
            (nx2-compile
             (let* ((*nx1-target-inhibit* *nx1-68k-target-inhibit*)
                    (*target-compiler-macros* *68k-target-compiler-macros*))
               (nx1-compile-lambda name def (make-afunc) nil env (or policy *default-compiler-policy*)*load-time-eval-token*))  ; will also bind *nx-lexical-environment*
             (or lfun-maker t)
             (if keep-lambda (if (lambda-expression-p keep-lambda) keep-lambda def))
             keep-symbols))))
  (values (afunc-lfun def)
          (afunc-warnings def)))

(eval-when (:compile-toplevel)
  (declaim (ftype (function (&rest ignore) t)  ppc-compile)))

(defun 
  #-ppc-target ppc-compile-named-function 
  #+ppc-target compile-named-function
  (def &optional name lfun-maker env keep-lambda keep-symbols policy *load-time-eval-token*)
  (declare (special *ppc-target-compiler-macros*))
  (setq 
   def
   (let ((env (new-lexical-environment env)))
     (setf (lexenv.variables env) 'barrier)
     (with-managed-allocation
       (let* ((afunc 
               (let* ((*nx1-target-inhibit* *nx1-ppc-target-inhibit*)
                      (*target-compiler-macros* *ppc-target-compiler-macros*))
                 (nx1-compile-lambda 
                      name 
                      def 
                      (make-afunc) 
                      nil 
                      env 
                      (or policy *default-compiler-policy*)
                      *load-time-eval-token*))))
         (if (afunc-lfun afunc)
           afunc
           (ppc2-compile 
            afunc
            ; will also bind *nx-lexical-environment*
            (or lfun-maker t)
            (if keep-lambda (if (lambda-expression-p keep-lambda) keep-lambda def))
            keep-symbols))))))
  (values (afunc-lfun def) (afunc-warnings def)))


  




(defparameter *compiler-whining-conditions*
  '((:undefined-function . undefined-function-reference)
    (:global-mismatch . invalid-arguments-global)
    (:lexical-mismatch . invalid-arguments)
    (:environment-mismatch . invalid-arguments)
    (:unused . style-warning)))


#-ppc-target
(defun %immref-p (n ncodev)
  (lap-inline ()
    (:variable n ncodev)
   (move.l arg_z atemp0)
   (move.l nilreg acc)
   (if# (ne (btst.w ($ $lfatr-immmap-bit) (atemp0 ($lfv_attrib))))  ; immediates map
     (vscale.w arg_y)
     (getvect atemp0 da)
     (if# (ne (btst.w ($ $lfatr-slfunv-bit) (atemp0 (- ($lfv_attrib) $v_data))))
       (sub.w ($ 4) atemp0))
     (lea (atemp0 da.l -4) atemp0)
     (move.l ($ 0) db)
     (while# (ne (progn (moveq 0 da) (move.b (-@ atemp0) da)))
       (if# (cs (add.b da da))
         (ror.w ($ 8) da)
         (move.b -@atemp0 da)
         (ror.w ($ 8) da))
       (add.l da db)
       (if# (le db arg_y)
         (if# eq (add.w ($ $t_val) acc))
         (bra @ret)))
     @ret)))


#-ppc-target
(require "NX2")

#+ppc-target
(require "PPC2")

(defparameter *nx-end* (cons nil nil))
(provide 'nx)

#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
