;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  1 2/16/95  slh  new file, for REQUIRE
;;  (do not edit before this line!!)


;; interface-tools.lisp
;; Copyright 1995 Digitool, Inc. The 'tool rules!

;;
;; Load this file to load the Interface Toolkit.
;; Alternatively, execute (require "INTERFACE-TOOLS")
;;

;; Modification History
;;
;; 05/21/97 bill (provide "INTERFACE-TOOLS")
;;               Change text above.
;; -----------   4.1
;; 2/16/95 slh   new file

(in-package :ccl)

(require 'make-ift)
(funcall (find-symbol "LOAD-IFT" "INTERFACE-TOOLS"))

(provide "INTERFACE-TOOLS")

; End of interface-tools.lisp
