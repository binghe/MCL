(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vm_behavior.h"
; at Sunday July 2,2006 7:24:10 pm.
; 
;  * Copyright (c) 2000-2002 Apple Computer, Inc. All rights reserved.
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
;  *	File:	mach/vm_behavior.h
;  *
;  *	Virtual memory map behavior definitions.
;  *
;  
; #ifndef	_MACH_VM_BEHAVIOR_H_
; #define _MACH_VM_BEHAVIOR_H_
; 
;  *	Types defined:
;  *
;  *	vm_behavior_t	behavior codes.
;  

(def-mactype :vm_behavior_t (find-mactype ':signed-long))
; 
;  *	Enumeration of valid values for vm_behavior_t.
;  *	These describe expected page reference behavior for 
;  *	for a given range of virtual memory.  For implementation 
;  *	details see vm/vm_fault.c
;  
(defconstant $VM_BEHAVIOR_DEFAULT 0)
; #define VM_BEHAVIOR_DEFAULT	((vm_behavior_t) 0)	/* default */
(defconstant $VM_BEHAVIOR_RANDOM 1)
; #define VM_BEHAVIOR_RANDOM	((vm_behavior_t) 1)	/* random */
(defconstant $VM_BEHAVIOR_SEQUENTIAL 2)
; #define VM_BEHAVIOR_SEQUENTIAL	((vm_behavior_t) 2)	/* forward sequential */
(defconstant $VM_BEHAVIOR_RSEQNTL 3)
; #define VM_BEHAVIOR_RSEQNTL	((vm_behavior_t) 3)	/* reverse sequential */
(defconstant $VM_BEHAVIOR_WILLNEED 4)
; #define VM_BEHAVIOR_WILLNEED	((vm_behavior_t) 4)	/* will need in near future */
(defconstant $VM_BEHAVIOR_DONTNEED 5)
; #define VM_BEHAVIOR_DONTNEED	((vm_behavior_t) 5)	/* dont need in near future */

; #endif	/*_MACH_VM_BEHAVIOR_H_*/


(provide-interface "vm_behavior")