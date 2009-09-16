(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CMCalibrator.h"
; at Sunday July 2,2006 7:25:13 pm.
; 
;      File:       CommonPanels/CMCalibrator.h
;  
;      Contains:   ColorSync Calibration API
;  
;      Version:    CommonPanels-70~11
;  
;      Copyright:  © 1998-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CMCALIBRATOR__
; #define __CMCALIBRATOR__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __EVENTS__
#| #|
#include <HIToolboxEvents.h>
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

(def-mactype :CalibrateEventProcPtr (find-mactype ':pointer)); (EventRecord * event)

(def-mactype :CalibrateEventUPP (find-mactype '(:pointer :OpaqueCalibrateEventProcPtr)))
;  Interface for new ColorSync monitor calibrators (ColorSync 2.6 and greater) 

(defconstant $kCalibratorNamePrefix :|cali|)
(defrecord CalibratorInfo
   (dataSize :UInt32)                           ;  Size of this structure - compatibility 
   (displayID :UInt32)                          ;  Contains an hDC on Win32 
   (profileLocationSize :UInt32)                ;  Max size for returned profile location 
   (profileLocationPtr (:pointer :CMProfileLocation));  For returning the profile 
   (eventProc (:pointer :OpaqueCalibrateEventProcPtr));  Ignored on Win32 
   (isGood :Boolean)                            ;  true or false 
)

;type name? (%define-record :CalibratorInfo (find-record-descriptor ':CalibratorInfo))

(def-mactype :CanCalibrateProcPtr (find-mactype ':pointer)); (CMDisplayIDType displayID , Str255 errMessage)

(def-mactype :CalibrateProcPtr (find-mactype ':pointer)); (CalibratorInfo * theInfo)

(def-mactype :CanCalibrateUPP (find-mactype '(:pointer :OpaqueCanCalibrateProcPtr)))

(def-mactype :CalibrateUPP (find-mactype '(:pointer :OpaqueCalibrateProcPtr)))
; 
;  *  NewCalibrateEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCalibrateEventUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCalibrateEventProcPtr)
() )
; 
;  *  NewCanCalibrateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCanCalibrateUPP" 
   ((userRoutine :pointer)
   )
   (:pointer :OpaqueCanCalibrateProcPtr)
() )
; 
;  *  NewCalibrateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCalibrateUPP" 
   ((userRoutine :pointer)
   )
   (:pointer :OpaqueCalibrateProcPtr)
() )
; 
;  *  DisposeCalibrateEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCalibrateEventUPP" 
   ((userUPP (:pointer :OpaqueCalibrateEventProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCanCalibrateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCanCalibrateUPP" 
   ((userUPP (:pointer :OpaqueCanCalibrateProcPtr))
   )
   nil
() )
; 
;  *  DisposeCalibrateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCalibrateUPP" 
   ((userUPP (:pointer :OpaqueCalibrateProcPtr))
   )
   nil
() )
; 
;  *  InvokeCalibrateEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCalibrateEventUPP" 
   ((event (:pointer :EventRecord))
    (userUPP (:pointer :OpaqueCalibrateEventProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeCanCalibrateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCanCalibrateUPP" 
   ((displayID :UInt32)
    (errMessage (:pointer :STR255))
    (userUPP (:pointer :OpaqueCanCalibrateProcPtr))
   )
   :Boolean
() )
; 
;  *  InvokeCalibrateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCalibrateUPP" 
   ((theInfo (:pointer :CalibratorInfo))
    (userUPP (:pointer :OpaqueCalibrateProcPtr))
   )
   :OSErr
() )
; 
;  *  CMCalibrateDisplay()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMCalibrateDisplay" 
   ((theInfo (:pointer :CalibratorInfo))
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

; #endif /* __CMCALIBRATOR__ */


(provide-interface "CMCalibrator")