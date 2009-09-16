#ifndef __AREA_H__
#define __AREA_H__ 1

#include "lisp.h"
#include "bits.h"
#include "memprotect.h"
#ifdef PMCL_OSX_NATIVE_KERNEL
#include <Carbon/Carbon.h>
#else
#include <Threads.h>
#endif

/*
   07/30/01 akh increase STACK_SEGMENT_SIZE from 8k to 16k 
   03/01/97 gb   4.0 released before anal-retention.
   02/20/97 bill area_ptr_threadID
   01/29/97 gb   anal-retentive extern decls.
   -----------   4.0
   06/16/96 bill STACK_SEGMENT_SIZE
   06/20/96 gb   add threshold, gc_count to/remove nextref from area struct.
                 declare egc ereas.
   05/12/96 gb   nilreg_area.
   ---- 3.9 ---
   03/14/96 bill #ifndef to match #endif at end of file
   02/20/96 gb   #include this once; area_list moves here; add area.owner.
   01/29/96 gb   don't overload markbits; add softprot, hardprot fields.
   01/22/96 gb   another use for markbits slot
   12/22/95 gb   area enums are fixnums
*/

typedef enum {
  AREA_VOID = 0,		/* Not really an area at all */
  AREA_CSTACK = 4,              /* A control stack */
  AREA_VSTACK = 8,              /* A value stack.  The GC sees it as being doubleword-aligned */
  AREA_TSTACK = 12,             /* A temp stack.  It -is- doubleword-aligned */
  AREA_READONLY = 16,           /* A (cfm) read-only section. */
  AREA_STATICLIB = 20,          /* A static section in a shared library.  May
                                 contain pointers to other static sections, but
                                 not to any dynamic areas */
  AREA_STATIC = 24,             /* A (cfm or other) static section: contains
                                 roots, but not GCed */
  AREA_DYNAMIC = 28             /* A heap. Only one such area is "the heap."*/
} area_code;

typedef struct area {
  struct area *pred;		/* linked list predecessor */
  struct area *succ;		/* linked list successor */
  BytePtr low;			/* arithmetic lower limit on addresses (inclusive) */
  BytePtr high;			/* arithmetic upper limit on addresses (exclusive) */
  BytePtr active;		/* low bound (stack) or high bound (heap) */
  BytePtr softlimit;		/* only makes sense for dynamic heaps & stacks */
  BytePtr hardlimit;		/* only makes sense for dynamic heaps & stacks */
  area_code code;
  bitvector markbits;           /* markbits for active area */
  unsigned ndwords;		/* "active" size of dynamic area or stack */
  struct area *older;		/* if ephemeral, the next older ephemeral area
				 or the dynamic area */
  struct area *younger;		/* if ephemeral, the next "younger" ephemeral area
				 if there is one.  If dynamic, the oldest ephemeral
				 area. */
  Handle h;			/* The handle allocated to contain this area, or NULL
				 if the operating system allocated it for us. */
  protected_area_ptr softprot;  /* "soft" protected_area */
  protected_area_ptr hardprot;  /* "hard" protected_area */
  unsigned owner;               /* position in external_containers linked list */
  bitvector refbits;            /* intergenerational references.
                                   May or may not be the same as markbits */
  unsigned threshold;           /* egc threshold (boxed "fullword count") or 0 */
  LispObj gccount;              /* boxed generation GC count. */
} area;

#define area_ptr_threadID(a) ((ThreadID) (a->threshold))

/*
  Areas are kept in a doubly-linked list.
  The list header is just a distinguished element of
  that list; by convention, the "active" dynamic
  area is described by that header's successor, and areas
  that may have entries in their "markbits" vector (heaps)
  precede (in the area_list->succ sense) those  that don't (stacks).
  The list header's "area" pointer is an "AREA_VOID" area; the header
  (once allocated during kernel initialization) never
  moves or changes.  Lisp code can get its hands on
  the list header via a nilreg global, and carefully,
  atomically, traverse it to do ROOM, etc.
*/


area *new_area(BytePtr, BytePtr, area_code);
void add_area(area *);
area *remove_area(area *);
area *area_containing(BytePtr);
area *stack_area_containing(BytePtr);
area *heap_area_node_containing(BytePtr);
void tenure_to_area(area *);
void untenure_from_area(area *);

extern area *all_areas;
extern area *nilreg_area, *tenured_area, *g2_area, *g1_area;

/* #define active_dynamic_area ((area *)(all_areas->succ)) */
#define reserved_area ((area *)(all_areas))
#define active_dynamic_area ((area *)(reserved_area->succ))


typedef struct area_list {
  area *area;
  struct area_list *next;
} area_list;

/* The useable size of a tsp or vsp stack segment.
  */
#define STACK_SEGMENT_SIZE 16384


#endif /* __AREA_H__ */
