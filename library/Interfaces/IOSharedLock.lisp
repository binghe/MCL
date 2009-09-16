(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOSharedLock.h"
; at Sunday July 2,2006 7:27:49 pm.
; 
;  * Copyright (c) 1998-2000 Apple Computer, Inc. All rights reserved.
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
;  * Copyright (c) 1998 Apple Computer, Inc.  All rights reserved. 
;  *
;  * HISTORY
;  *
;  
; 
;  * Multiprocessor locks used within the shared memory area between the
;  * kernel and event system.  These must work in both user and kernel mode.
;  * 
;  * These routines are public, for the purpose of writing frame buffer device
;  * drivers which handle their own cursors.  Certain architectures define a
;  * generic display class which handles cursor drawing and is subclassed by
;  * driver writers.  These drivers need not be concerned with the following
;  * types and definitions.
;  *
;  * The ev_lock(), ev_unlock(), and ev_try_lock() functions are available only
;  * to drivers built in or dynamically loaded into the kernel, and to DPS
;  * drivers built in or dynamically loaded into the Window Server.  They do not
;  * exist in any shared library.
;  *
;  * --> They're now in IOKit user lib.
;  
; #ifndef _IOKIT_IOSHAREDLOCK_H
; #define _IOKIT_IOSHAREDLOCK_H
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
;  should be 32 bytes on PPC

(def-mactype :IOSharedLockData (find-mactype ':signed-long))

(def-mactype :IOSharedLock (find-mactype '(:pointer :signed-long)))
; #define IOSpinLockInit(l)	(*(l) = (IOSharedLockData)0)
; #ifndef KERNEL

(deftrap-inline "_IOSpinLock" 
   ((l (:pointer :signed-long))
   )
   nil
() )

; #endif


(deftrap-inline "_IOSpinUnlock" 
   ((l (:pointer :signed-long))
   )
   nil
() )

(deftrap-inline "_IOTrySpinLock" 
   ((l (:pointer :signed-long))
   )
   :signed-long
() )
;  exact same stuff & implementation 

(def-mactype :ev_lock_data_t (find-mactype ':signed-long))

(def-mactype :ev_lock_t (find-mactype '(:pointer :signed-long)))
; #define ev_init_lock(l)		(*(l) = (ev_lock_data_t)0)
;  needs isync?
; #define ev_is_locked(l)	(*(l) != (ev_lock_data_t)0)
; #ifndef KERNEL

(deftrap-inline "_ev_lock" 
   ((l (:pointer :signed-long))
   )
   nil
() )
;  Spin lock!

; #endif


(deftrap-inline "_ev_unlock" 
   ((l (:pointer :signed-long))
   )
   nil
() )

(deftrap-inline "_ev_try_lock" 
   ((l (:pointer :signed-long))
   )
   :signed-long
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* ! _IOKIT_IOSHAREDLOCK_H */


(provide-interface "IOSharedLock")