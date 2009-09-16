(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:task_policy.h"
; at Sunday July 2,2006 7:24:07 pm.
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
; #ifndef _MACH_TASK_POLICY_H_
; #define _MACH_TASK_POLICY_H_

(require-interface "mach/mach_types")
; 
;  * These are the calls for accessing the policy parameters
;  * of a particular task.
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

(def-mactype :task_policy_flavor_t (find-mactype ':UInt32))

(def-mactype :task_policy_t (find-mactype '(:pointer :signed-long)))
; 
; kern_return_t	task_policy_set(
; 					task_t					task,
; 					task_policy_flavor_t	flavor,
; 					task_policy_t			policy_info,
; 					mach_msg_type_number_t	count);
; 
; kern_return_t	task_policy_get(
; 					task_t					task,
; 					task_policy_flavor_t	flavor,
; 					task_policy_t			policy_info,
; 					mach_msg_type_number_t	*count,
; 					boolean_t				*get_default);
; 
; 
;  * Defined flavors.
;  
; 
;  * TASK_CATEGORY_POLICY:
;  *
;  * This provides information to the kernel about the role
;  * of the task in the system.
;  *
;  * Parameters:
;  *
;  * role: Enumerated as follows:
;  *
;  * TASK_UNSPECIFIED is the default, since the role is not
;  * inherited from the parent.
;  *
;  * TASK_FOREGROUND_APPLICATION should be assigned when the
;  * task is a normal UI application in the foreground from
;  * the HI point of view.
;  * **N.B. There may be more than one of these at a given time.
;  *
;  * TASK_BACKGROUND_APPLICATION should be assigned when the
;  * task is a normal UI application in the background from
;  * the HI point of view.
;  *
;  * TASK_CONTROL_APPLICATION should be assigned to the unique
;  * UI application which implements the pop-up application dialog.
;  * There can only be one task at a time with this designation,
;  * which is assigned FCFS.
;  *
;  * TASK_GRAPHICS_SERVER should be assigned to the graphics
;  * management (window) server.  There can only be one task at
;  * a time with this designation, which is assigned FCFS.
;  
(defconstant $TASK_CATEGORY_POLICY 1)
; #define TASK_CATEGORY_POLICY		1
(def-mactype :task_role (find-mactype ':sint32))

(defconstant $TASK_RENICED -1)
(defconstant $TASK_UNSPECIFIED 0)
(defconstant $TASK_FOREGROUND_APPLICATION 1)
(defconstant $TASK_BACKGROUND_APPLICATION 2)
(defconstant $TASK_CONTROL_APPLICATION 3)
(defconstant $TASK_GRAPHICS_SERVER 4)

(def-mactype :task_role_t (find-mactype ':task_role))
(defrecord task_category_policy
   (role :TASK_ROLE_T)
#|
; Warning: type-size: unknown type TASK_ROLE_T
|#
)

(%define-record :task_category_policy_data_t (find-record-descriptor ':task_category_policy))

(def-mactype :task_category_policy_t (find-mactype '(:pointer :task_category_policy)))
(defconstant $TASK_CATEGORY_POLICY_COUNT 1)
; #define TASK_CATEGORY_POLICY_COUNT		(sizeof (task_category_policy_data_t) / sizeof (integer_t))

; #endif	/* _MACH_TASK_POLICY_H_ */


(provide-interface "task_policy")