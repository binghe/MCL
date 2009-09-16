(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOACPITypes.h"
; at Sunday July 2,2006 7:28:15 pm.
; 
;  * Copyright (c) 2003 Apple Computer, Inc. All rights reserved.
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
; #ifndef __IOKIT_IOACPITYPES_H
; #define __IOKIT_IOACPITYPES_H

(require-interface "IOKit/IOMessage")
(def-mactype :gIOACPIPlane (find-mactype '(:pointer :IORegistryPlane)))
(def-mactype :gIOACPIHardwareIDKey (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIOACPIUniqueIDKey (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIOACPIAddressKey (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIOACPIDeviceStatusKey (find-mactype '(:pointer :OSSymbol)))
; #pragma pack(1)
(defrecord IOACPIAddressSpaceDescriptor
   (resourceType :UInt32)
   (generalFlags :UInt32)
   (typeSpecificFlags :UInt32)
   (reserved1 :UInt32)
   (granularity :uint64)
   (minAddressRange :uint64)
   (maxAddressRange :uint64)
   (translationOffset :uint64)
   (addressLength :uint64)
   (reserved2 :uint64)
   (reserved3 :uint64)
   (reserved4 :uint64)
)

(defconstant $kIOACPIMemoryRange 0)
(defconstant $kIOACPIIORange 1)
(defconstant $kIOACPIBusNumberRange 2)

(def-mactype :IOACPIAddressSpaceID (find-mactype ':UInt32))

(defconstant $kIOACPIAddressSpaceIDSystemMemory 0)
(defconstant $kIOACPIAddressSpaceIDSystemIO 1)
(defconstant $kIOACPIAddressSpaceIDPCIConfiguration 2)
(defconstant $kIOACPIAddressSpaceIDEmbeddedController 3)
(defconstant $kIOACPIAddressSpaceIDSMBus 4)
;  Address space operations.

(defconstant $kIOACPIAddressSpaceOpRead 0)
(defconstant $kIOACPIAddressSpaceOpWrite 1)
;  64-bit ACPI address.
(defrecord IOACPIAddress
   (:variant
   (
   (addr64 :uint64)
   )
   (
   (offset :UInt16)
   (function :UInt16)
   (device :UInt16)
   (bus :UInt8)
   (reserved :UInt8)
   )
   )
)
;  Address space handler.

(def-mactype :IOACPIAddressSpaceHandler (find-mactype ':pointer)); (UInt32 operation , IOACPIAddress address , UInt64 * value , UInt32 bitWidth , UInt32 bitOffset , void * context)
;  Fixed ACPI event types.

(defconstant $kIOACPIFixedEventPMTimer 0)
(defconstant $kIOACPIFixedEventPowerButton 2)
(defconstant $kIOACPIFixedEventSleepButton 3)
(defconstant $kIOACPIFixedEventRealTimeClock 4)
; #pragma pack()
; 
;  * FIXME: Move to xnu/iokit to reserve the ACPI family code.
;  
; #ifndef sub_iokit_acpi
; #define sub_iokit_acpi   err_sub(10)

; #endif

; 
;  * ACPI notify message sent to all clients and interested parties.
;  * The notify code can be read from the argument as an UInt32.
;  
; #define kIOACPIMessageDeviceNotification  iokit_family_msg(sub_iokit_acpi, 0x10)
;  ACPI device power states.

(defconstant $kIOACPIDevicePowerStateD0 0)
(defconstant $kIOACPIDevicePowerStateD1 1)
(defconstant $kIOACPIDevicePowerStateD2 2)
(defconstant $kIOACPIDevicePowerStateD3 3)
(defconstant $kIOACPIDevicePowerStateCount 4)

; #endif /* !__IOKIT_IOACPITYPES_H */


(provide-interface "IOACPITypes")