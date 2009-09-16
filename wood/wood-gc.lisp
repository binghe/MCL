;;;-*- Mode: Lisp; Package: WOOD -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; wood-gc.lisp
;;
;; A copying garbage collector for Wood
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
;; 09/05/98 akh add another argument to gc-pheap-file. :delay-gvector-copy
;;               If true gvectors are forwarded and copying the contents is enqueued.
;;               Avoid blowing the stack for databases of recursively connected small objects.
;;               May blow the queue for databases containing just a few very large objects.
;; 08/28/98 akh remove declare (optimize debug) from gc-copy-cons-internal ?? 
;; ------------- 0.96
;; ------------- 0.95
;; ------------- 0.94
;; 03/21/96 bill (make-string ... :element-type 'base-character)
;; ------------- 0.93
;; 05/25/95 bill gc-pheap-file-internal takes a new :page-size arg, which is used
;;               as the page-size for the new, compacted, pheap. It returns true
;;               if the new page size is different than the old one.
;;               gc-pheap-file's args, except the first one, are now keywords instead
;;               of optional. This is an incompatible change.
;;               It takes a new :page-size arg which is passes on to gc-pheap-file-internal.
;;               The new file replaces the old if either the page size changed or it is smaller.
;; ------------  0.9
;; 11/02/94 ows  gc-pheap-file-internal takes keyword argument modify-input-file;
;;               when true, calls make-forwarding-table instead of open-dc-log.
;;               gc-pheap-file-internal copies the mac-file-creator from the input
;;               file to the output file.
;;               gc-pheap-file takes optional argument modify-input-file
;;               gc-pheap-file only swaps files when the size is smaller.
;;               new fns make-forwarding-table, forwarding-table-p
;;               gc-write-forwarding-pointer, address-forwarded-p check whether
;;               the log is a forwarding table.
;;               new fns address-forwarded-p, read-forwarded-pointer replace
;;               inlined versions of this code in callers.
;;               gc-copy-pkg-symbols, gc-copy-ptr, gc-copy-cons-internal
;;               call address-forwarded-p, read-forwarded-pointer.
;; 09/26/94 bill gc-copy-bytes uses addr+ instead of incf.
;;               Thanx to Christopher T. Wisdo for finding this.
;; ------------- 0.8
;; 03/27/93 bill New file. Doesn't yet deal with consing areas.
;;               Also doesn't delete anything from weak hash tables.
;;

(in-package :wood)

(defvar *delay-gvector-copy* nil)

(defun gc-pheap-file (filename &key
                                  (external-format :WOOD)
                                  (modify-input-file nil)
                                  (delay-gvector-copy nil)
                                  (page-size nil))
  (let ((output-filename (ccl::gen-file-name filename))
        (*delay-gvector-copy* delay-gvector-copy))
    (unwind-protect
      (let ((page-size-changed?
             (gc-pheap-file-internal filename output-filename
                                     :external-format external-format
                                     :modify-input-file modify-input-file
                                     :page-size page-size)))
        (flet ((file-size (file)
                 (with-open-file (stream file) (file-length stream))))
          (when (or page-size-changed? (< (file-size output-filename) (file-size filename)))
            (unless (eql 0 (ccl::exchange-files filename output-filename))
              (rename-file output-filename filename :if-exists :overwrite)))))
      (delete-file output-filename))))
      
(defun gc-pheap-file-internal (input-filename output-filename &key 
                                                  temp-filename
                                                  (external-format :WOOD)
                                                  (modify-input-file t)
                                                  page-size
                                                  &aux page-size-changed?)
  (when (probe-file output-filename)
    (error "~s already exists" output-filename))
  (when temp-filename
    (when (probe-file temp-filename)
      (error "~s already exists" temp-filename)))
  (with-open-pheap (input-pheap input-filename :external-format external-format)
    (let ((old-page-size (disk-cache-page-size (pheap-disk-cache input-pheap))))
      (if page-size
        (unless (eql page-size old-page-size)
          (setq page-size-changed? t))
        (setq page-size old-page-size)))
    (with-open-pheap (output-pheap output-filename
                                   :mac-file-creator (mac-file-creator input-filename)
                                   :external-format external-format
                                   :page-size page-size
                                   :if-does-not-exist :create)
      (if modify-input-file
        (progn
          (unless temp-filename
            (setq temp-filename (ccl::gen-file-name input-filename)))
          (let ((log (open-dc-log temp-filename (pheap-disk-cache input-pheap)))
                (q (make-q)))
            (log-position log 0)
            (unwind-protect
              (do-wood-gc input-pheap output-pheap log q)
              (without-interrupts
               (restore-from-log-after-gc input-pheap log))
              (close-dc-log log)
              (delete-file temp-filename))))
        (let ((forwarding-table (make-forwarding-table))
              (q (make-q)))
          (do-wood-gc input-pheap output-pheap forwarding-table q)))))
  page-size-changed?)

;; new type
(deftype forwarding-table ()
  ;; The car is a hash-table mapping address -> immediate-value.
  ;; The cdr is a hash-table mapping address -> pointer-value.
  'cons)

;; new macro
(defmacro forwarding-table-immediates (forwarding-table)
  `(car ,forwarding-table))

;; new macro
(defmacro forwarding-table-pointers (forwarding-table)
  `(cdr ,forwarding-table))

;; new function
(defun make-forwarding-table ()
  (cons (make-hash-table :test 'eql)
        (make-hash-table :test 'eql)))

;; new function
(defun forwarding-table-p (log-or-table)
  (typep log-or-table 'forwarding-table))

(defun gc-write-forwarding-pointer (address ptr imm? input-dc log)
  (if (forwarding-table-p log)
    (if imm?
      (setf (gethash address (forwarding-table-immediates log)) ptr)
      (setf (gethash address (forwarding-table-pointers log)) ptr))
    (progn
      (log-write-long log address)
      (multiple-value-bind (p i) (read-pointer input-dc address)
        (log-write-pointer log p i)
        (multiple-value-setq (p i) (read-pointer input-dc (+ address 4)))
        (log-write-pointer log p i))
      (setf (read-long input-dc address) $forwarding-pointer-header
            (read-pointer input-dc (+ address 4) imm?) ptr)))
  (values ptr imm?))

(defun restore-from-log-after-gc (pheap log)
  (let ((log-eof (log-position log))
        (dc (pheap-disk-cache pheap)))
    (log-position log 0)
    (loop
      (when (eql log-eof (log-position log))
        (return))
      (let ((address (log-read-long log)))
        (multiple-value-bind (ptr imm?) (log-read-pointer log)
          (setf (read-pointer dc address imm?) ptr)
          (multiple-value-setq (ptr imm?) (log-read-pointer log))
          (setf (read-pointer dc (+ address 4) imm?) ptr))))))

(defun do-wood-gc (input-pheap output-pheap log q)
  (let ((input-dc (pheap-disk-cache input-pheap))
        (output-dc (pheap-disk-cache output-pheap)))
    (multiple-value-bind (ptr imm?)
                         (dc-root-object input-dc)
      (multiple-value-setq (ptr imm?)
        (gc-copy-ptr ptr imm? input-dc output-dc log q))
      (setf (dc-root-object output-dc imm?) ptr)
      (gc-clear-q input-dc output-dc log q)
      ; Copy any symbols that have bindings
      (let ((pkg-btree (dc-package-btree input-dc nil))
            (mapper #'(lambda (input-dc name pkg pkg-imm?)
                        (declare (ignore name pkg-imm?))
                        (gc-copy-pkg-symbols pkg input-dc output-dc log q))))
        (declare (dynamic-extent mapper))
        (when pkg-btree
          (dc-map-btree input-dc pkg-btree mapper))))))

(defun gc-copy-pkg-symbols (pkg input-dc output-dc log q)
  (let ((mapper #'(lambda (input-dc name sym imm?)
                    (declare (ignore name imm?))
                    (unless (pointer-tagp sym $t_symbol)
                      (error "Not a symbol: #x~x" sym))
                    (let ((addr (- sym $t_symbol)))
                      (unless (address-forwarded-p input-dc addr log)
                        (when (dc-symbol-values-list input-dc sym)
                          (gc-copy-symbol sym addr input-dc output-dc log q)
                          (gc-clear-q input-dc output-dc log q)))))))
    (declare (dynamic-extent mapper))
    (dc-map-btree input-dc (dc-%svref input-dc pkg $pkg.btree) mapper)))

; gc-copy-ptr allocates space in the output pheap and leaves
; a forwarding pointer in the input pheap.
; It writes an entry to the log to restore the word written over by
; the forwarding pointer, and pushes the output object on the Q to
; be passed later to gc-copy-object
(defun gc-copy-ptr (ptr imm? input-dc output-dc log q)
  (when imm?
    (return-from gc-copy-ptr (values ptr t)))
  (when (eql ptr $pheap-nil)
    (return-from gc-copy-ptr ptr))
  (let ((address (pointer-address ptr)))
    (when (address-forwarded-p input-dc address log)
      (return-from gc-copy-ptr (read-forwarded-pointer input-dc address log)))
    (funcall (svref #(gc-copy-err     ; $t_fixnum
                      gc-copy-vector  ; $t_vector
                      gc-copy-symbol  ; $t_symbol
                      gc-copy-dfloat  ; $t_dfloat
                      gc-copy-cons    ; $t_cons
                      gc-copy-err     ; $t_sfloat
                      gc-copy-lfun    ; $t_lfun
                      gc-copy-err)    ; $t_imm
                    (pointer-tag ptr))
             ptr address input-dc output-dc log q)))

(defun address-forwarded-p (input-dc address log)
  (if (forwarding-table-p log)
    (or (gethash address (forwarding-table-immediates log))
        (gethash address (forwarding-table-pointers log)))
    (and (eql (read-word input-dc (+ address 2))
              (logand #xffff $forwarding-pointer-header))
         (eql (read-word input-dc address)
              (ash $forwarding-pointer-header -16)))))

(defun read-forwarded-pointer (input-dc address log)
  (if (forwarding-table-p log)
    ;; Return a second value t iff the address maps to an
    ;; immediate value.  OR only returns multiple values of
    ;; its last form, so it does this for free.
    (or (gethash address (forwarding-table-pointers log))
        (gethash address (forwarding-table-immediates log)))
    (read-pointer input-dc (+ address 4))))

(defun gc-copy-err (ptr address input-dc output-dc log q)
  (declare (ignore ptr address input-dc output-dc log q))
  (error "Dispatched on an immediate"))

; The definitions for these are at the end of this file.
(declaim (special *subtype-node-p* *subtype-special-copy-function*))

(defun gc-copy-vector (vector address input-dc output-dc log q)
  (let* ((size (dc-%vector-size input-dc vector))
         (subtype (dc-%vector-subtype input-dc vector)))
    (if (svref *subtype-node-p* subtype)
      (let ((copyer (or (cdr (assq subtype *subtype-special-copy-function*))
                        'gc-copy-gvector)))
        (funcall copyer vector address size input-dc output-dc log q))
      (let ((p (+ (gc-copy-bytes address (+ $vector-header-size (normalize-size size))
                              input-dc output-dc)
                  $t_vector)))
        (gc-write-forwarding-pointer address p nil input-dc log)
        p))))

(defun gc-copy-gvector (vector address size input-dc output-dc log q)
  (let ((p (+ (gc-copy-bytes address (+ $vector-header-size (normalize-size size))
                             input-dc output-dc)
              $t_vector)))
    (gc-write-forwarding-pointer address p nil input-dc log)
    (if *delay-gvector-copy*
      (enq q (cons vector p))      
      (dotimes (i (ash size -2))
        (multiple-value-bind (ptr imm?) (dc-%svref input-dc vector i)
          (multiple-value-setq (ptr imm?)
            (gc-copy-ptr ptr imm? input-dc output-dc log q))
          (setf (dc-%svref output-dc p i imm?) ptr))))
    p))

; Just cons a package. We'll copy symbols later
(defun gc-copy-pkg (pkg address size input-dc output-dc log q)
  (declare (ignore size q))
  (let* ((names (pointer-load (disk-cache-pheap input-dc)
                              (dc-%svref input-dc pkg $pkg.names)
                              :default
                              input-dc))
         (res (dc-make-package output-dc (car names) (cdr names))))
    (gc-write-forwarding-pointer address res nil input-dc log)
    res))

(defun gc-copy-area (area address size input-dc output-dc log q)
  (declare (ignore area address size input-dc output-dc log q))
  (error "Wood's GC doesn't deal with areas yet!"))

(defun gc-copy-error (vector address size input-dc output-dc log q)
  (declare (ignore  address size output-dc log q))
  (let ((subtype (dc-%vector-subtype input-dc vector)))
    (error "Can't copy vectors of subtype: ~s" subtype)))

(defun gc-copy-btree (btree address size input-dc output-dc log q)
  (declare (ignore size))
  (let ((p (dc-make-btree output-dc nil (dc-%svref input-dc btree $btree.type))))
    (gc-write-forwarding-pointer address p nil input-dc log)
    (enq q (cons btree p))              ; delay the copying
    p))

; Currently, btrees are the only things that are not copied immediately.
; Now optionally gvectors are also not copied immediately
; Eventually, we may want to use an algorithm that improves locality better.
(defun gc-clear-q (input-dc output-dc log q)
  (loop
    (when (q-empty-p q) (return))
    (destructuring-bind (in . out) (deq q)
      ;(break)
      (if *delay-gvector-copy*
        (let ((subtype (dc-%vector-subtype output-dc out)))
          (if (eq subtype $v_btree)
            (gc-map-btree in out input-dc output-dc log q) 
            (gc-finish-gvector in out input-dc output-dc log q)))
        (gc-map-btree in out input-dc output-dc log q)))))

(defun gc-finish-gvector (in out input-dc output-dc log q)
  (let ((size (dc-%vector-size output-dc out)))
    ;(break)
    (dotimes (i (ash size -2))
      (multiple-value-bind (ptr imm?) (dc-%svref input-dc in i)
        (multiple-value-setq (ptr imm?)
          (gc-copy-ptr ptr imm? input-dc output-dc log q))
        (setf (dc-%svref output-dc out i imm?) ptr)))))

(defun gc-map-btree (in out input-dc output-dc log q)
  (let ((type (dc-%svref output-dc out $btree.type))
        (*forwarded-btree* in))         ; prevent type error due to forwarding pointer
    (if (logbitp $btree-type_eqhash-bit type)
      ; Doesn't handle weak hash tables weakly yet.
      (let ((mapper #'(lambda (input-dc key-string value value-imm?)
                        (multiple-value-bind (key key-imm?) (dc-hash-key-value key-string)
                          (multiple-value-setq (key key-imm?)
                            (gc-copy-ptr key key-imm? input-dc output-dc log q))
                          (multiple-value-setq (value value-imm?)
                            (gc-copy-ptr value value-imm? input-dc output-dc log q))
                          (dc-puthash output-dc key key-imm? out value value-imm?)))))
        (declare (dynamic-extent mapper))
        (dc-map-btree input-dc in mapper))
      (let ((mapper #'(lambda (input-dc key-string value value-imm?)
                        (multiple-value-setq (value value-imm?)
                          (gc-copy-ptr value value-imm? input-dc output-dc log q))
                        (dc-btree-store output-dc out key-string value value-imm?))))
        (declare (dynamic-extent mapper))
        (dc-map-btree input-dc in mapper)))))

(defun gc-copy-class (class address size input-dc output-dc log q)
  (declare (ignore size))
  (let* ((hash (dc-class-hash output-dc t))
         (res (dc-make-uvector output-dc $class-size $v_class)))
    (multiple-value-bind (name name-imm?) (dc-%svref input-dc class $class.name)
      (multiple-value-bind (wrapper wrapper-imm?) (dc-%svref input-dc class $class.own-wrapper)
        (gc-write-forwarding-pointer address res nil input-dc log)
        (multiple-value-setq (name name-imm?)
          (gc-copy-ptr name name-imm? input-dc output-dc log q))
        (multiple-value-setq (wrapper wrapper-imm?)
          (gc-copy-ptr wrapper wrapper-imm? input-dc output-dc log q))
        (setf (dc-%svref output-dc res $class.name name-imm?) name
              (dc-%svref output-dc res $class.own-wrapper wrapper-imm?) wrapper)
        (dc-puthash output-dc name name-imm? hash res)))
    res))

(defun gc-copy-symbol (symbol address input-dc output-dc log q)
  (let* ((pkg (gc-copy-ptr (dc-symbol-package input-dc symbol) nil
                           input-dc output-dc log q))
         (print-name (gc-copy-ptr (dc-symbol-name input-dc symbol) nil
                                  input-dc output-dc log q))
         (values-list (dc-symbol-values-list input-dc symbol))
         (len (dc-%vector-size output-dc print-name))
         (str (make-string len :element-type 'base-character)))
    (declare (dynamic-extent str))
    (read-string output-dc (+ print-name $v_data) len str)
    (let ((p (dc-%make-symbol output-dc str pkg nil nil nil print-name)))
      (gc-write-forwarding-pointer address p nil input-dc log)
      (when values-list
        (setf (read-pointer output-dc (+ p $sym_values))
              (gc-copy-ptr values-list nil input-dc output-dc log q)))
      p)))

(defun gc-copy-dfloat (dfloat address input-dc output-dc log q)
  (declare (ignore dfloat q))
  (let* ((p (gc-copy-bytes address 8 input-dc output-dc))
         (res (+ p $t_dfloat)))
    (gc-write-forwarding-pointer address res nil input-dc log)
    res))

(defun gc-copy-cons (cons address input-dc output-dc log q)
  (declare (ignore cons))
  (let* ((p (gc-copy-bytes address 8 input-dc output-dc))
         (res (+ p $t_cons)))
    (gc-write-forwarding-pointer address res nil input-dc log)
    (gc-copy-cons-internal res input-dc output-dc log q)
    res))

(defun gc-copy-cons-internal (cons input-dc output-dc log q)
  ;(declare (optimize debug))
  (multiple-value-bind (ptr imm?) (dc-car output-dc cons)
    (unless imm?
      (multiple-value-setq (ptr imm?)
        (gc-copy-ptr ptr imm? input-dc output-dc log q)))
    (setf (dc-car output-dc cons imm?) ptr)
    (multiple-value-setq (ptr imm?) (dc-cdr output-dc cons))
    (cond (imm? (setf (dc-cdr output-dc cons t) ptr))
          ((not (pointer-tagp ptr $t_cons))
           (setq ptr (gc-copy-ptr ptr nil input-dc output-dc log q))
           (setf (dc-cdr output-dc cons) ptr))
          ((eql ptr $pheap-nil)
           (setf (dc-cdr output-dc cons) $pheap-nil))
          (t (let* ((addr (- ptr $t_cons)))
               (if (address-forwarded-p input-dc addr log)
                 (setf (dc-cdr output-dc cons) (read-forwarded-pointer input-dc addr log))
                 (let ((cdr (+ (gc-copy-bytes addr 8 input-dc output-dc)
                               $t_cons)))
                   (setf (dc-cdr output-dc cons) cdr)
                   (gc-write-forwarding-pointer addr cdr nil input-dc log)
                   ; Must be a tail-call
                   (gc-copy-cons-internal cdr input-dc output-dc log q))))))))

(defun gc-copy-lfun (lfun address input-dc output-dc log q)
  (declare (ignore lfun))
  (+ (gc-copy-vector (+ address $t_vector) address input-dc output-dc log q)
     (- $t_lfun $t_vector)))

; Here's where most of the storage gets allocated.
; We copy the storage from input-dc to output-dc. It will be
; furthur translated as necessary by our caller(s).
; This should eventually handle consing areas.
(defun gc-copy-bytes (address bytes input-dc output-dc)
  (let* ((res (- (%allocate-storage output-dc nil bytes) $t_cons))
         (string (make-string 512 :element-type 'base-character))
         (from address)
         (to res)
         (bytes-to-go bytes))
    (declare (dynamic-extent string))
    (loop
      (when (< bytes-to-go 512)
        (load-byte-array input-dc from bytes-to-go string 0 t)
        (store-byte-array string output-dc to bytes-to-go 0 t)
        (return))
      (load-byte-array input-dc from 512 string 0 t)
      (store-byte-array string output-dc to 512 0 t)
      (setq from (addr+ input-dc from 512))
      (setq to (addr+ output-dc to 512))
      (decf bytes-to-go 512))
    res))

;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Tables
;;

(defparameter *subtype-node-p*
  #(nil                                 ; 0 - unused
    nil                                 ; 1 - $v_bignum
    nil                                 ; 2 - $v_macptr not implemented
    nil                                 ; 3 - $v_badptr not implemented
    t                                   ; 4 - $v_nlfunv
    nil                                 ; 5 - unused
    nil                                 ; 6 - unused
    nil                                 ; 7 - $v_ubytev - unsigned byte vector
    nil                                 ; 8 - $v_uwordv - unsigned word vector
    nil                                 ; 9 - $v_floatv - float vector
    nil                                 ; 10 - $v_slongv - Signed long vector
    nil                                 ; 11 - $v_ulongv - Unsigned long vector
    nil                                 ; 12 - $v_bitv - Bit vector
    nil                                 ; 13 - $v_sbytev - Signed byte vector
    nil                                 ; 14 - $v_swordv - Signed word vector
    nil                                 ; 15 - $v_sstr - simple string
    t                                   ; 16 - $v_genv - simple general vector
    t                                   ; 17 - $v_arrayh - complex array header
    t                                   ; 18 - $v_struct - structure
    t                                   ; 19 - $v_mark - buffer mark unimplemented
    t                                   ; 20 - $v_pkg
    nil                                 ; 21 - unused
    t                                   ; 22 - $v_istruct - type in first element
    t                                   ; 23 - $v_ratio
    t                                   ; 24 - $v_complex
    t                                   ; 25 - $v_instance - clos instance
    nil                                 ; 26 - unused
    nil                                 ; 27 - unused
    nil                                 ; 28 - unused
    t                                   ; 29 - $v_weakh - weak list header
    t                                   ; 30 - $v_poolfreelist - free pool header
    t                                   ; 31 - $v_nhash unused
    t                                   ; 32 - $v_area - area descriptor
    t                                   ; 33 - $v_segment - area segment
    nil                                 ; 34 - $v_random-bits - vectors of random bits, e.g. resources
    t                                   ; 35 - $v_dbheader - database header
    nil                                 ; 36 - $v_segment-headers - specially allocated
    t                                   ; 37 - $v_btree
    nil                                 ; 38 - $v_btree-node - specially allocated
    t                                   ; 39 - $v_class
    t                                   ; 40 - $v_load-function
    ))

(defparameter *subtype-special-copy-function*
  '((#.$v_pkg . gc-copy-pkg)
    (#.$v_area . gc-copy-area)
    (#.$v_segment . gc-copy-error)
    (#.$v_dbheader . gc-copy-error)
    (#.$v_segment-headers .  gc-copy-error)
    (#.$v_btree . gc-copy-btree)
    (#.$v_btree-node . gc-copy-error)
    (#.$v_class . gc-copy-class)))
;;;    1   3/10/94  bill         1.8d247
;;;    2   7/26/94  Derek        1.9d027
;;;    3  10/04/94  bill         1.9d071
;;;    4  11/05/94  kab          1.9d087
;;;    2   3/23/95  bill         1.11d010
;;;    3   6/02/95  bill         1.11d040
