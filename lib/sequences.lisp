;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  4 10/22/97 akh  concatenate deal with some 68k vector types
;;  3 6/2/97   akh  merge forgives nil length
;;  25 1/22/97 akh  more brain damage in simple-vector-delete - set subtype after copy
;;  23 9/13/96 akh  merge with 3.1 version
;;  21 9/4/96  akh  conditionalize for 4.0/3.0+
;;  20 7/18/96 akh  maybe no change
;;  18 5/20/96 akh  make-sequence 'array works again
;;  17 3/16/96 akh  make array-ctype-length work for '(string 2)
;;  14 2/19/96 akh  make-sequence and coerce check length of specifier vs requested length
;;                  coerce was wrong for complex
;;  13 2/19/96 akh  vector-position - start default 0 
;;                   and lots more
;;  12 2/6/96  akh  somewhat faster search
;;  9 11/18/95 akh  1.0 => 1.0d0 in coerce, other trivia
;;  8 11/13/95 akh  coerce - fix for ppc
;;                  lots of %typed-uvref -> %typed-misc-ref if ppc
;;  7 10/27/95 akh  simple-vector-delete for ppc
;;  5 10/23/95 akh  copy-seq for ppc, concatenate back to making base string if possible, else extended
;;  4 10/18/95 Alice Hartley add some more string types to case in concatenate
;;  2 10/8/95  akh  coerce to standard-char remembers to return the char
;;  5 3/24/95  akh  fix coerce for extended strings
;;  4 3/2/95   akh  make-sequence knows about 2 string flavors
;;                  concatenate will make a fat string if any arg is fat string
;;  3 2/3/95   akh  merge leibniz patches
;;  (do not edit before this line!!)

; 
;; Copyright 1986-1988 Coral Software Corp.
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995-2000 Digitool, Inc.

#|
; Modification History
;
;
; coerce nil 'string -> ""
; coerce 'float -> single-float
; coerce - errors are type-errors. coerce character -> string works, may error if requested
; type is base-string and input contains non base-characters
; count heeds from-end arg, check type of predicates in notevery etc.
; concatenate accepts cons - same as list
; remove - do check-count
; ----- 5.2b6
; fix coerce to 'single-float - actually fixed elsewhere
; --- 5.2b1
; fix coerce for subtypes of 'character
;; ------- 5.1 final
; optimization in fill and replace
; akh fixnum decls in fill
; akh make-sequence type-error vs simple-error
; -------- 4.3f1c1
; 05/04/99 akh fix concatenate for e.g. '(string 3)
; ----------- 4.3b1
; 05/24/98 akh concatenate 'string - arg NIL doesn't force extended-string
; 10/21/97 akh concatenate transforms 68K vector types into something that make-sequence understands
; 02/14/97 gb  coerce handles SHORT-FLOAT case.
; 12/07/96 akh more brain damage in simple-vector-delete - set subtype after copy
; 10/07/96 bill vector-delete no longer tries to set to NIL the trailing elements
;               of a string or other non-general vector with a fill-pointer.
; ------------- 4.0b2
; 09/07/96 gb   SEQ-DISPATCH back in level-2.
; 08/12/96 bill (map nil ...) & some-xx-multi no longer cons.
; akh fixnum decls in replace
; 07/10/96 bill  fix severe brain-damage in simple-vector-delete
; akh coerce and make-sequence take 'array too
;03/01/96 gb    use array-ctype-length instead of the other thing
;02/22/95 bill  %copy-array uses length instead of array-dimensions for one-dimensional arrays
;01/18/96 bill  fix PPC version of simple-vector-delete
;12/27/95 gb    %typed-misc spelling.
; 8/07/95 slh   Gary's fix to %truncate-vector
;03/16/94 bill  vector-delete now clears the array between the old
;               a new fill pointers.
;-------------- 3.0d13
;10/24/93 alice concatenate and concat-to-simple* dynamic-extent and other nonsense
;08/14/93 alice gail's hack for list delete-duplicates
;-------------
;12/15/92 bill move definition of DELETE to after defs of functions it calls
;              so that deactivate-process can call DELETE during bootstrapping
;              and not get an undefined function error.
;11/20/92 gb   new vector headers, car/cdr.  Rearrange declarations.
;------------- 2.0
;02/21/92 (gb from bootpatch0) Teach ADJUST-TEST-ARGS about MACPTRs.
;------------- 2.0f2
;12/10/91 gb   don't call COERCE-TO-FUNCTION. %signal-error -> %err-disp.`
;11/25/91 bill a null :end arg to reduce & delete-duplicates means the length of the sequence.
;------------- 2.0b4
;08/31/91 gb   Pass type mask to COERCE-TO-COMPLEX-FLOAT .
;07/21/91 gb    Use CHECK-SEQUENCE-BOUNDS vice CHECK-START-END.  Fixup %badarg errors.
;06/28/91 bill  (let ((seq (make-array 5 :fill-pointer 0)) (cnt 0)) (map-into seq #'(lambda () (incf cnt))))
;               should return #(1 2 3 4 5) by my reading of the spec.
;               The X3J13 draft includes the example: (map-into syms #'gensym)
;               don't call ARRAY-HAS-FILL-POINTER-P on NIL
;06/12/91 alice map-into do little if no sequences
;-------------- 2.0b2
05/22/91 bill gb's fix to remove-if-not
05/20/91 gb   deprecate -IF, -IF-NOT.  Use a real, live %TRUNCATE-VECTOR in some cases
;             of REMOVE & DELETE.
01/08/91 bill brain-damage in reduce.
12/03/90 bill substitute-if-not: 'if -> 'if-not
12/01/90 bill Reinstante decf of END in list-delete-if-aux
11/27/90 alice more brain damage in mismatch - end test was in the wrong place
11/10/90 gb   reduce macrology.
11/06/90 bill brain-damage if :start or :start/:end or :end/:from-end specified in list-delete-if.
10/25/90 gb   make-sequence-like now a function.
09/25/90 akh  remove overzealous %car/cdr in subfns of position
07.20/90 akh  add map-into
07/17/90 akh  make-sequence fussier about type specifier
07/10/90 akh  fix caller of list-delete-moderately-complex - had arg order wrong
05/24/90 akh  negative count => 0 in delete, remove, and substitute.
              make-sequence check for type = (string 3) length not 3
05/23/90 akh  add :key arg to reduce
05/07/90  gz  Fix list-delete-moderately-complex and list-delete-very-simple.
03/25/90  gz  Allow for element-type-subtype returning NIL.
04/30/90 gb   more alleged fixes.
12/08/89 bill MLY's fix for list-subseq*
11/26/89  gz  count, subseq fixes.  This stuff really needs redoing.
11/13/89 bill (count 'a nil) => 0, not NIL.
8/20/89   gb  tried to fix list-delete,-position/find,matchp2 confusion.
4/19/89   gz  changes in coerce.
4/4/89    gz  removed selector constants already defined in lispequ.
15-apr-89 as  versions from 1.3:
                 some, any, every, notevery  <could use a bit of lapifying>
                 mismatch remove-duplicates
                 position, position-if, position-if-not
                 find, find-if, find-if-not
                 count, count-if, count-if-not
                 remove, remove-if, remove-if-not
                 delete, delete-if, delete-if-not
              COERCE does a type-expand
12/01/88  gb  declare ignore in matchify-list.
11/18/88  gb  coerce coerces to function.
10/29/88  gb  sequence-type open-coded now.
 9/23/88  gb  don't say incf in list-to-bit-vector*.
 9/2/88   gz  no more list-nreverse
 8/10/88  gz  sequences-*.lisp -> sequences.lisp. Flushed pre-1.0 edit history
 6/23/88  jaj added a type-expand to make-sequence and concatenate
12/22/87  cfry fixed substitute, substitute-if, substitute-if-not,
                    nsubstitute, nsubstitute-if, nsubstitute-if-not
              to be able to accept a COUNT arg of NIL
12/22/87 cfry fixed REMOVE, remove-if, remove-if-not, delete, delete-if,
              delete-if-not to accept NIL as its COUNT argument.
12/18/87 cfry fixed error message syntax "start is more than end"
10/12/87 cfry fixed list-to-bit-vector* so (coerce '(1 0 1) 'bit-vector 
              will work
 8/21/87 jaj fixed bug in list-subseq* where start and end are the same.

|#


;;
;; utility functions
;;
;;  these probably want to be in-line

(defun make-sequence-like (sequence length)
  (seq-dispatch 
   sequence
   (make-list length)
   (make-array length :element-type (array-element-type sequence))))

(defun adjust-test-args (item test test-not)
  ;; after running this "test" is the real test, a null test means "eq"
  ;; and "test-not" is used as a flag
  (when test-not
    (if test 
      (error "Both ~s and ~s keywords supplied" :test :test-not)
      (setq test test-not)))
  (if test
    (if (or (eq test #'eq)
            (eq test 'eq)
            (and (or (eq test #'equal) (eq test 'equal))
                 (or (fixnump item) (symbolp item))))
      (setq test nil)
      (if (eq test #'funcall)
        (setq test 'funcall)))
    (if (or (macptrp item) (and (not (fixnump item)) (numberp item)))
      (setq test #'eql)))
  (values test test-not))

(defun adjust-key (key)
  (and (neq key 'identity) 
       (neq key #'identity)
       key))

(defun matchp2 (item elt test test-not key)
  (if key
    (setq elt (funcall key elt)))
  (let ((res (if test (if (eq test 'funcall) (funcall item elt) (funcall test item elt))  (eq item elt))))
    (if test-not
      (not res)
      res)))

#|
(defun matchp1 (elt test notp key)
  (if (funcall test (if key (funcall key elt) elt))
    (if notp nil t)
    (if notp t nil)))
|#

;;; This is called in SORT, so we don't just eval-when compile it.
#-ppc-clos
; If only there was a way to nuke the macro and keep the comments ...
(defmacro type-specifier (type)
  "Returns the broad class of which TYPE is a specific subclass."
; Hmm... That means that 17 is the broad class of which '(17 11) is a subclass.
; I see.
; Macros that are called by sort (or anything else) are more trouble than
; they're worth, don't you think ?
  `(if (atom ,type) ,type (car ,type)))


(eval-when (:execute :compile-toplevel)
  
  (defmacro type-specifier-atom (type)
    "Returns the broad class of which TYPE is a specific subclass."
    ; Hmm... That means that 17 is the broad class of which '(17 11) is a subclass.
    ; I see.
    ; Macros that are called by sort (or anything else) are more trouble than
    ; they're worth, don't you think ?
    `(if (atom ,type) ,type (car (type-expand ,type))))

  
  )

#+ppc-clos
(defun make-sequence (type length &key (initial-element nil initial-element-p))
  "Return a sequence of the given TYPE and LENGTH, with elements initialized
  to INITIAL-ELEMENT."
  (setq length (require-type length 'fixnum))
  (let* ((ctype (specifier-type type)))
    (declare (fixnum length))
    (if (< length 0) (report-bad-arg length '(and fixnum unsigned-byte)))
    (let ((tlength (array-ctype-length ctype)))
      (if (and tlength (neq tlength length))
        (progn
          (error 'invalid-dimension-error
                 :datum length
                 :expected-type tlength))))
    (cond ((csubtypep ctype (specifier-type 'base-string))
           (if initial-element-p
             (make-string length 
                          :element-type 'base-char
                          :initial-element initial-element)
             (make-string length
                          :element-type 'base-char)))
          ((csubtypep ctype (specifier-type 'string))
           (if initial-element-p
             (make-string length :element-type 'character :initial-element initial-element)
             (make-string length :element-type 'character)))
          ((csubtypep ctype (specifier-type 'vector))
           (let* ((element-type (type-specifier (array-ctype-element-type ctype)))
                  (dims (array-ctype-dimensions ctype)))
             (if (eq element-type '*) (setq element-type t))
             (when (consp dims)
               (when (not (null (cdr dims)))
                 (error 'invalid-dimension-error :datum  dims :expected-type 'vector)))
             (if initial-element-p
               (make-array (the fixnum length)
                           :element-type element-type
                           :initial-element initial-element)
               (make-array (the fixnum length)
                           :element-type element-type))))
          ((csubtypep ctype (specifier-type 'array))
           (let* ((dims (array-ctype-dimensions ctype)))
             (when (consp dims)
               (when (not (null (cdr dims))) 
                 (error 'invalid-dimension-error :datum  type :expected-type 'vector))))
           (let* ((element-type (type-specifier (array-ctype-element-type ctype))))
             (if (eq element-type '*) (setq element-type t))
             (if initial-element-p
               (make-array (the fixnum length)
                           :element-type element-type
                           :initial-element initial-element)
               (make-array (the fixnum length)
                           :element-type element-type))))           
          ((csubtypep ctype (specifier-type 'null))
           (unless (zerop length)
             (error 'invalid-subtype-error :datum type :expected-type 'cons)))
          ((csubtypep ctype (specifier-type 'cons))
           (if (zerop length)
             (error 'invalid-subtype-error :datum type :expected-type 'null)
             (make-list length :initial-element initial-element)))
          ((csubtypep ctype (specifier-type 'list))
           (make-list length :initial-element initial-element))
          (t (error 'invalid-subtype-error :datum  type
                    :expected-type 'sequence)))))

#-ppc-clos
(defun make-sequence (type length &key (initial-element nil initial-element-p))
  "Returns a sequence of the given Type and Length, with elements initialized
  to :Initial-Element."
  (declare (fixnum length))
  (setq type (type-expand type))
  (let ((spec (type-specifier type)))
    (when (consp type)
      (multiple-value-bind (rank ignore size)
                           (parse-array-type type)
        (declare (ignore ignore))
        (if (and (numberp rank)(neq rank 1))
          ; cause error below - multi dimensional array ain't a sequence
          (setq spec nil)
          (progn 
            (when (eq spec 'list)
              (setq size (cadr type)))
            (when (and (numberp size) (not (= size length)))        
              ;; what is the correct way to report errors this week?
              (error "Type ~S and length ~S do not agree." type length))))))
    (case spec
      (list (make-list length :initial-element initial-element))
      ((simple-string string)  ; this will get you a default flavored string 
       (if initial-element-p
         (make-string length :initial-element initial-element)
         (make-string length)))
      ((extended-string simple-extended-string)
       (if initial-element-p
         (make-string length :element-type 'extended-character :initial-element initial-element)
         (make-string length :element-type 'extended-character)))
      ((base-string simple-base-string)
       (if initial-element-p
         (make-string length :element-type 'base-character :initial-element initial-element)
         (make-string length :element-type 'base-character)))       
      (simple-vector (make-array length :initial-element initial-element))      
      ((array vector simple-array)
       (if (listp type)
         (let ((element-type (cadr type)))
           (if (eq element-type '*) (setq element-type t))
           (if initial-element-p
             (make-array length :element-type element-type
                         :initial-element initial-element)
             (make-array length :element-type element-type)))
         (make-array length :initial-element initial-element)))
      ((bit-vector simple-bit-vector)
       (if initial-element-p
         (make-array length :element-type '(unsigned-byte 1)
                     :initial-element initial-element)
         (make-array length :element-type '(unsigned-byte 1))))
      (t (error "~S is a bad type specifier for sequences." type)))))

;;; Subseq:

(defun vector-subseq* (sequence start end)
  (declare (vector sequence))
  (declare (fixnum end start))
  (let* ((n (- end start))
         (copy (make-sequence-like sequence n)))
    (declare (fixnum n))
    (multiple-value-bind (v offset subtype) (array-data-offset-subtype sequence)
      (let* ((old-index (%i+ offset start)))
        (declare (fixnum old-index new-index))
        (dotimes (i n copy)
          #-ppc-target
          (%typed-uvset subtype copy i (%typed-uvref subtype v old-index))
          #+ppc-target
          (%typed-miscset subtype copy i (%typed-miscref subtype v old-index))
          (incf old-index))))))

(defun nthcdr-error (index list &aux (copy list))
 "If index > length, error"
 (dotimes (i index copy)
   (declare (fixnum i))
   (if copy
     (setq copy (cdr copy))
     (%err-disp $XACCESSNTH index list))))

; slisp didn't error if end > length, or if start > end.
(defun list-subseq* (sequence start end)
  (declare (fixnum start end))
  (if (= start end)
    nil
    (let* ((groveled (nthcdr-error start sequence))
           (result (list (car groveled))))
      (when groveled
        (do ((list (cdr groveled) (cdr list))
             (splice result (cdr (rplacd splice (list (car list)))))
             (index (1+ start) (1+ index)))
             ((= index end) result)
          (declare (fixnum index))
           ())))))

; This ensures that start & end will be non-negative FIXNUMS ...
; This implies that the address space is < 2^31 bytes, i.e., no list
; can have a length > most-positive fixnum.  Let them report it as a
; bug ...

(defun subseq (sequence start &optional end)
  (setq end (check-sequence-bounds sequence start end))
  (seq-dispatch 
   sequence
   (list-subseq* sequence start end)
   (vector-subseq* sequence start end)))

;;; Copy-seq:

(defun copy-seq (sequence)
  (seq-dispatch 
   sequence
   (copy-list sequence)
   (let* ((length (length sequence))
          (subtype (element-type-subtype (array-element-type sequence)))
          (result #-ppc-target (%make-uvector length subtype)
                  #+ppc-target (%alloc-misc length subtype))
          )
     (multiple-value-bind (src offset subtype) (array-data-offset-subtype sequence)
       (declare (fixnum offset subtype))                          
       (dotimes (i length result)
         (declare (fixnum i))
         #-ppc-target
         (%typed-uvset subtype result i (%typed-uvref subtype src offset))
         #+ppc-target
         (%typed-miscset subtype result i (%typed-miscref subtype src offset))
         (incf offset))))))

(defun check-sequence-bounds (seq start end &optional length)
  (if (not length) 
    (setq length (length seq)))
  (if (not end)
    (setq end length))
  (cond ((> end length)
         (%err-disp $XACCESSNTH end seq))
        ((> start end)
         (report-bad-arg start `(integer 0 ,end)))
        (t end)))
  

;;; Fill:

(defun fill (sequence item &key (start 0) end)
  "Replace the specified elements of SEQUENCE with ITEM.
   !$ could be sped up by calling iv-fill, sv-fill to avoid aref overhead."
  (setq end (check-sequence-bounds sequence start end nil))
  (locally (declare (fixnum start end))
    (seq-dispatch 
     sequence
     (do* ((current (nthcdr start sequence) (cdr (the list current)))
           (index start (1+ index)))
          ((or (atom current) (= index end)) sequence)
       (declare (fixnum index))
       (rplaca (the cons current) item))
     (multiple-value-bind (data offset)(array-data-and-offset sequence)
       (declare (fixnum offset))
       (setq start (+ start offset) end (+ end offset))
       (do ((index start (1+ index)))
           ((= index end) sequence)
         (declare (fixnum index)(OPTIMIZE (SPEED 3)(SAFETY 0)))
         (setf (uvref data index) item))))))

;;; Replace:

(defun replace (target-sequence source-sequence &key
                                ((:start1 target-start) 0)
                                ((:end1 target-end))
                                ((:start2 source-start) 0)
                                ((:end2 source-end)))
  "The target sequence is destructively modified by copying successive
   elements into it from the source sequence."
  (setq target-end (check-sequence-bounds target-sequence target-start
                                          target-end nil))
  (setq source-end (check-sequence-bounds source-sequence source-start
                                          source-end nil))
  (locally (declare (fixnum target-start target-end source-start source-end))
    (seq-dispatch 
     target-sequence
     (seq-dispatch 
      source-sequence
      (if (and (eq target-sequence source-sequence) 
               (> target-start source-start))
        (let ((new-elts (subseq source-sequence source-start
                                (+ source-start
                                   (min (- target-end target-start)
                                        (- source-end source-start))))))
          (do ((n new-elts (cdr n))
               (o (nthcdr target-start target-sequence) (cdr o)))
              ((null n) target-sequence)
            (rplaca o (car n))))
        (do ((target-index target-start (1+ target-index))
             (source-index source-start (1+ source-index))
             (target-sequence-ref (nthcdr target-start target-sequence)
                                  (cdr target-sequence-ref))
             (source-sequence-ref (nthcdr source-start source-sequence)
                                  (cdr source-sequence-ref)))
            ((or (= target-index target-end) (= source-index source-end)
                 (null target-sequence-ref) (null source-sequence-ref))
             target-sequence)
          (declare (fixnum target-index source-index))
          (rplaca target-sequence-ref (car source-sequence-ref))))
      (do ((target-index target-start (1+ target-index))
           (source-index source-start (1+ source-index))
           (target-sequence-ref (nthcdr target-start target-sequence)
                                (cdr target-sequence-ref)))
          ((or (= target-index target-end) (= source-index source-end)
               (null target-sequence-ref))
           target-sequence)
        (declare (fixnum target-index source-index))
        (rplaca target-sequence-ref (aref source-sequence source-index))))
     (seq-dispatch 
      source-sequence
      (do ((target-index target-start (1+ target-index))
           (source-index source-start (1+ source-index))
           (source-sequence (nthcdr source-start source-sequence)
                            (cdr source-sequence)))
          ((or (= target-index target-end) (= source-index source-end)
               (null source-sequence))
           target-sequence)
        (declare (fixnum target-index source-index))
        (aset target-sequence target-index (car source-sequence)))
      ;;; If we are copying around in the same vector, be careful not to copy the
      ;;; same elements over repeatedly.  We do this by copying backwards.
      (if (and (eq target-sequence source-sequence) 
               (> target-start source-start))
        (let ((nelts (min (- target-end target-start) 
                          (- source-end source-start))))
          (do ((target-index (+ target-start nelts -1) (1- target-index))
               (source-index (+ source-start nelts -1) (1- source-index)))
              ((= target-index (1- target-start)) target-sequence)
            (aset target-sequence target-index
                  (aref source-sequence source-index))))
        (multiple-value-bind (target-vect target-offset)(array-data-and-offset target-sequence)
          (multiple-value-bind (source-vect source-offset)(array-data-and-offset source-sequence)
            (declare (fixnum target-offset source-offset))
            (setq target-start (+ target-start target-offset)
                  source-start (+ source-start source-offset)
                  target-end (+ target-end target-offset)
                  source-end (+ source-end source-offset))
            (do ((target-index target-start (1+ target-index))
                 (source-index source-start (1+ source-index)))
                ((or (= target-index target-end) (= source-index source-end))
                 target-sequence)
              (declare (fixnum target-index source-index))
              (uvset target-vect target-index
                     (uvref source-vect source-index))))))))))

;;; Concatenate:

(defvar *68k-vector-types*
  #-ppc-target '(simple-long-vector simple-unsigned-long-vector
                 simple-unsigned-byte-vector
                 simple-unsigned-word-vector
                 simple-byte-vector
	         simple-word-vector)
  #+ppc-target nil)

;; maybe type-of should do this - don't dare try though
(defun canonicalize-68k-typespec (typespec)
  (if (atom typespec)
    (if (memq typespec *68k-vector-types*)
      (case typespec
        (simple-long-vector '(simple-array (signed-byte 32)))
        (simple-unsigned-long-vector '(simple-array (unsigned-byte 32)))
        (simple-unsigned-byte-vector '(simple-array (unsigned-byte 8)))
        (simple-unsigned-word-vector '(simple-array (unsigned-byte 16)))
        (simple-byte-vector '(simple-array (signed-byte 8)))
        (simple-word-vector '(simple-array (signed-byte 16)))        
        (t typespec))
      typespec)
    (if (consp typespec)
      (let ((the-car (car typespec)))
        (if (memq the-car *68k-vector-types*)
          (progn (setq the-car (canonicalize-68k-typespec the-car))
                 (append the-car  (list (cdr typespec))))
          typespec))
      typespec)))

(defun concatenate (output-type-spec &rest sequences &aux type-specifier-atom)
  "Returns a new sequence of all the argument sequences concatenated together
   which shares no structure with the original argument sequences of the
   specified OUTPUT-TYPE-SPEC."
  (declare (dynamic-extent sequences))
  (if (memq output-type-spec '(string simple-string))
    (setq output-type-spec
          (dolist (seq sequences 'base-string)  ; hope the list is short - dont care about vectors => strings today
            (when (and seq (not (base-string-p seq))) ; of course it may not need to be extended.
              (return 'extended-string))))            
    (unless (memq output-type-spec `(string simple-string base-string list cons vector 
                                     simple-base-string simple-extended-string extended-string
                                     bit-vector simple-bit-vector
                                     ,@*68k-vector-types*))
      (when (and (consp output-type-spec)
                 (memq (car output-type-spec) `(string simple-string))) ;; cause these are union types
        (setq type-specifier-atom (car output-type-spec)))
      (setq output-type-spec (type-expand output-type-spec))))
  (case (or type-specifier-atom (type-specifier-atom output-type-spec))
    ((list cons) (apply #'concat-to-list* sequences))
    ((simple-vector simple-string simple-base-string base-string vector string array simple-array
                    bit-vector simple-bit-vector extended-string simple-extended-string)
     (apply #'concat-to-simple* output-type-spec sequences))
    (t (if (subtypep output-type-spec 'list)
         (let ((res (apply #'concat-to-list* sequences)))
           (if (eq output-type-spec 'null)
             (if (eq (length res) 0)
               res
               (error "~S: invalid output type specification." output-type-spec))))               
         (error "~S: invalid output type specification." output-type-spec)))))

;;; Internal Frobs:

(defun concat-to-list* (&rest sequences)
  (declare (dynamic-extent sequences))
  (let* ((result (list nil))
         (splice result))
    (dolist (sequence sequences (%cdr result))
      (seq-dispatch
       sequence
       (dolist (item sequence)
         (setq splice (%cdr (%rplacd splice (list item)))))
       (dotimes (i (length sequence))
         (setq splice (%cdr (%rplacd splice (list (aref sequence i))))))))))
             

(defun concat-to-simple* (output-type-spec &rest arg-sequences)
  (declare (dynamic-extent arg-sequences))
  (do ((seqs arg-sequences (cdr seqs))
        (total-length 0)
        ;(lengths ())
        )
      ((null seqs)
       (do ((sequences arg-sequences (cdr sequences))
            ;(lengths lengths (cdr lengths))
            (index 0)
            (result (make-sequence output-type-spec total-length)))
           ((= index total-length) result)
         (let ((sequence (car sequences)))
           (seq-dispatch
            sequence
            (do ((sequence sequence (cdr sequence)))
                ((atom sequence))
              (aset result index (car sequence))
              (setq index (1+ index)))
            (let ((len (length sequence)))
              (do ((jndex 0 (1+ jndex)))
                  ((= jndex len))
                (aset result index (aref sequence jndex))
                (setq index (1+ index))))))))
     (let ((length (length (car seqs))))
       ;(setq lengths (nconc lengths (list length))) ; if itsa list, we dont care about its length, if itsan array, length twice is cheap
       (setq total-length (+ total-length length)))))


;This one doesn't choke on circular lists, doesn't cons as much, and is
;about 1/8K smaller to boot.
(defun map (type function sequence &rest more-sequences)
  (declare (dynamic-extent more-sequences))
  (let* ((sequences (cons sequence more-sequences))
         (arglist (make-list (length sequences)))
         (index 0)
         args seq p (ans ()))
    (declare (dynamic-extent sequences arglist))
    (unless (or (null type)
                (eq type 'list)
                (memq (if (consp type) (%car type) type)
                      '(simple-vector simple-string vector string array
                        simple-array bit-vector simple-bit-vector))
                (subtypep type 'sequence))
      (report-bad-arg type 'sequence))
    (loop
      (setq p sequences args arglist)
      (while p
        (cond ((null (setq seq (%car p))) (return))
              ((consp seq)
               (%rplaca p (%cdr seq))
               (%rplaca args (%car seq)))
              ((eq index (length seq)) (return))
              (t (%rplaca args (elt seq index))))
        (setq args (%cdr args) p (%cdr p)))
      (setq p (apply function arglist))
      (if type (push p ans))
      (setq index (%i+ index 1)))
    (when type
      (setq ans (nreverse ans))
      (if (eq type 'list) ans (coerce ans type)))))

;;;;;;;;;;;;;;;;;
;;
;; some, every, notevery, notany
;;
;; these all call SOME-XX-MULTI or SOME-XX-ONE
;; SOME-XX-MULTI should probably be coded in lap
;;
;; these should be transformed at compile time
;;
;; we may want to consider open-coding when
;; the predicate is a lambda
;; 

(eval-when (:execute :compile-toplevel)
  (defmacro negating-quantifier-p (quantifier-constant)
    `(%i> ,quantifier-constant $notany))
  )

; Vector is guaranteed to be simple; new-size is guaranteed <= (length vector).
; Return vector with its size adjusted and extra doublewords zeroed out.
; Should only be called on freshly consed vectors...
#-PPC-target
(defun %truncate-vector (v new-size)
  (lap-inline ()
    (:variable v new-size)
    (move.l arg_y atemp0)
    (vector-length-subtype atemp0 dy da)        ; da.b <- subtype, dy.l <- size
    (if# (eq (cmp.b ($ $v_bitv) da))
      ; Woe.  Whoa.
      ; First, compare new & old logical sizes.
      (move.l dy dx)
      (if# (ne (sub.l ($ 1) dx))
        (sub.l ($ 1) dx)
        (lsl.l ($ 3) dx)
        (moveq 0 db)
        (add.b (atemp0 $v_data) db)
        (add.l db dx))
      (move.l arg_z db)
      (getint db)
      (bif (le db dx) @done)
      (moveq 7 dx)
      (and.w db dx)                   ; bits in last byte
      (if# (ne (move.b dx (atemp0 $v_data)))
        (moveq 1 dx))
      (lsr.l ($ 3) db)
      (add.l ($ 1) db)
      (add.l dx db)
      (move.l db arg_z)        
      elseif# (or (ne (btst ($ $vnodebit) da))
                  (eq (cmp.b ($ $v_slongv) da))
                  (eq (cmp.b ($ $v_ulongv) da)))
      (vscale.l arg_z)
      elseif# (or (eq (cmp.b ($ $v_sstr) da))
                  (eq (cmp.b ($ $v_sbytev) da))
                  (eq (cmp.b ($ $v_ubytev) da)))
      (vscale.b arg_z)
      else# 
      (vscale.w arg_z))
    (if# (gt arg_z dy)
      (build-vector-header arg_z da db)
      (move.l db (atemp0 $vec.header))
      (add.l ($ 3) dy)
      (and.w ($ (lognot 3)) dy)
      (add.l ($ 3) arg_z)
      (and.w ($ (lognot 3)) arg_z)
      (sub.l arg_z dy)
      (lsr.l ($ 2) dy)
      (lea (atemp0 arg_z.l $v_data) atemp1)
      (moveq 0 da)
      (dbfloop.l dy (move.l da (@+ atemp1))))
@done
    (move.l atemp0 acc)))

(defun predicate-test (predicate)
  (cond ((symbolp predicate)
         (if (not (fboundp predicate))
           (require-type predicate 'function)
           predicate))        
        (t (require-type predicate 'function))))
    
(defun some (predicate one-seq &rest sequences)
  (declare (dynamic-extent sequences))
  (setq predicate (predicate-test predicate))
  (if sequences
      (some-xx-multi $some nil predicate one-seq sequences)
      (some-xx-one $some nil predicate one-seq)))

(defun notany (predicate one-seq &rest sequences)
  (declare (dynamic-extent sequences))
  (setq predicate (predicate-test predicate))
  (if sequences
      (some-xx-multi $notany t predicate one-seq sequences)
      (some-xx-one $notany t predicate one-seq)))

(defun every (predicate one-seq &rest sequences)
  (declare (dynamic-extent sequences))
  (setq predicate (predicate-test predicate))
  (if sequences
      (some-xx-multi $every t predicate one-seq sequences)
      (some-xx-one $every t predicate one-seq)))

(defun notevery (predicate one-seq &rest sequences)
  (declare (dynamic-extent sequences))
  (setq predicate (predicate-test predicate))
  (if sequences
      (some-xx-multi $notevery nil predicate one-seq sequences)
      (some-xx-one $notevery nil predicate one-seq)))

(defun some-xx-multi (caller at-end predicate first-seq sequences)
  (let* ((sequences (cons first-seq sequences))
         (min-vector-length most-positive-fixnum)
         (arg-slice (make-list (list-length sequences)))
         (cur-slice arg-slice)
         (not-result (negating-quantifier-p caller))
         result)
  (declare (fixnum min-vector-length)
           (list sequences arg-slice cur-slice)
           (dynamic-extent sequences arg-slice))
  (dolist (seq sequences)
    (seq-dispatch seq
                  nil
                  (setq min-vector-length (min min-vector-length
                                               (length seq)))))
  (dotimes (index min-vector-length)
    (dolist (one-seq sequences)
      (%rplaca cur-slice
               (if (vectorp one-seq)
                   (aref one-seq index)
                   (if one-seq
                       (progn
                         (%rplaca (memq one-seq sequences) (cdr one-seq))
                         (%car one-seq))
                       (return-from some-xx-multi at-end))))
      (setq cur-slice (%cdr cur-slice)))
    (setq result (apply predicate arg-slice)
          cur-slice arg-slice)
    (if not-result
        (when (not result)
          (return-from some-xx-multi
                       (if (eq caller $every) nil t)))
        (when result
          (return-from some-xx-multi
                       (if (eq caller $some) result nil)))))
  at-end))


(defun some-xx-one (caller at-end predicate seq
                           &aux (not-result (negating-quantifier-p caller))
                           result)
  (if (vectorp seq)
      (if (simple-vector-p seq)
        (locally (declare (type simple-vector seq))
          (dovector (element seq)
            (setq result (funcall predicate element))
            (if not-result
              (when (not result)
                (return-from some-xx-one
                  (if (eq caller $every) nil t)))
              (when result
                (return-from some-xx-one
                  (if (eq caller $some ) result nil))))))
        (dovector (element seq)
          (setq result (funcall predicate element))
          (if not-result
            (when (not result)
              (return-from some-xx-one
                (if (eq caller $every) nil t)))
            (when result
              (return-from some-xx-one
                (if (eq caller $some ) result nil))))))
      (dolist (element seq)
        (setq result (funcall predicate element))
        (if not-result
            (when (not result)
              (return-from some-xx-one
                           (if (eq caller $every) nil t)))
            (when result
              (return-from some-xx-one
                           (if (eq caller $some ) result nil))))))
      at-end)

;;; simple positional versions of find, position

(defun find-positional-test-key (item sequence test key)
  (if sequence
    (seq-dispatch
     sequence
     (let ((cons (member item sequence :test test :key key)))
       (and cons (%car cons)))
     (let ((pos (vector-position-1 item sequence nil test nil 0 nil key)))
       (and pos (aref sequence pos))))))

(defun find-positional-test-not-key (item sequence test-not key)
  (if sequence
    (seq-dispatch
     sequence
     (let ((cons (member item sequence :test-not test-not :key key)))
       (and cons (%car cons)))
     (let ((pos (vector-position-1 item sequence nil nil test-not 0 nil key)))
       (and pos (aref sequence pos))))))

(defun position-positional-test-key (item sequence test key)
  (if sequence
    (seq-dispatch
     sequence
     (progn
       (setq key (adjust-key key))
       (setq test
             (adjust-test-args item test nil))
       (if (or test key)
         (list-position/find-complex nil item sequence 0 nil test nil key)
         (list-position/find-simple nil item sequence 0 nil)))
     (vector-position-1 item sequence nil test nil 0 nil key))))

(defun position-positional-test-not-key (item sequence test-not key)
  (if sequence
    (seq-dispatch
     sequence
     (progn
       (setq key (adjust-key key))
       (multiple-value-bind (test test-not)
                            (adjust-test-args item nil test-not)
         (list-position/find-complex nil item sequence 0 nil test test-not key)))
     (vector-position-1 item sequence nil nil test-not 0 nil key))))


;;; Reduce:

(eval-when (:execute :compile-toplevel)
  
  (defmacro list-reduce (function sequence start end initial-value ivp key)
    (let ((what `(if ,key (funcall ,key (car sequence)) (car sequence))))
      `(let ((sequence (nthcdr ,start ,sequence)))
         (do ((count (if ,ivp ,start (1+ ,start)) (1+ count))
              (sequence (if ,ivp sequence (cdr sequence))
                        (cdr sequence))
              (value (if ,ivp ,initial-value ,what)
                     (funcall ,function value ,what)))
             ((= count ,end) value)))))
  
  (defmacro list-reduce-from-end (function sequence start end 
                                           initial-value ivp key)
    (let ((what `(if ,key (funcall ,key (car sequence)) (car sequence))))
      `(let ((sequence (nthcdr (- (length ,sequence) ,end) (reverse ,sequence))))
         (do ((count (if ,ivp ,start (1+ ,start)) (1+ count))
              (sequence (if ,ivp sequence (cdr sequence))
                        (cdr sequence))
              (value (if ,ivp ,initial-value ,what)
                     (funcall ,function ,what value)))
             ((= count ,end) value)))))
  
  ) ;; end eval-when

(defun reduce (function sequence &key from-end (start 0)
                        end (initial-value nil ivp) key)
  "The specified Sequence is ``reduced'' using the given Function.
  See manual for details."
  (unless end (setq end (length sequence)))
  (if (= end start)
    (if ivp initial-value (funcall function))
    (seq-dispatch
     sequence
     (if from-end
       (list-reduce-from-end  function sequence start end initial-value ivp key)
       (list-reduce function sequence start end initial-value ivp key))
     (let* ((disp (if from-end -1 1))
            (index (if from-end (1- end) start))
            (terminus (if from-end (1- start) end))
            (value (if ivp initial-value
                       (let ((elt (aref sequence index)))
                         (setq index (+ index disp))
                         (if key (funcall key elt) elt))))
            (element nil))
       (do* ()
            ((= index terminus) value)
         (setq element (aref sequence index)
               index (+ index disp)
               element (if key (funcall key element) element)
               value (funcall function (if from-end element value) (if from-end value element))))))))

(defun map-into (result-sequence function &rest sequences)
  (declare (dynamic-extent sequences))
  (let* ((nargs (list-length sequences))
         (temp (make-list (length sequences)))
         (maxcnt (seq-dispatch result-sequence (length result-sequence) (array-total-size result-sequence)))
         (rseq result-sequence))
    (declare (fixnum cnt nargs maxcnt))
    (declare (dynamic-extent temp))
    ; this declaration is maybe bogus
    (dolist (seq sequences)
      (let ((len (length seq)))
        (declare (fixnum len))
        (if (< len maxcnt)(setq maxcnt len))))
    (dotimes (cnt maxcnt)
      (let ((args temp)(seqs sequences))
        (dotimes (i nargs)
          (let ((seq (%car seqs)))
            (cond ((listp seq)
                   (%rplaca seqs (%cdr seq))
                   (%rplaca args (%car seq)))
                  (t (%rplaca args (aref seq cnt)))))
          (setq args (%cdr args))
          (setq seqs (%cdr seqs))))
      (let ((res (apply function temp)))
        (cond ((consp rseq)
               (%rplaca rseq res)
               (setq rseq (%cdr rseq)))
              (t (setf (aref result-sequence cnt) res)))))
    (when (and (not (listp result-sequence))
               (array-has-fill-pointer-p result-sequence))
      (setf (fill-pointer result-sequence) maxcnt))
    result-sequence))
          
    
;;; Coerce:

#|
; don't know if this is always right
; It's almost never right: the "type-spec" could be something
; defined with DEFTYPE, whose last element (if it has one) has
; nothing to do with the "length" of the specified type.
(defun specifier-length (type-spec)
  (if (consp type-spec)
    (let ((len? (car (last type-spec))))
      (if (fixnump len?) len?))))
|#

#+ppc-clos
(defun array-ctype-length (ctype)
  (if (typep ctype 'array-ctype)
    (let* ((dims (array-ctype-dimensions ctype)))
      (if (listp dims)
        (if (null (cdr dims))
          (let* ((dim0 (car dims)))
            (unless (eq dim0 '*) dim0)))))
    (if (typep ctype 'union-ctype)
      ; this isn't really right either but does trt for (string 2)
      ; check if all specify a length and lengths are the same?
      (dolist (type (union-ctype-types ctype))
        (let ((len (array-ctype-length type)))
          (when len (return len)))))))

#-ppc-clos
; really mean ppc-typesys ?
(defun coerce (object output-type-spec)
  "Coerces the Object to an object of type Output-Type-Spec."
  (setq output-type-spec (type-expand output-type-spec))
  (cond ((or (eq output-type-spec 'character) (eq output-type-spec 'base-character))
         (character object))
        ((eq output-type-spec 'standard-char)
         (let ((char (character object)))
           (unless (standard-char-p char) (%err-disp $xcoerce object 'standard-char))
           char))
        ((numberp object)
         (let* ((name output-type-spec) (args ()))
           (when (listp name) (setq args (%cdr name) name (%car name)))
           (cond ((eq name 'complex)
                  (if (endp args) (coerce-to-complex object)
                      (let ((rtype (type-expand (%car args))))
                        (cond ((%cdr args) (signal-program-error "Invalid type-specifier ~S" output-type-spec))
                              ((memq rtype '(float short-float single-float double-float long-float))
                               (coerce-to-complex-float (if (eq rtype 'short-float)
                                                          (ash 1 $t_sfloat)
                                                          (if (eq rtype 'float)
                                                            (logior (ash 1 $t_sfloat) (ash 1 $t_dfloat))
                                                            (ash 1 $t_dfloat)))
                                                        object))
                              ((or (eq rtype 'real) (eq rtype '*))
                               (coerce-to-complex object))
                              (t (coerce-to-complex-type object rtype))))))
                 ((memq name '(float short-float single-float double-float long-float))
                  (if (null args)
                    (let ((float (float object (if (eq name 'short-float) 0.0s0 0.0))))
                      (when args
                        (unless (test-limits float output-type-spec)
                          (%err-disp $xcoerce object output-type-spec)))
                      float)))
                 ((typep object output-type-spec) object)
                 (t (%err-disp $xcoerce object output-type-spec)))))
        ((and (stringp object)
              (or (eq output-type-spec 'string)
                  (typep object output-type-spec)))
         object)              
        ((eq output-type-spec 'function) (coerce-to-function-1 object))
        ((eq output-type-spec 'compiled-function) (coerce-to-compiled-function object))
        ((eq output-type-spec 'list) (coerce-to-list object))
        ((memq output-type-spec '(cons null))
         (let ((list (coerce-to-list object)))
           (when (eq output-type-spec (if (null list) 'cons 'null))
             (%err-disp $xcoerce object output-type-spec))
           list))
        (t (multiple-value-bind (rank elt-type size simple-p)
                                (parse-array-type output-type-spec)
             ;They don't actually expect us to typecheck all the elt-types,
             ;do they?  Well, we don't, we upgrade first, so there.
             (setq elt-type (unless (eq elt-type '*)
                              (or (element-type-subtype elt-type)
                                  ;elt-type is NIL, so can't coerce.
                                  (%err-disp $xcoerce object output-type-spec))))
             (cond ((null rank) ;not really an array type
                    (unless (typep object output-type-spec)
                      (%err-disp $xcoerce object output-type-spec))
                    object)
                   ((eq rank 1)
                    (if (eq size '*)
                      (coerce-to-uvector object elt-type simple-p)
                      (let ((vector (coerce-to-uvector object elt-type simple-p)))
                        (unless (eq (length vector) size)
                          (%err-disp $xcoerce object output-type-spec))
                        vector)))
                   ((or (eq rank '*) (eq rank (array-rank object)))
                    (coerce-to-uarray object elt-type simple-p))
                   (t (%err-disp $xcoerce object output-type-spec)))))))


; from optimizer - just return object if type is OK
; will maybe upgrade from base to extended otherwise (yuck) - consistent with 4.0
#-ppc-clos
(defun coerce-to-string (object type elt-type simple-p)
  (if (and (stringp object)
           (or (eq type 'string)(typep object type)))
    object
    (coerce-to-uvector object (element-type-subtype elt-type) simple-p)))



;If you change this, remember to change the transform.
#+ppc-clos
(defun coerce (object output-type-spec)
  "Coerces the Object to an object of type Output-Type-Spec."
  (let* ((type (specifier-type output-type-spec)))
    (if (%typep object type)
      object
      (cond       
       ((csubtypep type (specifier-type 'character))
        (let ((char (character object)))
          (cond ((eq output-type-spec 'standard-char)
                 (unless (standard-char-p char) (%err-disp $xcoerce object 'standard-char))
                 char)
                ((memq output-type-spec '(base-char base-character))
                 (unless (base-character-p char) (%err-disp $xcoerce object 'base-char))
                 char)
                (t char))))
       ((eq output-type-spec 'compiled-function)
        (coerce-to-compiled-function object))
       ((csubtypep type (specifier-type 'function))
        (coerce-to-function-1 object))
       ((csubtypep type (specifier-type 'cons))
        (if object
          (coerce-to-list object)
          (report-bad-arg object 'cons)))
       ((csubtypep type (specifier-type 'list))
        (coerce-to-list object))
       ((csubtypep type (specifier-type 'string))
        (coerce-to-string object type))
       #|
        (if (characterp object)
          (setq object (string object)))
        (let ((length (array-ctype-length type)))
          (if (and length (neq length (length object))) ;; <<
            (signal-type-error object length
                               "Length of ~a is not ~a" )))
        (coerce-to-uarray object (if (csubtypep type (specifier-type 'base-string))
                                   (type-keyword-code :base-string (target-platform))
                                   (type-keyword-code :extended-string (target-platform)))
                          t) |#
        
       ((csubtypep type (specifier-type 'vector))
        (let* ((element-type (type-specifier (array-ctype-element-type type))))
          (let ((length (array-ctype-length type)))
            (if (and length (neq length (length object)))
              (report-bad-arg (make-array length :element-type (if (eq element-type '*) t element-type))
                              `(vector ,element-type ,(length object))))
            (coerce-to-uarray object (element-type-subtype element-type) t))))
       ((csubtypep type (specifier-type 'array))
        (let* ((dims (array-ctype-dimensions type)))
          (when (consp dims)
            (when (not (null (cdr dims)))
              (signal-type-error output-type-spec 'sequence "~s is not a sequence type."))))
        (let ((length (array-ctype-length type)))
          (if (and length (neq length (length object)))
            (signal-type-error  object length "Length of ~s is not ~s.")))
        (coerce-to-uarray object (element-type-subtype (type-specifier 
                                                        (array-ctype-element-type type))) t))
       ((numberp object)
        (let ((res
               (cond
                #|
                ((csubtypep type (specifier-type 'single-float))
                 (float object 1.0s0))                
                ((csubtypep type (specifier-type 'float))
                 (float object 1.0d0))
                |# ;; if want 'float to be single
                ((csubtypep type (specifier-type 'double-float))
                 (float object 1.0d0))
                ((csubtypep type (specifier-type 'float))
                 (float object 1.0s0))
                 
                ((csubtypep type (specifier-type 'complex))
                 (coerce-to-complex object  output-type-spec)))))
          (unless res ;(and res (%typep res type))
            (error "~S can't be coerced to type ~S." object output-type-spec))
          res))
       (t (signal-type-error object output-type-spec "~S can't be coerced to type ~S."))))))

#+ppc-clos
(when (not (fboundp 'coerce-to-complex)) ; its in numbers in 3.0 - comes first - notype-spec
  (defun coerce-to-complex (object  output-type-spec)
    (if (consp output-type-spec)
      (let ((type2 (cadr output-type-spec)))     
        (if (complexp object)
          (complex (coerce (realpart object) type2)(coerce (imagpart object) type2))
          (complex (coerce object type2) 0)))
      (complex object))))
        

(defun coerce-to-function-1 (thing)
  (if (functionp thing)
    thing
    (if (symbolp thing)
      (%function thing)
      (if (lambda-expression-p thing)
        (%make-function nil thing nil)
        (%err-disp $xcoerce thing 'function)))))

;;; Internal Frobs:
;(coerce object '<array-type>)
(defun coerce-to-uarray (object subtype simple-p)
  (if (typep object 'array)
    (if (and (or (not simple-p) (typep object 'simple-array))
             (or (null subtype) (eq (array-element-subtype object) subtype)))
      object
      ;Make an array of the same shape as object but different subtype..
      (%copy-array subtype object))
    (if (typep object 'list)
      (%list-to-uvector subtype object)
      (%err-disp $xcoerce object 'array))))

(defun coerce-to-string (object &optional (ctype (specifier-type 'string)))
  (if (characterp object)
    (setq object (string object))
    (if (and object (symbolp object))  ;; ??
      (setq object (symbol-name object))))
  (cond 
   ((ctypep object ctype) object)
   (t    
    (let ((length (array-ctype-length ctype)))
      (if (and length (neq length (length object))) ;; <<
        (signal-type-error object length
                           "Length of ~s is not ~a." )))
    (let ((base-p (csubtypep ctype (specifier-type 'base-string))))
      (when base-p
        (if (and (stringp object)(not (latin1-p object)))
          (signal-type-error object ctype "~s cannot be coerced to ~s.")
          (if (vectorp object)
            (dovector (elt object)
              (if (not (base-character-p elt))
                (signal-type-error object ctype "~s cannot be coerced to ~s." ))))))    
      (coerce-to-uarray object (if base-p
                                 (type-keyword-code :base-string (target-platform))
                                 (type-keyword-code :extended-string (target-platform)))
                        t)))))

;(coerce object 'list)
(defun coerce-to-list (object)
  (seq-dispatch 
   object
   object
   (let* ((n (length object)))
     (declare (fixnum n))
     (multiple-value-bind (data offset) (array-data-and-offset object)
       (let* ((head (cons nil nil))
              (tail head))
         (declare (dynamic-extent head)
                  (cons head tail))
         (do* ((i 0 (1+ i))
               (j offset (1+ j)))
              ((= i n) (cdr head))
           (declare (fixnum i j))
           (setq tail (cdr (rplacd tail (cons (uvref data j) nil))))))))))
 

(defun %copy-array (new-subtype array)
  ;To be rewritten once make-array disentangled (so have a subtype-based entry
  ;point)
  (make-array (if (eql 1 (array-rank array))
                (length array)
                (array-dimensions array))
              :element-type (element-subtype-type new-subtype)
              :initial-contents array ;***** WRONG *****
              ))

(defun check-count (c)
  (if c
    (min (max (require-type c 'integer) 0) most-positive-fixnum)
    most-positive-fixnum))

;;; Delete:

(defun list-delete-1 (item list from-end test test-not start end count key 
                           &aux (temp list)  revp)
  (unless end (setq end most-positive-fixnum))
  (when (and from-end count)
    (let ((len (length temp)))
      (if (not (%i< start len))
        (return-from list-delete-1 temp))
      (setq temp (nreverse temp) revp t)
      (psetq end (%i- len start)
             start (%i- len (%imin len end)))))
  (setq key (adjust-key key))
  (multiple-value-setq (test test-not)
                       (adjust-test-args item test test-not))
  (setq temp
        (if (or test key test-not)
          (list-delete-moderately-complex item temp start end count test test-not key)
          (list-delete-very-simple item temp start end count)))
   (if revp
    (nreverse temp)
    temp))


(defun list-delete-very-simple (item list start end count)
  (unless start (setq start 0))
  (unless end (setq end most-positive-fixnum))
  (setq count (check-count count))
  (do* ((handle (cons nil list))
        (splice handle)
        (numdeleted 0)
        (i 0 (1+ i)))
       ((or (eq i end) (null (%cdr splice)) (eq numdeleted count))
        (%cdr handle))
    (declare (fixnum i start end count numdeleted)  ; declare-type-free !!
             (dynamic-extent handle) 
             (list splice handle))
    (if (and (%i>= i start) (eq item (car (%cdr splice))))
      (progn
        (%rplacd splice (%cddr splice))
        (setq numdeleted (%i+ numdeleted 1)))
      (setq splice (%cdr splice)))))

(defun list-delete-moderately-complex (item list start end count test test-not key)
  (unless start (setq start 0))
  (unless end (setq end most-positive-fixnum))
  (setq count (check-count count))
  (do* ((handle (cons nil list))
        (splice handle)
        (numdeleted 0)
        (i 0 (1+ i)))
       ((or (= i end) (null (cdr splice)) (= numdeleted count))
        (cdr handle))
    (declare (fixnum i start end count numdeleted)
             (dynamic-extent handle)
             (list splice))
    (if (and (>= i start) (matchp2 item (cadr splice) test test-not key))
      (progn
        (rplacd splice (cddr splice))
        (setq numdeleted (1+ numdeleted)))
      (setq splice (cdr splice)))))

(defun list-delete (item list &key from-end test test-not (start 0)
                         end count key 
                         &aux (temp list)  revp)
  (unless end (setq end most-positive-fixnum))
  (when (and from-end count)
    (let ((len (length temp)))
      (if (not (%i< start len))
        (return-from list-delete temp))
      (setq temp (nreverse temp) revp t)
      (psetq end (%i- len start)
             start (%i- len (%imin len end)))))
  (setq key (adjust-key key))
  (multiple-value-setq (test test-not)
                       (adjust-test-args item test test-not))
  (setq temp
        (if (or test key test-not)
          (list-delete-moderately-complex item temp start end count test test-not key)
          (list-delete-very-simple item temp start end count)))
   (if revp
    (nreverse temp)
    temp))

; Modified to clear the elements between the old and new fill pointers
; so they won't hold on to garbage.
(defun vector-delete (item vector test test-not key start end inc count
                           &aux (length (length vector)) pos fill val)
  (setq key (adjust-key key))
  (multiple-value-setq (test test-not) (adjust-test-args item test test-not))
  (setq end (check-sequence-bounds vector start end length))
  (if (%i< inc 0) (psetq start (%i- end 1) end (%i- start 1)))
  (setq fill (setq pos start))
  (loop
    (if (or (eq count 0) (eq pos end)) (return))
    (if (matchp2 item (setq val (aref vector pos)) test test-not key)
      (setq count (%i- count 1))
      (progn
        (if (neq fill pos) (setf (aref vector fill) val))
        (setq fill (%i+ fill inc))))
    (setq pos (%i+ pos inc)))
  (if (%i> fill pos) (psetq fill (%i+ pos 1) pos (%i+ fill 1)))
  (loop
    (if (eq pos length) (return))
    (setf (aref vector fill) (aref vector pos))
    (setq fill (%i+ fill 1) pos (%i+ pos 1)))
  (when (gvectorp (array-data-and-offset vector))
    (let ((old-fill (fill-pointer vector))
          (i fill))
      (declare (fixnum i old-fill))
      (loop
        (when (>= i old-fill) (return))
        (setf (aref vector i) nil)
        (incf i))))
  (setf (fill-pointer vector) fill)
  vector)


; The vector will be freshly consed & nothing is displaced to it,
; so it's legit to destructively truncate it.
; Likewise, it's ok to access its components with (%typed-)UVREF.
#-ppc-target
(defun simple-vector-delete (item vector test test-not key start end inc count
                                  &aux (length (length vector)) subtype pos fill val)
  (setq key (adjust-key key))
  (setq vector (copy-seq vector))
  (setq subtype (%vect-subtype vector))
  (multiple-value-setq (test test-not) (adjust-test-args item test test-not))
  (setq end (check-sequence-bounds vector start end length))
  (if (%i< inc 0) (psetq start (%i- end 1) end (%i- start 1)))
  (setq fill (setq pos start))
  (loop
    (if (or (eq count 0) (eq pos end)) 
      (progn 
        (if (%i> fill pos) (psetq fill (%i+ pos 1) pos (%i+ fill 1)))
        (loop
          (if (eq pos length) (return))
          #-ppc-target
          (%typed-uvset subtype vector fill (%typed-uvref subtype vector pos))
          #+ppc-target
          (%typed-miscset subtype vector fill (%typed-miscref subtype vector pos))
          (setq fill (%i+ fill 1) pos (%i+ pos 1)))
        (return)))
    (if (matchp2 item (setq val #-ppc-target (%typed-uvref subtype vector pos)
                            #+ppc-target (%typed-miscref subtype vector pos)
                            )
                 test test-not key)
      (setq count (%i- count 1))
      (progn
        (if (neq fill pos)
          #-ppc-target (%typed-uvset subtype vector fill val)
          #+ppc-target (%typed-miscset subtype vector fill val)
          )
        (setq fill (%i+ fill inc))))
    (setq pos (%i+ pos inc)))
  (%truncate-vector vector fill))

#+ppc-target ; - grovel twice -  dont copy first
(defun simple-vector-delete (item vector test test-not key start end inc count
                                  &aux (length (length vector)) 
                                  subtype pos fill)
  (setq key (adjust-key key))
  (multiple-value-setq (test test-not) (adjust-test-args item test test-not))
  (setq end (check-sequence-bounds vector start end length))
  (setq fill start)
  (if (%i< inc 0) (psetq start (%i- end 1) end (%i- start 1)))
  (let* ((bv (make-array (the fixnum (length vector)) :element-type 'bit :Initial-element 0))
         offset)    
    (declare (dynamic-extent bv)
             (type (simple-array bit (*)) bv))
    (multiple-value-setq (vector offset)(array-data-and-offset vector))
    (setq subtype (%vect-subtype vector))
    (setq pos start)
    (loop
      (when (or (eq count 0) (eq pos end))
        (unless (eq pos end)
          (incf fill (abs (- pos end))))
        (return))
      (if (matchp2 item   ; its already +ppc-target - lets make double sure?
                   #-ppc-target (%typed-uvref subtype vector (%i+ pos offset))
                   #+ppc-target (%typed-miscref subtype vector (%i+ pos offset))
                   test test-not key)
        (progn (setf (aref bv pos) 1)
               (setq count (%i- count 1)))
        (setq fill (%i+ fill 1)))
      (setq pos (%i+ pos inc)))
    (when (%i< inc 0)
      (psetq start (%i+ end 1) end (%i+ start 1)))
    (let* ((tail (- length end))
           (size (+ fill tail))
           (new-vect (%alloc-misc size subtype))
           (fill-end fill))
      (declare (fixnum tail size))
      (when (neq 0 start)
        (dotimes (i start)
          #-ppc-target          
          (%typed-uvset subtype new-vect i (%typed-uvref subtype vector (%i+ offset i)))
          #+ppc-target
          (%typed-miscset subtype new-vect i (%typed-miscref subtype vector (%i+ offset i)))
          ))
      (setq fill start)
      (setq pos (%i+ start offset))
      (loop
        (if (eq fill fill-end) (return))
        (if (neq 1 (aref bv pos))
          (progn
            #-ppc-target
            (%typed-uvset subtype new-vect fill (%typed-uvref subtype vector pos))
            #+ppc-target
            (%typed-miscset subtype new-vect fill (%typed-miscref subtype vector pos))
            (setq fill (%i+ fill 1))))
        (setq pos (%i+ pos 1)))
      (setq pos end)
      (loop
        (when (eq fill size) (return))
          #-ppc-target
          (%typed-uvset subtype new-vect fill (%typed-uvref subtype vector pos))
          #+ppc-target
          (%typed-miscset subtype new-vect fill (%typed-miscref subtype vector pos))
          (setq fill (%i+ fill 1)
                pos (%i+ pos 1)))
      new-vect)))


; When a vector has a fill pointer & it can be "destructively modified" by adjusting
; that fill pointer.
(defun vector-delete (item vector test test-not key start end inc count
                           &aux (length (length vector)) pos fill val)
  (setq key (adjust-key key))
  (multiple-value-setq (test test-not) (adjust-test-args item test test-not))
  (setq end (check-sequence-bounds vector start end length))
  (if (%i< inc 0) (psetq start (%i- end 1) end (%i- start 1)))
  (setq fill (setq pos start))
  (loop
    (if (or (eq count 0) (eq pos end)) (return))
    (if (matchp2 item (setq val (aref vector pos)) test test-not key)
      (setq count (%i- count 1))
      (progn
        (if (neq fill pos) (setf (aref vector fill) val))
        (setq fill (%i+ fill inc))))
    (setq pos (%i+ pos inc)))
  (if (%i> fill pos) (psetq fill (%i+ pos 1) pos (%i+ fill 1)))
  (loop
    (if (eq pos length) (return))
    (setf (aref vector fill) (aref vector pos))
    (setq fill (%i+ fill 1) pos (%i+ pos 1)))
  (when (eq t (array-element-type vector))
    (let ((old-fill (fill-pointer vector))
          (i fill))
      (declare (fixnum i old-fill))
      (loop
        (when (>= i old-fill) (return))
        (setf (aref vector i) nil)
        (incf i))))
  (setf (fill-pointer vector) fill)
  vector)

(defun delete (item sequence &key from-end test test-not (start 0)
                    end count key)
  (setq count (check-count count))
  (if sequence
    (seq-dispatch
     sequence
     (list-delete-1 item 
                  sequence 
                  from-end
                  test 
                  test-not
                  start 
                  end 
                  count
                  key)
     (if (array-has-fill-pointer-p sequence)
       (vector-delete item sequence test test-not key start end (if from-end -1 1) count)
       (simple-vector-delete item  ; well shucks why not callee decide
                            sequence
                             test test-not key start end (if from-end -1 1) count)))))

(defun delete-if (test sequence &key from-end (start 0)                       
                       end count key)
  (delete test sequence
          :test #'funcall
          :from-end from-end 
          :start start 
          :end end 
          :count count 
          :key key))

(defun delete-if-not (test sequence &key from-end (start 0) end count key)
  (delete test sequence 
          :test-not #'funcall 
          :from-end from-end 
          :start start 
          :end end 
          :count count 
          :key key))



;;; Remove:



(defun remove (item sequence &key from-end test test-not (start 0)
                    end (count most-positive-fixnum) key)
  (setq count (check-count count))
  (seq-dispatch
   sequence
   (list-delete-1 item 
                (copy-list sequence)
                from-end
                test 
                test-not
                start 
                end 
                count
                key)
   (simple-vector-delete item
                         sequence
                         test
                         test-not
                         key
                         start
                         end
                         (if from-end -1 1)
                         count)))




(defun remove-if (test sequence &key from-end (start 0)
                         end count key)
  (remove test sequence
          :test #'funcall
          :from-end from-end
          :start start
          :end end
          :count count
          :key key))

(defun remove-if-not (test sequence &key from-end (start 0)
                         end count key)
  (remove test sequence
          :test-not #'funcall
          :from-end from-end
          :start start
          :end end
          :count count
          :key key))

;;; Remove-Duplicates:

;;; Remove duplicates from a list. If from-end, remove the later duplicates,
;;; not the earlier ones. Thus if we check from-end we don't copy an item
;;; if we look into the already copied structure (from after :start) and see
;;; the item. If we check from beginning we check into the rest of the 
;;; original list up to the :end marker (this we have to do by running a
;;; do loop down the list that far and using our test.
; test-not is typically NIL, but member doesn't like getting passed NIL
; for its test-not fn, so I special cased the call to member. --- cfry

(defun remove-duplicates (sequence &key (test #'eql) test-not (start 0) 
      from-end (end (length sequence)) key)
  (delete-duplicates (copy-seq sequence) :from-end from-end :test test
                     :test-not test-not :start start :end end :key key))

;;; Delete-Duplicates:

(defresource *eq-hash-resource* :constructor (make-hash-table :test #'eq)
  :destructor #'clrhash)

(defresource *eql-hash-resource* :constructor (make-hash-table :test #'eql)
  :destructor #'clrhash)

(defresource *equal-hash-resource* :constructor (make-hash-table :test #'equal)
  :destructor #'clrhash)

(defresource *equalp-hash-resource* :constructor (make-hash-table :test #'equalp)
  :destructor #'clrhash)

(defun list-delete-duplicates* (list test test-not key from-end start end)
  ;(%print "test:" test "test-not:" test-not "key:" key)
  (let (res)
    (cond 
     ((and (> (- end start) 10) (not test-not) ;(eq key #'identity)
           (cond ((or (eq test 'eq)(eq test #'eq))(setq res *eq-hash-resource*))
                 ((or (eq test 'eql)(eq test #'eql))(setq res *eql-hash-resource*))
                 ((or (eq test 'equal)(eq test  #'equal))
                  (setq res *equal-hash-resource*))
                 ((or (eq test 'equalp)(eq test #'equalp))
                  (setq res *equalp-hash-resource*))))
      (when (not from-end)(setq list (nreverse list))) ; who cares about which end?
      (let* (prev)
        (using-resource (table res)
          (do* ((rest (nthcdr start list) (%cdr rest))
                (index start (%i+ 1 index)))
               ((or (eq index end)(null rest)))
            (declare (fixnum index start end))
            (let ((thing (funcall key (%car rest))))
              (cond ((gethash thing table)
                     (%rplacd prev (%cdr rest)))
                    (t (setf (gethash thing table) t)
                       (setq prev rest))))))
        (if from-end list (nreverse list))))
     (T 
      (let ((handle (cons nil list)))
        (do ((current  (nthcdr start list) (cdr current))
             (previous (nthcdr start handle))
             (index start (1+ index)))
            ((or (= index end) (null current)) 
             (cdr handle))
          ;(%print "outer loop top current:" current "previous:" previous)
          (if (do ((x (if from-end 
                        (nthcdr (1+ start) handle)
                        (cdr current))
                      (cdr x))
                   (i (1+ index) (1+ i)))
                  ((or (null x) 
                       (and (not from-end) (= i end)) 
                       (eq x current)) 
                   nil)
                ;(%print "inner loop top x:" x "i:" i)
                (if (list-delete-duplicates*-aux current x test test-not key)		                         
                  (return t)))
            (rplacd previous (cdr current))
            (setq previous (cdr previous)))))))))

(defun list-delete-duplicates*-aux (current x test test-not key)
     (if test-not
       (not (funcall test-not 
                     (funcall key (car current))
                     (funcall key (car x))))
       (funcall test 
                (funcall key (car current)) 
                (funcall key (car x)))))


(defun vector-delete-duplicates* (vector test test-not key from-end start end 
					 &optional (length (length vector)))
  (declare (vector vector))
  (do ((index start (1+ index))
       (jndex start))
      ((= index end)
       (do ((index index (1+ index))		; copy the rest of the vector
            (jndex jndex (1+ jndex)))
           ((= index length)
            (setq vector (shrink-vector vector jndex)))
            (aset vector jndex (aref vector index))))
      (aset vector jndex (aref vector index))
      (unless (position (funcall key (aref vector index)) vector :key key
                             :start (if from-end start (1+ index)) :test test
		                           :end (if from-end jndex end) :test-not test-not)
              (setq jndex (1+ jndex)))))

(defun delete-duplicates (sequence &key (test #'eql) test-not (start 0) from-end end key)
  "The elements of Sequence are examined, and if any two match, one is
   discarded.  The resulting sequence, which may be formed by destroying the
   given sequence, is returned.
   Sequences of type STR have a NEW str returned."
  (unless end (setq end (length sequence)))
  (unless key (setq key #'identity))
  (seq-dispatch sequence
    (if sequence
	      (list-delete-duplicates* sequence test test-not key from-end start end))
    (vector-delete-duplicates* sequence test test-not key from-end start end)))

(defun list-substitute* (pred new list start end count key 
                              test test-not old)
  ;(print-db pred new list start end count key test test-not old)
  (let* ((result (list nil))
         elt
         (splice result)
         (list list))           ; Get a local list for a stepper.
    (do ((index 0 (1+ index)))
        ((= index start))
      (setq splice (cdr (rplacd splice (list (car list)))))
      (setq list (cdr list)))
    (do ((index start (1+ index)))
        ((or (and end (= index end)) (null list) (= count 0)))
      (setq elt (car list))
      (setq splice
            (cdr (rplacd splice
                         (list
                          (cond ((case pred
                                   (normal
                                    (if test-not
                                      (not (funcall test-not  old
                                                    ;fry mod to slisp, which had arg order of OLD and ELT reversed.
                                                    (funcall key elt)))
                                      (funcall test old
                                               (funcall key elt))))
                                   (if (funcall test (funcall key elt)))
                                   (if-not (not (funcall test 
                                                         (funcall key elt)))))
                                 (setq count (1- count))
                                 new)
                                (t elt))))))
      (setq list (cdr list)))
    (do ()
        ((null list))
      (setq splice (cdr (rplacd splice (list (car list)))))
      (setq list (cdr list)))
    (cdr result)))

;;; Replace old with new in sequence moving from left to right by incrementer
;;; on each pass through the loop. Called by all three substitute functions.
(defun vector-substitute* (pred new sequence incrementer left right length
                                start end count key test test-not old)
  (let ((result (make-sequence-like sequence length))
        (index left))
    (do ()
        ((= index start))
      (aset result index (aref sequence index))
      (setq index (+ index incrementer)))
    (do ((elt))
        ((or (= index end) (= count 0)))
      (setq elt (aref sequence index))
      (aset result index 
            (cond ((case pred
                     (normal
                      (if test-not
                        (not (funcall test-not old (funcall key elt))) ;cfry mod
                        (funcall test old (funcall key elt)))) ;cfry mod
                     (if (funcall test (funcall key elt)))
                     (if-not (not (funcall test (funcall key elt)))))
                   (setq count (1- count))
                   new)
                  (t elt)))
      (setq index (+ index incrementer)))
    (do ()
        ((= index right))
      (aset result index (aref sequence index))
      (setq index (+ index incrementer)))
    result))

;;; Substitute:

(defun substitute (new old sequence &key from-end (test #'eql) test-not
                       (start 0) count
                       end (key #'identity))
  "Returns a sequence of the same kind as Sequence with the same elements
  except that all elements equal to Old are replaced with New.  See manual
  for details."
  (setq count (check-count count))
  (let ((length (if (sequencep sequence)
                  (length sequence)))
        ;(old (funcall key old)) ;incorrect spice code! key should only  be
        ;called on items of sequence
        )
    (setq end (check-sequence-bounds sequence start end 
                                     length))
    (seq-dispatch 
     sequence
     (if from-end
       (nreverse (list-substitute* 'normal new (reverse sequence) (- length end)
                                   (- length start) count key test test-not old))
       (list-substitute* 'normal new sequence start end count key test test-not
                         old))
     (if from-end
       (vector-substitute* 'normal new sequence -1 (1- length) -1 length 
                           (1- end) (1- start) count key test test-not old)
       (vector-substitute* 'normal new sequence 1 0 length length
                           start end count key test test-not old)))))


(defun substitute-if (new test sequence &key from-end (start 0)
                          (end (length sequence))
                          count (key #'identity))
  (substitute new test sequence
              :from-end from-end
              :test #'funcall
              :start start
              :end end
              :from-end from-end
              :count count
              :key key))

(defun substitute-if-not (new test sequence &key from-end (start 0)
                              (end (length sequence))
                              count (key #'identity))
  (substitute new test sequence
              :from-end from-end
              :test-not #'funcall
              :start start
              :end end
              :from-end from-end
              :count count
              :key key))

;;; NSubstitute:

(defun nsubstitute (new old sequence &key from-end (test #'eql) test-not 
                        end 
                        (count most-positive-fixnum) (key #'identity) (start 0))
  "Returns a sequence of the same kind as Sequence with the same elements
  except that all elements equal to Old are replaced with New.  The Sequence
  may be destroyed.  See manual for details." 
  (setq count (check-count count))
  (let ((incrementer 1)
        (length (if (sequencep sequence) (length sequence))))
    (setq end (check-sequence-bounds sequence start end 
                                     length))
    (seq-dispatch
     sequence
      (if from-end
        (nreverse (nlist-substitute*
                   new old (nreverse (the list sequence))
                   test test-not 
                   (- length end) 
                   (- length start)
                   count key))
        (nlist-substitute* new old sequence
                           test test-not start end count key))
      (progn 
        (if from-end
          (psetq start (1- end)
                 end (1- start)
                 incrementer -1))
        (nvector-substitute* new old sequence incrementer
                             test test-not start end count key)))))

(defun nlist-substitute* (new old sequence test test-not start end count key)
  (do ((list (nthcdr start sequence) (cdr list))
       (index start (1+ index)))
      ((or (and end (= index end)) (null list) (= count 0)) sequence)
    (when (if test-not
            (not (funcall test-not  old (funcall key (car list)))) ;cfry mod
            (funcall test  old (funcall key (car list)))) ;cfry mod
      (rplaca list new)
      (setq count (1- count)))))

(defun nvector-substitute* (new old sequence incrementer
                                test test-not start end count key)
  (do ((index start (+ index incrementer)))
      ((or (= index end) (= count 0)) sequence)
    (when (if test-not
            (not (funcall test-not  old (funcall key (aref sequence index))))
            ;above cfry mod. both order of argss to test-not and paren error
            ; between the funcall key and the funcall test-not
            (funcall test old (funcall key (aref sequence index)))) ;cfry mod
      (aset sequence index new)
      (setq count (1- count)))))

;;; NSubstitute-If:

(defun nsubstitute-if (new test sequence &key from-end (start 0)
                           end  
                           (count most-positive-fixnum) (key #'identity))
  (nsubstitute new test sequence
               :from-end from-end
               :test #'funcall
               :start start
               :end end
               :count count
               :key key))


;;; NSubstitute-If-Not:

(defun nsubstitute-if-not (new test sequence &key from-end (start 0)
                               end (count most-positive-fixnum) (key #'identity))
  (nsubstitute new test sequence
                 :from-end from-end
                 :test-not #'funcall
                 :start start
                 :end end
                 :count count
                 :key key))


;;; Position:

(defun list-position/find-1 (eltp item list from-end test test-not start end key &aux hard)
  ;;if eltp is true, return element, otherwise return position
  (setq key (adjust-key key))
  (multiple-value-setq (test test-not)
                       (adjust-test-args item test test-not))
  (setq end (check-sequence-bounds list start end most-positive-fixnum)
        hard (or test key test-not))
  (if from-end
    (if hard
      (list-position/find-from-end-complex eltp item list start end test test-not key)
      (list-position/find-from-end-simple eltp item list start end))
    (if hard
      (list-position/find-complex eltp item list start end test test-not key)
      (list-position/find-simple eltp item list start end))))

(defun position (item sequence &key from-end test test-not (start 0) end key)
  (if sequence
    (seq-dispatch 
     sequence
     (list-position/find-1 nil item sequence from-end test test-not start end key)
     (vector-position-1 item sequence from-end test test-not start end key))))

;Is it really necessary for these internal functions to take keyword args?
(defun list-position/find (eltp item list &key from-end test test-not (start 0) end key &aux hard)
  ;;if eltp is true, return element, otherwise return position
  (setq key (adjust-key key))
  (multiple-value-setq (test test-not)
                       (adjust-test-args item test test-not))
  (setq end (check-sequence-bounds list start end most-positive-fixnum)
        hard (or test key test-not))
  (if from-end
    (if hard
      (list-position/find-from-end-complex eltp item list start end test test-not key)
      (list-position/find-from-end-simple eltp item list start end))
    (if hard
      (list-position/find-complex eltp item list start end test test-not key)
      (list-position/find-simple eltp item list start end))))

;;; make these things positional



;;; add a simple-vector case

(defun vector-position-1 (item vector from-end test test-not start end key
                        &aux (inc (if from-end -1 1)) pos)
  (setq end (check-sequence-bounds vector start end))
  (setq key (adjust-key key))
  (multiple-value-setq (test test-not) (adjust-test-args item test test-not))
  (if from-end (psetq start (%i- end 1) end (%i- start 1)))
  (setq pos start)
  (if (simple-vector-p vector)
    (locally (declare (type simple-vector vector)
                      (optimize (speed 3) (safety 0)))
      (loop
        (if (eq pos end) (return))
        (if (matchp2 item (aref vector pos) test test-not key) (return pos))
        (setq pos (%i+ pos inc))))
    (loop
      (if (eq pos end) (return))
      (if (matchp2 item (aref vector pos) test test-not key) (return pos))
      (setq pos (%i+ pos inc)))))

(defun list-position/find-simple (eltp item list start end &aux (pos 0))
  (loop
    (if (or (eq pos start) (null list))
      (return)
      (setq list (cdr list) pos (%i+ pos 1))))
  (loop
    (if (and list (neq end pos))
      (if (eq item (car list))
        (return (if eltp item pos))
        (setq list (%cdr list) pos (%i+ pos 1)))
      (return))))

(defun list-position/find-complex (eltp item list start end test test-not key &aux (pos 0))
  (loop
    (if (or (eq pos start) (null list))
      (return)
      (setq list (cdr list) pos (%i+ pos 1))))
  (loop
    (if (and list (neq end pos))
      (progn
        (if (matchp2 item (car list) test test-not key)
          (return (if eltp (%car list) pos))
          (setq list (%cdr list) pos (%i+ pos 1))))
      (return))))

(defun list-position/find-from-end-simple (eltp item list start end &aux (pos 0) ret)
  (loop
    (if (or (eq pos start) (null list))
      (return)
      (setq list (cdr list) pos (%i+ pos 1))))
  (loop
    (if (and list (neq end pos))
      (progn
        (if (eq item (car list)) (setq ret pos))
        (setq list (%cdr list) pos (%i+ pos 1)))
      (return (if eltp (if ret item) ret)))))

(defun list-position/find-from-end-complex (eltp item list start end test test-not key 
                                            &aux (pos 0) ret val)
  (loop
    (if (or (eq pos start) (null list))
      (return)
      (setq list (cdr list) pos (%i+ pos 1))))
  (loop
    (if (and list (neq end pos))
      (progn
        (if (matchp2 item (setq val (car list)) test test-not key)
          (setq ret (if eltp val pos)))
        (setq list (%cdr list) pos (%i+ pos 1)))
      (return ret))))

(defun vector-position (item vector &key from-end test test-not (start 0) end key
                        &aux (inc (if from-end -1 1)) pos)
  (setq end (check-sequence-bounds vector start end))
  (setq key (adjust-key key))
  (multiple-value-setq (test test-not) (adjust-test-args item test test-not))
  (if from-end (psetq start (%i- end 1) end (%i- start 1)))
  (setq pos start)
  (loop
    (if (eq pos end) (return))
    (if (matchp2 item (aref vector pos) test test-not key) (return pos))
    (setq pos (%i+ pos inc))))

;;; Position-if:

(defun position-if (test sequence &key from-end (start 0) end key)
  (position test sequence
            :test #'funcall
            :from-end from-end
            :start start
            :end end
            :key key))


;;; Position-if-not:

(defun position-if-not (test sequence &key from-end (start 0) end key)
  (position test sequence
            :test-not #'funcall
            :from-end from-end
            :start start
            :end end
            :key key))

;;; Count:

(defun count (item sequence &key from-end test test-not (start 0) end key)
  (if sequence
    (seq-dispatch
     sequence
     (list-count item sequence  :from-end from-end :test test 
                 :test-not test-not :start start :end end :key key)
     (vector-count item sequence :from-end from-end :test test
                   :test-not test-not :start start :end end :key key))
    0))


#|
(defun list-count (item list &key from-end test test-not (start 0) end key
                        &aux (count 0) (pos 0))
  (declare (ignore from-end))
  (setq key (adjust-key key))
  (multiple-value-setq (test test-not)
                       (adjust-test-args item test test-not))
  (setq end (check-sequence-bounds list start end most-positive-fixnum))
  (loop
    (if (and list (neq end pos))
      (progn
        (if (and (%i<= start pos)
                 (matchp2 item (car list) test test-not key))
          (setq count (%i+ count 1)))
        (setq list (%cdr list) pos (%i+ pos 1)))
      (return count))))
|#

(defun list-count (item list &key from-end test test-not (start 0) end key
                        &aux (count 0) (pos 0))
  (setq key (adjust-key key))
  (multiple-value-setq (test test-not)
    (adjust-test-args item test test-not))
  (setq end (check-sequence-bounds list start end (if (not from-end) most-positive-fixnum (length list))))
  (if (not from-end)
    (loop
      (if (and list (neq end pos))
        (progn
          (if (and (%i<= start pos)
                   (matchp2 item (car list) test test-not key))
            (setq count (%i+ count 1)))
          (setq list (%cdr list) pos (%i+ pos 1)))
        (return count)))      
      (dotimes (i (- end start) count)
        (if (matchp2 item (nth (- end i 1) list) test test-not key)
          (setq count (%i+ count 1))))))

(defun vector-count (item vector &key from-end test test-not (start 0) end key
                          &aux (count 0) (pos start))
  (setq key (adjust-key key))
  (multiple-value-setq (test test-not)
    (adjust-test-args item test test-not))
  (setq end (check-sequence-bounds vector start end))
  (if (not from-end)
    (loop
      (if (eq end pos) (return count))
      (if (matchp2 item (aref vector pos) test test-not key)
        (setq count (%i+ count 1)))
      (setq pos (%i+ pos 1)))
    (let ((pos end))
      (loop
        (setq pos (%i- pos 1))
        (if (%i< pos start) (return count))
        (if (matchp2 item (aref vector pos) test test-not key)
          (setq count (%i+ count 1)))
        ))))

;;; Count-if:

(defun count-if (test sequence &key from-end (start 0) end key)
  (count test sequence
         :test #'funcall
         :from-end from-end
         :start start
         :end end
         :key key))

;;; Count-if-not:

(defun count-if-not (test sequence &key from-end (start 0) end key)
  (count test sequence
         :test-not #'funcall
         :from-end from-end
         :start start
         :end end
         :key key))


;;; Find:

(defun find (item sequence &key from-end test test-not (start 0) end key &aux temp)
  (if sequence
    (seq-dispatch
     sequence
     (list-position/find-1 t item sequence from-end test test-not start end key)
     (if (setq temp (vector-position-1 item sequence from-end test test-not start end key))
       (aref sequence temp)))))

(defun find-if (test sequence &key from-end (start 0) end key)
  (find test sequence
        :test #'funcall
        :from-end from-end
        :start start
        :end end
        :key key))

(defun find-if-not (test sequence &key from-end (start 0) end key)
  (find test sequence
        :test-not #'funcall
        :from-end from-end
        :start start
        :end end
        :key key))


;;; Mismatch:

(defun mismatch (seq1 seq2 &key (from-end nil)
                                  (test #'eql)
                                  (test-not nil)
                                  (key #'identity)
                                  (start1 0)
                                  (start2 0)
                                  (end1 nil)
                                  (end2 nil)
                             &aux (length1 (length seq1))
                                  (length2 (length seq2))
                                  (vectorp1 (vectorp seq1))
                                  (vectorp2 (vectorp seq2)))
  ;seq type-checking is done by length
  ;start/end type-cheking is done by <= (below)
  ;test/key type-checking is done by funcall
  ;no check for both test and test-not
  (or end1 (setq end1 length1))
  (or end2 (setq end2 length2))
  (unless (and (<= start1 end1 length1)
               (<= start2 end2 length2))
    (error "Sequence arg out of range"))
  (unless vectorp1
    (setq seq1 (nthcdr start1 seq1))
    (when from-end (setq seq1 (reverse seq1))))
  (unless vectorp2
    (setq seq2 (nthcdr start2 seq2))
    (when from-end (setq seq2 (reverse seq2))))
  (when test-not (setq test test-not))
  (if from-end
      ;from-end
      (let* ((count1 end1)
             (count2 end2)
             (elt1)
             (elt2))
        (loop
          (if (or (eq count1 start1)
                  (eq count2 start2))
              (return-from mismatch
                           (if (and (eq count1 start1)
                                    (eq count2 start2))
                               nil
                               count1)))
          
          (setq count1 (%i- count1 1)
                count2 (%i- count2 1))

          (setq elt1 (funcall key (if vectorp1
                                      (aref seq1 count1)
                                      (prog1
                                        (%car seq1)
                                        (setq seq1 (%cdr seq1)))))
                elt2 (funcall key (if vectorp2
                                      (aref seq2 count2)
                                      (prog1
                                        (%car seq2)
                                        (setq seq2 (%cdr seq2))))))

          (when (if test-not
                    (funcall test elt1 elt2)
                    (not (funcall test elt1 elt2)))
            (return-from mismatch (%i+ count1 1)))))
      ;from-start
      (let* ((count1 start1)
             (count2 start2)
             (elt1)
             (elt2))
        (loop
          (if (or (eq count1 end1)
                  (eq count2 end2))
              (return-from mismatch
                           (if (and (eq count1 end1)
                                    (eq count2 end2))
                               nil
                               count1)))
          (setq elt1 (funcall key (if vectorp1
                                      (aref seq1 count1)
                                      (prog1
                                        (%car seq1)
                                        (setq seq1 (%cdr seq1)))))
                elt2 (funcall key (if vectorp2
                                      (aref seq2 count2)
                                      (prog1
                                        (%car seq2)
                                        (setq seq2 (%cdr seq2))))))
          
          (when (if test-not
                    (funcall test elt1 elt2)
                    (not (funcall test elt1 elt2)))
            (return-from mismatch count1)) 
          (setq count1 (%i+ count1 1)
                count2 (%i+ count2 1))
          
          ))))


;;; Search comparison functions:

(eval-when (:execute :compile-toplevel)
  
  ;;; Compare two elements
  
  (defmacro xcompare-elements (elt1 elt2)
    `(if (not key)
       (if test-not
         (not (funcall test-not ,elt1 ,elt2))
         (funcall test ,elt1 ,elt2))
       (let* ((e1 (funcall key ,elt1))
              (e2 (funcall key ,elt2)))
         (if test-not
           (not (funcall test-not  e1 e2))
           (funcall test e1 e2)))))  
  
  (defmacro vector-vector-search (sub main)
    `(let ((first-elt (aref ,sub start1))
           (last-one nil))
       (do* ((index2 start2 (1+ index2))
             (terminus (%i- end2 (%i- end1 start1))))
            ((> index2 terminus))
         (declare (fixnum index2 terminus))
         (if (xcompare-elements first-elt (aref ,main index2))
           (if (do* ((subi1 (1+ start1)(1+ subi1))
                     (subi2 (1+ index2) (1+ subi2)))
                    ((eq subi1 end1) t)
                 (declare (fixnum subi1 subi2))
                 (if (not (xcompare-elements (aref ,sub subi1) (aref ,main subi2)))
                   (return nil)))
             (if from-end
               (setq last-one index2)
               (return-from search index2)))))
       last-one))

  (defmacro list-list-search (sub main)
    `(let* ((sub-sub (nthcdr start1 ,sub))
            (first-elt (%car sub-sub))
            (last-one nil))
       (do* ((index2 start2 (1+ index2))
             (sub-main (nthcdr start2 ,main) (%cdr sub-main))
             (terminus (%i- end2 (%i- end1 start1))))
            ((> index2 terminus))
         (declare (fixnum index2 terminus))
         (if (xcompare-elements first-elt (car sub-main))
           (if (do* ((ss (%cdr sub-sub) (%cdr ss))
		     (pos (1+ start1) (1+ pos))
                     (sm (%cdr sub-main) (cdr sm)))
                    ((or (null ss) (= pos end1))  t)
		 (declare (fixnum pos))
                 (if (not (xcompare-elements (%car ss) (%car sm)))
                     (return nil)))
              (if from-end
               (setq last-one index2)
               (return-from search index2)))))
       last-one))
  
 (defmacro list-vector-search (sub main)
    `(let* ((sub-sub (nthcdr start1 ,sub))
              (first-elt (%car sub-sub))
              (last-one nil))
         (do* ((index2 start2 (1+ index2))
               (terminus (%i- end2 (%i- end1 start1))))
              ((> index2 terminus))
           (declare (fixnum index2 terminus))
           (if (xcompare-elements first-elt (aref ,main index2))
             (if (do* ((ss (%cdr sub-sub) (%cdr ss))
		       (pos (1+ start1) (1+ pos))
                       (subi2 (1+ index2) (1+ subi2)))
                      ((or (null ss) (= pos end1))  t)
                   (declare (fixnum subi2 pos))
                   (if (not (xcompare-elements (%car ss) (aref ,main subi2)))
                     (return nil)))
               (if from-end
                 (setq last-one index2)
                 (return-from search index2)))))
         last-one))

  (defmacro vector-list-search (sub main)
    `(let ((first-elt (aref ,sub start1))
           (last-one nil))
       (do* ((index2 start2 (1+ index2))
             (sub-main (nthcdr start2 ,main) (%cdr sub-main))
             (terminus (%i- end2 (%i- end1 start1))))
            ((> index2 terminus))
         (declare (fixnum index2 terminus))
         (if (xcompare-elements first-elt (car sub-main))
           (if (do* ((subi1 (1+ start1)(1+ subi1))
                     (sm (%cdr sub-main) (cdr sm)))
                    ((eq subi1 end1) t)
                 (declare (fixnum subi1))
                 (if (not (xcompare-elements (aref ,sub subi1) (car sm)))
                   (return nil)))
             (if from-end
               (setq last-one index2)
               (return-from search index2)))))
       last-one))
                 
    
  )



(defun search (sequence1 sequence2 &key from-end (test #'eql) test-not 
                          (start1 0) end1 (start2 0) end2 (key #'identity))
  (setq end1 (check-sequence-bounds sequence1 start1 end1 nil))
  (setq end2 (check-sequence-bounds sequence2 start2 end2 nil))
  (setq key (adjust-key key))
  (locally (declare (fixnum start1 end1 start2 end2))
    (if (eq 0 (%i- end1 start1))(if from-end end2 start2)
    (seq-dispatch sequence1
                  (seq-dispatch sequence2
                                (list-list-search sequence1 sequence2)
                                (list-vector-search sequence1 sequence2))
                  (seq-dispatch sequence2
                                (vector-list-search sequence1 sequence2)
                                (vector-vector-search sequence1 sequence2))))))

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
