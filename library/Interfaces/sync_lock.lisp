(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:sync_lock.h"
; at Sunday July 2,2006 7:31:58 pm.
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
;  * 
;  
; 
;  *	File:	kern/sync_lock.h
;  *	Author:	Joseph CaraDonna
;  *
;  *	Contains RT distributed lock synchronization service definitions.
;  
; #ifndef _KERN_SYNC_LOCK_H_
; #define _KERN_SYNC_LOCK_H_

(require-interface "mach/mach_types")

(require-interface "sys/appleapiopts")
; #ifdef	__APPLE_API_PRIVATE
#| #|

#ifdefMACH_KERNEL_PRIVATE

#include <kernwait_queue.h>
#include <kernmacro_help.h>
#include <kernqueue.h>
#include <kernlock.h>

typedef struct ulock {
	queue_chain_t	thread_link;	
	queue_chain_t	held_link;	
	queue_chain_t	handoff_link;	

	decl_mutex_data(,lock)		

	struct lock_set *lock_set;	
	thread_act_t	holder;		
	unsigned int			
	 blocked:1,	
		unstable:1,	
	 ho_wait:1,	
	 accept_wait:1,	
			:0;		

	struct wait_queue wait_queue;	
} Ulock;

typedef struct ulock *ulock_t;

typedef struct lock_set {
	queue_chain_t	task_link;   
	decl_mutex_data(,lock)	     
	task_t		owner;	     
	ipc_port_t	port;	     
	int		ref_count;   

	boolean_t	active;	     
	int		n_ulocks;    

	struct ulock	ulock_list[1];	
} Lock_Set;

#define ULOCK_NULL	((ulock_t) 0)

#define ULOCK_FREE	0
#define ULOCK_HELD	1



#define lock_set_lock_init(ls)		mutex_init(&(ls)->lock, \
						   ETAP_THREAD_LOCK_SET)
#define lock_set_lock(ls)		mutex_lock(&(ls)->lock)
#define lock_set_unlock(ls)		mutex_unlock(&(ls)->lock)

#define ulock_lock_init(ul)		mutex_init(&(ul)->lock, \
						   ETAP_THREAD_ULOCK)
#define ulock_lock(ul)			mutex_lock(&(ul)->lock)
#define ulock_unlock(ul)		mutex_unlock(&(ul)->lock)

extern void lock_set_init(void);

extern	kern_return_t	lock_release_internal	(ulock_t ulock,
						 thread_act_t thr_act);

#endif

#endif
|#
 |#
;  __APPLE_API_PRIVATE 
; 
;  *	Forward Declarations
;  

(deftrap-inline "_lock_set_create" 
   ((task :pointer)
    (new_lock_set (:pointer :lock_set_t))
    (n_ulocks :signed-long)
    (policy :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_lock_set_destroy" 
   ((task :pointer)
    (lock_set :pointer)
   )
   :signed-long
() )

(deftrap-inline "_lock_acquire" 
   ((lock_set :pointer)
    (lock_id :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_lock_release" 
   ((lock_set :pointer)
    (lock_id :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_lock_try" 
   ((lock_set :pointer)
    (lock_id :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_lock_make_stable" 
   ((lock_set :pointer)
    (lock_id :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_lock_make_unstable" 
   ((ulock :ulock_t)
    (thr_act :pointer)
   )
   :signed-long
() )

(deftrap-inline "_lock_handoff" 
   ((lock_set :pointer)
    (lock_id :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_lock_handoff_accept" 
   ((lock_set :pointer)
    (lock_id :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_lock_set_reference" 
   ((lock_set :pointer)
   )
   nil
() )

(deftrap-inline "_lock_set_dereference" 
   ((lock_set :pointer)
   )
   nil
() )

; #endif /* _KERN_SYNC_LOCK_H_ */


(provide-interface "sync_lock")