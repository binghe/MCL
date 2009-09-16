(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:clock.h"
; at Sunday July 2,2006 7:25:43 pm.
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
;  *	File:		kern/clock.h
;  *	Purpose:	Data structures for the kernel alarm clock
;  *			facility. This file is used only by kernel
;  *			level clock facility routines.
;  
; #ifndef	_KERN_CLOCK_H_
; #define	_KERN_CLOCK_H_

(require-interface "mach/message")

(require-interface "mach/clock_types")

(require-interface "mach/mach_time")

(require-interface "sys/appleapiopts")
; #ifdef	__APPLE_API_PRIVATE
#| #|

#ifdefMACH_KERNEL_PRIVATE

#include <ipcipc_port.h>


struct	alarm {
	struct	alarm	*al_next;		
	struct	alarm	*al_prev;		
	int				al_status;		
	mach_timespec_t	al_time;		
	struct {				
		int				type;		
		ipc_port_t		port;		
		mach_msg_type_name_t
						port_type;	
		struct	clock	*clock;		
		void			*data;		
	} al_alrm;
#define al_type		al_alrm.type
#define al_port		al_alrm.port
#define al_port_type	al_alrm.port_type
#define al_clock	al_alrm.clock
#define al_data		al_alrm.data
	long			al_seqno;		
};
typedef struct alarm	alarm_data_t;


#define ALARM_FREE	0		
#define ALARM_SLEEP	1		
#define ALARM_CLOCK	2		
#define ALARM_DONE	4		


struct	clock_ops {
	int		(*c_config)(void);		

	int		(*c_init)(void);		

	kern_return_t	(*c_gettime)(	
				mach_timespec_t			*cur_time);

	kern_return_t	(*c_settime)(	
				mach_timespec_t			*clock_time);

	kern_return_t	(*c_getattr)(	
				clock_flavor_t			flavor,
				clock_attr_t			attr,
				mach_msg_type_number_t	*count);

	kern_return_t	(*c_setattr)(	
				clock_flavor_t			flavor,
				clock_attr_t			attr,
				mach_msg_type_number_t	count);

	void		(*c_setalrm)(		
				mach_timespec_t			*alarm_time);
};
typedef struct clock_ops	*clock_ops_t;
typedef struct clock_ops	clock_ops_data_t;


struct	clock {
	clock_ops_t			cl_ops;			
	struct ipc_port		*cl_service;	
	struct ipc_port		*cl_control;	
	struct	{							
		struct alarm 	*al_next;
	} cl_alarm;
};
typedef struct clock		clock_data_t;


extern void		clock_config(void);


extern void		clock_init(void);

extern void		clock_timebase_init(void);


extern void		clock_service_create(void);


extern void		clock_alarm_intr(
					clock_id_t		clock_id,
					mach_timespec_t	*clock_time);

extern kern_return_t	clock_sleep_internal(
							clock_t			clock,
							sleep_type_t	sleep_type,
							mach_timespec_t	*sleep_time);

typedef void		(*clock_timer_func_t)(
						uint64_t			timestamp);

extern void			clock_set_timer_func(
						clock_timer_func_t	func);

extern void			clock_set_timer_deadline(
						uint64_t			deadline);

extern void			mk_timebase_info(
						uint32_t			*delta,
						uint32_t			*abs_to_ns_numer,
						uint32_t			*abs_to_ns_denom,
						uint32_t			*proc_to_abs_numer,
						uint32_t			*proc_to_abs_denom);

extern uint32_t		clock_set_calendar_adjtime(
						int32_t				*secs,
						int32_t				*microsecs);

extern uint32_t		clock_adjust_calendar(void);

#endif

extern void			clock_get_calendar_microtime(
						uint32_t			*secs,
						uint32_t			*microsecs);

extern void			clock_get_calendar_nanotime(
						uint32_t			*secs,
						uint32_t			*nanosecs);

extern void			clock_set_calendar_microtime(
						uint32_t			secs,
						uint32_t			microsecs);

extern void			clock_get_system_microtime(
						uint32_t			*secs,
						uint32_t			*microsecs);

extern void			clock_get_system_nanotime(
						uint32_t			*secs,
						uint32_t			*nanosecs);

extern void			clock_adjtime(
						int32_t		*secs,
						int32_t		*microsecs);

extern void			clock_initialize_calendar(void);

extern void			clock_wakeup_calendar(void);

extern void			clock_gettimeofday(
                        uint32_t			*secs,
                        uint32_t			*microsecs);

#endif
|#
 |#
;  __APPLE_API_PRIVATE 
; #ifdef	__APPLE_API_UNSTABLE
#| #|

#define MACH_TIMESPEC_SEC_MAX		(0 - 1)
#define MACH_TIMESPEC_NSEC_MAX		(NSEC_PER_SEC - 1)

#define MACH_TIMESPEC_MAX	((mach_timespec_t) {				\
									MACH_TIMESPEC_SEC_MAX,		\
									MACH_TIMESPEC_NSEC_MAX } )
#define MACH_TIMESPEC_ZERO	((mach_timespec_t) { 0, 0 } )

#define ADD_MACH_TIMESPEC_NSEC(t1, nsec)		\
  do {											\
	(t1)->tv_nsec += (clock_res_t)(nsec);		\
	if ((clock_res_t)(nsec) > 0 &&				\
			(t1)->tv_nsec >= NSEC_PER_SEC) {	\
		(t1)->tv_nsec -= NSEC_PER_SEC;			\
		(t1)->tv_sec += 1;						\
	}											\
	else if ((clock_res_t)(nsec) < 0 &&			\
				 (t1)->tv_nsec < 0) {			\
		(t1)->tv_nsec += NSEC_PER_SEC;			\
		(t1)->tv_sec -= 1;						\
	}											\
  } while (0)

#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

(deftrap-inline "_clock_get_system_value" 
   ((returnArg (:pointer :mach_timespec))
    
   )
   nil
() )

(deftrap-inline "_clock_get_calendar_value" 
   ((returnArg (:pointer :mach_timespec))
    
   )
   nil
() )

(deftrap-inline "_clock_timebase_info" 
   ((info (:pointer :mach_timebase_info))
   )
   nil
() )

(deftrap-inline "_clock_get_uptime" 
   ((result (:pointer :uint64_t))
   )
   nil
() )

(deftrap-inline "_clock_interval_to_deadline" 
   ((interval :UInt32)
    (scale_factor :UInt32)
    (result (:pointer :uint64_t))
   )
   nil
() )

(deftrap-inline "_clock_interval_to_absolutetime_interval" 
   ((interval :UInt32)
    (scale_factor :UInt32)
    (result (:pointer :uint64_t))
   )
   nil
() )

(deftrap-inline "_clock_absolutetime_interval_to_deadline" 
   ((abstime :uint64_t)
    (result (:pointer :uint64_t))
   )
   nil
() )

(deftrap-inline "_clock_deadline_for_periodic_event" 
   ((interval :uint64_t)
    (abstime :uint64_t)
    (deadline (:pointer :uint64_t))
   )
   nil
() )

(deftrap-inline "_clock_delay_for_interval" 
   ((interval :UInt32)
    (scale_factor :UInt32)
   )
   nil
() )

(deftrap-inline "_clock_delay_until" 
   ((deadline :uint64_t)
   )
   nil
() )

(deftrap-inline "_absolutetime_to_nanoseconds" 
   ((abstime :uint64_t)
    (result (:pointer :uint64_t))
   )
   nil
() )

(deftrap-inline "_nanoseconds_to_absolutetime" 
   ((nanoseconds :uint64_t)
    (result (:pointer :uint64_t))
   )
   nil
() )

; #if		!defined(MACH_KERNEL_PRIVATE) && !defined(ABSOLUTETIME_SCALAR_TYPE)

(require-interface "libkern/OSBase")
; #define clock_get_uptime(a)			clock_get_uptime(__OSAbsoluteTimePtr(a))
; #define clock_interval_to_deadline(a, b, c)			clock_interval_to_deadline((a), (b), __OSAbsoluteTimePtr(c))
; #define clock_interval_to_absolutetime_interval(a, b, c)		clock_interval_to_absolutetime_interval((a), (b), __OSAbsoluteTimePtr(c))
; #define clock_absolutetime_interval_to_deadline(a, b)		clock_absolutetime_interval_to_deadline(__OSAbsoluteTime(a), __OSAbsoluteTimePtr(b))
; #define clock_deadline_for_periodic_event(a, b, c)		clock_deadline_for_periodic_event(__OSAbsoluteTime(a), __OSAbsoluteTime(b), __OSAbsoluteTimePtr(c))
; #define clock_delay_until(a)		clock_delay_until(__OSAbsoluteTime(a))
; #define absolutetime_to_nanoseconds(a, b)		absolutetime_to_nanoseconds(__OSAbsoluteTime(a), (b))
; #define nanoseconds_to_absolutetime(a, b)		nanoseconds_to_absolutetime((a), __OSAbsoluteTimePtr(b))
; #define AbsoluteTime_to_scalar(x)	(*(uint64_t *)(x))
;  t1 < = > t2 
; #define CMP_ABSOLUTETIME(t1, t2)					(AbsoluteTime_to_scalar(t1) >						AbsoluteTime_to_scalar(t2)? (int)+1 :		 (AbsoluteTime_to_scalar(t1) <						AbsoluteTime_to_scalar(t2)? (int)-1 : 0))
;  t1 += t2 
; #define ADD_ABSOLUTETIME(t1, t2)					(AbsoluteTime_to_scalar(t1) +=								AbsoluteTime_to_scalar(t2))
;  t1 -= t2 
; #define SUB_ABSOLUTETIME(t1, t2)					(AbsoluteTime_to_scalar(t1) -=								AbsoluteTime_to_scalar(t2))
; #define ADD_ABSOLUTETIME_TICKS(t1, ticks)			(AbsoluteTime_to_scalar(t1) +=										(int32_t)(ticks))

; #endif


; #endif	/* _KERN_CLOCK_H_ */


(provide-interface "clock")