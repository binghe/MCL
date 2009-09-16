(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vm_kern.h"
; at Sunday July 2,2006 7:32:14 pm.
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
; 
;  *	File:	vm/vm_kern.h
;  *	Author:	Avadis Tevanian, Jr., Michael Wayne Young
;  *	Date:	1985
;  *
;  *	Kernel memory management definitions.
;  
; #ifndef	_VM_VM_KERN_H_
; #define _VM_VM_KERN_H_

(require-interface "mach/boolean")

(require-interface "mach/kern_return")

(require-interface "mach/machine/vm_types")

(require-interface "vm/vm_map")

(deftrap-inline "_kmem_init" 
   ((start :UInt32)
    (end :UInt32)
   )
   nil
() )

(deftrap-inline "_kernel_memory_allocate" 
   ((map :vm_map_t)
    (addrp (:pointer :vm_offset_t))
    (size :UInt32)
    (mask :UInt32)
    (flags :signed-long)
   )
   :signed-long
() )
;  flags for kernel_memory_allocate 
(defconstant $KMA_HERE 1)
; #define KMA_HERE	0x01
(defconstant $KMA_NOPAGEWAIT 2)
; #define KMA_NOPAGEWAIT	0x02
(defconstant $KMA_KOBJECT 4)
; #define KMA_KOBJECT	0x04

(deftrap-inline "_kmem_alloc_contig" 
   ((map :vm_map_t)
    (addrp (:pointer :vm_offset_t))
    (size :UInt32)
    (mask :UInt32)
    (flags :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_kmem_alloc" 
   ((map :vm_map_t)
    (addrp (:pointer :vm_offset_t))
    (size :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_kmem_alloc_pageable" 
   ((map :vm_map_t)
    (addrp (:pointer :vm_offset_t))
    (size :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_kmem_alloc_wired" 
   ((map :vm_map_t)
    (addrp (:pointer :vm_offset_t))
    (size :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_kmem_alloc_aligned" 
   ((map :vm_map_t)
    (addrp (:pointer :vm_offset_t))
    (size :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_kmem_realloc" 
   ((map :vm_map_t)
    (oldaddr :UInt32)
    (oldsize :UInt32)
    (newaddrp (:pointer :vm_offset_t))
    (newsize :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_kmem_free" 
   ((map :vm_map_t)
    (addr :UInt32)
    (size :UInt32)
   )
   nil
() )

(deftrap-inline "_kmem_suballoc" 
   ((parent :vm_map_t)
    (addr (:pointer :vm_offset_t))
    (size :UInt32)
    (pageable :signed-long)
    (anywhere :signed-long)
    (new_map (:pointer :vm_map_t))
   )
   :signed-long
() )

(deftrap-inline "_kmem_io_object_deallocate" 
   ((copy :vm_map_copy_t)
   )
   nil
() )

(deftrap-inline "_kmem_io_object_trunc" 
   ((copy :vm_map_copy_t)
    (new_size :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_copyinmap" 
   ((map :vm_map_t)
    (fromaddr :UInt32)
    (toaddr :UInt32)
    (length :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_copyoutmap" 
   ((map :vm_map_t)
    (fromaddr :UInt32)
    (toaddr :UInt32)
    (length :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_vm_conflict_check" 
   ((map :vm_map_t)
    (off :UInt32)
    (len :UInt32)
    (pager :memory_object_t)
    (file_off :vm_object_offset_t)
   )
   :signed-long
() )
(def-mactype :kernel_map (find-mactype ':vm_map_t))
(def-mactype :kernel_pageable_map (find-mactype ':vm_map_t))
(def-mactype :ipc_kernel_map (find-mactype ':vm_map_t))

; #endif	/* _VM_VM_KERN_H_ */


(provide-interface "vm_kern")