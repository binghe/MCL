(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:QuickTimeStreaming.h"
; at Sunday July 2,2006 7:31:20 pm.
; 
;      File:       QuickTime/QuickTimeStreaming.h
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
; #ifndef __QUICKTIMESTREAMING__
; #define __QUICKTIMESTREAMING__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __MOVIES__
#| #|
#include <QuickTimeMovies.h>
#endif
|#
 |#
; #ifndef __QUICKTIMECOMPONENTS__
#| #|
#include <QuickTimeQuickTimeComponents.h>
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

(defconstant $kQTSInfiniteDuration #x7FFFFFFF)
(defconstant $kQTSUnknownDuration 0)
(defconstant $kQTSNormalForwardRate #x10000)
(defconstant $kQTSStoppedRate 0)
(defrecord QTSPresentationRecord
   (data (:array :signed-long 1))
)

;type name? (%define-record :QTSPresentationRecord (find-record-descriptor ':QTSPresentationRecord))

(def-mactype :QTSPresentation (find-mactype '(:pointer :QTSPresentationRecord)))
(defrecord QTSStreamRecord
   (data (:array :signed-long 1))
)

;type name? (%define-record :QTSStreamRecord (find-record-descriptor ':QTSStreamRecord))

(def-mactype :QTSStream (find-mactype '(:pointer :QTSStreamRecord)))
(defrecord QTSEditEntry
   (presentationDuration :TIMEVALUE64)
   (streamStartTime :TIMEVALUE64)
   (streamRate :signed-long)
)

;type name? (%define-record :QTSEditEntry (find-record-descriptor ':QTSEditEntry))
(defrecord QTSEditList
   (numEdits :SInt32)
   (edits (:array :QTSEditEntry 1))
)

;type name? (%define-record :QTSEditList (find-record-descriptor ':QTSEditList))

(def-mactype :QTSEditListPtr (find-mactype '(:pointer :QTSEditList)))

(def-mactype :QTSEditListHandle (find-mactype '(:handle :QTSEditList)))
; #define kQTSInvalidPresentation     (QTSPresentation)0L
; #define kQTSAllPresentations        (QTSPresentation)0L
; #define kQTSInvalidStream           (QTSStream)0L
; #define kQTSAllStreams              (QTSStream)0L

(def-mactype :QTSNotificationProcPtr (find-mactype ':pointer)); (ComponentResult inErr , OSType inNotificationType , void * inNotificationParams , void * inRefCon)

(def-mactype :QTSNotificationUPP (find-mactype '(:pointer :OpaqueQTSNotificationProcPtr)))
; -----------------------------------------
;     Get / Set Info
; -----------------------------------------

(defconstant $kQTSGetURLLink :|gull|)           ;  QTSGetURLLinkRecord* 

;  get and set 

(defconstant $kQTSTargetBufferDurationInfo :|bufr|);  Fixed* in seconds; expected, not actual 

(defconstant $kQTSDurationInfo :|dura|)         ;  QTSDurationAtom* 

(defconstant $kQTSSoundLevelMeteringEnabledInfo :|mtrn|);  Boolean* 

(defconstant $kQTSSoundLevelMeterInfo :|levm|)  ;  LevelMeterInfoPtr 

(defconstant $kQTSSourceTrackIDInfo :|otid|)    ;  UInt32* 

(defconstant $kQTSSourceLayerInfo :|olyr|)      ;  UInt16* 

(defconstant $kQTSSourceLanguageInfo :|olng|)   ;  UInt16* 

(defconstant $kQTSSourceTrackFlagsInfo :|otfl|) ;  SInt32* 

(defconstant $kQTSSourceDimensionsInfo :|odim|) ;  QTSDimensionParams* 

(defconstant $kQTSSourceVolumesInfo :|ovol|)    ;  QTSVolumesParams* 

(defconstant $kQTSSourceMatrixInfo :|omat|)     ;  MatrixRecord* 

(defconstant $kQTSSourceClipRectInfo :|oclp|)   ;  Rect* 

(defconstant $kQTSSourceGraphicsModeInfo :|ogrm|);  QTSGraphicsModeParams* 

(defconstant $kQTSSourceScaleInfo :|oscl|)      ;  Point* 

(defconstant $kQTSSourceBoundingRectInfo :|orct|);  Rect* 

(defconstant $kQTSSourceUserDataInfo :|oudt|)   ;  UserData 

(defconstant $kQTSSourceInputMapInfo :|oimp|)   ;  QTAtomContainer 

(defconstant $kQTSInfo_DataProc :|datp|)        ;  QTSDataProcParams* 

(defconstant $kQTSInfo_SendDataExtras :|dext|)  ;  QTSSendDataExtrasParams* 

(defconstant $kQTSInfo_HintTrackID :|htid|)     ;  long* 

(defconstant $kQTSInfo_URL :|url |)             ;  Handle*, cstring in handle 

(defconstant $kQTSInfo_Authentication :|auup|)  ;  QTSAuthenticationParams 

(defconstant $kQTSInfo_MediaPacketizer :|rmpk|) ;  ComponentInstance 

;  get only 

(defconstant $kQTSStatisticsInfo :|stat|)       ;  QTSStatisticsParams* 

(defconstant $kQTSMinStatusDimensionsInfo :|mstd|);  QTSDimensionParams* 

(defconstant $kQTSNormalStatusDimensionsInfo :|nstd|);  QTSDimensionParams* 

(defconstant $kQTSTotalDataRateInfo :|drtt|)    ;  UInt32*, add to what's there 

(defconstant $kQTSTotalDataRateInInfo :|drti|)  ;  UInt32*, add to what's there 

(defconstant $kQTSTotalDataRateOutInfo :|drto|) ;  UInt32*, add to what's there 

(defconstant $kQTSLostPercentInfo :|lpct|)      ;  QTSLostPercentParams*, add to what's there 

(defconstant $kQTSNumViewersInfo :|nviw|)       ;  UInt32* 

(defconstant $kQTSMediaTypeInfo :|mtyp|)        ;  OSType* 

(defconstant $kQTSNameInfo :|name|)             ;  QTSNameParams* 

(defconstant $kQTSCanHandleSendDataType :|chsd|);  QTSCanHandleSendDataTypeParams* 

(defconstant $kQTSAnnotationsInfo :|meta|)      ;  QTAtomContainer 

(defconstant $kQTSRemainingBufferTimeInfo :|btms|);  UInt32* remaining buffer time before playback, in microseconds 

(defconstant $kQTSInfo_SettingsText :|sttx|)    ;  QTSSettingsTextParams* 

(defconstant $kQTSInfo_AverageFrameRate :|fps |);  UnsignedFixed* 

(defrecord QTSAuthenticationParams
   (flags :SInt32)
   (userID (:pointer :char))                    ;  caller disposes of pointer
   (password (:pointer :char))                  ;  caller disposes of pointer
)

;type name? (%define-record :QTSAuthenticationParams (find-record-descriptor ':QTSAuthenticationParams))

(defconstant $kQTSTargetBufferDurationTimeScale #x3E8)
(defrecord QTSPanelFilterParams
   (version :SInt32)
   (inStream (:pointer :QTSStreamRecord))
   (inPanelType :OSType)
   (inPanelSubType :OSType)
   (details :QTAtomSpec)
)

;type name? (%define-record :QTSPanelFilterParams (find-record-descriptor ':QTSPanelFilterParams))
;  return true to keep this panel

(def-mactype :QTSPanelFilterProcPtr (find-mactype ':pointer)); (QTSPanelFilterParams * inParams , void * inRefCon)

(def-mactype :QTSPanelFilterUPP (find-mactype '(:pointer :OpaqueQTSPanelFilterProcPtr)))

(defconstant $kQTSSettingsTextSummary :|set1|)
(defconstant $kQTSSettingsTextDetails :|setd|)
(defrecord QTSSettingsTextParams
   (flags :SInt32)                              ;  None yet defined
   (inSettingsSelector :OSType)                 ;  which kind of setting you want from enum above
   (outSettingsAsText :Handle)                  ;  QTS allocates; Caller disposes
   (inPanelFilterProc (:pointer :OpaqueQTSPanelFilterProcPtr));  To get a subset filter with this   
   (inPanelFilterProcRefCon :pointer)
)

;type name? (%define-record :QTSSettingsTextParams (find-record-descriptor ':QTSSettingsTextParams))
(defrecord QTSCanHandleSendDataTypeParams
   (modifierTypeOrInputID :SInt32)
   (isModifierType :Boolean)
   (returnedCanHandleSendDataType :Boolean)     ;  callee sets to true if it can handle it
)

;type name? (%define-record :QTSCanHandleSendDataTypeParams (find-record-descriptor ':QTSCanHandleSendDataTypeParams))
(defrecord QTSNameParams
   (maxNameLength :SInt32)
   (requestedLanguage :SInt32)
   (returnedActualLanguage :SInt32)
   (returnedName (:pointer :UInt8))             ;  pascal string; caller supplies
)

;type name? (%define-record :QTSNameParams (find-record-descriptor ':QTSNameParams))
(defrecord QTSLostPercentParams
   (receivedPkts :UInt32)
   (lostPkts :UInt32)
   (percent :signed-long)
)

;type name? (%define-record :QTSLostPercentParams (find-record-descriptor ':QTSLostPercentParams))
(defrecord QTSDimensionParams
   (width :signed-long)
   (height :signed-long)
)

;type name? (%define-record :QTSDimensionParams (find-record-descriptor ':QTSDimensionParams))
(defrecord QTSVolumesParams
   (leftVolume :SInt16)
   (rightVolume :SInt16)
)

;type name? (%define-record :QTSVolumesParams (find-record-descriptor ':QTSVolumesParams))
(defrecord QTSGraphicsModeParams
   (graphicsMode :SInt16)
   (opColor :RGBColor)
)

;type name? (%define-record :QTSGraphicsModeParams (find-record-descriptor ':QTSGraphicsModeParams))
(defrecord QTSGetURLLinkRecord
   (displayWhere :Point)
   (returnedURLLink :Handle)
)

;type name? (%define-record :QTSGetURLLinkRecord (find-record-descriptor ':QTSGetURLLinkRecord))

(defconstant $kQTSDataProcParamsVersion1 1)

(defconstant $kQTSDataProcType_MediaSample :|mdia|)
(defconstant $kQTSDataProcType_HintSample :|hint|)
(defrecord QTSDataProcParams
   (version :SInt32)
   (flags :SInt32)
   (stream (:pointer :QTSStreamRecord))
   (procType :OSType)
   (proc (:pointer :OpaqueQTSNotificationProcPtr))
   (procRefCon :pointer)
)

;type name? (%define-record :QTSDataProcParams (find-record-descriptor ':QTSDataProcParams))

(defconstant $kQTSDataProcSelector_SampleData :|samp|)
(defconstant $kQTSDataProcSelector_UserData :|user|)

(defconstant $kQTSSampleDataCallbackParamsVersion1 1)
(defrecord QTSSampleDataCallbackParams
   (version :SInt32)
   (flags :SInt32)
   (stream (:pointer :QTSStreamRecord))
   (procType :OSType)
   (mediaType :OSType)
   (mediaTimeScale :signed-long)
   (sampleDesc (:Handle :SampleDescription))
   (sampleDescSeed :UInt32)
   (sampleTime :TIMEVALUE64)
   (duration :TIMEVALUE64)                      ;  could be 0 
   (sampleFlags :SInt32)
   (dataLength :UInt32)
   (data :pointer)
)

;type name? (%define-record :QTSSampleDataCallbackParams (find-record-descriptor ':QTSSampleDataCallbackParams))

(defconstant $kQTSUserDataCallbackParamsVersion1 1)
(defrecord QTSUserDataCallbackParams
   (version :SInt32)
   (flags :SInt32)
   (stream (:pointer :QTSStreamRecord))
   (procType :OSType)
   (userDataType :OSType)
   (userDataHandle :Handle)                     ;  caller must make copy if it wants to keep the data around
)

;type name? (%define-record :QTSUserDataCallbackParams (find-record-descriptor ':QTSUserDataCallbackParams))

(defconstant $kQTSSendDataExtrasParamsVersion1 1)
(defrecord QTSSendDataExtrasParams
   (version :SInt32)
   (flags :SInt32)
   (procType :OSType)
)

;type name? (%define-record :QTSSendDataExtrasParams (find-record-descriptor ':QTSSendDataExtrasParams))

(def-mactype :QTSModalFilterProcPtr (find-mactype ':pointer)); (DialogPtr inDialog , const EventRecord * inEvent , SInt16 * ioItemHit , void * inRefCon)

(def-mactype :QTSModalFilterUPP (find-mactype '(:pointer :OpaqueQTSModalFilterProcPtr)))
; -----------------------------------------
;     Characteristics
; -----------------------------------------
;  characteristics in Movies.h work here too 

(defconstant $kQTSSupportsPerStreamControlCharacteristic :|psct|)
(defrecord QTSVideoParams
   (width :signed-long)
   (height :signed-long)
   (matrix :MatrixRecord)
   (gWorld (:pointer :OpaqueGrafPtr))
   (gdHandle (:Handle :GDEVICE))
   (clip (:pointer :OpaqueRgnHandle))
   (graphicsMode :SInt16)
   (opColor :RGBColor)
)

;type name? (%define-record :QTSVideoParams (find-record-descriptor ':QTSVideoParams))
(defrecord QTSAudioParams
   (leftVolume :SInt16)
   (rightVolume :SInt16)
   (bassLevel :SInt16)
   (trebleLevel :SInt16)
   (frequencyBandsCount :SInt16)
   (frequencyBands :pointer)
   (levelMeteringEnabled :Boolean)
)

;type name? (%define-record :QTSAudioParams (find-record-descriptor ':QTSAudioParams))
(defrecord QTSMediaParams
   (v :QTSVideoParams)
   (a :QTSAudioParams)
)

;type name? (%define-record :QTSMediaParams (find-record-descriptor ':QTSMediaParams))

(defconstant $kQTSMustDraw 8)
(defconstant $kQTSAtEnd 16)
(defconstant $kQTSPreflightDraw 32)
(defconstant $kQTSSyncDrawing 64)
;  media task result flags 

(defconstant $kQTSDidDraw 1)
(defconstant $kQTSNeedsToDraw 4)
(defconstant $kQTSDrawAgain 8)
(defconstant $kQTSPartialDraw 16)
; ============================================================================
;         Notifications
; ============================================================================
;  ------ notification types ------ 

(defconstant $kQTSNullNotification :|null|)     ;  NULL 

(defconstant $kQTSErrorNotification :|err |)    ;  QTSErrorParams*, optional 

(defconstant $kQTSNewPresDetectedNotification :|newp|);  QTSNewPresDetectedParams* 

(defconstant $kQTSPresBeginChangingNotification :|prcb|);  NULL 

(defconstant $kQTSPresDoneChangingNotification :|prcd|);  NULL 

(defconstant $kQTSPresentationChangedNotification :|prch|);  NULL 

(defconstant $kQTSNewStreamNotification :|stnw|);  QTSNewStreamParams* 

(defconstant $kQTSStreamBeginChangingNotification :|stcb|);  QTSStream 

(defconstant $kQTSStreamDoneChangingNotification :|stcd|);  QTSStream 

(defconstant $kQTSStreamChangedNotification :|stch|);  QTSStreamChangedParams* 

(defconstant $kQTSStreamGoneNotification :|stgn|);  QTSStreamGoneParams* 

(defconstant $kQTSPreviewAckNotification :|pvak|);  QTSStream 

(defconstant $kQTSPrerollAckNotification :|pack|);  QTSStream 

(defconstant $kQTSStartAckNotification :|sack|) ;  QTSStream 

(defconstant $kQTSStopAckNotification :|xack|)  ;  QTSStream 

(defconstant $kQTSStatusNotification :|stat|)   ;  QTSStatusParams* 

(defconstant $kQTSURLNotification :|url |)      ;  QTSURLParams* 

(defconstant $kQTSDurationNotification :|dura|) ;  QTSDurationAtom* 

(defconstant $kQTSNewPresentationNotification :|nprs|);  QTSPresentation 

(defconstant $kQTSPresentationGoneNotification :|xprs|);  QTSPresentation 

(defconstant $kQTSPresentationDoneNotification :|pdon|);  NULL 

(defconstant $kQTSBandwidthAlertNotification :|bwal|);  QTSBandwidthAlertParams* 

(defconstant $kQTSAnnotationsChangedNotification :|meta|);  NULL 

;  flags for QTSErrorParams 

(defconstant $kQTSFatalErrorFlag 1)
(defrecord QTSErrorParams
   (errorString (:pointer :char))
   (flags :SInt32)
)

;type name? (%define-record :QTSErrorParams (find-record-descriptor ':QTSErrorParams))
(defrecord QTSNewPresDetectedParams
   (data :pointer)
)

;type name? (%define-record :QTSNewPresDetectedParams (find-record-descriptor ':QTSNewPresDetectedParams))
(defrecord QTSNewStreamParams
   (stream (:pointer :QTSStreamRecord))
)

;type name? (%define-record :QTSNewStreamParams (find-record-descriptor ':QTSNewStreamParams))
(defrecord QTSStreamChangedParams
   (stream (:pointer :QTSStreamRecord))
   (mediaComponent (:pointer :ComponentInstanceRecord));  could be NULL 
)

;type name? (%define-record :QTSStreamChangedParams (find-record-descriptor ':QTSStreamChangedParams))
(defrecord QTSStreamGoneParams
   (stream (:pointer :QTSStreamRecord))
)

;type name? (%define-record :QTSStreamGoneParams (find-record-descriptor ':QTSStreamGoneParams))
(defrecord QTSStatusParams
   (status :UInt32)
   (statusString (:pointer :char))
   (detailedStatus :UInt32)
   (detailedStatusString (:pointer :char))
)

;type name? (%define-record :QTSStatusParams (find-record-descriptor ':QTSStatusParams))
(defrecord QTSInfoParams
   (infoType :OSType)
   (infoParams :pointer)
)

;type name? (%define-record :QTSInfoParams (find-record-descriptor ':QTSInfoParams))
(defrecord QTSURLParams
   (urlLength :UInt32)
   (url (:pointer :char))
)

;type name? (%define-record :QTSURLParams (find-record-descriptor ':QTSURLParams))

(defconstant $kQTSBandwidthAlertNeedToStop 1)
(defconstant $kQTSBandwidthAlertRestartAt 2)
(defrecord QTSBandwidthAlertParams
   (flags :SInt32)
   (restartAt :signed-long)                     ;  new field in QT 4.1
   (reserved :pointer)
)

;type name? (%define-record :QTSBandwidthAlertParams (find-record-descriptor ':QTSBandwidthAlertParams))
; ============================================================================
;         Presentation
; ============================================================================
; -----------------------------------------
;      Flags
; -----------------------------------------
;  flags for NewPresentationFromData 

(defconstant $kQTSAutoModeFlag 1)
(defconstant $kQTSDontShowStatusFlag 8)
(defconstant $kQTSSendMediaFlag #x10000)
(defconstant $kQTSReceiveMediaFlag #x20000)
(defrecord QTSNewPresentationParams
   (dataType :OSType)
   (data :pointer)
   (dataLength :UInt32)
   (editList (:Handle :QTSEditList))
   (flags :SInt32)
   (timeScale :signed-long)                     ;  set to 0 for default timescale 
   (mediaParams (:pointer :QTSMediaParams))
   (notificationProc (:pointer :OpaqueQTSNotificationProcPtr))
   (notificationRefCon :pointer)
)

;type name? (%define-record :QTSNewPresentationParams (find-record-descriptor ':QTSNewPresentationParams))
(defrecord QTSPresParams
   (version :UInt32)
   (editList (:Handle :QTSEditList))
   (flags :SInt32)
   (timeScale :signed-long)                     ;  set to 0 for default timescale 
   (mediaParams (:pointer :QTSMediaParams))
   (notificationProc (:pointer :OpaqueQTSNotificationProcPtr))
   (notificationRefCon :pointer)
)

;type name? (%define-record :QTSPresParams (find-record-descriptor ':QTSPresParams))

(defconstant $kQTSPresParamsVersion1 1)
(defrecord QTSPresIdleParams
   (stream (:pointer :QTSStreamRecord))
   (movieTimeToDisplay :TIMEVALUE64)
   (flagsIn :SInt32)
   (flagsOut :SInt32)
)

;type name? (%define-record :QTSPresIdleParams (find-record-descriptor ':QTSPresIdleParams))

(defconstant $kQTSExportFlag_ShowDialog 1)

(defconstant $kQTSExportParamsVersion1 1)
(defrecord QTSExportParams
   (version :SInt32)
   (exportType :OSType)
   (exportExtraData :pointer)
   (destinationContainerType :OSType)
   (destinationContainerData :pointer)
   (destinationContainerExtras :pointer)
   (flagsIn :SInt32)
   (flagsOut :SInt32)
   (filterProc (:pointer :OpaqueQTSModalFilterProcPtr))
   (filterProcRefCon :pointer)
   (exportComponent (:pointer :ComponentRecord));  NULL unless you want to override 
)

;type name? (%define-record :QTSExportParams (find-record-descriptor ':QTSExportParams))
; -----------------------------------------
;     Toolbox Init/Close
; -----------------------------------------
;  all "apps" must call this 
; 
;  *  InitializeQTS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_InitializeQTS" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  TerminateQTS()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_TerminateQTS" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; -----------------------------------------
;     Presentation Functions
; -----------------------------------------
; 
;  *  QTSNewPresentation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSNewPresentation" 
   ((inParams (:pointer :QTSNewPresentationParams))
    (outPresentation (:pointer :QTSPRESENTATION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSNewPresentationFromData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  *    Windows:          in QTSClient.lib 5.0 and later
;  

(deftrap-inline "_QTSNewPresentationFromData" 
   ((inDataType :OSType)
    (inData :pointer)
    (inDataLength (:pointer :SInt64))
    (inPresParams (:pointer :QTSPresParams))
    (outPresentation (:pointer :QTSPRESENTATION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSNewPresentationFromFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  *    Windows:          in QTSClient.lib 5.0 and later
;  

(deftrap-inline "_QTSNewPresentationFromFile" 
   ((inFileSpec (:pointer :FSSpec))
    (inPresParams (:pointer :QTSPresParams))
    (outPresentation (:pointer :QTSPRESENTATION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSNewPresentationFromDataRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  *    Windows:          in QTSClient.lib 5.0 and later
;  

(deftrap-inline "_QTSNewPresentationFromDataRef" 
   ((inDataRef :Handle)
    (inDataRefType :OSType)
    (inPresParams (:pointer :QTSPresParams))
    (outPresentation (:pointer :QTSPRESENTATION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSDisposePresentation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSDisposePresentation" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresExport()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  *    Windows:          in QTSClient.lib 5.0 and later
;  

(deftrap-inline "_QTSPresExport" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inExportParams (:pointer :QTSExportParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresIdle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresIdle" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (ioParams (:pointer :QTSPresIdleParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  QTSPresInvalidateRegion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresInvalidateRegion" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inRegion (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; -----------------------------------------
;     Presentation Configuration
; -----------------------------------------
; 
;  *  QTSPresSetFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresSetFlags" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inFlags :SInt32)
    (inFlagsMask :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetFlags()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetFlags" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (outFlags (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetTimeBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetTimeBase" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (outTimeBase (:pointer :TIMEBASE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetTimeScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetTimeScale" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (outTimeScale (:pointer :TIMESCALE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresSetInfo" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inSelector :OSType)
    (ioParam :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetInfo" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inSelector :OSType)
    (ioParam :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresHasCharacteristic()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresHasCharacteristic" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inCharacteristic :OSType)
    (outHasIt (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSetNotificationProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresSetNotificationProc" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inNotificationProc (:pointer :OpaqueQTSNotificationProcPtr))
    (inRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetNotificationProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetNotificationProc" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (outNotificationProc (:pointer :QTSNOTIFICATIONUPP))
    (outRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; -----------------------------------------
;     Presentation Control
; -----------------------------------------
; 
;  *  QTSPresPreview()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSPresPreview" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inTimeValue (:pointer :TIMEVALUE64))
    (inRate :signed-long)
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresPreroll()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresPreroll" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inTimeValue :UInt32)
    (inRate :signed-long)
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresPreroll64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
;  *    Windows:          in QTSClient.lib 4.1 and later
;  

(deftrap-inline "_QTSPresPreroll64" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inPrerollTime (:pointer :TIMEVALUE64))
    (inRate :signed-long)
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresStart()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresStart" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSkipTo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresSkipTo" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inTimeValue :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSkipTo64()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
;  *    Windows:          in QTSClient.lib 4.1 and later
;  

(deftrap-inline "_QTSPresSkipTo64" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inTimeValue (:pointer :TIMEVALUE64))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresStop()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresStop" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ============================================================================
;         Streams
; ============================================================================
; -----------------------------------------
;     Stream Functions
; -----------------------------------------
; 
;  *  QTSPresNewStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresNewStream" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inDataType :OSType)
    (inData :pointer)
    (inDataLength :UInt32)
    (inFlags :SInt32)
    (outStream (:pointer :QTSSTREAM))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSDisposeStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSDisposeStream" 
   ((inStream (:pointer :QTSStreamRecord))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetNumStreams()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetNumStreams" 
   ((inPresentation (:pointer :QTSPresentationRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  QTSPresGetIndStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetIndStream" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inIndex :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :QTSStreamRecord)
() )
; 
;  *  QTSGetStreamPresentation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSGetStreamPresentation" 
   ((inStream (:pointer :QTSStreamRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :QTSPresentationRecord)
() )
; 
;  *  QTSPresSetPreferredRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresSetPreferredRate" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inRate :signed-long)
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetPreferredRate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetPreferredRate" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (outRate (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSetEnable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresSetEnable" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inEnableMode :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetEnable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetEnable" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (outEnableMode (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSetPresenting()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresSetPresenting" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inPresentingMode :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetPresenting()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetPresenting" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (outPresentingMode (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSetActiveSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
;  *    Windows:          in QTSClient.lib 4.1 and later
;  

(deftrap-inline "_QTSPresSetActiveSegment" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inStartTime (:pointer :TIMEVALUE64))
    (inDuration (:pointer :TIMEVALUE64))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetActiveSegment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
;  *    Windows:          in QTSClient.lib 4.1 and later
;  

(deftrap-inline "_QTSPresGetActiveSegment" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (outStartTime (:pointer :TIMEVALUE64))
    (outDuration (:pointer :TIMEVALUE64))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSetPlayHints()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresSetPlayHints" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inFlags :SInt32)
    (inFlagsMask :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetPlayHints()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetPlayHints" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (outFlags (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; -----------------------------------------
;     Stream Spatial Functions
; -----------------------------------------
; 
;  *  QTSPresSetGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresSetGWorld" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inGWorld (:pointer :OpaqueGrafPtr))
    (inGDHandle (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetGWorld()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetGWorld" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (outGWorld (:pointer :CGrafPtr))
    (outGDHandle (:pointer :GDHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSetClip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresSetClip" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inClip (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetClip()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetClip" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (outClip (:pointer :RGNHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSetMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresSetMatrix" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inMatrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetMatrix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetMatrix" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (outMatrix (:pointer :MatrixRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSetDimensions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresSetDimensions" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inWidth :signed-long)
    (inHeight :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetDimensions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetDimensions" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (outWidth (:pointer :Fixed))
    (outHeight (:pointer :Fixed))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSetGraphicsMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresSetGraphicsMode" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inMode :SInt16)
    (inOpColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetGraphicsMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetGraphicsMode" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (outMode (:pointer :short))
    (outOpColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetPicture()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetPicture" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (outPicture (:pointer :PICHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; -----------------------------------------
;     Stream Sound Functions
; -----------------------------------------
; 
;  *  QTSPresSetVolumes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresSetVolumes" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inLeftVolume :SInt16)
    (inRightVolume :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetVolumes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSPresGetVolumes" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (outLeftVolume (:pointer :short))
    (outRightVolume (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; -----------------------------------------
;     Sourcing
; -----------------------------------------
; 
;  *  QTSPresGetSettingsAsText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0.1 and later
;  

(deftrap-inline "_QTSPresGetSettingsAsText" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inFlags :SInt32)
    (inSettingsType :OSType)
    (outText (:pointer :Handle))
    (inPanelFilterProc (:pointer :OpaqueQTSPanelFilterProcPtr))
    (inPanelFilterProcRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSettingsDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSPresSettingsDialog" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inFlags :SInt32)
    (inFilterProc (:pointer :OpaqueQTSModalFilterProcPtr))
    (inFilterProcRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSettingsDialogWithFilters()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0.1 and later
;  

(deftrap-inline "_QTSPresSettingsDialogWithFilters" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inFlags :SInt32)
    (inFilterProc (:pointer :OpaqueQTSModalFilterProcPtr))
    (inFilterProcRefCon :pointer)
    (inPanelFilterProc (:pointer :OpaqueQTSPanelFilterProcPtr))
    (inPanelFilterProcRefCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresSetSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSPresSetSettings" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inSettings (:pointer :QTAtomSpec))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSPresGetSettings" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (outSettings (:pointer :QTATOMCONTAINER))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresAddSourcer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSPresAddSourcer" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inSourcer (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresRemoveSourcer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSPresRemoveSourcer" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inSourcer (:pointer :ComponentInstanceRecord))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPresGetNumSourcers()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSPresGetNumSourcers" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  QTSPresGetIndSourcer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  

(deftrap-inline "_QTSPresGetIndSourcer" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inIndex :UInt32)
    (outSourcer (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ============================================================================
;         Misc
; ============================================================================
;  flags for Get/SetNetworkAppName 

(defconstant $kQTSNetworkAppNameIsFullNameFlag 1)
; 
;  *  QTSSetNetworkAppName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
;  *    Windows:          in QTSClient.lib 4.1 and later
;  

(deftrap-inline "_QTSSetNetworkAppName" 
   ((inAppName (:pointer :char))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSGetNetworkAppName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
;  *    Windows:          in QTSClient.lib 4.1 and later
;  

(deftrap-inline "_QTSGetNetworkAppName" 
   ((inFlags :SInt32)
    (outCStringPtr (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; -----------------------------------------
;     Statistics Utilities
; -----------------------------------------
(defrecord QTSStatHelperRecord
   (data (:array :signed-long 1))
)

;type name? (%define-record :QTSStatHelperRecord (find-record-descriptor ':QTSStatHelperRecord))

(def-mactype :QTSStatHelper (find-mactype '(:pointer :QTSStatHelperRecord)))

(defconstant $kQTSInvalidStatHelper 0)
;  flags for QTSStatHelperNextParams 

(defconstant $kQTSStatHelperReturnPascalStringsFlag 1)
(defrecord QTSStatHelperNextParams
   (flags :SInt32)
   (returnedStatisticsType :OSType)
   (returnedStream (:pointer :QTSStreamRecord))
   (maxStatNameLength :UInt32)
   (returnedStatName (:pointer :char))          ;  NULL if you don't want it
   (maxStatStringLength :UInt32)
   (returnedStatString (:pointer :char))        ;  NULL if you don't want it
   (maxStatUnitLength :UInt32)
   (returnedStatUnit (:pointer :char))          ;  NULL if you don't want it
)

;type name? (%define-record :QTSStatHelperNextParams (find-record-descriptor ':QTSStatHelperNextParams))
(defrecord QTSStatisticsParams
   (statisticsType :OSType)
   (container :Handle)
   (parentAtom :signed-long)
   (flags :SInt32)
)

;type name? (%define-record :QTSStatisticsParams (find-record-descriptor ':QTSStatisticsParams))
;  general statistics types 

(defconstant $kQTSAllStatisticsType :|all |)
(defconstant $kQTSShortStatisticsType :|shrt|)
(defconstant $kQTSSummaryStatisticsType :|summ|)
;  statistics flags 

(defconstant $kQTSGetNameStatisticsFlag 1)
(defconstant $kQTSDontGetDataStatisticsFlag 2)
(defconstant $kQTSUpdateAtomsStatisticsFlag 4)
(defconstant $kQTSGetUnitsStatisticsFlag 8)
(defconstant $kQTSUpdateAllIfNecessaryStatisticsFlag #x10000)
;  statistics atom types 

(defconstant $kQTSStatisticsStreamAtomType :|strm|)
(defconstant $kQTSStatisticsNameAtomType :|name|);  chars only, no length or terminator 

(defconstant $kQTSStatisticsDataFormatAtomType :|frmt|);  OSType 

(defconstant $kQTSStatisticsDataAtomType :|data|)
(defconstant $kQTSStatisticsUnitsAtomType :|unit|);  OSType 

(defconstant $kQTSStatisticsUnitsNameAtomType :|unin|);  chars only, no length or terminator 

;  statistics data formats 

(defconstant $kQTSStatisticsSInt32DataFormat :|si32|)
(defconstant $kQTSStatisticsUInt32DataFormat :|ui32|)
(defconstant $kQTSStatisticsSInt16DataFormat :|si16|)
(defconstant $kQTSStatisticsUInt16DataFormat :|ui16|)
(defconstant $kQTSStatisticsFixedDataFormat :|fixd|)
(defconstant $kQTSStatisticsUnsignedFixedDataFormat :|ufix|)
(defconstant $kQTSStatisticsStringDataFormat :|strg|)
(defconstant $kQTSStatisticsOSTypeDataFormat :|ostp|)
(defconstant $kQTSStatisticsRectDataFormat :|rect|)
(defconstant $kQTSStatisticsPointDataFormat :|pont|)
;  statistics units types 

(defconstant $kQTSStatisticsNoUnitsType 0)
(defconstant $kQTSStatisticsPercentUnitsType :|pcnt|)
(defconstant $kQTSStatisticsBitsPerSecUnitsType :|bps |)
(defconstant $kQTSStatisticsFramesPerSecUnitsType :|fps |)
;  specific statistics types 

(defconstant $kQTSTotalDataRateStat :|drtt|)
(defconstant $kQTSTotalDataRateInStat :|drti|)
(defconstant $kQTSTotalDataRateOutStat :|drto|)
(defconstant $kQTSNetworkIDStringStat :|nids|)
; 
;  *  QTSNewStatHelper()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSNewStatHelper" 
   ((inPresentation (:pointer :QTSPresentationRecord))
    (inStream (:pointer :QTSStreamRecord))
    (inStatType :OSType)
    (inFlags :SInt32)
    (outStatHelper (:pointer :QTSSTATHELPER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSDisposeStatHelper()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSDisposeStatHelper" 
   ((inStatHelper (:pointer :QTSStatHelperRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSStatHelperGetStats()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSStatHelperGetStats" 
   ((inStatHelper (:pointer :QTSStatHelperRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSStatHelperResetIter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSStatHelperResetIter" 
   ((inStatHelper (:pointer :QTSStatHelperRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSStatHelperNext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSStatHelperNext" 
   ((inStatHelper (:pointer :QTSStatHelperRecord))
    (ioParams (:pointer :QTSStatHelperNextParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  QTSStatHelperGetNumStats()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSStatHelperGetNumStats" 
   ((inStatHelper (:pointer :QTSStatHelperRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
;  used by components to put statistics into the atom container 
; 
;  *  QTSGetOrMakeStatAtomForStream()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSGetOrMakeStatAtomForStream" 
   ((inContainer :Handle)
    (inStream (:pointer :QTSStreamRecord))
    (outParentAtom (:pointer :QTATOM))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSInsertStatistic()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSInsertStatistic" 
   ((inContainer :Handle)
    (inParentAtom :signed-long)
    (inStatType :OSType)
    (inStatData :pointer)
    (inStatDataLength :UInt32)
    (inStatDataFormat :OSType)
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSInsertStatisticName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSInsertStatisticName" 
   ((inContainer :Handle)
    (inParentAtom :signed-long)
    (inStatType :OSType)
    (inStatName (:pointer :char))
    (inStatNameLength :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSInsertStatisticUnits()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSInsertStatisticUnits" 
   ((inContainer :Handle)
    (inParentAtom :signed-long)
    (inStatType :OSType)
    (inUnitsType :OSType)
    (inUnitsName (:pointer :char))
    (inUnitsNameLength :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ============================================================================
;         Data Formats
; ============================================================================
; -----------------------------------------
;     Data Types
; -----------------------------------------
;  universal data types 

(defconstant $kQTSNullDataType :|NULL|)
(defconstant $kQTSUnknownDataType :|huh?|)
(defconstant $kQTSAtomContainerDataType :|qtac|);  QTAtomContainer 

(defconstant $kQTSAtomDataType :|qtat|)         ;  QTSAtomContainerDataStruct* 

(defconstant $kQTSAliasDataType :|alis|)
(defconstant $kQTSFileDataType :|fspc|)         ;  FSSpec* 

(defconstant $kQTSFileSpecDataType :|fspc|)     ;  FSSpec* 

(defconstant $kQTSHandleDataType :|hndl|)       ;  Handle* 

(defconstant $kQTSDataRefDataType :|dref|)      ;  DataReferencePtr 

;  these data types are specific to presentations 

(defconstant $kQTSRTSPDataType :|rtsp|)
(defconstant $kQTSSDPDataType :|sdp |)
; -----------------------------------------
;     Atom IDs
; -----------------------------------------

(defconstant $kQTSAtomType_Presentation :|pres|)
(defconstant $kQTSAtomType_PresentationHeader :|phdr|);  QTSPresentationHeaderAtom 

(defconstant $kQTSAtomType_MediaStream :|mstr|)
(defconstant $kQTSAtomType_MediaStreamHeader :|mshd|);  QTSMediaStreamHeaderAtom 

(defconstant $kQTSAtomType_MediaDescriptionText :|mdes|);  chars, no length 

(defconstant $kQTSAtomType_ClipRect :|clip|)    ;  QTSClipRectAtom 

(defconstant $kQTSAtomType_Duration :|dura|)    ;  QTSDurationAtom 

(defconstant $kQTSAtomType_BufferTime :|bufr|)  ;  QTSBufferTimeAtom 

(defrecord QTSAtomContainerDataStruct
   (container :Handle)
   (parentAtom :signed-long)
)

;type name? (%define-record :QTSAtomContainerDataStruct (find-record-descriptor ':QTSAtomContainerDataStruct))
;  flags for QTSPresentationHeaderAtom 

(defconstant $kQTSPresHeaderTypeIsData #x100)
(defconstant $kQTSPresHeaderDataIsHandle #x200)
(defrecord QTSPresentationHeaderAtom
   (versionAndFlags :SInt32)
   (conductorOrDataType :OSType)
   (dataAtomType :OSType)                       ;  where the data really is
)

;type name? (%define-record :QTSPresentationHeaderAtom (find-record-descriptor ':QTSPresentationHeaderAtom))
(defrecord QTSMediaStreamHeaderAtom
   (versionAndFlags :SInt32)
   (mediaTransportType :OSType)
   (mediaTransportDataAID :OSType)              ;  where the data really is
)

;type name? (%define-record :QTSMediaStreamHeaderAtom (find-record-descriptor ':QTSMediaStreamHeaderAtom))
(defrecord QTSBufferTimeAtom
   (versionAndFlags :SInt32)
   (bufferTime :signed-long)
)

;type name? (%define-record :QTSBufferTimeAtom (find-record-descriptor ':QTSBufferTimeAtom))
(defrecord QTSDurationAtom
   (versionAndFlags :SInt32)
   (timeScale :signed-long)
   (duration :TIMEVALUE64)
)

;type name? (%define-record :QTSDurationAtom (find-record-descriptor ':QTSDurationAtom))
(defrecord QTSClipRectAtom
   (versionAndFlags :SInt32)
   (clipRect :Rect)
)

;type name? (%define-record :QTSClipRectAtom (find-record-descriptor ':QTSClipRectAtom))

(defconstant $kQTSEmptyEditStreamStartTime -1)

(def-mactype :QTSStatus (find-mactype ':UInt32))

(defconstant $kQTSNullStatus 0)
(defconstant $kQTSUninitializedStatus 1)
(defconstant $kQTSConnectingStatus 2)
(defconstant $kQTSOpeningConnectionDetailedStatus 3)
(defconstant $kQTSMadeConnectionDetailedStatus 4)
(defconstant $kQTSNegotiatingStatus 5)
(defconstant $kQTSGettingDescriptionDetailedStatus 6)
(defconstant $kQTSGotDescriptionDetailedStatus 7)
(defconstant $kQTSSentSetupCmdDetailedStatus 8)
(defconstant $kQTSReceivedSetupResponseDetailedStatus 9)
(defconstant $kQTSSentPlayCmdDetailedStatus 10)
(defconstant $kQTSReceivedPlayResponseDetailedStatus 11)
(defconstant $kQTSBufferingStatus 12)
(defconstant $kQTSPlayingStatus 13)
(defconstant $kQTSPausedStatus 14)
(defconstant $kQTSAutoConfiguringStatus 15)
(defconstant $kQTSDownloadingStatus 16)
(defconstant $kQTSBufferingWithTimeStatus 17)
(defconstant $kQTSWaitingDisconnectStatus 100)
; -----------------------------------------
;     QuickTime Preferences Types
; -----------------------------------------

(defconstant $kQTSConnectionPrefsType :|stcm|)  ;  root atom that all other atoms are contained in
;     kQTSNotUsedForProxyPrefsType = 'nopr',     //        comma-delimited list of URLs that are never used for proxies

(defconstant $kQTSConnectionMethodPrefsType :|mthd|);       connection method (OSType that matches one of the following three)

(defconstant $kQTSDirectConnectPrefsType :|drct|);        used if direct connect (QTSDirectConnectPrefsRecord)
;     kQTSRTSPProxyPrefsType =     'rtsp',   //   used if RTSP Proxy (QTSProxyPrefsRecord)

(defconstant $kQTSSOCKSPrefsType :|sock|)       ;        used if SOCKS Proxy (QTSProxyPrefsRecord)


(defconstant $kQTSDirectConnectHTTPProtocol :|http|)
(defconstant $kQTSDirectConnectRTSPProtocol :|rtsp|)
(defrecord QTSDirectConnectPrefsRecord
   (tcpPortID :UInt32)
   (protocol :OSType)
)

;type name? (%define-record :QTSDirectConnectPrefsRecord (find-record-descriptor ':QTSDirectConnectPrefsRecord))
(defrecord QTSProxyPrefsRecord
   (serverNameStr (:string 255))
   (portID :UInt32)
)

;type name? (%define-record :QTSProxyPrefsRecord (find-record-descriptor ':QTSProxyPrefsRecord))
(defconstant $kQTSTransAndProxyPrefsVersNum 2)
; #define kQTSTransAndProxyPrefsVersNum       2       /* prefs atom format version */

(defconstant $kConnectionActive 1)
(defconstant $kConnectionUseSystemPref 2)
(defrecord QTSTransportPref
   (protocol :OSType)                           ;  udp, http, tcp, etc
   (portID :SInt32)                             ;  port to use for this connection type
   (flags :UInt32)                              ;  connection flags
   (seed :UInt32)                               ;  seed value last time this setting was read from system prefs
)

;type name? (%define-record :QTSTransportPref (find-record-descriptor ':QTSTransportPref))

(defconstant $kProxyActive 1)
(defconstant $kProxyUseSystemPref 2)
(defrecord QTSProxyPref
   (flags :UInt32)                              ;  proxy flags
   (portID :SInt32)                             ;  port to use for this connection type
   (seed :UInt32)                               ;  seed value last time this setting was read from system prefs
   (serverNameStr (:string 255))                ;  proxy server url
)

;type name? (%define-record :QTSProxyPref (find-record-descriptor ':QTSProxyPref))

(defconstant $kNoProxyUseSystemPref 1)
(defrecord QTSNoProxyPref
   (flags :UInt32)                              ;  no-proxy flags
   (seed :UInt32)                               ;  seed value last time this setting was read from system prefs
   (urlList (:array :character 1))              ;  NULL terminated, comma delimited list of urls
)

;type name? (%define-record :QTSNoProxyPref (find-record-descriptor ':QTSNoProxyPref))

(defconstant $kQTSInstantOnFlag_Enable 1)       ;  instant on is enabled (read/write)
;  instant on is possible (read only)

(defconstant $kQTSInstantOnFlag_Permitted 2)
(defrecord QTSInstantOnPref
   (flags :SInt32)                              ;  flags
   (factor :SInt32)                             ;     0-100; default is 50
)

;type name? (%define-record :QTSInstantOnPref (find-record-descriptor ':QTSInstantOnPref))

(defconstant $kQTSTransAndProxyAtomType :|strp|);  transport/proxy prefs root atom

(defconstant $kQTSConnectionPrefsVersion :|vers|);    prefs format version

(defconstant $kQTSTransportPrefsAtomType :|trns|);    tranport prefs root atom

(defconstant $kQTSConnectionAtomType :|conn|)   ;      connection prefs atom type, one for each transport type

(defconstant $kQTSUDPTransportType :|udp |)     ;      udp transport prefs

(defconstant $kQTSHTTPTransportType :|http|)    ;      http transport prefs

(defconstant $kQTSTCPTransportType :|tcp |)     ;      tcp transport prefs    

(defconstant $kQTSProxyPrefsAtomType :|prxy|)   ;    proxy prefs root atom

(defconstant $kQTSHTTPProxyPrefsType :|http|)   ;      http proxy settings

(defconstant $kQTSRTSPProxyPrefsType :|rtsp|)   ;      rtsp proxy settings

(defconstant $kQTSSOCKSProxyPrefsType :|sock|)  ;      socks proxy settings

(defconstant $kQTSProxyUserInfoPrefsType :|user|);    proxy username/password root atom

(defconstant $kQTSDontProxyPrefsAtomType :|nopr|);    no-proxy prefs root atom

(defconstant $kQTSDontProxyDataType :|data|)    ;      no proxy settings

(defconstant $kQTSInstantOnPrefsAtomType :|inon|);  instant on prefs

; 
;  *  QTSPrefsAddProxySetting()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
;  *    Windows:          in QTSClient.lib 4.1 and later
;  

(deftrap-inline "_QTSPrefsAddProxySetting" 
   ((proxyType :OSType)
    (portID :SInt32)
    (flags :UInt32)
    (seed :UInt32)
    (srvrURL (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPrefsFindProxyByType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
;  *    Windows:          in QTSClient.lib 4.1 and later
;  

(deftrap-inline "_QTSPrefsFindProxyByType" 
   ((proxyType :OSType)
    (flags :UInt32)
    (flagsMask :UInt32)
    (proxyHndl (:pointer :QTSProxyPref))
    (count (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPrefsAddConnectionSetting()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
;  *    Windows:          in QTSClient.lib 4.1 and later
;  

(deftrap-inline "_QTSPrefsAddConnectionSetting" 
   ((protocol :OSType)
    (portID :SInt32)
    (flags :UInt32)
    (seed :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPrefsFindConnectionByType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
;  *    Windows:          in QTSClient.lib 4.1 and later
;  

(deftrap-inline "_QTSPrefsFindConnectionByType" 
   ((protocol :OSType)
    (flags :UInt32)
    (flagsMask :UInt32)
    (connectionHndl (:pointer :QTSTransportPref))
    (count (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPrefsGetActiveConnection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
;  *    Windows:          in QTSClient.lib 4.1 and later
;  

(deftrap-inline "_QTSPrefsGetActiveConnection" 
   ((protocol :OSType)
    (connectInfo (:pointer :QTSTransportPref))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPrefsGetNoProxyURLs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
;  *    Windows:          in QTSClient.lib 4.1 and later
;  

(deftrap-inline "_QTSPrefsGetNoProxyURLs" 
   ((noProxyHndl (:pointer :QTSNoProxyPref))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPrefsSetNoProxyURLs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.1 and later
;  *    Windows:          in QTSClient.lib 4.1 and later
;  

(deftrap-inline "_QTSPrefsSetNoProxyURLs" 
   ((urls (:pointer :char))
    (flags :UInt32)
    (seed :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSPrefsAddProxyUserInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0.1 and later
;  *    Windows:          in QTSClient.lib 5.0.1 and later
;  

(deftrap-inline "_QTSPrefsAddProxyUserInfo" 
   ((proxyType :OSType)
    (flags :SInt32)
    (flagsMask :SInt32)
    (username (:pointer :UInt8))
    (password (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
; 
;  *  QTSPrefsFindProxyUserInfoByType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0.1 and later
;  *    Windows:          in QTSClient.lib 5.0.1 and later
;  

(deftrap-inline "_QTSPrefsFindProxyUserInfoByType" 
   ((proxyType :OSType)
    (flags :SInt32)
    (flagsMask :SInt32)
    (username (:pointer :UInt8))
    (password (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
; 
;  *  QTSPrefsGetInstantOnSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QTStreamLib 6.0 and later
;  *    Windows:          in QTSClient.lib 6.0 and later
;  

(deftrap-inline "_QTSPrefsGetInstantOnSettings" 
   ((outPref (:pointer :QTSInstantOnPref))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; 
;  *  QTSPrefsSetInstantOnSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QTStreamLib 6.0 and later
;  *    Windows:          in QTSClient.lib 6.0 and later
;  

(deftrap-inline "_QTSPrefsSetInstantOnSettings" 
   ((inPref (:pointer :QTSInstantOnPref))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSErr
() )
; ============================================================================
;         Memory Management Services
; ============================================================================
; 
;    These routines allocate normal pointers and handles,
;    but do the correct checking, etc.
;    Dispose using the normal DisposePtr and DisposeHandle
;    Call these routines for one time memory allocations.
;    You do not need to set any hints to use these calls.
; 
; 
;  *  QTSNewPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSNewPtr" 
   ((inByteCount :UInt32)
    (inFlags :SInt32)
    (outFlags (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :pointer
() )
; 
;  *  QTSNewHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSNewHandle" 
   ((inByteCount :UInt32)
    (inFlags :SInt32)
    (outFlags (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; #define QTSNewPtrClear(_s)      QTSNewPtr((_s), kQTSMemAllocClearMem, NULL)
; #define QTSNewHandleClear(_s)   QTSNewHandle((_s), kQTSMemAllocClearMem, NULL)
;  flags in

(defconstant $kQTSMemAllocClearMem 1)
(defconstant $kQTSMemAllocDontUseTempMem 2)
(defconstant $kQTSMemAllocTryTempMemFirst 4)
(defconstant $kQTSMemAllocDontUseSystemMem 8)
(defconstant $kQTSMemAllocTrySystemMemFirst 16)
(defconstant $kQTSMemAllocHoldMemory #x1000)
(defconstant $kQTSMemAllocIsInterruptTime #x1010000);  currently not supported for alloc

;  flags out

(defconstant $kQTSMemAllocAllocatedInTempMem 1)
(defconstant $kQTSMemAllocAllocatedInSystemMem 2)

(def-mactype :QTSMemPtr (find-mactype '(:pointer :OpaqueQTSMemPtr)))
; 
;    These routines are for buffers that will be recirculated
;    you must use QTReleaseMemPtr instead of DisposePtr
;    QTSReleaseMemPtr can be used at interrupt time
;    but QTSAllocMemPtr currently cannot 
; 
; 
;  *  QTSAllocMemPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSAllocMemPtr" 
   ((inByteCount :UInt32)
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQTSMemPtr)
() )
; 
;  *  QTSReleaseMemPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSReleaseMemPtr" 
   ((inMemPtr (:pointer :OpaqueQTSMemPtr))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ============================================================================
;         Buffer Management Services
; ============================================================================

(defconstant $kQTSStreamBufferVersion1 1)
(defrecord QTSStreamBuffer
   (reserved1 (:pointer :qtsstreambuffer))
   (reserved2 (:pointer :qtsstreambuffer))
   (next (:pointer :qtsstreambuffer))           ;  next message block in a message 
   (rptr (:pointer :UInt8))                     ;  first byte with real data in the DataBuffer 
   (wptr (:pointer :UInt8))                     ;  last+1 byte with real data in the DataBuffer 
   (version :SInt32)
   (metadata (:array :UInt32 4))                ;  usage defined by message sender 
   (flags :SInt32)                              ;  reserved 
   (reserved3 :signed-long)
   (reserved4 :signed-long)
   (reserved5 :signed-long)
   (moreMeta (:array :UInt32 8))
)

;type name? (%define-record :QTSStreamBuffer (find-record-descriptor ':QTSStreamBuffer))
;  flags for QTSDuplicateMessage

(defconstant $kQTSDuplicateBufferFlag_CopyData 1)
(defconstant $kQTSDuplicateBufferFlag_FlattenMessage 2)
; 
;  *  QTSNewStreamBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  *    Windows:          in QTSClient.lib 5.0 and later
;  

(deftrap-inline "_QTSNewStreamBuffer" 
   ((inDataSize :UInt32)
    (inFlags :SInt32)
    (outStreamBuffer (:pointer :QTSStreamBuffer))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSFreeMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSFreeMessage" 
   ((inMessage (:pointer :QTSStreamBuffer))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;     kQTSDuplicateBufferFlag_CopyData - forces a copy of the data itself
;     kQTSCopyBufferFlag_FlattenMessage - copies the data if it needs to be flattened
;     QTSDuplicateMessage never frees the old message
; 
; 
;  *  QTSDuplicateMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  *    Windows:          in QTSClient.lib 5.0 and later
;  

(deftrap-inline "_QTSDuplicateMessage" 
   ((inMessage (:pointer :QTSStreamBuffer))
    (inFlags :SInt32)
    (outDuplicatedMessage (:pointer :QTSStreamBuffer))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  QTSMessageLength()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSMessageLength" 
   ((inMessage (:pointer :QTSStreamBuffer))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  QTSStreamBufferDataInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0 and later
;  *    Windows:          in QTSClient.lib 5.0 and later
;  

(deftrap-inline "_QTSStreamBufferDataInfo" 
   ((inStreamBuffer (:pointer :QTSStreamBuffer))
    (outDataStart (:pointer :UInt8))
    (outDataMaxLength (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  ---- old calls (don't use these)
; 
;  *  QTSAllocBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSAllocBuffer" 
   ((inSize :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :QTSStreamBuffer)
() )
; 
;  *  QTSDupMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSDupMessage" 
   ((inMessage (:pointer :QTSStreamBuffer))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :QTSStreamBuffer)
() )
; 
;  *  QTSCopyMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSCopyMessage" 
   ((inMessage (:pointer :QTSStreamBuffer))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :QTSStreamBuffer)
() )
; 
;  *  QTSFlattenMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSFlattenMessage" 
   ((inMessage (:pointer :QTSStreamBuffer))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :QTSStreamBuffer)
() )
; ============================================================================
;         Misc
; ============================================================================
; 
;  *  QTSGetErrorString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSGetErrorString" 
   ((inErrorCode :SInt32)
    (inMaxErrorStringLength :UInt32)
    (outErrorString (:pointer :char))
    (inFlags :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  QTSInitializeMediaParams()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   in QTStreamLib 5.0.1 and later
;  *    Windows:          in QTSClient.lib 5.0.1 and later
;  

(deftrap-inline "_QTSInitializeMediaParams" 
   ((inMediaParams (:pointer :QTSMediaParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
;  UPP call backs 
; 
;  *  NewQTSNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTSNotificationUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQTSNotificationProcPtr)
() )
; 
;  *  NewQTSPanelFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTSPanelFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :OpaqueQTSPanelFilterProcPtr)
() )
; 
;  *  NewQTSModalFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQTSModalFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQTSModalFilterProcPtr)
() )
; 
;  *  DisposeQTSNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTSNotificationUPP" 
   ((userUPP (:pointer :OpaqueQTSNotificationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQTSPanelFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTSPanelFilterUPP" 
   ((userUPP (:pointer :OpaqueQTSPanelFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  DisposeQTSModalFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQTSModalFilterUPP" 
   ((userUPP (:pointer :OpaqueQTSModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQTSNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTSNotificationUPP" 
   ((inErr :signed-long)
    (inNotificationType :OSType)
    (inNotificationParams :pointer)
    (inRefCon :pointer)
    (userUPP (:pointer :OpaqueQTSNotificationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  InvokeQTSPanelFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTSPanelFilterUPP" 
   ((inParams (:pointer :QTSPanelFilterParams))
    (inRefCon :pointer)
    (userUPP (:pointer :OpaqueQTSPanelFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Boolean
() )
; 
;  *  InvokeQTSModalFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQTSModalFilterUPP" 
   ((inDialog (:pointer :OpaqueDialogPtr))
    (inEvent (:pointer :EventRecord))
    (ioItemHit (:pointer :SInt16))
    (inRefCon :pointer)
    (userUPP (:pointer :OpaqueQTSModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __QUICKTIMESTREAMING__ */


(provide-interface "QuickTimeStreaming")