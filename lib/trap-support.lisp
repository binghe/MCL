; -*- Mode:Lisp; Package:CCL; -*-

;; Trap-suppport.lisp - (formerly traps.lisp)
;; general interface macros to OS traps.
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.
;
;
; Edit history:

;07/21/91 gb %badarg errors in trap encoding.
;05/20/91 gb allow 16-bit data register returns in %register-trap.
;06/21/90 gb define $newTool, $newOS (trap modifier masks) here.
; ----- 2.0a1
;06/02/90 gb :d0 a legal stack-trap keyword.
;05/30/90 gb :ostype now a synonym for :long.
;01/26/90 gb :trap-modifier-bits in encode-trap.  Something more aesthetic would
;            be fine with me.
;12/01/89 gz :ostype and :boolean.
;11/10/89 gz (macro -> (defmacro.
;04/01/89 gz Added :void as output keyword.  Note that the keyword alists
;            are now used by defpascal.
;9/2/88   gz no more list-reverse.
;3/1/88   gz  added in-package.
;9/30/87 jaj renamed this file, formerly traps.lisp
;----------------------------------Version 1.0---------------------------------
;07/05/87 gz (declare (ignore env))
;02/17/87 gb &optional env on all (macro ...)s.
;02/05/87 gz %member -> memq, %assoc -> assq
;01/29/87 gz %put -> put.
;10/04/86 gz Made the keyword alists compile-time constants. define-macro => macro.
; 7/08/86 gz arg-pairs vs argpairs buglet...
; 5/26/86 gz Added %put of version so can tell if loaded

(in-package :ccl)

(defconstant $newTool #x0600)
(defconstant $newOS #x0200)

;(stack-trap [:check-error] ;optional
;            trapno
;            arg-type1 arg1 ... arg-typeN argN
;            &optional (value-type :novalue))
;  where arg-type is one of :word, :long, :ptr and value-type is one of
;    :word, :long, :ptr, or :novalue
;(register-trap [:check-error] ;optional
;               trapno
;               arg-type1 arg1 ... arg-typeN argN
;               &optional (value-type :novalue))
;  where arg-type1 is one of :D0,:D1,...,:D7,:A0,...,:A6 and value-type is
;    one of :novalue, :D0,...:D7,:A0,...,:A6
;    or one of (:signed-integer :d[0-7]), (:unsigned-integer :d[0-7]),
;              (:long/:longint :d[0-7]).
;(error-register-trap &rest args)
;  same as (register-trap :check-error . args)
;
; Examples:
;  _FindWindow:
;   (setq code (stack-trap #xa92c :word horiz :word vert ;The point
;                                 :ptr wptrloc           ;VAR whichWindow
;                                 :word))  ;Returns word
;  _SysBeep:
;   (stack-trap #xa9c8 :word 30)
;  _NewPtr with default error handling:
;   (setq ptr (register-trap :check-error #xa11e :d0 2345 :a0))
;  _Open without default error handing:
;   (setq errcode (logand #xFFFF (register-trap #xa000 :a0 iopb :d0)))
;  _GetGWorld (uses :d0 selector on stack-traps):
;   (stack-trap _QDExtensions :ptr Pcgrafptr 
;                             :ptr PGDHandle 
;                             :d0 (logior (ash 8 16) $selectGetGWorld))

(provide 'trap-support)

(defconstant *stack-trap-arg-keywords*
            '((:word . 3)
              (:long . 1) (:longword . 1) (:ostype . 1) ;Yow, synonyms!
              (:ptr . 0) (:pointer . 0)
              (:d0 . 2)  ; ugh.
              (:boolean . nil)    ; fake keywords
              ))

(defconstant *stack-trap-output-keywords*
             '((:novalue . 0) (:none . 0) (:void . 0) (nil . 0) ;Nil makes it so omitting it is allowed
               (:word . 7)
               (:long . 5) (:longword . 5)
               (:ptr . 4) (:pointer . 4)
               (:boolean . nil)
               ))

(defconstant *register-trap-arg-keywords*
             '((:d0 . 0) (:d1 . 1) (:d2 . 2) (:d3 . 3)
               (:d4 . 4) (:d5 . 5) (:d6 . 6) (:d7 . 7)
               (:a0 . 8) (:a1 . 9) (:a2 . 10) (:a3 . 11)
               (:a4 . 12) (:a5 .13) (:a6 . 14)))

(defconstant *register-trap-output-keywords*
              '((:novalue . 0) (:none . 0) (:void . 0) (nil . 0)
                (:d0 . #x10) (:d1 . #x11) (:d2 . #x12) (:d3 . #x13)
                (:d4 . #x14) (:d5 . #x15) (:d6 . #x16) (:d7 . #x17)
                (:a0 . #x18) (:a1 . #x19) (:a2 . #x1A) (:a3 . #x1B)
                (:a4 . #x1C) (:a5 . #x1D) (:a6 . #x1E)))

(defconstant *error-check-keywords* '(:check-error :error-check :error :errchk))

(defun encode-trap (fn trap arg-pairs arg-alist arg-width output-alist error-check-p
                       &aux (argspec 0) (arglist nil) (bit-no 0) type (boolean-p nil)
                       zero-extend-p sign-extend-p)
  (flet ((badarg () (signal-program-error "Syntax error in trap call.")))
    (tagbody
      loop
      (if (null (%cdr arg-pairs)) (go done))
      (when (eq (%car arg-pairs) :trap-modifier-bits)
        (let ((bits (car (%cdr arg-pairs))))
          (unless bits (badarg))
          (setq trap `(logior ,trap ,bits)
                arg-pairs (%cddr arg-pairs)))
        (go loop))
      (if (null (setq type (assq (%car arg-pairs) arg-alist)))
        (badarg))
      (if (null (setq arg-pairs (%cdr arg-pairs))) (badarg))
      (when (eq (%car type) :boolean)
        (setq arg-pairs
              (list* :word `(if ,(%car arg-pairs) -1 0) (%cdr arg-pairs)))
        (go loop))
      (setq argspec (+ (lsh (%cdr type) bit-no) argspec))
      (setq bit-no (%i+ bit-no arg-width))
      (setq arglist (cons (%car arg-pairs) arglist))
      (setq arg-pairs (%cdr arg-pairs))
      (go loop)
      done
      (let* ((resultspec (%car arg-pairs)))
        (when (and (consp resultspec)
                   (consp (%cdr resultspec))
                   (null (%cddr resultspec)))
          (ecase (%car resultspec)
            (:signed-integer (setq sign-extend-p t))
            (:unsigned-integer (setq zero-extend-p t))
            ((:long :longint)))
          (setq resultspec (%cadr resultspec)))
        (if (null (setq type (assq resultspec output-alist)))
          (badarg)))
      (when (eq (%car type) :boolean)
        (setq boolean-p t)
        (setq type (assq :word output-alist)))
      (setq argspec (+ (lsh (+ (if error-check-p  (lsh 1 (%i+ arg-width 1)) 0)
                               (if zero-extend-p 
                                 (lsh 1 (%i+ arg-width 2))
                                 (if sign-extend-p 
                                   (lsh 3 (%i+ arg-width 2))
                                   0))
                               (%cdr type))
                            bit-no)
                       argspec)))
    (let ((call `(,fn ,trap ,argspec ,@(nreverse arglist))))
      (when boolean-p (setq call `(%ilogbitp 8 ,call)))
      call)))
   
(defmacro stack-trap (trap &rest arg-pairs &aux (error-check-p nil))
  (when (memq trap *error-check-keywords*)
    (setq error-check-p t trap (%car arg-pairs) arg-pairs (%cdr arg-pairs)))
  (encode-trap '%stack-trap trap
               arg-pairs *stack-trap-arg-keywords* 2
               *stack-trap-output-keywords* error-check-p))

(defmacro register-trap (trap &rest arg-pairs &aux (error-check-p nil))
  (when (memq trap *error-check-keywords*)
    (setq error-check-p t trap (%car arg-pairs) arg-pairs (%cdr arg-pairs)))
  (encode-trap '%register-trap trap
               arg-pairs *register-trap-arg-keywords* 4
               *register-trap-output-keywords* error-check-p))

(defmacro error-register-trap (trap &rest arg-pairs)
  `(register-trap :check-error ,trap ,@arg-pairs) )

(provide 'trap-support)
; End of Trap-support.lisp
