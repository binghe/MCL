;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: encapsulate.lisp,v $
;;  Revision 1.8  2004/11/05 21:30:54  alice
;;  cvs haters anonymous
;;
;;  Revision 1.7  2004/11/05 21:19:05  alice
;;  *** empty log message ***
;;
;;  Revision 1.6  2004/11/03 20:55:59  svspire
;;  remove check for accessor methods in #'encapsulate when new MOP implementation. Encapsulating accessor methods seems to work now.
;;
;;  Revision 1.5  2004/06/18 04:06:08  alice
;;  ;; *trace-print-level* and *trace-print-length* can be :follow-print meaning use *print-level* or *print-length*
;; idea from Gary King.
;;
;;  Revision 1.4  2003/12/08 08:08:16  gtbyers
;;  Change uses of gf.dcode, since that symbol now names a constant.
;;
;;  10 7/18/96 akh  fix advise to not require compiler at load time. 
;;                         conditionalize for new clos (ppc or 68k) vs old clos (68k)
;;  9 6/16/96  akh  fix for new generic function scheme
;;  8 3/9/96   akh   apply-with-method-context macro in level-2 now
;;  7 2/8/96   akh  fix advise of methods (pass fn not symbol to %ppc-apply -xxx)
;;  6 1/28/96  akh  fix for new clos, make trace/advise of generic functions work
;;  4 10/31/95 akh  saved-method-var stuff
;;  3 10/17/95 akh  fix some more for nwo re gf's
;;  2 10/10/95 akh  %%call-encapsulated-gf etc. for nwo
;;  (do not edit before this line!!)


;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995-1999 Digitool, Inc.


;; encapsulate no longer errors for standard-accessor-method
;; ---------- 5.1b4
;; 11/3/04 SS remove check for accessor methods in #'encapsulate when new MOP implementation

;; *trace-print-level* and *trace-print-length* can be :follow-print meaning use *print-level* or *print-length*
;; idea from Gary King.
;; ------ 5.1b2
;; 12/05/99 akh advising or tracing reader and writer methods doesn't work so error for now.
;; -------- 4.3f1c1
; akh fix advise to not require compiler at load time. 
;          conditionalize for new clos (ppc or 68k) vs old clos (68k)
;10/09/93 alice %trace-function-spec-p fix bogus type check for specializers
;----------
; 03/07/93 alice trace-global-def don't assume before and after fns need to be quoted
; 11/13/92 alice advise and trace tell user about compiler warnings,
; 		 equal not eq for comparing advice-names.
; 10/08/92 alice trace and advise get better error messages
; 06/22/92 alice trace :step of gf traces :step all the methods
; 06/16/92 alice make trace etal work for (EQL ..) methods
; 06/01/92 alice %untrace allow ((:method ..)) as well as (:method ..)
;--------------- 2.0
; 12/14/91 alice %trace when step just check for lamda exists
; ---------------- 2.0b4
; 10/16/91 alice added advisedp, changed unadvise arglist to correspond, (trace (:method ..))
;--------------- 2.0b3
; 08/29/91 alice remove-encapsulalation had a glitch if method
; 08/14/91 bill  encapsulation no longer changes the type of a generic-function
;                forget-encapsulations in %defun-encapsulated-maybe if old def was a generic function
; 06/12/91 alice %trace-function-spec-p - fix for anonymous setf functions (e.g. (defsetf poo ..))
;---------- 2.0b2
; 03/22/91 alice trace-before and trace-after bind *print-readably* nil
; 03/04/91 alice give report-bad-arg's a second argument
;---------- 2.0b1
; 12/11/90 alice fix around advice
; ---------------------- 2.0a4
; 11/27/90 alice add another arg for %trace and advise - :define-if-not. Change advise arglist
; 11/23/90 alice allow (trace (setf car)), step predicate gets name as well as args
; 10/18/90 alice add trace-bar-frequency since its documented
; 10/18/90 alice trace and advise will define that which is undefined per Alan, Interlisp
;          (gsb and jh don't like this so add another flag) 
; 10/11/90 alice add step as trace option
; 10/05/90 alice if trace :before but not :after do call the original def
; 09/13/90 alice no compiler warning from trace-global-def
; 07/29/90 bill  & alice: Do the right thing for tracing methods w/call-next-method
; 07/25/90 alice fix bug in advise resulting in multiple instances of same advice-name
; 07/17/90 alice make trace and advise give the encapsulation fns a sensible name
;                which makes the need for special printers obsolete.
; 07/17/90 alice remove bogus def of write-a-function - the correct one is in l1-io
; 07/06/90 bill make function-encapsulation take a function so that
;               find-unencapsulated-definition will too.
;               remove-obsoleted-combined-methods on changing a %method-function
; 06/04/90 dont use plists, put in gb's fixes for e.g.defun (setf baz)
; 05/16/90 new
; 05/20/90 make trace-alist shorter, try ditto for advise alist
; 05/21/90 advice on methods too - seems o.k.
; 05/21/90 save trace and advice when redefining methods
; 05/22/90 make %defmethod work when generic-function is traced
;          if advice-name already exists - replace (where?)
;          make function and method printers know about encapsulations 

(in-package "CCL")

;; Lets try encapsulations
;; trace is here too
;; Make trace like 1.3, trace methods, trace (setf car)


(defvar *trace-alist* nil)
(defvar *trace-enable* t)
(defvar *trace-level* 0)
(defparameter *trace-max-indent* 40)
(defvar *trace-print-level* :follow-print)  ;; follow print-level
(defvar *trace-print-length* :follow-print)  ;; follow print-length
;(defparameter *trace-define-if-undefined* nil)
(defparameter *trace-bar-frequency* nil)


(defvar *advise-alist* nil)

(defparameter *encapsulation-table*
  (make-hash-table :test #'eq :rehash-size 2 :size 2))

(defstruct (encapsulation)
  symbol         ; the uninterned name containing original def
  type           ; trace or advise
  spec           ; the original function spec
  advice-name    ; optional
  advice-when    ; :before, :after, :around 
  owner          ; where encapsulation is installed
)

(defun setf-function-spec-name (spec)
  (if (and (consp spec) (eq (car spec) 'setf))
    (or (%setf-method (cadr spec)) ; this can be an anonymous function
        (setf-function-name (cadr spec)))
    spec))


(defun trace-tab (&aux (n (min *trace-level* *trace-max-indent*)))
  (fresh-line *trace-output*)
  (dotimes (i n)
    (declare (fixnum i))
    (tyo (if (and *trace-bar-frequency* 
                  (eq 0 (mod i *trace-bar-frequency*)))
           #\| #\Space) *trace-output*)))

(defun get-trace-print-level ()
  (let ((foo *trace-print-level*))
    (if (eq foo :follow-print)
      *print-level*
      (check-print-parameter foo))))

(defun get-trace-print-length ()
  (let ((foo *trace-print-length*))
    (if (eq foo :follow-print)
      *print-length*
      (check-print-parameter foo))))

(defun check-print-parameter (value)
  (assert (or (eq value nil)
              (and (fixnump value)
                   (plusp value))))
  value)
  

(defun trace-before  (&rest args)
  (declare (dynamic-extent args))
  (trace-tab)
  (let* ((*print-level* (get-trace-print-level))
         (*print-length* (get-trace-print-length))
         (*print-readably* nil))
    (format *trace-output* "Calling ~S ~%" args)))

(defun trace-after (sym &rest args &aux (n (length args)))
  (declare (dynamic-extent args))
  (let* ((*print-level* (get-trace-print-level))
         (*print-length* (get-trace-print-length))
         (*print-readably* nil))
    (if (eq n 1)
      (progn
        (trace-tab)
        (format *trace-output* "~S returned ~S~%" sym (%car args)))
      (progn
        (trace-tab)
        (format *trace-output* "~S returned ~S values :" sym n)
        (dolist (val args)
          (trace-tab)
          (format *trace-output* "     ~S" val))))))

(defun forget-encapsulations (name)
  (when (%traced-p name)
    (format t "~%... Untracing ~a" name) 
    (%untrace-1 name))
  (when (%advised-p name nil nil t)
    (format t "~%... Unadvising ~a" name) 
    (unadvise-1 name))
  nil)

(defun function-encapsulated-p (fn-or-method)
  (typecase fn-or-method
    ((or method symbol cons)(function-encapsulation fn-or-method))
    (function
     (or (function-traced-p fn-or-method)
         (function-advised-p fn-or-method )))))

(defun function-traced-p (fn)
  (%function-in-alist fn *trace-alist*))

(defun function-advised-p (fn)
  (%function-in-alist fn *advise-alist*))                           

(defun %function-in-alist (def list)
  (dolist (cap list)
    (let ((symbol (encapsulation-owner cap)))
      (typecase symbol
        (symbol (when (eq (fboundp symbol) def)
                  (return cap)))
        (method (when (eq (%method-function symbol) def)
                  (return cap)))
        (standard-generic-function
         (when (eq symbol def) (return cap)))))))

(defun function-encapsulation (spec)
  (typecase spec
    ((or symbol method)
     (gethash spec *encapsulation-table*))
    (function (function-encapsulated-p spec))
    (cons (gethash (setf-function-spec-name spec) *encapsulation-table*))))
;; i.e. old 68K clos - vs 68K target with new clos

#-ppc-clos
(defun %%call-encapsulated-gf (&lap &rest args)
  (lap
    ; atemp1 contains (gf . dcode)
    (move.l (cdr atemp1) atemp0)        ; dcode
    (move.l (car atemp1) atemp1)        ; gf
    (pea (atemp1 12))                   ; bogus return address
    (move.l (atemp1 2) atemp1)          ; dispatch-table
    (jmp @atemp0)))


; she works now - does the equivalent of the original gf - called from traced def
#+ppc-clos
(defun %%call-encapsulated-gf (thing args)
  ; (print 'one)(print thing)(print args)
  ; thing is gf . %%1st-arg-dcode
  ; args is ok
  (let* ((dcode (cdr thing))
         (proto (assq dcode dcode-proto-alist))  ; <<
         (dt (%gf-dispatch-table (car thing))))
    (if proto ; assume all of these special dudes want args individually 
      (if (listp args)
        (apply dcode dt args)
        (%apply-lexpr dcode dt args))
      (funcall dcode dt args))))
    


#-ppc-clos
(defun %%call-gf-encapsulation (&lap &rest args)
  (lap
    ; atemp1 contains (encapsulation gf . dcode)
    (add.l ($ 4) sp)                    ; pop bogus return address
    (move.l (car atemp1) atemp0)        ; encapsulation
    (jmp @atemp0)))                     ; (apply encapsulation args)


;; the dcode function of the original gf has been bashed with a combined method whose
;; dcode function is this. So the combined method is called with 2 args (dispatch-table
;; and args to the gf). The combined method in turn makes a lexpr of those 2 args.
#+ppc-clos
(defun %%call-gf-encapsulation (thing args)
  ; (print 'two)(print thing)(print (if (listp args) args (collect-lexpr-args args 0)))
  ; thing traced-blitz  gf-blitz . %%1st-arg-dcode  
  ; args = dispatch-table . original-args
  ;  dont need dispatch-table - its just there as a side effect
  (if (listp args)  ; this probably never happens
    (let ((orig-args (cadr args)))
      (if (listp orig-args)
        (apply (car thing) orig-args)
        (%apply-lexpr (car thing) orig-args)))
    (let* ((orig-args (%lexpr-ref args (%lexpr-count args) 1)))
      (if (listp orig-args)
        (apply (car thing) orig-args)
        ; knee deep in lexprs
        (%apply-lexpr (car thing) orig-args)))))
    

(defun encapsulate (fn-spec old-def type trace-spec newsym
                            &optional advice-name advice-when)
  (let ((capsule (function-encapsulation fn-spec))
        gf-dcode old-encapsulation)
    #-:MCL-COMMON-MOP-SUBSET
    (WHEN (and (or (eq type 'advice)(eq type 'trace))  ;; always true
               (typep fn-spec 'standard-accessor-method))
      (error "Can't trace or advise ~s ." fn-spec))  
    (%fhave newsym
            (if (standard-generic-function-p old-def)
              (let ((dcode (%gf-dcode old-def)))
                (setq gf-dcode
                      (if (and (combined-method-p dcode)
                               (eq '%%call-gf-encapsulation
                                   (function-name (%combined-method-dcode dcode))))
                        (let ((stuff (%combined-method-methods dcode)))
                          (setq old-encapsulation (car stuff))
                          (cdr stuff))
                        (cons old-def dcode)))
                #+ppc-clos
                (setf (uvref old-def 0)(uvref *gf-proto* 0))  ; <<  gotta remember to fix it
                (or old-encapsulation
                    (%cons-combined-method old-def gf-dcode #'%%call-encapsulated-gf)))
              old-def))                 ; make new symbol call old definition
    ;; move the encapsulation from fn-spec to sym    
    (cond (capsule (put-encapsulation newsym capsule)))    
    (put-encapsulation fn-spec
                       (make-encapsulation
                        :symbol newsym
                        :type type
                        :spec trace-spec
                        :advice-name advice-name
                        :advice-when advice-when))
    (values newsym gf-dcode)))
 

;; call with cap nil to remove - for symbol anyway
;; maybe advising methods is silly - just define a before method

(defun put-encapsulation (spec cap)
  (when cap
    (setf (encapsulation-owner cap) spec)
    (record-encapsulation cap)
    )
  (let ((key (typecase spec
               ((or symbol method standard-generic-function) spec)
               (cons (setf-function-spec-name spec))
               (t (report-bad-arg spec '(or symbol method cons))))))
    (if cap
      (setf (gethash key *encapsulation-table*) cap)
      (remhash key *encapsulation-table*)))
  cap)

(defun remove-encapsulation (capsule &optional dont-replace)
  ; optional don't replace is for unadvising, tracing all on a method
  (let (spec nextsym newdef def)
    (setq spec (encapsulation-owner capsule))
    (setq def (typecase spec
                (symbol (fboundp spec))
                (method spec)))
    (setq nextsym (encapsulation-symbol capsule))
    (setq newdef (fboundp nextsym))
    (without-interrupts
     (if (standard-generic-function-p def)
       (if (and (combined-method-p newdef)
                (eq '%%call-encapsulated-gf (function-name (%combined-method-dcode newdef))))
         (let* ((orig-decode (require-type (cdr (%combined-method-methods newdef)) 'function))
                #+ppc-clos
                (proto (cdr (assq orig-decode dcode-proto-alist)))
                ) ; <<
           (setf (%gf-dcode def) orig-decode)
           #+ppc-clos
           (setf (uvref def 0)(uvref (or proto *gf-proto*) 0)))
         (setf (car (%combined-method-methods (%gf-dcode def))) newdef))
       (typecase spec
         (symbol (%fhave spec newdef))
         (method (setf (%method-function spec) newdef)
                 (remove-obsoleted-combined-methods spec)
                 newdef)))
     (put-encapsulation spec
                        (if (null dont-replace)
                          (function-encapsulation nextsym)))
     (put-encapsulation nextsym nil)
     (unrecord-encapsulation capsule)
     )))


(defun record-encapsulation (capsule)
  (ecase (encapsulation-type capsule)
    (trace
     (when (not (memq capsule *trace-alist*))
       (push capsule *trace-alist*)))
    (advice
     (when (not (memq capsule *advise-alist*))
       (push capsule *advise-alist*)))))

(defun unrecord-encapsulation (capsule)
  (ecase (encapsulation-type capsule)
    (trace
      (setq *trace-alist* (delq capsule *trace-alist*)))
    (advice
     (setq *advise-alist* (delq capsule *advise-alist*)))))


(defun find-unencapsulated-definition (spec)
  ;; spec is a symbol, function, or method object
  ;; returns a raw function ?? 
  (let (foo)
    (while (setq foo (function-encapsulation spec))
      (setq spec (encapsulation-symbol foo)))
    (values
    (typecase spec
      (symbol (fboundp spec))
      (method (%method-function spec))
      (t spec))
    spec)))

(defun %trace-fboundp (spec)
  (typecase spec
    (symbol (fboundp spec))
    (method (%method-function spec))))


(defun %trace-function-spec-p (spec &optional define-if-not)
  ;; weed out macros and special-forms
  (typecase spec
    (symbol
     (when (or (null spec)(special-form-p spec)(macro-function spec))
       (error "Cannot trace or advise ~S." spec))
     (let ((res (or (fboundp spec)(and define-if-not
                                       (progn (warn "~S was undefined" spec)
                                              (%fhave spec (%function 'trace-null-def)))))))
       (when (not res)(error "~S is undefined." spec))
       (values res spec)))
    (method
     (values (%method-function spec) spec))
    (cons
     (case (car spec)
       (:method 
        (let ((gf (cadr spec))
              (qualifiers (butlast (cddr spec)))
              (specializers (car (last (cddr spec))))
              method)
          (require-type specializers 'list)
          (prog ()
            AGN
            (cond ((setq method
                         (find-method-by-names gf qualifiers specializers))
                   (return (values (%method-function method) method)))
                  (define-if-not
                    (when (define-undefined-method spec gf qualifiers specializers)
                      (go AGN)))
                  (t (error "Method ~s qualifiers ~s specializers ~s not found."
                            gf qualifiers specializers))))))
       (setf
        (let ((name-or-fn (setf-function-spec-name spec)))
          (cond ((symbolp name-or-fn)(%trace-function-spec-p name-or-fn))
                ((functionp name-or-fn) ; its anonymous - give it a name
                 (let ((newname (gensym)))
                   (%fhave newname name-or-fn)
                   (store-setf-method (cadr spec) newname)
                   (values name-or-fn newname))))))))))
    

(defun trace-null-def (&rest ignore)
  (declare (ignore ignore)))

(defun define-undefined-method (spec gf qualifiers specializers)
  (let (vars def)    
    (flet ((blob (e)
                 (let ((v (gensym)))
                   (push v vars)
                   (list v e))))
      (declare (dynamic-extent #'blob))
      (setq def
            (let ((lambda-list (mapcar #' blob specializers)))
              (eval
               `(defmethod ,gf ,@qualifiers (,@lambda-list &rest ignore)
                  (declare (ignore ignore ,@vars))))))
      (when def (warn "~S was undefined" spec))
      def)))

(defun %trace (sym &key before after step define-if-not)  
  (let (def newdef trace-thing)
    (multiple-value-setq (def trace-thing) 
      (%trace-function-spec-p sym define-if-not))
    (if def
      (let ()
        (when (%traced-p trace-thing)
          (%untrace-1 trace-thing)
          (setq def (%trace-fboundp trace-thing)))
        (when step   ; just check if has interpreted def
          (if (typep def 'standard-generic-function)
            (let ((methods (%gf-methods def)))
              ; should we complain if no methods? naah
              (dolist (m methods) ; stick :step-gf in advice-when slot
                (%trace m :step t)
                (let ((e (function-encapsulation m)))
                  (when e (setf (encapsulation-advice-when e) :step-gf))))
              ; we choose to believe that before and after are intended for the gf
              (if  (or before after)
                (setq step nil)                
                (return-from %trace)))
            (uncompile-for-stepping trace-thing nil t)))
        (let ((newsym (gensym "TRACE"))
              (method-p (typep trace-thing 'method)))
          (when (and (null before)(null after)(null step))
            (setq before #'trace-before)
            (setq after #'trace-after))
          (case before 
            (:print (setq before #'trace-before)))
          (case after
            (:print (setq after #'trace-after)))
          (setq newdef (trace-global-def 
                        sym newsym before after step method-p))
          (when method-p
            (copy-method-function-bits def newdef))
          (without-interrupts
           (multiple-value-bind (ignore gf-dcode) (encapsulate trace-thing def 'trace sym newsym)
             (declare (ignore ignore))
             (cond (gf-dcode 
                    (setf (%gf-dcode def)
                          (%cons-combined-method def (cons newdef gf-dcode) #'%%call-gf-encapsulation)))
                   ((symbolp trace-thing) (%fhave trace-thing newdef))
                   ((typep trace-thing 'method)
                    (setf (%method-function trace-thing) newdef)
                    (remove-obsoleted-combined-methods trace-thing)
                    newdef))))))
      (error "Trace does not understand ~S." sym))))

;; sym is either a symbol or a method

(defun %traced-p (sym)
  (let ((foo (function-encapsulation sym)))
    (and foo (eq (encapsulation-type foo) 'trace))))

(defmacro untrace (&rest syms)
  (if syms
    `(%untrace-0 ',syms)
    `(%untrace-all)))

(defun %untrace-0 (syms)
  (let (val x)
    (dolist (symbol syms)
      (setq x (%untrace symbol))
      (when x (push x val)))
    val))


(defun %untrace (sym)
  (when (and (consp sym)(consp (car sym)))
    (setq sym (car sym)))
  (multiple-value-bind (def trace-thing) (%trace-function-spec-p sym)
    (let (val)
      (when (typep def 'standard-generic-function)
        (let ((methods (%gf-methods def)))
          (dolist (m methods)
            (let ((e (function-encapsulation m)))
              (when (and e (eq (encapsulation-advice-when e) :step-gf))
                (remove-encapsulation e)
                (push m  val))))))
      ; gf could have first been traced :step, and then just plain traced
      ; maybe the latter trace should undo the stepping??
      (when (%traced-p trace-thing)
        (%untrace-1 trace-thing)
        (push trace-thing val))
      (if (null (cdr val))(car val) val))))

(defun %untrace-all ()
  (let ((val nil))
    (dolist (cap *trace-alist*)
      (push (encapsulation-spec cap) val)
      (remove-encapsulation cap))
    val))

;; thing is a symbol or method - def is current definition
;; we already know its traced
(defun %untrace-1 (thing)
  (let (capsule)
    (setq capsule (function-encapsulation thing))
    ;; trace encapsulations must be first      
    (when (neq (encapsulation-type capsule) 'trace)
      (error "~S was not traced." thing))
    (remove-encapsulation capsule)
    (encapsulation-spec capsule)))


(defmacro trace (&rest syms)
  (if syms
    `(%trace-0 ',syms)
    `(%trace-list)))

(defun %trace-0 (syms)
  (dolist (symbol syms)
       (cond ((consp symbol)
              (cond ((null (cdr symbol))
                     (%trace (car symbol) :before :print :after :print))
                    ((memq (car symbol) '(:method setf))
                     (%trace symbol :before :print :after :print))
                    (t (apply #'%trace symbol))))
             (t (%trace symbol :before :print :after :print)))))

(defun %trace-list ()
  (let (res)
    (dolist (x *trace-alist*)
      (push (encapsulation-spec x) res))
    res))


;; this week def is the name of an uninterned gensym whose fn-cell is original def

(defun trace-global-def (sym def before after step &optional method-p)
  (let ((saved-method-var (gensym)) do-it step-it)
    (when step
      (setq step-it            
            `(step-apply-simple ',def args)))
    (setq do-it
          (cond (step
                 (if (eq step t)
                   step-it
                   `(if (apply ',step ',sym args) ; gaak
                      ,step-it
                      ,(if (and before method-p)
                         `(apply-with-method-context ,saved-method-var (symbol-function ',def) args)
                         `(apply ',def args)))))
                (t (if (and before method-p)
                     `(apply-with-method-context ,saved-method-var (symbol-function ',def) args)
                     `(apply ',def args)))))
    (flet ((quoted-p (x)
             (and (consp x)
                  (case (car x)
                    ((function quote) t)))))
      (compile-named-function-warn
       `(lambda (,@(if (and before method-p)
                     `(&method ,saved-method-var))
                 &rest args) ; if methodp put &method on front of args - vs get-saved-method-var?
          (declare (dynamic-extent args))
          (let ((*trace-level* (1+ *trace-level*)))
            (declare (special *trace-enable* *trace-level*))
            ,(if before
               `(when *trace-enable*
                  (let* ((*trace-enable* nil))
                    ,(cond
                      ((eq before :break)
                       `(progn (apply #'trace-before ',sym args)
                               (break "~S" args)))
                      (t `(apply ,(if (quoted-p before) before `',before) ',sym args))))))           
            ,(if after
               `(let ((vals (multiple-value-list ,do-it)))
                  (when *trace-enable*
                    (let* ((*trace-enable* nil))
                      ,(cond ((eq after :break)
                              `(progn
                                 (apply #'trace-after ',sym vals)
                                 (break "~S" vals)))
                             (t `(apply ,(if (quoted-p after) after `',after) ',sym  vals)))))
                  (values-list vals))
               do-it)))
       `(traced ,sym)))))

; &method var tells compiler to bind var to contents of next-method-context
(defun advise-global-def (function-spec def when stuff &optional method-p)
  (declare (ignore function-spec))
  (let* ((saved-method-var (gensym)))
    `(lambda (,@(if (and method-p (neq when :after))
                  `(&method ,saved-method-var))
              &rest arglist)
       (declare (dynamic-extent arglist))
       (declare (ignore-if-unused arglist))
       (let ()
         ,(ecase
            when
            (:before
             `(block nil
                ,stuff                  
                (return ,(if method-p
                           `(apply-with-method-context ,saved-method-var (symbol-function ',def) arglist)
                           `(apply ',def arglist)))))
            (:after         
             `(block nil
                (let ((values (multiple-value-list (apply (function ,def) arglist))))
                  (declare (dynamic-extent values))
                  ,stuff
                  (return (values-list values)))))
            (:around
             ;; stuff is e.g. (+ 5 (:do-it))
             (if method-p 
               `(macrolet ((:do-it ()
                             `(apply-with-method-context ,',saved-method-var 
                                                         (symbol-function ',',def)
                                                         arglist)))
                  (block nil
                    (return  ,stuff)))
               `(macrolet ((:do-it ()
                             `(apply (function ,',def) arglist)))
                  (block nil
                    (return  ,stuff))))))))))


(defun compile-named-function-warn (fn name)
  (multiple-value-bind (result warnings)(compile-named-function fn name)    
    (when warnings 
      (let ((first t))
        (dolist (w warnings)
          (signal-compiler-warning w first nil nil nil)
          (setq first nil))))
    result))

;; want to look like
;; (setq values (multiple-value-list (progn ,@frob)))
     
       
(defun %advised-p (thing &optional when advice-name quick)
  ;; thing is a symbol, result is list of encapsulations
  ;; Quick when used as a simple predicate
  (let ((nx thing) cap val)
    (while (setq cap (function-encapsulation nx))
      (when (eq (encapsulation-type cap) 'advice)
        (if quick (return-from %advised-p cap))
        (when (or (and (null when)(null advice-name))
                  (and (eq when (encapsulation-advice-when cap))
                       (equal advice-name (encapsulation-advice-name cap))))
          (push cap val)))
      (setq nx (encapsulation-symbol cap)))
    val))  


(defun advise-2 (newdef newsym method-p function-spec when advice-name define-if-not)      
  (let (advise-thing def orig-sym orig-def)
    (multiple-value-setq (def advise-thing) 
      (%trace-function-spec-p function-spec define-if-not))
    (when (not def)(error "Advise does not understand ~s." function-spec))
    (when (%traced-p advise-thing)
      (setq orig-sym
            (encapsulation-symbol (function-encapsulation advise-thing)))
      (setq orig-def (fboundp orig-sym)))
    (let ((capsules (%advised-p advise-thing when advice-name)))
      (when capsules 
        (unadvise-capsules capsules)
        ; get the right def you fool!
        (setq def (%trace-function-spec-p function-spec))))
    (without-interrupts
     (multiple-value-bind (ignore gf-dcode)
                          (encapsulate (or orig-sym advise-thing) (or orig-def def) 
                                       'advice function-spec newsym
                                       advice-name when)
       (declare (ignore ignore))
       (lfun-name newdef `(advised ',function-spec))
       (if method-p (copy-method-function-bits def newdef))
       (if gf-dcode (setq newdef (%cons-combined-method def (cons newdef gf-dcode)
                                                        #'%%call-gf-encapsulation)))                     
       (cond (orig-sym
              (%fhave orig-sym newdef))  ; make traced call advised
             (t  (cond (gf-dcode (setf (%gf-dcode def) newdef))
                       ((symbolp advise-thing)
                        (%fhave advise-thing newdef))
                       ((typep advise-thing 'method)
                        (progn 
                          (setf (%method-function advise-thing) newdef)
                          (remove-obsoleted-combined-methods advise-thing)
                          newdef)))))))))

(defmacro advise (function form &key (when :before) name define-if-not)
  (let* ((newsym (gensym "ADVICE"))
         ; WAS typep advise-thing 'method
         (method-p (or (typep function 'method) ; can this happen?
                       (and (consp function)(eq (car function) :method))))
         (newdef (advise-global-def function newsym when form method-p)))
      `(advise-2 ,newdef ',newsym ,method-p ',function ',when ',name
                 ,define-if-not)))

(defmacro advisedp (function-spec &key when name)
  `(advisedp-1 ',function-spec ',when ',name))

(defun advisedp-1 (function-spec when name)
  (let (val)
    (flet ((xtract-capsule (c)
             (list (encapsulation-spec c)
                   (encapsulation-advice-when c)
                   (encapsulation-advice-name c))))
      (cond ((eq t function-spec)
             (dolist (c *advise-alist*)
               (when (and
                      (or (null when)(eq when (encapsulation-advice-when c)))
                      (or (null name)(equal name (encapsulation-advice-name c))))
                 (push (xtract-capsule c) val))))
            (t (let* ((advise-thing (nth-value 1  (%trace-function-spec-p function-spec)))
                      (capsules (%advised-p advise-thing when name)))
                 (dolist (capsule capsules)
                   (push (xtract-capsule capsule) val)))))
      val)))               


(defun unadvise-1 (function-spec &optional when advice-name ignore)
  (declare (ignore ignore))
  (let ((advise-thing (nth-value 1 (%trace-function-spec-p function-spec))))
    (let ((capsules (%advised-p advise-thing when advice-name)))
      (when capsules (unadvise-capsules capsules)))))

(defun unadvise-capsules (capsules)
  (let (val)
    (dolist (capsule capsules)
        (push (list (encapsulation-spec capsule)
                    (encapsulation-advice-when capsule)
                    (encapsulation-advice-name capsule))
              val)
        (remove-encapsulation capsule))
    val))

(defmacro unadvise (function &key when name)
  (cond ((neq function t)
         `(unadvise-1 ',function ',when ',name))
        (t '(%unadvise-all))))

(defun %unadvise-all ()
  (unadvise-capsules *advise-alist*))

(defun %set-unencapsulated-definition (spec newdef)
  (let (foo)
    (while (setq foo (function-encapsulation spec))
      (setq spec (encapsulation-symbol foo)))
    (typecase spec
      (symbol
       (%fhave spec newdef)) ;; or fset ??  
      (method
       (setf (%method-function spec) newdef)
       (remove-obsoleted-combined-methods spec)
       newdef))))


;; return t if we defined it, nil otherwise

(defun %defun-encapsulated-maybe (name newdef)
  (let ((def (fboundp name)))
    (when (and def (function-encapsulated-p name))
      (cond ((or *loading-files* (typep def 'standard-generic-function))
             (forget-encapsulations name)
             nil)
            (t (%set-unencapsulated-definition name newdef)
               T)))))

(defun %move-method-encapsulations-maybe (oldmethod newmethod)
  ;; deal with method redefinition
  (let (cap newdef olddef old-inner-def)
    (when (and (setq cap (function-encapsulation oldmethod))
               (neq oldmethod newmethod))      
      (cond (*loading-files*
             (when (%traced-p oldmethod)
               (warn "~%... Untracing ~s" (%untrace-1 oldmethod)))
             (when (%advised-p oldmethod nil nil t)
               (format t "~%... Unadvising ~s" (unadvise-1 oldmethod))))
            (t (setq newdef (%method-function newmethod))
               (setq olddef (%method-function oldmethod))
               (setq old-inner-def (find-unencapsulated-definition oldmethod))
               ;; make last encapsulation call new definition            
               (%set-unencapsulated-definition oldmethod newdef)
               (setf (%method-function newmethod) olddef)
               (remove-encapsulation cap t)
               (put-encapsulation newmethod cap)
               (setf (%method-function oldmethod) old-inner-def)
               (advise-set-method-bits newmethod newdef)
               )))))

(defun advise-set-method-bits (spec newdef)
  ;; spec is a symbol, function, or method object
  (let (foo)
    (while (setq foo (function-encapsulation spec))      
      (let ((def (typecase spec
                   (symbol (fboundp spec))
                   (method (%method-function spec))
                   (t nil))))
        (if def
          (copy-method-function-bits newdef def)
          (error "whats going on here anyway")))
      (setq spec (encapsulation-symbol foo)))))


#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
