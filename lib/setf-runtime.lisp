; -*- Mode: Lisp; Package: CCL; -*-

;;	Change History (most recent first):
;;  1 10/3/96  akh  from 3.1 for appgen
;;  (do not edit before this line!!)

;
; setf-runtime.lisp - runtime support for setf expressions
; Copyright 1995 Digitool, Inc. All rights reserved.

; Modification History
;
;  9/18/96 slh   both versions of apply+
;  9/14/95 slh   created from setf.lisp

(in-package "CCL")


(defun set-cadr (list new-value)
  (set-car (cdr list) new-value))

(defun set-cdar (list new-value)
  (set-cdr (car list) new-value))

(defun set-caar (list new-value)
  (set-car (car list) new-value))

(defun set-cddr (list new-value)
  (set-cdr (cdr list) new-value))

(defun %set-nthcdr (index list new-value)
  "If INDEX is 0, just return NEW-VALUE."
  (if (not (zerop index))
    (rplacd (nthcdr (1- index) list)
            new-value))
  new-value)

(defun set-fifth (list new-value)
  (set-car (cddddr list) new-value))

(defun set-sixth (list new-value)
  (set-car (cdr (cddddr list)) new-value))

(defun set-seventh (list new-value)
  (set-car (cddr (cddddr list)) new-value))

(defun set-eighth (list new-value)
  (set-car (cdddr (cddddr list)) new-value))

(defun set-ninth (list new-value)
  (set-car (cddddr (cddddr list)) new-value))

(defun set-tenth (list new-value)
  (set-car (cdr (cddddr (cddddr list))) new-value))

(defun set-caaar (list new-value)
  (set-car (caar list) new-value))

(defun set-caadr (list new-value)
  (set-car (cadr list) new-value))

(defun set-cadar (list new-value)
  (set-car (cdar list) new-value))

(defun set-caddr (list new-value)
  (set-car (cddr list) new-value))

(defun set-cdaar (list new-value)
  (set-cdr (caar list) new-value))

(defun set-cdadr (list new-value)
  (set-cdr (cadr list) new-value))

(defun set-cddar (list new-value)
  (set-cdr (cdar list) new-value))

(defun set-cdddr (list new-value)
  (set-cdr (cddr list) new-value))

(defun set-caaaar (list new-value)
  (set-car (caaar list) new-value))

(defun set-caaadr (list new-value)
  (set-car (caadr list) new-value))

(defun set-caadar (list new-value)
  (set-car (cadar list) new-value))

(defun set-caaddr (list new-value)
  (set-car (caddr list) new-value))

(defun set-cadaar (list new-value)
  (set-car (cdaar list) new-value))

(defun set-cadadr (list new-value)
  (set-car (cdadr list) new-value))

(defun set-caddar (list new-value)
  (set-car (cddar list) new-value))

(defun set-cadddr (list new-value)
  (set-car (cdddr list) new-value))

(defun set-cdaaar (list new-value)
  (set-cdr (caaar list) new-value))

(defun set-cdaadr (list new-value)
  (set-cdr (caadr list) new-value))

(defun set-cdadar (list new-value)
  (set-cdr (cadar list) new-value))

(defun set-cdaddr (list new-value)
  (set-cdr (caddr list) new-value))

(defun set-cddaar (list new-value)
  (set-cdr (cdaar list) new-value))

(defun set-cddadr (list new-value)
  (set-cdr (cdadr list) new-value))

(defun set-cdddar (list new-value)
  (set-cdr (cddar list) new-value))

(defun set-cddddr (list new-value)
  (set-cdr (cdddr list) new-value))

; For use by (setf (apply ...) ...)
; (apply+ f butlast last) = (apply f (append butlast (list last)))
#-ppc-target
(defun apply+ (&lap function &rest args)
  (lap
    (if# (lt (cmp.l ($ 12) nargs))
      (jsr_subprim $sp-n-req-rest)
      (dc.w 12)
      (dc.w #_debugger))
    (vpush arg_x)
    (sub.w ($ 4) nargs)
    (move.l arg_y atemp0)
    (loop#
     (if# (eq nilreg atemp0)
       (bra (exit#)))
     (if# (ne (ttagp ($ $t_cons) atemp0 da))
       (signal_error '#.$xnospread arg_y))
     (vpush (car atemp0))
     (add.w ($ 4) nargs)
     (move.l (cdr atemp0) atemp0))
    (vpush arg_z)
    (vpop_argregs_nz)
    (jmp #'funcall)))

#+ppc-target
(defun apply+ (&lap function arg1 arg2 &rest other-args)
  (ppc-lap-function apply+ ()
   (check-nargs 3 nil)
   (vpush arg_x)
   (mr temp0 arg_z)                     ; last
   (mr arg_z arg_y)                     ; butlast
   (subi nargs nargs '2)                ; remove count for butlast & last
   (mflr loc-pc)
   (bla .SPspreadargz)
   (cmpi cr0 nargs '3)
   (mtlr loc-pc)
   (addi nargs nargs '1)                ; count for last
   (blt cr0 @nopush)
   (vpush arg_x)
@nopush
   (mr arg_x arg_y)
   (mr arg_y arg_z)
   (mr arg_z temp0)
   (lwz temp0 'funcall nfn)
   (ba .SPfuncall)))

; We really need syntax to allow lap functions to have &optional and &rest args
(lfun-bits #'apply+ 
           #.(lfun-bits #'(lambda (function arg1 arg2 &rest other-args)
                            (declare (ignore function arg1 arg2 other-args)))))

; End of setf-runtime.lisp
