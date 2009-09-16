/* ifndef __constants__
__constants__ set 1
; 05/15/02 akh make  c_reg_save.size multiple of 16 bytes, c_frame ditto - altivec g4 wierdness - do elsewhere
; 02/14/97 gb   fp_s32conv & room for it in c_reg_save record.
; 02/13/97 bill nrs_global's cs_segment_size, vs_segment_size,
;               ts_segment_size, cs_hard_overflow_size,
;               cs_soft_overflow_size, cs_overflow_callback
; ------------  4.0
;  8/28/96 slh  nrs_global current_cursor
; 06/14/96 bill nrs_global new_gcable_ptr
; 06/10/96 gb   builtin function indices; fp_zero.
;;; --- 3.9 release ---
; 04/09/96 gb   nrs_global excised_code
; 04/08/96 bill exception_saved_registers
; 03/28/96 gb   missing ds.l's in nrs.globals
; 03/18/96 gb   area record
; 03/06/96 bill vectorH record, vectorH_header
; 03/01/96 bill resolve-slep-address nilreg-relative symbol
; 03/10/96  gb  subtag_creole, new globals
; 02/28/96 bill subtag_illegal & illegal_marker
; 01/25/96  gb  add lexpr_return, lexpr_return1v globals.
; 12/27/95  gb  no pad word in ratio; add *total-gc-microseconds*,
;               *total-bytes-freed*.
; 12/13/95  gb  %builtin-functions nrs
; 11/29/95  gb  add %init-misc nrs
; 11/07/95 bill add heap_start & heap_end to lisp_globals
; 10/25/95  gb  add %macro-code% nrs
; 10/23/95  gb  more nilreg-relative globals; fix subtag_character.
; 09/12/95  gb  add %closure-code% nrs
*/

/*  in openmcl constants32.s */
nbits_in_word = 32
nbits_in_byte = 8
ntagbits = 3	/* But only 2 are significant to lisp */
nlisptagbits = 2
nfixnumtagbits = 2
num_subtag_bits = 8
fixnumshift = 2
fixnum_shift = 2
fulltagmask = 7
tagmask = 3
fixnummask = 3
ncharcodebits = 16
charcode_shift = nbits_in_word-ncharcodebits
word_shift = 2
node_size = 4   /* this and below from openmcl constants32.s */
dnode_size = 8
dnode_align_bits = 3
dnode_shift = dnode_align_bits
bitmap_shift = 5

fixnumone = (1<<fixnumshift)
fixnum_one = fixnumone
fixnum1 = fixnumone


/* Tags. */
/* There are two-bit tags and three-bit tags. */
/* A FULLTAG is the value of the low three bits of a tagged object. */
/* A TAG is the value of the low two bits of a tagged object. */
/* A TYPECODE is either a TAG or the value of a "tag-misc" objects header-byte. */

/* There are 4 primary TAG values.  Any object which lisp can "see" can be classified  */
/* by its TAG.  (Some headers have FULLTAGS that are congruent modulo 4 with the */
/* TAGS of other objects, but lisp can't "see" headers.) */


tag_fixnum = 0	/* All fixnums, whether odd or even */
tag_list = 1	/* Conses and NIL */
tag_misc = 2	/* Heap-consed objects other than lists: vectors, symbols, functions, floats ... */
tag_imm = 3	/* Immediate-objects: characters, UNBOUND, other markers. */

/*
  And there are 8 FULLTAG values.  Note that NIL has its own FULLTAG (congruent mod 4 to tag-list),
  that FULLTAG-MISC is > 4 (so that code-vector entry-points can be branched to, since the low
  two bits of the PC are ignored) and that both FULLTAG-MISC and FULLTAG-IMM have header fulltags
  that share the same TAG.
  Things that walk memory (and the stack) have to be careful to look at the FULLTAG of each
  object that they see.
*/

fulltag_even_fixnum = 0	/* I suppose EVENP/ODDP might care; nothing else does. */
fulltag_cons = 1	/* a real (non_null) cons.  Shares TAG with fulltag_nil. */
fulltag_nodeheader = 2	/* Header of heap_allocated object that contains lisp_object pointers */
fulltag_imm = 3		/* a "real" immediate object.  Shares TAG with fulltag_immheader. */
fulltag_odd_fixnum = 4	/*  */
fulltag_nil = 5		/* NIL and nothing but.  (Note that there]s still a hidden NILSYM.) */
fulltag_misc = 6	/* Pointer "real" tag_misc object.  Shares TAG with fulltag_nodeheader. */
fulltag_immheader = 7	/* Header of heap-allocated object that contains unboxed data. */

nil_value = 0x00002015
misc_bias = fulltag_misc
cons_bias = tag_list  



/* Register usage: */

define([rzero],[r0])	
define([sp],[r1])

define([rnil],[r2])   /* ??	equ rtoc */
define([rtoc],[r2])

define([imm0],[r3])
define([imm1],[r4])
define([imm2],[r5])
define([imm3],[r6])
define([imm4],[r7])
define([nargs],[r8])
define([freeptr],[r9])  /* openMCL allocptr */
define([allocptr],[r9])
define([initptr],[r10]) /* openMCL allocbase */
define([allocbase],[r10])

define([extra],[r11])
define([tsp],[r12])	/* temp-consing stack.*/
define([vsp],[r13])
define([loc_g],[r14])	/* node locative */
define([loc_pc],[r15])	/* code vector locative */
define([fn],[r16])
define([temp3],[r17])
define([temp2],[r18])
define([temp1],[r19])
define([temp0],[r20])
define([arg_x],[r21])
define([arg_y],[r22])
define([arg_z],[r23])
define([save7],[r24])
define([save6],[r25])
define([save5],[r26])
define([save4],[r27])
define([save3],[r28])
define([save2],[r29])
define([save1],[r30])
define([save0],[r31])


define([fname],[temp3])
define([nfn],[temp2])
define([next_method_context],[temp1])
define([closure_data],[temp0])
define([first_nvr],[save7])
define([nargregs],[3])

r0 = 0
r1 = 1
r2 = 2
r3 = 3
r4 = 4
r5 = 5
r6 = 6
r7 = 7
r8 = 8
r9 = 9
r10 = 10
r11 = 11
r12 = 12
r13 = 13
r14 = 14
r15 = 15
r16 = 16
r17 = 17
r18 = 18
r19 = 19
r20 = 20
r21 = 21
r22 = 22
r23 = 23
r24 = 24
r25 = 25
r26 = 26
r27 = 27
r28 = 28
r29 = 29
r30 = 30
r31 = 31

/* Lisp code keeps 0.0 in fp_zero */
define([fp_zero],[f31])   /* a non-volatile reg as far as FFI is concerned. */
define([fp_s32conv],[f30])   /* for s32->fp conversion */


/* Functions are of (conceptually) unlimited size. */
	_struct(_function,-misc_bias)
	 _node(header)
	 _node(codevector)
	_ends


/* Order of CAR and CDR doesn]t seem to matter much - there aren]t */
/* too many tricks to be played with predecrement/preincrement addressing. */
/* Keep them in the confusing MCL 3.0 order, to avoid confusion. */
	_struct(cons,-cons_bias)
	 _node(cdr)
	 _node(car)
	_ends

	
misc_header_offset = -fulltag_misc
misc_subtag_offset = misc_header_offset+3		/* low byte of header */
misc_data_offset = misc_header_offset+4		/* first word of data */
misc_dfloat_offset = misc_header_offset+8		/* double-floats are doubleword-aligned */

max_64_bit_constant_index = ((0x7fff + misc_dfloat_offset)>>3)
max_32_bit_constant_index = ((0x7fff + misc_data_offset)>>2)
max_16_bit_constant_index = ((0x7fff + misc_data_offset)>>1)
max_8_bit_constant_index = (0x7fff + misc_data_offset)
max_1_bit_constant_index = ((0x7fff + misc_data_offset)<<5)

/* T is almost adjacent to NIL: since NIL is a misaligned CONS, it spans */
/* two doublewords.  The arithmetic difference between T and NIL is */
/* such that the least-significant bit and exactly one other bit is */
/* set in the result. */

t_offset = (8+(8-fulltag_nil)+fulltag_misc)
t_value = nil_value+t_offset

/* The order in which various header values are defined is significant in several ways: */
/* 1) Numeric subtags precede non-numeric ones; there are further orderings among numeric subtags. */
/* 2) All subtags which denote CL arrays are preceded by those that don]t, */
/*    with a further ordering which requires that (< header-arrayH header-vectorH ,@all-other-CL-vector-types) */
/* 3) The element-size of ivectors is determined by the ordering of ivector subtags. */
/* 4) All subtags are >= fulltag-immheader . */

define([define_subtag],[
subtag_$1 = $2|($3<<ntagbits)])
	
define([define_imm_subtag],[
	define_subtag($1,fulltag_immheader,$2)])

	
define([define_node_subtag],[
	define_subtag($1,fulltag_nodeheader,$2)])

	
/*Immediate subtags. */
	define_subtag(character,fulltag_imm,9)
	define_subtag(unbound,fulltag_imm,6)
        define_subtag(illegal,fulltag_imm,10)
	define_subtag(go_tag,fulltag_imm,12)
	define_subtag(block_tag,fulltag_imm,24)
	define_subtag(vsp_protect,fulltag_imm,7)
        define_subtag(no_thread_local_binding,fulltag_imm,30)
unbound_marker = subtag_unbound
undefined = unbound_marker
illegal_marker = subtag_illegal
no_thread_local_binding_marker = subtag_no_thread_local_binding
	
/*Numeric subtags. */

	define_imm_subtag(bignum,0)
min_numeric_subtag = subtag_bignum

	define_node_subtag(ratio,1)
max_rational_subtag = subtag_ratio

	define_imm_subtag(single_float,1)
	define_imm_subtag(double_float,2)
min_float_subtag = subtag_single_float
max_float_subtag = subtag_double_float
max_real_subtag = subtag_double_float

	define_node_subtag(complex,3)
max_numeric_subtag = subtag_complex

/* CL array types.  There are more immediate types than node types; all CL array subtags must be > than 
 all non-CL-array subtags.  So we start by defining the immediate subtags in decreasing order, starting 
 with that subtag whose element size isn]t an integral number of bits and ending with those whose 
 element size - like all non-CL-array fulltag-immheader types - is 32 bits. */

	define_imm_subtag(bit_vector,31)
	define_imm_subtag(double_float_vector,30)
	define_imm_subtag(s16_vector,29)
	define_imm_subtag(u16_vector,28)
	define_imm_subtag(simple_general_string,27)
min_16_bit_ivector_subtag = subtag_simple_general_string
max_16_bit_ivector_subtag = subtag_s16_vector
max_string_subtag = subtag_simple_general_string


	define_imm_subtag(simple_base_string,26)
	define_imm_subtag(s8_vector,25)
	define_imm_subtag(u8_vector,24)
min_8_bit_ivector_subtag = subtag_u8_vector
max_8_bit_ivector_subtag = subtag_simple_base_string
min_string_subtag = subtag_simple_base_string

	define_imm_subtag(s32_vector,23)
	define_imm_subtag(u32_vector,22)
	define_imm_subtag(single_float_vector,21)
max_32_bit_ivector_subtag = subtag_s32_vector
min_cl_ivector_subtag = subtag_single_float_vector

	define_node_subtag(vectorH,21)
	define_node_subtag(arrayH,20)
	define_node_subtag(simple_vector,22)
min_vector_subtag = subtag_vectorH
min_array_subtag = subtag_arrayH


/* So, we get the remaining subtags (n: (n > max-numeric-subtag) & (n < min-array-subtag)) */
/* for various immediate/node object types. */

	define_imm_subtag(macptr,3)
min_non_numeric_imm_subtag = subtag_macptr

	define_imm_subtag(dead_macptr,4)
	define_imm_subtag(code_vector,5)
	define_imm_subtag(creole,6)


max_non_array_imm_subtag = (19<<ntagbits)|fulltag_immheader

	define_node_subtag(catch_frame,4)
	define_node_subtag(function,5)
	define_node_subtag(sgbuf,6)
	define_node_subtag(symbol,7)
	define_node_subtag(lock,8)
	define_node_subtag(hash_vector,9)
	define_node_subtag(pool,10)
	define_node_subtag(weak,11)
	define_node_subtag(package,12)
	define_node_subtag(slot_vector,13)
	define_node_subtag(instance,14)
	define_node_subtag(struct,15)
	define_node_subtag(istruct,16)
	define_node_subtag(value_cell,17)
        define_node_subtag(xfunction,18)
        define_node_subtag(svar,19)
max_non_array_node_subtag = (19<<ntagbits)|fulltag_immheader
	
/* The objects themselves look something like this: */
	_structf(ratio)
	 _node(numer)
	 _node(denom)
	_endstructf

	_structf(single_float)
	 _word(value)
	_endstructf

	_structf(double_float)
	 _word(pad)
	 _dword(value)
	_endstructf

	_structf(one_digit_bignum)
	 _word(value)
	_endstructf

	_structf(two_digit_bignum)
	 _word(value)
	 _word(valuehi)
	 _word(pad)
	_endstructf
/*	 
c_frame	record 0
backlink ds.l 1
crsave	ds.l 1
savelr	ds.l 1
unused	ds.l 2
savetoc	ds.l 1
params	ds.l 8
slopslop  ds.l 2
minsiz	equ *
	endr
*/


	_struct(c_frame,0)	/* PowerOpen ABI C stack frame */
	 _node(backlink)
	 _node(crsave)
	 _node(savelr)
	 _field(unused,8)
	 _node(savetoc)
	 _struct_label(params)
         _node(param0)
         _node(param1)
         _node(param2)
         _node(param3)
         _node(param4)
         _node(param5)
         _node(param6)
         _node(param7)
	_field(slopslop,8)   /* openMCL lacks this */
	 _struct_label(minsiz)
	_ends


	_struct(lisp_frame,0)
	 _node(backlink) 
	 _node(savefn)	
	 _node(savelr)	
	 _node(savevsp)	
	_ends


	_struct(vector,-fulltag_misc)
	 _node(header)
	 _struct_label(data)
	_ends


	_structf(symbol)
	 _node(pname)
	 _node(vcell)
	 _node(fcell)
	 _node(package_plist)
	 _node(flags)
	_endstructf

	_structf(catch_frame)
	 _node(catch_tag)	/* #<unbound> -> unwind-protect, else catch */
	 _node(link)		/* backpointer to previous catch frame */
	 _node(mvflag)		/* 0 if single-valued catch, fixnum 1 otherwise */
	 _node(csp)		/* pointer to lisp_frame on csp */
	 _node(db_link)		/* head of special-binding chain */
	 _field(regs,8*node_size)	/* save7-save0 */
	 _node(xframe)		/* exception frame chain */
	 _node(tsp_segment)	/* maybe someday; padding for now */
	_endstructf
/*
macptr record -fulltag_misc
header	ds.l 1
origin equ *
address	ds.l 1
size	equ *+fulltag_misc
element_count equ (*-origin)/4
	endr
*/
	_structf(macptr)   /* this aint same as openmcl */
	/* _node(header) */
         _node(address)
	_endstructf

	_structf(vectorH)
	 _node(logsize)
	 _node(physsize)
	 _node(data_vector)
	 _node(displacement)
	 _node(flags)
	_endstructf	

/*
;; Nilreg-relative globals.  Talking the assembler into doing something reasonable here
;; is surprisingly hard.
*/

/* symbol_extra set symbol.size-fulltag_misc ???? */

lisp_globals_limit = 0x2010   /* huh ?? */

num_lisp_globals = 48		 /* MUST UPDATE THIS !!! */
	
	_struct(lisp_globals,lisp_globals_limit-(num_lisp_globals*node_size))


	_ends
/* (- (+ fulltag-nil (* (1+ pos) 4))) */

lisp_globals.catch_top = -9		/* last open catch frame  */
lisp_globals.db_link = -13		/* top of special-binding stack */
lisp_globals.save_freeptr = -17		/* freeptr when not running lisp */
lisp_globals.kernel_imports = -21	/* some things we need imported for us */
lisp_globals.xframe = -25		/* this thread's exception frame chain */
lisp_globals.emulator_registers = -29	/* where the 68K emulator stores the  emulated regs */
lisp_globals.appmain = -33		/* probably don't really need this */
lisp_globals.subprims_base = -37	/* address of dynamic subprims jump table */
lisp_globals.ret1val_addr = -41		/* address of "dynamic" subprims magic values return addr */
lisp_globals.save_vsp = -45		/* current thread's vsp */
lisp_globals.save_tsp = -49		/* current thread's tsp */
lisp_globals.xalloc = -53		/* pseudo_xalloc kernel callback */
lisp_globals.go_tag_counter = -57	/* counter for (immediate) go tag */
lisp_globals.block_tag_counter = -61	/* counter for (immediate) block tag */
lisp_globals.os_trap_base = -65
lisp_globals.tb_trap_base = -69
lisp_globals.os_trap_call = -73
lisp_globals.tb_trap_call = -77
lisp_globals.subprims_end = -81  	/* end of subprims */
lisp_globals.fwdnum = -85          	/* fixnum: GC "forwarder" call count. */
lisp_globals.gc_num = -89        	/* fixnum: GC call count. */
lisp_globals.gcable_pointers = -93      /* linked-list of weak macptrs. */
lisp_globals.heap_start = -97    	/* start of lisp heap */
lisp_globals.heap_end = -101		/* end of lisp heap */
lisp_globals.current_cs = -105		/* current control-stack area */
lisp_globals.current_vs = -109		/* current value-stack area */
lisp_globals.current_ts = -113		/* current temp-stack area */
lisp_globals.cs_overflow_limit = -117	/* limit for control-stack overflow check */
lisp_globals.all_areas = -121		/* doubly-linked list of all memory areas */
lisp_globals.lexpr_return = -125	/* magic &lexpr return code. */
lisp_globals.lexpr_return1v = -129	/* simpler when &lexpr called for single value. */
lisp_globals.in_gc = -133		/* non-zero when GC active */
lisp_globals.metering_info = -137	/* address of lisp_metering global */
lisp_globals.doh_head = -141		/* creole objects header */
lisp_globals.short_float_zero = -145	/* low half of 1.0d0 */
lisp_globals.double_float_one = -149	/* high half of 1.0d0 */
lisp_globals.ffi_exception = -153	/* fpscr FEX bit on return from ff-call */
lisp_globals.exception_saved_registers = -157 /* saved registers from exception frame */ 
lisp_globals.oldest_ephemeral = -161	/* dword address of oldest ephemeral object or 0 */
lisp_globals.tenured_area = -165	/* the tenured_area */
lisp_globals.native_kernel_version = -169  /* native kernel version number, or 0 */
lisp_globals.refbits = -173
lisp_globals.heap_limit = -177
lisp_globals.j_extend_heap = -181
lisp_globals.oldspace_dnode_count = -185
lisp_globals.ts_overflow_limit = -189
lisp_globals.vs_overflow_limit = -193                
                




symbol_extra = symbol.size-fulltag_misc
	
	_struct(nrs,-fulltag_nil)
	 _struct_pad(fulltag_nil)
	 _field(nilptr,16-fulltag_nil)

	 _struct_pad(fulltag_misc)
	 _struct_label(tsym)
	 _struct_pad(symbol_extra)	/* t  */

	 _struct_pad(fulltag_misc)
	 _struct_label(nilsym)
	 _struct_pad(symbol_extra)	/* nil  */

	 _struct_pad(fulltag_misc)
	 _struct_label(errdisp)
	 _struct_pad(symbol_extra)	/* %err-disp  */

	 _struct_pad(fulltag_misc)
	 _struct_label(cmain)
	 _struct_pad(symbol_extra)	/* cmain  */

	 _struct_pad(fulltag_misc)
	 _struct_label(eval)
	 _struct_pad(symbol_extra)	/* eval  */
 
	 _struct_pad(fulltag_misc)
	 _struct_label(appevalfn)
	 _struct_pad(symbol_extra)	/* apply-evaluated-function  */

	 _struct_pad(fulltag_misc)
	 _struct_label(error)
	 _struct_pad(symbol_extra)	/* error  */

	 _struct_pad(fulltag_misc)
	 _struct_label(defun)
	 _struct_pad(symbol_extra)	/* %defun  */

	 _struct_pad(fulltag_misc)
	 _struct_label(defvar)
	 _struct_pad(symbol_extra)	/* %defvar  */

	 _struct_pad(fulltag_misc)
	 _struct_label(defconstant)
	 _struct_pad(symbol_extra)	/* %defconstant  */

	 _struct_pad(fulltag_misc)
	 _struct_label(macrosym)
	 _struct_pad(symbol_extra)	/* %macro  */

	 _struct_pad(fulltag_misc)
	 _struct_label(kernelrestart)
	 _struct_pad(symbol_extra)	/* %kernel-restart  */

	 _struct_pad(fulltag_misc)
	 _struct_label(package)
	 _struct_pad(symbol_extra)	/* *package*  */

	 _struct_pad(fulltag_misc)
	 _struct_label(interrupt_level) /* *interrupt-level* */
	 _struct_pad(symbol_extra)
		

 	 _struct_pad(fulltag_misc)
	 _struct_label(kallowotherkeys)
	 _struct_pad(symbol_extra)	/* allow-other-keys  */

	 _struct_pad(fulltag_misc)
	 _struct_label(toplcatch)
	 _struct_pad(symbol_extra)	/* %toplevel-catch%  */

	 _struct_pad(fulltag_misc)
	 _struct_label(toplfunc)
	 _struct_pad(symbol_extra)	/* %toplevel-function%  */

	 _struct_pad(fulltag_misc)
	 _struct_label(callbacks)
	 _struct_pad(symbol_extra)	/* %pascal-functions%  */

	 _struct_pad(fulltag_misc)
	 _struct_label(allmeteredfuns)
	 _struct_pad(symbol_extra)	/* *all-metered-functions*  */

	 _struct_pad(fulltag_misc)
	_struct_label(dynvfp)
	_struct_pad(symbol_extra)	/* *%dynvfp%* */

	_struct_pad(fulltag_misc)
	_struct_label(dynvlimit)
	_struct_pad(symbol_extra)	/* *%dynvlimit%* */


	_struct_pad(fulltag_misc)
	_struct_label(udf)
	_struct_pad(symbol_extra)	/* %unbound-function%  */
	
	_struct_pad(fulltag_misc)
	_struct_label(foreground)
	_struct_pad(symbol_extra)	/* *foreground*  */

	_struct_pad(fulltag_misc)
	_struct_label(background_ticks)
	_struct_pad(symbol_extra)	/* *background-sleep-ticks* */

	_struct_pad(fulltag_misc)
	_struct_label(foreground_ticks)
	_struct_pad(symbol_extra)	/* *forekground-sleep-ticks* */

	_struct_pad(fulltag_misc)
	_struct_label(window_update_wptr)
	_struct_pad(symbol_extra)	/* *window-update-wptr* */ 

       	 _struct_pad(fulltag_misc)
	 _struct_label(gc_event_status_bits)
	 _struct_pad(symbol_extra)	/* *gc-event-status-bits*  */

         _struct_pad(fulltag_misc)
	 _struct_label(pre_gc_hook)
	 _struct_pad(symbol_extra)	/* *pre-gc-hook*  */

	 _struct_pad(fulltag_misc)
	 _struct_label(post_gc_hook)
	 _struct_pad(symbol_extra)	/* *post-gc-hook*  */

	 _struct_pad(fulltag_misc)
	 _struct_label(handlers)
	 _struct_pad(symbol_extra)	/* %handlers%  */

	_struct_pad(fulltag_misc)
	_struct_label(parse_string)
	_struct_pad(symbol_extra)	/* %parse-string%  */

	 _struct_pad(fulltag_misc)
	 _struct_label(all_packages)
	 _struct_pad(symbol_extra)	/* %all-packages%  */

	 _struct_pad(fulltag_misc)
	 _struct_label(keyword_package)
	 _struct_pad(symbol_extra)	/* *keyword-package*  */

	_struct_pad(fulltag_misc)
	_struct_label(saved_method_var)
	_struct_pad(symbol_extra)	/* %saved-method-var%  */

	 _struct_pad(fulltag_misc)
	 _struct_label(finalization_alist)
	 _struct_pad(symbol_extra)	/* %finalization-alist%  */

	_struct_pad(fulltag_misc)
	_struct_label(current_stack_group)
	 _struct_pad(symbol_extra)	/* *current-stack-group* */

	_struct_pad(fulltag_misc)
	 _struct_label(closure_code)
	_struct_pad(symbol_extra)	/* %closure-code% */

	_struct_pad(fulltag_misc)
	 _struct_label(macro_code)
	_struct_pad(symbol_extra)	/* %macro-code% */

	_struct_pad(fulltag_misc)
	 _struct_label(init_misc)
	_struct_pad(symbol_extra)	/* %init-misc */

	_struct_pad(fulltag_misc)
	_struct_label(builtin_functions)	/* %builtin-functions% */
	_struct_pad(symbol_extra)

	_struct_pad(fulltag_misc)
	_struct_label(total_gc_microseconds)	/* *total-gc-microseconds* */
	_struct_pad(symbol_extra)

	_struct_pad(fulltag_misc) 
	_struct_label(total_bytes_freed)	/* *total-bytes-freed*  */
	_struct_pad(symbol_extra)

	_struct_pad(fulltag_misc)
	 _struct_label(resolve_slep_address)	/* resolve-slep-address  */
	_struct_pad(symbol_extra)

	_struct_pad(fulltag_misc)
	_struct_label(excised_code)		/* %excised-code% */
	_struct_pad(symbol_extra)

       	 _struct_pad(fulltag_misc)
	 _struct_label(new_gcable_ptr) /* %new-gcable-ptr */
	 _struct_pad(symbol_extra)

	_struct_pad(fulltag_misc)
	_struct_label(current_cursor)		/* *current-cursor* */
	_struct_pad(symbol_extra)


	_struct_pad(fulltag_misc)
	_struct_label(cs_segment_size)		/* *cs-segment-size* */
	_struct_pad(symbol_extra)

	_struct_pad(fulltag_misc)
	_struct_label(vs_segment_size)		/* *vs-segment-size* */
	_struct_pad(fulltag_misc)

	_struct_pad(fulltag_misc)
	_struct_label(ts_segment_size)		/*  *ts-segment-size* */
	_struct_pad(symbol_extra)

	_struct_pad(fulltag_misc)
	_struct_label(cs_hard_overflow_size)		/* *cs-hard-overflow-size* */
	_struct_pad(symbol_extra)

	_struct_pad(fulltag_misc)
	_struct_label(cs_soft_overflow_size)	/* *cs-soft-overflow-size* */
	_struct_pad(symbol_extra)

	_struct_pad(fulltag_misc)
	_struct_label(cs_overflow_callback)
	_struct_pad(symbol_extra)

	_struct_pad(fulltag_misc)
	_struct_label(gc_cursor)     /* *gc-cursor*  */
	_struct_pad(symbol_extra)


define([def_header],[
$1 = ($2<<num_subtag_bits)|$3])

	def_header(single_float_header,single_float.element_count,subtag_single_float)
	def_header(double_float_header,double_float.element_count,subtag_double_float)
	def_header(one_digit_bignum_header,1,subtag_bignum)
	def_header(two_digit_bignum_header,2,subtag_bignum)
	def_header(three_digit_bignum_header,3,subtag_bignum)
	def_header(symbol_header,symbol.element_count,subtag_symbol)
	def_header(value_cell_header,1,subtag_value_cell	)
	def_header(macptr_header,macptr.element_count,subtag_macptr)
	def_header(vectorH_header,vectorH.element_count,subtag_vectorH)

	include(errors.s)

/* Symbol bits that we care about */
sym_vbit_bound = (0+fixnum_shift)
sym_vbit_bound_mask = (1<<sym_vbit_bound)
sym_vbit_const = (1+fixnum_shift)
sym_vbit_const_mask = (1<<sym_vbit_const)

	_struct(area,0)
	 _node(pred) 
	 _node(succ) 
	 _node(low) 
	 _node(high) 
	 _node(active) 
	 _node(softlimit) 
	 _node(hardlimit) 
	 _node(code) 
	 _node(markbits) 
	 _node(ndwords) 
	 _node(older) 
	 _node(younger) 
	 _node(h) 
	 _node(sofprot) 
	 _node(hardprot) 
	 _node(owner) 
	 _node(refbits) 
	 _node(nextref) 
	_ends


/* This is only referenced by c->lisp code that needs to save/restore C NVRs in a TSP frame. */
	_struct(c_reg_save,0)
	 _node(tsp_link)	/* backpointer */
	 _node(tsp_mark)	/* frame type */
	 _node(save_fpscr)	/* for Cs FPSCR */
	 _field(save_gprs,19*4) /* r13-r31 */
	 _dword(save_fp_zero)	/* for fp_zero */
	 _dword(save_fp_s32conv)
	_field(slop,2*4)        /* align */
	_ends


/* Indices in %builtin-functions% */
_builtin_plus = 0	/* +-2 */
_builtin_minus = 1	/* --2 */
_builtin_times = 2	/* *-2 */
_builtin_div = 3	/* /-2 */
_builtin_eq = 4		/* =-2 */
_builtin_ne = 5		/* /-2 */
_builtin_gt = 6		/* >-2 */
_builtin_ge = 7		/* >=-2 */
_builtin_lt = 8		/* <-2 */
_builtin_le = 9		/* <=-2 */
_builtin_eql = 10	/* eql */
_builtin_length = 11	/* length */
_builtin_seqtype = 12	/* sequence-type */
_builtin_assq = 13	/* assq */
_builtin_memq = 14	/* memq */
_builtin_logbitp = 15	/* logbitp */
_builtin_logior = 16	/* logior-2 */
_builtin_logand = 17	/* logand-2 */
_builtin_ash = 18	/* ash */
_builtin_negate = 19	/* %negate */
_builtin_logxor = 20	/* logxor-2 */
_builtin_aref1 = 21	/* %aref1 */
_builtin_aset1 = 22	/* %aset1 */

	/* FPSCR status bits */
fpscr_FX = 0
fpscr_FEX = 1
fpscr_VX = 2
fpscr_OX = 3
fpscr_UX = 4
fpscr_ZX = 5
fpscr_XX = 6
	/* FPSCR control bits */
fpscr_VE = 24
fpscr_OE = 25
fpscr_UE = 26
fpscr_ZE = 27
fpscr_XE = 28

/* registers, as used in destrucuring-bind/macro-bind */

define([whole_reg],[temp1])
define([arg_reg],[temp3])
define([keyvect_reg],[temp2])
define([mask_req_start],[24])
define([mask_req_width],[8])
define([mask_opt_start],[16])
define([mask_opt_width],[8])
define([mask_key_start],[8])
define([mask_key_width],[8])
define([mask_initopt],[7])
define([mask_keyp],[6]) /*  note that keyp can be true even when 0 keys. */
define([mask_aok],[5])
define([mask_restp],[4])


        _struct(MachineInformationPowerPC,0)
         _node(CTR.hi)
         _node(CTR.lo)
         _node(LR.hi)
         _node(LR.lo)
         _node(PC.hi)
         _node(PC.lo)
         _node(CR)
         _node(XER)
         _node(MSR)
         _node(MQ)
         _node(ExceptKind)
         _node(DSISR)
         _node(DAR.hi)
         _node(DAR.lo)
         _node(Reserved.hi)
         _node(Reserved.lo)
        _ends

        _struct(RegisterInformationPowerPC,0)
         _node(R0.hi)
         _node(R0.lo)
         _node(R1.hi)
         _node(R1.lo)
         _node(R2.hi)
         _node(R2.lo)
         _node(R3.hi)
         _node(R3.lo)
         _node(R4.hi)
         _node(R4.lo)
         _node(R5.hi)
         _node(R5.lo)
         _node(R6.hi)
         _node(R6.lo)
         _node(R7.hi)
         _node(R7.lo)
         _node(R8.hi)
         _node(R8.lo)
         _node(R9.hi)
         _node(R9.lo)
         _node(R10.hi)
         _node(R10.lo)
         _node(R11.hi)
         _node(R11.lo)
         _node(R12.hi)
         _node(R12.lo)
         _node(R13.hi)
         _node(R13.lo)
         _node(R14.hi)
         _node(R14.lo)
         _node(R15.hi)
         _node(R15.lo)
         _node(R16.hi)
         _node(R16.lo)
         _node(R17.hi)
         _node(R17.lo)
         _node(R18.hi)
         _node(R18.lo)
         _node(R19.hi)
         _node(R19.lo)
         _node(R20.hi)
         _node(R20.lo)
         _node(R21.hi)
         _node(R21.lo)
         _node(R22.hi)
         _node(R22.lo)
         _node(R23.hi)
         _node(R23.lo)
         _node(R24.hi)
         _node(R24.lo)
         _node(R25.hi)
         _node(R25.lo)
         _node(R26.hi)
         _node(R26.lo)
         _node(R27.hi)
         _node(R27.lo)
         _node(R28.hi)
         _node(R28.lo)
         _node(R29.hi)
         _node(R29.lo)
         _node(R30.hi)
         _node(R30.lo)
         _node(R31.hi)
         _node(R31.lo)
        _ends

        _struct(FPUInformationPowerPC,0)
         _field(Registers,256)
         _node(FPSCR)
         _node(Reserved)
        _ends

        _struct(VectorInformationPowerPC,0)
         _field(Registers,512)
         _field(VSCR,16)
         _node(VRsave)
        _ends

        _struct(ExceptionInformationPowerPC,0)
         _node(theKind)
         _node(MachineState)
         _node(registerImage)
         _node(FPUImage)
         _node(info)
         _node(vectorImage)
        _ends