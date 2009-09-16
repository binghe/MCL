
; l1-clos-boot.lisp

;; $Log: l1-clos-boot.lisp,v $
;; Revision 1.17  2004/10/11 02:14:26  alice
;; error message for inconsistent superclasses has more info
;;
;; Revision 1.16  2004/09/01 19:40:52  svspire
;; Add error check in ensure-method to catch faulty programmer redefinitions of ensure-generic-function. We can't babysit everybody, but I think this one was warranted because not doing it caused a hard crash of MCL.
;;
;; Revision 1.15  2004/05/21 16:52:47  svspire
;; %add-standard-method-to-standard-gf: don't error if the method already thinks it's part of the same gf. Removed some #\page characters.
;;
;; Revision 1.14  2004/03/27 21:59:25  alice
;; ;; fix misspelled initargs in declaration
;;
;; Revision 1.13  2004/03/04 22:25:37  alice
;; slot-unbound back to :instance instance
;;
;; Revision 1.12  2004/03/03 17:15:57  gtbyers
;; DEFAULT-INITARGS: order is (keyword, initform, initfunction.)
;;
;; Revision 1.11  2004/01/29 04:19:33  alice
;; fix method unbound-slot
;;
;; Revision 1.10  2004/01/28 10:15:14  gtbyers
;; SLOT-MISSING might return one or more values (if specialized by the user); some callers should use the first such value, others should return what CLHS says.  (SETF SLOT-VALUE) calls SLOT-MISSING with the symbol SETF as the operation.
;;
;; Revision 1.9  2003/12/31 19:17:24  gtbyers
;; MAKE-LOAD-FORM-SAVING-SLOTS: extract-instance-effective-slotds wants  a class as an argument, not a list of slots.
;;
;; Revision 1.8  2003/12/30 17:15:00  svspire
;; uncanonicalize-specializer now returns `(eql ,specializer) instead of just specializer
;;
;; Revision 1.7  2003/12/29 04:08:42  gtbyers
;; SLOT-ID stuff.
;;
;; Revision 1.6  2003/12/08 23:27:38  gtbyers
;; In *CLASS-TABLE* initialization,  map subtag for LOCK to LOCK class.
;;
;; Revision 1.5  2003/12/08 10:12:37  gtbyers
;; Can just use EQ when comparing EQL-SPECIALIZERS.  Doh; that's kind of the whole idea ...
;;
;; Revision 1.4  2003/12/08 08:55:48  gtbyers
;; new file, at least on the main branch
;;

;; check for :allocation :instance or :class in some places
;; comment out some unused code re primary-slot
;; slightly faster reader/writer methods
;; slot-id-value, set-slot-id-value fix to deal with non-standard wrapper or non-standard slotd
;; fix bug in slot-id->slotd when no map
;; --------- 5.2b6
;; find-slotd faster
;; slot-value calls slot-id-value - much faster - ditto set-slot-value -> set-slot-id-value
;; slot-id-value and set-slot-id-value faster
;; ----- 5.2b5
;; fix find-method for eql specializer provided
;; ---- 5.2b4
;; fix misspelled initargs in declaration
;; 08/26/05 akh #\rubout ain't standard-char
(in-package :ccl)

;;; Early accessors.  These functions eventually all get replaced with
;;; generic functions with "real", official names.

(defun %class-name (class)
  (%class.name class))



(defun %class-slots (class)
  (if (typep class 'slots-class)
    (%class.slots class)))

(defun %class-direct-slots (class)
  (if (typep class 'slots-class)
    (%class.direct-slots class)))

(defun %class-direct-superclasses (class)
  (%class.local-supers class))

(defun %class-direct-subclasses (class)
  (%class.subclasses class))

(defun %class-direct-default-initargs (class)
  (if (typep class 'std-class)
    (%class.local-default-initargs class)))

(defun %class-default-initargs (class)
  (if (typep class 'std-class)
    (%class.default-initargs class)))


(defun (setf %class-default-initargs) (new class)
  (setf (%class.default-initargs class) new))

(defun %slot-definition-name (slotd)
  (standard-slot-definition.name slotd))


(defun %slot-definition-type (slotd)
  (standard-slot-definition.type slotd))

(defun %slot-definition-initargs (slotd)
  (standard-slot-definition.initargs slotd))


(defun %slot-definition-initform (slotd)
  (standard-slot-definition.initform slotd))

(defun %slot-definition-initfunction (slotd)
  (standard-slot-definition.initfunction slotd))

(defun %slot-definition-allocation (slotd)
  (standard-slot-definition.allocation slotd))

(defun %slot-definition-class (slotd)
  (standard-slot-definition.class slotd))

;;; Returns (VALUES BOUNDP VALUE).
(defun %slot-definition-documentation (slotd)
  (let* ((val (%standard-instance-instance-location-access
	       slotd
	       standard-slot-definition.documentation)))
    (if (eq val (%slot-unbound-marker))
      (values nil nil)
      (values t val))))


(defun %slot-definition-class (slotd)
  (standard-slot-definition.class slotd))

(defun %slot-definition-location (slotd)
  (standard-effective-slot-definition.location slotd))

(defun (setf %slot-definition-location) (new slotd)
  (setf (standard-effective-slot-definition.location slotd) new))

(defun %slot-definition-readers (slotd)
  (standard-direct-slot-definition.readers slotd))

(defun (setf %slot-definition-readers) (new slotd)
  (setf (standard-direct-slot-definition.readers slotd) new))

(defun %slot-definition-writers (slotd)
  (standard-direct-slot-definition.writers slotd))

(defun (setf %slot-definition-writers) (new slotd)
  (setf (standard-direct-slot-definition.writers slotd) new))

(defun %generic-function-name (gf)
  (sgf.name gf))

(defun %generic-function-method-combination (gf)
  (sgf.method-combination gf))

(defun %generic-function-method-class (gf)
  (sgf.method-class gf))


(defun %method-qualifiers (m)
  (%method.qualifiers m))

(defun %method-specializers (m)
  (%method.specializers m))

(defun %method-function (m)
  (%method.function m))

(defun (setf %method-function) (new m)
  (setf (%method.function m) new))

(defun %method-gf (m)
  (%method.gf m))

(defun (setf %method-gf) (new m)
  (setf (%method.gf m) new))

(defun %method-name (m)
  (%method.name m))

(defun %method-lambda-list (m)
  (%method.lambda-list m))

;;; Map slot-names (symbols) to SLOT-ID objects (which contain unique indices).
(let* ((next-slot-index 1)              ; 0 is never a valid slot-index
       (slot-id-hash (make-hash-table :test #'eq :weak t)))
  (defun ensure-slot-id (slot-name)
    (setq slot-name (require-type slot-name 'symbol))
    (without-interrupts
      (or (gethash slot-name slot-id-hash)
          (setf (gethash slot-name slot-id-hash)
                (%istruct 'slot-id slot-name (prog1
                                                 next-slot-index
                                               (incf next-slot-index)))))))
  (defun current-slot-index () next-slot-index)
  )


(defun %slot-id-lookup-obsolete (instance slot-id)
  (update-obsolete-instance instance)
  (funcall (%wrapper-slot-id->slotd (instance.class-wrapper instance))
           slot-id))

(defun slot-id-lookup-no-slots (instance slot-id)
  (declare (ignore instance slot-id)))

(defun %slot-id-ref-obsolete (instance slot-id)
  (update-obsolete-instance instance)
  (funcall (%wrapper-slot-id-value (instance.class-wrapper instance))
           instance slot-id))

(defun %slot-id-ref-missing (instance slot-id)
  (values (slot-missing (class-of instance) instance (slot-id.name slot-id) 'slot-value)))

(defun %slot-id-set-obsolete (instance slot-id new-value)
  (update-obsolete-instance instance)
  (funcall (%wrapper-set-slot-id-value (instance.class-wrapper instance))
           instance slot-id new-value))

(defun %slot-id-set-missing (instance slot-id new-value)
  (slot-missing (class-of instance) instance (slot-id.name slot-id) 'setf new-value)
  new-value)

;;; This becomes (apply #'make-instance <method-class> &rest args).
(defun %make-method-instance (class &key
				    qualifiers
				    specializers
				    function				    
				    name
				    lambda-list
                                    &allow-other-keys)
  (let* ((method
	  (%instance-vector (%class.own-wrapper class)
			    qualifiers
			    specializers
			    function
			    nil
			    name
			    lambda-list)))
    (when function
      (let* ((inner (closure-function function)))
        (unless (eq inner function)
          (copy-method-function-bits inner function)))
      (lfun-name function method))
    method))
  
       
		 
(defun encode-lambda-list (l &optional return-keys?)
  (multiple-value-bind (ok req opttail resttail keytail auxtail)
                       (verify-lambda-list l)
    (when ok
      (let* ((bits 0)
             (temp nil)
             (nreq (length req))
             (num-opt 0)
             (rest nil)
             (lexpr nil)
             (keyp nil)
             (key-list nil)
             (aokp nil)
             (hardopt nil))
        (when (> nreq #.(ldb $lfbits-numreq $lfbits-numreq))
          (return-from encode-lambda-list nil))
        (when (eq (pop opttail) '&optional)
          (until (eq opttail resttail)
            (when (and (consp (setq temp (pop opttail)))
                       (%cadr temp))
              (setq hardopt t))
            (setq num-opt (%i+ num-opt 1))))
        (when (eq (%car resttail) '&rest)
          (setq rest t))
        (when (eq (%car resttail) '&lexpr)
          (setq lexpr t))
        (when (eq (pop keytail) '&key)
          (setq keyp t)
          (labels ((ensure-symbol (x)
                     (if (symbolp x) x (return-from encode-lambda-list nil)))
                   (ensure-keyword (x)
                     (make-keyword (ensure-symbol x))))
            (declare (dynamic-extent #'ensure-symbol #'ensure-keyword))
            (until (eq keytail auxtail)
              (setq temp (pop keytail))
              (if (eq temp '&allow-other-keys)
                (progn
                  (setq aokp t)
                  (unless (eq keytail auxtail)
                    (return-from encode-lambda-list nil)))
                (when return-keys?
                  (push (if (consp temp)
                          (if (consp (setq temp (%car temp))) 
                            (ensure-symbol (%car temp))
                            (ensure-keyword temp))
                          (ensure-keyword temp))
                        key-list))))))
        (when (%i> nreq (ldb $lfbits-numreq -1))
          (setq nreq (ldb $lfbits-numreq -1)))
        (setq bits (dpb nreq $lfbits-numreq bits))
        (when (%i> num-opt (ldb $lfbits-numopt -1))
          (setq num-opt (ldb $lfbits-numopt -1)))
        (setq bits (dpb num-opt $lfbits-numopt bits))
        (when hardopt (setq bits (%ilogior (%ilsl $lfbits-optinit-bit 1) bits)))
        (when rest (setq bits (%ilogior (%ilsl $lfbits-rest-bit 1) bits)))
        (when lexpr (setq bits (%ilogior (%ilsl $lfbits-restv-bit 1) bits)))
        (when keyp (setq bits (%ilogior (%ilsl $lfbits-keys-bit 1) bits)))
        (when aokp (setq bits (%ilogior (%ilsl $lfbits-aok-bit 1) bits)))
        (if return-keys?
          (values bits (apply #'vector (nreverse key-list)))
          bits)))))

(defun pair-arg-p (thing &optional lambda-list-ok supplied-p-ok keyword-nesting-ok)
  (or (symbol-arg-p thing lambda-list-ok) ; nil ok in destructuring case
      (and (consp thing)
           (or (null (%cdr thing))
               (and (consp (%cdr thing))
                    (or (null (%cddr thing))
                        (and supplied-p-ok
                             (consp (%cddr thing))
                             (null (%cdddr thing))))))
           (if (not keyword-nesting-ok)
             (req-arg-p (%car thing) lambda-list-ok)
             (or (symbol-arg-p (%car thing) lambda-list-ok)
                 (and (consp (setq thing (%car thing)))
                      (consp (%cdr thing))
                      (null (%cddr thing))
                      (%car thing)
                      (symbolp (%car thing))
                      (req-arg-p (%cadr thing) lambda-list-ok)))))))

(defun req-arg-p (thing &optional lambda-list-ok)
 (or
  (symbol-arg-p thing lambda-list-ok)
  (lambda-list-arg-p thing lambda-list-ok)))

(defun symbol-arg-p (thing nil-ok)
  (and
   (symbolp thing)
   (or thing nil-ok)
   (not (memq thing lambda-list-keywords))))

(defun lambda-list-arg-p (thing lambda-list-ok)
  (and 
   lambda-list-ok
   (listp thing)
   (if (verify-lambda-list thing t t)
     (setq *structured-lambda-list* t))))

(defun opt-arg-p (thing &optional lambda-ok)
  (pair-arg-p thing lambda-ok t nil))

(defun key-arg-p (thing &optional lambda-ok)
  (pair-arg-p thing lambda-ok t t))

(defun proclaimed-ignore-p (sym)
  (cdr (assq sym *nx-proclaimed-ignore*)))

(defun verify-lambda-list (l &optional destructure-p whole-p env-p)
  (let* ((the-keys lambda-list-keywords)
         opttail
         resttail
         keytail
         allowothertail
         auxtail
         safecopy
         whole
         m
         n
         req
         sym
         (*structured-lambda-list* nil))
  (prog ()
    (multiple-value-setq (safecopy whole)
                         (normalize-lambda-list l whole-p env-p))
    (unless (or destructure-p (eq l safecopy) (go LOSE)))
    (setq l safecopy)
    (unless (dolist (key the-keys t)
              (when (setq m (cdr (memq key l)))
                (if (memq key m) (return))))
      (go LOSE))
    (if (null l) (go WIN))
    (setq opttail (memq '&optional l))
    (setq m (or (memq '&rest l)
                (unless destructure-p (memq '&lexpr l))))
    (setq n (if destructure-p (memq '&body l)))
    (if (and m n) (go LOSE) (setq resttail (or m n)))
    (setq keytail (memq '&key l))
    (if (and (setq allowothertail (memq '&allow-other-keys l))
             (not keytail))
      (go LOSE))
    (if (and (eq (car resttail) '&lexpr)
             (or keytail opttail))
      (go lose))
    (setq auxtail (memq '&aux l))
    (loop
      (when (null l) (go WIN))
      (when (or (eq l opttail)
                (eq l resttail)
                (eq l keytail)
                (eq l allowothertail)
                (eq l auxtail))
        (return))
      (setq sym (pop l))
      (unless (and (req-arg-p sym destructure-p)
                   (or (proclaimed-ignore-p sym)
                       (and destructure-p (null sym))
                       (not (memq sym req))))  ; duplicate required args
        (go LOSE))
      (push sym req))
    (when (eq l opttail)
      (setq l (%cdr l))
      (loop
        (when (null l) (go WIN))
        (when (or (eq l resttail)
                  (eq l keytail)
                  (eq l allowothertail)
                  (eq l auxtail))
          (return))
        (unless (opt-arg-p (pop l) destructure-p)
          (go LOSE))))
    (when (eq l resttail)
      (setq l (%cdr l))
      (when (or (null l)
                (eq l opttail)
                (eq l keytail)
                (eq l allowothertail)
                (eq l auxtail))
        (go LOSE))
      (unless (req-arg-p (pop l) destructure-p) (go LOSE)))
    (unless (or (eq l keytail)  ; allowothertail is a sublist of keytail if present
                (eq l auxtail))
      (go LOSE))
    (when (eq l keytail)
      (pop l)
      (loop
        (when (null l) (go WIN))
        (when (or (eq l opttail)
                  (eq l resttail))
          (go LOSE))
        (when (or (eq l auxtail) (setq n (eq l allowothertail)))
          (if n (setq l (%cdr l)))
          (return))
        (unless (key-arg-p (pop l) destructure-p) (go LOSE))))
    (when (eq l auxtail)
      (setq l (%cdr l))
      (loop
        (when (null l) (go WIN))
        (when (or (eq l opttail)
                  (eq l resttail)
                  (eq l keytail))
          (go LOSE))
        (unless (pair-arg-p (pop l)) (go LOSE))))
    (when l (go LOSE))
  WIN
  (return (values
           t
           (nreverse req)
           (or opttail resttail keytail auxtail)
           (or resttail keytail auxtail)
           (or keytail auxtail)
           auxtail
           safecopy
           whole
           *structured-lambda-list*))
  LOSE
  (return (values nil nil nil nil nil nil nil nil nil nil)))))

(defun normalize-lambda-list (x &optional whole-p env-p)
  (let* ((y x) whole env envtail head)
    (setq
     x
     (loop
       (when (atom y)
         (if (or (null y) (eq x y))  (return x))
         (setq x (copy-list x) y x)
         (return
          (loop
            (when (atom (%cdr y))
              (%rplacd y (list '&rest (%cdr y)))
              (return x))
            (setq y (%cdr y)))))
       (setq y (%cdr y))))
    (when env-p
      ; Trapped in a world it never made ... 
      (when (setq y (memq '&environment x))
        (setq envtail (%cddr y)
              env (%cadr y))
        (cond ((eq y x)
               (setq x envtail))
              (t
               (dolist (v x)
                 (if (eq v '&environment)
                   (return)
                   (push v head)))
               (setq x (nconc (nreverse head) envtail) y (%car envtail))))))
    (when (and whole-p 
               (eq (%car x) '&whole)
               (%cadr x))
      (setq whole (%cadr x) x (%cddr x)))
    (values x whole env)))




(defparameter *type-system-initialized* nil)

(eval-when (eval compile)
  (require 'defstruct-macros))

(eval-when (:compile-toplevel :execute)
  (defmacro make-instance-vector (wrapper len)
    (let* ((instance (gensym))
	   (slots (gensym)))
      `(let* ((,slots (allocate-typed-vector :slot-vector (1+ ,len) (%slot-unbound-marker)))
	      (,instance (gvector :instance 0 ,wrapper ,slots)))
	(setf (instance.hash ,instance) (strip-tag-to-fixnum ,instance)
	      (slot-vector.instance ,slots) ,instance))))
)

(eval-when (:compile-toplevel :execute)
  (defmacro make-structure-vector (size)
    `(%alloc-misc ,size ppc::subtag-struct nil))

)
;;;;;;;;;;;;;;;;;;;;;;;;;;; defmethod support ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(%fhave 'function-encapsulation ;Redefined in encapsulate
        (qlfun bootstrapping-function-encapsulation (name)
          (declare (ignore name))
          nil))

(%fhave '%move-method-encapsulations-maybe ; Redefined in encapsulate
        (qlfun boot-%move-method-encapsulations-maybe (m1 m2)
          (declare (ignore m1 m2))
          nil))


(%fhave 'find-unencapsulated-definition  ;Redefined in encapsulate
        (qlfun bootstrapping-unenecapsulated-def (spec)
          (values
           (typecase spec
             (symbol (fboundp spec))
             (method (%method-function spec))
             (t spec))
           spec)))


(defglobal *class-wrapper-random-state* (make-random-state))

(defun new-class-wrapper-hash-index ()
  ; mustn't be 0
  (the fixnum (1+ (the fixnum (random most-positive-fixnum *class-wrapper-random-state*)))))

(defun %inner-method-function (method)
  (let ((f (%method-function method)))
    (when (function-encapsulation f)
      (setq f (find-unencapsulated-definition f)))
    (closure-function f)))


(defun copy-method-function-bits (from to)
  (let ((new-bits (logior (logand (logior (lsh 1 $lfbits-method-bit)
                                          (ash 1 $lfbits-nextmeth-bit)
                                          (ash 1 $lfbits-nextmeth-with-args-bit)
                                          $lfbits-args-mask) 
                                  (lfun-bits from))
                          (logand (lognot (logior (lsh 1 $lfbits-method-bit)
                                                  (ash 1 $lfbits-nextmeth-bit)
                                                  (ash 1 $lfbits-nextmeth-with-args-bit)
                                                  $lfbits-args-mask))
                                  (lfun-bits to)))))
    (lfun-bits to new-bits)
    new-bits))

(defun %ensure-generic-function-using-class (gf function-name &rest keys
						&key 
						&allow-other-keys)
  (if gf
    (apply #'%ensure-existing-generic-function-using-class gf function-name keys)
    (apply #'%ensure-new-generic-function-using-class function-name keys)))

(defun ensure-generic-function (function-name &rest keys &key &allow-other-keys)
  (let* ((def (fboundp function-name)))
    (when (and def (not (typep def 'generic-function)))
      (cerror "Try to remove any global non-generic function or macro definition."
	      "~s is defined as something other than a generic function." function-name)
      (fmakunbound function-name)
      (setq def nil))
    (apply #'%ensure-generic-function-using-class def function-name keys)))


(defun %ensure-new-generic-function-using-class
    (function-name &rest keys &key
		   (generic-function-class *standard-generic-function-class* gfc-p)
                   &allow-other-keys)
  (declare (dynamic-extent keys))
  (when gfc-p
    (if (symbolp generic-function-class)
      (setq generic-function-class (find-class generic-function-class)))
    (unless (subtypep generic-function-class *standard-generic-function-class*)
      (error "~s is not a subtype of ~s" generic-function-class *generic-function-class*))
    (remf keys :generic-function-class))
  (let* ((gf (apply #'%make-gf-instance generic-function-class keys)))
    (unless (eq (%gf-method-combination gf) *standard-method-combination*)
      (register-gf-method-combination gf (%gf-method-combination gf)))
    (setf (sgf.name gf) (getf keys :name function-name))
    (setf (fdefinition function-name) gf)))

(defun %ensure-existing-generic-function-using-class
    (gf function-name &key
	(generic-function-class *standard-generic-function-class* gfc-p)
	(method-combination *standard-method-combination* mcomb-p)
	(method-class *standard-method-class* mclass-p)
	(argument-precedence-order nil apo-p)
	declarations
	(lambda-list nil ll-p)
	name)
  (when gfc-p
    (if (symbolp generic-function-class)
      (setq generic-function-class (find-class generic-function-class)))
    (unless (subtypep generic-function-class *standard-generic-function-class*)
      (error "~s is not a subtype of ~s" generic-function-class *standard-generic-function-class*)))
  (when mcomb-p
    (unless (typep method-combination 'method-combination)
      (report-bad-arg method-combination 'method-combination)))
  (when mclass-p
    (if (symbolp method-class)
      (setq method-class (find-class method-class)))
    (unless (subtypep method-class *method-class*)
      (error "~s is not a subtype of ~s." method-class *method-class*)))
  (when declarations
    (unless (list-length declarations)
      (error "~s is not a proper list")))
  ;; Fix APO, lambda-list
  (if apo-p
    (if (not ll-p)
      (error "Cannot specify ~s without specifying ~s" :argument-precedence-order
	     :lambda-list)))
  (let* ((old-mc (sgf.method-combination gf)))
    (unless (eq old-mc method-combination)
      (unless (eq old-mc *standard-method-combination*)
	(unregister-gf-method-combination gf method-combination))))
    (setf (sgf.name gf) (or name function-name)
	  (sgf.decls gf) declarations
	  (sgf.method-class gf) method-class
	  (sgf.method-combination gf) method-combination)
    (unless (eq method-combination *standard-method-combination*)
      (register-gf-method-combination gf method-combination))
    (when ll-p
      (if apo-p
        (set-gf-arg-info gf :lambda-list lambda-list
                         :argument-precedence-order argument-precedence-order)
        (set-gf-arg-info gf :lambda-list lambda-list)))
    (setf (fdefinition function-name) gf))

(defun canonicalize-specializer (spec)
  (if (specializer-p spec)
    spec
    (if (symbolp spec)
      (find-class spec)
      (if (and (consp spec)
               (eq (car spec) 'eql)
               (consp (cdr spec))
               (null (cddr spec)))
        (intern-eql-specializer (cadr spec))
        (error "Unknown specializer form ~s" spec)))))

;;; The inverse operation: for printing, etc.
(defun uncanonicalize-specializer (specializer)
  (etypecase specializer
    (class (class-name specializer))
    (eql-specializer (list 'eql (eql-specializer-object specializer)))))

(defun canonicalize-specializers (specifiers)
  (mapcar #'canonicalize-specializer specifiers))

(defun uncanonicalize-specializers (specializers)
  (mapcar #'uncanonicalize-specializer specializers))

(defun ensure-method (name specializers &rest keys &key (documentation nil doc-p) qualifiers
                           &allow-other-keys)
  (declare (dynamic-extent keys))
  (setq specializers (canonicalize-specializers specializers))
  (let ((gf (ensure-generic-function name)))
    (unless (generic-function-p gf) ; allow for boneheaded programmers who specialize e-g-f and break its contract
      (error "ENSURE-GENERIC-FUNCTION failed to return a generic function. Instead it returned ~a when passed ~s."
             gf (list* name specializers keys)))
    (let ((method (apply #'%make-method-instance
                         (%gf-method-class gf)
                         :name name
                         :specializers specializers
                         keys))
          (old-method (when (%gf-methods gf)
                        (ignore-errors
                         (find-method gf qualifiers specializers nil)))))
      (%add-method gf method)
      (when (and doc-p *save-doc-strings*)
        (set-documentation method t documentation))
      (record-source-file method 'method)
      (when old-method (%move-method-encapsulations-maybe old-method method))
      method)))
        
(defun forget-encapsulations (name)
  (declare (ignore name))
  nil)

(defun %anonymous-method (function specializers qualifiers  lambda-list &optional documentation
                                   &aux name method-class)
  (let ((inner-function (closure-function function)))
    (unless (%method-function-p inner-function)
      (report-bad-arg inner-function 'method-function))   ; Well, I suppose we'll have to shoot you.
    (unless (eq inner-function function)   ; must be closed over
      (copy-method-function-bits inner-function function))
    (setq name (function-name inner-function))
    (if (typep name 'standard-method)     ; method-function already installed.
      (setq name (%method-name name)))
    (setq method-class *standard-method-class*)
    (unless (memq *standard-method-class* (or (%class.cpl method-class)
                                              (%class.cpl (update-class  method-class t))))
      (%badarg method-class 'standard-method))
;    (unless (member qualifiers '(() (:before) (:after) (:around)) :test #'equal)
;      (report-bad-arg qualifiers))
    (setq specializers (mapcar #'(lambda (s)
                                   (or (and (consp s)
                                            (eq (%car s) 'eql)
                                            (consp (%cdr s))
                                            (null (%cddr s))
                                            (intern-eql-specializer (%cadr s)))
                                       (and (specializer-p s) s)
                                       (find-class s)))
                               specializers))
    (let ((method (%make-method-instance method-class
                      :name name
		      :lambda-list lambda-list
                      :qualifiers qualifiers
                      :specializers specializers
                      :function function)))
      (lfun-name inner-function method)
      (when documentation
        (set-documentation method t documentation))
      method)))

	   
(defun check-defmethod-congruency (gf method)
  (unless (congruent-lambda-lists-p gf method)
    (cerror (format nil
		    "Remove ~d method~:p from the generic-function and change its lambda list."
		    (length (%gf-methods gf)))
	    "Incompatible lambda list in ~S for ~S" method gf)
    (loop
      (let ((methods (%gf-methods gf)))
        (if methods
          (remove-method gf (car methods))
          (return))))
    (%set-defgeneric-keys gf nil)
    (inner-lfun-bits gf (%ilogior (%ilsl $lfbits-gfn-bit 1)
                            (%ilogand $lfbits-args-mask
                                      (lfun-bits (%method-function method))))))
  gf)



(defun %method-function-method (method-function)
  (setq method-function
        (closure-function
         (if (function-encapsulation method-function)
           (find-unencapsulated-definition method-function)
           method-function)))
  (setq method-function (require-type method-function 'method-function))
  (lfun-name method-function))

(defglobal %defgeneric-methods% (make-hash-table :test 'eq :weak t))

(defun %defgeneric-methods (gf)
   (gethash gf %defgeneric-methods%))

(defun %set-defgeneric-methods (gf &rest methods)
   (if methods
     (setf (gethash gf %defgeneric-methods%) methods)
     (remhash gf %defgeneric-methods%)))

(defun %defgeneric-keys (gf)
  (%gf-dispatch-table-keyvect (%gf-dispatch-table gf)))

(defun %set-defgeneric-keys (gf keyvect)
  (setf (%gf-dispatch-table-keyvect (%gf-dispatch-table gf)) keyvect))

(defun congruent-lfbits-p (gbits mbits)
  (and (eq (ldb $lfbits-numreq gbits) (ldb $lfbits-numreq mbits))
       (eq (ldb $lfbits-numopt gbits) (ldb $lfbits-numopt mbits))
       (eq (or (logbitp $lfbits-rest-bit gbits)
               (logbitp $lfbits-restv-bit gbits)
               (logbitp $lfbits-keys-bit gbits))
           (or (logbitp $lfbits-rest-bit mbits)
               (logbitp $lfbits-restv-bit mbits)
               (logbitp $lfbits-keys-bit mbits)))))

(defun congruent-lambda-lists-p (gf method &optional
                                    error-p gbits mbits gkeys)
  (unless gbits (setq gbits (inner-lfun-bits gf)))
  (unless mbits (setq mbits (lfun-bits (%method-function method))))
  (and (congruent-lfbits-p gbits mbits)
       (or (and (or (logbitp $lfbits-rest-bit mbits)
                    (logbitp $lfbits-restv-bit mbits))
                (not (logbitp $lfbits-keys-bit mbits)))
           (logbitp $lfbits-aok-bit mbits)
           (progn
             (unless gkeys (setq gkeys (%defgeneric-keys gf)))
             (or (null gkeys)
                 (eql 0 (length gkeys))
                 (let ((mkeys (lfun-keyvect
                               (%inner-method-function method))))
                   (dovector (key gkeys t)
                     (unless (find key mkeys :test 'eq)
                       (if error-p
                         (error "~s does not specify keys: ~s" method gkeys))
                       (return nil)))))))))

(defun %add-method (gf method)
  (%add-standard-method-to-standard-gf gf method))

(defun %add-standard-method-to-standard-gf (gfn method)
  (let ((method-gf (%method-gf method)))
    (when (and method-gf ; it's okay if the method already thinks it's part of the same gf
               (not (eq method-gf gfn)))
      (error "~s is already a method of ~s." method (%method-gf method)))
    (set-gf-arg-info gfn :new-method method)
    (let* ((dt (%gf-dispatch-table gfn))
	   (methods (sgf.methods gfn))
	   (specializers (%method-specializers method))
	   (qualifiers (%method-qualifiers method)))
      (remove-obsoleted-combined-methods method dt specializers)
      (apply #'invalidate-initargs-vector-for-gf gfn specializers)
      (dolist (m methods)
        (when (and (equal specializers (%method-specializers m))
		   (equal qualifiers (%method-qualifiers m)))
	  (remove-method gfn m)
	  ;; There can be at most one match
	  (return)))
      (push method (sgf.methods gfn))
      (setf (%gf-dispatch-table-methods dt) (sgf.methods gfn))
      (setf (%method-gf method) gfn)
      (%add-direct-methods method)
      (compute-dcode gfn dt)
      (when (sgf.dependents gfn)
        (map-dependents gfn #'(lambda (d)
			        (update-dependent gfn d 'add-method method)))))
    gfn))

(defglobal *standard-kernel-method-class* nil)

(defun redefine-kernel-method (method)
  (when (and *warn-if-redefine-kernel*
             (or (let ((class *standard-kernel-method-class*))
                   (and class (typep method class)))
                 (and (standard-method-p method)
                      (kernel-function-p (%method-function method)))))
    (cerror "Replace the definition of ~S."
            "The method ~S is predefined in MCL." method)))

; Called by the expansion of generic-labels
(defun %add-methods (gf &rest methods)
  (declare (dynamic-extent methods))
  (dolist (m methods)
    (add-method gf m)))

(defun methods-congruent-p (m1 m2)
  (when (and (standard-method-p m1)(standard-method-p m2))
    (when (equal (%method-qualifiers m1) (%method-qualifiers m2))
      (let ((specs (%method-specializers m1)))
        (dolist (msp (%method-specializers m2) t)
          (let ((spec (%pop specs)))
            (unless (eq msp spec)
              (return nil))))))))

(defvar *maintain-class-direct-methods* nil)



; CAR is an EQL hash table for objects whose identity is not used by EQL
; (numbers and macptrs)
; CDR is a weak EQ hash table for other objects.
(defvar *eql-methods-hashes* (cons (make-hash-table :test 'eql)
                                   (make-hash-table :test 'eq :weak :key)))

(defun eql-methods-cell (object &optional addp)
  (let ((hashes *eql-methods-hashes*))
    (without-interrupts
     (let* ((hash (cond
                   ((or (typep object 'number)
                        (typep object 'macptr))
                    (car hashes))
                   (t (cdr hashes))))
            (cell (gethash object hash)))
       (when (and (null cell) addp)
         (setf (gethash object hash) (setq cell (cons nil nil))))
       cell))))




(defun map-classes (function)
  (with-hash-table-iterator (m %find-classes%)
    (loop
      (multiple-value-bind (found name cell) (m)
        (declare (list cell))
        (unless found (return))
        (when (cdr cell)
          (funcall function name (cdr cell)))))))


#|
(defun %class-primary-slot-accessor-info (class accessor-or-slot-name &optional create?)
  (let ((info-list (%class-get class '%class-primary-slot-accessor-info)))
    (or (car (member accessor-or-slot-name info-list
                     :key #'(lambda (x) (%slot-accessor-info.accessor x))))
        (and create?
             (let ((info (%cons-slot-accessor-info class accessor-or-slot-name)))
               (setf (%class-get class '%class-primary-slot-accessor-info)
                     (cons info info-list))
               info)))))

;; Clear the %class.primary-slot-accessor-info for an added or removed method's specializers
(defun clear-accessor-method-offsets (gf method)
  (when (or (typep method 'standard-accessor-method)
            (member 'standard-accessor-method
                    (%gf-methods gf)
                    :test #'(lambda (sam meth)
                             (declare (ignore sam))
                             (typep meth 'standard-accessor-method))))
    (labels ((clear-class (class)
               (when (typep class 'standard-class)
                 (let ((info (%class-primary-slot-accessor-info class gf)))
                   (when info
                     (setf (%slot-accessor-info.offset info) nil)))
                 (mapc #'clear-class (%class.subclasses class)))))
      (declare (dynamic-extent #'clear-class))
      (mapc #'clear-class (%method-specializers method)))))
|#

;; Remove methods which specialize on a sub-class of method's specializers from
;; the generic-function dispatch-table dt.
(defun remove-obsoleted-combined-methods (method &optional dt
                                                 (specializers (%method-specializers method)))
  (without-interrupts
   (unless dt
     (let ((gf (%method-gf method)))
       (when gf (setq dt (%gf-dispatch-table gf)))))
   (when dt
     (if specializers
       (let* ((argnum (%gf-dispatch-table-argnum dt))
              (class (nth argnum specializers))
              (size (%gf-dispatch-table-size dt))
              (index 0))
         #+ignore
         (clear-accessor-method-offsets (%gf-dispatch-table-gf dt) method)
         (if (typep class 'eql-specializer)                   ; eql specializer
           (setq class (class-of (eql-specializer-object class))))
         (while (%i< index size)
           (let* ((wrapper (%gf-dispatch-table-ref dt index))
                  hash-index-0?
                  (cpl (and wrapper
                            (not (setq hash-index-0?
                                       (eql 0 (%wrapper-hash-index wrapper))))
                            (%inited-class-cpl
                             (require-type (%wrapper-class wrapper) 'class)))))
             (when (or hash-index-0? (and cpl (cpl-index class cpl)))
               (setf (%gf-dispatch-table-ref dt index) *obsolete-wrapper*
                     (%gf-dispatch-table-ref dt (%i+ index 1)) *gf-dispatch-bug*))
             (setq index (%i+ index 2)))))
       (setf (%gf-dispatch-table-ref dt 1) nil)))))   ; clear 0-arg gf cm

; SETQ'd below after the GF's exist.
(defvar *initialization-invalidation-alist* nil)

; Called by %add-method, %remove-method
(defun invalidate-initargs-vector-for-gf (gf &optional first-specializer &rest other-specializers)
  (declare (ignore other-specializers))
  (when (and first-specializer (typep first-specializer 'class))        ; no eql methods or gfs with no specializers need apply
    (let ((indices (cdr (assq gf *initialization-invalidation-alist*))))
      (when indices
        (labels ((invalidate (class indices)
                             (when (std-class-p class)   ; catch the class named T
                               (dolist (index indices)
                                 (setf (standard-instance-instance-location-access class index) nil)))
                             (dolist (subclass (%class.subclasses class))
                               (invalidate subclass indices))))
          (invalidate first-specializer indices))))))

;; Return two values:
;; 1) the index of the first non-T specializer of method, or NIL if
;;    all the specializers are T or only the first one is T
;; 2) the index of the first non-T specializer
(defun multi-method-index (method &aux (i 0) index)
  (dolist (s (%method-specializers method) (values nil index))
    (unless (eq s *t-class*)
      (unless index (setq index i))
      (unless (eql i 0) (return (values index index))))
    (incf i)))

(defun %remove-standard-method-from-containing-gf (method)
  (setq method (require-type method 'standard-method))
  (let ((gf (%method-gf method)))
    (when gf
      (let* ((dt (%gf-dispatch-table gf))
	     (methods (sgf.methods gf)))
        (setf (%method-gf method) nil)
	(setq methods (nremove method methods))
        (setf (%gf-dispatch-table-methods dt) methods
	      (sgf.methods gf) methods)
        (%remove-direct-methods method)
        (remove-obsoleted-combined-methods method dt)
        (apply #'invalidate-initargs-vector-for-gf gf (%method-specializers method))
        (compute-dcode gf dt)
	(when (sgf.dependents gf)
	  (map-dependents
	   gf
	   #'(lambda (d)
	       (update-dependent gf d 'remove-method method)))))))
  method)

(eval-when (:compile-toplevel :execute)

(defmacro slot-id->slotd (slot-id wrapper)
  (let ((map (gensym))
        (index (gensym))
        (instance-index (gensym)))
    `(let* ((,index (slot-id.index ,slot-id))
            (,map (%wrapper-slot-id-map ,wrapper)))
       (when (and ,map (%i< ,index (uvsize ,map)))
         (let ((,instance-index (uvref ,map ,index)))
           (when (neq ,instance-index 0)
             (%svref (%wrapper-slot-definition-table ,wrapper) ,instance-index)))))))

;; do we need this? see e.g. %maybe-std-slot-value-using-class
(defmacro %standard-wrapper-test (wrapper)
  (let ((class (gensym)))
    `(let ((,class (%wrapper-class ,wrapper)))
       (and (eql (ppc-typecode ,class) ppc::subtag-instance)
            (eq *standard-class-wrapper* (instance.class-wrapper ,class))))))


;; do we need this? 
(defmacro %standard-slotd-test (slotd)
  `(and (eql (ppc-typecode ,slotd) ppc::subtag-instance)
        (eq *standard-effective-slot-definition-class-wrapper*
            (instance.class-wrapper ,slotd))))
)


#|
(defvar *reader-method-function-proto*
  #'(lambda (instance)
      (slot-value instance 'x)))
|#



#|
(defparameter *reader-method-function-proto4*
  #'(lambda (instance)
      (let* ((slot-id 'x)
             (wrapper (instance.class-wrapper instance)))    
        (if (eq 0 (%wrapper-instance-slots wrapper))
          (%slot-id-ref-obsolete instance slot-id)
          (let ((slotd (slot-id->slotd slot-id wrapper )))
            (if slotd         
              (if (%standard-slotd-test slotd)  ;; do we need this?
                (let* ((loc (standard-effective-slot-definition.location slotd))
                       (val (if (fixnump loc)
                              (%svref  (instance.slots instance) loc)
                              (%cdr (standard-effective-slot-definition.location slotd)))))            
                  (if (eq val (%slot-unbound-marker))
                    (slot-unbound (%wrapper-class wrapper) instance (slot-id.name slot-id))
                    val))
                (slot-value-using-class (%wrapper-class wrapper) instance slotd))
              (%slot-id-ref-missing instance slot-id)))))))
|#



(defparameter *reader-method-function-proto5*
  #'(lambda (instance)
      (let* ((slot-id 'x)
             (my-cons 'y)
             (wrapper (instance.class-wrapper instance))
             (wrapper-instance-slots (%wrapper-instance-slots wrapper)))        
        (if (eq 0 wrapper-instance-slots)
          (progn
            (%rplacd my-cons nil)
            (%slot-id-ref-obsolete instance slot-id))
          (progn 
            ;; if slots changed since last we looked, redo the slot-id mappping
            (when (neq wrapper-instance-slots (%cdr my-cons))
              (%rplaca my-cons (slot-id->slotd slot-id wrapper))
              (%rplacd my-cons wrapper-instance-slots))
            (let ((slotd (%car my-cons)))
              (if slotd
                (let* ((loc (standard-effective-slot-definition.location slotd))
                       (val (if (fixnump loc)
                              (%svref  (instance.slots instance) loc)
                              (%cdr loc))))            
                  (if (eq val (%slot-unbound-marker))
                    (slot-unbound (%wrapper-class wrapper) instance (slot-id.name slot-id))
                    val))
                (%slot-id-ref-missing instance slot-id))))))))




#|
(defvar *writer-method-function-proto*
  #'(lambda (new instance)
      (set-slot-value instance 'x new)))
|#



#|
(defparameter *writer-method-function-proto4*
  #'(lambda (value  instance)
      (let ((slot-id 'x)
            (wrapper (instance.class-wrapper instance)))    
        (if (eq 0 (%wrapper-instance-slots wrapper))
          (%slot-id-set-obsolete instance slot-id value)
          (let ((slotd (slot-id->slotd slot-id wrapper)))  
            (if slotd
              (if (%standard-slotd-test slotd)
                (progn
                  (when (neq value (%slot-unbound-marker))
                    (let ((type (standard-effective-slot-definition.type slotd)))
                      (unless (or (eq type t) (funcall (standard-effective-slot-definition.type-predicate slotd) value))
                        (setq value  (require-type value type)))))
                  (let ((loc (standard-effective-slot-definition.location slotd)))
                    (if (fixnump loc)
                      (%svset (instance.slots instance) loc value)
                      (setf (%cdr loc) value))))
                (setf (slot-value-using-class (%wrapper-class wrapper) instance slotd) value))
              (%slot-id-set-missing instance slot-id  value)))))))
|#

(defparameter *writer-method-function-proto5*
  #'(lambda (value  instance)
      (let* ((slot-id 'x)
             (my-cons 'y)
             (wrapper (instance.class-wrapper instance))
             (wrapper-instance-slots (%wrapper-instance-slots wrapper)))
        (if (eq 0 wrapper-instance-slots)
          (progn 
            (%rplacd my-cons nil)
            (%slot-id-set-obsolete instance slot-id value))
          (progn
            (when (neq wrapper-instance-slots (%cdr my-cons))
              (%rplaca my-cons (slot-id->slotd slot-id wrapper))
              (%rplacd my-cons wrapper-instance-slots))
            (let ((slotd (%car my-cons)))
              (if slotd
                (progn
                  (when (neq value (%slot-unbound-marker))
                    (let ((type (standard-effective-slot-definition.type slotd)))
                      (unless (or (eq type t) (funcall (standard-effective-slot-definition.type-predicate slotd) value))
                        (setq value  (require-type value type)))))
                  (let ((loc (standard-effective-slot-definition.location slotd)))
                    (if (fixnump loc)
                      (%svset (instance.slots instance) loc value)
                      (setf (%cdr loc) value))))
                (%slot-id-set-missing instance slot-id  value))))))))




(defparameter dcode-proto-alist
  (list (cons #'%%one-arg-dcode *gf-proto-one-arg*)
        (cons #'%%1st-two-arg-dcode *gf-proto-two-arg*)
        (cons #'%%2nd-two-arg-dcode *gf-proto-two-arg*)))

    
(defun compute-dcode (gf &optional dt)
  (setq gf (require-type gf 'standard-generic-function))
  (unless dt (setq dt (%gf-dispatch-table gf)))
  (let* ((methods (%gf-dispatch-table-methods dt))
         (bits (inner-lfun-bits gf))
         (nreq (ldb $lfbits-numreq bits))
         (0-args? (eql 0 nreq))
         (other-args? (or (not (eql 0 (ldb $lfbits-numopt bits)))
                          (logbitp $lfbits-rest-bit bits)
                          (logbitp $lfbits-restv-bit bits)
                          (logbitp $lfbits-keys-bit bits)
                          (logbitp $lfbits-aok-bit bits)))
         multi-method-index 
	 min-index
         (only-writers (and (eq nreq 2)(null other-args?)))
         )
    (when methods
      (unless 0-args?
        (dolist (m methods)
          #+ignore
          (when only-writers
            (let ((method-class (class-of m)))
              (when (neq  method-class *standard-writer-method-class*)                
                (setq only-writers nil))))
          (multiple-value-bind (mm-index index) (multi-method-index m)
            (when (and only-writers (not (and (eq mm-index 1)(eq index 1))))
              (setq only-writers nil))
            (when mm-index
              (if (or (null multi-method-index) (< mm-index multi-method-index))
                (setq multi-method-index mm-index)))
            (when index
              (if (or (null min-index) (< index min-index))
                (setq min-index index))))))
      (let ((dcode (if 0-args?
                     #'%%0-arg-dcode
                     (if only-writers
                       #'%%2nd-two-arg-dcode
                       (if multi-method-index
                         #'%%nth-arg-dcode
                         (if (null other-args?)
                           (if (eql nreq 1)
                             #'%%one-arg-dcode
                             (if (eql nreq 2)
                               #'%%1st-two-arg-dcode
                               #'%%1st-arg-dcode))                            
                           #'%%1st-arg-dcode))))))
        (setq multi-method-index
              (if multi-method-index
                (if min-index
                  (min multi-method-index min-index)
                  multi-method-index)
                0))
        (let* ((old-dcode (%gf-dcode gf))
               (encapsulated-dcode-cons (and (combined-method-p old-dcode)
                                             (eq '%%call-gf-encapsulation 
                                                 (function-name (%combined-method-dcode old-dcode)))
                                             (cdr (%combined-method-methods old-dcode)))))
          (when (or (neq dcode (if encapsulated-dcode-cons (cdr encapsulated-dcode-cons) old-dcode))
                    (neq multi-method-index (%gf-dispatch-table-argnum dt)))
            (let ((proto (or (cdr (assq dcode dcode-proto-alist)) *gf-proto*)))
              (clear-gf-dispatch-table dt)
              (setf (%gf-dispatch-table-argnum dt) multi-method-index)
              (if encapsulated-dcode-cons ; and more?
                (let ((old-gf (car encapsulated-dcode-cons)))
                  (if (not (typep old-gf 'generic-function))
                    (error "Confused"))
                  ;(setf (uvref old-gf 0)(uvref proto 0))
                  (setf (cdr encapsulated-dcode-cons) dcode))
                (progn 
                  (setf (%gf-dcode gf) dcode)
                  (setf (uvref gf 0)(uvref proto 0)))))))
        (values dcode multi-method-index)))))




(defun inherits-from-standard-generic-function-p (class)
  (memq *standard-generic-function-class*
        (%inited-class-cpl (require-type class 'class))))

;;;;;;;;;;; The type system needs to get wedged into CLOS fairly early ;;;;;;;


; Could check for duplicates, but not really worth it.  They're all allocated here
(defun new-type-class (name)
  (let* ((class (%istruct 
                 'type-class 
                 name
                 #'missing-type-method
                 nil
                 nil
                 #'(lambda (x y) (vanilla-union x y))
                 nil
                 #'(lambda (x y) (vanilla-intersection x y))
                 nil
                 #'missing-type-method
                 nil
                 #'missing-type-method)))
    (push (cons name class) *type-classes*)
    class))

;; There are ultimately about a dozen entries on this alist.
(defvar *type-classes* nil)
(declaim (special *wild-type* *empty-type* *universal-type*))
(defvar *type-kind-info* (make-hash-table :test #'equal))

(defun info-type-kind (name)
  (gethash name *type-kind-info*))

(defun (setf info-type-kind) (val name)
  (setf (gethash name *type-kind-info*) val))

(defun missing-type-method (&rest foo)
  (error "Missing type method for ~S" foo))
          
(new-type-class 'values)
(new-type-class 'function)
(new-type-class 'constant)
(new-type-class 'wild)
(new-type-class 'bottom)
(new-type-class 'named)
(new-type-class 'hairy)
(new-type-class 'unknown)
(new-type-class 'number)
(new-type-class 'array)
(new-type-class 'member)
(new-type-class 'union)
(new-type-class 'foreign)
(new-type-class 'cons)
(new-type-class 'intersection)
(new-type-class 'negation)
(defparameter *class-type-class* (new-type-class 'class))


                        
;;;;;;;;;;;;;;;;;;;;;;;;  Instances and classes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar %find-classes% (make-hash-table :test 'eq))

(defun class-cell-typep (form class-cell)
  (unless (listp class-cell)(error "puke"))
  (locally (declare (type list class-cell))
    (let ((class (cdr class-cell)))
      (when (not class)
        (setq class (find-class (car class-cell) nil))
        (when class (rplacd class-cell class)))
      (if class
        (not (null (memq class (%inited-class-cpl (class-of form)))))
        (if (fboundp 'typep)(typep form (car class-cell)) t)))))


;(defvar puke nil)

(defun %require-type-class-cell (arg class-cell)
  ; sort of weird  
  (if (or ;(not *type-system-initialized*)
          (not (listp class-cell)))  ; bootstrapping prob no longer
    arg ; (progn (pushnew class-cell puke) arg)
    (if (class-cell-typep arg class-cell)
      arg
      (%kernel-restart $xwrongtype arg (car class-cell)))))



(defun find-class-cell (name create?)
  (let ((cell (gethash name %find-classes%)))
    (or cell
        (and create?
             (setf (gethash name %find-classes%) (cons name nil))))))


(defun find-class (name &optional (errorp t) environment)
  (let* ((cell (find-class-cell name nil)))
    (declare (list cell))
    (or (cdr cell)
        (let ((defenv (and environment (definition-environment environment))))
          (when defenv
            (dolist (class (defenv.classes defenv))
              (when (eq name (%class.name class))
                (return class)))))
        (when (or errorp (not (symbolp name)))
          (error "Class named ~S not found." name)))))

(defun set-find-class (name class)
  (clear-type-cache)
  (let ((cell (find-class-cell name class)))
    (when cell
      (setf (info-type-kind name) :instance)
      (setf (cdr (the cons cell)) class))
    class))


; bootstrapping definition. real one is in "sysutils.lisp"

(defun built-in-type-p (name)
  (or (type-predicate name)
      (memq name '(signed-byte unsigned-byte mod 
                   values satisfies member and or not))
      (typep (find-class name nil) 'built-in-class)))



(defun %compile-time-defclass (name environment)
  (unless (find-class name nil environment)
    (let ((defenv (definition-environment environment)))
      (when defenv
        (push (make-instance 'compile-time-class :name name)
              (defenv.classes defenv)))))
  name)

(queue-fixup
 (without-interrupts 
  (defun set-find-class (name class)
    (setq name (require-type name 'symbol))
    (let ((cell (find-class-cell name class)))
      (declare (type list cell))
      (when *warn-if-redefine-kernel*
        (let ((old-class (cdr cell)))
          (when (and old-class (neq class old-class) (%class.kernel-p old-class))
            (cerror "Redefine ~S."
                    "~S is already defined in the CCL kernel." old-class)
            (setf (%class.kernel-p old-class) nil))))
      (when (null class)
        (when cell
          (setf (cdr cell) nil))
        (return-from set-find-class nil))
      (setq class (require-type class 'class))
      (when (built-in-type-p name)
        (unless (eq (cdr cell) class)
          (error "Cannot redefine built-in type name ~S" name)))
      (when (%deftype-expander name)
        (cerror "set ~S anyway, removing the ~*~S definition"
                "Cannot set ~S because type ~S is already defined by ~S"
                `(find-class ',name) name 'deftype)
        (%deftype name nil nil))
      (setf (info-type-kind name) :instance)
      (setf (cdr cell) class)))
  ) ; end of without-interrupts
 ) ; end of queue-fixup



#|
; This tended to cluster entries in gf dispatch tables too much.
(defvar *class-wrapper-hash-index* 0)
(defun new-class-wrapper-hash-index ()
  (let ((index *class-wrapper-hash-index*))
    (setq *class-wrapper-hash-index*
        (if (< index (- most-positive-fixnum 2))
          ; Increment by two longwords.  This is important!
          ; The dispatch code will break if you change this.
          (%i+ index 3)                 ; '3 = 24 bytes = 6 longwords in lap.
          1))))
|#



; Initialized after built-in-class is made
(defvar *built-in-class-wrapper* nil)

(defun make-class-ctype (class)
  (%istruct 'class-ctype *class-type-class* nil class nil))


(defvar *t-class* (let ((class (%cons-built-in-class 't)))
                    (setf (%class.cpl class) (list class))
                    (setf (%class.own-wrapper class)
                          (%cons-wrapper class (new-class-wrapper-hash-index)))
                    (setf (%class.ctype class) (make-class-ctype class))
                    (setf (find-class 't) class)
                    class))

(defun compute-cpl (class)
  (flet ((%real-class-cpl (class)
           (or (%class.cpl class)
               (compute-cpl class))))
    (let* ((predecessors (list (list class))) candidates cpl)
      (dolist (sup (%class.local-supers class))
        (when (symbolp sup) (report-bad-arg sup 'class))
        (dolist (sup (%real-class-cpl sup))
          (unless (assq sup predecessors) (push (list sup) predecessors))))
      (labels ((compute-predecessors (class table)
                 (dolist (sup (%class.local-supers class) table)
                   (compute-predecessors sup table)
                   ;(push class (cdr (assq sup table)))
                   (let ((a (assq sup table))) (%rplacd a (cons class (%cdr a))))
                   (setq class sup))))
        (compute-predecessors class predecessors))
      (setq candidates (list (assq class predecessors)))
      (while predecessors
        (dolist (c candidates 
                   (error "Inconsistent superclasses for ~s re: ~s" class candidates))
          (when (null (%cdr c))
            (setq predecessors (nremove c predecessors))
            (dolist (p predecessors) (%rplacd p (nremove (%car c) (%cdr p))))
            (setq candidates (nremove c candidates))
            (setq cpl (%rplacd c cpl))
            (dolist (sup (%class.local-supers (%car c)))
              (when (setq c (assq sup predecessors)) (push c candidates)))
            (return))))
      (setq cpl (nreverse cpl))
      (do* ((tail cpl (%cdr tail))
            sup-cpl)
           ((null (setq sup-cpl (and (cdr tail) (%real-class-cpl (cadr tail))))))
        (when (equal (%cdr tail) sup-cpl)
          (setf (%cdr tail) sup-cpl)
          (return)))
      cpl)))

(defun make-built-in-class (name &rest supers)
  (if (null supers)
    (setq supers (list *t-class*))
    (do ((supers supers (%cdr supers)))
        ((null supers))
      (when (symbolp (%car supers)) (%rplaca supers (find-class (%car supers))))))
  (let ((class (find-class name nil)))
    (if class
      (progn
        ;Must be debugging.  Give a try at redefinition...
        (dolist (sup (%class.local-supers class))
          (setf (%class.subclasses sup) (nremove class (%class.subclasses sup)))))
      (setq class (%cons-built-in-class name)))
    (dolist (sup supers)
      (setf (%class.subclasses sup) (cons class (%class.subclasses sup))))
    (setf (%class.local-supers class) supers)
    (setf (%class.cpl class) (compute-cpl class))
    (setf (%class.own-wrapper class) (%cons-wrapper class (new-class-wrapper-hash-index)))
    (setf (%class.ctype class)  (make-class-ctype class))
    (setf (find-class name) class)
    (dolist (sub (%class.subclasses class))   ; Only non-nil if redefining
      ;Recompute the cpl.
      (apply #'make-built-in-class (%class.name sub) (%class.local-supers sub)))
    class))

;; This will be filled in below.  Need it defined now as it goes in the
;; instance.class-wrapper of all the classes that standard-class inherits from.
(defvar *standard-class-wrapper* 
  (%cons-wrapper 'standard-class))

(defun make-standard-clasS (name &rest supers)
  (make-class name *standard-class-wrapper* supers))

(defun make-class (name metaclass-wrapper supers &optional own-wrapper)
  (let ((class (if (find-class name nil)
                 (error "Attempt to remake standard class ~s" name)
                 (%cons-standard-class name metaclass-wrapper))))
    (if (null supers)
      (setq supers (list *standard-class-class*))
      (do ((supers supers (cdr supers))
           sup)
          ((null supers))
        (setq sup (%car supers))
        (if (symbolp sup) (setf (%car supers) (setq sup (find-class (%car supers)))))
        (unless (or (eq sup *t-class*) (std-class-p sup))
          (error "~a is not of type ~a" sup 'std-class))))
    (setf (%class.local-supers class) supers)
    (let ((cpl (compute-cpl class))
          (wrapper (if own-wrapper
                     (progn
                       (setf (%wrapper-class own-wrapper) class)
                       own-wrapper)
                     (%cons-wrapper class))))
      (setf (%class.cpl class) cpl
            (%wrapper-instance-slots wrapper) (vector)
            (%class.own-wrapper class) wrapper
            (%class.ctype class) (make-class-ctype class)
            (%class.slots class) nil
            (find-class name) class
            )
      (dolist (sup supers)
        (setf (%class.subclasses sup) (cons class (%class.subclasses sup))))
      class)))


(eval-when (:compile-toplevel :execute)
(declaim (inline standard-instance-p))
)



(defun standard-instance-p (i)
  (eq (ppc-typecode i) ppc::subtag-instance))




(defun standard-object-p (thing)
 ; returns thing's class-wrapper or nil if it isn't a standard-object
  (if (standard-instance-p thing)
    (let* ((wrapper (instance.class-wrapper thing)))
      (if (uvectorp wrapper)  ;; ???? - probably ok
        wrapper))))


(defun std-class-p (class)
  ; (typep class 'std-class)
  ; but works at bootstrapping time as well
  (let ((wrapper (standard-object-p class)))
    (and wrapper
         (or (eq wrapper *standard-class-wrapper*)
             (memq *std-class-class* (%inited-class-cpl (%wrapper-class wrapper) t))))))

(set-type-predicate 'std-class 'std-class-p)

(defun slots-class-p (class)
  (let ((wrapper (standard-object-p class)))
    (and wrapper
         (or (eq wrapper *slots-class-wrapper*)
             (memq *slots-class* (%inited-class-cpl (%wrapper-class wrapper) t))))))  

(set-type-predicate 'slots-class 'slots-class-p)

(defun specializer-p (thing)
  (memq *specializer-class* (%inited-class-cpl (class-of thing))))

(defvar *standard-object-class* (make-standard-class 'standard-object *t-class*))

(defvar *metaobject-class* (make-standard-class 'metaobject *standard-object-class*))

(defvar *specializer-class* (make-standard-class 'specializer *metaobject-class*))
(defvar *eql-specializer-class* (make-standard-class 'eql-specializer *specializer-class*))

(defvar *standard-method-combination*
  (make-instance-vector
   (%class.own-wrapper
    (make-standard-class
     'standard-method-combination
     (make-standard-class 'method-combination *metaobject-class*)))
   1))


(defun eql-specializer-p (x)
  (memq *eql-specializer-class* (%inited-class-cpl (class-of x))))

(setf (type-predicate 'eql-specializer) 'eql-specializer-p)

; The *xxx-class-class* instances get slots near the end of this file.
(defvar *class-class* (make-standard-class 'class *specializer-class*))

(defvar *slots-class* (make-standard-class 'slots-class *class-class*))
(defvar *slots-class-wrapper* (%class.own-wrapper *slots-class*))


; an implementation class that exists so that
; standard-class & funcallable-standard-class can have a common ancestor not
; shared by anybody but their subclasses.

(defvar *std-class-class* (make-standard-class 'std-class *slots-class*))

;The class of all objects whose metaclass is standard-class. Yow.
(defvar *standard-class-class* (make-standard-class 'standard-class *std-class-class*))
; Replace its wrapper and the circle is closed.
(setf (%class.own-wrapper *standard-class-class*) *standard-class-wrapper*
      (%wrapper-class *standard-class-wrapper*) *standard-class-class*
      (%wrapper-instance-slots *standard-class-wrapper*) (vector))

(defvar *built-in-class-class* (make-standard-class 'built-in-class *class-class*))
(setf *built-in-class-wrapper* (%class.own-wrapper *built-in-class-class*)
      (instance.class-wrapper *t-class*) *built-in-class-wrapper*)

(defvar *structure-class-class* (make-standard-class 'structure-class *slots-class*))
(defvar *structure-class-wrapper* (%class.own-wrapper *structure-class-class*))
(defvar *structure-object-class* 
  (make-class 'structure-object *structure-class-wrapper* (list *t-class*)))

(defvar *forward-referenced-class-class*
  (make-standard-class 'forward-referenced-class *class-class*))

;; Has to be a standard class because code currently depends on T being the
;; only non-standard class in the CPL of a standard class.
(defvar *function-class* (make-standard-class 'function *t-class*))

;Right now, all functions are compiled.


(defvar *compiled-function-class* *function-class*)
(setf (find-class 'compiled-function) *compiled-function-class*)

(defvar *interpreted-function-class*
  (make-standard-class 'interpreted-function *function-class*))

(defvar *compiled-lexical-closure-class* 
  (make-standard-class 'compiled-lexical-closure *function-class*))

(defvar *interpreted-lexical-closure-class*
  (make-standard-class 'interpreted-lexical-closure *interpreted-function-class*))

(defvar *funcallable-standard-object-class*
  (make-standard-class 'funcallable-standard-object
                       *standard-object-class* *function-class*))

(defvar *funcallable-standard-class-class*
  (make-standard-class 'funcallable-standard-class *std-class-class*))

(defvar *generic-function-class*
  (make-class 'generic-function
              (%class.own-wrapper *funcallable-standard-class-class*)
              (list *metaobject-class* *funcallable-standard-object-class*)))
(defvar *standard-generic-function-class*
  (make-class 'standard-generic-function
              (%class.own-wrapper *funcallable-standard-class-class*)
              (list *generic-function-class*)))

; *standard-method-class* is upgraded to a real class below
(defvar *method-class* (make-standard-class 'method *metaobject-class*))
(defvar *standard-method-class* (make-standard-class 'standard-method *method-class*))
(defvar *accessor-method-class* (make-standard-class 'standard-accessor-method *standard-method-class*))
(defvar *standard-reader-method-class* (make-standard-class 'standard-reader-method *accessor-method-class*))
(defvar *standard-writer-method-class* (make-standard-class 'standard-writer-method *accessor-method-class*))
(defvar *method-function-class* (make-standard-class 'method-function *function-class*))
(defvar *interpreted-method-function-class* 
  (make-standard-class 'interpreted-method-function *method-function-class* *interpreted-function-class*))

(defvar *combined-method-class* (make-standard-class 'combined-method *function-class*))

(defvar *slot-definition-class* (make-standard-class 'slot-definition *metaobject-class*))
(defvar direct-slot-definition-class (make-standard-class 'direct-slot-definition
                                                           *slot-definition-class*))
(defvar effective-slot-definition-class (make-standard-class 'effective-slot-definition
                                                              *slot-definition-class*))
(defvar *standard-slot-definition-class* (make-standard-class 'standard-slot-definition
                                                              *slot-definition-class*))
(defvar *standard-direct-slot-definition-class* (make-class
                                                 'standard-direct-slot-definition
                                                 *standard-class-wrapper*
                                                 (list
                                                  *standard-slot-definition-class*
                                                  direct-slot-definition-class)))

(defvar *standard-effective-slot-definition-class* (make-class
                                                    'standard-effective-slot-definition
                                                    *standard-class-wrapper*
                                                    (list
                                                     *standard-slot-definition-class*
                                                     effective-slot-definition-class)
))

#+ppc-target
(defppclapfunction %class-of-instance ((i arg_z))
  (svref arg_z instance.class-wrapper i)
  (svref arg_z %wrapper-class arg_z)
  (blr))

#+ppc-target
(defppclapfunction class-of ((x arg_z))
  (check-nargs 1)
  (extract-fulltag imm0 x)  ; low8bits-of from here to done
  (cmpwi cr0 imm0 ppc::fulltag-misc)
  (beq cr0 @misc)
  (clrlslwi imm0 x 24 ppc::fixnumshift)   ; clear left 24 bits, box assume = make byte index 
  (b @done)
  @misc
  (extract-subtag imm0 x)
  (box-fixnum imm0 imm0)  
  @done
  (addi imm0 imm0 ppc::misc-data-offset)
  (lwz temp1 '*class-table* nfn)
  (lwz temp1 ppc::symbol.vcell temp1)
  (lwzx temp0 temp1 imm0) ; get entry from table
  (cmpw cr0 temp0 rnil)
  (beq @bad)
  ; functionp?
  (extract-typecode imm1 temp0)
  (cmpwi imm1 ppc::subtag-function)
  (bne @ret)  ; not function - return entry
  ; else jump to the fn
  ;(lwz temp0 ppc::function.codevector temp0) ; like jump_nfn asm macro
  (mr nfn temp0)
  (lwz temp0 ppc::misc-data-offset nfn) ; get the ffing codevector
  (la loc-pc ppc::misc-data-offset temp0)
  (SET-NARGS 1) ; maybe not needed
  (mtctr loc-pc)
  (bctr)
  @bad
  (lwz fname 'no-class-error nfn)
  (ba .spjmpsym)
  @ret
  (mr arg_z temp0)  ; return frob from table
  (blr))


(defvar *standard-effective-slot-definition-class-wrapper*
  (%class.own-wrapper *standard-effective-slot-definition-class*))



(let ((*dont-find-class-optimize* t))

;; The built-in classes.
(defvar *array-class* (make-built-in-class 'array))
(defvar *character-class* (make-built-in-class 'character))
(make-built-in-class 'number)
(make-built-in-class 'sequence)
(defvar *symbol-class* (make-built-in-class 'symbol))
(defvar *immediate-class* (make-built-in-class 'immediate))   ; Random immediate
;Random uvectors - these are NOT class of all things represented by a uvector
;type. Just random uvectors which don't fit anywhere else.
(make-built-in-class 'ivector)   ; unknown ivector
(make-built-in-class 'gvector)   ; unknown gvector
(defvar *istruct-class* (make-built-in-class 'internal-structure))   ; unknown istruct

(defvar *slot-vector-class* (make-built-in-class 'slot-vector (find-class 'gvector)))

(make-built-in-class 'macptr)
(make-built-in-class 'population)
(make-built-in-class 'pool)
(make-built-in-class 'package)
(defvar *lock-class* (make-built-in-class 'lock))

(make-built-in-class 'slot-id *istruct-class*)
(make-built-in-class 'value-cell)

(make-built-in-class 'buffer-mark)
(make-built-in-class 'fred-record *istruct-class*)
(make-built-in-class 'buffer *istruct-class*)
(make-built-in-class 'comtab *istruct-class*)
(make-built-in-class 'restart *istruct-class*)
(make-built-in-class 'hash-table *istruct-class*)
(make-built-in-class 'lexical-environment *istruct-class*)
(make-built-in-class 'compiler-policy *istruct-class*)
(make-built-in-class 'readtable *istruct-class*)
(make-built-in-class 'pathname *istruct-class*)
(make-built-in-class 'random-state *istruct-class*)
(make-built-in-class 'xp-structure *istruct-class*)
(make-built-in-class 'process *istruct-class*)
(make-built-in-class 'process-queue *istruct-class*)
(make-built-in-class 'resource *istruct-class*)
(make-built-in-class 'periodic-task *istruct-class*)

(make-built-in-class 'type-class *istruct-class*)

(defvar *ctype-class* (make-built-in-class 'ctype *istruct-class*))
(make-built-in-class 'key-info *istruct-class*)
(defvar *args-ctype* (make-built-in-class 'args-ctype *ctype-class*))
(make-built-in-class 'values-ctype *args-ctype*)
(make-built-in-class 'function-ctype *args-ctype*)
(make-built-in-class 'constant-ctype *ctype-class*)
(make-built-in-class 'named-ctype *ctype-class*)
(make-built-in-class 'cons-ctype *ctype-class*)
(make-built-in-class 'unknown-ctype (make-built-in-class 'hairy-ctype *ctype-class*))
(make-built-in-class 'numeric-ctype *ctype-class*)
(make-built-in-class 'array-ctype *ctype-class*)
(make-built-in-class 'member-ctype *ctype-class*)
(make-built-in-class 'union-ctype *ctype-class*)
(make-built-in-class 'foreign-ctype *ctype-class*)
(make-built-in-class 'class-ctype *ctype-class*)
(make-built-in-class 'negation-ctype *ctype-class*)
(make-built-in-class 'intersection-ctype *ctype-class*)


(make-built-in-class 'complex (find-class 'number))
(make-built-in-class 'real (find-class 'number))
(defvar *float-class* (make-built-in-class 'float (find-class 'real)))
(defvar *double-float-class* (make-built-in-class 'double-float (find-class 'float)))
(defvar *single-float-class*  (make-built-in-class 'single-float (find-class 'float)))
(setf (find-class 'short-float) *single-float-class*)
(setf (find-class 'long-float) *double-float-class*)

(make-built-in-class 'rational (find-class 'real))
(make-built-in-class 'ratio (find-class 'rational))
(make-built-in-class 'integer (find-class 'rational))
(defvar *fixnum-class* (make-built-in-class 'fixnum (find-class 'integer)))
(make-built-in-class 'bignum (find-class 'integer))

(make-built-in-class 'bit *fixnum-class*)
(make-built-in-class 'unsigned-byte (find-class 'integer))
(make-built-In-class 'signed-byte (find-class 'integer))

(make-built-in-class 'logical-pathname (find-class 'pathname))

(defvar *base-character-class* (make-built-in-class 'base-character *character-class*))
(setf (find-class 'base-char) *base-character-class*)
(defvar *extended-character-class* (make-built-in-class 'extended-character *character-class*))
(setf (find-class 'extended-char) *extended-character-class*)

(defvar *standard-char-class* (make-built-in-class 'standard-char (find-class 'base-char)))


(defvar *keyword-class* (make-built-in-class 'keyword *symbol-class*))

(make-built-in-class 'list (find-class 'sequence))
(defvar *cons-class* (make-built-in-class 'cons (find-class 'list)))
(defvar *null-class* (make-built-in-class 'null *symbol-class* (find-class 'list)))

(make-built-in-class 'svar)
(defvar *vector-class* (make-built-in-class 'vector *array-class* (find-class 'sequence)))
(defvar *simple-array-class* (make-built-in-class 'simple-array *array-class*))
(make-built-in-class 'simple-1d-array *vector-class* *simple-array-class*)

;Maybe should do *float-array-class* etc?
;Also, should straighten out the simple-n-dim-array mess...
(make-built-in-class 'unsigned-byte-vector *vector-class*)
(make-built-in-class 'simple-unsigned-byte-vector (find-class 'unsigned-byte-vector) (find-class 'simple-1d-array))
(make-built-in-class 'unsigned-word-vector *vector-class*)
(make-built-in-class 'simple-unsigned-word-vector (find-class 'unsigned-word-vector) (find-class 'simple-1d-array))


(progn
  (make-built-in-class 'double-float-vector *vector-class*)
  (make-built-in-class 'short-float-vector *vector-class*)
  (setf (find-class 'long-float-vector) (find-class 'double-float-vector))
  (setf (find-class 'single-float-vector) (find-class 'short-float-vector))
  (make-built-in-class 'simple-double-float-vector (find-class 'double-float-vector) (find-class 'simple-1d-array))
  (make-built-in-class 'simple-short-float-vector (find-class 'short-float-vector) (find-class 'simple-1d-array))
  (setf (find-class 'simple-long-float-vector) (find-class 'simple-double-float-vector))
  (setf (find-class 'simple-single-float-vector) (find-class 'simple-short-float-vector))
)
  
(make-built-in-class 'long-vector *vector-class*)
(make-built-in-class 'simple-long-vector (find-class 'long-vector) (find-class 'simple-1d-array))
(make-built-in-class 'unsigned-long-vector *vector-class*)
(make-built-in-class 'simple-unsigned-long-vector (find-class 'unsigned-long-vector) (find-class 'simple-1d-array))
(make-built-in-class 'byte-vector *vector-class*)
(make-built-in-class 'simple-byte-vector (find-class 'byte-vector) (find-class 'simple-1d-array))
(make-built-in-class 'bit-vector *vector-class*)
(make-built-in-class 'simple-bit-vector (find-class 'bit-vector) (find-class 'simple-1d-array))
(make-built-in-class 'word-vector *vector-class*)
(make-built-in-class 'simple-word-vector (find-class 'word-vector) (find-class 'simple-1d-array))
(make-built-in-class 'string *vector-class*)
(make-built-in-class 'extended-string (find-class 'string))
(make-built-in-class 'base-string (find-class 'string))
(make-built-in-class 'simple-string (find-class 'string) (find-class 'simple-1d-array))
(make-built-in-class 'simple-base-string (find-class 'base-string) (find-class 'simple-string))
(make-built-in-class 'simple-extended-string (find-class 'extended-string)(find-class 'simple-string))
(make-built-in-class 'general-vector *vector-class*)
(make-built-in-class 'simple-vector (find-class 'general-vector) (find-class 'simple-1d-array))


(defvar *stack-group-class* (make-built-in-class 'stack-group *function-class*))








(make-built-in-class 'hash-table-vector)
(make-built-in-class 'catch-frame)
(make-built-in-class 'code-vector)
(make-built-in-class 'creole-object)


(defun class-cell-find-class (class-cell errorp)
  (unless (listp class-cell)
    (setq class-cell (%kernel-restart $xwrongtype class-cell 'list)))
  (locally (declare (type list class-cell))
    (let ((class (cdr class-cell)))
      (or class
          (and 
           (setq class (find-class (car class-cell) nil))
           (when class 
             (rplacd class-cell class)
             class))
          ;(if errorp (dbg-paws (format nil "Class ~s not found." (car class-cell))))))))
          (if errorp (error "Class ~s not found." (car class-cell)) nil)))))
  




; (%wrapper-class (instance.class-wrapper frob))



(defvar *general-vector-class* (find-class 'general-vector))

(defvar *ivector-vector-classes*
  (vector (find-class 'short-float-vector)
          (find-class 'unsigned-long-vector)
          (find-class 'long-vector)
          (find-class 'unsigned-byte-vector)
          (find-class 'byte-vector)
          (find-class 'base-string)
          (find-class 'extended-string)
          (find-class 'unsigned-word-vector)
          (find-class 'word-vector)
          (find-class 'double-float-vector)
          (find-class 'bit-vector)))



(defparameter *class-table*
  (let* ((v (make-array 256 :initial-element nil)))
    ; Make one loop through the vector, initializing fixnum & list cells
    ; Set all things of ppc::fulltag-imm to *immediate-class*, then special-case
    ; characters later.
    (do* ((slice 0 (+ 8 slice)))
         ((= slice 256))
      (declare (type (unsigned-byte 8) slice))
      (setf (%svref v (+ slice ppc::fulltag-even-fixnum)) *fixnum-class*
            (%svref v (+ slice ppc::fulltag-odd-fixnum))  *fixnum-class*
            (%svref v (+ slice ppc::fulltag-cons)) *cons-class*
            (%svref v (+ slice ppc::fulltag-nil)) *null-class*
            (%svref v (+ slice ppc::fulltag-imm)) *immediate-class*))
    (macrolet ((map-subtag (subtag class-name)
               `(setf (%svref v ,subtag) (find-class ',class-name))))
      ; immheader types map to built-in classes.
      (map-subtag ppc::subtag-bignum bignum)
      (map-subtag ppc::subtag-double-float double-float)
      (map-subtag ppc::subtag-single-float short-float)
      (map-subtag ppc::subtag-macptr macptr)
      (map-subtag ppc::subtag-dead-macptr ivector)
      (map-subtag ppc::subtag-code-vector code-vector)
      (map-subtag ppc::subtag-creole-object creole-object)
      (map-subtag ppc::subtag-single-float-vector simple-short-float-vector)
      (map-subtag ppc::subtag-u32-vector simple-unsigned-long-vector)
      (map-subtag ppc::subtag-s32-vector simple-long-vector)
      (map-subtag ppc::subtag-u8-vector simple-unsigned-byte-vector)
      (map-subtag ppc::subtag-s8-vector simple-byte-vector)
      (map-subtag ppc::subtag-simple-base-string simple-base-string)
      (map-subtag ppc::subtag-simple-general-string simple-extended-string)
      (map-subtag ppc::subtag-u16-vector simple-unsigned-word-vector)
      (map-subtag ppc::subtag-s16-vector simple-word-vector)
      (map-subtag ppc::subtag-double-float-vector simple-double-float-vector)
      (map-subtag ppc::subtag-bit-vector simple-bit-vector)
      ; Some nodeheader types map to built-in-classes; others
      ; require further dispatching.
      (map-subtag ppc::subtag-ratio ratio)
      (map-subtag ppc::subtag-complex complex)
      (map-subtag ppc::subtag-catch-frame catch-frame)
      (map-subtag ppc::subtag-mark buffer-mark)
      (map-subtag ppc::subtag-hash-vector hash-table-vector)
      (map-subtag ppc::subtag-value-cell value-cell)
      (map-subtag ppc::subtag-pool pool)
      (map-subtag ppc::subtag-weak population)
      (map-subtag ppc::subtag-package package)
      (map-subtag ppc::subtag-simple-vector simple-vector)
      (map-subtag ppc::subtag-slot-vector slot-vector)
      (map-subtag ppc::subtag-lock lock))
    (setf (%svref v ppc::subtag-arrayH) *array-class*)
    ; These need to be special-cased:
    (setf (%svref v ppc::subtag-character)
          #'(lambda (c) (if (typep c 'base-character)                          
                          (let* ((code (%char-code c)))
                            (if (or (= code 13)   ;(char-eolp c)
                                    (and (>= code (char-code #\space))
                                         (< code (char-code #\rubout))))
                              *standard-char-class*
                              *base-character-class*))
                          *extended-character-class*)))
    (setf (%svref v ppc::subtag-struct)
          #'(lambda (s) (%structure-class-of s)))       ; need DEFSTRUCT
    (setf (%svref v ppc::subtag-istruct)
          #'(lambda (i) (or (find-class (%svref i 0) nil) *istruct-class*)))
    (setf (%svref v ppc::subtag-instance)
          #'%class-of-instance) ; #'(lambda (i) (%wrapper-class (instance.class-wrapper i))))
    (setf (%svref v ppc::subtag-symbol)
          #'(lambda (s) (if (eq (symbol-package s) *keyword-package*)
                          *keyword-class*
                          *symbol-class*)))
    (setf (%svref v ppc::subtag-function)
          #'(lambda (thing)
              (let ((bits (lfun-bits thing)))
                (declare (fixnum bits))
                (if (logbitp $lfbits-trampoline-bit bits)
                  ; stack-group or closure
                  (if (stack-group-p thing)
                    *stack-group-class*
                    (if (logbitp $lfbits-evaluated-bit bits)
                      *interpreted-lexical-closure-class*
                      (let ((inner-fn (closure-function thing)))
                        (if (neq inner-fn thing)
                          (let ((inner-bits (lfun-bits inner-fn)))
                            (if (logbitp $lfbits-method-bit inner-bits)
                              *compiled-lexical-closure-class*
                              (if (logbitp $lfbits-gfn-bit inner-bits)
				(%wrapper-class (instance.class-wrapper thing))
                                (if (logbitp $lfbits-cm-bit inner-bits)
                                  *combined-method-class*
                                  *compiled-lexical-closure-class*))))
                          *compiled-lexical-closure-class*))))
                  (if (logbitp $lfbits-evaluated-bit bits)
                    (if (logbitp $lfbits-method-bit bits)
                      *interpreted-method-function-class*
                      *interpreted-function-class*)
                    (if (logbitp  $lfbits-method-bit bits)
                      *method-function-class* 
                      (if (logbitp $lfbits-gfn-bit bits)
			(%wrapper-class (gf.instance.class-wrapper thing))
                        (if (logbitp $lfbits-cm-bit bits)
                          *combined-method-class*
                          *compiled-function-class*))))))))
    (setf (%svref v ppc::subtag-vectorH)
          #'(lambda (v)
              (let* ((subtype (%array-header-subtype v)))
                (declare (fixnum subtype))
                (if (eql subtype ppc::subtag-simple-vector)
                  *general-vector-class*
                  (%svref *ivector-vector-classes*
                          (ash (the fixnum (- subtype ppc::min-cl-ivector-subtag))
                               (- ppc::ntagbits)))))))

    v))





(defun no-class-error (x)
  (error "Bug (probably): can't determine class of ~s" x))
  

  ; return frob from table




) ; end let


; Can't use typep at bootstrapping time.
(defun classp (x)
  (let ((wrapper (standard-object-p x)))
    (and wrapper
         (let ((super (%wrapper-class wrapper)))
           (memq *class-class* (%inited-class-cpl super t))))))

(set-type-predicate 'class 'classp)

(defun subclassp (c1 c2)
  (and (classp c1)
       (classp c2)
       (not (null (memq c2 (%inited-class-cpl c1 t))))))

(defun %class-get (class indicator &optional default)
  (if (typep class 'std-class)
    (let ((cell (assq indicator (%class.alist class))))
      (if cell (cdr cell) default))
    default))
(defun %class-put (class indicator value)
  (let ((cell (assq indicator (%class.alist class))))
    (if cell
      (setf (cdr cell) value)
      (push (cons indicator value) (%class.alist class))))
  value)
  
(defsetf %class-get %class-put)
(defun %class-remprop (class indicator)
  (let* ((handle (cons nil (%class.alist class)))
         (last handle))
    (declare (dynamic-extent handle))
    (while (cdr last)
      (if (eq indicator (caar (%cdr last)))
        (progn
          (setf (%cdr last) (%cddr last))
          (setf (%class.alist class) (%cdr handle)))
        (setf last (%cdr last))))))    


(pushnew :primary-classes *features*)

(defun %class-primary-p (class)
  (if (typep class 'std-class)
    (%class-get class :primary-p)
    t))

(defun (setf %class-primary-p) (value class)
  (if value
    (setf (%class-get class :primary-p) value)
    (progn
      (%class-remprop class :primary-p)
      nil)))

; Returns the first element of the CPL that is primary
(defun %class-or-superclass-primary-p (class)
  (unless (class-has-a-forward-referenced-superclass-p class)
    (dolist (super (%inited-class-cpl class t))
      (when (and (typep super 'standard-class) (%class-primary-p super))
	(return super)))))


; Bootstrapping version of union
(unless (fboundp 'union)
(defun union (l1 l2)
  (dolist (e l1)
    (unless (memq e l2)
      (push e l2)))
  l2)
)

;; Stub to prevent errors when the user doesn't define types
(defun type-intersect (type1 type2)
  (cond ((and (null type1) (null type2))
         nil)
        ((equal type1 type2)
         type1)
        ((subtypep type1 type2)
         type1)
        ((subtypep type2 type1)
         type2)
        (t `(and ,type1 ,type2))
        ;(t (error "type-intersect not implemented yet."))
        ))

(defun %add-direct-methods (method)
  (dolist (spec (%method-specializers method))
    (%do-add-direct-method spec method)))

(defun %do-add-direct-method (spec method)
  (pushnew method (specializer.direct-methods spec)))

(defun %remove-direct-methods (method)
  (dolist (spec (%method-specializers method))
    (%do-remove-direct-method spec method)))

(defun %do-remove-direct-method (spec method)
  (setf (specializer.direct-methods spec)
	(nremove method (specializer.direct-methods spec))))

(defun canonicalize-eql-specializer (spec)
  (if (and (consp spec)
           (eq (%car spec) 'eql)
           (consp (%cdr spec))
           (null (%cddr spec)))
    (intern-eql-specializer (cadr spec))
    spec))

(defmethod find-method ((generic-function standard-generic-function)
                        method-qualifiers specializers &optional (errorp t))
  (dolist (m (%gf-methods generic-function)
	   (if errorp
	     (error "~s has no method for ~s ~s"
		    generic-function method-qualifiers specializers)))
    (flet ((err ()
	     (error "Wrong number of specializers: ~s" specializers)))
      (let ((ss (%method-specializers m))
	    (q (%method-qualifiers m))
	    s)
	(when (equal q method-qualifiers)
	  (dolist (spec specializers
		   (if (null ss)
		     (return-from find-method m)
		     (err)))
	    (unless (setq s (pop ss))
	      (err))
	    (unless (eq s (canonicalize-eql-specializer spec))
	      (return))))))))

#|
(defmethod create-reader-method-function ((class std-class)
					  (reader-method-class standard-reader-method)
					  (dslotd standard-direct-slot-definition))
  (gvector :function
           (uvref *reader-method-function-proto* 0)
           (ensure-slot-id (%slot-definition-name dslotd))
           'slot-id-value
           nil				;method-function name
           (dpb 1 $lfbits-numreq (ash 1 $lfbits-method-bit))))
|#



;; slightly faster

#|
(defmethod create-reader-method-function ((class std-class)
					  (reader-method-class standard-reader-method)
					  (dslotd standard-direct-slot-definition))
  (gvector :function
           (uvref *reader-method-function-proto* 0)
           (ensure-slot-id (%slot-definition-name dslotd))  
           '%slot-id-ref-obsolete
           'slot-unbound
           '%slot-id-ref-missing
           nil				;method-function name
           (dpb 1 $lfbits-numreq (ash 1 $lfbits-method-bit))))
|#

(defmethod create-reader-method-function ((class std-class)
					  (reader-method-class standard-reader-method)
					  (dslotd standard-direct-slot-definition))
  (gvector :function
           (uvref *reader-method-function-proto5* 0)
           (cons nil nil)  ;; compiler order is weird
           (ensure-slot-id (%slot-definition-name dslotd))
           '%slot-id-ref-obsolete
           'slot-unbound
           '%slot-id-ref-missing
           nil				;method-function name
           (dpb 1 $lfbits-numreq (ash 1 $lfbits-method-bit))))


;;with slotd test
#|
(defmethod create-reader-method-function ((class std-class)
					  (reader-method-class standard-reader-method)
					  (dslotd standard-direct-slot-definition))
  (gvector :function
           (uvref *reader-method-function-proto4* 0)
           (ensure-slot-id (%slot-definition-name dslotd))  
           '%slot-id-ref-obsolete
           '*standard-effective-slot-definition-class-wrapper*
           'slot-unbound
           'slot-value-using-class
           '%slot-id-ref-missing
           nil				;method-function name
           (dpb 1 $lfbits-numreq (ash 1 $lfbits-method-bit))))
|#





#|
(defmethod create-writer-method-function ((class std-class)
					  (writer-method-class standard-writer-method)
					  (dslotd standard-direct-slot-definition))
  (gvector :function
           (uvref *writer-method-function-proto* 0)
           (ensure-slot-id (%slot-definition-name dslotd))
           '%slot-id-set-obsolete
           'require-type
           '%slot-id-set-missing
           nil				;method-function name
           (dpb 2 $lfbits-numreq (ash 1 $lfbits-method-bit))))
|#




(defmethod create-writer-method-function ((class std-class)
					  (writer-method-class standard-writer-method)
					  (dslotd standard-direct-slot-definition))
  (gvector :function
           (uvref *writer-method-function-proto5* 0)
           (cons nil nil)  ;; compiler order is weird
           (ensure-slot-id (%slot-definition-name dslotd))
           '%slot-id-set-obsolete
           'require-type
           '%slot-id-set-missing
           nil				;method-function name
           (dpb 2 $lfbits-numreq (ash 1 $lfbits-method-bit))))






(defun %make-instance (class-cell &rest initargs)
  (declare (dynamic-extent initargs))
  (apply #'make-instance
         (or (cdr class-cell) (car (the list class-cell)))
         initargs))


(defmethod make-instance ((class symbol) &rest initargs)
  (declare (dynamic-extent initargs))
  (apply 'make-instance (find-class class) initargs))


(defmethod make-instance ((class standard-class) &rest initargs &key &allow-other-keys)
  (declare (dynamic-extent initargs))
  (%make-std-instance class initargs))

(defmethod make-instance ((class std-class) &rest initargs &key &allow-other-keys)
  (declare (dynamic-extent initargs))
  (%make-std-instance class initargs))


(defun %make-std-instance (class initargs)
  (setq initargs (default-initargs class initargs))
  (when initargs
    (apply #'check-initargs
           nil class initargs t
           #'initialize-instance #'allocate-instance #'shared-initialize
           nil))
  (let ((instance (apply #'allocate-instance class initargs)))
    (apply #'initialize-instance instance initargs)
    instance))

(defun default-initargs (class initargs)
  (unless (std-class-p class)
    (setq class (require-type class 'std-class)))
  (when (null (%class.cpl class)) (update-class class t))
  (let ((defaults ()))
    (dolist (key.form (%class-default-initargs class))
      (unless (pl-search initargs (%car key.form))
        (setq defaults
              (list* (funcall (caddr key.form))
                     (%car key.form)
                     defaults))))
    (when defaults
      (setq initargs (append initargs (nreverse defaults))))
    initargs))


(defun %allocate-std-instance (class)
  (unless (class-finalized-p class)
    (finalize-inheritance class))
  (let* ((wrapper (%class.own-wrapper class))
         (len (length (%wrapper-instance-slots wrapper))))
    (declare (fixnum len))
    (make-instance-vector wrapper len)))



(defmethod copy-instance ((instance standard-object))
  (let* ((new-slots (copy-uvector (instance.slots instance)))
	 (copy (gvector :instance 0 (instance.class-wrapper instance) new-slots)))
    (setf (instance.hash copy) (strip-tag-to-fixnum copy)
	  (slot-vector.instance new-slots) copy)))

(defmethod initialize-instance ((instance standard-object) &rest initargs)
  (declare (dynamic-extent initargs))
  (apply 'shared-initialize instance t initargs))


(defmethod reinitialize-instance ((instance standard-object) &rest initargs)
  (declare (dynamic-extent initargs))
  (when initargs
    (check-initargs 
     instance nil initargs t #'reinitialize-instance #'shared-initialize))
  (apply 'shared-initialize instance nil initargs))

(defmethod shared-initialize ((instance standard-object) slot-names &rest initargs)
  (declare (dynamic-extent initargs))
  (%shared-initialize instance slot-names initargs))

(defmethod shared-initialize ((instance standard-generic-function) slot-names
                              &rest initargs)
  (declare (dynamic-extent initargs))
  (%shared-initialize instance slot-names initargs))

;;; Slot-value, slot-boundp, slot-makunbound, etc.
#|
(declaim (inline find-slotd))
(defun find-slotd (name slots)
  (find name slots :key #'%slot-definition-name))
|#

;; um this is faster x 2
(defun find-slotd (name slots)
  (if (listp slots)   ; is most likely (always?)
    (dolist (x slots)
      (when (eq name (%slot-definition-name x))
        (return x)))
    (dovector (x slots)
      (when (eq name (%slot-definition-name x))
        (return x)))))

(defun %std-slot-value-using-class (instance slotd)
  (let* ((loc (standard-effective-slot-definition.location slotd)))
    (typecase loc
      (fixnum
       (standard-instance-instance-location-access instance loc))
      (cons
       (let* ((val (%cdr loc)))
	 (if (eq val (%slot-unbound-marker))
	   (slot-unbound (class-of instance) instance (standard-effective-slot-definition.name slotd))
	   val)))
      (t
       (error "Slot definition ~s has invalid location ~s (allocation ~s)."
	      slotd loc (slot-definition-allocation slotd))))))

#|
(defmethod slot-value-using-class ((class standard-class) 
                                   instance 
                                   (slotd standard-effective-slot-definition))
  (%std-slot-value-using-class instance slotd))
|#

(defmethod slot-value-using-class ((class standard-class)
				   instance
				   (slotd standard-effective-slot-definition))
  (ecase (standard-slot-definition.allocation slotd)
    ((:instance :class)
     (%std-slot-value-using-class instance slotd))))


(defun %maybe-std-slot-value-using-class (class instance slotd)
  (if (and (eql (ppc-typecode class) ppc::subtag-instance)
	   (eql (ppc-typecode slotd) ppc::subtag-instance)
	   (eq *standard-effective-slot-definition-class-wrapper*
	       (instance.class-wrapper slotd))
	   (eq *standard-class-wrapper* (instance.class-wrapper class)))
    (%std-slot-value-using-class instance slotd)
    (slot-value-using-class class instance slotd)))

  

(defun %std-setf-slot-value-using-class (instance slotd new)
  (let* ((loc (standard-effective-slot-definition.location slotd))
         (type (standard-effective-slot-definition.type slotd)))
    (unless (or (eq new (%slot-unbound-marker))
                (eq type t)
		(funcall (standard-effective-slot-definition.type-predicate slotd) new))
        (setq new (require-type new type)))
    (typecase loc
      (fixnum
       (setf 
	(standard-instance-instance-location-access instance loc) new))
      (cons
       (setf (%cdr loc) new))
      (t
       (error "Slot definition ~s has invalid location ~s (allocation ~s)."
	      slotd loc (slot-definition-allocation slotd))))))

#|  
(defmethod (setf slot-value-using-class) (new 
                                          (class standard-class)
                                          instance
                                          (slotd standard-effective-slot-definition))
  (%std-setf-slot-value-using-class instance slotd new))
|#

(defmethod (setf slot-value-using-class) (new
                                          (class standard-class)
                                          instance
                                          (slotd standard-effective-slot-definition))
  (ecase (standard-slot-definition.allocation slotd)
    ((:instance :class)
      (%std-setf-slot-value-using-class instance slotd new))))


(defun %maybe-std-setf-slot-value-using-class (class instance slotd new)
  (if (and (eql (ppc-typecode class) ppc::subtag-instance)
	   (eql (ppc-typecode slotd) ppc::subtag-instance)
	   (eq *standard-effective-slot-definition-class-wrapper*
	       (instance.class-wrapper slotd))
	   (eq *standard-class-wrapper* (instance.class-wrapper class)))
    (%std-setf-slot-value-using-class instance slotd new)
    (setf (slot-value-using-class class instance slotd) new)))

(defmethod slot-value-using-class ((class funcallable-standard-class)
				   instance
				   (slotd standard-effective-slot-definition))
  (let* ((loc (standard-effective-slot-definition.location slotd)))
      (typecase loc
	(fixnum
	 (standard-generic-function-instance-location-access instance loc))
	(cons
	 (let* ((val (%cdr loc)))
	   (if (eq val (%slot-unbound-marker))
	     (slot-unbound class instance (standard-effective-slot-definition.name slotd))
	     val)))
	(t
	 (error "Slot definition ~s has invalid location ~s (allocation ~s)."
		slotd loc (slot-definition-allocation slotd))))))

(defmethod (setf slot-value-using-class) (new
                                          (class funcallable-standard-class)
                                          instance
                                          (slotd standard-effective-slot-definition))
  (let* ((loc (standard-effective-slot-definition.location slotd))
         (type (standard-effective-slot-definition.type slotd)))
    (if (and type (not (eq type t)))
      (unless (or (eq new (%slot-unbound-marker)) (typep new type))
        (setq new (require-type new type))))
    (typecase loc
      (fixnum
       (setf 
        (standard-generic-function-instance-location-access instance loc) new))
      (cons
       (setf (%cdr loc) new))
      (t
       (error "Slot definition ~s has invalid location ~s (allocation ~s)."
              slotd loc (slot-definition-allocation slotd))))))

(defun slot-value (instance slot-name)
  (slot-id-value instance (ensure-slot-id slot-name)))


#|
(defun slot-value (instance slot-name)
  (let* ((class (class-of instance))
	   (slotd (find-slotd slot-name (%class-slots class))))
      (if slotd
	(slot-value-using-class class instance slotd)
	(slot-missing class instance slot-name 'slot-value))))
|#



(defmethod slot-unbound (class instance slot-name)
  (declare (ignore class))
  (error 'unbound-slot :name slot-name :instance instance))



(defmethod slot-makunbound-using-class ((class slots-class)
					instance
					(slotd standard-effective-slot-definition))
  (setf (slot-value-using-class class instance slotd) (%slot-unbound-marker))
  instance)

(defmethod slot-missing (class object slot-name operation &optional new-value)
  (declare (ignore class operation new-value))
  (error "~s has no slot named ~s." object slot-name))


(defun set-class-slot-value (class slot-name new)
  (let* ((slotd (find-slotd slot-name (%class-slots class))))
    (if slotd
      (let* ((loc (%slot-definition-location slotd)))
	(if (consp loc)
	  (rplacd loc new)
	  (error "Slot ~s is not a class slot in class ~s" slot-name class)))
      ;; This isn't exactly a SLOT-MISSING error, is it ?
      (slot-missing class class slot-name 'set-class-slot-value new))))

(defun set-slot-value (instance name value)
  (set-slot-id-value instance (ensure-slot-id name) value))

#|
(defun set-slot-value (instance name value)
  (let* ((class (class-of instance))
         (slotd (find-slotd  name (%class-slots class))))
    (if slotd
      (setf (slot-value-using-class class instance slotd) value)
      (progn (slot-missing class instance name '(setf slot-value) value)
             value))))
|#

(defsetf slot-value set-slot-value)

(defun slot-makunbound (instance name)
  (let* ((class (class-of instance))
         (slotd (find-slotd name (%class-slots class))))
    (if slotd
      (slot-makunbound-using-class class instance slotd)
      (slot-missing class instance name 'slot-makunbound))
    instance))


#|
(defmethod slot-boundp-using-class ((class standard-class)
				    instance
				    (slotd standard-effective-slot-definition))
  (if (eql 0 (%wrapper-instance-slots (instance.class-wrapper instance)))
    (progn
      (update-obsolete-instance instance)
      (slot-boundp instance (standard-effective-slot-definition.name slotd)))
    (let* ((loc (standard-effective-slot-definition.location slotd)))
      (typecase loc
	(fixnum
	 (not (eq (%standard-instance-instance-location-access instance loc)
		  (%slot-unbound-marker))))
	(cons
	 (not (eq (%cdr loc) (%slot-unbound-marker))))
	(t
	 (error "Slot definition ~s has invalid location ~s (allocation ~s)."
		slotd loc (slot-definition-allocation slotd)))))))
|#

(defmethod slot-boundp-using-class ((class standard-class)
				    instance
				    (slotd standard-effective-slot-definition))
  (ecase (standard-slot-definition.allocation slotd)
    ((:instance :class)
     (if (eql 0 (%wrapper-instance-slots (instance.class-wrapper instance)))
       (progn
         (update-obsolete-instance instance)
         (slot-boundp instance (standard-effective-slot-definition.name slotd)))
       (let* ((loc (standard-effective-slot-definition.location slotd)))
         (typecase loc
	   (fixnum
	    (not (eq (%standard-instance-instance-location-access instance loc)
		     (%slot-unbound-marker))))
	   (cons
	    (not (eq (%cdr loc) (%slot-unbound-marker))))
	   (t
	    (error "Slot definition ~s has invalid location ~s (allocation ~s)."
		   slotd loc (slot-definition-allocation slotd)))))))))

(defmethod slot-boundp-using-class ((class funcallable-standard-class)
				    instance
				    (slotd standard-effective-slot-definition))
  (if (eql 0 (%wrapper-instance-slots (gf.instance.class-wrapper instance)))
    (progn
      (update-obsolete-instance instance)
      (slot-boundp instance (standard-effective-slot-definition.name slotd)))
    (let* ((loc (standard-effective-slot-definition.location slotd)))
      (typecase loc
	(fixnum
	 (not (eq (%standard-generic-function-instance-location-access instance loc)
		  (%slot-unbound-marker))))
	(cons
	 (not (eq (%cdr loc) (%slot-unbound-marker))))
	(t
	 (error "Slot definition ~s has invalid location ~s (allocation ~s)."
		slotd loc (slot-definition-allocation slotd)))))))



(defun slot-boundp (instance name)
  (let* ((class (class-of instance))
	 (slotd (find-slotd name (%class-slots class))))
    (if slotd
      (slot-boundp-using-class class instance slotd)
      (values (slot-missing class instance name 'slot-boundp)))))

(defun slot-value-if-bound (instance name &optional default)
  (if (slot-boundp instance name)
    (slot-value instance name)
    default))

(defun slot-exists-p (instance name)
  (let* ((class (class-of instance))
	 (slots  (class-slots class)))
    (find-slotd name slots)))

#|
(defun slot-id-value (instance slot-id)
  (let* ((wrapper (if (eq (ppc-typecode instance) ppc::subtag-instance)
                    (instance.class-wrapper instance)
                    (%class.own-wrapper (class-of instance)))))
    (funcall (%wrapper-slot-id-value wrapper) instance slot-id)))
|#
;; for my info: %wrapper-class-slots are just class slots specific to this class - inherited class slots not included


;; with type test of slotd
(defun slot-id-value (instance slot-id)
  (cond 
   ((eq (ppc-typecode instance) ppc::subtag-instance)
    (let* ((wrapper (instance.class-wrapper instance)))
      (if (%standard-wrapper-test wrapper)
        (if (eq 0 (%wrapper-instance-slots wrapper))
          (progn                
            (update-obsolete-instance instance)
            (slot-id-value instance slot-id))
          (let* ((slotd (slot-id->slotd slot-id wrapper )))
            (if slotd
              (if (%standard-slotd-test slotd)
                (let* ((loc (standard-effective-slot-definition.location slotd))
                       (val (if (fixnump loc)
                              (%svref  (instance.slots instance) loc)
                              (%cdr loc))))                    
                  (if (eq val (%slot-unbound-marker))
                    (slot-unbound (%wrapper-class wrapper) instance (slot-id.name slot-id))
                    val))
                (slot-value-using-class (%wrapper-class wrapper) instance slotd))
              (%slot-id-ref-missing instance slot-id))))
        (funcall (%wrapper-slot-id-value wrapper) instance slot-id))))
   (t (let ((wrapper (%class.own-wrapper (class-of instance))))
        (funcall (%wrapper-slot-id-value wrapper) instance slot-id)))))



#|
(defun set-slot-id-value (instance slot-id value)
  (let* ((wrapper (if (eq (ppc-typecode instance) ppc::subtag-instance)
                    (instance.class-wrapper instance)
                    (%class.own-wrapper (class-of instance)))))
    (funcall (%wrapper-set-slot-id-value wrapper) instance slot-id value)))
|#



(defun set-slot-id-value (instance slot-id value)  
  (cond
   ((eq (ppc-typecode instance) ppc::subtag-instance)
    (let* ((wrapper (instance.class-wrapper instance)))
      (if (%standard-wrapper-test wrapper)
        (if (eq 0 (%wrapper-instance-slots wrapper))
          (progn
            (update-obsolete-instance instance)
            (set-slot-id-value instance slot-id value))
          (let ((slotd (slot-id->slotd slot-id wrapper)))  
            (if slotd
              (if (%standard-slotd-test slotd)
                (progn
                  (when (neq value (%slot-unbound-marker))
                    (let ((type (standard-effective-slot-definition.type slotd)))
                      (unless (or (eq type t) (funcall (standard-effective-slot-definition.type-predicate slotd) value))
                        (setq value  (require-type value type)))))
                  (let ((loc (standard-effective-slot-definition.location slotd)))
                    (if (fixnump loc)
                      (%svset (instance.slots instance) loc value)
                      (setf (%cdr loc) value))))
                (setf (slot-value-using-class (%wrapper-class wrapper) instance slotd) value))
              (progn (%slot-id-set-missing instance slot-id  value)
                     value))))
        (funcall (%wrapper-set-slot-id-value wrapper) instance slot-id value))))
   (t 
    (let* ((wrapper (%class.own-wrapper (class-of instance))))
      (funcall (%wrapper-set-slot-id-value wrapper) instance slot-id value)))))


; returns nil if (apply gf args) wil cause an error because of the
; non-existance of a method (or if GF is not a generic function or the name
; of a generic function).
(defun method-exists-p (gf &rest args)
  (declare (dynamic-extent args))
  (when (symbolp gf)
    (setq gf (fboundp gf)))
  (when (typep gf 'standard-generic-function)
    (or (null args)
        (let* ((methods (sgf.methods gf)))
          (dolist (m methods)
            (when (null (%method-qualifiers m))
              (let ((specializers (%method-specializers m))
                    (args args))
                (when (dolist (s specializers t)
                        (unless (cond ((typep s 'eql-specializer) 
                                       (eql (eql-specializer-object s) (car args)))
                                      (t (memq s (%inited-class-cpl
                                                  (class-of (car args))))))
                          (return nil))
                        (pop args))
                  (return-from method-exists-p m)))))
          nil))))

(defun funcall-if-method-exists (gf &optional default &rest args)
  (declare (dynamic-extent args))
  (if (apply #'method-exists-p gf args)
    (apply gf args)
    (if default (apply default args))))


(defun find-specializer (specializer)
  (if (and (listp specializer) (eql (car specializer) 'eql))
    (intern-eql-specializer (cadr specializer))
    (find-class specializer)))

(defmethod make-instances-obsolete ((class symbol))
  (make-instances-obsolete (find-class class)))

(defmethod make-instances-obsolete ((class standard-class))
  (let ((wrapper (%class.own-wrapper class)))
    (when wrapper
      (setf (%class.own-wrapper class) nil)
      (make-wrapper-obsolete wrapper))))

(defmethod make-instances-obsolete ((class funcallable-standard-class))
  (let ((wrapper (%class.own-wrapper class)))
    (when wrapper
      (setf (%class.own-wrapper class) nil)
      (make-wrapper-obsolete wrapper))))

(defmethod make-instances-obsolete ((class structure-class)))



; A wrapper is made obsolete by setting the hash-index & instance-slots to 0
; The instance slots are saved for update-obsolete-instance
; by consing them onto the class slots.
; Method dispatch looks at the hash-index.
; slot-value & set-slot-value look at the instance-slots.
; Each wrapper may have an associated forwarding wrapper, which must also be made
; obsolete.  The forwarding-wrapper is stored in the hash table below keyed
; on the wrapper-hash-index of the two wrappers.
(defvar *forwarding-wrapper-hash-table* (make-hash-table :test 'eq))  


(defun make-wrapper-obsolete (wrapper)
  (without-interrupts
   (let ((forwarding-info
          (unless (eql 0 (%wrapper-instance-slots wrapper))   ; already forwarded or obsolete?
            (%cons-forwarding-info (%wrapper-instance-slots wrapper)
                                   (%wrapper-class-slots wrapper)))))
     (when forwarding-info
       (setf (%wrapper-hash-index wrapper) 0
             (%wrapper-instance-slots wrapper) 0
             (%wrapper-forwarding-info wrapper) forwarding-info
	     (%wrapper-slot-id->slotd wrapper) #'%slot-id-lookup-obsolete
	     (%wrapper-slot-id-value wrapper) #'%slot-id-ref-obsolete
	     (%wrapper-set-slot-id-value wrapper) #'%slot-id-set-obsolete
             ))))
  wrapper)

#| ;; unused today
(defun %clear-class-primary-slot-accessor-offsets (class)
  (let ((info-list (%class-get class '%class-primary-slot-accessor-info)))
    (dolist (info info-list)
      (setf (%slot-accessor-info.offset info) nil))))

(defun primary-class-slot-offset (class slot-name)
  (dolist (super (%class.cpl class))
    (let* ((pos (and (typep super 'standard-class)
                     (%class-primary-p super)
                     (dolist (slot (%class-slots class))
		       (when (eq (%slot-definition-allocation slot)
				 :instance)
			 (when (eq slot-name (%slot-definition-name slot))
			   (return (%slot-definition-location slot))))))))
      (when pos (return pos)))))

; Called by the compiler-macro expansion for slot-value
; info is the result of a %class-primary-slot-accessor-info call.
; value-form is specified if this is set-slot-value.
; Otherwise it's slot-value.
(defun primary-class-slot-value (instance info &optional (value-form nil value-form-p))
  (let ((slot-name (%slot-accessor-info.slot-name info)))
    (prog1
      (if value-form-p
        (setf (slot-value instance slot-name) value-form)
        (slot-value instance slot-name))
      (setf (%slot-accessor-info.offset info)
            (primary-class-slot-offset (class-of instance) slot-name)))))

(defun primary-class-accessor (instance info &optional (value-form nil value-form-p))
  (let ((accessor (%slot-accessor-info.accessor info)))
    (prog1
      (if value-form-p
        (funcall accessor value-form instance)
        (funcall accessor instance))
      (let ((methods (compute-applicable-methods
                      accessor
                      (if value-form-p (list value-form instance) (list instance))))
            method)
        (when (and (eql (length methods) 1)
                   (typep (setq method (car methods)) 'standard-accessor-method))
          (let* ((slot-name (method-slot-name method)))
            (setf (%slot-accessor-info.offset info)
                  (primary-class-slot-offset (class-of instance) slot-name))))))))
|#

(defun exchange-slot-vectors-and-wrappers (a b)
  (let* ((temp-wrapper (instance.class-wrapper a))
	 (orig-a-slots (instance.slots a))
	 (orig-b-slots (instance.slots b)))
    (setf (instance.class-wrapper a) (instance.class-wrapper b)
	  (instance.class-wrapper b) temp-wrapper
	  (instance.slots a) orig-b-slots
	  (instance.slots b) orig-a-slots
	  (slot-vector.instance orig-a-slots) b
	  (slot-vector.instance orig-b-slots) a)))




;;; How slot values transfer (from PCL):
;;;
;;; local  --> local        transfer 
;;; local  --> shared       discard
;;; local  -->  --          discard
;;; shared --> local        transfer
;;; shared --> shared       discard
;;; shared -->  --          discard
;;;  --    --> local        added
;;;  --    --> shared        --
;;;
;;; See make-wrapper-obsolete to see how we got here.
;;; A word about forwarding.  When a class is made obsolete, the
;;; %wrapper-instance-slots slot of its wrapper is set to 0.
;;; %wrapper-class-slots = (instance-slots . class-slots)
;;; Note: this should stack-cons the new-instance if we can reuse the
;;; old instance or it's forwarded value.
(defun update-obsolete-instance (instance)
  (let* ((added ())
	 (discarded ())
	 (plist ()))
    (without-interrupts			; Not -close- to being correct
     (let* ((old-wrapper (standard-object-p instance)))
       (unless old-wrapper
         (when (standard-generic-function-p instance)
           (setq old-wrapper (gf.instance.class-wrapper instance)))
         (unless old-wrapper
           (report-bad-arg instance '(or standard-instance standard-generic-function))))
       (when (eql 0 (%wrapper-instance-slots old-wrapper))   ; is it really obsolete?
         (let* ((class (%wrapper-class old-wrapper))
                (new-wrapper (or (%class.own-wrapper class)
                                 (progn
                                   (update-class class t)
                                   (%class.own-wrapper class))))
                (forwarding-info (%wrapper-forwarding-info old-wrapper))
                (old-class-slots (%forwarding-class-slots forwarding-info))
                (old-instance-slots (%forwarding-instance-slots forwarding-info))
                (new-instance-slots (%wrapper-instance-slots new-wrapper))
                (new-class-slots (%wrapper-class-slots new-wrapper))
		(new-instance (allocate-instance class))
		(old-slot-vector (instance.slots instance))
		(new-slot-vector (instance.slots new-instance)))
             ;; Lots to do.  Hold onto your hat.
             (let* ((old-size (uvsize old-instance-slots))
		    (new-size (uvsize new-instance-slots)))
	       (declare (fixnum old-size new-size))
               (dotimes (i old-size)
	         (declare (fixnum i))
                 (let* ((slot-name (%svref old-instance-slots i))
                        (pos (%vector-member slot-name new-instance-slots))
                        (val (%svref old-slot-vector (%i+ i 1))))
                   (if pos
                     (setf (%svref new-slot-vector (%i+ pos 1)) val)
                     (progn
		       (push slot-name discarded)
		       (unless (eq val (%slot-unbound-marker))
			 (setf (getf plist slot-name) val))))))
               ;; Go through old class slots
               (dolist (pair old-class-slots)
                 (let* ((slot-name (%car pair))
                        (val (%cdr pair))
                        (pos (%vector-member slot-name new-instance-slots)))
                   (if pos
                     (setf (%svref new-slot-vector (%i+ pos 1)) val)
                     (progn
		       (push slot-name discarded)
		       (unless (eq val (%slot-unbound-marker))
			 (setf (getf plist slot-name) val))))))
               ; Go through new instance slots
               (dotimes (i new-size)
	         (declare (fixnum i))
                 (let* ((slot-name (%svref new-instance-slots i)))
                   (unless (or (%vector-member slot-name old-instance-slots)
                               (assoc slot-name old-class-slots))
                     (push slot-name added))))
               ;; Go through new class slots
               (dolist (pair new-class-slots)
                 (let ((slot-name (%car pair)))
                   (unless (or (%vector-member slot-name old-instance-slots)
                               (assoc slot-name old-class-slots))
                     (push slot-name added))))
               (exchange-slot-vectors-and-wrappers new-instance instance))))))
    ;; run user code with interrupts enabled.
    (update-instance-for-redefined-class instance added discarded plist))
  instance)

            
          
(defmethod update-instance-for-redefined-class ((instance standard-object)
						added-slots
						discarded-slots
						property-list
						&rest initargs)
  (declare (ignore discarded-slots property-list))
  (when initargs
    (check-initargs
     instance nil initargs t
     #'update-instance-for-redefined-class #'shared-initialize))
  (apply #'shared-initialize instance added-slots initargs))

(defmethod update-instance-for-redefined-class ((instance standard-generic-function)
						added-slots
						discarded-slots
						property-list
						&rest initargs)
  (declare (ignore discarded-slots property-list))
  (when initargs
    (check-initargs
     instance nil initargs t
     #'update-instance-for-redefined-class #'shared-initialize))
  (apply #'shared-initialize instance added-slots initargs))

(defun check-initargs (instance class initargs errorp &rest functions)
  (declare (dynamic-extent functions))
  (declare (list functions))
  (setq class (require-type (or class (class-of instance)) 'std-class))
  (let ((initvect (initargs-vector instance class functions)))
    (when (eq initvect t) (return-from check-initargs nil))
    (do* ((tail initargs (cddr tail))
          (initarg (car tail) (car tail))
          bad-keys? bad-key)
         ((null (cdr tail))
          (if bad-keys?
            (if errorp
              (error #'(lambda (stream key name class vect)
                         (let ((*print-array* t))
                           (format stream 
                                   "~s is an invalid initarg to ~s for ~s.~%~
                                    Valid initargs: ~s."
                                   key name class vect)))
                     bad-key (function-name (car functions)) class initvect)
              (values bad-keys? bad-key))))
      (if (eq initarg :allow-other-keys)
        (if (cadr tail)
          (return))                   ; (... :allow-other-keys t ...)
        (unless (or bad-keys? (%vector-member initarg initvect))
          (setq bad-keys? t
                bad-key initarg))))))

(defun initargs-vector (instance class functions)
  (let ((index (cadr (assq (car functions) *initialization-invalidation-alist*))))
    (unless index
      (error "Unknown initialization function: ~s." (car functions)))
    (let ((initvect (%svref (instance.slots class) index)))
      (unless initvect
        (setf (%svref (instance.slots class) index) 
              (setq initvect (compute-initargs-vector instance class functions))))
      initvect)))


(defun compute-initargs-vector (instance class functions)
  (let ((initargs (class-slot-initargs class))
        (cpl (%inited-class-cpl class)))
    (dolist (f functions)         ; for all the functions passed
      (dolist (method (%gf-methods f))   ; for each applicable method
        (let ((spec (car (%method-specializers method))))
          (when (if (typep spec 'eql-specializer)
                  (eql instance (eql-specializer-object spec))
                  (memq spec cpl))
            (let* ((func (%inner-method-function method))
                   (keyvect (if (logbitp $lfbits-aok-bit (lfun-bits func))
                              (return-from compute-initargs-vector t)
                              (lfun-keyvect func))))
              (dovector (key keyvect)
                (pushnew key initargs)))))))   ; add all of the method's keys
    (apply #'vector initargs)))



; A useful function
(defun class-make-instance-initargs (class)
  (setq class (require-type (if (symbolp class) (find-class class) class)
                            'std-class))
  (flet ((iv (class &rest functions)
           (declare (dynamic-extent functions))
           (initargs-vector (class-prototype class) class functions)))
    (let ((initvect (apply #'iv
                           class
                           #'initialize-instance #'allocate-instance #'shared-initialize
                           nil)))
      (if (eq initvect 't)
        t
        (concatenate 'list initvect)))))

                                   

; This is part of the MOP
;;; Maybe it was, at one point in the distant past ...
(defmethod class-slot-initargs ((class std-class))
  (apply #'append (mapcar #'(lambda (s)
                              (standard-slot-definition.initargs s))
                          (%class.slots class))))

    
  
(defun maybe-update-obsolete-instance (instance)
  (let ((wrapper (standard-object-p instance)))
    (unless wrapper
      (when (standard-generic-function-p instance)
        (setq wrapper (generic-function-wrapper instance)))
      (unless wrapper
        (report-bad-arg instance '(or standard-object standard-generic-function))))
    (when (eql 0 (%wrapper-hash-index wrapper))
      (update-obsolete-instance instance)))
  instance)


; If you ever reference one of these through anyone who might call update-obsolete-instance,
; you will lose badly.
(defun %maybe-forwarded-instance (instance)
  (maybe-update-obsolete-instance instance)
  instance)



(defmethod change-class (instance
			 (new-class symbol)
			 &rest initargs &key &allow-other-keys)
  (declare (dynamic-extent initargs))
  (apply #'change-class instance (find-class new-class) initargs))

(defmethod change-class ((instance standard-object)
			 (new-class standard-class)
			  &rest initargs &key &allow-other-keys)
  (declare (dynamic-extent initargs))
  (%change-class instance new-class initargs))


(defun %change-class (object new-class initargs)
  (let* ((old-class (class-of object))
	 (old-wrapper (%class.own-wrapper old-class))
	 (new-wrapper (or (%class.own-wrapper new-class)
			  (progn
			    (update-class new-class t)
			    (%class.own-wrapper new-class))))
	 (old-instance-slots-vector (%wrapper-instance-slots old-wrapper))
	 (new-instance-slots-vector (%wrapper-instance-slots new-wrapper))
	 (num-new-instance-slots (length new-instance-slots-vector))
	 (new-object (allocate-instance new-class)))
    (declare (fixnum num-new-instance-slots)
	     (simple-vector new-instance-slots old-instance-slots))
    ;; Retain local slots shared between the new class and the old.
    (do* ((new-pos 0 (1+ new-pos))
	  (new-slot-location 1 (1+ new-slot-location)))
	 ((= new-pos num-new-instance-slots))
      (declare (fixnum new-pos new-slot-vector-pos))
      (let* ((old-pos (position (svref new-instance-slots-vector new-pos)
				old-instance-slots-vector :test #'eq)))
	(when old-pos
	  (setf (%standard-instance-instance-location-access
		 new-object
		 new-slot-location)
		(%standard-instance-instance-location-access
		 object
		 (the fixnum (1+ (the fixnum old-pos))))))))
    ;; If the new class defines a local slot whos name matches
    ;; that of a shared slot in the old class, the shared slot's
    ;; value is used to initialize the new instance's local slot.
    (dolist (shared-slot (%wrapper-class-slots old-wrapper))
      (destructuring-bind (name . value) shared-slot
	(let* ((new-slot-pos (position name new-instance-slots-vector
				       :test #'eq)))
	  (if new-slot-pos
	    (setf (%standard-instance-instance-location-access
		   new-object
		   (the fixnum (1+ (the fixnum new-slot-pos))))
		  value)))))
    (exchange-slot-vectors-and-wrappers object new-object)
    (apply #'update-instance-for-different-class new-object object initargs)
    object))

(defmethod update-instance-for-different-class ((previous standard-object)
                                                (current standard-object)
                                                &rest initargs)
  (declare (dynamic-extent initargs))
  (%update-instance-for-different-class previous current initargs))

(defun %update-instance-for-different-class (previous current initargs)
  (when initargs
    (check-initargs
     current nil initargs t
     #'update-instance-for-different-class #'shared-initialize))
  (let* ((previous-slots (class-slots (class-of previous)))
	 (current-slots (class-slots (class-of current)))
	 (added-slot-names ()))
    (dolist (s current-slots)
      (let* ((name (%slot-definition-name s)))
	(unless (find-slotd name previous-slots)
	  (push name added-slot-names))))
    (apply #'shared-initialize
	   current
	   added-slot-names
	   initargs)))




; Clear all the valid initargs caches.
(defun clear-valid-initargs-caches ()
  (map-classes #'(lambda (name class)
                   (declare (ignore name))
                   (when (std-class-p class)
                     (setf (%class.make-instance-initargs class) nil
                           (%class.reinit-initargs class) nil
                           (%class.redefined-initargs class) nil
                           (%class.changed-initargs class) nil)))))

(defun clear-clos-caches ()
  (clear-all-gf-caches)
  (clear-valid-initargs-caches))

(defmethod allocate-instance ((class standard-class) &rest initargs)
  (declare (ignore initargs))
  (%allocate-std-instance class))

(defmethod allocate-instance ((class funcallable-standard-class) &rest initargs)
  (declare (ignore initargs))
  (%allocate-gf-instance class))

(unless *initialization-invalidation-alist*
  (setq *initialization-invalidation-alist*
        (list (list #'initialize-instance %class.make-instance-initargs)
              (list #'allocate-instance %class.make-instance-initargs)
              (list #'reinitialize-instance %class.reinit-initargs)
              (list #'shared-initialize 
                    %class.make-instance-initargs %class.reinit-initargs
                    %class.redefined-initargs %class.changed-initargs)
              (list #'update-instance-for-redefined-class
                    %class.redefined-initargs)
              (list #'update-instance-for-different-class
                    %class.changed-initargs))))


(defvar *initialization-function-lists*
  (list (list #'initialize-instance #'allocate-instance #'shared-initialize)
        (list #'reinitialize-instance #'shared-initialize)
        (list #'update-instance-for-redefined-class #'shared-initialize)
        (list #'update-instance-for-different-class #'shared-initialize)))



(unless *clos-initialization-functions*
  (setq *clos-initialization-functions*
        (list #'initialize-instance #'allocate-instance #'shared-initialize
              #'reinitialize-instance
              #'update-instance-for-different-class #'update-instance-for-redefined-class)))

(defun compute-initialization-functions-alist ()
  (let ((res nil)
        (lists *initialization-function-lists*))
    (dolist (cell *initialization-invalidation-alist*)
      (let (res-list)
        (dolist (slot-num (cdr cell))
          (push
           (ecase slot-num
             (#.%class.make-instance-initargs 
              (assq #'initialize-instance lists))
             (#.%class.reinit-initargs
              (assq #'reinitialize-instance lists))
             (#.%class.redefined-initargs
              (assq #'update-instance-for-redefined-class lists))
             (#.%class.changed-initargs
              (assq #'update-instance-for-different-class lists)))
           res-list))
        (push (cons (car cell) (nreverse res-list)) res)))
    (setq *initialization-functions-alist* res)))

(compute-initialization-functions-alist)


;; Need to define this for all of the built-in-class'es.
(defmethod class-prototype ((class std-class))
  (or (%class.prototype class)
      (setf (%class.prototype class) (allocate-instance class))))



(defun gf-class-prototype (class)
  (%allocate-gf-instance class))



(defmethod class-prototype ((class structure-class))
  (or (%class.prototype class)
      (setf (%class.prototype class)
            (funcall (sd-constructor (gethash (%class.name class) %defstructs%))))))


(defmethod remove-method ((generic-function standard-generic-function)
                          (method standard-method))
  (when (eq generic-function (%method-gf method))
    (%remove-standard-method-from-containing-gf method))
  generic-function)



(defmethod function-keywords ((method standard-method))
  (let ((f (%inner-method-function method)))
    (values
     (concatenate 'list (lfun-keyvect f))
     (%ilogbitp $lfbits-aok-bit (lfun-bits f)))))

(defmethod no-next-method ((generic-function standard-generic-function)
                           (method standard-method)
                           &rest args)
  (error "There is no next method for ~s~%args: ~s" method args))

(defmethod add-method ((generic-function standard-generic-function) (method standard-method))
  (%add-standard-method-to-standard-gf generic-function method))

(defmethod no-applicable-method (gf &rest args)
  (error "No applicable method for args:~% ~s~% to ~s" args gf))


(defmethod no-applicable-primary-method (gf methods)
  (%method-combination-error "No applicable primary methods for ~s~@
                              Applicable methods: ~s" gf methods))

(defmethod compute-applicable-methods ((gf standard-generic-function) args)
  (%compute-applicable-methods* gf args))

(defun %compute-applicable-methods+ (gf &rest args)
  (declare (dynamic-extent args))
  (%compute-applicable-methods* gf args))

(defun %compute-applicable-methods* (gf args)
  (let* ((methods (%gf-methods gf))
         (args-length (length args))
         (bits (inner-lfun-bits gf))
         arg-count res)
    (when methods
      (setq arg-count (length (%method-specializers (car methods))))
      (unless (<= arg-count args-length)
        (error "Too few args to ~s" gf))
      (unless (or (logbitp $lfbits-rest-bit bits)
                  (logbitp $lfbits-restv-bit bits)
                  (logbitp $lfbits-keys-bit bits)
                  (<= args-length 
                      (+ (ldb $lfbits-numreq bits) (ldb $lfbits-numopt bits))))
        (error "Too many args to ~s" gf))
      (let ((cpls (make-list arg-count)))
        (declare (dynamic-extent cpls))
        (do* ((args-tail args (cdr args-tail))
              (cpls-tail cpls (cdr cpls-tail)))
            ((null cpls-tail))
          (setf (car cpls-tail)
                (%class-precedence-list (class-of (car args-tail)))))
        (dolist (m methods)
          (if (%method-applicable-p m args cpls)
            (push m res)))
        (sort-methods res cpls (%gf-precedence-list gf))))))


(defun %method-applicable-p (method args cpls)
  (do* ((specs (%method-specializers method) (%cdr specs))
        (args args (%cdr args))
        (cpls cpls (%cdr cpls)))
      ((null specs) t)
    (let ((spec (%car specs)))
      (if (typep spec 'eql-specializer)
        (unless (eql (%car args) (eql-specializer-object spec))
          (return nil))
        (unless (memq spec (%car cpls))
          (return nil))))))


; Need this so that (compute-applicable-methods #'class-precedence-list ...)
; will not recurse.
(defun %class-precedence-list (class)
  (if (eq (class-of class) *standard-class-class*)
    (%inited-class-cpl class)
    (class-precedence-list class)))

(defmethod class-precedence-list ((class standard-class))
  (%inited-class-cpl class))

(defmethod class-precedence-list ((class class))
  (or (%class.cpl class)
      (error "~s has no class-precedence-list." class)))





(defun make-all-methods-kernel ()
  (dolist (f (population.data %all-gfs%))
    (let ((smc *standard-method-class*))
      (dolist (method (slot-value-if-bound f 'methods))
	(when (eq (class-of method) smc)
	  (change-class method *standard-kernel-method-class*))))))


(defun make-all-methods-non-kernel ()
  (dolist (f (population.data %all-gfs%))
    (let ((skmc *standard-kernel-method-class*))
      (dolist (method (slot-value-if-bound f 'methods))
	(when (eq (class-of method) skmc)
	  (change-class method *standard-method-class*))))))





(defun required-lambda-list-args (l)
  (multiple-value-bind (ok req) (verify-lambda-list l)
    (unless ok (error "Malformed lambda-list: ~s" l))
    req))




(defun check-generic-function-lambda-list (ll &optional (errorp t))
  (multiple-value-bind (ok reqsyms opttail resttail keytail auxtail)
                       (verify-lambda-list ll)
    (declare (ignore reqsyms resttail))
    (when ok 
      (block checkit
        (when (eq (car opttail) '&optional)
          (dolist (elt (cdr opttail))
            (when (memq elt lambda-list-keywords) (return))
            (unless (or (symbolp elt)
                        (and (listp elt)
                             (non-nil-symbol-p (car elt))
                             (null (cdr elt))))
              (return-from checkit (setq ok nil)))))
        (dolist (elt (cdr keytail))
          (when (memq elt lambda-list-keywords) (return))
          (unless (or (symbolp elt)
                      (and (listp elt)
                           (or (non-nil-symbol-p (car elt))
                               (and (listp (car elt))
                                    (non-nil-symbol-p (caar elt))
                                    (non-nil-symbol-p (cadar elt))
                                    (null (cddar elt))))
                           (null (cdr elt))))
            (return-from checkit (setq ok nil))))
        (when auxtail (setq ok nil))))
    (when (and errorp (not ok))
      (signal-program-error "Bad generic function lambda list: ~s" ll))
    ok))




(defun canonicalize-argument-precedence-order (apo req)
  (cond ((equal apo req) nil)
        ((not (eql (length apo) (length req)))
         (error "Lengths of ~S and ~S differ." apo req))
        (t (let ((res nil))
             (dolist (arg apo (nreverse res))
               (let ((index (position arg req)))
                 (if (or (null index) (memq index res))
                   (error "Missing or duplicate arguments in ~s" apo))
                 (push index res)))))))



(defun %defgeneric (function-name lambda-list method-combination generic-function-class
                                  options)
  (setq generic-function-class (find-class generic-function-class))
  (setq method-combination 
        (find-method-combination
         (class-prototype generic-function-class)
         (car method-combination)
         (cdr method-combination)))
  (let ((gf (fboundp function-name)))
    (when gf
      (dolist (method (%defgeneric-methods gf))
        (remove-method gf method))))
  (record-source-file function-name 'function)
  (record-arglist function-name lambda-list)
  (apply #'ensure-generic-function 
         function-name
         :lambda-list lambda-list
         :method-combination method-combination
         :generic-function-class generic-function-class
         options))




; Redefined in lib;method-combination.lisp
(defmethod find-method-combination ((gf standard-generic-function) type options)
  (unless (and (eq type 'standard) (null options))
    (error "non-standard method-combination not supported yet."))
  *standard-method-combination*)


(defmethod add-direct-method ((spec specializer) (method method))
  (pushnew method (specializer.direct-methods spec)))

(setf (fdefinition '%do-add-direct-method) #'add-direct-method)


(defmethod remove-direct-method ((spec specializer) (method method))
  (setf (specializer.direct-methods spec)
	(nremove method (specializer.direct-methods spec))))

(setf (fdefinition '%do-remove-direct-method) #'remove-direct-method)

(defmethod instance-class-wrapper ((instance standard-object))
  (instance.class-wrapper instance))

(defmethod instance-class-wrapper ((instance standard-generic-function))
  (gf.instance.class-wrapper  instance))

(defun generic-function-wrapper (gf)
  (unless (inherits-from-standard-generic-function-p (class-of gf))
    (%badarg gf 'standard-generic-function))
  (gf.instance.class-wrapper gf))

(defvar *make-load-form-saving-slots-hash* (make-hash-table :test 'eq))

(defun make-load-form-saving-slots (object &key
					   (slot-names nil slot-names-p)
					   environment)
  (declare (ignore environment))
  (let* ((class (class-of object))
         (class-name (class-name class))
         (structurep (structurep object))
         (sd (and structurep (require-type (gethash class-name %defstructs%) 'vector))))
    (unless (or structurep
                (standard-instance-p object))
      (%badarg object '(or standard-object structure-object)))
    (if slot-names-p
      (dolist (slot slot-names)
        (unless (slot-exists-p object slot)
          (error "~s has no slot named ~s" object slot)))
      (setq slot-names
            (if structurep
              (let ((res nil))
                (dolist (slot (sd-slots sd))
                  (unless (fixnump (car slot))
                    (push (%car slot) res)))
                (nreverse res))
              (mapcar '%slot-definition-name
                      (extract-instance-effective-slotds (class-of object))))))
    (values
     (let* ((form (gethash class-name *make-load-form-saving-slots-hash*)))
       (or (and (consp form)
                (eq (car form) 'allocate-instance)
                form)
           (setf (gethash class-name *make-load-form-saving-slots-hash*)
                 `(allocate-instance (find-class ',class-name)))))
     ;; initform is NIL when there are no slots
     (when slot-names
       `(%set-slot-values
         ',object
         ',slot-names
         ',(let ((temp #'(lambda (slot)
                           (if (slot-boundp object slot)
                             (slot-value object slot)
                             (%slot-unbound-marker)))))
             (declare (dynamic-extent temp))
             (mapcar temp slot-names)))))))


    

(defmethod allocate-instance ((class structure-class) &rest initargs)
  (declare (ignore initargs))
  (let* ((class-name (%class-name class))
         (sd (or (gethash class-name %defstructs%)
                 (error "Can't find structure named ~s" class-name)))
         (res (make-structure-vector (sd-size sd))))
    (setf (%svref res 0) (sd-superclasses sd))
    res))


(defun %set-slot-values (object slots values)
  (dolist (slot slots)
    (let ((value (pop values)))
      (if (eq value (%slot-unbound-marker))
        (slot-makunbound object slot)
        (setf (slot-value object slot) value)))))



#|
(defmethod method-specializers ((method standard-method))
  (%method-specializers method))

(defmethod method-qualifiers ((method standard-method))
  (%method-qualifiers method))
|#

(defun %recache-class-direct-methods ()
  (let ((*maintain-class-direct-methods* t))   ; in case we get an error
    (dolist (f (population-data %all-gfs%))
      (when (standard-generic-function-p f)
        (dolist (method (%gf-methods f))
          (%add-direct-methods method)))))
  (setq *maintain-class-direct-methods* t))   ; no error, all is well




