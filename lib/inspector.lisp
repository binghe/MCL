; -*- Mode:Lisp; Package:CCL; -*-

;;	Change History (most recent first):
;;  2 5/4/95   akh  put it back
;;  (do not edit before this line!!)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  inspector.lisp
;;
;;
;;  Copyright 1989-1994 Apple Computer, Inc.
;;  Copyright 1995 Digitool, Inc.
;;
;;  Load the relatively stable part of the inspector
;;

(in-package :ccl)

;(def-logical-directory "inspector" "library;Inspector Folder:")
;(include "ccl:library;scroll-bar-dialog-items.lisp")
;(include "ccl:library;pop-up-menu.lisp")
(include "ccl:inspector;inspector-package.lisp")
(include "ccl:inspector;inspector-class.lisp")
(include "ccl:inspector;inspector-window.lisp")
