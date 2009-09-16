;;;-*- Mode: Lisp; Package: (WOOD) -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; persistent-heap.lisp
;; Code to maintain a Lisp heap in a file.
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
;; 05/16/04 akh fix p-store-bignum and p-load-bignum 8 years later!!
;; 11/02/97 akh  bill's dc-aref-vector-and-index
;; 10/28/97 akh  bill's patches for multi-dim array and always rehash
;; -------------- 0.96
;; 05/21/96 bill  new functions p-store-bit-vector & p-load-bit-vector.
;;                Enter them in the $v_bitv slot of *p-store-subtype-functions*
;;                and *p-load-subtype-functions*, respectively.
;; -------------- 0.95
;; 05/09/96 bill  p-load-bignum, p-store-bignum, (method %p-store-object (t fixnum t))
;;                immediate-object-p is false for fixnums that are bigger than MCL 2.0 fixnums.
;;                p-load-bignum still needs to be fixed to cons less.
;; -------------- 0.94 = MCL-PPC 3.9
;; 04/04/96 bill  Handle hash tables.
;;                Revert p-load-header. New code renamed to p-load-arrayh.
;; 03/29/96 bill  #+ppc-target for the new p-load-header def.
;;                p-load-struct passes true value for the new struct-p
;;                arg to p-load-gvector. This makes loading a struct
;;                that references itself work again.
;; 03/27/96 bill  :read-only-p keyword for open-pheap (from Dylan).
;; 03/22/96 bill  Make it work on the PPC.
;;                This mostly involved mapping the new typecodes to/from the old subtypes
;;                and dealing with the change in complex array/vector headers.
;;                New:
;;                  *wood-subtype->ccl-subtag-table*, *ccl-subtag->wood-subtype-table*,
;;                  p-store-arrayh
;;                Changed:
;;                  wood->ccl-subtype, ccl->wood-subtype,
;;                  p-load-header, immediate-object-p, %p-store-object
;; 03/21/96 bill  uvref-extended-string, uvset-extended-string and other support for 2-byte strings.
;; 09/12/95 bill  setf method for p-stored?
;; -------------  0.93
;; 08/10/95 bill  p-assoc
;; 06/30/95 bill  p-load-header passes a null depth directly to p-load-gvector.
;;                Thanks to Sidney Markowitz.
;; 05/31/95 bill  Shared swapping space:
;;                Add :shared-buffer & :shared-buffer-pool to *open-pheap-keywords*
;;                open-pheap takes new :shared-buffer & :shared-buffer-pool keywords
;;                which it passes on to open-disk-cache.
;; 05/31/95 bill  pheap class definition now specifies the size of the pheap->mem-hash &
;;                mem->pheap-hash tables as *pheap<->mem-hash-table-size* = 500.
;; 05/25/95 bill  *default-page-size* moved to disk-cache.lisp.
;;                remove *default-max-pages*.
;;                add :swapping-space to *open-pheap-keywords*
;;                open-pheap takes a new :swapping-space keyword arg, the default is
;;                *default-swapping-space*. The default value for max-pages is now computed from
;;                the page-size and the swapping-space, and is forced to be at least 2.
;;                dc-cons-segment calls %dc-allocate-new-memory with a nil value for its
;;                initial-element arg. This prevents storage from being initialized twice,
;;                once when the segment is allocated and again when an object is consed.
;;                initialize-vector-storage calls extend-disk-cache with a true value for
;;                its new extend-file? arg if the vector being consed is at least 16K bytes
;;                long. This is an attempt to get contiguous disk space for large arrays.
;; 03/22/95 bill  in %p-store-internal - in the first (conser) body subform of the %p-store-object-body
;;                form, unconditionally set checked-load-function? to true. This prevents unnecessary
;;                checking in the second (filler) body subform.
;; -------------  0.91
;; 03/20/95 bill  %p-store checks for (eq descend :store-slots-again) before calling require-type.
;;                  This is an optimization, not a bug fix.
;;                %fill-load-function-object takes a new descend arg.
;;                %p-store-internal & %p-store-lfun-vector call %fill-load-function-object with the new arg.
;;                %p-store-internal lets %p-store-object-body do all the work with p-store-hash
;;                  and with the :store-slots-again descend value.
;;                %p-store-internal doesn't make its first call to %p-store-object-body if
;;                  in forced descend mode and there is no load function.
;;                %p-store-object-body now handles the :store-slots-again descend value.
;;                  It is also more efficient w.r.t. lookups in the p-store-hash table.
;; -------------  0.9
;; 02/10/95 bill  Binding of *loading-pheap* moves from p-load to pointer-load.
;; 01/17/95 bill  poor man's transactions.
;;                open-pheap takes an :initial-transaction-p keyword.
;;                If nil (NOT the default), errors on any disk writes that
;;                happen outside of a start-transaction/commit-transaction pair.
;; 12/09/94 bill  Changes from fix-redefine-class-patch for Alpha 1
;;                %p-store-internal gets new descend value :store-slots-again
;; 11/16/94 bill  flush-all-open-pheaps ignores errors and ensures that they
;;                won't happen again.
;; 11/04/94 ows   open-pheap & create-pheap take a mac-file-creator keyword, which
;;                they pass on to open-disk-cache.
;;                Add :mac-file-creator to *open-pheap-keywords*.
;; 11/02/94 bill  Handling of p-make-load-function-using-pheap moves into
;;                %p-store-internal and out of (method %p-store-object (t structure-object t)).
;;                %p-store-object-body-with-load-function commented out.
;;                Remove %p-store-hash-table and its call.
;;                Optimize handling of NIL in %p-store-internal
;; 10/28/94 Moon  Change without-interrupts to with-databases-locked
;;                Remove interlocking from pheap-write-hook since it is only called
;;                from inside of get-disk-page, which is already interlocked
;; 10/25/94 bill  p-loaded?, p-maphash type checks its hash table arg.
;;                initialize-vector-storage had an error in its first error call.
;;                %p-store-uvector calls %p-store-hash-table for hash tables.
;;                %p-store-hash-table saves hash tables without dumping
;;                a copy of #'equal, #'equalp, or internal hash table functions.
;;                p-load-load-function handles circularity correctly.
;;                New macro: %p-store-object-body-with-load-function and
;;                its helper function do-%p-store-object-body-with-load-function
;; 10/13/94 bill  New variable: *preserve-lfun-info*. Pass it as second arg to split-lfun.
;; 10/12/94 bill  typo in error message in initialize-vector-storage.
;;                Thanx to Chris DiGiano for finding this.
;; 10/11/94 bill  open-pheap works again if the file does not exist and
;;                the :if-exists keyword is present.
;; 09/26/94 bill  GZ's simplification t do-%p-store-object-body
;; 09/21/94 bill  without-interrupts as necessary for interlocking
;; 09/19/94 bill  New function: p-stored?
;;                New macro: careful-maybe-cached-address. Use it in %p-store-object-body
;;                to handle the case of a make-load-function-using-pheap returning
;;                the same disk object for two different memory objects.
;; 07/18/94 bill  (via derek)
;;		  Calls p-make-load-function-using-pheap instead of p-make-load-function.
;; 		  p-make-load-function-using-pheap takes the pheap as an arg, so that it
;; 		  can dispatch off its type. open-pheap takes a new :pheap-class keyword
;; 		  to support this. The reason for this change is to allow different
;;		  persistent heap types to have different strategies for storing objects to disk.
;; 06/21/94 bill  flush-all-open-pheaps removes a pheap from *open-pheaps* if
;;                its stream is no longer open.
;; 03/10/93 bill  create-pheap & open-pheap now take an :external-format keyword
;;                (submitted by Oliver Steele)
;; -------------- 0.8
;; 12/17/93 bill  increment version number. Call check-pheap-version in open-pheap
;; 11/09/93 bill  p-load-lfun & (method %p-store-object (t function t)) updated
;;                to work with functions whose immediates reference the function.
;; 10/20/93 bill  p-load-struct
;; 07/07/93 bill  %p-store-lfun-vector
;; 06/26/93 bill  use addr+, not +, when computing $sym_xxx addresses.
;; 03/29/93 bill  dc-%make-symbol comes out of line from dc-intern
;; 03/27/93 bill  dc-root-object, (setf dc-root-object)
;; 03/09/93 bill  DWIM for (setf p-car) & (setf p-cdr) was wrong.
;; -------------- 0.6
;; 02/17/93 bill  dc-uv-subtype-size, hence p-length & p-uvsize, now works
;;                correctly for 0 length bit vectors.
;; 01/19/93 bill  handle GENSYM'd symbols correctly. Add argument for
;;                (error "There is no package named ~s")
;; 12/09/92 bill  initialize-vector-storage works correctly for 0 length
;; 10/21/92 bill  p-nth, p-nthcdr for Ruben
;; 10/06/92 bill  in with-consing-area: dynamic-extend -> dynamic-extent.
;;                Thanx to Guillaume Cartier.
;;                Also, FLET -> LET to save a symbol in the thunk.
;; 08/27/92 bill  add p-make-load-function & p-make-load-function-object
;; 08/11/92 bill  remove misguided unwind-protect from do-%p-store-object-body
;;                (method p-store-object (t cons t)) now tail-calls for the CDR
;;                as does p-load-cons.
;; 08/06/92 bill  pheap-stream, pheap-pathname, print-object method for pheap's.
;; 07/30/92 bill  p-load-istruct marks hash tables as needing rehashing
;; -------------- 0.5
;; 07/27/92 bill  p-clrhash, p-maphash
;; 06/23/92 bill  (open-pheap name :if-exists :supersede) now works
;; 06/04/92 bill  save/restore functions
;; 06/23/92 bill  save/restore CLOS instances -> persistent-clos.lisp
;; -------------- 0.1
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; To do.
;;
;; Hook for writing/reading macptr's
;;
;; Make abort in the middle of load or store clear the cache appropriately.
;;
;; p-maphash, p-map-btree
;;
;; persistent-stream
;;
;; Think about floats. The current implementation does not allow
;; for distinguishing floats and conses when walking memory.
;; 1) A float is a 16-byte vector. Free up the tag
;; 2) Cons floats in a special area.
;; 3) Don't worry about being able to walk memory.

(defpackage :wood)
(in-package :wood)

(export '(create-pheap open-pheap close-pheap with-open-pheap
          root-object p-load p-store
          ))

(eval-when (:compile-toplevel :execute)
  (require :woodequ)
  (require :lispequ))

; Dispatch tables at end of file
(declaim (special *p-load-subtype-functions*
                  *subtype->bytes-per-element*
                  *p-store-subtype-functions*
                  *subtype->uvreffer*
                  *subtype->uvsetter*
                  *subtype-initial-element*))

(defparameter *pheap<->mem-hash-table-size* 1024) ;; was 500 makes no difference

; All sizes are rounded up to a multiple of 8 bytes.

(defmacro normalize-size (x &optional (multiple 8))
  (let ((mask (1- multiple)))
    `(logand (lognot ,mask) (+ ,x ,mask))))


(defclass pheap ()
  ((disk-cache :accessor pheap-disk-cache :initarg :disk-cache)
   (consing-area :accessor pheap-consing-area :initarg :consing-area)
   (pptr-hash :reader pptr-hash
              :initform (make-hash-table 
                         :weak :value 
                         :test 'eql))
   (wrapper-hash :reader wrapper-hash
                 :initform (make-hash-table :weak :key :test 'eq))
   (pheap->mem-hash :reader pheap->mem-hash
                   :initform (make-hash-table :weak :value
                                              :test 'eql
                                              :size *pheap<->mem-hash-table-size*))
   (mem->pheap-hash :reader mem->pheap-hash
                   :initform (make-hash-table :weak :key
                                              :test 'eq
                                              :size *pheap<->mem-hash-table-size*))
   (p-load-hash :reader p-load-hash
                :initform (make-hash-table :weak :key :test 'eq))
   (inside-p-load :accessor inside-p-load :initform nil)
   (p-store-hash :reader p-store-hash
                 :initform (make-hash-table :weak :key :test 'eq))
   (inside-p-store :accessor inside-p-store :initform nil)))

(defun pheap-stream (pheap)
  (disk-cache-stream (pheap-disk-cache pheap)))

(defun pheap-pathname (pheap)
  (pathname (pheap-stream pheap)))

(defmethod print-object ((pheap pheap) stream)
  (print-unreadable-object (pheap stream)
    (let ((pheap-stream (pheap-stream pheap)))
      (format stream "~a ~:_~s to ~:_~s"
              (stream-direction pheap-stream)
              (type-of pheap)
              (pathname pheap-stream)))))

(defmethod read-only-p ((pheap pheap))
  (disk-cache-read-only-p (pheap-disk-cache pheap)))
   
; A PPTR is a pointer into a PHEAP
(defstruct (pptr (:print-function print-pptr))
  pheap
  pointer
  )

(defun print-pptr (pptr stream level)
  (declare (ignore level))
  (write-string "#.(" stream)
  (prin1 'pptr stream)
  (tyo #\space stream)
  (prin1 (pptr-pheap pptr) stream)
  (write-string " #x" stream)
  (let ((*print-base* 16))
    (prin1 (pptr-pointer pptr) stream))
  (tyo #\) stream))

(defun pptr (pheap pointer)
  (if (eq pointer $pheap-nil)
    nil
    (let ((hash (pptr-hash pheap)))
      (or (gethash pointer hash)
          (setf (gethash pointer hash)
                (make-pptr :pheap pheap :pointer pointer))))))

; Turns a value into a (pointer imm?) pair
(defun split-pptr (maybe-pptr)
  (if (pptr-p maybe-pptr)
    (pptr-pointer maybe-pptr)
    (values maybe-pptr t)))

(defun dc-pointer-pptr (disk-cache pointer)
  (pptr (disk-cache-pheap disk-cache) pointer))

(defun pptr-disk-cache (pptr)
  (pheap-disk-cache (pptr-pheap pptr)))

(defun clear-memory<->disk-tables (pheap)
  (clrhash (mem->pheap-hash pheap))  
  (clrhash (pheap->mem-hash pheap)))

(defparameter $version-number #x504802)          ; current version number "PH2"

(defparameter *default-area-segment-size* 4096)

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; WITH-EGC macro can disable EGC while dumping or loading.
;;; This prevents extraneous rehashing of the mem->pheap hash table
;;;

(defmacro with-egc (state &body body)
  (let ((egc-state (gensym)))
    `(let ((,egc-state (ccl:egc-enabled-p)))
       (unwind-protect
         (progn
           (ccl:egc ,state)
           ,@body)
         (ccl:egc ,egc-state)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Functions to create, open, and close pheaps
;;

(defmacro dc-%svfill (disk-cache vector &body indices-and-values)
  (let (res)
    (loop
      (when (null indices-and-values) (return))
      (let ((index (pop indices-and-values))
            (value (pop indices-and-values))
            immediate?)
        (when (consp index)
          (psetq index (car index) immediate? (cadr index)))
        (push `(setf (dc-%svref ,disk-cache ,vector ,index ,immediate?) ,value)
              res)))
    `(progn ,@(nreverse res))))

; Create a pheap. Close its file.
(defun create-pheap (filename &key
                              (if-exists :error)
                              (area-segment-size *default-area-segment-size*)
                              (page-size *default-page-size*)
                              (mac-file-creator :ccl2)
                              (external-format :WOOD))
  (let ((min-page-size 512))
    (setq page-size 
          (require-type (* min-page-size (floor (+ page-size min-page-size -1) min-page-size))
                        'fixnum)))
  (let* ((disk-cache (open-disk-cache
                      filename
                      :if-exists if-exists
                      :if-does-not-exist :create
                      :page-size page-size
                      :mac-file-creator mac-file-creator
                      :external-format external-format)))
    (fill-long disk-cache 0 0 (ash (disk-cache-page-size disk-cache) -2))
    (initialize-vector-storage
     disk-cache (pointer-address $root-vector)
     $pheap-header-size $v_dbheader 4 $pheap-nil)
    (dc-%svfill disk-cache $root-vector
      ($pheap.version t) $version-number
      ($pheap.free-page t) 1
      $pheap.default-consing-area (dc-make-area
                                   disk-cache :segment-size area-segment-size)
      ($pheap.page-size t) page-size)
    (setf (read-string disk-cache
                       (+ $root-vector (- $t_vector) (ash $pheap-header-size 2)))
          #.(format nil "~%This is a persistent heap~%~
                         created by William's Object Oriented Database~%~
                         in Macintosh Common Lisp.~%"))
    (close-disk-cache disk-cache)
    filename))

(defvar *open-pheaps* nil)

(defparameter *open-pheap-keywords*
  '(:read-only-p
    :if-does-not-exist
    :if-exists
    :area-segment-size
    :page-size
    :swapping-space
    :max-pages
    :shared-buffer
    :shared-buffer-pool
    :mac-file-creator
    :external-format
    :pheap-class
    :initial-transaction-p))

(defun open-pheap (filename &rest rest
                              &key
                              (if-does-not-exist :error)
                              (if-exists :overwrite)
                              read-only-p
                              (area-segment-size *default-area-segment-size*)
                              (page-size *default-page-size*)
                              (swapping-space *default-swapping-space*)
                              max-pages
                              shared-buffer
                              shared-buffer-pool
                              (mac-file-creator :ccl2)
                              (external-format :WOOD)
                              (pheap-class (load-time-value (find-class 'pheap)))
                              (initial-transaction-p t)
                              &allow-other-keys)
  (declare (dynamic-extent rest))
  (if (null max-pages)
    (setq max-pages  (ceiling swapping-space page-size))
    (setq swapping-space (* max-pages page-size)))
  (when (symbolp pheap-class)
    (setq pheap-class (find-class pheap-class)))
  (unless (typep (class-prototype pheap-class) 'pheap)
    (error "~s is not a subclass of ~s" pheap-class 'pheap))
  (let* ((disk-cache (unless (eq if-exists :supersede)
                       (open-disk-cache filename
                                        :if-exists if-exists
                                        :if-does-not-exist nil
                                        :read-only-p read-only-p
                                        :page-size page-size
                                        :max-pages max-pages
                                        :shared-buffer shared-buffer
                                        :shared-buffer-pool shared-buffer-pool
                                        :write-hook 'pheap-write-hook
                                        :mac-file-creator mac-file-creator
                                        :external-format external-format
                                        :initial-transaction-p initial-transaction-p))))
    (when (null disk-cache)
      (if (or (eq if-exists :supersede)
              (eq if-does-not-exist :create))
        (progn
          (create-pheap filename
                        :if-exists if-exists
                        :area-segment-size area-segment-size
                        :page-size page-size
                        :mac-file-creator mac-file-creator
                        :external-format external-format)
          (return-from open-pheap
            (apply #'open-pheap filename :if-exists :overwrite rest)))
        (error "File ~s does not exist" filename)))
    (when (not (eql page-size (setq page-size (dc-%svref disk-cache $root-vector $pheap.page-size))))
      (close-disk-cache disk-cache)
      (return-from open-pheap
        (apply #'open-pheap filename
               :page-size page-size
               :swapping-space swapping-space
               :max-pages nil
               rest)))
    (let ((done? nil))
      (unwind-protect
        (progn
          (lock-page-at-address disk-cache 0)   ; accessed frequently
          (multiple-value-bind (count imm?) (dc-page-write-count disk-cache)
            (when (or imm? (not (eql count $pheap-nil)))
              (cerror "Hope for the best."
                      "~s was modified but not closed properly. It may be corrupt."
                      filename)
              (setf (dc-page-write-count disk-cache) $pheap-nil
                    (disk-cache-write-hook disk-cache) nil)
              (flush-disk-cache disk-cache)
              (setf (disk-cache-write-hook disk-cache) 'pheap-write-hook)))
          (let ((pheap (apply 'make-instance pheap-class
                              :disk-cache disk-cache
                              (dolist (keyword *open-pheap-keywords* rest)
                                (loop (unless (remf rest keyword)
                                        (return)))))))
            (check-pheap-version pheap)
            (setf (pheap-consing-area pheap) (dc-default-consing-area disk-cache))
            (with-databases-locked
             (push pheap *open-pheaps*))
            (setq done? t)
            pheap))
        (unless done?
          (close-disk-cache disk-cache))))))

(defun close-pheap (pheap)
  (flush-pheap pheap)                   ; interruptable
  (with-databases-locked
   (flush-pheap pheap)                  ; make sure we're really done
   (let ((disk-cache (pheap-disk-cache pheap)))
     (unlock-page (nth-value 3 (get-disk-page disk-cache 0)))
     (close-disk-cache disk-cache))
   (setq *open-pheaps* (delq pheap *open-pheaps*)))
  nil)

(defun move-pheap-file (pheap new-filename)
  (let* ((old-filename (probe-file (pheap-pathname pheap)))
         (new-filename (merge-pathnames (translate-logical-pathname new-filename)
                                        old-filename))
         (finished? nil)
         (disk-cache (pheap-disk-cache pheap))
         (page-size (dc-%svref disk-cache $root-vector $pheap.page-size))
         (shared-buffer (disk-cache-shared-buffer disk-cache))
         (mac-file-creator (mac-file-creator old-filename))
         (external-format (mac-file-type old-filename)))
    (flet ((open-it (pathname)
             (setf (pheap-disk-cache pheap)
                   (open-disk-cache pathname
                                    :if-does-not-exist :error
                                    :page-size page-size
                                    :shared-buffer shared-buffer
                                    :write-hook 'pheap-write-hook
                                    :mac-file-creator mac-file-creator
                                    :external-format external-format))
             (push pheap *open-pheaps*)))
      (declare (dynamic-extent #'open-it))
      (let ((new-path (probe-file new-filename)))
        (when new-path
          (if (equalp new-path old-filename)
            (return-from move-pheap-file
              (values new-path old-filename))
            (error "File already exists: ~s" new-filename))))
      (let* ((old-dir (pathname-directory old-filename))
             (new-dir (pathname-directory new-filename))
             (rename? (string-equal (second old-dir)
                                    (second new-dir))))
        (unless (and (eq :absolute (car old-dir))
                     (eq :absolute (car new-dir)))
          (error "Relative pathname detected"))
        (unwind-protect
          (progn
            (close-pheap pheap)
            (unless (and rename?
                         (ignore-errors         ; handle wierd aliases
                          (rename-file old-filename new-filename)))
              (setq rename? nil)
              (copy-file old-filename new-filename))
            (setq new-filename (probe-file new-filename))       ; resolve aliases
            (open-it new-filename)
            (setq finished? t)
            (values new-filename old-filename))
      (if finished?
        (unless rename?
          (delete-file old-filename))
        (unless rename?
          (open-it old-filename))))))))

(defmacro with-open-pheap ((pheap filename &rest options) &body body)
  `(let ((,pheap (open-pheap ,filename ,@options)))
     (unwind-protect
       (progn ,@body)
       (close-pheap ,pheap))))

(defun disk-cache-pheap (disk-cache)
  (dolist (pheap *open-pheaps*)
    (if (eq disk-cache (pheap-disk-cache pheap))
      (return pheap))))

(defun flush-pheap (pheap &optional (uninterruptable t))
  (if uninterruptable
    (with-databases-locked
      (flush-pheap pheap nil))
    (let ((disk-cache (pheap-disk-cache pheap))
          (*error-on-non-transaction-writes* nil))
      (flush-disk-cache disk-cache)
      (with-databases-locked
        (multiple-value-bind (count imm?) (dc-page-write-count disk-cache)
          (unless (and (not imm?) (eql count $pheap-nil))
            (setf (dc-page-write-count disk-cache) $pheap-nil
                  (disk-cache-write-hook disk-cache) nil)
            (flush-disk-cache disk-cache)
            (setf (disk-cache-write-hook disk-cache) 'pheap-write-hook)))))))

; This is only called while attempting to quit.
; Don't let errors get in the way.
(defun flush-all-open-pheaps ()
  (let ((bad-ones nil))
    (unwind-protect
      (dolist (pheap *open-pheaps*)
        (if (eq :closed (stream-direction (pheap-stream pheap)))
          (with-databases-locked
            (setq *open-pheaps* (delq pheap *open-pheaps*)))
          (handler-case
            (flush-pheap pheap)
            (error () (push pheap bad-ones)))))
      (dolist (pheap bad-ones)
        (with-databases-locked
          (setq *open-pheaps* (delq pheap *open-pheaps*))
          (setq *open-disk-caches*
                (delq (pheap-disk-cache pheap) *open-disk-caches*))
          (setq ccl::*open-file-streams*
                (delq (pheap-stream pheap) ccl::*open-file-streams*)))))))

(pushnew 'flush-all-open-pheaps *lisp-cleanup-functions*)

(defmacro with-transaction ((pheap) &body body)
  (let ((thunk (gensym)))
    `(let ((,thunk #'(lambda () ,@body)))
       (declare (dynamic-extent ,thunk))
       (funcall-with-transaction ,pheap ,thunk))))

(defun funcall-with-transaction (pheap thunk)
  (let ((transaction (start-transaction pheap))
        (done nil))
    (unwind-protect
      (multiple-value-prog1
        (funcall thunk)
        (setq done t))
      (if done
        (commit-transaction transaction)
        (abort-transaction transaction)))))

(defun start-transaction (pheap)
  (start-disk-cache-transaction (pheap-disk-cache pheap))
  pheap)

(defun commit-transaction (transaction)
  (let ((pheap transaction))
    (with-databases-locked
      (unwind-protect
        (flush-pheap pheap nil)
        (commit-disk-cache-transaction (pheap-disk-cache pheap) nil)))))

(defun abort-transaction (transaction)
  (commit-transaction transaction))


; This marks the pheap as modifed so that the next open
; will complain if it was not closed properly.
; Eventually, we'll also maintain an active transactions count.
; No with-databases-locked in pheap-write-hook since it is only called
; from inside of get-disk-page, which is already interlocked
(defun pheap-write-hook (disk-page)
   (let ((disk-cache (disk-page-disk-cache disk-page))
         flush-page-0?
         (*error-on-non-transaction-writes* nil))
     (multiple-value-bind (count imm?) (dc-page-write-count disk-cache)
       (when (and (not imm?) (eql count $pheap-nil))
         (setq count 0
               flush-page-0? t))
       (setf (dc-page-write-count disk-cache t)
             (if (eql count most-positive-fixnum)
               count
               (1+ count)))
       (when flush-page-0?
         (setf (disk-cache-write-hook disk-cache) nil)
         (flush-disk-page (nth-value 3 (get-disk-page disk-cache 0)))
         (setf (disk-cache-write-hook disk-cache) 'pheap-write-hook)))))

(defun dc-page-write-count (disk-cache)
  (dc-%svref disk-cache $root-vector $pheap.page-write-count))

(defun (setf dc-page-write-count) (value disk-cache &optional imm?)
  (setf (dc-%svref disk-cache $root-vector $pheap.page-write-count imm?)
        value))

(defun pheap-default-consing-area (pheap)
  (multiple-value-bind (pointer immediate?)
                       (dc-default-consing-area (pheap-disk-cache pheap))
    (if immediate?
      pointer
      (pptr pheap pointer))))

(defun dc-default-consing-area (disk-cache)
  (dc-%svref disk-cache
             $root-vector
             $pheap.default-consing-area))

(defmacro require-satisfies (predicate &rest args)
  `(unless (,predicate ,@args)
     (error "Not ~s" ',predicate)))

(defun (setf pheap-default-consing-area) (area pheap)
  (let ((disk-cache (pheap-disk-cache pheap))
        (pointer (pheap-pptr-pointer area pheap)))
    (require-satisfies dc-vector-subtype-p disk-cache pointer $v_area)
    (setf (dc-%svref disk-cache $root-vector $pheap.default-consing-area)
          pointer))
  area)


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Reading pheap data into the Lisp heap
;;
;; Readers take a DEPTH argument:
;; :default      The default. Load the object into memory stopping at
;;               objects that have already been loaded.
;; nil           No conversion except lookup in the hash table.
;; :single       load a single level. vectors, arrays, & lists will come out
;;               one level deep. May cons lots of pptr's
;; <fixnum>      Same as :single but will only load vectors if their length
;;               is <= depth
;; T             Recursive descent until closure. May modify some existing Lisp objects.
;;               Slower than the others as it requires clearing the descent hash table.


(defun root-object (pheap)
  (multiple-value-bind (pointer immediate?)
                       (dc-root-object (pheap-disk-cache pheap))
    (if immediate?
      pointer
      (pptr pheap pointer))))

(defun dc-root-object (disk-cache)
  (dc-%svref disk-cache $root-vector $pheap.root))                          

(defvar *loading-pheap* nil)

(defun p-loading-pheap ()
  *loading-pheap*)

(defun p-load (pptr &optional (depth :default))
  (if (pptr-p pptr)
    (pointer-load (pptr-pheap pptr)
                  (pptr-pointer pptr)
                  depth)
    pptr))

; This may execute with-databases-locked for quite a while.
; Whether it is with-databases-locked should likely be a switch.
(defun pointer-load (pheap pointer &optional depth disk-cache)
  (with-databases-locked
   (unless disk-cache
     (setq disk-cache (pheap-disk-cache pheap)))
   (let ((*loading-pheap* pheap))
     (if (or (neq depth t) (inside-p-load pheap))
       (pointer-load-internal pheap pointer depth disk-cache)
       (unwind-protect
         (progn
           (setf (inside-p-load pheap) t)
           (pointer-load-internal pheap pointer depth disk-cache))
         (clrhash (p-load-hash pheap))
         (setf (inside-p-load pheap) nil))))))

(defun pointer-load-internal (pheap pointer depth disk-cache)
  (let ((tag (pointer-tag pointer)))
    (declare (fixnum tag))
    (let ((f (locally (declare (optimize (speed 3) (safety 0)))
               (svref #(p-load-immediate        ; $t_fixnum
                        p-load-vector   ; $t_vector
                        p-load-symbol   ; $t_symbol
                        p-load-dfloat   ; $t_dfloat
                        p-load-cons     ; $t_cons
                        p-load-immediate        ; $t_sfloat
                        p-load-lfun     ; $t_lfun
                        p-load-immediate)       ; $t_imm
                      tag))))
      (unless (or (eq depth t) (eq f 'p-load-immediate))
        (let ((res (gethash pointer (pheap->mem-hash pheap))))
          (when res
            (return-from pointer-load-internal res))))
      (funcall f pheap disk-cache pointer depth))))

; For error messages
(defun dc-pointer-load (disk-cache pointer &optional immediate? pheap)
  (if immediate?
    pointer
    (pointer-load (or pheap (disk-cache-pheap disk-cache)) pointer :default disk-cache)))

(defmacro maybe-cached-value (pheap pointer &body forms)
  (setq pheap (require-type pheap 'symbol)
        pointer (require-type pointer '(or symbol integer)))
  (let ((pheap->mem-hash (make-symbol "PHEAP->MEM-HASH"))
        (value (make-symbol "VALUE")))
    `(let ((,pheap->mem-hash (pheap->mem-hash ,pheap)))
       (or (gethash ,pointer ,pheap->mem-hash)
           (let ((,value (progn ,@forms)))
             (if (pptr-p ,value)    ; you should throw out in this case.
               ,value
               (setf (gethash ,value (mem->pheap-hash ,pheap)) ,pointer
                     (gethash ,pointer ,pheap->mem-hash) ,value)))))))

(defmacro maybe-cached-address (pheap object &body forms)
  (setq pheap (require-type pheap 'symbol)
        object (require-type object 'symbol))
  (let ((mem->pheap-hash (make-symbol "MEM->PHEAP-HASH"))
        (address (make-symbol "ADDRESS")))
    `(let ((,mem->pheap-hash (mem->pheap-hash ,pheap)))
       (or (gethash ,object ,mem->pheap-hash)
           (let ((,address (progn ,@forms)))
             (setf (gethash ,address (pheap->mem-hash ,pheap)) ,object
                   (gethash ,object ,mem->pheap-hash) ,address))))))

(defmacro careful-maybe-cached-address (pheap object &body forms)
  (setq pheap (require-type pheap 'symbol)
        object (require-type object 'symbol))
  (let ((mem->pheap-hash (make-symbol "MEM->PHEAP-HASH"))
        (pheap->mem-hash (make-symbol "PHEAP->MEM-HASH"))
        (address (make-symbol "ADDRESS")))
    `(let ((,mem->pheap-hash (mem->pheap-hash ,pheap)))
       (or (gethash ,object ,mem->pheap-hash)
           (let ((,address (progn ,@forms))
                 (,pheap->mem-hash (pheap->mem-hash ,pheap)))
             (unless (gethash ,address ,pheap->mem-hash)        ; two different memory objects may go to the same disk object
               (setf (gethash ,address ,pheap->mem-hash) ,object))
             (setf (gethash ,object ,mem->pheap-hash) ,address))))))

(defun p-load-immediate (pheap disk-cache pointer depth)
  (declare (ignore disk-cache depth))
  (error "Immediate pointer ~s" (pptr pheap pointer)))

(defun p-load-vector (pheap disk-cache pointer depth)
  (let ((subtype (dc-%vector-subtype disk-cache pointer)))
    (declare (fixnum subtype))
    (let ((f (svref *p-load-subtype-functions* subtype)))
      (if f
        (funcall f pheap disk-cache pointer depth subtype)
        (pptr pheap pointer)))))

(defun p-load-error (pheap disk-cache pointer depth subtype)
  (declare (ignore disk-cache depth))
  (error "~x is of unsupported subtype: ~s" (pptr pheap pointer) subtype))

(defun p-load-nop (pheap disk-cache pointer depth subtype)
  (declare (ignore disk-cache depth subtype))
  (pptr pheap pointer))

(defmacro old-wood->ccl-subtype (wood-subtype)
  `(* 2 ,wood-subtype))

(defmacro old-ccl->wood-subtype (ccl-subtype)
  `(ash ,ccl-subtype -1))

#-ppc-target
(progn

(defmacro wood->ccl-subtype (wood-subtype)
  `(old-wood->ccl-subtype ,wood-subtype))

(defmacro ccl->wood-subtype (ccl-subtype)
  `(old-ccl->wood-subtype ,ccl-subtype))

)  ; end of #-ppc-target progn

#+ppc-target
(progn

(defvar *wood-subtype->ccl-subtag-table*)
(defvar *ccl-subtag->wood-subtype-table*)

(defmacro wood->ccl-subtype (wood-subtype)
  (let ((subtype-var (gensym)))
    `(let ((,subtype-var ,wood-subtype))
       (or (svref *wood-subtype->ccl-subtag-table* ,subtype-var)
           (error "There is no CCL typecode for wood subtype ~s"
                  ,subtype-var)))))

(defmacro ccl->wood-subtype (ccl-typecode)
  (let ((typecode-var (gensym)))
    `(let ((,typecode-var ,ccl-typecode))
       (or (svref *ccl-subtag->wood-subtype-table* ,typecode-var)
         (error "There is no wood subtype for ccl typecode ~s"
                ,typecode-var)))))

)  ; end of #+ppc-target progn
  

(defstruct uninitialize-structure)

(defvar *uninitialized-structure*
  (make-uninitialize-structure))

; general vector
(defun p-load-gvector (pheap disk-cache pointer depth subtype &optional
                             special-index-p special-index-value struct-p)
  (let* (length
         modified?
         (cached? t)
         (vector (maybe-cached-value pheap pointer
                   (setq cached? nil
                         length  (dc-%simple-vector-length disk-cache pointer))
                   (if (or (null depth)
                           (and (fixnump depth) (< depth length)))
                     (return-from p-load-gvector (pptr pheap pointer))
                     (let ((res (ccl::make-uvector
                                 length (wood->ccl-subtype subtype))))
                       (when struct-p
                         ; Make sure it looks like a structure
                         (setf (uvref res 0) (uvref *uninitialized-structure* 0)))
                       res)))))
    (when (or (not cached?)
              (listp depth)
              (and (eq depth t)
                   (let ((p-load-hash (p-load-hash pheap)))
                     (unless (gethash vector p-load-hash)
                       (setf (gethash vector p-load-hash) vector)))))
      (let ((next-level-depth (cond ((or (eq depth :single) (fixnump depth)) nil)
                                     ((listp depth) (car depth))
                                     (t depth))))
        (setq modified? t)
        (dotimes (i (or length (uvsize vector)))
          (setf (uvref vector i)
                (if (and special-index-p (funcall special-index-p i))
                  (funcall special-index-value disk-cache pointer i)
                  (multiple-value-bind (pointer immediate?)
                                       (dc-%svref disk-cache pointer i)
                    (if immediate?
                      pointer
                      (if (and struct-p (eql i 0))
                        (pointer-load pheap pointer :default disk-cache)
                        (pointer-load pheap pointer next-level-depth disk-cache)))))))))
    (values vector modified?)))

(defun p-load-header (pheap disk-cache pointer depth subtype &optional
                            special-index-p special-index-value)
;  (declare (type (integer 0 256) subtype))
  (if (or (null depth) (eq depth t))
    (p-load-gvector pheap disk-cache pointer depth subtype
                    special-index-p special-index-value)
    (let ((depth-list (list depth)))
      (declare (dynamic-extent depth-list))
      (p-load-gvector pheap disk-cache pointer depth-list subtype
                      special-index-p special-index-value))))

#-ppc-target
(defun p-load-arrayh (pheap disk-cache pointer depth subtype)
  (p-load-header pheap disk-cache pointer depth subtype))

#+ppc-target
(defun p-load-arrayh (pheap disk-cache pointer depth subtype)
  (declare (ignore subtype))
  (let* ((cached? t)
         (subtag (wood->ccl-subtype (old-ccl->wood-subtype (dc-%arrayh-type disk-cache pointer))))
         (rank (dc-array-rank disk-cache pointer))
         (vector (maybe-cached-value pheap pointer
                   (setq cached? nil)
                   (let* ((subtype (if (eql rank 1)
                                     ppc::subtag-vectorh
                                     ppc::subtag-arrayh))
                          (length (+ ppc::vectorh.element-count
                                     (if (eql rank 1) 0 rank))))
                     (ccl::make-uvector length subtype)))))
    (when (or (not cached?)
              (and (eq depth t)
                   (let ((p-load-hash (p-load-hash pheap)))
                     (unless (gethash vector p-load-hash)
                       (setf (gethash vector p-load-hash) vector)))))
      (if (eql rank 1)
        (setf (uvref vector ppc::vectorH.logsize-cell)
              (dc-%svref-fixnum disk-cache pointer $arh.fill '$arh.fill)
              (uvref vector ppc::vectorH.physsize-cell)
              (dc-%svref-fixnum disk-cache pointer $arh.vlen '$arh.vlen))
        (let ((total-size 1))
          (setf (uvref vector ppc::arrayH.rank-cell) rank)
          (dotimes (i rank)
            (let ((dim (dc-%svref-fixnum disk-cache pointer (+ $arh.fill i))))
              (declare (fixnum dim))
              (setq total-size (* total-size dim))
              (setf (uvref vector (+ ppc::arrayH.dim0-cell i)) dim)))
          (unless (fixnump total-size)
            (error "Array total size not a fixnum"))
          (setf (uvref vector ppc::vectorH.physsize-cell) total-size)))
      (setf (uvref vector ppc::vectorH.displacement-cell)
            (dc-%svref-fixnum disk-cache pointer $arh.offs '$arh.offs)
            (uvref vector ppc::vectorH.flags-cell)
            (dpb (dc-%arrayh-bits disk-cache pointer)
                 ppc::arrayH.flags-cell-bits-byte
                 (dpb subtag ppc::arrayH.flags-cell-subtag-byte 0))
            (uvref vector ppc::vectorH.data-vector-cell)
            (pointer-load pheap (dc-%svref disk-cache pointer $arh.vect) depth disk-cache)))
    vector))


(defun p-load-istruct (pheap disk-cache pointer depth subtype)
  (when (or (eq depth :single) (fixnump depth))
    (setq depth :default))
  (multiple-value-bind (vector modified?)
                       (p-load-gvector pheap disk-cache pointer depth subtype)
    (when (and (hash-table-p vector) modified?)
      (ccl::needs-rehashing vector))
    vector))

(defun p-load-struct (pheap disk-cache pointer depth subtype)
  (let ((vector (p-load-gvector pheap disk-cache pointer depth subtype nil nil t)))
    (when (ccl::uvector-subtype-p vector ccl::$v_struct)
      (let ((struct-type (uvref vector 0)))
        (when (typep struct-type 'pptr)
          (setf (uvref vector 0) (p-load struct-type)))))
    vector))

; ivectors
(defun p-load-ivector (pheap disk-cache pointer depth subtype)
  (declare (fixnum subtype))
  (let* ((cached? t)
         (res (maybe-cached-value pheap pointer
                (setq cached? nil)
                (let ((length (dc-uvsize disk-cache pointer))
                      (size (dc-%vector-size disk-cache pointer)))
                  (if (and depth
                           (or (not (fixnump depth)) (<= length depth)))
                    (load-byte-array
                     disk-cache (addr+ disk-cache pointer $v_data) size
                     (ccl::make-uvector length (wood->ccl-subtype subtype))
                     0 t)
                    (return-from p-load-ivector (pptr pheap pointer)))))))
    (when (and cached? (eq depth t))
      (let* ((size (dc-%vector-size disk-cache pointer))
             (subtype (dc-%vector-subtype disk-cache pointer)))
        (unless (eql (uvsize res) (dc-uvsize disk-cache pointer))
          (error "Inconsistency. Disk ivector is different size than in-memory version."))
        (unless (eql (wood->ccl-subtype subtype)
                     (ccl::%vect-subtype res))
          (error "Inconsistency. Subtype mismatch."))
        (load-byte-array disk-cache (addr+ disk-cache pointer $v_data) size res 0 t)))
    res))

#-ppc-target
(defun p-load-bignum (pheap disk-cache pointer depth subtype)
  (p-load-ivector pheap disk-cache pointer depth subtype))

;; bignums are stored in Wood files in MCL 2.0 format.
;; Their elements are 16-bit integers, and they are stored as sign/magnitude.
;; The first word's MSB is the sign bit. The rest of that word and the
;; other words are the magnitude.
;; Some day, recode this using bignum internals so that it doesn't cons so much.
#+ignore
(defun p-load-bignum (pheap disk-cache pointer depth subtype)
  (declare (ignore pheap depth subtype))
  (let ((p (+ pointer $v_data)))
    (accessing-disk-cache (disk-cache p)
      (let* ((first-word (load.uw 0))
             (negative? (logbitp 15 first-word))
             (value (logand #x7fff first-word))
             (index 0))
        (declare (fixnum first-word index))
        (dotimes (i (1- (the fixnum (dc-uvsize disk-cache pointer))))
          (setq value (+ (ash value 16) (load.uw (incf index 2)))))
        (if negative?
          (- value)
          value)))))

#-ignore ;; well it still conses but it WORKS.
;; load/store-byte-array, wood::read-string know about wood::$block-overhead
;; nobody else does - well some fill-xxx things whatever they are. and addr+
(defun p-load-bignum (pheap disk-cache pointer depth subtype)
  (declare (ignore pheap depth subtype))
  (let* ((byte-size (ash (dc-%vector-size disk-cache pointer) 2))
         (byte-array (make-array  byte-size :element-type '(unsigned-byte 8) :initial-element 0)))
    (declare (dynamic-extent byte-array))
    (wood::load-byte-array disk-cache (1- pointer) byte-size byte-array)
    ;(print (list string byte-size))    
    (let* ((size (+ (ash (uvref byte-array 5) 16)
                    (ash (uvref byte-array 6) 8)
                    (uvref byte-array 7))) ;; should get all 24 bits
           (index 8)
           (first-word (logior (lsh (uvref byte-array index) 8)(uvref byte-array (+ index 1))))
           (negative? (logbitp 15 first-word))
           (value (logand #x7fff first-word)))
      (declare (fixnum size index))
      (dotimes (i (1- (ash size -1)))
        (incf index 2)
        (setq value (+ (ash value 16) (logior (lsh (uvref byte-array index) 8)(uvref byte-array (+ index 1)))))
        )
      (if negative?
          (- value)
          value))))

#+ppc-target
(defun p-load-bit-vector (pheap disk-cache pointer depth subtype)
  (declare (fixnum subtype))
  (let* ((cached? t)
         (res (maybe-cached-value pheap pointer
                (setq cached? nil)
                (let ((length (dc-uvsize disk-cache pointer))
                      (size (dc-%vector-size disk-cache pointer)))
                  (declare (fixnum size))
                  (load-byte-array
                   disk-cache (addr+ disk-cache pointer (1+ $v_data)) (1- size)
                   (ccl::make-uvector length (wood->ccl-subtype subtype))
                   0 t)))))
    (when (and cached? (eq depth t))
      (let* ((size (dc-%vector-size disk-cache pointer))
             (subtype (dc-%vector-subtype disk-cache pointer)))
        (declare (fixnum size))
        (unless (eql (uvsize res) (dc-uvsize disk-cache pointer))
          (error "Inconsistency. Disk ivector is different size than in-memory version."))
        (unless (eql (wood->ccl-subtype subtype)
                     (ccl::%vect-subtype res))
          (error "Inconsistency. Subtype mismatch."))
        (load-byte-array disk-cache (addr+ disk-cache pointer (1+ $v_data)) (1- size) res 0 t)))
    res))

(defun p-load-lfun-vector (pheap disk-cache pointer depth subtype)
  (declare (ignore pheap disk-cache pointer depth subtype))
  (error "Inconsistency: WOOD does not tag vectors as ~s" '$t_lfunv))

(defun p-load-pkg (pheap disk-cache pointer depth subtype)
  (declare (ignore depth subtype))
  (maybe-cached-value pheap pointer
    (let* ((names (pointer-load-internal pheap (dc-%svref disk-cache pointer $pkg.names)
                                         t disk-cache))
           (name (car names)))
      (or (find-package name)
          (make-package name :nicknames (cdr names) :use nil)))))

;; End of loaders for $t_vector subtypes

(defun p-load-symbol (pheap disk-cache pointer depth)
  (declare (ignore depth))
  (maybe-cached-value pheap pointer
    (let ((pname (pointer-load-internal
                  pheap
                  (read-long disk-cache (addr+ disk-cache pointer $sym_pname))
                  :default disk-cache))
          (pkg (pointer-load-internal
                pheap
                (read-long disk-cache (addr+ disk-cache pointer $sym_package))
                :default disk-cache)))
      (if pkg
        (intern pname pkg)
        (make-symbol pname)))))

(defun p-load-dfloat (pheap disk-cache pointer depth)
  (maybe-cached-value pheap pointer
    (if (eq depth nil)
      (return-from p-load-dfloat (pptr pheap pointer)))
    (values (read-double-float disk-cache (- pointer $t_dfloat)) t)))

(defun p-load-cons (pheap disk-cache pointer depth)
    (p-load-cons-internal pheap disk-cache pointer depth nil nil))

(defvar *avoid-cons-caching* nil)

(defun p-load-cons-internal (pheap disk-cache pointer depth set-my-cdr res)
  (if (eql pointer $pheap-nil)
    (progn
      (when set-my-cdr
        (setf (cdr set-my-cdr) nil))
      res)
    (let* ((cached? t)
           (cons (block avoid-cache
                   (maybe-cached-value pheap pointer
                     (setq cached? nil)
                     (if (or (null depth) (and (fixnump depth) (<= depth 0)))
                       (return-from avoid-cache (pptr pheap pointer))
                       (let ((res (cons nil nil)))
                         (if *avoid-cons-caching*
                           (return-from avoid-cache res)
                           res)))))))
      (when set-my-cdr
        (setf (cdr set-my-cdr) cons))
      (if (and (listp cons)
               (or (not cached?)
                   (and (eq depth t)
                        (let ((p-load-hash (p-load-hash pheap)))
                          (unless (gethash cons p-load-hash)
                            (setf (gethash cons p-load-hash) cons))))))
        (let ((next-level-depth (unless (or (eq depth :single) (fixnump depth))
                                  depth))
              (rest-depth (if (fixnump depth) (1- depth) depth)))
          (multiple-value-bind (car car-imm?) (read-pointer disk-cache (- pointer $t_cons))
            (multiple-value-bind (cdr cdr-imm?) (read-pointer disk-cache pointer)
              (setf (car cons)
                    (if car-imm?
                      car
                      (pointer-load pheap car next-level-depth disk-cache)))
              (if (and (not cdr-imm?) (dc-consp disk-cache cdr))
                ; THIS MUST BE A TAIL CALL!!
                (p-load-cons-internal pheap disk-cache cdr rest-depth cons (or res cons))
                (progn
                  (setf (cdr cons)
                        (if cdr-imm?
                          cdr
                          (pointer-load pheap cdr rest-depth disk-cache)))
                  (or res cons))))))
        (or res cons)))))

; All this hair is to create the lfun before loading its immediates.
; This allows circular references.
(defun p-load-lfun (pheap disk-cache pointer depth)
  (let (imms imms-address indices
        (imms-length 0))
    (declare (fixnum imms-length))
    (let ((lfun (maybe-cached-value pheap pointer
                  (if (null depth)
                    (return-from p-load-lfun (pptr pheap pointer))
                    (let* ((vector-pointer (+ pointer (- $t_vector $t_lfun)))
                           (length (1- (dc-uvsize disk-cache vector-pointer)))
                           (vector (make-array length)))
                      (declare (fixnum length) (dynamic-extent vector))
                      (setq imms (make-array imms-length :initial-element '*$temp$*))
                      (dotimes (i length)
                        (declare (fixnum i))
                        (multiple-value-bind (val imm?) (dc-%svref disk-cache vector-pointer (1+ i))
                          (setf (ccl::%svref vector i)
                                (if imm? val (pointer-load-internal pheap val :default disk-cache)))))
                      (let (f)
                        (multiple-value-setq (f imms indices)
                          (ccl::applyv 'ccl::join-lfun-with-dummy-immediates vector))
                        (setq imms-address (dc-%svref disk-cache vector-pointer 0)
                              imms-length (dc-uvsize disk-cache imms-address))
                        (unless (eql (length imms) imms-length)
                          (error "Immediates count mismatch. Was: ~d, SB: ~d" imms imms-length))
                        f))))))
      (when imms
        (dotimes (i imms-length)
          (multiple-value-bind (val imm?) (dc-%svref disk-cache imms-address i)
            (setf (ccl::%svref imms i)
                  (if imm? val (pointer-load-internal pheap val :default disk-cache)))))
        (ccl::%patch-lfun-immediates lfun imms indices))
      lfun)))

; Load the result of p-make-load-function-object
(defun p-load-load-function (pheap disk-cache pointer depth subtype)
  (declare (ignore subtype))
  (let* ((object (maybe-cached-value pheap pointer
                   (if (null depth)
                     (return-from p-load-load-function (pptr pheap pointer))
                     (let ((load-function.args (pointer-load 
                                                pheap
                                                (dc-%svref disk-cache pointer $load-function.load-list)
                                                :default
                                                disk-cache)))
                       (apply (car load-function.args)
                              (cdr load-function.args))))))
         (init-function.args (pointer-load 
                              pheap
                              (dc-%svref disk-cache pointer $load-function.init-list)
                              :default
                              disk-cache)))
      (when init-function.args
            (apply (car init-function.args)
                   object
                   (cdr init-function.args)))
      object))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Writing Lisp data into the pheap
;;;

;;; The descend argument can take three values:
;;;
;;; :default     The default. Don't descend if you find an address in the cache
;;; nil          Same as :default, but newly consed values are not cached.
;;;              Allows storing stack-consed objects in the persistent heap.
;;; t            Recursively descend and overwrite any cached values.

(defun (setf root-object) (new-root pheap)
  (multiple-value-bind (pointer immediate?) (%p-store pheap new-root)
    (setf (dc-root-object (pheap-disk-cache pheap) immediate?) pointer)
    (if immediate?
      pointer
      (pptr pheap pointer))))

(defun (setf dc-root-object) (new-root disk-cache imm?)
  (setf (dc-%svref disk-cache $root-vector $pheap.root imm?) new-root))

(defun p-store (pheap object &optional (descend :default))
  (multiple-value-bind (pointer immediate?) (%p-store pheap object descend)
    (if (or immediate? (null pointer))
      pointer
      (pptr pheap pointer))))

(defun p-loaded? (pptr)
  (if (pptr-p pptr)
    (gethash (pptr-pointer pptr) (pheap->mem-hash (pptr-pheap pptr)))
    pptr))

; Again, maybe we shouldn't allow other than NIL for the object
;;; ----@@@@ This should be (setf p-loaded?) but that didn't work as a patch.
(defun set-p-loaded? (pptr object)
  (setq pptr (require-type pptr 'pptr))
  (if (pptr-p object)
    (require-satisfies eq object pptr)
    (let ((pheap (pptr-pheap pptr))
          (pointer (pptr-pointer pptr)))
      (with-databases-locked
        (let ((mem->pheap-hash (mem->pheap-hash pheap))
              (pheap->mem-hash (pheap->mem-hash pheap)))
          (if object
            (setf (gethash object mem->pheap-hash) pointer
                  (gethash pointer pheap->mem-hash) object)
            (let ((object (gethash pointer pheap->mem-hash)))
              (when object
                (remhash object mem->pheap-hash)
                (remhash pointer pheap->mem-hash))))))))
  object)

(defun p-stored? (pheap object)
  (cond ((null object) nil)
        ((pptr-p object)
         (and (eq pheap (pptr-pheap object))
              object))
        (t (multiple-value-bind (pointer imm?) (%p-store-hash-key pheap object)
             (cond (imm? pointer)
                   (pointer (pptr pheap pointer))
                   (t nil))))))

(defsetf p-stored? set-p-stored?)

; Maybe we should only allow NIL for PPTR.
; Allowing random other PPTRs gives people rope to hang themselves.
;;; ----@@@@ This should be (setf p-stored?) but that didn't work as a patch.
(defun set-p-stored? (pheap object pptr-or-nil)
  (if (pptr-p object)
    (require-satisfies eq pptr-or-nil object)
    (when object
      (with-databases-locked
        (let ((mem->pheap-hash (mem->pheap-hash pheap))
              (pheap->mem-hash (pheap->mem-hash pheap)))
          (if pptr-or-nil
            (let ((pointer (pptr-pointer pptr-or-nil)))
              (require-pptr-pheap pptr-or-nil pheap)
              (setf (gethash object mem->pheap-hash) pointer
                    (gethash pointer pheap->mem-hash) object))
            (let ((pointer (gethash object mem->pheap-hash)))
              (when pointer
                (remhash object mem->pheap-hash)
                (remhash pointer pheap->mem-hash) nil)))))))
  pptr-or-nil)


(defun require-pptr-pheap (pptr pheap)
  (unless (eq (pptr-pheap pptr) pheap)
    (error "wrong pheap!")))

(defun pheap-pptr-pointer (pptr pheap)
  (require-pptr-pheap pptr pheap)
  (pptr-pointer pptr))

#+ppc-target
(progn

(declaim (inline %ccl2-fixnum-p))

(defun %ccl2-fixnum-p (ppc-fixnum)
  (declare (fixnum ppc-fixnum))
  (and (>= ppc-fixnum (- (ash 1 28))) (< ppc-fixnum (ash 1 28))))

)

(declaim (inline immediate-object-p))

(defun immediate-object-p (object)
  #-ppc-target
  (ccl::dtagp object (+ (ash 1 ccl::$t_fixnum) 
                        (ash 1 ccl::$t_sfloat)
                        (ash 1 ccl::$t_imm)))
  #+ppc-target
  (let ((typecode (ccl::ppc-typecode object)))
    (if (eql typecode ppc::tag-fixnum)
      (%ccl2-fixnum-p object)
      (eql typecode ppc::tag-imm))))

; Same comment here as for pointer-load:
; this may execute with-databases-locked for a long time.
(defun %p-store (pheap object &optional (descend :default))
  (unless (or (eq descend :default)
              (null descend)
              (eq descend t)
              (eq descend :store-slots-again))
    (setq descend (require-type descend '(member :default nil t :store-slots-again))))
  (cond ((immediate-object-p object)
         (values object t))
        ((typep object 'pptr)
         (if (eq pheap (pptr-pheap object))
           (pptr-pointer object)
           (let ((pptr (or (p-store-pptr pheap object) object)))
             (require-pptr-pheap pptr pheap)
             (pptr-pointer pptr))))
        (t (with-databases-locked
            (if (or (eq descend :default) (inside-p-store pheap))
             (%p-store-internal pheap object descend)
             (unwind-protect
               (progn
                 (setf (inside-p-store pheap) t)
                 (%p-store-internal pheap object descend))
               (clrhash (p-store-hash pheap))
               (setf (inside-p-store pheap) nil)))))))

(defgeneric p-store-pptr (pheap pptr)
  (:method ((pheap pheap) (pptr t))
    nil))

; This happenned three times so I made it into a macro.
(defmacro %p-store-object-body ((pheap object descend disk-cache address)
                                    &body body
                                    &environment env)
  (multiple-value-bind (body decls) (ccl::parse-body body env)
    (unless (null (cddr body))
      (error "body must be of the form (conser filler)"))
    (let ((conser (car body))
          (filler (cadr body))
          (conser-var (gensym))
          (filler-var (gensym)))
      `(let ((,conser-var #'(lambda (,disk-cache ,object)
                              (declare (ignore-if-unused ,object))
                              ,@decls
                              ,conser))
             (,filler-var #'(lambda (,pheap ,disk-cache ,object ,address ,descend)
                              (declare (ignore-if-unused ,pheap ,descend))
                              ,@decls
                              ,filler)))
         (declare (dynamic-extent ,conser-var ,filler-var))
         (do-%p-store-object-body ,pheap ,object ,descend ,conser-var ,filler-var)))))

(defun do-%p-store-object-body (pheap object descend conser filler)
  (let* ((disk-cache (pheap-disk-cache pheap))
         (cached? t)
         (address nil)
         (p-store-hash (and (neq descend :default) (p-store-hash pheap)))
         (p-store-hash? (and p-store-hash (gethash object p-store-hash)))
         (orig-descend descend))
    (when p-store-hash?
      (return-from do-%p-store-object-body p-store-hash?))
    (when (eq descend :store-slots-again)
      (setq orig-descend t
            descend :default))
    (block avoid-cache
      (setq address (careful-maybe-cached-address pheap object
                      #+remove (when (eq descend nil)
                                   (when (setq address (gethash object (p-store-hash pheap)))
                                     (return-from do-%p-store-object-body address)))
                      (setq cached? nil)
                      (prog1
                        (setq address (funcall conser disk-cache object))
                        (when (or (eq descend nil)
                                  (and (consp object) *avoid-cons-caching*))
                          (return-from avoid-cache))))))
    (when p-store-hash
      (setf (gethash object p-store-hash) address)
      (when (eq orig-descend t)
        (setq cached? nil)))
    (unless cached?
      (funcall filler pheap disk-cache object address descend))
    address))

#| ; Not used. Keep around in case we need to reincarnate it later
(defmacro %p-store-object-body-with-load-function ((pheap object descend disk-cache address)
                                                          &body body
                                                          &environment env)
  (multiple-value-bind (body decls) (ccl::parse-body body env)
    (destructuring-bind (conser filler) body
      (let ((conser-var (gensym))
            (filler-var (gensym)))
        `(let ((,conser-var #'(lambda (,disk-cache) ,@decls ,conser))
               (,filler-var #'(lambda (,disk-cache ,address) ,@decls ,filler)))
           (declare (dynamic-extent ,conser-var ,filler-var))
           (do-%p-store-object-body-with-load-function ,pheap ,object ,descend ,conser-var ,filler-var))))))

; New function
(defun do-%p-store-object-body-with-load-function (pheap object descend conser filler)
  (let* (checked-load-function? load-function.args init-function.args)
    (%p-store-object-body (pheap object descend disk-cache address)
      (progn
        (multiple-value-setq (load-function.args init-function.args)
          (p-make-load-function-using-pheap pheap object))
        (setq checked-load-function? t)
        (if load-function.args
            (if (pptr-p load-function.args)
              (pheap-pptr-pointer load-function.args pheap)
              (dc-make-uvector disk-cache $load-function-size $v_load-function))
            (funcall conser disk-cache)))
      (progn
        (unless checked-load-function?
          (multiple-value-setq (load-function.args init-function.args)
            (p-make-load-function-using-pheap pheap object)))
        (if load-function.args
          (if (pptr-p load-function.args)
            (unless checked-load-function?
              (require-satisfies eql (pheap-pptr-pointer load-function.args pheap) address))
            (progn
              (unless checked-load-function?
                (require-satisfies dc-vector-subtype-p disk-cache address $v_load-function))
              (%fill-load-function-object
               pheap disk-cache address load-function.args init-function.args)))
          (funcall filler disk-cache address))))))
|#

(defun %p-store-internal (pheap object descend)
  (cond ((immediate-object-p object)
         (values object t))
        ((null object) $pheap-nil)
        (t (or (block no-load-function
                 (let* (checked-load-function? got-load-function? load-function.args init-function.args)
                   (when (or (eq descend t) (eq descend :store-slots-again))
                     (multiple-value-setq (load-function.args init-function.args)
                       (p-make-load-function-using-pheap pheap object))
                     (setq got-load-function? t)
                     (unless load-function.args
                       (return-from no-load-function nil)))
                   (%p-store-object-body (pheap object descend disk-cache address)
                     (progn
                       (unless got-load-function?
                         (multiple-value-setq (load-function.args init-function.args)
                           (p-make-load-function-using-pheap pheap object))
                         (setq got-load-function? t))
                       (setq checked-load-function? t)
                       (if load-function.args
                         (if (pptr-p load-function.args)
                           (pheap-pptr-pointer load-function.args pheap)
                           (dc-make-uvector disk-cache $load-function-size $v_load-function))
                         (return-from no-load-function nil)))
                     (progn
                       (unless got-load-function?
                         (multiple-value-setq (load-function.args init-function.args)
                           (p-make-load-function-using-pheap pheap object)))
                       (if load-function.args
                         (if (pptr-p load-function.args)
                           (unless checked-load-function?
                             (require-satisfies eql (pheap-pptr-pointer load-function.args pheap) address))
                           (progn
                             (unless checked-load-function?
                               (require-satisfies dc-vector-subtype-p disk-cache address $v_load-function))
                             (%fill-load-function-object
                              pheap disk-cache address load-function.args init-function.args descend)))
                         (return-from no-load-function nil))))))
               (%p-store-object pheap object descend)))))

(defmethod %p-store-object (pheap (object pptr) descend)
  (declare (ignore descend))
  (require-pptr-pheap object pheap)
  (pptr-pointer object))

(defmethod %p-store-object (pheap (object symbol) descend)
  (if (null object)
    $pheap-nil
    (maybe-cached-address pheap object
      (let ((address (dc-intern (pheap-disk-cache pheap)
                                (symbol-name object)
                                (symbol-package object)
                                t
                                (pheap-consing-area pheap)
                                pheap)))
        (when (eq descend nil)
          (return-from %p-store-object address))
        address))))

(defmethod %p-store-object (pheap (object null) descend)
  (declare (ignore pheap descend))
  $pheap-nil)

;;For general use, this should default to T, but for Hula we only save incidental lfuns in wood
;; heaps, so do not save debugging info for them.
(defvar *preserve-lfun-info* nil)

(defmethod %p-store-object (pheap (object function) descend)
  (let* ((split-vec (apply #'vector (split-lfun object *preserve-lfun-info*)))
         (subtype (ccl->wood-subtype (ccl::%vect-subtype split-vec)))
         (length (length split-vec)))
    (%p-store-object-body (pheap object descend disk-cache address)
      (declare (ignore object))
      (+ (dc-make-uvector disk-cache length subtype) (- $t_lfun $t_vector))
      (p-store-gvector pheap split-vec descend disk-cache (+ address (- $t_vector $t_lfun)) length))))

(defmethod %p-store-object (pheap (object cons) descend)
  (%p-store-object-body (pheap object descend disk-cache address)
    (dc-cons disk-cache $pheap-nil $pheap-nil)
    (progn
      (multiple-value-bind (car car-imm?) (%p-store pheap (car object) descend)
        (setf (dc-car disk-cache address car-imm?) car))
      (%p-store-cdr-of-cons pheap (cdr object) descend disk-cache address address))))

(defun %p-store-cdr-of-cons (pheap cdr descend disk-cache outer-address result)
  (if (consp cdr)
    ; This cached? & inner-cached? stuff is to get around a compiler bug
    ; that causes the recursive call to %p-store-cdr-of-cons to not be tail-called.
    (let (cached? address)
      (let* ((inner-cached? t))
        (setq address (%p-store-object-body (pheap cdr descend disk-cache address)
                        (declare (ignore-if-unused cdr disk-cache address))
                        (dc-cons disk-cache $pheap-nil $pheap-nil)
                        (setq inner-cached? nil))
              cached? inner-cached?))              
      (setf (dc-cdr disk-cache outer-address) address)
      (unless cached?
        (multiple-value-bind (car car-imm?) (%p-store pheap (car cdr) descend)
          (setf (dc-car disk-cache address car-imm?) car))
        (setq cdr (cdr cdr))
        ; THIS MUST BE A TAIL CALL!!
        (%p-store-cdr-of-cons pheap cdr descend disk-cache address result)))
    (multiple-value-bind (cdr cdr-imm?) (%p-store pheap cdr descend)
      (setf (dc-cdr disk-cache outer-address cdr-imm?) cdr)
      result)))

(defmethod %p-store-object (pheap (object double-float) descend)
  (maybe-cached-address pheap object
    (let ((address (dc-cons-float (pheap-disk-cache pheap)
                                  object
                                  (pheap-consing-area pheap))))
      (when (eq descend nil)
        (return-from %p-store-object address))
      address)))

(defun p-cons-float (pheap float)
  (pptr pheap (dc-cons-float (pheap-disk-cache pheap) float)))       

(defun dc-cons-float (disk-cache value &optional area)
  (setq value (require-type value 'float))
  (let ((address (%allocate-storage disk-cache area 8)))
    (setf (read-double-float disk-cache (decf address $t_cons)) value)
    (+ $t_dfloat address)))

(defmethod %p-store-object (pheap (object package) descend)
  (maybe-cached-address pheap object
    (let ((address (dc-find-or-make-package (pheap-disk-cache pheap) object t)))
      (when (eq descend nil)
        (return-from %p-store-object address))
      address)))

(defmethod %p-store-object (pheap (object structure-object) descend)
  (let* ((length (uvsize object))
         (consed? nil))
    (%p-store-object-body (pheap object descend disk-cache address)
      (progn
        (setq consed? t)
        (dc-make-uvector disk-cache length $v_struct))
      (progn
        (unless consed?
          ; Ensure that p-make-load-function-using-pheap method didn't change too much to handle
          (require-satisfies dc-vector-subtype-p disk-cache address $v_struct)
          (require-satisfies eql length (dc-uvsize disk-cache address)))
        (p-store-gvector pheap object descend disk-cache address length)))))

; Called by %p-store-object for structure-object and standard-object
(defun %fill-load-function-object (pheap disk-cache address
                                              load-function.args init-function.args descend)
  (progn
    (require-satisfies p-consp load-function.args)
    (require-satisfies p-listp init-function.args)
    (dc-%svfill disk-cache address
      $load-function.load-list (%p-store pheap load-function.args descend)
      $load-function.init-list (%p-store pheap init-function.args descend))))


#-ppc-target
(defmethod %p-store-object (pheap (object t) descend)
  (if (uvectorp object)
    (if (ccl::%lfun-vector-p object)
      (%p-store-lfun-vector pheap object descend)
      (%p-store-uvector pheap object descend))
    (error "Don't know how to store ~s" object)))

#+ppc-target
; No lfun vectors on the PPC
(defmethod %p-store-object (pheap (object t) descend)
  (if (uvectorp object)
    (%p-store-uvector pheap object descend)
    (error "Don't know how to store ~s" object)))

#+ppc-target
; Some ppc fixnums aren't Wood fixnums
(defmethod %p-store-object (pheap (object fixnum) descend)
  (if (%ccl2-fixnum-p object)
    (progn
      ; We should only get here if %ccl2-fixnum-p is false.
      (cerror "Do the right thing" "Object, ~s,  doesn't satisfy ~s" object '%ccl2-fixnum-p)
      (values object t))
    (p-store-bignum pheap object descend)))
        
(defun %p-store-uvector (pheap object descend)
  (let* ((length (uvsize object))
         (subtype (ccl->wood-subtype (ccl::%vect-subtype object)))
         (store-function (or (svref *p-store-subtype-functions* subtype)
                             (error "Can't store vector of subtype ~s: ~s" subtype object))))
    #+ppc-target
    (when (eql subtype $v_arrayh)
      (return-from %p-store-uvector
        (p-store-arrayh pheap object descend)))
    #+ppc-target
    (when (eql subtype $v_bignum)
      (return-from %p-store-uvector  ;; now get out please
        (p-store-bignum pheap object descend)))
    #+ccl-3
    (when (eql subtype $v_nhash)
      (return-from %p-store-uvector
        (p-store-nhash pheap object descend)))
    (%p-store-object-body (pheap object descend disk-cache address)
      (dc-make-uvector disk-cache length subtype)
      (funcall store-function pheap object descend disk-cache address length))))

#+ignore
(defun p-store-bignum (pheap object descend)
  (let* ((negative? (< object 0))
         (abs (if negative? (- object) object))
         (bits (integer-length abs)))
    (multiple-value-bind (words zero-bits) (ceiling bits 16)
      (declare (fixnum words bits))
      (when (eql 0 zero-bits)
        (incf words))
      (%p-store-object-body (pheap object descend disk-cache address)
        (declare (ignore object))
        (dc-make-uvector disk-cache words $v_bignum)
        (let ((position 0)
              (index (* 2 (1- words))))
          (declare (fixnum index))
          (accessing-disk-cache (disk-cache (+ address $v_data))
            (dotimes (i words)
              (let ((word (if (> position bits) 0 (ccl::load-byte 16 position abs))))
                (declare (fixnum word))
                (when (and negative? (eql index 0))
                  (setq word (logior #x8000 word)))
                (store.w word index)
                (incf position 16)
                (decf index 2)))))))))

;; it WORKS
#-ignore 
(defun p-store-bignum (pheap object descend)
  (declare (ignore descend))
  (let* ((negative? (< object 0))
         (abs (if negative? (- object) object))
         (bits (integer-length abs)))
    (multiple-value-bind (words zero-bits) (ceiling bits 16)
      (declare (fixnum words bits))
      (when (eql 0 zero-bits)
        (incf words))
      (let* ((bytes (+ words words))
             (disk-cache (pheap-disk-cache pheap))
             (array-length (+ $vector-header-size (normalize-size bytes)))
             (address (- (%allocate-storage disk-cache nil array-length)
                         $t_cons))
             (start $vector-header-size)
             (byte-array (make-array array-length :element-type '(unsigned-byte 8) :initial-element 0)))
        (declare (dynamic-extent byte-array))
        (declare (fixnum bytes start))
        ;(cerror "a" "b")
        ;;fill the byte-array 
        (setf (uvref byte-array 2) (ash $vector-header -8))
        (setf (uvref byte-array 3) (logand $vector-header #xff))  ;;?? $vector-header
        (setf (uvref byte-array 4) $v_bignum)
        (setf (uvref byte-array 5) (ash bytes -16))
        (setf (uvref byte-array 6) (logand #xff (ash bytes -8)))
        (setf (uvref byte-array 7) (logand #xff bytes)) ;; do all 3 bytes of size
        ;(cerror "c" "d")
        (if nil ;(ccl::bignump abs) ;; nope!
          (ccl::%copy-ivector-to-ivector abs 0 byte-array start bytes) 
          ;; works whether or not an mcl bignum.
          (let ((byte-pos (* bytes 8)))
            (declare (fixnum byte-pos))
            (dotimes (i bytes)
              (decf byte-pos 8)
              (setf (uvref byte-array (+ i start)) (ldb (byte 8 byte-pos) abs))
              )))
        (when negative? ;; get the sign right too
          (setf (uvref byte-array start)(logior #x80 (uvref byte-array start))))            
        ;(cerror "e" "f")
        (store-byte-array byte-array disk-cache address array-length 0 t)
        (+ address $t_vector) ;; aka 1
))))

#+ppc-target
(defun p-store-arrayh (pheap object descend)
  (assert (ccl::%array-is-header object))
  (multiple-value-bind (displaced-to offset) (displaced-array-p object)
    (let* ((rank (array-rank object))
           (dims (unless (eql rank 1) (array-dimensions object)))
           (total-size (array-total-size object))
           (fill (and (eql rank 1) (array-has-fill-pointer-p object) (fill-pointer object)))
           (simple (ccl::simple-array-p object))
           (subtype (old-wood->ccl-subtype (ccl->wood-subtype (ccl::%array-header-subtype object))))
           (adjustable (adjustable-array-p object))
           (length (if (eql rank 1) 
                     (+ $arh.fill 1)
                     (+ $arh.dims rank 1)))
           (bits (+ (if fill (ash 1 $arh_fill_bit) 0)
                    (if simple (ash 1 $arh_simple_bit) 0)
                    (if (ccl::%array-is-header displaced-to) (ash 1 $arh_disp_bit) 0)
                    (if adjustable (ash 1 $arh_adjp_bit) 0)))
           (flags (+ (ash rank (+ 2 16 -3))
                     (ash subtype (+ 8 -3))
                     (ash bits -3))))
      (unless (fixnump flags)
        (error "Array header flags not a fixnum. Rank must be too big."))
      (unless displaced-to
        (error "~s should be displaced but isn't"))
      (%p-store-object-body (pheap object descend disk-cache address)
        (declare (ignore object))
        (dc-make-uvector disk-cache length $v_arrayh)
        (progn
          (dc-%svfill disk-cache address
            ($arh.fixnum t) flags
            ($arh.offs t) offset)
          (if (eql rank 1)
            (dc-%svfill disk-cache address
              ($arh.vlen t) total-size
              ($arh.fill t) (or fill total-size))
            (progn
              (setf (dc-%svref disk-cache address $arh.dims t) rank)
              (dotimes (i rank)
                (setf (dc-%svref disk-cache address (+ $arh.fill i) t)
                      (pop dims)))))
          (setf (dc-%svref disk-cache address $arh.vect)
                (%p-store pheap displaced-to descend)))))))

(defun p-store-gvector (pheap object descend disk-cache address length)
  (dotimes (i length)
    (multiple-value-bind (element imm?) (%p-store pheap (uvref object i) descend)
      (setf (dc-%svref disk-cache address i imm?) element))))

(defun p-store-ivector (pheap object descend disk-cache address length)
  (declare (ignore pheap descend length))
  (let* ((bytes (dc-%vector-size disk-cache address)))
    (store-byte-array object disk-cache (addr+ disk-cache address $v_data) bytes 0 t)))

#+ppc-target
(defun p-store-bit-vector (pheap object descend disk-cache address length)
    (declare (ignore pheap descend length))
    (let* ((bytes (dc-%vector-size disk-cache address)))
      (declare (fixnum bytes))
      (store-byte-array object disk-cache (addr+ disk-cache address (1+ $v_data)) (1- bytes) 0 t)))

#-ppc-target
(defun %p-store-lfun-vector (pheap object descend)
  (%p-store-object-body (pheap object descend disk-cache address)
    (dc-make-uvector disk-cache $load-function-size $v_load-function)
    (let* ((load-function.args 
            `(ccl::%lfun-vector ,(ccl::%lfun-vector-lfun object))))
      (%fill-load-function-object 
       pheap disk-cache address load-function.args nil descend))))

(defmethod p-make-load-function-using-pheap ((pheap pheap) (hash hash-table))
  (let ((rehashF (function-name (ccl::nhash.rehashF hash)))
        (keytransF (ccl::nhash.keytransF hash))
        (compareF (ccl::nhash.compareF hash))
        (vector (ccl::nhash.vector hash))
        (count (ccl::nhash.count hash))
        (locked-additions (ccl::nhash.locked-additions hash)))
    (flet ((convert (f)
             (cond ((fixnump f) f)
                   ((symbolp f) (list f))
                   (t (function-name f)))))
      (values
       `(ccl::%cons-hash-table
         nil nil nil nil ,(ccl::nhash.grow-threshold hash) ,(ccl::nhash.rehash-ratio hash) ,(ccl::nhash.rehash-size hash))
       `(%initialize-hash-table ,rehashF ,(convert keytransF) ,(convert compareF)
                                ,vector ,count ,locked-additions)))))

(defun %initialize-hash-table (hash rehashF keytransF compareF vector count locked-additions)
  (flet ((convert (f)
           (cond ((symbolp f) (symbol-function f))
                 ((listp f) (car f))
                 (t f))))
    (setf (ccl::nhash.rehashF hash) (symbol-function rehashF)
          (ccl::nhash.keytransF hash) (convert keytransF)
          (ccl::nhash.compareF hash) (convert compareF)
          (ccl::nhash.vector hash) vector
          (ccl::nhash.count hash) count
          (ccl::nhash.locked-additions hash) locked-additions)
    ; Rehash all hash tables. Everything hashes differently between 3.x and 4.x
    (ccl::needs-rehashing hash)
    (when (eq rehashF 'ccl::%no-rehash)
      (ccl::%maybe-rehash hash))))

#-ccl-3
(defun p-load-nhash (pheap disk-cache pointer depth subtype)
  (p-load-header pheap disk-cache pointer depth subtype))

; ccl-3 stores 2 more words in the header than ccl-2 did.
; It uses the unused header word and the other two for
; the the cache-index, cache-key, & cache-value
#+ccl-3
(progn

(defconstant $old-nhash.vector-overhead 8)
(defconstant $old-nhash.vector-header-size 7)
(defconstant $new-nhash.vector-overhead 10)
(defconstant $nhash.vector-overhead-delta
  (- $new-nhash.vector-overhead $old-nhash.vector-overhead))

(defun p-load-nhash (pheap disk-cache pointer depth subtype)
  (assert (eql subtype $v_nhash))
  (let* (length
         (cached? t)
         (vector (maybe-cached-value pheap pointer
                   (setq cached? nil
                         length (dc-%simple-vector-length disk-cache pointer))
                   (let* ((pairs (- length $old-nhash.vector-overhead))
                          (element-count (ash pairs -1))
                          (res (ccl::%cons-nhash-vector element-count))
                          (res-length (uvsize res)))
                     (declare (fixnum disk-length pairs element-count res-length))
                     (assert (eql (the fixnum (- length $old-nhash.vector-overhead))
                                  (the fixnum (- res-length $new-nhash.vector-overhead))))
                     res))))
    (when (or (not cached?)
              (and (eq depth t)
                   (let ((p-load-hash (p-load-hash pheap)))
                     (unless (gethash vector p-load-hash)
                       (setf (gethash vector p-load-hash) vector)))))
      (dotimes (i (the fixnum (or length (dc-%simple-vector-length disk-cache pointer))))
        (declare (fixnum i))
        (let ((j (if (< i $old-nhash.vector-header-size)
                   i
                   (the fixnum 
                     (+ i $nhash.vector-overhead-delta)))))
          (unless (eql i $old-nhash.vector-header-size)
            (setf (uvref vector j)
                  (multiple-value-bind (pointer immediate?)
                                       (dc-%svref disk-cache pointer i)
                    (if immediate?
                      pointer
                      (pointer-load pheap pointer depth disk-cache))))))))
    vector))

(defun p-store-nhash (pheap object descend)
  (let* ((length (uvsize object))
         (old-length (- length $nhash.vector-overhead-delta)))
    (declare (fixnum length old-length))
    (%p-store-object-body (pheap object descend disk-cache address)
      (dc-make-uvector disk-cache old-length $v_nhash)
      (progn
        (setf (dc-%svref disk-cache address $old-nhash.vector-header-size) $pheap-nil)
        (dotimes (i length)
          (declare (fixnum i))
          (let ((j i))
            (declare (fixnum j))
            (unless (and (>= i $old-nhash.vector-header-size)
                         (progn (decf j $nhash.vector-overhead-delta)
                                (< i $new-nhash.vector-overhead)))
              (multiple-value-bind (element imm?) (%p-store pheap (uvref object i) descend)
                (setf (dc-%svref disk-cache address j imm?) element)))))))))

)  ; end of progn

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Useful macros for predicates and accessors
;;

(defmacro p-dispatch (p if-pptr otherwise &optional make-pptr? apply?)
  (let ((p (if (listp p) (car p) p))
        (args (if (listp p) (cdr p))))
    (flet ((add-apply (form)
             (if apply?
               `(apply #',(car form) ,@(cdr form))
               form)))
      `(if (typep ,p 'pptr)
         (locally (declare (type pptr ,p) (optimize (speed 3) (safety 0)))
           ,(if make-pptr?
              (let ((pheap (make-symbol "PHEAP"))
                    (disk-cache (make-symbol "DISK-CACHE"))
                    (pointer (make-symbol "POINTER"))
                    (immediate? (make-symbol "IMMEDIATE?")))
                `(let* ((,pheap (pptr-pheap ,p))
                        (,disk-cache (pheap-disk-cache ,pheap)))
                   (multiple-value-bind (,pointer ,immediate?)
                                        ,(add-apply
                                          `(,if-pptr ,disk-cache (pptr-pointer ,p) ,@args))
                     (if ,immediate?
                       ,pointer
                       (pptr ,pheap ,pointer)))))
              (add-apply `(,if-pptr (pptr-disk-cache ,p)
                                    (pptr-pointer ,p)
                                    ,@args))))
         ,(add-apply `(,otherwise ,p ,@args))))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun symbol-append (&rest syms)
    (let ((res (string (pop syms))))
      (loop
        (when (null syms) (return))
        (setq res (concatenate 'string res "-" (string (pop syms)))))
      (intern res))))
      
(defmacro def-predicate (lisp-predicate (p disk-cache pointer) &body body)
  (let ((p-name (symbol-append 'p lisp-predicate))
        (dc-name (symbol-append 'dc lisp-predicate)))
    `(progn
       (defun ,p-name (,p)
         (p-dispatch ,p ,dc-name ,lisp-predicate))
       (defun ,dc-name (,disk-cache ,pointer)
         ,@body))))

(defmacro def-accessor (lisp-accessor (p . args) (disk-cache pointer)
                                      &body body)
  (let ((p-name (symbol-append 'p lisp-accessor))
        (dc-name (symbol-append 'dc lisp-accessor))
        (args-sans-keywords (remove lambda-list-keywords args
                                    :test #'(lambda (ll arg) (memq arg ll))))
        (rest-arg? (let ((l (cdr (memq '&rest args))))
                     (when l
                       (when (cdr l) (error "rest arg must be last"))
                       (car l)))))
    `(progn
       (defun ,p-name (,p ,@args)
         ,@(if rest-arg? `((declare (dynamic-extent ,rest-arg?))))
         (p-dispatch (,p ,@args-sans-keywords)
                     ,dc-name ,lisp-accessor t ,rest-arg?))
       (defun ,dc-name (,disk-cache ,pointer ,@args)
         ,@body))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Predicates
;;;

; p-simple-string-p & dc-simple-string-p
(def-predicate simple-string-p (p disk-cache pointer)
  (dc-vector-subtype-p disk-cache pointer $v_sstr))

; p-simple-vector-p & dc-simple-vector-p
(def-predicate simple-vector-p (p disk-cache pointer)
  (dc-vector-subtype-p disk-cache pointer $v_genv))

(defun dc-vector-subtype-p (disk-cache pointer subtype)
  (declare (fixnum subtype))
  (and (pointer-tagp pointer $t_vector)
       (eql (read-8-bits disk-cache (+ pointer $v_subtype)) subtype)))

(def-predicate consp (p disk-cache pointer)
  (declare (ignore disk-cache))
  (and (not (eql pointer $pheap-nil))
       (pointer-tagp pointer $t_cons)))

(def-predicate listp (p disk-cache pointer)
  (declare (ignore disk-cache))
  (or (eql pointer $pheap-nil)
      (pointer-tagp pointer $t_cons)))

(defun p-atom (p)
  (not (p-consp p)))

(defun dc-atom (disk-cache pointer)
  (not (dc-consp disk-cache pointer)))

(def-predicate uvectorp (p disk-cache pointer)
  (declare (ignore disk-cache))
  (eq $t_vector (pointer-tag pointer)))

(def-predicate packagep (p disk-cache pointer)
  (dc-vector-subtype-p disk-cache pointer $v_pkg))

(def-predicate symbolp (p disk-cache pointer)
  (declare (ignore disk-cache))
  (pointer-tagp pointer $t_symbol))

(def-predicate arrayp (p disk-cache pointer)
  (and (pointer-tagp pointer $t_vector)
       (let ((subtype (dc-%vector-subtype disk-cache pointer)))
         (declare (fixnum subtype))
         (and (<= $v_min_arr subtype) (<= subtype $v_arrayh)))))

(defun dc-array-subtype-satisfies-p (disk-cache array predicate)
  (and (pointer-tagp array $t_vector)
       (let ((subtype (dc-%vector-subtype disk-cache array)))
         (if (eql $v_arrayh subtype)
           (values
            (funcall predicate
                     (old-ccl->wood-subtype (dc-%arrayh-type disk-cache array)))
            t)
           (funcall predicate subtype)))))

(def-predicate stringp (p disk-cache pointer)
  (multiple-value-bind (stringp arrayhp)
                       (dc-array-subtype-satisfies-p
                        disk-cache pointer
                        #'(lambda (x) (eql x $v_sstr)))
    (and stringp
         (or (not arrayhp)
             (eql $arh_one_dim (dc-%arrayh-rank4 disk-cache pointer))))))

(def-predicate vectorp (p disk-cache pointer)
  (multiple-value-bind (arrayp arrayhp)
                       (dc-array-subtype-satisfies-p
                        disk-cache pointer
                        #'(lambda (x) 
                            (declare (fixnum x))
                            (and (<= $v_min_arr x) (< x $v_arrayh))))
    (and arrayp
         (or (not arrayhp)
             (eql $arh_one_dim (dc-%arrayh-rank4 disk-cache pointer))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Accessors

; Returns vector size in BYTES
(defun dc-%vector-size (disk-cache v-pointer)
  (read-low-24-bits disk-cache (+ v-pointer $v_log)))

(def-accessor svref (v index) (disk-cache v-pointer)
  (require-satisfies dc-simple-vector-p disk-cache v-pointer)
  (let ((length (dc-%simple-vector-length disk-cache v-pointer)))
    (unless (< -1 index length)
      (error "Index ~s out of bounds in ~s"
             (dc-pointer-pptr disk-cache v-pointer))))
  (dc-%svref disk-cache v-pointer index))

(defun (setf p-svref) (value p index)
  (if (pptr-p p)
    (let ((pheap (pptr-pheap p)))
      (multiple-value-bind (v imm?) (%p-store pheap value)
        (setf (dc-svref (pheap-disk-cache pheap)
                        (pptr-pointer p)
                        index
                        imm?)
              v)
        (if imm?
          v
          (pptr pheap v))))
    (setf (svref p index) value)))

(defun (setf dc-svref) (value disk-cache v-pointer index &optional immediate?)
  (require-satisfies dc-simple-vector-p disk-cache v-pointer)
  (let ((length (dc-%simple-vector-length disk-cache v-pointer)))
    (unless (< -1 index length)
      (error "Index ~s out of bounds in ~s"
             (dc-pointer-pptr disk-cache v-pointer))))
  (setf (dc-%svref disk-cache v-pointer index immediate?) value))

; Here's where the $block-overhead is skipped
(defun addr+ (disk-cache address offset)
  (let* ((page-size (disk-cache-page-size disk-cache))
         (mask (disk-cache-mask disk-cache))
         (start-page 0)
         (page-offset 0)
         (offset (require-type offset 'fixnum)))
    (declare (fixnum page-size mask page-offset blocks-crossed offset))
    (macrolet ((doit ()
                 `(progn
                    (setq start-page (logand address mask)
                          page-offset (- address (incf start-page $block-overhead)))
                    (incf page-offset offset)
                    (when (>= page-offset (decf page-size $block-overhead))
                      (incf page-offset
                            (the fixnum (* $block-overhead
                                           (the fixnum (floor page-offset page-size))))))
                    (+ start-page page-offset))))
      ; This will usually be called with fixnum addresses.
      ; It gets called a lot, so the optimization is worthwhile
      (if (fixnump address)
        (locally (declare (fixnum address start-page))
          (doit))
        (doit)))))

(def-accessor ccl::%svref (v index) (disk-cache v-pointer)
  (read-pointer
   disk-cache
   (addr+ disk-cache v-pointer (+ (ash index 2) $v_data))))

(defun (setf p-%svref) (value v index &optional immediate?)
  (declare (ignore value v index immediate?))
  (error "Not implemeneted"))

(defun (setf dc-%svref) (value disk-cache v-pointer index &optional immediate?)
  (setf (read-pointer
         disk-cache
         (addr+ disk-cache v-pointer (+ (ash index 2) $v_data))
         immediate?)
        value))

(defun dc-%simple-vector-length (disk-cache pointer)
  (the fixnum (ash (the fixnum (read-low-24-bits
                                disk-cache (+ pointer $v_log)))
                   -2)))

(defun dc-%vector-subtype (disk-cache pointer)
  (read-8-bits disk-cache (+ pointer $v_subtype)))

(def-accessor ccl::%vect-subtype (p) (disk-cache pointer)
  (values (dc-%vector-subtype disk-cache pointer) t))

(defun dc-read-fixnum (disk-cache address &optional (address-name address))
  (multiple-value-bind (value imm?) (read-pointer disk-cache address)
    (unless (and imm? (fixnump value))
      (error "Inconsistency: pointer at ~s was not a fixnum." address-name))
    value))

(defun dc-read-cons (disk-cache address &optional (address-name address))
  (multiple-value-bind (value imm?) (read-pointer disk-cache address)
    (unless (and (not imm?) (pointer-tagp value $t_cons))
      (error "Inconsistency: pointer at ~s was not a cons." address-name))
    value))

(defun dc-%svref-fixnum (disk-cache vector index &optional (address-name index))
  (multiple-value-bind (value imm?) (dc-%svref disk-cache vector index)
    (unless (and imm? (fixnump value))
      (error "Inconsistency: pointer at ~s was not a fixnum." address-name))
    value))

(def-accessor car (p) (disk-cache pointer)
  (require-satisfies dc-listp disk-cache pointer)
  (if (eq pointer $pheap-nil)
    $pheap-nil
    (read-pointer disk-cache (- pointer $t_cons))))

(def-accessor cdr (p) (disk-cache pointer)
  (require-satisfies dc-listp disk-cache pointer)
  (if (eq pointer $pheap-nil)
    $pheap-nil
    (read-pointer disk-cache pointer)))

(def-accessor last (list) (disk-cache pointer)
  (require-satisfies dc-listp disk-cache pointer)
  (loop
    (let ((next (dc-cdr disk-cache pointer)))
      (when (dc-atom disk-cache next)
        (return pointer))
      (setq pointer next))))

(defun (setf p-car) (value p)
  (if (pptr-p p)
    (let ((pheap (pptr-pheap p)))
      (multiple-value-bind (v imm?) (%p-store pheap value)
        (setf (dc-car (pheap-disk-cache pheap)
                      (pptr-pointer p)
                      imm?)
              v)
        (if imm?
          v
          (pptr pheap v))))
    (setf (car p) value)))

(defun (setf dc-car) (value disk-cache pointer &optional immediate?)
  (require-satisfies dc-consp disk-cache pointer)
  (setf (read-pointer disk-cache (- pointer $t_cons) immediate?) value))

(defun (setf p-cdr) (value p)
  (if (pptr-p p)
    (let ((pheap (pptr-pheap p)))
      (multiple-value-bind (v imm?) (%p-store pheap value)
        (setf (dc-cdr (pheap-disk-cache pheap)
                      (pptr-pointer p)
                      imm?)
              v)
        (if imm?
          v
          (pptr pheap v))))
    (setf (cdr p) value)))

(defun (setf dc-cdr) (value disk-cache pointer &optional immediate?)
  (require-satisfies dc-consp disk-cache pointer)
  (setf (read-pointer disk-cache pointer immediate?) value))

(eval-when (:compile-toplevel :execute)

(defmacro def-cxrs (max-length)
  (let ((res nil)
        (prev '("A" "D"))
        (prev-symbols '(dc-car dc-cdr))
        (len 2)
        next next-symbols)
    (loop
      (loop for middle in prev
            for sym in prev-symbols
            do (loop for prefix in '("A" "D")
                     for prefix-symbol in '(dc-car dc-cdr)
                     for new-middle = (concatenate 'string prefix middle)
                     for name = (intern (concatenate 'string "C" new-middle "R")
                                        :wood)
                     for dc-name = (intern (concatenate 'string "DC-" (symbol-name name))
                                           :wood)
                     for p-name = (intern (concatenate 'string "P-" (symbol-name name))
                                          :wood)
                     for form = `(def-accessor ,name (p) (disk-cache pointer)
                                   (multiple-value-bind (thing imm?)
                                                        (,sym disk-cache pointer)
                                     (when imm?
                                       (error "Immediate returned from:~@
                                               (~s ~s #x~x).~@
                                               Expected a cons pointer."
                                              ',sym disk-cache pointer))
                                     (,prefix-symbol disk-cache thing)))
                     for p-setter = `(defun (setf ,p-name) (value p)
                                       (if (pptr-p p)
                                         (let ((pheap (pptr-pheap p)))
                                           (multiple-value-bind (v imm?) (%p-store pheap value)
                                             (setf (,dc-name (pheap-disk-cache pheap)
                                                             (pptr-pointer p)
                                                             imm?)
                                                   v)
                                             (if imm? v (pptr pheap v))))
                                         (setf (,name p) value)))
                     for dc-setter = `(defun (setf ,dc-name) (value disk-cache pointer &optional
                                                                    value-imm?)
                                        (multiple-value-bind (cons cons-imm?) (,sym disk-cache pointer)
                                          (when cons-imm?
                                            (error "(~s ~s ~s) is an immediate."
                                                   ',sym disk-cache pointer))
                                          (setf (,prefix-symbol disk-cache cons value-imm?) value)))
                                        
                     do
                     (push form res)
                     (push p-setter res)
                     (push dc-setter res)
                     (push new-middle next)
                     (push dc-name next-symbols)))
      (setq prev next prev-symbols next-symbols
            next nil next-symbols nil)
      (when (> (incf len) max-length) (return)))
    `(progn ,@(nreverse res))))

)

(def-cxrs 4)

(defun p-nth (n list)
  (if (pptr-p list)
    (let ((pheap (pptr-pheap list)))
      (multiple-value-bind (res imm?)
                           (dc-nth (pheap-disk-cache pheap) n (pptr-pointer list))
        (if imm? res (pptr pheap res))))
    (nth n list)))

(defun dc-nth (disk-cache n list)
  (dc-car disk-cache (dc-nthcdr disk-cache n list)))

(defun (setf p-nth) (value n list)
  (if (pptr-p list)
    (let* ((pheap (pptr-pheap list)))
      (multiple-value-bind (pointer imm?) (%p-store pheap value)
        (setf (dc-nth (pheap-disk-cache pheap) n (pptr-pointer list) imm?) pointer)
        (if imm? pointer (pptr pheap pointer))))
    (setf (nth n list) value)))

(defun (setf dc-nth) (value disk-cache n list &optional imm?)
  (setf (dc-car disk-cache (dc-nthcdr disk-cache n list) imm?) value))

(defun p-nthcdr (n list)
  (if (pptr-p list)
    (let ((pheap (pptr-pheap list)))
      (multiple-value-bind (res imm?)
                           (dc-nthcdr
                            (pheap-disk-cache pheap) n (pptr-pointer list))
        (if imm? res (pptr pheap res))))
    (nthcdr n list)))

(defun dc-nthcdr (disk-cache n list)
  (setq n (require-type n 'unsigned-byte))
  (loop
    (when (eql 0 n)
      (return list))
    (decf n)
    (setq list (dc-cdr disk-cache list))))

(defun (setf p-nthcdr) (value n list)
  (if (pptr-p list)
    (let* ((pheap (pptr-pheap list)))
      (multiple-value-bind (pointer imm?) (%p-store pheap value)
        (setf (dc-nthcdr (pheap-disk-cache pheap) n (pptr-pointer list) imm?) pointer)
        (if imm? pointer (pptr pheap pointer))))
    (setf (nthcdr n list) value)))

(defun (setf dc-nthcdr) (value disk-cache n list &optional imm?)
  (if (eql 0 n)
    (values value imm?)
    (setf (dc-cdr disk-cache (dc-nthcdr disk-cache (1- n) list) imm?) value)))

(defmacro p-dolist ((var list &optional result) &body body)
  (let ((list-var (gensym)))
    `(let ((,list-var ,list)
           ,var)
       (loop
         (when (null ,list-var) (return ,result))
         (setq ,var (p-car ,list-var)
               ,list-var (p-cdr ,list-var))
         ,@body))))

(defun p-assoc (indicator a-list &key (test 'eql) test-not key (p-load? t))
  (if test-not
    (flet ((test (x y)
             (not (funcall test-not x y))))
      (declare (dynamic-extent #'test))
      (p-assoc indicator a-list :test #'test :key key :p-load? p-load?))
    (p-dolist (cell a-list)
      (let ((key-item (p-car cell)))
        (when p-load?
          (setq key-item (p-load key-item)))
        (when (funcall test indicator (if key (funcall key key-item) key-item))
          (return cell))))))

(def-accessor uvsize (p) (disk-cache pointer)
  (require-satisfies dc-uvectorp disk-cache pointer)
  (let ((subtype (dc-%vector-subtype disk-cache pointer)))
    (dc-uv-subtype-size subtype
                        (dc-%vector-size disk-cache pointer)
                        (if (eql $v_bitv subtype)
                          (read-8-bits disk-cache (addr+ disk-cache pointer $v_data))))))

(defun dc-uv-subtype-size (subtype bytes &optional last-byte-bits)
  (let* ((bytes-per-element (svref *subtype->bytes-per-element* subtype)))
    (values
     (if bytes-per-element
       (/ bytes bytes-per-element)
       (if (eql $v_bitv subtype)
         (+ (* 8 (max 0 (- bytes 2))) last-byte-bits)
         (error "~s not supported for vectors of subtype ~s" 'dc-uvref subtype)))
     t)))
      
(def-accessor uvref (v index) (disk-cache v-pointer)
  (require-satisfies dc-uvectorp disk-cache v-pointer)
  (let* ((subtype (dc-%vector-subtype disk-cache v-pointer))
         (uvreffer (svref *subtype->uvreffer* subtype)))
    (unless uvreffer
      (error "~s not valid for vector ~s of subtype ~s"
             'dc-uvref (dc-pointer-pptr disk-cache v-pointer) subtype))
    (funcall uvreffer disk-cache v-pointer index)))

(defun do-uvref (disk-cache pointer offset index reader)
  (let ((size (dc-%vector-size disk-cache pointer)))
    (unless (< -1 offset size)
      (error "Index ~s out of range for ~s"
             index (dc-pointer-pptr disk-cache pointer)))
    (funcall reader disk-cache (addr+ disk-cache pointer (+ $v_data offset)))))

(defun uvref-signed-byte (disk-cache pointer index)
  (values (do-uvref disk-cache pointer index index 'read-8-bits-signed)
          t))

(defun uvref-unsigned-byte (disk-cache pointer index)
  (values (do-uvref disk-cache pointer index index 'read-8-bits)
          t))

(defun uvref-signed-word (disk-cache pointer index)
  (values (do-uvref disk-cache pointer (* 2 index) index 'read-word)
          t))

(defun uvref-unsigned-word (disk-cache pointer index)
  (values (do-uvref disk-cache pointer (* 2 index) index 'read-unsigned-word)
          t))

(defun uvref-signed-long (disk-cache pointer index)
  (values (do-uvref disk-cache pointer (* 4 index) index 'read-long)
          t))

(defun uvref-unsigned-long (disk-cache pointer index)
  (values (do-uvref disk-cache pointer (* 4 index) index 'read-unsigned-long)
          t))

(defun uvref-genv (disk-cache pointer index)
  (do-uvref disk-cache pointer (* 4 index) index 'read-pointer))

(defun uvref-string (disk-cache pointer index)
  (values (code-char (do-uvref disk-cache pointer index index 'read-8-bits))
          t))

(defun uvref-extended-string (disk-cache pointer index)
  (values (code-char (do-uvref disk-cache pointer index index 'read-unsigned-word))
          t))

; This will get much less ugly when we can stack cons float vectors.
(defun uvref-dfloat (disk-cache pointer index)
  (let ((offset (* index 8))
        (size (dc-%vector-size disk-cache pointer)))
    (unless (< -1 offset size)
      (error "Index ~s out of range for ~s"
             index (dc-pointer-pptr disk-cache pointer)))
    (values (read-double-float disk-cache (addr+ disk-cache pointer (+ $v_data offset))) t)))

(defun %bit-vector-index-address-and-bit (disk-cache pointer index)
  (let ((size (dc-uv-subtype-size
               $v_bitv
               (dc-%vector-size disk-cache pointer)
               (read-8-bits disk-cache (addr+ disk-cache pointer $v_data)))))
    (unless (< -1 index size)
      (error "Index ~s out of range for ~s" index (dc-pointer-pptr disk-cache pointer)))
    (values (addr+ disk-cache pointer (+ $v_data 1 (ash index -3)))
            (- 7 (logand index 7)))))

(defun uvref-bit-vector (disk-cache pointer index)
  (multiple-value-bind (address bit)
                       (%bit-vector-index-address-and-bit disk-cache pointer index)
    (values
     (if (logbitp bit (read-8-bits disk-cache address))
       1
       0)
     t)))
             

(defun (setf p-uvref) (value pptr index)
  (if (pptr-p pptr)
    (let ((pheap (pptr-pheap pptr)))
      (multiple-value-bind (value-pointer imm?)
                           (if (and (or (bignump value) (typep value 'double-float))
                                    (memq (svref *subtype->uvsetter* (p-%vect-subtype pptr))
                                          '(uvset-long uvset-dfloat)))
                              (values value t)
                              (%p-store pheap value))
        (setf (dc-uvref (pheap-disk-cache pheap)
                        (pptr-pointer pptr)
                        index
                        imm?)
              value-pointer)
        (if imm?
          value-pointer
          (pptr pheap value-pointer))))
    (setf (uvref pptr index) value)))

(defun (setf dc-uvref) (value disk-cache pointer index &optional immediate?)
  (let* ((subtype (dc-%vector-subtype disk-cache pointer))
         (uvsetter (svref *subtype->uvsetter* subtype)))
    (unless uvsetter
      (error "~s not valid for vector ~s of subtype ~s"
             'dc-uvref (dc-pointer-pptr disk-cache pointer) subtype))
    (funcall uvsetter value disk-cache pointer index immediate?)))

(defun do-uvset (value disk-cache pointer offset index writer immediate?)
  (let ((size (dc-%vector-size disk-cache pointer)))
    (unless (< -1 offset size)
      (error "Index ~s out of range for ~s"
             index (dc-pointer-pptr disk-cache pointer)))
    (if immediate?
      (values (funcall writer
                       value disk-cache (addr+ disk-cache pointer (+ $v_data offset)) t)
              t)
      (funcall writer value disk-cache (addr+ disk-cache pointer (+ $v_data offset))))))

(defun uvset-byte (value disk-cache pointer index immediate?)
  (unless (and immediate? (fixnump value))
    (error "Attempt to write a non-fixnum byte"))
  (do-uvset value disk-cache pointer index index #'(setf read-8-bits) nil))

(defun uvset-word (value disk-cache pointer index immediate?)
  (unless (and immediate? (fixnump value))
    (error "Attempt to write a non-fixnum word"))
  (do-uvset value disk-cache pointer (* 2 index) index #'(setf read-word) nil))

(defun uvset-long (value disk-cache pointer index immediate?)
  (unless immediate?
    (setq value (require-type
                 (pointer-load (disk-cache-pheap disk-cache) value :default disk-cache)
                 'integer)))
  (do-uvset value disk-cache pointer (* 4 index) index #'(setf read-long) nil))

(defun uvset-genv (value disk-cache pointer index immediate?)
  (do-uvset value disk-cache pointer (* 4 index) index #'(setf read-pointer) immediate?))

(defun uvset-string (value disk-cache pointer index immediate?)
  (declare (ignore immediate?))
  (do-uvset (char-code value) disk-cache pointer index index #'(setf read-8-bits) nil))

(defun uvset-extended-string (value disk-cache pointer index immediate?)
  (declare (ignore immediate?))
  (do-uvset (char-code value) disk-cache pointer index index #'(setf read-word) nil))

(defun uvset-dfloat (value disk-cache pointer index immediate?)
  (let ((offset (* index 8))
        (size (dc-%vector-size disk-cache pointer)))
    (unless (< -1 offset size)
      (error "Index ~s out of range for ~s"
             offset (dc-pointer-pptr disk-cache pointer)))
    (if immediate?
      (setf (read-double-float disk-cache (addr+ disk-cache pointer (+ $v_data offset)))
            (require-type value 'double-float))
      (let ((buf (make-string 8 :element-type 'base-character)))
        (declare (dynamic-extent buf))
        (require-satisfies pointer-tagp value $t_dfloat)
        (load-byte-array disk-cache (- value $t_dfloat) 8 buf)
        (store-byte-array buf disk-cache (addr+ disk-cache pointer (+ $v_data offset)) 8)
        value))))        

(defun uvset-bit-vector (value disk-cache pointer index immediate?)
  (multiple-value-bind (address bit)
                       (%bit-vector-index-address-and-bit disk-cache pointer index)
    (unless (and immediate? (or (eql value 1) (eql value 0)))
      (error "bit vector value must be 0 or 1"))
    (let* ((byte (read-8-bits disk-cache address))
           (set? (logbitp bit byte)))
      (if (eql  value 0)
        (when set?
          (setf (read-8-bits disk-cache address)
                (logand byte (lognot (ash 1 bit)))))
        (unless set?
          (setf (read-8-bits disk-cache address)
                (logior byte (ash 1 bit)))))))
  value)

(defun p-array-data-and-offset (p)
  (if (pptr-p p)
    (let ((pheap (pptr-pheap p)))
      (multiple-value-bind (address offset)
                           (dc-array-data-and-offset (pheap-disk-cache pheap)
                                                     (pptr-pointer p))
        (values (pptr pheap address) offset)))
    (ccl::array-data-and-offset p)))

(defun dc-array-data-and-offset (disk-cache pointer)
  (require-satisfies dc-arrayp disk-cache pointer)
  (if (not (dc-vector-subtype-p disk-cache pointer $v_arrayh))
    (values pointer 0)
    (let* ((p pointer)
           (offset 0))
      (loop
        (incf offset (dc-%svref-fixnum disk-cache p $arh.offs '$arh.offs))
        (let ((next-p (dc-%svref disk-cache p $arh.vect)))
          (unless (logbitp $arh_disp_bit (dc-%arrayh-bits disk-cache p))
            (return (values next-p offset)))
          (setq p next-p))))))

(def-accessor length (p) (disk-cache pointer)
  (values
   (cond ((dc-listp disk-cache pointer)
          (dc-%length-of-list disk-cache pointer))
         ((dc-vectorp disk-cache pointer)
          (dc-%vector-length disk-cache pointer))
         (t (error "~s is neither a list nor a vector"
                   (dc-pointer-pptr disk-cache pointer))))
   t))

(defun dc-%vector-length (disk-cache pointer)
  (if (eql $v_arrayh (dc-%vector-subtype disk-cache pointer))
    (if (logbitp $arh_fill_bit (dc-%arrayh-bits disk-cache pointer))
      (dc-%svref disk-cache pointer $arh.fill)
      (dc-%svref disk-cache pointer $arh.vlen))
    (dc-uvsize disk-cache pointer)))

(defun dc-%length-of-list (disk-cache pointer)
  (let ((len 0))
    (loop
      (if (eql $pheap-nil pointer)
        (return len))
      (setq pointer (dc-cdr disk-cache pointer))
      (incf len))))
  
(def-accessor symbol-name (p) (disk-cache pointer)
  (require-satisfies dc-symbolp disk-cache pointer)
  (read-pointer disk-cache (addr+ disk-cache pointer $sym_pname)))

(def-accessor symbol-package (p) (disk-cache pointer)
  (require-satisfies dc-symbolp disk-cache pointer)
  (read-pointer disk-cache (addr+ disk-cache pointer $sym_package)))

(defun dc-error (string disk-cache pointer)
  (let ((p (dc-pointer-pptr disk-cache pointer)))
    (error string p (p-load p))))

(def-accessor symbol-value (p) (disk-cache pointer)
  (let ((values (dc-symbol-values-list disk-cache pointer)))
    (let ((value (ccl::%unbound-marker-8))
          (value-imm? t))
      (when values
        (multiple-value-setq (value value-imm?) (dc-car disk-cache values)))
      (when (and value-imm? (eq value (ccl::%unbound-marker-8)))
        (dc-error "Unbound variable: ~s = ~s" disk-cache pointer))
      (values value value-imm?))))

; Should probably take an area parameter
(defun dc-symbol-values-list (disk-cache pointer &optional create?)
  (require-satisfies dc-symbolp disk-cache pointer)
  (let ((addr (addr+ disk-cache pointer $sym_values)))
    (multiple-value-bind (values vv-imm?)
                         (read-pointer disk-cache addr)
      (when (or vv-imm? (not (dc-listp disk-cache values)))
        (dc-error "Bad value list for symbol: ~s = ~s" disk-cache pointer))
      (if (eq values $pheap-nil)
        (when create?
          (setf (read-pointer disk-cache addr)
                (dc-make-list disk-cache 2)))
        values))))

(defun (setf p-symbol-value) (value symbol)
  (if (pptr-p symbol)
    (let ((pheap (pptr-pheap symbol)))
      (multiple-value-bind (v v-imm?) (%p-store pheap value)
        (setf (dc-symbol-value (pheap-disk-cache pheap) (pptr-pointer symbol) v-imm?)
              v)
        (if v-imm? v (pptr pheap v))))
    (setf (symbol-value symbol) value)))

(defun (setf dc-symbol-value) (value disk-cache pointer &optional imm?)
  (let ((values (dc-symbol-values-list disk-cache pointer t)))
    (setf (dc-car disk-cache values imm?) value)
    (values value imm?)))
  
(defun dc-pkg-arg (disk-cache pkg &optional (pkg-imm? (not (integerp pkg))))
  (or (dc-find-package disk-cache pkg pkg-imm?)
      (error "There is no package named ~s"
             (dc-canonicalize-pkg-arg disk-cache pkg pkg-imm?))))

(def-accessor package-name (p) (disk-cache pointer)
  (dc-car disk-cache
          (dc-%svref disk-cache (dc-pkg-arg disk-cache pointer) $pkg.names)))

(def-accessor package-nicknames (p) (disk-cache pointer)
  (dc-cdr disk-cache
          (dc-%svref disk-cache (dc-pkg-arg disk-cache pointer) $pkg.names)))

(def-accessor string (p) (disk-cache pointer)
  (if (dc-stringp disk-cache pointer)
    pointer
    (dc-symbol-name disk-cache pointer)))

(def-accessor array-rank (p) (disk-cache pointer)
  (require-satisfies dc-arrayp disk-cache pointer)
  (values
   (if (dc-vectorp disk-cache pointer)
     1
     (ash (dc-%arrayh-rank4 disk-cache pointer) -2))
   t))

(def-accessor array-dimension (p n) (disk-cache pointer)
  (let ((rank (dc-array-rank disk-cache pointer)))
    (if (or (not (fixnump n)) (< n 0) (>= n rank))
      (error "~s is non-integer, < 0, or > rank of ~s"
             n (dc-pointer-pptr disk-cache pointer))
      (values 
       (if (dc-simple-vector-p disk-cache pointer)
         (dc-%vector-length disk-cache pointer)
         (dc-%svref-fixnum disk-cache pointer (+ $arh.fill n)))
       t))))

(def-accessor array-dimensions (p) (disk-cache pointer)
  (let ((rank (dc-array-rank disk-cache pointer)))
    (declare (fixnum rank))
    (if (dc-simple-vector-p disk-cache pointer)
      (values (list (dc-%vector-length disk-cache pointer)) t)
      (let ((res nil)
            (index $arh.fill))
        (declare (fixnum index))
        (dotimes (i rank)
          (push (dc-%svref-fixnum disk-cache pointer index) res)
          (incf index))
        (values
         (nreverse res)
         t)))))
  
(defun p-aref (p &rest indices)
  (declare (dynamic-extent indices))
  (if (pptr-p p)
    (let ((pheap (pptr-pheap p)))
      (multiple-value-bind (res imm?) (dc-aref-internal (pheap-disk-cache pheap)
                                                        (pptr-pointer p)
                                                        indices)
        (if imm?
          res
          (pptr pheap res))))
    (apply #'aref p indices)))

(defun dc-aref (disk-cache pointer &rest indices)
  (declare (dynamic-extent indices))
  (dc-aref-internal disk-cache pointer indices))

; Clobbers the indices arg. It is a stack-consed rest arg in my uses of it here.
(defun dc-aref-internal (disk-cache pointer indices)
  (multiple-value-bind (vector index) (dc-aref-vector-and-index disk-cache pointer indices)
    (if (null vector)                   ; rank 0
      nil
      (dc-uvref disk-cache vector index))))

(defun dc-aref-vector-and-index (disk-cache pointer indices)
  (let ((rank (dc-array-rank disk-cache pointer)))
    (declare (fixnum rank))
    (unless (eql rank (length indices))
      (error "~s cannot be accessed with ~s subscripts."
             (dc-pointer-pptr disk-cache pointer)
             (length indices)))
    (if (eql rank 0)
      nil
      (multiple-value-bind (vector offset) (dc-array-data-and-offset disk-cache pointer)
        (if (eql rank 1)
          (values vector (+ offset (car indices)))
          (let* ((arrayh-index (+ $arh.dims rank))
                 (index 0)
                 (rest-size 1))
            (declare (fixnum index))
            (setq indices (nreverse indices))
            (dotimes (i rank)
              (let ((idx (pop indices))
                    (dim (dc-%svref-fixnum disk-cache pointer arrayh-index)))
                (if (>= idx dim)
                  (error "Array index ~s out of bounds for ~s"
                         idx (dc-pointer-pptr disk-cache pointer)))
                (setq index (+ index (* idx rest-size)))
                (setq rest-size (* rest-size dim))
                (decf arrayh-index)))
            (values vector (+ offset index))))))))

(defun (setf p-aref) (value p &rest indices)
  (declare (dynamic-extent indices))
  (if (pptr-p p)
    (let ((pheap (pptr-pheap p)))
      (multiple-value-bind (v imm?) (%p-store pheap value)
        (dc-setf-aref (pheap-disk-cache pheap) (pptr-pointer p) v imm? indices)
        (if imm?
          v
          (pptr pheap v))))
    (setf (apply #'aref p indices) value)))
                    
(defun dc-setf-aref (disk-cache pointer value value-imm? indices)
  (multiple-value-bind (vector index) (dc-aref-vector-and-index disk-cache pointer indices)
    (setf (dc-uvref disk-cache vector index value-imm?) value)))

#|
(defun incf-index-list (indices dims)
  (do ((indices-tail indices (cdr indices-tail))
       (dims-tail dims (cdr dims-tail)))
      ((null indices-tail) (return nil))
    (if (>= (incf (car indices-tail)) (car dims-tail))
      (setf (car indices-tail) 0)
      (return indices))))

(defun p-fill-array (array)
  (let* ((dims (p-array-dimensions array))
         (indices (make-list (length dims) :initial-element 0)))
    (loop
      (let ((value (p-store (pptr-pheap array) indices nil)))
        (apply #'(setf p-aref) value array indices))
      (unless (incf-index-list indices dims)
        (return array)))))

(defun p-check-array (array)
  (let* ((dims (p-array-dimensions array))
         (indices (make-list (length dims) :initial-element 0)))
    (loop
      (let ((value (p-load (apply #'p-aref array indices) t)))
        (unless (equal value indices)
          (cerror "Continue."
                  "~&SB: ~s, WAS: ~s~%" indices value))
        (unless (incf-index-list indices dims)
          (return))))))

|#

(defun p-delq (item list &optional count key)
  (unless (pptr-p list)
    (return-from p-delq
      (if key
        (delete item list :test 'eq :key key)
        (delq item list count))))
  (require-satisfies p-listp list)
  (let* ((pheap (pptr-pheap list))
         (list-address (pptr-pointer list))
         (disk-cache (pheap-disk-cache pheap)))
    (multiple-value-bind (item-address item-imm?)
                         (cond ((pptr-p item) (pheap-pptr-pointer item pheap))
                               ((immediate-object-p item) (values item t))
                               (t (or (gethash item (mem->pheap-hash pheap))
                                      (return-from p-delq list))))
      (let* ((handle (cons nil list-address))
             (last handle)
             (current list-address))
        (declare (dynamic-extent handle))
        (flet ((my-cdr (x)
                 (if (listp x)
                   (cdr x)
                   (multiple-value-bind (cdr imm?) (dc-cdr disk-cache x)
                     (when (and imm? cdr)
                       (error "Non-nil final cdr"))
                     cdr)))
               (set-my-cdr (x value)
                 (if (listp x)
                   (setf (cdr x) value)
                   (setf (dc-cdr disk-cache x) value))))
          (declare (dynamic-extent #'my-cdr #'set-my-cdr))
          (loop
            (when (or (eql current $pheap-nil) (eql 0 count))
              (return (pptr pheap (cdr handle))))
            (multiple-value-bind (car car-imm?) (dc-car disk-cache current)
              (if (if key
                    (eq item (funcall key (if car-imm? car (pptr pheap car))))
                    (and (eq car item-address)
                       (eq (not (null car-imm?)) item-imm?)))
                (progn
                  (setq current (my-cdr current))
                  (set-my-cdr last current)
                  (when count (decf count)))
                (setq last current
                      current (my-cdr current))))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Consers
;;

(defun initialize-vector-storage (disk-cache address length subtype 
                                                  bytes-per-element initial-element
                                                  &optional immediate?)
  (let* ((ptr address)
         (length (require-type length 'fixnum))
         (size (require-type (* length bytes-per-element) 'fixnum))
         (double-words (ash (+ size 7) -3))
         (min-disk-cache-size (addr+ disk-cache
                                     ptr
                                     (+ (ash double-words 3) $vector-header-size))))
    (declare (fixnum length size double-words))
    (unless (eql 0 (logand 7 ptr))
      (error "Address ~s not double-word aligned" address))
    (unless (< size #.(expt 2 24))
      (error "size: ~s > 24 bits" length))
    ; Extend the disk cache.
    ; Extend the file size too if the vector is big enough that it's worthwhile
    ; attempting to make the file contiguous there.
    ; Maybe this should extend the file for any object that crosses a page boundary
    (let ((extend-file-p (>= size (* 1024 16))))
      (extend-disk-cache disk-cache min-disk-cache-size extend-file-p))
    (unless (or (eql bytes-per-element 8)
                (eql bytes-per-element 4)
                (eql bytes-per-element 2)
                (eql bytes-per-element 1))
      (error "~s was ~s, should be 1, 2, or 4"
             'bytes-per-element bytes-per-element))
    (setf (read-long disk-cache ptr) $vector-header
          (read-8-bits disk-cache (incf ptr 4)) subtype
          (read-low-24-bits disk-cache ptr) size)
    (when (and initial-element (> double-words 0))
      (funcall (case bytes-per-element ((4 8) 'fill-long) (2 'fill-word) (1 'fill-byte))
               disk-cache
               (addr+ disk-cache ptr 4)
               initial-element
               ; round up to the nearest double word
               (* (case bytes-per-element ((4 8) 2) (2 4) (1 8)) double-words)
               immediate?)))
  (+ address $t_vector))

; All sizes are rounded up to a multiple of 8 bytes.
#| ;; moved up
(defmacro normalize-size (x &optional (multiple 8))
  (let ((mask (1- multiple)))
    `(logand (lognot ,mask) (+ ,x ,mask))))
|#

(assert (eql $segment-header-entry-bytes
             (normalize-size $segment-header-entry-bytes)))


; Make a new area with single segment.
(defun p-make-area (pheap &rest rest &key segment-size flags)
  (declare (ignore segment-size flags))
  (declare (dynamic-extent rest))
  (pptr pheap (apply #'dc-make-area (pheap-disk-cache pheap) rest)))

(defun dc-make-area (disk-cache &key
                                (segment-size *default-area-segment-size*)
                                (flags 0))
  (setq segment-size (require-type segment-size 'fixnum)
        flags (require-type flags 'fixnum))
  (symbol-macrolet ((area-header-size (normalize-size (* 4 $area-descriptor-size))))
    (let* ((area (%dc-allocate-new-memory disk-cache 1 $v_area))        ; take 1 page
           (free-count (floor (- (dc-%vector-size disk-cache area) area-header-size)
                              $segment-header-entry-bytes))
           (free-ptr (+ area $v_data area-header-size $t_cons
                        (- $segment-header-entry-bytes))))
      (assert (typep free-count 'fixnum))
      (dc-%svfill disk-cache area
        $segment-headers.area area
        ; $segment-headers.link is already $pheap-nil
        ($area.flags t) flags
        ($area.segment-size t) segment-size
        $area.last-headers area
        ($area.free-count t) free-count
        $area.free-ptr free-ptr)
      (dc-cons-segment disk-cache area segment-size $pheap-nil)
      area)))

(defmacro with-consing-area (area &body body)
  (let ((thunk (gensym)))
    `(let ((,thunk #'(lambda () ,@body)))
       (declare (dynamic-extent ,thunk))
       (call-with-consing-area ,thunk ,area))))

(defun call-with-consing-area (thunk area)
  (setq area (require-type area 'pptr))
  (let ((pheap (pptr-pheap area))
        (pointer (pptr-pointer area)))
    (require-satisfies dc-vector-subtype-p (pheap-disk-cache pheap) pointer $v_area)
    (let ((old-area (pheap-consing-area pheap)))
      (unwind-protect
        (progn
          (setf (pheap-consing-area pheap) pointer)
          (funcall thunk))
        (setf (pheap-consing-area pheap) old-area)))))

(def-accessor area (p) (disk-cache pointer)
  (let* ((page (logand pointer (disk-cache-mask disk-cache)))
         (segment (read-long disk-cache (+ page $block-segment-ptr))))
    (dc-%svref disk-cache segment  $segment.area)))

(defun area (p)
  (declare (ignore p))
  (error "In-memory objects do not have an area.."))


; Cons a new segment for the given area.
; The size defaults to the area's segment-size
; The free-link parameter is here only for use by dc-make-area above,
; so that it doesn't have to inline this code.
; Returns the pointer to the segment header.
(defun dc-cons-segment (disk-cache area &optional segment-size free-link)
  (unless segment-size
    (setq segment-size (dc-%svref disk-cache area $area.segment-size)))
  (let ((segment (%dc-allocate-new-memory disk-cache segment-size $v_segment nil)))
    (with-databases-locked
     (let ((free-count (dc-%svref-fixnum disk-cache area $area.free-count '$area.free-count))
           free-ptr)
       (declare (fixnum free-count))
       (flet ((get-free-link (disk-cache free-ptr)
                (if (eql 0 (dc-read-fixnum disk-cache (+ free-ptr $segment-header_freebytes)))
                  (dc-read-cons disk-cache (+ free-ptr $segment-header_free-link)
                                '$segment-header_free-link)
                  free-ptr)))
         (if (> free-count 0)
           (let ((old-free-ptr (dc-%svref disk-cache area $area.free-ptr)))
             (setq free-ptr (+ old-free-ptr $segment-header-entry-bytes)
                   free-link (or free-link (get-free-link disk-cache old-free-ptr))
                   free-count (1- free-count)))
           (symbol-macrolet ((segment-header-bytes (normalize-size (* 4 $segment-header-size))))
             (let* ((new-headers (%dc-allocate-new-memory disk-cache 1 $v_segment-headers)))
               (setf free-ptr (+ new-headers $v_data segment-header-bytes $t_cons)
                     free-link (or free-link
                                   (get-free-link disk-cache
                                                  (dc-%svref disk-cache area $area.free-ptr)))
                     free-count (floor (- (dc-%vector-size disk-cache new-headers)
                                          segment-header-bytes)
                                       $segment-header-entry-bytes)
                     (dc-%svref disk-cache new-headers $segment-headers.area) area
                     ; $segment-headers.link is already $pheap-nil
                     (dc-%svref disk-cache 
                                (dc-%svref disk-cache area $area.last-headers)
                                $segment-headers.link)
                     new-headers
                     (dc-%svref disk-cache area $area.last-headers) new-headers))))
         (dc-%svfill disk-cache segment
           $segment.area area
           $segment.header free-ptr)
         (symbol-macrolet ((segment-header-bytes (normalize-size (* 4 $segment-header-size))))
           (setf (read-pointer disk-cache (+ free-ptr $segment-header_free))
                 (+ segment $v_data segment-header-bytes $t_cons)
                 (read-pointer disk-cache (+ free-ptr $segment-header_freebytes) t)
                 (- (dc-%vector-size disk-cache segment) segment-header-bytes)
                 (read-pointer disk-cache (+ free-ptr $segment-header_free-link))
                 free-link
                 (read-pointer disk-cache (+ free-ptr $segment-header_segment))
                 segment))
         (dc-%svfill disk-cache area
           ($area.free-count t) free-count
           $area.free-ptr free-ptr))))))

; This is where the disk file gets longer.
; We grow a segment at a time.
; Segments are an even multiple of the page size in length and are aligned on a page
; boundary.
; This fills in only the vector header word and the subtype & length word.
; All other initialization must be done by the caller.
(defun %dc-allocate-new-memory (disk-cache segment-size subtype
                                               &optional
                                               (initial-element $pheap-nil)
                                               ie-imm?)
  (let* ((page-size (disk-cache-page-size disk-cache))
         (page-count (floor (+ segment-size (1- page-size)) page-size))
         free-page immediate?)
    (setq segment-size (* page-count page-size))
    (with-databases-locked
     (multiple-value-setq (free-page immediate?)
       (dc-%svref disk-cache $root-vector $pheap.free-page))
     (unless (and immediate? (fixnump free-page))
       (error "Inconsistent PHEAP: free pointer not a fixnum"))
     (setf (dc-%svref disk-cache $root-vector $pheap.free-page t) 
           (require-type (+ free-page page-count) 'fixnum)))
    (let* ((free (* free-page page-size))
           (data-size (- segment-size (* page-count $block-overhead)))
           (res (initialize-vector-storage
                 disk-cache (+ free $block-overhead)
                 (ash (- data-size $vector-header-size) -2)
                 subtype 4 initial-element ie-imm?)))
      (incf free $block-segment-ptr)
      (dotimes (i page-count)
        (setf (read-pointer disk-cache free) res)
        (incf free page-size))
      res)))

(eval-when (:compile-toplevel :execute)
  (assert (< (expt 2 24) most-positive-fixnum)))

(assert (fixnump (1- (expt 2 24))))

; And here's where all vectors are consed.
(defun %cons-vector-in-area (disk-cache area length subtype &optional
                                        initial-element (immediate? nil))
  (unless initial-element
    (setq initial-element (svref *subtype-initial-element* subtype)))
  (let* ((bytes-per-element (svref *subtype->bytes-per-element* subtype))
         (size (* length bytes-per-element)))
    (unless (< size (expt 2 24))
      (error "Attempt to allocate a vector larger than ~s bytes long"
             (1- (expt 2 24))))
    (locally (declare (fixnum size))
      (let* ((address (%allocate-storage disk-cache area (+ $vector-header-size size))))
        (initialize-vector-storage
         disk-cache (- address $t_cons) length subtype bytes-per-element initial-element
         immediate?)))))

; Allocate size bytes of storage from the given area.
; Does not write anything in the storage.
; If you do not fill it properly, the next GC of the pheap will die a horrible death.
(defun %allocate-storage (disk-cache area size)
  (setq area (maybe-default-disk-cache-area disk-cache area))
  (%allocate-storage-internal
   disk-cache area (dc-%svref disk-cache area $area.free-ptr) (normalize-size size)))

; Do the work for %allocate-storage.
; Size must be normalized.
; It's possible that this function needs to be only partially
; uninterruptable, but I was not sure so I played it safe. -Bill
(defun %allocate-storage-internal (disk-cache area segment size &optional
                                                   last-free-segment
                                                   (initial-segment segment)
                                                   it-better-fit)
  (with-databases-locked
   (let ((freebytes (dc-read-fixnum disk-cache (+ segment $segment-header_freebytes)
                                    '$segment-header_freebytes)))
     (declare (fixnum freebytes))
     (if (>= freebytes size)
       ; The allocation fits in this segment
       (let* ((address (dc-read-cons disk-cache (+ segment $segment-header_free))))
         (setf (read-pointer disk-cache (+ segment $segment-header_freebytes) t)
               (decf freebytes size)
               (read-pointer disk-cache (+ segment $segment-header_free))
               (addr+ disk-cache address size))
         (when (and (eql 0 freebytes) last-free-segment)
           ; This segment is full. Splice it out of the free list.
           (setf (read-pointer disk-cache (+ last-free-segment $segment-header_free-link))
                 (dc-read-cons disk-cache (+ segment $segment-header_free-link))
                 (read-pointer disk-cache (+ segment $segment-header_free-link))
                 $pheap-nil))
         address)
       ; Does not fit in this segment, try next free segment
       (let (#+remove (free-link (dc-read-cons disk-cache (+ segment $segment-header_free-link))))
         (when it-better-fit
           (error "it-better-fit and it doesn't"))
         (if nil ; (not (eql free-link $pheap-nil))
           ; Try the next segment in the free list
           (%allocate-storage-internal
            disk-cache area free-link size segment initial-segment)
           ; Does not fit in any of the existing segments. Make a new one.
           (let ((new-segment (dc-cons-segment
                               disk-cache
                               area
                               (max
                                (dc-%svref disk-cache area $area.segment-size)
                                (addr+
                                 disk-cache
                                 (+ $block-overhead
                                    (normalize-size (* 4 $segment-header-size))
                                    $vector-header-size)
                                 size)))))
             (%allocate-storage-internal
              disk-cache area new-segment size segment initial-segment t))))))))

(defun maybe-default-disk-cache-area (disk-cache area)
  (unless area
    (setq area (dc-default-consing-area disk-cache)))
  (require-satisfies dc-vector-subtype-p disk-cache area $v_area)
  area)

(defun maybe-default-area (pheap area)
  (if area
    (pheap-pptr-pointer area pheap)
    (pheap-consing-area pheap)))

(defun p-cons (pheap car cdr &optional area)
  (multiple-value-bind (car-p car-immediate?) (%p-store pheap car)
    (multiple-value-bind (cdr-p cdr-immediate?) (%p-store pheap cdr)
      (pptr pheap
            (dc-cons (pheap-disk-cache pheap)
                          car-p cdr-p car-immediate? cdr-immediate?
                          (maybe-default-area pheap area))))))

(defun dc-cons (disk-cache car cdr &optional
                                car-immediate? cdr-immediate? area)
  (let ((address (%allocate-storage disk-cache area 8)))
    (setf (read-pointer disk-cache (- address 4) car-immediate?) car
          (read-pointer disk-cache address cdr-immediate?) cdr)
    address))

(defun p-list (pheap &rest elements)
  (declare (dynamic-extent elements))
  (%p-list*-in-area pheap nil elements))

(defun p-list-in-area (pheap area &rest elements)
  (declare (dynamic-extent elements))
  (%p-list*-in-area pheap area elements))

(defun %p-list*-in-area (pheap area elements)
  (let* ((disk-cache (pheap-disk-cache pheap))
         (res $pheap-nil)
         (area-pointer (maybe-default-area pheap area)))
    (require-satisfies dc-vector-subtype-p disk-cache area-pointer $v_area)
    (setq elements (nreverse elements))
    (dolist (element elements)
      (multiple-value-bind (car car-imm?) (%p-store pheap element)
        (setq res (dc-cons disk-cache car res car-imm? nil area-pointer))))
    (pptr pheap res)))

(defun p-make-list (pheap size &key initial-element area)
  (let* ((disk-cache (pheap-disk-cache pheap))
         (area-pointer (maybe-default-area pheap area)))
    (require-satisfies dc-vector-subtype-p disk-cache area-pointer $v_area)
    (multiple-value-bind (ie ie-imm?) (%p-store pheap initial-element)
      (pptr pheap (dc-make-list disk-cache size ie area ie-imm?)))))

(defun dc-make-list (disk-cache size &optional ie area ie-imm?)
  (when (and (null ie) (not ie-imm?))
    (setq ie $pheap-nil))
  (let ((res $pheap-nil))
    (dotimes (i size)
      (setq res (dc-cons disk-cache ie res ie-imm? nil area)))
    res))

(defun p-make-uvector (pheap length subtype &key
                             (initial-element nil ie?)
                             area)
  (let (ie ie-imm?)
    (when ie?
      (multiple-value-setq (ie ie-imm?) (%p-store pheap initial-element)))
    (pptr pheap
          (dc-make-uvector
           (pheap-disk-cache pheap)
           length
           subtype
           (maybe-default-area pheap area)
           ie ie-imm?))))

(defun dc-make-uvector (disk-cache length &optional
                                        (subtype $v_genv)
                                        area
                                        initial-element
                                        ie-imm?)
  (setq area (maybe-default-disk-cache-area disk-cache area))
  (if (eql subtype $v_bitv)
    (%cons-bit-vector disk-cache area length initial-element ie-imm?)
    (progn
      (if (and (eq subtype $v_sstr) ie-imm?)
        (setq initial-element (char-code initial-element)))
      (%cons-vector-in-area disk-cache area length subtype initial-element ie-imm?))))

(defun p-make-vector (pheap length &key
                            (initial-element nil ie?)
                            area)
  (let (ie ie-imm?)
    (when ie?
      (multiple-value-setq (ie ie-imm?) (%p-store pheap initial-element)))
    (pptr pheap
          (dc-make-vector
           (pheap-disk-cache pheap)
           length
           (maybe-default-area pheap area)
           ie ie-imm?))))

(defun dc-make-vector (disk-cache length &optional
                                  area
                                  initial-element
                                  ie-imm?)
  (dc-make-uvector disk-cache length $v_genv area initial-element ie-imm?))

(defun %cons-bit-vector (disk-cache area length &optional initial-element ie-imm?)
  (let* ((bytes (1+ (ceiling length 8))))
    (unless (< bytes (expt 2 24))
      (error "Attempt to allocate a vector larger than ~s bytes long"
             (1- (expt 2 24))))
    (when initial-element
      (unless ie-imm?
        (error "Attempt to create a bit-vector with a non-bit initial-element."))
      (ecase initial-element
        (0)
        (1 (setq initial-element #xff))))
    (locally (declare (fixnum bytes))
      (let* ((address (%allocate-storage disk-cache area (+ $vector-header-size bytes)))
             (res (initialize-vector-storage
                   disk-cache (- address $t_cons) bytes $v_bitv 1
                   initial-element ie-imm?)))
        (setf (read-8-bits disk-cache (addr+ disk-cache res $v_data)) (mod length 8))
        res))))

(defun p-make-array (pheap dimensions &key 
                           area
                           (element-type t)
                           initial-contents
                           initial-element
                           adjustable
                           fill-pointer
                           displaced-to
                           displaced-index-offset)
  (let (ie ie-imm?)
    (when initial-element               ; NIL is the default
      (multiple-value-setq (ie ie-imm?) (%p-store pheap initial-element)))
    (pptr pheap
          (dc-make-array
           (pheap-disk-cache pheap)
           (p-load dimensions)
           (if (pptr-p area) 
             (pheap-pptr-pointer area pheap)
             (pheap-consing-area pheap))
           (p-load element-type)
           ie
           ie-imm?
           initial-contents
           adjustable
           fill-pointer
           displaced-to
           displaced-index-offset))))

(defun dc-make-array (disk-cache dimensions &optional
                                 area (element-type t) initial-element ie-imm?
                                 initial-contents adjustable
                                 fill-pointer displaced-to
                                 displaced-index-offset)
  (when (or initial-contents adjustable fill-pointer
            displaced-to displaced-index-offset)
    (error "Unsupported array option. Only support :initial-element & :area"))
  (let ((subtype (array-element-type->subtype element-type)))
    (if (or (atom dimensions) (null (cdr dimensions)))
      ; one-dimensional array
      (let ((length (require-type
                     (if (atom dimensions) dimensions (car dimensions))
                     'fixnum)))
        (dc-make-uvector disk-cache length subtype area initial-element ie-imm?))
      ; multi-dimensional array
      (progn
        (dolist (dim dimensions)
          (unless (and (fixnump dim) (>= dim 0))
            (error "Array dimension not a fixnum or less than 0: ~s")))
        (let ((rank (length dimensions))
              (length (apply #'* dimensions)))
          (unless (fixnump length)
            (error "Attempt to create multidimensional of size > ~s"
                   most-positive-fixnum))
          (unless (< rank (/ (expt 2 15) 4))
            (error "rank ~s > (/ (expt 2 15) 4)" rank))
          (let ((vector (dc-make-uvector
                         disk-cache length subtype area initial-element ie-imm?))
                (arrayh (dc-make-uvector disk-cache (+ $arh.dims rank 1) $v_arrayh area 0 t)))
            (setf (dc-%svref disk-cache arrayh $arh.vect) vector
                  (dc-%arrayh-rank4 disk-cache arrayh) (* 4 rank)
                  (dc-%arrayh-type disk-cache arrayh) (old-wood->ccl-subtype subtype)
                  (dc-%arrayh-bits disk-cache arrayh) (ash 1 $arh_simple_bit))
            (let ((dims dimensions)
                  (index $arh.fill))
              (declare (fixnum index))
              (dotimes (i (the fixnum rank))
                (setf (dc-%svref disk-cache arrayh index t) (pop dims))
                (incf index)))
            arrayh))))))
            

(defparameter *array-element-type->subtype*
  '((bit . #.$v_bitv)
    ((signed-byte 8) . #.$v_sbytev)
    ((unsigned-byte 8) . #.$v_ubytev)
    ((signed-byte 16) . #.$v_swordv)
    ((unsigned-byte 16) . #.$v_uwordv)
    ((signed-byte 32) . #.$v_slongv)
    ((unsigned-byte 32) . #.$v_ulongv)
    (double-float . #.$v_floatv)
    (character . #.$v_sstr)
    (t . #.$v_genv)))

(defun array-element-type->subtype (element-type)
  (if (eq element-type t)
    $v_genv
    (dolist (pair *array-element-type->subtype*
                  (error "Can't find subtype. Shouldn't happen."))
      (if (subtypep element-type (car pair))
        (return (cdr pair))))))

(defun p-vector (pheap &rest elements)
  (declare (dynamic-extent elements))
  (p-uvector* pheap $v_genv elements))

(defun p-uvector (pheap subtype &rest elements)
  (declare (dynamic-extent elements))
  (p-uvector* pheap subtype elements))

(defun p-uvector* (pheap subtype elements)
  (let* ((genv? (eql (svref *subtype->uvsetter* subtype) 'uvset-genv))
         (vector (p-make-uvector pheap (length elements) subtype))
         (disk-cache (pheap-disk-cache pheap))
         (vector-pointer (pptr-pointer vector))
         (i 0))
    (if genv?
      (dolist (element elements)
        (multiple-value-bind (e imm?) (%p-store pheap element)
          (setf (dc-%svref disk-cache vector-pointer i imm?) e)
          (incf i)))
      (dolist (element elements)
        (multiple-value-bind (e imm?) (%p-store pheap element)
          (setf (dc-uvref disk-cache vector-pointer i imm?) e)
          (incf i))))
    vector))

(defun p-cons-population (pheap data &optional (type 0))
  (p-uvector pheap $v_weakh nil type data))

(def-accessor ccl::population-data (p) (disk-cache pointer)
  (require-satisfies dc-vector-subtype-p disk-cache pointer $v_weakh)
  (dc-%svref disk-cache pointer $population.data))
              
(defun p-make-load-function-object (pheap load-function.args init-function.args
                                          &optional area)
  (require-satisfies p-consp load-function.args)
  (require-satisfies p-listp init-function.args)
  (pptr pheap
        (dc-make-load-function-object
         (pheap-disk-cache pheap)
         (%p-store pheap load-function.args)
         (%p-store pheap init-function.args)
         (if (pptr-p area) 
           (pheap-pptr-pointer area pheap)
           (pheap-consing-area pheap)))))


(defun dc-make-load-function-object (disk-cache load-function.args init-function.args
                                                &optional area)
  (let ((vector (dc-make-uvector disk-cache $load-function-size
                                 $v_load-function area)))
    (dc-%svfill disk-cache vector
      $load-function.load-list load-function.args
      $load-function.init-list init-function.args)
    vector))

(defmethod p-make-load-function ((object t))
  nil)

(defmethod p-make-load-function-using-pheap ((pheap pheap) object)
  (p-make-load-function object))        ; backward compatibility

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Packages and symbols
;;;
      
(defun p-find-package (pheap package)
  (if (and (pptr-p package)
           (p-packagep package))
    package
    (multiple-value-bind (pkg pkg-imm?) (split-pptr package)
      (let ((pointer (dc-find-package (pheap-disk-cache pheap) pkg pkg-imm?)))
        (when pointer
          (pptr pheap pointer))))))

; Returns a disk-resident package, memory-resident package, or memory-resident string
(defun dc-canonicalize-pkg-arg (disk-cache pkg pkg-imm?)
  (if pkg-imm?
    (values
     (if (packagep pkg)
       pkg
       (string pkg))
     t)
    (if (dc-packagep disk-cache pkg)
      pkg
      (values (pointer-load (disk-cache-pheap disk-cache)
                            (dc-string disk-cache pkg)
                            :default
                            disk-cache)
              t))))

(defun dc-find-package (disk-cache pkg &optional pkg-imm?)
  (multiple-value-bind (pkg pkg-imm?) (dc-canonicalize-pkg-arg disk-cache pkg pkg-imm?)
    (if (not pkg-imm?)
      pkg
      (let* ((pkg-name (if (packagep pkg)
                         (package-name pkg)
                         (string pkg)))
             (btree (dc-package-btree disk-cache nil)))
        (and btree
             (dc-btree-lookup disk-cache btree pkg-name))))))

(defun p-package-btree (pheap &optional (create? t))
  (let ((pointer (dc-package-btree (pheap-disk-cache pheap) create?)))
    (and pointer (pptr pheap pointer))))

(defun dc-package-btree (disk-cache &optional (create? t))
  (with-databases-locked
   (let ((btree (dc-%svref disk-cache $root-vector $pheap.package-btree)))
     (if (not (eql $pheap-nil btree))
       btree
       (when create?
         (setf (dc-%svref disk-cache $root-vector $pheap.package-btree)
               (dc-make-btree disk-cache)))))))

(defun p-make-package (pheap package-name &key nicknames)
  (pptr pheap (dc-make-package (pheap-disk-cache pheap)
                               (p-load package-name)
                               (p-load nicknames))))

(defun dc-make-package (disk-cache name &optional nicknames)
  (let* ((pkg-name (ensure-simple-string (string name)))
         (btree (dc-package-btree disk-cache)))
    (with-databases-locked
     (if (dc-btree-lookup disk-cache btree pkg-name)
       (error "package name ~s already in use in ~s"
              pkg-name (disk-cache-pheap disk-cache))
       (dc-btree-store
        disk-cache
        btree
        pkg-name
        (dc-cons-package disk-cache pkg-name nicknames))))))

(defun p-cons-package (pheap pkg-name &optional nicknames)
  (pptr pheap
        (dc-cons-package (pheap-disk-cache pheap)
                         (p-load pkg-name)
                         (p-load nicknames)
                         pheap)))

(defun dc-cons-package (disk-cache pkg-name &optional
                                   nicknames
                                   (pheap (disk-cache-pheap disk-cache)))
  (let* ((names (mapcar #'(lambda (x) (ensure-simple-string (string x)))
                        (cons pkg-name nicknames)))
         (p-names (%p-store pheap names))
         (package (dc-make-uvector disk-cache $pkg-length $v_pkg)))
    (setf (dc-uvref disk-cache package $pkg.names) p-names
          (dc-uvref disk-cache package $pkg.btree) (dc-make-btree disk-cache))
    package))
        

(defun p-intern (pheap string &key
                       (package *package*)
                       (area nil area-p))
  (multiple-value-bind (pkg pkg-imm?) (split-pptr package)
    (pptr pheap (dc-intern (pheap-disk-cache pheap)
                           (p-load string)
                           pkg pkg-imm?
                           (if area-p 
                             (pheap-pptr-pointer area pheap)
                             (pheap-consing-area pheap))
                           pheap))))

(defun dc-intern (disk-cache string pkg &optional pkg-imm? area pheap)
  (let* ((pkg (and pkg (dc-find-or-make-package disk-cache pkg pkg-imm?)))
         (str (require-type string 'string))
         (btree (and pkg (dc-%svref disk-cache pkg $pkg.btree))))
    (with-databases-locked
     (or (and pkg (dc-btree-lookup disk-cache btree str))
         (dc-%make-symbol disk-cache str pkg btree area pheap)))))

(defun dc-%make-symbol (disk-cache str pkg &optional pkg-btree area pheap str-pointer)
  (let ((sym (dc-cons-symbol disk-cache
                             (or str-pointer
                                 (%p-store (or pheap (disk-cache-pheap disk-cache)) str))
                             (or pkg $pheap-nil)
                             area)))
    (when pkg
      (dc-btree-store
       disk-cache
       (or pkg-btree (dc-%svref disk-cache pkg $pkg.btree))
       (setq str (ensure-simple-string str))
       sym))
    sym))

(defun dc-find-or-make-package (disk-cache package &optional pkg-imm?)
  (multiple-value-bind (pkg pkg-imm?)
                       (dc-canonicalize-pkg-arg disk-cache package pkg-imm?)
    (with-databases-locked
     (or (dc-find-package disk-cache pkg pkg-imm?)
         (let* ((pkg (or (if (packagep package) package (find-package package))
                         (error "There is no package named ~s") package))
                (pkg-name (package-name pkg))
                (nicknames (package-nicknames pkg)))
           (dc-make-package disk-cache pkg-name nicknames))))))

(defun dc-cons-symbol (disk-cache string-pointer package &optional area)
  (let ((sym (+ (- $t_symbol $t_cons)
                (%allocate-storage disk-cache area $symbol-size))))
    (setf (read-long disk-cache (+ sym $sym_header)) $symbol-header
          (read-long disk-cache (addr+ disk-cache sym $sym_pname)) string-pointer
          (read-long disk-cache (addr+ disk-cache sym $sym_package)) package
          (read-long disk-cache (addr+ disk-cache sym $sym_values)) $pheap-nil)
    sym))

(defun p-find-symbol (pheap string &optional (package *package*))
  (multiple-value-bind (pkg pkg-imm?) (split-pptr package)
    (let ((pointer (dc-find-symbol (pheap-disk-cache pheap) string pkg pkg-imm?)))
      (and pointer (pptr pheap pointer)))))

(defun dc-find-symbol (disk-cache string &optional (package *package*) pkg-imm?)
  (let* ((pkg (dc-find-package disk-cache package pkg-imm?))
         (str (require-type string 'string)))
    (and pkg
         (dc-btree-lookup disk-cache
                          (dc-%svref disk-cache pkg $pkg.btree)
                          str))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Hash tables
;;;

(defun p-make-hash-table (pheap &key (test 'eq) weak area)
  (pptr pheap (dc-make-hash-table 
               (pheap-disk-cache pheap)
               :test test
               :weak weak
               :area (maybe-default-area pheap area))))

(defun dc-make-hash-table (disk-cache &key (test 'eq) weak area)
  (unless (or (eq test 'eq) (eq test #'eq))
    (error "Only ~s hash tables supported" 'eq))
  (let ((type (ecase weak
                ((nil) $btree-type_eqhash)
                (:key $btree-type_eqhash-weak-key)
                (:value $btree-type_eqhash-weak-value))))
    (dc-make-btree disk-cache area type)))

(defun p-btree-p (p)
  (and (pptr-p p)
       (dc-btree-p (pptr-disk-cache p) (pptr-pointer p))))

(defun dc-btree-p (disk-cache pointer)
  (dc-vector-subtype-p disk-cache pointer $v_btree))

(def-predicate hash-table-p (p disk-cache pointer)
  (and (dc-btree-p disk-cache pointer)
       (> (dc-uvsize disk-cache pointer) $btree.type)   ; early versions missing this slot
       (logbitp $btree-type_eqhash-bit
                (dc-%svref-fixnum disk-cache pointer $btree.type '$btree.type))))

(def-accessor hash-table-count (p) (disk-cache pointer)
  (require-satisfies dc-hash-table-p disk-cache pointer)
  (dc-btree-count disk-cache pointer))

(def-accessor btree-count (p) (disk-cache pointer)
  (require-satisfies dc-btree-p disk-cache pointer)
  (dc-%svref disk-cache pointer $btree.count))

(defun btree-count (p)
  (declare (ignore p))
  (error "~s is only defined for wood btrees" 'btree-count))

(defun p-gethash (key hash &optional default)
  (if (pptr-p hash)
    (let* ((pheap (pptr-pheap hash))
           (hash-pointer (pptr-pointer hash))
           (disk-cache (pheap-disk-cache pheap)))
      (require-satisfies dc-hash-table-p disk-cache hash-pointer)
      (multiple-value-bind (value imm?) (%p-store-hash-key pheap key)
        (multiple-value-bind (res res-imm? found?)
                             (and value
                                  (dc-gethash disk-cache value imm? hash-pointer))
          (if found?
            (values
             (if res-imm?
               res
               (pptr pheap res))
             t)
            default))))
    (gethash key hash default)))

; This could be just %p-store, but I'd rather not look in the
; btree if I know that the key can't be EQ.
(defun %p-store-hash-key (pheap key)
  (if (pptr-p key)
    (pheap-pptr-pointer key pheap)
    (cond ((immediate-object-p key) (values key t))
          ((null key) $pheap-nil)
          (t
           (with-databases-locked
            (maybe-cached-address pheap key
              ; This will be slightly faster if the p-find-xxx's are changed
              ; to dc-find-xxx.
              (or (cond ((symbolp key)
                         (split-pptr (p-find-symbol
                                      pheap (symbol-name key) (symbol-package key))))
                        ((packagep key)
                         (split-pptr (p-find-package pheap key)))
                        ((typep key 'class)
                         (split-pptr (p-find-class pheap key nil))))
                  (return-from %p-store-hash-key nil))))))))

(defmacro with-dc-hash-key ((key-var key key-imm?) &body body)
  (let ((s4 (gensym))
        (s3 (gensym))
        (s2 (gensym))
        (s1 (gensym)))
    `(let* ((,s4 (make-string 4 :element-type 'base-character))
            (,s3 (make-string 3 :element-type 'base-character))
            (,s2 (make-string 2 :element-type 'base-character))
            (,s1 (make-string 1 :element-type 'base-character))
            ,key-var)
       (declare (dynamic-extent ,s4 ,s3 ,s2 ,s1))
       (%store-pointer ,key ,s4 0 ,key-imm?)
       (locally (declare (optimize (speed 3) (safety 0)))
         (if (eql #\000 (schar ,s4 0))
           (if (eql #\000 (schar ,s4 1))
             (if (eql #\000 (schar ,s4 2))
               (setf (schar ,s1 0) (schar ,s4 3)
                     ,key-var ,s1)
               (setf (schar ,s2 0) (schar ,s4 2)
                     (schar ,s2 1) (schar ,s4 3)
                     ,key-var ,s2))
             (setf (schar ,s3 0) (schar ,s4 1)
                   (schar ,s3 1) (schar ,s4 2)
                   (schar ,s3 2) (schar ,s4 3)
                   ,key-var ,s3))
           (setq ,key-var ,s4)))
       ,@body)))

(defun dc-hash-key-value (key-string)
  (let* ((s (make-string 4 :element-type 'base-character))
         (len (length key-string)))
    (declare (dynamic-extent s)
             (fixnum len))
    (locally (declare (optimize (speed 3) (safety 0)))
      (setf (schar s 0)
            (setf (schar s 1)
                  (setf (schar s 2)
                        (setf (schar s 3) #\000)))))
    (if (> len 4) (error "Bad hash-table key-string: ~s" key-string))
    (%copy-byte-array-portion key-string 0 len s (the fixnum (- 4 len)))
    (%load-pointer s 0)))

(defun dc-gethash (disk-cache key key-imm? hash)
  (with-dc-hash-key (key-string key key-imm?)
    (dc-btree-lookup disk-cache hash key-string)))
  
(defun (setf p-gethash) (value key hash &optional default)
  (declare (ignore default))
  (if (pptr-p hash)
    (let* ((pheap (pptr-pheap hash))
           (hash-pointer (pptr-pointer hash))
           (disk-cache (pheap-disk-cache pheap)))
      (require-satisfies dc-hash-table-p disk-cache hash-pointer)
      (multiple-value-bind (vp vi?) (%p-store pheap value)
        (multiple-value-bind (kp ki?) (%p-store pheap key)
          (dc-puthash disk-cache kp ki? hash-pointer vp vi?)
          (if vi?
            vp
            (pptr pheap vp)))))
    (setf (gethash key hash) value)))

(defun dc-puthash (disk-cache key key-imm? hash value &optional value-imm?)
  (with-dc-hash-key (key-string key key-imm?)
    (dc-btree-store disk-cache hash key-string value value-imm?)))

(defun p-remhash (key hash)
  (if (pptr-p hash)
    (let ((pheap (pptr-pheap hash)))
      (multiple-value-bind (value imm?) (%p-store-hash-key pheap key)
        (dc-remhash (pheap-disk-cache pheap) value imm? (pptr-pointer hash))))
    (remhash key hash)))

(defun dc-remhash (disk-cache key key-imm? hash)
  (with-dc-hash-key (key-string key key-imm?)
    (dc-btree-delete disk-cache hash key-string)))

(defun p-clrhash (hash)
  (if (pptr-p hash)
    (progn
      (dc-clrhash (pptr-disk-cache hash) (pptr-pointer hash))
      hash)
    (clrhash hash)))

(defun dc-clrhash (disk-cache hash)
  (dc-clear-btree disk-cache hash))

(defun p-maphash (function hash)
  (if (pptr-p hash)
    (let* ((pheap (pptr-pheap hash))
           (disk-cache (pheap-disk-cache pheap))
           (pointer (pptr-pointer hash)))
      (require-satisfies dc-hash-table-p disk-cache pointer)
      (let ((f #'(lambda (disk-cache key value value-imm?)
                   (declare (ignore disk-cache))
                   (multiple-value-bind (key-value key-imm?) (dc-hash-key-value key)
                     (funcall function
                              (if key-imm? key-value (pptr pheap key-value))
                              (if value-imm? value (pptr pheap value)))))))
        (declare (dynamic-extent f))
        (dc-map-btree disk-cache pointer f)))
    (maphash function hash)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; load barriars
;;;

(defun p-make-pload-barrier (pheap object)
  (multiple-value-bind (addr addr-imm?) (%p-store pheap object)
    (if addr-imm?
      object
      (pptr pheap
            (dc-make-pload-barrier (pheap-disk-cache pheap) addr)))))

; New function
(defun dc-make-pload-barrier (disk-cache address)
  (dc-make-uvector disk-cache $pload-barrier-size $v_pload-barrier nil address))

(defun p-load-pload-barrier (pheap disk-cache pointer depth subtype)
  (declare (ignore subtype depth))
  (pptr pheap (dc-%svref disk-cache pointer $pload-barrier.object)))

(defun p-load-through-barrier (object &optional (depth :default))
  (if (pptr-p object)
    (let* ((pheap (pptr-pheap object))
           (pointer (pptr-pointer object))
           (disk-cache (pheap-disk-cache pheap)))
      (if (dc-vector-subtype-p disk-cache pointer $v_pload-barrier)
        (pointer-load pheap (dc-%svref disk-cache pointer $pload-barrier.object)
                      depth disk-cache)
        (p-load object depth)))
    (p-load object depth)))

(defun p-uvector-subtype-p (p subtype)
  (if (pptr-p p)
    (dc-vector-subtype-p (pptr-disk-cache p) (pptr-pointer p) subtype)
    (ccl::uvector-subtype-p p subtype)))

(defun pload-barrier-p (object)
  (p-uvector-subtype-p object $v_pload-barrier))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Dispatch tables
;;;

(defparameter *p-load-subtype-functions*
  #(p-load-error                        ;($v_packed_sstr 0)
    p-load-bignum                       ;($v_bignum 1)
    p-load-error                        ;($v_macptr 2) - not supported
    p-load-ivector                      ;($v_badptr 3)
    p-load-lfun-vector                  ;($v_nlfunv 4)
    p-load-error                        ;subtype 5 unused
    p-load-ivector                      ;($v_xstr 6)      ;extended string
    p-load-ivector                      ;($v_ubytev 7)    ;unsigned byte vector
    p-load-ivector                      ;($v_uwordv 8)    ;unsigned word vector
    p-load-ivector                      ;($v_floatv 9)    ;float vector
    p-load-ivector                      ;($v_slongv 10)   ;Signed long vector
    p-load-ivector                      ;($v_ulongv 11)   ;Unsigned long vector
    #-ppc-target p-load-ivector         ;($v_bitv 12)     ;Bit vector
    #+ppc-target p-load-bit-vector
    p-load-ivector                      ;($v_sbytev 13)   ;Signed byte vector
    p-load-ivector                      ;($v_swordv 14)   ;Signed word vector
    p-load-ivector                      ;($v_sstr 15)     ;simple string
    p-load-gvector                      ;($v_genv 16)     ;simple general vector
    p-load-arrayh                       ;($v_arrayh 17)   ;complex array header
    p-load-struct                       ;($v_struct 18)   ;structure
    p-load-error                        ;($v_mark 19)     ;buffer mark
    p-load-pkg                          ;($v_pkg 20)
    p-load-error                        ;subtype 21 unused
    p-load-istruct                      ;($v_istruct 22)
    p-load-ivector                      ;($v_ratio 23)
    p-load-ivector                      ;($v_complex 24)
    p-load-instance                     ;($v_instance 25) ;clos instance
    p-load-error                        ;subtype 26 unused
    p-load-error                        ;subtype 27 unused
    p-load-error                        ;subtype 28 unused
    p-load-header                       ;($v_weakh 29)
    p-load-header                       ;($v_poolfreelist 30)
    p-load-nhash                        ;($v_nhash 31)
    ; internal subtypes
    p-load-nop                          ;($v_area 32)
    p-load-nop                          ;($v_segment 33)
    p-load-nop                          ;($v_random-bits 34)
    p-load-nop                          ;($v_dbheader 35)
    p-load-nop                          ;($v_segment-headers 36)
    p-load-nop                          ;($v_btree 37)
    p-load-nop                          ;($v_btree-node 38)
    p-load-class                        ;($v_class 39)
    p-load-load-function                ;($v_load-function 40)
    p-load-pload-barrier                ;($v_pload-barrier 41)
    ))

(defparameter *subtype->bytes-per-element*
  #(nil                                 ; 0 - unused
    2                                   ; 1 - $v_bignum
    nil                                 ; 2 - $v_macptr - not supported
    4                                   ; 3 - $v_badptr
    2                                   ; 4 - $v_nlfunv
    nil                                 ; 5 - unused
    2                                   ; 6 - $v_xstr - extended string
    1                                   ; 7 - $v_ubytev - unsigned byte vector
    2                                   ; 8 - $v_uwordv - unsigned word vector
    8                                   ; 9 - $v_floatv - float vector
    4                                   ; 10 - $v_slongv - Signed long vector
    4                                   ; 11 - $v_ulongv - Unsigned long vector
    nil                                   ; 12 - $v_bitv - Bit vector (handled specially)
    1                                   ; 13 - $v_sbytev - Signed byte vector
    2                                   ; 14 - $v_swordv - Signed word vector
    1                                   ; 15 - $v_sstr - simple string
    4                                   ; 16 - $v_genv - simple general vector
    4                                   ; 17 - $v_arrayh - complex array header
    4                                   ; 18 - $v_struct - structure
    nil                                 ; 19 - $v_mark - buffer mark unimplemented
    4                                   ; 20 - $v_pkg
    nil                                 ; 21 - unused
    4                                   ; 22 - $v_istruct - type in first element
    4                                   ; 23 - $v_ratio
    4                                   ; 24 - $v_complex
    4                                   ; 25 - $v_instance - clos instance
    nil                                 ; 26 - unused
    nil                                 ; 27 - unused
    nil                                 ; 28 - unused
    4                                   ; 29 - $v_weakh - weak list header
    4                                   ; 30 - $v_poolfreelist - free pool header
    4                                   ; 31 - $v_nhash
    ; WOOD specific subtypes
    4                                   ; 32 - $v_area - area descriptor
    4                                   ; 33 - $v_segment - area segment
    1                                   ; 34 - $v_random-bits - vectors of random bits, e.g. resources
    4                                   ; 35 - $v_dbheader - database header
    nil                                 ; 36 - $v_segment-headers - specially allocated
    4                                   ; 37 - $v_btree
    nil                                 ; 38 - $v_btree-node - specially allocated
    4                                   ; 39 - $v_class
    4                                   ; 40 - $v_load-function
    4                                   ;($v_pload-barrier 41)
    ))

(defparameter *p-store-subtype-functions*
  #(nil                                 ;($v_packed_sstr 0)
    p-store-ivector                      ;($v_bignum 1)
    nil                                 ;($v_macptr 2) - not supported
    p-store-ivector                     ;($v_badptr 3)
    nil                                 ;($v_nlfunv 4)
    nil                                 ;subtype 5 unused
    p-store-ivector                     ;($v_xstr 6)      ;16-bit string
    p-store-ivector                     ;($v_ubytev 7)    ;unsigned byte vector
    p-store-ivector                     ;($v_uwordv 8)    ;unsigned word vector
    p-store-ivector                     ;($v_floatv 9)    ;float vector
    p-store-ivector                     ;($v_slongv 10)   ;Signed long vector
    p-store-ivector                     ;($v_ulongv 11)   ;Unsigned long vector
    #-ppc-target p-store-ivector        ;($v_bitv 12)     ;Bit vector
    #+ppc-target p-store-bit-vector
    p-store-ivector                     ;($v_sbytev 13)   ;Signed byte vector
    p-store-ivector                     ;($v_swordv 14)   ;Signed word vector
    p-store-ivector                     ;($v_sstr 15)     ;simple string
    p-store-gvector                     ;($v_genv 16)     ;simple general vector
    p-store-gvector                     ;($v_arrayh 17)   ;complex array header
    p-store-gvector                     ;($v_struct 18)   ;structure
    nil                                 ;($v_mark 19)     ;buffer mark
    nil                                 ;($v_pkg 20)
    nil                                 ;subtype 21 unused
    p-store-gvector                     ;($v_istruct 22)
    p-store-ivector                     ;($v_ratio 23)
    p-store-ivector                     ;($v_complex 24)
    nil                                 ;($v_instance 25) ;clos instance
    nil                                 ;subtype 26 unused
    nil                                 ;subtype 27 unused
    nil                                 ;subtype 28 unused
    p-store-gvector                     ;($v_weakh 29)
    p-store-gvector                     ;($v_poolfreelist 30)
    p-store-gvector                     ;($v_nhash 31)
    ))

(defparameter *subtype->uvreffer*
  #(nil                                 ; 0 - unused
    uvref-unsigned-word                 ; 1 - $v_bignum
    nil                                 ; 2 - $v_macptr - not supported
    uvref-unsigned-long                 ; 3 - $v_badptr
    uvref-unsigned-word                 ; 4 - $v_nlfunv
    nil                                 ; 5 - unused
    uvref-extended-string               ; 6 - $v_xstr - extended string
    uvref-unsigned-byte                 ; 7 - $v_ubytev - unsigned byte vector
    uvref-unsigned-word                 ; 8 - $v_uwordv - unsigned word vector
    uvref-dfloat                        ; 9 - $v_floatv - float vector
    uvref-signed-long                   ; 10 - $v_slongv - Signed long vector
    uvref-unsigned-long                 ; 11 - $v_ulongv - Unsigned long vector
    uvref-bit-vector                    ; 12 - $v_bitv - Bit vector
    uvref-signed-byte                   ; 13 - $v_sbytev - Signed byte vector
    uvref-signed-word                   ; 14 - $v_swordv - Signed word vector
    uvref-string                        ; 15 - $v_sstr - simple string
    uvref-genv                          ; 16 - $v_genv - simple general vector
    uvref-genv                          ; 17 - $v_arrayh - complex array header
    uvref-genv                          ; 18 - $v_struct - structure
    nil                                 ; 19 - $v_mark - buffer mark unimplemented
    uvref-genv                          ; 20 - $v_pkg
    nil                                 ; 21 - unused
    uvref-genv                          ; 22 - $v_istruct - type in first element
    uvref-genv                          ; 23 - $v_ratio
    uvref-genv                          ; 24 - $v_complex
    uvref-genv                          ; 25 - $v_instance - clos instance
    nil                                 ; 26 - unused
    nil                                 ; 27 - unused
    nil                                 ; 28 - unused
    uvref-genv                          ; 29 - $v_weakh - weak list header
    uvref-genv                          ; 30 - $v_poolfreelist - free pool header
    uvref-genv                          ; 31 - $v_nhash
    ; WOOD specific subtypes
    uvref-genv                          ; 32 - $v_area - area descriptor
    uvref-genv                          ; 33 - $v_segment - area segment
    uvref-unsigned-byte                 ; 34 - $v_random-bits - vectors of random bits, e.g. resources
    uvref-genv                          ; 35 - $v_dbheader - database header
    nil                                 ; 36 - $v_segment-headers - specially allocated
    uvref-genv                          ; 37 - $v_btree
    nil                                 ; 38 - $v_btree-node - specially allocated
    uvref-genv                          ; 39 - $v_class
    uvref-genv                          ; 40 - $v_load-function
    uvref-genv                          ; 41 - $v_pload-barrier
    ))

(defparameter *subtype->uvsetter*
  #(nil                                 ; 0 - unused
    uvset-word                          ; 1 - $v_bignum
    nil                                 ; 2 - $v_macptr - not supported
    uvset-long                          ; 3 - $v_badptr
    uvset-word                          ; 4 - $v_nlfunv
    nil                                 ; 5 - unused
    uvset-extended-string               ; 6 - $v_xstr - extended string
    uvset-byte                          ; 7 - $v_ubytev - unsigned byte vector
    uvset-word                          ; 8 - $v_uwordv - unsigned word vector
    uvset-dfloat                        ; 9 - $v_floatv - float vector
    uvset-long                          ; 10 - $v_slongv - Signed long vector
    uvset-long                          ; 11 - $v_ulongv - Unsigned long vector
    uvset-bit-vector                    ; 12 - $v_bitv - Bit vector
    uvset-byte                          ; 13 - $v_sbytev - Signed byte vector
    uvset-word                          ; 14 - $v_swordv - Signed word vector
    uvset-string                        ; 15 - $v_sstr - simple string
    uvset-genv                          ; 16 - $v_genv - simple general vector
    uvset-genv                          ; 17 - $v_arrayh - complex array header
    uvset-genv                          ; 18 - $v_struct - structure
    nil                                 ; 19 - $v_mark - buffer mark unimplemented
    uvset-genv                          ; 20 - $v_pkg
    nil                                 ; 21 - unused
    uvset-genv                          ; 22 - $v_istruct - type in first element
    uvset-genv                          ; 23 - $v_ratio
    uvset-genv                          ; 24 - $v_complex
    uvset-genv                          ; 25 - $v_instance - clos instance
    nil                                 ; 26 - unused
    nil                                 ; 27 - unused
    nil                                 ; 28 - unused
    uvset-genv                          ; 29 - $v_weakh - weak list header
    uvset-genv                          ; 30 - $v_poolfreelist - free pool header
    uvset-genv                          ; 31 - $v_nhash
    ; WOOD specific subtypes
    uvset-genv                          ; 32 - $v_area - area descriptor
    uvset-genv                          ; 33 - $v_segment - area segment
    uvset-byte                          ; 34 - $v_random-bits - vectors of random bits, e.g. resources
    uvset-genv                          ; 35 - $v_dbheader - database header
    nil                                 ; 36 - $v_segment-headers - specially allocated
    uvset-genv                          ; 37 - $v_btree
    nil                                 ; 38 - $v_btree-node - specially allocated
    uvset-genv                          ; 39 - $v_class
    uvset-genv                          ; 40 - $v_load-function
    uvset-genv                          ; 41 - $v_pload-barrier
    ))

(defparameter *subtype-initial-element*
  #(nil                                 ; 0 - unused
    nil                                 ; 1 - $v_bignum
    nil                                 ; 2 - $v_macptr not implemented
    nil                                 ; 3 - $v_badptr not implemented
    nil                                 ; 4 - $v_nlfunv
    nil                                 ; 5 - unused
    nil                                 ; 6 - $v_xstr - extended string
    nil                                 ; 7 - $v_ubytev - unsigned byte vector
    nil                                 ; 8 - $v_uwordv - unsigned word vector
    0                                   ; 9 - $v_floatv - float vector
    nil                                 ; 10 - $v_slongv - Signed long vector
    nil                                 ; 11 - $v_ulongv - Unsigned long vector
    nil                                 ; 12 - $v_bitv - Bit vector
    nil                                 ; 13 - $v_sbytev - Signed byte vector
    nil                                 ; 14 - $v_swordv - Signed word vector
    nil                                 ; 15 - $v_sstr - simple string
    #.$pheap-nil                        ; 16 - $v_genv - simple general vector
    #.$pheap-nil                        ; 17 - $v_arrayh - complex array header
    #.$pheap-nil                        ; 18 - $v_struct - structure
    nil                                 ; 19 - $v_mark - buffer mark unimplemented
    #.$pheap-nil                        ; 20 - $v_pkg
    nil                                 ; 21 - unused
    #.$pheap-nil                        ; 22 - $v_istruct - type in first element
    0                                   ; 23 - $v_ratio
    0                                   ; 24 - $v_complex
    #.$pheap-nil                        ; 25 - $v_instance - clos instance
    nil                                 ; 26 - unused
    nil                                 ; 27 - unused
    nil                                 ; 28 - unused
    #.$pheap-nil                        ; 29 - $v_weakh - weak list header
    #.$pheap-nil                        ; 30 - $v_poolfreelist - free pool header
    nil                                 ; 31 - $v_nhash unused
    #.$pheap-nil                        ; 32 - $v_area - area descriptor
    #.$pheap-nil                        ; 33 - $v_segment - area segment
    nil                                 ; 34 - $v_random-bits - vectors of random bits, e.g. resources
    #.$pheap-nil                        ; 35 - $v_dbheader - database header
    nil                                 ; 36 - $v_segment-headers - specially allocated
    #.$pheap-nil                        ; 37 - $v_btree
    nil                                 ; 38 - $v_btree-node - specially allocated
    #.$pheap-nil                        ; 39 - $v_class
    #.$pheap-nil                        ; 40 - $v_load-function
    #.$pheap-nil                        ; 41 - $v_pload-barrier
    ))

#+ppc-target
(macrolet ((fill-subtype<->subtag-tables ()
             (let ((assoc-table
                    (vector
                                                        ; $v_sstr unsupported
                     ppc::subtag-bignum $v_bignum       ; 1
                     ppc::subtag-macptr $v_macptr       ; 2
                     ppc::subtag-dead-macptr $v_badptr  ; 3
                                                        ; 4 $v_nlfunv unsupported
                                                        ; 5 subtype unused
                     ppc::subtag-simple-general-string $v_xstr  ; 6
                     ppc::subtag-u8-vector $v_ubytev    ; 7
                     ppc::subtag-u16-vector $v_uwordv   ; 8
                     ppc::subtag-double-float-vector $v_floatv          ; 9
                     ppc::subtag-s32-vector $v_slongv   ; 10
                     ppc::subtag-u32-vector $v_ulongv   ; 11
                     ppc::subtag-bit-vector $v_bitv     ; 12
                     ppc::subtag-s8-vector $v_sbytev    ; 13
                     ppc::subtag-s16-vector $v_swordv   ; 14
                     ppc::subtag-simple-base-string $v_sstr     ; 15
                     ppc::subtag-simple-vector $v_genv  ; 16
                                                        ; 17 $v_arrayh handled specially
                     ppc::subtag-struct $v_struct       ; 18
                     ppc::subtag-mark $v_mark           ; 19
                     ppc::subtag-package $v_pkg         ; 20
                                                        ; 21 subtype unused
                     ppc::subtag-istruct $v_istruct     ; 22
                     ppc::subtag-ratio $v_ratio         ; 23
                     ppc::subtag-complex $v_complex     ; 24
                                                        ; 25 $v_instance handled specially
                                                        ; 26 subtype unused
                                                        ; 27 subtype unused
                                                        ; 28 subtype unused
                     ppc::subtag-weak $v_weakh          ; 29
                     ppc::subtag-pool $v_poolfreelist   ; 30
                     ppc::subtag-hash-vector $v_nhash   ; 31
                     ))
                   (ccl->wood (make-array 256 :initial-element nil))
                   (wood->ccl (make-array 32 :initial-element nil)))
               (do* ((i 0 (+ i 2)))
                   ((>= i (length assoc-table)))
                 (let ((ccl-subtag (aref assoc-table i))
                       (wood-subtype (aref assoc-table (1+ i))))
                   (setf (aref ccl->wood ccl-subtag) wood-subtype
                         (aref wood->ccl wood-subtype) ccl-subtag)))
               (setf (aref ccl->wood ppc::subtag-arrayh) $v_arrayh
                     (aref ccl->wood ppc::subtag-vectorh) $v_arrayh)
               `(progn
                  (setq *wood-subtype->ccl-subtag-table* ,wood->ccl
                        *ccl-subtag->wood-subtype-table* ,ccl->wood)
                  nil))))
  (fill-subtype<->subtag-tables))


#|

; Remove a pptr from the caches.
; Used while debugging p-xxx accessors
(defun pptr-decache (pptr)
  (let* ((pheap (pptr-pheap pptr))
         (pointer (pptr-pointer pptr))
         (pheap->mem-hash (pheap->mem-hash pheap)))
    (multiple-value-bind (value found) (gethash pointer pheap->mem-hash)
      (when found
        (remhash pointer pheap->mem-hash)
        (remhash value (mem->pheap-hash pheap))))))
    

(defun init-temp-pheap ()
  (declare (special pheap dc))
  (when (boundp 'pheap)
    (close-pheap pheap))
  (delete-file "temp.pheap")
  (create-pheap "temp.pheap")
  (setq pheap (open-pheap "temp.pheap")
        dc (pheap-disk-cache pheap))
  (dolist (w (windows :class 'inspector::inspector-window))
    (window-close w))
  (inspect dc))

(setq p $pheap-nil)

(time
 (dotimes (i 200)
   (setq p (dc-cons dc i p t nil))))

(time
   (dotimes (i 1000)
     (setq p (dc-make-uvector dc 12 $v_genv nil p))))

(defun crash-close (pheap)
  (let ((disk-cache (pheap-disk-cache pheap)))
    (close (disk-cache-stream disk-cache))
    (setq *open-disk-caches* (delq disk-cache *open-disk-caches*)
          *open-pheaps* (delq pheap *open-pheaps*)))
  nil)

|#
;;;    1   3/10/94  bill         1.8d247
;;;    2   6/22/94  bill         1.9d002
;;;    3   7/26/94  Derek        1.9d027
;;;    4   9/19/94  Cassels      1.9d061
;;;    5  10/04/94  bill         1.9d071
;;;    6  10/13/94  gz           1.9d074
;;;    7  10/30/94  gz           1.9d083
;;;    8  11/01/94  Derek        1.9d085 Bill's Saving Library Task
;;;    9  11/03/94  Moon         1.9d086
;;;    10  11/05/94  kab         1.9d087
;;;    11  11/21/94  gsb         1.9d100
;;;    12  12/02/94  gsb         1.9d111 (patch upload)
;;;    13  12/12/94  RŽti        1.9d112
;;;    2   2/18/95  RŽti         1.10d019
;;;    3   3/23/95  bill         1.11d010
;;;    4   6/02/95  bill         1.11d040
;;;    5   8/01/95  bill         1.11d065
;;;    6   8/18/95  bill         1.11d071
;;;    7   8/25/95  Derek        Derek and Neil's massive bug fix upload
;;;    8   9/13/95  bill         1.11d080
