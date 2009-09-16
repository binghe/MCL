; -*- Mode:Lisp; Package:INTERFACE-TOOLS; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  ift-init.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  performs various patches and initializations for the interface
;;  designer

;;;;;;;;;;;;;;;;;
;;
;; Change history
;;
;; 11/06/91 bill *restore-lisp-functions* -> def-load-pointers
;;


(in-package :interface-tools)

;;;;;;;;;;;;;;;;;;;
;;
;; random global variables
;;

(defparameter *dialog-item-scrap* ()
  "used for cut/copy/paste of dialog-items")

(defparameter *dialog-change-undohook* nil
  "should be nil or a cons of (<undo-menu-title> . <undo-function>)")

(defparameter *selected-dialog-items* ()
  "selected dialog-items in the edited window")

(defclass non-editable-dialog (color-dialog) ())


;;;;;;;;;;;;;;;;;;;;
;; 
;; cursor hacking
;;

(defun make-cursor (data-string mask-string hotspot)
  (when (or (> (length (string data-string)) 64)
            (> (length (string mask-string)) 64))
    (error "data-string & mask-string must be < 64 chars long"))
  (rlet ((data :bits16)
         (mask :bits16))
    (with-pstrs ((data-str data-string)
                 (mask-str mask-string))
      (#_StuffHex :ptr data :ptr data-str)
      (#_StuffHex :ptr mask :ptr mask-str))
    (make-record :cursor
               :data data
               :mask mask
               :hotspot hotspot)))

(defun make-grow-cursor ()
  (make-cursor "00003FC02040204027F82448244824483FC80408040807F80000000000000000"
               "00003FC03FC03FC03FF83FF83FF83FF83FF807F807F807F80000000000000000"
               #@(2 3)))

(defvar *grow-cursor* (make-grow-cursor))

;the cross-hair-cursor
(defun make-cross-hair-cursor ()
  (make-cursor "04000400040004000400FFE00400040004000400040004000000000000000000"
               "0000000000000000000000000000000000000000000000000000000000000000"
               #@(5 5)))

(defvar *cross-hair-cursor* (make-cross-hair-cursor))

(def-load-pointers init-cursors ()
  (setq *grow-cursor* (make-grow-cursor))
  (setq *cross-hair-cursor* (make-cross-hair-cursor)))
