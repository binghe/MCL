(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PMCore.h"
; at Sunday July 2,2006 7:24:42 pm.
; 
;      File:       PrintCore/PMCore.h
;  
;      Contains:   Carbon Printing Manager Interfaces.
;  
;      Version:    PrintingCore-129~1
;  
;      Copyright:  © 1998-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __PMCORE__
; #define __PMCORE__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __QUICKDRAW__
#| #|
#include <QDQuickdraw.h>
#endif
|#
 |#
; #ifndef __CMAPPLICATION__
#| #|
#include <ColorSyncCMApplication.h>
#endif
|#
 |#
; #ifndef __PMDEFINITIONS__

(require-interface "PrintCore/PMDefinitions")

; #endif


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
; #ifndef PM_USE_SESSION_APIS
(defconstant $PM_USE_SESSION_APIS 1)
; #define PM_USE_SESSION_APIS 1

; #endif  /* !defined(PM_USE_SESSION_APIS) */

;  Callbacks 

(def-mactype :PMIdleProcPtr (find-mactype ':pointer)); (void)

(def-mactype :PMIdleUPP (find-mactype '(:pointer :OpaquePMIdleProcPtr)))
; 
;  *  NewPMIdleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewPMIdleUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaquePMIdleProcPtr)
() )
; 
;  *  DisposePMIdleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposePMIdleUPP" 
   ((userUPP (:pointer :OpaquePMIdleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokePMIdleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokePMIdleUPP" 
   ((userUPP (:pointer :OpaquePMIdleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

; #if PM_USE_SESSION_APIS
;  Session routines 
;  Session support 
; 
;  *  PMRetain()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMRetain" 
   ((object (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMRelease()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMRelease" 
   ((object (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Session Print loop 
; **********************
;  A session is created with a refcount of 1. 
; **********************
; 
;  *  PMCreateSession()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMCreateSession" 
   ((printSession (:pointer :PMPRINTSESSION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Session PMPageFormat 
; **********************
;  A pageformat is created with a refcount of 1. 
; **********************
; 
;  *  PMCreatePageFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMCreatePageFormat" 
   ((pageFormat (:pointer :PMPAGEFORMAT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionDefaultPageFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionDefaultPageFormat" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (pageFormat (:pointer :OpaquePMPageFormat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionValidatePageFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionValidatePageFormat" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (pageFormat (:pointer :OpaquePMPageFormat))
    (result (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Session PMPrintSettings 
; **********************
;  A printSettings is created with a refcount of 1. 
; **********************
; 
;  *  PMCreatePrintSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMCreatePrintSettings" 
   ((printSettings (:pointer :PMPRINTSETTINGS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionDefaultPrintSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionDefaultPrintSettings" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printSettings (:pointer :OpaquePMPrintSettings))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionValidatePrintSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionValidatePrintSettings" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printSettings (:pointer :OpaquePMPrintSettings))
    (result (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Session Classic support 
; 
;  *  PMSessionGeneral()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionGeneral" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (pData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionConvertOldPrintRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionConvertOldPrintRecord" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printRecordHandle :Handle)
    (printSettings (:pointer :PMPRINTSETTINGS))
    (pageFormat (:pointer :PMPAGEFORMAT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionMakeOldPrintRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionMakeOldPrintRecord" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printSettings (:pointer :OpaquePMPrintSettings))
    (pageFormat (:pointer :OpaquePMPageFormat))
    (printRecordHandle (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Session Driver Information 
; 
;  *  PMPrinterGetDescriptionURL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetDescriptionURL" 
   ((printer (:pointer :OpaquePMPrinter))
    (descriptionType (:pointer :__CFString))
    (fileURL (:pointer :CFURLRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionGetCurrentPrinter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionGetCurrentPrinter" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (currentPrinter (:pointer :PMPRINTER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterGetLanguageInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetLanguageInfo" 
   ((printer (:pointer :OpaquePMPrinter))
    (info (:pointer :PMLanguageInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterGetDriverCreator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetDriverCreator" 
   ((printer (:pointer :OpaquePMPrinter))
    (creator (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterGetDriverReleaseInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetDriverReleaseInfo" 
   ((printer (:pointer :OpaquePMPrinter))
    (release (:pointer :VersRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterGetPrinterResolutionCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetPrinterResolutionCount" 
   ((printer (:pointer :OpaquePMPrinter))
    (count (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterGetPrinterResolution()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetPrinterResolution" 
   ((printer (:pointer :OpaquePMPrinter))
    (tag :UInt32)
    (res (:pointer :PMResolution))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterGetIndexedPrinterResolution()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetIndexedPrinterResolution" 
   ((printer (:pointer :OpaquePMPrinter))
    (index :UInt32)
    (res (:pointer :PMResolution))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterIsPostScriptCapable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterIsPostScriptCapable" 
   ((printer (:pointer :OpaquePMPrinter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Boolean
() )
; 
;  *  PMPrinterGetMakeAndModelName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetMakeAndModelName" 
   ((printer (:pointer :OpaquePMPrinter))
    (makeAndModel (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
;  Session ColorSync & PostScript Support 
; 
;  *  PMSessionEnableColorSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionEnableColorSync" 
   ((printSession (:pointer :OpaquePMPrintSession))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionDisableColorSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionDisableColorSync" 
   ((printSession (:pointer :OpaquePMPrintSession))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionPostScriptBegin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionPostScriptBegin" 
   ((printSession (:pointer :OpaquePMPrintSession))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionPostScriptEnd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionPostScriptEnd" 
   ((printSession (:pointer :OpaquePMPrintSession))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionPostScriptHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionPostScriptHandle" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (psHandle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionPostScriptData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionPostScriptData" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (psPtr :pointer)
    (len :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionPostScriptFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionPostScriptFile" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (psFile (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionSetPSInjectionData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionSetPSInjectionData" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printSettings (:pointer :OpaquePMPrintSettings))
    (injectionDictArray (:pointer :__CFArray))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Session Error 
; 
;  *  PMSessionError()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionError" 
   ((printSession (:pointer :OpaquePMPrintSession))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionSetError()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionSetError" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printError :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Other Session routines 
; 
;  *  PMSessionGetDocumentFormatGeneration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionGetDocumentFormatGeneration" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (docFormats (:pointer :CFArrayRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionSetDocumentFormatGeneration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionSetDocumentFormatGeneration" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (docFormat (:pointer :__CFString))
    (graphicsContextTypes (:pointer :__CFArray))
    (options (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionGetDocumentFormatSupported()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionGetDocumentFormatSupported" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (docFormats (:pointer :CFArrayRef))
    (limit :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionIsDocumentFormatSupported()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionIsDocumentFormatSupported" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (docFormat (:pointer :__CFString))
    (supported (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionGetGraphicsContext()
;  *  
;  *  Parameters:
;  *    
;  *    printSession:
;  *      the session
;  *    
;  *    graphicsContextType:
;  *      either kPMGraphicsContextQuickdraw or
;  *      kPMGraphicsContextCoreGraphics
;  *    
;  *    graphicsContext:
;  *      returns a GrafPtr or a CGContextRef
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionGetGraphicsContext" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (graphicsContextType (:pointer :__CFString))
    (graphicsContext :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionSetIdleProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionSetIdleProc" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (idleProc (:pointer :OpaquePMIdleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionSetDataInSession()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionSetDataInSession" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (key (:pointer :__CFString))
    (data (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionGetDataFromSession()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionGetDataFromSession" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (key (:pointer :__CFString))
    (data (:pointer :CFTypeRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionCreatePrinterList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionCreatePrinterList" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printerList (:pointer :CFArrayRef))
    (currentIndex (:pointer :CFIndex))
    (currentPrinter (:pointer :PMPRINTER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionSetCurrentPrinter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.4 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionSetCurrentPrinter" 
   ((session (:pointer :OpaquePMPrintSession))
    (printerName (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionSetCurrentPMPrinter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionSetCurrentPMPrinter" 
   ((session (:pointer :OpaquePMPrintSession))
    (printer (:pointer :OpaquePMPrinter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionSetDestination()
;  *  
;  *  Summary:
;  *    Alter a print session and print settings so that an associated
;  *    print job is sent to the provided destination type in the,
;  *    optional, MIME document format.
;  *  
;  *  Discussion:
;  *    This function is most useful when an application would like to
;  *    write its print output to disk without requiring user
;  *    interaction. The list of MIME types that can be sent to the
;  *    provided destination can be obtained from
;  *    PMSessionCopyOutputFormatList and one of these passed to this
;  *    function.
;  *  
;  *  Parameters:
;  *    
;  *    printSession:
;  *      The session to be used for a print job. The session holds the
;  *      preview setting which can override the destination type in the
;  *      print settings.
;  *    
;  *    printSettings:
;  *      The print settings to be used for a print job. The print
;  *      settings specify whether a job will be directed toward a
;  *      printer or to file. It also holds the requested MIME output
;  *      type.
;  *    
;  *    destType:
;  *      The destiation type for a print job associated with the
;  *      provided print session and print settings. Fax is currently not
;  *      supported, but kPMDestinationPrinter, kPMDestinationFile, and
;  *      kPMDestinationPreview can be set.
;  *    
;  *    destFormat:
;  *      The MIME type to be generated for the provided destination
;  *      type. This parameter can be NULL in which the default format
;  *      for the requested destination type is used. To obtain a list of
;  *      valid formats for a given destiation type, use the function
;  *      PMSessionCopyOutputFormatList.
;  *    
;  *    destLocation:
;  *      Some destination types support a destination location. The
;  *      clearest example is the kPMDestinationFile destination type
;  *      which allows a caller to also supply a file URL specifying
;  *      where the output file is to be created.
;  *    
;  *    SPECIAL_AVAILABILITY_NOTE:
;  *      This routine is available in ApplicationsServices.framework in
;  *      Mac OS X version 10.1 and later. On Mac OS X it is available to
;  *      CFM applications through CarbonLib starting with Mac OS X
;  *      version 10.2 and later.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionSetDestination" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printSettings (:pointer :OpaquePMPrintSettings))
    (destType :UInt16)
    (destFormat (:pointer :__CFString))
    (destLocation (:pointer :__CFURL))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionGetDestinationType()
;  *  
;  *  Summary:
;  *    Hand back the destination type that will be used for a print job
;  *    with the specified print settings and print session.
;  *  
;  *  Discussion:
;  *    Currently there are four destination types:
;  *    kPMDestinationPrinter, kPMDestinationFile, kPMDestinationFax and
;  *    kPMDestinationPreview. The first three destination types are
;  *    stored in the print settings. The switch for preview is stored in
;  *    the print session and, if enabled, overrides the destination in
;  *    the print setting. This function is preferred over
;  *    PMGetDestination as the latter does not take a print session
;  *    parameter and therefore can not indicate whether preview has been
;  *    selected as the destination.
;  *  
;  *  Parameters:
;  *    
;  *    printSession:
;  *      The session to be used for a print job. The session holds the
;  *      preview setting which can override the destination type in the
;  *      print settings.
;  *    
;  *    printSettings:
;  *      The print settings to be used for a print job. The print
;  *      settings specify whether a job will be directed toward a
;  *      printer or to file.
;  *    
;  *    destTypeP:
;  *      A pointer to a caller supplied PMDestinationType variable. If
;  *      this function succeeds then *'destTypeP' will be filled in with
;  *      the destination type for a print job that used the specified
;  *      session and print settings. If this function fails, then
;  *      *'destType' will be set to kPMDestinationInvalid.
;  *    
;  *    SPECIAL_AVAILABILITY_NOTE:
;  *      This routine is available in ApplicationsServices.framework in
;  *      Mac OS X version 10.1 and later. On Mac OS X it is available to
;  *      CFM applications through CarbonLib starting with Mac OS X
;  *      version 10.2 and later.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionGetDestinationType" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printSettings (:pointer :OpaquePMPrintSettings))
    (destTypeP (:pointer :PMDESTINATIONTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionCopyDestinationFormat()
;  *  
;  *  Summary:
;  *    Hand back the destination output MIME type associated with the
;  *    provided print session and print settings.
;  *  
;  *  Parameters:
;  *    
;  *    printSession:
;  *      A currently open print session.
;  *    
;  *    printSettings:
;  *      The print settings that are to be searched.
;  *    
;  *    destFormatP:
;  *      A pointer to a caller allocated CFStringRef variable. If this
;  *      routine returns noErr then *'destFormatP' will either be a copy
;  *      of a CFStringRef specifying the output format for the print
;  *      job, or NULL indicating that the default output format will be
;  *      used. If this function return an error, then *'destFormatP'
;  *      will be set to NULL.
;  *    
;  *    SPECIAL_AVAILABILITY_NOTE:
;  *      This routine is available in ApplicationsServices.framework in
;  *      Mac OS X version 10.1 and later. On Mac OS X it is available to
;  *      CFM applications through CarbonLib starting with Mac OS X
;  *      version 10.2 and later.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionCopyDestinationFormat" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printSettings (:pointer :OpaquePMPrintSettings))
    (destFormatP (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionCopyDestinationLocation()
;  *  
;  *  Summary:
;  *    Hand back the URL destination location given a print session and
;  *    print settings.
;  *  
;  *  Discussion:
;  *    Some destination type support a destination location which
;  *    further defines where the output from a pritn job should be sent.
;  *    The kPMDestinationFile destiation type, for example, will use a
;  *    file URL to determine where a new file should be created.
;  *  
;  *  Parameters:
;  *    
;  *    printSession:
;  *      A currently open print session.
;  *    
;  *    printSettings:
;  *      The print settings that are to be searched.
;  *    
;  *    destLocationP:
;  *      A pointer to a caller allocated CFURLRef variable. If this
;  *      routine returns noErr then *'outputFileP' will either be NULL
;  *      indicating that the job is using the default destination
;  *      location for the current destination type or a copy of a
;  *      CFURLRef will be placed in *'destLocationP'. If this function
;  *      returns an error then 'destLocationP' will be set to NULL.
;  *    
;  *    SPECIAL_AVAILABILITY_NOTE:
;  *      This routine is available in ApplicationsServices.framework in
;  *      Mac OS X version 10.1 and later. On Mac OS X it is available to
;  *      CFM applications through CarbonLib starting with Mac OS X
;  *      version 10.2 and later.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionCopyDestinationLocation" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printSettings (:pointer :OpaquePMPrintSettings))
    (destLocationP (:pointer :CFURLRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionCopyOutputFormatList()
;  *  
;  *  Summary:
;  *    Hands back an an array of MIME types describing the possible
;  *    output formats for the printer module associated with the current
;  *    printer.
;  *  
;  *  Parameters:
;  *    
;  *    printSession:
;  *      This session's current printer's printer module will be queried
;  *      for its supported output MIME types.
;  *    
;  *    destType:
;  *      A print job can have one of several possible destination types.
;  *      The list of valid output formats is dependent upon the
;  *      destination type. This parameter specifies destination type of
;  *      interest when retrieving the output formats list.
;  *    
;  *    documentFormatP:
;  *      A pointer to a caller's CFArrayRef variable. If this routine
;  *      completes successfully, then *'documentFormatP' will be set to
;  *      a CFArrayRef containing CFStringRefs. Each CFStringRef in the
;  *      array is a MIME type specifying a type of output that can be
;  *      generated by the printer module associated with the current
;  *      printer.
;  *    
;  *    SPECIAL_AVAILABILITY_NOTE:
;  *      This routine is available in ApplicationsServices.framework in
;  *      Mac OS X version 10.1 and later. On Mac OS X it is available to
;  *      CFM applications through CarbonLib starting with Mac OS X
;  *      version 10.2 and later. On Mac OS 8/9 using CarbonLib, this
;  *      routine returns kPMNotImplemented
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionCopyOutputFormatList" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (destType :UInt16)
    (documentFormatP (:pointer :CFArrayRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionCreatePageFormatList()
;  *  
;  *  Summary:
;  *    Hand back a list of page format instances. Each page format
;  *    instance describes a paper size available on the specified
;  *    printer.
;  *  
;  *  Parameters:
;  *    
;  *    printSession:
;  *      A currently open print session.
;  *    
;  *    printer:
;  *      The printer whose page size list should be enumerated. To get
;  *      the session's current printer, see PMSessionGetCurrentPrinter().
;  *    
;  *    pageFormatList:
;  *      If this function is successful then noErr will be returned and
;  *      *'pageFormatList' will be set to a newly created CFArray. Each
;  *      element in the array will be a PMPageFormat describing an
;  *      available paper size for the specified printer. If this
;  *      function fails then a non-zero error code will be returned and
;  *      *'pageFormatList' will be set to NULL.
;  *    
;  *    SPECIAL_AVAILABILITY_NOTE:
;  *      This routine is available in ApplicationsServices.framework in
;  *      Mac OS X version 10.1 and later. On Mac OS X it is available to
;  *      CFM applications through CarbonLib starting with Mac OS X
;  *      version 10.2 and later. On Mac OS 8/9 using CarbonLib, this
;  *      routine returns kPMNotImplemented
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionCreatePageFormatList" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printer (:pointer :OpaquePMPrinter))
    (pageFormatList (:pointer :CFArrayRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  * SPECIAL AVAILABILITY note: This routine is available in ApplicationsServices.framework in
;  * Mac OS X version 10.0 and later. On Mac OS X it is available to CFM applications through CarbonLib
;  * starting with Mac OS X version 10.2 and later.
;  *
;  * On Mac OS 8/9 using CarbonLib, this routine returns kPMNotImplemented
;  
; 
;  *  PMSessionBeginDocumentNoDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionBeginDocumentNoDialog" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printSettings (:pointer :OpaquePMPrintSettings))
    (pageFormat (:pointer :OpaquePMPageFormat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  * SPECIAL AVAILABILITY note: This routine is available in ApplicationsServices.framework in
;  * Mac OS X version 10.0 and later. On Mac OS X it is available to CFM applications through CarbonLib
;  * starting with Mac OS X version 10.2 and later.
;  *
;  * On Mac OS 8/9 using CarbonLib, this routine returns kPMNotImplemented
;  
; 
;  *  PMSessionEndDocumentNoDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionEndDocumentNoDialog" 
   ((printSession (:pointer :OpaquePMPrintSession))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  * SPECIAL AVAILABILITY note: This routine is available in ApplicationsServices.framework in
;  * Mac OS X version 10.0 and later. On Mac OS X it is available to CFM applications through CarbonLib
;  * starting with Mac OS X version 10.2 and later.
;  *
;  * On Mac OS 8/9 using CarbonLib, this routine returns kPMNotImplemented
;  
; 
;  *  PMSessionBeginPageNoDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionBeginPageNoDialog" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (pageFormat (:pointer :OpaquePMPageFormat))
    (pageFrame (:pointer :PMRect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  * SPECIAL AVAILABILITY note: This routine is available in ApplicationsServices.framework in
;  * Mac OS X version 10.0 and later. On Mac OS X it is available to CFM applications through CarbonLib
;  * starting with Mac OS X version 10.2 and later.
;  *
;  * On Mac OS 8/9 using CarbonLib, this routine returns kPMNotImplemented
;  
; 
;  *  PMSessionEndPageNoDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionEndPageNoDialog" 
   ((printSession (:pointer :OpaquePMPrintSession))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
#| 
; #else
; 
;  *  PMSetIdleProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetIdleProc" 
   ((idleProc (:pointer :OpaquePMIdleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Print loop 
; 
;  *  PMBegin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMBegin" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMEnd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMEnd" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; **********************
;   Valid only within a PMBeginPage/PMEndPage block. You should retrieve the printing 
;   port with this call and set it before imaging a page. 
; **********************
; 
;  *  PMGetGrafPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetGrafPtr" 
   ((printContext (:pointer :OpaquePMPrintContext))
    (grafPort (:pointer :GrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  PMPageFormat 
; 
;  *  PMNewPageFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMNewPageFormat" 
   ((pageFormat (:pointer :PMPAGEFORMAT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMDisposePageFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMDisposePageFormat" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMDefaultPageFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMDefaultPageFormat" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMValidatePageFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMValidatePageFormat" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (result (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  PMPrintSettings 
; 
;  *  PMNewPrintSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMNewPrintSettings" 
   ((printSettings (:pointer :PMPRINTSETTINGS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMDisposePrintSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMDisposePrintSettings" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMDefaultPrintSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMDefaultPrintSettings" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMValidatePrintSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMValidatePrintSettings" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (result (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Classic Support 
; 
;  *  PMGeneral()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGeneral" 
   ((pData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMConvertOldPrintRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMConvertOldPrintRecord" 
   ((printRecordHandle :Handle)
    (printSettings (:pointer :PMPRINTSETTINGS))
    (pageFormat (:pointer :PMPAGEFORMAT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMMakeOldPrintRecord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMMakeOldPrintRecord" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (pageFormat (:pointer :OpaquePMPageFormat))
    (printRecordHandle (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Driver Information 
; 
;  *  PMIsPostScriptDriver()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMIsPostScriptDriver" 
   ((isPostScript (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetLanguageInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetLanguageInfo" 
   ((info (:pointer :PMLanguageInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetDriverCreator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetDriverCreator" 
   ((creator (:pointer :OSType))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetDriverReleaseInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetDriverReleaseInfo" 
   ((release (:pointer :VersRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetPrinterResolutionCount()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetPrinterResolutionCount" 
   ((count (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetPrinterResolution()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetPrinterResolution" 
   ((tag :UInt32)
    (res (:pointer :PMResolution))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetIndexedPrinterResolution()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetIndexedPrinterResolution" 
   ((index :UInt32)
    (res (:pointer :PMResolution))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; **********************
;   PMEnableColorSync and PMDisableColorSync are valid within 
;   BeginPage/EndPage block 
; **********************
;  ColorSync & PostScript Support 
; 
;  *  PMEnableColorSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMEnableColorSync" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMDisableColorSync()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMDisableColorSync" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; **********************
;   The PMPostScriptxxx calls are valid within a 
;   BeginPage/EndPage block 
; **********************
; 
;  *  PMPostScriptBegin()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPostScriptBegin" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPostScriptEnd()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPostScriptEnd" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; **********************
;   These PMPostScriptxxx calls are valid within a 
;   PMPostScriptBegin/PMPostScriptEnd block 
; **********************
; 
;  *  PMPostScriptHandle()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPostScriptHandle" 
   ((psHandle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPostScriptData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPostScriptData" 
   ((psPtr :pointer)
    (len :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPostScriptFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPostScriptFile" 
   ((psFile (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Error 
; 
;  *  PMError()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMError" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetError()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetError" 
   ((printError :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
 |#

; #endif  /* PM_USE_SESSION_APIS */

;  PMPageFormat 
; 
;  *  PMCopyPageFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMCopyPageFormat" 
   ((formatSrc (:pointer :OpaquePMPageFormat))
    (formatDest (:pointer :OpaquePMPageFormat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; **********************
;   Flattening a page format should only be necessary if you intend to preserve 
;   the object settings along with a document. A page format will persist outside of a 
;   PMBegin/PMEnd block. This will allow you to use any accessors on the object without 
;   the need to flatten and unflatten. Keep in mind accessors make no assumption 
;   on the validity of the value you set. This can only be done thru PMValidatePageFormat 
;   in a PMBegin/PMEnd block or with PMSessionValidatePageFormat with a valid session. 
;   It is your responsibility for disposing of the handle. 
; **********************
; 
;  *  PMFlattenPageFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMFlattenPageFormat" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (flatFormat (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMUnflattenPageFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMUnflattenPageFormat" 
   ((flatFormat :Handle)
    (pageFormat (:pointer :PMPAGEFORMAT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  PMPageFormat Accessors 
; **********************
;  PMSetxxx calls only saves the value inside the printing object. They make no assumption on the 
;  validity of the value. This should be done using PMValidatePageFormat/PMSessionValidatePageFormat 
;  Any dependant settings are also updated during a validate call. 
;  For example: 
;  PMGetAdjustedPaperRect - returns a rect of a certain size 
;  PMSetScale( aPageFormat, 500.0 )  
;  PMGetAdjustedPaperRect - returns the SAME rect as the first call  
; 
;  PMGetAdjustedPaperRect - returns a rect of a certain size 
;  PMSetScale( aPageFormat, 500.0 ) 
;  PMValidatePageFormat or PMSessionValidatePageFormat 
;  PMGetAdjustedPaperRect - returns a rect thats scaled 500% from the first call 
; **********************
; 
;  *  PMGetPageFormatExtendedData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetPageFormatExtendedData" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (dataID :OSType)
    (size (:pointer :UInt32))
    (extendedData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetPageFormatExtendedData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetPageFormatExtendedData" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (dataID :OSType)
    (size :UInt32)
    (extendedData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; **********************
;   A value of 100.0 means 100% (no scaling). 50.0 means 50% scaling 
; **********************
; 
;  *  PMGetScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetScale" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (scale (:pointer :double))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetScale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetScale" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (scale :double-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; **********************
;   This is the drawing resolution of an app. This should not be confused with 
;   the resolution of the printer. You can call PMGetPrinterResolution to see 
;   what resolutions are avaliable for the current printer. 
; **********************
; 
;  *  PMGetResolution()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetResolution" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (res (:pointer :PMResolution))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetResolution()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetResolution" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (res (:pointer :PMResolution))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; **********************
;   This is the physical size of the paper without regard to resolution, orientation 
;   or scaling. It is returned as a 72dpi value. 
; **********************
; 
;  *  PMGetPhysicalPaperSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetPhysicalPaperSize" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (paperSize (:pointer :PMRect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetPhysicalPaperSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetPhysicalPaperSize" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (paperSize (:pointer :PMRect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; **********************
;   This is the physical size of the page without regard to resolution, orientation 
;   or scaling. It is returned as a 72dpi value. 
; **********************
; 
;  *  PMGetPhysicalPageSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetPhysicalPageSize" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (pageSize (:pointer :PMRect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetAdjustedPaperRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetAdjustedPaperRect" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (paperRect (:pointer :PMRect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetAdjustedPageRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetAdjustedPageRect" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (pageRect (:pointer :PMRect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetUnadjustedPaperRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetUnadjustedPaperRect" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (paperRect (:pointer :PMRect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetUnadjustedPaperRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetUnadjustedPaperRect" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (paperRect (:pointer :PMRect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetUnadjustedPageRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetUnadjustedPageRect" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (pageRect (:pointer :PMRect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetAdjustedPageRect()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetAdjustedPageRect" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (pageRect (:pointer :PMRect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetOrientation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetOrientation" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (orientation (:pointer :PMORIENTATION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetOrientation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetOrientation" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (orientation :UInt16)
    (lock :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  PMPrintSettings 
; 
;  *  PMCopyPrintSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMCopyPrintSettings" 
   ((settingSrc (:pointer :OpaquePMPrintSettings))
    (settingDest (:pointer :OpaquePMPrintSettings))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; **********************
;   Flattening a print settings should only be necessary if you intend to preserve 
;   the object settings along with a document. A print settings will persist outside of a 
;   PMBegin/PMEnd block. This allows you to use any accessors on the object without 
;   the need to flatten and unflatten. Keep in mind the accessors make no assumption 
;   on the validity of the value. This can only be done thru PMValidatePrintSettings 
;   in a PMBegin/PMEnd block or with PMSessionValidatePrintSettings with a valid session. 
;   It is your responsibility for disposing of the handle. 
; **********************
; 
;  *  PMFlattenPrintSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMFlattenPrintSettings" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (flatSettings (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMUnflattenPrintSettings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMUnflattenPrintSettings" 
   ((flatSettings :Handle)
    (printSettings (:pointer :PMPRINTSETTINGS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  PMPrintSettings Accessors 
; 
;  *  PMGetPrintSettingsExtendedData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetPrintSettingsExtendedData" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (dataID :OSType)
    (size (:pointer :UInt32))
    (extendedData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetPrintSettingsExtendedData()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetPrintSettingsExtendedData" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (dataID :OSType)
    (size :UInt32)
    (extendedData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetDestination()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetDestination" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (destType (:pointer :PMDESTINATIONTYPE))
    (fileURL (:pointer :CFURLRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetJobName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetJobName" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (name (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetJobName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetJobName" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (name (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetCopies()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetCopies" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (copies (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetCopies()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetCopies" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (copies :UInt32)
    (lock :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetFirstPage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetFirstPage" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (first (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetFirstPage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetFirstPage" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (first :UInt32)
    (lock :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetLastPage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetLastPage" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (last (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetLastPage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetLastPage" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (last :UInt32)
    (lock :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; **********************
;   The default page range is from 1-32000. The page range is something that is 
;   set by the application. It is NOT the first and last page to print. It serves 
;   as limits for setting the first and last page. You may pass kPMPrintAllPages for 
;   the maxPage value to specified that all pages are available for printing. 
; **********************
; 
;  *  PMGetPageRange()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetPageRange" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (minPage (:pointer :UInt32))
    (maxPage (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; **********************
;  The first and last page are immediately clipped to the new range 
; **********************
; 
;  *  PMSetPageRange()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetPageRange" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (minPage :UInt32)
    (maxPage :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetProfile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetProfile" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (tag :UInt32)
    (profile (:pointer :CMProfileLocation))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetColorMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetColorMode" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (colorMode (:pointer :PMCOLORMODE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetColorMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetColorMode" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (colorMode :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetJobNameCFString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetJobNameCFString" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (name (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetJobNameCFString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetJobNameCFString" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (name (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetCollate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetCollate" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (collate :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetCollate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetCollate" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (collate (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  PMServerCreatePrinterList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMServerCreatePrinterList" 
   ((server (:pointer :OpaquePMServer))
    (printerList (:pointer :CFArrayRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterGetName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetName" 
   ((printer (:pointer :OpaquePMPrinter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__CFString)
() )
; 
;  *  PMPrinterGetID()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetID" 
   ((printer (:pointer :OpaquePMPrinter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__CFString)
() )
; 
;  *  PMPrinterIsDefault()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterIsDefault" 
   ((printer (:pointer :OpaquePMPrinter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Boolean
() )
; 
;  *  PMPrinterGetLocation()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetLocation" 
   ((printer (:pointer :OpaquePMPrinter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__CFString)
() )
; 
;  *  PMPrinterGetState()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetState" 
   ((printer (:pointer :OpaquePMPrinter))
    (state (:pointer :PMPRINTERSTATE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterGetDeviceURI()
;  *  
;  *  Summary:
;  *    Hand back the URI of the printer's device.
;  *  
;  *  Discussion:
;  *    If defined on OS 9 this function returns kPMNotImplemented.
;  *  
;  *  Parameters:
;  *    
;  *    printer:
;  *      The printer whose device URI is to be retrieved.
;  *    
;  *    deviceURI:
;  *      On exit, if successful *'deviceURI' will contain a reference to
;  *      a CFURL describing the printer's device. The caller is
;  *      responsible for releasing this reference. If this call returns
;  *      an error, then *'deviceURI' will be set to NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetDeviceURI" 
   ((printer (:pointer :OpaquePMPrinter))
    (deviceURI (:pointer :CFURLRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterIsFavorite()
;  *  
;  *  Summary:
;  *    Return true if the printer is in the user's favorite printer list.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterIsFavorite" 
   ((printer (:pointer :OpaquePMPrinter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Boolean
() )
; 
;  *  PMPrinterCopyHostName()
;  *  
;  *  Summary:
;  *    Hand back the host name of the printer's server.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterCopyHostName" 
   ((printer (:pointer :OpaquePMPrinter))
    (hostNameP (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterIsRemote()
;  *  
;  *  Summary:
;  *    Hand back a boolean indicating whether the printer is hosted on a
;  *    remote print server.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterIsRemote" 
   ((printer (:pointer :OpaquePMPrinter))
    (isRemoteP (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMCGImageCreateWithEPSDataProvider()
;  *  
;  *  Summary:
;  *    Create an image reference that references both the PostScript
;  *    contents of an EPS file and a preview (proxy) image for that EPS
;  *    file.
;  *  
;  *  Discussion:
;  *    For OS X 10.1.0, this function ignores the passed in data
;  *    provider. The passed in image reference is retained and then
;  *    returned. For 10.1.1 and later, then the data provider is used
;  *    and the returned image reference is different than the passed in
;  *    image reference, so please be careful with your use of these
;  *    references. It is likely that the data will not be read from the
;  *    EPS data provider until well after this function returns. The
;  *    caller should be careful not to free the underlying EPS data
;  *    until the provider's release routine is invoked. Similarly the
;  *    preview image's data may be needed long after you think it should
;  *    be. Do not free the image data until the image data provider's
;  *    release data function has been called. To make sure these data
;  *    providers are properly reference counted, release your reference
;  *    the EPS data provider and on the EPS image preview when they are
;  *    no longer needed by your application. For Mac OS X 10.2 and
;  *    later, the contents of the EPS provider at the time of this call
;  *    can be dumped to a file if you first do the following, BEFORE
;  *    running your application. From the command line in terminal:
;  *    defaults write NSGlobalDomain com.apple.print.eps.testProvider
;  *    /tmp/dump.eps causes a dump of the EPS data into a file
;  *    /tmp/dump.eps.
;  *  
;  *  Parameters:
;  *    
;  *    epsDataProvider:
;  *      A Core Graphics data provider that can supply the PostScript
;  *      contents of the EPS file. Post OS X 10.1, there will be some
;  *      checking done on the EPS data provided to the
;  *      PMCGImageCreateWithEPSDataProvider() call. It is important that
;  *      the EPS data begin with the EPSF required header and bounding
;  *      box DSC comments.
;  *    
;  *    epsPreview:
;  *      A Core Graphics image reference to the proxy image for the EPS
;  *      file. When the image reference result of this function is
;  *      rendered on screen or printed to a printer that can not render
;  *      PostScript this proxy image is drawn instead.
;  *  
;  *  Result:
;  *    an image reference capable of rendering either the EPS content or
;  *    the proxy image depending upon the capabilities of the targeted
;  *    context.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMCGImageCreateWithEPSDataProvider" 
   ((epsDataProvider (:pointer :CGDataProvider))
    (epsPreview (:pointer :CGImage))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :CGImage)
() )
; 
;  *  PMPresetGetAttributes()
;  *  
;  *  Summary:
;  *    Hand back the meta-data describing a given preset.
;  *  
;  *  Discussion:
;  *    Each preset has associated with it a dictionary containing
;  *    meta-data. The meta-data provides the preset's id, the preset's
;  *    localized names, and descriptions of the environment for which
;  *    the preset it intended.
;  *  
;  *  Parameters:
;  *    
;  *    preset:
;  *      A print settings preset as obtained from PMPrinterCopyPresets().
;  *    
;  *    attributes:
;  *      On exit, *'attributes' is set to reference a dictionary
;  *      containing the preset's meta-data. The caller is responsible
;  *      for retaining this reference if it is to be used beyond the
;  *      lifetime of 'preset'. If this function fails, returning a
;  *      non-zero error code, then *'attributes' is set to NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPresetGetAttributes" 
   ((preset (:pointer :OpaquePMPreset))
    (attributes (:pointer :CFDictionaryRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterCopyPresets()
;  *  
;  *  Summary:
;  *    Provides a list of print settings presets for the specified
;  *    printer.
;  *  
;  *  Discussion:
;  *    A printer may have associated with it a list of preset settings.
;  *    Each setting is optimized for a particular printing situation.
;  *    This function returns all of the presets for a given printer. To
;  *    obtain more information about a particular preset see
;  *    PMPresetGetAttributes(). To apply a preset to some print
;  *    settings, use PMPresetApplyToPrintSettings().
;  *  
;  *  Parameters:
;  *    
;  *    printer:
;  *      Obtain the presets for this printer.
;  *    
;  *    presetList:
;  *      On exit, *'presetList' is set to reference an array of presets.
;  *      The caller must call CFRelease when it no longer needs the
;  *      array. Each element of the array is a PMPPreset. If this
;  *      function fails, returning a non-zero error code, then
;  *      *'presetList' will be set to NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterCopyPresets" 
   ((printer (:pointer :OpaquePMPrinter))
    (presetList (:pointer :CFArrayRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPresetCopyName()
;  *  
;  *  Summary:
;  *    Hand back a copy of the localized name for the specified preset.
;  *  
;  *  Parameters:
;  *    
;  *    preset:
;  *      The preset whose name is needed.
;  *    
;  *    name:
;  *      On exit, if this routine succeeds, *'name' is filled in with a
;  *      reference to a localized string with the preset's name. If this
;  *      routine fails, then *'name' is set to NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPresetCopyName" 
   ((preset (:pointer :OpaquePMPreset))
    (name (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPresetCreatePrintSettings()
;  *  
;  *  Summary:
;  *    Create a print settings conforming to the specified print
;  *    settings preset.
;  *  
;  *  Parameters:
;  *    
;  *    preset:
;  *      A preset specifying a set of initial print settings.
;  *    
;  *    session:
;  *      A valid print session.
;  *    
;  *    printSettings:
;  *      On exit, *'printSettings' is set to a newly created print
;  *      settings that contains the settings specified by 'preset'. The
;  *      caller is responsible for calling PMRelease when the print
;  *      settings are no longer needed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPresetCreatePrintSettings" 
   ((preset (:pointer :OpaquePMPreset))
    (session (:pointer :OpaquePMPrintSession))
    (printSettings (:pointer :PMPRINTSETTINGS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterGetCommInfo()
;  *  
;  *  Summary:
;  *    Provides information about the comm channel characteristics for
;  *    the printer.
;  *  
;  *  Discussion:
;  *    This function is typically relevant only to PostScript capable
;  *    printers. All PostScript printers, regardless of what
;  *    communications channel is used to send data to them, support data
;  *    in the range 0x20 - 0x7F. Many comm channels can support data
;  *    outside this range. The Boolean returned in *supportsTransparentP
;  *    indicates whether the comm channel to this printer supports bytes
;  *    in the range 0x0 to 0x1F. The Boolean returned in
;  *    *supportsEightBitP indicates whether the comm channel to this
;  *    printer supports bytes with the high bit set, i.e. bytes in the
;  *    range 0x80 - 0xFF.
;  *  
;  *  Parameters:
;  *    
;  *    printer:
;  *      Obtain the comm information for this printer.
;  *    
;  *    supportsTransparentP:
;  *      Storage for the returned Boolean indicating whether the comm
;  *      channel to this printer is transparent to bytes in the range
;  *      0x0 - 0x1F
;  *    
;  *    supportsEightBitP:
;  *      Storage for the returned Boolean indicating whether the comm
;  *      channel to this printer can bytes in the range 0x80 - 0xFF
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetCommInfo" 
   ((printer (:pointer :OpaquePMPrinter))
    (supportsTransparentP (:pointer :Boolean))
    (supportsEightBitP (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPaperCreate()
;  *  
;  *  Summary:
;  *    Create a new paper instance.
;  *  
;  *  Parameters:
;  *    
;  *    printer:
;  *      The new paper size is appropriate for this printer.
;  *    
;  *    id:
;  *      A unique identifier for this paper type.
;  *    
;  *    name:
;  *      The name to display to the user for this paper type.
;  *    
;  *    width:
;  *      The width, in points, of the paper.
;  *    
;  *    height:
;  *      The height, in points, of the paper.
;  *    
;  *    margins:
;  *      The unprintable margins on the paper.
;  *    
;  *    paperP:
;  *      if this function is successful, returning noErr, then *'paperP'
;  *      is set to be a reference to a newly created PMPaper instance.
;  *      The caller is responsible for calling PMRelease when the
;  *      instance is no longer needed. If this functions fails, it will
;  *      return a non-zero error and set *'paperP' to NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPaperCreate" 
   ((printer (:pointer :OpaquePMPrinter))
    (id (:pointer :__CFString))
    (name (:pointer :__CFString))
    (width :double-float)
    (height :double-float)
    (margins (:pointer :PMPAPERMARGINS))
    (paperP (:pointer :PMPAPER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMCreatePageFormatWithPMPaper()
;  *  
;  *  Summary:
;  *    Create a pageformat with a specific paper.
;  *  
;  *  Parameters:
;  *    
;  *    pageFormat:
;  *      On return, will contain the pageformat which was created
;  *    
;  *    paper:
;  *      The paper that will be associate with the pageformat
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMCreatePageFormatWithPMPaper" 
   ((pageFormat (:pointer :PMPAGEFORMAT))
    (paper (:pointer :OpaquePMPaper))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetPageFormatPaper()
;  *  
;  *  Summary:
;  *    Returns the paper associated with a pageformat.
;  *  
;  *  Parameters:
;  *    
;  *    format:
;  *      Obtain the paper for this pageformat.
;  *    
;  *    paper:
;  *      If successful noErr is returned and *paper will contain a
;  *      PMPaper object describing the current paper associated with the
;  *      pageformat.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetPageFormatPaper" 
   ((format (:pointer :OpaquePMPageFormat))
    (paper (:pointer :PMPAPER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterGetPaperList()
;  *  
;  *  Summary:
;  *    Returns the list of papers available for a given printer.
;  *  
;  *  Parameters:
;  *    
;  *    printer:
;  *      Obtain the paper list for this printer. Passing NULL will
;  *      return the paper list for the generic printer
;  *    
;  *    paperList:
;  *      If successful noErr is returned and *paperList is a CFArray of
;  *      PMPapers representing the list of papers available for the
;  *      printer.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetPaperList" 
   ((printer (:pointer :OpaquePMPrinter))
    (paperList (:pointer :CFArrayRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPaperGetID()
;  *  
;  *  Summary:
;  *    Returns the id for a given paper.
;  *  
;  *  Parameters:
;  *    
;  *    paper:
;  *      Obtain the id for this paper.
;  *    
;  *    paperID:
;  *      If successful noErr is returned and *paperID is set to the id
;  *      of the paper.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPaperGetID" 
   ((paper (:pointer :OpaquePMPaper))
    (paperID (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPaperGetName()
;  *  
;  *  Summary:
;  *    Returns the name for a given paper.
;  *  
;  *  Parameters:
;  *    
;  *    paper:
;  *      Obtain the name for this paper.
;  *    
;  *    paperName:
;  *      If successful noErr is returned and *paperName is set to the
;  *      name of the paper.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPaperGetName" 
   ((paper (:pointer :OpaquePMPaper))
    (paperName (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPaperGetHeight()
;  *  
;  *  Summary:
;  *    Returns the height for a given paper.
;  *  
;  *  Parameters:
;  *    
;  *    paper:
;  *      Obtain the height for this paper.
;  *    
;  *    paperHeight:
;  *      If successful noErr is returned and *paperHeight is set to the
;  *      height of the paper.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPaperGetHeight" 
   ((paper (:pointer :OpaquePMPaper))
    (paperHeight (:pointer :double))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPaperGetWidth()
;  *  
;  *  Summary:
;  *    Returns the width for a given paper.
;  *  
;  *  Parameters:
;  *    
;  *    paper:
;  *      Obtain the width for this paper.
;  *    
;  *    paperWidth:
;  *      If successful noErr is returned and *paperWidth is set to the
;  *      width of the paper.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPaperGetWidth" 
   ((paper (:pointer :OpaquePMPaper))
    (paperWidth (:pointer :double))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPaperGetMargins()
;  *  
;  *  Summary:
;  *    Returns the margins for a given paper.
;  *  
;  *  Parameters:
;  *    
;  *    paper:
;  *      Obtain the margin information for this paper.
;  *    
;  *    paperMargins:
;  *      If successful noErr is returned and *paperMargins is set to the
;  *      margins of the paper.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPaperGetMargins" 
   ((paper (:pointer :OpaquePMPaper))
    (paperMargins (:pointer :PMPAPERMARGINS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMWorkflowCopyItems()
;  *  
;  *  Summary:
;  *    Hand back an array of dictionaries describing the PDF Workflow
;  *    items installed on the system
;  *  
;  *  Parameters:
;  *    
;  *    workflowItems:
;  *      If this function returns without error then *'workflowItems'
;  *      will be filled in with a reference to an array. It is the
;  *      caller's responsability to release the array when done with it.
;  *      Each element in the array describes a PDF Workflow item or a
;  *      folder holding workflow items. A dictionary describing a
;  *      workflow item has, at least, the following keys and values:
;  *      displayName - The user's diaplayable name for the workflow item
;  *      itemURL - A CFURLRef pointing to the workflow item. A
;  *      dictionary describing a workflow folder has at least the
;  *      following keys: displayName - The user's diaplayable name for
;  *      the workflow item folderURL - A CFURLRef pointing to the
;  *      folder. items - A CFArrayRef describing the workflow items in
;  *      the folder. If this function returns a non-zero error code then
;  *      *'workflowItems' will be set to NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMWorkflowCopyItems" 
   ((workflowItems (:pointer :CFArrayRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterGetMimeTypes()
;  *  
;  *  Summary:
;  *    Return the array of mime type supported by the printer for a
;  *    given set of print settings.
;  *  
;  *  Parameters:
;  *    
;  *    printer:
;  *      The printer.
;  *    
;  *    settings:
;  *      The print settings for the print job. The part of the print
;  *      settings that effects the available mime type is the
;  *      destination. This parameter can be NULL.
;  *    
;  *    mimeTypes:
;  *      If this function returns without error then *'mimeTypes' is
;  *      filled in with a reference to an array of CFStrings. Each
;  *      CFString names a mime type supported by the printer with the
;  *      specified print settings. The caller must not release this
;  *      reference without first doing a retain. If this function
;  *      returns an error then 'mimeTypes' will be set to NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterGetMimeTypes" 
   ((printer (:pointer :OpaquePMPrinter))
    (settings (:pointer :OpaquePMPrintSettings))
    (mimeTypes (:pointer :CFArrayRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMWorkflowSubmitPDFWithSettings()
;  *  
;  *  Summary:
;  *    Submit a PDF file for workflow processing.
;  *  
;  *  Discussion:
;  *    The print dialog uses this function is conjunction with
;  *    PMWorkflowGetItems to implement the PDF workflow button. Caller's
;  *    can use PMWorkflowGetItems to obtain a CFURLRef that can be
;  *    passed to PMWorkflowPDF or they can create a CFURLRef to another
;  *    file system item.
;  *  
;  *  Parameters:
;  *    
;  *    workflowItem:
;  *      A file system URL pointing to the workflow item that will
;  *      handle the PDF file. Here are the different types of workflow
;  *      items currently supported: Folder alias:   The PDF is moved to
;  *      the resolved folder. Application or application alias: The
;  *      application is sent an open event along with a reference to the
;  *      PDF file. Compiled data fork AppleScript: The applescript is
;  *      run with an open event along with a reference to the PDF file.
;  *      executable tool: The tool is run with the following parameters:
;  *      title options pdfFile
;  *    
;  *    settings:
;  *      The prints settings to apply to the PDF.
;  *    
;  *    pdfFile:
;  *      A file system URL pointing to the file to be processed by the
;  *      workflow item.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMWorkflowSubmitPDFWithSettings" 
   ((workflowItem (:pointer :__CFURL))
    (settings (:pointer :OpaquePMPrintSettings))
    (pdfFile (:pointer :__CFURL))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMWorkflowSubmitPDFWithOptions()
;  *  
;  *  Summary:
;  *    Submit a PDF file for workflow processing.
;  *  
;  *  Discussion:
;  *    The print dialog uses this function is conjunction with
;  *    PMWorkflowGetItems to implement the PDF workflow button. Caller's
;  *    can use PMWorkflowGetItems to obtain a CFURLRef that can be
;  *    passed to PMWorkflowPDF or they can create a CFURLRef to another
;  *    file system item.
;  *  
;  *  Parameters:
;  *    
;  *    workflowItem:
;  *      A file system URL pointing to the workflow item that will
;  *      handle the PDF file. Here are the different types of workflow
;  *      items currently supported: Folder alias:   The PDF is moved to
;  *      the resolved folder. Application or application alias: The
;  *      application is sent an open event along with a reference to the
;  *      PDF file. Compiled data fork AppleScript: The applescript is
;  *      run with an open event along with a reference to the PDF file.
;  *      executable tool: The tool is run with the following parameters:
;  *      title options pdfFile
;  *    
;  *    title:
;  *      The user displayable name of the document.
;  *    
;  *    options:
;  *      A string of CUPS style key-value pairs that may be passed to
;  *      the PDF Workflow item. This parameter can be NULL in which case
;  *      an empty string of options is used.
;  *    
;  *    pdfFile:
;  *      A file system URL pointing to the file to be processed by the
;  *      workflow item.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMWorkflowSubmitPDFWithOptions" 
   ((workflowItem (:pointer :__CFURL))
    (title (:pointer :__CFString))
    (options (:pointer :char))
    (pdfFile (:pointer :__CFURL))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; ** Job Submission APIs **
; 
;  *  PMPrintSettingsToOptions()
;  *  
;  *  Summary:
;  *    Convert print settings to a CUPS style options string.
;  *  
;  *  Parameters:
;  *    
;  *    settings:
;  *      The print settings that should be converted to a CUPS style
;  *      options string.
;  *    
;  *    options:
;  *      On exit *'options' will be filled in with a malloc'd C string
;  *      describing the passed in print settings. It is the caller's
;  *      responsibility to free this memory when done with it. If this
;  *      function fails returning a non-zero error code then *'options'
;  *      will be set to NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrintSettingsToOptions" 
   ((settings (:pointer :OpaquePMPrintSettings))
    (options (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterPrintWithFile()
;  *  
;  *  Summary:
;  *    Submit a file for printing to a specified printer.
;  *  
;  *  Discussion:
;  *    One reason this function may fail is if the specified printer can
;  *    not handle the file's mime type. Use PMPrinterGetMimeTypes() to
;  *    check whether a mime type is supported. This function is
;  *    implemented using PMPrinterPrintWithProvider().
;  *  
;  *  Parameters:
;  *    
;  *    printer:
;  *      The printer.
;  *    
;  *    settings:
;  *      The print settings for the print job.
;  *    
;  *    format:
;  *      The physical page size and orientation on to which the document
;  *      should be printed. This parameter can be NULL.
;  *    
;  *    mimeType:
;  *      The mime type of the file to be printed. If this parameter is
;  *      NULL then the supplied file will be auto-typed.
;  *    
;  *    fileURL:
;  *      A file URL specifying the file to be printed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterPrintWithFile" 
   ((printer (:pointer :OpaquePMPrinter))
    (settings (:pointer :OpaquePMPrintSettings))
    (format (:pointer :OpaquePMPageFormat))
    (mimeType (:pointer :__CFString))
    (fileURL (:pointer :__CFURL))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrinterPrintWithProvider()
;  *  
;  *  Summary:
;  *    Submit a print data to a specified printer.
;  *  
;  *  Parameters:
;  *    
;  *    printer:
;  *      The printer.
;  *    
;  *    settings:
;  *      The print settings for the print job.
;  *    
;  *    format:
;  *      The physical page size and orientation on to which the document
;  *      should be printed. This parameter can be NULL.
;  *    
;  *    mimeType:
;  *      The mime type of the file to be printed. This parameter can not
;  *      be NULL. Use PMPrinterPrintWithFile() if aut-typing is desired.
;  *    
;  *    provider:
;  *      The data provider that supplies the print data.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrinterPrintWithProvider" 
   ((printer (:pointer :OpaquePMPrinter))
    (settings (:pointer :OpaquePMPrintSettings))
    (format (:pointer :OpaquePMPageFormat))
    (mimeType (:pointer :__CFString))
    (provider (:pointer :CGDataProvider))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMCopyAvailablePPDs()
;  *  
;  *  Summary:
;  *    Hand back the list of PPDs in the specified PPD domain.
;  *  
;  *  Parameters:
;  *    
;  *    domain:
;  *      The domain to search for PPDs.
;  *    
;  *    ppds:
;  *      If this function completes without error, *'ppds' is set to an
;  *      array of CFURLs. Each CFURL specifies the location of a PPD
;  *      file or a compressed PPD file. The caller is responsible for
;  *      releasing the array. If this function returns a non-zero error
;  *      code then *'ppds' is set to NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMCopyAvailablePPDs" 
   ((domain :UInt16)
    (ppds (:pointer :CFArrayRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMCopyLocalizedPPD()
;  *  
;  *  Summary:
;  *    Hand back a reference to a localized PPD.
;  *  
;  *  Parameters:
;  *    
;  *    ppd:
;  *      A PPD reference. Typically this is a CFURLRef returned from
;  *      PMCopyAvailablePPDs().
;  *    
;  *    localizedPPD:
;  *      If this function completes without error, *'localizedPPD' will
;  *      be set to a CFURLRef referencing the PPD that should be used
;  *      given the current user's language preferences. If this function
;  *      returns an error then *'localizedPPD' will be set to to NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMCopyLocalizedPPD" 
   ((ppd (:pointer :__CFURL))
    (localizedPPD (:pointer :CFURLRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  PMCopyPPDData()
;  *  
;  *  Summary:
;  *    Hand back the uncompressed PPD data for a PPD or compressed PPD
;  *    file.
;  *  
;  *  Parameters:
;  *    
;  *    ppd:
;  *      A reference to a PPD or compressed PPD file. This reference is
;  *      usually obtained from PMCopyAvailablePPDs() or from
;  *      PMCopyLocalizedPPD().
;  *    
;  *    data:
;  *      If this function completes without error then *'data' is set to
;  *      reference the uncompressed PPD data from the PPD file. If this
;  *      function returns a non-zero error then *'data is set to NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMCopyPPDData" 
   ((ppd (:pointer :__CFURL))
    (data (:pointer :CFDataRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __PMCORE__ */


(provide-interface "PMCore")