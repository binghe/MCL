(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vm_info.h"
; at Sunday July 2,2006 7:26:02 pm.
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
;  * Copyright (c) 1991,1990 Carnegie Mellon University
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
;  *	File:	mach_debug/vm_info.h
;  *	Author:	Rich Draves
;  *	Date:	March, 1990
;  *
;  *	Definitions for the VM debugging interface.
;  
; #ifndef	_MACH_DEBUG_VM_INFO_H_
; #define _MACH_DEBUG_VM_INFO_H_

(require-interface "mach/boolean")

(require-interface "mach/machine/vm_types")

(require-interface "mach/vm_inherit")

(require-interface "mach/vm_prot")

(require-interface "mach/memory_object_types")
; 
;  *	Remember to update the mig type definitions
;  *	in mach_debug_types.defs when adding/removing fields.
;  
(defrecord vm_info_region_64
   (vir_start :UInt32)
                                                ;  start of region 
   (vir_end :UInt32)
                                                ;  end of region 
   (vir_object :UInt32)
                                                ;  the mapped object 
   (vir_offset :vm_object_offset_t)
#|
; Warning: type-size: unknown type VM_OBJECT_OFFSET_T
|#
                                                ;  offset into object 
   (vir_needs_copy :signed-long)
                                                ;  does object need to be copied? 
   (vir_protection :signed-long)
                                                ;  protection code 
   (vir_max_protection :signed-long)
                                                ;  maximum protection 
   (vir_inheritance :UInt32)
                                                ;  inheritance 
   (vir_wired_count :UInt32)
                                                ;  number of times wired 
   (vir_user_wired_count :UInt32)               ;  number of times user has wired 
)
(%define-record :vm_info_region_64_t (find-record-descriptor :VM_INFO_REGION_64))
(defrecord vm_info_region
   (vir_start :UInt32)
                                                ;  start of region 
   (vir_end :UInt32)
                                                ;  end of region 
   (vir_object :UInt32)
                                                ;  the mapped object 
   (vir_offset :UInt32)
                                                ;  offset into object 
   (vir_needs_copy :signed-long)
                                                ;  does object need to be copied? 
   (vir_protection :signed-long)
                                                ;  protection code 
   (vir_max_protection :signed-long)
                                                ;  maximum protection 
   (vir_inheritance :UInt32)
                                                ;  inheritance 
   (vir_wired_count :UInt32)
                                                ;  number of times wired 
   (vir_user_wired_count :UInt32)               ;  number of times user has wired 
)
(%define-record :vm_info_region_t (find-record-descriptor :VM_INFO_REGION))
(defrecord vm_info_object
   (vio_object :UInt32)
                                                ;  this object 
   (vio_size :UInt32)
                                                ;  object size (valid if internal) 
   (vio_ref_count :UInt32)
                                                ;  number of references 
   (vio_resident_page_count :UInt32)            ;  number of resident pages 
   (vio_absent_count :UInt32)
                                                ;  number requested but not filled 
   (vio_copy :UInt32)
                                                ;  copy object 
   (vio_shadow :UInt32)
                                                ;  shadow object 
   (vio_shadow_offset :UInt32)
                                                ;  offset into shadow object 
   (vio_paging_offset :UInt32)
                                                ;  offset into memory object 
   (vio_copy_strategy :memory_object_copy_strategy_t)
#|
; Warning: type-size: unknown type MEMORY_OBJECT_COPY_STRATEGY_T
|#
                                                ;  how to handle data copy 
   (vio_last_alloc :UInt32)
                                                ;  offset of last allocation 
                                                ;  many random attributes 
   (vio_paging_in_progress :UInt32)
   (vio_pager_created :signed-long)
   (vio_pager_initialized :signed-long)
   (vio_pager_ready :signed-long)
   (vio_can_persist :signed-long)
   (vio_internal :signed-long)
   (vio_temporary :signed-long)
   (vio_alive :signed-long)
   (vio_lock_in_progress :signed-long)
   (vio_lock_restart :signed-long)
)
(%define-record :vm_info_object_t (find-record-descriptor :VM_INFO_OBJECT))

(def-mactype :vm_info_object_array_t (find-mactype '(:pointer :VM_INFO_OBJECT)))

; #endif	/* _MACH_DEBUG_VM_INFO_H_ */


(provide-interface "vm_info")