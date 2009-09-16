;;;-*- Mode: Lisp; Package: WOOD -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; disk-cache.lisp
;; Code to support a cached byte I/O stream.
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
;; ------------- 0.96
;; ------------- 0.95
;; ------------- 0.94
;; 03/27/96 bill Dylan changes add a :read-only-p keyword to open-disk-cache
;; ------------- 0.93
;; 05/31/95 bill Shared swapping space:
;;               Move the page-size, max-pages, pages & locked-pages slots from the
;;               disk-cache structure to the new shared-buffer structure. disk-cache
;;               gets a new shared-buffer slot to hold a shared-buffer instance.
;;               cons-disk-page works with a NIL disk-cache arg.
;;               print-disk-page works if disk-page-stream is NIL.
;;               New shared-buffer-pool structure.
;;               New get-shared-buffer function, gets or allocates a shared-buffer of
;;               a particular page size from a shared-buffer-pool instance.
;;               open-disk-cache takes new shared-buffer & shared-buffer-pool keyword
;;               args. If shared-buffer-pool is specified, uses get-shared-buffer
;;               to get a shared-buffer. Otherwise, if shared-buffer is specified, uses
;;               it. Otherwise, conses up a new shared-buffer with the given page-size
;;               & swapping-space.
;;               close-disk-cache call remove-disk-cache-from-shared-buffer, a new function
;;               that removes all references to a disk-cache from the disk-page's in a shared-buffer.
;;               add-disk-pages adds the new pages to the disk-cache-shared-buffer.
;;               read-disk-page takes a new disk-cache argument and uses it to initialize the
;;               disk-page-disk-cache & disk-page-stream slots.
;;               flush-disk-page works if disk-page-disk-cache is NIL.
;;               get-disk-page, lock-page, unlock-page updated for using the disk-cache-shared-buffer.
;;               extend-disk-cache no longer calls add-disk-pages. It lets get-disk-page do so.
;; 05/25/95 Moon New constant: $disk-page-flags_touched-bit, set when a page is
;;               referenced.
;;               New functions, disk-page-touched? & (setf disk-page-touched?), to access
;;               the $disk-page-flags_touched-bit.
;;               get-disk-page now uses a 1-bit clock algorithm instead of
;;               least-recently-swapped to determine which page to swap out.
;; 05/25/95 bill *default-page-size* moves here from "persistent-heap.lisp".
;;               New parameter, *default-swapping-space*, is the default number
;;               of bytes to use for swapping space.
;;               New parameter, *big-io-buffers*, true if cl:open takes an
;;               :elements-per-buffer keyword arg.
;;               open-disk-cache defaults its page-size arg to
;;               *default-page-size* instead of 512. It errors if the page size
;;               is not at least 512. Doesn't pass an :external-format keyword
;;               arg to open unless one was passed in. If *big-io-buffers* is
;;               true, passes the page-size as the :elements-per-buffer keyword
;;               arg to open.
;;               extend-disk-cache takes a new, optional, extend-file? arg. If
;;               true, calls set-minimum-file-length to extend the length of the file.
;; ------------- 0.9
;; 11/17/95 bill poor man's transactions.
;;               open-disk-cache takes an :initial-transaction-p keyword.
;;               If nil (NOT the default), errors on any disk writes that
;;               happen outside of a start-disk-cache-transaction/commit-disk-cache-transaction
;;               pair.
;; 11/03/94 ows  open-disk-cache takes a mac-file-creator keyword,
;;               which it passes on to open.
;; 10/28/94 Moon Change without-interrupts to with-databases-locked.
;;               Remove interlocking from get-disk-page; callers must.
;;               Add comment "Must be called inside with-databases-locked"
;;               to with-locked-page.
;; 09/21/94 bill without-interrupts as necessary for interlocking
;; 07/26/94 bill get-disk-page allocates a new page if all the pages
;;               are locked. Hence, it can't fail unless out of memory.
;; ------------- 0.8
;; 03/27/93 bill with-open-disk-cache
;; ------------- 0.6
;; ------------- 0.5
;; 07/09/92 bill Don't extend the file until flushing a page requires it.
;;               Keep a lock count, not just a bit.
;; 03/05/92 bill New file
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; To do:
;;
;; with-databases-locked in just the right places.
;; Add a journaling option.
;; Multi-user support.
;;

(defpackage :wood)
(in-package :wood)

(export '(open-disk-cache close-disk-cache disk-cache-size
          get-disk-page mark-page-modified extend-disk-cache))

;;;;;;;;;;;;;
;;
;; (open-disk-cache filename &key shared-p page-size max-pages
;;                  if-exists if-does-not-exist)
;;
;; filename            string or pathname
;; shared-p            boolean. Open for shared I/O if specified and true.
;; page-size           default: 512
;; max-pages           default: 200
;; if-exists           nil, :error, :supersede, or :overwrite.
;;                     Default: :overwrite
;; if-does-not-exist   Same as for OPEN. default: :error. 
;;
;; returns one value, a DISK-CACHE structure

;;;;;;;;;;;;;
;;
;; (close-disk-cache disk-cache)
;;
;; Flushes dirty pages and closes the stream for the given disk-cache.

;;;;;;;;;;;;;
;;
;; (disk-cache-size disk-cache)
;;
;; Return the number of bytes in the file

;;;;;;;;;;;;;
;;
;; (get-disk-page disk-cache address &optional modify-p)
;;
;; disk-cache    DISK-CACHE structure, as returned from OPEN-DISK-CACHE.
;; address       fixnum. the address from/to you wish to I/O
;; modify-p      boolean. True if you plan to write. Default: nil.
;;
;; returns four values:
;; 1) array   an array of type (array (signed-byte 8)) containing the byte
;;            at address
;; 2) offset  fixnum. The offset in the array for the byte at address.
;; 3) length  fixnum. The number of bytes of valid data in array at offset.
;;                    Will be (- page-size (mod address page-size))
;;                    unless the page is the last one or later.
;; 4) page   a disk-page structure that can be passed to mark-page-modified

;;;;;;;;;;;;;
;;
;; (mark-page-modified disk-page)
;;
;; disk-page    DISK-PAGE structure as returned in the fourth value from
;;              GET-DISK-PAGE.
;;
;; Sometimes you don't know in advance whether you'll modify a page.
;;
;; Returns true if the page was not already marked as modified, NIL
;; otherwise.

;;;;;;;;;;;;;
;;
;; (extend-disk-cache disk-cache new-size)
;;
;; new-size   the new size of the file in bytes.
;;            If smaller than the current size, this is a NOP.


(defstruct (shared-buffer (:constructor cons-shared-buffer (page-size page-count max-pages pages))
                             (:print-function print-shared-buffer))
  (page-size 512)                       ; size of a disk-page in bytes
  page-count                            ; number of disk pages
  max-pages                             ; user's maximum
  pages                                 ; head of the disk-page chain
  locked-pages                          ; head of locked pages chain
  users                                 ; a list of disk-cache instances
  )

(defun print-shared-buffer (shared-buffer stream level)
  (declare (ignore level))
  (print-unreadable-object (shared-buffer stream :type t :identity t)
    (format stream "~s ~s/~s"
            (shared-buffer-page-size shared-buffer)
            (shared-buffer-page-count shared-buffer)
            (shared-buffer-max-pages shared-buffer))))

(defparameter *default-page-size* 512)
(defparameter *default-swapping-space* (* 100 1024))

(defun make-shared-buffer (&key (page-size *default-page-size*)
                                   (swapping-space *default-swapping-space*)
                                   max-pages)
  (if (null max-pages)
    (setq max-pages  (ceiling swapping-space page-size))
    (setq swapping-space (* max-pages page-size)))
  (unless (>= page-size 512)
    (error "Page size must be at least 512"))
  (unless (eql page-size (expt 2 (1- (integer-length page-size))))
    (error "page-size must be a power of 2"))
  (cons-shared-buffer
   page-size 0 max-pages nil))

(defstruct (shared-buffer-pool (:constructor cons-shared-buffer-pool
                                                (swapping-space page-size auxiliary-swapping-space)))
  (swapping-space *default-swapping-space*)
  (page-size *default-page-size*)
  (auxiliary-swapping-space *default-swapping-space*)
  buffers)

(defun make-shared-buffer-pool (&key (swapping-space *default-swapping-space*)
                                         (page-size *default-page-size*)
                                         (auxiliary-swapping-space
                                          (min swapping-space *default-swapping-space*)))
  (cons-shared-buffer-pool swapping-space page-size auxiliary-swapping-space))

(defun get-shared-buffer (pool page-size)
  (or (find page-size (shared-buffer-pool-buffers pool) :key 'shared-buffer-page-size)
      (let* ((swapping-space (if (eql page-size (shared-buffer-pool-page-size pool))
                               (shared-buffer-pool-swapping-space pool)
                               (shared-buffer-pool-auxiliary-swapping-space pool)))
             (buffer (make-shared-buffer :page-size page-size
                                         :swapping-space swapping-space)))
        (push buffer (shared-buffer-pool-buffers pool))
        buffer)))

(defstruct (disk-cache (:print-function print-disk-cache))
  stream                                ; a stream to a file
  size                                  ; the length of the file
  (page-size 512)                       ; size of a disk-page in bytes
  (mask -512)                           ; address mask
  shared-buffer                         ; a shared-buffer instance
  page-hash                             ; page-address -> disk-page structure
  dirty-pages                           ; head of the dirty page chain
  log                                   ; a LOG structure: see "recovery.lisp"
  write-hook                            ; hook to call when a page is written to disk
  file-eof                              ; current EOF on disk
  transaction                           ; current transaction (just a counter for now)
  )

(defun print-disk-cache (disk-cache stream level)
  (declare (ignore level))
  (print-unreadable-object (disk-cache stream :type t :identity t)
    (prin1 (pathname (disk-cache-stream disk-cache)) stream)))

(defun disk-cache-read-only-p (disk-cache)
  (eql (stream-direction (disk-cache-stream disk-cache))
       :input))
          
(defstruct (disk-page (:print-function print-disk-page) (:constructor cons-disk-page))
  disk-cache                            ; back pointer
  stream                                ; the stream (did you guess?)
  address                               ; file address of base of this page
  (flags 0)                             ; bit 0 = dirty, bit 1 = touched
  (size 0)                              ; actual size (smaller for last page)
  next                                  ; next disk-page in the chain
  prev                                  ; previous disk-page in the chain
  next-dirty                            ; next dirty page
  prev-dirty                            ; previous dirty page
  data                                  ; an (unsigned-byte 8) array
  (lock-count 0))                       ; non-zero means locked that many times.

(defconstant $disk-page-flags_dirty-bit 0)
(defconstant $disk-page-flags_touched-bit 1)

(defun disk-page-dirty (disk-page)
  (logbitp $disk-page-flags_dirty-bit
           (the fixnum (disk-page-flags disk-page))))

(defun (setf disk-page-dirty) (value disk-page)
  (with-databases-locked
   (setf (disk-page-flags disk-page)
         (if value
           (ccl::bitset $disk-page-flags_dirty-bit (disk-page-flags disk-page))
           (ccl::bitclr $disk-page-flags_dirty-bit (disk-page-flags disk-page))))
   (not (null value))))

(declaim (inline disk-page-touched? (setf disk-page-touched?)))

(defun disk-page-touched? (disk-page)
  (declare (optimize (speed 3) (safety 0)))
  (logbitp $disk-page-flags_touched-bit
           (the fixnum (disk-page-flags disk-page))))

;; Must be called inside with-databases-locked
(defun (setf disk-page-touched?) (value disk-page)
  (declare (optimize (speed 3) (safety 0)))
  (setf (disk-page-flags disk-page)
        (if value
          (ccl::bitset $disk-page-flags_touched-bit (the fixnum (disk-page-flags disk-page)))
          (ccl::bitclr $disk-page-flags_touched-bit (the fixnum (disk-page-flags disk-page)))))
  value)

(defun disk-page-locked (disk-page)
  (let ((count (disk-page-lock-count disk-page)))
    (unless (eql 0 count)
      count)))

(defun print-disk-page (disk-page stream level)
  (declare (ignore level))
  (let* ((disk-page-stream (disk-page-stream disk-page))
         (path (if disk-page-stream (pathname disk-page-stream) :no-file)))
    (print-unreadable-object (disk-page stream :type t :identity t)
      (format stream "~s~@{ ~s~}"
              (disk-page-address disk-page)
              (disk-page-size disk-page)
              (disk-page-dirty disk-page)
              path))))

(defun make-disk-page (disk-cache size)
  (cons-disk-page :disk-cache disk-cache
                  :stream (and disk-cache (disk-cache-stream disk-cache))
                  :data (make-array size :element-type '(unsigned-byte 8))))

(defvar *open-disk-caches* nil)

; New code
(defparameter *big-io-buffers*
  (not (null (find :elements-per-buffer (ccl::lfun-keyvect #'open)))))

(defun open-disk-cache (filename &key shared-p read-only-p
                                    (page-size *default-page-size* page-size-p)
                                    max-pages
                                    (swapping-space *default-swapping-space*)
                                    shared-buffer
                                    shared-buffer-pool
                                    (if-exists :overwrite)
                                    (if-does-not-exist :error)
                                    (external-format :???? ef-p)
                                    (mac-file-creator :ccl2)
                                    write-hook
                                    (initial-transaction-p t))
  (when shared-buffer-pool
    (setq shared-buffer (get-shared-buffer shared-buffer-pool page-size)))
  (if shared-buffer
    (let ((shared-buffer-page-size (shared-buffer-page-size shared-buffer)))
      (when (and page-size-p (not (eql page-size shared-buffer-page-size)))
        (error "Page size different from shared-buffer page size"))
      (setq page-size shared-buffer-page-size))
    (setq shared-buffer
          (make-shared-buffer :page-size page-size
                              :max-pages max-pages
                              :swapping-space swapping-space)))
  (setq max-pages (shared-buffer-max-pages shared-buffer))
  (let ((mask (lognot (1- (expt 2 (1- (integer-length page-size)))))))
    (if (probe-file filename)
      (if (and ef-p (neq external-format (mac-file-type filename)))
        (error "(mac-file-type ~s) was ~s, should be ~s"
               filename (mac-file-type filename) external-format))
      (setq ef-p t))
    (let* ((ef (and ef-p (list :external-format external-format)))
           (epb (and *big-io-buffers* (list :elements-per-buffer page-size)))
           (rest (nconc ef epb))
           (stream (apply #'open
                          filename
                         :direction (if read-only-p :input (if shared-p :shared :io))
                         :if-exists if-exists
                         :if-does-not-exist if-does-not-exist
                         :mac-file-creator mac-file-creator
                         rest)))
      (when stream
        (let* ((size (file-length stream))
               (disk-cache (make-disk-cache :stream stream
                                            :size size
                                            :file-eof size
                                            :page-size page-size
                                            :mask mask
                                            :shared-buffer shared-buffer
                                            ;remove :max-pages max-pages
                                            :write-hook write-hook)))
          #+wood-fixnum-addresses
          (unless (fixnump size)
            (error "File ~s is too large for this compilation of Wood~%~
                    Recompile Wood with :wood-fixnum-addresses removed from *features*"
                   filename))
          (setf (disk-cache-page-hash disk-cache)
                (make-disk-page-hash :size (min (ceiling size page-size) max-pages)
                                     :page-size page-size))
          (when initial-transaction-p
            (setf (disk-cache-transaction disk-cache) 1))
          (push disk-cache *open-disk-caches*)
          (push disk-cache (shared-buffer-users shared-buffer))
          disk-cache)))))

(defmacro with-open-disk-cache ((disk-cache filename &rest options) &body body)
  `(let ((,disk-cache (open-disk-cache ,filename ,@options)))
     (unwind-protect
       (progn ,@body)
       (close-disk-cache ,disk-cache))))

(defun make-linked-disk-pages (disk-cache page-size page-count &optional file-length)
  (when file-length
    (setq page-count (max 1 (min page-count
                                 (floor (+ file-length page-size -1)
                                        page-size)))))
  (let (page last-page)
    (dotimes (i page-count)
      (let ((new-page (make-disk-page disk-cache page-size)))
        (setf (disk-page-next new-page) page)
        (if page
          (setf (disk-page-prev page) new-page)
          (setq last-page new-page))
        (setq page new-page)))
    (setf (disk-page-next last-page) page
          (disk-page-prev page) last-page)
    (values page page-count)))

(defun add-disk-pages (disk-cache count)
  (let* ((shared-buffer (disk-cache-shared-buffer disk-cache))
         (old-first-page (shared-buffer-pages shared-buffer))
         (new-first-page (make-linked-disk-pages
                          disk-cache
                          (disk-cache-page-size disk-cache)
                          count)))
    (when old-first-page
      (let ((old-last-page (disk-page-prev old-first-page))
            (new-last-page (disk-page-prev new-first-page)))
        (setf (disk-page-next new-last-page) old-first-page
              (disk-page-prev old-first-page) new-last-page
              (disk-page-next old-last-page) new-first-page
              (disk-page-prev new-first-page) old-last-page)))
    (setf (shared-buffer-pages shared-buffer) new-first-page)
    (incf (shared-buffer-page-count shared-buffer) count)))

(defun close-disk-cache (disk-cache)
  (flush-disk-cache disk-cache)         ; work interruptably
  (with-databases-locked
   (flush-disk-cache disk-cache)        ; make sure
   (remove-disk-cache-from-shared-buffer (disk-cache-shared-buffer disk-cache) disk-cache)
   (close (disk-cache-stream disk-cache))
   (setq *open-disk-caches* (delq disk-cache *open-disk-caches* 1))
   (setf (disk-cache-page-hash disk-cache) nil)))

(defun remove-disk-cache-from-shared-buffer (shared-buffer disk-cache)
  (if (null (setf (shared-buffer-users shared-buffer)
                  (delete disk-cache (shared-buffer-users shared-buffer) :test 'eq)))
    (setf (shared-buffer-page-count shared-buffer) 0
          (shared-buffer-pages shared-buffer) nil
          (shared-buffer-locked-pages shared-buffer) nil)
    (let ((page-hash (disk-cache-page-hash disk-cache)))
      (when page-hash
        (let* ((locked-pages nil)
               (mapper #'(lambda (address page)
                           (unless (eq disk-cache (disk-page-disk-cache page))
                             (error "page in disk-page-hash doesn't belong to disk-cache"))
                           (unless (eql 0 (disk-page-lock-count page))
                             (push page locked-pages)
                             (loop
                               (unless (unlock-page page) (return))))
                           (disk-page-remhash address page-hash)
                           (setf (disk-page-disk-cache page) nil
                                 (disk-page-address page) nil))))
          (declare (dynamic-extent mapper))
          (disk-page-maphash mapper page-hash)
          (when locked-pages
            (cerror "Continue" "Locked pages: ~s" locked-pages)))))))

(defun flush-disk-cache (disk-cache)
  (unless (disk-cache-read-only-p disk-cache)
    (loop
      (with-databases-locked
        (let* ((page (disk-cache-dirty-pages disk-cache)))
          (unless page (return))
          (flush-disk-page page))))
    (with-databases-locked
      (finish-output (disk-cache-stream disk-cache)))))

(defun read-disk-page (disk-cache disk-page address)
  (flush-disk-page disk-page)
  (when (> (the fixnum (disk-page-lock-count disk-page)) 0)
    (error "Attempt to read locked page"))
  (setf (disk-page-disk-cache disk-page) disk-cache
        (disk-page-stream disk-page) (disk-cache-stream disk-cache)
        (disk-page-address disk-page) address)
  (let* ((size (disk-cache-size disk-cache))
         (file-eof (disk-cache-file-eof disk-cache))
         (page-size (min (disk-cache-page-size disk-cache) (- size address))))
    (when (> file-eof address)
      (stream-read-bytes (disk-page-stream disk-page)
                         address
                         (disk-page-data disk-page)
                         0
                         page-size))
    (setf (disk-page-size disk-page) page-size)))

(defun flush-disk-page (disk-page)
  (when (disk-page-dirty disk-page)
    (let* ((disk-cache (disk-page-disk-cache disk-page))
           (write-hook (and disk-cache (disk-cache-write-hook disk-cache))))
      (when write-hook
        (funcall write-hook disk-page))
      (when (or (not write-hook) (disk-page-dirty disk-page))   ; write-hook may have flushed this page
        (let* ((address (disk-page-address disk-page))
               (size (disk-page-size disk-page))
               (end-of-page (+ address size))
               (stream (disk-page-stream disk-page)))
          (when (> end-of-page (disk-cache-file-eof disk-cache))
            (set-minimum-file-length stream end-of-page)
            (setf (disk-cache-file-eof disk-cache) end-of-page))
          (stream-write-bytes stream
                              address
                              (disk-page-data disk-page)
                              0
                              size))
        (let* ((next (disk-page-next-dirty disk-page))
               (prev (disk-page-prev-dirty disk-page)))
          (if (eq next disk-page)
            (setf next nil)
            (setf (disk-page-next-dirty prev) next
                  (disk-page-prev-dirty next) prev))
          (setf (disk-page-next-dirty disk-page) nil
                (disk-page-prev-dirty disk-page) nil)
          (when (eq disk-page (disk-cache-dirty-pages disk-cache))
            (setf (disk-cache-dirty-pages disk-cache) next)))
        (setf (disk-page-dirty disk-page) nil)))))

; The caller must be inside of with-databases-locked, or the buffer returned
; could be yanked out from under the caller.
; 1-bit-clock page replacement algorithm.
(defun get-disk-page (disk-cache address &optional modify-p)
  (declare (optimize (speed 3)(safety 0)))
  #+wood-fixnum-addresses
  (unless (fixnump address)
    (error "Address is not a fixnum"))
  (locally #+wood-fixnum-addresses
    (declare (fixnum address))
    (let* ((hash (disk-cache-page-hash disk-cache))
           (base-address (logand address (the fixnum (disk-cache-mask disk-cache))))
           (page (disk-page-gethash base-address hash))
           (offset (- address base-address))
           (size 0))
      #+wood-fixnum-addresses (declare (fixnum base-address))
      (declare (fixnum offset size))
      (block get-the-page
        (if page
          (setq size (disk-page-size page))
          (let ((max-size (disk-cache-size disk-cache))
                (shared-buffer (disk-cache-shared-buffer disk-cache)))
            #+wood-fixnum-addresses (declare (fixnum max-size))
            (if (>= address max-size)
              (if (> address max-size)
                (error "~s > size of ~s" address disk-cache)
                (when (eql address base-address)
                  ; If the address is the beginning of a page, and the end of
                  ; the file, return a pointer off the end of the last page.
                  (setq base-address (logand (1- address) (disk-cache-mask disk-cache))
                        offset (- address base-address)
                        page (disk-page-gethash base-address hash))
                  (when page
                    (setq size (disk-page-size page))
                    (return-from get-the-page)))))
            ; Keep adding pages till we max out.
            (when (>= (shared-buffer-page-count shared-buffer)
                      (shared-buffer-max-pages shared-buffer))
              (setq page (shared-buffer-pages shared-buffer)))
            (unless page
              (add-disk-pages disk-cache 1)
              (setq page (shared-buffer-pages shared-buffer)))
            ;; Here's the page replacement algorithm, one-bit clock algorithm
            (loop
              (unless (disk-page-touched? page) (return))
              (setf (disk-page-touched? page) nil)
              (setq page (disk-page-next page)))
            (setf (shared-buffer-pages shared-buffer) (disk-page-next page))
            (let ((old-address (disk-page-address page)))
              (when old-address
                (disk-page-remhash
                 old-address (disk-cache-page-hash (disk-page-disk-cache page)))))
            (setq size (read-disk-page disk-cache page base-address))
            (setf (disk-page-gethash base-address hash) page))))
      (setf (disk-page-touched? page) t)
      (when modify-p (mark-page-modified page))
      (values (disk-page-data page)
              offset
              (- size offset)
              page))))

(defvar *error-on-non-transaction-writes* t)

; The caller must be inside of with-databases-locked
(defun mark-page-modified (disk-page)
  (declare (optimize (speed 3) (safety 0)))
  (unless (disk-page-dirty disk-page)
    ; Link this disk-page as the last one in the dirty cache.
    (let* ((disk-cache (disk-page-disk-cache disk-page))
           (dirty-pages (disk-cache-dirty-pages disk-cache)))
      (when (disk-cache-read-only-p disk-cache)
        (error "Modifying a read-only database"))
      (when (and *error-on-non-transaction-writes*
                 (null (disk-cache-transaction disk-cache)))
        (restart-case
          (cerror "Let this write proceed"
                  "Write outside of transaction to ~s"
                  (or (disk-cache-pheap disk-cache) disk-cache))
          (dont-repeat ()
                       :report (lambda (s)
                                 (format s "Let this write proceed and don't warn in the future."))
                       (setq *error-on-non-transaction-writes* nil))))
      (if dirty-pages
        (let ((prev-dirty (disk-page-prev-dirty dirty-pages)))
          (setf (disk-page-next-dirty prev-dirty) disk-page
                (disk-page-prev-dirty disk-page) prev-dirty
                (disk-page-next-dirty disk-page) dirty-pages
                (disk-page-prev-dirty dirty-pages) disk-page))
        (setf (disk-page-next-dirty disk-page) disk-page
              (disk-page-prev-dirty disk-page) disk-page
              (disk-cache-dirty-pages disk-cache) disk-page)))
    (setf (disk-page-dirty disk-page) t)))

; Return the lock count after locking.
(defun lock-page (disk-page)
  (let ((lock-count (disk-page-lock-count disk-page)))
    (declare (fixnum lock-count))
    (when (eql 0 lock-count)
      (let* ((disk-cache (disk-page-disk-cache disk-page))
             (shared-buffer (disk-cache-shared-buffer disk-cache))
             (prev (disk-page-prev disk-page))
             (next (disk-page-next disk-page))
             (locked (shared-buffer-locked-pages shared-buffer))
             (prev-locked (if locked (disk-page-prev locked) disk-page)))
        (when (null locked)
          (setf (shared-buffer-locked-pages shared-buffer) (setq locked disk-page)))
        (setf (disk-page-next prev) next
              (disk-page-prev next) prev
              (disk-page-next prev-locked) disk-page
              (disk-page-prev disk-page) prev-locked
              (disk-page-prev locked) disk-page
              (disk-page-next disk-page) locked)
        (when (eq disk-page (shared-buffer-pages shared-buffer))
          (setf (shared-buffer-pages shared-buffer)
                (if (eq next disk-page) nil next)))))
    (setf (disk-page-lock-count disk-page)
          (the fixnum (1+ lock-count)))))

; Return the lock count or NIL if the page unlocked when this returns.
(defun unlock-page (disk-page)
  (let ((count (disk-page-lock-count disk-page)))
    (declare (fixnum count))
    (when (not (eql 0 count))
      (progn
        (when (eql count 1)
          (let* ((disk-cache (disk-page-disk-cache disk-page))
                 (shared-buffer (disk-cache-shared-buffer disk-cache))
                 (prev-locked (disk-page-prev disk-page))
                 (next-locked (disk-page-next disk-page))
                 (pages (shared-buffer-pages shared-buffer))
                 (prev (if pages (disk-page-prev pages) disk-page)))
            (when (null pages)
              (setf (shared-buffer-pages shared-buffer) (setq pages disk-page)))
            (setf (disk-page-next prev-locked) next-locked
                  (disk-page-prev next-locked) prev-locked
                  (disk-page-next prev) disk-page
                  (disk-page-prev disk-page) prev
                  (disk-page-prev pages) disk-page
                  (disk-page-next disk-page) pages)
            (when (eq disk-page (shared-buffer-locked-pages shared-buffer))
              (setf (shared-buffer-locked-pages shared-buffer)
                    (if (eq next-locked disk-page) nil next-locked)))))
        (setf (disk-page-lock-count disk-page) (decf count))
        (and (not (eql 0 count)) count)))))


;;; Must be called inside with-databases-locked
(defmacro with-locked-page ((disk-page-or-disk-cache 
                             &optional address modify-p array offset length page)
                            &body body &environment env)
  (if address
    (let (ignored-params)
      (multiple-value-bind (body-tail decls) (ccl::parse-body body env nil)
        (flet ((normalize (param &optional (ignoreable? t))
                 (or param
                     (let ((res (gensym)))
                       (if ignoreable? (push res ignored-params))
                       res))))
          `(multiple-value-bind (,(normalize array) ,(normalize offset)
                                 ,(normalize length) ,(setq page (normalize page nil)))
                                (get-disk-page ,disk-page-or-disk-cache ,address
                                               ,@(if modify-p `(,modify-p)))
             ,@(when ignored-params
                `((declare (ignore ,@ignored-params))))
             ,@decls
             (with-locked-page (,page)
               ,@body-tail)))))
    (let ((page-var (gensym)))
      `(let ((,page-var ,disk-page-or-disk-cache))
         (unwind-protect
           (progn
             (lock-page ,page-var)
             ,@body)
           (unlock-page ,page-var))))))

(defun lock-page-at-address (disk-cache address)
  (with-databases-locked
   (let ((page (nth-value 3 (get-disk-page disk-cache address))))
     (values (lock-page page) page))))

(defun unlock-page-at-address (disk-cache address)
  (with-databases-locked
   (let ((page (nth-value 3 (get-disk-page disk-cache address))))
     (unlock-page page))))

(defun extend-disk-cache (disk-cache new-size &optional extend-file?)
  #+wood-fixnum-addresses
  (unless (fixnump new-size)
    (error "New size is not a fixnum"))
  (with-databases-locked
   (let ((size (disk-cache-size disk-cache)))
     (when (> new-size size)
       ; Update size of last page
       (when (> size 0)
         (let* ((page-address (logand (1- size) (disk-cache-mask disk-cache)))
              (page (disk-page-gethash page-address (disk-cache-page-hash disk-cache))))
         (when page
           (setf (disk-page-size page)
                 (min (length (disk-page-data page)) (- new-size page-address))))))
       ; increase the file size & install the new size
       (when extend-file?
         (file-length (disk-cache-stream disk-cache) new-size))
       (setf (disk-cache-size disk-cache) new-size)))))

(defun flush-all-disk-caches ()
  (dolist (dc *open-disk-caches*)
    (if (eq :closed (stream-direction (disk-cache-stream dc)))
      (setq *open-disk-caches* (delq dc *open-disk-caches*))
      (flush-disk-cache dc))))

(pushnew 'flush-all-disk-caches *lisp-cleanup-functions*)

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Transaction support
;;;

; Not used yet, maybe it's unnecessary.
(defmacro with-disk-cache-transaction ((disk-cache) &body body)
  (let ((thunk (gensym)))
    `(let ((,thunk #'(lambda () ,@body)))
       (declare (dynamic-extent ,thunk))
       (funcall-with-disk-cache-transaction ,disk-cache ,thunk))))

(defun funcall-with-disk-cache-transaction (disk-cache thunk)
  (let ((transaction (start-disk-cache-transaction disk-cache))
        (done nil))
    (unwind-protect
      (multiple-value-prog1
        (funcall thunk)
        (setq done t))
      (if done
        (commit-disk-cache-transaction transaction)
        (abort-disk-cache-transaction transaction)))))

; These are dummies for now. Just keep a counter of how many there are.
(defun start-disk-cache-transaction (disk-cache)
  (with-databases-locked
    (setf (disk-cache-transaction disk-cache)
          (+ 1 (or (disk-cache-transaction disk-cache) 0)))
    disk-cache))

(defun commit-disk-cache-transaction (transaction &optional (flush t))
  (let ((disk-cache transaction))
    (with-databases-locked
      (let ((count (1- (disk-cache-transaction disk-cache))))
        (setf (disk-cache-transaction disk-cache)
              (if (eql count 0) nil count))))
    (when flush
      (with-databases-locked
        (flush-disk-cache disk-cache)))))

(defun abort-disk-cache-transaction (transaction &optional (flush t))
  (commit-disk-cache-transaction transaction flush))


#|
(setq dc (open-disk-cache "temp.lisp"))

; read a string from dc
(defun rc (address size)
  (declare (optimize (debug 3)))
  (declare (special dc))
  (let ((file-size (disk-cache-size dc)))
    (setq size (max 0 (min size (- file-size address)))))
  (let ((string (make-string size))
        (index 0))
    (loop
      (when (<= size 0) (return string))
      (multiple-value-bind (array array-index bytes) (get-disk-page dc address)
        (dotimes (i (min size bytes))
          (setf (schar string index) (code-char (aref array array-index)))
          (incf index)
          (incf array-index))
        (decf size bytes)
        (incf address bytes)))))

; write a string to dc
(defun wc (string address)
  (declare (special dc))
  (let* ((length (length string))
         (min-size (+ address length))
         (index 0))
    (when (> min-size (disk-cache-size dc))
      (extend-disk-cache dc min-size))
    (loop
      (when (<= length 0) (return))
      (multiple-value-bind (array array-index bytes) (get-disk-page dc address t)
        (dotimes (i (min length bytes))
          (declare (type (array (unsigned-byte 8)) array))
          (setf (aref array array-index) (char-code (schar string index)))
          (incf index)
          (incf array-index))
        (incf address bytes)
        (decf length bytes)))))

(close-disk-cache dc)

|#
;;;    1   3/10/94  bill         1.8d247
;;;    2   7/26/94  Derek        1.9d027
;;;    3  10/04/94  bill         1.9d071
;;;    4  11/03/94  Moon         1.9d086
;;;    5  11/05/94  kab          1.9d087
;;;    2   2/18/95  RŽti         1.10d019
;;;    3   3/23/95  bill         1.11d010
;;;    4   6/02/95  bill         1.11d040
;;;    5   8/01/95  bill         1.11d065
;;;    6   8/18/95  bill         1.11d071
;;;    7   8/25/95  Derek        Derek and Neil's massive bug fix upload
