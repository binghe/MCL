(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:mach_time.h"
; at Sunday July 2,2006 7:25:44 pm.
; 
;  * Copyright (c) 2001 Apple Computer, Inc. All rights reserved.
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
;  * Copyright (c) 2001 Apple Computer, Inc.  All rights reserved.
;  *
;  * HISTORY
;  *
;  * 30 January 2001 (debo)
;  *  Created.
;  
; #ifndef	_MACH_MACH_TIME_H_
; #define	_MACH_MACH_TIME_H_

(require-interface "mach/mach_types")

(deftrap-inline "_mach_wait_until" 
   ((deadline :uint64_t)
   )
   :signed-long
() )
(defrecord mach_timebase_info
   (numer :UInt32)
   (denom :UInt32)
)

(def-mactype :mach_timebase_info_t (find-mactype '(:pointer :mach_timebase_info)))

(%define-record :mach_timebase_info_data_t (find-record-descriptor ':mach_timebase_info))

(deftrap-inline "_mach_timebase_info" 
   ((info (:pointer :mach_timebase_info))
   )
   :signed-long
() )

; #endif /* _MACH_MACH_TIME_H_ */


(provide-interface "mach_time")