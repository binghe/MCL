(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:device_types.h"
; at Sunday July 2,2006 7:24:15 pm.
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
;  * Copyright (c) 1991,1990,1989 Carnegie Mellon University
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
; 
;  *	Author: David B. Golub, Carnegie Mellon University
;  *	Date: 	3/89
;  
; #ifndef	DEVICE_TYPES_H
; #define	DEVICE_TYPES_H
; 
;  * Types for device interface.
;  

(require-interface "mach/std_types")

(require-interface "mach/port")
; 
;  * IO buffer - out-of-line array of characters.
;  

(def-mactype :io_buf_ptr_t (find-mactype '(:pointer :character)))
; 
;  * Some types for IOKit.
;  
; #ifdef IOKIT
;  must match device_types.defs 
(defrecord io_name_t
   (contents (:array :character 128))
)
(defrecord io_string_t
   (contents (:array :character 512))
)
(defrecord io_struct_inband_t
   (contents (:array :character 4096))
)
(defrecord io_scalar_inband_t
   (contents (:array :signed-long 16))
)
(defrecord io_async_ref_t
   (contents (:array :UInt32 8))
); #ifdef MACH_KERNEL
#| #|

typedef struct IOObject * io_object_t;
typedef io_object_t io_connect_t;

extern void iokit_remove_reference( io_object_t	obj );

extern io_object_t iokit_lookup_object_port( ipc_port_t port );
extern io_connect_t iokit_lookup_connect_port( ipc_port_t port );

extern ipc_port_t iokit_make_object_port( io_object_t obj );
extern ipc_port_t iokit_make_connect_port( io_connect_t obj );

|#
 |#

; #else
; #ifndef	__IOKIT_PORTS_DEFINED__
#| #|
#define __IOKIT_PORTS_DEFINED__
typedef mach_port_t	io_object_t;
#endif
|#
 |#
;  __IOKIT_PORTS_DEFINED__ 

; #endif  /* MACH_KERNEL */


; #endif  /* IOKIT */


; #endif	/* DEVICE_TYPES_H */


(provide-interface "device_types")