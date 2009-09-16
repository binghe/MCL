(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:mach_types.h"
; at Sunday July 2,2006 7:24:01 pm.
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
;  * Copyright (c) 1991,1990,1989,1988 Carnegie Mellon University
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
;  *	File:	mach/mach_types.h
;  *	Author:	Avadis Tevanian, Jr., Michael Wayne Young
;  *	Date:	1986
;  *
;  *	Mach external interface definitions.
;  *
;  
; #ifndef	_MACH_MACH_TYPES_H_
; #define _MACH_MACH_TYPES_H_

(require-interface "stdint")

(require-interface "mach/host_info")

(require-interface "mach/host_notify")

(require-interface "mach/host_special_ports")

(require-interface "mach/machine")

(require-interface "mach/machine/vm_types")

(require-interface "mach/memory_object_types")

(require-interface "mach/exception_types")

(require-interface "mach/port")

(require-interface "mach/processor_info")

(require-interface "mach/task_info")

(require-interface "mach/task_policy")

(require-interface "mach/task_special_ports")

(require-interface "mach/thread_info")

(require-interface "mach/thread_policy")

(require-interface "mach/thread_special_ports")

(require-interface "mach/thread_status")

(require-interface "mach/time_value")

(require-interface "mach/clock_types")

(require-interface "mach/vm_attributes")

(require-interface "mach/vm_inherit")

(require-interface "mach/vm_behavior")

(require-interface "mach/vm_prot")

(require-interface "mach/vm_statistics")

(require-interface "mach/vm_sync")

(require-interface "mach/vm_types")

(require-interface "mach/vm_region")

(require-interface "mach/kmod")
; #ifdef	KERNEL_PRIVATE
#| #|

#include <machvm_param.h>


typedef struct task			*task_t;
typedef struct thread		*thread_t, *thread_act_t;
typedef struct ipc_space		*ipc_space_t;
typedef struct host			*host_t;
typedef struct host			*host_priv_t;
typedef struct host			*host_security_t;
typedef struct processor		*processor_t;
typedef struct processor_set		*processor_set_t;
typedef struct processor_set		*processor_set_control_t;
typedef struct semaphore 		*semaphore_t;
typedef struct lock_set 		*lock_set_t;
typedef struct ledger 			*ledger_t;
typedef	struct alarm			*alarm_t;
typedef	struct clock			*clock_serv_t;
typedef	struct clock			*clock_ctrl_t;

#if!defined(MACH_KERNEL_PRIVATE)


struct task ;
struct thread ;
struct host ;
struct processor ;
struct processor_set ;
struct semaphore ;
struct lock_set ;
struct ledger ;
struct alarm ;
struct clock ;

#endif

|#
 |#

; #else	/* !KERNEL_PRIVATE */
; 
;  * If we are not in the kernel, then these will all be represented by
;  * ports at user-space.
;  

(def-mactype :task_t (find-mactype ':pointer))

(def-mactype :thread_t (find-mactype ':pointer))

(def-mactype :thread_act_t (find-mactype ':pointer))

(def-mactype :ipc_space_t (find-mactype ':pointer))

(def-mactype :host_t (find-mactype ':pointer))

(def-mactype :host_priv_t (find-mactype ':pointer))

(def-mactype :host_security_t (find-mactype ':pointer))

(def-mactype :processor_t (find-mactype ':pointer))

(def-mactype :processor_set_t (find-mactype ':pointer))

(def-mactype :processor_set_control_t (find-mactype ':pointer))

(def-mactype :semaphore_t (find-mactype ':pointer))

(def-mactype :lock_set_t (find-mactype ':pointer))

(def-mactype :ledger_t (find-mactype ':pointer))

(def-mactype :alarm_t (find-mactype ':pointer))

(def-mactype :clock_serv_t (find-mactype ':pointer))

(def-mactype :clock_ctrl_t (find-mactype ':pointer))

; #endif	/* !KERNEL_PRIVATE */

; 
;  * These aren't really unique types.  They are just called
;  * out as unique types at one point in history.  So we list
;  * them here for compatibility.
;  

(def-mactype :processor_set_name_t (find-mactype ':pointer))
; 
;  * JMM - These types are just hard-coded as ports for now
;  

(def-mactype :clock_reply_t (find-mactype ':pointer))

(def-mactype :bootstrap_t (find-mactype ':pointer))

(def-mactype :mem_entry_name_port_t (find-mactype ':pointer))

(def-mactype :exception_handler_t (find-mactype ':pointer))

(def-mactype :exception_handler_array_t (find-mactype '(:pointer :pointer)))

(def-mactype :vm_task_entry_t (find-mactype ':pointer))

(def-mactype :io_master_t (find-mactype ':pointer))

(def-mactype :UNDServerRef (find-mactype ':pointer))
; 
;  * JMM - Mig doesn't translate the components of an array.
;  * For example, Mig won't use the thread_t translations
;  * to translate a thread_array_t argument.  So, these definitions
;  * are not completely accurate at the moment for other kernel
;  * components. MIG is being fixed.
;  

(def-mactype :task_array_t (find-mactype '(:pointer :pointer)))

(def-mactype :thread_array_t (find-mactype '(:pointer :pointer)))

(def-mactype :processor_set_array_t (find-mactype '(:pointer :pointer)))

(def-mactype :processor_set_name_array_t (find-mactype '(:pointer :pointer)))

(def-mactype :processor_array_t (find-mactype '(:pointer :pointer)))

(def-mactype :thread_act_array_t (find-mactype '(:pointer :pointer)))

(def-mactype :ledger_array_t (find-mactype '(:pointer :pointer)))
; 
;  * However the real mach_types got declared, we also have to declare
;  * types with "port" in the name for compatability with the way OSF
;  * had declared the user interfaces at one point.  Someday these should
;  * go away.
;  

(def-mactype :task_port_t (find-mactype ':pointer))

(def-mactype :task_port_array_t (find-mactype ':task_array_t))

(def-mactype :thread_port_t (find-mactype ':pointer))

(def-mactype :thread_port_array_t (find-mactype ':thread_array_t))

(def-mactype :ipc_space_port_t (find-mactype ':pointer))

(def-mactype :host_name_t (find-mactype ':pointer))

(def-mactype :host_name_port_t (find-mactype ':pointer))

(def-mactype :processor_set_port_t (find-mactype ':pointer))

(def-mactype :processor_set_name_port_t (find-mactype ':pointer))

(def-mactype :processor_set_name_port_array_t (find-mactype ':processor_set_array_t))

(def-mactype :processor_set_control_port_t (find-mactype ':pointer))

(def-mactype :processor_port_t (find-mactype ':pointer))

(def-mactype :processor_port_array_t (find-mactype ':processor_array_t))

(def-mactype :thread_act_port_t (find-mactype ':pointer))

(def-mactype :thread_act_port_array_t (find-mactype ':thread_act_array_t))

(def-mactype :semaphore_port_t (find-mactype ':pointer))

(def-mactype :lock_set_port_t (find-mactype ':pointer))

(def-mactype :ledger_port_t (find-mactype ':pointer))

(def-mactype :ledger_port_array_t (find-mactype ':ledger_array_t))

(def-mactype :alarm_port_t (find-mactype ':pointer))

(def-mactype :clock_serv_port_t (find-mactype ':pointer))

(def-mactype :clock_ctrl_port_t (find-mactype ':pointer))

(def-mactype :exception_port_t (find-mactype ':pointer))

(def-mactype :exception_port_arrary_t (find-mactype ':exception_handler_array_t))
(defconstant $TASK_NULL 0)
; #define TASK_NULL		((task_t) 0)
(defconstant $THREAD_NULL 0)
; #define THREAD_NULL		((thread_t) 0)
(defconstant $THR_ACT_NULL 0)
; #define THR_ACT_NULL 		((thread_act_t) 0)
(defconstant $IPC_SPACE_NULL 0)
; #define IPC_SPACE_NULL		((ipc_space_t) 0)
(defconstant $HOST_NULL 0)
; #define HOST_NULL		((host_t) 0)
(defconstant $HOST_PRIV_NULL 0)
; #define HOST_PRIV_NULL		((host_priv_t)0)
(defconstant $HOST_SECURITY_NULL 0)
; #define HOST_SECURITY_NULL	((host_security_t)0)
(defconstant $PROCESSOR_SET_NULL 0)
; #define PROCESSOR_SET_NULL	((processor_set_t) 0)
(defconstant $PROCESSOR_NULL 0)
; #define PROCESSOR_NULL		((processor_t) 0)
(defconstant $SEMAPHORE_NULL 0)
; #define SEMAPHORE_NULL		((semaphore_t) 0)
(defconstant $LOCK_SET_NULL 0)
; #define LOCK_SET_NULL		((lock_set_t) 0)
(defconstant $LEDGER_NULL 0)
; #define LEDGER_NULL 		((ledger_t) 0)
(defconstant $ALARM_NULL 0)
; #define ALARM_NULL		((alarm_t) 0)
(defconstant $CLOCK_NULL 0)
; #define CLOCK_NULL		((clock_t) 0)
(defconstant $UND_SERVER_NULL 0)
; #define UND_SERVER_NULL		((UNDServerRef) 0)

(def-mactype :ledger_item_t (find-mactype ':signed-long))

(def-mactype :emulation_vector_t (find-mactype '(:pointer :UInt32)))

(def-mactype :user_subsystem_t (find-mactype '(:pointer :character)))
; 
;  *	Backwards compatibility, for those programs written
;  *	before mach/{std,mach}_types.{defs,h} were set up.
;  

(require-interface "mach/std_types")

; #endif	/* _MACH_MACH_TYPES_H_ */


(provide-interface "mach_types")