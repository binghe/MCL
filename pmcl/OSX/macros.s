/* ifndef __macros__
__macros__ set 1

; 06/10/96 gb    extract_2_lisptags[.]
; ---- 3.9
; 04/08/96 bill  split (new) restore_saveregs out from vpop_saveregs
; 03/07/96 bill  vref16
; 12/07/95 slh   GB fix to extract_unsigned_byte_bits
; 11/29/95 gb    define jump_fname, jump_nfn macros
*/


define([lwi],[ifdef([DARWIN],[
	.if ((($2) & 0xffff8000) == 0xffff8000)
	 li $1,($2)
	.elseif ((($2) & 0xffff8000) == 0)
	 li $1,$2
	.else
	 lis $1,(($2)>>16)
	 .if (($2) & 0xffff) <> 0
	  ori $1,$1,(($2) & 0xffff)
	 .endif
	.endif],[
	.ifeq (($2) & 0xffff8000)-0xffff8000
	 li $1,$2
	.else
	 .ifeq (($2) & 0xffff8000)
	  li $1,$2
	 .else
	  lis $1,($2>>16)
	  .ifne ($2 & 0xffff)
	   ori $1,$1,$2 & 0xffff
	  .endif
	 .endif
	.endif
])])


ifdef([PPC64],[
        define([clrrri],[
        clrrdi $@
        ])       
        define([clrlri],[
        clrldi $@
        ])
        define([clrlri_],[
        clrldi. $@
        ])
        define([ldr],[
        ld $@
        ])
        define([ldrx],[
        ldx $@
        ])
        define([ldru],[
        ldu $@
        ])
        define([str],[
        std $@
        ])
        define([strx],[
        stdx $@
        ])
        define([stru],[
        stdu $@
        ])
        define([strux],[
        stdux $@
        ])	
        define([cmpr],[
        cmpd $@
        ])
        define([cmpri],[
        cmpdi $@
        ])
        define([cmplr],[
        cmpld $@
        ])
        define([cmplri],[
        cmpldi $@
        ])
        define([trlge],[
        tdlge $@
        ])
        define([trllt],[
        tdllt $@
        ])
        define([trlt],[
        tdlt $@
        ])
	define([trlle],[
	tdlle $@
	])
        define([treqi],[
        tdeqi $@
        ])
        define([trnei],[
        tdnei $@
        ])
        define([trgti],[
        tdgti $@
        ])
        define([srari],[
        sradi $@
        ])
        define([srri],[
        srdi $@
        ])
        define([srr],[
        srd $@
        ])
        define([slri],[
        sldi $@
        ])
        define([lrarx],[
        ldarx $@
        ])
        define([strcx],[
        stdcx. $@
        ])
        define([load_highbit],[
        lis $1,0x8000
        sldi $1,$1,32
        ])
        define([extract_bit_shift_count],[
        clrldi $1,$2,64-bitmap_shift
        ])
        define([alloc_trap],[
        tdlt allocptr,allocbase
        ])
],[
        define([clrrri],[
        clrrwi $@
        ])
        define([clrlri],[
        clrlwi $@
        ])
        define([clrlri_],[
        clrlwi. $@
        ])
        define([ldr],[
        lwz $@
        ])
        define([ldrx],[
        lwzx $@
        ])
        define([ldru],[
        lwzu $@
        ])
        define([str],[
        stw $@
        ])
        define([strx],[
        stwx $@
        ])
        define([stru],[
        stwu $@
        ])
        define([strux],[
        stwux $@
        ])
        define([cmpr],[
        cmpw $@
        ])
        define([cmpri],[
        cmpwi $@
        ])
        define([cmplr],[
        cmplw $@
        ])
        define([cmplri],[
        cmplwi $@
        ])
        define([trlge],[
        twlge $@
        ])
        define([trllt],[
        twllt $@
        ])
        define([trlt],[
        twlt $@
        ])
        define([trlle],[
        twlle $@
        ])       
        define([treqi],[
        tweqi $@
        ])
        define([trnei],[
        twnei $@
        ])
        define([trgti],[
        twgti $@
        ])
        define([srari],[
        srawi $@
        ])
        define([srri],[
        srwi $@
        ])
        define([srr],[
        srw $@
        ])
        define([slri],[
        slwi $@
        ])
        define([lrarx],[
        lwarx $@
        ])
        define([strcx],[
        stwcx. $@
        ])
        define([load_highbit],[
        lis $1,0x8000
        ])
        define([extract_bit_shift_count],[
        clrlwi $1,$2,32-bitmap_shift
        ])
        define([alloc_trap],[
        twllt allocptr,allocbase
        ])
])

/*
        dnode_align(dest,src,delta)
*/
        define([dnode_align],[
        la $1,($3+(dnode_size-1))($2)
        clrrri($1,$1,dnode_align_bits)
])

define([extract_fulltag],[
	clrlri($1,$2,nbits_in_word-ntagbits)
        ])

define([extract_lisptag],[
	clrlri($1,$2,nbits_in_word-nlisptagbits)
        ])

define([extract_lisptag_],[
	clrlri_($1,$2,nbits_in_word-nlisptagbits)
        ])

/*
	macro
	merge_lisptag &dest,&tagged_reg
	rlwimi&dot &dest,&tagged_reg,nlisptagbits,28,29
	endm

	macro
	extract_2_lisptags &dest,&tagged1,&tagged2
	extract_lisptag &dest,&tagged1
	merge_lisptag&dot &dest,&tagged2
	endm
*/

define([extract_subtag],[
	lbz $1,misc_subtag_offset($2)])


define([extract_lowbyte],[
        clrlri($1,$2,nbits_in_word-num_subtag_bits)
        ])

define([extract_header],[
	ldr($1,misc_header_offset($2))])
		
ifdef([PPC64],[
define([extract_typecode],[
	new_macro_labels()
	extract_fulltag($1,$2)
	cmpdi cr0,$1,fulltag_misc
	extract_lisptag($1,$1)
	bne cr0,macro_label(not_misc)
	extract_subtag($1,$2)
macro_label(not_misc):
])],[	
define([extract_typecode],[
	new_macro_labels()
	extract_lisptag($1,$2)
	cmpwi cr0,$1,tag_misc
	bne cr0,macro_label(not_misc)
	extract_subtag($1,$2)
macro_label(not_misc):
])])
	
define([box_fixnum],[
	slri($1,$2,fixnumshift)])

define([unbox_fixnum],[	
	srari($1,$2,fixnumshift)])

define([loaddf],[
	lfd $1,dfloat.value($2)])
	
define([storedf],[
	stfd $1,dfloat.value($2)])


	

define([push],[
	stru($1,-node_size($2))])
	
	/* Generally not a great idea. */
define([pop],[
	ldr($1,0($2))
	la $2,node_size($2)])
	
define([vpush],[
	push($1,vsp)])
	
define([vpop],[
	pop($1,vsp)])
	


/*	
	macro
	tpush &src
	push &src,tsp
	endm
*/
	
define([unlink],[
	ldr($1,0($1))
 ])

	
define([set_nargs],[
	lwi(nargs,($1)<<fixnumshift)])
	
define([bitclr],[
	rlwinm $1,$2,0,0x1f&((31-($3))+1),0x1f&((31-($3))-1)])
	

define([vref32],[
	lwz $1,misc_data_offset+(($3)<<2)($2)])
        
define([vref16],[/* dest,src,n*/
	lhz $1,misc_data_offset+(($3)<<1)($2)])

define([vrefr],[
        vref32($1,$2,$3)])
	
define([getvheader],[
	ldr($1,vector.header($2))])
	
	/* Size is unboxed element count */
define([header_size],[
	srri($1,$2,num_subtag_bits)])
	
	/* "Length" is fixnum element count */
define([header_length],[
ifdef([PPC64],[
        rldicr $1,$2,nbits_in_word-(num_subtag_bits-nfixnumtagbits),63-nfixnumtagbits
        clrldi $1,$1,(num_subtag_bits-nfixnumtagbits)
        ],[               
	rlwinm $1,$2,nbits_in_word-(num_subtag_bits-nfixnumtagbits),(num_subtag_bits-nfixnumtagbits),31-nfixnumtagbits
        ])
]) 

define([vector_size],[
	getvheader(ifelse($3.[],$1,$3),$2)
	header_size($1,ifelse($3.[],$1,$3))])
	
define([vector_length],[
	getvheader($3,$2)
	header_length($1,$3)])

	
define([ref_global],[
	ldr($1,lisp_globals.$2(rnil))      /* rnil  was 0 */
])

define([set_global],[
	str($1,lisp_globals.$2(rnil))
])

define([ref_nrs_value],[
	ldr($1,((nrs.$2)+(symbol.vcell))(rnil))  /* was r0 with constant offset in struct def */
])
	
define([set_nrs_value],[
	str($1,((nrs.$2)+(symbol.vcell))(rnil))
])

define([extract_unsigned_byte_bits],[
ifdef([PPC64],[
        rldicr $1,$2,64-fixnumshift,63-$3
],[                
        rlwinm $1,$2,0,32-fixnumshift,31-($3+fixnumshift)
])        
])

define([extract_unsigned_byte_bits_],[
ifdef([PPC64],[
        rldicr. $1,$2,64-fixnumshift,63-$3
],[                
        rlwinm. $1,$2,0,32-fixnumshift,31-($3+fixnumshift)
])        
])

	
	/* vpop argregs - nargs is known to be non-zero */
define([vpop_argregs_nz],[
	new_macro_labels()
	cmplri(cr1,nargs,node_size*2)
	vpop(arg_z)
	blt cr1,macro_label(l0)
	vpop(arg_y)
	bne cr1,macro_label(l0)
	vpop(arg_x)
macro_label(l0):])

                
	/* vpush argregs */
define([vpush_argregs],[
	new_macro_labels()
	cmplri(cr0,nargs,0)
	cmplri(cr1,nargs,node_size*2)
	beq cr0,macro_label(done)
	blt cr1,macro_label(z)
	beq cr1,macro_label(yz)
	vpush(arg_x)
macro_label(yz):
	vpush(arg_y)
macro_label(z):
	vpush(arg_z)
macro_label(done):
])

/* new stuff re lisp_frame? */

define([create_lisp_frame],[
	stru(sp,-lisp_frame.size(sp))
])

                
define([build_lisp_frame],[
	create_lisp_frame()
	str(ifelse($1,[],fn,$1),lisp_frame.savefn(sp))
	str(ifelse($2,[],loc_pc,$2),lisp_frame.savelr(sp))
	str(ifelse($3,[],vsp,$3),lisp_frame.savevsp(sp))
])

        	
define([discard_lisp_frame],[
	la sp,lisp_frame.size(sp)])
	
define([_car],[
	ldr($1,cons.car($2))
])
	
define([_cdr],[
	ldr($1,cons.cdr($2))])
	
define([_rplaca],[
	str($2,cons.car($1))])
	
define([_rplacd],[
	str($2,cons.cdr($1))])
		


define([vpush_saveregs],[
	vpush(save7)
	vpush(save6)
	vpush(save5)
	vpush(save4)
	vpush(save3)
	vpush(save2)
	vpush(save1)
	vpush(save0)])
	
define([restore_saveregs],[
	ldr(save0,node_size*0($1))
	ldr(save1,node_size*1($1))
	ldr(save2,node_size*2($1))
	ldr(save3,node_size*3($1))
	ldr(save4,node_size*4($1))
	ldr(save5,node_size*5($1))
	ldr(save6,node_size*6($1))
	ldr(save7,node_size*7($1))
])

define([vpop_saveregs],[
	restore_saveregs(vsp)
	la vsp,node_size*8(vsp)
])

define([leaf_trap_unless_fixnum],[
        new_macro_labels()
        extract_lisptag($2,$1)
        cmpwi $2,tag_fixnum
        beq macro_label(ok)
        mflr loc_pc
        build_lisp_frame()
        bl _SPxuuo_interr
        uuo_interr(error_object_not_fixnum,$1)
macro_label(ok):        
])                

define([leaf_trap_unless_list],[
        new_macro_labels()
        extract_lisptag($2,$1)
        cmpwi $2,tag_list
        beq macro_label(ok)
        mflr loc_pc
        build_lisp_frame()
        bl _SPxuuo_interr
        uuo_interr(error_object_not_list,$1)
macro_label(ok):        
])                

define([leaf_trap_unless_cons],[
        new_macro_labels()
        extract_fulltag($2,$1)
        cmpwi $2,fulltag_cons
        beq macro_label(ok)
        mflr loc_pc
        build_lisp_frame()
        bl _SPxuuo_interr
        uuo_interr(error_object_not_cons,$1)
macro_label(ok):        
])                

define([leaf_trap_unless_uvector],[
        new_macro_labels()
        extract_fulltag($2,$1)
        cmpwi $2,fulltag_misc
        beq macro_label(ok)
        mflr loc_pc
        build_lisp_frame()
        bl _SPxuuo_interr
        uuo_interr(error_object_not_uvector,$1)
macro_label(ok):        
])                
                                
        

define([trap_unless_fulltag_equal],[
	extract_fulltag($3,$1)
	trnei($3,$2)
])
	
define([trap_unless_typecode_equal],[
        extract_typecode($3,$1)
        trnei($3,$2)
])
	
/*
	macro
	spentry &name
	export .SP&name
	csect &name{pr}
	function .SP&name
.SP&name:
	endm
*/

/* "jump" to the code-vector of the function in nfn. */
define([jump_nfn],[
	ldr(temp0,_function.codevector(nfn))
        la loc_pc,misc_data_offset(temp0)
	mtctr loc_pc
	bctr
])

/* "call the code-vector of the function in nfn. */
define([call_nfn],[
	ldr(temp0,_function.codevector(nfn))
        la loc_pc,misc_data_offset(temp0)
	mtctr loc_pc
	bctrl
])

/* "jump" to the function in fnames function cell. */
define([jump_fname],[
	ldr(nfn,symbol.fcell(fname))
	jump_nfn()
])

/* call the function in fnames function cell. */
define([call_fname],[
	ldr(nfn,symbol.fcell(fname))
	call_nfn()
])

define([do_funcall],[
	new_macro_labels()
	extract_lisptag(imm0,temp0)
	cmpri(imm0,tag_misc)
	mr nfn,temp0
	bne macro_label(bad)
	extract_subtag(imm0,temp0)
	cmpri(imm0,subtag_function)
	cmpri(cr1,imm0,subtag_symbol)
        bne cr0,macro_label(_sym)
        jump_nfn()
macro_label(_sym):             
	mr fname,temp0
	bne cr1,macro_label(bad)
	jump_fname()
macro_label(bad):
        mr arg_z,temp0
        li arg_y,XNOTFUN       /* Still not fun */
        set_nargs(2)
        b _SPksignalerr
])

define([Set_TSP_Frame_Unboxed],[
	str(tsp,tsp_frame.type(tsp))
])

define([Set_TSP_Frame_Boxed],[
	str(rzero,tsp_frame.type(tsp))
])
		
/*
  A newly allocated TSP frame is always "raw" (has non-zero type, indicating
  that it doesn't contain tagged data.
*/
define([TSP_Alloc_Fixed_Unboxed],[
	stru(tsp,-($1+tsp_frame.data_offset)(tsp))
	Set_TSP_Frame_Unboxed()
])

define([TSP_Alloc_Fixed_Unboxed_Zeroed],[
	TSP_Alloc_Fixed_Unboxed($1)
	zero_doublewords tsp,tsp_frame.fixed_overhead,$1
])

define([TSP_Alloc_Fixed_Boxed],[
	TSP_Alloc_Fixed_Unboxed_Zeroed($1)
	Set_TSP_Frame_Boxed()
])

	
/*
  This assumes that the backpointer points  to the first byte beyond
  each frame.  If we allow segmented tstacks, that constraint might
  complicate  their implementation.
  We don't need to know the size of the frame (positive or negative,
  with or without header).  $1 and $2 are temp registers, $3 is an
  optional CR field.
*/

/* Handle the general case, where the frame might be empty */
define([Zero_TSP_Frame],[
	new_macro_labels()
	mr $1,tsp
	ldr($2,tsp_frame.backlink(tsp))
	la $2,-8($2)
	b macro_label(zero_tsp_test)
macro_label(zero_tsp_loop):
	stfdu fp_zero,8($1)
macro_label(zero_tsp_test):	
	cmpr(ifelse($3,[],[cr0],$3),$1,$2)
	bne ifelse($3,[],[cr0],$3),macro_label(zero_tsp_loop)
])

/* Save some branching when we know that the frame can't be empty.*/
define([Zero_TSP_Frame_nz],[
	new_macro_labels()
	mr $1,tsp
	ldr($2,tsp_frame.backlink(tsp))
	la $2,-8($2)
macro_label(zero_tsp_loop):
	stfdu fp_zero,8($1)
	cmpr(ifelse($3,[],[cr0],$3),$1,$2)
	bne ifelse($3,[],[cr0],$3),macro_label(zero_tsp_loop)
])
	
/* $1 = 8-byte-aligned size, positive.  $2 (optiional) set
   to negated size. */
define([TSP_Alloc_Var_Unboxed],[
	neg ifelse($2,[],$1,$2),$1
	strux(tsp,tsp,ifelse($2,[],$1,$2))
	Set_TSP_Frame_Unboxed()
])

define([TSP_Alloc_Var_Boxed],[
	TSP_Alloc_Var_Unboxed($1)
	Zero_TSP_Frame($1,$2)
	Set_TSP_Frame_Boxed()
])		


define([TSP_Alloc_Var_Boxed_nz],[
	TSP_Alloc_Var_Unboxed($1)
	Zero_TSP_Frame_nz($1,$2)
	Set_TSP_Frame_Boxed()
])

define([clear_alloc_tag],[
	clrrri(allocptr,allocptr,ntagbits)
])


/*
  This is probably only used once or twice in the entire kernel, but
  I wanted a place to describe the constraints on the mechanism.

  Those constaints are (not surprisingly) similar to those which apply
  to cons cells, except for the fact that the header (and any length
  field that might describe large arrays) has to have been stored in
  the object if the trap has succeeded on entry to the GC.  It follows
  that storing the register containing the header must immediately
  follow the allocation trap (and an auxiliary length register must
  be stored immediately after the header.)  Successfully falling
  through the trap must emulate any header initialization: it would
  be a bad idea to have allocptr pointing to a zero header ...
*/

/*
  Parameters:	

  $1 = dest reg
  $2 = header.  (For now, assume that this always encodes length ;
	that may change with "large vector" support.)
  $3 = register containing size in bytes.  (We're going to subtract 
	fulltag_misc from this; do it in the macro body, rather than force the		(1 ?) caller to do it.
*/

define([Misc_Alloc],[
	la $3,-fulltag_misc($3)
	sub allocptr,allocptr,$3
        alloc_trap()
	str($2,misc_header_offset(allocptr))
	mr $1,allocptr
	clear_alloc_tag()
])

/*
  Parameters $1, $2 as above; $3 = physical size constant.
*/
define([Misc_Alloc_Fixed],[
	la allocptr,(-$3)+fulltag_misc(allocptr)
        alloc_trap()
	str($2,misc_header_offset(allocptr))
	mr $1,allocptr
	clear_alloc_tag()
])

/* freeptr has been advanced, extra register contains lisp_global(HEAP_LIMIT) */
define([leaf_do_xalloc],[
        new_macro_labels()
        cmplw cr6,freeptr,extra
        ble cr6,macro_label(no_xalloc)
        mflr loc_pc
        build_lisp_frame()
        bl _SPfinish_alloc
        lwz loc_pc,lisp_frame.savelr(sp)
        la sp,lisp_frame.size(sp)
        mtlr loc_pc
macro_label(no_xalloc): 
])
        
            
/* freeptr has been advanced, extra register contains lisp_global(HEAP_LIMIT) */
define([early_leaf_do_xalloc],[
        new_macro_labels()
        cmplw cr6,freeptr,extra
        ble cr6,macro_label(no_xalloc)
        build_lisp_frame()
        mflr loc_pc
        build_lisp_frame()
        bl _SPfinish_alloc
        lwz loc_pc,lisp_frame.savelr(sp)
        la sp,lisp_frame.size(sp)
        mtlr loc_pc
        lwz loc_pc,lisp_frame.savelr(sp)
        la sp,lisp_frame.size(sp)
macro_label(no_xalloc):
])

define([ALIGN],[($1+($2-1))&~($2-1)])
define([STACK_ALIGN],[ALIGN($1,16)])        