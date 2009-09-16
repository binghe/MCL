(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DVFamily.h"
; at Sunday July 2,2006 7:27:44 pm.
; 
; 	File:		DVFamily.h
; 
; 	Copyright:	© 2001 by Apple Computer, Inc., all rights reserved.
; 
; 
; 
; 	DVFamily.h
; 
; #ifndef __DVFAMILY__
; #define __DVFAMILY__

(require-interface "IOKit/avc/IOFireWireAVCConsts")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; /////////////////////////////////////////////////////////////////////
; 
;  constants
; 
; /////////////////////////////////////////////////////////////////////

(defconstant $kInvalidDVDeviceID 0)
(defconstant $kEveryDVDeviceID #xFFFFFFFF)
(defconstant $kInvalidDVConnectionID 0)
(defconstant $kInvalidDVDeviceRefNum 0)
(defconstant $kEveryDVDeviceRefNum #xFFFFFFFF)

(defconstant $kDVDisconnectedErr -14101)
(defconstant $kDVBadIDErr -14102)
(defconstant $kUnknownStandardErr -14103)
(defconstant $kAlreadyEnabledErr -14104)
(defconstant $kNotEnabledErr -14105)
(defconstant $kDVDeviceBusyErr -14106)
(defconstant $kDVNoNotificationsErr -14107)

(defconstant $kUnknownStandard 0)
(defconstant $kNTSCStandard 1)
(defconstant $kPALStandard 2)
;  DV events

(defconstant $kInvalidDVDeviceEvent 0)
(defconstant $kDVDeviceAdded 1)
(defconstant $kDVDeviceRemoved 2)
(defconstant $KDVDeviceInfoChanged 4)
(defconstant $kDVIsochReadEnabled 8)
(defconstant $kDVIsochReadComplete 16)
(defconstant $kDVIsochReadDisabled 32)
(defconstant $kDVIsochWriteEnabled 64)
(defconstant $kDVIsochWriteComplete #x80)
(defconstant $kDVIsochWriteDisabled #x100)
(defconstant $kDVAVCEnabled #x200)
(defconstant $kDVAVCDisabled #x400)
(defconstant $kDVAVCTransactionComplete #x800)  ;  Tempory new event for input. Goes away DVFamily is dead.

(defconstant $kDVInputEvent #x1000)
(defconstant $kDVEveryEvent #x1FFF)

(defconstant $kDVGlobalEventConnectionID #xFFFFFFFF)
(defconstant $kEventSpecificDataSize 16)
; /////////////////////////////////////////////////////////////////////
; 
;  types
; 
; /////////////////////////////////////////////////////////////////////
;  holds our device identification...

(def-mactype :DVDeviceID (find-mactype ':UInt32))
;  holds our device connection identification...

(def-mactype :DVDeviceRefNum (find-mactype ':UInt32))

(def-mactype :DVClientID (find-mactype ':UInt32))
;  AVC

(defconstant $kAVCSupportInquiryCommand 2)
(defconstant $kAVCReportInquiryCommand 3)       ;  Opcodes and parameters

(defconstant $kAVCWindOpcode #xC4)
(defconstant $kAVCWindHighSpeedRewind 69)
(defconstant $kAVCWindStop 96)
(defconstant $kAVCWindRewind 101)
(defconstant $kAVCWindFastForward 117)
(defconstant $kAVCPlayOpcode #xC3)
(defconstant $kAVCPlayNextFrame 48)
(defconstant $kAVCPlaySlowest 49)
(defconstant $kAVCPlaySlow6 50)
(defconstant $kAVCPlaySlow5 51)
(defconstant $kAVCPlaySlow4 52)
(defconstant $kAVCPlaySlow3 53)
(defconstant $kAVCPlaySlow2 54)
(defconstant $kAVCPlaySlow1 55)
(defconstant $kAVCPlay1x 56)
(defconstant $kAVCPlayFast1 57)
(defconstant $kAVCPlayFast2 58)
(defconstant $kAVCPlayFast3 59)
(defconstant $kAVCPlayFast4 60)
(defconstant $kAVCPlayFast5 61)
(defconstant $kAVCPlayFast6 62)
(defconstant $kAVCPlayFastest 63)
(defconstant $kAVCPlayPreviousFrame 64)
(defconstant $kAVCPlayRevSlowest 65)
(defconstant $kAVCPlayRevSlow6 66)
(defconstant $kAVCPlayRevSlow5 67)
(defconstant $kAVCPlayRevSlow4 68)
(defconstant $kAVCPlayRevSlow3 69)
(defconstant $kAVCPlayRevSlow2 70)
(defconstant $kAVCPlayRevSlow1 71)
(defconstant $kAVCPlayRev1x 72)
(defconstant $kAVCPlayRevFast1 73)
(defconstant $kAVCPlayRevFast2 74)
(defconstant $kAVCPlayRevFast3 75)
(defconstant $kAVCPlayRevFast4 76)
(defconstant $kAVCPlayRevFast5 77)
(defconstant $kAVCPlayRevFast6 78)
(defconstant $kAVCPlayRevFastest 79)
(defconstant $kAVCPlayForward 117)
(defconstant $kAVCPlayForwardPause 125)
(defconstant $kAVCPlayReverse 101)
(defconstant $kAVCPlayReversePause 109)
(defconstant $kAVCMediumOpcode #xC1)
(defconstant $kAVCMediumEject 96)
(defconstant $kAVCMediumTrayOpen 49)
(defconstant $kAVCMediumTrayClose 50)
(defconstant $kAVCRecordOpcode #xC2)
(defconstant $kAVCRecVideoInsert 49)
(defconstant $kAVCRecAudioInsert 50)
(defconstant $kAVCRecAVInsert 51)
(defconstant $kAVCRecSubcodeInsert 52)
(defconstant $kAVCRecord 117)
(defconstant $kAVCRecPause 125)
(defconstant $kAVCRecVideoInsertPause 65)
(defconstant $kAVCRecAudioInsertPause 66)
(defconstant $kAVCRecAVInsertPause 67)
(defconstant $kAVCRecSubcodeInsertPause 68)
(defconstant $kAVCRecSpeedOpcode #xDB)
(defconstant $kAVCRecSpeedLowSpeed 0)
(defconstant $kAVCRecSpeed32 32)
(defconstant $kAVCRecSpeedStandard 111)
(defconstant $kAVCRecSpeedHighSpeed #xFE)
(defconstant $kAVCRecSpeedDummyOperand 127)
(defconstant $kAVCEditPresetOpcode 69)
(defconstant $kAVCEditPreRollAndStandby 0)
(defconstant $kAVCEditVideoInsert 33)
(defconstant $kAVCEditAudioInsert 34)
(defconstant $kAVCEditAVInsert 35)
(defconstant $kAVCEditSubcodeInsert 36)
(defconstant $kAVCEditSyncRecord 37)
(defconstant $kAVCEditSyncPlay 53)
(defconstant $kAVCEditOtherMode 96)
(defconstant $kAVCEditInPoint 0)
(defconstant $kAVCEditOutPoint 1)
(defconstant $kAVCEditPreRollTime 2)
(defconstant $kAVCEditDummyOperand #xFF)
(defconstant $kAVCPositionDummyOperand #xFF)
(defconstant $kAVCPositionTimeCodeOpcode 81)
(defconstant $kAVCPositionValueInquiry 113)
(defconstant $kAVCMechaModeInquiryOpcode #xD0)
(defconstant $kAVCMechaModeDummyOperand 127)
(defrecord AVCCTSFrameStruct
   (cmdType_respCode :UInt8)                    ;  cmd type/resp onse code
   (headerAddress :UInt8)
   (opcode :UInt8)
   (operand (:array :UInt8 5))
)

(def-mactype :AVCCTSFrameStructPtr (find-mactype '(:POINTER :AVCCTSFRAMESTRUCT)))
;  for sending AVC commands
(defrecord AVCTransactionParamsStruct
   (commandBufferPtr :pointer)
   (commandLength :UInt32)
   (responseBufferPtr :pointer)
   (responseBufferSize :UInt32)
   (responseHandler :pointer)
                                                ;  Obsolete
)
(%define-record :AVCTransactionParams (find-record-descriptor :AVCTRANSACTIONPARAMSSTRUCT))

(def-mactype :AVCTransactionParamsPtr (find-mactype '(:POINTER :AVCTRANSACTIONPARAMSSTRUCT)))
; /////////////////////////////////////////////////////////////////////
; 
;  DV Event Notification
; 

(def-mactype :DVNotificationID (find-mactype '(:pointer :OpaqueRef)))
(defrecord DVEventHeaderStruct
   (deviceID :UInt32)
                                                ;  who it's from
   (notifID (:pointer :OpaqueRef))
   (theEvent :UInt32)
                                                ;  what the event was
)
(%define-record :DVEventHeader (find-record-descriptor :DVEVENTHEADERSTRUCT))

(def-mactype :DVEventHeaderPtr (find-mactype '(:POINTER :DVEVENTHEADERSTRUCT)))
(defrecord DVEventRecordStruct
                                                ;  generalized form
   (eventHeader :DVEVENTHEADERSTRUCT)
   (eventData (:array :UInt8 16))
)
(%define-record :DVEventRecord (find-record-descriptor :DVEVENTRECORDSTRUCT))

(def-mactype :DVEventRecordPtr (find-mactype '(:POINTER :DVEVENTRECORDSTRUCT)))
(defrecord DVConnectionEventStruct
   (eventHeader :DVEVENTHEADERSTRUCT)
)
(%define-record :DVConnectionEvent (find-record-descriptor :DVCONNECTIONEVENTSTRUCT))

(def-mactype :DVConnectionEventPtr (find-mactype '(:POINTER :DVCONNECTIONEVENTSTRUCT)))
(defrecord DVIsochCompleteEventStruct
   (eventHeader :DVEVENTHEADERSTRUCT)
   (pFrameBuffer :pointer)
   (bufferSize :UInt32)
   (fwCycleTime :UInt32)
)
(%define-record :DVIsochCompleteEvent (find-record-descriptor :DVISOCHCOMPLETEEVENTSTRUCT))

(def-mactype :DVIsochCompleteEventPtr (find-mactype '(:POINTER :DVISOCHCOMPLETEEVENTSTRUCT)))
(defrecord DVAVTransactionCompleteEventStruct
   (eventHeader :DVEVENTHEADERSTRUCT)
   (commandBufferPtr :pointer)
   (commandLength :UInt32)
   (responseBufferPtr :pointer)
   (responseBufferSize :UInt32)
)
(%define-record :DVAVCTransactionCompleteEvent (find-record-descriptor :DVAVTRANSACTIONCOMPLETEEVENTSTRUCT))

(def-mactype :DVAVCTransactionCompleteEventPtr (find-mactype '(:POINTER :DVAVTRANSACTIONCOMPLETEEVENTSTRUCT)))
;  DV notification proc

(def-mactype :DVNotifyProc (find-mactype ':pointer)); (DVEventRecordPtr event , void * userData)
; /////////////////////////////////////////////////////////////////////
; 
;  external prototypes
; 
; /////////////////////////////////////////////////////////////////////
; /////////////////////////////////////////////////////////////////////
; 
;  general device management
; 

(deftrap-inline "_DVCountDevices" 
   (
   )
   :UInt32
() )

(deftrap-inline "_DVGetIndDevice" 
   ((pDVDevice (:pointer :DVDEVICEID))
    (index :UInt32)
   )
   :SInt16
() )

(deftrap-inline "_DVSetDeviceName" 
   ((deviceID :UInt32)
    (str (:pointer :char))
   )
   :SInt16
() )

(deftrap-inline "_DVGetDeviceName" 
   ((deviceID :UInt32)
    (str (:pointer :char))
   )
   :SInt16
() )

(deftrap-inline "_DVOpenDriver" 
   ((deviceID :UInt32)
    (pRefNum (:pointer :DVDEVICEREFNUM))
   )
   :SInt16
() )

(deftrap-inline "_DVCloseDriver" 
   ((refNum :UInt32)
   )
   :SInt16
() )
; OSErr DVGetDeviceInfo( DVDeviceID deviceID, DVDeviceInfoPtr pInfo );
; OSErr DVGetDeviceClock( DVDeviceID deviceID, Component *clock );
; /////////////////////////////////////////////////////////////////////
; 
;  DV event notification
; 
;  kEveryDVDeviceRefNum can be used as a wild card refNum, for notifications about all
;  devices - especially handy when there aren't any yet!
; 

(deftrap-inline "_DVNewNotification" 
   ((refNum :UInt32)
    (notifyProc :pointer)
    (userData :pointer)
    (pNotifyID (:pointer :DVNOTIFICATIONID))
   )
   :SInt16
() )

(deftrap-inline "_DVNotifyMeWhen" 
   ((refNum :UInt32)
    (notifyID (:pointer :OpaqueRef))
    (events :UInt32)
   )
   :SInt16
() )

(deftrap-inline "_DVCancelNotification" 
   ((refNum :UInt32)
    (notifyID (:pointer :OpaqueRef))
   )
   :SInt16
() )

(deftrap-inline "_DVDisposeNotification" 
   ((refNum :UInt32)
    (notifyID (:pointer :OpaqueRef))
   )
   :SInt16
() )
; /////////////////////////////////////////////////////////////////////
; 
;  DV Isoch Read
; 

(deftrap-inline "_DVEnableRead" 
   ((refNum :UInt32)
   )
   :SInt16
() )

(deftrap-inline "_DVDisableRead" 
   ((refNum :UInt32)
   )
   :SInt16
() )

(deftrap-inline "_DVReadFrame" 
   ((refNum :UInt32)
    (ppReadBuffer (:pointer :Ptr))
    (pSize (:pointer :UInt32))
   )
   :SInt16
() )

(deftrap-inline "_DVReleaseFrame" 
   ((refNum :UInt32)
    (pReadBuffer :pointer)
   )
   :SInt16
() )
; /////////////////////////////////////////////////////////////////////
; 
;  DV Isoch Write
; 

(deftrap-inline "_DVEnableWrite" 
   ((refNum :UInt32)
   )
   :SInt16
() )

(deftrap-inline "_DVDisableWrite" 
   ((refNum :UInt32)
   )
   :SInt16
() )

(deftrap-inline "_DVGetEmptyFrame" 
   ((refNum :UInt32)
    (ppEmptyFrameBuffer (:pointer :Ptr))
    (pSize (:pointer :UInt32))
   )
   :SInt16
() )

(deftrap-inline "_DVWriteFrame" 
   ((refNum :UInt32)
    (pWriteBuffer :pointer)
   )
   :SInt16
() )

(deftrap-inline "_DVSetWriteSignalMode" 
   ((refNum :UInt32)
    (mode :UInt8)
   )
   :SInt16
() )
; /////////////////////////////////////////////////////////////////////
; 
;  AVC transactions
; 

(deftrap-inline "_DVDoAVCTransaction" 
   ((refNum :UInt32)
    (pParams (:pointer (:pointer :AVCTRANSACTIONPARAMSSTRUCT)))
   )
   :SInt16
() )

(deftrap-inline "_DVIsEnabled" 
   ((refNum :UInt32)
    (isEnabled (:pointer :Boolean))
   )
   :SInt16
() )

(deftrap-inline "_DVGetDeviceStandard" 
   ((refNum :UInt32)
    (pStandard (:pointer :UInt32))
   )
   :SInt16
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif __DVFAMILY__


(provide-interface "DVFamily")