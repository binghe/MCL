;;-*- Mode: Lisp; Package: CCL -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; serial-streams.lisp
;; Copyright 1990-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;;
;The following knowledge is helpful in understanding the code:
;;   Use of Macintosh Drivers and Serial Ports
;;   Use of the MCL low-level system interface
;;   Use of MCL stream implementation
;;

; 03/06/92 bill add output-serial-stream & input-serial-stream
;               so that we inherit stream-clear-output, stream-fresh-line,
;               stream-clear-output, stream-force-output
; ------------- 2.0f3
; 02/25/91 bill Fix stop-bit computation.
; Joe 7/90: CLOS (MCL 2.0a2) version using new records. Streams are automatically
; opened when they are created.
;

(in-package :ccl)

(eval-when (:execute :compile-toplevel :load-toplevel)
  (require 'driver)
  
  (export '(serial-stream set-serial-port set-hand-shake serial-status
            SerSetBuf SerSetBrk SerClrBrk SerGetBuf
            *serial-a* *serial-a-in* *serial-a-out*
            *serial-b* *serial-b-in* *serial-b-out*
            make-serial-a dispose-serial-a
            make-serial-b dispose-serial-b)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;Serial Streams
;;
;;Serial Streams inherit from drivers.
;;
;;They provide a stream interface to some specific drivers on the Macintosh,
;;  namely, the serial drivers.
;;

(defclass serial-stream (driver stream)    ;define the new class
  ((serial-unread-char :initform nil))
  (:default-initargs :driver-buffer-size 4))

(defclass input-serial-stream (serial-stream input-stream) ())
(defclass output-serial-stream (serial-stream output-stream) ())

(defmethod initialize-instance :after ((s serial-stream) &rest initargs)
  (declare (ignore initargs))
  (stream-open s))

(defmethod stream-open ((s serial-stream))
  (with-slots (serial-unread-char) s
    (setf serial-unread-char nil)
    (driver-open s)))

(defmethod stream-tyo ((s serial-stream) char)
  (with-slots (driver-buffer) s
    (%put-byte driver-buffer (char-code char))
    (driver-write s 1)))

(defmethod stream-tyi ((s serial-stream))
  (with-slots (driver-buffer serial-unread-char) s
    (if serial-unread-char                   ; if a character has been 'unread'
      (prog1 serial-unread-char              ; return it, and set unread-char
        (setq serial-unread-char nil))       ; to nil
      (progn 
        (driver-read s 1)
        (code-char (%get-byte driver-buffer))))))

(defmethod stream-untyi ((s serial-stream) char)    ; function 'unreads' a char
  (with-slots (driver-open-p serial-unread-char) s
    (unless driver-open-p                    ; error if driver not open
      (error "Stream: ~s is not open" s))
    (setf serial-unread-char char)))         ; just store the unread char

(defmethod stream-eofp ((s serial-stream))   ; always more in the default method
  nil)

(defmethod stream-listen ((s serial-stream))
  (with-slots (driver-open-p driver-cspb serial-unread-char) s
    (unless driver-open-p                    ; error if driver not open
      (error "Stream: ~s is not open" s))
    (or serial-unread-char
        (progn
          (driver-status s 2)
          (neq 0 (%get-long driver-cspb $csParam-offset))))))

(defmethod stream-clear-input ((s serial-stream))
  (do ()
      ((not (stream-listen s)))
    (stream-tyi s)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;set-serial-port
;;
;;  used to configure the serial port
;;
;;  Takes keywords  :BAUD
;;                  :STOP
;;                  :PARITY
;;                  :LENGTH
;;
;;  Default values are: 9600 baud, 1 stop bit and parity 0.
;;
;;  This function does fancy argument checking.  It checks all args before
;;  erroring on any single one of them.
;;

(defmethod set-serial-port ((s serial-stream)
                            &key (baud 9600) (stop 1) (parity 0) (length 8))
  (with-slots (driver-open-p driver-cspb) s
    (unless driver-open-p                    ; error if driver not open
      (error "Driver: ~s is not open" s))
    (let ((bad-args nil)
          (config (case (floor length)
                      (5 0)
                      (7 1024)
                      (6 2048)
                      (8 3072)))
          (%baud (floor baud))
          (%stop (floor (* 1.5 (coerce stop 'number))))
          (%parity (floor parity)))
      ;Check arguments one at a time.
      (unless config (push `(length ,length) bad-args))
      (unless (<= 112 %baud 57600) (push `(baud ,baud) bad-args))
      (unless (<= 1 %stop 3) (push `(stop ,stop) bad-args))
      (unless (<= 0 %parity 2) (push `(parity ,parity) bad-args))
      (when bad-args
        (error "Invalid argument~p to set-serial-port. ~:{~a: ~s~:[~;, ~]~}"
               (length bad-args)
               (maplist #'(lambda (bad-arg-list)
                            `(,@(car bad-arg-list)
                              ,(> (length bad-arg-list) 1)))
                        bad-args)))
      (setf (rref driver-cspb (ParamBlockRec.csparam 0))
            (+ config (- (round (/ 114750 %baud)) 2)
               (ash (truncate %stop) 14)
               (ash (if (eq %parity 2) 3 %parity) 12)))
      ; (rref driver-cspb (ParamBlockRec.csparam 0)) is an array reference to
      ; the first (of 11) control parameters in the control/status paramblock
      (driver-control s 8)
      t)))

;;;;;;;;;;;;;;;
;;
;;set-hand-shake
;;
;;
;;     When xon-out is true, xon/xoff output flow control is enabled.
;;     When xon-in is true, input flow control is enabled.
;;     If cts-hand-shake is true, CTS hardware hand-shaking is enabled.
;;     xon-char and xoff-char should be the transmit on & off characters
;;     errors indicates which errors cause input requests to be aborted
;;       it should be the sum of the following:
;;          16 for parity errors
;;          32 for hardware overrun errors
;;          64 for framing errors
;;     events indicates whether changes in the CTS or break status will cause
;;       device driver events to be posted;  it should be the sum of the
;;       following
;;          32 if CTS change should generate events
;;          128 if break status change should generate events
;;       Note that these driver events are unsupported and degrade performance.
;;

(defmethod set-hand-shake ((s serial-stream) &key (xon-out nil) (xon-in nil) (cts-hand-shake nil)
                           (xon-char #\^Q) (xoff-char #\^S) (errors 0)
                           (events 0))
  (with-slots (driver-open-p driver-cspb) s
    (unless driver-open-p                     ; error if driver not open
      (error "Driver: ~s is not open" s))                                                 
    (%put-byte driver-cspb (if xon-out 1 0) (+ $csParam-offset 0))
    (%put-byte driver-cspb (if cts-hand-shake 1 0) (+ $csParam-offset 1))
    (%put-byte driver-cspb (char-int xon-char) (+ $csParam-offset 2))
    (%put-byte driver-cspb (char-int xoff-char) (+ $csParam-offset 3))
    (%put-byte driver-cspb errors (+ $csParam-offset 4))
    (%put-byte driver-cspb events (+ $csParam-offset 5))
    (%put-byte driver-cspb (if xon-in 1 0) (+ $csParam-offset 6))
    (driver-control s 10)))

;;;;;;;;;;;;;;;;;;;
;;
;;  serial-status 
;;
;;     This function returns five values giving the current status of the driver.
;;     The first value is a byte indicating which errors have occurred since the 
;;     last time serials-status was called. If it is the sum of the following values:
;;     1 = software overrun, 16 = parity error, 32 = hardware overrun, 64 = framing error.
;;     The remaining four values are booleans indicating in order:
;;     value 2: if there's a read pending
;;     value 3: if there's a write pending
;;     value 4: if output has been suspended by a hardware handshake
;;     value 5: if output has been suspended because of an XOff character was received
;;

(defmethod serial-status ((s serial-stream))
  (with-slots (driver-cspb) s
    (driver-status s 8)
    (values (%get-byte driver-cspb (+ $csParam-offset 0))          ; cumulative errors
            (= #x80 (%get-byte driver-cspb (+ $csParam-offset 1))) ; xoff sent
            (neq 0 (%get-byte driver-cspb (+ $csParam-offset 2)))  ; read pending flag
            (neq 0 (%get-byte driver-cspb (+ $csParam-offset 3)))  ; write pending flag
            (neq 0 (%get-byte driver-cspb (+ $csParam-offset 4)))  ; cts flow control hold flag
            (neq 0 (%get-byte driver-cspb (+ $csParam-offset 5)))  ; xoff flow control hold flag
            )))

;;;;;;;;;;;;;;;;;;;
;;
;;  Define functions for making two way streams for each serial port:
;;  (a is modem, b is printer).
;;

(defvar *serial-a-in* nil)
(defvar *serial-a-out* nil)
(defvar *serial-a* nil)

(defvar *serial-b-in* nil)
(defvar *serial-b-out* nil)
(defvar *serial-b* nil)

(defun make-serial-a (&key (baud 9600) (stop 1) (parity 0) (length 8)
                           (xon-out nil) (xon-in nil) (cts-hand-shake nil)
                           (xon-char #\^Q) (xoff-char #\^S) (errors 0)
                           (events 0))
  (dispose-serial-a)
  (setq *serial-a-in* (make-instance 'input-serial-stream :driver-name ".AIn")
        *serial-a-out* (make-instance 'output-serial-stream :driver-name ".AOut"))
  (set-serial-port *serial-a-in* :baud baud :stop stop :parity parity :length length)
  (set-hand-shake *serial-a-in* :xon-out xon-out :xon-in xon-in :cts-hand-shake cts-hand-shake
                  :xon-char xon-char :xoff-char xoff-char :errors errors :events events)
  (set-serial-port *serial-a-out* :baud baud :stop stop :parity parity :length length)
  (set-hand-shake *serial-a-out* :xon-out xon-out :xon-in xon-in :cts-hand-shake cts-hand-shake
                  :xon-char xon-char :xoff-char xoff-char :errors errors :events events)
  (setq *serial-a* (make-two-way-stream *serial-a-in* *serial-a-out*)))

(defun dispose-serial-a ()
  (when *serial-a*
    (driver-dispose *serial-a-in*)
    (driver-dispose *serial-a-out*)
    (setq *serial-a-in* nil
          *serial-a-out* nil
          *serial-a* nil)))

(defun make-serial-b (&key (baud 9600) (stop 1) (parity 0) (length 8)
                           (xon-out nil) (xon-in nil) (cts-hand-shake nil)
                           (xon-char #\^Q) (xoff-char #\^S) (errors 0)
                           (events 0))
  (dispose-serial-b)
  (setq *serial-b-in* (make-instance 'input-serial-stream :driver-name ".BIn")
        *serial-b-out* (make-instance 'output-serial-stream :driver-name ".BOut"))
  (set-serial-port *serial-b-in* :baud baud :stop stop :parity parity :length length)
  (set-hand-shake *serial-b-in* :xon-out xon-out :xon-in xon-in :cts-hand-shake cts-hand-shake
                  :xon-char xon-char :xoff-char xoff-char :errors errors :events events)
  (set-serial-port *serial-b-out* :baud baud :stop stop :parity parity :length length)
  (set-hand-shake *serial-b-out* :xon-out xon-out :xon-in xon-in :cts-hand-shake cts-hand-shake
                  :xon-char xon-char :xoff-char xoff-char :errors errors :events events)
  (setq *serial-b* (make-two-way-stream *serial-b-in* *serial-b-out*)))

(defun dispose-serial-b ()
  (when *serial-b*
    (driver-dispose *serial-b-in*)
    (driver-dispose *serial-b-out*)
    (setq *serial-b-in* nil
          *serial-b-out* nil
          *serial-b* nil)))

;; Dumplisp stuff:
(pushnew 'dispose-serial-a ccl:*save-exit-functions*)
(pushnew 'dispose-serial-b ccl:*save-exit-functions*)

;;;;;;;;;;;;;;;;;;
;;
;; Other serial driver functions:
;;
;;     These are documented in inside mac (vol II pp 250-255), but you probably
;;     won't need them.
;;
;;

(defmethod SerSetBuf ((s serial-stream) serBPtr serBLen)
  (with-slots (driver-cspb) s
    (%put-ptr driver-cspb serBPtr (+ $csParam-offset 0))
    (%put-word driver-cspb serBLen (+ $csParam-offset 4))
    (driver-control s 9)))

(defmethod SerSetBrk ((s serial-stream))
  (driver-control s 12))

(defmethod SerClrBrk ((s serial-stream))
  (driver-control s 11))

(defmethod SerGetBuf ((s serial-stream))
  (with-slots (driver-cspb) s
    (driver-status s 2)
    (%get-long driver-cspb (+ $csParam-offset 0))))

(provide 'serial-streams)
