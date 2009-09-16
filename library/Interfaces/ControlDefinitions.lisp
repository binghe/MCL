(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ControlDefinitions.h"
; at Sunday July 2,2006 7:25:03 pm.
; 
;      File:       HIToolbox/ControlDefinitions.h
;  
;      Contains:   Definitions of controls provided by the Control Manager
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1999-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __CONTROLDEFINITIONS__
; #define __CONTROLDEFINITIONS__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __APPEARANCE__
#| #|
#include <HIToolboxAppearance.h>
#endif
|#
 |#
; #ifndef __CARBONEVENTS__
#| #|
#include <HIToolboxCarbonEvents.h>
#endif
|#
 |#
; #ifndef __CONTROLS__
#| #|
#include <HIToolboxControls.h>
#endif
|#
 |#
; #ifndef __LISTS__
#| #|
#include <HIToolboxLists.h>
#endif
|#
 |#
; #ifndef __MACHELP__
#| #|
#include <HIToolboxMacHelp.h>
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
; 
;  *  ControlDefinitions.h
;  *  
;  *  Discussion:
;  *    System software supplies a variety of controls for your
;  *    applications to use. They are described herein.
;  
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ Resource Types                                                                                    
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kControlTabListResType :|tab#|)   ;  used for tab control (Appearance 1.0 and later)

(defconstant $kControlListDescResType :|ldes|)  ;  used for list box control (Appearance 1.0 and later)

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ Check Box Values                                                                  
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kControlCheckBoxUncheckedValue 0)
(defconstant $kControlCheckBoxCheckedValue 1)
(defconstant $kControlCheckBoxMixedValue 2)
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ Radio Button Values                                                               
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kControlRadioButtonUncheckedValue 0)
(defconstant $kControlRadioButtonCheckedValue 1)
(defconstant $kControlRadioButtonMixedValue 2)
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ Pop-Up Menu Control Constants                                                     
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Variant codes for the System 7 pop-up menu

(defconstant $popupFixedWidth 1)
(defconstant $popupVariableWidth 2)
(defconstant $popupUseAddResMenu 4)
(defconstant $popupUseWFont 8)
;  Menu label styles for the System 7 pop-up menu

(defconstant $popupTitleBold #x100)
(defconstant $popupTitleItalic #x200)
(defconstant $popupTitleUnderline #x400)
(defconstant $popupTitleOutline #x800)
(defconstant $popupTitleShadow #x1000)
(defconstant $popupTitleCondense #x2000)
(defconstant $popupTitleExtend #x4000)
(defconstant $popupTitleNoStyle #x8000)
;  Menu label justifications for the System 7 pop-up menu

(defconstant $popupTitleLeftJust 0)
(defconstant $popupTitleCenterJust 1)
(defconstant $popupTitleRightJust #xFF)
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ PopUp Menu Private Data Structure                                                                 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
(defrecord PopupPrivateData
   (mHandle (:pointer :OpaqueMenuRef))
   (mID :SInt16)
)

;type name? (def-mactype :PopupPrivateData (find-mactype ':PopupPrivateData))

(def-mactype :PopupPrivateDataPtr (find-mactype '(:pointer :PopupPrivateData)))

(def-mactype :PopupPrivateDataHandle (find-mactype '(:pointer :PopupPrivateDataPtr)))
 |#

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ Control Definition IDÕs                                                                           
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Standard System 7 procIDs

(defconstant $pushButProc 0)
(defconstant $checkBoxProc 1)
(defconstant $radioButProc 2)
(defconstant $scrollBarProc 16)
(defconstant $popupMenuProc #x3F0)
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ Control Part Codes                                                                
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kControlLabelPart 1)
(defconstant $kControlMenuPart 2)
(defconstant $kControlTrianglePart 4)
(defconstant $kControlEditTextPart 5)           ;  Appearance 1.0 and later

(defconstant $kControlPicturePart 6)            ;  Appearance 1.0 and later

(defconstant $kControlIconPart 7)               ;  Appearance 1.0 and later

(defconstant $kControlClockPart 8)              ;  Appearance 1.0 and later

(defconstant $kControlListBoxPart 24)           ;  Appearance 1.0 and later

(defconstant $kControlListBoxDoubleClickPart 25);  Appearance 1.0 and later

(defconstant $kControlImageWellPart 26)         ;  Appearance 1.0 and later

(defconstant $kControlRadioGroupPart 27)        ;  Appearance 1.0.2 and later

(defconstant $kControlButtonPart 10)
(defconstant $kControlCheckBoxPart 11)
(defconstant $kControlRadioButtonPart 11)
(defconstant $kControlUpButtonPart 20)
(defconstant $kControlDownButtonPart 21)
(defconstant $kControlPageUpPart 22)
(defconstant $kControlPageDownPart 23)
(defconstant $kControlClockHourDayPart 9)       ;  Appearance 1.1 and later

(defconstant $kControlClockMinuteMonthPart 10)  ;  Appearance 1.1 and later

(defconstant $kControlClockSecondYearPart 11)   ;  Appearance 1.1 and later

(defconstant $kControlClockAMPMPart 12)         ;  Appearance 1.1 and later

(defconstant $kControlDataBrowserPart 24)       ;  CarbonLib 1.0 and later

(defconstant $kControlDataBrowserDraggedPart 25);  CarbonLib 1.0 and later

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ Control Types and IDÕs available only with Appearance 1.0 and later                               
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ BEVEL BUTTON INTERFACE (CDEF 2)                                                   
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   Bevel buttons allow you to control the content type (pict/icon/etc.), the behavior  
;  (pushbutton/toggle/sticky), and the bevel size. You also have the option of          
;   attaching a menu to it. When a menu is present, you can specify which way the       
;   popup arrow is facing (down or right).                                              
;                                                                                       
;   This is all made possible by overloading the Min, Max, and Value parameters for the 
;   control, as well as adjusting the variant. Here's the breakdown of what goes where: 
;                                                                                       
;   Parameter                   What Goes Here                                          
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ         ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ    
;   Min                         Hi Byte = Behavior, Lo Byte = content type.             
;   Max                         ResID for resource-based content types.                 
;   Value                       MenuID to attach, 0 = no menu, please.                  
;                                                                                       
;   The variant is broken down into two halfs. The low 2 bits control the bevel type.   
;   Bit 2 controls the popup arrow direction (if a menu is present) and bit 3 controls  
;   whether or not to use the control's owning window's font.                           
;                                                                                       
;   Constants for all you need to put this together are below. The values for behaviors 
;   are set up so that you can simply add them to the content type and pass them into   
;   the Min parameter of NewControl.                                                    
;                                                                                       
;   An example call:                                                                    
;                                                                                       
;   control = NewControl( window, &bounds, "\p", true, 0, kControlContentIconSuiteRes + 
;                           kBehaviorToggles, myIconSuiteID, bevelButtonSmallBevelProc, 
;                           0L );                                                       
;                                                                                       
;   Attaching a menu:                                                                   
;                                                                                       
;   control = NewControl( window, &bounds, "\p", true, kMyMenuID,                       
;           kControlContentIconSuiteRes, myIconSuiteID, bevelButtonSmallBevelProc +     
;           kBevelButtonMenuOnRight, 0L );                                              
;                                                                                       
;   This will attach menu ID kMyMenuID to the button, with the popup arrow facing right.
;   This also puts the menu up to the right of the button. You can also specify that a  
;   menu can have multiple items checked at once by adding kBehaviorMultiValueMenus     
;   into the Min parameter. If you do use multivalue menus, the GetBevelButtonMenuValue 
;   helper function will return the last item chosen from the menu, whether or not it   
;   was checked.                                                                        
;                                                                                       
;   NOTE:   Bevel buttons with menus actually have *two* values. The value of the       
;           button (on/off), and the value of the menu. The menu value can be gotten    
;           with the GetBevelButtonMenuValue helper function.                           
;                                                                                       
;   Handle-based Content                                                                
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ                                                                
;   You can create your control and then set the content to an existing handle to an    
;   icon suite, etc. using the macros below. Please keep in mind that resource-based    
;   content is owned by the control, handle-based content is owned by you. The CDEF will
;   not try to dispose of handle-based content. If you are changing the content type of 
;   the button on the fly, you must make sure that if you are replacing a handle-       
;   based content with a resource-based content to properly dispose of the handle,      
;   else a memory leak will ensue.                                                      
;                                                                                       
;   Textual Content                                                                     
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ                                                                
;   Please note that if a bevel button gets its textual content from the title          
;   of the control. To alter the textual content of a bevel button, use the             
;   SetControlTitle[WithCFString] API.                                                  
;                                                                                       
;  Bevel Button Proc IDs 

(defconstant $kControlBevelButtonSmallBevelProc 32)
(defconstant $kControlBevelButtonNormalBevelProc 33)
(defconstant $kControlBevelButtonLargeBevelProc 34)
;  Add these variant codes to kBevelButtonSmallBevelProc to change the type of button 

(defconstant $kControlBevelButtonSmallBevelVariant 0)
(defconstant $kControlBevelButtonNormalBevelVariant 1)
(defconstant $kControlBevelButtonLargeBevelVariant 2)
(defconstant $kControlBevelButtonMenuOnRightVariant 4)
;  Bevel Thicknesses 

(def-mactype :ControlBevelThickness (find-mactype ':UInt16))

(defconstant $kControlBevelButtonSmallBevel 0)
(defconstant $kControlBevelButtonNormalBevel 1)
(defconstant $kControlBevelButtonLargeBevel 2)
;  Behaviors of bevel buttons. These are set up so you can add  
;  them together with the content types.                        

(defconstant $kControlBehaviorPushbutton 0)
(defconstant $kControlBehaviorToggles #x100)
(defconstant $kControlBehaviorSticky #x200)
(defconstant $kControlBehaviorSingleValueMenu 0)
(defconstant $kControlBehaviorMultiValueMenu #x4000);  only makes sense when a menu is attached.

(defconstant $kControlBehaviorOffsetContents #x8000)
;  Behaviors for 1.0.1 or later 

(defconstant $kControlBehaviorCommandMenu #x2000);  menu holds commands, not choices. Overrides multi-value bit.


(def-mactype :ControlBevelButtonBehavior (find-mactype ':UInt16))

(def-mactype :ControlBevelButtonMenuBehavior (find-mactype ':UInt16))
;  Bevel Button Menu Placements 

(def-mactype :ControlBevelButtonMenuPlacement (find-mactype ':UInt16))

(defconstant $kControlBevelButtonMenuOnBottom 0)
(defconstant $kControlBevelButtonMenuOnRight 4)
;  Control Kind Tag 

(defconstant $kControlKindBevelButton :|bevl|)
;  The HIObject class ID for the HIBevelButton class. 
; #define kHIBevelButtonClassID           CFSTR("com.apple.HIBevelButton")
;  Creation API: Carbon Only 
; 
;  *  CreateBevelButtonControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateBevelButtonControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (title (:pointer :__CFString))
    (thickness :UInt16)
    (behavior :UInt16)
    (info (:pointer :ControlButtonContentInfo))
    (menuID :SInt16)
    (menuBehavior :UInt16)
    (menuPlacement :UInt16)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Graphic Alignments 

(def-mactype :ControlButtonGraphicAlignment (find-mactype ':SInt16))

(defconstant $kControlBevelButtonAlignSysDirection -1);  only left or right

(defconstant $kControlBevelButtonAlignCenter 0)
(defconstant $kControlBevelButtonAlignLeft 1)
(defconstant $kControlBevelButtonAlignRight 2)
(defconstant $kControlBevelButtonAlignTop 3)
(defconstant $kControlBevelButtonAlignBottom 4)
(defconstant $kControlBevelButtonAlignTopLeft 5)
(defconstant $kControlBevelButtonAlignBottomLeft 6)
(defconstant $kControlBevelButtonAlignTopRight 7)
(defconstant $kControlBevelButtonAlignBottomRight 8)
;  Text Alignments 

(def-mactype :ControlButtonTextAlignment (find-mactype ':SInt16))

(defconstant $kControlBevelButtonAlignTextSysDirection 0)
(defconstant $kControlBevelButtonAlignTextCenter 1)
(defconstant $kControlBevelButtonAlignTextFlushRight -1)
(defconstant $kControlBevelButtonAlignTextFlushLeft -2)
;  Text Placements 

(def-mactype :ControlButtonTextPlacement (find-mactype ':SInt16))

(defconstant $kControlBevelButtonPlaceSysDirection -1);  if graphic on right, then on left

(defconstant $kControlBevelButtonPlaceNormally 0)
(defconstant $kControlBevelButtonPlaceToRightOfGraphic 1)
(defconstant $kControlBevelButtonPlaceToLeftOfGraphic 2)
(defconstant $kControlBevelButtonPlaceBelowGraphic 3)
(defconstant $kControlBevelButtonPlaceAboveGraphic 4)
;  Data tags supported by the bevel button controls 

(defconstant $kControlBevelButtonContentTag :|cont|);  ButtonContentInfo

(defconstant $kControlBevelButtonTransformTag :|tran|);  IconTransformType

(defconstant $kControlBevelButtonTextAlignTag :|tali|);  ButtonTextAlignment

(defconstant $kControlBevelButtonTextOffsetTag :|toff|);  SInt16

(defconstant $kControlBevelButtonGraphicAlignTag :|gali|);  ButtonGraphicAlignment

(defconstant $kControlBevelButtonGraphicOffsetTag :|goff|);  Point

(defconstant $kControlBevelButtonTextPlaceTag :|tplc|);  ButtonTextPlacement

(defconstant $kControlBevelButtonMenuValueTag :|mval|);  SInt16

(defconstant $kControlBevelButtonMenuHandleTag :|mhnd|);  MenuRef

(defconstant $kControlBevelButtonMenuRefTag :|mhnd|);  MenuRef

(defconstant $kControlBevelButtonCenterPopupGlyphTag :|pglc|);  Boolean: true = center, false = bottom right

;  These are tags in 1.0.1 or later 

(defconstant $kControlBevelButtonLastMenuTag :|lmnu|);  SInt16: menuID of last menu item selected from

(defconstant $kControlBevelButtonMenuDelayTag :|mdly|);  SInt32: ticks to delay before menu appears

;  tags available with Appearance 1.1 or later 
;  Boolean: True = if an icon of the ideal size for
;  the button isn't available, scale a larger or
;  smaller icon to the ideal size. False = don't
;  scale; draw a smaller icon or clip a larger icon.
;  Default is false. Only applies to IconSuites and

(defconstant $kControlBevelButtonScaleIconTag :|scal|);  IconRefs.

;  tags available in Mac OS X and later 

(defconstant $kControlBevelButtonOwnedMenuRefTag :|omrf|);  MenuRef (control will dispose)

(defconstant $kControlBevelButtonKindTag :|bebk|);  ThemeButtonKind ( kTheme[Small,Medium,Large,Rounded]BevelButton )

; 
;  *  Summary:
;  *    Tags available with Mac OS X 10.3 or later
;  
; 
;    * Passed data is an Boolean.  Gets or sets whether or not the
;    * associated menu is a multi-value menu or not.  True means that the
;    * menu can have multiple selections.
;    

(defconstant $kControlBevelButtonIsMultiValueMenuTag :|mult|)
;  Helper routines are available only thru the shared library/glue. 
; 
;  *  GetBevelButtonMenuValue()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetBevelButtonMenuValue" 
   ((inButton (:pointer :OpaqueControlRef))
    (outValue (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetBevelButtonMenuValue()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetBevelButtonMenuValue" 
   ((inButton (:pointer :OpaqueControlRef))
    (inValue :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetBevelButtonMenuHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetBevelButtonMenuHandle" 
   ((inButton (:pointer :OpaqueControlRef))
    (outHandle (:pointer :MENUHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; #define GetBevelButtonMenuRef GetBevelButtonMenuHandle
; 
;  *  GetBevelButtonContentInfo()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetBevelButtonContentInfo" 
   ((inButton (:pointer :OpaqueControlRef))
    (outContent (:pointer :ControlButtonContentInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetBevelButtonContentInfo()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetBevelButtonContentInfo" 
   ((inButton (:pointer :OpaqueControlRef))
    (inContent (:pointer :ControlButtonContentInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetBevelButtonTransform()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetBevelButtonTransform" 
   ((inButton (:pointer :OpaqueControlRef))
    (transform :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetBevelButtonGraphicAlignment()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetBevelButtonGraphicAlignment" 
   ((inButton (:pointer :OpaqueControlRef))
    (inAlign :SInt16)
    (inHOffset :SInt16)
    (inVOffset :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetBevelButtonTextAlignment()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetBevelButtonTextAlignment" 
   ((inButton (:pointer :OpaqueControlRef))
    (inAlign :SInt16)
    (inHOffset :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetBevelButtonTextPlacement()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetBevelButtonTextPlacement" 
   ((inButton (:pointer :OpaqueControlRef))
    (inWhere :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ SLIDER (CDEF 3)                                                                   
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   There are several variants that control the behavior of the slider control. Any     
;   combination of the following three constants can be added to the basic CDEF ID      
;   (kSliderProc).                                                                      
;                                                                                       
;   Variants:                                                                           
;                                                                                       
;       kSliderLiveFeedback     Slider does not use "ghosted" indicator when tracking.  
;                               ActionProc is called (set via SetControlAction) as the  
;                               indicator is dragged. The value is updated so that the  
;                               actionproc can adjust some other property based on the  
;                               value each time the action proc is called. If no action 
;                               proc is installed, it reverts to the ghost indicator.   
;                                                                                       
;       kSliderHasTickMarks     Slider is drawn with 'tick marks'. The control          
;                               rectangle must be large enough to accomidate the tick   
;                               marks.                                                  
;                                                                                       
;       kSliderReverseDirection Slider thumb points in opposite direction than normal.  
;                               If the slider is vertical, the thumb will point to the  
;                               left, if the slider is horizontal, the thumb will point 
;                               upwards.                                                
;                                                                                       
;       kSliderNonDirectional   This option overrides the kSliderReverseDirection and   
;                               kSliderHasTickMarks variants. It creates an indicator   
;                               which is rectangular and doesn't point in any direction 
;                               like the normal indicator does.                         
;                                                                                       
;                                                                                       
;   Mac OS X has a "Scroll to here" option in the General pane of System Preferences    
;   which allows users to click in the page up/down regions of a slider and have the    
;   thumb/indicator jump directly to the clicked position, which alters the value of    
;   the slider and moves any associated content appropriately. As long as the mouse     
;   button is held down, the click is treated as though the user had clicked in the     
;   thumb/indicator in the first place.                                                 
;                                                                                       
;   If you want the sliders in your application to work with the "Scroll to here"       
;   option, you must do the following:                                                  
;                                                                                       
;   1. Create live-tracking sliders, not sliders that show a "ghost" thumb when you     
;   click on it. You can request live-tracking sliders by passing true in the           
;   liveTracking parameter to CreateSliderControl. If you create sliders with           
;   NewControl, use the kControlSliderLiveFeedback variant.                             
;                                                                                       
;   2. Write an appropriate ControlActionProc and associate it with your slider via     
;   the SetControlAction API. This allows your application to update its content        
;   appropriately when the live-tracking slider is clicked.                             
;                                                                                       
;   3. When calling HandleControlClick or TrackControl, pass -1 in the action proc      
;   parameter. This is a request for the Control Manager to use the action proc you     
;   associated with your control in step 2. If you rely on the standard window event    
;   handler to do your control tracking, this step is handled for you automatically.    
;                                                                                       
;  Slider proc ID and variants 

(defconstant $kControlSliderProc 48)
(defconstant $kControlSliderLiveFeedback 1)
(defconstant $kControlSliderHasTickMarks 2)
(defconstant $kControlSliderReverseDirection 4)
(defconstant $kControlSliderNonDirectional 8)
;  Slider Orientation 

(def-mactype :ControlSliderOrientation (find-mactype ':UInt16))

(defconstant $kControlSliderPointsDownOrRight 0)
(defconstant $kControlSliderPointsUpOrLeft 1)
(defconstant $kControlSliderDoesNotPoint 2)
;  Control Kind Tag 

(defconstant $kControlKindSlider :|sldr|)
;  The HIObject class ID for the HISlider class. 
; #define kHISliderClassID                CFSTR("com.apple.HISlider")
;  Creation API: Carbon Only 
; 
;  *  CreateSliderControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateSliderControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (value :SInt32)
    (minimum :SInt32)
    (maximum :SInt32)
    (orientation :UInt16)
    (numTickMarks :UInt16)
    (liveTracking :Boolean)
    (liveTrackingProc (:pointer :OpaqueControlActionProcPtr))
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ DISCLOSURE TRIANGLE (CDEF 4)                                                      
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   This control can be used as either left or right facing. It can also handle its own 
;   tracking if you wish. This means that when the 'autotoggle' variant is used, if the 
;   user clicks the control, it's state will change automatically from open to closed   
;   and vice-versa depending on its initial state. After a successful call to Track-    
;   Control, you can just check the current value to see what state it was switched to. 
;  Triangle proc IDs 

(defconstant $kControlTriangleProc 64)
(defconstant $kControlTriangleLeftFacingProc 65)
(defconstant $kControlTriangleAutoToggleProc 66)
(defconstant $kControlTriangleLeftFacingAutoToggleProc 67)

(def-mactype :ControlDisclosureTriangleOrientation (find-mactype ':UInt16))

(defconstant $kControlDisclosureTrianglePointDefault 0);  points right on a left-to-right script system (Mac OS X and later or CarbonLib 1.5 and later only)

(defconstant $kControlDisclosureTrianglePointRight 1)
(defconstant $kControlDisclosureTrianglePointLeft 2)
;  Control Kind Tag 

(defconstant $kControlKindDisclosureTriangle :|dist|)
;  The HIObject class ID for the HIDisclosureTriangle class. 
; #define kHIDisclosureTriangleClassID    CFSTR("com.apple.HIDisclosureTriangle")
; 
;  *  CreateDisclosureTriangleControl()
;  *  
;  *  Summary:
;  *    Creates a Disclosure Triangle control at a specific position in
;  *    the specified window.
;  *  
;  *  Discussion:
;  *    Disclosure Triangles are small controls that give the user a way
;  *    to toggle the visibility of information or other user interface.
;  *    When information is in a hidden state, a Disclosure Triangle is
;  *    considered "closed" and should point to the right (or sometimes
;  *    to the left). When the user clicks on it, the Disclosure Triangle
;  *    rotates downwards into the "open" state. The application should
;  *    repond by revealing the appropriate information or interface. On
;  *    Mac OS X, a root control will be created for the window if one
;  *    does not already exist. If a root control exists for the window,
;  *    the Disclosure Triangle control will be embedded into it.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The WindowRef into which the Disclosure Triangle will be
;  *      created.
;  *    
;  *    inBoundsRect:
;  *      The desired position (in coordinates local to the window's
;  *      port) for the Disclosure Triangle.
;  *    
;  *    inOrientation:
;  *      The direction the Disclosure Triangle should point when it is
;  *      "closed". Passing kControlDisclosureTrianglePointDefault is
;  *      only legal as of Mac OS X and CarbonLib 1.5.
;  *    
;  *    inTitle:
;  *      The title for the Disclosure Triangle. The title will only be
;  *      displayed if the inDrawTitle parameter is true. Title display
;  *      only works on Mac OS X.
;  *    
;  *    inInitialValue:
;  *      The starting value determines whether the Disclosure Triangle
;  *      is initially in its "open" or "closed" state. The value 0
;  *      represents the "closed" state and 1 represents the "open" state.
;  *    
;  *    inDrawTitle:
;  *      A Boolean indicating whether the Disclosure Triangle should
;  *      draw its title next to the widget. Title display only works on
;  *      Mac OS X.
;  *    
;  *    inAutoToggles:
;  *      A Boolean indicating whether the Disclosure Triangle should
;  *      change its own value (from "open" to "closed" and vice-versa)
;  *      automatically when it is clicked on.
;  *    
;  *    outControl:
;  *      On successful output, outControl will contain a reference to
;  *      the Disclosure Triangle control.
;  *  
;  *  Result:
;  *    An OSStatus code indicating success or failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateDisclosureTriangleControl" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inBoundsRect (:pointer :Rect))
    (inOrientation :UInt16)
    (inTitle (:pointer :__CFString))
    (inInitialValue :SInt32)
    (inDrawTitle :Boolean)
    (inAutoToggles :Boolean)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Tagged data supported by disclosure triangles 

(defconstant $kControlTriangleLastValueTag :|last|);  SInt16

;  Helper routines are available only thru the shared library/glue. 
; 
;  *  SetDisclosureTriangleLastValue()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetDisclosureTriangleLastValue" 
   ((inTabControl (:pointer :OpaqueControlRef))
    (inValue :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ PROGRESS INDICATOR (CDEF 5)                                                       
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   This CDEF implements both determinate and indeterminate progress bars. To switch,   
;   just use SetControlData to set the indeterminate flag to make it indeterminate call 
;   IdleControls to step thru the animation. IdleControls should be called at least     
;   once during your event loop.                                                        
;                                                                                       
;   We also use this same CDEF for Relevance bars. At this time this control does not   
;   idle.                                                                               
;  Progress Bar proc IDs 

(defconstant $kControlProgressBarProc 80)
(defconstant $kControlRelevanceBarProc 81)
;  Control Kind Tag 

(defconstant $kControlKindProgressBar :|prgb|)
(defconstant $kControlKindRelevanceBar :|relb|)
;  The HIObject class ID for the HIProgressBar class. 
; #define kHIProgressBarClassID           CFSTR("com.apple.HIProgressBar")
;  Creation API: Carbon only 
; 
;  *  CreateProgressBarControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateProgressBarControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (value :SInt32)
    (minimum :SInt32)
    (maximum :SInt32)
    (indeterminate :Boolean)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  The HIObject class ID for the HIRelevanceBar class. 
; #define kHIRelevanceBarClassID          CFSTR("com.apple.HIRelevanceBar")
; 
;  *  CreateRelevanceBarControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateRelevanceBarControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (value :SInt32)
    (minimum :SInt32)
    (maximum :SInt32)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Tagged data supported by progress bars 

(defconstant $kControlProgressBarIndeterminateTag :|inde|);  Boolean

(defconstant $kControlProgressBarAnimatingTag :|anim|);  Boolean

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ LITTLE ARROWS (CDEF 6)                                                            
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   This control implements the little up and down arrows you'd see in the Memory       
;   control panel for adjusting the cache size.                                         
;  Little Arrows proc IDs 

(defconstant $kControlLittleArrowsProc 96)
;  Control Kind Tag 

(defconstant $kControlKindLittleArrows :|larr|)
; 
;  *  Summary:
;  *    Tags available with Mac OS X 10.3 or later
;  
; 
;    * Passed data is an SInt32.  Gets or sets the increment value of the
;    * control.
;    

(defconstant $kControlLittleArrowsIncrementValueTag :|incr|)
;  The HIObject class ID for the HILittleArrows class. 
; #define kHILittleArrowsClassID          CFSTR("com.apple.HILittleArrows")
;  Creation API: Carbon only 
; 
;  *  CreateLittleArrowsControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateLittleArrowsControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (value :SInt32)
    (minimum :SInt32)
    (maximum :SInt32)
    (increment :SInt32)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ CHASING ARROWS (CDEF 7)                                                           
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   To animate this control, make sure to call IdleControls repeatedly.                 
;                                                                                       
;  Chasing Arrows proc IDs 

(defconstant $kControlChasingArrowsProc 112)
;  Control Kind Tag 

(defconstant $kControlKindChasingArrows :|carr|)
;  The HIObject class ID for the HIChasingArrows class. 
; #define kHIChasingArrowsClassID         CFSTR("com.apple.HIChasingArrows")
;  Creation API: Carbon only 
; 
;  *  CreateChasingArrowsControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateChasingArrowsControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Tagged data supported by the Chasing Arrows control 

(defconstant $kControlChasingArrowsAnimatingTag :|anim|);  Boolean

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ TABS (CDEF 8)                                                                     
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   Tabs use an auxiliary resource (tab#) to hold tab information such as the tab name  
;   and an icon suite ID for each tab.                                                  
;                                                                                       
;   The ID of the tab# resource that you wish to associate with a tab control should    
;   be passed in as the Value parameter of the control. If you are using GetNewControl, 
;   then the Value slot in the CNTL resource should have the ID of the 'tab#' resource  
;   on creation.                                                                        
;                                                                                       
;   Passing zero in for the tab# resource tells the control not to read in a tab# res.  
;   You can then use SetControlMaximum to add tabs, followed by a call to SetControlData
;   with the kControlTabInfoTag, passing in a pointer to a ControlTabInfoRec. This sets 
;   the name and optionally an icon for a tab. Pass the 1-based tab index as the part   
;   code parameter to SetControlData to indicate the tab that you want to modify.       
;  Tabs proc IDs 

(defconstant $kControlTabLargeProc #x80)        ;  Large tab size, north facing   

(defconstant $kControlTabSmallProc #x81)        ;  Small tab size, north facing   

(defconstant $kControlTabLargeNorthProc #x80)   ;  Large tab size, north facing   

(defconstant $kControlTabSmallNorthProc #x81)   ;  Small tab size, north facing   

(defconstant $kControlTabLargeSouthProc #x82)   ;  Large tab size, south facing   

(defconstant $kControlTabSmallSouthProc #x83)   ;  Small tab size, south facing   

(defconstant $kControlTabLargeEastProc #x84)    ;  Large tab size, east facing    

(defconstant $kControlTabSmallEastProc #x85)    ;  Small tab size, east facing    

(defconstant $kControlTabLargeWestProc #x86)    ;  Large tab size, west facing    

(defconstant $kControlTabSmallWestProc #x87)    ;  Small tab size, west facing    

;  Tab Directions 

(def-mactype :ControlTabDirection (find-mactype ':UInt16))

(defconstant $kControlTabDirectionNorth 0)
(defconstant $kControlTabDirectionSouth 1)
(defconstant $kControlTabDirectionEast 2)
(defconstant $kControlTabDirectionWest 3)
;  Tab Sizes 

(def-mactype :ControlTabSize (find-mactype ':UInt16))

(defconstant $kControlTabSizeLarge 0)
(defconstant $kControlTabSizeSmall 1)
(defconstant $kControlTabSizeMini 3)
;  Control Tab Entry - used during creation                             
;  Note that the client is responsible for allocating/providing         
;  the ControlButtonContentInfo and string storage for this             
;  structure.                                                           
(defrecord ControlTabEntry
   (icon (:pointer :ControlButtonContentInfo))
   (name (:pointer :__CFString))
   (enabled :Boolean)
)

;type name? (%define-record :ControlTabEntry (find-record-descriptor ':ControlTabEntry))
;  Control Kind Tag 

(defconstant $kControlKindTabs :|tabs|)
;  The HIObject class ID for the HITabbedView class. 
; #define kHITabbedViewClassID            CFSTR("com.apple.HITabbedView")
;  Creation API: Carbon only 
; 
;  *  CreateTabsControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateTabsControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (size :UInt16)
    (direction :UInt16)
    (numTabs :UInt16)
    (tabArray (:pointer :ControlTabEntry))
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Tagged data supported by tabs 

(defconstant $kControlTabContentRectTag :|rect|);  Rect

(defconstant $kControlTabEnabledFlagTag :|enab|);  Boolean

(defconstant $kControlTabFontStyleTag :|font|)  ;  ControlFontStyleRec

;  New tags in 1.0.1 or later 

(defconstant $kControlTabInfoTag :|tabi|)       ;  ControlTabInfoRec

;  New tags in X 10.1 or later 

(defconstant $kControlTabImageContentTag :|cont|);  ControlButtonContentInfo


(defconstant $kControlTabInfoVersionZero 0)     ;  ControlTabInfoRec

(defconstant $kControlTabInfoVersionOne 1)      ;  ControlTabInfoRecV1

(defrecord ControlTabInfoRec
   (version :SInt16)                            ;  version of this structure.
   (iconSuiteID :SInt16)                        ;  icon suite to use. Zero indicates no icon
   (name (:string 255))                         ;  name to be displayed on the tab
)

;type name? (%define-record :ControlTabInfoRec (find-record-descriptor ':ControlTabInfoRec))
(defrecord ControlTabInfoRecV1
   (version :SInt16)                            ;  version of this structure. == kControlTabInfoVersionOne
   (iconSuiteID :SInt16)                        ;  icon suite to use. Zero indicates no icon
   (name (:pointer :__CFString))                ;  name to be displayed on the tab. Will be retained so caller
                                                ;  should always release it.
)

;type name? (%define-record :ControlTabInfoRecV1 (find-record-descriptor ':ControlTabInfoRecV1))
;  Helper routines are available only thru the shared library/glue. 
; 
;  *  GetTabContentRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetTabContentRect" 
   ((inTabControl (:pointer :OpaqueControlRef))
    (outContentRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetTabEnabled()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetTabEnabled" 
   ((inTabControl (:pointer :OpaqueControlRef))
    (inTabToHilite :SInt16)
    (inEnabled :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ VISUAL SEPARATOR (CDEF 9)                                                         
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   Separator lines determine their orientation (horizontal or vertical) automatically  
;   based on the relative height and width of their contrlRect.                         
;  Visual separator proc IDs 

(defconstant $kControlSeparatorLineProc #x90)
;  Control Kind Tag 

(defconstant $kControlKindSeparator :|sepa|)
;  The HIObject class ID for the HIVisualSeparator class. 
; #define kHIVisualSeparatorClassID       CFSTR("com.apple.HIVisualSeparator")
;  Creation API: Carbon only 
; 
;  *  CreateSeparatorControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateSeparatorControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ GROUP BOX (CDEF 10)                                                               
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   The group box CDEF can be use in several ways. It can have no title, a text title,  
;   a check box as the title, or a popup button as a title. There are two versions of   
;   group boxes, primary and secondary, which look slightly different.                  
;  Group Box proc IDs 

(defconstant $kControlGroupBoxTextTitleProc #xA0)
(defconstant $kControlGroupBoxCheckBoxProc #xA1)
(defconstant $kControlGroupBoxPopupButtonProc #xA2)
(defconstant $kControlGroupBoxSecondaryTextTitleProc #xA4)
(defconstant $kControlGroupBoxSecondaryCheckBoxProc #xA5)
(defconstant $kControlGroupBoxSecondaryPopupButtonProc #xA6)
;  Control Kind Tag 

(defconstant $kControlKindGroupBox :|grpb|)
(defconstant $kControlKindCheckGroupBox :|cgrp|)
(defconstant $kControlKindPopupGroupBox :|pgrp|)
;  The HIObject class ID for the HIGroupBox class. 
; #define kHIGroupBoxClassID              CFSTR("com.apple.HIGroupBox")
;  The HIObject class ID for the HICheckBoxGroup class. 
; #define kHICheckBoxGroupClassID         CFSTR("com.apple.HICheckBoxGroup")
;  Creation APIs: Carbon only 
; 
;  *  CreateGroupBoxControl()
;  *  
;  *  Summary:
;  *    Creates a group box control.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window that should contain the control.
;  *    
;  *    boundsRect:
;  *      The bounding box of the control.
;  *    
;  *    title:
;  *      The title of the control.
;  *    
;  *    primary:
;  *      Whether to create a primary or secondary group box.
;  *    
;  *    outControl:
;  *      On exit, contains the new control.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateGroupBoxControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (title (:pointer :__CFString))
    (primary :Boolean)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateCheckGroupBoxControl()
;  *  
;  *  Summary:
;  *    Creates a group box control that has a check box as its title.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window that should contain the control.
;  *    
;  *    boundsRect:
;  *      The bounding box of the control.
;  *    
;  *    title:
;  *      The title of the control (used as the title of the check box).
;  *    
;  *    initialValue:
;  *      The initial value of the check box.
;  *    
;  *    primary:
;  *      Whether to create a primary or secondary group box.
;  *    
;  *    autoToggle:
;  *      Whether to create an auto-toggling check box. Auto-toggling
;  *      check box titles are only supported on Mac OS X; this parameter
;  *      must be false when used with CarbonLib.
;  *    
;  *    outControl:
;  *      On exit, contains the new control.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateCheckGroupBoxControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (title (:pointer :__CFString))
    (initialValue :SInt32)
    (primary :Boolean)
    (autoToggle :Boolean)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreatePopupGroupBoxControl()
;  *  
;  *  Summary:
;  *    Creates a group box control that has a popup button as its title.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window that should contain the control.
;  *    
;  *    boundsRect:
;  *      The bounding box of the control.
;  *    
;  *    title:
;  *      The title of the control (used as the title of the popup
;  *      button).
;  *    
;  *    primary:
;  *      Whether to create a primary or secondary group box.
;  *    
;  *    menuID:
;  *      The menu ID of the menu to be displayed by the popup button.
;  *    
;  *    variableWidth:
;  *      Whether the popup button should have a variable-width title.
;  *      Fixed-width titles are only supported by Mac OS X; this
;  *      parameter must be true when used with CarbonLib.
;  *    
;  *    titleWidth:
;  *      The width in pixels of the popup button title.
;  *    
;  *    titleJustification:
;  *      The justification of the popup button title. Use one of the
;  *      TextEdit justification constants here (teFlushDefault,
;  *      teCenter, teFlushRight, or teFlushLeft).
;  *    
;  *    titleStyle:
;  *      The QuickDraw text style of the popup button title.
;  *    
;  *    outControl:
;  *      On exit, contains the new control.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreatePopupGroupBoxControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (title (:pointer :__CFString))
    (primary :Boolean)
    (menuID :SInt16)
    (variableWidth :Boolean)
    (titleWidth :SInt16)
    (titleJustification :SInt16)
    (titleStyle :UInt8)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Tagged data supported by group box 

(defconstant $kControlGroupBoxMenuHandleTag :|mhan|);  MenuRef (popup title only)

(defconstant $kControlGroupBoxMenuRefTag :|mhan|);  MenuRef (popup title only)

(defconstant $kControlGroupBoxFontStyleTag :|font|);  ControlFontStyleRec

;  tags available with Appearance 1.1 or later 

(defconstant $kControlGroupBoxTitleRectTag :|trec|);  Rect. Rectangle that the title text/control is drawn in. (get only)

; 
;  *  Summary:
;  *    Tags available with Mac OS X 10.3 or later
;  
; 
;    * Passed data is a Rect.  Returns the full rectangle that content is
;    * drawn in (get only). This is slightly different than the content
;    * region, as it also includes the frame drawn around the content.
;    

(defconstant $kControlGroupBoxFrameRectTag :|frec|)
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ IMAGE WELL (CDEF 11)                                                              
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   Image Wells allow you to control the content type (pict/icon/etc.) shown in the     
;   well.                                                                               
;                                                                                       
;   This is made possible by overloading the Min and Value parameters for the control.  
;                                                                                       
;   Parameter                   What Goes Here                                          
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ         ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ      
;   Min                         content type (see constants for bevel buttons)          
;   Value                       Resource ID of content type, if resource-based.         
;                                                                                       
;                                                                                       
;   Handle-based Content                                                                
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ                                                                
;   You can create your control and then set the content to an existing handle to an    
;   icon suite, etc. using the macros below. Please keep in mind that resource-based    
;   content is owned by the control, handle-based content is owned by you. The CDEF will
;   not try to dispose of handle-based content. If you are changing the content type of 
;   the button on the fly, you must make sure that if you are replacing a handle-       
;   based content with a resource-based content to properly dispose of the handle,      
;   else a memory leak will ensue.                                                      
;                                                                                       
;  Image Well proc IDs 

(defconstant $kControlImageWellProc #xB0)
;  Control Kind Tag 

(defconstant $kControlKindImageWell :|well|)
;  The HIObject class ID for the HIImageWell class. 
; #define kHIImageWellClassID             CFSTR("com.apple.HIImageWell")
;  Creation API: Carbon only 
; 
;  *  CreateImageWellControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateImageWellControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (info (:pointer :ControlButtonContentInfo))
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Tagged data supported by image wells 

(defconstant $kControlImageWellContentTag :|cont|);  ButtonContentInfo

(defconstant $kControlImageWellTransformTag :|tran|);  IconTransformType

(defconstant $kControlImageWellIsDragDestinationTag :|drag|);  Boolean

;  Helper routines are available only thru the shared library/glue. 
; 
;  *  GetImageWellContentInfo()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_GetImageWellContentInfo" 
   ((inButton (:pointer :OpaqueControlRef))
    (outContent (:pointer :ControlButtonContentInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetImageWellContentInfo()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetImageWellContentInfo" 
   ((inButton (:pointer :OpaqueControlRef))
    (inContent (:pointer :ControlButtonContentInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetImageWellTransform()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in AppearanceLib 1.0 and later
;  

(deftrap-inline "_SetImageWellTransform" 
   ((inButton (:pointer :OpaqueControlRef))
    (inTransform :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ POPUP ARROW (CDEF 12)                                                             
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   The popup arrow CDEF is used to draw the small arrow normally associated with a     
;   popup control. The arrow can point in four directions, and a small or large version 
;   can be used. This control is provided to allow clients to draw the arrow in a       
;   normalized fashion which will take advantage of themes automatically.               
;                                                                                       
;  Popup Arrow proc IDs 

(defconstant $kControlPopupArrowEastProc #xC0)
(defconstant $kControlPopupArrowWestProc #xC1)
(defconstant $kControlPopupArrowNorthProc #xC2)
(defconstant $kControlPopupArrowSouthProc #xC3)
(defconstant $kControlPopupArrowSmallEastProc #xC4)
(defconstant $kControlPopupArrowSmallWestProc #xC5)
(defconstant $kControlPopupArrowSmallNorthProc #xC6)
(defconstant $kControlPopupArrowSmallSouthProc #xC7)
;  Popup Arrow Orientations 

(defconstant $kControlPopupArrowOrientationEast 0)
(defconstant $kControlPopupArrowOrientationWest 1)
(defconstant $kControlPopupArrowOrientationNorth 2)
(defconstant $kControlPopupArrowOrientationSouth 3)

(def-mactype :ControlPopupArrowOrientation (find-mactype ':UInt16))
;  Popup Arrow Size 

(defconstant $kControlPopupArrowSizeNormal 0)
(defconstant $kControlPopupArrowSizeSmall 1)

(def-mactype :ControlPopupArrowSize (find-mactype ':UInt16))
;  Control Kind Tag 

(defconstant $kControlKindPopupArrow :|parr|)
; 
;  *  CreatePopupArrowControl()
;  *  
;  *  Summary:
;  *    Creates a popup arrow control.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window that should contain the control. May be NULL on Mac
;  *      OS X 10.3 and later.
;  *    
;  *    boundsRect:
;  *      The bounding box of the control.
;  *    
;  *    orientation:
;  *      The orientation of the control.
;  *    
;  *    size:
;  *      The size of the control.
;  *    
;  *    outControl:
;  *      On exit, contains the new control.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreatePopupArrowControl" 
   ((window (:pointer :OpaqueWindowPtr))        ;  can be NULL 
    (boundsRect (:pointer :Rect))
    (orientation :UInt16)
    (size :UInt16)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ PLACARD (CDEF 14)                                                                 
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Placard proc IDs 

(defconstant $kControlPlacardProc #xE0)
;  Control Kind Tag 

(defconstant $kControlKindPlacard :|plac|)
;  The HIObject class ID for the HIPlacardView class. 
; #define kHIPlacardViewClassID           CFSTR("com.apple.HIPlacardView")
; 
;  *  CreatePlacardControl()
;  *  
;  *  Summary:
;  *    Creates a placard control.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window that should contain the control. May be NULL on Mac
;  *      OS X 10.3 and later.
;  *    
;  *    boundsRect:
;  *      The bounding box of the control.
;  *    
;  *    outControl:
;  *      On exit, contains the new control.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreatePlacardControl" 
   ((window (:pointer :OpaqueWindowPtr))        ;  can be NULL 
    (boundsRect (:pointer :Rect))
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ CLOCK (CDEF 15)                                                                   
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   NOTE:   You can specify more options in the Value paramter when creating the clock. 
;           See below.                                                                  
;                                                                                       
;   NOTE:   Under Appearance 1.1, the clock control knows and returns more part codes.  
;           The new clock-specific part codes are defined with the other control parts. 
;           Besides these clock-specific parts, we also return kControlUpButtonPart     
;           and kControlDownButtonPart when they hit the up and down arrows.            
;           The new part codes give you more flexibility for focusing and hit testing.  
;                                                                                       
;           The original kControlClockPart is still valid. When hit testing, it means   
;           that some non-editable area of the clock's whitespace has been clicked.     
;           When focusing a currently unfocused clock, it changes the focus to the      
;           first part; it is the same as passing kControlFocusNextPart. When           
;           re-focusing a focused clock, it will not change the focus at all.           
;  Clock proc IDs 

(defconstant $kControlClockTimeProc #xF0)
(defconstant $kControlClockTimeSecondsProc #xF1)
(defconstant $kControlClockDateProc #xF2)
(defconstant $kControlClockMonthYearProc #xF3)
;  Clock Types 

(def-mactype :ControlClockType (find-mactype ':UInt16))

(defconstant $kControlClockTypeHourMinute 0)
(defconstant $kControlClockTypeHourMinuteSecond 1)
(defconstant $kControlClockTypeMonthDayYear 2)
(defconstant $kControlClockTypeMonthYear 3)
;  Clock Flags 
;   These flags can be passed into 'value' field on creation of the control.            
;   Value is set to 0 after control is created.                                         

(def-mactype :ControlClockFlags (find-mactype ':UInt32))

(defconstant $kControlClockFlagStandard 0)      ;  editable, non-live

(defconstant $kControlClockNoFlags 0)
(defconstant $kControlClockFlagDisplayOnly 1)   ;  add this to become non-editable

(defconstant $kControlClockIsDisplayOnly 1)
(defconstant $kControlClockFlagLive 2)          ;  automatically shows current time on idle. only valid with display only.

(defconstant $kControlClockIsLive 2)
;  Control Kind Tag 

(defconstant $kControlKindClock :|clck|)
;  The HIObject class ID for the HIClock class. 
; #define kHIClockViewClassID             CFSTR("com.apple.HIClock")
;  Creation API: Carbon only 
; 
;  *  CreateClockControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateClockControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (clockType :UInt16)
    (clockFlags :UInt32)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Tagged data supported by clocks 

(defconstant $kControlClockLongDateTag :|date|) ;  LongDateRec

(defconstant $kControlClockFontStyleTag :|font|);  ControlFontStyleRec

(defconstant $kControlClockAnimatingTag :|anim|);  Boolean

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ USER PANE (CDEF 16)                                                               
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   User panes have two primary purposes: to allow easy implementation of a custom      
;   control by the developer, and to provide a generic container for embedding other    
;   controls.                                                                           
;                                                                                       
;   In Carbon, with the advent of Carbon-event-based controls, you may find it easier   
;   to simply write a new control from scratch than to customize a user pane control.   
;   The set of callbacks provided by the user pane will not be extended to support      
;   new Control Manager features; instead, you should just write a real control.        
;                                                                                       
;   User panes do not, by default, support embedding. If you try to embed a control     
;   into a user pane, you will get back errControlIsNotEmbedder. You can make a user    
;   pane support embedding by passing the kControlSupportsEmbedding flag in the 'value' 
;   parameter when you create the control.                                              
;                                                                                       
;   User panes support the following overloaded control initialization options:         
;                                                                                       
;   Parameter                   What Goes Here                                          
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ         ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ      
;   Value                       Control feature flags                                   
;  User Pane proc IDs 

(defconstant $kControlUserPaneProc #x100)
;  Control Kind Tag 

(defconstant $kControlKindUserPane :|upan|)
;  Creation API: Carbon only 
; 
;  *  CreateUserPaneControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateUserPaneControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (features :UInt32)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Tagged data supported by user panes 
;  Currently, they are all proc ptrs for doing things like drawing and hit testing, etc. 

(defconstant $kControlUserItemDrawProcTag :|uidp|);  UserItemUPP

(defconstant $kControlUserPaneDrawProcTag :|draw|);  ControlUserPaneDrawUPP

(defconstant $kControlUserPaneHitTestProcTag :|hitt|);  ControlUserPaneHitTestUPP

(defconstant $kControlUserPaneTrackingProcTag :|trak|);  ControlUserPaneTrackingUPP

(defconstant $kControlUserPaneIdleProcTag :|idle|);  ControlUserPaneIdleUPP

(defconstant $kControlUserPaneKeyDownProcTag :|keyd|);  ControlUserPaneKeyDownUPP

(defconstant $kControlUserPaneActivateProcTag :|acti|);  ControlUserPaneActivateUPP

(defconstant $kControlUserPaneFocusProcTag :|foci|);  ControlUserPaneFocusUPP

(defconstant $kControlUserPaneBackgroundProcTag :|back|);  ControlUserPaneBackgroundUPP


(def-mactype :ControlUserPaneDrawProcPtr (find-mactype ':pointer)); (ControlRef control , SInt16 part)

(def-mactype :ControlUserPaneHitTestProcPtr (find-mactype ':pointer)); (ControlRef control , Point where)

(def-mactype :ControlUserPaneTrackingProcPtr (find-mactype ':pointer)); (ControlRef control , Point startPt , ControlActionUPP actionProc)

(def-mactype :ControlUserPaneIdleProcPtr (find-mactype ':pointer)); (ControlRef control)

(def-mactype :ControlUserPaneKeyDownProcPtr (find-mactype ':pointer)); (ControlRef control , SInt16 keyCode , SInt16 charCode , SInt16 modifiers)

(def-mactype :ControlUserPaneActivateProcPtr (find-mactype ':pointer)); (ControlRef control , Boolean activating)

(def-mactype :ControlUserPaneFocusProcPtr (find-mactype ':pointer)); (ControlRef control , ControlFocusPart action)

(def-mactype :ControlUserPaneBackgroundProcPtr (find-mactype ':pointer)); (ControlRef control , ControlBackgroundPtr info)

(def-mactype :ControlUserPaneDrawUPP (find-mactype '(:pointer :OpaqueControlUserPaneDrawProcPtr)))

(def-mactype :ControlUserPaneHitTestUPP (find-mactype '(:pointer :OpaqueControlUserPaneHitTestProcPtr)))

(def-mactype :ControlUserPaneTrackingUPP (find-mactype '(:pointer :OpaqueControlUserPaneTrackingProcPtr)))

(def-mactype :ControlUserPaneIdleUPP (find-mactype '(:pointer :OpaqueControlUserPaneIdleProcPtr)))

(def-mactype :ControlUserPaneKeyDownUPP (find-mactype '(:pointer :OpaqueControlUserPaneKeyDownProcPtr)))

(def-mactype :ControlUserPaneActivateUPP (find-mactype '(:pointer :OpaqueControlUserPaneActivateProcPtr)))

(def-mactype :ControlUserPaneFocusUPP (find-mactype '(:pointer :OpaqueControlUserPaneFocusProcPtr)))

(def-mactype :ControlUserPaneBackgroundUPP (find-mactype '(:pointer :OpaqueControlUserPaneBackgroundProcPtr)))
; 
;  *  NewControlUserPaneDrawUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewControlUserPaneDrawUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlUserPaneDrawProcPtr)
() )
; 
;  *  NewControlUserPaneHitTestUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewControlUserPaneHitTestUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlUserPaneHitTestProcPtr)
() )
; 
;  *  NewControlUserPaneTrackingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewControlUserPaneTrackingUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlUserPaneTrackingProcPtr)
() )
; 
;  *  NewControlUserPaneIdleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewControlUserPaneIdleUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlUserPaneIdleProcPtr)
() )
; 
;  *  NewControlUserPaneKeyDownUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewControlUserPaneKeyDownUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlUserPaneKeyDownProcPtr)
() )
; 
;  *  NewControlUserPaneActivateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewControlUserPaneActivateUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlUserPaneActivateProcPtr)
() )
; 
;  *  NewControlUserPaneFocusUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewControlUserPaneFocusUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlUserPaneFocusProcPtr)
() )
; 
;  *  NewControlUserPaneBackgroundUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewControlUserPaneBackgroundUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlUserPaneBackgroundProcPtr)
() )
; 
;  *  DisposeControlUserPaneDrawUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeControlUserPaneDrawUPP" 
   ((userUPP (:pointer :OpaqueControlUserPaneDrawProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeControlUserPaneHitTestUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeControlUserPaneHitTestUPP" 
   ((userUPP (:pointer :OpaqueControlUserPaneHitTestProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeControlUserPaneTrackingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeControlUserPaneTrackingUPP" 
   ((userUPP (:pointer :OpaqueControlUserPaneTrackingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeControlUserPaneIdleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeControlUserPaneIdleUPP" 
   ((userUPP (:pointer :OpaqueControlUserPaneIdleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeControlUserPaneKeyDownUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeControlUserPaneKeyDownUPP" 
   ((userUPP (:pointer :OpaqueControlUserPaneKeyDownProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeControlUserPaneActivateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeControlUserPaneActivateUPP" 
   ((userUPP (:pointer :OpaqueControlUserPaneActivateProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeControlUserPaneFocusUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeControlUserPaneFocusUPP" 
   ((userUPP (:pointer :OpaqueControlUserPaneFocusProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeControlUserPaneBackgroundUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeControlUserPaneBackgroundUPP" 
   ((userUPP (:pointer :OpaqueControlUserPaneBackgroundProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeControlUserPaneDrawUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeControlUserPaneDrawUPP" 
   ((control (:pointer :OpaqueControlRef))
    (part :SInt16)
    (userUPP (:pointer :OpaqueControlUserPaneDrawProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeControlUserPaneHitTestUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeControlUserPaneHitTestUPP" 
   ((control (:pointer :OpaqueControlRef))
    (where :Point)
    (userUPP (:pointer :OpaqueControlUserPaneHitTestProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  InvokeControlUserPaneTrackingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeControlUserPaneTrackingUPP" 
   ((control (:pointer :OpaqueControlRef))
    (startPt :Point)
    (actionProc (:pointer :OpaqueControlActionProcPtr))
    (userUPP (:pointer :OpaqueControlUserPaneTrackingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  InvokeControlUserPaneIdleUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeControlUserPaneIdleUPP" 
   ((control (:pointer :OpaqueControlRef))
    (userUPP (:pointer :OpaqueControlUserPaneIdleProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeControlUserPaneKeyDownUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeControlUserPaneKeyDownUPP" 
   ((control (:pointer :OpaqueControlRef))
    (keyCode :SInt16)
    (charCode :SInt16)
    (modifiers :SInt16)
    (userUPP (:pointer :OpaqueControlUserPaneKeyDownProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  InvokeControlUserPaneActivateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeControlUserPaneActivateUPP" 
   ((control (:pointer :OpaqueControlRef))
    (activating :Boolean)
    (userUPP (:pointer :OpaqueControlUserPaneActivateProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeControlUserPaneFocusUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeControlUserPaneFocusUPP" 
   ((control (:pointer :OpaqueControlRef))
    (action :SInt16)
    (userUPP (:pointer :OpaqueControlUserPaneFocusProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  InvokeControlUserPaneBackgroundUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeControlUserPaneBackgroundUPP" 
   ((control (:pointer :OpaqueControlRef))
    (info (:pointer :ControlBackgroundRec))
    (userUPP (:pointer :OpaqueControlUserPaneBackgroundProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     ¥ EDIT TEXT (CDEF 17)
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  Edit Text proc IDs 

(defconstant $kControlEditTextProc #x110)
(defconstant $kControlEditTextPasswordProc #x112)
;  proc IDs available with Appearance 1.1 or later 

(defconstant $kControlEditTextInlineInputProc #x114);  Can't combine with the other variants

;  Control Kind Tag 

(defconstant $kControlKindEditText :|etxt|)
; 
;  *  CreateEditTextControl()
;  *  
;  *  Summary:
;  *    Creates a new edit text control.
;  *  
;  *  Discussion:
;  *    This control is a legacy control. It is deprecated in favor of
;  *    the EditUnicodeText control, which handles Unicode and draws its
;  *    text using antialiasing. If you are creating a new text field,
;  *    please use CreateEditUnicodeTextControl.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window in which the control should be placed. May be NULL
;  *      in Mac OS X 10.3 and later.
;  *    
;  *    boundsRect:
;  *      The bounds of the control, in local coordinates of the window.
;  *    
;  *    text:
;  *      The text of the control. May be NULL.
;  *    
;  *    isPassword:
;  *      A Boolean indicating whether the field is to be used as a
;  *      password field. Passing false indicates that the field is to
;  *      display entered text normally. True means that the field will
;  *      be used as a password field and any text typed into the field
;  *      will be displayed only as bullets.
;  *    
;  *    useInlineInput:
;  *      A Boolean indicating whether or not the control is to accept
;  *      inline input. Pass true to to accept inline input, otherwise
;  *      pass false.
;  *    
;  *    style:
;  *      The control's font style, size, color, and so on. May be NULL.
;  *    
;  *    outControl:
;  *      On exit, contains the new control (if noErr is returned as the
;  *      result code).
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateEditTextControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (text (:pointer :__CFString))               ;  can be NULL 
    (isPassword :Boolean)
    (useInlineInput :Boolean)
    (style (:pointer :ControlFontStyleRec))     ;  can be NULL 
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Tagged data supported by edit text 

(defconstant $kControlEditTextStyleTag :|font|) ;  ControlFontStyleRec

(defconstant $kControlEditTextTextTag :|text|)  ;  Buffer of chars - you supply the buffer

(defconstant $kControlEditTextTEHandleTag :|than|);  The TEHandle of the text edit record

(defconstant $kControlEditTextKeyFilterTag :|fltr|)
(defconstant $kControlEditTextSelectionTag :|sele|);  ControlEditTextSelectionRec

(defconstant $kControlEditTextPasswordTag :|pass|);  The clear text password text

;  tags available with Appearance 1.1 or later 

(defconstant $kControlEditTextKeyScriptBehaviorTag :|kscr|);  ControlKeyScriptBehavior. Defaults to "PrefersRoman" for password fields,
;        or "AllowAnyScript" for non-password fields.

(defconstant $kControlEditTextLockedTag :|lock|);  Boolean. Locking disables editability.

(defconstant $kControlEditTextFixedTextTag :|ftxt|);  Like the normal text tag, but fixes inline input first

(defconstant $kControlEditTextValidationProcTag :|vali|);  ControlEditTextValidationUPP. Called when a key filter can't be: after cut, paste, etc.

(defconstant $kControlEditTextInlinePreUpdateProcTag :|prup|);  TSMTEPreUpdateUPP and TSMTEPostUpdateUpp. For use with inline input variant...

(defconstant $kControlEditTextInlinePostUpdateProcTag :|poup|);  ...The refCon parameter will contain the ControlRef.

; 
;  *  Discussion:
;  *    EditText ControlData tags available with MacOSX and later.
;  
; 
;    * Extract the content of the edit text field as a CFString.  Don't
;    * forget that you own the returned CFStringRef and are responsible
;    * for CFReleasing it.
;    

(defconstant $kControlEditTextCFStringTag :|cfst|);  CFStringRef (Also available on CarbonLib 1.5)
; 
;    * Extract the content of the edit text field as a CFString, if it is
;    * a password field.  Don't forget that you own the returned
;    * CFStringRef and are responsible for CFReleasing it.
;    

(defconstant $kControlEditTextPasswordCFStringTag :|pwcf|);  CFStringRef

;  Structure for getting the edit text selection 
(defrecord ControlEditTextSelectionRec
   (selStart :SInt16)
   (selEnd :SInt16)
)

;type name? (%define-record :ControlEditTextSelectionRec (find-record-descriptor ':ControlEditTextSelectionRec))

(def-mactype :ControlEditTextSelectionPtr (find-mactype '(:pointer :ControlEditTextSelectionRec)))

(def-mactype :ControlEditTextValidationProcPtr (find-mactype ':pointer)); (ControlRef control)

(def-mactype :ControlEditTextValidationUPP (find-mactype '(:pointer :OpaqueControlEditTextValidationProcPtr)))
; 
;  *  NewControlEditTextValidationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewControlEditTextValidationUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueControlEditTextValidationProcPtr)
() )
; 
;  *  DisposeControlEditTextValidationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeControlEditTextValidationUPP" 
   ((userUPP (:pointer :OpaqueControlEditTextValidationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeControlEditTextValidationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeControlEditTextValidationUPP" 
   ((control (:pointer :OpaqueControlRef))
    (userUPP (:pointer :OpaqueControlEditTextValidationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ STATIC TEXT (CDEF 18)                                                             
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Static Text proc IDs 

(defconstant $kControlStaticTextProc #x120)
;  Control Kind Tag 

(defconstant $kControlKindStaticText :|stxt|)
;  The HIObject class ID for the HIStaticTextView class. 
; #define kHIStaticTextViewClassID        CFSTR("com.apple.HIStaticTextView")
;  Creation API: Carbon only 
; 
;  *  CreateStaticTextControl()
;  *  
;  *  Summary:
;  *    Creates a new static text control.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window in which the control should be placed. May be NULL
;  *      in Mac OS X 10.3 and later.
;  *    
;  *    boundsRect:
;  *      The bounds of the control, in local coordinates of the window.
;  *    
;  *    text:
;  *      The text of the control. May be NULL.
;  *    
;  *    style:
;  *      The control's font style, size, color, and so on. May be NULL.
;  *    
;  *    outControl:
;  *      On exit, contains the new control.
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateStaticTextControl" 
   ((window (:pointer :OpaqueWindowPtr))        ;  can be NULL 
    (boundsRect (:pointer :Rect))
    (text (:pointer :__CFString))               ;  can be NULL 
    (style (:pointer :ControlFontStyleRec))     ;  can be NULL 
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  Summary:
;  *    Tagged data supported by the static text control
;  
; 
;    * Used to get or set the control's current text style. Data is of
;    * type ControlFontStyleRec. Available with Appearance Manager 1.0
;    * (Mac OS 8.0) and later.
;    

(defconstant $kControlStaticTextStyleTag :|font|)
; 
;    * Used to get or set the control's current text. Data is an array of
;    * chars. Generally you should used GetControlDataSize to determine
;    * the length of the text, and allocate a buffer of that length,
;    * before calling GetControlData with this selector. Deprecated in
;    * Carbon in favor of kControlStaticTextCFStringTag. Available with
;    * Appearance Manager 1.0 (Mac OS 8.0) and later.
;    

(defconstant $kControlStaticTextTextTag :|text|)
; 
;    * Used to get the height of the control's text. May not be used with
;    * SetControlData. Data is of type SInt16. Available with Appearance
;    * Manager 1.0 (Mac OS 8.0) and later.
;    

(defconstant $kControlStaticTextTextHeightTag :|thei|)
; 
;    * Used to get or set the control's text truncation style. Data is of
;    * type TruncCode; pass a truncation code of -1 to indication no
;    * truncation. Available with Appearance Manager 1.1 (Mac OS 8.5) and
;    * later. Truncation will not occur unless
;    * kControlStaticTextIsMultilineTag is set to false.
;    

(defconstant $kControlStaticTextTruncTag :|trun|)
; 
;    * Used to get or set the control's current text. Data is of type
;    * CFStringRef. When setting the text, the control will retain the
;    * string, so you may release the string after calling
;    * SetControlData; if the string is mutable, the control will make a
;    * copy of the string, so any changes to the string after calling
;    * SetControlData will not affect the control. When getting the text,
;    * the control retains the string before returning it to you, so you
;    * must release the string after you are done with it. Available in
;    * CarbonLib 1.5 and Mac OS X 10.0 and later.
;    

(defconstant $kControlStaticTextCFStringTag :|cfst|)
; 
;    * Used to get or set whether the control draws its text in multiple
;    * lines if the text is too wide for the control bounds. If false,
;    * then the control always draws the text in a single line. Data is
;    * of type Boolean. Available in Mac OS X 10.1 and later.
;    

(defconstant $kControlStaticTextIsMultilineTag :|stim|)
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ PICTURE CONTROL (CDEF 19)                                                         
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   Value parameter should contain the ID of the picture you wish to display when       
;   creating controls of this type. If you don't want the control tracked at all, use   
;   the 'no track' variant.                                                             
;  Picture control proc IDs 

(defconstant $kControlPictureProc #x130)
(defconstant $kControlPictureNoTrackProc #x131) ;  immediately returns kControlPicturePart

;  Control Kind Tag 

(defconstant $kControlKindPicture :|pict|)
; 
;  *  CreatePictureControl()
;  *  
;  *  Summary:
;  *    Creates a picture control.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window that should contain the control. May be NULL on Mac
;  *      OS X 10.3 and later.
;  *    
;  *    boundsRect:
;  *      The bounding box of the control.
;  *    
;  *    content:
;  *      The descriptor for the picture you want the control to display.
;  *    
;  *    dontTrack:
;  *      A Boolean value indicating whether the control should hilite
;  *      when it is clicked on. False means hilite and track the mouse.
;  *    
;  *    outControl:
;  *      On exit, contains the new control.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreatePictureControl" 
   ((window (:pointer :OpaqueWindowPtr))        ;  can be NULL 
    (boundsRect (:pointer :Rect))
    (content (:pointer :ControlButtonContentInfo))
    (dontTrack :Boolean)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Tagged data supported by picture controls 

(defconstant $kControlPictureHandleTag :|pich|) ;  PicHandle

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ ICON CONTROL (CDEF 20)                                                            
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   Value parameter should contain the ID of the ICON or cicn you wish to display when  
;   creating controls of this type. If you don't want the control tracked at all, use   
;   the 'no track' variant.                                                             
;  Icon control proc IDs 

(defconstant $kControlIconProc #x140)
(defconstant $kControlIconNoTrackProc #x141)    ;  immediately returns kControlIconPart

(defconstant $kControlIconSuiteProc #x142)
(defconstant $kControlIconSuiteNoTrackProc #x143);  immediately returns kControlIconPart

;  icon ref controls may have either an icon, color icon, icon suite, or icon ref.
;  for data other than icon, you must set the data by passing a
;  ControlButtonContentInfo to SetControlData

(defconstant $kControlIconRefProc #x144)
(defconstant $kControlIconRefNoTrackProc #x145) ;  immediately returns kControlIconPart

;  Control Kind Tag 

(defconstant $kControlKindIcon :|icon|)
;  The HIObject class ID for the HIIconView class. 
; #define kHIIconViewClassID              CFSTR("com.apple.HIIconView")
; 
;  *  CreateIconControl()
;  *  
;  *  Summary:
;  *    Creates an Icon control at a specific position in the specified
;  *    window.
;  *  
;  *  Discussion:
;  *    Icon controls display an icon that (optionally) hilites when
;  *    clicked on. On Mac OS X, a root control will be created for the
;  *    window if one does not already exist. If a root control exists
;  *    for the window, the Icon control will be embedded into it.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The WindowRef into which the Icon control will be created. May
;  *      be NULL on Mac OS X 10.3 and later.
;  *    
;  *    inBoundsRect:
;  *      The desired position (in coordinates local to the window's
;  *      port) for the Icon control.
;  *    
;  *    inIconContent:
;  *      The descriptor for the icon you want the control to display.
;  *      Mac OS X and CarbonLib 1.5 (and beyond) support all of the icon
;  *      content types. Prior to CarbonLib 1.5, the only content types
;  *      that are properly respected are kControlContentIconSuiteRes,
;  *      kControlContentCIconRes, and kControlContentICONRes.
;  *    
;  *    inDontTrack:
;  *      A Boolean value indicating whether the control should hilite
;  *      when it is clicked on. False means hilite and track the mouse.
;  *    
;  *    outControl:
;  *      On successful output, outControl will contain a reference to
;  *      the Icon control.
;  *  
;  *  Result:
;  *    An OSStatus code indicating success or failure.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateIconControl" 
   ((inWindow (:pointer :OpaqueWindowPtr))      ;  can be NULL 
    (inBoundsRect (:pointer :Rect))
    (inIconContent (:pointer :ControlButtonContentInfo))
    (inDontTrack :Boolean)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Tagged data supported by icon controls 

(defconstant $kControlIconTransformTag :|trfm|) ;  IconTransformType

(defconstant $kControlIconAlignmentTag :|algn|) ;  IconAlignmentType

;  Tags available with appearance 1.1 or later 

(defconstant $kControlIconResourceIDTag :|ires|);  SInt16 resource ID of icon to use

(defconstant $kControlIconContentTag :|cont|)   ;  accepts a ControlButtonContentInfo

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ WINDOW HEADER (CDEF 21)                                                           
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  Window Header proc IDs 

(defconstant $kControlWindowHeaderProc #x150)   ;  normal header

(defconstant $kControlWindowListViewHeaderProc #x151);  variant for list views - no bottom line

;  Control Kind Tag 

(defconstant $kControlKindWindowHeader :|whed|)
; 
;  *  Summary:
;  *    Tags available with Mac OS X 10.3 or later
;  
; 
;    * Passed data is a Boolean.  Set to true if the control is to draw
;    * as a list header.
;    

(defconstant $kControlWindowHeaderIsListHeaderTag :|islh|)
;  The HIObject class ID for the HIWindowHeaderView class. 
; #define kHIWindowHeaderViewClassID      CFSTR("com.apple.HIWindowHeaderView")
;  Creation API: Carbon Only 
; 
;  *  CreateWindowHeaderControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateWindowHeaderControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (isListHeader :Boolean)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ LIST BOX (CDEF 22)                                                                
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   Lists use an auxiliary resource to define their format. The resource type used is   
;   'ldes' and a definition for it can be found in Appearance.r. The resource ID for    
;   the ldes is passed in the 'value' parameter when creating the control. You may pass 
;   zero in value. This tells the List Box control to not use a resource. The list will 
;   be created with default values, and will use the standard LDEF (0). You can change  
;   the list by getting the list handle. You can set the LDEF to use by using the tag   
;   below (kControlListBoxLDEFTag)                                                      
;  List Box proc IDs 

(defconstant $kControlListBoxProc #x160)
(defconstant $kControlListBoxAutoSizeProc #x161)
;  Control Kind Tag 

(defconstant $kControlKindListBox :|lbox|)
;  Creation API: Carbon Only 
; 
;  *  CreateListBoxControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateListBoxControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (autoSize :Boolean)
    (numRows :SInt16)
    (numColumns :SInt16)
    (horizScroll :Boolean)
    (vertScroll :Boolean)
    (cellHeight :SInt16)
    (cellWidth :SInt16)
    (hasGrowSpace :Boolean)
    (listDef (:pointer :ListDefSpec))
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Tagged data supported by list box 

(defconstant $kControlListBoxListHandleTag :|lhan|);  ListHandle

(defconstant $kControlListBoxKeyFilterTag :|fltr|);  ControlKeyFilterUPP

(defconstant $kControlListBoxFontStyleTag :|font|);  ControlFontStyleRec

;  New tags in 1.0.1 or later 

(defconstant $kControlListBoxDoubleClickTag :|dblc|);  Boolean. Was last click a double-click?

(defconstant $kControlListBoxLDEFTag :|ldef|)   ;  SInt16. ID of LDEF to use.

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ PUSH BUTTON (CDEF 23)                                                             
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   The new standard checkbox and radio button controls support a "mixed" value that    
;   indicates that the current setting contains a mixed set of on and off values. The   
;   control value used to display this indication is defined in Controls.h:             
;                                                                                       
;       kControlCheckBoxMixedValue = 2                                                  
;                                                                                       
;   Two new variants of the standard pushbutton have been added to the standard control 
;   suite that draw a color icon next to the control title. One variant draws the icon  
;   on the left side, the other draws it on the right side (when the system justifica-  
;   tion is right to left, these are reversed).                                         
;                                                                                       
;   When either of the icon pushbuttons are created, the contrlMax field of the control 
;   record is used to determine the ID of the 'cicn' resource drawn in the pushbutton.  
;                                                                                       
;   In addition, a push button can now be told to draw with a default outline using the 
;   SetControlData routine with the kControlPushButtonDefaultTag below.                 
;                                                                                       
;   A push button may also be marked using the kControlPushButtonCancelTag. This has    
;   no visible representation, but does cause the button to play the CancelButton theme 
;   sound instead of the regular pushbutton theme sound when pressed.                   
;                                                                                       
;  Theme Push Button/Check Box/Radio Button proc IDs 

(defconstant $kControlPushButtonProc #x170)
(defconstant $kControlCheckBoxProc #x171)
(defconstant $kControlRadioButtonProc #x172)
(defconstant $kControlPushButLeftIconProc #x176);  Standard pushbutton with left-side icon

(defconstant $kControlPushButRightIconProc #x177);  Standard pushbutton with right-side icon

;  Variants with Appearance 1.1 or later 

(defconstant $kControlCheckBoxAutoToggleProc #x173)
(defconstant $kControlRadioButtonAutoToggleProc #x174)
;  Push Button Icon Alignments 

(def-mactype :ControlPushButtonIconAlignment (find-mactype ':UInt16))

(defconstant $kControlPushButtonIconOnLeft 6)
(defconstant $kControlPushButtonIconOnRight 7)
;  Control Kind Tag 

(defconstant $kControlKindPushButton :|push|)
(defconstant $kControlKindPushIconButton :|picn|)
(defconstant $kControlKindRadioButton :|rdio|)
(defconstant $kControlKindCheckBox :|cbox|)
;  The HIObject class ID for the HIPushButton class. 
; #define kHIPushButtonClassID            CFSTR("com.apple.HIPushButton")
;  The HIObject class ID for the HICheckBox class. 
; #define kHICheckBoxClassID              CFSTR("com.apple.HICheckBox")
;  The HIObject class ID for the HIRadioButton class. 
; #define kHIRadioButtonClassID           CFSTR("com.apple.HIRadioButton")
;  Creation APIs: Carbon Only 
; 
;  *  CreatePushButtonControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreatePushButtonControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (title (:pointer :__CFString))
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreatePushButtonWithIconControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreatePushButtonWithIconControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (title (:pointer :__CFString))
    (icon (:pointer :ControlButtonContentInfo))
    (iconAlignment :UInt16)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateRadioButtonControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateRadioButtonControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (title (:pointer :__CFString))
    (initialValue :SInt32)
    (autoToggle :Boolean)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateCheckBoxControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateCheckBoxControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (title (:pointer :__CFString))
    (initialValue :SInt32)
    (autoToggle :Boolean)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Tagged data supported by standard buttons 

(defconstant $kControlPushButtonDefaultTag :|dflt|);  default ring flag

(defconstant $kControlPushButtonCancelTag :|cncl|);  cancel button flag (1.1 and later)

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ SCROLL BAR (CDEF 24)                                                              
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   This is the new Appearance scroll bar.                                              
;                                                                                       
;                                                                                       
;   Mac OS X has a "Scroll to here" option in the General pane of System Preferences    
;   which allows users to click in the page up/down regions of a scroll bar and have    
;   the thumb/indicator jump directly to the clicked position, which alters the value   
;   of the scroll bar and moves the scrolled content appropriately. As long as the      
;   mouse button is held down, the click is treated as though the user had clicked in   
;   the thumb/indicator in the first place.                                             
;                                                                                       
;   If you want the scroll bars in your application to work with the "Scroll to here"   
;   option, you must do the following:                                                  
;                                                                                       
;   1. Create live-tracking scroll bars, not scroll bars that show a "ghost" thumb      
;   when you click on it. You can request live-tracking scroll bars by passing true     
;   in the liveTracking parameter to CreateScrollBarControl. If you create scroll bars  
;   with NewControl, use the kControlScrollBarLiveProc.                                 
;                                                                                       
;   2. Write an appropriate ControlActionProc and associate it with your scroll bar     
;   via the SetControlAction API. This allows your application to update its content    
;   appropriately when the live-tracking scroll bar is clicked.                         
;                                                                                       
;   3. When calling HandleControlClick or TrackControl, pass -1 in the action proc      
;   parameter. This is a request for the Control Manager to use the action proc you     
;   associated with your control in step 2. If you rely on the standard window event    
;   handler to do your control tracking, this step is handled for you automatically.    
;                                                                                       
;  Theme Scroll Bar proc IDs 

(defconstant $kControlScrollBarProc #x180)      ;  normal scroll bar

(defconstant $kControlScrollBarLiveProc #x182)  ;  live scrolling variant

;  Control Kind Tag 

(defconstant $kControlKindScrollBar :|sbar|)
;  The HIObject class ID for the HIScrollBar class. 
; #define kHIScrollBarClassID             CFSTR("com.apple.HIScrollBar")
; 
;  *  CreateScrollBarControl()
;  *  
;  *  Summary:
;  *    Creates a scroll bar control.
;  *  
;  *  Discussion:
;  *    This creation API is available in Carbon only.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window that should contain the control. May be NULL on Mac
;  *      OS X 10.3 and later.
;  *    
;  *    boundsRect:
;  *      The bounding box of the control.
;  *    
;  *    value:
;  *      The initial value of the control.
;  *    
;  *    minimum:
;  *      The minimum value of the control.
;  *    
;  *    maximum:
;  *      The maximum value of the control.
;  *    
;  *    viewSize:
;  *      Whether the width of the control is allowed to vary according
;  *      to the width of the
;  *    
;  *    liveTracking:
;  *      A Boolean indicating whether or not live tracking is enabled
;  *      for this scroll bar. If set to true and a valid
;  *      liveTrackingProc is also passed in, the callback will be called
;  *      repeatedly as the thumb is moved during tracking.  If set to
;  *      false, a semi-transparent thumb called a "ghost thumb" will
;  *      draw and no live tracking will occur.
;  *    
;  *    liveTrackingProc:
;  *      If liveTracking is on, a ControlActionUPP callback to be called
;  *      as the control live tracks.  This callback is called repeatedly
;  *      as the scroll thumb is moved during tracking.
;  *    
;  *    outControl:
;  *      On exit, contains the new control.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateScrollBarControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (value :SInt32)
    (minimum :SInt32)
    (maximum :SInt32)
    (viewSize :SInt32)
    (liveTracking :Boolean)
    (liveTrackingProc (:pointer :OpaqueControlActionProcPtr))
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  These tags are available in Mac OS X or later 

(defconstant $kControlScrollBarShowsArrowsTag :|arro|);  Boolean whether or not to draw the scroll arrows

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ POPUP BUTTON (CDEF 25)                                                            
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   This is the new Appearance Popup Button. It takes the same variants and does the    
;   same overloading as the previous popup menu control. There are some differences:    
;                                                                                       
;   Passing in a menu ID of -12345 causes the popup not to try and get the menu from a  
;   resource. Instead, you can build the menu and later stuff the MenuRef field in      
;   the popup data information.                                                         
;                                                                                       
;   You can pass -1 in the Max parameter to have the control calculate the width of the 
;   title on its own instead of guessing and then tweaking to get it right. It adds the 
;   appropriate amount of space between the title and the popup.                        
;                                                                                       
;  Theme Popup Button proc IDs 

(defconstant $kControlPopupButtonProc #x190)
(defconstant $kControlPopupFixedWidthVariant 1)
(defconstant $kControlPopupVariableWidthVariant 2)
(defconstant $kControlPopupUseAddResMenuVariant 4)
(defconstant $kControlPopupUseWFontVariant 8)
;  Control Kind Tag 

(defconstant $kControlKindPopupButton :|popb|)
;  The HIObject class ID for the HIPopupButton class. 
; #define kHIPopupButtonClassID           CFSTR("com.apple.HIPopupButton")
; 
;  *  CreatePopupButtonControl()
;  *  
;  *  Summary:
;  *    Creates a popup button control.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window that should contain the control. May be NULL on Mac
;  *      OS X 10.3 and later.
;  *    
;  *    boundsRect:
;  *      The bounding box of the control.
;  *    
;  *    title:
;  *      The title of the control.
;  *    
;  *    menuID:
;  *      The ID of a menu that should be used by the control. A menu
;  *      with this ID should be inserted into the menubar with
;  *      InsertMenu(menu, kInsertHierarchicalMenu). You can also pass
;  *      -12345 to have the control delay its acquisition of a menu; in
;  *      this case, you can build the menu and later provide it to the
;  *      control with SetControlData and kControlPopupButtonMenuRefTag
;  *      or kControlPopupButtonOwnedMenuRefTag.
;  *    
;  *    variableWidth:
;  *      Whether the width of the control is allowed to vary according
;  *      to the width of the selected menu item text, or should remain
;  *      fixed to the original control bounds width.
;  *    
;  *    titleWidth:
;  *      The width of the title.
;  *    
;  *    titleJustification:
;  *      The justification of the title.
;  *    
;  *    titleStyle:
;  *      A QuickDraw style bitfield indicating the font style of the
;  *      title.
;  *    
;  *    outControl:
;  *      On exit, contains the new control.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreatePopupButtonControl" 
   ((window (:pointer :OpaqueWindowPtr))        ;  can be NULL 
    (boundsRect (:pointer :Rect))
    (title (:pointer :__CFString))
    (menuID :SInt16)
    (variableWidth :Boolean)
    (titleWidth :SInt16)
    (titleJustification :SInt16)
    (titleStyle :UInt8)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  These tags are available in 1.0.1 or later of Appearance 

(defconstant $kControlPopupButtonMenuHandleTag :|mhan|);  MenuRef

(defconstant $kControlPopupButtonMenuRefTag :|mhan|);  MenuRef

(defconstant $kControlPopupButtonMenuIDTag :|mnid|);  SInt16

;  These tags are available in 1.1 or later of Appearance 

(defconstant $kControlPopupButtonExtraHeightTag :|exht|);  SInt16 - extra vertical whitespace within the button

(defconstant $kControlPopupButtonOwnedMenuRefTag :|omrf|);  MenuRef

;  These tags are available in Mac OS X 

(defconstant $kControlPopupButtonCheckCurrentTag :|chck|);  Boolean    - whether the popup puts a checkmark next to the current item (defaults to true)

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ RADIO GROUP (CDEF 26)                                                             
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   This control implements a radio group. It is an embedding control and can therefore 
;   only be used when a control hierarchy is established for its owning window. You     
;   should only embed radio buttons within it. As radio buttons are embedded into it,   
;   the group sets up its value, min, and max to represent the number of embedded items.
;   The current value of the control is the index of the sub-control that is the current
;   'on' radio button. To get the current radio button control handle, you can use the  
;   control manager call GetIndSubControl, passing in the value of the radio group.     
;                                                                                       
;   NOTE: This control is only available with Appearance 1.0.1.                         
;  Radio Group Proc ID 

(defconstant $kControlRadioGroupProc #x1A0)
;  Control Kind Tag 

(defconstant $kControlKindRadioGroup :|rgrp|)
;  The HIObject class ID for the HIRadioGroup class. 
; #define kHIRadioGroupClassID            CFSTR("com.apple.HIRadioGroup")
;  Creation API: Carbon Only 
; 
;  *  CreateRadioGroupControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateRadioGroupControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ SCROLL TEXT BOX (CDEF 27)                                                         
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   This control implements a scrolling box of (non-editable) text. This is useful for  
;   credits in about boxes, etc.                                                        
;   The standard version of this control has a scroll bar, but the autoscrolling        
;   variant does not. The autoscrolling variant needs two pieces of information to      
;   work: delay (in ticks) before the scrolling starts, and time (in ticks) between     
;   scrolls. It will scroll one pixel at a time, unless changed via SetControlData.     
;                                                                                       
;   Parameter                   What Goes Here                                          
;   ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ         ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ    
;   Value                       Resource ID of 'TEXT'/'styl' content.                   
;   Min                         Scroll start delay (in ticks)                       .   
;   Max                         Delay (in ticks) between scrolls.                       
;                                                                                       
;   NOTE: This control is only available with Appearance 1.1.                           
;  Scroll Text Box Proc IDs 

(defconstant $kControlScrollTextBoxProc #x1B0)
(defconstant $kControlScrollTextBoxAutoScrollProc #x1B1)
;  Control Kind Tag 

(defconstant $kControlKindScrollingTextBox :|stbx|)
;  Creation API: Carbon Only 
; 
;  *  CreateScrollingTextBoxControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateScrollingTextBoxControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (contentResID :SInt16)
    (autoScroll :Boolean)
    (delayBeforeAutoScroll :UInt32)
    (delayBetweenAutoScroll :UInt32)
    (autoScrollAmount :UInt16)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Tagged data supported by Scroll Text Box 

(defconstant $kControlScrollTextBoxDelayBeforeAutoScrollTag :|stdl|);  UInt32 (ticks until autoscrolling starts)

(defconstant $kControlScrollTextBoxDelayBetweenAutoScrollTag :|scdl|);  UInt32 (ticks between scrolls)

(defconstant $kControlScrollTextBoxAutoScrollAmountTag :|samt|);  UInt16 (pixels per scroll) -- defaults to 1

(defconstant $kControlScrollTextBoxContentsTag :|tres|);  SInt16 (resource ID of 'TEXT'/'styl') -- write only!

(defconstant $kControlScrollTextBoxAnimatingTag :|anim|);  Boolean (whether the text box should auto-scroll)

; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ DISCLOSURE BUTTON                                                                 
;   (CDEF 30)                                                                           
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;  The HIObject class ID for the HIDisclosureButton class. 
; #define kHIDisclosureButtonClassID      CFSTR("com.apple.HIDisclosureButton")
; 
;  *  CreateDisclosureButtonControl()
;  *  
;  *  Summary:
;  *    Creates a new instance of the Disclosure Button Control.
;  *  
;  *  Discussion:
;  *    CreateDisclosureButtonControl is preferred over NewControl
;  *    because it allows you to specify the exact set of parameters
;  *    required to create the control without overloading parameter
;  *    semantics. The initial minimum of the Disclosure Button will be
;  *    kControlDisclosureButtonClosed, and the maximum will be
;  *    kControlDisclosureButtonDisclosed.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The WindowRef in which to create the control.
;  *    
;  *    inBoundsRect:
;  *      The bounding rectangle for the control. The height of the
;  *      control is fixed and the control will be centered vertically
;  *      within the rectangle you specify.
;  *    
;  *    inValue:
;  *      The initial value; either kControlDisclosureButtonClosed or
;  *      kControlDisclosureButtonDisclosed.
;  *    
;  *    inAutoToggles:
;  *      A boolean value indicating whether its value should change
;  *      automatically after tracking the mouse.
;  *    
;  *    outControl:
;  *      On successful exit, this will contain the new control.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateDisclosureButtonControl" 
   ((inWindow (:pointer :OpaqueWindowPtr))
    (inBoundsRect (:pointer :Rect))
    (inValue :SInt32)
    (inAutoToggles :Boolean)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Control Kind Tag 

(defconstant $kControlKindDisclosureButton :|disb|)
; 
;  *  Discussion:
;  *    Disclosure Button Values
;  
; 
;    * The control be drawn suggesting a closed state.
;    

(defconstant $kControlDisclosureButtonClosed 0)
; 
;    * The control will be drawn suggesting an open state.
;    

(defconstant $kControlDisclosureButtonDisclosed 1)
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ ROUND BUTTON                                                                      
;   (CDEF 31)                                                                           
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
; 
;  *  ControlRoundButtonSize
;  *  
;  *  Discussion:
;  *    Button Sizes
;  

(def-mactype :ControlRoundButtonSize (find-mactype ':SInt16))
; 
;    * A 20 pixel diameter button.
;    

(defconstant $kControlRoundButtonNormalSize 0)
; 
;    * A 25 pixel diameter button.
;    

(defconstant $kControlRoundButtonLargeSize 2)
;  Data tags supported by the round button controls 

(defconstant $kControlRoundButtonContentTag :|cont|);  ControlButtonContentInfo

(defconstant $kControlRoundButtonSizeTag :|size|);  ControlRoundButtonSize

;  Control Kind Tag 

(defconstant $kControlKindRoundButton :|rndb|)
;  The HIObject class ID for the HIRoundButton class. 
; #define kHIRoundButtonClassID           CFSTR("com.apple.HIRoundButton")
; 
;  *  CreateRoundButtonControl()
;  *  
;  *  Summary:
;  *    Creates a new instance of the Round Button Control.
;  *  
;  *  Discussion:
;  *    CreateRoundButtonControl is preferred over NewControl because it
;  *    allows you to specify the exact set of parameters required to
;  *    create the control without overloading parameter semantics.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inWindow:
;  *      The WindowRef in which to create the control. May be NULL in
;  *      Mac OS X 10.3 and later.
;  *    
;  *    inBoundsRect:
;  *      The bounding rectangle for the control. The height and width of
;  *      the control is fixed (specified by the ControlRoundButtonSize
;  *      parameter) and the control will be centered within the
;  *      rectangle you specify.
;  *    
;  *    inSize:
;  *      The button size; either kControlRoundButtonNormalSize or
;  *      kControlRoundButtonLargeSize.
;  *    
;  *    inContent:
;  *      Any optional content displayed in the button. Currently only
;  *      kControlContentIconRef is supported. May be NULL.
;  *    
;  *    outControl:
;  *      On successful exit, this will contain the new control.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateRoundButtonControl" 
   ((inWindow (:pointer :OpaqueWindowPtr))      ;  can be NULL 
    (inBoundsRect (:pointer :Rect))
    (inSize :SInt16)
    (inContent (:pointer :ControlButtonContentInfo));  can be NULL 
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;     ¥ DATA BROWSER                                                                    
;      (CDEF 29)                                                                        
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   This control implements a user interface component for browsing (optionally)        
;   hiearchical data structures. The browser supports multiple presentation styles      
;   including, but not limited to:                                                      
;                                                                                       
;       kDataBrowserListView   - items and item properties in                           
;                                multi-column (optionally outline) format               
;       kDataBrowserColumnView - in-place browsing using fixed navigation columns       
;                                                                                       
;   The browser manages all view styles through a single high-level interface.          
;   The high-level interface makes the following assumptions:                           
;                                                                                       
;       - Items have unique 32-bit identifiers (0 is reserved)                          
;                                                                                       
;       - Items have two kinds of named and typed properties:                           
;            - Predefined attribute properties ( < 1024 )                               
;              (including some display properties)                                      
;            - Client-defined display properties ( >= 1024 )                            
;                                                                                       
;       - Some items are containers of other items                                      
;       - Items may be sorted by any property                                           
;                                                                                       
;   Because a browser doesn't know all details about the type of objects it manages,    
;   some implementation responsibility is best handled by its client. The client must   
;   provide a set of callback routines which define the item hierarchy and help to      
;   populate the browser with items. The client may also provide callbacks for handling 
;   custom data types and doing low-level event management.                             
;                                                                                       
;   The API is subdivided into a "universal" set of routines that applies to all view   
;   styles, and a set of routines unique to each view style. kDataBrowserListView and   
;   kDataBrowserColumnView share an (internal) TableView abstract base class. The       
;   TableView formatting options and API applies to both of these view styles.          
;                                                                                       
;   NOTE: This control is only available with CarbonLib 1.1.                            
;                                                                                       
;   NOTE: This control must be created with the CreateDataBrowserControl API in         
;         CarbonLib 1.1 through 1.4. In Mac OS X and CarbonLib 1.5 and later, you       
;         may use the control's procID (29) to create the control with NewControl       
;         or with a 'CNTL' resource.                                                    
;  Control Kind Tag 

(defconstant $kControlKindDataBrowser :|datb|)
;  Error Codes 

(defconstant $errDataBrowserNotConfigured -4970)
(defconstant $errDataBrowserItemNotFound -4971)
(defconstant $errDataBrowserItemNotAdded -4975)
(defconstant $errDataBrowserPropertyNotFound -4972)
(defconstant $errDataBrowserInvalidPropertyPart -4973)
(defconstant $errDataBrowserInvalidPropertyData -4974);  Return from DataBrowserGetSetItemDataProc 

(defconstant $errDataBrowserPropertyNotSupported -4979)
;  Generic Control Tags 

(defconstant $kControlDataBrowserIncludesFrameAndFocusTag :|brdr|);  Boolean 

(defconstant $kControlDataBrowserKeyFilterTag :|fltr|)
(defconstant $kControlDataBrowserEditTextKeyFilterTag :|fltr|)
(defconstant $kControlDataBrowserEditTextValidationProcTag :|vali|)
;  Data Browser View Styles 

(def-mactype :DataBrowserViewStyle (find-mactype ':OSType))

(defconstant $kDataBrowserNoView #x3F3F3F3F)    ;  Error State 

(defconstant $kDataBrowserListView :|lstv|)
(defconstant $kDataBrowserColumnView :|clmv|)
;  Selection Flags 

(def-mactype :DataBrowserSelectionFlags (find-mactype ':UInt32))

(defconstant $kDataBrowserDragSelect 1)         ;  Å ListMgr lNoRect 

(defconstant $kDataBrowserSelectOnlyOne 2)      ;  Å ListMgr lOnlyOne 

(defconstant $kDataBrowserResetSelection 4)     ;  Å ListMgr lNoExtend 

(defconstant $kDataBrowserCmdTogglesSelection 8);  Å ListMgr lUseSense 

(defconstant $kDataBrowserNoDisjointSelection 16);  Å ListMgr lNoDisjoint 

(defconstant $kDataBrowserAlwaysExtendSelection 32);  Å ListMgr lExtendDrag 
;  Å ListMgr lNoNilHilite 

(defconstant $kDataBrowserNeverEmptySelectionSet 64)
;  Data Browser Sorting 

(def-mactype :DataBrowserSortOrder (find-mactype ':UInt16))

(defconstant $kDataBrowserOrderUndefined 0)     ;  Not currently supported 

(defconstant $kDataBrowserOrderIncreasing 1)
(defconstant $kDataBrowserOrderDecreasing 2)
;  Data Browser Item Management 

(def-mactype :DataBrowserItemID (find-mactype ':UInt32))

(defconstant $kDataBrowserNoItem 0)             ;  Reserved DataBrowserItemID 


(def-mactype :DataBrowserItemState (find-mactype ':UInt32))

(defconstant $kDataBrowserItemNoState 0)
(defconstant $kDataBrowserItemAnyState -1)
(defconstant $kDataBrowserItemIsSelected 1)
(defconstant $kDataBrowserContainerIsOpen 2)    ;  During a drag operation 

(defconstant $kDataBrowserItemIsDragTarget 4)
;  Options for use with RevealDataBrowserItem 

(def-mactype :DataBrowserRevealOptions (find-mactype ':UInt8))

(defconstant $kDataBrowserRevealOnly 0)
(defconstant $kDataBrowserRevealAndCenterInView 1)
(defconstant $kDataBrowserRevealWithoutSelecting 2)
;  Set operations for use with SetDataBrowserSelectedItems 

(def-mactype :DataBrowserSetOption (find-mactype ':UInt32))

(defconstant $kDataBrowserItemsAdd 0)           ;  add specified items to existing set 

(defconstant $kDataBrowserItemsAssign 1)        ;  assign destination set to specified items 

(defconstant $kDataBrowserItemsToggle 2)        ;  toggle membership state of specified items 

(defconstant $kDataBrowserItemsRemove 3)        ;  remove specified items from existing set 

;  Commands for use with MoveDataBrowserSelectionAnchor 

(def-mactype :DataBrowserSelectionAnchorDirection (find-mactype ':UInt32))

(defconstant $kDataBrowserSelectionAnchorUp 0)
(defconstant $kDataBrowserSelectionAnchorDown 1)
(defconstant $kDataBrowserSelectionAnchorLeft 2)
(defconstant $kDataBrowserSelectionAnchorRight 3)
;  Edit menu command IDs for use with Enable/ExecuteDataBrowserEditCommand 

(def-mactype :DataBrowserEditCommand (find-mactype ':UInt32))

(defconstant $kDataBrowserEditMsgUndo :|undo|)
(defconstant $kDataBrowserEditMsgRedo :|redo|)
(defconstant $kDataBrowserEditMsgCut :|cut |)
(defconstant $kDataBrowserEditMsgCopy :|copy|)
(defconstant $kDataBrowserEditMsgPaste :|past|)
(defconstant $kDataBrowserEditMsgClear :|clea|)
(defconstant $kDataBrowserEditMsgSelectAll :|sall|)
;  Notifications used in DataBrowserItemNotificationProcPtr 

(def-mactype :DataBrowserItemNotification (find-mactype ':UInt32))

(defconstant $kDataBrowserItemAdded 1)          ;  The specified item has been added to the browser 

(defconstant $kDataBrowserItemRemoved 2)        ;  The specified item has been removed from the browser 

(defconstant $kDataBrowserEditStarted 3)        ;  Starting an EditText session for specified item 

(defconstant $kDataBrowserEditStopped 4)        ;  Stopping an EditText session for specified item 

(defconstant $kDataBrowserItemSelected 5)       ;  Item has just been added to the selection set 

(defconstant $kDataBrowserItemDeselected 6)     ;  Item has just been removed from the selection set 

(defconstant $kDataBrowserItemDoubleClicked 7)
(defconstant $kDataBrowserContainerOpened 8)    ;  Container is open 

(defconstant $kDataBrowserContainerClosing 9)   ;  Container is about to close (and will real soon now, y'all) 

(defconstant $kDataBrowserContainerClosed 10)   ;  Container is closed (y'all come back now!) 

(defconstant $kDataBrowserContainerSorting 11)  ;  Container is about to be sorted (lock any volatile properties) 

(defconstant $kDataBrowserContainerSorted 12)   ;  Container has been sorted (you may release any property locks) 

(defconstant $kDataBrowserUserToggledContainer 16);  _User_ requested container open/close state to be toggled 

(defconstant $kDataBrowserTargetChanged 15)     ;  The target has changed to the specified item 

(defconstant $kDataBrowserUserStateChanged 13)  ;  The user has reformatted the view for the target 

(defconstant $kDataBrowserSelectionSetChanged 14);  The selection set has been modified (net result may be the same) 

;  DataBrowser Property Management 
;  0-1023 reserved; >= 1024 for client use 

(def-mactype :DataBrowserPropertyID (find-mactype ':UInt32))
;  Predefined attribute properties, optional & non-display unless otherwise stated 

(defconstant $kDataBrowserItemNoProperty 0)     ;  The anti-property (no associated data) 

(defconstant $kDataBrowserItemIsActiveProperty 1);  Boolean typed data (defaults to true) 

(defconstant $kDataBrowserItemIsSelectableProperty 2);  Boolean typed data (defaults to true) 

(defconstant $kDataBrowserItemIsEditableProperty 3);  Boolean typed data (defaults to false, used for editable properties) 

(defconstant $kDataBrowserItemIsContainerProperty 4);  Boolean typed data (defaults to false) 

(defconstant $kDataBrowserContainerIsOpenableProperty 5);  Boolean typed data (defaults to true) 

(defconstant $kDataBrowserContainerIsClosableProperty 6);  Boolean typed data (defaults to true) 

(defconstant $kDataBrowserContainerIsSortableProperty 7);  Boolean typed data (defaults to true) 

(defconstant $kDataBrowserItemSelfIdentityProperty 8);  kDataBrowserIconAndTextType (display property; ColumnView only) 

(defconstant $kDataBrowserContainerAliasIDProperty 9);  DataBrowserItemID (alias/symlink an item to a container item) 

(defconstant $kDataBrowserColumnViewPreviewProperty 10);  kDataBrowserCustomType (display property; ColumnView only) 

(defconstant $kDataBrowserItemParentContainerProperty 11);  DataBrowserItemID (the parent of the specified item, used by ColumnView) 

;  DataBrowser Property Types (for display properties; i.e. ListView columns) 
;       These are primarily presentation types (or styles) although         
;       they also imply a particular set of primitive types or structures.  

(def-mactype :DataBrowserPropertyType (find-mactype ':OSType))
;  == Corresponding data type or structure == 

(defconstant $kDataBrowserCustomType #x3F3F3F3F);  No associated data, custom callbacks used 

(defconstant $kDataBrowserIconType :|icnr|)     ;  IconRef, IconTransformType, RGBColor 

(defconstant $kDataBrowserTextType :|text|)     ;  CFStringRef 

(defconstant $kDataBrowserDateTimeType :|date|) ;  DateTime or LongDateTime 

(defconstant $kDataBrowserSliderType :|sldr|)   ;  Min, Max, Value 

(defconstant $kDataBrowserCheckboxType :|chbx|) ;  ThemeButtonValue 

(defconstant $kDataBrowserProgressBarType :|prog|);  Min, Max, Value 

(defconstant $kDataBrowserRelevanceRankType :|rank|);  Min, Max, Value 

(defconstant $kDataBrowserPopupMenuType :|menu|);  MenuRef, Value 

(defconstant $kDataBrowserIconAndTextType :|ticn|);  IconRef, CFStringRef, etc 

;  DataBrowser Property Parts 
;       Visual components of a property type.      
;       For use with GetDataBrowserItemPartBounds. 

(def-mactype :DataBrowserPropertyPart (find-mactype ':OSType))

(defconstant $kDataBrowserPropertyEnclosingPart 0)
(defconstant $kDataBrowserPropertyContentPart :|----|)
(defconstant $kDataBrowserPropertyDisclosurePart :|disc|)
(defconstant $kDataBrowserPropertyTextPart :|text|)
(defconstant $kDataBrowserPropertyIconPart :|icnr|)
(defconstant $kDataBrowserPropertySliderPart :|sldr|)
(defconstant $kDataBrowserPropertyCheckboxPart :|chbx|)
(defconstant $kDataBrowserPropertyProgressBarPart :|prog|)
(defconstant $kDataBrowserPropertyRelevanceRankPart :|rank|)
;  Modify appearance/behavior of display properties 

(def-mactype :DataBrowserPropertyFlags (find-mactype ':UInt32))
;  Low 8 bits apply to all property types 

(defconstant $kDataBrowserUniversalPropertyFlagsMask #xFF)
(defconstant $kDataBrowserPropertyIsMutable 1)
(defconstant $kDataBrowserDefaultPropertyFlags 0)
(defconstant $kDataBrowserUniversalPropertyFlags #xFF);  support for an old name

(defconstant $kDataBrowserPropertyIsEditable 1) ;  support for an old name

;  Next 8 bits contain property-specific modifiers 

(defconstant $kDataBrowserPropertyFlagsOffset 8)
(defconstant $kDataBrowserPropertyFlagsMask #xFF00)
(defconstant $kDataBrowserCheckboxTriState #x100);  kDataBrowserCheckboxType

(defconstant $kDataBrowserDateTimeRelative #x100);  kDataBrowserDateTimeType 

(defconstant $kDataBrowserDateTimeDateOnly #x200);  kDataBrowserDateTimeType 

(defconstant $kDataBrowserDateTimeTimeOnly #x400);  kDataBrowserDateTimeType 

(defconstant $kDataBrowserDateTimeSecondsToo #x800);  kDataBrowserDateTimeType 

(defconstant $kDataBrowserSliderPlainThumb 0)   ;  kDataBrowserSliderType 

(defconstant $kDataBrowserSliderUpwardThumb #x100);  kDataBrowserSliderType 

(defconstant $kDataBrowserSliderDownwardThumb #x200);  kDataBrowserSliderType 

(defconstant $kDataBrowserDoNotTruncateText #x300);  kDataBrowserTextType && kDataBrowserIconAndTextType 

(defconstant $kDataBrowserTruncateTextAtEnd #x200);  kDataBrowserTextType && kDataBrowserIconAndTextType 

(defconstant $kDataBrowserTruncateTextMiddle 0) ;  kDataBrowserTextType && kDataBrowserIconAndTextType 

(defconstant $kDataBrowserTruncateTextAtStart #x100);  kDataBrowserTextType && kDataBrowserIconAndTextType 

(defconstant $kDataBrowserPropertyModificationFlags #xFF00);  support for an old name

(defconstant $kDataBrowserRelativeDateTime #x100);  support for an old name

; 
;    Next 8 bits contain viewStyle-specific modifiers 
;    See individual ViewStyle sections below for flag definitions 
; 

(defconstant $kDataBrowserViewSpecificFlagsOffset 16)
(defconstant $kDataBrowserViewSpecificFlagsMask #xFF0000)
(defconstant $kDataBrowserViewSpecificPropertyFlags #xFF0000);  support for an old name

;  High 8 bits are reserved for client application use 

(defconstant $kDataBrowserClientPropertyFlagsOffset 24)
(defconstant $kDataBrowserClientPropertyFlagsMask #xFF000000)
;  Client defined property description 
(defrecord DataBrowserPropertyDesc
   (propertyID :UInt32)
   (propertyType :OSType)
   (propertyFlags :UInt32)
)

;type name? (%define-record :DataBrowserPropertyDesc (find-record-descriptor ':DataBrowserPropertyDesc))
;  Callback definition for use with ForEachDataBrowserItem 

(def-mactype :DataBrowserItemProcPtr (find-mactype ':pointer)); (DataBrowserItemID item , DataBrowserItemState state , void * clientData)

(def-mactype :DataBrowserItemUPP (find-mactype '(:pointer :OpaqueDataBrowserItemProcPtr)))
; 
;  *  NewDataBrowserItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserItemUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDataBrowserItemProcPtr)
() )
; 
;  *  DisposeDataBrowserItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserItemUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDataBrowserItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserItemUPP" 
   ((item :UInt32)
    (state :UInt32)
    (clientData :pointer)
    (userUPP (:pointer :OpaqueDataBrowserItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  Creation/Configuration 
; 
;  *  CreateDataBrowserControl()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateDataBrowserControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (style :OSType)
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserViewStyle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserViewStyle" 
   ((browser (:pointer :OpaqueControlRef))
    (style (:pointer :DATABROWSERVIEWSTYLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserViewStyle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserViewStyle" 
   ((browser (:pointer :OpaqueControlRef))
    (style :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Item Manipulation 
;  Passing NULL for "items" argument to RemoveDataBrowserItems and 
;  UpdateDataBrowserItems refers to all items in the specified container. 
;  Passing NULL for "items" argument to AddDataBrowserItems means 
;  "generate IDs starting from 1." 
; 
;  *  AddDataBrowserItems()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AddDataBrowserItems" 
   ((browser (:pointer :OpaqueControlRef))
    (container :UInt32)
    (numItems :UInt32)
    (items (:pointer :DATABROWSERITEMID))       ;  can be NULL 
    (preSortProperty :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RemoveDataBrowserItems()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RemoveDataBrowserItems" 
   ((browser (:pointer :OpaqueControlRef))
    (container :UInt32)
    (numItems :UInt32)
    (items (:pointer :DATABROWSERITEMID))       ;  can be NULL 
    (preSortProperty :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  UpdateDataBrowserItems()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_UpdateDataBrowserItems" 
   ((browser (:pointer :OpaqueControlRef))
    (container :UInt32)
    (numItems :UInt32)
    (items (:pointer :DATABROWSERITEMID))       ;  can be NULL 
    (preSortProperty :UInt32)
    (propertyID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Edit Menu Enabling and Handling 
; 
;  *  EnableDataBrowserEditCommand()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_EnableDataBrowserEditCommand" 
   ((browser (:pointer :OpaqueControlRef))
    (command :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  ExecuteDataBrowserEditCommand()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ExecuteDataBrowserEditCommand" 
   ((browser (:pointer :OpaqueControlRef))
    (command :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserSelectionAnchor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserSelectionAnchor" 
   ((browser (:pointer :OpaqueControlRef))
    (first (:pointer :DATABROWSERITEMID))
    (last (:pointer :DATABROWSERITEMID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  MoveDataBrowserSelectionAnchor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_MoveDataBrowserSelectionAnchor" 
   ((browser (:pointer :OpaqueControlRef))
    (direction :UInt32)
    (extendSelection :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Container Manipulation 
; 
;  *  OpenDataBrowserContainer()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_OpenDataBrowserContainer" 
   ((browser (:pointer :OpaqueControlRef))
    (container :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CloseDataBrowserContainer()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CloseDataBrowserContainer" 
   ((browser (:pointer :OpaqueControlRef))
    (container :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SortDataBrowserContainer()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SortDataBrowserContainer" 
   ((browser (:pointer :OpaqueControlRef))
    (container :UInt32)
    (sortChildren :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Aggregate Item Access and Iteration 
; 
;  *  GetDataBrowserItems()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItems" 
   ((browser (:pointer :OpaqueControlRef))
    (container :UInt32)
    (recurse :Boolean)
    (state :UInt32)
    (items :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemCount()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemCount" 
   ((browser (:pointer :OpaqueControlRef))
    (container :UInt32)
    (recurse :Boolean)
    (state :UInt32)
    (numItems (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ForEachDataBrowserItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ForEachDataBrowserItem" 
   ((browser (:pointer :OpaqueControlRef))
    (container :UInt32)
    (recurse :Boolean)
    (state :UInt32)
    (callback (:pointer :OpaqueDataBrowserItemProcPtr))
    (clientData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Individual Item Access and Display 
; 
;  *  IsDataBrowserItemSelected()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsDataBrowserItemSelected" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  GetDataBrowserItemState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemState" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
    (state (:pointer :DATABROWSERITEMSTATE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RevealDataBrowserItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RevealDataBrowserItem" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
    (propertyID :UInt32)
    (options :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Selection Set Manipulation 
; 
;  *  SetDataBrowserSelectedItems()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserSelectedItems" 
   ((browser (:pointer :OpaqueControlRef))
    (numItems :UInt32)
    (items (:pointer :DATABROWSERITEMID))
    (operation :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  DataBrowser Attribute Manipulation 
;  The user customizable portion of the current view style settings 
; 
;  *  SetDataBrowserUserState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserUserState" 
   ((browser (:pointer :OpaqueControlRef))
    (stateInfo (:pointer :__CFData))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserUserState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserUserState" 
   ((browser (:pointer :OpaqueControlRef))
    (stateInfo (:pointer :CFDataRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  All items are active/enabled or not 
; 
;  *  SetDataBrowserActiveItems()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserActiveItems" 
   ((browser (:pointer :OpaqueControlRef))
    (active :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserActiveItems()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserActiveItems" 
   ((browser (:pointer :OpaqueControlRef))
    (active (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Inset the scrollbars within the DataBrowser bounds 
; 
;  *  SetDataBrowserScrollBarInset()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserScrollBarInset" 
   ((browser (:pointer :OpaqueControlRef))
    (insetRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserScrollBarInset()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserScrollBarInset" 
   ((browser (:pointer :OpaqueControlRef))
    (insetRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  The "user focused" item 
;  For the ListView, this means the root container 
;  For the ColumnView, this means the rightmost container column 
; 
;  *  SetDataBrowserTarget()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserTarget" 
   ((browser (:pointer :OpaqueControlRef))
    (target :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserTarget()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserTarget" 
   ((browser (:pointer :OpaqueControlRef))
    (target (:pointer :DATABROWSERITEMID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Current sort ordering 
;  ListView tracks this per-column 
; 
;  *  SetDataBrowserSortOrder()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserSortOrder" 
   ((browser (:pointer :OpaqueControlRef))
    (order :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserSortOrder()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserSortOrder" 
   ((browser (:pointer :OpaqueControlRef))
    (order (:pointer :DATABROWSERSORTORDER))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Scrollbar values 
; 
;  *  SetDataBrowserScrollPosition()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserScrollPosition" 
   ((browser (:pointer :OpaqueControlRef))
    (top :UInt32)
    (left :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserScrollPosition()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserScrollPosition" 
   ((browser (:pointer :OpaqueControlRef))
    (top (:pointer :UInt32))
    (left (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Show/Hide each scrollbar 
; 
;  *  SetDataBrowserHasScrollBars()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserHasScrollBars" 
   ((browser (:pointer :OpaqueControlRef))
    (horiz :Boolean)
    (vert :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserHasScrollBars()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserHasScrollBars" 
   ((browser (:pointer :OpaqueControlRef))
    (horiz (:pointer :Boolean))
    (vert (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Property passed to sort callback (ListView sort column) 
; 
;  *  SetDataBrowserSortProperty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserSortProperty" 
   ((browser (:pointer :OpaqueControlRef))
    (property :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserSortProperty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserSortProperty" 
   ((browser (:pointer :OpaqueControlRef))
    (property (:pointer :DATABROWSERPROPERTYID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Modify selection behavior 
; 
;  *  SetDataBrowserSelectionFlags()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserSelectionFlags" 
   ((browser (:pointer :OpaqueControlRef))
    (selectionFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserSelectionFlags()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserSelectionFlags" 
   ((browser (:pointer :OpaqueControlRef))
    (selectionFlags (:pointer :DATABROWSERSELECTIONFLAGS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Dynamically modify property appearance/behavior 
; 
;  *  SetDataBrowserPropertyFlags()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserPropertyFlags" 
   ((browser (:pointer :OpaqueControlRef))
    (property :UInt32)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserPropertyFlags()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserPropertyFlags" 
   ((browser (:pointer :OpaqueControlRef))
    (property :UInt32)
    (flags (:pointer :DATABROWSERPROPERTYFLAGS))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Text of current in-place edit session 
; 
;  *  SetDataBrowserEditText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserEditText" 
   ((browser (:pointer :OpaqueControlRef))
    (text (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CopyDataBrowserEditText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CopyDataBrowserEditText" 
   ((browser (:pointer :OpaqueControlRef))
    (text (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserEditText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserEditText" 
   ((browser (:pointer :OpaqueControlRef))
    (text (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Item/property currently being edited 
; 
;  *  SetDataBrowserEditItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserEditItem" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
    (property :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserEditItem()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserEditItem" 
   ((browser (:pointer :OpaqueControlRef))
    (item (:pointer :DATABROWSERITEMID))
    (property (:pointer :DATABROWSERPROPERTYID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Get the current bounds of a visual part of an item's property 
; 
;  *  GetDataBrowserItemPartBounds()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemPartBounds" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
    (property :UInt32)
    (part :OSType)
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  DataBrowser ItemData Accessors (used within DataBrowserItemData callback) 

(def-mactype :DataBrowserItemDataRef (find-mactype '(:pointer :void)))
; 
;  *  SetDataBrowserItemDataIcon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserItemDataIcon" 
   ((itemData (:pointer :void))
    (theData (:pointer :OpaqueIconRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataIcon()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataIcon" 
   ((itemData (:pointer :void))
    (theData (:pointer :ICONREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserItemDataText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserItemDataText" 
   ((itemData (:pointer :void))
    (theData (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataText" 
   ((itemData (:pointer :void))
    (theData (:pointer :CFStringRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserItemDataValue()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserItemDataValue" 
   ((itemData (:pointer :void))
    (theData :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataValue()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataValue" 
   ((itemData (:pointer :void))
    (theData (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserItemDataMinimum()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserItemDataMinimum" 
   ((itemData (:pointer :void))
    (theData :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataMinimum()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataMinimum" 
   ((itemData (:pointer :void))
    (theData (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserItemDataMaximum()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserItemDataMaximum" 
   ((itemData (:pointer :void))
    (theData :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataMaximum()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataMaximum" 
   ((itemData (:pointer :void))
    (theData (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserItemDataBooleanValue()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserItemDataBooleanValue" 
   ((itemData (:pointer :void))
    (theData :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataBooleanValue()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataBooleanValue" 
   ((itemData (:pointer :void))
    (theData (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserItemDataMenuRef()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserItemDataMenuRef" 
   ((itemData (:pointer :void))
    (theData (:pointer :OpaqueMenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataMenuRef()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataMenuRef" 
   ((itemData (:pointer :void))
    (theData (:pointer :MenuRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserItemDataRGBColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserItemDataRGBColor" 
   ((itemData (:pointer :void))
    (theData (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataRGBColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataRGBColor" 
   ((itemData (:pointer :void))
    (theData (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserItemDataDrawState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserItemDataDrawState" 
   ((itemData (:pointer :void))
    (theData :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataDrawState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataDrawState" 
   ((itemData (:pointer :void))
    (theData (:pointer :THEMEDRAWSTATE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserItemDataButtonValue()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserItemDataButtonValue" 
   ((itemData (:pointer :void))
    (theData :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataButtonValue()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataButtonValue" 
   ((itemData (:pointer :void))
    (theData (:pointer :THEMEBUTTONVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserItemDataIconTransform()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserItemDataIconTransform" 
   ((itemData (:pointer :void))
    (theData :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataIconTransform()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataIconTransform" 
   ((itemData (:pointer :void))
    (theData (:pointer :ICONTRANSFORMTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserItemDataDateTime()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserItemDataDateTime" 
   ((itemData (:pointer :void))
    (theData :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataDateTime()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataDateTime" 
   ((itemData (:pointer :void))
    (theData (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserItemDataLongDateTime()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserItemDataLongDateTime" 
   ((itemData (:pointer :void))
    (theData (:pointer :LONGDATETIME))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataLongDateTime()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataLongDateTime" 
   ((itemData (:pointer :void))
    (theData (:pointer :LONGDATETIME))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserItemDataItemID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserItemDataItemID" 
   ((itemData (:pointer :void))
    (theData :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataItemID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataItemID" 
   ((itemData (:pointer :void))
    (theData (:pointer :DATABROWSERITEMID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserItemDataProperty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserItemDataProperty" 
   ((itemData (:pointer :void))
    (theData (:pointer :DATABROWSERPROPERTYID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Standard DataBrowser Callbacks 
;  Basic Item Management & Manipulation 

(def-mactype :DataBrowserItemDataProcPtr (find-mactype ':pointer)); (ControlRef browser , DataBrowserItemID item , DataBrowserPropertyID property , DataBrowserItemDataRef itemData , Boolean setValue)

(def-mactype :DataBrowserItemDataUPP (find-mactype '(:pointer :OpaqueDataBrowserItemDataProcPtr)))
;  Item Comparison 

(def-mactype :DataBrowserItemCompareProcPtr (find-mactype ':pointer)); (ControlRef browser , DataBrowserItemID itemOne , DataBrowserItemID itemTwo , DataBrowserPropertyID sortProperty)

(def-mactype :DataBrowserItemCompareUPP (find-mactype '(:pointer :OpaqueDataBrowserItemCompareProcPtr)))
;  ItemEvent Notification 
;   A Very Important Note about DataBrowserItemNotificationProcPtr:                                     
;                                                                                                       
;   Under all currently shipping versions of CarbonLib (eg. up through 1.3), your callback is called    
;   just as the prototype appears in this header. It should only be expecting three parameters because  
;   DataBrowser will only pass three parameters.                                                        
;                                                                                                       
;   Under Mac OS X, your callback is called with an additional parameter. If you wish to interpret      
;   the additional parameter, your callback should have the same prototype as the                       
;   DataBrowserItemNotificationWithItemProcPtr (below). You may freely take a callback with this        
;   prototype and pass it to NewDataBrowserItemNotificationUPP in order to generate a                   
;   DataBrowserItemNotificationUPP that you can use just like any other DataBrowserItemNotificationUPP. 
;                                                                                                       
;   If you use this technique under CarbonLib, you will *not* receive valid data in the fourth          
;   parameter, and any attempt to use the invalid data will probably result in a crash.                 

(def-mactype :DataBrowserItemNotificationWithItemProcPtr (find-mactype ':pointer)); (ControlRef browser , DataBrowserItemID item , DataBrowserItemNotification message , DataBrowserItemDataRef itemData)

(def-mactype :DataBrowserItemNotificationProcPtr (find-mactype ':pointer)); (ControlRef browser , DataBrowserItemID item , DataBrowserItemNotification message)

(def-mactype :DataBrowserItemNotificationWithItemUPP (find-mactype '(:pointer :OpaqueDataBrowserItemNotificationWithItemProcPtr)))

(def-mactype :DataBrowserItemNotificationUPP (find-mactype '(:pointer :OpaqueDataBrowserItemNotificationProcPtr)))
;  Drag & Drop Processing 

(def-mactype :DataBrowserAddDragItemProcPtr (find-mactype ':pointer)); (ControlRef browser , DragReference theDrag , DataBrowserItemID item , ItemReference * itemRef)

(def-mactype :DataBrowserAcceptDragProcPtr (find-mactype ':pointer)); (ControlRef browser , DragReference theDrag , DataBrowserItemID item)

(def-mactype :DataBrowserReceiveDragProcPtr (find-mactype ':pointer)); (ControlRef browser , DragReference theDrag , DataBrowserItemID item)

(def-mactype :DataBrowserPostProcessDragProcPtr (find-mactype ':pointer)); (ControlRef browser , DragReference theDrag , OSStatus trackDragResult)

(def-mactype :DataBrowserAddDragItemUPP (find-mactype '(:pointer :OpaqueDataBrowserAddDragItemProcPtr)))

(def-mactype :DataBrowserAcceptDragUPP (find-mactype '(:pointer :OpaqueDataBrowserAcceptDragProcPtr)))

(def-mactype :DataBrowserReceiveDragUPP (find-mactype '(:pointer :OpaqueDataBrowserReceiveDragProcPtr)))

(def-mactype :DataBrowserPostProcessDragUPP (find-mactype '(:pointer :OpaqueDataBrowserPostProcessDragProcPtr)))
;  Contextual Menu Support 

(def-mactype :DataBrowserGetContextualMenuProcPtr (find-mactype ':pointer)); (ControlRef browser , MenuRef * menu , UInt32 * helpType , CFStringRef * helpItemString , AEDesc * selection)

(def-mactype :DataBrowserSelectContextualMenuProcPtr (find-mactype ':pointer)); (ControlRef browser , MenuRef menu , UInt32 selectionType , SInt16 menuID , MenuItemIndex menuItem)

(def-mactype :DataBrowserGetContextualMenuUPP (find-mactype '(:pointer :OpaqueDataBrowserGetContextualMenuProcPtr)))

(def-mactype :DataBrowserSelectContextualMenuUPP (find-mactype '(:pointer :OpaqueDataBrowserSelectContextualMenuProcPtr)))
;  Help Manager Support 

(def-mactype :DataBrowserItemHelpContentProcPtr (find-mactype ':pointer)); (ControlRef browser , DataBrowserItemID item , DataBrowserPropertyID property , HMContentRequest inRequest , HMContentProvidedType * outContentProvided , HMHelpContentPtr ioHelpContent)

(def-mactype :DataBrowserItemHelpContentUPP (find-mactype '(:pointer :OpaqueDataBrowserItemHelpContentProcPtr)))
; 
;  *  NewDataBrowserItemDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserItemDataUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDataBrowserItemDataProcPtr)
() )
; 
;  *  NewDataBrowserItemCompareUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserItemCompareUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDataBrowserItemCompareProcPtr)
() )
; 
;  *  NewDataBrowserItemNotificationWithItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserItemNotificationWithItemUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :OpaqueDataBrowserItemNotificationWithItemProcPtr)
() )
; 
;  *  NewDataBrowserItemNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserItemNotificationUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDataBrowserItemNotificationProcPtr)
() )
; 
;  *  NewDataBrowserAddDragItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserAddDragItemUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDataBrowserAddDragItemProcPtr)
() )
; 
;  *  NewDataBrowserAcceptDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserAcceptDragUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDataBrowserAcceptDragProcPtr)
() )
; 
;  *  NewDataBrowserReceiveDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserReceiveDragUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDataBrowserReceiveDragProcPtr)
() )
; 
;  *  NewDataBrowserPostProcessDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserPostProcessDragUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDataBrowserPostProcessDragProcPtr)
() )
; 
;  *  NewDataBrowserGetContextualMenuUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserGetContextualMenuUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDataBrowserGetContextualMenuProcPtr)
() )
; 
;  *  NewDataBrowserSelectContextualMenuUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserSelectContextualMenuUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDataBrowserSelectContextualMenuProcPtr)
() )
; 
;  *  NewDataBrowserItemHelpContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserItemHelpContentUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDataBrowserItemHelpContentProcPtr)
() )
; 
;  *  DisposeDataBrowserItemDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserItemDataUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserItemDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserItemCompareUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserItemCompareUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserItemCompareProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserItemNotificationWithItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserItemNotificationWithItemUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserItemNotificationWithItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserItemNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserItemNotificationUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserItemNotificationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserAddDragItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserAddDragItemUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserAddDragItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserAcceptDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserAcceptDragUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserAcceptDragProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserReceiveDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserReceiveDragUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserReceiveDragProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserPostProcessDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserPostProcessDragUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserPostProcessDragProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserGetContextualMenuUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserGetContextualMenuUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserGetContextualMenuProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserSelectContextualMenuUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserSelectContextualMenuUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserSelectContextualMenuProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserItemHelpContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserItemHelpContentUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserItemHelpContentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDataBrowserItemDataUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserItemDataUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
    (property :UInt32)
    (itemData (:pointer :void))
    (setValue :Boolean)
    (userUPP (:pointer :OpaqueDataBrowserItemDataProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  InvokeDataBrowserItemCompareUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserItemCompareUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (itemOne :UInt32)
    (itemTwo :UInt32)
    (sortProperty :UInt32)
    (userUPP (:pointer :OpaqueDataBrowserItemCompareProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeDataBrowserItemNotificationWithItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserItemNotificationWithItemUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
    (message :UInt32)
    (itemData (:pointer :void))
    (userUPP (:pointer :OpaqueDataBrowserItemNotificationWithItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  InvokeDataBrowserItemNotificationUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserItemNotificationUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
    (message :UInt32)
    (userUPP (:pointer :OpaqueDataBrowserItemNotificationProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDataBrowserAddDragItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserAddDragItemUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (theDrag (:pointer :OpaqueDragRef))
    (item :UInt32)
    (itemRef (:pointer :ITEMREFERENCE))
    (userUPP (:pointer :OpaqueDataBrowserAddDragItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeDataBrowserAcceptDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserAcceptDragUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (theDrag (:pointer :OpaqueDragRef))
    (item :UInt32)
    (userUPP (:pointer :OpaqueDataBrowserAcceptDragProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeDataBrowserReceiveDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserReceiveDragUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (theDrag (:pointer :OpaqueDragRef))
    (item :UInt32)
    (userUPP (:pointer :OpaqueDataBrowserReceiveDragProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeDataBrowserPostProcessDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserPostProcessDragUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (theDrag (:pointer :OpaqueDragRef))
    (trackDragResult :SInt32)
    (userUPP (:pointer :OpaqueDataBrowserPostProcessDragProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDataBrowserGetContextualMenuUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserGetContextualMenuUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (menu (:pointer :MenuRef))
    (helpType (:pointer :UInt32))
    (helpItemString (:pointer :CFStringRef))
    (selection (:pointer :AEDesc))
    (userUPP (:pointer :OpaqueDataBrowserGetContextualMenuProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDataBrowserSelectContextualMenuUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserSelectContextualMenuUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (menu (:pointer :OpaqueMenuRef))
    (selectionType :UInt32)
    (menuID :SInt16)
    (menuItem :UInt16)
    (userUPP (:pointer :OpaqueDataBrowserSelectContextualMenuProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDataBrowserItemHelpContentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserItemHelpContentUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
    (property :UInt32)
    (inRequest :SInt16)
    (outContentProvided (:pointer :HMCONTENTPROVIDEDTYPE))
    (ioHelpContent (:pointer :HMHelpContentRec))
    (userUPP (:pointer :OpaqueDataBrowserItemHelpContentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  Standard Callback (vtable) Structure 

(defconstant $kDataBrowserLatestCallbacks 0)
(defrecord DataBrowserCallbacks
   (version :UInt32)                            ;  Use kDataBrowserLatestCallbacks 
   (:variant
   (
   (itemDataCallback (:pointer :OpaqueDataBrowserItemDataProcPtr))
   (itemCompareCallback (:pointer :OpaqueDataBrowserItemCompareProcPtr))
   (itemNotificationCallback (:pointer :OpaqueDataBrowserItemNotificationProcPtr))
   (addDragItemCallback (:pointer :OpaqueDataBrowserAddDragItemProcPtr))
   (acceptDragCallback (:pointer :OpaqueDataBrowserAcceptDragProcPtr))
   (receiveDragCallback (:pointer :OpaqueDataBrowserReceiveDragProcPtr))
   (postProcessDragCallback (:pointer :OpaqueDataBrowserPostProcessDragProcPtr))
   (itemHelpContentCallback (:pointer :OpaqueDataBrowserItemHelpContentProcPtr))
   (getContextualMenuCallback (:pointer :OpaqueDataBrowserGetContextualMenuProcPtr))
   (selectContextualMenuCallback (:pointer :OpaqueDataBrowserSelectContextualMenuProcPtr))
   )
   )
)

;type name? (%define-record :DataBrowserCallbacks (find-record-descriptor ':DataBrowserCallbacks))
; 
;  *  InitDataBrowserCallbacks()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InitDataBrowserCallbacks" 
   ((callbacks (:pointer :DataBrowserCallbacks))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Macro for initializing callback structure 
; #define InitializeDataBrowserCallbacks(callbacks, vers) { (callbacks)->version = (vers); InitDataBrowserCallbacks(callbacks); }
; 
;  *  GetDataBrowserCallbacks()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserCallbacks" 
   ((browser (:pointer :OpaqueControlRef))
    (callbacks (:pointer :DataBrowserCallbacks))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserCallbacks()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserCallbacks" 
   ((browser (:pointer :OpaqueControlRef))
    (callbacks (:pointer :DataBrowserCallbacks))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Custom Format Callbacks (kDataBrowserCustomType display properties) 

(def-mactype :DataBrowserDragFlags (find-mactype ':UInt32))

(def-mactype :DataBrowserTrackingResult (find-mactype ':SInt16))

(defconstant $kDataBrowserContentHit 1)
(defconstant $kDataBrowserNothingHit 0)
(defconstant $kDataBrowserStopTracking -1)

(def-mactype :DataBrowserDrawItemProcPtr (find-mactype ':pointer)); (ControlRef browser , DataBrowserItemID item , DataBrowserPropertyID property , DataBrowserItemState itemState , const Rect * theRect , SInt16 gdDepth , Boolean colorDevice)

(def-mactype :DataBrowserEditItemProcPtr (find-mactype ':pointer)); (ControlRef browser , DataBrowserItemID item , DataBrowserPropertyID property , CFStringRef theString , Rect * maxEditTextRect , Boolean * shrinkToFit)

(def-mactype :DataBrowserHitTestProcPtr (find-mactype ':pointer)); (ControlRef browser , DataBrowserItemID itemID , DataBrowserPropertyID property , const Rect * theRect , const Rect * mouseRect)

(def-mactype :DataBrowserTrackingProcPtr (find-mactype ':pointer)); (ControlRef browser , DataBrowserItemID itemID , DataBrowserPropertyID property , const Rect * theRect , Point startPt , EventModifiers modifiers)

(def-mactype :DataBrowserItemDragRgnProcPtr (find-mactype ':pointer)); (ControlRef browser , DataBrowserItemID itemID , DataBrowserPropertyID property , const Rect * theRect , RgnHandle dragRgn)

(def-mactype :DataBrowserItemAcceptDragProcPtr (find-mactype ':pointer)); (ControlRef browser , DataBrowserItemID itemID , DataBrowserPropertyID property , const Rect * theRect , DragReference theDrag)

(def-mactype :DataBrowserItemReceiveDragProcPtr (find-mactype ':pointer)); (ControlRef browser , DataBrowserItemID itemID , DataBrowserPropertyID property , DataBrowserDragFlags dragFlags , DragReference theDrag)

(def-mactype :DataBrowserDrawItemUPP (find-mactype '(:pointer :OpaqueDataBrowserDrawItemProcPtr)))

(def-mactype :DataBrowserEditItemUPP (find-mactype '(:pointer :OpaqueDataBrowserEditItemProcPtr)))

(def-mactype :DataBrowserHitTestUPP (find-mactype '(:pointer :OpaqueDataBrowserHitTestProcPtr)))

(def-mactype :DataBrowserTrackingUPP (find-mactype '(:pointer :OpaqueDataBrowserTrackingProcPtr)))

(def-mactype :DataBrowserItemDragRgnUPP (find-mactype '(:pointer :OpaqueDataBrowserItemDragRgnProcPtr)))

(def-mactype :DataBrowserItemAcceptDragUPP (find-mactype '(:pointer :OpaqueDataBrowserItemAcceptDragProcPtr)))

(def-mactype :DataBrowserItemReceiveDragUPP (find-mactype '(:pointer :OpaqueDataBrowserItemReceiveDragProcPtr)))
; 
;  *  NewDataBrowserDrawItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserDrawItemUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :OpaqueDataBrowserDrawItemProcPtr)
() )
; 
;  *  NewDataBrowserEditItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserEditItemUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :OpaqueDataBrowserEditItemProcPtr)
() )
; 
;  *  NewDataBrowserHitTestUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserHitTestUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :OpaqueDataBrowserHitTestProcPtr)
() )
; 
;  *  NewDataBrowserTrackingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserTrackingUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :OpaqueDataBrowserTrackingProcPtr)
() )
; 
;  *  NewDataBrowserItemDragRgnUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserItemDragRgnUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :OpaqueDataBrowserItemDragRgnProcPtr)
() )
; 
;  *  NewDataBrowserItemAcceptDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserItemAcceptDragUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :OpaqueDataBrowserItemAcceptDragProcPtr)
() )
; 
;  *  NewDataBrowserItemReceiveDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewDataBrowserItemReceiveDragUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :OpaqueDataBrowserItemReceiveDragProcPtr)
() )
; 
;  *  DisposeDataBrowserDrawItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserDrawItemUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserDrawItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserEditItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserEditItemUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserEditItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserHitTestUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserHitTestUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserHitTestProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserTrackingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserTrackingUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserTrackingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserItemDragRgnUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserItemDragRgnUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserItemDragRgnProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserItemAcceptDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserItemAcceptDragUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserItemAcceptDragProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  DisposeDataBrowserItemReceiveDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeDataBrowserItemReceiveDragUPP" 
   ((userUPP (:pointer :OpaqueDataBrowserItemReceiveDragProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  InvokeDataBrowserDrawItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserDrawItemUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
    (property :UInt32)
    (itemState :UInt32)
    (theRect (:pointer :Rect))
    (gdDepth :SInt16)
    (colorDevice :Boolean)
    (userUPP (:pointer :OpaqueDataBrowserDrawItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  InvokeDataBrowserEditItemUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserEditItemUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
    (property :UInt32)
    (theString (:pointer :__CFString))
    (maxEditTextRect (:pointer :Rect))
    (shrinkToFit (:pointer :Boolean))
    (userUPP (:pointer :OpaqueDataBrowserEditItemProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Boolean
() )
; 
;  *  InvokeDataBrowserHitTestUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserHitTestUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (itemID :UInt32)
    (property :UInt32)
    (theRect (:pointer :Rect))
    (mouseRect (:pointer :Rect))
    (userUPP (:pointer :OpaqueDataBrowserHitTestProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Boolean
() )
; 
;  *  InvokeDataBrowserTrackingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserTrackingUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (itemID :UInt32)
    (property :UInt32)
    (theRect (:pointer :Rect))
    (startPt :Point)
    (modifiers :UInt16)
    (userUPP (:pointer :OpaqueDataBrowserTrackingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :SInt16
() )
; 
;  *  InvokeDataBrowserItemDragRgnUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserItemDragRgnUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (itemID :UInt32)
    (property :UInt32)
    (theRect (:pointer :Rect))
    (dragRgn (:pointer :OpaqueRgnHandle))
    (userUPP (:pointer :OpaqueDataBrowserItemDragRgnProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  InvokeDataBrowserItemAcceptDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserItemAcceptDragUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (itemID :UInt32)
    (property :UInt32)
    (theRect (:pointer :Rect))
    (theDrag (:pointer :OpaqueDragRef))
    (userUPP (:pointer :OpaqueDataBrowserItemAcceptDragProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :UInt32
() )
; 
;  *  InvokeDataBrowserItemReceiveDragUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeDataBrowserItemReceiveDragUPP" 
   ((browser (:pointer :OpaqueControlRef))
    (itemID :UInt32)
    (property :UInt32)
    (dragFlags :UInt32)
    (theDrag (:pointer :OpaqueDragRef))
    (userUPP (:pointer :OpaqueDataBrowserItemReceiveDragProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Boolean
() )
;  Custom Callback (vtable) Structure 

(defconstant $kDataBrowserLatestCustomCallbacks 0)
(defrecord DataBrowserCustomCallbacks
   (version :UInt32)                            ;  Use kDataBrowserLatestCustomCallbacks 
   (:variant
   (
   (drawItemCallback (:pointer :OpaqueDataBrowserDrawItemProcPtr))
   (editTextCallback (:pointer :OpaqueDataBrowserEditItemProcPtr))
   (hitTestCallback (:pointer :OpaqueDataBrowserHitTestProcPtr))
   (trackingCallback (:pointer :OpaqueDataBrowserTrackingProcPtr))
   (dragRegionCallback (:pointer :OpaqueDataBrowserItemDragRgnProcPtr))
   (acceptDragCallback (:pointer :OpaqueDataBrowserItemAcceptDragProcPtr))
   (receiveDragCallback (:pointer :OpaqueDataBrowserItemReceiveDragProcPtr))
   )
   )
)

;type name? (%define-record :DataBrowserCustomCallbacks (find-record-descriptor ':DataBrowserCustomCallbacks))
; 
;  *  InitDataBrowserCustomCallbacks()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InitDataBrowserCustomCallbacks" 
   ((callbacks (:pointer :DataBrowserCustomCallbacks))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Macro for initializing custom callback structure 
; #define InitializeDataBrowserCustomCallbacks(callbacks, vers) { (callbacks)->version = (vers); InitDataBrowserCustomCallbacks(callbacks); }
; 
;  *  GetDataBrowserCustomCallbacks()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserCustomCallbacks" 
   ((browser (:pointer :OpaqueControlRef))
    (callbacks (:pointer :DataBrowserCustomCallbacks))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserCustomCallbacks()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserCustomCallbacks" 
   ((browser (:pointer :OpaqueControlRef))
    (callbacks (:pointer :DataBrowserCustomCallbacks))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  TableView Formatting 

(def-mactype :DataBrowserTableViewHiliteStyle (find-mactype ':UInt32))

(defconstant $kDataBrowserTableViewMinimalHilite 0)
(defconstant $kDataBrowserTableViewFillHilite 1)

(def-mactype :DataBrowserTableViewPropertyFlags (find-mactype ':UInt32))
;  kDataBrowserTableView DataBrowserPropertyFlags 

(defconstant $kDataBrowserTableViewSelectionColumn #x10000)
;  The row and column indicies are zero-based 

(def-mactype :DataBrowserTableViewRowIndex (find-mactype ':UInt32))

(def-mactype :DataBrowserTableViewColumnIndex (find-mactype ':UInt32))

(def-mactype :DataBrowserTableViewColumnID (find-mactype ':UInt32))

(%define-record :DataBrowserTableViewColumnDesc (find-record-descriptor ':DataBrowserPropertyDesc))
;  TableView API 
;  Use when setting column position 

(defconstant $kDataBrowserTableViewLastColumn -1)
; 
;  *  RemoveDataBrowserTableViewColumn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RemoveDataBrowserTableViewColumn" 
   ((browser (:pointer :OpaqueControlRef))
    (column :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserTableViewColumnCount()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserTableViewColumnCount" 
   ((browser (:pointer :OpaqueControlRef))
    (numColumns (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserTableViewHiliteStyle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserTableViewHiliteStyle" 
   ((browser (:pointer :OpaqueControlRef))
    (hiliteStyle :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserTableViewHiliteStyle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserTableViewHiliteStyle" 
   ((browser (:pointer :OpaqueControlRef))
    (hiliteStyle (:pointer :DATABROWSERTABLEVIEWHILITESTYLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserTableViewRowHeight()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserTableViewRowHeight" 
   ((browser (:pointer :OpaqueControlRef))
    (height :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserTableViewRowHeight()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserTableViewRowHeight" 
   ((browser (:pointer :OpaqueControlRef))
    (height (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserTableViewColumnWidth()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserTableViewColumnWidth" 
   ((browser (:pointer :OpaqueControlRef))
    (width :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserTableViewColumnWidth()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserTableViewColumnWidth" 
   ((browser (:pointer :OpaqueControlRef))
    (width (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserTableViewItemRowHeight()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserTableViewItemRowHeight" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
    (height :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserTableViewItemRowHeight()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserTableViewItemRowHeight" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
    (height (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserTableViewNamedColumnWidth()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserTableViewNamedColumnWidth" 
   ((browser (:pointer :OpaqueControlRef))
    (column :UInt32)
    (width :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserTableViewNamedColumnWidth()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserTableViewNamedColumnWidth" 
   ((browser (:pointer :OpaqueControlRef))
    (column :UInt32)
    (width (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserTableViewGeometry()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserTableViewGeometry" 
   ((browser (:pointer :OpaqueControlRef))
    (variableWidthColumns :Boolean)
    (variableHeightRows :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserTableViewGeometry()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserTableViewGeometry" 
   ((browser (:pointer :OpaqueControlRef))
    (variableWidthColumns (:pointer :Boolean))
    (variableHeightRows (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserTableViewItemID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserTableViewItemID" 
   ((browser (:pointer :OpaqueControlRef))
    (row :UInt32)
    (item (:pointer :DATABROWSERITEMID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserTableViewItemRow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserTableViewItemRow" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
    (row :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserTableViewItemRow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserTableViewItemRow" 
   ((browser (:pointer :OpaqueControlRef))
    (item :UInt32)
    (row (:pointer :DATABROWSERTABLEVIEWROWINDEX))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserTableViewColumnPosition()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserTableViewColumnPosition" 
   ((browser (:pointer :OpaqueControlRef))
    (column :UInt32)
    (position :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserTableViewColumnPosition()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserTableViewColumnPosition" 
   ((browser (:pointer :OpaqueControlRef))
    (column :UInt32)
    (position (:pointer :DATABROWSERTABLEVIEWCOLUMNINDEX))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserTableViewColumnProperty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserTableViewColumnProperty" 
   ((browser (:pointer :OpaqueControlRef))
    (column :UInt32)
    (property (:pointer :DATABROWSERTABLEVIEWCOLUMNID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  kDataBrowserListView Formatting 
; 
;  *  Discussion:
;  *    DataBrowserPropertyFlags that are specific to kDataBrowserListView
;  

(defconstant $kDataBrowserListViewSelectionColumn #x10000)
(defconstant $kDataBrowserListViewMovableColumn #x20000)
(defconstant $kDataBrowserListViewSortableColumn #x40000)
; 
;    * kDataBrowserListViewTypeSelectColumn marks a column as
;    * type-selectable. If one or more of your list view columns are
;    * marked as type-selectable, Data Browser will do type-selection for
;    * you automatically. Data Browser applies the typing to the first
;    * column (in the system direction) with this property flag. This
;    * flag only intended for use with columns of type
;    * kDataBrowserTextType, kDataBrowserIconAndTextType, and
;    * kDataBrowserDateTimeType; if you set it for a column of another
;    * type, the type-selection behavior is undefined. Turning on this
;    * flag also causes Data Browser to gather all keyboard input via a
;    * carbon event handler instead of relying on calls to
;    * HandleControlKey; therefore, you will never see these keyboard
;    * events come out of WaitNextEvent. Only available on Mac OS X 10.3
;    * and later.
;    

(defconstant $kDataBrowserListViewTypeSelectColumn #x80000)
(defconstant $kDataBrowserListViewDefaultColumnFlags #x60000)

(def-mactype :DataBrowserListViewPropertyFlags (find-mactype ':UInt32))

(defconstant $kDataBrowserListViewLatestHeaderDesc 0)
(defrecord DataBrowserListViewHeaderDesc
   (version :UInt32)                            ;  Use kDataBrowserListViewLatestHeaderDesc 
   (minimumWidth :UInt16)
   (maximumWidth :UInt16)
   (titleOffset :SInt16)
   (titleString (:pointer :__CFString))
   (initialOrder :UInt16)
   (btnFontStyle :ControlFontStyleRec)
   (btnContentInfo :ControlButtonContentInfo)
)

;type name? (%define-record :DataBrowserListViewHeaderDesc (find-record-descriptor ':DataBrowserListViewHeaderDesc))
(defrecord DataBrowserListViewColumnDesc
   (propertyDesc :DataBrowserPropertyDesc)
   (headerBtnDesc :DataBrowserListViewHeaderDesc)
)

;type name? (%define-record :DataBrowserListViewColumnDesc (find-record-descriptor ':DataBrowserListViewColumnDesc))
;  kDataBrowserListView API 

(defconstant $kDataBrowserListViewAppendColumn -1)
; 
;  *  AutoSizeDataBrowserListViewColumns()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AutoSizeDataBrowserListViewColumns" 
   ((browser (:pointer :OpaqueControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  AddDataBrowserListViewColumn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_AddDataBrowserListViewColumn" 
   ((browser (:pointer :OpaqueControlRef))
    (columnDesc (:pointer :DataBrowserListViewColumnDesc))
    (position :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserListViewHeaderDesc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserListViewHeaderDesc" 
   ((browser (:pointer :OpaqueControlRef))
    (column :UInt32)
    (desc (:pointer :DataBrowserListViewHeaderDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserListViewHeaderDesc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserListViewHeaderDesc" 
   ((browser (:pointer :OpaqueControlRef))
    (column :UInt32)
    (desc (:pointer :DataBrowserListViewHeaderDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserListViewHeaderBtnHeight()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserListViewHeaderBtnHeight" 
   ((browser (:pointer :OpaqueControlRef))
    (height :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserListViewHeaderBtnHeight()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserListViewHeaderBtnHeight" 
   ((browser (:pointer :OpaqueControlRef))
    (height (:pointer :UInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserListViewUsePlainBackground()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserListViewUsePlainBackground" 
   ((browser (:pointer :OpaqueControlRef))
    (usePlainBackground :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserListViewUsePlainBackground()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserListViewUsePlainBackground" 
   ((browser (:pointer :OpaqueControlRef))
    (usePlainBackground (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserListViewDisclosureColumn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserListViewDisclosureColumn" 
   ((browser (:pointer :OpaqueControlRef))
    (column :UInt32)
    (expandableRows :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserListViewDisclosureColumn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserListViewDisclosureColumn" 
   ((browser (:pointer :OpaqueControlRef))
    (column (:pointer :DATABROWSERTABLEVIEWCOLUMNID))
    (expandableRows (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  kDataBrowserColumnView API 
; 
;  *  GetDataBrowserColumnViewPath()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserColumnViewPath" 
   ((browser (:pointer :OpaqueControlRef))
    (path :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserColumnViewPathLength()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserColumnViewPathLength" 
   ((browser (:pointer :OpaqueControlRef))
    (pathLength (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserColumnViewPath()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserColumnViewPath" 
   ((browser (:pointer :OpaqueControlRef))
    (length :UInt32)
    (path (:pointer :DATABROWSERITEMID))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SetDataBrowserColumnViewDisplayType()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetDataBrowserColumnViewDisplayType" 
   ((browser (:pointer :OpaqueControlRef))
    (propertyType :OSType)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetDataBrowserColumnViewDisplayType()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetDataBrowserColumnViewDisplayType" 
   ((browser (:pointer :OpaqueControlRef))
    (propertyType (:pointer :DATABROWSERPROPERTYTYPE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  DataBrowser UPP macros 
; ---------------------------------------------------------------------------------------
;  EditUnicodeText Control                                                               
; ---------------------------------------------------------------------------------------
;  This control is only available in Mac OS X.  It is super similar to Edit Text control 
;  Use all the same Get/Set tags.  But don't ask for the TEHandle.                       
; ---------------------------------------------------------------------------------------
;  This callback supplies the functionality of the TSMTEPostUpdateProcPtr that is used 
;  in the EditText control.  A client should supply this call if they want to look at  
;  inline text that has been fixed before it is included in the actual body text       
;  if the new text (i.e. the text in the handle) should be included in the body text    
;  the client should return true.  If the client wants to block the inclusion of the    
;  text they should return false.                                                       

(def-mactype :EditUnicodePostUpdateProcPtr (find-mactype ':pointer)); (UniCharArrayHandle uniText , UniCharCount uniTextLength , UniCharArrayOffset iStartOffset , UniCharArrayOffset iEndOffset , void * refcon)

(def-mactype :EditUnicodePostUpdateUPP (find-mactype '(:pointer :OpaqueEditUnicodePostUpdateProcPtr)))
; 
;  *  NewEditUnicodePostUpdateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NewEditUnicodePostUpdateUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueEditUnicodePostUpdateProcPtr)
() )
; 
;  *  DisposeEditUnicodePostUpdateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_DisposeEditUnicodePostUpdateUPP" 
   ((userUPP (:pointer :OpaqueEditUnicodePostUpdateProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeEditUnicodePostUpdateUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_InvokeEditUnicodePostUpdateUPP" 
   ((uniText (:Handle :UInt16))
    (uniTextLength :UInt32)
    (iStartOffset :UInt32)
    (iEndOffset :UInt32)
    (refcon :pointer)
    (userUPP (:pointer :OpaqueEditUnicodePostUpdateProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )

(defconstant $kControlEditUnicodeTextProc #x390)
(defconstant $kControlEditUnicodeTextPasswordProc #x392)
;  Control Kind Tag 

(defconstant $kControlKindEditUnicodeText :|eutx|)
;  The HIObject class ID for the HITextField class. 
; #define kHITextFieldClassID             CFSTR("com.apple.HITextField")
; 
;  *  CreateEditUnicodeTextControl()
;  *  
;  *  Summary:
;  *    Creates a new edit text control.
;  *  
;  *  Discussion:
;  *    This is the preferred edit text control. Use it instead of the
;  *    EditText control. This control handles Unicode and draws its text
;  *    using antialiasing, which the other control does not.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    window:
;  *      The window in which the control should be placed. May be NULL
;  *      in Mac OS X 10.3 and later.
;  *    
;  *    boundsRect:
;  *      The bounds of the control, in local coordinates of the window.
;  *    
;  *    text:
;  *      The text of the control. May be NULL.
;  *    
;  *    isPassword:
;  *      A Boolean indicating whether the field is to be used as a
;  *      password field. Passing false indicates that the field is to
;  *      display entered text normally. True means that the field will
;  *      be used as a password field and any text typed into the field
;  *      will be displayed only as bullets.
;  *    
;  *    style:
;  *      The control's font style, size, color, and so on. May be NULL.
;  *    
;  *    outControl:
;  *      On exit, contains the new control (if noErr is returned as the
;  *      result code).
;  *  
;  *  Result:
;  *    An operating system result code.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateEditUnicodeTextControl" 
   ((window (:pointer :OpaqueWindowPtr))
    (boundsRect (:pointer :Rect))
    (text (:pointer :__CFString))               ;  can be NULL 
    (isPassword :Boolean)
    (style (:pointer :ControlFontStyleRec))     ;  can be NULL 
    (outControl (:pointer :ControlRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     The EditUnicodeText control supports these tags previously defined for the EditText control:
;     
;         kControlEditTextLockedTag
;         kControlFontStyleTag
;         kControlEditTextFixedTextTag
;         kControlEditTextTextTag
;         kControlEditTextKeyFilterTag
;         kControlEditTextValidationProcTag
;         kControlEditTextSelectionTag
;         kControlEditTextKeyScriptBehaviorTag
;         kControlEditTextCFStringTag
;         kControlEditTextPasswordTag
;         kControlEditTextPasswordCFStringTag
; 
;  Tagged data supported by EditUnicodeText control only 

(defconstant $kControlEditTextSingleLineTag :|sglc|);  data is a Boolean; indicates whether the control should always be single-line

(defconstant $kControlEditTextInsertTextBufferTag :|intx|);  data is an array of char; get or set the control's text as WorldScript-encoded text

(defconstant $kControlEditTextInsertCFStringRefTag :|incf|);  data is a CFStringRef; get or set the control's text as a CFStringRef. Caller should release CFString if getting.

(defconstant $kControlEditUnicodeTextPostUpdateProcTag :|upup|);  data is a UnicodePostUpdateUPP; get or set the post-update proc


; #if OLDROUTINENAMES
#|                                              ; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ
;   ¥ OLDROUTINENAMES                                                                   
; ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ

(defconstant $kControlCheckboxUncheckedValue 0)
(defconstant $kControlCheckboxCheckedValue 1)
(defconstant $kControlCheckboxMixedValue 2)

(defconstant $inLabel 1)
(defconstant $inMenu 2)
(defconstant $inTriangle 4)
(defconstant $inButton 10)
(defconstant $inCheckBox 11)
(defconstant $inUpButton 20)
(defconstant $inDownButton 21)
(defconstant $inPageUp 22)
(defconstant $inPageDown 23)

(defconstant $kInLabelControlPart 1)
(defconstant $kInMenuControlPart 2)
(defconstant $kInTriangleControlPart 4)
(defconstant $kInButtonControlPart 10)
(defconstant $kInCheckBoxControlPart 11)
(defconstant $kInUpButtonControlPart 20)
(defconstant $kInDownButtonControlPart 21)
(defconstant $kInPageUpControlPart 22)
(defconstant $kInPageDownControlPart 23)
 |#

; #endif  /* OLDROUTINENAMES */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __CONTROLDEFINITIONS__ */


(provide-interface "ControlDefinitions")