;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: l1-dcode.lisp,v $
;;  Revision 1.9  2005/12/02 20:47:29  alice
;;  ; fix %%cnm-with-args-combined-method-dcode - check (and magic thing)
;;
;;  Revision 1.8  2004/04/16 22:47:07  alice
;;  %maybe-compute-gf-lambda-list - don't &allow-other-keys if keys
;;
;;  Revision 1.7  2004/03/25 23:59:54  alice
;;   03/25/04 correct compute-allowable-keywords-vector here now
;;
;;  Revision 1.6  2004/03/25 02:38:30  alice
;;  no change
;;
;;  Revision 1.5  2003/12/29 04:14:45  gtbyers
;;  Remove old reader-/writer-method dcode.
;;
;;  Revision 1.4  2003/12/08 08:28:22  gtbyers
;;  Lots and lots of changes.
;;
;;  2 10/5/97  akh  see below
;;  31 1/22/97 akh  probably no change
;;  27 6/16/96 akh  use faster generic-function protos
;;  25 5/20/96 akh  comment out some require-types
;;  20 3/19/96 akh  bills fixes to %find-nth-arg..., and find-dispatch-table-index
;;  17 3/9/96  akh  gary's changes for call-lexpr-tail-wise
;;                  a macro moves to level-2
;;  16 2/19/96 akh  some optimizations in %%1st/nth-arg-dcode
;;  15 2/8/96  akh  method => method-function in %call-methods
;;  12 1/28/96 akh  use lexpr vs dynamic-extent rest for gf and combined method args
;;                  gf and combined-methods are no longer closures
;;                  reinstate %%reader/writer-dcode
;;                  reinstate %%call-method (untested)
;;  11 12/1/95 akh  remove a dbg 
;;  9 10/31/95 akh  cpl-index => cpl-memq where that is sufficient
;;                  add blr
;;                  remove pseudo lexpr stuff
;;  7 10/23/95 akh  defppclapfunction,
;;  6 10/17/95 akh  standard-generic-function-p only true for outer function
;;                  magic is dynamic-extent cons vs list
;;  5 10/13/95 akh  fix make-n+1th-arg-combined-method - put combined method in dispatch table
;;  4 10/13/95 bill ccl3.0x25
;;  3 10/12/95 akh  cons-gf and combined-method back to putting name in  both inner and outer functions
;;  2 10/8/95  akh  no mo lap
;;  3 1/30/95  akh  nothing really
;;  (do not edit before this line!!)

;; l1-dcode.lisp
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995-1996 Digitool, Inc.


(in-package :ccl)

; Change log
; compute-allowable-keywords-vector - dont check (sgf.%lambda-list gf) ! 
; reinstate %%2nd-two-arg-dcode for writer methods - slightly faster
; ------- 5.2b6
; fix %%cnm-with-args-combined-method-dcode - check (and magic thing) 
;; -------- 5.1 final
; 03/25/04 correct compute-allowable-keywords-vector here now 
; 03/23/04 change migrated to method-combination.lisp
;; ----------
; 08/15/99 akh different solution for stream-writer => find-1st-arg-combined-method-2
;------- 4.3f1c31
; 09/23/98 akh find-1st-arg-combined-method-2 - doesn't compute a 1st-arg-combined method - for stream-writer fix
; 04/07/98 akh %call-next-method fix to not destructively modify closed over magic
; 11/27/97 akh make-eql-combined-method - fix when sub-dispatch? is true
; 09/15/97 akh  %%cnm-with-args-combined-method-dcode - tolerates thing being nil which it is
;                from %call-method* -> call-next-method-with-args 
; 01/01/97 bill %%reader-dcode-no-lexpr & %%writer-dcode-no-lexpr now work correctly for generic functions.
; 12/27/96 bill  New instance representation scheme (all instances have a forwarding pointer,
;                usually pointing to the instance itself).
; ------------- 4.0
; 09/13/96 bill %inited-class-cpl calls compute-cpl if it is called recursively on a class.
; 07/30/96 gb   dbg -> bug.
; 07/16/96 bill make *gf-proto* work with segmented VSP stack.
; 07/07/96 bill %apply-lexpr-tail-wise restores vsp relative to lisp-frame.savevsp, not
;               the lexpr itself. This makes it work with segmented stacks (the lexpr
;               may have moved).
; 06/03/96 bill Speed up %%reader-dcode & %%writer-dcode by making them go out of line less.
; ------------- MCL-PPC 3.9
; 03/25/96 bill %%check-keywords handles (progn (defmethod foo (x &optional y &key z) x) (foo 1))
; 03/18/96 bill Clean up and make more similar %find-xxx-arg-combined-method and
;               %%reader-dcode & %%writer-dcode.
; 03/07/96 bill x-%%check-keywords cddr's down the keywords list instead of cdr'ing
; 02/01/96 bill fix %cons-magic-next-method-arg.
;               Don't call it from %no-next-method.
; 01/30/96 gb  *gf-proto* : not #.(defppclapfunction ...)
; 11/24/95 akh grow-gf-dispatch-table - remove a dbg
; 11/02/95 gb   at most one #'copy-closure-inner.  Off-by-one in ppc SET-IMMEDIATE-n.
; 10/13/95 bill %cons-combined-method stores the gf as the function name, not the gf's name.
; 07/19/93 bill in make-standard-combined-method - ok-if-no-primaries defaults correctly.
;               speed up and reduce consing for no-applicable-method dispatch.
; 07/07/93 bill Larger *max-gf-dispatch-table-size*. "asr" -> "asr.l" in find-gf-dispatch-table-index.
;               grow-gf-dispatch-table takes an obsolete-wrappers-p arg supplied as the
;               second return value from find-gf-dispatch-table-index. If it is true, the
;               table is rehashed, but not grown.
; ------------- 3.0d11 
; 05/23/93 alice string< -> string-lessp, nuke def of string<
; ------------- 3.0d9
; 06/01/93 bill cnm-with-args-check-initargs special cases shared-initialize & update-instance-for-redefined-class
; ------------- 2.1d6
; 04/30/93 bill make-eql-combined-method now delays no-applicable-primary-method
;               error until run-time. Used to happen at method-combination
;               time when there were applicable primary EQL methods, but
;               no other applicable primary methods.
; ------------- 2.1d4
; 04/02/93 bill cnm-with-args-check-initargs now special cases update-instance-for-different-class
; 02/17/93 bill $sp-spreadargZ -> $sp-spreadargZ-vextend
; 03/25/92 bill %set-gf-dcode, %set-gf-dispatch-table, %set-combined-method-methods
;               now clear a couple of cache lines.
; 03/20/92 bill %0-arg-combined-method-trap was calling sort on the
;               method list directly. Now it does copy-list first.
; ------------- 2.0f3
; 01/23/92 bill in make-standard-combined-method: don't check keywords
;               if there are no applicable methods.
; 01/07/92 bill %no-next-method no longer conses.
; 12/10/91 gb   no ralph bit.
; -------- 2.0b4
; 08/26/91 bill remove commented out debugging code
; 08/24/91 gb   use new trap syntax.
; 07/21/91 gb   simpler lap without-interrupts .
; 07/25/91 bill reader-trap-2 now caches slot numbers for forwarded instances.
; 07/05/91 bill readers & writers really work for standard-generic-functions
; 06/25/91 bill readers & writers work for standard-generic-functions
;               %inited-class-cpl takes an optional initialize-can-fail arg
;-------------- 2.0b2
; 05/28/91 bill in make-eql-combined-method: sort is a destructive operation.
; 03/28/91 bill Don't need (%fhave 'function-encapsulation ...) here.
; 03/27/91 bill Call no-applicable-method only if there is NO applicable method,
;               Otherwise signal an error with no-applicable-primary-method.
; 03/26/91 bill %call-next-method and friends notice NIL for the magic arg
;               as meaning that method-combination screwed up.
; 03/25/91 bill %compute-applicable-methods -> %compute-applicable-methods+
; 03/20/91 bill slot-name -> method-slot-name
; 03/14/91 bill finally generic-functions with no specializers: %%0-arg-dcode
; 03/05/91 bill %cons-no-applicable-method replaces simple closure
;               to make these things uniquely recognizeable.
; 02/28 91 bill Support for user generic-function types:
;                 %gf-instance
; 02/20/91 bill compute-method-list errors on unknown method qualifiers
;               methods-with-qualifier no longer used.
; 02/15/91 bill Split this file off from l1-clos
; 02/08/91 bill assq -> %find-slotd where appropriate.
;               compute-cpl shares structure when possible.
; 02/22/91 gb - fix nilreg=>acc after swapin in 3 predicates
;-------------------- 2.0b1
; 01/28/91 bill CLASS-direct-methods, CLASS-direct-generic-functions -> SPECIALIZER-direct-xxx
;               eliminate %map-lfuns with %all-gfs%.
;               Use weak lists for %class-direct-methods.
; 01/21/91 bill If no-next-method returns values, they will become the values of
;               call-next-method.
;               multi-method-index was brain-damaged.
;               If no-applicable-method returns, its values will be returned
;               vice crashing.
;               The combined-method in the no-applicable-method case is a 
;               closure.  grow-gf-dispatch-table eliminates all such closures.
;               Hence, if somebody really uses no-applicable-method, they'll
;               get speed, but extraneous no-applicable-method closures can disappear.
;               %%slot-setf-dcode and its class are no more.
;               %%writer-dcode changes to take the new value as first arg.
; 01/07/91 bill record-accessor-methods updated for changed DEFCLASS
; 12/31/90 gb   Nail down some of CLOS.
; 12/12/90 bill record-accessor-methods
; 12/11/90 bill nreconc got make-eql-combined-method in trouble
; 12/01/90 bill Return value of SLOT-UNBOUND from %%reader-dcode.
;               Still don't handle SLOT-MISSING correctly there, though
;               it can rarely happen.
;               Nuked BAD-SLOT.
; 11/28/90 bill sort-methods in make-eql-combined-method.  EQL macptr's may not be EQ
;               multi-method-index returns 0 vice NIL for uni-methods.
; 11/29/90 gb   %%class-of recognizes evaluated functions, closures.
; 11/16/90 bill remove-obsoleted-combined-methods installs *obsolete-wrapper*
;               over all obsolete wrappers.
; 11/07/90 bill find-gf-dispatch-table-index checks for existence of the wrapper
;               it's trying to insert.  Also, no more multiply & divide: hard
;               code 3/4 full as the threshold
;               Brain-damage in find-1st-arg-combined-method.
; 10/31/90 gb   %cons-gf sets $lfatr-resident-bit.
; 10/29/90 bill remove-obsoleted-combined-methods needed to check for
;               *obsolete-wrapper*, and install it instead of NIL.
; 10/25/90 gz   unsigned long vectors.
; 10/25/90 bill find-gf-dispatch-table-index erroneously removed wrappers from
;               the dispatch-table.  Replace with *obsolete-wrapper* instead.
;               Limit dispatch-table size in grow-gf-dispatch-table
; 10/24/90 bill in initialize-class: local slots come before inherited ones again:
;               it's easier to find them when you inspect a class.
; 10/20/90 bill with-accessors.
; 10/16/90 gb   no more short vectors.
; 10/16/90 bill call eventch_jmp in the slot accessor dcode.  Otherwise
;               (loop (wptr w)) is uninterruptable.
; 10/12/90 bill coplete stack frame before erroring in %tail-call-next-method
; 10/08/90 bill do not stack-cons the rest arg in no-applicable-method
; 10/05/90 bill eliminate preserve_regs so we can restart across method-dispatch
; 10/03/90 bill circular class hierarchy error in initialize-class,
;               %class-cpl -> %inited-class-cpl where appropriate.
; 10/01/90 bill funcall-if-method-exists
; 10/01/90 bill update-obsolete-instance bug, prettify no-applicable-method message.
; 09/30/90 bill slot accessors & writers are optimized now:
;               %%reader-dcode, %%writer-dcode, %%slot-setf-dcode, compute-dcode.
;               make find-gf-dispatch-table-index delete obsolete wrappers.
; 09/28/90 bill type-check in clear-class-direct-methods-caches.
;               Remove cell in bootstrapping set-find-class if class is NIL.
; 09/27/90 bill %nth-arg-dcode brain-damage in update-obsolete-instance arg
; 09/26/90 bill %add-method neglected to clear the gf back-pointer in a replaced method.
; 09/24/90 bill in %cons-combined-method - no longer add a required arg.
; 09/21/90 bill add *istruct-class* to CPL's where it belongs.
; 09/19/90 bill punt class-prototype of built-in-class'es
;               *built-in-class-wrapper* is the %instance-class-wrapper of built-in classes
; 08/29/90 alice add methods-congruent-p, pass the actual method to record-source-file
; 09/14/90 bill Don't cons a class-prototype in initialize-class-and-wrapper
; 09/11/90 bill initargs-vector comes out from check-initargs.
;               class-make-instance-initargs.
; 08/30/90 bill Bad keys error messages need to bind *print-array* to true.
; 08/30/90 bill Give slots to the classes that should have them.
;               This allows subclassing of standard-method, class, standard-class
; 08/28/90 bill Store magic next-method arg in $vc.saved_method_var vice da.
; 08/25/90 bill Look inside of closed-over method-function's to get the lfun-bits.
; 08/24/90 bill *compiled-lexical-closure-class*, *interpreted-lexical-closure-class*,
;               *interpreted-function-class*, *funcallable-instance-class*
; 08/21/90 bill Allow DEFMETHOD multiple times from inside a compiled function.
; 08/16/90 bill add default arg to slot-value-if-bound
; 08/10/90 bill  cerror for defmethod on a non-generic function or non-congruent
;                lambda-list.  *defmethod-congruency-override*
; 08/03/90 bill  Fix of bug no longer causes :class slot-values to disappear.
; 08/02/90 gb    jmp (better safe than sorry) in %%class-of, access new package cell therein.
; 07/24/90 bill  bug in initialize-class caused incorrect sharing of :class slot after:
;                (defclass foo () ((bar :allocation :class))) 
;                (defclass foo1 (foo) ())
;                (defclass foo1 (foo) ((bar :allocation :class)))
; 07/05/90 bill  clear-class-direct-methods-caches, clear-gf-cache in ensure-generic-function
; 07/04/90 bill  New lfun-bits to distinguish call-next-method with & without args
;                argument-precedence-order now supported.
; 07/03/90 bill  keys & applicable-methods checking for call-next-method-with-args
; 06/30/90 bill  unwind-protect the body of %call-next-method.
;                %method-name now stored in the method.  method-function points back.
; 06/28/90 bill  Update for new magic-next-method-arg in atemp0 protocol.
; 06/26/90 bill  class-direct-methods, class-direct-generic-functions.
; 06/25/90 bill  clear-valid-initargs-caches, clear-clos-caches.
; 06/22/90 bill  initargs checking, aux-init-functions.
; 06/21/90 bill  lap implementation of keyword checking.
;                (class-of (the lfun-vector v)) cannot be a method.
; 06/20/90 bill  lisp implementation of keyword checking.
; 06/13/90 gz    A bootstrapping %[set-]defgeneric-methods.
; 06/13/90 bill  add defgeneric keys to lambda-list congruency testing.
; 06/07/90 alice mess around with %defmethod
; 06/07/90 bill *combined-methods* hash table is weak on value (along with
;               a good part of the rest of the world).
; 06/05/90 bill make-instance-internal goes in-line in make-instance.
;               in (method make-instance (standard-class)):
;                  %allocate-instance -> allocate-instance
; 06/04/90 bill add-method, method-qualifiers, no-applicable-method
;               error-ignoring-without-interrupts -> error
;               Fix bug when an eql method exists, but no primary for
;               class of the eql arg.
; 06/02/90 bill class-precedence-list, compute-applicable-methods, fix EQL
;               specializer bug in SORT-METHODS for uni-methods.
;               More %method< brain-damage.
;               Finish class-prototype.
; 06/01/90 bill ensure-generic-function, support for defgeneric.
; 05/30/90 gb   new %call-next-method, %cons-magic-next-method-arg per bill.
; 05/30/90 bill %define-structure-class
;               Remove STANDARD-OBJECT from the CPL of METAOBJECT.  This leaves
;               CLASS & METHOD with CPL's that disagree with the standard, where
;               they'll stay until I make them instantiable.
; 05/29/90 bill Eliminate first cons in heap-consed magic arg.  sp -> vsp in
;               %call-next-method.  %call-next-method now checks for args.
;               remove-method, function-keywords
; 05/27/90 gb   perform unspeakable acts on %call-next-method(-with-args).
; 05/25/90 alice bugger %defmethod and %method-name for encapsulations
; 05/25/90 bill %cons-magic -> %cons-magic-mext-method-arg & it works right now.
;               no-next-method as per the spec.
; 05/24/90 bill brain-damaged %method<
; 05/22/90 gb   no more symtagp.
; 05/21/90 bill shared-initialize returns its instance arg.
; 05/05/90 bill 68000 caught %add-method taking the %cadr of a non-list.
; 5/3/90   gz   old-lap[-inline]
; 04/30/90 gb   lap syntax, character types, sort-methods with stack-consed closures.
; 04/30/90 gz   Make (set-find-class name nil) dtrt.
; 04/20/90 gz   logical-pathname class.
; 04/10/90 bill *forwarding-wrapper-hash-table* not inited before %forward-instance sometimes.
; 03/31/90 gz   Added classes for keywords and standard-chars.  Kinda silly but
;               makes some other things easier...
; 03/25/90 gz   Split off built-in-type-p.  Added (find-class 'compiled-function).
;               Removed *object-class* (object-lisp objects).
; 03/08/90 bill find-method, :method abortion
; 03/02/90 bill change-class, update-instance-for-different-class
; 02/28/90 bill Speed up %slot-value & set-slot-value with a DBEQ loop.
;               Add slot-missing as per spec.
;               In %defclass: check local supers for forward-reference.
; 02/08/90 bill Remove FIND from slot-exists-p
; 02/07/90 bill Add with-slots & %gf-methods
; 01/05/90 bill Correct result for slot-makunbound.
; 02/02/90 gz   Added find-1st-arg-combined-method for the reader.
; 01/05/90 gz   added clear-gf-cache.
;               More watching out for swappable lfuns (in combined-method-trap's)
; 12/27/89 gz	methods are now instances.  Don't allow class names the same as
;		DEFTYPE names.
; 12/22/89 bill Add %remove-method.  store-generic-setf-method moved from level-2.
; 12/20/89 gz   Watch out for swappable lfuns, nilreg value cells.
;               Use lfuns rather than symbols for dcode.
;		Use defsetf where appropriate.
; 12/06/89 bill Merge in the new gf dispatch code.
; 11/30/89 bill Add make-instances-obsolete and change %defclass to use it.
; 11/19/89 gz   put 'setf-inverse -> defsetf.
; 11/13/89 bill Add %set-combined-method-methods
; 10/31/89 bill Add $lfbits-ralph-bit to standard-generic-function-p and friends.
; 10/27/89 bill %clear-gf-caches: check for new-style gf's
; 10/21/89 bill The CLOS class structure is now as the MOP needs it to be.
; 10/19/89 bill Convert over to new methods as the lfun-vectors of the old methods.
; 10/18/89 bill Add initialize-class-and-wrapper.  Make %allocate-instance,
;               %slot-value, & set-slot value use the slot info in the new
;               wrapper structure.  Make %defclass obsolete the new wrapper
;               appropriately via make-wrapper-obsolete.
;               Make methods not functionp
; 10/17/89 bill Fix %class-instance-slotds access in %allocate-instance.
; 10/14/89 bill Update for expanded class structure.
; 10/01/89 bill %add-method: prevent multiple instances of (eql foo)
; 9/28/89  gb   unsigned short, byte vectors.
; 09/26/89 bill Add slot-exists-p, obsolete-instance-slot-exists-p.
;               Break update-obsolete-instance out of obsolete-instance-...
; 09/17/89  gz  Define union, let it get replaced.
; 09/15/89 bill Change union to clos-union: union is in level-2
; 09/13/89 bill Added obsolete-instance-slot-value-first-message and enabled
;               *assume-obsolete-instances-are-true*.  This is not safe, but
;               is usually what you want while debugging.
; 09/12/89 bill Added bad-slot
; 09/12/89 bill Add kluged obsolete-instance-set-slot-value.
; 09/11/89 gz   flesh out type-intersect.
; 09/09/89 bill Remove typep from %defmethod: typep doesn't exist at boot time
; 09/01/89 bill Added obsolete-instance-slot-value
;               This is a kluge version that merely validates all instances
;               that come to it.  Works correctly if the instance variables
;               were not changed by the new defclass.
; 08/31/89 bill added method-exists-p
; 08/30/89 bill %defmethod: update record-source-file call to pass name of first specifier as class
;               This will change to include all specializers when toy CLOS supports it.
;               Needs to eventually support qualifiers, too.
; 08/29/89 bill Make shared slots work like the spec, not PCL (e.g. if a class inherits a
;               shared slot, the value cell for that slot is in the inherited class'es structure):
;               initialize-class, %slot-value, set-slot-value, set-class-slot-value
;               Note: the %slotd-value of a shared slot's slotd is now a list, the car of which
;               is the value.  This allows sharing of the value cell.
; 08/25/89 bill with-slot-values macro: cheap read-only with-slots.
; 08/25/89 bill type-intersect stub works only for non-specified types
; 08/29/89 gb   no more function-binding.
; 07/30/89 bill Add inputs description to %%1st-arg-dcode.
;               Put in missing call of primary method if there are
;               after methods & only one applicable primary (NOUSUAL).
; 07/28/89 gz default-initargs
; 07/27/89 gz %call-next-method-with-args, easy case...
; 07/20/89 gz fix in %1st-arg-no-usual-dcode for EQL specializers.
; 7/14/89  bill Clear the cache in %add-method
; 7/7/89   bill Add slot-unbound.  Change call in slot-value to use class arg
; 06/30/89 bill in %defclass: (documentation class ..) -> (documentation class-name ..)
; 05/19/89 gz record source file for methods. Initialize class in
;             %allocate-instance. Added set-class-slot-value.
; 04/08/89 gz Fleshed out class-of. $sp-clrcache in %set-gf-dcode.
;             added subclassp.
;04/07/89 gb  $sp8 -> $sp.
; 03/03/89 gz New

(defun %make-gf-instance (class &key
                                name
                                (method-combination *standard-method-combination* mcomb-p)
                                (method-class *standard-method-class* mclass-p)
                                declarations
                                (lambda-list nil ll-p)
                                (argument-precedence-order nil apo-p)
                                &allow-other-keys)
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
      (error "~s is not a proper list" declarations)))
  ;; Fix APO, lambda-list
  (if apo-p
    (if (not ll-p)
      (error "Cannot specify ~s without specifying ~s" :argument-precedence-order
	     :lambda-list)))
  (let* ((gf (%allocate-gf-instance class)))
    (setf (sgf.name gf) name
          (sgf.method-combination gf) method-combination
          (sgf.methods gf) nil
          (sgf.method-class gf) method-class
          (sgf.decls gf) declarations
          (sgf.%lambda-list gf) :unspecified
	  (sgf.dependents gf) nil)
    (when ll-p
      (if apo-p
        (set-gf-arg-info gf :lambda-list lambda-list
                         :argument-precedence-order argument-precedence-order)
        (set-gf-arg-info gf :lambda-list lambda-list)))
    gf))

(defun gf-arg-info-valid-p (gf)
  (let* ((bits (lfun-bits gf)))
    (declare (fixnum bits))
    (not (and (logbitp $lfbits-aok-bit bits)
	      (not (logbitp $lfbits-keys-bit bits))))))

(defun %maybe-compute-gf-lambda-list (gf method)
  (let* ((gf-ll (sgf.%lambda-list gf)))
    (if (eq gf-ll :unspecified)
      (and method
           (let* ((method-lambda-list (%method-lambda-list method))
                  (method-has-&key (member '&key method-lambda-list)))
             (declare (ignore-if-unused method-has-&key))
             (if nil ;method-has-&key ;; << ugh omitting this causes boot to fail
               ;; Treat gf lambda-list as (... &key &allow-other-keys)
               (nconc (ldiff method-lambda-list (cdr method-has-&key))
                      '(&allow-other-keys))
               method-lambda-list)))
      gf-ll)))
             
             
;;; Borrowed from PCL, sort of.  We can encode required/optional/restp/keyp
;;; information in the gf's lfun-bits
(defun set-gf-arg-info (gf &key new-method (lambda-list nil lambda-list-p)
                           (argument-precedence-order nil apo-p))
  (let* ((methods (%gf-methods gf))
         (dt (%gf-dispatch-table gf))
         (gf-lfun-bits (lfun-bits gf))
         (first-method-p (and new-method (null methods))))
    (declare (fixnum gf-lfun-bits))
    (unless lambda-list-p
      (setq lambda-list
            (%maybe-compute-gf-lambda-list gf (or (car (last methods))
                                                  new-method))))
    (when (or lambda-list-p
              (and first-method-p
                   (eq (%gf-%lambda-list gf) :unspecified)))
      (multiple-value-bind (newbits keyvect)
          (encode-lambda-list lambda-list t)
        (declare (fixnum newbits))
        (when (and methods (not first-method-p))
          (unless (and (= (ldb $lfbits-numreq gf-lfun-bits)
                          (ldb $lfbits-numreq newbits))
                       (= (ldb $lfbits-numopt gf-lfun-bits)
                          (ldb $lfbits-numopt newbits))
                       (eq (or (logbitp $lfbits-keys-bit gf-lfun-bits)
                               (logbitp $lfbits-rest-bit gf-lfun-bits)
                               (logbitp $lfbits-restv-bit gf-lfun-bits))
                           (or (logbitp $lfbits-keys-bit newbits)
                               (logbitp $lfbits-rest-bit newbits)
                               (logbitp $lfbits-restv-bit newbits))))
            (error "New lambda list ~s of generic function ~s is not
congruent with lambda lists of existing methods." lambda-list gf)))
        (when lambda-list-p
          (setf (%gf-%lambda-list gf) lambda-list
                (%gf-dispatch-table-keyvect dt) keyvect))
        (when (and apo-p lambda-list-p)
          (setf (%gf-dispatch-table-precedence-list dt)
                (canonicalize-argument-precedence-order
                 argument-precedence-order
                 (required-lambda-list-args lambda-list))))
        (lfun-bits gf (logior (ash 1 $lfbits-gfn-bit)
                              (logand $lfbits-args-mask newbits)))))
    (when new-method
          (check-defmethod-congruency gf new-method))))
        
(defun %gf-name (gf &optional (new-name nil new-name-p))
  (let* ((old-name (%standard-generic-function-instance-location-access
                    gf sgf.name)))
    (if new-name-p
      (setf (sgf.name gf) new-name))
    (unless (eq old-name (%slot-unbound-marker))
      old-name)))



	     
(defun make-n+1th-arg-combined-method (methods gf argnum)
  (let ((table (make-gf-dispatch-table)))
    (setf (%gf-dispatch-table-methods table) methods
          (%gf-dispatch-table-argnum table) (%i+ 1 argnum))
    (let ((self (%cons-combined-method gf table #'%%nth-arg-dcode))) ; <<
      (setf (%gf-dispatch-table-gf table) self)
      self)))

;Bring the generic function to the smallest possible size by removing
;any cached recomputable info.  Currently this means clearing out the
;combined methods from the dispatch table.

(defun clear-gf-cache (gf)
  #-bccl (unless t (typep gf 'standard-generic-function) 
           (report-bad-arg gf 'standard-generic-function))
  (let ((dt (%gf-dispatch-table gf)))
    (if (eq (%gf-dispatch-table-size dt) *min-gf-dispatch-table-size*)
      (clear-gf-dispatch-table dt)
      (let ((new (make-gf-dispatch-table)))
        (setf (%gf-dispatch-table-methods new) (%gf-dispatch-table-methods dt))
        (setf (%gf-dispatch-table-precedence-list new)
              (%gf-dispatch-table-precedence-list dt))
        (setf (%gf-dispatch-table-gf new) gf)
        (setf (%gf-dispatch-table-keyvect new)
              (%gf-dispatch-table-keyvect dt))
        (setf (%gf-dispatch-table-argnum new) (%gf-dispatch-table-argnum dt))
        (setf (%gf-dispatch-table gf) new)))))

(defun grow-gf-dispatch-table (gf-or-cm wrapper table-entry &optional obsolete-wrappers-p)
  ; Grow the table associated with gf and insert table-entry as the value for
  ; wrapper.  Wrapper is a class-wrapper.  Assumes that it is not obsolete.
  (let* ((dt (if (standard-generic-function-p gf-or-cm)
               (%gf-dispatch-table gf-or-cm)
               (%combined-method-methods gf-or-cm)))  ; huh
         (size (%gf-dispatch-table-size dt))
         (new-size (if obsolete-wrappers-p
                     size
                     (%i+ size size)))
         new-dt)
    (if (> new-size *max-gf-dispatch-table-size*)
      (progn 
        (when (not (fixnump (%gf-dispatch-table-mask dt)))(bug "906")) ; cant be right that its so big
        (setq new-dt (clear-gf-dispatch-table dt)
                   *gf-dt-ovf-cnt* (%i+ *gf-dt-ovf-cnt* 1))
        (when (not (fixnump (%gf-dispatch-table-mask new-dt)))(bug "903")))
      (progn
        (setq new-dt (make-gf-dispatch-table new-size))
        (setf (%gf-dispatch-table-methods new-dt) (%gf-dispatch-table-methods dt)
              (%gf-dispatch-table-precedence-list new-dt) (%gf-dispatch-table-precedence-list dt)
              (%gf-dispatch-table-keyvect new-dt) (%gf-dispatch-table-keyvect dt)
              (%gf-dispatch-table-gf new-dt) gf-or-cm
              (%gf-dispatch-table-argnum new-dt) (%gf-dispatch-table-argnum dt))
        (let ((i 0) index w cm)
          (dotimes (j (%ilsr 1 (%gf-dispatch-table-size dt)))
	    (declare (fixnum j))
            (unless (or (null (setq w (%gf-dispatch-table-ref dt i)))
                        (eql 0 (%wrapper-hash-index w))
                        (no-applicable-method-cm-p
                         (setq cm (%gf-dispatch-table-ref dt (%i+ i 1)))))
              (setq index (find-gf-dispatch-table-index new-dt w t))
              (setf (%gf-dispatch-table-ref new-dt index) w)
              (setf (%gf-dispatch-table-ref new-dt (%i+ index 1)) cm))
            (setq i (%i+ i 2))))))
    (let ((index (find-gf-dispatch-table-index new-dt wrapper t)))
      (setf (%gf-dispatch-table-ref new-dt index) wrapper)
      (setf (%gf-dispatch-table-ref new-dt (%i+ index 1)) table-entry))
    (if (standard-generic-function-p gf-or-cm)
      (setf (%gf-dispatch-table gf-or-cm) new-dt)
      (setf (%combined-method-methods gf-or-cm) new-dt))))


(defun inner-lfun-bits (function &optional value)
  (lfun-bits (closure-function function) value))



; probably want to use alists vs. hash-tables initially


; only used if error - well not really
(defun collect-lexpr-args (args first &optional last) 
  (if (listp args)
    (subseq args first (or last (length args)))
    (let ((res nil))
      (when (not last)(setq last (%lexpr-count args)))
      (dotimes (i (- last first))
        (setq res (push (%lexpr-ref args last (+ first i)) res)))
      (nreverse res))))




(defmacro with-list-from-lexpr ((list lexpr) &body body)
  (let ((len (gensym)))
    `(let* ((,len (%lexpr-count ,lexpr))
            (,list  (make-list ,len)))
       (declare (dynamic-extent ,list) (fixnum ,len))       
       (do* ((i 0 (1+ i))
             (ls ,list (cdr ls)))
            ((= i ,len) ,list)
         (declare (fixnum i) (list ls))
         (declare (optimize (speed 3)(safety 0)))
         (%rplaca ls (%lexpr-ref ,lexpr ,len i)))
       ,@body)))



(defmacro %standard-instance-p (i)
  `(eq (ppc-typecode ,i) ppc::subtag-instance))

(defppclapfunction %ppc-apply-lexpr-with-method-context ((magic arg_x)
							 (function arg_y)
							 (args arg_z))
  ; Somebody's called (or tail-called) us.
  ; Put magic arg in ppc::next-method-context (= ppc::temp1).
  ; Put function in ppc::nfn (= ppc::temp2).
  ; Set nargs to 0, then spread "args" on stack (clobbers arg_x, arg_y, arg_z,
  ;   but preserves ppc::nfn/ppc::next-method-context.
  ; Jump to the function in ppc::nfn.
  (mr ppc::next-method-context magic)
  (mr ppc::nfn function)
  (set-nargs 0)
  (mflr loc-pc)
  (bla .SPspread-lexpr-z)
  (mtlr loc-pc)
  (lwz temp0 ppc::misc-data-offset nfn)
  (la loc-pc ppc::misc-data-offset temp0)
  (mtctr loc-pc)
  (bctr))




(defppclapfunction %ppc-apply-with-method-context ((magic arg_x)
						   (function arg_y)
						   (args arg_z))
  ;; Somebody's called (or tail-called) us.
  ;; Put magic arg in ppc::next-method-context (= ppc::temp1).
  ;; Put function in ppc::nfn (= ppc::temp2).
  ;; Set nargs to 0, then spread "args" on stack (clobbers arg_x, arg_y, arg_z,
  ;;   but preserves ppc::nfn/ppc::next-method-context.
  ;; Jump to the function in ppc::nfn.
  (mr ppc::next-method-context magic)
  (mr ppc::nfn function)
  (set-nargs 0)
  (mflr loc-pc)
  (bla .SPspreadargZ)
  (mtlr loc-pc)
  (lwz temp0 ppc::misc-data-offset nfn)
  (la loc-pc ppc::misc-data-offset temp0)
  (mtctr loc-pc)
  (bctr))



(declaim (inline %find-1st-arg-combined-method))
(declaim (inline %find-nth-arg-combined-method))
(declaim (inline %find-2nd-arg-combined-method))

(defun %find-1st-arg-combined-method (dt arg)
  (declare (optimize (speed 3)(safety 0)))
  (flet ((get-wrapper (arg)
           (if (not (%standard-instance-p arg))
             (let* ((class (class-of arg)))
               (or (%class.own-wrapper class)
                   (progn
                     (update-class class nil)
                     (%class.own-wrapper class))))
             (instance.class-wrapper arg))))
    (declare (inline get-wrapper))
    (let ((wrapper (get-wrapper arg)))
      (when (eql 0 (%wrapper-hash-index wrapper))
        (update-obsolete-instance arg)
        (setq wrapper (get-wrapper arg)))
      (let* ((mask (%gf-dispatch-table-mask dt))
             (index (%ilsl 1 (%ilogand mask (%wrapper-hash-index wrapper))))
             table-wrapper flag)
        (declare (fixnum index mask))
        (loop 
          (if (eq (setq table-wrapper (%gf-dispatch-table-ref dt index)) wrapper)
            (return (%gf-dispatch-table-ref dt  (the fixnum (1+ index))))
            (progn
              (when (null (%gf-dispatch-table-ref dt (the fixnum (1+ index))))
                (if (or (neq table-wrapper (%unbound-marker-8))
                        (eql 0 flag))
                  (without-interrupts   ; why?
                   (return (1st-arg-combined-method-trap (%gf-dispatch-table-gf dt) wrapper arg))) ; the only difference?
                  (setq flag 0 index -2)))
              (setq index (+ 2 index)))))))))


(defun %find-2nd-arg-combined-method (dt arg1 arg)  
  (declare (optimize (speed 3)(safety 0)))
  (flet ((get-wrapper (arg)
           (if (not (%standard-instance-p arg))
             (let* ((class (class-of arg)))
               (or (%class.own-wrapper class)
                   (progn
                     (update-class class nil)
                     (%class.own-wrapper class))))
             (instance.class-wrapper arg))))
    (declare (inline get-wrapper))
    (let ((wrapper (get-wrapper arg)))
      (when (eql 0 (%wrapper-hash-index wrapper))
        (update-obsolete-instance arg)
        (setq wrapper (get-wrapper arg)))
      (let* ((mask (%gf-dispatch-table-mask dt))
             (index (%ilsl 1 (%ilogand mask (%wrapper-hash-index wrapper))))
             table-wrapper flag)
        (declare (fixnum index mask))
        (loop 
          (if (eq (setq table-wrapper (%gf-dispatch-table-ref dt index)) wrapper)
            (return (%gf-dispatch-table-ref dt (the fixnum (1+ index))))
            (progn
              (when (null (%gf-dispatch-table-ref dt (the fixnum (1+ index))))
                (if (or (neq table-wrapper (%unbound-marker-8))
                        (eql 0 flag))
                  (without-interrupts ; why?
                   (let ((gf (%gf-dispatch-table-gf dt)))
                     (let ((args-list (make-list 2)))
                       (declare (dynamic-extent args-list))
                       (%rplaca args-list arg1)
                       (%rplaca (cdr args-list) arg)
                       (return (nth-arg-combined-method-trap-0 gf dt wrapper args-list))
                       )))
                  (setq flag 0 index -2)))
              (setq index (+ 2 index)))))))))

; more PC - it it possible one needs to go round more than once? - seems unlikely
(defun %find-nth-arg-combined-method (dt arg args)  
  (declare (optimize (speed 3)(safety 0)))
  (flet ((get-wrapper (arg)
           (if (not (%standard-instance-p arg))
             (let* ((class (class-of arg)))
               (or (%class.own-wrapper class)
                   (progn
                     (update-class class nil)
                     (%class.own-wrapper class))))
             (instance.class-wrapper arg))))
    (declare (inline get-wrapper))
    (let ((wrapper (get-wrapper arg)))
      (when (eql 0 (%wrapper-hash-index wrapper))
        (update-obsolete-instance arg)
        (setq wrapper (get-wrapper arg)))
      (let* ((mask (%gf-dispatch-table-mask dt))
             (index (%ilsl 1 (%ilogand mask (%wrapper-hash-index wrapper))))
             table-wrapper flag)
        (declare (fixnum index mask))
        (loop 
          (if (eq (setq table-wrapper (%gf-dispatch-table-ref dt index)) wrapper)
            (return (%gf-dispatch-table-ref dt (the fixnum (1+ index))))
            (progn
              (when (null (%gf-dispatch-table-ref dt (the fixnum (1+ index))))
                (if (or (neq table-wrapper (%unbound-marker-8))
                        (eql 0 flag))
                  (without-interrupts ; why?
                   (let ((gf (%gf-dispatch-table-gf dt)))
                     (if (listp args)
                       (return (nth-arg-combined-method-trap-0 gf dt wrapper args))
                       (with-list-from-lexpr (args-list args)
                         (return (nth-arg-combined-method-trap-0 gf dt wrapper args-list))))))
                  (setq flag 0 index -2)))
              (setq index (+ 2 index)))))))))

; for calls from outside - e.g. stream-reader
(defun find-1st-arg-combined-method (gf arg)
  (declare (optimize (speed 3)(safety 0)))
  (%find-1st-arg-combined-method (%gf-dispatch-table gf) arg))

;; for stream-writer - rets nil if not in dispatch table - avoid crock when specializers on second arg
;; hopefully it will get in the dispatch table soon enough.
;; Well now we do it differently - we assume the gf takes 2 args and we care about the combined method
;; for the first arg when there are specializers on the second arg
(defun find-1st-arg-combined-method-2 (gf arg)
  (declare (optimize (speed 3)(safety 0)))
  (let ((table (%gf-dispatch-table gf)))
    (if (eq (%gf-dcode gf) #'%%nth-arg-dcode) ;; aka imm1 - its code-vector, dt, decode function
      (let ((args (list arg t)))
        (declare (dynamic-extent args))
        (%find-nth-arg-combined-method table arg args))
      (%find-1st-arg-combined-method table arg))))


;;;;;;;;;;;;;;;;;;;;;;;;;;; Generic functions and methods ;;;;;;;;;;;;;;;;;;;;


(defun standard-method-p (thing)
  (when (%standard-instance-p thing)
    (let* ((cpl (%class.cpl (%wrapper-class (instance.class-wrapper thing))))
           (smc *standard-method-class*))
      (dolist (c cpl)
        (if (eq c smc)(return t))))))



(defun %method-function-p (thing)
  (when (functionp thing)
    (let ((bits (lfun-bits thing)))
      (declare (fixnum bits))
      (logbitp $lfbits-method-bit bits))))




(setf (type-predicate 'standard-generic-function) 'standard-generic-function-p)
(setf (type-predicate 'combined-method) 'combined-method-p)

(setf (type-predicate 'standard-method) 'standard-method-p)

;; Maybe we shouldn't make this a real type...
(setf (type-predicate 'method-function) '%method-function-p)


(defvar %all-gfs% (%cons-population nil))


(eval-when (:compile-toplevel :execute)
(defconstant $lfbits-numinh-mask (logior (dpb -1 $lfbits-numinh 0)
                                         (%ilsl $lfbits-nonnullenv-bit 1)))
)


#+ppc-target
(defparameter *gf-proto*
  (nfunction
   gag
   (lambda (&lap &lexpr args)
     (ppc-lap-function 
      gag 
      ()
      (mflr loc-pc)
      (vpush-argregs)
      (vpush nargs)
      (add imm0 vsp nargs)
      (la imm0 4 imm0)                  ; caller's vsp
      (bla .SPlexpr-entry)
      (mtlr loc-pc)                     ; return to kernel
      (mr arg_z vsp)                    ; lexpr
      (svref arg_y gf.dispatch-table nfn) ; dispatch table
      (set-nargs 2)
      (svref nfn gf.dcode nfn)		; dcode function
      (lwz temp0 ppc::misc-data-offset nfn)
      (la loc-pc ppc::misc-data-offset temp0)
      (mtctr loc-pc)
      (bctr)))))

(defvar *gf-proto-code* (uvref *gf-proto* 0))

;;; The "early" version of %ALLOCATE-GF-INSTANCE.
(setf (fdefinition '%allocate-gf-instance)
      #'(lambda (class)
	  (declare (ignorable class))
	  (setq class *standard-generic-function-class*)
	  (let* ((wrapper (%class.own-wrapper class))
		 (len 7 #|(length #.(%wrapper-instance-slots (class-own-wrapper
							  *standard-generic-function-class*)))|#)
		 (dt (make-gf-dispatch-table))
		 (slots (allocate-typed-vector :slot-vector (1+ len) (%slot-unbound-marker)))
		 (fn (gvector :function
			      *gf-proto-code*
			      wrapper
			      slots
			      dt
			      #'%%0-arg-dcode
			      0
			      (%ilogior (%ilsl $lfbits-gfn-bit 1)
					(%ilogand $lfbits-args-mask 0)))))
	    (setf (gf.hash fn) (strip-tag-to-fixnum fn)
		  (slot-vector.instance slots) fn
		  (%gf-dispatch-table-gf dt) fn)
	    (push fn (population.data %all-gfs%))
	    fn)))

;; is a winner - saves ~15%
#+ppc-target
(defppclapfunction gag-one-arg ((arg arg_z))
  (check-nargs 1)  
  (svref arg_y gf.dispatch-table nfn) ; mention dt first
  (set-nargs 2)
  (svref nfn gf.dcode nfn)
  (lwz temp0 ppc::misc-data-offset nfn)
  (la loc-pc ppc::misc-data-offset temp0)
  (mtctr loc-pc)
  (bctr))



#+ppc-target
(defppclapfunction gag-two-arg ((arg0 arg_y) (arg1 arg_z))
  (check-nargs 2)  
  (svref arg_x gf.dispatch-table nfn) ; mention dt first
  (set-nargs 3)
  (svref nfn gf.dcode nfn)
  (lwz temp0 ppc::misc-data-offset nfn)
  (la loc-pc ppc::misc-data-offset temp0)
  (mtctr loc-pc)
  (bctr))
  


(defparameter *gf-proto-one-arg*  #'gag-one-arg)
(defparameter *gf-proto-two-arg*  #'gag-two-arg)

#+ppc-target
(defparameter *cm-proto*
  (nfunction
   gag
   (lambda (&lap &lexpr args)
     (ppc-lap-function 
      gag 
      ()
      (mflr loc-pc)
      (vpush-argregs)
      (vpush nargs)
      (add imm0 vsp nargs)
      (la imm0 4 imm0)                  ; caller's vsp
      (bla .SPlexpr-entry)
      (mtlr loc-pc)                     ; return to kernel
      (mr arg_z vsp)                    ; lexpr
      (svref arg_y combined-method.thing nfn) ; thing
      (set-nargs 2)
      (svref nfn combined-method.dcode nfn) ; dcode function
      (lwz temp0 ppc::misc-data-offset nfn)
      (la loc-pc ppc::misc-data-offset temp0)
      (mtctr loc-pc)
      (bctr)))))



(defvar *cm-proto-code* (uvref *cm-proto* 0))

(defun %cons-combined-method (gf thing dcode)
  ;; set bits and name = gf
  (gvector :function
           *cm-proto-code*
           thing
           dcode
           gf
           (%ilogior (%ilsl $lfbits-cm-bit 1)
                            (%ilogand $lfbits-args-mask (lfun-bits gf)))))

(defun %gf-dispatch-table (gf)
  ;(require-type gf 'standard-generic-function)
  (gf.dispatch-table gf))

(defun %gf-dcode (gf)
  ;(require-type gf 'standard-generic-function)
  (gf.dcode gf))

(defun %set-gf-dcode (gf val)
  (setf (gf.dcode gf) val))

(defun %set-gf-dispatch-table (gf val)
  (setf (gf.dispatch-table gf) val))


(defun %combined-method-methods  (cm)
  ;(require-type cm 'combined-method)
  (combined-method.thing cm))

(defun %combined-method-dcode (cm)
  ;(require-type cm 'combined-method)
  (combined-method.dcode cm))

(defun %set-combined-method-methods (cm val)
  (setf (combined-method.thing cm) val))

(defun %set-combined-method-dcode (cm val)
  (setf (combined-method.dcode cm) val))

(defun generic-function-p (thing)
  (when (typep thing 'function)
    (let ((bits (lfun-bits-known-function thing)))
      (declare (fixnum bits))
      (eq (ash 1 $lfbits-gfn-bit)
	  (logand bits (logior (ash 1 $lfbits-gfn-bit)
			       (ash 1 $lfbits-method-bit)))))))

(defun standard-generic-function-p (thing)
  (and (typep thing 'function)
       (let ((bits (lfun-bits-known-function thing)))
	 (declare (fixnum bits))
	 (eq (ash 1 $lfbits-gfn-bit)
	     (logand bits (logior (ash 1 $lfbits-gfn-bit)
				  (ash 1 $lfbits-method-bit)))))
       (or (eq (%class.own-wrapper *standard-generic-function-class*)
	       (gf.instance.class-wrapper thing))
	   (memq  *standard-generic-function-class*
		  (%inited-class-cpl (class-of thing))))))


(defun combined-method-p (thing)
  (when (functionp thing)
    (let ((bits (lfun-bits-known-function thing)))
      (declare (fixnum bits))
      (eq (ash 1 $lfbits-cm-bit)
	  (logand bits
		  (logior (ash 1 $lfbits-cm-bit)
			  (ash 1 $lfbits-method-bit)))))))

(setf (type-predicate 'generic-function) 'generic-function-p)

(setf (type-predicate 'standard-generic-function) 'standard-generic-function-p)
(setf (type-predicate 'combined-method) 'combined-method-p)



;;; A generic-function looks like:
;;; 
;;; header | trampoline |  dispatch-table | dcode | name | bits
;;; %svref :    0              1              2       3      4
;;;
;;; The trampoline is *gf-proto*'s code vector.
;;; The dispatch-table and dcode are sort of settable closed-over variables.

(defsetf %gf-dispatch-table %set-gf-dispatch-table)

(defun %gf-methods (gf)
  (sgf.methods gf))

(defun %gf-precedence-list (gf)
  (%gf-dispatch-table-precedence-list (%gf-dispatch-table gf)))

(defun %gf-%lambda-list (gf)
  (sgf.%lambda-list gf))

(defun (setf %gf-%lambda-list) (new gf)
  (setf (sgf.%lambda-list gf) new))

;;; Returns INSTANCE if it is either a standard instance of a
;;; standard gf, else nil.
(defun %maybe-gf-instance (instance)
  (if (or (standard-generic-function-p instance)
	  (%standard-instance-p instance))
    instance))

(defsetf %gf-dcode %set-gf-dcode)

(defun %gf-method-class (gf)
  (sgf.method-class gf))


(defun %gf-method-combination (gf)
  (sgf.method-combination gf))

(defun %combined-method-methods  (cm)
  (combined-method.thing cm))

(defun %combined-method-dcode (cm)
  ;(require-type cm 'combined-method)
  (combined-method.dcode cm))


; need setters too

(defsetf %combined-method-methods %set-combined-method-methods)

(defparameter *min-gf-dispatch-table-size* 2
  "The minimum size of a generic-function dispatch table")

(defun make-gf-dispatch-table (&optional (size *min-gf-dispatch-table-size*))
  (when (<= size 0) (report-bad-arg size '(integer 1)))
  (setq size (%imax (%ilsl (%i- (integer-length (%i+ size size -1))
                                1)
                           1)           ; next power of 2
                    *min-gf-dispatch-table-size*))
  (let ((res (%cons-gf-dispatch-table size)))
    (setf (%gf-dispatch-table-mask res) (%i- (%ilsr 1 size) 1)
          (%gf-dispatch-table-argnum res) 0
          (%gf-dispatch-table-ref res size) (%unbound-marker-8))
    res))

; I wanted this to be faster - I didn't
(defun clear-gf-dispatch-table (dt)
  (let ((i %gf-dispatch-table-first-data))
    (dotimes (j (%gf-dispatch-table-size dt))
      (declare (fixnum j))
      (setf (%svref dt i) nil               ; svref is for debugging - nil not 0 is right
            i (%i+ i 1)))
    (setf (%svref dt i) (%unbound-marker-8))   ; paranoia...
    (setf (svref dt (%i+ 1 i)) nil))
  dt)


; Remove all combined-methods from the world
(defun clear-all-gf-caches ()
  (dolist (f (population-data %all-gfs%))
    (clear-gf-cache f))
  (clrhash *combined-methods*)
  nil)



;  Lap fever strikes again... is this still correct? - seems not - maybe ok now
(defun find-gf-dispatch-table-index (dt wrapper &optional skip-full-check?)
  ;searches for an empty slot in dt at the hash-index for wrapper.
  ;returns nil if the table was full.
  (let ((contains-obsolete-wrappers-p nil)
        (mask (%gf-dispatch-table-mask dt)))
    (declare (fixnum mask))
    (unless skip-full-check?
      (let* ((size (1+ mask))
             (max-count (- size (the fixnum (ash (the fixnum (+ size 3)) -2))))
             (index 0)
             (count 0))
        (declare (fixnum size max-count index count))
        (dotimes (i size)
          (declare (fixnum i))
          (let ((wrapper (%gf-dispatch-table-ref dt index)))
            (if wrapper
              (if (eql 0 (%wrapper-hash-index wrapper))
                (setf contains-obsolete-wrappers-p t
                      (%gf-dispatch-table-ref dt index) *obsolete-wrapper*
                      (%gf-dispatch-table-ref dt (1+ index))
                      #'(lambda (&rest rest) 
                          (declare (ignore rest))
                          (error "Generic-function dispatch bug.")))
                (setq count (%i+ count 1)))))
          (setq index (%i+ index 2)))
        (when (> count max-count)
          (return-from find-gf-dispatch-table-index (values nil contains-obsolete-wrappers-p)))))
    (let* ((index (ash (logand mask (%wrapper-hash-index wrapper)) 1)) ; * 2 ??
           (flag nil)
           table-wrapper)      
      (values
       (loop
         (while (and (neq wrapper
                          (setq table-wrapper (%gf-dispatch-table-ref dt index)))
                     (%gf-dispatch-table-ref dt (1+ index))
                     (neq 0 (%wrapper-hash-index table-wrapper)))
           (setq index (%i+ index 2)))
         (if (eq (%unbound-marker-8) table-wrapper)
           (if flag
             (return nil)         ; table full
             (setq flag 1
                   index 0))
           (return index)))
       contains-obsolete-wrappers-p))))


(defvar *obsolete-wrapper* #(obsolete-wrapper 0))
(defvar *gf-dispatch-bug*
  #'(lambda (&rest rest)
      (declare (ignore rest))
      (error "Generic-function dispatch bug!")))

  
; This maximum is necessary because of the 32 bit arithmetic in
; find-gf-dispatch-table-index.
(defparameter *max-gf-dispatch-table-size* (expt 2 16))
(defvar *gf-dt-ovf-cnt* 0)              ; overflow count

(defvar *no-applicable-method-hash* nil)


(let* ((eql-specializers-hash (make-hash-table :test #'eql)))
  (defun intern-eql-specializer (object)
    (without-interrupts
      (or (gethash object eql-specializers-hash)
	  (setf (gethash object eql-specializers-hash)
		(make-instance 'eql-specializer :object object))))))


(setq *no-applicable-method-hash* (make-hash-table :test 'eq :size 0 :weak :key))


(defun make-no-applicable-method-function (gf)
  (if *no-applicable-method-hash*
    (progn
      (or (gethash gf *no-applicable-method-hash*))
      (setf (gethash gf *no-applicable-method-hash*)
            (%cons-no-applicable-method gf)))
    (%cons-no-applicable-method gf)))

(defun %cons-no-applicable-method (gf)
  (%cons-combined-method gf gf #'%%no-applicable-method))

; Returns true if F is a combined-method that calls no-applicable-method
(defun no-applicable-method-cm-p (f)
  (and (typep f 'combined-method)
       (eq '%%no-applicable-method
           (function-name (%combined-method-dcode f)))))


(defun %%no-applicable-method (gf args)
  ; do we really need this? - now we do
  ;(declare (dynamic-extent args)) ; today caller does the &rest
  (if (listp args)
    (apply #'no-applicable-method gf args)
    (%apply-lexpr #'no-applicable-method gf args )))

; if obsolete-wrappers-p is true, will rehash instead of grow.
; It would be better to do the rehash in place, but I'm lazy today.


(defun arg-wrapper (arg)
  (or (standard-object-p arg)
      (%class.own-wrapper (class-of arg))
      (error "~a has no wrapper" arg)))

;;;;;;;;;;;;;;;;;;;;;;;;; generic-function dcode ;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Simple case for generic-functions with no specializers
;; Why anyone would want to do this I can't imagine.

(defun %%0-arg-dcode (dispatch-table args) ; need to get gf from table
  (let ((method (or (%gf-dispatch-table-ref dispatch-table 1)
                    (0-arg-combined-method-trap
                     (%gf-dispatch-table-gf dispatch-table)))))
    (if (not (listp args))
      (progn
        (%apply-lexpr-tail-wise method args))
      (apply method args))))


; arg passed is dispatch table -  add a slot to it containing gf? - later
; or pass the gf instead of the dispatch table 
; (means adding another constant to gf to contain the dispatch table- above is clearer)

(defun %%1st-arg-dcode (dt  args)
  ;(declare (dynamic-extent args))
  (if (not (listp args))
    (let* ((args-len (%lexpr-count args)))
      (if (neq 0 args-len) 
        (let ((method (%find-1st-arg-combined-method dt (%lexpr-ref args args-len 0))))
	  (%apply-lexpr-tail-wise method args))
        (error "0 args to ~s" (%gf-dispatch-table-gf dt))))
    (let* ()  ; happens if traced
      (when (null args) (error "0 args to ~s" (%gf-dispatch-table-gf dt)))
      (let ((method (%find-1st-arg-combined-method dt (%car args))))
        (apply method args)))))

; oh damn this screws up trace and advise big time - fixed we think
(defun %%one-arg-dcode (dt  arg)
  (let ((method (%find-1st-arg-combined-method dt arg)))
    (funcall method arg)))

; two args - specialized on first
(defun %%1st-two-arg-dcode (dt arg1 arg2)
  (let ((method (%find-1st-arg-combined-method dt arg1)))
    (funcall method arg1 arg2)))

;; two args specialized on second
(defun %%2nd-two-arg-dcode (dt arg1 arg2)
  (let ((method (%find-2nd-arg-combined-method dt arg1 arg2)))
    (funcall method arg1 arg2)))

#|
; two args - specialized on second - worth the trouble? maybe not since most are writers anyway
; we have 43 callers of nth-arg-dcode out of 1100 gf's
; I think we have only one multimethod = convert-scrap
(defun %%2nd-two-arg-dcode (dt arg1 arg2)
  (let ((method (%find-2nd-arg-combined-method dt arg1 arg2)))
    (funcall method arg1 arg2)))
|#



;  arg is dispatch-table and argnum is in the dispatch table
(defun %%nth-arg-dcode (dt args)
  ;(declare (dynamic-extent args))
  (if (listp args)
    (let* ((args-len (list-length args))
           (argnum (%gf-dispatch-table-argnum dt)))
      (when (< args-len argnum) (error "Too few args ~s to ~s." args-len (%gf-dispatch-table-gf dt)))
      (let ((method (%find-nth-arg-combined-method dt (nth argnum args) args)))
        (apply method args)))
    (let* ((args-len (%lexpr-count args))
           (argnum (%gf-dispatch-table-argnum dt)))
      (when (< args-len argnum) (error "Too few args ~s to ~s." args-len (%gf-dispatch-table-gf dt)))
      (let ((method (%find-nth-arg-combined-method dt (%lexpr-ref args args-len argnum) args)))
	(%apply-lexpr-tail-wise method args)))))

#+ppc-target
(defppclapfunction %apply-lexpr-tail-wise ((method arg_y) (args arg_z))
  ; This assumes
  ; a) that "args" is a lexpr made via the .SPlexpr-entry mechanism
  ; b) That the LR on entry to this function points to the lexpr-cleanup
  ;    code that .SPlexpr-entry set up
  ; c) That there weren't any required args to the lexpr, e.g. that
  ;    (%lexpr-ref args (%lexpr-count args) 0) was the first arg to the gf.
  ; The lexpr-cleanup code will be EQ to either (lisp-global ret1valaddr)
  ; or (lisp-global lexpr-return1v).  In the former case, discard a frame
  ; from the cstack (multiple-value tossing).  Restore FN and LR from
  ; the first frame that .SPlexpr-entry pushed, restore vsp from (+ args 4),
  ; pop the argregs, and jump to the function.
  ; d) The lexpr args have not been modified since they were moved by a stack overflow
  (mflr loc-pc)
  (ref-global imm0 ret1valaddr)
  (cmpw cr2 loc-pc imm0)
  (lwz nargs 0 args)
  (cmpwi cr0 nargs 0)
  (cmpwi cr1 nargs '2)
  (mr nfn arg_y)
  (lwz temp0 ppc::misc-data-offset nfn)
  (if (:cr2 :eq)
    (la sp ppc::lisp-frame.size sp))
  (lwz loc-pc ppc::lisp-frame.savelr sp)
  (lwz fn ppc::lisp-frame.savefn sp)
  (lwz imm0 ppc::lisp-frame.savevsp sp)
  (sub vsp imm0 nargs)
  (mtlr loc-pc)
  (la loc-pc ppc::misc-data-offset temp0)
  (mtctr loc-pc)
  (la sp ppc::lisp-frame.size sp)
  (beqctr)
  (vpop arg_z)
  (bltctr cr1)
  (vpop arg_y)
  (beqctr cr1)
  (vpop arg_x)
  (bctr))




(defun 0-arg-combined-method-trap (gf)
  (let* ((methods (%gf-methods gf))
         (mc (%gf-method-combination gf))
         (cm (if (eq mc *standard-method-combination*)
               (make-standard-combined-method methods nil gf)
               (compute-effective-method-function 
                gf 
                mc
                (sort-methods (copy-list methods) nil)))))
    (setf (%gf-dispatch-table-ref (%gf-dispatch-table gf) 1) cm)
    cm))

(defun compute-effective-method-function (gf mc methods)  
  (if methods
    (compute-effective-method gf mc methods)
    (make-no-applicable-method-function gf)))

(defun 1st-arg-combined-method-trap (gf wrapper arg)
  ; Here when we can't find the method in the dispatch table.
  ; Compute it and add it to the table.  This code will remain in Lisp.
  ;In case pointing to the lfun-vector of a swappable - punt swapping
  ;#-bccl (setq gf (require-type gf 'standard-generic-function))  
  (let ((table (%gf-dispatch-table gf))
        (combined-method (compute-1st-arg-combined-method gf arg wrapper)))
    (multiple-value-bind (index obsolete-wrappers-p)
                         (find-gf-dispatch-table-index table wrapper)
      (if index
        (setf (%gf-dispatch-table-ref table index) wrapper
              (%gf-dispatch-table-ref table (%i+ index 1)) combined-method)
        (grow-gf-dispatch-table gf wrapper combined-method obsolete-wrappers-p)))
    combined-method))

(defvar *cpl-classes* nil)

(defun %inited-class-cpl (class &optional initialize-can-fail)
  (or (%class.cpl class)
      (if (memq class *cpl-classes*)
        (compute-cpl class)
        (let ((*cpl-classes* (cons class *cpl-classes*)))
          (declare (dynamic-extent *cpl-classes*))
          (update-class class initialize-can-fail)
          (%class.cpl class)))))


(defun compute-1st-arg-combined-method (gf arg &optional 
                                           (wrapper (arg-wrapper arg)))
  (declare (resident))
  ;#-bccl (setq gf (require-type gf 'standard-generic-function))  
  (let* ((methods (%gf-dispatch-table-methods (%gf-dispatch-table gf)))
         (cpl (%inited-class-cpl (%wrapper-class wrapper)))
         (method-combination (%gf-method-combination gf))
         applicable-methods eql-methods specializer)
    (dolist (method methods)
      ;#-bccl (setq method (require-type method 'standard-method))   ; for debugging.
      (setq specializer (%car (%method.specializers method)))
      (if (typep specializer 'eql-specializer)
        (when (cpl-memq (%wrapper-class (arg-wrapper (eql-specializer-object specializer))) cpl)
          (push method eql-methods))
        (when (cpl-memq specializer cpl)
          (push method applicable-methods))))
    (if (null eql-methods)
      (if (eq method-combination *standard-method-combination*)
        (make-standard-combined-method applicable-methods (list cpl) gf)
        (compute-effective-method-function 
         gf 
         method-combination
         (sort-methods applicable-methods
                       (list cpl)
                       (%gf-precedence-list gf))))
      (make-eql-combined-method  
       eql-methods applicable-methods (list cpl) gf 0 nil method-combination))))
      


(defvar *combined-methods* (make-hash-table  :test 'equal :weak :value))                          

(defun gethash-combined-method (key)
  (gethash key *combined-methods*))

(defun puthash-combined-method (key value)
  (setf (gethash key *combined-methods*) value))

;; Some statistics on the hash table above
(defvar *returned-combined-methods* 0)
(defvar *consed-combined-methods* 0)

;; Assumes methods are already sorted if cpls is nil
(defun make-standard-combined-method (methods cpls gf &optional
                                              (ok-if-no-primaries (null methods)))
  (unless (null cpls)
    (setq methods (sort-methods 
                   methods cpls (%gf-precedence-list (combined-method-gf gf)))))
  (let* ((keywords (compute-allowable-keywords-vector gf methods))
         (combined-method (make-standard-combined-method-internal
                           methods gf keywords ok-if-no-primaries)))
    (if (and keywords methods)
      (make-keyword-checking-combined-method gf combined-method keywords)
      combined-method)))


; Initialized below after the functions exist.
(defvar *clos-initialization-functions* nil)



; Returns NIL if all keywords allowed, or a vector of the allowable ones.
(defun compute-allowable-keywords-vector (gf methods)
  (setq gf (combined-method-gf gf))
  (unless (memq gf *clos-initialization-functions*)
    (let* ((gbits (inner-lfun-bits gf))
           (&key-mentioned-p (logbitp $lfbits-keys-bit gbits)))
      (unless (or (and ;; (neq :unspecified (sgf.%lambda-list gf)) ;; can we do this now? No
                       (logbitp $lfbits-aok-bit gbits)) 
                  (dolist (method methods)
                    (let ((mbits (lfun-bits (%method.function method))))
                      (when (logbitp $lfbits-keys-bit mbits)
                        (setq &key-mentioned-p t)
                        (if (logbitp $lfbits-aok-bit mbits)
                          (return t)))))
                  (not &key-mentioned-p))
        (let (keys)
          (flet ((adjoin-keys (keyvect keys)
                              (when keyvect
                                (dovector (key keyvect) (pushnew key keys)))
                              keys))
            (when (logbitp $lfbits-keys-bit gbits)
              (setq keys (adjoin-keys (%defgeneric-keys gf) keys)))
            (dolist (method methods)
              (let ((f (%inner-method-function method)))
                (when (logbitp $lfbits-keys-bit (lfun-bits f))
                  (setq keys (adjoin-keys (lfun-keyvect f) keys))))))
          (apply #'vector keys))))))

; The aux arg is used by keyword checking for %call-next-method-with-args - it is?
(defun make-keyword-checking-combined-method (gf combined-method keyvect)
  (let* ((bits (inner-lfun-bits gf))
         (numreq (ldb $lfbits-numreq bits))
         (key-index (+ numreq (ldb $lfbits-numopt bits))))
    (%cons-combined-method 
     gf       
     (vector key-index keyvect combined-method)
     #'%%check-keywords)))
; ok

; #(keyvect key-index combined-method) in atemp1 - actually key-index keyvect today


(defun odd-keys-error (varg l) 
  (let ((gf (combined-method-gf (%svref varg 2))))
    (error "Odd number of keyword args to ~s~%keyargs: ~s" gf l)))


(defun bad-key-error (key varg l)
  (let* ((keys (%svref varg 1))
         (gf (combined-method-gf (%svref varg 2)))
         (*print-array* t)
         (*print-readably* t)
         (readable-keys (format nil "~s" keys)))
    (error "Bad keyword ~s to ~s.~%keyargs: ~s~%allowable keys are ~a." key gf l readable-keys)))

; vector arg is (vector key-index keyvect combined-method) ; the next combined method
(defun %%check-keywords (vector-arg args)
  (flet ((do-it (vector-arg args)
           (let* ((args-len (length args))
                  (keyvect (%svref vector-arg 1))
                  (keyvect-len (length keyvect))
                  (key-index (%svref vector-arg 0)))
             ; vector arg is (vector key-index keyvect combined-method) ; the next combined method
             (declare (fixnum args-len key-index keyvect-len))
             (when (>= args-len key-index)
               (let* ((keys-in (- args-len key-index))
                      aok)  ; actually * 2
                 (declare (fixnum  key-index keys-in keyvect-len))
                 (when (logbitp 0 keys-in) (odd-keys-error vector-arg (collect-lexpr-args args key-index args-len)))
                 (do ((i key-index (+ i 2))
                      (kargs (nthcdr key-index args) (cddr kargs)))
                     ((eq i args-len))
                   (declare (fixnum i))
                   (when aok (return))
                   (let ((key (car kargs)))
                     (when (and (eq key :allow-other-keys)
                                (cadr kargs))
                       (return))
                     (when (not (dotimes (i keyvect-len nil)
                                  (if (eq key (%svref keyvect i))
                                    (return t))))
                       ; not found - is :allow-other-keys t in rest of user args
                       (when (not (do ((remargs kargs (cddr remargs)))
                                      ((null remargs) nil)
                                    (when (and (eq (car remargs) :allow-other-keys)
                                               (cadr remargs))
                                      (setq aok t)
                                      (return t))))              
                         (bad-key-error key vector-arg (collect-lexpr-args args key-index args-len))))))))
             (let ((method (%svref vector-arg 2)))
               ; magic here ?? not needed
               (apply method args)))))
    (if (listp args)
      (do-it vector-arg args)
      (with-list-from-lexpr (args-list args)
        (do-it vector-arg args-list)))))


; called from %%call-next-method-with-args - its the key-or-init-fn 
; called from call-next-method-with-args - just check the blooming keys
; dont invoke any methods - maybe use x%%check-keywords with last vector elt nil
; means dont call any methods - but need the gf or method for error message
(defun x-%%check-keywords (vector-arg ARGS)
  ;(declare (dynamic-extent args))
    ; vector arg is (vector key-index keyvect unused)
  (let* ((ARGS-LEN (length args))
         (keyvect (%svref vector-arg 1))
         (keyvect-len (length keyvect))
         (key-index (%svref vector-arg 0))
         (keys-in (- args-len key-index))
         aok)  ; actually * 2
    (declare (fixnum args-len key-index keys-in keyvect-len))
    
    (when (logbitp 0 keys-in) (odd-keys-error vector-arg (collect-lexpr-args args key-index args-len)))
    (do ((i key-index (+ i 2))
         (kargs (nthcdr key-index args) (cddr kargs)))
        ((eq i args-len))
      (declare (fixnum i))
      (when aok (return))
      (let ((key (car kargs)))
        (when (and (eq key :allow-other-keys)
                   (cadr kargs))
          (return))
        (when (not (dotimes (i keyvect-len nil)
                     (if (eq key (%svref keyvect i))
                       (return t))))
          ; not found - is :allow-other-keys t in rest of user args
          (when (not (do ((remargs kargs (cddr remargs)))
                         ((null remargs) nil)
                       (when (and (eq (car remargs) :allow-other-keys)
                                  (cadr remargs))
                         (setq aok t)
                         (return t))))              
            (bad-key-error key vector-arg 
                           (collect-lexpr-args args key-index args-len))))))))
#| ; testing
(setq keyvect  #(:a :b ))
(setq foo (make-array 3))
(setf (aref foo 0) keyvect (aref foo 1) 2)
(setf (aref foo 2)(method window-close (window)))
( %%check-keywords 1 2 :a 3 :c 4 foo)
( %%check-keywords 1 2 :a 3 :b 4 :d foo)
|#
 
    



; Map an effective-method to it's generic-function.
; This is only used for effective-method's which are not combined-method's
; (e.g. those created by non-STANDARD method-combination)
(defvar *effective-method-gfs* (make-hash-table :test 'eq :weak :key))


(defun get-combined-method (method-list gf)
  (let ((cm (gethash-combined-method method-list)))
    (when cm
      (setq gf (combined-method-gf gf))
      (if (combined-method-p cm)
        (and (eq (combined-method-gf cm) gf) cm)
        (and (eq (gethash cm *effective-method-gfs*) gf) cm)))))

(defun put-combined-method (method-list cm gf)
  (unless (%method-function-p cm)       ; don't bother with non-combined methods
    (puthash-combined-method method-list cm)
    (unless (combined-method-p cm)
      (setf (gethash cm *effective-method-gfs*) (combined-method-gf gf))))
  cm)

(defun make-standard-combined-method-internal (methods gf &optional 
                                                       keywords
                                                       (ok-if-no-primaries
                                                        (null methods)))
  (let ((method-list (and methods (compute-method-list methods))))
    (if method-list                 ; no applicable primary methods
      (if (atom method-list)
        (%method.function method-list)    ; can jump right to the method-function
        (progn
          (incf *returned-combined-methods*)  ; dont need this
          (if (contains-call-next-method-with-args-p method-list)
            (make-cnm-combined-method gf methods method-list keywords)
            (or (get-combined-method method-list gf)
                (progn
                  (incf *consed-combined-methods*)  ; dont need this
                  (puthash-combined-method
                   method-list
                   (%cons-combined-method
                    gf method-list #'%%standard-combined-method-dcode)))))))
      (if ok-if-no-primaries
        (make-no-applicable-method-function (combined-method-gf gf))
        (no-applicable-primary-method gf methods)))))

; Initialized after the initialization (generic) functions exist.
(defvar *initialization-functions-alist* nil)

; This could be in-line above, but I was getting confused.

; ok
(defun make-cnm-combined-method (gf methods method-list keywords)
  (setq gf (combined-method-gf gf))
  (let ((key (cons methods method-list)))
    (or (get-combined-method key gf)
        (let* (key-or-init-arg
               key-or-init-fn)
          (if keywords
            (let* ((bits (inner-lfun-bits gf))
                   (numreq (ldb $lfbits-numreq bits))
                   (key-index (+ numreq (ldb $lfbits-numopt bits))))
              (setq key-or-init-arg (vector key-index keywords gf))
              (setq key-or-init-fn #'x-%%check-keywords))
            (let ((init-cell (assq gf *initialization-functions-alist*)))
              (when init-cell                
                (setq key-or-init-arg init-cell)
                (setq key-or-init-fn #'%%cnm-with-args-check-initargs))))
          (incf *consed-combined-methods*)
          (let* ((vect (vector gf methods key-or-init-arg key-or-init-fn method-list))
                 (self (%cons-combined-method
                        gf vect #'%%cnm-with-args-combined-method-dcode)))
            ;(setf (svref vect 4) self)
            (puthash-combined-method ; if  testing 1 2 3 dont put in our real table
             key
             self))))))


(defparameter *check-call-next-method-with-args* t)

(defun contains-call-next-method-with-args-p (method-list)
  (when *check-call-next-method-with-args*
    (let ((methods method-list)
          method)
      (loop
        (setq method (pop methods))
        (unless methods (return nil))
        (unless (listp method)
          (if (logbitp $lfbits-nextmeth-with-args-bit
                       (lfun-bits (%method.function method)))
            (return t)))))))

; The METHODS arg is a sorted list of applicable methods.
; Returns the method-list expected by %%before-and-after-combined-method-dcode
; or a single method, or NIL if there are no applicable primaries
(defun compute-method-list (methods)
  (let (arounds befores primaries afters qs)
    (dolist (m methods)
      (setq qs (%method.qualifiers m))
      (if qs
        (if (cdr qs)
          (%invalid-method-error
           m "Multiple method qualifiers not allowed in ~s method combination"
           'standard)
          (case (car qs)
            (:before (push m befores))
            (:after (push m afters))
            (:around (push m arounds))
            (t (%invalid-method-error m "~s is not one of ~s, ~s, and ~s."
                                      (car qs) :before :after :around))))
        (push m primaries)))
    (setq primaries (nremove-uncallable-next-methods (nreverse primaries))
          arounds (nremove-uncallable-next-methods (nreverse arounds))
          befores (nreverse befores))      
    (flet ((next-method-bit-p (method)
                              (logbitp $lfbits-nextmeth-bit 
                                       (lfun-bits (%method.function method)))))
      (unless (null primaries)            ; return NIL if no applicable primary methods
        (when (and arounds (not (next-method-bit-p (car (last arounds)))))
          ; Arounds don't call-next-method, can't get to befores, afters, or primaries
          (setq primaries arounds
                arounds nil
                befores nil
                afters nil))
        (if (and (null befores) (null afters)
                 (progn
                   (when arounds
                     (setq primaries (nremove-uncallable-next-methods
                                      (nconc arounds primaries))
                           arounds nil))
                   t)
                 (null (cdr primaries))
                 (not (next-method-bit-p (car primaries))))
          (car primaries)                 ; single method, no call-next-method
          (let ((method-list primaries))
            (if (or befores afters)
              (setq method-list (cons befores (cons afters method-list))))
            (nconc arounds method-list)))))))


; ok 

(defun %invalid-method-error (method format-string &rest format-args)
  (error "~s is an invalid method.~%~?" method format-string format-args))

(defun %method-combination-error (format-string &rest args)
  (apply #'error format-string args))

; ok


(defun combined-method-gf (gf-or-cm)
  (let ((gf gf-or-cm))
    (while (combined-method-p gf)
      (setq gf (lfun-name gf)))
    gf))

(defun nth-arg-dcode-too-few-args (gf-or-cm)
  (error "Too few args to: ~s" (combined-method-gf gf-or-cm)))

(defun nth-arg-combined-method-trap-0 (gf-or-cm table wrapper args)
  (let* ((argnum (%gf-dispatch-table-argnum table))
         (arg (nth argnum args)))
    (nth-arg-combined-method-trap gf-or-cm table argnum args arg wrapper)))

; ok

(defun nth-arg-combined-method-trap (gf-or-cm table argnum args &optional
                                              (arg (nth-or-gf-error 
                                                    argnum args gf-or-cm))
                                              (wrapper (arg-wrapper arg)))
  ; Here when we can't find the method in the dispatch table.
  ; Compute it and add it to the table.  This code will remain in Lisp.
  (multiple-value-bind (combined-method sub-dispatch?)
                       (compute-nth-arg-combined-method
                        gf-or-cm (%gf-dispatch-table-methods table) argnum args
                        wrapper)
    (multiple-value-bind (index obsolete-wrappers-p)
                         ( find-gf-dispatch-table-index table wrapper)
      (if index
        (setf (%gf-dispatch-table-ref table index) wrapper
              (%gf-dispatch-table-ref table (%i+ index 1)) combined-method)
        (grow-gf-dispatch-table gf-or-cm wrapper combined-method obsolete-wrappers-p)))
    (if sub-dispatch?
      (let ((table (%combined-method-methods combined-method)))
        (nth-arg-combined-method-trap
         combined-method
         table
         (%gf-dispatch-table-argnum table)
         args))
      combined-method)))

;; Returns (values combined-method sub-dispatch?)
;; If sub-dispatch? is true, need to compute a combined-method on the
;; next arg.
(defun compute-nth-arg-combined-method (gf methods argnum args &optional 
                                           (wrapper (arg-wrapper
                                                     (nth-or-gf-error
                                                      argnum args gf))))
  (let* ((cpl (%inited-class-cpl (%wrapper-class wrapper)))
         (real-gf (combined-method-gf gf))
         (mc (%gf-method-combination real-gf))
         (standard-mc? (eq mc *standard-method-combination*))
         applicable-methods eql-methods specializers specializer sub-dispatch?)
    (dolist (method methods)
      ;(require-type method 'standard-method)   ; for debugging.
      (setq specializers (nthcdr argnum (%method.specializers method))
            specializer (%car specializers))
      (when (if (typep specializer 'eql-specializer)
              (when (cpl-memq (%wrapper-class
                                (arg-wrapper (eql-specializer-object specializer))) cpl)
                (push method eql-methods))
              (when (cpl-memq specializer cpl)
                (push method applicable-methods)))
        (if (contains-non-t-specializer? (%cdr specializers))
          (setq sub-dispatch? t))))
    (if (or eql-methods applicable-methods)
      (if (or (not standard-mc?)
            (contains-primary-method? applicable-methods)
            (contains-primary-method? eql-methods))
        (let ((cpls (args-cpls args)))
          (if eql-methods
            (make-eql-combined-method
             eql-methods applicable-methods cpls gf argnum sub-dispatch? mc)
            (if sub-dispatch?
              (values (make-n+1th-arg-combined-method applicable-methods gf argnum)
                      t)
              (if standard-mc?
                (make-standard-combined-method applicable-methods cpls gf)
                (compute-effective-method-function
                 real-gf mc (sort-methods applicable-methods
                                          (args-cpls args)
                                          (%gf-precedence-list real-gf)))))))
        (no-applicable-primary-method
         real-gf
         (sort-methods (append eql-methods applicable-methods)
                       (args-cpls args)
                       (%gf-precedence-list real-gf))))
       (make-no-applicable-method-function real-gf))))



(defun nth-or-gf-error (n l gf)
  (dotimes (i n) (declare (fixnum i)) (setf l (cdr l)))
  (if (null l)
    (nth-arg-dcode-too-few-args gf))
  (car l))

(defun contains-non-t-specializer? (specializer-list)
  (dolist (s specializer-list nil)
    (unless (eq *t-class* s)
      (return t))))

(defun contains-primary-method? (method-list)
  (dolist (m method-list nil)
    (if (null (%method.qualifiers m))
      (return t))))

(defun args-cpls (args &aux res)
  (dolist (arg args)
    (push (%inited-class-cpl (%wrapper-class (arg-wrapper arg))) res))
  (nreverse res))



;; This needs to be updated to use a linear search in a vector changing to
;; a hash table when the number of entries crosses some threshold.
(defun make-eql-combined-method (eql-methods methods cpls gf argnum sub-dispatch? &optional
                                             (method-combination *standard-method-combination*))
  (let ((eql-ms (copy-list eql-methods))
        (precedence-list (%gf-precedence-list (combined-method-gf gf)))
        (standard-mc? (eq method-combination *standard-method-combination*))
        (real-gf (combined-method-gf gf))
        eql-method-alist
        (can-use-eq? t))
    (unless sub-dispatch?
      (setq methods (sort-methods methods cpls precedence-list)))
    (while eql-ms
      (let ((eql-element (eql-specializer-object (nth argnum (%method.specializers (car eql-ms)))))
            (this-element-methods eql-ms)
            cell last-cell)
        (if (or (and (numberp eql-element) (not (fixnump eql-element)))
                (macptrp eql-element))
          (setq can-use-eq? nil))
        (setf eql-ms (%cdr eql-ms)
              (%cdr this-element-methods) nil
              cell eql-ms)
        (while cell
          (if (eql eql-element
                     (eql-specializer-object (nth argnum (%method.specializers (car cell)))))
            (let ((cell-save cell))
              (if last-cell
                (setf (%cdr last-cell) (cdr cell))
                (setq eql-ms (cdr eql-ms)))
              (setf cell (cdr cell)
                    (%cdr cell-save) this-element-methods
                    this-element-methods cell-save))
            (setq last-cell cell
                  cell (cdr cell))))
        (let* ((sorted-methods
                (sort-methods (nreconc (copy-list this-element-methods)
                                       (copy-list methods))
                              cpls
                              precedence-list))
               (method-list (and standard-mc? (compute-method-list sorted-methods))))
          (when (or (not standard-mc?)
                    (memq method-list this-element-methods)
                    (and (consp method-list)
                         (labels ((member-anywhere (tem mlist)
                                    (member tem mlist
                                            :test #'(lambda (tem el)
                                                      (if (listp el)
                                                        (member-anywhere tem el)
                                                        (member el tem))))))
                           (member-anywhere this-element-methods method-list))))
            ; Do EQL comparison only if the EQL methods can run
            ; (e.g. does not come after a primary method that does not call-next-method)
            (push (cons eql-element
                        (if sub-dispatch?
                          (make-n+1th-arg-combined-method
                           sorted-methods gf argnum)
                          (if standard-mc?
                            (make-standard-combined-method sorted-methods nil gf)
                            (compute-effective-method-function
                             real-gf method-combination sorted-methods))))
                  eql-method-alist)))))
    ;;eql-method-alist has (element . combined-method) pairs.
    ;;for now, we're going to use assq or assoc
    (let ((default-method (if sub-dispatch?
                            (make-n+1th-arg-combined-method
                             methods gf argnum)
                            (if standard-mc?
                              (make-standard-combined-method methods nil gf t)
                              (compute-effective-method-function
                               real-gf method-combination methods)))))
      (if eql-method-alist
        (%cons-combined-method 
         gf (cons argnum (cons eql-method-alist default-method))
         (if can-use-eq? 
           #'%%assq-combined-method-dcode
           #'%%assoc-combined-method-dcode))
        default-method))))

; ok



(DEFun %%assq-combined-method-dcode (stuff args)
  ;; stuff is (argnum eql-method-list . default-method)
  ;(declare (dynamic-extent args))
  (if (listp args)
    (let* ((args-len (list-length args))
           (argnum (car stuff)))
      (when (>= argnum args-len)(Error "Too few args to ~s." (%method-gf (cddr stuff))))
      (let* ((arg (nth argnum args))
             (thing (assq arg (cadr stuff)))) ; are these things methods or method-functions? - fns    
        (if thing 
          (apply (cdr thing) args)
          (apply (cddr stuff) args))))
    (let* ((args-len (%lexpr-count args))
           (argnum (car stuff)))
      (when (>= argnum args-len)(Error "Too few args to ~s." (%method-gf (cddr stuff))))
      (let* ((arg (%lexpr-ref args args-len argnum))
             (thing (assq arg (cadr stuff)))) ; are these things methods or method-functions? - fns    
        (if thing 
          (%apply-lexpr (cdr thing) args)
          (%apply-lexpr (cddr stuff) args))))))
  

(DEFun %%assoc-combined-method-dcode (stuff args)
  ;; stuff is (argnum eql-method-list . default-method)
  ;(declare (dynamic-extent args))
  (if (listp args)
    (let* ((args-len (list-length args))
           (argnum (car stuff)))
      (when (>= argnum args-len)(Error "Too few args to ~s." (%method-gf (cddr stuff))))
      (let* ((arg (nth argnum args))
             (thing (assoc arg (cadr stuff)))) ; are these things methods or method-functions?    
        (if thing 
          (apply (cdr thing) args)
          (apply (cddr stuff) args))))
    (let* ((args-len (%lexpr-count args))
           (argnum (car stuff)))
      (when (>= argnum args-len)(Error "Too few args to ~s." (%method-gf (cddr stuff))))
      (let* ((arg (%lexpr-ref args args-len argnum))
             (thing (assoc arg (cadr stuff)))) ; are these things methods or method-functions?    
        (if thing 
          (%apply-lexpr (cdr thing) args)
          (%apply-lexpr (cddr stuff) args))))))


; Assumes the two methods have the same number of specializers and that
; each specializer of each method is in the corresponding element of cpls
; (e.g. cpls is a list of the cpl's for the classes of args for which both
; method1 & method2 are applicable.
(defun %method< (method1 method2 cpls)
  (let ((s1s (%method.specializers method1))
        (s2s (%method.specializers method2))
        s1 s2 cpl)
    (loop
      (if (null s1s)
        (return (method-qualifiers< method1 method2)))
      (setq s1 (%pop s1s)
            s2 (%pop s2s)
            cpl (%pop cpls))
      (cond ((typep s1 'eql-specializer) 
             (unless (eq s1 s2)
               (return t)))
            ((typep s2 'eql-specializer) (return nil))
            ((eq s1 s2))
            (t (return (%i< (cpl-index s1 cpl) (cpl-index s2 cpl))))))))

(defun %simple-method< (method1 method2 cpl)
  (let ((s1 (%car (%method.specializers method1)))
        (s2 (%car (%method.specializers method2))))
    (cond ((typep s1 'eql-specializer) 
           (if (eq s1 s2)
             (method-qualifiers< method1 method2)
             t))
          ((typep s2 'eql-specializer) nil)
          ((eq s1 s2) (method-qualifiers< method1 method2))
          (t (%i< (cpl-index s1 cpl) (cpl-index s2 cpl))))))

; Sort methods with argument-precedence-order
(defun %hairy-method< (method1 method2 cpls apo)
  (let ((s1s (%method.specializers method1))
        (s2s (%method.specializers method2))
        s1 s2 cpl index)
    (loop
      (if (null apo)
        (return (method-qualifiers< method1 method2)))
      (setq index (pop apo))
      (setq s1 (nth index s1s)
            s2 (nth index s2s)
            cpl (nth index cpls))
      (cond ((typep s1 'eql-specializer) 
             (unless (eq s1 s2)
               (return t)))
            ((typep s2 'eql-specializer) (return nil))
            ((eq s1 s2))
            (t (return (%i< (cpl-index s1 cpl) (cpl-index s2 cpl))))))))

; This can matter if the user removes & reinstalls methods between
; invoking a generic-function and doing call-next-method with args.
; Hence, we need a truly canonical sort order for the methods
; (or a smarter comparison than EQUAL in %%cnm-with-args-check-methods).
(defun method-qualifiers< (method1 method2)
  (labels ((qualifier-list< (ql1 ql2 &aux q1 q2)
              (cond ((null ql1) (not (null ql2)))
                    ((null ql2) nil)
                    ((eq (setq q1 (car ql1)) (setq q2 (car ql2)))
                     (qualifier-list< (cdr ql1) (cdr ql2)))
                    ((string-lessp q1 q2) t)
                    ; This isn't entirely correct.
                    ; two qualifiers with the same pname in different packages
                    ; are not comparable here.
                    ; Unfortunately, users can change package names, hence,
                    ; comparing the package names doesn't work either.
                    (t nil))))
    (qualifier-list< (%method.qualifiers method1) (%method.qualifiers method2))))
       
(defun sort-methods (methods cpls &optional apo)
  (cond ((null cpls) methods)
        ((null (%cdr cpls))
         (setq cpls (%car cpls))
         (flet ((simple-sort-fn (m1 m2)
                  (%simple-method< m1 m2 cpls)))
           (declare (dynamic-extent #'simple-sort-fn))
           (%sort-list-no-key methods #'simple-sort-fn)))
        ((null apo)                     ; no unusual argument-precedence-order
         (flet ((sort-fn (m1 m2) 
                  (%method< m1 m2 cpls)))
           (declare (dynamic-extent #'sort-fn))
           (%sort-list-no-key methods #'sort-fn)))
        (t                              ; I guess some people are just plain rude
         (flet ((hairy-sort-fn (m1 m2)
                  (%hairy-method< m1 m2 cpls apo)))
           (declare (dynamic-extent #'hairy-sort-fn))
           (%sort-list-no-key methods #'hairy-sort-fn)))))

(defun nremove-uncallable-next-methods (methods)
  (do ((m methods (%cdr m))
       mbits)
      ((null m))
    (setq mbits (lfun-bits (%method.function (%car m))))
    (unless (logbitp $lfbits-nextmeth-bit mbits)
      (setf (%cdr m) nil)
      (return)))
  methods)

; ok
; Lap mania struck again - I'm immune
; Often used as a predicate - dont need index
(defun cpl-index (superclass cpl)
  ;; This will be table lookup later.  Also we'll prelookup the tables
  ;; in compute-1st-arg-combined-methods above.
  (locally (declare (optimize (speed 3)(safety 0)))
    (do ((i 0 (%i+ i 1))
         (cpl cpl (%cdr cpl)))
        ((null cpl) nil)
      (if (eq superclass (%car cpl))
        (return i)))))

(defun cpl-memq (superclass cpl)
  (locally (declare (optimize (speed 3)(safety 0)))
    (do ((cpl cpl (%cdr cpl)))
        ((null cpl) nil)
      (if (eq superclass (%car cpl))
        (return cpl)))))

;; Combined method interpretation


; magic is a list of (cnm-cm (methods) . args)
; cnm-cm is the argument checker for call-next-method-with-args or nil
; could make it be a cons as a flag that magic has been heap consed - done
; could also switch car and cadr
; if we do &lexpr business then if cddr is  lexpr-p (aka (not listp)) thats the clue
;  also would need to do lexpr-apply or apply depending on the state.


; per gb - use cons vs. make-list - untested - shorter tho
(defun %%standard-combined-method-dcode (methods  args)
  ; combined-methods as made by make-combined-method are in methods
  ; args are as put there by the caller of the gf.
  ;(declare (dynamic-extent args))
  (let* ((car-meths (car methods))
         (cell-2 (cons methods args))
         (magic (cons nil cell-2)))
    ; i.e. magic is nil methods . args
    (declare (dynamic-extent magic)
             (dynamic-extent cell-2))    
    ;(%rplaca magic nil) ; not needed ? 
    ;(setf (cadr magic) methods)
    ;(%rplaca (cdr magic) methods)
    ;(setf (cddr magic) args)
    ;(%rplacd (cdr magic) args)
    (if (listp car-meths)
      (progn
        (%%before-and-after-combined-method-dcode magic))
      (progn       
        (if (not (cdr methods))
          (%rplaca (cdr magic) car-meths)
          (%rplaca (cdr magic) (cdr methods)))
        ; so maybe its a combined-method ?? - no
        (apply-with-method-context magic (%method.function car-meths) args)))))

; args is list, old-args may be lexpr
(defun cmp-args-old-args (args old-args numreq)
  (declare (optimize (speed 3)(safety 0)))
  (if (listp old-args)
    (do ((newl args (cdr newl))
         (oldl old-args (cdr oldl))
         (i 0 (1+ i)))
        ((eql i numreq) t)
      (when (neq (car newl)(car oldl))(return nil)))
    (let ((len (%lexpr-count old-args)))
      (do ((newl args (cdr newl))
           (i 0 (1+ i)))
          ((eql i numreq) t)
        (when (neq (car newl)(%lexpr-ref old-args len i))(return nil))))))        


; called from call-next-method-with-args with magic supplied and 1st time around with not
(defun %%cnm-with-args-combined-method-dcode (thing args &optional magic) ; was &rest args
  ;(declare (dynamic-extent args))
  ; now thing is vector of gf orig methods, arg for key or initarg check, key or initarg fnction
  ; and our job is to do all the arg checking
  (let ()
    (when (and magic thing)  ;; << was just (when magic ...) which will error if thing is nil
      (flet ((do-it (thing args)
               (let* ((args-len (length args))
                      (gf (svref thing 0))  ; could get this from a method
                      (numreq (ldb $lfbits-numreq (inner-lfun-bits gf)))
                      (next-methods (cadr magic)))
                 ;(when (null self)(error "Next method with args context error"))
                 (when (neq 0 numreq)
                   ; oh screw it - old-args may be lexpr too
                   (let ((old-args (cddr magic)))
                     (when (< args-len numreq) (error "Too few args to ~S" gf))
                     (when (null (cmp-args-old-args args old-args numreq))
                       ; required args not eq - usually true, we expect
                       (let ((new-methods (%compute-applicable-methods* gf args))
                             (old-methods (svref thing 1)))
                         (when (not (equal new-methods old-methods))
                           (error '"Applicable-methods changed in call-next-method.~%~
                                    Should be: ~s~%Was: ~s~%Next-methods: ~s"
                                  old-methods new-methods next-methods))))))
                 (let ((key-or-init-fn (svref thing 3)))
                   (when key-or-init-fn 
                     ; was apply
                     (funcall key-or-init-fn (svref thing 2) args))))))
        (if (listp args)
          (do-it thing args)
          (with-list-from-lexpr (args-list args)
            (do-it thing args-list)))))
    ; ok done checking - lets do it 
    (let* ((methods (if magic (cadr magic)(svref thing 4)))  ;<< was 5 this is nil unless cnm with args
           ; was if magic
           (car-meths (car methods))
           (cell-2 (cons methods args))
           (magic (cons thing cell-2)))
      (declare (dynamic-extent magic cell-2))
      ; i.e. magic is thing methods . args
      ;(%rplaca magic thing)
      ;(setf (cadr magic) methods)
      ;(%rplaca (cdr magic) methods)
      ;(setf (cddr magic) args)
      ;(%rplacd (cdr magic) args)
      (if (listp car-meths)
        (progn
          (%%before-and-after-combined-method-dcode magic))
        (progn       
          (if (not (cdr methods))
            (%rplaca (cdr magic) car-meths)
            (%rplaca (cdr magic) (cdr methods)))
          ; so maybe its a combined-method ?? - no
          (apply-with-method-context magic (%method.function car-meths) args))))))



; here if car of methods is listp. methods = (befores afters . primaries)
(defun %%before-and-after-combined-method-dcode (magic) 
  (declare (list magic))
  (let* ((methods (cadr magic))         
         (befores (car methods))         
         (cdr-meths (cdr methods))
         (primaries (cdr cdr-meths))
         (afters (car cdr-meths))
         (args (cddr magic)))
    (declare (list befores afters primaries))
    (when befores 
      (dolist (method befores)
        (rplaca (cdr magic) method)
        (apply-with-method-context magic (%method.function method) args)))
    (let* ((cdr (cdr primaries))
           (method-function (%method.function (car primaries))))   ; guaranteed non nil?
      (rplaca (cdr magic) (if (null cdr)(car primaries) cdr))      
      (if (null afters)
        (apply-with-method-context magic method-function args)  ; tail call if possible
        (multiple-value-prog1
          (apply-with-method-context magic method-function args)        
          (dolist (method afters)
            (rplaca (cdr magic) method)
            (apply-with-method-context magic (%method.function method) args)))))))


; This is called by the compiler expansion of next-method-p
; I think there's a bug going around... LAP fever! I'm immune
(defun %next-method-p (magic)
  (let ((methods (%cadr magic)))
    (consp methods)))


(defun %call-next-method (magic &rest args) ; if args supplied they are new ones
  (declare (dynamic-extent args)) 
  (if args
    (apply #'%call-next-method-with-args magic args)
    (let* ((next-methods (%cadr magic))) ; don't get this closed magic stuff      
      (if (not (consp next-methods))
        ( %no-next-method  magic)            
        (let ((args (%cddr magic)))  ; get original args
          ;The unwind-protect is needed in case some hacker in his/her wisdom decides to:
          ; (defmethod foo (x) (catch 'foo (call-next-method)) (call-next-method))
          ; where the next-method throws to 'foo.
          ; The alternative is to make a new magic var with args
          ; actually not that fancy (call-next-method)(call-next-method) is same problem
          (let ()
            (unwind-protect
              (if (listp (car next-methods))
                ( %%before-and-after-combined-method-dcode magic)
                (let ((cdr (cdr next-methods)))
                  (rplaca (cdr magic)(if (not cdr)(car next-methods) cdr))
                  (let ((method-function (%method.function (car next-methods))))
                    (apply-with-method-context magic method-function args))))
              (rplaca (cdr magic) next-methods))))))))

;; Note: we need to change the compiler to call this when it can prove that
;; call-next-method cannot be called a second time. I believe thats done.


(defun %tail-call-next-method (magic)
  (let* ((next-methods (%cadr magic))  ; or make it car
         (args (%cddr magic))) ; get original args        
    (if (not (consp next-methods)) ; or consp?
      ( %no-next-method magic)
      (if (listp (car next-methods))
        ( %%before-and-after-combined-method-dcode magic)
        (let ((cdr (cdr next-methods)))
          (rplaca (cdr magic) (if (not cdr)(car next-methods) cdr))
          (apply-with-method-context magic (%method.function (car next-methods)) args))))))

; may be simpler to blow another cell so magic looks like
; (cnm-cm/nil next-methods . args) - done
; and also use first cell to mean heap-consed if itsa cons

(defun %call-next-method-with-args (magic &rest args)
  (declare (dynamic-extent args))
  (if (null args)
    (%call-next-method magic)
    (let* ((methods (%cadr magic)))
      (if (not (consp methods))
        (%no-next-method  magic)
        (let* ((cnm-cm (car magic)))
          ; a combined method
          (when (consp cnm-cm)(setq cnm-cm (car cnm-cm)))
          ; could just put the vector in car magic & no self needed in vector?
          (let ((the-vect cnm-cm)) ;  <<
            (funcall #'%%cnm-with-args-combined-method-dcode ;(%combined-method-dcode cnm-cm)
                     the-vect
                     args
                     magic)))))))



; called from x%%call-next-method-with-args - its the key-or-init-fn 
(defun %%cnm-with-args-check-initargs (init-cell args)
  ; here we forget the lexpr idea because it wants to cdr
  ;(declare (dynamic-extent args))
  (let* ((rest (cdr args))
         (first-arg (car args)))
    (declare (list rest))
    (let* ((initargs rest)
           (init-function (car init-cell))
           (instance (cond ((eq init-function #'update-instance-for-different-class)
                            (setq initargs (cdr rest))
                            (car rest))
                           ((eq init-function #'shared-initialize)
                            (setq initargs (cdr rest))
                            first-arg)
                           ((eq init-function #'update-instance-for-redefined-class)
                            (setq initargs (%cdddr rest))
                            first-arg)
                           (t first-arg)))
           (class (class-of instance))
           bad-initarg)
      (dolist (functions (cdr init-cell)
                         (error "Bad initarg: ~s to call-next-method for ~s~%on ~s"
                                bad-initarg instance (car init-cell)))
        (multiple-value-bind 
          (errorp bad-key)
          (if (eq (car functions) #'initialize-instance)
            (apply #'check-initargs instance class initargs nil
                   #'initialize-instance #'allocate-instance #'shared-initialize
                   nil)
            (apply #'check-initargs instance class initargs nil functions))
          (if errorp
            (unless bad-initarg (setq bad-initarg bad-key))
            (return t)))))))



(defun %no-next-method (magic)
  (let* ((method (%cadr magic)))
    (if (consp method) (setq method (car method)))
    (unless (typep method 'standard-method)
      (error "call-next-method called outside of generic-function dispatch context.~@
              Usually indicates an error in a define-method-combination form."))
    (let ((args (cddr magic))
          (gf (%method.gf method)))
      (if (listp args)
        (apply #'no-next-method gf method args)
        (%apply-lexpr #'no-next-method gf method args)))))




;; This makes a consed version of the magic first arg to a method.
;; Called when someone closes over the magic arg. (i.e. does (george #'call-next-method))

(defun %cons-magic-next-method-arg (magic)
  ; car is a cons as a flag that its already heap-consed! - else cnm-cm or nil
  (if (consp (car magic))
    magic
    (list* (list (car magic))
           (if (consp (%cadr magic))
             (copy-list (%cadr magic)) ; is this copy needed - probably not
             (cadr magic))
           (let ((args (%cddr magic)))
             (if (listp args)
               (copy-list args)
               (let* ((len (%lexpr-count args))
                      (l (make-list len)))
                 (do ((i 0 (1+ i))
                      (list l (cdr list)))
                     ((null list))
                   (%rplaca list (%lexpr-ref args len i)))
                 l))))))


; Support CALL-METHOD in DEFINE-METHOD-COMBINATION
(defun %%call-method* (method next-methods args)
  (let* ((method-function (%method.function method))
         (bits (lfun-bits method-function)))
    (declare (fixnum bits))
    (if (not (and (logbitp $lfbits-nextmeth-bit  bits)
                  (logbitp  $lfbits-method-bit bits)))
      (if (listp args)
        (apply method-function args)
        (%apply-lexpr method-function args))
      (let* ((cell-2 (cons next-methods args))
             (magic (cons nil cell-2)))
        (declare (dynamic-extent magic)
                 (dynamic-extent cell-2))  
        (if (null next-methods)
          (%rplaca (cdr magic) method))
        (apply-with-method-context magic method-function args)))))

; Error checking version for user's to call
(defun %call-method* (method next-methods args)
  (let* ((method-function (%method.function method))
         (bits (lfun-bits method-function)))
    (declare (fixnum bits))
    (if (not (and (logbitp $lfbits-nextmeth-bit  bits)
                  (logbitp  $lfbits-method-bit bits)))
      (progn
        (require-type method 'standard-method)
        (if (listp args)
          (apply method-function args)
          (%apply-lexpr method-function args)))
      (progn
        (do* ((list next-methods (cdr list)))
             ((null list))
          (when (not (listp list))
            (%err-disp $XIMPROPERLIST next-methods))
          (when (not (standard-method-p (car list)))
            (report-bad-arg (car list) 'standard-method))) 
        (let* ((cell-2 (cons next-methods args))
               (magic (cons nil cell-2)))
          (declare (dynamic-extent magic)
                   (dynamic-extent cell-2))  
          (if (null next-methods)
            (%rplaca (cdr magic) method))
          (apply-with-method-context magic method-function args))))))



#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
