;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: l0-hash.lisp,v $
;;  Revision 1.4  2003/12/08 07:54:33  gtbyers
;;  Remove some 68k-isms.
;;
;;  3 8/25/97  akh  sxhash
;;  17 7/30/96 akh  puthash and remhash call %hash-linear-probe, %rehash dont if a map has started
;;  16 7/26/96 akh  fix puthash "can't happen" does, gethash call gethash-woi in more cases
;;  14 6/7/96  akh  require size to be a fixnum
;;  12 5/20/96 akh  fix %%equalhash for lists and strings - no same hash for same elts different order
;;                  some decls, some inlines
;;  9 2/19/96  akh  gethash always returns 2 values
;;  6 12/1/95  akh  %i+ in grow-gf-dispatch-table
;;  5 10/27/95 akh  damage control
;;  5 10/26/95 gb   use %istruct to cons hash-table
;;  3 10/17/95 akh  merge patch to sxhash
;;  2 10/6/95  gb   Add missing functions.
;;  6 2/17/95  akh  probably no change
;;  5 2/9/95   slh  fix maphash crash for wta
;;  4 1/31/95  akh  put back some stuff missed while merging
;;  3 1/30/95  akh  fix for processes
;;  (do not edit before this line!!)

; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc. 

;;
;; fixes in gethash - assure cache-key and cache-value in sync
;; --------- 4.4b4
;; 06/20/02 less aggressive %needs-rehashing-p from gary byers
;; -------- 4.4b3 
;; 06/06/99 akh dont clrhash if locked, just set a bit.
;; ------------ 4.3b2
;; akh %%equalphash for string looks at whole string vs 1st 11 chars.
;; akh sxhash for vector array instance
;; akh size mb a fixnum, couple of the fixnums in puthash
;; akh fix %%equalhash for lists and strings - no same hash for same elts different order
;;	some decls, some inlines

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
;; 02/14/97 gb   bit-vector-hash: don't assume anything about alignment.
;;               hash short-floats.
;; ------------- 4.0
;; 06/10/96 gb   use %set-hash-table-vector-key in do-rehash (memoization for egc.)
;; 05/29/96 bill grow-hash-table now unsets the $nhash.lock-while-growing bit if it sets it.
;;               This was causing Dylan's shrink-hash-table to leave the hash table locked.
;; ------------- 3.9
;; 04/09/96 bill puthash no longer loses size when overwriting a deleted entry.
;;               grow-hash-table doesn't grow unless there are no deleted entries.
;; 02/20/96 gb   zero old hash table vector after resize; set keys memo-friendly 
;; 01/16/96 bill %%equalphash-aux no longer says gvectorp or uvectorp, just like %%equalphash.
;;               This makes it possible to compute the hash code of an istruct, e.g. a pathname.
;; 12/13/95 gb   $nhash_track_keys_bit may not be the sign bit: (%ilogbitp 28)
;;               compiles to tst.l on 68k
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
;;               before restoring registers and jumping to %hash-linear-probe .
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
;;   if lock 0 be normal
;;   if rehashing - go without interrupts and do linear scan
;;   if lock not 0 and needs rehash do woi linear scan
;;   else be normal (its ok if growing and no need rehash, if needs rehash, compute-hash-code will do it)

;; rehash
;;   dont do it if lock not 0
;; remhash
;;   if growing or rehashing use locked-additions list
;;   if nhash.lock not zero and needs rehashing use locked-additions alist.
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




(eval-when (:compile-toplevel :execute)
  (require "HASHENV" "ccl:xdump;hashenv")
  #+ppc-target
  (require :number-case-macro)
  (declaim (inline nhash.vector-size))
  (declaim (inline mixup-hash-code))
  (declaim (inline strip-tag-to-fixnum))
  (declaim (inline hash-table-p))
  (declaim (inline index->vector-index vector-index->index swap))
  (declaim (inline %already-rehashed-p %set-already-rehashed-p)))

(defun %cons-hash-table (rehash-function keytrans-function compare-function vector
                                         threshold rehash-ratio rehash-size)
  (%istruct
   'HASH-TABLE                          ; type
   rehash-function                      ; nhash.rehashF
   keytrans-function                    ; nhash.keytransF
   compare-function                     ; nhash.compareF
   nil                                  ; nhash.rehash-bits
   vector                               ; nhash.vector
   0                                    ; nhash.lock
   0                                    ; nhash.count
   nil                                  ; nhash.locked-additions 
   (get-fwdnum)                         ; nhash.fixnum
   (gc-count)                           ; nhash.gc-count
   threshold                            ; nhash.grow-threshold
   rehash-ratio                         ; nhash.rehash-ratio
   rehash-size                          ; nhash.rehash-size
   0))


 
(defun nhash.vector-size (vector)
  (ash (the fixnum (- (the fixnum (uvsize vector)) $nhash.vector_overhead)) -1))

; gets an optional additions argument for do-hash-table-iteration

(defun nhash-locked-additions-cell (key hash &optional addp additions)
  (without-interrupts  ; do this help ??? seems to - shouldnt be necessary
    (let* ((na (or additions (nhash.locked-additions hash))))
        (let* ((comparef (nhash.compareF hash))
               (cell (when na (cond ((eql compareF 0) (assq key na))
                                    ((eql compareF 1) (asseql key na))
                                    (t (assoc key na
                                              :test (hash-table-test-function hash)))))))
          (if addp
            (or cell (%car (push (cons key (%unbound-marker-8)) (nhash.locked-additions hash))))
            cell)))))
#+ignore
(defun %needs-rehashing-p (hash)
  (unless (eql (get-fwdnum) (nhash.fixnum hash))
    (let ((flags (nhash.vector.flags (nhash.vector hash))))
      (declare (fixnum flags))
      (if (logbitp $nhash_track_keys_bit flags)
        ; GC is tracking key movement
        (logbitp $nhash_key_moved_bit flags)
        ; GC is not tracking key movement
        (or (logbitp $nhash_key_moved_bit flags)
            ; key_moved_bit clear means only rehash on full gc or growzone
            (not (eql (gc-count) (nhash.gc-count hash))))))))

;; from gary byers
(defun %needs-rehashing-p (hash)
  (unless (eql (get-fwdnum) (nhash.fixnum hash))
    (let ((flags (nhash.vector.flags (nhash.vector hash))))
      (declare (fixnum flags))
      (if (logbitp $nhash_track_keys_bit flags)
        ; GC is tracking key movement
        (logbitp $nhash_key_moved_bit flags)
        ; GC is not tracking key movement
        (or (logbitp $nhash_key_moved_bit flags) ; Not sure what this means, but rarely true ...
            ;; Rehash if some key is somehow address-based and a GC occurred since last rehash
            (and (not (eql (gc-count) (nhash.gc-count hash))) 
                 (or (logbitp $nhash_component_address_bit flags)
                     (logbitp $nhash_ephemeral_bit flags))))))))

(defun %does-not-need-rehashing (hash)
  (get-fwdnum hash)
  (gc-count hash)
  (let* ((vector (nhash.vector hash))
         (flags (nhash.vector.flags vector)))
    (declare (fixnum flags))
    (when (logbitp $nhash_track_keys_bit flags)
      (setf (nhash.vector.flags vector)
            (logand (lognot (ash 1 $nhash_key_moved_bit)) flags)))))

(defun %needs-rehashing (hash)
  (setf (nhash.fixnum hash)   (the fixnum (1- (the fixnum (get-fwdnum))))
        (nhash.gc-count hash) (the fixnum (1- (the fixnum (gc-count)))))
  (let* ((vector (nhash.vector hash))
         (flags (nhash.vector.flags vector)))
    (declare (fixnum flags))
    (when (logbitp $nhash_track_keys_bit flags)
      (setf (nhash.vector.flags vector) (logior (ash 1 $nhash_key_moved_bit) flags)))))

(eval-when (:compile-toplevel :load-toplevel :execute)
; It's ok that this is defined in terms of ccl:$fixnumshift; all that means
; is that we're a little mixed up.
; On second thought: screw it.  Let's stop using 68K constants in honor of
; the 10th anniversary of anyone using a 68K machine for anything ...

(defun mixup-hash-code (fixnum)
  (declare (fixnum fixnum))
  (the fixnum
    (+ fixnum
       (the fixnum (%ilsl (- 32 8)
                          (logand (1- (ash 1 (- 8 (1+ ppc::fixnumshift)))) fixnum))))))
)

(defun rotate-hash-code (fixnum)
  (declare (fixnum fixnum))
  (let* ((low-3 (logand 7 fixnum))
         (but-low-3 (%ilsr 3 fixnum))
         (low-3*64K (%ilsl 13 low-3))
         (low-3-in-high-3 (%ilsl (- 32 3 3) low-3)))
    (declare (fixnum low-3 but-low-3 low-3*64K low-3-in-high-3))
    (the fixnum (+ low-3-in-high-3
                   (the fixnum (logxor low-3*64K but-low-3))))))


; Strip the tag bits to turn x into a fixnum

(defun strip-tag-to-fixnum (x)
  (declare (fixnum x))
  ;; logand-2 happens to know how to turn itself into %ilogand2,
  ;; but doesn't try to be smart about "-1".
  (logand-2 x -1))

(defconstant $nhash-track-keys-mask
  #.(- (ash 1 $nhash_track_keys_bit)))

(defconstant $nhash-clear-key-bits-mask #xfffff)

(defun compute-hash-code (hash key maybe-rehash-p 
                                        &optional update-maybe-rehash 
                                        (vector (nhash.vector hash))); vectorp))
  (let ((keytransF (nhash.keytransF hash))
        ;(vector (nhash.vector hash))
        primary addressp ephemeral-p)
    (if (not (fixnump keytransF))
      ; not EQ or EQL hash table
      (let ((fwdnum (get-fwdnum)))
        (multiple-value-setq (primary addressp ephemeral-p) (funcall keytransF key))
        (let ((original-primary primary)
              (immediate-p (immediate-p-macro primary)))  ; DUH  - wtf
          (when (and (not (eql fwdnum (get-fwdnum)))
                     (or addressp (not immediate-p)))
            ; GC happenned while computing address-based hash code.  Try again.
            ; should probably be smarter about ephemeral-p here.
            (return-from compute-hash-code
              (compute-hash-code hash key maybe-rehash-p update-maybe-rehash 
                                      vector)))
          (setq primary (strip-tag-to-fixnum primary))
          (unless immediate-p
            (setq primary (mixup-hash-code primary))
            (setq addressp :key)
            (when (ephemeral-p original-primary)
              (setq ephemeral-p t)))))
      ; EQ or EQL hash table
      (progn
        (if (and (not (eql keytransF 0))
                 (need-use-eql key))
           ; EQL hash table
          (setq primary (%%eqlhash-internal key))
          ; EQ hash table - or something eql doesn't do
          (setq primary key))
        (let ((original-primary primary))
          (setq primary (mixup-hash-code (strip-tag-to-fixnum primary)))
          (unless (immediate-p-macro original-primary)
            (when (eq original-primary key)
              (setq addressp :key))
            (setq ephemeral-p (ephemeral-p original-primary))))))
    (when addressp
      (let (rehashed?)
        (when maybe-rehash-p
          (when (neq 0 (%ilogand (nhash.lock hash) $nhash.lock-while-rehashing))
            (cerror "locked?" "locked? ~s ~s" (nhash.rehashF hash)(nhash.lock hash)))
          
          (setq rehashed? (funcall (nhash.rehashF hash) hash))
          (when nil (and (%needs-rehashing-p hash)
                     (eq (nhash.rehashf hash ) #'%no-rehash))
            (cerror "rehash?" "rehash?")) ; it happened -rehashF was %no-rehash
          (when (and rehashed? (not (eql 0 rehashed?)))
            ; rehashed. Need to start over.
            (return-from compute-hash-code              
              (compute-hash-code
               hash key maybe-rehash-p update-maybe-rehash vector))))
        (when update-maybe-rehash
          (setf (nhash.rehashF hash) #'%maybe-rehash)
          (let ((flags (nhash.vector.flags vector)))
            (declare (fixnum flags))
            (when ephemeral-p
              (setq flags (bitset $nhash_ephemeral_bit flags)))
            (if (eq :key addressp)
              ; hash code depended on key's address
              (if (logbitp $nhash_component_address_bit flags)
                (when ephemeral-p
                  (setq flags (bitset $nhash_key_moved_bit flags)))
                (progn
                  (when (not (logbitp $nhash_track_keys_bit flags))
                    (setq flags (bitclr $nhash_key_moved_bit flags)))
                  (setq flags (logior $nhash-track-keys-mask flags))))
              ; hash code depended on component address
              (progn
                (setq flags (logand (lognot $nhash-track-keys-mask) flags))
                (setq flags (bitset $nhash_component_address_bit flags))
                (if (logbitp $nhash_ephemeral_bit flags)
                  (setq flags (bitset $nhash_key_moved_bit flags))
                  (when (and (prog1 (logbitp $nhash_key_moved_bit flags)
                               (setq flags (bitclr $nhash_key_moved_bit flags)))
                             (logbitp $nhash_track_keys_bit flags))
                    ; GC moved a key, but we're disabling that feature
                    ; Remember rehash necessity
                    (setf (nhash.vector.flags vector) flags)
                    (%needs-rehashing hash)
                    (setq flags (nhash.vector.flags vector))))))
            (setf (nhash.vector.flags vector) flags)))          
          (when (eql 0 rehashed?)
            ; Table is locked and needs rehashing
            (return-from compute-hash-code nil))))
    (let* ((length (- (the fixnum (uvsize  vector)) $nhash.vector_overhead))
           (entries (ash length -1)))
      (declare (fixnum length entries))
      (values primary
              (fast-mod primary entries)
              entries))))

(defun %already-rehashed-p (primary rehash-bits)
  (declare (optimize (speed 3)(safety 0)))
  (declare (type (simple-array bit (*)) rehash-bits))
  (eql 1 (aref rehash-bits primary)))

(defun %set-already-rehashed-p (primary rehash-bits)
  (declare (optimize (speed 3)(safety 0)))
  (declare (type (simple-array bit (*)) rehash-bits))
  (setf (aref rehash-bits primary) 1))


(defun hash-table-p (hash)
  (istruct-typep hash 'hash-table))

(defun %normalize-hash-table-count (hash)
  (let* ((vector (nhash.vector hash))
         (weak-deletions-count (nhash.vector.weak-deletions-count vector)))
    (declare (fixnum weak-deletions-count))
    (unless (eql 0 weak-deletions-count)
      (setf (nhash.vector.weak-deletions-count vector) 0)
      (let ((deleted-count (the fixnum
                             (+ (the fixnum (nhash.vector.deleted-count vector))
                                weak-deletions-count)))
            (count (the fixnum (- (the fixnum (nhash.count hash)) weak-deletions-count))))
        (setf (nhash.vector.deleted-count vector) deleted-count
              (nhash.count hash) count)))))

  

(defun make-hash-table (&key (test 'eql)
                             (size 60)
                             (rehash-size 1.5)
                             (rehash-threshold .85)
                             (hash-function nil)
                             (weak nil)
                             (finalizeable nil))
  (unless (and test (or (functionp test) (symbolp test)))
    (report-bad-arg test '(and (not null) (or symbol function))))
  (unless (or (functionp hash-function) (symbolp hash-function))
    (report-bad-arg hash-function '(or symbol function)))
  (unless (and (realp rehash-threshold) (<= 0.0 rehash-threshold) (<= rehash-threshold 1.0))
    (report-bad-arg rehash-threshold '(real 0 1)))
  (unless (or (fixnump rehash-size) (and (realp rehash-size) (< 1.0 rehash-size)))
    (report-bad-arg rehash-size '(or fixnum (real 1 *))))
  (unless (fixnump size) (report-bad-arg size 'fixnum))
  (setq rehash-threshold (/ 1.0 (max 0.01 rehash-threshold)))
  (let ((default-hash-function
          (cond ((or (eq test 'eq) (eq test #'eq)) 
                 (setq test 0))
                ((or (eq test 'eql) (eq test #'eql)) 
                 (setq test -1))
                ((or (eq test 'equal) (eq test #'equal))
                 (setq test #'equal) #'%%equalhash)
                ((or (eq test 'equalp) (eq test #'equalp))
                 (setq test #'equalp) #'%%equalphash)
                (t (setq test (require-type test 'symbol))
                   (or hash-function 
                       (error "non-standard test specified without hash-function"))))))
    (setq hash-function
          (if hash-function
            (require-type hash-function 'symbol)
            default-hash-function)))
  (when (and weak (neq weak :value) (neq test 0))
    (error "Only EQ hash tables can be weak."))
  (when (and finalizeable (not weak))
    (error "Only weak hash tables can be finalizeable."))
  (multiple-value-bind (size total-size)
                       (compute-hash-size (1- size) 1 rehash-threshold)
    (let* ((flags (if weak
                    (+ (+
                        (ash 1 $nhash_weak_bit)
                        (ecase weak
                          ((t :key) 0)
                          (:value (ash 1 $nhash_weak_value_bit))))
                       (if finalizeable (ash 1 $nhash_finalizeable_bit) 0))
                    0))
           (hash (%cons-hash-table 
                  #'%no-rehash hash-function test
                  (%cons-nhash-vector total-size flags)
                  size rehash-threshold rehash-size)))
      (setf (nhash.vector.hash (nhash.vector hash)) hash)
      hash)))

(defun compute-hash-size (size rehash-size rehash-ratio)
  (let* ((new-size size))
    (setq new-size (max 30 (if (fixnump rehash-size)
                             (+ size rehash-size)
                             (ceiling (* size rehash-size)))))
    (if (<= new-size size)
      (setq new-size (1+ size)))        ; God save you if you make this happen
    
    (values new-size 
            (%hash-size (max (+ new-size 2) (ceiling (* new-size rehash-ratio)))))))

; Suggested size is a fixnum: number of pairs.
;  Return a fixnum >= that size that is relatively prime to all secondary keys.
(defun %hash-size (suggestion)
  (declare (fixnum suggestion))
  (declare (optimize (speed 3)(safety 0)))
  (if (<= suggestion #.(aref secondary-keys 7))
    (setq suggestion (+ 2 #.(aref secondary-keys 7)))
    (setq suggestion (logior 1 suggestion)))
  (loop
    (dovector (key secondary-keys (return-from %hash-size suggestion))
      (when (eql 0 (fast-mod suggestion key))
        (return)))
    (incf suggestion 2)))







; what if somebody is mapping, growing, rehashing? 
(defun clrhash (hash)
  (unless (hash-table-p hash)
    (report-bad-arg hash 'hash-table))
  (without-interrupts
   (if (neq 0 (logand (nhash.lock hash) (lognot $nhash.lock-clear)))
     (setf (nhash.lock hash) (logior $nhash.lock-clear (nhash.lock hash)))     
     (let* ((vector (nhash.vector hash))
            (size (nhash.vector-size vector))
            (count (+ size size))
            (index $nhash.vector_overhead))
       (declare (fixnum size count index))
       (dotimes (i count)
         (setf (%svref vector index) (%unbound-marker-8))
         (incf index))
       (incf (the fixnum (nhash.grow-threshold hash))
             (the fixnum (+ (the fixnum (nhash.count hash))
                            (the fixnum (nhash.vector.deleted-count vector)))))
       (setf (nhash.count hash) 0
             (nhash.lock hash) 0
             (nhash.locked-additions hash) nil
             (nhash.vector.cache-key vector) (%unbound-marker-8)
             (nhash.vector.cache-value vector) nil
             (nhash.vector.finalization-alist vector) nil
             (nhash.vector.free-alist vector) nil
             (nhash.vector.weak-deletions-count vector) 0
             (nhash.vector.deleted-count vector) 0
             (nhash.vector.flags vector) (logand $nhash_weak_flags_mask
                                                 (nhash.vector.flags vector)))))
   hash))

(defun index->vector-index (index)
  (declare (fixnum index))
  (the fixnum (+ $nhash.vector_overhead (the fixnum (+ index index)))))

(defun vector-index->index (index)
  (declare (fixnum index))
  (the fixnum (ash (the fixnum (- index $nhash.vector_overhead)) -1)))


(defun hash-table-count (hash)
  (if (nhash.locked-additions (require-type hash 'hash-table))
    (add-locked-additions hash))
  (%normalize-hash-table-count hash)
  (+ (the fixnum (nhash.count hash))
     (the fixnum (length (nhash.locked-additions hash)))))

(defun hash-table-rehash-size (hash)
  (nhash.rehash-size (require-type hash 'hash-table)))

(defun hash-table-rehash-threshold (hash)
  (/ 1.0 (nhash.rehash-ratio (require-type hash 'hash-table))))

(defun hash-table-size (hash)
  (%i+ (the fixnum (hash-table-count hash))
       (the fixnum (nhash.grow-threshold hash))
       (the fixnum (nhash.vector.deleted-count (nhash.vector hash)))))

(defun hash-table-test (hash)
  (let ((f (nhash.compareF (require-type hash 'hash-table))))
    (if (fixnump f)
      (if (eql 0 f) 'eq 'eql)
      (let ((name (if (symbolp f) f (function-name f))))
        (if (memq name '(equal equalp)) name f)))))

; sometimes you'd rather have the function than the symbol.
(defun hash-table-test-function (hash)
  (let ((f (nhash.compareF (require-type hash 'hash-table))))
    (if (fixnump f)
      (if (eql 0 f) #'eq #'eql)
      f)))

;; Finalization-list accessors are in "ccl:lib;hash" because SETF functions
;;  don't get dumped as "simple" %defuns.
;; 



(defun puthash (key hash default &optional (value default))
  (unless (hash-table-p hash)
    (report-bad-arg hash 'hash-table))
  (without-interrupts
   (when (and (neq 0 (logand $nhash.lock-clear (nhash.lock hash)))
              (eq 0 (logand (lognot $nhash.lock-clear) (nhash.lock hash))))
     (clrhash hash)
     ))
  (when (and (eq 0 (nhash.lock hash))
             (%needs-rehashing-p hash))
    (%rehash hash))
  (let ((level *interrupt-level*))
    (without-interrupts ; ???
     ;(multiple-p hash key) ;49
     (let ((vector (nhash.vector  hash)))     
       (when (and (eq key (nhash.vector.cache-key vector))
                  (eql 0 (%ilogand (nhash.lock hash) $nhash.lock-grow-or-rehash))) ; while growing or rehashing, can't mod vector
         (let* ((idx (nhash.vector.cache-idx vector)))
           (declare (fixnum idx))
           (setf (%svref vector (the fixnum (1+ (the fixnum (index->vector-index idx)))))
                 value)
           (setf (nhash.vector.cache-value vector) value)
           (return-from puthash value)))               
       (when (or (neq 0 (%ilogand (nhash.lock hash) $nhash.lock-grow-or-rehash))
                 (and nil (neq 0 (nhash.lock hash))  ; we could see if its already there? - DO LINEAR BELOW
                      (%needs-rehashing-p hash)))
         (let ((cell (nhash-locked-additions-cell key hash t)))
           (declare (cons cell))
           ; Table must be locked, add to locked-additions alist
           (setf (nhash.vector.cache-key vector) (%unbound-marker-8)
                 (nhash.vector.cache-value vector) nil)
           (setf (car cell) key
                 (cdr cell) value)
           (return-from puthash value)))
       (when (nhash.locked-additions hash)          ; may be left over from an aborted map
         (add-locked-additions hash))
       (when (nhash.locked-additions hash)
         (let ((cell (nhash-locked-additions-cell key hash)))
           (declare (list cell))
           (when cell
             (setf (nhash.vector.cache-key vector) (%unbound-marker-8)
                   (nhash.vector.cache-value vector) nil)
             (setf (cdr cell) value)
             (return-from puthash value))))
       (when (neq 0 (%ilogand (nhash.lock hash) $nhash.lock-grow-or-rehash)) ; sunday added
         (return-from puthash (puthash key hash value)))
       ; It is important that we are non-interruptable between the time
       ; that %hash-probe decides on an index and when we actually put
       ; the key/value pair in the table at that index.
       (let () ;((level *interrupt-level*))
         (progn ;without-interrupts  ; already woi
           (setq vector (nhash.vector hash))  ; maybe changed
           (multiple-value-bind (foundp old-val index) (%hash-probe hash key 1)
             (declare (ignore-if-unused old-val))
             (when (and (not foundp)(null index))
               ; table locked and needs rehash
               (multiple-value-setq (foundp old-val index) (%hash-linear-probe hash key)))
             (when (not foundp)
               (when (or (null index) ; null index = locked and needs rehash and not already there
                         (and (eql 0 (nhash.grow-threshold hash))  ; 7/96 - merged two cases - lose cerror
                              (neq 0 (nhash.lock hash))))                 
                 ;(incf n4)
                 (let ((cell (nhash-locked-additions-cell key hash t)))
                   (declare (cons cell))
                   ; Table is locked and needs rehash or wants to grow
                   (setf (nhash.vector.cache-key vector) (%unbound-marker-8)
                         (nhash.vector.cache-value vector) nil)
                   (setf (car cell) key
                         (cdr cell) value)
                   (return-from puthash value)))
               (when (< (the fixnum (nhash.grow-threshold hash)) 0)
                 (cerror "a" "negative grow ~s" (nhash.grow-threshold hash)))
               (when (eql 0 (nhash.grow-threshold hash))                 
                 ; lock it now then allow interrupts
                 ; this wont prevent somebody from starting a maphash between now and decision to rehash
                 
                 (unwind-protect
                   (progn
                     (setf (nhash.lock hash) (%ilogior (nhash.lock hash) $nhash.lock-while-growing))
                     (setq *interrupt-level* level) ; <<<
                     (grow-hash-table hash))
                   (setf (nhash.lock hash)(%ilogand (nhash.lock hash)
                                            #.(%ilognot $nhash.lock-while-growing))))
                 (return-from puthash (puthash key hash value)))
               (decf (the fixnum (nhash.grow-threshold hash)))
               (incf (the fixnum (nhash.count hash))))
             (locally (declare (fixnum index))
               (incf (the fixnum (%svref hash nhash.puthash-count)))
               (let ((flags (nhash.vector.flags vector))
                     (vector-index (index->vector-index index)))
                 (declare (fixnum flags vector-index))
                 #-ppc-target (setf (%svref vector vector-index) key)
                 #+ppc-target (%set-hash-table-vector-key vector vector-index key)
                 (incf vector-index)
                 (let ((old-value (%svref vector vector-index)))    ; ---can this be the old-val from %hash-probe?
                   (setf (%svref vector vector-index) value
                         (nhash.vector.cache-idx vector) index
                         (nhash.vector.cache-key vector) key
                         (nhash.vector.cache-value vector) value)
                   (when (null foundp)
                     (when (null old-value)
                       ; Writing over a deleted entry.  Adjust deleted-count
                       (when (> 0 (the fixnum (decf (the fixnum (nhash.vector.deleted-count vector)))))
                         (let ((weak-deletions (nhash.vector.weak-deletions-count vector)))
                           (declare (fixnum weak-deletions))
                           (setf (nhash.vector.weak-deletions-count vector) 0)
                           (incf (the fixnum (nhash.vector.deleted-count vector)) weak-deletions)
                           (decf (the fixnum (nhash.count hash)) weak-deletions)))
                       (incf (the fixnum (nhash.grow-threshold hash)))
                       (when (logbitp $nhash_finalizeable_bit flags)
                         ; new entry is finalizeable.  Push a cell on the free-alist
                         (push (cons nil nil) (nhash.vector.free-alist vector))))))))))
         ;(multiple-p hash key)  ; 49
         (when nil ;(neq value (gethash key hash default))
           (cerror "put" "put"))
         value)))))

; Setting a key in a hash-table vector needs to 
; ensure that the vector header gets memoized as well
#+ppc-target
(defppclapfunction %set-hash-table-vector-key ((vector arg_x) (index arg_y) (value arg_z))
  (ba .SPset-hash-key))

; do gethash without interrupts using linear search
; called by gethash if rehashing or (if growing and need rehashing).
; seems hardly more time woi than copying the vector (woi)
; and much less space consuming
; cant seem to get this to happen in real life - tested by setting rehashing bit at toplevel

(defun gethash-woi (key hash default)
  (without-interrupts
   ; either this guy has to look at locked additions or...
   ; only caller did this already
   #|
   (when (nhash.locked-additions hash)
     (let ((cell (nhash-locked-additions-cell key hash)))
       (declare (list cell))
       (when cell
         (setf (nhash.vector.cache-key (nhash.vector hash)) (%unbound-marker-8))
         (return-from gethash-woi
           (if (eq (cdr cell) (%unbound-marker-8))
             (values default nil)
             (values (cdr cell) t))))))|#
   (multiple-value-bind (foundp value idx)
     (%hash-linear-probe hash key)
     (values (if foundp value default) idx))))

(defun deleted-in-locked-additions (key hash)
  (when (nhash.locked-additions hash)
    (let ((cell (nhash-locked-additions-cell key hash)))
      (declare (list cell))
      (if cell
        (if (eq (cdr cell) (%unbound-marker-8))
          t          
          nil)))))

(defun count-entries (hash)
  (let* ((vector (nhash.vector hash))
         (size (uvsize vector))
         (idx $nhash.vector_overhead)
         (count 0))
    (loop
      (when (neq (%svref vector idx) (%unbound-marker-8))
        (incf count))
      (when (>= (setq idx (+ idx 2)) size)
        (return count)))))

(defun gethash (key hash &optional default)
  (unless (hash-table-p hash)
    (setq hash (require-type hash 'hash-table)))
  (without-interrupts
   (when (and (neq 0 (logand $nhash.lock-clear (nhash.lock hash)))
              (eq 0 (logand (lognot $nhash.lock-clear) (nhash.lock hash))))
     (clrhash hash)
     ))
  (without-interrupts  ; HUH ???
   (let* ((vector (nhash.vector hash))
          (cache-value (nhash.vector.cache-value vector)) ; get it sooner rather than later cause GC may clobber
          (cache-key (nhash.vector.cache-key vector)))
     (when (or (eq key cache-key)
               (let ((comparef (nhash.comparef hash)))  ;; added this <<< makes equal tables bettttterrr if you repeat
                 (if (eq comparef 0)  ;; eq
                   nil
                   (if (eq comparef -1) ;; eql
                     (eql key cache-key)
                     (if (eq comparef #'equal)
                       (equal key cache-key)
                       nil)))))
                     ;(if (functionp comparef) ;; equalp might cause GC so forget it
                     ;  (funcall comparef key cache-key))))))
       (return-from gethash
         (values cache-value ;(nhash.vector.cache-value vector)
                 t)))
     (let ()
       (when (and (eq 0 (nhash.lock hash))  ; sat added
                  (nhash.locked-additions hash))
         (add-locked-additions hash))
       (when (nhash.locked-additions hash)
         (let ((cell (nhash-locked-additions-cell key hash)))         
           (declare (type list cell))
           (when cell
             (let ((value (cdr cell)))
               (return-from gethash
                 (if (eq value (%unbound-marker-8))
                   (values default nil)
                   (values value t))))))))
     (let ((lock (nhash.lock hash)))
       (declare (fixnum lock))
       (when (or (logbitp $nhash-rehashing-bit lock)
                 ;(logbitp $nhash-growing-bit lock)
                 (and (neq 0 (nhash.lock hash)) ;(logbitp $nhash-growing-bit lock) ; << 7/96
                      ; if lock is 0, hash-probe will rehash it for us, else won't
                      (%needs-rehashing-p hash)))
         (return-from gethash
           (gethash-woi key hash default))))     
     (progn ;without-interrupts ; already woi
      (multiple-value-bind (foundp value index) (%hash-probe hash key nil)
        (if foundp
          (let ((vector (nhash.vector hash)))     ; may have changed
            (setf (nhash.vector.cache-key vector) (%svref vector (index->vector-index index))
                  (nhash.vector.cache-value vector) value
                  (nhash.vector.cache-idx vector) index)
            (values value t))
          (values default nil)))))))

(defun remhash (key hash)
  (unless (hash-table-p hash)
    (setq hash (require-type hash 'hash-table)))
  (when (and (eq 0 (nhash.lock hash))
             (%needs-rehashing-p hash))
    (%rehash hash))
  (without-interrupts
   (let* ((index nil)
          (vector (nhash.vector hash)))
     (progn ;without-interrupts  ; ???
       (when (neq 0 (%ilogand (nhash.lock hash) $nhash.lock-grow-or-rehash))
         ; growing or rehashing.  Not allowed to touch the vector
         (return-from remhash
           (prog1
             (if (eq (gethash key hash (%unbound-marker-8)) (%unbound-marker-8))
               nil ; wasnt there anyway
               (let ((cell (nhash-locked-additions-cell key hash t)))
                 (declare (cons cell))
                 (setf (cdr cell) (%unbound-marker-8))
                 t))
             (setf (nhash.vector.cache-key vector) (%unbound-marker-8)
                   (nhash.vector.cache-value vector) nil)))))    
     (when (and (eq key (nhash.vector.cache-key vector))
                (eq 0 (%ilogand (nhash.lock hash) $nhash.lock-grow-or-rehash)))
       (setf (nhash.vector.cache-key vector) (%unbound-marker-8)
             (nhash.vector.cache-value vector) nil)
       (let ((vidx (index->vector-index (nhash.vector.cache-idx vector))))
         (setf (%svref vector vidx) (%unbound-marker-8))
         (setf (%svref vector (the fixnum (1+ vidx))) nil))
       (incf (the fixnum (nhash.vector.deleted-count vector)))
       (decf (the fixnum (nhash.count hash)))
       (return-from remhash t))
     (when (nhash.locked-additions hash)
       (add-locked-additions hash))
     (when (nhash.locked-additions hash)
       (let ((cell (nhash-locked-additions-cell key hash)))
         (declare (list cell))
         (when cell
           (let ((old (cdr cell)))
             (setf (nhash.vector.cache-key vector) (%unbound-marker-8)
                   (nhash.vector.cache-value vector) nil)
             (setf (cdr cell) (%unbound-marker-8))
             (return-from remhash (if (eq old (%unbound-marker-8)) nil t))))))
     (progn ;without-interrupts
       (multiple-value-bind (foundp value idx) (%hash-probe hash key nil)
         (declare (ignore-if-unused value))
         (setq index idx)
         (when (and (not foundp)(not index)) ; << 7/96
           ; locked and needs rehashing
           (multiple-value-setq (foundp value index) (%hash-linear-probe hash key)))
         (when foundp           
           (setq vector (nhash.vector hash))         ; in case it changed
           ; always clear the cache cause I'm too lazy to call the comparison function
           ; and don't want to keep a possibly deleted key from being GC'd
           (setf (nhash.vector.cache-key vector) (%unbound-marker-8)
                 (nhash.vector.cache-value vector) nil)
           ; Update the count
           (incf (the fixnum (nhash.vector.deleted-count vector)))
           (decf (the fixnum (nhash.count hash)))
           ; Remove a cons from the free-alist if the table is finalizeable
           (when (logbitp $nhash_finalizeable_bit (nhash.vector.flags vector))
             (pop (the list (svref nhash.vector.free-alist vector))))
           ; Delete the value from the table.
           (let ((vector-index (index->vector-index index)))
             (declare (fixnum vector-index))
             (setf (%svref vector vector-index) (%unbound-marker-8)
                   (%svref vector (the fixnum (1+ vector-index))) nil))
           ; We deleted something
           t))))))               ; Found something
                  
; Grow the hash table, then add the given (key value) pair.
; caller has set lock-while growing (usually)
(defun grow-hash-table (hash)
  (unless (hash-table-p hash)
    (setq hash (require-type hash 'hash-table)))
  (if (eql 0 (%ilogand (nhash.lock hash) $nhash.lock-while-growing))
    (unwind-protect
      (progn
        (setf (nhash.lock hash) (%ilogior (nhash.lock hash) $nhash.lock-while-growing))
        (%grow-hash-table hash))
      (setf (nhash.lock hash) (%ilogand (nhash.lock hash) (lognot $nhash.lock-while-growing))))
    (%grow-hash-table hash)))

(defun %grow-hash-table (hash)
  (block grow-hash-table
    (%normalize-hash-table-count hash)
    (let* ((old-vector (nhash.vector hash))
           (old-size (nhash.count hash))
           (old-total-size (nhash.vector-size old-vector))
           (flags 0)
           (flags-sans-weak 0)
           (weak-flags)
           rehashF)
      (declare (fixnum old-total-size flags flags-sans-weak weak-flags))    
      ; well we knew lock was 0 when we called this - is it still 0?
      (when (and (> (nhash.vector.deleted-count old-vector) 0)
                 ; make sure nobody started mapping after we allowed interrupts
                 (eq 0 (%ilogand (nhash.lock hash) $nhash.lock-map-count-mask))) ; <<< EQ not NEQ
        ; There are enough deleted entries. Rehash to get rid of them
        (progn ;without-interrupts ; needed when egc - why??? - no mo 
          (%rehash hash)
          )        
        (return-from grow-hash-table))
      (multiple-value-bind (size total-size)
                           (compute-hash-size 
                            old-size (nhash.rehash-size hash) (nhash.rehash-ratio hash))
        (unless (eql 0 (nhash.grow-threshold hash))       ; maybe it's done already - shouldnt happen                
          (return-from grow-hash-table ))
        (unless (eql old-vector (nhash.vector hash))
          ; Somebody screwed around with my hash table.  Try again. - shouldnt happen
          (return-from grow-hash-table (grow-hash-table hash)))
        (progn ;without-interrupts  ; this ???
          (unwind-protect
            (let ((fwdnum (get-fwdnum))
                  (gc-count (gc-count))
                  vector)
              (setq flags (nhash.vector.flags old-vector)
                    flags-sans-weak (logand flags (logxor -1 $nhash_weak_flags_mask))
                    weak-flags (logand flags $nhash_weak_flags_mask)
                    rehashF (nhash.rehashF hash))          
              (setf (nhash.lock hash) (%ilogior (nhash.lock hash) $nhash.lock-while-growing) ; dont need
                    (nhash.rehashF hash) #'%am-growing
                    (nhash.vector.flags old-vector) flags-sans-weak)      ; disable GC weak stuff
              (%normalize-hash-table-count hash)
              (setq old-size (nhash.count hash))
              (setq vector (%cons-nhash-vector total-size 0))
              (do* ((index 0 (1+ index))
                    (vector-index (index->vector-index 0) (+ vector-index 2)))
                   ((>= index old-total-size))
                (declare (fixnum index vector-index))
                ; somebody messed with it - shouldnt happen cause we locked it
                (when (or (eq 0 (nhash.lock hash))
                          (neq old-vector (nhash.vector hash))
                          (neq old-size (nhash.count hash)))
                  (cerror "try again" "lock is 0 in grow ~s" index)
                  (return-from grow-hash-table (grow-hash-table hash )))
                
                (without-interrupts
                 (let ((key (%svref old-vector vector-index)))
                   (unless (eq key (%unbound-marker-8))
                     (let* ((new-index (%growhash-probe vector hash key))
                            (new-vector-index (index->vector-index new-index)))
                       (setf (%svref vector new-vector-index) key)
                       (setf (%svref vector (the fixnum (1+ new-vector-index)))
                             (%svref old-vector (the fixnum (1+ vector-index)))))))))
              (without-interrupts  ; trying this ???
               (setf (nhash.vector.finalization-alist vector)
                     (nhash.vector.finalization-alist old-vector)
                     (nhash.vector.free-alist vector)
                     (nhash.vector.free-alist old-vector)
                     (nhash.vector.flags vector)
                     (logior weak-flags (the fixnum (nhash.vector.flags vector))))
               (incf (nhash.puthash-count hash))
               (setf (nhash.rehash-bits hash) nil
                     (nhash.vector hash) vector
                     (nhash.vector.hash vector) hash
                     (nhash.vector.cache-key vector) (%unbound-marker-8)
                     (nhash.vector.cache-value vector) nil
                     (nhash.fixnum hash) fwdnum
                     (nhash.gc-count hash) gc-count
                     (nhash.grow-threshold hash) (- size (nhash.count hash)))
               (when (eq #'%am-growing (nhash.rehashF hash))
                 ; if not changed to %maybe-rehash then contains no address based keys
                 (setf (nhash.rehashf hash) #'%no-rehash))
               (setq rehashF nil)       ; tell clean-up form we finished the loop
               (when (neq old-size (nhash.count hash))
                 (cerror "xx" "Somebody messed with count while growing")
                 (return-from grow-hash-table (grow-hash-table hash )))
               (when (minusp (nhash.grow-threshold hash))
                 (cerror "nn" "negative grow-threshold ~S ~s ~s ~s" 
                         (nhash.grow-threshold hash) size total-size old-size))
               ; If the old vector's in some static heap, zero it
               ; so that less garbage is retained.
               #+ppc-target (%init-misc 0 old-vector)))            
            (when rehashF
              (setf (nhash.rehashF hash) rehashF
                    (nhash.vector.flags old-vector)
                    (logior weak-flags (the fixnum (nhash.vector.flags old-vector)))))))))))

; need this for now cause bits are different
(defun add-locked-additions (hash)
  (without-interrupts
   (when (eql 0 (nhash.lock hash))
     (progn ;without-interrupts ; we dont like this but dont see how it can work otherwise.
      ; it makes locked additions temporarily invisible so gethash will fail.
       ; It makes locked additions invisible so remhash will remove
       ; from the TABLE if it is there and not just mark it in locked additions
      ; and if so the unwind protect is not needed
       ; also could get messy if 2 processes are doing this
      (let ((additions (nhash.locked-additions hash))
            cell)
        (declare (list additions cell))        
        (setf (nhash.locked-additions hash) nil)
        (unwind-protect
          (progn
            (while (and additions (neq 0 (nhash.grow-threshold hash))) ; but what if its a bunch of remhashes?
              (setq cell (car additions))
              (if (neq (cdr cell) (%unbound-marker-8))
                (puthash (car cell) hash (cdr cell))
                (remhash (car cell) hash))
              (pop additions))
            (when  additions ; ok so just do the remhashes - is this worth the trouble?
              (let* ((tem additions))
                (declare (list tem))
                (while tem
                  (let ((cell (car tem)))
                    (setq tem (cdr tem))
                    (when (eq (cdr cell)(%unbound-marker-8))
                      (remhash (car cell) hash) 
                      (setq additions (delq cell additions))))))))
          (when additions
            (setf (nhash.locked-additions hash)
                  (nconc additions (nhash.locked-additions hash)))))))
      t)))


; values of nhash.rehashF
; %no-rehash - do nothing
; %maybe-rehash - if doesnt need rehashing - if is rehashing 0 else nil
;		  if locked 0
;		  else rehash, return t
; %am-rehashing - 0
; %am-growing   - calls %maybe-rehash

; compute-hash-code funcalls it if addressp and maybe-rehash-p
;                  sets to maybe-rehash if addressp and update-maybe-rehash (ie from puthash)
; grow-hash-table sets to %am-growing when doing so, resets to original value when done
; rehash sets to %am-rehashing, then to original when done

(defun %no-rehash (hash)
  (declare (%noforcestk)
           (optimize (speed 3) (safety 0))
           (ignore hash))
  nil)

(defun %maybe-rehash (hash)
  (declare (optimize (speed 3) (safety 0)))
  (cond ((not (%needs-rehashing-p hash))
         (if (logbitp $nhash-rehashing-bit (nhash.lock hash))
           0
           nil))
        ((not (eql 0 (nhash.lock hash)))
         0)
        (t (loop ; bogus ? - if someone starts mapping we could hang out here a long time?
             ; maybe not - if rehashing or growing its locked
             ; and puthash is woi
             (%rehash hash)
             (unless (%needs-rehashing-p hash)
               (return))
             ;(incf n3)
             )
           t)))

(defun %am-rehashing (hash)
  (declare (optimize (speed 3) (safety 0))
           (ignore hash))
  0)

(defun %am-growing (hash)
  (declare (optimize (speed 3) (safety 0)))
  (%maybe-rehash hash))

; returns three values:
;   foundp - true if key was found
;   value - the current value of key
;   index - the index in the vector for key (where it was or where
;           to insert it if foundp is nil)
; If update-maybe-rehash is true, will update the nhash.rehashF slot
; appropriately (true when called from puthash
(defun %hash-probe (hash key update-maybe-rehash)  
  (multiple-value-bind (hash-code index entries)
                       (compute-hash-code hash key t update-maybe-rehash)
    (unless hash-code
      ; Locked and rehashing
      (return-from %hash-probe  nil))
    (locally (declare (fixnum hash-code index entries) (optimize (speed 3)(safety 0)))
      (let* ((compareF (nhash.compareF hash))
             (vector (nhash.vector hash))
             (vector-index 0)
             table-key table-value
             (first-deleted-index nil)
             (rehash-count (nhash.puthash-count hash)))
        (declare (fixnum vector-index rehash-count))
        (macrolet (;testing (%svref (x y) `(uvref ,x ,y))
                   (return-it (form)
                     `(return-from %hash-probe
                        (if (eq rehash-count (nhash.puthash-count hash))
                          ,form
                          (%hash-probe hash key update-maybe-rehash)))))
          (macrolet ((test-it (predicate)
                       (unless (listp predicate) (setq predicate (list predicate)))
                       `(progn
                          (setq vector-index (index->vector-index index)
                                table-key (%svref vector vector-index)
                                table-value (%svref vector (the fixnum (1+ vector-index))))
                          (cond ((eq table-key (%unbound-marker-8))
                                 (when (eq table-value (%unbound-marker-8))
                                   (return-it
                                    (if first-deleted-index
                                      (values nil nil first-deleted-index)
                                      (values nil (%unbound-marker-8) index))))
                                 (unless first-deleted-index
                                   (setq first-deleted-index index)))
                                ((,@predicate key table-key)
                                 (return-it (values t table-value index)))))))
            (macrolet ((do-it (predicate)
                         `(progn
                            (test-it ,predicate)
                            ; First probe failed. Iterate on secondary key
                            (let ((initial-index index)
                                  (secondary-hash (%svref secondary-keys (logand 7 hash-code))))
                              (declare (fixnum secondary-hash initial-index))
                              (loop
                                (incf index secondary-hash)
                                (when (>= index entries)
                                  (decf index entries))
                                (when (eql index initial-index)
                                  (unless first-deleted-index
                                    (error "No deleted entries in table"))
                                  (return-from %hash-probe
                                    (values nil nil first-deleted-index)))
                                (test-it ,predicate))))))
              (if (fixnump comparef)
                ; EQ or EQL hash table
                (if (or (eql 0 comparef)
                        (immediate-p-macro key)
                        (not (need-use-eql key)))
                  ; EQ hash table or EQL == EQ for KEY
                  (do-it eq)
                  (do-it eql))
                ; general compare function
                (do-it (funcall comparef))))))))))



; Here when the table is locked and needs rehashing 

(defun %hash-linear-probe (hash key)
  (let* ((test (nhash.compareF hash))
         (vector (nhash.vector hash))
         (vsize (uvsize vector))
         (vector-index $nhash.vector_overhead)
         ;(elements (nhash.vector-size vector))
         ;(index elements)
         table-key)
    (declare (fixnum index vector-index vsize))
    (macrolet ((test-it (predicate v1 v2)
                 (if (listp predicate)
                 `(,@predicate ,v1 ,v2)
                 `(,predicate ,v1 ,v2))))
      (macrolet ((do-it (predicate)
                   `(loop                      
                      (setq table-key (%svref vector vector-index))
                      (unless (eq table-key (%unbound-marker-8))
                        (when (test-it ,predicate key table-key)
                          (return
                           (values t
                                   (%svref vector (the fixnum (1+ vector-index)))
                                   (vector-index->index vector-index)))))
                      (setq vector-index (+ 2 vector-index))
                      (when (= vector-index vsize)(return nil)))))
        (cond ((eql 0 test) (do-it eq))
              ((fixnump test) (do-it eql))
              (t (do-it (funcall test))))))))

#|
; mebbe?
(defmacro %rehash? (hash)
  (let ((level *interrupt-level*))
    (without-interrupts ; lets be uninterruptable between decision to do and doing
     (when (and (eq 0 (nhash.lock hash))
             (%needs-rehashing-p hash))
       (%rehash2 hash level)))))

(defun %rehash2 (hash level)
  (let* ((vector (nhash.vector hash))
         (flags (nhash.vector.flags vector))         
         ;(start-count 0)
         (rehashF (nhash.rehashF hash))
         done)
    (unwind-protect
      (progn
        (setf (nhash.vector.cache-key vector)(%unbound-marker-8))
        (setf (nhash.rehashF hash) #'%am-rehashing)        
        (setf (nhash.lock hash) (logior $nhash.lock-while-rehashing (nhash.lock hash)))
        ;(setq start-count (count-entries hash))
        (setf (nhash.vector.flags vector) (logand (nhash.vector.flags vector)
                                                  $nhash-clear-key-bits-mask))
        (let ((*interrupt-level* level))  ; do it with orig value of level
          (setq done (do-rehash hash)))) 
      (setf (nhash.lock hash)(logand  (lognot $nhash.lock-while-rehashing) (nhash.lock hash)))
      (if (and done (eq (nhash.rehashf hash) #'%am-rehashing))
        (setf (nhash.rehashF hash) #'%no-rehash)
        (setf (nhash.rehashf hash) rehashf))
      (when (not done)
        (setf (nhash.vector.flags (nhash.vector hash)) flags)
        ; even if didnt need rehashing before (from grow), surely does now if half rehashed
        ; unless of course we never started
        (%needs-rehashing hash)))))
|#



; Rehash
(defun %rehash (hash)
  (progn ;without-interrupts
  (let* ((vector (nhash.vector hash))
         (flags (nhash.vector.flags vector))         
         ;(start-count 0)
         (rehashF (nhash.rehashF hash))
         done)
    (unwind-protect
      (progn
        (setf (nhash.vector.cache-key vector)(%unbound-marker-8))
        (setf (nhash.rehashF hash) #'%am-rehashing)
        ; somebody could have started mapping between last time checked map count and now
        (without-interrupts ; paranoia 7/96 - well it does happen rather often
         (when (neq 0 (%ilogand (nhash.lock hash) $nhash.lock-map-count-mask))
          ;(incf n2)
           (return-from %rehash))
         (setf (nhash.lock hash) (logior $nhash.lock-while-rehashing (nhash.lock hash))))
        ;(setq start-count (count-entries hash))
        (setf (nhash.vector.flags vector) (logand (nhash.vector.flags vector)
                                                  $nhash-clear-key-bits-mask))
        (setq done (do-rehash hash))
        ;(when (neq (count-entries hash) start-count)(cerror "count" "count"))
        )
      (setf (nhash.lock hash)(logand  (lognot $nhash.lock-while-rehashing) (nhash.lock hash)))
      (if (and done (eq (nhash.rehashf hash) #'%am-rehashing))
        (setf (nhash.rehashF hash) #'%no-rehash)
        (setf (nhash.rehashf hash) rehashf))
      (when (not done)
        (setf (nhash.vector.flags (nhash.vector hash)) flags)
        ; even if didnt need rehashing before (from grow), surely does now if half rehashed
        ; unless of course we never started
        (%needs-rehashing hash))))))


(defun %make-rehash-bits (hash &optional (size (nhash.vector-size (nhash.vector hash))))
  (declare (fixnum size))
  (let ((rehash-bits (nhash.rehash-bits hash)))
    (unless (and rehash-bits
                 (>= (uvsize rehash-bits) size))
      (return-from %make-rehash-bits
        (setf (nhash.rehash-bits hash) (make-array size :element-type 'bit :initial-element 0))))
    (fill (the simple-bit-vector rehash-bits) 0)))

(defun do-rehash (hash)
  (let* ((vector (nhash.vector hash))
         (vector-index (- $nhash.vector_overhead 2))
         (size (nhash.vector-size vector))
         (rehash-bits (%make-rehash-bits hash size))   ; int here
         (index -1))
    (declare (fixnum size index vector-index))    
    (setf (nhash.vector.cache-key vector) (%unbound-marker-8))
    (%does-not-need-rehashing hash)
    (setf (nhash.puthash-count hash)(the fixnum (1+ (nhash.puthash-count hash)))) ; whazzat
    (loop
      (when (>= (incf index) size) (return))
      (setq vector-index (+ vector-index 2))
      ;(when (neq vector (nhash.vector hash)) (cerror "neq" "neq"))
      (unless (%already-rehashed-p index rehash-bits)
        (let* ((key (%svref vector vector-index))
               (value (%svref vector (the fixnum (1+ vector-index)))))
          (unless
            (when (eq key (%unbound-marker-8))
              (if (null value)  ; one less deleted entry
                (let ((count (1- (nhash.vector.deleted-count vector))))
                  (declare (fixnum count))
                  (setf (nhash.vector.deleted-count vector) count)
                  (if (< count 0)
                    (let ((wdc (nhash.vector.weak-deletions-count vector)))
                      (setf (nhash.vector.weak-deletions-count vector) 0)
                      (incf (nhash.vector.deleted-count vector) wdc)
                      (decf (nhash.count hash) wdc)))
                  (incf (nhash.grow-threshold hash))
                  (setf (%svref vector (1+ vector-index)) (%unbound-marker-8)))) ; deleted => empty
              t)
            (without-interrupts  ; shouldnt be needed ??? 
              (let ((last-index index)
                    (first t))
                (loop              
                  (when (neq 0 (%ilogand (nhash.lock hash) $nhash.lock-map-count-mask))
                    ; this happened  - hasn't since 2 paranoia fixes - one in %rehash and one in
                    ; start-hash-table-iterator?
                    (cerror "Stop rehashing." "Map count became non zero during rehash. ~s ~s"
                            (nhash.lock hash) hash)
                    (return-from  do-rehash nil))
                  (without-interrupts
                   (let ((vector (nhash.vector hash))
                         (found-index (%rehash-probe rehash-bits hash key)))
                     (%set-already-rehashed-p found-index rehash-bits)
                     (if (eq last-index found-index)
                       (return)
                       (let* ((found-vector-index (index->vector-index found-index))
                              (newkey (%svref vector found-vector-index))
                              (newvalue (%svref vector (1+ found-vector-index))))
                         (when first ; or (eq last-index index) ?
                           (setq first nil)
                           (setf (%svref vector vector-index) (%unbound-marker-8))
                           (setf (%svref vector (the fixnum (1+ vector-index))) (%unbound-marker-8)))
                         #-ppc-target (setf (%svref vector found-vector-index) key)
                         #+ppc-target (%set-hash-table-vector-key vector found-vector-index key)
                         (setf (%svref vector (the fixnum (1+ found-vector-index))) value)                       
                         (when (eq newkey (%unbound-marker-8))
                           (when (null newvalue)  ; one less deleted entry - huh
                             (let ((count (1- (nhash.vector.deleted-count vector))))
                               (declare (fixnum count))
                               (setf (nhash.vector.deleted-count vector) count)
                               (if (< count 0)
                                 (let ((wdc (nhash.vector.weak-deletions-count vector)))
                                   (setf (nhash.vector.weak-deletions-count vector) 0)
                                   (incf (nhash.vector.deleted-count vector) wdc)
                                   (decf (nhash.count hash) wdc)))
                               (incf (nhash.grow-threshold hash))))                       
                           (return))
                         (when  (eq key newkey)
                           (cerror "Delete one of the entries." "Duplicate key: ~s in ~s ~s ~s ~s ~s"
                                   key hash value newvalue index found-index)                       
                           (decf (nhash.count hash))
                           (incf (nhash.grow-threshold hash))
                           (return))
                         (setq key newkey
                               value newvalue
                               last-index found-index)))))))
              (when (%needs-rehashing-p hash)
                (return-from do-rehash nil))))))))
    t )

; Hash to an index that is not set in rehash-bits
(defun %rehash-probe (rehash-bits hash key)
  (declare (optimize (speed 3)(safety 0)))  
  (multiple-value-bind (hash-code index entries)(compute-hash-code hash key nil t)
    (declare (fixnum hash-code index entries))
    (when (null hash-code)(cerror "nuts" "Nuts"))
    (let* ((vector (nhash.vector hash))
           (vector-index (index->vector-index  index)))
      (if (or (not (%already-rehashed-p index rehash-bits))
              (eq key (%svref vector vector-index)))
        (return-from %rehash-probe index)
        (let ((second (%svref secondary-keys (%ilogand 7 hash-code))))
          (declare (fixnum second))
          (loop
            (setq index (+ index second))
            (when (>= index entries)
              (setq index (- index entries)))
            (when (or (not (%already-rehashed-p index rehash-bits))
                      (eq key (%svref vector (index->vector-index index))))
              (return-from %rehash-probe index))))))))

; Returns one value: the index of the entry in the vector
; Since we're growing, we don't need to compare and can't find a key that's
; already there.
(defun %growhash-probe (vector hash key)
  (declare (optimize (speed 3)(safety 0)))
  (multiple-value-bind (hash-code index entries)(compute-hash-code hash key nil t vector)
    (declare (fixnum hash-code index entries))
    (when (null hash-code)(cerror "nuts" "Nuts"))
    (let* ((vector-index (index->vector-index  index)))
      (declare (fixnum vector-index))
      (if (eq (%unbound-marker-8) (%svref vector vector-index))
        (return-from %growhash-probe index)
        (let ((second (%svref secondary-keys (%ilogand 7 hash-code))))
          (declare (fixnum second))
          (loop
            (setq index (+ index second))
            (when (>= index entries)
              (setq index (- index entries)))
            (when (eq (%unbound-marker-8) (%svref vector (index->vector-index index)))
              (return-from %growhash-probe index))))))))

;;;;;;;;;;;;;
;;
;; Mapping functions are in "ccl:lib;hash"
;;



;;;;;;;;;;;;;
;;
;; Hashing functions
;; EQ & the EQ part of EQL are done in-line.
;;

(defun swap (num)
  (declare (fixnum num))
  (the fixnum (+ (the fixnum (%ilsl 16 num))(the fixnum (%ilsr 13 num)))))


; Hash on address.
; If all keys are fixnums, short floats, or immediates, rehashing won't ever be necessary.
(defun %%eqhash (key)
  (let ((hash (mixup-hash-code (strip-tag-to-fixnum key))))
    (if (immediate-p-macro key)
      hash
      (values hash :key (ephemeral-p key)))))


#-ppc-target
(defun %%eqlhash-internal (key)
  (if (double-float-p key) ; do work
    (%dfloat-hash key)
    (cond ((bignump key)
           (%bignum-hash key))
          ((ratiop key)
           (logxor (swap (%%eqlhash-internal (numerator key)))
                   (%%eqlhash-internal (denominator key))))                 
          ((complexp key)
           (logxor (swap (%%eqlhash-internal (realpart key)))
                   (%%eqlhash-internal (imagpart key))))
          ((macptrp key) ; do work
           (%macptr-hash key))
          (t key))))


 ; teeny bit faster when nothing to do
#+ppc-target
(defun %%eqlhash-internal (key)
  (number-case key
    (fixnum (mixup-hash-code key)) ; added this 
    (double-float (%dfloat-hash key))
    (short-float (%sfloat-hash key))
    (bignum (%bignum-hash key))
    (ratio (logxor (swap (%%eqlhash-internal (numerator key)))
                   (%%eqlhash-internal (denominator key))))
    (complex
     (logxor (swap (%%eqlhash-internal (realpart key)))
             (%%eqlhash-internal (imagpart key))))
    (t (cond ((macptrp key)
              (%macptr-hash key))
             (t key)))))

               


; new function

(defun %%eqlhash (key)
; if key is a macptr, float, bignum, ratio, or complex, convert it to a fixnum
  (if (immediate-p-macro key)
    (%%eqhash key)
    (let ((primary  (%%eqlhash-internal key)))
      (if (eq primary key)
        (%%eqhash key)
        (mixup-hash-code (strip-tag-to-fixnum primary))))))

;; call %%eqlhash

(defun %%equalhash (key)
  (flet ((string-hash (key start len)
           (declare (fixnum start len))
           (let* ((res len))
             (dotimes (i len)
               (let ((code (%scharcode key (%i+ i start))))
                 ; not same as lappy one 
                 (setq code (mixup-hash-code code))
                 (setq res (%i+ (rotate-hash-code res) code))))
             res)))
  (let* ((immediate-p (immediate-p-macro key))
         (hash (if (and key (not immediate-p)) (%%eqlhash-internal key)))
         addressp
         ephemeral-p)
    (cond ((null key) (mixup-hash-code 17))
          (immediate-p (mixup-hash-code (strip-tag-to-fixnum key)))
          ((and hash (neq hash key)) hash)  ; eql stuff
          (t (typecase key
                (simple-string (string-hash key 0 (length key)))
                (string
                 (let ((length (length key)))
                   (multiple-value-bind (data offset) (array-data-and-offset key)
                     (string-hash data offset length))))
                (bit-vector (bit-vector-hash key))                
                (cons
                 (let ((hash 0))
                   (do* ((i 0 (1+ i))
                         (list key (cdr list)))
                        ((or (not (consp list)) (> i 11))) ; who figured 11?
                     (declare (fixnum i))
                     (multiple-value-bind (h1 a1 e1) (%%equalhash (%car list))
                       (when a1 (setq addressp t))
                       (when e1 (setq ephemeral-p t))
                       ; fix the case of lists of same stuff in different order
                       ;(setq hash (%ilogxor (fixnum-rotate h1 i) hash))
                       (setq hash (%i+ (rotate-hash-code hash) h1))
                       ))
                   (values hash addressp ephemeral-p)))
                (pathname (%%equalphash key))
                (t (%%eqlhash key))))))))

; so whats so special about bit vectors as opposed to any other vectors of bytes
; For starters, it's guaranteed that they exist in the implementation; that may
; not be true of other immediate vector types.
(defun bit-vector-hash (bv)
  (declare (optimize (speed 3)(safety 0)))
  (let ((length (length bv)))
    (declare (fixnum length)) ;will this always be true? it's true of all vectors.
    (multiple-value-bind (data offset) (array-data-and-offset bv)
      (declare (type simple-bit-vector data) (fixnum offset))
      (let* ((hash 0)
             (limit (+ length offset))
             (nbytes (ash (the fixnum (+ length 7)) -3)))
        (declare (fixnum hash limit nbytes))
        (dotimes (i nbytes (mixup-hash-code hash))
          (let* ((w 0))
            (declare (fixnum w))
            (dotimes (j 8 (setq hash (+ (the fixnum (ash hash -3))  w)))
              (setq w (the fixnum
                        (logxor
                         (the fixnum
                           (ash (if (< offset limit) 
                                  (the fixnum (sbit data offset))
                                  0)
                                (the fixnum j)))
                         w)))
              (incf offset))))))))

#|
(defun bit-vector-hash (bv)
  (declare (optimize (speed 3)(safety 0)))
  (let ((length (length bv)))
    (declare (fixnum length))
    (let* ((all (+ length 15))
           (nwds (ash all -4))
           (rem (logand all 15))
           (hash 0)
           (mask (ash (the fixnum (1- (the fixnum (expt 2 rem))))(the fixnum(- 16 rem)))))
      (declare (fixnum all nwds rem hash mask))
      (multiple-value-bind (data offset)
                           (array-data-and-offset bv)
        (declare (fixnum offset))
        (locally (declare (type (simple-array (unsigned-byte 16) (*)) data))
          (dotimes (i nwds)
            (setq hash (%i+ hash (aref data (the fixnum (+ i offset))))))
          (when (neq 0 mask)            
            (setq hash (%i+ hash (%ilogand mask (aref data (the fixnum (+ offset nwds)))))))
          (mixup-hash-code hash))))))
|#


; Same as %%equalhash, but different:
;  1) Real numbers are hashed as if they were double-floats.  The real components of complex numbers
;     are hashed as double-floats and XORed together.
;  2) Characters and strings are hashed in a case-insensitive manner.
;  3) Hash tables are hashed based on their size and type.
;  4) Structures and CL array types are hashed based on their content.


; check fixnum befor immediate-p. call %%eqlhash

(defun %%equalphash (key)
  ; typecase anyone?
  (flet ((string-hash (key start len)
           (declare (fixnum start len))
           (let* ((res len))
             (dotimes (i len)
               (let* ((char (%schar key (%i+ i start)))
                      (code (char-code (char-upcase char))))
                 ; not same as lappy one 
                 (setq code (mixup-hash-code code))
                 (setq res (%i+ (rotate-hash-code res) code))))
             res)))
    (cond ((or (fixnump key)(short-float-p key))
           (%dfloat-hash (float key 1.0d0))) 
          ((immediate-p-macro key)
           (mixup-hash-code (strip-tag-to-fixnum (if (characterp key)(char-upcase key) key))))
          ((bignump key)
           (if (<= most-negative-double-float key most-positive-double-float)
             (%dfloat-hash (float key 1.0d0))  ; with-stack-double-floats
             (%%eqlhash-internal key)))
          ((double-float-p key)
           (%dfloat-hash key))
          ((ratiop key)
           (%ilogxor (%%equalphash (numerator key)) (%%equalphash (denominator key))))
          ((complexp key)
           (%ilogxor (%%equalphash (realpart key)) (%%equalphash (imagpart key))))
          ((hash-table-p key)
           (equalphash-hash-table key))
          ((or (istructp key)
               (structurep key))  ; was (gvectorp key)
           (%%equalphash-structure 11 key))
          ((stringp key)
           (let ((length (length key)))
             (if (simple-string-p key)
               (string-hash key 0 length)
               (multiple-value-bind (array offset)(array-data-and-offset key)
                 (string-hash array offset length)))))
          ((or (arrayp key)) ;(uvectorp key)) ;??
           (%%equalphash-array 11 key))
          ((consp key)
           (%%equalphash-aux 11 key))
          (t (%%eqlhash key)))))


(defun equalphash-hash-table (hash-table)
  (let ((hash (%%equalhash "HASH-TABLE"))
        addressp ephemeral-p)
    (declare (fixnum hash))
    (incf hash (the fixnum (%%eqhash (hash-table-count hash-table))))
    (multiple-value-bind (h ap ep) (%%eqhash (nhash.comparef hash-table))
      (declare (fixnum h))
      (incf hash h)
      (if ap (setq addressp t))
      (if ep (setq ephemeral-p t)))
    (multiple-value-bind (h ap ep) (%%eqhash (nhash.keytransF hash-table))
      (declare (fixnum h))
      (incf hash h)
      (if ap (setq addressp t))
      (if ep (setq ephemeral-p t)))
    (if (or addressp ephemeral-p)
      (values hash addressp ephemeral-p)
      hash)))

(defun %%equalphash-structure (limit key)
  (let* ((size (uvsize key))
         (hash (mixup-hash-code size))
         addressp ephemeral-p)
    (declare (fixnum limit size hash))
    (dotimes (i size)
      (multiple-value-bind (h ap ep) (%%equalphash-aux limit (%svref key i))
        (declare (fixnum h))
        (setq hash (the fixnum (+ (the fixnum (rotate-hash-code hash)) h)))
        (if ap (setq addressp t))
        (if ep (setq ephemeral-p t)))
      (when (<= (decf limit) 0)
        (setq hash (the fixnum (+ (the fixnum (rotate-hash-code hash))
                                  #.(mixup-hash-code 11))))
        (return)))
    (if (or addressp ephemeral-p)
      (values hash addressp ephemeral-p)
      hash)))

(defun %%equalphash-array (limit key)
  (multiple-value-bind (array offset) (array-data-and-offset key)
    (let* ((rank (array-rank key))
           (vectorp (eql rank 1))
           (size (if vectorp (length key) (array-total-size key)))
           (hash (mixup-hash-code rank))
           addressp ephemeral-p)
      (declare (fixnum size hash limit rank))
      (if vectorp
        (setq hash
              (the fixnum
                   (+ (the fixnum (rotate-hash-code hash))
                      (the fixnum (mixup-hash-code size)))))
        (dotimes (i rank)
          (declare (fixnum i))
          (setq hash
                (the fixnum 
                     (+ (the fixnum (rotate-hash-code hash))
                        (the fixnum
                             (mixup-hash-code (array-dimension key i))))))))      
      (dotimes (i size)
        (declare (fixnum i))
        (multiple-value-bind (h ap ep) (%%equalphash-aux limit (uvref array offset))
          (declare (fixnum h))
          (setq hash (the fixnum (+ (the fixnum (rotate-hash-code hash)) h)))
          (if ap (setq addressp t))
          (if ep (setq ephemeral-p t)))
        (when (<= (decf limit) 0)
          (setq hash (the fixnum (+ (the fixnum (rotate-hash-code hash))
                                    #.(mixup-hash-code 11))))
          (return))
        (incf offset))
      (if (or addressp ephemeral-p)
        (values hash addressp ephemeral-p)
        hash))))



(defun %%equalphash-aux (limit key)
  (if (<= limit 0) 
    #.(mixup-hash-code 11)
    (if (null key) #.(mixup-hash-code 17)
        (cond ((consp key)
               (let ((hash 0)
                     address-p ephemeral-p)
                 (do ((l limit (1- l)))
                     ((eq l 0)(values hash address-p ephemeral-p))
                   (multiple-value-bind (ahash ap ep)
                                        (%%equalphash-aux l (if (consp key)(car key) key))
                     (setq hash (mixup-hash-code (logxor ahash hash)))
                     (if ap (setq address-p t))
                     (if ep (setq ephemeral-p t)))
                   (when (not (consp key))
                     (return (values hash address-p ephemeral-p)))
                   (setq key (cdr key)))))
              ((hash-table-p key)
               (equalphash-hash-table key))
              ; what are the dudes called that contain bits? they are uvectors but not gvectors?
              ; ivectors.
              ((or (istructp key)
                   (structurep key))    ;was (gvectorp key)
               (%%equalphash-structure limit key))
              ((or (arrayp key))  ; (uvectorp key))
               (%%equalphash-array limit key))
              (t (%%equalphash key))))))

(defun alist-hash-table (alist &rest hash-table-args)
  (declare (dynamic-extent hash-table-args))
  (if (typep alist 'hash-table)
    alist
    (let ((hash-table (apply #'make-hash-table hash-table-args)))
      (dolist (cons alist) (puthash (car cons) hash-table (cdr cons)))
      hash-table)))

(defun %hash-table-equalp (x y)
  ; X and Y are both hash tables
  (let* ((test (hash-table-test x)))
    (and (eq test
             (hash-table-test y))
         (eql (hash-table-count x)
              (hash-table-count y))
         (block nil
           (let* ((default (cons nil nil))
                  (foo #'(lambda (k v)
                           (let ((y-value (gethash k y default)))
                             (unless (and (neq default y-value)
                                          (funcall test v y-value))
                               (return nil))))))
             (declare (dynamic-extent foo default))
             (maphash foo x))
           t))))

(defun sxhash (s-expr)
  "Computes a hash code for S-EXPR and returns it as an integer."
  (logand (sxhash-aux s-expr 7 17) most-positive-fixnum))
#|
(defun sxhash-aux (expr counter key)
  (declare (fixnum counter key))
  (declare (fixnum counter))
  ; key often not fixnum
  ;(when (bignump key) (print (list 'big key)))
  ;(setq key (logand key most-positive-fixnum))
  (if (> counter 0)
    (typecase expr
      ((or string bit-vector number vector array standard-instance)  (%i+ key (%%equalhash expr)))
      ((or pathname logical-pathname)
       (dotimes (i (uvsize expr) key)
         (declare (fixnum i))
         (setq key (%i+ key (sxhash-aux (%svref expr i) (1- counter) key)))))
      (symbol (%i+ key (%%equalhash (symbol-name expr))))
      (cons (sxhash-aux
             (cdr expr)
             (the fixnum (1- counter))             
             (%i+ key (sxhash-aux (car expr) (the fixnum (1- counter)) key))))
      (t (%i+ counter key
            (%%equalhash (symbol-name (%type-of expr))))))
    key))
|#

(defun sxhash-aux (expr counter key)
  (declare (fixnum counter key))
  (declare (fixnum counter))
  ; key often not fixnum
  ;(when (bignump key) (print (list 'big key)))
  ;(setq key (logand key most-positive-fixnum))
  (if (> counter 0)
    (typecase expr       
      ((or string bit-vector number)   (%i+ key (%%equalhash expr)))       
      ((or pathname logical-pathname)
              (dotimes (i (uvsize expr) key)
                (declare (fixnum i))
                (setq key (%i+ key (sxhash-aux (%svref expr i) (1- counter) key)))))
      (symbol (%i+ key (%%equalhash (symbol-name expr))))
      (cons (sxhash-aux
                    (cdr expr)
                    (the fixnum (1- counter))             
                    (%i+ key (sxhash-aux (car expr) (the fixnum (1- counter)) key))))
      (macptr (%i+ key (%%eqlhash expr)))
      (t (cond ((immediate-p-macro expr)
                (%i+ (rotate-hash-code key) (mixup-hash-code (strip-tag-to-fixnum expr))))
               ((or (structurep expr)(istructp expr)) (%i+ (rotate-hash-code key) (sxhash-structure expr counter key)))
               ((arrayp expr)(setq key (%i+ (rotate-hash-code key) (sxhash-array expr counter key))))
               ((standard-instance-p expr) (%i+ key (sxhash-structure expr counter key)))
               (t (%i+ counter key (%%equalhash (symbol-name (%type-of expr))))))))
      key))

(defun sxhash-structure (expr limit hash)
  (let* ((size (uvsize expr)))
    (declare (fixnum limit size hash))
    (dotimes (i size)
      (setq hash (sxhash-aux (%svref expr i) limit hash))
      (when (<= (decf limit) 0)
        (setq hash (the fixnum (+ (the fixnum (rotate-hash-code hash))
                                  #.(mixup-hash-code 11))))
        (return)))
      hash))

(defun sxhash-array (key limit hash)
  (declare (fixnum limit hash))
  (multiple-value-bind (array offset) (array-data-and-offset key)
    (let* ((rank (array-rank key))
           (vectorp (eql rank 1))
           (size (if vectorp (length key) (array-total-size key))))
      (declare (fixnum size hash limit rank))
      (setq hash (%i+ hash (mixup-hash-code rank)))
      (if vectorp
        (setq hash
              (the fixnum
                (+ (the fixnum (rotate-hash-code hash))
                   (the fixnum (mixup-hash-code size)))))
        (dotimes (i rank)
          (declare (fixnum i))
          (setq hash
                (the fixnum 
                  (+ (the fixnum (rotate-hash-code hash))
                     (the fixnum
                       (mixup-hash-code (array-dimension key i))))))))      
      (dotimes (i size)
        (declare (fixnum i))
        (setq hash (sxhash-aux (uvref array offset) limit hash))
        (when (<= (decf limit) 0)
          (setq hash (the fixnum (+ (the fixnum (rotate-hash-code hash))
                                    #.(mixup-hash-code 11))))
          (return))
        (incf offset))
      hash)))






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Support for locking hash tables while fasdumping is in "ccl:lib;hash"
;;

;; "Weak table" stuff - which may or may not be just taking up space -
;; is there as well.
#| ; testing 1 2 3
(defvar *p1 nil)
(defvar *p2 nil)
(defvar *hash nil)

(setq *p1  (make-process "P1" :background-p t))
(setq *p2 (make-process "P2" :background-p t))
(setq *hash (make-hash-table :size 10))
(process-preset *p1 #'(lambda ()
                        (loop
                          (dotimes (i 100)
                            (setq *hash (make-hash-table :size 10))
                            (dotimes (i 2000)
                              (puthash (cons (gensym) i) *hash i)
                              (when (and (eq 0 (mod i 10))(eq 0 (nhash.lock *hash)))
                                ;(incf crud)
                                ;(%rehash *hash)
                                )
                              ;(when (eq 0 (mod i 500)) (gc))
                              )))))
(process-preset *p2 #'(lambda ()
                        (loop
                          (dotimes (i 400)
                            (let ((hash *hash))
                              (setq it nil)
                              (dotimes (i 200)
                                (setq it (cons i it)))
                              (sleep .1) ; fewer locked additions, more need to linear-probe
                              
                              (let  ((poo 0))
                                (maphash #'(lambda (a b)
                                             (setq it (cons (cons a b) it))
                                             (let ((c (gethash a hash)))
                                               (when (neq c b)                                               
                                                 (format t "~&test failing ~s ~s ~s ~x ~s" a b c 
                                                         (nhash.lock hash) hash)))
                                             (incf poo)
                                             (when (eq 0 (mod poo 5))                                               
                                               (remhash a hash)
                                               (if (gethash a hash) (format t "~&remhash puked"))))
                                         hash)))))))
    
(process-enable *p1)
(process-enable *p2)
|#

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
