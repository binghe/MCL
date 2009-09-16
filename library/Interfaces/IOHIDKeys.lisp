(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOHIDKeys.h"
; at Sunday July 2,2006 7:29:18 pm.
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
; #ifndef _IOKIT_HID_IOHIDKEYS_H_
; #define _IOKIT_HID_IOHIDKEYS_H_

(require-interface "sys/cdefs")

(require-interface "IOKit/hidsystem/IOHIDParameter")
;  The following keys are used to search the IORegistry for HID related services
; 
;  This is used to find HID Devices in the IORegistry 
(defconstant $kIOHIDDeviceKey "IOHIDDevice")
; #define kIOHIDDeviceKey                     "IOHIDDevice"
; !
;     @defined HID Device Property Keys
;     @abstract Keys that represent properties of a paticular element.
;     @discussion Keys that represent properties of a paticular element.  Can be added
;         to your matching dictionary when refining searches for HID devices.
;         <br><br>
;         <b>Please note:</b><br>
;         kIOHIDPrimaryUsageKey and kIOHIDPrimaryUsagePageKey are no longer 
;         rich enough to describe a device's capabilities.  Take, for example, a
;         device that describes both a keyboard and a mouse in the same descriptor.  
;         The previous behavior was to only describe the keyboard behavior with the 
;         primary usage and usage page.   Needless to say, this would sometimes cause 
;         a program interested in mice to skip this device when matching.  
;         <br>
;         Thus we have added 3 
;         additional keys:
;         <ul>
;             <li>kIOHIDDeviceUsageKey</li>
;             <li>kIOHIDDeviceUsagePageKey</li>
;             <li>kIOHIDDeviceUsagePairsKey</li>
;         </ul>
;         kIOHIDDeviceUsagePairsKey is used to represent an array of dictionaries containing 
;         key/value pairs referenced by kIOHIDDeviceUsageKey and kIOHIDDeviceUsagePageKey.  
;         These usage pairs describe all application type collections (behaviors) defined 
;         by the device.
;         <br><br>
;         An application intersted in only matching on one criteria would only add the 
;         kIOHIDDeviceUsageKey and kIOHIDDeviceUsagePageKey keys to the matching dictionary.
;         If it is interested in a device that has multiple behaviors, the application would
;         instead add an array or dictionaries referenced by kIOHIDDeviceUsagePairsKey to his 
;         matching dictionary.
; 
(defconstant $kIOHIDTransportKey "Transport")
; #define kIOHIDTransportKey                  "Transport"
(defconstant $kIOHIDVendorIDKey "VendorID")
; #define kIOHIDVendorIDKey                   "VendorID"
(defconstant $kIOHIDVendorIDSourceKey "VendorIDSource")
; #define kIOHIDVendorIDSourceKey             "VendorIDSource"
(defconstant $kIOHIDProductIDKey "ProductID")
; #define kIOHIDProductIDKey                  "ProductID"
(defconstant $kIOHIDVersionNumberKey "VersionNumber")
; #define kIOHIDVersionNumberKey              "VersionNumber"
(defconstant $kIOHIDManufacturerKey "Manufacturer")
; #define kIOHIDManufacturerKey               "Manufacturer"
(defconstant $kIOHIDProductKey "Product")
; #define kIOHIDProductKey                    "Product"
(defconstant $kIOHIDSerialNumberKey "SerialNumber")
; #define kIOHIDSerialNumberKey               "SerialNumber"
(defconstant $kIOHIDLocationIDKey "LocationID")
; #define kIOHIDLocationIDKey                 "LocationID"
(defconstant $kIOHIDDeviceUsageKey "DeviceUsage")
; #define kIOHIDDeviceUsageKey                "DeviceUsage"
(defconstant $kIOHIDDeviceUsagePageKey "DeviceUsagePage")
; #define kIOHIDDeviceUsagePageKey            "DeviceUsagePage"
(defconstant $kIOHIDDeviceUsagePairsKey "DeviceUsagePairs")
; #define kIOHIDDeviceUsagePairsKey           "DeviceUsagePairs"
(defconstant $kIOHIDPrimaryUsageKey "PrimaryUsage")
; #define kIOHIDPrimaryUsageKey               "PrimaryUsage"
(defconstant $kIOHIDPrimaryUsagePageKey "PrimaryUsagePage")
; #define kIOHIDPrimaryUsagePageKey           "PrimaryUsagePage"
(defconstant $kIOHIDMaxInputReportSizeKey "MaxInputReportSize")
; #define kIOHIDMaxInputReportSizeKey	    "MaxInputReportSize"
(defconstant $kIOHIDMaxOutputReportSizeKey "MaxOutputReportSize")
; #define kIOHIDMaxOutputReportSizeKey	    "MaxOutputReportSize"
(defconstant $kIOHIDMaxFeatureReportSizeKey "MaxFeatureReportSize")
; #define kIOHIDMaxFeatureReportSizeKey	    "MaxFeatureReportSize"
; !
;     @define kIOHIDElementKey
;     @abstract Keys that represents an element property.
;     @discussion Property for a HID Device or element dictionary.
;         Elements can be heirarchical, so they can contain other elements.
; 
(defconstant $kIOHIDElementKey "Elements")
; #define kIOHIDElementKey                    "Elements"
; !
;     @defined HID Element Dictionary Keys
;     @abstract Keys that represent properties of a particular elements.
;     @discussion These keys can also be added to a matching dictionary 
;         when searching for elements via copyMatchingElements.  
; 
(defconstant $kIOHIDElementCookieKey "ElementCookie")
; #define kIOHIDElementCookieKey              "ElementCookie"
(defconstant $kIOHIDElementTypeKey "Type")
; #define kIOHIDElementTypeKey                "Type"
(defconstant $kIOHIDElementCollectionTypeKey "CollectionType")
; #define kIOHIDElementCollectionTypeKey      "CollectionType"
(defconstant $kIOHIDElementUsageKey "Usage")
; #define kIOHIDElementUsageKey               "Usage"
(defconstant $kIOHIDElementUsagePageKey "UsagePage")
; #define kIOHIDElementUsagePageKey           "UsagePage"
(defconstant $kIOHIDElementMinKey "Min")
; #define kIOHIDElementMinKey                 "Min"
(defconstant $kIOHIDElementMaxKey "Max")
; #define kIOHIDElementMaxKey                 "Max"
(defconstant $kIOHIDElementScaledMinKey "ScaledMin")
; #define kIOHIDElementScaledMinKey           "ScaledMin"
(defconstant $kIOHIDElementScaledMaxKey "ScaledMax")
; #define kIOHIDElementScaledMaxKey           "ScaledMax"
(defconstant $kIOHIDElementSizeKey "Size")
; #define kIOHIDElementSizeKey                "Size"
(defconstant $kIOHIDElementReportSizeKey "ReportSize")
; #define kIOHIDElementReportSizeKey          "ReportSize"
(defconstant $kIOHIDElementReportCountKey "ReportCount")
; #define kIOHIDElementReportCountKey         "ReportCount"
(defconstant $kIOHIDElementIsArrayKey "IsArray")
; #define kIOHIDElementIsArrayKey             "IsArray"
(defconstant $kIOHIDElementIsRelativeKey "IsRelative")
; #define kIOHIDElementIsRelativeKey          "IsRelative"
(defconstant $kIOHIDElementIsWrappingKey "IsWrapping")
; #define kIOHIDElementIsWrappingKey          "IsWrapping"
(defconstant $kIOHIDElementIsNonLinearKey "IsNonLinear")
; #define kIOHIDElementIsNonLinearKey         "IsNonLinear"
(defconstant $kIOHIDElementHasPreferredStateKey "HasPreferredState")
; #define kIOHIDElementHasPreferredStateKey   "HasPreferredState"
(defconstant $kIOHIDElementHasNullStateKey "HasNullState")
; #define kIOHIDElementHasNullStateKey        "HasNullState"
(defconstant $kIOHIDElementVendorSpecificKey "VendorSpecifc")
; #define kIOHIDElementVendorSpecificKey      "VendorSpecifc"
(defconstant $kIOHIDElementUnitKey "Unit")
; #define kIOHIDElementUnitKey                "Unit"
(defconstant $kIOHIDElementUnitExponentKey "UnitExponent")
; #define kIOHIDElementUnitExponentKey        "UnitExponent"
(defconstant $kIOHIDElementNameKey "Name")
; #define kIOHIDElementNameKey                "Name"
(defconstant $kIOHIDElementValueLocationKey "ValueLocation")
; #define kIOHIDElementValueLocationKey       "ValueLocation"
(defconstant $kIOHIDElementDuplicateIndexKey "DuplicateIndex")
; #define kIOHIDElementDuplicateIndexKey      "DuplicateIndex"
; !
;     @typedef IOHIDElementCookie
;     @abstract Abstract data type used as a unique identifier for an element.
; 

(def-mactype :IOHIDElementCookie (find-mactype '(:pointer :void)))
; !
;   @typedef IOHIDElementType
;   @abstract Describes different types of HID elements.
;   @discussion Used by the IOHIDFamily to identify the type of
;   element processed.  Represented by the key kIOHIDElementTypeKey in the 
;     dictionary describing the element.
;   @constant kIOHIDElementTypeInput_Misc
;     Misc input data field or varying size.
;   @constant kIOHIDElementTypeInput_Button 
;     One bit input data field.
;   @constant kIOHIDElementTypeInput_Axis 
;     Input data field used to represent an axis.
;   @constant kIOHIDElementTypeInput_ScanCodes
;     Input data field used to represent a scan code or usage selector.
;   @constant kIOHIDElementTypeOutput
;     Used to represent an output data field in a report.
;   @constant kIOHIDElementTypeFeature
;     Describes input and output elements not intended for 
;     consumption by the end user.
;   @constant kIOHIDElementTypeCollection
;     Element used to identify a relationship between two or more elements.
; 
(def-mactype :IOHIDElementType (find-mactype ':sint32))

(defconstant $kIOHIDElementTypeInput_Misc 1)
(defconstant $kIOHIDElementTypeInput_Button 2)
(defconstant $kIOHIDElementTypeInput_Axis 3)
(defconstant $kIOHIDElementTypeInput_ScanCodes 4)
(defconstant $kIOHIDElementTypeOutput #x81)
(defconstant $kIOHIDElementTypeFeature #x101)
(defconstant $kIOHIDElementTypeCollection #x201)

;type name? (def-mactype :IOHIDElementType (find-mactype ':IOHIDElementType))
; !
;   @typedef IOHIDElementCollectionType
;   @abstract Describes different types of HID collections.
;   @discussion Collections identify a relationship between two or more
;     elements.
;   @constant kIOHIDElementCollectionTypePhysical   
;     Used for a set of data items that represent data points 
;     collected at one geometric point.
;   @constant kIOHIDElementCollectionTypeApplication 
;     Identifies item groups serving different purposes in a single device.
;   @constant kIOHIDElementCollectionTypeLogical
;     Used when a set of data items form a composite data structure.
;   @constant kIOHIDElementCollectionTypeReport 
;     Wraps all the fields in a report.
;   @constant kIOHIDElementCollectionTypeNamedArray 
;     Contains an array of selector usages.
;   @constant kIOHIDElementCollectionTypeUsageSwitch 
;     Modifies the meaning of the usage it contains.
;   @constant kIOHIDElementCollectionTypeUsageModifier 
;     Modifies the meaning of the usage attached to the encompassing collection.
; 
(def-mactype :IOHIDElementCollectionType (find-mactype ':sint32))

(defconstant $kIOHIDElementCollectionTypePhysical 0)
(defconstant $kIOHIDElementCollectionTypeApplication 1)
(defconstant $kIOHIDElementCollectionTypeLogical 2)
(defconstant $kIOHIDElementCollectionTypeReport 3)
(defconstant $kIOHIDElementCollectionTypeNamedArray 4)
(defconstant $kIOHIDElementCollectionTypeUsageSwitch 5)
(defconstant $kIOHIDElementCollectionTypeUsageModifier 6)

;type name? (def-mactype :IOHIDElementCollectionType (find-mactype ':IOHIDElementCollectionType))
; !
;   @typedef IOHIDReportType
;   @abstract Describes different type of HID reports.
;   @discussion Used by the IOHIDFamily to identify the type of
;     report being processed.
;   @constant kIOHIDReportTypeInput Input report.
;   @constant kIOHIDReportTypeOutput Output report.
;   @constant kIOHIDReportTypeFeature Feature report.
; 
(def-mactype :IOHIDReportType (find-mactype ':sint32))

(defconstant $kIOHIDReportTypeInput 0)
(defconstant $kIOHIDReportTypeOutput 1)
(defconstant $kIOHIDReportTypeFeature 2)
(defconstant $kIOHIDReportTypeCount 3)

;type name? (def-mactype :IOHIDReportType (find-mactype ':IOHIDReportType))
; !
;   @typedef IOHIDOptionsType
;   @abstract Options for opening a device via IOHIDLib.
;   @constant kIOHIDOptionsTypeNone Default option.
;   @constant kIOHIDOptionsTypeSeizeDevice Used to open exclusive
;     communication with the device.  This will prevent the system
;     and other clients from receiving events from the device.
; 
(def-mactype :IOHIDOptionsType (find-mactype ':sint32))

(defconstant $kIOHIDOptionsTypeNone 0)
(defconstant $kIOHIDOptionsTypeSeizeDevice 1)

;type name? (def-mactype :IOHIDOptionsType (find-mactype ':IOHIDOptionsType))

; #endif /* !_IOKIT_HID_IOHIDKEYS_H_ */


(provide-interface "IOHIDKeys")