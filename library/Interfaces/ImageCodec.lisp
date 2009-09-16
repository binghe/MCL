(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ImageCodec.h"
; at Sunday July 2,2006 7:28:00 pm.
; 
;      File:       QuickTime/ImageCodec.h
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
; #ifndef __IMAGECODEC__
; #define __IMAGECODEC__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __IMAGECOMPRESSION__

(require-interface "QuickTime/ImageCompression")

; #endif

; #ifndef __MOVIES__

(require-interface "QuickTime/Movies")

; #endif


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
; 
;    The following GX types were previously in GXTypes.h, but that header
;    is not available in any Mac OS X framework. 
; 
(defrecord gxPoint
   (x :signed-long)
   (y :signed-long)
)

;type name? (%define-record :gxPoint (find-record-descriptor ':gxPoint))
(defrecord gxPath
   (vectors :signed-long)
   (controlBits (:array :signed-long 1))
   (vector (:array :gxPoint 1))
)

;type name? (%define-record :gxPath (find-record-descriptor ':gxPath))
(defrecord gxPaths
   (contours :signed-long)
   (contour (:array :gxPath 1))
)

;type name? (%define-record :gxPaths (find-record-descriptor ':gxPaths))
;   codec capabilities flags    

(defconstant $codecCanScale 1)
(defconstant $codecCanMask 2)
(defconstant $codecCanMatte 4)
(defconstant $codecCanTransform 8)
(defconstant $codecCanTransferMode 16)
(defconstant $codecCanCopyPrev 32)
(defconstant $codecCanSpool 64)
(defconstant $codecCanClipVertical #x80)
(defconstant $codecCanClipRectangular #x100)
(defconstant $codecCanRemapColor #x200)
(defconstant $codecCanFastDither #x400)
(defconstant $codecCanSrcExtract #x800)
(defconstant $codecCanCopyPrevComp #x1000)
(defconstant $codecCanAsync #x2000)
(defconstant $codecCanMakeMask #x4000)
(defconstant $codecCanShift #x8000)
(defconstant $codecCanAsyncWhen #x10000)
(defconstant $codecCanShieldCursor #x20000)
(defconstant $codecCanManagePrevBuffer #x40000)
(defconstant $codecHasVolatileBuffer #x80000)   ;  codec requires redraw after window movement 

(defconstant $codecWantsRegionMask #x100000)
(defconstant $codecImageBufferIsOnScreen #x200000);  old def of codec using overlay surface, = ( codecIsDirectToScreenOnly | codecUsesOverlaySurface | codecImageBufferIsOverlaySurface | codecSrcMustBeImageBuffer ) 

(defconstant $codecWantsDestinationPixels #x400000)
(defconstant $codecWantsSpecialScaling #x800000)
(defconstant $codecHandlesInputs #x1000000)
(defconstant $codecCanDoIndirectSurface #x2000000);  codec can handle indirect surface (GDI) 

(defconstant $codecIsSequenceSensitive #x4000000)
(defconstant $codecRequiresOffscreen #x8000000)
(defconstant $codecRequiresMaskBits #x10000000)
(defconstant $codecCanRemapResolution #x20000000)
(defconstant $codecIsDirectToScreenOnly #x40000000);  codec can only decompress data to the screen 
;  codec can lock destination surface, icm doesn't lock for you 

(defconstant $codecCanLockSurface #x80000000)
;   codec capabilities flags2   

(defconstant $codecUsesOverlaySurface 1)        ;  codec uses overlay surface 

(defconstant $codecImageBufferIsOverlaySurface 2);  codec image buffer is overlay surface, the bits in the buffer are on the screen 

(defconstant $codecSrcMustBeImageBuffer 4)      ;  codec can only source data from an image buffer 

(defconstant $codecImageBufferIsInAGPMemory 16) ;  codec image buffer is in AGP space, byte writes are OK 

(defconstant $codecImageBufferIsInPCIMemory 32) ;  codec image buffer is across a PCI bus; byte writes are bad 

(defconstant $codecImageBufferMemoryFlagsValid 64);  set by ImageCodecNewImageBufferMemory/NewImageGWorld to indicate that it set the AGP/PCI flags (supported in QuickTime 6.0 and later) 
;  codec will draw higher-quality image if it performs scaling (eg, wipe effect with border) 

(defconstant $codecDrawsHigherQualityScaled #x80)
(defrecord CodecCapabilities
   (flags :signed-long)
   (wantedPixelSize :SInt16)
   (extendWidth :SInt16)
   (extendHeight :SInt16)
   (bandMin :SInt16)
   (bandInc :SInt16)
   (pad :SInt16)
   (time :UInt32)
   (flags2 :signed-long)                        ;  field new in QuickTime 4.0 
)

;type name? (%define-record :CodecCapabilities (find-record-descriptor ':CodecCapabilities))
;   codec condition flags   

(defconstant $codecConditionFirstBand 1)
(defconstant $codecConditionLastBand 2)
(defconstant $codecConditionFirstFrame 4)
(defconstant $codecConditionNewDepth 8)
(defconstant $codecConditionNewTransform 16)
(defconstant $codecConditionNewSrcRect 32)
(defconstant $codecConditionNewMask 64)
(defconstant $codecConditionNewMatte #x80)
(defconstant $codecConditionNewTransferMode #x100)
(defconstant $codecConditionNewClut #x200)
(defconstant $codecConditionNewAccuracy #x400)
(defconstant $codecConditionNewDestination #x800)
(defconstant $codecConditionFirstScreen #x1000)
(defconstant $codecConditionDoCursor #x2000)
(defconstant $codecConditionCatchUpDiff #x4000)
(defconstant $codecConditionMaskMayBeChanged #x8000)
(defconstant $codecConditionToBuffer #x10000)
(defconstant $codecConditionCodecChangedMask #x80000000)

(defconstant $codecInfoResourceType :|cdci|)    ;  codec info resource type 

(defconstant $codecInterfaceVersion 2)          ;  high word returned in component GetVersion 

(defrecord CDSequenceDataSourceQueueEntry
   (nextBusy :pointer)
   (descSeed :signed-long)
   (dataDesc :Handle)
   (data :pointer)
   (dataSize :signed-long)
   (useCount :signed-long)
   (frameTime :signed-long)
   (frameDuration :signed-long)
   (timeScale :signed-long)
)

;type name? (%define-record :CDSequenceDataSourceQueueEntry (find-record-descriptor ':CDSequenceDataSourceQueueEntry))

(def-mactype :CDSequenceDataSourceQueueEntryPtr (find-mactype '(:pointer :CDSequenceDataSourceQueueEntry)))
(defrecord CDSequenceDataSource
   (recordSize :signed-long)
   (next :pointer)
   (seqID :signed-long)
   (sourceID :signed-long)
   (sourceType :OSType)
   (sourceInputNumber :signed-long)
   (dataPtr :pointer)
   (dataDescription :Handle)
   (changeSeed :signed-long)
   (transferProc (:pointer :OpaqueICMConvertDataFormatProcPtr))
   (transferRefcon :pointer)
   (dataSize :signed-long)
                                                ;  fields available in QT 3 and later 
   (dataQueue (:pointer :QHdr))                 ;  queue of CDSequenceDataSourceQueueEntry structures
   (originalDataPtr :pointer)
   (originalDataSize :signed-long)
   (originalDataDescription :Handle)
   (originalDataDescriptionSeed :signed-long)
)

;type name? (%define-record :CDSequenceDataSource (find-record-descriptor ':CDSequenceDataSource))

(def-mactype :CDSequenceDataSourcePtr (find-mactype '(:pointer :CDSequenceDataSource)))
(defrecord ICMFrameTimeInfo
   (startTime :wide)
   (scale :signed-long)
   (duration :signed-long)
)

;type name? (%define-record :ICMFrameTimeInfo (find-record-descriptor ':ICMFrameTimeInfo))

(def-mactype :ICMFrameTimeInfoPtr (find-mactype '(:pointer :ICMFrameTimeInfo)))
(defrecord CodecCompressParams
   (sequenceID :signed-long)                    ;  precompress,bandcompress 
   (imageDescription (:Handle :ImageDescription));  precompress,bandcompress 
   (data :pointer)
   (bufferSize :signed-long)
   (frameNumber :signed-long)
   (startLine :signed-long)
   (stopLine :signed-long)
   (conditionFlags :signed-long)
   (callerFlags :UInt16)
   (capabilities (:pointer :CodecCapabilities)) ;  precompress,bandcompress 
   (progressProcRecord :ICMProgressProcRecord)
   (completionProcRecord :ICMCompletionProcRecord)
   (flushProcRecord :ICMFlushProcRecord)
   (srcPixMap :PixMap)                          ;  precompress,bandcompress 
   (prevPixMap :PixMap)
   (spatialQuality :UInt32)
   (temporalQuality :UInt32)
   (similarity :signed-long)
   (dataRateParams (:pointer :DataRateParams))
   (reserved :signed-long)
                                                ;  The following fields only exist for QuickTime 2.1 and greater 
   (majorSourceChangeSeed :UInt16)
   (minorSourceChangeSeed :UInt16)
   (sourceData (:pointer :CDSequenceDataSource))
                                                ;  The following fields only exist for QuickTime 2.5 and greater 
   (preferredPacketSizeInBytes :signed-long)
                                                ;  The following fields only exist for QuickTime 3.0 and greater 
   (requestedBufferWidth :signed-long)          ;  must set codecWantsSpecialScaling to indicate this field is valid
   (requestedBufferHeight :signed-long)         ;  must set codecWantsSpecialScaling to indicate this field is valid
                                                ;  The following fields only exist for QuickTime 4.0 and greater 
   (wantedSourcePixelType :OSType)
                                                ;  The following fields only exist for QuickTime 5.0 and greater 
   (compressedDataSize :signed-long)            ;  if nonzero, this overrides (*imageDescription)->dataSize
   (taskWeight :UInt32)                         ;  preferred weight for MP tasks implementing this operation
   (taskName :OSType)                           ;  preferred name (type) for MP tasks implementing this operation
)

;type name? (%define-record :CodecCompressParams (find-record-descriptor ':CodecCompressParams))
(defrecord CodecDecompressParams
   (sequenceID :signed-long)                    ;  predecompress,banddecompress 
   (imageDescription (:Handle :ImageDescription));  predecompress,banddecompress 
   (data :pointer)
   (bufferSize :signed-long)
   (frameNumber :signed-long)
   (startLine :signed-long)
   (stopLine :signed-long)
   (conditionFlags :signed-long)
   (callerFlags :UInt16)
   (capabilities (:pointer :CodecCapabilities)) ;  predecompress,banddecompress 
   (progressProcRecord :ICMProgressProcRecord)
   (completionProcRecord :ICMCompletionProcRecord)
   (dataProcRecord :ICMDataProcRecord)
   (port (:pointer :OpaqueGrafPtr))             ;  predecompress,banddecompress 
   (dstPixMap :PixMap)                          ;  predecompress,banddecompress 
   (maskBits (:pointer :BitMap))
   (mattePixMap (:pointer :PixMap))
   (srcRect :Rect)                              ;  predecompress,banddecompress 
   (matrix (:pointer :MatrixRecord))            ;  predecompress,banddecompress 
   (accuracy :UInt32)                           ;  predecompress,banddecompress 
   (transferMode :SInt16)                       ;  predecompress,banddecompress 
   (frameTime (:pointer :ICMFrameTimeRecord))   ;  banddecompress 
   (reserved (:array :signed-long 1))
                                                ;  The following fields only exist for QuickTime 2.0 and greater 
   (matrixFlags :SInt8)                         ;  high bit set if 2x resize 
   (matrixType :SInt8)
   (dstRect :Rect)                              ;  only valid for simple transforms 
                                                ;  The following fields only exist for QuickTime 2.1 and greater 
   (majorSourceChangeSeed :UInt16)
   (minorSourceChangeSeed :UInt16)
   (sourceData (:pointer :CDSequenceDataSource))
   (maskRegion (:pointer :OpaqueRgnHandle))
                                                ;  The following fields only exist for QuickTime 2.5 and greater 
   (** (:pointer :callback))                    ;(OSType wantedDestinationPixelTypes)
                                                ;  Handle to 0-terminated list of OSTypes 
   (screenFloodMethod :signed-long)
   (screenFloodValue :signed-long)
   (preferredOffscreenPixelSize :SInt16)
                                                ;  The following fields only exist for QuickTime 3.0 and greater 
   (syncFrameTime (:pointer :ICMFrameTimeInfo)) ;  banddecompress 
   (needUpdateOnTimeChange :Boolean)            ;  banddecompress 
   (enableBlackLining :Boolean)
   (needUpdateOnSourceChange :Boolean)          ;  band decompress 
   (pad :Boolean)
   (unused :signed-long)
   (finalDestinationPort (:pointer :OpaqueGrafPtr))
   (requestedBufferWidth :signed-long)          ;  must set codecWantsSpecialScaling to indicate this field is valid
   (requestedBufferHeight :signed-long)         ;  must set codecWantsSpecialScaling to indicate this field is valid
                                                ;  The following fields only exist for QuickTime 4.0 and greater 
   (displayableAreaOfRequestedBuffer :Rect)     ;  set in predecompress
   (requestedSingleField :Boolean)
   (needUpdateOnNextIdle :Boolean)
   (pad2 (:array :Boolean 2))
   (bufferGammaLevel :signed-long)
                                                ;  The following fields only exist for QuickTime 5.0 and greater 
   (taskWeight :UInt32)                         ;  preferred weight for MP tasks implementing this operation
   (taskName :OSType)                           ;  preferred name (type) for MP tasks implementing this operation
                                                ;  The following fields only exist for QuickTime 6.0 and greater 
   (bidirectionalPredictionMode :Boolean)
   (destinationBufferMemoryPreference :UInt8)   ;  a codec's PreDecompress/Preflight call can set this to express a preference about what kind of memory its destination buffer should go into.  no guarantees.
   (codecBufferMemoryPreference :UInt8)         ;  may indicate preferred kind of memory that NewImageGWorld/NewImageBufferMemory should create its buffer in, if applicable.
   (onlyUseCodecIfItIsInUserPreferredCodecList :Boolean);  set to prevent this codec from being used unless it is in the userPreferredCodec list
   (mediaContextID :QTUUID)
)

;type name? (%define-record :CodecDecompressParams (find-record-descriptor ':CodecDecompressParams))

(defconstant $matrixFlagScale2x #x80)
(defconstant $matrixFlagScale1x 64)
(defconstant $matrixFlagScaleHalf 32)

(defconstant $kScreenFloodMethodNone 0)
(defconstant $kScreenFloodMethodKeyColor 1)
(defconstant $kScreenFloodMethodAlpha 2)

(defconstant $kFlushLastQueuedFrame 0)
(defconstant $kFlushFirstQueuedFrame 1)

(defconstant $kNewImageGWorldErase 1)
;  values for destinationBufferMemoryPreference and codecBufferMemoryPreference 

(defconstant $kICMImageBufferNoPreference 0)
(defconstant $kICMImageBufferPreferMainMemory 1)
(defconstant $kICMImageBufferPreferVideoMemory 2)

(def-mactype :ImageCodecTimeTriggerProcPtr (find-mactype ':pointer)); (void * refcon)

(def-mactype :ImageCodecDrawBandCompleteProcPtr (find-mactype ':pointer)); (void * refcon , ComponentResult drawBandResult , UInt32 drawBandCompleteFlags)

(def-mactype :ImageCodecTimeTriggerUPP (find-mactype '(:pointer :OpaqueImageCodecTimeTriggerProcPtr)))

(def-mactype :ImageCodecDrawBandCompleteUPP (find-mactype '(:pointer :OpaqueImageCodecDrawBandCompleteProcPtr)))
; 
;  *  NewImageCodecTimeTriggerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewImageCodecTimeTriggerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueImageCodecTimeTriggerProcPtr)
() )
; 
;  *  NewImageCodecDrawBandCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewImageCodecDrawBandCompleteUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueImageCodecDrawBandCompleteProcPtr)
() )
; 
;  *  DisposeImageCodecTimeTriggerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeImageCodecTimeTriggerUPP" 
   ((userUPP (:pointer :OpaqueImageCodecTimeTriggerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeImageCodecDrawBandCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeImageCodecDrawBandCompleteUPP" 
   ((userUPP (:pointer :OpaqueImageCodecDrawBandCompleteProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeImageCodecTimeTriggerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeImageCodecTimeTriggerUPP" 
   ((refcon :pointer)
    (userUPP (:pointer :OpaqueImageCodecTimeTriggerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeImageCodecDrawBandCompleteUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeImageCodecDrawBandCompleteUPP" 
   ((refcon :pointer)
    (drawBandResult :signed-long)
    (drawBandCompleteFlags :UInt32)
    (userUPP (:pointer :OpaqueImageCodecDrawBandCompleteProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
(defrecord ImageSubCodecDecompressCapabilities
   (recordSize :signed-long)                    ;  sizeof(ImageSubCodecDecompressCapabilities)
   (decompressRecordSize :signed-long)          ;  size of your codec's decompress record
   (canAsync :Boolean)                          ;  default true
   (pad0 :UInt8)
                                                ;  The following field only exists for QuickTime 4.1 and greater 
   (suggestedQueueSize :UInt16)
                                                ;  The following field only exists for QuickTime 4.0 and greater 
   (canProvideTrigger :Boolean)
                                                ;  The following fields only exist for QuickTime 5.0 and greater 
   (subCodecFlushesScreen :Boolean)             ;  only used on Mac OS X
   (subCodecCallsDrawBandComplete :Boolean)
   (pad2 (:array :UInt8 1))
                                                ;  The following fields only exist for QuickTime 5.0.1 and greater 
   (isChildCodec :Boolean)                      ;  set by base codec before calling Initialize
   (reserved1 :UInt8)
   (pad4 (:array :UInt8 2))
)

;type name? (%define-record :ImageSubCodecDecompressCapabilities (find-record-descriptor ':ImageSubCodecDecompressCapabilities))

(defconstant $kCodecFrameTypeUnknown 0)
(defconstant $kCodecFrameTypeKey 1)
(defconstant $kCodecFrameTypeDifference 2)
(defconstant $kCodecFrameTypeDroppableDifference 3)
(defrecord ImageSubCodecDecompressRecord
   (baseAddr :pointer)
   (rowBytes :signed-long)
   (codecData :pointer)
   (progressProcRecord :ICMProgressProcRecord)
   (dataProcRecord :ICMDataProcRecord)
   (userDecompressRecord :pointer)              ;  pointer to codec-specific per-band data
   (frameType :UInt8)
   (inhibitMP :Boolean)                         ;  set this in BeginBand to tell the base decompressor not to call DrawBand from an MP task for this frame.  (Only has any effect for MP-capable subcodecs.  New in QuickTime 5.0.)
   (pad (:array :UInt8 2))
   (priv (:array :signed-long 2))
                                                ;  The following fields only exist for QuickTime 5.0 and greater 
   (drawBandCompleteUPP (:pointer :OpaqueImageCodecDrawBandCompleteProcPtr));  only used if subcodec set subCodecCallsDrawBandComplete; if drawBandCompleteUPP is non-nil, codec must call it when a frame is finished, but may return from DrawBand before the frame is finished. 
   (drawBandCompleteRefCon :pointer)            ;  Note: do not call drawBandCompleteUPP directly from a hardware interrupt; instead, use DTInstall to run a function at deferred task time, and call drawBandCompleteUPP from that. 
)

;type name? (%define-record :ImageSubCodecDecompressRecord (find-record-descriptor ':ImageSubCodecDecompressRecord))
; 
;   These data structures are used by code that wants to pass planar pixmap 
;    information around.
;   The structure below gives the basic idea of what is being done.
;   Normal instances of code will use a fixed number of planes (eg YUV420 uses 
;    three planes, Y, U and V). Each such code instance will define its own
;    version of the PlanarPixMapInfo struct counting the number of planes it 
;    needs along with defining constants that specify the meanings of each
;    plane.
; 
(defrecord PlanarComponentInfo
   (offset :SInt32)
   (rowBytes :UInt32)
)

;type name? (%define-record :PlanarComponentInfo (find-record-descriptor ':PlanarComponentInfo))
(defrecord PlanarPixMapInfo
   (componentInfo (:array :PlanarComponentInfo 1))
)

;type name? (%define-record :PlanarPixMapInfo (find-record-descriptor ':PlanarPixMapInfo))
(defrecord PlanarPixmapInfoSorensonYUV9
   (componentInfoY :PlanarComponentInfo)
   (componentInfoU :PlanarComponentInfo)
   (componentInfoV :PlanarComponentInfo)
)

;type name? (%define-record :PlanarPixmapInfoSorensonYUV9 (find-record-descriptor ':PlanarPixmapInfoSorensonYUV9))
(defrecord PlanarPixmapInfoYUV420
   (componentInfoY :PlanarComponentInfo)
   (componentInfoCb :PlanarComponentInfo)
   (componentInfoCr :PlanarComponentInfo)
)

;type name? (%define-record :PlanarPixmapInfoYUV420 (find-record-descriptor ':PlanarPixmapInfoYUV420))

(defconstant $codecSuggestedBufferSentinel :|sent|);  codec public resource containing suggested data pattern to put past end of data buffer 

;  name of parameters or effect -- placed in root container, required 

(defconstant $kParameterTitleName :|name|)
(defconstant $kParameterTitleID 1)
;  codec sub-type of parameters or effect -- placed in root container, required 

(defconstant $kParameterWhatName :|what|)
(defconstant $kParameterWhatID 1)
;  effect version -- placed in root container, optional, but recommended 

(defconstant $kParameterVersionName :|vers|)
(defconstant $kParameterVersionID 1)
;  is effect repeatable -- placed in root container, optional, default is TRUE

(defconstant $kParameterRepeatableName :|pete|)
(defconstant $kParameterRepeatableID 1)

(defconstant $kParameterRepeatableTrue 1)
(defconstant $kParameterRepeatableFalse 0)
;  substitution codec in case effect is missing -- placed in root container, recommended 

(defconstant $kParameterAlternateCodecName :|subs|)
(defconstant $kParameterAlternateCodecID 1)
;  maximum number of sources -- placed in root container, required 

(defconstant $kParameterSourceCountName :|srcs|)
(defconstant $kParameterSourceCountID 1)
;  EFFECT CLASSES
; 
;    The effect major class defines the major grouping of the effect.
;    Major classes are defined only by Apple and are not extendable by third
;    parties.  Major classes are used for filtering of the effect list by
;    applications, but do not define what UI sub-group may or may not be
;    presented to the user.  For example, the major class may be a transition,
;    but the minor class may be a wipe.  
; 
; 
;    Effects that fail to include a
;    kEffectMajorClassType will be classified as kMiscMajorClass.
; 

(defconstant $kEffectMajorClassType :|clsa|)
(defconstant $kEffectMajorClassID 1)

(defconstant $kGeneratorMajorClass :|genr|)     ;  zero source effects

(defconstant $kFilterMajorClass :|filt|)        ;  one source effects

(defconstant $kTransitionMajorClass :|tran|)    ;  multisource morph effects 

(defconstant $kCompositorMajorClass :|comp|)    ;  multisource layer effects

(defconstant $kMiscMajorClass :|misc|)          ;  all other effects

; 
;    The effect minor class defines the grouping of effects for the purposes
;    of UI.  Apple defines a set of minor classes and will extend it over
;    time.  Apple also provides strings within the UI for minor classes
;    that it defines.  Third party developers may either classify
;    their effects as a type defined by Apple, or may define their own
;    minor class.  Effects which define a minor class of their own
;    must also then supply a kEffectMinorClassNameType atom.
; 
; 
;    If a kEffectMinorClassNameType atom is present, but
;    the minor type is one defined by Apple, the Apple supplied
;    string will be used in the UI.
; 
; 
;    Effects that fail to supply a kEffectMinorClassType will be 
;    classified as kMiscMinorClass.
; 

(defconstant $kEffectMinorClassType :|clsi|)
(defconstant $kEffectMinorClassID 1)
(defconstant $kEffectMinorClassNameType :|clsn|)
(defconstant $kEffectMinorClassNameID 1)

(defconstant $kGeneratorMinorClass :|genr|)     ;  "Generators"

(defconstant $kRenderMinorClass :|rend|)        ;  "Render"

(defconstant $kFilterMinorClass :|filt|)        ;  "Filters"

(defconstant $kArtisticMinorClass :|arts|)      ;  "Artistic

(defconstant $kBlurMinorClass :|blur|)          ;  "Blur"

(defconstant $kSharpenMinorClass :|shrp|)       ;  "Sharpen"

(defconstant $kDistortMinorClass :|dist|)       ;  "Distort"

(defconstant $kNoiseMinorClass :|nois|)         ;  "Noise"

(defconstant $kAdjustmentMinorClass :|adst|)    ;  "Adjustments"

(defconstant $kTransitionMinorClass :|tran|)    ;  "Transitions"

(defconstant $kWipeMinorClass :|wipe|)          ;  "Wipes"

(defconstant $k3DMinorClass :|pzre|)            ;  "3D Transitions"

(defconstant $kCompositorMinorClass :|comp|)    ;  "Compositors"

(defconstant $kEffectsMinorClass :|fxfx|)       ;  "Special Effects"

(defconstant $kMiscMinorClass :|misc|)          ;  "Miscellaneous"

; 
;    Effects can define a number of "preset" values which will be presented to the user
;    in a simplified UI.  Each preset is an atom within the parameter description list
;    and must have an atom ID from 1 going up sequentially.  Inside of this atom are three other
;    atoms containing:
;     1) the name of the preset as a Pascal string
;     2) a preview picture for the preset, 86 x 64 pixels in size
;     3) the ENTIRE set of parameter values needed to create a sample of this preset.
; 

(defconstant $kEffectPresetType :|peff|)
(defconstant $kPresetNameType :|pnam|)
(defconstant $kPresetNameID 1)
(defconstant $kPresetPreviewPictureType :|ppct|)
(defconstant $kPresetPreviewPictureID 1)
(defconstant $kPresetSettingsType :|psst|)
(defconstant $kPresetSettingsID 1)

(defconstant $kParameterDependencyName :|deep|)
(defconstant $kParameterDependencyID 1)

(defconstant $kParameterListDependsUponColorProfiles :|prof|)
(defconstant $kParameterListDependsUponFonts :|font|)
(defrecord ParameterDependancyRecord
   (dependCount :signed-long)
   (depends (:array :OSType 1))
)

;type name? (%define-record :ParameterDependancyRecord (find-record-descriptor ':ParameterDependancyRecord))
; 
;    enumeration list in container -- placed in root container, optional unless used by a
;    parameter in the list
; 

(defconstant $kParameterEnumList :|enum|)
(defrecord EnumValuePair
   (value :signed-long)
   (name (:string 255))
)

;type name? (%define-record :EnumValuePair (find-record-descriptor ':EnumValuePair))
(defrecord EnumListRecord
   (enumCount :signed-long)                     ;  number of enumeration items to follow
   (values (:array :EnumValuePair 1))           ;  values and names for them, packed 
)

;type name? (%define-record :EnumListRecord (find-record-descriptor ':EnumListRecord))
;  atom type of parameter

(defconstant $kParameterAtomTypeAndID :|type|)

(defconstant $kNoAtom :|none|)                  ;  atom type for no data got/set

(defconstant $kAtomNoFlags 0)
(defconstant $kAtomNotInterpolated 1)           ;  atom can never be interpolated

(defconstant $kAtomInterpolateIsOptional 2)     ;  atom can be interpolated, but it is an advanced user operation

(defconstant $kAtomMayBeIndexed 4)              ;  more than one value of atom can exist with accending IDs (ie, lists of colors)

(defrecord ParameterAtomTypeAndID
   (atomType :signed-long)                      ;  type of atom this data comes from/goes into
   (atomID :signed-long)                        ;  ID of atom this data comes from/goes into
   (atomFlags :signed-long)                     ;  options for this atom
   (atomName (:string 255))                     ;  name of this value type
)

;type name? (%define-record :ParameterAtomTypeAndID (find-record-descriptor ':ParameterAtomTypeAndID))
;  optional specification of mapping between parameters and properties

(defconstant $kParameterProperty :|prop|)
(defrecord ParameterProperty
   (propertyClass :OSType)                      ;  class to set for this property (0 for default which is specified by caller)
   (propertyID :OSType)                         ;  id to set for this property (default is the atomType)
)

;type name? (%define-record :ParameterProperty (find-record-descriptor ':ParameterProperty))
;  data type of a parameter

(defconstant $kParameterDataType :|data|)

(defconstant $kParameterTypeDataLong 2)         ;  integer value

(defconstant $kParameterTypeDataFixed 3)        ;  fixed point value

(defconstant $kParameterTypeDataRGBValue 8)     ;  RGBColor data

(defconstant $kParameterTypeDataDouble 11)      ;  IEEE 64 bit floating point value

(defconstant $kParameterTypeDataText :|text|)   ;  editable text item

(defconstant $kParameterTypeDataEnum :|enum|)   ;  enumerated lookup value

(defconstant $kParameterTypeDataBitField :|bool|);  bit field value (something that holds boolean(s))

(defconstant $kParameterTypeDataImage :|imag|)  ;  reference to an image via Picture data

(defrecord ParameterDataType
   (dataType :OSType)                           ;  type of data this item is stored as
)

;type name? (%define-record :ParameterDataType (find-record-descriptor ':ParameterDataType))
; 
;    alternate (optional) data type -- main data type always required.  
;    Must be modified or deleted when modifying main data type.
;    Main data type must be modified when alternate is modified.
; 

(defconstant $kParameterAlternateDataType :|alt1|)
(defconstant $kParameterTypeDataColorValue :|cmlr|);  CMColor data (supported on machines with ColorSync)

(defconstant $kParameterTypeDataCubic :|cubi|)  ;  cubic bezier(s) (no built-in support)

(defconstant $kParameterTypeDataNURB :|nurb|)   ;  nurb(s) (no built-in support)

(defrecord ParameterAlternateDataEntry
   (dataType :OSType)                           ;  type of data this item is stored as
   (alternateAtom :signed-long)                 ;  where to store
)

;type name? (%define-record :ParameterAlternateDataEntry (find-record-descriptor ':ParameterAlternateDataEntry))
(defrecord ParameterAlternateDataType
   (numEntries :signed-long)
   (entries (:array :ParameterAlternateDataEntry 1))
)

;type name? (%define-record :ParameterAlternateDataType (find-record-descriptor ':ParameterAlternateDataType))
;  legal values for the parameter

(defconstant $kParameterDataRange :|rang|)

(defconstant $kNoMinimumLongFixed #x7FFFFFFF)   ;  ignore minimum/maxiumum values

(defconstant $kNoMaximumLongFixed #x80000000)
(defconstant $kNoScaleLongFixed 0)              ;  don't perform any scaling of value
;  allow as many digits as format

(defconstant $kNoPrecision -1)
;  'text'
(defrecord StringRangeRecord
   (maxChars :signed-long)                      ;  maximum length of string
   (maxLines :signed-long)                      ;  number of editing lines to use (1 typical, 0 to default)
)

;type name? (%define-record :StringRangeRecord (find-record-descriptor ':StringRangeRecord))
;  'long'
(defrecord LongRangeRecord
   (minValue :signed-long)                      ;  no less than this
   (maxValue :signed-long)                      ;  no more than this
   (scaleValue :signed-long)                    ;  muliply content by this going in, divide going out
   (precisionDigits :signed-long)               ;  # digits of precision when editing via typing
)

;type name? (%define-record :LongRangeRecord (find-record-descriptor ':LongRangeRecord))
;  'enum'
(defrecord EnumRangeRecord
   (enumID :signed-long)                        ;  'enum' list in root container to search within
)

;type name? (%define-record :EnumRangeRecord (find-record-descriptor ':EnumRangeRecord))
;  'fixd'
(defrecord FixedRangeRecord
   (minValue :signed-long)                      ;  no less than this
   (maxValue :signed-long)                      ;  no more than this
   (scaleValue :signed-long)                    ;  muliply content by this going in, divide going out
   (precisionDigits :signed-long)               ;  # digits of precision when editing via typing
)

;type name? (%define-record :FixedRangeRecord (find-record-descriptor ':FixedRangeRecord))
;  'doub'
; #define kNoMinimumDouble        (NAN)                   /* ignore minimum/maxiumum values */
; #define kNoMaximumDouble        (NAN)
(defconstant $kNoScaleDouble 0)
; #define kNoScaleDouble          (0)                     /* don't perform any scaling of value */
(defrecord DoubleRangeRecord
   (minValue :double-float)                     ;  no less than this 
   (maxValue :double-float)                     ;  no more than this 
   (scaleValue :double-float)                   ;  muliply content by this going in, divide going out 
   (precisionDigits :signed-long)               ;  # digits of precision when editing via typing 
)

;type name? (%define-record :DoubleRangeRecord (find-record-descriptor ':DoubleRangeRecord))
;  'bool'   
(defrecord BooleanRangeRecord
   (maskValue :signed-long)                     ;  value to mask on/off to set/clear the boolean
)

;type name? (%define-record :BooleanRangeRecord (find-record-descriptor ':BooleanRangeRecord))
;  'rgb '
(defrecord RGBRangeRecord
   (minColor :RGBColor)
   (maxColor :RGBColor)
)

;type name? (%define-record :RGBRangeRecord (find-record-descriptor ':RGBRangeRecord))
;  'imag'

(defconstant $kParameterImageNoFlags 0)
(defconstant $kParameterImageIsPreset 1)

(defconstant $kStandardPresetGroup :|pset|)
(defrecord ImageRangeRecord
   (imageFlags :signed-long)
   (fileType :OSType)                           ;  file type to contain the preset group (normally kStandardPresetGroup)
   (replacedAtoms :signed-long)                 ;  # atoms at this level replaced by this preset group
)

;type name? (%define-record :ImageRangeRecord (find-record-descriptor ':ImageRangeRecord))
;  union of all of the above
(defrecord ParameterRangeRecord
   (:variant
   (
   (longRange :LongRangeRecord)
   )
   (
   (enumRange :EnumRangeRecord)
   )
   (
   (fixedRange :FixedRangeRecord)
   )
   (
   (doubleRange :DoubleRangeRecord)
   )
   (
   (stringRange :StringRangeRecord)
   )
   (
   (booleanRange :BooleanRangeRecord)
   )
   (
   (rgbRange :RGBRangeRecord)
   )
   (
   (imageRange :ImageRangeRecord)
   )
   )
)

;type name? (%define-record :ParameterRangeRecord (find-record-descriptor ':ParameterRangeRecord))
;  UI behavior of a parameter

(defconstant $kParameterDataBehavior :|ditl|)
;  items edited via typing

(defconstant $kParameterItemEditText :|edit|)   ;  edit text box

(defconstant $kParameterItemEditLong :|long|)   ;  long number editing box

(defconstant $kParameterItemEditFixed :|fixd|)  ;  fixed point number editing box

(defconstant $kParameterItemEditDouble :|doub|) ;  double number editing box
;  items edited via control(s)

(defconstant $kParameterItemPopUp :|popu|)      ;  pop up value for enum types

(defconstant $kParameterItemRadioCluster :|radi|);  radio cluster for enum types

(defconstant $kParameterItemCheckBox :|chex|)   ;  check box for booleans

(defconstant $kParameterItemControl :|cntl|)    ;  item controlled via a standard control of some type
;  special user items

(defconstant $kParameterItemLine :|line|)       ;  line

(defconstant $kParameterItemColorPicker :|pick|);  color swatch & picker

(defconstant $kParameterItemGroupDivider :|divi|);  start of a new group of items

(defconstant $kParameterItemStaticText :|stat|) ;  display "parameter name" as static text

(defconstant $kParameterItemDragImage :|imag|)  ;  allow image display, along with drag and drop
;  flags valid for lines and groups

(defconstant $kGraphicsNoFlags 0)               ;  no options for graphics

(defconstant $kGraphicsFlagsGray 1)             ;  draw lines with gray
;  flags valid for groups

(defconstant $kGroupNoFlags 0)                  ;  no options for group -- may be combined with graphics options             

(defconstant $kGroupAlignText #x10000)          ;  edit text items in group have the same size

(defconstant $kGroupSurroundBox #x20000)        ;  group should be surrounded with a box

(defconstant $kGroupMatrix #x40000)             ;  side-by-side arrangement of group is okay

(defconstant $kGroupNoName #x80000)             ;  name of group should not be displayed above box
;  flags valid for popup/radiocluster/checkbox/control

(defconstant $kDisableControl 1)
(defconstant $kDisableWhenNotEqual 1)
(defconstant $kDisableWhenEqual 17)
(defconstant $kDisableWhenLessThan 33)
(defconstant $kDisableWhenGreaterThan 49)       ;  flags valid for controls

(defconstant $kCustomControl #x100000)          ;  flags valid for popups

(defconstant $kPopupStoreAsString #x10000)
(defrecord ControlBehaviors
   (groupID :signed-long)                       ;  group under control of this item
   (controlValue :signed-long)                  ;  control value for comparison purposes
   (customType :signed-long)                    ;  custom type identifier, for kCustomControl
   (customID :signed-long)                      ;  custom type ID, for kCustomControl
)

;type name? (%define-record :ControlBehaviors (find-record-descriptor ':ControlBehaviors))
(defrecord ParameterDataBehavior
   (behaviorType :OSType)
   (behaviorFlags :signed-long)
   (:variant
   (
   (controls :ControlBehaviors)
   )
   )
)

;type name? (%define-record :ParameterDataBehavior (find-record-descriptor ':ParameterDataBehavior))
;  higher level purpose of a parameter or set of parameters

(defconstant $kParameterDataUsage :|use |)

(defconstant $kParameterUsagePixels :|pixl|)
(defconstant $kParameterUsageRectangle :|rect|)
(defconstant $kParameterUsagePoint :|xy  |)
(defconstant $kParameterUsage3DPoint :|xyz |)
(defconstant $kParameterUsageDegrees :|degr|)
(defconstant $kParameterUsageRadians :|rads|)
(defconstant $kParameterUsagePercent :|pcnt|)
(defconstant $kParameterUsageSeconds :|secs|)
(defconstant $kParameterUsageMilliseconds :|msec|); 'µsec' 

(defconstant $kParameterUsageMicroseconds #xB5736563)
(defconstant $kParameterUsage3by3Matrix :|3by3|)
(defconstant $kParameterUsageCircularDegrees :|degc|)
(defconstant $kParameterUsageCircularRadians :|radc|)
(defrecord ParameterDataUsage
   (usageType :OSType)                          ;  higher level purpose of the data or group
)

;type name? (%define-record :ParameterDataUsage (find-record-descriptor ':ParameterDataUsage))
;  default value(s) for a parameter

(defconstant $kParameterDataDefaultItem :|dflt|)
;  atoms that help to fill in data within the info window 
; '©nam' 

(defconstant $kParameterInfoLongName #xA96E616D); '©cpy' 

(defconstant $kParameterInfoCopyright #xA9637079); '©inf' 

(defconstant $kParameterInfoDescription #xA9696E66); '©wnt' 

(defconstant $kParameterInfoWindowTitle #xA9776E74); '©pix' 

(defconstant $kParameterInfoPicture #xA9706978) ; '©man' 

(defconstant $kParameterInfoManufacturer #xA96D616E)
(defconstant $kParameterInfoIDs 1)
;  flags for ImageCodecValidateParameters 

(defconstant $kParameterValidationNoFlags 0)
(defconstant $kParameterValidationFinalValidation 1)

(def-mactype :QTParameterValidationOptions (find-mactype ':signed-long))
;  QTAtomTypes for atoms in image compressor settings containers

(defconstant $kImageCodecSettingsFieldCount :|fiel|);  Number of fields (UInt8) 

(defconstant $kImageCodecSettingsFieldOrdering :|fdom|);  Ordering of fields (UInt8)

(defconstant $kImageCodecSettingsFieldOrderingF1F2 1)
(defconstant $kImageCodecSettingsFieldOrderingF2F1 2)
;  Additional Image Description Extensions

(defconstant $kColorInfoImageDescriptionExtension :|colr|);  image description extension describing the color properties    

(defconstant $kPixelAspectRatioImageDescriptionExtension :|pasp|);  image description extension describing the pixel aspect ratio

(defconstant $kCleanApertureImageDescriptionExtension :|clap|);  image description extension describing the pixel aspect ratio

;  Color Info Image Description Extension types

(defconstant $kVideoColorInfoImageDescriptionExtensionType :|nclc|);  For video color descriptions (defined below)    

(defconstant $kICCProfileColorInfoImageDescriptionExtensionType :|prof|);  For ICC Profile color descriptions (not defined here)

;  Video Color Info Image Description Extensions
(defrecord NCLCColorInfoImageDescriptionExtension
   (colorParamType :OSType)                     ;  Type of color parameter 'nclc'               
   (primaries :UInt16)                          ;  CIE 1931 xy chromaticity coordinates          
   (transferFunction :UInt16)                   ;  Nonlinear transfer function from RGB to ErEgEb 
   (matrix :UInt16)                             ;  Matrix from ErEgEb to EyEcbEcr           
)

;type name? (%define-record :NCLCColorInfoImageDescriptionExtension (find-record-descriptor ':NCLCColorInfoImageDescriptionExtension))
;  Primaries

(defconstant $kQTPrimaries_ITU_R709_2 1)        ;  ITU-R BT.709-2, SMPTE 274M-1995, and SMPTE 296M-1997 

(defconstant $kQTPrimaries_Unknown 2)           ;  Unknown 

(defconstant $kQTPrimaries_EBU_3213 5)          ;  EBU Tech. 3213 (1981) 

(defconstant $kQTPrimaries_SMPTE_C 6)           ;  SMPTE C Primaries from SMPTE RP 145-1993 

;  Transfer Function

(defconstant $kQTTransferFunction_ITU_R709_2 1) ;  Recommendation ITU-R BT.709-2, SMPTE 274M-1995, SMPTE 296M-1997, SMPTE 293M-1996 and SMPTE 170M-1994 

(defconstant $kQTTransferFunction_Unknown 2)    ;  Unknown 

(defconstant $kQTTransferFunction_SMPTE_240M_1995 7);  SMPTE 240M-1995 and interim color implementation of SMPTE 274M-1995 

;  Matrix

(defconstant $kQTMatrix_ITU_R_709_2 1)          ;  Recommendation ITU-R BT.709-2 (1125/60/2:1 only), SMPTE 274M-1995 and SMPTE 296M-1997 

(defconstant $kQTMatrix_Unknown 2)              ;  Unknown 

(defconstant $kQTMatrix_ITU_R_601_4 6)          ;  Recommendation ITU-R BT.601-4, Recommendation ITU-R BT.470-4 System B and G, SMPTE 170M-1994 and SMPTE 293M-1996 

(defconstant $kQTMatrix_SMPTE_240M_1995 7)      ;  SMPTE 240M-1995 and interim color implementation of SMPTE 274M-1995 

;  Field/Frame Info Image Description (this remaps to FieldInfoImageDescriptionExtension)
(defrecord FieldInfoImageDescriptionExtension2
   (fields :UInt8)
   (detail :UInt8)
)

;type name? (%define-record :FieldInfoImageDescriptionExtension2 (find-record-descriptor ':FieldInfoImageDescriptionExtension2))

(defconstant $kQTFieldsProgressiveScan 1)
(defconstant $kQTFieldsInterlaced 2)

(defconstant $kQTFieldDetailUnknown 0)
(defconstant $kQTFieldDetailTemporalTopFirst 1)
(defconstant $kQTFieldDetailTemporalBottomFirst 6)
(defconstant $kQTFieldDetailSpatialFirstLineEarly 9)
(defconstant $kQTFieldDetailSpatialFirstLineLate 14)
;  Pixel Aspect Ratio Image Description Extensions
(defrecord PixelAspectRatioImageDescriptionExtension
   (hSpacing :UInt32)                           ;  Horizontal Spacing 
   (vSpacing :UInt32)                           ;  Vertical Spacing 
)

;type name? (%define-record :PixelAspectRatioImageDescriptionExtension (find-record-descriptor ':PixelAspectRatioImageDescriptionExtension))
;  Clean Aperture Image Description Extensions
(defrecord CleanApertureImageDescriptionExtension
   (cleanApertureWidthN :UInt32)                ;  width of clean aperture, numerator, denominator 
   (cleanApertureWidthD :UInt32)
   (cleanApertureHeightN :UInt32)               ;  height of clean aperture, numerator, denominator
   (cleanApertureHeightD :UInt32)
   (horizOffN :UInt32)                          ;  horizontal offset of clean aperture center minus (width-1)/2, numerator, denominator 
   (horizOffD :UInt32)
   (vertOffN :UInt32)                           ;  vertical offset of clean aperture center minus (height-1)/2, numerator, denominator 
   (vertOffD :UInt32)
)

;type name? (%define-record :CleanApertureImageDescriptionExtension (find-record-descriptor ':CleanApertureImageDescriptionExtension))

(def-mactype :ImageCodecMPDrawBandProcPtr (find-mactype ':pointer)); (void * refcon , ImageSubCodecDecompressRecord * drp)

(def-mactype :ImageCodecMPDrawBandUPP (find-mactype '(:pointer :OpaqueImageCodecMPDrawBandProcPtr)))
; 
;  *  NewImageCodecMPDrawBandUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewImageCodecMPDrawBandUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueImageCodecMPDrawBandProcPtr)
() )
; 
;  *  DisposeImageCodecMPDrawBandUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeImageCodecMPDrawBandUPP" 
   ((userUPP (:pointer :OpaqueImageCodecMPDrawBandProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeImageCodecMPDrawBandUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeImageCodecMPDrawBandUPP" 
   ((refcon :pointer)
    (drp (:pointer :ImageSubCodecDecompressRecord))
    (userUPP (:pointer :OpaqueImageCodecMPDrawBandProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;   codec selectors 0-127 are reserved by Apple 
;   codec selectors 128-191 are subtype specific 
;   codec selectors 192-255 are vendor specific 
;   codec selectors 256-32767 are available for general use 
;   negative selectors are reserved by the Component Manager 
; 
;  *  ImageCodecGetCodecInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecGetCodecInfo" 
   ((ci (:pointer :ComponentInstanceRecord))
    (info (:pointer :CodecInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecGetCompressionTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecGetCompressionTime" 
   ((ci (:pointer :ComponentInstanceRecord))
    (src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (depth :SInt16)
    (spatialQuality (:pointer :CODECQ))
    (temporalQuality (:pointer :CODECQ))
    (time (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecGetMaxCompressionSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecGetMaxCompressionSize" 
   ((ci (:pointer :ComponentInstanceRecord))
    (src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (depth :SInt16)
    (quality :UInt32)
    (size (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecPreCompress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecPreCompress" 
   ((ci (:pointer :ComponentInstanceRecord))
    (params (:pointer :CodecCompressParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecBandCompress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecBandCompress" 
   ((ci (:pointer :ComponentInstanceRecord))
    (params (:pointer :CodecCompressParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecPreDecompress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecPreDecompress" 
   ((ci (:pointer :ComponentInstanceRecord))
    (params (:pointer :CodecDecompressParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecBandDecompress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecBandDecompress" 
   ((ci (:pointer :ComponentInstanceRecord))
    (params (:pointer :CodecDecompressParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecBusy()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecBusy" 
   ((ci (:pointer :ComponentInstanceRecord))
    (seq :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecGetCompressedImageSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecGetCompressedImageSize" 
   ((ci (:pointer :ComponentInstanceRecord))
    (desc (:Handle :ImageDescription))
    (data :pointer)
    (bufferSize :signed-long)
    (dataProc (:pointer :ICMDataProcRecord))
    (dataSize (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecGetSimilarity()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecGetSimilarity" 
   ((ci (:pointer :ComponentInstanceRecord))
    (src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (desc (:Handle :ImageDescription))
    (data :pointer)
    (similarity (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecTrimImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecTrimImage" 
   ((ci (:pointer :ComponentInstanceRecord))
    (Desc (:Handle :ImageDescription))
    (inData :pointer)
    (inBufferSize :signed-long)
    (dataProc (:pointer :ICMDataProcRecord))
    (outData :pointer)
    (outBufferSize :signed-long)
    (flushProc (:pointer :ICMFlushProcRecord))
    (trimRect (:pointer :Rect))
    (progressProc (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecRequestSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecRequestSettings" 
   ((ci (:pointer :ComponentInstanceRecord))
    (settings :Handle)
    (rp (:pointer :Rect))
    (filterProc (:pointer :OpaqueModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecGetSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecGetSettings" 
   ((ci (:pointer :ComponentInstanceRecord))
    (settings :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecSetSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecSetSettings" 
   ((ci (:pointer :ComponentInstanceRecord))
    (settings :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecFlush()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecFlush" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecSetTimeCode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecSetTimeCode" 
   ((ci (:pointer :ComponentInstanceRecord))
    (timeCodeFormat :pointer)
    (timeCodeTime :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecIsImageDescriptionEquivalent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecIsImageDescriptionEquivalent" 
   ((ci (:pointer :ComponentInstanceRecord))
    (newDesc (:Handle :ImageDescription))
    (equivalent (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecNewMemory()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecNewMemory" 
   ((ci (:pointer :ComponentInstanceRecord))
    (data (:pointer :Ptr))
    (dataSize :signed-long)
    (dataUse :signed-long)
    (memoryGoneProc (:pointer :OpaqueICMMemoryDisposedProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecDisposeMemory()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecDisposeMemory" 
   ((ci (:pointer :ComponentInstanceRecord))
    (data :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecHitTestData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecHitTestData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (desc (:Handle :ImageDescription))
    (data :pointer)
    (dataSize :signed-long)
    (where :Point)
    (hit (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecNewImageBufferMemory()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecNewImageBufferMemory" 
   ((ci (:pointer :ComponentInstanceRecord))
    (params (:pointer :CodecDecompressParams))
    (flags :signed-long)
    (memoryGoneProc (:pointer :OpaqueICMMemoryDisposedProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecExtractAndCombineFields()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecExtractAndCombineFields" 
   ((ci (:pointer :ComponentInstanceRecord))
    (fieldFlags :signed-long)
    (data1 :pointer)
    (dataSize1 :signed-long)
    (desc1 (:Handle :ImageDescription))
    (data2 :pointer)
    (dataSize2 :signed-long)
    (desc2 (:Handle :ImageDescription))
    (outputData :pointer)
    (outDataSize (:pointer :long))
    (descOut (:Handle :ImageDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecGetMaxCompressionSizeWithSources()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecGetMaxCompressionSizeWithSources" 
   ((ci (:pointer :ComponentInstanceRecord))
    (src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (depth :SInt16)
    (quality :UInt32)
    (sourceData (:pointer :CDSequenceDataSource))
    (size (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecSetTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecSetTimeBase" 
   ((ci (:pointer :ComponentInstanceRecord))
    (base :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecSourceChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecSourceChanged" 
   ((ci (:pointer :ComponentInstanceRecord))
    (majorSourceChangeSeed :UInt32)
    (minorSourceChangeSeed :UInt32)
    (sourceData (:pointer :CDSequenceDataSource))
    (flagsOut (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecFlushFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecFlushFrame" 
   ((ci (:pointer :ComponentInstanceRecord))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecGetSettingsAsText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecGetSettingsAsText" 
   ((ci (:pointer :ComponentInstanceRecord))
    (text (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecGetParameterListHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecGetParameterListHandle" 
   ((ci (:pointer :ComponentInstanceRecord))
    (parameterDescriptionHandle (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecGetParameterList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecGetParameterList" 
   ((ci (:pointer :ComponentInstanceRecord))
    (parameterDescription (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecCreateStandardParameterDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecCreateStandardParameterDialog" 
   ((ci (:pointer :ComponentInstanceRecord))
    (parameterDescription :Handle)
    (parameters :Handle)
    (dialogOptions :signed-long)
    (existingDialog (:pointer :OpaqueDialogPtr))
    (existingUserItem :SInt16)
    (createdDialog (:pointer :QTPARAMETERDIALOG))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecIsStandardParameterDialogEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecIsStandardParameterDialogEvent" 
   ((ci (:pointer :ComponentInstanceRecord))
    (pEvent (:pointer :EventRecord))
    (createdDialog :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecDismissStandardParameterDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecDismissStandardParameterDialog" 
   ((ci (:pointer :ComponentInstanceRecord))
    (createdDialog :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecStandardParameterDialogDoAction()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecStandardParameterDialogDoAction" 
   ((ci (:pointer :ComponentInstanceRecord))
    (createdDialog :signed-long)
    (action :signed-long)
    (params :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecNewImageGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecNewImageGWorld" 
   ((ci (:pointer :ComponentInstanceRecord))
    (params (:pointer :CodecDecompressParams))
    (newGW (:pointer :GWORLDPTR))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecDisposeImageGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecDisposeImageGWorld" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theGW (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecHitTestDataWithFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecHitTestDataWithFlags" 
   ((ci (:pointer :ComponentInstanceRecord))
    (desc (:Handle :ImageDescription))
    (data :pointer)
    (dataSize :signed-long)
    (where :Point)
    (hit (:pointer :long))
    (hitFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecValidateParameters()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecValidateParameters" 
   ((ci (:pointer :ComponentInstanceRecord))
    (parameters :Handle)
    (validationFlags :signed-long)
    (errorString (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecGetBaseMPWorkFunction()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecGetBaseMPWorkFunction" 
   ((ci (:pointer :ComponentInstanceRecord))
    (workFunction (:pointer :COMPONENTMPWORKFUNCTIONUPP))
    (refCon :pointer)
    (drawProc (:pointer :OpaqueImageCodecMPDrawBandProcPtr))
    (drawProcRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecLockBits()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_ImageCodecLockBits" 
   ((ci (:pointer :ComponentInstanceRecord))
    (port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecUnlockBits()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_ImageCodecUnlockBits" 
   ((ci (:pointer :ComponentInstanceRecord))
    (port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecRequestGammaLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_ImageCodecRequestGammaLevel" 
   ((ci (:pointer :ComponentInstanceRecord))
    (srcGammaLevel :signed-long)
    (dstGammaLevel :signed-long)
    (codecCanMatch (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecGetSourceDataGammaLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_ImageCodecGetSourceDataGammaLevel" 
   ((ci (:pointer :ComponentInstanceRecord))
    (sourceDataGammaLevel (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  (Selector 42 skipped) 
; 
;  *  ImageCodecGetDecompressLatency()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_ImageCodecGetDecompressLatency" 
   ((ci (:pointer :ComponentInstanceRecord))
    (latency (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecMergeFloatingImageOntoWindow()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_ImageCodecMergeFloatingImageOntoWindow" 
   ((ci (:pointer :ComponentInstanceRecord))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecRemoveFloatingImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_ImageCodecRemoveFloatingImage" 
   ((ci (:pointer :ComponentInstanceRecord))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecGetDITLForSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_ImageCodecGetDITLForSize" 
   ((ci (:pointer :ComponentInstanceRecord))
    (ditl (:pointer :Handle))
    (requestedSize (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecDITLInstall()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_ImageCodecDITLInstall" 
   ((ci (:pointer :ComponentInstanceRecord))
    (d (:pointer :OpaqueDialogPtr))
    (itemOffset :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecDITLEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_ImageCodecDITLEvent" 
   ((ci (:pointer :ComponentInstanceRecord))
    (d (:pointer :OpaqueDialogPtr))
    (itemOffset :SInt16)
    (theEvent (:pointer :EventRecord))
    (itemHit (:pointer :short))
    (handled (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecDITLItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_ImageCodecDITLItem" 
   ((ci (:pointer :ComponentInstanceRecord))
    (d (:pointer :OpaqueDialogPtr))
    (itemOffset :SInt16)
    (itemNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecDITLRemove()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_ImageCodecDITLRemove" 
   ((ci (:pointer :ComponentInstanceRecord))
    (d (:pointer :OpaqueDialogPtr))
    (itemOffset :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecDITLValidateInput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_ImageCodecDITLValidateInput" 
   ((ci (:pointer :ComponentInstanceRecord))
    (ok (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecPreflight()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecPreflight" 
   ((ci (:pointer :ComponentInstanceRecord))
    (params (:pointer :CodecDecompressParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecInitialize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecInitialize" 
   ((ci (:pointer :ComponentInstanceRecord))
    (cap (:pointer :ImageSubCodecDecompressCapabilities))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecBeginBand()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecBeginBand" 
   ((ci (:pointer :ComponentInstanceRecord))
    (params (:pointer :CodecDecompressParams))
    (drp (:pointer :ImageSubCodecDecompressRecord))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecDrawBand()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecDrawBand" 
   ((ci (:pointer :ComponentInstanceRecord))
    (drp (:pointer :ImageSubCodecDecompressRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecEndBand()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecEndBand" 
   ((ci (:pointer :ComponentInstanceRecord))
    (drp (:pointer :ImageSubCodecDecompressRecord))
    (result :SInt16)
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecQueueStarting()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecQueueStarting" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecQueueStopping()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecQueueStopping" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecDroppingFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecDroppingFrame" 
   ((ci (:pointer :ComponentInstanceRecord))
    (drp (:pointer :ImageSubCodecDecompressRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecScheduleFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_ImageCodecScheduleFrame" 
   ((ci (:pointer :ComponentInstanceRecord))
    (drp (:pointer :ImageSubCodecDecompressRecord))
    (triggerProc (:pointer :OpaqueImageCodecTimeTriggerProcPtr))
    (triggerProcRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecCancelTrigger()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_ImageCodecCancelTrigger" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  selectors for component calls 

(defconstant $kImageCodecGetCodecInfoSelect 0)
(defconstant $kImageCodecGetCompressionTimeSelect 1)
(defconstant $kImageCodecGetMaxCompressionSizeSelect 2)
(defconstant $kImageCodecPreCompressSelect 3)
(defconstant $kImageCodecBandCompressSelect 4)
(defconstant $kImageCodecPreDecompressSelect 5)
(defconstant $kImageCodecBandDecompressSelect 6)
(defconstant $kImageCodecBusySelect 7)
(defconstant $kImageCodecGetCompressedImageSizeSelect 8)
(defconstant $kImageCodecGetSimilaritySelect 9)
(defconstant $kImageCodecTrimImageSelect 10)
(defconstant $kImageCodecRequestSettingsSelect 11)
(defconstant $kImageCodecGetSettingsSelect 12)
(defconstant $kImageCodecSetSettingsSelect 13)
(defconstant $kImageCodecFlushSelect 14)
(defconstant $kImageCodecSetTimeCodeSelect 15)
(defconstant $kImageCodecIsImageDescriptionEquivalentSelect 16)
(defconstant $kImageCodecNewMemorySelect 17)
(defconstant $kImageCodecDisposeMemorySelect 18)
(defconstant $kImageCodecHitTestDataSelect 19)
(defconstant $kImageCodecNewImageBufferMemorySelect 20)
(defconstant $kImageCodecExtractAndCombineFieldsSelect 21)
(defconstant $kImageCodecGetMaxCompressionSizeWithSourcesSelect 22)
(defconstant $kImageCodecSetTimeBaseSelect 23)
(defconstant $kImageCodecSourceChangedSelect 24)
(defconstant $kImageCodecFlushFrameSelect 25)
(defconstant $kImageCodecGetSettingsAsTextSelect 26)
(defconstant $kImageCodecGetParameterListHandleSelect 27)
(defconstant $kImageCodecGetParameterListSelect 28)
(defconstant $kImageCodecCreateStandardParameterDialogSelect 29)
(defconstant $kImageCodecIsStandardParameterDialogEventSelect 30)
(defconstant $kImageCodecDismissStandardParameterDialogSelect 31)
(defconstant $kImageCodecStandardParameterDialogDoActionSelect 32)
(defconstant $kImageCodecNewImageGWorldSelect 33)
(defconstant $kImageCodecDisposeImageGWorldSelect 34)
(defconstant $kImageCodecHitTestDataWithFlagsSelect 35)
(defconstant $kImageCodecValidateParametersSelect 36)
(defconstant $kImageCodecGetBaseMPWorkFunctionSelect 37)
(defconstant $kImageCodecLockBitsSelect 38)
(defconstant $kImageCodecUnlockBitsSelect 39)
(defconstant $kImageCodecRequestGammaLevelSelect 40)
(defconstant $kImageCodecGetSourceDataGammaLevelSelect 41)
(defconstant $kImageCodecGetDecompressLatencySelect 43)
(defconstant $kImageCodecMergeFloatingImageOntoWindowSelect 44)
(defconstant $kImageCodecRemoveFloatingImageSelect 45)
(defconstant $kImageCodecGetDITLForSizeSelect 46)
(defconstant $kImageCodecDITLInstallSelect 47)
(defconstant $kImageCodecDITLEventSelect 48)
(defconstant $kImageCodecDITLItemSelect 49)
(defconstant $kImageCodecDITLRemoveSelect 50)
(defconstant $kImageCodecDITLValidateInputSelect 51)
(defconstant $kImageCodecPreflightSelect #x200)
(defconstant $kImageCodecInitializeSelect #x201)
(defconstant $kImageCodecBeginBandSelect #x202)
(defconstant $kImageCodecDrawBandSelect #x203)
(defconstant $kImageCodecEndBandSelect #x204)
(defconstant $kImageCodecQueueStartingSelect #x205)
(defconstant $kImageCodecQueueStoppingSelect #x206)
(defconstant $kImageCodecDroppingFrameSelect #x207)
(defconstant $kImageCodecScheduleFrameSelect #x208)
(defconstant $kImageCodecCancelTriggerSelect #x209)

(defconstant $kMotionJPEGTag :|mjpg|)
(defconstant $kJPEGQuantizationTablesImageDescriptionExtension :|mjqt|)
(defconstant $kJPEGHuffmanTablesImageDescriptionExtension :|mjht|)
(defconstant $kFieldInfoImageDescriptionExtension :|fiel|);  image description extension describing the field count and field orderings


(defconstant $kFieldOrderUnknown 0)
(defconstant $kFieldsStoredF1F2DisplayedF1F2 1)
(defconstant $kFieldsStoredF1F2DisplayedF2F1 2)
(defconstant $kFieldsStoredF2F1DisplayedF1F2 5)
(defconstant $kFieldsStoredF2F1DisplayedF2F1 6)
(defrecord MotionJPEGApp1Marker
   (unused :signed-long)
   (tag :signed-long)
   (fieldSize :signed-long)
   (paddedFieldSize :signed-long)
   (offsetToNextField :signed-long)
   (qTableOffset :signed-long)
   (huffmanTableOffset :signed-long)
   (sofOffset :signed-long)
   (sosOffset :signed-long)
   (soiOffset :signed-long)
)

;type name? (%define-record :MotionJPEGApp1Marker (find-record-descriptor ':MotionJPEGApp1Marker))
(defrecord FieldInfoImageDescriptionExtension
   (fieldCount :UInt8)
   (fieldOrderings :UInt8)
)

;type name? (%define-record :FieldInfoImageDescriptionExtension (find-record-descriptor ':FieldInfoImageDescriptionExtension))
; 
;  *  QTPhotoSetSampling()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTPhotoSetSampling" 
   ((codec (:pointer :ComponentInstanceRecord))
    (yH :SInt16)
    (yV :SInt16)
    (cbH :SInt16)
    (cbV :SInt16)
    (crH :SInt16)
    (crV :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTPhotoSetRestartInterval()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTPhotoSetRestartInterval" 
   ((codec (:pointer :ComponentInstanceRecord))
    (restartInterval :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTPhotoDefineHuffmanTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTPhotoDefineHuffmanTable" 
   ((codec (:pointer :ComponentInstanceRecord))
    (componentNumber :SInt16)
    (isDC :Boolean)
    (lengthCounts (:pointer :UInt8))
    (values (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTPhotoDefineQuantizationTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTPhotoDefineQuantizationTable" 
   ((codec (:pointer :ComponentInstanceRecord))
    (componentNumber :SInt16)
    (table (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  selectors for component calls 

(defconstant $kQTPhotoSetSamplingSelect #x100)
(defconstant $kQTPhotoSetRestartIntervalSelect #x101)
(defconstant $kQTPhotoDefineHuffmanTableSelect #x102)
(defconstant $kQTPhotoDefineQuantizationTableSelect #x103)
;  source identifier -- placed in root container of description, one or more required 

(defconstant $kEffectSourceName :|src |)
;  source type -- placed in the input map to identify the source kind 

(defconstant $kEffectDataSourceType :|dtst|)
;   default effect types 

(defconstant $kEffectRawSource 0)               ;  the source is raw image data

(defconstant $kEffectGenericType :|geff|)       ;  generic effect for combining others


;type name? (def-mactype :EffectSource (find-mactype ':EffectSource))

(def-mactype :EffectSourcePtr (find-mactype '(:pointer :EffectSource)))
(defrecord SourceData
   (:variant
   (
   (image (:pointer :CDSequenceDataSource))
   )
   (
   (effect (:pointer :EffectSource))
   )
   )
)

;type name? (%define-record :SourceData (find-record-descriptor ':SourceData))
(defrecord EffectSource
   (effectType :signed-long)                    ;  type of effect or kEffectRawSource if raw ICM data
   (data :pointer)                              ;  track data for this effect
   (source :SourceData)                         ;  source/effect pointers
   (next (:pointer :EffectSource))              ;  the next source for the parent effect
                                                ;  fields added for QuickTime 4.0
   (lastTranslatedFrameTime :signed-long)       ;  start frame time of last converted frame, may be -1
   (lastFrameDuration :signed-long)             ;  duration of the last converted frame, may be zero
   (lastFrameTimeScale :signed-long)            ;  time scale of this source frame, only has meaning if above fields are valid
)
(defrecord EffectsFrameParams
   (frameTime :ICMFrameTimeRecord)              ;  timing data
   (effectDuration :signed-long)                ;  the duration of a single effect frame
   (doAsync :Boolean)                           ;  set to true if the effect can go async
   (pad (:array :UInt8 3))
   (source (:pointer :EFFECTSOURCE))            ;  ptr to the source input tree
   (refCon :pointer)                            ;  storage for the effect
)

;type name? (%define-record :EffectsFrameParams (find-record-descriptor ':EffectsFrameParams))

(def-mactype :EffectsFrameParamsPtr (find-mactype '(:pointer :EffectsFrameParams)))
; 
;  *  ImageCodecEffectSetup()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecEffectSetup" 
   ((effect (:pointer :ComponentInstanceRecord))
    (p (:pointer :CodecDecompressParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecEffectBegin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecEffectBegin" 
   ((effect (:pointer :ComponentInstanceRecord))
    (p (:pointer :CodecDecompressParams))
    (ePtr (:pointer :EffectsFrameParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecEffectRenderFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecEffectRenderFrame" 
   ((effect (:pointer :ComponentInstanceRecord))
    (p (:pointer :EffectsFrameParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecEffectConvertEffectSourceToFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecEffectConvertEffectSourceToFormat" 
   ((effect (:pointer :ComponentInstanceRecord))
    (sourceToConvert (:pointer :EFFECTSOURCE))
    (requestedDesc (:Handle :ImageDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecEffectCancel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecEffectCancel" 
   ((effect (:pointer :ComponentInstanceRecord))
    (p (:pointer :EffectsFrameParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecEffectGetSpeed()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ImageCodecEffectGetSpeed" 
   ((effect (:pointer :ComponentInstanceRecord))
    (parameters :Handle)
    (pFPS (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(defconstant $kSMPTENoFlag 0)
(defconstant $kSMPTESmoothEdgeFlag 1)           ;  smooth edges of the stroke

(defconstant $kSMPTEStrokeEdgeFlag 2)           ;  stroke edge with color


(def-mactype :SMPTEFlags (find-mactype ':signed-long))

(def-mactype :SMPTEFrameReference (find-mactype ':signed-long))

(defconstant $kSlideHorizontalWipe 1)
(defconstant $kSlideVerticalWipe 2)
(defconstant $kTopLeftWipe 3)
(defconstant $kTopRightWipe 4)
(defconstant $kBottomRightWipe 5)
(defconstant $kBottomLeftWipe 6)
(defconstant $kFourCornerWipe 7)
(defconstant $kFourBoxWipe 8)
(defconstant $kBarnVerticalWipe 21)
(defconstant $kBarnHorizontalWipe 22)
(defconstant $kTopCenterWipe 23)
(defconstant $kRightCenterWipe 24)
(defconstant $kBottomCenterWipe 25)
(defconstant $kLeftCenterWipe 26)
(defconstant $kDiagonalLeftDownWipe 41)
(defconstant $kDiagonalRightDownWipe 42)
(defconstant $kTopBottomBowTieWipe 43)
(defconstant $kLeftRightBowTieWipe 44)
(defconstant $kDiagonalLeftOutWipe 45)
(defconstant $kDiagonalRightOutWipe 46)
(defconstant $kDiagonalCrossWipe 47)
(defconstant $kDiagonalBoxWipe 48)
(defconstant $kFilledVWipe 61)
(defconstant $kFilledVRightWipe 62)
(defconstant $kFilledVBottomWipe 63)
(defconstant $kFilledVLeftWipe 64)
(defconstant $kHollowVWipe 65)
(defconstant $kHollowVRightWipe 66)
(defconstant $kHollowVBottomWipe 67)
(defconstant $kHollowVLeftWipe 68)
(defconstant $kVerticalZigZagWipe 71)
(defconstant $kHorizontalZigZagWipe 72)
(defconstant $kVerticalBarnZigZagWipe 73)
(defconstant $kHorizontalBarnZigZagWipe 74)

(defconstant $kRectangleWipe 101)
(defconstant $kDiamondWipe 102)
(defconstant $kTriangleWipe 103)
(defconstant $kTriangleRightWipe 104)
(defconstant $kTriangleUpsideDownWipe 105)
(defconstant $kTriangleLeftWipe 106)
(defconstant $kSpaceShipWipe 107)
(defconstant $kSpaceShipRightWipe 108)
(defconstant $kSpaceShipUpsideDownWipe 109)
(defconstant $kSpaceShipLeftWipe 110)
(defconstant $kPentagonWipe 111)
(defconstant $kPentagonUpsideDownWipe 112)
(defconstant $kHexagonWipe 113)
(defconstant $kHexagonSideWipe 114)
(defconstant $kCircleWipe 119)
(defconstant $kOvalWipe 120)
(defconstant $kOvalSideWipe 121)
(defconstant $kCatEyeWipe 122)
(defconstant $kCatEyeSideWipe 123)
(defconstant $kRoundRectWipe 124)
(defconstant $kRoundRectSideWipe 125)
(defconstant $kFourPointStarWipe 127)
(defconstant $kFivePointStarWipe #x80)
(defconstant $kStarOfDavidWipe #x81)
(defconstant $kHeartWipe #x82)
(defconstant $kKeyholeWipe #x83)

(defconstant $kRotatingTopWipe #xC9)
(defconstant $kRotatingRightWipe #xCA)
(defconstant $kRotatingBottomWipe #xCB)
(defconstant $kRotatingLeftWipe #xCC)
(defconstant $kRotatingTopBottomWipe #xCD)
(defconstant $kRotatingLeftRightWipe #xCE)
(defconstant $kRotatingQuadrantWipe #xCF)
(defconstant $kTopToBottom180Wipe #xD3)
(defconstant $kRightToLeft180Wipe #xD4)
(defconstant $kTopToBottom90Wipe #xD5)
(defconstant $kRightToLeft90Wipe #xD6)
(defconstant $kTop180Wipe #xDD)
(defconstant $kRight180Wipe #xDE)
(defconstant $kBottom180Wipe #xDF)
(defconstant $kLeft180Wipe #xE0)
(defconstant $kCounterRotatingTopBottomWipe #xE1)
(defconstant $kCounterRotatingLeftRightWipe #xE2)
(defconstant $kDoubleRotatingTopBottomWipe #xE3)
(defconstant $kDoubleRotatingLeftRightWipe #xE4)
(defconstant $kVOpenTopWipe #xE7)
(defconstant $kVOpenRightWipe #xE8)
(defconstant $kVOpenBottomWipe #xE9)
(defconstant $kVOpenLeftWipe #xEA)
(defconstant $kVOpenTopBottomWipe #xEB)
(defconstant $kVOpenLeftRightWipe #xEC)
(defconstant $kRotatingTopLeftWipe #xF1)
(defconstant $kRotatingBottomLeftWipe #xF2)
(defconstant $kRotatingBottomRightWipe #xF3)
(defconstant $kRotatingTopRightWipe #xF4)
(defconstant $kRotatingTopLeftBottomRightWipe #xF5)
(defconstant $kRotatingBottomLeftTopRightWipe #xF6)
(defconstant $kRotatingTopLeftRightWipe #xFB)
(defconstant $kRotatingLeftTopBottomWipe #xFC)
(defconstant $kRotatingBottomLeftRightWipe #xFD)
(defconstant $kRotatingRightTopBottomWipe #xFE)
(defconstant $kRotatingDoubleCenterRightWipe #x105)
(defconstant $kRotatingDoubleCenterTopWipe #x106)
(defconstant $kRotatingDoubleCenterTopBottomWipe #x107)
(defconstant $kRotatingDoubleCenterLeftRightWipe #x108)

(defconstant $kHorizontalMatrixWipe #x12D)
(defconstant $kVerticalMatrixWipe #x12E)
(defconstant $kTopLeftDiagonalMatrixWipe #x12F)
(defconstant $kTopRightDiagonalMatrixWipe #x130)
(defconstant $kBottomRightDiagonalMatrixWipe #x131)
(defconstant $kBottomLeftDiagonalMatrixWipe #x132)
(defconstant $kClockwiseTopLeftMatrixWipe #x136)
(defconstant $kClockwiseTopRightMatrixWipe #x137)
(defconstant $kClockwiseBottomRightMatrixWipe #x138)
(defconstant $kClockwiseBottomLeftMatrixWipe #x139)
(defconstant $kCounterClockwiseTopLeftMatrixWipe #x13A)
(defconstant $kCounterClockwiseTopRightMatrixWipe #x13B)
(defconstant $kCounterClockwiseBottomRightMatrixWipe #x13C)
(defconstant $kCounterClockwiseBottomLeftMatrixWipe #x13D)
(defconstant $kVerticalStartTopMatrixWipe #x140)
(defconstant $kVerticalStartBottomMatrixWipe #x141)
(defconstant $kVerticalStartTopOppositeMatrixWipe #x142)
(defconstant $kVerticalStartBottomOppositeMatrixWipe #x143)
(defconstant $kHorizontalStartLeftMatrixWipe #x144)
(defconstant $kHorizontalStartRightMatrixWipe #x145)
(defconstant $kHorizontalStartLeftOppositeMatrixWipe #x146)
(defconstant $kHorizontalStartRightOppositeMatrixWipe #x147)
(defconstant $kDoubleDiagonalTopRightMatrixWipe #x148)
(defconstant $kDoubleDiagonalBottomRightMatrixWipe #x149)
(defconstant $kDoubleSpiralTopMatixWipe #x154)
(defconstant $kDoubleSpiralBottomMatixWipe #x155)
(defconstant $kDoubleSpiralLeftMatixWipe #x156)
(defconstant $kDoubleSpiralRightMatixWipe #x157)
(defconstant $kQuadSpiralVerticalMatixWipe #x158)
(defconstant $kQuadSpiralHorizontalMatixWipe #x159)
(defconstant $kVerticalWaterfallLeftMatrixWipe #x15E)
(defconstant $kVerticalWaterfallRightMatrixWipe #x15F)
(defconstant $kHorizontalWaterfallLeftMatrixWipe #x160)
(defconstant $kHorizontalWaterfallRightMatrixWipe #x161)
(defconstant $kRandomWipe #x199)                ;  non-SMPTE standard numbers

(defconstant $kRandomWipeGroupWipe #x1F5)
(defconstant $kRandomIrisGroupWipe #x1F6)
(defconstant $kRandomRadialGroupWipe #x1F7)
(defconstant $kRandomMatrixGroupWipe #x1F8)

(def-mactype :SMPTEWipeType (find-mactype ':UInt32))
; 
;  *  ImageCodecEffectPrepareSMPTEFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_ImageCodecEffectPrepareSMPTEFrame" 
   ((effect (:pointer :ComponentInstanceRecord))
    (destPixMap (:pointer :PixMap))
    (returnValue (:pointer :SMPTEFRAMEREFERENCE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecEffectDisposeSMPTEFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_ImageCodecEffectDisposeSMPTEFrame" 
   ((effect (:pointer :ComponentInstanceRecord))
    (frameRef :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ImageCodecEffectRenderSMPTEFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_ImageCodecEffectRenderSMPTEFrame" 
   ((effect (:pointer :ComponentInstanceRecord))
    (destPixMap (:pointer :PixMap))
    (frameRef :signed-long)
    (effectPercentageEven :signed-long)
    (effectPercentageOdd :signed-long)
    (pSourceRect (:pointer :Rect))
    (matrixP (:pointer :MatrixRecord))
    (effectNumber :UInt32)
    (xRepeat :signed-long)
    (yRepeat :signed-long)
    (flags :signed-long)
    (penWidth :signed-long)
    (strokeValue :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  selectors for component calls 

(defconstant $kImageCodecEffectSetupSelect #x300)
(defconstant $kImageCodecEffectBeginSelect #x301)
(defconstant $kImageCodecEffectRenderFrameSelect #x302)
(defconstant $kImageCodecEffectConvertEffectSourceToFormatSelect #x303)
(defconstant $kImageCodecEffectCancelSelect #x304)
(defconstant $kImageCodecEffectGetSpeedSelect #x305)
(defconstant $kImageCodecEffectPrepareSMPTEFrameSelect #x100)
(defconstant $kImageCodecEffectDisposeSMPTEFrameSelect #x101)
(defconstant $kImageCodecEffectRenderSMPTEFrameSelect #x102)
;  curve atom types and data structures 

(defconstant $kCurvePathAtom :|path|)
(defconstant $kCurveEndAtom :|zero|)
(defconstant $kCurveAntialiasControlAtom :|anti|)
(defconstant $kCurveAntialiasOff 0)
(defconstant $kCurveAntialiasOn #xFFFFFFFF)
(defconstant $kCurveFillTypeAtom :|fill|)
(defconstant $kCurvePenThicknessAtom :|pent|)
(defconstant $kCurveMiterLimitAtom :|mitr|)
(defconstant $kCurveJoinAttributesAtom :|join|)
(defconstant $kCurveMinimumDepthAtom :|mind|)
(defconstant $kCurveDepthAlwaysOffscreenMask #x80000000)
(defconstant $kCurveTransferModeAtom :|xfer|)
(defconstant $kCurveGradientAngleAtom :|angl|)
(defconstant $kCurveGradientRadiusAtom :|radi|)
(defconstant $kCurveGradientOffsetAtom :|cent|)

(defconstant $kCurveARGBColorAtom :|argb|)
(defrecord ARGBColor
   (alpha :UInt16)
   (red :UInt16)
   (green :UInt16)
   (blue :UInt16)
)

;type name? (%define-record :ARGBColor (find-record-descriptor ':ARGBColor))

(defconstant $kCurveGradientRecordAtom :|grad|)
(defrecord GradientColorRecord
   (thisColor :ARGBColor)
   (endingPercentage :signed-long)
)

;type name? (%define-record :GradientColorRecord (find-record-descriptor ':GradientColorRecord))

(def-mactype :GradientColorPtr (find-mactype '(:pointer :GradientColorRecord)))

(defconstant $kCurveGradientTypeAtom :|grdt|)
;  currently supported gradient types 

(defconstant $kLinearGradient 0)
(defconstant $kCircularGradient 1)

(def-mactype :GradientType (find-mactype ':signed-long))
; 
;  *  CurveGetLength()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CurveGetLength" 
   ((effect (:pointer :ComponentInstanceRecord))
    (target (:pointer :gxPaths))
    (index :signed-long)
    (wideLength (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CurveLengthToPoint()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CurveLengthToPoint" 
   ((effect (:pointer :ComponentInstanceRecord))
    (target (:pointer :gxPaths))
    (index :signed-long)
    (length :signed-long)
    (location (:pointer :FixedPoint))
    (tangent (:pointer :FixedPoint))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CurveNewPath()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CurveNewPath" 
   ((effect (:pointer :ComponentInstanceRecord))
    (pPath (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CurveCountPointsInPath()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CurveCountPointsInPath" 
   ((effect (:pointer :ComponentInstanceRecord))
    (aPath (:pointer :gxPaths))
    (contourIndex :UInt32)
    (pCount (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CurveGetPathPoint()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CurveGetPathPoint" 
   ((effect (:pointer :ComponentInstanceRecord))
    (aPath (:pointer :gxPaths))
    (contourIndex :UInt32)
    (pointIndex :UInt32)
    (thePoint (:pointer :gxPoint))
    (ptIsOnPath (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CurveInsertPointIntoPath()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CurveInsertPointIntoPath" 
   ((effect (:pointer :ComponentInstanceRecord))
    (aPoint (:pointer :gxPoint))
    (thePath :Handle)
    (contourIndex :UInt32)
    (pointIndex :UInt32)
    (ptIsOnPath :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CurveSetPathPoint()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CurveSetPathPoint" 
   ((effect (:pointer :ComponentInstanceRecord))
    (aPath (:pointer :gxPaths))
    (contourIndex :UInt32)
    (pointIndex :UInt32)
    (thePoint (:pointer :gxPoint))
    (ptIsOnPath :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CurveGetNearestPathPoint()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CurveGetNearestPathPoint" 
   ((effect (:pointer :ComponentInstanceRecord))
    (aPath (:pointer :gxPaths))
    (thePoint (:pointer :FixedPoint))
    (contourIndex (:pointer :UInt32))
    (pointIndex (:pointer :UInt32))
    (theDelta (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CurvePathPointToLength()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CurvePathPointToLength" 
   ((ci (:pointer :ComponentInstanceRecord))
    (aPath (:pointer :gxPaths))
    (startDist :signed-long)
    (endDist :signed-long)
    (thePoint (:pointer :FixedPoint))
    (pLength (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CurveCreateVectorStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CurveCreateVectorStream" 
   ((effect (:pointer :ComponentInstanceRecord))
    (pStream (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CurveAddAtomToVectorStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CurveAddAtomToVectorStream" 
   ((effect (:pointer :ComponentInstanceRecord))
    (atomType :OSType)
    (atomSize :signed-long)
    (pAtomData :pointer)
    (vectorStream :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CurveAddPathAtomToVectorStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CurveAddPathAtomToVectorStream" 
   ((effect (:pointer :ComponentInstanceRecord))
    (pathData :Handle)
    (vectorStream :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CurveAddZeroAtomToVectorStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CurveAddZeroAtomToVectorStream" 
   ((effect (:pointer :ComponentInstanceRecord))
    (vectorStream :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CurveGetAtomDataFromVectorStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_CurveGetAtomDataFromVectorStream" 
   ((effect (:pointer :ComponentInstanceRecord))
    (vectorStream :Handle)
    (atomType :signed-long)
    (dataSize (:pointer :long))
    (dataPtr (:pointer :Ptr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  selectors for component calls 

(defconstant $kCurveGetLengthSelect #x100)
(defconstant $kCurveLengthToPointSelect #x101)
(defconstant $kCurveNewPathSelect #x102)
(defconstant $kCurveCountPointsInPathSelect #x103)
(defconstant $kCurveGetPathPointSelect #x104)
(defconstant $kCurveInsertPointIntoPathSelect #x105)
(defconstant $kCurveSetPathPointSelect #x106)
(defconstant $kCurveGetNearestPathPointSelect #x107)
(defconstant $kCurvePathPointToLengthSelect #x108)
(defconstant $kCurveCreateVectorStreamSelect #x109)
(defconstant $kCurveAddAtomToVectorStreamSelect #x10A)
(defconstant $kCurveAddPathAtomToVectorStreamSelect #x10B)
(defconstant $kCurveAddZeroAtomToVectorStreamSelect #x10C)
(defconstant $kCurveGetAtomDataFromVectorStreamSelect #x10D)
;  UPP call backs 
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __IMAGECODEC__ */


(provide-interface "ImageCodec")