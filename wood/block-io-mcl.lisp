;;;-*- Mode: Lisp; Package: ccl -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; block-io-mcl.lisp
;; low-level block I/O - MCL version.
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

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification history
;;
;; 01/29/00 akh  fix example at end of this file
;; 01/10/00 akh fix for possible non fixnum file address
;; ------------- 0.96
;; 07/20/96 bill databases-locked-p, with-databases-unlocked, & funcall-with-databases-unlocked
;;               are already part of CCL 4.0. Bind *warn-if-redefine*, etc. appropriately.
;; 07/06/96 bill provide block-io-mcl, not block-io.
;; 05/21/96 bill PPC versions of %fread-bytes & %fwrite-bytes now work correctly
;;               if the starting file or buffer position is odd.
;;               They use %copy-ivector-to-ivector instead of local code.
;; ------------- 0.95
;; 05/09/96 bill databases-locked-p
;;               funcall-with-databases-locked-p comes out-of-line from with-databases-unlocked.
;;               It now binds *database-locked-p* nil during its body.
;; 05/03/96 bill multi-process with-databases-locked
;; 05/01/96 slh  don't require lapmacros on PPC
;; ------------- 0.94 = MCL-PPC 3.9
;; 03/09/96 bill Eliminate LAP for ppc-target
;; ------------- 0.93
;; 07/21/95 bill inhibited-event-dispatch now processes *inhibited-foreground-switch*
;; 05/31/95 bill wood:with-database-locked now calls new inhibted-event-dispatch
;;               function if event processing happenned while it was inhibited.
;;               This makes interactive response time as good as it can be
;;               given this locking mechanism.
;; 05/25/95 bill %fread-bytes & %fwrite-bytes use #_BlockMove instead
;;               of a move.b loop; it's faster.
;;               set-minimum-file-length never makes the file shorter.
;; ------------- 0.9
;; 03/13/95 bill byte-array-p and ensure-byte-array move here from "disk-cache-accessors.lisp"
;;               byte-array-p updated to work in MCL 3.0.
;;               Former lap uses of $v_subtype changed to calls of ensure-byte-array
;; 10/25/94 Moon without-interrupts -> with-databases-locked
;; 09/21/94 bill without-interrupts around part of %fread-bytes and %fwrite-bytes
;; 01/31/94 bill %fread-bytes & %fwrite-bytes support offsets > 64K and
;;               will read/write more than just the first 512 bytes.
;; ------------  0.8
;; ------------  0.6
;; ------------  0.5
;; 03/05/92 bill New file
;;

(in-package :ccl)

;; N.B. there is another of this in disk-page-hash.lisp!!! - gone now
; Assume fixnum addresses.
; Comment out this form to compile Wood for files larger than 256 megs.
#+ignore
(eval-when (:compile-toplevel :execute :load-toplevel)
  (pushnew :wood-fixnum-addresses *features*))


(export '(stream-read-bytes stream-write-bytes set-minimum-file-length))

(provide :block-io-mcl)

(defvar *inhibit-event-dispatch* nil)
(defvar *event-dispatch-inhibited* nil)

; Set non-NIL if a suspend or resume event comes in while
; *event-dispatch-inhibited* is true. 0 means it was
; suspend, non-zero means resume.
(defvar *inhibited-foreground-switch* nil)

;;; This macro provides the interlocking so the WOOD database
;;; doesn't get screwed up by being used reentrantly by an event
;;; handler.  Change this macro and recompile to change the
;;; implementation of the interlocking.
;;; Defined here since WOOD doesn't seem to have
;;; a file specifically for macros like this.
#-ccl-3
(progn

(defmacro wood::with-databases-locked (&body body)
  ;; The following is surprisingly slow on 68040s
  ;`(without-interrupts ,@body)
  ;; So do it this way instead.
  `(multiple-value-prog1                ; Wish this could be prog1
     (let ((*inhibit-event-dispatch* t)) 
       ,@body)
     (locally (declare (optimize (speed 3) (safety 0)))         ; force inline value cell reference
       (when (and *event-dispatch-inhibited*
                  (not *inhibit-event-dispatch*))
         (inhibited-event-dispatch)))))

(defmacro wood::with-databases-unlocked (&body body)
  `(let ((ccl::*inhibit-event-dispatch* nil))
     (declare (special ccl::*inhibit-event-dispatch*))          ; fix build problem
     ,@body))

(defun wood::databases-locked-p (&optional by-locker)
  (declare (ignore by-locker))
  (and (boundp 'ccl::*inhibit-event-dispatch*)
       ccl::*inhibit-event-dispatch*))

)  ; end of #-ccl-3 progn

; with-databases-(un)locked is a NOP is CCL 3.0, since store-conditional
; doesn't exists there yet.
#+(and ccl-3 (not ppc-target))
(progn

(defmacro wood:with-databases-locked (&body body)
  `(progn ,@body))

(defmacro wood:with-databases-unlocked (&body body)
  `(progn ,@body))

(defun wood::databases-locked-p (&optional by-locker)
  (declare (ignore by-locker))
  nil)

)  ; end of #+(and ccl-3 (not ppc-target)) progn

#+ppc-target
(progn

(defvar *database-lock* (make-lock))
(defvar *database-queue* (make-process-queue "*database-queue*"))
(defvar *database-locked-p* nil)

(declaim (type lock *database-lock)
         (type boolean *database-locked-p*))

(declaim (inline lock-databases unlock-databases))

; You should only call this inside a binding of *database-locked-p* to true.
; Otherwise, another process will steal the lock from you.
; with-databases-locked uses it correctly.
; Returns when it has the *database-lock*.
; A true value means that it is newly grabbed.
; NIL means that this process already had the lock when lock-databases was called.
(defun lock-databases ()
  (declare (type process *current-process*))
  (let ((process *current-process*)
        (lock *database-lock*))
    (declare (type lock lock))
    (unless (eq (lock.value lock) process)
      (unless (store-conditional lock nil process)
        (lock-databases-out-of-line))
      t)))

(defun unlock-databases ()
  (declare (type lock *database-lock*)
           (type process *current-process*))
  (unless (store-conditional *database-lock* *current-process* nil)
    (error "~s not held by ~s" '*database-lock* *current-process*)))

(declaim (ftype (function (&optional t)) wood::with-databases-locked-p))

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))

(defun wood::databases-locked-p (&optional by-locker)
  (without-interrupts
   (let* ((lock *database-lock*)
          (locker (lock.value lock)))
     (cond ((null locker) nil)
           ((or (process-exhausted-p locker)
                (not (symbol-value-in-process '*database-locked-p* locker)))
            (setf (lock.value lock) nil))
           (by-locker (eq locker by-locker))
           (t t)))))

)

; This is so hairy because we're trying to avoid an unwind-protect (too slow)
; yet we still want to notice when the holder of the *database-lock*
; has thrown out of wood::with-databases-locked.
(defun lock-databases-out-of-line ()
  (let ((lock *database-lock*)
        (queue *database-queue*)
        (enqueued nil))
    (declare (type lock lock))
    ; In case we threw out of a with-databases-locked
    (unwind-protect
      (loop
        (wood::databases-locked-p)      ; clear lock.value if it's not really locked
        (unless enqueued
          (setq enqueued (process-enqueue-with-timeout queue 30)))
        (when enqueued
          (when (store-conditional lock nil *current-process*)
            (return t))
          (process-wait-with-timeout "Lock"
                                     30
                                     #'(lambda (lock)
                                         (null (lock.value lock)))
                                     lock)))
      (when enqueued
        (process-dequeue queue)))))

(defmacro wood::with-databases-locked (&body body)
  (let ((needs-unlocking-p (gensym)))
    `(let* ((*database-locked-p* t)
            (,needs-unlocking-p (lock-databases)))
       (multiple-value-prog1
         (progn ,@body)
         (when ,needs-unlocking-p 
           (unlock-databases))))))

;;; Undo the effect of with-databases-locked temporarily, if possible
(eval-when (:compile-toplevel :execute :load-toplevel)
(unless (fboundp 'wood::with-databases-unlocked)

(defmacro wood::with-databases-unlocked (&body body)
  (let ((thunk (gensym)))
    `(let ((,thunk #'(lambda () ,@body)))
       (declare (dynamic-extent ,thunk))
       (funcall-with-databases-unlocked ,thunk))))

))

(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))
      
(defun funcall-with-databases-unlocked (thunk)
  (let ((was-locked? nil))
    (unwind-protect
      (let ((*database-locked-p* *database-locked-p*))
        (when (setq was-locked? (wood::databases-locked-p *current-process*))
          (unlock-databases)
          (setq *database-locked-p* nil))
        (funcall thunk))
      (when was-locked?
        (lock-databases)))))

)

)  ; end of #+ppc-target progn

; Separate function mostly so we can meter it
(defun inhibited-event-dispatch ()
  (setq *event-dispatch-inhibited* nil)
  (let ((switch *inhibited-foreground-switch*))
    (when switch
      (setq *inhibited-foreground-switch* nil)
      (unless (eq *foreground*
                  (setq *foreground* (not (eql switch 0))))
        (when (fboundp 'establish-*foreground*)
          (funcall 'establish-*foreground*)))))
  (event-dispatch))

;; (stream-read-bytes stream address vector offset length)
;;   read length bytes into vector at offset from stream at address.
;;
;; (stream-write-bytes stream address vector offset length)
;;   write length bytes from stream at address into vector at offset.
;;   Extend the length of the file if necessary.
;;
;; (set-minimum-file-length stream length)
;;   Set the file length of stream to >= length.
;;
;; This implementation only supports vectors of type
;; (array (unsigned-byte 8)), (array (signed-byte 8)), or simple-string

(eval-when (eval compile)
  #-ppc-target
  (require 'lapmacros)
  (require 'lispequ)

;structure of fblock
;from "ccl:level-1;l1-sysio.lisp"

(let ((*warn-if-redefine* nil))

(def-accessors (fblock) %svref
  nil                                   ; 'fblock
  fblock.pb                             ; a parameter block; nil if closed.
  fblock.lastchar                       ; untyi char or nil
  fblock.dirty                          ; non-nil when dirty
  fblock.buffer                         ; macptr to buffer; nil when closed
  fblock.bufvec                         ; buffer vector; nil when closed
  fblock.bufsize                        ; size (in 8-bit bytes) of buffer
  fblock.bufidx                         ; index of next element to read/write
  fblock.bufcount                       ; # of elements in buffer
  fblock.filepos                        ; 8-bit position at last read/write
  fblock.fileeof                        ; file's logical eof.
  fblock.stream                         ; backptr to file stream
  fblock.element-type                   ; typespec
  fblock.nbits-per-element              ; # of bits per element
  fblock.elements-per-buffer            ; 512 or whatever
  fblock.minval                         ; minimum value of element type or nil: < 0 
  fblock.maxval                         ; maximum value or nil
  fblock.element-bit-offset             ; for non-arefable n-bit elements
)

) ; end of let

) ; end of eval-when

(declaim (inline byte-array-p ensure-byte-array))

#-ppc-target
(defun byte-array-p (array)
  (and (uvectorp array)
       (let ((subtype (%vect-subtype array)))
         (or (eql subtype $v_sstr)
             (eql subtype $v_ubytev)
             (eql subtype $v_sbytev)))))

#+ppc-target
(defun byte-array-p (array)
  (let ((typecode (extract-typecode array)))
    (or (eql typecode ppc::subtag-simple-base-string)
        (eql typecode ppc::subtag-s8-vector)
        (eql typecode ppc::subtag-u8-vector))))

(defun ensure-byte-array (array)
  (unless (byte-array-p array)
    (error "~s is not a byte array" array)))

; Read length bytes into array at offset from stream at address.
; Array must be a simple (byte 8) array.
; stream must be an input stream for 8 bit elements.
(defmethod stream-read-bytes ((stream input-file-stream)
                                 address array offset length)
  (%fread-bytes (slot-value stream 'fblock)
                #+:wood-fixnum-addresses
                (require-type address 'fixnum)
                #-:wood-fixnum-addresses
                (require-type address 'integer)
                array
                (require-type offset 'fixnum)
                (require-type length 'fixnum)))

#-ppc-target
(defun %fread-bytes (fblock address array offset length)
  (declare (fixnum offset length))
  #+:wood-fixnum-addresses (declare (fixnum address))
  (unless (eql 8 (fblock.nbits-per-element fblock))
    (error "%fread-bytes only implemented for 8-bit bytes"))
  (unless (>= (length array) (the fixnum (+ offset length)))
    (error "array too small"))
  (ensure-byte-array array)
  (let ((max-length (- (%fsize fblock) address)))
    #+:wood-fixnum-addresses (declare (fixnum max-length))
    (if (< max-length length) (setq length max-length))
    (if (< length 0) (setq length 0)))
  (let ((bytes length)
        (bufvec (fblock.bufvec fblock)))
    (declare (fixnum bytes))
    (loop
      (when (<= length 0) (return bytes))
      (wood::with-databases-locked
       (%fpos fblock address)
       (let* ((vec-index (- address (the #+:wood-fixnum-addresses fixnum
                                         #-:wood-fixnum-addresses integer
                                         (fblock.filepos fblock))))
              (vec-left (- (the fixnum (fblock.bufcount fblock)) vec-index)))
         (declare (fixnum vec-index vec-left))
         ;        (print-db vec-index vec-left)
         (if (> vec-left length) (setq vec-left length))
         (lap-inline ()
           (:variable bufvec array offset vec-index vec-left)
           (move.l (varg bufvec) atemp0)
           (move.l (varg vec-index) acc)
           (getint acc)
           (lea (atemp0 acc.l $v_data) atemp0)
           (move.l (varg array) atemp1)
           (move.l (varg offset) acc)
           (getint acc)
           (lea (atemp1 acc.l $v_data) atemp1)
           (move.l (varg vec-left) acc)
           (getint acc)
           (dc.w #_BlockMove)
           )
         (incf address vec-left)
         (incf offset vec-left)
         (decf length vec-left))))))

#+ppc-target
(defun %fread-bytes (fblock address array offset length)
  (declare (fixnum offset length))
  #+:wood-fixnum-addresses (declare (fixnum address))
  (unless (eql 8 (fblock.nbits-per-element fblock))
    (error "%fread-bytes only implemented for 8-bit bytes"))
  (unless (>= (length array) (the fixnum (+ offset length)))
    (error "array too small"))
  (ensure-byte-array array)
  (let ((max-length (- (%fsize fblock) address)))
     #+:wood-fixnum-addresses (declare (fixnum max-length))
    (if (< max-length length) (setq length max-length))
    (if (< length 0) (setq length 0)))
  (let ((bytes length)
        (bufvec (fblock.bufvec fblock)))
    (declare (fixnum bytes))
    (loop
      (when (<= length 0) (return bytes))
      (without-interrupts
       (%fpos fblock address)
       (let* ((vec-index (fblock.bufidx fblock))
              (vec-left (- (the fixnum (fblock.bufcount fblock)) vec-index)))
         (declare (fixnum vec-index vec-left))
         (if (> vec-left length) (setq vec-left length))
         (%copy-ivector-to-ivector bufvec vec-index array offset vec-left)
         (incf address vec-left)
         (incf offset vec-left)
         (decf length vec-left))))))

; same, but other direction
(defmethod stream-write-bytes ((stream output-file-stream)
                                  address array offset length)
  (%fwrite-bytes (slot-value stream 'fblock)
                 #+:wood-fixnum-addresses (require-type address 'fixnum)
                 #-:wood-fixnum-addresses (require-type address 'integer)
                 array
                 (require-type offset 'fixnum)
                 (require-type length 'fixnum)))

#-ppc-target
(defun %fwrite-bytes (fblock address array offset length)
  (declare (fixnum offset length))
   #+:wood-fixnum-addresses (declare (fixnum address))
  (unless (eql 8 (fblock.nbits-per-element fblock))
    (error "%fwrite-bytes only implemented for 8-bit bytes"))
  (unless (>= (length array) (the fixnum (+ offset length)))
    (error "array too small"))
  (ensure-byte-array array)
  (let ((min-size (+ address length)))
     #+:wood-fixnum-addresses (declare (fixnum min-size))
    (when (> min-size (%fsize fblock))
      (%fsize fblock min-size)))
  (let ((bytes length)
        (bufvec (fblock.bufvec fblock)))
    (declare (fixnum bytes))
    (loop
      (when (<= length 0) (return bytes))
      (wood::with-databases-locked
       (%fpos fblock address)
       (let* ((vec-index (- address (the  #+:wood-fixnum-addresses fixnum
                                          #-:wood-fixnum-addresses integer
                                          (fblock.filepos fblock))))
              (vec-left (- (the fixnum (fblock.elements-per-buffer fblock))
                           vec-index)))
         (declare (fixnum vec-index vec-left))
         (if (> vec-left length) (setq vec-left length))
         (lap-inline ()
           (:variable bufvec array offset vec-index vec-left)
           (move.l (varg bufvec) atemp1)
           (move.l (varg vec-index) acc)
           (getint acc)
           (lea (atemp1 acc.l $v_data) atemp1)
           (move.l (varg array) atemp0)
           (move.l (varg offset) acc)
           (getint acc)
           (lea (atemp0 acc.l $v_data) atemp0)
           (move.l (varg vec-left) acc)
           (getint acc)
           (dc.w #_BlockMove))
         (let ((index (+ vec-index vec-left))
               (bufcount (fblock.bufcount fblock)))
           (declare (fixnum index bufcount))
           (if (> index bufcount)
             (setf (fblock.bufcount fblock) index))
           (setf (fblock.bufidx fblock) index
                 (fblock.dirty fblock) t))
         (incf address vec-left)
         (incf offset vec-left)
         (decf length vec-left))))))

#+ppc-target
(defun %fwrite-bytes (fblock address array offset length)
  (declare (fixnum offset length))
  #+:wood-fixnum-addresses (declare (fixnum address))
  (unless (eql 8 (fblock.nbits-per-element fblock))
    (error "%fwrite-bytes only implemented for 8-bit bytes"))
  (unless (>= (length array) (the fixnum (+ offset length)))
    (error "array too small"))
  (ensure-byte-array array)
  (let ((min-size (+ address length)))
    #+:wood-fixnum-addresses (declare (fixnum min-size))
    (when (> min-size (%fsize fblock))
      (%fsize fblock min-size)))
  (let ((bytes length)
        (bufvec (fblock.bufvec fblock)))
    (declare (fixnum bytes))
    (loop
      (when (<= length 0) (return bytes))
      (wood::with-databases-locked
       (%fpos fblock address)
       (let* ((vec-index (fblock.bufidx fblock))
              (vec-left (- (the fixnum (fblock.elements-per-buffer fblock))
                           vec-index)))
         (declare (fixnum vec-index vec-left))
         (if (> vec-left length) (setq vec-left length))
         (%copy-ivector-to-ivector array offset bufvec vec-index vec-left)
         (let ((index (+ vec-index vec-left))
               (bufcount (fblock.bufcount fblock)))
           (declare (fixnum index bufcount))
           (if (> index bufcount)
             (setf (fblock.bufcount fblock) index))
           (setf (fblock.bufidx fblock) index
                 (fblock.dirty fblock) t))
         (incf address vec-left)
         (incf offset vec-left)
         (decf length vec-left))))))

(defun set-minimum-file-length (stream length)
  (unless (>= (file-length stream) length)
    (file-length stream length)))

#|
(setq s (open "temp.lisp" :direction :io :if-exists :overwrite))

(defun r (address length)
  (declare (special s))
  (let ((v (make-string length :element-type 'base-character)))
    (let ((real-length (stream-read-bytes s address v 0 length)))
      (if (eql length real-length)
        (values v length)
        (let ((res (make-string real-length)))
          (dotimes (i real-length)
            (setf (aref res i) (aref v i)))
          (values res real-length))))))

(defun w (string address &optional
                 (offset 0) (length (- (length string) offset)))
  (declare (special s))
  (stream-write-bytes s address string offset length))

|#
;;;    1   3/10/94  bill         1.8d247
;;;    2  10/04/94  bill         1.9d071
;;;    3  11/03/94  Moon         1.9d086
;;;    2   3/23/95  bill         1.11d010
;;;    3   6/02/95  bill         1.11d040
;;;    4   8/01/95  bill         1.11d065
