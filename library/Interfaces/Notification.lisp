(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Notification.h"
; at Sunday July 2,2006 7:24:58 pm.
; 
;      File:       HIToolbox/Notification.h
;  
;      Contains:   Notification Manager interfaces
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1989-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __NOTIFICATION__
; #define __NOTIFICATION__
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

;type name? (def-mactype :NMRec (find-mactype ':NMRec))

(def-mactype :NMRecPtr (find-mactype '(:pointer :NMRec)))

(def-mactype :NMProcPtr (find-mactype ':pointer)); (NMRecPtr nmReqPtr)

(def-mactype :NMUPP (find-mactype '(:pointer :OpaqueNMProcPtr)))
(defrecord NMRec
   (qLink (:pointer :QElem))                    ;  next queue entry
   (qType :SInt16)                              ;  queue type -- ORD(nmType) = 8
   (nmFlags :SInt16)                            ;  reserved
   (nmPrivate :signed-long)                     ;  reserved
   (nmReserved :SInt16)                         ;  reserved
   (nmMark :SInt16)                             ;  item to mark in Apple menu
   (nmIcon :Handle)                             ;  handle to small icon
   (nmSound :Handle)                            ;  handle to sound record
   (nmStr (:pointer :UInt8))                    ;  string to appear in alert
   (nmResp (:pointer :OpaqueNMProcPtr))         ;  pointer to response routine
   (nmRefCon :signed-long)                      ;  for application use
)
; 
;  *  NewNMUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewNMUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueNMProcPtr)
() )
; 
;  *  DisposeNMUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeNMUPP" 
   ((userUPP (:pointer :OpaqueNMProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeNMUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeNMUPP" 
   ((nmReqPtr (:pointer :NMREC))
    (userUPP (:pointer :OpaqueNMProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NMInstall()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NMInstall" 
   ((nmReqPtr (:pointer :NMREC))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NMRemove()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NMRemove" 
   ((nmReqPtr (:pointer :NMREC))
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

; #endif /* __NOTIFICATION__ */


(provide-interface "Notification")