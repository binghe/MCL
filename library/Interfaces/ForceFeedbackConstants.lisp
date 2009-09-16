(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ForceFeedbackConstants.h"
; at Sunday July 2,2006 7:27:53 pm.
; -----------------------------------------------------------------------------
;       File:           ForceFeedbackConstants.h
;       Contains:       Public constants for Force Feedback technology.
;       Copyright:      © 2002-2003 by Apple Computer, Inc. All rights reserved.
; 
; -----------------------------------------------------------------------------
; #ifndef _FORCEFEEDBACKCONSTANTS_H_
; #define _FORCEFEEDBACKCONSTANTS_H_

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; !	@header		ForceFeedbackConstants.h
; 	@abstract	Constants used in the public interfaces to the Force Feedback implementation in Mac OS X.
; 	@discussion	This header file contains the Effect type UUIDs, type definitions used in the API, force feedback constants and error values used by the API.
; 
; 
; -----------------------------------------------------------------------------
;  General defines
; -----------------------------------------------------------------------------

; #if !defined( DWORD )

(def-mactype :DWORD (find-mactype ':UInt32))

(def-mactype :LPDWORD (find-mactype '(:pointer :UInt32)))

; #endif


; #if !defined( LONG )

;type name? (def-mactype :LONG (find-mactype ':SInt32))

(def-mactype :LPLONG (find-mactype '(:pointer :signed-long)))

; #endif

; !
;     @defined FF_INFINITE
; 	@discussion 
;  
(defconstant $FF_INFINITE 4294967295)
; #define FF_INFINITE                 0xFFFFFFFFUL
; !
;     @defined FF_DEGREES
; 	@discussion 
;  
(defconstant $FF_DEGREES 100)
; #define FF_DEGREES                  100
; !
;     @defined FF_FFNOMINALMAX
; 	@discussion 
;  
(defconstant $FF_FFNOMINALMAX 10000)
; #define FF_FFNOMINALMAX             10000
; !
;     @defined FF_SECONDS
; 	@discussion 
;  
(defconstant $FF_SECONDS 1000000)
; #define FF_SECONDS                  1000000
; -----------------------------------------------------------------------------
;  Effect type UUIDs
; -----------------------------------------------------------------------------
;  E559C460-C5CD-11D6-8A1C-00039353BD00
; !
;     @defined kFFEffectType_ConstantForce_ID
;     @discussion UUID for a constant force effect type
;  
; #define kFFEffectType_ConstantForce_ID CFUUIDGetConstantUUIDWithBytes(NULL, 	    0xE5, 0x59, 0xC4, 0x60, 0xC5, 0xCD, 0x11, 0xD6, 				    0x8A, 0x1C, 0x00, 0x03, 0x93, 0x53, 0xBD, 0x00)
;  E559C461-C5CD-11D6-8A1C-00039353BD00
; !
;     @defined kFFEffectType_RampForce_ID
;     @discussion UUID for a ramp force effect type
;  
; #define kFFEffectType_RampForce_ID CFUUIDGetConstantUUIDWithBytes(NULL, 	    0xE5, 0x59, 0xC4, 0x61, 0xC5, 0xCD, 0x11, 0xD6, 				    0x8A, 0x1C, 0x00, 0x03, 0x93, 0x53, 0xBD, 0x00)
;  E559C462-C5CD-11D6-8A1C-00039353BD00
; !
;     @defined kFFEffectType_Square_ID
;     @discussion UUID for a square wave effect type
;  
; #define kFFEffectType_Square_ID CFUUIDGetConstantUUIDWithBytes(NULL, 		    0xE5, 0x59, 0xC4, 0x62, 0xC5, 0xCD, 0x11, 0xD6, 				    0x8A, 0x1C, 0x00, 0x03, 0x93, 0x53, 0xBD, 0x00)
;  E559C463-C5CD-11D6-8A1C-00039353BD00
; !
;     @defined kFFEffectType_Sine_ID
;     @discussion UUID for a sine wave effect type
;  
; #define kFFEffectType_Sine_ID CFUUIDGetConstantUUIDWithBytes(NULL, 		    0xE5, 0x59, 0xC4, 0x63, 0xC5, 0xCD, 0x11, 0xD6, 				    0x8A, 0x1C, 0x00, 0x03, 0x93, 0x53, 0xBD, 0x00)
;  E559C464-C5CD-11D6-8A1C-00039353BD00
; !
;     @defined kFFEffectType_Sine_ID
;     @discussion UUID for a sine wave effect type
;  
; #define kFFEffectType_Triangle_ID CFUUIDGetConstantUUIDWithBytes(NULL, 		    0xE5, 0x59, 0xC4, 0x64, 0xC5, 0xCD, 0x11, 0xD6, 				    0x8A, 0x1C, 0x00, 0x03, 0x93, 0x53, 0xBD, 0x00)
;  E559C465-C5CD-11D6-8A1C-00039353BD00
; !
;     @defined kFFEffectType_SawtoothUp_ID
;     @discussion UUID for a upwards sawtooth wave effect type
;  
; #define kFFEffectType_SawtoothUp_ID CFUUIDGetConstantUUIDWithBytes(NULL, 	    0xE5, 0x59, 0xC4, 0x65, 0xC5, 0xCD, 0x11, 0xD6, 				    0x8A, 0x1C, 0x00, 0x03, 0x93, 0x53, 0xBD, 0x00)
;  E559C466-C5CD-11D6-8A1C-00039353BD00
; !
;     @defined kFFEffectType_SawtoothDown_ID
;     @discussion UUID for a downwards sawtooth wave effect type
;  
; #define kFFEffectType_SawtoothDown_ID CFUUIDGetConstantUUIDWithBytes(NULL, 	    0xE5, 0x59, 0xC4, 0x66, 0xC5, 0xCD, 0x11, 0xD6, 				    0x8A, 0x1C, 0x00, 0x03, 0x93, 0x53, 0xBD, 0x00)
;  E559C467-C5CD-11D6-8A1C-00039353BD00
; !
;     @defined kFFEffectType_Spring_ID
;     @discussion UUID for a spring effect type
;  
; #define kFFEffectType_Spring_ID CFUUIDGetConstantUUIDWithBytes(NULL, 		    0xE5, 0x59, 0xC4, 0x67, 0xC5, 0xCD, 0x11, 0xD6, 				    0x8A, 0x1C, 0x00, 0x03, 0x93, 0x53, 0xBD, 0x00)
;  E559C468-C5CD-11D6-8A1C-00039353BD00
; !
;     @defined kFFEffectType_Damper_ID
;     @discussion UUID for a damper effect type
;  
; #define kFFEffectType_Damper_ID CFUUIDGetConstantUUIDWithBytes(NULL, 		    0xE5, 0x59, 0xC4, 0x68, 0xC5, 0xCD, 0x11, 0xD6, 				    0x8A, 0x1C, 0x00, 0x03, 0x93, 0x53, 0xBD, 0x00)
;  E559C469-C5CD-11D6-8A1C-00039353BD00
; !
;     @defined kFFEffectType_Inertia_ID
;     @discussion UUID for an inertia effect type
;  
; #define kFFEffectType_Inertia_ID CFUUIDGetConstantUUIDWithBytes(NULL, 		    0xE5, 0x59, 0xC4, 0x69, 0xC5, 0xCD, 0x11, 0xD6, 				    0x8A, 0x1C, 0x00, 0x03, 0x93, 0x53, 0xBD, 0x00)
;  E559C46A-C5CD-11D6-8A1C-00039353BD00
; !
;     @defined kFFEffectType_Friction_ID
;     @discussion UUID for a friction effect type
;  
; #define kFFEffectType_Friction_ID CFUUIDGetConstantUUIDWithBytes(NULL, 		    0xE5, 0x59, 0xC4, 0x6A, 0xC5, 0xCD, 0x11, 0xD6, 				    0x8A, 0x1C, 0x00, 0x03, 0x93, 0x53, 0xBD, 0x00)
;  E559C46B-C5CD-11D6-8A1C-00039353BD00
; !
;     @defined kFFEffectType_CustomForce_ID
;     @discussion UUID for a custom force effect type
;  
; #define kFFEffectType_CustomForce_ID CFUUIDGetConstantUUIDWithBytes(NULL, 	    0xE5, 0x59, 0xC4, 0x6B, 0xC5, 0xCD, 0x11, 0xD6, 				    0x8A, 0x1C, 0x00, 0x03, 0x93, 0x53, 0xBD, 0x00)
; -----------------------------------------------------------------------------
;  Effect definition constants
; -----------------------------------------------------------------------------
; !
;     @defined FFEFF_OBJECTOFFSETS
; 	@discussion OBJECT IDS cannot be used to identify trigger buttons in FFEFFECT.dwTriggerButton, and output axes in FFEFFECT.rgdwAxes[n]. Please use object offsets (FFJOFS_* constants), the only supported method.
;  
(defconstant $FFEFF_OBJECTOFFSETS 2)
; #define FFEFF_OBJECTOFFSETS         0x00000002UL
; !
;     @enum FFCoordinateSystemFlag
;     @discussion Different coordinates used by the Force Feedback framework.
;     @constant FFEFF_CARTESIAN Cartesian coordinates
;     @constant FFEFF_POLAR Polar coordinates
;     @constant FFEFF_SPHERICAL Sperical coordinates
;     

(def-mactype :FFCoordinateSystemFlag (find-mactype ':UInt32))

(defconstant $FFEFF_CARTESIAN 16)
(defconstant $FFEFF_POLAR 32)
(defconstant $FFEFF_SPHERICAL 64)
; !
;     @enum FFEffectParameterFlag
;     @discussion Effect Parameter flags for use in calls to <b>FFEffectGetParameters()</b> and <b>FFEffectSetParameters()</b>.
;     

(def-mactype :FFEffectParameterFlag (find-mactype ':UInt32))

(defconstant $FFEP_DURATION 1)
(defconstant $FFEP_SAMPLEPERIOD 2)
(defconstant $FFEP_GAIN 4)
(defconstant $FFEP_TRIGGERBUTTON 8)
(defconstant $FFEP_TRIGGERREPEATINTERVAL 16)
(defconstant $FFEP_AXES 32)
(defconstant $FFEP_DIRECTION 64)
(defconstant $FFEP_ENVELOPE #x80)
(defconstant $FFEP_TYPESPECIFICPARAMS #x100)
(defconstant $FFEP_STARTDELAY #x200)
(defconstant $FFEP_ALLPARAMS #x3FF)
(defconstant $FFEP_START #x20000000)
(defconstant $FFEP_NORESTART #x40000000)
(defconstant $FFEP_NODOWNLOAD #x80000000)
(defconstant $FFEB_NOTRIGGER #xFFFFFFFF)
; !
;     @enum FFEffectStartFlag
;     @discussion Effect Parameter flags for use in calls to <b>FFEffectStart()</b>.
;     

(def-mactype :FFEffectStartFlag (find-mactype ':UInt32))

(defconstant $FFES_SOLO 1)
(defconstant $FFES_NODOWNLOAD #x80000000)
; !
;     @enum FFEffectStatusFlag
;     @discussion Effect Parameter flags for use in calls to <b>FFEffectGetEffectStatus()</b>.
;     

(def-mactype :FFEffectStatusFlag (find-mactype ':UInt32))

(defconstant $FFEGES_NOTPLAYING 0)
(defconstant $FFEGES_PLAYING 1)
(defconstant $FFEGES_EMULATED 2)
; !
;     @enum FFCommandFlag
;     @discussion Command flags for <b>FFDeviceSendForceFeedbackCommand()</b>.
;     

(def-mactype :FFCommandFlag (find-mactype ':UInt32))

(defconstant $FFSFFC_RESET 1)
(defconstant $FFSFFC_STOPALL 2)
(defconstant $FFSFFC_PAUSE 4)
(defconstant $FFSFFC_CONTINUE 8)
(defconstant $FFSFFC_SETACTUATORSON 16)
(defconstant $FFSFFC_SETACTUATORSOFF 32)
; !
;     @enum FFState
;     @discussion Device state flags returned by <b>FFDeviceGetForceFeedbackState()</b>.
;     

(def-mactype :FFState (find-mactype ':UInt32))

(defconstant $FFGFFS_EMPTY 1)
(defconstant $FFGFFS_STOPPED 2)
(defconstant $FFGFFS_PAUSED 4)
(defconstant $FFGFFS_ACTUATORSON 16)
(defconstant $FFGFFS_ACTUATORSOFF 32)
(defconstant $FFGFFS_POWERON 64)
(defconstant $FFGFFS_POWEROFF #x80)
(defconstant $FFGFFS_SAFETYSWITCHON #x100)
(defconstant $FFGFFS_SAFETYSWITCHOFF #x200)
(defconstant $FFGFFS_USERFFSWITCHON #x400)
(defconstant $FFGFFS_USERFFSWITCHOFF #x800)
(defconstant $FFGFFS_DEVICELOST #x80000000)
; !
;     @defined FFJOFS_<i>i</i>
;     @discussion Axis and Button field offsets, used in <b>FFEFFECT.dwTriggerButton</b> and <b>FFEFFECT.rgdwAxes[<i>n</i>]</b>.
; 
(defconstant $FFJOFS_X 0)
; #define FFJOFS_X            0
(defconstant $FFJOFS_Y 4)
; #define FFJOFS_Y            4
(defconstant $FFJOFS_Z 8)
; #define FFJOFS_Z            8
(defconstant $FFJOFS_RX 12)
; #define FFJOFS_RX           12
(defconstant $FFJOFS_RY 16)
; #define FFJOFS_RY           16
(defconstant $FFJOFS_RZ 20)
; #define FFJOFS_RZ           20
; #define FFJOFS_SLIDER(n)   (24 + (n) * sizeof(LONG))
; #define FFJOFS_POV(n)      (32 + (n) * sizeof(DWORD))
; #define FFJOFS_BUTTON(n)   (48 + (n))
; #define FFJOFS_BUTTON0      FFJOFS_BUTTON(0)
; #define FFJOFS_BUTTON1      FFJOFS_BUTTON(1)
; #define FFJOFS_BUTTON2      FFJOFS_BUTTON(2)
; #define FFJOFS_BUTTON3      FFJOFS_BUTTON(3)
; #define FFJOFS_BUTTON4      FFJOFS_BUTTON(4)
; #define FFJOFS_BUTTON5      FFJOFS_BUTTON(5)
; #define FFJOFS_BUTTON6      FFJOFS_BUTTON(6)
; #define FFJOFS_BUTTON7      FFJOFS_BUTTON(7)
; #define FFJOFS_BUTTON8      FFJOFS_BUTTON(8)
; #define FFJOFS_BUTTON9      FFJOFS_BUTTON(9)
; #define FFJOFS_BUTTON10     FFJOFS_BUTTON(10)
; #define FFJOFS_BUTTON11     FFJOFS_BUTTON(11)
; #define FFJOFS_BUTTON12     FFJOFS_BUTTON(12)
; #define FFJOFS_BUTTON13     FFJOFS_BUTTON(13)
; #define FFJOFS_BUTTON14     FFJOFS_BUTTON(14)
; #define FFJOFS_BUTTON15     FFJOFS_BUTTON(15)
; #define FFJOFS_BUTTON16     FFJOFS_BUTTON(16)
; #define FFJOFS_BUTTON17     FFJOFS_BUTTON(17)
; #define FFJOFS_BUTTON18     FFJOFS_BUTTON(18)
; #define FFJOFS_BUTTON19     FFJOFS_BUTTON(19)
; #define FFJOFS_BUTTON20     FFJOFS_BUTTON(20)
; #define FFJOFS_BUTTON21     FFJOFS_BUTTON(21)
; #define FFJOFS_BUTTON22     FFJOFS_BUTTON(22)
; #define FFJOFS_BUTTON23     FFJOFS_BUTTON(23)
; #define FFJOFS_BUTTON24     FFJOFS_BUTTON(24)
; #define FFJOFS_BUTTON25     FFJOFS_BUTTON(25)
; #define FFJOFS_BUTTON26     FFJOFS_BUTTON(26)
; #define FFJOFS_BUTTON27     FFJOFS_BUTTON(27)
; #define FFJOFS_BUTTON28     FFJOFS_BUTTON(28)
; #define FFJOFS_BUTTON29     FFJOFS_BUTTON(29)
; #define FFJOFS_BUTTON30     FFJOFS_BUTTON(30)
; #define FFJOFS_BUTTON31     FFJOFS_BUTTON(31)
; !
;     @enum FFProperty
;     @discussion Used for <b>FFDeviceGetForceFeedbackProperty()</b> and <b>FFDeviceSetForceFeedbackProperty()</b>.
;     

(def-mactype :FFProperty (find-mactype ':UInt32))

(defconstant $FFPROP_FFGAIN $1ul)
(defconstant $FFPROP_AUTOCENTER $3ul)
; !
;     @enum FFCooperativeLevelFlag
;     @discussion flags for <b>FFDeviceSetCooperativeLevel()</b>.
;     

(def-mactype :FFCooperativeLevelFlag (find-mactype ':UInt32))

(defconstant $FFSCL_EXCLUSIVE 1)
(defconstant $FFSCL_NONEXCLUSIVE 2)
(defconstant $FFSCL_FOREGROUND 4)
(defconstant $FFSCL_BACKGROUND 8)
; !
; @enum FFCapabilitiesEffectType
;  @discussion Types used in the emulatedEffects or supportedEffects members of the FFCAPABILITIES structure.  Used to describe whether the particular effect type is supported or emulated by the device.
;  @constant FFCAP_ET_CONSTANTFORCE The effect represents a constant force effect.
;  @constant FFCAP_ET_RAMPFORCE The effect represents a ramp force effect.
;  @constant FFCAP_ET_SQUARE The effect represents a square force effect.
;  @constant FFCAP_ET_SINE The effect represents a sine force effect.
;  @constant FFCAP_ET_TRIANGLE The effect represents a triangle force effect.
;  @constant FFCAP_ET_SAWTOOTHUP The effect represents a sawtooth up force effect.
;  @constant FFCAP_ET_SAWTOOTHDOWN The effect represents a sawtooth down force effect.
;  @constant FFCAP_ET_SPRING The effect represents a spring force effect.
;  @constant FFCAP_ET_DAMPER The effect represents a damper force effect.
;  @constant FFCAP_ET_INERTIA The effect represents a inertia force effect.
;  @constant FFCAP_ET_FRICTION The effect represents a friction force effect.
;  @constant FFCAP_ET_CUSTOMFORCE The effect represents a custom force effect. The Force Feedback plugIn developer is required to provide additional documentation to the application writer on how the effect should be used.
;  

(def-mactype :FFCapabilitiesEffectType (find-mactype ':UInt32))

(defconstant $FFCAP_ET_CONSTANTFORCE 1)
(defconstant $FFCAP_ET_RAMPFORCE 2)
(defconstant $FFCAP_ET_SQUARE 4)
(defconstant $FFCAP_ET_SINE 8)
(defconstant $FFCAP_ET_TRIANGLE 16)
(defconstant $FFCAP_ET_SAWTOOTHUP 32)
(defconstant $FFCAP_ET_SAWTOOTHDOWN 64)
(defconstant $FFCAP_ET_SPRING #x80)
(defconstant $FFCAP_ET_DAMPER #x100)
(defconstant $FFCAP_ET_INERTIA #x200)
(defconstant $FFCAP_ET_FRICTION #x400)
(defconstant $FFCAP_ET_CUSTOMFORCE #x800)
; !
;     @enum FFCapabilitiesEffectSubType
;     @discussion Flags used to specify the subtype of an effect.
;     

(def-mactype :FFCapabilitiesEffectSubType (find-mactype ':UInt32))

(defconstant $FFCAP_ST_KINESTHETIC 1)
(defconstant $FFCAP_ST_VIBRATION 2)
; -----------------------------------------------------------------------------
;  Error return values
; -----------------------------------------------------------------------------
; !
;     @defined FF_OK
;     @discussion The operation completed successfully.
; 
; #define FF_OK                           S_OK
; !
;     @defined FF_FALSE
;     @discussion The operation did not complete successfully.
; 
; #define FF_FALSE                           S_FALSE
; !
;     @defined FF_DOWNLOADSKIPPED
;  *  @discussion 
;  *  The parameters of the effect were successfully updated by
;  *  FFEffectSetParameters, but the effect was not
;  *  downloaded because the FFEP_NODOWNLOAD flag was passed.
;  
(defconstant $FF_DOWNLOADSKIPPED 3)
; #define FF_DOWNLOADSKIPPED              ((HRESULT)0x00000003L)
; !
;     @defined FF_EFFECTRESTARTED
;  *  @discussion 
;  *  The parameters of the effect were successfully updated by
;  *  FFEffectSetParameters, but in order to change
;  *  the parameters, the effect needed to be restarted.
;  
(defconstant $FF_EFFECTRESTARTED 4)
; #define FF_EFFECTRESTARTED              ((HRESULT)0x00000004L)
; !
;     @defined FF_TRUNCATED
;  *  @discussion 
;  *  The parameters of the effect were successfully updated by
;  *  FFEffectSetParameters, but some of them were
;  *  beyond the capabilities of the device and were truncated.
;  
(defconstant $FF_TRUNCATED 8)
; #define FF_TRUNCATED                    ((HRESULT)0x00000008L)
; !
;     @defined FF_TRUNCATEDANDRESTARTED
;  *  @discussion 
;  *  Equal to FF_EFFECTRESTARTED | FF_TRUNCATED.
;  
(defconstant $FF_TRUNCATEDANDRESTARTED 12)
; #define FF_TRUNCATEDANDRESTARTED        ((HRESULT)0x0000000CL)
; !
;     @defined FFERR_DEVICENOTREG
;  *  @discussion 
;  * The device or device instance or effect is not registered.
;  
; #define FFERR_DEVICENOTREG              REGDB_E_CLASSNOTREG
; !
;     @defined FFERR_INVALIDPARAM
;  *  @discussion 
;  * An invalid parameter was passed to the returning function,
;  * or the object was not in a state that admitted the function
;  * to be called.
;  
; #define FFERR_INVALIDPARAM              E_INVALIDARG
; !
;     @defined FFERR_NOINTERFACE
;  *  @discussion 
;  * The specified interface is not supported by the object
;  
; #define FFERR_NOINTERFACE               E_NOINTERFACE
; !
;     @defined FFERR_GENERIC
;  *  @discussion 
;  * An undetermined error occurred.
;  
; #define FFERR_GENERIC                   E_FAIL
; !
;     @defined FFERR_OUTOFMEMORY
;  *  @discussion 
;  * Couldn't allocate sufficient memory to complete the caller's request.
;  
; #define FFERR_OUTOFMEMORY               E_OUTOFMEMORY
; !
;     @defined FFERR_UNSUPPORTED
;  *  @discussion 
;  * The function called is not supported at this time
;  
; #define FFERR_UNSUPPORTED               E_NOTIMPL
; #ifndef E_PENDING
; !
;     @defined E_PENDING
;  *  @discussion 
;  * Data is not yet available.
;  
(defconstant $E_PENDING 2147483658)
; #define E_PENDING                       0x8000000AL

; #endif

; !
;     @defined FFERR_DEVICEFULL
;  *  @discussion 
;  * The device is full.
;  
(defconstant $FFERR_DEVICEFULL 2147746305)
; #define FFERR_DEVICEFULL                0x80040201L
; !
;     @defined FFERR_MOREDATA
;  *  @discussion 
;  * Not all the requested information fit into the buffer.
;  
(defconstant $FFERR_MOREDATA 2147746306)
; #define FFERR_MOREDATA                  0x80040202L
; !
;     @defined FFERR_NOTDOWNLOADED
;  *  @discussion 
;  * The effect is not downloaded.
;  
(defconstant $FFERR_NOTDOWNLOADED 2147746307)
; #define FFERR_NOTDOWNLOADED             0x80040203L
; !
;     @defined FFERR_HASEFFECTS
;  *  @discussion 
;  *  The device cannot be reinitialized because there are still effects
;  *  attached to it.
;  
(defconstant $FFERR_HASEFFECTS 2147746308)
; #define FFERR_HASEFFECTS                0x80040204L
; !
;     @defined FFERR_INCOMPLETEEFFECT
;  *  @discussion 
;  *  The effect could not be downloaded because essential information
;  *  is missing.  For example, no axes have been associated with the
;  *  effect, or no type-specific information has been created.
;  
(defconstant $FFERR_INCOMPLETEEFFECT 2147746310)
; #define FFERR_INCOMPLETEEFFECT          0x80040206L
; !
;     @defined FFERR_EFFECTPLAYING
;  *  @discussion 
;  *  An attempt was made to modify parameters of an effect while it is
;  *  playing.  Not all hardware devices support altering the parameters
;  *  of an effect while it is playing.
;  
(defconstant $FFERR_EFFECTPLAYING 2147746312)
; #define FFERR_EFFECTPLAYING             0x80040208L
; !
;     @defined FFERR_UNPLUGGED
;  *  @discussion 
;  *  The operation could not be completed because the device is not
;  *  plugged in.
;  
(defconstant $FFERR_UNPLUGGED 2147746313)
; #define FFERR_UNPLUGGED                 0x80040209L
; 
;  Mac OS X specific
; 
; !
;     @defined FFERR_INVALIDDOWNLOADID
;  *  @discussion 
;  * The effect index provided by the API in downloadID is not recognized by the
;  * IOForceFeedbackLib driver.
;  
(defconstant $FFERR_INVALIDDOWNLOADID 2147746560)
; #define FFERR_INVALIDDOWNLOADID         0x80040300L
; !
;     @defined FFERR_DEVICEPAUSED
;  *  @discussion 
;  * When the device is paused via a call to FFDeviceSendForceFeedbackCommand(),
;  * other operations such as modifying existing effect parameters and creating 
;  * new effects are not allowed.
;  
(defconstant $FFERR_DEVICEPAUSED 2147746561)
; #define FFERR_DEVICEPAUSED              0x80040301L
; !
;     @defined FFERR_INTERNAL
;  *  @discussion 
;  * The IOForceFededbackLib driver has detected an internal fault.  Often this
;  * occurs because of an unexpected internal code path.
;  
(defconstant $FFERR_INTERNAL 2147746562)
; #define FFERR_INTERNAL                  0x80040302L
; !
;     @defined FFERR_EFFECTTYPEMISMATCH
;  *  @discussion 
;  * The IOForceFededbackLib driver has received an effect modification request
;  * whose basic type does not match the defined effect type for the given effect.
;  
(defconstant $FFERR_EFFECTTYPEMISMATCH 2147746563)
; #define FFERR_EFFECTTYPEMISMATCH        0x80040303L
; !
;     @defined FFERR_UNSUPPORTEDAXIS
;  *  @discussion 
;  * The effect includes one or more axes that the device does not support.
;  
(defconstant $FFERR_UNSUPPORTEDAXIS 2147746564)
; #define FFERR_UNSUPPORTEDAXIS           0x80040304L
; !
;     @defined FFERR_NOTINITIALIZED
;  *  @discussion 
;  * This object has not been initialized
;  
(defconstant $FFERR_NOTINITIALIZED 2147746565)
; #define FFERR_NOTINITIALIZED            0x80040305L
; !
;     @defined FFERR_EFFECTTYPENOTSUPPORTED
;  *  @discussion 
;  * The effect type requested is not explicitly supported by the particular device.
;  
(defconstant $FFERR_EFFECTTYPENOTSUPPORTED 2147746566)
; #define FFERR_EFFECTTYPENOTSUPPORTED    0x80040306L
; !
;     @defined FFERR_DEVICERELEASED
;  *  @discussion 
;  * The device has been released.
;  
(defconstant $FFERR_DEVICERELEASED 2147746567)
; #define FFERR_DEVICERELEASED            0x80040307L
; #ifdef __cplusplus
#| #|
}       
#endif
|#
 |#

; #endif // _FORCEFEEDBACKCONSTANTS_H_


(provide-interface "ForceFeedbackConstants")