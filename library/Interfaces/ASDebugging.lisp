(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ASDebugging.h"
; at Sunday July 2,2006 7:25:10 pm.
; 
;      File:       OpenScripting/ASDebugging.h
;  
;      Contains:   AppleScript Debugging Interfaces.
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
; #ifndef __ASDEBUGGING__
; #define __ASDEBUGGING__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __APPLESCRIPT__
#| #|
#include <OpenScriptingAppleScript.h>
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
;     Mode Flags
; *************************************************************************
;     This mode flag can be passed to OSASetProperty or OSASetHandler
;     and will prevent properties or handlers from being defined in a context
;     that doesn't already have bindings for them. An error is returned if
;     a current binding doesn't already exist. 
; 

(defconstant $kOSAModeDontDefine 1)
; *************************************************************************
;     Component Selectors
; *************************************************************************

(defconstant $kASSelectSetPropertyObsolete #x1101)
(defconstant $kASSelectGetPropertyObsolete #x1102)
(defconstant $kASSelectSetHandlerObsolete #x1103)
(defconstant $kASSelectGetHandlerObsolete #x1104)
(defconstant $kASSelectGetAppTerminologyObsolete #x1105)
(defconstant $kASSelectSetProperty #x1106)
(defconstant $kASSelectGetProperty #x1107)
(defconstant $kASSelectSetHandler #x1108)
(defconstant $kASSelectGetHandler #x1109)
(defconstant $kASSelectGetAppTerminology #x110A)
(defconstant $kASSelectGetSysTerminology #x110B)
(defconstant $kASSelectGetPropertyNames #x110C)
(defconstant $kASSelectGetHandlerNames #x110D)
; *************************************************************************
;     Context Accessors
; *************************************************************************
; 
;  *  OSASetProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSASetProperty" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (modeFlags :signed-long)
    (contextID :UInt32)
    (variableName (:pointer :AEDesc))
    (scriptValueID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  OSAGetProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSAGetProperty" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (modeFlags :signed-long)
    (contextID :UInt32)
    (variableName (:pointer :AEDesc))
    (resultingScriptValueID (:pointer :OSAID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  OSAGetPropertyNames()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSAGetPropertyNames" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (modeFlags :signed-long)
    (contextID :UInt32)
    (resultingPropertyNames (:pointer :AEDescList))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  OSASetHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSASetHandler" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (modeFlags :signed-long)
    (contextID :UInt32)
    (handlerName (:pointer :AEDesc))
    (compiledScriptID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  OSAGetHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSAGetHandler" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (modeFlags :signed-long)
    (contextID :UInt32)
    (handlerName (:pointer :AEDesc))
    (resultingCompiledScriptID (:pointer :OSAID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  OSAGetHandlerNames()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSAGetHandlerNames" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (modeFlags :signed-long)
    (contextID :UInt32)
    (resultingHandlerNames (:pointer :AEDescList))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  OSAGetAppTerminology()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSAGetAppTerminology" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (modeFlags :signed-long)
    (fileSpec (:pointer :FSSpec))
    (terminologyID :SInt16)
    (didLaunch (:pointer :Boolean))
    (terminologyList (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Errors:
;        errOSASystemError        operation failed
;     
; 
;  *  OSAGetSysTerminology()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_OSAGetSysTerminology" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (modeFlags :signed-long)
    (terminologyID :SInt16)
    (terminologyList (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Errors:
;        errOSASystemError        operation failed
;     
;  Notes on terminology ID
; 
;     A terminology ID is derived from script code and language code
;     as follows;
; 
;         terminologyID = ((scriptCode & 0x7F) << 8) | (langCode & 0xFF)
; 
; *************************************************************************
;     Obsolete versions provided for backward compatibility:
; 
; 
;  *  ASSetProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_ASSetProperty" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (contextID :UInt32)
    (variableName (:pointer :AEDesc))
    (scriptValueID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ASGetProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_ASGetProperty" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (contextID :UInt32)
    (variableName (:pointer :AEDesc))
    (resultingScriptValueID (:pointer :OSAID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ASSetHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_ASSetHandler" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (contextID :UInt32)
    (handlerName (:pointer :AEDesc))
    (compiledScriptID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ASGetHandler()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_ASGetHandler" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (contextID :UInt32)
    (handlerName (:pointer :AEDesc))
    (resultingCompiledScriptID (:pointer :OSAID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  ASGetAppTerminology()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_ASGetAppTerminology" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (fileSpec (:pointer :FSSpec))
    (terminologID :SInt16)
    (didLaunch (:pointer :Boolean))
    (terminologyList (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Errors:
;         errOSASystemError       operation failed
;     
; ************************************************************************
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __ASDEBUGGING__ */


(provide-interface "ASDebugging")