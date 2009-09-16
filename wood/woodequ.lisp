;;;-*- Mode: Lisp; Package: WOOD -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; woodequ.lisp
;; Data representation constants
;; Largely copied from "ccl:library;lispequ.lisp"
;;
;; Copyright © 1996 Digitool, Inc.
;; Copyright © 1992-1995 Apple Computer, Inc.
;; All rights reserved.
;; Permission is given to use, copy, and modify this software provided
;; that Digitool is given credit in all derivative works.
;; This software is provided "as is". Digitool makes no warranty or
;; representation, either express or implied, with respect to this software,
;; its quality, accuracy, merchantability, or fitness for a particular
;; purpose.
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; -------------- 0.96
;; -------------- 0.95
;; 05/09/96 bill  use addr+ in dc-%arrayh-xxx
;; -------------- 0.94 = MCL-PPC 3.9
;; 03/21/96 bill  add $v_xstr
;; -------------- 0.93
;; -------------- 0.9
;; 01/18/95 bill  $btree.max-key-size
;; -------------- 0.8
;; 03/27/93 bill  $forwarding-pointer-header
;; -------------- 0.6
;; 08/27/92 bill  $v_load-function
;; 08/24/92 bill  $btree-type_string-equal-bit, $btree-type_string-equal
;;                (these are not yet supported by the btree code)
;; -------------- 0.5
;; 06/23/92 bill  persistent-clos equates, btree type bits
;; -------------- 0.1
;;


(in-package :wood)

; low 3 bits of an address are the tag.

(defmacro pointer-tag (pointer)
  `(the fixnum (logand ,pointer 7)))

(defmacro pointer-tagp (pointer tag)
  `(eql (pointer-tag ,pointer) ,tag))
            
(defmacro pointer-address (pointer)
  `(logand ,pointer -8))

(defconstant $t_fixnum 0)
(defconstant $t_vector 1)
(defconstant $t_symbol 2)
(defconstant $t_dfloat 3)
(defconstant $t_cons 4)
(defconstant $t_sfloat 5)
(defconstant $t_lfun 6)
(defconstant $t_imm 7)

; Non-cons cells have a header long-word for the garbage collector.
(defconstant $vector-header #x1ff)
(defconstant $symbol-header #x8ff)
; Need to find a value that can't be the first word of a float
(defconstant $forwarding-pointer-header #xfff)

; Vectors are a longword of block header, 1 byte of subtype, 3 bytes of length (in bytes)
; then the contents.
;
;  -------------------
; | 00 | 00 | 01 | FF |
; |-------------------|
; | ST |    Length    |
; |-------------------|
; |     Contents      |
; |         .         |
; |         .         |
; |         .         |
;  -------------------

; Array subtypes. Multiply by two to get the MCL subtype
;(defconstant $v_packed_sstr 0)          ; used in image loader/dumper
(defconstant $v_bignum 1)
(defconstant $v_macptr 2)
(defconstant $v_badptr 3)
(defconstant $v_nlfunv 4)               ; Lisp FUNction vector
;subtype 5 unused
(defconstant $v_xstr 6)      ;16-bit character vector
(defconstant $v_min_arr 7)
(defconstant $v_ubytev 7)    ;unsigned byte vector
(defconstant $v_uwordv 8)    ;unsigned word vector
(defconstant $v_floatv 9)    ;float vector
(defconstant $v_slongv 10)   ;Signed long vector
(defconstant $v_ulongv 11)   ;Unsigned long vector
(defconstant $v_bitv 12)     ;Bit vector
(defconstant $v_sbytev 13)   ;Signed byte vector
(defconstant $v_swordv 14)   ;Signed word vector
(defconstant $v_sstr 15)     ;simple string
(defconstant $v_genv 16)     ;simple general vector
(defconstant $v_arrayh 17)   ;complex array header
(defconstant $v_struct 18)   ;structure
(defconstant $v_mark 19)     ;buffer mark
(defconstant $v_pkg 20)
;subtype 21 unused
(defconstant $v_istruct 22)
(defconstant $v_ratio 23)
(defconstant $v_complex 24)
(defconstant $v_instance 25) ;clos instance
; subtypes 26, 27, 28 unused.
(defconstant $v_weakh 29)
(defconstant $v_poolfreelist 30)
(defconstant $v_nhash 31)

; Types that exist only in the database
(defconstant $v_area 32)                ; area descriptor
(defconstant $v_segment 33)             ; area segment
(defconstant $v_random-bits 34)         ; used for vectors of random bits, e.g. resources
(defconstant $v_dbheader 35)            ; database header
(defconstant $v_segment-headers 36)     ; Segment headers page.
(defconstant $v_btree 37)               ; a BTREE
(defconstant $v_btree-node 38)          ; one node of a BTREE's tree.
(defconstant $v_class 39)               ; class
(defconstant $v_load-function 40)       ; result of P-MAKE-LOAD-FUNCTION-OBJECT
(defconstant $v_pload-barrier 41)       ; result of P-MAKE-PLOAD-BARRIER

(defconstant $v_link (- $t_vector))
(defconstant $V_SUBTYPE 3)
(defconstant $V_DATA 7)
(defconstant $V_LOG 3)
(defconstant $vector-header-size 8)

(defconstant $vnodebit 5)               ; set for arrays containing pointers
(defconstant $vnode (lsh 1 $vnodebit))

; NIL is tagged as a cons with and address of 0
(defconstant $pheap-nil $t_cons)

(defmacro def-indices (&body indices)
  (let ((index 0)
        res)
    (dolist (spec indices)
      (labels ((f (spec)
                 (etypecase spec
                   (symbol (push `(defconstant ,spec ,index) res))
                   (list (dolist (sub-spec spec)
                           (f sub-spec))))))
        (declare (dynamic-extent f))
        (f spec)
        (incf index)))
    `(progn ,@(nreverse res))))

; Symbols are not regular vectors.
(defconstant $sym_header -2)            ; $symbol-header
(defconstant $sym_pname 2)
(defconstant $sym_package 6)
(defconstant $sym_values 10)            ; place for (value function . plist)
(defconstant $symbol-size 16)

; Packages do not support inheritance.
; maybe they should.
(def-indices
  $pkg.names
  $pkg.btree
  $pkg-length)

; Weak lists. Subtype $v_weakh
(def-indices
  $population.gclink
  $population.type
  $population.data
  $population-size)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; A PHEAP file starts with a single vector containing
;; the root objects and the file-wide information.
;;
(defconstant $block-overhead 8)         ; commit-lsn + segment-ptr
(defconstant $block-commit-lsn 0)
(defconstant $block-segment-ptr 4)

(defconstant $root-vector (+ $block-overhead $t_vector))

(def-indices
  $pheap.version                        ; version number
  $pheap.free-page                      ; free pointer in pages
  $pheap.root                           ; root object
  $pheap.default-consing-area           ; a pointer to an area descriptor
  $pheap.class-hash                     ; class hash table
  $pheap.page-size                      ; size of a page in bytes
  $pheap.btree-free-list                ; head of linked list of btree nodes
  $pheap.package-btree                  ; string->package table
  $pheap.page-write-count               ; pages written since open
  $pheap-free9
  $pheap-free10
  $pheap-free11
  $pheap-free12
  $pheap-free13
  $pheap-free14
  $pheap-free15
  $pheap-header-size
  )

; A segment headers page header. Subtype is $v_segment-headers
; The header in the first page of headers for an area
; contains the $area.xxx information as well.
(def-indices
  $segment-headers.area                 ; my area
  $segment-headers.link                 ; next segment headers page
  $area.flags                           ; fixnum
  $area.segment-size                    ; default size for segments
  $area.last-headers                    ; last segment headers page
  $area.free-count                      ; number of headers left in $area.last-headers
  $area.free-ptr                        ; cons pointing at current header
  $area-descriptor-size
  )

(defconstant $segment-headers-size $area.flags)

; A segment header page entry
; Pointers to these are typed as conses
(defconstant $segment-header_free -4)   ; pointer to free space. Tagged as a cons
(defconstant $segment-header_freebytes 0)       ; number of bytes left
(defconstant $segment-header_free-link 4)       ; header entry with free space
(defconstant $segment-header_segment 8)         ; beginning of the segment
(defconstant $segment-header-entry-bytes (* 4 4))       ; must be a multiple of 8

; The header of a segment. Subtype is $v_segment
; This vector contains all other types of objects
(def-indices
  $segment.area                         ; my area
  $segment.header                       ; my header entry
  $segment-header-size
  )

; Complex array headers
; Copied from lispequ.
(def-indices
  $arh.fixnum
  $arh.offs
  $arh.vect
  ($arh.vlen $arh.dims)
  $arh.fill)

;byte offsets in arh.fixnum slot.
(defconstant $arh_rank4 0)		;4*rank
(defconstant $arh_type 2)		;vector subtype
(defconstant $arh_bits 3)		;Flags

(defconstant $arh_one_dim 4)		;arh.rank4 value of one-dim arrays

;Bits in $arh_bits.
(defconstant $arh_adjp_bit 7)		;adjustable-p
(defconstant $arh_fill_bit 6)		;fill-pointer-p
(defconstant $arh_disp_bit 5)		;displaced to another array header -p
(defconstant $arh_simple_bit 4)		;not adjustable, no fill-pointer and
					; not user-visibly displaced -p

(defmacro dc-%arrayh-bits (disk-cache pointer)
  (setq disk-cache (require-type disk-cache 'symbol))
  `(the fixnum
        (read-8-bits ,disk-cache
                     (addr+ ,disk-cache
                            ,pointer
                            (+ $v_data (* 4 $arh.fixnum) $arh_bits)))))

(defmacro dc-%arrayh-type (disk-cache pointer)
  (setq disk-cache (require-type disk-cache 'symbol))
  `(the fixnum
        (read-8-bits ,disk-cache
                     (addr+ ,disk-cache
                            ,pointer
                            (+ $v_data (* 4 $arh.fixnum) $arh_type)))))

(defmacro dc-%arrayh-rank4 (disk-cache pointer)
  (setq disk-cache (require-type disk-cache 'symbol))
  `(the fixnum
        (read-unsigned-word
         ,disk-cache
         (addr+ ,disk-cache
                ,pointer
                (+ $v_data (* 4 $arh.fixnum) $arh_rank4)))))

(defmacro arh.fixnum_type-bytespec ()
  (byte 8 5))

(defmacro arh.fixnum_type (fixnum)
  `(ldb (arh.fixnum_type-bytespec) ,fixnum))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; btree vector - subtype $v_btree
;;;
(def-indices
  $btree.root                           ; the root node
  $btree.count                          ; number of leaf entries
  $btree.depth                          ; 0 means only the root exists
  $btree.nodes                          ; total number of nodes
  $btree.first-leaf                     ; first leaf node. A constant
  $btree.type                           ; type bits
  $btree.max-key-size                   ; maximum size of a key
  $btree-size                           ; length of a $v_btree vector
  )

;; Btree type bits
(defconstant $btree-type_eqhash-bit 0)          ; EQ hash table
(defconstant $btree-type_weak-bit 1)    ; weak hash table
(defconstant $btree-type_weak-value-bit 2)      ; weak on value, not key
(defconstant $btree-type_string-equal-bit 3)    ; use string-equal, not string=

; Btree type values
(defconstant $btree-type_normal 0)      ; normal string->value btree
(defconstant $btree-type_string-equal (ash 1 $btree-type_string-equal-bit))
(defconstant $btree-type_eqhash (ash 1 $btree-type_eqhash-bit))
(defconstant $btree-type_eqhash-weak-key
  (+ $btree-type_eqhash (ash 1 $btree-type_weak-bit)))
(defconstant $btree-type_eqhash-weak-value
  (+ $btree-type_eqhash-weak-key (ash 1 $btree-type_weak-value-bit)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Persistent CLOS equates
;;;

; subtype $v_instance
(def-indices
  $instance.wrapper                     ; class wrapper
  $instance.slots                       ; slots vector
  $instance-size)

; A wrapper is a regular general vector
(def-indices
  $wrapper.class
  $wrapper.slots                        ; vector of slot names
  $wrapper-size)

; subtype $v_class
(def-indices
  $class.name
  $class.own-wrapper
  $class-size)

(defmacro %unbound-marker ()
  (ccl::%unbound-marker-8))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; $v_load-function subtype
;;;
(def-indices
  $load-function.load-list              ; load-function.args
  $load-function.init-list              ; init-function.args
  $load-function-size)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; $v_pload-barrier subtype
;;;

(def-indices
  $pload-barrier.object
  $pload-barrier-size)


(provide :woodequ)
;;;    1   3/10/94  bill         1.8d247
;;;    2   7/26/94  Derek        1.9d027
;;;    2   2/18/95  RŽti         1.10d019
;;;    3   3/23/95  bill         1.11d010
