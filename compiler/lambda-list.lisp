;;;-*-Mode: LISP; Package: CCL -*-

;; $Log: lambda-list.lisp,v $
;; Revision 1.5  2003/12/08 08:20:18  gtbyers
;; Most of this moved into level-1 CLOS code.
;;
;; Revision 1.4  2003/12/01 17:56:05  gtbyers
;; recover pre-MOP changes
;;
;; Revision 1.2  2002/11/18 05:12:11  gtbyers
;; CVS mod history marker
;;
;;	Change History (most recent first):
;;  4 9/4/96   akh  not sure
;;  3 7/18/96  akh  probably no change
;;  (do not edit before this line!!)


; verify-lambda-list.lisp
; Copyright 1995-1999 Digitool, Inc.

; Modification History
;
; 10/28/97 akh    uncompile-function for ppc tries harder
; 06/21/96 bill   %lfun-info honors the $lfbits-noname-bit
;  -------------  MCL-PPC 3.9
;  04/10/96 gb    move PARSE-BODY here.
;  02/20/96 gb    %lfun-info.
;  11/14/95 slh   nuke lappy %lfun-vector-mapwords for PPC

(in-package :ccl)


;;; Compiler functions needed elsewhere

; used-by: backtrace, fred-additions
(defun function-symbol-map (fn)
  (getf (%lfun-info fn) 'function-symbol-map))

    

#+ppc-target
(defun %lfun-info (fn)
  (and (compiled-function-p fn)
       (let ((bits (lfun-bits fn)))
         (declare (fixnum bits))
         (and (logbitp $lfbits-symmap-bit bits)
              (%svref fn (%i- (uvsize fn)
                              (if (logbitp $lfbits-noname-bit bits) 2 3)))))))

(defun uncompile-function (fn)
  (or (getf (%lfun-info fn) 'function-lambda-expression )
      #+ppc-target  ; we seem to have forgotten to save it on lfun-info in some cases
      (if (compiled-for-evaluation fn)
        (let ((foo (uvref fn 1))) ; gag
          (evalenv-form foo)))))
        



;;; Lambda-list utilities

; We should handle/encode (&allow-other-keys) w/o keywords - might tell the compiler
; or user something.
; We should think harder before writing bogus & misleading comments.
; Tar is not a plaything.

;;; Lambda-list verification:

; these things MUST be compiled.
(eval-when (load)

(defvar *structured-lambda-list* nil)






(defun parse-body (body env &optional (doc-string-allowed t) &aux
   decls
   doc
   (tail body)
   form)
  (declare (ignore env))
  (loop
   (if (endp tail) (return))  ; otherwise, it has a %car and a %cdr
   (if (and (stringp (setq form (%car tail))) (%cdr tail))
    (if doc-string-allowed
     (setq doc form)
     (return))
    (if (not (and (consp form) (symbolp (%car form)))) 
     (return)
     (if (eq (%car form) 'declare)
      (push form decls)
      (return))))
   (setq tail (%cdr tail)))
  (return-from parse-body (values tail (nreverse decls) doc)))

) ; end of eval-when (load)

; End of verify-lambda-list.lisp
