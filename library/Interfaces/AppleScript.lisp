(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AppleScript.h"
; at Sunday July 2,2006 7:25:10 pm.
; 
;      File:       OpenScripting/AppleScript.h
;  
;      Contains:   AppleScript Specific Interfaces.
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
; #ifndef __APPLESCRIPT__
; #define __APPLESCRIPT__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __OSA__
#| #|
#include <OpenScriptingOSA.h>
#endif
|#
 |#
; #ifndef __TEXTEDIT__
#| #|
#include <HIToolboxTextEdit.h>
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
; 
;     The specific type for the AppleScript instance of the
;     Open Scripting Architecture type.
; 

(defconstant $typeAppleScript :|ascr|)
(defconstant $kAppleScriptSubtype :|ascr|)
(defconstant $typeASStorage :|ascr|)
; *************************************************************************
;     Component Selectors
; *************************************************************************

(defconstant $kASSelectInit #x1001)
(defconstant $kASSelectSetSourceStyles #x1002)
(defconstant $kASSelectGetSourceStyles #x1003)
(defconstant $kASSelectGetSourceStyleNames #x1004)
; *************************************************************************
;     OSAGetScriptInfo Selectors
; *************************************************************************

(defconstant $kASHasOpenHandler :|hsod|)
; 
;         This selector is used to query a context as to whether it contains
;         a handler for the kAEOpenDocuments event. This allows "applets" to be 
;         distinguished from "droplets."  OSAGetScriptInfo returns false if
;         there is no kAEOpenDocuments handler, and returns the error value 
;         errOSAInvalidAccess if the input is not a context.
;     
; *************************************************************************
;     Initialization
; *************************************************************************
; 
;  *  ASInit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_ASInit" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (modeFlags :signed-long)
    (minStackSize :signed-long)
    (preferredStackSize :signed-long)
    (maxStackSize :signed-long)
    (minHeapSize :signed-long)
    (preferredHeapSize :signed-long)
    (maxHeapSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;         ComponentCallNow(kASSelectInit, 28);
;         This call can be used to explicitly initialize AppleScript.  If it is
;         not called, the a scripting size resource is looked for and used. If
;         there is no scripting size resource, then the constants listed below
;         are used.  If at any stage (the init call, the size resource, the 
;         defaults) any of these parameters are zero, then parameters from the
;         next stage are used.  ModeFlags are not currently used.
;         Errors:
;         errOSASystemError       initialization failed
;     
; 
;     These values will be used if ASInit is not called explicitly, or if any
;     of ASInit's parameters are zero:
; 

(defconstant $kASDefaultMinStackSize #x1000)
(defconstant $kASDefaultPreferredStackSize #x4000)
(defconstant $kASDefaultMaxStackSize #x4000)
(defconstant $kASDefaultMinHeapSize #x1000)
(defconstant $kASDefaultPreferredHeapSize #x4000)
(defconstant $kASDefaultMaxHeapSize #x2000000)
; *************************************************************************
;     Source Styles
; *************************************************************************
; 
;  *  ASSetSourceStyles()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_ASSetSourceStyles" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (sourceStyles (:Handle :STElement))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;         ComponentCallNow(kASSelectSetSourceStyles, 4);
;         Errors:
;         errOSASystemError       operation failed
;     
; 
;  *  ASGetSourceStyles()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_ASGetSourceStyles" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (resultingSourceStyles (:pointer :STHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;         ComponentCallNow(kASSelectGetSourceStyles, 4);
;         Errors:
;         errOSASystemError       operation failed
;     
; 
;  *  ASGetSourceStyleNames()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppleScriptLib 1.1 and later
;  

(deftrap-inline "_ASGetSourceStyleNames" 
   ((scriptingComponent (:pointer :ComponentInstanceRecord))
    (modeFlags :signed-long)
    (resultingSourceStyleNamesList (:pointer :AEDescList))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;         ComponentCallNow(kASSelectGetSourceStyleNames, 8);
;         This call returns an AEList of styled text descriptors the names of the
;         source styles in the current dialect.  The order of the names corresponds
;         to the order of the source style constants, below.  The style of each
;         name is the same as the styles returned by ASGetSourceStyles.
;         
;         Errors:
;         errOSASystemError       operation failed
;     
; 
;     Elements of STHandle correspond to following categories of tokens, and
;     accessed through following index constants:
; 

(defconstant $kASSourceStyleUncompiledText 0)
(defconstant $kASSourceStyleNormalText 1)
(defconstant $kASSourceStyleLanguageKeyword 2)
(defconstant $kASSourceStyleApplicationKeyword 3)
(defconstant $kASSourceStyleComment 4)
(defconstant $kASSourceStyleLiteral 5)
(defconstant $kASSourceStyleUserSymbol 6)
(defconstant $kASSourceStyleObjectSpecifier 7)
(defconstant $kASNumberOfSourceStyles 8)
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __APPLESCRIPT__ */


(provide-interface "AppleScript")