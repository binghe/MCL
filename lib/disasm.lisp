;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  3 10/27/95 bill see below
;;  (do not edit before this line!!)


;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

; Modification History
;
;10/25/95 bill  disassemble does the right thing for ppc-function-vector's
;10/20/95 slh   disabled for PPC
;11/20/92 gb    new lfun vectors
;-------- 2.0
;05/29/91 gb    disassemble-lfun requires FUNCTION vice COMPILED-FUNCTION.
;02/18/91 gb   %uvsize -> uvsize.
; 01/15/91 gb   make disassemble-list handle lambda-expressions & interpreted functions.
;               use "DL" if you want to disassemble an arbitrary lfun.
; 10/16/90 gb   no short vectors.
; 06/29/90 bill disassemble-list takes the %method-function of a method.
; 01/17/90 gz   Made decompose-fn not return lfun-bits.  Split of disassemble-list
;               for the inspector.  Check for $lfatr-noname-bit.
; 12/29/89 gz   This is part of the disassembler that is included in the
;               product.  The part with the multitudes of symbols gets
;               autoloaded.  This part has too many internal function refs
;               to try to load into a block-compiled lisp.

(in-package :ccl)

#-ppc-target
(progn

(declaim (notinline disasm-disassemble))

(defun disasm-disassemble (&rest args)
  (require "DISASSEMBLE")
  (apply 'disasm-disassemble args))


(defun disassemble (fn)
  (if (eq (%type-of fn) 'xppc-function-vector)
    (ppc-xdisassemble fn)
    (disasm-write (disassemble-list fn))))

(defun disassemble-list (thing &aux (fun thing))
  (when (typep fun 'standard-method) (setq fun (%method-function fun)))
  (when (or (symbolp fun)
            (and (consp fun) (neq (%car fun) 'lambda)))
    (setq fun (fboundp thing))
    (when (and (symbolp thing) (not (lfunp fun)))
      (setq fun (macro-function thing))))
  (if (or (typep fun 'interpreted-function)
          (typep fun 'interpreted-lexical-closure))
    (setq fun (function-lambda-expression fun))
    (if (typep fun 'compiled-lexical-closure)
      (setq fun (closure-function fun))))
  (when (lambda-expression-p fun)
    (setq fun (compile-named-function fun nil)))
; By now, we should have a compiled function.
  (disassemble-lfun fun thing))

(defun disassemble-lfun (fun &optional (thing fun))
  (unless (typep fun 'function) (report-bad-arg thing 'function))
  (multiple-value-bind (immarray codearray immrefs fcells vcells)
                       (decompose-fn fun)
    (let* ((codewords (length codearray))
           (numimmrefs (length immrefs))
           (attribs (lfun-attributes fun)))
      (unless (%ilogbitp $lfatr-noname-bit attribs)
        (setq codewords (- codewords 2)))
      (when (%ilogbitp $lfatr-symmap-bit attribs)
        (setq codewords (- codewords 2)))
      (disasm-disassemble 
       fun codearray immarray (+ codewords codewords) immrefs numimmrefs fcells vcells))))
    
(defun decompose-fn (fn &optional (imms-seen (make-array 16 :adjustable t
                                                         :fill-pointer 0)))
  (let* ((vec (%lfun-vector fn))
         (mapwords (%lfun-vector-mapwords vec))
         (codewords (- (uvsize vec) 1 mapwords))
         (codevector (%make-uvector codewords $v_swordv))
         (numimmrefs (%count-immrefs vec))
         (immrefs (make-array numimmrefs))
         (imm nil)
         (offset 0)
         (next nil)
         (temp nil)
         (vcells nil)
         (fcells nil)
         (k 0))
    (dotimes (i codewords)
      (declare (fixnum i))
      (uvset codevector i (uvref vec (+ i 1))))
    (dotimes (i codewords)
      (declare (fixnum i))
      (when (%immref-p i vec)
           (multiple-value-setq (imm offset) (%nth-immediate vec k))
           (cond ((eq offset $sym.gvalue)
                  (unless (setq temp (assq imm vcells))
                    (push (setq temp (cons imm (list 'special imm))) vcells))
                  (setq imm temp))
                 ((eq offset $sym.fapply)
                  (unless (setq temp (assq imm fcells))
                    (push (setq temp (cons imm (list 'function imm))) fcells))
                  (setq imm temp)))
           (setf (aref immrefs k) i
                 k (1+ k)
                 next (install-imm imm imms-seen)
                 (aref codevector i) (ash next -16)
                 (aref codevector (1+ i)) next)))
     (values imms-seen 
             codevector 
             immrefs 
             fcells
             vcells)))

; This uses EQ; is EQUAL preferable ?
(defun install-imm (imm immvect)
  (let ((n (fill-pointer immvect)))
    (dotimes (i n (vector-push-extend imm immvect))
      (declare (fixnum i))
      (when (eq imm (aref immvect i))
        (return i)))))

(defun disasm-write (instructions &optional (stream *standard-output*))
  (fresh-line stream)
  (dolist (q instructions)
    (when q
      (disasm-prin1 (pop q) stream)
      (princ " (" stream)
      (while q
        (disasm-prin1 (pop q) stream)
        (if q (tyo #\space stream)))
      (tyo #\) stream)
      (terpri stream)))
  (values))

(defun disasm-prin1 (thing stream)
  (if (and (consp thing) (consp (cdr thing)) (null (cddr thing)))
    (cond ((eq (%car thing) 'quote)
           (prin1 thing stream))
          ((eq (%car thing) 'function)
           (format stream "#'~S" (cadr thing)))
          ((eq (%car thing) 17)
           (format stream 
                   "'#<~S Symbol ~A Locative>" 
                   (cadr (cadr thing))
                   (if (eq (caadr thing) 'function)
                     "Function"
                     "Value")))
          ((eq (%car thing) 16)
             (format stream "#x~X" (cadr thing)))
          ((eq (%car thing) 'label)
           (let ((*print-radix* nil))
             (format stream "~A-~A" (car thing) (cadr thing))))
          (t (princ thing stream)))
    (princ thing stream)))

#-BCCL (progn (%fhave 'df #'disassemble) (%fhave 'dl #'(lambda (f) (disasm-write (disassemble-lfun f)))))

(provide 'disasm)

) ; #-ppc-target

; end
