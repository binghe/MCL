(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:wait_queue.h"
; at Sunday July 2,2006 7:32:17 pm.
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
; #ifndef _KERN_WAIT_QUEUE_H_
; #define _KERN_WAIT_QUEUE_H_

(require-interface "sys/appleapiopts")
; #ifdef	__APPLE_API_PRIVATE
#| #|

#include <machsync_policy.h>
#include <machkern_return.h>		

#include <kernkern_types.h>		

#ifdefMACH_KERNEL_PRIVATE

#include <kernlock.h>
#include <kernqueue.h>



typedef struct wait_queue {
    unsigned int                    
    	wq_type:16,		
					wq_fifo:1,		
					wq_isprepost:1,	
					:0;				
    hw_lock_data_t	wq_interlock;	
    queue_head_t	wq_queue;		
} WaitQueue;


typedef struct wait_queue_set {
	WaitQueue		wqs_wait_queue; 
	queue_head_t	wqs_setlinks;	
	unsigned int 	wqs_refcount;	
} WaitQueueSet;

#define wqs_type		wqs_wait_queue.wq_type
#define wqs_fifo		wqs_wait_queue.wq_fifo
#define wqs_isprepost	wqs_wait_queue.wq_isprepost
#define wqs_queue		wqs_wait_queue.wq_queue


typedef struct wait_queue_element {
	queue_chain_t	wqe_links;	
	void *			wqe_type;	
	wait_queue_t	wqe_queue;	
} WaitQueueElement;

typedef WaitQueueElement *wait_queue_element_t;


typedef struct wait_queue_link {
	WaitQueueElement		wql_element;	
	queue_chain_t			wql_setlinks;	
    wait_queue_set_t		wql_setqueue;	
} WaitQueueLink;

#define wql_links wql_element.wqe_links
#define wql_type  wql_element.wqe_type
#define wql_queue wql_element.wqe_queue

#define _WAIT_QUEUE_inited			0xf1d0
#define _WAIT_QUEUE_SET_inited		0xf1d1

#define wait_queue_is_queue(wq)	\
	((wq)->wq_type == _WAIT_QUEUE_inited)

#define wait_queue_is_set(wqs)	\
	((wqs)->wqs_type == _WAIT_QUEUE_SET_inited)

#define wait_queue_is_valid(wq)	\
	(((wq)->wq_type & ~1) == _WAIT_QUEUE_inited)

#define wait_queue_empty(wq)	(queue_empty(&(wq)->wq_queue))
#define wait_queue_held(wq)		(hw_lock_held(&(wq)->wq_interlock))
#define wait_queue_lock_try(wq) (hw_lock_try(&(wq)->wq_interlock))


#define wait_queue_lock(wq)	\
	((void) (!hw_lock_to(&(wq)->wq_interlock, LockTimeOut * 2) ? \
		 panic("wait queue deadlock - wq=0x%x, cpu=%d\n", \
		       wq, cpu_number()) : 0))

#define wait_queue_unlock(wq) \
	(assert(wait_queue_held(wq)), hw_lock_unlock(&(wq)->wq_interlock))

#define wqs_lock(wqs)		wait_queue_lock(&(wqs)->wqs_wait_queue)
#define wqs_unlock(wqs)		wait_queue_unlock(&(wqs)->wqs_wait_queue)
#define wqs_lock_try(wqs)	wait_queue__try_lock(&(wqs)->wqs_wait_queue)

#define wait_queue_assert_possible(thread) \
			((thread)->wait_queue == WAIT_QUEUE_NULL)




__private_extern__ wait_result_t wait_queue_assert_wait64_locked(
			wait_queue_t wait_queue,
			event64_t wait_event,
			wait_interrupt_t interruptible,
			thread_t thread);


__private_extern__ void wait_queue_peek64_locked(
			wait_queue_t wait_queue,
			event64_t event,
			thread_t *thread,
			wait_queue_t *found_queue);


__private_extern__ void wait_queue_pull_thread_locked(
			wait_queue_t wait_queue,
			thread_t thread,
			boolean_t unlock);


__private_extern__ kern_return_t wait_queue_wakeup64_all_locked(
			wait_queue_t wait_queue,
			event64_t wake_event,
			wait_result_t result,
			boolean_t unlock);


__private_extern__ kern_return_t wait_queue_wakeup64_one_locked(
			wait_queue_t wait_queue,
			event64_t wake_event,
			wait_result_t result,
			boolean_t unlock);


__private_extern__ thread_t wait_queue_wakeup64_identity_locked(
			wait_queue_t wait_queue,
			event64_t wake_event,
			wait_result_t result,
			boolean_t unlock);


__private_extern__ kern_return_t wait_queue_wakeup64_thread_locked(
			wait_queue_t wait_queue,
			event64_t wake_event,
			thread_t thread,
			wait_result_t result,
			boolean_t unlock);

#endif

#ifdef__APPLE_API_UNSTABLE


extern kern_return_t wait_queue_init(
			wait_queue_t wait_queue,
			int policy);

extern wait_queue_set_t wait_queue_set_alloc(
			int policy);

extern kern_return_t wait_queue_set_free(
			wait_queue_set_t set_queue);

extern wait_queue_link_t wait_queue_link_alloc(
			int policy);

extern kern_return_t wait_queue_link_free(
			wait_queue_link_t link_element);

#endif

#ifdef__APPLE_API_EVOLVING

extern wait_queue_t wait_queue_alloc(
			int policy);

extern kern_return_t wait_queue_free(
			wait_queue_t wait_queue);

extern kern_return_t wait_queue_link(
			wait_queue_t wait_queue,
			wait_queue_set_t set_queue);

extern kern_return_t wait_queue_unlink(
			wait_queue_t wait_queue,
			wait_queue_set_t set_queue);

extern kern_return_t wait_queue_unlink_all(
			wait_queue_t wait_queue);

extern kern_return_t wait_queue_set_unlink_all(
			wait_queue_set_t set_queue);


extern wait_result_t wait_queue_assert_wait64(
			wait_queue_t wait_queue,
			event64_t wait_event,
			wait_interrupt_t interruptible);


extern kern_return_t wait_queue_wakeup64_one(
			wait_queue_t wait_queue,
			event64_t wake_event,
			wait_result_t result);


extern kern_return_t wait_queue_wakeup64_all(
			wait_queue_t wait_queue,
			event64_t wake_event,
			wait_result_t result);


extern kern_return_t wait_queue_wakeup64_thread(
			wait_queue_t wait_queue,
			event64_t wake_event,
			thread_t thread,
			wait_result_t result);

#endif 




extern wait_result_t wait_queue_assert_wait(
			wait_queue_t wait_queue,
			event_t wait_event,
			wait_interrupt_t interruptible);


extern kern_return_t wait_queue_wakeup_one(
			wait_queue_t wait_queue,
			event_t wake_event,
			wait_result_t result);


extern kern_return_t wait_queue_wakeup_all(
			wait_queue_t wait_queue,
			event_t wake_event,
			wait_result_t result);


extern kern_return_t wait_queue_wakeup_thread(
			wait_queue_t wait_queue,
			event_t wake_event,
			thread_t thread,
			wait_result_t result);

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif /* _KERN_WAIT_QUEUE_H_ */


(provide-interface "wait_queue")