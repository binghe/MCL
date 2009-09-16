(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IBCarbonRuntime.h"
; at Sunday July 2,2006 7:25:07 pm.
; 
;      File:       HIToolbox/IBCarbonRuntime.h
;  
;      Contains:   Nib support for Carbon
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 2000-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __IBCARBONRUNTIME__
; #define __IBCARBONRUNTIME__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __MACWINDOWS__
#| #|
#include <HIToolboxMacWindows.h>
#endif
|#
 |#
; #ifndef __MENUS__
#| #|
#include <HIToolboxMenus.h>
#endif
|#
 |#
; #ifndef __CONTROLDEFINITIONS__
#| #|
#include <HIToolboxControlDefinitions.h>
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

(defconstant $kIBCarbonRuntimeCantFindNibFile -10960)
(defconstant $kIBCarbonRuntimeObjectNotOfRequestedType -10961)
(defconstant $kIBCarbonRuntimeCantFindObject -10962)
;  ----- typedef ------ 

(def-mactype :IBNibRef (find-mactype '(:pointer :OpaqueIBNibRef)))
;  ----- Create & Dispose NIB References ------ 
; 
;  *  CreateNibReference()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateNibReference" 
   ((inNibName (:pointer :__CFString))
    (outNibRef (:pointer :IBNIBREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateNibReferenceWithCFBundle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateNibReferenceWithCFBundle" 
   ((inBundle (:pointer :__CFBundle))
    (inNibName (:pointer :__CFString))
    (outNibRef (:pointer :IBNIBREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DisposeNibReference()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeNibReference" 
   ((inNibRef (:pointer :OpaqueIBNibRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  ----- Window ------ 
; 
;  *  CreateWindowFromNib()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateWindowFromNib" 
   ((inNibRef (:pointer :OpaqueIBNibRef))
    (inName (:pointer :__CFString))
    (outWindow (:pointer :WindowRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  ----- Menu -----
; 
;  *  CreateMenuFromNib()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateMenuFromNib" 
   ((inNibRef (:pointer :OpaqueIBNibRef))
    (inName (:pointer :__CFString))
    (outMenuRef (:pointer :MenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  ----- MenuBar ------
; 
;  *  CreateMenuBarFromNib()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateMenuBarFromNib" 
   ((inNibRef (:pointer :OpaqueIBNibRef))
    (inName (:pointer :__CFString))
    (outMenuBar (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetMenuBarFromNib()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetMenuBarFromNib" 
   ((inNibRef (:pointer :OpaqueIBNibRef))
    (inName (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __IBCARBONRUNTIME__ */


(provide-interface "IBCarbonRuntime")