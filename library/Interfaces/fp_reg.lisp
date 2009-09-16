(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:fp_reg.h"
; at Sunday July 2,2006 7:24:05 pm.
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
; 
;  * @OSF_COPYRIGHT@
;  
; 
;  * HISTORY
;  * 
;  * Revision 1.1.1.1  1998/09/22 21:05:31  wsanchez
;  * Import of Mac OS X kernel (~semeria)
;  *
;  * Revision 1.1.1.1  1998/03/07 02:25:47  wsanchez
;  * Import of OSF Mach kernel (~mburg)
;  *
;  * Revision 1.2.6.1  1994/09/23  02:37:03  ezf
;  * 	change marker to not FREE
;  * 	[1994/09/22  21:39:57  ezf]
;  *
;  * Revision 1.2.2.2  1993/06/09  02:40:30  gm
;  * 	Added to OSF/1 R1.3 from NMK15.0.
;  * 	[1993/06/02  21:16:11  jeffc]
;  * 
;  * Revision 1.2  1993/04/19  16:33:51  devrcs
;  * 	ansi C conformance changes
;  * 	[1993/02/02  18:56:01  david]
;  * 
;  * Revision 1.1  1992/09/30  02:30:43  robert
;  * 	Initial revision
;  * 
;  * $EndLog$
;  
;  CMU_HIST 
; 
;  * Revision 2.1.1.1.2.1  92/03/03  16:21:23  jeffreyh
;  * 	Merged up to Trunk
;  * 	[92/02/26            jeffreyh]
;  * 
;  * Revision 2.4  92/02/26  13:10:29  elf
;  * 	Added stupid alaises to make i386/fpu.c compile. RVB will fix.
;  * 	 
;  * 	[92/02/26            elf]
;  * 
;  * Revision 2.3  92/02/26  12:47:46  elf
;  * 	Installed from i386 directory.
;  * 	[92/02/26            danner]
;  * 
;  * 
;  * Revision 2.2  92/01/03  20:19:47  dbg
;  * 	Move this file to mach/i386.  Add FP_NO..FP_387 codes for
;  * 	floating-point processor status.  Error bits in control
;  * 	register are masks, not enables.
;  * 	[91/10/19            dbg]
;  * 
;  
;  CMU_ENDHIST 
;  
;  * Mach Operating System
;  * Copyright (c) 1992-1989 Carnegie Mellon University
;  * All Rights Reserved.
;  * 
;  * Permission to use, copy, modify and distribute this software and its
;  * documentation is hereby granted, provided that both the copyright
;  * notice and this permission notice appear in all copies of the
;  * software, derivative works or modified versions, and any portions
;  * thereof, and that both notices appear in supporting documentation.
;  * 
;  * CARNEGIE MELLON ALLOWS FREE USE OF THIS SOFTWARE IN ITS "AS IS"
;  * CONDITION.  CARNEGIE MELLON DISCLAIMS ANY LIABILITY OF ANY KIND FOR
;  * ANY DAMAGES WHATSOEVER RESULTING FROM THE USE OF THIS SOFTWARE.
;  * 
;  * Carnegie Mellon requests users of this software to return to
;  * 
;  *  Software Distribution Coordinator  or  Software.Distribution@CS.CMU.EDU
;  *  School of Computer Science
;  *  Carnegie Mellon University
;  *  Pittsburgh PA 15213-3890
;  * 
;  * any improvements or extensions that they make and grant Carnegie Mellon
;  * the rights to redistribute these changes.
;  
; 
;  
; #ifndef	_I386_FP_SAVE_H_
; #define	_I386_FP_SAVE_H_
; 
;  *	Floating point registers and status, as saved
;  *	and restored by FP save/restore instructions.
;  
(defrecord i386_fp_save
   (fp_control :UInt16)
                                                ;  control 
   (fp_unused_1 :UInt16)
   (fp_status :UInt16)
                                                ;  status 
   (fp_unused_2 :UInt16)
   (fp_tag :UInt16)
                                                ;  register tags 
   (fp_unused_3 :UInt16)
   (fp_eip :UInt32)
                                                ;  eip at failed instruction 
   (fp_cs :UInt16)
                                                ;  cs at failed instruction 
   (fp_opcode :UInt16)
                                                ;  opcode of failed instruction 
   (fp_dp :UInt32)
                                                ;  data address 
   (fp_ds :UInt16)
                                                ;  data segment 
   (fp_unused_4 :UInt16)
)
(defrecord i386_fp_regs
   (fp_reg_word (:array :UInt16 40))
                                                ;  space for 8 80-bit FP registers 
)
;  note when allocating this data structure, it must be 16 byte aligned. 
(defrecord i386_fx_save
   (fx_control :UInt16)                         ;  control 
   (fx_status :UInt16)                          ;  status 
   (fx_tag :UInt8)                              ;  register tags 
   (fx_bbz1 :UInt8)
                                                ;  better be zero when calling fxrtstor 
   (fx_opcode :UInt16)
   (fx_eip :UInt32)                             ;  eip  instruction 
   (fx_cs :UInt16)                              ;  cs instruction 
   (fx_bbz2 :UInt16)
                                                ;  better be zero when calling fxrtstor 
   (fx_dp :UInt32)                              ;  data address 
   (fx_ds :UInt16)                              ;  data segment 
   (fx_bbz3 :UInt16)
                                                ;  better be zero when calling fxrtstor 
   (fx_MXCSR :UInt32)
   (fx_MXCSR_MASK :UInt32)
   (fx_reg_word (:array :UInt16 64))            ;  STx/MMx registers 
   (fx_XMM_reg (:array :UInt16 64))             ;  XMM0-XMM7 
   (fx_reserved (:array :UInt8 224))            ;  reserved by intel for future expansion 
)
; 
;  * Control register
;  
(defconstant $FPC_IE 1)
; #define	FPC_IE		0x0001		/* enable invalid operation
; #define FPC_IM		FPC_IE
(defconstant $FPC_DE 2)
; #define	FPC_DE		0x0002		/* enable denormalized operation
; #define FPC_DM		FPC_DE
(defconstant $FPC_ZE 4)
; #define	FPC_ZE		0x0004		/* enable zero-divide exception */
; #define FPC_ZM		FPC_ZE
(defconstant $FPC_OE 8)
; #define	FPC_OE		0x0008		/* enable overflow exception */
; #define FPC_OM		FPC_OE
(defconstant $FPC_UE 16)
; #define	FPC_UE		0x0010		/* enable underflow exception */
(defconstant $FPC_PE 32)
; #define	FPC_PE		0x0020		/* enable precision exception */
(defconstant $FPC_PC 768)
; #define	FPC_PC		0x0300		/* precision control: */
(defconstant $FPC_PC_24 0)
; #define	FPC_PC_24	0x0000			/* 24 bits */
(defconstant $FPC_PC_53 512)
; #define	FPC_PC_53	0x0200			/* 53 bits */
(defconstant $FPC_PC_64 768)
; #define	FPC_PC_64	0x0300			/* 64 bits */
(defconstant $FPC_RC 3072)
; #define	FPC_RC		0x0c00		/* rounding control: */
(defconstant $FPC_RC_RN 0)
; #define	FPC_RC_RN	0x0000			/* round to nearest or even */
(defconstant $FPC_RC_RD 1024)
; #define	FPC_RC_RD	0x0400			/* round down */
(defconstant $FPC_RC_RU 2048)
; #define	FPC_RC_RU	0x0800			/* round up */
(defconstant $FPC_RC_CHOP 3072)
; #define	FPC_RC_CHOP	0x0c00			/* chop */
(defconstant $FPC_IC 4096)
; #define	FPC_IC		0x1000		/* infinity control (obsolete) */
(defconstant $FPC_IC_PROJ 0)
; #define	FPC_IC_PROJ	0x0000			/* projective infinity */
(defconstant $FPC_IC_AFF 4096)
; #define	FPC_IC_AFF	0x1000			/* affine infinity (std) */
; 
;  * Status register
;  
(defconstant $FPS_IE 1)
; #define	FPS_IE		0x0001		/* invalid operation */
(defconstant $FPS_DE 2)
; #define	FPS_DE		0x0002		/* denormalized operand */
(defconstant $FPS_ZE 4)
; #define	FPS_ZE		0x0004		/* divide by zero */
(defconstant $FPS_OE 8)
; #define	FPS_OE		0x0008		/* overflow */
(defconstant $FPS_UE 16)
; #define	FPS_UE		0x0010		/* underflow */
(defconstant $FPS_PE 32)
; #define	FPS_PE		0x0020		/* precision */
(defconstant $FPS_SF 64)
; #define	FPS_SF		0x0040		/* stack flag */
(defconstant $FPS_ES 128)
; #define	FPS_ES		0x0080		/* error summary */
(defconstant $FPS_C0 256)
; #define	FPS_C0		0x0100		/* condition code bit 0 */
(defconstant $FPS_C1 512)
; #define	FPS_C1		0x0200		/* condition code bit 1 */
(defconstant $FPS_C2 1024)
; #define	FPS_C2		0x0400		/* condition code bit 2 */
(defconstant $FPS_TOS 14336)
; #define	FPS_TOS		0x3800		/* top-of-stack pointer */
(defconstant $FPS_TOS_SHIFT 11)
; #define	FPS_TOS_SHIFT	11
(defconstant $FPS_C3 16384)
; #define	FPS_C3		0x4000		/* condition code bit 3 */
(defconstant $FPS_BUSY 32768)
; #define	FPS_BUSY	0x8000		/* FPU busy */
; 
;  * Kind of floating-point support provided by kernel.
;  
(defconstant $FP_NO 0)
; #define	FP_NO		0		/* no floating point */
(defconstant $FP_SOFT 1)
; #define	FP_SOFT		1		/* software FP emulator */
(defconstant $FP_287 2)
; #define	FP_287		2		/* 80287 */
(defconstant $FP_387 3)
; #define	FP_387		3		/* 80387 or 80486 */
(defconstant $FP_FXSR 4)
; #define FP_FXSR		4		/* Fast save/restore SIMD Extension */

; #endif	/* _I386_FP_SAVE_H_ */


(provide-interface "fp_reg")