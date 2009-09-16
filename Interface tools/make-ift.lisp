;-*- Mode: Lisp; Package: (interface-tools :use (common-lisp ccl) :nicknames (ift)) -*-

;;	Change History (most recent first):
;;  4 2/23/95  slh  icon-dialog-item file now in library folder
;;  3 2/17/95  slh  save-application module moved out
;;  (do not edit before this line!!)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  make-ift.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  tools for building and/or loading the interface designer
;;
;;  To load the interface designer, load the file "ccl:interface tools;interface-tools.lisp"
;;  or execute (require "INTERFACE-TOOLS").
;;  To recompile the interface designer without loading it, execute this file, then call
;;  INTERFACE-TOOLS::COMPILE-IFT.
;;

;;;;;;;;;
;;
;; Change History
;;
;; 05/21/97 bill  Change loading instructions above.
;;                Remove the PROVIDE form at the end of the file
;; -------------  4.1
;; 01/09/96 bill  ".fasl" -> *.fasl-pathname*
;;  2/15/95 slh   assume save-application built-in
;; ------------- 3.0d17
;; 06/??/93 alice save-application-dialog has moved to library
;; 03/10/92 bill Don't add-logical-pathname-translation if it's already there.
;; ------------- 2.0f3
;; 09/06/91 bill pop-up-menus is part of MCL: don't load it here
;; 07/09/91 bill *ift-modules* / load-ift-modules to prevent reloading of pop-up-menu
;; 05/29/91 bill added mode-line
;;


(defpackage :interface-tools
            (:use :common-lisp :ccl)
            (:shadow while until)
            (:nicknames :ift))

(require :resources)

(in-package :interface-tools)


;;;;;;;
;;
;; a simple defsystem
;;

; make ift be a host??
;(setf (logical-pathname-translations "ift") '(("**;*.*" "ccl:Interface Tools;**;*.*")))

(unless (equalp "interface tools"
                (car (last (pathname-directory
                            (translate-logical-pathname "ccl:ift;")))))
  (ccl::add-logical-pathname-translation
   "ccl" '("ift;**;*.*" "ccl:interface tools;**;*.*")))

(defparameter *ift-files* '(#|"ccl:ift;ift-init"|# "ccl:ift;ift-utils" "ccl:ift;dialog-editor"
                            "ccl:ift;item-defs" "ccl:ift;menu-editor" "ccl:ift;ift-menus"
                            ))

(defparameter *ift-support-files* '("ccl:ift;ift-macros" "ccl:ift;ift-init"))

(defparameter *ift-modules* '((:graphic-items . "ccl:library;graphic-items")
                              (:icon-dialog-item . "ccl:library;icon-dialog-item")))

(defvar *loaded-ift-files* '())

(defun compile-if-changed (file always)
  (let* ((source (merge-pathnames file ".lisp"))
         (fasl (merge-pathnames file *.fasl-pathname*)))
    (unless (probe-file source)
      (error "file not found: ~s" file))
    (when (or always
              (not (probe-file fasl))
              (< (file-write-date fasl)
                 (file-write-date source)))
      (compile-file source :output-file fasl :verbose t))))

(defun load-if-changed (file always)
  (compile-if-changed file nil)
  (let* ((fasl (merge-pathnames file *.fasl-pathname*))
         (date (file-write-date fasl))
         (last-load (assoc file *loaded-ift-files* :test #'equalp)))
    (when (or always
              (not last-load)
              (< (cdr last-load)
                 date))
      (load fasl :verbose t)
      (if last-load
          (setf (cdr last-load) date)
          (push (cons file date) *loaded-ift-files*)))))

(defun compile-ift (&optional always)
  (with-compilation-unit ()
    (load-ift-support))
  (with-compilation-unit ()
    (load-ift-modules))
  (with-compilation-unit ()
    (dolist (file *ift-files*)
      (compile-if-changed file always))))

;(compile-ift)
;(compile-ift t)

(defun load-ift-support ()
  (dolist (file *ift-support-files*)
    (load-if-changed file nil)))

(defun load-ift-modules ()
  (dolist (module *ift-modules*)
    (destructuring-bind (module-name . file) module
      (when (or (not (member module-name *modules* :test 'string-equal))
                (compile-if-changed file nil))
        (load-if-changed file nil)))))

;(load-ift-support)

(defun load-ift ()
  (with-compilation-unit ()
    (load-ift-modules))
  (with-compilation-unit ()
    (load-ift-support))
  (with-compilation-unit ()
    (dolist (file *ift-files*)
      (load-if-changed file nil)))
  (pushnew :interface-designer *features*))


#|
	Change History (most recent last):
	2	1/2/95	akh	provide interface tools
|# ;(do not edit past this line!!)
