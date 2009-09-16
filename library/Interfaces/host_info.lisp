(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:host_info.h"
; at Sunday July 2,2006 7:24:01 pm.
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
;  *	File:	mach/host_info.h
;  *
;  *	Definitions for host_info call.
;  
; #ifndef	_MACH_HOST_INFO_H_
; #define	_MACH_HOST_INFO_H_

(require-interface "mach/vm_statistics")

(require-interface "mach/machine")

(require-interface "mach/machine/vm_types")

(require-interface "mach/time_value")
; 
;  *	Generic information structure to allow for expansion.
;  

(def-mactype :host_info_t (find-mactype '(:pointer :signed-long)))
;  varying array of int. 
(defconstant $HOST_INFO_MAX 1024)
; #define	HOST_INFO_MAX	(1024)		/* max array size */
(defrecord host_info_data_t
   (contents (:array :signed-long 1024))
)
(defconstant $KERNEL_VERSION_MAX 512)
; #define KERNEL_VERSION_MAX (512)
(defrecord kernel_version_t
   (contents (:array :character 512))
)
(defconstant $KERNEL_BOOT_INFO_MAX 4096)
; #define KERNEL_BOOT_INFO_MAX (4096)
(defrecord kernel_boot_info_t
   (contents (:array :character 4096))
)
(defconstant $KERNEL_BOOTMAGIC_MAX 8192)
; #define	KERNEL_BOOTMAGIC_MAX	(8192)
; 
;  *	Currently defined information.
;  
;  host_info() 

(def-mactype :host_flavor_t (find-mactype ':signed-long))
(defconstant $HOST_BASIC_INFO 1)
; #define HOST_BASIC_INFO		1	/* basic info */
(defconstant $HOST_SCHED_INFO 3)
; #define HOST_SCHED_INFO		3	/* scheduling info */
(defconstant $HOST_RESOURCE_SIZES 4)
; #define HOST_RESOURCE_SIZES	4	/* kernel struct sizes */
(defconstant $HOST_PRIORITY_INFO 5)
; #define HOST_PRIORITY_INFO	5	/* priority information */
(defconstant $HOST_SEMAPHORE_TRAPS 7)
; #define HOST_SEMAPHORE_TRAPS	7	/* Has semaphore traps */
(defconstant $HOST_MACH_MSG_TRAP 8)
; #define HOST_MACH_MSG_TRAP	8	/* Has mach_msg_trap */
(defrecord host_basic_info
   (max_cpus :signed-long)
                                                ;  max number of cpus possible 
   (avail_cpus :signed-long)
                                                ;  number of cpus now available 
   (memory_size :UInt32)
                                                ;  size of memory in bytes 
   (cpu_type :signed-long)
                                                ;  cpu type 
   (cpu_subtype :signed-long)
                                                ;  cpu subtype 
)

(%define-record :host_basic_info_data_t (find-record-descriptor ':host_basic_info))

(def-mactype :host_basic_info_t (find-mactype '(:pointer :host_basic_info)))
(defconstant $HOST_BASIC_INFO_COUNT 1)
; #define HOST_BASIC_INFO_COUNT 		(sizeof(host_basic_info_data_t)/sizeof(integer_t))
(defrecord host_sched_info
   (min_timeout :signed-long)
                                                ;  minimum timeout in milliseconds 
   (min_quantum :signed-long)
                                                ;  minimum quantum in milliseconds 
)

(%define-record :host_sched_info_data_t (find-record-descriptor ':host_sched_info))

(def-mactype :host_sched_info_t (find-mactype '(:pointer :host_sched_info)))
(defconstant $HOST_SCHED_INFO_COUNT 1)
; #define HOST_SCHED_INFO_COUNT 		(sizeof(host_sched_info_data_t)/sizeof(integer_t))
(defrecord kernel_resource_sizes
   (task :UInt32)
   (thread :UInt32)
   (port :UInt32)
   (memory_region :UInt32)
   (memory_object :UInt32)
)

(%define-record :kernel_resource_sizes_data_t (find-record-descriptor ':kernel_resource_sizes))

(def-mactype :kernel_resource_sizes_t (find-mactype '(:pointer :kernel_resource_sizes)))
(defconstant $HOST_RESOURCE_SIZES_COUNT 1)
; #define HOST_RESOURCE_SIZES_COUNT 		(sizeof(kernel_resource_sizes_data_t)/sizeof(integer_t))
(defrecord host_priority_info
   (kernel_priority :signed-long)
   (system_priority :signed-long)
   (server_priority :signed-long)
   (user_priority :signed-long)
   (depress_priority :signed-long)
   (idle_priority :signed-long)
   (minimum_priority :signed-long)
   (maximum_priority :signed-long)
)

(%define-record :host_priority_info_data_t (find-record-descriptor ':host_priority_info))

(def-mactype :host_priority_info_t (find-mactype '(:pointer :host_priority_info)))
(defconstant $HOST_PRIORITY_INFO_COUNT 1)
; #define HOST_PRIORITY_INFO_COUNT 		(sizeof(host_priority_info_data_t)/sizeof(integer_t))
;  host_statistics() 
(defconstant $HOST_LOAD_INFO 1)
; #define	HOST_LOAD_INFO		1	/* System loading stats */
(defconstant $HOST_VM_INFO 2)
; #define HOST_VM_INFO		2	/* Virtual memory stats */
(defconstant $HOST_CPU_LOAD_INFO 3)
; #define HOST_CPU_LOAD_INFO	3	/* CPU load stats */
(defrecord host_load_info
   (avenrun (:array :signed-long 3))
                                                ;  scaled by LOAD_SCALE 
   (mach_factor (:array :signed-long 3))
                                                ;  scaled by LOAD_SCALE 
)

(%define-record :host_load_info_data_t (find-record-descriptor ':host_load_info))

(def-mactype :host_load_info_t (find-mactype '(:pointer :host_load_info)))
(defconstant $HOST_LOAD_INFO_COUNT 1)
; #define	HOST_LOAD_INFO_COUNT 		(sizeof(host_load_info_data_t)/sizeof(integer_t))
;  in <mach/vm_statistics.h> 
(defconstant $HOST_VM_INFO_COUNT 1)
; #define	HOST_VM_INFO_COUNT 		(sizeof(vm_statistics_data_t)/sizeof(integer_t))
(defrecord host_cpu_load_info
                                                ;  number of ticks while running... 
   (cpu_ticks (:array :UInt32 4))               ;  ... in the given mode 
)

(%define-record :host_cpu_load_info_data_t (find-record-descriptor ':host_cpu_load_info))

(def-mactype :host_cpu_load_info_t (find-mactype '(:pointer :host_cpu_load_info)))
(defconstant $HOST_CPU_LOAD_INFO_COUNT 1)
; #define HOST_CPU_LOAD_INFO_COUNT 		(sizeof (host_cpu_load_info_data_t) / sizeof (integer_t))

; #endif	/* _MACH_HOST_INFO_H_ */


(provide-interface "host_info")