(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:zalloc.h"
; at Sunday July 2,2006 7:32:19 pm.
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
;  *	File:	zalloc.h
;  *	Author:	Avadis Tevanian, Jr.
;  *	Date:	 1985
;  *
;  
; #ifndef	_KERN_ZALLOC_H_
; #define _KERN_ZALLOC_H_

(require-interface "mach/machine/vm_types")

(require-interface "kern/kern_types")

(require-interface "sys/appleapiopts")
; #ifdef	__APPLE_API_PRIVATE
#| #|

#ifdefMACH_KERNEL_PRIVATE

#include <zone_debug.h>
#include <mach_kdb.h>
#include <kernlock.h>
#include <kernqueue.h>
#include <kerncall_entry.h>



struct zone {
	int		count;		
	vm_offset_t	free_elements;
	vm_size_t	cur_size;	
	vm_size_t	max_size;	
	vm_size_t	elem_size;	
	vm_size_t	alloc_size;	
	char		*zone_name;	
	unsigned int
	 exhaustible :1,	
		collectable :1,	
		expandable :1,	
	 allows_foreign :1,
		doing_alloc :1,	
		waiting :1,	
		async_pending :1;	
	struct zone *	next_zone;	
	call_entry_data_t	call_async_alloc;	
#ifZONE_DEBUG
	queue_head_t	active_zones;	
#endif
	decl_simple_lock_data(,lock)		
};

extern void		zone_gc(void);
extern void		consider_zone_gc(void);


extern void		zone_steal_memory(void);


extern void		zone_bootstrap(void);


extern void		zone_init(vm_size_t);

#endif

#endif
|#
 |#
;  __APPLE_API_PRIVATE 
;  Allocate from zone 

(deftrap-inline "_zalloc" 
   ((zone (:pointer :zone))
   )
   :UInt32
() )
;  Non-blocking version of zalloc 

(deftrap-inline "_zalloc_noblock" 
   ((zone (:pointer :zone))
   )
   :UInt32
() )
;  Get from zone free list 

(deftrap-inline "_zget" 
   ((zone (:pointer :zone))
   )
   :UInt32
() )
;  Create zone 

(deftrap-inline "_zinit" 
   ((size :UInt32)
                                                ;  the size of an element 
    (max :UInt32)
                                                ;  maximum memory to use 
    (alloc :UInt32)
                                                ;  allocation size 
    (name (:pointer :char))
   )
   (:pointer :zone)
() )
;  a name for the zone 
;  Free zone element 

(deftrap-inline "_zfree" 
   ((zone (:pointer :zone))
    (elem :UInt32)
   )
   nil
() )
;  Fill zone with memory 

(deftrap-inline "_zcram" 
   ((zone (:pointer :zone))
    (newmem :UInt32)
    (size :UInt32)
   )
   nil
() )
;  Initially fill zone with specified number of elements 

(deftrap-inline "_zfill" 
   ((zone (:pointer :zone))
    (nelem :signed-long)
   )
   :signed-long
() )
;  Change zone parameters 

(deftrap-inline "_zone_change" 
   ((zone (:pointer :zone))
    (item :UInt32)
    (value :signed-long)
   )
   nil
() )
;  Preallocate space for zone from zone map 

(deftrap-inline "_zprealloc" 
   ((zone (:pointer :zone))
    (size :UInt32)
   )
   nil
() )
; 
;  * zone_free_count returns a hint as to the current number of free elements
;  * in the zone.  By the time it returns, it may no longer be true (a new
;  * element might have been added, or an element removed).
;  * This routine may be used in conjunction with zcram and a lock to regulate
;  * adding memory to a non-expandable zone.
;  

(deftrap-inline "_zone_free_count" 
   ((zone (:pointer :zone))
   )
   :signed-long
() )
; 
;  * Item definitions for zone_change:
;  
(defconstant $Z_EXHAUST 1)
; #define Z_EXHAUST	1	/* Make zone exhaustible	*/
(defconstant $Z_COLLECT 2)
; #define Z_COLLECT	2	/* Make zone collectable	*/
(defconstant $Z_EXPAND 3)
; #define Z_EXPAND	3	/* Make zone expandable		*/
(defconstant $Z_FOREIGN 4)
; #define	Z_FOREIGN	4	/* Allow collectable zone to contain foreign */
;  (not allocated via zalloc) elements. 
; #ifdef	__APPLE_API_PRIVATE
#| #|

#ifdefMACH_KERNEL_PRIVATE

#ifZONE_DEBUG

#ifMACH_KDB

extern vm_offset_t	next_element(
				zone_t		z,
				vm_offset_t	elt);

extern vm_offset_t	first_element(
				zone_t		z);

#endif

extern void		zone_debug_enable(
				zone_t		z);

extern void		zone_debug_disable(
				zone_t		z);

#endif

#endif

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif	/* _KERN_ZALLOC_H_ */


(provide-interface "zalloc")