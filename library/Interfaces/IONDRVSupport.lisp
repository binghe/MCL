(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IONDRVSupport.h"
; at Sunday July 2,2006 7:29:32 pm.
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
; #ifndef __IONDRVSUPPORT__
; #define __IONDRVSUPPORT__

(require-interface "libkern/OSTypes")
; #pragma options align=mac68k
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
(defconstant $kIONDRVIgnoreKey "AAPL,iokit-ignore-ndrv")
; #define kIONDRVIgnoreKey	"AAPL,iokit-ignore-ndrv"
(defconstant $kIONDRVForXKey "AAPL,iokit-ndrv")
; #define kIONDRVForXKey		"AAPL,iokit-ndrv"
(defrecord IOTVector
   (pc :pointer)
   (toc :UInt32)
)

;type name? (%define-record :IOTVector (find-record-descriptor ':IOTVector))
(defrecord IONDRVInterruptSetMember
   (setID :pointer)
   (member :UInt32)
)

;type name? (%define-record :IONDRVInterruptSetMember (find-record-descriptor ':IONDRVInterruptSetMember))

(def-mactype :IONDRVInterruptHandler (find-mactype ':pointer)); (IONDRVInterruptSetMember setMember , void * refCon , UInt32 theIntCount)

(def-mactype :IONDRVInterruptEnabler (find-mactype ':pointer)); (IONDRVInterruptSetMember setMember , void * refCon)

(def-mactype :IONDRVInterruptDisabler (find-mactype ':pointer)); (IONDRVInterruptSetMember setMember , void * refCon)

(defconstant $kIONDRVFirstMemberNumber 1)
(defconstant $kIONDRVIsrIsComplete 0)
(defconstant $kIONDRVIsrIsNotComplete -1)
(defconstant $kIONDRVMemberNumberParent -2)

(defconstant $kIONDRVReturnToParentWhenComplete 1)
(defconstant $kIONDRVReturnToParentWhenNotComplete 2)

(defconstant $kIONDRVISTChipInterruptSource 0)
(defconstant $kIONDRVISTOutputDMAInterruptSource 1)
(defconstant $kIONDRVISTInputDMAInterruptSource 2)
(defconstant $kIONDRVISTPropertyMemberCount 3)
(defconstant $kIONDRVISTPropertyName "driver-ist")
; #define kIONDRVISTPropertyName	"driver-ist" 

(deftrap-inline "_IONDRVInstallInterruptFunctions" 
   ((setID :pointer)
    (member :UInt32)
    (refCon :pointer)
    (handler (:pointer :IOTVector))
    (enabler (:pointer :IOTVector))
    (disabler (:pointer :IOTVector))
   )
   :signed-long
() )

(def-mactype :IONDRVUndefinedSymbolHandler (find-mactype ':pointer)); (void * self , const char * libraryName , const char * symbolName)
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __IONDRVSUPPORT__ */


(provide-interface "IONDRVSupport")