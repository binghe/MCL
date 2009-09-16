(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:LSOpen.h"
; at Sunday July 2,2006 7:24:46 pm.
; 
;      File:       LaunchServices/LSOpen.h
;  
;      Contains:   Public interfaces for LaunchServices.framework
;  
;      Version:    LaunchServices-98~1
;  
;      Copyright:  © 2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __LSOPEN__
; #define __LSOPEN__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __LSINFO__
#| #|
#include <LaunchServicesLSInfo.h>
#endif
|#
 |#
; #ifndef __AE__
#| #|
#include <AEAE.h>
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
;  ======================================================================================================== 
;  LaunchServices Type & Constants                                                                          
;  ======================================================================================================== 

(def-mactype :LSLaunchFlags (find-mactype ':UInt32))

(defconstant $kLSLaunchDefaults 1)              ;  default = open, async, use Info.plist, start Classic

(defconstant $kLSLaunchAndPrint 2)              ;  print items instead of open them

(defconstant $kLSLaunchReserved2 4)
(defconstant $kLSLaunchReserved3 8)
(defconstant $kLSLaunchReserved4 16)
(defconstant $kLSLaunchReserved5 32)
(defconstant $kLSLaunchReserved6 64)
(defconstant $kLSLaunchInhibitBGOnly #x80)      ;  causes launch to fail if target is background-only.

(defconstant $kLSLaunchDontAddToRecents #x100)  ;  do not add app or documents to recents menus.

(defconstant $kLSLaunchDontSwitch #x200)        ;  don't bring new app to the foreground.

(defconstant $kLSLaunchNoParams #x800)          ;  Use Info.plist to determine launch parameters

(defconstant $kLSLaunchAsync #x10000)           ;  launch async; obtain results from kCPSNotifyLaunch.

(defconstant $kLSLaunchStartClassic #x20000)    ;  start up Classic environment if required for app.

(defconstant $kLSLaunchInClassic #x40000)       ;  force app to launch in Classic environment.

(defconstant $kLSLaunchNewInstance #x80000)     ;  Instantiate app even if it is already running.

(defconstant $kLSLaunchAndHide #x100000)        ;  Send child a "hide" request as soon as it checks in.

(defconstant $kLSLaunchAndHideOthers #x200000)  ;  Hide all other apps when child checks in.

(defrecord LSLaunchFSRefSpec
   (appRef (:pointer :FSRef))                   ;  app to use, can be NULL
   (numDocs :UInt32)                            ;  items to open/print, can be NULL
   (itemRefs (:pointer :FSRef))                 ;  array of FSRefs
   (passThruParams (:pointer :AEDesc))          ;  passed untouched to application as optional parameter
   (launchFlags :UInt32)
   (asyncRefCon :pointer)                       ;  used if you register for app birth/death notification
)

;type name? (%define-record :LSLaunchFSRefSpec (find-record-descriptor ':LSLaunchFSRefSpec))
(defrecord LSLaunchURLSpec
   (appURL (:pointer :__CFURL))                 ;  app to use, can be NULL
   (itemURLs (:pointer :__CFArray))             ;  items to open/print, can be NULL
   (passThruParams (:pointer :AEDesc))          ;  passed untouched to application as optional parameter
   (launchFlags :UInt32)
   (asyncRefCon :pointer)                       ;  used if you register for app birth/death notification
)

;type name? (%define-record :LSLaunchURLSpec (find-record-descriptor ':LSLaunchURLSpec))
;  ======================================================================================================== 
;  LaunchServices API                                                                                       
;  ======================================================================================================== 
; 
;  *  LSOpenFSRef()
;  *  
;  *  Summary:
;  *    Open an application, document, or folder.
;  *  
;  *  Discussion:
;  *    Opens applications, documents, and folders. Applications are
;  *    opened via an 'oapp' or 'rapp' event. Documents are opened in
;  *    their user-overridden or default applications as appropriate.
;  *    Folders are opened in the Finder. Use the more specific
;  *    LSOpenFromRefSpec for more control over launching.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inRef:
;  *      The FSRef of the item to launch.
;  *    
;  *    outLaunchedRef:
;  *      The FSRef of the item actually launched. For inRefs that are
;  *      documents, outLaunchedRef will be the application used to
;  *      launch the document. Can be NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSOpenFSRef" 
   ((inRef (:pointer :FSRef))
    (outLaunchedRef (:pointer :FSRef))          ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LSOpenCFURLRef()
;  *  
;  *  Summary:
;  *    Open an application, document, or folder.
;  *  
;  *  Discussion:
;  *    Opens applications, documents, and folders. Applications are
;  *    opened via an 'oapp' or 'rapp' event. Documents are opened in
;  *    their user-overridden or default applications as appropriate.
;  *    Folders are opened in the Finder. Use the more specific
;  *    LSOpenFromURLSpec for more control over launching.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inURL:
;  *      The CFURLRef of the item to launch.
;  *    
;  *    outLaunchedURL:
;  *      The CFURLRef of the item actually launched. For inURLs that are
;  *      documents, outLaunchedURL will be the application used to
;  *      launch the document. Can be NULL. THIS FUNCTION, DESPITE ITS
;  *      NAME, RETAINS THE URL REFERENCE ON BEHALF OF THE CALLER. THE
;  *      CALLER MUST EVENTUALLY RELEASE THE RETURNED URL REFERENCE.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSOpenCFURLRef" 
   ((inURL (:pointer :__CFURL))
    (outLaunchedURL (:pointer :CFURLRef))       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LSOpenFromRefSpec()
;  *  
;  *  Summary:
;  *    Opens an application or one or more documents or folders.
;  *  
;  *  Discussion:
;  *    Opens applications, documents, and folders.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inLaunchSpec:
;  *      The specification of what to launch and how to launch it.
;  *    
;  *    outLaunchedRef:
;  *      The FSRef of the item actually launched. For inRefs that are
;  *      documents, outLaunchedRef will be the application used to
;  *      launch the document. Can be NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSOpenFromRefSpec" 
   ((inLaunchSpec (:pointer :LSLaunchFSRefSpec))
    (outLaunchedRef (:pointer :FSRef))          ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LSOpenFromURLSpec()
;  *  
;  *  Summary:
;  *    Opens an application or one or more documents or folders.
;  *  
;  *  Discussion:
;  *    Opens applications, documents, and folders.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.2
;  *  
;  *  Parameters:
;  *    
;  *    inLaunchSpec:
;  *      The specification of what to launch and how to launch it.
;  *    
;  *    outLaunchedURL:
;  *      The CFURLRef of the item actually launched. For inURLs that are
;  *      documents, outLaunchedURL will be the application used to
;  *      launch the document. Can be NULL. THIS FUNCTION, DESPITE ITS
;  *      NAME, RETAINS THE URL REFERENCE ON BEHALF OF THE CALLER. THE
;  *      CALLER MUST EVENTUALLY RELEASE THE RETURNED URL REFERENCE.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LSOpenFromURLSpec" 
   ((inLaunchSpec (:pointer :LSLaunchURLSpec))
    (outLaunchedURL (:pointer :CFURLRef))       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __LSOPEN__ */


(provide-interface "LSOpen")