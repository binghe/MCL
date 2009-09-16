(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IOHIDParameter.h"
; at Sunday July 2,2006 7:29:18 pm.
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
;  	Copyright (c) 1992 NeXT Computer, Inc.  All rights reserved. 
;  *
;  * evsio.h - Get/Set parameter calls for Event Status Driver.
;  *
;  *	CAUTION: Developers should stick to the API exported in
;  *		<drivers/event_status_driver.h> to guarantee
;  *		binary compatability of their applications in future
;  *		releases.
;  *
;  * HISTORY
;  * 22 May 1992    Mike Paquette at NeXT
;  *      Created. 
;  
; #ifndef _DEV_EVSIO_H
; #define _DEV_EVSIO_H
;  Public type definitions. 

(require-interface "IOKit/hidsystem/IOHIDTypes")

(require-interface "IOKit/hidsystem/IOLLEvent")
; 
;  * Identify this driver as one that uses the new driverkit and messaging API
;  
; #ifndef _NeXT_MACH_EVENT_DRIVER_
(defconstant $_NeXT_MACH_EVENT_DRIVER_ 1)
; #define _NeXT_MACH_EVENT_DRIVER_	(1)

; #endif /* !_NeXT_MACH_EVENT_DRIVER_ */

;  * 
(defconstant $kIOHIDKindKey "HIDKind")
; #define kIOHIDKindKey					"HIDKind"
(defconstant $kIOHIDInterfaceIDKey "HIDInterfaceID")
; #define kIOHIDInterfaceIDKey			"HIDInterfaceID"
(defconstant $kIOHIDSubinterfaceIDKey "HIDSubinterfaceID")
; #define kIOHIDSubinterfaceIDKey			"HIDSubinterfaceID"
(defconstant $kIOHIDParametersKey "HIDParameters")
; #define kIOHIDParametersKey				"HIDParameters"
(defconstant $kIOHIDKeyRepeatKey "HIDKeyRepeat")
; #define kIOHIDKeyRepeatKey				"HIDKeyRepeat"
(defconstant $kIOHIDInitialKeyRepeatKey "HIDInitialKeyRepeat")
; #define kIOHIDInitialKeyRepeatKey		"HIDInitialKeyRepeat"
(defconstant $kIOHIDKeyMappingKey "HIDKeyMapping")
; #define kIOHIDKeyMappingKey				"HIDKeyMapping"
(defconstant $kIOHIDResetKeyboardKey "HIDResetKeyboard")
; #define kIOHIDResetKeyboardKey			"HIDResetKeyboard"
(defconstant $kIOHIDKeyboardSwapCommandAltKey "HIDKeyboardSwapCommandAlt")
; #define kIOHIDKeyboardSwapCommandAltKey		"HIDKeyboardSwapCommandAlt"
(defconstant $kIOHIDKeyboardSwapControlCapsLockKey "HIDKeyboardSwapControlCapsLock")
; #define kIOHIDKeyboardSwapControlCapsLockKey	"HIDKeyboardSwapControlCapsLock"
(defconstant $kIOHIDKeyboardCapsLockDoesLockKey "HIDKeyboardCapsLockDoesLock")
; #define kIOHIDKeyboardCapsLockDoesLockKey	"HIDKeyboardCapsLockDoesLock"
(defconstant $kIOHIDKeyboardSupportsF12EjectKey "HIDKeyboardSupportsF12Eject")
; #define kIOHIDKeyboardSupportsF12EjectKey	"HIDKeyboardSupportsF12Eject"
(defconstant $kIOHIDKeyboardSupportedModifiersKey "HIDKeyboardSupportedModifiers")
; #define kIOHIDKeyboardSupportedModifiersKey   "HIDKeyboardSupportedModifiers"
(defconstant $kIOHIDPointerResolutionKey "HIDPointerResolution")
; #define kIOHIDPointerResolutionKey		"HIDPointerResolution"
(defconstant $kIOHIDResetPointerKey "HIDResetPointer")
; #define kIOHIDResetPointerKey			"HIDResetPointer"
(defconstant $kIOHIDPointerConvertAbsoluteKey "HIDPointerConvertAbsolute")
; #define kIOHIDPointerConvertAbsoluteKey	"HIDPointerConvertAbsolute"
(defconstant $kIOHIDPointerContactToMoveKey "HIDPointerContactToMove")
; #define kIOHIDPointerContactToMoveKey	"HIDPointerContactToMove"
(defconstant $kIOHIDPointerPressureToClickKey "HIDPointerPressureToClick")
; #define kIOHIDPointerPressureToClickKey	"HIDPointerPressureToClick"
(defconstant $kIOHIDPointerButtonMode "HIDPointerButtonMode")
; #define kIOHIDPointerButtonMode			"HIDPointerButtonMode"
(defconstant $kIOHIDPointerButtonCountKey "HIDPointerButtonCount")
; #define kIOHIDPointerButtonCountKey	"HIDPointerButtonCount"
(defconstant $kIOHIDPointerAccelerationKey "HIDPointerAcceleration")
; #define kIOHIDPointerAccelerationKey	"HIDPointerAcceleration"
(defconstant $kIOHIDPointerAccelerationSettingsKey "HIDPointerAccelerationSettings")
; #define kIOHIDPointerAccelerationSettingsKey	"HIDPointerAccelerationSettings"
(defconstant $kIOHIDPointerAccelerationTypeKey "HIDPointerAccelerationType")
; #define kIOHIDPointerAccelerationTypeKey	"HIDPointerAccelerationType"
(defconstant $kIOHIDPointerAccelerationTableKey "HIDPointerAccelerationTable")
; #define kIOHIDPointerAccelerationTableKey  "HIDPointerAccelerationTable"
(defconstant $kIOHIDScrollResetKey "HIDScrollReset")
; #define kIOHIDScrollResetKey			"HIDScrollReset"
(defconstant $kIOHIDScrollResolutionKey "HIDScrollResolution")
; #define kIOHIDScrollResolutionKey		"HIDScrollResolution"
(defconstant $kIOHIDScrollAccelerationKey "HIDScrollAcceleration")
; #define kIOHIDScrollAccelerationKey		"HIDScrollAcceleration"
(defconstant $kIOHIDScrollAccelerationTableKey "HIDScrollAccelerationTable")
; #define kIOHIDScrollAccelerationTableKey	"HIDScrollAccelerationTable"
(defconstant $kIOHIDTrackpadAccelerationType "HIDTrackpadAcceleration")
; #define kIOHIDTrackpadAccelerationType	"HIDTrackpadAcceleration"
(defconstant $kIOHIDMouseAccelerationType "HIDMouseAcceleration")
; #define kIOHIDMouseAccelerationType		"HIDMouseAcceleration"
(defconstant $kIOHIDClickTimeKey "HIDClickTime")
; #define kIOHIDClickTimeKey				"HIDClickTime"
(defconstant $kIOHIDClickSpaceKey "HIDClickSpace")
; #define kIOHIDClickSpaceKey				"HIDClickSpace"
(defconstant $kIOHIDWaitCursorFrameIntervalKey "HIDWaitCursorFrameInterval")
; #define kIOHIDWaitCursorFrameIntervalKey	"HIDWaitCursorFrameInterval"
(defconstant $kIOHIDAutoDimThresholdKey "HIDAutoDimThreshold")
; #define kIOHIDAutoDimThresholdKey		"HIDAutoDimThreshold"
(defconstant $kIOHIDAutoDimStateKey "HIDAutoDimState")
; #define kIOHIDAutoDimStateKey			"HIDAutoDimState"
(defconstant $kIOHIDAutoDimTimeKey "HIDAutoDimTime")
; #define kIOHIDAutoDimTimeKey			"HIDAutoDimTime"
(defconstant $kIOHIDIdleTimeKey "HIDIdleTime")
; #define kIOHIDIdleTimeKey				"HIDIdleTime"
(defconstant $kIOHIDBrightnessKey "HIDBrightness")
; #define kIOHIDBrightnessKey				"HIDBrightness"
(defconstant $kIOHIDAutoDimBrightnessKey "HIDAutoDimBrightness")
; #define kIOHIDAutoDimBrightnessKey		"HIDAutoDimBrightness"
(defconstant $kIOHIDFKeyModeKey "HIDFKeyMode")
; #define kIOHIDFKeyModeKey			"HIDFKeyMode"
;  if kIOHIDStickyKeysDisabledKey is 1, then all sticky keys functionality
;  is completely turned off. Multiple shifts will have no effect.
(defconstant $kIOHIDStickyKeysDisabledKey "HIDStickyKeysDisabled")
; #define kIOHIDStickyKeysDisabledKey		"HIDStickyKeysDisabled"
;  if kIOHIDStickyKeysOnKey is 1 then a depressed modifier will stay down
;  until a non-modifer key is pressed (or sticky keys is turned off)
(defconstant $kIOHIDStickyKeysOnKey "HIDStickyKeysOn")
; #define kIOHIDStickyKeysOnKey			"HIDStickyKeysOn"
;  if kIOHIDStickyKeysShiftTogglesKey is 1, then a sequence of five
;  shift keys in sequence will toggle sticky keys on or off
(defconstant $kIOHIDStickyKeysShiftTogglesKey "HIDStickyKeysShiftToggles")
; #define kIOHIDStickyKeysShiftTogglesKey	"HIDStickyKeysShiftToggles"
;  if kIOHIDMouseKeysOptionTogglesKey is 1, then a sequence of five
;  option keys in sequence will toggle mouse keys on or off
(defconstant $kIOHIDMouseKeysOptionTogglesKey "HIDMouseKeysOptionToggles")
; #define kIOHIDMouseKeysOptionTogglesKey	"HIDMouseKeysOptionToggles"
;  kIOHIDSlowKeysDelayKey represents the delay used for slow keys.
;  if kIOHIDSlowKeysDelayKey is 0, then slow keys off
(defconstant $kIOHIDSlowKeysDelayKey "HIDSlowKeysDelay")
; #define kIOHIDSlowKeysDelayKey			"HIDSlowKeysDelay"
(defconstant $kIOHIDF12EjectDelayKey "HIDF12EjectDelay")
; #define kIOHIDF12EjectDelayKey			"HIDF12EjectDelay"
(defconstant $kIOHIDMouseKeysOnKey "HIDMouseKeysOn")
; #define kIOHIDMouseKeysOnKey			"HIDMouseKeysOn"
;  the following are misspelled keys present in the system
;  they are being kept around, but will eventually be deprecated
(defconstant $kIOHIDSickyKeysDisabledKey "HIDStickyKeysDisabled")
; #define kIOHIDSickyKeysDisabledKey		"HIDStickyKeysDisabled"
(defconstant $kIOHIDSickyKeysOnKey "HIDStickyKeysOn")
; #define kIOHIDSickyKeysOnKey			"HIDStickyKeysOn"
(defconstant $kIOHIDSickyKeysShiftTogglesKey "HIDStickyKeysShiftToggles")
; #define kIOHIDSickyKeysShiftTogglesKey	"HIDStickyKeysShiftToggles"
;  the following values are used in kIOHIDPointerButtonMode

(defconstant $kIOHIDButtonMode_BothLeftClicks 0)
(defconstant $kIOHIDButtonMode_ReverseLeftRightClicks 1)
(defconstant $kIOHIDButtonMode_EnableRightClick 2)
(def-mactype :IOHIDButtonModes (find-mactype ':SINT32))
; #ifdef _undef
#| #|
#define EVS_PREFIX	"Evs_"	



#define EVSIOSWT "Evs_SetWaitThreshold"
#define EVSIOSWT_SIZE	EVS_PACKED_TIME_SIZE

#define EVSIOSWS "Evs_SetWaitSustain"
#define EVSIOSWS_SIZE	EVS_PACKED_TIME_SIZE

#define EVSIOSWFI "Evs_SetWaitFrameInterval"
#define EVSIOSWFI_SIZE	EVS_PACKED_TIME_SIZE

#define EVSIOCWINFO	"Evs_CurrentWaitCursorInfo"
#define EVSIOCWINFO_THRESH	0
#define EVSIOCWINFO_SUSTAIN	(EVSIOCWINFO_THRESH + EVS_PACKED_TIME_SIZE)
#define EVSIOCWINFO_FINTERVAL	(EVSIOCWINFO_SUSTAIN + EVS_PACKED_TIME_SIZE)
#define EVSIOCWINFO_SIZE	(EVSIOCWINFO_FINTERVAL + EVS_PACKED_TIME_SIZE)
#endif
|#
 |#
(defconstant $EVS_PACKED_TIME_SIZE 2)
; #define EVS_PACKED_TIME_SIZE (sizeof(UInt64) / sizeof( unsigned int))
;  Device control ioctls. Levels specified may be in the range 0 - 64. 
; #define EVSIOSB	  	kIOHIDBrightnessKey
(defconstant $EVSIOSB_SIZE 1)
; #define EVSIOSB_SIZE	1
; #define EVSIOSADB 	kIOHIDAutoDimBrightnessKey
(defconstant $EVSIOSADB_SIZE 1)
; #define EVSIOSADB_SIZE	1
; #ifdef _undef
#| #|
#define EVSIOSA	  "Evs_SetAttenuation"
#define EVIOSA_SIZE	1

#define EVSIO_DCTLINFO	"Evs_DeviceControlInfo"
typedef enum {
	EVSIO_DCTLINFO_BRIGHT,
	EVSIO_DCTLINFO_ATTEN,
	EVSIO_DCTLINFO_AUTODIMBRIGHT
} evsio_DCTLINFOIndices;
#define EVSIO_DCTLINFO_SIZE	(EVSIO_DCTLINFO_AUTODIMBRIGHT + 1)
#endif
|#
 |#
; 
;  * Device status request
;  
; #define	EVSIOINFO  NX_EVS_DEVICE_INFO
;  Keyboard-related ioctls - implemented within Event Sources 
; #define EVSIOSKR  	kIOHIDKeyRepeatKey
; #define EVSIOSKR_SIZE	EVS_PACKED_TIME_SIZE
; #define EVSIOSIKR 	kIOHIDInitialKeyRepeatKey
; #define EVSIOSIKR_SIZE	EVS_PACKED_TIME_SIZE
; #define EVSIORKBD 	kIOHIDResetKeyboardKey
(defconstant $EVSIORKBD_SIZE 1)
; #define EVSIORKBD_SIZE	1
; #define EVSIOCKR_SIZE	EVS_PACKED_TIME_SIZE
; #define	EVSIOCKML 	kIOHIDKeyMappingKey
(defconstant $EVSIOCKML_SIZE 1)
; #define EVSIOCKML_SIZE	1
;  The following two tokens are for use with the get/set character routines. 
; #define EVSIOSKM  	kIOHIDKeyMappingKey
(defconstant $EVSIOSKM_SIZE 4096)
; #define EVSIOSKM_SIZE	4096
; #define	EVSIOCKM  	kIOHIDKeyMappingKey
(defconstant $EVSIOCKM_SIZE 4096)
; #define EVSIOCKM_SIZE	4096
;  Mouse-related ioctls - implemented within Event Sources 
; #define	EVSIOSMS  	kIOHIDPointerAccelerationKey
(defconstant $EVSIOSMS_SIZE 1)
; #define	EVSIOSMS_SIZE		(1)
; #define	EVSIOCMS  	kIOHIDPointerAccelerationKey
(defconstant $EVSIOCMS_SIZE 1)
; #define	EVSIOCMS_SIZE		(1)
; #ifdef _undef
#| #|
#define EVSIOSMH  "Evs_SetMouseHandedness"
#define EVSIOSMH_SIZE	1		
#define EVSIOCMH  "Evs_CurrentMouseHandedness"
#define EVSIOCMH_SIZE	1
#endif
|#
 |#
;  Generic pointer device controls, implemented by the Event Driver. 
; #define	EVSIOSCT  	kIOHIDClickTimeKey
; #define EVSIOSCT_SIZE	EVS_PACKED_TIME_SIZE
; #define	EVSIOSCS  	kIOHIDClickSpaceKey

(defconstant $EVSIOSCS_X 0)
(defconstant $EVSIOSCS_Y 1)
(def-mactype :evsioEVSIOSCSIndices (find-mactype ':SINT32))
(defconstant $EVSIOSCS_SIZE 2)
; #define EVSIOSCS_SIZE	(EVSIOSCS_Y + 1)
; #define EVSIOSADT	 kIOHIDAutoDimThresholdKey
; #define EVSIOSADT_SIZE	EVS_PACKED_TIME_SIZE
; #define EVSIOSADS 	kIOHIDAutoDimStateKey
(defconstant $EVSIOSADS_SIZE 1)
; #define EVSIOSADS_SIZE	1
; #define EVSIORMS  	kIOHIDResetPointerKey
(defconstant $EVSIORMS_SIZE 1)
; #define EVSIORMS_SIZE	1
; #define	EVSIOCCT  	kIOHIDClickTimeKey
; #define EVSIOCCT_SIZE	EVS_PACKED_TIME_SIZE
; #define EVSIOCADT 	kIOHIDAutoDimThresholdKey
; #define EVSIOCADT_SIZE	EVS_PACKED_TIME_SIZE
; #define EVSIOGDADT 	kIOHIDAutoDimTimeKey
; #define EVSIOGDADT_SIZE	EVS_PACKED_TIME_SIZE
; #define EVSIOIDLE 	kIOHIDIdleTimeKey
; #define EVSIOIDLE_SIZE	EVS_PACKED_TIME_SIZE
; #define	EVSIOCCS  	kIOHIDClickSpaceKey

(defconstant $EVSIOCCS_X 0)
(defconstant $EVSIOCCS_Y 1)
(def-mactype :evsioEVSIOCCSIndices (find-mactype ':SINT32))
(defconstant $EVSIOCCS_SIZE 2)
; #define EVSIOCCS_SIZE	(EVSIOCCS_Y + 1)
; #define EVSIOCADS 	kIOHIDAutoDimStateKey
(defconstant $EVSIOCADS_SIZE 1)
; #define EVSIOCADS_SIZE	1

; #endif /* !_DEV_EVSIO_H */


(provide-interface "IOHIDParameter")