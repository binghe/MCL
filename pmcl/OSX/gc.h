#ifndef __GC_H__
#define __GC_H__ 1

#include "lisp.h"
#include "bits.h"
#include "lisp-exceptions.h"
#include "memprotect.h"

/*
 06/27/07 define area_dnode = area_dword
  ------ 5.2b6
  07/20/96  gb  ExceptionInformation -> ExceptionInformationPowerPC 
  06/20/96  gb  egc_control().
  ---- 3.9
  03/14/96 bill Reinsert the #ifndef to match the #endif
  02/28/96 bill growzone_handle
  02/20/96  gb  lib_purify.
  02/18/96 bill Add delete_protected_area
  01/11/96  gb  forward_marker; purify.
  12/28/95  gb  note_memoized_references args changed.
  12/13/95  gb  more parens around is_node_fulltag
*/

#define is_node_fulltag(f)  ((1<<(f))&((1<<fulltag_cons)|(1<<fulltag_misc)))

/*
  A code-vector's header can't look like a valid instruction or UUO:
  the low 8 bits must be subtag_code_vector, and the top 6 bits
  must be 0.  That means that the maximum length of a code vector
  is 18 bits worth of elements (~1MB.)
*/

#define code_header_mask ((0x3f<<26) | subtag_code_vector)

extern LispObj GCarealow;
extern unsigned GCndwords_in_area;
extern bitvector GCmarkbits;
extern LispObj *global_reloctab, *GCrelocptr;
extern LispObj GCfirstunmarked;

void mark_root(LispObj);
void mark_pc_root(LispObj);
void mark_locative_root(LispObj);
void rmark(LispObj);
unsigned skip_over_ivector(unsigned, LispObj);
void mark_simple_area_range(LispObj *,LispObj *);
LispObj calculate_relocation();
LispObj locative_forwarding_address(LispObj);
LispObj node_forwarding_address(LispObj);
void forward_range(LispObj *, LispObj *);
void note_memoized_references(ExceptionInformationPowerPC *,LogicalAddress, LogicalAddress, BytePtr *, BytePtr *);
void gc(xframe_list *);
void purify(ExceptionInformationPowerPC *);
OSErr lib_purify(ExceptionInformationPowerPC *, char *, LispObj *, LispObj *);
void delete_protected_area(protected_area_ptr);
Boolean egc_control(Boolean, BytePtr);



extern Handle growzone_handle;
extern Boolean gc_invoked_by_growzone;


#define area_dword(w,low) ((((LispObj)w) - (LispObj)low)>>3)
#define gc_area_dword(w)  area_dword(w,GCarealow)

#define area_dnode(w,low) ((unsigned)(((ptr_to_lispobj(w)) - ptr_to_lispobj(low))>>dnode_shift))
#define gc_area_dnode(w)  area_dnode(w,GCarealow)

#define forward_marker fulltag_nil

typedef struct mutable_data_section_header {
  struct mutable_data_section_header *next;
  BytePtr mutable_low;          /* low byte in mutable data section */
  BytePtr mutable_high;         /* high byte in mutable data section */
  BytePtr immutable_low;        /* low byte in (imported) mutable data section */
  BytePtr immutable_high;       /* high byte in (imported) mutable data section */
  LispObj flags;                /* bits, TBD. */
  LispObj timestamp;            /* for versioning */
  char libname[64];             /* null-terminated container name */
} mutable_data_section_header;

typedef struct static_header{
  BytePtr low;
  BytePtr high;
  mutable_data_section_header *next;
} static_header;


#endif                          /* __GC_H__ */
