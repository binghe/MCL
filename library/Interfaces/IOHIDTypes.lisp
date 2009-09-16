(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOHIDTypes.h"
; at Sunday July 2,2006 7:27:49 pm.
; 
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
; *****************************************************************************
; 	ev_types.h
; 	Data types for the events status driver.
; 	This file contains public API.
; 	mpaque 11Oct91
; 	
; 	Copyright 1991 NeXT Computer, Inc.
; 	
; 	Modified:
; 	
; *****************************************************************************
; #ifndef _DEV_EV_TYPES_H
; #define _DEV_EV_TYPES_H

(require-interface "mach/boolean")

(require-interface "IOKit/IOSharedLock")

(require-interface "IOKit/graphics/IOGraphicsTypes")
;  Shared memory versions 
(defconstant $EVENT_SYSTEM_VERSION 2)
; #define EVENT_SYSTEM_VERSION   2
;  Maximum length of SetMouseScaling arrays 
(defconstant $NX_MAXMOUSESCALINGS 20)
; #define NX_MAXMOUSESCALINGS 20
;  Match old struct names in kernel 
(defrecord evsioKeymapping
   (size :signed-long)
   (mapping (:pointer :char))
)
(%define-record :NXKeyMapping (find-record-descriptor :EVSIOKEYMAPPING))
;  Match old struct names in kernel 
(defrecord evsioMouseScaling
   (numScaleLevels :signed-long)
   (scaleThresholds (:array :SInt16 20))
   (scaleFactors (:array :SInt16 20))
)
(%define-record :NXMouseScaling (find-record-descriptor :EVSIOMOUSESCALING))

(defconstant $NX_OneButton 0)
(defconstant $NX_LeftButton 1)
(defconstant $NX_RightButton 2)
(def-mactype :NXMouseButton (find-mactype ':SINT32))
; 
;  * NXEventSystemInfo() information structures.  These are designed to
;  * allow for expansion.
;  *
;  * The current implementation of NXEventSystemInfo() uses an ioctl call.
;  * THIS WILL CHANGE.
;  
; 
;  * Generic query max size and typedefs.
;  *
;  *	The maximum size is selected to support anticipated future extensions
;  *	of request flavors.  Certain flavors planned for future releases may 
;  *	require roughtly 800 ints to represent.  We allow a little extra, in
;  *	case further growth is needed.
;  

(def-mactype :NXEventSystemInfoType (find-mactype '(:pointer :signed-long)))
(defconstant $NX_EVS_INFO_MAX 1024)
; #define NX_EVS_INFO_MAX		(1024)	/* Max array size */
(defrecord NXEventSystemInfoData
   (contents (:array :signed-long 1024))
)                                               ;  Event System Devices query 
(defconstant $NX_EVS_DEVICE_MAX 16)
; #define NX_EVS_DEVICE_MAX	16
;  Interface types 
(defconstant $NX_EVS_DEVICE_INTERFACE_OTHER 0)
; #define NX_EVS_DEVICE_INTERFACE_OTHER		0
(defconstant $NX_EVS_DEVICE_INTERFACE_NeXT 1)
; #define NX_EVS_DEVICE_INTERFACE_NeXT		1 // NeXT custom, in older sys
(defconstant $NX_EVS_DEVICE_INTERFACE_ADB 2)
; #define NX_EVS_DEVICE_INTERFACE_ADB		2 // NeXT/fruit keybds/mice
(defconstant $NX_EVS_DEVICE_INTERFACE_ACE 3)
; #define NX_EVS_DEVICE_INTERFACE_ACE		3 // For x86 PC keyboards
(defconstant $NX_EVS_DEVICE_INTERFACE_SERIAL_ACE 4)
; #define NX_EVS_DEVICE_INTERFACE_SERIAL_ACE	4 // For PC serial mice 
(defconstant $NX_EVS_DEVICE_INTERFACE_BUS_ACE 5)
; #define NX_EVS_DEVICE_INTERFACE_BUS_ACE		5 // For PC bus mice 
(defconstant $NX_EVS_DEVICE_INTERFACE_HIL 6)
; #define NX_EVS_DEVICE_INTERFACE_HIL		6 // For HIL hp keyboard 
(defconstant $NX_EVS_DEVICE_INTERFACE_TYPE5 7)
; #define NX_EVS_DEVICE_INTERFACE_TYPE5		7 // For Sun Type5 keyboard
; 
;  * Note! if any new interface types are added above, the following
;  * definition of the number of interfaces supported must reflect this.
;  * This is used in the libkeymap project (storemap.c module) which needs
;  * to be cognizant of the number of new devices coming online
;  * via support for heterogeneous architecture platforms.
;  * e.g., PCs, HP's HIL, Sun's Type5 keyboard,...
;  
(defconstant $NUM_SUPPORTED_INTERFACES 8)
; #define NUM_SUPPORTED_INTERFACES	(NX_EVS_DEVICE_INTERFACE_TYPE5 + 1)
;  Other, NeXT, ADB, ACE,...
;  Device types 
(defconstant $NX_EVS_DEVICE_TYPE_OTHER 0)
; #define NX_EVS_DEVICE_TYPE_OTHER	0
(defconstant $NX_EVS_DEVICE_TYPE_KEYBOARD 1)
; #define NX_EVS_DEVICE_TYPE_KEYBOARD	1
(defconstant $NX_EVS_DEVICE_TYPE_MOUSE 2)
; #define NX_EVS_DEVICE_TYPE_MOUSE	2	// Relative position devices
(defconstant $NX_EVS_DEVICE_TYPE_TABLET 3)
; #define NX_EVS_DEVICE_TYPE_TABLET	3	// Absolute position devices
(defrecord NXEventSystemDevice
   (interface :signed-long)
                                                ;  NeXT, ADB, other 
   (interface_addr :signed-long)
                                                ;  Device address on the interface 
   (dev_type :signed-long)
                                                ;  Keyboard, mouse, tablet, other 
   (id :signed-long)
                                                ;  manufacturer's device handler ID 
)
(defrecord NXEventSystemDeviceList   (dev (:array :NXEVENTSYSTEMDEVICE 16))
)
(defconstant $__OLD_NX_EVS_DEVICE_INFO 1)
; #define __OLD_NX_EVS_DEVICE_INFO		1
(defconstant $NX_EVS_DEVICE_INFO "Evs_EventDeviceInfo")
; #define NX_EVS_DEVICE_INFO			"Evs_EventDeviceInfo"
(defconstant $NX_EVS_DEVICE_INFO_COUNT 64)
; #define NX_EVS_DEVICE_INFO_COUNT 	(sizeof (NXEventSystemDeviceList) / sizeof (int))
; 
;  * Types used in evScreen protocol compliant operations.
;  

(defconstant $EVNOP 0)
(defconstant $EVHIDE 1)
(defconstant $EVSHOW 2)
(defconstant $EVMOVE 3)
(defconstant $EVLEVEL 4)
(def-mactype :EvCmd (find-mactype ':SINT32))
;  Cursor state 
(defconstant $EV_SCREEN_MIN_BRIGHTNESS 0)
; #define EV_SCREEN_MIN_BRIGHTNESS	0
(defconstant $EV_SCREEN_MAX_BRIGHTNESS 64)
; #define EV_SCREEN_MAX_BRIGHTNESS	64
;  Scale should lie between MIN_BRIGHTNESS and MAX_BRIGHTNESS 
; #define EV_SCALE_BRIGHTNESS( scale, datum ) 	((((unsigned long)(datum))*((unsigned long)scale)) >> 6)
; 
;  * Definition of a tick, as a time in milliseconds. This controls how
;  * often the event system periodic jobs are run.  All actual tick times
;  * are derived from the nanosecond timer.  These values are typically used
;  * as part of computing mouse velocity for acceleration purposes.
;  
(defconstant $EV_TICK_TIME 16)
; #define EV_TICK_TIME		16			/* 16 milliseconds */
(defconstant $EV_TICKS_PER_SEC 62)
; #define EV_TICKS_PER_SEC	(1000/EV_TICK_TIME)	/* ~ 62 Hz */
;  Mouse Button bits, as passed from an EventSrc to the Event Driver 
(defconstant $EV_RB 1)
; #define EV_RB			(0x01)
(defconstant $EV_LB 4)
; #define EV_LB			(0x04)
(defconstant $EV_MOUSEBUTTONMASK 5)
; #define EV_MOUSEBUTTONMASK	(EV_LB | EV_RB)
;  Tablet Pressure Constants, as passed from an EventSrc to the Event Driver 
(defconstant $EV_MINPRESSURE 0)
; #define EV_MINPRESSURE 0
(defconstant $EV_MAXPRESSURE 255)
; #define EV_MAXPRESSURE 255
;  Cursor size in pixels 
(defconstant $EV_CURSOR_WIDTH 16)
; #define EV_CURSOR_WIDTH		16
(defconstant $EV_CURSOR_HEIGHT 16)
; #define EV_CURSOR_HEIGHT	16
; #define kAppleOnboardGUID 	0x0610000000000000ULL

; #endif /* !_DEV_EV_TYPES_H */


(provide-interface "IOHIDTypes")