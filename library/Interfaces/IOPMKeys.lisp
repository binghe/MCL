(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOPMKeys.h"
; at Sunday July 2,2006 7:29:41 pm.
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
; !
;     @header IOPMKeys.h
;     
;     IOPMKeys.h defines C strings for use accessing power management data.
;     Note that all of these C strings must be converted to CFStrings before use. You can wrap
;     them with the CFSTR() macro, or create a CFStringRef (that you must later CFRelease()) using CFStringCreateWithCString()
;  
; 
;  * Types of power event
;  * These are potential arguments to IOPMSchedulePowerEvent().
;  * These are all potential values of the kIOPMPowerEventTypeKey in the CFDictionaries
;  * returned by IOPMCopyScheduledPowerEvents().
;  
; !
;     @define kIOPMAutoWake 
;     @abstract Value for scheduled wake from sleep.
; 
(defconstant $kIOPMAutoWake "wake")
; #define kIOPMAutoWake                                   "wake"
; !
;     @define kIOPMAutoPowerOn 
;     @abstract Value for scheduled power on from off state.
; 
(defconstant $kIOPMAutoPowerOn "poweron")
; #define kIOPMAutoPowerOn                                "poweron"
; !
;     @define kIOPMAutoWakeOrPowerOn 
;     @abstract Value for scheduled wake from sleep, or power on. The system will either wake OR
;         power on, whichever is necessary.
; 
(defconstant $kIOPMAutoWakeOrPowerOn "wakepoweron")
; #define kIOPMAutoWakeOrPowerOn                          "wakepoweron"
; !
;     @define kIOPMAutoSleep
;     @abstract Value for scheduled sleep.
; 
(defconstant $kIOPMAutoSleep "sleep")
; #define kIOPMAutoSleep                                   "sleep"
; !
;     @define kIOPMAutoShutdown 
;     @abstract Value for scheduled shutdown.
; 
(defconstant $kIOPMAutoShutdown "shutdown")
; #define kIOPMAutoShutdown                               "shutdown"
; 
;  * Keys for evaluating the CFDictionaries returned by IOPMCopyScheduledPowerEvents()
;  
; !
;     @define kIOPMPowerEventTimeKey 
;     @abstract Key for the time of the scheduled power event. Value is a CFDateRef.
; 
(defconstant $kIOPMPowerEventTimeKey "time")
; #define kIOPMPowerEventTimeKey                          "time"
; !
;     @define kIOPMPowerEventAppNameKey 
;     @abstract Key for the CFBundleIdentifier of the app that scheduled the power event. Value is a CFStringRef.
; 
(defconstant $kIOPMPowerEventAppNameKey "scheduledby")
; #define kIOPMPowerEventAppNameKey                       "scheduledby"
; !
;     @define kIOPMPowerEventTypeKey 
;     @abstract Key for the type of power event. Value is a CFStringRef, with the c-string value of one of the "kIOPMAuto" strings.
; 
(defconstant $kIOPMPowerEventTypeKey "eventtype")
; #define kIOPMPowerEventTypeKey                          "eventtype"

(provide-interface "IOPMKeys")