;;;-*-Mode: LISP; Package: CCL -*-

;;	Change History (most recent first):
;;  7 9/27/96  akh  fasl version
;;  5 7/27/95  akh  rehash patch - dbfloop.l
;;  3 2/17/95  slh  gb's fix to FaslDefvarinit
;;  (do not edit before this line!!)

; FasLoad.Lisp  - low level fast loader for Coral Lisp.
; Copyright 1985-1988 Coral Software Corp.
; Copyright 1989-1994 Apple Computer, Inc.
; Copyright 1995-1999 Digitool, Inc.

#| Recompiling instructions:
1. compile xdump.lisp (to xdump;xdump.fasl)
2. load xdump.fasl
3. compile fasload.lisp (to xdump;fasload.fasl)
4. load fasload.fasl
5. (dump-boot)
6. rebuild lisp-8
|#

; Modification History
;
;  08/10/98 akh  faslxintern passes package to %%addsym in ATEMP0 - not acc!
;  8/04/95 gb    flush_code_cache when consing lfun.
;  5/12/95 slh   PB's for new interfaces
;  5/06/95 slh   requires
;  3/14/95 slh   FaslGVec: use allocgvsub not allocvect, to get a vector that is
;                initialized and has the proper page-crossing behavior
;  2/17/95 slh   gb's fix for FaslDefvarinit
;--------------- 3.0d17
; 09/15/93 alice faslgvec needs to call allocvect for correct page crossing table
;---------- RIP
;;start of added text
; 06/29/93 bill FaslERef & FaslERefLfun read an unsigned word to
;               double the maximum table size.
; -------------- 3.0d11
; 06/06/93 alice added faslXchar, faslXsym, faslXintern, faslXPkgIntern and faslXPkg
; 06/05/93 alice just a note for the next guy who wonders - to get the contents
;		 of this file into your next image
;		 1. compile xdump.lisp 2. compile fasload.lisp 3.(dump-boot) 4. rebuild lisp-8
; 06/05/93 alice %%find-pkg %ktrans-xx and %%gethashedsym do fat strings
;		 hopefully fat symbol "abc" is the same as skinny "abc"
; ------------- 3.0d9
; 04/21/93 bill grab %parse-string% for the duration of %fasload so
;               that it has a prayer of working correctly in a multi-process
;               environment.
;               Call $sp-npopnlisparea instead of discard_csarea in case
;               one of the $sp-mkvstkblk calls overflowed a stack segment.
;               ($macptr.ptr) -> $macptr.ptr (more bootstrapping removal)
;-------------- 2.1d5
; 01/07/93 bill ($v_data) -> $v_data (e.g. remove Gary's bootstrapping)
;               in %%ktrans-da-dbdy - improve hash code generation and
;               make it be 32 bits instead of 14.
;-------------- 2.0
; 01/08/92 gb   Use kernel trap dispatcher (Quadra/AFP stack nonsense.)
; -------- 2.0b4
; 10/27/91 gb   no more export-1.
; -------- 2.0b3
; 08/29/91 gb   FaslLFVec obsolete.  Use new traps.
; 08/23/91 gb   remove 32K limit in %init-htab.
; 08/21/91 gb   clear cache after writing code to memory.
; 05/10/91 bill new FaslSkip & FaslProg1 opcodes
;               FaslLFuncall needed to save _FaslEpush around call to FaslExpr
; 02/12/91 bill $sp-stkover replaces $eventch_jmp at FaslExpr
; 01/07/90 gb   no-such-package is recoverable in %fasload.  PKG-ARG maintains
;               stack discipline after calling restart.
; 01/01/91 gb   nail down %fasload.
; 12/01/90 gb   braino in %%insertsym
; 12/01/90 bill GB's fix to faslGvec in %fasload: set the subtype.
; 08/28/90 bill FF22: methods with call-next-method changed.
; 07/23/90 gb   FF21.  Fix symbol alignment problems.
; 04/30/90 gb   FF20.
; 11/06/89 gb   FF1E.
; 10/16/89 gz  Flush fasldefobfun. ExportFindSym no longer returns keywords.
;    No more ExportConflicts.  ExportCheck preserves da/db/dy.
; 9/15/89  gz  check attribute bits before descending lfun imms.
; 08/24/89 gb   changes for egc.
; 05/03/89 gz   FF1D. lfuns with linkmaps.
; 04/27/89 gb   Min_version = ($ xff1c.
; 04/07/89 gb   no subprims. FF1C
; 3/23/89  gz   FF1B. New vcells.  xt_ -> xt. Flush defuns. Don't forward fixnums.
;               In fact  don't do auto-promotion at all for now. Use QconsZnil.
; 2/24/89  gz  don't call _mkuvect.
; 11/24/88 gz   csarea stuff around traps...
; 11/23/88 gb   regmask.
; 10/24/88 gb   lfun vector subtype set correctly  FF1A only  locatives obsolete.
; 10/23/88 gb   8.9 upload.
;9/22/88  gb    fasllfvec understands new immediates map.
;9/9/88   gz  flushed ff16 bootstrapping code. Save whole _FaslEPush slot.
;9/8/88   gb    FF17 longword alignment of cstack.
;9/3/88   gz  no more c_substr.
;8/17/88  gz  FF16 added Defmumble ops. Changed meaning of epush bit.
;    New faslereflfun  fasluvlfun  fasllfvec ops.
;7/31/88  gb    signal errors with subprims.  Don't call lfunp any more.
;11/24/87 jaj   conditionalized for Beany
;7/24/88  gb    FF15 faslhitype -> faslnil.
;7/23/88  gz  make gcable.
;    gb  Lisp-8
;5/12/88  gb    FF13: newer newfangled lfun-vectors.
;5/11/88  gb    FF12: newfangled lfun-vectors.
;7/08/87  gb    Vectorized packages.
;7/5/87   gz    FF11 : No more big-block and old-style-lfuns.
;               ETab op is now required  and must be sufficiently large.
;               Etab n1array -> vector.
;               FaslExtern.
;6/27/87  gb    FF10 : New unwind scheme.
;6/17/87  gb    YAFF : FF0F.
;6/12/87  gz    short fixnum op.
;06/12/87 gb    typecheck for SYMBL in faslsymloc.
;06/06/87 gb    FF0E  new lfun bits.
;06/05/87 gb    use defun macro.
;06/02/87 gb    FF0D  31-bit fixnums.
;5/15/87  gb    lfentry macros.
;5/15/87  gb    FF0C  1 token on vstack.
;5/9/87   gz  FF0B  uvector lfuns.
;5/04/87  gb    FaslQLfun makes lfun uvectors.
;4/14/87  gz  FF0A  for 8mb page table.
;4/9/87   gz  use lfentry.
;3/23/87  gz    FF09  symbol locatives.
;3/11/87  gz    FF08 (for new vector subtypes)
;3/3/87   gz    Fix for file format FF01.
;02/05/87 gz  FF07 FaslIVec  FaslGVec.  Allow longword sizes.
;01/30/87 gb  popcatch -> nthrow.
;01/29/87 gz  seg betty
;01/24/87 gz  Pass bad index to XARROOB.
;01/18/87 gz  FaslBin OR's in the subtype.
;01/12/87 gz  FF06 FaslEval
;01/12/87 gb    changed FASL_VERS to 5  set lfun array[0] to lfun in FaslQLFun
;12/29/86 gb    spop asave0/jmp_subprim Qvalues
;12/29/86 gz  FF04 Changes for packages  real error numbers
;12/21/86 gz  Made FaslSYmtab call FindSymTab  not c_FindSymTab...
;12/17/86 gz  Logo conditionals
;11/22/86 gz  FF03  added a5 opcodes  symfn. Still supports FF02.
;               Support for file format FF01 (relative block table).
;10/29/86 gz    Fixed n1array reading.
;10/26/86 gz    Added (%faslopen refnum).
;    Made FaslOpen copy filename string
;10/13/86 gb  iocompletion(sp) -> iocompletion(a0) in FaslOpen
; 9/27/86 gz  FF02. New strings  pgbin  symtabs/pkgintern  buffered i/o.
; 9/24/86 gb  changed unwind-protect sequence.
; 9/21/86 gz  New file.


(eval-when (:compile-toplevel :execute)
  (require "SYSEQU")
  (require "LAP")
  (require "LAPMACROS")
  (compile-load "ccl:xdump;xdump")
  (defconstant $fasl_vers #x29)
  (defconstant $fasl_min_vers #x29)
  (defconstant $fasl_file_id #xff00)
  (defconstant $fasl_file_id1 #xff01)
  (defconstant $faslend #xff)
  (defconstant $epush_bit #x7)
  (defconstant $faslbuflen 128)
  (defconstant $hprimes (make-array 8 
                                    :element-type '(unsigned-byte 16)
                                    :initial-contents '(20 28 44 52 68 76 92 116)))
  
  (defconstant $primsizes (make-array 23
                                      :element-type 'fixnum
                                      :initial-contents
                                      '(41 61 97 149 223 337 509 769 887 971 1153 1559 1733
                                        2609 2801 3917 5879 8819 13229 19843 24989 29789 32749)))
  
  (deflapgen defop (name)
    (apply #'%lap-expr `(jmp (^ ,name))))
  (deflapop HCOUNT (areg)
    `(car ,areg))
  (deflapop HLIMIT (areg)
    `(cdr ,areg))
  )


;acc = string or refnum.
(xdefun %fasload (string-or-refnum)
  (declare (resident))                  ; Big.
  (lap
    (equate
     _FaslFName -4
     _FaslEVec -8
     _FaslECnt -12
     _FaslIOPB -16
     _FaslVal -20
     _FaslStr -24
     _OldFaslStr -28
     _FaslErr -32
     _IOBuffer -36
     _BufCount -40
     _BufCountW -40
     _FaslVersion -44
     _FaslVersionW -44
     _FaslEPush -42
     _FaslEPushL -44
     _FaslGSymbols -48
     _numlocals (floor 48 4))
    (with-preserved-registers #(asave0)
      (move.l arg_z atemp0)
      (jsr_subprim $sp-pstr-arg-atemp0)
      (move.l atemp0 arg_z)
      (move.l vsp asave0)
      (vpush arg_z)
      (ttagp ($ $t_fixnum) arg_z da)
      (if# ne
        (moveq ($ 0) arg_z))
      (moveq ($ (1- (1- _numlocals))) da)  ;_FaslFName already pushed
      (with-local-labels
        @0 (vpush nilreg)
        (dbf da @0))
      (clr.l (asave0 _FaslVersion))    ; stick stuff in high words
      (vpush arg_z)
      (move.l (fixnum 52) acc)
      (jsr_subprim $sp-mkvstkblk)
      (move.l atemp0 (asave0 _FaslIOPB))
      (move.l (atemp0 $macptr.ptr) atemp0)
      (clr.l (atemp0 $ioFileName))
      (vpop arg_z)
      (getint arg_z)
      (move.w arg_z (atemp0 $ioRefNum))
      (move.l (fixnum (+ 4 $FASLBUFLEN)) acc)
      (jsr_subprim $sp-mkvstkblk)
      (move.l atemp0 (asave0 _IOBuffer))
      (move.l (special %parse-string%) acc)
      (move.l acc (asave0 _OldFaslStr))
      (if# (eq nilreg acc) 
        (move.l ($ 255) acc)
        (jsr_subprim $sp-MakeStr))
      (move.l acc (asave0 _FaslStr))
      (move.l nilreg (special %parse-string%))          ; in use
      (bsr FaslLoad)
      (move.l (asave0 _FaslErr) acc)
      (move.l ($ 1) da)
      (jsr_subprim $sp-npopnlisparea)
      (move.l asave0 vsp)
      (vpop asave0)
      (move.l acc arg_y)
      (move.l nilreg acc)
      (if# (eq nilreg  arg_y)
        (add.w ($ $t_val) acc))
      (bra fasl_exit)

FaslLoad
      (with-local-labels
        (pea (^ @10))
        (jsr_subprim $sp-mkunwind)
        
        (bsr FaslOpen)      ;Open file and check ID.
        (if# eq    
          (bsr ReadWord)      ;Read block count
          (pea (@w 1))        ;something odd
          (move.w da @sp)
          (if# ne
            (bsr GetFilePos)
            (loop#  
             (move.l da acc)     ;Save block info offset
             (mkint acc)
             (vpush acc)
             (bsr SetFilePos)      ;Go to block info
             (bsr ReadLong)      ;File pos of block
             (bsr SetFilePos)
             (bsr FaslBlock)      ;Read this block
             (vpop da)       ;File pos of block info
             (getint da)
             (add.l ($ 8) da)      ;advance it
             (sub.w ($ 1) @sp)      ;No more blocks?
             (bif eq (exit#)))
            (add.w ($ 4) sp)))
        
@9      (move.l nilreg acc)
        (jsr_subprim $sp-nthrow1v1)
        (rts)
        
@10     (move.l (asave0 _OldFaslStr) (special %parse-string%))
        (move.l (asave0 _FaslIOPB) atemp0)
        (move.l (atemp0 $macptr.ptr) atemp0)
        (tst.w (atemp0 $ioRefNum))
        (if# ne
          (tst.l (atemp0 $ioFilename))    ;%faslopen?
          (if# ne
            (jsr_subprim $sp-rtrap)
            (dc.w #_PBClose)))
        (rts))
      
      
      ;; Fasload a block
FaslBlock
      (with-local-labels
        (bsr ReadWord)    ;Block format version word.
        (cmp.w ($ (+ #xFF00 $FASL_VERS)) da)
        (bgtu @1)
        (cmp.w ($ (+ #xFF00 $FASL_MIN_VERS)) da)
        (bgeu @2)
@1      (move.l ($ $XFASLVERS) acc)  ;Something's wrong
        (cmp.w ($ #xFF00) da)    ;Does it at least look like FF??
        (bgeu @1a)
        (move.l ($ $XNOTFASL) acc)  ;No  totally bogus
@1a     (mkint acc)
        (set_nargs 1)
        (jmp_subprim $sp-ksignalerr)
        ; version (in da) is ok, save
@2      (move.w da (asave0 _FaslVersionW))
        (bsr ReadWord)                  ;Lisp kernel version words:  
        (bsr ReadWord)                  ; ignore.
        ;All set  start reading commands!
        (move.l nilreg (asave0 _FaslEVec))   ;No cache'd exps.
        (clr.l (asave0 _FaslECnt))
        (loop#
         (bsr ReadByte)
         (cmp.b ($ $FASLEND) da)
         (bif eq (exit#))
         (bsr FaslDispatch))
        (rts))
      
FaslExpr
;Really want to check stack here more than events  since this is
;called recursively for conses etc. Maybe Qeventch should force
;a stack check before doing events...
      (jsr_subprim $eventch_jmp)
      (bsr ReadByte)
      
FaslDispatch
      (bclr ($ $EPUSH_BIT) da)
      (sne (asave0 _FaslEPush))
      (cmp.b (^ NumFaslOps) da)
      (if# ltu
        (ext.w da)
        (add.w da da)
        (add.w da da)
        (lea (^ faslops) atemp0)
        (add.w da atemp0)
        (jmp @atemp0))
      
      (signal_error (fixnum $XBADFASL))
      
      
FaslOps
      (defop FaslNoop)                  ; 1
      (defop FaslObsolete)              ; 2
      (defop FaslETab)                  ; 3
      (defop FaslERef)                  ; 4
      (defop FaslLFuncall)              ; 5
      (defop FaslGlobals)               ; 6
      (defop FaslChar)                  ; 7
      (defop FaslFixnum)                ; 8
      (defop FaslFloat)                 ; 9
      (defop FaslStr)                   ; 10
      (defop FaslWFixnum)               ; 11
      (defop FaslMkSym)                 ; 12
      (defop FaslIntern)                ; 13
      (defop FaslPkgIntern)             ; 14
      (defop FaslPkg)                   ; 15
      (defop FaslCons)                  ; 16
      (defop FaslList)                  ; 17
      (defop FaslList_)                 ; 18
      (defop FaslNil)                   ; 19
      (defop FaslTImm)                  ; 20
      (defop FaslUVLfun)                ; 21
      (defop FaslERefLfun)              ; 22
      (defop FaslExtern)                ; 23
      (defop FaslA5DataBlk)             ; 24
      (defop FaslA5NodeBlk)             ; 25
      (defop FaslA5LFun)                ; 26
      (defop FaslA5Ref)                 ; 27
      (defop FaslSymFn)                 ; 28
      (defop FaslEval)                  ; 29
      (defop FaslIVec)                  ; 30
      (defop FaslGVec)                  ; 31
      (defop FaslObsolete)              ; 32
      (defop FaslNLFVec)                ; 33
      (defop FaslXchar)                 ; 34
      (defop FaslMkXsym)                ; 35
      (defop FaslDefun)                 ; 36
      (defop FaslObsolete)              ; 37
      (defop FaslDefmacro)              ; 38
      (defop FaslDefconstant)           ; 39
      (defop FaslDefparam)              ; 40
      (defop FaslDefvar)                ; 41
      (defop FaslDefvarinit)            ; 42
      (defop FaslSkip)                  ; 43
      (defop FaslProg1)                 ; 44
      (defop FaslXIntern)		; 45
      (defop FaslPkgXIntern)		; 46
      (defop FaslXPkg)			; 47
      
NumFaslOps
      (dc.w (ash 47 8))
      
EPushVal
      (move.l acc (asave0 _FaslVal))
      (tst.b (asave0 _FaslEPush))
      (if# ne
        (move.l (asave0 _FaslEVec) atemp0)
        (move.l (asave0 _FaslECnt) da)
        (vscale da)
        #+paranoia
        (progn
          (vsize atemp0 db)
          (cmp.l da db)
          (if# le 
            (bsr badfasl)))
        (move.l acc (atemp0 da.l $v_data))
        (add.l '1 (asave0 _FaslECnt)))
      (rts)
      
CantEPush
      (tst.b (asave0 _FaslEPush))
      (if# ne
        (bsr badfasl))
      (rts)
      
FaslNoop
      #+paranoia (bsr CantEPush)
      (rts)
      
FaslETab
      #+paranoia (bsr CantEPush)
      (bsr ReadLong)           ;# of entries.
      (move.l da acc)
      (asl.l ($ 2) acc)    ;# bytes
      (jsr_subprim $sp-allocgv)
      (move.l atemp0 (asave0 _FaslEVec))
      (clr.l (asave0 _FaslECnt))
      (rts)
      
FaslERef
      (clr.l da)
      (bsr ReadWord)
      #+paranoia
      (progn
        (move.l (asave0 _FaslECnt) db)
        (getint db)
        (cmp.l db da)
        (if# geu
          (bsr badfasl)))
      (lsl.l ($ 2) da)
      (move.l (asave0 _FaslEVec) atemp0)
      (move.l (atemp0 da.l $v_data) acc)
      (bra epushval)
      
FaslLFuncall
      (vpush (asave0 _FaslEPushL))
      (bsr FaslExpr)    ;Read an Lfun
      (vpop (asave0 _FaslEPushL))
      (move.l (asave0 _FaslVal) atemp0)
      (set_nargs 0)
      (jsr @atemp0)
      (bra epushval)
      
FaslChar
      (bsr ReadByte)
      (moveq ($ $t_imm_char) acc)
      (swap acc)
      (move.b da acc)
      (swap acc)
      (bra epushval)

FaslXchar
      (bsr ReadWord)
      (moveq ($ $t_imm_char) acc)
      (swap acc)
      (move.w da acc)
      (swap acc)
      (bra epushval)

FaslTImm
      (bsr ReadLong)
      (move.l da acc)
      #+paranoid (if# (ne (ttagp ($ $t_imm) acc da)) (dc.w #_debugger))
      (bra epushval)

FaslWFixnum
      (bsr ReadWord)
      (ext.l da)

FaslFixnum0
      (move.l da acc)
      (mkint acc)
      (bra epushval)
      
FaslFixnum
      (bsr ReadLong)
      (bra FaslFixnum0)
      
FaslFloat
      (bsr ReadLong)
      (pea (@w 1))
      (move.w da @sp)
      (pea (@w 1))
      (swap da)
      (move.w da @sp)
      (bsr ReadLong)
      (move.w @sp arg_y)
      (swap arg_y)
      (add.w ($ 4) sp)
      (move.w @sp arg_y)
      (add.w ($ 4) sp)
      (move.l da arg_z)
      (jsr_subprim $sp-makefloat)
      (bra epushval)
      
FaslStr
      (bsr ReadSize)
      (jsr_subprim $sp-MakeStr)
      (bsr epushval)
      (move.l acc atemp1)
      (bra ReadBin)
      
ReadSize
      (bsr ReadByte)
      (moveq ($ 0) acc)
      (move.b da acc)
      (add.b ($ 1) da)
      (if# eq
        (bsr ReadWord)
        (moveq ($ 0) acc)
        (move.w da acc)
        (add.w ($ 1) da)
        (if# eq
          (bsr ReadLong)
          (move.l da acc)))
      (rts)
      
; acc,atemp0<- string  da=len
; dy=length or nil if freshly consed.
ReadStr
      (bsr ReadSize)
      (move.l (asave0 _FaslStr) atemp1)
      (getvect atemp1 da)
      (if# (lt acc da)
        (jsr_subprim $sp-MakeStr)
        (vpush acc)
        (move.l acc atemp1)
        (bsr ReadBin)
        (vpop acc)
        (move.l acc atemp0)
        (vsize atemp0 da)
        (move.l nilreg dy)
        (rts))


      (move.l acc db)
      (mkint acc)
      (vpush acc)
      (bsr ReadNBytes)
      (vpop dy)
      (move.l dy da)
      (getint da)
      (move.l (asave0 _FaslStr) acc)
      (move.l acc atemp0)
      (rts)
      
FaslIVec
      (bsr ReadByte)      ;subtype
      (and.w ($ (lognot $VNODE)) da)
      (pea (@w 1))
      (move.b da @sp)
      (bsr ReadSize)      ;acc <- size in bytes
      (moveq ($ 0) arg_y)
      (move.b @sp arg_y)
      (add ($ 4) sp)
      (jsr_subprim $sp-allocvect)
      (move.l atemp0 acc)
      (bsr epushval)
      (move.l acc atemp1)
      (bra ReadBin)
      
FaslGVec
      (with-preserved-registers #(dsave0 dsave1 asave1)
        (bsr ReadByte)      ;subtype
        (or.b ($ $VNODE) da)
        (pea (@w 1))
        (move.b da @sp)
        (bsr ReadSize)     ;acc <- number of entries
        (lsl.l ($ 2) acc)      ;Number of bytes
        (move.l acc dsave0)
        (vunscale.l dsave0)

        (moveq ($ 0) arg_y)
        (move.b @sp arg_y)
        (add ($ 4) sp)
        (jsr_subprim $sp-allocgvsub) ; was $sp-allocvect, didn't init slots
        (move.l atemp0 acc)

        (bsr epushval)
        (move.l acc asave1)
        (moveq '0 dsave1)
        (while# (ne dsave1 dsave0)
                (bsr FaslExpr)
                (move.l dsave1 da)
                (vscale.l da)
                (move.l (asave0 _FaslVal) (asave1 da.l $v_data))
                (add.l '1 dsave1))
         (move.l asave1 (asave0 _FaslVal)))
      (rts)
      
FaslMkSym
      (bsr ReadSize)    ; << don't assume its a base-string
      (jsr_subprim $sp-MakeStr)
FaslMkSym1
      (vpush acc)
      (move.l acc atemp1)
      (bsr ReadBin)
      (vpop acc)
      (jsr_subprim $sp-MakeSym)
      (bra epushval)

FaslMkXSym
     (bsr ReadSize)
     (jsr_subprim $sp-MakeXStr)
     (bra FaslMkSym1)

      
      
FaslPkgIntern
      (vpush (asave0 _FaslEPushL))
      (bsr FaslExpr)
      (vpop (asave0 _FaslEPushL))
      #+paranoia
      (progn
        (ccall pkg-arg (asave0 _FaslVal)))
      (vpush (asave0 _FaslVal))
      (bra FaslIntern0)

FaslPkgXIntern
      (vpush (asave0 _FaslEPushL))
      (bsr FaslExpr)
      (vpop (asave0 _FaslEPushL))
      #+paranoia
      (progn
        (ccall pkg-arg (asave0 _FaslVal)))
      (vpush (asave0 _FaslVal))
      (bra FaslXIntern0)

FaslXIntern
      (vpush (special *package*))
FaslXIntern0
      (bsr ReadSize)    ; length in bytes
      (jsr_subprim $sp-MakeXstr)
      (vpush acc)
      (move.l acc atemp1)
      (bsr ReadBin)     ; readbin wants vect in atemp1 - clobbers
      (vpop atemp0)     ; what is in which regs now?
      (vsize atemp0 da)
      (move.l (vsp)  acc) ; package
      (jsr #'%%FindSym)
      (if# eq
        (vpop atemp0)  ; package
        (jsr #'%%AddSym)
        else#
        (lea (vsp 4) vsp))
      (bra epushval)
      
FaslIntern
      (vpush (special *package*))

FaslIntern0   ;Package on TOS
      (bsr ReadStr)    ; << don't assume its a base-string
FaslIntern1
      (vpush dy)    ;Save in case not found - LENGTH OR NIL IF NEW
      (vpush acc)
      (move.l (vsp 8) acc)  ;The package
      (jsr #'%%FindSym)
      (if# eq
        (vpop acc)
        (vpop da)
        (if# (ne nilreg da)
          (begin_csarea)
          (movem.l #(db dy) -@sp)
          (begin_csarea)
          (bsr copystr)
          (spop_csarea)
          (movem.l sp@+ #(db dy))
          (spop_csarea))
        (vpop atemp0)
        (jsr #'%%AddSym)
        else#
        (lea (vsp 12) vsp))

      (bra epushval)
      
;Intern the symbol  then export it.
; **** This is never used ****
FaslExtern
      (bra FaslObsolete)
      
      
FaslPkg
      (bsr ReadStr)  ; << dont assume its base-string
      (vpush dy)    ;Save in case of error
      (vpush acc)
      (move.l acc atemp0)
      ;(add ($ $v_data) atemp0)
      (jsr #'%%Find-Pkg)
      (if# (ne nilreg acc)
        (add.l ($ 8) vsp)
        else#
        (vpop acc)
        (vpop da)
        (if# (ne nilreg da)
          (bsr copystr))
        (signal_restart (fixnum $XNOPKG) acc))
      (bra epushval)

FaslXPkg
      (bsr ReadSize)    ; length in bytes
      (jsr_subprim $sp-MakeXstr)
      (vpush acc)
      (move.l acc atemp1)
      (bsr ReadBin)     ; readbin wants vect in atemp1 - clobbers
      (move.l (vsp) atemp0)
      (jsr #'%%Find-Pkg)
      (if# (eq nilreg acc)
        (vpop acc)
        (signal_restart (fixnum $XNOPKG) acc)
        else#
        (lea (vsp 4) vsp))
      (bra epushval)
      
     
      
      
CopyStr
      (vpush acc)
      (move.l da acc)
      (getint acc)
      (jsr_subprim $sp-MakeStr)
      (getvect atemp0 da)
      (vpop atemp1)
      (add.w ($ $v_data) atemp1)
      (dbfloop da (move.b atemp1@+ atemp0@+))
      (rts)
      
FaslCons
      (move.l nilreg arg_z)
      (jsr_subprim $sp-consZnil)
      (bsr epushval)
      (vpush acc)
      (bsr FaslExpr)
      (move.l @vsp atemp0)
      (rplaca atemp0 (asave0 _FaslVal))
      (bsr FaslExpr)
      (vpop atemp0)
      (rplacd atemp0 (asave0 _FaslVal))
      (move.l atemp0 (asave0 _FaslVal))
      (rts)
      
FaslList
      (pea (@w 1))
      (sf (sp))
      (bra FaslListx)
FaslList_
      (pea (@w 1))
      (st (sp))
FaslListx
      (with-local-labels
        (bsr ReadWord)
        (pea (@w 1))
        (move.w da @sp)
        (move.l nilreg arg_z)
        (jsr_subprim $sp-consznil)
        (bsr epushval)
        (vpush asave1)
        (vpush acc)
        (move.l acc asave1)
        (bsr FaslExpr)
        (rplaca asave1 (asave0 _FaslVal))
        (sub.w ($ 1) @sp)
        (bmi @2)
@1  
        (bsr FaslExpr)
        (move.l (asave0 _FaslVal) arg_z)
        (jsr_subprim $sp-consznil)
        (rplacd asave1 acc)
        (move.l acc asave1)
        (sub.w ($ 1) @sp)
        (bpl @1)
@2
        (add ($ 4) sp)
        (tst.b @sp)    ;list or list*?
        (add ($ 4) sp)
        (if# ne
          (bsr FaslExpr)
          (rplacd asave1 (asave0 _FaslVal)))
        (vpop (asave0 _FaslVal))
        (vpop asave1)
        (rts))
      
FaslNil
      (move.l nilreg acc)
      (bra epushval)
      
FaslGlobals
      (bsr FaslExpr)
      (move.l (asave0 _FaslVal) (asave0 _FaslGSymbols))
      (rts)
      
FaslA5DataBlk
      #+paranoia
      (bsr CantEPush)
      
      (bsr ReadWord)    ;Start offset
      (pea (@w 1))
      (move.w da (sp))
      (bsr ReadWord)   ;Number of bytes
      (move.w (sp) db)
      (add.w ($ 4) sp)
      (lea (a5 db.w) atemp1)
      (moveq ($ 0) db)
      (move.w da db)
      (bra ReadNBytes)
      
FaslA5NodeBlk
      (with-local-labels
        #+paranoia
        (bsr CantEPush)
        (bsr ReadWord)    ;Start offset
        (pea (@w 1))
        (move.w da (sp))
        (bsr ReadWord)    ;Number of exps
        (move.w (sp) db)
        (add.w ($ 4) sp)
        (bra @10)
@1      (pea (@w 1))
        (move.w da (sp))
        (pea (@w 1))
        (move.w db (sp))
        (bsr FaslExpr)
        (move.w (sp) db)
        (add.w ($ 4) sp)
        (move.l (asave0 _FaslVal) (a5 db.w))
        (add.w ($ 4) db)
        (spop da)
        (swap da)
@10     (dbf da @1)
        (rts))
      
; This is actually pretty old; that's what the "N" stands for.
FaslNLFVec
      (with-preserved-registers #(asave1 dsave0 dsave1 dsave2)
        (bsr ReadSize)                  ; Acc = size in bytes
        (moveq ($ $v_nlfunv) arg_y)
        ; _read can't cons unless they're swapping floppies or something  I hope.
        (jsr_subprim $sp-allocvect)
        (move.l acc dsave0)             ; remember logical size of vector
        (move.l atemp0 acc)
        (bsr epushval)
        (move.l acc asave1)                      ; asave1 = The vector
        (move.l dsave0 db)
        (mkint dsave0)
        (lea (asave1 $v_data) atemp1)
        (bsr ReadNBytes)
        (move.w (asave1 ($lfv_attrib)) acc)
        (if# (ne (btst ($ $lfatr-immmap-bit) acc))
          (moveq 0 dsave1)
          (move.l dsave0 dsave2)
          (getint dsave2)
          (btst ($ $lfatr-slfunv-bit) acc)     ;Shouldn't really happen  but then
          (if# ne                              ; shouldn't crash if it does  either...
            (sub.l ($ 4) dsave2))
          (sub.l ($ 4) dsave2)
          (bra @next)
          (prog#
           (if# (cs (add.b acc acc))
             (ror.w ($ 8) acc)
             (move.b -@atemp1 acc)
             (sub.l ($ 1) dsave2)
             (ror.w ($ 8) acc))
           (add.l acc dsave1)
           (vunscale.w dsave1)
           (mkint dsave2)
           (bsr FaslExpr)
           (move.l (asave0 _FaslVal) atemp1)
           (getint dsave2)
           (vscale.w dsave1)
           (if# (ne (move.l (asave1 dsave1.l ($lfv_lfun)) acc))         ; locative, may be indirect
             (if# (eq (cmp.b ($ $sym.gvalue) acc))
               (btst ($ $sym_bit_indirect) (atemp1 $sym.vbits))
               else#
               (btst ($ $sym_bit_indirect) (atemp1 $sym.fbits)))
             (add.l acc atemp1)
             (if# ne             
               (if# (eq (sub.w ($ $sym.gvalue) acc))
                 (debug "Indirect vcell in lfunv")
                 (move.l @atemp1 atemp1)
                 else#
                 (debug "Indirect fcell in lfunv")
                 (move.l (atemp1 (- $sym.entrypt $sym.fapply)) atemp1))))                
           (move.l atemp1 (asave1 dsave1.l ($lfv_lfun)))           
@next      (lea (asave1 dsave2.l $v_data) atemp1)
           (moveq ($ 0) acc)
           (sub.l ($ 1) dsave2)
           (move.b -@atemp1 acc)
           (until# eq)))
        (move.l asave1 (asave0 _FaslVal))
        (move.l ($ $lfv_lfun) acc)
        (add.l asave1 acc))
      (jmp_subprim $flush_code_cache)


FaslUVLfun
      (vpush (asave0 _FaslEPushL))
      (bsr FaslExpr)
      (vpop (asave0 _FaslEPushL))
      (move.l (asave0 _FaslVal) acc)
      (bra FaslUVLfun0)
      
FaslERefLfun
      (clr.l da)
      (bsr ReadWord)
      
      #+paranoia
      (progn
        (move.l (asave0 _FaslECnt) db)
        (getint db)
        (if# (geu db da)
          (bsr badfasl)))
      
      (lsl.l ($ 2) da)
      (move.l (asave0 _FaslEVec) atemp0)
      (move.l (atemp0 da.l $v_data) acc)
      
FaslUVLfun0
      #+paranoia
      (progn
        (ttagp ($ $t_vector) acc da)
        (bne @bad)
        (move.l acc atemp0)
        (vsubtypep ($ $v_nlfunv) atemp0 da)
        (if# ne 
          @bad    
          (bsr badfasl)))
      (add.l ($ ($lfv_lfun)) acc)
      (bra epushval)
      
FaslA5LFun
      (bsr ReadWord)   ;offset
      (lea (a5 da.w 0) atemp0)
      (move.l atemp0 acc)
      (bsr epushval)
      #+paranoia
      (progn
        (ttagp ($ $t_lfun) acc da)
        (if# ne 
          (bsr badfasl)))
      (rts)
      
FaslA5Ref
      (bsr ReadWord)
      (move.l (a5 da.w) acc)
      (bra epushval)
      
FaslSymFn
      (vpush (asave0 _FaslEPushL))
      (bsr FaslExpr)
      (vpop (asave0 _FaslEPushL))
      (move.l (asave0 _FaslVal) atemp0)
      (jsr_subprim $sp-%function)
      (move.l atemp0 acc)
      (bra epushval)
      
FaslEval
      (vpush (asave0 _FaslEPushL))
      (bsr FaslExpr)
      (vpop (asave0 _FaslEPushL))
      (ccall eval (asave0 _FaslVal))
      (bra epushval)
      
FaslDefun
      #+paranoia (bsr CantEPush)
      
      (bsr FaslExpr)
      (vpush (asave0 _FaslVal))
      (bsr FaslExpr)
      (cjmp %defun vsp@+ (asave0 _FaslVal))
      
FaslDefmacro
      #+paranoia (bsr CantEPush)
      
      (bsr FaslExpr)
      (vpush (asave0 _FaslVal))
      (bsr FaslExpr)
      (cjmp %macro vsp@+ (asave0 _FaslVal))
      
FaslDefconstant
      #+paranoia (bsr CantEPush)
      (bsr FaslExpr)
      (vpush (asave0 _FaslVal))
      (bsr FaslExpr)
      (vpush (asave0 _FaslVal))
      (bsr FaslExpr)
      (vpop arg_y)
      (vpop arg_x)
      (move.l (asave0 _FaslVal) arg_z)
      (set_nargs 3)
      (jmp #'%defconstant)
      
FaslDefvar
      #+paranoia (bsr CantEPush)
      (bsr FaslExpr)
      (cjmp %defvar (asave0 _FaslVal))
      
FaslDefparam
      #+paranoia (bsr CantEPush)
      (bsr FaslExpr)
      (vpush (asave0 _FaslVal))    ;sym
      (bsr FaslExpr)
      (vpush (asave0 _FaslVal))    ;value
      (bsr FaslExpr)
      (move.l (asave0 _FaslVal) arg_z)  ;doc
      (ccall %defvar (vsp 4) arg_z)

FaslDefparam1
      (vpop arg_z)
      (vpop arg_y)
      (jmp_subprim $sp-set)
      
FaslDefvarinit
      #+paranoia (bsr CantEPush)
      (bsr FaslExpr)
      (vpush (asave0 _FaslVal))  ;sym
      (bsr FaslExpr)
      (vpush (asave0 _FaslVal))    ;value
      (bsr FaslExpr)
      (move.l (asave0 _FaslVal) arg_z)  ;doc
      (ccall %defvar (vsp 4) (asave0 _FaslVal))
      (cmp.l acc nilreg)
      (beq FaslDefparam1)
      (add.w ($ 8) vsp)
      (rts)

FaslSkip
      (bsr FaslExpr)
      (bra FaslExpr)

FaslProg1
      (bsr FaslExpr)
      (vpush (asave0 _FaslVal))
      (bsr FaslExpr)
      (vpop (asave0 _FaslVal))
      (rts)
      
FaslObsolete
      (dc.w #x4afc)
      
      
      ;;; File I/O
FaslOpen
      (move.l (asave0 _FaslIOPB) atemp0)
      (move.l (atemp0 $macptr.ptr) atemp0)
      (tst.w (atemp0 $ioRefNum))   ;%faslopen?
      (if# eq 
        (begin_csarea)
        (move.l sp db)     ;db=old stack ptr
        (move.l (asave0 _FaslFName) atemp0)
        (getvect atemp0 d1)
        (moveq 0 d0)
        (move.b d1 d0)
        (moveq 1 da)
        (or.b da d1)
        (add.w da d1)
        (sub.s d1 sp)
        (move.l sp atemp1)              ;atemp1=copy of filename
        (move.b d0 (@+ atemp1))
        (dc.w #_BlockMove)
        (sub ($ 1) atemp1)
        (move.l (asave0 _Fasliopb) atemp0)
        (move.l (atemp0 $macptr.ptr) atemp0)
        (move.l atemp1 (atemp0 $ioFileName))
        (clr.l (atemp0 $ioCompletion))
        (clr.b (atemp0 $ioFileType))
        (clr.w (atemp0 $ioVRefNum))
        (move.b ($ $fsRdPerm) (atemp0 $ioPermssn))
        (clr.l (atemp0 $ioOwnBuf))
        (spush db)
        (jsr_subprim $sp-rtrap)
        (dc.w #_PBOpen)
        (spop sp)     ;Restore stack pointer
        (spop_csarea)
        (tst.w d0)
        (bne @nofile))
      
      (jsr_subprim $sp-Rtrap)
      (dc.w #_PBGetEOF)
      (tst.w d0)
      (bne ioerror)
      (move.l (atemp0 $ioLEOF) da)
      (sub.l ($ 4) da)
      (blt @nofasl)
      (clr.l (asave0 _BufCount))  ;Init I/O.
      (clr.l (atemp0 $ioPosOffset))
      (bsr ReadWord)
      (cmp.w ($ $FASL_FILE_ID) da)
      (beq @rts)
      (cmp.w ($ $FASL_FILE_ID1) da)
      (bne @nofasl)
      (bsr ReadLong)
      (bsr SetFilePos)
      (moveq ($ 0) acc)      ;Set Z flag
@rts
      (rts)
      
@nofasl  
      (move.l (fixnum $XNOTFASL) (asave0 _FaslErr))  ;Not one of ours
      (moveq ($ -1) acc)
      (rts)
      
@nofile  
      (ext.l acc)
      (mkint acc)
      (move.l acc (asave0 _FaslErr))
      (moveq ($ -1) acc)
      (rts)
      
ReadByte
      (move.l (asave0 _IOBuffer) atemp1)
      (move.l (atemp1 $macptr.ptr) atemp1)
      (sub.w ($ 1) (asave0 _BufCountw))
      (if# ge 
        (move.l @atemp1 atemp0)
        (move.b atemp0@+ da)
        (move.l atemp0 @atemp1)
        (rts))
      (move.l atemp1 @atemp1)
      (add.l ($ 4) atemp1@+)
      (move.l (asave0 _FaslIOPB) atemp0)
      (move.l (atemp0 $macptr.ptr) atemp0)
      (move.l ($ $faslbuflen) (atemp0 $ioByteCount))
      (move.l atemp1 (atemp0 $ioBuffer))
      (move.w ($ $fsAtMark) (atemp0 $ioPosMode))
      (jsr_subprim $sp-rtrap)
      (dc.w #_PBRead)          ;Doesn't gc
      (move.w (atemp0 (+ $ioNumDone 2)) (asave0 _BufCountw))
      (bne ReadByte)
ioerror
      (ext.l acc)
      (mkint acc)
      (tsignal_error acc)
      
ReadWord
      (bsr ReadByte)
      (move.b da -@sp)
      (bsr ReadByte)
      (move.b da db)
      (move.w sp@+ da)
      (move.b db da)
      (rts)
      
ReadLong
      (bsr ReadWord)
      (move.w da -@sp)
      (bsr ReadWord)
      (swap da)
      (move.w sp@+ da)
      (swap da)
      (rts)
      
ReadBin      ;atemp1=vector pointer
      (getvect atemp1 db)
      ;bra ReadNBytes

ReadNBytes      ;atemp1=ptr  db=#bytes
      (with-local-labels
        (move.l (asave0 _IOBuffer) atemp0)
        (move.l (atemp0 $macptr.ptr) atemp0)
        (move.l atemp0 acc)
        (move.l (atemp0) atemp0)    ;bufptr
        (move.w (asave0 _BufCountw) da)
        (ext.l da)
        (sub.l da db)
        (if# lt 
          (add.l db da)
          (moveq ($ 0) db))
        (sub.w da (asave0 _BufCountw))
        (bra @2)
        @1  (move.b atemp0@+ atemp1@+)
        @2  (dbf da @1)
        (exg acc atemp0)
        (move.l acc @atemp0)
        (move.l (asave0 _FaslIOPB) atemp0)
        (move.l (atemp0 $macptr.ptr) atemp0)
        (move.l db (atemp0 $ioByteCount))
        (if# ne
          (move.l atemp1 (atemp0 $ioBuffer))
          (move.l sp da)
          (move.l (a5 $trap_sp) sp)
          (dc.w #_PBRead)        ;Doesn't gc
          (move.l da sp)
          (bne ioerror))
        (rts))
      
      
SetFilePos
      (move.l (asave0 _FaslIOPB) atemp0)
      (move.l (atemp0 $macptr.ptr) atemp0) 
      (move.l (atemp0 $ioPosOffset) dy)    ;Real file pos
      (sub.l da dy)        ;dy=# bytes moving back
      (if# ge        ;Moving fwd from end  punt
        (move.w (asave0 _BufCountw) db)    ;db=# bytes stored
        (ext.l db)
        (sub.l dy db)        ;db=# bytes fwd from ptr
        (if# ge        ;Moving bwd from start  punt
          (move.w dy (asave0 _BufCountw))    ;Else just update local info
          (move.l (asave0 _IOBuffer) atemp0)
          (move.l (atemp0 $macptr.ptr) atemp0)
          (add.l db @atemp0)      ;bufptr
          (rts)))
      (move.l da (atemp0 $ioPosOffset))
      (move.w ($ $fsFromStart) (atemp0 $ioPosMode))
      (jsr_subprim $sp-Rtrap)
      (dc.w #_PBSetFPos)
      (tst.w d0)
      (bne ioerror)
      (clr.w (asave0 _BufCountw))
      (rts)
      
      
GetFilePos
      (move.l (asave0 _FaslIOPB) atemp0)
      (move.l (atemp0 $macptr.ptr) atemp0)
      (move.l (atemp0 $ioPosOffset) da)
      (move.w (asave0 _BufCountw) db)
      (ext.l db)
      (sub.l db da)
      (rts)
      
      BadFasl
      (signal_error (fixnum $XBADFASL)))
    fasl_exit
    (vpush acc)
    (vpush arg_y)
    (set_nargs 2)
    (jmp_subprim $sp-nvalret)))

;Called with acc=size (boxed), returns with atemp0=acc=htab
(xdefun %%NewHash (&lap size)
  (lap
    (vpush acc)
    (move.l '0 arg_y)
    (move.l '0 arg_z)
    (jsr_subprim $sp-consYZ)
    (move.l nilreg arg_y)
    (jsr_subprim $sp-consYZ)
    (move.l acc atemp0)
    (vpop acc)
    (jmp #'%%init-htab)))

;atemp0 = "htab" (preserved), acc = array size (boxed)
(xdefun %%init-htab (&lap 0)
  (lap
    (getint acc)
    (if# (gt ($ 32749) arg_z)
      (or.w ($ 1) arg_z)                  ; ensure that it's odd
      (prog#
       (move.l '#.$hprimes atemp1)
       (add ($ $v_data) atemp1)
       (moveq 8 db)
       (dbfloop db
                (move.w atemp1@+ da)
                (lsr.w ($ 2) da)
                (move.l arg_z dy)
                (divu da dy)            ; 32/16 -> 16r:16q
                (swap dy)
                (tst.w dy)
                (if# eq
                  (add.l ($ 2) arg_z)
                  (bra (top#)))))
      else#
      (move.l '#.$primsizes atemp1)
      (add ($ $v_data) atemp1)
      (prog#     
       (until# (mi (cmp.l atemp1@+ arg_z))))
      (move.l -@atemp1 arg_z))
    (cdr atemp0 atemp1)
    (clr.l (HCOUNT atemp1))
    ; Acc is UNBOXED at this point.  Hmm...
    (move.l acc db)
    (move.l db da)
    (lsr.l ($ 3) da)
    (sub.l da db)
    (mkint db)
    (move.l db (HLIMIT atemp1))
    (vpush atemp0)
    (lsl.l ($ 2) acc)
    (jsr_subprim $sp-allocgv)
    (vpop atemp0)
    (rplaca atemp0 acc)
    (move.l atemp0 acc)
    (rts)))

; arg_z=htab
; Set the size of the symbol-hash-table to about 87.5% occupancy & rehash everything
; destructively modifies the symbol-hash-table & returns it
(xdefun %%hresize (&lap htab)
  (lap
    (with-preserved-registers #(asave0 asave1 dsave0 dsave1)
      (defreg htab asave0)
      (defreg oldharr asave1)
      (defreg oldhsize dsave0)
      (defreg index dsave1)

      (move.l arg_z htab)
      (car htab oldharr)
      (vsize oldharr oldhsize)
      (vunscale.l oldhsize)
      (lea (oldharr $v_data) atemp0)
      (move.l oldhsize db)    
      (getint db)
      (move.l ($ 0) acc)
      (dbfloop.l db
        (move.l atemp0@+ da)
        (if# (ne nilreg da)
          (if# (ne (sub.l ($ $undefined) da))
            (add.l ($ 1) acc))))
      (move.l acc da)                   ; add 1/4
      (lsr.l ($ 2) da)
      (add.l da acc)
      (add.l ($ 2) acc)                 ; avoid boundary case
      (mkint acc)
      (move.l htab atemp0)
      (jsr #'%%init-htab)
      (move.l '0 index)
      (until# (eq  index oldhsize)
       (move.l index acc)
       (vscale.l acc)
       (move.l (oldharr acc.l $v_data) acc)
       (if# (ne acc nilreg)
         (if# (ne (sub.l ($ $undefined) acc))
           (add.l ($ $undefined) acc)
           (move.l acc atemp0)
           (vpush atemp0)
           (sympname atemp0 atemp0)
           (vsize atemp0 da)
           (move.l htab acc)
           (jsr #'%%GetSym)
           (car htab atemp0)
           (vpop (atemp0 dy.l $v_data))
           (cdr htab atemp0)
           (add.l '1 (HCOUNT atemp0))))
       (add.l '1 index))
      (move.l htab acc))
    (rts)))
#|
(defun ktest (string length)
  (let (deey deeb)
    (lap-inline ()
      (:variable string length deey deeb)
      (move.l (varg string) atemp0)
      (move.l (varg length) da)
      (getint da)
      (jsr #'%%ktrans-da-dbdy)
      (mkint dy)
      (move.l dy (varg deey))
      (mkint db)
      (move.l db (varg deeb)))
    (values deey deeb)))
|#

; atemp0 = string, da = length
; returns dy = initial probe offset, db = secondary probe
; both dy & db will be a multiple of 4
; da & atemp0 preserved.
(xdefun %%ktrans-da-dbdy (&lap string)
  (lap
    (movem.l #(atemp0 da) -@sp)
    (moveq ($ 0) dy)
    (if# (eq (vsubtypep ($ $v_xstr) atemp0 db)) 
      (add ($ $v_data) atemp0)
      (asr.l ($ 1) da)  ; the length is in bytes - we want words
      (moveq ($ 0) db)
      (bra @dbfw)
@loopw
      (ror.l da dy)
      (spush dy)
      (move.w atemp0@+ db)
      (if# (gtu (cmp.w ($ #xff) db))
        (add.w db @sp)
        else# ; if high byte is 0 do as for skinny strings
        (add.b db @sp))
      (spop dy)
@dbfw
      (dbf da @loopw)
      (bra @done))
    (add ($ $v_data) atemp0)
    (moveq ($ 0) db)
    (bra @dbf)    
@loop
    (ror.l da dy)
    (spush dy)
    (move.b atemp0@+ db)
    (add.b db @sp)
    (spop dy)
@dbf
    (dbf da @loop)
@done
    (move.l dy da)
    (move.l da db)
    (swap db)
    (eor.w db da)
    (move.w da db)
    (lsr.w ($ 8) db)
    (eor.w db da)
    (move.w da db)
    (lsr.w ($ 4) db)
    (eor.w db da)
    (moveq ($ #b01110) db)
    (and.l da db)
    (move.l '#.$hprimes atemp0)
    (move.w (atemp0 db $v_data) db)
    (lsr.w ($ 2) dy)
    (lsl.w ($ 2) dy)
    (movem.l sp@+ #(atemp0 da))
    (rts)))

;Atemp0 = string, da = length, acc = package hash-table.
;Returns symbol or UNDEFINED in acc, table offset in dy, Z set if found.
;Atemp0 preserved.
(xdefun %%getsym (&lap 0)
  (lap
    (jsr #'%%ktrans-da-dbdy)
    (jmp #'%%GetHashedSym)))

; atemp0 = string, da = length, acc = package hash-table,
; dy = hash code for string, db = secondary key
; returns symbol or UNDEFINED in acc, table offset in dy, Z set if found.
; atemp0 preserved.
(xdefun %%GetHashedSym (&lap 0)
  (lap
    (movem.l #(dsave0 dsave1 dsave2 dx asave0 asave1 atemp0 da) -@sp)
    (vsubtype atemp0 dx)    
    (add ($ $v_data) atemp0)
    (move.l acc asave0)
    (car asave0 asave0)
    (vsize asave0 dsave0)
    (cmp.b ($ $v_xstr) dx)
    (beq @xstr)
    (move.l dy dx)
    (divul.l dsave0 (dy dx))
    (bra @next)
    (prog#
     (if# (ne (sub.l ($ $undefined) acc))
       (add.l ($ $undefined) acc)
       (move.l acc asave1)
       (sympname asave1 asave1)
       (vector-length-subtype asave1 dsave2 dx)
       (add ($ $v_data) asave1)
       (move.l atemp0 atemp1)
       (move.w da dsave1)
       (if# (eq (cmp.b ($ $v_xstr) dx))
         (asr.w ($ 1) dsave2)
         (moveq ($ 0) dx)
         (cmp.w dsave2 dsave1)         
         (bra @3sx)
  @2sx   (move.b atemp1@+ dx)
	 (cmp.w asave1@+ dx)
  @3sx   (dbne dsave1 @2sx)
         (beq @ret)
         else#         
         (cmp.w dsave2 dsave1)
         (bra @3)
  @2     (cmp.b atemp1@+ asave1@+) 
  @3     (dbne dsave1 @2)
         (beq @ret)))
     (add.l db dy)
     (if# (pl dsave0 dy)
       (sub.l dsave0 dy))
@next
     (move.l (asave0 dy.l $v_data) acc)
     (until# (eq acc nilreg)))
    (moveq ($ $undefined) acc)            ; not found
@ret
    (movem.l sp@+ #(dsave0 dsave1 dsave2 dx asave0 asave1 atemp0 da))
    (rts)


@xstr 
    (asr.w ($ 1) da)
    (move.l dy dx)
    (divul.l dsave0 (dy dx))
    (bra @nextx)
    (prog#
     (if# (ne (sub.l ($ $undefined) acc))
       (add.l ($ $undefined) acc)
       (move.l acc asave1)
       (sympname asave1 asave1)
       (vector-length-subtype asave1 dsave2 dx)       
       (add ($ $v_data) asave1)
       (move.l atemp0 atemp1)
       (move.w da dsave1)
       (if# (eq (cmp.b ($ $v_sstr) dx))
         (moveq ($ 0) dx)
         (cmp.w dsave2 dsave1)
         (bra @3xs)
@2xs     (move.b asave1@+ dx)
         (cmp.w atemp1@+ dx)
@3xs     (dbne dsave1 @2xs)
         (beq @ret)
         else#
         (asr.w ($ 1) dsave2)
         (cmp.w dsave2 dsave1)
         (bra @3x)
@2x      (cmp.w atemp1@+ asave1@+) 
@3x      (dbne dsave1 @2x)
         (beq @ret)))
     (add.l db dy)
     (if# (pl dsave0 dy)
       (sub.l dsave0 dy))
@nextx
     (move.l (asave0 dy.l $v_data) acc)
     (until# (eq acc nilreg)))
    (moveq ($ $undefined) acc)            ; not found
    (bra @ret)
))


   
  
;Atemp0 = string, da = len, acc = package.
;Returns with acc=symbol (or NIL if not found), atemp1=symbol ptr if found
;             da=NIL/-1 (internal)/0 (external)/1 (inherited)
;	      db=offset in internal table
;             dy=offset in external table if not internal.
;             Z flag set as per da=nil

(xdefun %%findsym (&lap 0)
  (lap
    (jsr #'%%ktrans-da-dbdy)            ;DB/DY = hash info, preserves atemp0/da/acc
    (movem.l #(db dy) -@sp)
    (vpush acc)                         ; save package
    (move.l acc atemp1)                 ; move it to atemp1
    (move.l (svref atemp1 pkg.itab) acc)   ; internal table
    (jsr #'%%GetHashedSym)              ;Preserves atemp0/da
    (vpop atemp1)                       ; pop package
    (if# eq
      (move.l dy db)
      (moveq ($ -1) da)
      (bra @found))
    (vpush dy)                          ; save internal table offset
    (move.l (svref atemp1 pkg.etab) acc)   ; get external table
    (movem.l @sp #(db dy))
    (vpush atemp1)
    (jsr #'%%GetHashedSym)              ; Still preserves atemp0/da
    (vpop atemp1)                       ; Still pop package
    (if# eq
      (vpop db)
      (moveq ($ 0) da)
      (bra @found))
    (vpush dy)                          ; Save external table
    (move.l (svref atemp1 pkg.used) atemp1)
    (prog#
     (car atemp1 acc)
     (bif (eq nilreg acc) @notfound)
     (movem.l @sp #(db dy))
     (spush (cdr atemp1))
     (move.l acc atemp1)
     (move.l (svref atemp1 pkg.etab) acc)
     (jsr #'%%GetHashedSym)             ; Clobbers atemp0/da
     (spop atemp1)                      ; (Just kidding)
     (until# eq))
    (vpop dy)
    (vpop db)
    (moveq ($ 1) da)
@found
    (add ($ 8) sp)
    (move.l acc atemp1)
    (if# (eq  (a5 $nilsym) acc)
      (move.l nilreg acc))
    (rts)                               ; ~Z
@notfound
    (vpop dy)
    (vpop db)
    (move.l nilreg acc)
    (move.l nilreg da)
    (add ($ 8) sp)
    (cmp.w da da)                       ; Z
    (rts)))

;acc=pname, db=internal offset, dy=external offset, atemp0=package.
;Returns with symbol in acc.

(xdefun %%AddSym (&lap 0)
  (lap
    (vunscale.l db)
    (vunscale.l dy)
    (movem.l #(atemp0 db dy) -@vsp)
    (jsr_subprim $sp-MakeSym)
    (movem.l vsp@+ #(atemp1 db dy))
    (vscale.l db)
    (vscale.l dy)
    (jmp #'%%InsertSym)))

;Enter with acc=sym ptr (not NIL!), atemp1=package, db/dy as per %%AddSym
(xdefun %%InsertSym (&lap 0)
  (lap
    (move.l acc atemp0)
    (move.l (atemp0 $sym.package-plist) da)
    (btst ($ 0) da)                     ; uvectorp ?
    (if# eq
      (cmp.l nilreg da)
      (if# eq
        (move.l atemp1 (atemp0 $sym.package-plist))
        else#
        (exg atemp1 da)
         (if# (eq (car atemp1) nilreg)
          (rplaca atemp1 da))
         (exg atemp1 da)))
    (if# (eq (special *keyword-package*) atemp1)   ; Use external table
      (move.l (svref atemp1 pkg.etab) atemp1)
      (move.l dy db)
      (jsr #'%%HAdd)
      (move.l acc atemp0)               ; Defconstant keyword to itself.
      (or.b ($ (logior (ash 1 $sym_bit_special) (ash 1 $sym_bit_const))) (atemp0 $sym.vbits))
      (btst ($ $sym_bit_indirect) (atemp0 $sym.vbits))
      (add ($ $sym.gvalue) atemp0)
      (if# ne
        (debug "Indirect vcell!")
        (move.l @atemp0 atemp0))
      (move.l acc @atemp0)
      (rts))
    (move.l (svref atemp1 pkg.itab) atemp1)   ; Use internal table
    (jmp #'%%HAdd)))

;acc=sym ptr (not NIL!), atemp1 = htab, db=offset
(xdefun %%Hadd (&lap 0)
  (lap
    (car atemp1 atemp0)                 ;  Array
    (move.l acc (atemp0 db.l $v_data))
    (cdr atemp1 atemp0)
    (add.l '1 (HCOUNT atemp0))
    (move.l (HCOUNT atemp0) da)
    (cmp.l (HLIMIT atemp0) da)
    (if# geu
      (vpush acc)
      (move.l atemp1 arg_z)
      (jsr #'%%Hresize)
      (vpop acc))
    (rts)))

; Atemp0 = simple string, length in da.  Returns package or nil in acc.
(xdefun %%find-pkg (&lap 0)
  (lap-inline ()
    (with-preserved-registers #(asave0 asave1 dsave0)
      (vsubtype atemp0 db)
      (if# (eq (cmp.b ($ $v_xstr) db))
        (asr.l ($ 1) da))
      (add ($ $v_data) atemp0)
      (move.l atemp0 dy)
      (move.l (special %all-packages%) asave0)

@pkgs (car asave0 acc)
      (bif (eq acc nilreg) @ret)
      (move.l acc asave1)
      (move.l (svref asave1 pkg.names) asave1)
      (while# (ne asave1 nilreg)
        (car asave1 atemp1)
        (vsubtype atemp1 dsave0)
        (getvect atemp1 dx)
        (if# (eq (cmp.b ($ $v_xstr) db))
          (if# (eq (cmp.b ($ $v_xstr) dsave0)) ; atemp0 is words
            (asr.l ($ 1) dx)
            (cmp.l dx da)
            (bra @1xx)
@0xx        (cmp.w atemp0@+ atemp1@+)
@1xx        (dbne dx @0xx)
            (if# eq
              (add.w ($ 1) dx)
              (sub.l ($ 1) dx)
              (bcc @0xx)                      ; CS, CC, or neither ...
              (bcs @ret))
            else#  ; atemp0 is word atemp1 is byte
            (moveq ($ 0) dsave0)
            (cmp.l dx da)
            (bra @1sx)
@0xs        (move.b atemp1@+ dsave0)
            (cmp.w atemp0@+ dsave0)
@1xs        (dbne dx @0xs)
            (if# eq
              (add.w ($ 1) dx)
              (sub.l ($ 1) dx)
              (bcc @0xs)                      ; CS, CC, or neither ...
              (bcs @ret)))
          else#
          (if# (eq (cmp.b ($ $v_xstr) dsave0))
            (moveq ($ 0) dsave0)
            (cmp.l dx da)
            (bra @1sx)
@0sx        (move.b atemp0@+ dsave0)
            (cmp.w atemp1@+ dsave0)
@1sx        (dbne dx @0sx)
            (if# eq
              (add.w ($ 1) dx)
              (sub.l ($ 1) dx)
              (bcc @0sx)                      ; CS, CC, or neither ...
              (bcs @ret))
            else#
            (cmp.l dx da)
            (bra @1)
@0          (cmp.b atemp0@+ atemp1@+)
@1          (dbne dx @0)
            (if# eq
              (add.w ($ 1) dx)
              (sub.l ($ 1) dx)
              (bcc @0)                      ; CS, CC, or neither ...
              (bcs @ret))))
        (move.l dy atemp0)
        (cdr asave1 asave1))
      (cdr asave0 asave0)
      (bra @pkgs)
@ret)))

(xdefun pkg-arg (thing)
  (lap-inline ()
    (:variable thing)
    (if# (eq (ttagp ($ $t_vector) arg_z da))
      (move.l arg_z atemp1)
      (if# (eq (vsubtypep ($ $v_pkg) atemp1 da))
        (if# (eq (svref atemp1 pkg.names) nilreg)
          (ccall error '"~S is a deleted package ." arg_z))
        (bra @ret)))
    (jsr_subprim $sp-SymOrSStr)  ; o.k. 
    (vpush acc)
    (move.l acc atemp0)
    (vsize  atemp0 da)
    (jsr #'%%find-pkg)
    (if# (eq acc nilreg)
      (vpop arg_z)
      (move.l (fixnum $xnopkg) arg_y)
      (set_nargs 2)
      (jsr #'%kernel-restart)
      else#
    (add ($ 4) vsp))
@ret))


#|
	Change History (most recent last):
  2   1/6/95   akh   merge with d13
|# ;(do not edit past this line!!)
