(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:USBSpec.h"
; at Sunday July 2,2006 7:30:04 pm.
; 
;  * Copyright (c) 1998-2003 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
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
; #ifndef __OPEN_SOURCE__
; 
;  *
;  *	$Id: USBSpec.h,v 1.15 2003/08/20 19:41:41 nano Exp $
;  *
;  *	$Log: USBSpec.h,v $
;  *	Revision 1.15  2003/08/20 19:41:41  nano
;  *	
;  *	Bug #:
;  *	New version's of Nima's USB Prober (2.2b17)
;  *	3382540  Panther: Ejecting a USB CardBus card can freeze a machine
;  *	3358482  Device Busy message with Modems and IOUSBFamily 201.2.14 after sleep
;  *	3385948  Need to implement device recovery on High Speed Transaction errors to full speed devices
;  *	3377037  USB EHCI: returnTransactions can cause unstable queue if transactions are aborted
;  *	
;  *	Also, updated most files to use the id/log functions of cvs
;  *	
;  *	Submitted by: nano
;  *	Reviewed by: rhoads/barryt/nano
;  *	
;  

; #endif

; 
;  * Constants that both OS9 and OSX want to define, and whose values are
;  * specified by the USB Standard.
;  * Put in a seperate file so they can be included if the OS9 include file isn't already
;  * included.
;  
; #ifndef _USBSPEC_H
; #define _USBSPEC_H
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; !
;     @header     USBSpec.h
;      @abstract  Constants and definitions of parameters that are used in communcating with USB devices and interfaces.
;      @discussion    
;      
; !
;     @enum Endpoint type
;     @discussion Used in IOUSBFindEndpointRequest's type field
;     

(defconstant $kUSBControl 0)
(defconstant $kUSBIsoc 1)
(defconstant $kUSBBulk 2)
(defconstant $kUSBInterrupt 3)
(defconstant $kUSBAnyType #xFF)
; !
;     @enum Endpoint direction
;     @discussion Used in IOUSBFindEndpointRequest's direction field
;     

(defconstant $kUSBOut 0)
(defconstant $kUSBIn 1)
(defconstant $kUSBNone 2)
(defconstant $kUSBAnyDirn 3)
; !
;     @enum Device Request Type
;     @discussion This type is encoded in the bmRequestType field of a Device Request.  It specifies the type of request: standard, class or vendor specific.
;     

(defconstant $kUSBStandard 0)
(defconstant $kUSBClass 1)
(defconstant $kUSBVendor 2)
; !
;     @enum Device Request Recipient
;     @discussion This recipient is encoded in the bmRequestType field of a Device Request.  It specifies the type of recipient for a request:  the device, the interface, or an endpoint.
;     

(defconstant $kUSBDevice 0)
(defconstant $kUSBInterface 1)
(defconstant $kUSBEndpoint 2)
(defconstant $kUSBOther 3)
; !
;     @enum Device Request
;     @discussion Specifies values for the bRequest field of a Device Request.
;     

(defconstant $kUSBRqGetStatus 0)
(defconstant $kUSBRqClearFeature 1)
(defconstant $kUSBRqGetState 2)
(defconstant $kUSBRqSetFeature 3)
(defconstant $kUSBRqReserved2 4)
(defconstant $kUSBRqSetAddress 5)
(defconstant $kUSBRqGetDescriptor 6)
(defconstant $kUSBRqSetDescriptor 7)
(defconstant $kUSBRqGetConfig 8)
(defconstant $kUSBRqSetConfig 9)
(defconstant $kUSBRqGetInterface 10)
(defconstant $kUSBRqSetInterface 11)
(defconstant $kUSBRqSyncFrame 12)
; !
;     @enum USB Descriptors
;     @discussion Specifies values for diffent descriptor types.
;     

(defconstant $kUSBAnyDesc 0)                    ;  Wildcard for searches

(defconstant $kUSBDeviceDesc 1)
(defconstant $kUSBConfDesc 2)
(defconstant $kUSBStringDesc 3)
(defconstant $kUSBInterfaceDesc 4)
(defconstant $kUSBEndpointDesc 5)
(defconstant $kUSBDeviceQualifierDesc 6)
(defconstant $kUSBOtherSpeedConfDesc 7)
(defconstant $kUSBInterfacePowerDesc 8)
(defconstant $kUSBOnTheGoDesc 9)
(defconstant $kUSDebugDesc 10)
(defconstant $kUSBInterfaceAssociationDesc 11)
(defconstant $kUSBHIDDesc 33)
(defconstant $kUSBReportDesc 34)
(defconstant $kUSBPhysicalDesc 35)
(defconstant $kUSBHUBDesc 41)
; !
;     @enum Feature Selectors
;     @discussion Used with SET/CLEAR_FEATURE requests.
;     

(defconstant $kUSBFeatureEndpointStall 0)
(defconstant $kUSBFeatureDeviceRemoteWakeup 1)
; !
;     @enum USB Power constants
;     @discussion Constants relating to USB Power.
;     

(defconstant $kUSB100mAAvailable 50)
(defconstant $kUSB500mAAvailable #xFA)
(defconstant $kUSB100mA 50)
(defconstant $kUSBAtrBusPowered #x80)
(defconstant $kUSBAtrSelfPowered 64)
(defconstant $kUSBAtrRemoteWakeup 32)
; !
;     @enum USB Release constants
;     @discussion Constants relating to USB releases as found in the bcdUSB field of the Device Descriptor.
;     

(defconstant $kUSBRel10 #x100)
(defconstant $kUSBRel11 #x110)
(defconstant $kUSBRel20 #x200)
; !
;     @enum HID requests
;     @discussion Constants for HID requests.
;     

(defconstant $kHIDRqGetReport 1)
(defconstant $kHIDRqGetIdle 2)
(defconstant $kHIDRqGetProtocol 3)
(defconstant $kHIDRqSetReport 9)
(defconstant $kHIDRqSetIdle 10)
(defconstant $kHIDRqSetProtocol 11)
; !
;     @enum HID report types
;     @discussion Constants for the three kinds of HID reports.
;     

(defconstant $kHIDRtInputReport 1)
(defconstant $kHIDRtOutputReport 2)
(defconstant $kHIDRtFeatureReport 3)
; !
;     @enum HID Protocol
;     @discussion  Used in the SET_PROTOCOL device request
;     

(defconstant $kHIDBootProtocolValue 0)
(defconstant $kHIDReportProtocolValue 1)
; !
;     @enum HID Interface Protocol
;     @discussion Reported in the bInterfaceProtocol field of the Interface Descriptor.
;     

(defconstant $kHIDNoInterfaceProtocol 0)
(defconstant $kHIDKeyboardInterfaceProtocol 1)
(defconstant $kHIDMouseInterfaceProtocol 2)
(defconstant $kUSBVendorSpecificProtocol #xFF)

(defconstant $kUSBCapsLockKey 57)
(defconstant $kUSBNumLockKey 83)
(defconstant $kUSBScrollLockKey 71)
; !
;     @enum Device and Interface Class
;     @discussion Constants for USB Device and Interface classes (bDeviceClass and bInterfaceClass).
;     

(defconstant $kUSBCompositeClass 0)
(defconstant $kUSBAudioClass 1)
(defconstant $kUSBCommClass 2)
(defconstant $kUSBHIDClass 3)
(defconstant $kUSBDisplayClass 4)
(defconstant $kUSBPrintingClass 7)
(defconstant $kUSBMassStorageClass 8)
(defconstant $kUSBHubClass 9)
(defconstant $kUSBDataClass 10)
(defconstant $kUSBApplicationSpecificClass #xFE)
(defconstant $kUSBVendorSpecificClass #xFF)
; !
;     @enum Device and Interface SubClass
;     @discussion Constants for USB Device and Interface SubClasses (bDeviceSubClass and bInterfaceSubClass).
; 

(defconstant $kUSBCompositeSubClass 0)
(defconstant $kUSBHubSubClass 0)
(defconstant $kUSBDFUSubClass 1)
(defconstant $kUSBIrDABridgeSubClass 2)
(defconstant $kUSBMassStorageRBCSubClass 1)
(defconstant $kUSBMassStorageATAPISubClass 2)
(defconstant $kUSBMassStorageQIC157SubClass 3)
(defconstant $kUSBMassStorageUFISubClass 4)
(defconstant $kUSBMassStorageSFF8070iSubClass 5)
(defconstant $kUSBMassStorageSCSISubClass 6)
(defconstant $kUSBHIDBootInterfaceSubClass 1)
(defconstant $kUSBCommDirectLineSubClass 1)
(defconstant $kUSBCommAbstractSubClass 2)
(defconstant $kUSBCommTelephoneSubClass 3)
(defconstant $kUSBCommMultiChannelSubClass 4)
(defconstant $kUSBCommCAPISubClass 5)
(defconstant $kUSBCommEthernetNetworkingSubClass 6)
(defconstant $kUSBATMNetworkingSubClass 7)
; !
;     @enum DFU Class Attributes
;     @discussion 
; 

(defconstant $kUSBDFUAttributesMask 7)
(defconstant $kUSBDFUCanDownloadBit 0)
(defconstant $kUSBDFUCanUploadBit 1)
(defconstant $kUSBDFUManifestationTolerantBit 2)
; !
;     @enum Property Names
;     @discussion USB property names taken from the field names in various descriptors
; 
(defconstant $kUSBDeviceClass "bDeviceClass")
; #define kUSBDeviceClass             "bDeviceClass"
(defconstant $kUSBDeviceSubClass "bDeviceSubClass")
; #define kUSBDeviceSubClass          "bDeviceSubClass"
(defconstant $kUSBDeviceProtocol "bDeviceProtocol")
; #define kUSBDeviceProtocol          "bDeviceProtocol"
(defconstant $kUSBDeviceMaxPacketSize "bMaxPacketSize0")
; #define kUSBDeviceMaxPacketSize     "bMaxPacketSize0"
(defconstant $kUSBVendorID "idVendor")
; #define kUSBVendorID                "idVendor"          // good name
; #define kUSBVendorName              kUSBVendorID        // bad name - keep for backward compatibility
(defconstant $kUSBProductID "idProduct")
; #define kUSBProductID               "idProduct"         // good name
; #define kUSBProductName             kUSBProductID       // bad name - keep for backward compatibility
(defconstant $kUSBDeviceReleaseNumber "bcdDevice")
; #define kUSBDeviceReleaseNumber     "bcdDevice"
(defconstant $kUSBManufacturerStringIndex "iManufacturer")
; #define kUSBManufacturerStringIndex "iManufacturer"
(defconstant $kUSBProductStringIndex "iProduct")
; #define kUSBProductStringIndex      "iProduct"
(defconstant $kUSBSerialNumberStringIndex "iSerialNumber")
; #define kUSBSerialNumberStringIndex "iSerialNumber"
(defconstant $kUSBDeviceNumConfigs "bNumConfigurations")
; #define kUSBDeviceNumConfigs        "bNumConfigurations"
(defconstant $kUSBInterfaceNumber "bInterfaceNumber")
; #define kUSBInterfaceNumber         "bInterfaceNumber"
(defconstant $kUSBAlternateSetting "bAlternateSetting")
; #define kUSBAlternateSetting        "bAlternateSetting"
(defconstant $kUSBNumEndpoints "bNumEndpoints")
; #define kUSBNumEndpoints            "bNumEndpoints"
(defconstant $kUSBInterfaceClass "bInterfaceClass")
; #define kUSBInterfaceClass          "bInterfaceClass"
(defconstant $kUSBInterfaceSubClass "bInterfaceSubClass")
; #define kUSBInterfaceSubClass       "bInterfaceSubClass"
(defconstant $kUSBInterfaceProtocol "bInterfaceProtocol")
; #define kUSBInterfaceProtocol       "bInterfaceProtocol"
(defconstant $kUSBInterfaceStringIndex "iInterface")
; #define kUSBInterfaceStringIndex    "iInterface"
(defconstant $kUSBConfigurationValue "bConfigurationValue")
; #define kUSBConfigurationValue      "bConfigurationValue"
; #ifdef __cplusplus
#| #|
}       
#endif
|#
 |#

; #endif /* _USBSPEC_H */


(provide-interface "USBSpec")