(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vnode_pager.h"
; at Sunday July 2,2006 7:32:16 pm.
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
;  * Mach Operating System
;  * Copyright (c) 1987 Carnegie-Mellon University
;  * All rights reserved.  The CMU software License Agreement specifies
;  * the terms and conditions for use and redistribution.
;  
; #ifndef	_VNODE_PAGER_
(defconstant $_VNODE_PAGER_ 1)
; #define	_VNODE_PAGER_	1

(require-interface "mach/kern_return")

(require-interface "sys/types")

(require-interface "kern/queue")
; #ifdef	KERNEL
#| #|

#include <machboolean.h>
#include <vmvm_pager.h>

vm_pager_t	vnode_pager_setup();
boolean_t	vnode_has_page();
boolean_t	vnode_pager_active();




typedef struct pager_file {
	queue_chain_t	pf_chain;	
	struct	vnode	*pf_vp;		
	u_int		pf_count;	
	u_char		*pf_bmap; 	
	long		pf_npgs;	
	long		pf_pfree;	
	long		pf_lowat;	
	long		pf_hipage;	
	long		pf_hint;	
	char		*pf_name;	
	boolean_t	pf_prefer;
	int		pf_index;	
	void *		pf_lock;	
} *pager_file_t;

#define PAGER_FILE_NULL	(pager_file_t) 0

#define MAXPAGERFILES 16

#define MAX_BACKING_STORE 100

struct bs_map {
	struct vnode    *vp;   
	void     	*bs;
};




#define INDEX_NULL	0
typedef struct {
	unsigned int index:8;	
	unsigned int offset:24;	
} pf_entry;

typedef enum {
		IS_INODE,	
		IS_RNODE	
	} vpager_fstype;


typedef struct vstruct {
	boolean_t	is_device;	
	pager_file_t	vs_pf;		
	pf_entry	**vs_pmap;	
	unsigned int
		vs_swapfile:1;	
	short		vs_count;	
	int		vs_size;	
	struct vnode	*vs_vp;		
} *vnode_pager_t;

#define VNODE_PAGER_NULL	((vnode_pager_t) 0)



pager_return_t	pager_vnode_pagein();
pager_return_t	pager_vnode_pageout();
pager_return_t	vnode_pagein();
pager_return_t	vnode_pageout();

#endif
|#
 |#
;  KERNEL 

; #endif	/* _VNODE_PAGER_ */


(provide-interface "vnode_pager")