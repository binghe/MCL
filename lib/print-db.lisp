; -*- Mode:Lisp; Package:CCL; -*-

;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

; 09/01/93 bill return multiple values
; 02/05/93 bill use *trace-output* instead.
; 11/18/89  gz flushed print-out-array.
; 13-apr-89 as constistently use error-output
; 04/08/87 am  removed multi-dimension-array-to-list and mdal-aux to arrays-fry

(defmacro print-db (&rest forms &aux)
  `(multiple-value-prog1
     (progn ,@(print-db-aux forms))
     (terpri *trace-output*)))

(defun print-db-aux (forms)
   (when forms
     (cond ((stringp (car forms))
            `((print ',(car forms) *trace-output*)
              ,@(print-db-aux (cdr forms))))
           ((null (cdr forms))
            `((print ',(car forms) *trace-output*)
              (let ((values (multiple-value-list ,(car forms))))
                (prin1 (car values) *trace-output*)
                (apply #'values values))))
           (t `((print ',(car forms) *trace-output*)
                (prin1 ,(car forms) *trace-output*)
                ,@(print-db-aux (cdr forms)))))))


#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
