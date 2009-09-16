(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:thread_call.h"
; at Sunday July 2,2006 7:26:36 pm.
; 
;  * Copyright (c) 1993-1995, 1999-2000 Apple Computer, Inc.
;  * All rights reserved.
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
;  * Declarations for thread-based callouts.
;  *
;  * HISTORY
;  *
;  * 10 July 1999 (debo)
;  *  Pulled into Mac OS X (microkernel).
;  *
;  * 3 July 1993 (debo)
;  *	Created.
;  
; #ifndef _KERN_THREAD_CALL_H_
; #define _KERN_THREAD_CALL_H_

(require-interface "sys/appleapiopts")

(require-interface "mach/mach_types")

(require-interface "kern/clock")

(def-mactype :thread_call_t (find-mactype '(:pointer :call_entry)))

(def-mactype :thread_call_param_t (find-mactype '(:pointer :void)))

(def-mactype :thread_call_func_t (find-mactype ':pointer)); (thread_call_param_t param0 , thread_call_param_t param1)

(deftrap-inline "_thread_call_enter" 
   ((call (:pointer :call_entry))
   )
   :signed-long
() )

(deftrap-inline "_thread_call_enter1" 
   ((call (:pointer :call_entry))
    (param1 (:pointer :void))
   )
   :signed-long
() )

(deftrap-inline "_thread_call_enter_delayed" 
   ((call (:pointer :call_entry))
    (deadline :uint64_t)
   )
   :signed-long
() )

(deftrap-inline "_thread_call_enter1_delayed" 
   ((call (:pointer :call_entry))
    (param1 (:pointer :void))
    (deadline :uint64_t)
   )
   :signed-long
() )

(deftrap-inline "_thread_call_cancel" 
   ((call (:pointer :call_entry))
   )
   :signed-long
() )

(deftrap-inline "_thread_call_is_delayed" 
   ((call (:pointer :call_entry))
    (deadline (:pointer :uint64_t))
   )
   :signed-long
() )

(deftrap-inline "_thread_call_allocate" 
   ((func :pointer)
    (param0 (:pointer :void))
   )
   (:pointer :call_entry)
() )

(deftrap-inline "_thread_call_free" 
   ((call (:pointer :call_entry))
   )
   :signed-long
() )
; #ifdef	__APPLE_API_PRIVATE
#| #|

#ifdef__APPLE_API_OBSOLETE



void
thread_call_func(
	thread_call_func_t		func,
	thread_call_param_t		param,
	boolean_t				unique_call
);
void
thread_call_func_delayed(
	thread_call_func_t		func,
	thread_call_param_t		param,
	uint64_t				deadline
);

boolean_t
thread_call_func_cancel(
	thread_call_func_t		func,
	thread_call_param_t		param,
	boolean_t				cancel_all
);



#endif

#ifdefMACH_KERNEL_PRIVATE
#include <kerncall_entry.h>

typedef struct call_entry	thread_call_data_t;

void
thread_call_initialize(void);

void
thread_call_setup(
	thread_call_t			call,
	thread_call_func_t		func,
	thread_call_param_t		param0
);

void
call_thread_block(void),
call_thread_unblock(void);

#endif

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #if		!defined(MACH_KERNEL_PRIVATE) && !defined(ABSOLUTETIME_SCALAR_TYPE)

(require-interface "libkern/OSBase")
; #define thread_call_enter_delayed(a, b)		thread_call_enter_delayed((a), __OSAbsoluteTime(b))
; #define thread_call_enter1_delayed(a, b, c)		thread_call_enter1_delayed((a), (b), __OSAbsoluteTime(c))
; #define thread_call_is_delayed(a, b)		thread_call_is_delayed((a), __OSAbsoluteTimePtr(b))
; #define thread_call_func_delayed(a, b, c)		thread_call_func_delayed((a), (b), __OSAbsoluteTime(c))

; #endif


; #endif /* _KERN_THREAD_CALL_H_ */


(provide-interface "thread_call")