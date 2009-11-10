;-*-Mode: LISP; Package: CCL -*-

;; prepare-mcl-environment.lisp
;; Load this into a PPCCL to make it into an MCL-PPC for shipping

;; Copyright 1996 Digitool, Inc. The 'tool rules!

;;
;; Modification History
;;;; 11/10/09 terje *mcl-revision*
;; 04/08/97 bill  Remove *standard-kernel-method-class*, it's in l1-clos now.
;;                Change 68K version of make-all-methods-kernel
;;                to set the $lfattr-kernel-bit of the method's function instead
;;                of changing the method's class.
;;                Don't try to set the package in 68K MCL. Have to do it by hand there.
;; -------------  4.1b1
;; 08/26/96 bill  Fix the comment before (make-all-methods-kernel)
;; -------------  4.0b1
;; 08/15/96 bill  Do (make-all-methods-kernel)
;; 04/12/96 bill  New file
;;

(in-package :ccl)(defvar *mcl-revision* (with-open-file (in "ccl:.hg;branchheads.cache" :if-does-not-exist nil)                               (when in                                 (subseq (read-line in) 0 10))))

; enable redefine-kernel-function's error checking
(setq *warn-if-redefine-kernel* t)

; Set the frozen bits so that redefine-kernel-function
; will error if a builtin function is redefined.
(do-all-symbols (s)
  (when (fboundp s)
    (%symbol-bits s (bitset $sym_fbit_frozen (%symbol-bits s)))))

; Set the top-level *package* to the CL-USER package
#+ppc-target
(do-db-links (db var)
  (when (eq var '*package*)
    (setf (%fixnum-ref db 8) (find-package :cl-user))))

#-ppc-target
(defun make-all-methods-kernel ()
  (%map-lfuns #'(lambda (f)
                  (when (typep f 'generic-function)
                    (let ((smc *standard-method-class*))
                      (dolist (method (generic-function-methods f))
                        (when (eq (class-of method) smc)
                          (let ((f (%method-function method)))
                            (lfun-attributes f
                                             (bitset $lfatr-kernel-bit
                                                     (lfun-attributes f)))))))))))



; Force an error if a kernel method is redefined.
(make-all-methods-kernel)



