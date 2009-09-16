#ifndef __LISP_EXCEPTIONS_H__
#define __LISP_EXCEPTIONS_H__ 1

#include <StdLib.h>
#ifdef PMCL_OSX_NATIVE_KERNEL
#include <Carbon/Carbon.h>
#else
#include <CodeFragments.h>
#include <Memory.h>
#endif
#include "memprotect.h"
#include "gc.h"

/*
 06/23/07 akh add zalloc etc.
 ------ 5.2b6
 04/11/01 akh add installed_exception_handler for temp workaround for OSX problem
 01/29/97 gb    more anal-retentive extern decls for GCC.
 ---- 4.0 ----
 07/20/96 gb    ExceptionInformation -> ExceptionInformationPowerPC for 68K C.
 ---- 3.9 ----
 04/09/96 gb    Fatal(), alloc_critical prototypes
 03/10/96 gb    protection change; FP exceptions, 
                register_codevector_contains_pc change for metering.
 02/28/96 bill  lisp_growzone_UPP, install_lisp_growzone
 01/10/96 gb    fixnum_overflow UUO; another branch
                recognition scheme.
 12/13/95 gb    Bug(); handle_xalloc(); xframe macros
 12/07/95 bill  New: callback_for_trap, register_codevector_contains_pc.
                callback_to_lisp & handle_error take additional args
 11/20/95 bill  callback_to_lisp, xpLR
 10/26/95 slh   add ErrAction enum, error_action proto
*/

typedef enum {
  kDebugger,
  kContinue,
  kExit
} ErrAction;

#if 0
/* from universal headers macmemory.h sort of */
EXTERN_API(GrowZoneUPP)
NewGrowZoneUPP	(ProcPtr);
#endif
		
void
zero_page(BytePtr);

void
zero_heap_segment(BytePtr);

extern protected_area_ptr AllProtectedAreas;

protected_area_ptr find_protected_area(BytePtr);

OSStatus
lisp_Debugger(ExceptionInformationPowerPC *, int, char *, ...);

OSStatus
handle_protection_violation(ExceptionInformationPowerPC *);

protected_area_ptr 
new_protected_area(BytePtr, BytePtr, lisp_protection_kind, unsigned, Boolean);

void
unprotect_area_prefix(protected_area_ptr, size_t);

void
protect_area_prefix(protected_area_ptr, size_t);

void
protect_area(protected_area_ptr);

OSStatus
PMCL_exception_handler(ExceptionInformationPowerPC *xp);

ErrAction
error_action( void );

void
install_pmcl_exception_handlers(void);

void
unprotect_all_areas(void);

void
exception_cleanup(void);

void
exception_init(void);

void
install_threadentryupp(void);

#define UUO_MASK 0xfc00000f
#define IS_UUO(i) (((i) & UUO_MASK) == 0xb)
/* If an instruction is a UUO, the minor opcode is in bits 21:27 */
#define UUO_MINOR(u) (((u) >> 4) & 0x7f)

/*
  This assumes that we're in 32-bit mode, e.g., that a GPR is 32
   bits wide and stored in the "lo" part of an UnsignedWide.
*/

#define xpGPR(x,gpr) (((UnsignedWide*)((x)->registerImage))[(gpr)]).lo
#define set_xpGPR(x,gpr,new) xpGPR((x),(gpr)) = (UInt32)(new)

#define xpCCR(x) (x)->machineState->CRRegister
#define xpXER(x) (x)->machineState->XER
#define xpDAR(x) (x)->machineState->DAR.lo
#define xpDSISR(x) (x)->machineState->DSISR
#define xpFPSCR(x) (x)->FPUImage->FPSCR
#define xpMSR(x) (x)->machineState->MSR
#define xpFPRvector(x) ((double *)&(x->FPUImage->Registers[0]))
typedef unsigned opcode, *pc;

#define xpPC(x) (*((pc*)(&((x)->machineState->PC.lo))))
#define set_xpPC(x,new) (xpPC(x) = (pc)(new))

#define xpLR(x) (*((pc*)(&((x)->machineState->LR.lo))))
#define xpCTR(x) (*(pc*)(&((x)->machineState->CTR.lo)))

OSStatus
handle_uuo(ExceptionInformationPowerPC *, opcode, pc);


/* 
  Unconditional traps (tw, twi instructions) are used by the
  operating system.  We use conditional traps.
  */

int
is_conditional_trap(opcode);

#define kNameBufLen 256
#define TRAP_LOOKUP_TRIES 5   /* # instrs to scan before trap instr */

void
callback_for_trap (LispObj, ExceptionInformationPowerPC *, unsigned, unsigned, unsigned, unsigned);

unsigned
register_codevector_contains_pc (unsigned, unsigned);

void
callback_to_lisp (LispObj, ExceptionInformationPowerPC *, unsigned, unsigned, unsigned, unsigned, unsigned);

OSStatus
handle_trap(ExceptionInformationPowerPC *, opcode, pc);

unsigned
scan_for_instr( unsigned, unsigned, pc );

size_t
exception_fn_name( ExceptionInformationPowerPC *, int, char *, size_t );

size_t
symbol_name( unsigned, char *, size_t );

void
non_fatal_error( char * );

#define UUO_BOX_SIGNED (1)
#define UUO_BOX_UNSIGNED (2)
#define UUO_ADD_FIXNUMS (3)
#define UUO_SUB_FIXNUMS (4)

#define UUO_INTERR (11)
#define UUO_INTCERR (12)
#define UUO_INTERR2 (13)
#define UUO_INTCERR2 (14)
#define UUO_FIXNUM_OVERFLOW (21)
#define UUO_FPUX_BINOP (22)
#define UUO_XALLOC (24)

OSStatus
box_signed_integer(ExceptionInformationPowerPC *, unsigned, unsigned);

OSStatus
box_unsigned_integer(ExceptionInformationPowerPC *, unsigned, unsigned);

OSStatus
fix_fixnum_overflow(ExceptionInformationPowerPC *, unsigned, unsigned);

OSStatus
add_fixnums(ExceptionInformationPowerPC *, unsigned, unsigned, unsigned);

OSStatus
sub_fixnums(ExceptionInformationPowerPC *, unsigned, unsigned, unsigned);

OSStatus
handle_error(ExceptionInformationPowerPC *, unsigned, unsigned, unsigned, unsigned);

void
adjust_exception_pc(ExceptionInformationPowerPC *, int);


/* PPC instructions */
#define match_instr(instr, mask, target)   (((instr) & (mask)) == (target))
#define RS_field(instr)  (((instr) >> 21) & 0x1f)
#define RT_field(instr)  (RS_field(instr))
#define TO_field(instr)  (RT_field(instr))
#define RA_field(instr)  (((instr) >> 16) & 0x1f)
#define RB_field(instr)  (((instr) >> 11) & 0x1f)
#define D_field(instr)   ((instr) & 0xffff)

#define RS_MASK (0x1f << 21)
#define RT_MASK RS_MASK
#define TO_MASK RS_MASK
#define RA_MASK (0x1f << 16)
#define RB_MASK (0x1f << 11)
#define D_MASK 0xffff



#define OP(x) (((x) & 0x3f) << 26)
#define OP_MASK OP (0x3f)

/* Main opcode + TO field of a D form instruction */
#define OPTO(x,to) (OP(x) | (((to) & 0x1f) << 21))
#define OPTO_MASK (OP_MASK | TO_MASK)
#define OPTORA(x,to,ra) (OPTO(x,to) | ((ra) << 16))
#define OPTORA_MASK (OP_TO_MASK | RA_MASK)




/* An X form instruction.  */
#define X(op, xop) (OP (op) | (((xop) & 0x3ff) << 1))

/* An X form instruction with the RC bit specified.  */
#define XRC(op, xop, rc) (X ((op), (xop)) | ((rc) & 1))

/* The mask for an X form instruction.  */
#define X_MASK XRC(0x3f, 0x3ff, 1)

/* The bits in the TO field of a TW or TWI instruction */
#define TO_LT (1<<4)		/* signed < */
#define TO_GT (1<<3)		/* signed > */
#define TO_EQ (1<<2)		/* = */
#define TO_LO (1<<1)		/* unsigned < */
#define TO_HI (1<<0)		/* unsigned > */
#define TO_NE (TO_LT|TO_GT)

/* True if major opcode of "instr" is "op" */
#define major_opcode_p(instr, op) match_instr((instr),OP_MASK,OP(op))

/* True if "instr" is an X form instruction with major opcode "major"
   and minor opcode "minor" */
#define X_opcode_p(instr,major,minor) match_instr((instr),X_MASK,X(major,minor))

#define major_opcode_TWI 3
#define major_opcode_RLWINM 21
#define major_opcode_X31 31		/* an "X" form instruction; see minor opcode */
#define major_opcode_LWZ 32
#define major_opcode_LBZ 34
#define major_opcode_FPU_SINGLE 59
#define major_opcode_FPU_DOUBLE 63

#define minor_opcode_TW 4

#define D_instruction(major,rt,ra,imm) (OP(major)|((rt)<<21)|((ra)<<16)|((imm)&D_MASK))
#define TWI_instruction(rt,ra,imm)     D_instruction(major_opcode_TWI,rt,ra,imm)
#define LBZ_instruction(rt,ra,imm)     D_instruction(major_opcode_LBZ,rt,ra,imm)
#define LWZ_instruction(rt,ra,imm)     D_instruction(major_opcode_LWZ,rt,ra,imm)

#define D_RT_IMM_MASK                  (OP_MASK|RT_MASK|D_MASK)

#define X_instruction(major,minor,rt,ra,rb) (X(major,minor)|((rt)<<21)|((ra)<<16)|((rb)<<11))

#define unmasked_register              0

#define LISP_BREAK_INSTRUCTION 0x7F810808

void Bug(const char *format_string, ...);
int gc_from_xp(ExceptionInformationPowerPC *);

/* Yet another way to look at a branch instruction ... */
typedef union {
  struct {unsigned op:6, li:24, aa:1, lk:1;} b;
  unsigned opcode;
} branch_instruction;

GrowZoneUPP lisp_growzone_UPP;

#ifndef PMCL_OSX_NATIVE_KERNEL
ExceptionHandler installed_exception_handler;
#endif

void install_lisp_growzone (void);

void
Fatal(StringPtr, StringPtr);

/* Returns (possibly zeroed) pointer or signals a Fatal error. */
Ptr
alloc_ptr_critical(unsigned, Boolean);

/*
  Returns locked handle, master pointer in reference parameter or signals
  a Fatal error.  Will try both application heap & multifinder. */

Ptr
alloc_handle_critical(unsigned size, Handle *);

Ptr
allocate(unsigned);

Ptr
zalloc(unsigned);

void
deallocate(Ptr);

#endif


#define debug_entry_exception 0
#define debug_entry_bug 1
#define debug_entry_dbg 2

