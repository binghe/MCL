;;;-*-Mode: LISP; Package: CCL -*-
; defrecord.lisp

; Copyright 1986-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995 Digitool, Inc.

; Modification History:
;; define-record - warn vs error if duplicate field names
;; ----- 5.2b4
;; add somemore int64 records
;; variable *readonly-records* - can't be redefined
;; rlet of :array allows local variable(s) or expressions(s) thereof for :array dimension(s)
;; --------- 5.1 final
; 05/25/00 AKH no more %register-trap in dispose-record
;---------------
; 09/23/96 bill  add %get-double-float & %get-single-float to mactype-handle-reffers-alist
; -------------  4.0b2
; 12/05/95 bill  make-record returns (require-trap #_NewXxx size) instead of (%register-trap ... size)
;  5/25/95 slh   interfaces-2 changes
;----------- 3.0d17
; 02/22/02 (bill from "post f2 build:copy-record-patch")
;              (copy-record foo) no longer errors at macroexpand time
;----------- 2.0f2c5
; 01/23/91 bill  in define-record: don't :include the first field.
;                Also, be smarter about detecting duplicate field names.
; 01/13/92 bill  Make doubly sure that initial values override defaults.
;                Error on DEFRECORD with duplicate field names
; 01/11/92 alice make initial values override defaults, don't keywordify a :default form
;----------- 2.0b4
;10/08/91 bill Handle references to signed words or longs are now done correctly.
;09/20/91 bill There is no such thing as %get-pointer
;08/30/91 bill make-record-handle & make-record-pointer are no more: don't export them.
;08/29/91 bill included-fields are now first-class citizens: they have a field-descriptor-length
;08/29/91 bill get-record-field is simpler because mactype-get-function is always
;              computed now
;08/24/91 gb   use new trap syntax.
;08/23/91 bill RLET allows initialization forms on MACTYPEs
;07/15/91 bill clear-record was parenthesized wrong (engbar finds another one)
;07/21/91 gb   do things differently.
;07/09/91 bill revivify record-info, field-info, & record-fields
;              return field-length vice 1.3's default-value as third value of
;              field-info and the fourth element of each sublist of the result
;              of record-fields
;07/01/91 bill define-record no longer autoloads mactypes.
;06/22/91 bill href, pref, hset, pset, make-record-handle, make-record-pointer
;06/21/91 bill copy-record no longer errors if you leave out its record-type arg.
;------------- 2.0b2
;06/05/91 bill record-source-file moves from defrecord to %define-record
;05/20/91 gb   Somewhat less hysterical MAKE-RECORD.
;04/26/91 bill print-record stopped too soon.
;04/25/91 bill expand-handle-record-get is a little less eager to expand into WITH-POINTERS.
;04/17/91 bill in process-field - Convert strings to keywords for field names
;              This allows (defrecord frob ("VARIANT" ...) ...)
;04/09/91 bill dispose-record was parenthesized wrong
;01/23/91 bill copy-record uses new traps
;01/14/91 bill make-record used to generate (with-dereferenced-handles (...))
;              copy-record now takes :storage, :size, :source-storage, :dest-storage
;              keywords with its record-type arg.
;12/22/90 joe  moved autoload logic to mactypes. Added %define-record so we can make 
;              record-aliases. Rect is gone.
;10/20/90 bill autoload record description in rref, rset, make-record
;10/09/90 bill fix print-record brain-damage.
;09/25/90 bill %get-ptr -> %inc-ptr in get-record-field
;10/16/90 gb   no more %str-length.
;09/14/90 bill clear-records
;09/07/90 bill Restore the second value to get-record-field so inspector can be smart again.
;              Add rect.botright (proper name for rect.bottomright)
;08/28/90 joe  Moved run-time stuff (which didn't belong here anyways) to level2 
;              so this can be loaded as a library. Changed clear-record to look 
;              like dispose-record. Now they can take either an optional record-type
;              or storage (:handle or :pointer) to make them compile to more efficient code.
;              Added :size option to make-record. Change copy-record to work more
;              like dispose-record & be completely safe when record type is not
;              supplied. :org field option is now :origin. Got rid of record-info,
;              field-info, record-fields, record-storage, record-length,
;              *record-field-types*. These are all replaced by structures which are
;              in mactypes.lisp. Fixed rlet reverse storing order bug.
;
; 7/24/90 joe  MAJOR rewrite. New features: multi-dimensional arrays,
;              variants of variants, working defaults, user extensible
;              record types, etc.
;
;06/05/90 gz   Added unsigned-long.  Also added short/unsigned-short/long as
;              synonyms for integer/short-integer/longint.
;04/30/90 gb   rset wasn't setf inverse of rref.
;04/14/90 gz   %substr now takes start/end args.
;04/12/90 bill %write-string's second arg no longer optional in print-record.
;12/03/89 bill Return second value from get-record-field: the type of the field
;              Added pointer-size.
;11/18/89 gz   Don't use plists.  No more %write.
;9/30/89 bill  pr-%print-string-n-esc => %write-string. pr-%print-form => %write
;7/17/89  gz   use %get-point/%put-point.
;3/17/89  as   from 1.3: :unsigned-integer slot-type
;              record-slot-forms works on new-value handles
;9/2/88   gz	no more list-[n]reverse
;7/27/88  gz	set-slot does %char-code for :character slots

;6/9/88   as   make-record binds its gensym
;05/18/88 as   fixes to define-record and make-record
;04/12/88 as   field-info-values fixed
;03/24/88 as   field info doesn't use multiple values
;              took out some excess calls to make-keyword
;03/23/88 as   changed libfasls to requires
;03/22/88 as   changed a bunch of other stuff to macros
;03/21/88 as   dispose-record is macro.  Takes optional arg :storage-type for
;                efficiency.

;04/02/88 gz   New macptr scheme.
;10/21/87 jaj  added defrecord of rect
;10/15/87 jaj  redefining a record resets record-storage
;10/05/87 jaj  removed actual record definitions. now in library;records.lisp
;9/18/87 jaj   put #-bccl before all defrecords
;--------------------------Version 1.0-------------------------------------
; 8/21/87 gz   Made rset not expand into trap macros so it can be used without
;              alltraps.
; 7/12/87 gb   Provide thyself.
; 7/11/87 gz   Changed an eval to symbol-value.
; 7/8/87  gz   keywordify -> make-keyword.
; 6/23/87 gz   %pr-thing -> prin1.
; 6/17/87 jaj  added list and dialog-item defrecords
; 6/14/87 gb   (libfasl 'toolequ) so $applzone & $syszone are constants.
; 6/10/87 gb   regbuf; better naming suggestions welcomed.
; 6/05/87 jaj  %get-safe-ptr ands with lo3bytes. Added  wptr-to-procid.
; 5/27/87 jaj  default records are zeroed out. added %get-safe-ptr and
;              changed get-record-field to use it.
;05/26/87 cfry added record-field-length, *record-types*, *record-field-types*
;              extended define-record to push onto *record-types*
;05/18/87 gb  expand into %get-signed-word.
;04/16/87 jaj describe-record-field -> field-info added record-string,
;             get-record-field, set-record-field. fixed zone-pointerp
;04/10/87 jaj up to spec. removed _rget, _rset, _rmake etc.
;04/08/87 jaj %default -> record-default
;04/04/87 gz  added libfasl'backquote. max->%imax. Converted ERROR calls
;04/02/87 jaj defmacro-ified all macros
;03/30/87 jaj added rref, rset and generally re-arranged.  Moved mac-record
;             definitions here. Should be backward compatible for now.
;02/05/87 gz %member -> memq, %assoc -> assq
;01/29/87 gz %put -> put
; 1/14/87 gb %set -> set, %get -> get.
; 1/10/87 gb assoc -> %assoc in slot-descriptor; member -> %member
; 1/10/87 gz Changed an integerp to fixnump
; 9/22/86 gz Moved with-pointer(s) to level-2.
; 7/31/86 gz _rget/_rset do number-of-args checking.

(in-package :ccl)

(require 'mactypes)

(export '(record-fields field-info record-info 
          defrecord record-length record-storage rref rset raref rarset
          pref href #|pset hset make-record-handle make-record-pointer|#
          make-record rlet copy-record dispose-record clear-record print-record
          get-record-field set-record-field get-field-offset))

;
; Record and field primitives
;

; These are useful for programmers even though we don't use them internally
(defun record-fields (record-type)
  (mapcar #'(lambda (field-descriptor) (field-descriptor-name field-descriptor))
          (record-descriptor-fields 
           (find-record-descriptor (make-keyword record-type)))))

(defun field-info (record-type field-name)
  (setq field-name (make-keyword field-name))
  (dolist (field (record-descriptor-fields 
                  (find-record-descriptor (make-keyword record-type)))
                 (error "There is no ~s field in records of type ~s"
                        field-name record-type))
    (when (eq (field-descriptor-name field) field-name)
      (return (values (field-descriptor-offset field)
                      (field-descriptor-type field)
                      (field-descriptor-length field))))))

(defun record-info (record-type &optional errorp)
  (setq record-type (make-keyword record-type))
  (let ((record-desc (find-record-descriptor record-type errorp)))
    (when record-desc
      (mapcar #'(lambda (field) (list (field-descriptor-name field)
                                      (field-descriptor-offset field)
                                      (field-descriptor-type field)
                                      (field-descriptor-length field)))
              (record-descriptor-fields record-desc)))))

; 
; Defrecord
; This macro expands to define-record with all symbols replaced by
; keywords
;

#-interfaces-2
(defmacro defrecord (name-storage &rest slot-descriptions)
  (multiple-value-bind (name storage)
                       (if (consp name-storage)
                         (values (make-keyword (car name-storage))
                                 (make-keyword (cadr name-storage)))
                         (values (make-keyword name-storage)
                                 :pointer))
    (when (mactype-p name)              ; autoload at compile time
      (error "Invalid record name: ~s" name))
    `(eval-when (eval load compile)
       (define-record ,name ,storage ',(keywordify slot-descriptions)))))

#+interfaces-2
(defun parse-record-keywords (name-keys)
  (if (not (consp name-keys))
    (values (make-keyword name-keys) :pointer nil)
    (let ((name (make-keyword (car name-keys)))
          (packed? (if (member :packed name-keys) t nil))
          (pointer? (member :pointer name-keys))
          (handle? (member :handle name-keys)))
      (assert (not (and pointer? handle?)) ()
              "Record defined as being storage pointer and handle")
      (values name 
              (if handle? :handle :pointer)
              (if packed? t nil)))))

#+interfaces-2
(defmacro defrecord (name-keys &rest slot-descriptions)
  (multiple-value-bind (name storage packed?) (parse-record-keywords name-keys)
    (when (mactype-p name)              ; autoload at compile time
      ;; Wednesday May 24,1995 alanr changed to warn from error
      (warn "Invalid record name: ~s" name))
    `(eval-when (eval load compile)
       (define-record ,name ,storage ',(keywordify slot-descriptions) ,packed?))))

(eval-when (eval compile load)
  ; takes the rest arg of defrecord and returns a parallel tree with
  ; all symbols turned into keywords.  This happens at macro-expansion time.
  (defun keywordify (thing)
    (cond ((and thing (symbolp thing))
           (make-keyword thing))
          ((and (consp thing) (not (memq (car thing) '(:array :string :default))))
           (cons (keywordify (car thing))
                 (keywordify (cdr thing))))
          (t
           thing))))

(defvar *readonly-records* nil)

;field-list is a list of (name type &key org)
(defun define-record (name storage field-list #+interfaces-2 &optional #+interfaces-2 packed?)
  (when (mactype-p name nil)            ; don't autoload at load time
    (error "Invalid record name: ~s" name))
  (unless (memq storage '(:handle :pointer))
    (error "Unrecognized storage option: ~s for record" storage))
  (when (or (memq name *readonly-mactypes*)(memq name *readonly-records*))
    (warn "cant redefine record ~s" name)
    (return-from define-record name))
  (multiple-value-bind (field-descriptors length init-list)
                       (process-field-list field-list 0)
    (let (duplicates)
      (do* ((fields field-descriptors (cdr fields)))
           ((null fields))
        (let* ((field (car fields))
               (name (field-descriptor-name field))
               (dup-field (car (member name (cdr fields)
                                      :test 'eq
                                      :key 'field-descriptor-name))))
          (when (and dup-field
                     (not (and (eql (field-descriptor-offset field)
                                    (field-descriptor-offset dup-field))
                               (let ((type (field-descriptor-type field))
                                     (dup-type (field-descriptor-type dup-field)))
                                 (or (equal type dup-type)
                                     (and (symbolp type)
                                          (symbolp dup-type)
                                          (let ((mactype (find-mactype type nil)))
                                            (and mactype
                                                 (eq mactype
                                                     (find-mactype dup-type nil))))))))))
            (pushnew name duplicates))))
      (when duplicates
        (warn "Duplicate field names for record type ~s~%~s" name duplicates)))
    (%define-record name (make-record-descriptor :name name
                                                 :storage storage
                                                 :fields field-descriptors
                                                 :length length
                                                 :default-init-list init-list
                                                 #+interfaces-2 :packed? #+interfaces-2 packed?))))

(defun %define-record (name struct)
  (record-source-file name 'record)
  (setf (gethash name %record-descriptors%) 
        struct)
  (unless (memq name *record-types*)
    (push name *record-types*))
  name)

(defun process-field-list (field-list offset)
  (let (field-descriptors init-list)
    (dolist (field field-list)
      (multiple-value-bind (new-descriptors new-offset new-init-list)
                           (if (eq (car field) :variant)
                             (process-variant (cdr field) offset)
                             (process-field field offset))
        (setq field-descriptors (nconc field-descriptors new-descriptors)
              offset new-offset
              init-list (nconc init-list  new-init-list))))
    (values field-descriptors offset init-list)))

(defun process-field (field offset)
  (let ((name (car field))
        (type (cadr field))
        include-descriptors include-inits default-form include-p)
    (let (#+interfaces-2 (packed? (and (consp type) (if (member :packed type) t nil))))
      #+interfaces-2 (when packed? (setq type (remove :packed type)))
      (if (stringp name) (setq name (make-keyword name)))
      (do ((options (cddr field) (cddr options)))
          ((null options))
        (let ((keyword (car options))
              (arg (cadr options)))
          (ecase keyword
            (:offset (setq offset (require-type arg 'fixnum)))
            (:default (setq default-form arg))
            (:include (setq include-p arg)))))
      (when (record-type-p type)
        (multiple-value-setq (include-descriptors include-inits)
          (included-fields type offset (unless include-p name))))
      (unless include-p (setq include-descriptors nil))
      (let ((field-length (record-field-length type)))
        (when (and (oddp offset)
                   (> field-length 1)
                   (not (and (array-mactype-p type)
                             (= (record-field-length (cadr type)) 1))))
          (incf offset))
        (values (nconc (list (make-field-descriptor :name name
                                                    :type type
                                                    :offset offset
                                                    :length field-length
                                                    #+interfaces-2 :packed? #+interfaces-2 packed?))
                       include-descriptors)
                (+ offset field-length)
                (nconc (when default-form (list name default-form))
                       include-inits))))))

(defun included-fields (record-type offset &optional name)
  (let ((rdesc (find-record-descriptor record-type))
        new-inits)
    (values
     (mapcar #'(lambda (fdesc)
                 (make-field-descriptor 
                  :name (field-descriptor-name fdesc)
                  :type (field-descriptor-type fdesc)
                  :offset (+ offset (field-descriptor-offset fdesc))
                  :length (field-descriptor-length fdesc)))
             (record-descriptor-fields rdesc))     
     (do ((l (record-descriptor-default-init-list rdesc)(cddr l))) ; (:x 0 :y 0 ...)
         ((null l) new-inits)
       (setq new-inits 
             (nconc (list (if name 
                            (make-keyword 
                             (concatenate 'string (symbol-name name) "."
                                          (symbol-name (car l))))
                            (car l))
                          (cadr l))
                    new-inits))))))


(defun process-variant (variants offset)
  (let ((highest-offset 0)
        field-descriptors
        init-list)
    (dolist (variant-fields variants)
      (let ((current-offset offset))
        (multiple-value-bind (new-descriptors new-offset new-init-list)
                             (process-field-list variant-fields current-offset)
          (setq field-descriptors (nconc field-descriptors new-descriptors)
                current-offset new-offset
                init-list (nconc init-list new-init-list))
          (when (> current-offset highest-offset)
            (setq highest-offset current-offset)))))
    (values field-descriptors highest-offset init-list)))

;
; rref & rset
;

(eval-when (:compile-toplevel :execute)
  (defmacro mactype-handle-reffers-alist ()
    ''((%get-ostype . %hget-ostype)
       (%get-string . %get-string)
       (%get-ptr . %hget-ptr)
       (%get-long . %hget-long)
       (%get-point . %hget-point)
       (%get-unsigned-long . %hget-unsigned-long)
       (%get-signed-long . %hget-signed-long)
       (%get-word . %hget-word)
       (%get-unsigned-word . %hget-unsigned-word)
       (%get-signed-word . %hget-signed-word)
       (%get-byte . %hget-byte)
       (%get-unsigned-byte . %hget-unsigned-byte)
       (%get-signed-byte . %hget-signed-byte)
       (%get-double-float . %hget-double-float)
       (%get-single-float . %hget-single-float)))
)

(defmacro rref (pointer 
                accessor 
                &key 
                (storage (record-descriptor-storage 
                          (find-record-descriptor 
                           (nth-value 2 (parse-accessor accessor))))))
  (multiple-value-bind (offset field-type)
                       (parse-accessor accessor)
    (funcall (ecase storage
               (:handle 'expand-handle-record-get)
               (:pointer 'expand-record-get))
             pointer offset field-type)))

(defmacro href (pointer accessor)
  `(rref ,pointer ,accessor :storage :handle))




(defun expand-record-get (pointer offset field-type)
  (if (or (array-mactype-p field-type)
          (record-type-p field-type))
    `(%inc-ptr ,pointer ,offset)
    (let* ((mactype (find-field-mactype field-type))
           (access `(,(mactype-access-operator mactype) ,pointer ,offset))
           (wrapper (mactype-access-coercion mactype)))
      (if wrapper (funcall wrapper access) access))))

(defun expand-handle-record-get (pointer offset field-type)
  (if (or (array-mactype-p field-type)
          (record-type-p field-type))
    (error "Illegal attempt to get a pointer to a ~s within a handle" field-type)
    (let* ((mactype (find-field-mactype field-type))
           (access-form `(,(cdr (assq (mactype-access-operator mactype)
                                      (mactype-handle-reffers-alist)))
                          ,pointer
                          ,offset))
           (access-coercion (mactype-access-coercion mactype)))
      (if access-coercion (funcall access-coercion access-form) access-form))))

(defmacro pref (pointer accessor)
  `(rref ,pointer ,accessor :storage :pointer))

(defmacro raref (pointer accessor &rest indices)
  `(rref ,pointer (,accessor ,@indices) :storage :pointer))

(defun expand-record-set (pointer offset field-type newval)
  (if (or (array-mactype-p field-type)
            (record-type-p field-type))
      `(require-trap #_blockmove 
                     ,newval
                     (%inc-ptr ,pointer ,offset)
                     ,(record-field-length field-type))
      (let* ((mactype (find-field-mactype field-type))
             (accessform (list (mactype-access-operator mactype) pointer offset))
             (store-coerce (mactype-store-coercion mactype)))
        `(setf ,accessform  ,(if store-coerce (funcall store-coerce newval) newval)))))

(defun expand-handle-record-set (pointer offset field-type newval)
    (if (or (array-mactype-p field-type)
            (record-type-p field-type))
      `(require-trap #_blockmove 
                       ,newval
                       (%inc-ptr (%get-ptr ,pointer) ,offset)
                       ,(record-field-length field-type))
      (let* ((mactype (find-field-mactype field-type))
             (access-form `(,(cdr (assq (mactype-access-operator mactype)
                                        (mactype-handle-reffers-alist)))
                            ,pointer
                            ,offset))
             (store-coerce (mactype-store-coercion mactype)))
        `(setf ,access-form ,(if store-coerce (funcall store-coerce newval) newval)))))

(defmacro rset (pointer 
                accessor 
                thing 
                &key 
                (storage (record-descriptor-storage 
                          (find-record-descriptor 
                           (nth-value 2 (parse-accessor accessor))))))
  (multiple-value-bind (offset field-type)
                       (parse-accessor accessor)
    (funcall (ecase storage (:handle 'expand-handle-record-set) (:pointer 'expand-record-set))
             pointer
             offset
             field-type
             thing)))

(defmacro rarset (pointer thing accessor &rest indices)
  `(setf (rref ,pointer (,accessor ,@indices) :storage :pointer) ,thing))

(defmacro get-field-offset (accessor)
  (multiple-value-bind (offset field-type)
                       (parse-accessor accessor)
    `(values ,offset ',field-type)))

(defun parse-accessor (accessor &aux accessor-list array-indices)
  (if (consp accessor)
    (setq array-indices (cdr accessor)
          accessor-list (decompose-record-accessor (car accessor)))
    (setq accessor-list (decompose-record-accessor accessor)))
  (let ((field-type (car accessor-list))
        (offset 0))
    (do* ((accessors (cdr accessor-list) (cdr accessors)))
         ((not accessors))
      (let ((field-descriptor (find-field-descriptor field-type (car accessors))))
        (setq offset 
              (%i+ offset (field-descriptor-offset field-descriptor)))
        (setq field-type (field-descriptor-type field-descriptor))))
    (when array-indices
      (multiple-value-setq (offset field-type)
                           (find-array-field-offset 
                            field-type offset array-indices accessor)))
    (values offset field-type (car accessor-list))))

(defun find-array-field-offset (field-type offset array-indices 
                                           &optional (error-ref array-indices))
  (unless (array-mactype-p field-type)
    (error "Array indices: ~s specified for non-array field type ~s"
           error-ref field-type))
  (let* ((basic-type (cadr field-type))
         (basic-length (record-field-length basic-type))
         (dimensions (cddr field-type)))
    (when (> (length array-indices) (length dimensions))
      (error "Too many indices: ~s specified for field type: ~s"
             error-ref field-type))
    (dolist (index array-indices)
      (setq dimensions (cdr dimensions)
            offset `(+ ,offset (* (the fixnum ,index)
                                  ,(* basic-length (apply #'* dimensions))))))
    (if dimensions
      (setq field-type `(:array ,basic-type ,@dimensions))
      (setq field-type basic-type)))
  (values offset field-type))

(defun decompose-record-accessor (accessor &aux ret)
  (do* ((str (symbol-name accessor) (%substr str (+ i 1) len))
        (len (length str) (length str))
        (i (%str-member #\. str) (%str-member #\. str))
        (field (%substr str 0 (or i len)) (%substr str 0 (or i len))))
       ((not i) (nreverse (cons (make-keyword field) ret)))
    (push (make-keyword field) ret)))

;
; defsetf forms for rref & raref
;

(define-setf-method rref (record accessor &key (storage (record-descriptor-storage 
                                                         (find-record-descriptor 
                                                          (nth-value 2 (parse-accessor accessor))))))
  (multiple-value-bind (offset field-type)
                       (parse-accessor accessor)
    
    (let* ((record-temp (gensym))
           (store-temp (gensym))
           (access-form (funcall (ecase storage 
                                   (:handle 'expand-handle-record-get) 
                                   (:pointer 'expand-record-get))
                                 record-temp
                                 offset
                                 field-type))
           (assignment-form (funcall (ecase storage 
                                       (:handle 'expand-handle-record-set) 
                                       (:pointer 'expand-record-set))
                                     record-temp
                                     offset
                                     field-type
                                     store-temp)))
      (values (list record-temp)
              (list record)
              (list store-temp)
              assignment-form
              access-form))))

(define-setf-method raref (pointer field-type &rest indices)
  (let ((pointer-temp (gensym))
        (store-temp (gensym)))
    (values (list pointer-temp)
            (list pointer)
            (list store-temp)
            `(progn (rarset ,pointer-temp ,field-type ,store-temp ,@indices)
                    ,store-temp)
            `(raref ,pointer-temp ,field-type ,@indices))))

;
; get-record-field and set-record-field
;

(defun get-record-field (record record-type field-name)
  (setq record-type (make-keyword record-type)
        field-name (make-keyword field-name))
  (let* ((field (find-field-descriptor record-type field-name))
         (field-type (field-descriptor-type field)))
    (new-with-pointers ((pointer record))
      (cond ((or (array-mactype-p field-type)
                 (record-type-p field-type))
             (when (and (handlep record)
                        (not (handle-locked-p record)))
               (error "Illegal attempt to get a pointer to a ~s within an unlocked handle"
                      field-type))
             (values (%setf-macptr (%null-ptr)   ; pointer is stack-consed
                                   (%inc-ptr pointer (field-descriptor-offset field)))
                     field-type))
            (t
             (values
              (let* ((mactype (find-field-mactype field-type)))
                (funcall (mactype-get-function mactype)
                         pointer 
                         (field-descriptor-offset field)))
              (and (listp field-type) (cadr field-type))))))))

(defun set-record-field (record record-type field-name thing)
  (setq record-type (make-keyword record-type)
        field-name (make-keyword field-name))
  (let* ((field-desc (find-field-descriptor record-type field-name))
         (field-type (field-descriptor-type field-desc)))
    (new-with-pointers ((pointer record))
      (cond ((or (array-mactype-p field-type)
                 (record-type-p field-type))
             (#_blockmove 
              thing
              (%inc-ptr pointer 
                        (field-descriptor-offset field-desc)) 
              (field-descriptor-length field-desc)))
            (t
             (funcall (mactype-set-function 
                       (find-field-mactype field-type))
                      pointer (field-descriptor-offset field-desc) thing))))))


;;
;; Make record and rlet
;;

; note that syntax has been changed so that storage options are in a list
; with the record type...
(defmacro make-record (record-type &rest init-forms)
  (let (storage clear length)
    (when (consp record-type)
      (multiple-value-setq (record-type storage clear length)
                           (apply #'(lambda (type &key storage clear length)
                                      (values type storage clear length))
                                  record-type)))
    (setq record-type (make-keyword record-type))
    (let* ((desc (find-record-descriptor record-type))
           (handle (gensym))
           (pointer (gensym)))
      (unless storage
        (setq storage (record-descriptor-storage desc)))
      (unless length
        (setq length (record-descriptor-length desc)))
      (let* ((trapname (ecase storage
                         (:handle (if clear '#_NewHandleClear '#_NewHandle))
                         (:Pointer (if clear '#_NewPtrClear '#_NewPtr))))
             (trapform `(require-trap ,trapname :errchk ,length))
             (forms (record-field-forms pointer record-type init-forms)))
        (if forms
          (if (eq storage :handle)
            `(let ((,handle ,trapform))
               (with-dereferenced-handles ((,pointer ,handle))
                 ,@forms)
               ,handle)
            `(let ((,pointer ,trapform))
               ,@forms
               ,pointer))
          trapform)))))

(defmacro rlet (spec &body body)
  `(%stack-block ,(rlet-sizes spec)
     ,@(rlet-inits spec)
     ,@body))

(defmacro rletZ (spec &body body)
  `(%stack-block ,(rlet-sizes spec t)
     ,@(rlet-inits spec)
     ,@body))

#|
(defun rlet-sizes (inits &optional clear-p &aux result)
  (dolist (item inits (nreverse result))
    (push `(,(car item)
            ,(record-field-length (keywordify (cadr item)))
            ,@(if clear-p '(:clear t)))
          result)))
|#

(defun rlet-sizes (inits &optional clear-p &aux result)
  (dolist (item inits (nreverse result))
    (push `(,(car item)
            ,(record-field-length-for-rlet (keywordify (cadr item)))
            ,@(if clear-p '(:clear t)))
          result)))

;; allows local variable(s) or expressions(s) thereof for :array dimension(s)
#|
(defun record-field-length-for-rlet (field-type)
  (if (and (consp field-type)(eq (car field-type) :array))
    (progn
      (when (eq (car (last field-type)) :packed)
        (setq field-type (butlast field-type)))
      (let ((num-elts (ignore-errors (apply #'* (mapcar #'eval (cddr field-type))))))
        (if num-elts
          (* (record-field-length (cadr field-type)) num-elts)
          `(* ,(record-field-length (cadr field-type)) ,@(cddr field-type)))))
    (record-field-length field-type)))
|#

(defun record-field-length-for-rlet (field-type)
  (if (and (consp field-type)(eq (car field-type) :array))
    (progn
      (let ((packed-boolean? nil)
            (field-type-elt-type (cadr field-type))
            (field-type-dims (cddr field-type)))
        (when (eq (car (last field-type-dims)) :packed)          
          (setq field-type-dims (butlast field-type-dims))
          (when (eq field-type-elt-type :boolean)(setq packed-boolean? t)))
        (let ((num-elts (ignore-errors (apply #'* (mapcar #'eval field-type-dims)))))
          (if num-elts
            (let ((length (* (record-field-length field-type-elt-type) num-elts)))
              (if packed-boolean?
                (ceiling length 8)
                length))
            (if (not packed-boolean?)
              `(* ,(record-field-length field-type-elt-type) ,@field-type-dims)
              `(ceiling (* ,(record-field-length field-type-elt-type) ,@field-type-dims) 8 ))))))
    (record-field-length field-type)))

(defun rlet-inits (inits &aux result)
  (dolist (item inits result)
    (let ((name (car item))
          (record-type (keywordify (cadr item)))
          (inits (cddr item)))
      (if (record-type-p record-type)
        (setq result (nconc result (record-field-forms name record-type inits)))
        (when inits
          (let ((mactype (find-mactype record-type nil nil)))
            (if (and mactype (null (cdr inits)))
              (setq result
                    (nconc result
                           `((setf (,(mactype-access-operator mactype) ,name)
                                   ,(funcall (mactype-encode-expand mactype)
                                             (car inits))))))
              (error "Unexpected or malformed initialization forms: ~s in field type: ~s"
                     inits record-type))))))))

;(rlet ((x :rect)) (foo 1)) -> (%STACK-BLOCK ((X 8)) (FOO 1))
;(rlet ((x :rect :left 10 :top 20)) (foo 1)) ->
;    (%STACK-BLOCK ((X 8))
;        (%PUT-WORD X 10 2)
;        (%PUT-WORD X 20 0)
;        (FOO 1))
;(rlet ((x :rect :left 10)(y  :rect :bottomright #@(10 20))) (foo 1)) ->
;   (%STACK-BLOCK ((Y 8) (X 8))
;      (%PUT-LONG Y 1310730 4)
;      (%PUT-WORD X 10 2)
;      (FOO 1))

(defun record-field-forms (pointer record-type field-value-pairs)
  (unless (evenp (length field-value-pairs))
    (error "Odd number of initialization arguments: ~s" field-value-pairs))
  (flet ((initform (pointer record-type accessor value-form)
           (let ((path (make-keyword
                        (concatenate 'string 
                                     (symbol-name record-type)
                                     "."
                                     (symbol-name (if (consp accessor)
                                                    (car accessor) accessor))))))
             (setq accessor
                   (if (consp accessor)
                     (cons path (cdr accessor))
                     path)))
           (multiple-value-bind (offset field-type) (parse-accessor accessor)
             (values
              (expand-record-set pointer offset field-type value-form)
              offset
              (record-field-length field-type)))))
  (let ((record-desc (find-record-descriptor record-type))
        forms init-forms offsets)
    (do* ((pairs field-value-pairs (cddr pairs)))
         ((null pairs))
      (multiple-value-bind (form offset size)
                           (initform pointer record-type
                                     (car pairs) (cadr pairs))
        (push form forms)
        (push (cons offset size) offsets)))
    (setq forms (nreverse forms))
    (do ((inits (record-descriptor-default-init-list record-desc) 
                (cddr inits)))
        ((null inits))
      (multiple-value-bind (form offset size)
                           (initform pointer record-type
                                     (car inits) (cadr inits))
        (unless (dotimes (i size t)
                  (unless (member (+ i offset) offsets
                                  :test #'(lambda (byte offset)
                                            (< (1- (car offset)) byte
                                               (+ (car offset) (cdr offset)))))
                    (return nil)))
          ; There is at least one byte that this form initializes
          ; That has not yet been initialized: include it.
          (push form init-forms)
          (push (cons offset size) offsets))))
    (nconc init-forms forms))))


(defmacro copy-record (source-record &optional record-type dest-record)
  (destructuring-bind (record-type &key size storage source-storage dest-storage)
                      (if (and record-type (listp record-type)) record-type (list record-type))
    (when record-type
      (let ((record-desc (find-record-descriptor (make-keyword record-type))))
        (unless size
          (setq size (record-descriptor-length record-desc)))
        (unless storage
          (setq storage (record-descriptor-storage record-desc)))))
    (unless source-storage (setq source-storage storage))
    (unless dest-storage (setq dest-storage storage))
    (if (eq source-storage :unknown) (setq source-storage nil))
    (if (eq dest-storage :unknown) (setq dest-storage nil))
    (let ((type '(member nil :pointer :handle)))
      (setq source-storage (require-type source-storage type))
      (setq dest-storage (require-type dest-storage type)))
    (if (and size (constantp size) dest-record 
             (not (null source-storage)) (eq source-storage dest-storage))
      (let ((dvar (gensym)))
        `(let (,dvar)
           ,(ecase source-storage
              (:handle `(require-trap #_BlockMove
                                      (%get-ptr ,source-record)
                                      (%get-ptr (setq ,dvar ,dest-record))
                                      ,size))
              (:pointer `(require-trap #_BlockMove
                                       ,source-record
                                       (setq ,dvar ,dest-record)
                                       ,size)))
           ,dvar))
      (let ((svar (gensym))
            (size-var (gensym))
            (dvar (gensym)))
        (setq storage
              (if (eq source-storage dest-storage)
                source-storage
                (cons source-storage dest-storage)))
        `(let ((,svar ,source-record)
               (,size-var ,size)
               (,dvar ,dest-record))
           (declare (dynamic-extent ,svar))
           (values (%copy-record
                    ,svar ,dvar ,size-var ',storage)))))))

(defun %copy-record (source-record dest-record size storage)
  (let (source-storage dest-storage)
    (if (listp storage)
      (setq source-storage (%car storage)
            dest-storage (%cdr storage))
      (setq source-storage storage
            dest-storage storage))
    (setq source-storage
          (ecase source-storage
            (:handle t)
            (:pointer nil)
            ((nil) (handlep source-record))))
    (unless size
      (setq size
            (if source-storage
              (#_GetHandleSize source-record)
              (#_GetPtrSize source-record))))
    (setq dest-storage
          (ecase dest-storage
            (:handle t)
            (:pointer nil)
            ((nil) (if dest-record (handlep dest-record) source-storage))))
    (unless dest-record
      (setq dest-record
            (if dest-storage
              (#_NewHandle :errchk size)
              (#_NewPtr :errchk size))))
    (#_BlockMove (if source-storage (%get-ptr source-record) source-record)
                (if dest-storage (%get-ptr dest-record) dest-record)
                 size)
    dest-record))

(defmacro clear-record (record &optional storage-type)
  (when storage-type
    (unless (memq storage-type '(:handle :pointer))
      (setq storage-type (record-descriptor-storage 
                          (find-record-descriptor (make-keyword storage-type))))))
  (case storage-type
    (:handle
     `(%clear-pointer (%get-ptr ,record)))
    (:pointer
     `(%clear-pointer ,record))
    (t
     (let ((record-sym (gensym)))
       `(let ((,record-sym ,record))
          (if (handlep ,record-sym)
            (%clear-pointer (%get-ptr ,record-sym))
            (if (zone-pointerp ,record-sym)
              (%clear-pointer ,record-sym))))))))

(defmacro dispose-record (record &optional storage-type)
  (when storage-type
    (unless (memq storage-type '(:handle :pointer))
      (setq storage-type (record-descriptor-storage 
                          (find-record-descriptor (make-keyword storage-type))))))
  (case storage-type
    (:handle
     `(require-trap #_DisposeHandle ,record))
    (:pointer
     `(require-trap #_DisposePtr  ,record))
    (t
     (let ((record-sym (gensym)))
       `(let ((,record-sym ,record))
          (if (handlep ,record-sym)
            (require-trap #_DisposeHandle   ,record-sym)
            (if (zone-pointerp ,record-sym)
              (require-trap #_DisposePtr  ,record-sym))))))))

(defun print-record (record record-type &optional (currlevel 0))
  (setq record-type (make-keyword record-type))
  (if (and *print-level* (>= currlevel *print-level*))
    (prin1 record)
    (progn 
      (%write-string "#<Record " *standard-output*)
      (write record-type)
      (do* ((field-list (record-descriptor-fields (find-record-descriptor record-type))
                        (cdr field-list))
            (field-desc (car field-list) (car field-list))
            (max-offset -1 (max max-offset offset))
            (offset (and field-desc (field-descriptor-offset field-desc))
                    (and field-desc (field-descriptor-offset field-desc)))
            (currlength 0 (1+ currlength))
            field-name value field-type)
           ((or (not field-list)
                (and *print-length* (>= currlength *print-length*)))
            ;if terminated because ran over *print-length* then print ...
            (if field-list
              (%write-string " ..." *standard-output*))
            (tyo #\>))
        (when (and offset (%i< max-offset offset))
          (setq field-name (field-descriptor-name field-desc)
                field-type (field-descriptor-type field-desc)
                value (get-record-field record record-type field-name))
          ;need space if not first element
          (tyo #\space)
          (write field-name)
          (tyo #\space)
          (if (record-type-p field-type)
            (print-record value field-type (1+ currlevel))
            (if (eq field-type :point)
              (%write-string (point-string value) *standard-output*)
              (write value)))))))
  (values))



(defun clear-records ()
  (setq *record-types* nil)
  (clrhash %record-descriptors%)
  t)

(unless *record-types*
  (clear-records))

(defrecord Rect 
  (:variant    
   ((top :signed-integer)
    (left :signed-integer)
    (bottom :signed-integer)
    (right :signed-integer))   
   ((topLeft :point)
    (:variant ((botRight :point))
              ((bottomRight :point))))
   ))

;; these probably belong elsewhere
;; same as unsignedwide - endian dependent
(defrecord u_int64_t  
   (hi :unsigned-long)
   (lo :unsigned-long)
   )

(defrecord uint64_t   ;; yet another spelling 
   (hi :unsigned-long)
   (lo :unsigned-long)
   )

(defrecord uint64   ;; yet another spelling 
   (hi :unsigned-long)
   (lo :unsigned-long)
   )

;; same as wide
(defrecord int64_t
   (hi :signed-long)
   (lo :unsigned-long)
   )

(defrecord sint64
   (hi :signed-long)
   (lo :unsigned-long)
   )
(eval-when (:load-toplevel :execute)
  (pushnew :rect *readonly-records*)
  (pushnew :int64_t *readonly-records*)
  (pushnew :u_int64_t *readonly-records*)
  (pushnew :uint64_t *readonly-records*)
  (pushnew :uint64 *readonly-records*)
  (pushnew :sint64 *readonly-records*)
  
)

#|

(defun field-info-values (record-type field-name)
  (do* ((slots (record-info record-type t) (record-info (car (cdar slots))))
        (sd (assq field-name slots) (assq field-name slots)))
       ((or sd (not slots))
        (if sd
          (progn
            (setq sd (cdr sd))
            (values (cadr sd) (car sd) (car (cddr sd))))
           (error "There is no ~s field in records of type ~s"
                     field-name record-type)))))


(record-slot-forms 'my-rec :rect '(:topleft 0 :bottomright 100))

(defrecord (htest :handle)
  (title (string 255))
  (size :longint)
  (version :byte)
  (type :ostype))

(defrecord (ptest :pointer)
  (title (string 255))
  (size :longint)
  (version :byte)
  (type :ostype))

(record-slot-forms 'm-han :htest '(:title "this is a test" :size 100 :type "BAZA"))
(record-slot-forms 'm-ptr :ptest '(:title "this is a test" :size 100 :type "BAZA"))

(defrecord is-pointer
  (one :longint)
  (two :longint)
  (three :longint)
  (four :longint))

(defrecord (is-handle :handle)
  (one :longint)
  (two :longint)
  (three :longint)
  (four :longint))

(defrecord p-has-pointer
  (point :is-pointer))

(defrecord p-has-handle
  (hand :is-handle))


(defrecord (h-has-pointer :handle)
  (point :is-pointer))

(defrecord (h-has-handle :handle)
  (hand :is-handle))

(setq foo (make-record :is-pointer :one 1 :two 2 :three 3 :four 4))
(print-record foo :is-pointer)
(setq bar (make-record :is-handle :one 1 :two 2 :three 3 :four 4))
(print-record bar :is-handle)
(setq p-foo (make-record :p-has-pointer :point foo))
(print-record p-foo :p-has-pointer)
(setq p-bar (make-record :p-has-handle :hand bar))
(print-record p-bar :p-has-handle)
(setq h-foo (make-record :h-has-pointer :point foo))
(print-record h-foo :h-has-pointer)
(setq h-bar (make-record :h-has-handle :hand bar))
(print-record h-bar :h-has-handle)

(defun dispose-record-fn (arg)
  (dispose-record arg))

(mapcar 'dispose-record-fn `(h-bar h-foo p-bar p-foo bar foo))
(setq h-bar nil
      h-foo nil
      p-bar nil
      p-foo nil
      bar nil
      foo nil)

;(rref ptr window.portbits.bounds.top) -> (%GET-SIGNED-WORD PTR 8)
;(rref ptr window.portbits.bounds) -> (%INT-TO-PTR (%I+ PTR 8))
;(rref ptr window.portbits.bounds.bottomright) -> (%GET-LONG PTR 12)
;(rref ptr window.nextwindow :storage :handle) -> (%GET-PTR (%GET-PTR PTR) 144)
;(rref ptr window.portrect)-> (%INT-TO-PTR (%I+ PTR 16))
;(rref ptr window.portrect :storage :handle) -> error
;(rref ptr window.portrect.right) -> (%GET-SIGNED-WORD PTR 22)
;(rref ptr terec.nlines) -> (%GET-SIGNED-WORD (%GET-PTR PTR) 94)
;(rref ptr terec.viewrect) -> error
;(rref ptr terec.viewrect.right) -> (%GET-SIGNED-WORD (%GET-PTR PTR) 14)
;(rset ptr window.portbits.bounds.top val) -> (%PUT-WORD PTR VAL 8)
;(rset ptr window.portrect rect) -> (_BLOCKMOVE :A0 RECT :A1 (%INC-PTR PTR 16) :D0 8)
;(rset ptr window.portbits.bounds rect) -> (_BLOCKMOVE :A0 RECT :A1 (%INC-PTR PTR 8) :D0 8)
;(rset ptr window.portbits.bounds.topleft point) -> (%PUT-LONG PTR POINT 8)
;(rset ptr window.nextwindow wptr) -> (%PUT-PTR PTR WPTR 144)
;(rset ptr window.nextwindow wptr :storage :handle) -> (%PUT-PTR (%GET-PTR PTR) WPTR 144)
;(rset ptr window.nextwindow wptr)
;    -> (WITH-POINTERS ((#:G132 PTR)) (%PUT-PTR #:G132 WPTR 144))

|#


(provide 'defrecord)

;;;End of defrecord.lisp
