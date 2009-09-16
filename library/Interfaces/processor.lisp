(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:processor.h"
; at Sunday July 2,2006 7:26:19 pm.
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
;  *	processor.h:	Processor and processor-set definitions.
;  
; #ifndef	_KERN_PROCESSOR_H_
; #define	_KERN_PROCESSOR_H_
; 
;  *	Data structures for managing processors and sets of processors.
;  

(require-interface "mach/boolean")

(require-interface "mach/kern_return")

(require-interface "kern/kern_types")

(require-interface "sys/appleapiopts")
; #ifdef	__APPLE_API_PRIVATE
#| #|

#ifdefMACH_KERNEL_PRIVATE

#include <cpus.h>

#include <machmach_types.h>
#include <kerncpu_number.h>
#include <kernlock.h>
#include <kernqueue.h>
#include <kernsched.h>

#include <machineast_types.h>

struct processor_set {
	queue_head_t		idle_queue;		
	int					idle_count;		
	queue_head_t		active_queue;	

	queue_head_t		processors;		
	int					processor_count;
	decl_simple_lock_data(,sched_lock)	

	struct	run_queue	runq;			

	queue_head_t		tasks;			
	int					task_count;		
	queue_head_t		threads;		
	int					thread_count;	
	int					ref_count;		
	boolean_t			active;			
	decl_mutex_data(,	lock)			

	int					timeshare_quanta;	
	int					quantum_factors[NCPUS+1];

	struct ipc_port	*	pset_self;		
	struct ipc_port *	pset_name_self;	

	uint32_t			run_count;		
	uint32_t			share_count;	

	integer_t			mach_factor;	
	integer_t			load_average;	
	uint32_t			sched_load;		
};

struct processor {
	queue_chain_t		processor_queue;
	int					state;			
	struct thread
						*active_thread,	
						*next_thread,	
						*idle_thread;	

	processor_set_t		processor_set;	

	int					current_pri;	

	timer_call_data_t	quantum_timer;	
	uint64_t			quantum_end;	
	uint64_t			last_dispatch;	

	int					timeslice;		
	uint64_t			deadline;		

	struct run_queue	runq;			

	queue_chain_t		processors;		
	decl_simple_lock_data(,lock)
	struct ipc_port		*processor_self;
	int					slot_num;		
};

extern struct processor_set	default_pset;
extern processor_t	master_processor;

extern struct processor	processor_array[NCPUS];





#define PROCESSOR_OFF_LINE		0	
#define PROCESSOR_RUNNING		1	
#define PROCESSOR_IDLE			2	
#define PROCESSOR_DISPATCHING	3	
#define PROCESSOR_SHUTDOWN		4	
#define PROCESSOR_START			5	



extern processor_t	processor_ptr[NCPUS];

#define cpu_to_processor(i)	(processor_ptr[i])

#define current_processor()	(processor_ptr[cpu_number()])



#define cpu_state(slot_num)	(processor_ptr[slot_num]->state)
#define cpu_idle(slot_num)	(cpu_state(slot_num) == PROCESSOR_IDLE)



#define pset_lock(pset)		mutex_lock(&(pset)->lock)
#define pset_lock_try(pset)	mutex_try(&(pset)->lock)
#define pset_unlock(pset)	mutex_unlock(&(pset)->lock)

#define processor_lock(pr)	simple_lock(&(pr)->lock)
#define processor_unlock(pr)	simple_unlock(&(pr)->lock)

extern void		pset_sys_bootstrap(void);

#define timeshare_quanta_update(pset)					\
MACRO_BEGIN												\
	int		proc_count = (pset)->processor_count;		\
	int		runq_count = (pset)->runq.count;			\
														\
	(pset)->timeshare_quanta = (pset)->quantum_factors[	\
					(runq_count > proc_count)?			\
							proc_count: runq_count];	\
MACRO_END

#define pset_run_incr(pset)					\
	hw_atomic_add(&(pset)->run_count, 1)

#define pset_run_decr(pset)					\
	hw_atomic_sub(&(pset)->run_count, 1)

#define pset_share_incr(pset)				\
	hw_atomic_add(&(pset)->share_count, 1)

#define pset_share_decr(pset)				\
	hw_atomic_sub(&(pset)->share_count, 1)

extern void		cpu_up(
					int		cpu);

extern kern_return_t	processor_shutdown(
							processor_t		processor);

extern void		pset_remove_processor(
					processor_set_t		pset,
					processor_t			processor);

extern void		pset_add_processor(
					processor_set_t		pset,
					processor_t			processor);

extern void		pset_remove_task(
					processor_set_t		pset,
					task_t				task);

extern void		pset_add_task(
					processor_set_t		pset,
					task_t				task);

extern void		pset_remove_thread(
					processor_set_t		pset,
					thread_t			thread);

extern void		pset_add_thread(
					processor_set_t		pset,
					thread_t			thread);

extern void		thread_change_psets(
					thread_t			thread,
					processor_set_t		old_pset,
					processor_set_t		new_pset);

extern kern_return_t	processor_assign(
							processor_t			processor,
							processor_set_t		new_pset,
							boolean_t			wait);

extern kern_return_t	processor_info_count(
							processor_flavor_t		flavor,
							mach_msg_type_number_t	*count);

#endif

extern kern_return_t	processor_start(
							processor_t		processor);

extern kern_return_t	processor_exit(
							processor_t		processor);

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

(deftrap-inline "_pset_deallocate" 
   ((pset :pointer)
   )
   nil
() )

(deftrap-inline "_pset_reference" 
   ((pset :pointer)
   )
   nil
() )

; #endif	/* _KERN_PROCESSOR_H_ */


(provide-interface "processor")