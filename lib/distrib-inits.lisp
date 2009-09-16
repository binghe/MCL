; -*- Mode:Lisp; Package:CCL; -*-

;; distrib-inits.lisp
;; Copyright 1990-1994, Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.


; Things that are in the development environment that need to be
; added to the distribution environment.

; This needs to be compiled after everything is loaded.

(in-package :ccl)

; *def-accessor-types* is used by the inspector to name slots in uvectors
(dolist (cell '#.*def-accessor-types*)
  (add-accessor-types (list (car cell)) (cdr cell)))
