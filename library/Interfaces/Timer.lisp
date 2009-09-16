(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Timer.h"
; at Sunday July 2,2006 7:23:28 pm.
; 
;      File:       CarbonCore/Timer.h
;  
;      Contains:   Time Manager interfaces.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __TIMER__
; #define __TIMER__
; #ifndef __CONDITIONALMACROS__
#| #|
#include <CarbonCoreConditionalMacros.h>
#endif
|#
 |#
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __OSUTILS__
#| #|
#include <CarbonCoreOSUtils.h>
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
;  high bit of qType is set if task is active 

(defconstant $kTMTaskActive #x8000)

;type name? (def-mactype :TMTask (find-mactype ':TMTask))

(def-mactype :TMTaskPtr (find-mactype '(:pointer :TMTask)))

(def-mactype :TimerProcPtr (find-mactype ':pointer)); (TMTaskPtr tmTaskPtr)

(def-mactype :TimerUPP (find-mactype '(:pointer :OpaqueTimerProcPtr)))
(defrecord TMTask
   (qLink (:pointer :QElem))
   (qType :SInt16)
   (tmAddr (:pointer :OpaqueTimerProcPtr))
   (tmCount :signed-long)
   (tmWakeUp :signed-long)
   (tmReserved :signed-long)
)
; 
;  *  InsTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InsTime" 
   ((tmTaskPtr (:pointer :QElem))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InsXTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InsXTime" 
   ((tmTaskPtr (:pointer :QElem))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PrimeTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PrimeTime" 
   ((tmTaskPtr (:pointer :QElem))
    (count :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RmvTime()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RmvTime" 
   ((tmTaskPtr (:pointer :QElem))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  InstallTimeTask, InstallXTimeTask, PrimeTimeTask and RemoveTimeTask work 
;  just like InsTime, InsXTime, PrimeTime, and RmvTime except that they 
;  return an OSErr result. 
; 
;  *  InstallTimeTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_InstallTimeTask" 
   ((tmTaskPtr (:pointer :QElem))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InstallXTimeTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_InstallXTimeTask" 
   ((tmTaskPtr (:pointer :QElem))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  PrimeTimeTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_PrimeTimeTask" 
   ((tmTaskPtr (:pointer :QElem))
    (count :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RemoveTimeTask()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.1 and later
;  

(deftrap-inline "_RemoveTimeTask" 
   ((tmTaskPtr (:pointer :QElem))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  Microseconds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Microseconds" 
   ((microTickCount (:pointer :UnsignedWide))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NewTimerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewTimerUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTimerProcPtr)
() )
; 
;  *  DisposeTimerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeTimerUPP" 
   ((userUPP (:pointer :OpaqueTimerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeTimerUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeTimerUPP" 
   ((tmTaskPtr (:pointer :TMTASK))
    (userUPP (:pointer :OpaqueTimerProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __TIMER__ */


(provide-interface "Timer")