;;; -*- Mode:Lisp; Package:CCL; -*-

(in-package :ccl)

;;;
;;; **** Need to change for every machine
;;;
;;; Put your initials here
;;;
(unless (and (boundp '*user-initials*)
             *user-initials*)
  (setq *user-initials* (or (chooser-name) "akh")))

;;;
;;; **** Need to change for every machine
;;;
;;; Put your name here!!!
;;;
(unless (and (boundp '*user*) *user*)
  (setq *user* (or (chooser-name) "Unknown")))


; where projector databases live
(setf (logical-pathname-translations "SSRemote")
      '(("**;*.*" "aliceppc:ccl3&4db:**:*.*")))

; location of project hierarchy on local disk
(setf (logical-pathname-translations "SSLocal")
      `(("**;*.*" "ccl:**;*.*")))

; end
