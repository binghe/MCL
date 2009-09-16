(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOKitKeys.h"
; at Sunday July 2,2006 7:24:15 pm.
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
;  * Copyright (c) 1999 Apple Computer, Inc.  All rights reserved. 
;  *
;  * Common symbol definitions for IOKit. 
;  *
;  * HISTORY
;  *
;  
; #ifndef _IOKIT_IOKITKEYS_H
; #define _IOKIT_IOKITKEYS_H
;  properties found in the registry root
(defconstant $kIOKitBuildVersionKey "IOKitBuildVersion")
; #define kIOKitBuildVersionKey		"IOKitBuildVersion"
(defconstant $kIOKitDiagnosticsKey "IOKitDiagnostics")
; #define kIOKitDiagnosticsKey		"IOKitDiagnostics"
;  a dictionary keyed by plane name
(defconstant $kIORegistryPlanesKey "IORegistryPlanes")
; #define kIORegistryPlanesKey		"IORegistryPlanes"
(defconstant $kIOCatalogueKey "IOCatalogue")
; #define kIOCatalogueKey			"IOCatalogue"
;  registry plane names
(defconstant $kIOServicePlane "IOService")
; #define kIOServicePlane			"IOService"
(defconstant $kIOPowerPlane "IOPower")
; #define kIOPowerPlane			"IOPower"
(defconstant $kIODeviceTreePlane "IODeviceTree")
; #define kIODeviceTreePlane		"IODeviceTree"
(defconstant $kIOAudioPlane "IOAudio")
; #define kIOAudioPlane			"IOAudio"
(defconstant $kIOFireWirePlane "IOFireWire")
; #define kIOFireWirePlane		"IOFireWire"
(defconstant $kIOUSBPlane "IOUSB")
; #define kIOUSBPlane			"IOUSB"
;  IOService class name
(defconstant $kIOServiceClass "IOService")
; #define kIOServiceClass			"IOService"
;  IOResources class name
(defconstant $kIOResourcesClass "IOResources")
; #define kIOResourcesClass		"IOResources"
;  IOService driver probing property names
(defconstant $kIOClassKey "IOClass")
; #define kIOClassKey			"IOClass"
(defconstant $kIOProbeScoreKey "IOProbeScore")
; #define kIOProbeScoreKey		"IOProbeScore"
(defconstant $kIOKitDebugKey "IOKitDebug")
; #define kIOKitDebugKey			"IOKitDebug"
;  IOService matching property names
(defconstant $kIOProviderClassKey "IOProviderClass")
; #define kIOProviderClassKey		"IOProviderClass"
(defconstant $kIONameMatchKey "IONameMatch")
; #define kIONameMatchKey			"IONameMatch"
(defconstant $kIOPropertyMatchKey "IOPropertyMatch")
; #define kIOPropertyMatchKey		"IOPropertyMatch"
(defconstant $kIOPathMatchKey "IOPathMatch")
; #define kIOPathMatchKey			"IOPathMatch"
(defconstant $kIOLocationMatchKey "IOLocationMatch")
; #define kIOLocationMatchKey		"IOLocationMatch"
(defconstant $kIOParentMatchKey "IOParentMatch")
; #define kIOParentMatchKey		"IOParentMatch"
(defconstant $kIOResourceMatchKey "IOResourceMatch")
; #define kIOResourceMatchKey		"IOResourceMatch"
(defconstant $kIOMatchedServiceCountKey "IOMatchedServiceCountMatch")
; #define kIOMatchedServiceCountKey	"IOMatchedServiceCountMatch"
(defconstant $kIONameMatchedKey "IONameMatched")
; #define kIONameMatchedKey		"IONameMatched"
(defconstant $kIOMatchCategoryKey "IOMatchCategory")
; #define kIOMatchCategoryKey		"IOMatchCategory"
(defconstant $kIODefaultMatchCategoryKey "IODefaultMatchCategory")
; #define kIODefaultMatchCategoryKey	"IODefaultMatchCategory"
;  IOService default user client class, for loadable user clients
(defconstant $kIOUserClientClassKey "IOUserClientClass")
; #define kIOUserClientClassKey		"IOUserClientClass"
;  IOService notification types
(defconstant $kIOPublishNotification "IOServicePublish")
; #define kIOPublishNotification		"IOServicePublish"
(defconstant $kIOFirstPublishNotification "IOServiceFirstPublish")
; #define kIOFirstPublishNotification	"IOServiceFirstPublish"
(defconstant $kIOMatchedNotification "IOServiceMatched")
; #define kIOMatchedNotification		"IOServiceMatched"
(defconstant $kIOFirstMatchNotification "IOServiceFirstMatch")
; #define kIOFirstMatchNotification	"IOServiceFirstMatch"
(defconstant $kIOTerminatedNotification "IOServiceTerminate")
; #define kIOTerminatedNotification	"IOServiceTerminate"
;  IOService interest notification types
(defconstant $kIOGeneralInterest "IOGeneralInterest")
; #define kIOGeneralInterest		"IOGeneralInterest"
(defconstant $kIOBusyInterest "IOBusyInterest")
; #define kIOBusyInterest			"IOBusyInterest"
(defconstant $kIOAppPowerStateInterest "IOAppPowerStateInterest")
; #define kIOAppPowerStateInterest	"IOAppPowerStateInterest"
(defconstant $kIOPriorityPowerStateInterest "IOPriorityPowerStateInterest")
; #define kIOPriorityPowerStateInterest	"IOPriorityPowerStateInterest"
;  IOService interest notification types
(defconstant $kIOCFPlugInTypesKey "IOCFPlugInTypes")
; #define kIOCFPlugInTypesKey		"IOCFPlugInTypes"
;  properties found in services that implement command pooling
(defconstant $kIOCommandPoolSizeKey "IOCommandPoolSize")
; #define kIOCommandPoolSizeKey	       "IOCommandPoolSize"          // (OSNumber)
;  properties found in services that have transfer constraints
(defconstant $kIOMaximumBlockCountReadKey "IOMaximumBlockCountRead")
; #define kIOMaximumBlockCountReadKey        "IOMaximumBlockCountRead"        // (OSNumber)
(defconstant $kIOMaximumBlockCountWriteKey "IOMaximumBlockCountWrite")
; #define kIOMaximumBlockCountWriteKey       "IOMaximumBlockCountWrite"       // (OSNumber)
(defconstant $kIOMaximumByteCountReadKey "IOMaximumByteCountRead")
; #define kIOMaximumByteCountReadKey         "IOMaximumByteCountRead"         // (OSNumber)
(defconstant $kIOMaximumByteCountWriteKey "IOMaximumByteCountWrite")
; #define kIOMaximumByteCountWriteKey        "IOMaximumByteCountWrite"        // (OSNumber)
(defconstant $kIOMaximumSegmentCountReadKey "IOMaximumSegmentCountRead")
; #define kIOMaximumSegmentCountReadKey      "IOMaximumSegmentCountRead"      // (OSNumber)
(defconstant $kIOMaximumSegmentCountWriteKey "IOMaximumSegmentCountWrite")
; #define kIOMaximumSegmentCountWriteKey     "IOMaximumSegmentCountWrite"     // (OSNumber)
(defconstant $kIOMaximumSegmentByteCountReadKey "IOMaximumSegmentByteCountRead")
; #define kIOMaximumSegmentByteCountReadKey  "IOMaximumSegmentByteCountRead"  // (OSNumber)
(defconstant $kIOMaximumSegmentByteCountWriteKey "IOMaximumSegmentByteCountWrite")
; #define kIOMaximumSegmentByteCountWriteKey "IOMaximumSegmentByteCountWrite" // (OSNumber)
;  properties found in services that wish to describe an icon
; 
;  IOIcon = 
;  {
;      CFBundleIdentifier   = "com.example.driver.example";
;      IOBundleResourceFile = "example.icns";
;  };
; 
;  where IOBundleResourceFile is the filename of the resource
(defconstant $kIOIconKey "IOIcon")
; #define kIOIconKey               "IOIcon"               // (OSDictionary)
(defconstant $kIOBundleResourceFileKey "IOBundleResourceFile")
; #define kIOBundleResourceFileKey "IOBundleResourceFile" // (OSString)
(defconstant $kIOBusBadgeKey "IOBusBadge")
; #define kIOBusBadgeKey           "IOBusBadge"           // (OSDictionary)
(defconstant $kIODeviceIconKey "IODeviceIcon")
; #define kIODeviceIconKey         "IODeviceIcon"         // (OSDictionary)
;  property of root that describes the machine's serial number as a string
(defconstant $kIOPlatformSerialNumberKey "IOPlatformSerialNumber")
; #define kIOPlatformSerialNumberKey	"IOPlatformSerialNumber"	// (OSString)

; #endif /* ! _IOKIT_IOKITKEYS_H */


(provide-interface "IOKitKeys")