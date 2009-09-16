;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  3 3/27/96  akh  dont need call to ed-end-of-buffer or somesuch
;;  2 3/16/96  akh  specialize fred methods on fred-mixin
;;  (do not edit before this line!!)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; toolserver.lisp
;; Copyright 1990-1994, Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;;
;; Example Appleevents interface to Toolserver. To get things going,
;; evaluate: (open-toolserver-io). (Launch toolserver first)
;; If there's a toolserver running, this will automatically connect, otherwise,
;; it will bring up a choose-process-dialog
;;
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Change History
;; 


(in-package :ccl)

(require :appleevent-toolkit)

(declaim (ftype (function (&rest t) t) ccl::get-error-number)
         (ftype (function (&rest t) t) ccl::get-transaction-id)
         (ftype (function (&rest t) t) ccl::get-sender-address)
         (ftype (function (&rest t) t) ccl::send-appleevent)
         (ftype (function (&rest t) t) ccl::find-named-process)
         (ftype (function (&rest t) t) ccl::create-appleevent)
         (ftype (function (&rest t) t) ccl::create-odoc)
         (ftype (function (&rest t) t) ccl::create-psn-target)
         (ftype (function (&rest t) t) ccl::choose-appleevent-target))

(defvar *toolserver-target* nil)
(defvar *toolserver-transaction-id* 0)

(defun choose-toolserver-target ()
  (let ((success nil))
    (unless *toolserver-target*
      (setf *toolserver-target* (make-record (:aeaddressdesc :clear t))))
    (unwind-protect
      (progn
        (choose-appleevent-target *toolserver-target* 
                                  :prompt "Please choose a Toolserver Application")
        (setq success t))
      (unless success
        (forget-toolserver-target)))))

(defun set-toolserver-psn-target (psnhigh psnlow)
  (let ((success nil))
    (unless *toolserver-target*
      (setf *toolserver-target* (make-record (:aeaddressdesc :clear t))))
    (unwind-protect
      (progn
        (create-psn-target *toolserver-target* psnhigh psnlow)
        (setq success t))
      (unless success
        (forget-toolserver-target)))))

(defun verify-toolserver-target ()
  (unless *toolserver-target*
    (multiple-value-bind (psnhigh psnlow)
                         (find-named-process "ToolServer")
      (if psnhigh
        (set-toolserver-psn-target psnhigh psnlow)
        (choose-toolserver-target)))))

(defun forget-toolserver-target ()
  (when *toolserver-target*
    (dispose-record *toolserver-target* :aeaddressdesc)
    (setq *toolserver-target* nil)))

(defun send-toolserver-script (text)
  (verify-toolserver-target)
  (with-aedescs (ae reply)
    (create-appleevent ae :|MPS | :|scpt| *toolserver-target*
                       :transaction-id (incf *toolserver-transaction-id*))
    (ae-put-parameter-char ae #$keyDirectObject text)
    
    (send-appleevent ae reply)))

(defun send-toolserver-odoc (&rest paths)
  (declare (dynamic-extent paths))
  (verify-toolserver-target)
  (with-aedescs (ae reply)
    (create-odoc ae *toolserver-target* paths
                 :transaction-id (incf *toolserver-transaction-id*))
    (send-appleevent ae reply)))

(defun send-toolserver-abort (&optional (transaction-id #$kAnyTransactionID))
  (verify-toolserver-target)
  (with-aedescs (ae reply)
    (create-appleevent ae :|MPS | :|abrt| *toolserver-target*
                       :transaction-id transaction-id)
    (send-appleevent ae reply)))

(defun toolserver-status (&optional (transaction-id #$kAnyTransactionID))
  (verify-toolserver-target)
  (with-aedescs (ae reply)
    (create-appleevent ae :|MPS | :|scpt| *toolserver-target*
                       :transaction-id transaction-id)
    (send-appleevent ae reply :reply-mode :wait-reply)
    (if (eql #$noerr (get-error-number reply))
      (let ((filename (ae-get-parameter-char ae :|what|)))
        (if filename
          `(:what ,filename
                  :pos ,(ae-get-parameter-longinteger ae :|pos |)
                  :size ,(ae-get-parameter-longinteger ae :|size|)
                  :who ,(ae-get-parameter-char ae :|who |))
          :not-executing-any-script))
      :not-executing-indicated-script)))


;;; Make the toolserver io pseudo-listener:
;;; ^X^F brings up a choose file dialog & inserts the result into the window
;;; (wonder why MPW never thought of that!)
;;; ^. (NOT command-.) sends a toolserver abort.

(defvar *toolserver-io* nil)
(defvar *toolserver-comtab* (copy-comtab))
(defvar *toolserver-control-x-comtab* (copy-comtab *control-x-comtab*))
(comtab-set-key *toolserver-comtab* #\enter 'toolserver-io-eval)
(comtab-set-key *toolserver-comtab* '(:control #\x) *toolserver-control-x-comtab*)

(comtab-set-key *toolserver-control-x-comtab* '(:control #\f) 'ed-choose-file-dialog)
(comtab-set-key *toolserver-control-x-comtab* '(:control #\e) 'toolserver-io-eval)

(comtab-set-key *toolserver-comtab* '(:control #\.) 'toolserver-io-abort)

(defclass toolserver-io (fred-window)
  ()
  (:default-initargs :window-title "Toolserver" :scratch-p t
    :comtab *toolserver-comtab*))

(defmethod initialize-instance :before ((tio toolserver-io) &key &allow-other-keys)
           (verify-toolserver-target)
           (send-toolserver-script "set backgroundout dev:console")
           (send-toolserver-script "set backgrounderr dev:console"))

(defmethod toolserver-io-eval ((tio fred-mixin))
  (let* ((buf (fred-buffer tio))
         (start (buffer-line-start buf))
         (end (buffer-line-end buf)))
    (ed-insert-char tio #\newline)
    (send-toolserver-script (buffer-substring buf end start))))

(defmethod toolserver-io-abort ((tio fred-mixin))
  (send-toolserver-abort))

(defmethod ed-choose-file-dialog ((w fred-mixin))
  (buffer-insert-substring (fred-buffer w)
                           (concatenate 'string
                                        "\""
                                        (mac-namestring (choose-file-dialog))
                                        "\" ")))

(defmethod outp-handler ((a application) theAppleEvent reply handlerRefcon)
  (declare (ignore reply handlerRefcon))
  (let ((what (ae-get-parameter-char theAppleEvent #$keyDirectObject t)))
    (check-required-params "unexpected parameters in outp" theAppleEvent)
    (unless (and *toolserver-io* (wptr *toolserver-io*))
      (setq *toolserver-io* (make-instance 'toolserver-io)))
    (set-window-layer *toolserver-io* 0)
    (write what :stream *toolserver-io* :escape nil)
    ;(ed-end-of-buffer *toolserver-io*)
    (window-show-cursor *toolserver-io*)))

(defun open-toolserver-io ()
  (unless (and *toolserver-io* (wptr *toolserver-io*))
    (setq *toolserver-io* (make-instance 'toolserver-io)))
  (install-appleevent-handler :|MPS | :|outp| #'outp-handler))

(defmethod window-close :after ((tio toolserver-io))
           (forget-toolserver-target)
           (deinstall-appleevent-handler :|MPS | :|outp|)
           (setf *toolserver-io* nil))

(provide :toolserver)
