(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOTypes.h"
; at Sunday July 2,2006 7:24:13 pm.
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
; #ifndef	__IOKIT_IOTYPES_H
; #define __IOKIT_IOTYPES_H
; #ifndef IOKIT
(defconstant $IOKIT 1)
; #define IOKIT 1

; #endif /* !IOKIT */


; #if KERNEL
#| |#

(require-interface "IOKit/system")

#|
 |#

; #else

(require-interface "mach/message")

(require-interface "mach/vm_types")

; #endif


(require-interface "IOKit/IOReturn")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; #ifndef	NULL
; #define	NULL	0

; #endif

; 
;  * Simple data types.
;  
; #ifndef __MACTYPES__	/* CF MacTypes.h */
#| #|
#ifndef__TYPES__	

#include <libkernOSTypes.h>

#ifndef__cplusplus
#if!TYPE_BOOL
#ifdefKERNEL
typedef int	bool;
enum {
    false	= 0,
    true	= 1
};
#endif#endif#endif
#endif
#endif
|#
 |#
;  __MACTYPES__ 

(def-mactype :IOOptionBits (find-mactype ':UInt32))

(def-mactype :IOFixed (find-mactype ':SInt32))

(def-mactype :IOVersion (find-mactype ':UInt32))

(def-mactype :IOItemCount (find-mactype ':UInt32))

(def-mactype :IOCacheMode (find-mactype ':UInt32))

(def-mactype :IOByteCount (find-mactype ':UInt32))

(def-mactype :IOVirtualAddress (find-mactype ':vm_address_t))

(def-mactype :IOLogicalAddress (find-mactype ':IOVirtualAddress))

; #if 0
#| 
(%define-record :IOPhysicalAddress (find-record-descriptor ':UInt64))

(%define-record :IOPhysicalLength (find-record-descriptor ':UInt64))
; #define IOPhysical32( hi, lo )		((UInt64) lo + ((UInt64)(hi) << 32))
; #define IOPhysSize	64
 |#

; #else

(def-mactype :IOPhysicalAddress (find-mactype ':UInt32))

(def-mactype :IOPhysicalLength (find-mactype ':UInt32))
; #define IOPhysical32( hi, lo )		(lo)
(defconstant $IOPhysSize 32)
; #define IOPhysSize	32

; #endif


; #if __cplusplus
#| 
(defrecord IOVirtualRange
   (address :IOVirtualAddress)
   (length :UInt32)
)
 |#

; #else
#|
; Warning: type-size: unknown type IOVIRTUALADDRESS
|#
(defrecord IOVirtualRange
   (address :IOVirtualAddress)
   (length :UInt32)
)

; #endif

; 
;  * Map between #defined or enum'd constants and text description.
;  
(defrecord IONamedValue
   (value :signed-long)
   (name (:pointer :char))
)
; 
;  * Memory alignment -- specified as a power of two.
;  

(def-mactype :IOAlignment (find-mactype ':UInt32))
(defconstant $IO_NULL_VM_TASK 0)
; #define IO_NULL_VM_TASK		((vm_task_t)0)
; 
;  * Pull in machine specific stuff.
;  
; #include <IOKit/machine/IOTypes.h>
; #ifndef MACH_KERNEL
; #ifndef __IOKIT_PORTS_DEFINED__
; #define __IOKIT_PORTS_DEFINED__
; #ifdef KERNEL
#| #|
typedef struct OSObject * io_object_t;
|#
 |#

; #else /* KERNEL */

(def-mactype :io_object_t (find-mactype ':pointer))

; #endif /* KERNEL */


; #endif /* __IOKIT_PORTS_DEFINED__ */


(require-interface "device/device_types")

(def-mactype :io_connect_t (find-mactype ':pointer))

(def-mactype :io_iterator_t (find-mactype ':pointer))

(def-mactype :io_registry_entry_t (find-mactype ':pointer))

(def-mactype :io_service_t (find-mactype ':pointer))

(def-mactype :io_enumerator_t (find-mactype ':pointer))

; #endif /* MACH_KERNEL */

;  IOConnectMapMemory memoryTypes

(defconstant $kIODefaultMemoryType 0)

(defconstant $kIODefaultCache 0)
(defconstant $kIOInhibitCache 1)
(defconstant $kIOWriteThruCache 2)
(defconstant $kIOCopybackCache 3)
(defconstant $kIOWriteCombineCache 4)
;  IOMemory mapping options

(defconstant $kIOMapAnywhere 1)
(defconstant $kIOMapCacheMask #x700)
(defconstant $kIOMapCacheShift 8)
(defconstant $kIOMapDefaultCache 0)
(defconstant $kIOMapInhibitCache #x100)
(defconstant $kIOMapWriteThruCache #x200)
(defconstant $kIOMapCopybackCache #x300)
(defconstant $kIOMapWriteCombineCache #x400)
(defconstant $kIOMapUserOptionsMask #xFFF)
(defconstant $kIOMapReadOnly #x1000)
(defconstant $kIOMapStatic #x1000000)
(defconstant $kIOMapReference #x2000000)
; ! @enum Scale Factors
;     @discussion Used when a scale_factor parameter is required to define a unit of time.
;     @constant kNanosecondScale Scale factor for nanosecond based times.
;     @constant kMicrosecondScale Scale factor for microsecond based times.
;     @constant kMillisecondScale Scale factor for millisecond based times.
;     @constant kSecondScale Scale factor for second based times. 

(defconstant $kNanosecondScale 1)
(defconstant $kMicrosecondScale #x3E8)
(defconstant $kMillisecondScale #xF4240)
(defconstant $kSecondScale #x3B9ACA00)
;  compatibility types 
; #ifndef KERNEL
; 
;  * Machine-independent caching specification.
;  

(defconstant $IO_CacheOff 0)                    ;  cache inhibit

(defconstant $IO_WriteThrough 1)
(defconstant $IO_CopyBack 2)
(def-mactype :IOCache (find-mactype ':SINT32))
; typedef char OSString[64];

(def-mactype :IODeviceNumber (find-mactype ':UInt32))

(def-mactype :IOObjectNumber (find-mactype ':UInt32))

; #endif

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* ! __IOKIT_IOTYPES_H */


(provide-interface "IOTypes")