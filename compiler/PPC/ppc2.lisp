;;;-*-Mode: LISP; Package: CCL -*-

;; $Log: ppc2.lisp,v $
;; Revision 1.7  2006/02/05 16:47:00  alice
;; ; fix ppc2-ff-call-internal so return value is :single-float if so desired
;;
;; Revision 1.6  2005/06/25 21:27:16  alice
;; ; 06/23/05 akh fix ppc2-bind-lambda for e.g. &rest b &key (c (list b))
;;
;; Revision 1.5  2003/12/08 08:25:21  gtbyers
;; Backend changes for %SLOT-REF, %SLOT-UNBOUND-MARKER.
;;
;; Revision 1.4  2003/12/01 17:56:06  gtbyers
;; recover pre-MOP changes
;;
;; Revision 1.2  2002/11/18 05:36:54  gtbyers
;; Add CVS log marker
;;
;;	Change History (most recent first):
;;  8 6/2/97   akh  somethng from gary?
;;  5 3/17/97  akh  gary's fix to ppc2-lexical-reference
;;  40 6/16/96 akh  (the fixnum (- the fixnum foo)) = %%ineg
;;  38 6/7/96  akh  %iasr-c, %ilsr-c for count > 31
;;  37 5/23/96 akh  add ppc2-form-float, test float type in ppc2-copy-register
;;  36 5/20/96 akh  in ppc2-copy-register - dont check type of double-float - we ought to be sure by now
;;  35 4/19/96 akh  from gb
;;  30 3/15/96 bill 3.1d78
;;  26 2/19/96 akh  gary's fix for &rest with &key in ppc2-lambda
;;  25 2/7/96  bill 3.1d66
;;  17 12/12/95 akh gary's fix to ppc-invoke-fn
;;  14 12/1/95 gb   Try again (AppleShare keeps losing connection.)
;;  14 12/1/95 gb   %alloc-misc changes; stack-consed %alloc-misc; ppc
;;                   vector-types; portable ppc2-long-constant-p
;;
;;  11 11/19/95 gb  &lexpr, stack-consed closure, %get-long sign extends right
;;  10 11/15/95 gb  fix nlexit callers, point-h, point-v
;;  9 11/14/95 akh  gary's fix to ppc2-dynamic-extent-form
;;  5 10/26/95 akh  damage control
;;  5 10/26/95 gb   ppc2-without-interrupts; some event-poll changes
;;                  three-untargeted-reg-forms
;;  2 10/6/95  gb   Additions & fixes.
;;  (do not edit before this line!!)

; Modification History
; ppc2-seq-bind-var - short-float=single-float
;; ------ 5.2b6
; fix ppc2-vref for bit-vector
; ---- 5.2b1
; fix ppc2-ff-call-internal so return value is :single-float if so desired
; 06/23/05 akh fix ppc2-bind-lambda for e.g. &rest b &key (c (list b))
; --------- 5.1 final
; 08/12/01 akh - see ppc2-%i* - fix in case want unboxed
; 08/12/01 akh add a comment re int-to-ptr bug
; 10/12/00 AKH STUFF ABOUT LEXPRS AND REGSAVE-INFO
; 03/20/99 akh ppc2-%macptrptr% - (from some unknown guy) don't  claim usage of an imm-temp for all eternity
; 01/19/99 akh gary's fix to fence post in PPC2-%ALLOC-MISC
; 12/21/98 akh ppc2-vset had a bug re declared array type short-float and set to constant value
; 12/20/98 akh ppc2-dynamic-extent-double/short-float do make-tsp-dfloat/sfloat-from-fpr
; 12/18/98 akh ppc2-form-float and ppc2-copy-register do single-float tooo. add ppc2-sf-vset, call it from ppc2-vset
; 10/31/98 akh ppc2-unboxed-integer-arg-to-reg - move result of .spgetxlong to immreg (if not imm0)
; 08/03/98 akh in ppc2-compile - if the function is lexically bound then do not %tail-call-next-method
; 07/15/98 akh fix ppc2-lambda-bind for dynamic-extent rest
; 05/31/98 akh  dynamic-extent double or short-float vars are stack-consed
; 04/16/97 bill in ppc2-vref: misc-ref-short-float -> misc-ref-single-float,
;               misc-ref-c-short-float -> misc-ref-c-single-float
; ------------- 4.1b2
; 03/21/97 gb   wider compound-branch targets; ppc2-get-next-label checks for overflow;
;               suppress warning from PPC2-CHECK-LCELL-DEPTH.
; ------------- 4.1b1
; 03/13/97 bill from Gary:
;               remove ppc2-open-var.
;               ppc2-set-var-ea uses VINSN-NOTEs instead of numbered labels.
;               ppc2-close-var emits a NOTE that was allocated earlier, bracketing the NOTE which
;                 marks the start of the variable's scope.
;               ppc2-expand-note gives lap-labels no visn-note-class'es :begin-variable-scope & :end-variable-scope
;               label-address in ppc2-digest-symbols processes a note instead of a labelnum.
; 03/01/97 gb   short-gloats, lcells, lregs, lotsa changes.
; 02/27/97 bill Gary's fix to ppc2-%i-
; 01/24/97 bill point-h & point-v => integer-point-h & integer-point-v
; 10/14/96 bill Gary's fix to ppc2-fixnum (fixnum-conditional-patch).
; ------------- 4.0 
; 10/13/96 gb   recognize compound-cd in single-arg VALUES case.
; ------------- 4.0f2
; 10/11/96 bill ppc2-ff-call-internal has #+sf & #-sf clauses so that it
;               will work to call traps that take :single-float args and return
;               :single-float results even though MCL doesn't have single floats.
; ------------- 4.0f1
; 10/07/96 bill Gary's changes to ppc2-invoke-fn that make self-recursive calls faster
; ------------- 4.0b2
; 08/28/96 bill ppc2-dynamic-extent-form handles a non-constant clear-p argument to %new-ptr.
; 09/06/96  gb  ppc2-%sbchar, ppc2-%sechar type-and-bounds-check by default.
; ------------- 4.0b1
;;<end of added text>
; 08/12/96 bill in ppc2-prog1, "<" => "<-". This makes it generate a compare instruction
; 06/20/96 bill update ppc2-invoke-fn, ppc2-do-return, & ppc2-restore-nvrs to
;               restore the non-volotile registers relative to the top of the
;               stack instaed of relative to the next stack frame.
;               This makes it work with a segmented vstack. It also saves a memory reference.
; 06/20/96  gb  revive ppc2-or; ppc2-%debug-trap (for DBG); new cr/conditional scheme;
;               less boxing on aref/aset of double-float vector.
;               better fixnum comparisons; use fp-zero reg.  call subprims for builtins.
; akh fix %iasr-c for count > 31
;  6/06/96 slh  ppc2-bind-lambda, ppc2-lambda from patch
;     ?    akh  in ppc2-copy-register - dont check type of double-float - we ought to be sure by now
; 04/18/96 gb   offset ->constant-offet in immediate-set-ptr; use fp reg in clear-fpu-exceptions.
;               require other stuff in nx.
; ------ 3.9f1c2
; 04/09/96 gb   (ppc2-lwi ... offset) -> (ppc2-lwi ... constant-offset) in PPC2-IMMEDIATE-STORE.
; 04/07/96 gb   the PPC2-LABELS fix (comment.)
; 03/28/96 bill Gary's fixes to ppc2-%immediate-set-xxx and ppc2-immediate-put-xxx
;               Gary's fix for "d86 compiler bug" in ppc2-lambda
;               Gary's code to make defppc2-df-op always store the result in
;                 some register other than the source registers so that the
;                 source values will be available for error signalling.
;               A couple of other changes from Gary.
; 03/26/96 gb   *save-local-symbols* again; %vreflet.
; 03/15/96 bill Gary's fix to ppc2-dynamic-extent-form
; 03/14/96 bill defppc2-df-op does clear-fpu-exceptions (from GB)
; 03/13/96 bill ppc2-spread-lambda-list errors if there are more than 255 required, optional, or keyword args
; 03/06/96 bill ppc2-xmake-function doesn't call add-traceback-table if
;               traceback-fullwords returns 0 (which it does if the name string
;               is not a simple-base-string).
; 03/01/96 bill ppc2-ff-call-slep
; 03/10/96 gb   open-code FP stuff; FP-regs more first-class
; 02/21/96 bill Gary's fix to ppc2-values
; 02/07/96 bill "<" => "<-" in ppc2-catch so the thrown value gets remembered.
; 02/02/96 gb   disable save-local-symbols (doesn't work).  Fix package typo in
;               ppc2-uvset.
; 01/22/96 gb   &lexpr changes.
; 01/17/96 gb   work with freelisting scheme; ppc2-nlexit and
;               ppc2-unwind-protect exit cleanup forms; ff-call
;               and PPC2-COPY-REGISTER handle fprs better; 
;               add %SETF-DOUBLE-FLOAT.
; 01/16/96 bill multiple-value-list now saves its result
; 01/05/96 bill Gary's fix to ppc2-invoke-fn
; 01/04/96 bill In ppc2-%register-trap, don't mask out the high bits of the
;               trap number passed in arg_z to .SPregtrap
; 12/27/95 gb   %hget, mvpass fixes; new vinsns; compile on PPC
; 12/13/95 gb   progv; call-builtin; out-of-line changes
; 12/02/95 bill  Fix Gary's merge error in ppc2-%alloc-misc
; 11/30/95 slh   mods. for PPC target
; 11/21/95 bill  Gary's fix to ppc2-let
; 11/15/95 gb point-h/point-v backwards; ppc2-nlexit's callers pass
;   xfer arg.
; 11/13/95 gb use ENSURING-NODE-TARGET to ensure that node values
;   stay in node regs.  New macptr scheme; point-h/v.  Several
;   other fixes (&key/&rest order in stack frame, etc.)

(eval-when (:compile-toplevel :execute)
  (require "NXENV")
  (require "PPCENV"))


(defmacro with-ppc-p2-declarations (declsform &body body)
  `(let* ((*ppc2-noforcestk* *ppc2-noforcestk*)
          (*ppc2-tail-allow* *ppc2-tail-allow*)
          (*ppc2-reckless* *ppc2-reckless*)
          (*ppc2-inhibit-eventchecks* *ppc2-inhibit-eventchecks*)
          (*ppc2-open-code-inline* *ppc2-open-code-inline*)
          (*ppc2-trust-declarations* *ppc2-trust-declarations*))
     (ppc2-decls ,declsform)
     ,@body))

(defmacro with-local-vinsn-macros ((segvar &optional vreg-var xfer-var) &body body)
  (declare (ignorable xfer-var))
  (let* ((template-name-var (gensym))
         (template-temp (gensym))
         (args-var (gensym))
         (labelnum-var (gensym))
         (retvreg-var (gensym))
         (label-var (gensym)))
    `(macrolet ((! (,template-name-var &rest ,args-var)
                  (let* ((,template-temp (get-vinsn-template-cell ,template-name-var)))
                    (unless ,template-temp
                      (warn "VINSN \"~A\" not defined" ,template-name-var))
                    `(%emit-vinsn ,',segvar (load-time-value (get-vinsn-template-cell ',,template-name-var)) ,@,args-var))))
       (macrolet ((<- (,retvreg-var)
                    `(ppc2-copy-register ,',segvar ,',vreg-var ,,retvreg-var))
                  (@  (,labelnum-var)
                    `(ppc2-gen-label ,',segvar ,,labelnum-var))
                  (-> (,label-var)
                    `(! jump (aref *ppc2-labels* ,,label-var)))
                  (^ (&rest branch-args)
                    `(ppc2-branch ,',segvar ,',xfer-var ,',vreg-var ,@branch-args)))
         ,@body))))


(defmacro regspec-crf-gpr-case ((regspec regval) crf-form gpr-form)
  (let* ((class (gensym)))
    `(if ,regspec
       (multiple-value-bind (,class ,regval) (regspec-class-and-value ,regspec ppc::hard-reg-class-gpr-crf-mask)
         (declare (fixnum ,class ,regval))
         (if (= ,class ppc::hard-reg-class-crf)
           ,crf-form
           ,gpr-form)))))

(defmacro ensuring-node-target ((target-var vreg-var) &body body)
  `(let* ((*ppc-node-temps* *ppc-node-temps*)
          (,target-var (ppc-ensure-node-target ,vreg-var)))
     (declare (special *ppc-node-temps*))     
     (progn
       ,@body)
     (<- ,target-var)))

(defun ppc-available-crf-temp (mask)
  (dotimes (bit 8 (error "Bug: ran out of node CR fields."))
    (when (logbitp bit mask)
      (return (ppc::make-hard-crf-reg (the fixnum (ash bit 2)))))))

(defmacro with-node-temps ((&rest reserved) (&rest nodevars) &body body)
  `(let* ((*ppc-node-temps* (logand *ppc-node-temps* (lognot (logior ,@(mapcar #'(lambda (r) `(ash 1 (ppc::hard-regspec-value ,r))) reserved)))))
          ,@(mapcar #'(lambda (v) `(,v (ppc2-make-unwired-lreg (ppc-select-node-temp)))) nodevars))
     ,@body))

(defmacro with-imm-temps ((&rest reserved) (&rest immvars) &body body)
  `(let* ((*ppc-imm-temps* (logand *ppc-imm-temps* (lognot (logior ,@(mapcar #'(lambda (r) `(ash 1 (ppc::hard-regspec-value ,r))) reserved)))))
          ,@(mapcar #'(lambda (v) (let* ((var (if (atom v) v (car v)))
                                         (mode-name (if (atom v) :u32 (cadr v)))) 
                                    `(,var (ppc-select-imm-temp ',mode-name)))) immvars))
          ,@body))

; Choose an immediate register (for targeting), but don't "reserve" it.
(defmacro with-imm-target ((&rest reserved) spec &body body)
  (let* ((name (if (atom spec) spec (car spec)))
         (mode-name (if (atom spec) :u32 (cadr spec))))
    `(let* ((,name (ppc-available-imm-temp (logand *ppc-imm-temps* 
                                                   (lognot (logior ,@(mapcar #'(lambda (r) 
                                                                                 `(ash 1 (ppc::hard-regspec-value ,r))) reserved))))
                                           ',mode-name)))
       ,@body)))


(defmacro with-fp-target ((&rest reserved) spec &body body)
  (let* ((name (if (atom spec) spec (car spec)))
         (mode-name (if (atom spec) :double-float (cadr spec))))
    `(let* ((,name (ppc-available-fp-temp (logand *ppc-fp-temps* 
                                                   (lognot (logior ,@(mapcar #'(lambda (r) 
                                                                                 `(ash 1 (ppc::hard-regspec-value ,r))) reserved))))
                                           ',mode-name)))
       ,@body)))

(defmacro with-crf-temps ((&rest reserved) (&rest crfvars) &body body)
  `(let* ((*ppc-crf-temps* (logand *ppc-crf-temps* (lognot (logior ,@(mapcar #'(lambda (r) `(ash 1 (ash ,r -2))) reserved)))))
          ,@(mapcar #'(lambda (v) `(,v (ppc2-make-unwired-lreg (ppc-select-crf-temp)))) crfvars))
     ,@body))

(defmacro with-crf-target ((&rest reserved) name &body body)
  `(let* ((,name (ppc2-make-unwired-lreg 
                  (ppc-available-crf-temp 
                   (logand *ppc-crf-temps* 
                           (lognot (logior ,@(mapcar #'(lambda (r) `(ash 1 (ash (ppc::hard-regspec-value ,r) -2))) reserved))))))))
     ,@body))


(defvar *ppc2-imms* nil)
(DEFVAR *IS-LEXPR* NIL)

(defvar *ppc-current-context-annotation* nil)
(defvar *ppc2-inhibit-eventchecks* nil)
(defvar *ppc2-woi* nil)
(defvar *ppc2-open-code-inline* nil)
(defvar *ppc2-register-restore-count* 0)
(defvar *ppc2-register-restore-ea* nil)
(defvar *ppc2-compiler-register-save-label* nil)
(defvar *ppc2-valid-register-annotations* 0)
(defvar *ppc2-register-annotation-types* nil)
(defvar *ppc2-register-ea-annotations* nil)

(defparameter *ppc2-tail-call-aliases*
  '((%call-next-method . (%tail-call-next-method . 1))))

(defvar *ppc2-popreg-labels* nil)
(defvar *ppc2-popj-labels* nil)
(defvar *ppc2-valret-labels* nil)
(defvar *ppc2-nilret-labels* nil)

(defvar *ppc2-icode* nil)
(defvar *ppc2-labels* nil)
(defvar *ppc2-undo-stack* nil)
(defvar *ppc2-undo-because* nil)


(defvar *ppc2-cur-afunc* nil)
(defvar *ppc2-vstack* 0)
(defvar *ppc2-cstack* 0)
(defvar *ppc2-undo-count* 0)
(defvar *ppc2-returning-values* nil)
(defvar *ppc2-vcells* nil)
(defvar *ppc2-fcells* nil)
(defvar *ppc2-entry-vsp-saved-p* nil)

(defvar *ppc2-entry-label* nil)
(defvar *ppc2-tail-label* nil)
(defvar *ppc2-tail-allow* t)
(defvar *ppc2-reckless* nil)
(defvar *ppc2-trust-declarations* nil)
(defvar *ppc2-entry-vstack* nil)
(defvar *ppc2-fixed-nargs* nil)
(defvar *ppc2-need-nargs* t)

(defparameter *ppc2-inhibit-register-allocation* nil)
(defvar *ppc2-record-symbols* nil)
(defvar *ppc2-recorded-symbols* nil)
(defvar *ppc2-noforcestk* nil)

(defvar *ppc2-result-reg* ppc::arg_z)





(declaim (fixnum *ppc2-vstack* *ppc2-cstack*))

 


; Before any defppc2's, make the *ppc2-specials* vector.
(next-nx-defops)
(defvar *ppc2-specials* nil)
(let* ((newsize (%i+ (next-nx-num-ops) 10))
       (old *ppc2-specials*)
       (oldsize (length old)))
  (declare (fixnum newsize oldsize))
  (unless (>= oldsize newsize)
    (let* ((v (make-array newsize :initial-element nil)))
      (dotimes (i oldsize (setq *ppc2-specials* v))
        (setf (svref v i) (svref old i))))))


(defvar *ppc2-all-lregs* ())
(defvar *ppc2-all-lcells* ())

(defun ppc2-note-logical-register (l)
  (push l *ppc2-all-lregs*)
  l)

(defun ppc2-free-logical-registers ()
  (without-interrupts
   (let* ((prev (pool.data *lreg-freelist*)))
     (dolist (r *ppc2-all-lregs*)
       (setf (lreg-value r) prev
             prev r))
     (setf (pool.data *lreg-freelist*) prev)
     (setq *ppc2-all-lregs* nil))))
     
(defun ppc2-free-lcells ()
  (without-interrupts 
   (let* ((prev (pool.data *lcell-freelist*)))
     (dolist (r *ppc2-all-lcells*)
       (setf (lcell-kind r) prev
             prev r))
     (setf (pool.data *lcell-freelist*) prev)
     (setq *ppc2-all-lcells* nil))))
    
(defun ppc2-make-wired-lreg (value &key 
                                   (class (ppc::hard-regspec-class value))
                                   (mode (ppc::get-regspec-mode value))
                                   (type (ppc::get-node-regspec-type-modes value)))
  (ppc2-note-logical-register (make-lreg (ppc::hard-regspec-value value) class mode type t)))

(defun ppc2-make-unwired-lreg (value &key 
                                     (class (if value (ppc::hard-regspec-class value) 0))
                                     (mode (if value (ppc::get-regspec-mode value) 0))
                                     (type (if value (ppc::get-node-regspec-type-modes value) 0)))
  (ppc2-note-logical-register (make-lreg (if value (ppc::hard-regspec-value value)) class mode type nil)))

(defun ppc2-note-lcell (c)
  (push c *ppc2-all-lcells*)
  c)

(defvar *ppc2-top-vstack-lcell* ())
(defvar *ppc2-bottom-vstack-lcell* ())

(defun ppc2-new-lcell (kind parent width attributes info)
  (ppc2-note-lcell (make-lcell kind parent width attributes info)))

(defun ppc2-new-vstack-lcell (kind width attributes info)
  (setq *ppc2-top-vstack-lcell* (ppc2-new-lcell kind *ppc2-top-vstack-lcell* width attributes info)))

(defun ppc2-reserve-vstack-lcells (n)
  (dotimes (i n) (ppc2-new-vstack-lcell :reserved 4 0 nil)))

(defun ppc2-vstack-mark-top ()
  (ppc2-new-lcell :tos *ppc2-top-vstack-lcell* 0 0 nil))

; Alist mapping VARs to lcells/lregs
(defvar *ppc2-var-cells* ())

(defun ppc2-note-var-cell (var cell)
  ;(format t "~& ~s -> ~s" (var-name var) cell)
  (push (cons var cell) *ppc2-var-cells*))

(defun ppc2-note-top-cell (var)
  (ppc2-note-var-cell var *ppc2-top-vstack-lcell*))

(defun ppc2-lookup-var-cell (var)
  (or (cdr (assq var *ppc2-var-cells*))
      (and nil (warn "Cell not found for ~s" (var-name var)))))

(defun ppc2-collect-lcells (kind &optional (bottom *ppc2-bottom-vstack-lcell*) (top *ppc2-top-vstack-lcell*))
  (do* ((res ())
        (cell top (lcell-parent cell)))
       ((eq cell bottom) res)
    (if (null cell)
      (error "Horrible compiler bug.")
      (if (eq (lcell-kind cell) kind)
        (push cell res)))))

  
; ensure that lcell's offset matches what we expect it to.
; For bootstrapping.

(defun ppc2-ensure-lcell-offset (c expected)
  (if c (= (calc-lcell-offset c) expected) (zerop expected)))

(defun ppc2-check-lcell-depth (&optional (context "wherever"))
  (when (logbitp ppc2-debug-verbose-bit *ppc2-debug-mask*)
    (let* ((depth (calc-lcell-depth *ppc2-top-vstack-lcell*)))
      (or (= depth *ppc2-vstack*)
          (warn "~a: lcell depth = ~d, vstack = ~d" context depth *ppc2-vstack*)))))

(defun ppc2-do-lexical-reference (seg vreg ea)
  (declare (fixnum ea))
  (when vreg
    (with-local-vinsn-macros (seg vreg) 
      (if (ppc::memory-spec-p ea)
        (ensuring-node-target (target vreg)
          (progn
            (ppc2-stack-to-register seg ea target)
            (if (ppc::ppc-addrspec-vcell-p ea)
              (! vcell-ref target target))))
        (<- ea)))))

(defun ppc2-do-lexical-setq (seg vreg ea valreg)
  (with-local-vinsn-macros (seg vreg)
    (cond ((ppc::ppc-addrspec-vcell-p ea)     ; closed-over vcell
           (with-node-temps (valreg) (vcell)
             (ppc2-stack-to-register seg ea vcell)
             (! vcell-set& vcell valreg)))      ; Memoize it
          ((ppc::memory-spec-p ea)    ; vstack slot
           (ppc2-register-to-stack seg valreg ea))
          (t
           (ppc2-copy-register seg ea valreg)))
    (when vreg
      (<- valreg))))

; ensure that next-method-var is heap-consed (if it's closed over.)
; it isn't ever setqed, is it ?
(defun ppc2-heap-cons-next-method-var (seg var)
  (with-local-vinsn-macros (seg)
    (when (eq (ash 1 $vbitclosed)
              (logand (logior (ash 1 $vbitclosed)
                              (ash 1 $vbitcloseddownward))
                      (the fixnum (nx-var-bits var))))
      (let ((ea (var-ea var)))
        (ppc2-do-lexical-reference seg ppc::arg_z ea)
        (ppc2-set-nargs seg 1)
        (! ref-constant ppc::fname (ppc2-immediate-index (ppc2-symbol-entry-locative '%cons-magic-next-method-arg)))
        (! call-known-symbol)
        (ppc2-do-lexical-setq seg nil ea ppc::arg_z)))))

(defun ppc2-reverse-cc (cc)
  ;                NE  NE  EQ  EQ   LE   GE   LT   GT   GE   LE   GT   LT    MI   PL   PL   MI
  (%cdr (assq cc '((6 . 6) (7 . 7) (15 . 12) (13 . 14) (12 . 15) (14 . 13)  (11 . 10) (10 . 11)))))

(defun ppc2-invert-cc (cc)
  ;                NE  EQ  EQ  NE   LE   GT   LT   GE   GE   LT   GT   LE    MI   PL   PL   MI
  (%cdr (assq cc '((6 . 7) (7 . 6) (15 . 14) (13 . 12) (12 . 13) (14 . 15)  (11 . 10) (10 . 11)))))





; To confuse things further, the 68K argument order for a comparison 
; is the opposite of the PPC order: on the 68K, 
;  (cmp.l x y) === (setq CCR (- y x)), while on the PPC it's
;  (cmpw x y) ===  (setq CRFn (- x y)).
; The 68K (tst.l x) is equivalent to (cmpi.l #0 x) === (setq CCR (- x 0))
; The PPC (cmpwi x 0) === (setq CRFn (- x 0)).  SO:
; In most cases, we want to treat the 68K condition code as if the operands
; were reversed; in a few cases (notably when a 68K TST.L or MOVE.L was doing
; an implicit compare to #0), we don't want to reverse them.
(defun 68k-cc-to-ppc-cr-bit (cc &optional (reverse t))
  (ecase (if reverse (ppc2-reverse-cc cc) cc)
    (#. $ccEQ (values ppc::ppc-eq-bit t))
    (#. $ccNE (values ppc::ppc-eq-bit nil))
    (#. $ccGT (values ppc::ppc-gt-bit t))
    (#. $ccLE (values ppc::ppc-gt-bit nil))
    (#. $ccLT (values ppc::ppc-lt-bit t))
    (#. $ccGE (values ppc::ppc-lt-bit nil))))

; For now, the register-spec must be 
; a) non-nil
; c) of an expected class.
; Return the class and value.
(defun regspec-class-and-value (regspec expected)
  (declare (fixnum expected))
  (let* ((class (ppc::hard-regspec-class regspec)))
    (declare (type (unsigned-byte 8 class)))
    (if (logbitp class expected)
      (values class (ppc::hard-regspec-value regspec))
      (error "bug: Register spec class (~d) is not one  of ~s." class expected))))

(defparameter *ppc2-debug-mask* 0)
(defconstant ppc2-debug-verbose-bit 0)
(defconstant ppc2-debug-vinsns-bit 1)
(defconstant ppc2-debug-lcells-bit 1)


; Loop through all labels in *ppc2-labels*; if the label
; has been emitted, remove it from vinsns and return it to
; the *vinsn-label-freelist*. 
; "vinsns" should then contain nothing but ... vinsns

(defun ppc2-remove-labels ()
  (let* ((labels *ppc2-labels*)
         (freelist *vinsn-label-freelist*))
    (dotimes (i (the fixnum (length labels)))
      (let* ((lab (aref labels i)))
        (if lab
          (if (vinsn-label-succ lab)
            (remove-and-free-dll-node lab freelist)
            (free-dll-node lab freelist)))))))
  

(defun ppc2-compile (afunc &optional lfun-maker lambda-form *ppc2-record-symbols*)
  ;; if the function is lexically bound then do not %tail-call-next-method which is the only thing *PPC2-TAIL-CALL-ALIASES* does
  (LET* (;(NAME (AFUNC-NAME AFUNC))
         (ENV (AFUNC-ENVIRONMENT AFUNC))
         ;(FNS (IF ENV (LEXENV.FUNCTIONS ENV)))
         (*PPC2-TAIL-CALL-ALIASES* (IF ENV NIL *PPC2-TAIL-CALL-ALIASES*)))
    
    (with-managed-allocation
      (when (eq lfun-maker t) (setq lfun-maker #'ppc2-xmake-function))
      (dolist (a  (afunc-inner-functions afunc))
        (unless (afunc-lfun a)
          (ppc2-compile a 
                        (or (null lfun-maker) lfun-maker) 
                        (if lambda-form 
                          (afunc-lambdaform a)) 
                        *ppc2-record-symbols*)))  ; always compile inner guys
      (let* ((*ppc2-cur-afunc* afunc)
             (*IS-LEXPR* NIL)
             (*ppc2-returning-values* nil)
             (*ppc2-inhibit-eventchecks* nil)
             (*ppc-current-context-annotation* nil)
             (*ppc2-woi* nil)
             (*next-lcell-id* -1)
             (*ppc2-open-code-inline* nil)
             (*ppc2-register-restore-count* nil)
             (*ppc2-compiler-register-save-label* nil)
             (*ppc2-valid-register-annotations* 0)
             (*ppc2-register-ea-annotations* (ppc2-make-stack 16))
             (*ppc2-register-restore-ea* nil)
             (*ppc2-vstack* 0)
             (*ppc2-cstack* 0)
             (*ppc2-all-lcells* ())
             (*ppc2-top-vstack-lcell* nil)
             (*ppc2-bottom-vstack-lcell* (ppc2-new-vstack-lcell :bottom 0 0 nil))
             (*ppc2-var-cells* nil)
             (*ppc-node-temps* ppc-temp-node-regs)
             (*ppc-imm-temps* ppc-imm-regs)
             (*ppc-crf-temps* ppc-cr-fields)
             (*ppc-fp-temps* ppc-temp-fp-regs)
             (bits 0)
             (*logical-register-counter* -1)
             (*ppc2-all-lregs* ())
             (*ppc2-popj-labels* nil)
             (*ppc2-popreg-labels* nil)
             (*ppc2-valret-labels* nil)
             (*ppc2-nilret-labels* nil)
             (*ppc2-undo-count* 0)
             (*ppc2-labels* (ppc2-make-stack 64 #-ppc-target $v_genv #+ppc-target ppc::subtag-simple-vector))
             (*ppc2-undo-stack* (ppc2-make-stack 64 #-ppc-target $v_genv #+ppc-target ppc::subtag-simple-vector))
             (*ppc2-undo-because* (ppc2-make-stack 64))
             (*ppc2-imms* (ppc2-make-stack 64 #-ppc-target $v_genv #+ppc-target ppc::subtag-simple-vector))
             (*ppc2-entry-label* nil)
             (*ppc2-tail-label* nil)
             (*ppc2-inhibit-register-allocation* nil)
             (*ppc2-tail-allow* t)
             (*ppc2-reckless* nil)
             (*ppc2-trust-declarations* t)
             (*ppc2-entry-vstack* nil)
             (*ppc2-fixed-nargs* nil)
             (*ppc2-need-nargs* t)
             (*ppc2-noforcestk* nil)
             (fname (afunc-name afunc))
             (*ppc2-entry-vsp-saved-p* nil)
             (*ppc2-vcells* (afunc-vcells afunc))
             (*ppc2-fcells* (afunc-fcells afunc))
             *ppc2-recorded-symbols*)
        (set-fill-pointer
         *ppc2-labels*
         (set-fill-pointer
          *ppc2-undo-stack*
          (set-fill-pointer 
           *ppc2-undo-because*
           (set-fill-pointer
            *ppc2-imms* 0))))
        (ppc2-get-next-label) ; start @ label 1, 0 is confused with NIL in compound cd
        (with-dll-node-freelist (vinsns *vinsn-freelist*)
          (unwind-protect
            (progn
              (setq bits (ppc2-form vinsns (ppc2-make-wired-lreg *ppc2-result-reg*) $ppc-return (afunc-acode afunc)))
              (dotimes (i (length *ppc2-imms*))
                (let ((imm (aref *ppc2-imms* i)))
                  (when (ppc2-symbol-locative-p imm) (aset *ppc2-imms* i (car imm)))))
              (when (logbitp ppc2-debug-vinsns-bit *ppc2-debug-mask*)
                (format t "~% vinsns for ~s (after generation)" (afunc-name afunc))
                (do-dll-nodes (v vinsns) (format t "~&~s" v))
                (format t "~%~%"))
              (with-dll-node-freelist (*ppc-lap-instructions* *ppc-lap-instruction-freelist*)
                (let* ((*ppc-lap-labels* nil))
                  (ppc2-expand-vinsns vinsns) 
                  (if (logbitp $fbitnonnullenv (the fixnum (afunc-bits afunc)))
                    (setq bits (+ bits (ash 1 $lfbits-nonnullenv-bit))))
                  (let* ((function-debugging-info (afunc-lfun-info afunc)))
                    (when (or function-debugging-info lambda-form *ppc2-record-symbols*)
                      (if lambda-form (setq function-debugging-info 
                                            (list* 'function-lambda-expression lambda-form function-debugging-info)))
                      (if *ppc2-record-symbols*
                        (setq function-debugging-info (nconc (list 'function-symbol-map *ppc2-recorded-symbols*)
                                                             function-debugging-info)))
                      (setq bits (logior (ash 1 $lfbits-symmap-bit) bits))
                      (ppc2-new-immediate function-debugging-info)))
                  (if (or fname lambda-form *ppc2-recorded-symbols*)
                    (ppc2-new-immediate fname)
                    (setq bits (logior (ash -1 $lfbits-noname-bit) bits)))                                     
                  (unless (afunc-parent afunc)
                    (ppc2-fixup-fwd-refs afunc))
                  (setf (afunc-all-vars afunc) nil)
                  (setf (afunc-argsword afunc) bits)
                  ; Writing traceback tables should be an optimize space/optimize debug
                  ; tradeoff.
                  (let* ((regsave-label (if (typep *ppc2-compiler-register-save-label* 'vinsn-note)
                                          (vinsn-label-info (vinsn-note-label *ppc2-compiler-register-save-label*))))
                         (regsave-reg (if regsave-label (- 32 *ppc2-register-restore-count*)))
                         (regsave-addr (if regsave-label (- *ppc2-register-restore-ea*))))
                    (when lfun-maker
                      (setf (afunc-lfun afunc)
                            (funcall lfun-maker *ppc-lap-instructions* *ppc-lap-labels* *ppc2-imms*  bits
                                     (if (and fname (symbolp fname)) (symbol-name fname))
                                     regsave-label
                                     regsave-reg
                                     regsave-addr))))
                  (ppc2-digest-symbols))))
            (ppc2-remove-labels))))
      afunc)))

(defun ppc2-xmake-function (codeheader labels imms bits &optional 
                                       traceback-string *ppc-lap-regsave-label* *ppc-lap-regsave-reg* *ppc-lap-regsave-addr*)
  (let* ((*ppc-lap-instructions* codeheader)
         (*ppc-lap-labels* labels)
         (numimms (length imms))
         (function (#-ppc-target %make-uvector #+ppc-target %alloc-misc
                    (+ numimms 2)
                    #-ppc-target 52 #+ppc-target ppc::subtag-function)))
    (dotimes (i numimms)
      (setf (uvref function (1+ i)) (aref imms i)))
    (setf (uvref function (+ numimms 1)) bits)
    (let* ((maxpc (ppc-lap-encode-regsave-info (ppc-lap-do-labels)))
           (traceback-size (traceback-fullwords traceback-string))
           (code-vector (#-ppc-target %make-uvector #+ppc-target %alloc-misc
                         (+ traceback-size (ash maxpc -2))
                         #-ppc-target 10 #+ppc-target ppc::subtag-code-vector))
           (i 0))
      (ppc-lap-resolve-labels)
      (do-dll-nodes (insn *ppc-lap-instructions*)
        (ppc-lap-generate-instruction code-vector i insn)
        (incf i))
      (unless (eql 0 traceback-size)
        (add-traceback-table code-vector i traceback-string))
      (setf (uvref function 0) code-vector)
      #+ppc-target (%make-code-executable code-vector)
      function)))
      
    
(defun ppc2-make-stack (size &optional (subtype #-ppc-target $v_swordv
                                                #+ppc-target ppc::subtag-s16-vector))
  (make-uarray-1 subtype size t 0 nil nil nil nil t nil))

(defun ppc2-fixup-fwd-refs (afunc)
  (dolist (f (afunc-inner-functions afunc))
    (ppc2-fixup-fwd-refs f))
  (let ((fwd-refs (afunc-fwd-refs afunc)))
    (when fwd-refs
      (let* ((v (afunc-lfun afunc))
             (vlen (uvsize v)))
        (declare (fixnum vlen))
        (dolist (ref fwd-refs)
          (let* ((ref-fun (afunc-lfun ref)))
            (do* ((i 1 (1+ i)))
                 ((= i vlen))
              (declare (fixnum i))
              (if (eq (%svref v i) ref)
                (setf (%svref v i) ref-fun)))))))))

(defun ppc2-digest-symbols ()
  (if *ppc2-recorded-symbols*
    (let* ((symlist *ppc2-recorded-symbols*)
           (len (length symlist))
           (syms (make-array len))
           (ptrs (make-array (%i+  (%i+ len len) len)))
           (i -1)
           (j -1))
      (declare (fixnum i j))
      (dolist (info symlist (progn (%rplaca symlist syms)
                                   (%rplacd symlist ptrs)))
        (flet ((label-address (note start-p sym)
                 (let* ((label (vinsn-note-label note))
                        (lap-label (if label (vinsn-label-info label))))
                   (if lap-label
                     (ppc-lap-label-address lap-label)
                     (error "Missing or bad ~s label: ~s" 
                       (if start-p 'start 'end) sym)))))
          (destructuring-bind (var sym startlab endlab) info
            (let* ((ea (var-ea var))
                   (ea-val (ldb (byte 16 0) ea)))
              (setf (aref ptrs (incf i)) (if (ppc::memory-spec-p ea)
                                           (logior (ash ea-val 6) #o77)
                                           ea-val)))
            (setf (aref syms (incf j)) sym)
            (setf (aref ptrs (incf i)) (label-address startlab t sym))
            (setf (aref ptrs (incf i)) (label-address endlab nil sym))))))))

(defun ppc2-decls (decls)
  (if (fixnump decls)
    (locally (declare (fixnum decls))
      (setq *ppc2-noforcestk* (neq 0 (%ilogand2 $decl_noforcestk decls))
            *ppc2-tail-allow* (neq 0 (%ilogand2 $decl_tailcalls decls))
            *ppc2-inhibit-eventchecks* (or *ppc2-woi* (neq 0 (%ilogand2 $decl_eventchk decls)))
            *ppc2-open-code-inline* (neq 0 (%ilogand2 $decl_opencodeinline decls))
            *ppc2-reckless* (neq 0 (%ilogand2 $decl_unsafe decls))
            *ppc2-trust-declarations* (neq 0 (%ilogand2 $decl_trustdecls decls))))))


(defun %ppc2-bigger-cdr-than (x y)
  (declare (cons x y))
  (> (the fixnum (cdr x)) (the fixnum (cdr y))))

; Return an unordered list of "varsets": each var in a varset can be assigned a register
; and all vars in a varset can be assigned the same register (e.g., no scope conflicts.)

(defun ppc2-partition-vars (vars)
  (labels ((var-weight (var)
             (let* ((bits (nx-var-bits var)))
               (declare (fixnum bits))
               (if (eql 0 (logand bits (logior
                                        (ash 1 $vbitpuntable)
                                        #+ignore (ash -1 $vbitspecial)
                                        #-ignore (ash 1 $vbitspecial)
                                        (ash 1 $vbitnoreg))))
                 (if (eql (logior (ash 1 $vbitclosed) (ash 1 $vbitsetq))
                          (logand bits (logior (ash 1 $vbitclosed) (ash 1 $vbitsetq))))
                   0
                   (%i+ (%ilogand $vrefmask bits) (%ilsr 8 (%ilogand $vsetqmask bits))))
                 0)))
           (sum-weights (varlist) 
             (let ((sum 0))
               (dolist (v varlist sum) (incf sum (var-weight v)))))
           (vars-disjoint-p (v1 v2)
             (if (eq v1 v2)
               nil
               (if (memq v1 (var-binding-info v2))
                 nil
                 (if (memq v2 (var-binding-info v1))
                   nil
                   t)))))
    (setq vars (%sort-list-no-key
                ;(delete-if #'(lambda (v) (eql (var-weight v) 0)) vars) 
                (do* ((handle (cons nil vars))
                      (splice handle))
                     ((null (cdr splice)) (cdr handle))                  
                  (declare (dynamic-extent handle) (type cons handle splice))
                  (if (eql 0 (var-weight (%car (cdr splice))))
                    (rplacd splice (%cdr (cdr splice)))
                    (setq splice (cdr splice))))
                #'(lambda (v1 v2) (%i> (var-weight v1) (var-weight v2)))))
    ; This isn't optimal.  It partitions all register-allocatable variables into sets such that
    ; 1) no variable is a member of more than one set and
    ; 2) all variables in a given set are disjoint from each other
    ; A set might have exactly one member.
    ; If a register is allocated for any member of a set, it's allocated for all members of that
    ; set.
    (let* ((varsets nil))
      (do* ((all vars (cdr all)))
           ((null all))
        (let* ((var (car all)))
          (when (dolist (already varsets t)
                  (when (memq var (car already)) (return)))
            (let* ((varset (cons var nil)))
              (dolist (v (cdr all))
                (when (dolist (already varsets t)
                        (when (memq v (car already)) (return)))
                  (when (dolist (d varset t)
                          (unless (vars-disjoint-p v d) (return)))
                    (push v varset))))
              (let* ((weight (sum-weights varset)))
                (declare (fixnum weight))
                (if (>= weight 3)
                  (push (cons (nreverse varset) weight) varsets)))))))
      varsets)))

; Maybe globally allocate registers to symbols naming functions & variables,
; and to simple lexical variables.
(defun ppc2-allocate-global-registers (fcells vcells all-vars no-regs)
  (if no-regs
    (progn
      (dolist (c fcells) (%rplacd c nil))
      (dolist (c vcells) (%rplacd c nil))
      (values 0 nil))
    (let* ((maybe (ppc2-partition-vars all-vars)))
      (dolist (c fcells) 
        (if (>= (the fixnum (cdr c)) 3) (push c maybe)))
      (dolist (c vcells) 
        (if (>= (the fixnum (cdr c)) 3) (push c maybe)))
      (do* ((things (%sort-list-no-key maybe #'%ppc2-bigger-cdr-than) (cdr things))
            (n 0 (1+ n))
            (regno ppc::save0 (1- regno))
            (constant-alist ()))
           ((or (null things) (= n $numppcsaveregs))
            (dolist (cell fcells) (%rplacd cell nil))
            (dolist (cell vcells) (%rplacd cell nil))
            (values n constant-alist))
        (declare (list things)
                 (fixnum n regno))
        (let* ((thing (car things)))
          (if (or (memq thing fcells)
                  (memq thing vcells))
            (push (cons thing regno) constant-alist)
            (dolist (var (car thing))
              (nx-set-var-bits var 
                               (%ilogior (%ilogand (%ilognot $vrefmask) (nx-var-bits var))
                                 regno
                                 (%ilsl $vbitreg 1))))))))))
          
    
;; Vpush the last N non-volatile-registers.
;; Could use a STM here, especially if N is largish or optimizing for space.
(defun ppc2-save-nvrs (seg n)
  (declare (fixnum n))
  (when (> n 0)
    (setq *ppc2-compiler-register-save-label* (ppc2-emit-note seg :regsave))
    (with-local-vinsn-macros (seg)
      (! save-nvrs (- 32 n)))
    (dotimes (i n)
      (ppc2-new-vstack-lcell :regsave 4 0 (- ppc::save0 i)))
    (incf *ppc2-vstack* (the fixnum (* n 4)))
    (setq *ppc2-register-restore-ea* *ppc2-vstack*
          *ppc2-register-restore-count* n)))


; If there are an indefinite number of args/values on the vstack,
; we have to restore from a register that matches the compiler's
; notion of the vstack depth.  This can be computed by the caller 
; (sum of vsp & nargs, or copy of vsp  before indefinite number of 
; args pushed, etc.)
; We DON'T try to compute this from the saved context, since the
; saved vsp may belong to a different stack segment.  (It's cheaper
; to compute/copy than to load it, anyway.)

(defun ppc2-restore-nvrs (seg ea nregs &optional from-fp)
  (when (null from-fp)
    (setq from-fp ppc::vsp))
  (when (and ea nregs)
    (with-local-vinsn-macros (seg)
      (let* ((first (- 32 nregs)))
        (declare (fixnum cell first n))
        (! restore-nvrs first from-fp (- *ppc2-vstack* ea))))))


;; The change is to ask for a stack-consed rest var if the rest var is ignored.
;; And also to pop the rest var immediately if it's ignored, rather than at the end
;; of the function.  That will allow calling the final function tail-recursively.  



(defun ppc2-bind-lambda (seg lcells req opt rest keys auxen optsupvloc passed-in-regs lexpr &optional inherited
                             &aux (vloc 0) (numopt (%ilsl 2 (list-length (%car opt))))
                             (nkeys (list-length (%cadr keys))) 
                             reg)
  (declare (fixnum vloc))
  (WHEN LEXPR (SETQ *IS-LEXPR* T))
  (ppc2-check-lcell-depth)
  (dolist (arg inherited)
    (if (memq arg passed-in-regs)
      (ppc2-set-var-ea seg arg (var-ea arg))
      (let* ((lcell (pop lcells)))
        (if (setq reg (ppc2-assign-register-var arg))
          (ppc2-init-regvar seg arg reg (ppc2-vloc-ea vloc))
          (ppc2-bind-var seg arg vloc lcell))
        (setq vloc (%i+ vloc 4)))))
  (dolist (arg req)
    (if (memq arg passed-in-regs)
      (ppc2-set-var-ea seg arg (var-ea arg))
      (let* ((lcell (pop lcells)))
        (if (setq reg (ppc2-assign-register-var arg))
          (ppc2-init-regvar seg arg reg (ppc2-vloc-ea vloc))
          (ppc2-bind-var seg arg vloc lcell))
        (setq vloc (%i+ vloc 4)))))
  (when opt
    (if (ppc2-hard-opt-p opt)
      (setq vloc (apply #'ppc2-initopt seg vloc optsupvloc lcells (nthcdr (- (length lcells) (ash numopt -2)) lcells) opt)
              lcells (nthcdr (ash numopt -2) lcells))
      (dolist (var (%car opt))
        (if (memq var passed-in-regs)
          (ppc2-set-var-ea seg var (var-ea var))
          (let* ((lcell (pop lcells)))
            (if (setq reg (ppc2-assign-register-var var))
              (ppc2-init-regvar seg var reg (ppc2-vloc-ea vloc))
              (ppc2-bind-var seg var vloc lcell))
            (setq vloc (+ vloc 4)))))))
  (let ((vloc-before-keys vloc)
        (lcells-before-keys lcells))
    (when keys
      ;(apply #'ppc2-init-keys seg vloc lcells keys) ;; do after know where rest arg lives
      (setq vloc (+ vloc (%ilsl 3 nkeys))
            lcells (nthcdr (+ nkeys nkeys) lcells)))
    (when rest
      (if lexpr
        (progn
          (if (setq reg (ppc2-assign-register-var rest))
            (progn
              (ppc2-load-lexpr-address seg reg)
              (ppc2-set-var-ea seg rest reg))
            (with-imm-temps () ((nargs-cell :u32))
              (ppc2-load-lexpr-address seg nargs-cell)
              (let* ((loc *ppc2-vstack*))
                (ppc2-vpush-register seg nargs-cell :reserved)
                (ppc2-note-top-cell rest)
                (ppc2-bind-var seg rest loc *ppc2-top-vstack-lcell*)))))
        (progn
          (if (setq reg (ppc2-assign-register-var rest))
            (ppc2-init-regvar seg rest reg (ppc2-vloc-ea vloc))
            (ppc2-bind-var seg rest vloc (pop lcells)))
          (setq vloc (+ vloc 4)))))
    (when keys (apply #'ppc2-init-keys seg vloc-before-keys lcells-before-keys keys)))
  (ppc2-seq-bind seg (%car auxen) (%cadr auxen)))

(defun ppc2-initopt (seg vloc spvloc lcells splcells vars inits spvars)
  (with-local-vinsn-macros (seg)
    (dolist (var vars vloc)
      (let* ((initform (pop inits))
             (spvar (pop spvars))
             (lcell (pop lcells))
             (splcell (pop splcells))
             (reg (ppc2-assign-register-var var))
             (regloadedlabel (if reg (ppc2-get-next-label))))
        (unless (nx-null initform)
          (ppc2-stack-to-register seg (ppc2-vloc-ea spvloc) ppc::arg_z)
          (let ((skipinitlabel (ppc2-get-next-label)))
            (with-crf-temps () (crf)
              (ppc2-compare-registers seg crf (ppc2-make-compound-cd 0 skipinitlabel) ppc::arg_z ppc::rnil ppc::ppc-eq-bit t))
            (if reg
              (ppc2-form seg reg regloadedlabel initform)
              (ppc2-register-to-stack seg (ppc2-one-untargeted-reg-form seg initform ppc::arg_z) (ppc2-vloc-ea vloc)))
            (@ skipinitlabel)))
        (if reg
          (progn
            (ppc2-init-regvar seg var reg (ppc2-vloc-ea vloc))
            (@ regloadedlabel))
          (ppc2-bind-var seg var vloc lcell))
        (when spvar
          (if (setq reg (ppc2-assign-register-var spvar))
            (ppc2-init-regvar seg spvar reg (ppc2-vloc-ea spvloc))
            (ppc2-bind-var seg spvar spvloc splcell))))
      (setq vloc (%i+ vloc 4))
      (if spvloc (setq spvloc (%i+ spvloc 4))))))

(defun ppc2-init-keys (seg vloc lcells allow-others keyvars keysupp keyinits keykeys)
  (declare (ignore keykeys allow-others))
  (with-local-vinsn-macros (seg)
    (dolist (var keyvars)
      (let* ((spvar (pop keysupp))
             (initform (pop keyinits))
             (reg (ppc2-assign-register-var var))
             (regloadedlabel (if reg (ppc2-get-next-label)))
             (var-lcell (pop lcells))
             (sp-lcell (pop lcells))
             (sploc (%i+ vloc 4)))
        (unless (nx-null initform)
          (ppc2-stack-to-register seg (ppc2-vloc-ea sploc) ppc::arg_z)
          (let ((skipinitlabel (ppc2-get-next-label)))
            (with-crf-temps () (crf)
              (ppc2-compare-registers seg crf (ppc2-make-compound-cd 0 skipinitlabel) ppc::arg_z ppc::rnil ppc::ppc-eq-bit t))
            (if reg
              (ppc2-form seg reg regloadedlabel initform)
              (ppc2-register-to-stack seg (ppc2-one-untargeted-reg-form seg initform ppc::arg_z) (ppc2-vloc-ea vloc)))
            (@ skipinitlabel)))
        (if reg
          (progn
            (ppc2-init-regvar seg var reg (ppc2-vloc-ea vloc))
            (@ regloadedlabel))
          (ppc2-bind-var seg var vloc var-lcell))
        (when spvar
          (if (setq reg (ppc2-assign-register-var spvar))
            (ppc2-init-regvar seg spvar reg (ppc2-vloc-ea sploc))
            (ppc2-bind-var seg spvar sploc sp-lcell))))
      (setq vloc (%i+ vloc 8)))))

; Vpush register r, unless var gets a globally-assigned register.
; Return NIL if register was vpushed, else var.
(defun ppc2-vpush-arg-register (seg reg var)
  (when var
    (let* ((bits (nx-var-bits var)))
      (declare (fixnum bits))
      (if (logbitp $vbitreg bits)
        var
        (progn 
          (ppc2-vpush-register seg reg :reserved)
          nil)))))


; nargs has been validated, arguments defaulted and canonicalized.
; Save caller's context, then vpush any argument registers that
; didn't get global registers assigned to their variables.
; Return a list of vars/nils for each argument register 
;  (nil if vpushed, var if still in arg_reg).
(defun ppc2-argregs-entry (seg revargs)
  (with-local-vinsn-macros (seg)
    (let* ((nargs (length revargs))
           (reg-vars ()))
      (declare (type (unsigned-byte 16) nargs))
      (! save-lr)
      (if (<= nargs $numppcargregs)       ; caller didn't vpush anything
        (if *ppc2-open-code-inline*
          (! save-lisp-context-vsp)
          (! save-lisp-context-vsp-ool))
        (let* ((offset (ash (the fixnum (- nargs $numppcargregs)) 2)))
          (declare (fixnum offset))
          (if *ppc2-open-code-inline*
            (! save-lisp-context-offset offset)
            (! save-lisp-context-offset-ool offset))))
      (destructuring-bind (&optional zvar yvar xvar &rest stack-args) revargs
        (let* ((nstackargs (length stack-args)))
          (ppc2-set-vstack (ash nstackargs 2))
          (dotimes (i nstackargs)
            (ppc2-new-vstack-lcell :reserved 4 0 nil))
          (if (>= nargs 3)
            (push (ppc2-vpush-arg-register seg ppc::arg_x xvar) reg-vars))
          (if (>= nargs 2)
            (push (ppc2-vpush-arg-register seg ppc::arg_y yvar) reg-vars))
          (if (>= nargs 1)
            (push (ppc2-vpush-arg-register seg ppc::arg_z zvar) reg-vars))))
      reg-vars)))

; Just required args.
; Since this is just a stupid bootstrapping port, always save 
; lisp context.
(defun ppc2-req-nargs-entry (seg rev-fixed-args)
  (let* ((nargs (length rev-fixed-args)))
    (declare (type (unsigned-byte 16) nargs))
    (with-local-vinsn-macros (seg)
      (unless *ppc2-reckless*
        (! check-exact-nargs nargs))
      (ppc2-argregs-entry seg rev-fixed-args))))

; No more than three &optional args; all default to NIL and none have
; supplied-p vars.  No &key/&rest.
(defun ppc2-simple-opt-entry (seg rev-opt-args rev-req-args)
  (let* ((min (length rev-req-args))
         (nopt (length rev-opt-args))
         (max (+ min nopt)))
    (declare (type (unsigned-byte 16) min nopt max))
    (with-local-vinsn-macros (seg)
      (unless *ppc2-reckless*
        (when rev-req-args
          (! check-min-nargs min))
        (! check-max-nargs max))
      (if (= nopt 1)
        (! default-1-arg min)
        (if (= nopt 2)
          (! default-2-args min)
          (! default-3-args min)))
      (ppc2-argregs-entry seg (append rev-opt-args rev-req-args)))))

; if "num-fixed" is > 0, we've already ensured that at least that many args
; were provided; that may enable us to generate better code for saving the
; argument registers.
; We're responsible for computing the caller's VSP and saving
; caller's state.
(defun ppc2-lexpr-entry (seg num-fixed)
  (with-local-vinsn-macros (seg)
    (! save-lexpr-argregs num-fixed)
    (dotimes (i num-fixed)
      (! copy-lexpr-argument))
    (! save-lisp-context-lexpr)))

(defun ppc2-load-lexpr-address (seg dest)
  (with-local-vinsn-macros (seg)
    (! load-vframe-address dest *ppc2-vstack*)))


(defun ppc2-structured-initopt (seg lcells vloc context vars inits spvars)
  (with-local-vinsn-macros (seg)
    (dolist (var vars vloc)
      (let* ((initform (pop inits))
             (spvar (pop spvars))
             (spvloc (%i+ vloc 4))
             (var-lcell (pop lcells))
             (sp-lcell (pop lcells)))
        (unless (nx-null initform)
          (ppc2-stack-to-register seg (ppc2-vloc-ea spvloc) ppc::arg_z)
          (let ((skipinitlabel (ppc2-get-next-label)))
            (with-crf-temps () (crf)
              (ppc2-compare-registers seg crf (ppc2-make-compound-cd 0 skipinitlabel) ppc::arg_z ppc::rnil ppc::ppc-eq-bit t))
            (ppc2-register-to-stack seg (ppc2-one-untargeted-reg-form seg initform ppc::arg_z) (ppc2-vloc-ea vloc))
            (@ skipinitlabel)))
        (ppc2-bind-structured-var seg var vloc var-lcell context)
        (when spvar
          (ppc2-bind-var seg spvar spvloc sp-lcell)))
      (setq vloc (%i+ vloc 8)))))



(defun ppc2-structured-init-keys (seg lcells vloc context allow-others keyvars keysupp keyinits keykeys)
  (declare (ignore keykeys allow-others))
  (with-local-vinsn-macros (seg)
    (dolist (var keyvars)
      (let* ((spvar (pop keysupp))
             (initform (pop keyinits))
             (sploc (%i+ vloc 4))
             (var-lcell (pop lcells))
             (sp-lcell (pop lcells)))
        (unless (nx-null initform)
          (ppc2-stack-to-register seg (ppc2-vloc-ea sploc) ppc::arg_z)
          (let ((skipinitlabel (ppc2-get-next-label)))
            (with-crf-temps () (crf)
              (ppc2-compare-registers seg crf (ppc2-make-compound-cd 0 skipinitlabel) ppc::arg_z ppc::rnil ppc::ppc-eq-bit t))
            (ppc2-register-to-stack seg (ppc2-one-untargeted-reg-form seg initform ppc::arg_z) (ppc2-vloc-ea vloc))
            (@ skipinitlabel)))
        (ppc2-bind-structured-var seg var vloc var-lcell context)
        (when spvar
          (ppc2-bind-var seg spvar sploc sp-lcell)))
      (setq vloc (%i+ vloc 8)))))

(defun ppc2-vloc-ea (n &optional vcell-p)
  (setq n (ppc::make-memory-spec (dpb ppc::memspec-frame-address ppc::memspec-type-byte n)))
  (if vcell-p
    (ppc::make-vcell-memory-spec n)
    n))


(defun ppc2-form (seg vreg xfer form)
  (if (nx-null form)
    (ppc2-nil seg vreg xfer)
    (if (nx-t form)
      (ppc2-t seg vreg xfer)
      (let* ((op nil)
             (fn nil))
        (if (and (consp form)
                 (setq fn (svref *ppc2-specials* (%ilogand #.operator-id-mask (setq op (acode-operator form))))))
          (if (and (null vreg)
                   (%ilogbitp operator-acode-subforms-bit op)
                   (%ilogbitp operator-assignment-free-bit op))
            (dolist (f (%cdr form) (ppc2-branch seg xfer nil))
              (ppc2-form seg nil nil f ))
            (apply fn seg vreg xfer (%cdr form)))
          (error "ppc2-form ? ~s" form))))))

; dest is a float reg - form is acode
(defun ppc2-form-float (seg freg xfer form)
  (declare (ignore xfer))
  (when (or (nx-null form)(nx-t form))(error "ppc2-form to freg ~s" form))
  (when (and (= (ppc::get-regspec-mode freg) ppc::hard-reg-class-fpr-mode-double)
             (ppc2-form-typep form 'double-float))
    ; kind of screwy - encoding the source type in the dest register spec
    (ppc::set-node-regspec-type-modes freg ppc::hard-reg-class-fpr-type-double))
  (when (and (= (ppc::get-regspec-mode freg) ppc::hard-reg-class-fpr-mode-single)
             (or (ppc2-form-typep form 'short-float)
                 (ppc2-form-typep form 'single-float)))
    ; kind of screwy - encoding the source type in the dest register spec
    (ppc::set-node-regspec-type-modes freg ppc::hard-reg-class-fpr-type-single))
  (let* ((fn nil))
    (if (and (consp form)
             (setq fn (svref *ppc2-specials* (%ilogand #.operator-id-mask (acode-operator form)))))      
      (apply fn seg freg nil (%cdr form))
      (error "ppc2-form ? ~s" form))))



(defun ppc2-form-typep (form type)
  (if (acode-p form)
    (let* ((op (acode-operator form))
           (opval-p (or (eq op (%nx1-operator fixnum)) (eq op (%nx1-operator immediate))))
           (optype (and *ppc2-trust-declarations*
                        (if (eq op (%nx1-operator typed-form)) 
                          (%cadr form)
                          (if (eq op (%nx1-operator lexical-reference))
                            (var-inittype (%cadr form))
                            (cdr (assq op *nx-operator-result-types*)))))))
      (values
       (if optype 
         (subtypep optype type)
         (if opval-p (typep (%cadr form) type)))))))

(defun ppc2-form-type (form)
  (if (acode-p form)
    (let* ((op (acode-operator form)))
      (if (eq op (%nx1-operator fixnum))
        'fixnum
        (if (eq op (%nx1-operator immediate))
          (type-of (%cadr form))
          (and *ppc2-trust-declarations*
               (if (eq op (%nx1-operator typed-form))
                 (%cadr form)
                 (cdr (assq op *nx-operator-result-types*)))))))))
  
(defun ppc2-use-operator (op seg vreg xfer &rest forms)
  (declare (dynamic-extent forms))
  (apply (svref *ppc2-specials* (%ilogand operator-id-mask op)) seg vreg xfer forms))

; Returns true iff lexical variable VAR isn't setq'ed in FORM.
; Punts a lot ...
(defun ppc2-var-not-set-by-form-p (var form)
  (or (not (%ilogbitp $vbitsetq (nx-var-bits var)))
      (ppc2-setqed-var-not-set-by-form-p var form)))

(defun ppc2-setqed-var-not-set-by-form-p (var form)
  (setq form (ppc2-unwrapped-form form))
  (or (atom form)
      (ppc-constant-form-p form)
      (ppc2-lexical-reference-p form)
      (let ((op (acode-operator form))
            (subforms nil))
        (if (eq op (%nx1-operator setq-lexical))
          (and (neq var (cadr form))
               (ppc2-setqed-var-not-set-by-form-p var (caddr form)))
          (and (%ilogbitp operator-side-effect-free-bit op)
               (flet ((not-set-in-formlist (formlist)
                        (dolist (subform formlist t)
                          (unless (ppc2-setqed-var-not-set-by-form-p var subform) (return)))))
                 (if
                   (cond ((%ilogbitp operator-acode-subforms-bit op) (setq subforms (%cdr form)))
                         ((%ilogbitp operator-acode-list-bit op) (setq subforms (cadr form))))
                   (not-set-in-formlist subforms)
                   (and (or (eq op (%nx1-operator call))
                            (eq op (%nx1-operator lexical-function-call)))
                        (ppc2-setqed-var-not-set-by-form-p var (cadr form))
                        (setq subforms (caddr form))
                        (not-set-in-formlist (car subforms))
                        (not-set-in-formlist (cadr subforms))))))))))
  
(defun ppc2-nil (seg vreg xfer)
  (with-local-vinsn-macros (seg vreg xfer)
    (if (ppc2-for-value-p vreg)
      (ensuring-node-target (target vreg)
        (! load-nil target)))
    (ppc2-branch seg (ppc2-cd-false xfer) vreg)))

(defun ppc2-t (seg vreg xfer)
  (with-local-vinsn-macros (seg vreg xfer)
    (if (ppc2-for-value-p vreg)
      (ensuring-node-target (target vreg)
        (! load-t target)))
    (ppc2-branch seg (ppc2-cd-true xfer) vreg)))

(defun ppc2-crf-p (vreg)
  (ppc2-ea-physical-reg vreg ppc::hard-reg-class-crf))

(defun ppc2-for-value-p (vreg)
  (and vreg (not (ppc2-crf-p vreg))))

(defun ppc2-mvpass (seg form &optional xfer)
  (ppc2-form seg  ppc::arg_z (%ilogior2 (or xfer 0) $ppc-mvpass-mask) form))

(defun ppc2-adjust-vstack (delta)
  (ppc2-set-vstack (%i+ *ppc2-vstack* delta)))

(defun ppc2-set-vstack (new)
  (setq *ppc2-vstack* new))

(defun ppc2-gen-label (seg labelnum)
  (append-dll-node (aref *ppc2-labels* labelnum) seg)
  labelnum)

; Emit a note at the end of the segment.
(defun ppc2-emit-note (seg class &rest info)
  (declare (dynamic-extent info))
  (let* ((note (make-vinsn-note class info)))
    (append-dll-node (vinsn-note-label note) seg)
    note))

; Emit a note immediately before the target vinsn.
(defun ppc-prepend-note (vinsn class &rest info)
  (declare (dynamic-extent info))
  (let* ((note (make-vinsn-note class info)))
    (insert-dll-node-before (vinsn-note-label note) vinsn)
    note))

(defun ppc2-close-note (seg note)
  (let* ((end (close-vinsn-note note)))
    (append-dll-node (vinsn-note-label end) seg)
    end))

(defun ppc2-merge-labels (from-lab to-lab)
  (let* ((to-refs (vinsn-label-refs to-lab)))
    (when to-refs
      ; Make all extant refs to TO-LAB refer to FROM-LAB
      (setf (vinsn-label-refs to-lab) nil)
      (dolist (vinsn to-refs)
        (push vinsn (vinsn-label-refs from-lab))
        (let* ((vp (vinsn-variable-parts vinsn)))
          (declare (simple-vector vp))
          (dotimes (i (the fixnum (length vp)))
            (when (eq to-lab (svref vp i))
              (setf (svref vp i) from-lab))))))))

(defun ppc2-copy-label (from to)
  (let* ((from-lab (aref *ppc2-labels* from))
         (to-lab (aref *ppc2-labels* to)))
    (when (null (vinsn-label-succ from-lab))
      (error "Copy label: not defined yet!"))
    (ppc2-merge-labels from-lab to-lab)
    (setf (aref *ppc2-labels* to) from-lab)))


(defun ppc2-stack-to-register (seg memspec reg)
  (with-local-vinsn-macros (seg)
    (! vframe-load reg (ppc::memspec-frame-address-offset memspec) *ppc2-vstack*)))

(defun ppc2-lcell-to-register (seg lcell reg)
  (with-local-vinsn-macros (seg)
    (! lcell-load reg lcell (ppc2-vstack-mark-top))))


(defun ppc2-register-to-stack (seg reg memspec)
  (with-local-vinsn-macros (seg)
    (! vframe-store reg (ppc::memspec-frame-address-offset memspec) *ppc2-vstack*)))


(defun ppc2-ea-open (ea)
  (if (and ea (ppc::ppc-addrspec-vcell-p ea))
    (ppc::make-memory-spec (ppc::memspec-frame-address-offset ea))
    ea))

(defun ppc2-set-NARGS (seg n)
  (if (> n call-arguments-limit)
    (error "~s exceeded." call-arguments-limit)
    (with-local-vinsn-macros (seg)
      (! set-nargs n))))

(defun ppc2-assign-register-var (v)
  (let ((bits (nx-var-bits v)))
    (when (%ilogbitp $vbitreg bits)
      (%ilogand bits $vrefmask))))

; Can't cross-compile this.  Too bad.
#+ppc-clos
(defun ppc2-single-float-bits (the-sf)
  (uvref the-sf ppc::single-float.value-cell))

#+ppc-clos
(defun ppc2-double-float-bits (the-df)
  (values (uvref the-df ppc::double-float.value-cell)
          (uvref the-df ppc::double-float.val-low-cell)))

(defun ppc2-immediate (seg vreg xfer form)
  (with-local-vinsn-macros (seg vreg xfer)
    (if vreg
      (if (and (= (ppc::hard-regspec-class vreg) ppc::hard-reg-class-fpr)
               (or (and (typep form 'double-float) (= (ppc::get-regspec-mode vreg) ppc::hard-reg-class-fpr-mode-double))
                   (and (typep form 'short-float)(= (ppc::get-regspec-mode vreg) ppc::hard-reg-class-fpr-mode-single))))
        (if (zerop form)
          (if (eql form 0.0d0)
            (! zero-double-float-register vreg)
            (! zero-single-float-register vreg))
          (if (typep form 'short-float)
            (let* ((bits (ppc2-single-float-bits form)))
              (with-imm-temps () ((bitsreg :u32))
                (! lwi bitsreg bits)
                (! load-single-float-constant vreg bitsreg)))
            (multiple-value-bind (high low) (ppc2-double-float-bits form)
              (declare (integer high low))
              (with-imm-temps () ((highreg :u32) (lowreg :u32))
                (if (zerop high)
                  (setq highreg ppc::rzero)
                  (! lwi highreg high))
                (if (zerop low)
                  (setq lowreg ppc::rzero)
                  (! lwi lowreg low))
                (! load-double-float-constant vreg highreg lowreg)))))            
        (ensuring-node-target (target vreg)
          (if (characterp form)
            (ppc2-lwi seg target (logior (ash (char-code form) ppc::charcode-shift) ppc::subtag-character))
            (ppc2-store-immediate seg form target))))
      (if (and (listp form) *load-time-eval-token* (eq (car form) *load-time-eval-token*))
        (ppc2-store-immediate seg form ppc::temp0)))
    (^)))

(defun ppc2-register-constant-p (form)
  (and (consp form)
           (or (memq form *ppc2-vcells*)
               (memq form *ppc2-fcells*))
           (%cdr form)))

(defun ppc2-store-immediate (seg imm dest)
  (with-local-vinsn-macros (seg)
    (let* ((reg (ppc2-register-constant-p imm)))
      (if reg
        (ppc2-copy-register seg dest reg)
        (let* ((idx (ppc2-immediate-index imm)))
          (if (< idx 8192)
            (! ref-constant dest idx)
            (with-imm-target () (idxreg :s32)
              (ppc2-lwi seg idxreg (+ ppc::misc-data-offset (ash (1+ idx) 2)))
              (! ref-indexed-constant dest idxreg)))))
      dest)))

(defun ppc2-immediate-index (imm)
  (or (position imm *ppc2-imms*) (ppc2-new-immediate imm)))

(defun ppc2-new-immediate (form)
  (vector-push-extend form *ppc2-imms*))


; Returns label iff form is (local-go <tag>) and can go without adjusting stack.
(defun ppc2-go-label (form)
  (let ((current-stack (ppc2-encode-stack)))
    (while (and (acode-p form) (or (eq (acode-operator form) (%nx1-operator progn))
                                   (eq (acode-operator form) (%nx1-operator local-tagbody))))
      (setq form (caadr form)))
    (when (acode-p form)
      (let ((op (acode-operator form)))
        (if (and (eq op (%nx1-operator local-go))
                 (ppc2-equal-encodings-p (%caddr (%cadr form)) current-stack))
          (%cadr (%cadr form))
          (if (and (eq op (%nx1-operator local-return-from))
                   (nx-null (caddr form)))
            (let ((tagdata (car (cadr form))))
              (and (ppc2-equal-encodings-p (cdr tagdata) current-stack)
                   (null (caar tagdata))
                   (< 0 (cdar tagdata) $ppc-mvpass)
                   (cdar tagdata)))))))))

(defun ppc2-single-valued-form-p (form)
  (setq form (ppc2-unwrapped-form form))
  (or (nx-null form)
      (nx-t form)
      (if (acode-p form)
        (let ((op (acode-operator form)))
          (or (%ilogbitp operator-single-valued-bit op)
              (and (eql op (%nx1-operator values))
                   (let ((values (cadr form)))
                     (and values (null (cdr values)))))
              nil                       ; Learn about functions someday
              )))))





(defun ppc2-fix-stackreg (seg regnum amt)
  (with-local-vinsn-macros (seg)
    (! adjust-stack-register regnum amt)))



(defun ppc2-get-next-label ()
  (let* ((lnum (length *ppc2-labels*)))
    (if (>= lnum $ppc-mvpass)
      (compiler-function-overflow)
      (vector-push-extend (make-vinsn-label lnum) *ppc2-labels*))))


; Strip off any type info or "punted" lexical references.
; ??? Is it true that the "value" of the punted reference is unwrapped ? ???
(defun ppc2-unwrapped-form (form) 
  (while (and (consp (setq form (nx-untyped-form form)))
           (eq (%car form) (%nx1-operator lexical-reference))
           (ppc2-punted-var-p (cadr form)))
    (setq form (var-ea (cadr form))))
  form)

; safe = T means assume "vector" is miscobj, do bounds check.
; safe = fixnum means check that subtag of vector = "safe" and do bounds check.
; safe = nil means crash&burn.
; This mostly knows how to reference the elements of an immediate miscobj.
; This returns a boxed object.  It'd be nice if there was some way not to.
; Need dfloat vreg scheme.
(defun ppc2-vref (seg vreg xfer subtag vector index safe)
  (declare (fixnum subtag))
  (if (= (the fixnum (logand subtag ppc::fulltagmask)) ppc::fulltag-nodeheader)
    (ppc2-misc-node-ref seg vreg xfer vector index safe)
    (with-local-vinsn-macros (seg vreg xfer)
      (unless (= (the fixnum (logand subtag ppc::fulltagmask)) ppc::fulltag-immheader)
        (error "Bug: not a PPC subtag: ~s" subtag))
      (if (null vreg)
        (progn
          (ppc2-form seg nil nil vector)
          (ppc2-form seg nil xfer index))
        (if (and (= (ppc::hard-regspec-class vreg) ppc::hard-reg-class-fpr)
                 (= subtag ppc::subtag-double-float-vector))
          (ppc2-df-vref seg vreg xfer vector index (if (null safe) nil (if *ppc2-trust-declarations* t safe)))
          (if (and (= (ppc::hard-regspec-class vreg) ppc::hard-reg-class-fpr)
                   (= subtag ppc::subtag-single-float-vector))
            (ppc2-sf-vref seg vreg xfer vector index
                         (if (null safe) nil (if *ppc2-trust-declarations* t safe)))
            (let* ((index-known-fixnum (ppc2-fixnum-form-p index))            
                   (unscaled-idx nil)
                   (src nil))              
              (ensuring-node-target (target vreg)
                (if (or safe (not index-known-fixnum))
                  (multiple-value-setq (src unscaled-idx)
                    (ppc2-two-untargeted-reg-forms seg vector ppc::arg_y index ppc::arg_z))
                  (setq src (ppc2-one-untargeted-reg-form seg vector ppc::arg_z)))
                (when safe
                  (if (typep safe 'fixnum)
                    (! trap-unless-typecode= src safe))
                  (unless (or index-known-fixnum (ppc2-fixnum-type-p index))
                    (! trap-unless-fixnum unscaled-idx))
                  (! check-misc-bound unscaled-idx src))
                (if (<= subtag ppc::max-32-bit-ivector-subtag)
                  (if (and index-known-fixnum (<= index-known-fixnum ppc::max-32-bit-constant-index))
                    (cond ((= subtag ppc::subtag-single-float-vector)
                           (! misc-ref-c-single-float 0 src index-known-fixnum)
                           (! single->heap target 0))
                          (t
                           (with-imm-temps () (temp)
                             (! misc-ref-c-u32 temp src index-known-fixnum)
                             (if (= subtag ppc::subtag-s32-vector)
                               (! s32->integer target temp)
                               (! u32->integer target temp)))))
                    (with-imm-temps () (idx-reg)
                      (if index-known-fixnum
                        (ppc2-absolute-long seg idx-reg nil (+ ppc::misc-data-offset (ash index-known-fixnum 2)))
                        (! scale-32bit-misc-index idx-reg unscaled-idx))
                      (cond ((= subtag ppc::subtag-single-float-vector)
                             (! misc-ref-single-float 0 src idx-reg)
                             (! single->heap target 0))
                            (t (with-imm-temps (idx-reg) (temp)
                                 (! misc-ref-u32 temp src idx-reg)
                                 (if (= subtag ppc::subtag-s32-vector)
                                   (! s32->integer target temp)
                                   (! u32->integer target temp)))))))
                  (if (<= subtag ppc::max-8-bit-ivector-subtag)
                    (with-imm-temps () (temp)
                      (if (and index-known-fixnum (<= index-known-fixnum ppc::max-8-bit-constant-index))
                        (! misc-ref-c-u8 temp src index-known-fixnum)
                        (with-imm-temps () (idx-reg)
                          (if index-known-fixnum
                            (ppc2-absolute-long seg idx-reg nil (+ ppc::misc-data-offset index-known-fixnum))
                            (! scale-8bit-misc-index idx-reg unscaled-idx))
                          (! misc-ref-u8 temp src idx-reg)))
                      (if (= subtag ppc::subtag-u8-vector)
                        (! u8->fixnum target temp)
                        (if (= subtag ppc::subtag-s8-vector)
                          (! s8->fixnum target temp)
                          (! u16->char target temp))))
                    (if (<= subtag ppc::max-16-bit-ivector-subtag)
                      (with-imm-temps () (temp)
                        (if (and index-known-fixnum (<= index-known-fixnum ppc::max-16-bit-constant-index))
                          (! misc-ref-c-u16 temp src index-known-fixnum)
                          (with-imm-temps () (idx-reg)
                            (if index-known-fixnum
                              (ppc2-absolute-long seg idx-reg nil (+ ppc::misc-data-offset (ash index-known-fixnum 1)))
                              (! scale-16bit-misc-index idx-reg unscaled-idx))
                            (! misc-ref-u16 temp src idx-reg)))
                        (if (= subtag ppc::subtag-u16-vector)
                          (! u16->fixnum target temp)
                          (if (= subtag ppc::subtag-s16-vector)
                            (! s16->fixnum target temp)
                            (! u16->char target temp))))
                      ; Down to the dregs.
                      (if (= subtag ppc::subtag-double-float-vector)
                        (progn
                          (if (and index-known-fixnum (<= index-known-fixnum ppc::max-64-bit-constant-index))
                            (! misc-ref-c-double-float 0 src index-known-fixnum)
                            (with-imm-temps () (idx-reg)
                              (if index-known-fixnum
                                (ppc2-absolute-long seg idx-reg nil (+ ppc::misc-dfloat-offset (ash index-known-fixnum 3)))
                                (! scale-64bit-misc-index idx-reg unscaled-idx))
                              (! misc-ref-double-float 0 src idx-reg)))
                          (! double->heap target 0))
                        ;; the last dreg is bit-vector
                        (if (and index-known-fixnum (<= index-known-fixnum ppc::max-1-bit-constant-index))
                          (! misc-ref-c-bit[fixnum] target src index-known-fixnum)
                          (with-imm-temps () (word-index bitnum dest)
                            (if index-known-fixnum
                              (progn
                                (ppc2-lwi seg word-index (+ ppc::misc-data-offset (ash(ash index-known-fixnum -5) 2)))  ;; <<
                                (ppc2-lwi seg bitnum (logand index-known-fixnum #x1f)))
                              (! scale-1bit-misc-index word-index bitnum unscaled-idx))
                            (! misc-ref-u32 dest src word-index)
                            (! extract-variable-bit[fixnum] target dest bitnum))))))))
              (^))))))))

; In this case, the target register is an fp reg and the vector is declared
; do be a double-float vector.  Avoid boxing the result!
(defun ppc2-df-vref (seg vreg xfer vector index safe)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((index-known-fixnum (ppc2-fixnum-form-p index))
           (src)
           (unscaled-idx))
      (if (or safe (not index-known-fixnum))
        (multiple-value-setq (src unscaled-idx)
          (ppc2-two-untargeted-reg-forms seg vector ppc::arg_y index ppc::arg_z))
        (setq src (ppc2-one-untargeted-reg-form seg vector ppc::arg_z)))
      (when safe
        (if (typep safe 'fixnum)
          (! trap-unless-typecode= src safe))
        (unless (or index-known-fixnum (ppc2-fixnum-type-p index))
          (! trap-unless-fixnum unscaled-idx))
        (! check-misc-bound unscaled-idx src))
      (if (and index-known-fixnum (<= index-known-fixnum ppc::max-64-bit-constant-index))
        (! misc-ref-c-double-float vreg src index-known-fixnum)
        (with-imm-temps () (idx-reg)
          (if index-known-fixnum
            (ppc2-absolute-long seg idx-reg nil (+ ppc::misc-dfloat-offset (ash index-known-fixnum 3)))
            (! scale-64bit-misc-index idx-reg unscaled-idx))
          (! misc-ref-double-float vreg src idx-reg)))
      (^))))

(defun ppc2-sf-vref (seg vreg xfer vector index safe)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((index-known-fixnum (ppc2-fixnum-form-p index))
           (src)
           (unscaled-idx))
      (if (or safe (not index-known-fixnum))
        (multiple-value-setq (src unscaled-idx)
          (ppc2-two-untargeted-reg-forms seg vector ppc::arg_y index ppc::arg_z))
        (setq src (ppc2-one-untargeted-reg-form seg vector ppc::arg_z)))
      (when safe
        (if (typep safe 'fixnum)
          (! trap-unless-typecode= src safe))
        (unless (or index-known-fixnum (ppc2-fixnum-type-p index))
          (! trap-unless-fixnum unscaled-idx))
        (! check-misc-bound unscaled-idx src))
      (if (and index-known-fixnum (<= index-known-fixnum ppc::max-32-bit-constant-index))
        (! misc-ref-c-single-float vreg src index-known-fixnum)
        (with-imm-temps () (idx-reg)
          (if index-known-fixnum
            (ppc2-absolute-long seg idx-reg nil (+ ppc::misc-data-offset (ash index-known-fixnum 2)))
            (! scale-32bit-misc-index idx-reg unscaled-idx))
          (! misc-ref-single-float vreg src idx-reg)))
      (^))))

(defun ppc2-2d-aref (seg vreg xfer subtag array idx-0 idx-1 safe)
  (with-local-vinsn-macros (seg vreg xfer)
      (unless (= (the fixnum (logand subtag ppc::fulltagmask)) ppc::fulltag-immheader)
        (error "Bug: not a PPC subtag: ~s" subtag))
      (if (null vreg)
        (progn
          (ppc2-form seg nil nil array)
          (ppc2-form seg nil nil idx-0)
          (ppc2-form seg nil xfer idx-1))
        (if (and (= (ppc::hard-regspec-class vreg) ppc::hard-reg-class-fpr)
                 (= subtag ppc::subtag-double-float-vector))
          (ppc2-2d-df-vref seg vreg xfer array idx-0 idx-1 (if (null safe) nil (if *ppc2-trust-declarations* t safe)))
          (if (and (= (ppc::hard-regspec-class vreg) ppc::hard-reg-class-fpr)
                   (= subtag ppc::subtag-single-float-vector))
            (ppc2-2d-sf-vref seg vreg xfer array idx-0 idx-1
                         (if (null safe) nil (if *ppc2-trust-declarations* t safe)))
            (with-local-vinsn-macros (seg vreg xfer)
              (unless (= (the fixnum (logand subtag ppc::fulltagmask)) ppc::fulltag-immheader)
                (error "Bug: not a PPC subtag: ~s" subtag))
              (let* ((index0-known-fixnum (ppc2-fixnum-form-p idx-0))
                     (index1-known-fixnum (ppc2-fixnum-form-p idx-1))
                     (unscaled-idx0 nil)
                     (unscaled-idx1 nil)
                     (src nil))
                (ensuring-node-target (target vreg)
                  (if t ;(or safe (not index0-known-fixnum)(not index1-known-fixnum))
                    (multiple-value-setq (src unscaled-idx0 unscaled-idx1)
                        (ppc2-three-untargeted-reg-forms seg array ppc::arg_x idx-0 ppc::arg_y idx-1 ppc::arg_z))                    
                    
                    (setq src (ppc2-one-untargeted-reg-form seg array ppc::arg_z)))
                  (when safe
                    (unless (or index0-known-fixnum (ppc2-fixnum-type-p idx-0))
                      (! trap-unless-fixnum unscaled-idx0))
                    (unless (or index1-known-fixnum (ppc2-fixnum-type-p idx-1))
                      (! trap-unless-fixnum unscaled-idx1)))
                  (with-node-temps ()(temp-data temp-idx)
                    (if safe 
                      (! 2d-array-index unscaled-idx0 unscaled-idx1 src temp-idx)
                      (! 2d-array-index-no-bounds-check unscaled-idx0 unscaled-idx1 src temp-idx))        
                    (! misc-ref-data-vector temp-data src)
                    (when (fixnump safe)
                      (! trap-unless-typecode= temp-data safe))
                    (with-imm-temps () (idx-reg)
                      (cond ((= subtag ppc::subtag-single-float-vector)                             
                             (! scale-32bit-misc-index idx-reg temp-idx)
                             (! misc-ref-single-float 0 temp-data idx-reg)
                             (! single->heap target 0))
                            ((= subtag ppc::subtag-double-float-vector)                             
                             (! scale-64bit-misc-index idx-reg temp-idx)
                             (! misc-ref-double-float 0 temp-data idx-reg)
                             (! double->heap target 0))
                            (t (error "Shouldn't happen"))))))
                (^))))))))

;; only called if array is known float type
(defun ppc2-2d-aset (seg vreg xfer subtag array  idx-0 idx-1 value safe)
  (with-local-vinsn-macros (seg vreg xfer)
      (unless (= (the fixnum (logand subtag ppc::fulltagmask)) ppc::fulltag-immheader)
        (error "Bug: not a PPC subtag: ~s" subtag))
      (if nil ;(null vreg)
        (progn
          (error "Shouldn't happen")
          (ppc2-form seg nil nil array)
          (ppc2-form seg nil xfer idx-0))
        (if (and (or (null vreg)(= (ppc::hard-regspec-class vreg) ppc::hard-reg-class-fpr))
                 (= subtag ppc::subtag-double-float-vector))
          (ppc2-2d-df-vset seg vreg xfer array idx-0 idx-1 value (if (null safe) nil (if *ppc2-trust-declarations* t safe)))
          (if (and (or (null vreg)(= (ppc::hard-regspec-class vreg) ppc::hard-reg-class-fpr))
                   (= subtag ppc::subtag-single-float-vector))
            (ppc2-2d-sf-vset seg vreg xfer array idx-0 idx-1 value
                         (if (null safe) nil (if *ppc2-trust-declarations* t safe)))
            ;; finish this
            (with-local-vinsn-macros (seg vreg xfer)
              (unless (= (the fixnum (logand subtag ppc::fulltagmask)) ppc::fulltag-immheader)
                (error "Bug: not a PPC subtag: ~s" subtag))
              (let* ((index0-known-fixnum (ppc2-fixnum-form-p idx-0))
                     (index1-known-fixnum (ppc2-fixnum-form-p idx-1))
                     (constval (ppc2-constant-value-ok-for-subtag subtag value))
                     ;(need-val-reg (or vreg (not constval)))
                     (unscaled-idx0 nil)
                     (unscaled-idx1 nil)                     
                     ;(val-reg)
                     ;(src nil)
                     )
                (with-node-temps () (SRC)
                  (if t ;(or safe (not index0-known-fixnum)(not index1-known-fixnum))
                    (if T ;need-val-reg
                      (progn
                         (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg ARRAY ppc::arg_z))                        
                         (multiple-value-setq (unscaled-idx0 unscaled-idx1 VALUE)
                          (ppc2-three-untargeted-reg-forms seg IDX-0 ppc::arg_x idx-1 ppc::arg_y VALUE ppc::arg_z))
                         (ppc2-vpop-register seg SRC))
                      (multiple-value-setq (src unscaled-idx0 unscaled-idx1)
                        (ppc2-three-untargeted-reg-forms seg array ppc::arg_x idx-0 ppc::arg_y idx-1 ppc::arg_z)))
                    (if T ;need-val-reg
                      (multiple-value-setq (src value)
                        (ppc2-two-untargeted-reg-forms seg array ppc::arg_y value ppc::arg_z))
                      (setq src (ppc2-one-untargeted-reg-form seg array ppc::arg_z))))
                  (when safe
                    (if nil ;(typep safe 'fixnum)
                      (! trap-unless-typecode= src safe))
                    (unless (or index0-known-fixnum (ppc2-fixnum-type-p idx-0))
                      (! trap-unless-fixnum unscaled-idx0))
                    (unless (or index1-known-fixnum (ppc2-fixnum-type-p idx-1))
                      (! trap-unless-fixnum unscaled-idx1)))
                  (with-node-temps ()(temp-data temp-idx)
                    (if safe 
                      (! 2d-array-index unscaled-idx0 unscaled-idx1 src temp-idx)
                      (! 2d-array-index-no-bounds-check unscaled-idx0 unscaled-idx1 src temp-idx))        
                    (! misc-ref-data-vector temp-data src)
                    (when (fixnump safe)
                      (! trap-unless-typecode= temp-data safe))
                    (with-imm-temps () (idx-reg)
                      (with-fp-target () fp-val
                        (cond ((= subtag ppc::subtag-single-float-vector)
                               (when (and safe (not constval))
                                 (! trap-unless-typecode= VALUE ppc::subtag-single-float))
                               (! scale-32bit-misc-index idx-reg temp-idx)
                               (! get-single fp-val value)
                               (! misc-set-single-float fp-val temp-data idx-reg))
                              ((= subtag ppc::subtag-double-float-vector)
                               (when (and safe (not constval))
                                 (! trap-unless-typecode= VALUE ppc::subtag-double-float))
                               (! scale-64bit-misc-index idx-reg temp-idx)
                               (! get-double fp-val value)
                               (! misc-set-double-float fp-val temp-data idx-reg))
                              (t (error "Shouldn't happen"))))))
              (when vreg (<- VALUE))
              (^)))))))))
                         
(defun ppc2-2d-sf-vref (seg vreg xfer vector index0 index1 safe)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((index0-known-fixnum (ppc2-fixnum-form-p index0))
           (index1-known-fixnum (ppc2-fixnum-form-p index1))
           (src)
           (unscaled-idx0)
           (unscaled-idx1))
      (if t ;(or safe (not index0-known-fixnum)(not index1-known-fixnum))
        (multiple-value-setq (src unscaled-idx0 unscaled-idx1)
          (ppc2-three-untargeted-reg-forms seg vector ppc::arg_x index0 ppc::arg_y index1 ppc::arg_z))
        (setq src (ppc2-one-untargeted-reg-form seg vector ppc::arg_z)))
      (when safe
        (if nil ;(typep safe 'fixnum)
          (! trap-unless-typecode= src safe))
        (unless (or index0-known-fixnum (ppc2-fixnum-type-p index0))
          (! trap-unless-fixnum unscaled-idx0))
        (unless (or index1-known-fixnum (ppc2-fixnum-type-p index1))
          (! trap-unless-fixnum unscaled-idx1)))
      (with-node-temps ()(temp-data temp-idx)
        (if safe 
          (! 2d-array-index unscaled-idx0 unscaled-idx1 src temp-idx)
          (! 2d-array-index-no-bounds-check unscaled-idx0 unscaled-idx1 src temp-idx))        
        (! misc-ref-data-vector temp-data src)
        (when (typep safe 'fixnum)
          (! trap-unless-typecode= temp-data safe))
        (with-imm-temps () (idx-reg)
          (! scale-32bit-misc-index idx-reg temp-idx)
          (! misc-ref-single-float vreg temp-data idx-reg)))
        (^))))

(defun ppc2-2d-sf-vset (seg vreg xfer vector index0 index1 value safe)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((index0-known-fixnum (ppc2-fixnum-form-p index0))
           (index1-known-fixnum (ppc2-fixnum-form-p index1))
           ;(src)
           (unscaled-idx0)
           (unscaled-idx1))
      (with-node-temps () (src)
        (with-fp-target () (fp-val :single-float)
          (if t ;(or safe (not index0-known-fixnum)(not index1-known-fixnum))
            (progn 
              (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg vector ppc::arg_z))
              (multiple-value-setq (unscaled-idx0 unscaled-idx1 fp-val)
                (ppc2-three-untargeted-reg-forms seg index0 ppc::arg_x index1 ppc::arg_y value (or vreg fp-val)))
              (ppc2-vpop-register seg src))
            (multiple-value-setq (src fp-val) (ppc2-two-untargeted-reg-forms seg vector ppc::arg_z value (or vreg fp-val))))          
          (when safe          
            (unless (or index0-known-fixnum (ppc2-fixnum-type-p index0))
              (! trap-unless-fixnum unscaled-idx0))
            (unless (or index1-known-fixnum (ppc2-fixnum-type-p index1))
              (! trap-unless-fixnum unscaled-idx1)))
          (with-node-temps ()(temp-data temp-idx)
            (if safe 
              (! 2d-array-index unscaled-idx0 unscaled-idx1 src temp-idx)
              (! 2d-array-index-no-bounds-check unscaled-idx0 unscaled-idx1 src temp-idx))        
            (! misc-ref-data-vector temp-data src)
            (if (typep safe 'fixnum)
              (! trap-unless-typecode= temp-data safe))
            (with-imm-temps () (idx-reg)
              (! scale-32bit-misc-index idx-reg temp-idx)
              (! misc-set-single-float fp-val temp-data idx-reg)))
          (<- fp-val)
          (^))))))
(defun ppc2-2d-df-vset (seg vreg xfer vector index0 index1 value safe)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((index0-known-fixnum (ppc2-fixnum-form-p index0))
           (index1-known-fixnum (ppc2-fixnum-form-p index1))
           ;(src)
           (unscaled-idx0)
           (unscaled-idx1))
      (with-node-temps ()(src)
        (with-fp-target () fp-val
          (if t ;(or safe (not index0-known-fixnum)(not index1-known-fixnum))
            (progn 
              (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg vector ppc::arg_z))
              (multiple-value-setq (unscaled-idx0 unscaled-idx1 fp-val)
                (ppc2-three-untargeted-reg-forms seg index0 ppc::arg_x index1 ppc::arg_y value (or vreg fp-val)))
              (ppc2-vpop-register seg src))
            (multiple-value-setq (src fp-val)(ppc2-two-untargeted-reg-forms seg vector ppc::arg_z value (or vreg fp-val))))
          (when safe          
            (unless (or index0-known-fixnum (ppc2-fixnum-type-p index0))
              (! trap-unless-fixnum unscaled-idx0))
            (unless (or index1-known-fixnum (ppc2-fixnum-type-p index1))
              (! trap-unless-fixnum unscaled-idx1)))
          (with-node-temps ()(temp-data temp-idx)
            (if safe 
              (! 2d-array-index unscaled-idx0 unscaled-idx1 src temp-idx)
              (! 2d-array-index-no-bounds-check unscaled-idx0 unscaled-idx1 src temp-idx))        
            (! misc-ref-data-vector temp-data src)
            (if (typep safe 'fixnum)
              (! trap-unless-typecode= temp-data safe))
            (with-imm-temps () (idx-reg)
              (! scale-64bit-misc-index idx-reg temp-idx)
              (! misc-set-double-float fp-val temp-data idx-reg)))
          (<- fp-val)
          (^))))))

(defun ppc2-2d-df-vref (seg vreg xfer vector index0 index1 safe)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((index0-known-fixnum (ppc2-fixnum-form-p index0))
           (index1-known-fixnum (ppc2-fixnum-form-p index1))
           (src)
           (unscaled-idx0)
           (unscaled-idx1))
      (if t ;(or safe (not index0-known-fixnum)(not index1-known-fixnum))
        (multiple-value-setq (src unscaled-idx0 unscaled-idx1)
          (ppc2-three-untargeted-reg-forms seg vector ppc::arg_x index0 ppc::arg_y index1 ppc::arg_z))
        (setq src (ppc2-one-untargeted-reg-form seg vector ppc::arg_z)))
      (when safe        
        (unless (or index0-known-fixnum (ppc2-fixnum-type-p index0))
          (! trap-unless-fixnum unscaled-idx0))
        (unless (or index1-known-fixnum (ppc2-fixnum-type-p index1))
          (! trap-unless-fixnum unscaled-idx1)))
      (with-node-temps ()(temp-data temp-idx)
        (if safe 
          (! 2d-array-index unscaled-idx0 unscaled-idx1 src temp-idx)
          (! 2d-array-index-no-bounds-check unscaled-idx0 unscaled-idx1 src temp-idx))        
        (! misc-ref-data-vector temp-data src)
        (if (typep safe 'fixnum)
          (! trap-unless-typecode= temp-data safe))
        (with-imm-temps () (idx-reg)
          (! scale-64bit-misc-index idx-reg temp-idx)
          (! misc-ref-double-float vreg temp-data idx-reg)))
        (^))))
          


(defun ppc2-constant-value-ok-for-subtag (subtag form)
  (declare (fixnum subtag))
  (if (and (acode-p form)
           (or (eq (acode-operator form) (%nx1-operator immediate))
               (eq (acode-operator form) (%nx1-operator fixnum))))
    (let* ((val (%cadr form))
           (typep (cond ((= subtag ppc::subtag-s32-vector)
                         (typep val '(signed-byte 32)))
                        ((= subtag ppc::subtag-single-float-vector)
                         (typep val 'short-float))
                        ((= subtag ppc::subtag-double-float-vector)
                         (typep val 'double-float))
                        ((<= subtag ppc::max-32-bit-ivector-subtag)
                         (typep val '(unsigned-byte 32)))
                        ((= subtag ppc::subtag-simple-base-string)
                         (typep val 'base-character))
                        ((= subtag ppc::subtag-s8-vector)
                         (typep val '(signed-byte 8)))
                        ((= subtag ppc::subtag-u8-vector)
                         (typep val '(unsigned-byte 8)))
                        ((= subtag ppc::subtag-simple-general-string)
                         (typep val 'character))
                        ((= subtag ppc::subtag-s16-vector) 
                         (typep val '(signed-byte 16)))
                        ((= subtag ppc::subtag-u16-vector)
                         (typep val '(unsigned-byte 16)))
                        ((= subtag ppc::subtag-bit-vector)
                         (typep val 'bit)))))
      (if typep val))))
                       
                   
      


(defun ppc2-vset (seg vreg xfer subtag vector index value safe)
  (declare (fixnum subtag))
  (if (= (the fixnum (logand subtag ppc::fulltagmask)) ppc::fulltag-nodeheader)
    (ppc2-misc-node-set seg vreg xfer vector index value safe)
    (if (and (= subtag ppc::subtag-double-float-vector)
             (or (null vreg) (= (ppc::hard-regspec-class vreg) ppc::hard-reg-class-fpr)))
      (ppc2-df-vset seg vreg xfer vector index value 
                    (if (null safe) nil (if *ppc2-trust-declarations* t safe)))
      (if (and (= subtag ppc::subtag-single-float-vector)
               (or (null vreg) (= (ppc::hard-regspec-class vreg) ppc::hard-reg-class-fpr)))
        (ppc2-sf-vset seg vreg xfer vector index value 
                      (if (null safe) nil (if *ppc2-trust-declarations* t safe)))
        
        (with-local-vinsn-macros (seg vreg xfer)
          (unless (= (the fixnum (logand subtag ppc::fulltagmask)) ppc::fulltag-immheader)
            (error "Bug: not a PPC subtag: ~s" subtag))
          (let* ((index-known-fixnum (ppc2-fixnum-form-p index))
                 (constval (ppc2-constant-value-ok-for-subtag subtag value))
                 (need-val-reg (or vreg (not constval)))
                 (unscaled-idx nil)
                 (idx-reg nil)
                 (val-reg)
                 (src nil))
            (if (or safe (not index-known-fixnum))
              (if need-val-reg
                (multiple-value-setq (src unscaled-idx val-reg)
                  (ppc2-three-untargeted-reg-forms seg vector ppc::arg_x index ppc::arg_y value ppc::arg_z))
                (multiple-value-setq (src unscaled-idx)
                  (ppc2-two-untargeted-reg-forms seg vector ppc::arg_y index ppc::arg_z)))
              (if need-val-reg
                (multiple-value-setq (src val-reg)
                  (ppc2-two-untargeted-reg-forms seg vector ppc::arg_y value ppc::arg_z))
                (setq src (ppc2-one-untargeted-reg-form seg vector ppc::arg_z))))
            (when safe
              (if (typep safe 'fixnum)
                (! trap-unless-typecode= src safe))
              (unless (or index-known-fixnum (ppc2-fixnum-type-p index))
                (! trap-unless-fixnum unscaled-idx))
              (! check-misc-bound unscaled-idx src))
            (with-imm-temps () (temp)
              (cond ((<= subtag ppc::max-32-bit-ivector-subtag)
                     (if (and constval (not (= subtag ppc::subtag-single-float-vector)))
                       (ppc2-lwi seg temp constval)
                       (cond ((= subtag ppc::subtag-single-float-vector)
                              (when (and safe (not constval))
                                (! trap-unless-typecode= val-reg ppc::subtag-single-float))
                              (! misc-ref-c-u32 temp val-reg ppc::single-float.value-cell))
                             ((= subtag ppc::subtag-s32-vector)
                              (! unbox-s32 temp val-reg))
                             (t
                              (! unbox-u32 temp val-reg))))
                     (if (and index-known-fixnum 
                              (<= index-known-fixnum ppc::max-32-bit-constant-index))
                       (! misc-set-c-u32 temp src index-known-fixnum)
                       (progn
                         (setq idx-reg (ppc2-make-unwired-lreg (ppc-select-imm-temp :u32)))
                         (if index-known-fixnum
                           (ppc2-absolute-long seg idx-reg nil (+ ppc::misc-data-offset (ash index-known-fixnum 2)))
                           (! scale-32bit-misc-index idx-reg unscaled-idx))
                         (! misc-set-u32 temp src idx-reg))))                   
                    ((<= subtag ppc::max-8-bit-ivector-subtag)
                     (if constval
                       (ppc2-lwi seg temp (if (characterp constval) (char-code constval) constval))
                       (if safe
                         (cond ((= subtag ppc::subtag-simple-base-string)
                                (! unbox-base-character temp val-reg))
                               ((= subtag ppc::subtag-s8-vector)
                                (! unbox-s8 temp val-reg))
                               (t
                                (! unbox-u8 temp val-reg)))
                         (if (= subtag ppc::subtag-simple-base-string)
                           (! character->code temp val-reg)
                           (! fixnum->u32 temp val-reg))))
                     (if (and index-known-fixnum 
                              (<= index-known-fixnum ppc::max-8-bit-constant-index))
                       (! misc-set-c-u8 temp src index-known-fixnum)
                       (progn
                         (setq idx-reg (ppc2-make-unwired-lreg (ppc-select-imm-temp :u32)))
                         (if index-known-fixnum
                           (ppc2-absolute-long seg idx-reg nil (+ ppc::misc-data-offset index-known-fixnum))
                           (! scale-8bit-misc-index idx-reg unscaled-idx))
                         (! misc-set-u8 temp src idx-reg))))
                    ((<= subtag ppc::max-16-bit-ivector-subtag)
                     (if constval
                       (ppc2-lwi seg temp (if (characterp constval) (char-code constval) constval))
                       (if safe
                         (cond ((= subtag ppc::subtag-simple-general-string)
                                (! unbox-character temp val-reg))
                               ((= subtag ppc::subtag-s16-vector)
                                (! unbox-s16 temp val-reg))
                               (t
                                (! unbox-u16 temp val-reg)))
                         (if (= subtag ppc::subtag-simple-general-string)
                           (! character->code temp val-reg)
                           (! fixnum->u32 temp val-reg))))
                     (if (and index-known-fixnum 
                              (<= index-known-fixnum ppc::max-16-bit-constant-index))
                       (! misc-set-c-u16 temp src index-known-fixnum)
                       (progn
                         (setq idx-reg (ppc2-make-unwired-lreg (ppc-select-imm-temp :u32)))
                         (if index-known-fixnum
                           (ppc2-absolute-long seg idx-reg nil (+ ppc::misc-data-offset (ash index-known-fixnum 1)))
                           (! scale-16bit-misc-index idx-reg unscaled-idx))
                         (! misc-set-u16 temp src idx-reg))))
                    ((= subtag ppc::subtag-double-float-vector)
                     (if safe
                       (! get-double? 0 val-reg)
                       (! get-double 0 val-reg))
                     (if (and index-known-fixnum 
                              (<= index-known-fixnum ppc::max-64-bit-constant-index))
                       (! misc-set-c-double-float 0 src index-known-fixnum)
                       (progn
                         (setq idx-reg temp)
                         (if index-known-fixnum
                           (ppc2-absolute-long seg idx-reg nil (+ ppc::misc-dfloat-offset (ash index-known-fixnum 3)))
                           (! scale-64bit-misc-index idx-reg unscaled-idx))
                         (! misc-set-double-float 0 src idx-reg))))
                    (t
                     ; bit-vector case.
                     ; It's easiest to do this when the bitnumber is known (and a little easier still
                     ; if the value's known.)
                     (if (and index-known-fixnum (<= index-known-fixnum ppc::max-1-bit-constant-index))
                       (let* ((word-index (ash index-known-fixnum -5))
                              (bit-number (logand index-known-fixnum #x1f)))
                         (! misc-ref-c-u32 temp src word-index)
                         (if constval                         
                           (if (zerop constval)
                             (! set-constant-ppc-bit-to-0 temp temp bit-number)
                             (! set-constant-ppc-bit-to-1 temp temp bit-number))
                           (with-imm-temps () (bitval)
                             (! unbox-bit bitval val-reg)
                             (! set-constant-ppc-bit-to-variable-value temp temp bitval bit-number)))
                         (! misc-set-c-u32 temp src word-index))
                       ; When the bit-number isn't known, we have to do one of the following:
                       ; A) If the value's known:
                       ;   1) generate a mask with a 1 in the "bitnum" bit and 0s elsewhere.
                       ;   2) Grab the word out of the vector.
                       ;   3) If the value's 0, do an ANDC with the mask and word, else an OR.
                       ; B) When the value's not known:
                       ;   1) Extract the value into PPC bit 0 of some register, trapping if value not a bit.
                       ;   2) Shift the value right "bitnum" bits.
                       ;   3) Generate a mask with a 1 in the "bitnum" bit and 0s elsewhere.
                       ;   4) Reference the word, ANDC it with the mask, OR the shifted value in.
                       (with-imm-temps () (word-index bit-number)
                         (! scale-1bit-misc-index word-index bit-number unscaled-idx)
                         (if constval
                           (progn
                             (! lwi temp #x80000000)
                             (! shift-right-variable-word bit-number temp bit-number)       ; (A1)
                             (! misc-ref-u32 temp src word-index)   ; (A2)
                             (if (zerop constval)   ; (A3)
                               (! u32logandc2 temp temp bit-number)
                               (! u32logior temp temp bit-number)))
                           (with-imm-temps () (bitval)
                             (! unbox-bit-bit0 bitval val-reg)      ; (B1)
                             (! shift-right-variable-word bitval bitval bit-number)         ; (B2)
                             (! lwi temp #x80000000)
                             (! shift-right-variable-word bit-number temp bit-number)       ; (B3)
                             (! misc-ref-u32 temp src word-index)
                             (! u32logandc2 temp temp bit-number)      ; clear bit-number'th bit
                             (! u32logior temp temp bitval)))       ; (B4)                     
                         (! misc-set-u32 temp src word-index))))))
            (when vreg (<- val-reg))
            (^)))))))

;; In this case, the destination (vreg) is either an FPR or null, so
;; we can maybe avoid boxing the value.
(defun ppc2-df-vset (seg vreg xfer vector index value safe)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((index-known-fixnum (ppc2-fixnum-form-p index))
           (src nil)
           (unscaled-idx nil))
      (with-fp-target () fp-val
        (if (or safe (not index-known-fixnum))
          (multiple-value-setq (src unscaled-idx fp-val)
            (ppc2-three-untargeted-reg-forms seg vector ppc::arg_y index ppc::arg_z value (or vreg fp-val)))
          (multiple-value-setq (src fp-val)
            (ppc2-two-untargeted-reg-forms seg vector ppc::arg_z value (or vreg fp-val))))
        (when safe
            (if (typep safe 'fixnum)
              (! trap-unless-typecode= src safe))
            (unless (or index-known-fixnum (ppc2-fixnum-type-p index))
              (! trap-unless-fixnum unscaled-idx))
            (! check-misc-bound unscaled-idx src))
        (if (and index-known-fixnum
                 (<= index-known-fixnum ppc::max-64-bit-constant-index))
          (! misc-set-c-double-float fp-val src index-known-fixnum)
          (with-imm-temps () (idx-reg)
            (if index-known-fixnum
              (ppc2-absolute-long seg idx-reg nil (+ ppc::misc-dfloat-offset (ash index-known-fixnum 3)))
              (! scale-64bit-misc-index idx-reg unscaled-idx))
            (! misc-set-double-float fp-val src idx-reg)))
        (<- fp-val)                     ; should be a no-op in this case
        (^)))))

(defun ppc2-sf-vset (seg vreg xfer vector index value safe)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((index-known-fixnum (ppc2-fixnum-form-p index))
           (src nil)
           (unscaled-idx nil))
      (with-fp-target () (fp-val :single-float)
        (if (or safe (not index-known-fixnum))
          (multiple-value-setq (src unscaled-idx fp-val)
            (ppc2-three-untargeted-reg-forms seg vector ppc::arg_y index ppc::arg_z value (or vreg fp-val)))
          (multiple-value-setq (src fp-val)
            (ppc2-two-untargeted-reg-forms seg vector ppc::arg_z value (or vreg fp-val))))
        (when safe
            (if (typep safe 'fixnum)
              (! trap-unless-typecode= src safe))
            (unless (or index-known-fixnum (ppc2-fixnum-type-p index))
              (! trap-unless-fixnum unscaled-idx))
            (! check-misc-bound unscaled-idx src))
        (if (and index-known-fixnum
                 (<= index-known-fixnum ppc::max-32-bit-constant-index))
          (! misc-set-c-single-float fp-val src index-known-fixnum)
          (with-imm-temps () (idx-reg)
            (if index-known-fixnum
              (ppc2-absolute-long seg idx-reg nil (+ ppc::misc-data-offset (ash index-known-fixnum 2)))
              (! scale-32bit-misc-index idx-reg unscaled-idx))
            (! misc-set-single-float fp-val src idx-reg)))
        (<- fp-val)                     ; should be a no-op in this case
        (^)))))



            
          
        


(defun ppc2-tail-call-alias (immref sym &optional arglist)
  (let ((alias (cdr (assq sym *ppc2-tail-call-aliases*))))
    (if (and alias (or (null arglist) (eq (+ (length (car arglist)) (length (cadr arglist))) (cdr alias))))
      (make-acode (%nx1-operator immediate) (car alias))
      immref)))

; If BODY is essentially an APPLY involving an &rest arg, try to avoid
; consing it.
(defun ppc2-eliminate-&rest (body rest key-p auxen rest-values)
  (when (and rest (not key-p) (not (cadr auxen)) rest-values)
    (when (eq (logand (the fixnum (nx-var-bits rest))
                      (logior $vsetqmask #+ignore (ash -1 $vbitspecial) #-ignore (ASH 1 $vbitspecial)
                              (ash 1 $vbitclosed) (ash 1 $vbitsetq) (ash 1 $vbitcloseddownward)))
              0)               ; Nothing but simple references
      (do* ()
           ((not (acode-p body)))
        (let* ((op (acode-operator body)))
          (if (or (eq op (%nx1-operator lexical-function-call))
                  (eq op (%nx1-operator call)))
            (destructuring-bind (fn-form (stack-args reg-args) &optional spread-p) (%cdr body)
               (unless (and (eq spread-p t)
                           (eq (ppc2-lexical-reference-p (%car reg-args)) rest))
                (return nil))
              (flet ((independent-of-all-values (form)        
                       (setq form (ppc2-unwrapped-form form))
                       (or (ppc-constant-form-p form)
                           (let* ((lexref (ppc2-lexical-reference-p form)))
                             (and lexref 
                                  (neq lexref rest)
                                  (dolist (val rest-values t)
                                    (unless (ppc2-var-not-set-by-form-p lexref val)
                                      (return))))))))
                (unless (or (eq op (%nx1-operator lexical-function-call))
                            (independent-of-all-values fn-form))
                  (return nil))
                (if (dolist (s stack-args t)
                          (unless (independent-of-all-values s)
                            (return nil)))
                  (let* ((arglist (append stack-args rest-values)))
                    (return
                     (make-acode op 
                                 fn-form 
                                 (if (<= (length arglist) $numppcargregs)
                                   (list nil (reverse arglist))
                                   (list (butlast arglist $numppcargregs)
                                         (reverse (last arglist $numppcargregs))))
                                 nil)))
                  (return nil))))
            (if (eq op (%nx1-operator local-block))
              (setq body (%cadr body))
              (if (and (eq op (%nx1-operator if))
                       (eq (ppc2-lexical-reference-p (%cadr body)) rest))
                (setq body (%caddr body))
                (return nil)))))))))

(defun ppc2-call-fn (seg vreg xfer fn arglist spread-p)
  (with-local-vinsn-macros (seg vreg xfer)
    (when spread-p
      (destructuring-bind (stack-args reg-args) arglist
        (when (and (null (cdr reg-args))
                   (nx-null (ppc2-unwrapped-form (car reg-args))))
          (setq spread-p nil)
          (let* ((nargs (length stack-args)))
            (declare (fixnum nargs))
            (if (<= nargs $numppcargregs)
              (setq arglist (list nil (reverse stack-args)))
              (setq arglist (list (butlast stack-args $numppcargregs) (reverse (last stack-args $numppcargregs)))))))))
    (let* ((lexref (ppc2-lexical-reference-p fn))
           (simple-case (or (fixnump fn) 
                            (ppc2-immediate-function-p fn)
                            (and 
                             lexref
                             (not spread-p)
                             (flet ((all-simple (args)
                                      (dolist (arg args t)
                                        (when (and arg (not (ppc2-var-not-set-by-form-p lexref arg)))
                                          (return)))))
                               (and (all-simple (car arglist))
                                    (all-simple (cadr arglist))
                                    (setq fn (var-ea lexref)))))))
           (cstack *ppc2-cstack*)
           (top *ppc2-top-vstack-lcell*)
           (vstack *ppc2-vstack*))
      (setq xfer (or xfer 0))
      (when (and (eq xfer $ppc-return)
                 (eq 0 *ppc2-undo-count*)
                 (acode-p fn)
                 (eq (acode-operator fn) (%nx1-operator immediate))
                 (symbolp (cadr fn)))
        (setq fn (ppc2-tail-call-alias fn (%cadr fn) arglist)))
      
      (if (and (eq xfer $ppc-return) (not (ppc2-tailcallok xfer)))
        (progn
          (ppc2-call-fn seg vreg $ppc-mvpass fn arglist spread-p)
          (ppc2-set-vstack (%i+ (if simple-case 0 4) vstack))
          (setq  *ppc2-cstack* cstack)
          (let ((*ppc2-returning-values* t)) (ppc2-do-return seg)))
        (let* ((mv-p (ppc2-mv-p xfer)))
          (unless simple-case
            (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg fn ppc::arg_z))
            (setq fn (ppc2-vloc-ea vstack)))
          (ppc2-invoke-fn seg fn (ppc2-arglist seg arglist) spread-p xfer)
          (if (and (%ilogbitp $ppc-mvpass-bit xfer)
                   (not simple-case))
            (progn
              (! call-subprim .SPsave-values)
              (! vstack-discard 1)
              (ppc2-set-nargs seg 0)
              (! call-subprim .SPrecover-values))
            (unless (or mv-p simple-case)
              (! vstack-discard 1)))
          (ppc2-set-vstack vstack)
          (setq *ppc2-top-vstack-lcell* top)
          (setq *ppc2-cstack* cstack)
          (when (or (%ilogbitp $ppc-mvpass-bit xfer) (not mv-p))
            (<- ppc::arg_z)
            (ppc2-branch seg (%ilogand2 (%ilognot $ppc-mvpass-mask) xfer) vreg))))
      nil)))

(defun ppc2-restore-full-lisp-context (seg)
  (with-local-vinsn-macros (seg)
    (if *ppc2-open-code-inline*
      (! restore-full-lisp-context)
      (! restore-full-lisp-context-ool))))

(defun ppc2-call-symbol (seg jump-p)
  ; fname contains a symbol; we can either call it via
  ; a call to .SPjmpsym or expand the instructions inline.
  ; Since the branches are unconditional, the call doesn't
  ; cost much, but doing the instructions inline would give
  ; an instruction scheduler some opportunities to improve
  ; performance, so this isn't a strict time/speed tradeoff.
  ; This should probably dispatch on something other than
  ; *ppc2-open-code-inline*, since that does imply a time/speed
  ; tradeoff.
  (with-local-vinsn-macros (seg)
    (if *ppc2-open-code-inline*
      (if jump-p
        (! jump-known-symbol)
        (! call-known-symbol))
      (if jump-p
        (! jump-subprim .SPjmpsym)
        (! call-subprim .SPjmpsym)))))

; Nargs = nil -> multiple-value case.
(defun ppc2-invoke-fn (seg fn nargs spread-p xfer)
  (with-local-vinsn-macros (seg)
    (let* ((f-op (ppc2-unwrapped-form fn))
           (immp (and (consp f-op)
                      (eq (%car f-op) (%nx1-operator immediate))))
           (symp (and immp (symbolp (%cadr f-op))))
           (label-p (and (fixnump fn) 
                         (locally (declare (fixnum fn))
                           (and (= fn -1) (- fn)))))
           (tail-p (eq xfer $ppc-return))
           (func (if (consp f-op) (%cadr f-op)))
           (a-reg nil)
           (lfunp (and (acode-p f-op) 
                       (eq (acode-operator f-op) (%nx1-operator simple-function))))
           (expression-p (and (fixnump fn) (not label-p)))
           (callable (or symp lfunp label-p))
           (destreg (if symp ppc::fname (if lfunp ppc::nfn (unless label-p ppc::temp0)))))
      (when expression-p
        ;Have to do this before spread args, since might be vsp-relative.
        (if nargs
          (ppc2-do-lexical-reference seg destreg fn)
          (ppc2-copy-register seg destreg fn)))
      (if (or symp lfunp)
        (setq func (if symp (ppc2-symbol-entry-locative func)
                       (ppc2-afunc-lfun-ref func))
              a-reg (ppc2-register-constant-p func)))
      (when tail-p
        #-no-compiler-bugs
        (unless (or immp symp lfunp (fixnump fn)) (error "Well, well, well.  How could this have happened ?"))
        (when a-reg
          (ppc2-copy-register seg destreg a-reg))
        (unless spread-p
          (if nargs
            (ppc2-restore-nvrs seg *ppc2-register-restore-ea* *ppc2-register-restore-count*)
            (when *ppc2-register-restore-count*
              (with-imm-temps () (vsp0)
                (! fixnum-add vsp0 ppc::vsp ppc::nargs)
                (ppc2-restore-nvrs seg *ppc2-register-restore-ea* *ppc2-register-restore-count* vsp0))))))
       (if spread-p
         (progn
           (ppc2-set-nargs seg (%i- nargs 1))
           (when (and tail-p *ppc2-register-restore-count*)
             (! copy-gpr ppc::temp1 ppc::vsp))          ; .SPspread-lexpr-z & .SPspreadargz preserve temp1
           (! call-subprim (if (eq spread-p 0) .SPspread-lexpr-z .SPspreadargz))
           (when (and tail-p *ppc2-register-restore-count*)
             (ppc2-restore-nvrs seg *ppc2-register-restore-ea* *ppc2-register-restore-count* ppc::temp1)))
        (if nargs
          (ppc2-set-nargs seg nargs) 
          (! call-subprim .SPvpopargregs)))
      (if callable
        (if (not tail-p)
          (if (ppc2-mvpass-p xfer)
            (progn
              (if label-p
                (ppc2-copy-register seg ppc::temp0 ppc::fn)
                (if a-reg
                  (ppc2-copy-register seg ppc::temp0 a-reg)
                  (ppc2-store-immediate seg func ppc::temp0)))
              (! call-subprim .SPmvpass))
            (progn 
              (if label-p
                (progn
                  (ppc2-copy-register seg ppc::nfn ppc::fn)
                  (! call-label (aref *ppc2-labels* 1)))
                (progn
                  (if a-reg
                    (ppc2-copy-register seg destreg a-reg)
                    (ppc2-store-immediate seg func destreg))
                  (if symp
                    (ppc2-call-symbol seg nil)
                    (! call-known-function))))))
          (progn
            (ppc2-unwind-stack seg xfer 0 0 #x1fff)  ;; << was #x7ff
            (if (and (not spread-p) nargs (%i<= nargs $numppcargregs))
              (progn
                (if label-p
                  (ppc2-copy-register seg ppc::nfn ppc::fn))
                (unless (or label-p a-reg) (ppc2-store-immediate seg func destreg))
                (ppc2-restore-full-lisp-context seg)
                (if label-p
                  (! jump (aref *ppc2-labels* 1))
                  (progn
                    (if symp
                      (ppc2-call-symbol seg t)
                      (! jump-known-function)))))
              (progn
                (if label-p
                  (ppc2-copy-register seg ppc::nfn ppc::fn)
                  (unless a-reg (ppc2-store-immediate seg func destreg)))
                (! jump-subprim 
                   (cond ((or spread-p (null nargs)) (if symp .SPtcallsymgen .SPtcallnfngen))
                         ((%i> nargs $numppcargregs) (if symp .SPtcallsymslide .SPtcallnfnslide))
                         (t (if symp .SPtcallsymvsp .SPtcallnfnvsp))))))))
        ; The general (funcall) case.
        (progn
          (unless (fixnump fn) 
            (ppc2-one-targeted-reg-form seg fn destreg))
          (if (not tail-p)
            (if (ppc2-mvpass-p xfer)
              (! call-subprim .SPmvpass)
              (! call-subprim .SPfuncall))                  
            (! jump-subprim 
               (cond ((or (null nargs) spread-p) .SPtfuncallgen)
                     ((%i> nargs $numppcargregs) .SPtfuncallslide)
                     (t .SPtfuncallvsp)))))))
    nil))

(defun ppc2-seq-fbind (seg vreg xfer vars afuncs body p2decls)
  (let* ((old-stack (ppc2-encode-stack))
         (copy afuncs)
         (func nil))
    (with-ppc-p2-declarations p2decls 
      (dolist (var vars) 
        (when (neq 0 (afunc-fn-refcount (setq func (pop afuncs))))
          (ppc2-seq-bind-var seg var (nx1-afunc-ref func))))
      (ppc2-undo-body seg vreg xfer body old-stack)
      (dolist (var vars)
        (when (neq 0 (afunc-fn-refcount (setq func (pop copy))))
          (ppc2-close-var seg var))))))

(defun ppc2-make-closure (seg afunc downward-p)
  (with-local-vinsn-macros (seg)
    (flet ((var-to-reg (var target)
             (let* ((ea (var-ea (var-bits var))))
               (if ea
                 (progn
                   (ppc2-addrspec-to-reg seg (ppc2-ea-open ea) target)
                   target)
                 ppc::rnil)))
           (set-some-cells (dest cellno c0 c1 c2 c3)
             (declare (fixnum cellno))
             (! misc-set-c-node c0 dest cellno)
             (incf cellno)
             (when c1
               (! misc-set-c-node c1 dest cellno)
               (incf cellno)
               (when c2
                 (! misc-set-c-node c2 dest cellno)
                 (incf cellno)
                 (when c3
                   (! misc-set-c-node c3 dest cellno)
                   (incf cellno))))
             cellno))
      (let* ((inherited-vars (afunc-inherited-vars afunc))
             (dest (ppc2-make-wired-lreg ppc::arg_z))
             (vsize (+ (length inherited-vars) 
                       2                  ; %closure-code%, afunc
                       2)))               ; name, lfun-bits
        (declare (list inherited-vars))
        (if downward-p
          (progn
            (let* ((*ppc2-vstack* *ppc2-vstack*)
                   (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*))
              (ppc2-lwi seg ppc::arg_x (ash ppc::subtag-function ppc::fixnumshift))
              (! %closure-code% ppc::arg_y)
              (ppc2-store-immediate seg (ppc2-afunc-lfun-ref afunc) ppc::arg_z)
              (ppc2-vpush-register-arg seg ppc::arg_x)
              (ppc2-vpush-register-arg seg ppc::arg_y)
              (ppc2-vpush-register-arg seg ppc::arg_z)
              ; Could be smarter about memory traffic here.
              (dolist (v inherited-vars)
                (ppc2-vpush-register-arg seg (var-to-reg v ppc::arg_z)))       
              (ppc2-vpush-register-arg seg ppc::rnil)
              (ppc2-lwi seg ppc::arg_z (ash (ash 1 $lfbits-trampoline-bit) ppc::fixnumshift))
              (ppc2-vpush-register-arg seg ppc::arg_z)
              (ppc2-set-nargs seg (1+ vsize))     ; account for subtag
              (! call-subprim-0 dest .SPstkgvector))
            (ppc2-open-undo $undostkblk))
          (let* ((cell 0))
            (declare (fixnum cell))
            (with-imm-target (ppc::imm0) (header :u32)
              (ppc2-lwi seg header (logior (ash vsize ppc::num-subtag-bits) ppc::subtag-function))
              (! %new-alloc-misc-fixed dest header (ash vsize ppc::word-shift)))
            (! %closure-code% ppc::arg_x)
            (ppc2-store-immediate seg (ppc2-afunc-lfun-ref afunc) ppc::arg_y)
            (with-node-temps (ppc::arg_z) (t0 t1 t2 t3)
              (do* ((ccode ppc::arg_x nil)
                    (func ppc::arg_y nil))
                   ((null inherited-vars))
                (let* ((t0r (or ccode (if inherited-vars (var-to-reg (pop inherited-vars) t0))))
                       (t1r (or func (if inherited-vars (var-to-reg (pop inherited-vars) t1))))
                       (t2r (if inherited-vars (var-to-reg (pop inherited-vars) t2)))
                       (t3r (if inherited-vars (var-to-reg (pop inherited-vars) t3))))
                  (setq cell (set-some-cells dest cell t0r t1r t2r t3r)))))
            (ppc2-lwi seg ppc::arg_y (ash (ash 1 $lfbits-trampoline-bit) ppc::fixnumshift))
            (! misc-set-c-node ppc::rnil dest cell)
            (! misc-set-c-node ppc::arg_y dest (1+ cell))))
        dest))))
        
(defun ppc2-symbol-entry-locative (sym)
  (setq sym (require-type sym 'symbol))
  (when (eq sym '%call-next-method-with-args)
    (setf (afunc-bits *ppc2-cur-afunc*)
          (%ilogior (%ilsl $fbitnextmethargsp 1) (afunc-bits *ppc2-cur-afunc*))))
  (or (assq sym *ppc2-fcells*)
      (let ((new (list sym)))
        (push new *ppc2-fcells*)
        new)))

(defun ppc2-symbol-value-locative (sym)
  (setq sym (require-type sym 'symbol))
  (or (assq sym *ppc2-vcells*)
      (let ((new (list sym)))
        (push new *ppc2-vcells*)
        new)))

(defun ppc2-symbol-locative-p (imm)
  (and (consp imm)
       (or (memq imm *ppc2-vcells*)
           (memq imm *ppc2-fcells*))))




(defun ppc2-immediate-function-p (f)
  (setq f (ppc2-unwrapped-form f))
  (and (acode-p f)
       (or (eq (%car f) (%nx1-operator immediate))
           (eq (%car f) (%nx1-operator simple-function)))))

(defun ppc-constant-form-p (form)
  (setq form (nx-untyped-form form))
  (if form
    (or (nx-null form)
        (nx-t form)
        (and (consp form)
             (or (eq (acode-operator form) (%nx1-operator immediate))
                 (eq (acode-operator form) (%nx1-operator fixnum))
                 (eq (acode-operator form) (%nx1-operator simple-function)))))))

(defun ppc2-long-constant-p (form)
  (setq form (ppc2-unwrapped-form form))
  (or (ppc2-fixnum-form-p form)
      (and (acode-p form)
           (eq (acode-operator form) (%nx1-operator immediate))
           (setq form (%cadr form))
           (if (integerp form) 
             form
             (progn
               (if (symbolp form) (setq form (symbol-name form)))
               (if (and (stringp form) (eql (length form) 4))
	         (%stack-block ((buf 4))
		   (%put-ostype buf form)
		   (%get-unsigned-long buf))
                 (if (characterp form) (%char-code form))))))))


(defun ppc-side-effect-free-form-p (form)
  (when (consp (setq form (ppc2-unwrapped-form form)))
    (or (ppc-constant-form-p form)
        ;(eq (acode-operator form) (%nx1-operator bound-special-ref))
        (if (eq (acode-operator form) (%nx1-operator lexical-reference))
          (not (%ilogbitp $vbitsetq (nx-var-bits (%cadr form))))))))

(defun ppc2-formlist (seg stkargs &optional revregargs)
  (let* ((nregs (length revregargs))
         (n nregs))
    (declare (fixnum n))
    (dolist (arg stkargs)
      (let* ((reg (ppc2-one-untargeted-reg-form seg arg ppc::arg_z)))
        (ppc2-vpush-register-arg seg reg)
        (incf n)))
    (when revregargs
      (let* ((zform (%car revregargs))
             (yform (%cadr revregargs))
             (xform (%caddr revregargs)))
        (if (eq 3 nregs)
          (ppc2-three-targeted-reg-forms seg xform ppc::arg_x yform ppc::arg_y zform ppc::arg_z)
          (if (eq 2 nregs)
            (ppc2-two-targeted-reg-forms seg yform ppc::arg_y zform ppc::arg_z)
            (ppc2-one-targeted-reg-form seg zform ppc::arg_z)))))
    n))

(defun ppc2-arglist (seg args)
  (ppc2-formlist seg (car args) (cadr args)))



; if EA is a register-spec of the indicated class, return
; the register #.
(defun ppc2-ea-physical-reg (ea class)
  (declare (fixnum class))
  (and ea
       (ppc::register-spec-p ea)
       (= (ppc::hard-regspec-class ea) class)
       (ppc::hard-regspec-value ea)))

; treat form as a 32-bit immediate value and load it into immreg.
; This is the "lenient" version of 32-bit-ness; OSTYPEs and chars
; count, and we don't care about the integer's sign.

(defun ppc2-unboxed-integer-arg-to-reg (seg form immreg)
  (with-local-vinsn-macros (seg)
    (let* ((value (ppc2-long-constant-p form)))
      (if value
        (if (eql value 0)
          (ppc2-make-wired-lreg ppc::rzero :mode (ppc-gpr-mode-name-value :u32))
          (progn
            (unless (typep immreg 'lreg)
              (setq immreg (ppc2-make-unwired-lreg immreg :mode (ppc-gpr-mode-name-value :u32))))
            (ppc2-lwi seg immreg value)
            immreg))
        (progn 
          (ppc2-one-targeted-reg-form seg form ppc::arg_z)
          (! call-subprim .SPgetXlong)
          (ppc2-make-wired-lreg ppc::imm0 :mode (ppc-gpr-mode-name-value :u32))
          ;; copy it to immreg if immreg not imm0
          ;(when (not (eq (ppc2-ea-physical-reg immreg ppc::hard-reg-class-gpr) ppc::imm0))(cerror "OK" "OOPs"))
          (ppc2-copy-register seg (ppc2-ea-physical-reg immreg ppc::hard-reg-class-gpr) ppc::imm0)
          immreg)))))


(defun ppc2-macptr-arg-to-reg (seg form address-reg)  
  (ppc2-one-targeted-reg-form seg
                              form 
                              (ppc::set-regspec-mode address-reg (ppc-gpr-mode-name-value :address))))


(defun ppc2-one-lreg-form (seg form lreg)
  (let ((is-float (= (ppc::hard-regspec-class lreg) ppc::hard-reg-class-fpr)))
    (if is-float
      (ppc2-form-float seg lreg nil form)
      (ppc2-form seg lreg nil form))
    lreg))

(defun ppc2-one-targeted-reg-form (seg form reg)
  (ppc2-one-lreg-form seg form (if (typep reg 'lreg) reg (ppc2-make-wired-lreg reg))))

(defun ppc2-one-untargeted-lreg-form (seg form reg)
  (ppc2-one-lreg-form seg form (if (typep reg 'lreg) reg (ppc2-make-unwired-lreg reg))))

; Evaluated form into lisp register "suggested", unless it's already sitting somewhere else.
(defun ppc2-one-untargeted-reg-form (seg form suggested)
  ; If the suggested reg isn't a gpr, just evaluate the form to the register
  (let* ((gpr-p (= (ppc::hard-regspec-class suggested) ppc::hard-reg-class-gpr))
         (node-p (if gpr-p (= (ppc::get-regspec-mode suggested) ppc::hard-reg-class-gpr-mode-node))))
    (if node-p
      (let* ((reg (ppc2-ea-physical-reg (ppc2-lexical-reference-ea form) ppc::hard-reg-class-gpr)))
        (if reg
          reg
          (if (nx-null form)
            ppc::rnil
            (if (eql 0 (ppc2-fixnum-form-p form))
              ppc::rzero
              (if (and (acode-p form) 
                       (eq (acode-operator form) (%nx1-operator immediate)) 
                       (setq reg (ppc2-register-constant-p (cadr form))))
                reg
                
                (ppc2-one-untargeted-lreg-form seg form suggested))))))
      (ppc2-one-untargeted-lreg-form seg form suggested))))
             

(defun ppc2-push-register (seg areg)
  (let* ((a-float (= (ppc::hard-regspec-class areg) ppc::hard-reg-class-fpr))
         (a-double (if a-float (= (ppc::get-regspec-mode areg) ppc::hard-reg-class-fpr-mode-double)))
         (a-node (unless a-float (= (ppc::get-regspec-mode areg) ppc::hard-reg-class-gpr-mode-node)))
         vinsn)
    (with-local-vinsn-macros (seg)
      (if a-node
        (setq vinsn (ppc2-vpush-register seg areg :node-temp))
        (progn
          (setq vinsn
                (if a-float
                  (if a-double
                    (! temp-push-double-float areg)
                    (! temp-push-single-float areg))
                  (! temp-push-unboxed-word areg)))
          (ppc2-open-undo $undostkblk)))
      vinsn)))

(defun ppc2-pop-register (seg areg)
  (let* ((a-float (= (ppc::hard-regspec-class areg) ppc::hard-reg-class-fpr))
         (a-double (if a-float (= (ppc::get-regspec-mode areg) ppc::hard-reg-class-fpr-mode-double)))
         (a-node (unless a-float (= (ppc::get-regspec-mode areg) ppc::hard-reg-class-gpr-mode-node)))
         vinsn)
    (with-local-vinsn-macros (seg)
      (if a-node
        (setq vinsn (ppc2-vpop-register seg areg))
        (progn
          (setq vinsn
                (if a-float
                  (if a-double
                    (! temp-pop-double-float areg)
                    (! temp-pop-single-float areg))
                  (! temp-pop-unboxed-word areg)))
          (ppc2-close-undo)))
      vinsn)))

; we never leave the first form pushed (the 68K compiler had some subprims that
; would vpop the first argument out of line.)
(defun ppc2-two-targeted-reg-forms (seg aform areg bform breg)
  (let* ((avar (ppc2-lexical-reference-p aform))
         (atriv (ppc2-trivial-p bform))
         (aconst (and (not atriv) (or (ppc-side-effect-free-form-p aform)
                                      (if avar (ppc2-var-not-set-by-form-p avar bform)))))
         (apushed (not (or atriv aconst))))
    (progn
      (unless aconst
        (if atriv
          (ppc2-one-targeted-reg-form seg aform areg)
          (ppc2-push-register seg (ppc2-one-untargeted-reg-form seg aform areg))))
      (ppc2-one-targeted-reg-form seg bform breg)
      (if aconst
        (ppc2-one-targeted-reg-form seg aform areg)
        (if apushed
          (ppc2-pop-register seg areg))))
    (values areg breg)))


(defun ppc2-two-untargeted-reg-forms (seg aform areg bform breg)
  (let* ((avar (ppc2-lexical-reference-p aform))
         (adest areg)
         (bdest breg)
         (atriv (ppc2-trivial-p bform))
         (aconst (and (not atriv) (or (ppc-side-effect-free-form-p aform)
                                      (if avar (ppc2-var-not-set-by-form-p avar bform)))))
         (apushed (not (or atriv aconst))))
    (progn
      (unless aconst
        (if atriv
          (setq adest (ppc2-one-untargeted-reg-form seg aform areg))
          (ppc2-push-register seg (ppc2-one-untargeted-reg-form seg aform areg))))
      (setq bdest (ppc2-one-untargeted-reg-form seg bform breg))
      (if aconst
        (setq adest (ppc2-one-untargeted-reg-form seg aform areg))
        (if apushed
          (ppc2-pop-register seg areg))))
    (values adest bdest)))


(defun ppc2-three-targeted-reg-forms (seg aform areg bform breg cform creg)
  (let* ((atriv (or (null aform) 
                    (and (ppc2-trivial-p bform)
                         (ppc2-trivial-p cform))))
         (btriv (or (null bform)
                    (ppc2-trivial-p cform)))
         (aconst (and (not atriv) 
                      (or (ppc-side-effect-free-form-p aform)
                          (let ((avar (ppc2-lexical-reference-p aform)))
                            (and avar 
                                 (ppc2-var-not-set-by-form-p avar bform)
                                 (ppc2-var-not-set-by-form-p avar cform))))))
         (bconst (and (not btriv)
                      (or
                       (ppc-side-effect-free-form-p bform)
                       (let ((bvar (ppc2-lexical-reference-p bform)))
                         (and bvar (ppc2-var-not-set-by-form-p bvar cform)))))))
    (if (and aform (not aconst))
      (if atriv
        (ppc2-one-targeted-reg-form seg aform areg)
        (ppc2-push-register seg (ppc2-one-untargeted-reg-form seg aform areg))))
    (if (and bform (not bconst))
      (if btriv
        (ppc2-one-targeted-reg-form seg bform breg)
        (ppc2-push-register seg (ppc2-one-untargeted-reg-form seg bform breg))))
    (ppc2-one-targeted-reg-form seg cform creg)
    (unless btriv 
      (if bconst
        (ppc2-one-targeted-reg-form seg bform breg)
        (ppc2-pop-register seg breg)))
    (unless atriv
      (if aconst
        (ppc2-one-targeted-reg-form seg aform areg)
        (ppc2-pop-register seg areg)))
    (values areg breg creg)))

(defun ppc2-three-untargeted-reg-forms (seg aform areg bform breg cform creg)
  (let* ((atriv (or (null aform) 
                    (and (ppc2-trivial-p bform)
                         (ppc2-trivial-p cform))))
         (btriv (or (null bform)
                    (ppc2-trivial-p cform)))
         (aconst (and (not atriv) 
                      (or (ppc-side-effect-free-form-p aform)
                          (let ((avar (ppc2-lexical-reference-p aform)))
                            (and avar 
                                 (ppc2-var-not-set-by-form-p avar bform)
                                 (ppc2-var-not-set-by-form-p avar cform))))))
         (bconst (and (not btriv)
                      (or
                       (ppc-side-effect-free-form-p bform)
                       (let ((bvar (ppc2-lexical-reference-p bform)))
                         (and bvar (ppc2-var-not-set-by-form-p bvar cform))))))
         (adest areg)
         (bdest breg)
         (cdest creg))
    (if (and aform (not aconst))
      (if atriv
        (setq adest (ppc2-one-targeted-reg-form seg aform areg))
        (ppc2-push-register seg (ppc2-one-untargeted-reg-form seg aform areg))))
    (if (and bform (not bconst))
      (if btriv
        (setq bdest (ppc2-one-untargeted-reg-form seg bform breg))
        (ppc2-push-register seg (ppc2-one-untargeted-reg-form seg bform breg))))
    (setq cdest (ppc2-one-untargeted-reg-form seg cform creg))
    (unless btriv 
      (if bconst
        (setq bdest (ppc2-one-untargeted-reg-form seg bform breg))
        (ppc2-pop-register seg breg)))
    (unless atriv
      (if aconst
        (setq adest (ppc2-one-untargeted-reg-form seg aform areg))
        (ppc2-pop-register seg areg)))
    (values adest bdest cdest)))



(defun ppc2-lwi (seg reg value)
  (with-local-vinsn-macros (seg)
    (if (< value 0)
      (! lwi-s32 reg value)
      (! lwi reg value))))

(defun ppc2-multiple-value-body (seg form)
  (let* ((lab (ppc2-get-next-label))
         (*ppc2-vstack* *ppc2-vstack*)
         (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*)
         (old-stack (ppc2-encode-stack)))
    (with-local-vinsn-macros (seg)
      (ppc2-open-undo $undomvexpect)
      (ppc2-undo-body seg nil (%ilogior2 $ppc-mvpass-mask lab) form old-stack)
      (@ lab))))

(defun ppc2-afunc-lfun-ref (afunc)
  (or
   (afunc-lfun afunc)
   (progn (pushnew afunc (afunc-fwd-refs *ppc2-cur-afunc*) :test #'eq)
          afunc)))

(defun ppc2-augment-arglist (afunc arglist &optional (maxregs $numppcargregs))
  (let ((inherited-args (afunc-inherited-vars afunc)))
    (when inherited-args
      (let* ((current-afunc *ppc2-cur-afunc*)
             (stkargs (car arglist))
             (regargs (cadr arglist))
             (inhforms nil)
             (numregs (length regargs))
             (own-inhvars (afunc-inherited-vars current-afunc)))
        (dolist (var inherited-args)
          (let* ((root-var (nx-root-var var))
                 (other-guy 
                  (dolist (v own-inhvars #|(error "other guy not found")|# root-var)
                    (when (eq root-var (nx-root-var v)) (return v)))))
            (push (make-acode (%nx1-operator inherited-arg) other-guy) inhforms)))
        (dolist (form inhforms)
          (if (%i< numregs maxregs)
            (progn
              (setq regargs (nconc regargs (list form)))
              (setq numregs (%i+ numregs 1)))
            (push form stkargs)))
        (%rplaca (%cdr arglist) regargs) ; might have started out NIL.
        (%rplaca arglist stkargs)))) 
  arglist)




; There are other cases involving constants that are worth exploiting.
(defun ppc2-compare (seg vreg xfer i j cr-bit true-p)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((jconstant (ppc2-fixnum-form-p j))
           (js16 (typep jconstant '(signed-byte  #.(- 16 ppc::fixnumshift))))
           (iconstant (ppc2-fixnum-form-p i))
           (is16 (typep iconstant '(signed-byte  #.(- 16 ppc::fixnumshift))))                      
           (boolean (ppc2-crf-p vreg)))
      (if (and boolean (or js16 is16))
        (let* ((reg (ppc2-one-untargeted-reg-form seg (if js16 i j) ppc::arg_z)))
          (! compare-signed-s16const vreg reg (ash (if js16 jconstant iconstant) ppc::fixnumshift))
          (unless (or js16 (eq cr-bit ppc::ppc-eq-bit)) 
            (setq cr-bit (- 1 cr-bit)))
          (^ cr-bit true-p))
        (if (and (eq cr-bit ppc::ppc-eq-bit) 
                 (or js16 is16))
          (ppc2-test-reg-%izerop 
           seg 
           vreg 
           xfer 
           (ppc2-one-untargeted-reg-form 
            seg 
            (if js16 i j) 
            ppc::arg_z) 
           cr-bit 
           true-p 
           (ash (if js16 jconstant iconstant) ppc::fixnumshift))
          (multiple-value-bind (ireg jreg) (ppc2-two-untargeted-reg-forms seg i ppc::arg_y j ppc::arg_z)
            (ppc2-compare-registers seg vreg xfer ireg jreg cr-bit true-p)))))))

(defun ppc2-compare-registers (seg vreg xfer ireg jreg cr-bit true-p)
  (with-local-vinsn-macros (seg vreg xfer)
    (if vreg
      (regspec-crf-gpr-case 
       (vreg dest)
       (progn
         (! compare dest ireg jreg)
         (^ cr-bit true-p))
       (with-imm-temps () ((b31-reg :u32))
         (ecase cr-bit
           (#. ppc::ppc-eq-bit 
            (if true-p
              (! eq->bit31 b31-reg ireg jreg)
              (! ne->bit31 b31-reg ireg jreg)))
           (#. ppc::ppc-lt-bit
            (if true-p
              (! lt->bit31 b31-reg ireg jreg)
              (! ge->bit31 b31-reg ireg jreg)))
           (#. ppc::ppc-gt-bit
            (if true-p
              (! gt->bit31 b31-reg ireg jreg)
              (! le->bit31 b31-reg ireg jreg))))
         (ensuring-node-target (target dest)
           (! bit31->truth target b31-reg))
         (^)))
      (^))))

; Have to extract a bit out of the CR when a boolean result needed.
(defun ppc2-compare-double-float-registers (seg vreg xfer ireg jreg cr-bit true-p)
  (with-local-vinsn-macros (seg vreg xfer)
    (if vreg
      (regspec-crf-gpr-case 
       (vreg dest)
       (progn
         (! double-float-compare dest ireg jreg)
         (^ cr-bit true-p))
       (with-imm-temps () ((b31-reg :u32))
         (with-crf-temps () (flags)
           (! double-float-compare flags ireg jreg)
           (! crbit->bit31 b31-reg flags cr-bit))
         (unless true-p
           (! invert-bit31 b31-reg))
         (ensuring-node-target (target dest)
           (! bit31->truth target b31-reg))
         (^)))
      (^))))


(defun ppc2-immediate-form-p (form)
  (if (and (consp form)
           (or (eq (%car form) (%nx1-operator immediate))
               (eq (%car form) (%nx1-operator simple-function))))
    t))

(defun ppc2-test-%izerop (seg vreg xfer form cr-bit true-p)
  (ppc2-test-reg-%izerop seg vreg xfer (ppc2-one-untargeted-reg-form seg form ppc::arg_z) cr-bit true-p 0))

(defun ppc2-test-reg-%izerop (seg vreg xfer reg cr-bit true-p  zero)
  (declare (fixnum reg zero))
  (with-local-vinsn-macros (seg vreg xfer)
    (regspec-crf-gpr-case 
     (vreg dest)
     (progn
       (! compare-signed-s16const dest reg zero)
       (^ cr-bit true-p))
     (with-imm-temps (reg) (b31-reg scaled)
       (if (zerop zero)
         (setq scaled reg)
         (! subtract-constant scaled reg zero))
       (ecase cr-bit
         (#. ppc::ppc-eq-bit 
          (if true-p
            (! eq0->bit31 b31-reg scaled)
            (! ne0->bit31 b31-reg scaled)))
         (#. ppc::ppc-lt-bit
          (if true-p
            (! lt0->bit31 b31-reg scaled)
            (! ge0->bit31 b31-reg scaled)))
         (#. ppc::ppc-gt-bit
          (if true-p
            (! gt0->bit31 b31-reg scaled)
            (! le0->bit31 b31-reg scaled))))
          (ensuring-node-target (target dest)
            (! bit31->truth target b31-reg))
       (^)))))

(defun ppc2-lexical-reference-ea (form &optional (no-closed-p t))
  (let* ((addr nil))
    (when (acode-p (setq form (ppc2-unwrapped-form form)))
      (if (eq (acode-operator form) (%nx1-operator lexical-reference))
        (unless (and no-closed-p (ppc::ppc-addrspec-vcell-p (setq addr (var-ea (%cadr form)))))
          addr)))))


(defun ppc2-vpush-register (seg src &optional why info attr)
  (with-local-vinsn-macros (seg)
    (prog1
      (! vpush-register src)
      (ppc2-new-vstack-lcell (or why :node) 4 (or attr 0) info)
      (ppc2-adjust-vstack +4))))

(defun ppc2-vpush-register-arg (seg src)
  (ppc2-vpush-register seg src :outgoing-argument))


(defun ppc2-vpop-register (seg dest)
  (with-local-vinsn-macros (seg)
    (prog1
      (! vpop-register dest)
      (setq *ppc2-top-vstack-lcell* (lcell-parent *ppc2-top-vstack-lcell*))
      (ppc2-adjust-vstack -4))))

(defun ppc2-copy-register (seg dest src)
  (with-local-vinsn-macros (seg)
    (when dest
      (unless src (error "Bug: no source register to copy."))
      (let* ((dest-gpr (ppc2-ea-physical-reg dest ppc::hard-reg-class-gpr))
             (src-gpr (ppc2-ea-physical-reg src ppc::hard-reg-class-gpr))
             (dest-fpr (ppc2-ea-physical-reg dest ppc::hard-reg-class-fpr))
             (src-fpr (ppc2-ea-physical-reg src ppc::hard-reg-class-fpr))
             (src-mode (ppc::get-regspec-mode src))
             (dest-mode (ppc::get-regspec-mode dest))
             (dest-crf (ppc2-ea-physical-reg dest ppc::hard-reg-class-crf)))
        (if (and dest-gpr (or (eql dest-gpr ppc::rnil) (eql dest-gpr ppc::rzero)))
          (break "Bad destination register: ~s" dest-gpr))
        (if (and dest-crf src-gpr)
          ; "Copying" a GPR to a CR field means comparing it to rnil
          (! compare dest src ppc::rnil)
          (if (and dest-gpr src-gpr)
            (if (eql src-gpr ppc::rzero)        
              ; Rzero always contains 0, so we can
              ; save ourselves some trouble.
              ; This assumes that (LI dest-gpr 0) is easier
              ; on the register-renaming pipeline nonsense than
              ; (MR dest-gpr rzero) would be.
              (! lwi dest-gpr 0)
              (case dest-mode
                (#.ppc::hard-reg-class-gpr-mode-node      ; boxed result.
                 (case src-mode
                   (#.ppc::hard-reg-class-gpr-mode-node
                    (unless (eql  dest-gpr src-gpr)
                      (! copy-gpr dest src)))
                   (#.ppc::hard-reg-class-gpr-mode-u32
                    (! u32->integer dest src))
                   (#.ppc::hard-reg-class-gpr-mode-s32
                    (! s32->integer dest src))
                   (#.ppc::hard-reg-class-gpr-mode-u16
                    (! u16->fixnum dest src))
                   (#.ppc::hard-reg-class-gpr-mode-s16
                    (! s16->fixnum dest src))
                   (#.ppc::hard-reg-class-gpr-mode-u8
                    (! u8->fixnum dest src))
                   (#.ppc::hard-reg-class-gpr-mode-s8
                    (! s8->fixnum dest src))
                   (#.ppc::hard-reg-class-gpr-mode-address
                    (! macptr->heap dest src))))
                ((#.ppc::hard-reg-class-gpr-mode-u32
                  #.ppc::hard-reg-class-gpr-mode-address)
                 (case src-mode
                   (#.ppc::hard-reg-class-gpr-mode-node
                    (let* ((src-type (ppc::get-node-regspec-type-modes src)))
                      (declare (fixnum src-type))
                      (case dest-mode
                        (#.ppc::hard-reg-class-gpr-mode-u32
                         (! unbox-u32 dest src))
                        (#.ppc::hard-reg-class-gpr-mode-address
                         (unless (logbitp #.ppc::hard-reg-class-gpr-mode-address src-type)
                           (! trap-unless-typecode= src ppc::subtag-macptr))
                         (! deref-macptr dest src)))))
                   ((#.ppc::hard-reg-class-gpr-mode-u32
                     #.ppc::hard-reg-class-gpr-mode-s32
                     #.ppc::hard-reg-class-gpr-mode-address)
                    (unless (eql  dest-gpr src-gpr)
                      (! copy-gpr dest src)))
                   ((#.ppc::hard-reg-class-gpr-mode-u16
                     #.ppc::hard-reg-class-gpr-mode-s16)
                    (! u16->u32 dest src))
                   ((#.ppc::hard-reg-class-gpr-mode-u8
                     #.ppc::hard-reg-class-gpr-mode-s8)
                    (! u8->u32 dest src))))
                (#.ppc::hard-reg-class-gpr-mode-s32
                 (case src-mode
                   (#.ppc::hard-reg-class-gpr-mode-node
                    (! unbox-s32 dest src))
                   ((#.ppc::hard-reg-class-gpr-mode-u32
                     #.ppc::hard-reg-class-gpr-mode-s32
                     #.ppc::hard-reg-class-gpr-mode-address)
                    (unless (eql  dest-gpr src-gpr)
                      (! copy-gpr dest src)))
                   (#.ppc::hard-reg-class-gpr-mode-u16
                    (! u16->u32 dest src))                 
                   (#.ppc::hard-reg-class-gpr-mode-s16
                    (! s16->s32 dest src))
                   (#.ppc::hard-reg-class-gpr-mode-u8
                    (! u8->u32 dest src))
                   (#.ppc::hard-reg-class-gpr-mode-s8
                    (! s8->s32 dest src))))
                (#.ppc::hard-reg-class-gpr-mode-u16
                 (case src-mode
                   (#.ppc::hard-reg-class-gpr-mode-node
                    (! unbox-u16 dest src))
                   ((#.ppc::hard-reg-class-gpr-mode-u8
                     #.ppc::hard-reg-class-gpr-mode-s8)
                    (! u8->u32 dest src))
                   (t
                    (unless (eql dest-gpr src-gpr)
                      (! copy-gpr dest src)))))
                (#.ppc::hard-reg-class-gpr-mode-s16
                 (case src-mode
                   (#.ppc::hard-reg-class-gpr-mode-node
                    (! unbox-s16 dest src))
                   (#.ppc::hard-reg-class-gpr-mode-s8
                    (! s8->s32 dest src))
                   (#.ppc::hard-reg-class-gpr-mode-u8
                    (! u8->u32 dest src))
                   (t
                    (unless (eql dest-gpr src-gpr)
                      (! copy-gpr dest src)))))
                (#.ppc::hard-reg-class-gpr-mode-u8
                 (case src-mode
                   (#.ppc::hard-reg-class-gpr-mode-node
                    (! unbox-u8 dest src))
                   (t
                    (unless (eql dest-gpr src-gpr)
                      (! copy-gpr dest src)))))
                (#.ppc::hard-reg-class-gpr-mode-s8
                 (case src-mode
                   (#.ppc::hard-reg-class-gpr-mode-node
                    (! unbox-s8 dest src))
                   (t
                    (unless (eql dest-gpr src-gpr)
                      (! copy-gpr dest src)))))))
            (if src-gpr
              (if dest-fpr
                (progn
                  (case src-mode
                    (#.ppc::hard-reg-class-gpr-mode-node
                     (case dest-mode
                       (#.ppc::hard-reg-class-fpr-mode-double
                        ; if we knew the source was double, we set a  bit in the dest reg spec (weird huh)
                        (unless (logbitp ppc::hard-reg-class-fpr-type-double 
                                         (ppc::get-node-regspec-type-modes dest))
                          (! trap-unless-typecode= src ppc::subtag-double-float))
                        (! get-double dest src))
                       (#.ppc::hard-reg-class-fpr-mode-single
                        (unless (logbitp ppc::hard-reg-class-fpr-type-single 
                                         (ppc::get-node-regspec-type-modes dest))
                          (! trap-unless-typecode= src ppc::subtag-single-float))                        
                        (! get-single dest src)))))))
              (if dest-gpr
                (case dest-mode
                  (#.ppc::hard-reg-class-gpr-mode-node
                   (case src-mode
                     (#.ppc::hard-reg-class-fpr-mode-double
                      (! double->heap dest src))
                     (#.ppc::hard-reg-class-fpr-mode-single
                      (! single->heap dest src)))))
                (if (and src-fpr dest-fpr)
                  (unless (eql dest-fpr src-fpr)
                    (! copy-fpr dest src)))))))))))
  
(defun ppc2-unreachable-store (&optional vreg)
  ; I don't think that anything needs to be done here,
  ; but leave this guy around until we're sure.
  ; (PPC2-VPUSH-REGISTER will always vpush something, even
  ; if code to -load- that "something" never gets generated.
  ; If I'm right about this, that means that the compile-time
  ; stack-discipline problem that this is supposed to deal
  ; with can't happen.)
  (declare (ignore vreg))
  nil)

; bind vars to initforms, as per let*, &aux.
(defun ppc2-seq-bind (seg vars initforms)
  (dolist (var vars)
    (ppc2-seq-bind-var seg var (pop initforms))))

(defun ppc2-dynamic-extent-form (seg curstack val)
  (when (acode-p val)
    (with-local-vinsn-macros (seg)
      (let* ((op (acode-operator val)))
        (cond ((eq op (%nx1-operator list))
               (let* ((*ppc2-vstack* *ppc2-vstack*)
                      (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*))
                 (ppc2-set-nargs seg (ppc2-formlist seg (%cadr val) nil))
                 (ppc2-open-undo $undostkblk curstack)
                 (! call-subprim .SPstkconslist))
               (setq val ppc::arg_z))
              ((eq op (%nx1-operator list*))
               (let* ((arglist (%cadr val)))                   
                 (let* ((*ppc2-vstack* *ppc2-vstack*)
                        (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*))
                   (ppc2-arglist seg arglist))
                 (when (car arglist)
                   (ppc2-set-nargs seg (length (%car arglist)))
                   (! call-subprim .SPstkconslist-star)
                   (ppc2-open-undo $undostkblk curstack))
                 (setq val ppc::arg_z)))
              ((eq op (%nx1-operator multiple-value-list))
               (ppc2-multiple-value-body seg (%cadr val))
               (ppc2-open-undo $undostkblk curstack)
               (! call-subprim .SPstkconslist)
               (setq val ppc::arg_z))
              ((eq op (%nx1-operator cons))
               (ppc2-two-targeted-reg-forms seg (%cadr val) ppc::arg_y (%caddr val) ppc::arg_z)
               (ppc2-open-undo $undostkblk )
               (! make-tsp-cons ppc::arg_z ppc::arg_y ppc::arg_z) 
               (setq val ppc::arg_z))
              ((eq op (%nx1-operator %consmacptr%))
               (with-imm-target () (address :address)
                 (ppc2-one-targeted-reg-form seg val address)
                 (with-node-temps () (node)
                   (! macptr->stack node address)
                   (ppc2-open-undo $undostkblk)
                   (setq val node))))
              ((eq op (%nx1-operator %new-ptr))
               (let ((clear-form (caddr val)))
                 (if (nx-constant-form-p clear-form)
                   (progn 
                     (ppc2-one-targeted-reg-form seg (%cadr val) ppc::arg_z)
                     (ppc2-open-undo $undostkblk)
                     (if (nx-null clear-form)
                       (! call-subprim .SPmakestackblock)
                       (! call-subprim .SPmakestackblock0)))
                   (with-crf-temps () (crf)
                     (let ((stack-block-0-label (ppc2-get-next-label))
                           (done-label (ppc2-get-next-label)))
                       (ppc2-two-targeted-reg-forms seg (%cadr val) ppc::arg_z clear-form ppc::arg_y)
                       (! compare crf ppc::arg_y ppc::rnil)
                       (! bne crf (aref *ppc2-labels* stack-block-0-label))
                       (! call-subprim .SPmakestackblock)
                       (-> done-label)
                       (@ stack-block-0-label)
                       (! call-subprim .SPmakestackblock0)
                       (@ done-label)))))
               (setq val ppc::arg_z))
              ((eq op (%nx1-operator make-list))
               (ppc2-two-targeted-reg-forms seg (%cadr val) ppc::arg_y (%caddr val) ppc::arg_z)
               (ppc2-open-undo $undostkblk curstack)
               (! call-subprim .SPmakestacklist)
               (setq val ppc::arg_z))       
              ((eq (%car val) (%nx1-operator vector))
               (let* ((*ppc2-vstack* *ppc2-vstack*)
                      (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*))
                 (ppc2-set-nargs seg (ppc2-formlist seg (%cadr val) nil))
                 (! call-subprim .SPmkstackv))
               (ppc2-open-undo $undostkblk)
               (setq val ppc::arg_z))
              ((eq op (%nx1-operator %ppc-gvector))
               (let* ((*ppc2-vstack* *ppc2-vstack*)
                      (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*)
                      (arglist (%cadr val)))
                 (ppc2-set-nargs seg (ppc2-formlist seg (append (car arglist) (reverse (cadr arglist))) nil))
                 (! call-subprim .SPstkgvector))
               (ppc2-open-undo $undostkblk)
               (setq val ppc::arg_z)) 
              ((eq op (%nx1-operator closed-function)) 
               (setq val (ppc2-make-closure seg (cadr val) t))) ; can't error
              ((eq op (%nx1-operator %make-uvector))
               (destructuring-bind (element-count subtag &optional (init 0 init-p)) (%cdr val)
                 (if init-p
                   (progn
                     (ppc2-three-targeted-reg-forms seg element-count ppc::arg_x subtag ppc::arg_y init ppc::arg_z)
                     (! call-subprim .SPstack-misc-alloc-init))
                   (progn
                     (ppc2-two-targeted-reg-forms seg element-count ppc::arg_y subtag ppc::arg_z)
                     (! call-subprim .SPstack-misc-alloc)))
                 (ppc2-open-undo $undostkblk)
                 (setq val ppc::arg_z)))))))
  val)

#|
(defun ppc2-dynamic-extent-double-float (seg curstack val)
  (with-local-vinsn-macros (seg)
    (ppc2-one-targeted-reg-form seg val ppc::arg_z)
    (ppc2-open-undo $undostkblk curstack)
    (! make-tsp-dfloat ppc::arg_z  ppc::arg_z)
    ppc::arg_z))

(defun ppc2-dynamic-extent-short-float (seg curstack val)
  (with-local-vinsn-macros (seg)
    (ppc2-one-targeted-reg-form seg val ppc::arg_z)
    (ppc2-open-undo $undostkblk curstack)
    (! make-tsp-sfloat ppc::arg_z  ppc::arg_z)
    ppc::arg_z))
|#

(defun ppc2-dynamic-extent-double-float (seg curstack val)
  (with-local-vinsn-macros (seg)
    (ppc2-one-targeted-reg-form seg val (ppc::make-hard-fp-reg ppc::fp0 ppc::hard-reg-class-fpr-mode-double))
    (ppc2-open-undo $undostkblk curstack)
    (! make-tsp-dfloat-from-fpr ppc::arg_z  ppc::fp0)
    ppc::arg_z))

(defun ppc2-copy-double-float (seg curstack val)
  (declare (ignore curstack))
  (with-local-vinsn-macros (seg)
    (ppc2-one-targeted-reg-form seg val (ppc::make-hard-fp-reg ppc::fp0 ppc::hard-reg-class-fpr-mode-double))
    (! double->heap ppc::arg_z ppc::fp0)
    ppc::arg_z))

(defun ppc2-copy-short-float (seg curstack val)
  (declare (ignore curstack))
  (with-local-vinsn-macros (seg)
    (ppc2-one-targeted-reg-form seg val (ppc::make-hard-fp-reg ppc::fp0 ppc::hard-reg-class-fpr-mode-single))
    (! single->heap ppc::arg_z ppc::fp0)
    ppc::arg_z))

(defun ppc2-dynamic-extent-short-float (seg curstack val)
  (with-local-vinsn-macros (seg)
    (ppc2-one-targeted-reg-form seg val (ppc::make-hard-fp-reg ppc::fp0 ppc::hard-reg-class-fpr-mode-single))
    (ppc2-open-undo $undostkblk curstack)
    (! make-tsp-sfloat-from-fpr ppc::arg_z  ppc::fp0)
    ppc::arg_z))
  

(defun ppc2-addrspec-to-reg (seg addrspec reg)
  (if (ppc::memory-spec-p addrspec)
    (ppc2-stack-to-register seg addrspec reg)
    (ppc2-copy-register seg reg addrspec)))
  
(defun ppc2-seq-bind-var (seg var val)
  (with-local-vinsn-macros (seg)
    (let* ((sym (var-name var))
           (bits (nx-var-bits var))
           (closed-p (and (%ilogbitp $vbitclosed bits)
                          (%ilogbitp $vbitsetq bits)))
           (curstack (ppc2-encode-stack))
           (make-vcell (and closed-p (eq bits (var-bits var))))
           (closed-downward (and closed-p (%ilogbitp $vbitcloseddownward bits))))
      (unless (fixnump val)
        (setq val (nx-untyped-form val))        
        (when (and (%ilogbitp $vbitdynamicextent bits) (acode-p val))
          (if (eq (var-inittype var) 'double-float)
            (setq val (ppc2-dynamic-extent-double-float seg curstack val))
            (if (memq (var-inittype var) '(single-float short-float))
              (setq val (ppc2-dynamic-extent-short-float seg curstack val))
              (setq val (ppc2-dynamic-extent-form seg curstack val)))))
        (when (and (%ilogbitp $vbitdestructive bits)(not (%ilogbitp $vbitdynamicextent bits)) (acode-p val))
          ;(print (list 'cow sym bits))
          (if (eq (var-inittype var) 'double-float)
            (setq val (ppc2-copy-double-float seg curstack val))
            (if (memq (var-inittype var) '(short-float single-float))
              (setq val (ppc2-copy-short-float seg curstack val))))))
      (if (%ilogbitp $vbitspecial bits)
        (ppc2-dbind seg val sym)
        (let ((puntval nil))
          (flet ((ppc2-puntable-binding-p (var initform)
                   ; The value returned is acode.
                   (let* ((bits (nx-var-bits var)))
                     (if (%ilogbitp $vbitpuntable bits)
                       (nx-untyped-form initform)))))
            (declare (inline ppc2-puntable-binding-p))
            (if (and (not (ppc2-load-ea-p val))
                     (setq puntval (ppc2-puntable-binding-p var val)))
              (progn
                (nx-set-var-bits var (%ilogior (%ilsl $vbitpunted 1) bits))
                (ppc2-set-var-ea seg var puntval))
              (progn
                (let* ((vloc *ppc2-vstack*)
                       (reg (ppc2-assign-register-var var)))
                  (if (ppc2-load-ea-p val)
                    (if reg 
                      (ppc2-addrspec-to-reg seg val reg)
                      (if (ppc::memory-spec-p val)
                        (with-node-temps () (temp)
                          (ppc2-addrspec-to-reg seg val temp)
                          (ppc2-vpush-register seg temp :node var bits))
                        (ppc2-vpush-register seg val :node var bits)))
                    (if reg
                      (ppc2-one-targeted-reg-form seg val reg)
                      (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg val ppc::arg_z) :node var bits)))
                  (ppc2-set-var-ea seg var (or reg (ppc2-vloc-ea vloc closed-p)))
                  (if reg
                    (ppc2-note-var-cell var reg)
                    (ppc2-note-top-cell var))
                  (when make-vcell
                    (with-node-temps () (temp)
                        (ppc2-stack-to-register seg vloc temp)
                        (if closed-downward
                          (progn
                            (! make-tsp-vcell temp temp)
                            (ppc2-open-undo $undostkblk))
                          (! make-vcell temp temp))
                        (ppc2-register-to-stack seg temp vloc))))))))))))

(defun ppc2-punted-var-p (var)
  (let ((bits (nx-var-bits var)))
    (and (%ilogbitp $vbitpunted bits)
         (not (%ilogbitp $vbitspecial bits)))))

; Never make a vcell if this is an inherited var.
; If the var's inherited, its bits won't be a fixnum (and will
; therefore be different from what NX-VAR-BITS returns.)
(defun ppc2-bind-var (seg var vloc &optional lcell &aux 
                          (bits (nx-var-bits var)) 
                          (closed-p (and (%ilogbitp $vbitclosed bits) (%ilogbitp $vbitsetq bits)))
                          (closed-downward (if closed-p (%ilogbitp $vbitcloseddownward bits)))
                          (make-vcell (and closed-p (eq bits (var-bits var))))
                          (addr (ppc2-vloc-ea vloc)))
  (with-local-vinsn-macros (seg)
    (if (%ilogbitp $vbitspecial bits)
      (progn
        (ppc2-dbind seg addr (var-name var))
        t)
      (progn
        (when (%ilogbitp $vbitpunted bits)
          (error "bind-var: var ~s was punted" var))
        (when make-vcell
          (with-node-temps () (temp)
            (ppc2-stack-to-register seg vloc temp)
            (if closed-downward
              (progn
                (! make-tsp-vcell temp temp)
                (ppc2-open-undo $undostkblk))
              (! make-vcell temp temp))
            (ppc2-register-to-stack seg temp vloc)))
        (when lcell
          (setf (lcell-kind lcell) :node
                (lcell-attributes lcell) bits
                (lcell-info lcell) var)
          (ppc2-note-var-cell var lcell))          
        (ppc2-set-var-ea seg var (ppc2-vloc-ea vloc closed-p))        
        closed-downward))))

(defun ppc2-set-var-ea (seg var ea)
  (setf (var-ea var) ea)
  (when (and (typep ea 'fixnum) *ppc2-record-symbols*)
    (let* ((start (ppc2-emit-note seg :begin-variable-scope)))
      (push (list var (var-name var) start (close-vinsn-note start))
          *ppc2-recorded-symbols*)))
  ea)

(defun ppc2-close-var (seg var)
  (let ((bits (nx-var-bits var)))
    (when (and *ppc2-record-symbols* 
         (%izerop (%ilogand (%ilogior #+ignore (ash -1 $vbitspecial) #-ignore (%ilsl $vbitspecial 1)
                                      (%ilsl $vbitpunted 1)) bits)))
      (let ((endnote (%car (%cdddr (assq var *ppc2-recorded-symbols*)))))
        (unless endnote (error "ppc2-close-var ?"))
        (setf (vinsn-note-class endnote) :end-variable-scope)
        (append-dll-node (vinsn-note-label endnote) seg)))))

(defun ppc2-load-ea-p (ea)
  (or (typep ea 'fixnum)
      (typep ea 'lreg)
      (typep ea 'lcell)))

(defun ppc2-dbind (seg value sym)
  (with-local-vinsn-macros (seg)
    (let* ((ea-p (ppc2-load-ea-p value))
           (nil-p (unless ea-p (eq (setq value (nx-untyped-form value)) *nx-nil*)))
           (self-p (unless ea-p (and (or
                                      (eq (acode-operator value) (%nx1-operator bound-special-ref))
                                      (eq (acode-operator value) (%nx1-operator special-ref)))
                                     (eq (cadr value) sym)))))
      (if (or nil-p self-p)
        (progn
          (ppc2-store-immediate seg (ppc2-symbol-value-locative sym) ppc::arg_z)
          (if nil-p
            (! call-subprim .SPbind-nil)
            (if (or *ppc2-reckless* (eq (acode-operator value) (%nx1-operator special-ref)))
              (! call-subprim .SPbind-self)
              (! call-subprim .SPbind-self-boundp-check))))
        (progn
          (if ea-p 
            (ppc2-store-ea seg value ppc::arg_z)
            (ppc2-one-targeted-reg-form seg value ppc::arg_z))
          (ppc2-store-immediate seg (ppc2-symbol-value-locative sym) ppc::arg_y)
          (! call-subprim .SPbind)))
      (ppc2-open-undo $undospecial)
      (ppc2-new-vstack-lcell :special 12 (ash 1 $vbitspecial) sym)
      (ppc2-adjust-vstack 12))))

; Store the contents of EA - which denotes either a vframe location
; or a hard register - in reg.

(defun ppc2-store-ea (seg ea reg)
  (if (typep ea 'fixnum)
    (if (ppc::memory-spec-p ea)
      (ppc2-stack-to-register seg ea reg)
      (ppc2-copy-register seg reg ea))
    (if (typep ea 'lreg)
      (ppc2-copy-register seg reg ea)
      (if (typep ea 'lcell)
        (ppc2-lcell-to-register seg ea reg)))))


      

; Callers should really be sure that this is what they want to use.
(defun ppc2-absolute-long (seg vreg xfer value)
  (with-local-vinsn-macros (seg vreg xfer)
    (when vreg
      (ppc2-lwi seg vreg value))
    (^)))



(defun ppc2-store-macptr (seg vreg address-reg)
  (with-local-vinsn-macros (seg vreg)
    (when (ppc2-for-value-p vreg)
      (if (logbitp vreg ppc-imm-regs)
        (<- address-reg)
        (! macptr->heap vreg address-reg)))))

(defun ppc2-store-signed-longword (seg vreg imm-reg)
  (with-local-vinsn-macros (seg vreg)
    (when (ppc2-for-value-p vreg)
      (if (logbitp vreg ppc-imm-regs)
        (<- imm-reg)
        (! s32->integer vreg imm-reg)))))

(defun ppc2-store-signed-halfword (seg vreg imm-reg)
  (with-local-vinsn-macros (seg vreg)
    (when (ppc2-for-value-p vreg)
      (if (logbitp vreg ppc-imm-regs)
        (<- imm-reg)
        (! s16->fixnum vreg imm-reg)))))


(defun ppc2-store-unsigned-halfword (seg vreg imm-reg)
  (with-local-vinsn-macros (seg vreg)
    (when (ppc2-for-value-p vreg)
      (if (logbitp vreg ppc-imm-regs)
        (<- imm-reg)
        (! u16->fixnum vreg imm-reg)))))


(defparameter *emulator-register-numbers*
  #(0 1 2 3 8 9 10 11 4 5 6 7 12 13 14))

(defun ppc2-encode-register-trap-procinfo (resultbits forms)
  (flet ((register-routine-parameter (whichparam whichreg size)
           (ash (logior (ash size #$kRegisterParameterSizePhase)
                        (ash (svref *emulator-register-numbers* whichreg) #$kRegisterParameterWhichPhase))
                (+ #$kRegisterParameterPhase (* whichparam #$kRegisterParameterWidth))))) 
    
    (let* ((info (logior #$kregisterbased (register-routine-parameter 0 #|$d1|# 1 #$kFourByteCode))))
      (do* ((forms forms (cdr forms))
            (form (car forms) (car forms))
            (param 1 (1+ param)))
           ((null forms))
        (declare (fixnum param))
        (setq info (logior info (register-routine-parameter param (car form) #$kFourByteCode))))
      (if (logbitp 4 resultbits)
        (dpb 
         (if (logbitp 6 resultbits) #$kTwoByteCode #$kFourByteCode)
         (byte #$kResultSizeWidth #$kResultSizePhase)
         (dpb (svref *emulator-register-numbers* (logand #x0f resultbits))
              (byte #$kRegisterResultLocationWidth #$kRegisterResultLocationPhase)
              info))
        info))))

; If "value-first-p" is true and both "offset" and "val" need to be 
; evaluated, evaluate "val" before evaluating "offset".
(defun ppc2-%immediate-set-ptr (seg vreg xfer deref ptr offset val value-first-p)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((intval (ppc2-absolute-ptr-p val))
           (offval (ppc2-fixnum-form-p offset))
           (absptr (and offval (ppc2-absolute-ptr-p ptr)))
           (for-value (ppc2-for-value-p vreg)))
      (flet ((address-and-node-regs ()
               (if for-value
                 (progn
                   (ppc2-one-targeted-reg-form seg val ppc::arg_z)
                   (if (eq intval 0)
                     (values ppc::rzero ppc::arg_z)
                     (progn
                       (if intval
                         (ppc2-lwi seg ppc::imm0 intval)                         
                         (! deref-macptr ppc::imm0 ppc::arg_z))
                       (values ppc::imm0 ppc::arg_z))))
                 (if (eq intval 0)
                   (values ppc::rzero nil)
                   (values (ppc2-macptr-arg-to-reg seg val ppc::imm0) nil)))))
        (if (and absptr offval)
          (setq absptr (+ absptr offval) offval 0)
          (setq absptr nil))
        (and offval (%i> (integer-length offval) 15) (setq offval nil))
        (and absptr (%i> (integer-length absptr) 15) (setq absptr nil))
        (if absptr
          (multiple-value-bind (address node) (address-and-node-regs)
            (! mem-set-c-fullword address ppc::rzero absptr)
            (if for-value
              (<- node)))
          ; No absolute ptr (which is presumably a rare case anyway.)
          (if offval
            ; Easier: need one less register than in the general case.
            (with-imm-target () (ptr-reg :address)
              (ppc2-one-targeted-reg-form seg ptr ptr-reg)
              (if intval
                (with-imm-target (ptr-reg) (val-target :address)                    
                  (if (eql intval 0)
                    (setq val-target ppc::rzero)
                    (ppc2-lwi seg val-target intval))
                  (if deref
                    (! mem-ref-c-fullword ptr-reg ptr-reg 0))
                  (! mem-set-c-fullword val-target ptr-reg offval)
                  (if for-value
                    (<- (ppc::set-regspec-mode val-target (ppc-gpr-mode-name-value :address)))))
                (progn
                  (! temp-push-unboxed-word ptr-reg)
                  (ppc2-open-undo $undostkblk)
                  (multiple-value-bind (address node) (address-and-node-regs)
                    (with-imm-target (address) (ptr-reg :address)
                      (! temp-pop-unboxed-word ptr-reg)
                      (ppc2-close-undo)
                      (if deref
                        (! mem-ref-c-fullword ptr-reg ptr-reg 0))
                      (! mem-set-c-fullword address ptr-reg offval)
                      (if for-value
                        (<- node)))))))
            ;; No (16-bit) constant offset.  Might still have a 32-bit constant offset;
            ;; might have a constant value.  Might not.  Might not.
            ;; Easiest to special-case the constant-value case first ...
            (let* ((xptr-reg nil)
                   (xoff-reg nil)
                   (xval-reg nil)
                   (node-arg_z nil)
                   (constant-offset (ppc2-fixnum-form-p offset)))
              (if intval
                (if constant-offset
                  (with-imm-target () (ptr-reg :address)
                    (ppc2-one-targeted-reg-form seg ptr ptr-reg)
                    (with-imm-target (ptr-reg) (off-reg :s32)
                      (ppc2-lwi seg off-reg constant-offset)
                      (with-imm-target (ptr-reg off-reg) (val-reg :address)
                        (if (eql intval 0)
                          (setq val-reg ppc::rzero)
                          (ppc2-lwi seg val-reg intval))
                        (setq xptr-reg ptr-reg
                              xoff-reg off-reg
                              xval-reg val-reg))))
                  ; Offset's non-constant.  Temp-push the pointer, evaluate
                  ; and unbox the offset, load the value, pop the pointer.
                  (progn
                    (with-imm-target () (ptr-reg :address)
                      (ppc2-one-targeted-reg-form seg ptr ptr-reg)
                      (! temp-push-unboxed-word ptr-reg)
                      (ppc2-open-undo $undostkblk))
                    (with-imm-target () (off-reg :s32)
                      (! fixnum->s32 off-reg (ppc2-one-targeted-reg-form seg offset ppc::arg_z))
                      (with-imm-target (off-reg) (val-reg :s32)
                        (if (eql intval 0)
                          (setq val-reg ppc::rzero)
                          (ppc2-lwi seg val-reg intval))
                        (with-imm-target (off-reg val-reg) (ptr-reg :address)
                          (! temp-pop-unboxed-word ptr-reg)
                          (ppc2-close-undo)
                          (setq xptr-reg ptr-reg
                                xoff-reg off-reg
                                xval-reg val-reg))))))
                ;; No intval; maybe constant-offset.
                (with-imm-target () (ptr-reg :address)
                  (ppc2-one-targeted-reg-form seg ptr ptr-reg)
                  (! temp-push-unboxed-word ptr-reg)
                  (ppc2-open-undo $undostkblk)
                  (if (or constant-offset (not value-first-p))
                    (progn
                      (if (not constant-offset)
                        (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg offset ppc::arg_z)))
                      (multiple-value-bind (address node) (address-and-node-regs)
                        (with-imm-target (address) (off-reg :s32)
                          (if constant-offset
                            (ppc2-lwi seg off-reg constant-offset)
                            (with-node-temps (ppc::arg_z) (temp)
                              (ppc2-vpop-register seg temp)
                              (! fixnum->s32 off-reg temp)))
                          (with-imm-target (ppc::imm0 off-reg) (ptr-reg :address)
                            (! temp-pop-unboxed-word ptr-reg)
                            (ppc2-close-undo)
                            (setq xptr-reg ptr-reg
                                  xoff-reg off-reg
                                  xval-reg address
                                  node-arg_z node)))))
                    (progn
                      ; The "for-value" case can't happen here.
                      (with-imm-target (ptr-reg) (address :address)
                        (ppc2-two-targeted-reg-forms seg val address offset ppc::arg_z)
                        (with-imm-target (address ptr-reg) (off-reg :s32)
                          (! fixnum->s32 off-reg ppc::arg_z)
                          (! temp-pop-unboxed-word ptr-reg)
                          (ppc2-close-undo)
                          (setq xptr-reg ptr-reg
                                  xoff-reg off-reg
                                  xval-reg address
                                  node-arg_z nil)))))))
              (if deref
                (! mem-ref-c-fullword xptr-reg xptr-reg 0))
              (! mem-set-fullword xval-reg xptr-reg xoff-reg)
              (when for-value
                (if node-arg_z
                  (<- node-arg_z)
                  (<- (ppc::set-regspec-mode 
                       xval-reg
                       (ppc-gpr-mode-name-value :address))))))))
        (^)))))
  
(defun ppc2-memory-store-displaced (seg valreg basereg displacement size deref)
  (with-local-vinsn-macros (seg)
    (if deref
      (! mem-ref-c-fullword basereg basereg 0))
    (case size
      (4 (! mem-set-c-fullword valreg basereg displacement))
      (2 (! mem-set-c-halfword valreg basereg displacement))
      (1 (! mem-set-c-byte valreg basereg displacement)))))

(defun ppc2-memory-store-indexed (seg valreg basereg idxreg size deref)
  (with-local-vinsn-macros (seg)
    (if deref
      (! mem-ref-c-fullword basereg basereg 0))
    (case size
      (4 (! mem-set-fullword valreg basereg idxreg))
      (2 (! mem-set-halfword valreg basereg idxreg))
      (1 (! mem-set-byte valreg basereg idxreg)))))
      
(defun ppc2-%immediate-store  (seg vreg xfer bits ptr offset val value-first-p)
  (with-local-vinsn-macros (seg vreg xfer)
    (if (eql 0 (%ilogand #xf bits))
      (ppc2-%immediate-set-ptr seg vreg xfer (%ilogbitp 4 bits) ptr offset val value-first-p)
      (let* ((deref (%ilogbitp 4 bits))
             (size
              (if (eq (setq bits (%ilogand2 #xf bits)) 3) 
                1
                (if (eq bits 2) 
                  2 
                  4)))
             (long-p (eq bits 1))
             (intval (if long-p (ppc2-long-constant-p val) (ppc2-fixnum-form-p val)))
             (offval (ppc2-fixnum-form-p offset))
             (absptr (unless deref (and offval (ppc2-absolute-ptr-p ptr))))
             (for-value (ppc2-for-value-p vreg)))
        (declare (fixnum size))
        (flet ((val-to-argz-and-imm0 ()
                 (ppc2-one-targeted-reg-form seg val ppc::arg_z)
                 (if (eq size 4)
                   (! call-subprim .SPgetXlong)
                   (! fixnum->s32 ppc::imm0 ppc::arg_z))))
          (if (and absptr offval)
            (setq absptr (+ absptr offval) offval 0)
            (setq absptr nil))
          (and offval (%i> (integer-length offval) 15) (setq offval nil))
          (and absptr (%i> (integer-length absptr) 15) (setq absptr nil))
          (if absptr
            (if intval
              (with-imm-target () (val-target :s32)
                (if (eql intval 0)
                  (setq val-target ppc::rzero)
                  (ppc2-lwi seg val-target intval))
                (ppc2-memory-store-displaced seg val-target ppc::rzero absptr size nil)
                (if for-value
                  (<- (ppc::set-regspec-mode 
                       val-target 
                       (ppc-gpr-mode-name-value
                        (if (eq size 4)
                          :s32
                          (if (eq size 2)
                            :s16
                            :s8)))))))
              (progn
                (val-to-argz-and-imm0)
                (ppc2-memory-store-displaced seg ppc::imm0 ppc::rzero absptr size nil)
                (<- ppc::arg_z)))
            ; No absolute ptr (which is presumably a rare case anyway.)
            (if offval
              ; Easier: need one less register than in the general case.
              (with-imm-target () (ptr-reg :address)
                (ppc2-one-targeted-reg-form seg ptr ptr-reg)
                (if intval
                  (with-imm-target (ptr-reg) (val-target :s32)                    
                    (if (eql intval 0)
                      (setq val-target ppc::rzero)
                      (ppc2-lwi seg val-target intval))
                    (ppc2-memory-store-displaced seg val-target ptr-reg offval size deref)
                    (if for-value
                      (<- (ppc::set-regspec-mode 
                           val-target 
                           (ppc-gpr-mode-name-value
                            (if (eq size 4)
                              :s32
                              (if (eq size 2)
                                :s16
                                :s8)))))))
                  (progn
                    (! temp-push-unboxed-word ptr-reg)
                    (ppc2-open-undo $undostkblk)
                    (val-to-argz-and-imm0)                  
                    (with-imm-target (ppc::imm0) (ptr-reg :address)
                      (! temp-pop-unboxed-word ptr-reg)
                      (ppc2-close-undo)
                      (ppc2-memory-store-displaced seg ppc::imm0 ptr-reg offval size deref)                    
                      (if for-value
                        (<- ppc::arg_z))))))
              ;; No (16-bit) constant offset.  Might still have a 32-bit constant offset;
              ;; might have a constant value.  Might not.  Might not.
              ;; Easiest to special-case the constant-value case first ...
              (let* ((xptr-reg nil)
                     (xoff-reg nil)
                     (xval-reg nil)
                     (node-arg_z nil)
                     (constant-offset (ppc2-fixnum-form-p offset)))
                (if intval
                  (if constant-offset
                    (with-imm-target () (ptr-reg :address)
                      (ppc2-one-targeted-reg-form seg ptr ptr-reg)
                      (with-imm-target (ptr-reg) (off-reg :s32)
                        (ppc2-lwi seg off-reg constant-offset)
                        (with-imm-target (ptr-reg off-reg) (val-reg :s32)
                          (if (eql intval 0)
                            (setq val-reg ppc::rzero)
                            (ppc2-lwi seg val-reg intval))
                          (setq xptr-reg ptr-reg
                                xoff-reg off-reg
                                xval-reg val-reg))))
                    ; Offset's non-constant.  Temp-push the pointer, evaluate
                    ; and unbox the offset, load the value, pop the pointer.
                    (progn
                      (with-imm-target () (ptr-reg :address)
                        (ppc2-one-targeted-reg-form seg ptr ptr-reg)
                        (! temp-push-unboxed-word ptr-reg)
                        (ppc2-open-undo $undostkblk))
                      (with-imm-target () (off-reg :s32)
                        (! fixnum->s32 off-reg (ppc2-one-targeted-reg-form seg offset ppc::arg_z))
                        (with-imm-target (off-reg) (val-reg :s32)
                          (if (eql intval 0)
                            (setq val-reg ppc::rzero)
                            (ppc2-lwi seg val-reg intval))
                          (with-imm-target (off-reg val-reg) (ptr-reg :address)
                            (! temp-pop-unboxed-word ptr-reg)
                            (ppc2-close-undo)
                            (setq xptr-reg ptr-reg
                                  xoff-reg off-reg
                                  xval-reg val-reg))))))
                  ;; No intval; maybe constant-offset.
                  (with-imm-target () (ptr-reg :address)
                    (ppc2-one-targeted-reg-form seg ptr ptr-reg)
                    (! temp-push-unboxed-word ptr-reg)
                    (ppc2-open-undo $undostkblk)
                    (if (or constant-offset (not value-first-p))
                      (progn
                        (if (not constant-offset)
                          (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg offset ppc::arg_z)))
                        (val-to-argz-and-imm0)
                        (with-imm-target (ppc::imm0) (off-reg :s32)
                          (if constant-offset
                            (ppc2-lwi seg off-reg constant-offset)
                            (with-node-temps (ppc::arg_z) (temp)
                              (ppc2-vpop-register seg temp)
                              (! fixnum->s32 off-reg temp)))
                          (with-imm-target (ppc::imm0 off-reg) (ptr-reg :address)
                            (! temp-pop-unboxed-word ptr-reg)
                            (ppc2-close-undo)
                            (setq xptr-reg ptr-reg
                                  xoff-reg off-reg
                                  xval-reg ppc::imm0
                                  node-arg_z t))))
                      (progn
                        (ppc2-two-targeted-reg-forms seg val ppc::arg_z offset ppc::arg_y)
                        (if (eq size 4)
                          (! call-subprim .SPgetXlong)
                          (! fixnum->s32 ppc::imm0 ppc::arg_z))
                        (with-imm-target (ppc::imm0) (off-reg :s32)
                          (! fixnum->s32 off-reg ppc::arg_y)
                          (with-imm-target (ppc::imm0 off-reg) (ptr-reg :address)
                            (! temp-pop-unboxed-word ptr-reg)
                            (ppc2-close-undo)
                            (setq xptr-reg ptr-reg
                                    xoff-reg off-reg
                                    xval-reg ppc::imm0
                                    node-arg_z nil)))))))
                (ppc2-memory-store-indexed seg xval-reg xptr-reg xoff-reg size deref)              
                (when for-value
                  (if node-arg_z
                    (<- ppc::arg_z)
                    (<- (ppc::set-regspec-mode 
                         xval-reg
                         (ppc-gpr-mode-name-value
                          (if (eq size 4)
                            :s32
                            (if (eq size 2)
                              :s16
                              :s8))))))))))
          (^))))))


; Is acode-expression the result of alphatizing (%int-to-ptr <integer>) ?
(defun ppc2-absolute-ptr-p (acode-expression &optional skip)
  (and (acode-p acode-expression)
       (or skip (prog1 (eq (acode-operator acode-expression) (%nx1-operator %macptrptr%))
                  (setq acode-expression (%cadr acode-expression))))
       (eq (acode-operator acode-expression) (%nx1-operator %consmacptr%))
       (eq (acode-operator (setq acode-expression (%cadr acode-expression))) 
           (%nx1-operator %immediate-int-to-ptr))
       (let ((op (acode-operator (setq acode-expression (%cadr acode-expression)))))
         (if (or (eq op (%nx1-operator fixnum))
                 (and (eq op (%nx1-operator immediate))
                      (integerp (%cadr acode-expression))))
           (%cadr acode-expression)))))


(defun ppc2-encoding-undo-count (encoding)
 (svref encoding 0))

(defun ppc2-encoding-cstack-depth (encoding)    ; hardly ever interesting
  (svref encoding 1))

(defun ppc2-encoding-vstack-depth (encoding)
  (svref encoding 2))

(defun ppc2-encoding-vstack-top (encoding)
  (svref encoding 3))

(defun ppc2-encode-stack ()
  (vector *ppc2-undo-count* *ppc2-cstack* *ppc2-vstack* *ppc2-top-vstack-lcell*))

(defun ppc2-decode-stack (encoding)
  (values (ppc2-encoding-undo-count encoding)
          (ppc2-encoding-cstack-depth encoding)
          (ppc2-encoding-vstack-depth encoding)
          (ppc2-encoding-vstack-top encoding)))

(defun ppc2-equal-encodings-p (a b)
  (dotimes (i 3 t)
    (unless (eq (svref a i) (svref b i)) (return))))

(defun ppc2-open-undo (&optional (reason $undocatch) (curstack (ppc2-encode-stack)))
  (set-fill-pointer 
   *ppc2-undo-stack*
   (set-fill-pointer *ppc2-undo-because* *ppc2-undo-count*))
  (vector-push-extend curstack *ppc2-undo-stack*)
  (vector-push-extend reason *ppc2-undo-because*)
  (setq *ppc2-undo-count* (%i+ *ppc2-undo-count* 1)))

(defun ppc2-close-undo (&aux
                        (new-count (%i- *ppc2-undo-count* 1))
                        (i (aref *ppc2-undo-stack* new-count)))
  (multiple-value-setq (*ppc2-undo-count* *ppc2-cstack* *ppc2-vstack* *ppc2-top-vstack-lcell*)
    (ppc2-decode-stack i))
  (set-fill-pointer 
   *ppc2-undo-stack*
   (set-fill-pointer *ppc2-undo-because* new-count)))





; "Trivial" means can be evaluated without allocating or modifying registers.
; Interim definition, which will probably stay here forever.
(defun ppc2-trivial-p (form &aux op bits)
  (setq form (nx-untyped-form form))
  (and
   (consp form)
   (not (eq (setq op (%car form)) (%nx1-operator call)))
   (or
    (nx-null form)
    (nx-t form)
    (eq op (%nx1-operator simple-function))
    (eq op (%nx1-operator fixnum))
    (eq op (%nx1-operator immediate))
    (eq op (%nx1-operator bound-special-ref))
    (and (or (eq op (%nx1-operator inherited-arg)) 
             (eq op (%nx1-operator lexical-reference)))
         (or (%ilogbitp $vbitpunted (setq bits (nx-var-bits (cadr form))))
             (neq (%ilogior (%ilsl $vbitclosed 1) (%ilsl $vbitsetq 1))
                  (%ilogand (%ilogior (%ilsl $vbitclosed 1) (%ilsl $vbitsetq 1)) bits)))))))

(defun ppc2-fixnum-form-p (x)
  (setq x (ppc2-unwrapped-form x))
  (if (acode-p x)
    (if (eq (acode-operator x) (%nx1-operator fixnum)) 
      (cadr x))))

(defun ppc2-fixnum-type-p (form)
  (or (ppc2-fixnum-form-p form)
      (and *ppc2-trust-declarations*
           (acode-p form)
           (eq (acode-operator form) (%nx1-operator typed-form))
           (subtypep (cadr form) 'fixnum))))

(defun ppc2-lexical-reference-p (form)
  (when (acode-p form)
    (let ((op (acode-operator (setq form (ppc2-unwrapped-form form)))))
      (when (or (eq op (%nx1-operator lexical-reference))
                (eq op (%nx1-operator inherited-arg)))
        (%cadr form)))))

(defun ppc2-ref-symbol-value (seg vreg xfer sym check-boundp)
  (with-local-vinsn-macros (seg vreg xfer)
    (when vreg
      (setq sym (ppc2-symbol-value-locative sym))
      (let* ((symreg (or (ppc2-register-constant-p sym)
                         (ppc2-store-immediate seg sym (if (and check-boundp 
                                                                (eq ppc::arg_z (ppc::hard-regspec-value vreg)))
                                                         ppc::arg_y 
                                                         ppc::arg_z)))))
        (ensuring-node-target (target vreg)
          (if check-boundp
            (if (eq (ppc::hard-regspec-value vreg) (ppc::hard-regspec-value symreg))
              (with-node-temps (target symreg) (other)
                (! copy-node-gpr other symreg)
                (! symbol-value target other))
              (! symbol-value target symreg))
            (! node-slot-ref target symreg ppc::symbol.vcell-cell)))))
    (^)))

;; Should be less eager to box result
(defun ppc2-extract-charcode (seg vreg xfer char safe)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((src (ppc2-one-untargeted-reg-form seg char ppc::arg_z)))
      (when safe
        (! trap-unless-character src))
      (if vreg
        (ensuring-node-target (target vreg)
          (! character->fixnum target src)))
      (^))))
  
(defun ppc2-reference-list (seg vreg xfer listform safe refcdr)
  (if (ppc2-form-typep listform 'list)
    (setq safe nil))                    ; May also have been passed as NIL.
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((src (ppc2-one-untargeted-reg-form seg listform ppc::arg_z)))
      (when safe
        (! trap-unless-list src))
      (if vreg
        (ensuring-node-target (target vreg)
          (if refcdr
            (! %cdr target src)
            (! %car target src))))
      (^))))

; If safe, ensure that index is a fixnum (if non-constant)
; and check vector bound.
; If we're going to have to evaluate the index into a register (to do
; the bounds check), but know that the index could be a constant 16-bit
; displacement, this'll look pretty silly ..
(defun ppc2-misc-node-ref (seg vreg xfer miscobj index safe)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((index-known-fixnum (ppc2-fixnum-form-p index))
           (unscaled-idx nil)
           (src nil))
      (if (or safe (not index-known-fixnum))
        (multiple-value-setq (src unscaled-idx)
          (ppc2-two-untargeted-reg-forms seg miscobj ppc::arg_y index ppc::arg_z))
        (setq src (ppc2-one-untargeted-reg-form seg miscobj ppc::arg_z)))
      (when safe
        (if (typep safe 'fixnum)
          (! trap-unless-typecode= src safe))
        (unless index-known-fixnum
          (! trap-unless-fixnum unscaled-idx))
        (! check-misc-bound unscaled-idx src))
      (when vreg
        (ensuring-node-target (target vreg)
          (if (and index-known-fixnum (<= index-known-fixnum ppc::max-32-bit-constant-index))
            (progn
              (! misc-ref-c-node target src index-known-fixnum))
            (let* ((idx-reg ppc::imm0))
              (if index-known-fixnum
                (ppc2-absolute-long seg idx-reg nil (+ ppc::misc-data-offset (ash index-known-fixnum 2)))
                (! scale-32bit-misc-index idx-reg unscaled-idx))
              (! misc-ref-node target src idx-reg)))))
      (^))))

(defun ppc2-misc-node-set (seg vreg xfer miscobj index value safe)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((index-known-fixnum (ppc2-fixnum-form-p index))
           (src )
           (unscaled-idx )
           (val-reg )
           (memoize (ppc2-acode-needs-memoization value)))
      (if (or safe (not index-known-fixnum))
        (multiple-value-setq (src unscaled-idx val-reg)
          (ppc2-three-untargeted-reg-forms seg miscobj ppc::arg_x index ppc::arg_y value ppc::arg_z))
        (multiple-value-setq (src val-reg)
          (ppc2-two-untargeted-reg-forms seg miscobj ppc::arg_y value ppc::arg_z)))
      (when safe
        (if (typep safe 'fixnum)
          (! trap-unless-typecode= src safe))
        (unless index-known-fixnum
          (! trap-unless-fixnum unscaled-idx))
        (! check-misc-bound unscaled-idx src))
      (if (and index-known-fixnum (<= index-known-fixnum ppc::max-32-bit-constant-index))
        (progn
          (if memoize
            (! misc-set-c-node& val-reg src index-known-fixnum)
            (! misc-set-c-node val-reg src index-known-fixnum)))
        (let* ((idx-reg ppc::imm0))
          (if index-known-fixnum
            (ppc2-absolute-long seg idx-reg nil (+ ppc::misc-data-offset (ash index-known-fixnum 2)))
            (! scale-32bit-misc-index idx-reg unscaled-idx))
          (if memoize
            (! misc-set-node& val-reg src idx-reg)
            (! misc-set-node val-reg src idx-reg))))
      (<- val-reg)
      (^))))



(defun ppc2-misc-byte-count (subtag element-count)
  (declare (fixnum subtag))
  (if (or (= ppc::fulltag-nodeheader (logand subtag ppc::fulltagmask))
          (<= subtag ppc::max-32-bit-ivector-subtag))
    (ash element-count 2)
    (if (<= subtag ppc::max-8-bit-ivector-subtag)
      element-count
      (if (<= subtag ppc::max-16-bit-ivector-subtag)
        (ash element-count 1)
        (if (= subtag ppc::subtag-bit-vector)
          (ash (+ element-count 7) -3)
          (+ 4 (ash element-count 3)))))))

; The naive approach is to vpush all of the initforms, allocate the miscobj,
; then sit in a loop vpopping the values into the vector.
; That's "naive" when most of the initforms in question are "side-effect-free"
; (constant references or references to un-SETQed lexicals), in which case
; it makes more sense to just store the things into the vector cells, vpushing/
; vpopping only those things that aren't side-effect-free.  (It's necessary
; to evaluate any non-trivial forms before allocating the miscobj, since that
; ensures that the initforms are older (in the EGC sense) than it is.)
; The break-even point space-wise is when there are around 3 non-trivial initforms
; to worry about.


(defun ppc2-allocate-initialized-gvector (seg vreg xfer subtag initforms)
  (with-local-vinsn-macros (seg vreg xfer)
    (if (null vreg)
      (dolist (f initforms) (ppc2-form seg nil nil f))
      (let* ((*ppc2-vstack* *ppc2-vstack*)
             (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*)
             (n (length initforms))
             (nntriv (let* ((count 0)) 
                       (declare (fixnum count))
                       (dolist (f initforms count) 
                         (unless (ppc-side-effect-free-form-p f)
                           (incf count)))))                                             
             (header (logior (ash n ppc::num-subtag-bits) subtag)))
        (declare (fixnum n nntriv))
        (cond ((or *ppc2-open-code-inline* (> nntriv 3))
               (ppc2-formlist seg initforms nil)
               (with-imm-target (ppc::imm0) (rheader :u32)
                 (ppc2-lwi seg rheader header)
                 (! %ppc-new-gvector vreg rheader (ash n ppc::word-shift))))
              (t
               (let* ((pending ())
                      (vstack *ppc2-vstack*))
                 (declare (fixnum vstack))
                 (dolist (form initforms)
                   (if (ppc-side-effect-free-form-p form)
                     (push form pending)
                     (progn
                       (push nil pending)
                       (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg form ppc::arg_z)))))
                 (with-imm-target (ppc::imm0) (hreg :u32)
                 (ppc2-lwi seg hreg header)
                 (ensuring-node-target (target vreg)
                   (! %new-alloc-misc-fixed target hreg (ash n ppc::word-shift))
                   (with-node-temps (target) (nodetemp)
                     (do* ((forms pending (cdr forms))
                           (index (1- n) (1- index))
                           (pushed-cell (+ vstack (the fixnum (ash nntriv ppc::word-shift)))))
                          ((null forms))
                       (declare (list forms) (fixnum pushed-cell))
                       (let* ((form (car forms))
                              (reg nodetemp))
                         (if form
                           (setq reg (ppc2-one-untargeted-reg-form seg form nodetemp))
                           (progn
                             (decf pushed-cell 4)
                             (ppc2-stack-to-register seg (ppc2-vloc-ea pushed-cell) nodetemp)))
                         (! misc-set-c-node reg target index))))))
                 (! vstack-discard nntriv))))))
     (^)))

;; Heap-allocated constants -might- need memoization: they might be newly-created,
;; as in the case of synthesized toplevel functions in .pfsl files.
(defun ppc2-acode-needs-memoization (valform)
  (if (ppc2-form-typep valform 'fixnum)
    nil
    (let* ((val (ppc2-unwrapped-form valform)))
      (if (or (eq val *nx-t*)
              (eq val *nx-nil*)
              (and (acode-p val)
                   (let* ((op (acode-operator val)))
                     (or (eq op (%nx1-operator fixnum)) #|(eq op (%nx1-operator immediate))|#))))
        nil
        t))))

(defun ppc2-modify-cons (seg vreg xfer ptrform valform safe setcdr returnptr)
  (if (ppc2-form-typep ptrform 'cons)
    (setq safe nil))                    ; May also have been passed as NIL.
  (with-local-vinsn-macros (seg vreg xfer)
    (multiple-value-bind (ptr-vreg val-vreg) (ppc2-two-untargeted-reg-forms seg ptrform ppc::arg_y valform ppc::arg_z)
    (let* ((memoize (ppc2-acode-needs-memoization valform)))
      (when safe
        (! TRAP-UNLESS-cons ptr-vreg))
      (if setcdr
        (if memoize
          (! %set-cdr& ptr-vreg val-vreg)
          (! %set-cdr ptr-vreg val-vreg))
        (if memoize
          (! %set-car& ptr-vreg val-vreg)
          (! %set-car ptr-vreg val-vreg)))
      (if returnptr
        (<- ptr-vreg)
        (<- val-vreg))
      (^)))))



(defun ppc2-find-nilret-label ()
  (dolist (l *ppc2-nilret-labels*)
    (destructuring-bind (label vsp csp register-restore-count register-restore-ea &rest agenda) l
      (and (or (and (eql 0 register-restore-count)
                    (or (not (eql 0 vsp))
                        (eq vsp *ppc2-vstack*)))
                (and 
                 (eq register-restore-count *ppc2-register-restore-count*)
                 (eq vsp *ppc2-vstack*)))
           (or agenda (eq csp *ppc2-cstack*))
           (eq register-restore-ea *ppc2-register-restore-ea*)
           (eq (%ilsr 1 (length agenda)) *ppc2-undo-count*)
           (dotimes (i (the fixnum *ppc2-undo-count*) t) 
             (unless (and (eq (pop agenda) (aref *ppc2-undo-because* i))
                          (eq (pop agenda) (aref *ppc2-undo-stack* i)))
               (return)))
           (return label)))))

(defun ppc2-record-nilret-label ()
  (let* ((lab (ppc2-get-next-label))
         (info nil))
    (dotimes (i (the fixnum *ppc2-undo-count*))
      (push (aref *ppc2-undo-because* i) info)
      (push (aref *ppc2-undo-stack* i) info))
    (push (cons
                 lab 
                 (cons
                  *ppc2-vstack*
                  (cons 
                   *ppc2-cstack*
                   (cons
                    *ppc2-register-restore-count*
                    (cons
                     *ppc2-register-restore-ea*
                     (nreverse info))))))
          *ppc2-nilret-labels*)
    lab))

; If we know that the form is something that sets a CR bit,
; allocate a CR field and evaluate the form in such a way
; as to set that bit.
; If it's a compile-time constant, branch accordingly and
; let the dead code die.
; Otherwise, evaluate it to some handy register and compare
; that register to RNIL.
; "XFER" is a compound destination.
(defun ppc2-conditional-form (seg xfer form)
  (let* ((uwf (ppc2-unwrapped-form form)))
    (if (nx-null uwf)
      (ppc2-branch seg (ppc2-cd-false xfer) nil)
      (if (ppc-constant-form-p uwf)
        (ppc2-branch seg (ppc2-cd-true xfer) nil)
        (with-crf-target () crf
          (ppc2-form seg crf xfer form))))))

      
(defun ppc2-branch (seg xfer crf &optional cr-bit true-p)
  (let* ((*ppc2-vstack* *ppc2-vstack*)
         (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*))
    (with-local-vinsn-macros (seg)
      (setq xfer (or xfer 0))
      (when (%ilogbitp $ppc-mvpass-bit xfer) ;(ppc2-mvpass-p cd)
        (setq xfer (%ilogand (%ilognot $ppc-mvpass-mask) xfer))
        (unless *ppc2-returning-values*
          (ppc2-vpush-register seg ppc::arg_z)
          (ppc2-set-nargs seg 1)))
      (if (neq 0 xfer)
        (if (eq xfer $ppc-return)    ;; xfer : RETURN ==> popj
          (ppc2-do-return seg)
          (if (not (ppc2-cd-compound-p xfer))
            (-> xfer)  ;; xfer : label# ==> BRA label#
            ;; cd is compound : (<true> / <false>)
            (let* ((truebranch (ppc2-cd-true xfer))
                   (falsebranch (ppc2-cd-false xfer))
                   (tbranch (if true-p truebranch falsebranch))
                   (nbranch (if true-p falsebranch truebranch))
                   (tn0 (neq 0 tbranch))
                   (tnret (neq $ppc-return tbranch))
                   (nn0 (neq 0 nbranch))
                   (nnret (neq $ppc-return nbranch))
                   (tlabel (if (and tnret tn0) (aref *ppc2-labels* tbranch)))
                   (nlabel (if (and nnret nn0) (aref *ppc2-labels* nbranch))))
              (unless cr-bit (setq cr-bit ppc::ppc-eq-bit))
              (if (and tn0 tnret nn0 nnret)
                (progn
                  (! branch-true crf cr-bit tlabel)    ;; (label# /  label#)
                  (-> nbranch)))
                (if (and nnret tnret)
                  (if nn0
                    (! branch-false crf cr-bit nlabel)
                    (! branch-true crf cr-bit tlabel))
                  (let* ((aux-label (ppc2-get-next-label))
                         (auxl (aref *ppc2-labels* aux-label)))
                    (if tn0
                      (! branch-true crf cr-bit auxl)
                      (! branch-false crf cr-bit auxl))
                    (ppc2-do-return seg)
                    (@ aux-label))))))))))

(defun ppc2-cd-merge (cd label)
  (setq cd (or cd 0))
  (let ((mvpass (%ilogbitp $ppc-mvpass-bit cd)))
    (if (neq 0 (%ilogand2 (%ilognot $ppc-mvpass-mask) cd))
      (if (ppc2-cd-compound-p cd)
        (ppc2-make-compound-cd
         (ppc2-cd-merge (ppc2-cd-true cd) label)
         (ppc2-cd-merge (ppc2-cd-false cd) label)
         mvpass)
        cd)
      (if mvpass 
        (%ilogior2 $ppc-mvpass-mask label)
        label))))

(defun ppc2-mvpass-p (xfer)
  (if xfer (or (%ilogbitp $ppc-mvpass-bit xfer) (eq xfer $ppc-mvpass))))

(defun ppc2-cd-compound-p (xfer)
  (if xfer (%ilogbitp $ppc-compound-branch-target-bit xfer)))

(defun ppc2-cd-true (xfer)
 (if (ppc2-cd-compound-p xfer)
   (ldb  $ppc-compound-branch-true-byte xfer)
  xfer))

(defun ppc2-cd-false (xfer)
 (if (ppc2-cd-compound-p xfer)
   (ldb  $ppc-compound-branch-false-byte xfer)
   xfer))

(defun ppc2-make-compound-cd (tpart npart &optional mvpass-p)
  (dpb (or npart 0) $ppc-compound-branch-false-byte
       (dpb (or tpart 0) $ppc-compound-branch-true-byte
            (logior (if mvpass-p $ppc-mvpass-mask 0) $ppc-compound-branch-target-mask))))

(defun ppc2-invert-cd (cd)
  (if (ppc2-cd-compound-p cd)
    (ppc2-make-compound-cd (ppc2-cd-false cd) (ppc2-cd-true cd) (logbitp $ppc-mvpass-bit cd))
    cd))

(defun ppc2-long-constant-p (form)
  (setq form (ppc2-unwrapped-form form))
  (or (ppc2-fixnum-form-p form)
      (and (acode-p form)
           (eq (acode-operator form) (%nx1-operator immediate))
           (setq form (%cadr form))
           (if (integerp form) 
             form
             (progn
               (if (symbolp form) (setq form (symbol-name form)))
               (if (and (stringp form) (eql (length form) 4))
                 (logior (ash (%char-code (char form 0)) 24)
                         (ash (%char-code (char form 1)) 16)
                         (ash (%char-code (char form 2)) 8)
                         (%char-code (char form 3)))
                 (if (characterp form) (%char-code form))))))))

; execute body, cleanup afterwards (if need to)
(defun ppc2-undo-body (seg vreg xfer body old-stack)
  (let* ((current-stack (ppc2-encode-stack))
         (numundo (%i- *ppc2-undo-count* (ppc2-encoding-undo-count old-stack))))
    (declare (fixnum numundo))
    (with-local-vinsn-macros (seg vreg xfer)
      (if (eq current-stack old-stack)
        (ppc2-form seg vreg xfer body)
        (if (eq xfer $ppc-return)
          (progn
            (ppc2-form seg vreg xfer body)
            (dotimes (i numundo) (ppc2-close-undo)))
          (if (ppc2-mvpass-p xfer)
            (progn
              (ppc2-mvpass seg body) ; presumed to be ok
              (let* ((*ppc2-returning-values* :pass))
                (ppc2-nlexit seg xfer numundo)
                (^))
              (dotimes (i numundo) (ppc2-close-undo)))
            (progn
              ; There are some cases where storing thru ppc::arg_z can be avoided (stores to vlocs, specials,
              ; etc.) and some other case where it can't ($test, $vpush.)  The case of a null vd can
              ; certainly avoid it; the check of numundo is to keep $acc boxed in case of nthrow.
              (ppc2-form  seg (if (or vreg (not (%izerop numundo))) ppc::arg_z) nil body)
              (ppc2-unwind-set seg xfer old-stack)
              (when vreg (<- ppc::arg_z))
              (^))))))))


(defun ppc2-unwind-set (seg xfer encoding)
  (multiple-value-bind (target-catch target-cstack target-vstack target-vstack-lcell)
                       (ppc2-decode-stack encoding)
    (ppc2-unwind-stack seg xfer target-catch target-cstack target-vstack)
    (setq *ppc2-undo-count* target-catch 
          *ppc2-cstack* target-cstack
          *ppc2-vstack* target-vstack
          *ppc2-top-vstack-lcell* target-vstack-lcell)))

(defun ppc2-unwind-stack (seg xfer target-catch target-cstack target-vstack)
  (let* ((current-catch *ppc2-undo-count*)
         (current-cstack *ppc2-cstack*)
         (current-vstack *ppc2-vstack*)
         (diff (%i- current-catch target-catch))
         target
         (exit-vstack current-vstack))
    (declare (ignore-if-unused target))
    (when (neq 0 diff)
      (setq exit-vstack (ppc2-nlexit seg xfer diff))
      (multiple-value-setq (target current-cstack current-vstack)
                           (ppc2-decode-stack (aref *ppc2-undo-stack* target-catch))))
    (if (%i< 0 (setq diff (%i- current-cstack target-cstack)))
      (ppc2-fix-stackreg seg ppc::sp diff))
    (if (%i< 0 (setq diff (%i- current-vstack target-vstack)))
      (with-local-vinsn-macros (seg)
        (! vstack-discard (ash diff -2))))
    exit-vstack))

; We can sometimes combine unwinding the catch stack with returning from the function
; by jumping to a subprim that knows how to do this.  If catch frames were distinguished
; from unwind-protect frames, we might be able to do this even when saved registers
; are involved (but the subprims restore them from the last catch frame.)
; *** there are currently only subprims to handle the "1 frame" case; add more ***
(defun ppc2-do-return (seg)
  (let* ((*ppc2-vstack* *ppc2-vstack*)
         (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*)
         (mask *ppc2-register-restore-count*)
         (ea *ppc2-register-restore-ea*)
         (label nil)
         (vstack nil)
         (foldp (not *ppc2-open-code-inline*)))
    (if (%izerop mask) (setq mask nil))
    (with-local-vinsn-macros (seg)
      (progn
        (setq vstack (ppc2-set-vstack (ppc2-unwind-stack seg $ppc-return 0 0 #x1fff)))  ;; << was #x7ff
        (if *ppc2-returning-values*
          (cond ((and mask foldp (setq label (%cdr (assq vstack *ppc2-valret-labels*))))
                 (-> label))
                (t
                 (@ (setq label (ppc2-get-next-label)))
                 (push (cons vstack label) *ppc2-valret-labels*)
                 (when mask
                   (with-imm-temps () (vsp0)
                     (! fixnum-add vsp0 ppc::vsp ppc::nargs)
                     (ppc2-restore-nvrs seg ea mask vsp0)))
                 (! jump-subprim .SPnvalret)))
          (if (null mask)
            (if *ppc2-open-code-inline*
              (progn
                (! restore-full-lisp-context)
                (! jump-return-pc))
              (! popj))
            (if (and foldp (setq label (assq *ppc2-vstack* *ppc2-popreg-labels*)))
              (-> (cdr label))
              (let* ((new-label (ppc2-get-next-label)))
                (@ new-label)
                (push (cons *ppc2-vstack* new-label) *ppc2-popreg-labels*)
                (ppc2-set-vstack (ppc2-restore-nvrs seg ea mask))
                (if *ppc2-open-code-inline*
                  (progn
                    (! restore-full-lisp-context)
                    (! jump-return-pc))
                  (! popj))))))))
    nil))



(defun ppc2-mvcall (seg vreg xfer fn arglist &optional recursive-p)
  (let* ((cstack *ppc2-cstack*)
         (vstack *ppc2-vstack*))
    (with-local-vinsn-macros (seg vreg xfer)
      (if (and (eq xfer $ppc-return) (not (ppc2-tailcallok xfer)))
        (progn
          (ppc2-mvcall seg vreg $ppc-mvpass fn arglist t)
          (ppc2-set-vstack (%i+ (if arglist 4 0) vstack))
          (setq *ppc2-cstack* cstack)
          (let* ((*ppc2-returning-values* t)) (^)))
        (let* ((mv-p (ppc2-mv-p xfer)))
          (if (null arglist)
            (ppc2-call-fn seg vreg xfer fn arglist nil)
            (progn
              (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg fn ppc::arg_z))
              (ppc2-multiple-value-body seg (pop arglist))
              (when arglist
                (ppc2-open-undo $undostkblk)
                (! call-subprim .SPsave-values)
                (dolist (form arglist)
                  (ppc2-multiple-value-body seg form)
                  (! call-subprim .SPadd-values))
                (ppc2-set-nargs seg 0)
                (! call-subprim .SPrecover-values)
                (ppc2-close-undo))
              (! lisp-word-ref ppc::temp0 ppc::vsp ppc::nargs)
              (ppc2-invoke-fn seg ppc::temp0 nil nil xfer)))
          (unless recursive-p
            (if mv-p
              (unless (eq xfer $ppc-return)
                (let* ((*ppc2-returning-values* t))
                  (^)))
              (progn 
                (ppc2-adjust-vstack -4)          ; discard function
                (! vstack-discard 1)
                (<- ppc::arg_z)
                (^)))))))))


(defun ppc2-hard-opt-p (opts)
  (or
   (dolist (x (%cadr opts))
     (unless (nx-null x) (return t)))
   (dolist (x (%caddr opts))
     (when x (return t)))))

(defun ppc2-close-lambda (seg req opt rest keys auxen)
  (dolist (var req)
    (ppc2-close-var seg var))
  (dolist (var (%car opt))
    (ppc2-close-var seg var))
  (dolist (var (%caddr opt))
    (when var
      (ppc2-close-var seg var)))
  (if rest
    (ppc2-close-var seg rest))
  (dolist (var (%cadr keys))
    (ppc2-close-var seg var))
  (dolist (var (%caddr keys))
    (if var (ppc2-close-var seg var)))
  (dolist (var (%car auxen))
    (ppc2-close-var seg var)))

(defun ppc2-close-structured-var (seg var)
  (if (ppc2-structured-var-p var)
    (apply #'ppc2-close-structured-lambda seg (cdr var))
    (ppc2-close-var seg var)))

(defun ppc2-close-structured-lambda (seg whole req opt rest keys auxen)
  (if whole
    (ppc2-close-var seg whole))
  (dolist (var req)
    (ppc2-close-structured-var seg var))
  (dolist (var (%car opt))
    (ppc2-close-structured-var seg var))
  (dolist (var (%caddr opt))
    (when var
      (ppc2-close-var seg var)))
  (if rest
    (ppc2-close-structured-var seg rest))
  (dolist (var (%cadr keys))
    (ppc2-close-structured-var seg var))
  (dolist (var (%caddr keys))
    (if var (ppc2-close-var seg var)))
  (dolist (var (%car auxen))
    (ppc2-close-var seg var)))


(defun ppc2-init-regvar (seg var reg addr)
  (ppc2-stack-to-register seg addr reg)
  (ppc2-set-var-ea seg var reg))

(defun ppc2-bind-structured-var (seg var vloc lcell &optional context)
  (if (not (ppc2-structured-var-p var))
    (let* ((reg (ppc2-assign-register-var var)))
      (if reg
        (ppc2-init-regvar seg var reg (ppc2-vloc-ea vloc))
        (ppc2-bind-var seg var vloc lcell)))
    (let* ((v2 (%cdr var))
           (v v2)
           (vstack *ppc2-vstack*)
           (whole (pop v))
           (req (pop v))
           (opt (pop v))
           (rest (pop v))
           (keys (pop v)))
      
      (apply #'ppc2-bind-structured-lambda seg 
             (ppc2-spread-lambda-list seg (ppc2-vloc-ea vloc) whole req opt rest keys context)
             vstack context v2))))

(defun ppc2-bind-structured-lambda (seg lcells vloc context whole req opt rest keys auxen
                        &aux (nkeys (list-length (%cadr keys))))
  (declare (fixnum vloc))
  (when whole
    (ppc2-bind-structured-var seg whole vloc (pop lcells))
    (incf vloc 4))
  (dolist (arg req)
    (ppc2-bind-structured-var seg arg vloc (pop lcells) context)
    (incf vloc 4))
  (when opt
   (if (ppc2-hard-opt-p opt)
     (setq vloc (apply #'ppc2-structured-initopt seg lcells vloc context opt)
           lcells (nthcdr (ash (length (car opt)) 1) lcells))
     (dolist (var (%car opt))
       (ppc2-bind-structured-var seg var vloc (pop lcells) context)
       (incf vloc 4))))
  (when rest
    (ppc2-bind-structured-var seg rest vloc (pop lcells) context)
    (incf vloc 4))
  (when keys
    (apply #'ppc2-structured-init-keys seg lcells vloc context keys)
    (setq vloc (%i+ vloc (%ilsl 3 nkeys))))
  (ppc2-seq-bind seg (%car auxen) (%cadr auxen)))

(defun ppc2-structured-var-p (var)
  (and (consp var) (or (eq (%car var) *nx-lambdalist*)
                       (eq (%car var) (%nx1-operator lambda-list)))))

(defun ppc2-simple-var (var &aux (bits (cadr var)))
  (if (or (%ilogbitp $vbitclosed bits)
          (%ilogbitp $vbitspecial bits))
    (nx-error "Non-simple-variable ~S" (%car var))
    var))

(defun ppc2-nlexit (seg xfer &optional (nlevels 0))
  (let* ((numnthrow 0)
         (n *ppc2-undo-count*)
         (cstack *ppc2-cstack*)
         (vstack *ppc2-vstack*)
         (target-cstack)
         (target-vstack)
         (lastcatch n)
         (i nil)
         (returning (eq xfer $ppc-return))
         (junk1 nil)
         (nspecs 0)
         (dest (%i- n nlevels))
         (retval *ppc2-returning-values*)
         reason)
    (declare (ignorable junk1))
    (declare (fixnum nspecs))
    (with-local-vinsn-macros (seg)
      (when (neq 0 nlevels)
        (let* ((numnlispareas 0))
          (declare (fixnum numnlispareas))
          (flet ((popnlispareas ()
                   (dotimes (i numnlispareas)
                     (! discard-temp-frame)))
                 (throw-through-numnthrow-catch-frames ()
                   (when (neq 0 numnthrow)
                     (ppc2-lwi seg ppc::imm0 (ash numnthrow ppc::fixnum-shift))
                     (! call-subprim (if retval .SPnthrowvalues .SPnthrow1value))
                     (setq numnthrow 0)
                     (multiple-value-setq (junk1 cstack vstack)
                       (ppc2-decode-stack (aref *ppc2-undo-stack* lastcatch))))))
            (while (%i> n dest)
              (cond ((eql $undocatch (setq reason (aref *ppc2-undo-because* (setq n (%i- n 1)))))
                     (popnlispareas)
                     (setq numnthrow (%i+ numnthrow 1) lastcatch n))
                    ((eql $undostkblk reason)
                     (throw-through-numnthrow-catch-frames)
                     (incf numnlispareas))))
            (throw-through-numnthrow-catch-frames)
            (setq i lastcatch)
            (while (%i> i dest)
              (let ((reason (aref *ppc2-undo-because* (setq i (%i- i 1)))))
                (if (eq reason $undospecial)
                  (setq nspecs (%i+ nspecs 1)))))
            (if (> nspecs 0)
              (ppc2-dpayback seg nspecs))
            (when (and (neq lastcatch dest)
                       (%i>
                        vstack
                        (setq target-vstack 
                              (nth-value 2 (ppc2-decode-stack (aref *ppc2-undo-stack* dest)))))
                       (neq retval t))
              (unless returning
                (let ((vdiff (%i- vstack target-vstack)))
                  (if retval
                    (progn
                      (ppc2-lwi seg ppc::imm0 vdiff)
                      (! call-subprim .SPmvslide))
                    (ppc2-fix-stackreg seg ppc::vsp vdiff)))))
            (setq numnlispareas 0)
            (while (%i> lastcatch dest)
              (let ((reason (aref *ppc2-undo-because* (setq lastcatch (%i- lastcatch 1)))))
                (setq target-cstack (nth-value 1
                                               (ppc2-decode-stack (aref *ppc2-undo-stack* lastcatch))))
                (if (eq reason $undostkblk)
                  (incf numnlispareas))
                (if (%i> cstack target-cstack)
                  (ppc2-fix-stackreg seg ppc::sp (%i- cstack target-cstack)))
                ; else what's going on? $sp-stkcons, for one thing
                (setq cstack target-cstack)))
            (popnlispareas)))
        vstack))))


; Restore the N most recent dynamic bindings.
(defun ppc2-dpayback (seg n)
  (declare (fixnum n))
  (with-local-vinsn-macros (seg)
    (! dpayback n)))

(defun ppc2-spread-lambda-list (seg listform whole req opt rest keys 
                                    &optional enclosing-ea cdr-p)
  (with-local-vinsn-macros (seg)
    (let* ((numopt (length (%car opt)))
           (nkeys (length (%cadr keys)))
           (numreq (length req))
           (vtotal numreq)
           (old-top *ppc2-top-vstack-lcell*)
           (doadlword (dpb nkeys (byte 8 16) (dpb numopt (byte 8 8) (dpb numreq (byte 8 0) 0 )))))
      (declare (fixnum numopt nkeys numreq vtotal doadlword))
      (when (or (> numreq 255) (> numopt 255) (> nkeys 255))
        (error "A lambda list can contain a maximum of 255 required, 255 optional, and 255 keywords args"))
      (if (fixnump listform)
        (ppc2-store-ea seg listform ppc::temp3)
        (ppc2-one-targeted-reg-form seg listform ppc::temp3))
      (when whole
        (ppc2-vpush-register seg ppc::temp3 :reserved))
      (when keys
        (setq doadlword (%ilogior2 (ash #x80000000 -6) doadlword))
        (incf  vtotal (%ilsl 1 nkeys))
        (if (%car keys)                 ; &allow-other-keys
          (setq doadlword (%ilogior doadlword (ash #x80000000 -5))))
        (ppc2-store-immediate seg (%car (%cdr (%cdr (%cdr (%cdr keys))))) ppc::temp2))
      (when opt
        (setq vtotal (%i+ vtotal numopt))
        (when (ppc2-hard-opt-p opt)
          (setq doadlword (%ilogior2 doadlword (ash #x80000000 -7)))
          (setq vtotal (%i+ vtotal numopt))))
      (when rest
        (setq doadlword (%ilogior2 (ash #x80000000 -4) doadlword) vtotal (%i+ vtotal 1)))
      (ppc2-reserve-vstack-lcells vtotal)
      (ppc2-lwi seg ppc::nargs doadlword)
      (if cdr-p
        (! call-subprim .SPmacro-bind)
        (if enclosing-ea
          (progn
            (ppc2-store-ea seg enclosing-ea ppc::arg_z)
            (! call-subprim .SPdestructuring-bind-inner))
          (! call-subprim .SPdestructuring-bind)))
      (ppc2-set-vstack (%i+ *ppc2-vstack* (%ilsl 2 vtotal)))
      (ppc2-collect-lcells :reserved old-top))))


(defun ppc2-tailcallok (xfer)
  (and (eq xfer $ppc-return)
       *ppc2-tail-allow*
       (eq 0 *ppc2-undo-count*)))

(defun ppc2-mv-p (cd)
  (or (eq cd $ppc-return) (ppc2-mvpass-p cd)))

(defun ppc2-expand-note (note)
  (let* ((lab (vinsn-note-label note)))
    (case (vinsn-note-class note)
      ((:regsave :begin-variable-scope :end-variable-scope)
       (setf (vinsn-label-info lab) (emit-ppc-lap-label lab))))))

(defun ppc2-expand-vinsns (header &optional (optimize t))
  (when optimize (optimize-vinsns header))
  (do-dll-nodes (v header)
    (if (%vinsn-label-p v)
      (let* ((id (vinsn-label-id v)))
        (if (typep id 'fixnum)
          (when (or t (vinsn-label-refs v))
            (setf (vinsn-label-info v) (emit-ppc-lap-label v)))
          (ppc2-expand-note id)))
      (ppc2-expand-vinsn v)))
  (ppc2-free-logical-registers)
  (ppc2-free-lcells))

; It's not clear whether or not predicates, etc. want to look
; at an lreg or just at its value slot.
; It's clear that the assembler just wants the value, and that
; the value had better be assigned by the time we start generating
; machine code.
; For now, we replace lregs in the operand vector with their values
; on entry, but it might be reasonable to make PARSE-OPERAND-FORM
; deal with lregs ...
(defun ppc2-expand-vinsn (vinsn)
  (let* ((template (vinsn-template vinsn))
         (vp (vinsn-variable-parts vinsn))
         (nvp (vinsn-template-nvp template)))
    (declare (fixnum nvp))
    (dotimes (i nvp)
      (let* ((val (svref vp i)))
        (when (typep val 'lreg)
          (setf (svref vp i) (lreg-value val)))))                       
    (dolist (name (vinsn-template-local-labels template))
      (make-ppc-lap-label name))
    (labels ((parse-operand-form (valform)
               (cond ((atom valform) valform)
                     ((atom (cdr valform)) (svref vp (car valform)))
                     (t (let* ((op-vals (cdr valform))
                               (parsed-ops (make-list (length op-vals)))
                               (tail parsed-ops))
                          (declare (dynamic-extent parsed-ops)
                                   (cons parsed-ops tail))
                          (dolist (op op-vals (apply (car valform) parsed-ops))
                            (setq tail (cdr (rplaca tail (parse-operand-form op)))))))))
             (expand-insn-form (f)
               (let* ((operands (cdr f))
                      (head (make-list (length operands)))
                      (tail head))
                 (declare (dynamic-extent head)
                          (cons (head tail)))
                 (dolist (op operands)
                   (rplaca tail (parse-operand-form op))
                   (setq tail (cdr tail)))
                 (ppc-emit-lap-instruction (svref ppc::*ppc-opcodes* (car f)) 
                                           head)))
             (eval-predicate (f)
               (case (car f)
                 (:pred (let* ((op-vals (cddr f))
                               (parsed-ops (make-list (length op-vals)))
                               (tail parsed-ops))
                          (declare (dynamic-extent parsed-ops)
                                   (cons parsed-ops tail))
                          (dolist (op op-vals (apply (cadr f) parsed-ops))
                            (setq tail (cdr (rplaca tail (parse-operand-form op)))))))
                 (:not (not (eval-predicate (cadr f))))
                 (:or (some #'eval-predicate (cadr f)))
                 (:and (every #'eval-predicate (cadr f)))
                 (t (error "Unknown predicate: ~s" f))))
             (expand-form (f)
               (if (keywordp f)
                 (emit-ppc-lap-label f)
                 (if (atom f)
                   (error "Invalid form in vinsn body: ~s" f)
                   (if (atom (car f))
                     (expand-insn-form f)
                     (if (eval-predicate (car f))
                       (dolist (subform (cdr f))
                         (expand-form subform))))))))
      (declare (dynamic-extent #'expand-form #'parse-operand-form #'expand-insn-form #'eval-predicate))
      ;(format t "~& vinsn = ~s" vinsn)
      (dolist (form (vinsn-template-body template))
        (expand-form form ))
      (setf (vinsn-variable-parts vinsn) nil)
      (when vp
        (free-varparts-vector vp)))))


(defun ppc2-emit-event-poll (seg)
  (with-local-vinsn-macros (seg)
    (unless *ppc2-inhibit-eventchecks*
      (let* ((event-poll-template (need-vinsn-template (load-time-value (get-vinsn-template-cell 'event-poll)))))
        (or (do* ((prev (dll-header-last seg) (dll-node-pred prev)))
                 ((eq prev seg) nil)
              (when (typep prev 'vinsn)
                (if (eq (vinsn-template prev) event-poll-template)
                  (progn
                    (remove-dll-node prev)
                    (append-dll-node prev seg)
                    (return t))
                  (return nil))))            
            (append-dll-node (make-vinsn event-poll-template) seg))))))

(defparameter *ppc2-builtin-subprims* '(((0 . 23) . #..SPbuiltin-plus)))

(defun ppc2-builtin-index-subprim (idx)
  (dolist (cell *ppc2-builtin-subprims*)
    (destructuring-bind ((low . high) . base) cell
      (if (and (>= idx low)
               (< idx high))
        (return (+ base (ash (- idx low) 2)))))))

(defun ppc2-fixed-call-builtin (seg vreg xfer name subprim)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((index (ppc::builtin-function-name-offset name))
           (idx-subprim (ppc2-builtin-index-subprim index))
           (tail-p (ppc2-tailcallok xfer)))
      (when tail-p
        (ppc2-restore-nvrs seg *ppc2-register-restore-ea* *ppc2-register-restore-count*)
        (ppc2-restore-full-lisp-context seg))
      (if idx-subprim
        (setq subprim idx-subprim)
        (! lwi ppc::imm0 (ash index ppc::fixnumshift)))
      (if tail-p
        (! jump-subprim subprim)
        (progn
          (! call-subprim subprim)
          (<- ppc::arg_z)
          (^))))))

(defun ppc2-unary-builtin (seg vreg xfer name form)
  (ppc2-one-targeted-reg-form seg form ppc::arg_z)
  (ppc2-fixed-call-builtin seg vreg xfer name .SPcallbuiltin1))

(defun ppc2-binary-builtin (seg vreg xfer name form1 form2)
  (ppc2-two-targeted-reg-forms seg form1 ppc::arg_y form2 ppc::arg_z)
  (ppc2-fixed-call-builtin seg vreg xfer name .SPcallbuiltin2))

(defun ppc2-ternary-builtin (seg vreg xfer name form1 form2 form3)
  (ppc2-three-targeted-reg-forms seg form1 ppc::arg_x form2 ppc::arg_y form3 ppc::arg_z)
  (ppc2-fixed-call-builtin seg vreg xfer name .SPcallbuiltin3))


(eval-when (:compile-toplevel :execute :load-toplevel)


(defmacro defppc2 (name locative arglist &body forms)
  (multiple-value-bind (body decls)
                       (parse-body forms nil t)
    (destructuring-bind (vcode-block dest control &rest other-args) arglist
      (let* ((fun `(nfunction ,name 
                              (lambda (,vcode-block ,dest ,control ,@other-args) ,@decls 
                                      (block ,name (with-local-vinsn-macros (,vcode-block ,dest ,control) ,@body))))))
        `(progn
           (record-source-file ',name 'function)
           (svset *ppc2-specials* (%ilogand #.operator-id-mask (%nx1-operator ,locative)) ,fun))))))
)
  
(defppc2 ppc2-lambda lambda-list (seg vreg xfer req opt rest keys auxen body p2decls)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((stack-consed-rest nil)
           (lexprp (if (consp rest) (progn (setq rest (car rest)) t)))
           (rest-var-bits (and rest (nx-var-bits rest)))
           (rest-ignored-p (and rest (not lexprp) (%ilogbitp $vbitignore rest-var-bits)))
           (want-stack-consed-rest (or rest-ignored-p
                                       (and rest (not lexprp) (%ilogbitp $vbitdynamicextent rest-var-bits))))
           (afunc *ppc2-cur-afunc*)
           (inherited-vars (afunc-inherited-vars afunc))
           (fbits (afunc-bits afunc))
           (methodp (%ilogbitp $fbitmethodp fbits))
           (method-var (if methodp (pop req)))
           (next-method-p (%ilogbitp $fbitnextmethp fbits))
           (allow-other-keys-p (%car keys))
           (hardopt (ppc2-hard-opt-p opt))
           (lap-p (when (and (consp (%car req)) (eq (%caar req) '&lap))
                    (prog1 (%cdar req) (setq req nil))))
           (num-inh (length inherited-vars))
           (num-req (length req))
           (num-opt (length (%car opt)))
           (no-regs nil)
           (arg-regs nil)
           optsupvloc
           reglocatives
           pregs
           (reserved-lcells nil)
           (*ppc2-vstack* 0))
      (declare (type (unsigned-byte 16) num-req num-opt num-inh reqvloc))
      ;(WHEN LEXPRP (SETQ *IS-LEXPR* T))
      (with-ppc-p2-declarations p2decls
        (setq *ppc2-inhibit-register-allocation*
              (setq no-regs (%ilogbitp $fbitnoregs fbits)))
        (multiple-value-setq (pregs reglocatives) 
          (ppc2-allocate-global-registers *ppc2-fcells* *ppc2-vcells* (afunc-all-vars afunc) no-regs))
        (@ (ppc2-get-next-label)) ; generic self-reference label, should be label #1
        (unless next-method-p
          (setq method-var nil))
        
        (let* ((rev-req (reverse req))
               (rev-fixed (if inherited-vars (reverse (append inherited-vars req)) rev-req))
               (num-fixed (length rev-fixed))
               (rev-opt (reverse (car opt))))

          (if (not (or opt rest keys))
            (setq arg-regs (ppc2-req-nargs-entry seg rev-fixed))
            (if (and (not (or hardopt rest keys))
                     (<= num-opt $numppcargregs))
              (setq arg-regs (ppc2-simple-opt-entry seg rev-opt rev-fixed))
              (progn
                ; If the minumum acceptable number of args is non-zero, ensure
                ; that at least that many were received.  If there's an upper bound,
                ; enforce it.
                
                (when rev-fixed
                  (ppc2-reserve-vstack-lcells num-fixed)                    
                  (! check-min-nargs num-fixed))
                (unless (or rest keys)
                  (! check-max-nargs (+ num-fixed num-opt)))
                ;; Going to have to call one or more subprims.  First save
                ;; the LR in LOC-PC.
                (! save-lr)
                ;; If there were &optional args, initialize their values
                ;; to NIL.  All of the argregs get vpushed as a result of this.
                (when opt
                  (ppc2-reserve-vstack-lcells num-opt)
                  (! default-optionals (+ num-fixed num-opt)))
                (when keys
                  (let* ((keyvect (%car (%cdr (%cdr (%cdr (%cdr keys))))))
                         (flags (the fixnum (logior (the fixnum (if rest 4 0)) 
                                                    (the fixnum (if (or methodp allow-other-keys-p) 1 0)))))
                         (nkeys (length keyvect))
                         (nprev (+ num-fixed num-opt))
                         (spno (if (= 0 nprev)
                                 .SPsimple-keywords
                                 (if (= 0 num-opt)
                                   .SPkeyword-args
                                   .SPkeyword-bind))))
                    (declare (fixnum flags nkeys nprev spno))
                    (dotimes (i (the fixnum (+ nkeys nkeys)))
                      (ppc2-new-vstack-lcell :reserved 4 0 nil))
                    (! misc-ref-c-node ppc::temp3 ppc::nfn (1+ (ppc2-immediate-index keyvect)))
                    (ppc2-lwi seg ppc::imm2 (ash flags ppc::fixnumshift))
                    (ppc2-lwi seg ppc::imm3 (ash nkeys ppc::fixnumshift))
                    (unless (= nprev 0)
                      (ppc2-lwi seg ppc::imm0 (ash nprev ppc::fixnumshift)))
                    (! call-subprim spno)))
                (when rest
                  ;; If any keyword-binding's happened, the key/value pairs have been slid to the top-of-stack
                  ;; for us.  There'll be an even number of them (nargs - the "previous" (required/&optional)
                  ;; count.)
                  (if lexprp
                    (ppc2-lexpr-entry seg num-fixed)
                    (progn
                      (if want-stack-consed-rest
                        (setq stack-consed-rest t))
                      (let* ((nprev (+ num-fixed num-opt))
                             (simple (and (not keys) (= 0 nprev)))
                             (spno (if stack-consed-rest
                                     (if simple
                                       .SPstack-rest-arg
                                       (if (and (not keys) (= 0 num-opt))
                                         .SPreq-stack-rest-arg
                                         .SPstack-cons-rest-arg))
                                     (if simple
                                       .SPheap-rest-arg
                                       (if (and (not keys) (= 0 num-opt))
                                         .SPreq-heap-rest-arg
                                         .SPheap-cons-rest-arg)))))
                        (declare (fixnum nprev))
                        (unless simple
                          (ppc2-lwi seg ppc::imm0 (ash nprev ppc::fixnumshift)))
                        (! call-subprim spno))
                      ; Make an lcell for the &rest arg
                      (ppc2-reserve-vstack-lcells 1))))
                (when hardopt
                  (ppc2-reserve-vstack-lcells num-opt)
                  (ppc2-lwi seg ppc::imm0 (ash num-opt ppc::fixnumshift))
                  ; .SPopt-supplied-p wants nargs to contain the actual arg-count
                  ; minus the number of "fixed" (required, inherited) args.
                  (unless (= 0 num-fixed)
                    (! scale-nargs num-fixed))
                  (! call-subprim .SPopt-supplied-p))
                (let* ((nwords-vpushed (+ num-fixed 
                                          num-opt 
                                          (if hardopt num-opt 0) 
                                          (if lexprp 0 (if rest 1 0))
                                          (ash (length (%cadr keys)) 1)))
                       (nbytes-vpushed (ash nwords-vpushed 2)))
                  (declare (fixnum nwords-vpushed nbytes-vpushed))
                  (unless (or lexprp keys) 
                    (if *ppc2-open-code-inline*
                      (! save-lisp-context-offset nbytes-vpushed)
                      (! save-lisp-context-offset-ool nbytes-vpushed)))
                  (ppc2-set-vstack nbytes-vpushed)
                  (setq optsupvloc (- *ppc2-vstack* (ash num-opt 2)))))))
          ;; Caller's context is saved; *ppc2-vstack* is valid.  Might still have method-var
          ;; to worry about.
          (unless (= 0 pregs)
            ;; Save NVRs; load constants into any that get constants.
            (ppc2-save-nvrs seg pregs)
            (dolist (pair reglocatives)
              (declare (cons pair))
              (let* ((constant (car pair))
                     (reg (cdr pair)))
                (declare (cons constant))
                (rplacd constant reg)
                (! ref-constant reg (ppc2-immediate-index (car constant))))))
          (when method-var
            (ppc2-seq-bind-var seg method-var ppc::next-method-context))
          ; If any arguments are still in arg_x, arg_y, arg_z, that's because they weren't vpushed
          ; in a "simple" entry case and belong in some NVR.  Put them in their NVRs, so that we can
          ; handle arbitrary expression evaluation (special binding, value-cell consing, etc.) without
          ; clobbering the argument registers.
          (when arg-regs
            (do* ((vars arg-regs (cdr vars))
                  (arg-reg-num ppc::arg_z (1- arg-reg-num)))
                 ((null vars))
              (declare (list vars) (fixnum arg-reg-num))
              (let* ((var (car vars)))
                (when var
                  (let* ((reg (ppc2-assign-register-var var)))
                    (ppc2-copy-register seg reg arg-reg-num)
                    (setf (var-ea var) reg))))))
          (setq *ppc2-entry-vsp-saved-p* t)
#|
          (when stack-consed-rest
            (if rest-ignored-p
              (if nil (ppc2-jsrA5 $sp-popnlisparea))
              (progn
                (ppc2-open-undo $undostkblk))))
|#
          (when stack-consed-rest
            (ppc2-open-undo $undostkblk))
          (setq *ppc2-entry-vstack* *ppc2-vstack*)
          (setq reserved-lcells (ppc2-collect-lcells :reserved))
          (ppc2-emit-event-poll seg)
          (ppc2-bind-lambda seg reserved-lcells req opt rest keys auxen optsupvloc arg-regs lexprp inherited-vars))
        (when method-var (ppc2-heap-cons-next-method-var seg method-var))
        (ppc2-form seg vreg xfer body)
        (ppc2-close-lambda seg req opt rest keys auxen)
        (dolist (v inherited-vars)
          (ppc2-close-var seg v))
        (when method-var
          (ppc2-close-var seg method-var))
        (let* ((bits 0))
          (when (%i> num-inh (ldb $lfbits-numinh -1))
            (setq num-inh (ldb $lfbits-numinh -1)))
          (setq bits (dpb num-inh $lfbits-numinh bits))
          (unless lap-p
            (when (%i> num-req (ldb $lfbits-numreq -1))
              (setq num-req (ldb $lfbits-numreq -1)))
            (setq bits (dpb num-req $lfbits-numreq bits))
            (when (%i> num-opt (ldb $lfbits-numopt -1))
              (setq num-opt (ldb $lfbits-numopt -1)))
            (setq bits (dpb num-opt $lfbits-numopt bits))
            (when hardopt (setq bits (%ilogior (%ilsl $lfbits-optinit-bit 1) bits)))
            (when rest (setq bits (%ilogior (if lexprp (%ilsl $lfbits-restv-bit 1) (%ilsl $lfbits-rest-bit 1)) bits)))
            (when keys (setq bits (%ilogior (%ilsl $lfbits-keys-bit 1) bits)))
            (when allow-other-keys-p (setq bits (%ilogior (%ilsl $lfbits-aok-bit 1) bits)))
            (when (%ilogbitp $fbitnextmethargsp (afunc-bits afunc))
              (if methodp
                (setq bits (%ilogior (%ilsl $lfbits-nextmeth-with-args-bit 1) bits))
                (let ((parent (afunc-parent afunc)))
                  (when parent
                    (setf (afunc-bits parent) (bitset $fbitnextmethargsp (afunc-bits parent)))))))
            (when methodp
              (setq bits (logior (ash 1 $lfbits-method-bit) bits))
              (when next-method-p
                (setq bits (logior (%ilsl $lfbits-nextmeth-bit 1) bits))))) 
          bits)))))


(defppc2 ppc2-progn progn (seg vreg xfer forms)
  (declare (list forms))
  (if (null forms)
    (ppc2-nil seg vreg xfer)
    (loop
      (let* ((form (pop forms)))
        (if forms
          (ppc2-form seg nil nil form)
          (return (ppc2-form seg vreg xfer form)))))))

#|
(defppc2 ppc2-prog1 prog1 (seg vreg xfer forms)
  (if (eq (list-length forms) 1)
    (ppc2-use-operator (%nx1-operator values) seg vreg xfer forms)
    (progn
      (if vreg
        (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg (pop forms) ppc::arg_z))
        (ppc2-form seg nil nil (pop forms)))
      (dolist (form forms)
        (ppc2-form seg nil nil form))
      (if vreg (ppc2-vpop-register seg vreg))
      (^))))
|#


(defppc2 ppc2-prog1 prog1 (seg vreg xfer forms)
  (if (eq (list-length forms) 1)
    (ppc2-use-operator (%nx1-operator values) seg vreg xfer forms)
    (if (null vreg)
      (ppc2-use-operator (%nx1-operator progn) seg vreg xfer forms)
      (let* ((float-p (= (ppc::hard-regspec-class vreg) ppc::hard-reg-class-fpr))
             (crf-p (= (ppc::hard-regspec-class vreg) ppc::hard-reg-class-crf))
             (node-p (unless (or float-p crf-p)
                       (= (ppc::get-regspec-mode vreg) ppc::hard-reg-class-gpr-mode-node)))
             (first (pop forms)))
        (ppc2-push-register seg 
                            (if (or node-p crf-p)
                              (ppc2-one-untargeted-reg-form seg first ppc::arg_z)
                              (ppc2-one-targeted-reg-form seg first vreg)))
        (dolist (form forms)
          (ppc2-form seg nil nil form))
        (if crf-p
          (progn
            (ppc2-vpop-register seg ppc::arg_z)
            (<- ppc::arg_z))
          (ppc2-pop-register seg vreg))
        (^)))))

(defppc2 ppc2-free-reference free-reference (seg vreg xfer sym)
  (ppc2-ref-symbol-value seg vreg xfer sym t))

(defppc2 ppc2-special-ref special-ref (seg vreg xfer sym)
  (ppc2-ref-symbol-value seg vreg xfer sym t))

(defppc2 ppc2-bound-special-ref bound-special-ref (seg vreg xfer sym)
  (ppc2-ref-symbol-value seg vreg xfer sym nil))

(defppc2 ppc2-%svref %svref (seg vreg xfer vector index)
  (ppc2-misc-node-ref seg vreg xfer vector index nil))

(defppc2 ppc2-svref svref (seg vreg xfer vector index)
  (ppc2-misc-node-ref seg vreg xfer vector index (unless *ppc2-reckless* ppc::subtag-simple-vector)))

;; It'd be nice if this didn't box the result.  Worse things happen ...
;;  Once there's a robust mechanism, adding a CHARCODE storage class shouldn't be hard.
(defppc2 ppc2-%sbchar %sbchar (seg vreg xfer string index)
  (ppc2-vref seg vreg xfer ppc::subtag-simple-base-string string index (unless *ppc2-reckless* ppc::subtag-simple-base-string)))

(defppc2 ppc2-%sechar %sechar (seg vreg xfer string index)
  (ppc2-vref seg vreg xfer ppc::subtag-simple-general-string string index (unless *ppc2-reckless* ppc::subtag-simple-general-string)))


(defppc2 ppc2-%svset %svset (seg vreg xfer vector index value)
  (ppc2-misc-node-set seg vreg xfer vector index value nil))

(defppc2 ppc2-svset svset (seg vreg xfer vector index value)
   (ppc2-misc-node-set seg vreg xfer vector index value (unless *ppc2-reckless* ppc::subtag-simple-vector)))

(defppc2 ppc2-typed-form typed-form (seg vreg xfer typespec form)
  (declare (ignore typespec)) ; Boy, do we ever !
  (ppc2-form seg vreg xfer form))

(defppc2 ppc2-%primitive %primitive (seg vreg xfer &rest ignore)
  (declare (ignore seg vreg xfer ignore))
  (error "You're probably losing big: using %primitive ..."))

(defppc2 ppc2-consp consp (seg vreg xfer cc form)
  (if (null vreg)
    (ppc2-form seg vreg xfer form)
    (let* ((tagreg ppc::imm0))
      (multiple-value-bind (cr-bit true-p) (68k-cc-to-ppc-cr-bit (ppc2-fixnum-form-p cc) nil)
        (! extract-fulltag tagreg (ppc2-one-untargeted-reg-form seg form ppc::arg_z))
        (ppc2-test-reg-%izerop seg vreg xfer tagreg cr-bit true-p ppc::fulltag-cons)))))
      

(defppc2 ppc2-cons cons (seg vreg xfer y z)
  (if (null vreg)
    (progn
      (ppc2-form seg nil nil y)
      (ppc2-form seg nil xfer z))
    (multiple-value-bind (yreg zreg) (ppc2-two-untargeted-reg-forms seg y ppc::arg_y z ppc::arg_z)
      (ensuring-node-target (target vreg)
        (! cons target yreg zreg))
      (^))))

(defppc2 ppc2-%rplaca %rplaca (seg vreg xfer ptr val)
  (ppc2-modify-cons seg vreg xfer ptr val nil nil t))

(defppc2 ppc2-%rplacd %rplacd (seg vreg xfer ptr val)
  (ppc2-modify-cons seg vreg xfer ptr val nil t t))

(defppc2 ppc2-rplaca rplaca (seg vreg xfer ptr val)
  (ppc2-modify-cons seg vreg xfer ptr val t nil t))

(defppc2 ppc2-set-car set-car (seg vreg xfer ptr val)
  (ppc2-modify-cons seg vreg xfer ptr val t nil nil))

(defppc2 ppc2-rplacd rplacd (seg vreg xfer ptr val)
  (ppc2-modify-cons seg vreg xfer ptr val t t t))

(defppc2 ppc2-set-cdr set-cdr (seg vreg xfer ptr val)
  (ppc2-modify-cons seg vreg xfer ptr val t t nil))

(defppc2 ppc2-%car %car (seg vreg xfer form)
  (ppc2-reference-list seg vreg xfer form nil nil))

(defppc2 ppc2-%cdr %cdr (seg vreg xfer form)
  (ppc2-reference-list seg vreg xfer form nil t))

(defppc2 ppc2-car car (seg vreg xfer form)
  (ppc2-reference-list seg vreg xfer form t nil))

(defppc2 ppc2-cdr cdr (seg vreg xfer form)
  (ppc2-reference-list seg vreg xfer form t t))

(defppc2 ppc2-vector vector (seg vreg xfer arglist)
  (ppc2-allocate-initialized-gvector seg vreg xfer ppc::subtag-simple-vector arglist))

;; If we can pick a constant subtype out of the arglist, do so and allocate it inline.
;; If it looks like a 68k subtag (or anything other than a ppc::fulltag-nodeheader
;; tag), warn and see if we can come up with a better guess.
;; Of course, it'd be nice if we could catch this at runtime as well.  I'd guess
;; that most calls to %gvector have constant subtype/subtag arguments.  We'll see.
(defppc2 ppc2-%ppc-gvector %ppc-gvector (seg vreg xfer arglist)
  (let* ((all-on-stack (append (car arglist) (reverse (cadr arglist))))
         (subtag-form (car all-on-stack))
         (subtag (ppc2-fixnum-form-p subtag-form)))
    (if (null vreg)
      (dolist (form all-on-stack (^)) (ppc2-form seg nil nil form))
      (if (null subtag)
        (progn                            ; Vpush everything and call subprim
          (let* ((*ppc2-vstack* *ppc2-vstack*)
                 (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*))
            (ppc2-set-nargs seg (ppc2-formlist seg all-on-stack nil))
            (! call-subprim .SPgvector))
          (<- ppc::arg_z)
          (^))
        (let* ((subtag-tag (logand subtag ppc::full-tag-mask)))
          (declare (fixnum subtag-tag))
          (unless (= subtag-tag ppc::fulltag-nodeheader)
            (let* ((newtag ppc::subtag-simple-vector))
              (warn "%gvector: subtag was ~d, using ~d instead" subtag newtag)
              (setq subtag newtag)))
          (ppc2-allocate-initialized-gvector seg vreg xfer subtag (cdr all-on-stack)))))))

;; Should be less eager to box result
(defppc2 ppc2-%char-code %char-code (seg vreg xfer c)
  (ppc2-extract-charcode seg vreg xfer c nil))

(defppc2 ppc2-char-code char-code (seg vreg xfer c)
  (ppc2-extract-charcode seg vreg xfer c (not (ppc2-form-typep c 'character))))

(defppc2 ppc2-%ilogior2 %ilogior2 (seg vreg xfer form1 form2)
  (let* ((fix1 (ppc2-fixnum-form-p form1))
         (fix2 (ppc2-fixnum-form-p form2)))
    (if (and fix1 fix2)
      (ppc2-use-operator (%nx1-operator fixnum) seg vreg xfer (logior fix1 fix2)))
    (let* ((fixval (or fix1 fix2))
           (unboxed-fixval (if fixval (ash fixval ppc::fixnumshift)))
           (high (if fixval (if (= unboxed-fixval (logand #xffff0000 unboxed-fixval)) (ash unboxed-fixval -16))))
           (low (if fixval (unless high (if (= unboxed-fixval (logand #x0000ffff unboxed-fixval)) unboxed-fixval))))
           (otherform (if (or high low) (if fix1 form2 form1))))
      (if otherform
        (let* ((other-reg (ppc2-one-untargeted-reg-form seg otherform ppc::arg_z)))
          (when vreg
            (ensuring-node-target (target vreg) 
              (if high
                (! logior-high target other-reg high)
                (! logior-low target other-reg low)))))
        (multiple-value-bind (r1 r2) (ppc2-two-untargeted-reg-forms seg form1 ppc::arg_y form2 ppc::arg_z)
          (if vreg (ensuring-node-target (target vreg) (! %logior2 target r1 r2)))))   
      (^))))

; in a lot of (typical ?) cases, it might be possible to use a rotate-and-mask instead
; of andi./andis.

(defppc2 ppc2-%ilogand2 %ilogand2 (seg vreg xfer form1 form2)
  (let* ((fix1 (ppc2-fixnum-form-p form1))
         (fix2 (ppc2-fixnum-form-p form2)))
    (if (and fix1 fix2)
      (ppc2-use-operator (%nx1-operator fixnum) seg vreg xfer (logand fix1 fix2)))
    (let* ((fixval (or fix1 fix2))
           (unboxed-fixval (if fixval (ash fixval ppc::fixnumshift)))
           (high (if fixval (if (= unboxed-fixval (logand #xffff0000 unboxed-fixval)) (ash unboxed-fixval -16))))
           (low (if fixval (unless high (if (= unboxed-fixval (logand #x0000ffff unboxed-fixval)) unboxed-fixval))))
           (otherform (if (or high low) (if fix1 form2 form1))))
      (if otherform
        (let* ((other-reg (ppc2-one-untargeted-reg-form seg otherform ppc::arg_z)))
          (when vreg
            (ensuring-node-target (target vreg) 
              (if high
                (! logand-high target other-reg high)
                (! logand-low target other-reg low)))))
        (multiple-value-bind (r1 r2) (ppc2-two-untargeted-reg-forms seg form1 ppc::arg_y form2 ppc::arg_z)
          (if vreg (ensuring-node-target (target vreg) (! %logand2 target r1 r2)))))
      (^))))

(defppc2 ppc2-%ilogxor2 %ilogxor2 (seg vreg xfer form1 form2)
  (let* ((fix1 (ppc2-fixnum-form-p form1))
         (fix2 (ppc2-fixnum-form-p form2)))
    (if (and fix1 fix2)
      (ppc2-use-operator (%nx1-operator fixnum) seg vreg xfer (logxor fix1 fix2)))
    (let* ((fixval (or fix1 fix2))
           (unboxed-fixval (if fixval (ash fixval ppc::fixnumshift)))
           (high (if fixval (if (= unboxed-fixval (logand #xffff0000 unboxed-fixval)) (ash unboxed-fixval -16))))
           (low (if fixval (unless high (if (= unboxed-fixval (logand #x0000ffff unboxed-fixval)) unboxed-fixval))))
           (otherform (if (or high low) (if fix1 form2 form1))))
      (if otherform
        (let* ((other-reg (ppc2-one-untargeted-reg-form seg otherform ppc::arg_z)))
          (when vreg
            (ensuring-node-target (target vreg) 
              (if high
                (! logxor-high target other-reg high)
                (! logxor-low target other-reg low)))))
        (multiple-value-bind (r1 r2) (ppc2-two-untargeted-reg-forms seg form1 ppc::arg_y form2 ppc::arg_z)
          (if vreg (ensuring-node-target (target vreg) (! %logxor2 vreg r1 r2)))))
      (^))))

(defppc2 ppc2-%ineg %ineg (seg vreg xfer n)
  (let* ((src (ppc2-one-untargeted-reg-form seg n ppc::arg_z)))
    (when vreg
      (ensuring-node-target (target vreg) 
        (! negate-fixnum target src)))
    (^)))

(defppc2 ppc2-%%ineg %%ineg (seg vreg xfer n)
  (let* ((src (ppc2-one-untargeted-reg-form seg n ppc::arg_z)))
    (when vreg
      (ensuring-node-target (target vreg) 
        (! negate-fixnum-no-ovf target src)))
    (^)))

(defppc2 ppc2-characterp characterp (seg vreg xfer cc form)
  (multiple-value-bind (cr-bit true-p) (68k-cc-to-ppc-cr-bit (ppc2-fixnum-form-p cc) nil)
    (! extract-lowbyte ppc::imm0 (ppc2-one-untargeted-reg-form seg form ppc::arg_z))
    (ppc2-test-reg-%izerop seg vreg xfer ppc::imm0 cr-bit true-p ppc::subtag-character)))

(defppc2 ppc2-struct-ref struct-ref (seg vreg xfer struct offset)
  (ppc2-misc-node-ref seg vreg xfer struct offset ppc::subtag-struct))

(defppc2 ppc2-struct-set struct-set (seg vreg xfer struct offset value)
  (ppc2-misc-node-set seg vreg xfer struct offset value ppc::subtag-struct))

(defppc2 ppc2-ppc-lisptag ppc-lisptag (seg vreg xfer node)
  (if (null vreg)
    (ppc2-form seg vreg xfer node)
    (progn
      (ensuring-node-target (target vreg) 
        (! extract-tag[fixnum] target (ppc2-one-untargeted-reg-form seg node ppc::arg_z)))
      (^))))

(defppc2 ppc2-ppc-fulltag ppc-fulltag (seg vreg xfer node)
  (if (null vreg)
    (ppc2-form seg vreg xfer node)
    (progn
      (ensuring-node-target (target vreg) 
        (! extract-fulltag[fixnum] target (ppc2-one-untargeted-reg-form seg node ppc::arg_z)))
      (^))))

(defppc2 ppc2-ppc-typecode ppc-typecode (seg vreg xfer node)
  (if (null vreg)
    (ppc2-form seg vreg xfer node)
    (let* ((reg (ppc2-one-untargeted-reg-form seg node (if (eq (ppc::hard-regspec-value vreg) ppc::arg_z) 
                                                         ppc::arg_y ppc::arg_z))))
      (ensuring-node-target (target vreg) 
        (! extract-typecode[fixnum] target reg ))
      (^))))

; Note that this goes through the whole MISC-NODE-SET mechanism.
; Among other things, that helps to ensure memoization.
(defppc2 ppc2-setq-special setq-special (seg vreg xfer sym val)
  (ppc2-misc-node-set seg 
                      vreg 
                      xfer 
                      (make-acode (%nx1-operator immediate) (ppc2-symbol-value-locative sym) )
                      (make-acode (%nx1-operator fixnum) ppc::symbol.vcell-cell) 
                      val
                      nil))

(defppc2 ppc2-local-go local-go (seg vreg xfer tag)
  (let* ((curstack (ppc2-encode-stack))
         (label (cadr tag))
         (deststack (caddr tag)))
    (if (not (ppc2-equal-encodings-p curstack deststack))
      (multiple-value-bind (catch cstack vstack)
                           (ppc2-decode-stack deststack)
        (ppc2-unwind-stack seg xfer catch cstack vstack)))
    (-> label)
    (ppc2-unreachable-store vreg)))

(defppc2 ppc2-local-block local-block (seg vreg xfer blocktag body)
  (let* ((curstack (ppc2-encode-stack))
         (compound (ppc2-cd-compound-p xfer))
         (mvpass-p (ppc2-mvpass-p xfer))
         (need-label (if xfer (or compound mvpass-p) t))
         end-of-block
         last-cd
         (dest (if (ppc2-crf-p vreg) ppc::arg_z vreg)))
    (if need-label
      (setq end-of-block (ppc2-get-next-label)))
    (setq last-cd (if need-label (%ilogior2 (if mvpass-p $ppc-mvpass-mask 0) end-of-block) xfer))
    (%rplaca blocktag (cons (cons dest last-cd) curstack))
    (if mvpass-p
      (ppc2-multiple-value-body seg body)
      (ppc2-form seg dest (if xfer last-cd) body))
    (when need-label
      (@ end-of-block)
      (if compound
        (<- dest))
      (ppc2-branch seg (%ilogand (%ilognot $ppc-mvpass-mask) (or xfer 0)) vreg))))

(defppc2 ppc2-%izerop %izerop (seg vreg xfer cc form)
  (multiple-value-bind (cr-bit true-p) (68k-cc-to-ppc-cr-bit (ppc2-fixnum-form-p cc) nil)
    (ppc2-test-%izerop seg vreg xfer form cr-bit true-p)))


(defppc2 ppc2-uvsize uvsize (seg vreg xfer v)
  (let* ((misc-reg (ppc2-one-untargeted-reg-form seg v ppc::arg_z)))
    (unless *ppc2-reckless* (! trap-unless-uvector misc-reg))
    (if vreg 
      (ensuring-node-target (target vreg)
        (! misc-element-count[fixnum] target misc-reg)))
    (^)))

(defppc2 ppc2-%ilsl %ilsl (seg vreg xfer form1 form2)
  (if (null vreg)
    (progn
      (ppc2-form seg nil nil form1)
      (ppc2-form seg nil xfer form2))
    (let* ((const (ppc2-fixnum-form-p form1)))
      (ensuring-node-target (target vreg)
        (if const
          (let* ((src (ppc2-one-untargeted-reg-form seg form2 ppc::arg_z)))
            (if (<= const 31)
              (! %ilsl-c target const src)
              (!  lwi target 0)))
          (multiple-value-bind (count src) (ppc2-two-untargeted-reg-forms seg form1 ppc::arg_y form2 ppc::arg_z)
            (! %ilsl target count src))))
      (^))))

(defppc2 ppc2-endp endp (seg vreg xfer cc form)
  (let* ((formreg (ppc2-one-untargeted-reg-form seg form ppc::arg_z)))
    (! trap-unless-list formreg)
    (multiple-value-bind (cr-bit true-p) (68k-cc-to-ppc-cr-bit (ppc2-fixnum-form-p cc) t)
      (ppc2-compare-registers seg vreg xfer formreg ppc::rnil cr-bit true-p))))


(defppc2 ppc2-%code-char %code-char (seg vreg xfer c)
  (if (null vreg)
    (ppc2-form seg nil xfer c)
    (progn
      (ensuring-node-target (target vreg)
        (! fixnum->char target (ppc2-one-untargeted-reg-form seg c ppc::arg_z)))
      (^))))

(defppc2 ppc2-%schar %schar (seg vreg xfer str idx)
  (multiple-value-bind (src unscaled-idx)
                       (ppc2-two-untargeted-reg-forms seg str ppc::arg_y idx ppc::arg_z)
    (if vreg
      (ensuring-node-target (target vreg)
        (! %schar target src unscaled-idx)))
    (^)))

(defppc2 ppc2-%set-schar %set-schar (seg vreg xfer str idx char)
  (multiple-value-bind (src unscaled-idx char)
                       (ppc2-three-untargeted-reg-forms seg str ppc::arg_x idx ppc::arg_y
                                                        char ppc::arg_z)
    (! %set-schar  src unscaled-idx char)
    (when vreg (<- char)) 
    (^)))

(defppc2 ppc2-%set-scharcode %set-scharcode (seg vreg xfer str idx char)
  (multiple-value-bind (src unscaled-idx char)
                       (ppc2-three-untargeted-reg-forms seg str ppc::arg_x idx ppc::arg_y
                                                        char ppc::arg_z)
    (! %set-scharcode  src unscaled-idx char)
    (when vreg (<- char)) 
    (^)))

(defppc2 ppc2-%scharcode %scharcode (seg vreg xfer str idx)
  (multiple-value-bind (src unscaled-idx)
                       (ppc2-two-untargeted-reg-forms seg str ppc::arg_y idx ppc::arg_z)
    (if vreg
      (ensuring-node-target (target vreg)
        (! %scharcode target src unscaled-idx)))
    (^)))

      

(defppc2 ppc2-code-char code-char (seg vreg xfer c)
  (let* ((reg (ppc2-one-untargeted-reg-form seg c ppc::arg_z)))
    (! require-u16 reg)                 ; Typecheck even if result unused.
    (if vreg
      (ensuring-node-target (target vreg)
        (! fixnum->char target reg)))
    (^)))

(defppc2 ppc2-eq eq (seg vreg xfer cc form1 form2)
  (multiple-value-bind (cr-bit true-p) (68k-cc-to-ppc-cr-bit (ppc2-fixnum-form-p cc) t)
    (ppc2-compare seg vreg xfer form1 form2 cr-bit true-p)))

(defppc2 ppc2-neq neq (seg vreg xfer cc form1 form2)
  (multiple-value-bind (cr-bit true-p) (68k-cc-to-ppc-cr-bit (ppc2-fixnum-form-p cc) t)
    (ppc2-compare seg vreg xfer form1 form2 cr-bit true-p)))

(defppc2 ppc2-embedded-non-local-lexit embedded-nlexit (seg vreg xfer form)
  (ppc2-form seg vreg xfer form))

(defppc2 ppc2-embedded-call embedded-call (seg vreg xfer form)
  (ppc2-form seg vreg xfer form))

(defppc2 ppc2-%word-to-int %word-to-int (seg vreg xfer form)
  (if (null vreg)
    (ppc2-form seg nil xfer form)
    (progn
      (ensuring-node-target (target vreg)
        (! sign-extend-halfword target (ppc2-one-untargeted-reg-form seg form ppc::arg_z)))
      (^))))

(defppc2 ppc2-multiple-value-list multiple-value-list (seg vreg xfer form)
  (ppc2-multiple-value-body seg form)
  (! call-subprim .SPconslist)
  (when vreg
    (<- ppc::arg_z))
  (^))

(defppc2 ppc2-immform immediate (seg vreg xfer form)
  (ppc2-immediate seg vreg xfer form))

(defppc2 ppc2-lexical-reference lexical-reference (seg vreg xfer varnode)
  (let* ((ea-or-form (var-ea varnode)))
    (if (and (ppc2-punted-var-p varnode) (not (fixnump ea-or-form)))
      (ppc2-form seg vreg xfer ea-or-form)
      (let* ((cell (ppc2-lookup-var-cell varnode)))
        (if (and cell (typep cell 'lcell))
          (if (ppc2-ensure-lcell-offset cell (logand ea-or-form #xffff))
            (and nil (format t "~& could use cell ~s for var ~s" cell (var-name varnode)))
            (if (logbitp ppc2-debug-verbose-bit *ppc2-debug-mask*)
              (break "wrong ea for lcell for var ~s: got ~d, expected ~d" 
                     (var-name varnode) (calc-lcell-offset cell) (logand ea-or-form #xffff))))
          (if (not cell)
            (when (ppc::memory-spec-p ea-or-form)
              (if (logbitp ppc2-debug-verbose-bit *ppc2-debug-mask*)
                (format t "~& no lcell for ~s." (var-name varnode))))))
        
        (unless (fixnump ea-or-form)
          (break "bogus ref to var ~s (~s) : ~s " varnode (var-name varnode) ea-or-form))
        (ppc2-do-lexical-reference seg vreg ea-or-form)
        (^)))))

(defppc2 ppc2-setq-lexical setq-lexical (seg vreg xfer varspec form)
  (let* ((ea (var-ea varspec)))
    (unless (fixnump ea) (break "setq lexical is losing BIG"))
    (let* ((valreg (ppc2-one-untargeted-reg-form seg form (if (and (ppc::register-spec-p ea) 
                                                                   (or (null vreg) (eq ea vreg)))
                                                            ea
                                                            ppc::arg_z))))
      (ppc2-do-lexical-setq seg vreg ea valreg))
    (^)))

(defppc2 ppc2-fixnum fixnum (seg vreg xfer value)
  (if (null vreg)
    (^)
    (let* ((class (ppc::hard-regspec-class vreg))
           (unboxed (if (= class ppc::hard-reg-class-gpr)
                      (not (= ppc::hard-reg-class-gpr-mode-node (ppc::get-regspec-mode vreg))))))
      (if unboxed
        (ppc2-absolute-long seg vreg xfer value)
        (if (= class ppc::hard-reg-class-crf)
          (progn
            ;(break "Would have clobbered a GPR!")
            (ppc2-branch seg (ppc2-cd-true xfer) nil))
          (progn
            (ensuring-node-target (target vreg)
              (ppc2-absolute-long seg target nil (ash value ppc::fixnumshift)))
            (^)))))))

(defppc2 ppc2-%ilogbitp %ilogbitp (seg vreg xfer cc bitnum form)
  (if (null vreg)
    (progn
      (ppc2-form seg nil nil bitnum)
      (ppc2-form seg vreg xfer form))
    (multiple-value-bind (cr-bit true-p) (68k-cc-to-ppc-cr-bit (ppc2-fixnum-form-p cc) t)
      (let* ((fixbit (ppc2-fixnum-form-p bitnum)))
        (if fixbit
          (let* ((reg (ppc2-one-untargeted-reg-form seg form ppc::arg_z))
                 (ppc-bit (- 31 (max (min (+ fixbit ppc::fixnumshift) 31) ppc::fixnumshift))))
            (with-imm-temps () (bitreg)
              (! extract-constant-ppc-bit bitreg reg ppc-bit)
              (regspec-crf-gpr-case 
               (vreg dest)
               (progn
                 (! compare-signed-s16const dest bitreg 0)
                 (^ cr-bit true-p))
               (progn
                 (if true-p
                   (! invert-bit31 bitreg))
                 (ensuring-node-target (target dest)
                   (! bit31->truth target bitreg))
                 (^)))))
          (multiple-value-bind (rbit rform) (ppc2-two-untargeted-reg-forms seg bitnum ppc::arg_y form ppc::arg_z)
             (with-imm-temps () (bitreg)
               (! extract-variable-non-insane-bit bitreg rform rbit)
               (regspec-crf-gpr-case 
               (vreg dest)
               (progn
                 (! compare-signed-s16const dest bitreg 0)
                 (^ cr-bit true-p))
               (progn
                 (if true-p
                   (! invert-bit31 bitreg))
                 (ensuring-node-target (target dest)
                   (! bit31->truth target bitreg))
                 (^))))))))))

(defppc2 ppc2-uvref uvref (seg vreg xfer vector index)
  (ppc2-two-targeted-reg-forms seg vector ppc::arg_y index ppc::arg_z)
  (! call-subprim .SPmisc-ref)
  (<- ppc::arg_z)
  (^))

(defppc2 ppc2-uvset uvset (seg vreg xfer vector index value)
  (ppc2-three-targeted-reg-forms seg vector ppc::arg_x index ppc::arg_y value ppc::arg_z)
  (! call-subprim .SPmisc-set)
  (<- ppc::arg_z)
  (^))

(defppc2 ppc2-%typed-2d-float-aref %typed-2d-float-aref (seg vreg xfer subtag array idx-0 idx-1)
  (let* ((fixtype (ppc2-fixnum-form-p subtag)))
    (if fixtype
      (ppc2-2d-aref seg vreg xfer fixtype array idx-0 idx-1 (unless *ppc2-reckless* fixtype))
      (error "Shouldn't happen"))))

(defppc2 ppc2-%typed-2d-float-aset %typed-2d-float-aset (seg vreg xfer subtag array idx-0 idx-1 value)
  (let* ((fixtype (ppc2-fixnum-form-p subtag)))
    (if fixtype
      (ppc2-2d-aset seg vreg xfer fixtype array idx-0 idx-1 value (unless *ppc2-reckless* fixtype))
      (error "Shouldn't happen"))))

(defppc2 ppc2-%decls-body %decls-body (seg vreg xfer form p2decls)
  (with-ppc-p2-declarations p2decls
    (ppc2-form seg vreg xfer form)))

; We do things differently than the 68K port did.  Among other things,
; we don't need to (half-)word-align the stack frame, so we don't care
; about "argwords"; we also reserve space for the UPP that's eventually
; going to wind up as the first C arg and the procinfo word that'll wind
; up as the second.  We also evaluate things right into a C frame that
; we allocate, so we can pretty much spit things out in order.
; This expects things to follow either #$kPascalStackBased or 
; #$kD0DispatchedPascalStackBased conventions, though the "trap"
; case of ff-call-gen-trap should be able to handle whatever CallUniversalProc
; can using very similar code.

(defppc2 ppc2-%stack-trap %stack-trap (seg vreg xfer trapnum bits argwords argbits forms)
  (declare (ignore argwords argbits))
  (let* ((*ppc2-cstack* *ppc2-cstack*)
         (*ppc2-vstack* *ppc2-vstack*)
         (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*)
         (nforms (length forms))
         (procinfo (dpb (if (logbitp 2 bits)
                          (if (or (eq bits #b100)
                                  (eq bits #b101))
                            #$kFourByteCode
                            #$kTwoByteCode)
                          #$kNoByteCode)
                        (byte #$kResultSizeWidth #$kResultSizePhase) #$kPascalStackBased))
          (paramoffset #$kDispatchedSelectorSizePhase)
         (nextarg 2))
    (declare (fixnum paramoffset nextarg))
    (! alloc-c-frame (+ 2 nforms))      ; space for UPP address, procinfo.
    (ppc2-open-undo $undo-ppc-c-frame)
    ; First, we have to check to see if we have a d0-based selector.  If so, I -guess- that
    ; it gets passed before any of the stack-based args do (after the UPP and the procinfo.)
    (dolist (form forms)
      (let ((op (acode-operator form)))
        (if (or (eq op (%nx1-operator strap-selector-save))
                (eq op (%nx1-operator strap-selector-last)))
          (progn
            (setq procinfo (dpb #$kD0DispatchedPascalStackBased 
                                (byte #$kCallingConventionWidth #$kCallingConventionPhase)
                                procinfo)
                  paramoffset (+ #$kDispatchedSelectorSizePhase #$kDispatchedSelectorSizeWidth)
                  nextarg 3)))))
    ; Now, back through the list putting parameters in the right place and 
    ; setting procinfo.
    (dolist (form forms)
      (let* ((op (acode-operator form)))
        (if (or (eq op (%nx1-operator strap-selector-save))
                (eq op (%nx1-operator strap-selector-last)))
          (progn
            (setq procinfo (dpb #$kTwoByteCode (byte #$kDispatchedSelectorSizeWidth #$kDispatchedSelectorSizePhase) procinfo))
            (! set-c-arg (ppc2-unboxed-integer-arg-to-reg seg (%cadr form) ppc::imm0) 2))
          (let* ((pointer-p (eq op (%nx1-operator spushp)))
                 (long-p (eq op (%nx1-operator spushl))))
            (setq procinfo (dpb (if (or pointer-p long-p) #$kFourByteCode #$kTwoByteCode)
                                (byte #$kStackParameterWidth paramoffset)
                                procinfo))
            (! set-c-arg
               (if pointer-p
                 (with-imm-target () (target :address)
                   (ppc2-one-targeted-reg-form seg (%cadr form) target))
                 (with-imm-target () (target :u32)    ; a lie
                   (ppc2-unboxed-integer-arg-to-reg seg (%cadr form) target)))
               nextarg)
            (incf nextarg)
            (incf paramoffset #$kStackParameterWidth)))))
    (ppc2-lwi seg ppc::imm0 procinfo)
    (! set-c-arg ppc::imm0 1)
    ; We never set c-arg 0, but do need to load the (boxed) trap number into arg_z.
    (ppc2-lwi seg ppc::arg_z (ash (logand trapnum #x3ff) ppc::fixnumshift))
    (! call-subprim .SPstrap)
    (ppc2-close-undo)
    (if (not (%ilogbitp 2 bits))
      (ppc2-nil seg vreg xfer)
      (progn
        (when vreg
         (<- (ppc::set-regspec-mode 
               ppc::imm0
             (ppc-gpr-mode-name-value
              (if (eq bits #b100)
                :address
                (if (eq bits #b101)
                  :s32
                  :s16))))))
        (^)))))

(defppc2 ppc2-%err-disp %err-disp (seg vreg xfer arglist)
  (ppc2-set-nargs seg (ppc2-arglist seg arglist))
  (! call-subprim .SPksignalerr)
  (ppc2-nil seg vreg xfer))

(defppc2 ppc2-newblocktag newblocktag (seg vreg xfer)
  (when vreg
    (! call-subprim .SPnewblocktag)
    (<- ppc::arg_z))
  (^))

(defppc2 ppc2-newgotag newgotag (seg vreg xfer)
  (when vreg
    (! call-subprim .SPnewgotag)
    (<- ppc::arg_z))
  (^))

(defppc2 ppc2-symbol-name symbol-name (seg vreg xfer sym)
  (let* ((reg (ppc2-one-targeted-reg-form seg sym ppc::arg_z)))
    (unless *ppc2-reckless*
      (! trap-unless-typecode= reg ppc::subtag-symbol))
    (when vreg
      (ensuring-node-target (target vreg)
        (! misc-ref-c-node target reg ppc::symbol.pname-cell)))
    (^)))

(defppc2 ppc2-local-tagbody local-tagbody (seg vreg xfer taglist body)
  (let* ((encstack (ppc2-encode-stack))
         (tagop (%nx1-operator tag-label)))
    (dolist (tag taglist)
      (rplacd tag (cons (ppc2-get-next-label) (cons encstack (cadr (cddr (cddr tag)))))))
    ; Check to see if tags referenced by backward branches will
    ; "obviously" do an eventcheck (via function call or otherwise)
    ; after they're branched to.
    ; The annotations produced by pass 1 are conservative; if we want to
    ; try walking the forms, we might do a better job.
    (let* ((forms body)
           (tag nil)
           (form nil))
      (while forms
        (setq form (pop forms))
        (if (and (eq (acode-operator form) tagop)
                 (cddr (setq tag (cddr form)))
                 (dolist (after forms)
                   (let ((op (acode-operator after)))
                     (when (or (eq op (%nx1-operator embedded-call))
                               ;; Do branches back to our
                               ;; tag branch back to another tag which is branched back to?
                               (and (eq op tagop)
                                    (cddr (cddr after))))
                       ;(format t "~&win one,")
                       (return t))  ;No gratuitous eventcheck here.
                     (when (eq op (%nx1-operator embedded-nlexit))
                       ;; Punt for now. 
                       ;(format t "~&lose one.")
                       (return nil)))))
          (rplacd (cdr tag) nil))))
    (dolist (form body)
      (if (eq (acode-operator form) tagop)
        (let ((tag (cddr form)))
          (@ (car tag))
          (when (cddr tag) (ppc2-emit-event-poll seg)))
        (ppc2-form seg nil nil form)))
    (ppc2-nil seg vreg xfer)))

(defppc2 ppc2-call call (seg vreg xfer fn arglist &optional spread-p)
  (ppc2-call-fn seg vreg xfer fn arglist spread-p))

(defppc2 ppc2-self-call self-call (seg vreg xfer arglist &optional spread-p)
  (setq arglist (ppc2-augment-arglist *ppc2-cur-afunc* arglist (if spread-p 1 $numppcargregs)))
  (ppc2-call-fn seg vreg xfer -1 arglist spread-p))


(defppc2 ppc2-lexical-function-call lexical-function-call (seg vreg xfer afunc arglist &optional spread-p)
  (ppc2-call-fn seg vreg xfer (list (%nx1-operator simple-function) afunc)
                (ppc2-augment-arglist afunc arglist (if spread-p 1 $numppcargregs))
                spread-p))

(defppc2 ppc2-builtin-call builtin-call (seg vreg xfer index arglist)
  (let* ((nargs (ppc2-arglist seg arglist))
         (tail-p (and (ppc2-tailcallok xfer) (<= nargs $numppcargregs)))
         (idx (ppc2-fixnum-form-p index))
         (idx-subprim (ppc2-builtin-index-subprim idx))
         (subprim
          (or idx-subprim
              (case nargs
                (0 .SPcallbuiltin0)
                (1 .SPcallbuiltin1)
                (2 .SPcallbuiltin2)
                (3 .SPcallbuiltin3)
                (t .SPcallbuiltin)))))
    (when tail-p
      (ppc2-restore-nvrs seg *ppc2-register-restore-ea* *ppc2-register-restore-count*)
      (ppc2-restore-full-lisp-context seg))
    (unless idx-subprim
      (! lwi ppc::imm0 (ash idx ppc::fixnumshift))
      (when (eql subprim .SPcallbuiltin)
        (ppc2-set-nargs seg nargs)))
    (if tail-p
      (! jump-subprim subprim)
      (progn
        (! call-subprim subprim)
        (<- ppc::arg_z)
        (^)))))
      

(defppc2 ppc2-if if (seg vreg xfer testform true false)
  (if (nx-constant-form-p (ppc2-unwrapped-form testform))
    (ppc2-form seg vreg xfer (if (nx-null (ppc2-unwrapped-form testform)) false true))
    (let* ((cstack *ppc2-cstack*)
           (vstack *ppc2-vstack*)
           (top-lcell *ppc2-top-vstack-lcell*)
           (entry-stack (ppc2-encode-stack))
           (true-stack nil)
           (false-stack nil)
           (true-cleanup-label nil)
           (same-stack-effects nil)
           (true-is-goto (ppc2-go-label true))
           (false-is-goto (and (not true-is-goto) (ppc2-go-label false)))
           (endlabel (ppc2-get-next-label))
           (falselabel (ppc2-get-next-label))
           (need-else (unless false-is-goto (or (not (nx-null false)) (ppc2-for-value-p vreg))))
           (both-single-valued (and (not *ppc2-open-code-inline*)
                                    (eq xfer $ppc-return)
                                    (ppc2-for-value-p vreg)
                                    need-else
                                    (ppc2-single-valued-form-p true) 
                                    (ppc2-single-valued-form-p false))))
      (if (eq 0 xfer) 
        (setq xfer nil))
      (if both-single-valued            ; it's implied that we're returning
        (progn
          (let ((merge-else-branch-label (if (nx-null false) (ppc2-find-nilret-label))))
            (ppc2-conditional-form seg (ppc2-make-compound-cd 0 falselabel) testform)
            (ppc2-form seg ppc::arg_z endlabel true)
            (if (and merge-else-branch-label (neq -1 (aref *ppc2-labels* merge-else-branch-label)))
              (ppc2-copy-label merge-else-branch-label falselabel)
              (progn
                (@ falselabel)
                (if (nx-null false) (@ (ppc2-record-nilret-label)))
                (ppc2-form seg ppc::arg_z nil false)))
            (@ endlabel)
            (<- ppc::arg_z)
            (^)))
        (progn
          (if (and need-else (ppc2-mvpass-p xfer))
            (setq true-cleanup-label (ppc2-get-next-label)))         
          (ppc2-conditional-form 
           seg
           (ppc2-make-compound-cd 
            (or true-is-goto 0)
            (or false-is-goto 
                (if need-else 
                  (if true-is-goto 0 falselabel) 
                  (if true-is-goto xfer (ppc2-cd-merge xfer falselabel))))) 
           testform)  
          (if true-is-goto
            (ppc2-unreachable-store)
            (if true-cleanup-label
              (progn
                (ppc2-open-undo $undomvexpect)
                (ppc2-form seg vreg (%ilogior2 $ppc-mvpass-mask true-cleanup-label) true))
              (ppc2-form seg vreg (if need-else (ppc2-cd-merge xfer endlabel) xfer) true)))
          (setq true-stack (ppc2-encode-stack))
          (setq *ppc2-cstack* cstack)
          (ppc2-set-vstack vstack)
          (setq *ppc2-top-vstack-lcell* top-lcell)
          (if false-is-goto (ppc2-unreachable-store))
          (let ((merge-else-branch-label (if (and (nx-null false) (eq xfer $ppc-return)) (ppc2-find-nilret-label))))
            (if (and merge-else-branch-label (neq -1 (aref *ppc2-labels* merge-else-branch-label)))
              (ppc2-copy-label merge-else-branch-label falselabel)
              (progn
                (@ falselabel)
                (when need-else
                  (if true-cleanup-label
                    (ppc2-mvpass seg false)
                    (ppc2-form seg vreg xfer false))
                  (setq false-stack (ppc2-encode-stack))))))
          (when true-cleanup-label
            (if (setq same-stack-effects (ppc2-equal-encodings-p true-stack false-stack)) ; can share cleanup code
              (@ true-cleanup-label))
            (let* ((*ppc2-returning-values* :pass))
              (ppc2-nlexit seg xfer 1)
              (ppc2-branch seg (if (and xfer (neq xfer $ppc-mvpass-mask)) xfer (if (not same-stack-effects) endlabel)) vreg))
            (unless same-stack-effects
              (@ true-cleanup-label)
              (multiple-value-setq (true *ppc2-cstack* *ppc2-vstack* *ppc2-top-vstack-lcell*)
                (ppc2-decode-stack true-stack))
              (let* ((*ppc2-returning-values* :pass))
                (ppc2-nlexit seg xfer 1)
                (^)))
            (ppc2-close-undo)
            (multiple-value-setq (*ppc2-undo-count* *ppc2-cstack* *ppc2-vstack* *ppc2-top-vstack-lcell*) 
              (ppc2-decode-stack entry-stack)))
          (@ endlabel))))))

(defppc2 ppc2-or or (seg vreg xfer forms)
  (let* ((mvpass (ppc2-mvpass-p xfer))
         (tag1 (ppc2-get-next-label))
         (tag2 (ppc2-get-next-label))
         (vstack *ppc2-vstack*)
         (cstack *ppc2-cstack*)
         (dest (if (ppc2-crf-p vreg) vreg (if vreg ppc::arg_z (ppc-available-crf-temp *ppc-crf-temps*))))
         (cd1 (ppc2-make-compound-cd 
               (if (eq dest ppc::arg_z) tag1 (ppc2-cd-merge (ppc2-cd-true xfer) tag1)) 0)))
    (while (cdr forms)
      (ppc2-form seg dest (if (eq dest ppc::arg_z) nil cd1) (car forms))
      (when (eq dest ppc::arg_z)
        (with-crf-target () val-crf
          (ppc2-copy-register seg val-crf dest)
          (ppc2-branch seg cd1 val-crf)))
      (setq forms (%cdr forms)))
    (if mvpass
      (progn (ppc2-multiple-value-body seg (car forms)) 
             (let* ((*ppc2-returning-values* t)) (ppc2-branch seg (ppc2-cd-merge xfer tag2) vreg)))
      (ppc2-form seg  vreg (if (eq dest ppc::arg_z) (ppc2-cd-merge xfer tag2) xfer) (car forms)))
    (setq *ppc2-vstack* vstack *ppc2-cstack* cstack)
    (@ tag1)
    (when (eq dest ppc::arg_z)
      (<- ppc::arg_z)
      (^))
    (@ tag2)))

(defppc2 ppc2-simple-function simple-function (seg vreg xfer afunc)
  (ppc2-immediate seg vreg xfer (ppc2-afunc-lfun-ref afunc)))

(defppc2 ppc2-list list (seg vreg xfer arglist)
  (if (null vreg)
    (dolist (form arglist)
      (ppc2-form seg vreg nil form)) 
    (let* ((*ppc2-vstack* *ppc2-vstack*)
           (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*)
           (nargs (ppc2-formlist seg arglist nil)))
      (ppc2-set-nargs seg nargs)
      (! call-subprim .SPconslist)
      (<- ppc::arg_z)))
  (^))

(defppc2 ppc2-list* list* (seg vreg xfer arglist)
  (if (null vreg)
    (dolist (arg (apply #'append arglist))
      (ppc2-form seg nil nil arg))
    (let* ((*ppc2-vstack* *ppc2-vstack*)
           (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*)
           (nargs (ppc2-arglist seg arglist)))
      (declare (fixnum args))
      (when (> nargs 1)
        (ppc2-set-nargs seg (1- nargs))
        (! call-subprim .SPconslist-star))
      (<- ppc::arg_z)))
  (^))

(defppc2 ppc2-minus1 minus1 (seg vreg xfer form)
  (ppc2-unary-builtin seg vreg xfer '%negate form))

(defppc2 ppc2-add2 add2 (seg vreg xfer form1 form2)
  (ppc2-binary-builtin seg vreg xfer '+-2 form1 form2))

(defppc2 ppc2-logbitp logbitp (seg vreg xfer bitnum int)
  (ppc2-binary-builtin seg vreg xfer 'logbitp bitnum int))

(defppc2 ppc2-logior2 logior2 (seg vreg xfer form1 form2)
  (ppc2-binary-builtin seg vreg xfer 'logior-2 form1 form2))

(defppc2 ppc2-logxor2 logxor2 (seg vreg xfer form1 form2)
  (ppc2-binary-builtin seg vreg xfer 'logxor-2 form1 form2))

(defppc2 ppc2-logand2 logand2 (seg vreg xfer form1 form2)
  (ppc2-binary-builtin seg vreg xfer 'logand-2 form1 form2))

(defppc2 ppc2-%quo2 %quo2 (seg vreg xfer form1 form2)
  (ppc2-binary-builtin seg vreg xfer '/-2 form1 form2))

(defppc2 ppc2-%aref1 %aref1 (seg vreg xfer v i)
  (ppc2-binary-builtin seg vreg xfer '%aref1 v i))

(defppc2 ppc2-%aset1 aset1 (seg vreg xfer v i n)
  (ppc2-ternary-builtin seg vreg xfer '%aset1 v i n))

(defppc2 ppc2-%i+ %i+ (seg vreg xfer form1 form2 &optional overflow)
  (cond ((null vreg) 
         (ppc2-form seg nil nil form1) 
         (ppc2-form seg nil xfer form2))
        (overflow
         (multiple-value-bind (r1 r2) (ppc2-two-untargeted-reg-forms seg form1 ppc::arg_y form2 ppc::arg_z)
           (ensuring-node-target (target vreg)
             (! fixnum-add-overflow target r1 r2))
           (^)))
        (t                              
         ; There isn't any "addi" that checks for overflow, which is why we didn't bother.
         (let* ((fix1 (ppc2-fixnum-form-p form1))
                (fix2 (ppc2-fixnum-form-p form2))
                (other (if fix1 form2 (if fix2 form1))))
           (if (and fix1 fix2)
             (ppc2-lwi seg vreg (ash (+ fix1 fix2) ppc::fixnumshift))
             (if other
               (let* ((constant (ash (or fix1 fix2) ppc::fixnumshift))
                      (reg (ppc2-one-untargeted-reg-form seg other ppc::arg_z))
                      (high (ldb (byte 16 16) constant))
                      (low (ldb (byte 16 0) constant)))
                 (declare (fixnum high low))
                 (if (zerop constant)
                   (<- reg)
                   (progn
                     (if (logbitp 15 low) (setq high (ldb (byte 16 0) (1+ high))))
                     (if (and (eq vreg reg) (not (zerop high)))
                       (with-node-temps (vreg) (temp)
                         (! add-immediate temp reg high low)
                         (<- temp))
                       (ensuring-node-target (target vreg)
                         (! add-immediate target reg high low))))))
               (multiple-value-bind (r1 r2) (ppc2-two-untargeted-reg-forms seg form1 ppc::arg_y form2 ppc::arg_z)
                 (ensuring-node-target (target vreg)
                   (! fixnum-add target r1 r2)))))
           (^)))))

(defppc2 ppc2-%i- %i- (seg vreg xfer num1 num2 &optional overflow)
  (let* ((v1 (ppc2-fixnum-form-p num1))
         (v2 (ppc2-fixnum-form-p num2)))
    (if (and v1 v2)
      (ppc2-use-operator (%nx1-operator fixnum) seg vreg xfer (%i- v1 v2))
      (if (and v2  (neq v2 most-negative-fixnum))
        (ppc2-use-operator (%nx1-operator %i+) seg vreg xfer num1 (make-acode (%nx1-operator fixnum) (- v2)) overflow) 
        (if (eq v2 0)
          (ppc2-form seg vreg xfer num1)
          (cond
           ((null vreg)
            (ppc2-form seg nil nil num1)
            (ppc2-form seg nil xfer num2))
           (overflow
            (multiple-value-bind (r1 r2) (ppc2-two-untargeted-reg-forms seg num1 ppc::arg_y num2 ppc::arg_z)
               (ensuring-node-target (target vreg)
                 (! fixnum-sub-overflow target r1 r2))
              (^)))
           ((and v1 (<= (integer-length v1) (- 15 ppc::fixnumshift)))
            (ensuring-node-target (target vreg)
              (! fixnum-sub-from-constant target v1 (ppc2-one-untargeted-reg-form seg num2 ppc::arg_z)))
            (^))
           (t
            (multiple-value-bind (r1 r2) (ppc2-two-untargeted-reg-forms seg num1 ppc::arg_y num2 ppc::arg_z)
              (ensuring-node-target (target vreg)
                (! fixnum-sub target r1 r2))
              (^)))))))))

(defppc2 ppc2-%i* %i* (seg vreg xfer num1 num2)
  (if (null vreg)
    (progn
      (ppc2-form seg nil nil num1)
      (ppc2-form seg nil xfer num2))  
    (let* ((fix1 (ppc2-fixnum-form-p num1))
           (fix2 (ppc2-fixnum-form-p num2))
           (other (if (typep fix1 '(signed-byte 16)) num2 (if (typep fix2 '(signed-byte 16)) num1))))
      (if (and fix1 fix2)
        (ppc2-lwi seg vreg (ash (* fix1 fix2) ppc::fixnumshift))
        (if other
          (ensuring-node-target (target vreg)  ;; added this ??? - 08/12/01
            (! multiply-immediate target (ppc2-one-untargeted-reg-form seg other ppc::arg_z) (or fix1 fix2)))
          (multiple-value-bind (rx ry) (ppc2-two-untargeted-reg-forms seg num1 ppc::arg_y num2 ppc::arg_z)
            (ensuring-node-target (target vreg)
              (! multiply-fixnums target rx ry)))))
      (^))))

(defppc2 ppc2-nth-value nth-value (seg vreg xfer n form)
  (let* ((*ppc2-vstack* *ppc2-vstack*)
         (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*))
    (let* ((nreg (ppc2-one-untargeted-reg-form seg n ppc::arg_z)))
      (unless (ppc2-fixnum-form-p n)
        (! trap-unless-fixnum nreg))
      (ppc2-vpush-register seg nreg))
     (ppc2-multiple-value-body seg form) ; sets nargs
    (! call-subprim .SPnthvalue))
  (<- ppc::arg_z)
  (^))

(defppc2 ppc2-values values (seg vreg xfer forms)
  (if (eq (list-length forms) 1)
    (if (ppc2-cd-compound-p xfer)
      (ppc2-form seg vreg xfer (%car forms))
      (progn
        (ppc2-form seg vreg nil (%car forms))
        (^)))
    (if (not (ppc2-mv-p xfer))
      (if forms
        (ppc2-use-operator (%nx1-operator prog1) seg vreg xfer forms)
        (ppc2-nil seg vreg xfer))
      (progn
        (let* ((*ppc2-vstack* *ppc2-vstack*)
               (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*))
          (ppc2-set-nargs seg (ppc2-formlist seg forms nil)))
        (let* ((*ppc2-returning-values* t))
          (^))))))

(defppc2 ppc2-base-character-p base-character-p (seg vreg xfer cc form)
  (multiple-value-bind (cr-bit true-p) (68k-cc-to-ppc-cr-bit (ppc2-fixnum-form-p cc) t)
    (! mask-base-character ppc::imm0 (ppc2-one-untargeted-reg-form seg form ppc::arg_z))
    (ppc2-test-reg-%izerop seg vreg xfer ppc::imm0 cr-bit true-p ppc::subtag-character)))

(defppc2 ppc2-let* let* (seg vreg xfer vars vals body p2decls &aux
                             (old-stack (ppc2-encode-stack)))
  (ppc2-check-lcell-depth)
  (with-ppc-p2-declarations p2decls
    (ppc2-seq-bind seg vars vals)
    (ppc2-undo-body seg vreg xfer body old-stack))
  (dolist (v vars) (ppc2-close-var seg v)))

(defppc2 ppc2-multiple-value-bind multiple-value-bind (seg vreg xfer vars valform body p2decls)
  (let* ((n (list-length vars))
         (vloc *ppc2-vstack*)
         (nbytes (%ilsl 2 n))
         (old-stack (ppc2-encode-stack)))
    (with-ppc-p2-declarations p2decls
      (ppc2-multiple-value-body seg valform)
      (ppc2-lwi seg ppc::imm0 nbytes)
      (! call-subprim .SPfitvals)
      (ppc2-set-vstack (%i+ vloc nbytes))
      (let* ((old-top *ppc2-top-vstack-lcell*)
             (lcells (progn (ppc2-reserve-vstack-lcells n) (ppc2-collect-lcells :reserved old-top))))
        (dolist (var vars)
          (ppc2-bind-var seg var vloc (pop lcells))
          (setq vloc (%i+ vloc 4))))
      (ppc2-undo-body seg vreg xfer body old-stack)
      (dolist (var vars)
        (ppc2-close-var seg var)))))

(defppc2 ppc2-debind debind (seg vreg xfer lambda-list bindform req opt rest keys auxen whole body p2decls cdr-p)
  (declare (ignore lambda-list))
  (let* ((old-stack (ppc2-encode-stack))
         (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*)
         (vloc *ppc2-vstack*))
    (with-ppc-p2-declarations p2decls      
      (ppc2-bind-structured-lambda seg 
                                   (ppc2-spread-lambda-list seg bindform whole req opt rest keys nil cdr-p)
                                   vloc (ppc2-vloc-ea vloc) whole req opt rest keys auxen)
      (ppc2-undo-body seg vreg xfer body old-stack)
      (ppc2-close-structured-lambda seg whole req opt rest keys auxen))))

(defppc2 ppc2-multiple-value-prog1 multiple-value-prog1 (seg vreg xfer forms)
  (if (or (not (ppc2-mv-p xfer)) (ppc2-single-valued-form-p (%car forms)))
    (ppc2-use-operator (%nx1-operator prog1) seg vreg xfer forms)
    (progn
      (let* ((*ppc2-vstack* *ppc2-vstack*)
             (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*))
        (ppc2-multiple-value-body seg (%car forms))
        (ppc2-open-undo $undostkblk)
        (! call-subprim .SPsave-values))
      (dolist (form (cdr forms))
        (ppc2-form seg nil nil form))
      (ppc2-set-nargs seg 0)
      (! call-subprim .SPrecover-values)
      (ppc2-close-undo)
      (let* ((*ppc2-returning-values* t))
        (^)))))

(defppc2 ppc2-not not (seg vreg xfer cc form)
  (ppc2-compare-registers 
   seg 
   vreg 
   xfer
   (ppc2-one-untargeted-reg-form seg form ppc::arg_z) 
   ppc::rnil 
   ppc::ppc-eq-bit 
   (eq (ppc2-fixnum-form-p cc) $ccEQ)))


(defppc2 ppc2-%alloc-misc %make-uvector (seg vreg xfer element-count st &optional initval)
  (if (null vreg)
    (progn
      (ppc2-form seg nil nil element-count)
      (ppc2-form seg nil xfer st))
    (let* ((subtag (ppc2-fixnum-form-p st))
           (nelements (ppc2-fixnum-form-p element-count))
           (nbytes (if (and subtag nelements) (ppc2-misc-byte-count subtag nelements))))
      (if (and nbytes (null initval) (< (logand (lognot 7) (+ nbytes 4 7)) #x8000))
        (with-imm-target (ppc::imm0) (header :u32)
          (ppc2-lwi seg header (ppc::make-vheader nelements subtag))
          (ensuring-node-target (target vreg)
            (! %new-alloc-misc-fixed target header nbytes)))
        (progn
          (if initval
            (progn
              (ppc2-three-targeted-reg-forms seg element-count ppc::arg_x st ppc::arg_y initval ppc::arg_z)
              (! call-subprim .SPmisc-alloc-init)
              (<- ppc::arg_z))
            (progn
              (ppc2-two-targeted-reg-forms seg element-count ppc::arg_y st ppc::arg_z)
              (! call-subprim .SPmisc-alloc)
              (<- ppc::arg_z)))))
      (^))))

(defppc2 ppc2-%iasr %iasr (seg vreg xfer form1 form2)
  (if (null vreg)
    (progn
      (ppc2-form seg nil nil form1)
      (ppc2-form seg vreg xfer form2))
    (let* ((count (ppc2-fixnum-form-p form1)))
      (ensuring-node-target (target vreg)
        (if count
          (! %iasr-c target (if (> count 31) 31 count)
             (ppc2-one-untargeted-reg-form seg form2 ppc::arg_z))
          (multiple-value-bind (cnt src) (ppc2-two-targeted-reg-forms seg form1 ppc::arg_y form2 ppc::arg_z)
            (! %iasr target cnt src))))
      (^))))

(defppc2 ppc2-%fixnum-shift-left-right %fixnum-shift-left-right (seg vreg xfer form1 form2)
  (if (null vreg)
    (progn
      (ppc2-form seg nil nil form1)
      (ppc2-form seg vreg xfer form2))
    (let* ()
      (ensuring-node-target (target vreg)       
        (multiple-value-bind (src cnt) (ppc2-two-targeted-reg-forms seg form1 ppc::arg_y form2 ppc::arg_z)
          (! %fixnum-shift-left-right target src cnt)))
      (^))))
  

(defppc2 ppc2-%ilsr %ilsr (seg vreg xfer form1 form2)
  (if (null vreg)
    (progn
      (ppc2-form seg nil nil form1)
      (ppc2-form seg vreg xfer form2))
    (let* ((count (ppc2-fixnum-form-p form1)))
      (ensuring-node-target (target vreg)
        (if count
          (let ((src (ppc2-one-untargeted-reg-form seg form2 ppc::arg_z)))
            (if (<= count 31)
              (! %ilsr-c target count src)
              (!  lwi target 0)))
          (multiple-value-bind (cnt src) (ppc2-two-targeted-reg-forms seg form1 ppc::arg_y form2 ppc::arg_z)
            (! %ilsr target cnt src))))
      (^))))


(defppc2 ppc2-%i<> %i<> (seg vreg xfer cc form1 form2)
  (multiple-value-bind (cr-bit true-p) (68k-cc-to-ppc-cr-bit (ppc2-fixnum-form-p cc) t)
    (ppc2-compare seg vreg xfer form1 form2 cr-bit true-p)))

(defppc2 ppc2-double-float-compare double-float-compare (seg vreg xfer cc form1 form2)
  (multiple-value-bind (cr-bit true-p) (68k-cc-to-ppc-cr-bit (ppc2-fixnum-form-p cc) t)
    (with-fp-target () (r1 :double-float)
      (with-fp-target (r1) (r2 :double-float)
        (multiple-value-bind (r1 r2) (ppc2-two-untargeted-reg-forms seg form1 r1 form2 r2)
          (ppc2-compare-double-float-registers seg vreg xfer r1 r2 cr-bit true-p))))))

(defppc2 ppc2-short-float-compare short-float-compare (seg vreg xfer cc form1 form2)
  (multiple-value-bind (cr-bit true-p) (68k-cc-to-ppc-cr-bit (ppc2-fixnum-form-p cc) t)
    (with-fp-target () (r1 :single-float)
      (with-fp-target (r1) (r2 :single-float)
        (multiple-value-bind (r1 r2) (ppc2-two-untargeted-reg-forms seg form1 r1 form2 r2)
          (ppc2-compare-double-float-registers seg vreg xfer r1 r2 cr-bit true-p))))))
 
(eval-when (:compile-toplevel :execute)
  (defmacro defppc2-df-op (fname opname vinsn)
    `(defppc2 ,fname ,opname (seg vreg xfer f0 f1)
       (if (null vreg)
         (progn
           (ppc2-form seg nil nil f0)
           (ppc2-form seg vreg xfer f1))
         (with-fp-target () (r1 :double-float)
           (with-fp-target (r1) (r2 :double-float)
             (multiple-value-bind (r1 r2) (ppc2-two-untargeted-reg-forms seg f0 r1 f1 r2)
               (! CLEAR-FPU-EXCEPTIONS ppc::fp-zero)
               (if (= (ppc::hard-regspec-class vreg) ppc::hard-reg-class-fpr)
                 (let* ((vreg-val (ppc::hard-regspec-value vreg)))
                   (declare (fixnum vreg-val))
                   (if (or (= vreg-val (ppc::hard-regspec-value r1))
                           (= vreg-val (ppc::hard-regspec-value r2)))
                     (with-fp-target (r1 r2) (result :double-float)
                       (! ,vinsn result r1 r2)
                       (<- result))
                     (! ,vinsn vreg r1 r2)))
                 (with-fp-target (r1 r2) (result :double-float)
                   (! ,vinsn result r1 r2)
                   (ensuring-node-target (target vreg)
                     (<- result))))
               (^)))))))
  
  (defmacro defppc2-sf-op (fname opname vinsn)
    `(defppc2 ,fname ,opname (seg vreg xfer f0 f1)
       (if (null vreg)
         (progn
           (ppc2-form seg nil nil f0)
           (ppc2-form seg vreg xfer f1))
         (with-fp-target () (r1 :single-float)
           (with-fp-target (r1) (r2 :single-float)
             (multiple-value-bind (r1 r2) (ppc2-two-untargeted-reg-forms seg f0 r1 f1 r2)
               (! CLEAR-FPU-EXCEPTIONS ppc::fp-zero)
               (if (= (ppc::hard-regspec-class vreg) ppc::hard-reg-class-fpr)
                 (let* ((vreg-val (ppc::hard-regspec-value vreg)))
                   (declare (fixnum vreg-val))
                   (if (or (= vreg-val (ppc::hard-regspec-value r1))
                           (= vreg-val (ppc::hard-regspec-value r2)))
                     (with-fp-target (r1 r2) (result :single-float)
                       (! ,vinsn result r1 r2)
                       (<- result))
                     (! ,vinsn vreg r1 r2)))
                 (with-fp-target (r1 r2) (result :single-float)
                   (! ,vinsn result r1 r2)
                   (ensuring-node-target (target vreg)
                     (<- result))))
               (^)))))))
)

(defppc2-df-op ppc2-%double-float+-2 %double-float+-2 double-float+-2)
(defppc2-df-op ppc2-%double-float--2 %double-float--2 double-float--2)
(defppc2-df-op ppc2-%double-float*-2 %double-float*-2 double-float*-2)
(defppc2-df-op ppc2-%double-float/-2 %double-float/-2 double-float/-2)

(defppc2-sf-op ppc2-%short-float+-2 %short-float+-2 single-float+-2)
(defppc2-sf-op ppc2-%short-float--2 %short-float--2 single-float--2)
(defppc2-sf-op ppc2-%short-float*-2 %short-float*-2 single-float*-2)
(defppc2-sf-op ppc2-%short-float/-2 %short-float/-2 single-float/-2)
               

(defppc2 ppc2-%register-trap %register-trap (seg vreg xfer trapnum bits forms)
  (let* ((procinfo (ppc2-encode-register-trap-procinfo bits forms))
         (n (length forms)))
    (! alloc-c-frame (+ 3 n))           ; Space for UPP, procinfo, trapnum in D1.
    (ppc2-open-undo $undostkblk)
    (do* ((forms forms (cdr forms))
          (form (car forms) (car forms))
          (i 3 (1+ i)))
         ((null forms))
      (declare (list forms) (fixnum i))
      (! set-c-arg 
         (with-imm-target () temp
           (if (< (pop form) #o10) 
             (ppc2-unboxed-integer-arg-to-reg seg form temp)
             (ppc2-macptr-arg-to-reg seg form temp)))
         i))
    (with-imm-target () p
      (ppc2-lwi seg p procinfo)
      (! set-c-arg p 1))
    (ppc2-lwi seg ppc::arg_z (ash trapnum ppc::fixnumshift))
    (! call-subprim .SPregtrap)
    (ppc2-close-undo)
    (if (logbitp 5 bits)                ; check error: cr0_eq false, arg_z = error value.
      (! check-trap-error))
    (if (not (logbitp 4 bits))
      (ppc2-nil seg vreg xfer)
      (progn
        (when vreg
          (<- (ppc::set-regspec-mode ppc::imm0
                                     (ppc-gpr-mode-name-value
                                      (if (logbitp 3 bits)
                                        :address
                                        (if (logbitp 6 bits)
                                          (if (logbitp 7 bits)
                                            :s16
                                            :u16)
                                          :s32))))))
        (^)))))

(defppc2 ppc2-immediate-get-ptr immediate-get-ptr (seg vreg xfer bits ptr offset)
  (let* ((deref (%ilogbitp 4 bits))
         (absptr (unless deref (ppc2-absolute-ptr-p ptr)))
         (triv-p (ppc2-trivial-p offset))
         (dest vreg)
         (offval (ppc2-fixnum-form-p offset)))
    (cond ((not vreg)
           (ppc2-form seg nil nil ptr)
           (ppc2-form seg nil xfer offset))
          (t
           (if (and absptr offval) 
             (setq absptr (+ absptr offval) offval 0)
             (setq absptr nil))
           (and offval (%i> (integer-length offval) 15) (setq offval nil))
           (and absptr (%i> (integer-length absptr) 15) (setq absptr nil))
           (if absptr
             (! mem-ref-c-fullword dest ppc::rzero absptr)
             (if offval
               (let* ((src (ppc2-macptr-arg-to-reg seg ptr ppc::imm0)))
                 (if deref 
                   (! mem-ref-c-fullword src src 0))
                 (! mem-ref-c-fullword dest src offval))
               (let* ((src (ppc2-macptr-arg-to-reg seg ptr ppc::imm0)))
                 (if triv-p
                   (with-imm-temps (src) (x)
                     (if (ppc2-fixnum-form-p offset)
                       (ppc2-lwi seg x (ppc2-fixnum-form-p offset))
                       (! fixnum->s32 x (ppc2-one-untargeted-reg-form seg offset ppc::arg_z)))
                     (if deref 
                       (! mem-ref-c-fullword src src 0))
                     (! mem-ref-fullword dest src x))
                   (progn
                     (! temp-push-unboxed-word src)
                     (ppc2-open-undo $undostkblk)
                     (let* ((oreg (ppc2-one-untargeted-reg-form seg offset ppc::arg_z)))
                       (with-imm-temps () (src x)
                         (! temp-pop-unboxed-word src)
                         (ppc2-close-undo)
                         (if deref 
                           (! mem-ref-c-fullword src src 0))
                         (! fixnum->s32 x oreg)
                         (! mem-ref-fullword dest src x)))))))) 
           (^)))))

; This returns an unboxed object, unless the caller wants to box it.
(defppc2 ppc2-immediate-get-xxx immediate-get-xxx (seg vreg xfer bits ptr offset)
  (let* ((lowbits (%ilogand2 3 bits))
         (deref (%ilogbitp 4 bits))
         (size 
          (if (eq lowbits 3) 
            1 
            (if (eq lowbits 2) 
              2 
              4)))
         (extend-p (%ilogbitp 2 bits)) ;(setq bits (%ilogand2 #xf bits))))
         (absptr (unless deref (ppc2-absolute-ptr-p ptr)))
         (triv-p (ppc2-trivial-p offset))
         (offval (ppc2-fixnum-form-p offset)))
    (declare (fixnum size))
    (cond ((null vreg)
           (ppc2-form seg nil nil ptr)
           (ppc2-form seg nil xfer offset))
          (t 
           (if (and absptr offval) 
             (setq absptr (+ absptr offval) offval 0)
             (setq absptr nil))
           (and offval (%i> (integer-length offval) 15) (setq offval nil))
           (and absptr (%i> (integer-length absptr) 15) (setq absptr nil))
           (with-imm-target () (dest :u32)
             (if absptr
               (progn (if (eq size 4)
                 (! mem-ref-c-fullword dest ppc::rzero absptr)
                 (if (eq size 2)
                   (! mem-ref-c-u16 dest ppc::rzero absptr)
                   (! mem-ref-c-u8 dest ppc::rzero absptr))))
               (if offval
                 (with-imm-target () (src-reg :address)
                   
                   (ppc2-one-targeted-reg-form seg ptr src-reg)
                   (if deref
                     (! mem-ref-c-fullword src-reg src-reg 0))
                   (if (eq size 4)
                     (! mem-ref-c-fullword dest src-reg offval)
                     (if (eq size 2)
                       (! mem-ref-c-u16 dest src-reg offval)
                       (! mem-ref-c-u8 dest src-reg offval))))
                 (with-imm-target () (src-reg :address)
                   (with-imm-target (src-reg) (offset-reg :s32)                                   
                     (ppc2-one-targeted-reg-form seg ptr src-reg)
                     (if triv-p
                       (if (ppc2-fixnum-form-p offset)
                         (ppc2-lwi seg offset-reg (ppc2-fixnum-form-p offset))
                         (! fixnum->s32 offset-reg (ppc2-one-untargeted-reg-form seg offset ppc::arg_z)))
                       (progn
                         (! temp-push-unboxed-word src-reg)
                         (ppc2-open-undo $undostkblk)
                         (! fixnum->s32 offset-reg (ppc2-one-untargeted-reg-form seg offset ppc::arg_z))
                         (! temp-pop-unboxed-word src-reg)
                         (ppc2-close-undo)))
                     (if deref
                       (! mem-ref-c-fullword src-reg src-reg 0))
                     (if (eq size 4)
                       (! mem-ref-fullword dest src-reg offset-reg)
                       (if (eq size 2)
                         (! mem-ref-u16 dest src-reg offset-reg)
                         (! mem-ref-u8 dest src-reg offset-reg)))))))
             ; %get-fixnum: if storing to a node vreg, ignore any overflow.
             (if (and (eq size 4) 
                      (%ilogbitp 5 bits) 
                      (logbitp (ppc::hard-regspec-value vreg)
                               ppc-node-regs))
               (! box-fixnum vreg (ppc::set-regspec-mode dest  (ppc-gpr-mode-name-value :s32)))
               (<- (ppc::set-regspec-mode 
                    dest 
                    (ppc-gpr-mode-name-value
                     (if (eq size 4)
                       (if (%ilogbitp 5 bits)
                         :s32           ; %get-fixnum to "raw" target.
                         (if (%ilogbitp 3 bits)
                           :u32
                           :s32))
                       (if (eq size 2)
                         (if extend-p
                           :s16
                           :u16)
                         (if extend-p
                           :s8
                           :u8))))))))
           (^)))))

(defppc2 ppc2-let let (seg vreg xfer vars vals body p2decls)
  (let* ((old-stack (ppc2-encode-stack))
         (val nil)
         (bits nil)
         (valcopy vals))
    (with-ppc-p2-declarations p2decls
      (dolist (var vars)
        (setq val (%car valcopy))
        (cond ((or (%ilogbitp $vbitspecial (setq bits (nx-var-bits var)))
                   (and (%ilogbitp $vbitreg bits)
                        (dolist (val (%cdr valcopy))
                          (unless (ppc2-trivial-p val) (return t)))))
               (let* ((pair (cons (ppc2-vloc-ea *ppc2-vstack*) nil)))
                 (%rplaca valcopy pair)
                 (if (and (%ilogbitp $vbitdynamicextent bits)
                          (progn
                            (setq val 
                                  (ppc2-dynamic-extent-form seg (ppc2-encode-stack) val))
                            (ppc2-load-ea-p val)))
                   (progn
                     (%rplaca pair (ppc2-vloc-ea *ppc2-vstack*))
                     (ppc2-vpush-register seg val :reserved))
                 (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg val ppc::arg_z) :reserved))
                 (%rplacd pair *ppc2-top-vstack-lcell*)))
              (t (ppc2-seq-bind-var seg var val)
                 (%rplaca valcopy nil)))
        (setq valcopy (%cdr valcopy)))
      (dolist (var vars)
        (declare (list val))
        (when (setq val (pop vals))
          (if (%ilogbitp $vbitspecial (nx-var-bits var))
            (ppc2-dbind seg (car val) (var-name var))
            (ppc2-seq-bind-var seg var (car val)))))
      (ppc2-undo-body seg vreg xfer body old-stack)
      (dolist (var vars)
        (ppc2-close-var seg var)))))

(defppc2 ppc2-closed-function closed-function (seg vreg xfer afunc)
  (ppc2-make-closure seg afunc nil)
  (when vreg (<- ppc::arg_z))
  (^))

(defppc2 ppc2-flet flet (seg vreg xfer vars afuncs body p2decls)
  (ppc2-seq-fbind seg vreg xfer vars afuncs body p2decls))

(defppc2 ppc2-labels labels (seg vreg xfer vars afuncs body p2decls)
  (let* ((fwd-refs nil)
         (func nil)
         (togo vars)
         (real-vars ())
         (real-funcs ())
         (funs afuncs))
    (dolist (v vars)
      (when (neq 0 (afunc-fn-refcount (setq func (pop funs))))
        (push v real-vars)
        (push func real-funcs)
        (let* ((i 2)
               (our-var nil)
               (item nil))
          (declare (fixnum i))
          (dolist (ref (afunc-inherited-vars func))
            (when (memq (setq our-var (var-bits ref)) togo)
              (setq item (cons i our-var))
              (let* ((refs (assq v fwd-refs)))
                (if refs
                  (push item (cdr refs))
                  (push (list v item) fwd-refs))))
            (incf i)))
        (setq togo (%cdr togo))))       
    (if (null fwd-refs)
      (ppc2-seq-fbind seg vreg xfer (nreverse real-vars) (nreverse real-funcs) body p2decls)
      (let* ((old-stack (ppc2-encode-stack)))
        (setq real-vars (nreverse real-vars) real-funcs (nreverse real-funcs))
        (with-ppc-p2-declarations p2decls
          (dolist (var real-vars)
            (ppc2-seq-bind-var seg var (nx1-afunc-ref (pop real-funcs))))
          (dolist (ref fwd-refs)
            (let ((ea (var-ea (pop ref))))
              (ppc2-addrspec-to-reg seg ea ppc::temp0)
              (dolist (r ref)
                (let* ((v-ea (var-ea (cdr r))))
                  (let* ((val-reg (if (eq v-ea ea)
                                    ppc::temp0
                                    (progn
                                      (ppc2-addrspec-to-reg seg v-ea ppc::temp1)
                                      ppc::temp1))))
                    ; can't be sure of relative ages of function vectors, so have to memoize.
                    ; the concept of "forward" references implies that the memoization may
                    ; actually be needed.
                    (! misc-set-c-node& val-reg ppc::temp0 (car r)))))))
          (ppc2-undo-body seg vreg xfer body old-stack)
          (dolist (var real-vars)
            (ppc2-close-var seg var)))))))

; Make a function call (e.g., to mapcar) with some of the toplevel arguments
; stack-consed (downward) closures.  Bind temporaries to these closures so
; that tail-recursion/non-local exits work right.
; (all of the closures are distinct: FLET and LABELS establish dynamic extent themselves.)
(defppc2 ppc2-with-downward-closures with-downward-closures (seg vreg xfer tempvars closures callform)
  (let* ((old-stack (ppc2-encode-stack)))
    (ppc2-seq-bind seg tempvars closures)
    (ppc2-undo-body seg vreg xfer callform old-stack)
    (dolist (v tempvars) (ppc2-close-var seg v))))


(defppc2 ppc2-local-return-from local-return-from (seg vreg xfer blocktag value)
  (declare (ignorable vreg xfer))
  (let* ((*ppc2-undo-count* *ppc2-undo-count*)
         (tagdata (car blocktag))
         (cur-stack (ppc2-encode-stack))
         (dest-vd (caar tagdata))
         (dest-cd (cdar tagdata))
         (mv-p (ppc2-mvpass-p dest-cd))
         (dest-stack  (cdr tagdata))
         (need-break (neq cur-stack dest-stack)))
    (let* ((*ppc2-vstack* *ppc2-vstack*)
           (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*)
           (*ppc2-cstack* *ppc2-cstack*))
      (if 
        (or
         (eq dest-cd $ppc-return)
         (and mv-p 
              (eq (ppc2-encoding-undo-count cur-stack)
                  (ppc2-encoding-undo-count dest-stack)) 
              (eq (ppc2-encoding-cstack-depth cur-stack)
                  (ppc2-encoding-cstack-depth dest-stack))))
        (ppc2-form seg dest-vd dest-cd value)
        (if mv-p
          (progn
            (ppc2-multiple-value-body seg value)
            (let* ((*ppc2-returning-values* :pass))
              (ppc2-nlexit seg dest-cd (%i- *ppc2-undo-count* (ppc2-encoding-undo-count dest-stack)))
              (ppc2-branch seg dest-cd vreg)))
          (progn
            (ppc2-form 
             seg
             (if need-break (if dest-vd ppc::arg_z) dest-vd) 
             (if need-break nil dest-cd)
             value)
            (when need-break
              (ppc2-unwind-set seg dest-cd dest-stack)
              (when dest-vd (ppc2-copy-register seg dest-vd ppc::arg_z))
              (ppc2-branch seg dest-cd dest-vd))))))
    (ppc2-unreachable-store)))

(defppc2 ppc2-inherited-arg inherited-arg (seg vreg xfer arg)
  (when vreg
    (ppc2-addrspec-to-reg seg (ppc2-ea-open (var-ea arg)) vreg))
  (^))


(defppc2 ppc2-%lisp-word-ref %lisp-word-ref (seg vreg xfer base offset)
  (let* ((fixoffset (ppc2-fixnum-form-p offset)))
    (cond ((null vreg)
           (ppc2-form seg nil nil base)
           (ppc2-form seg nil xfer offset))
          ((typep fixoffset '(signed-byte 14))
           (ensuring-node-target (target vreg)
             (! lisp-word-ref-c target 
                (ppc2-one-untargeted-reg-form seg base ppc::arg_z) 
                (ash fixoffset ppc::word-shift)))
           (^))
          (t (multiple-value-bind (breg oreg)
                                  (ppc2-two-untargeted-reg-forms seg base ppc::arg_y offset ppc::arg_z)
               (ensuring-node-target (target vreg)
                 (! lisp-word-ref target breg oreg))
               (^))))))

(defppc2 ppc2-int>0-p int>0-p (seg vreg xfer cc form)
  (multiple-value-bind (cr-bit true-p) (68k-cc-to-ppc-cr-bit (ppc2-fixnum-form-p cc) nil)
    (ppc2-one-targeted-reg-form seg form ppc::arg_z)
    (! call-subprim .SPinteger-sign)
    (ppc2-test-reg-%izerop seg vreg xfer ppc::imm0 cr-bit true-p 0)))


(defppc2 ppc2-throw throw (seg vreg xfer tag valform )
  (declare (ignorable vreg xfer))
  (let* ((*ppc2-vstack* *ppc2-vstack*)
         (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*))
    (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg tag ppc::arg_z))
    (if (ppc2-trivial-p valform)
      (progn
        (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg valform ppc::arg_z))
        (ppc2-set-nargs seg 1))
      (ppc2-multiple-value-body seg valform))
    (! call-subprim .SPthrow)))

; This (and unwind-protect and things like that) are a little funky in that
; they have no good way of specifying the exit-point.  The bad way is to
; follow the call to the catch-frame-creating subprim with a branch to that
; exit-point; the subprim returns to the following instruction.
; If the compiler ever gets smart about eliminating dead code, it has to
; be careful not to consider the block following the jump to be dead.
; Use a vinsn other than JUMP to reference the label.
(defppc2 ppc2-catch catch (seg vreg xfer tag valform)
  (let* ((tag-label (ppc2-get-next-label))
         (mv-pass (ppc2-mv-p xfer)))
    (ppc2-one-targeted-reg-form seg tag ppc::arg_z)
    (! call-subprim (if mv-pass .SPmkcatchmv .SPmkcatch1v))
    (! non-barrier-jump (aref *ppc2-labels* tag-label))
    (ppc2-open-undo)
    (if mv-pass
      (ppc2-multiple-value-body seg valform)  
      (ppc2-one-targeted-reg-form seg valform ppc::arg_z))
    (ppc2-lwi seg ppc::imm0 (ash 1 ppc::fixnumshift))
    (! call-subprim (if mv-pass .SPnthrowvalues .SPnthrow1value))
    (ppc2-close-undo)
    (@ tag-label)
    (unless mv-pass (if vreg (<- ppc::arg_z)))
    (let* ((*ppc2-returning-values* mv-pass)) ; nlexit keeps values on stack
      (^))))


(defppc2 ppc2-fixnum-overflow fixnum-overflow (seg vreg xfer form)
  (destructuring-bind (op n0 n1) (ppc2-unwrapped-form form)
    (ppc2-use-operator op seg vreg xfer n0 n1 *nx-t*)))


(defppc2 ppc2-%typed-uvref %typed-uvref (seg vreg xfer subtag uvector index)
  (let* ((fixtype (ppc2-fixnum-form-p subtag)))
    (if fixtype
      (ppc2-vref seg vreg xfer fixtype uvector index (unless *ppc2-reckless* fixtype))
      (progn
        (ppc2-three-targeted-reg-forms seg subtag ppc::arg_x uvector ppc::arg_y index ppc::arg_z)
        (! call-subprim .SPsubtag-misc-ref)
        (when vreg (<- ppc::arg_z))
        (^)))))

(defppc2 ppc2-%typed-uvset %typed-uvset (seg vreg xfer subtag uvector index newval)
  
  (let* ((fixtype (ppc2-fixnum-form-p subtag)))
    (if fixtype
      (ppc2-vset seg vreg xfer fixtype uvector index newval (unless *ppc2-reckless* fixtype))
      (progn                            ; Could always do a four-targeted-reg-forms ...
        (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg subtag ppc::arg_z))
        (ppc2-three-targeted-reg-forms seg uvector ppc::arg_x index ppc::arg_y newval ppc::arg_z)
        (ppc2-vpop-register seg ppc::temp0)
        (! call-subprim .SPsubtag-misc-set)
        (when vreg (<- ppc::arg_z))
        (^)))))

#|
(defppc2 ppc2-%macptrptr% %macptrptr% (seg vreg xfer form)
  (unless vreg
    (setq vreg (ppc2-make-unwired-lreg (ppc-select-imm-temp :address))))
  (ppc2-one-targeted-reg-form seg form vreg)
  (^))
|#

(defppc2 ppc2-%macptrptr% %macptrptr% (seg vreg xfer form)
  (with-imm-target () (target :address)
    (ppc2-one-targeted-reg-form seg form (or vreg target)))
  (^))
           

; cons a macptr, unless "vreg" is an immediate register of mode :address.
(defppc2 ppc2-%consmacptr% %consmacptr% (seg vreg xfer form)
  (cond ((null vreg) (ppc2-form seg nil xfer form))
        ((eql (ppc::get-regspec-mode vreg) ppc::hard-reg-class-gpr-mode-address)
         (ppc2-form seg vreg xfer form))
        (t         
         (with-imm-target () (temp :address)
           (<- (ppc2-one-targeted-reg-form seg form temp))
           (^)))))

(defppc2 ppc2-%immediate-ptr-to-int %immediate-ptr-to-int (seg vreg xfer form)
  (if (null vreg)
    (ppc2-form seg nil xfer form)
    (with-imm-target () (address-reg :address)
      (ppc2-form seg address-reg nil form)
      (<- (ppc::set-regspec-mode address-reg (ppc-gpr-mode-name-value :u32)))
      (^))))


#|
;; look out - there is a bug with %int-to-ptr
;; p1 below does (MULLI IMM0 ARG_Z 4) and does not unbox the result before storing in macptr
;; fixed - see ppc2-%i*
(defun p1 (a)  ;; bad - ops other than * do work ok I think,  works ok without fixnum decls.
  (declare (fixnum a))
  (%int-to-ptr (the fixnum (* a 4))))
|#
(defppc2 ppc2-%immediate-int-to-ptr %immediate-int-to-ptr (seg vreg xfer form)
  (if (null vreg)
    (ppc2-form seg nil xfer form)
    (progn
      (unless (logbitp (ppc::hard-regspec-value vreg) ppc-imm-regs)
        (error "I give up.  When will I get this right ?"))
      (let* ((u32-reg (ppc2-one-targeted-reg-form seg 
                                                    form
                                                    (ppc2-make-wired-lreg vreg :mode ppc::hard-reg-class-gpr-mode-u32))))
        (<- u32-reg)
        (^)))))


(defppc2 ppc2-%function %function (seg vreg xfer sym)
  (when vreg
    (let* ((symreg (ppc2-one-untargeted-reg-form seg (make-acode (%nx1-operator immediate)
                                                                 (ppc2-symbol-entry-locative sym)) ppc::arg_z)))
      (with-node-temps (vreg symreg) (val)
        (! symbol-function val symreg)
        (<- val))))
  (^))

(defppc2 ppc2-%unbound-marker %unbound-marker (seg vreg xfer)
  (when vreg       
    (ensuring-node-target (target vreg)
      (ppc2-lwi seg target ppc::unbound-marker)))
  (^))

(defppc2 ppc2-%illegal-marker %illegal-marker (seg vreg xfer)
  (when vreg    
    (ensuring-node-target (target vreg)
      (ppc2-lwi seg target ppc::illegal-marker)))
  (^))

(defppc2 ppc2-%slot-unbound-marker %slot-unbound-marker (seg vreg xfer)
  (when vreg
    (ensuring-node-target (target vreg)
      (ppc2-lwi seg target ppc::slot-unbound-marker)))
  (^))

(defppc2 ppc2-%slot-ref %slot-ref (seg vreg xfer instance idx)
  (ensuring-node-target (target (or vreg ppc::arg_z))
    (multiple-value-bind (v i) (ppc2-two-untargeted-reg-forms seg instance ppc::arg_y idx ppc::arg_z)
      (unless *ppc2-reckless*
        (! check-misc-bound i v))
      (with-node-temps (v) (temp)
        (! slot-ref temp v i)
        (<- temp))))
  (^))


(defppc2 ppc2-lambda-bind lambda-bind (seg vreg xfer vals req rest keys-p auxen body p2decls)
  (let* ((old-stack (ppc2-encode-stack))
         (nreq (list-length req))
         (rest-arg (nthcdr nreq vals))
         (apply-body (ppc2-eliminate-&rest body rest keys-p auxen rest-arg)))
    (ppc2-seq-bind seg req vals)
    (when apply-body (setq rest nil body apply-body))
    (let*
      ((vloc *ppc2-vstack*)
       (restloc vloc)
       (nvloc (progn (if (or rest keys-p) (ppc2-formlist seg rest-arg)) *ppc2-vstack*)))
      (with-ppc-p2-declarations p2decls
        (when rest
          (when keys-p
            (until (eq restloc nvloc)
              (with-node-temps () (temp)
                (ppc2-stack-to-register seg (ppc2-vloc-ea restloc) temp)
                (ppc2-vpush-register seg temp))
              (setq restloc (%i+ restloc 4))))
          (ppc2-set-nargs seg (length rest-arg))
          (if (%ilogbitp $vbitdynamicextent (nx-var-bits rest))
            (progn
              ;; this thinks the args are still there
              (ppc2-set-vstack (%i+ restloc 0))  ;; added this - doesn't matter if 0 or 4????
              (ppc2-open-undo $undostkblk) 
              (! call-subprim .SPstkconslist))
            (! call-subprim .SPconslist))
          
          (ppc2-vpush-register seg ppc::arg_z)
          (ppc2-set-vstack (%i+ restloc 4)))
        (when rest (ppc2-bind-var seg rest restloc))
        (destructuring-bind (vars inits) auxen
          (while vars
            (let ((val (%car inits))) 
              (if (fixnump val)
                (progn
                  (when rest (setq val (%i+ (%i+ val val) 1)))
                  (ppc2-bind-var seg (%car vars) (%i+ vloc (%ilsl 2 val))))
                (ppc2-seq-bind-var seg (%car vars) val)))
            (setq vars (%cdr vars) inits (%cdr inits))))
        (ppc2-undo-body seg vreg xfer body old-stack)
        (dolist (var req) (ppc2-close-var seg var))
        (when rest (ppc2-close-var seg rest))
        (dolist (var (%car auxen)) (ppc2-close-var seg var))))))

(macrolet 
  ((def-ppc2-require (function op &optional (vinsn op))
     `(defppc2 ,function ,op (seg vreg xfer val)
        (let* ((val-reg (ppc2-one-untargeted-reg-form 
                         seg 
                         val 
                         (if (eq vreg ppc::arg_z) ppc::arg_y ppc::arg_z))))
          (! ,vinsn val-reg)
          (when vreg (<- val-reg))
          (^)))))
  (def-ppc2-require ppc2-require-simple-vector require-simple-vector)
  (def-ppc2-require ppc2-require-simple-string require-simple-string)
  (def-ppc2-require ppc2-require-integer require-integer)
  (def-ppc2-require ppc2-require-fixnum require-fixnum)
  (def-ppc2-require ppc2-require-real require-real)
  (def-ppc2-require ppc2-require-list require-list)
  (def-ppc2-require ppc2-require-character require-character)
  (def-ppc2-require ppc2-require-number require-number)
  (def-ppc2-require ppc2-require-symbol require-symbol))

(defppc2 ppc2-%badarg2 %badarg2 (seg vreg xfer badthing goodthing)
  (ppc2-two-targeted-reg-forms seg badthing ppc::arg_y goodthing ppc::arg_z)
  (ppc2-lwi seg ppc::arg_x (ash $XWRONGTYPE ppc::fixnumshift))
  (ppc2-set-nargs seg 3)
  (! call-subprim .SPksignalerr)
  (<- ppc::rnil)
  (^))  
          
(defppc2 ppc2-%set-sbchar %set-sbchar (seg vreg xfer string index value)
  (ppc2-vset 
   seg 
   vreg 
   xfer 
   ppc::subtag-simple-base-string 
   string 
   index
   value 
   (unless *ppc2-reckless* ppc::subtag-simple-base-string)))


; If we didn't use this for stack consing, turn it into a call.  Ugh.

(defppc2 ppc2-make-list make-list (seg vreg xfer size initial-element)
  (ppc2-form seg vreg xfer (make-acode (%nx1-operator call)
                                       (make-acode (%nx1-operator immediate) 'make-list)
                                       (list nil
                                             (list initial-element 
                                                   (make-acode (%nx1-operator immediate)
                                                               :initial-element)
                                                   size)))))


(defppc2 ppc2-setq-free setq-free (seg vreg xfer sym val)
  (ppc2-one-targeted-reg-form seg val ppc::arg_z)
  (ppc2-immediate seg ppc::arg_y nil (ppc2-symbol-value-locative sym))
  (! call-subprim .SPsetqsym)
  (<- ppc::arg_z)
  (^))

(defppc2 ppc2-%setf-macptr %setf-macptr (seg vreg xfer x y)
  (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg x ppc::arg_z))
  (with-imm-target () (src-reg :address)
    (ppc2-one-targeted-reg-form seg y src-reg)
    (ppc2-vpop-register seg ppc::arg_z)
    (unless (or *ppc2-reckless* (ppc2-form-typep x 'macptr))
      (with-imm-temps (src-reg) ()
        (! trap-unless-typecode= ppc::arg_z ppc::subtag-macptr)))
    (! set-macptr-address src-reg ppc::arg_z)
    (<- ppc::arg_z)
    (^)))

(defppc2 ppc2-%setf-double-float %setf-double-float (seg vref xfer fnode fval)
  (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg fnode ppc::arg_z))
  (let* ((target (ppc::make-hard-fp-reg ppc::fp1 ppc::hard-reg-class-fpr-mode-double)))
    (ppc2-one-targeted-reg-form seg fval target)
    (ppc2-vpop-register seg ppc::arg_z)
    (unless (or *ppc2-reckless* (ppc2-form-typep fnode 'double-float))
      (! trap-unless-typecode= ppc::arg_z ppc::subtag-double-float))
    (! store-double ppc::arg_z target)
    (<- ppc::arg_z)
    (^)))

(defppc2 ppc2-%setf-short-float %setf-short-float (seg vreg xfer fnode fval)
  (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg fnode ppc::arg_z))
  (let* ((target (ppc::make-hard-fp-reg ppc::fp1 ppc::hard-reg-class-fpr-mode-single)))
    (ppc2-one-targeted-reg-form seg fval target)
    (ppc2-vpop-register seg ppc::arg_z)
    (unless (or *ppc2-reckless* (ppc2-form-typep fnode 'short-float))
      (! trap-unless-typecode= ppc::arg_z ppc::subtag-single-float))
    (! store-single ppc::arg_z target)
    (<- ppc::arg_z)
    (^)))

(defppc2 ppc2-unwind-protect unwind-protect (seg vreg xfer protected-form cleanup-form)
  (let* ((cleanup-label (ppc2-get-next-label))
         (protform-label (ppc2-get-next-label))
         (old-stack (ppc2-encode-stack)))
    (! call-subprim .SPmkunwind)
    (! non-barrier-jump (aref *ppc2-labels* cleanup-label))
    (-> protform-label)
    (@ cleanup-label)
    (let* ((*ppc2-vstack* *ppc2-vstack*)
           (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*)
           (*ppc2-cstack* (%i+ *ppc2-cstack* 16)))
      (ppc2-open-undo $undostkblk)      ; tsp frame created by nthrow.
      (! save-cleanup-context)
      (setq *ppc2-cstack* (%i+ *ppc2-cstack* 16))       ; the frame we just pushed
      (ppc2-form seg nil nil cleanup-form)
      (ppc2-close-undo)
      (! restore-cleanup-context)
      (! jump-return-pc)) ; rts
    (ppc2-open-undo)
    (@ protform-label)
    (ppc2-undo-body seg vreg xfer protected-form old-stack)))

(defppc2 ppc2-progv progv (seg vreg xfer symbols values body)
  (let* ((cleanup-label (ppc2-get-next-label))
         (protform-label (ppc2-get-next-label))
         (old-stack (ppc2-encode-stack)))
    (ppc2-two-targeted-reg-forms seg symbols ppc::arg_y values ppc::arg_z)
    (! call-subprim .SPprogvsave)
    (ppc2-open-undo $undostkblk)
    (! call-subprim .SPmkunwind)
    (! non-barrier-jump (aref *ppc2-labels* cleanup-label))
    (-> protform-label)
    (@ cleanup-label)
    (! jump-subprim .SPprogvrestore)
    (ppc2-open-undo)
    (@ protform-label)
    (ppc2-undo-body seg vreg xfer body old-stack)))

(defppc2 ppc2-%ptr-eql %ptr-eql (seg vreg xfer cc x y )
  (if (null vreg)
    (progn
      (ppc2-form seg nil nil x)
      (ppc2-form seg nil xfer y))
    (let* ((x-abs (ppc2-absolute-ptr-p x t))
           (y-abs (ppc2-absolute-ptr-p y t))
           (abs (or x-abs y-abs))
           (other (if abs (if x-abs y x))))
      (multiple-value-bind (cr-bit true-p) (68k-cc-to-ppc-cr-bit (ppc2-fixnum-form-p cc) t)
        (if other
          (with-imm-target () (other-target :address)
            (ppc2-one-targeted-reg-form seg other other-target)
            (if (typep abs '(signed-byte 16))              
              (ppc2-test-reg-%izerop seg vreg xfer other-target cr-bit true-p abs)
              (with-imm-temps (other-target) ((abs-target :address))
                (ppc-use-imm-temp other-target)
                (ppc2-lwi seg abs-target abs)
                (ppc2-compare-registers seg vreg xfer other-target abs-target cr-bit true-p))))
          ; Neither expression is obviously a constant-valued macptr.
          (with-imm-target () (target-a :address)
            (ppc2-one-targeted-reg-form seg x target-a)
            (! temp-push-unboxed-word target-a)
            (ppc2-open-undo $undostkblk)
            (ppc2-one-targeted-reg-form seg y target-a)
            (with-imm-target (target-a) (target-b :address)
              (! temp-pop-unboxed-word target-b)
              (ppc2-close-undo)
              (ppc2-compare-registers seg vreg xfer target-b target-a cr-bit true-p))))))))


(defppc2 ppc2-%immediate-set-xxx %immediate-set-xxx (seg vreg xfer bits ptr offset val)
  (ppc2-%immediate-store seg vreg xfer bits ptr offset val nil))

(defppc2 ppc2-immediate-put-xxx immediate-put-xxx (seg vreg xfer bits ptr val offset)
  (ppc2-%immediate-store seg nil nil bits ptr offset val t)
  (ppc2-nil seg vreg xfer))

(defppc2 ppc2-%immediate-inc-ptr %immediate-inc-ptr (seg vreg xfer ptr by)
  (let* ((triv-by (ppc2-trivial-p by))
         (fixnum-by (ppc2-fixnum-form-p by)))
    (if (and fixnum-by (eql 0 fixnum-by))
      (ppc2-form seg vreg xfer ptr)
      (with-imm-target (vreg) (ptr-reg :address)
        (ppc2-one-targeted-reg-form seg ptr ptr-reg)
        (if fixnum-by
          (with-imm-target (vreg ptr-reg) (result :address)
            (let* ((high (ldb (byte 16 16) fixnum-by))
                   (low (ldb (byte 16 0) fixnum-by)))
              (declare (type (unsigned-byte 16) high low))
              (if (logbitp 15 low) (incf high))
              (! add-immediate result ptr-reg high low)
              (<- result)))
          (progn
            (unless triv-by
              (! temp-push-unboxed-word ptr-reg)
              (ppc2-open-undo $undostkblk))
            (with-imm-target (vreg ptr-reg) (by-reg :s32)
              (ppc2-one-targeted-reg-form seg by by-reg)
              (unless triv-by
                (! temp-pop-unboxed-word ptr-reg)
                (ppc2-close-undo))
              (with-imm-target (vreg ptr-reg by-reg) (result :address)
                (! fixnum-add result ptr-reg by-reg)
                (<- result)))))
        (^)))))

; The form in question just binds *interrupt-level* to -1, but we want
; to disable the generation of event-polling sequences that would otherwise
; appear lexically within the body.
(defppc2 ppc2-without-interrupts without-interrupts (seg vreg xfer form)
  (let* ((*ppc2-inhibit-eventchecks* t))
    (ppc2-form seg vreg xfer form)))


(defppc2 ppc2-multiple-value-call multiple-value-call (seg vreg xfer fn arglist)
  (ppc2-mvcall seg vreg xfer fn arglist))

(defppc2 ppc2-ff-call-slep ff-call-slep (seg vreg xfer address argspecs argvals resultspec)
  (ppc2-ff-call-internal seg vreg xfer address argspecs argvals resultspec .SPffcallslep))

(defppc2 ppc2-ff-call native-ff-call (seg vreg xfer address argspecs argvals resultspec)
  (ppc2-ff-call-internal seg vreg xfer address argspecs argvals resultspec .SPffcalladdress))

(defun ppc2-ff-call-internal (seg vreg xfer address argspecs argvals resultspec subprim)
  (with-local-vinsn-macros (seg vreg xfer)
    (let* ((*ppc2-vstack* *ppc2-vstack*)
           (*ppc2-top-vstack-lcell* *ppc2-top-vstack-lcell*)
           (*ppc2-cstack* *ppc2-cstack*)
           (nextarg 0)
           (fp-loads ()))
      (declare (fixnum nextarg))
      (! alloc-c-frame (the fixnum
                         (+ (the fixnum (length argvals)) 
                            (the fixnum (count-if #'(lambda (x) (eq x :double-float)) argspecs)))))
      (ppc2-open-undo $undo-ppc-c-frame)
      (ppc2-vpush-register seg (ppc2-one-untargeted-reg-form seg address ppc::arg_z))
      ; Evaluate each form into the C frame, according to the matching argspec.
      ; Remember type and arg offset of any FP args, since FP regs will have to be loaded
      ; later.
      (do* ((specs argspecs (cdr specs))
            (vals argvals (cdr vals)))
           ((null specs))
        (declare (list specs vals))
        (let* ((valform (car vals))
               (spec (car specs))
               (longval (ppc2-long-constant-p valform))
               (absptr (ppc2-absolute-ptr-p valform)))
          (case spec
            (:double-float
             (ppc2-one-targeted-reg-form seg valform (ppc::make-hard-fp-reg ppc::fp0 ppc::hard-reg-class-fpr-mode-double))
             (! set-double-c-arg ppc::fp0 nextarg)            
             (push (cons :double nextarg) fp-loads)
             (incf nextarg))
            (:single-float
             (ppc2-one-targeted-reg-form
              seg valform (ppc::make-hard-fp-reg
                           ppc::fp0 ppc::hard-reg-class-fpr-mode-single))
             (! set-single-c-arg ppc::fp0 nextarg)
             (push (cons :single nextarg) fp-loads))
            (:address
             (with-imm-target () (ptr :address)
               (if absptr
                 (ppc2-lwi seg ptr absptr)
                 (ppc2-one-targeted-reg-form seg valform ptr))
               (! set-c-arg ptr nextarg)))
            (t
             (with-imm-target () (valreg :u32)
               (if longval
                 (ppc2-lwi seg valreg longval)
                 (ppc2-unboxed-integer-arg-to-reg seg valform valreg))
               (! set-c-arg valreg nextarg))))
          (incf nextarg)))
      (do* ((fpreg ppc::fp1 (1+ fpreg))
            (reloads (nreverse fp-loads) (cdr reloads)))
           ((or (null reloads) (= fpreg ppc::fp14)))
        (declare (list reloads) (fixnum fpreg))
        (let* ((reload (car reloads))
               (size (car reload))
               (from (cdr reload)))
          (if (eq size :double)
            (! reload-double-c-arg fpreg from)
            (! reload-single-c-arg fpreg from))))
      (ppc2-vpop-register seg ppc::arg_z)
      (! call-subprim subprim)            ; subprim is .SPffcalladdress or .SPffcallslep
      (ppc2-close-undo)
      (when vreg
        (if (eq resultspec :void)
          (<- ppc::rnil)
          (if (eq resultspec :double-float)
            (<- (ppc::make-hard-fp-reg ppc::fp1 ppc::hard-reg-class-fpr-mode-double))
            (if (eq resultspec :single-float)
              (<- (ppc::make-hard-fp-reg 
                   ppc::fp1 
                   #-ignore ppc::hard-reg-class-fpr-mode-single ;; <<
                   #+ignore ppc::hard-reg-class-fpr-mode-double))
              (<- (ppc::set-regspec-mode ppc::imm0 (ppc-gpr-mode-name-value
                                                    (case resultspec
                                                      (:address :address)
                                                      (:signed-byte :s8)
                                                      (:unsigned-byte :u8)
                                                      (:signed-halfword :s16)
                                                      (:unsigned-halfword :u16)
                                                      (:signed-fullword :s32)
                                                      (t :u32)))))))))
      (^))))

               
             
(defppc2 ppc2-%temp-list %temp-list (seg vreg xfer arglist)
  (ppc2-use-operator (%nx1-operator list) seg vreg xfer arglist))

(defppc2 ppc2-%temp-cons %temp-cons (seg vreg xfer car cdr)
  (ppc2-use-operator (%nx1-operator cons) seg vreg xfer car cdr))

(defppc2 ppc2-point-h integer-point-h (seg vreg xfer form)
  (if (null vreg)
    (ppc2-form seg nil xfer form)
    (with-imm-target () (s32 :s32)
      (let* ((immval (ppc2-long-constant-p form)))
        (if immval
          (ppc2-lwi seg s32 immval)
          (ppc2-one-targeted-reg-form seg form s32))
        (ensuring-node-target (target vreg)
          (! s16->fixnum target (ppc::set-regspec-mode s32 (ppc-gpr-mode-name-value :s16)))))
      (^))))

 
(defppc2 ppc2-point-v integer-point-v (seg vreg xfer form)
  (if (null vreg)
    (ppc2-form seg nil xfer form)
    (with-imm-target () (s32 :s32)
      (let* ((immval (ppc2-long-constant-p form)))
        (if immval
          (ppc2-lwi seg s32 immval)
          (ppc2-one-targeted-reg-form seg form s32))
        (ensuring-node-target (target vreg)
          (! s32-highword target s32))
      (^)))))

         
(defppc2 ppc2-%vreflet %vreflet (seg vreg xfer vars vals body p2decls)
  (let* ((old-stack (ppc2-encode-stack)))
    (with-ppc-p2-declarations p2decls
      (dolist (var vars)
        (ppc2-vpush-register 
         seg 
         (ppc2-one-untargeted-reg-form seg (pop vals) ppc::arg_z))
        (with-node-temps () (ptr)
          (! macptr->stack ptr ppc::vsp)
          (ppc2-open-undo $undostkblk)
          (ppc2-seq-bind-var seg var ptr)))
      (ppc2-undo-body seg vreg xfer body old-stack)
      (dolist (var vars) (ppc2-close-var seg var)))))


;; Under MacsBug 5.3 (and some others ?), this'll do a low-level user
;; break.  If the debugger doesn't recognize the trap instruction,
;; you'll have to manually advance the PC past it.  "arg" winds up in the
;; arg_z register; whatever's in arg_z on return is returned by
;; the %debug-trap construct.

(defppc2 ppc2-%debug-trap %debug-trap (seg vreg xfer arg)
  (ppc2-one-targeted-reg-form seg arg ppc::arg_z)
  (! %debug-trap)
  (<- ppc::arg_z)
  (^))

;------

#+not-yet
(progn




  


(defppc2 ppc2-short-float short-float (val)
  (ppc2-absolute-long (%address-of val)))










;Make a gcable macptr.
(defppc2 ppc2-%new-ptr %new-ptr (b vreg xfer size clear-p )
  (declare (ignore b vreg xfer size clear-p))
  (error "%New-ptr is a waste of precious silicon."))





       





  






)






