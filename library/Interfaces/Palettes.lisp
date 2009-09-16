(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Palettes.h"
; at Sunday July 2,2006 7:24:31 pm.
; 
;      File:       QD/Palettes.h
;  
;      Contains:   Palette Manager Interfaces.
;  
;      Version:    Quickdraw-150~1
;  
;      Copyright:  © 1987-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __PALETTES__
; #define __PALETTES__
; #ifndef __QUICKDRAW__
#| #|
#include <QDQuickdraw.h>
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

(defconstant $pmCourteous 0)                    ; Record use of color on each device touched.

(defconstant $pmDithered 1)
(defconstant $pmTolerant 2)                     ; render ciRGB if ciTolerance is exceeded by best match.

(defconstant $pmAnimated 4)                     ; reserve an index on each device touched and render ciRGB.

(defconstant $pmExplicit 8)                     ; no reserve, no render, no record; stuff index into port.

(defconstant $pmWhite 16)
(defconstant $pmBlack 32)
(defconstant $pmInhibitG2 #x100)
(defconstant $pmInhibitC2 #x200)
(defconstant $pmInhibitG4 #x400)
(defconstant $pmInhibitC4 #x800)
(defconstant $pmInhibitG8 #x1000)
(defconstant $pmInhibitC8 #x2000)               ;  NSetPalette Update Constants 

(defconstant $pmNoUpdates #x8000)               ; no updates

(defconstant $pmBkUpdates #xA000)               ; background updates only

(defconstant $pmFgUpdates #xC000)               ; foreground updates only

(defconstant $pmAllUpdates #xE000)              ; all updates

(defrecord ColorInfo
   (ciRGB :RGBColor)                            ; true RGB values
   (ciUsage :SInt16)                            ; color usage
   (ciTolerance :SInt16)                        ; tolerance value
   (ciDataFields (:array :SInt16 3))            ; private fields
)

;type name? (%define-record :ColorInfo (find-record-descriptor ':ColorInfo))

(def-mactype :ColorInfoPtr (find-mactype '(:pointer :ColorInfo)))

(def-mactype :ColorInfoHandle (find-mactype '(:handle :ColorInfo)))
(defrecord (Palette :handle)
   (pmEntries :SInt16)                          ; entries in pmTable
   (pmDataFields (:array :SInt16 7))            ; private fields
   (pmInfo (:array :ColorInfo 1))
)

;type name? (%define-record :Palette (find-record-descriptor ':Palette))

(def-mactype :PalettePtr (find-mactype '(:pointer :Palette)))

(def-mactype :PaletteHandle (find-mactype '(:handle :Palette)))
; 
;  *  InitPalettes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InitPalettes" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NewPalette()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewPalette" 
   ((entries :SInt16)
    (srcColors (:Handle :ColorTable))
    (srcUsage :SInt16)
    (srcTolerance :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :Palette)
() )
; 
;  *  GetNewPalette()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetNewPalette" 
   ((PaletteID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :Palette)
() )
; 
;  *  DisposePalette()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposePalette" 
   ((srcPalette (:Handle :Palette))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ActivatePalette()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ActivatePalette" 
   ((srcWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPalette()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetPalette" 
   ((dstWindow (:pointer :OpaqueWindowPtr))
    (srcPalette (:Handle :Palette))
    (cUpdates :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NSetPalette()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NSetPalette" 
   ((dstWindow (:pointer :OpaqueWindowPtr))
    (srcPalette (:Handle :Palette))
    (nCUpdates :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetPalette()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetPalette" 
   ((srcWindow (:pointer :OpaqueWindowPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :Palette)
() )
; 
;  *  CopyPalette()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CopyPalette" 
   ((srcPalette (:Handle :Palette))
    (dstPalette (:Handle :Palette))
    (srcEntry :SInt16)
    (dstEntry :SInt16)
    (dstLength :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PmForeColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PmForeColor" 
   ((dstEntry :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PmBackColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PmBackColor" 
   ((dstEntry :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AnimateEntry()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AnimateEntry" 
   ((dstWindow (:pointer :OpaqueWindowPtr))
    (dstEntry :SInt16)
    (srcRGB (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]AnimatePalette()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacAnimatePalette AnimatePalette

; #endif


(deftrap-inline "_AnimatePalette" 
   ((dstWindow (:pointer :OpaqueWindowPtr))
    (srcCTab (:Handle :ColorTable))
    (srcIndex :SInt16)
    (dstEntry :SInt16)
    (dstLength :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetEntryColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetEntryColor" 
   ((srcPalette (:Handle :Palette))
    (srcEntry :SInt16)
    (dstRGB (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetEntryColor()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetEntryColor" 
   ((dstPalette (:Handle :Palette))
    (dstEntry :SInt16)
    (srcRGB (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetEntryUsage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetEntryUsage" 
   ((srcPalette (:Handle :Palette))
    (srcEntry :SInt16)
    (dstUsage (:pointer :short))
    (dstTolerance (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetEntryUsage()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetEntryUsage" 
   ((dstPalette (:Handle :Palette))
    (dstEntry :SInt16)
    (srcUsage :SInt16)
    (srcTolerance :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CTab2Palette()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CTab2Palette" 
   ((srcCTab (:Handle :ColorTable))
    (dstPalette (:Handle :Palette))
    (srcUsage :SInt16)
    (srcTolerance :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  Palette2CTab()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Palette2CTab" 
   ((srcPalette (:Handle :Palette))
    (dstCTab (:Handle :ColorTable))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  Entry2Index()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Entry2Index" 
   ((entry :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  RestoreDeviceClut()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RestoreDeviceClut" 
   ((gd (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]ResizePalette()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacResizePalette ResizePalette

; #endif


(deftrap-inline "_ResizePalette" 
   ((p (:Handle :Palette))
    (size :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SaveFore()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SaveFore" 
   ((c (:pointer :ColorSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SaveBack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SaveBack" 
   ((c (:pointer :ColorSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RestoreFore()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RestoreFore" 
   ((c (:pointer :ColorSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RestoreBack()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RestoreBack" 
   ((c (:pointer :ColorSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetDepth()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetDepth" 
   ((gd (:Handle :GDEVICE))
    (depth :SInt16)
    (whichFlags :SInt16)
    (flags :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HasDepth()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HasDepth" 
   ((gd (:Handle :GDEVICE))
    (depth :SInt16)
    (whichFlags :SInt16)
    (flags :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  PMgrVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PMgrVersion" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetPaletteUpdates()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetPaletteUpdates" 
   ((p (:Handle :Palette))
    (updates :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetPaletteUpdates()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetPaletteUpdates" 
   ((p (:Handle :Palette))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetGray()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetGray" 
   ((device (:Handle :GDEVICE))
    (backGround (:pointer :RGBColor))
    (foreGround (:pointer :RGBColor))
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

; #endif /* __PALETTES__ */


(provide-interface "Palettes")