(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOCFUnserialize.h"
; at Sunday July 2,2006 7:28:42 pm.
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
;  IOUnserialize.h created by rsulack on Mon 23-Nov-1998 
;  IOCFUnserialize.h creates CF collections Mon 30-Aug-1999 
; #ifndef __IOKIT_IOCFUNSERIALIZE_H
; #define __IOKIT_IOCFUNSERIALIZE_H

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFString")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
;  on success IOCFUnserialize sets errorString to 0 and returns
;  the unserialized object.
;  on failure IOCFUnserialize sets errorString to a CFString object 
;  containing a error message suitable for logging and returns 0

(deftrap-inline "_IOCFUnserialize" 
   ((buffer (:pointer :char))
    (allocator (:pointer :__CFAllocator))
    (options :UInt32)
    (errorString (:pointer :CFStringRef))
   )
   (:pointer :void)
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* __IOKIT_IOCFUNSERIALIZE_H */


(provide-interface "IOCFUnserialize")