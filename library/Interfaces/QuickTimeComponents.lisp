(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:QuickTimeComponents.h"
; at Sunday July 2,2006 7:30:09 pm.
; 
;      File:       QuickTime/QuickTimeComponents.h
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
; #ifndef __QUICKTIMECOMPONENTS__
; #define __QUICKTIMECOMPONENTS__
; #ifndef __CARBON__
#| #|
#include <CarbonCarbon.h>
#endif
|#
 |#
; #ifndef __IMAGECOMPRESSION__
#| #|
#include <QuickTimeImageCompression.h>
#endif
|#
 |#
; #ifndef __MOVIES__
#| #|
#include <QuickTimeMovies.h>
#endif
|#
 |#
; #ifndef __QUICKTIMEMUSIC__

(require-interface "QuickTime/QuickTimeMusic")

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

(defconstant $clockComponentType :|clok|)
(defconstant $systemTickClock :|tick|)          ;  subtype: 60ths since boot   

(defconstant $systemSecondClock :|seco|)        ;  subtype: seconds since 1904       

(defconstant $systemMillisecondClock :|mill|)   ;  subtype: 1000ths since boot       

(defconstant $systemMicrosecondClock :|micr|)   ;  subtype: 1000000ths since boot 


(defconstant $kClockRateIsLinear 1)
(defconstant $kClockImplementsCallBacks 2)
(defconstant $kClockCanHandleIntermittentSound 4);  sound clocks only 


; #if OLDROUTINENAMES
#| 
; #define GetClockTime(aClock, out) ClockGetTime(aClock, out)
 |#

; #endif

; * These are Clock procedures *
; 
;  *  ClockGetTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ClockGetTime" 
   ((aClock (:pointer :ComponentInstanceRecord))
    (out (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ClockNewCallBack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ClockNewCallBack" 
   ((aClock (:pointer :ComponentInstanceRecord))
    (tb (:pointer :TimeBaseRecord))
    (callBackType :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :QTCallBackHeader)
() )
; 
;  *  ClockDisposeCallBack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ClockDisposeCallBack" 
   ((aClock (:pointer :ComponentInstanceRecord))
    (cb (:pointer :QTCallBackHeader))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ClockCallMeWhen()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ClockCallMeWhen" 
   ((aClock (:pointer :ComponentInstanceRecord))
    (cb (:pointer :QTCallBackHeader))
    (param1 :signed-long)
    (param2 :signed-long)
    (param3 :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ClockCancelCallBack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ClockCancelCallBack" 
   ((aClock (:pointer :ComponentInstanceRecord))
    (cb (:pointer :QTCallBackHeader))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ClockRateChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ClockRateChanged" 
   ((aClock (:pointer :ComponentInstanceRecord))
    (cb (:pointer :QTCallBackHeader))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ClockTimeChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ClockTimeChanged" 
   ((aClock (:pointer :ComponentInstanceRecord))
    (cb (:pointer :QTCallBackHeader))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ClockSetTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ClockSetTimeBase" 
   ((aClock (:pointer :ComponentInstanceRecord))
    (tb (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ClockStartStopChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ClockStartStopChanged" 
   ((aClock (:pointer :ComponentInstanceRecord))
    (cb (:pointer :QTCallBackHeader))
    (startChanged :Boolean)
    (stopChanged :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ClockGetRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_ClockGetRate" 
   ((aClock (:pointer :ComponentInstanceRecord))
    (rate (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ClockGetTimesForRateChange()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_ClockGetTimesForRateChange" 
   ((aClock (:pointer :ComponentInstanceRecord))
    (fromRate :signed-long)
    (toRate :signed-long)
    (currentTime (:pointer :TimeRecord))
    (preferredTime (:pointer :TimeRecord))
    (safeIncrementForPreferredTime (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  ClockGetRateChangeConstraints()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_ClockGetRateChangeConstraints" 
   ((aClock (:pointer :ComponentInstanceRecord))
    (minimumDelay (:pointer :TimeRecord))
    (maximumDelay (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
;  StdCompression component type and subtypes

(defconstant $StandardCompressionType :|scdi|)
(defconstant $StandardCompressionSubType :|imag|)
(defconstant $StandardCompressionSubTypeSound :|soun|)

(def-mactype :SCModalFilterProcPtr (find-mactype ':pointer)); (DialogRef theDialog , EventRecord * theEvent , short * itemHit , long refcon)

(def-mactype :SCModalHookProcPtr (find-mactype ':pointer)); (DialogRef theDialog , short itemHit , void * params , long refcon)

(def-mactype :SCModalFilterUPP (find-mactype '(:pointer :OpaqueSCModalFilterProcPtr)))

(def-mactype :SCModalHookUPP (find-mactype '(:pointer :OpaqueSCModalHookProcPtr)))
;   Preference flags.

(defconstant $scListEveryCodec 2)
(defconstant $scAllowZeroFrameRate 4)
(defconstant $scAllowZeroKeyFrameRate 8)
(defconstant $scShowBestDepth 16)
(defconstant $scUseMovableModal 32)
(defconstant $scDisableFrameRateItem 64)
(defconstant $scShowDataRateAsKilobits #x80)
;   Possible test flags for setting test image.

(defconstant $scPreferCropping 1)
(defconstant $scPreferScaling 2)
(defconstant $scPreferScalingAndCropping 3)
(defconstant $scDontDetermineSettingsFromTestImage 4)
;   Dimensions of the image preview box.

(defconstant $scTestImageWidth 80)
(defconstant $scTestImageHeight 80)
;   Possible items returned by hookProc.

(defconstant $scOKItem 1)
(defconstant $scCancelItem 2)
(defconstant $scCustomItem 3)
;   Result returned when user cancelled.

(defconstant $scUserCancelled 1)
;  Component selectors

(defconstant $scPositionRect 2)
(defconstant $scPositionDialog 3)
(defconstant $scSetTestImagePictHandle 4)
(defconstant $scSetTestImagePictFile 5)
(defconstant $scSetTestImagePixMap 6)
(defconstant $scGetBestDeviceRect 7)
(defconstant $scRequestImageSettings 10)
(defconstant $scCompressImage 11)
(defconstant $scCompressPicture 12)
(defconstant $scCompressPictureFile 13)
(defconstant $scRequestSequenceSettings 14)
(defconstant $scCompressSequenceBegin 15)
(defconstant $scCompressSequenceFrame 16)
(defconstant $scCompressSequenceEnd 17)
(defconstant $scDefaultPictHandleSettings 18)
(defconstant $scDefaultPictFileSettings 19)
(defconstant $scDefaultPixMapSettings 20)
(defconstant $scGetInfo 21)
(defconstant $scSetInfo 22)
(defconstant $scNewGWorld 23)
;   Get/SetInfo structures.
(defrecord SCSpatialSettings
   (codecType :OSType)
   (codec (:pointer :ComponentRecord))
   (depth :SInt16)
   (spatialQuality :UInt32)
)

;type name? (%define-record :SCSpatialSettings (find-record-descriptor ':SCSpatialSettings))
(defrecord SCTemporalSettings
   (temporalQuality :UInt32)
   (frameRate :signed-long)
   (keyFrameRate :signed-long)
)

;type name? (%define-record :SCTemporalSettings (find-record-descriptor ':SCTemporalSettings))
(defrecord SCDataRateSettings
   (dataRate :signed-long)
   (frameDuration :signed-long)
   (minSpatialQuality :UInt32)
   (minTemporalQuality :UInt32)
)

;type name? (%define-record :SCDataRateSettings (find-record-descriptor ':SCDataRateSettings))
(defrecord SCExtendedProcs
   (filterProc (:pointer :OpaqueSCModalFilterProcPtr))
   (hookProc (:pointer :OpaqueSCModalHookProcPtr))
   (refcon :signed-long)
   (customName (:string 31))
)

;type name? (%define-record :SCExtendedProcs (find-record-descriptor ':SCExtendedProcs))

(defconstant $scWindowRefKindCarbon :|carb|)    ;  WindowRef

(defrecord SCWindowSettings
   (size :signed-long)                          ;  must be sizeof(SCWindowSettings)
   (windowRefKind :signed-long)                 ;  type of parent window
   (parentWindow :pointer)                      ;  parent window, for sheets or NIL for none
)

;type name? (%define-record :SCWindowSettings (find-record-descriptor ':SCWindowSettings))
;   Get/SetInfo selectors

(defconstant $scSpatialSettingsType :|sptl|)    ;  pointer to SCSpatialSettings struct

(defconstant $scTemporalSettingsType :|tprl|)   ;  pointer to SCTemporalSettings struct

(defconstant $scDataRateSettingsType :|drat|)   ;  pointer to SCDataRateSettings struct

(defconstant $scColorTableType :|clut|)         ;  pointer to CTabHandle

(defconstant $scProgressProcType :|prog|)       ;  pointer to ProgressRecord struct

(defconstant $scExtendedProcsType :|xprc|)      ;  pointer to SCExtendedProcs struct

(defconstant $scPreferenceFlagsType :|pref|)    ;  pointer to long

(defconstant $scSettingsStateType :|ssta|)      ;  pointer to Handle

(defconstant $scSequenceIDType :|sequ|)         ;  pointer to ImageSequence

(defconstant $scWindowPositionType :|wndw|)     ;  pointer to Point

(defconstant $scCodecFlagsType :|cflg|)         ;  pointer to CodecFlags

(defconstant $scCodecSettingsType :|cdec|)      ;  pointer to Handle

(defconstant $scForceKeyValueType :|ksim|)      ;  pointer to long

(defconstant $scCompressionListType :|ctyl|)    ;  pointer to OSType Handle

(defconstant $scCodecManufacturerType :|cmfr|)  ;  pointer to OSType

(defconstant $scAvailableCompressionListType :|avai|);  pointer to OSType Handle

(defconstant $scWindowOptionsType :|shee|)      ;  pointer to SCWindowSettings struct

(defconstant $scSoundVBRCompressionOK :|cvbr|)  ;  pointer to Boolean

(defconstant $scSoundSampleRateChangeOK :|rcok|);  pointer to Boolean

(defconstant $scSoundCompressionType :|ssct|)   ;  pointer to OSType

(defconstant $scSoundSampleRateType :|ssrt|)    ;  pointer to UnsignedFixed

(defconstant $scSoundInputSampleRateType :|ssir|);  pointer to UnsignedFixed

(defconstant $scSoundSampleSizeType :|ssss|)    ;  pointer to short

(defconstant $scSoundChannelCountType :|sscc|)  ;  pointer to short

;   scTypeNotFoundErr returned by Get/SetInfo when type cannot be found.
(defrecord SCParams
   (flags :signed-long)
   (theCodecType :OSType)
   (theCodec (:pointer :ComponentRecord))
   (spatialQuality :UInt32)
   (temporalQuality :UInt32)
   (depth :SInt16)
   (frameRate :signed-long)
   (keyFrameRate :signed-long)
   (reserved1 :signed-long)
   (reserved2 :signed-long)
)

;type name? (%define-record :SCParams (find-record-descriptor ':SCParams))

(defconstant $scGetCompression 1)
(defconstant $scShowMotionSettings 1)
(defconstant $scSettingsChangedItem -1)

(defconstant $scCompressFlagIgnoreIdenticalFrames 1)
;  QTAtomTypes for atoms found in settings atom containers

(defconstant $kQTSettingsVideo :|vide|)         ;  Container for video/image compression related atoms (Get/SetInfo selectors)

(defconstant $kQTSettingsSound :|soun|)         ;  Container for sound compression related atoms (Get/SetInfo selectors)

(defconstant $kQTSettingsComponentVersion :|vers|);  . Version of component that wrote settings (QTSettingsVersionAtomRecord)

;  Format of 'vers' atom found in settings atom containers
(defrecord QTSettingsVersionAtomRecord
   (componentVersion :signed-long)              ;  standard compression component version
   (flags :SInt16)                              ;  low bit is 1 if little endian platform, 0 if big endian platform
   (reserved :SInt16)                           ;  should be 0
)

;type name? (%define-record :QTSettingsVersionAtomRecord (find-record-descriptor ':QTSettingsVersionAtomRecord))
; #define SCGetCompression(ci, params, where) SCGetCompressionExtended(ci,params,where,0,0,0,0)
; * These are Progress procedures *
; 
;  *  SCGetCompressionExtended()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCGetCompressionExtended" 
   ((ci (:pointer :ComponentInstanceRecord))
    (params (:pointer :SCParams))
    (where :Point)
    (filterProc (:pointer :OpaqueSCModalFilterProcPtr))
    (hookProc (:pointer :OpaqueSCModalHookProcPtr))
    (refcon :signed-long)
    (customName (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCPositionRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCPositionRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (rp (:pointer :Rect))
    (where (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCPositionDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCPositionDialog" 
   ((ci (:pointer :ComponentInstanceRecord))
    (id :SInt16)
    (where (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCSetTestImagePictHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCSetTestImagePictHandle" 
   ((ci (:pointer :ComponentInstanceRecord))
    (testPict (:Handle :Picture))
    (testRect (:pointer :Rect))
    (testFlags :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCSetTestImagePictFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCSetTestImagePictFile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (testFileRef :SInt16)
    (testRect (:pointer :Rect))
    (testFlags :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCSetTestImagePixMap()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCSetTestImagePixMap" 
   ((ci (:pointer :ComponentInstanceRecord))
    (testPixMap (:Handle :PixMap))
    (testRect (:pointer :Rect))
    (testFlags :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCGetBestDeviceRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCGetBestDeviceRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCRequestImageSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCRequestImageSettings" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCCompressImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCCompressImage" 
   ((ci (:pointer :ComponentInstanceRecord))
    (src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (desc (:pointer :IMAGEDESCRIPTIONHANDLE))
    (data (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCCompressPicture()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCCompressPicture" 
   ((ci (:pointer :ComponentInstanceRecord))
    (srcPicture (:Handle :Picture))
    (dstPicture (:Handle :Picture))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCCompressPictureFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCCompressPictureFile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (srcRefNum :SInt16)
    (dstRefNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCRequestSequenceSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCRequestSequenceSettings" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCCompressSequenceBegin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCCompressSequenceBegin" 
   ((ci (:pointer :ComponentInstanceRecord))
    (src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (desc (:pointer :IMAGEDESCRIPTIONHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCCompressSequenceFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCCompressSequenceFrame" 
   ((ci (:pointer :ComponentInstanceRecord))
    (src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (data (:pointer :Handle))
    (dataSize (:pointer :long))
    (notSyncFlag (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCCompressSequenceEnd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCCompressSequenceEnd" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCDefaultPictHandleSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCDefaultPictHandleSettings" 
   ((ci (:pointer :ComponentInstanceRecord))
    (srcPicture (:Handle :Picture))
    (motion :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCDefaultPictFileSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCDefaultPictFileSettings" 
   ((ci (:pointer :ComponentInstanceRecord))
    (srcRef :SInt16)
    (motion :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCDefaultPixMapSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCDefaultPixMapSettings" 
   ((ci (:pointer :ComponentInstanceRecord))
    (src (:Handle :PixMap))
    (motion :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCGetInfo" 
   ((ci (:pointer :ComponentInstanceRecord))
    (infoType :OSType)
    (info :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCSetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCSetInfo" 
   ((ci (:pointer :ComponentInstanceRecord))
    (infoType :OSType)
    (info :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCNewGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCNewGWorld" 
   ((ci (:pointer :ComponentInstanceRecord))
    (gwp (:pointer :GWORLDPTR))
    (rp (:pointer :Rect))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCSetCompressFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCSetCompressFlags" 
   ((ci (:pointer :ComponentInstanceRecord))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCGetCompressFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCGetCompressFlags" 
   ((ci (:pointer :ComponentInstanceRecord))
    (flags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCGetSettingsAsText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCGetSettingsAsText" 
   ((ci (:pointer :ComponentInstanceRecord))
    (text (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCGetSettingsAsAtomContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCGetSettingsAsAtomContainer" 
   ((ci (:pointer :ComponentInstanceRecord))
    (settings (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCSetSettingsFromAtomContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SCSetSettingsFromAtomContainer" 
   ((ci (:pointer :ComponentInstanceRecord))
    (settings :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Note: if you're using SCCompressSequenceFrameAsync with a scForceKeyValue setting, you must call SCAsyncIdle occasionally at main task time. 
; 
;  *  SCCompressSequenceFrameAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_SCCompressSequenceFrameAsync" 
   ((ci (:pointer :ComponentInstanceRecord))
    (src (:Handle :PixMap))
    (srcRect (:pointer :Rect))
    (data (:pointer :Handle))
    (dataSize (:pointer :long))
    (notSyncFlag (:pointer :short))
    (asyncCompletionProc (:pointer :ICMCompletionProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SCAsyncIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_SCAsyncIdle" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(defconstant $TweenComponentType :|twen|)

(def-mactype :TweenerComponent (find-mactype ':ComponentInstance))
; 
;  *  TweenerInitialize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TweenerInitialize" 
   ((tc (:pointer :ComponentInstanceRecord))
    (container :Handle)
    (tweenAtom :signed-long)
    (dataAtom :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TweenerDoTween()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TweenerDoTween" 
   ((tc (:pointer :ComponentInstanceRecord))
    (tr (:pointer :TWEENRECORD))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TweenerReset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TweenerReset" 
   ((tc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(defconstant $TCSourceRefNameType :|name|)

(defconstant $tcDropFrame 1)
(defconstant $tc24HourMax 2)
(defconstant $tcNegTimesOK 4)
(defconstant $tcCounter 8)
(defrecord TimeCodeDef
   (flags :signed-long)                         ;  drop-frame, etc.
   (fTimeScale :signed-long)                    ;  time scale of frameDuration (eg. 2997)
   (frameDuration :signed-long)                 ;  duration of each frame (eg. 100)
   (numFrames :UInt8)                           ;  frames/sec for timecode (eg. 30) OR frames/tick for counter mode
   (padding :UInt8)                             ;  unused padding byte
)

;type name? (%define-record :TimeCodeDef (find-record-descriptor ':TimeCodeDef))

(defconstant $tctNegFlag #x80)                  ;  negative bit is in minutes

(defrecord TimeCodeTime
   (hours :UInt8)
   (minutes :UInt8)
   (seconds :UInt8)
   (frames :UInt8)
)

;type name? (%define-record :TimeCodeTime (find-record-descriptor ':TimeCodeTime))
(defrecord TimeCodeCounter
   (counter :signed-long)
)

;type name? (%define-record :TimeCodeCounter (find-record-descriptor ':TimeCodeCounter))
(defrecord TimeCodeRecord
   (:variant
   (
   (t :TimeCodeTime)
   )
   (
   (c :TimeCodeCounter)
   )
   )
)

;type name? (%define-record :TimeCodeRecord (find-record-descriptor ':TimeCodeRecord))
(defrecord TimeCodeDescription
   (descSize :signed-long)                      ;  standard sample description header
   (dataFormat :signed-long)
   (resvd1 :signed-long)
   (resvd2 :SInt16)
   (dataRefIndex :SInt16)
   (flags :signed-long)                         ;  timecode specific stuff
   (timeCodeDef :TimeCodeDef)
   (srcRef (:array :signed-long 1))
)

;type name? (%define-record :TimeCodeDescription (find-record-descriptor ':TimeCodeDescription))

(def-mactype :TimeCodeDescriptionPtr (find-mactype '(:pointer :TimeCodeDescription)))

(def-mactype :TimeCodeDescriptionHandle (find-mactype '(:handle :TimeCodeDescription)))

(defconstant $tcdfShowTimeCode 1)
(defrecord TCTextOptions
   (txFont :SInt16)
   (txFace :SInt16)
   (txSize :SInt16)
   (pad :SInt16)                                ;  let's make it longword aligned - thanks.. 
   (foreColor :RGBColor)
   (backColor :RGBColor)
)

;type name? (%define-record :TCTextOptions (find-record-descriptor ':TCTextOptions))

(def-mactype :TCTextOptionsPtr (find-mactype '(:pointer :TCTextOptions)))
; 
;  *  TCGetCurrentTimeCode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TCGetCurrentTimeCode" 
   ((mh (:pointer :ComponentInstanceRecord))
    (frameNum (:pointer :long))
    (tcdef (:pointer :TimeCodeDef))
    (tcrec (:pointer :TimeCodeRecord))
    (srcRefH (:pointer :USERDATA))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TCGetTimeCodeAtTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TCGetTimeCodeAtTime" 
   ((mh (:pointer :ComponentInstanceRecord))
    (mediaTime :signed-long)
    (frameNum (:pointer :long))
    (tcdef (:pointer :TimeCodeDef))
    (tcdata (:pointer :TimeCodeRecord))
    (srcRefH (:pointer :USERDATA))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TCTimeCodeToString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TCTimeCodeToString" 
   ((mh (:pointer :ComponentInstanceRecord))
    (tcdef (:pointer :TimeCodeDef))
    (tcrec (:pointer :TimeCodeRecord))
    (tcStr (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TCTimeCodeToFrameNumber()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TCTimeCodeToFrameNumber" 
   ((mh (:pointer :ComponentInstanceRecord))
    (tcdef (:pointer :TimeCodeDef))
    (tcrec (:pointer :TimeCodeRecord))
    (frameNumber (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TCFrameNumberToTimeCode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TCFrameNumberToTimeCode" 
   ((mh (:pointer :ComponentInstanceRecord))
    (frameNumber :signed-long)
    (tcdef (:pointer :TimeCodeDef))
    (tcrec (:pointer :TimeCodeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TCGetSourceRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TCGetSourceRef" 
   ((mh (:pointer :ComponentInstanceRecord))
    (tcdH (:Handle :TimeCodeDescription))
    (srefH (:pointer :USERDATA))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TCSetSourceRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TCSetSourceRef" 
   ((mh (:pointer :ComponentInstanceRecord))
    (tcdH (:Handle :TimeCodeDescription))
    (srefH (:Handle :UserDataRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TCSetTimeCodeFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TCSetTimeCodeFlags" 
   ((mh (:pointer :ComponentInstanceRecord))
    (flags :signed-long)
    (flagsMask :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TCGetTimeCodeFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TCGetTimeCodeFlags" 
   ((mh (:pointer :ComponentInstanceRecord))
    (flags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TCSetDisplayOptions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TCSetDisplayOptions" 
   ((mh (:pointer :ComponentInstanceRecord))
    (textOptions (:pointer :TCTextOptions))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TCGetDisplayOptions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TCGetDisplayOptions" 
   ((mh (:pointer :ComponentInstanceRecord))
    (textOptions (:pointer :TCTextOptions))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(def-mactype :MovieImportComponent (find-mactype ':ComponentInstance))

(def-mactype :MovieExportComponent (find-mactype ':ComponentInstance))

(defconstant $MovieImportType :|eat |)
(defconstant $MovieExportType :|spit|)

(defconstant $canMovieImportHandles 1)
(defconstant $canMovieImportFiles 2)
(defconstant $hasMovieImportUserInterface 4)
(defconstant $canMovieExportHandles 8)
(defconstant $canMovieExportFiles 16)
(defconstant $hasMovieExportUserInterface 32)
(defconstant $movieImporterIsXMLBased 32)
(defconstant $dontAutoFileMovieImport 64)
(defconstant $canMovieExportAuxDataHandle #x80)
(defconstant $canMovieImportValidateHandles #x100)
(defconstant $canMovieImportValidateFile #x200)
(defconstant $dontRegisterWithEasyOpen #x400)
(defconstant $canMovieImportInPlace #x800)
(defconstant $movieImportSubTypeIsFileExtension #x1000)
(defconstant $canMovieImportPartial #x2000)
(defconstant $hasMovieImportMIMEList #x4000)
(defconstant $canMovieImportAvoidBlocking #x8000)
(defconstant $canMovieExportFromProcedures #x8000)
(defconstant $canMovieExportValidateMovie #x10000)
(defconstant $movieImportMustGetDestinationMediaType #x10000)
(defconstant $movieExportNeedsResourceFork #x20000)
(defconstant $canMovieImportDataReferences #x40000)
(defconstant $movieExportMustGetSourceMediaType #x80000)
(defconstant $canMovieImportWithIdle #x100000)
(defconstant $canMovieImportValidateDataReferences #x200000)
(defconstant $reservedForUseByGraphicsImporters #x800000)

(defconstant $movieImportCreateTrack 1)
(defconstant $movieImportInParallel 2)
(defconstant $movieImportMustUseTrack 4)
(defconstant $movieImportWithIdle 16)

(defconstant $movieImportResultUsedMultipleTracks 8)
(defconstant $movieImportResultNeedIdles 32)
(defconstant $movieImportResultComplete 64)

(defconstant $kMovieExportTextOnly 0)
(defconstant $kMovieExportAbsoluteTime 1)
(defconstant $kMovieExportRelativeTime 2)

(defconstant $kMIDIImportSilenceBefore 1)
(defconstant $kMIDIImportSilenceAfter 2)
(defconstant $kMIDIImport20Playable 4)
(defconstant $kMIDIImportWantLyrics 8)

(defconstant $kQTMediaConfigResourceType :|mcfg|)
(defconstant $kQTMediaConfigResourceVersion 2)
(defconstant $kQTMediaGroupResourceType :|mgrp|)
(defconstant $kQTMediaGroupResourceVersion 1)
(defconstant $kQTBrowserInfoResourceType :|brws|)
(defconstant $kQTBrowserInfoResourceVersion 1)

(defconstant $kQTMediaMIMEInfoHasChanged 2)     ;  the MIME type(s) is(are) new or has changed since the last time
;   someone asked about it

(defconstant $kQTMediaFileInfoHasChanged 4)     ;  the file extension(s) is(are) new or has changed since the last time
;   anyone asked about it

(defconstant $kQTMediaConfigCanUseApp #x40000)  ;  this MIME type can be configured to use app

(defconstant $kQTMediaConfigCanUsePlugin #x80000);  this MIME type can be configured to use plug-in

(defconstant $kQTMediaConfigUNUSED #x100000)    ;  currently unused

(defconstant $kQTMediaConfigBinaryFile #x800000);  file should be transfered in binary mode

(defconstant $kQTMediaConfigTextFile 0)         ;  not a bit, defined for clarity

(defconstant $kQTMediaConfigMacintoshFile #x1000000);  file's resource fork is significant

(defconstant $kQTMediaConfigCanDoFileAssociation #x4000000);  can configure this file association 

(defconstant $kQTMediaConfigAssociateByDefault #x8000000);  Deprecated, use kQTMediaConfigTakeFileAssociationByDefault instead

(defconstant $kQTMediaConfigTakeFileAssociationByDefault #x8000000);  take this file association by default

(defconstant $kQTMediaConfigUseAppByDefault #x10000000);  use the app by default for this MIME type

(defconstant $kQTMediaConfigUsePluginByDefault #x20000000);  use the plug-in by default for this MIME type

(defconstant $kQTMediaConfigDefaultsMask #x30000000)
(defconstant $kQTMediaConfigDefaultsShift 12)   ;  ((flags & kQTMediaConfigDefaultsMask) >> kQTMediaConfigDefaultsShift) to get default setting 
;  the file has a "QuickTime like" file format 

(defconstant $kQTMediaConfigHasFileHasQTAtoms #x40000000)
;  mime type group constants for groupID field of 'mcfg' resource

(defconstant $kQTMediaConfigStreamGroupID :|strm|)
(defconstant $kQTMediaConfigInteractiveGroupID :|intr|)
(defconstant $kQTMediaConfigVideoGroupID :|eyes|)
(defconstant $kQTMediaConfigAudioGroupID :|ears|)
(defconstant $kQTMediaConfigMPEGGroupID :|mpeg|)
(defconstant $kQTMediaConfigMP3GroupID :|mp3 |)
(defconstant $kQTMediaConfigImageGroupID :|ogle|)
(defconstant $kQTMediaConfigMiscGroupID :|misc|)
;  file type group constants for groupID field of 'mcfg' resource

(defconstant $kQTMediaInfoNetGroup :|net |)
(defconstant $kQTMediaInfoWinGroup :|win |)
(defconstant $kQTMediaInfoMacGroup :|mac |)
(defconstant $kQTMediaInfoMiscGroup #x3F3F3F3F) ;  '????'


(defconstant $kMimeInfoMimeTypeTag :|mime|)
(defconstant $kMimeInfoFileExtensionTag :|ext |)
(defconstant $kMimeInfoDescriptionTag :|desc|)
(defconstant $kMimeInfoGroupTag :|grop|)
(defconstant $kMimeInfoDoNotOverrideExistingFileTypeAssociation :|nofa|)

(defconstant $kQTFileTypeAIFF :|AIFF|)
(defconstant $kQTFileTypeAIFC :|AIFC|)
(defconstant $kQTFileTypeDVC :|dvc!|)
(defconstant $kQTFileTypeMIDI :|Midi|)
(defconstant $kQTFileTypePicture :|PICT|)
(defconstant $kQTFileTypeMovie :|MooV|)
(defconstant $kQTFileTypeText :|TEXT|)
(defconstant $kQTFileTypeWave :|WAVE|)
(defconstant $kQTFileTypeSystemSevenSound :|sfil|)
(defconstant $kQTFileTypeMuLaw :|ULAW|)
(defconstant $kQTFileTypeAVI :|VfW |)
(defconstant $kQTFileTypeSoundDesignerII :|Sd2f|)
(defconstant $kQTFileTypeAudioCDTrack :|trak|)
(defconstant $kQTFileTypePICS :|PICS|)
(defconstant $kQTFileTypeGIF :|GIFf|)
(defconstant $kQTFileTypePNG :|PNGf|)
(defconstant $kQTFileTypeTIFF :|TIFF|)
(defconstant $kQTFileTypePhotoShop :|8BPS|)
(defconstant $kQTFileTypeSGIImage :|.SGI|)
(defconstant $kQTFileTypeBMP :|BMPf|)
(defconstant $kQTFileTypeJPEG :|JPEG|)
(defconstant $kQTFileTypeJFIF :|JPEG|)
(defconstant $kQTFileTypeMacPaint :|PNTG|)
(defconstant $kQTFileTypeTargaImage :|TPIC|)
(defconstant $kQTFileTypeQuickDrawGXPicture :|qdgx|)
(defconstant $kQTFileTypeQuickTimeImage :|qtif|)
(defconstant $kQTFileType3DMF :|3DMF|)
(defconstant $kQTFileTypeFLC :|FLC |)
(defconstant $kQTFileTypeFlash :|SWFL|)
(defconstant $kQTFileTypeFlashPix :|FPix|)
(defconstant $kQTFileTypeMP4 :|mpg4|)
(defconstant $kQTFileTypePDF :|PDF |)
(defconstant $kQTFileType3GPP :|3gpp|)
(defconstant $kQTFileTypeAMR :|amr |)
(defconstant $kQTFileTypeSDV :|sdv |)
;  QTAtomTypes for atoms in import/export settings containers

(defconstant $kQTSettingsDVExportNTSC :|dvcv|)  ;  True is export as NTSC, false is export as PAL. (Boolean)

(defconstant $kQTSettingsDVExportLockedAudio :|lock|);  True if audio locked to video. (Boolean)

(defconstant $kQTSettingsEffect :|effe|)        ;  Parent atom whose contents are atoms of an effects description

(defconstant $kQTSettingsGraphicsFileImportSequence :|sequ|);  Parent atom of graphic file movie import component

(defconstant $kQTSettingsGraphicsFileImportSequenceEnabled :|enab|);  . If true, import numbered image sequence (Boolean)

(defconstant $kQTSettingsMovieExportEnableVideo :|envi|);  Enable exporting of video track (Boolean)

(defconstant $kQTSettingsMovieExportEnableSound :|enso|);  Enable exporting of sound track (Boolean)

(defconstant $kQTSettingsMovieExportSaveOptions :|save|);  Parent atom of save options

(defconstant $kQTSettingsMovieExportSaveForInternet :|fast|);  . Save for Internet

(defconstant $kQTSettingsMovieExportSaveCompressedMovie :|cmpm|);  . Save compressed movie resource

(defconstant $kQTSettingsMIDI :|MIDI|)          ;  MIDI import related container

(defconstant $kQTSettingsMIDISettingFlags :|sttg|);  . MIDI import settings (UInt32)

(defconstant $kQTSettingsText :|text|)          ;  Text related container

(defconstant $kQTSettingsTextDescription :|desc|);  . Text import settings (TextDescription record)

(defconstant $kQTSettingsTextSize :|size|)      ;  . Width/height to create during import (FixedPoint)

(defconstant $kQTSettingsTextSettingFlags :|sttg|);  . Text export settings (UInt32)

(defconstant $kQTSettingsTextTimeFraction :|timf|);  . Movie time fraction for export (UInt32)

(defconstant $kQTSettingsTime :|time|)          ;  Time related container

(defconstant $kQTSettingsTimeDuration :|dura|)  ;  . Time related container

(defconstant $kQTSettingsAudioCDTrack :|trak|)  ;  Audio CD track related container

(defconstant $kQTSettingsAudioCDTrackRateShift :|rshf|);  . Rate shift to be performed (SInt16)

(defconstant $kQTSettingsDVExportDVFormat :|dvcf|);  Exported DV Format, DV('dv  ') or DVCPRO('dvp '). (OSType)

(defrecord MovieExportGetDataParams
   (recordSize :signed-long)
   (trackID :signed-long)
   (sourceTimeScale :signed-long)
   (requestedTime :signed-long)
   (actualTime :signed-long)
   (dataPtr :pointer)
   (dataSize :signed-long)
   (desc (:Handle :SampleDescription))
   (descType :OSType)
   (descSeed :signed-long)
   (requestedSampleCount :signed-long)
   (actualSampleCount :signed-long)
   (durationPerSample :signed-long)
   (sampleFlags :signed-long)
)

;type name? (%define-record :MovieExportGetDataParams (find-record-descriptor ':MovieExportGetDataParams))

(def-mactype :MovieExportGetDataProcPtr (find-mactype ':pointer)); (void * refCon , MovieExportGetDataParams * params)

(def-mactype :MovieExportGetPropertyProcPtr (find-mactype ':pointer)); (void * refcon , long trackID , OSType propertyType , void * propertyValue)

(defconstant $kQTPresetsListResourceType :|stg#|)
(defconstant $kQTPresetsPlatformListResourceType :|stgp|)

(defconstant $kQTPresetInfoIsDivider 1)
(defrecord QTPresetInfo
   (presetKey :OSType)                          ;  unique key for this preset in presetsArray 
   (presetFlags :UInt32)                        ;  flags about this preset 
   (settingsResourceType :OSType)               ;  resource type of settings resource 
   (settingsResourceID :SInt16)                 ;  resource id of settings resource 
   (padding1 :SInt16)
   (nameStringListID :SInt16)                   ;  name string list resource id 
   (nameStringIndex :SInt16)                    ;  name string index 
   (infoStringListID :SInt16)                   ;  info string list resource id 
   (infoStringIndex :SInt16)                    ;  info string index 
)

;type name? (%define-record :QTPresetInfo (find-record-descriptor ':QTPresetInfo))
(defrecord QTPresetListRecord
   (flags :UInt32)                              ;  flags for whole list 
   (count :UInt32)                              ;  number of elements in presetsArray 
   (reserved :UInt32)
   (presetsArray (:array :QTPresetInfo 1))      ;  info about each preset 
)

;type name? (%define-record :QTPresetListRecord (find-record-descriptor ':QTPresetListRecord))

(defconstant $kQTMovieExportSourceInfoResourceType :|src#|)
(defconstant $kQTMovieExportSourceInfoIsMediaType 1)
(defconstant $kQTMovieExportSourceInfoIsMediaCharacteristic 2)
(defconstant $kQTMovieExportSourceInfoIsSourceType 4)
(defrecord QTMovieExportSourceInfo
   (mediaType :OSType)                          ;  Media type of source 
   (minCount :UInt16)                           ;  min number of sources of this kind required, zero if none required 
   (maxCount :UInt16)                           ;  max number of sources of this kind allowed, -1 if unlimited allowed 
   (flags :signed-long)                         ;  reserved for flags 
)

;type name? (%define-record :QTMovieExportSourceInfo (find-record-descriptor ':QTMovieExportSourceInfo))
(defrecord QTMovieExportSourceRecord
   (count :signed-long)
   (reserved :signed-long)
   (sourceArray (:array :QTMovieExportSourceInfo 1))
)

;type name? (%define-record :QTMovieExportSourceRecord (find-record-descriptor ':QTMovieExportSourceRecord))

(def-mactype :MovieExportGetDataUPP (find-mactype '(:pointer :OpaqueMovieExportGetDataProcPtr)))

(def-mactype :MovieExportGetPropertyUPP (find-mactype '(:pointer :OpaqueMovieExportGetPropertyProcPtr)))
; 
;  *  NewSCModalFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSCModalFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSCModalFilterProcPtr)
() )
; 
;  *  NewSCModalHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSCModalHookUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSCModalHookProcPtr)
() )
; 
;  *  NewMovieExportGetDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMovieExportGetDataUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMovieExportGetDataProcPtr)
() )
; 
;  *  NewMovieExportGetPropertyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewMovieExportGetPropertyUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueMovieExportGetPropertyProcPtr)
() )
; 
;  *  DisposeSCModalFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSCModalFilterUPP" 
   ((userUPP (:pointer :OpaqueSCModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSCModalHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSCModalHookUPP" 
   ((userUPP (:pointer :OpaqueSCModalHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeMovieExportGetDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMovieExportGetDataUPP" 
   ((userUPP (:pointer :OpaqueMovieExportGetDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeMovieExportGetPropertyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeMovieExportGetPropertyUPP" 
   ((userUPP (:pointer :OpaqueMovieExportGetPropertyProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeSCModalFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSCModalFilterUPP" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (theEvent (:pointer :EventRecord))
    (itemHit (:pointer :short))
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueSCModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeSCModalHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSCModalHookUPP" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (itemHit :SInt16)
    (params :pointer)
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueSCModalHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  InvokeMovieExportGetDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMovieExportGetDataUPP" 
   ((refCon :pointer)
    (params (:pointer :MovieExportGetDataParams))
    (userUPP (:pointer :OpaqueMovieExportGetDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeMovieExportGetPropertyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeMovieExportGetPropertyUPP" 
   ((refcon :pointer)
    (trackID :signed-long)
    (propertyType :OSType)
    (propertyValue :pointer)
    (userUPP (:pointer :OpaqueMovieExportGetPropertyProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  MovieImportHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportHandle" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataH :Handle)
    (theMovie (:Handle :MovieType))
    (targetTrack (:Handle :TrackType))
    (usedTrack (:pointer :TRACK))
    (atTime :signed-long)
    (addedDuration (:pointer :TIMEVALUE))
    (inFlags :signed-long)
    (outFlags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportFile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theFile (:pointer :FSSpec))
    (theMovie (:Handle :MovieType))
    (targetTrack (:Handle :TrackType))
    (usedTrack (:pointer :TRACK))
    (atTime :signed-long)
    (addedDuration (:pointer :TIMEVALUE))
    (inFlags :signed-long)
    (outFlags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetSampleDuration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportSetSampleDuration" 
   ((ci (:pointer :ComponentInstanceRecord))
    (duration :signed-long)
    (scale :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetSampleDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportSetSampleDescription" 
   ((ci (:pointer :ComponentInstanceRecord))
    (desc (:Handle :SampleDescription))
    (mediaType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetMediaFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportSetMediaFile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (alias (:Handle :AliasRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetDimensions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportSetDimensions" 
   ((ci (:pointer :ComponentInstanceRecord))
    (width :signed-long)
    (height :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetChunkSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportSetChunkSize" 
   ((ci (:pointer :ComponentInstanceRecord))
    (chunkSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetProgressProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportSetProgressProc" 
   ((ci (:pointer :ComponentInstanceRecord))
    (proc (:pointer :OpaqueMovieProgressProcPtr))
    (refcon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetAuxiliaryData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportSetAuxiliaryData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (data :Handle)
    (handleType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetFromScrap()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportSetFromScrap" 
   ((ci (:pointer :ComponentInstanceRecord))
    (fromScrap :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportDoUserDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportDoUserDialog" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theFile (:pointer :FSSpec))
    (theData :Handle)
    (canceled (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetDuration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportSetDuration" 
   ((ci (:pointer :ComponentInstanceRecord))
    (duration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportGetAuxiliaryDataType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportGetAuxiliaryDataType" 
   ((ci (:pointer :ComponentInstanceRecord))
    (auxType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportValidate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportValidate" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theFile (:pointer :FSSpec))
    (theData :Handle)
    (valid (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportGetFileType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportGetFileType" 
   ((ci (:pointer :ComponentInstanceRecord))
    (fileType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportDataRef" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataRefType :OSType)
    (theMovie (:Handle :MovieType))
    (targetTrack (:Handle :TrackType))
    (usedTrack (:pointer :TRACK))
    (atTime :signed-long)
    (addedDuration (:pointer :TIMEVALUE))
    (inFlags :signed-long)
    (outFlags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportGetSampleDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportGetSampleDescription" 
   ((ci (:pointer :ComponentInstanceRecord))
    (desc (:pointer :SAMPLEDESCRIPTIONHANDLE))
    (mediaType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportGetMIMETypeList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportGetMIMETypeList" 
   ((ci (:pointer :ComponentInstanceRecord))
    (mimeInfo (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetOffsetAndLimit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportSetOffsetAndLimit" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offset :UInt32)
    (limit :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportGetSettingsAsAtomContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportGetSettingsAsAtomContainer" 
   ((ci (:pointer :ComponentInstanceRecord))
    (settings (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetSettingsFromAtomContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieImportSetSettingsFromAtomContainer" 
   ((ci (:pointer :ComponentInstanceRecord))
    (settings :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetOffsetAndLimit64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MovieImportSetOffsetAndLimit64" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offset (:pointer :wide))
    (limit (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MovieImportIdle" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inFlags :signed-long)
    (outFlags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportValidateDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MovieImportValidateDataRef" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataRefType :OSType)
    (valid (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportGetLoadState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_MovieImportGetLoadState" 
   ((ci (:pointer :ComponentInstanceRecord))
    (importerLoadState (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportGetMaxLoadedTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_MovieImportGetMaxLoadedTime" 
   ((ci (:pointer :ComponentInstanceRecord))
    (time (:pointer :TIMEVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportEstimateCompletionTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_MovieImportEstimateCompletionTime" 
   ((ci (:pointer :ComponentInstanceRecord))
    (time (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetDontBlock()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_MovieImportSetDontBlock" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dontBlock :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportGetDontBlock()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_MovieImportGetDontBlock" 
   ((ci (:pointer :ComponentInstanceRecord))
    (willBlock (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetIdleManager()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MovieImportSetIdleManager" 
   ((ci (:pointer :ComponentInstanceRecord))
    (im (:pointer :OpaqueIdleManager))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetNewMovieFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MovieImportSetNewMovieFlags" 
   ((ci (:pointer :ComponentInstanceRecord))
    (newMovieFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportGetDestinationMediaType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_MovieImportGetDestinationMediaType" 
   ((ci (:pointer :ComponentInstanceRecord))
    (mediaType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportSetMediaDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_MovieImportSetMediaDataRef" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  MovieImportDoUserDialogDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_MovieImportDoUserDialogDataRef" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataRefType :OSType)
    (canceled (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportToHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportToHandle" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataH :Handle)
    (theMovie (:Handle :MovieType))
    (onlyThisTrack (:Handle :TrackType))
    (startTime :signed-long)
    (duration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportToFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportToFile" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theFile (:pointer :FSSpec))
    (theMovie (:Handle :MovieType))
    (onlyThisTrack (:Handle :TrackType))
    (startTime :signed-long)
    (duration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportGetAuxiliaryData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportGetAuxiliaryData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataH :Handle)
    (handleType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportSetProgressProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportSetProgressProc" 
   ((ci (:pointer :ComponentInstanceRecord))
    (proc (:pointer :OpaqueMovieProgressProcPtr))
    (refcon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportSetSampleDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportSetSampleDescription" 
   ((ci (:pointer :ComponentInstanceRecord))
    (desc (:Handle :SampleDescription))
    (mediaType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportDoUserDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportDoUserDialog" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theMovie (:Handle :MovieType))
    (onlyThisTrack (:Handle :TrackType))
    (startTime :signed-long)
    (duration :signed-long)
    (canceled (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportGetCreatorType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportGetCreatorType" 
   ((ci (:pointer :ComponentInstanceRecord))
    (creator (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportToDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportToDataRef" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataRefType :OSType)
    (theMovie (:Handle :MovieType))
    (onlyThisTrack (:Handle :TrackType))
    (startTime :signed-long)
    (duration :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportFromProceduresToDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportFromProceduresToDataRef" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataRefType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportAddDataSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportAddDataSource" 
   ((ci (:pointer :ComponentInstanceRecord))
    (trackType :OSType)
    (scale :signed-long)
    (trackID (:pointer :long))
    (getPropertyProc (:pointer :OpaqueMovieExportGetPropertyProcPtr))
    (getDataProc (:pointer :OpaqueMovieExportGetDataProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportValidate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportValidate" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theMovie (:Handle :MovieType))
    (onlyThisTrack (:Handle :TrackType))
    (valid (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportGetSettingsAsAtomContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportGetSettingsAsAtomContainer" 
   ((ci (:pointer :ComponentInstanceRecord))
    (settings (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportSetSettingsFromAtomContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportSetSettingsFromAtomContainer" 
   ((ci (:pointer :ComponentInstanceRecord))
    (settings :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportGetFileNameExtension()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportGetFileNameExtension" 
   ((ci (:pointer :ComponentInstanceRecord))
    (extension (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportGetShortFileTypeString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportGetShortFileTypeString" 
   ((ci (:pointer :ComponentInstanceRecord))
    (typeString (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportGetSourceMediaType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportGetSourceMediaType" 
   ((ci (:pointer :ComponentInstanceRecord))
    (mediaType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportSetGetMoviePropertyProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_MovieExportSetGetMoviePropertyProc" 
   ((ci (:pointer :ComponentInstanceRecord))
    (getPropertyProc (:pointer :OpaqueMovieExportGetPropertyProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Text Export Display Info data structure
(defrecord TextDisplayData
   (displayFlags :signed-long)
   (textJustification :signed-long)
   (bgColor :RGBColor)
   (textBox :Rect)
   (beginHilite :SInt16)
   (endHilite :SInt16)
   (hiliteColor :RGBColor)
   (doHiliteColor :Boolean)
   (filler :SInt8)
   (scrollDelayDur :signed-long)
   (dropShadowOffset :Point)
   (dropShadowTransparency :SInt16)
)

;type name? (%define-record :TextDisplayData (find-record-descriptor ':TextDisplayData))

(def-mactype :TextExportComponent (find-mactype ':ComponentInstance))

(def-mactype :GraphicImageMovieImportComponent (find-mactype ':ComponentInstance))
; 
;  *  TextExportGetDisplayData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TextExportGetDisplayData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (textDisplay (:pointer :TextDisplayData))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TextExportGetTimeFraction()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TextExportGetTimeFraction" 
   ((ci (:pointer :ComponentInstanceRecord))
    (movieTimeFraction (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TextExportSetTimeFraction()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TextExportSetTimeFraction" 
   ((ci (:pointer :ComponentInstanceRecord))
    (movieTimeFraction :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TextExportGetSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TextExportGetSettings" 
   ((ci (:pointer :ComponentInstanceRecord))
    (setting (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  TextExportSetSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_TextExportSetSettings" 
   ((ci (:pointer :ComponentInstanceRecord))
    (setting :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MIDIImportGetSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MIDIImportGetSettings" 
   ((ci (:pointer :ComponentInstanceRecord))
    (setting (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MIDIImportSetSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MIDIImportSetSettings" 
   ((ci (:pointer :ComponentInstanceRecord))
    (setting :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportNewGetDataAndPropertiesProcs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportNewGetDataAndPropertiesProcs" 
   ((ci (:pointer :ComponentInstanceRecord))
    (trackType :OSType)
    (scale (:pointer :TIMESCALE))
    (theMovie (:Handle :MovieType))
    (theTrack (:Handle :TrackType))
    (startTime :signed-long)
    (duration :signed-long)
    (getPropertyProc (:pointer :MOVIEEXPORTGETPROPERTYUPP))
    (getDataProc (:pointer :MOVIEEXPORTGETDATAUPP))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  MovieExportDisposeGetDataAndPropertiesProcs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_MovieExportDisposeGetDataAndPropertiesProcs" 
   ((ci (:pointer :ComponentInstanceRecord))
    (getPropertyProc (:pointer :OpaqueMovieExportGetPropertyProcPtr))
    (getDataProc (:pointer :OpaqueMovieExportGetDataProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(defconstant $movieExportUseConfiguredSettings :|ucfg|);  pointer to Boolean

(defconstant $movieExportWidth :|wdth|)         ;  pointer to Fixed

(defconstant $movieExportHeight :|hegt|)        ;  pointer to Fixed

(defconstant $movieExportDuration :|dura|)      ;  pointer to TimeRecord

(defconstant $movieExportVideoFilter :|iflt|)   ;  pointer to QTAtomContainer

(defconstant $movieExportTimeScale :|tmsc|)     ;  pointer to TimeScale

; 
;  *  GraphicsImageImportSetSequenceEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImageImportSetSequenceEnabled" 
   ((ci (:pointer :ComponentInstanceRecord))
    (enable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GraphicsImageImportGetSequenceEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_GraphicsImageImportGetSequenceEnabled" 
   ((ci (:pointer :ComponentInstanceRecord))
    (enable (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; ----------------------------'brws' • browser prefs configuration info ------------------------
;  Mac browser can use plug-in from System "Internet Plug-ins" folder 

(defconstant $kQTBrowserInfoCanUseSystemFolderPlugin 1)
;  Open component as preflight check

(defconstant $kQTPreFlightOpenComponent 2)
(defrecord ComponentPreflightFlags
   (flags :signed-long)
)

;type name? (%define-record :ComponentPreflightFlags (find-record-descriptor ':ComponentPreflightFlags))
; **************
; 
;     File Preview Components
; 
; **************

(def-mactype :pnotComponent (find-mactype ':ComponentInstance))

(defconstant $pnotComponentWantsEvents 1)
(defconstant $pnotComponentNeedsNoCache 2)

(defconstant $ShowFilePreviewComponentType :|pnot|)
(defconstant $CreateFilePreviewComponentType :|pmak|)
; 
;  *  PreviewShowData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PreviewShowData" 
   ((p (:pointer :ComponentInstanceRecord))
    (dataType :OSType)
    (data :Handle)
    (inHere (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  PreviewMakePreview()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PreviewMakePreview" 
   ((p (:pointer :ComponentInstanceRecord))
    (previewType (:pointer :OSType))
    (previewResult (:pointer :Handle))
    (sourceFile (:pointer :FSSpec))
    (progress (:pointer :ICMProgressProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  PreviewMakePreviewReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PreviewMakePreviewReference" 
   ((p (:pointer :ComponentInstanceRecord))
    (previewType (:pointer :OSType))
    (resID (:pointer :short))
    (sourceFile (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  PreviewEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_PreviewEvent" 
   ((p (:pointer :ComponentInstanceRecord))
    (e (:pointer :EventRecord))
    (handledEvent (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(def-mactype :DataCompressorComponent (find-mactype ':ComponentInstance))

(def-mactype :DataDecompressorComponent (find-mactype ':ComponentInstance))

(def-mactype :DataCodecComponent (find-mactype ':ComponentInstance))

(defconstant $DataCompressorComponentType :|dcom|)
(defconstant $DataDecompressorComponentType :|ddec|)
(defconstant $AppleDataCompressorSubType :|adec|)
(defconstant $zlibDataCompressorSubType :|zlib|)
; * These are DataCodec procedures *
; 
;  *  DataCodecDecompress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataCodecDecompress" 
   ((dc (:pointer :ComponentInstanceRecord))
    (srcData :pointer)
    (srcSize :UInt32)
    (dstData :pointer)
    (dstBufferSize :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataCodecGetCompressBufferSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataCodecGetCompressBufferSize" 
   ((dc (:pointer :ComponentInstanceRecord))
    (srcSize :UInt32)
    (dstSize (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataCodecCompress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataCodecCompress" 
   ((dc (:pointer :ComponentInstanceRecord))
    (srcData :pointer)
    (srcSize :UInt32)
    (dstData :pointer)
    (dstBufferSize :UInt32)
    (actualDstSize (:pointer :UInt32))
    (decompressSlop (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataCodecBeginInterruptSafe()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataCodecBeginInterruptSafe" 
   ((dc (:pointer :ComponentInstanceRecord))
    (maxSrcSize :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataCodecEndInterruptSafe()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataCodecEndInterruptSafe" 
   ((dc (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataCodecDecompressPartial()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataCodecDecompressPartial" 
   ((dc (:pointer :ComponentInstanceRecord))
    (next_in :pointer)
    (avail_in (:pointer :UInt32))
    (total_in (:pointer :UInt32))
    (next_out :pointer)
    (avail_out (:pointer :UInt32))
    (total_out (:pointer :UInt32))
    (didFinish (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataCodecCompressPartial()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataCodecCompressPartial" 
   ((dc (:pointer :ComponentInstanceRecord))
    (next_in :pointer)
    (avail_in (:pointer :UInt32))
    (total_in (:pointer :UInt32))
    (next_out :pointer)
    (avail_out (:pointer :UInt32))
    (total_out (:pointer :UInt32))
    (tryToFinish :Boolean)
    (didFinish (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(def-mactype :DataHCompletionProcPtr (find-mactype ':pointer)); (Ptr request , long refcon , OSErr err)

(def-mactype :DataHCompletionUPP (find-mactype '(:pointer :OpaqueDataHCompletionProcPtr)))

(defconstant $kDataHCanRead 1)
(defconstant $kDataHSpecialRead 2)
(defconstant $kDataHSpecialReadFile 4)
(defconstant $kDataHCanWrite 8)
(defconstant $kDataHSpecialWrite 16)
(defconstant $kDataHSpecialWriteFile 32)
(defconstant $kDataHCanStreamingWrite 64)
(defconstant $kDataHMustCheckDataRef #x80)
;  Data reference records for specific data ref types
(defrecord HandleDataRefRecord
   (dataHndl :Handle)
)

;type name? (%define-record :HandleDataRefRecord (find-record-descriptor ':HandleDataRefRecord))

(def-mactype :HandleDataRefPtr (find-mactype '(:pointer :HandleDataRefRecord)))

(def-mactype :HandleDataRef (find-mactype '(:handle :HandleDataRefRecord)))
(defrecord PointerDataRefRecord
   (data :pointer)
   (dataLength :signed-long)
)

;type name? (%define-record :PointerDataRefRecord (find-record-descriptor ':PointerDataRefRecord))

(def-mactype :PointerDataRefPtr (find-mactype '(:pointer :PointerDataRefRecord)))

(def-mactype :PointerDataRef (find-mactype '(:handle :PointerDataRefRecord)))
;  Data reference extensions

(defconstant $kDataRefExtensionChokeSpeed :|chok|)
(defconstant $kDataRefExtensionFileName :|fnam|)
(defconstant $kDataRefExtensionMIMEType :|mime|)
(defconstant $kDataRefExtensionMacOSFileType :|ftyp|)
(defconstant $kDataRefExtensionInitializationData :|data|)
(defconstant $kDataRefExtensionQuickTimeMediaType :|mtyp|)

(defconstant $kDataHChokeToMovieDataRate 1)     ;  param is 0
;  param is bytes per second

(defconstant $kDataHChokeToParam 2)
(defrecord DataHChokeAtomRecord
   (flags :signed-long)                         ;  one of kDataHChokeTo constants
   (param :signed-long)
)

;type name? (%define-record :DataHChokeAtomRecord (find-record-descriptor ':DataHChokeAtomRecord))
(defrecord DataHVolumeListRecord
   (vRefNum :SInt16)
   (flags :signed-long)
)

;type name? (%define-record :DataHVolumeListRecord (find-record-descriptor ':DataHVolumeListRecord))

(def-mactype :DataHVolumeListPtr (find-mactype '(:pointer :DataHVolumeListRecord)))

(def-mactype :DataHVolumeList (find-mactype '(:handle :DataHVolumeListRecord)))

(defconstant $kDataHExtendedSchedule :|xtnd|)
(defrecord DataHScheduleRecord
   (timeNeededBy :TimeRecord)
   (extendedID :signed-long)                    ;  always is kDataHExtendedSchedule
   (extendedVers :signed-long)                  ;  always set to 0
   (priority :signed-long)                      ;  100.0 or more means must have. lower numbers…
)

;type name? (%define-record :DataHScheduleRecord (find-record-descriptor ':DataHScheduleRecord))

(def-mactype :DataHSchedulePtr (find-mactype '(:pointer :DataHScheduleRecord)))
;  Flags for DataHGetInfoFlags

(defconstant $kDataHInfoFlagNeverStreams 1)     ;  set if this data handler doesn't stream

(defconstant $kDataHInfoFlagCanUpdateDataRefs 2);  set if this data handler might update data reference
;  set if this data handler may need to occupy the network

(defconstant $kDataHInfoFlagNeedsNetworkBandwidth 4)
;  Types for DataHGetFileTypeOrdering

(defconstant $kDataHFileTypeMacOSFileType :|ftyp|)
(defconstant $kDataHFileTypeExtension :|fext|)
(defconstant $kDataHFileTypeMIME :|mime|)

(def-mactype :DataHFileTypeOrderingPtr (find-mactype '(:pointer :OSType)))

(def-mactype :DataHFileTypeOrderingHandle (find-mactype '(:handle :OSType)))
; 
;  *  DataHGetData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetData" 
   ((dh (:pointer :ComponentInstanceRecord))
    (h :Handle)
    (hOffset :signed-long)
    (offset :signed-long)
    (size :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHPutData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHPutData" 
   ((dh (:pointer :ComponentInstanceRecord))
    (h :Handle)
    (hOffset :signed-long)
    (offset (:pointer :long))
    (size :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHFlushData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHFlushData" 
   ((dh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHOpenForWrite()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHOpenForWrite" 
   ((dh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHCloseForWrite()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHCloseForWrite" 
   ((dh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHOpenForRead()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHOpenForRead" 
   ((dh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHCloseForRead()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHCloseForRead" 
   ((dh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHSetDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHSetDataRef" 
   ((dh (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetDataRef" 
   ((dh (:pointer :ComponentInstanceRecord))
    (dataRef (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHCompareDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHCompareDataRef" 
   ((dh (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (equal (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHTask" 
   ((dh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHScheduleData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHScheduleData" 
   ((dh (:pointer :ComponentInstanceRecord))
    (PlaceToPutDataPtr :pointer)
    (FileOffset :signed-long)
    (DataSize :signed-long)
    (RefCon :signed-long)
    (scheduleRec (:pointer :DataHScheduleRecord))
    (CompletionRtn (:pointer :OpaqueDataHCompletionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHFinishData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHFinishData" 
   ((dh (:pointer :ComponentInstanceRecord))
    (PlaceToPutDataPtr :pointer)
    (Cancel :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHFlushCache()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHFlushCache" 
   ((dh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHResolveDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHResolveDataRef" 
   ((dh (:pointer :ComponentInstanceRecord))
    (theDataRef :Handle)
    (wasChanged (:pointer :Boolean))
    (userInterfaceAllowed :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetFileSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetFileSize" 
   ((dh (:pointer :ComponentInstanceRecord))
    (fileSize (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHCanUseDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHCanUseDataRef" 
   ((dh (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (useFlags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetVolumeList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetVolumeList" 
   ((dh (:pointer :ComponentInstanceRecord))
    (volumeList (:pointer :DATAHVOLUMELIST))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHWrite()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHWrite" 
   ((dh (:pointer :ComponentInstanceRecord))
    (data :pointer)
    (offset :signed-long)
    (size :signed-long)
    (completion (:pointer :OpaqueDataHCompletionProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHPreextend()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHPreextend" 
   ((dh (:pointer :ComponentInstanceRecord))
    (maxToAdd :UInt32)
    (spaceAdded (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHSetFileSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHSetFileSize" 
   ((dh (:pointer :ComponentInstanceRecord))
    (fileSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetFreeSpace()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetFreeSpace" 
   ((dh (:pointer :ComponentInstanceRecord))
    (freeSize (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHCreateFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHCreateFile" 
   ((dh (:pointer :ComponentInstanceRecord))
    (creator :OSType)
    (deleteExisting :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetPreferredBlockSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetPreferredBlockSize" 
   ((dh (:pointer :ComponentInstanceRecord))
    (blockSize (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetDeviceIndex()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetDeviceIndex" 
   ((dh (:pointer :ComponentInstanceRecord))
    (deviceIndex (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHIsStreamingDataHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHIsStreamingDataHandler" 
   ((dh (:pointer :ComponentInstanceRecord))
    (yes (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetDataInBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetDataInBuffer" 
   ((dh (:pointer :ComponentInstanceRecord))
    (startOffset :signed-long)
    (size (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetScheduleAheadTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetScheduleAheadTime" 
   ((dh (:pointer :ComponentInstanceRecord))
    (millisecs (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHSetCacheSizeLimit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHSetCacheSizeLimit" 
   ((dh (:pointer :ComponentInstanceRecord))
    (cacheSizeLimit :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetCacheSizeLimit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetCacheSizeLimit" 
   ((dh (:pointer :ComponentInstanceRecord))
    (cacheSizeLimit (:pointer :SIZE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetMovie" 
   ((dh (:pointer :ComponentInstanceRecord))
    (theMovie (:pointer :Movie))
    (id (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHAddMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHAddMovie" 
   ((dh (:pointer :ComponentInstanceRecord))
    (theMovie (:Handle :MovieType))
    (id (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHUpdateMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHUpdateMovie" 
   ((dh (:pointer :ComponentInstanceRecord))
    (theMovie (:Handle :MovieType))
    (id :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHDoesBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHDoesBuffer" 
   ((dh (:pointer :ComponentInstanceRecord))
    (buffersReads (:pointer :Boolean))
    (buffersWrites (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetFileName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetFileName" 
   ((dh (:pointer :ComponentInstanceRecord))
    (str (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetAvailableFileSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetAvailableFileSize" 
   ((dh (:pointer :ComponentInstanceRecord))
    (fileSize (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetMacOSFileType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetMacOSFileType" 
   ((dh (:pointer :ComponentInstanceRecord))
    (fileType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetMIMEType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetMIMEType" 
   ((dh (:pointer :ComponentInstanceRecord))
    (mimeType (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHSetDataRefWithAnchor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHSetDataRefWithAnchor" 
   ((dh (:pointer :ComponentInstanceRecord))
    (anchorDataRef :Handle)
    (dataRefType :OSType)
    (dataRef :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetDataRefWithAnchor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHGetDataRefWithAnchor" 
   ((dh (:pointer :ComponentInstanceRecord))
    (anchorDataRef :Handle)
    (dataRefType :OSType)
    (dataRef (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHSetMacOSFileType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHSetMacOSFileType" 
   ((dh (:pointer :ComponentInstanceRecord))
    (fileType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHSetTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHSetTimeBase" 
   ((dh (:pointer :ComponentInstanceRecord))
    (tb (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetInfoFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_DataHGetInfoFlags" 
   ((dh (:pointer :ComponentInstanceRecord))
    (flags (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHScheduleData64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_DataHScheduleData64" 
   ((dh (:pointer :ComponentInstanceRecord))
    (PlaceToPutDataPtr :pointer)
    (FileOffset (:pointer :wide))
    (DataSize :signed-long)
    (RefCon :signed-long)
    (scheduleRec (:pointer :DataHScheduleRecord))
    (CompletionRtn (:pointer :OpaqueDataHCompletionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHWrite64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_DataHWrite64" 
   ((dh (:pointer :ComponentInstanceRecord))
    (data :pointer)
    (offset (:pointer :wide))
    (size :signed-long)
    (completion (:pointer :OpaqueDataHCompletionProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetFileSize64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_DataHGetFileSize64" 
   ((dh (:pointer :ComponentInstanceRecord))
    (fileSize (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHPreextend64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_DataHPreextend64" 
   ((dh (:pointer :ComponentInstanceRecord))
    (maxToAdd (:pointer :wide))
    (spaceAdded (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHSetFileSize64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_DataHSetFileSize64" 
   ((dh (:pointer :ComponentInstanceRecord))
    (fileSize (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetFreeSpace64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_DataHGetFreeSpace64" 
   ((dh (:pointer :ComponentInstanceRecord))
    (freeSize (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHAppend64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_DataHAppend64" 
   ((dh (:pointer :ComponentInstanceRecord))
    (data :pointer)
    (fileOffset (:pointer :wide))
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHReadAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_DataHReadAsync" 
   ((dh (:pointer :ComponentInstanceRecord))
    (dataPtr :pointer)
    (dataSize :UInt32)
    (dataOffset (:pointer :wide))
    (completion (:pointer :OpaqueDataHCompletionProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHPollRead()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_DataHPollRead" 
   ((dh (:pointer :ComponentInstanceRecord))
    (dataPtr :pointer)
    (dataSizeSoFar (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetDataAvailability()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_DataHGetDataAvailability" 
   ((dh (:pointer :ComponentInstanceRecord))
    (offset :signed-long)
    (len :signed-long)
    (missing_offset (:pointer :long))
    (missing_len (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetFileSizeAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_DataHGetFileSizeAsync" 
   ((dh (:pointer :ComponentInstanceRecord))
    (fileSize (:pointer :wide))
    (completionRtn (:pointer :OpaqueDataHCompletionProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetDataRefAsType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_DataHGetDataRefAsType" 
   ((dh (:pointer :ComponentInstanceRecord))
    (requestedType :OSType)
    (dataRef (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHSetDataRefExtension()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_DataHSetDataRefExtension" 
   ((dh (:pointer :ComponentInstanceRecord))
    (extension :Handle)
    (idType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetDataRefExtension()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_DataHGetDataRefExtension" 
   ((dh (:pointer :ComponentInstanceRecord))
    (extension (:pointer :Handle))
    (idType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetMovieWithFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_DataHGetMovieWithFlags" 
   ((dh (:pointer :ComponentInstanceRecord))
    (theMovie (:pointer :Movie))
    (id (:pointer :short))
    (flags :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetFileTypeOrdering()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_DataHGetFileTypeOrdering" 
   ((dh (:pointer :ComponentInstanceRecord))
    (orderingListHandle (:pointer :DATAHFILETYPEORDERINGHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  flags for DataHCreateFileWithFlags

(defconstant $kDataHCreateFileButDontCreateResFile 1)
; 
;  *  DataHCreateFileWithFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_DataHCreateFileWithFlags" 
   ((dh (:pointer :ComponentInstanceRecord))
    (creator :OSType)
    (deleteExisting :Boolean)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetMIMETypeAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_DataHGetMIMETypeAsync" 
   ((dh (:pointer :ComponentInstanceRecord))
    (mimeType (:pointer :STR255))
    (completionRtn (:pointer :OpaqueDataHCompletionProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0.1 and later
;  *    Windows:          in qtmlClient.lib 5.0.1 and later
;  

(deftrap-inline "_DataHGetInfo" 
   ((dh (:pointer :ComponentInstanceRecord))
    (what :OSType)
    (info :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  DataHSetIdleManager()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_DataHSetIdleManager" 
   ((dh (:pointer :ComponentInstanceRecord))
    (im (:pointer :OpaqueIdleManager))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  DataHDeleteFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_DataHDeleteFile" 
   ((dh (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
;  if set, datahandler should append wide and mdat atoms in append call

(defconstant $kDataHMovieUsageDoAppendMDAT 1)
; 
;  *  DataHSetMovieUsageFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_DataHSetMovieUsageFlags" 
   ((dh (:pointer :ComponentInstanceRecord))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )

(defconstant $kDataHTempUseSameDirectory 1)     ;  temp data ref should be in same directory as current data ref (vs. in temporary directory)

(defconstant $kDataHTempUseSameVolume 2)        ;  temp data ref should be on same volume as current data ref (vs. find "best" volume)

(defconstant $kDataHTempCreateFile 4)           ;  create the file
;  open temporary file for write (kDataHTempCreateFile must be passed, too)

(defconstant $kDataHTempOpenFile 8)
; 
;  *  DataHUseTemporaryDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_DataHUseTemporaryDataRef" 
   ((dh (:pointer :ComponentInstanceRecord))
    (inFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  DataHGetTemporaryDataRefCapabilities()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_DataHGetTemporaryDataRefCapabilities" 
   ((dh (:pointer :ComponentInstanceRecord))
    (outUnderstoodFlags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  DataHRenameFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_DataHRenameFile" 
   ((dh (:pointer :ComponentInstanceRecord))
    (newDataRef :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  DataHPlaybackHints()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_DataHPlaybackHints" 
   ((dh (:pointer :ComponentInstanceRecord))
    (flags :signed-long)
    (minFileOffset :UInt32)
    (maxFileOffset :UInt32)
    (bytesPerSecond :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  DataHPlaybackHints64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.1 and later
;  *    Windows:          in qtmlClient.lib 4.1 and later
;  

(deftrap-inline "_DataHPlaybackHints64" 
   ((dh (:pointer :ComponentInstanceRecord))
    (flags :signed-long)
    (minFileOffset (:pointer :wide))
    (maxFileOffset (:pointer :wide))
    (bytesPerSecond :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Symbolic constants for DataHGetDataRate

(defconstant $kDataHGetDataRateInfiniteRate #x7FFFFFFF);  all the data arrived instantaneously

; 
;  *  DataHGetDataRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_DataHGetDataRate" 
   ((dh (:pointer :ComponentInstanceRecord))
    (flags :signed-long)
    (bytesPerSecond (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Flags for DataHSetTimeHints
;  set if this data handler should use the network without requesting bandwidth

(defconstant $kDataHSetTimeHintsSkipBandwidthRequest 1)
; 
;  *  DataHSetTimeHints()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_DataHSetTimeHints" 
   ((dh (:pointer :ComponentInstanceRecord))
    (flags :signed-long)
    (bandwidthPriority :signed-long)
    (scale :signed-long)
    (minTime :signed-long)
    (maxTime :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Standard type for video digitizers 

(defconstant $videoDigitizerComponentType :|vdig|)
(defconstant $vdigInterfaceRev 2)
;  Input Format Standards 

(defconstant $ntscIn 0)                         ;  current input format 

(defconstant $currentIn 0)                      ;  ntsc input format 

(defconstant $palIn 1)                          ;  pal input format 

(defconstant $secamIn 2)                        ;  secam input format 

(defconstant $ntscReallyIn 3)                   ;  ntsc input format 

;  Input Formats 

(defconstant $compositeIn 0)                    ;  input is composite format 

(defconstant $sVideoIn 1)                       ;  input is sVideo format 

(defconstant $rgbComponentIn 2)                 ;  input is rgb component format 

(defconstant $rgbComponentSyncIn 3)             ;  input is rgb component format (sync on green?)

(defconstant $yuvComponentIn 4)                 ;  input is yuv component format 

(defconstant $yuvComponentSyncIn 5)             ;  input is yuv component format (sync on green?) 

(defconstant $tvTunerIn 6)
(defconstant $sdiIn 7)
;  Video Digitizer PlayThru States 

(defconstant $vdPlayThruOff 0)
(defconstant $vdPlayThruOn 1)
;  Input Color Space Modes 

(defconstant $vdDigitizerBW 0)                  ;  black and white 

(defconstant $vdDigitizerRGB 1)                 ;  rgb color 

;  Phase Lock Loop Modes 

(defconstant $vdBroadcastMode 0)                ;  Broadcast / Laser Disk video mode 

(defconstant $vdVTRMode 1)                      ;  VCR / Magnetic media mode 

;  Field Select Options 

(defconstant $vdUseAnyField 0)                  ;  Digitizers choice on field use 

(defconstant $vdUseOddField 1)                  ;  Use odd field for half size vert and smaller 

(defconstant $vdUseEvenField 2)                 ;  Use even field for half size vert and smaller 

;  vdig types 

(defconstant $vdTypeBasic 0)                    ;  basic, no clipping 

(defconstant $vdTypeAlpha 1)                    ;  supports clipping with alpha channel 

(defconstant $vdTypeMask 2)                     ;  supports clipping with mask plane 

(defconstant $vdTypeKey 3)                      ;  supports clipping with key color(s) 

;  Digitizer Input Capability/Current Flags 

(defconstant $digiInDoesNTSC 1)                 ;  digitizer supports NTSC input format 

(defconstant $digiInDoesPAL 2)                  ;  digitizer supports PAL input format 

(defconstant $digiInDoesSECAM 4)                ;  digitizer supports SECAM input format 

(defconstant $digiInDoesGenLock #x80)           ;  digitizer does genlock 

(defconstant $digiInDoesComposite #x100)        ;  digitizer supports composite input type 

(defconstant $digiInDoesSVideo #x200)           ;  digitizer supports S-Video input type 

(defconstant $digiInDoesComponent #x400)        ;  digitizer supports component = rgb, input type 

(defconstant $digiInVTR_Broadcast #x800)        ;  digitizer can differentiate between the two 

(defconstant $digiInDoesColor #x1000)           ;  digitizer supports color 

(defconstant $digiInDoesBW #x2000)              ;  digitizer supports black & white 
;  Digitizer Input Current Flags = these are valid only during active operating conditions,   
;  digitizer detects input signal is locked, this bit = horiz lock || vertical lock 

(defconstant $digiInSignalLock #x80000000)
;  Digitizer Output Capability/Current Flags 

(defconstant $digiOutDoes1 1)                   ;  digitizer supports 1 bit pixels 

(defconstant $digiOutDoes2 2)                   ;  digitizer supports 2 bit pixels 

(defconstant $digiOutDoes4 4)                   ;  digitizer supports 4 bit pixels 

(defconstant $digiOutDoes8 8)                   ;  digitizer supports 8 bit pixels 

(defconstant $digiOutDoes16 16)                 ;  digitizer supports 16 bit pixels 

(defconstant $digiOutDoes32 32)                 ;  digitizer supports 32 bit pixels 

(defconstant $digiOutDoesDither 64)             ;  digitizer dithers in indexed modes 

(defconstant $digiOutDoesStretch #x80)          ;  digitizer can arbitrarily stretch 

(defconstant $digiOutDoesShrink #x100)          ;  digitizer can arbitrarily shrink 

(defconstant $digiOutDoesMask #x200)            ;  digitizer can mask to clipping regions 

(defconstant $digiOutDoesDouble #x800)          ;  digitizer can stretch to exactly double size 

(defconstant $digiOutDoesQuad #x1000)           ;  digitizer can stretch exactly quadruple size 

(defconstant $digiOutDoesQuarter #x2000)        ;  digitizer can shrink to exactly quarter size 

(defconstant $digiOutDoesSixteenth #x4000)      ;  digitizer can shrink to exactly sixteenth size 

(defconstant $digiOutDoesRotate #x8000)         ;  digitizer supports rotate transformations 

(defconstant $digiOutDoesHorizFlip #x10000)     ;  digitizer supports horizontal flips Sx < 0 

(defconstant $digiOutDoesVertFlip #x20000)      ;  digitizer supports vertical flips Sy < 0 

(defconstant $digiOutDoesSkew #x40000)          ;  digitizer supports skew = shear,twist, 

(defconstant $digiOutDoesBlend #x80000)
(defconstant $digiOutDoesWarp #x100000)
(defconstant $digiOutDoesHW_DMA #x200000)       ;  digitizer not constrained to local device 

(defconstant $digiOutDoesHWPlayThru #x400000)   ;  digitizer doesn't need time to play thru 

(defconstant $digiOutDoesILUT #x800000)         ;  digitizer does inverse LUT for index modes 

(defconstant $digiOutDoesKeyColor #x1000000)    ;  digitizer does key color functions too 

(defconstant $digiOutDoesAsyncGrabs #x2000000)  ;  digitizer supports async grabs 

(defconstant $digiOutDoesUnreadableScreenBits #x4000000);  playthru doesn't generate readable bits on screen

(defconstant $digiOutDoesCompress #x8000000)    ;  supports alternate output data types 

(defconstant $digiOutDoesCompressOnly #x10000000);  can't provide raw frames anywhere 

(defconstant $digiOutDoesPlayThruDuringCompress #x20000000);  digi can do playthru while providing compressed data 

(defconstant $digiOutDoesCompressPartiallyVisible #x40000000);  digi doesn't need all bits visible on screen to do hardware compress 
;  digi doesn't need any bufferization when providing compressed data 

(defconstant $digiOutDoesNotNeedCopyOfCompressData #x80000000)
;  Types 

(def-mactype :VideoDigitizerComponent (find-mactype ':ComponentInstance))

(def-mactype :VideoDigitizerError (find-mactype ':signed-long))
(defrecord DigitizerInfo
   (vdigType :SInt16)
   (inputCapabilityFlags :signed-long)
   (outputCapabilityFlags :signed-long)
   (inputCurrentFlags :signed-long)
   (outputCurrentFlags :signed-long)
   (slot :SInt16)                               ;  temporary for connection purposes 
   (gdh (:Handle :GDEVICE))                     ;  temporary for digitizers that have preferred screen 
   (maskgdh (:Handle :GDEVICE))                 ;  temporary for digitizers that have mask planes 
   (minDestHeight :SInt16)                      ;  Smallest resizable height 
   (minDestWidth :SInt16)                       ;  Smallest resizable width 
   (maxDestHeight :SInt16)                      ;  Largest resizable height 
   (maxDestWidth :SInt16)                       ;  Largest resizable width 
   (blendLevels :SInt16)                        ;  Number of blend levels supported (2 if 1 bit mask) 
   (reserved :signed-long)                      ;  reserved 
)

;type name? (%define-record :DigitizerInfo (find-record-descriptor ':DigitizerInfo))
(defrecord VdigType
   (digType :signed-long)
   (reserved :signed-long)
)

;type name? (%define-record :VdigType (find-record-descriptor ':VdigType))
(defrecord (VdigTypeList :handle)
   (count :SInt16)
   (list (:array :VdigType 1))
)

;type name? (%define-record :VdigTypeList (find-record-descriptor ':VdigTypeList))
(defrecord VdigBufferRec
   (dest (:Handle :PixMap))
   (location :Point)
   (reserved :signed-long)
)

;type name? (%define-record :VdigBufferRec (find-record-descriptor ':VdigBufferRec))
(defrecord (VdigBufferRecList :handle)
   (count :SInt16)
   (matrix (:pointer :MatrixRecord))
   (mask (:pointer :OpaqueRgnHandle))
   (list (:array :VdigBufferRec 1))
)

;type name? (%define-record :VdigBufferRecList (find-record-descriptor ':VdigBufferRecList))

(def-mactype :VdigBufferRecListPtr (find-mactype '(:pointer :VdigBufferRecList)))

(def-mactype :VdigBufferRecListHandle (find-mactype '(:handle :VdigBufferRecList)))

(def-mactype :VdigIntProcPtr (find-mactype ':pointer)); (long flags , long refcon)

(def-mactype :VdigIntUPP (find-mactype '(:pointer :OpaqueVdigIntProcPtr)))
(defrecord (VDCompressionList :handle)
   (codec (:pointer :ComponentRecord))
   (cType :OSType)
   (typeName (:string 63))
   (name (:string 63))
   (formatFlags :signed-long)
   (compressFlags :signed-long)
   (reserved :signed-long)
)

;type name? (%define-record :VDCompressionList (find-record-descriptor ':VDCompressionList))

(def-mactype :VDCompressionListPtr (find-mactype '(:pointer :VDCompressionList)))

(def-mactype :VDCompressionListHandle (find-mactype '(:handle :VDCompressionList)))

(defconstant $dmaDepth1 1)
(defconstant $dmaDepth2 2)
(defconstant $dmaDepth4 4)
(defconstant $dmaDepth8 8)
(defconstant $dmaDepth16 16)
(defconstant $dmaDepth32 32)
(defconstant $dmaDepth2Gray 64)
(defconstant $dmaDepth4Gray #x80)
(defconstant $dmaDepth8Gray #x100)

(defconstant $kVDIGControlledFrameRate -1)
; 
;  *  VDGetMaxSrcRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetMaxSrcRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inputStd :SInt16)
    (maxSrcRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetActiveSrcRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetActiveSrcRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inputStd :SInt16)
    (activeSrcRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetDigitizerRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetDigitizerRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (digitizerRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetDigitizerRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetDigitizerRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (digitizerRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetVBlankRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetVBlankRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inputStd :SInt16)
    (vBlankRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetMaskPixMap()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetMaskPixMap" 
   ((ci (:pointer :ComponentInstanceRecord))
    (maskPixMap (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetPlayThruDestination()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetPlayThruDestination" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dest (:pointer :PIXMAPHANDLE))
    (destRect (:pointer :Rect))
    (m (:pointer :MatrixRecord))
    (mask (:pointer :RGNHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDUseThisCLUT()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDUseThisCLUT" 
   ((ci (:pointer :ComponentInstanceRecord))
    (colorTableHandle (:Handle :ColorTable))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetInputGammaValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetInputGammaValue" 
   ((ci (:pointer :ComponentInstanceRecord))
    (channel1 :signed-long)
    (channel2 :signed-long)
    (channel3 :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetInputGammaValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetInputGammaValue" 
   ((ci (:pointer :ComponentInstanceRecord))
    (channel1 (:pointer :Fixed))
    (channel2 (:pointer :Fixed))
    (channel3 (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetBrightness()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetBrightness" 
   ((ci (:pointer :ComponentInstanceRecord))
    (brightness (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetBrightness()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetBrightness" 
   ((ci (:pointer :ComponentInstanceRecord))
    (brightness (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetContrast()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetContrast" 
   ((ci (:pointer :ComponentInstanceRecord))
    (contrast (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetHue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetHue" 
   ((ci (:pointer :ComponentInstanceRecord))
    (hue (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetSharpness()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetSharpness" 
   ((ci (:pointer :ComponentInstanceRecord))
    (sharpness (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetSaturation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetSaturation" 
   ((ci (:pointer :ComponentInstanceRecord))
    (saturation (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetContrast()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetContrast" 
   ((ci (:pointer :ComponentInstanceRecord))
    (contrast (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetHue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetHue" 
   ((ci (:pointer :ComponentInstanceRecord))
    (hue (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetSharpness()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetSharpness" 
   ((ci (:pointer :ComponentInstanceRecord))
    (sharpness (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetSaturation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetSaturation" 
   ((ci (:pointer :ComponentInstanceRecord))
    (saturation (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGrabOneFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGrabOneFrame" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetMaxAuxBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetMaxAuxBuffer" 
   ((ci (:pointer :ComponentInstanceRecord))
    (pm (:pointer :PIXMAPHANDLE))
    (r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetDigitizerInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetDigitizerInfo" 
   ((ci (:pointer :ComponentInstanceRecord))
    (info (:pointer :DigitizerInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetCurrentFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetCurrentFlags" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inputCurrentFlag (:pointer :long))
    (outputCurrentFlag (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetKeyColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetKeyColor" 
   ((ci (:pointer :ComponentInstanceRecord))
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetKeyColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetKeyColor" 
   ((ci (:pointer :ComponentInstanceRecord))
    (index (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDAddKeyColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDAddKeyColor" 
   ((ci (:pointer :ComponentInstanceRecord))
    (index (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetNextKeyColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetNextKeyColor" 
   ((ci (:pointer :ComponentInstanceRecord))
    (index :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetKeyColorRange()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetKeyColorRange" 
   ((ci (:pointer :ComponentInstanceRecord))
    (minRGB (:pointer :RGBColor))
    (maxRGB (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetKeyColorRange()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetKeyColorRange" 
   ((ci (:pointer :ComponentInstanceRecord))
    (minRGB (:pointer :RGBColor))
    (maxRGB (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetDigitizerUserInterrupt()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetDigitizerUserInterrupt" 
   ((ci (:pointer :ComponentInstanceRecord))
    (flags :signed-long)
    (userInterruptProc (:pointer :OpaqueVdigIntProcPtr))
    (refcon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetInputColorSpaceMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetInputColorSpaceMode" 
   ((ci (:pointer :ComponentInstanceRecord))
    (colorSpaceMode :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetInputColorSpaceMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetInputColorSpaceMode" 
   ((ci (:pointer :ComponentInstanceRecord))
    (colorSpaceMode (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetClipState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetClipState" 
   ((ci (:pointer :ComponentInstanceRecord))
    (clipEnable :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetClipState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetClipState" 
   ((ci (:pointer :ComponentInstanceRecord))
    (clipEnable (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetClipRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetClipRgn" 
   ((ci (:pointer :ComponentInstanceRecord))
    (clipRegion (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDClearClipRgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDClearClipRgn" 
   ((ci (:pointer :ComponentInstanceRecord))
    (clipRegion (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetCLUTInUse()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetCLUTInUse" 
   ((ci (:pointer :ComponentInstanceRecord))
    (colorTableHandle (:pointer :CTABHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetPLLFilterType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetPLLFilterType" 
   ((ci (:pointer :ComponentInstanceRecord))
    (pllType :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetPLLFilterType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetPLLFilterType" 
   ((ci (:pointer :ComponentInstanceRecord))
    (pllType (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetMaskandValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetMaskandValue" 
   ((ci (:pointer :ComponentInstanceRecord))
    (blendLevel :UInt16)
    (mask (:pointer :long))
    (value (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetMasterBlendLevel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetMasterBlendLevel" 
   ((ci (:pointer :ComponentInstanceRecord))
    (blendLevel (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetPlayThruDestination()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetPlayThruDestination" 
   ((ci (:pointer :ComponentInstanceRecord))
    (dest (:Handle :PixMap))
    (destRect (:pointer :Rect))
    (m (:pointer :MatrixRecord))
    (mask (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetPlayThruOnOff()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetPlayThruOnOff" 
   ((ci (:pointer :ComponentInstanceRecord))
    (state :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetFieldPreference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetFieldPreference" 
   ((ci (:pointer :ComponentInstanceRecord))
    (fieldFlag :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetFieldPreference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetFieldPreference" 
   ((ci (:pointer :ComponentInstanceRecord))
    (fieldFlag (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDPreflightDestination()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDPreflightDestination" 
   ((ci (:pointer :ComponentInstanceRecord))
    (digitizerRect (:pointer :Rect))
    (dest (:pointer :PixMap))
    (destRect (:pointer :Rect))
    (m (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDPreflightGlobalRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDPreflightGlobalRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theWindow (:pointer :OpaqueGrafPtr))
    (globalRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetPlayThruGlobalRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetPlayThruGlobalRect" 
   ((ci (:pointer :ComponentInstanceRecord))
    (theWindow (:pointer :OpaqueGrafPtr))
    (globalRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetInputGammaRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetInputGammaRecord" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inputGammaPtr (:pointer :VDGammaRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetInputGammaRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetInputGammaRecord" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inputGammaPtr (:pointer :VDGAMRECPTR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetBlackLevelValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetBlackLevelValue" 
   ((ci (:pointer :ComponentInstanceRecord))
    (blackLevel (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetBlackLevelValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetBlackLevelValue" 
   ((ci (:pointer :ComponentInstanceRecord))
    (blackLevel (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetWhiteLevelValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetWhiteLevelValue" 
   ((ci (:pointer :ComponentInstanceRecord))
    (whiteLevel (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetWhiteLevelValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetWhiteLevelValue" 
   ((ci (:pointer :ComponentInstanceRecord))
    (whiteLevel (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetVideoDefaults()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetVideoDefaults" 
   ((ci (:pointer :ComponentInstanceRecord))
    (blackLevel (:pointer :UInt16))
    (whiteLevel (:pointer :UInt16))
    (brightness (:pointer :UInt16))
    (hue (:pointer :UInt16))
    (saturation (:pointer :UInt16))
    (contrast (:pointer :UInt16))
    (sharpness (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetNumberOfInputs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetNumberOfInputs" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inputs (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetInputFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetInputFormat" 
   ((ci (:pointer :ComponentInstanceRecord))
    (input :SInt16)
    (format (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetInput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetInput" 
   ((ci (:pointer :ComponentInstanceRecord))
    (input :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetInput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetInput" 
   ((ci (:pointer :ComponentInstanceRecord))
    (input (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetInputStandard()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetInputStandard" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inputStandard :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetupBuffers()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetupBuffers" 
   ((ci (:pointer :ComponentInstanceRecord))
    (bufferList (:Handle :VdigBufferRecList))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGrabOneFrameAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGrabOneFrameAsync" 
   ((ci (:pointer :ComponentInstanceRecord))
    (buffer :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDDone()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDDone" 
   ((ci (:pointer :ComponentInstanceRecord))
    (buffer :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetCompression()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetCompression" 
   ((ci (:pointer :ComponentInstanceRecord))
    (compressType :OSType)
    (depth :SInt16)
    (bounds (:pointer :Rect))
    (spatialQuality :UInt32)
    (temporalQuality :UInt32)
    (keyFrameRate :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDCompressOneFrameAsync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDCompressOneFrameAsync" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;     Note that UInt8* queuedFrameCount replaces Boolean* done. 0(==false) still means no frames, and 1(==true) one, 
;     but if more than one are available the number should be returned here. The value 2 previously meant more than one frame,
;     so some VDIGs may return 2 even if more than 2 are available, and some will still return 1 as they are using the original definition 
; 
;  *  VDCompressDone()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDCompressDone" 
   ((ci (:pointer :ComponentInstanceRecord))
    (queuedFrameCount (:pointer :UInt8))
    (theData (:pointer :Ptr))
    (dataSize (:pointer :long))
    (similarity (:pointer :UInt8))
    (t (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDReleaseCompressBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDReleaseCompressBuffer" 
   ((ci (:pointer :ComponentInstanceRecord))
    (bufferAddr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetImageDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetImageDescription" 
   ((ci (:pointer :ComponentInstanceRecord))
    (desc (:Handle :ImageDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDResetCompressSequence()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDResetCompressSequence" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetCompressionOnOff()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetCompressionOnOff" 
   ((ci (:pointer :ComponentInstanceRecord))
    (state :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetCompressionTypes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetCompressionTypes" 
   ((ci (:pointer :ComponentInstanceRecord))
    (h (:Handle :VDCompressionList))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetTimeBase" 
   ((ci (:pointer :ComponentInstanceRecord))
    (t (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetFrameRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetFrameRate" 
   ((ci (:pointer :ComponentInstanceRecord))
    (framesPerSecond :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetDataRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetDataRate" 
   ((ci (:pointer :ComponentInstanceRecord))
    (milliSecPerFrame (:pointer :long))
    (framesPerSecond (:pointer :Fixed))
    (bytesPerSecond (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetSoundInputDriver()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetSoundInputDriver" 
   ((ci (:pointer :ComponentInstanceRecord))
    (soundDriverName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetDMADepths()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetDMADepths" 
   ((ci (:pointer :ComponentInstanceRecord))
    (depthArray (:pointer :long))
    (preferredDepth (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetPreferredTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetPreferredTimeScale" 
   ((ci (:pointer :ComponentInstanceRecord))
    (preferred (:pointer :TIMESCALE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDReleaseAsyncBuffers()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDReleaseAsyncBuffers" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  83 is reserved for compatibility reasons 
; 
;  *  VDSetDataRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetDataRate" 
   ((ci (:pointer :ComponentInstanceRecord))
    (bytesPerSecond :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetTimeCode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetTimeCode" 
   ((ci (:pointer :ComponentInstanceRecord))
    (atTime (:pointer :TimeRecord))
    (timeCodeFormat :pointer)
    (timeCodeTime :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDUseSafeBuffers()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDUseSafeBuffers" 
   ((ci (:pointer :ComponentInstanceRecord))
    (useSafeBuffers :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetSoundInputSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetSoundInputSource" 
   ((ci (:pointer :ComponentInstanceRecord))
    (videoInput :signed-long)
    (soundInput (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetCompressionTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetCompressionTime" 
   ((ci (:pointer :ComponentInstanceRecord))
    (compressionType :OSType)
    (depth :SInt16)
    (srcRect (:pointer :Rect))
    (spatialQuality (:pointer :CODECQ))
    (temporalQuality (:pointer :CODECQ))
    (compressTime (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetPreferredPacketSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetPreferredPacketSize" 
   ((ci (:pointer :ComponentInstanceRecord))
    (preferredPacketSizeInBytes :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetPreferredImageDimensions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetPreferredImageDimensions" 
   ((ci (:pointer :ComponentInstanceRecord))
    (width :signed-long)
    (height :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetPreferredImageDimensions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetPreferredImageDimensions" 
   ((ci (:pointer :ComponentInstanceRecord))
    (width (:pointer :long))
    (height (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDGetInputName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDGetInputName" 
   ((ci (:pointer :ComponentInstanceRecord))
    (videoInput :signed-long)
    (name (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  VDSetDestinationPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_VDSetDestinationPort" 
   ((ci (:pointer :ComponentInstanceRecord))
    (destPort (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;    The following call is designed to give the VDIG a little more control over how it is presented to the User, to clarify the 
;    distinction between Devices and Inputs. Historically, the assumption has been that there is one component registered per device
;    and the component name is displayed. This change lets a component choose its name after registration.
;    vdDeviceFlagShowInputsAsDevices is meant for components that register once and support multiple devices 
;    The UI is clearer if these are presented as device rather than inputs, 
;    and this allows a VDIG to present itself this way without huge restructuring
;    vdDeviceFlagHideDevice is for the kind of VDIG that registers itself, and then can register a further VDIG for each device. 
;    If no hardware is available, returning this flag will omit it from the list. 
;    This call being made is also a good time to check for hardware and register further VDIG components if needed, 
;    allowing for lazy initialization when the Application needs to find a VDIG rather than on every launch or replug.
; 

(defconstant $vdDeviceFlagShowInputsAsDevices 1);  Tell the Panel to promote Inputs to Devices
;  Omit this Device entirely from the list

(defconstant $vdDeviceFlagHideDevice 2)
; 
;  *  VDGetDeviceNameAndFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_VDGetDeviceNameAndFlags" 
   ((ci (:pointer :ComponentInstanceRecord))
    (outName (:pointer :STR255))
    (outNameFlags (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )

(defconstant $vdFlagCaptureStarting 1)          ;  Capture is about to start; allocate bandwidth 

(defconstant $vdFlagCaptureStopping 2)          ;  Capture is about to stop; stop queuing frames

(defconstant $vdFlagCaptureIsForPreview 4)      ;  Capture is just to screen for preview purposes

(defconstant $vdFlagCaptureIsForRecord 8)       ;  Capture is going to be recorded

(defconstant $vdFlagCaptureLowLatency 16)       ;  Fresh frames are more important than delivering every frame - don't queue too much

(defconstant $vdFlagCaptureAlwaysUseTimeBase 32);  Use the timebase for every frame; don't worry about making durations uniform

(defconstant $vdFlagCaptureSetSettingsBegin 64) ;  A series of calls are about to be made to restore settings.
;  Finished restoring settings; any set calls after this are from the app or UI

(defconstant $vdFlagCaptureSetSettingsEnd #x80)
; 
;  *  VDCaptureStateChanging()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_VDCaptureStateChanging" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inStateFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;    These UniqueID calls are so that the VDIG can give the SG information enabling it to restore a particular
;    configuration - choose a particular device and input from those available.
;    For example, restoring the specific camera for a set of several hot-plugged FireWire cameras 
;    the caller can pass nil if it is not interested in one of the IDs
;    returning 0 in an ID means you don't have one
; 
; 
;  *  VDGetUniqueIDs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_VDGetUniqueIDs" 
   ((ci (:pointer :ComponentInstanceRecord))
    (outDeviceID (:pointer :UInt64))
    (outInputID (:pointer :UInt64))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;    Note this is a 'Select' not a 'Set' - the assumption is that the Unique ID is a function of the hardware
;    and not modifiable by the calling application. Either a nil pointer or 0 an the ID means don't care.
;    return vdDontHaveThatUniqueIDErr if your device doesn't have a match.
; 
; 
;  *  VDSelectUniqueIDs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_VDSelectUniqueIDs" 
   ((ci (:pointer :ComponentInstanceRecord))
    (inDeviceID (:pointer :UInt64))
    (inInputID (:pointer :UInt64))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  VDCopyPreferredAudioDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_VDCopyPreferredAudioDevice" 
   ((vdig (:pointer :ComponentInstanceRecord))
    (outAudioDeviceUID (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;    IIDC (Instrumentation & Industrial Digital Camera) Video Digitizers
;    Video Digitizers of subtype vdSubtypeIIDC support FireWire cameras which conform to the
;    "IIDC 1394-based Digital Camera Specification." 
; 

(defconstant $vdSubtypeIIDC :|iidc|)            ;  Subtype for IIDC 1394-Digital Camera video digitizer

; 
;    vdIIDCAtomTypeFeature
;    Parent node for the QTAtoms which describe a given feature.  
; 

(defconstant $vdIIDCAtomTypeFeature :|feat|)
; 
;    vdIIDCAtomTypeFeatureAtomTypeAndID
;    This atom describes the feature's OSType/group/name and QTAtomType & QTAtomID needed to retrieve its settings.
;    The contents of this atom is a VDIIDCFeatureAtomTypeAndID structure.  
; 

(defconstant $vdIIDCAtomTypeFeatureAtomTypeAndID :|t&id|)
(defconstant $vdIIDCAtomIDFeatureAtomTypeAndID 1)
(defrecord VDIIDCFeatureAtomTypeAndID
   (feature :OSType)                            ;  OSType of feature
   (group :OSType)                              ;  OSType of group that feature is categorized into
   (name (:string 255))                         ;  Name of this feature
   (atomType :signed-long)                      ;  Atom type which contains feature's settings
   (atomID :signed-long)                        ;  Atom ID which contains feature's settings
)

;type name? (%define-record :VDIIDCFeatureAtomTypeAndID (find-record-descriptor ':VDIIDCFeatureAtomTypeAndID))
;  IIDC Feature OSTypes

(defconstant $vdIIDCFeatureHue :|hue |)         ;  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureSaturation :|satu|)  ;  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureSharpness :|shrp|)   ;  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureBrightness :|brit|)  ;  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureGain :|gain|)        ;  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureIris :|iris|)        ;  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureShutter :|shtr|)     ;  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureExposure :|xpsr|)    ;  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureWhiteBalanceU :|whbu|);  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureWhiteBalanceV :|whbv|);  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureGamma :|gmma|)       ;  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureTemperature :|temp|) ;  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureZoom :|zoom|)        ;  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureFocus :|fcus|)       ;  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeaturePan :|pan |)         ;  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureTilt :|tilt|)        ;  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureOpticalFilter :|opft|);  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureTrigger :|trgr|)     ;  Trigger's setttings handled by VDIIDCTriggerSettings

(defconstant $vdIIDCFeatureCaptureSize :|cpsz|) ;  Feature's settings is not defined

(defconstant $vdIIDCFeatureCaptureQuality :|cpql|);  Feature's settings is not defined

(defconstant $vdIIDCFeatureFocusPoint :|fpnt|)  ;  Focus Point's settings handled by VDIIDCFocusPointSettings

(defconstant $vdIIDCFeatureEdgeEnhancement :|eden|);  Feature's settings handled by VDIIDCFeatureSettings

(defconstant $vdIIDCFeatureLightingHint :|lhnt|);  Feature's settings handled by VDIIDCLightingHintSettings

; 
;    IIDC Group OSTypes that features are categorized into
;    (The values used for the constants cannot be the same as any of the IIDC Feature OSTypes constants)
; 

(defconstant $vdIIDCGroupImage :|imag|)         ;  Feature related to camera's image

(defconstant $vdIIDCGroupColor :|colr|)         ;  Feature related to camera's color control

(defconstant $vdIIDCGroupMechanics :|mech|)     ;  Feature related to camera's mechanics

(defconstant $vdIIDCGroupTrigger :|trig|)       ;  Feature related to camera's trigger

; 
;    vdIIDCAtomTypeFeatureSettings
;    This atom describes the settings for the majority of features.
;    The contents of this atom is a VDIIDCFeatureSettings structure.
; 

(defconstant $vdIIDCAtomTypeFeatureSettings :|fstg|)
(defconstant $vdIIDCAtomIDFeatureSettings 1)
(defrecord VDIIDCFeatureCapabilities
   (flags :UInt32)
   (rawMinimum :UInt16)
   (rawMaximum :UInt16)
   (absoluteMinimum :single-float)
   (absoluteMaximum :single-float)
)

;type name? (%define-record :VDIIDCFeatureCapabilities (find-record-descriptor ':VDIIDCFeatureCapabilities))
(defrecord VDIIDCFeatureState
   (flags :UInt32)
   (value :single-float)
)

;type name? (%define-record :VDIIDCFeatureState (find-record-descriptor ':VDIIDCFeatureState))
(defrecord VDIIDCFeatureSettings
   (capabilities :VDIIDCFeatureCapabilities)
   (state :VDIIDCFeatureState)
)

;type name? (%define-record :VDIIDCFeatureSettings (find-record-descriptor ':VDIIDCFeatureSettings))
; 
;    Flags for use in VDIIDCFeatureCapabilities.flags & VDIIDCFeatureState.flags
;    When indicating capabilities, the flag being set indicates that the feature can be put into the given state.
;    When indicating/setting state, the flag represents the current/desired state.
;    Note that certain combinations of flags are valid for cababilities (i.e. vdIIDCFeatureFlagOn | vdIIDCFeatureFlagOff)
;    but are mutally exclusive for state.
; 

(defconstant $vdIIDCFeatureFlagOn 1)
(defconstant $vdIIDCFeatureFlagOff 2)
(defconstant $vdIIDCFeatureFlagManual 4)
(defconstant $vdIIDCFeatureFlagAuto 8)
(defconstant $vdIIDCFeatureFlagTune 16)
(defconstant $vdIIDCFeatureFlagRawControl 32)
(defconstant $vdIIDCFeatureFlagAbsoluteControl 64)
; 
;    vdIIDCAtomTypeTriggerSettings
;    This atom describes the settings for the trigger feature.
;    The contents of this atom is a VDIIDCTriggerSettings structure.
; 

(defconstant $vdIIDCAtomTypeTriggerSettings :|tstg|)
(defconstant $vdIIDCAtomIDTriggerSettings 1)
(defrecord VDIIDCTriggerCapabilities
   (flags :UInt32)
   (absoluteMinimum :single-float)
   (absoluteMaximum :single-float)
)

;type name? (%define-record :VDIIDCTriggerCapabilities (find-record-descriptor ':VDIIDCTriggerCapabilities))
(defrecord VDIIDCTriggerState
   (flags :UInt32)
   (mode2TransitionCount :UInt16)
   (mode3FrameRateMultiplier :UInt16)
   (absoluteValue :single-float)
)

;type name? (%define-record :VDIIDCTriggerState (find-record-descriptor ':VDIIDCTriggerState))
(defrecord VDIIDCTriggerSettings
   (capabilities :VDIIDCTriggerCapabilities)
   (state :VDIIDCTriggerState)
)

;type name? (%define-record :VDIIDCTriggerSettings (find-record-descriptor ':VDIIDCTriggerSettings))
; 
;    Flags for use in VDIIDCTriggerCapabilities.flags & VDIIDCTriggerState.flags
;    When indicating capabilities, the flag being set indicates that the trigger can be put into the given state.
;    When indicating/setting state, the flag represents the current/desired state.
;    Note that certain combinations of flags are valid for cababilities (i.e. vdIIDCTriggerFlagOn | vdIIDCTriggerFlagOff)
;    but are mutally exclusive for state.
; 

(defconstant $vdIIDCTriggerFlagOn 1)
(defconstant $vdIIDCTriggerFlagOff 2)
(defconstant $vdIIDCTriggerFlagActiveHigh 4)
(defconstant $vdIIDCTriggerFlagActiveLow 8)
(defconstant $vdIIDCTriggerFlagMode0 16)
(defconstant $vdIIDCTriggerFlagMode1 32)
(defconstant $vdIIDCTriggerFlagMode2 64)
(defconstant $vdIIDCTriggerFlagMode3 #x80)
(defconstant $vdIIDCTriggerFlagRawControl #x100)
(defconstant $vdIIDCTriggerFlagAbsoluteControl #x200)
; 
;    vdIIDCAtomTypeFocusPointSettings
;    This atom describes the settings for the focus point feature.
;    The contents of this atom is a VDIIDCFocusPointSettings structure.
; 

(defconstant $vdIIDCAtomTypeFocusPointSettings :|fpst|)
(defconstant $vdIIDCAtomIDFocusPointSettings 1)
(defrecord VDIIDCFocusPointSettings
   (focusPoint :Point)
)

;type name? (%define-record :VDIIDCFocusPointSettings (find-record-descriptor ':VDIIDCFocusPointSettings))
; 
;    vdIIDCAtomTypeLightingHintSettings
;    This atom describes the settings for the light hint feature.
;    The contents of this atom is a VDIIDCLightingHintSettings structure.
; 

(defconstant $vdIIDCAtomTypeLightingHintSettings :|lhst|)
(defconstant $vdIIDCAtomIDLightingHintSettings 1)
(defrecord VDIIDCLightingHintSettings
   (capabilityFlags :UInt32)
   (stateFlags :UInt32)
)

;type name? (%define-record :VDIIDCLightingHintSettings (find-record-descriptor ':VDIIDCLightingHintSettings))
; 
;    Flags for use in VDIIDCLightingHintSettings.capabilityFlags & VDIIDCLightingHintSettings.capabilityFlags
;    When indicating capabilities, the flag being set indicates that the hint can be applied.
;    When indicating/setting state, the flag represents the current/desired hints applied/to apply.
;    Certain combinations of flags are valid for cababilities (i.e. vdIIDCLightingHintNormal | vdIIDCLightingHintLow)
;    but are mutally exclusive for state.
; 

(defconstant $vdIIDCLightingHintNormal 1)
(defconstant $vdIIDCLightingHintLow 2)
; 
;    VDIIDC calls are additional calls for IIDC digitizers (vdSubtypeIIDC)
;    These calls are only valid for video digitizers of subtype vdSubtypeIIDC.
; 
; 
;  *  VDIIDCGetFeatures()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_VDIIDCGetFeatures" 
   ((ci (:pointer :ComponentInstanceRecord))
    (container (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  VDIIDCSetFeatures()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_VDIIDCSetFeatures" 
   ((ci (:pointer :ComponentInstanceRecord))
    (container :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  VDIIDCGetDefaultFeatures()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_VDIIDCGetDefaultFeatures" 
   ((ci (:pointer :ComponentInstanceRecord))
    (container (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  VDIIDCGetCSRData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_VDIIDCGetCSRData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offsetFromUnitBase :Boolean)
    (offset :UInt32)
    (data (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  VDIIDCSetCSRData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_VDIIDCSetCSRData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (offsetFromUnitBase :Boolean)
    (offset :UInt32)
    (data :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
; 
;  *  VDIIDCGetFeaturesForSpecifier()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_VDIIDCGetFeaturesForSpecifier" 
   ((ci (:pointer :ComponentInstanceRecord))
    (specifier :OSType)
    (container (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )

(defconstant $xmlParseComponentType :|pars|)
(defconstant $xmlParseComponentSubType :|xml |)

(defconstant $xmlIdentifierInvalid 0)
(defconstant $xmlIdentifierUnrecognized #xFFFFFFFF)
(defconstant $xmlContentTypeInvalid 0)
(defconstant $xmlContentTypeElement 1)
(defconstant $xmlContentTypeCharData 2)

(defconstant $elementFlagAlwaysSelfContained 1) ;     Element doesn't have contents or closing tag even if it doesn't end with />, as in the HTML <img> tag

(defconstant $elementFlagPreserveWhiteSpace 2)  ;   Preserve whitespace in content, default is to remove it 

(defconstant $xmlParseFlagAllowUppercase 1)     ;     Entities and attributes do not have to be lowercase (strict XML), but can be upper or mixed case as in HTML

(defconstant $xmlParseFlagAllowUnquotedAttributeValues 2);     Attributes values do not have to be enclosed in quotes (strict XML), but can be left unquoted if they contain no spaces

(defconstant $xmlParseFlagEventParseOnly 4)     ;     Do event parsing only
;     Preserve whitespace throughout the document

(defconstant $xmlParseFlagPreserveWhiteSpace 8)

(defconstant $attributeValueKindCharString 0)
(defconstant $attributeValueKindInteger 1)      ;     Number

(defconstant $attributeValueKindPercent 2)      ;     Number or percent

(defconstant $attributeValueKindBoolean 4)      ;     "true" or "false"

(defconstant $attributeValueKindOnOff 8)        ;     "on" or "off"

(defconstant $attributeValueKindColor 16)       ;     Either "#rrggbb" or a color name

(defconstant $attributeValueKindEnum 32)        ;     one of a number of strings; the enum strings are passed as a zero-separated, double-zero-terminated C string in the attributeKindValueInfo param

(defconstant $attributeValueKindCaseSensEnum 64);     one of a number of strings; the enum strings are passed as for attributeValueKindEnum, but the values are case-sensitive

(defconstant $MAX_ATTRIBUTE_VALUE_KIND 64)

(defconstant $nameSpaceIDNone 0)
;   A Parsed XML attribute value, one of number/percent, boolean/on-off, color, or enumerated type
(defrecord XMLAttributeValue
   (:variant
   (
   (number :SInt32)
   )
                                                ;     The value when valueKind is attributeValueKindInteger or attributeValueKindPercent
   (
   (boolean :Boolean)
   )
                                                ;     The value when valueKind is attributeValueKindBoolean or attributeValueKindOnOff
   (
   (color :RGBColor)
   )
                                                ;     The value when valueKind is attributeValueKindColor
   (
   (enumType :UInt32)
   )
                                                ;     The value when valueKind is attributeValueKindEnum
   )
)

;type name? (%define-record :XMLAttributeValue (find-record-descriptor ':XMLAttributeValue))
;   An XML attribute-value pair
(defrecord XMLAttribute
   (identifier :UInt32)                         ;     Tokenized identifier, if the attribute name was recognized by the parser
   (name (:pointer :char))                      ;     Attribute name, Only present if identifier == xmlIdentifierUnrecognized
   (valueKind :signed-long)                     ;     Type of parsed value, if the value was recognized and parsed; otherwise, attributeValueKindCharString
   (value :XMLAttributeValue)                   ;     Parsed attribute value
   (valueStr (:pointer :char))                  ;     Always present
)

;type name? (%define-record :XMLAttribute (find-record-descriptor ':XMLAttribute))

(def-mactype :XMLAttributePtr (find-mactype '(:pointer :XMLAttribute)))
;   Forward struct declarations for recursively-defined tree structure

;type name? (def-mactype :XMLContent (find-mactype ':XMLContent))

(def-mactype :XMLContentPtr (find-mactype '(:pointer :XMLContent)))
; 
;     An XML Element, i.e.
;         <element attr="value" attr="value" ...> [contents] </element>
;     or
;         <element attr="value" attr="value" .../>
; 
(defrecord XMLElement
   (identifier :UInt32)                         ;     Tokenized identifier, if the element name was recognized by the parser
   (name (:pointer :char))                      ;     Element name, only present if identifier == xmlIdentifierUnrecognized
   (attributes (:pointer :XMLAttribute))        ;     Array of attributes, terminated with an attribute with identifier == xmlIdentifierInvalid
   (contents (:pointer :XMLContent))            ;     Array of contents, terminated with a content with kind == xmlIdentifierInvalid
)

;type name? (%define-record :XMLElement (find-record-descriptor ':XMLElement))

(def-mactype :XMLElementPtr (find-mactype '(:pointer :XMLElement)))
; 
;     The content of an XML element is a series of parts, each of which may be either another element
;     or simply character data.
; 
(defrecord XMLElementContent
   (:variant
   (
   (element :XMLElement)
   )
                                                ;     The contents when the content kind is xmlContentTypeElement
   (
   (charData (:pointer :char))
   )
                                                ;     The contents when the content kind is xmlContentTypeCharData
   )
)

;type name? (%define-record :XMLElementContent (find-record-descriptor ':XMLElementContent))
(defrecord XMLContent
   (kind :UInt32)
   (actualContent :XMLElementContent)
)
(defrecord XMLDocRecord
   (xmlDataStorage :pointer)                    ;     opaque storage
   (rootElement :XMLElement)
)

;type name? (%define-record :XMLDocRecord (find-record-descriptor ':XMLDocRecord))

(def-mactype :XMLDoc (find-mactype '(:pointer :XMLDocRecord)))
; callback routines for event parsing

(def-mactype :StartDocumentHandler (find-mactype ':pointer)); (long refcon)

(def-mactype :EndDocumentHandler (find-mactype ':pointer)); (long refcon)

(def-mactype :StartElementHandler (find-mactype ':pointer)); (const char * name , const char ** atts , long refcon)

(def-mactype :EndElementHandler (find-mactype ':pointer)); (const char * name , long refcon)

(def-mactype :CharDataHandler (find-mactype ':pointer)); (const char * charData , long refcon)

(def-mactype :PreprocessInstructionHandler (find-mactype ':pointer)); (const char * name , const char * const atts [ ] , long refcon)

(def-mactype :CommentHandler (find-mactype ':pointer)); (const char * comment , long refcon)

(def-mactype :CDataHandler (find-mactype ':pointer)); (const char * cdata , long refcon)

(def-mactype :StartDocumentHandlerUPP (find-mactype '(:pointer :OpaqueStartDocumentHandler)))

(def-mactype :EndDocumentHandlerUPP (find-mactype '(:pointer :OpaqueEndDocumentHandler)))

(def-mactype :StartElementHandlerUPP (find-mactype '(:pointer :OpaqueStartElementHandler)))

(def-mactype :EndElementHandlerUPP (find-mactype '(:pointer :OpaqueEndElementHandler)))

(def-mactype :CharDataHandlerUPP (find-mactype '(:pointer :OpaqueCharDataHandler)))

(def-mactype :PreprocessInstructionHandlerUPP (find-mactype '(:pointer :OpaquePreprocessInstructionHandler)))

(def-mactype :CommentHandlerUPP (find-mactype '(:pointer :OpaqueCommentHandler)))

(def-mactype :CDataHandlerUPP (find-mactype '(:pointer :OpaqueCDataHandler)))
;   Parses the XML file pointed to by dataRef, returning a XMLDoc parse tree
; 
;  *  XMLParseDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseDataRef" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataRefType :OSType)
    (parseFlags :signed-long)
    (document (:pointer :XMLDOC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;   Parses the XML file pointed to by fileSpec, returning a XMLDoc parse tree
; 
;  *  XMLParseFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseFile" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (fileSpec (:pointer :FSSpec))
    (parseFlags :signed-long)
    (document (:pointer :XMLDOC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;   Disposes of a XMLDoc parse tree
; 
;  *  XMLParseDisposeXMLDoc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseDisposeXMLDoc" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (document (:pointer :XMLDocRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     Returns a more detailed description of the error and the line in which it occurred, if a
;     file failed to parse properly.
; 
; 
;  *  XMLParseGetDetailedParseError()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseGetDetailedParseError" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (errorLine (:pointer :long))
    (errDesc (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     Tell the parser of an element to be recognized. The tokenized element unique identifier is
;     passed in *elementID, unless *elementID is zero, whereupon a unique ID is generated and returned.
;     Thus, a valid element identifier can never be zero.
; 
; 
;  *  XMLParseAddElement()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseAddElement" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (elementName (:pointer :char))
    (nameSpaceID :UInt32)
    (elementID (:pointer :UInt32))
    (elementFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     Tells the parser of an attribute for the specified element. The tokenized attribute unique
;     ID is passed in *attributeID, unless *attributeID is zero, whereupon a unique ID is generated and
;     returned. Thus, a valid attribute identifier can never be zero.
; 
; 
;  *  XMLParseAddAttribute()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseAddAttribute" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (elementID :UInt32)
    (nameSpaceID :UInt32)
    (attributeName (:pointer :char))
    (attributeID (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     Tells the parser of several attributes for the specified element. The attributes are passed
;     as a zero-delimited, double-zero-terminated C string in attributeNames, and the attribute
;     IDs are passed in on attributeIDs as an array; if any attributeIDs are zero, unique IDs
;     are generated for those and returned
; 
; 
;  *  XMLParseAddMultipleAttributes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseAddMultipleAttributes" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (elementID :UInt32)
    (nameSpaceIDs (:pointer :UInt32))
    (attributeNames (:pointer :char))
    (attributeIDs (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     Tells the parser of an attribute, which may have a particular type of value, for the
;     specified element. Params are as in XMLParseAddAttribute, plus all the kinds of values
;     the attribute may have are passed in attributeValueKind, and optional additional information
;     required to tokenize the particular kind of attribute is passed in attributeValueKindInfo
; 
; 
;  *  XMLParseAddAttributeAndValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseAddAttributeAndValue" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (elementID :UInt32)
    (nameSpaceID :UInt32)
    (attributeName (:pointer :char))
    (attributeID (:pointer :UInt32))
    (attributeValueKind :UInt32)
    (attributeValueKindInfo :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     Tells the parser of several attributes, which may have a particular type of value, for the
;     specified element. Params are as in XMLParseAddMultipleAttributes, plus all the kinds of values
;     the attributes may have are passed in attributeValueKinds, and optional additional information
;     required to tokenize the particular kind of attributes is passed in attributeValueKindInfos
; 
; 
;  *  XMLParseAddMultipleAttributesAndValues()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseAddMultipleAttributesAndValues" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (elementID :UInt32)
    (nameSpaceIDs (:pointer :UInt32))
    (attributeNames (:pointer :char))
    (attributeIDs (:pointer :UInt32))
    (attributeValueKinds (:pointer :UInt32))
    (attributeValueKindInfos :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     Tells the parser that the particular attribute may have an additional kind of
;     value, as specified by attributeValueKind and attributeValueKindInfo
; 
; 
;  *  XMLParseAddAttributeValueKind()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseAddAttributeValueKind" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (elementID :UInt32)
    (attributeID :UInt32)
    (attributeValueKind :UInt32)
    (attributeValueKindInfo :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     Tell the parser of a namespace to be recognized. The tokenized namespace unique identifier is
;     passed in *nameSpaceID, unless *nameSpaceID is zero, whereupon a unique ID is generated and returned.
;     Thus, a valid nameSpaceID identifier can never be zero.
; 
; 
;  *  XMLParseAddNameSpace()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseAddNameSpace" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (nameSpaceURL (:pointer :char))
    (nameSpaceID (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;   Specifies the offset and limit for reading from the dataref to be used when parsing
; 
;  *  XMLParseSetOffsetAndLimit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseSetOffsetAndLimit" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (offset :UInt32)
    (limit :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;   Set the event parse refcon
; 
;  *  XMLParseSetEventParseRefCon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseSetEventParseRefCon" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (refcon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;   Set the start document handler UPP for event parsing
; 
;  *  XMLParseSetStartDocumentHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseSetStartDocumentHandler" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (startDocument (:pointer :OpaqueStartDocumentHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;   Set the end document handler UPP for event parsing
; 
;  *  XMLParseSetEndDocumentHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseSetEndDocumentHandler" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (endDocument (:pointer :OpaqueEndDocumentHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;   Set the start element handler UPP for event parsing
; 
;  *  XMLParseSetStartElementHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseSetStartElementHandler" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (startElement (:pointer :OpaqueStartElementHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;   Set the end element handler UPP for event parsing
; 
;  *  XMLParseSetEndElementHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseSetEndElementHandler" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (endElement (:pointer :OpaqueEndElementHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;   Set the character data handler UPP for event parsing
; 
;  *  XMLParseSetCharDataHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseSetCharDataHandler" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (charData (:pointer :OpaqueCharDataHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;   Set the preprocess instruction handler UPP for event parsing
; 
;  *  XMLParseSetPreprocessInstructionHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseSetPreprocessInstructionHandler" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (preprocessInstruction (:pointer :OpaquePreprocessInstructionHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;   Set the comment handler UPP for event parsing
; 
;  *  XMLParseSetCommentHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_XMLParseSetCommentHandler" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (comment (:pointer :OpaqueCommentHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;   Set the cdata handler UPP for event parsing
; 
;  *  XMLParseSetCDataHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_XMLParseSetCDataHandler" 
   ((aParser (:pointer :ComponentInstanceRecord))
    (cdata (:pointer :OpaqueCDataHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;     Helper Macros
;     
;         These macros allow you to easily add entities and attributes to the parser
;         in an error free manner when the identifiers are defined in a particular manner.
;         For these to work, you must define the identifiers as follows:
;         
;         For entities, they must be defined as element_elementName, as in:
;         
;             enum
;             {
;                 element_xml =   1,      //  "xml"
;                 element_head,           //  "head"
;                 element_body            //  "body"
;             };
;             
;         If the element name has characters that are illegal in an identifier,
;         some of the macros support that, but the identifier must not contain
;         the illegal characters:
;         
;             enum
;             {
;                 element_rootlayout      //  "root-layout"
;             }
;             
;         For attribute names, similar rules apply except that they must be defined
;         as attr_attributeName, as in:
;             
;             enum
;             {
;                 attr_src    =   1,      //  "src"
;                 attr_href,
;                 attr_width,
;                 attr_height
;             }
;             
;         Finally, the existence of local variables elementID and attributeID is required.
; 
; 
;     Adds the specified element to the parser, i.e. XML_ADD_ELEMENT(head) adds the element "head" with
;     a unique identifier of element_head
; 
; #define XML_ADD_ELEMENT_NS(elementName,nameSpaceID)        elementID   =   GLUE2(element_,elementName);    XMLParseAddElement(xmlParser, #elementName, nameSpaceID, &elementID, 0)
; #define XML_ADD_ELEMENT(elementName)                    XML_ADD_ELEMENT_NS(elementName,nameSpaceIDNone)
; 
;     Adds the specified element to the parser, not using the same string to generate the identifier and
;     the element name. Use for element names that contain characters which are illegal in identifiers,
;     i.e XML_ADD_COMPLEX_ELEMENT("root-layout",rootlayout) adds the element "root-layout" with a unique
;     identifier of element_rootlayout
; 
; #define XML_ADD_COMPLEX_ELEMENT_NS(elementName,elemID,nameSpaceID)     elementID   =   GLUE2(element_,elemID);     XMLParseAddElement(xmlParser, #elementName, nameSpaceID, &elementID, 0)
; #define XML_ADD_COMPLEX_ELEMENT(elementName,elemID)                     XML_ADD_COMPLEX_ELEMENT_NS(elementName,elemID,nameSpaceIDNone)
; 
;     Adds the specified attribute to the current element in the parser, i.e. XML_ADD_ATTRIBUTE(src)
;     adds the attribute "src" to the current element, and identifies it by attr_src
; 
; #define XML_ADD_ATTRIBUTE_NS(attrName,nameSpaceID)     attributeID =   GLUE2(attr_,attrName);      XMLParseAddAttribute(xmlParser, elementID, nameSpaceID, #attrName, &attributeID);
; #define XML_ADD_ATTRIBUTE(attrName)                       XML_ADD_ATTRIBUTE_NS(attrName,nameSpaceIDNone)
; 
;     Adds the specified attribute to the current element in the parser, i.e. XML_ADD_ATTRIBUTE(element_img, src)
;     adds the attribute "src" to the element_img element, and identifies it by attr_src
;     Adds the specified attribute to the current element in the parser, not using the same string to
;     generate the identifier and the element name. Use for attribute names that contain characters which
;     are illegal in identifiers, i.e XML_ADD_COMPLEX_ATTRIBUTE("http-equiv",httpequiv) adds the element
;     "http-equiv" with a unique identifier of attr_httpequiv
; 
; #define XML_ADD_COMPLEX_ATTRIBUTE_NS(attrName,attrID,nameSpaceID)  attributeID =   GLUE2(attr_,attrID);        XMLParseAddAttribute(xmlParser, elementID, nameSpaceID, #attrName, &attributeID);
; #define XML_ADD_COMPLEX_ATTRIBUTE(attrName,attrID)                    XML_ADD_COMPLEX_ATTRIBUTE_NS(attrName,attrID,nameSpaceIDNone)
; #define XML_ADD_ATTRIBUTE_AND_VALUE_NS(attrName,valueKind,valueKindInfo,nameSpaceID)   attributeID =   GLUE2(attr_,attrName);      XMLParseAddAttributeAndValue(xmlParser, elementID, nameSpaceID, #attrName, &attributeID, valueKind, valueKindInfo);
; #define XML_ADD_ATTRIBUTE_AND_VALUE(attrName,valueKind,valueKindInfo)                   XML_ADD_ATTRIBUTE_AND_VALUE_NS(attrName,valueKind,valueKindInfo,nameSpaceIDNone)
; #define XML_ADD_COMPLEX_ATTRIBUTE_AND_VALUE_NS(attrName,attrID,valueKind,valueKindInfo,nameSpaceID)        attributeID =   GLUE2(attr_,attrID);        XMLParseAddAttributeAndValue(xmlParser, elementID, nameSpaceID, #attrName, &attributeID, valueKind, valueKindInfo);
; #define XML_ADD_COMPLEX_ATTRIBUTE_AND_VALUE(attrName,attrID,valueKind,valueKindInfo)                    XML_ADD_COMPLEX_ATTRIBUTE_AND_VALUE_NS(attrName,attrID,valueKind,valueKindInfo,nameSpaceIDNone)
; 
;     General Sequence Grab stuff
; 

(def-mactype :SeqGrabComponent (find-mactype ':ComponentInstance))

(def-mactype :SGChannel (find-mactype ':ComponentInstance))

(defconstant $SeqGrabComponentType :|barg|)
(defconstant $SeqGrabChannelType :|sgch|)
(defconstant $SeqGrabPanelType :|sgpn|)
(defconstant $SeqGrabCompressionPanelType :|cmpr|)
(defconstant $SeqGrabSourcePanelType :|sour|)

(defconstant $seqGrabToDisk 1)
(defconstant $seqGrabToMemory 2)
(defconstant $seqGrabDontUseTempMemory 4)
(defconstant $seqGrabAppendToFile 8)
(defconstant $seqGrabDontAddMovieResource 16)
(defconstant $seqGrabDontMakeMovie 32)
(defconstant $seqGrabPreExtendFile 64)
(defconstant $seqGrabDataProcIsInterruptSafe #x80)
(defconstant $seqGrabDataProcDoesOverlappingReads #x100)

(def-mactype :SeqGrabDataOutputEnum (find-mactype ':UInt32))

(defconstant $seqGrabRecord 1)
(defconstant $seqGrabPreview 2)
(defconstant $seqGrabPlayDuringRecord 4)
(defconstant $seqGrabLowLatencyCapture 8)       ;  return the freshest frame possible, for live work (videoconferencing, live broadcast, live image processing) 

(defconstant $seqGrabAlwaysUseTimeBase 16)      ;  Tell VDIGs to use TimebaseTime always, rather than creating uniform frame durations, for more accurate live sync with audio 


(def-mactype :SeqGrabUsageEnum (find-mactype ':UInt32))

(defconstant $seqGrabHasBounds 1)
(defconstant $seqGrabHasVolume 2)
(defconstant $seqGrabHasDiscreteSamples 4)
(defconstant $seqGrabDoNotBufferizeData 8)
(defconstant $seqGrabCanMoveWindowWhileRecording 16)

(def-mactype :SeqGrabChannelInfoEnum (find-mactype ':UInt32))
(defrecord SGOutputRecord
   (data (:array :signed-long 1))
)

;type name? (%define-record :SGOutputRecord (find-record-descriptor ':SGOutputRecord))

(def-mactype :SGOutput (find-mactype '(:pointer :SGOutputRecord)))
(defrecord SeqGrabFrameInfo
   (frameOffset :signed-long)
   (frameTime :signed-long)
   (frameSize :signed-long)
   (frameChannel (:pointer :ComponentInstanceRecord))
   (frameRefCon :signed-long)
)

;type name? (%define-record :SeqGrabFrameInfo (find-record-descriptor ':SeqGrabFrameInfo))

(def-mactype :SeqGrabFrameInfoPtr (find-mactype '(:pointer :SeqGrabFrameInfo)))
(defrecord SeqGrabExtendedFrameInfo
   (frameOffset :wide)
   (frameTime :signed-long)
   (frameSize :signed-long)
   (frameChannel (:pointer :ComponentInstanceRecord))
   (frameRefCon :signed-long)
   (frameOutput (:pointer :SGOutputRecord))
)

;type name? (%define-record :SeqGrabExtendedFrameInfo (find-record-descriptor ':SeqGrabExtendedFrameInfo))

(def-mactype :SeqGrabExtendedFrameInfoPtr (find-mactype '(:pointer :SeqGrabExtendedFrameInfo)))

(defconstant $grabPictOffScreen 1)
(defconstant $grabPictIgnoreClip 2)
(defconstant $grabPictCurrentImage 4)

(defconstant $sgFlagControlledGrab 1)
(defconstant $sgFlagAllowNonRGBPixMaps 2)

(def-mactype :SGDataProcPtr (find-mactype ':pointer)); (SGChannel c , Ptr p , long len , long * offset , long chRefCon , TimeValue time , short writeType , long refCon)

(def-mactype :SGDataUPP (find-mactype '(:pointer :OpaqueSGDataProcPtr)))
(defrecord SGDeviceInputName
   (name (:string 63))
   (icon :Handle)
   (flags :signed-long)
   (reserved :signed-long)                      ;  zero
)

;type name? (%define-record :SGDeviceInputName (find-record-descriptor ':SGDeviceInputName))

(defconstant $sgDeviceInputNameFlagInputUnavailable 1)
(defrecord SGDeviceInputListRecord
   (count :SInt16)
   (selectedIndex :SInt16)
   (reserved :signed-long)                      ;  zero
   (entry (:array :SGDeviceInputName 1))
)

;type name? (%define-record :SGDeviceInputListRecord (find-record-descriptor ':SGDeviceInputListRecord))

(def-mactype :SGDeviceInputListPtr (find-mactype '(:pointer :SGDeviceInputListRecord)))

(def-mactype :SGDeviceInputList (find-mactype '(:handle :SGDeviceInputListRecord)))
(defrecord SGDeviceName
   (name (:string 63))
   (icon :Handle)
   (flags :signed-long)
   (refCon :signed-long)
   (inputs (:Handle :SGDeviceInputListRecord))  ;  list of inputs; formerly reserved to 0
)

;type name? (%define-record :SGDeviceName (find-record-descriptor ':SGDeviceName))

(defconstant $sgDeviceNameFlagDeviceUnavailable 1)
(defconstant $sgDeviceNameFlagShowInputsAsDevices 2)
(defrecord (SGDeviceListRecord :handle)
   (count :SInt16)
   (selectedIndex :SInt16)
   (reserved :signed-long)                      ;  zero
   (entry (:array :SGDeviceName 1))
)

;type name? (%define-record :SGDeviceListRecord (find-record-descriptor ':SGDeviceListRecord))

(def-mactype :SGDeviceListPtr (find-mactype '(:pointer :SGDeviceListRecord)))

(def-mactype :SGDeviceList (find-mactype '(:handle :SGDeviceListRecord)))

(defconstant $sgDeviceListWithIcons 1)
(defconstant $sgDeviceListDontCheckAvailability 2)
(defconstant $sgDeviceListIncludeInputs 4)

(defconstant $seqGrabWriteAppend 0)
(defconstant $seqGrabWriteReserve 1)
(defconstant $seqGrabWriteFill 2)

(defconstant $seqGrabUnpause 0)
(defconstant $seqGrabPause 1)
(defconstant $seqGrabPauseForMenu 3)

(defconstant $channelFlagDontOpenResFile 2)
(defconstant $channelFlagHasDependency 4)

(def-mactype :SGModalFilterProcPtr (find-mactype ':pointer)); (DialogRef theDialog , const EventRecord * theEvent , short * itemHit , long refCon)

(def-mactype :SGModalFilterUPP (find-mactype '(:pointer :OpaqueSGModalFilterProcPtr)))

(defconstant $sgPanelFlagForPanel 1)

(defconstant $seqGrabSettingsPreviewOnly 1)

(defconstant $channelPlayNormal 0)
(defconstant $channelPlayFast 1)
(defconstant $channelPlayHighQuality 2)
(defconstant $channelPlayAllData 4)
; 
;  *  SGInitialize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGInitialize" 
   ((s (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetDataOutput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetDataOutput" 
   ((s (:pointer :ComponentInstanceRecord))
    (movieFile (:pointer :FSSpec))
    (whereFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetDataOutput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetDataOutput" 
   ((s (:pointer :ComponentInstanceRecord))
    (movieFile (:pointer :FSSpec))
    (whereFlags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetGWorld" 
   ((s (:pointer :ComponentInstanceRecord))
    (gp (:pointer :OpaqueGrafPtr))
    (gd (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetGWorld" 
   ((s (:pointer :ComponentInstanceRecord))
    (gp (:pointer :CGrafPtr))
    (gd (:pointer :GDHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGNewChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGNewChannel" 
   ((s (:pointer :ComponentInstanceRecord))
    (channelType :OSType)
    (ref (:pointer :SGCHANNEL))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGDisposeChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGDisposeChannel" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGStartPreview()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGStartPreview" 
   ((s (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGStartRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGStartRecord" 
   ((s (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGIdle" 
   ((s (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGStop()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGStop" 
   ((s (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGPause()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPause" 
   ((s (:pointer :ComponentInstanceRecord))
    (pause :unsigned-byte)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGPrepare()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPrepare" 
   ((s (:pointer :ComponentInstanceRecord))
    (prepareForPreview :Boolean)
    (prepareForRecord :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGRelease()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGRelease" 
   ((s (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetMovie()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetMovie" 
   ((s (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MovieType)
() )
; 
;  *  SGSetMaximumRecordTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetMaximumRecordTime" 
   ((s (:pointer :ComponentInstanceRecord))
    (ticks :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetMaximumRecordTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetMaximumRecordTime" 
   ((s (:pointer :ComponentInstanceRecord))
    (ticks (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetStorageSpaceRemaining()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetStorageSpaceRemaining" 
   ((s (:pointer :ComponentInstanceRecord))
    (bytes (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetTimeRemaining()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetTimeRemaining" 
   ((s (:pointer :ComponentInstanceRecord))
    (ticksLeft (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGrabPict()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGrabPict" 
   ((s (:pointer :ComponentInstanceRecord))
    (p (:pointer :PICHANDLE))
    (bounds (:pointer :Rect))
    (offscreenDepth :SInt16)
    (grabPictFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetLastMovieResID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetLastMovieResID" 
   ((s (:pointer :ComponentInstanceRecord))
    (resID (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetFlags" 
   ((s (:pointer :ComponentInstanceRecord))
    (sgFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetFlags" 
   ((s (:pointer :ComponentInstanceRecord))
    (sgFlags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetDataProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetDataProc" 
   ((s (:pointer :ComponentInstanceRecord))
    (proc (:pointer :OpaqueSGDataProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGNewChannelFromComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGNewChannelFromComponent" 
   ((s (:pointer :ComponentInstanceRecord))
    (newChannel (:pointer :SGCHANNEL))
    (sgChannelComponent (:pointer :ComponentRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGDisposeDeviceList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGDisposeDeviceList" 
   ((s (:pointer :ComponentInstanceRecord))
    (list (:Handle :SGDeviceListRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGAppendDeviceListToMenu()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGAppendDeviceListToMenu" 
   ((s (:pointer :ComponentInstanceRecord))
    (list (:Handle :SGDeviceListRecord))
    (mh (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetSettings" 
   ((s (:pointer :ComponentInstanceRecord))
    (ud (:Handle :UserDataRecord))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetSettings" 
   ((s (:pointer :ComponentInstanceRecord))
    (ud (:pointer :USERDATA))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetIndChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetIndChannel" 
   ((s (:pointer :ComponentInstanceRecord))
    (index :SInt16)
    (ref (:pointer :SGCHANNEL))
    (chanType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGUpdate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGUpdate" 
   ((s (:pointer :ComponentInstanceRecord))
    (updateRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetPause()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetPause" 
   ((s (:pointer :ComponentInstanceRecord))
    (paused (:pointer :Byte))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(def-mactype :ConstComponentListPtr (find-mactype '(:handle :ComponentRecord)))
; 
;  *  SGSettingsDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSettingsDialog" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
    (numPanels :SInt16)
    (panelList (:Handle :ComponentRecord))
    (flags :signed-long)
    (proc (:pointer :OpaqueSGModalFilterProcPtr))
    (procRefNum :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetAlignmentProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetAlignmentProc" 
   ((s (:pointer :ComponentInstanceRecord))
    (alignmentProc (:pointer :ICMAlignmentProcRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetChannelSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetChannelSettings" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
    (ud (:Handle :UserDataRecord))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetChannelSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetChannelSettings" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
    (ud (:pointer :USERDATA))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetMode" 
   ((s (:pointer :ComponentInstanceRecord))
    (previewMode (:pointer :Boolean))
    (recordMode (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetDataRef" 
   ((s (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataRefType :OSType)
    (whereFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetDataRef" 
   ((s (:pointer :ComponentInstanceRecord))
    (dataRef (:pointer :Handle))
    (dataRefType (:pointer :OSType))
    (whereFlags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGNewOutput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGNewOutput" 
   ((s (:pointer :ComponentInstanceRecord))
    (dataRef :Handle)
    (dataRefType :OSType)
    (whereFlags :signed-long)
    (sgOut (:pointer :SGOUTPUT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGDisposeOutput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGDisposeOutput" 
   ((s (:pointer :ComponentInstanceRecord))
    (sgOut (:pointer :SGOutputRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetOutputFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetOutputFlags" 
   ((s (:pointer :ComponentInstanceRecord))
    (sgOut (:pointer :SGOutputRecord))
    (whereFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetChannelOutput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetChannelOutput" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
    (sgOut (:pointer :SGOutputRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetDataOutputStorageSpaceRemaining()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetDataOutputStorageSpaceRemaining" 
   ((s (:pointer :ComponentInstanceRecord))
    (sgOut (:pointer :SGOutputRecord))
    (space (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGHandleUpdateEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGHandleUpdateEvent" 
   ((s (:pointer :ComponentInstanceRecord))
    (event (:pointer :EventRecord))
    (handled (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetOutputNextOutput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetOutputNextOutput" 
   ((s (:pointer :ComponentInstanceRecord))
    (sgOut (:pointer :SGOutputRecord))
    (nextOut (:pointer :SGOutputRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetOutputNextOutput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetOutputNextOutput" 
   ((s (:pointer :ComponentInstanceRecord))
    (sgOut (:pointer :SGOutputRecord))
    (nextOut (:pointer :SGOUTPUT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetOutputMaximumOffset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetOutputMaximumOffset" 
   ((s (:pointer :ComponentInstanceRecord))
    (sgOut (:pointer :SGOutputRecord))
    (maxOffset (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetOutputMaximumOffset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetOutputMaximumOffset" 
   ((s (:pointer :ComponentInstanceRecord))
    (sgOut (:pointer :SGOutputRecord))
    (maxOffset (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetOutputDataReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetOutputDataReference" 
   ((s (:pointer :ComponentInstanceRecord))
    (sgOut (:pointer :SGOutputRecord))
    (dataRef (:pointer :Handle))
    (dataRefType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGWriteExtendedMovieData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGWriteExtendedMovieData" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
    (p :pointer)
    (len :signed-long)
    (offset (:pointer :wide))
    (sgOut (:pointer :SGOUTPUT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetStorageSpaceRemaining64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_SGGetStorageSpaceRemaining64" 
   ((s (:pointer :ComponentInstanceRecord))
    (bytes (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetDataOutputStorageSpaceRemaining64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_SGGetDataOutputStorageSpaceRemaining64" 
   ((s (:pointer :ComponentInstanceRecord))
    (sgOut (:pointer :SGOutputRecord))
    (space (:pointer :wide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     calls from Channel to seqGrab
; 
; 
;  *  SGWriteMovieData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGWriteMovieData" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
    (p :pointer)
    (len :signed-long)
    (offset (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGAddFrameReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGAddFrameReference" 
   ((s (:pointer :ComponentInstanceRecord))
    (frameInfo (:pointer :SeqGrabFrameInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetNextFrameReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetNextFrameReference" 
   ((s (:pointer :ComponentInstanceRecord))
    (frameInfo (:pointer :SeqGrabFrameInfo))
    (frameDuration (:pointer :TIMEVALUE))
    (frameNumber (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetTimeBase" 
   ((s (:pointer :ComponentInstanceRecord))
    (tb (:pointer :TIMEBASE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSortDeviceList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSortDeviceList" 
   ((s (:pointer :ComponentInstanceRecord))
    (list (:Handle :SGDeviceListRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGAddMovieData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGAddMovieData" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
    (p :pointer)
    (len :signed-long)
    (offset (:pointer :long))
    (chRefCon :signed-long)
    (time :signed-long)
    (writeType :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGChangedSource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGChangedSource" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGAddExtendedFrameReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGAddExtendedFrameReference" 
   ((s (:pointer :ComponentInstanceRecord))
    (frameInfo (:pointer :SeqGrabExtendedFrameInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetNextExtendedFrameReference()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetNextExtendedFrameReference" 
   ((s (:pointer :ComponentInstanceRecord))
    (frameInfo (:pointer :SeqGrabExtendedFrameInfo))
    (frameDuration (:pointer :TIMEVALUE))
    (frameNumber (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGAddExtendedMovieData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGAddExtendedMovieData" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
    (p :pointer)
    (len :signed-long)
    (offset (:pointer :wide))
    (chRefCon :signed-long)
    (time :signed-long)
    (writeType :SInt16)
    (whichOutput (:pointer :SGOUTPUT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGAddOutputDataRefToMedia()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGAddOutputDataRefToMedia" 
   ((s (:pointer :ComponentInstanceRecord))
    (sgOut (:pointer :SGOutputRecord))
    (theMedia (:Handle :MediaType))
    (desc (:Handle :SampleDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetSettingsSummary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_SGSetSettingsSummary" 
   ((s (:pointer :ComponentInstanceRecord))
    (summaryText :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; ** Sequence Grab CHANNEL Component Stuff **
; 
;  *  SGSetChannelUsage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetChannelUsage" 
   ((c (:pointer :ComponentInstanceRecord))
    (usage :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetChannelUsage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetChannelUsage" 
   ((c (:pointer :ComponentInstanceRecord))
    (usage (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetChannelBounds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetChannelBounds" 
   ((c (:pointer :ComponentInstanceRecord))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetChannelBounds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetChannelBounds" 
   ((c (:pointer :ComponentInstanceRecord))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetChannelVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetChannelVolume" 
   ((c (:pointer :ComponentInstanceRecord))
    (volume :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetChannelVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetChannelVolume" 
   ((c (:pointer :ComponentInstanceRecord))
    (volume (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetChannelInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetChannelInfo" 
   ((c (:pointer :ComponentInstanceRecord))
    (channelInfo (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetChannelPlayFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetChannelPlayFlags" 
   ((c (:pointer :ComponentInstanceRecord))
    (playFlags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetChannelPlayFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetChannelPlayFlags" 
   ((c (:pointer :ComponentInstanceRecord))
    (playFlags (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetChannelMaxFrames()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetChannelMaxFrames" 
   ((c (:pointer :ComponentInstanceRecord))
    (frameCount :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetChannelMaxFrames()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetChannelMaxFrames" 
   ((c (:pointer :ComponentInstanceRecord))
    (frameCount (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetChannelRefCon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetChannelRefCon" 
   ((c (:pointer :ComponentInstanceRecord))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetChannelClip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetChannelClip" 
   ((c (:pointer :ComponentInstanceRecord))
    (theClip (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetChannelClip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetChannelClip" 
   ((c (:pointer :ComponentInstanceRecord))
    (theClip (:pointer :RGNHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetChannelSampleDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetChannelSampleDescription" 
   ((c (:pointer :ComponentInstanceRecord))
    (sampleDesc :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetChannelDeviceList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetChannelDeviceList" 
   ((c (:pointer :ComponentInstanceRecord))
    (selectionFlags :signed-long)
    (list (:pointer :SGDEVICELIST))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetChannelDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetChannelDevice" 
   ((c (:pointer :ComponentInstanceRecord))
    (name (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetChannelMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetChannelMatrix" 
   ((c (:pointer :ComponentInstanceRecord))
    (m (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetChannelMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetChannelMatrix" 
   ((c (:pointer :ComponentInstanceRecord))
    (m (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetChannelTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetChannelTimeScale" 
   ((c (:pointer :ComponentInstanceRecord))
    (scale (:pointer :TIMESCALE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGChannelPutPicture()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGChannelPutPicture" 
   ((c (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGChannelSetRequestedDataRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGChannelSetRequestedDataRate" 
   ((c (:pointer :ComponentInstanceRecord))
    (bytesPerSecond :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGChannelGetRequestedDataRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGChannelGetRequestedDataRate" 
   ((c (:pointer :ComponentInstanceRecord))
    (bytesPerSecond (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGChannelSetDataSourceName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGChannelSetDataSourceName" 
   ((c (:pointer :ComponentInstanceRecord))
    (name (:pointer :STR255))
    (scriptTag :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGChannelGetDataSourceName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGChannelGetDataSourceName" 
   ((c (:pointer :ComponentInstanceRecord))
    (name (:pointer :STR255))
    (scriptTag (:pointer :SCRIPTCODE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGChannelSetCodecSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_SGChannelSetCodecSettings" 
   ((c (:pointer :ComponentInstanceRecord))
    (settings :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGChannelGetCodecSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_SGChannelGetCodecSettings" 
   ((c (:pointer :ComponentInstanceRecord))
    (settings (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetChannelTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 4.0 and later
;  *    Windows:          in qtmlClient.lib 4.0 and later
;  

(deftrap-inline "_SGGetChannelTimeBase" 
   ((c (:pointer :ComponentInstanceRecord))
    (tb (:pointer :TIMEBASE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetChannelRefCon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_SGGetChannelRefCon" 
   ((c (:pointer :ComponentInstanceRecord))
    (refCon (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
;  A utility call to find out the current device and input names, instead of having to call GetDeviceList and walk it yourself 
; 
;  *  SGGetChannelDeviceAndInputNames()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_SGGetChannelDeviceAndInputNames" 
   ((c (:pointer :ComponentInstanceRecord))
    (outDeviceName (:pointer :STR255))
    (outInputName (:pointer :STR255))
    (outInputNumber (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
;  A media format independent call for this. Inputs start at 0 here (Sound starts at 1, VDIGs at 0 in direct calls) 
; 
;  *  SGSetChannelDeviceInput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_SGSetChannelDeviceInput" 
   ((c (:pointer :ComponentInstanceRecord))
    (inInputNumber :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
;  A call to bracket SetSettings related calls, to give downstream components an opportunity to deal with the entire 
;     settings change in one go 

(defconstant $sgSetSettingsBegin 1)             ;  SGSetSettings related set calls about to start
;  Finished SGSetSettings calls. Get ready to use the new settings

(defconstant $sgSetSettingsEnd 2)
; 
;  *  SGSetChannelSettingsStateChanging()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_SGSetChannelSettingsStateChanging" 
   ((c (:pointer :ComponentInstanceRecord))
    (inFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;     calls from seqGrab to Channel
; 
; 
;  *  SGInitChannel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGInitChannel" 
   ((c (:pointer :ComponentInstanceRecord))
    (owner (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGWriteSamples()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGWriteSamples" 
   ((c (:pointer :ComponentInstanceRecord))
    (m (:Handle :MovieType))
    (theFile (:Handle :AliasRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetDataRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetDataRate" 
   ((c (:pointer :ComponentInstanceRecord))
    (bytesPerSecond (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGAlignChannelRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGAlignChannelRect" 
   ((c (:pointer :ComponentInstanceRecord))
    (r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     Dorky dialog panel calls
; 
; 
;  *  SGPanelGetDitl()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPanelGetDitl" 
   ((s (:pointer :ComponentInstanceRecord))
    (ditl (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGPanelGetTitle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPanelGetTitle" 
   ((s (:pointer :ComponentInstanceRecord))
    (title (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGPanelCanRun()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPanelCanRun" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGPanelInstall()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPanelInstall" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
    (d (:pointer :OpaqueDialogPtr))
    (itemOffset :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGPanelEvent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPanelEvent" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
    (d (:pointer :OpaqueDialogPtr))
    (itemOffset :SInt16)
    (theEvent (:pointer :EventRecord))
    (itemHit (:pointer :short))
    (handled (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGPanelItem()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPanelItem" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
    (d (:pointer :OpaqueDialogPtr))
    (itemOffset :SInt16)
    (itemNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGPanelRemove()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPanelRemove" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
    (d (:pointer :OpaqueDialogPtr))
    (itemOffset :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGPanelSetGrabber()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPanelSetGrabber" 
   ((s (:pointer :ComponentInstanceRecord))
    (sg (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGPanelSetResFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPanelSetResFile" 
   ((s (:pointer :ComponentInstanceRecord))
    (resRef :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGPanelGetSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPanelGetSettings" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
    (ud (:pointer :USERDATA))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGPanelSetSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPanelSetSettings" 
   ((s (:pointer :ComponentInstanceRecord))
    (c (:pointer :ComponentInstanceRecord))
    (ud (:Handle :UserDataRecord))
    (flags :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGPanelValidateInput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPanelValidateInput" 
   ((s (:pointer :ComponentInstanceRecord))
    (ok (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGPanelSetEventFilter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGPanelSetEventFilter" 
   ((s (:pointer :ComponentInstanceRecord))
    (proc (:pointer :OpaqueSGModalFilterProcPtr))
    (refCon :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     SGPanelGetDITLForSize is used to retrieve user interface elements that fit within a specified size
;     panel.  The component should return badComponentSelector for sizes it does not support.  The component
;     is required to support kSGSmallestDITLSize, and it is recommended to support kSGLargestDITLSize.
;     
;     If SGPanelGetDITLForSize is unimplemented entirely, the panel is assumed to not have resizable UI elements.
; 

(defconstant $kSGSmallestDITLSize -1)           ;  requestedSize h and v set to this to retrieve small size
;  requestedSize h and v set to this to retrieve large size

(defconstant $kSGLargestDITLSize -2)
; 
;  *  SGPanelGetDITLForSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_SGPanelGetDITLForSize" 
   ((s (:pointer :ComponentInstanceRecord))
    (ditl (:pointer :Handle))
    (requestedSize (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; ** Sequence Grab VIDEO CHANNEL Component Stuff **
; 
;     Video stuff
; 
(defrecord SGCompressInfo
   (buffer :pointer)
   (bufferSize :UInt32)
   (similarity :UInt8)
   (reserved :UInt8)
)

;type name? (%define-record :SGCompressInfo (find-record-descriptor ':SGCompressInfo))

(def-mactype :SGGrabBottleProcPtr (find-mactype ':pointer)); (SGChannel c , short bufferNum , long refCon)

(def-mactype :SGGrabCompleteBottleProcPtr (find-mactype ':pointer)); (SGChannel c , short bufferNum , Boolean * done , long refCon)

(def-mactype :SGDisplayBottleProcPtr (find-mactype ':pointer)); (SGChannel c , short bufferNum , MatrixRecord * mp , RgnHandle clipRgn , long refCon)

(def-mactype :SGCompressBottleProcPtr (find-mactype ':pointer)); (SGChannel c , short bufferNum , long refCon)

(def-mactype :SGCompressCompleteBottleProcPtr (find-mactype ':pointer)); (SGChannel c , short bufferNum , Boolean * done , SGCompressInfo * ci , long refCon)

(def-mactype :SGAddFrameBottleProcPtr (find-mactype ':pointer)); (SGChannel c , short bufferNum , TimeValue atTime , TimeScale scale , const SGCompressInfo * ci , long refCon)

(def-mactype :SGTransferFrameBottleProcPtr (find-mactype ':pointer)); (SGChannel c , short bufferNum , MatrixRecord * mp , RgnHandle clipRgn , long refCon)
;     Note that UInt8 *queuedFrameCount replaces Boolean *done. 0(==false) still means no frames, and 1(==true) one, 
;     but if more than one are available the number should be returned here. The value 2 previously meant more than one frame,
;     so some VDIGs may return 2 even if more than 2 are available, and some will still return 1 as they are using the original definition. 

(def-mactype :SGGrabCompressCompleteBottleProcPtr (find-mactype ':pointer)); (SGChannel c , UInt8 * queuedFrameCount , SGCompressInfo * ci , TimeRecord * t , long refCon)

(def-mactype :SGDisplayCompressBottleProcPtr (find-mactype ':pointer)); (SGChannel c , Ptr dataPtr , ImageDescriptionHandle desc , MatrixRecord * mp , RgnHandle clipRgn , long refCon)

(def-mactype :SGGrabBottleUPP (find-mactype '(:pointer :OpaqueSGGrabBottleProcPtr)))

(def-mactype :SGGrabCompleteBottleUPP (find-mactype '(:pointer :OpaqueSGGrabCompleteBottleProcPtr)))

(def-mactype :SGDisplayBottleUPP (find-mactype '(:pointer :OpaqueSGDisplayBottleProcPtr)))

(def-mactype :SGCompressBottleUPP (find-mactype '(:pointer :OpaqueSGCompressBottleProcPtr)))

(def-mactype :SGCompressCompleteBottleUPP (find-mactype '(:pointer :OpaqueSGCompressCompleteBottleProcPtr)))

(def-mactype :SGAddFrameBottleUPP (find-mactype '(:pointer :OpaqueSGAddFrameBottleProcPtr)))

(def-mactype :SGTransferFrameBottleUPP (find-mactype '(:pointer :OpaqueSGTransferFrameBottleProcPtr)))

(def-mactype :SGGrabCompressCompleteBottleUPP (find-mactype '(:pointer :OpaqueSGGrabCompressCompleteBottleProcPtr)))

(def-mactype :SGDisplayCompressBottleUPP (find-mactype '(:pointer :OpaqueSGDisplayCompressBottleProcPtr)))
(defrecord VideoBottles
   (procCount :SInt16)
   (grabProc (:pointer :OpaqueSGGrabBottleProcPtr))
   (grabCompleteProc (:pointer :OpaqueSGGrabCompleteBottleProcPtr))
   (displayProc (:pointer :OpaqueSGDisplayBottleProcPtr))
   (compressProc (:pointer :OpaqueSGCompressBottleProcPtr))
   (compressCompleteProc (:pointer :OpaqueSGCompressCompleteBottleProcPtr))
   (addFrameProc (:pointer :OpaqueSGAddFrameBottleProcPtr))
   (transferFrameProc (:pointer :OpaqueSGTransferFrameBottleProcPtr))
   (grabCompressCompleteProc (:pointer :OpaqueSGGrabCompressCompleteBottleProcPtr))
   (displayCompressProc (:pointer :OpaqueSGDisplayCompressBottleProcPtr))
)

;type name? (%define-record :VideoBottles (find-record-descriptor ':VideoBottles))
; 
;  *  SGGetSrcVideoBounds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetSrcVideoBounds" 
   ((c (:pointer :ComponentInstanceRecord))
    (r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetVideoRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetVideoRect" 
   ((c (:pointer :ComponentInstanceRecord))
    (r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetVideoRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetVideoRect" 
   ((c (:pointer :ComponentInstanceRecord))
    (r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetVideoCompressorType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetVideoCompressorType" 
   ((c (:pointer :ComponentInstanceRecord))
    (compressorType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetVideoCompressorType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetVideoCompressorType" 
   ((c (:pointer :ComponentInstanceRecord))
    (compressorType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetVideoCompressor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetVideoCompressor" 
   ((c (:pointer :ComponentInstanceRecord))
    (depth :SInt16)
    (compressor (:pointer :ComponentRecord))
    (spatialQuality :UInt32)
    (temporalQuality :UInt32)
    (keyFrameRate :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetVideoCompressor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetVideoCompressor" 
   ((c (:pointer :ComponentInstanceRecord))
    (depth (:pointer :short))
    (compressor (:pointer :COMPRESSORCOMPONENT))
    (spatialQuality (:pointer :CODECQ))
    (temporalQuality (:pointer :CODECQ))
    (keyFrameRate (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetVideoDigitizerComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetVideoDigitizerComponent" 
   ((c (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :ComponentInstanceRecord)
() )
; 
;  *  SGSetVideoDigitizerComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetVideoDigitizerComponent" 
   ((c (:pointer :ComponentInstanceRecord))
    (vdig (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGVideoDigitizerChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGVideoDigitizerChanged" 
   ((c (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetVideoBottlenecks()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetVideoBottlenecks" 
   ((c (:pointer :ComponentInstanceRecord))
    (vb (:pointer :VideoBottles))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetVideoBottlenecks()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetVideoBottlenecks" 
   ((c (:pointer :ComponentInstanceRecord))
    (vb (:pointer :VideoBottles))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGrabFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGrabFrame" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGrabFrameComplete()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGrabFrameComplete" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
    (done (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGDisplayFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGDisplayFrame" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
    (mp (:pointer :MatrixRecord))
    (clipRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGCompressFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGCompressFrame" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGCompressFrameComplete()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGCompressFrameComplete" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
    (done (:pointer :Boolean))
    (ci (:pointer :SGCompressInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGAddFrame()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGAddFrame" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
    (atTime :signed-long)
    (scale :signed-long)
    (ci (:pointer :SGCompressInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGTransferFrameForCompress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGTransferFrameForCompress" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
    (mp (:pointer :MatrixRecord))
    (clipRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetCompressBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetCompressBuffer" 
   ((c (:pointer :ComponentInstanceRecord))
    (depth :SInt16)
    (compressSize (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetCompressBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetCompressBuffer" 
   ((c (:pointer :ComponentInstanceRecord))
    (depth (:pointer :short))
    (compressSize (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetBufferInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetBufferInfo" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
    (bufferPM (:pointer :PIXMAPHANDLE))
    (bufferRect (:pointer :Rect))
    (compressBuffer (:pointer :GWORLDPTR))
    (compressBufferRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetUseScreenBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetUseScreenBuffer" 
   ((c (:pointer :ComponentInstanceRecord))
    (useScreenBuffer :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetUseScreenBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetUseScreenBuffer" 
   ((c (:pointer :ComponentInstanceRecord))
    (useScreenBuffer (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;     Note that UInt8 *queuedFrameCount replaces Boolean *done. 0(==false) still means no frames, and 1(==true) one, 
;     but if more than one are available the number should be returned here. The value 2 previously meant more than one frame,
;     so some VDIGs may return 2 even if more than 2 are available, and some will still return 1 as they are using the original definition. 
; 
;  *  SGGrabCompressComplete()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGrabCompressComplete" 
   ((c (:pointer :ComponentInstanceRecord))
    (queuedFrameCount (:pointer :UInt8))
    (ci (:pointer :SGCompressInfo))
    (tr (:pointer :TimeRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGDisplayCompress()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGDisplayCompress" 
   ((c (:pointer :ComponentInstanceRecord))
    (dataPtr :pointer)
    (desc (:Handle :ImageDescription))
    (mp (:pointer :MatrixRecord))
    (clipRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetFrameRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetFrameRate" 
   ((c (:pointer :ComponentInstanceRecord))
    (frameRate :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetFrameRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetFrameRate" 
   ((c (:pointer :ComponentInstanceRecord))
    (frameRate (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetPreferredPacketSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetPreferredPacketSize" 
   ((c (:pointer :ComponentInstanceRecord))
    (preferredPacketSizeInBytes :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetPreferredPacketSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetPreferredPacketSize" 
   ((c (:pointer :ComponentInstanceRecord))
    (preferredPacketSizeInBytes (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetUserVideoCompressorList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetUserVideoCompressorList" 
   ((c (:pointer :ComponentInstanceRecord))
    (compressorTypes :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetUserVideoCompressorList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetUserVideoCompressorList" 
   ((c (:pointer :ComponentInstanceRecord))
    (compressorTypes (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; ** Sequence Grab SOUND CHANNEL Component Stuff **
; 
;     Sound stuff
; 
; 
;  *  SGSetSoundInputDriver()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetSoundInputDriver" 
   ((c (:pointer :ComponentInstanceRecord))
    (driverName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetSoundInputDriver()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetSoundInputDriver" 
   ((c (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SGSoundInputDriverChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSoundInputDriverChanged" 
   ((c (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetSoundRecordChunkSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetSoundRecordChunkSize" 
   ((c (:pointer :ComponentInstanceRecord))
    (seconds :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetSoundRecordChunkSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetSoundRecordChunkSize" 
   ((c (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SGSetSoundInputRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetSoundInputRate" 
   ((c (:pointer :ComponentInstanceRecord))
    (rate :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetSoundInputRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetSoundInputRate" 
   ((c (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetSoundInputParameters()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetSoundInputParameters" 
   ((c (:pointer :ComponentInstanceRecord))
    (sampleSize :SInt16)
    (numChannels :SInt16)
    (compressionType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetSoundInputParameters()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetSoundInputParameters" 
   ((c (:pointer :ComponentInstanceRecord))
    (sampleSize (:pointer :short))
    (numChannels (:pointer :short))
    (compressionType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetAdditionalSoundRates()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetAdditionalSoundRates" 
   ((c (:pointer :ComponentInstanceRecord))
    (rates :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetAdditionalSoundRates()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetAdditionalSoundRates" 
   ((c (:pointer :ComponentInstanceRecord))
    (rates (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     Text stuff
; 
; 
;  *  SGSetFontName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetFontName" 
   ((c (:pointer :ComponentInstanceRecord))
    (pstr (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetFontSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetFontSize" 
   ((c (:pointer :ComponentInstanceRecord))
    (fontSize :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetTextForeColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetTextForeColor" 
   ((c (:pointer :ComponentInstanceRecord))
    (theColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetTextBackColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetTextBackColor" 
   ((c (:pointer :ComponentInstanceRecord))
    (theColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetJustification()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetJustification" 
   ((c (:pointer :ComponentInstanceRecord))
    (just :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGGetTextReturnToSpaceValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetTextReturnToSpaceValue" 
   ((c (:pointer :ComponentInstanceRecord))
    (rettospace (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetTextReturnToSpaceValue()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetTextReturnToSpaceValue" 
   ((c (:pointer :ComponentInstanceRecord))
    (rettospace :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;     Music stuff
; 
; 
;  *  SGGetInstrument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGGetInstrument" 
   ((c (:pointer :ComponentInstanceRecord))
    (td (:pointer :ToneDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  SGSetInstrument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 2.5 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_SGSetInstrument" 
   ((c (:pointer :ComponentInstanceRecord))
    (td (:pointer :ToneDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(defconstant $sgChannelAtom :|chan|)
(defconstant $sgChannelSettingsAtom :|ctom|)
(defconstant $sgChannelDescription :|cdsc|)
(defconstant $sgChannelSettings :|cset|)

(defconstant $sgDeviceNameType :|name|)
(defconstant $sgDeviceDisplayNameType :|dnam|)
(defconstant $sgDeviceUIDType :|duid|)
(defconstant $sgInputUIDType :|iuid|)
(defconstant $sgUsageType :|use |)
(defconstant $sgPlayFlagsType :|plyf|)
(defconstant $sgClipType :|clip|)
(defconstant $sgMatrixType :|mtrx|)
(defconstant $sgVolumeType :|volu|)

(defconstant $sgPanelSettingsAtom :|ptom|)
(defconstant $sgPanelDescription :|pdsc|)
(defconstant $sgPanelSettings :|pset|)

(defconstant $sgcSoundCompressionType :|scmp|)
(defconstant $sgcSoundCodecSettingsType :|cdec|)
(defconstant $sgcSoundSampleRateType :|srat|)
(defconstant $sgcSoundChannelCountType :|schn|)
(defconstant $sgcSoundSampleSizeType :|ssiz|)
(defconstant $sgcSoundInputType :|sinp|)
(defconstant $sgcSoundGainType :|gain|)

(defconstant $sgcVideoHueType :|hue |)
(defconstant $sgcVideoSaturationType :|satr|)
(defconstant $sgcVideoContrastType :|trst|)
(defconstant $sgcVideoSharpnessType :|shrp|)
(defconstant $sgcVideoBrigtnessType :|brit|)
(defconstant $sgcVideoBlackLevelType :|blkl|)
(defconstant $sgcVideoWhiteLevelType :|whtl|)
(defconstant $sgcVideoInputType :|vinp|)
(defconstant $sgcVideoFormatType :|vstd|)
(defconstant $sgcVideoFilterType :|vflt|)
(defconstant $sgcVideoRectType :|vrct|)
(defconstant $sgcVideoDigitizerType :|vdig|)

(def-mactype :QTVideoOutputComponent (find-mactype ':ComponentInstance))
;  Component type and subtype enumerations

(defconstant $QTVideoOutputComponentType :|vout|)
(defconstant $QTVideoOutputComponentBaseSubType :|base|)
;  QTVideoOutput Component flags

(defconstant $kQTVideoOutputDontDisplayToUser 1)
;  Display mode atom types

(defconstant $kQTVODisplayModeItem :|qdmi|)
(defconstant $kQTVODimensions :|dimn|)          ;  atom contains two longs - pixel count - width, height

(defconstant $kQTVOResolution :|resl|)          ;  atom contains two Fixed - hRes, vRes in dpi

(defconstant $kQTVORefreshRate :|refr|)         ;  atom contains one Fixed - refresh rate in Hz

(defconstant $kQTVOPixelType :|pixl|)           ;  atom contains one OSType - pixel format of mode

(defconstant $kQTVOName :|name|)                ;  atom contains string (no length byte) - name of mode for display to user

(defconstant $kQTVODecompressors :|deco|)       ;  atom contains other atoms indicating supported decompressors
;  kQTVODecompressors sub-atoms

(defconstant $kQTVODecompressorType :|dety|)    ;  atom contains one OSType - decompressor type code

(defconstant $kQTVODecompressorContinuous :|cont|);  atom contains one Boolean - true if this type is displayed continuously

(defconstant $kQTVODecompressorComponent :|cmpt|);  atom contains one Component - component id of decompressor

; * These are QTVideoOutput procedures *
; 
;  *  QTVideoOutputGetDisplayModeList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputGetDisplayModeList" 
   ((vo (:pointer :ComponentInstanceRecord))
    (outputs (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputGetCurrentClientName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputGetCurrentClientName" 
   ((vo (:pointer :ComponentInstanceRecord))
    (str (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputSetClientName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputSetClientName" 
   ((vo (:pointer :ComponentInstanceRecord))
    (str (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputGetClientName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputGetClientName" 
   ((vo (:pointer :ComponentInstanceRecord))
    (str (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputBegin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputBegin" 
   ((vo (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputEnd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputEnd" 
   ((vo (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputSetDisplayMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputSetDisplayMode" 
   ((vo (:pointer :ComponentInstanceRecord))
    (displayModeID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputGetDisplayMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputGetDisplayMode" 
   ((vo (:pointer :ComponentInstanceRecord))
    (displayModeID (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputCustomConfigureDisplay()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputCustomConfigureDisplay" 
   ((vo (:pointer :ComponentInstanceRecord))
    (filter (:pointer :OpaqueModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputSaveState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputSaveState" 
   ((vo (:pointer :ComponentInstanceRecord))
    (state (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputRestoreState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputRestoreState" 
   ((vo (:pointer :ComponentInstanceRecord))
    (state :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputGetGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputGetGWorld" 
   ((vo (:pointer :ComponentInstanceRecord))
    (gw (:pointer :GWORLDPTR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputGetGWorldParameters()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputGetGWorldParameters" 
   ((vo (:pointer :ComponentInstanceRecord))
    (baseAddr (:pointer :Ptr))
    (rowBytes (:pointer :long))
    (colorTable (:pointer :CTABHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputGetIndSoundOutput()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputGetIndSoundOutput" 
   ((vo (:pointer :ComponentInstanceRecord))
    (index :signed-long)
    (outputComponent (:pointer :Component))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputGetClock()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputGetClock" 
   ((vo (:pointer :ComponentInstanceRecord))
    (clock (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputSetEchoPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 3.0 and later
;  *    Windows:          in qtmlClient.lib 3.0 and later
;  

(deftrap-inline "_QTVideoOutputSetEchoPort" 
   ((vo (:pointer :ComponentInstanceRecord))
    (echoPort (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputGetIndImageDecompressor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 5.0 and later
;  *    Windows:          in qtmlClient.lib 5.0 and later
;  

(deftrap-inline "_QTVideoOutputGetIndImageDecompressor" 
   ((vo (:pointer :ComponentInstanceRecord))
    (index :signed-long)
    (codec (:pointer :Component))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputBaseSetEchoPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QuickTimeLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_QTVideoOutputBaseSetEchoPort" 
   ((vo (:pointer :ComponentInstanceRecord))
    (echoPort (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  QTVideoOutputCopyIndAudioOutputDeviceUID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 (or QuickTime 6.4) and later in QuickTime.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  *    Windows:          in qtmlClient.lib 6.5 and later
;  

(deftrap-inline "_QTVideoOutputCopyIndAudioOutputDeviceUID" 
   ((vo (:pointer :ComponentInstanceRecord))
    (index :signed-long)
    (audioDeviceUID (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :signed-long
() )
;  UPP call backs 
; 
;  *  NewDataHCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDataHCompletionUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDataHCompletionProcPtr)
() )
; 
;  *  NewVdigIntUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewVdigIntUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueVdigIntProcPtr)
() )
; 
;  *  NewStartDocumentHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewStartDocumentHandlerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueStartDocumentHandler)
() )
; 
;  *  NewEndDocumentHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewEndDocumentHandlerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueEndDocumentHandler)
() )
; 
;  *  NewStartElementHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewStartElementHandlerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueStartElementHandler)
() )
; 
;  *  NewEndElementHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewEndElementHandlerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueEndElementHandler)
() )
; 
;  *  NewCharDataHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCharDataHandlerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCharDataHandler)
() )
; 
;  *  NewPreprocessInstructionHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewPreprocessInstructionHandlerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaquePreprocessInstructionHandler)
() )
; 
;  *  NewCommentHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCommentHandlerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCommentHandler)
() )
; 
;  *  NewCDataHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCDataHandlerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :OpaqueCDataHandler)
() )
; 
;  *  NewSGDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSGDataUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSGDataProcPtr)
() )
; 
;  *  NewSGModalFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSGModalFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSGModalFilterProcPtr)
() )
; 
;  *  NewSGGrabBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSGGrabBottleUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSGGrabBottleProcPtr)
() )
; 
;  *  NewSGGrabCompleteBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSGGrabCompleteBottleUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSGGrabCompleteBottleProcPtr)
() )
; 
;  *  NewSGDisplayBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSGDisplayBottleUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSGDisplayBottleProcPtr)
() )
; 
;  *  NewSGCompressBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSGCompressBottleUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSGCompressBottleProcPtr)
() )
; 
;  *  NewSGCompressCompleteBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSGCompressCompleteBottleUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSGCompressCompleteBottleProcPtr)
() )
; 
;  *  NewSGAddFrameBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSGAddFrameBottleUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSGAddFrameBottleProcPtr)
() )
; 
;  *  NewSGTransferFrameBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSGTransferFrameBottleUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSGTransferFrameBottleProcPtr)
() )
; 
;  *  NewSGGrabCompressCompleteBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSGGrabCompressCompleteBottleUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSGGrabCompressCompleteBottleProcPtr)
() )
; 
;  *  NewSGDisplayCompressBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewSGDisplayCompressBottleUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueSGDisplayCompressBottleProcPtr)
() )
; 
;  *  DisposeDataHCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDataHCompletionUPP" 
   ((userUPP (:pointer :OpaqueDataHCompletionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeVdigIntUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeVdigIntUPP" 
   ((userUPP (:pointer :OpaqueVdigIntProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeStartDocumentHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeStartDocumentHandlerUPP" 
   ((userUPP (:pointer :OpaqueStartDocumentHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeEndDocumentHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeEndDocumentHandlerUPP" 
   ((userUPP (:pointer :OpaqueEndDocumentHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeStartElementHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeStartElementHandlerUPP" 
   ((userUPP (:pointer :OpaqueStartElementHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeEndElementHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeEndElementHandlerUPP" 
   ((userUPP (:pointer :OpaqueEndElementHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCharDataHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCharDataHandlerUPP" 
   ((userUPP (:pointer :OpaqueCharDataHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposePreprocessInstructionHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposePreprocessInstructionHandlerUPP" 
   ((userUPP (:pointer :OpaquePreprocessInstructionHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCommentHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCommentHandlerUPP" 
   ((userUPP (:pointer :OpaqueCommentHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCDataHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCDataHandlerUPP" 
   ((userUPP (:pointer :OpaqueCDataHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; 
;  *  DisposeSGDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSGDataUPP" 
   ((userUPP (:pointer :OpaqueSGDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSGModalFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSGModalFilterUPP" 
   ((userUPP (:pointer :OpaqueSGModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSGGrabBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSGGrabBottleUPP" 
   ((userUPP (:pointer :OpaqueSGGrabBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSGGrabCompleteBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSGGrabCompleteBottleUPP" 
   ((userUPP (:pointer :OpaqueSGGrabCompleteBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSGDisplayBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSGDisplayBottleUPP" 
   ((userUPP (:pointer :OpaqueSGDisplayBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSGCompressBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSGCompressBottleUPP" 
   ((userUPP (:pointer :OpaqueSGCompressBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSGCompressCompleteBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSGCompressCompleteBottleUPP" 
   ((userUPP (:pointer :OpaqueSGCompressCompleteBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSGAddFrameBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSGAddFrameBottleUPP" 
   ((userUPP (:pointer :OpaqueSGAddFrameBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSGTransferFrameBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSGTransferFrameBottleUPP" 
   ((userUPP (:pointer :OpaqueSGTransferFrameBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSGGrabCompressCompleteBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSGGrabCompressCompleteBottleUPP" 
   ((userUPP (:pointer :OpaqueSGGrabCompressCompleteBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeSGDisplayCompressBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeSGDisplayCompressBottleUPP" 
   ((userUPP (:pointer :OpaqueSGDisplayCompressBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDataHCompletionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDataHCompletionUPP" 
   ((request :pointer)
    (refcon :signed-long)
    (err :SInt16)
    (userUPP (:pointer :OpaqueDataHCompletionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeVdigIntUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeVdigIntUPP" 
   ((flags :signed-long)
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueVdigIntProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeStartDocumentHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeStartDocumentHandlerUPP" 
   ((refcon :signed-long)
    (userUPP (:pointer :OpaqueStartDocumentHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeEndDocumentHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeEndDocumentHandlerUPP" 
   ((refcon :signed-long)
    (userUPP (:pointer :OpaqueEndDocumentHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeStartElementHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeStartElementHandlerUPP" 
   ((name (:pointer :char))
    (atts (:pointer :char))
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueStartElementHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeEndElementHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeEndElementHandlerUPP" 
   ((name (:pointer :char))
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueEndElementHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeCharDataHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCharDataHandlerUPP" 
   ((charData (:pointer :char))
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueCharDataHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokePreprocessInstructionHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokePreprocessInstructionHandlerUPP" 
   ((name (:pointer :char))
    (atts (:pointer :char))
    (refcon :signed-long)
    (userUPP (:pointer :OpaquePreprocessInstructionHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeCommentHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCommentHandlerUPP" 
   ((comment (:pointer :char))
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueCommentHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeCDataHandlerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCDataHandlerUPP" 
   ((cdata (:pointer :char))
    (refcon :signed-long)
    (userUPP (:pointer :OpaqueCDataHandler))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  InvokeSGDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSGDataUPP" 
   ((c (:pointer :ComponentInstanceRecord))
    (p :pointer)
    (len :signed-long)
    (offset (:pointer :long))
    (chRefCon :signed-long)
    (time :signed-long)
    (writeType :SInt16)
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueSGDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeSGModalFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSGModalFilterUPP" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (theEvent (:pointer :EventRecord))
    (itemHit (:pointer :short))
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueSGModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeSGGrabBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSGGrabBottleUPP" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueSGGrabBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeSGGrabCompleteBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSGGrabCompleteBottleUPP" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
    (done (:pointer :Boolean))
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueSGGrabCompleteBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeSGDisplayBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSGDisplayBottleUPP" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
    (mp (:pointer :MatrixRecord))
    (clipRgn (:pointer :OpaqueRgnHandle))
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueSGDisplayBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeSGCompressBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSGCompressBottleUPP" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueSGCompressBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeSGCompressCompleteBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSGCompressCompleteBottleUPP" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
    (done (:pointer :Boolean))
    (ci (:pointer :SGCompressInfo))
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueSGCompressCompleteBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeSGAddFrameBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSGAddFrameBottleUPP" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
    (atTime :signed-long)
    (scale :signed-long)
    (ci (:pointer :SGCompressInfo))
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueSGAddFrameBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeSGTransferFrameBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSGTransferFrameBottleUPP" 
   ((c (:pointer :ComponentInstanceRecord))
    (bufferNum :SInt16)
    (mp (:pointer :MatrixRecord))
    (clipRgn (:pointer :OpaqueRgnHandle))
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueSGTransferFrameBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeSGGrabCompressCompleteBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSGGrabCompressCompleteBottleUPP" 
   ((c (:pointer :ComponentInstanceRecord))
    (queuedFrameCount (:pointer :UInt8))
    (ci (:pointer :SGCompressInfo))
    (t (:pointer :TimeRecord))
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueSGGrabCompressCompleteBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeSGDisplayCompressBottleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeSGDisplayCompressBottleUPP" 
   ((c (:pointer :ComponentInstanceRecord))
    (dataPtr :pointer)
    (desc (:Handle :ImageDescription))
    (mp (:pointer :MatrixRecord))
    (clipRgn (:pointer :OpaqueRgnHandle))
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueSGDisplayCompressBottleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  selectors for component calls 

(defconstant $kClockGetTimeSelect 1)
(defconstant $kClockNewCallBackSelect 2)
(defconstant $kClockDisposeCallBackSelect 3)
(defconstant $kClockCallMeWhenSelect 4)
(defconstant $kClockCancelCallBackSelect 5)
(defconstant $kClockRateChangedSelect 6)
(defconstant $kClockTimeChangedSelect 7)
(defconstant $kClockSetTimeBaseSelect 8)
(defconstant $kClockStartStopChangedSelect 9)
(defconstant $kClockGetRateSelect 10)
(defconstant $kClockGetTimesForRateChangeSelect 11)
(defconstant $kClockGetRateChangeConstraintsSelect 12)
(defconstant $kSCGetCompressionExtendedSelect 1)
(defconstant $kSCPositionRectSelect 2)
(defconstant $kSCPositionDialogSelect 3)
(defconstant $kSCSetTestImagePictHandleSelect 4)
(defconstant $kSCSetTestImagePictFileSelect 5)
(defconstant $kSCSetTestImagePixMapSelect 6)
(defconstant $kSCGetBestDeviceRectSelect 7)
(defconstant $kSCRequestImageSettingsSelect 10)
(defconstant $kSCCompressImageSelect 11)
(defconstant $kSCCompressPictureSelect 12)
(defconstant $kSCCompressPictureFileSelect 13)
(defconstant $kSCRequestSequenceSettingsSelect 14)
(defconstant $kSCCompressSequenceBeginSelect 15)
(defconstant $kSCCompressSequenceFrameSelect 16)
(defconstant $kSCCompressSequenceEndSelect 17)
(defconstant $kSCDefaultPictHandleSettingsSelect 18)
(defconstant $kSCDefaultPictFileSettingsSelect 19)
(defconstant $kSCDefaultPixMapSettingsSelect 20)
(defconstant $kSCGetInfoSelect 21)
(defconstant $kSCSetInfoSelect 22)
(defconstant $kSCNewGWorldSelect 23)
(defconstant $kSCSetCompressFlagsSelect 24)
(defconstant $kSCGetCompressFlagsSelect 25)
(defconstant $kSCGetSettingsAsTextSelect 26)
(defconstant $kSCGetSettingsAsAtomContainerSelect 27)
(defconstant $kSCSetSettingsFromAtomContainerSelect 28)
(defconstant $kSCCompressSequenceFrameAsyncSelect 29)
(defconstant $kSCAsyncIdleSelect 30)
(defconstant $kTweenerInitializeSelect 1)
(defconstant $kTweenerDoTweenSelect 2)
(defconstant $kTweenerResetSelect 3)
(defconstant $kTCGetCurrentTimeCodeSelect #x101)
(defconstant $kTCGetTimeCodeAtTimeSelect #x102)
(defconstant $kTCTimeCodeToStringSelect #x103)
(defconstant $kTCTimeCodeToFrameNumberSelect #x104)
(defconstant $kTCFrameNumberToTimeCodeSelect #x105)
(defconstant $kTCGetSourceRefSelect #x106)
(defconstant $kTCSetSourceRefSelect #x107)
(defconstant $kTCSetTimeCodeFlagsSelect #x108)
(defconstant $kTCGetTimeCodeFlagsSelect #x109)
(defconstant $kTCSetDisplayOptionsSelect #x10A)
(defconstant $kTCGetDisplayOptionsSelect #x10B)
(defconstant $kMovieImportHandleSelect 1)
(defconstant $kMovieImportFileSelect 2)
(defconstant $kMovieImportSetSampleDurationSelect 3)
(defconstant $kMovieImportSetSampleDescriptionSelect 4)
(defconstant $kMovieImportSetMediaFileSelect 5)
(defconstant $kMovieImportSetDimensionsSelect 6)
(defconstant $kMovieImportSetChunkSizeSelect 7)
(defconstant $kMovieImportSetProgressProcSelect 8)
(defconstant $kMovieImportSetAuxiliaryDataSelect 9)
(defconstant $kMovieImportSetFromScrapSelect 10)
(defconstant $kMovieImportDoUserDialogSelect 11)
(defconstant $kMovieImportSetDurationSelect 12)
(defconstant $kMovieImportGetAuxiliaryDataTypeSelect 13)
(defconstant $kMovieImportValidateSelect 14)
(defconstant $kMovieImportGetFileTypeSelect 15)
(defconstant $kMovieImportDataRefSelect 16)
(defconstant $kMovieImportGetSampleDescriptionSelect 17)
(defconstant $kMovieImportGetMIMETypeListSelect 18)
(defconstant $kMovieImportSetOffsetAndLimitSelect 19)
(defconstant $kMovieImportGetSettingsAsAtomContainerSelect 20)
(defconstant $kMovieImportSetSettingsFromAtomContainerSelect 21)
(defconstant $kMovieImportSetOffsetAndLimit64Select 22)
(defconstant $kMovieImportIdleSelect 23)
(defconstant $kMovieImportValidateDataRefSelect 24)
(defconstant $kMovieImportGetLoadStateSelect 25)
(defconstant $kMovieImportGetMaxLoadedTimeSelect 26)
(defconstant $kMovieImportEstimateCompletionTimeSelect 27)
(defconstant $kMovieImportSetDontBlockSelect 28)
(defconstant $kMovieImportGetDontBlockSelect 29)
(defconstant $kMovieImportSetIdleManagerSelect 30)
(defconstant $kMovieImportSetNewMovieFlagsSelect 31)
(defconstant $kMovieImportGetDestinationMediaTypeSelect 32)
(defconstant $kMovieImportSetMediaDataRefSelect 33)
(defconstant $kMovieImportDoUserDialogDataRefSelect 34)
(defconstant $kMovieExportToHandleSelect #x80)
(defconstant $kMovieExportToFileSelect #x81)
(defconstant $kMovieExportGetAuxiliaryDataSelect #x83)
(defconstant $kMovieExportSetProgressProcSelect #x84)
(defconstant $kMovieExportSetSampleDescriptionSelect #x85)
(defconstant $kMovieExportDoUserDialogSelect #x86)
(defconstant $kMovieExportGetCreatorTypeSelect #x87)
(defconstant $kMovieExportToDataRefSelect #x88)
(defconstant $kMovieExportFromProceduresToDataRefSelect #x89)
(defconstant $kMovieExportAddDataSourceSelect #x8A)
(defconstant $kMovieExportValidateSelect #x8B)
(defconstant $kMovieExportGetSettingsAsAtomContainerSelect #x8C)
(defconstant $kMovieExportSetSettingsFromAtomContainerSelect #x8D)
(defconstant $kMovieExportGetFileNameExtensionSelect #x8E)
(defconstant $kMovieExportGetShortFileTypeStringSelect #x8F)
(defconstant $kMovieExportGetSourceMediaTypeSelect #x90)
(defconstant $kMovieExportSetGetMoviePropertyProcSelect #x91)
(defconstant $kTextExportGetDisplayDataSelect #x100)
(defconstant $kTextExportGetTimeFractionSelect #x101)
(defconstant $kTextExportSetTimeFractionSelect #x102)
(defconstant $kTextExportGetSettingsSelect #x103)
(defconstant $kTextExportSetSettingsSelect #x104)
(defconstant $kMIDIImportGetSettingsSelect #x100)
(defconstant $kMIDIImportSetSettingsSelect #x101)
(defconstant $kMovieExportNewGetDataAndPropertiesProcsSelect #x100)
(defconstant $kMovieExportDisposeGetDataAndPropertiesProcsSelect #x101)
(defconstant $kGraphicsImageImportSetSequenceEnabledSelect #x100)
(defconstant $kGraphicsImageImportGetSequenceEnabledSelect #x101)
(defconstant $kPreviewShowDataSelect 1)
(defconstant $kPreviewMakePreviewSelect 2)
(defconstant $kPreviewMakePreviewReferenceSelect 3)
(defconstant $kPreviewEventSelect 4)
(defconstant $kDataCodecDecompressSelect 1)
(defconstant $kDataCodecGetCompressBufferSizeSelect 2)
(defconstant $kDataCodecCompressSelect 3)
(defconstant $kDataCodecBeginInterruptSafeSelect 4)
(defconstant $kDataCodecEndInterruptSafeSelect 5)
(defconstant $kDataCodecDecompressPartialSelect 6)
(defconstant $kDataCodecCompressPartialSelect 7)
(defconstant $kDataHGetDataSelect 2)
(defconstant $kDataHPutDataSelect 3)
(defconstant $kDataHFlushDataSelect 4)
(defconstant $kDataHOpenForWriteSelect 5)
(defconstant $kDataHCloseForWriteSelect 6)
(defconstant $kDataHOpenForReadSelect 8)
(defconstant $kDataHCloseForReadSelect 9)
(defconstant $kDataHSetDataRefSelect 10)
(defconstant $kDataHGetDataRefSelect 11)
(defconstant $kDataHCompareDataRefSelect 12)
(defconstant $kDataHTaskSelect 13)
(defconstant $kDataHScheduleDataSelect 14)
(defconstant $kDataHFinishDataSelect 15)
(defconstant $kDataHFlushCacheSelect 16)
(defconstant $kDataHResolveDataRefSelect 17)
(defconstant $kDataHGetFileSizeSelect 18)
(defconstant $kDataHCanUseDataRefSelect 19)
(defconstant $kDataHGetVolumeListSelect 20)
(defconstant $kDataHWriteSelect 21)
(defconstant $kDataHPreextendSelect 22)
(defconstant $kDataHSetFileSizeSelect 23)
(defconstant $kDataHGetFreeSpaceSelect 24)
(defconstant $kDataHCreateFileSelect 25)
(defconstant $kDataHGetPreferredBlockSizeSelect 26)
(defconstant $kDataHGetDeviceIndexSelect 27)
(defconstant $kDataHIsStreamingDataHandlerSelect 28)
(defconstant $kDataHGetDataInBufferSelect 29)
(defconstant $kDataHGetScheduleAheadTimeSelect 30)
(defconstant $kDataHSetCacheSizeLimitSelect 31)
(defconstant $kDataHGetCacheSizeLimitSelect 32)
(defconstant $kDataHGetMovieSelect 33)
(defconstant $kDataHAddMovieSelect 34)
(defconstant $kDataHUpdateMovieSelect 35)
(defconstant $kDataHDoesBufferSelect 36)
(defconstant $kDataHGetFileNameSelect 37)
(defconstant $kDataHGetAvailableFileSizeSelect 38)
(defconstant $kDataHGetMacOSFileTypeSelect 39)
(defconstant $kDataHGetMIMETypeSelect 40)
(defconstant $kDataHSetDataRefWithAnchorSelect 41)
(defconstant $kDataHGetDataRefWithAnchorSelect 42)
(defconstant $kDataHSetMacOSFileTypeSelect 43)
(defconstant $kDataHSetTimeBaseSelect 44)
(defconstant $kDataHGetInfoFlagsSelect 45)
(defconstant $kDataHScheduleData64Select 46)
(defconstant $kDataHWrite64Select 47)
(defconstant $kDataHGetFileSize64Select 48)
(defconstant $kDataHPreextend64Select 49)
(defconstant $kDataHSetFileSize64Select 50)
(defconstant $kDataHGetFreeSpace64Select 51)
(defconstant $kDataHAppend64Select 52)
(defconstant $kDataHReadAsyncSelect 53)
(defconstant $kDataHPollReadSelect 54)
(defconstant $kDataHGetDataAvailabilitySelect 55)
(defconstant $kDataHGetFileSizeAsyncSelect 58)
(defconstant $kDataHGetDataRefAsTypeSelect 59)
(defconstant $kDataHSetDataRefExtensionSelect 60)
(defconstant $kDataHGetDataRefExtensionSelect 61)
(defconstant $kDataHGetMovieWithFlagsSelect 62)
(defconstant $kDataHGetFileTypeOrderingSelect 64)
(defconstant $kDataHCreateFileWithFlagsSelect 65)
(defconstant $kDataHGetMIMETypeAsyncSelect 66)
(defconstant $kDataHGetInfoSelect 67)
(defconstant $kDataHSetIdleManagerSelect 68)
(defconstant $kDataHDeleteFileSelect 69)
(defconstant $kDataHSetMovieUsageFlagsSelect 70)
(defconstant $kDataHUseTemporaryDataRefSelect 71)
(defconstant $kDataHGetTemporaryDataRefCapabilitiesSelect 72)
(defconstant $kDataHRenameFileSelect 73)
(defconstant $kDataHPlaybackHintsSelect #x103)
(defconstant $kDataHPlaybackHints64Select #x10E)
(defconstant $kDataHGetDataRateSelect #x110)
(defconstant $kDataHSetTimeHintsSelect #x111)
(defconstant $kVDGetMaxSrcRectSelect 1)
(defconstant $kVDGetActiveSrcRectSelect 2)
(defconstant $kVDSetDigitizerRectSelect 3)
(defconstant $kVDGetDigitizerRectSelect 4)
(defconstant $kVDGetVBlankRectSelect 5)
(defconstant $kVDGetMaskPixMapSelect 6)
(defconstant $kVDGetPlayThruDestinationSelect 8)
(defconstant $kVDUseThisCLUTSelect 9)
(defconstant $kVDSetInputGammaValueSelect 10)
(defconstant $kVDGetInputGammaValueSelect 11)
(defconstant $kVDSetBrightnessSelect 12)
(defconstant $kVDGetBrightnessSelect 13)
(defconstant $kVDSetContrastSelect 14)
(defconstant $kVDSetHueSelect 15)
(defconstant $kVDSetSharpnessSelect 16)
(defconstant $kVDSetSaturationSelect 17)
(defconstant $kVDGetContrastSelect 18)
(defconstant $kVDGetHueSelect 19)
(defconstant $kVDGetSharpnessSelect 20)
(defconstant $kVDGetSaturationSelect 21)
(defconstant $kVDGrabOneFrameSelect 22)
(defconstant $kVDGetMaxAuxBufferSelect 23)
(defconstant $kVDGetDigitizerInfoSelect 25)
(defconstant $kVDGetCurrentFlagsSelect 26)
(defconstant $kVDSetKeyColorSelect 27)
(defconstant $kVDGetKeyColorSelect 28)
(defconstant $kVDAddKeyColorSelect 29)
(defconstant $kVDGetNextKeyColorSelect 30)
(defconstant $kVDSetKeyColorRangeSelect 31)
(defconstant $kVDGetKeyColorRangeSelect 32)
(defconstant $kVDSetDigitizerUserInterruptSelect 33)
(defconstant $kVDSetInputColorSpaceModeSelect 34)
(defconstant $kVDGetInputColorSpaceModeSelect 35)
(defconstant $kVDSetClipStateSelect 36)
(defconstant $kVDGetClipStateSelect 37)
(defconstant $kVDSetClipRgnSelect 38)
(defconstant $kVDClearClipRgnSelect 39)
(defconstant $kVDGetCLUTInUseSelect 40)
(defconstant $kVDSetPLLFilterTypeSelect 41)
(defconstant $kVDGetPLLFilterTypeSelect 42)
(defconstant $kVDGetMaskandValueSelect 43)
(defconstant $kVDSetMasterBlendLevelSelect 44)
(defconstant $kVDSetPlayThruDestinationSelect 45)
(defconstant $kVDSetPlayThruOnOffSelect 46)
(defconstant $kVDSetFieldPreferenceSelect 47)
(defconstant $kVDGetFieldPreferenceSelect 48)
(defconstant $kVDPreflightDestinationSelect 50)
(defconstant $kVDPreflightGlobalRectSelect 51)
(defconstant $kVDSetPlayThruGlobalRectSelect 52)
(defconstant $kVDSetInputGammaRecordSelect 53)
(defconstant $kVDGetInputGammaRecordSelect 54)
(defconstant $kVDSetBlackLevelValueSelect 55)
(defconstant $kVDGetBlackLevelValueSelect 56)
(defconstant $kVDSetWhiteLevelValueSelect 57)
(defconstant $kVDGetWhiteLevelValueSelect 58)
(defconstant $kVDGetVideoDefaultsSelect 59)
(defconstant $kVDGetNumberOfInputsSelect 60)
(defconstant $kVDGetInputFormatSelect 61)
(defconstant $kVDSetInputSelect 62)
(defconstant $kVDGetInputSelect 63)
(defconstant $kVDSetInputStandardSelect 64)
(defconstant $kVDSetupBuffersSelect 65)
(defconstant $kVDGrabOneFrameAsyncSelect 66)
(defconstant $kVDDoneSelect 67)
(defconstant $kVDSetCompressionSelect 68)
(defconstant $kVDCompressOneFrameAsyncSelect 69)
(defconstant $kVDCompressDoneSelect 70)
(defconstant $kVDReleaseCompressBufferSelect 71)
(defconstant $kVDGetImageDescriptionSelect 72)
(defconstant $kVDResetCompressSequenceSelect 73)
(defconstant $kVDSetCompressionOnOffSelect 74)
(defconstant $kVDGetCompressionTypesSelect 75)
(defconstant $kVDSetTimeBaseSelect 76)
(defconstant $kVDSetFrameRateSelect 77)
(defconstant $kVDGetDataRateSelect 78)
(defconstant $kVDGetSoundInputDriverSelect 79)
(defconstant $kVDGetDMADepthsSelect 80)
(defconstant $kVDGetPreferredTimeScaleSelect 81)
(defconstant $kVDReleaseAsyncBuffersSelect 82)
(defconstant $kVDSetDataRateSelect 84)
(defconstant $kVDGetTimeCodeSelect 85)
(defconstant $kVDUseSafeBuffersSelect 86)
(defconstant $kVDGetSoundInputSourceSelect 87)
(defconstant $kVDGetCompressionTimeSelect 88)
(defconstant $kVDSetPreferredPacketSizeSelect 89)
(defconstant $kVDSetPreferredImageDimensionsSelect 90)
(defconstant $kVDGetPreferredImageDimensionsSelect 91)
(defconstant $kVDGetInputNameSelect 92)
(defconstant $kVDSetDestinationPortSelect 93)
(defconstant $kVDGetDeviceNameAndFlagsSelect 94)
(defconstant $kVDCaptureStateChangingSelect 95)
(defconstant $kVDGetUniqueIDsSelect 96)
(defconstant $kVDSelectUniqueIDsSelect 97)
(defconstant $kVDCopyPreferredAudioDeviceSelect 99)
(defconstant $kVDIIDCGetFeaturesSelect #x200)
(defconstant $kVDIIDCSetFeaturesSelect #x201)
(defconstant $kVDIIDCGetDefaultFeaturesSelect #x202)
(defconstant $kVDIIDCGetCSRDataSelect #x203)
(defconstant $kVDIIDCSetCSRDataSelect #x204)
(defconstant $kVDIIDCGetFeaturesForSpecifierSelect #x205)
(defconstant $kXMLParseDataRefSelect 1)
(defconstant $kXMLParseFileSelect 2)
(defconstant $kXMLParseDisposeXMLDocSelect 3)
(defconstant $kXMLParseGetDetailedParseErrorSelect 4)
(defconstant $kXMLParseAddElementSelect 5)
(defconstant $kXMLParseAddAttributeSelect 6)
(defconstant $kXMLParseAddMultipleAttributesSelect 7)
(defconstant $kXMLParseAddAttributeAndValueSelect 8)
(defconstant $kXMLParseAddMultipleAttributesAndValuesSelect 9)
(defconstant $kXMLParseAddAttributeValueKindSelect 10)
(defconstant $kXMLParseAddNameSpaceSelect 11)
(defconstant $kXMLParseSetOffsetAndLimitSelect 12)
(defconstant $kXMLParseSetEventParseRefConSelect 13)
(defconstant $kXMLParseSetStartDocumentHandlerSelect 14)
(defconstant $kXMLParseSetEndDocumentHandlerSelect 15)
(defconstant $kXMLParseSetStartElementHandlerSelect 16)
(defconstant $kXMLParseSetEndElementHandlerSelect 17)
(defconstant $kXMLParseSetCharDataHandlerSelect 18)
(defconstant $kXMLParseSetPreprocessInstructionHandlerSelect 19)
(defconstant $kXMLParseSetCommentHandlerSelect 20)
(defconstant $kXMLParseSetCDataHandlerSelect 21)
(defconstant $kSGInitializeSelect 1)
(defconstant $kSGSetDataOutputSelect 2)
(defconstant $kSGGetDataOutputSelect 3)
(defconstant $kSGSetGWorldSelect 4)
(defconstant $kSGGetGWorldSelect 5)
(defconstant $kSGNewChannelSelect 6)
(defconstant $kSGDisposeChannelSelect 7)
(defconstant $kSGStartPreviewSelect 16)
(defconstant $kSGStartRecordSelect 17)
(defconstant $kSGIdleSelect 18)
(defconstant $kSGStopSelect 19)
(defconstant $kSGPauseSelect 20)
(defconstant $kSGPrepareSelect 21)
(defconstant $kSGReleaseSelect 22)
(defconstant $kSGGetMovieSelect 23)
(defconstant $kSGSetMaximumRecordTimeSelect 24)
(defconstant $kSGGetMaximumRecordTimeSelect 25)
(defconstant $kSGGetStorageSpaceRemainingSelect 26)
(defconstant $kSGGetTimeRemainingSelect 27)
(defconstant $kSGGrabPictSelect 28)
(defconstant $kSGGetLastMovieResIDSelect 29)
(defconstant $kSGSetFlagsSelect 30)
(defconstant $kSGGetFlagsSelect 31)
(defconstant $kSGSetDataProcSelect 32)
(defconstant $kSGNewChannelFromComponentSelect 33)
(defconstant $kSGDisposeDeviceListSelect 34)
(defconstant $kSGAppendDeviceListToMenuSelect 35)
(defconstant $kSGSetSettingsSelect 36)
(defconstant $kSGGetSettingsSelect 37)
(defconstant $kSGGetIndChannelSelect 38)
(defconstant $kSGUpdateSelect 39)
(defconstant $kSGGetPauseSelect 40)
(defconstant $kSGSettingsDialogSelect 41)
(defconstant $kSGGetAlignmentProcSelect 42)
(defconstant $kSGSetChannelSettingsSelect 43)
(defconstant $kSGGetChannelSettingsSelect 44)
(defconstant $kSGGetModeSelect 45)
(defconstant $kSGSetDataRefSelect 46)
(defconstant $kSGGetDataRefSelect 47)
(defconstant $kSGNewOutputSelect 48)
(defconstant $kSGDisposeOutputSelect 49)
(defconstant $kSGSetOutputFlagsSelect 50)
(defconstant $kSGSetChannelOutputSelect 51)
(defconstant $kSGGetDataOutputStorageSpaceRemainingSelect 52)
(defconstant $kSGHandleUpdateEventSelect 53)
(defconstant $kSGSetOutputNextOutputSelect 54)
(defconstant $kSGGetOutputNextOutputSelect 55)
(defconstant $kSGSetOutputMaximumOffsetSelect 56)
(defconstant $kSGGetOutputMaximumOffsetSelect 57)
(defconstant $kSGGetOutputDataReferenceSelect 58)
(defconstant $kSGWriteExtendedMovieDataSelect 59)
(defconstant $kSGGetStorageSpaceRemaining64Select 60)
(defconstant $kSGGetDataOutputStorageSpaceRemaining64Select 61)
(defconstant $kSGWriteMovieDataSelect #x100)
(defconstant $kSGAddFrameReferenceSelect #x101)
(defconstant $kSGGetNextFrameReferenceSelect #x102)
(defconstant $kSGGetTimeBaseSelect #x103)
(defconstant $kSGSortDeviceListSelect #x104)
(defconstant $kSGAddMovieDataSelect #x105)
(defconstant $kSGChangedSourceSelect #x106)
(defconstant $kSGAddExtendedFrameReferenceSelect #x107)
(defconstant $kSGGetNextExtendedFrameReferenceSelect #x108)
(defconstant $kSGAddExtendedMovieDataSelect #x109)
(defconstant $kSGAddOutputDataRefToMediaSelect #x10A)
(defconstant $kSGSetSettingsSummarySelect #x10B)
(defconstant $kSGSetChannelUsageSelect #x80)
(defconstant $kSGGetChannelUsageSelect #x81)
(defconstant $kSGSetChannelBoundsSelect #x82)
(defconstant $kSGGetChannelBoundsSelect #x83)
(defconstant $kSGSetChannelVolumeSelect #x84)
(defconstant $kSGGetChannelVolumeSelect #x85)
(defconstant $kSGGetChannelInfoSelect #x86)
(defconstant $kSGSetChannelPlayFlagsSelect #x87)
(defconstant $kSGGetChannelPlayFlagsSelect #x88)
(defconstant $kSGSetChannelMaxFramesSelect #x89)
(defconstant $kSGGetChannelMaxFramesSelect #x8A)
(defconstant $kSGSetChannelRefConSelect #x8B)
(defconstant $kSGSetChannelClipSelect #x8C)
(defconstant $kSGGetChannelClipSelect #x8D)
(defconstant $kSGGetChannelSampleDescriptionSelect #x8E)
(defconstant $kSGGetChannelDeviceListSelect #x8F)
(defconstant $kSGSetChannelDeviceSelect #x90)
(defconstant $kSGSetChannelMatrixSelect #x91)
(defconstant $kSGGetChannelMatrixSelect #x92)
(defconstant $kSGGetChannelTimeScaleSelect #x93)
(defconstant $kSGChannelPutPictureSelect #x94)
(defconstant $kSGChannelSetRequestedDataRateSelect #x95)
(defconstant $kSGChannelGetRequestedDataRateSelect #x96)
(defconstant $kSGChannelSetDataSourceNameSelect #x97)
(defconstant $kSGChannelGetDataSourceNameSelect #x98)
(defconstant $kSGChannelSetCodecSettingsSelect #x99)
(defconstant $kSGChannelGetCodecSettingsSelect #x9A)
(defconstant $kSGGetChannelTimeBaseSelect #x9B)
(defconstant $kSGGetChannelRefConSelect #x9C)
(defconstant $kSGGetChannelDeviceAndInputNamesSelect #x9D)
(defconstant $kSGSetChannelDeviceInputSelect #x9E)
(defconstant $kSGSetChannelSettingsStateChangingSelect #x9F)
(defconstant $kSGInitChannelSelect #x180)
(defconstant $kSGWriteSamplesSelect #x181)
(defconstant $kSGGetDataRateSelect #x182)
(defconstant $kSGAlignChannelRectSelect #x183)
(defconstant $kSGPanelGetDitlSelect #x200)
(defconstant $kSGPanelGetTitleSelect #x201)
(defconstant $kSGPanelCanRunSelect #x202)
(defconstant $kSGPanelInstallSelect #x203)
(defconstant $kSGPanelEventSelect #x204)
(defconstant $kSGPanelItemSelect #x205)
(defconstant $kSGPanelRemoveSelect #x206)
(defconstant $kSGPanelSetGrabberSelect #x207)
(defconstant $kSGPanelSetResFileSelect #x208)
(defconstant $kSGPanelGetSettingsSelect #x209)
(defconstant $kSGPanelSetSettingsSelect #x20A)
(defconstant $kSGPanelValidateInputSelect #x20B)
(defconstant $kSGPanelSetEventFilterSelect #x20C)
(defconstant $kSGPanelGetDITLForSizeSelect #x20D)
(defconstant $kSGGetSrcVideoBoundsSelect #x100)
(defconstant $kSGSetVideoRectSelect #x101)
(defconstant $kSGGetVideoRectSelect #x102)
(defconstant $kSGGetVideoCompressorTypeSelect #x103)
(defconstant $kSGSetVideoCompressorTypeSelect #x104)
(defconstant $kSGSetVideoCompressorSelect #x105)
(defconstant $kSGGetVideoCompressorSelect #x106)
(defconstant $kSGGetVideoDigitizerComponentSelect #x107)
(defconstant $kSGSetVideoDigitizerComponentSelect #x108)
(defconstant $kSGVideoDigitizerChangedSelect #x109)
(defconstant $kSGSetVideoBottlenecksSelect #x10A)
(defconstant $kSGGetVideoBottlenecksSelect #x10B)
(defconstant $kSGGrabFrameSelect #x10C)
(defconstant $kSGGrabFrameCompleteSelect #x10D)
(defconstant $kSGDisplayFrameSelect #x10E)
(defconstant $kSGCompressFrameSelect #x10F)
(defconstant $kSGCompressFrameCompleteSelect #x110)
(defconstant $kSGAddFrameSelect #x111)
(defconstant $kSGTransferFrameForCompressSelect #x112)
(defconstant $kSGSetCompressBufferSelect #x113)
(defconstant $kSGGetCompressBufferSelect #x114)
(defconstant $kSGGetBufferInfoSelect #x115)
(defconstant $kSGSetUseScreenBufferSelect #x116)
(defconstant $kSGGetUseScreenBufferSelect #x117)
(defconstant $kSGGrabCompressCompleteSelect #x118)
(defconstant $kSGDisplayCompressSelect #x119)
(defconstant $kSGSetFrameRateSelect #x11A)
(defconstant $kSGGetFrameRateSelect #x11B)
(defconstant $kSGSetPreferredPacketSizeSelect #x121)
(defconstant $kSGGetPreferredPacketSizeSelect #x122)
(defconstant $kSGSetUserVideoCompressorListSelect #x123)
(defconstant $kSGGetUserVideoCompressorListSelect #x124)
(defconstant $kSGSetSoundInputDriverSelect #x100)
(defconstant $kSGGetSoundInputDriverSelect #x101)
(defconstant $kSGSoundInputDriverChangedSelect #x102)
(defconstant $kSGSetSoundRecordChunkSizeSelect #x103)
(defconstant $kSGGetSoundRecordChunkSizeSelect #x104)
(defconstant $kSGSetSoundInputRateSelect #x105)
(defconstant $kSGGetSoundInputRateSelect #x106)
(defconstant $kSGSetSoundInputParametersSelect #x107)
(defconstant $kSGGetSoundInputParametersSelect #x108)
(defconstant $kSGSetAdditionalSoundRatesSelect #x109)
(defconstant $kSGGetAdditionalSoundRatesSelect #x10A)
(defconstant $kSGSetFontNameSelect #x100)
(defconstant $kSGSetFontSizeSelect #x101)
(defconstant $kSGSetTextForeColorSelect #x102)
(defconstant $kSGSetTextBackColorSelect #x103)
(defconstant $kSGSetJustificationSelect #x104)
(defconstant $kSGGetTextReturnToSpaceValueSelect #x105)
(defconstant $kSGSetTextReturnToSpaceValueSelect #x106)
(defconstant $kSGGetInstrumentSelect #x100)
(defconstant $kSGSetInstrumentSelect #x101)
(defconstant $kQTVideoOutputGetDisplayModeListSelect 1)
(defconstant $kQTVideoOutputGetCurrentClientNameSelect 2)
(defconstant $kQTVideoOutputSetClientNameSelect 3)
(defconstant $kQTVideoOutputGetClientNameSelect 4)
(defconstant $kQTVideoOutputBeginSelect 5)
(defconstant $kQTVideoOutputEndSelect 6)
(defconstant $kQTVideoOutputSetDisplayModeSelect 7)
(defconstant $kQTVideoOutputGetDisplayModeSelect 8)
(defconstant $kQTVideoOutputCustomConfigureDisplaySelect 9)
(defconstant $kQTVideoOutputSaveStateSelect 10)
(defconstant $kQTVideoOutputRestoreStateSelect 11)
(defconstant $kQTVideoOutputGetGWorldSelect 12)
(defconstant $kQTVideoOutputGetGWorldParametersSelect 13)
(defconstant $kQTVideoOutputGetIndSoundOutputSelect 14)
(defconstant $kQTVideoOutputGetClockSelect 15)
(defconstant $kQTVideoOutputSetEchoPortSelect 16)
(defconstant $kQTVideoOutputGetIndImageDecompressorSelect 17)
(defconstant $kQTVideoOutputBaseSetEchoPortSelect 18)
(defconstant $kQTVideoOutputCopyIndAudioOutputDeviceUIDSelect 22)
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __QUICKTIMECOMPONENTS__ */


(provide-interface "QuickTimeComponents")