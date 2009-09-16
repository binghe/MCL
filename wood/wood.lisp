;;;-*- Mode: Lisp; Package: (WOOD) -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; wood.lisp
;; This file exists so that you can (require "WOOD" "ccl:wood;wood")
;; You may need to edit the definition of the "wood" logical host
;; in the file "load-wood.lisp"
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
;; -------------  0.961
;; 09/20/96 bill  resignal the error in the handler-case if not a wrong fasl version error
;; -------------- 0.96
;; -------------- 0.95
;; -------------- 0.94
;; 03/09/96 bill  say ccl::*.fasl-pathname* instead of ".fasl".
;; -------------- 0.93
;; 08/11/95 bill  Handle wrong fasl version errors
;; -------------- 0.9
;; 03/09/94 bill  wood::load-wood -> (find-symbol "LOAD-WOOD" :wood)
;; -------------- 0.8
;; -------------- 0.6
;; 08/31/92 bill  new file
;;

(in-package :cl-user)

(labels ((load-it ()
           (let* ((path (or *load-pathname* *loading-file-source-file*))
                  (load-wood-path
                   (make-pathname :host       (pathname-host path)
                                  :device     (pathname-device path)
                                  :directory  (pathname-directory path)
                                  :name       "load-wood"
                                  :defaults   nil)))
             (handler-case
               (compile-load load-wood-path :verbose t)
               (simple-error (condition)
                (if (equalp "Wrong FASL version."
                            (simple-condition-format-string condition))
                  (progn
                    (format t "~&;Deleting FASL file from other MCL version...")
                    (delete-file (merge-pathnames load-wood-path ccl::*.fasl-pathname*))
                    (return-from load-it (load-it)))
                  (error condition)))))))
  (load-it))
                

; Wood package is created by "load-wood.lisp"
; find-symbol so we can compile this file before loading that one.
(funcall (find-symbol "LOAD-WOOD" :wood))       ; does (provide "WOOD")



;;;    1   3/10/94  bill         1.8d247
;;;    2   3/23/95  bill         1.11d010
