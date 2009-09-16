;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: hashenv.lisp,v $
;;  Revision 1.4  2003/12/08 08:19:22  gtbyers
;;  Lose lots of 68K-ness.
;;
;;  3 5/20/96  akh  add immediate-p-macro
;;  (do not edit before this line!!)


;; 06/06/99 akh  add $nhash.lock-clear

(eval-when (:compile-toplevel :execute)


; undistinguished values of nhash.lock
(defconstant $nhash.lock-while-growing #x10000)
(defconstant $nhash.lock-while-rehashing #x20000)
(defconstant $nhash.lock-clear #x40000)

(defconstant $nhash.lock-grow-or-rehash #x30000)
(defconstant $nhash.lock-map-count-mask #xffff)
(defconstant $nhash.lock-not-while-rehashing #x-20001)

; The hash.vector cell contains a vector with 8 longwords of overhead
; followed by alternating keys and values.
; A key of $undefined denotes an empty or deleted value
; The value will be $undefined for empty values, or NIL for deleted values.
(def-accessors () %svref
  nhash.vector.link                     ; GC link for weak vectors
  nhash.vector.flags                    ; a fixnum of flags
  nhash.vector.free-alist               ; empty alist entries for finalization
  nhash.vector.finalization-alist       ; deleted out key/value pairs put here
  nhash.vector.weak-deletions-count     ; incremented when the GC deletes an element
  nhash.vector.hash                     ; back-pointer
  nhash.vector.deleted-count            ; number of deleted entries
  nhash.vector.cache-idx                ; index of last cached key/value pair
  nhash.vector.cache-key                ; cached key
  nhash.vector.cache-value              ; cached value
  )


(defconstant $nhash_weak_bit 12)        ; weak hash table
(defconstant $nhash_weak_value_bit 11)  ; weak on value vice key if this bit set
(defconstant $nhash_finalizeable_bit 10)
(defconstant $nhash_weak_flags_mask
  (bitset $nhash_weak_bit (bitset $nhash_weak_value_bit (bitset $nhash_finalizeable_bit 0))))

(defconstant $nhash_track_keys_bit 28)  ; request GC to track relocation of keys.
(defconstant $nhash_key_moved_bit 27)   ; set by GC if a key moved.
(defconstant $nhash_ephemeral_bit 26)   ; set if a hash code was computed using an address
                                        ; in ephemeral space
(defconstant $nhash_component_address_bit 25)
                                        ; a hash code was computed from a key's component

(defconstant $nhash.vector_overhead 10)


(defconstant $nhash-growing-bit 16)
(defconstant $nhash-rehashing-bit 17)

)
   
(defmacro immediate-p-macro (thing) ; boot weirdness
  (if (ppc-target-p)
    `(let* ((tag (ppc-lisptag ,thing)))
       (declare (fixnum tag))
       (or (= tag ppc::tag-fixnum)
           (= tag ppc::tag-imm)))
    `(dtagp ,thing (logior (ash 1 $t_fixnum)
                           (ash 1 $t_sfloat)
                           (ash 1 $t_imm)))))



; state is #(index vector hash-table saved-lock)
(def-accessors %svref
  hti.index
  hti.vector
  hti.hash-table
  hti.lock
  hti.locked-additions)


