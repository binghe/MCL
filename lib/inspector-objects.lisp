;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  inspector-objects.lisp
;;
;;
;; Copyright 1990-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;;
;;  Load the more changeable part of the inspector
;;

#+PPC-target
(include "ccl:inspector;ppc;new-backtrace.lisp")
#-ppc-target
(include "ccl:inspector;68K;new-backtrace.lisp")

(include "ccl:inspector;inspector-objects.lisp")
