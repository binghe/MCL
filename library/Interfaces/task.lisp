(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:task.h"
; at Sunday July 2,2006 7:26:22 pm.
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
;  * @OSF_FREE_COPYRIGHT@
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
;  *	File:	task.h
;  *	Author:	Avadis Tevanian, Jr.
;  *
;  *	This file contains the structure definitions for tasks.
;  *
;  
; 
;  * Copyright (c) 1993 The University of Utah and
;  * the Computer Systems Laboratory (CSL).  All rights reserved.
;  *
;  * Permission to use, copy, modify and distribute this software and its
;  * documentation is hereby granted, provided that both the copyright
;  * notice and this permission notice appear in all copies of the
;  * software, derivative works or modified versions, and any portions
;  * thereof, and that both notices appear in supporting documentation.
;  *
;  * THE UNIVERSITY OF UTAH AND CSL ALLOW FREE USE OF THIS SOFTWARE IN ITS "AS
;  * IS" CONDITION.  THE UNIVERSITY OF UTAH AND CSL DISCLAIM ANY LIABILITY OF
;  * ANY KIND FOR ANY DAMAGES WHATSOEVER RESULTING FROM THE USE OF THIS SOFTWARE.
;  *
;  * CSL requests users of this software to return to csl-dist@cs.utah.edu any
;  * improvements that they make and grant CSL redistribution rights.
;  *
;  
; #ifndef	_KERN_TASK_H_
; #define _KERN_TASK_H_

(require-interface "kern/kern_types")

(require-interface "mach/mach_types")

(require-interface "vm/pmap")
; #ifdef	__APPLE_API_PRIVATE
#| #|

#ifdefMACH_KERNEL_PRIVATE

#include <machboolean.h>
#include <machport.h>
#include <machtime_value.h>
#include <machmessage.h>
#include <machmach_param.h>
#include <machtask_info.h>
#include <machexception_types.h>
#include <mach_prof.h>
#include <machinetask.h>
#include <kernqueue.h>
#include <kernexception.h>
#include <kernlock.h>
#include <kernsyscall_emulation.h>
#include <norma_task.h>
#include <mach_host.h>
#include <fast_tas.h>
#include <task_swapper.h>
#include <kernthread_act.h>

typedef struct task {
	
	decl_mutex_data(,lock)		
	int		ref_count;	
	boolean_t	active;		

	
	vm_map_t	map;		
	queue_chain_t	pset_tasks;	
	void		*user_data;	
	int		suspend_count;	

#ifTASK_SWAPPER
	
	unsigned short	swap_state;	
	unsigned short	swap_flags;	
	unsigned int	swap_stamp;	
	unsigned long	swap_rss;	
	int		swap_ast_waiting; 
					  
	int		swap_nswap;	
	queue_chain_t	swapped_tasks;	
#endif

	
	queue_head_t	threads;
	int				thread_count;
	int				res_thread_count;
	int				active_thread_count;

	processor_set_t	processor_set;	
#ifMACH_HOST
	boolean_t	may_assign;	
	boolean_t	assign_active;	
#endif

	
	integer_t		user_stop_count;	

	task_role_t		role;

	integer_t		priority;			
	integer_t		max_priority;		

	
	security_token_t sec_token;
	audit_token_t	audit_token;
        
	
	time_value_t	total_user_time;	
	time_value_t	total_system_time;	

#ifMACH_PROF
	boolean_t	task_profiled;  
	struct prof_data *profil_buffer;
#endif

	
	decl_mutex_data(,itk_lock_data)
	struct ipc_port *itk_self;	
	struct ipc_port *itk_sself;	
	struct exception_action exc_actions[EXC_TYPES_COUNT];
		 			
	struct ipc_port *itk_host;	
	struct ipc_port *itk_bootstrap;	
	struct ipc_port *itk_registered[TASK_PORT_REGISTER_MAX];
					

	struct ipc_space *itk_space;

	
	queue_head_t	semaphore_list;		
	queue_head_t	lock_set_list;		
	int		semaphores_owned;	
	int 		lock_sets_owned;	

	
	struct 	eml_dispatch	*eml_dispatch;

        
	struct ipc_port	*wired_ledger_port;
	struct ipc_port *paged_ledger_port;
	unsigned long	priv_flags;	
        
#ifNORMA_TASK
	long		child_node;	
#endif
#ifFAST_TAS
	vm_offset_t	fast_tas_base;
	vm_offset_t	fast_tas_end;
#endif
	MACHINE_TASK
	integer_t faults;              
        integer_t pageins;             
        integer_t cow_faults;          
        integer_t messages_sent;       
        integer_t messages_received;   
        integer_t syscalls_mach;       
        integer_t syscalls_unix;       
        integer_t csw;                 
#ifdef MACH_BSD 
	void *bsd_info;
#endif 
	vm_offset_t	system_shared_region;
	vm_offset_t	dynamic_working_set;
	uint32_t taskFeatures[2];		
#define tf64BitAddr	0x80000000		
#define tf64BitData	0x40000000		
} Task;

#define task_lock(task)		mutex_lock(&(task)->lock)
#define task_lock_try(task)	mutex_try(&(task)->lock)
#define task_unlock(task)	mutex_unlock(&(task)->lock)

#define itk_lock_init(task)	mutex_init(&(task)->itk_lock_data, \
					   ETAP_THREAD_TASK_ITK)
#define itk_lock(task)		mutex_lock(&(task)->itk_lock_data)
#define itk_unlock(task)	mutex_unlock(&(task)->itk_lock_data)

#define task_reference_locked(task) ((task)->ref_count++)


#define VM_BACKING_STORE_PRIV	0x1



extern void task_backing_store_privileged(
				task_t task);


extern void		task_init(void);


extern kern_return_t	task_create_internal(
				task_t		parent_task,
				boolean_t	inherit_memory,
				task_t		*child_task);	

extern void		consider_task_collect(void);

#define current_task_fast()	(current_act_fast()->task)
#define current_task()		current_task_fast()

#endif

extern task_t		kernel_task;


extern kern_return_t	task_hold(
				task_t	task);


extern kern_return_t	task_release(
				task_t	task);


extern kern_return_t	task_halt(
				task_t	task);

#ifdefined(MACH_KERNEL_PRIVATE) || defined(BSD_BUILD)
extern kern_return_t	task_importance(
							task_t			task,
							integer_t		importance);
#endif

extern void 	*get_bsdtask_info(task_t);
extern void	set_bsdtask_info(task_t,void *);
extern vm_map_t get_task_map(task_t);
extern vm_map_t	swap_task_map(task_t, vm_map_t);
extern pmap_t	get_task_pmap(task_t);

extern boolean_t	task_reference_try(task_t task);

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #if		!defined(MACH_KERNEL_PRIVATE)

(deftrap-inline "_current_task" 
   (
   )
   :pointer
() )

; #endif	/* MACH_KERNEL_TASK */

;  Take reference on task (make sure it doesn't go away) 

(deftrap-inline "_task_reference" 
   ((task :pointer)
   )
   nil
() )
;  Remove reference to task 

(deftrap-inline "_task_deallocate" 
   ((task :pointer)
   )
   nil
() )

; #endif	/* _KERN_TASK_H_ */


(provide-interface "task")