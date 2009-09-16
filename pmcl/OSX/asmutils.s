
;;; assembly-language utilities for OSX-native kernel
;;; $Log: OSXasmutils.unix-s,v $
;;; Revision 1.3  2003/09/30 20:03:11  gtbyers
;;; Define and use DCBZL  "instruction" (dcbz with PPC bit 10 set), since 970 dcbz instruction ignores cache block size (!).
;;;
;;; Revision 1.2  2002/11/18 04:47:08  gtbyers
;;; Remove stale comments; add CVS log thing.
;;;
;;; 

        .macro DCBZL
 	.long (31<<26)+(1<<21)+($0<<16)+($1<<11)+(1014<<1)
        .endmacro

	
	.globl _zero_cache_lines
_zero_cache_lines:	
;;; Zero R4 cache lines, starting at address in R3.  Each line is assumed to be
;;; R5 bytes wide.
	cmpwi cr0,r4,0
	mtctr r4
	beqlr
1:	DCBZL 0,3
	add r3,r3,r5
	bdnz 1b
	blr


	.globl _current_stack_pointer
_current_stack_pointer:	
	mr r3,r1
	blr
	

	.globl _count_leading_zeros
_count_leading_zeros:
	cntlzw r3,r3
	blr

	.globl _find_interrupt_context
_find_interrupt_context:	
	lwz r4,0(r1)		; caller's frame pointer
	lwz r4,0(r4)		; its caller: emulator frame ?
	clrlwi. r5,r4,31	; cr0_eq clear if so
	clrrwi r4,r4,1
	add r3,r4,r3		; add offset
	bnelr			; return if emulator frame
	li r3,0
	blr			; return NULL otherwise

	.globl _set_fpscr
_set_fpscr:	
	stw r3,-4(r1)
	lfd f0,-8(r1)
	mtfsf 0xff,f0
	blr

	.globl _call_cfm_proc
_call_cfm_proc:
	lwz r0,0(r3)
	mr r12,r3		; r12 = proc
	mr r3,r4
	mr r4,r5
	mr r5,r6
	mtctr r0
	mr r6,r7
	mr r7,r8
	mr r8,r9
	lwz r2,4(r12)
	mr r9,r10
	bctr


	.globl _exception_handler_return
_exception_handler_return:
	.long 0
	b _exception_handler_return

	