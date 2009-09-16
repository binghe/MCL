(in-package :ccl)


;;	Change History (most recent first):
;; $Log: l1-error-system.lisp,v $
;; Revision 1.7  2004/03/03 17:20:15  gtbyers
;; UNBOUND-SLOT condition: name of initarg should be :INSTANCE.
;;
;; Revision 1.6  2004/02/05 03:10:26  alice
;; probably no change
;;
;; Revision 1.5  2003/12/08 08:29:45  gtbyers
;; Define MAKE-PROGRAM-ERROR here.
;;
;;  1 11/13/95 gb   split off from l1-readloop.lisp
;;  (do not edit before this line!!)
;;; This file contains the error/condition system.  Functions that
;;; signal/handle errors are defined later.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Mod History
;;
;; "~S can't be FUNCALLed or APPLYed." is undefined-function error
;; "Too few arguments (no opt/rest)" is program-error 
;; throw error is control-error
;; fix condition-arg for various array errors, add invalid-dimension-error
;; define-condition invalid-subtype-error
;; ------ 5.2b6
;; make-condition  accept a class as well as class-name from patch
;; ------- 5.0 final
;; akh fix signal-program-error so error is tail called
;; akh add $xunread to simple-error-classes*
;; 07/25/99 akh define-condition unbound-slot, define two  common-lisp float-error conditions
;; --------- 4.3f1c1
;; 05/03/99 akh add conditions parse-error and reader-error. Use reader-error, some bad arglist stuff => program-error
;; ------------ 4.3b1
;; 01/19/99 akh simple-condition format-control = format-string per ANSI CL
;; 11/24/97 akh (define-condition array-error (simple-error)) and some subclasses for JCMA 
;;                 - hooked into  condition-arg in a sort of ugly way
;; 07/30/96 gb    just some comments.
;; --- 3.9
;; 03/25/96 bill  in define-condition for arithmetic-error: dectected -> detected
;; 03/01/96 gb    arithmetic errors aren't simple, have :report method
;; 02/19/96 bill  Add frame-ptr first arg to all def-kernel-restart forms. Use that instead of (%get-frame-ptr)
;; 02/14/96 bill  No (def-kernel-restart $xstkover ...) for PPC.
;; 01/31/96 gb    no need for nilreg-cell-symbol since 3.0.
;; 01/16/96 bill  %last-fn-on-stack doesn't do parent-frame for PPC
;;

;;;***********************************
;;; Error System
;;;***********************************

(defclass condition () ())
(defclass warning (condition) ())
(defclass serious-condition (condition) ())
(defclass error (serious-condition) ())
(define-condition simple-condition (condition)
  ((format-string :initarg :format-string :initarg :format-control
                  :reader simple-condition-format-string :reader simple-condition-format-control)
   (format-arguments :initarg :format-arguments :initarg :simple-condition-format-arguments
                     :initform nil
                     :reader simple-condition-format-arguments))
  (:report (lambda (c stream)  ;; If this were a method, slot value might be faster someday.  Accessors always faster ?
                               ;; And of course it's terribly important that this be as fast as humanly possible...
	    ;Use accessors because they're documented and users can specialize them.
            (apply #'format stream (simple-condition-format-string c)
                   (simple-condition-format-arguments c)))))

(define-condition storage-condition (serious-condition) ())
(define-condition simple-storage-condition (simple-error storage-condition) ())

(define-condition print-not-readable (error)
  ((object :initarg :object :reader print-not-readable-object)
   (stream :initarg :stream :reader print-not-readable-stream))
  (:report (lambda (c stream)
             (let* ((*print-readably* nil))
               (format stream "Attempt to print object ~S on stream ~S ."
                       (print-not-readable-object c)
                       (print-not-readable-stream c))))))

(define-condition simple-warning (simple-condition warning))

(define-condition compiler-warning (warning)
  ((file-name :initarg :file-name :initform nil :accessor compiler-warning-file-name)
   (function-name :initarg :function-name :initform nil :accessor compiler-warning-function-name)
   (warning-type :initarg :warning-type :reader compiler-warning-warning-type)
   (args :initarg :args :reader compiler-warning-args)
   (nrefs :initform 1 :accessor compiler-warning-nrefs))
  (:report report-compiler-warning))

(define-condition style-warning (compiler-warning))
(define-condition undefined-function-reference (style-warning))
(define-condition macro-used-before-definition (compiler-warning))
(define-condition invalid-arguments (style-warning))
(define-condition invalid-arguments-global (style-warning))

(define-condition simple-error (simple-condition error))

(define-condition simple-storage-condition (simple-condition storage-condition))
(define-condition stack-overflow-condition (simple-storage-condition))

(define-condition type-error (error)
  ((datum :initarg :datum)
   (expected-type :initarg :expected-type :reader type-error-expected-type)
   (format-string :initarg :format-string  :initform (%rsc-string  $xwrongtype) :reader type-error-format-string))
  (:report (lambda (c s)
             (format s (type-error-format-string c)
                     (type-error-datum c) 
                     (type-error-expected-type c)))))

;(define-condition array-error (simple-error)) ;; or type-error - but wtf is expected type

(define-condition array-subscript-out-of-bounds (type-error))  ;; <<

(define-condition array-wrong-number-of-subscripts (type-error))

(define-condition array-element-type-mismatch (type-error))

(let* ((magic-token '("Unbound")))
  (defmethod type-error-datum ((c type-error))
    (let* ((datum-slot (slot-value c 'datum)))
      (if (eq magic-token datum-slot)
        (%unbound-marker-8)
        datum-slot)))

; do we need this
  (defun signal-type-error (datum expected &optional (format-string (%rsc-string  $xwrongtype)))
    (let ((error #'error))
      (funcall error (make-condition 'type-error
                                     :format-string format-string
                                     :datum (if (eq datum (%unbound-marker-8)) magic-token datum)
                                     :expected-type (%type-error-type expected)))))
)

;;; This is admittedly sleazy; ANSI CL requires TYPE-ERRORs to be
;;; signalled in cases where a type-specifier is not of an appropriate
;;; subtype.  The sleazy part is whether it's right to overload TYPE-ERROR
;;; like this.

(define-condition invalid-subtype-error (type-error)
  ()
  (:report (lambda (c s)
             (format s "The type specifier ~S is not determinably a subtype of the type ~S"
                     (type-error-datum c)
                     (type-error-expected-type c)))))

;; also sleazy - used for invalid/conflicting array dimension specs
(define-condition invalid-dimension-error (type-error)
  ()
  (:report (lambda (c s)
             (format s "The specified dimension(s) ~S inconsistent with ~S"
                     (type-error-datum c)
                     (type-error-expected-type c)))))

  

(define-condition simple-type-error (simple-condition type-error))


(define-condition program-error (error))
(define-condition simple-program-error (simple-condition program-error)
  ((context :initarg :context :reader simple-program-error-context :initform nil)))


(defun signal-program-error (string &rest args)
  (let ((error #'error))
      (funcall error (make-condition 'simple-program-error
                         :format-string (if (fixnump string) (%rsc-string string) string)
                         :format-arguments args))))

(defun make-program-error (string &rest args)
       (make-condition 'simple-program-error
                         :format-string (if (fixnump string) (%rsc-string string) string)
                         :format-arguments args))

(define-condition simple-destructuring-error (simple-program-error))

(define-condition compile-time-program-error (simple-program-error)
  nil ;((context :initarg :context :reader compile-time-program-error-context))
  (:report
   (lambda (c s)
     (format s "While compiling ~a :~%~a" 
             (simple-program-error-context c)
             (apply #'format nil (simple-condition-format-string c) (simple-condition-format-arguments c))))))

(define-condition eval-program-error (simple-program-error)
  nil ;((context :initarg :context :reader eval-program-error-context))
  (:report
   (lambda (c s)
     (format s "While preprocessing ~a :~%~a" 
             (simple-program-error-context c)
             (apply #'format nil (simple-condition-format-string c) (simple-condition-format-arguments c))))))


; Miscellaneous error during compilation (caused by macroexpansion, transforms, compile-time evaluation, etc.)
; NOT program-errors.
(define-condition compile-time-error (simple-error)
  ((context :initarg :context :reader compile-time-error-context))
  (:report
   (lambda (c s)
     (format s "While compiling ~a :~%~a" 
             (compile-time-error-context c)
             (format nil "~a" c)))))

(define-condition control-error (error)
                  ((format-string :initarg :format-string)
                   (format-arguments :initarg :format-arguments))
  (:report (lambda (c s)
             (format s (slot-value c 'format-string)
                     (slot-value c 'format-arguments)))))

(define-condition package-error (error)
  ((package :initarg :package :reader package-error-package)))
(define-condition no-such-package (package-error)
  ()
  (:report (lambda (c s) (format s (%rsc-string $xnopkg) (package-error-package c)))))
(define-condition unintern-conflict-error (package-error)
  ((sym-to-unintern :initarg :sym)
   (conflicting-syms :initarg :conflicts))
  (:report (lambda (c s)
             (format s (%rsc-string $xunintc) (slot-value c 'sym-to-unintern) (package-error-package c) (slot-value c 'conflicting-syms)))))

(define-condition import-conflict-error (package-error)
  ((imported-sym :initarg :imported-sym)
   (conflicting-sym :initarg :conflicting-sym)
   (conflict-external-p :initarg :conflict-external))
  (:report (lambda (c s)
             (format s (%rsc-string (if (slot-value c 'conflict-external-p) $ximprtcx $ximprtc))
                     (slot-value c 'imported-sym)
                     (package-error-package c)
                     (slot-value c 'conflicting-sym)))))

(define-condition use-package-conflict-error (package-error)
  ((package-to-use :initarg :package-to-use)
   (conflicts :initarg :conflicts)
   (external-p :initarg :external-p))
  (:report (lambda (c s)
             (format s (%rsc-string (if (slot-value c 'external-p) $xusecX $xusec))
                     (slot-value c 'package-to-use)
                     (package-error-package c)
                     (slot-value c 'conflicts)))))

(define-condition export-conflict-error (package-error)
  ((conflicts :initarg :conflicts))
  (:report 
   (lambda (c s)
     (format s "Name conflict~p detected by ~A :" (length (slot-value c 'conflicts)) 'export)
     (let* ((package (package-error-package c)))
       (dolist (conflict (slot-value c 'conflicts))
         (destructuring-bind (inherited-p sym-to-export using-package conflicting-sym) conflict
           (format s "~&~A'ing ~S from ~S would cause a name conflict with ~&~
                      the ~a symbol ~S in the package ~s, which uses ~S."
                   'export 
                   sym-to-export 
                   package 
                   (if inherited-p "inherited" "present")
                   conflicting-sym
                   using-package
                   package)))))))

(define-condition export-requires-import (package-error)
  ((to-be-imported :initarg :to-be-imported))
  (:report
   (lambda (c s)
     (let* ((p (package-error-package c)))
       (format s "The following symbols need to be imported to ~S before they can be exported ~& from that package:~%~s:" p (slot-value c 'to-be-imported) p)))))
  
(define-condition package-name-conflict-error (package-error simple-error) ())

(define-condition package-is-used-by (package-error)
  ((using-packages :initarg :using-packages))
  (:report (lambda (c s)
             (format s "~S is used by ~S" (package-error-package c)
                     (slot-value c 'using-packages)))))

(define-condition symbol-name-not-accessible (package-error)
  ((symbol-name :initarg :symbol-name))
  (:report (lambda (c s)
             (format s "No aymbol named ~S is accessible in package ~s"
                     (slot-value c 'symbol-name)
                     (package-error-package c)))))

(define-condition stream-error (error)
  ((stream :initarg :stream :reader stream-error-stream)))
(define-condition end-of-file (stream-error) ()
  (:report (lambda (c s)
             (format s "Unexpected end of file on ~s" (stream-error-stream c)))))

;; parse-namestring & friends use this
;; no more
#|
(define-condition parse-error (simple-condition  stream-error)()                  
  (:report (lambda (c s)
             (let ((*print-circle* nil))
               (format s "Parsing ~s:~%~?" (stream-error-stream c)  ; the string is also in format arguments
                       (simple-condition-format-string c)
                       (simple-condition-format-arguments c))))))
|#


(define-condition parse-error (error) ())

;; now parse-namestring etal use this
(define-condition pathname-parse-error (simple-condition parse-error)())


;; PPC uses this
(define-condition reader-error (parse-error stream-error) ()  ;; Lisp reader errors 
  (:report (lambda (c output-stream)
             (format output-stream "Reading stream ~S:~%~?"
                     (stream-error-stream c)
                     (simple-condition-format-string c)
                     (simple-condition-format-arguments c)))))
                  

(define-condition modify-read-only-buffer (error) ()
  (:report (lambda (c s)
             (declare (ignore c))
             (format s "Cannot modify a read-only buffer"))))

(define-condition file-error (simple-condition error)
  ((pathname :initarg :pathname :reader file-error-pathname)
   (error-type :initarg :error-type :initform "File error on file ~S"))
  (:report (lambda (c s)
              (apply #'format s (slot-value c 'error-type) 
                     (file-error-pathname c)
                     (simple-condition-format-arguments c)))))

(define-condition cell-error (error)
  ((name :initarg :name :reader cell-error-name)
   (error-type :initarg :error-type :initform "Cell error" :reader cell-error-type))
  (:report (lambda (c s) (format s "~A: ~S" (cell-error-type c) (cell-error-name c)))))

(define-condition unbound-slot (cell-error)                  
  ((error-type :initform "Unbound-slot")
   (instance :initarg :instance :reader unbound-slot-instance))
  (:report (lambda (c s)
             (format s "Unbound-slot ~s in ~s." (cell-error-name c)(unbound-slot-instance c)))))
 


(define-condition unbound-variable (cell-error)
  ((error-type :initform "Unbound variable")))

(define-condition undefined-function (cell-error)
  ((error-type :initform "Undefined function")))
(define-condition undefined-function-call (control-error undefined-function)
  ((function-name :initarg :function-name :reader undefined-function-call-name)
   (function-arguments :initarg :function-arguments :reader undefined-function-call-arguments))
  (:report (lambda (c s) (format s "Undefined function ~S called with arguments ~:S ."
                                 (undefined-function-call-name c)
                                 (undefined-function-call-arguments c)))))

(define-condition arithmetic-error (error) 
  ((operation :initform nil :initarg :operation :reader arithmetic-error-operation)
   (operands :initform nil :initarg :operands :reader arithmetic-error-operands))
  (:report (lambda (c s) (format s "~S detected ~&performing ~S on ~:S"
                                 (type-of c) 
                                 (arithmetic-error-operation c) 
                                 (arithmetic-error-operands c)))))

(define-condition division-by-zero (arithmetic-error))
  
(define-condition floating-point-underflow (arithmetic-error))
                  
                  
(define-condition floating-point-overflow (arithmetic-error))
(define-condition inexact-result (arithmetic-error))
(define-condition invalid-operation (arithmetic-error))
(define-condition FLOATING-POINT-INVALID-OPERATION (arithmetic-error))
(define-condition floating-point-inexact (arithmetic-error))

(defun restartp (thing) 
  (istruct-typep thing 'restart))
(setf (type-predicate 'restart) 'restartp)

(defmethod print-object ((restart restart) stream)
  (let ((report (%restart-report restart)))
    (cond ((or *print-escape* (null report))
           (print-unreadable-object (restart stream :identity t)
             (format stream "~S ~S"
                     'restart (%restart-name restart))))
          ((stringp report)
           (write-string report stream))
          (t
           (funcall report stream)))))

(defun %make-restart (name action report interactive test)
  (%cons-restart name action report interactive test))

(defun make-restart (vector name action-function &key report-function interactive-function test-function)
  (unless vector (setq vector (%cons-restart nil nil nil nil nil)))
  (setf (%restart-name vector) name
        (%restart-action vector) (require-type action-function 'function)
        (%restart-report vector) (if report-function (require-type report-function 'function))
        (%restart-interactive vector) (if interactive-function (require-type interactive-function 'function))
        (%restart-test vector) (if test-function (require-type test-function 'function)))
  vector)

(defun restart-name (restart)
  (%restart-name (require-type restart 'restart)))

(defun applicable-restart-p (restart condition)
  (let* ((pair (assq restart *condition-restarts*))
         (test (%restart-test restart)))
    (and (or (null pair) (eq (%cdr pair) condition))
         (or (null test) (funcall test condition)))))

(defun compute-restarts (&optional condition &aux restarts)
  (dolist (cluster %restarts% (nreverse restarts))
    (if (null condition)
      (setq restarts (nreconc (copy-list cluster) restarts))
      (dolist (restart cluster)
        (when (applicable-restart-p restart condition)
          (push restart restarts))))))

(defun find-restart (name &optional condition)
  (dolist (cluster %restarts%)
    (dolist (restart cluster)
      (when (and (or (eq restart name) (eq (restart-name restart) name))
                 (or (null condition)
                     (applicable-restart-p restart condition)))
	(return-from find-restart restart)))))

(defun %active-restart (name)
  (dolist (cluster %restarts%)
    (dolist (restart cluster)
      (when (or (eq restart name) (eq (%restart-name restart) name))
        (return-from %active-restart (values restart cluster)))))
  (error "Restart ~S is not active." name))

(defun invoke-restart (restart &rest values)
  (multiple-value-bind (restart tag) (%active-restart restart)
    (let ((fn (%restart-action restart)))
      (cond ((null fn)                  ; simple restart
             (unless (null values) (%err-disp $xtminps))
             (throw tag (values nil T)))
            ((fixnump fn)               ; restart case
             (throw tag (cons fn values)))
            (t (apply fn values))))))   ; restart bind

(defun invoke-restart-no-return (restart)
  (invoke-restart restart)
  (error 'restart-failure :restart restart))

#| ;; temp kludge for muffle-warning in event-processing-loop
(defun invoke-restart-no-return (restart)
  (when restart
    (invoke-restart restart)
    (error 'restart-failure :restart restart)))
|#

(defun invoke-restart-interactively (restart)
  (multiple-value-bind (restart tag) (%active-restart restart)
    (format *error-output* "~&Invoking restart: ~a~&" restart)
    (let* ((argfn (%restart-interactive restart))
           (values (when argfn (funcall argfn)))
           (fn (%restart-action restart)))
      (cond ((null fn)                  ; simple restart
             (unless (null values) (%err-disp $xtminps))
             (throw tag (values nil T)))
            ((fixnump fn)               ; restart case
             (throw tag (cons fn values)))
            (t (apply fn values))))))   ; restart bind


(defun maybe-invoke-restart (restart value condition)
  (let ((restart (find-restart restart condition)))
    (when restart (invoke-restart restart value))))

(defun use-value (value &optional condition)
  (maybe-invoke-restart 'use-value value condition))

(defun store-value (value &optional condition)
  (maybe-invoke-restart 'store-value value condition))

(defun condition-arg (thing args type)
  #+ignore
  (if (stringp thing)
    (push (list 'cond-arg thing type args %handlers%) shit))  ;; cond arg is usually type appleevent-error
  (cond ((condition-p thing) (if args (%err-disp $xtminps) thing))  ;; ??
        ((symbolp thing) (apply #'make-condition thing args))
        ;; god awful kludge cause I'm confused about path from kernel to %error - it varies bet 68K and PPC
        ;; so this is a little bit ass backwards, bass ackwards
        ((and (eq type 'simple-error)
              (stringp thing)
              (cond ((or (string= thing "Too few arguments (with opt/rest)")  ;; these are built into kernel
                         (string= thing "Too few arguments (with opt/rest/key)")
                         (string= thing "Too many arguments (no opt/rest)")
                         (string= thing "Too few arguments (no opt/rest)")
                         (string= thing "Too many arguments (with opt)" )
                         (string= thing "Incorrect keyword arguments in ~S ."))
                     (make-condition 'simple-program-error :format-string thing :format-arguments args))                    
                    ((or (string= thing (%rsc-string $XCALLTOOFEW))
                         (string= thing (%rsc-string $XCALLTOOMANY))
                         (string= thing (%rsc-string $XTMINPS))
                         (string= thing (%rsc-string $XCALLNOMATCH)))
                     (make-condition 'simple-program-error :format-string thing :format-arguments args))
                    ((string= thing (%rsc-string $xarroob))
                     (make-condition 'array-subscript-out-of-bounds
                                     :format-string thing  ;; takes two args
                                     :datum (car  args)
                                     :expected-type (second args)))                     
                    ((string= thing (%rsc-string $xnotelt))
                     (make-condition 'array-element-type-mismatch 
                                     :datum (car args)
                                     :expected-type (second args)
                                     :format-string thing ))
                    ((string= thing (%rsc-string $XNDIMS))
                     (make-condition 'array-wrong-number-of-subscripts 
                                     :format-string thing 
                                     :datum (car args)
                                     :expected-type (second args)))
                    ((string= thing "~S can't be FUNCALLed or APPLYed.")
                     (make-condition 'undefined-function-call
                                     :format-string thing
                                     :function-name (car args)
                                     :function-arguments (cdr args)))                              
                    ((string= thing (%rsc-string $xnopkg))
                     (make-condition 'package-error
                                     :package-arg (car args)
                                     :format-arguments args
                                     :format-string thing))
                    (t (make-condition type :format-string thing :format-arguments args)))))
        (t (make-condition type :format-string thing :format-arguments args))))

#|
(defun make-condition (name &rest init-list &aux class)
  (declare (dynamic-extent init-list))
  (if (and (setq class (find-class name nil))
           (condition-p (class-prototype class)))
    (apply #'make-instance class init-list)
    (error "~S is not a defined condition type name" name)))
|#

(defun make-condition (name &rest init-list &aux class)
  (declare (dynamic-extent init-list))
  (if (and (setq class (if  (typep name 'standard-class) 
                         name
                         (find-class name nil)))
           (condition-p (class-prototype class)))
    (apply #'make-instance class init-list)
    (error "~S is not a defined condition type name" name)))

(defmethod print-object ((c condition) stream)
  (if *print-escape* 
    (call-next-method)
    (report-condition c stream)))

(defmethod report-condition ((c condition) stream)
  (princ (cond ((typep c 'error) "Error ")
               ((typep c 'warning) "Warning ")
               (t "Condition "))
         stream)
  ;Here should dump all slots or something.  For now...
  (let ((*print-escape* t))
    (print-object c stream)))

(defun signal-simple-condition (class-name format-string &rest args)
  (let ((e #'error))  ; Never-tail-call.
    (funcall e (make-condition class-name :format-string format-string :format-arguments args))))

(defun signal-simple-program-error (format-string &rest args)
  (apply #'signal-simple-condition 'simple-program-error format-string args))

;;getting the function name for error functions.


(defun %last-fn-on-stack (&optional (number 0) (s (%get-frame-ptr)))
  (let* ((fn nil)
         (sg *current-stack-group*))
    (let ((p s))
      (tagbody
        (dotimes (i number)
          (declare (fixnum i))
          (unless (setq p (parent-frame p sg))
            (go done)))
        (if #-ppc-target (setq p (parent-frame p sg))
            #+ppc-target p
          (setq fn (cfp-lfun p sg)))
        done))
    fn))
 
(defun %err-fn-name (lfun)
  "given an lfun returns the name or the string \"Unknown\""
  (if (lfunp lfun) (or (lfun-name lfun) lfun)
     (or lfun "Unknown")))

(defun %real-err-fn-name (error-pointer)
  (let ((name (%err-fn-name (%last-fn-on-stack 0 error-pointer))))
    (if (memq name '(event-dispatch call-check-regs))
      (%err-fn-name (%last-fn-on-stack 1 error-pointer))
      name)))


;; Some simple restarts for simple error conditions.  Callable from the kernel.



(def-kernel-restart $xvunbnd %default-unbound-variable-restarts (frame-ptr cell-name)
  (unless *level-1-loaded*
    #-ppc-target (lap-inline (cell-name) (dc.w #_Debugger))
    #+ppc-target (dbg cell-name))       ;  user should never see this.
  (let ((condition (make-condition 'unbound-variable :name cell-name)))
    (flet ((new-value ()
             (catch-cancel
              (return-from new-value
                           (list (read-from-string 
                                  (get-string-from-user
                                   (format nil "New value for ~s : " cell-name))))))
             (continue condition))) ; force error again if cancelled, var still not set.
      (restart-case (%error condition nil frame-ptr)
        (continue ()
                  :report (lambda (s) (format s "Retry getting the value of ~S." cell-name))
                  (symbol-value cell-name))
        (use-value (value)
                   :interactive new-value
                   :report (lambda (s) (format s "Specify a value of ~S to use this time." cell-name))
                   value)
        (store-value (value)
                     :interactive new-value
                     :report (lambda (s) (format s "Specify a value of ~S to store and use." cell-name))
                     (setf (symbol-value cell-name) value))))))

(def-kernel-restart $xnopkg %default-no-package-restart (frame-ptr package-name)
  (or (and *autoload-lisp-package*
           (or (string-equal package-name "LISP") 
               (string-equal package-name "USER"))
           (progn
             (require "LISP-PACKAGE")
             (find-package package-name)))
      (let* ((alias (or (%cdr (assoc package-name '(("LISP" . "COMMON-LISP")
                                                    ("USER" . "CL-USER")) 
                                     :test #'string-equal))
                        (if (packagep *package*) (package-name *package*))))
             (condition (make-condition 'no-such-package :package package-name)))
        (flet ((try-again (p)
                          (or (find-package p) (%kernel-restart $xnopkg p))))
          (restart-case
            (restart-case (%error condition nil frame-ptr)
              (continue ()
                        :report (lambda (s) (format s "Retry finding package with name ~S." package-name))
                        (try-again package-name))
              (use-value (value)
                         :interactive (lambda () (block nil 
                                                   (catch-cancel
                                                    (return (list (get-string-from-user
                                                                   "Find package named : "))))
                                                   (continue condition)))
                         :report (lambda (s) (format s "Find specified package instead of ~S ." package-name))
                         (try-again value))
              (make-nickname ()
                             :report (lambda (s) (format s "Make ~S be a nickname for package ~S." package-name alias))
                             (let ((p (try-again alias)))
                               (push package-name (cdr (pkg.names p)))
                               p)))
            (require-lisp-package ()
                                  :test (lambda (c)
                                          (and (eq c condition)
                                               (or (string-equal package-name "LISP") (string-equal package-name "USER"))))
                                  :report (lambda (s) 
                                            (format s "(require :lisp-package) and retry finding package ~s"
                                                    package-name))
                                  (require "LISP-PACKAGE")
                                  (try-again package-name)))))))

(def-kernel-restart $xunintc unintern-conflict-restarts (frame-ptr sym package conflicts)
  (let ((condition (make-condition 'unintern-conflict-error :package package :sym sym :conflicts conflicts)))
    (restart-case (%error condition nil frame-ptr)
      (continue ()
                :report (lambda (s) (format s "Try again to unintern ~s from ~s" sym package))
                (unintern sym package))
      (do-shadowing-import (ssym)
                           :report (lambda (s) (format s "SHADOWING-IMPORT one of ~S in ~S." conflicts package))
                           :interactive (lambda ()
                                          (block nil
                                            (catch-cancel
                                             (return (select-item-from-list conflicts 
                                                                            :window-title 
                                                                            (format nil "Shadowing-import one of the following in ~s" package)
                                                                            :table-print-function #'prin1)))
                                            (continue condition)))
                           (shadowing-import (list ssym) package)))))


(def-kernel-restart $xusec blub (frame-ptr package-to-use using-package conflicts)
  (resolve-use-package-conflict-error frame-ptr package-to-use using-package conflicts nil))

(def-kernel-restart $xusecX blub (frame-ptr package-to-use using-package conflicts)
  (resolve-use-package-conflict-error frame-ptr package-to-use using-package conflicts t))

(defun resolve-use-package-conflict-error (frame-ptr package-to-use using-package conflicts external-p)
  (let ((condition (make-condition 'use-package-conflict-error 
                                   :package using-package
                                   :package-to-use package-to-use
                                   :conflicts conflicts
                                   :external-p external-p)))
    (flet ((external-test (&rest ignore) (declare (ignore ignore)) external-p)
           (present-test (&rest ignore) (declare (ignore ignore)) (not external-p)))
      (declare (dynamic-extent #'present-test #'external-test))
      (restart-case (%error condition nil frame-ptr)
        (continue ()
                  :report (lambda (s) (format s "Try again to use ~s in ~s" package-to-use using-package)))
        (resolve-by-shadowing-import (&rest shadowing-imports)
                                     :test external-test
                                     :interactive (lambda ()
                                                    (mapcar #'(lambda (pair) 
                                                                (block nil
                                                                  (catch-cancel
                                                                    (return (car (select-item-from-list pair
                                                                                                        :window-title 
                                                                                                        (format nil "Shadowing-import one of the following in ~s" using-package)
                                                                                                        :table-print-function #'prin1))))
                                                                  (continue condition)))
                                                            conflicts))
                                     :report (lambda (s) (format s "SHADOWING-IMPORT one of each pair of conflicting symbols."))
                                     (shadowing-import shadowing-imports using-package))
        (unintern-all ()
                      :test present-test
                      :report (lambda (s) (format s "UNINTERN all conflicting symbols from ~S" using-package))
                      (dolist (c conflicts)
                        (unintern (car c) using-package)))
        (shadow-all ()
                      :test present-test
                      :report (lambda (s) (format s "SHADOW all conflicting symbols in ~S" using-package))
                      (dolist (c conflicts)
                        (shadow-1 using-package (car c))))
        (resolve-by-unintern-or-shadow (&rest dispositions)
                                       :test present-test
                                       :interactive (lambda ()
                                                      (mapcar #'(lambda (pair)
                                                                  (let* ((present-sym (car pair)))
                                                                    (block nil
                                                                      (catch-cancel
                                                                        (return (car (select-item-from-list (list 'shadow 'unintern) 
                                                                                                            :window-title
                                                                                                            (format nil "SHADOW ~S in, or UNINTERN ~S from ~S" 
                                                                                                                    present-sym 
                                                                                                                    present-sym
                                                                                                                    using-package)
                                                                                                            :table-print-function #'prin1)))
                                                                        (continue condition)))))
                                                              conflicts))
                                       :report (lambda (s) (format s "SHADOW or UNINTERN the conflicting symbols in ~S." using-package))
                                       (dolist (d dispositions)
                                         (let* ((sym (car (pop conflicts))))
                                           (if (eq d 'shadow)
                                             (shadow-1 using-package sym)
                                             (unintern sym using-package)))))))))


(defun resolve-export-conflicts (conflicts package)
  (let* ((first-inherited (caar conflicts))
         (all-same (dolist (conflict (cdr conflicts) t)
                     (unless (eq (car conflict) first-inherited) (return nil))))
         (all-inherited (and all-same first-inherited))
         (all-present (and all-same (not first-inherited)))
         (condition (make-condition 'export-conflict-error
                                    :conflicts conflicts
                                    :package package)))
    (flet ((check-again () 
             (let* ((remaining-conflicts (check-export-conflicts (mapcar #'cadr conflicts) package)))
               (if remaining-conflicts (resolve-export-conflicts remaining-conflicts package)))))
      (restart-case (%error condition nil (%get-frame-ptr))
        (resolve-all-by-shadowing-import-inherited 
         ()
         :test (lambda (&rest ignore) (declare (ignore ignore)) all-inherited)
         :report (lambda (s) (format s "SHADOWING-IMPORT all conflicting inherited symbol(s) in using package(s)."))
         (dolist (conflict conflicts (check-again))
           (destructuring-bind (using-package inherited-sym) (cddr conflict)
             (shadowing-import-1 using-package inherited-sym))))
        (resolve-all-by-shadowing-import-exported 
         ()
         :test (lambda (&rest ignore) (declare (ignore ignore)) all-inherited)
         :report (lambda (s) (format s "SHADOWING-IMPORT all conflicting symbol(s) to be exported in using package(s)."))
         (dolist (conflict conflicts (check-again))
           (destructuring-bind (exported-sym using-package ignore) (cdr conflict)
             (declare (ignore ignore))
             (shadowing-import-1 using-package exported-sym))))
        (resolve-all-by-uninterning-present 
         ()
         :test (lambda (&rest ignore) (declare (ignore ignore)) all-present)
         :report (lambda (s) (format s "UNINTERN all present conflicting symbol(s) in using package(s)."))
         (dolist (conflict conflicts (check-again))
           (destructuring-bind (using-package inherited-sym) (cddr conflict)
             (unintern inherited-sym using-package))))
        (resolve-all-by-shadowing-present 
         ()
         :test (lambda (&rest ignore) (declare (ignore ignore)) all-present)
         :report (lambda (s) (format s "SHADOW all present conflicting symbol(s) in using package(s)."))
         (dolist (conflict conflicts (check-again))
           (destructuring-bind (using-package inherited-sym) (cddr conflict)
             (shadow-1 using-package inherited-sym))))
        (review-and-resolve 
         (dispositions)
         :report (lambda (s) (format s "Review each name conflict and resolve individually."))
         :interactive (lambda ()
                        (let* ((disp nil))
                          (block b
                            (catch-cancel
                              (dolist (conflict conflicts (return-from b (list disp)))
                                (destructuring-bind (inherited-p exported-sym using-package conflicting-sym) conflict
                                  (let* ((syms (list exported-sym conflicting-sym)))
                                    (if inherited-p
                                      (push (list 'shadowing-import
                                                  (select-item-from-list syms
                                                                              :window-title 
                                                                              (format nil "Shadowing-import one of the following in ~s" using-package)
                                                                              :table-print-function #'prin1)
                                                  using-package)
                                            disp)
                                      (let* ((selection (car (select-item-from-list syms
                                                                                    :window-title 
                                                                                    (format nil "Shadow ~S or unintern ~s in ~s"
                                                                                            exported-sym 
                                                                                            conflicting-sym using-package)
                                                                                    :table-print-function #'prin1))))
                                        (push (if (eq selection 'exported-sym)
                                                (list 'shadow (list exported-sym) using-package)
                                                (list 'unintern conflicting-sym using-package))
                                              disp)))))))
                            nil)))
         (dolist (disp dispositions (check-again))
           (apply (car disp) (cdr disp))))))))


(def-kernel-restart $xwrongtype default-require-type-restarts (frame-ptr value typespec)
  (setq typespec (%type-error-type typespec))
  (let ((condition (make-condition 'type-error 
                                   :datum value
                                   :expected-type typespec)))
    (restart-case (%error condition nil frame-ptr)
      (use-value (newval)
                 :report (lambda (s)
                           (format s "Use a new value of type ~s instead of ~s." typespec value))
                 :interactive (lambda ()
                                (format *query-io* "~&New value of type ~S :" typespec)
                                (list (read *query-io*)))
                 (require-type newval typespec)))))

(def-kernel-restart $xudfcall default-undefined-function-call-restarts (frame-ptr function-name args)
  (unless *level-1-loaded*
    #-ppc-target (lap-inline (function-name) (dc.w #_Debugger))
    #+ppc-target (dbg function-name))   ; user should never see this
  (let ((condition (make-condition 'undefined-function-call
                                   :function-name function-name
                                   :function-arguments args)))
    (restart-case (%error condition nil frame-ptr)
      (continue ()
                :report (lambda (s) (format s "Retry applying ~S to ~S." function-name args))
                (apply function-name args))
      (use-value (function)
                 :interactive (lambda ()
                                (format *query-io* "Function to apply instead of ~s :" function-name)
                                (let ((f (read *query-io*)))
                                  (unless (symbolp f) (setq f (eval f))) ; almost-the-right-thing (tm)
                                  (list (coerce f 'function))))
                 :report (lambda (s) (format s "Apply specified function to ~S this time." args))
                 (apply function args))
      (store-value (function)
                   :interactive (lambda ()
                                (format *query-io* "Function to apply as new definition of ~s :" function-name)
                                (let ((f (read *query-io*)))
                                  (unless (symbolp f) (setq f (eval f))) ; almost-the-right-thing (tm)
                                  (list (coerce f 'function))))
                   :report (lambda (s) (format s "Specify a function to use as the definition of ~S." function-name))
                   (apply (setf (symbol-function function-name) function) args)))))

; This expects to get an argument only when the stack has not already
; been extended. In that case, it uses the argument to report how
; much has been requested and to extend by at least that amount.
; The kernel has extended the max stack size by $default_segment_size so
; that this code will have a chance to run. If we throw out, it will
; restore it.
#-ppc-target
(def-kernel-restart $xstkover stack-overflow-restarts (frame-ptr &optional bytes-needed-in)
  (let* ((sgbuf (sg-buffer *current-stack-group*))
         (bytes-needed (or bytes-needed-in (stack-group-size)))
         (condition (make-condition 'stack-overflow-condition
                                    :format-string "Stack overflow. Min stack size needed (bytes): ~s"
                                    :format-arguments (list bytes-needed))))
    (restart-case (%error condition nil frame-ptr)
      (continue ()
                :report (lambda (s) (format s "make the stack larger."))
                (setf (sgbuf.maxsize sgbuf)
                      (min (floor most-positive-fixnum 2)
                           (+ bytes-needed (floor bytes-needed 4))))))))

; This has to be defined fairly early (assuming, of course, that it "has" to be defined at all ...

(defun ensure-value-of-type (value typespec placename &optional (typename typespec))
  (declare (resident))
  (tagbody
    again
    (unless (typep value typespec)
      (let ((condition (make-condition 'type-error 
                                       :datum value
                                       :expected-type typename)))
        (restart-case (%error condition nil (%get-frame-ptr))
          (store-value (newval)
                       :report (lambda (s)
                                 (format s "Assign a new value of type ~a to ~s" typespec placename))
                       :interactive (lambda ()
                                      (format *query-io* "~&New value for ~S :" placename)
                                      (list (eval (read))))
                       (setq value newval)
                       (go again))))))
  value)

;;;The Error Function

(defparameter *kernel-simple-error-classes*
  (list (cons $xcalltoofew 'simple-destructuring-error)
        (cons $xcalltoomany 'simple-destructuring-error)
        (cons $xstkover 'stack-overflow-condition)
        (cons $xmemfull 'simple-storage-condition)
        (cons $xwrongtype 'type-error) ; this one needs 2 args
        (CONS $XNOFILLPTR 'TYPE-ERROR)
        (cons $xcoerce 'type-error)
        (cons $xnoctag 'control-error)
        (cons $xdivzro 'division-by-zero)
        (cons $xflovfl 'floating-point-overflow)
        (cons $xfunbnd 'undefined-function)
        ;; reader-error things - ??
        ;(cons $xillchr 'simple-reader-error)
        ;(cons $xnordisp 'simple-reader-error)
        ;(cons $XDOTERR 'simple-reader-error)
        (cons $XBADSYM 'simple-reader-error)
        (cons $xbadnum 'simple-reader-error)
        (cons $XRDFEATURE 'simple-reader-error)
        ;(cons $xrdnoarg 'simple-reader-error)
        (cons $xnoesym 'simple-reader-error)
        ;(cons $xunread 'simple-reader-error)
        ))

; do we like this?
(defparameter *simple-error-types*
  (vector nil 'simple-program-error 'file-error))

(defconstant $pgm-err #x10000)





(defparameter %type-error-typespecs%
  #(array
    bignum
    fixnum
    character
    integer
    list
    number
    sequence
    simple-string
    simple-vector
    string
    symbol
    macptr
    real
    cons
    unsigned-byte
    (integer 2 36)
    float
    rational
    ratio
    short-float
    double-float
    complex
    vector
    simple-base-string
    function
    (unsigned-byte 16)
    (unsigned-byte 8)
    (unsigned-byte 32)
    (signed-byte 32)
    (signed-byte 16)
    (signed-byte 8)
    base-character
    bit
    (unsigned-byte 24)                  ; (integer 0 (array-total-size-limit))
    uvector
))


(defun %type-error-type (type)
  (if (fixnump type) 
    (svref %type-error-typespecs% type)
    type))

(defun %typespec-id (typespec)
  (flet ((type-equivalent (t1 t2) (ignore-errors (and (subtypep t1 t2) (subtypep t2 t1)))))
    (position typespec %type-error-typespecs% :test #'type-equivalent)))


(defmethod condition-p ((x t)) nil)
(defmethod condition-p ((x condition)) t)



(let* ((globals ()))

  (defun %check-error-globals ()
    (let ((vars ())
          (valfs ())
          (oldvals ()))
      (dolist (g globals (values vars valfs oldvals))
        (destructuring-bind (sym predicate newvalf) g
          (let* ((boundp (boundp sym))
                 (oldval (if boundp (symbol-value sym) (%unbound-marker-8))))
          (unless (and boundp (funcall predicate oldval))
            (push sym vars)
            (push oldval oldvals)
            (push newvalf valfs)))))))

  (defun check-error-global (sym checkfn newvalfn)
    (setq sym (require-type sym 'symbol)
          checkfn (require-type checkfn 'function)
          newvalfn (require-type newvalfn 'function))
    (let ((found (assq sym globals)))
      (if found
        (setf (cadr found) checkfn (caddr found) newvalfn)
        (push (list sym checkfn newvalfn) globals))
      sym))
)

(check-error-global '*package* #'packagep #'(lambda () (find-package "CL-USER")))
(let* ((terminal-io-test #'(lambda (s) (typep s 'terminal-io)))
       (new-terminal-io #'(lambda () (make-instance 'terminal-io))))
  (check-error-global '*terminal-io* terminal-io-test new-terminal-io)
  (check-error-global '*debug-io* #'streamp new-terminal-io)
  (check-error-global '*error-output* #'streamp #'(lambda () (make-instance 'pop-up-terminal-io))))
  

