(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:MediaHandlers.h"
; at Sunday July 2,2006 7:30:27 pm.
; 
;      File:       QuickTime/MediaHandlers.h
;  
;      Contains:   QuickTime Interfaces.
;  
;      Version:    QuickTime_6
;  
;      Copyright:  © 1990-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __MEDIAHANDLERS__
; #define __MEDIAHANDLERS__
; #ifndef __CARBON__
#| #|
#include <CarbonCarbon.h>
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

(def-mactype :PrePrerollCompleteProcPtr (find-mactype ':pointer)); (MediaHandler mh , OSErr err , void * refcon)

(def-mactype :PrePrerollCompleteUPP (find-mactype '(:pointer :OpaquePrePrerollCompleteProcPtr)))

(defconstant $handlerHasSpatial 1)
(defconstant $handlerCanClip 2)
(defconstant $handlerCanMatte 4)
(defconstant $handlerCanTransferMode 8)
(defconstant $handlerNeedsBuffer 16)
(defconstant $handlerNoIdle 32)
(defconstant $handlerNoScheduler 64)
(defconstant $handlerWantsTime #x80)
(defconstant $handlerCGrafPortOnly #x100)
(defconstant $handlerCanSend #x200)
(defconstant $handlerCanHandleComplexMatrix #x400)
(defconstant $handlerWantsDestinationPixels #x800)
(defconstant $handlerCanSendImageData #x1000)
(defconstant $handlerCanPicSave #x2000)
;  media task flags 

(defconstant $mMustDraw 8)
(defconstant $mAtEnd 16)
(defconstant $mPreflightDraw 32)
(defconstant $mSyncDrawing 64)
(defconstant $mPrecompositeOnly #x200)
(defconstant $mSoundOnly #x400)
(defconstant $mDoIdleActionsBeforeDraws #x800)
(defconstant $mDisableIdleActions #x1000)
;  media task result flags 

(defconstant $mDidDraw 1)
(defconstant $mNeedsToDraw 4)
(defconstant $mDrawAgain 8)
(defconstant $mPartialDraw 16)
(defconstant $mWantIdleActions 32)

(defconstant $forceUpdateRedraw 1)
(defconstant $forceUpdateNewBuffer 2)
;  media hit test flags 

(defconstant $mHitTestBounds 1)                 ;     point must only be within targetRefCon's bounding box 

(defconstant $mHitTestImage 2)                  ;   point must be within the shape of the targetRefCon's image 

(defconstant $mHitTestInvisible 4)              ;   invisible targetRefCon's may be hit tested 
;   for codecs that want mouse events 

(defconstant $mHitTestIsClick 8)
;  media is opaque flags 

(defconstant $mOpaque 1)
(defconstant $mInvisible 2)
;  MediaSetPublicInfo/MediaGetPublicInfo selectors 

(defconstant $kMediaQTIdleFrequencySelector :|idfq|)
(defrecord GetMovieCompleteParams
   (version :SInt16)
   (theMovie (:Handle :MovieType))
   (theTrack (:Handle :TrackType))
   (theMedia (:Handle :MediaType))
   (movieScale :signed-long)
   (mediaScale :signed-long)
   (movieDuration :signed-long)
   (trackDuration :signed-long)
   (mediaDuration :signed-long)
   (effectiveRate :signed-long)
   (timeBase (:pointer :TimeBaseRecord))
   (volume :SInt16)
   (width :signed-long)
   (height :signed-long)
   (trackMovieMatrix :MatrixRecord)
   (moviePort (:pointer :OpaqueGrafPtr))
   (movieGD (:Handle :GDEVICE))
   (trackMatte (:Handle :PixMap))
   (inputMap :Handle)
   (mediaContextID :QTUUID)
)

;type name? (%define-record :GetMovieCompleteParams (find-record-descriptor ':GetMovieCompleteParams))

(defconstant $kMediaVideoParamBrightness 1)
(defconstant $kMediaVideoParamContrast 2)
(defconstant $kMediaVideoParamHue 3)
(defconstant $kMediaVideoParamSharpness 4)
(defconstant $kMediaVideoParamSaturation 5)
(defconstant $kMediaVideoParamBlackLevel 6)
(defconstant $kMediaVideoParamWhiteLevel 7)
;  These are for MediaGetInfo() and MediaSetInfo().

(defconstant $kMHInfoEncodedFrameRate :|orat|)  ;  Parameter is a MHInfoEncodedFrameRateRecord*.

;  This holds the frame rate at which the track was encoded.
(defrecord MHInfoEncodedFrameRateRecord
   (encodedFrameRate :signed-long)
)

;type name? (%define-record :MHInfoEncodedFrameRateRecord (find-record-descriptor ':MHInfoEncodedFrameRateRecord))

(def-mactype :dataHandlePtr (find-mactype '(:pointer :Handle)))

(def-mactype :dataHandleHandle (find-mactype '(:handle :Handle)))
(defrecord QTCustomActionTargetRecord
   (movie (:Handle :MovieType))
   (doMCActionCallbackProc (:pointer :OpaqueDoMCActionProcPtr))
   (callBackRefcon :signed-long)
   (track (:Handle :TrackType))
   (trackObjectRefCon :signed-long)
   (defaultTrack (:Handle :TrackType))
   (defaultObjectRefCon :signed-long)
   (reserved1 :signed-long)
   (reserved2 :signed-long)
)

;type name? (%define-record :QTCustomActionTargetRecord (find-record-descriptor ':QTCustomActionTargetRecord))

(def-mactype :QTCustomActionTargetPtr (find-mactype '(:pointer :QTCustomActionTargetRecord)))
(defrecord MediaEQSpectrumBandsRecord
   (count :SInt16)
   (frequency (:pointer :UInt32))               ;  pointer to array of frequencies
)

;type name? (%define-record :MediaEQSpectrumBandsRecord (find-record-descriptor ':MediaEQSpectrumBandsRecord))

(def-mactype :MediaEQSpectrumBandsRecordPtr (find-mactype '(:pointer :MediaEQSpectrumBandsRecord)))
; 
;  *  CallComponentExecuteWiredAction()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_CallComponentExecuteWiredAction" 
   ((ci (:pointer :ComponentInstanceRecord))
    (actionContainer :Handle)
    (actionAtom :signed-long)
    (target (:pointer :QTCustomActionTargetRecord))
    (event (:pointer :QTEventRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  MediaCallRange2 
;  These are unique to each type of media handler 
;  They are also included in the public interfaces 
;  Flags for MediaSetChunkManagementFlags

(defconstant $kEmptyPurgableChunksOverAllowance 1)
; 
;  *  MediaSetChunkManagementFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MediaSetChunkManagementFlags" 
   ((mh (:pointer :ComponentInstanceRecord))
    (flags :UInt32)
    (flagsMask :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetChunkManagementFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MediaGetChunkManagementFlags" 
   ((mh (:pointer :ComponentInstanceRecord))
    (flags (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetPurgeableChunkMemoryAllowance()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MediaSetPurgeableChunkMemoryAllowance" 
   ((mh (:pointer :ComponentInstanceRecord))
    (allowance :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetPurgeableChunkMemoryAllowance()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MediaGetPurgeableChunkMemoryAllowance" 
   ((mh (:pointer :ComponentInstanceRecord))
    (allowance (:pointer :SIZE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  MediaEmptyAllPurgeableChunks()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MediaEmptyAllPurgeableChunks" 
   ((mh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; **** These are the calls for dealing with the Generic media handler ****
; 
;  *  MediaInitialize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaInitialize" 
   ((mh (:pointer :ComponentInstanceRecord))
    (gmc (:pointer :GetMovieCompleteParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetHandlerCapabilities()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetHandlerCapabilities" 
   ((mh (:pointer :ComponentInstanceRecord))
    (flags :signed-long)
    (flagsMask :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaIdle" 
   ((mh (:pointer :ComponentInstanceRecord))
    (atMediaTime :signed-long)
    (flagsIn :signed-long)
    (flagsOut (:pointer :long))
    (movieTime (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetMediaInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetMediaInfo" 
   ((mh (:pointer :ComponentInstanceRecord))
    (h :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaPutMediaInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaPutMediaInfo" 
   ((mh (:pointer :ComponentInstanceRecord))
    (h :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetActive()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetActive" 
   ((mh (:pointer :ComponentInstanceRecord))
    (enableMedia :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetRate" 
   ((mh (:pointer :ComponentInstanceRecord))
    (rate :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGGetStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGGetStatus" 
   ((mh (:pointer :ComponentInstanceRecord))
    (statusErr (:pointer :ComponentResult))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaTrackEdited()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaTrackEdited" 
   ((mh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetMediaTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetMediaTimeScale" 
   ((mh (:pointer :ComponentInstanceRecord))
    (newTimeScale :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetMovieTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetMovieTimeScale" 
   ((mh (:pointer :ComponentInstanceRecord))
    (newTimeScale :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetGWorld" 
   ((mh (:pointer :ComponentInstanceRecord))
    (aPort (:pointer :OpaqueGrafPtr))
    (aGD (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetDimensions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetDimensions" 
   ((mh (:pointer :ComponentInstanceRecord))
    (width :signed-long)
    (height :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetClip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetClip" 
   ((mh (:pointer :ComponentInstanceRecord))
    (theClip (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetMatrix" 
   ((mh (:pointer :ComponentInstanceRecord))
    (trackMovieMatrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetTrackOpaque()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetTrackOpaque" 
   ((mh (:pointer :ComponentInstanceRecord))
    (trackIsOpaque (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetGraphicsMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetGraphicsMode" 
   ((mh (:pointer :ComponentInstanceRecord))
    (mode :signed-long)
    (opColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetGraphicsMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetGraphicsMode" 
   ((mh (:pointer :ComponentInstanceRecord))
    (mode (:pointer :long))
    (opColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGSetVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGSetVolume" 
   ((mh (:pointer :ComponentInstanceRecord))
    (volume :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetSoundBalance()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetSoundBalance" 
   ((mh (:pointer :ComponentInstanceRecord))
    (balance :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetSoundBalance()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetSoundBalance" 
   ((mh (:pointer :ComponentInstanceRecord))
    (balance (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetNextBoundsChange()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetNextBoundsChange" 
   ((mh (:pointer :ComponentInstanceRecord))
    (when (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetSrcRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetSrcRgn" 
   ((mh (:pointer :ComponentInstanceRecord))
    (rgn (:pointer :OpaqueRgnHandle))
    (atMediaTime :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaPreroll()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaPreroll" 
   ((mh (:pointer :ComponentInstanceRecord))
    (time :signed-long)
    (rate :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSampleDescriptionChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSampleDescriptionChanged" 
   ((mh (:pointer :ComponentInstanceRecord))
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaHasCharacteristic()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaHasCharacteristic" 
   ((mh (:pointer :ComponentInstanceRecord))
    (characteristic :OSType)
    (hasIt (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetOffscreenBufferSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetOffscreenBufferSize" 
   ((mh (:pointer :ComponentInstanceRecord))
    (bounds (:pointer :Rect))
    (depth :SInt16)
    (ctab (:Handle :ColorTable))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetHints()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetHints" 
   ((mh (:pointer :ComponentInstanceRecord))
    (hints :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetName" 
   ((mh (:pointer :ComponentInstanceRecord))
    (name (:pointer :STR255))
    (requestedLanguage :signed-long)
    (actualLanguage (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaForceUpdate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaForceUpdate" 
   ((mh (:pointer :ComponentInstanceRecord))
    (forceUpdateFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetDrawingRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetDrawingRgn" 
   ((mh (:pointer :ComponentInstanceRecord))
    (partialRgn (:pointer :RGNHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGSetActiveSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGSetActiveSegment" 
   ((mh (:pointer :ComponentInstanceRecord))
    (activeStart :signed-long)
    (activeDuration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaInvalidateRegion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaInvalidateRegion" 
   ((mh (:pointer :ComponentInstanceRecord))
    (invalRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetNextStepTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetNextStepTime" 
   ((mh (:pointer :ComponentInstanceRecord))
    (flags :SInt16)
    (mediaTimeIn :signed-long)
    (mediaTimeOut (:pointer :TIMEVALUE))
    (rate :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetNonPrimarySourceData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetNonPrimarySourceData" 
   ((mh (:pointer :ComponentInstanceRecord))
    (inputIndex :signed-long)
    (dataDescriptionSeed :signed-long)
    (dataDescription :Handle)
    (data :pointer)
    (dataSize :signed-long)
    (asyncCompletionProc (:pointer :ICMCompletionProcRecord))
    (transferProc (:pointer :OpaqueICMConvertDataFormatProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaChangedNonPrimarySource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaChangedNonPrimarySource" 
   ((mh (:pointer :ComponentInstanceRecord))
    (inputIndex :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaTrackReferencesChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaTrackReferencesChanged" 
   ((mh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetSampleDataPointer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetSampleDataPointer" 
   ((mh (:pointer :ComponentInstanceRecord))
    (sampleNum :signed-long)
    (dataPtr (:pointer :Ptr))
    (dataSize (:pointer :long))
    (sampleDescIndex (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaReleaseSampleDataPointer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaReleaseSampleDataPointer" 
   ((mh (:pointer :ComponentInstanceRecord))
    (sampleNum :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaTrackPropertyAtomChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaTrackPropertyAtomChanged" 
   ((mh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetTrackInputMapReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetTrackInputMapReference" 
   ((mh (:pointer :ComponentInstanceRecord))
    (inputMap :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetVideoParam()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetVideoParam" 
   ((mh (:pointer :ComponentInstanceRecord))
    (whichParam :signed-long)
    (value (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetVideoParam()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetVideoParam" 
   ((mh (:pointer :ComponentInstanceRecord))
    (whichParam :signed-long)
    (value (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaCompare()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaCompare" 
   ((mh (:pointer :ComponentInstanceRecord))
    (isOK (:pointer :Boolean))
    (srcMedia (:Handle :MediaType))
    (srcMediaComponent (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetClock()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetClock" 
   ((mh (:pointer :ComponentInstanceRecord))
    (clock (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetSoundOutputComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetSoundOutputComponent" 
   ((mh (:pointer :ComponentInstanceRecord))
    (outputComponent (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetSoundOutputComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetSoundOutputComponent" 
   ((mh (:pointer :ComponentInstanceRecord))
    (outputComponent (:pointer :Component))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetSoundLocalizationData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetSoundLocalizationData" 
   ((mh (:pointer :ComponentInstanceRecord))
    (data :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetInvalidRegion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetInvalidRegion" 
   ((mh (:pointer :ComponentInstanceRecord))
    (rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSampleDescriptionB2N()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSampleDescriptionB2N" 
   ((mh (:pointer :ComponentInstanceRecord))
    (sampleDescriptionH (:Handle :SampleDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSampleDescriptionN2B()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSampleDescriptionN2B" 
   ((mh (:pointer :ComponentInstanceRecord))
    (sampleDescriptionH (:Handle :SampleDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaQueueNonPrimarySourceData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaQueueNonPrimarySourceData" 
   ((mh (:pointer :ComponentInstanceRecord))
    (inputIndex :signed-long)
    (dataDescriptionSeed :signed-long)
    (dataDescription :Handle)
    (data :pointer)
    (dataSize :signed-long)
    (asyncCompletionProc (:pointer :ICMCompletionProcRecord))
    (frameTime (:pointer :ICMFrameTimeRecord))
    (transferProc (:pointer :OpaqueICMConvertDataFormatProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaFlushNonPrimarySourceData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaFlushNonPrimarySourceData" 
   ((mh (:pointer :ComponentInstanceRecord))
    (inputIndex :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetURLLink()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetURLLink" 
   ((mh (:pointer :ComponentInstanceRecord))
    (displayWhere :Point)
    (urlLink (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaMakeMediaTimeTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaMakeMediaTimeTable" 
   ((mh (:pointer :ComponentInstanceRecord))
    (offsets (:pointer :long))
    (startTime :signed-long)
    (endTime :signed-long)
    (timeIncrement :signed-long)
    (firstDataRefIndex :SInt16)
    (lastDataRefIndex :SInt16)
    (retDataRefSkew (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaHitTestForTargetRefCon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaHitTestForTargetRefCon" 
   ((mh (:pointer :ComponentInstanceRecord))
    (flags :signed-long)
    (loc :Point)
    (targetRefCon (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaHitTestTargetRefCon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaHitTestTargetRefCon" 
   ((mh (:pointer :ComponentInstanceRecord))
    (targetRefCon :signed-long)
    (flags :signed-long)
    (loc :Point)
    (wasHit (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetActionsForQTEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaGetActionsForQTEvent" 
   ((mh (:pointer :ComponentInstanceRecord))
    (event (:pointer :QTEventRecord))
    (targetRefCon :signed-long)
    (container (:pointer :QTATOMCONTAINER))
    (atom (:pointer :QTATOM))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaDisposeTargetRefCon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaDisposeTargetRefCon" 
   ((mh (:pointer :ComponentInstanceRecord))
    (targetRefCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaTargetRefConsEqual()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaTargetRefConsEqual" 
   ((mh (:pointer :ComponentInstanceRecord))
    (firstRefCon :signed-long)
    (secondRefCon :signed-long)
    (equal (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetActionsCallback()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaSetActionsCallback" 
   ((mh (:pointer :ComponentInstanceRecord))
    (actionsCallbackProc (:pointer :OpaqueActionsProcPtr))
    (refcon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaPrePrerollBegin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaPrePrerollBegin" 
   ((mh (:pointer :ComponentInstanceRecord))
    (time :signed-long)
    (rate :signed-long)
    (completeProc (:pointer :OpaquePrePrerollCompleteProcPtr))
    (refcon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaPrePrerollCancel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaPrePrerollCancel" 
   ((mh (:pointer :ComponentInstanceRecord))
    (refcon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaEnterEmptyEdit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaEnterEmptyEdit" 
   ((mh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaCurrentMediaQueuedData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MediaCurrentMediaQueuedData" 
   ((mh (:pointer :ComponentInstanceRecord))
    (milliSecs (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetEffectiveVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaGetEffectiveVolume" 
   ((mh (:pointer :ComponentInstanceRecord))
    (volume (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaResolveTargetRefCon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaResolveTargetRefCon" 
   ((mh (:pointer :ComponentInstanceRecord))
    (container :Handle)
    (atom :signed-long)
    (targetRefCon (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetSoundLevelMeteringEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaGetSoundLevelMeteringEnabled" 
   ((mh (:pointer :ComponentInstanceRecord))
    (enabled (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetSoundLevelMeteringEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaSetSoundLevelMeteringEnabled" 
   ((mh (:pointer :ComponentInstanceRecord))
    (enable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetSoundLevelMeterInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaGetSoundLevelMeterInfo" 
   ((mh (:pointer :ComponentInstanceRecord))
    (levelInfo (:pointer :LevelMeterInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetEffectiveSoundBalance()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaGetEffectiveSoundBalance" 
   ((mh (:pointer :ComponentInstanceRecord))
    (balance (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetScreenLock()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaSetScreenLock" 
   ((mh (:pointer :ComponentInstanceRecord))
    (lockIt :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetDoMCActionCallback()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaSetDoMCActionCallback" 
   ((mh (:pointer :ComponentInstanceRecord))
    (doMCActionCallbackProc (:pointer :OpaqueDoMCActionProcPtr))
    (refcon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetErrorString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaGetErrorString" 
   ((mh (:pointer :ComponentInstanceRecord))
    (theError :signed-long)
    (errorString (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetSoundEqualizerBands()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaGetSoundEqualizerBands" 
   ((mh (:pointer :ComponentInstanceRecord))
    (spectrumInfo (:pointer :MediaEQSpectrumBandsRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetSoundEqualizerBands()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaSetSoundEqualizerBands" 
   ((mh (:pointer :ComponentInstanceRecord))
    (spectrumInfo (:pointer :MediaEQSpectrumBandsRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetSoundEqualizerBandLevels()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaGetSoundEqualizerBandLevels" 
   ((mh (:pointer :ComponentInstanceRecord))
    (bandLevels (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaDoIdleActions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaDoIdleActions" 
   ((mh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetSoundBassAndTreble()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaSetSoundBassAndTreble" 
   ((mh (:pointer :ComponentInstanceRecord))
    (bass :SInt16)
    (treble :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetSoundBassAndTreble()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaGetSoundBassAndTreble" 
   ((mh (:pointer :ComponentInstanceRecord))
    (bass (:pointer :short))
    (treble (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaTimeBaseChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MediaTimeBaseChanged" 
   ((mh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaMCIsPlayerEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_MediaMCIsPlayerEvent" 
   ((mh (:pointer :ComponentInstanceRecord))
    (e (:pointer :EventRecord))
    (handledIt (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetMediaLoadState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_MediaGetMediaLoadState" 
   ((mh (:pointer :ComponentInstanceRecord))
    (mediaLoadState (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaVideoOutputChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_MediaVideoOutputChanged" 
   ((mh (:pointer :ComponentInstanceRecord))
    (vout (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaEmptySampleCache()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_MediaEmptySampleCache" 
   ((mh (:pointer :ComponentInstanceRecord))
    (sampleNum :signed-long)
    (sampleCount :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetPublicInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_MediaGetPublicInfo" 
   ((mh (:pointer :ComponentInstanceRecord))
    (infoSelector :OSType)
    (infoDataPtr :pointer)
    (ioDataSize (:pointer :SIZE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetPublicInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_MediaSetPublicInfo" 
   ((mh (:pointer :ComponentInstanceRecord))
    (infoSelector :OSType)
    (infoDataPtr :pointer)
    (dataSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaGetUserPreferredCodecs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_MediaGetUserPreferredCodecs" 
   ((mh (:pointer :ComponentInstanceRecord))
    (userPreferredCodecs (:pointer :CODECCOMPONENTHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MediaSetUserPreferredCodecs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_MediaSetUserPreferredCodecs" 
   ((mh (:pointer :ComponentInstanceRecord))
    (userPreferredCodecs (:pointer :CodecComponentPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Keyboard Focus Support
; 
;  *  MediaRefConSetProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MediaRefConSetProperty" 
   ((mh (:pointer :ComponentInstanceRecord))
    (refCon :signed-long)
    (propertyType :signed-long)
    (propertyValue :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  MediaRefConGetProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MediaRefConGetProperty" 
   ((mh (:pointer :ComponentInstanceRecord))
    (refCon :signed-long)
    (propertyType :signed-long)
    (propertyValue :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  MediaNavigateTargetRefCon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MediaNavigateTargetRefCon" 
   ((mh (:pointer :ComponentInstanceRecord))
    (navigation :signed-long)
    (refCon (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  MediaGGetIdleManager()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MediaGGetIdleManager" 
   ((mh (:pointer :ComponentInstanceRecord))
    (pim (:pointer :IDLEMANAGER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  MediaGSetIdleManager()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MediaGSetIdleManager" 
   ((mh (:pointer :ComponentInstanceRecord))
    (im (:pointer :OpaqueIdleManager))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  MediaGGetLatency()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_MediaGGetLatency" 
   ((mh (:pointer :ComponentInstanceRecord))
    (latency (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
;  selectors for component calls 

(defconstant $kCallComponentExecuteWiredActionSelect -9)
(defconstant $kMediaSetChunkManagementFlagsSelect #x415)
(defconstant $kMediaGetChunkManagementFlagsSelect #x416)
(defconstant $kMediaSetPurgeableChunkMemoryAllowanceSelect #x417)
(defconstant $kMediaGetPurgeableChunkMemoryAllowanceSelect #x418)
(defconstant $kMediaEmptyAllPurgeableChunksSelect #x419)
(defconstant $kMediaInitializeSelect #x501)
(defconstant $kMediaSetHandlerCapabilitiesSelect #x502)
(defconstant $kMediaIdleSelect #x503)
(defconstant $kMediaGetMediaInfoSelect #x504)
(defconstant $kMediaPutMediaInfoSelect #x505)
(defconstant $kMediaSetActiveSelect #x506)
(defconstant $kMediaSetRateSelect #x507)
(defconstant $kMediaGGetStatusSelect #x508)
(defconstant $kMediaTrackEditedSelect #x509)
(defconstant $kMediaSetMediaTimeScaleSelect #x50A)
(defconstant $kMediaSetMovieTimeScaleSelect #x50B)
(defconstant $kMediaSetGWorldSelect #x50C)
(defconstant $kMediaSetDimensionsSelect #x50D)
(defconstant $kMediaSetClipSelect #x50E)
(defconstant $kMediaSetMatrixSelect #x50F)
(defconstant $kMediaGetTrackOpaqueSelect #x510)
(defconstant $kMediaSetGraphicsModeSelect #x511)
(defconstant $kMediaGetGraphicsModeSelect #x512)
(defconstant $kMediaGSetVolumeSelect #x513)
(defconstant $kMediaSetSoundBalanceSelect #x514)
(defconstant $kMediaGetSoundBalanceSelect #x515)
(defconstant $kMediaGetNextBoundsChangeSelect #x516)
(defconstant $kMediaGetSrcRgnSelect #x517)
(defconstant $kMediaPrerollSelect #x518)
(defconstant $kMediaSampleDescriptionChangedSelect #x519)
(defconstant $kMediaHasCharacteristicSelect #x51A)
(defconstant $kMediaGetOffscreenBufferSizeSelect #x51B)
(defconstant $kMediaSetHintsSelect #x51C)
(defconstant $kMediaGetNameSelect #x51D)
(defconstant $kMediaForceUpdateSelect #x51E)
(defconstant $kMediaGetDrawingRgnSelect #x51F)
(defconstant $kMediaGSetActiveSegmentSelect #x520)
(defconstant $kMediaInvalidateRegionSelect #x521)
(defconstant $kMediaGetNextStepTimeSelect #x522)
(defconstant $kMediaSetNonPrimarySourceDataSelect #x523)
(defconstant $kMediaChangedNonPrimarySourceSelect #x524)
(defconstant $kMediaTrackReferencesChangedSelect #x525)
(defconstant $kMediaGetSampleDataPointerSelect #x526)
(defconstant $kMediaReleaseSampleDataPointerSelect #x527)
(defconstant $kMediaTrackPropertyAtomChangedSelect #x528)
(defconstant $kMediaSetTrackInputMapReferenceSelect #x529)
(defconstant $kMediaSetVideoParamSelect #x52B)
(defconstant $kMediaGetVideoParamSelect #x52C)
(defconstant $kMediaCompareSelect #x52D)
(defconstant $kMediaGetClockSelect #x52E)
(defconstant $kMediaSetSoundOutputComponentSelect #x52F)
(defconstant $kMediaGetSoundOutputComponentSelect #x530)
(defconstant $kMediaSetSoundLocalizationDataSelect #x531)
(defconstant $kMediaGetInvalidRegionSelect #x53C)
(defconstant $kMediaSampleDescriptionB2NSelect #x53E)
(defconstant $kMediaSampleDescriptionN2BSelect #x53F)
(defconstant $kMediaQueueNonPrimarySourceDataSelect #x540)
(defconstant $kMediaFlushNonPrimarySourceDataSelect #x541)
(defconstant $kMediaGetURLLinkSelect #x543)
(defconstant $kMediaMakeMediaTimeTableSelect #x545)
(defconstant $kMediaHitTestForTargetRefConSelect #x546)
(defconstant $kMediaHitTestTargetRefConSelect #x547)
(defconstant $kMediaGetActionsForQTEventSelect #x548)
(defconstant $kMediaDisposeTargetRefConSelect #x549)
(defconstant $kMediaTargetRefConsEqualSelect #x54A)
(defconstant $kMediaSetActionsCallbackSelect #x54B)
(defconstant $kMediaPrePrerollBeginSelect #x54C)
(defconstant $kMediaPrePrerollCancelSelect #x54D)
(defconstant $kMediaEnterEmptyEditSelect #x54F)
(defconstant $kMediaCurrentMediaQueuedDataSelect #x550)
(defconstant $kMediaGetEffectiveVolumeSelect #x551)
(defconstant $kMediaResolveTargetRefConSelect #x552)
(defconstant $kMediaGetSoundLevelMeteringEnabledSelect #x553)
(defconstant $kMediaSetSoundLevelMeteringEnabledSelect #x554)
(defconstant $kMediaGetSoundLevelMeterInfoSelect #x555)
(defconstant $kMediaGetEffectiveSoundBalanceSelect #x556)
(defconstant $kMediaSetScreenLockSelect #x557)
(defconstant $kMediaSetDoMCActionCallbackSelect #x558)
(defconstant $kMediaGetErrorStringSelect #x559)
(defconstant $kMediaGetSoundEqualizerBandsSelect #x55A)
(defconstant $kMediaSetSoundEqualizerBandsSelect #x55B)
(defconstant $kMediaGetSoundEqualizerBandLevelsSelect #x55C)
(defconstant $kMediaDoIdleActionsSelect #x55D)
(defconstant $kMediaSetSoundBassAndTrebleSelect #x55E)
(defconstant $kMediaGetSoundBassAndTrebleSelect #x55F)
(defconstant $kMediaTimeBaseChangedSelect #x560)
(defconstant $kMediaMCIsPlayerEventSelect #x561)
(defconstant $kMediaGetMediaLoadStateSelect #x562)
(defconstant $kMediaVideoOutputChangedSelect #x563)
(defconstant $kMediaEmptySampleCacheSelect #x564)
(defconstant $kMediaGetPublicInfoSelect #x565)
(defconstant $kMediaSetPublicInfoSelect #x566)
(defconstant $kMediaGetUserPreferredCodecsSelect #x567)
(defconstant $kMediaSetUserPreferredCodecsSelect #x568)
(defconstant $kMediaRefConSetPropertySelect #x569)
(defconstant $kMediaRefConGetPropertySelect #x56A)
(defconstant $kMediaNavigateTargetRefConSelect #x56B)
(defconstant $kMediaGGetIdleManagerSelect #x56C)
(defconstant $kMediaGSetIdleManagerSelect #x56D)
(defconstant $kMediaGGetLatencySelect #x571)
; 
;  *  NewPrePrerollCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewPrePrerollCompleteUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaquePrePrerollCompleteProcPtr)
() )
; 
;  *  DisposePrePrerollCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposePrePrerollCompleteUPP" 
   ((userUPP (:pointer :OpaquePrePrerollCompleteProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokePrePrerollCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokePrePrerollCompleteUPP" 
   ((mh (:pointer :ComponentInstanceRecord))
    (err :SInt16)
    (refcon :pointer)
    (userUPP (:pointer :OpaquePrePrerollCompleteProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __MEDIAHANDLERS__ */


(provide-interface "MediaHandlers")