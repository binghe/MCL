(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:kern_types.h"
; at Sunday July 2,2006 7:26:19 pm.
; 
;  * Copyright (c) 2002,2000 Apple Computer, Inc. All rights reserved.
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
; #ifndef	_KERN_KERN_TYPES_H_
; #define	_KERN_KERN_TYPES_H_

(require-interface "stdint")

(require-interface "mach/mach_types")

(require-interface "mach/machine/vm_types")

(require-interface "sys/appleapiopts")

; #if !defined(MACH_KERNEL_PRIVATE)
; 
;  * Declare empty structure definitions for export to other
;  * kernel components.  This lets us still provide some level
;  * of type checking, without exposing our internal data
;  * structures.
;  
(defrecord wait_queue
   (opaque (:array :UInt32 2))
   (opaquep (:array :uintptr_t 2))
#|
; Warning: type-size: unknown type uintptr_t
|#
)

; #endif /* MACH_KERNEL_PRIVATE */


(def-mactype :zone_t (find-mactype '(:pointer :zone)))
(defconstant $ZONE_NULL 0)
; #define		ZONE_NULL			((zone_t) 0)

(def-mactype :wait_queue_t (find-mactype '(:pointer :wait_queue)))
(defconstant $WAIT_QUEUE_NULL 0)
; #define		WAIT_QUEUE_NULL 	((wait_queue_t) 0)
; #define 		SIZEOF_WAITQUEUE	sizeof(struct wait_queue)

(def-mactype :ipc_kobject_t (find-mactype ':UInt32))
(defconstant $IKO_NULL 0)
; #define		IKO_NULL			((ipc_kobject_t) 0)

(def-mactype :event_t (find-mactype '(:pointer :void)))
;  wait event 
(defconstant $NO_EVENT 0)
; #define		NO_EVENT			((event_t) 0)

(%define-record :event64_t (find-record-descriptor ':uint64_t))
;  64 bit wait event 
(defconstant $NO_EVENT64 0)
; #define		NO_EVENT64		((event64_t) 0)
; 
;  *	Possible wait_result_t values.
;  

(def-mactype :wait_result_t (find-mactype ':signed-long))
; #define THREAD_WAITING		-1		/* thread is waiting */
(defconstant $THREAD_AWAKENED 0)
; #define THREAD_AWAKENED		0		/* normal wakeup */
(defconstant $THREAD_TIMED_OUT 1)
; #define THREAD_TIMED_OUT	1		/* timeout expired */
(defconstant $THREAD_INTERRUPTED 2)
; #define THREAD_INTERRUPTED	2		/* aborted/interrupted */
(defconstant $THREAD_RESTART 3)
; #define THREAD_RESTART		3		/* restart operation entirely */

(def-mactype :thread_continue_t (find-mactype ':pointer)); (void)
;  where to resume it 
(defconstant $THREAD_CONTINUE_NULL 0)
; #define	THREAD_CONTINUE_NULL	((thread_continue_t) 0)
; 
;  * Interruptible flag for waits.
;  

(def-mactype :wait_interrupt_t (find-mactype ':signed-long))
(defconstant $THREAD_UNINT 0)
; #define THREAD_UNINT			0		/* not interruptible      */
(defconstant $THREAD_INTERRUPTIBLE 1)
; #define THREAD_INTERRUPTIBLE	1		/* may not be restartable */
(defconstant $THREAD_ABORTSAFE 2)
; #define THREAD_ABORTSAFE		2		/* abortable safely       */
; #ifdef	__APPLE_API_PRIVATE
#| #|

#ifdefMACH_KERNEL_PRIVATE

#include <kernmisc_protos.h>
typedef  struct clock			*clock_t;

#endif

#ifdef__APPLE_API_EVOLVING

#ifndefMACH_KERNEL_PRIVATE
struct wait_queue_set ;
struct wait_queue_link ;
#endif
typedef struct wait_queue_set	*wait_queue_set_t;
#define WAIT_QUEUE_SET_NULL 	((wait_queue_set_t)0)
#define SIZEOF_WAITQUEUE_SET	wait_queue_set_size()

typedef struct wait_queue_link	*wait_queue_link_t;
#define WAIT_QUEUE_LINK_NULL	((wait_queue_link_t)0)
#define SIZEOF_WAITQUEUE_LINK	wait_queue_link_size()

typedef struct mig_object		*mig_object_t;
#define MIG_OBJECT_NULL			((mig_object_t) 0)

typedef struct mig_notify		*mig_notify_t;
#define MIG_NOTIFY_NULL 		((mig_notify_t) 0)

typedef boolean_t				(*thread_roust_t)(thread_t, wait_result_t);
#define THREAD_ROUST_NULL	 	((thread_roust_t) 0)

#endif

#ifdef__APPLE_API_UNSTABLE


typedef struct thread			*thread_shuttle_t;
#define THREAD_SHUTTLE_NULL		((thread_shuttle_t)0)
struct wait_queue_sub ;
typedef struct wait_queue_sub	*wait_queue_sub_t;
#define WAIT_QUEUE_SUB_NULL 	((wait_queue_sub_t)0)
#define SIZEOF_WAITQUEUE_SUB	wait_queue_set_size()

#endif  

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif	/* _KERN_KERN_TYPES_H_ */


(provide-interface "kern_types")