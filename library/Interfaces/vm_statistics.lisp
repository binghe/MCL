(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vm_statistics.h"
; at Sunday July 2,2006 7:24:01 pm.
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
;  *	File:	mach/vm_statistics.h
;  *	Author:	Avadis Tevanian, Jr., Michael Wayne Young, David Golub
;  *
;  *	Virtual memory statistics structure.
;  *
;  
; #ifndef	VM_STATISTICS_H_
; #define	VM_STATISTICS_H_

(require-interface "mach/machine/vm_types")
(defrecord vm_statistics
   (free_count :signed-long)
                                                ;  # of pages free 
   (active_count :signed-long)
                                                ;  # of pages active 
   (inactive_count :signed-long)
                                                ;  # of pages inactive 
   (wire_count :signed-long)
                                                ;  # of pages wired down 
   (zero_fill_count :signed-long)
                                                ;  # of zero fill pages 
   (reactivations :signed-long)
                                                ;  # of pages reactivated 
   (pageins :signed-long)
                                                ;  # of pageins 
   (pageouts :signed-long)
                                                ;  # of pageouts 
   (faults :signed-long)
                                                ;  # of faults 
   (cow_faults :signed-long)
                                                ;  # of copy-on-writes 
   (lookups :signed-long)
                                                ;  object cache lookups 
   (hits :signed-long)
                                                ;  object cache hits 
)

(def-mactype :vm_statistics_t (find-mactype '(:pointer :vm_statistics)))

(%define-record :vm_statistics_data_t (find-record-descriptor ':vm_statistics))
;  included for the vm_map_page_query call 
(defconstant $VM_PAGE_QUERY_PAGE_PRESENT 1)
; #define VM_PAGE_QUERY_PAGE_PRESENT      0x1
(defconstant $VM_PAGE_QUERY_PAGE_FICTITIOUS 2)
; #define VM_PAGE_QUERY_PAGE_FICTITIOUS   0x2
(defconstant $VM_PAGE_QUERY_PAGE_REF 4)
; #define VM_PAGE_QUERY_PAGE_REF          0x4
(defconstant $VM_PAGE_QUERY_PAGE_DIRTY 8)
; #define VM_PAGE_QUERY_PAGE_DIRTY        0x8
; 
;  *	Each machine dependent implementation is expected to
;  *	keep certain statistics.  They may do this anyway they
;  *	so choose, but are expected to return the statistics
;  *	in the following structure.
;  
(defrecord pmap_statistics
   (resident_count :signed-long)
                                                ;  # of pages mapped (total)
   (wired_count :signed-long)
                                                ;  # of pages wired 
)

(def-mactype :pmap_statistics_t (find-mactype '(:pointer :pmap_statistics)))
(defconstant $VM_FLAGS_FIXED 0)
; #define VM_FLAGS_FIXED		0x0
(defconstant $VM_FLAGS_ANYWHERE 1)
; #define VM_FLAGS_ANYWHERE	0x1
(defconstant $VM_FLAGS_ALIAS_MASK 4278190080)
; #define VM_FLAGS_ALIAS_MASK	0xFF000000
; #define VM_GET_FLAGS_ALIAS(flags, alias)					(alias) = ((flags) & VM_FLAGS_ALIAS_MASK) >> 24	
; #define VM_SET_FLAGS_ALIAS(flags, alias)					(flags) = (((flags) & ~VM_FLAGS_ALIAS_MASK) |			(((alias) & ~VM_FLAGS_ALIAS_MASK) << 24))
(defconstant $VM_MEMORY_MALLOC 1)
; #define VM_MEMORY_MALLOC 1
(defconstant $VM_MEMORY_MALLOC_SMALL 2)
; #define VM_MEMORY_MALLOC_SMALL 2
(defconstant $VM_MEMORY_MALLOC_LARGE 3)
; #define VM_MEMORY_MALLOC_LARGE 3
(defconstant $VM_MEMORY_MALLOC_HUGE 4)
; #define VM_MEMORY_MALLOC_HUGE 4
(defconstant $VM_MEMORY_SBRK 5)
; #define VM_MEMORY_SBRK 5// uninteresting -- no one should call
(defconstant $VM_MEMORY_REALLOC 6)
; #define VM_MEMORY_REALLOC 6
(defconstant $VM_MEMORY_MALLOC_TINY 7)
; #define VM_MEMORY_MALLOC_TINY 7
(defconstant $VM_MEMORY_ANALYSIS_TOOL 10)
; #define VM_MEMORY_ANALYSIS_TOOL 10
(defconstant $VM_MEMORY_MACH_MSG 20)
; #define VM_MEMORY_MACH_MSG 20
(defconstant $VM_MEMORY_IOKIT 21)
; #define VM_MEMORY_IOKIT	21
(defconstant $VM_MEMORY_STACK 30)
; #define VM_MEMORY_STACK  30
(defconstant $VM_MEMORY_GUARD 31)
; #define VM_MEMORY_GUARD  31
(defconstant $VM_MEMORY_SHARED_PMAP 32)
; #define	VM_MEMORY_SHARED_PMAP 32
;  memory containing a dylib 
(defconstant $VM_MEMORY_DYLIB 33)
; #define VM_MEMORY_DYLIB	33
;  Placeholders for now -- as we analyze the libraries and find how they
;  use memory, we can make these labels more specific.
(defconstant $VM_MEMORY_APPKIT 40)
; #define VM_MEMORY_APPKIT 40
(defconstant $VM_MEMORY_FOUNDATION 41)
; #define VM_MEMORY_FOUNDATION 41
(defconstant $VM_MEMORY_COREGRAPHICS 42)
; #define VM_MEMORY_COREGRAPHICS 42
(defconstant $VM_MEMORY_CARBON 43)
; #define VM_MEMORY_CARBON 43
(defconstant $VM_MEMORY_JAVA 44)
; #define VM_MEMORY_JAVA 44
(defconstant $VM_MEMORY_ATS 50)
; #define VM_MEMORY_ATS 50
;  memory allocated by the dynamic loader for itself 
(defconstant $VM_MEMORY_DYLD 60)
; #define VM_MEMORY_DYLD 60
;  malloc'd memory created by dyld 
(defconstant $VM_MEMORY_DYLD_MALLOC 61)
; #define VM_MEMORY_DYLD_MALLOC 61
;  Reserve 240-255 for application 
(defconstant $VM_MEMORY_APPLICATION_SPECIFIC_1 240)
; #define VM_MEMORY_APPLICATION_SPECIFIC_1 240
(defconstant $VM_MEMORY_APPLICATION_SPECIFIC_16 255)
; #define VM_MEMORY_APPLICATION_SPECIFIC_16 255
; #define VM_MAKE_TAG(tag) (tag<<24)

; #endif	/* VM_STATISTICS_H_ */


(provide-interface "vm_statistics")