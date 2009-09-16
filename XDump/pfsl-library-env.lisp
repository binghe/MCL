;;;;-*- Mode: Lisp; Package: CCL -*-

; pfsl-library-env.lisp
; Copyright 1997 Digitool, Inc. The 'tool rules!

; Compilation environment for pfsl-libraries.

(in-package :ccl)

;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Modification History
;;;
;;; #$kPowerPC -> #$kPowerPCArch
;;; ---- 5.1 final
;;; 05/06/97 bill  No redefinition warnings for fragment-descriptor
;;;                or cfrg-header records.
;;; 04/24/97 bill  New file
;;;

(require "FASLENV" "ccl:xdump;faslenv")
(require "PPC-ARCH" "ccl:compiler;ppc;ppc-arch")
(require "PPC-LAP" "ccl:compiler;ppc;ppc-lap")

; This code is now part of "ccl:xdump;faslenv"
#+ignore
(progn

(assert (eql numfaslops 48))

(defconstant $fasl-library-pointer 48)
(defconstant $fasl-provide 49)

)

(defmacro def-pfsl-library-faslop (n arglist &body body)
  `(setf (svref *pfsl-library-dispatch-table* ,n)
         #'(lambda ,arglist ,@body)))

(defmacro copy-pfsl-library-faslop (n)
  `(let* ((n ,n))
     (setf (svref *pfsl-library-dispatch-table* n)
           (svref *fasl-dispatch-table* n))))

; This really belongs in "ccl:lib;lispequ.lisp"
(def-accessors (pfsl-library) %svref
  nil                                   ; type
  pfsl-library.name
  pfsl-library.pathname
  pfsl-library.area
  pfsl-library.start
  pfsl-library.end)

; The following two records are also defined in "ccl:examples;cfm-mover.lisp"
(let ((*warn-if-redefine* nil)
      (*warn-if-redefine-kernel* nil))

; Information about the 'cfrg' resource format
; starts on page 3-29 of the "Power PC System Software" manual.

(defrecord fragment-descriptor
  (code-type :ostype)                   ; #$kPowerpc
  (update-level :long)                  ; #$kFullLib or #$KUpdateLib
  (current-version :long)               ; version number
  (oldest-definition-version :long)     ; compatible back to version number
  (application-stack-size :long)        ; stack size for application
  (application-library-directory :word) ; index of 'alis' record
  (fragment-type :byte)                 ; #$kIsLib, #$kIsApp, #$kIsDropIn
  (fragment-location :byte)             ; #$kInMem, #$kOnDiskFlat, #$kOnDiskSegmented
  (fragment-offset :long)               ; see table below
  (fragment-length :long)               ; see table below
  (reserved-1 :long)
  (reserved-2 :long)
  (record-length :unsigned-word)        ; total length of this record
  (name (:array :byte 0)))              ; Pascal string padded with 0's to record-length

; fragment-location         fragment-offset        fragment-length
; -----------------         ---------------        ---------------
; #$kInMem                  memory address         size in bytes
; #$kOnDiskFlat             Offset in data fork    size in bytes or #$kWholeFork (0)
; #$kOnDiskSegmented        resource type          resource index

(defrecord cfrg-header
  (reserved-1 :long)
  (reserved-2 :long)
  (version :long)
  (reserved-3 :long)
  (reserved-4 :long)
  (reserved-5 :long)
  (reserved-6 :long)
  (fragment-descriptor-count :long)
  (descriptors (:array :fragment-descriptor 0)))

)

; The value in the cfrg-header.version slot
(defconstant $cfrg-version 1)

(defconstant $kPowerPC-long #.(rlet ((x :long))
                                (setf (%get-ostype x) #$kPowerPCCFragArch)
                                (%get-long x)))

(provide "PFSL-LIBRARY-ENV")
