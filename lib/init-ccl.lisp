; init-ccl.lisp
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995 Digitool, Inc.

;(setq *save-local-symbols* t)

#-ppc-target
(progn
(format t "~&Initializing Macintosh Common Lisp ...")
(setq *load-verbose* t)
(setq *warn-if-redefine* nil)

(require 'compile-ccl)
(load-ccl)

(setq *warn-if-redefine* t)
(setq *load-verbose* nil)
(format t "~&Macintosh Common Lisp Loaded")

;(save-application "ccl;CCL")
)  ; end of #-ppc-target progn

#+ppc-target
(require'ppc-init-ccl)

; End of init-ccl.lisp
