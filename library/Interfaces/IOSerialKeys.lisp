(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOSerialKeys.h"
; at Sunday July 2,2006 7:29:55 pm.
; 
;  * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
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
;  * IOSerialKeys.h
;  *
;  * 2000-10-21	gvdl	Initial real change to IOKit serial family.
;  *
;  
; 
; Sample Matching dictionary
; {
;     IOProviderClass = kIOSerialBSDServiceValue;
;     kIOSerialBSDTypeKey = kIOSerialBSDAllTypes
; 			| kIOSerialBSDModemType
; 			| kIOSerialBSDRS232Type;
;     kIOTTYDeviceKey = <Raw Unique Device Name>;
;     kIOTTYBaseNameKey = <Raw Unique Device Name>;
;     kIOTTYSuffixKey = <Raw Unique Device Name>;
;     kIOCalloutDeviceKey = <Callout Device Name>;
;     kIODialinDeviceKey = <Dialin Device Name>;
; }
; 
; Note only the IOProviderClass is mandatory.  The other keys allow the searcher to reduce the size of the set of matching devices.
; 
;  Service Matching That is the 'IOProviderClass' 
(defconstant $kIOSerialBSDServiceValue "IOSerialBSDClient")
; #define kIOSerialBSDServiceValue	"IOSerialBSDClient"
;  Matching keys 
(defconstant $kIOSerialBSDTypeKey "IOSerialBSDClientType")
; #define kIOSerialBSDTypeKey		"IOSerialBSDClientType"
;  Currently possible kIOSerialBSDTypeKey values. 
(defconstant $kIOSerialBSDAllTypes "IOSerialStream")
; #define kIOSerialBSDAllTypes		"IOSerialStream"
(defconstant $kIOSerialBSDModemType "IOModemSerialStream")
; #define kIOSerialBSDModemType		"IOModemSerialStream"
(defconstant $kIOSerialBSDRS232Type "IORS232SerialStream")
; #define kIOSerialBSDRS232Type		"IORS232SerialStream"
;  Properties that resolve to a /dev device node to open for
;  a particular service
(defconstant $kIOTTYDeviceKey "IOTTYDevice")
; #define kIOTTYDeviceKey			"IOTTYDevice"
(defconstant $kIOTTYBaseNameKey "IOTTYBaseName")
; #define kIOTTYBaseNameKey		"IOTTYBaseName"
(defconstant $kIOTTYSuffixKey "IOTTYSuffix")
; #define kIOTTYSuffixKey			"IOTTYSuffix"
(defconstant $kIOCalloutDeviceKey "IOCalloutDevice")
; #define kIOCalloutDeviceKey		"IOCalloutDevice"
(defconstant $kIODialinDeviceKey "IODialinDevice")
; #define kIODialinDeviceKey		"IODialinDevice"
;  Property 'ioctl' wait for the tty device to go idle.
(defconstant $kIOTTYWaitForIdleKey "IOTTYWaitForIdle")
; #define kIOTTYWaitForIdleKey		"IOTTYWaitForIdle"

; #if KERNEL
#| 
(def-mactype :gIOSerialBSDServiceValue (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIOSerialBSDTypeKey (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIOSerialBSDAllTypes (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIOSerialBSDModemType (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIOSerialBSDRS232Type (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIOTTYDeviceKey (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIOTTYBaseNameKey (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIOTTYSuffixKey (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIOCalloutDeviceKey (find-mactype '(:pointer :OSSymbol)))
(def-mactype :gIODialinDeviceKey (find-mactype '(:pointer :OSSymbol)))
 |#

; #endif /* KERNEL */


(provide-interface "IOSerialKeys")