(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:task_info.h"
; at Sunday July 2,2006 7:24:06 pm.
; 
;  * Copyright (c) 2000-2003 Apple Computer, Inc. All rights reserved.
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
;  *	Machine-independent task information structures and definitions.
;  *
;  *	The definitions in this file are exported to the user.  The kernel
;  *	will translate its internal data structures to these structures
;  *	as appropriate.
;  *
;  
; #ifndef	TASK_INFO_H_
; #define	TASK_INFO_H_

(require-interface "mach/machine/vm_types")

(require-interface "mach/time_value")

(require-interface "mach/policy")

(require-interface "sys/appleapiopts")
; 
;  *	Generic information structure to allow for expansion.
;  

(def-mactype :task_flavor_t (find-mactype ':UInt32))

(def-mactype :task_info_t (find-mactype '(:pointer :signed-long)))
;  varying array of int 
(defconstant $TASK_INFO_MAX 1024)
; #define	TASK_INFO_MAX	(1024)		/* maximum array size */
(defrecord task_info_data_t
   (contents (:array :signed-long 1024))
)
; 
;  *	Currently defined information structures.
;  
(defconstant $TASK_BASIC_INFO 4)
; #define TASK_BASIC_INFO         4       /* basic information */
(defrecord task_basic_info
   (suspend_count :signed-long)                 ;  suspend count for task 
   (virtual_size :UInt32)                       ;  number of virtual pages 
   (resident_size :UInt32)                      ;  number of resident pages 
   (user_time :time_value)                      ;  total user run time for
;                                            terminated threads 
   (system_time :time_value)                    ;  total system run time for
;                                            terminated threads 
   (policy :signed-long)
                                                ;  default policy for new threads 
)

(%define-record :task_basic_info_data_t (find-record-descriptor ':task_basic_info))

(def-mactype :task_basic_info_t (find-mactype '(:pointer :task_basic_info)))
(defconstant $TASK_BASIC_INFO_COUNT 1)
; #define TASK_BASIC_INFO_COUNT                   (sizeof(task_basic_info_data_t) / sizeof(natural_t))
(defconstant $TASK_EVENTS_INFO 2)
; #define	TASK_EVENTS_INFO	2	/* various event counts */
(defrecord task_events_info
   (faults :signed-long)
                                                ;  number of page faults 
   (pageins :signed-long)
                                                ;  number of actual pageins 
   (cow_faults :signed-long)
                                                ;  number of copy-on-write faults 
   (messages_sent :signed-long)
                                                ;  number of messages sent 
   (messages_received :signed-long)             ;  number of messages received 
   (syscalls_mach :signed-long)                 ;  number of mach system calls 
   (syscalls_unix :signed-long)                 ;  number of unix system calls 
   (csw :signed-long)                           ;  number of context switches 
)

(%define-record :task_events_info_data_t (find-record-descriptor ':task_events_info))

(def-mactype :task_events_info_t (find-mactype '(:pointer :task_events_info)))
(defconstant $TASK_EVENTS_INFO_COUNT 1)
; #define	TASK_EVENTS_INFO_COUNT			(sizeof(task_events_info_data_t) / sizeof(natural_t))
(defconstant $TASK_THREAD_TIMES_INFO 3)
; #define	TASK_THREAD_TIMES_INFO	3	/* total times for live threads -
(defrecord task_thread_times_info
   (user_time :time_value)
                                                ;  total user run time for
; 					   live threads 
   (system_time :time_value)
                                                ;  total system run time for
; 					   live threads 
)

(%define-record :task_thread_times_info_data_t (find-record-descriptor ':task_thread_times_info))

(def-mactype :task_thread_times_info_t (find-mactype '(:pointer :task_thread_times_info)))
(defconstant $TASK_THREAD_TIMES_INFO_COUNT 1)
; #define	TASK_THREAD_TIMES_INFO_COUNT			(sizeof(task_thread_times_info_data_t) / sizeof(natural_t))
; #ifdef	__APPLE_API_UNSTABLE
#| #|

#define TASK_SCHED_TIMESHARE_INFO	10
#define TASK_SCHED_RR_INFO		11
#define TASK_SCHED_FIFO_INFO		12

#define TASK_SCHED_INFO			14

#endif
|#
 |#
;  __APPLE_API_UNSTABLE 
(defconstant $TASK_SECURITY_TOKEN 13)
; #define TASK_SECURITY_TOKEN		13
#|
; Warning: type-size: unknown type SECURITY_TOKEN_T
|#
(defconstant $TASK_SECURITY_TOKEN_COUNT 1)
; #define TASK_SECURITY_TOKEN_COUNT			(sizeof(security_token_t) / sizeof(natural_t))
(defconstant $TASK_AUDIT_TOKEN 15)
; #define TASK_AUDIT_TOKEN		15
#|
; Warning: type-size: unknown type AUDIT_TOKEN_T
|#
(defconstant $TASK_AUDIT_TOKEN_COUNT 1)
; #define TASK_AUDIT_TOKEN_COUNT			(sizeof(audit_token_t) / sizeof(natural_t))

; #endif	/* TASK_INFO_H_ */


(provide-interface "task_info")