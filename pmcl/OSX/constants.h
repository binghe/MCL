#ifndef __constants__
#define __constants__ 1

/*  Modification History

$Log: constants.h,v $
Revision 1.4  2003/12/08 05:09:34  gtbyers
Change unused subtag_sgbuf to subtag_slot_vector (neither is
referenced in kernel ...).


02/25/97 bill  gc_redraw_window_frames_bit, gc_allow-stack-overflows_bit
01/29/96 gb    rename "errors.h" -> "lisp-errors.h" (to allow easier inclusion of <errors.h>
               from {cincludes}).
--- 4.0 ---
07/30/96 gb    define subtag_character.
07/20/96 gb    ExceptionInformation -> ExceptionInformationPowerPC
07/10/96 gb    heap_segment_size, log2_heap_segment_size now constants
06/10/96 gb    lisp double_float
05/12/96 gb    move BA_MASK, BA_VAL here.
--- 3.9 ---
03/10/96 gb    creole
02/20/96 gb    lfun_bit constants.
02/27/96 bill  define the gc_xxx bits in the GC_EVENT_STATUS_BITS nrs
02/26/96 bill  population_weak_list, population_weak_alist, population_termination_bit
01/25/96 gb    GC needs to know what catch_frames look like.
12/27/95 gb    no pad word in ratio.
12/22/95 gb    xmacptr; macptr.ptr -> macptr.address
12/13/95 gb    hashtable-vector header & bits
11/20/95 bill  macptr & special_binding struct definitions

*/

#define nbits_in_word 32
#define nbits_in_byte 8
#define ntagbits 3	/* But only 2 are significant to lisp */
#define nlisptagbits 2
#define nfixnumtagbits 2
#define num_subtag_bits 8
#define fixnumshift 2
#define fixnum_shift 2
#define fulltagmask 7
#define tagmask	 3
#define fixnummask 3
#define subtagmask ((1<<num_subtag_bits)-1)
#define ncharcodebits 16
#define charcode_shift (nbits_in_word-ncharcodebits)

/*  Tags. */
/*  There are two-bit tags and three-bit tags. */
/*  A FULLTAG is the value of the low three bits of a tagged object. */
/*  A TAG is the value of the low two bits of a tagged object. */
/*  A TYPECODE is either a TAG or the value of a "tag-misc" object's header-byte. */

/*  There are 4 primary TAG values.  Any object which lisp can "see" can be classified  */
/*  by its TAG.  (Some headers have FULLTAGS that are congruent modulo 4 with the */
/*  TAGS of other objects, but lisp can't "see" headers.) */


#define tag_fixnum 0	/*  All fixnums, whether odd or even */
#define tag_list 1	/*  Conses and NIL */
#define tag_misc 2	/*  Heap-consed objects other than lists: vectors, symbols, functions, floats ... */
#define tag_imm	 3	/*  Immediate-objects: characters, UNBOUND, other markers. */

/*  And there are 8 FULLTAG values.  Note that NIL has its own FULLTAG (congruent mod 4 to tag-list), */
/*  that FULLTAG-MISC is > 4 (so that code-vector entry-points can be branched to, since the low */
/*  two bits of the PC are ignored) and that both FULLTAG-MISC and FULLTAG-IMM have header fulltags */
/*  that share the same TAG. */
/*  Things that walk memory (and the stack) have to be careful to look at the FULLTAG of each */
/*  object that they see. */

#define fulltag_even_fixnum 0	/*  I suppose EVENP/ODDP might care; nothing else does. */
#define fulltag_cons	 1	/*  a real (non_null) cons.  Shares TAG with fulltag_nil. */
#define fulltag_nodeheader 2	/*  Header of heap_allocated object that contains lisp_object pointers */
#define fulltag_imm	 3	/*  a "real" immediate object.  Shares TAG with fulltag_immheader. */
#define fulltag_odd_fixnum 4	/*   */
#define fulltag_nil	 5	/*  NIL and nothing but.  (Note that there's still a hidden NILSYM.) */
#define fulltag_misc	 6	/*  Pointer "real" tag_misc object.  Shares TAG with fulltag_nodeheader. */
#define fulltag_immheader 7	/*  Header of heap-allocated object that contains unboxed data. */

/*  Register usage: */
#define rzero 0
#define sp 1
#define rnil 2
#define imm0 3
#define imm1 4
#define imm2 5
#define imm3 6
#define imm4 7
#define nargs 8
#define freeptr 9
#define initptr 10
#define extra 11
#define tsp 12
#define vsp 13
#define loc_g 14		/*  node locative */
#define loc_pc 15		/*  code vector locative */
#define fn 16
#define temp3 17
#define temp2 18
#define temp1 19
#define temp0 20	
#define arg_x 21
#define arg_y 22
#define arg_z 23
#define save7 24
#define save6 25
#define save5 26
#define save4 27
#define save3 28
#define save2 29
#define save1 30
#define save0 31

#define vfp save0	/*  frame pointer if needed (stack consing). */
#define fname temp3
#define nfn temp2
#define next_method_context temp1
#define closure_data temp0

typedef unsigned LispObj;
typedef unsigned unsigned_of_pointer_size;

/*  Order of CAR and CDR doesn't seem to matter much - there aren't */
/*  too many tricks to be played with predecrement/preincrement addressing. */
/*  Keep them in the confusing MCL 3.0 order, to avoid confusion. */

typedef struct cons {
  LispObj cdr;
  LispObj car;
} cons;


#define misc_header_offset -fulltag_misc
#define misc_subtag_offset misc_header_offset+3		/*  low byte of header */
#define misc_data_offset misc_header_offset+4		/*  first word of data */
#define misc_dfloat_offset misc_header_offset+8		/*  double-floats are doubleword-aligned */

#define max_64_bit_constant_index ((0x7fff + misc_dfloat_offset)>>3)
#define max_32_bit_constant_index ((0x7fff + misc_data_offset)>>2)
#define max_16_bit_constant_index ((0x7fff + misc_data_offset)>>1)
#define max_8_bit_constant_index (0x7fff + misc_data_offset)
#define max_1_bit_constant_index ((0x7fff + misc_data_offset)<<5)

/*  T is almost adjacent to NIL: since NIL is a misaligned CONS, it spans */
/*  two doublewords.  The arithmetic difference between T and NIL is */
/*  such that the least-significant bit and exactly one other bit is */
/*  set in the result. */

#define t_offset (8+(8-fulltag_nil)+fulltag_misc)

/*  The order in which various header values are defined is significant in several ways: */
/*  1) Numeric subtags precede non-numeric ones; there are further orderings among numeric subtags. */
/*  2) All subtags which denote CL arrays are preceded by those that don't, */
/*     with a further ordering which requires that (< header-arrayH header-vectorH ,@all-other-CL-vector-types) */
/*  3) The element-size of ivectors is determined by the ordering of ivector subtags. */
/*  4) All subtags are >= fulltag-immheader . */

#define SUBTAG(tag,subtag) ((tag) | ((subtag) << ntagbits))
#define IMM_SUBTAG(subtag) SUBTAG(fulltag_immheader,(subtag))
#define NODE_SUBTAG(subtag) SUBTAG(fulltag_nodeheader,(subtag))

	
/* Numeric subtags. */

#define subtag_bignum IMM_SUBTAG(0)
#define min_numeric_subtag subtag_bignum

#define subtag_ratio NODE_SUBTAG(1)
#define max_rational_subtag subtag_ratio

#define subtag_single_float IMM_SUBTAG(1)
#define subtag_double_float IMM_SUBTAG(2)
#define min_float_subtag subtag_single_float
#define max_float_subtag subtag_double_float
#define max_real_subtag subtag_double_float

#define subtag_complex NODE_SUBTAG(3)
#define max_numeric_subtag subtag_complex


/*  CL array types.  There are more immediate types than node types; all CL array subtags must be > than */
/*  all non-CL-array subtags.  So we start by defining the immediate subtags in decreasing order, starting */
/*  with that subtag whose element size isn't an integral number of bits and ending with those whose */
/*  element size - like all non-CL-array fulltag-immheader types - is 32 bits. */

#define subtag_bit_vector IMM_SUBTAG(31)
#define subtag_double_float_vector IMM_SUBTAG(30)
#define subtag_s16_vector IMM_SUBTAG(29)
#define subtag_u16_vector IMM_SUBTAG(28)
#define subtag_simple_general_string IMM_SUBTAG(27)
#define min_16_bit_ivector_subtag subtag_simple_general_string
#define max_16_bit_ivector_subtag subtag_s16_vector
#define max_string_subtag subtag_simple_general_string

#define subtag_simple_base_string IMM_SUBTAG(26)
#define subtag_s8_vector IMM_SUBTAG(25)
#define subtag_u8_vector IMM_SUBTAG(24)
#define min_8_bit_ivector_subtag subtag_u8_vector
#define max_8_bit_ivector_subtag subtag_simple_base_string
#define min_string_subtag subtag_simple_base_string

#define subtag_s32_vector IMM_SUBTAG(23)
#define subtag_u32_vector IMM_SUBTAG(22)
#define subtag_single_float_vector IMM_SUBTAG(21)
#define max_32_bit_ivector_subtag subtag_s32_vector
#define min_cl_ivector_subtag subtag_single_float_vector


#define subtag_vectorH NODE_SUBTAG(21)
#define subtag_arrayH NODE_SUBTAG(20)
#define subtag_simple_vector NODE_SUBTAG(22)	/*  Only one such subtag) */
#define min_vector_subtag subtag_vectorH
#define min_array_subtag subtag_arrayH

/*  So, we get the remaining subtags (n: (n > max-numeric-subtag) & (n < min-array-subtag)) */
/*  for various immediate/node object types. */

#define subtag_macptr IMM_SUBTAG(3)
#define min_non_numeric_imm_subtag subtag_macptr

#define subtag_dead_macptr IMM_SUBTAG(4)
#define subtag_code_vector IMM_SUBTAG(5)
#define subtag_creole IMM_SUBTAG(6)

#define max_non_array_imm_subtag ((19<<ntagbits)|fulltag_immheader)

#define subtag_catch_frame NODE_SUBTAG(4)
#define subtag_function NODE_SUBTAG(5)
#define subtag_slot_vector NODE_SUBTAG(6)
#define subtag_symbol NODE_SUBTAG(7)
#define subtag_lock NODE_SUBTAG(8)
#define subtag_hash_vector NODE_SUBTAG(9)
#define subtag_pool NODE_SUBTAG(10)
#define subtag_weak NODE_SUBTAG(11)
#define subtag_package NODE_SUBTAG(12)
#define subtag_mark NODE_SUBTAG(13)
#define subtag_instance NODE_SUBTAG(14)
#define subtag_struct NODE_SUBTAG(15)
#define subtag_istruct NODE_SUBTAG(16)
#define max_non_array_node_subtag ((19<<ntagbits)|fulltag_immheader)
	
/*  The objects themselves look something like this: */

typedef struct lispsymbol {
  LispObj header;
  LispObj pname;
  LispObj vcell;
  LispObj fcell;
  LispObj package_plist;
  LispObj flags;
} lispsymbol;

typedef struct ratio {
  LispObj header;
  LispObj numer;
  LispObj denom;
} ratio;

typedef struct double_float {
  LispObj header;
  LispObj pad;
  LispObj value_high;
  LispObj value_low;
} double_float;

typedef struct single_float {
  LispObj header;
  LispObj value;
} single_float;

typedef struct macptr {
  LispObj header;
  LispObj address;
} macptr;

typedef struct xmacptr {
  LispObj header;
  LispObj address;
  LispObj flags;
  LispObj link;
} xmacptr;
  

typedef struct c_frame {
  struct c_frame *backlink;
  unsigned crsave;
  unsigned savelr;
  unsigned unused[2];
  unsigned savetoc;
  unsigned params[8];
} c_frame;

typedef struct lisp_frame {
  struct lisp_frame *backlink;
  LispObj savefn;
  LispObj savelr;
  LispObj savevsp;
} lisp_frame;

typedef struct special_binding {
  struct special_binding *link;
  struct lispsymbol *sym;
  LispObj value;
} special_binding;

/* The GC (at least) needs to know what a
   package looks like, so that it can do GCTWA. */
typedef struct package {
  LispObj header;
  LispObj itab;			/* itab and etab look like (vector (fixnum . fixnum) */
  LispObj etab;
  LispObj used;
  LispObj used_by;
  LispObj names;
  LispObj shadowed;
} package;

/*
  The GC also needs to know what a catch_frame looks like.
*/

typedef struct catch_frame {
  LispObj header;
  LispObj catch_tag;
  LispObj link;
  LispObj mvflag;
  LispObj csp;
  LispObj db_link;
  LispObj regs[8];
  LispObj xframe;
  LispObj tsp_segment;
} catch_frame;

#define catch_frame_element_count ((sizeof(catch_frame)/sizeof(LispObj))-1)
#define catch_frame_header make_header(subtag_catch_frame,catch_frame_element_count)

#define unbound SUBTAG(fulltag_imm, 6)
#define undefined unbound
#define subtag_character SUBTAG(fulltag_imm, 9)

/* 
  All exception frames in a thread are linked together 
  */
typedef struct xframe_list {
  ExceptionInformationPowerPC *this;
  struct xframe_list *prev;
} xframe_list;

#define fixnum_bitmask(n)  (1<<((n)+fixnumshift))

/* 
  The GC (at least) needs to know about hash-table-vectors and their flag bits.
*/

typedef struct hash_table_vector_header {
  LispObj header;
  LispObj link;                 /* If weak */
  LispObj flags;                /* a fixnum; see below */
  LispObj free_alist;           /* preallocated conses for finalization_alist */
  LispObj finalization_alist;   /* key/value alist for finalization */
  LispObj weak_deletions_count; /* incremented when GC deletes weak pair */
  LispObj hash;                 /* backpointer to hash-table */
  LispObj deleted_count;        /* number of deleted entries */
  LispObj cache_idx;            /* index of last cached pair */
  LispObj cache_key;            /* value of last cached key */
  LispObj cache_value;          /* last cached value */
} hash_table_vector_header;

/*
  Bits (masks)  in hash_table_vector.flags:
*/

/* GC should track keys when addresses change */ 
#define nhash_track_keys_mask fixnum_bitmask(28) 

/* GC should set when nhash_track_keys_bit & addresses change */
#define nhash_key_moved_mask  fixnum_bitmask(27) 

/* weak on key or value (need new "weak both" encoding.) */
#define nhash_weak_mask       fixnum_bitmask(12)

/* weak on value */
#define nhash_weak_value_mask fixnum_bitmask(11)

/* finalizable */
#define nhash_finalizable_mask fixnum_bitmask(10)


/* Lfun bits */

#define lfbits_nonnullenv_mask fixnum_bitmask(0)
#define lfbits_keys_mask fixnum_bitmask(1)
#define lfbits_restv_mask fixnum_bitmask(7)
#define lfbits_optinit_mask fixnum_bitmask(14)
#define lfbits_rest_mask fixnum_bitmask(15)
#define lfbits_aok_mask fixnum_bitmask(16)
#define lfbits_lap_mask fixnum_bitmask(23)
#define lfbits_trampoline_mask fixnum_bitmask(24)
#define lfbits_evaluated_mask fixnum_bitmask(25)
#define lfbits_cm_mask fixnum_bitmask(26)         /* combined_method */
#define lfbits_nextmeth_mask fixnum_bitmask(26)   /* or call_next_method with method_mask */
#define lfbits_gfn_mask fixnum_bitmask(27)        /* generic_function */
#define lfbits_nextmeth_with_args_mask fixnum_bitmask(27)   /* or call_next_method_with_args with method_mask */
#define lfbits_method_mask fixnum_bitmask(28)     /* method function */
/* PPC only but want it defined for xcompile */
#define lfbits_noname_mask fixnum_bitmask(29)

/*
  known values of an "extended" (gcable) macptr's flags word:
*/

typedef enum {
  xmacptr_flag_none = 0,        /* Maybe already disposed by Lisp */
  xmacptr_flag_handle,          /* DisposeHandle, careful with GrowZone */
  xmacptr_flag_ptr,             /* DisposePtr */
  xmacptr_flag_window,          /* DisposeWindow */
  xmacptr_flag_gworld           /* DisposeGworld */
} xmacptr_flag;

/* Creole */

#define doh_quantum 400
#define doh_block_slots ((doh_quantum >> 2) - 3)

typedef struct doh_block {
  struct doh_block *link;
  unsigned size;
  unsigned free;
  LispObj data[doh_block_slots];
} doh_block, *doh_block_ptr;


#define population_weak_list (0<<fixnum_shift)
#define population_weak_alist (1<<fixnum_shift)
#define population_termination_bit (16+fixnum_shift)
#define population_type_mask ((1<<population_termination_bit)-1)

#define gc_suspend_or_resume_event fixnum_bitmask(0)
#define gc_update_bit fixnum_bitmask(1)
#define gc_integrity_check_bit fixnum_bitmask(2)
#define gc_polling_allowed fixnum_bitmask(3)
#define gc_redraw_window_frames_bit fixnum_bitmask(4)
#define gc_allow_stack_overflows_bit fixnum_bitmask(5)
#define gc_post_egc_hook fixnum_bitmask(22)
#define gc_terminate_macptrs fixnum_bitmask(23)
#define gc_poll_in_foreground fixnum_bitmask(24)
#define gc_pregc_pending fixnum_bitmask(25)
#define gc_postgc_pending fixnum_bitmask(26)
#define gc_use_gc_cursor fixnum_bitmask(27)
#define gc_polling_enabled fixnum_bitmask(28)

#include "lisp-errors.h"

#define BA_MASK ((unsigned) ((-1<<26) | (1<<1)))
#define BA_VAL  ((unsigned) ((18<<26) | (1<<1)))


/* 
  These were previously global variables.  There are lots of implicit
  assumptions about the size of a heap segment, so they might as well
  be constants.
*/

/*
#define heap_segment_size 0x00008000
#define log2_heap_segment_size 15
*/


#define heap_segment_size 0x00010000
#define log2_heap_segment_size 16

#define node_size 4
#define node_shift 2

#define dnode_size (node_size*2)
#define dnode_shift node_shift+1



#endif

