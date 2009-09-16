(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:QuickTimeVRFormat.h"
; at Sunday July 2,2006 7:31:24 pm.
; 
;      File:       QuickTime/QuickTimeVRFormat.h
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
; #ifndef __QUICKTIMEVRFORMAT__
; #define __QUICKTIMEVRFORMAT__
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
; #ifndef __QUICKTIMEVR__
#| #|
#include <QuickTimeQuickTimeVR.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=mac68k
;  File Format Version numbers 
(defconstant $kQTVRMajorVersion 2)
; #define kQTVRMajorVersion (2)
(defconstant $kQTVRMinorVersion 0)
; #define kQTVRMinorVersion (0)
;  User data type for the Movie Controller type specifier

(defconstant $kQTControllerType :|ctyp|)        ;  Atom & ID of where our

(defconstant $kQTControllerID 1)                ;  ...controller name is stored

;  VRWorld atom types

(defconstant $kQTVRWorldHeaderAtomType :|vrsc|)
(defconstant $kQTVRImagingParentAtomType :|imgp|)
(defconstant $kQTVRPanoImagingAtomType :|impn|)
(defconstant $kQTVRObjectImagingAtomType :|imob|)
(defconstant $kQTVRNodeParentAtomType :|vrnp|)
(defconstant $kQTVRNodeIDAtomType :|vrni|)
(defconstant $kQTVRNodeLocationAtomType :|nloc|)
(defconstant $kQTVRCursorParentAtomType :|vrcp|);  New with 2.1

(defconstant $kQTVRCursorAtomType :|CURS|)      ;  New with 2.1

(defconstant $kQTVRColorCursorAtomType :|crsr|) ;  New with 2.1

;  NodeInfo atom types

(defconstant $kQTVRNodeHeaderAtomType :|ndhd|)
(defconstant $kQTVRHotSpotParentAtomType :|hspa|)
(defconstant $kQTVRHotSpotAtomType :|hots|)
(defconstant $kQTVRHotSpotInfoAtomType :|hsin|)
(defconstant $kQTVRLinkInfoAtomType :|link|)
;  Miscellaneous atom types

(defconstant $kQTVRStringAtomType :|vrsg|)
(defconstant $kQTVRStringEncodingAtomType :|vrse|);  New with 2.1

(defconstant $kQTVRPanoSampleDataAtomType :|pdat|)
(defconstant $kQTVRObjectInfoAtomType :|obji|)
(defconstant $kQTVRImageTrackRefAtomType :|imtr|);  Parent is kQTVRObjectInfoAtomType. Required if track ref is not 1 as required by 2.0 format.

(defconstant $kQTVRHotSpotTrackRefAtomType :|hstr|);  Parent is kQTVRObjectInfoAtomType. Required if track ref is not 1 as required by 2.0 format.

(defconstant $kQTVRAngleRangeAtomType :|arng|)
(defconstant $kQTVRTrackRefArrayAtomType :|tref|)
(defconstant $kQTVRPanConstraintAtomType :|pcon|)
(defconstant $kQTVRTiltConstraintAtomType :|tcon|)
(defconstant $kQTVRFOVConstraintAtomType :|fcon|)
(defconstant $kQTVRCubicViewAtomType :|cuvw|)   ;  New with 5.0

(defconstant $kQTVRCubicFaceDataAtomType :|cufa|);  New with 5.0


(defconstant $kQTVRObjectInfoAtomID 1)
(defconstant $kQTVRObjectImageTrackRefAtomID 1) ;  New with 2.1, it adds a track reference to select between multiple image tracks

(defconstant $kQTVRObjectHotSpotTrackRefAtomID 1);  New with 2.1, it adds a track reference to select between multiple hotspot tracks

;  Track reference types

(defconstant $kQTVRImageTrackRefType :|imgt|)
(defconstant $kQTVRHotSpotTrackRefType :|hott|)
;  Old hot spot types

(defconstant $kQTVRHotSpotNavigableType :|navg|)
;  Valid bits used in QTVRLinkHotSpotAtom

(defconstant $kQTVRValidPan 1)
(defconstant $kQTVRValidTilt 2)
(defconstant $kQTVRValidFOV 4)
(defconstant $kQTVRValidViewCenter 8)
;  Values for flags field in QTVRPanoSampleAtom

(defconstant $kQTVRPanoFlagHorizontal 1)
(defconstant $kQTVRPanoFlagLast #x80000000)
;  Values for locationFlags field in QTVRNodeLocationAtom

(defconstant $kQTVRSameFile 0)
;  Header for QTVR track's Sample Description record (vrWorld atom container is appended)
(defrecord QTVRSampleDescription
   (descSize :UInt32)                           ;  total size of the QTVRSampleDescription
   (descType :UInt32)                           ;  must be 'qtvr'
   (reserved1 :UInt32)                          ;  must be zero
   (reserved2 :UInt16)                          ;  must be zero
   (dataRefIndex :UInt16)                       ;  must be zero
   (data :UInt32)                               ;  Will be extended to hold vrWorld QTAtomContainer
)

;type name? (%define-record :QTVRSampleDescription (find-record-descriptor ':QTVRSampleDescription))

(def-mactype :QTVRSampleDescriptionPtr (find-mactype '(:pointer :QTVRSampleDescription)))

(def-mactype :QTVRSampleDescriptionHandle (find-mactype '(:handle :QTVRSampleDescription)))
; 
;   =================================================================================================
;    Definitions and structures used in the VRWorld QTAtomContainer
;   -------------------------------------------------------------------------------------------------
; 
(defrecord QTVRStringAtom
   (stringUsage :UInt16)
   (stringLength :UInt16)
   (theString (:array :UInt8 4))                ;  field previously named "string"
)

;type name? (%define-record :QTVRStringAtom (find-record-descriptor ':QTVRStringAtom))

(def-mactype :QTVRStringAtomPtr (find-mactype '(:pointer :QTVRStringAtom)))
(defrecord QTVRWorldHeaderAtom
   (majorVersion :UInt16)
   (minorVersion :UInt16)
   (nameAtomID :signed-long)
   (defaultNodeID :UInt32)
   (vrWorldFlags :UInt32)
   (reserved1 :UInt32)
   (reserved2 :UInt32)
)

;type name? (%define-record :QTVRWorldHeaderAtom (find-record-descriptor ':QTVRWorldHeaderAtom))

(def-mactype :QTVRWorldHeaderAtomPtr (find-mactype '(:pointer :QTVRWorldHeaderAtom)))
;  Valid bits used in QTVRPanoImagingAtom

(defconstant $kQTVRValidCorrection 1)
(defconstant $kQTVRValidQuality 2)
(defconstant $kQTVRValidDirectDraw 4)
(defconstant $kQTVRValidFirstExtraProperty 8)
(defrecord QTVRPanoImagingAtom
   (majorVersion :UInt16)
   (minorVersion :UInt16)
   (imagingMode :UInt32)
   (imagingValidFlags :UInt32)
   (correction :UInt32)
   (quality :UInt32)
   (directDraw :UInt32)
   (imagingProperties (:array :UInt32 6))       ;  for future properties
   (reserved1 :UInt32)
   (reserved2 :UInt32)
)

;type name? (%define-record :QTVRPanoImagingAtom (find-record-descriptor ':QTVRPanoImagingAtom))

(def-mactype :QTVRPanoImagingAtomPtr (find-mactype '(:pointer :QTVRPanoImagingAtom)))
(defrecord QTVRNodeLocationAtom
   (majorVersion :UInt16)
   (minorVersion :UInt16)
   (nodeType :OSType)
   (locationFlags :UInt32)
   (locationData :UInt32)
   (reserved1 :UInt32)
   (reserved2 :UInt32)
)

;type name? (%define-record :QTVRNodeLocationAtom (find-record-descriptor ':QTVRNodeLocationAtom))

(def-mactype :QTVRNodeLocationAtomPtr (find-mactype '(:pointer :QTVRNodeLocationAtom)))
; 
;   =================================================================================================
;    Definitions and structures used in the Nodeinfo QTAtomContainer
;   -------------------------------------------------------------------------------------------------
; 
(defrecord QTVRNodeHeaderAtom
   (majorVersion :UInt16)
   (minorVersion :UInt16)
   (nodeType :OSType)
   (nodeID :signed-long)
   (nameAtomID :signed-long)
   (commentAtomID :signed-long)
   (reserved1 :UInt32)
   (reserved2 :UInt32)
)

;type name? (%define-record :QTVRNodeHeaderAtom (find-record-descriptor ':QTVRNodeHeaderAtom))

(def-mactype :QTVRNodeHeaderAtomPtr (find-mactype '(:pointer :QTVRNodeHeaderAtom)))
(defrecord QTVRAngleRangeAtom
   (minimumAngle :single-float)
   (maximumAngle :single-float)
)

;type name? (%define-record :QTVRAngleRangeAtom (find-record-descriptor ':QTVRAngleRangeAtom))

(def-mactype :QTVRAngleRangeAtomPtr (find-mactype '(:pointer :QTVRAngleRangeAtom)))
(defrecord QTVRHotSpotInfoAtom
   (majorVersion :UInt16)
   (minorVersion :UInt16)
   (hotSpotType :OSType)
   (nameAtomID :signed-long)
   (commentAtomID :signed-long)
   (cursorID (:array :SInt32 3))
                                                ;  canonical view for this hot spot
   (bestPan :single-float)
   (bestTilt :single-float)
   (bestFOV :single-float)
   (bestViewCenter :QTVRFloatPoint)
                                                ;  Bounding box for this hot spot
   (hotSpotRect :Rect)
   (flags :UInt32)
   (reserved1 :UInt32)
   (reserved2 :UInt32)
)

;type name? (%define-record :QTVRHotSpotInfoAtom (find-record-descriptor ':QTVRHotSpotInfoAtom))

(def-mactype :QTVRHotSpotInfoAtomPtr (find-mactype '(:pointer :QTVRHotSpotInfoAtom)))
(defrecord QTVRLinkHotSpotAtom
   (majorVersion :UInt16)
   (minorVersion :UInt16)
   (toNodeID :UInt32)
   (fromValidFlags :UInt32)
   (fromPan :single-float)
   (fromTilt :single-float)
   (fromFOV :single-float)
   (fromViewCenter :QTVRFloatPoint)
   (toValidFlags :UInt32)
   (toPan :single-float)
   (toTilt :single-float)
   (toFOV :single-float)
   (toViewCenter :QTVRFloatPoint)
   (distance :single-float)
   (flags :UInt32)
   (reserved1 :UInt32)
   (reserved2 :UInt32)
)

;type name? (%define-record :QTVRLinkHotSpotAtom (find-record-descriptor ':QTVRLinkHotSpotAtom))

(def-mactype :QTVRLinkHotSpotAtomPtr (find-mactype '(:pointer :QTVRLinkHotSpotAtom)))
; 
;   =================================================================================================
;    Definitions and structures used in Panorama and Object tracks
;   -------------------------------------------------------------------------------------------------
; 
(defrecord QTVRPanoSampleAtom
   (majorVersion :UInt16)
   (minorVersion :UInt16)
   (imageRefTrackIndex :UInt32)                 ;  track reference index of the full res image track
   (hotSpotRefTrackIndex :UInt32)               ;  track reference index of the full res hot spot track
   (minPan :single-float)
   (maxPan :single-float)
   (minTilt :single-float)
   (maxTilt :single-float)
   (minFieldOfView :single-float)
   (maxFieldOfView :single-float)
   (defaultPan :single-float)
   (defaultTilt :single-float)
   (defaultFieldOfView :single-float)
                                                ;  Info for highest res version of image track
   (imageSizeX :UInt32)                         ;  pixel width of the panorama (e.g. 768)
   (imageSizeY :UInt32)                         ;  pixel height of the panorama (e.g. 2496)
   (imageNumFramesX :UInt16)                    ;  diced frames wide (e.g. 1)
   (imageNumFramesY :UInt16)                    ;  diced frames high (e.g. 24)
                                                ;  Info for highest res version of hotSpot track
   (hotSpotSizeX :UInt32)                       ;  pixel width of the hot spot panorama (e.g. 768)
   (hotSpotSizeY :UInt32)                       ;  pixel height of the hot spot panorama (e.g. 2496)
   (hotSpotNumFramesX :UInt16)                  ;  diced frames wide (e.g. 1)
   (hotSpotNumFramesY :UInt16)                  ;  diced frames high (e.g. 24)
   (flags :UInt32)
   (panoType :OSType)
   (reserved2 :UInt32)
)

;type name? (%define-record :QTVRPanoSampleAtom (find-record-descriptor ':QTVRPanoSampleAtom))

(def-mactype :QTVRPanoSampleAtomPtr (find-mactype '(:pointer :QTVRPanoSampleAtom)))
; 
;    View atom for cubes (since same fields in QTVRPanoSampleAtom are set to special
;    values for backwards compatibility and hence are ignored by the cubic engine)
; 
(defrecord QTVRCubicViewAtom
   (minPan :single-float)
   (maxPan :single-float)
   (minTilt :single-float)
   (maxTilt :single-float)
   (minFieldOfView :single-float)
   (maxFieldOfView :single-float)
   (defaultPan :single-float)
   (defaultTilt :single-float)
   (defaultFieldOfView :single-float)
)

;type name? (%define-record :QTVRCubicViewAtom (find-record-descriptor ':QTVRCubicViewAtom))

(def-mactype :QTVRCubicViewAtomPtr (find-mactype '(:pointer :QTVRCubicViewAtom)))
(defrecord QTVRCubicFaceData
   (orientation (:array :single-float 4))       ;  WXYZ quaternion of absolute orientation
   (center (:array :single-float 2))            ;  Center of image relative to center of projection (default = (0,0)) in normalized units
   (aspect :single-float)                       ;  aspect>1 => tall pixels; aspect <1 => squat pixels (default = 1)
   (skew :single-float)                         ;  skew x by y (default = 0)
)

;type name? (%define-record :QTVRCubicFaceData (find-record-descriptor ':QTVRCubicFaceData))

(def-mactype :QTVRCubicFaceDataPtr (find-mactype '(:pointer :QTVRCubicFaceData)))
;  Special resolution values for the Image Track Reference Atoms. Use only one value per track reference.

(defconstant $kQTVRFullTrackRes 1)
(defconstant $kQTVRHalfTrackRes 2)
(defconstant $kQTVRQuarterTrackRes 4)
(defconstant $kQTVRPreviewTrackRes #x8000)
(defrecord QTVRTrackRefEntry
   (trackRefType :UInt32)
   (trackResolution :UInt16)
   (trackRefIndex :UInt32)
)

;type name? (%define-record :QTVRTrackRefEntry (find-record-descriptor ':QTVRTrackRefEntry))
; 
;   =================================================================================================
;    Object File format 2.0
;   -------------------------------------------------------------------------------------------------
; 

(defconstant $kQTVRObjectAnimateViewFramesOn 1)
(defconstant $kQTVRObjectPalindromeViewFramesOn 2)
(defconstant $kQTVRObjectStartFirstViewFrameOn 4)
(defconstant $kQTVRObjectAnimateViewsOn 8)
(defconstant $kQTVRObjectPalindromeViewsOn 16)
(defconstant $kQTVRObjectSyncViewToFrameRate 32)
(defconstant $kQTVRObjectDontLoopViewFramesOn 64)
(defconstant $kQTVRObjectPlayEveryViewFrameOn #x80)
(defconstant $kQTVRObjectStreamingViewsOn #x100)

(defconstant $kQTVRObjectWrapPanOn 1)
(defconstant $kQTVRObjectWrapTiltOn 2)
(defconstant $kQTVRObjectCanZoomOn 4)
(defconstant $kQTVRObjectReverseHControlOn 8)
(defconstant $kQTVRObjectReverseVControlOn 16)
(defconstant $kQTVRObjectSwapHVControlOn 32)
(defconstant $kQTVRObjectTranslationOn 64)

(defconstant $kGrabberScrollerUI 1)             ;  "Object" 

(defconstant $kOldJoyStickUI 2)                 ;   "1.0 Object as Scene"     

(defconstant $kJoystickUI 3)                    ;  "Object In Scene"

(defconstant $kGrabberUI 4)                     ;  "Grabber only"

(defconstant $kAbsoluteUI 5)                    ;  "Absolute pointer"

(defrecord QTVRObjectSampleAtom
   (majorVersion :UInt16)                       ;  kQTVRMajorVersion
   (minorVersion :UInt16)                       ;  kQTVRMinorVersion
   (movieType :UInt16)                          ;  ObjectUITypes
   (viewStateCount :UInt16)                     ;  The number of view states 1 based
   (defaultViewState :UInt16)                   ;  The default view state number. The number must be 1 to viewStateCount
   (mouseDownViewState :UInt16)                 ;  The mouse down view state.   The number must be 1 to viewStateCount
   (viewDuration :UInt32)                       ;  The duration of each view including all animation frames in a view
   (columns :UInt32)                            ;  Number of columns in movie
   (rows :UInt32)                               ;  Number rows in movie
   (mouseMotionScale :single-float)             ;  180.0 for kStandardObject or kQTVRObjectInScene, actual degrees for kOldNavigableMovieScene.
   (minPan :single-float)                       ;  Start   horizontal pan angle in degrees
   (maxPan :single-float)                       ;  End     horizontal pan angle in degrees
   (defaultPan :single-float)                   ;  Initial horizontal pan angle in degrees (poster view)
   (minTilt :single-float)                      ;  Start   vertical   pan angle in degrees
   (maxTilt :single-float)                      ;  End     vertical   pan angle in degrees
   (defaultTilt :single-float)                  ;  Initial vertical   pan angle in degrees (poster view)  
   (minFieldOfView :single-float)               ;  minimum field of view setting (appears as the maximum zoom effect) must be >= 1
   (fieldOfView :single-float)                  ;  the field of view range must be >= 1
   (defaultFieldOfView :single-float)           ;  must be in minFieldOfView and maxFieldOfView range inclusive
   (defaultViewCenterH :single-float)
   (defaultViewCenterV :single-float)
   (viewRate :single-float)
   (frameRate :single-float)
   (animationSettings :UInt32)                  ;  32 reserved bit fields
   (controlSettings :UInt32)                    ;  32 reserved bit fields
)

;type name? (%define-record :QTVRObjectSampleAtom (find-record-descriptor ':QTVRObjectSampleAtom))

(def-mactype :QTVRObjectSampleAtomPtr (find-mactype '(:pointer :QTVRObjectSampleAtom)))
; 
;   =================================================================================================
;    QuickTime VR Authoring Components
;   -------------------------------------------------------------------------------------------------
; 
; 
;    ComponentDescription constants for QTVR Export components   
;     (componentType = MovieExportType; componentSubType = MovieFileType)
; 

(defconstant $kQTVRFlattenerManufacturer :|vrwe|);  aka QTVRFlattenerType

(defconstant $kQTVRSplitterManufacturer :|vrsp|)
(defconstant $kQTVRObjExporterManufacturer :|vrob|)
;  QuickTime VR Flattener atom types

(defconstant $kQTVRFlattenerSettingsParentAtomType :|VRWe|);  parent of settings atoms (other than compression)

(defconstant $kQTVRFlattenerPreviewResAtomType :|PRes|);  preview resolution Int16

(defconstant $kQTVRFlattenerImportSpecAtomType :|ISpe|);  import file spec FSSpec

(defconstant $kQTVRFlattenerCreatePreviewAtomType :|Prev|);  Boolean

(defconstant $kQTVRFlattenerImportPreviewAtomType :|IPre|);  Boolean

(defconstant $kQTVRFlattenerBlurPreviewAtomType :|Blur|);  Boolean

;  QuickTime VR Splitter atom types

(defconstant $kQTVRSplitterSettingsParentAtomType :|VRSp|);  parent of settings atoms (other than compression)

(defconstant $kQTVRSplitterGenerateHTMLAtomType :|Ghtm|);  Boolean

(defconstant $kQTVRSplitterOverwriteFilesAtomType :|Owfi|);  Boolean

(defconstant $kQTVRSplitterUseFlattenerAtomType :|Usef|);  Boolean

(defconstant $kQTVRSplitterShowControllerAtomType :|Shco|);  Boolean

(defconstant $kQTVRSplitterTargetMyselfAtomType :|Tgtm|);  Boolean

;  QuickTime VR Object Exporter atom types

(defconstant $kQTVRObjExporterSettingsBlockSize :|bsiz|);  block size for compression

(defconstant $kQTVRObjExporterSettingsTargetSize :|tsiz|);  target file size


; #if OLDROUTINENAMES
#| 
(%define-record :VRStringAtom (find-record-descriptor ':QTVRStringAtom))

(%define-record :VRWorldHeaderAtom (find-record-descriptor ':QTVRWorldHeaderAtom))

(%define-record :VRPanoImagingAtom (find-record-descriptor ':QTVRPanoImagingAtom))

(%define-record :VRNodeLocationAtom (find-record-descriptor ':QTVRNodeLocationAtom))

(%define-record :VRNodeHeaderAtom (find-record-descriptor ':QTVRNodeHeaderAtom))

(%define-record :VRAngleRangeAtom (find-record-descriptor ':QTVRAngleRangeAtom))

(%define-record :VRHotSpotInfoAtom (find-record-descriptor ':QTVRHotSpotInfoAtom))

(%define-record :VRLinkHotSpotAtom (find-record-descriptor ':QTVRLinkHotSpotAtom))

(%define-record :VRPanoSampleAtom (find-record-descriptor ':QTVRPanoSampleAtom))

(%define-record :VRTrackRefEntry (find-record-descriptor ':QTVRTrackRefEntry))

(%define-record :VRObjectSampleAtom (find-record-descriptor ':QTVRObjectSampleAtom))
 |#

; #endif  /* OLDROUTINENAMES */

; #pragma options align=reset

; #endif /* __QUICKTIMEVRFORMAT__ */


(provide-interface "QuickTimeVRFormat")