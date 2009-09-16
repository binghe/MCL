(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ICAApplication.h"
; at Sunday July 2,2006 7:25:17 pm.
; 
;      File:       ImageCapture/ICAApplication.h
;  
;      Contains:   General purpose Image Capture definitions
;  
;      Version:    ImageCapture-181~1
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __ICAAPPLICATION__
; #define __ICAAPPLICATION__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
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

(def-mactype :ICAObject (find-mactype '(:pointer :OpaqueICAObject)))

(def-mactype :ICAProperty (find-mactype '(:pointer :OpaqueICAProperty)))

(def-mactype :ICAConnectionID (find-mactype '(:pointer :OpaqueICAConnectionID)))

(def-mactype :ICAEventDataCookie (find-mactype '(:pointer :OpaqueICAEventDataCookie)))

(def-mactype :ICAScannerSessionID (find-mactype '(:pointer :OpaqueICAScannerSessionID)))
; 
; --------------- Defines --------------- 
; 
;  Error codes (Image Capture range = -9900...-9949)

(defconstant $kICACommunicationErr -9900)
(defconstant $kICADeviceNotFoundErr -9901)
(defconstant $kICADeviceNotOpenErr -9902)
(defconstant $kICAFileCorruptedErr -9903)
(defconstant $kICAIOPendingErr -9904)
(defconstant $kICAInvalidObjectErr -9905)
(defconstant $kICAInvalidPropertyErr -9906)
(defconstant $kICAIndexOutOfRangeErr -9907)
(defconstant $kICAPropertyTypeNotFoundErr -9908)
(defconstant $kICACannotYieldDevice -9909)
(defconstant $kICADataTypeNotFoundErr -9910)
(defconstant $kICADeviceMemoryAllocationErr -9911)
(defconstant $kICADeviceInternalErr -9912)
(defconstant $kICADeviceInvalidParamErr -9913)
(defconstant $kICADeviceAlreadyOpenErr -9914)
(defconstant $kICADeviceLocationIDNotFoundErr -9915)
(defconstant $kICADeviceGUIDNotFoundErr -9916)
(defconstant $kICADeviceIOServicePathNotFoundErr -9917)
;  ICAObject types and subtypes 

(defconstant $kICADevice :|icdv|)               ;  Also creator of device library files 

(defconstant $kICADeviceCamera :|cmra|)         ;  Also file type of device library files 

(defconstant $kICADeviceScanner :|scan|)        ;  Also file type of device library files 

(defconstant $kICADeviceMFP :|mfp |)            ;  Also file type of device library files 

(defconstant $kICAList :|objl|)
(defconstant $kICADirectory :|dire|)
(defconstant $kICAFile :|file|)
(defconstant $kICAFileImage :|imag|)
(defconstant $kICAFileMovie :|moov|)
(defconstant $kICAFileAudio :|audo|)
(defconstant $kICAFileFirmware :|firm|)
(defconstant $kICAFileOther :|othe|)
;  ICAProperties 

(defconstant $kICAProperty :|prop|)             ;  
;     file properties 
;  
;  for images, refer to 'Digital Still Camera Image File Format Standard' Exif Version 2.1 section 2.6.4. and 2.6.5.

(defconstant $kICAPropertyImageWidth :|0100|)   ;  UInt32 

(defconstant $kICAPropertyImageHeight :|0101|)  ;  UInt32 

(defconstant $kICAPropertyImageBitDepth :|0102|);  UInt32 

(defconstant $kICAPropertyImageDPI :|011A|)     ;  UInt32 

(defconstant $kICAPropertyImageExposureTime :|829A|)
(defconstant $kICAPropertyImageFNumber :|829D|)
(defconstant $kICAPropertyImageDateOriginal :|9003|);  null terminated string (YYYYMMDDThhmmss.s) 

(defconstant $kICAPropertyImageDateDigitized :|9004|);  null terminated string (YYYYMMDDThhmmss.s) 

(defconstant $kICAPropertyImageShutterSpeed :|9201|);  

(defconstant $kICAPropertyImageAperture :|9202|);  

(defconstant $kICAPropertyImageFlash :|9209|)   ;  UInt16

(defconstant $kICAPropertyColorSpace :|A001|)   ;  UInt16

(defconstant $kICAPropertyImageFilename :|ifil|);  null terminated string 

(defconstant $kICAPropertyImageSize :|isiz|)    ;  UInt32 

(defconstant $kICAPropertyImageData :|idat|)    ;  void * 

(defconstant $kICAPropertyImageThumbnail :|thum|);  void * 

(defconstant $kICAPropertyColorSyncProfile :|prof|)
;  Messages 

(defconstant $kICAMessageConnect :|open|)
(defconstant $kICAMessageDisconnect :|clos|)
(defconstant $kICAMessageReset :|rese|)
(defconstant $kICAMessageCheckDevice :|chkd|)
(defconstant $kICAMessageCameraReadClock :|rclk|)
(defconstant $kICAMessageGetLastButtonPressed :|btn?|)
;  Data type definitions, mapped to AppleEvent types 

(defconstant $kICATypeUInt16 :|ui16|)           ;  UInt16 

(defconstant $kICATypeUInt32 :|ui32|)           ;  UInt32 

(defconstant $kICATypeUInt64 :|ui64|)           ;  UInt64 

(defconstant $kICATypeSInt16 :|si16|)           ;  SInt16 

(defconstant $kICATypeSInt32 :|si32|)           ;  SInt32 

(defconstant $kICATypeSInt64 :|si64|)           ;  SInt64 

(defconstant $kICATypeFixed :|sing|)            ;  typeIEEE32BitFloatingPoint 

(defconstant $kICATypeBoolean :|bool|)          ;  typeBoolean 

(defconstant $kICATypeString :|TEXT|)           ;  typeChar 

(defconstant $kICATypeData :|data|)             ;  void * 

(defconstant $kICATypeThumbnail :|thum|)        ;  ICAThumbnail

;  Flags for PropertyInfo flag element 

(defconstant $kICAFlagReadWriteAccess 1)
(defconstant $kICAFlagReadAccess 2)
;  Notification types (Refer to section 12.4 of PTP spec) 

(defconstant $kICAEventCancelTransaction :|ecnt|)
(defconstant $kICAEventObjectAdded :|eoba|)
(defconstant $kICAEventObjectRemoved :|eobr|)
(defconstant $kICAEventStoreAdded :|esta|)
(defconstant $kICAEventStoreRemoved :|estr|)
(defconstant $kICAEventDeviceAdded :|edea|)
(defconstant $kICAEventDeviceRemoved :|eder|)
(defconstant $kICAEventDevicePropChanged :|edpc|)
(defconstant $kICAEventObjectInfoChanged :|eoic|)
(defconstant $kICAEventDeviceInfoChanged :|edic|)
(defconstant $kICAEventRequestObjectTransfer :|erot|)
(defconstant $kICAEventStoreFull :|estf|)
(defconstant $kICAEventDeviceReset :|edvr|)
(defconstant $kICAEventStorageInfoChanged :|esic|)
(defconstant $kICAEventCaptureComplete :|ecpc|)
(defconstant $kICAEventUnreportedStatus :|eurs|)
;  Used for partial reads via ICAGetPropertyData 

(defconstant $kICAStartAtBeginning 0)
(defconstant $kICAEntireLength -1)
;  ICADownloadFile flags 

(defconstant $kDeleteAfterDownload 1)
(defconstant $kCreateCustomIcon 2)
(defconstant $kAddMetaDataToFinderComment 4)
(defconstant $kAdjustCreationDate 8)
(defconstant $kSetFileTypeAndCreator 16)        ; kEmbedColorSyncProfile   = 0x00000020,

(defconstant $kRotateImage 64)
(defconstant $kDontEmbedColorSyncProfile #x80)
;  extended notification 

(defconstant $kExtendedNotificationPB :|extd|)
(defconstant $kMessageGetEventData :|mged|)
(defconstant $kEventClassPTPStandard :|PTPs|)
(defconstant $kEventClassPTPVendor :|PTPv|)
;  button types

(defconstant $kICAButtonScan :|scan|)
(defconstant $kICAButtonCopy :|copy|)
(defconstant $kICAButtonEMail :|mail|)
(defconstant $kICAButtonWeb :|web |)
; 
; --------------- Structures --------------- 
; 
(defrecord ICAObjectInfo
   (objectType :OSType)                         ;  i.e. kICAFile
   (objectSubtype :OSType)                      ;  i.e. kICAFileImage  
)

;type name? (%define-record :ICAObjectInfo (find-record-descriptor ':ICAObjectInfo))
(defrecord ICAPropertyInfo
   (propertyType :OSType)
   (dataType :OSType)
   (dataSize :UInt32)
   (dataFlags :UInt32)
)

;type name? (%define-record :ICAPropertyInfo (find-record-descriptor ':ICAPropertyInfo))
(defrecord ICAMessage
   (messageType :OSType)                        ;  <--  i.e. kICAMessageCameraCaptureNewImage 
   (startByte :UInt32)                          ;  <-- 
   (dataPtr :pointer)                           ;  <-- 
   (dataSize :UInt32)                           ;  <-- 
   (dataType :OSType)                           ;  <-- 
)

;type name? (%define-record :ICAMessage (find-record-descriptor ':ICAMessage))
(defrecord ICAThumbnail
   (width :UInt32)
   (height :UInt32)
   (dataSize :UInt32)
   (data (:array :UInt8 1))                     ;  8-bit RGB data (RGBRGBRGB...)
)

;type name? (%define-record :ICAThumbnail (find-record-descriptor ':ICAThumbnail))

(defconstant $kICAPBVersion #x10000)
;  
; --------------- Completion Procs --------------- 
; 
; 
;    
;    NOTE: the parameter for the completion proc (ICAHeader*) has to be casted to the appropriate type
;    e.g. (ICAGetChildCountPB*), ...
;    
; 

;type name? (def-mactype :ICAHeader (find-mactype ':ICAHeader))

(def-mactype :ICACompletion (find-mactype ':pointer)); (ICAHeader * pb)
;  
; --------------- ICAHeader --------------- 
; 
(defrecord ICAHeader
   (err :SInt16)                                ;  --> 
   (refcon :UInt32)                             ;  <-- 
)
; 
; --------------- Object parameter blocks --------------- 
; 
(defrecord ICAGetChildCountPB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (count :UInt32)                              ;  --> 
)

;type name? (%define-record :ICAGetChildCountPB (find-record-descriptor ':ICAGetChildCountPB))
(defrecord ICAGetNthChildPB
   (header :ICAHEADER)
   (parentObject (:pointer :OpaqueICAObject))   ;  <-- 
   (index :UInt32)                              ;  <-- zero based 
   (childObject (:pointer :OpaqueICAObject))    ;  --> 
   (childInfo :ICAObjectInfo)                   ;  --> 
)

;type name? (%define-record :ICAGetNthChildPB (find-record-descriptor ':ICAGetNthChildPB))
(defrecord ICAGetObjectInfoPB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (objectInfo :ICAObjectInfo)                  ;  --> 
)

;type name? (%define-record :ICAGetObjectInfoPB (find-record-descriptor ':ICAGetObjectInfoPB))
(defrecord ICAGetParentOfObjectPB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (parentObject (:pointer :OpaqueICAObject))   ;  --> 
   (parentInfo :ICAObjectInfo)                  ;  --> 
)

;type name? (%define-record :ICAGetParentOfObjectPB (find-record-descriptor ':ICAGetParentOfObjectPB))
(defrecord ICAGetRootOfObjectPB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (rootObject (:pointer :OpaqueICAObject))     ;  --> 
   (rootInfo :ICAObjectInfo)                    ;  --> 
)

;type name? (%define-record :ICAGetRootOfObjectPB (find-record-descriptor ':ICAGetRootOfObjectPB))
(defrecord ICAGetObjectRefConPB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (objectRefCon :UInt32)                       ;  --> 
)

;type name? (%define-record :ICAGetObjectRefConPB (find-record-descriptor ':ICAGetObjectRefConPB))
(defrecord ICASetObjectRefConPB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (objectRefCon :UInt32)                       ;  <-- 
)

;type name? (%define-record :ICASetObjectRefConPB (find-record-descriptor ':ICASetObjectRefConPB))
; 
; --------------- Property parameter blocks --------------- 
; 
(defrecord ICAGetPropertyCountPB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (count :UInt32)                              ;  --> 
)

;type name? (%define-record :ICAGetPropertyCountPB (find-record-descriptor ':ICAGetPropertyCountPB))
(defrecord ICAGetNthPropertyPB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (index :UInt32)                              ;  <-- zero based 
   (property (:pointer :OpaqueICAProperty))     ;  --> 
   (propertyInfo :ICAPropertyInfo)              ;  --> 
)

;type name? (%define-record :ICAGetNthPropertyPB (find-record-descriptor ':ICAGetNthPropertyPB))
(defrecord ICAGetPropertyByTypePB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (propertyType :OSType)                       ;  <-- 
   (property (:pointer :OpaqueICAProperty))     ;  --> 
   (propertyInfo :ICAPropertyInfo)              ;  --> 
)

;type name? (%define-record :ICAGetPropertyByTypePB (find-record-descriptor ':ICAGetPropertyByTypePB))
(defrecord ICAGetPropertyInfoPB
   (header :ICAHEADER)
   (property (:pointer :OpaqueICAProperty))     ;  <-- 
   (propertyInfo :ICAPropertyInfo)              ;  --> 
)

;type name? (%define-record :ICAGetPropertyInfoPB (find-record-descriptor ':ICAGetPropertyInfoPB))
(defrecord ICAGetPropertyDataPB
   (header :ICAHEADER)
   (property (:pointer :OpaqueICAProperty))     ;  <-- 
   (startByte :UInt32)                          ;  <-- 
   (requestedSize :UInt32)                      ;  <-- 
   (dataPtr :pointer)                           ;  <-> 
   (actualSize :UInt32)                         ;  --> 
   (dataType :OSType)                           ;  --> 
)

;type name? (%define-record :ICAGetPropertyDataPB (find-record-descriptor ':ICAGetPropertyDataPB))
(defrecord ICASetPropertyDataPB
   (header :ICAHEADER)
   (property (:pointer :OpaqueICAProperty))     ;  <-- 
   (startByte :UInt32)                          ;  <-- 
   (dataPtr :pointer)                           ;  <-- 
   (dataSize :UInt32)                           ;  <-- 
   (dataType :OSType)                           ;  <-- 
)

;type name? (%define-record :ICASetPropertyDataPB (find-record-descriptor ':ICASetPropertyDataPB))
(defrecord ICAGetParentOfPropertyPB
   (header :ICAHEADER)
   (property (:pointer :OpaqueICAProperty))     ;  <-- 
   (parentObject (:pointer :OpaqueICAObject))   ;  --> 
   (parentInfo :ICAObjectInfo)                  ;  --> 
)

;type name? (%define-record :ICAGetParentOfPropertyPB (find-record-descriptor ':ICAGetParentOfPropertyPB))
(defrecord ICAGetRootOfPropertyPB
   (header :ICAHEADER)
   (property (:pointer :OpaqueICAProperty))     ;  <-- 
   (rootObject (:pointer :OpaqueICAObject))     ;  --> 
   (rootInfo :ICAObjectInfo)                    ;  --> 
)

;type name? (%define-record :ICAGetRootOfPropertyPB (find-record-descriptor ':ICAGetRootOfPropertyPB))
(defrecord ICAGetPropertyRefConPB
   (header :ICAHEADER)
   (property (:pointer :OpaqueICAProperty))     ;  <-- 
   (propertyRefCon :UInt32)                     ;  --> 
)

;type name? (%define-record :ICAGetPropertyRefConPB (find-record-descriptor ':ICAGetPropertyRefConPB))
(defrecord ICASetPropertyRefConPB
   (header :ICAHEADER)
   (property (:pointer :OpaqueICAProperty))     ;  <-- 
   (propertyRefCon :UInt32)                     ;  <-- 
)

;type name? (%define-record :ICASetPropertyRefConPB (find-record-descriptor ':ICASetPropertyRefConPB))
; 
; --------------- Device parameter blocks --------------- 
; 
(defrecord ICAGetDeviceListPB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  --> 
)

;type name? (%define-record :ICAGetDeviceListPB (find-record-descriptor ':ICAGetDeviceListPB))
(defrecord ICAObjectSendMessagePB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (message :ICAMessage)                        ;  <-- 
   (result :UInt32)                             ;  --> message specific result
)

;type name? (%define-record :ICAObjectSendMessagePB (find-record-descriptor ':ICAObjectSendMessagePB))
(defrecord ICARegisterEventNotificationPB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-> 
   (notifyType :OSType)                         ;  <-> 
   (notifyProc :pointer)                        ;  <-- 
)

;type name? (%define-record :ICARegisterEventNotificationPB (find-record-descriptor ':ICARegisterEventNotificationPB))
(defrecord ICAExtendedRegisterEventNotificationPB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-> 
   (extd :OSType)                               ;  <-- 
   (notifyProc :pointer)                        ;  <-- 
   (rawEventType :UInt32)                       ;  -->
   (eventType :OSType)                          ;  <->
   (eventClass :OSType)                         ;  -->
   (eventDataSize :UInt32)                      ;  -->
   (eventDataCookie (:pointer :OpaqueICAEventDataCookie));  -->
   (deviceObject (:pointer :OpaqueICAObject))   ;  -->
)

;type name? (%define-record :ICAExtendedRegisterEventNotificationPB (find-record-descriptor ':ICAExtendedRegisterEventNotificationPB))
(defrecord ICADownloadFilePB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (dirFSRef (:pointer :FSRef))                 ;  <-- 
   (flags :UInt32)                              ;  <-- 
   (fileType :OSType)                           ;  <-- 
   (fileCreator :OSType)                        ;  <-- 
   (rotationAngle :signed-long)                 ;  <-- 
   (fileFSRef (:pointer :FSRef))                ;  --> can be NULL
)

;type name? (%define-record :ICADownloadFilePB (find-record-descriptor ':ICADownloadFilePB))
(defrecord ICACopyObjectPropertyDictionaryPB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (theDict (:pointer :CFDictionaryRef))        ;  --> 
)

;type name? (%define-record :ICACopyObjectPropertyDictionaryPB (find-record-descriptor ':ICACopyObjectPropertyDictionaryPB))
; 
;    
;    NOTE: for all APIs - pass NULL as completion parameter to make a synchronous call 
;    
; 
; 
; --------------- Object functions --------------- 
; 
; 
;  *  ICAGetChildCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetChildCount" 
   ((pb (:pointer :ICAGetChildCountPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICAGetNthChild()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetNthChild" 
   ((pb (:pointer :ICAGetNthChildPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICAGetObjectInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetObjectInfo" 
   ((pb (:pointer :ICAGetObjectInfoPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICAGetParentOfObject()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetParentOfObject" 
   ((pb (:pointer :ICAGetParentOfObjectPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICAGetRootOfObject()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetRootOfObject" 
   ((pb (:pointer :ICAGetRootOfObjectPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICAGetObjectRefCon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetObjectRefCon" 
   ((pb (:pointer :ICAGetObjectRefConPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICASetObjectRefCon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICASetObjectRefCon" 
   ((pb (:pointer :ICASetObjectRefConPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
; --------------- Property functions --------------- 
; 
; 
;  *  ICAGetPropertyCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetPropertyCount" 
   ((pb (:pointer :ICAGetPropertyCountPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICAGetNthProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetNthProperty" 
   ((pb (:pointer :ICAGetNthPropertyPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICAGetPropertyByType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetPropertyByType" 
   ((pb (:pointer :ICAGetPropertyByTypePB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICAGetPropertyInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetPropertyInfo" 
   ((pb (:pointer :ICAGetPropertyInfoPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICAGetPropertyData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetPropertyData" 
   ((pb (:pointer :ICAGetPropertyDataPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICASetPropertyData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICASetPropertyData" 
   ((pb (:pointer :ICASetPropertyDataPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICAGetParentOfProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetParentOfProperty" 
   ((pb (:pointer :ICAGetParentOfPropertyPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICAGetRootOfProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetRootOfProperty" 
   ((pb (:pointer :ICAGetRootOfPropertyPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICAGetPropertyRefCon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetPropertyRefCon" 
   ((pb (:pointer :ICAGetPropertyRefConPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICASetPropertyRefCon()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICASetPropertyRefCon" 
   ((pb (:pointer :ICASetPropertyRefConPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  
; --------------- Device functions --------------- 
; 
; 
;  *  ICAGetDeviceList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAGetDeviceList" 
   ((pb (:pointer :ICAGetDeviceListPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICAObjectSendMessage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAObjectSendMessage" 
   ((pb (:pointer :ICAObjectSendMessagePB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICARegisterEventNotification()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICARegisterEventNotification" 
   ((pb (:pointer :ICARegisterEventNotificationPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  
; ------------------------------------------------ 
; 
; 
;  *  ICADownloadFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICADownloadFile" 
   ((pb (:pointer :ICADownloadFilePB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
; 
;  *  ICACopyObjectPropertyDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICACopyObjectPropertyDictionary" 
   ((pb (:pointer :ICACopyObjectPropertyDictionaryPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
;  
; --- scanner support --------------------------------------------- 
; 
(defrecord ICAScannerOpenSessionPB
   (header :ICAHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (sessionID (:pointer :OpaqueICAScannerSessionID));  --> 
)

;type name? (%define-record :ICAScannerOpenSessionPB (find-record-descriptor ':ICAScannerOpenSessionPB))
(defrecord ICAScannerCloseSessionPB
   (header :ICAHEADER)
   (sessionID (:pointer :OpaqueICAScannerSessionID));  <-- 
)

;type name? (%define-record :ICAScannerCloseSessionPB (find-record-descriptor ':ICAScannerCloseSessionPB))
(defrecord ICAScannerInitializePB
   (header :ICAHEADER)
   (sessionID (:pointer :OpaqueICAScannerSessionID));  <-- 
)

;type name? (%define-record :ICAScannerInitializePB (find-record-descriptor ':ICAScannerInitializePB))
(defrecord ICAScannerGetParametersPB
   (header :ICAHEADER)
   (sessionID (:pointer :OpaqueICAScannerSessionID));  <-- 
   (theDict (:pointer :__CFDictionary))         ;  --> 
)

;type name? (%define-record :ICAScannerGetParametersPB (find-record-descriptor ':ICAScannerGetParametersPB))
(defrecord ICAScannerSetParametersPB
   (header :ICAHEADER)
   (sessionID (:pointer :OpaqueICAScannerSessionID));  <-- 
   (theDict (:pointer :__CFDictionary))         ;  <-> 
)

;type name? (%define-record :ICAScannerSetParametersPB (find-record-descriptor ':ICAScannerSetParametersPB))
(defrecord ICAScannerStatusPB
   (header :ICAHEADER)
   (sessionID (:pointer :OpaqueICAScannerSessionID));  <-- 
   (status :UInt32)                             ;  --> 
)

;type name? (%define-record :ICAScannerStatusPB (find-record-descriptor ':ICAScannerStatusPB))
(defrecord ICAScannerStartPB
   (header :ICAHEADER)
   (sessionID (:pointer :OpaqueICAScannerSessionID));  <-- 
)

;type name? (%define-record :ICAScannerStartPB (find-record-descriptor ':ICAScannerStartPB))
; 
;  *  ICAScannerOpenSession()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAScannerOpenSession" 
   ((pb (:pointer :ICAScannerOpenSessionPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
; 
;  *  ICAScannerCloseSession()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAScannerCloseSession" 
   ((pb (:pointer :ICAScannerCloseSessionPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
; 
;  *  ICAScannerInitialize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAScannerInitialize" 
   ((pb (:pointer :ICAScannerInitializePB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
; 
;  *  ICAScannerGetParameters()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAScannerGetParameters" 
   ((pb (:pointer :ICAScannerGetParametersPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
; 
;  *  ICAScannerSetParameters()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAScannerSetParameters" 
   ((pb (:pointer :ICAScannerSetParametersPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
; 
;  *  ICAScannerStatus()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAScannerStatus" 
   ((pb (:pointer :ICAScannerStatusPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
; 
;  *  ICAScannerStart()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAScannerStart" 
   ((pb (:pointer :ICAScannerStartPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
;  
; --- new APIs for Panther --------------------------------------------- 
; 
;  ICADeviceYield

(defconstant $kICAMessageDeviceYield :|yiel|)
;  ICAImportImage

(defconstant $kICAAllowMultipleImages 1)

(def-mactype :ICAImportFilterProc (find-mactype ':pointer)); (CFDictionaryRef imageInfo , UInt32 refcon)
(defrecord ICAImportImagePB
   (header :ICAHEADER)                          ;  <-- 
   (deviceObject (:pointer :OpaqueICAObject))   ;  <-- 
   (flags :UInt32)                              ;  <-- 
   (supportedFileTypes (:pointer :__CFArray))   ;  <-- 
   (filterProc :pointer)                        ;  <-- 
   (importedImages (:pointer :CFArrayRef))      ;  --> 
)

;type name? (%define-record :ICAImportImagePB (find-record-descriptor ':ICAImportImagePB))
; 
;  *  ICAImportImage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICAImportImage" 
   ((pb (:pointer :ICAImportImagePB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
;  ICACopyObjectThumbnail

(defconstant $kICAThumbnailFormatICA :|ica |)
(defconstant $kICAThumbnailFormatJPEG :|jpeg|)
(defconstant $kICAThumbnailFormatTIFF :|tiff|)
(defrecord ICACopyObjectThumbnailPB
   (header :ICAHEADER)                          ;  <-- 
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (thumbnailFormat :OSType)                    ;  <-- 
   (thumbnailData (:pointer :CFDataRef))        ;  --> 
)

;type name? (%define-record :ICACopyObjectThumbnailPB (find-record-descriptor ':ICACopyObjectThumbnailPB))
; 
;  *  ICACopyObjectThumbnail()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ICACopyObjectThumbnail" 
   ((pb (:pointer :ICACopyObjectThumbnailPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSErr
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __ICAAPPLICATION__ */


(provide-interface "ICAApplication")