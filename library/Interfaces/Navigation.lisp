(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Navigation.h"
; at Sunday July 2,2006 7:25:12 pm.
; 
;      File:       NavigationServices/Navigation.h
;  
;      Contains:   Navigation Services Interfaces
;  
;      Version:    NavigationServices-97.5~1
;  
;      Copyright:  © 1996-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __NAVIGATION__
; #define __NAVIGATION__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __TRANSLATION__
#| #|
#include <HIToolboxTranslation.h>
#endif
|#
 |#
; #ifndef __MACWINDOWS__
#| #|
#include <HIToolboxMacWindows.h>
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

(def-mactype :NavAskSaveChangesAction (find-mactype ':UInt32))
;  input action codes for NavAskSaveChanges() 

(defconstant $kNavSaveChangesClosingDocument 1)
(defconstant $kNavSaveChangesQuittingApplication 2)
(defconstant $kNavSaveChangesOther 0)

(def-mactype :NavAskSaveChangesResult (find-mactype ':UInt32))
;  result codes for NavAskSaveChanges() 

(defconstant $kNavAskSaveChangesSave 1)
(defconstant $kNavAskSaveChangesCancel 2)
(defconstant $kNavAskSaveChangesDontSave 3)

(def-mactype :NavAskDiscardChangesResult (find-mactype ':UInt32))
;  result codes for NavAskDiscardChanges() 

(defconstant $kNavAskDiscardChanges 1)
(defconstant $kNavAskDiscardChangesCancel 2)

(def-mactype :NavFilterModes (find-mactype ':SInt16))
;  which elements are being filtered for objects: 

(defconstant $kNavFilteringBrowserList 0)
(defconstant $kNavFilteringFavorites 1)
(defconstant $kNavFilteringRecents 2)
(defconstant $kNavFilteringShortCutVolumes 3)
(defconstant $kNavFilteringLocationPopup 4)     ;  for v1.1 or greater 


(defconstant $kNavFileOrFolderVersion 1)
(defrecord NavFileOrFolderInfo
   (version :UInt16)
   (isFolder :Boolean)
   (visible :Boolean)
   (creationDate :UInt32)
   (modificationDate :UInt32)
   (:variant
   (
   (locked :Boolean)                            ;  file is locked 
   (resourceOpen :Boolean)                      ;  resource fork is opened 
   (dataOpen :Boolean)                          ;  data fork is opened 
   (reserved1 :Boolean)
   (dataSize :UInt32)                           ;  size of the data fork 
   (resourceSize :UInt32)                       ;  size of the resource fork 
   (finderInfo :FInfo)                          ;  more file info: 
   (finderXInfo :FXInfo)
   )
   (
   (shareable :Boolean)
   (sharePoint :Boolean)
   (mounted :Boolean)
   (readable :Boolean)
   (writeable :Boolean)
   (reserved2 :Boolean)
   (numberOfFiles :UInt32)
   (finderDInfo :DInfo)
   (finderDXInfo :DXInfo)
   (folderType :OSType)                         ;  package type, For struct version >= 1 
   (folderCreator :OSType)                      ;  package creator, For struct version >= 1 
   (reserved3 (:array :character 206))
   )
   )
)

;type name? (%define-record :NavFileOrFolderInfo (find-record-descriptor ':NavFileOrFolderInfo))
(defrecord NavEventDataInfo
   (:variant
   (
   (event (:pointer :EventRecord))
   )
                                                ;  for event processing 
   (
   (param :pointer)
   )
                                                ;  points to event specific data 
   )
)

;type name? (%define-record :NavEventDataInfo (find-record-descriptor ':NavEventDataInfo))
(defrecord NavEventData
   (eventDataParms :NavEventDataInfo)           ;  the event data 
   (itemHit :SInt16)                            ;  the dialog item number, for v1.1 or greater 
)

;type name? (%define-record :NavEventData (find-record-descriptor ':NavEventData))
; 
;  *  NavDialogRef
;  *  
;  *  Summary:
;  *    Opaque Navigation Services dialog identifier
;  *  
;  *  Discussion:
;  *    A NavDialogRef is an opaque reference to an instance of a
;  *    Navigation Services dialog. A new NavDialogRef is returned from
;  *    any of the NavCreate*Dialog functions and is later disposed with
;  *    the NavDialogDispose function. NavDialogRef is the new name for
;  *    the NavContext type, and thus when a client's event proc is
;  *    called, the value of the NavCBRec.context field is the same as
;  *    the NavDialogRef returned from the corresponding
;  *    NavCreate*Dialog. A NavDialogRef is distinct from, and is not
;  *    interchangable with, a Dialog Manager DialogRef.
;  

(def-mactype :NavDialogRef (find-mactype '(:pointer :__NavDialog)))

; #if CALL_NOT_IN_CARBON
#|                                              ;  NavContext is the old name for NavDialogRef 

(def-mactype :NavContext (find-mactype ':NavDialogRef))
 |#

; #endif  /* CALL_NOT_IN_CARBON */

; 
;  *  NavUserAction
;  *  
;  *  Summary:
;  *    Indicates an action taken by the user
;  *  
;  *  Discussion:
;  *    When the user clicks a button at the bottom of a Nav Services
;  *    dialog (or makes an equivalent mouse or key gesture), a
;  *    kNavCBUserAction event is sent to the client's event proc
;  *    indicating which action was taken. Often, the action also
;  *    dismisses the dialog. User action events are only generated when
;  *    using dialogs created from a NavCreate*Dialog function. In the
;  *    special case of a modeless GetFile dialog (supported only on Mac
;  *    OS X), the user can option-click on the open button to keep the
;  *    dialog from being dismissed, but the kNavCBUserAction event is
;  *    sent so the client can get the reply record and open the selected
;  *    files.
;  

(def-mactype :NavUserAction (find-mactype ':UInt32))
; 
;    * No action taken. The dialog is still running or was terminated
;    * programmatically.
;    

(defconstant $kNavUserActionNone 0)
; 
;    * The user cancelled the dialog.
;    

(defconstant $kNavUserActionCancel 1)
; 
;    * The user clicked the Open button in the GetFile dialog.
;    

(defconstant $kNavUserActionOpen 2)
; 
;    * The user clicked the Save button in the PutFile dialog.
;    

(defconstant $kNavUserActionSaveAs 3)
; 
;    * The user clicked the Choose button in the ChooseFile,
;    * ChooseFolder, ChooseVolume or ChooseObject dialogs.
;    

(defconstant $kNavUserActionChoose 4)
; 
;    * The user clicked the New Folder button in the New Folder dialog.
;    

(defconstant $kNavUserActionNewFolder 5)
; 
;    * The user clicked the Save button in an AskSaveChanges dialog.
;    

(defconstant $kNavUserActionSaveChanges 6)
; 
;    * The user clicked the Don't Save button in an AskSaveChanges dialog.
;    

(defconstant $kNavUserActionDontSaveChanges 7)
; 
;    * The user clicked the Discard button in the AskDiscardChanges
;    * dialog.
;    

(defconstant $kNavUserActionDiscardChanges 8)
; 
;    * The user clicked the Review Unsaved button in the
;    * AskReviewDocuments dialog (used only on Mac OS X).
;    

(defconstant $kNavUserActionReviewDocuments 9)
; 
;    * The user clicked the Discard Changes button in the
;    * AskReviewDocuments dialog (used only on Mac OS X).
;    

(defconstant $kNavUserActionDiscardDocuments 10)

(defconstant $kNavCBRecVersion 1)
; 
;  *  NavCBRec
;  *  
;  *  Summary:
;  *    A structure passed to event and preview callbacks
;  *  
;  *  Discussion:
;  *    The NavCBRec structure is passed to the client's event proc or
;  *    custom preview proc. It provides information that is specific to
;  *    each event type. New for Carbon: the userAction field.
;  
(defrecord NavCBRec
                                                ; 
;    * The version of the struct (currently 1)
;    
   (version :UInt16)
                                                ; 
;    * The NavDialogRef this callback with which this call is associated
;    
   (context (:pointer :__NavDialog))
                                                ; 
;    * The dialog's window
;    
   (window (:pointer :OpaqueWindowPtr))
                                                ; 
;    * The custom control area rectangle (window coordinates)
;    
   (customRect :Rect)
                                                ; 
;    * The custom preview area rectangle (window coordinates)
;    
   (previewRect :Rect)
                                                ; 
;    * The event-specific data, including the EventRecord, if any
;    
   (eventData :NavEventData)
                                                ; 
;    * The action taken by the user that generated a kNavCBUserAction
;    * event (Carbon dialogs only)
;    
   (userAction :UInt32)
                                                ; 
;    * Reserved for future use
;    
   (reserved (:array :character 218))
)

;type name? (%define-record :NavCBRec (find-record-descriptor ':NavCBRec))

(def-mactype :NavCBRecPtr (find-mactype '(:pointer :NavCBRec)))
; 
;  *  NavEventCallbackMessage
;  *  
;  *  Summary:
;  *    Identifies the message type being sent to the client's event proc
;  

(def-mactype :NavEventCallbackMessage (find-mactype ':SInt32))
; 
;    * An OS event has occurred. A pointer to the EventRecord is in the
;    * eventData.eventDataParms.event field of the NavCBRec.
;    

(defconstant $kNavCBEvent 0)
; 
;    * Negotiate for custom control space. Client can set change the
;    * customRect field in the NavCBRec to create space for a custom
;    * area. Nav Services will continue to send the kNavCBCustomize
;    * message until the client leaves the customRect field unchanged.
;    

(defconstant $kNavCBCustomize 1)
; 
;    * This message is sent after custom area negotiation, just before
;    * the dialog is made visible. Add your custom controls when you
;    * receive this message.
;    

(defconstant $kNavCBStart 2)
; 
;    * This is the last message sent, after the dialog has been hidden.
;    

(defconstant $kNavCBTerminate 3)
; 
;    * Sent when the dialog has been resized. Check the customRect and or
;    * previewRect values to see if any relayout is needed. Nav Services
;    * automatically moves controls in the custom area.
;    

(defconstant $kNavCBAdjustRect 4)
; 
;    * The target folder of the dialog has changed. The
;    * NavCBRec.eventData.eventDataParms.param field is an AEDesc*
;    * containing an descriptor of the new location (ususally an FSSpec
;    * or an FSRef).
;    

(defconstant $kNavCBNewLocation 5)
; 
;    * The target folder has changed to the user's desktop folder.
;    

(defconstant $kNavCBShowDesktop 6)
; 
;    * The user has selected or deselected a file or folder. The
;    * NavCBRec.eventData.eventDataParms.param field is an AEDescList*
;    * identifying the currently selected items.
;    

(defconstant $kNavCBSelectEntry 7)
; 
;    * The value of the Show/Format popup menu has changed. The
;    * NavCBRec.eventData.eventDataParms.param is a NavMenuItemSpec*
;    * identifying the menu item selected. If the dialog was created
;    * using the Carbon-only NavCreate*Dialog APIs, then the menuType
;    * field of the NavMenuItemSpec is set to the index into the client's
;    * CFArray of popupExtension strings (see NavDialogCreationOptions).
;    

(defconstant $kNavCBPopupMenuSelect 8)
; 
;    * Sent when the user has accepted (Open, Save, etc.).
;    

(defconstant $kNavCBAccept 9)
; 
;    * Sent when the user has cancelled the dialog.
;    

(defconstant $kNavCBCancel 10)
; 
;    * The custom preview area state has changed. The
;    * NavCBRec.eventData.eventDataParms.param is a Boolean* set to true
;    * if the preview area is visible or false if it is not.
;    

(defconstant $kNavCBAdjustPreview 11)
; 
;    * The user has taken one of the actions described in the
;    * NavUserAction definition. The action may or may not dismiss the
;    * dialog. The NavCBRec.userAction field indicates which action was
;    * taken (Carbon dialogs only).
;    

(defconstant $kNavCBUserAction 12)
; 
;    * The user has opened a folder or chosen a file. The client can
;    * block navigation or dismissal by setting the appropriate action
;    * state with the kNavCtlSetActionState NavCustomControl selector.
;    

(defconstant $kNavCBOpenSelection #x80000000)

(def-mactype :NavCallBackUserData (find-mactype '(:pointer :void)))
;  for events and customization: 

(def-mactype :NavEventProcPtr (find-mactype ':pointer)); (NavEventCallbackMessage callBackSelector , NavCBRecPtr callBackParms , void * callBackUD)
;  for preview support: 

(def-mactype :NavPreviewProcPtr (find-mactype ':pointer)); (NavCBRecPtr callBackParms , void * callBackUD)
;  filtering callback information: 

(def-mactype :NavObjectFilterProcPtr (find-mactype ':pointer)); (AEDesc * theItem , void * info , void * callBackUD , NavFilterModes filterMode)

(def-mactype :NavEventUPP (find-mactype '(:pointer :OpaqueNavEventProcPtr)))

(def-mactype :NavPreviewUPP (find-mactype '(:pointer :OpaqueNavPreviewProcPtr)))

(def-mactype :NavObjectFilterUPP (find-mactype '(:pointer :OpaqueNavObjectFilterProcPtr)))
; 
;  *  NewNavEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewNavEventUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueNavEventProcPtr)
() )
; 
;  *  NewNavPreviewUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewNavPreviewUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueNavPreviewProcPtr)
() )
; 
;  *  NewNavObjectFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewNavObjectFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueNavObjectFilterProcPtr)
() )
; 
;  *  DisposeNavEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeNavEventUPP" 
   ((userUPP (:pointer :OpaqueNavEventProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeNavPreviewUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeNavPreviewUPP" 
   ((userUPP (:pointer :OpaqueNavPreviewProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeNavObjectFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeNavObjectFilterUPP" 
   ((userUPP (:pointer :OpaqueNavObjectFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeNavEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeNavEventUPP" 
   ((callBackSelector :SInt32)
    (callBackParms (:pointer :NavCBRec))
    (callBackUD :pointer)
    (userUPP (:pointer :OpaqueNavEventProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeNavPreviewUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeNavPreviewUPP" 
   ((callBackParms (:pointer :NavCBRec))
    (callBackUD :pointer)
    (userUPP (:pointer :OpaqueNavPreviewProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeNavObjectFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeNavObjectFilterUPP" 
   ((theItem (:pointer :AEDesc))
    (info :pointer)
    (callBackUD :pointer)
    (filterMode :SInt16)
    (userUPP (:pointer :OpaqueNavObjectFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )

(def-mactype :NavCustomControlMessage (find-mactype ':SInt32))

(defconstant $kNavCtlShowDesktop 0)             ;     show desktop,           parms = nil 

(defconstant $kNavCtlSortBy 1)                  ;     sort key field,       parms->NavSortKeyField 

(defconstant $kNavCtlSortOrder 2)               ;     sort order,              parms->NavSortOrder 

(defconstant $kNavCtlScrollHome 3)              ;     scroll list home,       parms = nil 

(defconstant $kNavCtlScrollEnd 4)               ;     scroll list end,      parms = nil 

(defconstant $kNavCtlPageUp 5)                  ;     page list up,          parms = nil 

(defconstant $kNavCtlPageDown 6)                ;     page list down,          parms = nil 

(defconstant $kNavCtlGetLocation 7)             ;     get current location,   parms<-AEDesc* 

(defconstant $kNavCtlSetLocation 8)             ;     set current location,   parms->AEDesc* 

(defconstant $kNavCtlGetSelection 9)            ;     get current selection,     parms<-AEDescList* 

(defconstant $kNavCtlSetSelection 10)           ;     set current selection,     parms->AEDescList* 

(defconstant $kNavCtlShowSelection 11)          ;     make selection visible,       parms = nil 

(defconstant $kNavCtlOpenSelection 12)          ;     open view of selection,       parms = nil 

(defconstant $kNavCtlEjectVolume 13)            ;     eject volume,          parms->vRefNum 

(defconstant $kNavCtlNewFolder 14)              ;     create a new folder,     parms->StringPtr 

(defconstant $kNavCtlCancel 15)                 ;     cancel dialog,          parms = nil 

(defconstant $kNavCtlAccept 16)                 ;     accept dialog default,     parms = nil 

(defconstant $kNavCtlIsPreviewShowing 17)       ;     query preview status,   parms<-Boolean 

(defconstant $kNavCtlAddControl 18)             ;   add one control to dialog,    parms->ControlHandle 

(defconstant $kNavCtlAddControlList 19)         ;     add control list to dialog,    parms->Handle (DITL rsrc) 

(defconstant $kNavCtlGetFirstControlID 20)      ;     get 1st control ID,         parms<-UInt16 

(defconstant $kNavCtlSelectCustomType 21)       ;     select a custom menu item  parms->NavMenuItemSpec* 

(defconstant $kNavCtlSelectAllType 22)          ;   select an "All" menu item parms->SInt16 

(defconstant $kNavCtlGetEditFileName 23)        ;     get save dlog's file name  parms<-StringPtr 

(defconstant $kNavCtlSetEditFileName 24)        ;     set save dlog's file name  parms->StringPtr 

(defconstant $kNavCtlSelectEditFileName 25)     ;     select save dlog file name parms->ControlEditTextSelectionRec*, v1.1 or greater 

(defconstant $kNavCtlBrowserSelectAll 26)       ;   re-scan the browser list  parms = nil, v2.0 or greater 

(defconstant $kNavCtlGotoParent 27)             ;   navigate to parent         parms = nil, v2.0 or greater 

(defconstant $kNavCtlSetActionState 28)         ;   restrict navigation      parms->NavActionState (flags), v2.0 or greater 

(defconstant $kNavCtlBrowserRedraw 29)          ;   rescan browser list      parms = nil, v2.0 or greater 

(defconstant $kNavCtlTerminate 30)              ;   terminate/dismiss dialog  parms = nil, v2.0 or greater 


(def-mactype :NavActionState (find-mactype ':UInt32))

(defconstant $kNavNormalState 0)                ;  normal/default state 

(defconstant $kNavDontOpenState 1)              ;  disallow opening files/folders 

(defconstant $kNavDontSaveState 2)              ;  disallow saving files 

(defconstant $kNavDontChooseState 4)            ;  disallow choosing objects 

(defconstant $kNavDontNewFolderState 16)        ;  disallow creating new folders 


(def-mactype :NavPopupMenuItem (find-mactype ':UInt16))

(defconstant $kNavAllKnownFiles 0)
(defconstant $kNavAllReadableFiles 1)
(defconstant $kNavAllFiles 2)

(def-mactype :NavSortKeyField (find-mactype ':UInt16))

(defconstant $kNavSortNameField 0)
(defconstant $kNavSortDateField 1)

(def-mactype :NavSortOrder (find-mactype ':UInt16))

(defconstant $kNavSortAscending 0)
(defconstant $kNavSortDescending 1)

(def-mactype :NavDialogOptionFlags (find-mactype ':UInt32))

(defconstant $kNavDefaultNavDlogOptions #xE4)   ;  use defaults for all the options 

(defconstant $kNavNoTypePopup 1)                ;  don't show file type/extension popup on Open/Save 

(defconstant $kNavDontAutoTranslate 2)          ;  don't automatically translate on Open 

(defconstant $kNavDontAddTranslateItems 4)      ;  don't add translation choices on Open/Save 

(defconstant $kNavAllFilesInPopup 16)           ;  "All Files" menu item in the type popup on Open 

(defconstant $kNavAllowStationery 32)           ;  allow saving of stationery files 

(defconstant $kNavAllowPreviews 64)             ;  allow preview to show 

(defconstant $kNavAllowMultipleFiles #x80)      ;  allow multiple items to be selected 

(defconstant $kNavAllowInvisibleFiles #x100)    ;  allow invisible items to be shown 

(defconstant $kNavDontResolveAliases #x200)     ;  don't resolve aliases 

(defconstant $kNavSelectDefaultLocation #x400)  ;  make the default location the browser selection 

(defconstant $kNavSelectAllReadableItem #x800)  ;  make the dialog select "All Readable Documents" on open 

(defconstant $kNavSupportPackages #x1000)       ;  recognize file system packages, v2.0 or greater 

(defconstant $kNavAllowOpenPackages #x2000)     ;  allow opening of packages, v2.0 or greater 

(defconstant $kNavDontAddRecents #x4000)        ;  don't add chosen objects to the recents list, v2.0 or greater 

(defconstant $kNavDontUseCustomFrame #x8000)    ;  don't draw the custom area bevel frame, v2.0 or greater 

(defconstant $kNavDontConfirmReplacement #x10000);  don't show the "Replace File?" alert on save conflict, v3.0 or greater 

(defconstant $kNavPreserveSaveFileExtension #x20000);  extension in default file name is preserved and initially hidden, v3.1 or greater 


(def-mactype :NavTranslationOptions (find-mactype ':UInt32))

(defconstant $kNavTranslateInPlace 0)           ;     translate in place, replacing translation source file (default for Save) 

(defconstant $kNavTranslateCopy 1)              ;     translate to a copy of the source file (default for Open) 


(defconstant $kNavMenuItemSpecVersion 0)
(defrecord NavMenuItemSpec
   (version :UInt16)
   (menuCreator :OSType)
   (menuType :OSType)
   (menuItemName (:string 255))
   (reserved (:array :character 245))
)

;type name? (%define-record :NavMenuItemSpec (find-record-descriptor ':NavMenuItemSpec))

(def-mactype :NavMenuItemSpecArrayPtr (find-mactype '(:pointer :NavMenuItemSpec)))

(def-mactype :NavMenuItemSpecArrayHandle (find-mactype '(:handle :NavMenuItemSpec)))

(def-mactype :NavMenuItemSpecPtr (find-mactype ':NavMenuItemSpecArrayPtr))

(def-mactype :NavMenuItemSpecHandle (find-mactype ':NavMenuItemSpecArrayHandle))

(defconstant $kNavGenericSignature :|****|)
(defrecord NavTypeList
   (componentSignature :OSType)
   (reserved :SInt16)
   (osTypeCount :SInt16)
   (osType (:array :OSType 1))
)

;type name? (%define-record :NavTypeList (find-record-descriptor ':NavTypeList))

(def-mactype :NavTypeListPtr (find-mactype '(:pointer :NavTypeList)))

(def-mactype :NavTypeListHandle (find-mactype '(:handle :NavTypeList)))

(defconstant $kNavDialogOptionsVersion 0)
(defrecord NavDialogOptions
   (version :UInt16)
   (dialogOptionFlags :UInt32)                  ;  option flags for affecting the dialog's behavior 
   (location :Point)                            ;  top-left location of the dialog, or {-1,-1} for default position 
   (clientName (:string 255))
   (windowTitle (:string 255))
   (actionButtonLabel (:string 255))            ;  label of the default button (or null string for default) 
   (cancelButtonLabel (:string 255))            ;  label of the cancel button (or null string for default) 
   (savedFileName (:string 255))                ;  default name for text box in NavPutFile (or null string for default) 
   (message (:string 255))                      ;  custom message prompt (or null string for default) 
   (preferenceKey :UInt32)                      ;  a key for to managing preferences for using multiple utility dialogs 
   (popupExtension (:Handle :NavMenuItemSpec))  ;  extended popup menu items, an array of NavMenuItemSpecs 
   (reserved (:array :character 494))
)

;type name? (%define-record :NavDialogOptions (find-record-descriptor ':NavDialogOptions))

(defconstant $kNavReplyRecordVersion 2)
; 
;  *  NavReplyRecord
;  *  
;  *  Summary:
;  *    A structure describing the results of a Nav Services dialog
;  *  
;  *  Discussion:
;  *    A reply record is the result of a Nav Services file dialog. Using
;  *    the older API, which is always modal, the client passes the
;  *    address of a reply record when invoking the dialog. In the Carbon
;  *    API, dialogs may also be window modal or modeless, so the client
;  *    requests the reply record by calling NavDialogGetReply when a
;  *    kNavCBUserAction event is received. Either way, a reply record
;  *    should be disposed of using NavDisposeReply.
;  
(defrecord NavReplyRecord
                                                ; 
;    * The version of the structure. The first public version of the
;    * structure was version 0. Fields added after version 0, starting
;    * with the saveFileName field, are noted below.
;    
   (version :UInt16)
                                                ; 
;    * True if the reply contains a non-null selection
;    
   (validRecord :Boolean)
                                                ; 
;    * True if this reply is from a PutFile dialog and the file to be
;    * saved already exists and needs to be replaced. The user has
;    * already been warned unless the kNavDontConfirmReplacement option
;    * flag is used.
;    
   (replacing :Boolean)
                                                ; 
;    * True if this reply is from a PutFile dialog and the user wants to
;    * save the file as stationery.
;    
   (isStationery :Boolean)
                                                ; 
;    * True if translation was performed on the file(s) to be opened or
;    * if transtlation will be needed on the file to be saved.
;    
   (translationNeeded :Boolean)
                                                ; 
;    * For GetFile or Choose dialogs, a list of items chosen by the user.
;    * For the older NavPutFile dialog, a list containing one item: an
;    * FSSpec of the file to be saved. ** IMPORTANT NOTE *** For the new
;    * Carbon-only PutFile dialog created with NavCreatePutFileDialog,
;    * the selection is a list containing one item: the DIRECTORY where
;    * the file is to be saved. The file name is obtained from the
;    * saveFileName field. When using the original modal API, each
;    * descriptor will contain an FSSpec (typeFSS). When using the new
;    * Carbon-only dialogs created via the NavCreate*Dialog functions,
;    * each descriptor could contain either an FSSpec (typeFSS, used on
;    * Mac OS 8 or 9) or an FSRef (typeFSRef, used on Mac OS X). This
;    * divergence is caused by the need to use FSRef (for Unicode/HFS+
;    * support) on Mac OS X, while being unable to provide FSRefs on Mac
;    * OS 8.6.
;    
   (selection :AEDesc)
                                                ; 
;    * For NavPutFile: the script system associated with the name of the
;    * file to be saved.
;    
   (keyScript :SInt16)
                                                ; 
;    * A handle to an array of type FileTranslationSpec. Each array entry
;    * corresponds to an item in the selection and describes the
;    * translation that was performed (GetFile) or needs to be performed
;    * (PutFile) on that item.
;    
   (fileTranslation (:Handle :FileTranslationSpec))
                                                ; 
;    * Reserved for private use.
;    
   (reserved1 :UInt32)
                                                ; 
;    * Carbon PutFile dialog only: the name of the file to be saved. This
;    * field contains the true file name to saved, even if the extension
;    * will be hidden from the user. This field was added in structure
;    * version 1.
;    
   (saveFileName (:pointer :__CFString))
                                                ; 
;    * The extension on the name of the saved file should be hidden. Once
;    * the file has been saved, the client should call NavCompleteSave.
;    * NavCompleteSave will take care of hiding the extension on the
;    * file. However, the client needs to know that the extension is
;    * hidden so that it can display the document name correctly in the
;    * UI, such as in window titles and menus. This field is only used if
;    * the client has r equested extension preservation using the
;    * kNavPreserveSaveFileExtension dialog option flag. This field was
;    * added in structure version 2.
;    
   (saveFileExtensionHidden :Boolean)
                                                ; 
;    * Reserved for future use.
;    
   (reserved2 :UInt8)
                                                ; 
;    * Reserved for future use.
;    
   (reserved (:array :character 225))
)

;type name? (%define-record :NavReplyRecord (find-record-descriptor ':NavReplyRecord))
; 
;  *  NavLoad()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavLoad" 
   (
   )
   :OSErr
() )
; 
;  *  NavUnload()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavUnload" 
   (
   )
   :OSErr
() )
; 
;  *  NavLibraryVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavLibraryVersion" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  NavGetDefaultDialogOptions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavGetDefaultDialogOptions" 
   ((dialogOptions (:pointer :NavDialogOptions))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavGetFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavGetFile" 
   ((defaultLocation (:pointer :AEDesc))        ;  can be NULL 
    (reply (:pointer :NavReplyRecord))
    (dialogOptions (:pointer :NavDialogOptions));  can be NULL 
    (eventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (previewProc (:pointer :OpaqueNavPreviewProcPtr));  can be NULL 
    (filterProc (:pointer :OpaqueNavObjectFilterProcPtr));  can be NULL 
    (typeList (:Handle :NavTypeList))           ;  can be NULL 
    (callBackUD :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavPutFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavPutFile" 
   ((defaultLocation (:pointer :AEDesc))        ;  can be NULL 
    (reply (:pointer :NavReplyRecord))
    (dialogOptions (:pointer :NavDialogOptions));  can be NULL 
    (eventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (fileType :OSType)
    (fileCreator :OSType)
    (callBackUD :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavAskSaveChanges()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavAskSaveChanges" 
   ((dialogOptions (:pointer :NavDialogOptions))
    (action :UInt32)
    (reply (:pointer :NAVASKSAVECHANGESRESULT))
    (eventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (callBackUD :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavCustomAskSaveChanges()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavCustomAskSaveChanges" 
   ((dialogOptions (:pointer :NavDialogOptions))
    (reply (:pointer :NAVASKSAVECHANGESRESULT))
    (eventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (callBackUD :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavAskDiscardChanges()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavAskDiscardChanges" 
   ((dialogOptions (:pointer :NavDialogOptions))
    (reply (:pointer :NAVASKDISCARDCHANGESRESULT))
    (eventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (callBackUD :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavChooseFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavChooseFile" 
   ((defaultLocation (:pointer :AEDesc))        ;  can be NULL 
    (reply (:pointer :NavReplyRecord))
    (dialogOptions (:pointer :NavDialogOptions));  can be NULL 
    (eventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (previewProc (:pointer :OpaqueNavPreviewProcPtr));  can be NULL 
    (filterProc (:pointer :OpaqueNavObjectFilterProcPtr));  can be NULL 
    (typeList (:Handle :NavTypeList))           ;  can be NULL 
    (callBackUD :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavChooseFolder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavChooseFolder" 
   ((defaultLocation (:pointer :AEDesc))        ;  can be NULL 
    (reply (:pointer :NavReplyRecord))
    (dialogOptions (:pointer :NavDialogOptions));  can be NULL 
    (eventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (filterProc (:pointer :OpaqueNavObjectFilterProcPtr));  can be NULL 
    (callBackUD :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavChooseVolume()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavChooseVolume" 
   ((defaultSelection (:pointer :AEDesc))       ;  can be NULL 
    (reply (:pointer :NavReplyRecord))
    (dialogOptions (:pointer :NavDialogOptions));  can be NULL 
    (eventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (filterProc (:pointer :OpaqueNavObjectFilterProcPtr));  can be NULL 
    (callBackUD :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavChooseObject()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavChooseObject" 
   ((defaultLocation (:pointer :AEDesc))        ;  can be NULL 
    (reply (:pointer :NavReplyRecord))
    (dialogOptions (:pointer :NavDialogOptions));  can be NULL 
    (eventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (filterProc (:pointer :OpaqueNavObjectFilterProcPtr));  can be NULL 
    (callBackUD :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavNewFolder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavNewFolder" 
   ((defaultLocation (:pointer :AEDesc))        ;  can be NULL 
    (reply (:pointer :NavReplyRecord))
    (dialogOptions (:pointer :NavDialogOptions));  can be NULL 
    (eventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (callBackUD :pointer)                       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavTranslateFile()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavTranslateFile" 
   ((reply (:pointer :NavReplyRecord))
    (howToTranslate :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavCompleteSave()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavCompleteSave" 
   ((reply (:pointer :NavReplyRecord))
    (howToTranslate :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavCustomControl()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavCustomControl" 
   ((dialog (:pointer :__NavDialog))
    (selector :SInt32)
    (parms :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavCreatePreview()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 2.0 and later
;  

(deftrap-inline "_NavCreatePreview" 
   ((theObject (:pointer :AEDesc))
    (previewDataType :OSType)
    (previewData :pointer)
    (previewDataSize :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavDisposeReply()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavDisposeReply" 
   ((reply (:pointer :NavReplyRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NavServicesCanRun()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in NavigationLib 1.0 and later
;  

(deftrap-inline "_NavServicesCanRun" 
   (
   )
   :Boolean
() )

; #if TARGET_RT_MAC_CFM
; #ifdef __cplusplus
#| #|
    inline pascal Boolean NavServicesAvailable() { return ((NavLibraryVersion != (void*)kUnresolvedCFragSymbolAddress) && NavServicesCanRun()); }
|#
 |#

; #else
; #define NavServicesAvailable()  ((NavLibraryVersion != (void*)kUnresolvedCFragSymbolAddress) && NavServicesCanRun())

; #endif

#| 
; #elif TARGET_RT_MAC_MACHO
;  Navigation is always available on OS X 
; #ifdef __cplusplus
#|
    inline pascal Boolean NavServicesAvailable() { return true; }
|#

; #else
; #define NavServicesAvailable()  (true)

; #endif

 |#

; #else
;  NavServicesAvailable() is implemented in Navigation.o for classic 68K clients
; 
;  *  NavServicesAvailable()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

; #endif  /*  */

;  Carbon API 
;  Includes support for Unicode and long file names (where available). 

(defconstant $kNavDialogCreationOptionsVersion 0)
; 
;  *  NavDialogCreationOptions
;  *  
;  *  Summary:
;  *    Options used to control the appearance and operation of a Nav
;  *    Services dialog
;  *  
;  *  Discussion:
;  *    NavDialogCreationOptions is a preferred replacement for
;  *    NavDialogOptions. The new structure uses CFStrings in place of
;  *    Pascal strings, and adds fields for setting the dialog modality
;  *    and the parent window (for sheet dialogs). A
;  *    NavDialogCreationOptions structure can be initialized using
;  *    NavDialogGetDefaultCreationOptions. Each of the NavCreate*Dialog
;  *    functions accepts a pointer to the client's
;  *    NavDialogCreationOptions structure.
;  
(defrecord NavDialogCreationOptions
                                                ; 
;    * The version of the struture. Currently, the only valid version is
;    * 0, containing all the fields described here.
;    
   (version :UInt16)
                                                ; 
;    * Options for the dialog. See NavDialogOptionFlags for a description
;    * of each option.
;    
   (optionFlags :UInt32)
                                                ; 
;    * The screen position at which to place the upper left corner of the
;    * dialog, in global coordinates. Specify (-1, -1) to use the default
;    * (persistent) location. Ignored for sheet dialogs.
;    
   (location :Point)
                                                ; 
;    * The user-readable name of the client, usually the name of the
;    * current application. This value is used to construct the default
;    * window title in the file dialogs, and the message text in the Ask
;    * dialogs. On Mac OS 9 and earlier, this value is used as a key to
;    * store persistent per-client dialog settings, so it's always a good
;    * idea to set this field to a non-NULL value.
;    
   (clientName (:pointer :__CFString))
                                                ; 
;    * The custom title for the dialog window. Specify NULL to use the
;    * default title.
;    
   (windowTitle (:pointer :__CFString))
                                                ; 
;    * The custom label for the default (Open/Save/Choose) button.
;    * Specify NULL to use the default label.
;    
   (actionButtonLabel (:pointer :__CFString))
                                                ; 
;    * The custom label for the Cancel button. Specify NULL to use the
;    * default label.
;    
   (cancelButtonLabel (:pointer :__CFString))
                                                ; 
;    * The initial value appearing in the edit text field for the file
;    * name to be saved (PutFile, NavAskSaveChanges only).
;    
   (saveFileName (:pointer :__CFString))
                                                ; 
;    * For the file dialogs, a banner message appearing across the top of
;    * the dialog. Specify NULL to provide no banner message. For the Ask
;    * alerts, a custom message to replace the default message.
;    
   (message (:pointer :__CFString))
                                                ; 
;    * A key to uniquely identify the dialog's usage context within the
;    * application. If an application uses the same class of dialog (e.g.
;    * GetFile or ChooseFile) for more than one purpose, set this field
;    * to a unique value for each usage in order to give each dialog its
;    * own persistent settings (e.g. screen rectangle, starting target
;    * folder).
;    
   (preferenceKey :UInt32)
                                                ; 
;    * A CFArray of CFStrings. The strings are added as menu items to the
;    * Show or Format popup menus in the GetFile or PutFile dialogs,
;    * respectively.
;    
   (popupExtension (:pointer :__CFArray))
                                                ; 
;    * The modality in which to present the dialog. The default modality
;    * for all dialogs is kWindowModalityAppModal. If
;    * kWindowModalityWindowModal is specified, then a valid parentWindow
;    * is required.
;    
   (modality :UInt32)
                                                ; 
;    * The window to which a window-modal (sheet) dialog is to be
;    * attached.
;    
   (parentWindow (:pointer :OpaqueWindowPtr))
                                                ; 
;    * Reserved for future use.
;    
   (reserved (:array :character 16))
)

;type name? (%define-record :NavDialogCreationOptions (find-record-descriptor ':NavDialogCreationOptions))
; 
;  *  NavGetDefaultDialogCreationOptions()
;  *  
;  *  Summary:
;  *    Initialize the input structure to default values
;  *  
;  *  Discussion:
;  *    Provided as a convenience to obtain the preferred default options
;  *    for use in creating any Nav Services dialog.
;  *  
;  *  Parameters:
;  *    
;  *    outOptions:
;  *      A pointer to the client-allocated options structure to
;  *      initialize
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavGetDefaultDialogCreationOptions" 
   ((outOptions (:pointer :NavDialogCreationOptions))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NavCreateGetFileDialog()
;  *  
;  *  Summary:
;  *    Create a GetFile dialog
;  *  
;  *  Discussion:
;  *    Use this function to create a dialog designed for opening
;  *    document files. This function replaces NavGetFile, allowing new
;  *    window modalities, and adding Unicode support. Upon successful
;  *    creation, the dialog is not visible. Present and run the dialog
;  *    with NavDialogRun. After the dialog is complete, dispose of it
;  *    with NavDialogDispose.
;  *  
;  *  Parameters:
;  *    
;  *    inOptions:
;  *      Options controlling the appearance and behavior of the dialog
;  *    
;  *    inTypeList:
;  *      A creator signature and list of file types to show in the
;  *      dialog file browser. If NULL, show all files.
;  *    
;  *    inEventProc:
;  *      The UPP for the client's event callack, or NULL for no event
;  *      callback
;  *    
;  *    inPreviewProc:
;  *      The UPP for the client's custom file preview callback, or NULL
;  *      for standard previews
;  *    
;  *    inFilterProc:
;  *      The UPP for the client's custom filter callback, or NULL for no
;  *      custom file filtering
;  *    
;  *    inClientData:
;  *      A client-defined context value passed to all callback functions
;  *    
;  *    outDialog:
;  *      Upon successful completion, a reference to the created dialog
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavCreateGetFileDialog" 
   ((inOptions (:pointer :NavDialogCreationOptions));  can be NULL 
    (inTypeList (:Handle :NavTypeList))         ;  can be NULL 
    (inEventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (inPreviewProc (:pointer :OpaqueNavPreviewProcPtr));  can be NULL 
    (inFilterProc (:pointer :OpaqueNavObjectFilterProcPtr));  can be NULL 
    (inClientData :pointer)                     ;  can be NULL 
    (outDialog (:pointer :NavDialogRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NavCreatePutFileDialog()
;  *  
;  *  Summary:
;  *    Create a PutFile dialog
;  *  
;  *  Discussion:
;  *    Use this function to create a dialog designed for setting the
;  *    name and location of a document file prior to saving. This
;  *    function replaces NavPutFile, allowing new window modalities, and
;  *    adding Unicode support. Upon successful creation, the dialog is
;  *    not visible. Present and run the dialog with NavDialogRun. After
;  *    the dialog is complete, dispose of it with NavDialogDispose.
;  *  
;  *  Parameters:
;  *    
;  *    inOptions:
;  *      Options controlling the appearance and behavior of the dialog
;  *    
;  *    inFileType:
;  *      The type of the file to be saved. This parameter is used in
;  *      conjunction with the inFileCreator parameter to look up the
;  *      kind string for the Format popup menu, and to drive the
;  *      identification of translation options.
;  *    
;  *    inFileCreator:
;  *      The creator signature of the file to be saved (see inFileType
;  *      parameter)
;  *    
;  *    inEventProc:
;  *      The UPP for the client's event callack, or NULL for no event
;  *      callback
;  *    
;  *    inClientData:
;  *      A client-defined context value passed to all callback functions
;  *    
;  *    outDialog:
;  *      Upon successful completion, a reference to the created dialog
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavCreatePutFileDialog" 
   ((inOptions (:pointer :NavDialogCreationOptions));  can be NULL 
    (inFileType :OSType)
    (inFileCreator :OSType)
    (inEventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (inClientData :pointer)                     ;  can be NULL 
    (outDialog (:pointer :NavDialogRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NavCreateAskReviewDocumentsDialog()
;  *  
;  *  Summary:
;  *    Create an AskReviewDocumentsDialog dialog
;  *  
;  *  Discussion:
;  *    Use this function to create a dialog which tells the user how
;  *    many unsaved documents there are, and asks the user to start
;  *    reviewing the documents, don't save any documents, or cancel.
;  *    This dialog is appropriate to use when an application is quitting
;  *    and there is more than one unsaved document. It is supported only
;  *    on Mac OS X because the HI guidelines for earlier versions of Mac
;  *    OS do not include this dialog as part of the application quit
;  *    sequence. Upon successful creation, the dialog is not visible.
;  *    Present and run the dialog with NavDialogRun. After the dialog is
;  *    complete, dispose of it with NavDialogDispose. Upon dismissal of
;  *    the dialog, this dialog's user action will be set to one of the
;  *    following: kNavUserActionReviewDocuments,
;  *    kNavUserActionDiscardDocuments, or kNavUserActionCancel.
;  *  
;  *  Parameters:
;  *    
;  *    inOptions:
;  *      Options controlling the appearance and behavior of the dialog
;  *    
;  *    inDocumentCount:
;  *      Indicates the number of documents needing review. This number
;  *      appears in the text presented to the user. If for any reason
;  *      the total number of unsaved documents is unknown, specify 0,
;  *      and an ambiguous message will appear. Do not specifiy 1, since
;  *      the HI guidelines call for this alert only when there is more
;  *      than one document to be reviewed.
;  *    
;  *    inEventProc:
;  *      The UPP for the client's event callack, or NULL for no event
;  *      callback
;  *    
;  *    inClientData:
;  *      A client-defined context value passed to all callback functions
;  *    
;  *    outDialog:
;  *      Upon successful completion, a reference to the created dialog
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavCreateAskReviewDocumentsDialog" 
   ((inOptions (:pointer :NavDialogCreationOptions))
    (inDocumentCount :UInt32)
    (inEventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (inClientData :pointer)                     ;  can be NULL 
    (outDialog (:pointer :NavDialogRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  NavCreateAskSaveChangesDialog()
;  *  
;  *  Summary:
;  *    Create an AskSaveChanges dialog
;  *  
;  *  Discussion:
;  *    Use this function to create a dialog which asks the user to save,
;  *    don't save or cancel closing a document with unsaved changes.
;  *    This function replaces NavAskSaveChanges and
;  *    NavCustomAskSaveChanges, allowing new window modalities, and
;  *    adding Unicode support. Upon successful creation, the dialog is
;  *    not visible. Present and run the dialog with NavDialogRun. After
;  *    the dialog is complete, dispose of it with NavDialogDispose. To
;  *    provide a customized message for the alert, specify an non-NULL
;  *    message value in the options structure.
;  *  
;  *  Parameters:
;  *    
;  *    inOptions:
;  *      Options controlling the appearance and behavior of the dialog
;  *    
;  *    inAction:
;  *      Indicates this usage context for this dialog: closing a
;  *      document or quitting an application. This setting affects the
;  *      message text displayed to the user.
;  *    
;  *    inEventProc:
;  *      The UPP for the client's event callack, or NULL for no event
;  *      callback
;  *    
;  *    inClientData:
;  *      A client-defined context value passed to all callback functions
;  *    
;  *    outDialog:
;  *      Upon successful completion, a reference to the created dialog
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavCreateAskSaveChangesDialog" 
   ((inOptions (:pointer :NavDialogCreationOptions))
    (inAction :UInt32)
    (inEventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (inClientData :pointer)                     ;  can be NULL 
    (outDialog (:pointer :NavDialogRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NavCreateAskDiscardChangesDialog()
;  *  
;  *  Summary:
;  *    Create an AskDiscardChanges dialog
;  *  
;  *  Discussion:
;  *    Use this function to create a dialog which asks the user to
;  *    discard changes to a document or cancel. This is most often use
;  *    when the user wants to revert a a document to the last saved
;  *    revision. This function replaces NavAskDiscardChanges, allowing
;  *    new window modalities, and adding Unicode support. Upon
;  *    successful creation, the dialog is not visible. Present and run
;  *    the dialog with NavDialogRun. After the dialog is complete,
;  *    dispose of it with NavDialogDispose.
;  *  
;  *  Parameters:
;  *    
;  *    inOptions:
;  *      Options controlling the appearance and behavior of the dialog
;  *    
;  *    inEventProc:
;  *      The UPP for the client's event callack, or NULL for no event
;  *      callback
;  *    
;  *    inClientData:
;  *      A client-defined context value passed to all callback functions
;  *    
;  *    outDialog:
;  *      Upon successful completion, a reference to the created dialog
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavCreateAskDiscardChangesDialog" 
   ((inOptions (:pointer :NavDialogCreationOptions))
    (inEventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (inClientData :pointer)                     ;  can be NULL 
    (outDialog (:pointer :NavDialogRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NavCreateChooseFileDialog()
;  *  
;  *  Summary:
;  *    Create a ChooseFile dialog
;  *  
;  *  Discussion:
;  *    Use this function to create a dialog designed for selecting one
;  *    file as the target of an operation. A ChooseFile dialog is a
;  *    simple version a GetFile dialog. This function replaces
;  *    NavChooseFile, allowing new window modalities, and adding Unicode
;  *    support. Upon successful creation, the dialog is not visible.
;  *    Present and run the dialog with NavDialogRun. After the dialog is
;  *    complete, dispose of it with NavDialogDispose.
;  *  
;  *  Parameters:
;  *    
;  *    inOptions:
;  *      Options controlling the appearance and behavior of the dialog
;  *    
;  *    inTypeList:
;  *      A creator signature and list of file types to show in the
;  *      dialog file browser. If NULL, show all files.
;  *    
;  *    inEventProc:
;  *      The UPP for the client's event callack, or NULL for no event
;  *      callback
;  *    
;  *    inPreviewProc:
;  *      The UPP for the client's custom file preview callback, or NULL
;  *      for standard previews
;  *    
;  *    inFilterProc:
;  *      The UPP for the client's custom filter callback, or NULL for no
;  *      custom file filtering
;  *    
;  *    inClientData:
;  *      A client-defined context value passed to all callback functions
;  *    
;  *    outDialog:
;  *      Upon successful completion, a reference to the created dialog
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavCreateChooseFileDialog" 
   ((inOptions (:pointer :NavDialogCreationOptions));  can be NULL 
    (inTypeList (:Handle :NavTypeList))         ;  can be NULL 
    (inEventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (inPreviewProc (:pointer :OpaqueNavPreviewProcPtr));  can be NULL 
    (inFilterProc (:pointer :OpaqueNavObjectFilterProcPtr));  can be NULL 
    (inClientData :pointer)                     ;  can be NULL 
    (outDialog (:pointer :NavDialogRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NavCreateChooseFolderDialog()
;  *  
;  *  Summary:
;  *    Create a ChooseFolder dialog
;  *  
;  *  Discussion:
;  *    Use this function to create a dialog designed for selecting a
;  *    folder as the target of an operation. This function replaces
;  *    NavChooseFolder, allowing new window modalities, and adding
;  *    Unicode support. Upon successful creation, the dialog is not
;  *    visible. Present and run the dialog with NavDialogRun. After the
;  *    dialog is complete, dispose of it with NavDialogDispose.
;  *  
;  *  Parameters:
;  *    
;  *    inOptions:
;  *      Options controlling the appearance and behavior of the dialog
;  *    
;  *    inEventProc:
;  *      The UPP for the client's event callack, or NULL for no event
;  *      callback
;  *    
;  *    inFilterProc:
;  *      The UPP for the client's custom filter callback, or NULL for no
;  *      custom file filtering
;  *    
;  *    inClientData:
;  *      A client-defined context value passed to all callback functions
;  *    
;  *    outDialog:
;  *      Upon successful completion, a reference to the created dialog
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavCreateChooseFolderDialog" 
   ((inOptions (:pointer :NavDialogCreationOptions));  can be NULL 
    (inEventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (inFilterProc (:pointer :OpaqueNavObjectFilterProcPtr));  can be NULL 
    (inClientData :pointer)                     ;  can be NULL 
    (outDialog (:pointer :NavDialogRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NavCreateChooseVolumeDialog()
;  *  
;  *  Summary:
;  *    Create a ChooseVolume dialog
;  *  
;  *  Discussion:
;  *    Use this function to create a dialog designed for selecting a
;  *    volume as the target of an operation. This function replaces
;  *    NavChooseVolume, allowing new window modalities, and adding
;  *    Unicode support. Upon successful creation, the dialog is not
;  *    visible. Present and run the dialog with NavDialogRun. After the
;  *    dialog is complete, dispose of it with NavDialogDispose.
;  *  
;  *  Parameters:
;  *    
;  *    inOptions:
;  *      Options controlling the appearance and behavior of the dialog
;  *    
;  *    inEventProc:
;  *      The UPP for the client's event callack, or NULL for no event
;  *      callback
;  *    
;  *    inFilterProc:
;  *      The UPP for the client's custom filter callback, or NULL for no
;  *      custom file filtering
;  *    
;  *    inClientData:
;  *      A client-defined context value passed to all callback functions
;  *    
;  *    outDialog:
;  *      Upon successful completion, a reference to the created dialog
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavCreateChooseVolumeDialog" 
   ((inOptions (:pointer :NavDialogCreationOptions));  can be NULL 
    (inEventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (inFilterProc (:pointer :OpaqueNavObjectFilterProcPtr));  can be NULL 
    (inClientData :pointer)                     ;  can be NULL 
    (outDialog (:pointer :NavDialogRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NavCreateChooseObjectDialog()
;  *  
;  *  Summary:
;  *    Create a ChooseObject dialog
;  *  
;  *  Discussion:
;  *    Use this function to create a dialog designed for selecting a
;  *    file, folder, or volume as the target of an operation. This
;  *    function replaces NavChooseObject, allowing new window
;  *    modalities, and adding Unicode support. Upon successful creation,
;  *    the dialog is not visible. Present and run the dialog with
;  *    NavDialogRun. After the dialog is complete, dispose of it with
;  *    NavDialogDispose.
;  *  
;  *  Parameters:
;  *    
;  *    inOptions:
;  *      Options controlling the appearance and behavior of the dialog
;  *    
;  *    inEventProc:
;  *      The UPP for the client's event callack, or NULL for no event
;  *      callback
;  *    
;  *    inPreviewProc:
;  *      The UPP for the client's custom file preview callback, or NULL
;  *      for standard previews
;  *    
;  *    inFilterProc:
;  *      The UPP for the client's custom filter callback, or NULL for no
;  *      custom file filtering
;  *    
;  *    inClientData:
;  *      A client-defined context value passed to all callback functions
;  *    
;  *    outDialog:
;  *      Upon successful completion, a reference to the created dialog
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavCreateChooseObjectDialog" 
   ((inOptions (:pointer :NavDialogCreationOptions));  can be NULL 
    (inEventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (inPreviewProc (:pointer :OpaqueNavPreviewProcPtr));  can be NULL 
    (inFilterProc (:pointer :OpaqueNavObjectFilterProcPtr));  can be NULL 
    (inClientData :pointer)                     ;  can be NULL 
    (outDialog (:pointer :NavDialogRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NavCreateNewFolderDialog()
;  *  
;  *  Summary:
;  *    Create a NewFolder dialog
;  *  
;  *  Discussion:
;  *    Use this function to create a dialog designed for creating a new
;  *    folder. Nav Services creates the folder as specified by the user
;  *    and returns a reference to the folder in the selection field of
;  *    the reply record. This function replaces NavNewFolder, allowing
;  *    new window modalities, and adding Unicode support. Upon
;  *    successful creation, the dialog is not visible. Present and run
;  *    the dialog with NavDialogRun. After the dialog is complete,
;  *    dispose of it with NavDialogDispose.
;  *  
;  *  Parameters:
;  *    
;  *    inOptions:
;  *      Options controlling the appearance and behavior of the dialog
;  *    
;  *    inEventProc:
;  *      The UPP for the client's event callack, or NULL for no event
;  *      callback
;  *    
;  *    inClientData:
;  *      A client-defined context value passed to all callback functions
;  *    
;  *    outDialog:
;  *      Upon successful completion, a reference to the created dialog
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavCreateNewFolderDialog" 
   ((inOptions (:pointer :NavDialogCreationOptions));  can be NULL 
    (inEventProc (:pointer :OpaqueNavEventProcPtr));  can be NULL 
    (inClientData :pointer)                     ;  can be NULL 
    (outDialog (:pointer :NavDialogRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NavDialogRun()
;  *  
;  *  Summary:
;  *    Show and run a Nav Services dialog
;  *  
;  *  Discussion:
;  *    After a dialog is created with a NavCreate*Dialog function, the
;  *    client can modify the dialog target folder or save file name
;  *    using NavCustomControl with the appropriate selectors. The dialog
;  *    is presented to the user by calling NavDialogRun. If the dialog
;  *    is system modal or application modal (kWindowModalitySystemModal,
;  *    kWindowModalityAppModal), NavDialogRun does not return until the
;  *    dialog has been dismissed. If the dialog is modeless or window
;  *    modal (kWindowModalityNone, kWindowModalityWindowModal),
;  *    NavDialogRun shows the dialog and returns immediately. In order
;  *    to know when the dialog has been dismissed, the client must watch
;  *    for the kNavCBUserAction event sent to the client event proc.
;  *    Note that on Mac OS 9 and earlier, all dialogs are modal, even if
;  *    a modeless or window modal dialog is requested. However, the
;  *    kNavCBUserAction event is still sent to the event proc, so it's
;  *    possible to use a single programming model on OS 9 and OS X
;  *    provided the client assumes NavDialogRun returns immediately
;  *    after showing the dialog.
;  *  
;  *  Parameters:
;  *    
;  *    inDialog:
;  *      The dialog to run
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavDialogRun" 
   ((inDialog (:pointer :__NavDialog))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NavDialogDispose()
;  *  
;  *  Summary:
;  *    Dispose of a Nav Services dialog
;  *  
;  *  Discussion:
;  *    Call this function when completely finished with a Nav Services
;  *    dialog. After calling NavDialogDispose, the dialog reference is
;  *    no longer valid. NavDialogDispose is safe to call from within a
;  *    callback to the client's Nav Services event proc.
;  *  
;  *  Parameters:
;  *    
;  *    inDialog:
;  *      The dialog to dispose
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavDialogDispose" 
   ((inDialog (:pointer :__NavDialog))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NavDialogGetWindow()
;  *  
;  *  Summary:
;  *    Return the window in which a Nav Services dialog appears
;  *  
;  *  Discussion:
;  *    Note that a valid NavDialogRef may not have a window until
;  *    NavDialogRun has been called. If no window exists for the dialog,
;  *    NavDialogGetWindow returns NULL.
;  *  
;  *  Parameters:
;  *    
;  *    inDialog:
;  *      Which dialog
;  *  
;  *  Result:
;  *    The window reference
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavDialogGetWindow" 
   ((inDialog (:pointer :__NavDialog))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWindowPtr)
() )
; 
;  *  NavDialogGetUserAction()
;  *  
;  *  Summary:
;  *    Return the current user action taken by the user
;  *  
;  *  Discussion:
;  *    A user action occurs when the user dismisses the dialog or
;  *    otherwise does something generating a reply record that the
;  *    client needs to act upon. If the user has not taken such an
;  *    action, NavDialogGetUserAction returns kNavUserActionNone. If the
;  *    dialog is terminated using the NavCustomControl selector
;  *    kNavCtlTerminate, the final user action is kNavUserActionNone.
;  *    For file dialogs, if the final user action is not
;  *    kNavUserActionCancel, then there is a valid reply record which
;  *    can be obtained with NavDialogGetReply. Although the user action
;  *    is sent to the client event proc as a kNavCBUserAction event,
;  *    this function is provided as a convenience for clients of modal
;  *    dialogs who may find it easier to get the user action immediately
;  *    after NavDialogRun returns.
;  *  
;  *  Parameters:
;  *    
;  *    inDialog:
;  *      Which dialog
;  *  
;  *  Result:
;  *    The user action
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavDialogGetUserAction" 
   ((inDialog (:pointer :__NavDialog))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  NavDialogGetReply()
;  *  
;  *  Summary:
;  *    Fill in the provided reply record with the results of a user
;  *    action such as kNavUserActionOpen, kNavUserActionSaveAs, or
;  *    kNavUserActionChoose.
;  *  
;  *  Discussion:
;  *    Call this function when a file dialog receives a user action
;  *    other that implies an item or items to open, save, etc. Upon
;  *    successful completion, the reply record describes the item(s)
;  *    that the client needs to act upon. The reply record should later
;  *    be disposed of with NavDisposeReply.
;  *  
;  *  Parameters:
;  *    
;  *    inDialog:
;  *      Which dialog
;  *    
;  *    outReply:
;  *      A pointer to the client-allocated reply record to be filled in
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavDialogGetReply" 
   ((inDialog (:pointer :__NavDialog))
    (outReply (:pointer :NavReplyRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NavDialogGetSaveFileName()
;  *  
;  *  Summary:
;  *    Return the current value of the file name to be saved in a
;  *    PutFile dialog
;  *  
;  *  Discussion:
;  *    This function can be called at any time on a valid PutFile dialog
;  *    to obtain the current value of the save file name. This function
;  *    is a Unicode-based replacement for the kNavCtlGetEditFileName
;  *    NavCustomControl selector. On Mac OS X, the full file name is
;  *    returned, including any extenison that may be hidden from the
;  *    user.
;  *  
;  *  Parameters:
;  *    
;  *    inPutFileDialog:
;  *      Which dialog
;  *  
;  *  Result:
;  *    The save file name as a CFStringRef. The string is immutable. The
;  *    client should retain the string if the reference is to be held
;  *    beyond the life of the dialog (standard CF retain/release
;  *    semantics).
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavDialogGetSaveFileName" 
   ((inPutFileDialog (:pointer :__NavDialog))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :__CFString)
() )
; 
;  *  NavDialogSetSaveFileName()
;  *  
;  *  Summary:
;  *    Set the current value of the file name to be saved in a PutFile
;  *    dialog
;  *  
;  *  Discussion:
;  *    This function can be called at any time to set the current save
;  *    file name. Use it to set an initial name before calling
;  *    NavDialogRun or to change the file name dynamically while a
;  *    dialog is running. This function is a Unicode-based replacement
;  *    for the kNavCtlSetEditFileName NavCustomControl selector.
;  *  
;  *  Parameters:
;  *    
;  *    inPutFileDialog:
;  *      Which PutFile dialog
;  *    
;  *    inFileName:
;  *      The file name to use. A copy of the provided string is made for
;  *      use by Navigation Services.
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavDialogSetSaveFileName" 
   ((inPutFileDialog (:pointer :__NavDialog))
    (inFileName (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  NavDialogGetSaveFileExtensionHidden()
;  *  
;  *  Summary:
;  *    Get the current state of the extension hiding in a PutFile dialog
;  *  
;  *  Discussion:
;  *    This function can be called at any time to determine if a PutFile
;  *    dialog is hiding the file extesion (if any) of the file to be
;  *    saved.
;  *  
;  *  Parameters:
;  *    
;  *    inPutFileDialog:
;  *      Which PutFile dialog
;  *  
;  *  Result:
;  *    True if the extension is hidden, false if the extension is
;  *    visible or there is no extension.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavDialogGetSaveFileExtensionHidden" 
   ((inPutFileDialog (:pointer :__NavDialog))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Boolean
() )
; 
;  *  NavDialogSetSaveFileExtensionHidden()
;  *  
;  *  Summary:
;  *    Set the current state of the extension hiding in a PutFile dialog
;  *  
;  *  Discussion:
;  *    This function can be called at any time to hide or show the
;  *    extension of the file to be saved in a PutFile dialog. If the
;  *    current file name has no extension, then hiding the extension has
;  *    no effect.
;  *  
;  *  Parameters:
;  *    
;  *    inPutFileDialog:
;  *      Which PutFile dialog
;  *    
;  *    inHidden:
;  *      The new value for the hidden extension state
;  *  
;  *  Result:
;  *    A status code
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NavDialogSetSaveFileExtensionHidden" 
   ((inPutFileDialog (:pointer :__NavDialog))
    (inHidden :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __NAVIGATION__ */


(provide-interface "Navigation")