(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:mach_traps.h"
; at Sunday July 2,2006 7:30:23 pm.
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
;  *	Definitions of general Mach system traps.
;  *
;  *	IPC traps are defined in <mach/message.h>.
;  *	Kernel RPC functions are defined in <mach/mach_interface.h>.
;  
; #ifndef	_MACH_MACH_TRAPS_H_
; #define _MACH_MACH_TRAPS_H_

(require-interface "mach/kern_return")

(require-interface "mach/port")

(require-interface "mach/vm_types")

(require-interface "mach/clock_types")

(deftrap-inline "_semaphore_signal_trap" 
   ((signal_name :mach_port_name_t)
   )
   :signed-long
() )

(deftrap-inline "_semaphore_signal_all_trap" 
   ((signal_name :mach_port_name_t)
   )
   :signed-long
() )

(deftrap-inline "_semaphore_signal_thread_trap" 
   ((signal_name :mach_port_name_t)
    (thread_name :mach_port_name_t)
   )
   :signed-long
() )

(deftrap-inline "_semaphore_wait_trap" 
   ((wait_name :mach_port_name_t)
   )
   :signed-long
() )

(deftrap-inline "_semaphore_timedwait_trap" 
   ((wait_name :mach_port_name_t)
    (sec :UInt32)
    (nsec :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_semaphore_wait_signal_trap" 
   ((wait_name :mach_port_name_t)
    (signal_name :mach_port_name_t)
   )
   :signed-long
() )

(deftrap-inline "_semaphore_timedwait_signal_trap" 
   ((wait_name :mach_port_name_t)
    (signal_name :mach_port_name_t)
    (sec :UInt32)
    (nsec :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_init_process" 
   (
   )
   :signed-long
() )

(deftrap-inline "_map_fd" 
   ((fd :signed-long)
    (offset :UInt32)
    (va (:pointer :vm_offset_t))
    (findspace :signed-long)
    (size :UInt32)
   )
   :signed-long
() )

(deftrap-inline "_task_for_pid" 
   ((target_tport :pointer)
    (pid :signed-long)
    (t (:pointer :mach_port_t))
   )
   :signed-long
() )

(deftrap-inline "_pid_for_task" 
   ((t :pointer)
    (x (:pointer :int))
   )
   :signed-long
() )

(deftrap-inline "_macx_swapon" 
   ((name (:pointer :char))
    (flags :signed-long)
    (size :signed-long)
    (priority :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_macx_swapoff" 
   ((name (:pointer :char))
    (flags :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_macx_triggers" 
   ((hi_water :signed-long)
    (low_water :signed-long)
    (flags :signed-long)
    (alert_port :pointer)
   )
   :signed-long
() )

(deftrap-inline "_macx_backing_store_suspend" 
   ((suspend :signed-long)
   )
   :signed-long
() )

(deftrap-inline "_macx_backing_store_recovery" 
   ((pid :signed-long)
   )
   :signed-long
() )

; #endif	/* _MACH_MACH_TRAPS_H_ */


(provide-interface "mach_traps")