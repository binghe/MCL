(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OSAGeneric.h"
; at Sunday July 2,2006 7:25:09 pm.
; 
;      File:       OpenScripting/OSAGeneric.h
;  
;      Contains:   AppleScript Generic Component Interfaces.
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
; #ifndef __OSAGENERIC__
; #define __OSAGENERIC__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __OSA__
#| #|
#include <OpenScriptingOSA.h>
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
;     NOTE:   This interface defines a "generic scripting component."
;             The Generic Scripting Component allows automatic dispatch to a
;             specific scripting component that conforms to the OSA interface.
;             This component supports OSA, by calling AppleScript or some other 
;             scripting component.  Additionally it provides access to the default
;             and the user-prefered scripting component.
; 
;  Component version this header file describes 

(defconstant $kGenericComponentVersion #x100)

(defconstant $kGSSSelectGetDefaultScriptingComponent #x1001)
(defconstant $kGSSSelectSetDefaultScriptingComponent #x1002)
(defconstant $kGSSSelectGetScriptingComponent #x1003)
(defconstant $kGSSSelectGetScriptingComponentFromStored #x1004)
(defconstant $kGSSSelectGenericToRealID #x1005)
(defconstant $kGSSSelectRealToGenericID #x1006)
(defconstant $kGSSSelectOutOfRange #x1007)

(def-mactype :ScriptingComponentSelector (find-mactype ':OSType))

(def-mactype :GenericID (find-mactype ':UInt32))
;  get and set the default scripting component 
; 
;  *  OSAGetDefaultScriptingComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSAGetDefaultScriptingComponent" 
   ((genericScriptingComponent (:pointer :ComponentInstanceRecord))
    (scriptingSubType (:pointer :SCRIPTINGCOMPONENTSELECTOR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  OSASetDefaultScriptingComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSASetDefaultScriptingComponent" 
   ((genericScriptingComponent (:pointer :ComponentInstanceRecord))
    (scriptingSubType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  get a scripting component instance from its subtype code 
; 
;  *  OSAGetScriptingComponent()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSAGetScriptingComponent" 
   ((genericScriptingComponent (:pointer :ComponentInstanceRecord))
    (scriptingSubType :OSType)
    (scriptingInstance (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  get a scripting component selector (subType) from a stored script 
; 
;  *  OSAGetScriptingComponentFromStored()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSAGetScriptingComponentFromStored" 
   ((genericScriptingComponent (:pointer :ComponentInstanceRecord))
    (scriptData (:pointer :AEDesc))
    (scriptingSubType (:pointer :SCRIPTINGCOMPONENTSELECTOR))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  get a real component instance and script id from a generic id 
; 
;  *  OSAGenericToRealID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSAGenericToRealID" 
   ((genericScriptingComponent (:pointer :ComponentInstanceRecord))
    (theScriptID (:pointer :OSAID))
    (theExactComponent (:pointer :ComponentInstance))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  get a generic id from a real component instance and script id 
; 
;  *  OSARealToGenericID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSARealToGenericID" 
   ((genericScriptingComponent (:pointer :ComponentInstanceRecord))
    (theScriptID (:pointer :OSAID))
    (theExactComponent (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __OSAGENERIC__ */


(provide-interface "OSAGeneric")