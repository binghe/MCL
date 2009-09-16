;-*- Mode: Lisp; Package: CCL -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; load-all-patches.lisp
;; Copyright 1990-1994 Apple Computer, Inc.
;; Copyright 1995-1996 Digitool, Inc.
;;

;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; 10/09/96 slh   move export to inside eval-when
;; 0/13/96 bill   File and function renamed to load-all-patches
;;                Add copyright, in-package, export.
;; -------------  4.0b1
;; 04/25/96 bill  ".fasl" -> *.fasl-pathname*
;; -------------  MCL-PPC 3.9
;;

(in-package :ccl)

(eval-when (:execute :compile-toplevel :load-toplevel)
  (export '(*compile-before-loading*
            load-all-patches)))

(defvar *compile-before-loading* nil)

(defun load-compiled-file (file &key verbose output-file
                                (always *compile-before-loading*)
                                (save-local-symbols *fasl-save-local-symbols*)
                                (save-doc-strings *fasl-save-doc-strings*)
                                (save-definitions *fasl-save-definitions*))
  (let* ((source (merge-pathnames ".lisp" file))
         (fasl (merge-pathnames *.fasl-pathname* (or output-file file)))
         source-probe fasl-probe)
    (cond ((and (setq source-probe (probe-file source))
                (or always
                    (not (setq fasl-probe (probe-file fasl)))
                    (< (file-write-date fasl)
                       (file-write-date source))))
           (compile-file source :output-file fasl :load t :verbose verbose
                         :save-local-symbols save-local-symbols
                         :save-doc-strings save-doc-strings
                         :save-definitions save-definitions))
          ((or fasl-probe
               (and (null source-probe) (probe-file fasl)))
           (load fasl :verbose verbose))
          (t (error 'file-error "File not found: ~S" file)))))

(defun load-directory-files (pathname &key directories (files t)
                                      directory-pathnames test resolve-aliases
                                      verbose
                                      (always *compile-before-loading*)
                                      (save-local-symbols *fasl-save-local-symbols*)
                                      (save-doc-strings *fasl-save-doc-strings* )
                                      (save-definitions *fasl-save-definitions*))
  (loop for path in (directory pathname
                               :directories directories
                               :files files
                               :directory-pathnames directory-pathnames
                               :test test
                               :resolve-aliases resolve-aliases)
        do (load-compiled-file path
                               :verbose verbose
                               :always always
                               :save-local-symbols save-local-symbols
                               :save-doc-strings save-doc-strings
                               :save-definitions save-definitions)))

(defvar *mcl-patch-directory* "ccl:patches;")

(defun load-all-patches (&optional (patch-directory *mcl-patch-directory*))
  (format *standard-output* "~&;Loading Patches . . . .")
  (let ((*warn-if-redefine-kernel* nil)
        (*warn-if-redefine* nil))
    (load-directory-files (merge-pathnames #.(make-pathname :name :wild
                                                            :type (pathname-type *.fasl-pathname*)
                                                            :defaults nil)
                                           patch-directory)
                          :verbose t :always nil))
  (format *standard-output* "~&;Patches loaded."))