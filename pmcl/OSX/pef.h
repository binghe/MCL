#ifdef PMCL_OSX_NATIVE_KERNEL
#include <Carbon/Carbon.h>
#else
#include <Types.h>              /* for Boolean */
#endif

#include "area.h"

/*
  01/29/97  gb  define PEF_export_symbol_size - gcc botches sizeof(mac_aligned_struct)
  --- 4.0 ---
  07/26/96  gb  define kWeakLib & kInitBefore.
  07/20/96  gb  kWeakImport; logical_import_container.flags.
  06/13/96  gb  declare error-checing I/O functions
  05/12/96  gb  cfrg ('cfrg' resource) structure.
  --- 3.9 ---
  04/08/96  gb  logical_import_container.versions 
  03/17/96  gb  logical_import_container.version
  02/20/96  gb  fix pi_data; multi-seg lib stuff.
  01/31/96  gb  pi_data stuff.
*/

/*
  PEF might mean "PowerPC Executable Format".  Or it might
  mean "Preferred [over XCOFF] Executable Format".

  Apple hasn't made the PEF spec public, but they're
  pretty much committed to it.  Its primary advantages
  over XCOFF as an executable format include:

  A) a scheme for run-length encoding data; depending
  on the data, this can reduce disk image size.  There
  are memory-related tradeoffs, however; unpacking a
  large data segment takes memory on the order of
  packed_size+unpacked_size (I don't -think- that it
  unpacks "on the fly" from a disk buffer; 68K MCL
  did so, but large images took a long time to launch.)

  B) a more compact representation of (data-to-code, data-to
  data) relocation information.  Apple's XCOFF linker doesn't
  even bother to strip code-to-code (PC-relative!) relocation
  records from an executable file, but PEF's encoding scheme
  is much more compact anyway.

*/

/*
  A PEF container (typically a resource or file slice)
  contains a PEF_header, followed by a some number of
  PEF_section_header structures, followed by a (possibly
  0-length) "global string table", followed by some
  amount of data for each section.
  
  Some headers are "loadable"; others aren't.  Loader
  information (for instance) is considered non-loadable;
  code ("text", in UnixEse) and data are usually loadable.

  Actually, most of the PEF header consists of version
  number information.  Presumably, some data & code follows.
*/

typedef struct PEF_header {
  unsigned magic;               /* A file starting with these 4 bytes -couldn't be anything else */
  unsigned containerID;         /* peff */
  unsigned arch;                /* Architecture stamp.  CFM-68K uses PEF as well. */
  unsigned version;             /* PEF version, not file version */
  unsigned timestamp;           /* In Mac time format */
  unsigned olddefversion;       /* Version number */
  unsigned oldimpversion;       /* Another version number; see below */
  unsigned curversion;          /* The last of many version numbers */
  unsigned short nsections;     /* Number of section headers which follow */
  unsigned short nloadsections; /* Headers describing loadable sections precede other section headers */
  unsigned memoryaddress;       /* Used in accelerated code resources. */
} PEF_header;

#define sufficiently_advanced 'Joy!' /* Indistinguishable from PEF_header.magic */

typedef struct PEF_section {
  unsigned name;                /* Offset of cstring in global string table, or -1 */
  unsigned addr;                /* Nominal logical address */
  unsigned execsize;            /* Logical size of expanded, zero-padded section data */
  unsigned initsize;            /* Logical size of expanded data, less any zero-padding */
  unsigned rawsize;             /* Size of data in the container */
  unsigned offset;              /* Offset from start of container to data, 0 if no data */
  unsigned char region_kind;    /* see region_kind_xxx below */
  unsigned char sharing_kind;   /* how section is shared with other processes */
  unsigned char alignment;      /* Supposed to be log2 of section alignment; may be ignored by loader ??? */
  unsigned char pad;            /* Undefined; probably -not- ignored by loader.  Just kidding */
} PEF_section;
    
typedef enum {
  section_kind_code = 0,        /* An executable, readonly section */
  section_kind_data,            /* An uncompressed, writable section */
  section_kind_pidata,          /* "pattern-initialized" (RLE) data section */
  section_kind_constant,        /* An uncompressed, readonly section */
  section_kind_loader,          /* A loader section, see below */
  section_kind_debug            /* debug section.  I don't think this is used yet. */
} section_kind;

typedef enum {
  kContextShare = 1,            /* Data instantiated per each processs */
  kGlobalShare = 4              /* Data instantiated globally */
} sharing_kind;


/*
  The loader section starts with a loader header (what else ?), followed
  by a list of "import containers" (libraries & applications) that this
  container imports from, followed by a list of symbols that this container
  imports, followed by a list describing which sections need to be relocated
  relative to the actual load-time address of sections which they reference,
  followed by a compressed representation of those relocations, followed by
  the loader section's own string table ("LST") (string lengths are generally encoded
  elsewhere, so strings in lst are not null-terminated), followed by information
  describing symbols that this container exports. */

typedef struct loader_header {
  unsigned entry_section;       /* entrypoint section number or -1 */
  unsigned entry_offset;        /* offset of entrypoint in entry_section or 0 */
  unsigned init_section;        /* fragment init routine section number or -1 */
  unsigned init_offset;         /* offset of fragment init routine in init_section or 0 */
  unsigned term_section;        /* fragment terminate routine section number or -1 */
  unsigned term_offset;         /* offset of fragment terminate routine in term_section or 0 */
  unsigned num_import_containers; /* count of containers (files) we import from */
  unsigned num_import_symbols;  /* count of symbols imported from all import_containers */
  unsigned num_reloc_sections;  /* count of sections with relocations */
  unsigned reloc_table_offset;  /* byte offset from start of loader section to relocations table */
  unsigned lst_offset;          /* byte offset from start of loader section to loader string table */
  unsigned hash_slot_table_offset; /* byte offset from start of loader section to export hash table */
  unsigned hash_slot_shift;     /* used in hashing export symbols */
  unsigned export_count;        /* number of exported symbols */
} loader_header;

typedef struct import_container {
  unsigned name;                /* Offset of container (lib) name in lst */
  unsigned old_imp_version;     /* Oldest implementation version of container we want */
  unsigned current_version;     /* Expected current version */
  unsigned import_count;        /* Count of imports from this container */
  unsigned first_import;        /* Index of first import in import table */
  unsigned char initorder;      /* Initialization order flag */
  unsigned char reserved[3];
} import_container;

#define kInitBefore 0x80	/* Library must be initialized before those it uses */
#define kWeakLib 0x40		/* Import library weakly */

typedef struct logical_import_container {
  char *name;
  unsigned num_imports;
  unsigned old_imp_version;
  unsigned current_version;
  unsigned flags;
} logical_import_container;

typedef struct import_symbol {
  unsigned class:8;
  unsigned name_offset:24;
} import_symbol;


typedef struct logical_import {
  char *name;
  unsigned class;
  logical_import_container *container;
} logical_import;

#pragma options align=mac68k
typedef struct PEF_export_symbol {
  unsigned class:8;
  unsigned name_offset:24;
  unsigned value;
  unsigned short section_number;
} PEF_export_symbol;
#pragma options align=reset

/* 
  GCC (at least) doesn't get sizeof(PEF_export_symbol) right.
  I'm not sure whether this is a GCC bug or whether it's
  considered bad C form to expect sizeof to do anything
  useful.
*/

#define PEF_export_symbol_size 10

typedef struct logical_export {
  char name[32];               /* null-terminated */
  unsigned gst_index;
  unsigned section_number;
  unsigned class;
  int hash_code;
  int hash_slot_index;
  int value;
} logical_export;
  
typedef struct {
  char *data;
  unsigned logsize;
  unsigned physsize;
} global_string_table;

typedef struct {
  Boolean external;
  unsigned relocpos;            /* disk address of relocation header or 0  */
  union {
    PEF_section *physical_section;
    logical_import *external_section;
  } section;
  area_list *contents;
} logical_section;

/* Symbol classes */
#define kCodeSymbol 0
#define kDataSymbol 1
#define kTVectSymbol 2
#define kTOCSymbol 3
#define kGlueSymbol 4
#define kWeakImport 0x80

typedef struct relocation_header {
  unsigned short section_number; /* section number to which these relocations apply */
  unsigned short reserved;
  unsigned relocation_count;    /* number of relocation entries in this section */
  unsigned first_relocation;    /* offset of section's first relocation in relocation table */
} relocation_header;

typedef union {
  struct {unsigned op:7, rest:9;} opcode;
  struct {unsigned op:2, delta_d4:8, cnt:6;} deltadata;
  struct {unsigned op:7, cnt_m1:9;} run;
  struct {unsigned op:7, idx:9;} glp;
  struct {unsigned op:4, delta_m1:12;} delta;
  struct {unsigned op:4, icnt_m1:4, rcnt_m1:8;} rpt;
  struct {unsigned op:6, idx_top:10;} large1;
  struct {unsigned op:6, cnt_m1:4, idx_top:6;} large2;
  unsigned short instr;
  unsigned short bot;
} relocation_instruction;


#define DDAT 0
#define CODE 0x20
#define DATA 0x21
#define DESC 0x22
#define DSC2 0x23
#define VTBL 0x24
#define SYMR 0x25
#define SYMB 0x30
#define CDIS 0x31
#define DTIS 0x32
#define SECN 0x33         
#define DELTA 8
#define RPT 9


/*
  "Pattern-initialized data" is data encoded in a simple byte-coded
  language.  The opcodes are described below; the one-byte opcode
  is generally followed by zero or more "count" bytes, which are
  in turn followed by any "raw data" bytes that the opcode may
  use.

  All opcodes take at least one "count" parameter (COUNT1).  Values
  1-31 can be encoded in the low 5 bits of the opcode; larger values
  are encoded in 1 or more bytes which follow the opcode.

  Count values (other than the special case where COUNT1 fits in 5 bits)
  are encoded in 1 to 5 bytes.  If the high bit of a count byte is clear,
  then the low 7 bits of the count value are the low seven bits of that
  byte; otherwise, the low seven bits are ORed into the accumulated value
  and the accumulated value is shifted left 7 bits.  If there are as many
  as 5 count bytes, the most significant bit of the last byte must be clear.

  This is described as "intentionally simple", to make decoding fast.
*/

typedef union {
  struct {unsigned op:3, count:5;} op;
  unsigned char b;
} pattern;

#define pi_op_Zero 0            /* COUNT1 bytes of 0 */
#define pi_op_Block 1           /* COUNT1 bytes of data follow opcode */
#define pi_op_Repeat 2          /* COUNT1 bytes of raw data, repeated COUNT2 times */
#define pi_op_RepeatBlock 3     /* (COUNT1+COUNT2)*COUNT3 bytes of raw data */
#define pi_op_RepeatZero 4      /* (COUNT2*COUNT3) bytes of raw data */

typedef union {
  struct {unsigned a4:4, b7:7, c7:7, d7:7, e7:7;} bits;
  unsigned long fullword;
} pi_count;

#pragma options align=mac68k
typedef struct cfrg_member {
  long archType;
  long updateLevel;
  long currentVersion;
  long oldDefVersion;
  long appStackSize;
  short appSubFolderID;
  char usage;
  char where;
  long offset;
  long length;
  long reserved0;
  short reserved1;
  short extensions;
  short member_size;
  char member_name[1];
} cfrg_member;
#pragma options align=reset

typedef struct cfrg {
  long reserved0;
  long reserved1;
  long cfrgversion;
  long reserved2;
  long reserved3;
  long reserved4;
  long reserved5;
  long nmembers;
  cfrg_member members[1];
} cfrg;

    
void
check_pef_error(OSErr);

void
PEF_write(short, long*, const void *);

void
PEF_getpos(short, long*);

void
PEF_setpos(short, short, long);


