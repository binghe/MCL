



#include "lisp-exceptions.h"
#include "lisp_globals.h"
#include "area.h"
#include <ctype.h>
#include <stdio.h>
#include <stddef.h>
#include <string.h>
#include <stdarg.h>
#include <stdio.h>
#include <strings.h>
#include <sys/mman.h>
#ifdef PMCL_OSX_NATIVE_KERNEL
#include <Carbon/Carbon.h>
#else
#include <Errors.h>
#include <TextUtils.h>
#include <Threads.h>
#include <MacTypes.h>
#include <Multiprocessing.h>
#include <MacMemory.h>
#endif

#include "debugf.h"




/*
 $Log: lisp-exceptions.c,v $
 Revision 1.17  2003/12/08 05:14:46  gtbyers
 More careful about debugger entry from exceptions; tell debugger why
 it's being entered.

 Revision 1.16  2003/12/01 17:56:08  gtbyers
 recover pre-MOP changes

 Revision 1.14  2003/11/17 06:57:41  gtbyers
 provide stub definition of lisp_Debugger for #-native-kernel case.

 Revision 1.13  2003/11/17 02:17:18  gtbyers
 Don't call lisp_Debugger directly from exception handlers.

 Revision 1.12  2003/11/13 00:20:22  gtbyers
 Use lisp_Debugger() to report/deal with unhandled exceptions.  Use call_cfm_proc to reset thread.

 Revision 1.11  2003/11/10 17:15:43  gtbyers
 Handle LISP_BREAK_INSTRUCTION.  Remove some code that deals with "exception policy", on the assumption that it's no longer used ...

 Revision 1.10  2003/03/09 05:11:25  gtbyers
 fix Bug() typo.  lisp_growzone_internal sets gc_invoked_by_growzone.

 Revision 1.9  2003/03/08 00:01:19  gtbyers
 Bug() does exactly what debugf() does (in CFM kernel.)

 Revision 1.8  2003/03/03 19:30:26  svspire
 Make it MCL_DEBUG (underscore) instead, since some csh commands like echo have trouble with hyphens.

 Revision 1.7  2003/03/03 11:47:58  gtbyers
 if MCL-DEBUG env var is set, beep and give user 60 seconds to attach GDB before application exception handler fails.

 Revision 1.5  2003/02/12 21:37:21  gtbyers
 new per-thread exception handling.

 Revision 1.4  2002/12/18 04:20:01  gtbyers
 Better to call install_threadentryupp() in native kernel than to leave the variable uninitialized.

 Revision 1.3  2002/11/25 06:02:48  gtbyers
 Try to straighten out report_memfault() and callers.  Note when application exception handler failed; repeat the exception (and don't try to handle it) in that case.  error_action() always returns kExit if no TTY.

 Revision 1.2  2002/11/23 09:00:31  gtbyers
 in callback_to_lisp(), native kernel passes arg4 (vice arg3 twice) to CFM proc.

 akh - add zalloc etc
------- 5.2b6
 06/26/01 akh (re)InstallExceptionHandler after making newthread (osx bug)
----------- 4.4b1
 akh InstallExceptionHandler - use CarbonLib version if exists, else InterfaceLib
 akh protect/unprotect memory use mprotect if osx
 akh call NewExceptionHandlerUPP if exists (carbonlib 1.1d12)
 akh trying to use multiprocessing interface to exception handling without success
 akh call NewThreadEntryUPP in/for NewThread 
 akh use ourcallupp2 vs CallUniversalProc if carbon
 akh lose getzone etal if CARBON ??
 akh use c2pstrcpy vs. c2pstr if CARBON it's supposed to be in InterfaceLib but isn't really
----------- 4.3 and 4.3.1
 03/12/97 bill  update_area_active, do_vsp_overflow, & do_tsp_overflow include pointers
                that are equal to the area.high slot in that area.
 02/20/97 bill  Control stack segmentation support:
                continue_on_new_thread, allocate_cstack, allocate_no_stack, cs_stack_switch_startup
 10/25/96 bill  do_vsp_overflow checks younger VSP frames for the real_vsp.
 -------------  4.0
 07/26/96 gb    lisp_bug; Debugstr(pstring) -> Bug(cstring).
 07/14/96 gb    force full gc in lisp_growzone_internal.  (log2_)heap_segment_size
                now constants.
 07/11/96 bill  do_vsp_overflow & do_tsp_overflow call allocate_area_with_c_gc_context
                insead of calling allocate_vstack & allocate_tstack directly.
                A GC may happen due to growzone.
 07/10/96 bill  find_non_catch_frame_from_xp ignores frames with a savevsp of 0.
                The VSP relocation code at the end of do_vsp_overflow doesn't
                report relocation errors for them either.
                They are there during the execution of an unwind-protect cleanup form.
 07/08/96 bill  handle_trap ignores VSP & TSP in determining when to exit CSP overflow mode.
                find_non_catch_frame_from_xp ignores frames with a savelr of 0.
                The VSP relocation code at the end of do_vsp_overflow doesn't
                report relocation errors for them either.
                They are there while the arguments to a ppc-ff-call are being evaluated.
 06/21/96 bill  sample_preserved_registers
 06/17/96 bill  do_soft_stack_overflow calls either do_vsp_overflow or do_tsp_overflow.
                These two new functions handle extending the corresponding stack.
                gc_from_xp calls (new) update_area_active instead of updating the
                CURRENT_VS & CURRENT_TS active pointers itself.
 06/20/96 gb    egc-related changes.
 06/10/96 gb    new exception scheme.
 05/12/96 gb    bother with HoldMemory (RamDoubler.)
 ---- 3.9 ---
 04/15/96 gb    don't bother with HoldMemory.  Account for heap_spare in lisp_growzone_internal.
 ---- 3.9f1c2
 04/11/96 gb    reprotect_dynamic_heap: adjust a->high & a->ndwords for heap_spare.
                add fatal_oserr(); call it on save_application failure. ~ -> % in 
                allocation_failure() format string.  I mean printf string.
 04/10/96 gb    new protection stuff for out-of-memory conditions.
 		alloc_xxx_critical.
 04/09/96 gb    use adjust_exception_pc instead of set_xpPC so GC changes to
                pc don't get lost.
 04/08/96 bill  callback_to_lisp makes EXCEPTION_SAVED_REGISTERS point at saved registers.
 03/28/96 gb    protect hard area when soft area unprotected in handle_xalloc
 03/26/96 gb    stack overflow fixes (reset_lisp_process).  Code cleanup.
 03/21/96 bill  callback_to_lisp stores SP in the area.active slot of the
                current stack area.
 03/18/96 gb    second (lib_version) value from save-library; gc_from_c
                assumes trap call "normalized" current_cs.
 03/01/96 bill  (defpascal %err-disp ...) expects 0/1 instead of nil/t for its continuable arg.
                Change all the callers of handle_error accordingly.
 03/10/96 gb    new protection scheme; FP exceptions.
 02/28/96 bill  lisp_growzone, lisp_growzone_UPP, install_lisp_growzone
 02/20/96 gb    save_application/save_library.
 02/28/96 bill  lisp_growzone, lisp_growzone_UPP, install_lisp_growzone
 02/18/96 bill  new_protected_area uses NewPtr instead of malloc and
                returns NULL if the allocation fails.
 02/01/96 gb    some stack-overflow/area changes.
 01/22/96 gb    start signalling stack overflow.
 01/10/96 gb    fix_fixnum_overflow; purify, write_PEF_file.
 12/27/95 gb    note_memoized_references params change.
 12/22/95 gb    handle_xalloc didn't come close; no chatter on console for now
 12/13/95 gb    lotsa changes
 12/07/95 bill  handle_trap calls callback_for_trap instead of callback_to_lisp.
                It uses register_codevector_contains_pc to split the PC up into
                a code_vector and offset and passes these on to callback_to_lisp.
                callback_to_lisp takes an additional arg, which
                handle_error also uses callback_for_trap and passes a continuable flag.
 11/22/95 bill  handle_trap & handle_error use new function: callback_to_lisp
 11/19/95 gb    no mo SIOW
 11/14/95 slh   handle_trap: fix event poll case
                call_errdisp()
 11/10/95 slh   scan_for_instr uses codevec_hdr_p
 10/26/95 slh   add error_action(), use in handle_trap()
*/

/*
  Handle exceptions.

  On System 7.x (for known values of "x"), it's necessary to hook into
  the system exception handling mechanisms; by default, those mechanisms
  deliver the exception to a debugger -before- we get a chance to see
  it.  That's no fun.

  Supposedly, later OS versions will provide some means whereby applications
  can inform the system of whether or not they want things to behave in a
  useful manner.
*/

extern LispObj lisp_nil;

/* top 6 bits will be zero, subtag will be subtag_code_vector */
#define CV_HDR_MASK     (OP_MASK | subtagmask)
#define CV_HDR_VALUE    subtag_code_vector
#define codevec_hdr_p(value)	(((value) & CV_HDR_MASK) == CV_HDR_VALUE)


typedef enum {
  kSysFirst,
  kUserFirst
} ExceptionPolicy;




/*
  An "exception policy making" function gets called when both system and user
  handlers are present.  It gets to look at the exception context and both
  the system and user handlers, and should return one of the ExceptionPolicy
  constants above.
  */

typedef ExceptionPolicy (*ExceptionPolicyMaker) 
     (ExceptionInformation *, ExceptionHandler, ExceptionHandler);


void
allocation_failure(Boolean pointerp, unsigned size)
{
  unsigned char buf[64];
  DebugStr("\pallocation_failure");
  sprintf((char *)buf, "Can't allocate ~s of size %d bytes.", pointerp ? "pointer" : "handle", size);
#ifdef CARBON
  c2pstrcpy(buf, (char *)buf);
  Fatal("\p:   Kernel memory allocation failure.  ", buf);
#else
  Fatal("\p:   Kernel memory allocation failure.  ", c2pstr(buf));
#endif
}

void
fatal_oserr(StringPtr param, OSErr err)
{
  unsigned char buf[64];
  DebugStr("\pfatal_oserr");
  sprintf((char *)buf," - operating system error %d.", err);
#ifdef CARBON
  c2pstrcpy(buf, (char *)buf);
  Fatal(param, buf);
#else
  Fatal(param, c2pstr(buf));
#endif
}

/* 
  Allocate a pointer or die.
*/
Ptr
alloc_ptr_critical(unsigned size, Boolean clear_p)
{
  Ptr p = clear_p ? NewPtrClear(size) : NewPtr(size);

  if (p == NULL) {
    allocation_failure(true, size);
  }
  return p;
}

Ptr
allocate(unsigned size)
{
  return (Ptr) malloc(size);
}

void
deallocate(Ptr p)
{
  free((void *)p);
}

Ptr
zalloc(unsigned size)
{
  Ptr p = allocate(size);
  if (p != NULL) {
    memset(p, 0, size);
  }
  return p;
}

Handle
new_locked_handle(unsigned size)
{
  Handle h;
  ReserveMem(size);
  h = NewHandle(size);
  if (h) {
    HLock(h);
  }
  return h;
}

Handle
new_temp_locked_handle(unsigned size)
{
  Handle h;
  OSErr err;
  
  h = TempNewHandle(size, &err);
  if (err != noErr) {
    return NULL;
  }
  HLock(h);
  return h;
}

/*
  Allocate a locked handle or die.  If size is less than 10K, try
  application heap first, else try multifinder first.
*/
Ptr
alloc_handle_critical(unsigned size, Handle *h_p)
{
  Boolean small = (size <= (10<<10));
  Handle h;

  if (small) {
    if ((h = new_locked_handle(size)) == NULL) {
      h = new_temp_locked_handle(size);
    }
  } else {
    if ((h = new_temp_locked_handle(size)) == NULL) {
      h = new_locked_handle(size);
    }
  }

  if (h == NULL) {
    allocation_failure(false, size);
  }

  if (h_p != NULL) {
    *h_p = h;
  }
  return *h;
}
  


/* 
  Sooner or later, there'll be some more native way to protect/unprotect 
  memory.  That might mean that this old way breaks.
*/

extern OSErr (* our_CallOSTrapUniversalProc) (UniversalProcPtr, unsigned, ...);
extern OSErr (* our_CallUniversalProc) (UniversalProcPtr, unsigned, ...);
/* extern OSErr (* our_LockMemory) (BytePtr, unsigned);
extern OSErr (* our_UnlockMemory)(BytePtr, unsigned);
*/
/* these do not exist in OSX but do exist in "real" CarbonLib so we avoid runtime "link" error */
extern OSErr (* our_HoldMemory) (BytePtr, unsigned);
extern OSErr (* our_UnholdMemory)(BytePtr, unsigned);

void
report_unprotect (LogicalAddress addr, int nbytes)
{
#ifdef CARBON
 debugf("UnProtect addr %x nbytes %d.", addr, nbytes);
#else
 char buf[64];
 sprintf(buf, "UnProtect addr %x nbytes %d.", addr, nbytes);
 c2pstr(buf);
 DebugStr(buf);
#endif
}

void
report_protect (LogicalAddress addr, int nbytes)
{
#ifdef CARBON
 debugf("Protect addr %x nbytes %d.", addr, nbytes);
#else
 char buf[64];
 sprintf(buf, "Protect addr %x nbytes %d.", addr, nbytes);
 c2pstr(buf);
 DebugStr(buf);
#endif
}





int
ProtectMemory(LogicalAddress addr, int nbytes)
{
  return 0;
}


int
UnProtectMemory(LogicalAddress addr, int nbytes)
{
  return 0;
}

void
unprotect_area(protected_area_ptr p)
{
  BytePtr start = p->start;
  unsigned nprot = p->nprot;
  
  if (nprot) {
    UnProtectMemory(start, nprot);
    p->nprot = 0;
  }
}


extern
int
cache_block_size;		/* May be different on later CPUs. */

int
page_size = 4096;

extern void
zero_cache_lines(BytePtr, size_t, size_t);


#ifdef PMCL_OSX_NATIVE_KERNEL
/* Somewhere (buried inside a UPP) is a CFM function (transfer vector).
   Why do lisp callbacks involve UPPs under Carbon?  There's no 68K
   emulator ... */
#define UPP_CFM_PROC(callback_ptr) \
 (((RoutineDescriptor *)(callback_ptr))->routineRecords[0].procDescriptor)
extern int
call_cfm_proc(ProcPtr, ...);
#else
extern int
ourcallupp2(UniversalProcPtr, int, ...); 
#endif




void
zero_page(BytePtr start)
{
  zero_cache_lines(start, (page_size/cache_block_size), cache_block_size);
}

void
zero_heap_segment(BytePtr start)
{
  zero_cache_lines(start, (heap_segment_size/cache_block_size), cache_block_size);
}

protected_area_ptr
AllProtectedAreas = NULL;

/* 
  This does a linear search.  Areas aren't created all that often;
  if there get to be very many of them, some sort of tree search
  might be justified.
*/

protected_area_ptr
find_protected_area(BytePtr addr)
{
  protected_area* p;
  
  for(p = AllProtectedAreas; p; p=p->next) {
    if ((p->start <= addr) && (p->end > addr)) {
      return p;
    }
  }
  return NULL;
}

void
signal_stack_soft_overflow(ExceptionInformation *xp, unsigned reg)
{
  /* The cstack just overflowed.  Force the current thread's
     control stack to do so until all stacks are well under their overflow
     limits. */

  lisp_global(CS_OVERFLOW_LIMIT) = 0xfffffff8; /* force unsigned traps to fail */
  handle_error(xp, error_stack_overflow, reg, 0, (unsigned) xpPC(xp));
}

extern LispObj start_lisp(LispObj, LispObj);

void
reset_lisp_process(ExceptionInformation *xp)
{
  catch_frame *last_catch = (catch_frame *) (untag(lisp_global(CATCH_TOP)));

  lisp_global(SAVE_FREEPTR) = xpGPR(xp, freeptr);

  lisp_global(SAVE_VSP) = ((lisp_frame *)last_catch->csp)->savevsp;
  lisp_global(SAVE_TSP) = ((LispObj) last_catch) - 8; /* account for TSP header */
#ifdef PMCL_OSX_NATIVE_KERNEL
   start_lisp(lisp_nil, 1);
  /* call_cfm_proc((ProcPtr)start_lisp, lisp_nil, 1); */
#else
  start_lisp(lisp_nil, 1);   /* I think we got to here starting on OSX */
#endif
}
  
int wedged_count = 5;
extern unsigned heap_spare_size;
extern unsigned heap_spare;

void
set_heap_limit(ExceptionInformation *xp, BytePtr newfree)
{
  unsigned zbytes;
  area *a = active_dynamic_area;
  BytePtr limit = a->high, egclimit = NULL;

  if (a->older && lisp_global(OLDEST_EPHEMERAL)) {
    egclimit = (BytePtr)align_to_power_of_2((LispObj)newfree+heap_segment_size+a->threshold, log2_heap_segment_size);
  }
  
  if (egclimit) {
    if (egclimit <= limit) {
      limit = egclimit;
    }
  }
  
  lisp_global(HEAP_LIMIT) = (LispObj) limit;
  zbytes = limit - newfree;

  if (zbytes) {
    memset(newfree,0,zbytes);
  }

  if ((((BytePtr)lisp_global(HEAP_LIMIT))-newfree) < (2 * heap_segment_size)) {
    handle_error(xp, error_memory_full, rnil, 0, (unsigned) xpPC(xp));
  }

  return;
}


 
void
update_area_active (int global, BytePtr value)
{
  area *a = (area *) lisp_global(global);
  for (; a; a = a->older) {
    if ((a->low <= value) && (a->high >= value)) break;
  };
  if (a == NULL) Bug("Can't find active area");
  a->active = value;
  lisp_global(global) = (LispObj) a;

  for (a = a->younger; a; a = a->younger) {
    a->active = a->high;
  }
}


/* Returns #bytes freed by invoking GC */

int
gc_from_xp(ExceptionInformation *xp)
{
  area *a;
  xframe_list xf;
  BytePtr oldfree, newfree;


  xf.prev = (xframe_list *) lisp_global(XFRAME);
  xf.this = xp;

  a = (area *) lisp_global(CURRENT_CS);
  a->active = (BytePtr) xpGPR(xp, sp);
  
  update_area_active(CURRENT_VS, (BytePtr) xpGPR(xp, vsp));
  update_area_active(CURRENT_TS, (BytePtr) xpGPR(xp, tsp));

  a = active_dynamic_area;
  oldfree = a->active = (BytePtr) xpGPR(xp, freeptr);
  gc(&xf);

  newfree = a->active;
  xpGPR(xp,freeptr) = xpGPR(xp, initptr) = (unsigned) newfree;

  set_heap_limit(xp, newfree);
  return (oldfree-newfree);
}

extern BytePtr
current_stack_pointer(void);

void
protect_area(protected_area_ptr p)
{
  BytePtr start = p->start;
  unsigned n = p->protsize;

  if (n && ! p->nprot) {
    ProtectMemory(start, n);
    p->nprot = n;
  }
}


/* This is called by do_vsp_overflow & do_tsp_overflow.
   Allocating a stack area may cause a GC due to growzone.
   Since we get to the stack allocation code via a trap, not a ppc-ff-call,
   we need to store the area info where gc_from_c expects to find it.
 */

area *
allocate_area_with_c_gc_context(ExceptionInformation *xp, area *allocator(unsigned), unsigned size)
{
  area *new_area;

  (((area *) lisp_global(CURRENT_CS)) -> active) = (BytePtr) xpGPR(xp, sp);
  lisp_global(SAVE_VSP) = (LispObj) xpGPR(xp, vsp);
  lisp_global(SAVE_TSP) = (LispObj) xpGPR(xp, tsp);
  lisp_global(SAVE_FREEPTR) = (LispObj) xpGPR(xp, freeptr);
  
  new_area = allocator(size);

  set_xpGPR(xp, freeptr, lisp_global(SAVE_FREEPTR));

  return new_area;
}


/* Call this to GC from C code that was entered via a ppc-ff-call from lisp */

int
gc_from_c()
{
  ExceptionInformation xp_record, *xp = &xp_record;
  MachineInformation mp_record;
  RegisterInformation rp_record;
  int bytes_freed;

  memset(&xp_record, 0, sizeof(ExceptionInformation));
  memset(&mp_record, 0, sizeof(MachineInformation));
  memset(&rp_record, 0, sizeof(RegisterInformation));

  xp_record.machineState = &mp_record;
  xp_record.registerImage = &rp_record;

  set_xpGPR(xp, sp, ((area *) lisp_global(CURRENT_CS)) ->active);
  set_xpGPR(xp, vsp, lisp_global(SAVE_VSP));
  set_xpGPR(xp, tsp, lisp_global(SAVE_TSP));
  set_xpGPR(xp, freeptr, lisp_global(SAVE_FREEPTR));
  
  bytes_freed = gc_from_xp(xp);

  lisp_global(SAVE_FREEPTR) = (LispObj) xpGPR(xp, freeptr);

  return bytes_freed;
}

long
lisp_growzone_internal(Size);

long
lisp_growzone (Size cbneeded)
{
#ifndef CARBON
  THz saved_zone = GetZone();
#endif
  long result;

#ifndef CARBON
  SetZone(ApplicationZone());
#endif
  result = lisp_growzone_internal(cbneeded);
#ifndef CARBON
  SetZone(saved_zone);
#endif
  return result;
}

wide saved_bytes_freed = {0};
LispObj saved_freeptr = 0;
long saved_freemem = 0;

/* These should really be user settable parameters */
#define growzone_extra_bytes 8192
#define minimum_heap_free (64*1024)


long
lisp_growzone_internal(Size cbneeded)
{
  long free_bytes = FreeMem();
  lispsymbol * total_bytes_freed = (lispsymbol *) &(nrs_TOTAL_BYTES_FREED);
  LispObj val;
  wide *bytes_freed = NULL;
  area *a;
  BytePtr active, high;
  unsigned max_delta, delta;
  protected_area_ptr prot_h, prot_s;

  val = total_bytes_freed->vcell;
  if (!((fulltag_of(val) == fulltag_misc) &&
        (header_subtag(header_of(val)) == subtag_macptr) &&
        ((bytes_freed = (wide *) ((macptr *) (untag(val)))->address)->lo == saved_bytes_freed.lo) &&
        (bytes_freed->hi == saved_bytes_freed.hi) &&
        (free_bytes == saved_freemem) &&
        (lisp_global(SAVE_FREEPTR) == saved_freeptr))) {

    growzone_handle = GZSaveHnd();
    if (gc_invoked_by_growzone) {
      Bug("Growzone reentered!");
    }
    gc_invoked_by_growzone = true;
    /* Force a full gc here */
    untenure_from_area(tenured_area);
    gc_from_c();

    growzone_handle = NULL;
    gc_invoked_by_growzone = false;

    if (bytes_freed != NULL) {
      saved_bytes_freed.lo = bytes_freed->lo;
      saved_bytes_freed.hi = bytes_freed->hi;
    }
    saved_freemem = FreeMem();
    saved_freeptr = lisp_global(SAVE_FREEPTR);

    if (free_bytes != saved_freemem) {
       return saved_freemem - free_bytes;
    }
    free_bytes = saved_freemem;
  }

  /* GCing didn't free up enough. Time to shrink the lisp heap */
  /* Need to slide by heap_segment_size increments.
     The entire "hard" protected area slides.
     The top of the "soft" protected area slides.
     The area high, softlimit, & hardlimit slide, though the softlimit may be NULL.
     Finally, we SetHandleSIze smaller.

     The protected areas need to be a multiple of heap_segment_size in size and
     aligned on a page_size boundary. That means we could slide the hard area
     by 8K multiples if the soft area were empty, but I didn't bother. Instead,
     we always slide the end by a multiple of heap_segment_size.

     It would be nice to be able to shrink the mark bits, too, but we need to change
     them from pointers to locked handles in order to do so. 
       
     The mark bits are now at the beginning of the same block that contains
     the heap; we could shrink them, but we'd only free space by shuffling the
     heap down in memory.
*/

  if (heap_spare == 0) {
    /* Lisp heap is too full. */
    return 0;
  }

  a = active_dynamic_area;

  /* Does this ever happen? */
  if (a->h == GZSaveHnd()) return 0;

  active = (BytePtr) lisp_global(SAVE_FREEPTR);
  high = a->high;
  max_delta = (high - (active + heap_spare_size + minimum_heap_free)) & (~(heap_segment_size-1));

  if ((max_delta <= 0) || (max_delta < cbneeded)) return 0;

  /* Should be a way for users to control the extra space (8192) */
  delta = align_to_power_of_2(cbneeded + growzone_extra_bytes, log2_heap_segment_size);
  if (delta > max_delta) {
    delta = max_delta;
  }

  a->high = (high -= delta);
  a->hardlimit -= delta;             /* should be same as a->high, but why count on it? */
  if (a->softlimit) {
     a->softlimit -= delta;
  }
  (a->ndwords) -= (delta>>3);

  /* We're going to lower the end of the hard area, the start of the hard area,
     and the end of the soft area by 'delta' bytes.  (The last two addresses
     happen to be identical).  After doing so, there may (should) be at least one segment
     in the soft area.  If so, protect the soft area; if not, protect the hard area. */

  prot_s = a->softprot;
  prot_h = a->hardprot;

  if (prot_s->nprot != 0) {
    unprotect_area(prot_s);
  }
  prot_s->end -= delta;

  if (prot_s->end > prot_s->start) {
    protect_area(prot_s);
  }
  
  /* The hard area shouldn't (in the new scheme) have been protected
     (that only happens when the lisp heap is nearly full, and shrinking
     it would have been a bad idea.)  But let's be paranoid ... */
  
  if (prot_h->nprot != 0) {
    unprotect_area(prot_h);
  }
  
  prot_h->end -= delta;
  prot_h->start -= delta;

  /* If the soft area's unprotected (shouldn't happen), protect the
     hard area. */

  if (prot_s->nprot == 0) {
    protect_area(prot_h);
  }

  SetHandleSize(a->h, GetHandleSize(a->h) - delta);

  saved_freemem = FreeMem() - cbneeded;
  return delta;

}

GrowZoneUPP lisp_growzone_UPP = NULL;

void
install_lisp_growzone (void)
{

  saved_bytes_freed.lo = saved_bytes_freed.hi = 0;
  /* In the MPW headers we are using NewGrowZoneProc is a macro that calls NewRoutineDescriptor
    and NewGrowZoneUPP does not exist. Same is true in MPW-GM. NewGrowZoneUPP is in univ headers 3.3 */
#ifndef CARBON
  lisp_growzone_UPP = NewGrowZoneProc(lisp_growzone);
#else
  lisp_growzone_UPP = NewGrowZoneUPP(lisp_growzone);
#endif
  SetGrowZone(lisp_growzone_UPP);

}




protection_handler
 * protection_handlers[] = {
   do_spurious_wp_fault,
   do_soft_stack_overflow,
   do_soft_stack_overflow,
   do_soft_stack_overflow,
   do_hard_stack_overflow,
   do_hard_stack_overflow,
   do_hard_stack_overflow,
   do_heap_soft_probe,
   do_heap_hard_probe
   };

#define IS_MEMORY_EXCEPTION(code) (((code) == kReadOnlyMemoryException) || \
                                   ((code) == kUnresolvablePageFaultException) || \
                                   ((code) == kExcludedMemoryException) || \
                                   ((code) == kUnmappedMemoryException) || \
                                   ((code) == kAccessException))


OSStatus
handle_protection_violation(ExceptionInformation *xp)
{
  BytePtr addr;
  protected_area_ptr area;
  protection_handler *handler;
  int xnum = xp->theKind;

  if (!(IS_MEMORY_EXCEPTION(xnum))) {
    return -1;
  }

  addr = (BytePtr) ((int) (xp->info.memoryInfo->theAddress));
  
     
  area = find_protected_area(addr);
  
  if (area == NULL) {		/* Don't know why this fault happened. */
    return -1;
  } 
  
  handler = protection_handlers[area->why];

  return handler(xp, area, addr);
}


protected_area_ptr
new_protected_area(BytePtr start, BytePtr end, lisp_protection_kind reason, unsigned protsize, Boolean now)
{
  protected_area_ptr p = (protected_area_ptr) allocate(sizeof(protected_area));
  
  if (p == NULL) return NULL;
  p->protsize = protsize;
  p->nprot = 0;
  p->start = start;
  p->end = end;
  p->why = reason;
  p->next = AllProtectedAreas;

  AllProtectedAreas = p;
  if (now) {
    protect_area(p);
  }
  
  return p;
}

/*
  Un-protect the first nbytes bytes in specified area.
  Note that this may cause the area to be empty.
*/
void
unprotect_area_prefix(protected_area_ptr area, size_t delta)
{
  unprotect_area(area);
  area->start += delta;
  if ((area->start + area->protsize) <= area->end) {
    protect_area(area);
  }
}


/*
  Extend the protected area, causing the preceding nbytes bytes
  to be included and protected.
*/
void
protect_area_prefix(protected_area_ptr area, size_t delta)
{
  unprotect_area(area);
  area->start -= delta;
  protect_area(area);
}





OSStatus
do_heap_soft_probe(ExceptionInformation *xp, protected_area_ptr p, BytePtr addr)
{
#ifdef SUPPORT_PRAGMA_UNUSED
#pragma unused(xp)
#endif
  area *a = active_dynamic_area;
  BytePtr old_start = p->start;

  /* Sanity check ... */
  if ((old_start + heap_segment_size) >= addr) {
    /* Maybe do an egc here. */
    if (a->older && lisp_global(OLDEST_EPHEMERAL)) {
      if (((BytePtr)(xpGPR(xp,freeptr))-(a->low)) >= a->threshold) {
        gc_from_xp(xp);
        lisp_global(HEAP_LIMIT) = (LispObj)(p->start);
        return 0;               /* May fault again real soon ...*/
      }
    }
    unprotect_area_prefix(p, heap_segment_size);
    zero_heap_segment(old_start);
    /* If the soft area's now empty, protect the hard area */
    if (p->nprot == 0) {
      protect_area(active_dynamic_area->hardprot);
    }
    lisp_global(HEAP_LIMIT) = (LispObj)(p->start);
    return 0;
  }
  return -1;
}


OSStatus
do_heap_hard_probe(ExceptionInformation *xp, protected_area_ptr p, BytePtr addr)
{
  int want, have, got, freed;
  LispObj curfreeptr = (LispObj) xpGPR(xp, freeptr);
  area *a = active_dynamic_area;

  a->active = (BytePtr)curfreeptr;

  want = (LispObj) addr - curfreeptr;
  have = (LispObj) (p->start) - curfreeptr;
  
  
  untenure_from_area(tenured_area); /* force a full GC */
  freed = gc_from_xp(xp);
  got = have + freed;

  
  /* We only win (without making another heap or something)
     if we've "got" more than we "want", since the free pointer
     has to wind up before the hard guard segment. */
  if (got > want) {
    if (active_dynamic_area->softprot->nprot) {
      /* Soft area is protected, so unprotect the hard area */
      unprotect_area(p);
    }
  } else {
    /* We failed to allocate something less than 32K bytes.  It'd probably
       be wise to panic & try to grab another heap at this point.
       Calling lisp at this point ... um, lets us test stack overflow detection.
       */
    /* I don't think that this can happen anymore. */
    handle_error(xp, error_alloc_failed, rnil, 0, (unsigned) xpPC(xp));
  }
  return 0;
}

OSStatus
do_hard_stack_overflow(ExceptionInformation *xp, protected_area_ptr area, BytePtr addr)
{
#ifdef SUPPORT_PRAGMA_UNUSED
#pragma unused(area,addr)
#endif
  reset_lisp_process(xp);
  return -1;
}

extern area*
allocate_vstack(unsigned useable);       /* This is in "pmcl-kernel.c" */

extern area*
allocate_tstack(unsigned useable);       /* This is in "pmcl-kernel.c" */

Boolean
catch_frame_p(lisp_frame *spPtr)
{
  catch_frame* catch = (catch_frame *) untag(lisp_global(CATCH_TOP));

  for (; catch; catch = (catch_frame *) untag(catch->link)) {
    if (spPtr == ((lisp_frame *) catch->csp)) {
      return true;
    }
  }
  return false;
}

Boolean
unwind_protect_cleanup_frame_p(lisp_frame *spPtr)
{
  if ((spPtr->savevsp == 0) ||  /* The frame to where the unwind-protect will return */
      (((spPtr->backlink)->savevsp) == 0)) {  /* The frame that returns to the kernel  from the cleanup form */
    return true;
  } else {
    return false;
  }
}

Boolean
lexpr_entry_frame_p(lisp_frame *spPtr)
{
  LispObj savelr = spPtr->savelr;
  LispObj lexpr_return = (LispObj) lisp_global(LEXPR_RETURN);
  LispObj lexpr_return1v = (LispObj) lisp_global(LEXPR_RETURN1V);
  LispObj ret1valn = (LispObj) lisp_global(RET1VALN);

  return
    (savelr == lexpr_return1v) ||
    (savelr == lexpr_return) ||
    ((savelr == ret1valn) &&
     (((spPtr->backlink)->savelr) == lexpr_return));
}

int ffcall_overflow_count = 0;

/* Find a frame that is neither a catch frame nor one of the lexpr_entry frames
   We don't check for non-lisp frames here because we'll always stop before we
   get there due to a dummy lisp frame pushed by .SPcallback that masks out the foreign frames.
   The one exception is that there is a non-lisp frame without a valid VSP while
   in the process of ppc-ff-call. We recognize that because its savelr is 0.
   If the saved VSP itself is 0 or the savevsp in the next frame is 0,
   then we're executing an unwind-protect cleanup form, and the top stack frame
   belongs to its (no longer extant) catch frame.
 */
lisp_frame *
find_non_catch_frame_from_xp (ExceptionInformation *xp)
{
  lisp_frame *spPtr = (lisp_frame *) xpGPR(xp, sp);
  if ((((unsigned) spPtr) + sizeof(lisp_frame)) != ((unsigned) (spPtr->backlink))) {
    ffcall_overflow_count++;          /* This is mostly so I can breakpoint here */
  }
  for (; (spPtr->savelr == 0) ||	/* In the process of ppc-ff-call */
         unwind_protect_cleanup_frame_p(spPtr) ||
         catch_frame_p(spPtr) ||
         lexpr_entry_frame_p(spPtr); ) {
     spPtr = spPtr->backlink;
     };
  return spPtr;
}

Boolean
db_link_chain_in_area_p (area *a)
{
  LispObj *db = (LispObj *) lisp_global(DB_LINK),
          *high = (LispObj *) a->high,
          *low = (LispObj *) a->low;
  for (; db; db = (LispObj *) *db) {
    if ((db >= low) && (db < high)) return true;
  };
  return false;
}

typedef struct preserved_registers {
  LispObj the_pc;
  LispObj the_lr;
  LispObj sp_r1;
  LispObj rnil_r2;
  LispObj tsp_r12;
  LispObj vsp_r13;
  LispObj save7_r24;
  LispObj save6_r25;
  LispObj save5_r26;
  LispObj save4_r27;
  LispObj save3_r28;
  LispObj save2_r29;
  LispObj save1_r30;
  LispObj save0_r31;
} preserved_registers;

/* This is for debugging so that you can easily see in the Power Mac Debugger
   a window containing the preserved state
   */
void
sample_preserved_registers (ExceptionInformation *xp, preserved_registers *pr)
{
  pr->the_pc = (LispObj) xpPC(xp);
  pr->the_lr = (LispObj) xpLR(xp);
  pr->sp_r1 = xpGPR(xp, sp);
  pr->rnil_r2 = xpGPR(xp, rnil);
  pr->tsp_r12 = xpGPR(xp, tsp);
  pr->vsp_r13 = xpGPR(xp, vsp);
  pr->save7_r24 = xpGPR(xp, save7);
  pr->save6_r25 = xpGPR(xp, save6);
  pr->save5_r26 = xpGPR(xp, save5);
  pr->save4_r27 = xpGPR(xp, save4);
  pr->save3_r28 = xpGPR(xp, save3);
  pr->save2_r29 = xpGPR(xp, save2);
  pr->save1_r30 = xpGPR(xp, save1);
  pr->save0_r31 = xpGPR(xp, save0);
}


/* Note: CURRENT_VS (CURRENT_TS) is always either the area containing the
  current value of VSP (TSP) or an older area.
  */

/*
  Find or create a new VSP segment. Copy the top-most stack frame to it
  */

OSStatus
do_vsp_overflow (ExceptionInformation *xp, BytePtr addr)
{
#ifdef SUPPORT_PRAGMA_UNUSED
#pragma unused(addr)
#endif
  area *first_a = (area *) lisp_global(CURRENT_VS);
  area *a, *new_a = NULL, *maybe_new_a = NULL;
  pc where = xpPC(xp);
  opcode instruction = *where;
  unsigned vsp_reg = RA_field(instruction);   /* the "VSP" register for the instruction causing the trap */
  BytePtr vspPtr = (BytePtr) xpGPR(xp, vsp_reg);
  BytePtr real_vsp = (BytePtr) xpGPR(xp, vsp);
  BytePtr new_vsp;
  lisp_frame *spPtr = find_non_catch_frame_from_xp(xp), *cf_ptr;
  BytePtr savevsp = (BytePtr) spPtr->savevsp;
  int size, frame_size;
  preserved_registers pr;

  sample_preserved_registers(xp, &pr);

  if (xpGPR(xp, rnil) != lisp_nil) {
    Bug("VSP overflow in non-lisp context");
  };

  for (a = first_a; a && ((a->low > savevsp) || (a->high < savevsp)); a = a->older) {
  };
  if (!a) Bug("Can't find savevsp area");

  if (vsp_reg != vsp) {
    for (a = first_a; a && ((a->low > real_vsp) || (a->high < real_vsp)); a = a->older) {
    };
    /* Might have overflowed once already while sliding the stack.
       This could leave the real_vsp pointing at a younger stack frame:
       (let ((x (make-list 5000))) (time (apply 'foo x))) then proceed through the stack overflows */
    if (!a) {
      for (a = first_a->younger; a && ((a->low > real_vsp) || (a->high < real_vsp)); a = a->younger) {
      };
    };
    if (!a) {
      Bug("Can't find real_vsp area");
    };
  };

  for (a = first_a; a && ((a->low > vspPtr) || (a->high < vspPtr)); a = a->older) {
  };
  if (!a) Bug("Can't find VSP area");

  /* May have already extended the stack once, in which case the saved VSP is in another segment */
  if ((a->low > savevsp) || (a->high < savevsp))
    savevsp = a->high;

  frame_size = savevsp - vspPtr;
  size = align_to_power_of_2(512 + frame_size, 12);      /* Leave some space in the new segment */
  if (STACK_SEGMENT_SIZE > size)
    size = STACK_SEGMENT_SIZE;

  /* Look for an existing segment that's big enough.
     If the register being stored through is not VSP, then we're
     in one of the tXXXslide subprims, copying from another segment,
     so we have to be careful not to use the VSP segment.
     Also need to be careful not to use a segment that contains part of the db_link chain
     (may be left from a previous tXXXslide).
      */
  for (maybe_new_a = a->younger; maybe_new_a != NULL; maybe_new_a = maybe_new_a->younger) {
    int a_size = maybe_new_a->high - maybe_new_a->softlimit;
    if ((size <= a_size) &&
	((vsp_reg == vsp) || (real_vsp < maybe_new_a->low) || (real_vsp > maybe_new_a->high)) &&
	!db_link_chain_in_area_p(maybe_new_a)) {
      area *prev_a = maybe_new_a->younger;
      area *next_a = maybe_new_a->older;
      new_a = maybe_new_a;
      if (next_a != a) {
        if (prev_a)
          prev_a->older = next_a;
        if (next_a)
          next_a->younger = prev_a;
        prev_a = a->younger;
        prev_a->older = new_a;
        new_a->younger = prev_a;
        new_a->older = a;
        a->younger = new_a;
      };
      break;
    }
  };

  /* If no existing segment, allocate a new one */
  if (! new_a) {
    area *prev_a = a->younger;
    new_a = allocate_area_with_c_gc_context(xp, allocate_vstack, size);
    if (! new_a)
      return do_hard_stack_overflow(xp, NULL, NULL);
    if (prev_a) {
      prev_a->older = new_a;
      new_a->younger = prev_a;
    }
    new_a->older = a;
    a->younger = new_a;
  };

  lisp_global(CURRENT_VS) = (LispObj) new_a;
  a->active = vspPtr;
  new_vsp = new_a->high - frame_size;
  BlockMoveData(vspPtr, new_vsp, frame_size);
  xpGPR(xp, vsp_reg) = (LispObj) new_vsp;
  new_a->active = new_vsp;              /* Not really necessary */
  
  /* If current instruction's an STMW, there would have been a preceding
     (la vsp -n vsp), which is really an (addi vsp -n vsp) instruction ...
     "emulate" the STMW so that if a GC happens during handle_error, this
     part of the stack is initialized. */
  if ((major_opcode_p(instruction, 47)) &&
      (D_field(instruction) == 0)) {
    /* (stmw rs 0 vsp) */
    LispObj *vspP = (LispObj *) new_vsp;
    unsigned reg = RS_field(instruction);

    a->active = vspPtr + (4 * (32 - reg));         /* Ignore the (la vsp -n vsp) in the old segment */
    
    for (; reg < 32; reg++) {
      *vspP++ = xpGPR(xp, reg);
    }
  };

  /* Update the VSP in any moved catch frames so that throwing will stay in the new stack segment.
     This is important since otherwise after the throw we'll see old values of variables.
     Sometimes a catch frame is already in the new_vsp segment (if an overflow has
     already happenned).
     */
  {
    unsigned diff = new_vsp - vspPtr;
    unsigned high = (unsigned) new_a->high;
    for (cf_ptr = (lisp_frame *) xpGPR(xp, sp); cf_ptr != spPtr; cf_ptr = cf_ptr->backlink) {
      if (cf_ptr->savelr !=0) {		/*  ppc-ff-call frame if NULL (invalid savevsp) */
        unsigned catch_vsp = ((unsigned) cf_ptr->savevsp);
        if (catch_vsp && ((catch_vsp < ((unsigned) new_vsp)) || (catch_vsp > high))) {
          catch_vsp += diff;
          if ((catch_vsp < ((unsigned) new_vsp)) || (catch_vsp > high)) {
            Bug("Can't relocate catch or lexpr frame VSP");
          } else {
            cf_ptr->savevsp = (LispObj) catch_vsp;
          }
        }
      }
    }
  }
  
  /* Don't signal an error if we found an existing segment.
     This is important for stack group switch.
     Otherwise we might signal an error during the call to YieldToThread
     at a time when Lisp code cannot run.
     If vsp_reg is not vsp, then we're sliding from a segment that is
     about to be replaced by the one that we just allocated. In this case,
     Lisp has already approved the stack extension. Calling lisp there is
     also dangerous since a GC might free the stack frame being copied from.
     */
  if ((maybe_new_a == NULL) && (vsp_reg == vsp) &&
      ((((unsigned) nrs_GC_EVENT_STATUS_BITS.vcell) & gc_allow_stack_overflows_bit) == 0)) {
    handle_error(xp, error_stack_overflow, vsp, 0, (unsigned) xpPC(xp));
  };
  
  return 0;                     /* if we ever return. */
}

OSStatus
do_tsp_overflow (ExceptionInformation *xp, BytePtr addr)
{
  area *first_a = (area *) lisp_global(CURRENT_TS);
  area *a = first_a, *new_a, *maybe_new_a;
  BytePtr tspPtr = (BytePtr) xpGPR(xp, tsp);
  LispObj rnil_value = xpGPR(xp, rnil);
  int frame_size = tspPtr - addr;
  BytePtr new_tsp;
  pc where = xpPC(xp);
  opcode instruction = *where;

  preserved_registers pr;

  sample_preserved_registers(xp, &pr);

  if ((rnil_value != lisp_nil) && ((unsigned) rnil_value) != (((unsigned) lisp_nil) - 1)) {
    Bug("TSP overflow in non-lisp context");
  }

  if ((frame_size > 4096) || (frame_size < 0)) {
    Bug("TSP frame size out of range");
  };

  for (; a && ((a->low > tspPtr) || (a->high < tspPtr)); a = a->older) {
  };
  if (!a)
    Bug("Can't find TSP area");

  new_a = maybe_new_a = a->younger;

  /* If no existing segment, allocate a new one */
  if (! new_a) {
    new_a = allocate_area_with_c_gc_context(xp, allocate_tstack, STACK_SEGMENT_SIZE);
    if (! new_a)
      return do_hard_stack_overflow(xp, NULL, NULL);
    new_a->older = a;
    a->younger = new_a;
  };

  lisp_global(CURRENT_TS) = (LispObj) new_a;
  a->active = tspPtr;
  new_tsp = new_a->high - frame_size;
  
  /* Emulate current instruction, which must be a stwu or stwux */
  if ((major_opcode_p(instruction, 37) ||                /* stwu */
       X_opcode_p(instruction, 31, 183)) &&              /* stwux */
      (RA_field(instruction) == tsp)) {
    /* (stwu rs D tsp) or (stwux rs tsp rb) */
    LispObj *tspP = (LispObj *) new_tsp;
    unsigned reg = RS_field(instruction);

    *tspP = xpGPR(xp, reg);
    xpPC(xp) += 1;
  } else {
    Bug("Instruction causing TSP overflow not stwu or stwux");
  };

  /* Update the tsp. This must happen after the stwu has been emulated, so the
     link will work correctly
     */
  xpGPR(xp, tsp) = (LispObj) new_tsp;
  new_a->active = new_tsp;              /* Not really necessary */

  /* Don't signal an error if we found an existing segment.
     Unlike the VSP, this is not functionally important, but
     it has a noticeable performance impact.
     Also, don't signal an error if nilreg is not NIL. This happens
     when .SPcallback allocates a TSP frame to save the C saved registers.
     */
  if ((maybe_new_a == NULL) && (xpGPR(xp, rnil) == lisp_nil) &&
      ((((unsigned) nrs_GC_EVENT_STATUS_BITS.vcell) & gc_allow_stack_overflows_bit) == 0)) {
    handle_error(xp, error_stack_overflow, tsp, 0, (unsigned) xpPC(xp));
  };
  
  return 0;                     /* if we ever return. */
}

OSStatus
do_soft_stack_overflow(ExceptionInformation *xp, protected_area_ptr prot_area, BytePtr addr)
{
  /* Trying to write into a guard page on the vstack or tstack.
     Allocate a new stack segment, emulate stwu and stwux for the TSP, and
     signal an error_stack_overflow condition.
      */
  lisp_protection_kind which = prot_area->why;
  Boolean on_TSP = (which == kTSPsoftguard);

  if (on_TSP) {
    return do_tsp_overflow(xp, addr);
   } else {
    return do_vsp_overflow(xp, addr);
   }
}

OSStatus
do_spurious_wp_fault(ExceptionInformation *xp, protected_area_ptr area, BytePtr addr)
{
#ifdef SUPPORT_PRAGMA_UNUSED
#pragma unused(xp,area,addr)
#endif
  return -1;
}



static
ExceptionHandler 
  /* installed_exception_handler = NULL, */
  prev_exception_handler = NULL;





OSStatus
PMCL_exception_handler(ExceptionInformation *xp)
{
  int xnum = xp->theKind;
  OSStatus ret = -1;

  if (IS_MEMORY_EXCEPTION(xnum)) {
    ret = handle_protection_violation(xp);
  } else {
    if ((xnum == kIllegalInstructionException) || (xnum == kTrapException)) {
      pc program_counter = xpPC(xp);
      opcode instruction = *program_counter;
      
      if (IS_UUO(instruction)) {
	ret = handle_uuo(xp, instruction, program_counter);
      } else {
	if ((xnum == kTrapException) &&
	    is_conditional_trap(instruction)) {
	  ret = handle_trap(xp, instruction, program_counter);
	}
      }
    }
  }
  if (ret != noErr) {
    char buf[128];

    sprintf(buf, "Unhandled exception of type %d at 0x%08x", xnum, xpPC(xp));
    ret = lisp_Debugger(xp, debug_entry_exception, buf);
  }
  return ret;
}

void
adjust_exception_pc(ExceptionInformation *xp, int delta)
{
  xp->machineState->PC.lo += delta;
}

OSStatus
handle_xalloc(ExceptionInformation *xp, unsigned rt, unsigned ra, unsigned rb, Boolean bump)
{
  /* If rt is rzero, this means "do a GC or purify now."
     If ra is rzero, do a GC, otherwise call "purify", then:
     if rb is rzero, return; otherwise, write a PEF image
     to the (open) refnum whose boxed value is in rb.
     Otherwise, we're trying to allocate something >32KB; we may
     or may not be able to do so and may or may not have to GC
     to do so. */
  
  area *a = active_dynamic_area;
  Boolean egc_was_enabled = (a->older != NULL);
  

  if (rt == rzero) {
    if (egc_was_enabled) {
      egc_control(false, (BytePtr) xpGPR(xp, freeptr));
    }
    gc_from_xp(xp);
    if (ra != rzero) {
      if (ra == vsp) {          /* %save-library */
        extern unsigned next_libnum;
        OSErr err = -50;
        char libname[64], *src;
        int i, tag, subtag, elements, refnum = (int) (xpGPR(xp, rb));
        LispObj 
          *firstobj = (LispObj *) xpGPR(xp, arg_y), 
          *lastobj = (LispObj *) xpGPR(xp, arg_z),
          namestr = xpGPR(xp, arg_x),
          header;
        unsigned libnum = next_libnum;

        tag = fulltag_of(namestr);
        if (tag == fulltag_misc) {
          header = deref(namestr, 0);
          subtag = header_subtag(header);
          elements = header_element_count(header);
          if ((subtag == subtag_simple_base_string) &&
              (elements < 64)) {
            src = ((char *) namestr)+misc_data_offset;
            for (i = 0; i < elements; i++) {
              libname[i] = src[i];
            }
            libname[elements] = 0;
            err = noErr;
            if (firstobj == (LispObj *) lisp_nil) {
              firstobj = (LispObj *) a->low;
            } else {
              firstobj = (LispObj *) untag((LispObj)firstobj);
              if (firstobj < ((LispObj *) (a->low))) {
                err = -50;
              }
            }
            if (lastobj == (LispObj *)lisp_nil) {
              lastobj = (LispObj *) a->active;
            } else {
              lastobj = (LispObj *) untag((LispObj)lastobj);
              if (lastobj > ((LispObj *) (a->active))) {
                err = -50;
              }
            }
          }
          if (err == noErr) {
            err = lib_purify(xp, libname, firstobj, lastobj);
            gc_from_xp(xp);
            if (err == noErr) {
              extern OSErr save_library(short, unsigned, unsigned *);
              unsigned version;

              err = save_library((short)refnum, libnum, &version);
              if (err == noErr) {
                xpGPR(xp, imm1) = version;
              }
            }
          }
        }
        xpGPR(xp, imm0) = (err << fixnumshift); 
      } else {
        purify(xp);
        gc_from_xp(xp);
        if (rb != 0) {
          int refnum = ((int) (xpGPR(xp, rb))) >> fixnumshift;
          OSErr err;
          extern OSErr save_application(short);
          
          err = save_application((short) refnum);
          if (err == noErr) {
            exit(0);
          }
          fatal_oserr("\p: save_application", err);
        }
      }
    }
    if (egc_was_enabled) {
      egc_control(true, NULL);
    }
  } else {
    BytePtr curfree = (BytePtr) xpGPR(xp,initptr), probe;
    protected_area_ptr hardprot = a->hardprot;
    unsigned 
      have = (((BytePtr)lisp_global(HEAP_LIMIT)) - curfree),
      total,
      need;
      
    if (rt != rnil) {
      return -1;
    }
    
    probe = (BytePtr)xpGPR(xp,freeptr);
    need = probe - (BytePtr)xpGPR(xp,initptr);
    xpGPR(xp,freeptr) = xpGPR(xp,initptr);
    
    if (tenured_area) {

      total = (hardprot->start - tenured_area->low);
    }
    need = (need+7)&~7;
    if ((need >= have) && (need <= total)) {
      a->active = curfree;
      /* If we need to do so, force a full gc */
      if (probe > a->high) {
        untenure_from_area(tenured_area);
      }
      gc_from_xp(xp);           /* may retenure everything */
      curfree = a->active;
      have = hardprot->start-curfree;
    }
    if (need <= have) {
      BytePtr newfree = curfree+need;

      xpGPR(xp, initptr) = (LispObj) curfree;
      xpGPR(xp, freeptr) = (LispObj) newfree;
      if ((LispObj)newfree > lisp_global(HEAP_LIMIT)) {
        set_heap_limit(xp,((BytePtr)align_to_power_of_2((LispObj)newfree,log2_heap_segment_size)));
      }
    } else {
      handle_error(xp, error_alloc_failed, rnil, 0, (unsigned) xpPC(xp));
    }
  }
  if (bump) {
    adjust_exception_pc(xp,4);
  }
  return noErr;
}

void
pseudo_xalloc(unsigned the_uuo, ExceptionInformation *xp)
{
  unsigned
    rt = 0x1f & (the_uuo >> 21),
    ra = 0x1f & (the_uuo >> 16),
    rb = 0x1f & (the_uuo >> 11);

  handle_xalloc(xp, rt, ra, rb, false);
}
 


/* 
  This wants to scan backwards until "where" points to an instruction
   whose major opcode is either 63 (double-float) or 59 (single-float)
*/

OSStatus
handle_fpux_binop(ExceptionInformation *xp, unsigned where)
{
  OSStatus err;
  unsigned *there = (unsigned *) where, instr, errnum;
  int i = TRAP_LOOKUP_TRIES, delta = 0;
  
  while (i--) {
    instr = *--there;
    delta -= 4;
    if (codevec_hdr_p(instr)) {
      return -1;
    }
    if (major_opcode_p(instr, major_opcode_FPU_DOUBLE)) {
      errnum = error_FPU_exception_double;
      break;
    }

    if (major_opcode_p(instr, major_opcode_FPU_SINGLE)) {
      errnum = error_FPU_exception_short;
      break;
    }
  }
  
  err = handle_error(xp, errnum, rnil, 0, (unsigned) there);
  /* Yeah, we said "non-continuable".  In case we ever change that ... */
  
  adjust_exception_pc(xp, delta);
  xp->FPUImage->FPSCR &= 0x03fff;
  
  return err;

}

UInt32 gMPCounter = 0;

OSStatus
handle_uuo(ExceptionInformation *xp, opcode the_uuo, pc where) 
{
#ifdef SUPPORT_PRAGMA_UNUSED
#pragma unused(where)
#endif
  unsigned 
    minor = UUO_MINOR(the_uuo),
    rt = 0x1f & (the_uuo >> 21),
    ra = 0x1f & (the_uuo >> 16),
    rb = 0x1f & (the_uuo >> 11),
    errnum = 0x3ff & (the_uuo >> 16);

  OSStatus status = -1;

  int bump = 4;

  switch (minor) {
  case UUO_XALLOC:
    bump = 0;
    status = handle_xalloc(xp, rt, ra, rb, true);
    break;

  case UUO_FIXNUM_OVERFLOW:
    status = fix_fixnum_overflow(xp, rt, ra);
    break;

  case UUO_BOX_SIGNED:
    status = box_signed_integer(xp, rt, ra);
    break;
    
  case UUO_BOX_UNSIGNED:
    status = box_unsigned_integer(xp, rt, ra);
    break;
    
  case UUO_ADD_FIXNUMS:
    status = add_fixnums(xp, rt, ra, rb);
    break;
    
  case UUO_SUB_FIXNUMS:
    status = sub_fixnums(xp, rt, ra, rb);
    break;

  case UUO_INTERR:
    status = handle_error(xp, errnum, rb, 0, (unsigned) where);
    break;

  case UUO_INTCERR:
    status = handle_error(xp, errnum, rb, 1, (unsigned) where);
    break;

  case UUO_FPUX_BINOP:
    status = handle_fpux_binop(xp, (unsigned)where);
    bump = 0;
    break;

  default:
    status = -1;
    bump = 0;
  }
  
  if ((!status) && bump) {
    adjust_exception_pc(xp, bump);
  }
  return status;
}

unsigned
register_codevector_contains_pc (unsigned lisp_function, unsigned where)
{
  unsigned code_vector, size;

  if ((fulltag_of(lisp_function) == fulltag_misc) &&
      (header_subtag(header_of(lisp_function)) == subtag_function)) {
    code_vector = deref(lisp_function, 1);
    size = header_element_count(header_of(code_vector)) << 2;
    if ((untag(code_vector) < where) && (where < (code_vector + size)))
      return(code_vector);
  }

  return(0);
}

/* Callback to lisp to handle a trap. Need to translate the
   PC (where) into one of two forms of pairs:

   1. If PC is in fn or nfn's code vector, use the register number
      of fn or nfn and the index into that function's code vector.
   2. Otherwise use 0 and the pc itself
*/
void
callback_for_trap (LispObj callback_macptr, ExceptionInformation *xp, unsigned where,
                   unsigned arg1, unsigned arg2, unsigned arg3)
{
  unsigned code_vector = register_codevector_contains_pc(xpGPR(xp, fn), where);
  unsigned register_number = fn;
  unsigned index = where;
  if (code_vector == 0) {
    register_number = nfn;
    code_vector = register_codevector_contains_pc(xpGPR(xp, nfn), where);
  }
  if (code_vector == 0)
    register_number = 0;
  else
    index = (where - (code_vector + misc_data_offset)) >> 2;
  callback_to_lisp(callback_macptr, xp, register_number, index, arg1, arg2, arg3);
}

void
callback_to_lisp (LispObj callback_macptr, ExceptionInformation *xp,
                  unsigned arg1, unsigned arg2, unsigned arg3, unsigned arg4, unsigned arg5)
{
  xframe_list xframe_link;
  unsigned  callback_ptr, i;
  LispObj saved_registers[8];
  area *a;

  /* Put the active stack pointer where .SPcallback expects it */
  a = (area *) lisp_global(CURRENT_CS);
  a->active = (BytePtr) xpGPR(xp, sp);

  /* Copy globals from the exception frame to nilreg globals */
  lisp_global(SAVE_FREEPTR) = (LispObj) xpGPR(xp, freeptr);
  lisp_global(SAVE_VSP) = (LispObj) xpGPR(xp, vsp);
  lisp_global(SAVE_TSP) = (LispObj) xpGPR(xp, tsp);

  /* Link the exception frame into the xframe list */
  xframe_link.this = xp;
  xframe_link.prev = (xframe_list *) lisp_global(XFRAME);
  lisp_global(XFRAME) = (LispObj) &xframe_link;

  /* pass the saved registers to .SPcallback 
     It would be nice to just push these on the VSP, but how would we handle overflow? */
  for (i = 0; i < 8; i++) {
    saved_registers[i] = (LispObj) xpGPR(xp, save0-i);
  }
  lisp_global(EXCEPTION_SAVED_REGISTERS) = (LispObj) saved_registers;

  /* Call back.
     Lisp will handle trampolining through some code that
     will push lr/fn & pc/nfn stack frames for backtrace.
     16320 = (make-proc-info '(:ptr :long :long :long :long :long) nil)  actually isn't, it's 262080 */
  callback_ptr = ((macptr *)(untag(callback_macptr)))->address;
#ifndef CARBON /* carbon case pukes here  dunno why - COMPILER THINKS TOC IS PRESERVED */
  CallUniversalProc((UniversalProcPtr)(callback_ptr), 262080, xp, arg1, arg2, arg3, arg4, arg5);
#else
  /* DebugStr("\pphoo"); */
#ifdef PMCL_OSX_NATIVE_KERNEL  
  call_cfm_proc(UPP_CFM_PROC(callback_ptr), xp,arg1,arg2,arg3,arg4,arg5);
#else
  ourcallupp2((UniversalProcPtr)(callback_ptr), 262080, xp, arg1, arg2, arg3, arg4, arg5);
#endif
#endif

  /* Unlink the exception frame from the xframe list */
  lisp_global(XFRAME) = (LispObj) xframe_link.prev;

  /* Copy GC registers back into exception frame */
  xpGPR(xp, initptr) = xpGPR(xp, freeptr) = lisp_global(SAVE_FREEPTR);
}

area *
allocate_no_stack (unsigned size)
{
#ifdef SUPPORT_PRAGMA_UNUSED
#pragma unused(size)
#endif

  return (area *) NULL;
}

extern OSErr xNewThread(ThreadStyle, ThreadEntryProcPtr, void *, Size, ThreadOptions, void **, ThreadID *);
extern OSErr xDisposeThread (ThreadID, void *, Boolean);
extern OSErr kernel_xYieldToThread (ThreadID);




/* Here is where we start up on the new thread after a control stack overflow. */
voidPtr *cs_stack_switch_startup(void *threadParam)
{
#ifdef SUPPORT_PRAGMA_UNUSED
#pragma unused(threadParam)
#endif

  LispObj callback_macptr;
  unsigned callback_ptr, i;
  int interrupt_level;
  area *a;
  xframe_list *xf;
  ExceptionInformation *xp;
  LispObj saved_registers[8];

  /* DebugStr("\pin-stack-switch"); */

  for (;;) {

    callback_macptr = nrs_CS_OVERFLOW_CALLBACK.vcell;
    callback_ptr = ((macptr *)(untag(callback_macptr)))->address;
    a = (area *) lisp_global(CURRENT_CS);

    /* The LAP code (cs-overflow-callback) will install the new cs area.
       We need to keep the old one for now so that the callback code will
       store the correct frame pointer to the old stack frame */
    lisp_global(CS_OVERFLOW_LIMIT) = (LispObj) 0;

    /* pass the saved registers to .SPcallback  */
    xf = (xframe_list *) lisp_global(XFRAME);
    xp = xf->this;
    for (i = 0; i < 8; i++) {
      saved_registers[i] = (LispObj) xpGPR(xp, save0-i);
    }
    lisp_global(EXCEPTION_SAVED_REGISTERS) = (LispObj) saved_registers;

    /* Decrement *interrupt-level* so that callback will initially operate
       without-interrupts. %cs-overflow-callback will increment it again. */
    interrupt_level = ((int) nrs_INTERRUPT_LEVEL.vcell) - (2 << fixnumshift);
    if (interrupt_level >= 0) interrupt_level = (-1 << fixnumshift);
    nrs_INTERRUPT_LEVEL.vcell = (LispObj) interrupt_level;

    /* Don't signal stack overflow errors for VSP & TSP overflows
       until the Lisp code clears this bit */
    nrs_GC_EVENT_STATUS_BITS.vcell |= gc_allow_stack_overflows_bit;

    /* Lisp code does most of the work */
#ifndef CARBON
    CallUniversalProc((UniversalProcPtr)(callback_ptr), 0);
#else
#ifdef PMCL_OSX_NATIVE_KERNEL
    call_cfm_proc(UPP_CFM_PROC(callback_ptr),0);
#else
    ourcallupp2((UniversalProcPtr)(callback_ptr), 0);
#endif
#endif

    /* The lisp code has returned. Just need to reinstall the cs-area and
       set the active area of the new cs_area to empty and we can switch back
       to the other thread */
    lisp_global(CURRENT_CS) = (LispObj) a;
    lisp_global(CS_OVERFLOW_LIMIT) = (LispObj) a->softlimit;
    a->younger->active = a->younger->high;
    nrs_INTERRUPT_LEVEL.vcell = (LispObj) (interrupt_level + (2 << fixnumshift));
    kernel_xYieldToThread (area_ptr_threadID(a)); 

  }
}

#ifdef CARBON
MPTaskID  gMPTaskID		= kInvalidID; /* the task that serves exceptions */

MPQueueID gMPQueueID		= kInvalidID;
#endif

ProcPtr threadentryupp = NULL;
void 
install_threadentryupp (void)
{
#ifndef CARBON
  threadentryupp = (ProcPtr)cs_stack_switch_startup;
#else
 threadentryupp = (ProcPtr) NewThreadEntryUPP((ThreadEntryProcPtr)cs_stack_switch_startup);
#endif
}




area *
allocate_cstack (unsigned size)
{
  ThreadID threadMade;
  area *new_area;
  extern area *register_cstack(BytePtr, unsigned);

  size = ((size+4095)&(~4095));
  if (noErr == xNewThread(kCooperativeThread,          /* threadStyle */
                          (ThreadEntryProcPtr)threadentryupp,
                            
                          NULL,                        /* threadParam */
                          size,                        /* stackSize */
                          kCreateIfNeeded,             /* options */
                          NULL,                        /* threadResult */
                          &threadMade))                /* threadMade */
    {
    new_area = register_cstack(NULL, 0);             
    if (new_area == NULL) {
      xDisposeThread(threadMade, NULL, false);
      return(NULL);
    };
#ifndef PMCL_OSX_NATIVE_KERNEL
    if (is_osx())  /* current osx bug requires this */
     {
      InstallExceptionHandler(installed_exception_handler);
     }
#endif
    new_area->threshold = threadMade;
    /* DebugStr("\pthreadmade"); */
/* one hopes this will not be necessary */
    return new_area;
  } else {
    return NULL;
  };
}

/* Cons up a new thread and a new control stack area.
   If successful, continue execution on the new thread,
   and when that thread switches back to this one, return true.
   If not successful, return false */
Boolean
continue_on_new_thread (ExceptionInformation *xp)
{
  xframe_list xf;
  area *cs = (area *) lisp_global(CURRENT_CS);
  area *new_cs = cs->younger;
  LispObj callback_macptr;

  callback_macptr = nrs_CS_OVERFLOW_CALLBACK.vcell;
  if (!((fulltag_of(callback_macptr) == fulltag_misc) &&
        (header_subtag(header_of(callback_macptr)) == subtag_macptr))) {
    /* No cs-overflow-callback in the Lisp, must signal an error */
    return(false);
  } else {
    /* Link the exception frame into the xframe list */
    xf.prev = (xframe_list *) lisp_global(XFRAME);
    xf.this = xp;
    lisp_global(XFRAME) = (LispObj) &xf;

    if (new_cs == NULL) {
      int cs_segment_size = unbox_fixnum(nrs_CS_SEGMENT_SIZE.vcell),
          cs_hard_overflow_size = unbox_fixnum(nrs_CS_HARD_OVERFLOW_SIZE.vcell),
          cs_soft_overflow_size = unbox_fixnum(nrs_CS_SOFT_OVERFLOW_SIZE.vcell);
      int stack_size = cs_segment_size + cs_hard_overflow_size + cs_soft_overflow_size;
      new_cs = allocate_area_with_c_gc_context(xp, allocate_cstack, (unsigned) stack_size);
      if (new_cs != NULL) {
        cs->younger = new_cs;
        new_cs->older = cs;
      }
    } else {
      /* Copy registers from xp to lisp globals */
      allocate_area_with_c_gc_context(xp, allocate_no_stack, 0);
    };

    /* Switch to the new thread */
    if (new_cs != NULL) {
#if 0
      if (is_osx()) {
        debugf("yielding to id %x.", area_ptr_threadID(new_cs));
        } 
#endif
      kernel_xYieldToThread(area_ptr_threadID(new_cs));
    }

    /* Unlink the exception frame from the xframe list */
    lisp_global(XFRAME) = (LispObj) xf.prev;

    return (new_cs != NULL);
  }
}

/* callback to (symbol-value cmain) if it is a macptr, 
   otherwise report cause and function name to console.
   Returns noErr if exception handled OK */
OSStatus
handle_trap(ExceptionInformation *xp, opcode the_trap, pc where)
{
  unsigned  instr, err_arg1 = 0, err_arg2 = 0, err_arg3 = 0;
  int       ra, rs, fn_reg = 0;
  char *    error_msg = nil;
  char      name[kNameBufLen];
  LispObj   cmain = nrs_CMAIN.vcell;
  Boolean   event_poll_p = false;

  /* If we got here, "the_trap" is either a TWI or a TW instruction.
     It's a TWI instruction iff its major opcode is major_opcode_TWI. */

  /* If it's a "twllt" instruction where RA == sp, it's a failed 
     control stack overflow check.  In that case:
     
     a) We're in "yellow zone" mode if the value of the lisp_global(CS_OVERFLOW_LIMIT)
     is 0xfffffff8.  If we're not already in yellow zone mode, attempt to create
     a new thread and continue execution on its stack. If that fails, call
     signal_stack_soft_overflow to enter yellow zone mode and signal the condition to lisp.
     
     b) If we're already in "yellow zone" mode, then:
     
     1) if the SP is past the current control-stack area's hard overflow limit,
     signal a "hard" stack overflow error (e.g., throw to toplevel as quickly as
     possible. If we aren't in "yellow zone" mode, attempt to continue on another
     thread first.
     
     2) if SP is "well" (> 4K) below its soft overflow limit, set lisp_global(CS_OVERFLOW_LIMIT)
     to its "real" value.  We're out of "yellow zone mode" in this case.
     
     3) Otherwise, do nothing.  We'll continue to trap every time something gets pushed
     on the control stack, so we should try to detect and handle all of these cases
     fairly quickly.  Of course, the trap overhead is going to slow things down quite a bit.
     */

  if (X_opcode_p(the_trap,major_opcode_X31,minor_opcode_TW) &&
      (RA_field(the_trap) == sp) &&
      (TO_field(the_trap) == TO_LO)) {
    area 
      *CS_area = (area *) lisp_global(CURRENT_CS);
      
    unsigned 
      current_SP = xpGPR(xp,sp);
    /* debugf("cs-overflow sp %x", current_SP); */

    if (current_SP  < (unsigned) (CS_area->hardlimit)) {
      /* If we're not in soft overflow mode yet, assume that the
         user has set the soft overflow size very small and try to
         continue on another thread before throwing to toplevel */
      if (lisp_global(CS_OVERFLOW_LIMIT == 0xfffffff8) ||
          !continue_on_new_thread(xp)) {
        reset_lisp_process(xp);
      }
    } else {
      if (lisp_global(CS_OVERFLOW_LIMIT) == 0xfffffff8) {
        /* If the control stack is at least 4K away from its soft limit,
           stop trapping.  Else keep trapping. */
        if (current_SP > (unsigned) ((CS_area->softlimit)+4096)) {
          lisp_global(CS_OVERFLOW_LIMIT) = (LispObj) (CS_area->softlimit);
        }
      } else {
        if (!continue_on_new_thread(xp)) {
          signal_stack_soft_overflow(xp, sp);
        }
      }
    }
    
    adjust_exception_pc(xp, 4);
    return noErr;
  }  else {
    if (the_trap == LISP_BREAK_INSTRUCTION) {
      char *message =  (char *) xpGPR(xp,3);
      set_xpPC(xp, xpLR(xp));
      if (message == NULL) {
	message = "Lisp Breakpoint";
      }
      lisp_Debugger(xp, debug_entry_dbg, message);
      return noErr;
    }

    if ((fulltag_of(cmain) == fulltag_misc) &&
        (header_subtag(header_of(cmain)) == subtag_macptr)) {
      /* cmain is a macptr, we can call back to lisp */
      if (the_trap == TWI_instruction(TO_GT,nargs,0)) {
        /* Disable interrupts if we're about to process one */
        event_poll_p = true;    /* remember to turn interrupts back on */
        nrs_INTERRUPT_LEVEL.vcell = (-1 << fixnumshift);
      }
      callback_for_trap(cmain, xp, (unsigned) where, (unsigned) the_trap, 0, 0);
      if (event_poll_p) {
        nrs_INTERRUPT_LEVEL.vcell = 0;
      }
      adjust_exception_pc(xp, 4);
      return(noErr);
    }
    return -1;
  }
}


/* Look at up to TRAP_LOOKUP_TRIES instrs before trap instr for a pattern.
   Stop if subtag_code_vector is encountered. */
unsigned
scan_for_instr( unsigned target, unsigned mask, pc where )
{
  int i = TRAP_LOOKUP_TRIES;

  while( i-- ) {
    unsigned instr = *(--where);
    if ( codevec_hdr_p(instr) ) {
      return 0;
    } else if ( match_instr(instr, mask, target) ) {
      return instr;
    }
  }
  return 0;
}



void non_fatal_error( char *msg )
{ 
#ifdef CARBON
 debugf ("Non-fatal error: %s.\n", msg );
#else
  DebugStr ("\pNon-fatal");
  fprintf( stderr, "Non-fatal error: %s.\n", msg );
  fflush( stderr );
#endif
}

/* The main opcode.  */

int 
is_conditional_trap(opcode instr)
{
  unsigned to = TO_field(instr);
  int is_tw = X_opcode_p(instr,major_opcode_X31,minor_opcode_TW);

  if (instr == LISP_BREAK_INSTRUCTION) {
    return 1;
  }
  if (is_tw || major_opcode_p(instr,major_opcode_TWI)) {
    /* A "tw" or "twi" instruction.  To be unconditional, the EQ bit must be set
       in the TO mask and either the register operands (if "tw") are the same or
       either both of the signed or both of the unsigned inequality bits
       must be set. */
    if (! (to & TO_EQ)) {
      return 1;			/* Won't trap on EQ: conditional */
    }
    if (is_tw && (RA_field(instr) == RB_field(instr))) {
      return 0;			/* Will trap on EQ, same regs: unconditional */
    }
    if (((to & (TO_LO|TO_HI)) == (TO_LO|TO_HI)) || 
	((to & (TO_LT|TO_GT)) == (TO_LT|TO_GT))) {
      return 0;			/* Will trap on EQ and either (LT|GT) or (LO|HI) : unconditional */
    }
    return 1;			/* must be conditional */
  }
  return 0;			/* Not "tw" or "twi".  Let debugger have it */
}

OSStatus
handle_error(ExceptionInformation *xp, unsigned errnum, unsigned rb, unsigned continuable, unsigned where)
{
  LispObj   pname;
  LispObj   errdisp = nrs_ERRDISP.vcell;

  if ((fulltag_of(errdisp) == fulltag_misc) &&
      (header_subtag(header_of(errdisp)) == subtag_macptr)) {
    /* errdisp is a macptr, we can call back to lisp */
    callback_for_trap(errdisp, xp, where, errnum, rb, continuable);
    return(0);
    }

  return (-1);
}
	       
/*
ProcPtr our_NewExceptionHandlerUPP = NULL;
ProcPtr our_InstallExceptionHandler = NULL;
*/

/* ifdef carbon look for Installexceptionhandler in carbonLib - is there in 1.1d12 - previously not */
#ifdef CARBON
#ifndef PMCL_OSX_NATIVE_KERNEL
extern OSErr aligned_exception_handler(ExceptionInformation *);
void
install_pmcl_exception_handlers()
{ ExceptionHandler exception_handler = (ExceptionHandler) aligned_exception_handler;
  /* OSErr err;
  Str255 errmsg;
  Ptr mainaddr;
  CFragConnectionID lib_connection;
  CFragSymbolClass sclass; */
 /* DebugStr("\pin install_pmcl_exception_handlers"); */
  
 /* if newexceptionhandlerupp exists (carbonlib 1.1d12) then call it, else don't */
 /* to heck with it - assume a recent enough version of CarbonLib */
  
  
 exception_handler = (ExceptionHandler)NewExceptionHandlerUPP((ExceptionHandlerProcPtr)exception_handler);
 prev_exception_handler  =  (ExceptionHandler)InstallExceptionHandler(exception_handler);   
 (Ptr)installed_exception_handler = (Ptr)exception_handler;
 
}
#else
/* Use Mach exception handling */

extern Boolean running_under_rosetta(void);

void
install_pmcl_exception_handlers()
{
  void install_mach_exception_handler(ExceptionHandler);

  if (false && (!running_under_rosetta())) {
    install_mach_exception_handler(PMCL_exception_handler);
  }
}
#endif
#else

void
install_pmcl_exception_handlers()
{ prev_exception_handler = InstallExceptionHandler(PMCL_exception_handler);
  installed_exception_handler = PMCL_exception_handler;
}

#endif


void
unprotect_all_areas()
{
  protected_area_ptr p;

  for(p = AllProtectedAreas, AllProtectedAreas = NULL; p; p = p->next) {
    unprotect_area(p);
  }
}

Boolean
exception_filter_installed_p()
{
  return true;
#if 0
  return installed_exception_filter == PMCL_exception_filter;
#endif
}

#ifdef CARBON
void
exception_cleanup()
{
  unprotect_all_areas();
#ifndef PMCL_OSX_NATIVE_KERNEL
  InstallExceptionHandler(prev_exception_handler);
#endif
#if 0
  if (exception_filter_installed_p()) {
    InstallExceptionFilter(prev_exception_filter);
  }
#endif
}
#else
void
exception_cleanup()
{
  unprotect_all_areas();
  InstallExceptionHandler(prev_exception_handler);
#if 0
  if (exception_filter_installed_p()) {
    InstallExceptionFilter(prev_exception_filter);
  }
#endif
}
#endif

void
exception_init()
{
  install_pmcl_exception_handlers();
  /* belongs elsewhere -but where? */
  install_threadentryupp();
}


void
Bug(const char *format, ...)
{
  char s[512];
  va_list args;

  va_start(args, format);
  vsprintf(s, format, args);
  lisp_Debugger(NULL, debug_entry_bug,  s);
}

void
lisp_bug(char *string)
{
  Bug("Bug in MCL-PPC system code:\n%s", string);
}

#ifdef PMCL_OSX_NATIVE_KERNEL
#define	C_REDZONE_LEN		224
#define	C_STK_ALIGN			16
#define C_PARAMSAVE_LEN		64
#define	C_LINKAGE_LEN		48
#define TRUNC_DOWN(a,b,c)  (((((unsigned)a)-(b))/(c)) * (c))
#include <mach/mach.h>
#include <mach/mach_error.h>
#include <mach/machine/thread_state.h>
#include <mach/machine/thread_status.h>
#include <mach/mig_errors.h>
#include <pthread.h>

#define MACH_CHECK_ERROR(x) if (x != KERN_SUCCESS) {abort();}

/* a distinguished UUO at a distinguished address */
extern void exception_handler_return();

boolean_t pmcl_exc_server(mach_msg_header_t *, mach_msg_header_t *);

typedef struct {
  mach_msg_header_t Head;
  /* start of the kernel processed data */
  mach_msg_body_t msgh_body;
  mach_msg_port_descriptor_t thread;
  mach_msg_port_descriptor_t task;
  /* end of the kernel processed data */
  NDR_record_t NDR;
  exception_type_t exception;
  mach_msg_type_number_t codeCnt;
  integer_t code[2];
  mach_msg_trailer_t trailer;
} exceptionRequest;

/*
  The initial function for an exception-handling thread.
*/

void *
exception_handler_proc(void *arg)
{
  mach_port_t p = (mach_port_t) arg;

  mach_msg_server(pmcl_exc_server, 256, p, 0);
  /* Should never return. */
  abort();
}

void
mach_thread_state_to_mac_xinfo(mach_port_t thread,
			       ppc_thread_state_t *ts,
			       MachineInformationPowerPC *machine_info,
			       RegisterInformationPowerPC *reg_info,
			       FPUInformationPowerPC *fpu_info,
			       VectorInformationPowerPC *vec_info)
{
  ppc_exception_state_t xs;
  ppc_vector_state_t vs;
  mach_msg_type_number_t thread_state_count;
  int i, j;

  thread_state_count = PPC_FLOAT_STATE_COUNT;
  thread_get_state(thread,
		   PPC_FLOAT_STATE,
		   (thread_state_t)fpu_info,
		   &thread_state_count);
  fpu_info->FPSCR = fpu_info->Reserved;

  thread_state_count = PPC_EXCEPTION_STATE_COUNT;
  thread_get_state(thread,
		   PPC_EXCEPTION_STATE,
		   (thread_state_t)&xs,
		   &thread_state_count);

  thread_state_count = PPC_VECTOR_STATE_COUNT;
  thread_get_state(thread,
		   PPC_VECTOR_STATE,
		   (thread_state_t)&vs,
		   &thread_state_count);

  bcopy(&vs, vec_info, 33*16);	/* vrs, vscr in common. */
  vec_info->VRsave = ts->vrsave;

  for (i = 0, j = 2; i < 32; i++, j++) {
    ((UnsignedWide *)reg_info)[i].lo = ((unsigned *)ts)[j];
  }
  
  machine_info->CTR.lo = ts->ctr;
  machine_info->LR.lo = ts->lr;
  machine_info->PC.lo = ts->srr0;
  machine_info->CRRegister = ts->cr;
  machine_info->XER = ts->xer;
  machine_info->MSR = ts->srr1;
  machine_info->MQ = ts->mq;
  machine_info->DSISR = xs.dsisr;
  machine_info->DAR.lo = xs.dar;
}

void
restore_thread_state_from_xp(mach_port_t thread, 
			     ExceptionInformation *xp,
			     ppc_thread_state_t *ts)
{
  ppc_exception_state_t xs;
  ppc_vector_state_t vs;
  int i, j;
  RegisterInformationPowerPC *regs = xp->registerImage;
  MachineInformationPowerPC *machine_info = xp->machineState;
  FPUInformationPowerPC *fpu_info = xp->FPUImage;
  VectorInformationPowerPC *vec_info = xp->vectorImage;

  fpu_info->Reserved = fpu_info->FPSCR;
  thread_set_state(thread,
		   PPC_FLOAT_STATE,
		   (thread_state_t)fpu_info,
		   PPC_FLOAT_STATE_COUNT);

  for (i = 0, j = 2; i < 32; i++, j++) {
    ((unsigned *)ts)[j] = ((UnsignedWide *)regs)[i].lo;
  }

  ts->ctr =  machine_info->CTR.lo;
  ts->lr =  machine_info->LR.lo;
  ts->srr0 =  machine_info->PC.lo;
  ts->cr =  machine_info->CRRegister;
  ts->xer =  machine_info->XER;
  ts->srr1 =  machine_info->MSR;
  ts->mq =  machine_info->MQ;

  ts->vrsave = vec_info->VRsave;

  bcopy(vec_info, &vs, 33*16);
  thread_set_state(thread,
		   PPC_FLOAT_STATE,
		   (thread_state_t)fpu_info,
		   PPC_FLOAT_STATE_COUNT);
  thread_set_state(thread,
		   PPC_VECTOR_STATE,
		   (thread_state_t)&vs,
		   PPC_VECTOR_STATE_COUNT);
  thread_set_state(thread,
		   MACHINE_THREAD_STATE,
		   (thread_state_t)ts,
		   MACHINE_THREAD_STATE_COUNT);
}

ExceptionInformationPowerPC *
setup_mac_exception_state(mach_port_t thread, void *handler, void *resumer)
{
  MachineInformationPowerPC *machine_info;
  MemoryExceptionInformation *mem_info;
  RegisterInformationPowerPC *reg_info;
  FPUInformationPowerPC *fpu_info;
  VectorInformationPowerPC *vec_info;
  ExceptionInformationPowerPC *xp;
  ppc_thread_state_t ts;
  mach_msg_type_number_t thread_state_count;
  unsigned stackp, backptr;

  thread_state_count = MACHINE_THREAD_STATE_COUNT;
  thread_get_state(thread,
		   MACHINE_THREAD_STATE,
		   (thread_state_t)&ts,
		   &thread_state_count);

  backptr = ts.r1;
  stackp = TRUNC_DOWN(backptr, C_REDZONE_LEN, C_STK_ALIGN);
  stackp = TRUNC_DOWN(stackp, sizeof(VectorInformationPowerPC), C_STK_ALIGN);
  vec_info = (VectorInformationPowerPC *)stackp;
  stackp = TRUNC_DOWN(stackp, sizeof(FPUInformationPowerPC), C_STK_ALIGN);
  fpu_info = (FPUInformationPowerPC *)stackp;
  stackp = TRUNC_DOWN(stackp, sizeof(MachineInformationPowerPC), C_STK_ALIGN);
  machine_info = (MachineInformationPowerPC *)stackp;
  stackp = TRUNC_DOWN(stackp, sizeof(RegisterInformationPowerPC), C_STK_ALIGN);
  reg_info = (RegisterInformationPowerPC *)stackp;
  stackp = TRUNC_DOWN(stackp, sizeof(MemoryExceptionInformation), C_STK_ALIGN);
  mem_info = (MemoryExceptionInformation *)stackp;
  stackp = TRUNC_DOWN(stackp, sizeof(ExceptionInformationPowerPC), C_STK_ALIGN);
  xp = (ExceptionInformationPowerPC *)stackp;
  stackp -= (C_PARAMSAVE_LEN+C_LINKAGE_LEN);
  *(unsigned *)stackp = backptr;
  
  xp->machineState = machine_info;
  xp->registerImage = reg_info;
  xp->FPUImage = fpu_info;
  xp->vectorImage = vec_info;
  xp->info.memoryInfo = mem_info;

  mach_thread_state_to_mac_xinfo(thread,
				 &ts,
				 machine_info,
				 reg_info,
				 fpu_info,
				 vec_info);

  /* Caller must set exceptionKind, memory_info fields  in xp*/

  ts.r1 = (int) stackp;
  ts.r3 = (int) xp;
  ts.srr0 = (int) handler;
  ts.lr = (int) resumer;
  thread_set_state(thread, 
		   MACHINE_THREAD_STATE,
		   (thread_state_t)&ts,
		   MACHINE_THREAD_STATE_COUNT);
  return xp;
}

boolean_t application_handler_failed_p = FALSE;

kern_return_t
do_exception_return(mach_port_t thread)
{
  ppc_thread_state_t ts;
  kern_return_t exception_handler_return_value;
  ExceptionInformation *xp;
  mach_msg_type_number_t thread_state_count;

  thread_state_count = MACHINE_THREAD_STATE_COUNT;
  thread_get_state(thread,
		   MACHINE_THREAD_STATE,
		   (thread_state_t)&ts,
		   &thread_state_count);
  exception_handler_return_value = (kern_return_t) ts.r3;

  xp = (ExceptionInformation *) ((ts.r1)+(C_PARAMSAVE_LEN+C_LINKAGE_LEN));

  restore_thread_state_from_xp(thread,
			       xp,
			       &ts);
  if (exception_handler_return_value != noErr) {
    application_handler_failed_p = TRUE;
  }
  return 0;
}


kern_return_t
pmcl_catch_exception_raise(mach_port_t exception_port,
			   mach_port_t thread,
			   mach_port_t task, 
			   exception_type_t exception,
			   exception_data_t code_vector,
			   mach_msg_type_number_t code_count)
{
  ExceptionKind what_happened = kUnknownException;
  ExceptionInformation *xp;
  int code = *code_vector;

  if (application_handler_failed_p) {
    application_handler_failed_p = FALSE;
    if (getenv("MCL_DEBUG")) {
      int i;
      for (i = 0; i < 10; i++) {
	SysBeep(100);sleep(1);
      }
      fprintf(stderr, "Attach debugger to process %d; exception will be raised in 60 seconds\n", getpid());
      sleep(60);
    }
    return -1;
  }

  if ((exception == EXC_BAD_INSTRUCTION) &&
      (code_vector[0] == EXC_PPC_UNIPL_INST) &&
      (code_vector[1] == (int)exception_handler_return)) {
    return do_exception_return(thread);
  }

  xp = setup_mac_exception_state(thread,
				 (void *)PMCL_exception_handler,
				 (void *)exception_handler_return);
  
  switch (exception) {
  case EXC_BAD_ACCESS:
    xp->info.memoryInfo->theAddress = (LogicalAddress)code_vector[1];
    switch (code) {
    case KERN_PROTECTION_FAILURE:
      if (xp->machineState->DSISR & (1 << 25)) {
	what_happened = kReadOnlyMemoryException;
      } else {
	what_happened = kAccessException;
      }
      break;
    default:
      what_happened = kUnmappedMemoryException;
      break;
    }
    break;

  case EXC_SOFTWARE:
    if (code == EXC_PPC_TRAP) {
      what_happened = kTrapException;
    }
    break;

  case EXC_BAD_INSTRUCTION:
    what_happened = kIllegalInstructionException;
    break;
  }

  if (what_happened != kUnknownException) {
    xp->theKind = what_happened;
    return 0;
  }
  return -1;
}

boolean_t
pmcl_exc_server(mach_msg_header_t *in, mach_msg_header_t *out)
{
  static NDR_record_t _NDR = {0};
  kern_return_t handled;
  mig_reply_error_t *reply = (mig_reply_error_t *) out;
  exceptionRequest *req = (exceptionRequest *) in;

  reply->NDR = _NDR;

  out->msgh_bits = in->msgh_bits & MACH_MSGH_BITS_REMOTE_MASK;
  out->msgh_remote_port = in->msgh_remote_port;
  out->msgh_size = sizeof(mach_msg_header_t)+(3 * sizeof(unsigned));
  out->msgh_local_port = MACH_PORT_NULL;
  out->msgh_id = in->msgh_id+100;

  /* Could handle other exception flavors in the range 2401-2403 */


  if (in->msgh_id != 2401) {
    reply->RetCode = MIG_BAD_ID;
    return FALSE;
  }
  handled = pmcl_catch_exception_raise(req->Head.msgh_local_port,
				       req->thread.name,
				       req->task.name,
				       req->exception,
				       req->code,
				       req->codeCnt);
  reply->RetCode = handled;
  return TRUE;
}
  
				       
  
/* Return the port 'name' of the port set used by the exception
   thread */

mach_port_t
mach_exception_port_set()
{
  static mach_port_t __exception_port_set = MACH_PORT_NULL;
  kern_return_t kret;  
  if (__exception_port_set == MACH_PORT_NULL) {
    pthread_attr_t attr;
    pthread_t exception_thread;
    kret = mach_port_allocate(mach_task_self(),
			      MACH_PORT_RIGHT_PORT_SET,
			      &__exception_port_set);
    MACH_CHECK_ERROR(kret);
    pthread_attr_init(&attr);
    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);

    pthread_create(&exception_thread, 
		   &attr, 
		   exception_handler_proc,
		   (void *)__exception_port_set);
  }
  return __exception_port_set;
}


kern_return_t
install_mach_exception_handler_for_current_thread(exception_mask_t which)
{
  mach_port_t 
    thread = mach_thread_self(),
    exception_port_set = mach_exception_port_set(),
    task_self = mach_task_self(),
    thread_exception_port;
  kern_return_t kret;

  kret = mach_port_allocate(task_self,
			    MACH_PORT_RIGHT_RECEIVE,
			    &thread_exception_port);
  
  MACH_CHECK_ERROR(kret);

  kret = mach_port_insert_right(task_self,
				thread_exception_port,
				thread_exception_port,
				MACH_MSG_TYPE_MAKE_SEND);
  MACH_CHECK_ERROR(kret);

  kret = thread_set_exception_ports(thread,
				    which,
				    thread_exception_port,
				    EXCEPTION_DEFAULT,
				    THREAD_STATE_NONE);
  MACH_CHECK_ERROR(kret);

  (void)register_thread_exception_port(thread_exception_port);

  /* Add this thread's exception port to exception set */
  
  return mach_port_move_member(task_self,
			       thread_exception_port,
			       exception_port_set);
}


ExceptionHandler user_handler = NULL;
void install_mach_exception_handler(ExceptionHandler handler)
{  
  user_handler = handler;
  install_mach_exception_handler_for_current_thread((EXC_MASK_SOFTWARE|
						     EXC_MASK_BAD_ACCESS |
						     EXC_MASK_BAD_INSTRUCTION));
}

#endif

#ifndef PMCL_OSX_NATIVE_KERNEL
/* Not much that we can do ... */
OSStatus
lisp_Debugger(ExceptionInformationPowerPC *xp, int why, char *message, ...)
{
  va_list args;
  char buf[256];

  va_start(args,message);

  vsoutputf(buf, message, args);
  debugf(message);
  va_end(args);
  exit(-1);
}
#endif
