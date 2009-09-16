(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:host.h"
; at Sunday July 2,2006 7:27:56 pm.
; 
;  * Copyright (c) 2000-2003 Apple Computer, Inc. All rights reserved.
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
;  * Copyright (c) 1991,1990,1989,1988 Carnegie Mellon University
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
;  *	kern/host.h
;  *
;  *	Definitions for host data structures.
;  *
;  
; #ifndef	_KERN_HOST_H_
; #define _KERN_HOST_H_

(require-interface "mach/mach_types")

(require-interface "sys/appleapiopts")
; #ifdef	__APPLE_API_PRIVATE
#| #|

#ifdefMACH_KERNEL_PRIVATE
#include <kernlock.h>
#include <kernexception.h>
#include <machexception_types.h>
#include <machhost_special_ports.h>
#include <kernkern_types.h>


struct	host {
	decl_mutex_data(,lock)		
	ipc_port_t special[HOST_MAX_SPECIAL_PORT + 1];
	struct exception_action exc_actions[EXC_TYPES_COUNT];
};

typedef struct host	host_data_t;

extern host_data_t	realhost;

#define host_lock(host)		mutex_lock(&(host)->lock)
#define host_unlock(host)	mutex_unlock(&(host)->lock)

#endif

#endif
|#
 |#
;  __APPLE_API_PRIVATE 
; 
;  * Access routines for inside the kernel.
;  

(deftrap-inline "_host_self" 
   (
   )
   :pointer
() )

(deftrap-inline "_host_priv_self" 
   (
   )
   :pointer
() )

(deftrap-inline "_host_security_self" 
   (
   )
   :pointer
() )

; #endif	/* _KERN_HOST_H_ */


(provide-interface "host")