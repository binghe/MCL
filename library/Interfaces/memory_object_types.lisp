(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:memory_object_types.h"
; at Sunday July 2,2006 7:24:03 pm.
; 
;  * Copyright (c) 2000-2001 Apple Computer, Inc. All rights reserved.
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
;  
; 
;  *	File:	memory_object.h
;  *	Author:	Michael Wayne Young
;  *
;  *	External memory management interface definition.
;  
; #ifndef	_MACH_MEMORY_OBJECT_TYPES_H_
; #define _MACH_MEMORY_OBJECT_TYPES_H_
; 
;  *	User-visible types used in the external memory
;  *	management interface:
;  

(require-interface "mach/port")

(require-interface "mach/vm_types")

(require-interface "mach/machine/vm_types")

(require-interface "sys/appleapiopts")
; #define VM_64_BIT_DATA_OBJECTS

;type name? (def-mactype :long (find-mactype ':UInt32)); memory_object_offset_t

;type name? (def-mactype :long (find-mactype ':UInt32)); memory_object_size_t
; #ifdef __APPLE_API_EVOLVING
#| #|

#ifdefKERNEL_PRIVATE
typedef struct 		memory_object {
	int		*pager;
} *memory_object_t;

typedef struct		memory_object_control {
	struct vm_object *object;
} *memory_object_control_t;

#else

typedef mach_port_t	memory_object_t;
typedef mach_port_t	memory_object_control_t;

#endif

typedef memory_object_t *memory_object_array_t;
					
					
					

typedef	mach_port_t	memory_object_name_t;
					
					

typedef mach_port_t	memory_object_default_t;
					
					

#define MEMORY_OBJECT_NULL		((memory_object_t) 0)
#define MEMORY_OBJECT_CONTROL_NULL	((memory_object_control_t) 0)
#define MEMORY_OBJECT_NAME_NULL		((memory_object_name_t) 0)
#define MEMORY_OBJECT_DEFAULT_NULL	((memory_object_default_t) 0)


typedef	int		memory_object_copy_strategy_t;
					
#define 	MEMORY_OBJECT_COPY_NONE		0
					
#define 	MEMORY_OBJECT_COPY_CALL		1
					
#define 	MEMORY_OBJECT_COPY_DELAY 	2
					
#define 	MEMORY_OBJECT_COPY_TEMPORARY 	3
					
#define 	MEMORY_OBJECT_COPY_SYMMETRIC 	4
					

#define 	MEMORY_OBJECT_COPY_INVALID	5
					

typedef	int		memory_object_return_t;
					
#define 	MEMORY_OBJECT_RETURN_NONE	0
					
#define 	MEMORY_OBJECT_RETURN_DIRTY	1
					
#define 	MEMORY_OBJECT_RETURN_ALL	2
					
#define 	MEMORY_OBJECT_RETURN_ANYTHING	3
					



#define 	MEMORY_OBJECT_DATA_FLUSH 	0x1
#define 	MEMORY_OBJECT_DATA_NO_CHANGE	0x2
#define 	MEMORY_OBJECT_DATA_PURGE	0x4
#define 	MEMORY_OBJECT_COPY_SYNC		0x8
#define 	MEMORY_OBJECT_DATA_SYNC		0x10



#define MEMORY_OBJECT_INFO_MAX      (1024) 
typedef int     *memory_object_info_t;      
typedef int	 memory_object_flavor_t;
typedef int      memory_object_info_data_t[MEMORY_OBJECT_INFO_MAX];


#define MEMORY_OBJECT_PERFORMANCE_INFO	11
#define MEMORY_OBJECT_ATTRIBUTE_INFO	14
#define MEMORY_OBJECT_BEHAVIOR_INFO 	15	

#ifdef __APPLE_API_UNSTABLE
#define OLD_MEMORY_OBJECT_BEHAVIOR_INFO 	10	
#define OLD_MEMORY_OBJECT_ATTRIBUTE_INFO	12

struct old_memory_object_behave_info {
	memory_object_copy_strategy_t	copy_strategy;	
	boolean_t			temporary;
	boolean_t			invalidate;
};

struct old_memory_object_attr_info {			
        boolean_t       		object_ready;
        boolean_t       		may_cache;
        memory_object_copy_strategy_t 	copy_strategy;
};

typedef struct old_memory_object_behave_info *old_memory_object_behave_info_t;
typedef struct old_memory_object_behave_info old_memory_object_behave_info_data_t;
typedef struct old_memory_object_attr_info *old_memory_object_attr_info_t;
typedef struct old_memory_object_attr_info old_memory_object_attr_info_data_t;

#define OLD_MEMORY_OBJECT_BEHAVE_INFO_COUNT   	\
                (sizeof(old_memory_object_behave_info_data_t)sizeof(int))
#define OLD_MEMORY_OBJECT_ATTR_INFO_COUNT		\
		(sizeof(old_memory_object_attr_info_data_t)sizeof(int))
#endif 

struct memory_object_perf_info {
	vm_size_t			cluster_size;
	boolean_t			may_cache;
};

struct memory_object_attr_info {
	memory_object_copy_strategy_t	copy_strategy;
	vm_offset_t			cluster_size;
	boolean_t			may_cache_object;
	boolean_t			temporary;
};

struct memory_object_behave_info {
	memory_object_copy_strategy_t	copy_strategy;	
	boolean_t			temporary;
	boolean_t			invalidate;
	boolean_t			silent_overwrite;
	boolean_t			advisory_pageout;
};


typedef struct memory_object_behave_info *memory_object_behave_info_t;
typedef struct memory_object_behave_info memory_object_behave_info_data_t;

typedef struct memory_object_perf_info 	*memory_object_perf_info_t;
typedef struct memory_object_perf_info	memory_object_perf_info_data_t;

typedef struct memory_object_attr_info	*memory_object_attr_info_t;
typedef struct memory_object_attr_info	memory_object_attr_info_data_t;

#define MEMORY_OBJECT_BEHAVE_INFO_COUNT   	\
                (sizeof(memory_object_behave_info_data_t)sizeof(int))
#define MEMORY_OBJECT_PERF_INFO_COUNT		\
		(sizeof(memory_object_perf_info_data_t)sizeof(int))
#define MEMORY_OBJECT_ATTR_INFO_COUNT		\
		(sizeof(memory_object_attr_info_data_t)sizeof(int))

#define invalid_memory_object_flavor(f)					\
	(f != MEMORY_OBJECT_ATTRIBUTE_INFO && 				\
	 f != MEMORY_OBJECT_PERFORMANCE_INFO && 			\
	 f != OLD_MEMORY_OBJECT_BEHAVIOR_INFO &&			\
	 f != MEMORY_OBJECT_BEHAVIOR_INFO &&				\
	 f != OLD_MEMORY_OBJECT_ATTRIBUTE_INFO)



#define MEMORY_OBJECT_TERMINATE_IDLE	0x1
#define MEMORY_OBJECT_RESPECT_CACHE	0x2
#define MEMORY_OBJECT_RELEASE_NO_OP	0x4




#define MAX_UPL_TRANSFER 256

struct upl_page_info {
	vm_offset_t	phys_addr;
        unsigned int
                        pageout:1,      
                        absent:1,       
                        dirty:1,        
			precious:1,     
			device:1,	
                        :0;		
};

typedef struct upl_page_info	upl_page_info_t;
typedef upl_page_info_t		*upl_page_info_array_t;
typedef upl_page_info_array_t	upl_page_list_ptr_t;



#define MAP_MEM_NOOP		0
#define MAP_MEM_COPYBACK	1
#define MAP_MEM_IO		2
#define MAP_MEM_WTHRU		3
#define MAP_MEM_WCOMB		4	
					

#define GET_MAP_MEM(flags)	\
	((((unsigned int)(flags)) >> 24) & 0xFF)

#define SET_MAP_MEM(caching, flags)	\
	((flags) = ((((unsigned int)(caching)) << 24) \
			& 0xFF000000) | ((flags) & 0xFFFFFF));


#define MAP_MEM_ONLY		0x10000	
#define MAP_MEM_NAMED_CREATE	0x20000 




#define UPL_FLAGS_NONE		0x0
#define UPL_COPYOUT_FROM	0x1
#define UPL_PRECIOUS		0x2
#define UPL_NO_SYNC		0x4
#define UPL_CLEAN_IN_PLACE	0x8
#define UPL_NOBLOCK		0x10
#define UPL_RET_ONLY_DIRTY	0x20
#define UPL_SET_INTERNAL	0x40
#define UPL_QUERY_OBJECT_TYPE	0x80
#define UPL_RET_ONLY_ABSENT	0x100  
#define UPL_FILE_IO             0x200
#define UPL_SET_LITE		0x400
#define UPL_SET_INTERRUPTIBLE	0x800
#define UPL_SET_IO_WIRE		0x1000
#define UPL_FOR_PAGEOUT		0x2000
#define UPL_WILL_BE_DUMPED      0x4000



#define UPL_ABORT_RESTART	0x1
#define UPL_ABORT_UNAVAILABLE	0x2
#define UPL_ABORT_ERROR		0x4
#define UPL_ABORT_FREE_ON_EMPTY	0x8  
#define UPL_ABORT_DUMP_PAGES	0x10
#define UPL_ABORT_NOTIFY_EMPTY	0x20


#define UPL_CHECK_DIRTY         0x1


#define UPL_IOSYNC	0x1
#define UPL_NOCOMMIT	0x2
#define UPL_NORDAHEAD   0x4


#define UPL_COMMIT_FREE_ON_EMPTY	0x1 
#define UPL_COMMIT_CLEAR_DIRTY		0x2
#define UPL_COMMIT_SET_DIRTY		0x4
#define UPL_COMMIT_INACTIVATE		0x8
#define UPL_COMMIT_NOTIFY_EMPTY		0x10



#define UPL_DEV_MEMORY			0x1
#define UPL_PHYS_CONTIG			0x2




#define UPL_DEVICE_PAGE(upl) \
	(((upl)[(index)].phys_addr != 0) ? (!((upl)[0].device)) : FALSE)

#define UPL_PAGE_PRESENT(upl, index)  \
	((upl)[(index)].phys_addr != 0)

#define UPL_PHYS_PAGE(upl, index) \
	(((upl)[(index)].phys_addr != 0) ?  \
			((upl)[(index)].phys_addr) : (vm_offset_t)NULL)

#define UPL_DIRTY_PAGE(upl, index) \
	(((upl)[(index)].phys_addr != 0) ? ((upl)[(index)].dirty) : FALSE)

#define UPL_PRECIOUS_PAGE(upl, index) \
	(((upl)[(index)].phys_addr != 0) ? ((upl)[(index)].precious) : FALSE)

#define UPL_VALID_PAGE(upl, index) \
	(((upl)[(index)].phys_addr != 0) ? (!((upl)[(index)].absent)) : FALSE)

#define UPL_PAGEOUT_PAGE(upl, index) \
	(((upl)[(index)].phys_addr != 0) ? ((upl)[(index)].pageout) : FALSE)

#define UPL_SET_PAGE_FREE_ON_COMMIT(upl, index) \
	if ((upl)[(index)].phys_addr != 0)     \
		((upl)[(index)].pageout) =  TRUE

#define UPL_CLR_PAGE_FREE_ON_COMMIT(upl, index) \
	if ((upl)[(index)].phys_addr != 0)     \
		((upl)[(index)].pageout) =  FALSE



#define UPL_POP_DIRTY		0x1
#define UPL_POP_PAGEOUT		0x2
#define UPL_POP_PRECIOUS	0x4
#define UPL_POP_ABSENT		0x8
#define UPL_POP_BUSY		0x10

#define UPL_POP_PHYSICAL	0x10000000
#define UPL_POP_DUMP            0x20000000
#define UPL_POP_SET		0x40000000
#define UPL_POP_CLR		0x80000000



#define UPL_ROP_ABSENT		0x01

#define UPL_ROP_PRESENT		0x02

#define UPL_ROP_DUMP		0x04



#ifdefKERNEL_PRIVATE

extern void memory_object_reference(memory_object_t object);
extern void memory_object_deallocate(memory_object_t object);

extern void memory_object_default_reference(memory_object_default_t);
extern void memory_object_default_deallocate(memory_object_default_t);

extern void memory_object_control_reference(memory_object_control_t control);
extern void memory_object_control_deallocate(memory_object_control_t control);




extern vm_size_t	upl_offset_to_pagelist;
extern vm_size_t upl_get_internal_pagelist_offset();




#define UPL_GET_INTERNAL_PAGE_LIST(upl) \
	((upl_page_info_t *)((upl_offset_to_pagelist == 0) ?  \
	(unsigned int)upl + (unsigned int)(upl_offset_to_pagelist = upl_get_internal_pagelist_offset()): \
	(unsigned int)upl + (unsigned int)upl_offset_to_pagelist))

extern boolean_t	upl_page_present(upl_page_info_t *upl, int index);

extern boolean_t	upl_dirty_page(upl_page_info_t *upl, int index);

extern boolean_t	upl_valid_page(upl_page_info_t *upl, int index);

extern vm_offset_t	upl_phys_page(upl_page_info_t *upl, int index);

extern void	   	upl_set_dirty(upl_t   upl);

extern void		upl_clear_dirty(upl_t   upl);




#include <machmessage.h>


extern int kernel_vm_map_get_upl(
	vm_map_t		map,
	vm_address_t		offset,
	vm_size_t		*upl_size,
	upl_t			*upl,
	upl_page_info_array_t	page_list,
	unsigned int		*count,
	int			*flags,
	int             	force_data_sync);

extern int kernel_upl_map(
	vm_map_t        map,
	upl_t           upl,
	vm_offset_t     *dst_addr);

extern int kernel_upl_unmap(
	vm_map_t        map,
	upl_t           upl);

extern int     kernel_upl_commit(
	upl_t                   upl,
	upl_page_info_t         *pl,
	mach_msg_type_number_t	 count);

extern int kernel_upl_commit_range(
	upl_t                   upl,
	vm_offset_t             offset,
	vm_size_t		size,
	int			flags,
	upl_page_info_array_t	pl,
	mach_msg_type_number_t	count);

extern int kernel_upl_abort(
	upl_t                   upl,
	int                     abort_type);

extern int kernel_upl_abort_range(
	upl_t                   upl,
	vm_offset_t             offset,
	vm_size_t               size,
	int                     abort_flags);


#endif 

#endif
|#
 |#
;  __APPLE_API_EVOLVING 

; #endif	/* _MACH_MEMORY_OBJECT_TYPES_H_ */


(provide-interface "memory_object_types")