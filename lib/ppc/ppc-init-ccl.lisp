

;;	Change History (most recent first):
;;  3 12/22/95 gb   more misplaced initializations
;;  2 12/12/95 akh  set some .fasl pathnames
;;  1 12/1/95  akh  new file
;;  (do not edit before this line!!)
; ppc-init-ccl.lisp
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995 Digitool, Inc.

;; 02/27/97 bill save-it function combines save-mcl-libraries and save-application
;; 10/22/96 bill save-mcl-libraries takes an optional suffix arg, which it
;;               concatenates on the end of the library names.
;;               It also saves in the "ccl:ccl;" directory instead of "ccl:pmcl;"
;; ------------- 4.0
;; 04/02/96 bill don't clear *arglist-on-space*
;; 03/10/96 gb  save-mcl-libraries

;(setq *save-local-symbols* t)


#+carbon-compat (require "PPC-INIT-CCL-CARBON")
#-carbon-compat
(progn
#+ppc-target
(progn
(breaker)
(format t "~&Initializing Macintosh Common Lisp ...")
(setq *load-verbose* t)
(setq *warn-if-redefine* nil)
(setq *.fasl-pathname* (pathname ".pfsl")) ; leave it?
(setq *.pfsl-pathname* (pathname ".pfsl"))
(setq *fasl-target* :ppc)
(setq *save-exit-functions* nil)

(require 'compile-ccl)
(ppc-load-ccl)

(setq *warn-if-redefine* t)
(setq *load-verbose* nil)
(format t "~&Macintosh Common Lisp Loaded")

(defun save-mcl-libraries (&optional (suffix ""))
  (save-library (concatenate 'string "ccl:ccl;pmcl-compiler" suffix)
                "pmcl-compiler" *nx-start* *nx-end*)
  ; More here ?
  ; Pick up the leftovers ...
  (save-library (concatenate 'string "ccl:ccl;pmcl-library" suffix)
                "pmcl-library" nil nil))

(defun save-it (&optional (suffix ""))
  (save-mcl-libraries (and suffix (concatenate 'string "-" suffix)))
  (let ((prefix "ccl:ccl;PPCCL"))
    (save-application (if suffix
                        (concatenate 'string prefix " " suffix)
                        prefix))))

;(save-application "ccl;CCL")
)
) ; #-carbon-compat
; End of init-ccl.lisp
