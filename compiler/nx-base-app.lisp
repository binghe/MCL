;;;-*-Mode: LISP; Package: CCL -*-

;; $Log: nx-base-app.lisp,v $
;; Revision 1.2  2002/11/18 05:12:33  gtbyers
;; CVS mod history marker
;;
;;	Change History (most recent first):
;;  2 7/18/96  akh  require nx-basic
;;  (do not edit before this line!!)


; l1-base-app.lisp
; Copyright 1995 Digitool, Inc. The 'tool rules!

; Loaded instead of compiler for standalone applications.

(in-package :ccl)

;(require 'numbers)
(require 'sort)
(require 'hash)

; this file is now equiv to nx-basic
(%include "ccl:compiler;nx-basic.lisp")  ; get cons-var, augment-environment
; nx-basic includes lambda-list

; End of nx-base-app.lisp
