(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ICADevice.h"
; at Sunday July 2,2006 7:25:18 pm.
; 
;      File:       ImageCapture/ICADevice.h
;  
;      Contains:   Low level Image Capture device definitions.
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
; #ifndef __ICADEVICE__
; #define __ICADEVICE__
; #ifndef __ICAAPPLICATION__
#| #|
#include <ImageCaptureICAApplication.h>
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
;  
; --------------- Completion Procs --------------- 
; 
; 
;    
;    NOTE: the parameter for the completion proc (ICDHeader*) has to be casted to the appropriate type
;    e.g. (ICD_BuildObjectChildrenPB*), ...
;    
; 

;type name? (def-mactype :ICDHeader (find-mactype ':ICDHeader))

(def-mactype :ICDCompletion (find-mactype ':pointer)); (ICDHeader * pb)
;  
; --------------- ICDHeader --------------- 
; 
(defrecord ICDHeader
   (err :SInt16)                                ;  --> 
   (refcon :UInt32)                             ;  <-- 
)
; 
; --------------- Object parameter blocks ---------------
; 
(defrecord ICD_NewObjectPB
   (header :ICDHEADER)
   (parentObject (:pointer :OpaqueICAObject))   ;  <-- 
   (objectInfo :ICAObjectInfo)                  ;  <-- 
   (object (:pointer :OpaqueICAObject))         ;  --> 
)

;type name? (%define-record :ICD_NewObjectPB (find-record-descriptor ':ICD_NewObjectPB))
(defrecord ICD_DisposeObjectPB
   (header :ICDHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
)

;type name? (%define-record :ICD_DisposeObjectPB (find-record-descriptor ':ICD_DisposeObjectPB))
; 
; --------------- Property parameter blocks ---------------
; 
(defrecord ICD_NewPropertyPB
   (header :ICDHEADER)
   (object (:pointer :OpaqueICAObject))         ;  <-- 
   (propertyInfo :ICAPropertyInfo)              ;  <-- 
   (property (:pointer :OpaqueICAProperty))     ;  --> 
)

;type name? (%define-record :ICD_NewPropertyPB (find-record-descriptor ':ICD_NewPropertyPB))
(defrecord ICD_DisposePropertyPB
   (header :ICDHEADER)
   (property (:pointer :OpaqueICAProperty))     ;  <-- 
)

;type name? (%define-record :ICD_DisposePropertyPB (find-record-descriptor ':ICD_DisposePropertyPB))
; 
;    
;    NOTE: for all APIs - pass NULL as completion parameter to make a synchronous call 
;    
; 
;  
; --------------- Object utilities for device libraries --------------- 
; 
; 
;  *  ICDNewObject()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
;  

(deftrap-inline "_ICDNewObject" 
   ((pb (:pointer :ICD_NewObjectPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICDDisposeObject()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
;  

(deftrap-inline "_ICDDisposeObject" 
   ((pb (:pointer :ICD_DisposeObjectPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICDNewProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
;  

(deftrap-inline "_ICDNewProperty" 
   ((pb (:pointer :ICD_NewPropertyPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  ICDDisposeProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   in ImageCaptureLib 1.0 and later
;  

(deftrap-inline "_ICDDisposeProperty" 
   ((pb (:pointer :ICD_DisposePropertyPB))
    (completion :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __ICADEVICE__ */


(provide-interface "ICADevice")