;;;-*- Mode: Lisp; Package: (WOOD) -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; load-wood.lisp
;; Load this file and evaluate (wood::load-wood)
;; You may need to edit the definition of the "wood" logical host.
;;
;; Copyright © 1996 Digitool, Inc.
;; Copyright © 1992-1995 Apple Computer, Inc.
;; All rights reserved.
;; Permission is given to use, copy, and modify this software provided
;; that Digitool is given credit in all derivative works.
;; This software is provided "as is". Digitool makes no warranty or
;; representation, either express or implied, with respect to this software,
;; its quality, accuracy, merchantability, or fitness for a particular
;; purpose.
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Modification History
;;
;; 04/11/97 bill  compile-and-load checks for "Wrong PFSL version" as well
;;                as "Wrong FASL version".
;; -------------  0.961
;; 09/20/96 bill  The WOOD package definition mentions the imported symbols as symbols,
;;                not strings, for versions of MCL that don't already include them (e.g. 3.9).
;; -------------  0.96
;; 07/20/96 bill  import databases-locked-p, with-databases-unlocked, funcall-with-databases-unlocked
;;                from CCL.
;;                Don't load break-loop-patch if ccl::databases-locked-p is fbound
;; 07/09/96 bill  AlanR's fix to (setf (logical-pathname-translations "wood") ...)
;;                (pathname-directory ...) -> (or (pathname-directory ...) '(:absolute))
;; -------------  0.95
;; 06/04/96 bill  load-wood loads break-loop-patch
;; 05/09/96 bill  export with-databases-unlocked and databases-locked-p
;; -------------  0.94 = MCL-PPC 3.9
;; 03/21/96 bill  compile-and-load resignals any error it doesn't recognize
;; 03/09/96 bill  say ccl::*.fasl-pathname* instead of ".fasl".
;; -------------  0.93
;; 08/11/95 bill  translate this file's pathname to a physical one when
;;                defining the "wood" logical pathname to prevent
;;                a recursive definition.
;; 08/11/95 bill  compile-and-load deletes fasl files for other MCL versions.
;; 08/11/95 bill  load-wood loads big-io-buffer-patch if necessary
;; 08/10/95 bill  export p-assoc & p-do-btree
;; 05/31/95 bill  export make-shared-buffer, make-shared-buffer-pool
;; 05/25/95 bill  add disk-page-hash to *wood-files*
;; -------------  0.9
;; 01/17/95 bill  export p-store-pptr, pptr-pointer, pptr-pheap,
;;                with-transaction, start-transaction, commit-transaction,
;;                abort-transaction
;; 11/02/94 ows   export pptr, pheap-pathname
;; 10/25/94 bill  export pptr-p, p-loaded?, p-stored?,
;;                wood-disk-resident-slot-names, define-disk-resident-slots
;; 03/14/94 bill  Don't push anything onto *module-search-path*
;; -------------- 0.8
;; 12/27/93 bill  export p-btree-count, p-hash-table-count, initialize-persistent-instance
;; 12/17/93 bill  Use "wood:wood;..." instead of "wood:..." to prevent
;;                bogus default directories.
;;                Add "version-control" to *wood-files*
;; 03/29/93 bill  Add "q" and "wood-gc" to *wood-files*
;; -------------- 0.6
;; 12/16/92 bill  p-btree-clear -> p-clear-btree
;; 10/21/92 bill  p-nth, p-nthcdr
;; 08/31/92 bill  export p-make-load-function, p-make-load-function
;; 08/06/92 bill  (provide "WOOD")
;; 07/30/92 bill  export p-btree-p and p-hash-table-p
;; -------------- 0.5
;; 07/27/92 bill  Export all documented symbols.
;;

(defpackage :wood
  #+ppc-target
  (:import-from "CCL"
                ccl::databases-locked-p
                ccl::funcall-with-databases-unlocked
                ccl::with-databases-unlocked))

(in-package :wood)

(export '(load-wood
          open-pheap close-pheap with-open-pheap root-object flush-pheap
          make-shared-buffer make-shared-buffer-pool
          pheap p-loading-pheap
          p-load p-store p-stored? p-loaded?
          p-make-area with-consing-area
          p-cons p-list p-list-in-area p-make-list
          p-make-uvector p-make-array p-vector
          p-listp p-consp p-atom p-uvectorp p-packagep p-symbolp
          p-stringp p-simple-string-p p-vectorp p-simple-vector-p p-arrayp
          pload-barrier-p 
          p-car p-cdr p-caar p-cadr p-cdar p-cddr
          p-caaar p-caadr p-cadar p-caddr p-cdaar p-cdadr p-cddar p-cdddr
          p-caaaar p-caaadr p-caadar p-caaddr p-cadaar p-cadadr p-caddar p-cadddr
          p-cdaaar p-cdaadr p-cdadar p-cdaddr p-cddaar p-cddadr p-cdddar p-cddddr
          p-nth p-nthcdr p-last p-delq p-dolist p-assoc
          p-instance-class p-slot-value
          p-uvsize p-uvref p-uvector-subtype-p p-svref p-%svref p-length p-aref
          p-array-rank p-array-dimensions p-array-dimension
          p-intern p-find-symbol p-find-package p-make-package
          p-symbol-name p-symbol-package p-symbol-value
          p-package-name p-package-nicknames
          p-make-btree p-btree-p p-btree-lookup p-btree-store p-btree-delete
          p-clear-btree p-map-btree p-do-btree p-btree-count p-map-btree-keystrings
          p-make-hash-table p-hash-table-p p-gethash p-remhash p-clrhash
          p-hash-table-size p-maphash p-hash-table-count
          wood-slot-names-vector wood-slot-value initialize-persistent-instance
          p-make-load-function p-make-load-function-object p-make-load-function-using-pheap
          p-make-load-function-saving-slots progn-load-functions progn-init-functions
          p-store-pptr
          p-make-pload-barrier p-load-through-barrier
          gc-pheap-file clear-memory<->disk-tables
          with-egc *avoid-cons-caching*
          pptr-p pptr pptr-pointer pptr-pheap
          wood-disk-resident-slot-names define-disk-resident-slots
          pheap-pathname move-pheap-file
          with-databases-locked with-databases-unlocked databases-locked-p
          with-transaction start-transaction commit-transaction abort-transaction
          ))

(setf (logical-pathname-translations "wood")
      (let ((path (or *load-pathname* *loading-file-source-file*)))
        (if path
          (let* ((dest-dir (make-pathname :device    (pathname-device path)
                                          :host      (pathname-host path)
                                          :directory (append
                                                      (or (pathname-directory path)
                                                          '(:absolute))
                                                      '(:wild-inferiors))
                                          :name      :wild
                                          :type      :wild))
                 (physical-dir (translate-logical-pathname dest-dir)))
            ; This is what you'll get if you load this file
            ; or evaluate this form from this buffer.
            `(("wood;**;*.*" ,physical-dir)
              ("**;*.*" ,physical-dir)))
          ; This is what you'll get if you evalute this form
          ; from the listener.
          '(("wood;**;*.*" "ccl:wood;**;*.*")))))

(defun compile-if-needed (file &optional force)
  (let ((lisp (merge-pathnames file ".lisp"))
        (fasl (merge-pathnames file ccl::*.fasl-pathname*)))
    (when (or force
              (not (probe-file fasl))
              (> (file-write-date lisp) (file-write-date fasl)))
      (compile-file lisp :verbose t))))

(defun compile-and-load (file &optional force-compile)
  (compile-if-needed file force-compile)
  (handler-case
    (load file :verbose t)
    (simple-error (condition)
      (if (member (simple-condition-format-string condition)
                  '("Wrong FASL version." "Wrong PFSL version.")
                  :test 'equalp)
        (progn
          (format t "~&;Deleting FASL file from other MCL version...")
          (delete-file (merge-pathnames file ccl::*.fasl-pathname*))
          (compile-and-load file force-compile))
        (error condition)))))

(defparameter *wood-files*
  '("block-io-mcl" "split-lfun" "q"
    "disk-page-hash" "disk-cache" "woodequ" "disk-cache-accessors"
    "disk-cache-inspector" "persistent-heap" "version-control"
    "btrees" "persistent-clos"
    "recovery" "wood-gc"))

(defun load-wood (&optional force-compile)
  (with-compilation-unit ()
    (compile-if-needed "wood:wood;load-wood")
    (unless (boundp 'ccl::*elements-per-buffer*)
      (compile-and-load "wood:patches;big-io-buffer-patch"))
    (dolist (file *wood-files*)
      (compile-and-load (merge-pathnames file "wood:wood;") force-compile))
    #+ppc-target
    (unless (fboundp 'ccl::databases-locked-p)
      (compile-and-load "wood:patches;break-loop-patch" force-compile))
    (provide "WOOD")))

; This should be called only after load-wood.
; It compiles the changed files
(defun compile-wood ()
  (with-compilation-unit ()
    (compile-if-needed "wood:wood;load-wood")
    (dolist (file *wood-files*)
      (compile-if-needed (merge-pathnames file "wood:wood;")))))
;;;    1   3/10/94  bill         1.8d247
;;;    2   3/23/94  bill         1.8d277
;;;    3   7/26/94  Derek        1.9d027
;;;    4   9/19/94  Cassels      1.9d061
;;;    5  11/01/94  Derek        1.9d085 Bill's Saving Library Task
;;;    6  11/05/94  kab          1.9d087
;;;    7  11/21/94  gsb          1.9d100
;;;    2   2/18/95  RŽti         1.10d019
;;;    3   3/23/95  bill         1.11d010
;;;    4   4/19/95  bill         1.11d021
;;;    5   6/02/95  bill         1.11d040
