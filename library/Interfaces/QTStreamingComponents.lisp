(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:QTStreamingComponents.h"
; at Sunday July 2,2006 7:31:22 pm.
; 
;      File:       QuickTime/QTStreamingComponents.h
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
; #ifndef __QTSTREAMINGCOMPONENTS__
; #define __QTSTREAMINGCOMPONENTS__
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
; #ifndef __QUICKTIMESTREAMING__
#| #|
#include <QuickTimeQuickTimeStreaming.h>
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
; ============================================================================
;         Stream Sourcer
; ============================================================================

(defconstant $kQTSSourcerType :|srcr|)

(def-mactype :QTSSourcer (find-mactype ':ComponentInstance))

(defconstant $kQTSSGChannelSourcerType :|sgch|)
(defconstant $kQTSMovieTrackSourcerType :|trak|)
(defconstant $kQTSPushDataSourcerType :|push|)
;  flags for sourcer data 

(defconstant $kQTSSourcerDataFlag_SyncSample 1)
(defconstant $kQTSPushDataSourcerFlag_SampleTimeIsValid #x80000000)

(defconstant $kQTSSourcerInitParamsVersion1 1)
(defrecord QTSSourcerInitParams
   (version :SInt32)
   (flags :SInt32)
   (dataType :OSType)
   (data :pointer)
   (dataLength :UInt32)
)

;type name? (%define-record :QTSSourcerInitParams (find-record-descriptor ':QTSSourcerInitParams))
; 
;  *  QTSNewSourcer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSNewSourcer" 
   ((params :pointer)
    (inInitParams (:pointer :QTSSourcerInitParams))
    (inFlags :SInt32)
    (outSourcer (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  info selectors for sourcers - get and set 

(defconstant $kQTSInfo_Track :|trak|)           ;  QTSTrackParams* 

(defconstant $kQTSInfo_Loop :|loop|)            ;  QTSLoopParams* 

(defconstant $kQTSInfo_SourcerTiming :|stim|)   ;  QTSSourcerTimingParams* 

(defconstant $kQTSInfo_TargetFrameRate :|tfps|) ;  Fixed * in frames per second 

(defconstant $kQTSInfo_PushData :|push|)        ;  QTSPushDataParams* 

(defconstant $kQTSInfo_SourcerCallbackProc :|scbp|);  QTSSourcerCallbackProcParams* 

(defconstant $kQTSInfo_TargetDataRate :|tdrt|)  ;  UInt32 * in bytes per second 

(defconstant $kQTSInfo_AudioAutoGainOnOff :|agc |);  Boolean*  - error if unavailable

(defconstant $kQTSInfo_AudioGain :|gain|)       ;  Fixed* kFixed1 is unity gain 

(defconstant $kQTSInfo_CroppedInputRect :|crpr|);  Rect* - defined relative to kQTSInfo_FullInputRect below 

(defconstant $kQTSInfo_SpatialSettings :|sptl|) ;  pointer to SCSpatialSettings struct

(defconstant $kQTSInfo_TemporalSettings :|tprl|);  pointer to SCTemporalSettings struct

(defconstant $kQTSInfo_DataRateSettings :|drat|);  pointer to SCDataRateSettings struct

(defconstant $kQTSInfo_CodecFlags :|cflg|)      ;  pointer to CodecFlags

(defconstant $kQTSInfo_CodecSettings :|cdec|)   ;  pointer to Handle

(defconstant $kQTSInfo_ForceKeyValue :|ksim|)   ;  pointer to long

(defconstant $kQTSInfo_SoundSampleRate :|ssrt|) ;  pointer to UnsignedFixed

(defconstant $kQTSInfo_SoundSampleSize :|ssss|) ;  pointer to short

(defconstant $kQTSInfo_SoundChannelCount :|sscc|);  pointer to short

(defconstant $kQTSInfo_SoundCompression :|ssct|);  pointer to OSType

(defconstant $kQTSInfo_CompressionList :|ctyl|) ;  pointer to OSType Handle

(defconstant $kQTSInfo_VideoHue :|hue |)        ;  UInt16* 

(defconstant $kQTSInfo_VideoSaturation :|satr|) ;  UInt16* 

(defconstant $kQTSInfo_VideoContrast :|trst|)   ;  UInt16* 

(defconstant $kQTSInfo_VideoBrightness :|brit|) ;  UInt16* 

(defconstant $kQTSInfo_VideoSharpness :|shrp|)  ;  UInt16* 

(defconstant $kQTSInfo_TimeScale :|scal|)       ;  UInt32* 

(defconstant $kQTSInfo_SGChannelDeviceName :|innm|);  Handle* 

(defconstant $kQTSInfo_SGChannelDeviceList :|srdl|);  SGDeviceList* 

(defconstant $kQTSInfo_SGChannelDeviceInput :|sdii|);  short* 

(defconstant $kQTSInfo_SGChannelSettings :|sesg|);  QTSSGChannelSettingsParams 

(defconstant $kQTSInfo_PreviewWhileRecordingMode :|srpr|);  Boolean* 

(defconstant $kQTSInfo_CompressionParams :|sccp|);  QTAtomContainer* 

;  info selectors for sourcers - get only

(defconstant $kQTSInfo_SGChannel :|sgch|)       ;  SGChannel* 

(defconstant $kQTSInfo_SGChannelInputName :|srnm|);  Handle* 

(defconstant $kQTSInfo_FullInputRect :|fulr|)   ;  Rect* 

;  loop flags 

(defconstant $kQTSLoopFlag_Loop 1)

(defconstant $kQTSLoopParamsVersion1 1)
(defrecord QTSLoopParams
   (version :SInt32)
   (flags :SInt32)
   (loopFlags :SInt32)
   (flagsMask :SInt32)
   (numLoops :SInt32)
)

;type name? (%define-record :QTSLoopParams (find-record-descriptor ':QTSLoopParams))

(defconstant $kQTSTrackParamsVersion1 1)
(defrecord QTSTrackParams
   (version :SInt32)
   (flags :SInt32)
   (track (:Handle :TrackType))
   (trackStartOffset :TIMEVALUE64)              ;  to start other than at the beginning otherwise set to 0
   (duration :TIMEVALUE64)                      ;  to limit the duration otherwise set to 0
   (loopParams (:pointer :QTSLoopParams))       ;  set to NULL if not using; default is no looping 
)

;type name? (%define-record :QTSTrackParams (find-record-descriptor ':QTSTrackParams))

(defconstant $kQTSSourcerTimingParamsVersion1 1)
(defrecord QTSSourcerTimingParams
   (version :SInt32)
   (flags :SInt32)
   (timeScale :signed-long)
   (presentationStartTime :TIMEVALUE64)
   (presentationEndTime :TIMEVALUE64)
   (presentationCurrentTime :TIMEVALUE64)
   (localStartTime :TIMEVALUE64)
   (localEndTime :TIMEVALUE64)
   (localCurrentTime :TIMEVALUE64)
)

;type name? (%define-record :QTSSourcerTimingParams (find-record-descriptor ':QTSSourcerTimingParams))

(defconstant $kQTSPushDataParamsVersion1 1)

(defconstant $kQTSPushDataFlag_SampleTimeIsValid 1)
(defconstant $kQTSPushDataFlag_DurationIsValid 2)
(defrecord QTSPushDataParams
   (version :SInt32)
   (flags :SInt32)
   (sampleDescription (:Handle :SampleDescription));  caller owns the handle 
   (sampleDescSeed :UInt32)
   (sampleTime :TIMEVALUE64)                    ;  also set flag if you set this 
   (duration :TIMEVALUE64)                      ;  also set flag if you set this 
   (dataLength :UInt32)
   (dataPtr :pointer)                           ;  this does not have to be a real macintosh Ptr 
)

;type name? (%define-record :QTSPushDataParams (find-record-descriptor ':QTSPushDataParams))

(defconstant $kQTSSourcerCallbackProcParamsVersion1 1)
(defrecord QTSSourcerCallbackProcParams
   (version :SInt32)
   (flags :SInt32)
   (proc (:pointer :OpaqueQTSNotificationProcPtr))
   (refCon :pointer)
)

;type name? (%define-record :QTSSourcerCallbackProcParams (find-record-descriptor ':QTSSourcerCallbackProcParams))
;  track sourcer callback selectors

(defconstant $kQTSSourcerCallback_Done :|done|) ;  QTSSourcerDoneParams* 

;  push data sourcer callback selectors

(defconstant $kQTSPushDataSourcerCallback_HasCharacteristic #x50D);  QTSPushDataHasCharacteristicParams* 

(defconstant $kQTSPushDataSourcerCallback_SetInfo #x507);  QTSPushDataInfoParams* 

(defconstant $kQTSPushDataSourcerCallback_GetInfo #x508);  QTSPushDataInfoParams* 

(defrecord QTSPushDataHasCharacteristicParams
   (version :SInt32)
   (flags :SInt32)
   (characteristic :OSType)
   (returnedHasIt :Boolean)
   (reserved1 :character)
   (reserved2 :character)
   (reserved3 :character)
)

;type name? (%define-record :QTSPushDataHasCharacteristicParams (find-record-descriptor ':QTSPushDataHasCharacteristicParams))
(defrecord QTSPushDataInfoParams
   (version :SInt32)
   (flags :SInt32)
   (selector :OSType)
   (ioParams :pointer)
)

;type name? (%define-record :QTSPushDataInfoParams (find-record-descriptor ':QTSPushDataInfoParams))

(defconstant $kQTSSourcerDoneParamsVersion1 1)
(defrecord QTSSourcerDoneParams
   (version :SInt32)
   (flags :SInt32)
   (sourcer (:pointer :ComponentInstanceRecord))
)

;type name? (%define-record :QTSSourcerDoneParams (find-record-descriptor ':QTSSourcerDoneParams))
(defrecord QTSSGChannelSettingsParams
   (settings (:Handle :UserDataRecord))
   (flags :SInt32)
)

;type name? (%define-record :QTSSGChannelSettingsParams (find-record-descriptor ':QTSSGChannelSettingsParams))
; -----------------------------------------
;     Stream Sourcer Selectors
; -----------------------------------------

(defconstant $kQTSSourcerInitializeSelect #x500)
(defconstant $kQTSSourcerSetEnableSelect #x503)
(defconstant $kQTSSourcerGetEnableSelect #x504)
(defconstant $kQTSSourcerSetInfoSelect #x507)
(defconstant $kQTSSourcerGetInfoSelect #x508)
(defconstant $kQTSSourcerSetTimeScaleSelect #x50E)
(defconstant $kQTSSourcerGetTimeScaleSelect #x50F)
(defconstant $kQTSSourcerIdleSelect #x516)
; -----------------------------------------
;     Stream Sourcer Prototypes
; -----------------------------------------
; 
;  *  QTSSourcerInitialize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0.1 and later
;  

(deftrap-inline "_QTSSourcerInitialize" 
   ((inSourcer (:pointer :ComponentInstanceRecord))
    (inInitParams (:pointer :QTSSourcerInitParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :signed-long
() )
; 
;  *  QTSSourcerIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSSourcerIdle" 
   ((inSourcer (:pointer :ComponentInstanceRecord))
    (inTime (:pointer :TIMEVALUE64))
    (inFlags :SInt32)
    (outFlags (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTSSourcerSetEnable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSSourcerSetEnable" 
   ((inSourcer (:pointer :ComponentInstanceRecord))
    (inEnableMode :Boolean)
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTSSourcerGetEnable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSSourcerGetEnable" 
   ((inSourcer (:pointer :ComponentInstanceRecord))
    (outEnableMode (:pointer :Boolean))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTSSourcerSetTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSSourcerSetTimeScale" 
   ((inSourcer (:pointer :ComponentInstanceRecord))
    (inTimeScale :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTSSourcerGetTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSSourcerGetTimeScale" 
   ((inSourcer (:pointer :ComponentInstanceRecord))
    (outTimeScale (:pointer :TIMESCALE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTSSourcerSetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSSourcerSetInfo" 
   ((inSourcer (:pointer :ComponentInstanceRecord))
    (inSelector :OSType)
    (ioParams :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTSSourcerGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSSourcerGetInfo" 
   ((inSourcer (:pointer :ComponentInstanceRecord))
    (inSelector :OSType)
    (ioParams :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )

(defconstant $kQTSInfo_InputDeviceName :|innm|) ;  Handle* 

(defconstant $kQTSInfo_InputSourceName :|srnm|) ;  Handle* 

; ============================================================================
;         Stream Handler
; ============================================================================
; 
;     Server edits are only valid for the current chunk
; 
(defrecord SHServerEditParameters
   (version :UInt32)
   (editRate :signed-long)
   (dataStartTime_mediaAxis :TIMEVALUE64)
   (dataEndTime_mediaAxis :TIMEVALUE64)
)

;type name? (%define-record :SHServerEditParameters (find-record-descriptor ':SHServerEditParameters))

(defconstant $kSHNoChunkDispatchFlags 0)
(defconstant $kSHChunkFlagSyncSample 4)
(defconstant $kSHChunkFlagDataLoss 16)
(defconstant $kSHChunkFlagExtended 32)
(defrecord SHChunkRecord
   (version :UInt32)
   (reserved1 :signed-long)
   (flags :SInt32)
   (dataSize :UInt32)
   (dataPtr (:pointer :UInt8))
   (reserved2 :signed-long)
   (reserved3 :signed-long)
   (presentationTime :TIMEVALUE64)
   (reserved4 :signed-long)
   (reserved5 :signed-long)
   (serverEditParameters (:pointer :SHServerEditParameters))
   (reserved6 :signed-long)
   (reserved7 :signed-long)
)

;type name? (%define-record :SHChunkRecord (find-record-descriptor ':SHChunkRecord))

(defconstant $kSHNumExtendedDataLongs 10)

(defconstant $kSHExtendedChunkFlag_HasSampleCount 1)
(defconstant $kSHExtendedChunkFlag_HasFrameLengths 2)
(defrecord SHExtendedChunkRecord
   (chunk :SHChunkRecord)
   (extendedFlags :SInt32)
   (extendedData (:array :SInt32 10))
)

;type name? (%define-record :SHExtendedChunkRecord (find-record-descriptor ':SHExtendedChunkRecord))
; ============================================================================
;         RTP Components
; ============================================================================

(def-mactype :RTPSSRC (find-mactype ':UInt32))

(defconstant $kRTPInvalidSSRC 0)
;  RTP standard content encodings for audio 

(defconstant $kRTPPayload_PCMU 0)               ;  8kHz PCM mu-law mono 

(defconstant $kRTPPayload_1016 1)               ;  8kHz CELP (Fed Std 1016) mono 

(defconstant $kRTPPayload_G721 2)               ;  8kHz G.721 ADPCM mono 

(defconstant $kRTPPayload_GSM 3)                ;  8kHz GSM mono 

(defconstant $kRTPPayload_G723 4)               ;  8kHz G.723 ADPCM mono 

(defconstant $kRTPPayload_DVI_8 5)              ;  8kHz Intel DVI ADPCM mono 

(defconstant $kRTPPayload_DVI_16 6)             ;  16kHz Intel DVI ADPCM mono 

(defconstant $kRTPPayload_LPC 7)                ;  8kHz LPC 

(defconstant $kRTPPayload_PCMA 8)               ;  8kHz PCM a-law mono 

(defconstant $kRTPPayload_L16_44_2 10)          ;  44.1kHz 16-bit linear stereo 

(defconstant $kRTPPayload_L16_44_1 11)          ;  44.1kHz 16-bit linear mono 

(defconstant $kRTPPayload_PureVoice 12)         ;  8kHz PureVoice mono (QCELP) 

(defconstant $kRTPPayload_MPEGAUDIO 14)         ;  MPEG I and II audio 

(defconstant $kRTPPayload_DVI_11 16)            ;  11kHz Intel DVI ADPCM mono 

(defconstant $kRTPPayload_DVI_22 17)            ;  22kHz Intel DVI ADPCM mono 

;  RTP standard content encodings for video 

(defconstant $kRTPPayload_CELLB 25)             ;  Sun CellB 

(defconstant $kRTPPayload_JPEG 26)              ;  JPEG 

(defconstant $kRTPPayload_CUSEEME 27)           ;  Cornell CU-SeeMe 

(defconstant $kRTPPayload_NV 28)                ;  Xerox PARC nv 

(defconstant $kRTPPayload_PICWIN 29)            ;  BBN Picture Window 

(defconstant $kRTPPayload_CPV 30)               ;  Bolter CPV 

(defconstant $kRTPPayload_H261 31)              ;  CCITT H.261 

(defconstant $kRTPPayload_MPEGVIDEO 32)         ;  MPEG I and II video 

(defconstant $kRTPPayload_H263 34)              ;  CCITT H.263 

;  Other RTP standard content encodings 

(defconstant $kRTPPayload_MPEG2T 33)            ;  MPEG 2 Transport 

;  Dynamic encodings 

(defconstant $kRTPPayload_FirstDynamic 96)
(defconstant $kRTPPayload_LastDynamic 127)
(defconstant $kRTPPayload_Unknown #xFF)
; 
; -----------------------------------------
;     RTP Info selectors
; -----------------------------------------
; 
;  ----- these are get and set ----- 

(defconstant $kRTPInfo_SSRC :|ssrc|)            ;  UInt32* 

(defconstant $kRTPInfo_NextSeqNum :|rnsn|)      ;  UInt16* 

; -----------------------------------------
;     RTP Statistics
; -----------------------------------------

(defconstant $kRTPTotalReceivedPktsStat :|trcp|)
(defconstant $kRTPTotalLostPktsStat :|tlsp|)
(defconstant $kRTPTotalProcessedPktsStat :|tprp|)
(defconstant $kRTPTotalDroppedPktsStat :|tdrp|)
(defconstant $kRTPBadHeaderDroppedPktsStat :|bhdp|)
(defconstant $kRTPOurHeaderDroppedPktsStat :|ohdp|)
(defconstant $kRTPNotReceivingSenderDroppedPktsStat :|nsdp|)
(defconstant $kRTPNotProcessingDroppedPktsStat :|npdp|)
(defconstant $kRTPBadSeqDroppedPktsStat :|bsdp|)
(defconstant $kRTPArriveTooLatePktsStat :|artl|)
(defconstant $kRTPWaitForSeqDroppedPktsStat :|wsdp|)
(defconstant $kRTPBadStateDroppedPktsStat :|stdp|)
(defconstant $kRTPBadPayloadDroppedPktsStat :|bpdp|)
(defconstant $kRTPNoTimeScaleDroppedPktsStat :|ntdp|)
(defconstant $kRTPDupSeqNumDroppedPktsStat :|dsdp|)
(defconstant $kRTPLostPktsPercentStat :|lspp|)
(defconstant $kRTPDroppedPktsPercentStat :|dppp|)
(defconstant $kRTPTotalUnprocessedPktsPercentStat :|tupp|)
(defconstant $kRTPRTCPDataRateStat :|rrcd|)
(defconstant $kRTPPayloadIDStat :|rpid|)
(defconstant $kRTPPayloadNameStat :|rpnm|)
(defconstant $kRTPNumPktsInQueueStat :|rnpq|)
(defconstant $kRTPTotalPktsInQueueStat :|rtpq|)
(defconstant $kRTPTotalOutOfOrderPktsStat :|rtoo|)
(defconstant $kRTPRetransmissionStat :|rrtx|)
; -----------------------------------------
;     Payload Info
; -----------------------------------------

(defconstant $kRTPPayloadSpeedTag :|sped|)      ;  0-255, 255 is fastest

(defconstant $kRTPPayloadLossRecoveryTag :|loss|);  0-255, 0 can't handle any loss, 128 can handle 50% packet loss

(defconstant $kRTPPayloadConformanceTag :|conf|);  more than one of these can be present

(defrecord RTPPayloadCharacteristic
   (tag :OSType)
   (value :signed-long)
)

;type name? (%define-record :RTPPayloadCharacteristic (find-record-descriptor ':RTPPayloadCharacteristic))
; 
;     pass RTPPayloadSortRequest to QTSFindMediaPacketizer or QTSFindMediaPacketizerForTrack.
;     define the characteristics to sort by. tag is key to sort on. value is positive for ascending
;     sort (low value first), negative for descending sort (high value first).
; 
(defrecord RTPPayloadSortRequest
   (characteristicCount :signed-long)
   (characteristic (:array :RTPPayloadCharacteristic 1));  tag is key to sort on, value is + for ascending, - for descending
)

;type name? (%define-record :RTPPayloadSortRequest (find-record-descriptor ':RTPPayloadSortRequest))

(def-mactype :RTPPayloadSortRequestPtr (find-mactype '(:pointer :RTPPayloadSortRequest)))
;  flags for RTPPayloadInfo 

(defconstant $kRTPPayloadTypeStaticFlag 1)
(defconstant $kRTPPayloadTypeDynamicFlag 2)
(defrecord RTPPayloadInfo
   (payloadFlags :signed-long)
   (payloadID :UInt8)
   (reserved1 :character)
   (reserved2 :character)
   (reserved3 :character)
   (payloadName (:array :character 1))
)

;type name? (%define-record :RTPPayloadInfo (find-record-descriptor ':RTPPayloadInfo))

(def-mactype :RTPPayloadInfoPtr (find-mactype '(:pointer :RTPPayloadInfo)))

(def-mactype :RTPPayloadInfoHandle (find-mactype '(:handle :RTPPayloadInfo)))
; ============================================================================
;         RTP Reassembler
; ============================================================================

(def-mactype :RTPReassembler (find-mactype ':ComponentInstance))

(defconstant $kRTPReassemblerType :|rtpr|)

(defconstant $kRTPBaseReassemblerType :|gnrc|)
(defconstant $kRTP261ReassemblerType :|h261|)
(defconstant $kRTP263ReassemblerType :|h263|)
(defconstant $kRTP263PlusReassemblerType :|263+|)
(defconstant $kRTPAudioReassemblerType :|soun|)
(defconstant $kRTPQTReassemblerType :|qtim|)
(defconstant $kRTPPureVoiceReassemblerType :|Qclp|)
(defconstant $kRTPJPEGReassemblerType :|jpeg|)
(defconstant $kRTPQDesign2ReassemblerType :|QDM2|)
(defconstant $kRTPSorensonReassemblerType :|SVQ1|)
(defconstant $kRTPMP3ReassemblerType :|mp3 |)
(defconstant $kRTPMPEG4AudioReassemblerType :|mp4a|)
(defconstant $kRTPMPEG4VideoReassemblerType :|mp4v|)
(defconstant $kRTPAMRReassemblerType :|amr |)
(defrecord RTPRssmInitParams
   (ssrc :UInt32)
   (payloadType :UInt8)
   (reserved1 :UInt8)
   (reserved2 :UInt8)
   (reserved3 :UInt8)
   (timeBase (:pointer :TimeBaseRecord))
   (timeScale :signed-long)
)

;type name? (%define-record :RTPRssmInitParams (find-record-descriptor ':RTPRssmInitParams))
(defrecord RTPDescParams
   (container :Handle)
   (presentationParentAtom :signed-long)
   (streamParentAtom :signed-long)
)

;type name? (%define-record :RTPDescParams (find-record-descriptor ':RTPDescParams))
(defrecord RTPRssmMoreInitParams
   (initParams :RTPRssmInitParams)
   (version :SInt32)
   (desc :RTPDescParams)
)

;type name? (%define-record :RTPRssmMoreInitParams (find-record-descriptor ':RTPRssmMoreInitParams))

(defconstant $kRTPRssmMoreInitParamsVersion1 1)
;  get/set info selectors

(defconstant $kRTPRssmInfo_MoreInitParams :|rrmi|)
(defrecord RTPRssmPacket
   (next (:pointer :rtprssmpacket))
   (prev (:pointer :rtprssmpacket))
   (streamBuffer (:pointer :QTSStreamBuffer))
   (paramsFilledIn :Boolean)
   (reserved :UInt8)
   (sequenceNum :UInt16)
   (transportHeaderLength :UInt32)              ;  filled in by base
   (payloadHeaderLength :UInt32)                ;  derived adjusts this 
   (dataLength :UInt32)
   (serverEditParams :SHServerEditParameters)
   (timeStamp :TIMEVALUE64)                     ;  lower 32 bits is original rtp timestamp
   (chunkFlags :SInt32)                         ;  these are or'd together
   (flags :SInt32)
)

;type name? (%define-record :RTPRssmPacket (find-record-descriptor ':RTPRssmPacket))
;  flags for RTPRssmPacket struct

(defconstant $kRTPRssmPacketHasMarkerBitSet 1)
(defconstant $kRTPRssmPacketHasServerEditFlag #x10000)
;  flags for RTPRssmSendStreamBufferRange

(defconstant $kRTPRssmCanRefStreamBuffer 1)
;  flags for RTPRssmSendPacketList

(defconstant $kRTPRssmLostSomePackets 1)
;  flags for RTPRssmSetFlags

(defconstant $kRTPRssmEveryPacketAChunkFlag 1)
(defconstant $kRTPRssmQueueAndUseMarkerBitFlag 2)
(defconstant $kRTPRssmTrackLostPacketsFlag #x10000)
(defconstant $kRTPRssmNoReorderingRequiredFlag #x20000)
(defrecord RTPSendStreamBufferRangeParams
   (streamBuffer (:pointer :QTSStreamBuffer))
   (presentationTime :TIMEVALUE64)
   (chunkStartPosition :UInt32)
   (numDataBytes :UInt32)
   (chunkFlags :SInt32)
   (flags :SInt32)
   (serverEditParams (:pointer :SHServerEditParameters));  NULL if no edit
)

;type name? (%define-record :RTPSendStreamBufferRangeParams (find-record-descriptor ':RTPSendStreamBufferRangeParams))
;  characteristics

(defconstant $kRTPCharacteristic_RequiresOrderedPackets :|rrop|)
(defconstant $kRTPCharacteristic_TimeStampsNotMonoIncreasing :|tsmi|)

(defconstant $kRTPReassemblerInfoResType :|rsmi|)
(defrecord RTPReassemblerInfo
   (characteristicCount :signed-long)
   (characteristic (:array :RTPPayloadCharacteristic 1))
                                                ;  after the last characteristic, the payload name (defined by the MediaPacketizerPayloadInfo
                                                ;  structure) is present. 
)

;type name? (%define-record :RTPReassemblerInfo (find-record-descriptor ':RTPReassemblerInfo))

(def-mactype :RTPReassemblerInfoPtr (find-mactype '(:pointer :RTPReassemblerInfo)))

(def-mactype :RTPReassemblerInfoHandle (find-mactype '(:handle :RTPReassemblerInfo)))
; #define RTPReassemblerInfoToPayloadInfo(_rsmi) ((RTPPayloadInfoPtr)(&((_rsmi)->characteristic[(_rsmi)->characteristicCount])))
;  RTPReassemblerInfoElement structs are padded to 32 bits 

(defconstant $kRTPReassemblerInfoPadUpToBytes 4)
; 
;  *  QTSFindReassemblerForPayloadID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSFindReassemblerForPayloadID" 
   ((inPayloadID :UInt8)
    (inSortInfo (:pointer :RTPPayloadSortRequest))
    (outReassemblerList (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSFindReassemblerForPayloadName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSFindReassemblerForPayloadName" 
   ((inPayloadName (:pointer :char))
    (inSortInfo (:pointer :RTPPayloadSortRequest))
    (outReassemblerList (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; -----------------------------------------
;     RTP Reassembler Selectors
; -----------------------------------------

(defconstant $kRTPRssmSetCapabilitiesSelect #x100)
(defconstant $kRTPRssmGetCapabilitiesSelect #x101)
(defconstant $kRTPRssmSetPayloadHeaderLengthSelect #x102)
(defconstant $kRTPRssmGetPayloadHeaderLengthSelect #x103)
(defconstant $kRTPRssmSetTimeScaleSelect #x104)
(defconstant $kRTPRssmGetTimeScaleSelect #x105)
(defconstant $kRTPRssmNewStreamHandlerSelect #x106)
(defconstant $kRTPRssmSetStreamHandlerSelect #x107)
(defconstant $kRTPRssmGetStreamHandlerSelect #x108)
(defconstant $kRTPRssmSendStreamHandlerChangedSelect #x109)
(defconstant $kRTPRssmSetSampleDescriptionSelect #x10A)
(defconstant $kRTPRssmGetChunkAndIncrRefCountSelect #x10D)
(defconstant $kRTPRssmSendChunkAndDecrRefCountSelect #x10E)
(defconstant $kRTPRssmSendLostChunkSelect #x10F)
(defconstant $kRTPRssmSendStreamBufferRangeSelect #x110)
(defconstant $kRTPRssmClearCachedPackets #x111)
(defconstant $kRTPRssmFillPacketListParamsSelect #x113)
(defconstant $kRTPRssmReleasePacketListSelect #x114)
(defconstant $kRTPRssmIncrChunkRefCountSelect #x115)
(defconstant $kRTPRssmDecrChunkRefCountSelect #x116)
(defconstant $kRTPRssmGetExtChunkAndIncrRefCountSelect #x117)
(defconstant $kRTPRssmInitializeSelect #x500)
(defconstant $kRTPRssmHandleNewPacketSelect #x501)
(defconstant $kRTPRssmComputeChunkSizeSelect #x502)
(defconstant $kRTPRssmAdjustPacketParamsSelect #x503)
(defconstant $kRTPRssmCopyDataToChunkSelect #x504)
(defconstant $kRTPRssmSendPacketListSelect #x505)
(defconstant $kRTPRssmGetTimeScaleFromPacketSelect #x506)
(defconstant $kRTPRssmSetInfoSelect #x509)
(defconstant $kRTPRssmGetInfoSelect #x50A)
(defconstant $kRTPRssmHasCharacteristicSelect #x50B)
(defconstant $kRTPRssmResetSelect #x50C)
; -----------------------------------------
;     RTP Reassembler functions - base to derived
; -----------------------------------------
; 
;  *  RTPRssmInitialize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmInitialize" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inInitParams (:pointer :RTPRssmInitParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmHandleNewPacket()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmHandleNewPacket" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inStreamBuffer (:pointer :QTSStreamBuffer))
    (inNumWraparounds :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmComputeChunkSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmComputeChunkSize" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inPacketListHead (:pointer :RTPRssmPacket))
    (inFlags :SInt32)
    (outChunkDataSize (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmAdjustPacketParams()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmAdjustPacketParams" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inPacket (:pointer :RTPRssmPacket))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmCopyDataToChunk()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmCopyDataToChunk" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inPacketListHead (:pointer :RTPRssmPacket))
    (inMaxChunkDataSize :UInt32)
    (inChunk (:pointer :SHChunkRecord))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmSendPacketList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmSendPacketList" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inPacketListHead (:pointer :RTPRssmPacket))
    (inLastChunkPresentationTime (:pointer :TIMEVALUE64))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmGetTimeScaleFromPacket()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmGetTimeScaleFromPacket" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inStreamBuffer (:pointer :QTSStreamBuffer))
    (outTimeScale (:pointer :TIMESCALE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmSetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmSetInfo" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inSelector :OSType)
    (ioParams :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmGetInfo" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inSelector :OSType)
    (ioParams :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmHasCharacteristic()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmHasCharacteristic" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inCharacteristic :OSType)
    (outHasIt (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmReset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmReset" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; -----------------------------------------
;     RTP Reassembler functions - derived to base
; -----------------------------------------
;  ----- setup
; 
;  *  RTPRssmSetCapabilities()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmSetCapabilities" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (inFlagsMask :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmGetCapabilities()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmGetCapabilities" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (outFlags (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmSetPayloadHeaderLength()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmSetPayloadHeaderLength" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inPayloadHeaderLength :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmGetPayloadHeaderLength()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmGetPayloadHeaderLength" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (outPayloadHeaderLength (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmSetTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmSetTimeScale" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inSHTimeScale :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmGetTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmGetTimeScale" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (outSHTimeScale (:pointer :TIMESCALE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmNewStreamHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmNewStreamHandler" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inSHType :OSType)
    (inSampleDescription (:Handle :SampleDescription))
    (inSHTimeScale :signed-long)
    (outHandler (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmSetStreamHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmSetStreamHandler" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inStreamHandler (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmGetStreamHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmGetStreamHandler" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (outStreamHandler (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmSendStreamHandlerChanged()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmSendStreamHandlerChanged" 
   ((rtpr (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmSetSampleDescription()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmSetSampleDescription" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inSampleDescription (:Handle :SampleDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  ----- manually sending chunks
; 
;  *  RTPRssmGetChunkAndIncrRefCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmGetChunkAndIncrRefCount" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inChunkDataSize :UInt32)
    (inChunkPresentationTime (:pointer :TIMEVALUE64))
    (outChunk (:pointer :SHChunkRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmGetExtChunkAndIncrRefCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QTStreamLib 6.0 and later
;  *    Windows:          in qtmlClient.lib 6.0 and later
;  

(deftrap-inline "_RTPRssmGetExtChunkAndIncrRefCount" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inChunkDataSize :UInt32)
    (inChunkPresentationTime (:pointer :TIMEVALUE64))
    (inFlags :SInt32)
    (outChunk (:pointer :SHExtendedChunkRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmSendChunkAndDecrRefCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmSendChunkAndDecrRefCount" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inChunk (:pointer :SHChunkRecord))
    (inServerEdit (:pointer :SHServerEditParameters))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmSendLostChunk()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmSendLostChunk" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inChunkPresentationTime (:pointer :TIMEVALUE64))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmSendStreamBufferRange()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmSendStreamBufferRange" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inParams (:pointer :RTPSendStreamBufferRangeParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmClearCachedPackets()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmClearCachedPackets" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmFillPacketListParams()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmFillPacketListParams" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inPacketListHead (:pointer :RTPRssmPacket))
    (inNumWraparounds :SInt32)
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmReleasePacketList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmReleasePacketList" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inPacketListHead (:pointer :RTPRssmPacket))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmIncrChunkRefCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmIncrChunkRefCount" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inChunk (:pointer :SHChunkRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPRssmDecrChunkRefCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPRssmDecrChunkRefCount" 
   ((rtpr (:pointer :ComponentInstanceRecord))
    (inChunk (:pointer :SHChunkRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; ============================================================================
;         RTP Media Packetizer
; ============================================================================

(defconstant $kRTPMediaPacketizerType :|rtpm|)

(def-mactype :RTPMediaPacketizer (find-mactype ':ComponentInstance))

(defconstant $kRTPBaseMediaPacketizerType :|gnrc|)
(defconstant $kRTP261MediaPacketizerType :|h261|)
(defconstant $kRTP263PlusMediaPacketizerType :|263+|)
(defconstant $kRTPAudioMediaPacketizerType :|soun|)
(defconstant $kRTPQTMediaPacketizerType :|qtim|)
(defconstant $kRTPPureVoiceMediaPacketizerType :|Qclp|)
(defconstant $kRTPJPEGMediaPacketizerType :|jpeg|)
(defconstant $kRTPQDesign2MediaPacketizerType :|QDM2|)
(defconstant $kRTPSorensonMediaPacketizerType :|SVQ1|)
(defconstant $kRTPMP3MediaPacketizerType :|mp3 |)
(defconstant $kRTPMPEG4AudioMediaPacketizerType :|mp4a|)
(defconstant $kRTPMPEG4VideoMediaPacketizerType :|mp4v|)
(defconstant $kRTPAMRMediaPacketizerType :|amr |)

(def-mactype :RTPMPSampleRef (find-mactype ':UInt32))

(def-mactype :RTPMPDataReleaseProcPtr (find-mactype ':pointer)); (UInt8 * inData , void * inRefCon)

(def-mactype :RTPMPDataReleaseUPP (find-mactype '(:pointer :OpaqueRTPMPDataReleaseProcPtr)))

(defconstant $kMediaPacketizerCanPackEditRate 1)
(defconstant $kMediaPacketizerCanPackLayer 2)
(defconstant $kMediaPacketizerCanPackVolume 4)
(defconstant $kMediaPacketizerCanPackBalance 8)
(defconstant $kMediaPacketizerCanPackGraphicsMode 16)
(defconstant $kMediaPacketizerCanPackEmptyEdit 32)
(defrecord MediaPacketizerRequirements
   (mediaType :OSType)                          ;  media type supported (0 for all)
   (dataFormat :OSType)                         ;  data format (e.g., compression) supported (0 for all)
   (capabilityFlags :UInt32)                    ;  ability to handle non-standard track characteristics
   (canPackMatrixType :UInt8)                   ;  can pack any matrix type up to this (identityMatrixType for identity only)
   (reserved1 :UInt8)
   (reserved2 :UInt8)
   (reserved3 :UInt8)
)

;type name? (%define-record :MediaPacketizerRequirements (find-record-descriptor ':MediaPacketizerRequirements))

(def-mactype :MediaPacketizerRequirementsPtr (find-mactype '(:pointer :MediaPacketizerRequirements)))
(defrecord MediaPacketizerInfo
   (mediaType :OSType)                          ;  media type supported (0 for all)
   (dataFormat :OSType)                         ;  data format (e.g., compression) supported (0 for all)
   (vendor :OSType)                             ;  manufacturer of this packetizer (e.g., 'appl' for Apple)
   (capabilityFlags :UInt32)                    ;  ability to handle non-standard track characteristics
   (canPackMatrixType :UInt8)                   ;  can pack any matrix type up to this (identityMatrixType for identity only)
   (reserved1 :UInt8)
   (reserved2 :UInt8)
   (reserved3 :UInt8)
   (characteristicCount :signed-long)
   (characteristic (:array :RTPPayloadCharacteristic 1))
                                                ;  after the last characteristic, the payload name (defined by the RTPPayloadInfo
                                                ;  structure) is present. 
)

;type name? (%define-record :MediaPacketizerInfo (find-record-descriptor ':MediaPacketizerInfo))

(def-mactype :MediaPacketizerInfoPtr (find-mactype '(:pointer :MediaPacketizerInfo)))

(def-mactype :MediaPacketizerInfoHandle (find-mactype '(:handle :MediaPacketizerInfo)))
; #define MediaPacketizerInfoToPayloadInfo(_mpi) ((RTPPayloadInfoPtr)(&((_mpi)->characteristic[(_mpi)->characteristicCount])))
;  MediaPacketizerInfo structs are padded to 32 bits 

(defconstant $kMediaPacketizerInfoPadUpToBytes 4)

(defconstant $kRTPMediaPacketizerInfoRezType :|pcki|)
; 
;  *  QTSFindMediaPacketizer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSFindMediaPacketizer" 
   ((inPacketizerinfo (:pointer :MediaPacketizerRequirements))
    (inSampleDescription (:Handle :SampleDescription))
    (inSortInfo (:pointer :RTPPayloadSortRequest))
    (outPacketizerList (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSFindMediaPacketizerForTrack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSFindMediaPacketizerForTrack" 
   ((inTrack (:Handle :TrackType))
    (inSampleDescriptionIndex :signed-long)
    (inSortInfo (:pointer :RTPPayloadSortRequest))
    (outPacketizerList (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSFindMediaPacketizerForPayloadID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSFindMediaPacketizerForPayloadID" 
   ((payloadID :signed-long)
    (inSortInfo (:pointer :RTPPayloadSortRequest))
    (outPacketizerList (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSFindMediaPacketizerForPayloadName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSFindMediaPacketizerForPayloadName" 
   ((payloadName (:pointer :char))
    (inSortInfo (:pointer :RTPPayloadSortRequest))
    (outPacketizerList (:pointer :QTATOMCONTAINER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  flags for RTPMPInitialize

(defconstant $kRTPMPRealtimeModeFlag 1)
;  flags for RTPMPSampleDataParams

(defconstant $kRTPMPSyncSampleFlag 1)
(defconstant $kRTPMPRespectDurationFlag 2)
(defrecord RTPMPSampleDataParams
   (version :UInt32)
   (timeStamp :UInt32)
   (duration :UInt32)                           ;  0 = unknown duration
   (playOffset :UInt32)
   (playRate :signed-long)
   (flags :SInt32)
   (sampleDescSeed :UInt32)
   (sampleDescription :Handle)
   (sampleRef :UInt32)
   (dataLength :UInt32)
   (data (:pointer :UInt8))
   (releaseProc (:pointer :OpaqueRTPMPDataReleaseProcPtr))
   (refCon :pointer)
)

;type name? (%define-record :RTPMPSampleDataParams (find-record-descriptor ':RTPMPSampleDataParams))
;  out flags for idle, RTPMPSetSampleData, and RTPMPFlush

(defconstant $kRTPMPStillProcessingData 1)      ;  not done with data you've got

(defrecord RTPMPPayloadTypeParams
   (flags :UInt32)
   (payloadNumber :UInt32)
   (nameLength :SInt16)                         ;  in: size of payloadName buffer (counting null terminator) -- this will be reset to needed length and paramErr returned if too small 
   (payloadName (:pointer :char))               ;  caller must provide buffer 
)

;type name? (%define-record :RTPMPPayloadTypeParams (find-record-descriptor ':RTPMPPayloadTypeParams))
; -----------------------------------------
;     RTP Media Packetizer Info selectors
; -----------------------------------------
;  info selectors - get only 

(defconstant $kRTPMPPayloadTypeInfo :|rtpp|)    ;  RTPMPPayloadTypeParams* 

(defconstant $kRTPMPRTPTimeScaleInfo :|rtpt|)   ;  TimeScale* 

(defconstant $kRTPMPRequiredSampleDescriptionInfo :|sdsc|);  SampleDescriptionHandle* 

(defconstant $kRTPMPMinPayloadSize :|mins|)     ;  UInt32* in bytes, does not include rtp header; default is 0 

(defconstant $kRTPMPMinPacketDuration :|mind|)  ;  UInt3* in milliseconds; default is no min required 

(defconstant $kRTPMPSuggestedRepeatPktCountInfo :|srpc|);  UInt32* 

(defconstant $kRTPMPSuggestedRepeatPktSpacingInfo :|srps|);  UInt32* in milliseconds 

(defconstant $kRTPMPMaxPartialSampleSizeInfo :|mpss|);  UInt32* in bytes 

(defconstant $kRTPMPPreferredBufferDelayInfo :|prbd|);  UInt32* in milliseconds 

(defconstant $kRTPMPPayloadNameInfo :|name|)    ;  StringPtr 

(defconstant $kRTPInfo_FormatString :|fmtp|)    ;  char **, caller allocates ptr, callee disposes 

; -----------------------------------------
;     RTP Media Packetizer Characteristics
; -----------------------------------------
;  also supports relevant ones in Movies.h and QTSToolbox.h 

(defconstant $kRTPMPNoSampleDataRequiredCharacteristic :|nsdr|)
(defconstant $kRTPMPHasUserSettingsDialogCharacteristic :|sdlg|)
(defconstant $kRTPMPPrefersReliableTransportCharacteristic :|rely|)
(defconstant $kRTPMPRequiresOutOfBandDimensionsCharacteristic :|robd|)
(defconstant $kRTPMPReadsPartialSamplesCharacteristic :|rpsp|)
; -----------------------------------------
;     RTP Media Packetizer selectors
; -----------------------------------------

(defconstant $kRTPMPInitializeSelect #x500)
(defconstant $kRTPMPPreflightMediaSelect #x501)
(defconstant $kRTPMPIdleSelect #x502)
(defconstant $kRTPMPSetSampleDataSelect #x503)
(defconstant $kRTPMPFlushSelect #x504)
(defconstant $kRTPMPResetSelect #x505)
(defconstant $kRTPMPSetInfoSelect #x506)
(defconstant $kRTPMPGetInfoSelect #x507)
(defconstant $kRTPMPSetTimeScaleSelect #x508)
(defconstant $kRTPMPGetTimeScaleSelect #x509)
(defconstant $kRTPMPSetTimeBaseSelect #x50A)
(defconstant $kRTPMPGetTimeBaseSelect #x50B)
(defconstant $kRTPMPHasCharacteristicSelect #x50C)
(defconstant $kRTPMPSetPacketBuilderSelect #x50E)
(defconstant $kRTPMPGetPacketBuilderSelect #x50F)
(defconstant $kRTPMPSetMediaTypeSelect #x510)
(defconstant $kRTPMPGetMediaTypeSelect #x511)
(defconstant $kRTPMPSetMaxPacketSizeSelect #x512)
(defconstant $kRTPMPGetMaxPacketSizeSelect #x513)
(defconstant $kRTPMPSetMaxPacketDurationSelect #x514)
(defconstant $kRTPMPGetMaxPacketDurationSelect #x515);  for export component and apps who want to
;  access dialogs for Media-specific settings
;  (such as Pure Voice interleave factor)

(defconstant $kRTPMPDoUserDialogSelect #x516)
(defconstant $kRTPMPSetSettingsFromAtomContainerAtAtomSelect #x517)
(defconstant $kRTPMPGetSettingsIntoAtomContainerAtAtomSelect #x518)
(defconstant $kRTPMPGetSettingsAsTextSelect #x519)
(defconstant $kRTPMPGetSettingsSelect #x51C)
(defconstant $kRTPMPSetSettingsSelect #x51D)
; -----------------------------------------
;     RTP Media Packetizer functions
; -----------------------------------------
; 
;  *  RTPMPInitialize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPInitialize" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  return noErr if you can handle this media 
; 
;  *  RTPMPPreflightMedia()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPPreflightMedia" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inMediaType :OSType)
    (inSampleDescription (:Handle :SampleDescription))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;    do work here if you need to - give up time periodically
;    if you're doing time consuming operations
; 
; 
;  *  RTPMPIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPIdle" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (outFlags (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;    caller owns the RTPMPSampleDataParams struct
;    media Packetizer must copy any fields of the struct it wants to keep
;    media Packetizer must call release proc when done with the data
;    you can do the processing work here if it does not take up too
;    much cpu time - otherwise do it in idle
; 
; 
;  *  RTPMPSetSampleData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPSetSampleData" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inSampleData (:pointer :RTPMPSampleDataParams))
    (outFlags (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;    send everything you have buffered - you will get idles while
;    you set the kRTPMPStillProcessingData flag here and in idle
; 
; 
;  *  RTPMPFlush()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPFlush" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (outFlags (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;    dispose of anything buffered and get rid of state
;    do not send the buffered data (because presumably
;    there is no connection for you to send on)
;    state should be the same as if you were just initialized
; 
; 
;  *  RTPMPReset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPReset" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; -----------------------------------------
;     RTP Media Packetizer get / set functions
; -----------------------------------------
; 
;  *  RTPMPSetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPSetInfo" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inSelector :OSType)
    (ioParams :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPGetInfo" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inSelector :OSType)
    (ioParams :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPSetTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPSetTimeScale" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inTimeScale :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPGetTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPGetTimeScale" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (outTimeScale (:pointer :TIMESCALE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPSetTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPSetTimeBase" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inTimeBase (:pointer :TimeBaseRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPGetTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPGetTimeBase" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (outTimeBase (:pointer :TIMEBASE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPHasCharacteristic()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPHasCharacteristic" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inSelector :OSType)
    (outHasIt (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPSetPacketBuilder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPSetPacketBuilder" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inPacketBuilder (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPGetPacketBuilder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPGetPacketBuilder" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (outPacketBuilder (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPSetMediaType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPSetMediaType" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inMediaType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPGetMediaType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPGetMediaType" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (outMediaType (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  size is in bytes
; 
;  *  RTPMPSetMaxPacketSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPSetMaxPacketSize" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inMaxPacketSize :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPGetMaxPacketSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPGetMaxPacketSize" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (outMaxPacketSize (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  duration is in milliseconds
; 
;  *  RTPMPSetMaxPacketDuration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPSetMaxPacketDuration" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inMaxPacketDuration :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPGetMaxPacketDuration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPGetMaxPacketDuration" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (outMaxPacketDuration (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPDoUserDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPDoUserDialog" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inFilterUPP (:pointer :OpaqueModalFilterProcPtr))
    (canceled (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPSetSettingsFromAtomContainerAtAtom()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPSetSettingsFromAtomContainerAtAtom" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inContainer :Handle)
    (inParentAtom :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPGetSettingsIntoAtomContainerAtAtom()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPGetSettingsIntoAtomContainerAtAtom" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inOutContainer :Handle)
    (inParentAtom :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPGetSettingsAsText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPMPGetSettingsAsText" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (text (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPGetSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  *    Windows:          in QTSClient.lib 5.0 and later
;  

(deftrap-inline "_RTPMPGetSettings" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (outSettings (:pointer :QTATOMCONTAINER))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPMPSetSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  *    Windows:          in QTSClient.lib 5.0 and later
;  

(deftrap-inline "_RTPMPSetSettings" 
   ((rtpm (:pointer :ComponentInstanceRecord))
    (inSettings (:pointer :QTAtomSpec))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; ============================================================================
;         RTP Packet Builder
; ============================================================================

(defconstant $kRTPPacketBuilderType :|rtpb|)

(def-mactype :RTPPacketBuilder (find-mactype ':ComponentInstance))

(def-mactype :RTPPacketGroupRef (find-mactype '(:pointer :OpaqueRTPPacketGroupRef)))

(def-mactype :RTPPacketRef (find-mactype '(:pointer :OpaqueRTPPacketRef)))

(def-mactype :RTPPacketRepeatedDataRef (find-mactype '(:pointer :OpaqueRTPPacketRepeatedDataRef)))
;  flags for RTPPBBegin/EndPacket, RTPPBBegin/EndPacketGroup

(defconstant $kRTPPBSetMarkerFlag 1)
(defconstant $kRTPPBRepeatPacketFlag 2)
(defconstant $kRTPPBSyncSampleFlag #x10000)
(defconstant $kRTPPBBFrameFlag #x20000)
(defconstant $kRTPPBDontSendFlag #x10000000)    ;  when set in EndPacketGroup, will not add group


(defconstant $kRTPPBUnknownPacketMediaDataLength 0)
;  flags for RTPPBGetSampleData

(defconstant $kRTPPBEndOfDataFlag 1)

(def-mactype :RTPPBCallbackProcPtr (find-mactype ':pointer)); (OSType inSelector , void * ioParams , void * inRefCon)

(def-mactype :RTPPBCallbackUPP (find-mactype '(:pointer :OpaqueRTPPBCallbackProcPtr)))
; -----------------------------------------
;     RTP Packet Builder selectors
; -----------------------------------------

(defconstant $kRTPPBBeginPacketGroupSelect #x500)
(defconstant $kRTPPBEndPacketGroupSelect #x501)
(defconstant $kRTPPBBeginPacketSelect #x502)
(defconstant $kRTPPBEndPacketSelect #x503)
(defconstant $kRTPPBAddPacketLiteralDataSelect #x504)
(defconstant $kRTPPBAddPacketSampleDataSelect #x505)
(defconstant $kRTPPBAddPacketRepeatedDataSelect #x506)
(defconstant $kRTPPBReleaseRepeatedDataSelect #x507)
(defconstant $kRTPPBSetPacketSequenceNumberSelect #x508)
(defconstant $kRTPPBGetPacketSequenceNumberSelect #x509)
(defconstant $kRTPPBSetCallbackSelect #x50A)
(defconstant $kRTPPBGetCallbackSelect #x50B)
(defconstant $kRTPPBSetInfoSelect #x50C)
(defconstant $kRTPPBGetInfoSelect #x50D)
(defconstant $kRTPPBSetPacketTimeStampOffsetSelect #x50E)
(defconstant $kRTPPBGetPacketTimeStampOffsetSelect #x50F)
(defconstant $kRTPPBAddPacketSampleData64Select #x510)
(defconstant $kRTPPBGetSampleDataSelect #x511)
(defconstant $kRTPPBAddRepeatPacketSelect #x512)
; -----------------------------------------
;     RTP Packet Builder functions
; -----------------------------------------
; 
;  *  RTPPBBeginPacketGroup()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPPBBeginPacketGroup" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (inTimeStamp :UInt32)
    (outPacketGroup (:pointer :RTPPACKETGROUPREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPPBEndPacketGroup()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPPBEndPacketGroup" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (inPacketGroup (:pointer :OpaqueRTPPacketGroupRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPPBBeginPacket()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPPBBeginPacket" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (inPacketGroup (:pointer :OpaqueRTPPacketGroupRef))
    (inPacketMediaDataLength :UInt32)
    (outPacket (:pointer :RTPPACKETREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPPBEndPacket()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPPBEndPacket" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (inPacketGroup (:pointer :OpaqueRTPPacketGroupRef))
    (inPacket (:pointer :OpaqueRTPPacketRef))
    (inTransmissionTimeOffset :UInt32)
    (inDuration :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;    non-NULL RTPPacketRepeatedDataRef means this data will be repeated later
;    pb must return a repeated data ref
; 
; 
;  *  RTPPBAddPacketLiteralData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPPBAddPacketLiteralData" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (inPacketGroup (:pointer :OpaqueRTPPacketGroupRef))
    (inPacket (:pointer :OpaqueRTPPacketRef))
    (inData (:pointer :UInt8))
    (inDataLength :UInt32)
    (outDataRef (:pointer :RTPPACKETREPEATEDDATAREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;    non-NULL RTPPacketRepeatedDataRef means this data will be repeated later
;    pb must return a repeated data ref
; 
; 
;  *  RTPPBAddPacketSampleData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPPBAddPacketSampleData" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (inPacketGroup (:pointer :OpaqueRTPPacketGroupRef))
    (inPacket (:pointer :OpaqueRTPPacketRef))
    (inSampleDataParams (:pointer :RTPMPSampleDataParams))
    (inSampleOffset :UInt32)
    (inSampleDataLength :UInt32)
    (outDataRef (:pointer :RTPPACKETREPEATEDDATAREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;    non-NULL RTPPacketRepeatedDataRef means this data will be repeated later
;    pb must return a repeated data ref
; 
; 
;  *  RTPPBAddPacketSampleData64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  *    Windows:          in QTSClient.lib 5.0 and later
;  

(deftrap-inline "_RTPPBAddPacketSampleData64" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (inPacketGroup (:pointer :OpaqueRTPPacketGroupRef))
    (inPacket (:pointer :OpaqueRTPPacketRef))
    (inSampleDataParams (:pointer :RTPMPSampleDataParams))
    (inSampleOffset (:pointer :UInt64))
    (inSampleDataLength :UInt32)
    (outDataRef (:pointer :RTPPACKETREPEATEDDATAREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;    call to add the repeated data using the ref you got from
;    RTPPBAddPacketLiteralData or RTPPBAddPacketSampleData
; 
; 
;  *  RTPPBAddPacketRepeatedData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPPBAddPacketRepeatedData" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (inPacketGroup (:pointer :OpaqueRTPPacketGroupRef))
    (inPacket (:pointer :OpaqueRTPPacketRef))
    (inDataRef (:pointer :OpaqueRTPPacketRepeatedDataRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  call when done with repeated data
; 
;  *  RTPPBReleaseRepeatedData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPPBReleaseRepeatedData" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inDataRef (:pointer :OpaqueRTPPacketRepeatedDataRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;    seq number is just relative seq number
;    don't call if you don't care when seq # is used
; 
; 
;  *  RTPPBSetPacketSequenceNumber()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPPBSetPacketSequenceNumber" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (inPacketGroup (:pointer :OpaqueRTPPacketGroupRef))
    (inPacket (:pointer :OpaqueRTPPacketRef))
    (inSequenceNumber :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPPBGetPacketSequenceNumber()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPPBGetPacketSequenceNumber" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (inPacketGroup (:pointer :OpaqueRTPPacketGroupRef))
    (inPacket (:pointer :OpaqueRTPPacketRef))
    (outSequenceNumber (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPPBSetPacketTimeStampOffset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  *    Windows:          in QTSClient.lib 5.0 and later
;  

(deftrap-inline "_RTPPBSetPacketTimeStampOffset" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (inPacketGroup (:pointer :OpaqueRTPPacketGroupRef))
    (inPacket (:pointer :OpaqueRTPPacketRef))
    (inTimeStampOffset :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPPBGetPacketTimeStampOffset()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  *    Windows:          in QTSClient.lib 5.0 and later
;  

(deftrap-inline "_RTPPBGetPacketTimeStampOffset" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (inPacketGroup (:pointer :OpaqueRTPPacketGroupRef))
    (inPacket (:pointer :OpaqueRTPPacketRef))
    (outTimeStampOffset (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPPBAddRepeatPacket()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  *    Windows:          in QTSClient.lib 5.0 and later
;  

(deftrap-inline "_RTPPBAddRepeatPacket" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
    (inPacketGroup (:pointer :OpaqueRTPPacketGroupRef))
    (inPacket (:pointer :OpaqueRTPPacketRef))
    (inTransmissionOffset :signed-long)
    (inSequenceNumber :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;    used for communicating with the caller of the media packetizers if needed
;    NOT used for communicating with the media packetizers themselves
; 
; 
;  *  RTPPBSetCallback()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPPBSetCallback" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inCallback (:pointer :OpaqueRTPPBCallbackProcPtr))
    (inRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPPBGetCallback()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPPBGetCallback" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (outCallback (:pointer :RTPPBCALLBACKUPP))
    (outRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPPBSetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPPBSetInfo" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inSelector :OSType)
    (ioParams :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPPBGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_RTPPBGetInfo" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inSelector :OSType)
    (ioParams :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  RTPPBGetSampleData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  *    Windows:          in QTSClient.lib 5.0 and later
;  

(deftrap-inline "_RTPPBGetSampleData" 
   ((rtpb (:pointer :ComponentInstanceRecord))
    (inParams (:pointer :RTPMPSampleDataParams))
    (inStartOffset (:pointer :UInt64))
    (outDataBuffer (:pointer :UInt8))
    (inBytesToRead :UInt32)
    (outBytesRead (:pointer :UInt32))
    (outFlags (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  UPP call backs 
; 
;  *  NewRTPMPDataReleaseUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewRTPMPDataReleaseUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRTPMPDataReleaseProcPtr)
() )
; 
;  *  NewRTPPBCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewRTPPBCallbackUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRTPPBCallbackProcPtr)
() )
; 
;  *  DisposeRTPMPDataReleaseUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeRTPMPDataReleaseUPP" 
   ((userUPP (:pointer :OpaqueRTPMPDataReleaseProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeRTPPBCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeRTPPBCallbackUPP" 
   ((userUPP (:pointer :OpaqueRTPPBCallbackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeRTPMPDataReleaseUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeRTPMPDataReleaseUPP" 
   ((inData (:pointer :UInt8))
    (inRefCon :pointer)
    (userUPP (:pointer :OpaqueRTPMPDataReleaseProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeRTPPBCallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeRTPPBCallbackUPP" 
   ((inSelector :OSType)
    (ioParams :pointer)
    (inRefCon :pointer)
    (userUPP (:pointer :OpaqueRTPPBCallbackProcPtr))
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

; #endif /* __QTSTREAMINGCOMPONENTS__ */


(provide-interface "QTStreamingComponents")