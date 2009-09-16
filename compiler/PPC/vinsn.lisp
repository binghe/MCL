;;;-*- Mode: Lisp; Package: CCL -*-

;; $Log: vinsn.lisp,v $
;; Revision 1.2  2002/11/18 05:37:04  gtbyers
;; Add CVS log marker
;;
;;	Change History (most recent first):
;;  11 3/27/96 gb   3.1d86
;;  10 2/3/96  bill 3.1d64
;;  6 12/22/95 gb   no path in REQUIRE
;;  5 12/12/95 akh  dont eval defstruct at compile time - bad for cross compiling
;;  (do not edit before this line!!)

;; collect is in ccl package
;; --- 5.2b6
;; 01/29/00 akh restore the guts of fixup-vinsn-template so can add opcodes
;; 03/31/97 bill rename the BLOCK structure to COMPILER-BLOCK so we don't
;;               define a structure on the Common Lisp BLOCK symbol.
;; 02/01/97 gb   vinsn-notes, other stuff.
;; -------- 4.0
;; 03/24/96 gb   make-vinsn ignores spurious labels on freelist.
;; 01/19/96 bill vinsn-template-opcode-alist slot, initialize it in define-vinsn,
;;               fixup-vinsn-template, fixup-vinsn-templates.
;; 01/29/96 gb   revive make-vinsn, *vinsn-freelist*.
;; 01/10/96 gb   freelisting; vinsn-templates hash to "cells" for
;;               forward-referencing.
;; 12/27/95 gb   vinsn-attributes mechanism.

(cl:eval-when (:compile-toplevel :load-toplevel :execute)
  (require "DLL-NODE")
  (require "PPC-ASM"))


(cl:in-package "CCL")

; Specifying the same name for a result and an argument basically says that
; it's ok for the vinsn to clobber that argument.  (In all other cases,
; arguments are assumed to be "read-only", and damned well better be.)
; Any results that are also arguments must follow all results that aren't in
; the "results" list; any arguments that are also results must precede
; all arguments that aren't in the "arguments" list, and all hybrids must
; appear in the same order in both lists. This is what "nhybrids" is about
; (and why it defaults to 0 ...)
; Sometimes (often) these hybrid "results" aren't very interesting as results;
; it might be clearer to consider "mutable" arguments as quasi-temporaries.
(defstruct vinsn-template
  name                                  ; a symbol in the PPC package
  result-vreg-specs                     ; one or more vreg specs for values defined by the vinsn
  argument-vreg-specs                   ; may ultimately overlap some result vreg(s)
  ; one or more vreg specs for temporaries used in vinsn.
  ; all such temporaries are assumed to have lifetimes which span all
  ; machine instructions in the vinsn (e.g., they can't conflict with any
  ; registers used for args/results and may have further constraints.
  temp-vreg-specs                  
  local-labels
  body                                  ; list of vinsns, ppc-instructions, local labels
  (nhybrids 0)
  (nvp 0)
  results&args                          ;
  (attributes 0)                        ; attribute bitmask
  opcode-alist                          ; ((number1 . name1) (number2 . name2) ...)
)

#-:ansi-make-load-form
(defmethod make-load-form ((v vinsn-template))
  (make-load-form-saving-slots v))
#+:ansi-make-load-form
(defmethod make-load-form ((v vinsn-template) &optional env)
  (declare (ignore env))
  (make-load-form-saving-slots v))

(defvar *vinsn-templates* (make-hash-table :test #'eq))

(defun get-vinsn-template-cell (name)
  (let* ((n (intern (string name) *ccl-package*)))
    (or (gethash n *vinsn-templates*)
        (setf (gethash n *vinsn-templates*) (cons n nil)))))

(defun need-vinsn-template (name)
  (or (cdr (if (consp name) name (get-vinsn-template-cell name)))
      (error "Unknown vinsn: ~s" name)))

(defun set-vinsn-template (name template)
  (setf (cdr (get-vinsn-template-cell name)) template))

(defstruct (vinsn (:include dll-node)
                  (:print-function print-vinsn)
                  (:constructor %make-vinsn (template)))
  template                              ; The vinsn-template of which this is an instance
  variable-parts                        ; vector of result-vregs, arguments, temps, local-labels
  target-insns                          ; list header or NIL.
)

(defloadvar *vinsn-freelist* (make-dll-node-freelist))

(defun make-vinsn (template)
  (let* ((vinsn (alloc-dll-node *vinsn-freelist*)))
    (loop
      ; Sometimes, PPC2-compile seems to return its node list
      ; to the freelist without first removing the vinsn-labels in it.
      (if (or (null vinsn) (typep vinsn 'vinsn)) (return))
      (setq vinsn (alloc-dll-node *vinsn-freelist*)))
    (if vinsn
      (progn
        (setf (vinsn-template vinsn) template
              (vinsn-variable-parts vinsn) nil
              (vinsn-target-insns vinsn) nil)
        vinsn)
      (%make-vinsn template))))

(eval-when (:load-toplevel :execute)
(defstruct (vinsn-label (:include dll-node)
                        (:print-function print-vinsn-label)
                        (:predicate %vinsn-label-p)
                        (:constructor %make-vinsn-label (id)))
  id
  refs                                  ; vinsns in which this label appears as an operand
  info                                  ; code-generation stuff
)
)

(defloadvar *vinsn-label-freelist* (make-dll-node-freelist))

(defun make-vinsn-label (id)
  (let* ((lab (alloc-dll-node *vinsn-label-freelist*)))
    (if lab
      (progn
        (setf (vinsn-label-id lab) id
              (vinsn-label-refs lab) nil
              (vinsn-label-info lab) nil)
        lab)
      (%make-vinsn-label id))))

; "Real" labels have fixnum IDs.
(defun vinsn-label-p (l)
  (if (%vinsn-label-p l) 
    (typep (vinsn-label-id l) 'fixnum)))

; "pseudo-labels" use the ID field to attach annotations of some sort
; to a code position.
(defun vinsn-note-p (l)
  (if (%vinsn-label-p l)
    (not (typep (vinsn-label-id l) 'fixnum))))

(defun print-vinsn-label (l s d)
  (declare (ignore d))
  (print-unreadable-object (l s :type t)
    (format s "~d" (vinsn-label-id l))))

; Notes are attached to pseudo-labels.  They're used to attach semantic
; information to an execution point. 
; The pseudo-label points to the note via its LABEL-ID; the note has
; a backpointer to the pseudo-label.

(defstruct (vinsn-note
            (:constructor %make-vinsn-note)
            (:print-function print-vinsn-note))
  (label (make-vinsn-label nil))
  (peer nil :type (or null vinsn-note))
  (class nil)
  (info nil :type (or null simple-vector)))


(defun print-vinsn-note (n s d)
  (declare (ignore d))
  (print-unreadable-object (n s :type t)
    (format s "~d" (vinsn-note-class n))
    (let* ((info (vinsn-note-info n)))
      (when info (format s " / ~S" info)))))
  
(defun make-vinsn-note (class info)
  (let* ((n (%make-vinsn-note :class class :info (if info (apply #'vector info))))
         (lab (vinsn-note-label n)))
    (setf (vinsn-label-id lab) n)
    n))

(defun close-vinsn-note (n)
  (let* ((end (%make-vinsn-note :peer n)))
    (setf (vinsn-label-id (vinsn-note-label end)) end
          (vinsn-note-peer end) n
          (vinsn-note-peer n) end)
    end))
        

(defun vinsn-vreg-description (value spec)
  (case (cadr spec)
    ((:u32 :s32 :u16 :s16 :u8 :s8 :lisp :address :imm)
     (let* ((mode (if (typep value 'fixnum)
                    (ppc::get-regspec-mode value))))
       (if (and mode (not (eql 0 mode)))
         (list (ppc::hard-regspec-value value)
               (car (rassoc mode *ppc-mode-name-value-alist* :test #'eq)))
         value)))
    (t value)))

(defun collect-vinsn-variable-parts (v start n &optional specs)
  (declare (fixnum start n))
  (let* ((varparts (vinsn-variable-parts v)))
    (when varparts
  (let* ((head (cons nil nil))
         (tail head))
    (declare (dynamic-extent head) (cons head tail))
    (do* ((j start (1+ j))
              (i 0 (1+ i)))
             ((= i n) (cdr head))
          (declare (fixnum i j))
          (setq tail (cdr (rplacd tail (cons (vinsn-vreg-description (svref varparts j) (pop specs)) nil)))))))))

      
(defun collect-vinsn-results (v)
  (let* ((template (vinsn-template v))
         (result-specs (vinsn-template-result-vreg-specs template)))
    (collect-vinsn-variable-parts v 0 (length result-specs) result-specs)))

(defun collect-vinsn-arguments (v)
  (let* ((template (vinsn-template v))
         (arg-specs (vinsn-template-argument-vreg-specs template)))
    (collect-vinsn-variable-parts v
                                  (- (length (vinsn-template-result-vreg-specs template)) 
                                     (vinsn-template-nhybrids template))
                                  (length arg-specs)
                                  arg-specs)))

(defun collect-vinsn-temps (v)
  (let* ((template (vinsn-template v)))
    (collect-vinsn-variable-parts v 
                                  (+
                                   (length (vinsn-template-result-vreg-specs template)) 
                                   (length (vinsn-template-argument-vreg-specs template)))
                                  (length (vinsn-template-temp-vreg-specs template)))))

(defun template-infix-p (template)
  (declare (ignore template))
  nil)

(defun print-vinsn (v stream d)
  (declare (ignore d))
  (let* ((template (vinsn-template v))
         (results (collect-vinsn-results v))
         (args (collect-vinsn-arguments v))
         (opsym (if (cdr results) :== :=))
         (infix (and (= (length args) 2) (template-infix-p template)))
         (opname (vinsn-template-name template)))
    (print-unreadable-object (v stream)
      (if results (format stream "~A ~S " (if (cdr results) results (car results)) opsym))
      (if infix
        (format stream "~A ~A ~A" (car args) opname (cadr args))
        (format stream "~A~{ ~A~}" opname args)))))
  
(defparameter *known-vinsn-attributes* '(
  :jump                                 ; an unconditional branch
  :branch                               ; a conditional branch
  :call                                 ; a jump that returns
  :funcall                              ; A full function call, assumed to bash all volatile registers
  :subprim-call                         ; A subprimitive call; bashes some volatile registers
  :jumpLR                               ; Jumps to the LR, possibly stopping off at a function along the way.
  :lrsave                               ; saves LR in LOC-PC
  :lrrestore                            ; restores LR from LOC-PC
  :lispcontext                          ; references lisp frame LOC-PC, FN, and entry VSP
  :node                                 ; saves/restores a node value in stack-like memory
  :word                                 ; saves/restores an unboxed word in stack-like memory
  :doubleword                           ; saves/restores an unboxed doubleword (fp-reg) in stack-like memory
  :vsp                                  ; uses the vsp to save/restore
  :tsp                                  ; uses the tsp to save/restore
  :csp                                  ; uses sp to save/restore
  :push                                 ; saves something
  :pop                                  ; restores something
  :multiple                             ; saves/restores multiple nodes/words/doublewords
  :ref                                  ; references memory
  :set                                  ; sets memory
  :outgoing-argument                    ; e.g., pushed as an argument, not to avoid clobbering
  :xref                                 ; makes some label externally visible
))

(defparameter *nvp-max* 6 "size of *vinsn-varparts* freelist elements")
(defloadvar *vinsn-varparts* (%cons-pool))

(defun alloc-varparts-vector ()
  (without-interrupts
   (let* ((v (pool.data *vinsn-varparts*)))
     (if v
       (progn
         (setf (pool.data *vinsn-varparts*)
               (svref v 0))
         #+ppc-target (%init-misc 0 v)
         #-ppc-target (fill v 0)
         v)
       (make-array (the fixnum *nvp-max*) :initial-element 0)))))

(defun free-varparts-vector (v)
  (without-interrupts
   (setf (svref v 0) (pool.data *vinsn-varparts*)
         (pool.data *vinsn-varparts*) v)
   nil))

(defun encode-vinsn-attributes (attribute-list)
  (flet ((attribute-weight (k)
           (let* ((pos (position k *known-vinsn-attributes*)))
             (if pos (ash 1 pos) (error "Unknown vinsn attribute: ~s" k)))))
    (let* ((attr 0))
      (declare (fixnum attr))
      (dolist (a attribute-list attr)
        (setq attr (logior attr (the fixnum (attribute-weight a))))))))

; This defines a template.  All expressions in the body must be evaluable at macroexpansion time.
(defmacro define-vinsn (vinsn-name (results args &optional temps) &body body)
  (let* ((name-list ())
          (attrs 0)
         (nhybrids 0)
         (local-labels ())
         (referenced-labels ())
         (opcode-alist ()))
    (flet ((valid-spec-name (x) (or (and (consp x) 
                                         (consp (cdr x)) 
                                         (null (cddr x)) 
                                         (atom (car x))
                                         (or (assoc (cadr x) *vreg-specifier-constant-constraints* :test #'eq)
                                             (assoc (cadr x) *spec-class-storage-class-alist* :test #'eq)
                                             (eq (cadr x) :label)
                                             (and (consp (cadr x))
                                                  (or 
                                                   (assoc (caadr x) *vreg-specifier-constant-constraints* :test #'eq)
                                                   (assoc (caadr x) *spec-class-storage-class-alist* :test #'eq)
                                                   )))
                                         (car x))
                                    (error "Invalid vreg spec: ~s" x)))
           (add-spec-name (vname) 
             (if (member vname name-list :test #'eq)
               (error "Duplicate name ~s in vinsn ~s" vname vinsn-name)
               (push vname name-list))))
      (declare (dynamic-extent valid-spec-name add-spec-name))
      (when (consp vinsn-name)
        (setq attrs (encode-vinsn-attributes (cdr vinsn-name))
              vinsn-name (car vinsn-name)))
      (unless (and (symbolp vinsn-name) (eq *CCL-PACKAGE* (symbol-package vinsn-name)))
        (setq vinsn-name (intern (string vinsn-name) *CCL-PACKAGE*)))
      (dolist (n (append args temps))
        (add-spec-name (valid-spec-name n)))
      (dolist (form body)
        (if (atom form)
          (add-spec-name form)))
      (setq name-list (nreverse name-list))
      ; We now know that "args" is an alist; we don't know if "results" is.
      ; First, make sure that there are no duplicate result names (and validate "results".)
      (do* ((res results tail)
            (tail (cdr res) (cdr tail)))
           ((null res))
        (let* ((name (valid-spec-name (car res))))
          (if (assoc name tail :test #'eq)
            (error "Duplicate result name ~s in ~s." name results))))
      (let* ((non-hybrid-results ()) 
             (match-args args))
        (dolist (res results)
          (let* ((res-name (car res)))
            (if (not (assoc res-name args :test #'eq))
              (if (not (= nhybrids 0))
                (error "result ~s should also name an argument. " res-name)
                (push res-name non-hybrid-results))
              (if (eq res-name (caar match-args))
                (setf nhybrids (1+ nhybrids)
                      match-args (cdr match-args))
                (error "~S - hybrid results should appear in same order as arguments." res-name)))))
        (dolist (name non-hybrid-results)
          (add-spec-name name)))
      (let* ((k -1))
        (declare (fixnum k))
        (let* ((name-alist (mapcar #'(lambda (n) (cons n (list (incf k)))) name-list)))
          (flet ((find-name (n)
                   (let* ((pair (assoc n name-alist :test #'eq)))
                     (declare (list pair))
                     (if pair (cdr pair) (error "Unknown name ~s" n)))))
            (labels ((simplify-operand (op)
                       (if (atom op)
                         (if (typep op 'fixnum)
                           op
                           (if (constantp op)
                             (progn
                               (if (keywordp op)
                                 (pushnew op referenced-labels))
                               (eval op))
                             (find-name op)))
                         (if (eq (car op) :apply)
                           `(,(cadr op) ,@(mapcar #'simplify-operand (cddr op)))
                            (simplify-operand (eval op))))))    ; Handler-case this?         
              (labels ((simplify-constraint (guard)
                         ;; A constraint is one of
                         ;; (:eq|:lt|:gt vreg-name constant)       ; "value" of vreg relop constant
                         ;; (:pred <function-name> <operand>*  ; <function-name> unquoted,
                         ;;      each <operand> is a vreg-name or constant expression.
                         ;; (:type vreg-name typeval)      ; vreg is of "type" typeval
                         ;; (:not <constraint>)            ;  constraint is false
                         ;; (:and <constraint> ...)        ;  conjuntion
                         ;; (:or <constraint> ...)         ;  disjunction
                         ;; There's no "else"; we'll see how ugly it is without one.
                         (destructuring-bind (guardname &rest others) guard
                           (ecase guardname
                             (:not 
                              (destructuring-bind (negation) others
                                `(:not ,(simplify-constraint negation))))
                             (:pred
                              (destructuring-bind (predicate &rest operands) others
                                `(:pred ,predicate ,@(mapcar #'simplify-operand operands))))
                             ((:eq :lt :gt :type)
                              (destructuring-bind (vreg constant) others
                                (unless (constantp constant)
                                  (error "~S : not constant in constraint ~s ." constant guard))
                                `(,guardname ,(find-name vreg) ,(eval constant))))
                             ((:or :and)
                              (unless others (error "Missing constraint list in ~s ." guard))
                              `(,guardname ,(mapcar #'simplify-constraint others))))))
                       (simplify-form (form)
                         (if (atom form)
                           (progn 
                             (push form local-labels) 
                             form)
                           (destructuring-bind (&whole w opname &rest opvals) form
                             (if (consp opname)         ; A constraint, we presume ...
                               (cons (simplify-constraint opname)
                                     (mapcar #'simplify-form opvals))
                               (if (keywordp opname)
                                 form
                                 (let* ((name (string opname))
                                        (opnum (gethash name ppc::*ppc-opcode-numbers*)))
                                   (if (not opnum)
                                     (let* ((expander (ppc::ppc-macro-function name)))
                                       (if expander
                                         (simplify-form (funcall expander form nil))
                                         (error "Unknown PPC instruction in ~s" form)))
                                     (let* ((opcode (if (< -1 opnum (length ppc::*ppc-opcodes*))
                                                      (svref ppc::*ppc-opcodes* opnum)
                                                      (error "~& Invalid PPC opcode: ~s" name)))
                                            (opvals (mapcar #'simplify-operand opvals)))
                                       (setf (assq opnum opcode-alist) name)
                                       (let* ((operands (ppc::ppc-opcode-operands opcode))
                                              (nmin (ppc::ppc-opcode-min-args opcode))
                                              (nmax (ppc::ppc-opcode-max-args opcode))
                                              (nhave (length opvals)))
                                         (declare (fixnum nreq nhave))
                                         (if (= nhave nmax)
                                           `(,opnum ,@opvals)
                                           (if (> nhave nmax)
                                             (error "Too many operands in ~s (~a accepts at most ~d)"
                                                    (cdr w) name nmax)
                                             (if (= nhave nmin)
                                               (let* ((newops ()))
                                                 (dolist (op operands `(,opnum ,@(nreverse newops)))
                                                   (let* ((flags (ppc::ppc-operand-flags op)))
                                                     (unless (logbitp ppc::$ppc-operand-fake flags)
                                                       (push (if (logbitp ppc::$ppc-operand-optional flags)
                                                               0
                                                               (pop opvals))
                                                             newops)))))
                                               (error "Too few operands in ~s : (~a requires at least ~d)"
                                                      (cdr w) name nmin))))))))))))))
                 (let* ((template (make-vinsn-template :name vinsn-name
                                                      :result-vreg-specs results
                                                      :argument-vreg-specs args
                                                      :temp-vreg-specs temps
                                                      :nhybrids nhybrids
                                                       :results&args (append results (nthcdr nhybrids args))
                                                      :nvp (- (+ (length results) (length args) (length temps))
                                                              nhybrids)
                                                      :body (prog1 (mapcar #'simplify-form body)
                                                              (dolist (ref referenced-labels)
                                                                (unless (memq ref local-labels)
                                                                  (error 
                                                                   "local-label ~S was referenced but ~
                                                                    never defined in VINSN-TEMPLATE definition for ~s"
                                                                   ref vinsn-name))))
                                                      :local-labels local-labels
                                                      :attributes attrs
                                                      :opcode-alist opcode-alist)))
                  
                  `(progn
                     (set-vinsn-template ',vinsn-name ,template)
                     (record-source-file ',vinsn-name 'vinsn)
                     ',vinsn-name))))))))))

; Fix the opnum's in the vinsn-template-body to agree with ppc::*ppc-opcode-numbers*
(defun fixup-vinsn-template (orig-template)
  ; Need to update for Gary's new *vinsn-templates* entry form
  (let* ((template (cdr orig-template)))
    (unless (vinsn-template-p template)
      (setq template (require-type template 'vinsn-template)))
    (let ((new-opcode-alist nil)
          (changes nil)
          (opcode-alist (vinsn-template-opcode-alist template)))
      ; this is patterned after ppc2-expand-vinsn
      (labels ((walk-form (f)
                 (unless (atom f)
                   (if (fixnump (car f))
                     (got-one f)
                     (dolist (subform (cdr f))
                       (walk-form subform)))))
               (got-one (f)
                 (let* ((old-opcode (car f))
                        (name (cdr (assq old-opcode opcode-alist)))
                        (new-opcode (and name (gethash name ppc::*ppc-opcode-numbers*))))
                   (unless new-opcode
                     (cerror "Continue" "Can't find new opcode number for ~s in ~s" (car f) template))
                   (setf (assq new-opcode new-opcode-alist) name)
                   (unless (eq new-opcode old-opcode)
                     (push (cons f new-opcode) changes)))))
        (mapc #'walk-form (vinsn-template-body template))
        (without-interrupts
         (dolist (change changes)
           (setf (caar change) (cdr change)))
         (setf (vinsn-template-opcode-alist template) new-opcode-alist))))    
    orig-template))

(defun fixup-vinsn-templates ()
  (maphash #'(lambda (name template)
               (declare (ignore name))
               (fixup-vinsn-template template))
           *vinsn-templates*))
                                       
; Could probably split this up and do some arg checking at macroexpand time.
(defun match-template-vregs (template vinsn supplied-vregs)
  (declare (list supplied-vregs))
  (let* ((nsupp (length supplied-vregs))
         (results&args (vinsn-template-results&args template))
         (nra (length results&args))
         (temp-specs (vinsn-template-temp-vreg-specs template))
         (ntemps (length temp-specs))
         (nvp (vinsn-template-nvp template))
         (vp (alloc-varparts-vector))
         (*ppc-node-temps* *ppc-node-temps*)
         (*ppc-imm-temps* *ppc-imm-temps*)
         (*ppc-crf-temps* *ppc-crf-temps*))
    (declare (fixnum nvp ntemps nsupp)
             (list result-specs temp-specs arg-specs))
    (unless (= nsupp nra)
      (error "Vinsn ~A expects ~D result/argument specs, received ~D ."
             (vinsn-template-name template) nra nsupp))
    (do* ((i 0 (1+ i))
          (supp supplied-vregs (cdr supp))
          (spec results&args (cdr spec)))
         ((null supp))
      (declare (fixnum i) (list spec supp))
      (setf (svref vp i) (match-vreg (car supp) (cadar spec) vinsn vp i)))
    ;; Allocate some temporaries.
    (do* ((i (- nvp ntemps) (1+ i))
          (temps temp-specs (cdr temps)))
         ((null temps) vp)
      (declare (fixnum i))
      (let* ((lreg (allocate-temporary-vreg (car temps))))      
        (setf (svref vp i) lreg)
        (pushnew vinsn (lreg-defs lreg))
        (pushnew vinsn (lreg-refs lreg))))))

; "spec" is (<name> <class>).  *** Why name ? ***
;  <class> is keyword or (<keyword> <val>)
(defun allocate-temporary-vreg (spec)
  (setq spec (cadr spec))
  (let* ((class (if (atom spec) spec (car spec)))
         (value (if (atom spec) nil (cadr spec))))
    (if value
      (ecase class
        (:crf (ppc2-make-wired-lreg (ppc-use-crf-temp value) :class ppc::hard-reg-class-crf))
        ((:u8 :s8 :u16 :s16 :u32 :s32) 
         (ppc2-make-wired-lreg (ppc-use-imm-temp value)
                               :class ppc::hard-reg-class-gpr
                               :mode (ppc-gpr-mode-name-value class)))
        (:lisp (ppc2-make-wired-lreg 
                (ppc-use-node-temp value) 
                :class ppc::hard-reg-class-gpr
                :mode ppc::hard-reg-class-gpr-mode-node)))
      (ecase class
        ((:imm :wordptr) 
         (ppc2-make-unwired-lreg
          (if (= *ppc-imm-temps* 0) (ppc-select-node-temp) (ppc-select-imm-temp))
              :class ppc::hard-reg-class-gpr
              :mode ppc::hard-reg-class-gpr-mode-node)) 
        ((:u8 :s8 :u16 :s16 :u32 :s32) 
         (ppc2-make-unwired-lreg (ppc-select-imm-temp)
                                 :class ppc::hard-reg-class-gpr
                                 :mode (ppc-gpr-mode-name-value class)))
        (:lisp 
         (ppc2-make-unwired-lreg 
                (ppc-select-node-temp) 
                :class ppc::hard-reg-class-gpr
                :mode ppc::hard-reg-class-gpr-mode-node))
        (:crf 
         (ppc2-make-unwired-lreg (ppc-select-crf-temp) :class ppc::hard-reg-class-crf))))))



(defun select-vinsn (template-or-name vregs)
  (let* ((template (need-vinsn-template template-or-name))
         (vinsn (make-vinsn template)))
    (setf (vinsn-variable-parts vinsn) (match-template-vregs template vinsn vregs))
    vinsn))

(defun %emit-vinsn (vlist name &rest vregs)
  (append-dll-node (select-vinsn name vregs) vlist))


;;; Flow-graph nodes (FGNs)

(defstruct (compiler-block 
            (:conc-name "BLOCK-")
            (:include dll-header)
            (:constructor %make-block))
  (node))

(defun make-block ()
  (let* ((b (%make-block)))
    (setf (dll-header-first b) b
          (dll-header-last b) b)))

(defstruct (fgn (:include dll-node))
  (inedges ())                          ; list of nodes which reference this node
  (visited nil)                         ; Boolean
)

; Some things (CATCH and UNWIND-PROTECT cleanup forms)
; are made visible to "external" code
(defstruct (external-ref (:include fgn))
  (out-ref ()))

(defstruct (flownode (:include fgn))
  (block (make-block))                  ; vinsns contained in this node
  (xvis nil)                            ; nodes made "externally visible"
)

; FGNs which don't terminate with an "external jump"
; (jump-return-pc/jump-subprim, etc) jump to their
; successor, either explicitly or by falling through.
; We can introduce or remove jumps when linearizing
; the program.
(defstruct (jumpnode (:include flownode))
  (outedge)                             ; the FGN we jump/fall in to.
)

; A node that ends in a conditional branch, followed
; by an implicit or explicit jump.  Keep track of
; the conditional branch and the node it targets.
(defstruct (condnode (:include jumpnode))
  (condbranch)                          ; the :branch vinsn
  (branchedge)                          ; the FGN it targets
)

; A node that terminates with a branch to "external code",
; i.e., a jump-return-pc or jump-subprim.
(defstruct (xjumpnode (:include flownode))
)

(defstruct fgn-function
  (nodes (make-dll-header))
  (externals (make-dll-header)))


(defun %vinsn-attribute-p (vinsn mask)
  (declare (fixnum mask))
  (if (vinsn-p vinsn)
    (let* ((template (vinsn-template vinsn)))
      (not (eql 0 (logand mask (the fixnum (vinsn-template-attributes template))))))))

(defmacro vinsn-attribute-p (vinsn &rest attrs)
  `(%vinsn-attribute-p ,vinsn ,(encode-vinsn-attributes attrs)))

; Ensure that conditional branches that aren't followed
; by jumps are followed by (jump lab-next) @lab-next.
; Ensure that JUMPs and JUMPLRs are followed by labels.
; It's easiest to do this by walking backwards.
; When we're all done, labels will mark the start of each block.
(defun normalize-vinsns (header)
  (do* ((prevtype :label currtype)
        (current (dll-header-last header) (dll-node-pred current))
        (currtype nil))
       ((eq current header))
    (setq currtype (cond ((vinsn-label-p current) :label)
                         ((vinsn-attribute-p current :branch) :branch)
                         ((vinsn-attribute-p current :jump) :jump)
                         ((vinsn-attribute-p current :jumplr) :jumplr)))
    (case currtype
      ((:jump :jumplr)
       (unless (eq prevtype :label)
         (let* ((lab (aref *ppc2-labels* (ppc2-get-next-label))))
           (insert-dll-node-after lab current))))
      (:branch
        (unless (eq prevtype :jump)
          (let* ((lab (aref *ppc2-labels* (ppc2-get-next-label)))
                 (jump (select-vinsn "JUMP" (list lab))))
            (insert-dll-node-after lab current)
            (insert-dll-node-after jump current))))))
  '(when *ppc2-debug-vinsns*
    (format t "~%~% normalized:~%~%")
    (do-dll-nodes (v header) (format t "~&~s" v))))
            
                         
(defun delete-unreferenced-labels (labels)
  (delete #'(lambda (l)
              (unless (vinsn-label-refs l)
                (when (vinsn-label-succ l)
                  (remove-dll-node l))
                t)) labels :test #'funcall))

(defun optimize-vinsns (header)
  ; Delete unreferenced labels that the compiler might
  ; have emitted.  Subsequent operations may cause
  ; other labels to become unreferenced.
  (let* ((labels (collect ((labs)) 
                   (do-dll-nodes (v header)
                     (when (vinsn-label-p v) (labs v)))
                   (labs))))
    ; Look for pairs of adjacent, referenced labels.
    ; Merge them together (so that one of them becomes unreferenced.)
    ; Repeat the process until no pairs are found.
    (do* ((repeat t))
         ((not repeat))
      (setq repeat nil 
            labels (delete-unreferenced-labels labels))
      (dolist (l labels)
        (let* ((succ (vinsn-label-succ l)))
          (when (vinsn-label-p succ)
            (ppc2-merge-labels l succ)
            (setq repeat t)
            (return)))))
    (delete-unreferenced-labels labels)
    '(when *ppc2-debug-vinsns*
      (format t "~& optimized:~%~%")
      (do-dll-nodes (v header) (format t "~&~s - (~s)" v (if (typep v 'vinsn)
                                                           (vinsn-sets-gpr-p v ppc::temp0)))))
    (normalize-vinsns header)
  ))

(ccl::provide "VINSN")
