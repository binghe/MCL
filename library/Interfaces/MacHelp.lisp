(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:MacHelp.h"
; at Sunday July 2,2006 7:25:03 pm.
; 
;      File:       HIToolbox/MacHelp.h
;  
;      Contains:   Macintosh Help Package Interfaces.
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1998-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __MACHELP__
; #define __MACHELP__
; #ifndef __CONTROLS__
#| #|
#include <HIToolboxControls.h>
#endif
|#
 |#
; #ifndef __DIALOGS__
#| #|
#include <HIToolboxDialogs.h>
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
; #ifndef __MENUS__
#| #|
#include <HIToolboxMenus.h>
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
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Help Manager constants, etc.                                                     
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kMacHelpVersion 3)
;  Resource ID and menu ID of help menu 

(defconstant $kHMHelpMenuID -16490)

(def-mactype :HMContentRequest (find-mactype ':SInt16))

(defconstant $kHMSupplyContent 0)
(defconstant $kHMDisposeContent 1)

(def-mactype :HMContentType (find-mactype ':UInt32))

(defconstant $kHMNoContent :|none|)
(defconstant $kHMCFStringContent :|cfst|)       ;  CFStringRef

(defconstant $kHMCFStringLocalizedContent :|cfsl|);  CFStringRef; name of a localized string. Supported by Jaguar and later.

(defconstant $kHMPascalStrContent :|pstr|)
(defconstant $kHMStringResContent :|str#|)
(defconstant $kHMTEHandleContent :|txth|)       ;  Supported by CarbonLib and Jaguar and later

(defconstant $kHMTextResContent :|text|)        ;  Supported by CarbonLib and Jaguar and later

(defconstant $kHMStrResContent :|str |)
; 
;  *  HMTagDisplaySide
;  *  
;  *  Discussion:
;  *    Help tag display locations relative to absolute hot rect
;  

(def-mactype :HMTagDisplaySide (find-mactype ':SInt16))
; 
;    * System default location
;    

(defconstant $kHMDefaultSide 0)
; 
;    * Above, aligned with left or right depending on system script
;    

(defconstant $kHMOutsideTopScriptAligned 1)
; 
;    * To the left, centered vertically
;    

(defconstant $kHMOutsideLeftCenterAligned 2)
(defconstant $kHMOutsideBottomScriptAligned 3)
; 
;    * To the right, centered vertically
;    

(defconstant $kHMOutsideRightCenterAligned 4)
; 
;    * Above, aligned with left
;    

(defconstant $kHMOutsideTopLeftAligned 5)
; 
;    * Above, aligned with right
;    

(defconstant $kHMOutsideTopRightAligned 6)
; 
;    * To the left, aligned with top
;    

(defconstant $kHMOutsideLeftTopAligned 7)
; 
;    * To the left, aligned with bottom
;    

(defconstant $kHMOutsideLeftBottomAligned 8)
; 
;    * To the right, aligned with top
;    

(defconstant $kHMOutsideBottomLeftAligned 9)
; 
;    * To the right, aligned with bottom
;    

(defconstant $kHMOutsideBottomRightAligned 10)
(defconstant $kHMOutsideRightTopAligned 11)
(defconstant $kHMOutsideRightBottomAligned 12)
; 
;    * Above, centered horizontally
;    

(defconstant $kHMOutsideTopCenterAligned 13)
; 
;    * Below, centered horizontally
;    

(defconstant $kHMOutsideBottomCenterAligned 14)
; 
;    * Inside, aligned with right, centered vertically
;    

(defconstant $kHMInsideRightCenterAligned 15)
; 
;    * Inside, aligned with left, centered vertically
;    

(defconstant $kHMInsideLeftCenterAligned 16)
; 
;    * Inside, aligned with bottom, centered horizontally
;    

(defconstant $kHMInsideBottomCenterAligned 17)
; 
;    * Inside, aligned with top, centered horizontally
;    

(defconstant $kHMInsideTopCenterAligned 18)
; 
;    * Inside, aligned with top and left
;    

(defconstant $kHMInsideTopLeftCorner 19)
; 
;    * Inside, aligned with top and right
;    

(defconstant $kHMInsideTopRightCorner 20)
; 
;    * Inside, aligned with bottom and left
;    

(defconstant $kHMInsideBottomLeftCorner 21)
; 
;    * Inside, aligned with bottom and right
;    

(defconstant $kHMInsideBottomRightCorner 22)
; 
;    * Centered vertically and horizontally
;    

(defconstant $kHMAbsoluteCenterAligned 23)
;  Obsoleted constants HMTagDisplaySides, use the new ones, please 

(defconstant $kHMTopSide 1)
(defconstant $kHMLeftSide 2)
(defconstant $kHMBottomSide 3)
(defconstant $kHMRightSide 4)
(defconstant $kHMTopLeftCorner 5)
(defconstant $kHMTopRightCorner 6)
(defconstant $kHMLeftTopCorner 7)
(defconstant $kHMLeftBottomCorner 8)
(defconstant $kHMBottomLeftCorner 9)
(defconstant $kHMBottomRightCorner 10)
(defconstant $kHMRightTopCorner 11)
(defconstant $kHMRightBottomCorner 12)

(def-mactype :HMContentProvidedType (find-mactype ':SInt16))

(defconstant $kHMContentProvided 0)
(defconstant $kHMContentNotProvided 1)
(defconstant $kHMContentNotProvidedDontPropagate 2)

(defconstant $kHMMinimumContentIndex 0)         ;  first entry in HMHelpContentRec.content is the minimum content 

(defconstant $kHMMaximumContentIndex 1)         ;  second entry in HMHelpContentRec.content is the maximum content 


(defconstant $errHMIllegalContentForMinimumState -10980);  unrecognized content type for minimum content 
;  unrecognized content type for maximum content 

(defconstant $errHMIllegalContentForMaximumState -10981)
;  obsolete names; will be removed

(defconstant $kHMIllegalContentForMinimumState -10980)

(defconstant $kHelpTagEventHandlerTag :|hevt|)
(defrecord HMStringResType
   (hmmResID :SInt16)
   (hmmIndex :SInt16)
)

;type name? (%define-record :HMStringResType (find-record-descriptor ':HMStringResType))
(defrecord HMHelpContent
   (contentType :UInt32)
   (:variant
   (
   (tagCFString (:pointer :__CFString))
   )
                                                ;  CFStringRef
   (
   (tagString (:string 255))
   )
                                                ;  Pascal String
   (
   (tagStringRes :HMStringResType)
   )
                                                ;  STR# resource ID and index
   (
   (tagTEHandle :Handle)
   )
                                                ;  TextEdit handle (NOT SUPPORTED ON MAC OS X)
   (
   (tagTextRes :SInt16)
   )
                                                ;  TEXT/styl resource ID (NOT SUPPORTED ON MAC OS X)
   (
   (tagStrRes :SInt16)
   )
                                                ;  STR resource ID
   )
)

;type name? (%define-record :HMHelpContent (find-record-descriptor ':HMHelpContent))
(defrecord HMHelpContentRec
   (version :SInt32)
   (absHotRect :Rect)
   (tagSide :SInt16)
   (content (:array :HMHelpContent 2))
)

;type name? (%define-record :HMHelpContentRec (find-record-descriptor ':HMHelpContentRec))

(def-mactype :HMHelpContentPtr (find-mactype '(:pointer :HMHelpContentRec)))
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Callback procs                                       
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ 

(def-mactype :HMControlContentProcPtr (find-mactype ':pointer)); (ControlRef inControl , Point inGlobalMouse , HMContentRequest inRequest , HMContentProvidedType * outContentProvided , HMHelpContentPtr ioHelpContent)

(def-mactype :HMWindowContentProcPtr (find-mactype ':pointer)); (WindowRef inWindow , Point inGlobalMouse , HMContentRequest inRequest , HMContentProvidedType * outContentProvided , HMHelpContentPtr ioHelpContent)

(def-mactype :HMMenuTitleContentProcPtr (find-mactype ':pointer)); (MenuRef inMenu , HMContentRequest inRequest , HMContentProvidedType * outContentProvided , HMHelpContentPtr ioHelpContent)

(def-mactype :HMMenuItemContentProcPtr (find-mactype ':pointer)); (const MenuTrackingData * inTrackingData , HMContentRequest inRequest , HMContentProvidedType * outContentProvided , HMHelpContentPtr ioHelpContent)

(def-mactype :HMControlContentUPP (find-mactype '(:pointer :OpaqueHMControlContentProcPtr)))

(def-mactype :HMWindowContentUPP (find-mactype '(:pointer :OpaqueHMWindowContentProcPtr)))

(def-mactype :HMMenuTitleContentUPP (find-mactype '(:pointer :OpaqueHMMenuTitleContentProcPtr)))

(def-mactype :HMMenuItemContentUPP (find-mactype '(:pointer :OpaqueHMMenuItemContentProcPtr)))
; 
;  *  NewHMControlContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewHMControlContentUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueHMControlContentProcPtr)
() )
; 
;  *  NewHMWindowContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewHMWindowContentUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueHMWindowContentProcPtr)
() )
; 
;  *  NewHMMenuTitleContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewHMMenuTitleContentUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueHMMenuTitleContentProcPtr)
() )
; 
;  *  NewHMMenuItemContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewHMMenuItemContentUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueHMMenuItemContentProcPtr)
() )
; 
;  *  DisposeHMControlContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeHMControlContentUPP" 
   ((userUPP (:pointer :OpaqueHMControlContentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeHMWindowContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeHMWindowContentUPP" 
   ((userUPP (:pointer :OpaqueHMWindowContentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeHMMenuTitleContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeHMMenuTitleContentUPP" 
   ((userUPP (:pointer :OpaqueHMMenuTitleContentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeHMMenuItemContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeHMMenuItemContentUPP" 
   ((userUPP (:pointer :OpaqueHMMenuItemContentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeHMControlContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeHMControlContentUPP" 
   ((inControl (:pointer :OpaqueControlRef))
    (inGlobalMouse :Point)
    (inRequest :SInt16)
    (outContentProvided (:pointer :HMCONTENTPROVIDEDTYPE))
    (ioHelpContent (:pointer :HMHelpContentRec))
    (userUPP (:pointer :OpaqueHMControlContentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  InvokeHMWindowContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeHMWindowContentUPP" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inGlobalMouse :Point)
    (inRequest :SInt16)
    (outContentProvided (:pointer :HMCONTENTPROVIDEDTYPE))
    (ioHelpContent (:pointer :HMHelpContentRec))
    (userUPP (:pointer :OpaqueHMWindowContentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  InvokeHMMenuTitleContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeHMMenuTitleContentUPP" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inRequest :SInt16)
    (outContentProvided (:pointer :HMCONTENTPROVIDEDTYPE))
    (ioHelpContent (:pointer :HMHelpContentRec))
    (userUPP (:pointer :OpaqueHMMenuTitleContentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  InvokeHMMenuItemContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeHMMenuItemContentUPP" 
   ((inTrackingData (:pointer :MenuTrackingData))
    (inRequest :SInt16)
    (outContentProvided (:pointer :HMCONTENTPROVIDEDTYPE))
    (ioHelpContent (:pointer :HMHelpContentRec))
    (userUPP (:pointer :OpaqueHMMenuItemContentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  API                                                                                      
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Help Menu 
; 
;  *  HMGetHelpMenu()
;  *  
;  *  Summary:
;  *    Returns a menu to which applications may add their own help items.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    outHelpMenu:
;  *      On exit, contains the help menu.
;  *    
;  *    outFirstCustomItemIndex:
;  *      On exit, contains the menu item index that will be used by the
;  *      first item added by the application. This parameter may be NULL.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMGetHelpMenu" 
   ((outHelpMenu (:pointer :MenuRef))
    (outFirstCustomItemIndex (:pointer :MENUITEMINDEX));  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Installing/Retrieving Content 
;  Menu title and item help tags are not supported by CarbonLib. They are fully supported on Mac OS X. 
;  Pass NULL for the inContent parameter of HMSetControl/Window/MenuItemHelpContent to remove help content
;        from a control, window, or menu. 
; 
;  *  HMSetControlHelpContent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMSetControlHelpContent" 
   ((inControl (:pointer :OpaqueControlRef))
    (inContent (:pointer :HMHelpContentRec))    ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMGetControlHelpContent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMGetControlHelpContent" 
   ((inControl (:pointer :OpaqueControlRef))
    (outContent (:pointer :HMHelpContentRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMSetWindowHelpContent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMSetWindowHelpContent" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inContent (:pointer :HMHelpContentRec))    ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMGetWindowHelpContent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMGetWindowHelpContent" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outContent (:pointer :HMHelpContentRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMSetMenuItemHelpContent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMSetMenuItemHelpContent" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :UInt16)
    (inContent (:pointer :HMHelpContentRec))    ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMGetMenuItemHelpContent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMGetMenuItemHelpContent" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inItem :UInt16)
    (outContent (:pointer :HMHelpContentRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Installing/Retrieving Content Callbacks 
; 
;  *  HMInstallControlContentCallback()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMInstallControlContentCallback" 
   ((inControl (:pointer :OpaqueControlRef))
    (inContentUPP (:pointer :OpaqueHMControlContentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMInstallWindowContentCallback()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMInstallWindowContentCallback" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inContentUPP (:pointer :OpaqueHMWindowContentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMInstallMenuTitleContentCallback()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMInstallMenuTitleContentCallback" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inContentUPP (:pointer :OpaqueHMMenuTitleContentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMInstallMenuItemContentCallback()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMInstallMenuItemContentCallback" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inContentUPP (:pointer :OpaqueHMMenuItemContentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMGetControlContentCallback()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMGetControlContentCallback" 
   ((inControl (:pointer :OpaqueControlRef))
    (outContentUPP (:pointer :HMCONTROLCONTENTUPP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMGetWindowContentCallback()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMGetWindowContentCallback" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (outContentUPP (:pointer :HMWINDOWCONTENTUPP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMGetMenuTitleContentCallback()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMGetMenuTitleContentCallback" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (outContentUPP (:pointer :HMMENUTITLECONTENTUPP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMGetMenuItemContentCallback()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMGetMenuItemContentCallback" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (outContentUPP (:pointer :HMMENUITEMCONTENTUPP))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Enabling and Disabling Help Tags 
; 
;  *  HMAreHelpTagsDisplayed()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMAreHelpTagsDisplayed" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  HMSetHelpTagsDisplayed()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMSetHelpTagsDisplayed" 
   ((inDisplayTags :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMSetTagDelay()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMSetTagDelay" 
   ((inDelay :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMGetTagDelay()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMGetTagDelay" 
   ((outDelay (:pointer :DURATION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Compatibility 
; 
;  *  HMSetMenuHelpFromBalloonRsrc()
;  *  
;  *  Summary:
;  *    Not really implemented.
;  *  
;  *  Discussion:
;  *    Though this API is exported from CarbonLib and Mac OS X, it is
;  *    completely non-functional. We have no plans to implement it.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMSetMenuHelpFromBalloonRsrc" 
   ((inMenu (:pointer :OpaqueMenuRef))
    (inHmnuRsrcID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMSetDialogHelpFromBalloonRsrc()
;  *  
;  *  Summary:
;  *    Not really implemented.
;  *  
;  *  Discussion:
;  *    Though this API is exported from CarbonLib and Mac OS X, it is
;  *    completely non-functional. We have no plans to implement it.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMSetDialogHelpFromBalloonRsrc" 
   ((inDialog (:pointer :OpaqueDialogPtr))
    (inHdlgRsrcID :SInt16)
    (inItemStart :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Displaying tags 
; 
;  *  HMDisplayTag()
;  *  
;  *  Summary:
;  *    Displays a help tag at a user defined location.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inContent:
;  *      HMHelpContentRec describing the help tag to be displayed.
;  *  
;  *  Result:
;  *    An OSStatus code indicating success or failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMDisplayTag" 
   ((inContent (:pointer :HMHelpContentRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  HMHideTag()
;  *  
;  *  Summary:
;  *    HMHideTag hides the currently visible help tag.  If there is no
;  *    current help tag, this call does nothing.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Result:
;  *    An OSStatus code indicating success or failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HMHideTag" 
   (
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

; #endif /* __MACHELP__ */


(provide-interface "MacHelp")