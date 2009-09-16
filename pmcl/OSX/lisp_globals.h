#ifndef __lisp_globals__
#define __lisp_globals__

/*
 02/13/97 bill nrs_CS_SEGMENT_SIZE, nrs_VS_SEGMENT_SIZE,
               nrs_TS_SEGMENT_SIZE, nrs_CS_HARD_OVERFLOW_SIZE,
               nrs_CS_SOFT_OVERFLOW_SIZE, nrs_CS_OVERFLOW_CALLBACK
 ------------  4.0
  8/28/96 slh  nrs_CURRENT_CURSOR
 06/14/96 bill nrs_NEW_GCABLE_PTR, bump num_nilreg_symbols
 06/10/96  gb  OLDEST_EPHEMERAL, TENURED_DATA.
 05/12/96  gb  num_nilreg_symbols, nilreg_symbols_end
 --- 3.9 ---
 04/09/96  gb  nrs_EXCISED_CODE
 04/08/96 bill EXCEPTION_SAVED_REGISTERS
 03/01/96 bill nrs_RESOLVE_SLEP_ADDRESS
 03/07/96  gb  add METERING_INFO, DOH_HEAD, SHORT_FLOAT_ZERO, DOUBLE_FLOAT_ONE, FFI_EXCEPTION
 02/04/96  gb  add IN_GC
 01/25/96  gb  add LEXPR_RETURN, LEXPR_RETURN1V
 12/27/95  gb  nrs_TOTAL_GC_MICROSECONDS, nrs_TOTAL_BYTES_FREED
 12/22/95  gb  READONLY_SECTION stuff
 12/13/95  gb  nrs_BUILTIN_FUNCTIONS
 11/29/95  gb  add nrs_INIT_MISC
 10/26/95 slh  add HEAP_START, HEAP_END
 10/25/95  gb  add %macro-code% nrs
 10/23/96  gb  a few more nilreg-relative globals.
 09/12/95  gb  add %closure-code% nrs
*/

extern LispObj lisp_nil;

#define CATCH_TOP (-1)		/* pointer to active catch frame */
#define DB_LINK (-2)		/* head of special-binding linked-list. */
#define SAVE_FREEPTR  (-3)	/* someplace to keep freeptr when in foreign context */
#define KERNEL_IMPORTS (-4)	/* some things we need to have imported for us. */
#define XFRAME (-5)		/* head of exception frame list. */
#define EMULATOR_REGISTERS (-6)	/* Where the 68K registers are kept. */
#define APPMAIN (-7)		/* application's (c-runtime) main() function */
#define SUBPRIMS_BASE (-8)	/* where the dynamic subprims wound up */
#define RET1VALN (-9)		/* magic multiple-values return address */
#define SAVE_VSP (-10)		/* vstack pointer */
#define SAVE_TSP (-11)		/* tstack pointer */
#define XALLOC (-12)		/* kernel callback for xalloc pseudo-uuo */
#define GO_TAG_COUNTER (-13)
#define BLOCK_TAG_COUNTER (-14)
#define OS_TRAP_BASE (-15)
#define TB_TRAP_BASE (-16)
#define OS_TRAP_CALL (-17)
#define TB_TRAP_CALL (-18)
#define SUBPRIMS_END (-19)        /*  end of subprims */
#define FWDNUM (-20)            /* fixnum: GC "forwarder" call count. */
#define GC_NUM (-21)            /* fixnum: GC call count. */
#define GCABLE_POINTERS (-22)   /* linked-list of weak macptrs. */
#define HEAP_START (-23)        /* start of lisp heap */
#define HEAP_END (-24)          /* end of lisp heap */
#define CURRENT_CS (-25)        /* area describing control-stack */
#define CURRENT_VS (-26)        /* area describing value-stack */
#define CURRENT_TS (-27)        /* area describing temp-stack */
#define CS_OVERFLOW_LIMIT (-28) /* value for control-stack overflow check */
#define ALL_AREAS (-29)         /* doubly-linked list of stack & heap areas */
#define LEXPR_RETURN (-30)      /* magic &lexpr cleanup code */
#define LEXPR_RETURN1V (-31)    /* single-value &lexpr cleanup code */
#define IN_GC (-32)             /* non-zero when lisp addresses may be invalid */
#define METERING_INFO (-33)     /* address of lisp_metering global */
#define DOH_HEAD (-34)          /* Homer ? */
#define SHORT_FLOAT_ZERO (-35)  /* low half of 1.0d0 */
#define DOUBLE_FLOAT_ONE (-36)  /* high half of 1.0d0 */
#define FFI_EXCEPTION (-37)     /* fpscr FEX bit from last ff-call */
#define EXCEPTION_SAVED_REGISTERS (-38)  /* saved registers from exception frame */
#define OLDEST_EPHEMERAL (-39)  /* doubleword address of oldest ephemeral object or 0 */
#define TENURED_AREA (-40)      /* the tenured area */
#define NATIVE_KERNEL_VERSION (-41) /* native kernel version number, or 0 */
#define REFBITS (-42)		    /* for write barrier */
#define HEAP_LIMIT (-43)	    /* equivalent to next guard region */
#define J_EXTEND_HEAP (-44)	    /* function to extend heap */
#define OLDSPACE_DNODE_COUNT (-45)  /* for write barrier */ 
#define TS_OVERFLOW_LIMIT (-46) /* current thread's tstack limit */
#define VS_OVERFLOW_LIMIT (-47) /* current thread's vstack limit */

#define READONLY_SECTION_END (-1020)
#define READONLY_SECTION_START (-1021)
#define STATIC_HEAP_NEXT (-1022) /* next static heap triplet in application or NULL */
#define STATIC_HEAP_END (-1023) /* end of (primary) static heap */
#define STATIC_HEAP_START (-1024) /* start of (primary) static heap */


#define lisp_global(g) (((LispObj *) (lisp_nil-fulltag_nil))[(g)])
#define nrs_symbol(s) (((lispsymbol *) (lisp_nil+(8-fulltag_nil)+8))[(s)])

#define nrs_T 				(nrs_symbol(0))		/* t */
#define nrs_NILSYM			(nrs_symbol(1))		/* nil */
#define nrs_ERRDISP			(nrs_symbol(2))		/* %err-disp */
#define nrs_CMAIN			(nrs_symbol(3))		/* cmain */
#define nrs_EVAL			(nrs_symbol(4))		/* eval */
#define nrs_APPEVALFN			(nrs_symbol(5))		/* apply-evaluated-function */
#define nrs_ERROR			(nrs_symbol(6))		/* error */
#define nrs_DEFUN			(nrs_symbol(7))		/* %defun */
#define nrs_DEFVAR			(nrs_symbol(8))		/* %defvar */
#define nrs_DEFCONSTANT			(nrs_symbol(9))		/* %defconstant */
#define nrs_MACRO			(nrs_symbol(10))	/* %macro */
#define nrs_KERNELRESTART		(nrs_symbol(11))	/* %kernel-restart */
#define nrs_PACKAGE			(nrs_symbol(12))	/* *package* */
#define nrs_INTERRUPT_LEVEL		(nrs_symbol(13))	/* *interrupt-level* */
#define nrs_KALLOWOTHERKEYS		(nrs_symbol(14))	/* :allow-other-keys */
#define nrs_TOPLCATCH			(nrs_symbol(15))	/* %toplevel-catch% */
#define nrs_TOPLFUNC			(nrs_symbol(16))	/* %toplevel-function% */
#define nrs_CALLBACKS			(nrs_symbol(17))	/* %pascal-functions% */
#define nrs_ALLMETEREDFUNS		(nrs_symbol(18))	/* *all-metered-functions* */
#define nrs_DYNVFP			(nrs_symbol(19))	/* *%dynvfp%* */
#define nrs_DYNVLIMIT			(nrs_symbol(20))	/* *%dynvlimit%* */
#define nrs_UDF				(nrs_symbol(21))	/* %unbound-function% */
#define nrs_FOREGROUND			(nrs_symbol(22))	/* *foreground* */
#define nrs_BACKGROUND_TICKS		(nrs_symbol(23))	/* *background-sleep-ticks* */
#define nrs_FOREGROUND_TICKS		(nrs_symbol(24))	/* *foreground-sleep-ticks* */
#define nrs_WINDOW_UPDATE_WPTR		(nrs_symbol(25))	/* *window-update-wptr* */
#define nrs_GC_EVENT_STATUS_BITS	(nrs_symbol(26))	/* *gc-event-status-bits* */
#define nrs_PRE_GC_HOOK			(nrs_symbol(27))	/* *pre-gc-hook* */
#define nrs_POST_GC_HOOK		(nrs_symbol(28))	/* *post-gc-hook* */
#define nrs_HANDLERS			(nrs_symbol(29))	/* %handlers% */
#define nrs_PARSE_STRING		(nrs_symbol(30))	/* %parse-string% */
#define nrs_ALL_PACKAGES		(nrs_symbol(31))	/* %all-packages% */
#define nrs_KEYWORD_PACKAGE		(nrs_symbol(32))	/* *keyword-package* */
#define nrs_SAVED_METHOD_VAR		(nrs_symbol(33))	/* %saved-method-var% */
#define nrs_FINALIZATION_ALIST		(nrs_symbol(34))	/* %finalization-alist% */
#define nrs_CURRENT_STACK_GROUP		(nrs_symbol(35))	/* *current-stack-group* */
#define nrs_CLOSURE_CODE		(nrs_symbol(36))        /* %closure-code% */
#define nrs_MACRO_CODE                  (nrs_symbol(37))        /* %macro-code% */
#define nrs_INIT_MISC			(nrs_symbol(38))        /* %init-misc% */
#define nrs_BUILTIN_FUNCTIONS           (nrs_symbol(39))        /* %builtin-functions% */
#define nrs_TOTAL_GC_MICROSECONDS       (nrs_symbol(40))        /* *total-gc-microseconds* */
#define nrs_TOTAL_BYTES_FREED           (nrs_symbol(41))        /* *total-bytes-freed* */
#define nrs_RESOLVE_SLEP_ADDRESS        (nrs_symbol(42))        /* resolve-slep-address */
#define nrs_EXCISED_CODE                (nrs_symbol(43))        /* %excised-code% */
#define nrs_NEW_GCABLE_PTR		(nrs_symbol(44))	/* %new-gcable-ptr */
#define nrs_CURRENT_CURSOR              (nrs_symbol(45))        /* *current-cursor* */
#define nrs_CS_SEGMENT_SIZE             (nrs_symbol(46))        /* *cs-segment-size* */
#define nrs_TS_SEGMENT_SIZE             (nrs_symbol(47))        /* *ts-segment-size* */
#define nrs_VS_SEGMENT_SIZE             (nrs_symbol(48))        /* *vs-segment-size* */
#define nrs_CS_HARD_OVERFLOW_SIZE       (nrs_symbol(49))        /* *cs-hard-overflow-size* */
#define nrs_CS_SOFT_OVERFLOW_SIZE       (nrs_symbol(50))        /* *cs-soft-overflow-size* */
#define nrs_CS_OVERFLOW_CALLBACK        (nrs_symbol(51))        /* cs-overflow-callback */
#define nrs_GC_CURSOR			(nrs_symbol(52))	/* *gc-cursor* */
#define num_nilreg_symbols 53
#define nilreg_symbols_end ((BytePtr) &(nrs_symbol(num_nilreg_symbols)))
#endif
