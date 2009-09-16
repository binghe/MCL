(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:QuickTimeVR.h"
; at Sunday July 2,2006 7:31:23 pm.
; 
;      File:       QuickTime/QuickTimeVR.h
;  
;      Contains:   QuickTime VR interfaces
;  
;      Version:    QuickTime_6
;  
;      Copyright:  © 1997-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __QUICKTIMEVR__
; #define __QUICKTIMEVR__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __MOVIES__
#| #|
#include <QuickTimeMovies.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

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
; #pragma options align=mac68k

(def-mactype :QTVRInstance (find-mactype '(:pointer :OpaqueQTVRInstance)))
;  Released API Version numbers 
(defconstant $kQTVRAPIMajorVersion05 5)
; #define kQTVRAPIMajorVersion05  (0x05)
(defconstant $kQTVRAPIMajorVersion02 2)
; #define kQTVRAPIMajorVersion02  (0x02)
(defconstant $kQTVRAPIMinorVersion00 0)
; #define kQTVRAPIMinorVersion00  (0x00)
(defconstant $kQTVRAPIMinorVersion01 1)
; #define kQTVRAPIMinorVersion01  (0x01)
(defconstant $kQTVRAPIMinorVersion10 16)
; #define kQTVRAPIMinorVersion10  (0x10)
(defconstant $kQTVRAPIMinorVersion20 32)
; #define kQTVRAPIMinorVersion20  (0x20)
;  Version numbers for the API described in this header 
; #define kQTVRAPIMajorVersion kQTVRAPIMajorVersion05
; #define kQTVRAPIMinorVersion kQTVRAPIMinorVersion00

(defconstant $kQTVRControllerSubType :|ctyp|)
(defconstant $kQTVRQTVRType :|qtvr|)
(defconstant $kQTVRPanoramaType :|pano|)
(defconstant $kQTVRObjectType :|obje|)
(defconstant $kQTVROldPanoType :|STpn|)         ;  Used in QTVR 1.0 release

(defconstant $kQTVROldObjectType :|stna|)       ;  Used in QTVR 1.0 release

(defconstant $kQTVRUnknownType "\\?\\?\\?\\?")
; #define kQTVRUnknownType '\?\?\?\?' /* Unknown node type */
;  QTVR hot spot types

(defconstant $kQTVRHotSpotLinkType :|link|)
(defconstant $kQTVRHotSpotURLType :|url |)
(defconstant $kQTVRHotSpotUndefinedType :|undf|)
;  Special Values for nodeID in QTVRGoToNodeID

(defconstant $kQTVRCurrentNode 0)
(defconstant $kQTVRPreviousNode #x80000000)
(defconstant $kQTVRDefaultNode #x80000001)
;  Panorama correction modes used for the kQTVRImagingCorrection imaging property

(defconstant $kQTVRNoCorrection 0)
(defconstant $kQTVRPartialCorrection 1)
(defconstant $kQTVRFullCorrection 2)
;  Imaging Modes used by QTVRSetImagingProperty, QTVRGetImagingProperty, QTVRUpdate, QTVRBeginUpdate

(def-mactype :QTVRImagingMode (find-mactype ':UInt32))

(defconstant $kQTVRStatic 1)
(defconstant $kQTVRMotion 2)
(defconstant $kQTVRCurrentMode 0)               ;  Special Value for QTVRUpdate

(defconstant $kQTVRAllModes 100)                ;  Special value for QTVRSetProperty

;  Imaging Properties used by QTVRSetImagingProperty, QTVRGetImagingProperty

(defconstant $kQTVRImagingCorrection 1)
(defconstant $kQTVRImagingQuality 2)
(defconstant $kQTVRImagingDirectDraw 3)
(defconstant $kQTVRImagingCurrentMode 100)      ;  Get Only

;  OR the above with kImagingDefaultValue to get/set the default value

(defconstant $kImagingDefaultValue #x80000000)
;  Transition Types used by QTVRSetTransitionProperty, QTVREnableTransition

(defconstant $kQTVRTransitionSwing 1)
;  Transition Properties QTVRSetTransitionProperty

(defconstant $kQTVRTransitionSpeed 1)
(defconstant $kQTVRTransitionDirection 2)
;  Constraint values used to construct value returned by GetConstraintStatus

(defconstant $kQTVRUnconstrained 0)
(defconstant $kQTVRCantPanLeft 1)
(defconstant $kQTVRCantPanRight 2)
(defconstant $kQTVRCantPanUp 4)
(defconstant $kQTVRCantPanDown 8)
(defconstant $kQTVRCantZoomIn 16)
(defconstant $kQTVRCantZoomOut 32)
(defconstant $kQTVRCantTranslateLeft 64)
(defconstant $kQTVRCantTranslateRight #x80)
(defconstant $kQTVRCantTranslateUp #x100)
(defconstant $kQTVRCantTranslateDown #x200)
;  Object-only mouse mode values used to construct value returned by QTVRGetCurrentMouseMode

(defconstant $kQTVRPanning 1)                   ;  standard objects, "object only" controllers

(defconstant $kQTVRTranslating 2)               ;  all objects

(defconstant $kQTVRZooming 4)                   ;  all objects

(defconstant $kQTVRScrolling 8)                 ;  standard object arrow scrollers and joystick object
;  object absolute controller

(defconstant $kQTVRSelecting 16)
;  Properties for use with QTVRSetInteractionProperty/GetInteractionProperty

(defconstant $kQTVRInteractionMouseClickHysteresis 1);  pixels within which the mouse is considered not to have moved (UInt16)

(defconstant $kQTVRInteractionMouseClickTimeout 2);  ticks after which a mouse click times out and turns into panning (UInt32)

(defconstant $kQTVRInteractionPanTiltSpeed 3)   ;  control the relative pan/tilt speed from 1 (slowest) to 10 (fastest). (UInt32) Default is 5;

(defconstant $kQTVRInteractionZoomSpeed 4)      ;  control the relative zooming speed from 1 (slowest) to 10 (fastest). (UInt32) Default is 5;

(defconstant $kQTVRInteractionTranslateOnMouseDown 101);  Holding MouseDown with this setting translates zoomed object movies (Boolean)

(defconstant $kQTVRInteractionMouseMotionScale 102);  The maximum angle of rotation caused by dragging across the display window. (* float)

(defconstant $kQTVRInteractionNudgeMode 103)    ;  A QTVRNudgeMode: rotate, translate, or the same as the current mouse mode. Requires QTVR 2.1

;  OR the above with kQTVRInteractionDefaultValue to get/set the default value

(defconstant $kQTVRInteractionDefaultValue #x80000000)
;  Geometry constants used in QTVRSetBackBufferPrefs, QTVRGetBackBufferSettings, QTVRGetBackBufferMemInfo

(defconstant $kQTVRUseMovieGeometry 0)
(defconstant $kQTVRVerticalCylinder :|vcyl|)
(defconstant $kQTVRHorizontalCylinder :|hcyl|)
(defconstant $kQTVRCube :|cube|)
;  Resolution constants used in QTVRSetBackBufferPrefs, QTVRGetBackBufferSettings, QTVRGetBackBufferMemInfo

(defconstant $kQTVRDefaultRes 0)
(defconstant $kQTVRFullRes 1)
(defconstant $kQTVRHalfRes 2)
(defconstant $kQTVRQuarterRes 4)
;  QTVR-specific pixelFormat constants used in QTVRSetBackBufferPrefs, QTVRGetBackBufferSettings, QTVRGetBackBufferMemInfo

(defconstant $kQTVRUseMovieDepth 0)
;  Cache Size Pref constants used in QTVRSetBackBufferPrefs, QTVRGetBackBufferSettings

(defconstant $kQTVRMinimumCache -1)
(defconstant $kQTVRSuggestedCache 0)
(defconstant $kQTVRFullCache 1)
;  Angular units used by QTVRSetAngularUnits

(def-mactype :QTVRAngularUnits (find-mactype ':UInt32))

(defconstant $kQTVRDegrees 0)
(defconstant $kQTVRRadians 1)
;  Values for enableFlag parameter in QTVREnableHotSpot

(defconstant $kQTVRHotSpotID 0)
(defconstant $kQTVRHotSpotType 1)
(defconstant $kQTVRAllHotSpots 2)
;  Values for viewParameter for QTVRSet/GetViewParameter

(defconstant $kQTVRPanAngle #x100)              ;  default units; &float, &float

(defconstant $kQTVRTiltAngle #x101)             ;  default units; &float, &float

(defconstant $kQTVRFieldOfViewAngle #x103)      ;  default units; &float, &float

(defconstant $kQTVRViewCenter #x104)            ;  pixels (per object movies); &QTVRFloatPoint, &QTVRFloatPoint

(defconstant $kQTVRHotSpotsVisible #x200)       ;  Boolean, &Boolean

;  Values for flagsIn for QTVRSet/GetViewParameter

(defconstant $kQTVRValueIsRelative 1)           ;  Is the value absolute or relative to the current value?

(defconstant $kQTVRValueIsRate 2)               ;  Is the value absolute or a rate of change to be applied?
;  Is the value a percentage of the user rate pref?

(defconstant $kQTVRValueIsUserPrefRelative 4)
;  Values for kind parameter in QTVRGet/SetConstraints, QTVRGetViewingLimits

(defconstant $kQTVRPan 0)
(defconstant $kQTVRTilt 1)
(defconstant $kQTVRFieldOfView 2)
(defconstant $kQTVRViewCenterH 4)               ;  WrapAndConstrain only

(defconstant $kQTVRViewCenterV 5)               ;  WrapAndConstrain only

;  Values for setting parameter in QTVRSetAnimationSetting, QTVRGetAnimationSetting

(def-mactype :QTVRObjectAnimationSetting (find-mactype ':UInt32))
;  View Frame Animation Settings

(defconstant $kQTVRPalindromeViewFrames 1)
(defconstant $kQTVRStartFirstViewFrame 2)
(defconstant $kQTVRDontLoopViewFrames 3)
(defconstant $kQTVRPlayEveryViewFrame 4)        ;  Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10)
;  View Animation Settings

(defconstant $kQTVRSyncViewToFrameRate 16)
(defconstant $kQTVRPalindromeViews 17)
(defconstant $kQTVRPlayStreamingViews 18)       ;  Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10)


(def-mactype :QTVRControlSetting (find-mactype ':UInt32))

(defconstant $kQTVRWrapPan 1)
(defconstant $kQTVRWrapTilt 2)
(defconstant $kQTVRCanZoom 3)
(defconstant $kQTVRReverseHControl 4)
(defconstant $kQTVRReverseVControl 5)
(defconstant $kQTVRSwapHVControl 6)
(defconstant $kQTVRTranslation 7)

(def-mactype :QTVRViewStateType (find-mactype ':UInt32))

(defconstant $kQTVRDefault 0)
(defconstant $kQTVRCurrent 2)
(defconstant $kQTVRMouseDown 3)

(def-mactype :QTVRNudgeControl (find-mactype ':UInt32))

(defconstant $kQTVRRight 0)
(defconstant $kQTVRUpRight 45)
(defconstant $kQTVRUp 90)
(defconstant $kQTVRUpLeft #x87)
(defconstant $kQTVRLeft #xB4)
(defconstant $kQTVRDownLeft #xE1)
(defconstant $kQTVRDown #x10E)
(defconstant $kQTVRDownRight #x13B)

(def-mactype :QTVRNudgeMode (find-mactype ':UInt32))

(defconstant $kQTVRNudgeRotate 0)
(defconstant $kQTVRNudgeTranslate 1)
(defconstant $kQTVRNudgeSameAsMouse 2)
;  Flags to control elements of the QTVR control bar (set via mcActionSetFlags) 

(defconstant $mcFlagQTVRSuppressBackBtn #x10000)
(defconstant $mcFlagQTVRSuppressZoomBtns #x20000)
(defconstant $mcFlagQTVRSuppressHotSpotBtn #x40000)
(defconstant $mcFlagQTVRSuppressTranslateBtn #x80000)
(defconstant $mcFlagQTVRSuppressHelpText #x100000)
(defconstant $mcFlagQTVRSuppressHotSpotNames #x200000);  bits 0->30 should be interpreted as "explicit on" for the corresponding suppression bits

(defconstant $mcFlagQTVRExplicitFlagSet #x80000000)
;  Cursor types used in type field of QTVRCursorRecord

(defconstant $kQTVRUseDefaultCursor 0)
(defconstant $kQTVRStdCursorType 1)
(defconstant $kQTVRColorCursorType 2)
;  Values for flags parameter in QTVRMouseOverHotSpot callback

(defconstant $kQTVRHotSpotEnter 0)
(defconstant $kQTVRHotSpotWithin 1)
(defconstant $kQTVRHotSpotLeave 2)
;  Values for flags parameter in QTVRSetPrescreenImagingCompleteProc
;  Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10)

(defconstant $kQTVRPreScreenEveryIdle 1)
;  Values for flags field of areasOfInterest in QTVRSetBackBufferImagingProc

(defconstant $kQTVRBackBufferEveryUpdate 1)
(defconstant $kQTVRBackBufferEveryIdle 2)
(defconstant $kQTVRBackBufferAlwaysRefresh 4)   ;  Requires that backbuffer proc be long-rowBytes aware (gestaltQDHasLongRowBytes)

(defconstant $kQTVRBackBufferHorizontal 8)
;  Values for flagsIn parameter in QTVRBackBufferImaging callback

(defconstant $kQTVRBackBufferRectVisible 1)
(defconstant $kQTVRBackBufferWasRefreshed 2)
;  Values for flagsOut parameter in QTVRBackBufferImaging callback

(defconstant $kQTVRBackBufferFlagDidDraw 1)
(defconstant $kQTVRBackBufferFlagLastFlag #x80000000)
;  QTVRCursorRecord used in QTVRReplaceCursor
(defrecord QTVRCursorRecord
   (theType :UInt16)                            ;  field was previously named "type"
   (rsrcID :SInt16)
   (handle :Handle)
)

;type name? (%define-record :QTVRCursorRecord (find-record-descriptor ':QTVRCursorRecord))
(defrecord QTVRFloatPoint
   (x :single-float)
   (y :single-float)
)

;type name? (%define-record :QTVRFloatPoint (find-record-descriptor ':QTVRFloatPoint))
;  Struct used for areasOfInterest parameter in QTVRSetBackBufferImagingProc
(defrecord QTVRAreaOfInterest
   (panAngle :single-float)
   (tiltAngle :single-float)
   (width :single-float)
   (height :single-float)
   (flags :UInt32)
)

;type name? (%define-record :QTVRAreaOfInterest (find-record-descriptor ':QTVRAreaOfInterest))
; 
;   =================================================================================================
;    Callback routines 
;   -------------------------------------------------------------------------------------------------
; 

(def-mactype :QTVRLeavingNodeProcPtr (find-mactype ':pointer)); (QTVRInstance qtvr , UInt32 fromNodeID , UInt32 toNodeID , Boolean * cancel , SInt32 refCon)

(def-mactype :QTVREnteringNodeProcPtr (find-mactype ':pointer)); (QTVRInstance qtvr , UInt32 nodeID , SInt32 refCon)

(def-mactype :QTVRMouseOverHotSpotProcPtr (find-mactype ':pointer)); (QTVRInstance qtvr , UInt32 hotSpotID , UInt32 flags , SInt32 refCon)

(def-mactype :QTVRImagingCompleteProcPtr (find-mactype ':pointer)); (QTVRInstance qtvr , SInt32 refCon)

(def-mactype :QTVRBackBufferImagingProcPtr (find-mactype ':pointer)); (QTVRInstance qtvr , Rect * drawRect , UInt16 areaIndex , UInt32 flagsIn , UInt32 * flagsOut , SInt32 refCon)

(def-mactype :QTVRLeavingNodeUPP (find-mactype '(:pointer :OpaqueQTVRLeavingNodeProcPtr)))

(def-mactype :QTVREnteringNodeUPP (find-mactype '(:pointer :OpaqueQTVREnteringNodeProcPtr)))

(def-mactype :QTVRMouseOverHotSpotUPP (find-mactype '(:pointer :OpaqueQTVRMouseOverHotSpotProcPtr)))

(def-mactype :QTVRImagingCompleteUPP (find-mactype '(:pointer :OpaqueQTVRImagingCompleteProcPtr)))

(def-mactype :QTVRBackBufferImagingUPP (find-mactype '(:pointer :OpaqueQTVRBackBufferImagingProcPtr)))
; 
;  *  NewQTVRLeavingNodeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTVRLeavingNodeUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQTVRLeavingNodeProcPtr)
() )
; 
;  *  NewQTVREnteringNodeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTVREnteringNodeUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQTVREnteringNodeProcPtr)
() )
; 
;  *  NewQTVRMouseOverHotSpotUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTVRMouseOverHotSpotUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQTVRMouseOverHotSpotProcPtr)
() )
; 
;  *  NewQTVRImagingCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTVRImagingCompleteUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQTVRImagingCompleteProcPtr)
() )
; 
;  *  NewQTVRBackBufferImagingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTVRBackBufferImagingUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQTVRBackBufferImagingProcPtr)
() )
; 
;  *  DisposeQTVRLeavingNodeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTVRLeavingNodeUPP" 
   ((userUPP (:pointer :OpaqueQTVRLeavingNodeProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQTVREnteringNodeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTVREnteringNodeUPP" 
   ((userUPP (:pointer :OpaqueQTVREnteringNodeProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQTVRMouseOverHotSpotUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTVRMouseOverHotSpotUPP" 
   ((userUPP (:pointer :OpaqueQTVRMouseOverHotSpotProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQTVRImagingCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTVRImagingCompleteUPP" 
   ((userUPP (:pointer :OpaqueQTVRImagingCompleteProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQTVRBackBufferImagingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTVRBackBufferImagingUPP" 
   ((userUPP (:pointer :OpaqueQTVRBackBufferImagingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQTVRLeavingNodeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTVRLeavingNodeUPP" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (fromNodeID :UInt32)
    (toNodeID :UInt32)
    (cancel (:pointer :Boolean))
    (refCon :SInt32)
    (userUPP (:pointer :OpaqueQTVRLeavingNodeProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeQTVREnteringNodeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTVREnteringNodeUPP" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (nodeID :UInt32)
    (refCon :SInt32)
    (userUPP (:pointer :OpaqueQTVREnteringNodeProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeQTVRMouseOverHotSpotUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTVRMouseOverHotSpotUPP" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (hotSpotID :UInt32)
    (flags :UInt32)
    (refCon :SInt32)
    (userUPP (:pointer :OpaqueQTVRMouseOverHotSpotProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeQTVRImagingCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTVRImagingCompleteUPP" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (refCon :SInt32)
    (userUPP (:pointer :OpaqueQTVRImagingCompleteProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeQTVRBackBufferImagingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTVRBackBufferImagingUPP" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (drawRect (:pointer :Rect))
    (areaIndex :UInt16)
    (flagsIn :UInt32)
    (flagsOut (:pointer :UInt32))
    (refCon :SInt32)
    (userUPP (:pointer :OpaqueQTVRBackBufferImagingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   =================================================================================================
;     QTVR Intercept Struct, Callback, Routine Descriptors 
;   -------------------------------------------------------------------------------------------------
; 

(def-mactype :QTVRProcSelector (find-mactype ':UInt32))

(defconstant $kQTVRSetPanAngleSelector #x2000)
(defconstant $kQTVRSetTiltAngleSelector #x2001)
(defconstant $kQTVRSetFieldOfViewSelector #x2002)
(defconstant $kQTVRSetViewCenterSelector #x2003)
(defconstant $kQTVRMouseEnterSelector #x2004)
(defconstant $kQTVRMouseWithinSelector #x2005)
(defconstant $kQTVRMouseLeaveSelector #x2006)
(defconstant $kQTVRMouseDownSelector #x2007)
(defconstant $kQTVRMouseStillDownSelector #x2008)
(defconstant $kQTVRMouseUpSelector #x2009)
(defconstant $kQTVRTriggerHotSpotSelector #x200A)
(defconstant $kQTVRGetHotSpotTypeSelector #x200B);  Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10)

(defconstant $kQTVRSetViewParameterSelector #x200C);  Requires QTVR 5.0 (kQTVRAPIMajorVersion05 + kQTVRAPIMinorVersion00)

(defconstant $kQTVRGetViewParameterSelector #x200D);  Requires QTVR 5.0 (kQTVRAPIMajorVersion05 + kQTVRAPIMinorVersion00)

(defrecord QTVRInterceptRecord
   (reserved1 :SInt32)
   (selector :SInt32)
   (reserved2 :SInt32)
   (reserved3 :SInt32)
   (paramCount :SInt32)
   (parameter (:array :pointer 6))
)

;type name? (%define-record :QTVRInterceptRecord (find-record-descriptor ':QTVRInterceptRecord))

(def-mactype :QTVRInterceptPtr (find-mactype '(:pointer :QTVRInterceptRecord)))
;  Prototype for Intercept Proc callback

(def-mactype :QTVRInterceptProcPtr (find-mactype ':pointer)); (QTVRInstance qtvr , QTVRInterceptPtr qtvrMsg , SInt32 refCon , Boolean * cancel)

(def-mactype :QTVRInterceptUPP (find-mactype '(:pointer :OpaqueQTVRInterceptProcPtr)))
; 
;  *  NewQTVRInterceptUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTVRInterceptUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQTVRInterceptProcPtr)
() )
; 
;  *  DisposeQTVRInterceptUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTVRInterceptUPP" 
   ((userUPP (:pointer :OpaqueQTVRInterceptProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQTVRInterceptUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTVRInterceptUPP" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (qtvrMsg (:pointer :QTVRInterceptRecord))
    (refCon :SInt32)
    (cancel (:pointer :Boolean))
    (userUPP (:pointer :OpaqueQTVRInterceptProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;   =================================================================================================
;     Initialization QTVR calls 
;   -------------------------------------------------------------------------------------------------
;    Requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10) and only work on Non-Macintosh platforms
; 
; 
;   =================================================================================================
;     General QTVR calls 
;   -------------------------------------------------------------------------------------------------
; 
; 
;  *  QTVRGetQTVRTrack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetQTVRTrack" 
   ((theMovie (:Handle :MovieType))
    (index :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :TrackType)
() )
; 
;  *  QTVRGetQTVRInstance()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetQTVRInstance" 
   ((qtvr (:pointer :QTVRINSTANCE))
    (qtvrTrack (:Handle :TrackType))
    (mc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   =================================================================================================
;     Viewing Angles and Zooming 
;   -------------------------------------------------------------------------------------------------
; 
;  QTVRSetViewParameter requires QTVR 5.0 (kQTVRAPIMajorVersion05 + kQTVRAPIMinorVersion00)
; 
;  *  QTVRSetViewParameter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 5.0 and later
;  *    Windows:          in QTVR.lib 5.0 and later
;  

(deftrap-inline "_QTVRSetViewParameter" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (viewParameter :UInt32)
    (value :pointer)
    (flagsIn :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  QTVRGetViewParameter requires QTVR 5.0 (kQTVRAPIMajorVersion05 + kQTVRAPIMinorVersion00)
; 
;  *  QTVRGetViewParameter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 5.0 and later
;  *    Windows:          in QTVR.lib 5.0 and later
;  

(deftrap-inline "_QTVRGetViewParameter" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (viewParameter :UInt32)
    (value :pointer)
    (flagsIn :UInt32)
    (flagsOut (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRSetPanAngle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetPanAngle" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (panAngle :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetPanAngle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetPanAngle" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :single-float
() )
; 
;  *  QTVRSetTiltAngle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetTiltAngle" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (tiltAngle :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetTiltAngle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetTiltAngle" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :single-float
() )
; 
;  *  QTVRSetFieldOfView()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetFieldOfView" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (fieldOfView :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetFieldOfView()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetFieldOfView" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :single-float
() )
; 
;  *  QTVRShowDefaultView()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRShowDefaultView" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Object Specific
; 
;  *  QTVRSetViewCenter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetViewCenter" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (viewCenter (:pointer :QTVRFloatPoint))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetViewCenter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetViewCenter" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (viewCenter (:pointer :QTVRFloatPoint))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRNudge()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRNudge" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (direction :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  QTVRInteractionNudge requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10)
; 
;  *  QTVRInteractionNudge()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.1 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRInteractionNudge" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (direction :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   =================================================================================================
;     Scene and Node Location Information 
;   -------------------------------------------------------------------------------------------------
; 
; 
;  *  QTVRGetVRWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetVRWorld" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (VRWorld (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetNodeInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetNodeInfo" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (nodeID :UInt32)
    (nodeInfo (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGoToNodeID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGoToNodeID" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (nodeID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetCurrentNodeID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetCurrentNodeID" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  QTVRGetNodeType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetNodeType" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (nodeID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSType
() )
; 
;   =================================================================================================
;     Hot Spot related calls 
;   -------------------------------------------------------------------------------------------------
; 
; 
;  *  QTVRPtToHotSpotID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRPtToHotSpotID" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (pt :Point)
    (hotSpotID (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  QTVRGetHotSpotType requires QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10)
; 
;  *  QTVRGetHotSpotType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.1 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetHotSpotType" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (hotSpotID :UInt32)
    (hotSpotType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRTriggerHotSpot()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRTriggerHotSpot" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (hotSpotID :UInt32)
    (nodeInfo :Handle)
    (selectedAtom :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRSetMouseOverHotSpotProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetMouseOverHotSpotProc" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (mouseOverHotSpotProc (:pointer :OpaqueQTVRMouseOverHotSpotProcPtr))
    (refCon :SInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVREnableHotSpot()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVREnableHotSpot" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (enableFlag :UInt32)
    (hotSpotValue :UInt32)
    (enable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetVisibleHotSpots()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetVisibleHotSpots" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (hotSpots :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  QTVRGetHotSpotRegion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetHotSpotRegion" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (hotSpotID :UInt32)
    (hotSpotRegion (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   =================================================================================================
;     Event & Cursor Handling Calls 
;   -------------------------------------------------------------------------------------------------
; 
; 
;  *  QTVRSetMouseOverTracking()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetMouseOverTracking" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (enable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetMouseOverTracking()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetMouseOverTracking" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  QTVRSetMouseDownTracking()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetMouseDownTracking" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (enable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetMouseDownTracking()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetMouseDownTracking" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  QTVRMouseEnter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRMouseEnter" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (pt :Point)
    (hotSpotID (:pointer :UInt32))
    (w (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRMouseWithin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRMouseWithin" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (pt :Point)
    (hotSpotID (:pointer :UInt32))
    (w (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRMouseLeave()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRMouseLeave" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (pt :Point)
    (w (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRMouseDown()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRMouseDown" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (pt :Point)
    (when :UInt32)
    (modifiers :UInt16)
    (hotSpotID (:pointer :UInt32))
    (w (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRMouseStillDown()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRMouseStillDown" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (pt :Point)
    (hotSpotID (:pointer :UInt32))
    (w (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRMouseUp()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRMouseUp" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (pt :Point)
    (hotSpotID (:pointer :UInt32))
    (w (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  These require QTVR 2.01 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion01)
; 
;  *  QTVRMouseStillDownExtended()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0.1 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRMouseStillDownExtended" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (pt :Point)
    (hotSpotID (:pointer :UInt32))
    (w (:pointer :OpaqueWindowPtr))
    (when :UInt32)
    (modifiers :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRMouseUpExtended()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0.1 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRMouseUpExtended" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (pt :Point)
    (hotSpotID (:pointer :UInt32))
    (w (:pointer :OpaqueWindowPtr))
    (when :UInt32)
    (modifiers :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   =================================================================================================
;     Intercept Routines 
;   -------------------------------------------------------------------------------------------------
; 
; 
;  *  QTVRInstallInterceptProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRInstallInterceptProc" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (selector :UInt32)
    (interceptProc (:pointer :OpaqueQTVRInterceptProcPtr))
    (refCon :SInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRCallInterceptedProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRCallInterceptedProc" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (qtvrMsg (:pointer :QTVRInterceptRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   =================================================================================================
;     Object Movie Specific Calls 
;   -------------------------------------------------------------------------------------------------
;    QTVRGetCurrentMouseMode requires QTRVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10)
; 
; 
;  *  QTVRGetCurrentMouseMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.1 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetCurrentMouseMode" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  QTVRSetFrameRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetFrameRate" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (rate :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetFrameRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetFrameRate" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :single-float
() )
; 
;  *  QTVRSetViewRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetViewRate" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (rate :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetViewRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetViewRate" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :single-float
() )
; 
;  *  QTVRSetViewCurrentTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetViewCurrentTime" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (time :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetViewCurrentTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetViewCurrentTime" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVRGetCurrentViewDuration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetCurrentViewDuration" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;   =================================================================================================
;    View State Calls - QTVR Object Only
;   -------------------------------------------------------------------------------------------------
; 
; 
;  *  QTVRSetViewState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetViewState" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (viewStateType :UInt32)
    (state :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetViewState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetViewState" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (viewStateType :UInt32)
    (state (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetViewStateCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetViewStateCount" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt16
() )
; 
;  *  QTVRSetAnimationSetting()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetAnimationSetting" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (setting :UInt32)
    (enable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetAnimationSetting()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetAnimationSetting" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (setting :UInt32)
    (enable (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRSetControlSetting()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetControlSetting" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (setting :UInt32)
    (enable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetControlSetting()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetControlSetting" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (setting :UInt32)
    (enable (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVREnableFrameAnimation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVREnableFrameAnimation" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (enable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetFrameAnimation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetFrameAnimation" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  QTVREnableViewAnimation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVREnableViewAnimation" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (enable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetViewAnimation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetViewAnimation" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;   =================================================================================================
;     Imaging Characteristics 
;   -------------------------------------------------------------------------------------------------
; 
; 
;  *  QTVRSetVisible()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetVisible" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (visible :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetVisible()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetVisible" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  QTVRSetImagingProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetImagingProperty" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (imagingMode :UInt32)
    (imagingProperty :UInt32)
    (propertyValue :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetImagingProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetImagingProperty" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (imagingMode :UInt32)
    (imagingProperty :UInt32)
    (propertyValue (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRUpdate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRUpdate" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (imagingMode :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRBeginUpdateStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRBeginUpdateStream" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (imagingMode :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVREndUpdateStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVREndUpdateStream" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRSetTransitionProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetTransitionProperty" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (transitionType :UInt32)
    (transitionProperty :UInt32)
    (transitionValue :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVREnableTransition()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVREnableTransition" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (transitionType :UInt32)
    (enable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   =================================================================================================
;     Basic Conversion and Math Routines 
;   -------------------------------------------------------------------------------------------------
; 
; 
;  *  QTVRSetAngularUnits()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetAngularUnits" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (units :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetAngularUnits()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetAngularUnits" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
;  Pano specific routines
; 
;  *  QTVRPtToAngles()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRPtToAngles" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (pt :Point)
    (panAngle (:pointer :float))
    (tiltAngle (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRCoordToAngles()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRCoordToAngles" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (coord (:pointer :QTVRFloatPoint))
    (panAngle (:pointer :float))
    (tiltAngle (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRAnglesToCoord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRAnglesToCoord" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (panAngle :single-float)
    (tiltAngle :single-float)
    (coord (:pointer :QTVRFloatPoint))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Object specific routines
; 
;  *  QTVRPanToColumn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRPanToColumn" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (panAngle :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
;  zero based   
; 
;  *  QTVRColumnToPan()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRColumnToPan" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (column :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :single-float
() )
;  zero based   
; 
;  *  QTVRTiltToRow()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRTiltToRow" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (tiltAngle :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
;  zero based   
; 
;  *  QTVRRowToTilt()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRRowToTilt" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (row :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :single-float
() )
;  zero based               
; 
;  *  QTVRWrapAndConstrain()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRWrapAndConstrain" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (kind :SInt16)
    (value :single-float)
    (result (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   =================================================================================================
;     Interaction Routines 
;   -------------------------------------------------------------------------------------------------
; 
; 
;  *  QTVRSetEnteringNodeProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetEnteringNodeProc" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (enteringNodeProc (:pointer :OpaqueQTVREnteringNodeProcPtr))
    (refCon :SInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRSetLeavingNodeProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetLeavingNodeProc" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (leavingNodeProc (:pointer :OpaqueQTVRLeavingNodeProcPtr))
    (refCon :SInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRSetInteractionProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetInteractionProperty" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (property :UInt32)
    (value :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetInteractionProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetInteractionProperty" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (property :UInt32)
    (value :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRReplaceCursor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRReplaceCursor" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (cursRecord (:pointer :QTVRCursorRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   =================================================================================================
;     Viewing Limits and Constraints 
;   -------------------------------------------------------------------------------------------------
; 
; 
;  *  QTVRGetViewingLimits()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetViewingLimits" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (kind :UInt16)
    (minValue (:pointer :float))
    (maxValue (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetConstraintStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetConstraintStatus" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  QTVRGetConstraints()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetConstraints" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (kind :UInt16)
    (minValue (:pointer :float))
    (maxValue (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRSetConstraints()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetConstraints" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (kind :UInt16)
    (minValue :single-float)
    (maxValue :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   =================================================================================================
;     Back Buffer Memory Management 
;   -------------------------------------------------------------------------------------------------
; 
; 
;  *  QTVRGetAvailableResolutions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetAvailableResolutions" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (resolutionsMask (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  These require QTVR 2.1 (kQTVRAPIMajorVersion02 + kQTVRAPIMinorVersion10)
; 
;  *  QTVRGetBackBufferMemInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.1 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetBackBufferMemInfo" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (geometry :UInt32)
    (resolution :UInt16)
    (cachePixelFormat :UInt32)
    (minCacheBytes (:pointer :SInt32))
    (suggestedCacheBytes (:pointer :SInt32))
    (fullCacheBytes (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRGetBackBufferSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.1 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRGetBackBufferSettings" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (geometry (:pointer :UInt32))
    (resolution (:pointer :UInt16))
    (cachePixelFormat (:pointer :UInt32))
    (cacheSize (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRSetBackBufferPrefs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.1 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetBackBufferPrefs" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (geometry :UInt32)
    (resolution :UInt16)
    (cachePixelFormat :UInt32)
    (cacheSize :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   =================================================================================================
;     Buffer Access 
;   -------------------------------------------------------------------------------------------------
; 
; 
;  *  QTVRSetPrescreenImagingCompleteProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetPrescreenImagingCompleteProc" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (imagingCompleteProc (:pointer :OpaqueQTVRImagingCompleteProcPtr))
    (refCon :SInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRSetBackBufferImagingProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRSetBackBufferImagingProc" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (backBufferImagingProc (:pointer :OpaqueQTVRBackBufferImagingProcPtr))
    (numAreas :UInt16)
    (areasOfInterest (:pointer :QTVRAreaOfInterest))
    (refCon :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTVRRefreshBackBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeVRLib 2.0 and later
;  *    Windows:          in QTVR.lib 2.1 and later
;  

(deftrap-inline "_QTVRRefreshBackBuffer" 
   ((qtvr (:pointer :OpaqueQTVRInstance))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   =================================================================================================
;     Old Names
;   -------------------------------------------------------------------------------------------------
; 

; #if OLDROUTINENAMES
#| 
(%define-record :CursorRecord (find-record-descriptor ':QTVRCursorRecord))

(%define-record :AreaOfInterest (find-record-descriptor ':QTVRAreaOfInterest))

(%define-record :FloatPoint (find-record-descriptor ':QTVRFloatPoint))

(def-mactype :LeavingNodeProcPtr (find-mactype ':pointer))

(def-mactype :LeavingNodeUPP (find-mactype ':QTVRLeavingNodeUPP))

(def-mactype :EnteringNodeProcPtr (find-mactype ':pointer))

(def-mactype :EnteringNodeUPP (find-mactype ':QTVREnteringNodeUPP))

(def-mactype :MouseOverHotSpotProcPtr (find-mactype ':pointer))

(def-mactype :MouseOverHotSpotUPP (find-mactype ':QTVRMouseOverHotSpotUPP))

(def-mactype :ImagingCompleteProcPtr (find-mactype ':pointer))

(def-mactype :ImagingCompleteUPP (find-mactype ':QTVRImagingCompleteUPP))

(def-mactype :BackBufferImagingProcPtr (find-mactype ':pointer))

(def-mactype :BackBufferImagingUPP (find-mactype ':QTVRBackBufferImagingUPP))
 |#

; #endif  /* OLDROUTINENAMES */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __QUICKTIMEVR__ */


(provide-interface "QuickTimeVR")