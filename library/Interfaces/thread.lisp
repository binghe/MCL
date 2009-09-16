(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:thread.h"
; at Sunday July 2,2006 7:26:23 pm.
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
;  *	File:	thread.h
;  *	Author:	Avadis Tevanian, Jr.
;  *
;  *	This file contains the structure definitions for threads.
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
; #ifndef	_KERN_THREAD_H_
; #define _KERN_THREAD_H_

(require-interface "mach/kern_return")

(require-interface "mach/mach_types")

(require-interface "mach/message")

(require-interface "mach/boolean")

(require-interface "mach/vm_param")

(require-interface "mach/thread_info")

(require-interface "mach/thread_status")

(require-interface "mach/exception_types")

(require-interface "kern/cpu_data")

(require-interface "kern/kern_types")

(require-interface "ipc/ipc_types")
; 
;  * Logically, a thread of control consists of two parts:
;  *
;  * + A thread_shuttle, which may migrate due to resource contention
;  *
;  * + A thread_activation, which remains attached to a task.
;  *
;  * The thread_shuttle contains scheduling info, accounting info,
;  * and links to the thread_activation within which the shuttle is
;  * currently operating.
;  *
;  * An activation always has a valid task pointer, and it is always constant.
;  * The activation is only linked onto the task's activation list until
;  * the activation is terminated.
;  *
;  * The thread holds a reference on the activation while using it.
;  

(require-interface "sys/appleapiopts")
; #ifdef	__APPLE_API_PRIVATE
#| #|

#ifdefMACH_KERNEL_PRIVATE

#include <cpus.h>
#include <cputypes.h>

#include <mach_assert.h>
#include <mach_host.h>
#include <mach_prof.h>
#include <mach_lock_mon.h>
#include <mach_ldebug.h>

#include <machport.h>
#include <kernast.h>
#include <kerncpu_number.h>
#include <kernqueue.h>
#include <kerntime_out.h>
#include <kerntimer.h>
#include <kernlock.h>
#include <kernsched.h>
#include <kernsched_prim.h>
#include <kernthread_call.h>
#include <kerntimer_call.h>
#include <kerntask.h>
#include <kernexception.h>
#include <kernetap_macros.h>
#include <ipcipc_kmsg.h>
#include <ipcipc_port.h>

#include <machinethread.h>
#include <machinethread_act.h>

struct thread {
	
  	
	queue_chain_t	links;				
	run_queue_t		runq;				
	wait_queue_t	wait_queue;			
	event64_t		wait_event;			
	thread_act_t	top_act;			
	uint32_t							
						interrupt_level:2,	
						vm_privilege:1,		
						active_callout:1,	
						:0;


	
	decl_simple_lock_data(,sched_lock)	
	decl_simple_lock_data(,wake_lock)	
	boolean_t			wake_active;	
	int					at_safe_point;	
	ast_t				reason;			
	wait_result_t		wait_result;	
	thread_roust_t 		roust;			
	thread_continue_t	continuation;	

	
    struct funnel_lock	*funnel_lock;		
    int				    funnel_state;
#define TH_FN_OWNED			0x1				
#define TH_FN_REFUNNEL		0x2				

	vm_offset_t     	kernel_stack;		
	vm_offset_t			reserved_stack;		

	
	int					state;

#define TH_WAIT			0x01			
#define TH_SUSP			0x02			
#define TH_RUN			0x04			
#define TH_UNINT		0x08			
#define TH_TERMINATE	0x10			

#define TH_ABORT		0x20			
#define TH_ABORT_SAFELY	0x40			

#define TH_IDLE			0x80			

#define TH_SCHED_STATE	(TH_WAIT|TH_SUSP|TH_RUN|TH_UNINT)

#define TH_STACK_HANDOFF	0x0100		
#define TH_STACK_ALLOC		0x0200		
#define TH_STACK_STATE	(TH_STACK_HANDOFF | TH_STACK_ALLOC)

	
	integer_t			sched_mode;			
#define TH_MODE_REALTIME		0x0001		
#define TH_MODE_TIMESHARE		0x0002		
#define TH_MODE_PREEMPT			0x0004		
#define TH_MODE_FAILSAFE		0x0008		
#define TH_MODE_PROMOTED		0x0010		
#define TH_MODE_FORCEDPREEMPT	0x0020		
#define TH_MODE_DEPRESS			0x0040		
#define TH_MODE_POLLDEPRESS		0x0080		
#define TH_MODE_ISDEPRESSED		(TH_MODE_DEPRESS | TH_MODE_POLLDEPRESS)

	integer_t			sched_pri;			
	integer_t			priority;			
	integer_t			max_priority;		
	integer_t			task_priority;		

	integer_t			promotions;			
	integer_t			pending_promoter_index;
	void				*pending_promoter[2];

	integer_t			importance;			

											
	struct {								
		uint32_t			period;
		uint32_t			computation;
		uint32_t			constraint;
		boolean_t			preemptible;

		uint64_t			deadline;
	}					realtime;

	uint32_t			current_quantum;	

  
	timer_data_t		system_timer;		
	processor_set_t		processor_set;		
	processor_t			bound_processor;	
	processor_t			last_processor;		
	uint64_t			last_switch;		

	
	uint64_t			computation_metered;
	uint64_t			computation_epoch;
	integer_t			safe_mode;		
	natural_t			safe_release;	

	
	natural_t			sched_stamp;	
	natural_t			cpu_usage;		
	natural_t			cpu_delta;		
	natural_t			sched_usage;	
	natural_t			sched_delta;	
	natural_t			sleep_stamp;	

	
	timer_data_t			user_timer;			
	timer_save_data_t		system_timer_save;	
	timer_save_data_t		user_timer_save;	

	
	timer_call_data_t		wait_timer;
	integer_t				wait_timer_active;
	boolean_t				wait_timer_is_set;

	
	timer_call_data_t		depress_timer;
	integer_t				depress_timer_active;

	
	union {
		struct {
		  	mach_msg_return_t	state;		
		  	ipc_object_t		object;		
		  	mach_msg_header_t	*msg;		
			mach_msg_size_t		msize;		
		  	mach_msg_option_t	option;		
		  	mach_msg_size_t		slist_size;	
			struct ipc_kmsg		*kmsg;		
			mach_port_seqno_t	seqno;		
			mach_msg_continue_t	continuation;
		} receive;
		struct {
			struct semaphore	*waitsemaphore;  	
			struct semaphore	*signalsemaphore;	
			int					options;			
			kern_return_t		result;				
			mach_msg_continue_t continuation;
		} sema;
	  	struct {
			int					option;		
		} swtch;
		int						misc;		
	} saved;

	
	struct ipc_kmsg_queue ith_messages;
	mach_port_t ith_mig_reply;			
	mach_port_t ith_rpc_reply;			

	
	vm_offset_t			recover;		
	int					ref_count;		

	
	queue_chain_t		pset_threads;	
#ifMACH_HOST
	boolean_t			may_assign;		
	boolean_t			assign_active;	
#endif

	
		queue_chain_t			task_threads;

		
		struct MachineThrAct	mact;

		
		struct task				*task;
		vm_map_t				map;

		decl_mutex_data(,lock)
		int						act_ref_count;

		
		struct thread			*thread;

		
		struct thread			*higher, *lower;

		
		int						suspend_count;

		
		int						user_stop_count;

		
		ast_t					ast;

		
		uint32_t
		
						active:1,

	   
						started:1,
						:0;

		
		struct ReturnHandler {
			struct ReturnHandler	*next;
			void		(*handler)(
							struct ReturnHandler		*rh,
							struct thread				*act);
		} *handlers, special_handler;

		
		struct ipc_port			*ith_self;		
		struct ipc_port			*ith_sself;		
		struct exception_action	exc_actions[EXC_TYPES_COUNT];

		
		queue_head_t			held_ulocks;

#ifMACH_PROF
		
		boolean_t				profiled;
		boolean_t				profiled_own;
		struct prof_data		*profil_buffer;
#endif

#ifdefMACH_BSD
		void					*uthread;
#endif


#ifMACH_LOCK_MON
	unsigned			lock_stack;			
#endif 

#ifETAP_EVENT_MONITOR
	int					etap_reason;		
	boolean_t			etap_trace;			
#endif

#ifMACH_LDEBUG
	
#define MUTEX_STACK_DEPTH	20
#define LOCK_STACK_DEPTH	20
	mutex_t				*mutex_stack[MUTEX_STACK_DEPTH];
	lock_t				*lock_stack[LOCK_STACK_DEPTH];
	unsigned int		mutex_stack_index;
	unsigned int		lock_stack_index;
	unsigned			mutex_count;		
#endif


};

#define ith_state		saved.receive.state
#define ith_object		saved.receive.object
#define ith_msg			saved.receive.msg
#define ith_msize		saved.receive.msize
#define ith_option		saved.receive.option
#define ith_scatter_list_size	saved.receive.slist_size
#define ith_continuation	saved.receive.continuation
#define ith_kmsg		saved.receive.kmsg
#define ith_seqno		saved.receive.seqno

#define sth_waitsemaphore	saved.sema.waitsemaphore
#define sth_signalsemaphore	saved.sema.signalsemaphore
#define sth_options		saved.sema.options
#define sth_result		saved.sema.result
#define sth_continuation	saved.sema.continuation

extern void			thread_bootstrap(void);

extern void			thread_init(void);

extern void			thread_reaper_init(void);

extern void			thread_reference(
						thread_t		thread);

extern void			thread_deallocate(
						thread_t		thread);

extern void			thread_terminate_self(void);

extern void			thread_hold(
						thread_act_t	thread);

extern void			thread_release(
						thread_act_t	thread);

#define thread_lock_init(th)	simple_lock_init(&(th)->sched_lock, ETAP_THREAD_LOCK)
#define thread_lock(th)			simple_lock(&(th)->sched_lock)
#define thread_unlock(th)		simple_unlock(&(th)->sched_lock)
#define thread_lock_try(th)		simple_lock_try(&(th)->sched_lock)

#define thread_should_halt_fast(thread)	\
	(!(thread)->top_act || !(thread)->top_act->active)

#define thread_reference_locked(thread) ((thread)->ref_count++)

#define wake_lock_init(th)					\
			simple_lock_init(&(th)->wake_lock, ETAP_THREAD_WAKE)
#define wake_lock(th)		simple_lock(&(th)->wake_lock)
#define wake_unlock(th)		simple_unlock(&(th)->wake_lock)
#define wake_lock_try(th)		simple_lock_try(&(th)->wake_lock)

extern vm_offset_t		stack_alloc(
							thread_t		thread,
							void			(*start)(thread_t));

extern boolean_t		stack_alloc_try(
							thread_t	    thread,
							void			(*start)(thread_t));

extern void				stack_free(
							thread_t		thread);

extern void				stack_free_stack(
							vm_offset_t		stack);

extern void				stack_collect(void);

extern kern_return_t	thread_setstatus(
							thread_act_t			thread,
							int						flavor,
							thread_state_t			tstate,
							mach_msg_type_number_t	count);

extern kern_return_t	thread_getstatus(
							thread_act_t			thread,
							int						flavor,
							thread_state_t			tstate,
							mach_msg_type_number_t	*count);

extern kern_return_t	thread_info_shuttle(
							thread_act_t			thread,
							thread_flavor_t			flavor,
							thread_info_t			thread_info_out,
							mach_msg_type_number_t	*thread_info_count);

extern void				thread_task_priority(
							thread_t		thread,
							integer_t		priority,
							integer_t		max_priority);

extern kern_return_t	thread_get_special_port(
							thread_act_t	thread,
							int				which,
							ipc_port_t 		*port);

extern kern_return_t	thread_set_special_port(
							thread_act_t	thread,
							int				which,
							ipc_port_t		port);

extern thread_act_t		switch_act(
							thread_act_t	act);

extern thread_t			kernel_thread_create(
							void			(*start)(void),
							integer_t		priority);

extern thread_t			kernel_thread_with_priority(
							void            (*start)(void),
							integer_t		priority);

extern void				machine_stack_attach(
							thread_t		thread,
							vm_offset_t		stack,
							void			(*start)(thread_t));

extern vm_offset_t		machine_stack_detach(
							thread_t		thread);

extern void				machine_stack_handoff(
							thread_t		old,
							thread_t		new);

extern thread_t			machine_switch_context(
							thread_t			old_thread,
							thread_continue_t	continuation,
							thread_t			new_thread);

extern void				machine_load_context(
							thread_t		thread);

extern void				machine_switch_act(
							thread_t		thread,
							thread_act_t	old,
							thread_act_t	new);

extern kern_return_t	machine_thread_set_state(
							thread_act_t			act,
							thread_flavor_t			flavor,
							thread_state_t			state,
							mach_msg_type_number_t	count);

extern kern_return_t	machine_thread_get_state(
							thread_act_t			act,
							thread_flavor_t			flavor,
							thread_state_t			state,
							mach_msg_type_number_t	*count);

extern kern_return_t	machine_thread_dup(
							thread_act_t	self,
							thread_act_t	target);

extern void				machine_thread_init(void);

extern kern_return_t	machine_thread_create(
							thread_t		thread,
							task_t			task);

extern void 		    machine_thread_destroy(
							thread_t		thread);

extern void				machine_thread_set_current(
							thread_t		thread);

extern void			machine_thread_terminate_self(void);



struct funnel_lock {
	int			fnl_type;			
	mutex_t		*fnl_mutex;			
	void *		fnl_mtxholder;		
	void *		fnl_mtxrelease;		
	mutex_t		*fnl_oldmutex;		
};

typedef struct funnel_lock		funnel_t;

extern void 		funnel_lock(
						funnel_t	*lock);

extern void 		funnel_unlock(
						funnel_t	*lock);

typedef struct ReturnHandler		ReturnHandler;

#define act_lock(act)			mutex_lock(&(act)->lock)
#define act_lock_try(act)		mutex_try(&(act)->lock)
#define act_unlock(act)			mutex_unlock(&(act)->lock)

#define 	act_reference_locked(act)	\
MACRO_BEGIN								\
	(act)->act_ref_count++;				\
MACRO_END

#define 	act_deallocate_locked(act)		\
MACRO_BEGIN									\
	if (--(act)->act_ref_count == 0)		\
	    panic("act_deallocate_locked");		\
MACRO_END

extern void				act_reference(
							thread_act_t	act);

extern void				act_deallocate(
							thread_act_t	act);

extern void				act_attach(
							thread_act_t		act,
							thread_t			thread);

extern void				act_detach(
							thread_act_t	act);

extern thread_t			act_lock_thread(
								thread_act_t	act);

extern void					act_unlock_thread(
								thread_act_t	act);

extern thread_act_t			thread_lock_act(
								thread_t		thread);

extern void					thread_unlock_act(
								thread_t		thread);

extern void			act_execute_returnhandlers(void);

extern void			install_special_handler(
						thread_act_t	thread);

extern void			special_handler(
						ReturnHandler	*rh,
						thread_act_t	act);

#else

typedef struct funnel_lock		funnel_t;

extern boolean_t	thread_should_halt(
						thread_t		thread);

extern void			act_reference(
						thread_act_t	act);

extern void			act_deallocate(
						thread_act_t	act);

#endif

extern thread_t		kernel_thread(
						task_t		task,
						void		(*start)(void));

extern void         thread_set_cont_arg(
						int				arg);

extern int          thread_get_cont_arg(void);


extern boolean_t	is_thread_running(thread_act_t); 
extern boolean_t	is_thread_idle(thread_t); 
extern kern_return_t	get_thread_waitresult(thread_t);

typedef void	(thread_apc_handler_t)(thread_act_t);

extern kern_return_t	thread_apc_set(thread_act_t, thread_apc_handler_t);
extern kern_return_t	thread_apc_clear(thread_act_t, thread_apc_handler_t);

extern vm_map_t			swap_act_map(thread_act_t, vm_map_t);

extern void		*get_bsdthread_info(thread_act_t);
extern void		set_bsdthread_info(thread_act_t, void *);
extern task_t	get_threadtask(thread_act_t);

#endif
|#
 |#
;  __APPLE_API_PRIVATE 
; #ifdef	__APPLE_API_UNSTABLE
#| #|

#if	!defined(MACH_KERNEL_PRIVATE)

extern thread_act_t	current_act(void);

#endif

#endif
|#
 |#
;  __APPLE_API_UNSTABLE 
; #ifdef __APPLE_API_EVOLVING
#| #|



#define THR_FUNNEL_NULL (funnel_t *)0

extern funnel_t		 *funnel_alloc(
						int			type);

extern funnel_t		*thread_funnel_get(void);

extern boolean_t	thread_funnel_set(
						funnel_t	*lock,
						boolean_t	 funneled);

extern boolean_t	thread_funnel_merge(
						funnel_t	*lock,
						funnel_t	*other);

#endif
|#
 |#
;  __APPLE_API_EVOLVING 
; #ifdef __APPLE_API_PRIVATE
#| #|

extern boolean_t	refunnel_hint(
						thread_t		thread,
						wait_result_t	wresult);


vm_offset_t min_valid_stack_address(void);
vm_offset_t max_valid_stack_address(void);

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif	/* _KERN_THREAD_H_ */


(provide-interface "thread")