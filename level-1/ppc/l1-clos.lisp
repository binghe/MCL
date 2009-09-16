;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: l1-clos.lisp,v $
;;  Revision 1.22  2004/10/11 02:11:23  alice
;;  ;; change to ensure class
;;
;;  Revision 1.21  2004/09/01 19:38:31  svspire
;;  Late redefine ensure-generic-function instead of setfing the fdefinition of %ensure-generic-function-using-class so it's clear from the definition what's going on.
;;
;;  Revision 1.20  2004/06/15 13:58:14  alice
;;  ;; update-slots usually creates new wrapper - from Gary
;;
;;  Revision 1.19  2004/06/04 05:06:07  alice
;;  ;; check-for-class-circle less redundant
;;
;;  Revision 1.18  2004/04/02 16:24:08  svspire
;;  Include #'add-method in the post-bootstrap redefinitions so it will get called when AMOP says it's supposed to.
;;
;;  Revision 1.17  2004/04/01 21:37:55  svspire
;;  ensure-class-using-class: partial fix for forward-referenced class problems, per GB.
;;
;;  Revision 1.16  2004/03/31 17:43:37  alice
;;  moved circle check to  class-has-a-forward-referenced-superclass-p
;;
;;  Revision 1.15  2004/03/30 02:49:35  alice
;;  circular class detection now boots
;;
;;  Revision 1.14  2004/03/29 04:48:43  alice
;;  retract previous change - doesn't boot
;;
;;  Revision 1.13  2004/03/29 04:21:46  alice
;;  fix ensure-class to error vs blow the stack for circular class def
;;
;;  Revision 1.12  2004/03/25 02:36:24  alice
;;  ;; 03/24/04 ensure-class-using-class ((class class) gets &allow-other-keys
;;
;;  Revision 1.11  2004/03/16 00:15:17  svspire
;;  Er, that should read "normalize-egf-keys"
;;
;;  Revision 1.10  2004/03/15 23:56:08  svspire
;;  Fix parentheses in error message in normalize-gf-keys
;;
;;  Revision 1.9  2004/03/03 17:19:18  gtbyers
;;  Change CLASS-HAS-A-FORWARD-REFERENCED-SUPERCLASS-P to return the first forward-referenced class found.  Define COMPUTE-CLASS-PRECEDENCE-LIST and have it detect forward-referenced superclasses.  UPDATE-CLASS invalidates any cached initarg functions (for MAKE-INSTANCE, etc.).
;;
;;  Revision 1.8  2004/01/04 02:17:58  gtbyers
;;  %SHARED-INITIALIZE: typecheck initform vale, not (missing) initarg.
;;
;;  Revision 1.7  2003/12/29 04:12:20  gtbyers
;;  New slot-lookup stuff.
;;
;;  Revision 1.6  2003/12/08 08:28:03  gtbyers
;;  Lots and lots of changes.
;;
;;  4 10/5/97  akh  see below
;;  3 8/25/97  akh  probably nothing
;;  32 1/22/97 akh  eval-when around declaim inline standard-instance-p
;;  26 7/18/96 akh  dummy def for find-unencapsulated-definition, :ppc-clos on *features*,
;;                     %class-of-instance
;;  25 6/16/96 akh  faster generic-function protos, lapify class-of
;;  24 6/7/96  akh  check-generic-function-lambda-list
;;                  interpreted-method-function is both interpreted-function and method-function
;;                  and intrepreted-lexical-closure is interpreted-function
;;  22 5/20/96 akh  add class-cell-find-class
;;  20 3/16/96 akh  dont do %%reader/writer-dcode when *compile-definitions* is nil
;;  17 3/9/96  akh  short-float = double-float, delete some commented out stuff
;;  14 1/28/96 akh  fix class-of for nwo
;;                  reinstate %%reader-dcode and %%writer-dcode
;;  13 12/1/95 gb   allocate-typed-vector wants type-keyword first
;;  12 11/15/95 gb  new class-of for PPC
;;  10 10/31/95 akh remove make-simple-vector
;;                  #-ppc-target the 68k class arrays.
;;  8 10/26/95 Alice Hartley make-simple-vector = make-array (the fixnum .)
;;  7 10/23/95 akh  some ppc stuff, class-of was slightly wrong for ppc
;;  6 10/17/95 akh  class-of - only outer fn is standard-generic-function-p
;;  5 10/13/95 bill ccl3.0x25
;;  4 10/10/95 akh  code-vector is not an lfun vector
;;  3 10/8/95  akh  no mo lap
;;  4 8/18/95  akh  methods-congruent-p - check for really method
;;  3 1/31/95  akh  no more bignums in copy-method-function-bits - per patch
;;  (do not edit before this line!!)

; l1-clos.lisp
; Copyright 1990-1994 Apple Computer, Inc.
; Copyright 1995-2000 Digitool, Inc.

(in-package :ccl)

; Modification History

;; collect is now in ccl package
;; update-class moved from ensure-class to shared-initialize
;; class-has-a-forward-referenced-superclass-p less likely to blow the stack
;; xxx-slot-definition-class methods check :allocation = :instance or :class
;; comment out an unused function re %slotd
;; add-accessor-methods - warn if same named accessor for different slots?
;; no more :initargs for :direct-slots in slots-class
;; faster accessor methods
;; minor change to %shared-initialize - just optimization
;; (setf class-name) calls reinitialize-instance
;; -------- 5.2b6
;; -------- 5.1 final
;; update-slots usually creates new wrapper - from Gary
;; check-for-class-circle less redundant
;; --------- 5.1b2
;; 03/24/04 ensure-class-using-class ((class class) gets &allow-other-keys
;; ------ 5.1b1
; lose type-seen, type-intersect detects nonsense - would have caught CLIM bug at compile time rather than run time
; ---------- 5.0 final
; add allocate-instance std-class, add method change-class ((instance standard-generic-function) (new-class funcallable-standard-class)
; fix initialize-class fix to be more specific - much more
;; -------- 4.4b3
; enforce read-only in set-structure-slot-value
; added variable *check-slot-type*, if true do that in %shared-initialize, set-slot-value, and initialize-class-and-wrapper
;  probably doesn't work for primary classes.
; enforce slot type in set-structure-slot-value but not in set-slot-value
; see comment in initialize-class
; ------- 4.3.1b1
; 07/24/99 akh unbound slot signals error of type unbound-slot
; --------- 4.3f1c1
; 07/12/99 akh compute-cpl trying to produce a very slightly more informative error message
; --------- 4.3b3
; 05/07/99 akh make-instances-obsolete returns the class 
; ------------ 4.3b1
; 03/28/99 akh  method-slot-name for interpreted accessors?
; 01/20/99 akh   add built-in classes extended-char and base-char per stupid ANSI CL change
; 11/28/97 akh   fix  shared-initialize (and thus initialize-instance also) to check initargs if called from "outside"
; 11/19/97 akh   change-class takes initargs per ANSI CL
; 09/23/97 akh   %add-method - use inner-lfun-bits for method function
; 08/26/97 akh   %change-class - fix setting slots unbound  - it missed the last one
; 03/01/97 gb    SET-FIND-CLASS clears type cache; add SHORT-FLOATs and SHORT-FLOAT-VECTOR
;                classes.
; 01/02/97 bill  initialize-class & sort-instance-slotds handle primary classes.
;                Remove *special-instance-slotds-alist*.
;                Instead, stanard-method, class, & std-class are primary classes.
; 01/01/97 bill  %defclass takes a :primary-p keyword, the value of which is stored
;                in the class'es :primary-p property.
; 12/27/96 bill  New instance representation scheme (all instances have a forwarding pointer,
;                usually pointing to the instance itself).
; -------------  4.0
; 10/04/96 bill  (with-slots () instance ...) and (with-accessors () instance ...) no longer
;                warn about an unused gensym.
; 09/13/96 bill  compute-cpl calls itself recursively if one of the superclasses
;                has a null %class-cpl.
; 08/26/96 bill  redefine-kernel-method says MCL instead of CCL in its error message.
; 08/21/96 bill  %defgeneric calls record-arglist to save the user arglist.
; -------------  4.0b1
; 08/10/96 bill  Gary's fix to the ppc::subtag-vectorH case in *ppc-class-table*
; 08/07/96 bill  the subtag-function entry of *ppc-class-table* can distinguish
;                a closed over method function from a generic function and a combined-method
; 07/18/96 gb    setup *features* in one place.
; akh - dummy def for find-unencapsulated-definition, :ppc-clos on *features*
;      %class-of-instance
; akh check-generic-function-lambda-list
; akh interpreted-method-function is both interpreted-function and method-function
;     and intrepreted-lexical-closure is interpreted-function 
; 06/04/96 bill  %defclass sets the %class-ctype when :metaclass is specified
; akh  class-cell-find-class
; -------------  MCL-PPC 3.9
; 04/10/96 bill  standard-kernel-method class stored in *standard-kernel-method-class*
;                redefine-kernel-method checks for it.
;                make-all-methods-kernel makes changes the class of all generic function methods
;                to *standard-kernel-method-class*.
; 03/07/96 bill  value-cell class and an entry for it in *ppc-class-table*
; 03/10/96 gb    creole-object
; 02/23/96 bill  Fix %defmethod and %anonymous-method to work for a non-standard method class.
; 01/31/96 bill  *ppc-class-table* handles stack-groups
; 11/15/95 gb    new class-of.
; 11/04/95 gb    add some stuff from level-0; explict :initial-element nil
;                 on a make-array call.
; 10/12/95 bill  slot-value & set-slot-value work again for structure instances
;  4/06/95 slh   some encapsulate fns here, to make it optional
; -------------- 3.0d18
; 12/26/94 alice move class-cell-typep here for bootstrapping
; Change log
; 10/08/93 bill  (make-built-in-class 'periodic-task)
; -------------- 3.0d13
; 07/26/93 bill  make $lfbits-restv-bit equivalent to $lfbits-rest-bit
; 07/07/93 bill  new-class-wrapper-hash-index now uses random instead of incrementing a counter.
; 07/06/93 bill  class-make-instance-initargs now returns T if all initargs are accepted.
;                It used to error in this case.
; -------------- 3.0d11
; 05/16/93 alice added built-in-class simple-extended-string
; 05/15/93 alice %%class-of does extended-char via non-zero high byte of char  - need to fix print-object
; 01/11/93 bill  process-queue class
; 12/29/92 bill  make-load-form-saving-slots now handles unbound slots correctly.
; 12/17/92 bill  (make-built-in-class 'resource ...)
; 09/10/92 bill  make-load-form-saving-slots now returns (allocate-instance (find-class '<class-name>))
;                instead of (make-instance '<class-name>). allocate-instance now defined for structure-class,
;                so make-load-form-saving-slots doesn't have to special case structure instances as much.
; 07/30/92 bill  make-load-form-saving-slots returns a second value of NIL
;                when there are no slots (thanks to Flavors).
; 07/24/92 bill  %find-classes% now hashes name to (name . class)
;                so that (make-instance 'name) can be transformed
;                to (%make-instance (load-time-value (find-class-cell 'name t)))
; 07/23/92 bill  speed up make-instance by making default-initargs faster.
; 07/21/92 bill  Some more AMOP readers for slot-definition objects
; 07/17/92 bill  %update-instance-for-difference-class -> %update-instance-for-different-class
; 07/08/92 bill  METHOD now works for EQL specializers
; 06/19/92 bill  in method-slot-name: %method-function -> %inner-method-function.
;                This stops tracing an accessor method from breaking it.
; 04/21/92 bill  remove confusing comment.
; 04/17/92 bill  make-load-form-saving-slots no longer does (%svref nil 4) if called
;                with a structure instance and a non-empty list of slots.
;                It also interprets an explicit value of NIL for its second arg
;                as specifying no slots instead of all slots.
; 04/17/92 bill  set-class-slot-value calls error instead of slot-missing
; 04/07/92 bill  ensure-generic-function-internal now cerrors on change of lambda list.
; -------------  2.0
; 03/24/92 bill  set-aux-init-functions no longer leaves NILs in *initialization-invalidation-alist*
; -------------- 2.0f3
; 02/21/92 (bill from bootpatch0) in INVALIDATE-INITARGS-VECTOR-FOR-GF: allow specialization of
;               initialize-instance for classes which do not inherit from std-class.
; ------------- 2.0f2
; 12/14/91 alice copy-method-function-bits, copy the method-bit too
; 12/14/91 alice add a class for interpreted-method-function and use it in %%class-of
; 12/10/91 gb   no ralph bit.
; ------------- 2.0b4
; 11/22/91 bill change-class no longer conses a new wrapper if it doesn't
;               need to.  *eql-methods-hashes* maps objects to a list of their
;               EQL methods so that those generic functions can be properly
;               updated at change-class time.
; 11/08/91 bill initialize-class needed to clear the aux-init-functions-cache
; 10/31/91 gb   make-built-in-class for 'compiler-policy.
; 10/29/91 bill check-generic-function-lambda-list
; 10/11/91 bill class-instance-slots & class-class-slots needed to initialize-class
;               clear-class-direct-methods-caches -> clear-specializer-direct-methods-caches
;               If *defmethod-congruency-override* is a function, attempts
;               to redefine a non generic-function as a generic function
;               will cause it to get called with the function name (a
;               symbol) as the first arg.  This was inconsistent before.
; 10/10/91 bill remove forward-referenced-class.  We don't use it yet.
; 10/10/91 gb   make built-in-classes for base-,extended-character; standard-char subtype of base-character.
;               make built-in-classes for bit, signed- and unsigned-byte.
; 10/03/91 bill kill class-direct-slots.  Add class-direct-instance-slots, class-direct-class-slots,
;               class-class-slots
; 09/30/91 gb   (make-built-in-class 'lexical-environment *istruct-class*).
; 09/18/91 bill 'standard-class -> 'std-class where appropriate.
; -------------- 2.0b3
; 08/28/91 gb   forget about funcallable instances.
; 08/24/91 gb   use new trap syntax : (dc.w #_debugger)
; 07/21/91 gb   don't defvar built-in-classes unless necessary.  better badarg errors
;               (some may be wrong).  Use dynamic-extent.
; 08/14/91 bill forget-encapsulations when redefining a non-generic-function to be a generic-function.
; 08/13/91 bill new order for encapsulating generic functions in %defmethod & compute-dcode
; 08/07/91 bill documentation for methods, generic-functions, and classes is now
;               associated with the instance, not its name.
; 07/15/91 bill remove debugging declare from %defclass
; 07/05/91 bill compute-dcode now uses %%reader-dcode & %%writer-dcode for
;               generic-functions
; 07/02/91 bill Detect attempts to add slots to an instance of STANDARD-CLASS.
;               This is a bug that should be fixed, but doing so is a big global change.
;               Everywhere there's a (%class-xxx class),
;               it needs to be (%class-xxx (%maybe-forwarded-instance class))
;               Warn on attempting to redefine kernel methods or classes
; 06/25/91 bill Make the class hierarchy agree with "The Art of the MOP".
;               standard-generic-function is now a subclass of standard-object
;               and an instance of funcallable-standard-class.
; 06/19/91 bill (typep generic-function 'standard-object) => t
;               funcallable-instance -> funcallable-standard-object
;               funcallable-standard-class
; 06/14/91 bill compute-dcode & multi-method-index
;               (defmethod print-object :around (x (stream foo)) ...)
;               no longer destroys the printer.
;               In general, it now works to have a generic function which
;               contains both methods which specialize on the first argument
;               and methods which do not specialize on the first
;               argument but do specialize on another argument.
;-------------- 2.0b2
; 05/29/91 bill copy-instance is now a generic-function
; 05/28/91 bill #'(setf class-name)
;               slot-value & set-slot-value support structure-instance's
; 05/20/91 gb   New float class hierarchy.
; 05/14/91 bill make-load-form-saving-slots
; 05/09/91 bill %compile-time-defclass, find-class looks in defenv.classes
; 05/06/91 bill copy-instance
; 05/01/91 bill %add-methods
; 04/15/91 bill allow the metaclass arg to %defclass to be a class as well as a class name
; 04/09/91 bill SPECIALIZER class
;               %anonymous-method supports specializer instances as well as names.
; 04/02/91 bill %defclass supports the metaclass class option
; 04/02/91 bill ensure-generic-function-internal comes out of ensure-generic-function
;               so that generic-function can use it.
; 03/27/91 bill no-applicable-method says "No applicable method ..." vice
;               "No applicable primary method ..."
; 03/25/91 bill compute-applicable-methods does not take a rest arg.
; 03/20/91 bill slot-name -> method-slot-name
; 03/14/91 bill finally generic-functions with no specializers
; 03/12/91 bill slot-exists-p returns NIL vice erroring on non STANDARD-INSTANCE's
; 03/05/91 bill instance-class-wrapper methods.
; 02/28/91 bill %slot-value & set-slot-value work for standard-generic-function's
; 02/20/91 bill don't type-check method-qualifiers in %defmethod.
; 02/15/91 bill *standard-method-combination* is now an instance of the class named
;               standard-method-combination.
; 02/15/91 bill First half of file moved to l1-dcode.lisp
;------------ 2.0b1




(eval-when (eval compile)
  (require 'defstruct-macros))

;;; At this point in the load sequence, the handful of extant basic classes
;;; exist only in skeletal form (without direct or effective slot-definitions.)


(defun extract-slotds-with-allocation (allocation slotds)
  (collect ((right-ones))
    (dolist (s slotds (right-ones))
      (if (eq (%slot-definition-allocation s) allocation)
        (right-ones s)))))

(defun extract-instance-direct-slotds (class)
  (extract-slotds-with-allocation :instance (%class.direct-slots class)))

(defun extract-class-direct-slotds (class)
  (extract-slotds-with-allocation :class (%class.direct-slots class)))

(defun extract-instance-effective-slotds (class)
  (extract-slotds-with-allocation :instance (%class.slots class)))

(defun extract-class-effective-slotds (class)
  (extract-slotds-with-allocation :class (%class.slots class)))

(defun extract-instance-and-class-slotds (slotds)
  (collect ((instance-slots)
                  (shared-slots))
    (dolist (s slotds (values (instance-slots) (shared-slots)))
      (if (eq (%slot-definition-allocation s) :class)
        (shared-slots s)
        (instance-slots s)))))



(defun direct-instance-and-class-slotds (class)
  (extract-instance-and-class-slotds (%class.direct-slots class)))

(defun effective-instance-and-class-slotds (class)
  (extract-instance-and-class-slotds (%class.slots class)))

(defun %shared-initialize (instance slot-names initargs)
  (unless (or (listp slot-names) (eq slot-names t))
    (report-bad-arg slot-names '(or list (eql t))))
  (unless (plistp initargs) (report-bad-arg initargs '(satisfies plistp)))
  (let* ((wrapper (instance.class-wrapper instance))
         (class (%wrapper-class wrapper)))
    (when (eql 0 (%wrapper-hash-index wrapper)) ; obsolete
      (update-obsolete-instance instance)
      (setq wrapper (instance.class-wrapper instance)))
    (dolist (slotd (%class.slots class))
      (let* ((loc (%slot-definition-location slotd)))
        (unless loc (error "Blew it! no location for ~s" slotd))
        (multiple-value-bind (ignore new-value foundp)
            (get-properties initargs
                            (%slot-definition-initargs slotd))
          (declare (ignore ignore))
          (if foundp
	    (progn
	      (unless (or (eq t (standard-effective-slot-definition.type slotd))  ;; <<
                          (funcall (standard-effective-slot-definition.type-predicate slotd) new-value))
		(report-bad-arg new-value (%slot-definition-type slotd)))
	      (if (consp loc)
		(rplacd loc new-value)
		(setf (standard-instance-instance-location-access instance loc)
		      new-value)))
            (if (or (eq slot-names t)
                    (member (%slot-definition-name slotd)
                            slot-names
			    :test #'eq))
              (let* ((curval (if (consp loc)
                               (cdr loc)
                               (%standard-instance-instance-location-access
				instance loc))))
                (if (eq curval (%slot-unbound-marker))
                  (let* ((initfunction (%slot-definition-initfunction slotd)))
                    (if initfunction
                      (let* ((newval (funcall initfunction)))
			(unless (or (eq t (standard-effective-slot-definition.type slotd))  ;; <<
                                    (funcall (standard-effective-slot-definition.type-predicate slotd) newval))
			  (report-bad-arg newval (%slot-definition-type slotd)))
                        (if (consp loc)
                          (rplacd loc newval)
                          (setf (standard-instance-instance-location-access
				 instance loc)
				newval)))))))))))))
  instance)

;;; This is redefined (to call MAKE-INSTANCE) below.
(setf (fdefinition '%make-direct-slotd)
      #'(lambda (slotd-class &key
			     name
			     initfunction
			     initform
			     initargs
			     (allocation :instance)
			     class
			     (type t)
			     (documentation (%slot-unbound-marker))
			     readers
			     writers)
	  (declare (ignore slotd-class))
	  (%instance-vector
	   (%class.own-wrapper *standard-direct-slot-definition-class*)
	   name type initfunction initform initargs allocation
	   documentation class readers writers)))

;;; Also redefined below, after MAKE-INSTANCE is possible.
(setf (fdefinition '%make-effective-slotd)
      #'(lambda (slotd-class &key
			     name
			     initfunction
			     initform
			     initargs
			     allocation
			     class
			     type
			     documentation)
	  (declare (ignore slotd-class))
	  (%instance-vector
	   (%class.own-wrapper *standard-effective-slot-definition-class*)
	   name type initfunction initform initargs allocation
	   documentation class nil (ensure-slot-id name) #'t-p)))

(defmethod class-slots ((class class)))
(defmethod class-direct-slots ((class class)))
(defmethod class-default-initargs ((class class)))
(defmethod class-direct-default-initargs ((class class)))


#|
(defmethod direct-slot-definition-class ((class std-class) &rest initargs)
  (declare (ignore initargs))
  *standard-direct-slot-definition-class*)

(defmethod effective-slot-definition-class ((class std-class) &rest  initargs)
  (declare (ignore initargs))
  *standard-effective-slot-definition-class*)
|#



(defmethod direct-slot-definition-class ((class std-class) &key (allocation :instance) &allow-other-keys)
  (unless (member allocation '(:instance :class))
    (report-bad-arg allocation '(member (:instance :class))))
  *standard-direct-slot-definition-class*)

(defmethod effective-slot-definition-class ((class std-class) &key (allocation :instance) &allow-other-keys)
  (unless (member allocation '(:instance :class))
    (report-bad-arg allocation '(member (:instance :class))))
  *standard-effective-slot-definition-class*)




(defun make-direct-slot-definition (class initargs)
  (apply #'%make-direct-slotd
	 (apply #'direct-slot-definition-class class initargs)
	 :class class
	 initargs))

(defun make-effective-slot-definition (class &rest initargs)
  (declare (dynamic-extent initargs))
  (apply #'%make-effective-slotd
	 (apply #'effective-slot-definition-class class initargs)
	 initargs))


(defmethod compute-effective-slot-definition ((class slots-class)
                                              name
                                              direct-slots)
  
  (let* ((initer (dolist (s direct-slots)
                   (when (%slot-definition-initfunction s)
                     (return s))))
         (documentor (dolist (s direct-slots)
		       (when (%slot-definition-documentation s)
                         (return s))))
         (first (car direct-slots))
         (initargs (let* ((initargs nil))
                     (dolist (dslot direct-slots initargs)
                       (dolist (dslot-arg (%slot-definition-initargs  dslot))
                         (pushnew dslot-arg initargs :test #'eq))))))
    (make-effective-slot-definition
     class
     :name name
     :allocation (%slot-definition-allocation first)
     :documentation (when documentor (nth-value
				      1
				      (%slot-definition-documentation
				       documentor)))
     :class (%slot-definition-class first)
     :initargs initargs
     :initfunction (if initer (%slot-definition-initfunction initer))
     :initform (if initer (%slot-definition-initform initer))
     :type (or (%slot-definition-type first) t))))

(defmethod compute-slots ((class slots-class))
  (let* ((slot-name-alist ()))
    (labels ((note-direct-slot (dslot)
               (let* ((sname (%slot-definition-name dslot))
                      (pair (assq sname slot-name-alist)))
                 (if pair
                   (push dslot (cdr pair))
                   (push (list sname dslot) slot-name-alist))))
             (rwalk (tail)
               (when tail
                 (rwalk (cdr tail))
		 (let* ((c (car tail)))
		   (unless (eq c *t-class*)
		     (dolist (dslot (%class-direct-slots c))
		       (note-direct-slot dslot)))))))
      (rwalk (class-precedence-list class)))
    (collect ((effective-slotds))
      (dolist (pair (nreverse slot-name-alist) (effective-slotds))
        (effective-slotds (compute-effective-slot-definition class (car pair) (cdr pair)))))))


(defmethod compute-slots :around ((class std-class))
  (let* ((cpl (%class.cpl class)))
    (multiple-value-bind (instance-slots class-slots)
        (extract-instance-and-class-slotds (call-next-method))
      (setq instance-slots (sort-effective-instance-slotds instance-slots class cpl))
      (do* ((loc 1 (1+ loc))
            (islotds instance-slots (cdr islotds)))
           ((null islotds))
        (declare (fixnum loc))
        (setf (%slot-definition-location (car islotds)) loc))
      (dolist (eslotd class-slots)
        (setf (%slot-definition-location eslotd) 
              (assoc (%slot-definition-name eslotd)
                     (%class-get (%slot-definition-class eslotd)
				 :class-slots)
		     :test #'eq)))
      (append instance-slots class-slots))))

(defmethod compute-slots :around ((class structure-class))
  (let* ((slots (call-next-method))	 )
      (do* ((loc 1 (1+ loc))
            (islotds slots (cdr islotds)))
           ((null islotds) slots)
        (declare (fixnum loc))
        (setf (%slot-definition-location (car islotds)) loc))))

;;; Should eventually do something here.
(defmethod compute-slots ((s structure-class))
  (call-next-method))


(defmethod direct-slot-definition-class ((class structure-class) &rest initargs)
  (declare (ignore initargs))
  (find-class 'structure-direct-slot-definition))

(defmethod effective-slot-definition-class ((class structure-class) &rest initargs)
  (declare (ignore initargs))
  (find-class 'structure-effective-slot-definition))


(defmethod compute-default-initargs ((class slots-class))
  (let* ((initargs ()))
    (dolist (c (%class-precedence-list class) (nreverse initargs))
      (if (typep c 'forward-referenced-class)
	(error
	 "Class precedence list of ~s contains FORWARD-REFERENCED-CLASS ~s ."
	 class c)
	(dolist (i (%class-direct-default-initargs c))
	  (pushnew i initargs :test #'eq :key #'car))))))

(defun constantly (x)
  #'(lambda (&rest ignore)
      (declare (dynamic-extent ignore)
               (ignore ignore))
      x))


(defvar *update-slots-preserve-existing-wrapper* nil)

(defun update-slots (class eslotds)
  (let ((instance-slots (extract-instance-and-class-slotds eslotds)))
    (let* ((new-ordering
            (let* ((v (make-array (the fixnum (length instance-slots)))))
              (dolist (e instance-slots v)
                (setf (svref v
                             (the fixnum
                               (- (%slot-definition-location e) 1)))
                      (%slot-definition-name e)))))
           (old-wrapper (%class.own-wrapper class))
           ;(old-ordering (if old-wrapper (%wrapper-instance-slots old-wrapper)))
           (new-wrapper
            (cond ((null old-wrapper)
                   (%cons-wrapper class))
                  ((and old-wrapper *update-slots-preserve-existing-wrapper*)
                   old-wrapper)
                  #+ignore ;; lose this - from Gary
                  ((and (equalp old-ordering new-ordering)
                        (null class-slots))
                   old-wrapper)
                  (t
                   (make-instances-obsolete class)
                   ;;; Is this right ?
                   #|(%class.own-wrapper class)|#
                   (%cons-wrapper class)))))
      ;;; This is a crock: structure-classes should have slots ...
      (unless (<= (the fixnum (uvsize (instance.slots class))) %class.slots)
	(setf (%class.slots class) eslotds))
      (setf (%wrapper-instance-slots new-wrapper) new-ordering
	    (%wrapper-class-slots new-wrapper) (%class-get class :class-slots)
            (%class.own-wrapper class) new-wrapper)
      (setup-slot-lookup new-wrapper eslotds))))


  
(defun setup-slot-lookup (wrapper eslotds)
  (when eslotds
    (let* ((nslots (length eslotds))
	   (total-slot-ids (current-slot-index))
	   (small (< nslots 255))
	   (map
	    (if small
	      (make-array total-slot-ids :element-type '(unsigned-byte 8))
	      (make-array total-slot-ids :element-type '(unsigned-byte 32))))
	   (table (make-array (the fixnum (1+ nslots))))
	   (i 0))
      (declare (fixnum nslots total-slot-ids i) (simple-vector table))
      (setf (svref table 0) nil)
      (dolist (slotd eslotds)
	(incf i)
	(setf (svref table i) slotd)
	(setf (aref map
		    (slot-id.index
		     (standard-effective-slot-definition.slot-id slotd)))
	      i))
      (let* ((lookup-f (gvector :function
				(%svref (if small
					  #'%small-map-slot-id-lookup
					  #'%large-map-slot-id-lookup) 0)
				map
				table
				(dpb 1 $lfbits-numreq
				     (ash -1 $lfbits-noname-bit))))
	     (class (%wrapper-class wrapper))
	     (get-f (gvector :function
			     (%svref (if small
				       #'%small-slot-id-value
				       #'%large-slot-id-value) 0)
			     map
			     table
			     class
			     #'%maybe-std-slot-value-using-class
			     #'%slot-id-ref-missing
			     (dpb 2 $lfbits-numreq
				  (ash -1 $lfbits-noname-bit))))
	     (set-f (gvector :function
			     (%svref (if small
				       #'%small-set-slot-id-value
				       #'%large-set-slot-id-value) 0)
			     map
			     table
			     class
			     #'%maybe-std-setf-slot-value-using-class
			     #'%slot-id-set-missing
			     (dpb 3 $lfbits-numreq
				  (ash -1 $lfbits-noname-bit)))))
	(setf (%wrapper-slot-id->slotd wrapper) lookup-f
	      (%wrapper-slot-id-value wrapper) get-f
	      (%wrapper-set-slot-id-value wrapper) set-f
	      (%wrapper-slot-id-map wrapper) map
	      (%wrapper-slot-definition-table wrapper) table))))
  wrapper)

                       
    

(defmethod validate-superclass ((class class) (super class))
  (or (eq super *t-class*)
      (let* ((class-of-class (class-of class))
             (class-of-super (class-of super)))
        (or (eq class-of-class class-of-super)
            (and (eq class-of-class *standard-class-class*)
                 (eq class-of-super *funcallable-standard-class-class*))
            (and (eq class-of-class *funcallable-standard-class-class*)
                 (eq class-of-super *standard-class-class*))))))

(defmethod validate-superclass ((class std-class) (super forward-referenced-class))
  t)


(defmethod add-direct-subclass ((class class) (subclass class))
  (pushnew subclass (%class.subclasses class))
  subclass)

(defmethod remove-direct-subclass ((class class) (subclass class))
  (setf (%class.subclasses class)
        (remove subclass (%class.subclasses class)))
  subclass)

(defun add-direct-subclasses (class new)
  (dolist (n new)
    (unless (memq class (%class.subclasses  class))
      (add-direct-subclass n class))))

(defun remove-direct-subclasses (class old-supers new-supers)
  (dolist (o old-supers)
    (unless (memq o new-supers)
      (remove-direct-subclass o class))))

;;; Built-in classes are always finalized.
(defmethod class-finalized-p ((class class))
  t)

;;; Standard classes are finalized if they have a wrapper and that
;;; wrapper as an instance-slots vector; that implies that
;;; both UPDATE-CPL and UPDATE-SLOTS have been called on the class.
(defmethod class-finalized-p ((class std-class))
  (let* ((w (%class.own-wrapper class)))
    (and w (typep (%wrapper-instance-slots w) 'vector))))

(defmethod finalize-inheritance ((class std-class))
  (update-class class t))

(defmethod finalize-inheritance ((fwc forward-referenced-class))
  (error "~s can't be finalized." fwc))

(defmethod class-primary-p ((class std-class))
  (%class-primary-p class))

(defmethod (setf class-primary-p) (new (class std-class))
  (setf (%class-primary-p class) new))

(defmethod class-primary-p ((class class))
  t)

(defmethod (setf class-primary-p) (new (class class))
  new)


(defun forward-referenced-class-p (class)
  (typep class 'forward-referenced-class))

; This uses the primary class information to sort a class'es slots
(defun sort-effective-instance-slotds (slotds class cpl)
  (let (primary-slotds
        primary-slotds-class
        (primary-slotds-length 0))
    (declare (fixnum primary-slotds-length))
    (dolist (sup (cdr cpl))
      (unless (eq sup *t-class*)      
        (when (class-primary-p sup)
          (let ((sup-slotds (extract-instance-effective-slotds sup)))
            (if (null primary-slotds-class)
              (setf primary-slotds-class sup
                    primary-slotds sup-slotds
                    primary-slotds-length (length sup-slotds))
              (let ((sup-slotds-length (length sup-slotds)))
                (do* ((i 0 (1+ i))
                      (n (min sup-slotds-length primary-slotds-length))
                      (sup-slotds sup-slotds (cdr sup-slotds))
                      (primary-slotds primary-slotds (cdr primary-slotds)))
                     ((= i n))
                  (unless (eq (%slot-definition-name (car sup-slotds))
                              (%slot-definition-name (car primary-slotds)))
                    (error "While initializing ~s:~%~
                            attempt to mix incompatible primary classes:~%~
                            ~s and ~s"
                           class sup primary-slotds-class)))
                (when (> sup-slotds-length primary-slotds-length)
                  (setq primary-slotds-class sup
                        primary-slotds sup-slotds
                        primary-slotds-length sup-slotds-length))))))))
    (if (null primary-slotds-class)
      slotds
      (flet ((slotd-position (slotd)
               (let* ((slotd-name (%slot-definition-name slotd)))
                 (do* ((i 0 (1+ i))
                       (primary-slotds primary-slotds (cdr primary-slotds)))
                      ((= i primary-slotds-length) primary-slotds-length)
                   (declare (fixnum i))
                   (when (eq slotd-name
                                (%slot-definition-name (car primary-slotds)))
                   (return i))))))
        (declare (dynamic-extent #'slotd-position))
        (sort-list slotds '< #'slotd-position)))))


#|
(defun class-has-a-forward-referenced-superclass-p (class)
  (check-for-class-circle (%class-name class) class)
  (or (if (forward-referenced-class-p class) class)
      (dolist (s (%class-direct-superclasses class))
	(let* ((fwdref (class-has-a-forward-referenced-superclass-p s)))
	  (when fwdref (return fwdref))))))
|#

#|
(defun check-for-class-circle (name subclass)
  (dolist (s (%class-direct-subclasses subclass))
    (when (eq (%class-name s) name) (error "Circular class hierarchy for class ~S" s))
    (check-for-class-circle name s)))


(defun check-for-class-circle (name subclass)
  (dolist (s (%class-direct-subclasses subclass))
    (when (eq (%class-name s) name) (error "Circular class hierarchy for class ~S" s))
    (if (not (class-finalized-p s))(check-for-class-circle name s))))
|#

(defun update-cpl (class cpl)
  (if (class-finalized-p class)
    (unless (equal (%class.cpl class) cpl)
      (setf (%class.cpl class) cpl)
      #|(force-cache-flushes class)|#)
    (setf (%class.cpl class) cpl)))

;; from openMCL
(defun class-has-a-forward-referenced-superclass-p (original)
  (labels ((scan-forward-refs (class seen)
             (unless (memq class seen)
               (or (if (forward-referenced-class-p class) class)
                   (progn
                     (push class seen)
                     (dolist (s (%class-direct-superclasses class))
                       (when (eq s original)
                         (error "Circular class hierarchy: the class ~s is a superclass of at least one of its superclasses (~s)." original class))
                       (let* ((fwdref (scan-forward-refs s seen)))
                         (when fwdref (return fwdref)))))))))
    (scan-forward-refs original ())))


(defmethod compute-class-precedence-list ((class class))
  (let* ((fwdref (class-has-a-forward-referenced-superclass-p class)))
    (when fwdref
      (error "~&Class ~s can't be finalized because at least one of its superclasses (~s) is a FORWARD-REFERENCED-CLASS." class fwdref)))
  (compute-cpl class))

;;; Classes that can't be instantiated via MAKE-INSTANCE have no
;;; initargs caches.
(defmethod %flush-initargs-caches ((class class))
  )

;;; Classes that have initargs caches should flush them when the
;;; class is finalized.
(defmethod %flush-initargs-caches ((class std-class))
  (setf (%class.make-instance-initargs class) nil
	(%class.reinit-initargs class) nil
	(%class.redefined-initargs class) nil
	(%class.changed-initargs class) nil))


(defun update-class (class finalizep)
  ;;
  ;; Calling UPDATE-SLOTS below sets the class wrapper of CLASS, which
  ;; makes the class finalized.  When UPDATE-CLASS isn't called from
  ;; FINALIZE-INHERITANCE, make sure that this finalization invokes
  ;; FINALIZE-INHERITANCE as per AMOP.  Note, that we can't simply
  ;; delay the finalization when CLASS has no forward referenced
  ;; superclasses because that causes bootstrap problems.
  (when (and (not (or finalizep (class-finalized-p class)))
	     (not (class-has-a-forward-referenced-superclass-p class)))
    (finalize-inheritance class)
    (return-from update-class))
  (when (or finalizep
	    (class-finalized-p class)
	    (not (class-has-a-forward-referenced-superclass-p class)))
    (update-cpl class (compute-class-precedence-list  class))
    ;;; This -should- be made to work for structure classes
    (update-slots class (compute-slots class))
    (setf (%class-default-initargs class) (compute-default-initargs class))
    (%flush-initargs-caches class)
    )
  (unless finalizep
    (dolist (sub (%class-direct-subclasses class))
      (update-class sub nil))))


(defun check-duplicate-accessors (dslotds)  
  (while (cdr dslotds)
    (let* ((dslotd (car dslotds))
           (readers (%slot-definition-readers dslotd))
           (writers (%slot-definition-writers dslotd)))
      (dolist (reader readers)
        (dolist (later-slot (cdr dslotds))
          (when (memq reader (%slot-definition-readers later-slot))
            (warn "Reader ~s multiply defined" reader))))
      (dolist (writer writers)
        (dolist (later-slot (cdr dslotds))
          (when (member writer (%slot-definition-writers later-slot) :test #'equal)
            (warn "Writer ~s multiply defined" writer)))))
    (setq dslotds (cdr dslotds))))

(defun add-accessor-methods (class dslotds)
  (check-duplicate-accessors dslotds)
  (dolist (dslotd dslotds)
    (dolist (reader (%slot-definition-readers dslotd))
      (add-reader-method class			   
			 (ensure-generic-function reader)
			 dslotd))
    (dolist (writer (%slot-definition-writers dslotd))
      (add-writer-method class
			 (ensure-generic-function writer)
			 dslotd))))


(defun remove-accessor-methods (class dslotds)
  (dolist (dslotd dslotds)
    (dolist (reader (%slot-definition-readers dslotd))
      (remove-reader-method class (ensure-generic-function reader :lambda-list '(x))))
    (dolist (writer (%slot-definition-writers dslotd))
      (remove-writer-method class (ensure-generic-function writer :lambda-list '(x y))))))

(defmethod reinitialize-instance :before ((class std-class)  &key direct-superclasses)
  (remove-accessor-methods class (%class-direct-slots class))
  (remove-direct-subclasses class (%class-direct-superclasses class) direct-superclasses))
   
(defmethod shared-initialize :after
  ((class slots-class)
   slot-names &key
   (direct-superclasses nil direct-superclasses-p)
   (direct-slots nil direct-slots-p)
   (direct-default-initargs nil direct-default-initargs-p)
   (documentation nil doc-p)
   (primary-p nil primary-p-p))
  (declare (ignore slot-names))
  (if direct-superclasses-p
    (progn
      (setq direct-superclasses  ;; from openMCL
            (or direct-superclasses
                (list (if (typep class 'funcallable-standard-class)
                        *funcallable-standard-object-class*
                        *standard-object-class*))))
      #+ignore
      (setq direct-superclasses (or direct-superclasses
                                    (list *standard-object-class*)))
      (dolist (superclass direct-superclasses)
        (unless (validate-superclass class superclass)
          (error "The class ~S was specified as a~%super-class of the class ~S;~%~
                    but the meta-classes ~S and~%~S are incompatible."
                 superclass class (class-of superclass) (class-of class))))
      (setf (%class.local-supers class) direct-superclasses))
    (setq direct-superclasses (%class.local-supers class)))
  (setq direct-slots
	(if direct-slots-p
          (setf (%class.direct-slots class)
                (mapcar #'(lambda (initargs)
			    (make-direct-slot-definition class initargs))
			direct-slots))
          (%class.direct-slots class)))
  (if direct-default-initargs-p
      (setf (%class.local-default-initargs class)  direct-default-initargs)
      (setq direct-default-initargs (%class.local-default-initargs class)))
 (let* ((new-class-slot-cells ())
         (old-class-slot-cells (%class-get class :class-slots)))
    (dolist (slot direct-slots)
      (when (eq (%slot-definition-allocation slot) :class)
        (let* ((slot-name (%slot-definition-name slot))
               (pair (assq slot-name old-class-slot-cells)))
          ;;; If the slot existed as a class slot in the old
          ;;; class, retain the definition (even if it's unbound.)
          (unless pair
            (let* ((initfunction (%slot-definition-initfunction slot)))
              (setq pair (cons slot-name
                               (if initfunction
                                 (funcall initfunction)
                                 (%slot-unbound-marker))))))
          (push pair new-class-slot-cells))))
    (when new-class-slot-cells
      (setf (%class-get class :class-slots) new-class-slot-cells)))
  (when doc-p
    (set-documentation class 'type documentation))
  (when primary-p-p
    (setf (class-primary-p class) primary-p))

  (add-direct-subclasses class direct-superclasses)
  (update-class class nil)
  (add-accessor-methods class direct-slots))

(defmethod initialize-instance :before ((class class) &key &allow-other-keys)
  (setf (%class.ctype class) (make-class-ctype class)))

(defun ensure-class-metaclass-and-initargs (class args)
  (let* ((initargs (copy-list args))
         (missing (cons nil nil))
         (supplied-meta (getf initargs :metaclass missing))
         (supplied-supers (getf initargs :direct-superclasses missing))
         (supplied-slots (getf initargs :direct-slots missing))
         (metaclass (cond ((not (eq supplied-meta missing))
			   (if (typep supplied-meta 'class)
			     supplied-meta
			     (find-class supplied-meta)))
                          ((or (null class)
                               (typep class 'forward-referenced-class))
                           *standard-class-class*)
                          (t (class-of class)))))
    (declare (dynamic-extent missing))
    (flet ((fix-super (s)
             (cond ((classp s) s)
                   ((not (and s (symbolp s)))
                    (error "~s is not a class or a legal class name." s))
                   (t
                    (or (find-class s nil)
			(setf (find-class s)
			      (make-instance 'forward-referenced-class :name s))))))
           (excise-all (keys)
             (dolist (key keys)
               (loop (unless (remf initargs key) (return))))))
      (excise-all '(:metaclass :direct-superclasses :direct-slots))
      (values metaclass
              `(,@ (unless (eq supplied-supers missing)
                     `(:direct-superclasses ,(mapcar #'fix-super supplied-supers)))
                ,@ (unless (eq supplied-slots missing)
                     `(:direct-slots ,supplied-slots))
               ,@initargs)))))

;;; This defines a new class.
(defmethod ensure-class-using-class ((class null) name &rest keys &key &allow-other-keys)
  (multiple-value-bind (metaclass initargs)
      (ensure-class-metaclass-and-initargs class keys)
    (let* ((class (apply #'make-instance metaclass :name name initargs)))      
      (setf (find-class name) class))))

(defmethod ensure-class-using-class ((class forward-referenced-class) name &rest keys &key &allow-other-keys)
  (multiple-value-bind (metaclass initargs)
      (ensure-class-metaclass-and-initargs class keys)
    (apply #'change-class class metaclass initargs)
    (apply #'reinitialize-instance class initargs)
    (setf (find-class name) class)))
	   
;;; Redefine an existing (not forward-referenced) class.
(defmethod ensure-class-using-class ((class class) name &rest keys &key &allow-other-keys)
  (multiple-value-bind (metaclass initargs)
      (ensure-class-metaclass-and-initargs class keys)
    (unless (eq (class-of class) metaclass)
      (error "Can't change metaclass of ~s to ~s." class metaclass))
    (apply #'reinitialize-instance class initargs)
    (setf (find-class name) class)))


(defun ensure-class (name &rest keys &key &allow-other-keys)
  (let ((class (apply #'ensure-class-using-class (find-class name nil) name keys)))
    #|(update-class class nil)|#  ;; ??  moved to shared-initialize
    class))

#|
(defun ensure-class (name &rest keys &key &allow-other-keys)
  (apply #'ensure-class-using-class (find-class name nil) name keys))
|#


#|  ;; what ??
(defun slot-plist-from-%slotd (%slotd allocation)
  (destructuring-bind (name initform initargs . type) %slotd
    (let* ((initfunction (if (functionp initform)
                           initform
                           (if (consp initform)
                             (constantly (car initform))))))
      `(:name ,name :alllocation ,allocation :initargs ,initargs
        ,@(when initfunction `(:initfunction ,initfunction :initform ',initform))
        :type ,(or type t)))))
|#




(defmethod method-slot-name ((m standard-accessor-method))
  (standard-direct-slot-definition.name (%accessor-method.slot-definition m)))


(defun %ensure-class-preserving-wrapper (&rest args)
  (declare (dynamic-extent args))
  (let* ((*update-slots-preserve-existing-wrapper* t))
    (apply #'ensure-class args)))

(defun %find-direct-slotd (class name)
  (dolist (dslotd (%class.direct-slots class)
           (error "Direct slot definition for ~s not found in ~s" name class))
    (when (eq (%slot-definition-name dslotd) name)
      (return dslotd))))

(defun %add-slot-readers (class-name pairs)
  (let* ((class (find-class class-name)))
    (dolist (pair pairs)
      (destructuring-bind (slot-name &rest readers) pair
        (setf (%slot-definition-readers (%find-direct-slotd class slot-name)) readers)))
    (add-accessor-methods class (%class.direct-slots class))))

(defun %add-slot-writers (class-name pairs)
  (let* ((class (find-class class-name)))
    (dolist (pair pairs)
      (destructuring-bind (slot-name &rest readers) pair
        (setf (%slot-definition-writers (%find-direct-slotd class slot-name)) readers)))
    (add-accessor-methods class (%class.direct-slots class))))






(%ensure-class-preserving-wrapper
 'standard-method
 :direct-superclasses '(method)
 :direct-slots `((:name qualifiers :initargs (:qualifiers) :initfunction ,#'false :initform nil)
                 (:name specializers :initargs (:specializers) :initfunction ,#'false :initform nil)
                 (:name function :initargs (:function))
                 (:name generic-function :initargs (:generic-function) :initfunction ,#'false :initform nil)
                 (:name name :initargs (:name) :initfunction ,#'false :initform nil)
		 (:name lambda-list :initform nil :initfunction ,#'false
		  :initargs (:lambda-list)))
 :primary-p t)

(defmethod shared-initialize :after ((method standard-method)
                                     slot-names
                                     &key function &allow-other-keys)
  (declare (ignore slot-names))
  (when function
    (let* ((inner (closure-function function)))
      (unless (eq inner function)
	(copy-method-function-bits inner function)))    
    (lfun-name function method)))

;;; Reader & writer methods classes.
(%ensure-class-preserving-wrapper
 'standard-accessor-method
 :direct-superclasses '(standard-method)
 :direct-slots '((:name slot-definition :initargs (:slot-definition)))
 :primary-p t)

(%ensure-class-preserving-wrapper
 'standard-reader-method
 :direct-superclasses '(standard-accessor-method))

(%ensure-class-preserving-wrapper
 'standard-writer-method
 :direct-superclasses '(standard-accessor-method))

(defmethod reader-method-class ((class standard-class)
				(dslotd standard-direct-slot-definition)
				&rest initargs)
  (declare (ignore initargs))
  *standard-reader-method-class*)

(defmethod reader-method-class ((class funcallable-standard-class)
				(dslotd standard-direct-slot-definition)
				&rest initargs)
  (declare (ignore  initargs))
  *standard-reader-method-class*)


(defmethod add-reader-method ((class std-class) gf dslotd)
  (let* ((initargs
	  `(:qualifiers nil
	    :specializers ,(list class)
	    :lambda-list (x)
	    :name ,(function-name gf)
	    :slot-definition ,dslotd))
	 (method-class
	  (apply #'reader-method-class class dslotd initargs))	 
         (method (apply #'make-instance method-class
			:function (create-reader-method-function class (class-prototype method-class) dslotd)
			initargs)))
    (declare (dynamic-extent initargs))
    (add-method gf method)))

(defmethod remove-reader-method ((class std-class) gf)
  (let* ((method (find-method gf () (list class) nil)))
    (when method (remove-method gf method))))

(defmethod writer-method-class ((class standard-class)
				(dslotd standard-direct-slot-definition)
				&rest initargs)
  (declare (ignore initargs))
  *standard-writer-method-class*)

(defmethod writer-method-class ((class funcallable-standard-class)
				(dslotd standard-direct-slot-definition)
				&rest initargs)
  (declare (ignore initargs))
  *standard-writer-method-class*)

(defmethod add-writer-method ((class std-class) gf dslotd)
  (let* ((initargs
	  `(:qualifiers nil
	    :specializers ,(list *t-class* class)
	    :lambda-list (y x)
	    :name ,(function-name gf)
	    :slot-definition ,dslotd))
	 (method-class (apply #'writer-method-class class dslotd initargs))
	 (method 
	  (apply #'make-instance
		 method-class
		 :function (create-writer-method-function class (class-prototype method-class) dslotd)
		 initargs)))
    (declare (dynamic-extent initargs))
    (add-method gf method)))

(defmethod remove-writer-method ((class std-class) gf)
  (let* ((method (find-method gf () (list *t-class* class) nil)))
    (when method (remove-method gf method))))

;;; We can now define accessors.  Fix up the slots in the classes defined
;;; thus far.

(%add-slot-readers 'standard-method '((qualifiers method-qualifiers)
				      (specializers method-specializers)
				      (name method-name)
				      ;(function method-function)
				      (generic-function method-generic-function)
				      (lambda-list method-lambda-list)))

(%add-slot-writers 'standard-method '((function (setf method-function))
				      (generic-function (setf method-generic-function))))

(defmethod method-function ((m standard-method))
  (%method.function m))


(%add-slot-readers 'standard-accessor-method
		   '((slot-definition accessor-method-slot-definition)))

(%ensure-class-preserving-wrapper
 'specializer
 :direct-superclasses '(metaobject)
 :direct-slots `((:name direct-methods
		  :readers (specializer-direct-methods)
		  :initform nil :initfunction ,#'false))
 :primary-p t)
		  
(%ensure-class-preserving-wrapper
 'eql-specializer
 :direct-superclasses '(specializer)
 :direct-slots '((:name object :initargs (:object) :readers (eql-specializer-object)))
 :primary-p t)


(%ensure-class-preserving-wrapper
 'class
 :direct-superclasses '(specializer)
 :direct-slots
 `((:name prototype :initform nil :initfunction ,#'false)
   (:name name :initargs (:name) :initform nil :initfunction ,#'false :readers (class-name) :writers ((setf class-name)))
   (:name precedence-list :initargs (:precedence-list) :initform nil  :initfunction ,#'false)
   (:name own-wrapper :initargs (:own-wrapper) :initform nil  :initfunction ,#'false :readers (class-own-wrapper) :writers ((setf class-own-wrapper)))
   (:name direct-superclasses :initargs (:direct-superclasses) :initform nil  :initfunction ,#'false :readers (class-direct-superclasses))
   (:name direct-subclasses :initargs (:direct-subclasses) :initform nil  :initfunction ,#'false :readers (class-direct-subclasses))
   (:name dependents :initform nil :initfunction ,#'false)
   (:name class-ctype :initform nil :initfunction ,#'false))
 :primary-p t)


(%ensure-class-preserving-wrapper
 'forward-referenced-class
 :direct-superclasses '(class))



(%ensure-class-preserving-wrapper
 'built-in-class
 :direct-superclasses '(class))


(%ensure-class-preserving-wrapper
 'slots-class
 :direct-superclasses '(class)
 :direct-slots `((:name direct-slots :initform nil :initfunction ,#'false
		  ;; :initargs (:direct-slots)  ;; << remove
                  :readers (class-direct-slots))
                 (:name slots :initform nil :initfunction ,#'false
		  ;; Defining CLASS-SLOTS naively as a reader method
		  ;; can cause infinite recursion.
		  ;; (It'll be especially naive if there's a non-reader
		  ;; method defined on CLASS-SLOTS.)
		  ;; The fact that the slot is a primary slot
		  ;; saves the day (keeping us from trying to call
		  ;; CLASS-SLOTS inside SLOT-VALUE-USING-CLASS
		   :readers (class-slots))
		 (:name kernel-p :initform nil :initfunction ,#'false)
                 (:name direct-default-initargs :initargs (:direct-default-initargs) :initform nil  :initfunction ,#'false :readers (class-direct-default-initargs))
                 (:name default-initargs :initform nil  :initfunction ,#'false :readers (class-default-initargs))
                 (:name alist :initform nil  :initfunction ,#'false))
 :primary-p t)


; This class exists only so that standard-class & funcallable-standard-class
; can inherit its slots.
(%ensure-class-preserving-wrapper
 'std-class
 :direct-superclasses '(slots-class)
 :direct-slots `(
                 (:name make-instance-initargs :initform nil  :initfunction ,#'false)
                 (:name reinit-initargs :initform nil  :initfunction ,#'false)
                 (:name redefined-initargs :initform nil :initfunction ,#'false)
                 (:name changed-initargs :initform nil  :initfunction ,#'false))
 :primary-p t)



(%ensure-class-preserving-wrapper
 'standard-class
 :direct-superclasses '(std-class))

(%ensure-class-preserving-wrapper
 'funcallable-standard-class
 :direct-superclasses '(std-class))


(%ensure-class-preserving-wrapper
 'generic-function
 :direct-superclasses '(metaobject funcallable-standard-object)
 :metaclass 'funcallable-standard-class)

(%ensure-class-preserving-wrapper
 'standard-generic-function
 :direct-superclasses '(generic-function)
 :direct-slots `((:name name :initargs (:name) :readers (generic-function-name))
		 (:name method-combination :initargs (:method-combination)
                  :initform *standard-method-combination*
                  :initfunction ,#'(lambda () *standard-method-combination*)
		  :readers (generic-function-method-combination))
                 (:name method-class :initargs (:method-class)
                  :initform *standard-method-class*
                  :initfunction ,#'(lambda () *standard-method-class*)
		  :readers (generic-function-method-class))
		 (:name methods :initargs (:methods)
		  :initform nil :initfunction ,#'false
		  :readers (generic-function-methods))
		 (:name declarations
		  :initargs (:declarations)
		  :initform nil :initfunction ,#'false
		  :readers (generic-function-declarations))
                 (:name %lambda-list
                  :initform :unspecified
                  :initfunction ,(constantly :unspecified))
		 (:name dependents
		  :initform nil :initfunction ,#'false))
 :metaclass 'funcallable-standard-class
 :primary-p t)

(%ensure-class-preserving-wrapper
 'standard-generic-function
 :direct-superclasses '(generic-function)

 :metaclass 'funcallable-standard-class)

(%ensure-class-preserving-wrapper
 'structure-class
 :direct-superclasses '(slots-class))

(%ensure-class-preserving-wrapper
 'slot-definition
 :direct-superclasses '(metaobject)
  :direct-slots `((:name name :initargs (:name) :readers (slot-definition-name)
		  :initform nil :initfunction ,#'false)
		 (:name type :initargs (:type) :readers (slot-definition-type)
		  :initform t :initfunction ,#'true)
		 (:name initfunction :initargs (:initfunction) :readers (slot-definition-initfunction)
		  :initform nil :initfunction ,#'false)
		 (:name initform :initargs (:initform) :readers (slot-definition-initform)
		  :initform nil :initfunction ,#'false)
		 (:name initargs :initargs (:initargs) :readers (slot-definition-initargs)
		  :initform nil :initfunction ,#'false)
		 (:name allocation :initargs (:allocation) :readers (slot-definition-allocation)
		  :initform :instance :initfunction ,(constantly :instance))
		 (:name documentation :initargs (:documentation) :readers (slot-definition-documentation)
		  :initform nil :initfunction ,#'false)
		 (:name class :initargs (:class) :readers (slot-definition-class)))
  
 :primary-p t)

(%ensure-class-preserving-wrapper
 'direct-slot-definition
 :direct-superclasses '(slot-definition)
 :direct-slots `((:name readers :initargs (:readers) :initform nil
		  :initfunction ,#'false :readers (slot-definition-readers))
		 (:name writers :initargs (:writers) :initform nil
		  :initfunction ,#'false :readers (slot-definition-writers))))

(%ensure-class-preserving-wrapper
 'effective-slot-definition
 :direct-superclasses '(slot-definition)
 :direct-slots `((:name location :initform nil :initfunction ,#'false
		  :readers (slot-definition-location))
		 (:name slot-id :initform nil :initfunction ,#'false
                  :readers (slot-definition-slot-id))
		 (:name type-predicate :initform #'t-p
		  :initfunction ,#'(lambda () #'t-p)
		  :readers (slot-definition-predicate))
		 )
 
 :primary-p t)

(%ensure-class-preserving-wrapper
 'standard-slot-definition
 :direct-superclasses '(slot-definition)
)



(%ensure-class-preserving-wrapper
 'standard-direct-slot-definition
 :direct-superclasses '(standard-slot-definition direct-slot-definition)
)

(%ensure-class-preserving-wrapper
 'standard-effective-slot-definition
 :direct-superclasses '(standard-slot-definition effective-slot-definition)) 

                             



;; Fake method-combination
(defclass method-combination (metaobject) 
  ((name :accessor method-combination-name :initarg :name)))



(defclass standard-method-combination (method-combination) ())

(initialize-instance *standard-method-combination* :name 'standard)

(setq *standard-kernel-method-class*
  (defclass standard-kernel-method (standard-method)
    ()))

(unless *standard-method-combination*
  (setq *standard-method-combination*
        (make-instance 'standard-method-combination :name 'standard)))

; For %compile-time-defclass
(defclass compile-time-class (class) ())


(defclass structure-slot-definition (slot-definition) ())
(defclass structure-effective-slot-definition (structure-slot-definition
					       effective-slot-definition)
    ())

(defclass structure-direct-slot-definition (structure-slot-definition
					    direct-slot-definition)
    ())

(defmethod shared-initialize :after ((class structure-class)
                                     slot-names
                                     &key
                                     (direct-superclasses nil direct-superclasses-p)
				     &allow-other-keys)
  (declare (ignore slot-names))
  (labels ((obsolete (class)
             (dolist (sub (%class.subclasses class)) (obsolete sub))
             ;;Need to save old class info in wrapper for obsolete instance access...
             (setf (%class.cpl class) nil)))
    (obsolete class)
    (when direct-superclasses-p
      (let* ((old-supers (%class.local-supers class))
             (new-supers direct-superclasses))
        (dolist (c old-supers)
          (unless (memq c new-supers)
            (remove-direct-subclass c class)))
        (dolist (c new-supers)
          (unless (memq c old-supers)
            (add-direct-subclass c class)))
        (setf (%class.local-supers class) new-supers)))
    (unless (%class.own-wrapper class)
      (setf (%class.own-wrapper class) (%cons-wrapper class)))
    (update-cpl class (compute-cpl class))))
              

                                     
                                     
; Called from DEFSTRUCT expansion.
(defun %define-structure-class (sd)
  (let* ((dslots ()))
    (dolist (ssd (cdr (sd-slots sd)) (setq dslots (nreverse dslots)))
      (let* ((type (ssd-type ssd))
	     (refinfo (ssd-refinfo ssd)))
	(unless (logbitp $struct-inherited refinfo)
	  (let* ((name (ssd-name ssd))
		 (initform (cadr ssd))
		 (initfunction (constantly initform)))
	    (push `(:name ,name :type ,type :initform ,initform :initfunction ,initfunction) dslots)))))
    (ensure-class (sd-name sd)
		  :metaclass 'structure-class
		  :direct-superclasses (list (or (cadr (sd-superclasses sd)) 'structure-object))
		  :direct-slots  dslots 
		  )))



(defun standard-instance-access (instance location)
  (etypecase location
    (fixnum (%standard-instance-instance-location-access instance location))
    (cons (%cdr location))))

(defun (setf standard-instance-access) (new instance location)
  (etypecase location
    (fixnum (setf (standard-instance-instance-location-access instance location)
		  new))
    (cons (setf (%cdr location) new))))

(defun funcallable-standard-instance-access (instance location)
  (etypecase location
    (fixnum (%standard-generic-function-instance-location-access instance location))
    (cons (%cdr location))))

(defun (setf funcallable-standard-instance-access) (new instance location)
  (etypecase location
    (fixnum (setf (%standard-generic-function-instance-location-access instance location) new))
    (cons (setf (%cdr location) new))))


;;; Handle a trap from %slot-ref
(defun %slot-unbound-trap (slotv idx frame-ptr)
  (let* ((instance nil)
	 (class nil)
	 (slot nil))
    (if (and (eq (ppc-typecode slotv) ppc::subtag-slot-vector)
	     (setq instance (slot-vector.instance slotv))
	     (setq slot
		   (find idx (class-slots (setq class (class-of instance)))
			 :key #'slot-definition-location)))
      (slot-unbound class instance (slot-definition-name slot))
      (%error "Unbound slot at index ~d in ~s" (list idx slotv) frame-ptr))))


;;;
;;; Now that CLOS is nominally bootstrapped, it's possible to redefine some
;;; of the functions that really should have been generic functions ...
(setf (fdefinition '%class-name) #'class-name
      (fdefinition '%class-default-initargs) #'class-default-initargs
      (fdefinition '%class-direct-default-initargs) #'class-direct-default-initargs
      (fdefinition '(setf %class-direct-default-initargs))
      #'(lambda (new class)
	  (if (typep class 'slots-class)
	    (setf (slot-value class 'direct-default-initargs) new)
	    new))
      (fdefinition '%class-direct-slots) #'class-direct-slots
      (fdefinition '%class-slots) #'class-slots
      (fdefinition '%class-direct-superclasses) #'class-direct-superclasses
      (fdefinition '(setf %class-direct-superclasses))
      #'(lambda (new class)
	  (setf (slot-value class 'direct-superclasses) new))
      (fdefinition '%class-direct-subclasses) #'class-direct-subclasses)

  
(setf (fdefinition '%slot-definition-name) #'slot-definition-name
      (fdefinition '%slot-definition-type) #'slot-definition-type
      (fdefinition '%slot-definition-initargs) #'slot-definition-initargs
      (fdefinition '%slot-definition-allocation) #'slot-definition-allocation
      (fdefinition '%slot-definition-location) #'slot-definition-location
      (fdefinition '%slot-definition-readers) #'slot-definition-readers
      (fdefinition '%slot-definition-writers) #'slot-definition-writers)


(setf (fdefinition '%method-qualifiers) #'method-qualifiers
      (fdefinition '%method-specializers) #'method-specializers
      (fdefinition '%method-function) #'method-function
      (fdefinition '(setf %method-function)) #'(setf method-function)
      (fdefinition '%method-gf) #'method-generic-function
      (fdefinition '(setf %method-gf)) #'(setf method-generic-function)
      (fdefinition '%method-name) #'method-name
      (fdefinition '%method-lambda-list) #'method-lambda-list
      (fdefinition '%add-method) #'add-method
      )
		   
      
;;; Make a direct-slot-definition of the appropriate class.
(defun %make-direct-slotd (slotd-class &rest initargs)
  (declare (dynamic-extent initargs))
  (apply #'make-instance slotd-class initargs))

;;; Likewise, for an effective-slot-definition.
(defun %make-effective-slotd (slotd-class &rest initargs)
  (declare (dynamic-extent initargs))
  (apply #'make-instance slotd-class initargs))

;;; Likewise, for methods
(defun %make-method-instance (class &rest initargs)
  (apply #'make-instance class initargs))

(defmethod initialize-instance :after ((slotd effective-slot-definition) &key name)
  (setf (standard-effective-slot-definition.slot-id slotd)
        (ensure-slot-id name)))
  
(defmethod specializer-direct-generic-functions ((s specializer))
  (let* ((gfs ())
	 (methods (specializer-direct-methods s)))
    (dolist (m methods gfs)
      (let* ((gf (method-generic-function m)))
	(when gf (pushnew gf gfs))))))

(defmethod generic-function-lambda-list ((gf standard-generic-function))
  (%maybe-compute-gf-lambda-list gf (car (generic-function-methods gf))))

(defmethod generic-function-argument-precedence-order
    ((gf standard-generic-function))
  (let* ((req (required-lambda-list-args (generic-function-lambda-list gf)))
	 (apo (%gf-dispatch-table-precedence-list
	       (%gf-dispatch-table gf))))
    (if (null apo)
      req
      (mapcar #'(lambda (n) (nth n req)) apo))))

(defun normalize-egf-keys (keys gf) 
  (let* ((missing (cons nil nil))
	 (env (getf keys :environment nil)))
    (declare (dynamic-extent missing))
    (remf keys :environment)
    (let* ((gf-class (getf keys :generic-function-class missing))
	   (mcomb (getf keys :method-combination missing))
	   (method-class (getf keys :method-class missing)))
      (if (eq gf-class missing)
	(setf gf-class (if gf (class-of gf) *standard-generic-function-class*))
	(progn
	  (remf keys :generic-function-class)
	  (if (typep gf-class 'symbol)
	    (setq gf-class
		  (find-class gf-class t env)))
	  (unless (or (eq gf-class *standard-generic-function-class*)
		      (subtypep gf-class *generic-function-class*))
	    (error "Class ~S is not a subclass of ~S"
	           gf-class *generic-function-class*))))
      (unless (eq mcomb missing)
	(unless (typep mcomb 'method-combination)
	  (setf (getf keys :method-combination)
		(find-method-combination (class-prototype gf-class)
					 (car mcomb)
					 (cdr mcomb)))))
      (unless (eq method-class missing)
	(if (typep method-class 'symbol)
	  (setq method-class (find-class method-class t env)))
	(unless (subtypep method-class *method-class*)
	  (error "~s is not a subclass of ~s" method-class *method-class*))
	(setf (getf keys :method-class) method-class))
      (values gf-class keys))))
    
(defmethod ensure-generic-function-using-class
    ((gf null)
     function-name
     &rest keys
     &key
     &allow-other-keys)
  (declare (dynamic-extent keys))
  (multiple-value-bind (gf-class initargs)
      (normalize-egf-keys keys nil)
    (let* ((gf (apply #'make-instance gf-class
		      :name function-name
		      initargs)))
      (setf (fdefinition function-name) gf))))

(defmethod ensure-generic-function-using-class
    ((gf generic-function)
     function-name
     &rest keys
     &key
     &allow-other-keys)
  (declare (dynamic-extent keys) (ignorable function-name))
  (multiple-value-bind (gf-class initargs)
      (normalize-egf-keys keys gf)
    (unless (eq gf-class (class-of gf))
      (cerror (format nil "Change the class of ~s to ~s." gf gf-class)
	      "The class of the existing generic function ~s is not ~s"
	      gf gf-class)
      (change-class gf gf-class))
    (apply #'reinitialize-instance gf initargs)))

(defmethod initialize-instance :after ((gf standard-generic-function)
				       &key
				       (lambda-list nil ll-p)
				       (argument-precedence-order nil apo-p)
				       &allow-other-keys)
  (if (and apo-p (not ll-p))
    (error
     "Cannot specify :ARGUMENT-PRECEDENCE-ORDER without specifying :LAMBDA-LIST"))
  (if ll-p
    (progn
      (unless (verify-lambda-list lambda-list)
	(error "~s is not a valid generic function lambda list" lambda-list))
      (if apo-p
	(set-gf-arg-info gf :lambda-list lambda-list
			 :argument-precedence-order argument-precedence-order)
	(set-gf-arg-info gf :lambda-list lambda-list)))
    (set-gf-arg-info gf))
  (if (gf-arg-info-valid-p gf)
    (compute-dcode gf (%gf-dispatch-table gf)))
  gf)

(defmethod reinitialize-instance :after ((gf standard-generic-function)
					 &rest args
					 &key
					 (lambda-list nil ll-p)
					 (argument-precedence-order nil apo-p)
					 &allow-other-keys)
  (if (and apo-p (not ll-p))
    (error
     "Cannot specify :ARGUMENT-PRECEDENCE-ORDER without specifying :LAMBDA-LIST"))
  (if ll-p
    (progn
      (unless (verify-lambda-list lambda-list)
	(error "~s is not a valid generic function lambda list" lambda-list))
      (if apo-p
	(set-gf-arg-info gf :lambda-list lambda-list
			 :argument-precedence-order argument-precedence-order)
	(set-gf-arg-info gf :lambda-list lambda-list)))
    (set-gf-arg-info gf))
  (if (and (gf-arg-info-valid-p gf)
	   args
	   (or ll-p (cddr args)))
    (compute-dcode gf (%gf-dispatch-table gf)))
  (when (sgf.dependents gf)
    (map-dependents gf #'(lambda (d)
			   (apply #'update-dependent gf d args))))
  gf)
  

(defun decode-method-lambda-list (method-lambda-list)
  (flet ((bad ()
	   (error "Invalid lambda-list syntax in ~s" method-lambda-list)))
    (collect ((specnames)
                    (required))
       (do* ((tail method-lambda-list (cdr tail))
	     (head (car tail) (car tail)))
	    ((or (null tail) (member head lambda-list-keywords))
	     (if (verify-lambda-list tail)
	       (values (required) tail (specnames))
	       (bad)))
	 (cond ((atom head)
		(unless (typep head 'symbol) (bad))
		(required head)
		(specnames t))
	       (t
		(unless (and (typep (car head) 'symbol)
			     (consp (cdr head))
			     (null (cddr head)))
		  (bad))
		(required (car head))
		(specnames (cadr head))))))))
  
(defun extract-specializer-names (method-lambda-list)
  (nth-value 2 (decode-method-lambda-list method-lambda-list)))

(defun extract-lambda-list (method-lambda-list)
  (multiple-value-bind (required tail)
      (decode-method-lambda-list method-lambda-list)
    (nconc required tail)))

#| Redefine ensure-generic-function instead so it's clear from that code what's going on.
(setf (fdefinition '%ensure-generic-function-using-class)
      #'ensure-generic-function-using-class)
|#

; Redefine to call #'ensure-generic-function-using-class instead of % version
(defun ensure-generic-function (function-name &rest keys &key &allow-other-keys)
  (let* ((def (fboundp function-name)))
    (when (and def (not (typep def 'generic-function)))
      (cerror "Try to remove any global non-generic function or macro definition."
	      "~s is defined as something other than a generic function." function-name)
      (fmakunbound function-name)
      (setq def nil))
    (apply 'ensure-generic-function-using-class def function-name keys)))

(defmethod shared-initialize :after ((gf generic-function) slot-names
				     &key
				     (documentation nil doc-p))
  (declare (ignore slot-names))
  (when doc-p
    (if documentation (check-type documentation string))
    (set-documentation gf t documentation)))

(defmethod allocate-instance ((b built-in-class) &rest initargs)
  (declare (ignore initargs))
  (error "Can't allocate instances of BUILT-IN-CLASS."))

(defmethod reinitialize-instance ((m method) &rest initargs)
  (declare (ignore initargs))
  (error "Can't reinitialze ~s ~s" (class-of m) m))

(defmethod add-dependent ((class class) dependent)
  (pushnew dependent (%class.dependents class)))

(defmethod add-dependent ((gf standard-generic-function) dependent)
  (pushnew dependent (sgf.dependents gf)))

(defmethod remove-dependent ((class class) dependent)
  (setf (%class.dependents class)
	(delete dependent (%class.dependents class))))

(defmethod remove-dependent ((gf standard-generic-function) dependent)
  (setf (sgf.dependents gf)
	(delete dependent (sgf.dependents gf))))

(defmethod map-dependents ((class class) function)
  (dolist (d (%class.dependents class))
    (funcall function d)))

(defmethod map-dependents ((gf standard-generic-function) function)
  (dolist (d (sgf.dependents gf))
    (funcall function d)))

(defgeneric update-dependent (metaobject dependent &rest initargs))

(defmethod reinitialize-instance :after ((class std-class) &rest initargs)
  (map-dependents class #'(lambda (d)
			    (apply #'update-dependent class d initargs))))

;; should name be symbol?
(defmethod (setf class-name) (name (class class))
  (reinitialize-instance class :name name)
  (set-find-class name class)  ;; should reinitialize-instance do that
  name)



(defun %allocate-gf-instance (class)
  (unless (class-finalized-p class)
    (finalize-inheritance class))
  (let* ((wrapper (%class.own-wrapper class))
	 (len (length (%wrapper-instance-slots wrapper)))
	 (dt (make-gf-dispatch-table))
	 (slots (allocate-typed-vector :slot-vector (1+ len) (%slot-unbound-marker)))
	 (fn (gvector :function
		      *gf-proto-code*
                      wrapper
		      slots
                      dt
                      #'%%0-arg-dcode
		      0
		      ;; Set the AOK (&allow-other-keys) bit without
		      ;; setting the KEYS bit, to indicate that we
		      ;; don't know anything about this gf's
		      ;; lambda-list.
		      (logior (ash 1 $lfbits-gfn-bit)
			      (ash 1 $lfbits-aok-bit)))))
    (setf (gf.hash fn) (strip-tag-to-fixnum fn)
	  (slot-vector.instance slots) fn
	  (%gf-dispatch-table-gf dt) fn)
    (push fn (population.data %all-gfs%))
    fn))

(defmethod slot-value-using-class ((class structure-class)
				   instance
				   (slotd structure-effective-slot-definition))
  (let* ((loc (standard-effective-slot-definition.location slotd)))
      (typecase loc
	(fixnum
	 (struct-ref  instance loc))
	(t
	 (error "Slot definition ~s has invalid location ~s (allocation ~s)."
		slotd loc (slot-definition-allocation slotd))))))

;;; Some STRUCTURE-CLASS leftovers.
(defmethod (setf slot-value-using-class)
    (new
     (class structure-class)
     instance
     (slotd structure-effective-slot-definition))
  (let* ((loc (standard-effective-slot-definition.location slotd))
	 (type (standard-effective-slot-definition.type slotd)))
    (if (and type (not (eq type t)))
      (unless (or (eq new (%slot-unbound-marker))
		  (typep new type))
	(setq new (require-type new type))))
    (typecase loc
      (fixnum
       (setf (struct-ref instance loc) new))
      (t
       (error "Slot definition ~s has invalid location ~s (allocation ~s)."
	      slotd loc (slot-definition-allocation slotd))))))

(defmethod slot-boundp-using-class ((class structure-class)
				    instance
				    (slotd structure-effective-slot-definition))
  (declare (ignore instance))
  t)



;;; This has to be somewhere, so it might as well be here.
(defmethod make-load-form ((s slot-id) &optional env)
  (declare (ignore env))
  `(ensure-slot-id ,(slot-id.name s)))



#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
