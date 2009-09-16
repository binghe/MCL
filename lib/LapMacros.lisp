;;;-*-Mode: LISP; Package: CCL -*-

; lapmacros.lisp - Useful lap definitions.
;; Copyright 1986-1988 Coral Software Corp.
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.

;Lisp equivalents of (some of) macros.i/constants.i and other useful stuff.

; Modification History
;
;10/20/95 slh  empty for PPC
;07/07/93 bill mkchar.w now uses 16 bits of its args.
;------------- 3.0d12
;11/20/92 gb   new vector headers; flip car & cdr.
;12/09/92 bill Add dbfloop & dbfloop.l to *fred-special-indent-alist*
;-------------- 2.0
;07/17/91 bill add T & F to *lap-inverted-ccs*
;07/21/91 gb   New without-interrupts.  Wtaerr macros want "right-type" arg.
;05/20/91 gb   dtagp.  Support FPU a bit better.
;02/07/91 alice ccl; =>ccl:
;--------------- 2.0b1
;10/31/90 gb   null.
;09/30/90 bill with-saved-regs
;06/06/90 gb   [t]signal_restart.
;05/22/90 gb   no more symtag[p].
;04/30/90 gb   index->address, address->index for stack walkers.
;01/01/90 gb   no more if, when, unless, while, until.
;12/28/89 gz   'lapgen => *lapgens*
;12/08/89 bill Added without-interrupts, with-saved-argregs
; 12/05/89 gb  with-preserved-registers
;11/16/89 bill Added symbol-function-locative & symbol-value-locative lapop's
;10/25/89 bill Added vpush_argregs
; 9/11/89  gz  (%cdr (%sym-value-loc x)) -> (%sym-value x)
; 8/24/89  gb  begin_cstraps uses trap-sp.  Some stack-trap utilities.
; 5/31/89  gz  while#/until# loops.
; 4/4/89   gz  bmovup, some floating point macros.  Try to avoid evaluating
;              subprim constants at compile-time (of this file).
; 03/09/89 gz  store_float, vpop_argregs, bmovdown.
;              restore_regs takes a source arg.
;              mkchar doesn't getint, for kernel compatibility.
; 01/02/89 gz  Allow a symbol in preserve_regs meaning vpush.
;              Added lfjsr, lfjmp.
;11/23/88  gz  Eval the displacement arg to VARG.
;11/16/88  gz  added vref, svref, csarea, loop#, dbfloop. Made defreg/equate take
;              multiple args, added eval.
;10/27/88  gb  added EQUATE, which might want to be called something else.
;10/23/88  gb  8.9 uoload.
; 9/23/88  gb  missing quote in EXITLISP.
; 9/8/88   gb  no cfp.
; 9/02/88  gz  added tail-ccall.  Fix in ttagp.  Added defreg
; 8/26/88  gz  added [t]signal_error.
; 8/19/88  gz  setpred takes an optional temp register.
; 8/17/88  gz  lap-instr -> lap.lisp
; 8/17/88  gb  Another varg.
; 8/16/88  gz  Added varg, car, cdr operand macros.
;	       protect_caller, unprotect_caller, vsize, preserve_regs,
;	       restore_regs, prog#, bif.  Allow andif# in else# clauses.
;	       Allow boolean expressions in lap-test.
;	       Added lap-instr helper fn for better error messages.
;	       Use new (@+ reg) syntax, let lap handle fixnums, fixed some typos.
; 10/11/87 jaj subprims.lisp now loaded from internal rather than lib
;-----------------------------Version 1.0---------------------------------
; 7/23/87  gz  flush unused lex var.
; 7/12/87  gb  Provide thyself.
; 7/06/87  gb  commented-out old lfunentry macro.
; 6/12/87  gb  proclaim all specials.
; 6/05/87  gb  31-bit fixnums.
; 5/20/87  gb  $last_arg set to 4.
; 4/28/87  gz  made lfentry accept -1 as # of optionals, use ndoadl. Added
;              $fixnumbit. rearranged to simplify bootstrapping.
; 4/16/87  gz  fix for optional args in lfentry
; 3/15/87  gz  added $tval
; 3/4/87   gz  added lfentry, lfret.
; 3/3/87   gz  added bindsym, ccall, $_car, $_cdr
; 2/20/87  gz  include subprims. set $last_arg in startlfun
; 01/17/87 gz  Added $qmkstkblk
; 01/14/87 gb  %get -> get.
; 12/27/86 gz  New file

(in-package :ccl)

#-ppc-target
(progn

(eval-when (eval compile)
  (require 'sysequ)
  (require'backquote))

(eval-when (eval compile load)
  (require 'lispequ)
  (require'lap))

(eval-when (eval compile)
  (%include "ccl:compiler-68K;subprims8.lisp"))

(dolist (x '#.*subprims8-alist*)
  (define-constant (car x) (cadr x)))

(deflapgen bgeu (gethash 'bcc *lapgens*))
(deflapgen bgtu (gethash 'bhi *lapgens*))
(deflapgen bleu (gethash 'bls *lapgens*))
(deflapgen bltu (gethash 'bcs *lapgens*))

(deflapgen sgtu (gethash 'shi *lapgens*))
(deflapgen sleu (gethash 'sls *lapgens*))
(deflapgen sgeu (gethash 'scc *lapgens*))
(deflapgen sltu (gethash 'scs *lapgens*))

(deflapgen noop (gethash 'nop *lapgens*))

(defparameter *lap-typemask* `($ ,$typemask))

(defparameter *lap-stack-trap-destination* nil)
(defparameter *lap-stack-trap-remaining-args* nil)
(defparameter *lap-stack-trap-args* nil)

(deflapop fixnum (n)
   (unless (fixnump (setq n (lap-abs-val n))) (lap-error))
  `(quote ,n))

; These things probably shouldn't be done this way.
(deflapop symbol-function-locative (symbol)
  (unless (symbolp symbol) (lap-error))
  `(quote ,(lap-inline (symbol) (add.l ($ $sym.fapply) acc))))

(deflapop symbol-value-locative (symbol)
  (unless (symbolp symbol) (lap-error))
  `(quote ,(lap-inline (symbol) (add.l ($ $sym.gvalue) acc))))

(defun find-reg (regnum reglist)
  (dolist (pair reglist)
    (when (eq (cdr pair) regnum)
      (return (car pair)))))

(deflapop varg (sym &optional (disp 0))
  (setq disp (lap-abs-val disp))
  (locally 
   (declare (special *lap-vars* *lap-vtop*))
   (let ((ea (cdr (assq sym *lap-vars*))))
     (if (not ea) (lap-error))
     (multiple-value-bind (reg mode offset)
                          (nx2-decode-spec ea (+ *lap-vtop* disp))
       (let ((regname (find-reg reg (if (eq mode 0) *lap-dregs* *lap-aregs*))))
         (case mode
           ((0 1) regname)
           (2 (list regname))
           (5 (list regname offset))
           (t (lap-error))))))))

;A little helper function.
(defun lap-move.l (source dest) (%lap-expr 'move.l source dest))
(defun lap-move.w (source dest) (%lap-expr 'move.w source dest))

(deflapgen progn (&rest forms)
  (dolist (form forms) (lap-instr form)))

;This is supposed to generate the words at compile-time instead of run-time,
; when we have that capability again...
(eval-when (eval compile load)
  (defmacro gen-lap-words (&rest instructions)
     `(apply #'%lap-expr 'progn ',instructions)))

(deflapgen defreg (&rest name-reg-pairs &aux name reg)
  (while name-reg-pairs
    (setq name (pop name-reg-pairs))
    (setq reg (lap-reg-op (pop name-reg-pairs)))
    (if (%i< reg 8)
      (push (cons name reg) *lap-dregs*)
      (push (cons name (%i- reg 8)) *lap-aregs*))))

(deflapgen spush (arg) (lap-move.l arg '-@sp))

(deflapgen spop (arg) (lap-move.l 'sp@+ arg))

(deflapgen vpush (arg) (lap-move.l arg '-@vsp))

(deflapgen vpop (arg) (lap-move.l 'vsp@+ arg))

(deflapgen vpop_argregs_nz ()
  (gen-lap-words
   (if# (eq (cmp.w ($ 8) nargs))
     (vpop arg_z)
     (vpop arg_y)
    elseif# mi
     (vpop arg_z)
    else#
     (movem.l (@+ vsp) #(arg_x arg_y arg_z)))))

(deflapgen vpop_argregs ()
  (gen-lap-words (if# (ne (tst.w nargs)) (vpop_argregs_nz))))

(deflapgen vpush_argregs_nz ()
  (gen-lap-words
   (if# (eq (cmp.w ($ 8) nargs))
     (vpush arg_y)
     (vpush arg_z)
    elseif# mi
     (vpush arg_z)
    else#
     (movem.l #(arg_x arg_y arg_z) -@vsp))))

(deflapgen vpush_argregs ()
  (gen-lap-words (if# (ne (tst.w nargs)) (vpush_argregs_nz))))

;; Executes BODY with argregs pushed on the stack
(deflapgen with-saved-argregs (&rest body)
  (lap-instr
   `(progn (if# (ne (spush nargs))
             (vpush_argregs_nz))
           ,@body
           (if# (ne (spop nargs))
             (vpop_argregs_nz)))))

(deflapgen with-saved-regs (regs &rest body)
  (let ((len (length regs)))
    (lap-instr
     (if (eql 0 len)
       `(progn ,@body)
       `(progn
          ,(if (eql 1 len)
             `(vpush ,(svref regs 0))
             `(movem.l ,regs -@vsp))
          ,@body
          ,(if (eql 1 len)
             `(vpop ,(svref regs 0))
             `(movem.l vsp@+ ,regs)))))))

(deflapgen car (areg dest) (lap-move.l (list areg $_car) dest))
(deflapgen cdr (areg dest) (lap-move.l (if (eq (lap-areg-op-p dest) (lap-areg-op areg))
                                         (list '-@ areg)
                                         (list areg $_cdr))
                                       dest))

(deflapop car (areg) `(,areg ,$_car))
(deflapop cdr (areg) `(,areg ,$_cdr))

(deflapgen null (arg) (apply #'%lap-expr `(cmp.l ,arg nilreg)))
(deflapgen rplaca (areg val) (lap-move.l val (list 'car areg)))
(deflapgen rplacd (areg val) (lap-move.l val (list 'cdr areg)))

(deflapop vref.b (areg index &optional (byte-offset 0))
  `(,areg (+ $v_data ,index ,byte-offset)))
(deflapop vref.w (areg index &optional (byte-offset 0))
  `(,areg (+ $v_data (%ilsl 1 ,index) ,byte-offset)))
(deflapop vref.l (areg index &optional (byte-offset 0))
  `(,areg (+ $v_data (%ilsl 2 ,index) ,byte-offset)))
(deflapop svref (&rest args) `(vref.l ,@args))

(deflapgen begin_csarea ()
  (gen-lap-words (spush (a5 $csarea)) (move.l sp (a5 $csarea))))

(deflapgen spop_csarea ()
  (gen-lap-words (spop (a5 $csarea))))

(deflapgen restore_csarea ()
  (gen-lap-words (move.l (a5 $csarea) sp) (spop (a5 $csarea))))

(deflapgen spop_discard_csarea ()
  (gen-lap-words (spop sp) (spop (a5 $csarea))))

(deflapgen discard_csarea ()
  (gen-lap-words (move.l (a5 $csarea) sp) (spop_discard_csarea)))

(deflapgen csarea_trap (trapnum)
  (%lap-expr 'jsr_subprim '$sp-csarea_trap)
  (%lap-expr 'dc.w trapnum))

(deflapgen begin_cstraps ()
  (gen-lap-words (clr.l -@sp) (begin_csarea) (exitlisp) (move.l (a5 $trap_sp) sp)))

(deflapgen end_cstraps ()
  (gen-lap-words (enterlisp) (restore_csarea) (add.w ($ 4) sp)))

; simple without-interrupts.
; VSP is decrememted by 3 * 4 (dynamic binding frame)
;  SP has a catch frame pushed on it when BODY runs.
; The single value returned by the body is in ACC on exit.
(deflapgen without-interrupts (&rest body)
  (apply '%lap-expr
         `(progn
            (jsr_subprim $sp-woi)
            ,@body
            (jsr_subprim $sp-nthrow1v1))))

(deflapgen ttag (node dreg)
  (let ((dest-mode (lap-dreg-op dreg)))
    (cond ((eq (lap-dreg-op-p node) dest-mode)
           (%lap-expr 'and.w *lap-typemask* dreg))
          ((lap-areg-op-p node)
           (%lap-expr 'move.w node dreg)
           (%lap-expr 'and.w *lap-typemask* dreg))
          (t
           (lap-move.l *lap-typemask* dreg)
           (if (lap-dreg-op-p node)
             (%lap-expr 'and.w node dreg)
             (%lap-expr 'and.l node dreg))))))

(deflapgen ttagp (type node dest)
  (if (fixnump type)
    (setq type `($ ,type)))
  (%lap-expr 'ttag node dest)
  (unless (and (consp type)
               (eq (%car type) '$)
               (%izerop (lap-abs-val (cadr type))))
    (%lap-expr 'sub.b type dest)))

(deflapgen dtagp (dreg &rest tags)
  (%lap-expr 'btst dreg `($ (logior ,@(mapcar #'(lambda (bit) `(ash 1 ,bit)) tags)))))

(deflapgen set_nargs (count)
   (lap-move.l (list '$ (list '* 4 count)) 'nargs))

(deflapgen lsr2 (amt dest)
  (%lap-expr 'q2 
             (case (or *lap-cur-size* 1)
               (2 'lsr.l)
               (1 'lsr.w)
               (t 'lsr.b))
             amt 
             dest
             (case (or *lap-cur-size* 1)
               (2 'lsl.l)
               (1 'lsl.w)
               (t 'lsl.b))))

(deflapgen add2 (amt dest)
  (%lap-expr 'q2 (case (or *lap-cur-size* 1)
                 (2 'add.l)
                 (1 'add.w)
                 (t 'add.b))
             amt dest
             (case (or *lap-cur-size* 1)
                 (2 'sub.l)
                 (1 'sub.w)
                 (t 'sub.b))))

(deflapgen sub2 (amt dest)
  (%lap-expr 'q2 
             (case (or *lap-cur-size* 1)
               (2 'sub.l)
               (1 'sub.w)
               (t 'sub.b))
             amt 
             dest
             (case (or *lap-cur-size* 1)
                 (2 'add.l)
                 (1 'add.w)
                 (t 'add.b))))

; bytes 8-31 of result undefined on exit!
(deflapgen header-subtype (src dest)
  (%lap-expr 'movereg.w src dest)
  (%lap-expr 'lsr.w '($ #.(- $header-vector-length-shift 8)) dest)
  (%lap-expr 'lsr.b '($ #.(- $header-subtype-shift (- $header-vector-length-shift 8))) dest))

(deflapgen header-length (src dest)
  (%lap-expr 'movereg.l src dest)
  (%lap-expr 'lsr2.l '($ $header-vector-length-shift) dest))

(deflapgen header-length-subtype (src len sub)
  (%lap-expr 'movereg.l src len)
  (%lap-expr 'lsr.l '($ (- $header-vector-length-shift 8)) len)
  (%lap-expr 'move.b len sub)
  (%lap-expr 'lsr.l '($ 8) len)
  (%lap-expr 'lsr.b '($ (- $header-subtype-shift (- $header-vector-length-shift 8))) sub))

(deflapgen vector-length-subtype (avect dlen dsub)
  (%lap-expr 'header-length-subtype `(,avect #.$vec.header) dlen dsub))

(deflapgen vsubtype (avect dest)
   (%lap-expr 'header-subtype `(,avect #.$vec.header_low) dest))

(deflapgen vsubtypep (type avect dtemp)
  (%lap-expr 'vsubtype avect dtemp)
  (%lap-expr 'cmp.b type dtemp))

(deflapgen vsubtype= (type avect dtemp)
  (lap-instr
   `(progn
      (move.w (,avect $vec.header_low) ,dtemp)
      (lsl.w ($ #.(- 16 $header-vector-length-shift)) ,dtemp)
      (cmp.w ($ ,(ash (logior (ash (lap-count-op type 0 62) $header-subtype-shift) $header-nibble) 
                      (- 16 $header-vector-length-shift))) ,dtemp))))

(deflapgen build-vector-header (len subtype ddest)
  (apply #'%lap-expr 
   `(progn
      (movereg ,len ,ddest)
      (lsl.l ($ #.(- $header-vector-length-shift $header-subtype-shift)) ,ddest)
      (add.b ,subtype ,ddest)
      (lsl.l ($ #.$header-subtype-shift) ,ddest)
      (add2.b ($ #.$header-nibble) ,ddest))))

(deflapgen header-p (src temp)
  (apply #'%lap-expr
         `(progn
            (moveq #.$header-nibble-mask ,temp)
            (,(case (or *lap-cur-size* 0)
                 (2 'and.l)
                 (1 'and.w)
                 (t 'and.b))
             ,src ,temp)
            (sub2.b ($ #.$header-nibble) ,temp))))

(deflapop header (subtype length)
  `($ (logior (ash ,length $header-vector-length-shift) (ash ,subtype $header-subtype-shift) $header-nibble)))
         
(deflapgen set_vsubtype (type avect dtemp)
  (apply #'%lap-expr
         `(progn
            (vsize ,avect ,dtemp)
            (build-vector-header ,dtemp ,type ,dtemp)
            (move.l ,dtemp (,avect #.$vec.header)))))

(deflapgen change_vsubtype (avect old new)
  (%lap-expr 'add.w `($ (ash (- ,new ,old) 4)) `(,avect ,$vec.header_low)))

(deflapgen vsize (avect dreg)
  (%lap-expr 'header-length `(,avect ,$vec.header) dreg))

(deflapgen getvect-header (avect dest)
  (%lap-expr 'sub.w '($ #.(- $vec.header)) avect)
  (%lap-expr 'move.l `(@+ ,avect) dest))
        
(deflapgen getvect (avect dlen)
  (%lap-expr 'getvect-header avect dlen)
  (%lap-expr 'header-length dlen dlen))

(deflapgen jsr_subprim (n)
   (%lap-expr 'jsr (list 'a5 n)))

(deflapgen jmp_subprim (n)
   (%lap-expr 'jmp (list 'a5 n)))

(deflapgen strap-reserve (n)
  (%lap-expr 'move.l `($ (+ 8 ,n)) 'arg_z)
  (%lap-expr 'jsr '(a5 $sp-mknlisparea)))

(deflapgen begin-stacktrap (argspecs &rest body)
  (let* ((n (lap-stack-trap-argbytes argspecs))
         (*lap-stack-trap-args* argspecs)
         (*lap-stack-trap-remaining-args* argspecs)
         (*lap-stack-trap-destination*  n))
    (declare (special *lap-stack-trap-destination*
                      *lap-stack-trap-remaining-args*))
    (%lap-expr 'strap-reserve n)
    (apply #'%lap-expr 'progn body)
    (when *lap-stack-trap-remaining-args*
      (lap-error "Unused stack trap arguments : ~s"
                 *lap-stack-trap-remaining-args*))))

(defun lap-stack-trap-argbytes (argspecs)
  (let ((i 0))
    (dolist (spec argspecs i)
      (cond ((eq spec :long)
             (setq i (+ i 4)))
            ((eq spec :word)
             (setq i (+ i 2)))
            (t (lap-error
                "Unknown trap argument specifier ~s in ~s . "
                spec argspecs))))))

(deflapgen strap-arg (form)
  (let* ((args *lap-stack-trap-remaining-args*)
         (argspec (if args 
                    (pop *lap-stack-trap-remaining-args*)
                    (lap-error "Spurious stack trap argument ~s" form)))
         (size (if (eq argspec :long) 4 2)))
    (apply #'%lap-expr `(move.l ,form (sp ,*lap-stack-trap-destination*)))
    (setq *lap-stack-trap-destination* (- *lap-stack-trap-destination* size))))

(deflapgen regtrap (trapnum)
   (%lap-expr 'jsr '(a5 $sp-rtrap))
   (%lap-expr 'dc.w trapnum))

(deflapgen regtrapd0 (trapnum)
   (%lap-expr 'jsr '(a5 $sp-rtrapd0))
   (%lap-expr 'dc.w trapnum))

(deflapgen stacktrap (trapnum &optional nwords)
  ;(declare (ignore nwords))
  nwords
  (%lap-expr 'jsr '(a5 $sp-strap))
  (%lap-expr 'dc.w trapnum))

;Bring things to a state where an RTS will return from the lfun.
(deflapgen lfunlk (&optional (restore-vsp t))
  (when restore-vsp (gen-lap-words (spop vsp))))

(deflapgen lfret (&optional (restore-vsp t))
  (%lap-expr 'lfunlk restore-vsp)
  (gen-lap-words (rts)))

(deflapgen fsymevalapply (sym &optional nargs)
  (when nargs (%lap-expr 'set_nargs nargs))
  (when (quoted-form-p sym) (setq sym (cadr sym)))
  (unless (symbolp sym) (lap-error))
  (%lap-expr 'jsr `(function ,sym)))

(deflapgen fsymevaljmp (sym &optional nargs)
  (when nargs (%lap-expr 'set_nargs nargs))
  (when (quoted-form-p sym) (setq sym (cadr sym)))
  (unless (symbolp sym) (lap-error))
  (%lap-expr 'jmp `(function ,sym)))

(deflapgen lfjsr (where)
  (%lap-expr 'movereg where 'atemp0)
  (%lap-expr 'jsr '(atemp0)))

(deflapgen lfjmp (where)
  (%lap-expr 'movereg where 'atemp0)
  (%lap-expr 'jmp '(atemp0)))

(defun set-one-reg (reg arg)
  (unless (eq (lap-reg-op-p arg) (lap-reg-op reg))
    (%lap-expr (case (or *lap-cur-size* 2)
                 (2 'move.l)
                 (1 'move.w)
                 (t 'move.b)) arg reg)))

(defun set-two-regs (reg1 arg1 reg2 arg2)
  (let ((op1 (lap-reg-op reg1))
        (op2 (lap-reg-op reg2)))
    (if (eq op1 (lap-reg-op-p arg2))
      (if (eq op2 (lap-reg-op-p arg1))
        (%lap-expr 'exg reg1 reg2)
        (progn
          (lap-move.l reg1 reg2)
          (set-one-reg reg1 arg1)))
      (progn
        (set-one-reg reg1 arg1)
        (set-one-reg reg2 arg2)))))

(defun set-three-regs (reg1 arg1 reg2 arg2 reg3 arg3)
  (let ((op1 (lap-reg-op reg1))
        (op2 (lap-reg-op reg2))
        (op3 (lap-reg-op reg3))
        (type1 (lap-reg-op-p arg1))
        (type2 (lap-reg-op-p arg2))
        (type3 (lap-reg-op-p arg3)))
    (cond ((eq type3 op1)
           (cond ((eq type1 op3)
                  (set-one-reg reg2 arg2)
                  (%lap-expr 'exg reg3 reg1))
                 ((eq type2 op3)
                  (if (eq type1 op2)
                    (progn
                      (%lap-expr 'exg reg1 reg2)
                      (%lap-expr 'exg reg2 reg3))
                    (progn
                      (lap-move.l reg3 reg2)
                      (set-two-regs reg1 arg1 reg3 arg3))))
                 (t
                  (lap-move.l reg1 reg3)
                  (set-two-regs reg1 arg1 reg2 arg2))))
          ((eq type3 op2)
           (set-three-regs reg2 arg2 reg1 arg1 reg3 arg3))
          (t
           (set-two-regs reg1 arg1 reg2 arg2)
           (set-one-reg reg3 arg3)))))
          

(defun lap-arglist (args &optional (vpushlimit 3) &aux (m (length args)) (n m))
  (while (%i> m vpushlimit)
    (%lap-expr 'vpush (pop args))
    (setq m (%i- m 1)))
  (if (eq m 3)
    (set-three-regs 'arg_x (pop args) 'arg_y (pop args) 'arg_z (%car args))
    (if (eq m 2)
      (set-two-regs 'arg_y (pop args) 'arg_z (%car args))
      (if (eq m 1)
        (set-one-reg 'arg_z (%car args)))))
  n)

(deflapgen movereg (src dest)
  (set-one-reg dest src))

(deflapgen dbcc-l (cc dreg lab)
  (%lap-expr '.dbcc cc dreg lab)
  (%lap-expr 'add.w '($ 1) dreg)
  (%lap-expr 'sub.l '($ 1) dreg)
  (%lap-expr 'bcc lab))

(deflapgen dbfl (dreg lab)
  (%lap-expr 'dbcc-l 'f dreg lab))

(pushnew '(dbfloop . 1) *fred-special-indent-alist*
         :key #'car)
(pushnew '(dbfloop.l . 1) *fred-special-indent-alist*
         :key #'car)

(deflapgen dbfloop (dreg &rest instrs &aux (L0 (gensym)) (L1 (gensym)))
  (lap-instr `(progn
                (bra ,L1)
                ,L0
		,@instrs
		,L1
		(,(if (eq *lap-cur-size* 2) 'dbfl 'dbf) ,dreg ,L0))))

;Move dcount bytes, words, or longs from asrc to adst. (if moving bytes,
;must be an even number).
(deflapgen bmovdown (asrc adst dcount &aux (l0 (gensym)) (l1 (gensym)))
  (unless (eq *lap-cur-size* 2)
    (%lap-expr 'lsr.l (if (eq *lap-cur-size* 0) 2 1) dcount)
    (%lap-expr 'bcc l1)
    (%lap-expr 'move.w `(@+ ,asrc) `(@+ ,adst)))
  (lap-instr `(progn
                (bra ,l1)
                ,l0 (move.l (@+ ,asrc) (@+ ,adst))
                ,l1 (dbfl ,dcount ,l0))))

(deflapgen bmovup (asrc adst dcount &aux (l0 (gensym)) (l1 (gensym)))
  (unless (eq *lap-cur-size* 2)
    (%lap-expr 'lsr.l (if (eq *lap-cur-size* 0) 2 1) dcount)
    (%lap-expr 'bcc l1)
    (%lap-expr 'move.w `(-@ ,asrc) `(-@ ,adst)))
  (lap-instr `(progn
                (bra ,l1)
                ,l0 (move.l (-@ ,asrc) (-@ ,adst))
                ,l1 (dbfl ,dcount ,l0))))

(defparameter *lap-last-preserved-regs* ())
(deflapgen preserve_regs (&optional (regs '#(asave0 asave1 dsave0 dsave1 dsave2)))
  (nx2-note-register-usage (lap-register-mask regs #o46)) ; #o46 = $vpush.
  (if (symbolp regs)
    (%lap-expr 'vpush regs)
    (%lap-expr 'movem.l regs '-@vsp))
  (push regs *lap-last-preserved-regs*))

(deflapgen unuse_regs (&optional (source 'vsp@+))
  (let ((regs (car *lap-last-preserved-regs*)))
    (if regs
      (%lap-expr (if (symbolp regs) 'move.l 'movem.l) source regs)
      (lap-error "no registers to restore"))))

(deflapgen restore_regs (&optional (source 'vsp@+))
  (let ((regs (pop *lap-last-preserved-regs*)))
    (if regs
      (%lap-expr (if (symbolp regs) 'move.l 'movem.l) source regs)
      (lap-error "no registers to restore"))))

(deflapgen with-preserved-registers (regs &rest body)
  (lap-instr
   `(progn
      (preserve_regs ,regs)
      ,@body
      (restore_regs))))

(deflapgen ccall (fsym &rest args)
   (%lap-expr 'fsymevalapply fsym (lap-arglist args)))

(deflapgen cjmp (fsym &rest args)
   (%lap-expr 'fsymevaljmp fsym (lap-arglist args)))

(deflapgen tail-ccall (fsym &rest args)
  (let ((n (lap-arglist args)))
    (if (%i<= n 3)
      (progn
        (lap-instr '(lfunlk))
        (%lap-expr 'fsymevaljmp fsym n))
      (lap-error "Not implemented"))))

(deflapgen signal_error (&rest args)
  (%lap-expr 'set_nargs (lap-arglist args))
  (%lap-expr 'jsr_subprim '$sp-ksignalerr))

(deflapgen signal_restart (&rest args)
  (apply #'%lap-expr `(ccall %kernel-restart ,@args)))

(deflapgen tsignal_error (&rest args)
  (%lap-expr 'set_nargs (lap-arglist args))
  (%lap-expr 'jmp_subprim '$sp-ksignalerr))

(deflapgen Tsignal_restart (&rest args)
  (apply #'%lap-expr `(cjmp %kernel-restart ,@args)))

(deflapgen getint (dreg)
  (%lap-expr 'asr.l 3 dreg))

(deflapgen mkint (dreg)
  (%lap-expr 'lsl.l 3 dreg))

(deflapgen getflt (areg low high)
  (lap-move.l (list areg (- $t_dfloat)) low)
  (lap-move.l (list areg (- 4 $t_dfloat)) high))

;lap supports the 68881...
(deflapgen store_float (areg freg)
  (%lap-expr 'fmove.d `(,areg $floathi) freg))

(deflapgen get_fpcr (dst)
  (%lap-expr 'dc.w (%i+ #xF200 (lap-dreg-op dst)) #xB000))
(deflapgen set_fpcr (src)
  (%lap-expr 'dc.w (%i+ #xF200 (lap-dreg-op src)) #x9000))

; Destination -must- be an fpreg; source may or may not be.
(defun lap-fp-op-to-reg (src dest-fpreg k-factor extension)
  (declare (ignore k-factor))
  (let* ((src-fpreg (lap-freg-op-p src)))
    (if src-fpreg
      (%fpgen 0 src-fpreg dest-fpreg extension)
      (multiple-value-bind (ea-mode-reg ea-extension) (lap-std-operand src)
        (%fpgen 2 *lap-cur-fp-size* dest-fpreg extension ea-mode-reg ea-extension)))))

(deflapfpgen fmove (src dest &optional k-factor)
  (let ((src-fpreg (lap-freg-op-p src))
        (dest-fpreg (lap-freg-op-p dest)))
    (cond ((and src-fpreg (not dest-fpreg))
           (multiple-value-bind (ea-mode-reg ea-extension)
                                (lap-std-operand dest)
             (%fpgen 3 *lap-cur-fp-size* src-fpreg 0 ea-mode-reg ea-extension)))
          (t (lap-fp-op-to-reg src (lap-freg-op dest) k-factor 0)))))

(dolist (pair '((fint . 1)
                (fsinh . 2)
                (fintrz . 3)
                (fsqrt . 4)
                (flognp1 . 6)
                (fetoxm1 . 8)
                (fatanh . 9)
                (fatan . 10)
                (fasin . 12)
                (fatanh . 13)
                (fsin . 14)
                (ftan . 15)
                (fetox . 16)
                (ftwotox . 17)
                (ftentox . 18)
                (flogn . 20)
                (facos . 28)
                (fcos . 29)
                (fdiv . 32)
                (fadd . 34)
                (fmul . 35)
                (fscale . 38)
                (fsub . 40)))
  (let ((extension (cdr pair)))
    (setf (gethash (car pair) *lapfpgens*)
          (nfunction standard-fp-op (lambda (src &optional (dest src) k-factor)
                                      (lap-fp-op-to-reg src (lap-freg-op dest) k-factor extension))))))

(deflapgen getchar (dreg)
  (%lap-expr 'swap dreg)
  (%lap-expr 'ext.l dreg)
  (%lap-expr 'mkint dreg))

(deflapgen mkchar (dreg &aux (size *lap-cur-size*))
  (%lap-expr 'and.w (if (eq size 1) '($ #xFFFF) '($ #xff)) dreg)
  (%lap-expr 'swap dreg)
  (%lap-expr 'move.w '($ $t_imm_char) dreg))

(deflapgen sympname (asym dest)
  (lap-move.l (list asym $SYM.PNAME) dest))

(deflapgen bindsym (sym &optional (val nil val-p))
  (if (quoted-form-p sym)
    (setq sym (cadr sym)))
  (unless (symbolp sym) (lap-error))
  (when val-p (lap-move.l val 'acc))
  (%lap-expr 'lea `(special ,sym) 'atemp0)
  (%lap-expr 'jsr_subprim '$sp-dbind))

; This does a boundp check on the locative.
(deflapgen specref (sym)
  (if (quoted-form-p sym)
    (setq sym (cadr sym)))
  (unless (symbolp sym) (lap-error))
  (%lap-expr 'lea `(special ,sym) 'atemp0)
  (%lap-expr 'jsr_subprim '$sp-specref))

(deflapgen setpred (cc &optional tempreg)
  (%lap-expr '.scc cc 'acc)
  (if tempreg
    (progn
      (%lap-expr 'move.l '($ $t_val) tempreg)
      (%lap-expr 'and.l tempreg 'acc))
    (%lap-expr 'and.l `($ ,$t_val) 'acc))
  (%lap-expr 'add.l 'nilreg 'acc))

(deflapgen retcc (cc)
   (%lap-expr 'setpred cc 'da)
   (%lap-expr 'lfret))

(deflapgen move_t (dest)
  (if (lap-reg-op-p dest)
    (progn
      (lap-move.l 'nilreg dest)
      (%lap-expr 'add.w '($ $t_val) dest))
    (lap-move.l '(a5 $t) dest)))

(deflapgen klexpr (&optional (nreq 0))
  (unless (and (fixnump nreq) (%i>= nreq 0))
    (report-bad-arg nreq '(integer 0 #.call-arguments-limit)))
  (%lap-expr 'jsr_subprim (if (neq 0 nreq) '$sp-klexpr-n '$sp-klexpr))
  (if (neq 0 nreq) (%lap-expr 'dc.w (%ilsl 2 nreq)))
  (gen-lap-words (move.l @sp nargs) (sub.l vsp nargs))
  (if (neq 0 nreq) (%lap-expr 'sub.w `($ ,(%ilsl 2 nreq)) 'nargs)))

(deflapgen vscale (dreg &aux (size *lap-cur-size*))
  (%lap-expr 
   'asr.l 
   (if (eq size 0)   ; byte
     '($ #.$fixnumshift)
     (if (eq size 1) ; word
       '($ #.(- $fixnumshift 1))
       '($ #.(- $fixnumshift 2))))
   dreg))

(deflapgen vunscale (dreg &aux (size *lap-cur-size*))
  (if (or (eq size 0) ; byte
          (eq size 1)) ; word
    (%lap-expr 'lsl.l `($ ,(- $fixnumshift size)) dreg)
    (%lap-expr 'add.l dreg dreg)))

(deflapgen exitlisp ()
  (gen-lap-words
   (movem.l #(dsave0 dsave1 dsave2 asave0 asave1 nilreg vsp) (a5 $romregs))))

(deflapgen enterlisp ()
  (gen-lap-words
   (movem.l (a5 $romregs) #(dsave0 dsave1 dsave2 asave0 asave1 nilreg))))

(deflapgen index->address (i a)
  (%lap-expr 'vscale.l i)
  (%lap-expr 'movereg i a))

(deflapgen address->index (a i)
  (%lap-expr 'movereg a i)
  (%lap-expr 'vunscale.l i))

(defun lap-wta (thing right callop)
  (let* ((id (if (quoted-form-p right) (%typespec-id (cadr right)))))
    (if id (setq right (list 'quote id))))
  (set-two-regs 'arg_y thing 'arg_z right)
  (%lap-expr callop '$sp-badinp2))

(deflapgen wtaerr (thing right) (lap-wta thing right 'jsr_subprim))
(deflapgen twtaerr (thing right) (lap-wta thing right 'jmp_subprim))

; (prog#
;   ...
;  (bne (top#))  ;goes to top
;  ..
;  (bcc (exit#))  ;goes to end
;  ..
; )
(defparameter *lap-prog#-labels* nil)
(deflapgen prog# (&rest forms)
  (let ((*lap-prog#-labels* (cons `(^ ,(gensym)) `(^ ,(gensym)))))
    (%lap-label (cadr (car *lap-prog#-labels*)))
    (dolist (form forms)
      (lap-instr form))
    (%lap-label (cadr (cdr *lap-prog#-labels*)))))
(deflapgen loop# (&rest forms)
  (lap-instr `(prog# ,@forms (bra (top#)))))
(deflapop top# ()
  (if *lap-prog#-labels* (car *lap-prog#-labels*)
      (lap-error "~S label outside a prog#" '(top#))))
(deflapop exit# ()
  (if *lap-prog#-labels* (cdr *lap-prog#-labels*)
    (lap-error "~S label outside a prog#" '(exit#))))

(deflapgen until# (test &rest instructions)
  (if (null instructions)               ; backward compatibility
    (lap-test test '(top#))             ;loop unless test
    (let ((label (gensym)))
      (%lap-expr 'bra label)
      (lap-instr `(prog# ,@instructions ,label (until# ,test))))))

(deflapgen while# (test &rest instructions)
  (if (null instructions)               ; backward compatibility
    (lap-test test '(exit#))            ;exit unless test
    (let ((label (gensym)))
      (%lap-expr 'bra label)
      (lap-instr `(prog# ,@instructions ,label (bif ,test (top#)))))))

(deflapgen if# (test &rest forms)
  (let ((@false (gensym))
        (@continue (gensym))
        (pending-if t)
        (some-else nil)       ; elseif# or else# seen
        (seen-else# nil)      ; guess.
        (body forms)
        (form nil))
    (lap-test test @false)
    (while forms
      (if (consp (setq form (pop forms)))
        (lap-instr form)
        (cond ((eq form 'else#)
               (if seen-else#
                 (lap-error "Duplicate else# clause in ~s" body))
               (if forms
                 (progn
                   (setq seen-else# t some-else t)
                   (%lap-expr 'bra @continue)
                   (setq pending-if nil)
                   (%lap-label @false))
                 ; else complain ?
                 ))
              ((eq form 'elseif#)
               (when seen-else#
                 (lap-error "misplaced elseif# in ~s" body))
               (unless (setq test (pop forms))
                 (lap-error "missing elseif# test clause in ~s" body))
               (setq some-else t)
               (%lap-expr 'bra @continue)
               (%lap-label @false)
               (lap-test test (setq @false (gensym))))
              ((eq form 'andif#)
               (unless (setq test (pop forms))
                 (lap-error "missing andif# test clause in ~s" body))
               (lap-test test (if seen-else# @continue @false)))
              (t (%lap-label form)))))
    (if pending-if (%lap-label @false))
    (if some-else (%lap-label @continue))))

     
(defparameter *lap-inverted-ccs*
  '((t . f)
    (f . t)
    (hi . ls) (ls . hi) (cc . cs) (cs . cc) (hs . lo) (lo . hs)
    (ne . eq) (eq . ne) (vc . vs) (vs . vc) (pl . mi) (mi . pl)
    (ge . lt) (lt . ge) (gt . le) (le . gt) 
    (geu . ltu) (gtu . leu) (leu . gtu) (ltu . geu)))

(defun lap-branch (cc label invert-p)
  (%lap-expr '.bcc
             (if invert-p  (cdr (assq cc *lap-inverted-ccs*)) cc)
             label))

(deflapgen bif (test label)  ;that's "Branch IF"...
  (lap-test test label nil))

(defun lap-test (test label &optional (brfalse t))
  (if (atom test)
    (lap-branch test label brfalse)
    (let* ((op (pop test)))
      (cond ((or (eq op 'not) (eq op '~))
             (when (cdr test) (lap-error))
             (lap-test (car test) label (not brfalse)))
            ((or (eq op 'and) (eq op 'or))
             (if (if (eq op 'and) brfalse (not brfalse))
               (dolist (atest test) (lap-test atest label brfalse))
               (let ((@lose (gensym)))
                 (while (cdr test)
                   (lap-test (car test) @lose (not brfalse))
                   (setq test (cdr test)))
                 (lap-test (car test) label brfalse)
                 (%lap-label @lose))))
            (t (if (cdr test)
                 (lap-instr (cons 'cmp.l test))
                 (when test (lap-instr (car test))))
               (lap-branch op label brfalse))))))

(deflapgen equate (&rest var-val-pairs)
  (while var-val-pairs
    (let* ((var (pop var-val-pairs)) (val (pop var-val-pairs)))
     (declare (special *lap-bindings*))
     (setq val (eval val))
     (push (cons var (%sym-value var)) *lap-bindings*)
     (set var val))))

(deflapgen eval (&rest forms) (eval `(progn ,@forms)))

(deflapgen debug (string)
  (setq string (require-type string 'string))
  (lap-instr
   `(progn
      (spush ',(concatenate 'base-string (string (code-char (length string))) string))
      (add.l ($ $v_data) @sp)
      (dc.w #xabff))))

(provide 'lapmacros)

) ; #-ppc-target

;End of LapMacros.lisp

#|
	Change History (most recent last):
	2	12/29/94	akh	merge with d13
|# ;(do not edit past this line!!)
