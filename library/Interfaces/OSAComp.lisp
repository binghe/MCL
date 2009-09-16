(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OSAComp.h"
; at Sunday July 2,2006 7:25:09 pm.
; 
;      File:       OpenScripting/OSAComp.h
;  
;      Contains:   AppleScript Component Implementor's Interfaces.
;  
;      Version:    OSA-62~76
;  
;      Copyright:  © 1992-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __OSACOMP__
; #define __OSACOMP__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
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
; *************************************************************************
;     Types and Constants
; *************************************************************************
; *************************************************************************
;     Routines for Associating a Storage Type with a Script Data Handle 
; *************************************************************************
; 
;  *  OSAGetStorageType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSAGetStorageType" 
   ((scriptData (:Handle :OpaqueAEDataStorageType))
    (dscType (:pointer :DescType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  OSAAddStorageType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSAAddStorageType" 
   ((scriptData (:Handle :OpaqueAEDataStorageType))
    (dscType :FourCharCode)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  OSARemoveStorageType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSARemoveStorageType" 
   ((scriptData (:Handle :OpaqueAEDataStorageType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __OSACOMP__ */


(provide-interface "OSAComp")