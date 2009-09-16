;;-*- Mode: Lisp; Package: CCL -*-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; make-help-map.lisp
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.
;;
;; Code to parse the MCL Help file and create the MCL Help Map file.
;;

(in-package :ccl)

;;;;;;;;;;;;;
;;
;; Modification History
;;
;; 02/08/96 bill remove ".fasl" so that it will become ".pfsl" on the PPC.
;; 07/31/91 bill add IN-PACKAGE. Add :test & :size to make-hash-table call
;;

;;;;;;;;;;;;;
;;
;; Each entry in the help file looks like
;;
;;  symbol-name
;;  type
;;  arglist
;;  documentation
;;
;; Each part of the documentation is stored on a single line.
;; Font changes are denoted by @x, where x is one of:
;;
;;  p  plain text, code font
;;  b  bold, code font
;;  d  plain text, documentation font
;;  i  italic, documentation font
;;
;; The code font will be Geneva 10 (or 9, if 10 is not available)
;; The documentation font will be New York 10.
;;
;; Example:
;;
;;   DEFUN
;;   @isymbol lambda-list@p {@ideclaration@p @d| @idoc-string@p}@d* @p{@iform@p}@d*
;;   [@iMacro@d]
;;   defines a function with the name @isymbol.@p @dOnce a function is defined, it may be used just like the functions which are built into the system. @pdefun@d returns @isymbol.@d
;;
;; The help map file sets *FAST-HELP* to a hash table which maps symbols
;; to locations in the help file.
;; If the help map file is missing or outdated (it knows the length of
;; the help file), DOCUMENTATION and ARGLIST will do a binary search in
;; the help file (hence, it must be alphabetical).  If you change the help
;; file (make-help-map) will update the help map and make arglist on space
;; fast again.

(defvar *help-map-duplicates* nil)

(defun make-help-map (&key (help-file "ccl:MCL Help")
                           (helpmap-source "ccl:library;MCL Help Map.lisp")
                           (helpmap-fasl "ccl:MCL Help Map"))
  (let ((helpmap (make-hash-table :test 'eq :size 1500))
        (eof (list nil))
        duplicates)
    (let ((*package* *package*))
      (in-package :ccl)
      (with-open-file (s help-file)
        (file-position s (* 26 11))
        (multiple-value-bind (reader arg) (stream-reader s)
          (loop
            (if (eofp s) (return))
            (let ((sym (read s nil eof)))
              (if (eq sym eof) (return))
              (if (gethash sym helpmap) (push sym duplicates))
              (setf (gethash sym helpmap) (stream-position s))
              (skip-past-double-newline s reader arg)))))
      (setq *help-map-duplicates* duplicates)
      (setq *fast-help* helpmap)
      (when duplicates
        (format t "Duplicates in help file stored in *help-map-duplicates*~%~s"
                duplicates))
      (compile-file helpmap-source :output-file helpmap-fasl :verbose t))))

(provide 'make-help-map)
