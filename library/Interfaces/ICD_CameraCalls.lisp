(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ICD_CameraCalls.h"
; at Sunday July 2,2006 7:27:56 pm.
; 
;  	File:       ICADevices/ICA_CameraCalls.h
; 
;  	Contains:   Camera module related interfaces
; 
;  	Copyright:  © 2000-2002 by Apple Computer, Inc., all rights reserved.
; 
;  
;   	Bugs?:      For bug reports, consult the following page on
;                 the World Wide Web:
; 
;   	http://developer.apple.com/bugreporter/
; 
; 
; #ifndef __ICD_CameraCalls__
; #define __ICD_CameraCalls__

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

(defconstant $kICD_FileData :|file|)
(defconstant $kICD_ThumbnailData :|thum|)
(defconstant $kICD_MetaData :|meta|)
;  flags 

(defconstant $hasChildrenMask 1)
(defconstant $hasThumbnailMask 2)
(defconstant $fileLockedMask 4)
(defconstant $rawImageFormatMask 8)
(defrecord ObjectInfo
   (icaObject (:pointer :OpaqueICAObject))
                                                ;  Apple
   (reserved :UInt32)
                                                ;  Apple	
   (icaObjectInfo :ICAObjectInfo)
                                                ;  vendor
   (uniqueID :UInt32)
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
   (uniqueIDFireWire :uint64)
                                                ;  vendor
)
(defrecord ICD_GetPropertyDataPB
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

;type name? (%define-record :ICD_GetPropertyDataPB (find-record-descriptor ':ICD_GetPropertyDataPB))
(defrecord ICD_SetPropertyDataPB
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

;type name? (%define-record :ICD_SetPropertyDataPB (find-record-descriptor ':ICD_SetPropertyDataPB))
(defrecord ICD_ObjectSendMessagePB
   (header :ICDHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (objectInfo :ICAObjectInfo)
                                                ;  <-- 
   (connectionID (:pointer :OpaqueICAConnectionID));  <-- 
   (message :ICAMessage)                        ;  <-- 
   (totalDataSize :UInt32)                      ;  <-- 
   (result :UInt32)                             ;  --> 
)

;type name? (%define-record :ICD_ObjectSendMessagePB (find-record-descriptor ':ICD_ObjectSendMessagePB))

(def-mactype :__ICD_OpenUSBDevice (find-mactype ':pointer)); (UInt32 locationID , ObjectInfo * objectInfo)

(def-mactype :__ICD_OpenUSBDeviceWithIORegPath (find-mactype ':pointer)); (UInt32 locationID , io_string_t ioregPath , ObjectInfo * objectInfo)

(def-mactype :__ICD_OpenFireWireDevice (find-mactype ':pointer)); (UInt64 guid , ObjectInfo * objectInfo)

(def-mactype :__ICD_OpenFireWireDeviceWithIORegPath (find-mactype ':pointer)); (UInt64 guid , io_string_t ioregPath , ObjectInfo * objectInfo)

(def-mactype :__ICD_CloseDevice (find-mactype ':pointer)); (ObjectInfo * objectInfo)

(def-mactype :__ICD_PeriodicTask (find-mactype ':pointer)); (ObjectInfo * objectInfo)
;  index is zero based 

(def-mactype :__ICD_GetObjectInfo (find-mactype ':pointer)); (const ObjectInfo * parentInfo , UInt32 index , ObjectInfo * newInfo)

(def-mactype :__ICD_Cleanup (find-mactype ':pointer)); (ObjectInfo * objectInfo)

(def-mactype :__ICD_GetPropertyData (find-mactype ':pointer)); (const ObjectInfo * objectInfo , ICD_GetPropertyDataPB * pb)

(def-mactype :__ICD_SetPropertyData (find-mactype ':pointer)); (const ObjectInfo * objectInfo , const ICD_SetPropertyDataPB * pb)

(def-mactype :__ICD_ReadFileData (find-mactype ':pointer)); (const ObjectInfo * objectInfo , UInt32 dataType , Ptr buffer , UInt32 offset , UInt32 * length)

(def-mactype :__ICD_WriteFileData (find-mactype ':pointer)); (const ObjectInfo * objectInfo , UInt32 dataType , Ptr buffer , UInt32 offset , UInt32 * length)

(def-mactype :__ICD_SendMessage (find-mactype ':pointer)); (const ObjectInfo * objectInfo , ICD_ObjectSendMessagePB * pb , ICDCompletion completion)

(def-mactype :__ICD_AddPropertiesToCFDictionary (find-mactype ':pointer)); (ObjectInfo * objectInfo , CFMutableDictionaryRef dict)
;  camera related callBacks into the ICADevices.framework:

(deftrap-inline "_ICD_main" 
   ((argc :signed-long)
    (argv (:pointer :char))
   )
   :signed-long
() )

(deftrap-inline "_ICDGetStandardPropertyData" 
   ((objectInfo (:pointer :OBJECTINFO))
    (pb (:pointer :ICD_GetPropertyDataPB))
   )
   :SInt16
() )

(deftrap-inline "_ICDNewObjectInfoCreated" 
   ((parentInfo (:pointer :OBJECTINFO))
    (index :UInt32)
    (newICAObject (:pointer :ICAOBJECT))
   )
   :SInt16
() )

(def-mactype :ICDNewObjectCreatedCompletion (find-mactype ':pointer)); (const ObjectInfo * info)

(deftrap-inline "_ICDNewObjectCreated" 
   ((parentInfo (:pointer :OBJECTINFO))
    (objectInfo (:pointer :OBJECTINFO))
    (completion :pointer)
   )
   :SInt16
() )

(deftrap-inline "_ICDCopyDeviceInfoDictionary" 
   ((deviceName (:pointer :char))
                                                ;  name of the device (from device's objectInfo)
    (theDict (:pointer :CFDictionaryRef))
   )
   :SInt16
() )
;  this CFDictionaryRef contains information about the camera, e.g. the icon file,...

(deftrap-inline "_ICDCreateICAThumbnailFromICNS" 
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
; 		   dataSize       -> 9216  (= 48*48*4)

(deftrap-inline "_ICDInitiateNotificationCallback" 
   ((pb (:pointer :ICAExtendedRegisterEventNotificationPB))
   )
   :SInt16
() )

(deftrap-inline "_ICDCreateEventDataCookie" 
   ((object (:pointer :OpaqueICAObject))
    (cookie (:pointer :ICAEVENTDATACOOKIE))
   )
   :SInt16
() )
;  ----------------------------------------------------
;  USB

(deftrap-inline "_ICDConnectUSBDevice" 
   ((locationID :UInt32)
   )
   :SInt16
() )

(deftrap-inline "_ICDConnectUSBDeviceWithIORegPath" 
   ((locationID :UInt32)
    (ioregPath (:pointer :IO_STRING_T))
   )
   :SInt16
() )

(deftrap-inline "_ICDDisconnectUSBDevice" 
   ((locationID :UInt32)
   )
   :SInt16
() )

(deftrap-inline "_ICDDisconnectUSBDeviceWithIORegPath" 
   ((locationID :UInt32)
    (ioregPath (:pointer :IO_STRING_T))
   )
   :SInt16
() )
;  ----------------------------------------------------
;  FireWire

(deftrap-inline "_ICDConnectFWDevice" 
   ((guid :uint64)
   )
   :SInt16
() )

(deftrap-inline "_ICDConnectFWDeviceWithIORegPath" 
   ((guid :uint64)
    (ioregPath (:pointer :IO_STRING_T))
   )
   :SInt16
() )

(deftrap-inline "_ICDDisconnectFWDevice" 
   ((guid :uint64)
   )
   :SInt16
() )

(deftrap-inline "_ICDDisconnectFWDeviceWithIORegPath" 
   ((guid :uint64)
    (ioregPath (:pointer :IO_STRING_T))
   )
   :SInt16
() )
;  ----------------------------------------------------

(deftrap-inline "_ICDStatusChanged" 
   ((object (:pointer :OpaqueICAObject))
                                                ;  deprecated - use ICDInitiateNotificationCallback instead
    (message :OSType)
   )
   :SInt16
() )
;  callback functions
(defrecord ICD_callback_functions
   (f_ICD_OpenUSBDevice :pointer)
   (f_ICD_CloseDevice :pointer)
   (f_ICD_PeriodicTask :pointer)
   (f_ICD_GetObjectInfo :pointer)
   (f_ICD_Cleanup :pointer)
   (f_ICD_GetPropertyData :pointer)
   (f_ICD_SetPropertyData :pointer)
   (f_ICD_ReadFileData :pointer)
   (f_ICD_WriteFileData :pointer)
   (f_ICD_SendMessage :pointer)
   (f_ICD_AddPropertiesToCFDictionary :pointer)
   (f_ICD_OpenFireWireDevice :pointer)
   (f_ICD_OpenUSBDeviceWithIORegPath :pointer)
   (f_ICD_OpenFireWireDeviceWithIORegPath :pointer)
)
(%define-record :gICDCallbackFunctions (find-record-descriptor ':ICD_callback_functions))

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


(provide-interface "ICD_CameraCalls")