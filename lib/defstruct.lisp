;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  8 9/4/96   akh  conditionalization for 3.0+
;;  6 12/12/95 akh  conditionalize at runtime not read time
;;  5 11/13/95 akh  fix for cross compiling - no trying to send 68k fns to ppc either in defstruct itself or in usages thereof
;;  4 10/31/95 akh  defstruct-reftype for both targets - should use new typecode regimen
;;  2 10/27/95 akh  defstruct-ref-transform conditionalized fer ppc/68k
;;  2 2/2/95   akh  merge leibniz patches
;;  (do not edit before this line!!)

(in-package :ccl)

; Defstruct.lisp
; Copyright 1987-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

;; Modification History
; $Log: defstruct.lisp,v $
; Revision 1.7  2006/02/03 22:16:25  alice
; ; remove-structure-defs nukes %class.prototype
;
; Revision 1.6  2004/03/27 21:52:25  alice
; ; change-class gets &allow-other-keys
;
; Revision 1.5  2004/01/13 13:01:26  gtbyers
; COPY-STRUCTURE: typecheck arg for STRUCTURE-OBJECT
;
; Revision 1.4  2003/12/08 08:05:15  gtbyers
; Set $struct_inherited bit.  Don't use 68K constants anymore.
;
; remove-structure-defs nukes %class.prototype
; ------- 5.1 final
; change-class gets &allow-other-keys
; -------- 5.1b1
; 07/19/99 akh add some ,@(if predicate ...) in slot-accessor-fn
; --------- 4.3f1c1
; akh add function find-sub-sd that looks in env first - called by name-clash, sd-refname-pos-in-included-struct
;     and remove-structure-defs. Callers of those pass env.
; --------------4.3b3

; akh sd-refname-pos-in-included-struct had a bug
; 06/19/99 akh type-checking structure-refs when debug 3 from Ralf Moeller.
; 04/30/99 akh add copy-structure (ansi cl)
;---------------- 4.3b1
; 01/13/98 akh   remove-structure-defs - don't nuke the print-function
; 11/19/97 akh   change-class takes initargs per ANSI CL
; 03/06/97 akh   change-class deletes the inline definitions for refnames from *nx-globally-inline*
;		 also delete predicate, print-fn and constructor.
; 12/26/96 bill  New function: sd-refname-pos-in-included-struct.
;                defstruct-slot-defs excludes from the generated declarations
;                any accessor names that are defined by an included structure.
;                %defstruct-compile checks to see if any of the accessor names
;                are defined by an included structure. If so, it generates no code
;                for them. Instead, it warns if they are at a different offset in the
;                structure.
; -------------  4.0
; 03/21/96 bill  gb's fix to slot-accessor-fn
; 10/27/95 slh   fix (?) defstruct-reftype
;  4/06/95 slh   fns from defstruct-macros here
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
;11/11/91 gb   remember when no :print-function and :include so WRITE-A-FUNCTION knows
;              to look at superclasses' print functions.
;------------ 2.0b3
;06/25/91 gb   defstruct does (EVAL-WHEN (:COMPILE-TOPLEVEL) ...), note-function-info
;              on accessors.
;03/04/91 alice no more report-bad-arg with one argument,  some of these => program-error
;------------- 2.0b1
;01/11/91 bill note-function-info in defstruct-copier
;10/24/90 bill in defstruct: allow NIL predicate for typed structure.
;09/27/90 bill remove old predicate when redefining a structure.
;10/16/90 gb   allow &key, etc. in BOA-constructers.
;06/07/90 bill %defstruct calls %define-structure-class
;03/25/90  gz Allow for element-type-subtype returning NIL.  Check for
;             built-in classes.
; 01/03/89 gz Don't use page-type...
; 11/26/89 gz %structure-refs% hash table.
;             Look for compile-time defstructs for :include's.
;             Store superclasses list in slot 0 of structures.
;             %defstructs% hash table
; 10/4/89 gz  fset-globally -> fset.
; 11/10/89 gb? (macro defstruct ...) => (defmacro defstuct ...)
; 5/18/89 gz  fake %structure-class-of def.
;12/26/88 gz  Create accessor fns at load-time (as closures).
;             Do real-structure predicates inline.
;             fasload print defstructs.
;11/19/88 gz  less hair with concat-pnames.
; 11/6/88 gb  more hair with concat-pnames.
; 9/2/88  gz  No more list-nreverse.  copy-uvector -> l1-aprims.
; 8/25/88 gz  Reorganized somewhat for proper compile-time processing.
;             Intern concatenated names in the original package.
;	      Flush random state stuff.
; 8/17/88 gz  fix construct-random-state for lisp-8.
; 6/13/88 as   define-structure pays attention to *save-doc-strings*
;12/4/88  cfry in slot-accessor-fn, nineth -> ninth
; 4/8/88  gz  new macptr scheme
; 12/23/87 cfry fixed defstruct to error if :named and specified type of
;           vector which can't take elements of type symbol.
; 12/11/87 cfry fixed construct-random-state for reading of a random-state
; 8/02/87 gz bounds check in predicate for :type vector.
; 7/31/87 gb define-structure puts doc on plist via setf-documentation.
; 7/29/87 gb fwd-ref-print-function bug.
; 7/25/87 gb moved structure-class-p to sysutils.  Proclaim accessors inline.
; 7/15/87 gz New

(eval-when (eval compile)
  (require 'defstruct-macros)
  (require 'lapmacros))

(require 'hash)

(defvar %structure-refs% (make-hash-table :test #'eq))
(defvar %defstructs% (make-hash-table :test #'eq))

(defun make-ssd (name initform offset r/o &optional (type t))
  (let ((refinfo (%ilogior2 offset (if r/o #x1000000 0))))
    (list* name initform
           (if (eq type 't)
             refinfo
             (cons type refinfo)))))

(declaim (inline type-and-refinfo-p))
(defun type-and-refinfo-p (object)
  (or (fixnump object) (consp object)))

(defun ssd-set-reftype (ssd reftype)
  (ssd-update-refinfo (ssd refinfo)
                      (%ilogior2 (%ilogand2 #x300FFFF refinfo)
                                 (%ilsl 16 reftype))))

(defun ssd-set-r/o (ssd) 
  (ssd-update-refinfo (ssd refinfo)
                      (%ilogior2 #x1000000 refinfo)))

(defun ssd-set-inherited (ssd)
  (ssd-update-refinfo (ssd refinfo)
		       (bitset $struct-inherited refinfo)))

(defun copy-ssd (ssd)
  (let* ((cdr (cdr ssd))
         (cddr (cdr cdr)))
    (list* (%car ssd) (%car cdr)
           (if (consp cddr)
             (list* (%car cddr) (%cdr cddr))
             cddr))))

(declaim (inline ssd-type-and-refinfo))
(defun ssd-type-and-refinfo (ssd)
  (cddr ssd))

(defun ssd-type (ssd)
  (let ((type-and-refinfo (ssd-type-and-refinfo ssd)))
    (if (consp type-and-refinfo)
      (%car type-and-refinfo)
      't)))

(defun ssd-refinfo (ssd)
  (let ((type-and-refinfo (ssd-type-and-refinfo ssd)))
    (if (consp type-and-refinfo) (%cdr type-and-refinfo) type-and-refinfo)))

(defun %structure-class-of (thing)
  (find-class (struct-name thing)))

;These might want to compiler-transform into non-typechecking versions...
(defun struct-ref (struct offset)
  (if (structurep struct) (uvref struct offset)
      (report-bad-arg struct 'structure)))

(defun struct-set (struct offset value)
  (if (structurep struct) (uvset struct offset value)
      (report-bad-arg struct 'structure)))

(defsetf struct-ref struct-set)

(defun optimize-structure-access (env)
  (nx-allow-transforms env))  ;; match with what this does (debug /= 3 compilation-speed /= 3)
                              ;; because if allow-transforms is true then the accessors open-code
#|
  (and (<= (safety-optimize-quantity env) 2)
       (>= (speed-optimize-quantity env) 1)
       (< (debug-optimize-quantity env) 3)))  ;; was 2
|#

(defun name-clash (accessor-name superclasses env)
  (loop for superclass in superclasses 
        for sd = (find-sub-sd superclass env)
        thereis (and sd
                     (find accessor-name (sd-refnames sd)))))



; things for defstruct to do - at load time
(defun %defstruct-do (sd print-function predicate &optional doc &aux (name (sd-name sd)))
  ;(declare (ignore refnames))  
  (when (null (sd-type sd))
    (%define-structure-class sd))
  (sd-set-print-function sd print-function)
  (when (and doc *save-doc-strings* #-bccl (fboundp 'set-documentation))
    (set-documentation name 'structure doc))  
  (puthash name %defstructs% sd)
  (record-source-file name 'structure)
  (when (and predicate (null (sd-type sd)))
    (puthash predicate %structure-refs% name))  
  (when *fasload-print* (format t "~&~S~%" name))
  name)


(defun find-sub-sd (included-name env)
  (or (let* ((defenv (definition-environment env)))
        (when defenv (%cdr (assq included-name (defenv.structures defenv)))))
     
      (gethash included-name %defstructs%)))

(defun sd-refname-pos-in-included-struct (sd name env)
  (dolist (included-type (cdr (sd-superclasses sd)))
    (let ((sub-sd (find-sub-sd included-type env)))
      (when sub-sd
        (let ((refnames (sd-refnames sub-sd)))
          (if refnames
            (let ((pos (position name refnames :test 'eq)))
              (when pos (return-from sd-refname-pos-in-included-struct (1+ pos))))
            (dolist (slot (sd-slots sub-sd))
              (let ((ssd-name (ssd-name slot)))
                (unless (fixnump ssd-name)
                  (when (eq name ssd-name)
                    (return-from sd-refname-pos-in-included-struct
                      (ssd-offset slot))))))))))))

; return stuff for defstruct to compile
(defun %defstruct-compile (sd refnames predicate env)
  (let ((stuff))    
    (dolist (slot (sd-slots sd))
      (unless (fixnump (ssd-name slot))
        (let* ((accessor (if refnames (pop refnames) (ssd-name slot)))
               (pos (sd-refname-pos-in-included-struct sd accessor env)))
          (if pos
            (let ((offset (ssd-offset slot)))
              (unless (eql pos offset)
                ; This should be a style-warning
                (warn "Accessor ~s at different position than in included structure"
                      accessor)))
            (let ((fn (slot-accessor-fn slot accessor predicate env)))
              ;(unless fn (print (list slot accessor predicate env superclasses)))
              (push
               `(progn
                  ,fn
                  (puthash ',accessor %structure-refs% ',(ssd-type-and-refinfo slot)))
               
               stuff))))))
    `(progn ,@(nreverse stuff))))


; no #. for cross compile
(defvar *struct-ref-vector* 
  (vector #'(lambda (x) (declare (optimize (safety 3))) (struct-ref x 0))
          #'(lambda (x) (declare (optimize (safety 3))) (struct-ref x 1))
          #'(lambda (x) (declare (optimize (safety 3))) (struct-ref x 2))
          #'(lambda (x) (declare (optimize (safety 3))) (struct-ref x 3))
          #'(lambda (x) (declare (optimize (safety 3))) (struct-ref x 4))
          #'(lambda (x) (declare (optimize (safety 3))) (struct-ref x 5))
          #'(lambda (x) (declare (optimize (safety 3))) (struct-ref x 6))
          #'(lambda (x) (declare (optimize (safety 3))) (struct-ref x 7))
          #'(lambda (x) (declare (optimize (safety 3))) (struct-ref x 8))
          #'(lambda (x) (declare (optimize (safety 3))) (struct-ref x 9))))

(defvar *svref-vector*
  (vector #'(lambda (x) (declare (optimize (safety 3))) (svref x 0))
          #'(lambda (x) (declare (optimize (safety 3))) (svref x 1))
          #'(lambda (x) (declare (optimize (safety 3))) (svref x 2))
          #'(lambda (x) (declare (optimize (safety 3))) (svref x 3))
          #'(lambda (x) (declare (optimize (safety 3))) (svref x 4))
          #'(lambda (x) (declare (optimize (safety 3))) (svref x 5))
          #'(lambda (x) (declare (optimize (safety 3))) (svref x 6))
          #'(lambda (x) (declare (optimize (safety 3))) (svref x 7))
          #'(lambda (x) (declare (optimize (safety 3))) (svref x 8))
          #'(lambda (x) (declare (optimize (safety 3))) (svref x 9))))


; too bad there isnt a way to suppress generating these darn functions when you dont want them.
; Makes no sense to fetch functions from a vector of 68K functions and send them over to PPC.
; So can use that space optimization iff host and target are the same.

(defun slot-accessor-fn (slot name predicate env ; superclasses
                                               ; ************
                              &aux (ref (ssd-reftype slot))
                              (offset (ssd-offset slot)))
     
  (let ((host-is-target (if (ppc-target-p)
                          #+powerpc t #-powerpc nil
                          #+powerpc nil #-powerpc t)))
    (if (not (optimize-structure-access env))
      (cond ((eq ref $defstruct-nth) 
             (if (and host-is-target (%i< offset 10))  				 ;; ??? and host = target
               `(defun ,name (structure)
                  ,@(if predicate `((setq structure (%require-type structure ',predicate))))
                  (,(%svref '#(first second third fourth fifth
                                     sixth seventh eighth ninth tenth) offset)
                   structure))
               `(defun ,name (x) (declare (optimize (safety 3)))
                       ,@(if predicate `((setq x (%require-type x ',predicate))))
                       (nth ,offset x))))
            
            ((eq ref ppc::subtag-struct) 
             (if (and host-is-target (%i< offset 10))
               `(defun ,name (structure)
                  ,@(if predicate `((setq structure (%require-type structure ',predicate))))
                  (funcall ,(%svref *struct-ref-vector* offset)
                           structure))
               `(defun ,name (structure) (declare (optimize (safety 3)))
                       ,@(if predicate `((setq structure (%require-type structure ',predicate))))
                       (struct-ref structure ,offset))))
            
            ((eq ref ppc::subtag-simple-vector)
             (if (and host-is-target (%i< offset 10)) 
               `(defun ,name (structure)
                  ,@(if predicate `((setq structure (%require-type structure ',predicate))))
                  (funcall ,(%svref *svref-vector* offset)
                           structure))
               `(defun ,name (structure) (declare (optimize (safety 3)))
                       ,@(if predicate `((setq structure (%require-type structure ',predicate))))
                       (svref structure ,offset))))
            (t `(defun ,name (x) (uvref x ,offset))))
      (cond ((eq ref $defstruct-nth) 
             (if (and host-is-target (%i< offset 10))  				 ;; ??? and host = target
               `(fset ',name
                      ,(symbol-function
                        (%svref '#(first second third fourth fifth
                                         sixth seventh eighth ninth tenth) offset)))
               `(defun ,name (x) (declare (optimize (safety 3))) (nth ,offset x))))
            ((eq ref ppc::subtag-struct) 
             (if (and host-is-target (%i< offset 10))		 ; ??? host = target
               `(fset ',name ,(%svref *struct-ref-vector* offset))
               `(defun ,name (x) (declare (optimize (safety 3))) (struct-ref x ,offset))))
            ((eq ref ppc::subtag-simple-vector)
             (if (and host-is-target (%i< offset 10))   			 	; ??? host = target
               `(fset ',name ,(%svref *svref-vector* offset))
               `(defun ,name (x) (declare (optimize (safety 3))) (svref x ,offset))))
            (t `(defun ,name (x) (uvref x ,offset)))))))

(defun defstruct-reftype (type)
  (cond ((null type) ppc::subtag-struct)
        ((eq type 'list) $defstruct-nth)
        (t (element-type-subtype (cadr type)))))

#|
(defun defstruct-slot-defs (sd refnames env)
  (let ((ref (defstruct-reftype (sd-type sd))) name defs)
    (dolist (slot (sd-slots sd))
      (ssd-set-reftype slot ref)
      (unless (fixnump (setq name (ssd-name slot))) ;Ignore fake 'name' slots
        (when refnames (setq name (pop refnames)))
        (unless (sd-refname-pos-in-included-struct sd name env)
          (push name defs))))
    (setq defs (nreverse defs))
    `(progn
       (eval-when (:compile-toplevel)
         ,@(mapcar #'(lambda (name) `(note-function-info ',name nil ,env)) defs))
       (declaim (inline ,@defs)))))
|#

(defun defstruct-slot-defs (sd refnames env)
  (let ((ref (defstruct-reftype (sd-type sd))) name defs)
    (dolist (slot (sd-slots sd))
      (ssd-set-reftype slot ref)
      (unless (fixnump (setq name (ssd-name slot))) ;Ignore fake 'name' slots
        (when refnames (setq name (pop refnames)))
        (unless (sd-refname-pos-in-included-struct sd name env)
          (push name defs))))
    (setq defs (nreverse defs))
    `(progn
       (eval-when (:compile-toplevel)
         ,@(mapcar #'(lambda (name) `(note-function-info ',name nil ,env)) defs))
       ,@(when (optimize-structure-access env)
           `((declaim (inline ,@defs)))))))

;Used by setf and whatever...
(defun defstruct-ref-transform (predicate-or-type-and-refinfo args)
  (if (type-and-refinfo-p predicate-or-type-and-refinfo)
    (multiple-value-bind (type refinfo)
                         (if (consp predicate-or-type-and-refinfo)
                           (values (%car predicate-or-type-and-refinfo)
                                   (%cdr predicate-or-type-and-refinfo))
                           (values 't predicate-or-type-and-refinfo))
      (let* ((offset (refinfo-offset refinfo))
             (ref (refinfo-reftype refinfo))
             (accessor
              (cond ((eq ref $defstruct-nth)
                     `(nth ,offset ,@args))
                    ((eq ref ppc::subtag-struct)
                     `(struct-ref ,@args ,offset))
                    ((eq ref ppc::subtag-simple-vector)
                     `(svref ,@args ,offset))
                    (t `(uvref ,@args ,offset)))))
        (if (eq type 't)
          accessor
          `(the ,type ,accessor))))
    `(structure-typep ,@args ',predicate-or-type-and-refinfo)))

; Should probably remove the constructor, copier, and predicate as
; well. Can't remove the inline proclamations for the refnames,
; as the user may have explicitly said this. Questionable - but surely
; must delete the inline definitions.
; Doesn't remove the copier because we don't know for sure what it's name is
(defmethod change-class ((from structure-class) (to class) &rest initargs &key &allow-other-keys)
  (declare (dynamic-extent initargs))
  (declare (ignore initargs))
  (let ((class-name (class-name from)))
    (unless (eq from to)                  ; shouldn't be
      (remove-structure-defs class-name)
      (remhash class-name %defstructs%)))
  (call-next-method))

; if redefining a structure as another structure or redefining a structure as a class
(defun remove-structure-defs (class-name &optional env)
  (let ((sd (find-sub-sd class-name env))) ;(gethash class-name %defstructs%)))
    (when sd
      (dolist (refname (sd-refnames sd))
        (unless (name-clash refname (cdr (sd-superclasses sd)) env)  ;; added CDR here
          (remhash refname %structure-refs%)
          (let ((def (assq refname *nx-globally-inline*)))
            (when def (set-function-info refname nil)))
          (when (symbolp refname)
            ;(unless (name-clash refname (sd-superclasses sd))
              (fmakunbound refname))))
      (let ((class (find-class class-name nil))) ;; added 11/15/05
        (when class
          (setf (%class.prototype class) nil)))
      #|
      (let ((print-fn (sd-print-function sd)))
        (when (symbolp print-fn) (fmakunbound print-fn)))
       |#
      (let ((constructor (sd-constructor sd)))
        (when (symbolp constructor) (fmakunbound constructor)))
      (let ((delete-match #'(lambda (pred struct-name)
                              (when (eq struct-name class-name)
                                (remhash pred %structure-refs%)
                                (fmakunbound pred)))))
        (declare (dynamic-extent delete-match))
        ; get rid of the predicate
        (maphash delete-match %structure-refs%)))))

(defun copy-structure (struc)
  (require-type struc 'structure-object)
  (copy-uvector struc)) 


(provide 'defstruct)

; End of defstruct.lisp
