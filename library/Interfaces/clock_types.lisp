(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:clock_types.h"
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
;  * @OSF_COPYRIGHT@
;  
; 
;  *	File:		clock_types.h
;  *	Purpose:	Clock facility header definitions. These
;  *				definitons are needed by both kernel and
;  *				user-level software.
;  
; 
;  * N.B. This interface has been deprecated and the contents
;  * of this file should be considered obsolete.
;  
; #ifndef	_MACH_CLOCK_TYPES_H_
; #define	_MACH_CLOCK_TYPES_H_

(require-interface "mach/time_value")

(require-interface "sys/appleapiopts")
; 
;  * Type definitions.
;  

(def-mactype :alarm_type_t (find-mactype ':signed-long))
;  alarm time type 

(def-mactype :sleep_type_t (find-mactype ':signed-long))
;  sleep time type 

(def-mactype :clock_id_t (find-mactype ':signed-long))
;  clock identification type 

(def-mactype :clock_flavor_t (find-mactype ':signed-long))
;  clock flavor type 

(def-mactype :clock_attr_t (find-mactype '(:pointer :signed-long)))
;  clock attribute type 

(def-mactype :clock_res_t (find-mactype ':signed-long))
;  clock resolution type 
; 
;  * Normal time specification used by the kernel clock facility.
;  
(defrecord mach_timespec
   (tv_sec :UInt32)
                                                ;  seconds 
   (tv_nsec :signed-long)
                                                ;  nanoseconds 
)

(%define-record :mach_timespec_t (find-record-descriptor ':mach_timespec))
; #ifdef	__APPLE_API_UNSTABLE
#| #|


#define SYSTEM_CLOCK		0	
#define CALENDAR_CLOCK		1	

#define REALTIME_CLOCK		0	


#define CLOCK_GET_TIME_RES	1	

#define CLOCK_ALARM_CURRES	3	
#define CLOCK_ALARM_MINRES	4	
#define CLOCK_ALARM_MAXRES	5	

#define NSEC_PER_USEC	1000		
#define USEC_PER_SEC	1000000		
#define NSEC_PER_SEC	1000000000	

#define BAD_MACH_TIMESPEC(t)						\
	((t)->tv_nsec < 0 || (t)->tv_nsec >= NSEC_PER_SEC)


#define CMP_MACH_TIMESPEC(t1, t2)					\
	((t1)->tv_sec > (t2)->tv_sec ? +NSEC_PER_SEC :	\
	((t1)->tv_sec < (t2)->tv_sec ? -NSEC_PER_SEC :	\
			(t1)->tv_nsec - (t2)->tv_nsec))


#define ADD_MACH_TIMESPEC(t1, t2)								\
  do {															\
	if (((t1)->tv_nsec += (t2)->tv_nsec) >= NSEC_PER_SEC) {		\
		(t1)->tv_nsec -= NSEC_PER_SEC;							\
		(t1)->tv_sec  += 1;										\
	}															\
	(t1)->tv_sec += (t2)->tv_sec;								\
  } while (0)


#define SUB_MACH_TIMESPEC(t1, t2)								\
  do {															\
	if (((t1)->tv_nsec -= (t2)->tv_nsec) < 0) {					\
		(t1)->tv_nsec += NSEC_PER_SEC;							\
		(t1)->tv_sec  -= 1;										\
	}															\
	(t1)->tv_sec -= (t2)->tv_sec;								\
  } while (0)


#define ALRMTYPE			0xff		
#define TIME_ABSOLUTE		0x00		
#define TIME_RELATIVE		0x01		

#define BAD_ALRMTYPE(t)		(((t) &~ TIME_RELATIVE) != 0)

#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif /* _MACH_CLOCK_TYPES_H_ */


(provide-interface "clock_types")