;;;-*- Mode: Lisp; Package: CCL -*-

;; $Log: ppc-optimizers.lisp,v $
;; Revision 1.3  2002/11/22 10:12:43  gtbyers
;; Lose compiler macro for MAKE-UARRAY-1.
;;
;; Revision 1.2  2002/11/18 05:36:28  gtbyers
;; Add CVS log marker
;;
;;	Change History (most recent first):
;; make-string compiler-macro was too forgiving re element-type
;; ------- 5.2b6
;; lose compiler macros for sbit and %sbitset - dont work for some reason - put back -problem fixed
;; ------ MCL 5.1b2
;;  5 10/26/95 gb   compiler-macros for %instance, %pool, %population
;;  2 10/6/95  gb   SBIT, at least.
;;  (do not edit before this line!!)

;; 01/10/00 akh compiler macro for float
;; 01/19/99 akh  some base-char = base-character stuff
;; 12/31/98 akh   lose compiler-macros for aref and aset
;; 03/01/97 gb    short-float mods.
;; ---- 4.0
;; 06/16/96 gb    ppc-subtag-bytes was already defined in level-0.
;; ---- 3.9
;; 03/28/96 bill  lockp
;; 03/24/96 gb    2-d aset/aref, arrayp, vectorp, ratiop, complexp.
;; 02/23/96 bill  ff-call handles return value in :d0 if all the args are 4 bytes
;; 02/22/96 bill  ff-call
;; 01/03/96 gb    move def of *ppc-target-compiler-macros* elsewhere.
;; 12/13/95 bill  nuke the "Can't transform MAKE-ARRAY call ~s" warning

;; This is all done for bootstrapping; when we get running native,
;; we should just remove the mechanism.
;; This is supposed to isolate platform-specific differences
;; between the two implementations.

(eval-when (:compile-toplevel :execute)
  (require "PPC-ARCH"))


(eval-when (:compile-toplevel :load-toplevel :execute)



(defun (setf ppc-compiler-macro-function) (new name)
  (unless (symbolp name) (report-bad-arg name 'symbol))
  (if new
    (setf (gethash name *ppc-target-compiler-macros*) new)
    (remhash name *ppc-target-compiler-macros*))
  new)

(defmacro define-ppc-compiler-macro  (name arglist &body body &environment env)
  (unless (symbolp name) (report-bad-arg name 'symbol))
  (let ((body (parse-macro-1 name arglist body env)))
    `(eval-when (:compile-toplevel :load-toplevel :execute)
       (setf (ppc-compiler-macro-function ',name)
             (nfunction (ppc-compiler-macro-function ,name) ,body))         
       ',name)))

)

(define-ppc-compiler-macro arrayp (arg)
  `(>= (the fixnum (ppc-typecode ,arg)) #.ppc::subtag-arrayH))

(define-ppc-compiler-macro vectorp (arg)
  `(>= (the fixnum (ppc-typecode ,arg)) #.ppc::subtag-vectorH))


(define-ppc-compiler-macro fixnump (arg)
  `(eql (ppc-lisptag ,arg) #.ppc::tag-fixnum))

#|
(define-ppc-compiler-macro float (&whole w number &optional other)
  (declare (ignore number other))
  w)
|#

(define-ppc-compiler-macro float (&whole call &environment env number &optional other)
  ;; gets unused var warning sometimes if only use of other (if a var) is here - unlikely
  (if (nx-form-typep other 'short-float env) ; (typep other 'short-float)
    `(the short-float (%short-float ,number))
    (if (nx-form-typep other 'double-float env)
      `(the double-float (%double-float ,number))
      call)))
  

(define-ppc-compiler-macro double-float-p (n)
  `(eql (ppc-typecode ,n) #.ppc::subtag-double-float))

#+no-sf
(define-ppc-compiler-macro short-float-p (n)
  `(double-float-p ,n))

#-no-sf
(define-ppc-compiler-macro short-float-p (n)
  `(eql (ppc-typecode ,n) #.ppc::subtag-single-float))

#+no-sf
(define-ppc-compiler-macro floatp (n)
  `(double-float-p ,n))

#-no-sf
(define-ppc-compiler-macro floatp (n)
  (let* ((typecode (make-symbol "TYPECODE")))
    `(let* ((,typecode (ppc-typecode ,n)))
       (declare (fixnum ,typecode))
       (or (= ,typecode #.ppc::subtag-double-float)
           (= ,typecode #.ppc::subtag-single-float)))))

(define-ppc-compiler-macro functionp (n)
  `(eql (ppc-typecode ,n) #.ppc::subtag-function))

(define-ppc-compiler-macro listp (n)
  `(eql (ppc-lisptag ,n) #.ppc::tag-list))

(define-ppc-compiler-macro consp (n)
  `(eql (ppc-fulltag ,n) #.ppc::fulltag-cons))

(define-ppc-compiler-macro bignump (n)
  `(eql (ppc-typecode ,n) #.ppc::subtag-bignum))

(define-ppc-compiler-macro ratiop (n)
  `(eql (ppc-typecode ,n) #.ppc::subtag-ratio))

(define-ppc-compiler-macro complexp (n)
  `(eql (ppc-typecode ,n) #.ppc::subtag-complex))

#|
(define-ppc-compiler-macro aref (&whole call a &rest subscripts)
  (if (= 2 (length subscripts))
    `(%aref2 ,a ,(car subscripts) ,(cadr subscripts))
    call))

(define-ppc-compiler-macro aset (&whole call a &rest subs&val)
  (if (= 3 (length subs&val))
    `(%aset2 ,a ,(car subs&val) ,(cadr subs&val) ,(caddr subs&val))
    call))
|#


(define-ppc-compiler-macro make-sequence (&whole call &environment env typespec len &rest keys &key initial-element)
  (declare (ignore typespec len keys initial-element))
  call)

(define-ppc-compiler-macro make-string (&whole call size &rest keys)     
  (if (constant-keywords-p keys)
    (destructuring-bind (&key (element-type () element-type-p)
                              (initial-element () initial-element-p))
                        keys
      (if (not element-type-p)
        `(%alloc-misc ,size #.ppc::subtag-simple-general-string ,@(if initial-element-p `(,initial-element)))
        (if (quoted-form-p element-type)
          (let* ((element-type (cadr element-type)))
            (if (memq element-type '(base-character base-char standard-char))
              `(%alloc-misc ,size #.ppc::subtag-simple-base-string ,@(if initial-element-p `(,initial-element)))
              (if (subtypep element-type 'character)
                `(%alloc-misc ,size #.ppc::subtag-simple-general-string ,@(if initial-element-p `(,initial-element)))
                call)))
          call)))
    call))



(define-ppc-compiler-macro sbit (&environment env &whole call v &optional sub0 &rest others)
  (if (and sub0 (null others))
    `(%typed-miscref #.ppc::subtag-bit-vector ,v ,sub0)
    call))

(define-ppc-compiler-macro %sbitset (&environment env &whole call v sub0 &optional (newval nil newval-p) &rest newval-was-really-sub1)
  (if (and newval-p (not newval-was-really-sub1) )
    `(%typed-miscset #.ppc::subtag-bit-vector ,v ,sub0 ,newval)
    call))


(define-ppc-compiler-macro simple-base-string-p (thing)
  `(= (the fixnum (ppc-typecode ,thing)) #.ppc::subtag-simple-base-string))

(define-ppc-compiler-macro allocate-typed-vector (type-keyword elements &optional (init nil init-p))
  (allocate-typed-vector-form type-keyword elements init init-p :ppc))

(define-ppc-compiler-macro gvector (type-keyword &rest inits)
  (gvector-form type-keyword inits :ppc))


(defun xppc-element-type-subtype (type)
  "Convert element type specifier to internal array subtype code"
  (cond ;Check for some common cases explicitly before going into a
   ;full subtypep...
   ((eq type t) ppc::subtag-simple-vector)
   ((or (eq type 'extended-character)(eq type 'character)(eq type 'extended-char)) ppc::subtag-simple-general-string)
   ((or (eq type 'base-character)(eq type 'base-char)) ppc::subtag-simple-base-string)
   ((eq type 'bit) ppc::subtag-bit-vector)
   ((eq type 'double-float) ppc::subtag-double-float-vector)
   ((eq type 'short-float) ppc::subtag-single-float-vector)
   ((and (consp type)
         (if (eql (%car type) 'signed-byte)
           (let ((size (car (%cdr type))))
             (and (null (%cddr type))
                  (fixnump size)
                  (%i< 0 size)
                  (cond ((%i<= size 8) ppc::subtag-s8-vector)
                        ((%i<= size 16) ppc::subtag-s16-vector)
                        ((%i<= size 32) ppc::subtag-s32-vector)
                        (t ppc::subtag-simple-vector))))
           (and (eql (%car type) 'unsigned-byte)
                (let ((size (car (%cdr type))))
                  (and (null (%cddr type))
                       (fixnump size)
                       (%i< 0 size)
                       (cond ((eq size 1) ppc::subtag-bit-vector)
                             ((%i<= size 8) ppc::subtag-u8-vector)
                             ((%i<= size 16) ppc::subtag-u16-vector)
                             ((%i<= size 32) ppc::subtag-u32-vector)
                             (t ppc::subtag-simple-vector))))))))
   ((subtypep type 'bit) ppc::subtag-bit-vector)
   ((subtypep type '(signed-byte 8)) ppc::subtag-s8-vector)
   ((subtypep type '(unsigned-byte 8)) ppc::subtag-u8-vector)
   ((subtypep type '(signed-byte 16)) ppc::subtag-s16-vector)
   ((subtypep type '(unsigned-byte 16)) ppc::subtag-u16-vector)
   ((subtypep type '(signed-byte 32)) ppc::subtag-s32-vector)
   ((subtypep type '(unsigned-byte 32)) ppc::subtag-u32-vector)
   ((subtypep type 'double-float) ppc::subtag-double-float-vector)
   ((subtypep type 'short-float) ppc::subtag-single-float-vector)
   ((subtypep type 'base-character) ppc::subtag-simple-base-string)
   ((subtypep type 'character) ppc::subtag-simple-general-string)
   ((subtypep type nil) nil)
   ((not (type-specifier-p type)) nil)
   (t ppc::subtag-simple-vector)))


(defsetf %misc-ref %misc-set)

(defun make-c-proc-info (arg-types return-type)
  (make-proc-info arg-types return-type #$kCStackBased))

(define-ppc-compiler-macro ff-call (upp &rest 68k-args)
  (or (simple-ppc-ff-call upp 68k-args)
      `(ff-call-68k-macro ,upp ,@68k-args)))

; Handle stack based args and either a stack return or return in :d0.
; Return NIL if it's a harder case.
(defun simple-ppc-ff-call (upp 68k-args)
  (let ((types nil)
        (ppc-arglist nil)
        (return-type nil)
        (ppc-return-type nil))
    (loop
      (when (null 68k-args) (return))
      (let* ((type (pop 68k-args))
             (return-type? (null 68k-args)) 
             (ppc-type (if (and return-type? (eq type :d0))
                         :signed-fullword
                         (mactype=>ppc-ff-call-type
                          (or (find-mactype type nil)
                              (return-from simple-ppc-ff-call nil))))))
        (when return-type?
          (setq return-type type
                ppc-return-type ppc-type)
          (return))
        (let ((arg (pop 68k-args)))
          (push type types)
          (push ppc-type ppc-arglist)
          (push arg ppc-arglist))))
    (if (neq return-type :d0)
      `(ppc-ff-call (or *call-universal-proc-address* (get-call-universal-proc-address))
                    :address
                    ,upp
                    :signed-fullword
                    ,(make-proc-info (nreverse types) return-type)
                    ,@(nreverse ppc-arglist)
                    ,ppc-return-type)
      ; Can handle a return value in :d0 if all the args are 4 bytes.
      ; We just tell the emulator that we're using C calling conventions
      ; and pass the args in the opposite order
      (let ((ppc-types nil)
            (ppc-args nil)
            (gensyms nil))
        (loop
          (when (null ppc-arglist) (return))
          (push (pop ppc-arglist) ppc-args)
          (let ((type (pop ppc-arglist)))
            (unless (memq type '(:signed-fullword :unsigned-fullword :address))
              (return-from simple-ppc-ff-call nil))
            (push type ppc-types)
            (push (gensym) gensyms)))
        `(let ,(mapcar 'list gensyms ppc-args)
           (declare (dynamic-extent ,@gensyms))
           (ppc-ff-call (or *call-universal-proc-address* (get-call-universal-proc-address))
                        :address
                        ,upp
                        :signed-fullword
                        ,(make-c-proc-info types :long)
                        ,@(mapcan 'list (nreverse ppc-types) (reverse gensyms))
                        ,ppc-return-type))))))

(define-ppc-compiler-macro lockp (lock)
  `(eq ppc::subtag-lock (ppc-typecode ,lock)))

(provide "PPC-OPTIMIZERS")
