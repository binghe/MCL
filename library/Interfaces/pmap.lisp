(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:pmap.h"
; at Sunday July 2,2006 7:26:23 pm.
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
;  *	File:	vm/pmap.h
;  *	Author:	Avadis Tevanian, Jr.
;  *	Date:	1985
;  *
;  *	Machine address mapping definitions -- machine-independent
;  *	section.  [For machine-dependent section, see "machine/pmap.h".]
;  
; #ifndef	_VM_PMAP_H_
; #define _VM_PMAP_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_PRIVATE
#| #|

#include <machkern_return.h>
#include <machvm_param.h>
#include <machvm_types.h>
#include <machvm_attributes.h>
#include <machboolean.h>
#include <machvm_prot.h>




extern kern_return_t 	copypv(
				addr64_t source, 
				addr64_t sink, 
				unsigned int size, 
				int which);	
#define cppvPsnk 	1
#define cppvPsrc 	2
#define cppvFsnk 	4
#define cppvFsrc 	8
#define cppvNoModSnk   16
#define cppvNoRefSrc   32
#define cppvKmap   	64	

#if!defined(MACH_KERNEL_PRIVATE)

typedef void *pmap_t;

#else

typedef struct pmap *pmap_t;

#include <machinepmap.h>



extern vm_offset_t	pmap_steal_memory(vm_size_t size);
						
extern unsigned int	pmap_free_pages(void);	
extern void		pmap_startup(
				vm_offset_t *startp,
				vm_offset_t *endp);
						
extern void		pmap_init(void);	

#ifndefMACHINE_PAGES


extern boolean_t	pmap_next_page(ppnum_t *pnum);
						
extern void		pmap_virtual_space(
					vm_offset_t	*virtual_start,
					vm_offset_t	*virtual_end);
						
#endif


extern pmap_t		pmap_create(vm_size_t size);	
extern pmap_t		(pmap_kernel)(void);	
extern void		pmap_reference(pmap_t pmap);	
extern void		pmap_destroy(pmap_t pmap); 
extern void		pmap_switch(pmap_t);


extern void		pmap_enter(	
				pmap_t		pmap,
				vm_offset_t	v,
				ppnum_t		pn,
				vm_prot_t	prot,
				unsigned int	flags,
				boolean_t	wired);

extern void		pmap_remove_some_phys(
				pmap_t		pmap,
				ppnum_t		pn);




extern void		pmap_page_protect(	
				ppnum_t	phys,
				vm_prot_t	prot);

extern void		(pmap_zero_page)(
				ppnum_t		pn);

extern void		(pmap_zero_part_page)(
				ppnum_t		pn,
				vm_offset_t     offset,
				vm_size_t       len);

extern void		(pmap_copy_page)(
				ppnum_t		src,
				ppnum_t		dest);

extern void		(pmap_copy_part_page)(
				ppnum_t		src,
				vm_offset_t	src_offset,
				ppnum_t		dst,
				vm_offset_t	dst_offset,
				vm_size_t	len);

extern void		(pmap_copy_part_lpage)(
				vm_offset_t	src,
				ppnum_t		dst,
				vm_offset_t	dst_offset,
				vm_size_t	len);

extern void		(pmap_copy_part_rpage)(
				ppnum_t		src,
				vm_offset_t	src_offset,
				vm_offset_t	dst,
				vm_size_t	len);


extern boolean_t	pmap_verify_free(ppnum_t pn);


extern int		(pmap_resident_count)(pmap_t pmap);


extern void		pmap_collect(pmap_t pmap);


extern vm_offset_t	(pmap_phys_address)(	
				int		frame);

extern int		(pmap_phys_to_frame)(	
				vm_offset_t	phys);


extern void		(pmap_copy)(		
				pmap_t		dest,
				pmap_t		source,
				vm_offset_t	dest_va,
				vm_size_t	size,
				vm_offset_t	source_va);

extern kern_return_t	(pmap_attribute)(	
				pmap_t		pmap,
				vm_offset_t	va,
				vm_size_t	size,
				vm_machine_attribute_t  attribute,
				vm_machine_attribute_val_t* value);

extern kern_return_t	(pmap_attribute_cache_sync)(  
				ppnum_t		pn, 
				vm_size_t	size, 
				vm_machine_attribute_t attribute, 
				vm_machine_attribute_val_t* value);


#ifndefPMAP_ACTIVATE_USER
#define PMAP_ACTIVATE_USER(act, cpu) {				\
	pmap_t  pmap;						\
								\
	pmap = (act)->map->pmap;				\
	if (pmap != pmap_kernel())				\
		PMAP_ACTIVATE(pmap, (act), (cpu));		\
}
#endif 

#ifndefPMAP_DEACTIVATE_USER
#define PMAP_DEACTIVATE_USER(act, cpu) {			\
	pmap_t  pmap;						\
								\
	pmap = (act)->map->pmap;				\
	if ((pmap) != pmap_kernel())				\
		PMAP_DEACTIVATE(pmap, (act), (cpu));		\
}
#endif 

#ifndefPMAP_ACTIVATE_KERNEL
#define PMAP_ACTIVATE_KERNEL(cpu)			\
		PMAP_ACTIVATE(pmap_kernel(), THR_ACT_NULL, cpu)
#endif

#ifndefPMAP_DEACTIVATE_KERNEL
#define PMAP_DEACTIVATE_KERNEL(cpu)			\
		PMAP_DEACTIVATE(pmap_kernel(), THR_ACT_NULL, cpu)
#endif

#ifndefPMAP_ENTER

#define PMAP_ENTER(pmap, virtual_address, page, protection, flags, wired) \
		MACRO_BEGIN					\
		pmap_enter(					\
			(pmap),					\
			(virtual_address),			\
			(page)->phys_page,			\
			(protection) & ~(page)->page_lock,	\
			flags,					\
			(wired)					\
		 );						\
		MACRO_END
#endif


				
extern void		pmap_clear_reference(ppnum_t	 pn);
				
extern boolean_t	(pmap_is_referenced)(ppnum_t	 pn);
				
extern void             pmap_set_modify(ppnum_t	 pn);
				
extern void		pmap_clear_modify(ppnum_t pn);
				
extern boolean_t	pmap_is_modified(ppnum_t pn);


extern void		pmap_protect(	
				pmap_t		map,
				vm_offset_t	s,
				vm_offset_t	e,
				vm_prot_t	prot);

extern void		(pmap_pageable)(
				pmap_t		pmap,
				vm_offset_t	start,
				vm_offset_t	end,
				boolean_t	pageable);

#endif



#define PMAP_NULL  ((pmap_t) 0)

extern pmap_t	kernel_pmap;			
#define 	pmap_kernel()	(kernel_pmap)



#define VM_MEM_GUARDED 		0x1
#define VM_MEM_COHERENT		0x2
#define VM_MEM_NOT_CACHEABLE	0x4
#define VM_MEM_WRITE_THROUGH	0x8

#define VM_WIMG_MASK		0xFF
#define VM_WIMG_USE_DEFAULT	0x80000000

extern void		pmap_modify_pages(	
				pmap_t		map,
				vm_offset_t	s,
				vm_offset_t	e);

extern vm_offset_t	pmap_extract(pmap_t pmap,
				vm_offset_t va);

extern void		pmap_change_wiring(	
				pmap_t		pmap,
				vm_offset_t	va,
				boolean_t	wired);

extern void		pmap_remove(	
				pmap_t		map,
				addr64_t	s,
				addr64_t	e);


#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif	/* _VM_PMAP_H_ */


(provide-interface "pmap")