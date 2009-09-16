;;-*- Mode: Lisp; Package: CCL -*-

;;	Change History (most recent first):
;;  2 4/1/96   akh  changes from bill
;;  (do not edit before this line!!)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; FF-example.lisp
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.
;;
;;
;;  Examples the Macintosh Common Lisp Foreign Function Interface,
;;  Lisp component.
;;

;;;;;;;;;;;;
;;
;; Change History
;;
;; 
;; 04/09/96 bill add-flt returns and works
;; 04/01/96 bill comment out add-flt for PPC, can't return floats yet.
;; 11/19/91 bill defccallable syntax is now similar to defpascal
;;

(in-package :ccl)

;;set-up
;;These logical directories should be set up for your particular disk
(add-logical-pathname-translation "ccl" '("ff;**;*.*" "ccl:examples;ff examples;**;*.*"))
(setf (logical-pathname-translations "mpw")
      '(("clib;**;*.*" "hd:mpw:libraries:clibraries:**:*.*")
        ("lib;**;*.*"   "hd:mpw:libraries:libraries:**.*.*")
        ("**;*.*" "hd:mpw:**:*.*")))

(eval-when (:execute :compile-toplevel :load-toplevel)
  (require :ff-source))


(ff-load "ccl:ff;ff-example.c.o"
         :ffenv-name 'test
         :libraries '("mpw:clib;StdCLib.o"
                      "mpw:lib;interface.o"))

(deffcfun (digit-value "digitval") (character) :long)

(deffcfun (setchar "setchar") ((string :by-reference) fixnum character) 
      :novalue)

(deffcfun (flt-incr "flt_incr") 
      ((float :double :by-reference) 
       (float :extended)) 
      :novalue)

(deffcfun (grow-ptr "growptr") ((cons :lisp-ref)) :novalue)

(deffcfun (add-flt "add_flt") (float float) :float)

(defccallable add-one (:long i :long)
  (+ i 1))

(deffcfun (add-three "addthree") ((fixnum :long) (t :ptr)) :long)
