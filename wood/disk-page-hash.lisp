;;;-*- Mode: Lisp; Package: WOOD -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; disk-page-hash.lisp
;; A simple and very fast hashing mechanism for disk pages
;;
;; Copyright © 1996-1999 Digitool, Inc.
;; Copyright © 1992-1995 Apple Computer, Inc.
;; All rights reserved.
;; Permission is given to use, copy, and modify this software provided
;; that Digitool is given credit in all derivative works.
;; This software is provided "as is". Digitool makes no warranty or
;; representation, either express or implied, with respect to this software,
;; its quality, accuracy, merchantability, or fitness for a particular
;; purpose.
;;
;; Entry points are: make-disk-page-hash, disk-page-gethash,
;; (setf disk-page-gethash), disk-page-remhash, disk-page-maphash.
;; They are similar to the Common Lisp hash table functions,
;; except the table must have integer keys (fixnums if
;; :wood-fixnum-addresses is on *features* when this file is compiled).
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; 01/10/00 akh moved (pushnew :wood-fixnum-addresses *features*) to block-io-mcl
;; -------- 0.96
;; -------- 0.95
;; -------- 0.94
;; 03/21/96 bill (make-array ... :INITIAL-ELEMENT NIL) in make-disk-page-hash-table-vector
;; -------- 0.93
;; 05/31/95 bill New file
;;

#|
Algorithm notes.

This uses the same basic Knuth algorithm as MCL's hash table implementation.
Hashing is into a vector of size 2**n. Each entry has either a key, a
deleted marker, or an empty marker. The first hash probe is a mask with
the key. If that hits the looked-for key, we're done. If it hits an empty
marker, we're done and the desired key is not in the table. If it hits
a deleted marker or a different key, we pick a secondary key from the
*secondary-keys* table. Then add the secondary key, modding with the table
length until you find the key you're looking for or an empty marker.
Since all the secondary keys are odd primes (relatively prime to the table
size), this is guaranteed to hit every element of the vector.

A sequence of insertions and deletions can leave a table that has no empty
markers. This makes gethash for a key that isn't in the table take a long time.
Hence, when this condition is detected, the table is rehashed to get rid of
the deleted markers. The rehashing algorithm is the library card catalog
algorithm. You keep a counter of which card drawer you last started with.
pull the drawer out of that slot and increment the counter. Put the drawer
in your hand where it goes. If this causes you to pull out another drawer,
then put that one where it goes. Eventually, you'll put a drawer in an empty
slot and you can go back to the counter's slot. Continue until the counter
is greater than the number of slots.

|#

(in-package :wood)

#| ;; moved to block-io-mcl
; Assume fixnum addresses.
; Comment out this form to compile Wood for files larger than 256 megs.
(eval-when (:compile-toplevel :execute :load-toplevel)
  (pushnew :wood-fixnum-addresses *features*))
|#

(defstruct (disk-page-hash (:constructor cons-disk-page-hash ())
                              (:print-function print-disk-page-hash))
  vector                 ; Where the data is stored.
  vector-length          ; (length vector) - a power of 2
  size                   ; number of entries that will fit
  count                  ; number of entries currently in stored
  mask                   ; (1- (ash vector-length -1))
  shift                  ; (integer-length mask)
  secondary-mask         ; mask for length of *secondary-keys* shifted up by shift
  (cache-address nil)    ; adderss of last reference
  (cache-value nil)      ; value of last reference
  (cache-index nil)      ; vector index of last reference
  page-size              ; The page size of the disk-cache using this hash table
  page-size-shift        ; (integer-length (1- page-size))
  bit-vector)            ; for rehashing. Actually an (unsigned-byte 8) vector (faster).

(defun print-disk-page-hash (hash stream level)
  (declare (ignore level))
  (print-unreadable-object (hash stream :identity t :type t)
    (format stream "~d/~d" 
            (disk-page-hash-count hash)
            (disk-page-hash-size hash))))

(defconstant *secondary-keys* 
  (coerce (mapcar #'(lambda (x) (+ x x)) '(3 5 7 11 13 17 19 23)) 'vector))

(defconstant *secondary-keys-length* (length *secondary-keys*))
(defconstant *secondary-keys-mask* (1- *secondary-keys-length*))

(assert (eql *secondary-keys-length*
             (expt 2 (integer-length (1- *secondary-keys-length*)))))

(defconstant *no-key-marker* nil)
(defconstant *deleted-key-marker* :deleted)

(defparameter *minimum-size*
  (expt 2 (1- (integer-length (apply 'max (coerce *secondary-keys* 'list))))))

; Not just the default; it's not a parameter.
(defparameter *default-rehash-threshold* 0.85)

(defun make-disk-page-hash-table-vector (count &optional (rehash-threshold *default-rehash-threshold*))
  (let* ((nominal-count (max *minimum-size*
                             (1+ count)
                             (ceiling count rehash-threshold)))
         (shift (integer-length (1- nominal-count)))
         (real-count (expt 2 shift)))
    (values
     (make-array (* 2 real-count) :initial-element nil)
     real-count
     shift)))

(defun make-disk-page-hash (&key (size 1) (page-size 1))
  (init-disk-page-hash (cons-disk-page-hash) size page-size))

(defun init-disk-page-hash (hash count page-size)
  (multiple-value-bind (vector real-count shift) (make-disk-page-hash-table-vector count)
    (let ((size (truncate (* real-count *default-rehash-threshold*))))
      (when (eql size real-count)
        (decf size))
      (setf (disk-page-hash-vector hash) vector
            (disk-page-hash-vector-length hash) (length vector)
            (disk-page-hash-size hash) size
            (disk-page-hash-count hash) 0
            (disk-page-hash-mask hash) (1- real-count)
            (disk-page-hash-shift hash) shift
            (disk-page-hash-secondary-mask hash) (ash *secondary-keys-mask* shift)
            (disk-page-hash-cache-address hash) nil
            (disk-page-hash-cache-value hash) nil
            (disk-page-hash-cache-index hash) nil
            (disk-page-hash-page-size hash) page-size
            (disk-page-hash-page-size-shift hash) (integer-length (1- page-size))
            (disk-page-hash-bit-vector hash) nil)))
  hash)

(declaim (inline address-iasr))

(defun address-iasr (count address &optional known-fixnum-p)
  (declare (fixnum count))
  #+wood-fixnum-addresses (declare (fixnum address) (ignore known-fixnum-p))
  (if #+wood-fixnum-addresses t
      #-wood-fixnum-addresses known-fixnum-p
      (ccl::%iasr count address)
      (ash address (the fixnum (- 0 count)))))

; I wanted this to be an inlined function, but MCL's compiler wouldn't inline the knowledge
; that address was a fixnum.
(defmacro %disk-page-gethash-macro (address hash &optional fixnum-address?)
  `(locally (declare (optimize (speed 3) (safety 0)))
     (if (eql ,address (disk-page-hash-cache-address ,hash))
       (disk-page-hash-cache-value ,hash)
       (let* ((page-number (address-iasr (disk-page-hash-page-size-shift ,hash) ,address ,fixnum-address?))
              (hash-code (logand page-number (the fixnum (disk-page-hash-mask ,hash))))
              (index (* 2 hash-code))
              (vector (disk-page-hash-vector ,hash))
              (probe (svref vector index)))
         (declare (fixnum hash-code index probe ,@(and fixnum-address? '(page-number)))
                  (type simple-vector vector))
         (cond ((eql probe ,address) (aref vector (the fixnum (1+ index))))
               ((eql probe *no-key-marker*) nil)
               (t (let ((secondary-key (aref *secondary-keys*
                                             (ccl::%iasr (disk-page-hash-shift ,hash)
                                                         (logand page-number (the fixnum (disk-page-hash-secondary-mask ,hash))))))
                        (vector-length (disk-page-hash-vector-length ,hash))
                        (original-index index))
                    (declare (fixnum secondary-key vector-length original-index))
                    (loop
                      (incf index secondary-key)
                      (when (>= index vector-length)
                        (decf index vector-length))
                      (when (eql index original-index)
                        (return nil))
                      (let ((probe (aref vector index)))
                        (when (eql probe ,address)
                          (let ((value (aref vector (the fixnum (1+ index)))))
                            (setf (disk-page-hash-cache-address hash) address
                                  (disk-page-hash-cache-value hash) value
                                  (disk-page-hash-cache-index hash) index)
                            (return value)))
                        (when (eql probe *no-key-marker*)
                          (return nil)))))))))))

; This is one of WOOD's most-called functions.
; It's important that it be as fast as possible.
(defun disk-page-gethash (address hash)
  (declare (optimize (speed 3) (safety 0)))
  ; Assume if it's non-null that it's of the right type since
  ; type check takes too long (unless unlined LAP?).
  ; Need to check for null since disk cache inspectors can remain open
  ; after their disk cache has been closed.
  (unless hash
    (error "Null hash table."))
  (if #+wood-fixnum-addresses t
      #-wood-fixnum-addresses (fixnump address)
    (locally (declare (fixnum address))
      (%disk-page-gethash-macro address hash t))
    (%disk-page-gethash-macro address hash)))

(defun (setf disk-page-gethash) (value address hash &optional deleting?)
  #+wood-fixnum-addresses (declare (fixnum address))
  (unless (typep hash 'disk-page-hash)
    (setq hash (require-type hash 'disk-page-hash)))
  (let ((vector (disk-page-hash-vector hash)))
    (if (eql address (disk-page-hash-cache-address hash))
      (let ((index (disk-page-hash-cache-index hash)))
        (if deleting?
          (let ((vector (disk-page-hash-vector hash)))
            (setf (disk-page-hash-cache-address hash) nil
                  (disk-page-hash-cache-value hash) nil
                  (disk-page-hash-cache-index hash) nil
                  (aref vector index) *deleted-key-marker*
                  (aref vector (the fixnum (1+ index))) nil)
            (decf (the fixnum (disk-page-hash-count hash)))
            t)
          (setf (disk-page-hash-cache-value hash) value
                (aref vector (1+ index)) value)))
      (let* ((page-size-shift (disk-page-hash-page-size-shift hash))
             (page-number (address-iasr page-size-shift address))
             (hash-code (logand page-number (the fixnum (disk-page-hash-mask hash))))
             (index (* 2 hash-code))
             (probe (svref vector index))
             (new-key? (not deleting?)))
        (declare (fixnum page-size-shift hash-code index))
        (or (when (eql probe address)
              (setq new-key? nil)
              t)
            (eql probe *no-key-marker*)
            (let ((secondary-key (aref *secondary-keys*
                                       (ccl::%iasr (disk-page-hash-shift hash)
                                                   (logand page-number (the fixnum (disk-page-hash-secondary-mask hash))))))
                  (vector-length (length vector))
                  (first-deletion nil)
                  (original-index index))
              (declare (fixnum secondary-key vector-length original-index))
              (loop
                (incf index secondary-key)
                (when (>= index vector-length)
                  (decf index vector-length))
                (let ((probe (aref vector index)))
                  (when (eql probe address)
                    (setq new-key? nil)
                    (return t))
                  (when (and (not deleting?) 
                             (eql index original-index)
                             (< (disk-page-hash-count hash) (disk-page-hash-size hash)))
                    (incf (disk-page-hash-count hash))
                    (return-from disk-page-gethash
                      (disk-page-rehash hash address value)))
                  (when (eql probe *no-key-marker*)
                    (when first-deletion
                      (setq index first-deletion))
                    (return t))
                  (when (eql probe *deleted-key-marker*)
                    (unless first-deletion
                      (setq first-deletion index)))))))
        (when new-key?
          (let ((count (disk-page-hash-count hash)))
            (declare (fixnum count))
            (if (>= count (disk-page-hash-size hash))
              (return-from disk-page-gethash (grow-disk-page-hash hash address value))
              (setf (disk-page-hash-count hash) (the fixnum (1+ count))))))
        (if deleting?
          (when (integerp (aref vector index))
            (decf (disk-page-hash-count hash))
            (setf (disk-page-hash-cache-address hash) nil
                  (disk-page-hash-cache-value hash) nil
                  (disk-page-hash-cache-index hash) nil
                  (aref vector index) *deleted-key-marker*
                  (aref vector (the fixnum (1+ index))) nil)
            t)
          (setf (disk-page-hash-cache-address hash) address
                (disk-page-hash-cache-value hash) value
                (disk-page-hash-cache-index hash) index
                (aref vector index) address
                (aref vector (the fixnum (1+ index))) value))))))

(defun disk-page-remhash (address hash)
  (setf (disk-page-gethash address hash t) nil))

(defun disk-page-maphash (function hash)
  (disk-page-map-vector function (disk-page-hash-vector hash)))

(defun disk-page-map-vector (function vector)
  (let ((index 0)
        (length (length vector)))
    (declare (fixnum index length))
    (loop
      (let ((key (ccl::%svref vector index))
            (value (ccl::%svref vector (incf index))))
        (incf index)
        (unless (or (eql key *no-key-marker*) (eql key *deleted-key-marker*))
          (funcall function key value))
        (when (>= index length)
          (return))))))

(defun grow-disk-page-hash (hash address value)
  (let* ((vector (disk-page-hash-vector hash))
         (mapper #'(lambda (key value)
                     (setf (disk-page-gethash key hash) value))))
    (declare (dynamic-extent mapper))
    (init-disk-page-hash hash
                         (* 2 (disk-page-hash-size hash))
                         (disk-page-hash-page-size hash))
    (disk-page-map-vector mapper vector)
    (setf (disk-page-gethash address hash) value)))

; Rehash to get rid of deleted markers. Insert address/value pair
; This is called when the vector has no empty slots, all are filled
; with data or delted key markers. In that state a failing gethash
; takes a long time, so we get rid of the delted markers to speed it up.
(defun disk-page-rehash (hash address value)
  (locally
    (declare (optimize (speed 3) (safety 0)))
    (setf (disk-page-hash-cache-address hash) *no-key-marker*
          (disk-page-hash-cache-value hash) nil
          (disk-page-hash-cache-index hash) nil)
    (let* ((vector (disk-page-hash-vector hash))
           (bits (disk-page-hash-bit-vector hash))
           (vector-length (disk-page-hash-vector-length hash))
           (page-size-shift (disk-page-hash-page-size-shift hash))
           (mask (disk-page-hash-mask hash))
           (shift (disk-page-hash-shift hash))
           (secondary-mask (disk-page-hash-secondary-mask hash))
           (loop-index -2)
           (loop-index+1 -1)
           (original-value value))
      (declare (type simple-vector vector)
               (fixnum vector-length page-size-shift mask shift secondary-mask loop-index loop-index+1))
      #-wood-fixnum-addresses (declare (fixnum minus-page-size-shift))
      (flet ((bit-ref (bits index)
               (declare (type (simple-array (unsigned-byte 8) (*)) bits)
                        (optimize (speed 3)(safety 0)))
               (aref bits index))
             ((setf bit-ref) (v bits index)
               (declare (type (simple-array (unsigned-byte 8) (*)) bits)
                        (optimize (speed 3)(safety 0)))
               (setf (aref bits index) v)))
        (declare (inline bit-ref (setf bit-ref)))
        (if (or (null bits) (< (length bits) vector-length))
          (setq bits
                ; not really a bit vector because that's too slow
                (setf (disk-page-hash-bit-vector hash)
                      (make-array vector-length :element-type '(unsigned-byte 8) :initial-element 0)))
          (dotimes (i vector-length) (setf (bit-ref bits i) 0)))
        (loop
          (unless address
            (loop
              (incf loop-index 2)
              (incf loop-index+1 2)
              ;(print-db loop-index)
              (when (>= loop-index vector-length)
                (return-from disk-page-rehash original-value))
              (when (eql 0 (bit-ref bits loop-index))
                (setq address (svref vector loop-index))
                ;(print-db address)
                (cond ((eql address *no-key-marker*))
                      ((eql address *deleted-key-marker*)
                       (setf (svref vector loop-index) *no-key-marker*
                             (svref vector loop-index+1) nil))
                      (t (setq value (svref vector loop-index+1))
                         (setf (svref vector loop-index) *no-key-marker*
                               (svref vector loop-index+1) nil)
                         (return))))))
          (let* ((integer-address address)
                 (page-number (address-iasr page-size-shift integer-address))
                 (hash-code (logand page-number mask))
                 (index (* 2 hash-code)))
            #+wood-fixnum-addresses (declare (fixnum integer-address page-number))
            (declare (fixnum hash-code index))
            (flet ((insert-p (probe)
                     (let ((index+1 (1+ index)))
                       (declare (fixnum index+1))
                       (cond ((or (eql probe *no-key-marker*) (eql probe *deleted-key-marker*))
                              (setf (svref vector index) address
                                    (svref vector index+1) value)
                              (setq address nil value nil)
                              (setf (bit-ref bits index) 1))
                             ((eql 0 (bit-ref bits index))
                              (setf (svref vector index) address
                                    address probe)
                              (rotatef value (svref vector index+1))
                              (setf (bit-ref bits index) 1))
                             (t nil)))))
              (declare (dynamic-extent insert-p))
              (unless (insert-p (svref vector index))
                (let ((secondary-key (aref *secondary-keys*
                                           (ccl::%iasr shift (logand page-number secondary-mask)))))
                  (declare (fixnum secondary-key))
                  (loop
                    (incf index secondary-key)
                    (when (>= index vector-length)
                      (decf index vector-length))
                    ;(print-db index)
                    (when (insert-p (svref vector index)) (return))))))))))))

; For testing
#|
(advise disk-page-rehash
        (destructuring-bind (hash address value) arglist
          (prog1
            (:do-it)
            (let ((was (disk-page-gethash address hash)))
              (unless (eq value was)
                (error "address: ~s, sb: ~s, was: ~s" address value was)))
            (let ((mapper #'(lambda (a v)
                              (let ((was (disk-page-gethash a hash)))
                                (unless (eq was v)
                                  (error "Address: ~s~%, sb: ~s~%, was: ~s"
                                         a v was))
                                (unless (eql a (disk-page-address v))
                                  (error "Address: ~s for ~s" a v))))))
              (declare (dynamic-extent mapper))
              (disk-page-maphash mapper hash))))
        :when :around
        :name :debug)

(advise (setf disk-page-gethash)
        (destructuring-bind (value address hash &optional delete?) arglist
          (unless (or delete? (eql address (disk-page-address value)))
            (error "Address: ~s, value: ~s" address value))
          (:do-it)
          (unless (eq (disk-page-gethash address hash) value)
            (error "Bad value")))
        :when :around
        :name :debug)
|#
;;;    1   6/02/95  bill         1.11d040
;;;    2   8/01/95  bill         1.11d065
