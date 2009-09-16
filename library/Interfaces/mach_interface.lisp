(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:mach_interface.h"
; at Sunday July 2,2006 7:25:43 pm.
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
;  * Copyright (C) Apple Computer 1998
;  * ALL Rights Reserved
;  
; 
;  * This file represents the interfaces that used to come
;  * from creating the user headers from the mach.defs file.
;  * Because mach.defs was decomposed, this file now just
;  * wraps up all the new interface headers generated from
;  * each of the new .defs resulting from that decomposition.
;  
; #ifndef	_MACH_INTERFACE_H_
; #define _MACH_INTERFACE_H_

(require-interface "mach/clock")

(require-interface "mach/clock_priv")

(require-interface "mach/clock_reply_server")

(require-interface "mach/exc_server")

(require-interface "mach/host_priv")

(require-interface "mach/host_security")

(require-interface "mach/ledger")

(require-interface "mach/lock_set")

(require-interface "mach/mach_host")

(require-interface "mach/mach_port")

(require-interface "mach/memory_object_server")

(require-interface "mach/memory_object_default_server")

(require-interface "mach/memory_object_control")

(require-interface "mach/memory_object_name")

(require-interface "mach/notify_server")

(require-interface "mach/processor")

(require-interface "mach/processor_set")

(require-interface "mach/semaphore")

(require-interface "mach/task")

(require-interface "mach/thread_act")

(require-interface "mach/vm_map")

; #endif /* _MACH_INTERFACE_H_ */


(provide-interface "mach_interface")