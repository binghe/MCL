;;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  3 10/26/95 Alice Hartley %istruct/make-uvector stuff
;;  5 6/8/95   slh  %get-frame-ptr again
;;  4 6/8/95   akh  %get-frame-ptr works for other than current-stack-group
;;  3 4/24/95  akh  probably no change
;;  2 4/4/95   akh  add free-stackseg and next-stackseg
;;  3 1/25/95  akh  make-stack-group - stack size defaults to 64k
;;  (do not edit before this line!!)

;; L1-stack-groups.lisp
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995 Digitool, Inc. The 'tool rules!

;; Modification History
;
;11/15/95 bill parent-frame, stack-area-endptr & cfp-lfun move here from "lib;backtrace".
;10/20/95 slh  dumb de-lap: ignore most of file for PPC
; 3/13/95 slh  added *bind-io-control-vars-per-process*
;------------- 3.0d17
;07/13/93 bill symbol-value-locative-in-stack-group now looks for the
;              LAST binding on *current-stack-group* if it finds no
;              binding for the given stack-group.
;07/09/93 bill stack-size default -> 16384.
;06/29/93 bill default for stack-size in make-stack-group -> 8192.
;              sg-previous-stack-group -> previous-stack-group
;------------- 3.0d11
;03/09/93 bill stack-group-size
;02/17/93 bill sg-buffer
;01/29/93 bill %in-temp-gspace looks at all stacksegs of tempvbuf
;01/28/93 bill make-stack-group has without-interrupts where needed. It also leaves
;              the allocation of the initial chunks to $sp-sg-preset. Added a stack-size arg.
;01/24/93 bill stack-group-preset runs enough of the initial function to bind *top-listener*
;01/17/93 bill sgbuf.csbuf &sgbuf.vsbuf may be 0. Check for that case.
;              symbol-value-in-stack-group
;01/11/92 bill (temporary-cons-p x) implies (cons-p x)
;12/17/92 bill typo in %in-non-lisp-area
;11/20/92  gb  new file.
;---------- 2.0

(cl:in-package "CCL")

(defvar *bind-io-control-vars-per-process* nil
  "If true, bind I/O control variables per process")

           
#|
	Change History (most recent last):
	2	12/27/94	akh	merge with d13
|# ;(do not edit past this line!!)
