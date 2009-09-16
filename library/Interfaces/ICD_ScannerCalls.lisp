(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ICD_ScannerCalls.h"
; at Sunday July 2,2006 7:27:57 pm.
; 
;  File:       ICADevices/ICA_ScannerCalls.h
; 
;  Contains:   Scanner module related interfaces
; 
;  Copyright:  © 2000-2002 by Apple Computer, Inc., all rights reserved.
; 
; 
;  Bugs?:      For bug reports, consult the following page on
;  the World Wide Web:
; 
;  http://developer.apple.com/bugreporter/
; 
;  
; #ifndef __ICD_ScannerCalls__
; #define __ICD_ScannerCalls__

(require-interface "Carbon/Carbon")

(require-interface "CoreFoundation/CoreFoundation")

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

;  DataTypes for _ICD_ReadFileData/_ICD_WriteFileData 

(defconstant $kICS_FileData :|file|)
(defconstant $kICS_ThumbnailData :|thum|)
(defconstant $kICS_MetaData :|meta|)
(defrecord ScannerObjectInfo
   (icaObject (:pointer :OpaqueICAObject))
                                                ;  Apple
   (reserved :UInt32)
                                                ;  Apple
   (icaObjectInfo :ICAObjectInfo)
                                                ;  vendor
   (uniqueID :UInt32)
                                                ;  vendor
   (uniqueIDFireWire :uint64)
                                                ;  vendor
   (thumbnailSize :UInt32)
                                                ;  vendor
   (dataSize :UInt32)
                                                ;  vendor
   (dataWidth :UInt32)
                                                ;  vendor
   (dataHeight :UInt32)
                                                ;  vendor
   (name (:array :UInt8 32))
                                                ;  vendor
   (creationDate (:array :UInt8 20))
                                                ;  vendor
   (flags :UInt32)
                                                ;  vendor
   (privateData :pointer)
                                                ;  vendor
)
(defrecord ICD_ScannerGetPropertyDataPB
   (header :ICDHEADER)
   (parentObject (:pointer :OpaqueICAObject))   ;  <-- 
   (parentObjectInfo :ICAObjectInfo)            ;  <-- 
   (connectionID (:pointer :OpaqueICAConnectionID));  <-- 
   (property (:pointer :OpaqueICAProperty))     ;  <-- 
   (propertyInfo :ICAPropertyInfo)              ;  <-- 
   (startByte :UInt32)                          ;  <-- 
   (requestedSize :UInt32)                      ;  <-- 
   (dataPtr :pointer)                           ;  <-> 
   (actualSize :UInt32)                         ;  --> 
   (dataType :OSType)                           ;  --> 
)

;type name? (%define-record :ICD_ScannerGetPropertyDataPB (find-record-descriptor ':ICD_ScannerGetPropertyDataPB))
(defrecord ICD_ScannerSetPropertyDataPB
   (header :ICDHEADER)
   (parentObject (:pointer :OpaqueICAObject))   ;  <-- 
   (parentObjectInfo :ICAObjectInfo)            ;  <-- 
   (connectionID (:pointer :OpaqueICAConnectionID));  <-- 
   (property (:pointer :OpaqueICAProperty))     ;  <-- 
   (propertyInfo :ICAPropertyInfo)              ;  <-- 
   (startByte :UInt32)                          ;  <-- 
   (dataPtr :pointer)                           ;  <-- 
   (dataSize :UInt32)                           ;  <-- 
   (totalDataSize :UInt32)                      ;  <-- 
   (dataType :OSType)                           ;  <-- 
)

;type name? (%define-record :ICD_ScannerSetPropertyDataPB (find-record-descriptor ':ICD_ScannerSetPropertyDataPB))
(defrecord ICD_ScannerObjectSendMessagePB
   (header :ICDHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (objectInfo :ICAObjectInfo)
                                                ;  <-- 
   (connectionID (:pointer :OpaqueICAConnectionID));  <-- 
   (message :ICAMessage)                        ;  <-- 
   (totalDataSize :UInt32)                      ;  <-- 
   (result :UInt32)                             ;  --> 
)

;type name? (%define-record :ICD_ScannerObjectSendMessagePB (find-record-descriptor ':ICD_ScannerObjectSendMessagePB))
(defrecord ICD_ScannerOpenSessionPB
   (header :ICDHEADER)
   (object (:pointer :OpaqueICAObject))
                                                ;  <-- 
   (objectInfo :ICAObjectInfo)
                                                ;  <-- 
   (connectionID (:pointer :OpaqueICAConnectionID))
                                                ;  <-- 
   (sessionID (:pointer :OpaqueICAScannerSessionID))
                                                ;  <-- 
)

;type name? (%define-record :ICD_ScannerOpenSessionPB (find-record-descriptor ':ICD_ScannerOpenSessionPB))
(defrecord ICD_ScannerCloseSessionPB
   (header :ICDHEADER)
   (object (:pointer :OpaqueICAObject))
                                                ;  <-- 
   (objectInfo :ICAObjectInfo)
                                                ;  <-- 
   (connectionID (:pointer :OpaqueICAConnectionID))
                                                ;  <-- 
   (sessionID (:pointer :OpaqueICAScannerSessionID));  <-- 
)

;type name? (%define-record :ICD_ScannerCloseSessionPB (find-record-descriptor ':ICD_ScannerCloseSessionPB))
(defrecord ICD_ScannerInitializePB
   (header :ICDHEADER)
   (object (:pointer :OpaqueICAObject))
                                                ;  <-- 
   (objectInfo :ICAObjectInfo)
                                                ;  <-- 
   (connectionID (:pointer :OpaqueICAConnectionID))
                                                ;  <-- 
   (sessionID (:pointer :OpaqueICAScannerSessionID))
                                                ;  <-- 
)

;type name? (%define-record :ICD_ScannerInitializePB (find-record-descriptor ':ICD_ScannerInitializePB))
(defrecord ICD_ScannerGetParametersPB
   (header :ICDHEADER)
   (object (:pointer :OpaqueICAObject))
                                                ;  <-- 
   (objectInfo :ICAObjectInfo)
                                                ;  <-- 
   (connectionID (:pointer :OpaqueICAConnectionID))
                                                ;  <-- 
   (sessionID (:pointer :OpaqueICAScannerSessionID))
                                                ;  <-- 
   (theDict (:pointer :__CFDictionary))
                                                ;  <-> 
)

;type name? (%define-record :ICD_ScannerGetParametersPB (find-record-descriptor ':ICD_ScannerGetParametersPB))
(defrecord ICD_ScannerSetParametersPB
   (header :ICDHEADER)
   (object (:pointer :OpaqueICAObject))
                                                ;  <-- 
   (objectInfo :ICAObjectInfo)
                                                ;  <-- 
   (connectionID (:pointer :OpaqueICAConnectionID))
                                                ;  <-- 
   (sessionID (:pointer :OpaqueICAScannerSessionID))
                                                ;  <-- 
   (theDict (:pointer :__CFDictionary))
                                                ;  <-> 
)

;type name? (%define-record :ICD_ScannerSetParametersPB (find-record-descriptor ':ICD_ScannerSetParametersPB))
(defrecord ICD_ScannerStatusPB
   (header :ICDHEADER)
   (object (:pointer :OpaqueICAObject))
                                                ;  <-- 
   (objectInfo :ICAObjectInfo)
                                                ;  <-- 
   (connectionID (:pointer :OpaqueICAConnectionID))
                                                ;  <-- 
   (sessionID (:pointer :OpaqueICAScannerSessionID))
                                                ;  <-- 
   (status :UInt32)
                                                ;  --> 
)

;type name? (%define-record :ICD_ScannerStatusPB (find-record-descriptor ':ICD_ScannerStatusPB))
(defrecord ICD_ScannerStartPB
   (header :ICDHEADER)
   (object (:pointer :OpaqueICAObject))
                                                ;  <-- 
   (objectInfo :ICAObjectInfo)
                                                ;  <-- 
   (connectionID (:pointer :OpaqueICAConnectionID))
                                                ;  <-- 
   (sessionID (:pointer :OpaqueICAScannerSessionID))
                                                ;  <-- 
)

;type name? (%define-record :ICD_ScannerStartPB (find-record-descriptor ':ICD_ScannerStartPB))

(def-mactype :__ICD_ScannerOpenUSBDevice (find-mactype ':pointer)); (UInt32 locationID , ScannerObjectInfo * objectInfo)

(def-mactype :__ICD_ScannerOpenUSBDeviceWithIORegPath (find-mactype ':pointer)); (UInt32 locationID , io_string_t ioregPath , ScannerObjectInfo * objectInfo)

(def-mactype :__ICD_ScannerOpenFireWireDevice (find-mactype ':pointer)); (UInt64 guid , ScannerObjectInfo * objectInfo)

(def-mactype :__ICD_ScannerOpenFireWireDeviceWithIORegPath (find-mactype ':pointer)); (UInt64 guid , io_string_t ioregPath , ScannerObjectInfo * objectInfo)

(def-mactype :__ICD_ScannerCloseDevice (find-mactype ':pointer)); (ScannerObjectInfo * objectInfo)

(def-mactype :__ICD_ScannerPeriodicTask (find-mactype ':pointer)); (ScannerObjectInfo * objectInfo)
;  index is zero based 

(def-mactype :__ICD_ScannerGetObjectInfo (find-mactype ':pointer)); (const ScannerObjectInfo * parentInfo , UInt32 index , ScannerObjectInfo * newInfo)

(def-mactype :__ICD_ScannerCleanup (find-mactype ':pointer)); (ScannerObjectInfo * objectInfo)

(def-mactype :__ICD_ScannerGetPropertyData (find-mactype ':pointer)); (const ScannerObjectInfo * objectInfo , ICD_ScannerGetPropertyDataPB * pb)

(def-mactype :__ICD_ScannerSetPropertyData (find-mactype ':pointer)); (const ScannerObjectInfo * objectInfo , const ICD_ScannerSetPropertyDataPB * pb)

(def-mactype :__ICD_ScannerReadFileData (find-mactype ':pointer)); (const ScannerObjectInfo * objectInfo , UInt32 dataType , Ptr buffer , UInt32 offset , UInt32 * length)

(def-mactype :__ICD_ScannerWriteFileData (find-mactype ':pointer)); (const ScannerObjectInfo * objectInfo , UInt32 dataType , Ptr buffer , UInt32 offset , UInt32 * length)

(def-mactype :__ICD_ScannerSendMessage (find-mactype ':pointer)); (const ScannerObjectInfo * objectInfo , ICD_ScannerObjectSendMessagePB * pb , ICDCompletion completion)

(def-mactype :__ICD_ScannerAddPropertiesToCFDictionary (find-mactype ':pointer)); (ScannerObjectInfo * objectInfo , CFMutableDictionaryRef dict)
;  scanner specific

(def-mactype :__ICD_ScannerOpenSession (find-mactype ':pointer)); (const ScannerObjectInfo * deviceObjectInfo , ICD_ScannerOpenSessionPB * pb)

(def-mactype :__ICD_ScannerCloseSession (find-mactype ':pointer)); (const ScannerObjectInfo * deviceObjectInfo , ICD_ScannerCloseSessionPB * pb)

(def-mactype :__ICD_ScannerInitialize (find-mactype ':pointer)); (const ScannerObjectInfo * deviceObjectInfo , ICD_ScannerInitializePB * pb)

(def-mactype :__ICD_ScannerGetParameters (find-mactype ':pointer)); (const ScannerObjectInfo * deviceObjectInfo , ICD_ScannerGetParametersPB * pb)

(def-mactype :__ICD_ScannerSetParameters (find-mactype ':pointer)); (const ScannerObjectInfo * deviceObjectInfo , ICD_ScannerSetParametersPB * pb)

(def-mactype :__ICD_ScannerStatus (find-mactype ':pointer)); (const ScannerObjectInfo * deviceObjectInfo , ICD_ScannerStatusPB * pb)

(def-mactype :__ICD_ScannerStart (find-mactype ':pointer)); (const ScannerObjectInfo * deviceObjectInfo , ICD_ScannerStartPB * pb)
;  callback functions
(defrecord ICD_Scannerscanner_callback_functions
   (f_ICD_ScannerOpenUSBDevice :pointer)
   (f_ICD_ScannerOpenUSBDeviceWithIORegPath :pointer)
   (f_ICD_ScannerCloseDevice :pointer)
   (f_ICD_ScannerPeriodicTask :pointer)
   (f_ICD_ScannerGetObjectInfo :pointer)
   (f_ICD_ScannerCleanup :pointer)
   (f_ICD_ScannerGetPropertyData :pointer)
   (f_ICD_ScannerSetPropertyData :pointer)
   (f_ICD_ScannerReadFileData :pointer)
   (f_ICD_ScannerWriteFileData :pointer)
   (f_ICD_ScannerSendMessage :pointer)
   (f_ICD_ScannerAddPropertiesToCFDictionary :pointer)
   (f_ICD_ScannerOpenFireWireDevice :pointer)
   (f_ICD_ScannerOpenFireWireDeviceWithIORegPath :pointer)
   (f_ICD_ScannerOpenSession :pointer)
   (f_ICD_ScannerCloseSession :pointer)
   (f_ICD_ScannerInitialize :pointer)
   (f_ICD_ScannerGetParameters :pointer)
   (f_ICD_ScannerSetParameters :pointer)
   (f_ICD_ScannerStatus :pointer)
   (f_ICD_ScannerStart :pointer)
)
(%define-record :ICD_scanner_callback_functions (find-record-descriptor :ICD_SCANNERSCANNER_CALLBACK_FUNCTIONS))
(%define-record :gICDScannerCallbackFunctions (find-record-descriptor ':ICD_scanner_callback_functions))
;  scanner related callBacks into the ICADevices.framework:

(deftrap-inline "_ICD_ScannerMain" 
   ((argc :signed-long)
    (argv (:pointer :char))
   )
   :signed-long
() )

(deftrap-inline "_ICDScannerGetStandardPropertyData" 
   ((objectInfo (:pointer :SCANNEROBJECTINFO))
    (pb (:pointer :ICD_ScannerGetPropertyDataPB))
   )
   :SInt16
() )

(deftrap-inline "_ICDScannerNewObjectInfoCreated" 
   ((parentInfo (:pointer :SCANNEROBJECTINFO))
    (index :UInt32)
    (newICAObject (:pointer :ICAOBJECT))
   )
   :SInt16
() )

(deftrap-inline "_ICDScannerCopyDeviceInfoDictionary" 
   ((deviceName (:pointer :char))
                                                ;  name of the device (from device's objectInfo)
    (theDict (:pointer :CFDictionaryRef))
   )
   :SInt16
() )
;  this CFDictionaryRef contains information about the camera, e.g. the icon file,...

(deftrap-inline "_ICDScannerCreateICAThumbnailFromICNS" 
   ((fileName (:pointer :char))
                                                ;  filename for .icns icon file (this file has to contain the 48*48 icon - 'huge 32 bit data')
    (thumbnail (:pointer :ICAThumbnail))
   )
   :SInt16
() )
;  pointer to ICAThumbnail
;  NOTE: you have to allocate and prefill the ICAThumbnail
;        malloc(sizeof(ICAThumbnail)+9215);
;          width & height -> 48
; 		 dataSize       -> 9216  (= 48*48*4)

(deftrap-inline "_ICDScannerInitiateNotificationCallback" 
   ((pb (:pointer :ICAExtendedRegisterEventNotificationPB))
   )
   :SInt16
() )

(deftrap-inline "_ICDScannerCreateEventDataCookie" 
   ((object (:pointer :OpaqueICAObject))
    (cookie (:pointer :ICAEVENTDATACOOKIE))
   )
   :SInt16
() )
;  ----------------------------------------------------
;  USB

(deftrap-inline "_ICDScannerConnectUSBDevice" 
   ((locationID :UInt32)
   )
   :SInt16
() )

(deftrap-inline "_ICDScannerConnectUSBDeviceWithIORegPath" 
   ((locationID :UInt32)
    (ioregPath (:pointer :IO_STRING_T))
   )
   :SInt16
() )

(deftrap-inline "_ICDScannerDisconnectUSBDevice" 
   ((locationID :UInt32)
   )
   :SInt16
() )

(deftrap-inline "_ICDScannerDisconnectUSBDeviceWithIORegPath" 
   ((locationID :UInt32)
    (ioregPath (:pointer :IO_STRING_T))
   )
   :SInt16
() )
;  ----------------------------------------------------
;  FireWire

(deftrap-inline "_ICDScannerConnectFWDevice" 
   ((guid :uint64)
   )
   :SInt16
() )

(deftrap-inline "_ICDScannerConnectFWDeviceWithIORegPath" 
   ((guid :uint64)
    (ioregPath (:pointer :IO_STRING_T))
   )
   :SInt16
() )

(deftrap-inline "_ICDScannerDisconnectFWDevice" 
   ((guid :uint64)
   )
   :SInt16
() )

(deftrap-inline "_ICDScannerDisconnectFWDeviceWithIORegPath" 
   ((guid :uint64)
    (ioregPath (:pointer :IO_STRING_T))
   )
   :SInt16
() )

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

; #endif


(provide-interface "ICD_ScannerCalls")