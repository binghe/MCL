(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ipc_types.h"
; at Sunday July 2,2006 7:26:25 pm.
; 
;  * Copyright (c) 2002,2000 Apple Computer, Inc. All rights reserved.
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
;  * Define Basic IPC types available to callers.
;  * These are not intended to be used directly, but
;  * are used to define other types available through
;  * port.h and mach_types.h for in-kernel entities.
;  
; #ifndef	_IPC_TYPES_H_
; #define	_IPC_TYPES_H_

(require-interface "mach/port")

(require-interface "mach/message")

(require-interface "mach/mach_types")

; #if !defined(MACH_KERNEL_PRIVATE)
; 
;  * For kernel code that resides outside of mach
;  * we define empty structs so that everything will
;  * remain strongly typed, without giving out
;  * implementation details.
;  

; #endif /* !MACH_KERNEL_PRIVATE */


(def-mactype :ipc_object_t (find-mactype '(:pointer :ipc_object)))
(defconstant $IPC_OBJECT_NULL 0)
; #define IPC_OBJECT_NULL		((ipc_object_t) 0)
; #define IPC_OBJECT_DEAD		((ipc_object_t)~0)
; #define IPC_OBJECT_VALID(io)	(((io) != IPC_OBJECT_NULL) && 				 ((io) != IPC_OBJECT_DEAD))

(def-mactype :mach_msg_continue_t (find-mactype ':pointer)); (mach_msg_return_t)
;  after wakeup 

; #endif	/* _IPC_TYPES_H_ */


(provide-interface "ipc_types")