/*

  Non-PEF data loader definitions.

*/

/*
  01/29/97  gb    don't initialize load_error_message, do declare it extern.
  --- 4.0 ---
  05/30/96  gb    logical_section_excised_code.  Compression codes.
  05/12/96  gb    new file.
  --- 3.9 ---
*/


#define logical_section_none 0  /* "marked" flag */
#define logical_section_subprims 1 /* heap-allocated subprims */
#define logical_section_nilreg_area 2 /* The nilreg-relative globals & symbols, loaded by PEF */
#define logical_section_application_code 3 /* The application's readonly section, loaded by PEF */
#define logical_section_application_data 4 /* The heap, as it were. */
#define logical_section_lib_static 5 /* library mutable data section */
#define logical_section_lib_staticlib 6 /* imported library immutable data section */
#define logical_section_lib_code 7 /* imported library code section */
#define logical_section_excised_code 8 /* An afterthought, but it kind of works because there's no library #1 */

typedef struct phys_data_area {
  LispObj start;
  LispObj end;
  union {
    int next;                   /* index of next phys_data_area in logical section */
    int bias;                   /* relocation bias */
  } u;
  unsigned logical_section;     /* logical section ID */
} phys_data_area;

typedef struct lisp_data_header {
  unsigned sig0;                /* signature word: 'pmcl' */
  unsigned sig1;                /* signature word: 'data' */
  unsigned header_version;      /* overall version of this header structure  */
  unsigned flags;               /* so far, unused */
  unsigned numlibs;             /* # of lisp libraries */
  unsigned nphys;               /* # of phys_data_areas */
  unsigned logsize;             /* logical size of data, in bytes */
  unsigned physsize;            /* physical size of data: if /= logsize, data is compressed */
  phys_data_area phys_areas[1]; /* typically more than one */
} lisp_data_header;


OSErr
load_application_data(area *,short, long);

OSErr
save_application_data(short, Boolean);

extern StringPtr 
load_error_message;

#define lisp_load_error 17
#define current_header_version 1
#define header_sig0 'pmcl'
#define header_sig1 'data'

/* Segmented relocation FSM states */
#define relocation_state_header 0 /* header allowed */
#define relocation_state_gvector 1 /* simple node doublewords */
#define relocation_state_hash_vector 2 /* in the midst of a hash table vector */
#define relocation_state_ivector 3 /* not really relocating at all */
#define relocation_state_code_vector 4 /* relocating absolute subprim calls */


/* Compression bytecodes.  Some of these can appear whenever the
   loader is expecting a header or a node; some can only appear
   in one context or another.
*/

#define comp_val  fulltag_nil
#define comp_header_val (comp_val | (1 << ntagbits))
#define comp_mask fulltagmask
#define comp_header_mask (comp_mask | (1 << ntagbits))

#define comp_node(n)  (comp_val | ((n) << (ntagbits+1)))
#define comp_header(n) (comp_header_val | ((n) << (ntagbits+1)))

/* is x a compression bytecode ? */
#define comp_p(x)  (((x) & comp_mask) == comp_val)

/* is x a compressed node bytecode ? */
#define comp_node_p(x) (((x) & comp_header_mask) == comp_val)

/* is x a compressed header bytecode ? */
#define comp_header_p(x) (((x) & comp_header_mask) == comp_header_val)



/* reference to NIL */
#define compressed_nil                       comp_node(0)

/* (untagged) signed byte follows */ 
#define compressed_byte_fixnum               comp_node(1)

 /* 8-bit (doubleword) relative heap reference to misc-tagged object */
#define compressed_byte_relative_misc        comp_node(2)

/* 16-bit (doubleword) relative heap reference to misc-tagged object */
#define compressed_halfword_relative_misc    comp_node(3)

/* reference to #<undefined> */
#define compressed_undefined                 comp_node(4)

/* reference to undefined_function object */
#define compressed_undefined_function        comp_node(5)

/* reference to 0 */
#define compressed_zero                      comp_node(6)

/* reference to cons cell at previous doubleword */
#define compressed_prev_cons                 comp_node(7)

/* reference to cons cell at next doubleword */
#define compressed_next_cons                 comp_node(8)

/* 8-bit (doubleword) relative heap reference to cons cell */
#define compressed_byte_relative_cons        comp_node(9)

/* 16-bit (doubleword) relative heap reference to cons cell */
#define compressed_halfword_relative_cons        comp_node(10)



/* "simple" keyword: no function def or plist.  pname follows */
#define compressed_keyword                   comp_header(0)

/* function: element count fits in 1 byte */
#define compressed_8bit_function             comp_header(1)

/* function: element count fits in 2 bytes */
#define compressed_16bit_function            comp_header(2)

/* simple vector (array t (*)): 1 byte element count */
#define compressed_8bit_simple_vector        comp_header(3)

/* simple vector: 2 byte element count */
#define compressed_16bit_simple_vector       comp_header(4)

/* simple base string: 1 byte element count */
#define compressed_8bit_simple_base_string   comp_header(5)

/* simple base string: 2 byte element count */
#define compressed_16bit_simple_base_string  comp_header(6)

/* double float: 8 bytes of data follow.  Note alignment/padding. */
#define compressed_double_float              comp_header(7)
 
/* "random" miscobj header: subtag, 1 byte element count follow */
#define compressed_8bit_vector               comp_header(8)

/* "random" miscobj header: subtag, 2 byte element count follow */
#define compressed_16bit_vector              comp_header(9)

/* symbol, all cells follow (should also encode unbound/unfbound symbols) */
#define compressed_symbol                    comp_header(10)


typedef struct compressed_node {
  union {
    unsigned char bytes[4];
    LispObj node;
  } u;
} compressed_node;

