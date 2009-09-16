;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: defstruct-lds.lisp,v $
;;  Revision 1.7  2006/02/03 22:13:33  alice
;;  ;; possible fix for defstruct :constructor and class-prototype
;;
;;  Revision 1.6  2003/12/08 08:03:54  gtbyers
;;  Don't use 68K constants anymore.  Set the "inherited" bit on inherited slots.
;;
;;  5 9/4/96   akh  conditionalize for 3.0+
;;  4 11/13/95 akh  fix for cross compiling
;;  3 10/27/95 akh  ppc/68k conditionalize defstruct-constructors
;;  (do not edit before this line!!)


; defstruct-lds.lisp
; Copyright 1995-2000 Digitool, Inc.

(in-package :ccl)

;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;; fix for case (defstruct (sbt-11 (:constructor sbt-11-con (&aux a b)))
;;   a (b 0 :type integer))
;; fix for conc-name provided NIl
;; ---- 5,2b6
;; possible fix for defstruct :constructor and class-prototype
;; ----------- 5.1 final
;; defstruct-boa-constructor allows lambda args that don't correspond to slot names (ANSI compatibility)
;; defstruct-constructor allows t as a slot name
;; -------- 4.4b5
;; 11/20/01 akh note-function-info for defstruct-predicate - bug report from gsb
;; enforce :type in slots -ANSI says implementation dependent
;; akh pass env to remove-structure-defs - or don't call it at all??
;; -------- 4.3b3
;; 06/19/99 akh change for type checking business
;; 01/30/99 akh :print-object option added
;; 12/26/96 bill   None.
;;

(eval-when (eval compile)
  (require 'defstruct-macros)
  (require 'lapmacros))

;These should be elsewhere...
#-ppc-target
(defun uvector-subtype-p (thing subtype-number)
  (old-lap-inline ()
    (move.l arg_y atemp0)
    (move.l arg_z dx)
    (getint dx)
    (move.l nilreg acc)
    (if# (and (eq (ttagp ($ $t_vector) arg_y da))
              (eq (vsubtypep dx atemp0 da)))
      (add.l ($ $t_val) acc))))

#+ppc-target
(defun uvector-subtype-p (thing subtype-number)
  (= (the fixnum (%vect-subtype thing)) subtype-number))

(defun uvector (subtype &rest p)
  (declare (dynamic-extent p))
  (let ((n (length p)) (uv))
    (setq uv #-ppc-target (%make-uvector n subtype)
             #+ppc-target (%alloc-misc n subtype))
    (dotimes (i (the fixnum n)) (declare (fixnum i)) (uvset uv i (pop p)))
    uv))

;(defmacro test (&rest args) `(macroexpand-1 (defstruct ,@args)))



(defmacro defstruct (options &rest slots &environment env)
  ;There's too much state to keep around here to break it up into little
  ;functions, so what the hell, let's do it all inline...
  (prog (struct-name type conc-name constructor copier predicate include
         print-function print-object named initial-offset boa-constructors print-p
         documentation (slot-list ()) (offset 0) superclasses sd
         refnames)
    ;Parse options
    (if (atom options)
      (setq struct-name options options ())
      (setq struct-name (pop options)))
    (unless (symbolp struct-name) (signal-program-error $XNotSym struct-name))
    (let (name args constructor-p predicate-p)
      (while options
        (if (atom (car options))
          (setq name (%car options) args ())
          (setq name (%caar options) args (%cdar options)))
        (case name
          (:conc-name
           (when conc-name (go dup-options))
           (when (cdr args) (go bad-options))
           (setq conc-name (or args (list nil))))
          (:constructor
           (when (cddr args) (go bad-options))
           (cond ((cdr args) 
                  ;(setq constructor (car args)) ;; << added - nope see below in (setq sd ...)
                  (push args boa-constructors))
                 (t (when constructor (go dup-options))
                    (unless (symbolp (%car args)) (go bad-options))
                    (setq constructor-p t constructor args))))
          (:copier
           (when copier (go dup-options))
           (when (or (cdr args) (not (symbolp (%car args)))) (go bad-options))
           (setq copier args))
          (:predicate
           (when predicate (go dup-options))
           (when (or (cdr args) (not (symbolp (%car args)))) (go bad-options))
           (setq predicate-p t predicate args))
          (:include
           (when include (go dup-options))
           (when (or (null args) (not (symbolp (car args)))) (go bad-options))
           (setq include args))
          ((:print-function :print-object)
           (when print-function (go dup-options))
           (when (or (cdr args)
                     (not (or (symbolp (%car args))
                              (and (consp (%car args)) (eq (%caar args) 'lambda)))))
             (go bad-options))
           (setq print-p t print-function (%car args))
           (when (eq name :print-object)(setq print-object t)))
          (:type 
           (when type (go dup-options))
           (when (cdr args) (go bad-options))
           (unless (eq (setq type (%car args)) 'list)
             (when (eq type 'vector) (setq type '(vector t)))
             (when (or (atom type) (neq (%car type) 'vector) (cdr (%cdr type)))
               (go bad-options))))
          (:named
           (when args (go bad-options))
           (setq named t))
          (:initial-offset
           (when initial-offset (go dup-options))
           (when (or (cdr args) (not (fixnump (%car args))) (%i< (%car args) 0))
             (go bad-options))
           (setq initial-offset (%car args)))
          (t (go bad-options)))
        (setq options (%cdr options)))
      ;Options parsed!  Do defaulting and some consistency checking.
      (cond (type 
             (when (null (defstruct-reftype type)) ;e.g. (vector NIL)
               (bad-named-arg :type type))
             (when print-p
               (error "Cannot specify ~S with ~S" :print-function :type))
             (if (and named (consp type) (eq (car type) 'vector)
                      (cadr type) (not (subtypep 'symbol (cadr type))))
               (error "Cannot specify ~S with type: ~S" :named type))
             )
            ((built-in-type-p struct-name)
             (error "Cannot redefine built-in type ~S" struct-name))
            (initial-offset
             (error "Cannot use ~S without ~S" :initial-offset :type))
            (t (setq named t)))
      (if (not named)
        (when predicate-p
          (unless (null (setq predicate (%car predicate)))
            (error "Cannot specify :PREDICATE for an unnamed structure")))
        (setq predicate (if (null predicate)
                          (concat-pnames struct-name "-P")
                          (%car predicate))))
      (setq conc-name
            (if (null conc-name) (%str-cat (symbol-name struct-name) "-")
                (if (%car conc-name) (string (%car conc-name)))))
      (unless (and boa-constructors (not constructor-p))
        (setq constructor
              (if (null constructor)
                (concat-pnames "MAKE-" struct-name) (%car constructor))))
      (setq copier
            (if (null copier) (concat-pnames "COPY-" struct-name) (%car copier))))
    ;Process included slots
    (when include
      (let* ((included-name (%car include))
             (sub-sd (or (let* ((defenv (definition-environment env)))
                          (when defenv (%cdr (assq included-name (defenv.structures defenv)))))
                         (gethash included-name %defstructs%)))
            (slots (%cdr include))
            name args ssd)
        (unless sub-sd (error "No such structure: ~S" (cons :include include)))
        (unless (eq (defstruct-reftype type)
                    (defstruct-reftype (sd-type sub-sd)))
          (error "Incompatible structure type ~S for ~S"
                 (sd-type sub-sd) (cons :include include)))
        (dolist (ssd (sd-slots sub-sd)) (push (copy-ssd ssd) slot-list))
        (while slots
          (if (atom (car slots))
            (setq name (%car slots) args ())
            (setq name (%caar slots) args (%cdar slots)))
          (unless (symbolp name) (signal-program-error $XNotSym name))
          (unless (setq ssd (named-ssd name slot-list))
            (error "~S has no ~S slot, in ~S"
                   (sd-name sub-sd) name (cons :include include)))          
          (ssd-set-initform ssd (pop args))
          (while args
            (when (atom (cdr args)) (signal-program-error "~S is not a proper list" (cdr args)))
            (cond ((eq (%car args) :type)  )
                  ((eq (%car args) :read-only)
                   (when (and (not (%cadr args)) (ssd-r/o ssd))
                     (signal-program-error "Slot ~S in ~S must be read-only" name (sd-name sub-sd)))
                   (when (%cadr args) (ssd-set-r/o ssd)))
                  (t (signal-program-error "~S must be  (member :type :read-only)." (%car args))))
            (setq args (%cddr args)))
          (setq slots (%cdr slots)))
        (setq offset (sd-size sub-sd))
        (setq superclasses (sd-superclasses sub-sd))))
    (push struct-name superclasses)
    ;Now add own slots
    (setq offset (%i+ offset (or initial-offset 0)))
    (when (and named (or type (not include)))
      (push (make-ssd 0 (if type `',struct-name `',superclasses) offset t) slot-list)
      (setq named offset offset (%i+ offset 1)))
    (when (stringp (%car slots))
      (setq documentation (%car slots) slots (%cdr slots)))
     (let (name args read-only initform)
      (while slots
         (if (atom (%car slots))
           (setq name (%car slots) args ())
           (setq name (%caar slots) args (%cdar slots)))
         (unless (symbolp name) (go bad-slot))
         (setq read-only nil initform (pop args))
         (while args
            (when (atom (cdr args)) (go bad-slot))
            (cond ((eq (%car args) :type) )
                  ((eq (%car args) :read-only)
                   (setq read-only (%cadr args)))
                  (t (go bad-slot)))
            (setq args (%cddr args)))
         (push (make-ssd name initform offset read-only) slot-list)
         (setq slots (%cdr slots) offset (%i+ offset 1))))

    (setq slot-list (nreverse slot-list))
    (when (and (null type) include)
      (ssd-set-initform (car slot-list) `',superclasses))
    #+ignore
    (when conc-name
      (dolist (slot slot-list)
        (unless (fixnump (ssd-name slot))
          (push (concat-pnames conc-name (ssd-name slot)) refnames)))
      (setq refnames (nreverse refnames)))
    (progn ;when conc-name
      (dolist (slot slot-list)
        (unless (fixnump (ssd-name slot))
          (push (if conc-name
                  (concat-pnames conc-name (ssd-name slot))
                  (ssd-name slot))
                refnames)))
      (setq refnames (nreverse refnames)))
    (setq sd (vector type slot-list superclasses offset 
                     (or constructor (and boa-constructors (caar boa-constructors))) ;; was just constructor
                     () refnames))
    (return
     `(progn
       (remove-structure-defs  ',struct-name ,env) ; lose any previous defs
        ,(defstruct-slot-defs sd refnames env)
        ,.(if constructor (list (defstruct-constructor sd constructor)))
        ,.(defstruct-boa-constructors sd boa-constructors)
        ,.(if copier (list (defstruct-copier sd copier env)))
        ,.(if predicate (defstruct-predicate sd named predicate env)) ;; added env arg here
        (eval-when (:compile-toplevel)
          (define-compile-time-structure 
            ',sd 
            ',refnames 
            ,(if (and predicate (null (sd-type sd))) `',predicate)
            ,env))        
        (%defstruct-do
         ',sd
         ,(if print-function
            (if print-object               
              (if (symbolp print-function)
                `(cons ',print-function :print-object)
                `(cons #',print-function :print-object))              
              (if (symbolp print-function)
                `',print-function
                `#',print-function))
            (unless print-p (if include 0)))
         ,(if (and predicate (null (sd-type sd))) `',predicate)
         ,.(if documentation (list documentation)))
        ,(%defstruct-compile sd refnames predicate env) ; (rest superclasses))
                                                     ; ****************************
        ',struct-name))

    dup-options
     (error "Duplicate ~S options not allowed" (%car options))
    bad-options
     (signal-program-error "Bad defstruct option ~S." (%car options))
    bad-slot
    (signal-program-error "Bad defstruct slot spec ~S." (%car slots))))

(defun concat-pnames (name1 name2)
  (intern (%str-cat (string name1) (string name2))))

(defun wrap-with-type-check (value slot &aux (slot-type (ssd-type slot)))
  (if (or (null slot-type)(eq t slot-type))
    value
    `(require-type ,value ',slot-type)))

;; from rainer but more cautious
(defun defstruct-constructor (sd constructor &aux (offset 0)
                                 (args ())
                                 (values ())
                                 slot-offset
                                 name)
  (dolist (slot (sd-slots sd))
    (setq slot-offset (ssd-offset slot))
    #-bccl (when (%i< slot-offset offset)
             (error "slots out of order! ~S" (sd-slots sd)))
    (while (%i< offset slot-offset)
      (push nil values)
      (setq offset (%i+ offset 1)))
    (if (fixnump (setq name (ssd-name slot)))
      (push (wrap-with-type-check (ssd-initform slot) slot) values)
      (if (fixnump (setq name (ssd-name slot)))
        (push (wrap-with-type-check (ssd-initform slot) slot) values)
        (let* ((temp (make-symbol (symbol-name name))))
          (push (list (list (make-keyword name) temp) (ssd-initform slot)) args)
          (push (wrap-with-type-check temp slot) values))
        #+ignore
        (let ((safe-name (if (constantp name)
                         (make-symbol (symbol-name name))
                         name)))
        (push (list safe-name (ssd-initform slot)) args)
        (push (wrap-with-type-check safe-name slot) values))
        ))
    (setq offset (%i+ offset 1)))
  (setq values (nreverse values))
  `(defun ,constructor (&key ,@(nreverse args))
     ,(case (setq name (defstruct-reftype (sd-type sd)))
        (#.$defstruct-nth `(list ,@values))
        (#.ppc::subtag-simple-vector `(vector ,@values))
        (#.ppc::subtag-struct `(%ppc-gvector ppc::subtag-struct ,@values))
        (t `(uvector ,name ,@values))) ))

#|
(defun defstruct-constructor (sd constructor &aux (offset 0)
                                                  (args ())
                                                  (values ())
                                                  slot-offset
                                                  name)
  (dolist (slot (sd-slots sd))
    (setq slot-offset (ssd-offset slot))
    #-bccl (when (%i< slot-offset offset)
             (error "slots out of order! ~S" (sd-slots sd)))
    (while (%i< offset slot-offset)
      (push nil values)
      (setq offset (%i+ offset 1)))
    (if (fixnump (setq name (ssd-name slot)))
      (push (wrap-with-type-check (ssd-initform slot) slot) values)
      (progn 
        (push (list name (ssd-initform slot)) args)
        (push (wrap-with-type-check name slot) values)))
    (setq offset (%i+ offset 1)))
  (setq values (nreverse values))
  `(defun ,constructor (&key ,@(nreverse args))
     ,(if (ppc-target-p)
        #+ppc-clos
        (case (setq name (defstruct-reftype (sd-type sd)))
          (#.$defstruct-nth `(list ,@values))
          (#.ppc::subtag-simple-vector `(vector ,@values))
          (#.ppc::subtag-struct `(%ppc-gvector ppc::subtag-struct ,@values))
          (t `(uvector ,name ,@values)))  ;??
        #-ppc-clos nil
        (case (setq name (defstruct-reftype (sd-type sd)))
          (#.$defstruct-nth `(list ,@values)) 
          (#.$v_genv  `(vector ,@values))
          (#.$v_struct `(%gvector ,$v_struct ,@values))
          (t `(uvector ,name ,@values))))))
|#

(defun defstruct-boa-constructors (sd boas &aux (list ()))
  (dolist (boa boas list)
    (push (defstruct-boa-constructor sd boa) list)))

(defun defstruct-boa-constructor (sd boa &aux (args ())
                                              (used-slots ())
                                              (values ())
                                              (offset 0)
                                              arg-kind slot slot-offset)
  (unless (verify-lambda-list (cadr boa))
    (error "Invalid lambda-list in ~S ." (cons :constructor boa)))
  (dolist (arg (cadr boa))
    (cond ((memq arg lambda-list-keywords)
           (setq arg-kind arg))
          ((setq slot (named-ssd arg (sd-slots sd)))
           (when (or (eq arg-kind '&optional) (eq arg-kind '&key))
             (setq arg (list arg (ssd-initform slot))))
           (push slot used-slots))
          ((and (consp arg) (setq slot (named-ssd (if (consp (%car arg)) (%cadar arg) (%car arg)) (sd-slots sd))))
           (push slot used-slots))
          (t nil))
    (push arg args))
  (dolist (slot (sd-slots sd))
    (setq slot-offset (ssd-offset slot))
    #-bccl (when (%i< slot-offset offset) (error "slots out of order! ~S" sd))
    (while (%i< offset slot-offset)
      (push nil values)
      (setq offset (%i+ offset 1)))
    (push (if (memq slot used-slots) (ssd-name slot)
              (if (constantp (ssd-initform slot)) (ssd-initform slot)
                  (progn
                    (unless (eq arg-kind '&aux)
                      (push (setq arg-kind '&aux) args))
                    (push (list (ssd-name slot) (ssd-initform slot)) args)
                    (ssd-name slot))))
          values)
    (setq offset (%i+ offset 1)))
  (setq values (mapcar #'wrap-with-type-check (nreverse values) (sd-slots sd)))
  `(defun ,(car boa) ,(nreverse args)
     ,(case (setq slot (defstruct-reftype (sd-type sd)))
          (#.$defstruct-nth `(list ,@values))
          (#.ppc::subtag-simple-vector `(vector ,@values))
          (#.ppc::subtag-struct `(%ppc-gvector ppc::subtag-struct ,@values))
          (t `(uvector ,slot ,@values))) ))

(defun defstruct-copier (sd copier env)
  `(progn
     (eval-when (:compile-toplevel)
       (note-function-info ',copier nil ,env))
     (fset ',copier
           ,(if (eq (sd-type sd) 'list) '#'copy-list '#'copy-uvector))))
; (put 'COPY-SHIP 'nx-alias 'copy-list)

(defun defstruct-predicate (sd named predicate env &aux (arg (gensym)))
  (let* ((sd-name (sd-name sd))
         (body
          (case (sd-type sd)
            ((nil) `(structure-typep ,arg ',sd-name))
            ((list) `(and (consp ,arg) (eq (nth ,named ,arg) ',sd-name)))
            (t `(and (uvector-subtype-p ,arg ,(defstruct-reftype (sd-type sd)))
                     (< ,named (uvsize ,arg))
                     (eq (uvref ,arg ,named) ',sd-name))))))
    `((setf (symbol-function ',predicate) #'(lambda (,arg) ,body))
      (eval-when (:compile-toplevel)(note-function-info ',predicate nil ,env)))))

; End of defstruct-lds.lisp
