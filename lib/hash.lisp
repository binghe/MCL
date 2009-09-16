;;-*- Mode: Lisp; Package: CCL -*-

;;  This is just the stuff (make-load-form, print-object) that can't be fasloaded earlier.

;;	Change History (most recent first):
;;  $Log: hash.lisp,v $
;;  Revision 1.4  2003/12/08 08:09:48  gtbyers
;;  No more #-ansi-make-load-form.
;;
;;  6 7/30/96  akh  finish-hash-table-iterator - dont mess with lock if never started
;;                  paranoia in start-hash-table-iterator
;;  2 10/6/95  gb   
;;  6 2/17/95  akh  probably no change
;;  5 2/9/95   slh  fix maphash crash for wta
;;  4 1/31/95  akh  put back some stuff missed while merging
;;  3 1/30/95  akh  fix for processes
;;  (do not edit before this line!!)

; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995 Digitool, Inc. The 'tool rules!

;;;;;;;;;;;;;
;;
;; hash.lisp
;; New hash table implementation

;;;;;;;;;;;;;
;;
;; Things I didn't do
;;
;; Save the 32-bit hash code along with the key so that growing the table can
;; avoid calling the hashing function (at least until a GC happens during growing).
;;
;; Maybe use Knuth's better method for hashing:
;; find two primes N-2, N.  N is the table size.
;; First probe is at primary = (mod (funcall (nhash.keytransF h) key) N)
;; Secondary probes are spaced by (mod (funcall (nhash.keytransF h) key) N-2)
;; This does a bit better scrambling of the secondary probes, but costs another divide.
;;
;; Rethink how finalization is reported to the user.  Maybe have a finalization function which
;; is called with the hash table and the deleted key & value.


;;;;;;;;;;;;;
;;
;; Modification History
;;
;; 12/06/95 bill  hash-table-weak-p & (setf hash-table-weak-p)
;; 10/26/95 slh   %gvector -> %istruct
;;  2/09/95 slh   start-hash-table-iterator: clear hti.hash-table if bogus
;;                finish-hash-table-iterator: check for null hti.hash-table
;; 01/30/95 alice fix for processes
;; 10/05/93 bill %%equalhash-aux & %%equalphash-aux say (car atemp0) instead of -@atemp0
;; 09/15/93 bill Bob Cassell's patch to the make-load-form method.
;;               Makes it generate simple enough forms that the
;;               new fasl-scan-user-form will not compile them.
;; ------------- 3.0d13
;; 07/29/93 bill gethash neglected to branch after calling asseql.
;;               Worse, calling add-locked-additions clobbers the temp registers, unbeknownst
;;               to the earlier version of gethash.
;;               fasl-lock-hash-table, fasl-unlock-hash-tables
;; 06/05/93 bill %rehash now puts $nhash.lock-while-rehashing in nhash.lock
;;               as it was designed to do. %maybe-rehash checks for the
;;               proper value, too.
;; ------------- 3.0d11
;; 11/20/92 gb   keep cache value/index in hash vector so gc can zap them.
;; 12/11/92 bill Moon's fix to compute-hash-code, pop saved update-maybe-rehash
;;               before restoring registers and jumping to %hash-linear-probe.
;;               This only happens when the table is locked and needs rehashing
;;               (e.g. GETHASH is called during MAPHASH when the table needs
;;               to be rehashed).
;; 08/11/92 bill EQUALP hash tables no longer error with CLOS instances as keys.
;; 07/30/92 bill gethash now returns the proper value when it finds the
;;               entry in the locked-additions alist (during mapping).
;; 06/22/92 bill in puthash: Don't need to check for both weak & finalizeable.
;;               (besides, the test for weak was wrong).
;; 06/19/92 bill clrhash now calls $sp-eventch occasionally so that calling
;;               it on a big hash table in a VM environment will be interruptable.
;;               grow-hash-table no longer throws away nhash.vector.weak-deletions-count.
;;               Decrementers of nhash.vector.deleted-count also update
;;               nhash.vector.weak-deletions-count, when appropriate.
;; 05/23/92 bill do-rehash now cerror's on duplicate keys.
;;               It also handles nhash.vector.deleted-count correctly
;;               if you throw out of it.
;; 05/22/92 bill clrhash now clears the rehashing bits.
;; 05/21/92 bill do-rehash got in an infinite loop on Bob Cassels.
;;               Was a bug in neglecting to set the $nhash_key_moved_bit
;;               when we get a key whose address was used to compute
;;               the hash code and we're not getting GC assistance.
;;               Also, %hash-probe now passes its maybe-update-rehash arg
;;               to %general-hash-probe. This prevents gethash from
;;               changing the when-does-this-table-need-rehashing information.
;;               Finally, get-fwdnum had a bug in code that is never used.
;; ------------- 2.0
;; 12/31/91 bill report-bad-arg is not funcallable.
;; 10/11/91 bill Speed up make-hash-table by by speeding up %cons-nhash-vector.
;;               This makes growing a hash table much faster, as well.
;; 10/07/91 gb   Fix bug in %hash-probe for EQL hash tables.
;; 10/03/91 bill Compute secondary offset from original hash code, not normalized one.
;; 10/02/91 bill speed up gethash & %hash-probe by a few microseconds each.
;;               make EQUALP hash tables work for vectors with fill pointers.
;; 09/24/91 bill Doing many REMHASH'es no longer causes a hash table to become
;;               extremely slow.
;; 09/18/91 bill %%equalhash works for bit vectors.
;;               eql hash tables work for all numbers, not just fixnums
;; 09/17/91 bill gethash returns two values
;; 09/04/91 gb   (atemp0 nhash.vector) -> (svref atemp0 nhash.vector) in 
;;               %does-not-need-rehashing.
;; 08/29/91 gb   use (a5 $relocnum) - a fixnum - vice dynamic gc-count.
;; 08/24/91 gb   use new trap syntax.
;; 08/21/91 bill missing (the fixnum ...) in sxhash
;; 08/19/91 bill make cacheing work in do-hash-table-iteration
;; 08/16/91 bill hash tables can become completely filled with deleted entries:
;;               add terminating test to %xx-hash-probe.
;; 08/10/91 gb   clear caches when rehashing.  Interact with gc.
;; 08/04/91 gb   only cache keys that are in the table in gethash.
;; 08/02/91 bill finish %%equalphash.  sxhash hashes on %type-of as a last resort.
;;               with-hash-table-iterator sets the cache.
;; 08/01/91 bill Moon's bug: da->acc in compute-hash-code (only affects user hashing functions)
;; 07/31/91 bill nhash.vector.weak-deletions-count, nhash.vector.hash.
;;               Sample and map through nhash.locked-additions in with-hash-table-iterator.
;;               User supplied hash-function & test to make-hash-table must be symbols
;;               (otherwise fasdumping a hash table becomes problematical).
;;               make-load-form
;; 07/12/91 bill Chisel a toothpick out of solid granite
;; 07/01/91 gb   Initial data structures and hashing functions

;;;;;;;;;;;;;
;;
;; Documentation
;;
;; MAKE-HASH-TABLE is extended to accept a :HASH-FUNCTION keyword arg which
;; defaults for the 4 Common Lisp defined :TEST's.  Also, any fbound symbol can
;; be used for the :TEST argument.  The HASH-FUNCTION is a function of one
;; argument, the key, which returns one, two, or three values:
;;
;; 1) HASH-CODE
;; 2) ADDRESSP
;; 3) EPHEMERAL-P
;;
;; The HASH-CODE can be any object.  If it is a relocateable object (not a
;; fixnum, short float, or immediate) then ADDRESSP will default to :KEY
;; and it is an error if NIL is returned for ADDRESSP.
;;
;; If ADDRESSP is NIL, the hashing code assumes that no addresses were used
;; in computing the HASH-CODE.  If ADDRESSP is :KEY (which is the default
;; if the hash function returns only one value and it is relocateable) then
;; the hashing code assumes that only the KEY's address was used to compute
;; the HASH-CODE.  Otherwise, it is assumed that the address of a
;; component of the key was used to compute the HASH-CODE.
;;
;; If EPHEMERAL-P is returned and is NIL, the hashing code assumes that none
;; of the objects whose addresses were used in calculating the
;; HASH-CODE were ephemeral.  E.g. the table will not need to be rehashed
;; after an ephemeral GC.  If the hash function returns one or two values,
;; and the value returned or defaulted for ADDRESSP is :KEY, then
;; EPHEMERAL-P will be true iff the KEY is not in tenured space.
;;
;;
;; Some (proposed) functions for using in user hashing functions:
;;
;; (HASH-CODE object)
;;
;; returns three values:
;;
;; 1) HASH-CODE
;; 2) ADDRESSP
;; 3) EPHEMERAL-P
;;
;; HASH-CODE is the object transformed into a fixnum by changing its tag
;; bits to a fixnum's tag.  ADDRESSP is true if the object was
;; relocateable.  EPHEMERAL-P is true if ADDRESSP was true and the object
;; is not in tenured space.
;;
;;
;; (FIXNUM-ADD o1 o2)
;; Combines two objects additively and returns a fixnum.
;; If the two objects are fixnums, will be the same as (+ o1 o2) except
;; that the result can not be a bignum.
;;
;; (FIXNUM-MULTIPLY o1 o2)
;; Combines two objects multiplicatively and returns a fixnum.
;;
;; (FIXNUM-FLOOR dividend &optional divisor)
;; Same as Common Lisp's FLOOR function, but converts the objects into
;; fixnums before doing the divide and returns two fixnums: quotient &
;; remainder.
;;
;;;;;;;;;;;;;
;;
;; Implementation details.
;;
;; Hash table vectors have a header that the garbage collector knows about
;; followed by alternating keys and values.  Empty or deleted slots are
;; denoted by a key of $undefined.  Empty slots have a value of $undefined.
;; Deleted slots have a value of NIL.
;;
;; The nhash.lock slot is used to control access to the nhash.vector.
;; 0  means no one is mapping
;; >0 means MAPHASH or WITH-HASH-TABLE-ITERATOR is mapping.
;;    If PUTHASH needs to grow the table it must do it via the
;;    nhash.locked-additions alist.
;; -1 means the table is being grown.  GETHASH can probe normally but
;;    PUTHASH & REMHASH need to make their modifications on the
;;    nhash.locked-additions alist.
;; -2 means the table is being rehashed.  GETHASH must do linear search,
;;    and PUTHASH & REMHASH must use the nhash.locked-additions alist.
;;
;; changed to count of mappers in low 16  + bit for grow and bit for rehash
;; if nhash.lock is 0 nobody is mapping or rehashing or growing
;; in which case puthash and gethash and remhash act normally
;; maphash and WITH-HASH-TABLE-ITERATOR
;;  if rehashing, process-wait for rehash to be finished then proceed normally
;;   otherwise increment map-count, map and decrement map-count when done.
;;   (won't quite work if growing - if we are modifying the hash entries the mods will
;;     happen in the old vector which will then be replaced by the new vector)
;;  so wait on growing too.
;; puthash
;;  if growing or rehashing, add to locked additions alist
;;  if nhash.lock not zero and needs rehashing add to locked-additions alist.
;;  if lock not zero and wants to grow add to locked-additions alist.
;; gethash
;;   if mapping be normal
;;   if rehashing - go without interrupts and do linear scan
;;   if growing - if needs rehash go without interrupts and do linear scan
;;			if not needs rehashing do normal
;; rehash
;;   dont do it if lock not 0
;; remhash
;;   if growing or rehashing use locked-additions list
;;    else be normal.
;; grow 
;;   may do rehash instead if enough deleted entries and map count is zero 
;; 
;;
;; Five bits in the nhash.vector.flags fixnum interact with the garbage
;; collector.  This description uses the symbols that represent bit numbers
;; in a fixnum.  $nhash_xxx_bit has a corresponding $nhash_lap_xxx_bit which
;; gives the byte offset of the bit for LAP code.  The two bytes in
;; question are at offsets $nhash.vector-weak-byte and
;; $nhash.vector-track-keys-byte offsets from the tagged vector.
;; The 32 bits of the fixnum at nhash.vector.flags look like:
;;
;;     TKEC0000 00000000 WVF00000 00000000
;;
;;
;; $nhash_track_keys_bit         "T" in the diagram above
;;                               Sign bit of the longword at $nhash.vector.flags
;;                               or the byte at $nhash.vector-track-keys-byte.
;;                               If set, GC tracks relocation of keys in the
;;                               vector.
;; $nhash_key_moved_bit          "K" in the diagram above
;;                               Set by GC to indicate that a key moved.
;;                               If $nhash_track_keys_bit is clear, this bit is set to
;;                               indicate that any GC will require a rehash.
;;                               GC never clears this bit, but may set it if
;;                               $nhash_track_keys_bit is set.
;; $nhash_ephemeral_bit          "E" in the diagram above
;;                               Ignored by GC.  Set to indicate that an
;;                               ephemeral address was used to calculate one
;;                               or more of the hash codes.
;; $nhash_component_address_bit  "C" in the diagram above.
;;                               Ignored by GC.  Set to indicate that the
;;                               address of a component of a key was used. 
;;                               Means that $nhash_track_keys_bit will
;;                               never be set until all such keys are
;;                               removed.
;; $nhash_weak_bit               "W" in the diagram above
;;                               Sign bit of the byte at $nhash.vector-weak-byte
;;                               Set to indicate a weak hash table
;; $nhash_weak_value_bit         "V" in the diagram above
;;                               If clear, the table is weak on key
;;                               If set, the table is weak on value
;; $nhash_finalizeable_bit       "F" in the diagram above
;;                               If set the table is finalizeable:
;;                               If any key/value pairs are removed, they will be added to
;;                               the nhash.vector.finalization-alist using cons cells
;;                               from nhash.vector.free-alist

(in-package :ccl)

(eval-when (:execute :compile-toplevel :load-toplevel)
  
  (def-accessors (hash-table) %svref
    nil                                   ; 'HASH-TABLE
    nhash.rehashF                         ; function: rehashes if necessary
    nhash.keytransF                       ; transform key into (values primary addressp)
    nhash.compareF                        ; comparison function: 0 -> eq, -1 ->eql, else function
    nhash.rehash-bits                     ; bitset (array (unsigned-byte 32)) for rehash
    nhash.vector                          ; N <key,value> pairs; n relatively prime to & larger than all secondary keys
    nhash.lock                            ; fixnum: count of mappers in low 16 bits + bits for grow and rehash
    nhash.count                           ; Number of entries
    nhash.locked-additions                ; Alist to look in when table locked & not otherwise found
    nhash.fixnum                          ; (a5 $fwdnum)
    nhash.gc-count                        ; (a5 $relocnum) - incremented by full gc, growzone.
    nhash.grow-threshold                  ; Max # entries before grow
    nhash.rehash-ratio                    ; inverted rehash-threshold
    nhash.rehash-size			; rehash-size from user
    nhash.puthash-count                   ; number of times table has been rehashed or grown
    )
  
  ; It's wired in to the code that the length of this vector is 8 and
  ; that its largest element is < 30
  (defconstant secondary-keys #(3 5 7 11 13 17 19 23))
  )

#+ppc-target
(eval-when (:compile-toplevel :execute)
  (require "HASHENV" "ccl:xdump;hashenv"))

(defvar *hash-table-class* (make-built-in-class 'hash-table *istruct-class*))

(setf (type-predicate 'hash-table) 'hash-table-p)


(defmethod print-object ((table hash-table) stream)
  (print-unreadable-object (table stream :type t :identity t)
    (format stream "~S ~S size ~D/~D~:[ Locked ~x~]"
            ':test (hash-table-test table)
            (hash-table-count table)
            (hash-table-size table)
            (eql (nhash.lock table) 0) (nhash.lock table))))


; Of course, the lisp version of this would be too slow ...
; NFCOMP doesn't dump SETF functions.
(defun hash-table-finalization-list (hash-table)
  (unless (hash-table-p hash-table)
    (report-bad-arg hash-table 'hash-table))
  (let* ((vector (nhash.vector hash-table))
         (flags (nhash.vector.flags vector)))
    (declare (fixnum flags))
    (if (logbitp $nhash_finalizeable_bit flags)
      (nhash.vector.finalization-alist vector)
      (error "~S is not a finalizeable hash table" hash-table))))

(defun (setf hash-table-finalization-list) (value hash-table)
  (unless (hash-table-p hash-table)
    (report-bad-arg hash-table 'hash-table))
  (let* ((vector (nhash.vector hash-table))
         (flags (nhash.vector.flags vector)))
    (declare (fixnum flags))
    (if (logbitp $nhash_finalizeable_bit flags)
      (setf (nhash.vector.finalization-alist vector) value)
      (error "~S is not a finalizeable hash table" hash-table))))

(defsetf gethash puthash)

; Returns nil, :key or :value
(defun hash-table-weak-p (hash)
  (unless (hash-table-p hash)
    (setq hash (require-type hash 'hash-table)))
  (let* ((vector (nhash.vector hash))
         (flags (nhash.vector.flags vector)))
    (when (logbitp $nhash_weak_bit flags)
      (if (logbitp $nhash_weak_value_bit flags)
        :value
        :key))))

; value should be nil, :key or :value
(defun (setf hash-table-weak-p) (value hash)
  (unless (hash-table-p hash)
    (setq hash (require-type hash 'hash-table)))
  (without-interrupts                   ; while we've got flags in our hand
   (let* ((vector (nhash.vector hash))
          (flags (nhash.vector.flags vector)))
     (ecase value
       (:key
        (unless (eq (hash-table-test hash) 'eq)
          (error "Only EQ hash tables can be weak on key"))
        (setf (nhash.vector.flags vector)
              (bitset $nhash_weak_bit
                      (bitclr $nhash_weak_value_bit flags))))
       (:value
        (setf (nhash.vector.flags vector)
              (bitset $nhash_weak_bit
                      (bitset $nhash_weak_value_bit flags))))
       ((nil)
        (setf (nhash.vector.flags vector) (bitclr $nhash_weak_bit flags))))))
  value)



;;;;;;;;;;;;;
;;
;; Mapping functions
;;
(defmacro with-hash-table-iterator ((mname hash-table) &body body)
  (let ((state (gensym)))
    `(let ((,state (vector nil nil ,hash-table nil nil)))
       (declare (dynamic-extent ,state))
       (unwind-protect
         (macrolet ((,mname () `(do-hash-table-iteration ,',state)))
           (start-hash-table-iterator ,state)
           ,@body)
         (finish-hash-table-iterator ,state)))))


(defun start-hash-table-iterator (state)
  (let ((hash (hti.hash-table state))
        lock vector)
    (unless (hash-table-p hash)
      (setf (hti.hash-table state) nil)         ; for finish-hash-table-iterator
      (report-bad-arg hash 'hash-table))    
    ; if rehash or grow in progress - hang out till its done 
    (when (neq 0 (%ilogand (nhash.lock hash)  $nhash.lock-grow-or-rehash))
      (process-wait "Wait rehash done" 
                    #'(lambda (hash)
                        (eq 0 (%ilogand (nhash.lock hash)  $nhash.lock-grow-or-rehash)))
                    hash) 
     ;(print 'waited)
      )
    (without-interrupts
     ; paranoia - maybe a rehash started between success of wait function and now
     (when (neq 0 (%ilogand (nhash.lock hash)  $nhash.lock-grow-or-rehash)) ; 7/96
       ; hasnt happened so far
       ;(incf n1)
       (return-from start-hash-table-iterator (start-hash-table-iterator state))) 
     (setf (hti.lock state) (setq lock (nhash.lock hash))
           (hti.locked-additions state) (nhash.locked-additions hash))     
     (when (eq $nhash.lock-map-count-mask 
               (%ilogand lock $nhash.lock-map-count-mask))
       ; is this check silly?
       (error "Too many mappers ~s of hash table ~S" lock hash))
     (setq vector (nhash.vector hash))
     (setf (hti.vector state) vector)
     #|
     ; this isnt right - in case the mapper is modifying the table. 
     ; if rehashing - copy the vector and iterate on the copy - actually copy the whole darn thing
     (if (neq 0 (%ilogand lock $nhash.lock-while-rehashing))
       (without-interrupts
        ;(print 'copying-to-map)
        (let* ((vector (copy-uvector vector))
               (new-hash (%cons-hash-table (nhash.rehashF hash)
                                           (nhash.keytransf hash)
                                           (nhash.compareF hash)
                                           vector
                                           (nhash.grow-threshold hash)
                                           (nhash.rehash-ratio hash)
                                           (nhash.rehash-size hash))))
          (setf (hti.vector state) vector)
          (setf (hti.hash-table state) new-hash)
          (setq hash new-hash)
          (setf (hti.lock hash) 0)
          (setq lock 0)))
       (setf (hti.vector state) vector))
     |# 
     (setf (nhash.lock hash) (1+ lock))
     (setf (hti.index state) (nhash.vector-size vector)))))
 
; this is as fast as the lappy version

(defun do-hash-table-iteration (state)
  (let ((vector (hti.vector state))
        (index (hti.index state))
        key value)
    (declare (optimize (speed 3) (safety 0))) ; what if its big  and empty?
    (if (setf (hti.index state)
              (if index
                (loop
                  (if (eq index 0)(return (setq index nil)))
                  (locally (declare (fixnum index))
                    (setq index (- index 1))
                    (let* ((vector-index (index->vector-index index)))
                      (declare (fixnum vector-index))
                      (setq key (%svref vector vector-index))
                      (when (neq key (%unbound-marker-8))
                        (setq value (%svref vector (the fixnum (1+ vector-index))))
                        (return index)))))))
      (let ((hash (hti.hash-table state)))
        (if (and (hti.locked-additions state)
                 (nhash-locked-additions-cell key hash nil (hti.locked-additions state)))
          (do-hash-table-iteration state)
          (progn
            (setf (nhash.vector.cache-idx (setq vector (nhash.vector hash))) index
                  (nhash.vector.cache-key vector) key
                  (nhash.vector.cache-value vector) value)
            (values t key value))))
      (loop
        (let ((cell (pop (hti.locked-additions state))))
          (declare (list cell))
          (if cell
            (unless (eq (cdr cell) (%unbound-marker-8))
              (return (values t (car cell) (cdr cell))))
            (return nil)))))))

(defun finish-hash-table-iterator (state)
  (without-interrupts
   (let ((hash (hti.hash-table state)))
     (when hash
       (let* ((lock  (hti.lock state))
              (hlock (nhash.lock hash)))         
         (when lock ; unless we never started  ; 7/96
           (when (eq 0 (logand hlock #xffff))
             (error "Hash-table-iterator is confused. hlock ~s hit.lock ~s" hlock lock))
           (setf (nhash.lock hash) (decf hlock))
           (setf
            (hti.index state)  nil
            (hti.vector state) nil
            (hti.lock state)   nil)))))))

(defun maphash (function hash-table)
  (with-hash-table-iterator (m hash-table)
    (loop
      (multiple-value-bind (found key value) (m)
        (unless found (return))
        (funcall function key value)))))


(defmethod make-load-form ((hash hash-table) &optional env)
  (declare (ignore env))
  (let ((rehashF (function-name (nhash.rehashF hash)))
        (keytransF (nhash.keytransF hash))
        (compareF (nhash.compareF hash))
        (vector (nhash.vector hash))
        (count (nhash.count hash))
        (locked-additions (nhash.locked-additions hash)))
    (flet ((convert (f)
             (if (or (fixnump f) (symbolp f))
               `',f
               `(symbol-function ',(function-name f)))))
      (values
       `(%cons-hash-table
         nil nil nil nil ,(nhash.grow-threshold hash) ,(nhash.rehash-ratio hash) ,(nhash.rehash-size hash))
       `(%initialize-hash-table ,hash ',rehashF ,(convert keytransF) ,(convert compareF)
                                ',vector ,count ',locked-additions)))))

(defun needs-rehashing (hash)
  (%needs-rehashing hash))

(defun %initialize-hash-table (hash rehashF keytransF compareF vector count locked-additions)
  (setf (nhash.rehashF hash) (symbol-function rehashF)
        (nhash.keytransF hash) keytransF
        (nhash.compareF hash) compareF
        (nhash.vector hash) vector
        (nhash.count hash) count
        (nhash.locked-additions hash) locked-additions)
  (unless (eq rehashF '%no-rehash)
    (%needs-rehashing hash)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Support for locking hash tables while fasdumping
;;

;; This needs to be updated for processes - OK?
;; is it ok if its being rehashed or growing?
(defun fasl-lock-hash-table (hash-table)
  (setq hash-table (require-type hash-table 'hash-table))
  (without-interrupts
   (let ((hlock (nhash.lock hash-table)))
     (push (cons hash-table hlock) *fcomp-locked-hash-tables*) ; cons not needed
     (when  (eq $nhash.lock-map-count-mask (logand hlock $nhash.lock-map-count-mask))
       (error "Too many mappers of ~S" hash-table))
     (setf (nhash.lock hash-table) (1+ hlock)))))

(defun fasl-unlock-hash-tables ()
  (dolist (hash-table.lock *fcomp-locked-hash-tables*)
    (decf (nhash.lock (car hash-table.lock)))))

	      

#+not-yet
(progn
;;;;;;;;;;;;;
;;
;; Replacement for population
;;
(def-accessors (weak-table) %svref
  nil                                   ; 'weak-table
  weak-table.vector                     ; a $v_nhash vector
  weak-table.index                      ; index for next entry
  weak-table.grow-threshold             ; number of entries left in vector
  )

(defun make-weak-table (&optional (size 20))
  (%istruct 'weak-table
            (%cons-nhash-vector
             size (+ (ash 1 $nhash_weak_bit)))
            0
            size))

(defun weak-table-p (weak-table)
  (istruct-typep weak-table 'weak-table))

(setf (type-predicate 'weak-table) 'weak-table-p)

(defun weak-table-count (weak-table)
  (setq weak-table (require-type weak-table 'weak-table))
  (- (weak-table.index weak-table)
     (nhash.vector.weak-deletions-count (weak-table.vector weak-table))))

(defun weak-table-push (key weak-table &optional value)
  (setq weak-table (require-type weak-table 'weak-table))
  (let ((thresh (weak-table.grow-threshold weak-table))
        (vector (weak-table.vector weak-table))
        (index (weak-table.index weak-table)))
    (declare (fixnum thresh index))
    (if (> thresh 0)
      (progn
        (lap-inline (index)
          (:variable vector key value)
          (move.l (varg vector) atemp0)
          (lea (atemp0 arg_z.l $nhash_data) atemp0)
          (move.l (varg key) atemp0@+)
          (move.l (varg value) @atemp0))
        (setf (weak-table.index weak-table) (the fixnum (1+ index))
              (weak-table.grow-threshold weak-table) (the fixnum (1- thresh)))
        value)
      (let ((deletions (nhash.vector.weak-deletions-count vector)))
        (declare (fixnum deletions))
        (if (> deletions 0)
          ; GC deleted some entries, we can compact the table
          (progn
            (lap-inline (index)
              (:variable vector)
              (getint arg_z)            ; length
              (move.l (varg vector) atemp0)
              (lea (atemp0 $nhash_data) atemp0)
              (move.l atemp0 atemp1)
              (move.l ($ $undefined) da)
              ; Find the first deleted entry
              (dbfloop.l arg_z
                (if# (ne (cmp.l @atemp0 da))
                  (add.l ($ 1) arg_z)
                  (bra @move))
                (add.w ($ 8) atemp0))
              ; copy the rest of the table up
              @move
              (dbfloop.l arg_z
                (move.l atemp0@+ db)
                (if# (eq (cmp.l db da))
                  (add.w ($ 4) atemp0)
                 else#
                  (move.l db atemp1@+)
                  (move.l atemp0@+ atemp1@+)))
              ; Write over the newly emptied part of the table
              (while# (ne (cmp.l atemp0 atemp1))
                (move.l da @atemp1)
                (add.l ($ 8) atemp1)))
            (setf (nhash.vector.weak-deletions-count vector) 0
                  (weak-table.index weak-table) (the fixnum (- index deletions))
                  (weak-table.grow-threshold weak-table) (the fixnum (+ thresh deletions)))
            (weak-table-push key weak-table value))
          ; table is full.  Grow it by a factor of 1.5
          (let* ((new-size (+ index (the fixnum (ash (the fixnum (1+ index)) -1))))
                 (new-vector (%cons-nhash-vector new-size (ash 1 $nhash_weak_bit))))
            (declare (fixnum new-size))
            (lap-inline (index)
              (:variable vector new-vector count)
              (move.l (varg vector) atemp0)
              (move.l (varg new-vector) atemp1)
              (lea (atemp0 $nhash_data) atemp0)
              (lea (atemp1 $nhash_data) atemp1)
              (getint arg_z)            ; table length
              (dbfloop.l arg_z
                (move.l atemp0@+ atemp1@+)
                (move.l atemp0@+ atemp1@+)))
            (setf (weak-table.vector weak-table) new-vector
                  (weak-table.grow-threshold weak-table) (the fixnum (- new-size index)))
            ; It's possible that GC deleted some entries while consing the new vector
            (setf (nhash.vector.weak-deletions-count new-vector)
                  (nhash.vector.weak-deletions-count vector))
            (weak-table-push key weak-table value)))))))

; function gets two args: key & value
(defun map-weak-table (function weak-table)
  (setq weak-table (require-type weak-table 'weak-table))
  (let* ((vector (weak-table.vector weak-table))
         (index (weak-table.index weak-table))
         (flags (nhash.vector.flags vector)))
    (unwind-protect
      (progn
        (setf (nhash.vector.flags vector) 0)    ; disable deletion by GC
        (lap-inline ()
          (:variable function vector index)
          (while# (gt (move.l (varg index) da))
            (sub.l '1 da)
            (move.l da (varg index))
            (move.l (varg vector) atemp0)
            (move.l (atemp0 da.l $nhash_data) arg_y)
            (if# (ne (cmp.w ($ $undefined) arg_y))
              (move.l (atemp0 da.l (+ $nhash_data 4)) arg_z)
              (set_nargs 2)
              (move.l (varg function) atemp0)
              (jsr_subprim $sp-funcall))))
        nil)
      (setf (nhash.vector.flags vector) flags))))

; function gets one arg, the key
(defun map-weak-table-keys (function weak-table)
  (flet ((f (key value)
           (declare (ignore value))
           (funcall function key)))
    (declare (dynamic-extent #'f))
    (map-weak-table #'f weak-table)))
    
) ; #+not-yet

; end
