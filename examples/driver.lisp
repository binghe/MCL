;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  2 4/19/96  akh  from gb
;;  (do not edit before this line!!)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; driver.lisp
;;
;; Copyright 1988 Coral Software Corp.
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995-1999 Digitool, Inc.

;;
;;  This is an example of how to access the Device Manager's drivers from
;;  MCL.
;;
;The following knowledge is helpful in understanding the code:
;;   Use of Macintosh Drivers (Inside Mac II)
;;   Use of the MCL's low-level system interface
;;   Use of CLOS
;;
;;
;;  You should call driver-dispose on your driver when you are done with it
;;  to free up the memory occupied by the buffers.
;;

;;;;;;;;;;;;;;;;;;;
;;
;; Modification History

;; won't work with OSX
;; ----------------
;; 07/31/99 akh driver-read does stream-listen first.
;;          somewhat less vulnerable to multiple process hangs but definitely not foolproof
;;          previously hung badly if one process did stream listen while another was in driver-read
;; ------- 4.3f1c1 
;; 04/16/96  gb   newfangled trap calls.
;; 12/23/91 bill Joe's mod to driver-dispose to call driver-close vice stream-close
;; Joe 10/90 CLOS 2.0a3 version using new records & traps.
;;           Note: this code used to be in serial-streams
;;

(in-package :ccl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (export '(driver driver-open driver-close driver-dispose driver-control 
            driver-status driver-killio
            driver-name driver-open-p driver-iopb driver-cspb driver-buffer
            set-driver-buffer driver-buffer-size)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;the driver object
;;
;; drivers no longer inherit from streams (but can be used as a mix-in)
;; for a stream (such as serial streams)
;;

(defclass driver ()
  ((driver-name :initarg :driver-name :initform ".????" :reader driver-name)
   (driver-open-p :initform nil :reader driver-open-p)
   (driver-iopb :initform (make-record (:ParamBlockRec :clear t)))
   (driver-cspb :initform (make-record (:ParamBlockRec :clear t)))
   (driver-buffer-size :initform 64 :initarg :driver-buffer-size
                       :reader driver-buffer-size)
   (driver-buffer :initform nil :initarg :driver-buffer :reader driver-buffer)
   (dispose-buffer)))

(defmethod initialize-instance :after ((d driver) &rest initargs)
  (declare (ignore initargs))
  (with-slots (driver-buffer-size driver-buffer) d
    (if driver-buffer
      (set-driver-buffer d driver-buffer nil) ; if buffer supplied install it for real
      (set-driver-buffer d (#_newptr driver-buffer-size) t)))) ; otherwise make a new one

(defmethod set-driver-buffer ((d driver) pointer &optional (dispose nil))
  (with-slots (driver-buffer-size driver-buffer driver-iopb dispose-buffer) d
    (setf driver-buffer pointer
          driver-buffer-size (#_getptrsize pointer)
          dispose-buffer dispose
          (rref driver-iopb ParamBlockRec.ioBuffer) driver-buffer)
    t))

(defmethod driver-dispose ((d driver)) ()
  (with-slots (driver-open-p driver-iopb driver-cspb driver-buffer dispose-buffer) d
    (when driver-open-p
      (driver-close d))   ; vice stream-close
    (when driver-iopb
      (dispose-record driver-iopb)
      (dispose-record driver-cspb)
      (when dispose-buffer 
        (memerror-check (#_DisposePtr driver-buffer)))
      (setq driver-iopb nil
            driver-cspb nil
            driver-buffer nil))))

(defmethod driver-open ((d driver))
  (with-slots (driver-open-p driver-iopb driver-cspb 
                             driver-buffer driver-name) d
    (unless driver-iopb
      (error "Driver: ~s has been disposed" d))  ; check if disposed
    (unless driver-open-p
      (clear-record driver-iopb :paramblockrec)  ; clear the paramblocks
      (clear-record driver-cspb :paramblockrec)  ; and install the right data
      (with-pstrs ((driver-pname driver-name))
        (setf (rref driver-iopb ParamBlockRec.ioNamePtr) driver-pname
              (rref driver-iopb ParamBlockRec.ioBuffer) driver-buffer)
        (errchk (#_pbOpenSync driver-iopb)))  ;; << was pbopensync and shall remain so
      ; put the refnum in the control/status paramblock too!
      (setf (rref driver-cspb ParamBlockRec.ioCRefNum)
            (rref driver-iopb ParamBlockRec.ioRefNum))
      (setq driver-open-p t))))

(defmethod driver-close ((d driver))
  (with-slots (driver-open-p driver-iopb) d
    (unless driver-iopb
      (error "Driver: ~s has been disposed" d)) ; check if disposed
    (when driver-open-p
      (errchk (#_pbClosesync driver-iopb))
      (setf driver-open-p nil))))

; To write the driver, you must first put your data into the buffer
; using %put-long, %put-byte,etc., (or rset if you've have a record 
; declaration for your buffer). Then call driver-write with a number 
; indicating how many bytes are to be written from the buffer.

(defmethod driver-write ((d driver) count)
  (with-slots (driver-open-p driver-iopb) d
    (unless driver-open-p                    ; error if driver not open
      (error "Driver: ~s is not open" d))
    (setf (rref driver-iopb ParamBlockRec.ioReqCount) count)
    (errchk (#_pbWriteSync driver-iopb))))

;; Reading is a lot like writing... You specify how many bytes to read,
;; and call driver-read. Driver-read will hang out until the requested
;; bytes have been read, and will return. It's up to you to dig the data
;; out of the buffer. Driver-read is also an example of an asynchronous 
;; driver call. The reason for doing this is that a synchronous call
;; to the _Read trap hangs until there is input available. Rather than 
;; make an explicit check for input (via stream-listen), we do the read 
;; asynchronously and wait in an abortable loop until the read completes.

#|
(defmethod driver-read ((d driver) count)
  (with-slots (driver-open-p driver-iopb) d
    (unless driver-open-p                    ; error if driver not open
      (error "Driver: ~s is not open" d))
    (setf (rref driver-iopb ParamBlockRec.ioReqCount) count)
    (errchk (#_pbreadAsync driver-iopb)) ; make the async call...
    (let ((result (rref driver-iopb ParamBlockRec.ioResult)))
      (unwind-protect
        (loop                            ; loop until it the result comes back
          (cond ((zerop result)          ; success!!!
                 (return))
                ((= 1 result))           ; still waiting...
                (t                       ; crud.
                 (error "Whoa Dudeness! Driver Read Error! Error = ~d ~
                         ~%Bummer." 
                        (- 65536 result))))
          (setq result (rref driver-iopb ParamBlockRec.ioResult)))
        (unless (zerop result)           ; this stuff only happens when you abort.
          (driver-killio d))))))         ; It seems to prevent random hangs.
|#

(defmethod driver-read ((d driver) count)
  (with-slots (driver-open-p driver-iopb) d
    (unless driver-open-p                    ; error if driver not open
      (error "Driver: ~s is not open" d))
    (setf (rref driver-iopb ParamBlockRec.ioReqCount) count)
    ;(errchk (#_pbreadAsync driver-iopb)) ; make the async call... LATER
    (let (begin
          result)
      (unwind-protect
        (loop
          (when (and (not begin)(stream-listen d))
            (setf (rref driver-iopb ParamBlockRec.ioReqCount) count)
            (setq begin t)
            (errchk (#_pbreadAsync driver-iopb)))
          (when begin
            (setq result (rref driver-iopb ParamBlockRec.ioResult))            
            (cond ((zerop result)          ; success!!!
                   (return))
                  ((= 1 result))           ; still waiting...
                  (t                       ; crud.
                   (error "Whoa Dudeness! Driver Read Error! Error = ~d ~
                           ~%Bummer." 
                          (- 65536 result))))))
        (when (and begin (not (zerop result)))           ; this stuff only happens when you abort.
          (driver-killio d))))))

;; Note that often times, a block of memory in a record is not used
;; as declared in Inside Mac. In stream-listen, for example, the csParam
;; field of the ParamBlockRec record is declared in Inside Mac as an
;; array of 11 words, but it is used as a longword (i.e. only the
;; the first two words are used). The following constant is used to access
;; the beginning of the csParam field:

(defconstant $csParam-offset #.(get-field-offset ParamBlockRec.csParam))

(defmethod driver-control ((D driver) code)
  (with-slots (driver-open-p driver-cspb) d
    (unless driver-open-p                    ; error if driver not open
      (error "Driver: ~s is not open" d))
    (setf (rref driver-cspb ParamBlockRec.csCode) code)
    (errchk (#_pbControlSync driver-cspb))))

(defmethod driver-status ((d driver) code)
  (with-slots (driver-open-p driver-cspb) d
    (unless driver-open-p                    ; error if driver not open
      (error "Driver: ~s is not open" d))
    (setf (rref driver-cspb ParamBlockRec.csCode) code)
    (errchk (#_pbStatusSync driver-cspb))))

(defmethod driver-killio ((d driver))
  (with-slots (driver-open-p driver-iopb) d
    (unless driver-open-p                    ; error if driver not open
      (error "Driver: ~s is not open" d))
    (errchk (#_pbclosesync driver-iopb))
    #+ignore
    (errchk (#_pbKillIOSync driver-iopb))))

(provide :driver)

