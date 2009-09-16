;;;-*-Mode: LISP; Package: CCL -*-

;; disasm.lisp - disassemble compiled functions into 68000 code
;; Copyright 1986-1988 Coral Software Corp. All rights reserved.
;; Copyright 1989-1994 Apple Computer, Inc.
;; Copyright 1995 Digitool, Inc.


; Modification History
;
; 10/20/95 slh  disabled for PPC
; 09/01/91 bill divx.l, mulx.l got left out of table in merge.
; 07/21/91 gb   Bitfield instrs.  Constant wimping.  Use EQUAL hash table keyed on pname; may
;               avoid some interning.
; 06/11/91 bill DIVx.L, MULx.L
;-------------- 2.0b2
; 05/29/91 gb   $sp-funcall_cclosure dc.w's.
; 05/20/91 gb   recognize &restv subprims; disassemble (btst dN ($ C)).
; 02/07/91 alice ccl; => ccl;
;--------------- 2.0b1
; 01/09/90 gb   add $sp-stack-rest-keys, $sp-stack-req-rest-keys
;               to *disasm-subprim-key-word*, $sp-stack-req-rest-keys to 
;               *disasm-subprim-req-word*.
; 10/16/90 gb   Say, no short vectors.
; 08/10/90 gb   say uvref.  Say atemp1, atemp0 vice a1, a0.  $sp-lexpr-n has dc.w after.
; 04/30/90 gb   recognize fixnum 1 in addq,subq.  Maybe should say ($ 8) when dest is areg ...
; 12/29/89 gz   Split off some stuff that should live in the product into
;               another file.  This file will get autoloaded in the product.
;               It must not reference any functions which will not be accessible
;               thru symbols in the product.
; 11/18/89 gz   %nth -> nth.  get -> gethash.
;12-Nov-89 Mly  Make disasm-index-reg consistently print "asave0" rather than "a2", etc
; 10/30/89 gb   unquote the occasional defparameter argument. Disassemble macro-functions
;               named by symbols.  No usual, no bit.
; 9/13/89  gz   $vcells_start, $fcells_end. disasm-a5-lfun-p.
; 5/31/89  gz   use nilreg-cell-symbol.
; 5/01/89  gz   handle locative immediates. Flushed some lisp-7-isms.
;               Account for the local symbols immediate.
;04/07/89 gb  $sp8 -> $sp.
; 4/4/89   gz   No more a5 globals.  Handle nilreg globals/fns instead.
;03/09/89  gz   New decompose-fn values.
;03/02/89  gb   Fail on evaluated closures (don't compile !)
;2/13/89   gz   Handle some f68881 instructions.
;2/4/89    gz   Handle indexed pc-rel mode.
;               Print function refs as #'
;               Print labels outside instructions.
;11/19/88  gb   compiled-function-p -> functionp. Require 'disasm.  
;               Dig around in functions.
;11/16/88  gz   Allow for multiple subprim names for same subprim.
;11/02/88  gb   new keyword arg subprims. Moveq says "fixnum" if it can.
;10/25/88  gb   set_nargs : hard-wired nargs register is 4 vice 6.
;10/23/88  gb   8.9 upload.
; 9/13/88  gb   nilreg is a4.
; 8/24/88  gz   2-arg %nth-immediate.  %nth -> nth
; 8/11/88  gb   Magic incantations in disasm-a5-lfun-p.
; 8/13/88  gz   Recognize long fixnums and chars.  Use %word-to-int...
; 8/10/88  gz   recognize (special x) and (function x) constructs.
; 8/2/88   gb   register pet names.  Check for 'signature' kludge in a5-lfun-p.
; 4/19/88  gz   Show movem reglist as vector, like LAP.
; 4/11/88  gz   New macptr scheme.
; 3/1/88   gz   Added in-package so can load into user pkg.  Don't be so
;		fussy about alignment...
; 2/16/87  gb   Hands off subtype 0 in %make-ivector calls!  New magic numbers
;               hardwired into disasm-split-lfun for xfer table functions.
; 7/18/87  gz   make subprim names strings rather than symbols.
; 7/12/87  gz   don't worry about %type-of and hitypes no more!
; 7/12/87  gb   Provide thyself.
; 6/30/87  gz   Handle block-compiled lfuns, immediates.
; 6/13/87  gb   proclaim all specials.
; 6/12/87  gb   disasm-ea references lisp-package symbols as "quoted" forms.
; 6/02/87  gb   recognize 31-bit fixnums.
; 5/26/87  gz   handle compiled closures.  princ rather than prin1 everything
;               except immediates.
; 4/28/87  gb   Use compile-named-function vice nc-compile-named-function.
; 4/19/87  gz   added DISASSEMBLE.  Changed the "sorry" emsg somewhat.
; 4/6/87   gz   converted ERROR calls
; 03/17/87  gz  sign-extend subprim offset. Just load subprims.lisp at compile time.
; 02/19/87  gz  clr fix.
; 02/17/87  gb  %include subprims.lisp, (Macro ...) -> (defmacro ...)

(in-package "CCL")

#-ppc-target
(progn

(eval-when (eval compile)
  (require 'sysequ)
  (require 'subprims8 "ccl:compiler;subprims8")
  (require 'backquote))

(eval-when (eval compile)
 (defconstant $sizeword 1)
 (defconstant $sizebyte 0)
 (defconstant $sizelong 2)
 (defconstant $sizenone 3)

 (defmacro disasm-dregs () ''(d0 d1 d2 d3 d4 dsave0 dsave1 dsave2))
 (defmacro disasm-aregs () ''(atemp0 atemp1 asave0 asave1 nilreg a5 vsp sp))
 (defmacro disasm-@aregs () ''(@atemp0 @atemp1 @asave0 @asave1 @nilreg @a5 @vsp @sp))
 (defmacro disasm--@aregs () ''(-@atemp0 -@atemp1 -@asave0 -@asave1 -@a4 -@a5 -@vsp -@sp))
 (defmacro disasm-aregs@+ () ''(atemp0@+ atemp1@+ asave0@+ asave1@+ a4@+ a5@+ vsp@+ sp@+))
 (defmacro disasm-bcc.s () ''(bra.s bsr.s bhi.s bls.s bcc.s bcs.s bne.s beq.s
                             bvc.s bvs.s bpl.s bmi.s bge.s blt.s bgt.s ble.s))
 (defmacro disasm-bcc.l () ''(bra bsr bhi bls bcc bcs bne beq
                             bvc bvs bpl bmi bge blt bgt ble))
 (defmacro disasm-scc  () ''(st  sf  shi sls scc scs sne seq
                            svc svs spl smi sge slt sgt sle))
 (defmacro disasm-dbcc () ''(dbt  dbra dbhi dbls dbcc dbcs dbne dbeq
                            dbvc dbvs dbpl dbmi dbge dblt dbgt dble))


(let* (names masks roots
       (opcodes  '(
                   (ori     #xFF00 #x0000)  ;00000000 ********
                   (andi    #xFF00 #x0200)  ;00000010 ********
                   (subi    #xFF00 #x0400)  ;00000100 ********
                   (addi    #xFF00 #x0600)  ;00000110 ********
                   (statbit #xFF00 #x0800)  ;00001000 ********
                   (eori    #xFF00 #x0A00)  ;00001010 ********
                   (cmpi    #xFF00 #x0C00)  ;00001100 ********
                   (moves   #xFF00 #x0E00)  ;00001110 ********
                   (movep   #xF138 #x0108)  ;0000***1 **001***
                   (dynbit  #xF100 #x0100)  ;0000***1 ********

                   (move.b  #xF000 #x1000)  ;0001**** ********
                   (move.l  #xF000 #x2000)  ;0010**** ********
                   (move.w  #xF000 #x3000)  ;0011**** ********

                   (toccr   #xFFC0 #x44C0)  ;01000100 11******
                   (tosr    #xFFC0 #x46C0)  ;01000110 11******
                   (neg     #xFF00 #x4400)  ;01000100 ********
                   (not     #xFF00 #x4600)  ;01000110 ********
                   (fromsr  #xFFC0 #x40C0)  ;01000000 11******
                   (negx    #xFF00 #x4000)  ;01000000 ********
                   (fromccr #xFFC0 #x42C0)  ;01000010 11******
                   (clr     #xFF00 #x4200)  ;01000010 ********

                   (nbcd    #xFFC0 #x4800)  ;01001000 00******
                   (swap    #xFFF8 #x4840)  ;01001000 01000***
                   (pea     #xFFC0 #x4840)  ;01001000 01******
                   (ext     #xFFB8 #x4880)  ;01001000 1*000***
                   (movem   #xFF80 #x4880)  ;01001000 1*******

                   (illegal #xFFFF #x4AFC)  ;01001010 11111100
                   (tas     #xFFC0 #x4AC0)  ;01001010 11******
                   (tst     #xFF00 #x4A00)  ;01001010 ********

                   (mulx.l  #xFFC0 #x4C00)  ;01001100 00******
                   (divx.l  #xFFC0 #x4C40)  ;01001100 01******
                   (movem   #xFF80 #x4C80)  ;01001100 1*******

                   (trap    #xFFF0 #x4E40)  ;01001110 0100****
                   (link    #xFFF8 #x4E50)  ;01001110 01010***
                   (unlk    #xFFF8 #x4E58)  ;01001110 01011***
                   (moveusp #xFFF0 #x4E60)  ;01001110 0110****
                   (reset   #xFFFF #x4E70)  ;01001110 01110000
                   (nop     #xFFFF #x4E71)  ;01001110 01110001
                   (stop    #xFFFF #x4E72)  ;01001110 01110010
                   (rte     #xFFFF #x4E73)  ;01001110 01110011
                   (rtd     #xFFFF #x4E74)  ;01001110 01110100
                   (rts     #xFFFF #x4E75)  ;01001110 01110101
                   (trapv   #xFFFF #x4E76)  ;01001110 01110110
                   (rtr     #xFFFF #x4E77)  ;01001110 01110111
                   (movec   #xFFFE #x4E7A)  ;01001110 0111101*
                   (jsr_subprim #xffff #x4ead)
                   (jsr     #xFFC0 #x4E80)  ;01001110 10******
                   (jmp_subprim #xffff #x4eed)
                   (jmp     #xFFC0 #x4EC0)  ;01001110 11******
                   (chk     #xF1C0 #x4180)  ;0100***1 10******
                   (lea     #xF1C0 #x41C0)  ;0100***1 11******

                   (dbcc    #xF0F8 #x50C8)  ;0101**** 11001***
                   (scc     #xF0C0 #x50C0)  ;0101**** 11******
                   (addsubq #xF000 #x5000)  ;0101**** ********
 
                   (bcc     #xF000 #x6000)  ;0110**** ********

                   (moveq   #xF100 #x7000)  ;0111***0 ********

                   (div     #xF0C0 #x80C0)  ;1000**** 11******
                   (bcd2    #xF1F0 #x8100)  ;1000***1 0000****
                   (or      #xF000 #x8000)  ;1000**** ********

                   (sub     #xF0C0 #x90C0)  ;1001**** 11******
                   (addsubx #xF130 #x9100)  ;1001***1 **00****
                   (sub     #xF000 #x9000)  ;1001**** ********

                   (atrap   #xF000 #xA000)  ;1010**** ********

                   (cmpa    #xF0C0 #xB0C0)  ;1011**** 11******
                   (cmp     #xF100 #xB000)  ;1011***0 ********
                   (cmpm    #xF138 #xB108)  ;1011***1 **001***
                   (eor     #xF100 #xB100)  ;1011***1 ********

                   (mul     #xF0C0 #xC0C0)  ;1100**** 11******
                   (bcd2    #xF1F0 #xC100)  ;1100***1 0000****
                   (exg     #xF1F0 #xC140)  ;1100***1 0100****
                   (exg     #xF1F8 #xC188)  ;1100***1 10001***
                   (and     #xF000 #xC000)  ;1100**** ********

                   (add     #xF0C0 #xD0C0)  ;1101**** 11******
                   (addsubx #xF130 #xD100)  ;1101***1 **00****
                   (add     #xF000 #xD000)  ;1101**** ********

                   (bf      #xF8C0 #xE8C0)  ;11101*** ********
                   (shift   #xF000 #xE000)  ;11100*** ********
                   (fpgen   #xFFC0 #xF200)  ;11110010 00******
                ))
       (n (list-length opcodes)))
   (setq names (make-array n))
   (setq masks (make-array n :element-type '(signed-byte 16)))
   (setq roots (make-array n :element-type '(signed-byte 16)))
   (setq n 0)
   (dolist (op opcodes)
     (aset names n (symbol-name (%car op)))
     (aset masks n (%word-to-int (%cadr op)))
     (aset roots n (%word-to-int (%caddr op)))
     (setq n (%i+ n 1)))
   (defmacro disasm-opcode-names () `',names)
   (defmacro disasm-opcode-masks () `',masks)
   (defmacro disasm-root-opcodes () `',roots))


(let (name offset alist
      (subprims *subprims8-alist*))
  (dolist (subp subprims)
    (setq name (%car subp) offset (%cadr subp))
    (unless (assq offset alist)
      (push (cons offset
                  (if (memq name '($sp-tcall $sp-tfuncall $sp-nvalret $sp-values))
                    (list 'jmp_subprim (string name))
                    (list 'jsr_subprim (string name))))
            alist)))
  (defmacro disasm-subprim-alist () `',alist)
)

) ;eval-when

(defparameter *disasm-opcode-names* (disasm-opcode-names))
(defparameter *disasm-opcode-masks* (disasm-opcode-masks))
(defparameter *disasm-root-opcodes* (disasm-root-opcodes))
(defparameter *disasm-subprim-alist* (disasm-subprim-alist))

(defparameter *disasm-disassemblers* (make-hash-table :test #'equal))

(defvar *disasm-quote-imms* t)
(defvar *disasm-label-refcounts* nil)
(defvar *disasm-instructions*)
(defvar *disasm-code-pc*)
(defvar *disasm-labrefs*)
(defvar *disasm-opcode-name*)
(defvar *disasm-instr-pc*)
(defvar *disasm-end-pc*)
(defvar *disasm-codearray*)
(defvar *disasm-numimms*)
(defvar *disasm-immarray*)
(defvar *disasm-function*)
(defvar *disasm-immrefs*)
(defvar *disasm-num-immrefs*)
(defvar *disasm-function*)
(defvar *disasm-vcells* nil)
(defvar *disasm-fcells* nil)
(defparameter *disassemble-trap-name-hook* #'false)

; Some subprimitives take parameters as words and/or immediates following
; the return address.  (-These- subprimitives, for instance.)

; These guys leave the number of required args * 4.
(defparameter *disasm-subprim-req-word*
  (list $sp-n-req-args $sp-n-req-args-vpush $sp-req-initopt
        $sp-funcall_cclosure
        $sp-req-opt $sp-stack-req-rest $sp-stack-req-restv
        $sp-n-req-initopt-rest $sp-n-req-initopt-restv
        $sp-n-req-opt-rest $sp-n-req-opt-restv $sp-n-req-rest $sp-n-req-restv 
        $sp-req-rest-keys $sp-req-restv-keys
        $sp-req-initopt-keys $sp-req-opt-keys $sp-kreqkeys
        $sp-req-opt-rest-keys $sp-req-opt-restv-keys 
        $sp-req-initopt-rest-keys $sp-req-initopt-restv-keys
        $sp-klexpr-n $sp-stack-req-rest-keys $sp-stack-req-restv-keys))

; These guys leave the number of &optional args * 4.
(defparameter *disasm-subprim-opt-word*
  (list $sp-n-req-initopt-rest $sp-n-req-opt-rest $sp-n-req-opt-restv
        $sp-req-initopt-keys $sp-req-opt-keys $sp-req-opt $sp-req-initopt
        $sp-req-opt-rest-keys  $sp-req-opt-restv-keys 
        $sp-req-initopt-rest-keys $sp-req-initopt-restv-keys))

; These guys leave the number of &key args * 4.
(defparameter *disasm-subprim-key-word*
  (list $sp-rest-keys $sp-req-rest-keys $sp-req-initopt-keys 
        $sp-restv-keys $sp-req-restv-keys
        $sp-req-opt-keys $sp-kreqkeys $sp-stack-rest-keys
        $sp-req-opt-keys $sp-kreqkeys $sp-stack-restv-keys
        $sp-stack-req-rest-keys $sp-stack-req-restv-keys
        $sp-req-opt-rest-keys $sp-req-initopt-rest-keys
        $sp-req-opt-restv-keys $sp-req-initopt-restv-keys))

#-bccl (require 'disasm)

(defun disasm-immref-p (&optional (pc *disasm-code-pc*))
  (let ((pcword (%ilsr 1 pc)))
    (dotimes (i *disasm-num-immrefs*)
      (declare (fixnum i))
      (when (eq pcword (aref *disasm-immrefs* i))
        (return (uvref *disasm-codearray* (1+ pcword)))))))

(defun disasm-next-immref ()
  ;; Paranoia :
  (unless (disasm-immref-p) (error "Who's calling DISASM-NEXT-IMMREF? Why?"))
  (aref *disasm-immarray* (+ (%ilsl 16 (disasm-nextword)) (disasm-nextword))))

(defun disasm-disassemble (*disasm-function* 
                           *disasm-codearray* 
                           *disasm-immarray*
                           *disasm-end-pc*
                           *disasm-immrefs* 
                           *disasm-num-immrefs*
                           *disasm-fcells*
                           *disasm-vcells*)
 (let* ((*disasm-numimms* (if *disasm-immarray* (length *disasm-immarray*) 0))
        (*disasm-instr-pc* 0)
        (*disasm-code-pc* 0)
        (*disasm-instructions* nil)
        (*disasm-labrefs* nil)
        (*disasm-opcode-name* nil))
   (loop
     (disasm-disassemble-instruction)
     (when (eq *disasm-instr-pc* *disasm-end-pc*) (return)))
   (disasm-fixlabrefs)
   (setq *disasm-instructions* (nreverse *disasm-instructions*))))

(defun disasm-fixlabrefs (&aux a)
  (dolist (ref *disasm-labrefs*)
    (setq a (assq (car ref) *disasm-instructions*))
    (if (null a)
      (progn
        (unless (setq a (disasm-immref-p (car ref))) 
          (error "Missing target for label ~S" (%car ref)))
        (setq a (disasm-#immref (aref *disasm-immarray* a)))
        (%rplaca ref (car a))
        (%rplacd ref (cdr a)))
      (progn
        (%rplaca a ref)
        (rplaca (%cdr ref) (%car ref))  ;Change (pc NIL . #) to (LABEL pc . #)
        (unless *disasm-label-refcounts* (%rplacd (%cdr ref) nil))
        (%rplaca ref 'label)))))

(defun disasm-disassemble-instruction (&aux opcode)
  (when (>= (setq *disasm-instr-pc* *disasm-code-pc*) *disasm-end-pc*)
    (return-from disasm-disassemble-instruction))
  (if (disasm-immref-p)
    (disasm-record 'dc.l (disasm-#immref (disasm-next-immref)))
    (progn
      (setq opcode (disasm-nextword))
      (dotimes (i (length *disasm-opcode-names*))
        (when (eq (%ilogand2 (uvref *disasm-opcode-masks* i) opcode)
                  (%ilogand2 (uvref *disasm-root-opcodes* i) #xFFFF))
          (return-from disasm-disassemble-instruction
                       (funcall 
                        (gethash (setq *disasm-opcode-name* (aref *disasm-opcode-names* i))
                                 *disasm-disassemblers*)
                        opcode))))
      (disasm-unrec opcode))))

(defun disasm-nextword ()
 (when (< *disasm-end-pc* *disasm-code-pc*) (error "disasm-nextword : overrun"))
 (prog1 (%ilogand2 #xffff
                   (aref *disasm-codearray* (%ilsr 1 *disasm-code-pc*)))
        (setq *disasm-code-pc* (%i+ *disasm-code-pc* 2))))


(defun %byte-to-int (b)  ;ext.w b / ext.l b
  (setq b (%ilogand b #xFF))
  (if (%i< b 128) b (%i- b 256)))

(defun reg9 (opcode)
 (%ilogand2 7 (%ilsr 9 opcode)))

(defun disasm-dreg (reg) (nth reg (disasm-dregs)))
(defun disasm-areg (reg) (nth reg (disasm-aregs)))
(defun disasm-@areg (reg) (nth reg (disasm-@aregs)))

(defun disasm-std-instr (op)
 (values
  (%ilogand2 7 (%ilsr 3 op)) ; mode
  (%ilogand2 7 op)          ; reg
  (%ilogand2 3 (%ilsr 6 op)))) ; size

(defun disasm-index-reg (ext)
  (nth (%ilogand2 7 (%ilsr 12 ext))
        (if (%ilogbitp 15 ext)
          (if (%ilogbitp 11 ext)
            '(a0.l a1.l asave0.l asave1.l nilreg.l a5.l vsp.l sp.l)
            '(a0.w a1.w asave0.w asave1.w nilreg.w a5.w vsp.w sp.w))
          (if (%ilogbitp 11 ext)
            '(d0.l d1.l d2.l d3.l d4.l dsave0.l dsave1.l dsave2.l)
            '(d0.w d1.w d2.w d3.w d4.w dsave0.w dsave1.w dsave2.w)))))

(defun disasm-ea (mode reg &optional (size $sizenone))
 (case mode
  (0 (disasm-dreg reg))
  (1 (disasm-areg reg))
  (2 (disasm-@areg reg))
  (3 (nth reg (disasm-aregs@+)))
  (4 (nth reg (disasm--@aregs)))
  (5 (disasm-areg-ea reg))
  (6 (let ((ext (disasm-nextword)))
       (list (disasm-areg reg)
             (disasm-index-reg ext)
             (%byte-to-int ext))))
  (7 
   (case reg
    (0 (list '@W (%word-to-int (disasm-nextword))))
    (1  (if (disasm-immref-p)
          (disasm-@immref (disasm-next-immref))
          (list '@L (%word-to-int (disasm-nextword)) (disasm-nextword))))
    (2 (disasm-pcrel))
    (3 (let ((ext (disasm-nextword)))
         (list 'pc (disasm-index-reg ext) (%byte-to-int ext))))
    (4
     (case size
      (3 (error "Bug! No size for immediate EA"))
      (2 (if (disasm-immref-p)
           (disasm-#immref (disasm-next-immref))
           (let* ((ext1 (disasm-nextword)) (ext2 (disasm-nextword)))
             (cond ((%izerop (%ilogand2 $typemask ext2))
                    (setq ext2
                          (%i+ (%ilsl (%i- 16 $fixnumshift) ext1)
                               (%ilsr $fixnumshift ext2)))
                    (if (eq ext2 0) '(fixnum 0)  ;Minimize consing
                        (if (eq ext2 1) '(fixnum 1)
                            (if (eq ext2 -1) '(fixnum -1)
                                (list 'fixnum ext2)))))
                   ((and (eq ext2 $t_imm_char)
                         (eq ext1 (%ilogand #xFF ext1)))
                    (setq ext1 (%code-char ext1))
                    (list 'char
                          ;these things get PRINC'd...
                          (%str-cat "#\\" (or (char-name ext1) (string ext1)))))
                   (t (list '$ (%word-to-int ext1) ext2))))))
      ((0 1) (list '$ (disasm-nextword)))))
    (t (error "disasm-ea : mode = 7, reg = ~S ???" reg))))))

(defun disasm-@immref (imm)
  (if (eq (%type-of imm) 'symbol-locative)
    (multiple-value-bind (sym offset) (%symbol-locative-symbol imm)
      (cond ((eq offset $sym.gvalue) (list 'special sym))
            ((eq offset $sym.fapply) (list 'function sym))
            (t (list '@L imm))))
    (if (or (memq imm *disasm-vcells*)
            (memq imm *disasm-fcells*))
      (%cdr imm)
      (list '@L imm))))

(defun disasm-#immref (imm)
  (if (eq (%type-of imm) 'symbol-locative)
    (multiple-value-bind (sym offset) (%symbol-locative-symbol imm)
      (cond ((eq offset $sym.gvalue) (list 17 'special sym))
            ((eq offset $sym.fapply) (list 17 'function sym))
            (t (list 'quote imm))))
    (if (or (memq imm *disasm-vcells*)
            (memq imm *disasm-fcells*))
      (list 17 (%cdr imm))
      (list 'quote imm))))

(defun disasm-areg-ea (reg &optional (offset (%word-to-int (disasm-nextword))))
  (cond ((and (eq reg 0) (eq offset -4)) '(a0 -4))
        ((eq reg 4)
         (multiple-value-bind (symbol loc) (nilreg-cell-symbol offset)
           (if (null offset)
             (list (disasm-areg reg) offset)
             (list (if (eq loc 0)
                     'quote
                     (if (eq loc $sym.gvalue)
                       'special
                       'function))
                   symbol)))) 
        (t (list (disasm-areg reg) offset))))

(defun disasm-pc-relref (pc disp &aux 
                            (addr (%i+ pc (setq disp (%word-to-int disp)))))
  (let ((ref (assq addr *disasm-labrefs*)))
    (if (null ref) 
      (push (setq ref (list* addr nil 1)) *disasm-labrefs*)
      (%rplacd (%cdr ref) (%i+ (%cddr ref) 1)))
    ref))

(defun disasm-pcrel ()
 (disasm-pc-relref *disasm-code-pc* (disasm-nextword)))

(defun disasm-std-ea (opcode &optional (size $sizenone))
 (multiple-value-bind (mode reg) (disasm-std-instr opcode)
   (disasm-ea mode reg size)))

(eval-when (eval compile)
 (defmacro defdisasm (name arglist &body body)
   `(setf (gethash ',(symbol-name name) *disasm-disassemblers*)
          #'(lambda ,arglist ,@body))))

(defdisasm move.l (opcode &aux src dst)
 (multiple-value-bind (srcmode srcreg) (disasm-std-instr opcode)
  (setq src (disasm-ea srcmode srcreg $sizelong)
        dst (disasm-ea (%ilogand2 7 (%ilsr 6 opcode)) (reg9 opcode)))
  (cond ((eq src 'vsp@+)
         (if (eq dst 'd0) (disasm-record-list '(vpop d0))
           (if (eq dst 'a0) (disasm-record-list '(vpop a0))
             (disasm-record 'vpop dst))))
        ((eq src 'sp@+)
         (disasm-record 'spop dst))
        ((eq dst '-@vsp)
         (if (eq src 'd0) (disasm-record-list '(vpush d0))
           (disasm-record 'vpush src)))
        ((eq dst '-@sp)
         (disasm-record 'spush src))
        ((eq dst 'a0)
         (disasm-record-list (if (eq src 'd0) '(move.l d0 a0) (list* 'move.l src '(a0)))))
        ((eq dst 'd0)
         (disasm-record-list (if (eq src 'nilreg) '(move.l nilreg d0)
                                 (list* 'move.l src '(d0)))))
        ((and (eq src '@a0) (eq dst 'a1))
         (disasm-record-list '(move.l @a0 a1)))
        (t (disasm-record 'move.l src dst)))))

(defdisasm move.w (opcode)
 (disasm-move opcode 'move.w $sizeword))

(defdisasm move.b (opcode)
 (disasm-move opcode 'move.b $sizebyte))

(defun disasm-move (opcode opname size)
 (multiple-value-bind (srcmode srcreg)
  (disasm-std-instr opcode)
  (disasm-record
   opname
   (disasm-ea srcmode srcreg size)
   (disasm-ea (%ilogand2 7 (%ilsr 6 opcode)) (reg9 opcode)))))

(defdisasm bcc (opcode &aux (cc (%ilogand2 (%ilsr 8 opcode) 15))
                            (base *disasm-code-pc*)
                            (disp (%byte-to-int opcode))
                            (opnames (disasm-bcc.s)))
 (if (eq disp 0) (setq disp (%word-to-int (disasm-nextword))
                       opnames (disasm-bcc.l)))
 (disasm-record (nth cc opnames) (disasm-pc-relref base disp)))

(defdisasm dbcc (opcode)
  (disasm-record (nth (%ilogand2 (%ilsr 8 opcode) 15) (disasm-dbcc))
                 (disasm-dreg (%ilogand opcode 7))
                 (disasm-pc-relref *disasm-code-pc* (%word-to-int (disasm-nextword)))))

(defdisasm scc (opcode)
  (disasm-record (nth (%ilogand2 (%ilsr 8 opcode) 15) (disasm-scc))
                (disasm-std-ea opcode)))

(defdisasm addsubq (opcode &aux (val (reg9 opcode)))
  (multiple-value-bind (mode reg size) (disasm-std-instr opcode)
    (disasm-record (nth size (if (%ilogbitp 8 opcode) '(subq.b subq.w subq.l)
                                                       '(addq.b addq.w addq.l)))
                   (if (eq val 0) '(fixnum 1) val)
                   (disasm-ea mode reg))))

(defdisasm jsr_subprim (opcode)
  (setq opcode (disasm-subprim 'jsr_subprim))
  (when (memq opcode *disasm-subprim-req-word*)
    (setq *disasm-instr-pc* *disasm-code-pc*)
    (disasm-record 'dc.w (disasm-nextword)))
  (when (memq opcode *disasm-subprim-opt-word*)
    (setq *disasm-instr-pc* *disasm-code-pc*)
    (disasm-record 'dc.w (disasm-nextword)))
  (when (memq opcode *disasm-subprim-key-word*)
    (setq *disasm-instr-pc* *disasm-code-pc*)
    (disasm-record 'dc.w (disasm-nextword))))

(defdisasm jmp_subprim (opcode)
 (declare (ignore opcode))
 (disasm-subprim 'jmp_subprim))

(defun disasm-subprim (opname &aux
  (offset (%word-to-int (disasm-nextword)))
  (subpname (%cdr (assq offset *disasm-subprim-alist*))))
 (if (null subpname)
   (disasm-record opname (or (disasm-a5-lfun-p offset) offset))
   (disasm-record-list (if (eq opname (%car subpname)) subpname
                           (cons opname (%cdr subpname)))))
 offset)

(defun disasm-a5-lfun-p (offset)
  (old-lap-inline (offset)
   (getint acc)
   (add.l a5 acc)
   (if# (not (and (eq (ttagp ($ $t_lfun) acc da))
                  (geu (cmp.l (a5 $slfuns_start) acc))
	          (ltu (cmp.l (a5 $slfuns_end) acc))))
     (move.l nilreg acc))))

(defdisasm jsr (opcode)
  (disasm-record 'jsr (disasm-std-ea opcode)))

(defdisasm jmp (opcode)
 (disasm-record 'jmp (disasm-std-ea opcode)))

(defdisasm fromsr (opcode)
   (disasm-record 'move.w 'sr (disasm-std-ea opcode)))
(defdisasm tosr (opcode)
   (disasm-record 'move.w (disasm-std-ea opcode $sizeword) 'sr))
(defdisasm fromccr (opcode)
   (disasm-record 'move.w 'ccr (disasm-std-ea opcode)))
(defdisasm toccr (opcode)
   (disasm-record 'move.w (disasm-std-ea opcode $sizeword) 'ccr))

(defdisasm moveusp (opcode &aux (areg (disasm-areg (%ilogand opcode 7))))
   (disasm-record-list
    (if (%ilogbitp 3 opcode) (list 'move.l 'usp areg)
                             (list 'move.l areg 'usp))))

(defdisasm chk (opcode)
 (multiple-value-bind (mode reg) (disasm-std-instr opcode)
  (disasm-record 'chk (disasm-ea mode reg $sizeword) (disasm-dreg (reg9 opcode)))))

(defdisasm moveq (opcode &aux (reg (reg9 opcode)) (val (%byte-to-int opcode)))
 (if (and (eq reg 4) (eq val (%ilogand2 -4 val)) (%i>= val 0))
     (progn 
       (setq val (%iasr 2 val))
       (if (%i< val 6)
           (disasm-record-list (nth val '((set_nargs 0) (set_nargs 1)
                                           (set_nargs 2) (set_nargs 3)
                                           (set_nargs 4) (set_nargs 5))))
           (disasm-record 'set_nargs val)))
     (progn
       (if (%izerop (%ilogand2 7 val))
         (setq val 
               (if (%izerop val) 
                 '(fixnum 0) 
                 (if (eq 8 val) 
                   '(fixnum 1)
                   (list 'fixnum (ash val -3))))))
       (disasm-record 'moveq val (disasm-dreg reg)))))

(defdisasm ext (opcode)
 (disasm-record (if (%ilogbitp 6 opcode) 'ext.l 'ext.w)
                (disasm-dreg (%ilogand2 opcode 7))))

(defdisasm lea (opcode)
  (disasm-record 'lea (disasm-std-ea opcode) (disasm-areg (reg9 opcode))))

(defdisasm pea (opcode)
 (disasm-record 'pea (disasm-std-ea opcode)))

(defdisasm link (opcode)
  (disasm-record 'link (disasm-areg (%ilogand 7 opcode)) (disasm-nextword)))

(defdisasm unlk (opcode)
  (disasm-record 'unlk (disasm-areg (%ilogand 7 opcode))))

(defdisasm reset (opcode)
  (declare (ignore opcode))
  (disasm-record-list '(reset)))

(defdisasm nop (opcode)
  (declare (ignore opcode))
  (disasm-record-list '(nop)))

(defdisasm stop (opcode)
  (declare (ignore opcode))
  (disasm-record 'stop (disasm-nextword)))

(defdisasm rte (opcode)
  (declare (ignore opcode))
  (disasm-record-list '(rte)))

(defdisasm rtd (opcode)
  (declare (ignore opcode))
  (disasm-record 'rtd (disasm-nextword)))

(defdisasm rts (opcode)
 (declare (ignore opcode))
 (disasm-record-list '(rts)))

(defdisasm trapv (opcode)
  (declare (ignore opcode))
  (disasm-record-list '(trapv)))

(defdisasm rtr (opcode)
  (declare (ignore opcode))
  (disasm-record-list '(rtr)))

(defdisasm illegal (opcode)
  (declare (ignore opcode))
  (disasm-record-list '(illegal)))

(defdisasm movep (opcode &aux (inst (if (%ilogbitp 6 opcode) 'movep.l 'movep.w))
                              (dreg (disasm-dreg (reg9 opcode)))
                              (ea (list (disasm-areg (%ilogand opcode 7))
                                        (disasm-nextword))))
    (if (%ilogbitp 7 opcode)
        (disasm-record inst dreg ea)
        (disasm-record inst ea dreg)))

(defdisasm moves (opcode &aux (ext (disasm-nextword))
                              (xreg (%ilogand2 (%ilsr 12 ext) 7)))
   (multiple-value-bind (mode reg size) (disasm-std-instr opcode)
     (setq opcode (nth size '(moves.b moves.w moves.l)))
     (setq reg (disasm-ea mode reg size))
     (setq xreg (if (%ilogbitp 15 ext) (disasm-areg xreg) (disasm-dreg xreg)))
     (if (%ilogbitp 11 ext)
         (disasm-record opcode xreg reg)
         (disasm-record opcode reg xreg))))

(defdisasm movec (opcode &aux (ext (disasm-nextword))
                              (xreg (%ilogand (%ilsr 12 ext) 7))
                              (creg (%ilogand ext #xFFF)))
  (setq xreg (if (%ilogbitp 15 ext) (disasm-areg xreg) (disasm-dreg xreg)))
  (setq creg (if (eq creg #x000) 'sfc
               (if (eq creg #x001) 'dfc
                 (if (eq creg #x800) 'usp
                   (if (eq creg #x801) 'vbr
                      creg)))))
  (if (%ilogbitp 0 opcode)
      (disasm-record 'movec xreg creg)
      (disasm-record 'movec creg xreg)))

(defdisasm exg (opcode &aux (rx (reg9 opcode)) (ry (%ilogand2 7 opcode)))
  (if (%ilogbitp 7 opcode)
      (disasm-record 'exg (disasm-dreg rx) (disasm-areg ry))
    (if (%ilogbitp 3 opcode)
        (disasm-record 'exg (disasm-areg rx) (disasm-areg ry))
          (disasm-record 'exg (disasm-dreg rx) (disasm-dreg ry)))))
                          
(defdisasm tst (opcode)
 (multiple-value-bind (mode reg size) (disasm-std-instr opcode)
  (setq reg (disasm-ea mode reg))
  (if (eq size $sizelong)
      (if (eq reg 'd0) (disasm-record-list '(tst.l d0))
         (if (eq reg 'vsp@+) (disasm-record-list '(tst.l vsp@+))
             (disasm-record 'tst.l reg)))
      (disasm-record (nth size '(tst.b tst.w)) reg))))

(defdisasm tas (opcode)
  (disasm-record 'tas (disasm-std-ea opcode)))

(defdisasm cmpa (opcode &aux (size (if (%ilogbitp 8 opcode) $sizelong $sizeword)))
 (disasm-record (if (eq size $sizelong) 'cmpa.l 'cmpa.w)
                (disasm-std-ea opcode size)
                (disasm-areg (reg9 opcode))))

(defdisasm cmp (opcode)
 (multiple-value-bind (mode reg size)
  (disasm-std-instr opcode)
  (disasm-record (nth size '(cmp.b cmp.w cmp.l))
                 (disasm-ea mode reg size)
                 (disasm-dreg (reg9 opcode)))))

(defdisasm cmpm (opcode)
  (multiple-value-bind (ignore ry size) (disasm-std-instr opcode)
      (declare (ignore ignore))
      (disasm-record (nth size '(cmpm.b cmpm.w cmpm.l))
                     (nth ry (disasm-aregs@+))
                     (nth (reg9 opcode) (disasm-aregs@+)))))

(defdisasm and (opcode)
   (disasm-log opcode '(and.b and.w and.l)))

(defdisasm or (opcode)
   (disasm-log opcode '(or.b or.w or.l)))

(defdisasm eor (opcode)
   (disasm-log opcode '(eor.b eor.w eor.l)))

(defun disasm-log (opcode opnames &aux (dreg (disasm-dreg (reg9 opcode))))
 (multiple-value-bind (mode reg size) (disasm-std-instr opcode)
  (if (%ilogbitp 8 opcode)
   (disasm-record (nth size opnames) dreg (disasm-ea mode reg size))
   (disasm-record (nth size opnames) (disasm-ea mode reg size) dreg))))

(defdisasm shift (opcode &aux (leftp (%ilogbitp 8 opcode))
                              (src (reg9 opcode)))
 (multiple-value-bind (mode reg size) (disasm-std-instr opcode)
  (if (eq size $sizenone)
      (disasm-record (shiftop src leftp $sizeword) (disasm-ea mode reg))
      (disasm-record (shiftop (%ilogand 3 mode) leftp size)
                     (if (%ilogbitp 5 opcode) (disasm-dreg src)
                        (if (eq src 0) 8 src))
                     (disasm-dreg reg)))))

(defun shiftop (op leftp size)
 (nth op (nth size (if leftp '((asl.b lsl.b roxl.b rol.b)
                                 (asl.w lsl.w roxl.w rol.w)
                                 (asl.l lsl.l roxl.l rol.l))
                               '((asr.b lsr.b roxr.b ror.b)
                                 (asr.w lsr.w roxr.w ror.w)
                                 (asr.l lsr.l roxr.l ror.l))))))

(defdisasm trap (opcode) (disasm-record 'trap (%ilogand #xF opcode)))

(defdisasm atrap (opcode) 
  (disasm-record 'atrap
                 (or (funcall *disassemble-trap-name-hook* opcode)
                     (list 16 opcode))))

(defdisasm ori (opcode)
 (disasm-logi '(ori.b ori.w ori.l) opcode))

(defdisasm andi (opcode)
 (disasm-logi '(andi.b andi.w andi.l) opcode))

(defdisasm eori (opcode)
 (disasm-logi '(eori.b eori.w eori.l) opcode))

(defun disasm-logi (opnames opcode)
  (if (eq (%ilogand2 opcode #o77) #o74)
     (if (%ilogbitp 6 opcode)
         (disasm-record (%cadr opnames) (disasm-nextword) 'sr)
         (disasm-record (%car opnames) (disasm-nextword) 'ccr))
     (disasm-immop opnames opcode)))

(defdisasm subi (opcode)
 (disasm-immop '(subi.b subi.w subi.l) opcode))

(defdisasm addi (opcode)
 (disasm-immop '(addi.b addi.w addi.l) opcode))

(defdisasm cmpi (opcode)
 (disasm-immop '(cmpi.b cmpi.w cmpi.l) opcode))

(defun disasm-immop (opnames opcode)
 (multiple-value-bind (mode reg size)
  (disasm-std-instr opcode)
  (disasm-record (nth size opnames)
                 (disasm-ea 7 4 size)  ; immediate
                 (disasm-ea mode reg size))))

(defdisasm add (opcode)
 (disasm-addsub '(add.b add.w add.l) opcode))

(defdisasm sub (opcode)
 (disasm-addsub '(sub.b sub.w sub.l) opcode))

; NOT addx, subx !
(defun disasm-addsub (opnames opcode &aux (xreg (reg9 opcode))
                                          (bit8 (%ilogbitp 8 opcode)))
 (multiple-value-bind (mode reg size) (disasm-std-instr opcode)
   (if (eq size $sizenone) ; adda.
    (progn
     (setq size (if bit8 $sizelong $sizeword))
     (disasm-record (nth size opnames)
                    (disasm-ea mode reg size)
                    (disasm-areg xreg)))
    (progn
     (setq xreg (disasm-dreg xreg))
     (disasm-record (nth size opnames)
                    (if bit8 xreg (disasm-ea mode reg size))
                    (if bit8 (disasm-ea mode reg size) xreg))))))

(defdisasm addsubx (opcode)
  (multiple-value-bind (rm reg size) (disasm-std-instr opcode)
    (disasm-record-list
     (cons (nth size (if (%ilogbitp 14 opcode) '(addx.b addx.w addx.l)
                                                '(subx.b subx.w subx.l)))
           (if (%izerop rm) (list (disasm-dreg reg) (disasm-dreg (reg9 opcode)))
               (list (nth reg (disasm--@aregs))
                     (nth (reg9 opcode) (disasm--@aregs))))))))

(defdisasm mul (opcode)
  (disasm-record (if (%ilogbitp 8 opcode) 'muls 'mulu)
                 (disasm-std-ea opcode $sizeword)
                 (disasm-dreg (reg9 opcode))))

(defdisasm div (opcode)
  (disasm-record (if (%ilogbitp 8 opcode) 'divs 'divu)
                 (disasm-std-ea opcode $sizeword)
                 (disasm-dreg (reg9 opcode))))

(defdisasm mulx.l (opcode)
  (disasm-muldiv.l opcode 'muls.l 'mulu.l))

(defdisasm divx.l (opcode)
  (disasm-muldiv.l opcode 'divs.l 'divu.l 'divsl.l 'divul.l))

(defun disasm-muldiv.l (opcode signed unsigned &optional 
                               (signed-short signed) (unsigned-short unsigned))
  (let* ((ext (disasm-nextword))
         (dl (ldb (byte 3 12) ext))
         (dh (ldb (byte 3 0) ext))
         (64bit (logbitp 10 ext))
         (signed? (logbitp 11 ext)))
    (declare (fixnum ext dl dh))
    (disasm-record (if 64bit
                     (if signed? signed unsigned)
                     (if signed? signed-short unsigned-short))
                   (disasm-std-ea opcode $sizelong)
                   (if 64bit
                     (list (disasm-dreg dh) (disasm-dreg dl))
                     (disasm-dreg dl)))))

(defdisasm neg (opcode)
  (disasm-arith1 '(neg.b neg.w neg.l) opcode))

(defdisasm not (opcode)
  (disasm-arith1 '(not.b not.w not.l) opcode))

(defdisasm negx (opcode)
  (disasm-arith1 '(negx.b negx.w negx.l) opcode))

(defdisasm clr (opcode)
  (disasm-arith1 '(clr.b clr.w clr.l) opcode))

(defun disasm-arith1 (opnames opcode)
  (multiple-value-bind (mode reg size) (disasm-std-instr opcode)
     (disasm-record (nth size opnames) (disasm-ea mode reg size))))

(defdisasm nbcd (opcode)
  (disasm-record 'nbcd (disasm-std-ea opcode)))

(defdisasm bcd2 (opcode &aux (opname (if (%ilogbitp 14 opcode) 'abcd 'sbcd))
                             (rx (reg9 opcode))
                             (ry (%ilogand opcode 7)))
  (if (%ilogbitp 3 opcode)
      (disasm-record opname (nth ry (disasm--@aregs)) (nth rx (disasm--@aregs)))
      (disasm-record opname (disasm-dreg ry) (disasm-dreg rx))))

(defdisasm dynbit (opcode)
 (multiple-value-bind (mode reg opnum) (disasm-std-instr opcode)
  (disasm-record (nth opnum '(btst bchg bclr bset))
                 (disasm-dreg (reg9 opcode))
                 (disasm-ea mode reg $sizeword))))

(defdisasm statbit (opcode)
   (multiple-value-bind (mode reg opnum)
      (disasm-std-instr opcode)
      (disasm-record (nth opnum '("BTST" "BCHG" "BCLR" "BSET"))
                     (disasm-nextword)
                     (disasm-ea mode reg $sizebyte))))

(defdisasm swap (opcode)
  (disasm-record 'swap (disasm-dreg (%ilogand 7 opcode))))

(defdisasm movem (opcode &aux (regmask (disasm-nextword))
                              (pushp (eq (%ilogand opcode #o70) #o40))
                              (regs ())
                              i inc)
  (if pushp (setq i 15 inc -1) (setq i 0 inc +1))
  (dolist (reg (disasm-dregs))
    (if (%ilogbitp i regmask) (push reg regs))
    (setq i (%i+ i inc)))
  (dolist (reg (disasm-aregs))
    (if (%ilogbitp i regmask) (push reg regs))
    (setq i (%i+ i inc)))
  (setq regs (apply #'vector regs))
  (disasm-record-list (cons (if (%ilogbitp 6 opcode) "MOVEM.L" "MOVEM.W")
                            (if (%ilogbitp 10 opcode)
                                (list (disasm-std-ea opcode) regs)
                                (list regs (disasm-std-ea opcode))))))

(defdisasm bf (opcode)
  (let* ((optype (%ilogand 7 (%ilsr 8 opcode)))
         (opname (svref #("BFTST" "BFEXTU" "BFCHG" "BFEXTS" "BFCLR" "BFFFO" "BFSET" "BFINS") optype))
         (bfword (disasm-nextword))
         (width (%ilogand 31 bfword))
         (offset (%ilogand 31 (%ilsr 6 bfword)))
         (reg (if (%ilogbitp 0 optype) (disasm-dreg (%ilsr 12 bfword))))
         (ea (disasm-std-ea opcode)))
    (if (%ilogbitp 5 bfword) (setq width (disasm-dreg width)))
    (if (%ilogbitp 11 bfword) (setq offset (disasm-dreg offset)))
    (if reg
      (if (eq optype 7)
        (disasm-record opname reg offset width ea)
        (disasm-record opname ea offset width reg))
      (disasm-record opname ea offset width))))

(defun disasm-fp-op (code fmt)
  (when (setq code
              (%cdr (assq code '((0 . "FMOVE") (1 . "FINT") (2 . "FSINH")
                                 (3 . "FINTRZ") (4 . "FSQRT") (6 . "FLOGNP1")
                                 (8 . "FETOXM1") (9 . "FTANH") (10 . "FATAN")
                                 (12 . "FASIN") (13 . "FATANH") (14 . "FSIN")
                                 (15 . "FTAN") (16 . "FETOX") (17 . "FTWOTOX")
                                 (18 . "FTENTOX") (20 . "FLOGN") (21 . "FLOG10")
                                 (22 . "FLOG2") (24 . "FABS") (25 . "FCOSH")
                                 (26 . "FNEG") (28 . "FACOS") (29 . "FCOS")
                                 (30 . "FGETEXP") (31 . "FGETMAN") (32 . "FDIV")
                                 (33 . "FMOD") (34 . "FADD") (35 . "FMUL")
                                 (36 . "FSGLDIV") (37 . "FREM") (38 . "FSCALE")
                                 (39 . "FSGLMUL") (40 . "FSUB") (48 . "FSINCOS")
                                 (56 . "FCMP") (58 . "FTST")))))
    (%str-cat code (nth fmt '(".L" ".S" ".X" ".P" ".W" ".D" ".B" ".P")))))

(defun disasm-fpreg (fp) (nth fp '(fp0 fp1 fp2 fp3 fp4 fp5 fp6 fp7)))

(defdisasm fpgen (opcode)
  (let* ((ea (%ilogand opcode #o77))
         (opword (disasm-nextword))
         (opclass (%ilogand 7 (%ilsr 13 opword)))
         (rx (%ilogand 7 (%ilsr 10 opword)))
         (ry (%ilogand 7 (%ilsr 7 opword)))
         (ext (%ilogand #o177 opword))
         op)
    (cond ((and (eq opclass 0) (eq ea 0) (setq op (disasm-fp-op ext 2)))
           (disasm-record op (disasm-fpreg rx) (disasm-fpreg ry)))
          ((and (eq opclass 0) (eq ea 0) (<= 48 ext 55))
           (disasm-record "FSINCOS.X"
                          (disasm-fpreg rx)
                          (disasm-fpreg (%ilogand ext 7))
                          (disasm-fpreg ry)))
          ((and (eq opclass 2) (neq rx 7) (setq op (disasm-fp-op ext rx)))
           (disasm-record op
                          (disasm-std-ea ea)
                          (disasm-fpreg ry)))
          ((and (eq opclass 2) (neq rx 7) (<= 48 ext 55))
           (disasm-record (disasm-fp-op 48 rx)
                          (disasm-std-ea ea)
                          (disasm-fpreg (%ilogand ext 7))
                          (disasm-fpreg ry)))
          ((and (eq opclass 2) (eq ea 0) (eq rx 7))
           (disasm-record "FMOVECR.X" `($ ,ext) (disasm-fpreg ry)))
          ((and (eq opclass 3) (neq (%ilogand rx 3) 3) (eq ext 0))
           (disasm-record (disasm-fp-op 0 rx)
                          (disasm-fpreg ry)
                          (disasm-std-ea ea)))
          ((and (eq opclass 3) (eq rx 3))
           (disasm-record (disasm-fp-op 0 rx)
                          (disasm-fpreg ry)
                          (disasm-std-ea ea)
                          `($ ,(if (%i< ext #o100) ext (%i- ext #o200)))))
          ((and (eq opclass 3) (eq rx 7) (eq 0 (%ilogand #xF ext)))
           (disasm-record (disasm-fp-op 0 rx)
                          (disasm-fpreg ry)
                          (disasm-std-ea ea)
                          (disasm-dreg (%ilsr 4 ext))))
          (t (disasm-record 'dc.w opcode opword)))))

(defdisasm unrec (opcode)
   (disasm-unrec opcode))

(defun disasm-unrec (opcode)
 (disasm-record 'dc.w opcode))

(defun disasm-record (&rest args)
  (disasm-record-list args))

(defun disasm-record-list (args)
  (push (cons *disasm-instr-pc* args) *disasm-instructions*))

(provide "DISASSEMBLE")

) ; #-ppc-target

; end
