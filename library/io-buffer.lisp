;;; -*- Mode: LISP; Syntax: Ansi-common-lisp; Package: CCL; Base: 10 -*-

;;	Change History (most recent first):
;;  3 8/25/97  akh  jcma's fix in an error case
;;  2 6/9/97   akh  io-buffer-stream-listen sees untyi-char
;;  (do not edit before this line!!)
;;; io-buffer.lisp
;;; Copyright 1996-1999 Digitool, Inc. 

;;; General purpose I/O buffer mechanism.
;;; Any stream that uses buffering can use this code to do the buffering.
;;; All that remains is to write the code that fills and empties the
;;; buffers, and does the opening and closing, eof testing, data avaiable, etc.

(in-package :ccl)



;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History
;;;;;; Terje stream-clear-output no longer hangs;;; -------- MCL 5.2
;;; io-buffer-write-file - check start > filesize vs start >= filesize
;;; -------- 5.1 final
;;; %%ptr-difference uses current macptr lap defs.
;;; ------- 5.1b1
;;; akh add stream-untyi for buffered-binary-input-stream-mixin
;;; akh add %io-buffer-read-bytes-to-file-stream from JCMa
;;; ------ 5.0b5
;;; add some stream-element-type methods. stream-tyo and tyi for binary streams????
;;; stream-writer ((stream buffered-binary-output-stream-mixin)) error if code arg is not fixnum, or just do it if character???
;;; -------- 4.4b5
;;; fix in %io-buffer-read-bytes-to-vector
;;; ------- 4.4b4
;;; 03/26/02 stream-read-bytes-to-vector was broken
;;; 03/14/02 add (defmethod stream-writer ((stream buffered-binary-output-stream-mixin)), stream-reader for input too
;;; ----- 4.4b2
;;; 10/02/99 akh stream-clear-output gets outcount right and decf's bytes written from Terje N.
;;; -------- 4.3f1c1
;;; 06/25/99 akh  move provide to end of file
;;; 05/28/99 jcma %io-buffer-advance takes an optional errorp arguments. All callers updated appropriately.
;;;                           grab-io-buffer-lock-out-of-line uses process-poll for performance.
;;; 05/13/99 jcma %io-buffer-advance may signal EOF. Updated all definitions that would have remained inconsistent
;;;                            %io-buffer-read-byte, %io-buffer-read-bytes-to-file, %io-buffer-read-bytes-to-vector
;;; 04/29/99 jcma added stream-read-bytes-to-vector, io-buffer-read-bytes-to-vector
;;; 04/13/99 jcma added %io-buffer-read-untyi-char
;;  05/24/98 akh   stream-tyo and %io-buffer-stream-write-string handle extended chars/strings, add stream-write-byte
;;; 09/10/97 slh   <initialize-instance buffered-stream-mixin>: allow other keys - maybe unnecessary
;;; 07/31/97 cvince   make stream-close after method an around method
;;; 07/25/97 jcma  fixed end test in io-buffer-write-file
;;; 07/25/97 akh   jcma's fix to end bad arg test
;;; 06/05/97 akh   stream-listen checks for untyi-char, some changes in the test at end of this file
;;; 11/20/96 bill  Slightly speed up Gary's fixes to io-buffer-write-file.
;;;                stream-clear-output doesn't call %io-buffer-force-output.
;;;                Instead, it just initializes the outptr itself.
;;;                %io-buffer-force-output no longer initializes io-buffer-outptr.
;;;                This is now the responsibility of the force-output function.
;;;                %io-buffer-advance & stream-listen likewise don't initialize
;;;                io-buffer-inptr.
;;; 11/20/96 gb    fixes in io-buffer-write-file.
;;; 11/18/96 bill  io-buffer-read-bytes-to-file
;;; 11/15/96 bill  make stream-io-buffer, instead of using-stream-io-buffer,
;;;                error if the io-buffer is NIL.
;;; 11/14/96 bill  %stream-bytes-read & %stream-bytes-written cache.
;;;                stream-bytes-received & stream-bytes-transmitted methods and their setf methods.
;;;                io-buffer-inbuf-size, io-buffer-outbuf-size
;;;                io-buffer-outpos, io-buffer-inpos
;;;                io-buffer-write-file
;;; 11/13/96 bill  using-stream-io-buffer handles a null stream-io-buffer
;;;                and takes keyword instead of optional args.
;;;                (method stream-close :after (buffered-stream-mixin)) sets the io-buffer to NIL.
;;;                Restore the second arg to %io-buffer-force-output in %io-buffer-stream-write-string
;;;                and %io-buffer-stream-write-ptr
;;; 11/13/96 bill  stream-clear-input & stream-clear-output methods.
;;;                Replace io-buffer-finish-output with a finish-p arg to io-buffer-flush-output.
;;;                (method stream-listen (buffered-input-stream-mixin)) resets the io-buffer-inptr.
;;; 11/13/96 gb    spell "buffering", "buffered" with one #\r.
;;;                Call %IO-BUFFER-FORCE-OUTPUT in STREAM-FORCE-OUTPUT method.
;;;                IO-BUFFER-FORCE-OUTPUT hook functions expect "count" argument.
;;; 11/13/96 bill  Speed up locking by eliminating the unwind-protect
;;;                This reduces the time for with-io-buffer-locked from 5.48 microseconds to 0.420
;;;                microseconds on my 132 Mhz 9500.
;;;                flush-output -> force-output
;;;                stream-tyi doesn't call code-char on NIL.
;;;                stream-reader and stream-writer methods.
;;;                %io-buffer-write-byte clears the untyi-char if sharing buffers.
;;;                initialize io-buffer-bytes-read and io-buffer-bytes-written to 0.
;;;                Put a simple example at the end of the file.
;;;                Fix parens in stream-eofp.
;;;                %get-unsigned-byte, not %get-byte, in %io-buffer-read-byte
;;; 11/12/96 bill  New file
;;;

#|

BUFFERED-STREAM-MIXIN is the abstract mixin one of whose subclasses should be
mixed in to your class. Its STREAM-IO-BUFFER accessor is an IO-BUFFER structure
instance. The INITIALIZE-INSTANCE method for BUFFERED-STREAM-MIXIN sets up the
IO-BUFFER. If you need to store other stuff, you can :INCLUDE IO-BUFFER in
your own structure and set the STREAM-IO-BUFFER slot to your instance before
CALL-NEXT-METHOD in your INITIALIZE-INSTANCE method.

The subclasses of BUFFERED-STREAM-MIXIN and the methods specialized on them are
as follows. BUFFERED-STREAM-MIXIN, BUFFERED-INPUT-STREAM-MIXIN, and
BUFFERED-OUTPUT-STREAM-MIXIN are abstract classes. You should mix in one
or more of the other classes. The default methods should be useable as is
unless you need to do filtering on the data.

BUFFERED-STREAM-MIXIN
  initialize-instance
  stream-close :after

BUFFERED-INPUT-STREAM-MIXIN (BUFFERED-STREAM-MIXIN)
  stream-listen
  stream-eofp
  stream-clear-input

BUFFERED-OUTPUT-STREAM-MIXIN (BUFFERED-STREAM-MIXIN)
  stream-write-string
  stream-force-output
  stream-finish-output
  stream-clear-output

BUFFERED-CHARACTER-INPUT-STREAM-MIXIN (BUFFERED-INPUT-STREAM-MIXIN INPUT-STREAM)
  stream-tyi
 
BUFFERED-CHARACTER-OUTPUT-STREAM-MIXIN (BUFFERED-OUTPUT-STREAM-MIXIN OUTPUT-STREAM)
  stream-tyo

BUFFERED-CHARACTER-IO-STREAM-MIXIN (BUFFERED-CHARACTER-INPUT-STREAM-MIXIN BUFFERED-CHARACTER-OUTPUT-STREAM-MIXIN)

BUFFERED-BINARY-INPUT-STREAM-MIXIN (BUFFERED-INPUT-STREAM-MIXIN INPUT-BINARY-STREAM)
  stream-read-byte

BUFFERED-BINARY-OUTPUT-STREAM-MIXIN (BUFFERED-OUTPUT-STREAM-MIXIN OUTPUT-BINARY-STREAM)
  stream-write-byte
  stream-write-vector

BUFFERED-BINARY-IO-STREAM-MIXIN (BUFFERED-BINARY-INPUT-STREAM-MIXIN BUFFERED-BINARY-OUTPUT-STREAM-MIXIN)


Generic functions that fill and empty the buffers and
provide eof and data available information. You need to
specialize these on your stream class. Most of them do
not have a default method.

INITIALIZE-INSTANCE stream &key insize outsize share-buffers-p
  Initializes (STREAM-IO-BUFFER stream). Allocates an instance
  of IO-BUFFER if the slot is not already set. If it is set,
  it should be a structure instance that :INCLUDE's IO-BUFFER.
  If INSIZE (OUTSIZE) is non-NIL, it is the number of bytes to
  allocate for the input (output) buffer. If SHARE-BUFFERS-P is
  true, causes a single buffer to be shared between input and output.

STREAM-CLOSE :after stream
  Deallocates the buffers if they were allocated by INITIALIZE-INSTANCE.

IO-BUFFER-ADVANCE stream io-buffer readp &optional errorp
  Called when there is no data in the input buffer.
  If readp is true, this is a request for data:
    Either fill IO-BUFFER-INBUF with data
    or %SETF-MACPTR it to the new buffer (for non-copying reads).
    And set IO-BUFFER-INCOUNT to the number of bytes in the buffer.
    Also, (%setf-macptr io-buffer-inptr io-buffer-inbuf).
    Return true if there are new bytes to read, false if end-of-file.
    Don't return unless you've gotten more data or the stream is at end-of-file.
  If readp is false, this is a notification that the input buffer has
  been used up. If this is a doing non-copying input, release the input
  buffer. You can read more here if you want to, but it's best not to block.
  ERRORP controls whether eof errors are signalled or NIL returned.
    
IO-BUFFER-LISTEN stream io-buffer
  Return true if there is data ready to read.
  If you modify io-buffer-inbuf, then (%setf-macptr io-buffer-inptr io-buffer-inbuf).

IO-BUFFER-EOFP stream io-buffer
  Return true if the stream is at end-of-file.

IO-BUFFER-FORCE-OUTPUT stream io-buffer count finish-p
  Write count bytes from IO-BUFFER-OUTBUF.
   (%SETF-MACPTR IO-BUFFER-OUTBUF ...) if you are doing non-copying writes.
  Also, (%setf-macptr io-buffer-outptr io-buffer-outbuf).
  Set IO-BUFFER-OUTCOUNT to the number of bytes in the (possibly new) output buffer.
    If you're not doing non-copying-writes this will be IO-BUFFER-OUTSIZE.
  If finish-p is true, you should finish the output before returning.

|#

(defstruct io-buffer
  stream                                ; The stream I'm bufferring
  untyi-char                            ; nil or last value passed to stream-untyi
  inbuf                                 ; a macptr
  inptr                                 ; pointer to current byte - a macptr
  insize                                ; The total size (octets) of inbuf if we allocated it, NIL otherwise
  incount                               ; number of bytes left to read
  (bytes-read 0)                        ; total number of byte read from stream.
  (advance-function 'io-buffer-advance)
  (listen-function 'io-buffer-listen)
  (eofp-function 'io-buffer-eofp)
  outbuf                                ; a macptr, EQ to inbuf if sharing input and output buffer
  outptr                                ; pointer to current byte, EQ to inptr if sharing buffers
  outsize                               ; number of octets in outbuf
  outcount                              ; number of bytes left to write before buffer is full
                                        ; NIL if sharing buffers
  (bytes-written 0)                     ; total number of bytes written
  (force-output-function 'io-buffer-force-output)
  (close-function 'io-buffer-close)
  (lock (make-lock)))                   ; a lock to grab

(defclass buffered-stream-mixin ()
  ((io-buffer :reader %stream-io-buffer :writer (setf stream-io-buffer) :initform nil)
   (%bytes-read :initform 0 :accessor %stream-bytes-read)
   (%bytes-written :initform 0 :accessor %stream-bytes-written)))

(declaim (inline stream-io-buffer))

(defun stream-io-buffer (stream &optional (error-if-nil t))
  (or (%stream-io-buffer stream)
      (when error-if-nil
        (error "~s is closed" stream))))

(defclass buffered-input-stream-mixin (buffered-stream-mixin)
  ())
(defclass buffered-output-stream-mixin (buffered-stream-mixin)
  ())
(defclass buffered-io-stream-mixin (buffered-input-stream-mixin buffered-output-stream-mixin)
  ())
(defclass buffered-character-input-stream-mixin (buffered-input-stream-mixin input-stream)
  ())
(defclass buffered-character-output-stream-mixin (buffered-output-stream-mixin output-stream)
  ())
(defclass buffered-character-io-stream-mixin (buffered-character-input-stream-mixin buffered-character-output-stream-mixin)
  ())
(defclass buffered-binary-input-stream-mixin (buffered-input-stream-mixin input-binary-stream)
  ())
(defclass buffered-binary-output-stream-mixin (buffered-output-stream-mixin output-binary-stream)
  ())
(defclass buffered-binary-io-stream-mixin (buffered-binary-input-stream-mixin buffered-binary-output-stream-mixin)
  ())

(defmethod initialize-instance ((stream buffered-stream-mixin)
                                &key insize             ; integer to allocate inbuf here, nil otherwise
                                outsize                 ; integer to allocate outbuf here, nil otherwise
                                share-buffers-p         ; true if input and output share a buffer
                                advance-function
                                listen-function
                                eofp-function
                                force-output-function
                                close-function
                                &allow-other-keys)  ;; dont think this is needed - akh
  (call-next-method)
  (let ((io-buffer (or (let ((io-buffer (stream-io-buffer stream nil)))
                         (when io-buffer
                           (setf (io-buffer-stream io-buffer) stream
                                 (io-buffer-insize io-buffer) insize
                                 (io-buffer-outsize io-buffer) outsize)
                           io-buffer))
                       (make-io-buffer :stream stream :insize insize :outsize outsize))))
    (setf (io-buffer-inbuf io-buffer)
          (if insize
            (#_NewPtrClear :errchk insize)
            (%null-ptr))
          (io-buffer-inptr io-buffer) (%inc-ptr (io-buffer-inbuf io-buffer) 0)
          (io-buffer-incount io-buffer) 0)
    (if share-buffers-p
      (if insize
        (setf (io-buffer-outbuf io-buffer) (io-buffer-inbuf io-buffer)
              (io-buffer-outptr io-buffer) (io-buffer-inptr io-buffer)
              (io-buffer-outsize io-buffer) insize
              (io-buffer-outcount io-buffer) nil)
        (error "Can't share buffers unless insize is non-zero"))
      (setf (io-buffer-outbuf io-buffer)
            (if outsize
              (#_NewPtrClear :errchk outsize)
              (%null-ptr))
            (io-buffer-outptr io-buffer) (%inc-ptr (io-buffer-outbuf io-buffer) 0)
            (io-buffer-outcount io-buffer) (or outsize 0)))
    (when advance-function
      (setf (io-buffer-advance-function io-buffer) advance-function))
    (when listen-function
      (setf (io-buffer-listen-function io-buffer) listen-function))
    (when eofp-function
      (setf (io-buffer-eofp-function io-buffer) eofp-function))
    (when force-output-function
      (setf (io-buffer-force-output-function io-buffer) force-output-function))
    (when close-function
      (setf (io-buffer-close-function io-buffer) close-function))
    (setf (stream-io-buffer stream) io-buffer)))

;; The primary stream-close method in ccl:library;opentransport.lisp bashes the io-buffer
;; slot when it calls ot-conn-close.  This :after deconstructor never gets to do its job. cvince -- 07/31/97
#+ignore
(defmethod stream-close :after ((stream buffered-stream-mixin))
  (let* ((io-buffer (stream-io-buffer stream nil)))
    (when io-buffer
      (setf (stream-io-buffer stream) nil
            (%stream-bytes-read stream) (io-buffer-bytes-read io-buffer)
            (%stream-bytes-written stream) (io-buffer-bytes-written io-buffer))
      (when (io-buffer-insize io-buffer)
        (setf (io-buffer-insize io-buffer) nil)
        (#_DisposePtr (io-buffer-inbuf io-buffer))
        (%setf-macptr (io-buffer-inbuf io-buffer) (%null-ptr))
        (%setf-macptr (io-buffer-inptr io-buffer) (%null-ptr)))
      (when (io-buffer-outsize io-buffer)
        (setf (io-buffer-outsize io-buffer) nil)
        (#_DisposePtr (io-buffer-outbuf io-buffer))
        (%setf-macptr (io-buffer-outbuf io-buffer) (%null-ptr))
        (%setf-macptr (io-buffer-outptr io-buffer) (%null-ptr))))))

;; Make the :after method an :around method in order to keep the mac resource deallocation transparent. cvince -- 07/31/97
; from cvincent - see ot-conn-close, which clears stream-io-buffer too early
(defmethod stream-close :around ((stream buffered-stream-mixin))
  (let ((io-buffer (stream-io-buffer stream nil)))
    (case io-buffer
      ((nil) (call-next-method))
      (t (setf (%stream-bytes-read    stream) (io-buffer-bytes-read    io-buffer)
               (%stream-bytes-written stream) (io-buffer-bytes-written io-buffer))
         (call-next-method)
         (when (io-buffer-insize io-buffer)
           (setf (io-buffer-insize io-buffer) nil)
           (#_DisposePtr (io-buffer-inbuf io-buffer))
           (%setf-macptr (io-buffer-inbuf io-buffer) (%null-ptr))
           (%setf-macptr (io-buffer-inptr io-buffer) (%null-ptr)))
         (when (io-buffer-outsize io-buffer)
           (setf (io-buffer-outsize io-buffer) nil)
           (#_DisposePtr (io-buffer-outbuf io-buffer))
           (%setf-macptr (io-buffer-outbuf io-buffer) (%null-ptr))
           (%setf-macptr (io-buffer-outptr io-buffer) (%null-ptr)))))))

(defmethod stream-bytes-received ((stream buffered-stream-mixin))
  (let ((io-buffer (stream-io-buffer stream nil)))
    (if io-buffer
      (io-buffer-bytes-read io-buffer)
      (%stream-bytes-read stream))))

(defmethod (setf stream-bytes-received) (bytes-read (stream buffered-stream-mixin))
  (let ((io-buffer (stream-io-buffer stream nil)))
    (if io-buffer
      (setf (io-buffer-bytes-read io-buffer) bytes-read)
      (setf (%stream-bytes-read stream) bytes-read))))

(defmethod stream-bytes-transmitted ((stream buffered-stream-mixin))
  (let ((io-buffer (stream-io-buffer stream nil)))
    (if io-buffer
      (io-buffer-bytes-written io-buffer)
      (%stream-bytes-written stream))))

(defmethod (setf stream-bytes-transmitted) (bytes-written (stream buffered-stream-mixin))
  (let ((io-buffer (stream-io-buffer stream nil)))
    (if io-buffer
      (setf (io-buffer-bytes-written io-buffer) bytes-written)
      (setf (%stream-bytes-written stream) bytes-written))))

(defgeneric io-buffer-advance (stream io-buffer readp &optional errorp)
  (:documentation
   "Called when the current input buffer is empty (or non-existent).
    READP true means the caller expects to return a byte now.
    ERRORP controls where eof errors are signalled or NIL returned.
    Return value is non-null when there is input ready."))

(defgeneric io-buffer-listen (stream io-buffer)
  (:documentation
   "Called in response to stream-listen when the current
    input buffer is empty.
    Returns a boolean"))

(defgeneric io-buffer-eofp (stream io-buffer)
  (:documentation
   "Called in response to stream-eofp when the input buffer is empty.
    Returns a boolean."))

(defgeneric io-buffer-force-output (stream io-buffer count finish-p)
  (:documentation
   "Called in response to stream-force-output.
    Write count bytes from io-buffer-outbuf.
    Finish the I/O if finish-p is true."))

(defvar *grabbed-io-buffer-locks* nil)

(declaim (type t *grabbed-io-buffer-locks*))

(declaim (inline %grab-io-buffer-lock %release-io-buffer-lock))

; You should only call this inside a binding of *grabbed-io-buffer-locks* to a list containing the lock.
; Otherwise, another process will steal the lock from you.
; with-io-buffer-locked uses it correctly.
; Returns when it has the lock.
; A true value means that it is newly grabbed.
; NIL means that this process already had the lock when %grab-io-buffer-lock was called.
(defun %grab-io-buffer-lock (lock)
  (declare (type lock lock)
           (type process *current-process*)
           (optimize (speed 3) (safety 0)))
  (let ((process *current-process*))
    (locally (declare (type lock lock))
      (or (store-conditional lock nil process)
          (if (eq (lock.value lock) process)
            nil
            (grab-io-buffer-lock-out-of-line lock))))))

(defun %release-io-buffer-lock (lock)
  (setf (lock.value lock) nil))

(defun %io-buffer-lock-really-grabbed-p (lock)
  (declare (type lock lock))
  (without-interrupts
   (let* ((locker (lock.value lock)))
     (cond ((null locker) nil)
           ((or (process-exhausted-p locker)
                (not (memq lock (symbol-value-in-process '*grabbed-io-buffer-locks* locker))))
            (setf (lock.value lock) nil))
           (t t)))))

(defun grab-io-buffer-lock-out-of-line (lock)
   (declare (type lock lock))
   ; In case we threw out of a with-io-buffer-locked
   (loop (%io-buffer-lock-really-grabbed-p lock)   ; clear bogus lock.value
            (when (store-conditional lock nil *current-process*)
                (return t))
            (process-poll-with-timeout "Lock io-buffer" 30 #'(lambda (lock) (null (lock.value lock))) lock)))

; Execute the body with the lock grabbed.
; lock must really be a lock or you will crash.
; This isn't just with-lock-grabbed because that does an unwind-protect.
; The special binding of *grabbed-io-buffer-locks* is much faster (factor of 10).
(defmacro with-io-buffer-lock-grabbed ((lock &optional multiple-value-p) &body body)
  (let ((needs-unlocking-p (gensym))
        (lock-var (gensym)))
    `(let* ((,lock-var ,lock)
            (*grabbed-io-buffer-locks* (cons ,lock-var *grabbed-io-buffer-locks*))
            (,needs-unlocking-p (%grab-io-buffer-lock ,lock-var)))
         (declare (dynamic-extent *grabbed-io-buffer-locks*))
         (,(if multiple-value-p 'multiple-value-prog1 'prog1)
          (progn ,@body)
          (when ,needs-unlocking-p 
            (%release-io-buffer-lock ,lock-var))))))

; io-buffer must really be an io-buffer or you will crash
(defmacro with-io-buffer-locked ((io-buffer &optional multiple-value-p) &body body)
  `(with-io-buffer-lock-grabbed ((locally (declare (optimize (speed 3) (safety 0)))
                                   (io-buffer-lock ,io-buffer))
                                 ,multiple-value-p)
     ,@body))

(defmacro using-stream-io-buffer ((io-buffer stream &key
                                             speedy
                                             multiple-value-p)
                                  &body body)
  `(let ((,io-buffer (stream-io-buffer ,stream)))
     ,@(when speedy `((declare (optimize (speed 3) (safety 0)))))
     (with-io-buffer-locked (,io-buffer ,multiple-value-p) ,@body)))

(defun %io-buffer-advance (io-buffer read-p &optional errorp)
  (funcall (io-buffer-advance-function io-buffer) (io-buffer-stream io-buffer) io-buffer read-p errorp))

(declaim (inline %io-buffer-read-byte))

(defun %io-buffer-read-byte (io-buffer errorp)
   (declare (optimize (speed 3) (safety 0)))
   (when (eql 0 (io-buffer-incount io-buffer))
       (unless (%io-buffer-advance io-buffer t errorp)         ; eof may be signalled through this -- JCMa 5/13/1999.
          (return-from %io-buffer-read-byte nil)))
   (prog1
      (%get-unsigned-byte (io-buffer-inptr io-buffer))
      (%incf-ptr (io-buffer-inptr io-buffer))
      (setf (io-buffer-bytes-read io-buffer)    ; (incf (the fixnum ...)) does an overflow check
               (the fixnum (1+ (the fixnum (io-buffer-bytes-read io-buffer)))))
      (setf (io-buffer-incount io-buffer) (the fixnum (1- (the fixnum (io-buffer-incount io-buffer)))))))

(defun io-buffer-read-byte (io-buffer &optional errorp)
  (with-io-buffer-locked (io-buffer)
    (%io-buffer-read-byte io-buffer errorp)))

(declaim (inline %io-buffer-read-untyi-char))

(defun %io-buffer-read-untyi-char (io-buffer)
   (declare (optimize (speed 3) (safety 0)))
   (let ((char (io-buffer-untyi-char io-buffer)))
      (when char
          (setf (io-buffer-untyi-char io-buffer) nil
                   (io-buffer-bytes-read io-buffer) (the fixnum (1+ (the fixnum (io-buffer-bytes-read io-buffer))))))
      char))

(declaim (inline io-buffer-tyi))

(defun %io-buffer-tyi (io-buffer)
   (declare (optimize (speed 3) (safety 0)))
   (let ((byte (%io-buffer-read-byte io-buffer nil)))
      (and byte (%code-char byte))))

(declaim (inline io-buffer-tyi))

(defun io-buffer-tyi (io-buffer &optional (dont-type-check))
   (unless dont-type-check
      (unless (typep io-buffer 'io-buffer)
         (setq io-buffer (require-type io-buffer 'io-buffer))))
   (locally (declare (optimize (speed 3) (safety 0)))
      (with-io-buffer-locked (io-buffer)
          (if (io-buffer-untyi-char io-buffer)
             (prog1 (io-buffer-untyi-char io-buffer)
                (setf (io-buffer-untyi-char io-buffer) nil
                         (io-buffer-bytes-read io-buffer) 
                         (the fixnum (1+ (the fixnum (io-buffer-bytes-read io-buffer))))))
             (let ((byte (%io-buffer-read-byte io-buffer nil)))
                (and byte (%code-char byte)))))))

(defmethod stream-tyi ((stream buffered-character-input-stream-mixin))
  (io-buffer-tyi (stream-io-buffer stream) t))

#| ;; let em be the default
(defmethod stream-element-type ((stream buffered-character-input-stream-mixin))
  'base-character)

(defmethod stream-element-type ((stream buffered-character-output-stream-mixin))
  'base-character)
|#

(defmethod stream-clear-input ((stream buffered-character-input-stream-mixin))
   (using-stream-io-buffer (io-buffer stream :speedy t)
      (setf (io-buffer-incount io-buffer) 0
               (io-buffer-untyi-char io-buffer) nil)
      (%io-buffer-advance io-buffer nil nil)))

(defvar *buffered-character-input-stream-mixin-class*
  (find-class 'buffered-character-input-stream-mixin))

(defmethod stream-reader ((stream buffered-character-input-stream-mixin))
  (maybe-default-stream-reader (stream *buffered-character-input-stream-mixin-class*)
    (values #'io-buffer-tyi (stream-io-buffer stream))))

(defmethod stream-untyi ((stream buffered-character-input-stream-mixin) char)
   (using-stream-io-buffer (io-buffer stream :speedy t)
      (if (io-buffer-untyi-char io-buffer)
         (error "Two untyi's in a row")
         (setf (io-buffer-untyi-char io-buffer) char
                  (io-buffer-bytes-read io-buffer)
                  (the fixnum (1- (the fixnum (io-buffer-bytes-read io-buffer)))))))
   char)

;; this is stupid - have one method on buffered-input-stream-mixin instead
(defmethod stream-untyi ((stream buffered-binary-input-stream-mixin) char)
   (using-stream-io-buffer (io-buffer stream :speedy t)
      (if (io-buffer-untyi-char io-buffer)
         (error "Two untyi's in a row")
         (setf (io-buffer-untyi-char io-buffer) char
                  (io-buffer-bytes-read io-buffer)
                  (the fixnum (1- (the fixnum (io-buffer-bytes-read io-buffer)))))))
   char) 

(defmethod stream-read-byte ((stream buffered-binary-input-stream-mixin))
  (using-stream-io-buffer (io-buffer stream :speedy t)
    (%io-buffer-read-byte io-buffer nil)))

(defmethod stream-tyi ((stream buffered-binary-input-stream-mixin)) ;; ??? - or error
  (io-buffer-tyi (stream-io-buffer stream) t))

(defmethod stream-eofp ((stream buffered-input-stream-mixin))
  (let ((io-buffer (stream-io-buffer stream)))
    (and (eql 0 (io-buffer-incount io-buffer))
         (locally (declare (optimize (speed 3) (safety 0)))
           (with-io-buffer-locked (io-buffer)
             (funcall (io-buffer-eofp-function io-buffer) stream io-buffer))))))

(defmethod stream-listen ((stream buffered-input-stream-mixin))
  (let ((io-buffer (stream-io-buffer stream)))
    (or (not (eql 0 (io-buffer-incount io-buffer)))
        (io-buffer-untyi-char io-buffer)
        (locally (declare (optimize (speed 3) (safety 0)))
          (with-io-buffer-locked (io-buffer)
            (funcall (io-buffer-listen-function io-buffer) stream io-buffer))))))

(defmethod stream-element-type ((stream buffered-binary-input-stream-mixin))
  '(unsigned-byte 8))

(defmethod stream-element-type ((stream buffered-binary-output-stream-mixin))
  '(unsigned-byte 8))

(declaim (inline io-buffer-inpos))

(defun io-buffer-inpos (io-buffer)
  (%ptr-difference (io-buffer-inptr io-buffer) (io-buffer-inbuf io-buffer)))

(declaim (inline io-buffer-outpos))

(defun io-buffer-outpos (io-buffer)
  (%ptr-difference (io-buffer-outptr io-buffer) (io-buffer-outbuf io-buffer)))

(declaim (inline %io-buffer-force-output))

(defun %io-buffer-force-output (io-buffer finish-p)
  (funcall (io-buffer-force-output-function io-buffer)
           (io-buffer-stream io-buffer)
           io-buffer
           (io-buffer-outpos io-buffer)
           finish-p))

(defun flush-io-buffer (io-buffer finish-p)
  (with-io-buffer-locked (io-buffer)
    (%io-buffer-force-output io-buffer finish-p)))

(declaim (inline %io-buffer-write-byte))

(defun %io-buffer-write-byte (io-buffer byte)
  (declare (optimize (speed 3) (safety 0)))
  (when (eql 0 (or (io-buffer-outcount io-buffer) (io-buffer-incount io-buffer)))
    (%io-buffer-force-output io-buffer nil))
  (setf (%get-byte (io-buffer-outptr io-buffer)) byte)
  (%incf-ptr (io-buffer-outptr io-buffer))
  (setf (io-buffer-bytes-written io-buffer)
        (the fixnum (1+ (the fixnum (io-buffer-bytes-written io-buffer)))))
  (if (io-buffer-outcount io-buffer)
    (setf (io-buffer-outcount io-buffer)
          (the fixnum (1- (the fixnum (io-buffer-outcount io-buffer)))))
    (setf (io-buffer-incount io-buffer)
          (the fixnum (1- (the fixnum (io-buffer-incount io-buffer))))
          (io-buffer-untyi-char io-buffer) nil))
  byte)

(defmethod stream-tyo ((stream buffered-character-output-stream-mixin) char)
  (using-stream-io-buffer (io-buffer stream :speedy t)
    (let ((code (char-code char)))
      (declare (fixnum code))
      (if (> code #xff)
        (progn
          (%io-buffer-write-byte io-buffer (ash code -8))
          (setq code (logand code #xff))))
      (%io-buffer-write-byte io-buffer code))))

(defmethod stream-clear-output ((stream buffered-output-stream-mixin))  ;; was  buffered-character-...  (using-stream-io-buffer (io-buffer stream :speedy t)     (let ((outsize (io-buffer-outsize io-buffer)))      (decf (io-buffer-bytes-written io-buffer) (io-buffer-outpos io-buffer))      (setf (io-buffer-outcount io-buffer)            (io-buffer-outbuf-size io-buffer) ; # should it use outsize if non-nil?            #+ignore (or outsize 0))) ; setting io-buffer-outbuf-size to 0 leads to an endless loop when advancing the stream    (%setf-macptr (io-buffer-outptr io-buffer) (io-buffer-outbuf io-buffer))))

(defvar *buffered-character-output-stream-mixin-class*
  (find-class 'buffered-character-output-stream-mixin))

(defvar *buffered-binary-output-stream-mixin-class*
  (find-class 'buffered-binary-output-stream-mixin))

(defvar *buffered-binary-input-stream-mixin-class*
  (find-class 'buffered-binary-input-stream-mixin))



(defmethod stream-writer ((stream buffered-character-output-stream-mixin))
  (maybe-default-stream-writer (stream *buffered-character-output-stream-mixin-class*)
    (flet ((io-buffer-tyo (io-buffer char)
             (unless (typep io-buffer 'io-buffer)
               (setq io-buffer (require-type io-buffer 'io-buffer)))
             (with-io-buffer-locked (io-buffer)
               (%io-buffer-write-byte io-buffer (char-code char)))))
      (values #'io-buffer-tyo (stream-io-buffer stream)))))

;; classes were a little screwed up here - opentransport-binary-tcp-stream inherited from buffered-character-output-stream-mixin
;; before buffered-binary-output-stream-mixin - fixed - hope nothing else breaks
;; Why is buffered-character-output-stream-mixin there at all???
 
(defmethod stream-writer ((stream buffered-binary-output-stream-mixin))
  (maybe-default-stream-binary-writer (stream *buffered-binary-output-stream-mixin-class*)
    (flet ((io-buffer-tyo2 (io-buffer code)
             (unless (typep code 'fixnum)
               (if (characterp code)
                 (setq code (char-code code))  ;; ??? - i think it should be an error 
                 (setq code (require-type code 'fixnum))))
             (unless (typep io-buffer 'io-buffer)
               (setq io-buffer (require-type io-buffer 'io-buffer)))
             (with-io-buffer-locked (io-buffer)
               (%io-buffer-write-byte io-buffer code))))
      (values #'io-buffer-tyo2 (stream-io-buffer stream)))))

(defmethod stream-reader ((stream buffered-binary-input-stream-mixin))
  (maybe-default-stream-binary-reader (stream *buffered-binary-input-stream-mixin-class*)
    (values #'io-buffer-read-byte (stream-io-buffer stream))))

;; same as for buffered-character... should this be here or let it error?
(defmethod stream-tyo ((stream buffered-binary-output-stream-mixin) char)
  (using-stream-io-buffer (io-buffer stream :speedy t)
    (let ((code (char-code char)))
      (declare (fixnum code))
      (if (> code #xff)
        (progn
          (%io-buffer-write-byte io-buffer (ash code -8))
          (setq code (logand code #xff))))
      (%io-buffer-write-byte io-buffer code))))
    

(defmethod stream-force-output ((stream buffered-output-stream-mixin))
  (using-stream-io-buffer (io-buffer stream :speedy t)
    (%io-buffer-force-output io-buffer nil)))

(defmethod stream-finish-output ((stream buffered-output-stream-mixin))
  (using-stream-io-buffer (io-buffer stream :speedy t)
    (%io-buffer-force-output io-buffer t)))



(eval-when (:compile-toplevel :execute)

(unless (fboundp '%copy-ivector-to-ptr)
  (declaim (ftype (function) %copy-ivector-to-ptr)))

)

(unless (fboundp '%copy-ivector-to-ptr)

; 3.1, 3.9, and 4.0 have fast versions of this.
; This version is for older lisps that don't have it.
(defun %copy-ivector-to-ptr (ivector ivector-start ptr ptr-start bytes)
  (declare (type (simple-array unsigned-byte (*)) ivector)
           (type fixnum ivector-start ptr-start bytes)
           (optimize (speed 3) (safety 0) (debug 0)))
  ivector ivector ivector ivector
  ivector-start ivector-start ivector-start
  ptr ptr ptr ptr
  ptr-start ptr-start ptr-start
  bytes bytes bytes bytes
  (dotimes (i bytes)
    (setf (%get-byte ptr ptr-start) (aref ivector ivector-start))
    (incf ivector-start)
    (incf ptr-start)))

)

(defmethod stream-write-byte ((stream buffered-binary-output-stream-mixin) byte)
  (unless (fixnump byte)(setq byte (require-type byte 'fixnum)))
  (using-stream-io-buffer (io-buffer stream :speedy t)
    (%io-buffer-write-byte io-buffer byte)))

(defmethod stream-write-string ((stream buffered-output-stream-mixin) string start end)
  (%io-buffer-stream-write-string stream string start end))

(defmethod stream-write-vector ((stream buffered-binary-output-stream-mixin) string start end)
  (%io-buffer-stream-write-string stream string start end))

(defun %io-buffer-stream-write-string (stream string start end)
   (let ((length (length string)))
      (declare (fixnum length))
      (unless (and (fixnump start)
                         (locally (declare (type fixnum start))
                            (and (>= start 0) (<= start length))))
         (setq start (require-type start `(integer 0 ,length))))
      (unless (and (fixnump end) 
                         (locally (declare (type fixnum end start))
                            (and (>= end start) (<= end length))))
         (setq end (require-type end `(integer ,start ,length)))))
   (using-stream-io-buffer (io-buffer stream :speedy t)
    (locally (declare (type fixnum start end))
      (multiple-value-bind (arr offset) (array-data-and-offset string)
        (declare (type fixnum offset))
        (if (or (simple-base-string-p arr)(typep arr '(simple-array (unsigned-byte 8)))) 
          (let ((bytes (- end start)))
            (declare (type fixnum bytes))
            (incf start offset)
            (incf end offset)
            (loop
              (when (<= bytes 0) (return))
              (let ((outcount (io-buffer-outcount io-buffer)))
                (declare (fixnum outcount))
                (if (>= outcount bytes)
                  (progn
                    (%copy-ivector-to-ptr arr start (io-buffer-outptr io-buffer) 0 bytes)
                    (%incf-ptr (io-buffer-outptr io-buffer) bytes)
                    (setf (io-buffer-outcount io-buffer)
                          (the fixnum (- outcount bytes))
                          (io-buffer-bytes-written io-buffer)
                          (the fixnum (+ (the fixnum (io-buffer-bytes-written io-buffer)) bytes)))
                    (return))
                  (progn
                    (unless (eql 0 outcount)
                      (%copy-ivector-to-ptr arr start (io-buffer-outptr io-buffer) 0 outcount)
                      (%incf-ptr (io-buffer-outptr io-buffer) outcount)
                      (setf (io-buffer-outcount io-buffer) 0
                            (io-buffer-bytes-written io-buffer)
                            (the fixnum (+ (the fixnum (io-buffer-bytes-written io-buffer)) outcount)))
                      (decf bytes outcount)
                      (incf start outcount))
                    (%io-buffer-force-output io-buffer nil))))))
          (if (or (simple-extended-string-p arr)(typep arr '(simple-array (unsigned-byte 16))))
            (locally (declare (type (simple-array (unsigned-byte 16) (*)) arr)) ;simple-extended-string arr)) 
              (let ((nchars (- end start)))
                (declare (fixnum nchars))
                (incf start offset)
                (loop 
                  (when (<= nchars 0)
                    (%io-buffer-force-output io-buffer nil)
                    (return))                    
                  (let ((c (aref arr start)))
                    (declare (fixnum c))
                    (if (> c #xff)
                      (progn
                        (%io-buffer-write-byte io-buffer (ash c -8))
                        (setq c (logand c #xff))))
                    (%io-buffer-write-byte io-buffer c))
                  (decf nchars)
                  (incf start))))
            (error "Illegal string argument ~s for stream-write-string/vector." string)))))))

(defun %io-buffer-write-ptr (io-buffer ptr start bytes)
   (unless (fixnump start)
      (setq start (require-type start 'fixnum)))
   (unless (fixnump bytes)
      (setq bytes (require-type bytes 'fixnum)))
   (locally (declare (type fixnum start bytes))
      (with-macptrs ((ptr (%inc-ptr ptr start)))
          (loop
             (when (<= bytes 0) (return))
             (let ((outcount (io-buffer-outcount io-buffer)))
                (declare (fixnum outcount))
                (if (>= outcount bytes)
                   (progn
                      (#_BlockMoveData ptr (io-buffer-outptr io-buffer) bytes)
                      (%incf-ptr ptr bytes)
                      (%incf-ptr (io-buffer-outptr io-buffer) bytes)
                      (setf (io-buffer-outcount io-buffer)
                               (the fixnum (- outcount bytes))
                               (io-buffer-bytes-written io-buffer)
                               (the fixnum (+ (the fixnum (io-buffer-bytes-written io-buffer)) bytes)))
                      (return))
                   (progn
                      (unless (eql 0 outcount)
                         (#_BlockMoveData ptr (io-buffer-outptr io-buffer) outcount)
                         (%incf-ptr ptr outcount)
                         (%incf-ptr (io-buffer-outptr io-buffer) outcount)
                         (setf (io-buffer-outcount io-buffer) 0
                                  (io-buffer-bytes-written io-buffer)
                                  (the fixnum (+ (the fixnum (io-buffer-bytes-written io-buffer)) bytes)))
                         (decf bytes outcount))
                      (%io-buffer-force-output io-buffer nil))))))))

(declaim (inline %io-buffer-stream-write-ptr))

(defun %io-buffer-stream-write-ptr (stream ptr start bytes)
   (using-stream-io-buffer (io-buffer stream :speedy t)
      (%io-buffer-write-ptr io-buffer ptr start bytes)))

(defmethod stream-write-ptr ((stream buffered-output-stream-mixin) ptr start bytes)
  (%io-buffer-stream-write-ptr stream ptr start bytes)) 

(defun io-buffer-write-file (io-buffer pathname &optional (start 0) end)
   (with-fsopen-file (pb pathname)
       (let* ((write-buf (io-buffer-outbuf io-buffer))
                 (filesize (the integer (geteof pb))))
          ;; check for bad arguments
          (when (or (< start 0) (> start filesize))   ;; was >=
              (error "Start index of ~s is not between 0 & ~s" start filesize))
          (if end
             (when (or (< end start) (> end filesize))      ; fixed -- JCMa 7/25/1997. RJ
                 (error "End index of ~s is not between ~s and ~s" end start filesize))
             (setq end filesize))
          (setfpos pb start)        ;set file position
          (with-io-buffer-locked (io-buffer)
              (%io-buffer-force-output io-buffer nil)         ; ensure that the buffer is empty
              (let ((bytes-left (- end start)))
                 (loop
                    (when (<= bytes-left 0) (return))
                    (let ((bytes (min (io-buffer-outcount io-buffer) bytes-left)))
                       (fsread pb bytes write-buf)
                       (decf bytes-left bytes)
                       (decf (io-buffer-outcount io-buffer) bytes)
                       (incf (io-buffer-bytes-written io-buffer) bytes)
                       (%setf-macptr (io-buffer-outptr io-buffer) (%inc-ptr write-buf bytes))
                       (%io-buffer-force-output io-buffer nil)))))))) 

(defun %io-buffer-read-bytes-to-file (io-buffer pathname bytes &optional (start 0))
   (create-file pathname :if-exists :error)
   (with-fsopen-file (pb pathname t)
       (unless (zerop start)
          (setfpos pb start))
       (with-io-buffer-locked (io-buffer)
           (loop with bytes-remaining = bytes
	            until (eql 0 bytes-remaining)
	            while (if (eql 0 (io-buffer-incount io-buffer))
                                (%io-buffer-advance io-buffer t t)    ; eof may be signalled through this -- JCMa 5/13/1999.
                                t)
	            for read-buffer =  (io-buffer-inptr io-buffer)
	            for buffer-size = (min (io-buffer-incount io-buffer) bytes-remaining)
	            do (fswrite pb buffer-size read-buffer)
                    (%incf-ptr read-buffer buffer-size)
                    (decf bytes-remaining buffer-size)
                    (decf (io-buffer-incount io-buffer) buffer-size)
                    (incf (io-buffer-bytes-read io-buffer) buffer-size)))))

(defun %io-buffer-read-bytes-to-file-stream (io-buffer stream bytes)
   (let* ((column.fblock (column.fblock stream))
             (fblock (cdr column.fblock))
             (pb (%fblock.pb fblock)))
      (with-io-buffer-locked (io-buffer)
          (loop with bytes-remaining = bytes
                   until (eql 0 bytes-remaining)
                   while (if (eql 0 (io-buffer-incount io-buffer))
                               (%io-buffer-advance io-buffer t t)
                               t)
                   for read-buffer =  (io-buffer-inptr io-buffer)
                   for buffer-size = (min (io-buffer-incount io-buffer) bytes-remaining)
                   do (fswrite pb buffer-size read-buffer)
                   (%incf-ptr read-buffer buffer-size)
                   (decf bytes-remaining buffer-size)
                   (decf (io-buffer-incount io-buffer) buffer-size)
                   (incf (io-buffer-bytes-read io-buffer) buffer-size)))))

(defun io-buffer-read-bytes-to-file (io-buffer pathname bytes &optional (start 0))
  (let* ((tmp-file (when (probe-file pathname) (gen-file-name pathname)))
	 (win-p nil))
    (cond (tmp-file
	   (unwind-protect 
             (progn (rename-file pathname tmp-file :if-exists :error)
                    (%io-buffer-read-bytes-to-file io-buffer pathname bytes start)
                    (setq win-p t))
	     (if win-p 
               (delete-file tmp-file)
               (rename-file tmp-file pathname :if-exists :supersede))))
	  (t (%io-buffer-read-bytes-to-file io-buffer pathname bytes start))))) 

(declaim (inline %io-buffer-read-bytes-to-vector))

(defun %io-buffer-read-bytes-to-vector (io-buffer vector bytes start)
   (loop with fill-pointer = start
            with bytes-remaining = bytes
            until (eql 0 bytes-remaining)
            while (if (eql 0 (io-buffer-incount io-buffer))
                        (%io-buffer-advance io-buffer t t)        ; eof may be signalled through this -- JCMa 5/13/1999.
                        t)
            for buffer =  (io-buffer-inptr io-buffer)
            for read-bytes = (min (io-buffer-incount io-buffer) bytes-remaining)
            do (%copy-ptr-to-ivector buffer 0 vector fill-pointer read-bytes)                
            (incf fill-pointer read-bytes)
            (%incf-ptr (io-buffer-inptr io-buffer) read-bytes) ;; <<
            (decf bytes-remaining read-bytes)
            (decf (io-buffer-incount io-buffer) read-bytes)
            (incf (io-buffer-bytes-read io-buffer) read-bytes)))

(defun io-buffer-read-bytes-to-vector (io-buffer vector bytes &optional (start 0))
   (require-type io-buffer 'io-buffer)
   (with-io-buffer-locked (io-buffer)
       (multiple-value-bind (v v-offset) 
                                       (array-data-and-offset vector)
           (%io-buffer-read-bytes-to-vector io-buffer v bytes (+ start v-offset)))))

(defmethod stream-read-bytes-to-vector ((stream buffered-output-stream-mixin) vector bytes &optional (start 0))
   (io-buffer-read-bytes-to-vector (stream-io-buffer stream) vector bytes start))

(defun io-buffer-inbuf-size (io-buffer)
  (unless (typep io-buffer 'io-buffer)
    (setq io-buffer (require-type io-buffer 'io-buffer)))
  (or (io-buffer-insize io-buffer)
      (with-io-buffer-locked (io-buffer)
       (+ (io-buffer-incount io-buffer)
          (io-buffer-inpos io-buffer)))))

(defun io-buffer-outbuf-size (io-buffer)
  (unless (typep io-buffer 'io-buffer)
    (setq io-buffer (require-type io-buffer 'io-buffer)))
  (or (io-buffer-outsize io-buffer)
      (with-io-buffer-locked (io-buffer)
       (+ (io-buffer-outcount io-buffer)
          (io-buffer-outpos io-buffer)))))

; This is useful for io-buffer-flush-output methods to
; determine how many characters are in the output buffer.

(defun %ptr-difference (p1 p2)
  (%%ptr-difference (require-type p1 'macptr) (require-type p2 'macptr)))

#+ppc-target
(defppclapfunction %%ptr-difference ((p1 arg_y) (p2 arg_z))
  (check-nargs 2)
  (macptr-ptr imm0 p1)
  (macptr-ptr imm1 p2)
  (sub imm0 imm0 imm1)
  (mtxer rzero)
  (addo imm1 imm0 imm0)
  (addo. arg_z imm1 imm1)
  (bnslr)
  (ba .SPbox-signed))


#-ppc-target
(defun %%ptr-difference (p1 p2)
  (lap-inline ()
    (:variable p1 p2)
    (move.l (varg p1) atemp0)
    (move.l (svref atemp0 macptr.ptr) acc)
    (move.l (varg p2) atemp0)
    (sub.l (svref atemp0 macptr.ptr) acc)
    (jsr_subprim $sp-mklong)))

(provide "IO-BUFFER")


#|

; Example
; Put a second level of buffering on a file stream
; This allows input or output only, not both.
; To do both requires a little more smarts about sharing the buffer.

(defclass my-file-stream (buffered-character-io-stream-mixin)
  ((stream :accessor my-file-stream-stream
           :initarg :stream)))

(defmethod my-open (file &rest open-keys)
  (let ((stream (apply 'open file open-keys)))
    (make-instance 'my-file-stream :stream stream
                   :insize 10
                   :outsize 10)))

(defmethod stream-close ((stream my-file-stream))
  (force-output stream)
  (close (my-file-stream-stream stream)))

(defmethod io-buffer-advance ((stream my-file-stream) io-buffer readp &optional errorp)
   (declare (ignore readp errorp))
   (let* ((ptr (io-buffer-inbuf io-buffer))
             (size (io-buffer-insize io-buffer))
             (file-stream (my-file-stream-stream stream))
             (count (dotimes (i size size)
                           (let ((char (stream-tyi file-stream)))
                              (unless char
                                 (return i))
                              (setf (%get-byte ptr i) (char-code char))))))
      (%setf-macptr (io-buffer-inptr io-buffer) ptr)  ; added this
      (setf (io-buffer-incount io-buffer) count)
      (unless (eql count 0)
         count)))

(defmethod io-buffer-listen ((stream my-file-stream) io-buffer)
  (declare (ignore io-buffer))
  (stream-listen (my-file-stream-stream stream)))

(defmethod io-buffer-eofp ((stream my-file-stream) io-buffer)
  ;(declare (ignore io-buffer))
  (and (stream-eofp (my-file-stream-stream stream))
       (null (io-buffer-untyi-char io-buffer)) ; added these
       (eql 0 (io-buffer-incount io-buffer))))

(defmethod io-buffer-force-output ((stream my-file-stream) io-buffer count finish-p)
  (let* ((outbuf (io-buffer-outbuf io-buffer))
         (file-stream (my-file-stream-stream stream)))
    (dotimes (i count)
      (stream-tyo file-stream (code-char (%get-unsigned-byte outbuf i))))
    (when finish-p
      (stream-finish-output file-stream))
    (%setf-macptr (io-buffer-outptr io-buffer) outbuf) ; added this
    (setf (io-buffer-outcount io-buffer) (io-buffer-outsize io-buffer))))

; This should return '("line1" "line2")
(defun test-my-file-stream ()
  (let ((stream (my-open "temp.temp" :if-exists :supersede :direction :output)))
    (unwind-protect
      (progn
        (write-line "line1" stream)
        (write-line "line2" stream))
      (close stream)))
  (let ((stream (my-open "temp.temp" :direction :input)))
    (unwind-protect
      ;(loop while (peek-char nil stream nil nil) collect  (read-char-no-hang stream nil nil))
      (loop
        until (eofp stream)
        collect (read-line stream))
      (close stream))))

(with-open-file (stream "temp.temp" :if-exists :supersede :direction :output :element-type '(unsigned-byte 8))
  (print (type-of stream)) ; output-binary-file-stream
  (format stream "~s" "asdf") ; errors
  (stream-tyo stream #\c)  ; works
  )

|#
