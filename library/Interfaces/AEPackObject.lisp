(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AEPackObject.h"
; at Sunday July 2,2006 7:24:25 pm.
; 
;      File:       AE/AEPackObject.h
;  
;      Contains:   AppleEvents object packing Interfaces.
;  
;      Version:    AppleEvents-275~1
;  
;      Copyright:  © 1991-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __AEPACKOBJECT__
; #define __AEPACKOBJECT__
; #ifndef __APPLEEVENTS__
#| #|
#include <AEAppleEvents.h>
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
;  These are the object packing routines.  
; 
;  *  CreateOffsetDescriptor()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
;  

(deftrap-inline "_CreateOffsetDescriptor" 
   ((theOffset :signed-long)
    (theDescriptor (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CreateCompDescriptor()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
;  

(deftrap-inline "_CreateCompDescriptor" 
   ((comparisonOperator :FourCharCode)
    (operand1 (:pointer :AEDesc))
    (operand2 (:pointer :AEDesc))
    (disposeInputs :Boolean)
    (theDescriptor (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CreateLogicalDescriptor()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
;  

(deftrap-inline "_CreateLogicalDescriptor" 
   ((theLogicalTerms (:pointer :AEDescList))
    (theLogicOperator :FourCharCode)
    (disposeInputs :Boolean)
    (theDescriptor (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CreateObjSpecifier()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
;  

(deftrap-inline "_CreateObjSpecifier" 
   ((desiredClass :FourCharCode)
    (theContainer (:pointer :AEDesc))
    (keyForm :FourCharCode)
    (keyData (:pointer :AEDesc))
    (disposeInputs :Boolean)
    (objSpecifier (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CreateRangeDescriptor()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ObjectSupportLib 1.0 and later
;  

(deftrap-inline "_CreateRangeDescriptor" 
   ((rangeStart (:pointer :AEDesc))
    (rangeStop (:pointer :AEDesc))
    (disposeInputs :Boolean)
    (theDescriptor (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __AEPACKOBJECT__ */


(provide-interface "AEPackObject")