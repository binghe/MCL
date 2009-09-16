(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOHITabletPointer.h"
; at Sunday July 2,2006 7:29:25 pm.
; 
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * Copyright (c) 1999-2003 Apple Computer, Inc.  All Rights Reserved.
;  * 
;  * This file contains Original Code and/or Modifications of Original Code
;  * as defined in and that are subject to the Apple Public Source License
;  * Version 2.0 (the 'License'). You may not use this file except in
;  * compliance with the License. Please obtain a copy of the License at
;  * http://www.opensource.apple.com/apsl/ and read it before using this
;  * file.
;  * 
;  * The Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
;  * Please see the License for the specific language governing rights and
;  * limitations under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; #ifndef _IOHITABLETPOINTER_H
; #define _IOHITABLETPOINTER_H

(require-interface "IOKit/hidsystem/IOHIDevice")

(require-interface "IOKit/hidsystem/IOHITablet")

(require-interface "IOKit/hidsystem/IOLLEvent")
(defconstant $kIOHITabletPointerID "PointerID")
; #define kIOHITabletPointerID			"PointerID"
(defconstant $kIOHITabletPointerDeviceID "DeviceID")
; #define kIOHITabletPointerDeviceID		"DeviceID"
(defconstant $kIOHITabletPointerVendorType "VendorPointerType")
; #define kIOHITabletPointerVendorType	"VendorPointerType"
(defconstant $kIOHITabletPointerType "PointerType")
; #define kIOHITabletPointerType			"PointerType"
(defconstant $kIOHITabletPointerSerialNumber "SerialNumber")
; #define kIOHITabletPointerSerialNumber	"SerialNumber"
(defconstant $kIOHITabletPointerUniqueID "UniqueID")
; #define kIOHITabletPointerUniqueID		"UniqueID"
#|
 confused about CLASS IOHITabletPointer #\: public IOHIDevice #\{ OSDeclareDefaultStructors #\( IOHITabletPointer #\) #\; public #\: IOHITablet * _tablet #\; UInt16 _deviceID #\; static UInt16 generateDeviceID #\( #\) #\; virtual bool init #\( OSDictionary * propTable #\) #\; virtual bool attach #\( IOService * provider #\) #\; virtual void dispatchTabletEvent #\( NXEventData * tabletEvent #\, AbsoluteTime ts #\) #\; virtual void dispatchProximityEvent #\( NXEventData * proximityEvent #\, AbsoluteTime ts #\) #\;
|#

; #endif /* !_IOHITABLETPOINTER_H */


(provide-interface "IOHITabletPointer")