(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:TSMTE.h"
; at Sunday July 2,2006 7:25:05 pm.
; 
;      File:       HIToolbox/TSMTE.h
;  
;      Contains:   Text Services Managerfor TextEdit Interfaces.
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1991-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __TSMTE__
; #define __TSMTE__
; #ifndef __TEXTEDIT__
#| #|
#include <HIToolboxTextEdit.h>
#endif
|#
 |#
; #ifndef __DIALOGS__
#| #|
#include <HIToolboxDialogs.h>
#endif
|#
 |#
; #ifndef __TEXTSERVICES__
#| #|
#include <HIToolboxTextServices.h>
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
;  signature, interface types

(defconstant $kTSMTESignature :|tmTE|)
(defconstant $kTSMTEInterfaceType :|tmTE|)
; 
;     In Carbon, since DialogRef is opaque, the TSMDialogRecord is removed.
;     Only one kind of TSMTE dialog remains, with extended data managed by TSMTE.
;     Use kTSMTESignature for the dialog refCon, and use the accessors below,
;     i.e. GetTSMTEDialogTSMTERecHandle, to get at the old TSMDialogRecord info.
; 

; #if CALL_NOT_IN_CARBON
#| 
(defconstant $kTSMTEDialog :|tmDI|)
 |#

; #endif  /* CALL_NOT_IN_CARBON */

;  update flag for TSMTERec

(defconstant $kTSMTEAutoScroll 1)
;  callback procedure definitions

(def-mactype :TSMTEPreUpdateProcPtr (find-mactype ':pointer)); (TEHandle textH , long refCon)

(def-mactype :TSMTEPostUpdateProcPtr (find-mactype ':pointer)); (TEHandle textH , long fixLen , long inputAreaStart , long inputAreaEnd , long pinStart , long pinEnd , long refCon)

(def-mactype :TSMTEPreUpdateUPP (find-mactype '(:pointer :OpaqueTSMTEPreUpdateProcPtr)))

(def-mactype :TSMTEPostUpdateUPP (find-mactype '(:pointer :OpaqueTSMTEPostUpdateProcPtr)))
;  data types
(defrecord TSMTERec
   (textH :Handle)
   (preUpdateProc (:pointer :OpaqueTSMTEPreUpdateProcPtr))
   (postUpdateProc (:pointer :OpaqueTSMTEPostUpdateProcPtr))
   (updateFlag :signed-long)
   (refCon :signed-long)
)

;type name? (%define-record :TSMTERec (find-record-descriptor ':TSMTERec))

(def-mactype :TSMTERecPtr (find-mactype '(:pointer :TSMTERec)))

(def-mactype :TSMTERecHandle (find-mactype '(:handle :TSMTERec)))

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
(defrecord TSMDialogRecord
   (fDialog :DialogRecord)
   (fDocID (:pointer :OpaqueTSMDocumentID))
   (fTSMTERecH (:Handle :TSMTERec))
   (fTSMTERsvd (:array :signed-long 3))         ;  reserved
)

;type name? (def-mactype :TSMDialogRecord (find-mactype ':TSMDialogRecord))

(def-mactype :TSMDialogPtr (find-mactype '(:pointer :TSMDialogRecord)))

(def-mactype :TSMDialogPeek (find-mactype ':TSMDialogPtr))
 |#

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */

; 
;  *  NewTSMTEPreUpdateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewTSMTEPreUpdateUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTSMTEPreUpdateProcPtr)
() )
; 
;  *  NewTSMTEPostUpdateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewTSMTEPostUpdateUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTSMTEPostUpdateProcPtr)
() )
; 
;  *  DisposeTSMTEPreUpdateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeTSMTEPreUpdateUPP" 
   ((userUPP (:pointer :OpaqueTSMTEPreUpdateProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeTSMTEPostUpdateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeTSMTEPostUpdateUPP" 
   ((userUPP (:pointer :OpaqueTSMTEPostUpdateProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeTSMTEPreUpdateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeTSMTEPreUpdateUPP" 
   ((textH :Handle)
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueTSMTEPreUpdateProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeTSMTEPostUpdateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeTSMTEPostUpdateUPP" 
   ((textH :Handle)
    (fixLen :signed-long)
    (inputAreaStart :signed-long)
    (inputAreaEnd :signed-long)
    (pinStart :signed-long)
    (pinEnd :signed-long)
    (refCon :signed-long)
    (userUPP (:pointer :OpaqueTSMTEPostUpdateProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  IsTSMTEDialog()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
;  

(deftrap-inline "_IsTSMTEDialog" 
   ((dialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  Getters 
; 
;  *  GetTSMTEDialogDocumentID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
;  

(deftrap-inline "_GetTSMTEDialogDocumentID" 
   ((dialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTSMDocumentID)
() )
; 
;  *  GetTSMTEDialogTSMTERecHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
;  

(deftrap-inline "_GetTSMTEDialogTSMTERecHandle" 
   ((dialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :TSMTERec)
() )
;  Setters 
; 
;  *  SetTSMTEDialogDocumentID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
;  

(deftrap-inline "_SetTSMTEDialogDocumentID" 
   ((dialog (:pointer :OpaqueDialogPtr))
    (documentID (:pointer :OpaqueTSMDocumentID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetTSMTEDialogTSMTERecHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
;  

(deftrap-inline "_SetTSMTEDialogTSMTERecHandle" 
   ((dialog (:pointer :OpaqueDialogPtr))
    (tsmteRecHandle (:Handle :TSMTERec))
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

; #endif /* __TSMTE__ */


(provide-interface "TSMTE")