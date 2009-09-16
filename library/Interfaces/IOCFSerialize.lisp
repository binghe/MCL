(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOCFSerialize.h"
; at Sunday July 2,2006 7:28:42 pm.
; 
;  * Copyright (c) 1999-2000 Apple Computer, Inc. All rights reserved.
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
;  * HISTORY
;  *
;  
;  IOCFSerialize serializes CFObjects to a format suitable for passing
;  * to the kernel. 
; #ifndef __IOKIT_IOCFSERIALIZE_H
; #define __IOKIT_IOCFSERIALIZE_H

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFData")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(defconstant $kIOCFSerializeToBinary 1)

(deftrap-inline "_IOCFSerialize" 
   ((object (:pointer :void))
    (options :UInt32)
   )
   (:pointer :__CFData)
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* __IOKIT_IOCFSERIALIZE_H */


(provide-interface "IOCFSerialize")