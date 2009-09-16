; -*- Mode:Lisp; Package:CCL; -*-
;
; l1-traps.lisp - level-1 trap interface file
; Copyright 1995 Digitool, Inc.

; Modification History
;
; 10/20/95 slh   dumb de-lap: ignore most of file for PPC
;  5/16/95 slh   find-ff-trap, add-ff-trap broken out
;  5/10/95 slh   created from a file by Alan Ruttenberg & Mike Travers

(in-package :ccl)

(defvar *ff-traps* nil
  "association between trap name and cons of offset and trap words vector")

#-ppc-target
(progn

; redefined by new-traps.lisp
(defun find-ff-trap (name)
  (cdr (assq name *ff-traps*)))

; redefined by new-traps.lisp
(defun add-ff-trap (name offset trap-words)
  (let ((pair (cons offset trap-words)))
    (push (cons name pair) *ff-traps*)
    pair))

(defvar *ff-trap-pointer-size* 4096 ; about a thousand traps
  "This is (#_getpointersize *ff-trap-pointer*)")

(defvar *ff-trap-pointer-grow-by* 4096
  "Amount to grow the pointer when we run out of space")

(defvar *ff-trap-pointer* (%register-trap 41246 384 *ff-trap-pointer-size*)
  "this holds the actual code which we will jump to to execute the trap")

(defvar *ff-trap-pointer-end* 0
  "This is the offset to next available word in the trap pointer. Add new inlines here")

(defun register-fftrap (name trapwords)
  "Gets called to set up the inline code for a trap. This happens at either load-trap time,
   or when the fasl is loaded, via the load-time-value form."
  (or (find-ff-trap name)
      (add-to-fftrap-pointer name trapwords)))

(defun add-to-fftrap-pointer (name trapwords)
  "Add the actual inline instructions to the pointer. Must do a $sp_clrcache to make sure that
   Those words are not overridden by some cache slot"
  (let ((offset *ff-trap-pointer-end*))
    (when (> (+ (* 2 (length trapwords)) *ff-trap-pointer-end*) *ff-trap-pointer-size*)
      (resize-fftrap-pointer))
    (loop for word across trapwords
          for offset from *ff-trap-pointer-end* by 2
          do (%put-word *ff-trap-pointer* word offset) 
          finally (setq *ff-trap-pointer-end* (+ 2 offset)))
    (old-lap-inline ()
      (jsr_subprim $sp-clrcache))
    (let ((existing (find-ff-trap name)))
      (cond (existing 
             (setf (%car existing) offset)
             existing)
            (t (add-ff-trap name offset trapwords))))))

(defun resize-fftrap-pointer ()
  (let ((new-size (+ *ff-trap-pointer-size* *ff-trap-pointer-grow-by*)))
    (or (zerop (%register-trap 40992 8 *ff-trap-pointer* new-size))     ; (#_setptrsize *ff-trap-pointer* new-size)
        (let ((new (%register-trap 41246 896 new-size)))        ; (#_newptr :errchk new-size)
          (%register-trap 41006 152 *ff-trap-pointer* new *ff-trap-pointer-size*)       ; (#_blockmove *ff-trap-pointer* new *ff-trap-pointer-size*)
          (setq *ff-trap-pointer* new)))
    (setq *ff-trap-pointer-size* new-size)))

) ; #-ppc-target

; End of l1-traps.lisp
