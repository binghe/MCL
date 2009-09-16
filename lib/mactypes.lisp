;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  8 10/3/96  slh  def-mactype a macro - so compiler not needed at load time
;;  (do not edit before this line!!)


; standard macintosh types...
; Copyright 1990-1994 Apple Computer, Inc.  All Rights Reserved.
; Copyright 1995 Digitool, Inc.  All Rights Reserved.

;
; This file should codify all the information about foreign types (mactypes)
; that lisp knows about.
;
; Change log:
; change ct-type-check for :ostype and :fourcharcode
;; ------- 5.2b5
;; add :float = :single-float - or should it be double??
;; add :boolean_t which appears to wish to be :sint32 ??
; add some more intN things to mactypes, add type :double = :double-float (ugh)
; add variable *readonly-mactypes* - types that can't be redefined
; add sintN, uintN to mactypes
;; -------- 5.1 final
; 01/16/97 bill #'pointerp -> #'macptrp
;               Type checks shouldn't be testing for presence in the heap.
;               Sometimes you really want to pass an out-of-heap pointer.
; ------------- 4.0
; 10/04/96 slh  Bill's change to def-mactype avoids calling compile
; 09/23/96 bill Update :double-float & :single-float so that they will work as record field types
; ------------- 4.0b2
; 06/04/96 bill :single-float
; ------------- MCL-PPC 3.9
; 03/06/96 bill :signed-long and :unsigned-long mactypes type check with ostype-p instead of integerp.
; 01/30/96 bill char-int -> char-code, int-char -> code-char
; 01/02/96 gb   double-float mactype.
;  6/01/95 slh  record-field-length: hack for :str255 & friends (!DISABLED!)
;  5/25/95 slh  new interfaces-2 mods.
;  5/12/95 slh  interfaces-2 mods.
; 07/08/92 bill find-mactype converts all symbols to keywords, not just those in the *traps-package*
;-------------- 2.0
; 08/29/91 bill always compute mactype-get-function & mactype-set-function in def-mactype
; 08/23/91 gb   fix :access-operator in unsigned-byte.
; 08/14/91 bill :type-check-expand slots expand into code that does require-type
; 07/21/91 gb   in brief: access-operator, access and store-coercions, no atomic-handle-ref.
; 06/18/91 bill find-field-descriptor reports valid field names in its error message
; 06/18/91 bill fast-mactype-p requires keyword.
; 06/10/91 bill in find-mactype: don't be so eager to call load-mactype
;-------------- 2.0b2
; 5/6/91   joe  record-length rounds up to the nearest even number
; 04/08/91 bill find-mactype looks in keyword package, if mactype is a symbol
;               in the TRAPS package.
; 02/04/91 joe  record-length works on mactypes too
; 01/04/91 bill added optional autoload parameter to record-type-p & mactype-p
; 12/31/90 bill "a invalid-type" -> "an invalid-type".
; 12/22/90 joe  Filled in :name for cannonical types. Record-length is a macro.
; 11/06/90 bill handlep -> null-or-handlep
; 09/27/90 bill find-record-descriptor tries to autoload the record definition.
;               (:predicate nil) for mactype structure.
; 09/11/90 bill :QELMPTR, :PTR aliases for :POINTER.
;               :TEHandle is an alias for :HANDLE
; joe (new) 7/1990

(in-package :ccl)

(eval-when (:execute :compile-toplevel :load-toplevel)
(export '(mactype-p *mactypes*
          record-type-p find-record-descriptor record-descriptor-name
          record-descriptor-length record-descriptor-storage record-descriptor-fields
          record-descriptor-default-init-list record-length
          field-descriptor-name field-descriptor-type field-descriptor-offset
          field-descriptor-length))
)


(defstruct (mactype (:predicate nil))
  name
  record-size
  access-coercion
  store-coercion
  get-function                      ; these functions are just the compiles of
  set-function                      ; the expands (filled in automagically)
  stack-size
  stack-arg-code
  stack-return-code
  (encode-expand #'identity)
  (decode-expand #'identity)
  type-check-expand
  ct-type-check
  ff-type                           ; we should get rid of this
  access-operator
  )

(defvar %mactypes% (make-hash-table :test #'eq))
(defvar *mactypes* nil)
(defvar *readonly-mactypes* nil)

(defun find-mactype (mactype &optional (errorp t) (autoload t) &aux (type mactype))
  (when (consp mactype)
    (setq mactype (car mactype)))
  (or (gethash mactype %mactypes%)
      (and (not (find-record-descriptor
                 (if (symbolp mactype) (make-keyword mactype) mactype)
                 nil nil))
           autoload
           (symbolp mactype)
           (load-mactype mactype)
           (gethash type %mactypes%))
      (and (symbolp mactype) (not (keywordp mactype))
           (find-mactype (make-keyword mactype) nil autoload))
      (and errorp
           (error "~s is not a known Macintosh type" type))))


(defun mactype-p (type &optional (autoload t))
  (not (not (find-mactype type nil autoload))))

; Same as mactype-p but not so eager to autoload
(defun fast-mactype-p (type)
  (and (keywordp type) (mactype-p type)))

(defun array-mactype-p (type)
  (and (consp type)
       (eq (car type) :array)))

(defun string-mactype-p (type)
  (and (consp type)
       (eq (car type) :string)))

(defun mactype-pointer-to-p (type)
  (and (consp type)
       (or (eq (car type) :pointer)
           (eq (car type) :handle))))

(defun mactype-pointer-to (type)
  (cadr type))


;; Record structures & type functions
;;

(defstruct record-descriptor
  name
  length
  storage     ; storage type
  fields      ; list of field-descriptor
  default-init-list
  #+interfaces-2 packed?)

(proclaim '(notinline record-descriptor-storage))  ; allows function to be advised in new-traps

(defstruct field-descriptor
  name
  type
  offset
  length
  #+interfaces-2 packed?)

(defun find-record-descriptor (record-type &optional (errorp t) (autoload t))
  (or (gethash record-type %record-descriptors%)
      (and (not (gethash record-type %mactypes%))
           autoload
           (symbolp record-type)
           (load-record record-type)
           (gethash record-type %record-descriptors%))
      (and errorp
           (error "~s is not a valid record type" record-type))))

(defun record-type-p (record-type &optional (autoload t))
  (not (not (find-record-descriptor record-type nil autoload))))

(defun find-field-descriptor (record-type field-name &optional (errorp t))

  (let* ((record-descriptor (find-record-descriptor record-type t))
         (fields (record-descriptor-fields record-descriptor)))
    (dolist (field fields
                   (and errorp (error "~s is not a field of record: ~s~@
                                       Valid fields are: ~s" 
                                      field-name record-type
                                      (sort (mapcar #'field-descriptor-name fields)
                                            #'string-lessp))))
      (when (eq field-name (field-descriptor-name field))
        (return field)))))

(defun find-field-mactype (mactype &optional (errorp t))
  (or (find-mactype mactype nil)
      (and errorp
           (error "~s is not a known record field type" mactype))))

(defun eval-constants (s)
  (cond ((and (symbolp s) (constantp s)) (symbol-value s))
        ((consp s) (cons (eval-constants (car s)) (eval-constants (cdr s))))
        (t s)))

(defun record-field-length (field-type)
  (if (consp field-type)
    (case (car field-type)
      (:array
       #-interfaces-2 
       (* (record-field-length (cadr field-type))
          (apply #'* (eval-constants (cddr field-type))))
       #+interfaces-2
       (progn
         (when (eq (car (last field-type)) :packed)
           (setq field-type (butlast field-type)))
         (let ((length (* (record-field-length (cadr field-type))
                          (apply #'* (mapcar #'eval (cddr field-type))))))
           (if (and (eq (cadr field-type) :boolean)
                    (eq (car (last field-type)) :packed))
             (ceiling length 8)
             length))))
      (:string
       (1+ (#-interfaces-2 eval-constants
            #+interfaces-2 eval
            (cadr field-type))))
      #+obsolete
      ((:unsigned-byte :signed-byte)    ; temporary hack courtesy of slh
       1)
      (t ; must be a pointer or handle
       4))
    (or #+no (let ((length (cdr (assq field-type '((:Str255 . 256) (:Str63  .  64) (:Str32  .  33)
                                                   (:Str31  .  32) (:Str27  .  28) (:Str15  .  16))))))
               (when length
                 (warn "Record or field type ~S is now ambiguous.~&Instead use (:STRING ~D), :STRINGPTR, :CSTRINGPTR, etc.~&Returning length ~D." field-type (1- length) length)
                 length))
        (let ((type-desc (find-field-mactype field-type nil)))
          (when type-desc
            (mactype-record-size type-desc)))
        (let ((record-desc (find-record-descriptor field-type nil)))
          (when record-desc
            (record-descriptor-length record-desc)))
        (error "~s is not a record or field type" field-type))))

(defmacro record-length (record-type)
  (when (symbolp record-type)
    (setq record-type (make-keyword record-type)))
  (logand (1+ (record-field-length record-type)) #xffffffe))

;; Deftrap support
;
(defconstant *stack-code-width* 2)
(defconstant *register-code-width* 4)

(defconstant *register-arg-codes* *register-trap-arg-keywords*)
(defconstant *register-return-codes* *register-trap-output-keywords*)

(defun register-p (reg)
  (not (not (assoc reg *register-arg-codes*))))

(defconstant *d0-stack-arg-code* 2)

(defun find-arg-mactype (mactype &optional (errorp t) &aux rdesc (type mactype))
  (or (progn
        (setq rdesc (find-record-descriptor mactype nil))
        (cond ((or rdesc (array-mactype-p mactype))
               (case (record-field-length mactype)
                 ((1 2)
                  (setq mactype :record-integer))
                 ((3 4)
                  (setq mactype :record-longint))
                 (otherwise
                  (when rdesc
                    (setq mactype :pointer))))))
        (or (find-mactype mactype nil)
            (and errorp
                 (error "Unrecognized Macintosh argument type ~s" type))))
      (and (symbolp mactype)
           (not (keywordp mactype))
           (find-arg-mactype (make-keyword mactype) nil))))


;; Def-mactype & the types themselves...



(defmacro def-mactype (name struct &optional (private nil))
  (let ((name-var   (gensym "NAME"))
        (struct-var (gensym "STRUCT"))
        (arg-var    (gensym "ARG"))
        (ptr-var    (gensym "PTR"))
        (offset-var (gensym "OFFSET"))
        (thing-var  (gensym "THING"))
        (compile-time-struct (eval struct)))

    `(let ((,name-var   ,name)
           (,struct-var ,struct))
       (when (not (memq ,name-var *readonly-mactypes*))         
         (unless (mactype-name ,struct-var)
           (setf (mactype-name ,struct-var) ,name-var))
         
         ,(when (and (mactype-type-check-expand compile-time-struct)
                     (not (mactype-ct-type-check compile-time-struct)))
            `(setf (mactype-ct-type-check ,struct-var)
                   #'(lambda (,arg-var)
                       (declare (ignore-if-unused ,arg-var))
                       ,(funcall (mactype-type-check-expand compile-time-struct)
                                 arg-var))))
         
         ,(when (and (not (mactype-get-function compile-time-struct))
                     (mactype-access-operator compile-time-struct))
            `(setf (mactype-get-function ,struct-var)
                   ,(if (mactype-access-coercion compile-time-struct)
                      `#'(lambda (,ptr-var ,offset-var)
                           (declare (ignore-if-unused ,ptr-var ,offset-var))
                           ,(funcall (mactype-access-coercion compile-time-struct)
                                     (list (mactype-access-operator compile-time-struct)
                                           ptr-var
                                           offset-var)))
                      `(quote ,(mactype-access-operator compile-time-struct)))))
         
         ,(when (and (not (mactype-set-function compile-time-struct))
                     (mactype-access-operator compile-time-struct))
            `(setf (mactype-set-function ,struct-var)
                   ,(let ((access-operator (mactype-access-operator compile-time-struct)))
                      (if (mactype-store-coercion compile-time-struct)
                        `#'(lambda (,ptr-var ,offset-var ,thing-var)
                             (declare (ignore-if-unused ,ptr-var ,offset-var ,thing-var))
                             (setf (,access-operator ,ptr-var ,offset-var)
                                   ,(funcall (mactype-store-coercion compile-time-struct)
                                             thing-var)))
                        (let ((expansion (macroexpand
                                          `(setf (,access-operator pointer offset) value))))
                          (if (and (listp expansion)
                                   (symbolp (car expansion))
                                   (equal (cdr expansion) '(pointer offset value)))
                            `(quote ,(car expansion))
                            `#'(lambda (,ptr-var ,offset-var ,thing-var)
                                 (setf (,access-operator ,ptr-var ,offset-var)
                                       ,thing-var))))))))
         
         (setf (gethash ,name-var %mactypes%) ,struct-var)
         (unless ,private
           (pushnew ,name-var *mactypes*)))
       ,name-var)))


;;; Here they are!

(def-mactype :boolean 
  (make-mactype :name :boolean
                :record-size 1
                :access-coercion #'(lambda (accessform)
                                `(neq 0 ,accessform))
                :store-coercion #'(lambda (newval)
                                `(if ,newval -1 0))
                :stack-size 2
                :stack-arg-code 3
                :stack-return-code 7
                :encode-expand #'(lambda (arg) `(if ,arg -1 0))
                :decode-expand #'(lambda (call) `(%ilogbitp 8 ,call))
                :type-check-expand nil
                :ct-type-check nil
                :ff-type :word
                :access-operator '%get-byte))

(def-mactype :character
  (make-mactype :name :character
                :record-size 1
                :access-coercion #'(lambda (accessform)
                                `(%code-char ,accessform))
                :store-coercion #'(lambda (newval)
                                `(%char-code ,newval))
                :stack-size 2
                :stack-arg-code 3
                :stack-return-code 7
                :encode-expand #'(lambda (arg) `(char-code ,arg))
                :decode-expand #'(lambda (call) `(code-char ,call))
                :type-check-expand #'(lambda (arg) `(require-type ,arg 'character))
                :ct-type-check #'characterp
                :ff-type :word
                :access-operator '%get-unsigned-byte))

(def-mactype :signed-byte
  (make-mactype :name :signed-byte
                :record-size 1
                :stack-size 2 
                :stack-arg-code 3
                :stack-return-code 7
                :type-check-expand #'(lambda (arg) `(require-type ,arg 'fixnum))
                :ct-type-check #'fixnump
                :ff-type :word
                :access-operator '%get-signed-byte))

(def-mactype :sint8
  (make-mactype :name :sint8
                :record-size 1
                :stack-size 2 
                :stack-arg-code 3
                :stack-return-code 7
                :type-check-expand #'(lambda (arg) `(require-type ,arg 'fixnum))
                :ct-type-check #'fixnump
                :ff-type :word
                :access-operator '%get-signed-byte))

(def-mactype :int8 (find-mactype :sint8))  ;;  is signed right?
(def-mactype :int8_t (find-mactype :sint8))

(def-mactype :unsigned-byte
  (make-mactype :name :unsigned-byte
                :record-size 1
                :stack-size 2 
                :stack-arg-code 3
                :stack-return-code 7
                :type-check-expand #'(lambda (arg) `(require-type ,arg 'fixnum))
                :ct-type-check #'fixnump
                :ff-type :word
                :access-operator '%get-unsigned-byte))

(def-mactype :uint8
  (make-mactype :name :uint8
                :record-size 1
                :stack-size 2 
                :stack-arg-code 3
                :stack-return-code 7
                :type-check-expand #'(lambda (arg) `(require-type ,arg 'fixnum))
                :ct-type-check #'fixnump
                :ff-type :word
                :access-operator '%get-unsigned-byte))

(def-mactype :byte (find-mactype :unsigned-byte)) ; alias

(def-mactype :signed-integer
  (make-mactype :name :signed-integer
                :record-size 2
                :stack-size 2 
                :stack-arg-code 3
                :stack-return-code 7
                :type-check-expand #'(lambda (arg) `(require-type ,arg 'fixnum))
                :ct-type-check #'fixnump
                :ff-type :word
                :access-operator '%get-signed-word))

(def-mactype :sint16
  (make-mactype :name :sint16
                :record-size 2
                :stack-size 2 
                :stack-arg-code 3
                :stack-return-code 7
                :type-check-expand #'(lambda (arg) `(require-type ,arg 'fixnum))
                :ct-type-check #'fixnump
                :ff-type :word
                :access-operator '%get-signed-word))

(def-mactype :int16 (find-mactype :sint16))
(def-mactype :int16_t (find-mactype :sint16))

(def-mactype :unsigned-integer
  (make-mactype :name :unsigned-integer
                :record-size 2
                :stack-size 2 
                :stack-arg-code 3
                :stack-return-code 7
                :type-check-expand #'(lambda (arg) `(require-type ,arg 'fixnum))
                :ct-type-check #'fixnump
                :ff-type :word
                :access-operator '%get-unsigned-word))

(def-mactype :uint16
  (make-mactype :name :uint16
                :record-size 2
                :stack-size 2 
                :stack-arg-code 3
                :stack-return-code 7
                :type-check-expand #'(lambda (arg) `(require-type ,arg 'fixnum))
                :ct-type-check #'fixnump
                :ff-type :word
                :access-operator '%get-unsigned-word))

(def-mactype :integer (find-mactype :signed-integer)) ; alias
(def-mactype :signed-short (find-mactype :SInt16)) ; alias
(def-mactype :short (find-mactype :SInt16)) ; alias
(def-mactype :unsigned-short (find-mactype :UInt16)) ; alias
(def-mactype :signed-word (find-mactype :SInt16)) ; alias
(def-mactype :word (find-mactype :SInt16)) ; alias
(def-mactype :unsigned-word (find-mactype :UInt16)) ; alias

(def-mactype :signed-long
  (make-mactype :name :signed-long
                :record-size 4
                :stack-size 4
                :stack-arg-code 1
                :stack-return-code 5
                :type-check-expand nil
                :ct-type-check #'ostype-p
                :ff-type :long
                :access-operator '%get-signed-long))

(def-mactype :sint32
  (make-mactype :name :sint32
                :record-size 4
                :stack-size 4
                :stack-arg-code 1
                :stack-return-code 5
                :type-check-expand nil
                :ct-type-check #'ostype-p
                :ff-type :long
                :access-operator '%get-signed-long))

(def-mactype :unsigned-long
  (make-mactype :name :unsigned-long
                :record-size 4
                :stack-size 4
                :stack-arg-code 1
                :stack-return-code 5
                :type-check-expand nil
                :ct-type-check #'ostype-p
                :ff-type :long
                :access-operator '%get-unsigned-long))

(def-mactype :uint32
  (make-mactype :name :uint32
                :record-size 4
                :stack-size 4
                :stack-arg-code 1
                :stack-return-code 5
                :type-check-expand nil
                :ct-type-check #'ostype-p
                :ff-type :long
                :access-operator '%get-unsigned-long))

(def-mactype :long (find-mactype :signed-long)) ; alias
(def-mactype :signed-longint (find-mactype :signed-long)) ; alias
(def-mactype :longint (find-mactype :signed-long)) ; alias
(def-mactype :unsigned-longint (find-mactype :unsigned-long)) ; alias
;; some headers say typedef int		boolean_t;
(def-mactype :boolean_t (find-mactype :signed-long))  ;; ugh


(def-mactype :pointer
  (make-mactype :name :pointer
                :record-size 4
                :stack-size 4
                :stack-arg-code 0
                :stack-return-code 4
                :type-check-expand nil
                :ct-type-check #'macptrp
                :ff-type :ptr
                :access-operator '%get-ptr))

; Support old :ptr syntax
(setf (gethash :ptr %mactypes%) (find-mactype :pointer))

(def-mactype :array (find-mactype :pointer)) ; alias

;(def-mactype :qelemptr (find-mactype :pointer))

(def-mactype :handle
  (make-mactype :name :handle
                :record-size 4
                :stack-size 4
                :stack-arg-code 0
                :stack-return-code 4
                :type-check-expand #'(lambda (arg) `(require-null-or-handlep ,arg))
                :ct-type-check #'null-or-handlep
                :access-operator '%get-ptr
                #+interfaces-2 :ff-type #+interfaces-2 :ptr))

(def-mactype :TEHandle
  (find-mactype :handle))

(def-mactype :point
  (make-mactype :name :point
                :record-size 4
                :stack-size 4
                :stack-arg-code 1
                :stack-return-code 5
                :type-check-expand nil
                :ct-type-check #'integerp
                :ff-type :long
                :access-operator '%get-point))

(def-mactype :ostype
  (make-mactype :name :ostype
                :record-size 4
                :stack-size 4
                :stack-arg-code 1
                :stack-return-code 5
                :type-check-expand nil
                :ct-type-check #'ostype-p  #+ignore #'(lambda (ostype)
                                                        (or (stringp ostype)
                                                            (symbolp ostype)))
                :ff-type :long
                :access-operator '%get-ostype))

(def-mactype :FourCharCode
  (make-mactype :name :FourCharCode
                :record-size 4
                :stack-size 4
                :stack-arg-code 1
                :stack-return-code 5
                :type-check-expand nil
                :ct-type-check #'ostype-p  #+ignore #'(lambda (ostype)
                                                        (or (stringp ostype)
                                                            (symbolp ostype)))
                :ff-type :long
                :access-operator '%get-ostype))

(def-mactype :string
  (make-mactype :name :string
                :record-size 4
                :stack-size 4
                :stack-arg-code 0
                :stack-return-code 4
                :type-check-expand nil
                :ct-type-check #'macptrp
                :ff-type :ptr
                :access-operator '%get-string))

(def-mactype :invalid-type
  (make-mactype :name :invalid-type
                :record-size 0
                :stack-size 0
                :stack-arg-code nil
                :stack-return-code nil
                :type-check-expand nil
                :ct-type-check nil
                :ff-type nil))

; These are used to account for the differences between 
(def-mactype :record-integer
  (make-mactype :stack-size 2
                :encode-expand #'(lambda (arg) `(%get-signed-word ,arg))
                :stack-arg-code 3
                :stack-return-code 7
                :type-check-expand nil
                :ct-type-check #'macptrp
                :ff-type :word
                :access-operator '%get-signed-word)
  t)

(def-mactype :record-longint
  (make-mactype :stack-size 4
                :encode-expand #'(lambda (arg) `(%get-signed-long ,arg))
                :stack-arg-code 1
                :stack-return-code 5
                :type-check-expand nil
                :ct-type-check #'macptrp
                :ff-type :long
                :access-operator '%get-signed-word)
  t)

(def-mactype :double-float
  (make-mactype :stack-size 8
                :record-size 8
                :ff-type :double-float
                :access-operator '%get-double-float)
  nil)

(def-mactype :double (find-mactype :double-float))

(def-mactype :single-float
  (make-mactype :stack-size 4
                :record-size 4
                :ff-type :single-float
                :access-operator '%get-single-float)
  nil)

(def-mactype :float (find-mactype :single-float))  ;; ??

(eval-when (:load-toplevel :execute)
  (maphash #'(lambda (k v)(declare (ignore v))(pushnew  k *readonly-mactypes*)) %mactypes%))


(provide 'mactypes)

#|
	Change History (most recent last):
	2	1/2/95	akh	nothing really
|# ;(do not edit past this line!!)
