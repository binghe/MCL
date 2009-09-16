(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ICACamera.h"
; at Sunday July 2,2006 7:25:18 pm.
; 
;      File:       ImageCapture/ICACamera.h
;  
;      Contains:   Digital still camera-specific selectors and structures
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
; #ifndef __ICACAMERA__
; #define __ICACAMERA__

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; 
;    -------------------------------------------------------------------------
;                                 Selectors           
;    -------------------------------------------------------------------------
; 
;  Camera properties
;  Refer to section 13 of the PIMA 15740 (PTP) specification for
;  descriptions and usage notes for these standard properties

(defconstant $kICAPropertyCameraBatteryLevel :|5001|);  UInt8   enum/range

(defconstant $kICAPropertyCameraFunctionalMode :|5002|);  UInt16     enum

(defconstant $kICAPropertyCameraImageSize :|5003|);  CFString     enum/range

(defconstant $kICAPropertyCameraCompressionSetting :|5004|);  UInt8   enum/range

(defconstant $kICAPropertyCameraWhiteBalance :|5005|);  UInt16     enum

(defconstant $kICAPropertyCameraRGBGain :|5006|);  null terminated string enum/range

(defconstant $kICAPropertyCameraFNumber :|5007|);  UInt16     enum

(defconstant $kICAPropertyCameraFocalLength :|5008|);  UInt32     enum/range

(defconstant $kICAPropertyCameraFocusDistance :|5009|);  UInt16     enum/range

(defconstant $kICAPropertyCameraFocusMode :|500A|);  UInt16     enum

(defconstant $kICAPropertyCameraExposureMeteringMode :|500B|);  UInt16     enum

(defconstant $kICAPropertyCameraFlashMode :|500C|);  UInt16     enum

(defconstant $kICAPropertyCameraExposureTime :|500D|);  UInt32     enum/range

(defconstant $kICAPropertyCameraExposureProgramMode :|500E|);  UInt16     enum

(defconstant $kICAPropertyCameraExposureIndex :|500F|);  UInt16     enum/range

(defconstant $kICAPropertyCameraExposureBiasCompensation :|5010|);  UInt16     enum/range

(defconstant $kICAPropertyCameraDateTime :|5011|);  null terminated string     none

(defconstant $kICAPropertyCameraCaptureDelay :|5012|);  UInt32     enum/range

(defconstant $kICAPropertyCameraStillCaptureMode :|5013|);  UInt16     enum

(defconstant $kICAPropertyCameraContrast :|5014|);  UInt8   enum/range

(defconstant $kICAPropertyCameraSharpness :|5015|);  UInt8   enum/range

(defconstant $kICAPropertyCameraDigitalZoom :|5016|);  UInt8   enum/range

(defconstant $kICAPropertyCameraEffectMode :|5017|);  UInt16     enum

(defconstant $kICAPropertyCameraBurstNumber :|5018|);  UInt16     enum/range

(defconstant $kICAPropertyCameraBurstInterval :|5019|);  UInt16     enum/range

(defconstant $kICAPropertyCameraTimelapseNumber :|501A|);  UInt16     enum/range

(defconstant $kICAPropertyCameraTimelapseInterval :|501B|);  UInt32     enum/range

(defconstant $kICAPropertyCameraFocusMeteringMode :|501C|);  UInt16     enum

;  Refer to section 5.5.3 of the PTP spec

(defconstant $kICAPropertyCameraStorageType :|stor|);  UInt16

(defconstant $kICAPropertyCameraFilesystemType :|fsys|);  UInt16

(defconstant $kICAPropertyCameraAccessCapability :|acap|);  UInt16

(defconstant $kICAPropertyCameraMaxCapacity :|maxc|);  UInt64

(defconstant $kICAPropertyCameraFreeSpaceInBytes :|fres|);  UInt64

(defconstant $kICAPropertyCameraFreeSpaceInImages :|frei|);  UInt32

(defconstant $kICAPropertyCameraStorageDescription :|stod|);  null terminated string

(defconstant $kICAPropertyCameraVolumeLabel :|voll|);  null terminated string

;  ICA specific

(defconstant $kICAPropertyCameraIcon :|icon|)   ;  ICAThumbnail

(defconstant $kICAPropertyCameraSupportedMessages :|msgs|);  array of OSTypes

;  Values for kICAPropertyCameraStorageType

(defconstant $kICAStorageFixedROM 1)
(defconstant $kICAStorageRemovableROM 2)
(defconstant $kICAStorageFixedRAM 3)
(defconstant $kICAStorageRemovableRAM 4)
;  Values for kICAPropertyCameraFilesystemType

(defconstant $kICAFileystemGenericFlat 1)
(defconstant $kICAFileystemGenericHierarchical 2)
(defconstant $kICAFileystemDCF 3)
;  Values for kICAPropertyCameraAccessCapability

(defconstant $kICAAccessReadWrite 0)
(defconstant $kICAAccessReadOnly 1)
(defconstant $kICAAccessReadOnlyWithObjectDeletion 2)
;  Camera messages

(defconstant $kICAMessageCameraCaptureNewImage :|ccni|)
(defconstant $kICAMessageCameraDeleteOne :|del1|)
(defconstant $kICAMessageCameraDeleteAll :|dela|)
(defconstant $kICAMessageCameraSyncClock :|sclk|)
(defconstant $kICAMessageCameraUploadData :|load|)

; #endif /* __ICACAMERA__ */


(provide-interface "ICACamera")