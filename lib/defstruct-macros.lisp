;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  $Log: defstruct-macros.lisp,v $
;;  Revision 1.4  2003/12/08 08:04:38  gtbyers
;;  Define $struct_inherited bit.  Don't use 68K constants anymore.
;;
;;  2 2/2/95   akh  merge leibniz patches
;;  (do not edit before this line!!)

; Copyright 1987-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995 Digitool, Inc.

; This file is needed to compile DEFSTRUCT and anything accessing defstruct
; data structures.

;; Modification History
;
;  5/03/95 slh   requires
;  4/06/95 slh   macros only here
;  3/30/95 slh   merge in base-app changes
;--------------  3.0d18
; 04/17/92 bill sd-refnames
;-------------- 2.0
; 03/25/90 gz  Assume sd-xxx usage debugged now (svref -> %svref).
; 11/24/89 gz sd superclasses now include name, stored in slot 0.
; 8/26/88 gz No more sd-documentation.  16-bit offset.
; 8/12/88 gb 20-bit offset.
; 7/15/87 gz New

(in-package :ccl)

(eval-when (:execute :compile-toplevel :load-toplevel)
  (require "LISPEQU"))

(defconstant $struct-r/o 24)             ; Read-only bit in refinfo fixnum
(defconstant $struct-inherited 25)		; Struct slot is  inherited.


(defconstant $defstruct-nth ppc::subtag-bignum)   ; Anything that won't conflict with array types...

(defmacro ssd-name (ssd) `(car ,ssd))
;(defmacro ssd-type (ssd) (declare (ignore ssd)) t)
(defmacro ssd-initform (ssd) `(cadr ,ssd))
;(defmacro ssd-refinfo (ssd) `(cddr ,ssd))

(defmacro ssd-update-refinfo ((ssd refinfo-var) new-refinfo-form)
  (check-type refinfo-var symbol)
  (let ((refinfo-cons (gensym)))
    `(let* ((,refinfo-cons (cdr ,ssd))
            (,refinfo-var (cdr ,refinfo-cons)))
       (when (consp ,refinfo-var)
         (setq ,refinfo-cons ,refinfo-var)
         (setq ,refinfo-var (%cdr ,refinfo-cons)))
       (%rplacd ,refinfo-cons ,new-refinfo-form))))

(defmacro refinfo-offset (refinfo) `(%ilogand2 #xFFFF ,refinfo))
(defmacro refinfo-r/o (refinfo) `(%ilogbitp $struct-r/o ,refinfo))
(defmacro refinfo-reftype (refinfo) `(%ilogand2 #xFF (%ilsr 16 ,refinfo)))

(defmacro ssd-offset (ssd) `(refinfo-offset (ssd-refinfo ,ssd)))
(defmacro ssd-r/o (ssd) `(refinfo-r/o (ssd-refinfo ,ssd)))
(defmacro ssd-reftype (ssd) `(refinfo-reftype (ssd-refinfo ,ssd)))

(defmacro ssd-set-initform (ssd value) `(rplaca (cdr ,ssd) ,value))

#| these are fns now
(defmacro ssd-set-reftype (ssd reftype)      ;-> ssd multiply evaluated
  `(rplacd (cdr ,ssd) (%ilogior2 (%ilogand2 #x100FFFF (cdr (%cdr ,ssd)))
                                 (%ilsl 16 ,reftype))))

(defmacro ssd-set-r/o (ssd)                  ;-> ssd multiply evaluated
  `(rplacd (cdr ,ssd) (%ilogior2 #x1000000 (cdr (%cdr ,ssd)))))

(defmacro copy-ssd (ssd)                     ;-> ssd multiply evaluated
  `(list* (car ,ssd) (car (%cdr ,ssd)) (%cddr ,ssd)))
|#

(defmacro named-ssd (name slot-list) `(assq ,name ,slot-list))

(defmacro sd-name (sd) `(%car (%svref ,sd 2)))
(defmacro sd-type (sd) `(%svref ,sd 0))
(defmacro sd-slots (sd) `(%svref ,sd 1))
(defmacro sd-superclasses (sd) `(%svref ,sd 2))
(defmacro sd-size (sd) `(%svref ,sd 3))
(defmacro sd-constructor (sd) `(%svref ,sd 4))
(defmacro sd-print-function (sd) `(%svref ,sd 5))
(defmacro sd-set-print-function (sd value) `(%svset ,sd 5 ,value))
(defmacro sd-refnames (sd) `(%svref ,sd 6))

(defmacro struct-name (struct) `(car (uvref ,struct 0)))
(defmacro struct-def (struct) `(gethash (car (uvref ,struct 0)) %defstructs%))

;Can use this to let the printer print with print-function, reader read with
;constructor and slot-names, inspector inspect with slot-names.
;Everything else you have to arrange yourself.
#+ignore
(defmacro pretend-i-am-a-structure (name constructor print-function &rest slot-names)
  (let ((slots slot-names) (offset 1) (supers (list name)))
    (while slots
      (%rplaca slots (make-ssd (%car slots) () offset t))
      (ssd-set-reftype (%car slots) ppc::subtag-struct)
      (setq slots (%cdr slots) offset (1+ offset)))
    (push (make-ssd 0 `',supers 0 t) slot-names)
    (ssd-set-reftype (%car slot-names) ppc::subtag-struct)
    `(puthash ',name %defstructs%
          '#(internal-structure  ;Make structure-class-p false.
             ,slot-names
             ,supers
             ,offset
             ,constructor
             ,print-function
             nil))))

(provide 'defstruct-macros)

; End of defstruct-macros.lisp
