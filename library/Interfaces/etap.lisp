(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:etap.h"
; at Sunday July 2,2006 7:26:28 pm.
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
;  * File : etap.h 
;  *
;  *	  Contains ETAP buffer and table definitions
;  *
;  
; #ifndef _MACH_ETAP_H_
; #define _MACH_ETAP_H_

(require-interface "mach/machine/boolean")

(require-interface "mach/etap_events")

(require-interface "mach/clock_types")

(require-interface "mach/time_value")

(require-interface "mach/kern_return")
(defconstant $ETAP_CBUFF_ENTRIES 20000)
; #define ETAP_CBUFF_ENTRIES	20000
(defconstant $ETAP_CBUFF_IBUCKETS 10)
; #define ETAP_CBUFF_IBUCKETS	10
(defconstant $ETAP_CBUFF_WIDTH 80)
; #define	ETAP_CBUFF_WIDTH	80
(defconstant $ETAP_MBUFF_ENTRIES 28000)
; #define ETAP_MBUFF_ENTRIES	28000
(defconstant $ETAP_MBUFF_DATASIZE 4)
; #define ETAP_MBUFF_DATASIZE	4
;  ===================================
;  * Event & Subsystem Table Definitions
;  * ===================================
;  
(defconstant $EVENT_NAME_LENGTH 20)
; #define EVENT_NAME_LENGTH    20                    /* max event name size  */
(defrecord event_table_entry
   (event :UInt16)
                                                ;  etap event type      
   (status :UInt16)                             ;  event trace status   
   (name (:array :character 20))                ;  event text name      
   (dynamic :UInt16)                            ;  dynamic ID (0=none)  
)
(defrecord subs_table_entry
   (subs :UInt16)                               ;  etap subsystem type  
   (name (:array :character 20))                ;  subsystem text name  
)

(def-mactype :event_table_t (find-mactype '(:pointer :event_table_entry)))

(def-mactype :subs_table_t (find-mactype '(:pointer :subs_table_entry)))

(def-mactype :etap_event_t (find-mactype ':UInt16))
(defconstant $EVENT_TABLE_NULL 0)
; #define EVENT_TABLE_NULL		((event_table_t) 0)
;  =========
;  * ETAP Time
;  * =========
;  

(%define-record :etap_time_t (find-record-descriptor ':mach_timespec))
;  =============================
;  * Cumulative buffer definitions
;  * =============================
;  
; 
;  *  The cbuff_data structure contains cumulative lock
;  *  statistical information for EITHER hold operations
;  *  OR wait operations.
;  
(defrecord cbuff_data
   (triggered :UInt32)                          ;  number of event occurances  
   (time :mach_timespec)                        ;  sum of event durations	
   (time_sq :mach_timespec)                     ;  sum of squared durations	
   (min_time :mach_timespec)                    ;  min duration of event       
   (max_time :mach_timespec)                    ;  max duration of event  	
)
; 
;  *  The cbuff_entry contains all trace data for an event.
;  *  The cumulative buffer consists of these entries.
;  
(defrecord cbuff_entry
   (event :UInt16)                              ;  event type           
   (kind :UInt16)                               ;  read,write,or simple 
   (instance :UInt32)                           ;  & of event struct    
   (hold :CBUFF_DATA)                           ;  hold trace data      
   (wait :CBUFF_DATA)                           ;  wait trace data      
   (hold_interval (:array :UInt32 10))          ;  hold interval array  
   (wait_interval (:array :UInt32 10))          ;  wait interval array  
)

(def-mactype :cbuff_entry_t (find-mactype '(:pointer :cbuff_entry)))
(defconstant $CBUFF_ENTRY_NULL 0)
; #define CBUFF_ENTRY_NULL	((cbuff_entry_t)0)
;  
;  *  The cumulative buffer maintains a header which is used by
;  *  both the kernel instrumentation and the ETAP user-utilities.
;  
(defrecord cumulative_buffer
   (next :UInt32)
                                                ;  next available entry in buffer 
   (static_start :UInt16)                       ;  first static entry in buffer   
   (entry (:array :cbuff_entry 20000))          ;  buffer entries   
)

(def-mactype :cumulative_buffer_t (find-mactype '(:pointer :cumulative_buffer)))
;  ===========================
;  * ETAP probe data definitions
;  * ===========================
;  
(defrecord etap_data_t
   (contents (:array :UInt32 4))
)
; #define ETAP_DATA_ENTRY	sizeof(unsigned int)
; #define ETAP_DATA_SIZE	ETAP_DATA_ENTRY * ETAP_MBUFF_DATASIZE
; #define ETAP_DATA_NULL	(etap_data_t*) 0
;  ==========================
;  * Monitor buffer definitions
;  * ==========================
;  
; 
;  *  The mbuff_entry structure contains trace event instance data.
;  
(defrecord mbuff_entry
   (event :UInt16)
                                                ;  event type                             
   (flags :UInt16)                              ;  event strain flags		      
   (instance :UInt32)                           ;  address of event (lock, thread, etc.)  
   (pc :UInt32)
                                                ;  program counter			      
   (time :mach_timespec)
                                                ;  operation time                         
   (data :ETAP_DATA_T)
                                                ;  event specific data  		      
)

(def-mactype :mbuff_entry_t (find-mactype '(:pointer :mbuff_entry)))
;  
;  *  Each circular monitor buffer will contain maintanence 
;  *  information and mon_entry records.
;  
(defrecord monitor_buffer
   (free :UInt32)                               ;  index of next available record 
   (timestamp :UInt32)                          ;  timestamp of last wrap around  
   (entry (:array :mbuff_entry 1))              ;  buffer entries (holder)        
)

(def-mactype :monitor_buffer_t (find-mactype '(:pointer :monitor_buffer)))
;  ===================
;  * Event strains/flags
;  * ===================
;  
;  | |t|b|e|k|u|m|s|r|w| | | | | 
;  ----------------------------- 
(defconstant $WRITE_LOCK 16)
; #define  WRITE_LOCK	0x10		/* | | | | | | | | | |1| | | | | */
(defconstant $READ_LOCK 32)
; #define  READ_LOCK	0x20		/* | | | | | | | | |1| | | | | | */
(defconstant $COMPLEX_LOCK 48)
; #define  COMPLEX_LOCK	0x30		/* | | | | | | | | |1|1| | | | | */
(defconstant $SPIN_LOCK 64)
; #define  SPIN_LOCK	0x40		/* | | | | | | | |1| | | | | | | */
(defconstant $MUTEX_LOCK 128)
; #define  MUTEX_LOCK	0x80		/* | | | | | | |1| | | | | | | | */
(defconstant $USER_EVENT 256)
; #define	 USER_EVENT	0x100		/* | | | | | |1| | | | | | | | | */
(defconstant $KERNEL_EVENT 512)
; #define  KERNEL_EVENT	0x200		/* | | | | |1| | | | | | | | | | */
(defconstant $EVENT_END 1024)
; #define  EVENT_END	0x400		/* | | | |1| | | | | | | | | | | */
(defconstant $EVENT_BEGIN 2048)
; #define  EVENT_BEGIN	0x800		/* | | |1| | | | | | | | | | | | */
(defconstant $SYSCALL_TRAP 4096)
; #define  SYSCALL_TRAP	0x1000		/* | |1| | | | | | | | | | | | | */
;  =========================
;  * Event trace status values
;  * =========================
;  
;  | | | | | | | | | | |M|M|C|C| 
;  | | | | | | | | | | |d|c|d|c| 
;  ----------------------------- 
(defconstant $CUM_CONTENTION 1)
; #define CUM_CONTENTION	0x1		/* | | | | | | | | | | | | | |1| */
(defconstant $CUM_DURATION 2)
; #define CUM_DURATION	0x2		/* | | | | | | | | | | | | |1| | */
(defconstant $MON_CONTENTION 4)
; #define MON_CONTENTION	0x4		/* | | | | | | | | | | | |1| | | */
(defconstant $MON_DURATION 8)
; #define MON_DURATION	0x8		/* | | | | | | | | | | |1| | | | */
(defconstant $ETAP_TRACE_ON 15)
; #define ETAP_TRACE_ON	0xf		/* | | | | | | | | | | |1|1|1|1| */
(defconstant $ETAP_TRACE_OFF 0)
; #define ETAP_TRACE_OFF	0x0		/* | | | | | | | | | | | | | | | */
;  ==================
;  * ETAP trace flavors
;  * ==================
;  
;  Mode 
(defconstant $ETAP_CUMULATIVE 3)
; #define ETAP_CUMULATIVE	0x3		/* | | | | | | | | | | | | |1|1| */
(defconstant $ETAP_MONITORED 12)
; #define ETAP_MONITORED	0xc		/* | | | | | | | | | | |1|1| | | */
(defconstant $ETAP_RESET 61680)
; #define ETAP_RESET   	0xf0f0
;  Type 
(defconstant $ETAP_CONTENTION 5)
; #define ETAP_CONTENTION	0x5		/* | | | | | | | | | | | |1| |1| */
(defconstant $ETAP_DURATION 10)
; #define ETAP_DURATION	0xa		/* | | | | | | | | | | |1| |1| | */
;  ===============================
;  * Buffer/Table flavor definitions
;  * ===============================
;  
(defconstant $ETAP_TABLE_EVENT 0)
; #define  ETAP_TABLE_EVENT    	 	0
(defconstant $ETAP_TABLE_SUBSYSTEM 1)
; #define  ETAP_TABLE_SUBSYSTEM  		1
(defconstant $ETAP_BUFFER_CUMULATIVE 2)
; #define  ETAP_BUFFER_CUMULATIVE       	2
(defconstant $ETAP_BUFFER_MONITORED 3)
; #define  ETAP_BUFFER_MONITORED       	3
;  ==========================
;  * ETAP function declarations
;  * ==========================
;  

(deftrap-inline "_etap_trace_event" 
   ((mode :UInt16)
    (type :UInt16)
    (enable :signed-long)
    (nargs :UInt32)
    (args (:pointer :UInt16))
   )
   :signed-long
() )

(deftrap-inline "_etap_probe" 
   ((eventno :UInt16)
    (event_id :UInt16)
    (data_size :UInt32)
    (data (:pointer :ETAP_DATA_T))
   )
   :signed-long
() )
;  =================================================================
;  * convienience user probe macro - only used if DO_PROBE is #defined
;  * =================================================================
;  
; #ifdef DO_PROBE
#| #|
#define PROBE_DATA(subsys, tag, data0, data1, data2, data3) \
	{ \
	etap_data_t _mmmm; \
	_mmmm[0] = (u_int)data0; \
	_mmmm[1] = (u_int)data1; \
	_mmmm[2] = (u_int)data2; \
	_mmmm[3] = (u_int)data3; \
	etap_probe(subsys, tag, sizeof (etap_data_t), &_mmmm); \
	}
|#
 |#

; #else
; #define PROBE_DATA(type, tag, data0, data1, data2, data3)

; #endif	/* DO_PROBE */


; #endif  /* _MACH_ETAP_H_ */


(provide-interface "etap")