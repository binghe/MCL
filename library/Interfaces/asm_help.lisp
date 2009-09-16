(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:asm_help.h"
; at Sunday July 2,2006 7:26:39 pm.
; 
;  * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * The contents of this file constitute Original Code as defined in and
;  * are subject to the Apple Public Source License Version 1.1 (the
;  * "License").  You may not use this file except in compliance with the
;  * License.  Please obtain a copy of the License at
;  * http://www.apple.com/publicsource and read it before using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
;  * License for the specific language governing rights and limitations
;  * under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
;  Copyright (c) 1991 NeXT Computer, Inc.  All rights reserved.
;  *
;  *	File:	architecture/i386/asm_help.h
;  *	Author:	Mike DeMoney, NeXT Computer, Inc.
;  *	Modified for i386 by: Bruce Martin, NeXT Computer, Inc.
;  *
;  *	This header file defines macros useful when writing assembly code
;  *	for the Intel i386 family processors.
;  *
;  * HISTORY
;  * 10-Mar-92  Bruce Martin (bmartin@next.com)
;  *	Adapted to i386
;  * 23-Jan-91  Mike DeMoney (mike@next.com)
;  *	Created.
;  
; #ifndef	_ARCH_I386_ASM_HELP_H_
; #define	_ARCH_I386_ASM_HELP_H_

(require-interface "architecture/i386/reg_help")
; #ifdef	__ASSEMBLER__
#| #|

#define ALIGN						\
	.align	2, 0x90

#define ROUND_TO_STACK(len)				\
	(((len) + STACK_INCR - 1)  STACK_INCR * STACK_INCR)

#ifdefnotdef
#define CALL_MCOUNT						\
	pushl	%ebp						;\
	movl	%esp, %ebp					;\
	.data							;\
	1: .long 0						;\
	.text							;\
	lea 9b,%edx						;\
	call mcount						;\
	popl	%ebp						;
#else#define CALL_MCOUNT
#endif

#define NESTED_FUNCTION_PROLOGUE(localvarsize)			\
	.set	__framesize,ROUND_TO_STACK(localvarsize)	;\
	.set	__nested_function, 1				;\
	CALL_MCOUNT						\
	.if __framesize						;\
	  pushl	%ebp						;\
	  movl	%esp, %ebp					;\
	  subl	$__framesize, %esp				;\
	.endif							;\
	pushl	%edi						;\
	pushl	%esi						;\
	pushl	%ebx


#define LEAF_FUNCTION_PROLOGUE(localvarsize)			\
	.set	__framesize,ROUND_TO_STACK(localvarsize)	;\
	.set	__nested_function, 0				;\
	CALL_MCOUNT						\
	.if __framesize						;\
	  pushl	%ebp						;\
	  movl	%esp, %ebp					;\
	  subl	$__framesize, %esp				;\
	.endif


#define FUNCTION_EPILOGUE					\
	.if __nested_function					;\
	  popl	%ebx						;\
	  popl	%esi						;\
	  popl	%edi						;\
	.endif							;\
	.if __framesize						;\
	  movl	%ebp, %esp					;\
	  popl	%ebp						;\
	.endif							;\
	ret





#define TEXT						\
	.text


#define DATA						\
	.data


#define LEAF(name, localvarsize)			\
	.globl	name					;\
	ALIGN						;\
name:							;\
	LEAF_FUNCTION_PROLOGUE(localvarsize)


#define X_LEAF(name, value)				\
	.globl	name					;\
	.set	name,value


#define P_LEAF(name, localvarsize)			\
	ALIGN						;\
name:							;\
	LEAF_FUNCTION_PROLOGUE(localvarsize)


#define LABEL(name)					\
	.globl	name					;\
name:


#define NESTED(name, localvarsize)			\
	.globl	name					;\
	ALIGN						;\
name:							;\
	NESTED_FUNCTION_PROLOGUE(localvarsize)


#define X_NESTED(name, value)				\
	.globl	name					;\
	.set	name,value


#define P_NESTED(name, localvarsize)			\
	ALIGN						;\
name:							;\
	NESTED_FUNCTION_PROLOGUE(localvarsize)


#define END(name)					\
	FUNCTION_EPILOGUE





#define IMPORT(name)					\
	.reference	name


#define ABS(name, value)				\
	.globl	name					;\
	.set	name,value


#define P_ABS(name, value)				\
	.set	name,value


#define EXPORT(name)					\
	.globl	name					;\
name:


#define BSS(name,size)					\
	.comm	name,size



#define P_BSS(name,size)				\
	.lcomm	name,size



#ifdefined(__DYNAMIC__)
#define PICIFY(var)					\
	call	1f					; \
1:							; \
	popl	%edx					; \
	movl	L 
; # var ## $non_lazy_ptr-1b(%edx),%edx
#COMPILER-DIRECTIVE 
#define CALL_EXTERN_AGAIN(func)	\
	PICIFY(func)		; \
	call	%edx

#define NON_LAZY_STUB(var)	\
.non_lazy_symbol_pointer	; \
L 
; # var ## $non_lazy_ptr:	; .indirect_symbol var		; .long 0				; .text
#COMPILER-DIRECTIVE 
#define CALL_EXTERN(func)	\
	CALL_EXTERN_AGAIN(func)	; \
	NON_LAZY_STUB(func)

#define BRANCH_EXTERN(func)	\
	PICIFY(func)		; \
	jmp	%edx		; \
	NON_LAZY_STUB(func)

#define PUSH_EXTERN(var)	\
	PICIFY(var)		; \
	movl	(%edx),%edx	; \
	pushl	%edx		; \
	NON_LAZY_STUB(var)

#define REG_TO_EXTERN(reg, var)	\
	PICIFY(var)		; \
	movl	reg, (%edx)	; \
	NON_LAZY_STUB(var)

#define EXTERN_TO_REG(var, reg)				\
	call	1f					; \
1:							; \
	popl	%edx					; \
	movl	L 
; # var ##$non_lazy_ptr-1b(%edx),reg	; 	NON_LAZY_STUB(var)
#COMPILER-DIRECTIVE 

#else#define BRANCH_EXTERN(func)	jmp	func
#define PUSH_EXTERN(var)	pushl	var
#define CALL_EXTERN(func)	call	func
#define CALL_EXTERN_AGAIN(func)	call	func
#define REG_TO_EXTERN(reg, var)	movl	reg, var
#define EXTERN_TO_REG(var, reg)	movl	$ 
; # var, reg
#COMPILER-DIRECTIVE #endif
#endif
|#
 |#
;  __ASSEMBLER__ 

; #endif	/* _ARCH_I386_ASM_HELP_H_ */


(provide-interface "asm_help")