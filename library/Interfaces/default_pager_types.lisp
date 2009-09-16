(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:default_pager_types.h"
; at Sunday July 2,2006 7:27:30 pm.
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
; #ifndef	_MACH_DEFAULT_PAGER_TYPES_H_
; #define _MACH_DEFAULT_PAGER_TYPES_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_UNSTABLE
#| #|

#include <machmach_types.h>
#include <machmachinevm_types.h>
#include <machmemory_object_types.h>

typedef	memory_object_default_t	default_pager_t;

#ifdefMACH_KERNEL_PRIVATE



typedef struct default_pager_info {
	vm_size_t dpi_total_space;	
	vm_size_t dpi_free_space;	
	vm_size_t dpi_page_size;	
} default_pager_info_t;

typedef integer_t *backing_store_info_t;
typedef int	backing_store_flavor_t;
typedef int	*vnode_ptr_t;

#define BACKING_STORE_BASIC_INFO	1
#define BACKING_STORE_BASIC_INFO_COUNT \
		(sizeof(struct backing_store_basic_info)sizeof(integer_t))
struct backing_store_basic_info {
	natural_t	pageout_calls;		
	natural_t	pagein_calls;		
	natural_t	pages_in;		
	natural_t	pages_out;		
	natural_t	pages_unavail;		
	natural_t	pages_init;		
	natural_t	pages_init_writes;	

	natural_t	bs_pages_total;		
	natural_t	bs_pages_free;		
	natural_t	bs_pages_in;		
	natural_t	bs_pages_in_fail;	
	natural_t	bs_pages_out;		
	natural_t	bs_pages_out_fail;	

	integer_t	bs_priority;
	integer_t	bs_clsize;
};
typedef struct backing_store_basic_info	*backing_store_basic_info_t;


typedef struct default_pager_object {
	vm_offset_t dpo_object;		
	vm_size_t dpo_size;		
} default_pager_object_t;

typedef default_pager_object_t *default_pager_object_array_t;

typedef struct default_pager_page {
	vm_offset_t dpp_offset;		
} default_pager_page_t;

typedef default_pager_page_t *default_pager_page_array_t;

#endif

#define DEFAULT_PAGER_BACKING_STORE_MAXPRI	4

#define HI_WAT_ALERT	1
#define LO_WAT_ALERT	2

#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif	/* _MACH_DEFAULT_PAGER_TYPES_H_ */


(provide-interface "default_pager_types")