;;-*- Mode: Lisp; Package: CCL -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; eval-server.lisp
;; Copyright 1990-1994, Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;;
;;
;;  handle eval, dosc and scpt AppleEvents
;;
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Change History
;; disposhandle => disposehandle
;; ----
;;  5/03/96 bill  eval-handler detects a null reply AEDesc as generated
;;                by the "ignoring application responses ... end ignoring"
;;                AppleScript.
;;  ------------  MCL-PPC 3.9
;;  6/01/91       New.
;;

; MCL responds to 'dosc' and 'eval' identically, i.e. it reads the string from the
; direct parameter of the appleevent, evals it, and puts the answer as a string
; in the direct parameter of the reply.
;

(in-package "CCL")

(require :appleevent-toolkit)

(declaim (ftype (function (&rest t) t) ccl::get-transaction-id)
         (ftype (function (&rest t) t) ccl::get-sender-address)
         (ftype (function (&rest t) t) ccl::send-appleevent)
         (ftype (function (&rest t) t) ccl::create-appleevent))

(defmethod eval-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore handlerRefcon))
  (let ((what (ae-get-parameter-char theAppleEvent #$keyDirectObject t)))
    (check-required-params "unexpected parameters in scpt" theAppleEvent)
    (let ((res (eval (read-from-string what))))
      (unless (eq #$typeNull (pref reply :AEDesc.descriptorType))
        (ae-put-parameter-char reply #$keyDirectObject 
                               (write-to-string res))))))

(install-appleevent-handler :|misc| :|dosc| #'eval-handler)
(install-appleevent-handler :|misc| :|eval| #'eval-handler)


; handle MPW 'scpt' events. Any output to *standard-output* or *error-output*
; is sent back as outp events.

(defclass outp-stream (output-stream)
  ((transaction-id :initarg :transaction-id)
   (target :initarg :target)
   (datahandle :initform (#_NewHandle 1024))
   (output-position :initform 0)
   ))

(defmethod stream-force-output ((s outp-stream))
  (with-slots (datahandle output-position transaction-id target) s
    (unless (eql 0 output-position)
      (with-aedescs (AppleEvent reply)
        (create-appleevent AppleEvent :|MPS | :|outp| target
                           :transaction-id transaction-id)
        (with-dereferenced-handles ((p datahandle))
          (ae-error
            (#_AEPutParamPtr AppleEvent #$keyDirectObject #$typeChar p output-position)))
        (send-appleevent AppleEvent reply)
        (setf output-position 0)))))

(defmethod stream-tyo ((s outp-stream) c)
  (without-interrupts 
   (with-slots (datahandle output-position) s
     (when (eql 1024 output-position)
       (stream-force-output s))
     (%hput-byte datahandle (char-code c) output-position)
     (incf output-position))))

(defmethod stream-close :before ((s outp-stream))
           (without-interrupts
            (stream-force-output s))
           (with-slots (datahandle target) s
             (#_DisposeHandle datahandle)
             (setf datahandle nil)
             (setf target nil)))

(defmethod scpt-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore reply handlerRefcon))
  (with-aedescs (return-target)
    (let ((what (ae-get-parameter-char theAppleEvent #$keyDirectObject t)))
      (check-required-params "unexpected parameters in scpt" theAppleEvent)
      (let* ((who (get-sender-address theAppleEvent return-target))
             (stream (make-instance 'outp-stream
                                    :target who
                                    :transaction-id (get-transaction-id theAppleEvent)))
             (*standard-output* stream)
             (*error-output* stream))
        (handler-case (format t "~s~&" (eval (read-from-string what)))
          (error (c) (report-condition c *error-output*)
                 (stream-fresh-line *error-output* )))
        (close stream)))))

(install-appleevent-handler :|MPS | :|scpt| #'scpt-handler)



#| some testing code:

(with-aedescs (event reply target)
  (create-self-target target)
  (create-appleevent event :|misc| :|dosc| target)
  (ae-put-parameter-char event #$keyDirectObject "(+ 1 2)")
  (send-appleevent event reply :reply-mode :wait-reply)
  (ae-get-parameter-char reply #$keyDirectObject t))

|#
  

(provide :eval-server)
