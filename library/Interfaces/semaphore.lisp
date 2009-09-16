(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:semaphore.h"
; at Sunday July 2,2006 7:26:21 pm.
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
; #ifndef _MACH_SEMAPHORE_H_
; #define _MACH_SEMAPHORE_H_

(require-interface "mach/port")

(require-interface "mach/mach_types")

(require-interface "mach/kern_return")

(require-interface "mach/sync_policy")
; 
;  *	Forward Declarations
;  *
;  *	The semaphore creation and deallocation routines are
;  *	defined with the Mach task APIs in <mach/task.h>.
;  *
;  *      kern_return_t	semaphore_create(task_t task,
;  *                                       semaphore_t *new_semaphore,
;  *					 sync_policy_t policy,
;  *					 int value);
;  *
;  *	kern_return_t	semaphore_destroy(task_t task,
;  *					  semaphore_t semaphore);
;  

(deftrap-inline "_semaphore_signal" 
   ((semaphore :pointer)
   )
   :signed-long
() )

(deftrap-inline "_semaphore_signal_all" 
   ((semaphore :pointer)
   )
   :signed-long
() )

(deftrap-inline "_semaphore_signal_thread" 
   ((semaphore :pointer)
    (thread_act :pointer)
   )
   :signed-long
() )

(deftrap-inline "_semaphore_wait" 
   ((semaphore :pointer)
   )
   :signed-long
() )

(deftrap-inline "_semaphore_timedwait" 
   ((semaphore :pointer)
    (wait_time (:pointer :mach_timespec))
   )
   :signed-long
() )

(deftrap-inline "_semaphore_wait_signal" 
   ((wait_semaphore :pointer)
    (signal_semaphore :pointer)
   )
   :signed-long
() )

(deftrap-inline "_semaphore_timedwait_signal" 
   ((wait_semaphore :pointer)
    (signal_semaphore :pointer)
    (wait_time (:pointer :mach_timespec))
   )
   :signed-long
() )

(require-interface "sys/appleapiopts")
; #ifdef  __APPLE_API_PRIVATE
#| #|
#ifdef __APPLE_API_EVOLVING

#define SEMAPHORE_OPTION_NONE		0x00000000

#define SEMAPHORE_SIGNAL		0x00000001
#define SEMAPHORE_WAIT			0x00000002
#define SEMAPHORE_WAIT_ON_SIGNAL	0x00000008

#define SEMAPHORE_SIGNAL_TIMEOUT	0x00000010
#define SEMAPHORE_SIGNAL_ALL		0x00000020
#define SEMAPHORE_SIGNAL_INTERRUPT	0x00000040	
#define SEMAPHORE_SIGNAL_PREPOST	0x00000080

#define SEMAPHORE_WAIT_TIMEOUT		0x00000100
#define SEMAPHORE_WAIT_INTERRUPT	0x00000400	

#define SEMAPHORE_TIMEOUT_NOBLOCK	0x00100000
#define SEMAPHORE_TIMEOUT_RELATIVE	0x00200000

#define SEMAPHORE_USE_SAVED_RESULT	0x01000000	
#define SEMAPHORE_SIGNAL_RELEASE	0x02000000	

extern  kern_return_t	semaphore_operator	(int options,
						 semaphore_t wait_semaphore,
						 semaphore_t signal_semaphore,
						 thread_act_t thread,
						 mach_timespec_t wait_time);

#endif

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif /* _MACH_SEMAPHORE_H_ */


(provide-interface "semaphore")