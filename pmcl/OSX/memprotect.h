#ifndef __memprotect_h__
#define __memprotect_h__

/*
  01/29/97 gb  anal-retentive extern decls for gcc.
  ---- 4.0 ---
  07/20/96 gb  say "ExceptionInformationPowerPC" to keep 68K C happy
  ---- 3.9 ---
  03/10/96 gb  new protection scheme
  10/24/95 gb  no more kMEMOpreempt
*/

#ifdef PMCL_OSX_NATIVE_KERNEL
#include <Carbon/Carbon.h>
#else
#include <MachineExceptions.h>
#endif
#include "lisp.h"

int
ProtectMemory(LogicalAddress, int);

int
UnProtectMemory(LogicalAddress, int);

typedef enum {
  kNotProtected,		/* At least not at the moment. */
  kVSPsoftguard,
  kSPsoftguard,
  kTSPsoftguard,
  kSPhardguard,			/* Touch one and die. */
  kVSPhardguard,
  kTSPhardguard,
  kHEAPsoft,			/* Uninitialized page in the heap */
  kHEAPhard,			/* The end-of-the-line in the heap */
  /* Phony last entry. */
  kNumProtectionKinds
  } lisp_protection_kind;

typedef
struct protected_area {
  struct protected_area *next;
  BytePtr start;                /* first byte (page-aligned) that might be protected */
  BytePtr end;                  /* last byte (page-aligned) that could be protected */
  unsigned nprot;               /* Might be 0 */
  unsigned protsize;            /* number of bytes to protect */
  lisp_protection_kind why;
} protected_area, *protected_area_ptr;


/* Various functions that try to respond to a protection violation */
typedef 
  OSStatus (protection_handler)(ExceptionInformationPowerPC *, protected_area_ptr, BytePtr);

protection_handler 
  do_spurious_wp_fault,
  do_soft_stack_overflow,
  do_hard_stack_overflow,
  do_heap_soft_probe,
  do_heap_hard_probe;

extern protection_handler
  *protection_handlers[];


void
exception_cleanup(void);

void
exception_init(void);

  
#endif /* __memprotect_h__ */
