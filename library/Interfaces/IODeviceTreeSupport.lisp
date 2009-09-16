(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IODeviceTreeSupport.h"
; at Sunday July 2,2006 7:28:47 pm.
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
; #ifndef _IOKIT_IODEVICETREE_H
; #define _IOKIT_IODEVICETREE_H

(require-interface "IOKit/IORegistryEntry")

(require-interface "libkern/c++/OSData")

#|class IODeviceMemory;
|#

#|class IOService;
|#
(def-mactype :gIODTPlane (find-mactype '(:pointer :IORegistryPlane)))
(def-mactype :gIODTCompatibleKey (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIODTTypeKey (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIODTModelKey (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIODTAAPLInterruptsKey (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIODTDefaultInterruptController (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIODTNWInterruptMappingKey (find-mactype '(:pointer :OSSymbol)))

(deftrap-inline "_IODTMatchNubWithKeys" 
   ((nub (:pointer :IORegistryEntry))
    (keys (:pointer :char))
   )
   :Boolean
() )

(deftrap-inline "_IODTCompareNubName" 
   ((regEntry (:pointer :IORegistryEntry))
    (name (:pointer :osstring))
    (matchingName (:pointer :osstring))
   )
   :Boolean
() )

(defconstant $kIODTRecursive 1)
(defconstant $kIODTExclusive 2)

(deftrap-inline "_IODTFindMatchingEntries" 
   ((from (:pointer :IORegistryEntry))
    (options :UInt32)
    (keys (:pointer :char))
   )
   (:pointer :OSCollectionIterator)
() )

(def-mactype :IODTCompareAddressCellFunc (find-mactype ':pointer)); (UInt32 cellCount , UInt32 left [ ] , UInt32 right [ ])

(def-mactype :IODTNVLocationFunc (find-mactype ':pointer)); (IORegistryEntry * entry , UInt8 * busNum , UInt8 * deviceNum , UInt8 * functionNum)

(deftrap-inline "_IODTSetResolving" 
   ((regEntry (:pointer :IORegistryEntry))
    (compareFunc :pointer)
    (locationFunc :pointer)
   )
   :void
() )

(deftrap-inline "_IODTResolveAddressCell" 
   ((regEntry (:pointer :IORegistryEntry))
    (cellsIn (:pointer :UInt32))
    (phys (:pointer :IOPHYSICALADDRESS))
    (len (:pointer :IOPHYSICALLENGTH))
   )
   :Boolean
() )
#|
 confused about OSARRAY const char * addressPropertyName #\, IODeviceMemory * parent #\)
|#
; #pragma options align=mac68k
(defrecord IONVRAMDescriptor
   (format :UInt32)
   (marker :UInt32)
   (bridgeCount :UInt32)
   (busNum :UInt32)
   (bridgeDevices :UInt32)
   (functionNum :UInt32)
   (deviceNum :UInt32)
)
; #pragma options align=reset

(deftrap-inline "_IODTMakeNVDescriptor" 
   ((regEntry (:pointer :IORegistryEntry))
    (hdr (:pointer :IONVRAMDESCRIPTOR))
   )
   :signed-long
() )

(deftrap-inline "_IODTInterruptControllerName" 
   ((regEntry (:pointer :IORegistryEntry))
   )
   (:pointer :ossymbol)
() )

(deftrap-inline "_IODTMapInterrupts" 
   ((regEntry (:pointer :IORegistryEntry))
   )
   :Boolean
() )
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(deftrap-inline "_IONDRVLibrariesInitialize" 
   ((provider (:pointer :ioservice))
   )
   :signed-long
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _IOKIT_IODEVICETREE_H */


(provide-interface "IODeviceTreeSupport")