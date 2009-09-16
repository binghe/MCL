;;;-*- Mode: Lisp; Package: (WOOD) -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; version-control.lisp
;; Check for old persistent heap version. Update if we know how.
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
;; -------------  0.96
;; -------------  0.95
;; -------------  0.94
;; -------------  0.93
;; -------------  0.9
;; -------------  0.8
;; 12/17/93 bill  New file

(in-package :wood)

; This function is called by open-pheap.
; It currently knows how to update from version 1 to version 2.
(defun check-pheap-version (pheap)
  (let ((disk-cache (pheap-disk-cache pheap)))
    (multiple-value-bind (version imm?) (dc-%svref disk-cache $root-vector $pheap.version)
      (unless (and imm? (eql version $version-number))
        (cond ((eql version #x504801) (dc-fix-symbols disk-cache))
              (t (error "Unknown version number in ~s" pheap)))
        (setf (dc-%svref disk-cache $root-vector $pheap.version t) $version-number))))
  $version-number)


; version 2 fixed a bug that caused symbols whose storage crossed a
; page boundary to be stored incorrectly. This functions updates
; a version 1 pheap to version 2.
(defun dc-fix-symbols (disk-cache)
  (let* ((page-size (disk-cache-page-size disk-cache))
         (size (disk-cache-size disk-cache))
         (pages (floor size page-size))
         (page 1)
         (addr page-size)
         (count 0))
    (loop
      (when (>= page pages) (return))
      (let* ((area (read-pointer disk-cache (+ addr $block-segment-ptr)))
             (next-page (+ addr page-size)))
        (when (dc-vector-subtype-p disk-cache area $v_segment)
          (let ((header (read-long disk-cache (- next-page 8))))
            (when (eql header $symbol-header)
              (unless (eql area
                           (read-pointer
                            disk-cache (+ next-page $block-segment-ptr)))
                (let* ((sym (- next-page 6))
                       (package (read-pointer disk-cache (+ sym $sym_package)))
                       (values (read-pointer disk-cache (+ sym $sym_values))))
                  (setf (read-pointer disk-cache
                                      (addr+ disk-cache sym $sym_package))
                        package)
                  (setf (read-pointer disk-cache
                                      (addr+ disk-cache sym $sym_values))
                        values)
                  (setf (read-pointer disk-cache (+ next-page $block-segment-ptr))
                        area)
                  (incf count))))))
        (incf page)
        (setq addr next-page)))
    count))
;;;    1   3/10/94  bill         1.8d247
;;;    2   3/23/95  bill         1.11d010
