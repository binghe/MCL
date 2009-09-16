(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:exception_types.h"
; at Sunday July 2,2006 7:24:04 pm.
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
;  * Mach Operating System
;  * Copyright (c) 1991,1990,1989,1988,1987 Carnegie Mellon University
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
; #ifndef	_MACH_EXCEPTION_TYPES_H_
; #define	_MACH_EXCEPTION_TYPES_H_

(require-interface "mach/machine/exception")
; 
;  *	Machine-independent exception definitions.
;  
(defconstant $EXC_BAD_ACCESS 1)
; #define EXC_BAD_ACCESS		1	/* Could not access memory */
;  Code contains kern_return_t describing error. 
;  Subcode contains bad memory address. 
(defconstant $EXC_BAD_INSTRUCTION 2)
; #define EXC_BAD_INSTRUCTION	2	/* Instruction failed */
;  Illegal or undefined instruction or operand 
(defconstant $EXC_ARITHMETIC 3)
; #define EXC_ARITHMETIC		3	/* Arithmetic exception */
;  Exact nature of exception is in code field 
(defconstant $EXC_EMULATION 4)
; #define EXC_EMULATION		4	/* Emulation instruction */
;  Emulation support instruction encountered 
;  Details in code and subcode fields	
(defconstant $EXC_SOFTWARE 5)
; #define EXC_SOFTWARE		5	/* Software generated exception */
;  Exact exception is in code field. 
;  Codes 0 - 0xFFFF reserved to hardware 
;  Codes 0x10000 - 0x1FFFF reserved for OS emulation (Unix) 
(defconstant $EXC_BREAKPOINT 6)
; #define EXC_BREAKPOINT		6	/* Trace, breakpoint, etc. */
;  Details in code field. 
(defconstant $EXC_SYSCALL 7)
; #define EXC_SYSCALL		7	/* System calls. */
(defconstant $EXC_MACH_SYSCALL 8)
; #define EXC_MACH_SYSCALL	8	/* Mach system calls. */
(defconstant $EXC_RPC_ALERT 9)
; #define EXC_RPC_ALERT		9	/* RPC alert */
; 
;  *	Machine-independent exception behaviors
;  
; # define EXCEPTION_DEFAULT		1
; 	Send a catch_exception_raise message including the identity.
;  
; # define EXCEPTION_STATE		2
; 	Send a catch_exception_raise_state message including the
;  *	thread state.
;  
; # define EXCEPTION_STATE_IDENTITY	3
; 	Send a catch_exception_raise_state_identity message including
;  *	the thread identity and state.
;  
; 
;  * Masks for exception definitions, above
;  * bit zero is unused, therefore 1 word = 31 exception types
;  
(defconstant $EXC_MASK_BAD_ACCESS 2)
; #define EXC_MASK_BAD_ACCESS		(1 << EXC_BAD_ACCESS)
(defconstant $EXC_MASK_BAD_INSTRUCTION 4)
; #define EXC_MASK_BAD_INSTRUCTION	(1 << EXC_BAD_INSTRUCTION)
(defconstant $EXC_MASK_ARITHMETIC 8)
; #define EXC_MASK_ARITHMETIC		(1 << EXC_ARITHMETIC)
(defconstant $EXC_MASK_EMULATION 16)
; #define EXC_MASK_EMULATION		(1 << EXC_EMULATION)
(defconstant $EXC_MASK_SOFTWARE 32)
; #define EXC_MASK_SOFTWARE		(1 << EXC_SOFTWARE)
(defconstant $EXC_MASK_BREAKPOINT 64)
; #define EXC_MASK_BREAKPOINT		(1 << EXC_BREAKPOINT)
(defconstant $EXC_MASK_SYSCALL 128)
; #define EXC_MASK_SYSCALL		(1 << EXC_SYSCALL)
(defconstant $EXC_MASK_MACH_SYSCALL 256)
; #define EXC_MASK_MACH_SYSCALL		(1 << EXC_MACH_SYSCALL)
(defconstant $EXC_MASK_RPC_ALERT 512)
; #define EXC_MASK_RPC_ALERT		(1 << EXC_RPC_ALERT)
; #define EXC_MASK_ALL	(EXC_MASK_BAD_ACCESS |						 EXC_MASK_BAD_INSTRUCTION |					 EXC_MASK_ARITHMETIC |						 EXC_MASK_EMULATION |						 EXC_MASK_SOFTWARE |						 EXC_MASK_BREAKPOINT |						 EXC_MASK_SYSCALL |						 EXC_MASK_MACH_SYSCALL |					 EXC_MASK_RPC_ALERT |						 EXC_MASK_MACHINE)
(defconstant $FIRST_EXCEPTION 1)
; #define FIRST_EXCEPTION		1	/* ZERO is illegal */
; 
;  * Machine independent codes for EXC_SOFTWARE
;  * Codes 0x10000 - 0x1FFFF reserved for OS emulation (Unix) 
;  * 0x10000 - 0x10002 in use for unix signals
;  
(defconstant $EXC_SOFT_SIGNAL 65539)
; #define	EXC_SOFT_SIGNAL		0x10003	/* Unix signal exceptions */
; #ifndef	ASSEMBLER

(require-interface "mach/port")

(require-interface "mach/thread_status")

(require-interface "mach/machine/vm_types")
; 
;  * Exported types
;  

(def-mactype :exception_type_t (find-mactype ':signed-long))

(def-mactype :exception_data_type_t (find-mactype ':signed-long))

(def-mactype :exception_behavior_t (find-mactype ':signed-long))

(def-mactype :exception_data_t (find-mactype '(:pointer :signed-long)))

(def-mactype :exception_mask_t (find-mactype ':UInt32))

(def-mactype :exception_mask_array_t (find-mactype '(:pointer :UInt32)))

(def-mactype :exception_behavior_array_t (find-mactype '(:pointer :signed-long)))

(def-mactype :exception_flavor_array_t (find-mactype '(:pointer :thread_state_flavor_t)))

(def-mactype :exception_port_array_t (find-mactype '(:pointer :pointer)))

; #endif	/* ASSEMBLER */


; #endif	/* _MACH_EXCEPTION_TYPES_H_ */


(provide-interface "exception_types")