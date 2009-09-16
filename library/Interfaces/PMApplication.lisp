(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PMApplication.h"
; at Sunday July 2,2006 7:25:12 pm.
; 
;      File:       Print/PMApplication.h
;  
;      Contains:   Carbon Printing Manager Interfaces.
;  
;      Version:    Printing-158~1
;  
;      Copyright:  © 1998-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __PMAPPLICATION__
; #define __PMAPPLICATION__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __DIALOGS__
#| #|
#include <HIToolboxDialogs.h>
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
;  Callbacks 

(def-mactype :PMItemProcPtr (find-mactype ':pointer)); (DialogRef theDialog , short item)

(def-mactype :PMPrintDialogInitProcPtr (find-mactype ':pointer)); (PMPrintSettings printSettings , PMDialog * theDialog)

(def-mactype :PMPageSetupDialogInitProcPtr (find-mactype ':pointer)); (PMPageFormat pageFormat , PMDialog * theDialog)

(def-mactype :PMSheetDoneProcPtr (find-mactype ':pointer)); (PMPrintSession printSession , WindowRef documentWindow , Boolean accepted)

(def-mactype :PMItemUPP (find-mactype '(:pointer :OpaquePMItemProcPtr)))

(def-mactype :PMPrintDialogInitUPP (find-mactype '(:pointer :OpaquePMPrintDialogInitProcPtr)))

(def-mactype :PMPageSetupDialogInitUPP (find-mactype '(:pointer :OpaquePMPageSetupDialogInitProcPtr)))

(def-mactype :PMSheetDoneUPP (find-mactype '(:pointer :OpaquePMSheetDoneProcPtr)))
; 
;  *  NewPMItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewPMItemUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaquePMItemProcPtr)
() )
; 
;  *  NewPMPrintDialogInitUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewPMPrintDialogInitUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaquePMPrintDialogInitProcPtr)
() )
; 
;  *  NewPMPageSetupDialogInitUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewPMPageSetupDialogInitUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaquePMPageSetupDialogInitProcPtr)
() )
; 
;  *  NewPMSheetDoneUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewPMSheetDoneUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaquePMSheetDoneProcPtr)
() )
; 
;  *  DisposePMItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposePMItemUPP" 
   ((userUPP (:pointer :OpaquePMItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposePMPrintDialogInitUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposePMPrintDialogInitUPP" 
   ((userUPP (:pointer :OpaquePMPrintDialogInitProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposePMPageSetupDialogInitUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposePMPageSetupDialogInitUPP" 
   ((userUPP (:pointer :OpaquePMPageSetupDialogInitProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposePMSheetDoneUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposePMSheetDoneUPP" 
   ((userUPP (:pointer :OpaquePMSheetDoneProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokePMItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokePMItemUPP" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (item :SInt16)
    (userUPP (:pointer :OpaquePMItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokePMPrintDialogInitUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokePMPrintDialogInitUPP" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (theDialog (:pointer :PMDIALOG))
    (userUPP (:pointer :OpaquePMPrintDialogInitProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokePMPageSetupDialogInitUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokePMPageSetupDialogInitUPP" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (theDialog (:pointer :PMDIALOG))
    (userUPP (:pointer :OpaquePMPageSetupDialogInitProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokePMSheetDoneUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokePMSheetDoneUPP" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (documentWindow (:pointer :OpaqueWindowPtr))
    (accepted :Boolean)
    (userUPP (:pointer :OpaquePMSheetDoneProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

; #if PM_USE_SESSION_APIS
;  Print loop 
; 
;  *  PMSessionBeginDocument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionBeginDocument" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printSettings (:pointer :OpaquePMPrintSettings))
    (pageFormat (:pointer :OpaquePMPageFormat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionEndDocument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionEndDocument" 
   ((printSession (:pointer :OpaquePMPrintSession))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionBeginPage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionBeginPage" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (pageFormat (:pointer :OpaquePMPageFormat))
    (pageFrame (:pointer :PMRect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionEndPage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionEndPage" 
   ((printSession (:pointer :OpaquePMPrintSession))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Session Printing Dialogs 
; 
;  *  PMSessionPageSetupDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionPageSetupDialog" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (pageFormat (:pointer :OpaquePMPageFormat))
    (accepted (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionPrintDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionPrintDialog" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printSettings (:pointer :OpaquePMPrintSettings))
    (constPageFormat (:pointer :OpaquePMPageFormat))
    (accepted (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionPageSetupDialogInit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionPageSetupDialogInit" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (pageFormat (:pointer :OpaquePMPageFormat))
    (newDialog (:pointer :PMDIALOG))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionPrintDialogInit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionPrintDialogInit" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printSettings (:pointer :OpaquePMPrintSettings))
    (constPageFormat (:pointer :OpaquePMPageFormat))
    (newDialog (:pointer :PMDIALOG))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionPrintDialogMain()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionPrintDialogMain" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (printSettings (:pointer :OpaquePMPrintSettings))
    (constPageFormat (:pointer :OpaquePMPageFormat))
    (accepted (:pointer :Boolean))
    (myInitProc (:pointer :OpaquePMPrintDialogInitProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionPageSetupDialogMain()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionPageSetupDialogMain" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (pageFormat (:pointer :OpaquePMPageFormat))
    (accepted (:pointer :Boolean))
    (myInitProc (:pointer :OpaquePMPageSetupDialogInitProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; **********************
;   Sheets are not available on classic. 
; **********************
; 
;  *  PMSessionUseSheets()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionUseSheets" 
   ((printSession (:pointer :OpaquePMPrintSession))
    (documentWindow (:pointer :OpaqueWindowPtr))
    (sheetDoneProc (:pointer :OpaquePMSheetDoneProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
#| 
; #else
;  Print loop 
; 
;  *  PMBeginDocument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMBeginDocument" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (pageFormat (:pointer :OpaquePMPageFormat))
    (printContext (:pointer :PMPRINTCONTEXT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMEndDocument()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMEndDocument" 
   ((printContext (:pointer :OpaquePMPrintContext))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMBeginPage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMBeginPage" 
   ((printContext (:pointer :OpaquePMPrintContext))
    (pageFrame (:pointer :PMRect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMEndPage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMEndPage" 
   ((printContext (:pointer :OpaquePMPrintContext))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Printing Dialogs 
; 
;  *  PMPageSetupDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPageSetupDialog" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (accepted (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrintDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrintDialog" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (constPageFormat (:pointer :OpaquePMPageFormat))
    (accepted (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPageSetupDialogInit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPageSetupDialogInit" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (newDialog (:pointer :PMDIALOG))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; **********************
;   PMPrintDialogInit is not recommended. You should instead use 
;   PMPrintDialogInitWithPageFormat or PMSessionPrintDialogInit 
; **********************
; 
;  *  PMPrintDialogInit()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrintDialogInit" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (newDialog (:pointer :PMDIALOG))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrintDialogInitWithPageFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrintDialogInitWithPageFormat" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (constPageFormat (:pointer :OpaquePMPageFormat))
    (newDialog (:pointer :PMDIALOG))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPrintDialogMain()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPrintDialogMain" 
   ((printSettings (:pointer :OpaquePMPrintSettings))
    (constPageFormat (:pointer :OpaquePMPageFormat))
    (accepted (:pointer :Boolean))
    (myInitProc (:pointer :OpaquePMPrintDialogInitProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMPageSetupDialogMain()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMPageSetupDialogMain" 
   ((pageFormat (:pointer :OpaquePMPageFormat))
    (accepted (:pointer :Boolean))
    (myInitProc (:pointer :OpaquePMPageSetupDialogInitProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
 |#

; #endif  /* PM_USE_SESSION_APIS */

;  Printing Dialog accessors 
; 
;  *  PMGetDialogPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetDialogPtr" 
   ((pmDialog (:pointer :OpaquePMDialog))
    (theDialog (:pointer :DIALOGREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; #define PMGetDialogRef PMGetDialogPtr
; 
;  *  PMGetModalFilterProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetModalFilterProc" 
   ((pmDialog (:pointer :OpaquePMDialog))
    (filterProc (:pointer :MODALFILTERUPP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetModalFilterProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetModalFilterProc" 
   ((pmDialog (:pointer :OpaquePMDialog))
    (filterProc (:pointer :OpaqueModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetItemProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetItemProc" 
   ((pmDialog (:pointer :OpaquePMDialog))
    (itemProc (:pointer :PMITEMUPP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetItemProc()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetItemProc" 
   ((pmDialog (:pointer :OpaquePMDialog))
    (itemProc (:pointer :OpaquePMItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetDialogAccepted()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetDialogAccepted" 
   ((pmDialog (:pointer :OpaquePMDialog))
    (process (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetDialogAccepted()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetDialogAccepted" 
   ((pmDialog (:pointer :OpaquePMDialog))
    (process :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMGetDialogDone()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMGetDialogDone" 
   ((pmDialog (:pointer :OpaquePMDialog))
    (done (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  PMSetDialogDone()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSetDialogDone" 
   ((pmDialog (:pointer :OpaquePMDialog))
    (done :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Presets 
; 
;  *  PMSessionEnablePrinterPresets()
;  *  
;  *  Summary:
;  *    Enable the use of printer presets in the print dialog.
;  *  
;  *  Discussion:
;  *    Displaying the print dialog on a session after making this call
;  *    will show the presets available for the specified graphis type.
;  *    In addition this call will enable the use of the simplified print
;  *    dialog. On OS 9 this function returns kPMNotImplemented.
;  *  
;  *  Parameters:
;  *    
;  *    session:
;  *      The session that will be used to present the print dialog.
;  *    
;  *    graphicsType:
;  *      The printer presets in the dialog should be suitable for
;  *      rendering this type of graphic. Currently defined graphics
;  *      types are: "Photo"
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionEnablePrinterPresets" 
   ((session (:pointer :OpaquePMPrintSession))
    (graphicsType (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  PMSessionDisablePrinterPresets()
;  *  
;  *  Summary:
;  *    Disable the use of printer presets in the print dialog.
;  *  
;  *  Discussion:
;  *    On OS 9 this function returns noErr since presets are never used
;  *    in that OS.
;  *  
;  *  Parameters:
;  *    
;  *    session:
;  *      The session that will be used to present the print dialog.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_PMSessionDisablePrinterPresets" 
   ((session (:pointer :OpaquePMPrintSession))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __PMAPPLICATION__ */


(provide-interface "PMApplication")