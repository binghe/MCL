(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Dialogs.h"
; at Sunday July 2,2006 7:24:59 pm.
; 
;      File:       HIToolbox/Dialogs.h
;  
;      Contains:   Dialog Manager interfaces.
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __DIALOGS__
; #define __DIALOGS__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __EVENTS__
#| #|
#include <HIToolboxEvents.h>
#endif
|#
 |#
; #ifndef __MACWINDOWS__
#| #|
#include <HIToolboxMacWindows.h>
#endif
|#
 |#
; #ifndef __TEXTEDIT__
#| #|
#include <HIToolboxTextEdit.h>
#endif
|#
 |#
; #ifndef __CONTROLS__
#| #|
#include <HIToolboxControls.h>
#endif
|#
 |#
; #ifndef __CARBONEVENTS__
#| #|
#include <HIToolboxCarbonEvents.h>
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
;  new, more standard names for dialog item types

(defconstant $kControlDialogItem 4)
(defconstant $kButtonDialogItem 4)
(defconstant $kCheckBoxDialogItem 5)
(defconstant $kRadioButtonDialogItem 6)
(defconstant $kResourceControlDialogItem 7)
(defconstant $kStaticTextDialogItem 8)
(defconstant $kEditTextDialogItem 16)
(defconstant $kIconDialogItem 32)
(defconstant $kPictureDialogItem 64)
(defconstant $kUserDialogItem 0)
(defconstant $kHelpDialogItem 1)
(defconstant $kItemDisableBit #x80)
;  old names for dialog item types

(defconstant $ctrlItem 4)
(defconstant $btnCtrl 0)
(defconstant $chkCtrl 1)
(defconstant $radCtrl 2)
(defconstant $resCtrl 3)
(defconstant $statText 8)
(defconstant $editText 16)
(defconstant $iconItem 32)
(defconstant $picItem 64)
(defconstant $userItem 0)
(defconstant $itemDisable #x80)
;  standard dialog item numbers

(defconstant $kStdOkItemIndex 1)
(defconstant $kStdCancelItemIndex 2)            ;  old names

(defconstant $ok 1)
(defconstant $cancel 2)
;  standard icon resource id's    

(defconstant $kStopIcon 0)
(defconstant $kNoteIcon 1)
(defconstant $kCautionIcon 2)                   ;  old names

(defconstant $stopIcon 0)
(defconstant $noteIcon 1)
(defconstant $cautionIcon 2)

; #if OLDROUTINENAMES
#| 
; 
;    These constants lived briefly on ETO 16.  They suggest
;    that there is only one index you can use for the OK 
;    item, which is not true.  You can put the ok item 
;    anywhere you want in the DITL.
; 

(defconstant $kOkItemIndex 1)
(defconstant $kCancelItemIndex 2)
 |#

; #endif  /* OLDROUTINENAMES */

;   Dialog Item List Manipulation Constants 

(def-mactype :DITLMethod (find-mactype ':SInt16))

(defconstant $overlayDITL 0)
(defconstant $appendDITLRight 1)
(defconstant $appendDITLBottom 2)

(def-mactype :StageList (find-mactype ':SInt16))
;  DialogPtr is obsolete. Use DialogRef instead.

(def-mactype :DialogRef (find-mactype ':DialogPtr))

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
(defrecord DialogRecord
   (window :WindowRecord)                       ;  in Carbon use GetDialogWindow or GetDialogPort
   (items :Handle)                              ;  in Carbon use Get/SetDialogItem
   (textH :Handle)                              ;  in Carbon use GetDialogTextEditHandle
   (editField :SInt16)                          ;  in Carbon use SelectDialogItemText/GetDialogKeyboardFocusItem
   (editOpen :SInt16)                           ;  not available in Carbon 
   (aDefItem :SInt16)                           ;  in Carbon use Get/SetDialogDefaultItem
)

;type name? (def-mactype :DialogRecord (find-mactype ':DialogRecord))

(def-mactype :DialogPeek (find-mactype '(:pointer :DialogRecord)))
 |#

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */

(defrecord (DialogTemplate :handle)
   (boundsRect :Rect)
   (procID :SInt16)
   (visible :Boolean)
   (filler1 :Boolean)
   (goAwayFlag :Boolean)
   (filler2 :Boolean)
   (refCon :SInt32)
   (itemsID :SInt16)
   (title (:string 255))
)

;type name? (%define-record :DialogTemplate (find-record-descriptor ':DialogTemplate))

(def-mactype :DialogTPtr (find-mactype '(:pointer :DialogTemplate)))

(def-mactype :DialogTHndl (find-mactype '(:handle :DialogTemplate)))
(defrecord (AlertTemplate :handle)
   (boundsRect :Rect)
   (itemsID :SInt16)
   (stages :SInt16)
)

;type name? (%define-record :AlertTemplate (find-record-descriptor ':AlertTemplate))

(def-mactype :AlertTPtr (find-mactype '(:pointer :AlertTemplate)))

(def-mactype :AlertTHndl (find-mactype '(:handle :AlertTemplate)))
;  new type abstractions for the dialog manager 

(def-mactype :DialogItemIndexZeroBased (find-mactype ':SInt16))

(def-mactype :DialogItemIndex (find-mactype ':SInt16))

(def-mactype :DialogItemType (find-mactype ':SInt16))
;  dialog manager callbacks 

(def-mactype :SoundProcPtr (find-mactype ':pointer)); (SInt16 soundNumber)

(def-mactype :ModalFilterProcPtr (find-mactype ':pointer)); (DialogRef theDialog , EventRecord * theEvent , DialogItemIndex * itemHit)
;  ModalFilterYDProcPtr was previously in StandardFile.h 

(def-mactype :ModalFilterYDProcPtr (find-mactype ':pointer)); (DialogRef theDialog , EventRecord * theEvent , short * itemHit , void * yourDataPtr)

(def-mactype :UserItemProcPtr (find-mactype ':pointer)); (DialogRef theDialog , DialogItemIndex itemNo)

(def-mactype :SoundUPP (find-mactype '(:pointer :OpaqueSoundProcPtr)))

(def-mactype :ModalFilterUPP (find-mactype '(:pointer :OpaqueModalFilterProcPtr)))

(def-mactype :ModalFilterYDUPP (find-mactype '(:pointer :OpaqueModalFilterYDProcPtr)))

(def-mactype :UserItemUPP (find-mactype '(:pointer :OpaqueUserItemProcPtr)))
; 
;  *  NewSoundUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  NewModalFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewModalFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueModalFilterProcPtr)
() )
; 
;  *  NewModalFilterYDUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewModalFilterYDUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueModalFilterYDProcPtr)
() )
; 
;  *  NewUserItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewUserItemUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueUserItemProcPtr)
() )
; 
;  *  DisposeSoundUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposeModalFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeModalFilterUPP" 
   ((userUPP (:pointer :OpaqueModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeModalFilterYDUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeModalFilterYDUPP" 
   ((userUPP (:pointer :OpaqueModalFilterYDProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeUserItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeUserItemUPP" 
   ((userUPP (:pointer :OpaqueUserItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeSoundUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokeModalFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeModalFilterUPP" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (theEvent (:pointer :EventRecord))
    (itemHit (:pointer :DIALOGITEMINDEX))
    (userUPP (:pointer :OpaqueModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeModalFilterYDUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeModalFilterYDUPP" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (theEvent (:pointer :EventRecord))
    (itemHit (:pointer :short))
    (yourDataPtr :pointer)
    (userUPP (:pointer :OpaqueModalFilterYDProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeUserItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeUserItemUPP" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (itemNo :SInt16)
    (userUPP (:pointer :OpaqueUserItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     ¥ Following types are valid with Appearance 1.0 and later
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  Alert types to pass into StandardAlert 

(defconstant $kAlertStopAlert 0)
(defconstant $kAlertNoteAlert 1)
(defconstant $kAlertCautionAlert 2)
(defconstant $kAlertPlainAlert 3)

(def-mactype :AlertType (find-mactype ':SInt16))

(defconstant $kAlertDefaultOKText -1)           ;  "OK"

(defconstant $kAlertDefaultCancelText -1)       ;  "Cancel"
;  "Don't Save"

(defconstant $kAlertDefaultOtherText -1)
;  StandardAlert alert button numbers 

(defconstant $kAlertStdAlertOKButton 1)
(defconstant $kAlertStdAlertCancelButton 2)
(defconstant $kAlertStdAlertOtherButton 3)
(defconstant $kAlertStdAlertHelpButton 4)
;  Dialog Flags for use in NewFeaturesDialog or dlgx resource 

(defconstant $kDialogFlagsUseThemeBackground 1)
(defconstant $kDialogFlagsUseControlHierarchy 2)
(defconstant $kDialogFlagsHandleMovableModal 4)
(defconstant $kDialogFlagsUseThemeControls 8)
;  Alert Flags for use in alrx resource 

(defconstant $kAlertFlagsUseThemeBackground 1)
(defconstant $kAlertFlagsUseControlHierarchy 2)
(defconstant $kAlertFlagsAlertIsMovable 4)
(defconstant $kAlertFlagsUseThemeControls 8)
;  For dftb resource 

(defconstant $kDialogFontNoFontStyle 0)
(defconstant $kDialogFontUseFontMask 1)
(defconstant $kDialogFontUseFaceMask 2)
(defconstant $kDialogFontUseSizeMask 4)
(defconstant $kDialogFontUseForeColorMask 8)
(defconstant $kDialogFontUseBackColorMask 16)
(defconstant $kDialogFontUseModeMask 32)
(defconstant $kDialogFontUseJustMask 64)
(defconstant $kDialogFontUseAllMask #xFF)
(defconstant $kDialogFontAddFontSizeMask #x100)
(defconstant $kDialogFontUseFontNameMask #x200)
(defconstant $kDialogFontAddToMetaFontMask #x400)
;  Also for dftb resource. This one is available in Mac OS X or later. 
;  It corresponds directly to kControlUseThemeFontIDMask from Controls.h. 

(defconstant $kDialogFontUseThemeFontIDMask #x80)
(defrecord AlertStdAlertParamRec
   (movable :Boolean)                           ;  Make alert movable modal 
   (helpButton :Boolean)                        ;  Is there a help button? 
   (filterProc (:pointer :OpaqueModalFilterProcPtr));  Event filter 
   (defaultText (:pointer :UInt8))              ;  Text for button in OK position 
   (cancelText (:pointer :UInt8))               ;  Text for button in cancel position 
   (otherText (:pointer :UInt8))                ;  Text for button in left position 
   (defaultButton :SInt16)                      ;  Which button behaves as the default 
   (cancelButton :SInt16)                       ;  Which one behaves as cancel (can be 0) 
   (position :UInt16)                           ;  Position (kWindowDefaultPosition in this case 
                                                ;  equals kWindowAlertPositionParentWindowScreen) 
)

;type name? (%define-record :AlertStdAlertParamRec (find-record-descriptor ':AlertStdAlertParamRec))

(def-mactype :AlertStdAlertParamPtr (find-mactype '(:pointer :AlertStdAlertParamRec)))

(defconstant $kHICommandOther :|othr|)          ;  sent by standard sheet dialogs when the "other" button is pressed 


(defconstant $kStdCFStringAlertVersionOne 1)    ;  current version of AlertStdCFStringAlertParamRec 

; 
;  *  Summary:
;  *    Flags to CreateStandardAlert that are specified in the
;  *    AlertStdCFStringAlertParamRec.flags field.
;  
; 
;    * Applies to StandardSheet only. Do not dispose of the sheet window
;    * after closing it; allows the sheet to be re-used again in a later
;    * call to ShowSheetWindow.
;    

(defconstant $kStdAlertDoNotDisposeSheet 1)
; 
;    * Applies to StandardSheet only. Causes the sheet window to be
;    * hidden immediately without animation effects when the default
;    * button is chosen by the user.
;    

(defconstant $kStdAlertDoNotAnimateOnDefault 2)
; 
;    * Applies to StandardSheet only. Causes the sheet window to be
;    * hidden immediately without animation effects when the cancel
;    * button is chosen by the user.
;    

(defconstant $kStdAlertDoNotAnimateOnCancel 4)
; 
;    * Applies to StandardSheet only. Causes the sheet window to be
;    * hidden immediately without animation effects when the other button
;    * is chosen by the user.
;    

(defconstant $kStdAlertDoNotAnimateOnOther 8)
(defrecord AlertStdCFStringAlertParamRec
   (version :UInt32)                            ;  kStdCFStringAlertVersionOne 
   (movable :Boolean)                           ;  Make alert movable modal 
   (helpButton :Boolean)                        ;  Is there a help button? 
   (defaultText (:pointer :__CFString))         ;  Text for button in OK position 
   (cancelText (:pointer :__CFString))          ;  Text for button in cancel position 
   (otherText (:pointer :__CFString))           ;  Text for button in left position 
   (defaultButton :SInt16)                      ;  Which button behaves as the default 
   (cancelButton :SInt16)                       ;  Which one behaves as cancel (can be 0) 
   (position :UInt16)                           ;  Position (kWindowDefaultPosition in this case 
                                                ;  equals kWindowAlertPositionParentWindowScreen) 
   (flags :UInt32)                              ;  Options for the behavior of the alert or sheet 
)

;type name? (%define-record :AlertStdCFStringAlertParamRec (find-record-descriptor ':AlertStdCFStringAlertParamRec))

(def-mactype :AlertStdCFStringAlertParamPtr (find-mactype '(:pointer :AlertStdCFStringAlertParamRec)))
;  ÑÑÑ end Appearance 1.0 or later stuff
; 
;     NOTE: Code running under MultiFinder or System 7.0 or newer
;     should always pass NULL to InitDialogs.
; 
; 
;  *  InitDialogs()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  ErrorSound()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  NewDialog()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewDialog" 
   ((dStorage :pointer)
    (boundsRect (:pointer :Rect))
    (title (:pointer :STR255))
    (visible :Boolean)
    (procID :SInt16)
    (behind (:pointer :OpaqueWindowPtr))
    (goAwayFlag :Boolean)
    (refCon :SInt32)
    (items :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDialogPtr)
() )
; 
;  *  GetNewDialog()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetNewDialog" 
   ((dialogID :SInt16)
    (dStorage :pointer)
    (behind (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDialogPtr)
() )
; 
;  *  NewColorDialog()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewColorDialog" 
   ((dStorage :pointer)
    (boundsRect (:pointer :Rect))
    (title (:pointer :STR255))
    (visible :Boolean)
    (procID :SInt16)
    (behind (:pointer :OpaqueWindowPtr))
    (goAwayFlag :Boolean)
    (refCon :SInt32)
    (items :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDialogPtr)
() )
; 
;  *  CloseDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  DisposeDialog()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposeDialog" 
   ((theDialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ModalDialog()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ModalDialog" 
   ((modalFilter (:pointer :OpaqueModalFilterProcPtr))
    (itemHit (:pointer :DIALOGITEMINDEX))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  IsDialogEvent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_IsDialogEvent" 
   ((theEvent (:pointer :EventRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  DialogSelect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DialogSelect" 
   ((theEvent (:pointer :EventRecord))
    (theDialog (:pointer :DIALOGREF))
    (itemHit (:pointer :DIALOGITEMINDEX))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  DrawDialog()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DrawDialog" 
   ((theDialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  UpdateDialog()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_UpdateDialog" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (updateRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HideDialogItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HideDialogItem" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (itemNo :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ShowDialogItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ShowDialogItem" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (itemNo :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FindDialogItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FindDialogItem" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (thePt :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  DialogCut()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DialogCut" 
   ((theDialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DialogPaste()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DialogPaste" 
   ((theDialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DialogCopy()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DialogCopy" 
   ((theDialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DialogDelete()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DialogDelete" 
   ((theDialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  Alert()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Alert" 
   ((alertID :SInt16)
    (modalFilter (:pointer :OpaqueModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  StopAlert()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StopAlert" 
   ((alertID :SInt16)
    (modalFilter (:pointer :OpaqueModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  NoteAlert()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NoteAlert" 
   ((alertID :SInt16)
    (modalFilter (:pointer :OpaqueModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  CautionAlert()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CautionAlert" 
   ((alertID :SInt16)
    (modalFilter (:pointer :OpaqueModalFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetDialogItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetDialogItem" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (itemNo :SInt16)
    (itemType (:pointer :DIALOGITEMTYPE))
    (item (:pointer :Handle))
    (box (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetDialogItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetDialogItem" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (itemNo :SInt16)
    (itemType :SInt16)
    (item :Handle)
    (box (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ParamText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ParamText" 
   ((param0 (:pointer :STR255))
    (param1 (:pointer :STR255))
    (param2 (:pointer :STR255))
    (param3 (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SelectDialogItemText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SelectDialogItemText" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (itemNo :SInt16)
    (strtSel :SInt16)
    (endSel :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetDialogItemText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetDialogItemText" 
   ((item :Handle)
    (text (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetDialogItemText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetDialogItemText" 
   ((item :Handle)
    (text (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetAlertStage()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetAlertStage" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetDialogFont()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetDialogFont" 
   ((fontNum :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ResetAlertStage()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ResetAlertStage" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  APIs in Carbon
; 
;  *  GetParamText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetParamText" 
   ((param0 (:pointer :UInt8))
    (param1 (:pointer :UInt8))
    (param2 (:pointer :UInt8))
    (param3 (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  newdialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  newcolordialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  paramtext()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  getdialogitemtext()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  setdialogitemtext()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  finddialogitem()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  AppendDITL()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AppendDITL" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (theHandle :Handle)
    (method :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CountDITL()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CountDITL" 
   ((theDialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  ShortenDITL()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ShortenDITL" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (numberItems :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InsertDialogItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InsertDialogItem" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (afterItem :SInt16)
    (itemType :SInt16)
    (itemHandle :Handle)
    (box (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RemoveDialogItems()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RemoveDialogItems" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (itemNo :SInt16)
    (amountToRemove :SInt16)
    (disposeItemData :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  StdFilterProc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StdFilterProc" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (event (:pointer :EventRecord))
    (itemHit (:pointer :DIALOGITEMINDEX))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  GetStdFilterProc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetStdFilterProc" 
   ((theProc (:pointer :MODALFILTERUPP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDialogDefaultItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetDialogDefaultItem" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (newItem :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDialogCancelItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetDialogCancelItem" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (newItem :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetDialogTracksCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetDialogTracksCursor" 
   ((theDialog (:pointer :OpaqueDialogPtr))
    (tracks :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     ¥ Appearance Dialog Routines (available only with Appearance 1.0 and later)
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  NewFeaturesDialog()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_NewFeaturesDialog" 
   ((inStorage :pointer)
    (inBoundsRect (:pointer :Rect))
    (inTitle (:pointer :STR255))
    (inIsVisible :Boolean)
    (inProcID :SInt16)
    (inBehind (:pointer :OpaqueWindowPtr))
    (inGoAwayFlag :Boolean)
    (inRefCon :SInt32)
    (inItemListHandle :Handle)
    (inFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDialogPtr)
() )
; 
;  *  AutoSizeDialog()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_AutoSizeDialog" 
   ((inDialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;     Regarding StandardAlert and constness:
;     Even though the inAlertParam parameter is marked const here, there was
;     a chance Dialog Manager would modify it on versions of Mac OS prior to 9.
; 
; 
;  *  StandardAlert()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_StandardAlert" 
   ((inAlertType :SInt16)
    (inError (:pointer :STR255))
    (inExplanation (:pointer :STR255))
    (inAlertParam (:pointer :AlertStdAlertParamRec));  can be NULL 
    (outItemHit (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  CFString-based StandardAlert and StandardSheet APIs are only available on Mac OS X and later
; 
;  *  GetStandardAlertDefaultParams()
;  *  
;  *  Summary:
;  *    Fills out an AlertStdCFStringAlertParamRec with default values: -
;  *      not movable -   no help button -   default button with title
;  *    kAlertDefaultOKText, meaning "OK" -   no cancel or other buttons
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    param:
;  *      The parameter block to initialize.
;  *    
;  *    version:
;  *      The parameter block version; pass kStdCFStringAlertVersionOne.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetStandardAlertDefaultParams" 
   ((param (:pointer :AlertStdCFStringAlertParamRec))
    (version :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateStandardAlert()
;  *  
;  *  Summary:
;  *    Creates an alert containing standard elements and using standard
;  *    formatting rules.
;  *  
;  *  Discussion:
;  *    CreateStandardAlert should be used in conjunction with
;  *    RunStandardAlert. After CreateStandardAlert returns, the alert is
;  *    still invisible. RunStandardAlert will show the alert and run a
;  *    modal dialog loop to process events in the alert. 
;  *    
;  *    The strings passed to this API in the error, explanation, and
;  *    AlertStdCFStringAlertParamRec button title parameters will all be
;  *    retained during the creation of the alert, and released when the
;  *    alert is disposed by RunStandardAlert. There is no net change to
;  *    the refcount of these strings across CreateStandardAlert and
;  *    RunStandardAlert.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    alertType:
;  *      The type of alert to create.
;  *    
;  *    error:
;  *      The error string to display. CreateStandardAlert increments the
;  *      refcount on this string, so you may release it after
;  *      CreateStandardAlert returns if you don't need it later.
;  *    
;  *    explanation:
;  *      The explanation string to display. May be NULL or empty to
;  *      display no explanation. CreateStandardAlert increments the
;  *      refcount on this string, so you may release it after
;  *      CreateStandardAlert returns if you don't need it later.
;  *    
;  *    param:
;  *      The parameter block describing how to create the alert. May be
;  *      NULL. CreateStandardAlert increments the refcount on the button
;  *      title strings in the parameter block, so you may release them
;  *      after CreateStandardAlert returns if you don't need them later.
;  *    
;  *    outAlert:
;  *      On exit, contains the new alert.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateStandardAlert" 
   ((alertType :SInt16)
    (error (:pointer :__CFString))
    (explanation (:pointer :__CFString))        ;  can be NULL 
    (param (:pointer :AlertStdCFStringAlertParamRec));  can be NULL 
    (outAlert (:pointer :DIALOGREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RunStandardAlert()
;  *  
;  *  Summary:
;  *    Shows, runs, and destroys a standard alert using a modal dialog
;  *    loop.
;  *  
;  *  Discussion:
;  *    RunStandardAlert displays and runs an alert created by
;  *    CreateStandardAlert. It handles all user interaction with the
;  *    alert. After the user has dismissed the alert, RunStandardAlert
;  *    destroys the alert dialog; the DialogRef will be invalid after
;  *    RunStandardAlert returns. DO NOT call DisposeDialog. 
;  *    
;  *    NOTE: DO NOT call this function for a dialog that was not created
;  *    with CreateStandardAlert! You will sorely regret it, I promise
;  *    you.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inAlert:
;  *      The alert to display.
;  *    
;  *    filterProc:
;  *      An event filter function for handling events that do not apply
;  *      to the alert. May be NULL.
;  *    
;  *    outItemHit:
;  *      On exit, contains the item index of the button that was pressed
;  *      to close the alert.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RunStandardAlert" 
   ((inAlert (:pointer :OpaqueDialogPtr))
    (filterProc (:pointer :OpaqueModalFilterProcPtr));  can be NULL 
    (outItemHit (:pointer :DIALOGITEMINDEX))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateStandardSheet()
;  *  
;  *  Summary:
;  *    Creates an alert containing standard elements and using standard
;  *    formatting rules, and prepares it to be displayed as a sheet.
;  *  
;  *  Discussion:
;  *    CreateStandardSheet should be used in conjunction with
;  *    ShowSheetWindow. After CreateStandardSheet returns, the alert is
;  *    still invisible. ShowSheetWindow will show the alert and then
;  *    return. Events in the sheet are handled asynchronously; the
;  *    application should be prepared for the sheet window to be part of
;  *    its windowlist while running its own event loop. When a button in
;  *    the sheet is pressed, the EventTargetRef passed to
;  *    CreateStandardSheet will receive a command event with one of the
;  *    command IDs kHICommandOK, kHICommandCancel, or kHICommandOther.
;  *    The sheet is hidden and the sheet dialog destroyed before the
;  *    command is sent; the caller does not have to call HideSheetWindow
;  *    or DisposeDialog. 
;  *    
;  *    The strings passed to this API in the error, explanation, and
;  *    AlertStdCFStringAlertParamRec button title parameters will all be
;  *    retained during the creation of the sheet, and released when the
;  *    sheet is disposed. There is no net change to the refcount of
;  *    these strings across CreateStandardSheet and sheet destruction.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    alertType:
;  *      The type of alert to create.
;  *    
;  *    error:
;  *      The error string to display. CreateStandardSheet increments the
;  *      refcount on this string, so you may release it after
;  *      CreateStandardSheet returns if you don't need it later.
;  *    
;  *    explanation:
;  *      The explanation string to display. May be NULL or empty to
;  *      display no explanation. CreateStandardSheet increments the
;  *      refcount on this string, so you may release it after
;  *      CreateStandardSheet returns if you don't need it later.
;  *    
;  *    param:
;  *      The parameter block describing how to create the alert. May be
;  *      NULL. CreateStandardSheet increments the refcount on the button
;  *      title strings in the parameter block, so you may release them
;  *      after CreateStandardSheet returns if you don't need them later.
;  *    
;  *    notifyTarget:
;  *      The event target to be notified when the sheet is closed. The
;  *      caller should install an event handler on this target for the
;  *      [kEventClassCommand, kEventProcessCommand] event. May be NULL
;  *      if the caller does not need the command event to be sent to any
;  *      target. 
;  *      
;  *      Typically, this will be the event target for the parent window
;  *      of the sheet; a standard practice is to install a handler on
;  *      the parent window just before showing the sheet window, and to
;  *      remove the handler from the parent window after the sheet has
;  *      been closed. It is also possible to install a handler on the
;  *      sheet window itself, in which case you would pass NULL for this
;  *      parameter, since the command event is automatically sent to the
;  *      sheet window already. If you install a handler on the sheet
;  *      itself, make sure to return eventNotHandledErr from your
;  *      handler, because CreateStandardSheet installs its own handler
;  *      on the sheet and that handler must be allowed to run to close
;  *      the sheet window and release the DialogRef.
;  *    
;  *    outSheet:
;  *      On exit, contains the new alert.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateStandardSheet" 
   ((alertType :SInt16)
    (error (:pointer :__CFString))
    (explanation (:pointer :__CFString))        ;  can be NULL 
    (param (:pointer :AlertStdCFStringAlertParamRec));  can be NULL 
    (notifyTarget (:pointer :OpaqueEventTargetRef));  can be NULL 
    (outSheet (:pointer :DIALOGREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CloseStandardSheet()
;  *  
;  *  Summary:
;  *    Closes a standard sheet dialog and releases the dialog data
;  *    structures.
;  *  
;  *  Discussion:
;  *    CloseStandardSheet is meant to be used when you need to remove a
;  *    sheet because of a higher-priority request to close the sheet's
;  *    document window. For example, you might have a Save Changes sheet
;  *    open on a document window. Meanwhile, the user drags the document
;  *    into the trash. When your application sees that the document has
;  *    been moved to the trash, it knows that it should close the
;  *    document window, but first it needs to close the sheet. 
;  *    
;  *    CloseStandardSheet should not be used by your Carbon event
;  *    handler in response to a click in one of the sheet buttons; the
;  *    Dialog Manager will close the sheet automatically in that case.
;  *    
;  *    
;  *    If kStdAlertDoNotDisposeSheet was specified when the sheet was
;  *    created, the sheet dialog will be hidden but not released, and
;  *    you can reuse the sheet later.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inSheet:
;  *      The sheet to close.
;  *    
;  *    inResultCommand:
;  *      This command, if not zero, will be sent to the EventTarget
;  *      specified when the sheet was created.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CloseStandardSheet" 
   ((inSheet (:pointer :OpaqueDialogPtr))
    (inResultCommand :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDialogItemAsControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetDialogItemAsControl" 
   ((inDialog (:pointer :OpaqueDialogPtr))
    (inItemNo :SInt16)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  MoveDialogItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_MoveDialogItem" 
   ((inDialog (:pointer :OpaqueDialogPtr))
    (inItemNo :SInt16)
    (inHoriz :SInt16)
    (inVert :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SizeDialogItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SizeDialogItem" 
   ((inDialog (:pointer :OpaqueDialogPtr))
    (inItemNo :SInt16)
    (inWidth :SInt16)
    (inHeight :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  AppendDialogItemList()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DialogsLib 8.5 and later
;  

(deftrap-inline "_AppendDialogItemList" 
   ((dialog (:pointer :OpaqueDialogPtr))
    (ditlID :SInt16)
    (method :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     ¥ Dialog Routines available only with Appearance 1.1 (Mac OS 8.5) and later
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  SetDialogTimeout()
;  *  
;  *  Summary:
;  *    Sets the timeout for a modal dialog.
;  *  
;  *  Discussion:
;  *    SetDialogTimeout sets the delay after which a dialog will be
;  *    automatically dismissed. When SetDialogTimeout is called, the
;  *    Dialog Manager takes the current time, adds the timeout to it,
;  *    and stores the result as the time to dismiss the dialog. If the
;  *    dismissal time is reached, the dialog is automatically closed and
;  *    the specified dialog item index is returned from ModalDialog in
;  *    the itemHit parameter. If the user moves the mouse or presses a
;  *    key, the dismissal time is reset by adding the original timeout
;  *    to the time of the event. Only the ModalDialog API observes the
;  *    timeout value; if you are handling events in a modeless dialog or
;  *    sheet using IsDialogEvent and DialogSelect, the timeout will be
;  *    ignored.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDialog:
;  *      The dialog on which to set a timeout.
;  *    
;  *    inButtonToPress:
;  *      The dialog item index that should be returned from ModalDialog
;  *      when the timeout expires.
;  *    
;  *    inSecondsToWait:
;  *      The time to wait before dismissing the dialog, in seconds.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DialogsLib 8.5 and later
;  

(deftrap-inline "_SetDialogTimeout" 
   ((inDialog (:pointer :OpaqueDialogPtr))
    (inButtonToPress :SInt16)
    (inSecondsToWait :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDialogTimeout()
;  *  
;  *  Summary:
;  *    Retrieves the timeout for a modal dialog.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inDialog:
;  *      The dialog from which to retrieve the timeout.
;  *    
;  *    outButtonToPress:
;  *      On exit, contains the dialog item index that should be returned
;  *      from ModalDialog when the dialog is dismissed. May be NULL if
;  *      you do not need this information.
;  *    
;  *    outSecondsToWait:
;  *      On exit, contains the time to wait before dismissing the
;  *      dialog, in seconds. May be NULL if you do not need this
;  *      information.
;  *    
;  *    outSecondsRemaining:
;  *      On exit, contains the time until the dialog is dismissed, in
;  *      seconds. May be NULL if you do not need this information.
;  *  
;  *  Result:
;  *    An operating system result code. Returns dialogNoTimeoutErr if no
;  *    timeout has been set for this dialog.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DialogsLib 8.5 and later
;  

(deftrap-inline "_GetDialogTimeout" 
   ((inDialog (:pointer :OpaqueDialogPtr))
    (outButtonToPress (:pointer :SInt16))       ;  can be NULL 
    (outSecondsToWait (:pointer :UInt32))       ;  can be NULL 
    (outSecondsRemaining (:pointer :UInt32))    ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetModalDialogEventMask()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DialogsLib 8.5 and later
;  

(deftrap-inline "_SetModalDialogEventMask" 
   ((inDialog (:pointer :OpaqueDialogPtr))
    (inMask :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetModalDialogEventMask()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DialogsLib 8.5 and later
;  

(deftrap-inline "_GetModalDialogEventMask" 
   ((inDialog (:pointer :OpaqueDialogPtr))
    (outMask (:pointer :EVENTMASK))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     ¥ Accessor functions
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
; 
;  *  GetDialogWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_GetDialogWindow" 
   ((dialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  GetDialogTextEditHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_GetDialogTextEditHandle" 
   ((dialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  GetDialogDefaultItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_GetDialogDefaultItem" 
   ((dialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetDialogCancelItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_GetDialogCancelItem" 
   ((dialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetDialogKeyboardFocusItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_GetDialogKeyboardFocusItem" 
   ((dialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetPortDialogPort()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_SetPortDialogPort" 
   ((dialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetDialogPort()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_GetDialogPort" 
   ((dialog (:pointer :OpaqueDialogPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueGrafPtr)
() )
; 
;  *  GetDialogFromWindow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later or as macro/inline
;  

(deftrap-inline "_GetDialogFromWindow" 
   ((window (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDialogPtr)
() )
; 
;  *  CouldDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  FreeDialog()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  CouldAlert()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  FreeAlert()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #if OLDROUTINENAMES
#| 
; #define DisposDialog(theDialog) DisposeDialog(theDialog)
; #define UpdtDialog(theDialog, updateRgn) UpdateDialog(theDialog, updateRgn)
; #define GetDItem(theDialog, itemNo, itemType, item, box) GetDialogItem(theDialog, itemNo, itemType, item, box)
; #define SetDItem(theDialog, itemNo, itemType, item, box) SetDialogItem(theDialog, itemNo, itemType, item, box)
; #define HideDItem(theDialog, itemNo) HideDialogItem(theDialog, itemNo)
; #define ShowDItem(theDialog, itemNo) ShowDialogItem(theDialog, itemNo)
; #define SelIText(theDialog, itemNo, strtSel, endSel) SelectDialogItemText(theDialog, itemNo, strtSel, endSel)
; #define GetIText(item, text) GetDialogItemText(item, text)
; #define SetIText(item, text) SetDialogItemText(item, text)
; #define FindDItem(theDialog, thePt) FindDialogItem(theDialog, thePt)
; #define NewCDialog(dStorage, boundsRect, title, visible, procID, behind, goAwayFlag, refCon, items) NewColorDialog(dStorage, boundsRect, title, visible, procID, behind, goAwayFlag, refCon, items)
; #define GetAlrtStage() GetAlertStage()
; #define ResetAlrtStage() ResetAlertStage()
; #define DlgCut(theDialog) DialogCut(theDialog)
; #define DlgPaste(theDialog) DialogPaste(theDialog)
; #define DlgCopy(theDialog) DialogCopy(theDialog)
; #define DlgDelete(theDialog) DialogDelete(theDialog)
; #define SetDAFont(fontNum) SetDialogFont(fontNum)
; #define SetGrafPortOfDialog(dialog) SetPortDialogPort(dialog)
 |#

; #endif  /* OLDROUTINENAMES */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __DIALOGS__ */


(provide-interface "Dialogs")