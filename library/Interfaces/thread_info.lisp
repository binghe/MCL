(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:thread_info.h"
; at Sunday July 2,2006 7:24:08 pm.
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
;  *	File:	mach/thread_info
;  *
;  *	Thread information structure and definitions.
;  *
;  *	The defintions in this file are exported to the user.  The kernel
;  *	will translate its internal data structures to these structures
;  *	as appropriate.
;  *
;  
; #ifndef	_MACH_THREAD_INFO_H_
; #define _MACH_THREAD_INFO_H_

(require-interface "sys/appleapiopts")

(require-interface "mach/boolean")

(require-interface "mach/policy")

(require-interface "mach/time_value")

(require-interface "mach/machine/vm_types")
; 
;  *	Generic information structure to allow for expansion.
;  

(def-mactype :thread_flavor_t (find-mactype ':UInt32))

(def-mactype :thread_info_t (find-mactype '(:pointer :signed-long)))
;  varying array of int 
(defconstant $THREAD_INFO_MAX 1024)
; #define THREAD_INFO_MAX		(1024)	/* maximum array size */
(defrecord thread_info_data_t
   (contents (:array :signed-long 1024))
)
; 
;  *	Currently defined information.
;  
(defconstant $THREAD_BASIC_INFO 3)
; #define THREAD_BASIC_INFO         	3     /* basic information */
(defrecord thread_basic_info
   (user_time :time_value)                      ;  user run time 
   (system_time :time_value)                    ;  system run time 
   (cpu_usage :signed-long)                     ;  scaled cpu usage percentage 
   (policy :signed-long)
                                                ;  scheduling policy in effect 
   (run_state :signed-long)                     ;  run state (see below) 
   (flags :signed-long)                         ;  various flags (see below) 
   (suspend_count :signed-long)                 ;  suspend count for thread 
   (sleep_time :signed-long)                    ;  number of seconds that thread
;                                            has been sleeping 
)

(%define-record :thread_basic_info_data_t (find-record-descriptor ':thread_basic_info))

(def-mactype :thread_basic_info_t (find-mactype '(:pointer :thread_basic_info)))
(defconstant $THREAD_BASIC_INFO_COUNT 1)
; #define THREAD_BASIC_INFO_COUNT                   (sizeof(thread_basic_info_data_t) / sizeof(natural_t))
; 
;  *	Scale factor for usage field.
;  
(defconstant $TH_USAGE_SCALE 1000)
; #define TH_USAGE_SCALE	1000
; 
;  *	Thread run states (state field).
;  
(defconstant $TH_STATE_RUNNING 1)
; #define TH_STATE_RUNNING	1	/* thread is running normally */
(defconstant $TH_STATE_STOPPED 2)
; #define TH_STATE_STOPPED	2	/* thread is stopped */
(defconstant $TH_STATE_WAITING 3)
; #define TH_STATE_WAITING	3	/* thread is waiting normally */
(defconstant $TH_STATE_UNINTERRUPTIBLE 4)
; #define TH_STATE_UNINTERRUPTIBLE 4	/* thread is in an uninterruptible
(defconstant $TH_STATE_HALTED 5)
; #define TH_STATE_HALTED		5	/* thread is halted at a
; 
;  *	Thread flags (flags field).
;  
(defconstant $TH_FLAGS_SWAPPED 1)
; #define TH_FLAGS_SWAPPED	0x1	/* thread is swapped out */
(defconstant $TH_FLAGS_IDLE 2)
; #define TH_FLAGS_IDLE		0x2	/* thread is an idle thread */
; #ifdef	__APPLE_API_UNSTABLE
#| #|

#define THREAD_SCHED_TIMESHARE_INFO	10
#define THREAD_SCHED_RR_INFO		11
#define THREAD_SCHED_FIFO_INFO		12

#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif	/* _MACH_THREAD_INFO_H_ */


(provide-interface "thread_info")