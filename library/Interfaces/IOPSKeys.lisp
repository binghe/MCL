(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOPSKeys.h"
; at Sunday July 2,2006 7:29:43 pm.
; 
;  * Copyright (c) 2002 Apple Computer, Inc. All rights reserved.
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
; !
;     @header IOPSKeys.h
;     
;     IOPSKeys.h defines C strings for use accessing power source data in IOPowerSource
;     CFDictionaries, as returned by IOPSGetPowerSourceDescription()<br>
;     Note that all of these C strings must be converted to CFStrings before use. You can wrap
;     them with the CFSTR() macro, or create a CFStringRef (that you must later CFRelease()) using CFStringCreateWithCString()
;  
; !
;  @define kIOPSUPSManagementClaimed
;  @abstract Claims UPS management for a third-party driver.
;  @discussion kIOPSUPSManagementClaimed If a third-party app manages UPS power it should set this key in the SCDynamicStore
;     with a value of kCFBooleanTrue.
;     If this key is not set, OS X will provide a minimal default UPS Power Management
;     implementation that includes clean shutdown if the attached UPS falls below 20%
;     remaining battery power. <br>This key should be used with the "State:" prefix, as in "State:/IOKit/UPSPowerManagementClaimed"
;     
;  
(defconstant $kIOPSUPSManagementClaimed "/IOKit/UPSPowerManagementClaimed")
; #define kIOPSUPSManagementClaimed       "/IOKit/UPSPowerManagementClaimed"
; !
;     @define kIOPSLowWarnLevelKey 
;     @abstract Key for the "Warning" UPS low power trigger-level. Default is 50%.
; 
(defconstant $kIOPSLowWarnLevelKey "Low Warn Level")
; #define kIOPSLowWarnLevelKey           "Low Warn Level"
; !
;     @define kIOPSDeadWarnLevelKey 
;     @abstract Key for the "Shutdown System" low power trigger-level. Default is 20%.
; 
(defconstant $kIOPSDeadWarnLevelKey "Shutdown Level")
; #define kIOPSDeadWarnLevelKey          "Shutdown Level"
; !
;     @define kIOPSDynamicStorePath
;     @abstract This is only used for internal bookkeeping, and should be ignored.
;  
(defconstant $kIOPSDynamicStorePath "/IOKit/PowerSources")
; #define kIOPSDynamicStorePath          "/IOKit/PowerSources"
; 
;  * Power Source data keys
;  * These keys specify the values in a dictionary of PowerSource details.
;  * Use these keys in conjunction with the dictionary returned by 
;  * IOPSGetPowerSourceDescription()
;  
; !
;     @define kIOPSPowerSourceStateKey
;     @abstract CFDictionary key for the current source of power.
;         <br>Type CFString, value is kIOPSACPowerValue, kIOPSBatteryPowerValue, or kIOPSOffLineValue.
; 
(defconstant $kIOPSPowerSourceStateKey "Power Source State")
; #define kIOPSPowerSourceStateKey       "Power Source State"
; !
;     @define kIOPSCurrentCapacityKey
;     @abstract CFDictionary key for the current power source's capacity.
;         <br>Type CFNumber (signed integer), units are relative to "Max Capacity"
; 
(defconstant $kIOPSCurrentCapacityKey "Current Capacity")
; #define kIOPSCurrentCapacityKey        "Current Capacity"
; !
;     @define kIOPSMaxCapacityKey
;     @abstract CFDictionary key for the current power source's maximum capacity
;         <br>Type CFNumber (signed integer), units are %
; 
(defconstant $kIOPSMaxCapacityKey "Max Capacity")
; #define kIOPSMaxCapacityKey            "Max Capacity"
; !
;     @define kIOPSTimeToEmptyKey
;     @abstract CFDictionary key for the current power source's time remaining until empty.
;         Only valid if the power source is running off its own power. That's when the 
;         kIOPSPowerSourceStateKey has value kIOPSBatteryPowerValue, 
;         and the value of kIOPSIsChargingKey is kCFBooleanFalse.
;         <br>Type CFNumber (signed integer), units are minutes
;         <br>A value of -1 indicates "Still Calculating the Time", otherwise estimated minutes left on the battery.
; 
(defconstant $kIOPSTimeToEmptyKey "Time to Empty")
; #define kIOPSTimeToEmptyKey            "Time to Empty"
; !
;     @define kIOPSTimeToFullChargeKey
;     @abstract CFDictionary key for the current power source's time remaining until empty.
;         Only valid if the value of kIOPSIsChargingKey is kCFBooleanTrue.
;         <br>Type CFNumber (signed integer), units are minutes
;         <br>A value of -1 indicates "Still Calculating the Time", otherwise estimated minutes until fully charged.
; 
(defconstant $kIOPSTimeToFullChargeKey "Time to Full Charge")
; #define kIOPSTimeToFullChargeKey       "Time to Full Charge"
; !
;     @define kIOPSIsChargingKey
;     @abstract CFDictionary key for the current power source's charging state
;         <br>Type CFBoolean - kCFBooleanTrue or kCFBooleanFalse
; 
(defconstant $kIOPSIsChargingKey "Is Charging")
; #define kIOPSIsChargingKey             "Is Charging"
; !
;     @define kIOPSIsPresentKey
;     @abstract CFDictionary key for the current power source's presence. 
;     <br>For instance, a PowerBook with the capacity for two batteries but 
;         with only one present would show two power source dictionaries, 
;         but kIOPSIsPresentKey would have the value kCFBooleanFalse in one of them.
;     <br>Type CFBoolean - kCFBooleanTrue or kCFBooleanFalse
; 
(defconstant $kIOPSIsPresentKey "Is Present")
; #define kIOPSIsPresentKey              "Is Present"
; !
;     @define kIOPSVoltageKey
;     @abstract CFDictionary key for the current power source's electrical voltage.
;     <br>Type CFNumber (signed integer) - units are mV
; 
(defconstant $kIOPSVoltageKey "Voltage")
; #define kIOPSVoltageKey                "Voltage"
; !
;     @define kIOPSCurrentKey
;     @abstract CFDictionary key for the current power source's electrical current.
;     <br>Type CFNumber (signed integer) - units are mA
; 
(defconstant $kIOPSCurrentKey "Current")
; #define kIOPSCurrentKey                "Current"
; !
;     @define kIOPSNameKey
;     @abstract CFDictionary key for the current power source's name.
;     <br>Type CFStringRef
; 
(defconstant $kIOPSNameKey "Name")
; #define kIOPSNameKey                   "Name"
; !
;     @define kIOPSTransportTypeKey
;     @abstract CFDictionary key for the current power source's transport type.
;     <br>Type CFStringRef. Valid transport types are kIOPSSerialTransportType, 
;     kIOPSUSBTransportType, kIOPSNetworkTransportType, or kIOPSInternalType.
; 
(defconstant $kIOPSTransportTypeKey "Transport Type")
; #define kIOPSTransportTypeKey          "Transport Type"
; 
;  * Transport types
;  
; !
;     @define kIOPSSerialTransportType
;     @abstract Value for key kIOPSTransportTypeKey. Indicates the power source is a UPS attached over a serial connection.
; 
(defconstant $kIOPSSerialTransportType "Serial")
; #define kIOPSSerialTransportType       "Serial"
; !
;     @define kIOPSUSBTransportType
;     @abstract Value for key kIOPSTransportTypeKey. Indicates the power source is a UPS attached over a USB connection.
; 
(defconstant $kIOPSUSBTransportType "USB")
; #define kIOPSUSBTransportType          "USB"
; !
;     @define kIOPSNetworkTransportType
;     @abstract Value for key kIOPSTransportTypeKey. Indicates the power source is a UPS attached over a network connection (and it may be managing several computers).
; 
(defconstant $kIOPSNetworkTransportType "Ethernet")
; #define kIOPSNetworkTransportType      "Ethernet"
; !
;     @define kIOPSInternalType
;     @abstract Value for key kIOPSTransportTypeKey. Indicates the power source is an internal battery.
; 
(defconstant $kIOPSInternalType "Internal")
; #define kIOPSInternalType              "Internal"
; 
;  * PS state 
;  
; !
;     @define kIOPSOffLineValue
;     @abstract Value for key kIOPSPowerSourceStateKey. Power source is off-line or no longer connected.
; 
(defconstant $kIOPSOffLineValue "Off Line")
; #define kIOPSOffLineValue              "Off Line"
; !
;     @define kIOPSACPowerValue
;     @abstract Value for key kIOPSPowerSourceStateKey. Power source is connected to external or AC power, and is not draining the internal battery.
; 
(defconstant $kIOPSACPowerValue "AC Power")
; #define kIOPSACPowerValue              "AC Power"
; !
;     @define kIOPSBatteryPowerValue
;     @abstract Value for key kIOPSPowerSourceStateKey. Power source is currently using the internal battery.
; 
(defconstant $kIOPSBatteryPowerValue "Battery Power")
; #define kIOPSBatteryPowerValue         "Battery Power"

(provide-interface "IOPSKeys")