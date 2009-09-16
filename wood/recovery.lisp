;;;-*- Mode: Lisp; Package: WOOD -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; recovery.lisp
;; Support logging/recovery for WOOD.
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
;; To do:
;;
;; Remember most recently consed object so that undo
;; bytes are unnecessary for subsequent stores into that object.

(in-package :wood)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; -------------- 0.96
;; -------------- 0.95
;; -------------- 0.94
;; 03/21/96 bill  (make-string ... :element-type 'base-character)
;; -------------- 0.93
;; -------------- 0.9
;; -------------- 0.8
;; -------------- 0.6
;; -------------- 0.5
;; 05/27/92 bill  New file
;;

#|
Format of a log file:
=========
<Entry 0>      ; first log entry
...
<Entry n>      ; last log entry
=========

Format of a log entry:
=========
<Type>         ; one byte. The type of entry
<Data>         ; entry type specific
=========


Format of data types written in log:

<byte>         ; 8 bits of data
<word>         ; 2 <byte>s
<long>         ; 4 <byte>s
<length>       ; 1 or more bytes. Each contains 7 bits of data.
               ; If the MSB of a byte is set, there are more bytes
<string>       ; <length><data> - <data> is <length> bytes


Entry descriptions:

Header. The first entry in a log file:
=========
$log-header-type                 ; <byte>
$log-version                     ; <byte>
<EOF>                            ; <long> - End of file address
<checkpoint>                     ; LSN of last checkpoint record
<log for>                        ; <string> - Name of file that this
                                 ; one is logging. Assumed to be in
                                 ; the same directory as the log file.
=========

Begin transaction:
=========
$begin-transaction-type          ; <byte>
<parent LSN>                     ; <long> - LSN of parent transaction or 0
=========

Continue transaction.
A Continue transaction record is written when a different
transaction needs to write log records.
=========
$continue-transaction-type       ; <byte>
<LSN>                            ; <long>
=========

Abort transaction:
=========
$abort-transaction-type          ; <byte>
<LSN>                            ; <long>
=========

Commit transaction:
=========
$commit-transaction-type         ; <byte>
<LSN>                            ; <long>
=========

Checkpoint:
=========
$checkpoint-type                 ; <byte>
<open transaction count>         ; <length>
<lsn 0>                          ; <long>
...
<lsn n>                          ; <long>
=========

There are 2 basic kinds of data entries: with and without undo.
Eventually, we may want to work at encoding the address as a
byte or word, offset from the past address written to the log.
This poses problems for undo, however, as undo parses the log
backwards.

Write data without undo:
=========
<type>                           ; <byte>
<address>                        ; <long>
<size>                           ; <length> (optional) size of data
<data>
=========

Write data with undo:
=========
<type>                           ; <byte>
<undo-link>                      ; <length> - negative offset to last undo
<address>                        ; <long>
<size>                           ; <length> (optional) size of data
<old data>
<new data>
=========

Write byte:
=========
$write-byte                      ; <byte>
<address>                        ; <long>
<data>                           ; <byte>
=========

Write byte with undo:
=========
$write-byte-with-undo            ; <byte>
<undo-link)                      ; <length>
<address>                        ; <long>
<old data>                       ; <byte>
<new data>                       ; <byte>
=========

Write word:
=========
$write-word                      ; <byte>
<address>                        ; <long>
<data>                           ; <word>
=========

Write word with undo:
=========
$write-word-with-undo            ; <byte>
<undo-link)                      ; <length>
<address>                        ; <long>
<old data>                       ; <word>
<new data>                       ; <word>
=========

Write long:
=========
$write-long                      ; <byte>
<address>                        ; <long>
<data>                           ; <long>
=========

Write long with undo:
=========
$write-long-with-undo            ; <byte>
<undo-link)                      ; <length>
<address>                        ; <long>
<old data>                       ; <long>
<new data>                       ; <long>
=========

Write bytes:
=========
$write-bytes                     ; <byte>
<address>                        ; <long>
<size>                           ; <length>
<data>                           ; <size> <byte>s
=========

write bytes with undo:
=========
$write-bytes-with-undo           ; <byte>
<undo-link>                      ; <length>
<address>                        ; <long>
<size>                           ; <length>
<old data>                       ; <size> <byte>s
<new data>                       ; <size> <byte>s
=========

Fill bytes:
=========
$fill-byte                       ; <byte>
<address>                        ; <long>
<count>                          ; <length>
<data>                           ; <byte>
=========

Fill bytes with undo:
=========
$fill-byte-with-undo             ; <byte>
<undo-link>                      ; <length>
<address>                        ; <long>
<count>                          ; <length>
<old data>                       ; <count> <byte>s
<new data>                       ; <byte>
=========

Fill word:
=========
$fill-word                       ; <byte>
<address>                        ; <long>
<count>                          ; <length>
<data>                           ; <word>
=========

Fill word with undo:
=========
$fill-word-with-undo             ; <byte>
<undo-link>                      ; <length>
<address>                        ; <long>
<count>                          ; <length>
<old data>                       ; <count> <word>s
<new data>                       ; <word>
=========

Fill long:
=========
$fill-long                       ; <byte>
<address>                        ; <long>
<count>                          ; <length>
<data>                           ; <long>
=========

Fill long with undo:
=========
$fill-long-with-undo             ; <byte>
<undo-link>                      ; <length>
<address>                        ; <long>
<count>                          ; <length>
<old data>                       ; <count> <long>s
<new data>                       ; <long>
=========

|#

(defconstant $log-header-type #xfe)
(defconstant $log-version 1)
(defconstant $log-min-version 1)        ; the minimum version we can handle
(defconstant $log-eof-address 2)
(defconstant $log-checkpoint-address 6)

(defconstant $begin-transaction-type    1)
(defconstant $continue-transaction-type 2)
(defconstant $abort-transaction-type    3)
(defconstant $commit-transaction-type   4)
(defconstant $write-byte                5)
(defconstant $write-byte-with-undo      6)
(defconstant $write-word                7)
(defconstant $write-word-with-undo      8)
(defconstant $write-long                9)
(defconstant $write-long-with-undo     10)
(defconstant $write-bytes              11)
(defconstant $write-bytes-with-undo    12)
(defconstant $fill-byte                13)
(defconstant $fill-byte-with-undo      14)
(defconstant $fill-word                15)
(defconstant $fill-word-with-undo      16)
(defconstant $fill-long                17)
(defconstant $fill-long-with-undo      18)
(defconstant $checkpoint-type          19)

; tables at bottom of file
(declaim (special *log-type->name* *log-undo-functions*))

(defun log-type->name (log-type)
  (svref *log-type->name* log-type))

; A dc-log is used for logging writes to a disk-cache.
; It keeps the current output page locked so that entries
; can be made quickly.
(defstruct (dc-log (:print-function print-dc-log))
  log-for                               ; the disk-cache I'm logging
  disk-cache                            ; the disk-cache for the log file
  page                                  ; the disk-page for page-buffer
  buffer                                ; one block of log bytes
  (ptr 0)                               ; index into page-buffer
  (bytes-left 0)                        ; number of bytes after ptr
  modified                              ; true if we've written in the page
  page-0                                ; first page - for EOF & last checkpoint
  buffer-0                              ; and it's buffer
  (eof 0)                               ; End of file if PTR not at EOF
  active-transactions                   ; list of LSN's
  )

(defun print-dc-log (dc-log stream level)
  (declare (ignore level))
  (let* ((log-for (dc-log-log-for dc-log))
         (log-for-stream (and log-for (disk-cache-stream log-for)))
         (log-for-path (and log-for-stream (pathname log-for-stream)))
         (dc (dc-log-disk-cache dc-log))
         (dc-stream (and dc (disk-cache-stream dc)))
         (dc-path (and dc-stream (pathname dc-stream))))
    (print-unreadable-object (dc-log stream :type t :identity t)
      (let ((pos (log-position dc-log)))
        (prin1 pos stream)
        (write-char #\/ stream)
        (prin1 (max pos (dc-log-eof dc-log)) stream))
      (when (or log-for-path dc-path)
        (write-char #\space stream)
        (prin1 dc-path stream)
        (write-char #\space stream)
        (prin1 log-for-path stream)))))

; Open a disk-cache log
; filename is a string or pathname
; log-for is a disk-cache
(defun open-dc-log (filename log-for &key 
                             (if-exists :overwrite)
                             (if-does-not-exist :create))
  (let ((check-header? (and (probe-file filename) (eq if-exists :overwrite)))
        (disk-cache (open-disk-cache filename
                                     :if-exists if-exists
                                     :if-does-not-exist if-does-not-exist))
        (log-for-name (file-namestring (disk-cache-stream log-for)))
        dc-log)
    (when disk-cache
      (setq dc-log (make-dc-log :log-for log-for
                                :disk-cache disk-cache))
      (if check-header?
        (progn
          (log-position dc-log 0)
          (let ((page (dc-log-page dc-log)))
            (lock-page page)            ; extra lock to keep page-0 swapped in
            (setf (dc-log-page-0 dc-log) page
                  (dc-log-buffer-0 dc-log) (dc-log-buffer dc-log)))
          (unless (eql $log-header-type (log-read-byte dc-log))
            (error "Bad log header in ~s" dc-log))
          (unless (<= $log-min-version (log-read-byte dc-log) $log-version)
            (error "Bad log version in ~s" dc-log))
          (let* ((eof (log-read-long dc-log))
                 (checkpoint (log-read-long dc-log))
                 (dc-log-for-name (log-read-string dc-log)))
            (declare (ignore checkpoint))            (setf (dc-log-eof dc-log) eof)
            (unless (equalp log-for-name dc-log-for-name)
              (cerror "Ignore this problem."
                      "~s is a log for ~s, not ~s"
                      dc-log dc-log-for-name log-for-name))
            (log-position dc-log eof)))
        (progn
          (unless (eql 0 (disk-cache-size disk-cache))
            (error "~s is not empty." disk-cache))
          (log-extend dc-log)
          (log-position dc-log 0)
          (let ((page (dc-log-page dc-log)))
            (lock-page page)            ; extra lock to keep page-0 swapped in
            (setf (dc-log-page-0 dc-log) page
                  (dc-log-buffer-0 dc-log) (dc-log-buffer dc-log)))
          (log-write-byte dc-log $log-header-type)
          (log-write-byte dc-log $log-version)
          (log-write-long dc-log 0)     ; eof
          (log-write-long dc-log 0)     ; checkpoint
          (log-write-string dc-log log-for-name t)
          (setf (dc-log-eof dc-log) (log-position dc-log))))
      dc-log)))

(defun close-dc-log (dc-log &optional ignore-active-transactions)
  (let ((disk-cache (dc-log-disk-cache dc-log)))
    (when disk-cache
      (force-log dc-log)
      (unless (or ignore-active-transactions
                  (null (dc-log-active-transactions dc-log)))
        (cerror "Close the log anyway."
                "Attempt to close ~s with active transactions."
                dc-log))
      (close-disk-cache (dc-log-disk-cache dc-log))
      (setf (dc-log-disk-cache dc-log) nil
            (dc-log-page dc-log) nil
            (dc-log-buffer dc-log) nil
            (dc-log-page-0 dc-log) nil
            (dc-log-buffer-0 dc-log) nil)
      t)))

; Make a dc-log one block longer.
; Position the pointer at the beginning of the new block.
; return the position of the pointer.
(defun log-extend (dc-log) 
  (let* ((disk-cache (dc-log-disk-cache dc-log))
         (page-size (disk-cache-page-size disk-cache))
         (size (disk-cache-size disk-cache))
         (old-page (dc-log-page dc-log)))
    (unless (eql 0 (mod size page-size))
      (error "Inconsistency: Log is not an even number of pages long"))
    (extend-disk-cache disk-cache (+ size page-size))
    (multiple-value-bind (buffer offset bytes-left page)
                         (get-disk-page disk-cache size t)
      (unless (and (eql offset 0) (eql bytes-left page-size))
        (error "Inconsistent page offset stuff."))
      (array-fill-byte buffer 0 0 bytes-left)
      (lock-page page)
      (when old-page
        (when (dc-log-modified dc-log)
          (mark-page-modified old-page)
          (setf (dc-log-modified dc-log) nil))
        (unlock-page old-page))
      (setf (dc-log-page dc-log) page
            (dc-log-buffer dc-log) buffer
            (dc-log-ptr dc-log) 0
            (dc-log-bytes-left dc-log) bytes-left))
    size))

(defun log-next-page (dc-log &optional extend-p)
  (let* ((page (dc-log-page dc-log))
         (disk-cache (disk-page-disk-cache page))
         (page-size (disk-cache-page-size disk-cache))
         (address (+ (disk-page-address page) page-size)))
    (declare (fixnum page-size))
    (when (dc-log-modified dc-log)
      (mark-page-modified page)
      (setf (dc-log-modified dc-log) nil))
    (multiple-value-bind (buf offset size new-page)
                         (get-disk-page disk-cache address)
      (declare (fixnum offset size))
      (unless (or (eql offset 0) (eql offset page-size))
        (error "Non-aligned log page in ~s" dc-log))
      (unless (> size 0)
        (if extend-p
          (return-from log-next-page
            (log-extend dc-log)))
        (error "Attempt to read past eof of ~s" dc-log))
      (lock-page new-page)
      (setf (dc-log-page dc-log) new-page
            (dc-log-buffer dc-log) buf
            (dc-log-ptr dc-log) 0
            (dc-log-bytes-left dc-log) size)
      (unlock-page page))
    address))

(defun log-read-byte (dc-log)
  (unless (dc-log-p dc-log)
    (setq dc-log (require-type dc-log 'dc-log)))
  (locally (declare (optimize (speed 3) (safety 0)))
    (let ((bytes-left (dc-log-bytes-left dc-log)))
      (declare (fixnum bytes-left))
      (when (<= bytes-left 0)
        (log-next-page dc-log)
        (setq bytes-left (dc-log-bytes-left dc-log)))
      (let ((buf (dc-log-buffer dc-log))
            (ptr (dc-log-ptr dc-log)))
        (declare (fixnum ptr)
                 (type (simple-array (unsigned-byte 8) (*)) buf))
        (prog1
          (aref buf ptr)
          (setf (dc-log-ptr dc-log) (the fixnum (1+ ptr))
                (dc-log-bytes-left dc-log) (the fixnum (1- bytes-left))))))))

(defun log-read-word (dc-log)
  (unless (dc-log-p dc-log)
    (setq dc-log (require-type dc-log 'dc-log)))
  (locally (declare (optimize (speed 3) (safety 0)))
    (let ((bytes-left (dc-log-bytes-left dc-log)))
      (declare (fixnum bytes-left))
      (if (>= bytes-left 2)
        (let ((buf (dc-log-buffer dc-log))
              (ptr (dc-log-ptr dc-log)))
          (declare (fixnum ptr)
                   (type (simple-array (unsigned-byte 8) (*)) buf))
          (prog1
            (the fixnum
              (+ (the fixnum (ash (the fixnum (aref buf ptr)) 8))
                 (the fixnum (aref buf (incf ptr)))))
            (setf (dc-log-ptr dc-log) (the fixnum (1+ ptr))
                  (dc-log-bytes-left dc-log) (the fixnum (- bytes-left 2)))))
        (the fixnum
          (+ (the fixnum (ash (the fixnum (log-read-byte dc-log)) 8))
             (the fixnum (log-read-byte dc-log))))))))

(defun log-read-long (dc-log)
  (unless (dc-log-p dc-log)
    (setq dc-log (require-type dc-log 'dc-log)))
  (locally (declare (optimize (speed 3) (safety 0)))
    (let ((bytes-left (dc-log-bytes-left dc-log)))
      (declare (fixnum bytes-left))
      (macrolet ((add-em (b3 b2 b1 b0)
                   `(let ((-b3- ,b3)
                          (-low-3- (the fixnum
                                     (+ (the fixnum (ash (the fixnum ,b2) 16))
                                        (the fixnum (ash (the fixnum ,b1) 8))
                                        (the fixnum ,b0)))))
                      (if (eql 0 -b3-)
                        -low-3-
                        (+ (ash -b3- 24) -low-3-)))))
        (if (>= bytes-left 4)
          (let ((buf (dc-log-buffer dc-log))
                (ptr (dc-log-ptr dc-log)))
            (declare (fixnum ptr)
                     (type (simple-array (unsigned-byte 8) (*)) buf))
            (prog1
              (add-em (aref buf ptr)
                      (aref buf (incf ptr))
                      (aref buf (incf ptr))
                      (aref buf (incf ptr)))
              (setf (dc-log-ptr dc-log) (the fixnum (1+ ptr))
                    (dc-log-bytes-left dc-log) (the fixnum (- bytes-left 4)))))
          (add-em (log-read-byte dc-log)
                  (log-read-byte dc-log)
                  (log-read-byte dc-log)
                  (log-read-byte dc-log)))))))

(defvar *log-pointer-buf*
  (make-array 4 :element-type '(unsigned-byte 8)))

(defun log-read-pointer (dc-log)
  (unless (dc-log-p dc-log)
    (setq dc-log (require-type dc-log 'dc-log)))
  (locally (declare (optimize (speed 3) (safety 0)))
    (let ((pointer-buf (or *log-pointer-buf* 
                           (make-array 4 :element-type '(unsigned-byte 8)))))
      (declare (type (simple-array (unsigned-byte 8) (*)) pointer-buf))
      (setq *log-pointer-buf* nil)
      (let ((bytes-left (dc-log-bytes-left dc-log)))
        (declare (fixnum bytes-left))
        (if (>= bytes-left 4)
          (let ((buf (dc-log-buffer dc-log))
                (ptr (dc-log-ptr dc-log)))
            (declare (fixnum ptr)
                     (type (simple-array (unsigned-byte 8) (*)) buf))
            (setf (aref pointer-buf 0) (aref buf ptr)
                  (aref pointer-buf 1) (aref buf (incf ptr))
                  (aref pointer-buf 2) (aref buf (incf ptr))
                  (aref pointer-buf 3) (aref buf (incf ptr))
                  (dc-log-ptr dc-log) (the fixnum (1+ ptr))
                  (dc-log-bytes-left dc-log) (the fixnum (- bytes-left 4))))
          (setf (aref pointer-buf 0) (log-read-byte dc-log)
                (aref pointer-buf 1) (log-read-byte dc-log)
                (aref pointer-buf 2) (log-read-byte dc-log)
                (aref pointer-buf 3) (log-read-byte dc-log))))
      (multiple-value-bind (res imm?) (%%load-pointer pointer-buf 0)
        (setq *log-pointer-buf* pointer-buf)
        (values res imm?)))))

(defun log-write-byte (dc-log byte)
  (unless (fixnump byte)
    (setq byte (require-type byte 'fixnum)))
  (unless (dc-log-p dc-log)
    (setq dc-log (require-type dc-log 'dc-log)))
  (locally (declare (optimize (speed 3) (safety 0))
                    (fixnum byte))
    (let ((bytes-left (dc-log-bytes-left dc-log)))
      (declare (fixnum bytes-left))
      (when (<= bytes-left 0)
        (log-next-page dc-log t)
        (setq bytes-left (dc-log-bytes-left dc-log)))
      (let ((buf (dc-log-buffer dc-log))
            (ptr (dc-log-ptr dc-log)))
        (declare (fixnum ptr)
                 (type (simple-array (unsigned-byte 8) (*)) buf))
        (setf (aref buf ptr) byte
              (dc-log-ptr dc-log) (the fixnum (1+ ptr))
              (dc-log-bytes-left dc-log) (the fixnum (1- bytes-left))
              (dc-log-modified dc-log) t)
        byte))))

(defun log-write-word (dc-log word)
  (unless (fixnump word)
    (setq word (require-type word 'fixnum)))
  (unless (dc-log-p dc-log)
    (setq dc-log (require-type dc-log 'dc-log)))
  (locally (declare (optimize (speed 3) (safety 0))
                    (fixnum word))
    (let ((bytes-left (dc-log-bytes-left dc-log)))
      (declare (fixnum bytes-left))
      (if (>= bytes-left 2)
        (let ((buf (dc-log-buffer dc-log))
              (ptr (dc-log-ptr dc-log)))
          (declare (fixnum ptr)
                   (type (simple-array (unsigned-byte 8) (*)) buf))
          (setf (aref buf ptr) (ash word -8)
                (aref buf (the fixnum (1+ ptr))) (logand word #xff)
                (dc-log-ptr dc-log) (the fixnum (+ ptr 2))
                (dc-log-bytes-left dc-log) (the fixnum (- bytes-left 2))
                (dc-log-modified dc-log) t))
        (progn
          (log-write-byte dc-log (ash word -8))
          (log-write-byte dc-log (logand word #xff))))
      word)))

(defun log-write-long (dc-log long)
  (setq long (require-type long 'integer))
  (unless (dc-log-p dc-log)
    (setq dc-log (require-type dc-log 'dc-log)))
  (locally (declare (optimize (speed 3) (safety 0)))
    (let ((bytes-left (dc-log-bytes-left dc-log))
          (low3 (if (fixnump long)
                  (the fixnum (logand (the fixnum long) #xffffff))
                  (logand long #xffffff))))
      (declare (fixnum bytes-left low3))
      (if (>= bytes-left 4)
        (let ((buf (dc-log-buffer dc-log))
              (ptr (dc-log-ptr dc-log)))
          (declare (fixnum ptr)
                   (type (simple-array (unsigned-byte 8) (*)) buf))
          (setf (aref buf ptr) (if (eql low3 long) 0 (ash long -24))
                (aref buf (incf ptr)) (ash low3 -16)
                (aref buf (incf ptr)) (logand (ash low3 -8) #xff)
                (aref buf (incf ptr)) (logand low3 #xff)
                (dc-log-ptr dc-log) (the fixnum (1+ ptr))
                (dc-log-bytes-left dc-log) (the fixnum (- bytes-left 4))
                (dc-log-modified dc-log) t))
        (progn
          (log-write-byte dc-log (if (eql low3 long) 0 (ash long -24)))
          (log-write-byte dc-log (ash low3 -16))
          (log-write-byte dc-log (logand (ash low3 -8) #xff))
          (log-write-byte dc-log (logand low3 #xff))))
      long)))

(defun log-write-pointer (dc-log pointer &optional imm?)
  (unless (dc-log-p dc-log)
    (setq dc-log (require-type dc-log 'dc-log)))
  (locally (declare (optimize (speed 3) (safety 0)))
    (let ((pointer-buf (or *log-pointer-buf* 
                           (make-array 4 :element-type '(unsigned-byte 8)))))
      (declare (type (simple-array (unsigned-byte 8) (*)) pointer-buf))
      (setq *log-pointer-buf* nil)
      (%%store-pointer pointer pointer-buf 0 imm?)
      (let ((bytes-left (dc-log-bytes-left dc-log)))
        (declare (fixnum bytes-left))
        (if (>= bytes-left 4)
          (let ((buf (dc-log-buffer dc-log))
                (ptr (dc-log-ptr dc-log)))
            (declare (fixnum ptr)
                     (type (simple-array (unsigned-byte 8) (*)) buf))
            (setf (aref buf ptr) (aref pointer-buf 0)
                  (aref buf (incf ptr)) (aref pointer-buf 1)
                  (aref buf (incf ptr)) (aref pointer-buf 2)
                  (aref buf (incf ptr)) (aref pointer-buf 3)
                  (dc-log-ptr dc-log) (the fixnum (1+ ptr))
                  (dc-log-bytes-left dc-log) (the fixnum (- bytes-left 4))
                  (dc-log-modified dc-log) t))
          (progn
            (log-write-byte dc-log (aref pointer-buf 0))
            (log-write-byte dc-log (aref pointer-buf 1))
            (log-write-byte dc-log (aref pointer-buf 2))
            (log-write-byte dc-log (aref pointer-buf 3)))))
      (values pointer imm?))))

(defun log-read-length (dc-log)
  (let ((res 0)
        (byte 0))
    (declare (fixnum res byte))
    (loop
      (setq byte (log-read-byte dc-log))
      (if (logbitp 7 byte)
        (setq res (+ (the fixnum (ash res 8)) (logand #x7f byte)))
        (return (the fixnum (+ (the fixnum (ash res 8)) byte)))))))

(defun log-write-length (dc-log length)
  (unless (fixnump length)
    (setq length (require-type length 'fixnum)))
  (labels ((foo (dc-log length hibit)
             (declare (fixnum length hibit)
                      (optimize (speed 3) (safety 0)))
             (if (>= length 128)
               (progn
                 (foo dc-log (ash length -7) 128)
                 (log-write-byte dc-log (logior hibit (logand length #x7f))))
               (log-write-byte dc-log (logior hibit length)))))
    (foo dc-log length 0)))

; Will read a length from the log if the END arg is omitted.
; If STRING is specified, it can be any 1-d array capable of holding
; bytes (same limitations as %copy-byte-array-portion)
; If STRING is not specified, will cons up a string.
(defun log-read-string (dc-log &optional string (start 0) length)
  (unless (fixnump start)
    (setq start (require-type start 'fixnum)))
  (if length
    (setq length (require-type length 'fixnum)))
  (unless (dc-log-p dc-log)
    (setq dc-log (require-type dc-log 'dc-log)))
  (locally (declare (fixnum start)
                    (optimize (speed 3) (safety 0)))
    (let ((length (or length (log-read-length dc-log)))
          (buf (dc-log-buffer dc-log))
          (ptr (dc-log-ptr dc-log))
          (bytes-left (dc-log-bytes-left dc-log)))
      (declare (fixnum length ptr bytes-left))
      (unless string (setq string (make-string length :element-type 'base-character)))
      (unless (<= length 0)
        (if (<= bytes-left 0)
          (log-next-page dc-log))
        (loop
          (let ((bytes-to-move (if (< bytes-left length) bytes-left length)))
            (declare (fixnum bytes-to-move))
            (%copy-byte-array-portion buf ptr bytes-to-move string start)
            (when (<= (decf length bytes-to-move) 0)
              (setf (dc-log-ptr dc-log) (the fixnum (+ ptr bytes-to-move))
                    (dc-log-bytes-left dc-log) (the fixnum (- bytes-left bytes-to-move)))
              (return))
            (incf start bytes-to-move)
            (log-next-page dc-log)
            (setq buf (dc-log-buffer dc-log)
                  ptr (dc-log-ptr dc-log)
                  bytes-left (dc-log-bytes-left dc-log)))))
      string)))

; Again, STRING is as for %copy-byte-array-portion
(defun log-write-string (dc-log string write-length? &optional
                                (start 0) length)
  (let ((string-length (length string)))
    (declare (fixnum string-length))
    (setq start (require-type start 'fixnum))
    (unless (<= 0 start string-length)
      (error "~s not inside string" 'start))
    (locally (declare (fixnum start))
      (if length
        (progn
          (setq length (require-type length 'fixnum))
          (locally (declare (fixnum length))
            (unless (<= start (+ start length) string-length)
              (error "(+ ~s ~s) not inside string" 'start 'length))))
        (setq length (- string-length start)))))
  (unless (dc-log-p dc-log)
    (setq dc-log (require-type dc-log 'dc-log)))
  (locally (declare (fixnum start length)
                    (optimize (speed 3) (safety 0)))
    (when write-length?
      (log-write-length dc-log length))
    (when (> length 0)
      (let ((buf (dc-log-buffer dc-log))
            (ptr (dc-log-ptr dc-log))
            (bytes-left (dc-log-bytes-left dc-log)))
        (declare (fixnum ptr bytes-left))
        (loop
          (let ((bytes-to-write (if (< bytes-left length) bytes-left length)))
            (declare (fixnum bytes-to-write))
            (%copy-byte-array-portion string start bytes-to-write buf ptr)
            (when (<= (decf length bytes-to-write) 0)
              (setf (dc-log-ptr dc-log) (the fixnum (+ ptr bytes-to-write))
                    (dc-log-bytes-left dc-log) (the fixnum (- bytes-left bytes-to-write)))
              (return))
            (incf start bytes-to-write)
            (setf (dc-log-modified dc-log) t)
            (log-next-page dc-log t)
            (setq buf (dc-log-buffer dc-log)
                  ptr (dc-log-ptr dc-log)
                  bytes-left (dc-log-bytes-left dc-log)))))))
  string)

(defun log-write-disk-cache-portion (dc-log address length)
  (setq length (require-type length 'fixnum))
  (locally (declare (fixnum length))
    (let ((disk-cache (dc-log-log-for dc-log))
          (buf (make-string 512 :element-type 'base-character))
          (bytes-to-copy 0))
      (declare (fixnum bytes-to-copy offset bytes-left))
      (declare (dynamic-extent string))
      (unless (<= length 0)
        (loop
          (with-locked-page (disk-cache address nil page-buf offset bytes-left)
            (declare (fixnum offset bytes-left))
            (setq bytes-to-copy 512)
            (if (< bytes-left bytes-to-copy)
              (setq bytes-to-copy bytes-left))
            (if (< length bytes-to-copy)
              (setq bytes-to-copy length))
            (%copy-byte-array-portion page-buf offset bytes-to-copy buf 0))
          (log-write-string dc-log buf nil 0 bytes-to-copy)
          (if (<= (decf length bytes-to-copy) 0)
            (return))
          (incf address bytes-to-copy))))))

(defun log-read-disk-cache-portion (dc-log address length)
  (setq length (require-type length 'fixnum))
  (locally (declare (fixnum length))
    (let ((disk-cache (dc-log-log-for dc-log))
          (buf (make-string 512 :element-type 'base-character))
          (bytes-to-copy 0))
      (declare (fixnum bytes-to-copy))
      (declare (dynamic-extent string))
      (unless (<= length 0)
        (loop
          (with-locked-page (disk-cache address t page-buf offset bytes-left)
            (declare (fixnum offset bytes-left))
            (setq bytes-to-copy 512)
            (if (< bytes-left bytes-to-copy)
              (setq bytes-to-copy bytes-left))
            (if (< length bytes-to-copy)
              (setq bytes-to-copy length))
            (log-read-string dc-log buf 0 bytes-to-copy)
            (%copy-byte-array-portion buf offset bytes-to-copy page-buf 0)
            (if (<= (decf length bytes-to-copy) 0)
              (return))
            (incf address bytes-to-copy)))))))

(defun log-position (dc-log &optional new-position)
  (let* ((page (dc-log-page dc-log))
         (pos (if page
                (+ (disk-page-address page) (dc-log-ptr dc-log))
                0))
         (disk-cache (dc-log-disk-cache dc-log)))
    (if (null new-position)
      pos
      (let ((eof (dc-log-eof dc-log))
            (offset 0))
        (declare (fixnum offset))
        (if (> pos eof)
          (setq eof (setf (dc-log-eof dc-log) pos)))
        (if (> new-position eof)
          (error "Attempt to set position past EOF"))
        (when (eql new-position (disk-cache-size disk-cache))
          (setq offset 1)
          (decf new-position))
        (when (dc-log-modified dc-log)
          (mark-page-modified page)
          (setf (dc-log-modified dc-log) nil))
        (multiple-value-bind (buf ptr bytes-left new-page)
                             (get-disk-page disk-cache new-position)
          (declare (fixnum ptr bytes-left))
          (unless (eq page new-page)
            (lock-page new-page)
            (setf (dc-log-page dc-log) new-page
                  (dc-log-buffer dc-log) buf)
            (when page (unlock-page page)))
          (setf (dc-log-ptr dc-log) (the fixnum (+ ptr offset))
                (dc-log-bytes-left dc-log) (the fixnum (- bytes-left offset))))
          new-position))))

(defun force-log (dc-log)
  (let* ((buf-0 (dc-log-buffer-0 dc-log))
         (old-eof (%load-long buf-0 $log-eof-address))
         (eof (max (dc-log-eof dc-log) (log-position dc-log))))
    (unless (eql eof old-eof)
      (%store-long eof buf-0 $log-eof-address)
      (mark-page-modified (dc-log-page-0 dc-log)))
    (when (dc-log-modified dc-log)
      (mark-page-modified (dc-log-page dc-log))
      (setf (dc-log-modified dc-log) nil))
    (flush-disk-cache (dc-log-disk-cache dc-log))))

#|
Begin transaction:
=========
$begin-transaction-type          ; <byte>
<parent LSN>                     ; <long> - LSN of parent transaction or 0
=========
|#
; Returns the LSN of the new transaction
(defun begin-transaction-log-entry (dc-log &optional (parent-lsn 0))
  (setq parent-lsn (require-type parent-lsn 'integer))
  (let ((lsn (log-position dc-log)))
    (log-write-byte dc-log $begin-transaction-type)
    (log-write-long dc-log parent-lsn)
    (push lsn (dc-log-active-transactions dc-log))
    lsn))

#|
Continue transaction.
A Continue transaction record is written when a different
transaction needs to write log records.
=========
$continue-transaction-type       ; <byte>
<LSN>                            ; <long>
=========
|#
(defun log-ensure-active-transaction (dc-log transaction-lsn)
  (unless (member transaction-lsn (dc-log-active-transactions dc-log))
    (error "~s is not an active transaction of ~s" transaction-lsn dc-log)))

(defun continue-transaction-log-entry (dc-log transaction-lsn)
  (log-ensure-active-transaction dc-log transaction-lsn)
  (log-write-byte dc-log $continue-transaction-type)
  (log-write-long dc-log transaction-lsn))

#|
Abort transaction:
=========
$abort-transaction-type          ; <byte>
<LSN>                            ; <long>
=========
|#
(defun abort-transaction-log-entry (dc-log transaction-lsn)
  (log-ensure-active-transaction dc-log transaction-lsn)
  (setf (dc-log-active-transactions dc-log)
        (delete transaction-lsn (dc-log-active-transactions dc-log)))
  (log-write-byte dc-log $abort-transaction-type)
  (log-write-long dc-log transaction-lsn))
  

#|
Commit transaction:
=========
$commit-transaction-type         ; <byte>
<LSN>                            ; <long>
=========
|#
(defun commit-transaction-log-entry (dc-log transaction-lsn)
  (log-ensure-active-transaction dc-log transaction-lsn)
  (setf (dc-log-active-transactions dc-log)
        (delete transaction-lsn (dc-log-active-transactions dc-log)))
  (log-write-byte dc-log $commit-transaction-type)
  (log-write-long dc-log transaction-lsn))

#|
Checkpoint:
=========
$checkpoint-type                 ; <byte>
<open transaction count>         ; <length>
<lsn 0>                          ; <long>
...
<lsn n>                          ; <long>
=========
|#
(defun checkpoint-log-entry (dc-log)
  (let* ((lsn (log-position dc-log))
         (active-transactions (dc-log-active-transactions dc-log))
         (count (length active-transactions)))
    (log-write-byte dc-log $checkpoint-type)
    (log-write-length dc-log count)
    (dolist (lsn active-transactions)
      (log-write-long dc-log lsn))
    (%store-long lsn (dc-log-buffer-0 dc-log) $log-checkpoint-address)
    (mark-page-modified (dc-log-page-0 dc-log))
    count))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; The undoable log entries each have an undo function.
;; This function is called by undo-aborted-transaction with two args:
;; a log positioned just after the <undo-link> and the disk-cache
;; we're logging.
;;

#|
Write byte:
=========
$write-byte                      ; <byte>
<address>                        ; <long>
<data>                           ; <byte>
=========

Write byte with undo:
=========
$write-byte-with-undo            ; <byte>
<undo-link)                      ; <length>
<address>                        ; <long>
<old data>                       ; <byte>
<new data>                       ; <byte>
=========
|#

(defun write-byte-log-entry (dc-log address byte &optional last-undo)
  (if last-undo
    (progn
      (log-write-byte dc-log $write-byte-with-undo)
      (log-write-length dc-log (- (log-position dc-log) last-undo))
      (log-write-long dc-log address)
      (log-write-byte dc-log (read-8-bits (dc-log-disk-cache dc-log) address)))
    (progn
      (log-write-byte dc-log $write-byte)
      (log-write-long dc-log address)))
  (log-write-byte dc-log byte))

(defun undo-write-byte (log disk-cache)
  (setf (read-8-bits disk-cache (log-read-long log)) (log-read-byte log)))

#|
Write word:
=========
$write-word                      ; <byte>
<address>                        ; <long>
<data>                           ; <word>
=========

Write word with undo:
=========
$write-word-with-undo            ; <byte>
<undo-link)                      ; <length>
<address>                        ; <long>
<old data>                       ; <word>
<new data>                       ; <word>
=========
|#

(defun write-word-log-entry (dc-log address word &optional last-undo)
  (if last-undo
    (progn
      (log-write-byte dc-log $write-word-with-undo)
      (log-write-length dc-log (- (log-position dc-log) last-undo))
      (log-write-long dc-log address)
      (log-write-word dc-log (read-word (dc-log-disk-cache dc-log) address)))
    (progn
      (log-write-byte dc-log $write-word)
      (log-write-long dc-log address)))
  (log-write-word dc-log word))

(defun undo-write-word (log disk-cache)
  (setf (read-word disk-cache (log-read-long log)) (log-read-word log)))

#|
Write long:
=========
$write-long                      ; <byte>
<address>                        ; <long>
<data>                           ; <long>
=========

Write long with undo:
=========
$write-long-with-undo            ; <byte>
<undo-link)                      ; <length>
<address>                        ; <long>
<old data>                       ; <long>
<new data>                       ; <long>
=========
|#

(defun write-long-log-entry (dc-log address long &optional imm? last-undo)
  (if last-undo
    (progn
      (log-write-byte dc-log $write-byte-with-undo)
      (log-write-length dc-log (- (log-position dc-log) last-undo))
      (log-write-long dc-log address)
      (log-write-long dc-log (read-long (dc-log-disk-cache dc-log) address)))
    (progn
      (log-write-byte dc-log $write-long)
      (log-write-long dc-log address)))
  (if imm?
    (log-write-pointer dc-log long t)
    (log-write-long dc-log long)))

(defun undo-write-long (log disk-cache)
  (setf (read-long disk-cache (log-read-long log)) (log-read-long log)))

#|
Write bytes:
=========
$write-bytes                     ; <byte>
<address>                        ; <long>
<size>                           ; <length>
<data>                           ; <size> <byte>s
=========

write bytes with undo:
=========
$write-bytes-with-undo           ; <byte>
<undo-link>                      ; <length>
<address>                        ; <long>
<size>                           ; <length>
<old data>                       ; <size> <byte>s
<new data>                       ; <size> <byte>s
=========
|#
(defun write-bytes-log-entry (dc-log string start length address &optional last-undo)
  (if last-undo
    (progn
      (log-write-byte dc-log $write-bytes-with-undo)
      (log-write-length dc-log (- (log-position dc-log) last-undo))
      (log-write-long dc-log address)
      (log-write-length dc-log length)
      (log-write-disk-cache-portion dc-log address length)
      (log-write-string dc-log string nil start length))
    (progn
      (log-write-byte dc-log $write-bytes)
      (log-write-long dc-log address)
      (log-write-string dc-log string t start length)))
  string)

(defun undo-write-bytes (log disk-cache)
  (declare (ignore disk-cache))
  (log-read-disk-cache-portion log (log-read-long log) (log-read-length log)))

#|
Fill bytes:
=========
$fill-byte                      ; <byte>
<address>                        ; <long>
<count>                          ; <length>
<data>                           ; <byte>
=========

Fill bytes with undo:
=========
$fill-byte-with-undo            ; <byte>
<undo-link>                      ; <length>
<address>                        ; <long>
<count>                          ; <length>
<old data>                       ; <count> <byte>s
<new data>                       ; <byte>
=========
|#
(defun fill-byte-log-entry (dc-log address value count &optional last-undo)
  (if last-undo
    (progn
      (log-write-byte dc-log $fill-byte-with-undo)
      (log-write-length dc-log (- (log-position dc-log) last-undo))
      (log-write-long dc-log address)
      (log-write-length dc-log count)
      (log-write-disk-cache-portion dc-log address count))
    (progn
      (log-write-byte dc-log $fill-byte)
      (log-write-long dc-log address)
      (log-write-length dc-log count)))
  (log-write-byte dc-log value))

(defun undo-fill-byte (log disk-cache)
  (declare (ignore disk-cache))
  (log-read-disk-cache-portion log (log-read-long log) (log-read-length log)))

#|
Fill word:
=========
$fill-word                       ; <byte>
<address>                        ; <long>
<count>                          ; <length>
<data>                           ; <word>
=========

Fill word with undo:
=========
$fill-word-with-undo             ; <byte>
<undo-link>                      ; <length>
<address>                        ; <long>
<count>                          ; <length>
<old data>                       ; <count> <word>s
<new data>                       ; <word>
=========
|#
(defun fill-word-log-entry (dc-log address value count &optional last-undo)
  (if last-undo
    (progn
      (log-write-byte dc-log $fill-word-with-undo)
      (log-write-length dc-log (- (log-position dc-log) last-undo))
      (log-write-long dc-log address)
      (log-write-length dc-log count)
      (log-write-disk-cache-portion dc-log address count))
    (progn
      (log-write-byte dc-log $fill-word)
      (log-write-long dc-log address)
      (log-write-length dc-log count)))
  (log-write-word dc-log value))

(defun undo-fill-word (log disk-cache)
  (declare (ignore disk-cache))
  (log-read-disk-cache-portion 
   log (log-read-long log) (* 2 (the fixnum (log-read-length log)))))

#|
Fill long:
=========
$fill-long                       ; <byte>
<address>                        ; <long>
<count>                          ; <length>
<data>                           ; <long>
=========

Fill long with undo:
=========
$fill-long-with-undo             ; <byte>
<undo-link>                      ; <length>
<address>                        ; <long>
<count>                          ; <length>
<old data>                       ; <count> <long>s
<new data>                       ; <long>
=========
|#
(defun fill-long-log-entry (dc-log address value count &optional imm? last-undo)
  (if last-undo
    (progn
      (log-write-byte dc-log $fill-long-with-undo)
      (log-write-length dc-log (- (log-position dc-log) last-undo))
      (log-write-long dc-log address)
      (log-write-length dc-log count)
      (log-write-disk-cache-portion dc-log address count))
    (progn
      (log-write-byte dc-log $fill-long)
      (log-write-long dc-log address)
      (log-write-length dc-log count)))
  (if imm?
    (log-write-pointer dc-log value t)
    (log-write-long dc-log value)))

(defun undo-fill-long (log disk-cache)
  (declare (ignore disk-cache))
  (log-read-disk-cache-portion 
   log (log-read-long log) (* 4 (the fixnum (log-read-length log)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Support for undoing aborted transactions
;;

(eval-when (:compile-toplevel :execute)
  (require "LISPEQU"))                  ; ccl::%cons-pool & ccl::pool.data

(defvar *dc-log-resource* (ccl::%cons-pool))

(defun allocate-dc-log ()
  (let ((log (ccl::pool.data *dc-log-resource*)))
    (if log
      (progn
        (setf (ccl::pool.data *dc-log-resource*)
              (dc-log-log-for log))
        (setf (dc-log-log-for log) nil)
        log)
      (make-dc-log))))

; The reason we copy a log is so that recovery can use it as a pointer.
; We need to lock the page a second time so that it remains locked
; when we move to a different page with either log.
(defun dc-log-copy (log)
  (let ((copy (allocate-dc-log))
        (page (dc-log-page log)))
    (setf (dc-log-log-for copy) (dc-log-log-for log)
          (dc-log-disk-cache copy) (dc-log-disk-cache log)
          (dc-log-page copy) page
          (dc-log-buffer copy) (dc-log-buffer log)
          (dc-log-ptr copy) (dc-log-ptr log)
          (dc-log-bytes-left copy) (dc-log-bytes-left log)
          (dc-log-modified copy) (dc-log-modified log)
          (dc-log-page-0 copy) (dc-log-page-0 log)
          (dc-log-buffer-0 copy) (dc-log-buffer-0 log)
          (dc-log-eof copy) (dc-log-eof log)
          (dc-log-active-transactions copy) (dc-log-active-transactions log))
    (when page (lock-page page))
    copy))

(defun free-dc-log (log)
  (let ((page (dc-log-page log)))
    (when page
      (unlock-page page)))
  (setf (dc-log-disk-cache log) nil
        (dc-log-page log) nil
        (dc-log-buffer log) nil
        (dc-log-ptr log) 0
        (dc-log-bytes-left log) 0
        (dc-log-modified log) nil
        (dc-log-page-0 log) nil
        (dc-log-buffer-0 log) nil
        (dc-log-eof log) 0
        (dc-log-active-transactions log) nil)
  (let ((pool *dc-log-resource*))
    (setf (dc-log-log-for log) (ccl::pool.data pool)
          (ccl::pool.data pool) log))
  nil)

(defmacro with-dc-log-copy ((copy log) &body body)
  `(let ((,copy (dc-log-copy ,log)))
     (unwind-protect
       (progn ,@body)
       (free-dc-log ,copy))))

;; last-undo is 0 if there's nothing to do.
;; Otherwise, it's the LSN of the last undoable log entry for
;; the transaction whose begin-transaction log entry is at LSN.
(defun undo-aborted-transaction (dc-log lsn last-undo)
  (with-dc-log-copy (log dc-log)
    (log-position log lsn)
    (let ((undo-ptr last-undo)
          (log-for (dc-log-log-for log)))
      (loop
        (if (eql 0 undo-ptr) (return))
        (log-position log undo-ptr)
        (let* ((type (log-read-byte log))
               (undo-function (svref *log-undo-functions* type)))
          (unless undo-function
            (error "Log entry ~s is not undoable" (log-type->name type)))
          (let ((undo-link (log-read-length log)))
            (decf undo-ptr undo-link))
          (funcall undo-function log log-for))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; tables
;;
(defparameter *log-type->name*
  #(nil
    $begin-transaction-type             ; 1
    $continue-transaction-type          ; 2
    $abort-transaction-type             ; 3
    $commit-transaction-type            ; 4
    $write-byte                         ; 5
    $write-byte-with-undo               ; 6
    $write-word                         ; 7
    $write-word-with-undo               ; 8
    $write-long                         ; 9
    $write-long-with-undo               ; 10
    $write-bytes                        ; 11
    $write-bytes-with-undo              ; 12
    $fill-byte                          ; 13
    $fill-byte-with-undo                ; 14
    $fill-word                          ; 15
    $fill-word-with-undo                ; 16
    $fill-long                          ; 17
    $fill-long-with-undo                ; 18
    $checkpoint-type                    ; 19
    ))

(defparameter *log-undo-functions*
  #(nil                                 ; type 0 unused
    nil                                 ; $begin-transaction-type = 1
    nil                                 ; $continue-transaction-type = 2
    nil                                 ; $abort-transaction-type = 3
    nil                                 ; $commit-transaction-type = 4
    nil                                 ; $write-byte = 5
    undo-write-byte                     ; $write-byte-with-undo = 6
    nil                                 ; $write-word = 7
    undo-write-word                     ; $write-word-with-undo = 8
    nil                                 ; $write-long = 9
    undo-write-long                     ; $write-long-with-undo = 10
    nil                                 ; $write-bytes = 11
    undo-write-bytes                    ; $write-bytes-with-undo = 12
    nil                                 ; $fill-byte = 13
    undo-fill-byte                      ; $fill-byte-with-undo = 14
    nil                                 ; $fill-word = 15
    undo-fill-word                      ; $fill-word-with-undo = 16
    nil                                 ; $fill-long = 17
    undo-fill-long                      ; $fill-long-with-undo = 18
    nil                                 ; $checkpoint-type = 19
    ))
;;;    1   3/10/94  bill         1.8d247
;;;    2   3/23/95  bill         1.11d010
