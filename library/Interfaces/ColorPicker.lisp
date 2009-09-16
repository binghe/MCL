(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ColorPicker.h"
; at Sunday July 2,2006 7:25:13 pm.
; 
;      File:       CommonPanels/ColorPicker.h
;  
;      Contains:   Color Picker package Interfaces.
;  
;      Version:    CommonPanels-70~11
;  
;      Copyright:  © 1987-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __COLORPICKER__
; #define __COLORPICKER__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#
; #ifndef __EVENTS__
#| #|
#include <HIToolboxEvents.h>
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
; Maximum small fract value, as long

(defconstant $kMaximumSmallFract #xFFFF)

(defconstant $kDefaultColorPickerWidth #x17F)
(defconstant $kDefaultColorPickerHeight #xEE)

(def-mactype :DialogPlacementSpec (find-mactype ':SInt16))

(defconstant $kAtSpecifiedOrigin 0)
(defconstant $kDeepestColorScreen 1)
(defconstant $kCenterOnMainScreen 2)
;  These are for the flags field in the structs below (for example ColorPickerInfo). 

(defconstant $kColorPickerDialogIsMoveable 1)
(defconstant $kColorPickerDialogIsModal 2)
(defconstant $kColorPickerCanModifyPalette 4)
(defconstant $kColorPickerCanAnimatePalette 8)
(defconstant $kColorPickerAppIsColorSyncAware 16)
(defconstant $kColorPickerInSystemDialog 32)
(defconstant $kColorPickerInApplicationDialog 64)
(defconstant $kColorPickerInPickerDialog #x80)
(defconstant $kColorPickerDetachedFromChoices #x100)
(defconstant $kColorPickerCallColorProcLive #x200)

; #if OLDROUTINENAMES
#|                                              ; Maximum small fract value, as long

(defconstant $MaxSmallFract #xFFFF)

(defconstant $kDefaultWidth #x17F)
(defconstant $kDefaultHeight #xEE)
;  These are for the flags field in the structs below (for example ColorPickerInfo). 

(defconstant $DialogIsMoveable 1)
(defconstant $DialogIsModal 2)
(defconstant $CanModifyPalette 4)
(defconstant $CanAnimatePalette 8)
(defconstant $AppIsColorSyncAware 16)
(defconstant $InSystemDialog 32)
(defconstant $InApplicationDialog 64)
(defconstant $InPickerDialog #x80)
(defconstant $DetachedFromChoices #x100)
(defconstant $CallColorProcLive #x200)
 |#

; #endif  /* OLDROUTINENAMES */

;  A SmallFract value is just the fractional part of a Fixed number,
; which is the low order word.  SmallFracts are used to save room,
; and to be compatible with Quickdraw's RGBColor.  They can be
; assigned directly to and from INTEGERs. 
;  Unsigned fraction between 0 and 1 

(def-mactype :SmallFract (find-mactype ':UInt16))
;  For developmental simplicity in switching between the HLS and HSV
; models, HLS is reordered into HSL. Thus both models start with
; hue and saturation values; value/lightness/brightness is last. 
(defrecord HSVColor
   (hue :UInt16)                                ; Fraction of circle, red at 0
   (saturation :UInt16)                         ; 0-1, 0 for gray, 1 for pure color
   (value :UInt16)                              ; 0-1, 0 for black, 1 for max intensity
)

;type name? (%define-record :HSVColor (find-record-descriptor ':HSVColor))
(defrecord HSLColor
   (hue :UInt16)                                ; Fraction of circle, red at 0
   (saturation :UInt16)                         ; 0-1, 0 for gray, 1 for pure color
   (lightness :UInt16)                          ; 0-1, 0 for black, 1 for white
)

;type name? (%define-record :HSLColor (find-record-descriptor ':HSLColor))
(defrecord CMYColor
   (cyan :UInt16)
   (magenta :UInt16)
   (yellow :UInt16)
)

;type name? (%define-record :CMYColor (find-record-descriptor ':CMYColor))
(defrecord PMColor
   (profile (:Handle :CMProfile))
   (color :CMColor)
)

;type name? (%define-record :PMColor (find-record-descriptor ':PMColor))

(def-mactype :PMColorPtr (find-mactype '(:pointer :PMColor)))
(defrecord NPMColor
   (profile (:pointer :OpaqueCMProfileRef))
   (color :CMColor)
)

;type name? (%define-record :NPMColor (find-record-descriptor ':NPMColor))

(def-mactype :NPMColorPtr (find-mactype '(:pointer :NPMColor)))

(def-mactype :Picker (find-mactype '(:pointer :OpaquePicker)))

(def-mactype :picker (find-mactype ':Picker))
(defrecord PickerMenuItemInfo
   (editMenuID :SInt16)
   (cutItem :SInt16)
   (copyItem :SInt16)
   (pasteItem :SInt16)
   (clearItem :SInt16)
   (undoItem :SInt16)
)

;type name? (%define-record :PickerMenuItemInfo (find-record-descriptor ':PickerMenuItemInfo))
;  Structs related to deprecated API's have been pulled from this file. 
;  Those structs necessary for developers writing their own color pickers... 
;  have been moved to ColorPickerComponents.h. 

(def-mactype :ColorChangedProcPtr (find-mactype ':pointer)); (long userData , PMColor * newColor)

(def-mactype :NColorChangedProcPtr (find-mactype ':pointer)); (long userData , NPMColor * newColor)

(def-mactype :UserEventProcPtr (find-mactype ':pointer)); (EventRecord * event)

(def-mactype :ColorChangedUPP (find-mactype '(:pointer :OpaqueColorChangedProcPtr)))

(def-mactype :NColorChangedUPP (find-mactype '(:pointer :OpaqueNColorChangedProcPtr)))

(def-mactype :UserEventUPP (find-mactype '(:pointer :OpaqueUserEventProcPtr)))
(defrecord ColorPickerInfo
   (theColor :PMColor)
   (dstProfile (:Handle :CMProfile))
   (flags :UInt32)
   (placeWhere :SInt16)
   (dialogOrigin :Point)
   (pickerType :OSType)
   (eventProc (:pointer :OpaqueUserEventProcPtr))
   (colorProc (:pointer :OpaqueColorChangedProcPtr))
   (colorProcData :UInt32)
   (prompt (:string 255))
   (mInfo :PickerMenuItemInfo)
   (newColorChosen :Boolean)
   (filler :SInt8)
)

;type name? (%define-record :ColorPickerInfo (find-record-descriptor ':ColorPickerInfo))
(defrecord NColorPickerInfo
   (theColor :NPMColor)
   (dstProfile (:pointer :OpaqueCMProfileRef))
   (flags :UInt32)
   (placeWhere :SInt16)
   (dialogOrigin :Point)
   (pickerType :OSType)
   (eventProc (:pointer :OpaqueUserEventProcPtr))
   (colorProc (:pointer :OpaqueNColorChangedProcPtr))
   (colorProcData :UInt32)
   (prompt (:string 255))
   (mInfo :PickerMenuItemInfo)
   (newColorChosen :Boolean)
   (reserved :UInt8)                            ; Must be 0
)

;type name? (%define-record :NColorPickerInfo (find-record-descriptor ':NColorPickerInfo))
;   Below are the color conversion routines.
; 
;  *  Fix2SmallFract()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Fix2SmallFract" 
   ((f :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt16
() )
; 
;  *  SmallFract2Fix()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SmallFract2Fix" 
   ((s :UInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMY2RGB()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CMY2RGB" 
   ((cColor (:pointer :CMYColor))
    (rColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RGB2CMY()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RGB2CMY" 
   ((rColor (:pointer :RGBColor))
    (cColor (:pointer :CMYColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HSL2RGB()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HSL2RGB" 
   ((hColor (:pointer :HSLColor))
    (rColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RGB2HSL()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RGB2HSL" 
   ((rColor (:pointer :RGBColor))
    (hColor (:pointer :HSLColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HSV2RGB()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HSV2RGB" 
   ((hColor (:pointer :HSVColor))
    (rColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RGB2HSV()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RGB2HSV" 
   ((rColor (:pointer :RGBColor))
    (hColor (:pointer :HSVColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;   GetColor() works with or without the Color Picker extension.
; 
;  *  GetColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetColor" 
   ((where :Point)
    (prompt (:pointer :STR255))
    (inColor (:pointer :RGBColor))
    (outColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;   PickColor() requires the Color Picker extension (version 2.0 or greater).
; 
;  *  PickColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorPickerLib 2.0 and later
;  

(deftrap-inline "_PickColor" 
   ((theColorInfo (:pointer :ColorPickerInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;   NPickColor() requires the Color Picker extension (version 2.1 or greater).
; 
;  *  NPickColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in ColorPickerLib 2.1 and later
;  

(deftrap-inline "_NPickColor" 
   ((theColorInfo (:pointer :NColorPickerInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  A suite of mid-level API calls have been deprecated.  Likely you never...  
;  used them anyway.  They were removed from this file and should not be... 
;  used in the future as they are not gauranteed to be supported. 
; 
;  *  NewColorChangedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewColorChangedUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueColorChangedProcPtr)
() )
; 
;  *  NewNColorChangedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewNColorChangedUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueNColorChangedProcPtr)
() )
; 
;  *  NewUserEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewUserEventUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueUserEventProcPtr)
() )
; 
;  *  DisposeColorChangedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeColorChangedUPP" 
   ((userUPP (:pointer :OpaqueColorChangedProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeNColorChangedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeNColorChangedUPP" 
   ((userUPP (:pointer :OpaqueNColorChangedProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeUserEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeUserEventUPP" 
   ((userUPP (:pointer :OpaqueUserEventProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeColorChangedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeColorChangedUPP" 
   ((userData :signed-long)
    (newColor (:pointer :PMColor))
    (userUPP (:pointer :OpaqueColorChangedProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeNColorChangedUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeNColorChangedUPP" 
   ((userData :signed-long)
    (newColor (:pointer :NPMColor))
    (userUPP (:pointer :OpaqueNColorChangedProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeUserEventUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeUserEventUPP" 
   ((event (:pointer :EventRecord))
    (userUPP (:pointer :OpaqueUserEventProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __COLORPICKER__ */


(provide-interface "ColorPicker")