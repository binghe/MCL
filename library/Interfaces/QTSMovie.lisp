(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:QTSMovie.h"
; at Sunday July 2,2006 7:31:20 pm.
; 
;      File:       QuickTime/QTSMovie.h
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
; #ifndef __QTSMOVIE__
; #define __QTSMOVIE__
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

(require-interface "QuickTime/QuickTimeStreaming")

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

(defconstant $kQTSStreamMediaType :|strm|)
(defrecord QTSSampleDescription
   (descSize :signed-long)
   (dataFormat :signed-long)
   (resvd1 :signed-long)                        ;  set to 0
   (resvd2 :SInt16)                             ;  set to 0
   (dataRefIndex :SInt16)
   (version :UInt32)
   (resvd3 :UInt32)                             ;  set to 0
   (flags :SInt32)
                                                ;  qt atoms follow:
                                                ;       long size, long type, some data
                                                ;       repeat as necessary
)

;type name? (%define-record :QTSSampleDescription (find-record-descriptor ':QTSSampleDescription))

(def-mactype :QTSSampleDescriptionPtr (find-mactype '(:pointer :QTSSampleDescription)))

(def-mactype :QTSSampleDescriptionHandle (find-mactype '(:handle :QTSSampleDescription)))

(defconstant $kQTSSampleDescriptionVersion1 1)

(defconstant $kQTSDefaultMediaTimeScale #x258)
;  sample description flags

(defconstant $kQTSSampleDescPassSampleDataAsHandleFlag 1)
; ============================================================================
;         Stream Media Handler
; ============================================================================
; -----------------------------------------
;     Info Selectors
; -----------------------------------------
;  all indexes start at 1 

(defconstant $kQTSMediaPresentationInfo :|pres|);  QTSMediaPresentationParams* 

(defconstant $kQTSMediaNotificationInfo :|noti|);  QTSMediaNotificationParams* 

(defconstant $kQTSMediaTotalDataRateInfo :|dtrt|);  UInt32*, bits/sec 

(defconstant $kQTSMediaLostPercentInfo :|lspc|) ;  Fixed* 

(defconstant $kQTSMediaNumStreamsInfo :|nstr|)  ;  UInt32* 

(defconstant $kQTSMediaIndSampleDescriptionInfo :|isdc|);  QTSMediaIndSampleDescriptionParams* 

(defrecord QTSMediaPresentationParams
   (presentationID (:pointer :QTSPresentationRecord))
)

;type name? (%define-record :QTSMediaPresentationParams (find-record-descriptor ':QTSMediaPresentationParams))
(defrecord QTSMediaNotificationParams
   (notificationProc (:pointer :OpaqueQTSNotificationProcPtr))
   (notificationRefCon :pointer)
   (flags :SInt32)
)

;type name? (%define-record :QTSMediaNotificationParams (find-record-descriptor ':QTSMediaNotificationParams))
(defrecord QTSMediaIndSampleDescriptionParams
   (index :SInt32)
   (returnedMediaType :OSType)
   (returnedSampleDescription (:Handle :SampleDescription))
)

;type name? (%define-record :QTSMediaIndSampleDescriptionParams (find-record-descriptor ':QTSMediaIndSampleDescriptionParams))
; -----------------------------------------
;     QTS Media Handler Selectors
; -----------------------------------------

(defconstant $kQTSMediaSetInfoSelect #x100)
(defconstant $kQTSMediaGetInfoSelect #x101)
(defconstant $kQTSMediaSetIndStreamInfoSelect #x102)
(defconstant $kQTSMediaGetIndStreamInfoSelect #x103)
; -----------------------------------------
;     QTS Media Handler functions
; -----------------------------------------
; 
;  *  QTSMediaSetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSMediaSetInfo" 
   ((mh (:pointer :ComponentInstanceRecord))
    (inSelector :OSType)
    (ioParams :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTSMediaGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSMediaGetInfo" 
   ((mh (:pointer :ComponentInstanceRecord))
    (inSelector :OSType)
    (ioParams :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTSMediaSetIndStreamInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSMediaSetIndStreamInfo" 
   ((mh (:pointer :ComponentInstanceRecord))
    (inIndex :SInt32)
    (inSelector :OSType)
    (ioParams :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  QTSMediaGetIndStreamInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in QuickTime.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in QTStreamLib 4.0 and later
;  *    Windows:          in QTSClient.lib 4.0 and later
;  

(deftrap-inline "_QTSMediaGetIndStreamInfo" 
   ((mh (:pointer :ComponentInstanceRecord))
    (inIndex :SInt32)
    (inSelector :OSType)
    (ioParams :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; ============================================================================
;         Hint Media Handler
; ============================================================================

(defconstant $kQTSHintMediaType :|hint|)

(defconstant $kQTSHintTrackReference :|hint|)
;  MixedMode ProcInfo constants for component calls 

(defconstant $uppQTSMediaSetInfoProcInfo #xFF0)
(defconstant $uppQTSMediaGetInfoProcInfo #xFF0)
(defconstant $uppQTSMediaSetIndStreamInfoProcInfo #x3FF0)
(defconstant $uppQTSMediaGetIndStreamInfoProcInfo #x3FF0)
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __QTSMOVIE__ */


(provide-interface "QTSMovie")