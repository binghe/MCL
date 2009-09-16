(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:sched_prim.h"
; at Sunday July 2,2006 7:26:32 pm.
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
;  *	File:	sched_prim.h
;  *	Author:	David Golub
;  *
;  *	Scheduling primitive definitions file
;  *
;  
; #ifndef	_KERN_SCHED_PRIM_H_
; #define _KERN_SCHED_PRIM_H_

(require-interface "mach/boolean")

(require-interface "mach/machine/vm_types")

(require-interface "mach/kern_return")

(require-interface "kern/clock")

(require-interface "kern/kern_types")

(require-interface "kern/thread")

(require-interface "kern/lock")

(require-interface "kern/time_out")

(require-interface "kern/cpu_data")

(require-interface "sys/appleapiopts")
; #ifdef	__APPLE_API_PRIVATE
#| #|

#ifdefMACH_KERNEL_PRIVATE

#include <mach_ldebug.h>



extern void		sched_init(void);

extern void		sched_timebase_init(void);


extern void		thread_timer_setup(
					thread_t		thread);

extern void		thread_timer_terminate(void);


extern boolean_t	thread_stop( 
						thread_t	thread);


extern boolean_t	thread_wait(
						thread_t	thread);


extern thread_t	thread_select(
						processor_t	myprocessor);

extern kern_return_t thread_go_locked(
					 	thread_t		thread,
						wait_result_t	result);


extern boolean_t thread_invoke(
						thread_t		old_thread,
						thread_t		new_thread,
						int				reason,
						thread_continue_t continuation);


extern void		thread_continue(
						thread_t		old_thread);


extern int		thread_run(
						thread_t		old_thread,
						thread_continue_t continuation,
						thread_t		new_thread);


extern void		thread_dispatch(
						thread_t		thread);


extern void		call_continuation(
						thread_continue_t continuation);		  


extern void		set_sched_pri(
					thread_t		thread,
					int				priority);


extern void		set_priority(
					thread_t		thread,
					int				priority);


extern void		compute_priority(
					thread_t		thread,
					boolean_t		override_depress);


extern void		compute_my_priority(
					thread_t		thread);


extern void		sched_tick_init(void);


extern void		update_priority(
					thread_t		thread);


extern void		idle_thread(void);




extern void		thread_bootstrap_return(void);


extern void		thread_exception_return(void);


extern void     thread_syscall_return(
                        kern_return_t   ret);




extern wait_result_t	thread_block_reason(
							thread_continue_t	continuation,
							ast_t				reason);


extern void		thread_setrun(
					thread_t	thread,
					integer_t	options);

#define SCHED_TAILQ		0
#define SCHED_HEADQ		1
#define SCHED_PREEMPT	2


extern processor_t		thread_bind(
							thread_t		thread,
							processor_t		processor);


__private_extern__ wait_interrupt_t thread_interrupt_level(
						wait_interrupt_t interruptible);

__private_extern__ wait_result_t thread_mark_wait_locked(
						thread_t		 thread,
						wait_interrupt_t interruptible);


__private_extern__ wait_result_t thread_sleep_fast_usimple_lock(
						event_t			event,
						simple_lock_t	lock,
						wait_interrupt_t interruptible);


__private_extern__ kern_return_t clear_wait_internal(
						thread_t		thread,
						wait_result_t	result);

__private_extern__
	wait_queue_t	wait_event_wait_queue(
						event_t			event);

#endif

extern wait_result_t	assert_wait_prim(
							event_t				event,
							thread_roust_t		roust_hint,
							uint64_t			deadline,
							wait_interrupt_t	interruptible);




extern void		thread_unstop(
						thread_t		thread);


extern kern_return_t clear_wait(
						thread_t		thread,
						wait_result_t	result);

#endif
|#
 |#
;  __APPLE_API_PRIVATE 
; 
;  * *********************   PUBLIC APIs ************************************
;  
;  Set timer for current thread 

(deftrap-inline "_thread_set_timer" 
   ((interval :UInt32)
    (scale_factor :UInt32)
   )
   nil
() )

(deftrap-inline "_thread_set_timer_deadline" 
   ((deadline :uint64_t)
   )
   nil
() )

(deftrap-inline "_thread_cancel_timer" 
   (
   )
   nil
() )
;  Declare thread will wait on a particular event 

(deftrap-inline "_assert_wait" 
   ((event (:pointer :void))
    (interruptflag :signed-long)
   )
   :signed-long
() )
;  Assert that the thread intends to wait for a timeout 

(deftrap-inline "_assert_wait_timeout" 
   ((msecs :UInt32)
    (interruptflags :signed-long)
   )
   :signed-long
() )
;  Sleep, unlocking and then relocking a usimple_lock in the process 

(deftrap-inline "_thread_sleep_usimple_lock" 
   ((event (:pointer :void))
    (lock :usimple_lock_t)
    (interruptible :signed-long)
   )
   :signed-long
() )
;  Sleep, unlocking and then relocking a mutex in the process 

(deftrap-inline "_thread_sleep_mutex" 
   ((event (:pointer :void))
    (mutex (:pointer :mutex_t))
    (interruptible :signed-long)
   )
   :signed-long
() )
;  Sleep with a deadline, unlocking and then relocking a mutex in the process 

(deftrap-inline "_thread_sleep_mutex_deadline" 
   ((event (:pointer :void))
    (mutex (:pointer :mutex_t))
    (deadline :uint64_t)
    (interruptible :signed-long)
   )
   :signed-long
() )
;  Sleep, unlocking and then relocking a write lock in the process 

(deftrap-inline "_thread_sleep_lock_write" 
   ((event (:pointer :void))
    (lock (:pointer :lock_t))
    (interruptible :signed-long)
   )
   :signed-long
() )
;  Sleep, hinting that a thread funnel may be involved in the process 

(deftrap-inline "_thread_sleep_funnel" 
   ((event (:pointer :void))
    (interruptible :signed-long)
   )
   :signed-long
() )
;  Wake up thread (or threads) waiting on a particular event 

(deftrap-inline "_thread_wakeup_prim" 
   ((event (:pointer :void))
    (one_thread :signed-long)
    (result :signed-long)
   )
   :signed-long
() )
; #ifdef	__APPLE_API_UNSTABLE
#| #|


extern wait_result_t thread_block(
						thread_continue_t continuation);

#endif
|#
 |#
;  __APPLE_API_UNSTABLE 
; 
;  *	Routines defined as macros
;  
; #define thread_wakeup(x)								thread_wakeup_prim((x), FALSE, THREAD_AWAKENED)
; #define thread_wakeup_with_result(x, z)					thread_wakeup_prim((x), FALSE, (z))
; #define thread_wakeup_one(x)							thread_wakeup_prim((x), TRUE, THREAD_AWAKENED)

; #if		!defined(MACH_KERNEL_PRIVATE) && !defined(ABSOLUTETIME_SCALAR_TYPE)

(require-interface "libkern/OSBase")
; #define thread_set_timer_deadline(a)		thread_set_timer_deadline(__OSAbsoluteTime(a))

; #endif


; #endif	/* _KERN_SCHED_PRIM_H_ */


(provide-interface "sched_prim")