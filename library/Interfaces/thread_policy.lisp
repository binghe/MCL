(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:thread_policy.h"
; at Sunday July 2,2006 7:24:09 pm.
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
;  * Copyright (c) 2000 Apple Computer, Inc.  All rights reserved.
;  *
;  * HISTORY
;  *
;  * 10 October 2000 (debo)
;  *  Created.
;  *
;  * 30 November 2000 (debo)
;  *	Final resolution of review feedback.
;  
; #ifndef _MACH_THREAD_POLICY_H_
; #define _MACH_THREAD_POLICY_H_

(require-interface "mach/mach_types")
; 
;  * These are the calls for accessing the policy parameters
;  * of a particular thread.
;  *
;  * The extra 'get_default' parameter to the second call is
;  * IN/OUT as follows:
;  * 1) if asserted on the way in it indicates that the default
;  * values should be returned, not the ones currently set, in
;  * this case 'get_default' will always be asserted on return;
;  * 2) if unasserted on the way in, the current settings are
;  * desired and if still unasserted on return, then the info
;  * returned reflects the current settings, otherwise if
;  * 'get_default' returns asserted, it means that there are no
;  * current settings due to other parameters taking precedence,
;  * and the default ones are being returned instead.
;  

(def-mactype :thread_policy_flavor_t (find-mactype ':UInt32))

(def-mactype :thread_policy_t (find-mactype '(:pointer :signed-long)))
; 
; kern_return_t	thread_policy_set(
; 					thread_act_t				thread,
; 					thread_policy_flavor_t		flavor,
; 					thread_policy_t				policy_info,
; 					mach_msg_type_number_t		count);
; 
; kern_return_t	thread_policy_get(
; 					thread_act_t				thread,
; 					thread_policy_flavor_t		flavor,
; 					thread_policy_t				policy_info,
; 					mach_msg_type_number_t		*count,
; 					boolean_t					*get_default);
; 
; 
;  * Defined flavors.
;  
; 
;  * THREAD_STANDARD_POLICY:
;  *
;  * This is the standard (fair) scheduling mode, assigned to new
;  * threads.  The thread will be given processor time in a manner
;  * which apportions approximately equal share to long running
;  * computations.
;  *
;  * Parameters:
;  *	[none]
;  
(defconstant $THREAD_STANDARD_POLICY 1)
; #define THREAD_STANDARD_POLICY			1
(defrecord thread_standard_policy
   (no_data :UInt32)
)

(%define-record :thread_standard_policy_data_t (find-record-descriptor ':thread_standard_policy))

(def-mactype :thread_standard_policy_t (find-mactype '(:pointer :thread_standard_policy)))
(defconstant $THREAD_STANDARD_POLICY_COUNT 0)
; #define THREAD_STANDARD_POLICY_COUNT	0
; 
;  * THREAD_EXTENDED_POLICY:
;  *
;  * Extended form of THREAD_STANDARD_POLICY, which supplies a
;  * hint indicating whether this is a long running computation.
;  *
;  * Parameters:
;  *
;  * timeshare: TRUE (the default) results in identical scheduling
;  * behavior as THREAD_STANDARD_POLICY.
;  
(defconstant $THREAD_EXTENDED_POLICY 1)
; #define THREAD_EXTENDED_POLICY			1
(defrecord thread_extended_policy
   (timeshare :signed-long)
)

(%define-record :thread_extended_policy_data_t (find-record-descriptor ':thread_extended_policy))

(def-mactype :thread_extended_policy_t (find-mactype '(:pointer :thread_extended_policy)))
(defconstant $THREAD_EXTENDED_POLICY_COUNT 1)
; #define THREAD_EXTENDED_POLICY_COUNT		(sizeof (thread_extended_policy_data_t) / sizeof (integer_t))
; 
;  * THREAD_TIME_CONSTRAINT_POLICY:
;  *
;  * This scheduling mode is for threads which have real time
;  * constraints on their execution.
;  *
;  * Parameters:
;  *
;  * period: This is the nominal amount of time between separate
;  * processing arrivals, specified in absolute time units.  A
;  * value of 0 indicates that there is no inherent periodicity in
;  * the computation.
;  *
;  * computation: This is the nominal amount of computation
;  * time needed during a separate processing arrival, specified
;  * in absolute time units.
;  *
;  * constraint: This is the maximum amount of real time that
;  * may elapse from the start of a separate processing arrival
;  * to the end of computation for logically correct functioning,
;  * specified in absolute time units.  Must be (>= computation).
;  * Note that latency = (constraint - computation).
;  *
;  * preemptible: This indicates that the computation may be
;  * interrupted, subject to the constraint specified above.
;  
(defconstant $THREAD_TIME_CONSTRAINT_POLICY 2)
; #define THREAD_TIME_CONSTRAINT_POLICY	2
(defrecord thread_time_constraint_policy
   (period :UInt32)
   (computation :UInt32)
   (constraint :UInt32)
   (preemptible :signed-long)
)

(%define-record :thread_time_constraint_policy_data_t (find-record-descriptor ':thread_time_constraint_policy))

(def-mactype :thread_time_constraint_policy_t (find-mactype '(:pointer :thread_time_constraint_policy)))
(defconstant $THREAD_TIME_CONSTRAINT_POLICY_COUNT 1)
; #define THREAD_TIME_CONSTRAINT_POLICY_COUNT		(sizeof (thread_time_constraint_policy_data_t) / sizeof (integer_t))
; 
;  * THREAD_PRECEDENCE_POLICY:
;  *
;  * This may be used to indicate the relative value of the
;  * computation compared to the other threads in the task.
;  *
;  * Parameters:
;  *
;  * importance: The importance is specified as a signed value.
;  
(defconstant $THREAD_PRECEDENCE_POLICY 3)
; #define THREAD_PRECEDENCE_POLICY		3
(defrecord thread_precedence_policy
   (importance :signed-long)
)

(%define-record :thread_precedence_policy_data_t (find-record-descriptor ':thread_precedence_policy))

(def-mactype :thread_precedence_policy_t (find-mactype '(:pointer :thread_precedence_policy)))
(defconstant $THREAD_PRECEDENCE_POLICY_COUNT 1)
; #define THREAD_PRECEDENCE_POLICY_COUNT		(sizeof (thread_precedence_policy_data_t) / sizeof (integer_t))

; #endif	/* _MACH_THREAD_POLICY_H_ */


(provide-interface "thread_policy")