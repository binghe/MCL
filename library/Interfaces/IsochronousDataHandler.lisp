(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IsochronousDataHandler.h"
; at Sunday July 2,2006 7:30:08 pm.
; 
;      File:       DVComponentGlue/IsochronousDataHandler.h
;  
;      Contains:   Component Manager based Isochronous Data Handler
;  
;      Copyright:  © 1997-2001 by Apple Computer, Inc., all rights reserved.
;  
;      Warning:    *** APPLE INTERNAL USE ONLY ***
;                  This file may contain unreleased API's
;  
;      BuildInfo:  Built by:            wgulland
;                  On:                  Tue Mar 19 11:37:55 2002
;                  With Interfacer:     3.0d35   (Mac OS X for PowerPC)
;                  From:                IsochronousDataHandler.i
;                      Revision:        1.5
;                      Dated:           2001/10/05 16:46:32
;                      Last change by:  wgulland
;                      Last comment:    Add inputFormat to IDHDeviceStatus structure
;  
;      Bugs:       Report bugs to Radar component "System Interfaces", "Latest"
;                  List the version information (from above) in the Problem Description.
;  
; 
; #ifndef __ISOCHRONOUSDATAHANDLER__
; #define __ISOCHRONOUSDATAHANDLER__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __MOVIESFORMAT__

(require-interface "QuickTime/MoviesFormat")

; #endif

; #ifndef __QUICKTIMECOMPONENTS__

(require-interface "QuickTime/QuickTimeComponents")

; #endif


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

; #if PRAGMA_STRUCT_ALIGN
#| ; #pragma options align=mac68k
 |#

; #elif PRAGMA_STRUCT_PACKPUSH
#| ; #pragma pack(push, 2)
 |#

; #elif PRAGMA_STRUCT_PACK
#| ; #pragma pack(2)
 |#

; #endif


(defconstant $kIDHComponentType :|ihlr|)        ;  Component type

(defconstant $kIDHSubtypeDV :|dv  |)            ;  Subtype for DV (over FireWire)

(defconstant $kIDHSubtypeFireWireConference :|fwc |);  Subtype for FW Conference

;  Version of Isochronous Data Handler API

(defconstant $kIDHInterfaceVersion1 1)          ;  Initial relase (Summer '99)

;  atom types

(defconstant $kIDHDeviceListAtomType :|dlst|)
(defconstant $kIDHDeviceAtomType :|devc|)       ;  to be defined elsewhere

(defconstant $kIDHIsochServiceAtomType :|isoc|)
(defconstant $kIDHIsochModeAtomType :|mode|)
(defconstant $kIDHDeviceIDType :|dvid|)
(defconstant $kIDHDefaultIOType :|dfio|)
(defconstant $kIDHIsochVersionAtomType :|iver|)
(defconstant $kIDHUniqueIDType :|unid|)
(defconstant $kIDHNameAtomType :|name|)
(defconstant $kIDHUseCMPAtomType :|ucmp|)
(defconstant $kIDHIsochMediaType :|av  |)
(defconstant $kIDHDataTypeAtomType :|dtyp|)
(defconstant $kIDHDataSizeAtomType :|dsiz|)     ;  ??? packet size vs. buffer size

(defconstant $kIDHDataBufferSizeAtomType :|dbuf|);  ??? packet size vs. buffer size

(defconstant $kIDHDataIntervalAtomType :|intv|)
(defconstant $kIDHDataIODirectionAtomType :|ddir|)
(defconstant $kIDHSoundMediaAtomType :|soun|)
(defconstant $kIDHSoundTypeAtomType :|type|)
(defconstant $kIDHSoundChannelCountAtomType :|ccnt|)
(defconstant $kIDHSoundSampleSizeAtomType :|ssiz|)
(defconstant $kIDHSoundSampleRateAtomType :|srat|);  same as video out... (what does this comment mean?)

(defconstant $kIDHVideoMediaAtomType :|vide|)
(defconstant $kIDHVideoDimensionsAtomType :|dimn|)
(defconstant $kIDHVideoResolutionAtomType :|resl|)
(defconstant $kIDHVideoRefreshRateAtomType :|refr|)
(defconstant $kIDHVideoPixelTypeAtomType :|pixl|)
(defconstant $kIDHVideoDecompressorAtomType :|deco|)
(defconstant $kIDHVideoDecompressorTypeAtomType :|dety|)
(defconstant $kIDHVideoDecompressorContinuousAtomType :|cont|)
(defconstant $kIDHVideoDecompressorComponentAtomType :|cmpt|)
;  I/O Flags 

(defconstant $kIDHDataTypeIsInput 1)
(defconstant $kIDHDataTypeIsOutput 2)
(defconstant $kIDHDataTypeIsInputAndOutput 4)
;  Permission Flags 

(defconstant $kIDHOpenForReadTransactions 1)
(defconstant $kIDHOpenForWriteTransactions 2)
(defconstant $kIDHOpenWithExclusiveAccess 4)
(defconstant $kIDHOpenWithHeldBuffers 8)        ;  IDH will hold buffer until ReleaseBuffer()

(defconstant $kIDHCloseForReadTransactions 16)
(defconstant $kIDHCloseForWriteTransactions 32)
; 
;    Errors 
;     These REALLY need to be moved into Errors.h
;    ¥¥¥Êneeds officially assigned numbers
; 

(defconstant $kIDHErrDeviceDisconnected -14101)
(defconstant $kIDHErrInvalidDeviceID -14102)
(defconstant $kIDHErrDeviceInUse -14104)
(defconstant $kIDHErrDeviceNotOpened -14105)
(defconstant $kIDHErrDeviceBusy -14106)
(defconstant $kIDHErrDeviceReadError -14107)
(defconstant $kIDHErrDeviceWriteError -14108)
(defconstant $kIDHErrDeviceNotConfigured -14109)
(defconstant $kIDHErrDeviceList -14110)
(defconstant $kIDHErrCompletionPending -14111)
(defconstant $kIDHErrDeviceTimeout -14112)
(defconstant $kIDHErrInvalidIndex -14113)
(defconstant $kIDHErrDeviceCantRead -14114)
(defconstant $kIDHErrDeviceCantWrite -14115)
(defconstant $kIDHErrCallNotSupported -14116)
;  Holds Device Identification...

(def-mactype :IDHDeviceID (find-mactype ':UInt32))

(defconstant $kIDHInvalidDeviceID 0)
(defconstant $kIDHDeviceIDEveryDevice #xFFFFFFFF)
;  Values for 5 bit STYPE part of CIP header

(defconstant $kIDHDV_SD 0)
(defconstant $kIDHDV_SDL 1)
(defconstant $kIDHDV_HD 2)
(defconstant $kIDHDVCPro_25 30)
(defconstant $kIDHDVCPro_50 29)
;   Isoch Interval Atom Data
(defrecord IDHIsochInterval
   (duration :SInt32)
   (scale :signed-long)
)

;type name? (%define-record :IDHIsochInterval (find-record-descriptor ':IDHIsochInterval))
;  Need to fix this.  For now, cast this as a FWReferenceID

(def-mactype :PsuedoID (find-mactype '(:pointer :OpaquePsuedoID)))
; 
;    Isoch Device Status
;     This is atom-like, but isnÕt an atom
; 
(defrecord IDHDeviceStatus
   (version :UInt32)
   (physicallyConnected :Boolean)
   (readEnabled :Boolean)
   (writeEnabled :Boolean)
   (exclusiveAccess :Boolean)
   (currentBandwidth :UInt32)
   (currentChannel :UInt32)
   (localNodeID (:pointer :OpaquePsuedoID))     ; ¥¥¥Êmay go in atoms 
   (inputStandard :SInt16)                      ;  One of the QT input standards
   (deviceActive :Boolean)
   (inputFormat :UInt8)                         ;  Expected STYPE of data from device
   (outputFormats :UInt32)                      ;  Bitmask for supported STYPE values, if version > 0x200
)

;type name? (%define-record :IDHDeviceStatus (find-record-descriptor ':IDHDeviceStatus))
; 
;    Isochronous Data Handler Events
;     
; 

(def-mactype :IDHEvent (find-mactype ':UInt32))

(defconstant $kIDHEventInvalid 0)
(defconstant $kIDHEventDeviceAdded 1)           ;  A new device has been added to the bus

(defconstant $kIDHEventDeviceRemoved 2)         ;  A device has been removed from the bus

(defconstant $kIDHEventDeviceChanged 4)         ;  Some device has changed state on the bus

(defconstant $kIDHEventReadEnabled 8)           ;  A client has enabled a device for read

(defconstant $kIDHEventFrameDropped 16)         ;  software failed to keep up with isoc data flow

(defconstant $kIDHEventReadDisabled 32)         ;  A client has disabled a device from read

(defconstant $kIDHEventWriteEnabled 64)         ;  A client has enabled a device for write

(defconstant $kIDHEventReserved2 #x80)          ;  Reserved for future use

(defconstant $kIDHEventWriteDisabled #x100)     ;  A client has disabled a device for write

(defconstant $kIDHEventEveryEvent #xFFFFFFFF)

(def-mactype :IDHNotificationID (find-mactype ':UInt32))
(defrecord IDHEventHeader
   (deviceID :UInt32)                           ;  Device which generated event
   (notificationID :UInt32)
   (event :UInt32)                              ;  What the event is
)

;type name? (%define-record :IDHEventHeader (find-record-descriptor ':IDHEventHeader))
; 
;    IDHGenericEvent
;     An IDH will often have to post events from at interrupt time.  Since memory
;     allocation cannot occur from the interrupt handler, the IDH can preallocate
;     storage needed for handling the event by creating some IDHGenericEvent items.
;     Subsequently, when an event is generated, the type of event (specified in the
;     IDHEventHeader) will dictate how the IDHGenericEvent should be interpretted.
;     
;     IMPORTANT NOTE : This means that a specific event structure can NEVER be greater
;     than the size of the generic one.
;     
; 
(defrecord IDHGenericEvent
   (eventHeader :IDHEventHeader)
   (pad (:array :UInt32 4))
)

;type name? (%define-record :IDHGenericEvent (find-record-descriptor ':IDHGenericEvent))
; 
;    IDHDeviceConnectionEvent
;     For kIDHEventDeviceAdded or kIDHEventDeviceRemoved events.
; 
(defrecord IDHDeviceConnectionEvent
   (eventHeader :IDHEventHeader)
)

;type name? (%define-record :IDHDeviceConnectionEvent (find-record-descriptor ':IDHDeviceConnectionEvent))
; 
;    IDHDeviceIOEnableEvent
;     For kIDHEventReadEnabled, kIDHEventReadDisabled, kIDHEventWriteEnabled, or
;     kIDHEventWriteDisabled.
; 
(defrecord IDHDeviceIOEnableEvent
   (eventHeader :IDHEventHeader)
)

;type name? (%define-record :IDHDeviceIOEnableEvent (find-record-descriptor ':IDHDeviceIOEnableEvent))
; 
;    IDHDeviceFrameDroppedEvent
;     For kIDHEventFrameDropped
; 
(defrecord IDHDeviceFrameDroppedEvent
   (eventHeader :IDHEventHeader)
   (totalDropped :UInt32)
   (newlyDropped :UInt32)
)

;type name? (%define-record :IDHDeviceFrameDroppedEvent (find-record-descriptor ':IDHDeviceFrameDroppedEvent))

(def-mactype :IDHNotificationProcPtr (find-mactype ':pointer)); (IDHGenericEvent * event , void * userData)

(def-mactype :IDHNotificationProc (find-mactype ':pointer))

(def-mactype :IDHNotificationUPP (find-mactype '(:pointer :OpaqueIDHNotificationProcPtr)))
(defrecord IDHParameterBlock
   (reserved1 :UInt32)
   (reserved2 :UInt16)
   (buffer :pointer)
   (requestedCount :UInt32)
   (actualCount :UInt32)
   (completionProc (:pointer :OpaqueIDHNotificationProcPtr))
   (refCon :pointer)
   (result :SInt16)
)

;type name? (%define-record :IDHParameterBlock (find-record-descriptor ':IDHParameterBlock))
(defrecord IDHResolution
   (x :UInt32)
   (y :UInt32)
)

;type name? (%define-record :IDHResolution (find-record-descriptor ':IDHResolution))
(defrecord IDHDimension
   (x :signed-long)
   (y :signed-long)
)

;type name? (%define-record :IDHDimension (find-record-descriptor ':IDHDimension))
; 
;  *  IDHGetDeviceList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHGetDeviceList" 
   ((idh (:pointer :ComponentInstanceRecord))
    (deviceList (:pointer :QTATOMCONTAINER))
   )
   :signed-long
() )
; 
;  *  IDHGetDeviceConfiguration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHGetDeviceConfiguration" 
   ((idh (:pointer :ComponentInstanceRecord))
    (configurationID (:pointer :QTAtomSpec))
   )
   :signed-long
() )
; 
;  *  IDHSetDeviceConfiguration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHSetDeviceConfiguration" 
   ((idh (:pointer :ComponentInstanceRecord))
    (configurationID (:pointer :QTAtomSpec))
   )
   :signed-long
() )
; 
;  *  IDHGetDeviceStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHGetDeviceStatus" 
   ((idh (:pointer :ComponentInstanceRecord))
    (configurationID (:pointer :QTAtomSpec))
    (status (:pointer :IDHDeviceStatus))
   )
   :signed-long
() )
; 
;  *  IDHGetDeviceClock()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHGetDeviceClock" 
   ((idh (:pointer :ComponentInstanceRecord))
    (clock (:pointer :Component))
   )
   :signed-long
() )
; 
;  *  IDHOpenDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHOpenDevice" 
   ((idh (:pointer :ComponentInstanceRecord))
    (permissions :UInt32)
   )
   :signed-long
() )
; 
;  *  IDHCloseDevice()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHCloseDevice" 
   ((idh (:pointer :ComponentInstanceRecord))
   )
   :signed-long
() )
; 
;  *  IDHRead()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHRead" 
   ((idh (:pointer :ComponentInstanceRecord))
    (pb (:pointer :IDHParameterBlock))
   )
   :signed-long
() )
; 
;  *  IDHWrite()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHWrite" 
   ((idh (:pointer :ComponentInstanceRecord))
    (pb (:pointer :IDHParameterBlock))
   )
   :signed-long
() )
; 
;  *  IDHNewNotification()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHNewNotification" 
   ((idh (:pointer :ComponentInstanceRecord))
    (deviceID :UInt32)
    (notificationProc (:pointer :OpaqueIDHNotificationProcPtr))
    (userData :pointer)
    (notificationID (:pointer :IDHNOTIFICATIONID))
   )
   :signed-long
() )
; 
;  *  IDHNotifyMeWhen()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHNotifyMeWhen" 
   ((idh (:pointer :ComponentInstanceRecord))
    (notificationID :UInt32)
    (events :UInt32)
   )
   :signed-long
() )
; 
;  *  IDHCancelNotification()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHCancelNotification" 
   ((idh (:pointer :ComponentInstanceRecord))
    (notificationID :UInt32)
   )
   :signed-long
() )
; 
;  *  IDHDisposeNotification()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHDisposeNotification" 
   ((idh (:pointer :ComponentInstanceRecord))
    (notificationID :UInt32)
   )
   :signed-long
() )
; 
;  *  IDHReleaseBuffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHReleaseBuffer" 
   ((idh (:pointer :ComponentInstanceRecord))
    (pb (:pointer :IDHParameterBlock))
   )
   :signed-long
() )
; 
;  *  IDHCancelPendingIO()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHCancelPendingIO" 
   ((idh (:pointer :ComponentInstanceRecord))
    (pb (:pointer :IDHParameterBlock))
   )
   :signed-long
() )
; 
;  *  IDHGetDeviceControl()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHGetDeviceControl" 
   ((idh (:pointer :ComponentInstanceRecord))
    (deviceControl (:pointer :ComponentInstance))
   )
   :signed-long
() )
; 
;  *  IDHUpdateDeviceList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in IDHLib 1.0 and later
;  

(deftrap-inline "_IDHUpdateDeviceList" 
   ((idh (:pointer :ComponentInstanceRecord))
    (deviceList (:pointer :QTATOMCONTAINER))
   )
   :signed-long
() )
; 
;  *  IDHGetDeviceTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IDHGetDeviceTime" 
   ((idh (:pointer :ComponentInstanceRecord))
    (deviceTime (:pointer :TimeRecord))
   )
   :signed-long
() )
; 
;  *  IDHSetFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IDHSetFormat" 
   ((idh (:pointer :ComponentInstanceRecord))
    (format :UInt32)
   )
   :signed-long
() )
; 
;  *  IDHGetFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IDHGetFormat" 
   ((idh (:pointer :ComponentInstanceRecord))
    (format (:pointer :UInt32))
   )
   :signed-long
() )
; 
;  *  NewIDHNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewIDHNotificationUPP" 
   ((userRoutine :pointer)
   )
   (:pointer :OpaqueIDHNotificationProcPtr)
() )
; 
;  *  DisposeIDHNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeIDHNotificationUPP" 
   ((userUPP (:pointer :OpaqueIDHNotificationProcPtr))
   )
   nil
() )
; 
;  *  InvokeIDHNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in DVComponentGlue.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeIDHNotificationUPP" 
   ((event (:pointer :IDHGenericEvent))
    (userData :pointer)
    (userUPP (:pointer :OpaqueIDHNotificationProcPtr))
   )
   :OSStatus
() )
;  selectors for component calls 

(defconstant $kIDHGetDeviceListSelect 1)
(defconstant $kIDHGetDeviceConfigurationSelect 2)
(defconstant $kIDHSetDeviceConfigurationSelect 3)
(defconstant $kIDHGetDeviceStatusSelect 4)
(defconstant $kIDHGetDeviceClockSelect 5)
(defconstant $kIDHOpenDeviceSelect 6)
(defconstant $kIDHCloseDeviceSelect 7)
(defconstant $kIDHReadSelect 8)
(defconstant $kIDHWriteSelect 9)
(defconstant $kIDHNewNotificationSelect 10)
(defconstant $kIDHNotifyMeWhenSelect 11)
(defconstant $kIDHCancelNotificationSelect 12)
(defconstant $kIDHDisposeNotificationSelect 13)
(defconstant $kIDHReleaseBufferSelect 14)
(defconstant $kIDHCancelPendingIOSelect 15)
(defconstant $kIDHGetDeviceControlSelect 16)
(defconstant $kIDHUpdateDeviceListSelect 17)
(defconstant $kIDHGetDeviceTimeSelect 18)
(defconstant $kIDHSetFormatSelect 19)
(defconstant $kIDHGetFormatSelect 20)

; #if PRAGMA_STRUCT_ALIGN
#| ; #pragma options align=reset
 |#

; #elif PRAGMA_STRUCT_PACKPUSH
#| ; #pragma pack(pop)
 |#

; #elif PRAGMA_STRUCT_PACK
#| ; #pragma pack()
 |#

; #endif

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __ISOCHRONOUSDATAHANDLER__ */


(provide-interface "IsochronousDataHandler")