; -*- Mode:Lisp; Package:CCL; -*-

;;	Change History (most recent first):
;;  4 7/18/96  akh  set comtab keys for inspector stuff here
;;  3 12/22/95 gb   don't require LAPMACROS on PPC
;;  2 11/13/95 akh  %magic-closure-value #-ppc-target
;;  (do not edit before this line!!)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  inspector-package.lisp
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  Definition of INSPECTOR package
;;

;;;;;;;
;;
;; Mod History
;;
;; 01/09/92 bill (require "LAPMACROS")
;; 07/09/91 bill don't import ccl internal symbols.  Use package prefix at reference point.
;; 06/28/91 bill import line clip-region, & erase-rect so that they
;;               can be exported by ccl:library;quickdraw.lisp

(in-package :ccl)

(defpackage :inspector
  (:use :common-lisp :ccl))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (import '(line clip-region erase-rect)
          :inspector))

#-ppc-target
(eval-when (:compile-toplevel :execute)
  (require "LAPMACROS"))
#-ppc-target
(defun inspector::%magic-closure-value ()
  (lap-inline ()
    (move.l ($ $magic_closure_value) acc)))

(comtab-set-key *control-x-comtab* '(:control #\i)    'ed-info-current-sexp)
(comtab-set-key %initial-comtab%  #\Help              'ed-inspect-current-sexp)
