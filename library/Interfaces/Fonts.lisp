(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Fonts.h"
; at Sunday July 2,2006 7:24:31 pm.
; 
;      File:       QD/Fonts.h
;  
;      Contains:   Public interface to the Font Manager.
;  
;      Version:    Quickdraw-150~1
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __FONTS__
; #define __FONTS__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __ATSTYPES__
#| #|
#include <ATSATSTypes.h>
#endif
|#
 |#
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

(defconstant $systemFont 0)
(defconstant $applFont 1)

(defconstant $kFMDefaultOptions 0)
;  Activation contexts 

(defconstant $kFMDefaultActivationContext 0)
(defconstant $kFMGlobalActivationContext 1)
(defconstant $kFMLocalActivationContext 0)
;  Iteration scopes 

(defconstant $kFMDefaultIterationScope 0)
(defconstant $kFMGlobalIterationScope 1)
(defconstant $kFMLocalIterationScope 0)
;  kPlatformDefaultGuiFontID is used in QuickTime 3.0. 

(defconstant $kPlatformDefaultGuiFontID 1)

(defconstant $commandMark 17)
(defconstant $checkMark 18)
(defconstant $diamondMark 19)
(defconstant $appleMark 20)

(defconstant $propFont #x9000)
(defconstant $prpFntH #x9001)
(defconstant $prpFntW #x9002)
(defconstant $prpFntHW #x9003)
(defconstant $fixedFont #xB000)
(defconstant $fxdFntH #xB001)
(defconstant $fxdFntW #xB002)
(defconstant $fxdFntHW #xB003)
(defconstant $fontWid #xACB0)
(defrecord FMInput
   (family :SInt16)
   (size :SInt16)
   (face :UInt8)
   (needBits :Boolean)
   (device :SInt16)
   (numer :Point)
   (denom :Point)
)

;type name? (%define-record :FMInput (find-record-descriptor ':FMInput))
(defrecord FMOutput
   (errNum :SInt16)
   (fontHandle :Handle)
   (boldPixels :UInt8)
   (italicPixels :UInt8)
   (ulOffset :UInt8)
   (ulShadow :UInt8)
   (ulThick :UInt8)
   (shadowPixels :UInt8)
   (extra :SInt8)
   (ascent :UInt8)
   (descent :UInt8)
   (widMax :UInt8)
   (leading :SInt8)
   (curStyle :SInt8)
   (numer :Point)
   (denom :Point)
)

;type name? (%define-record :FMOutput (find-record-descriptor ':FMOutput))

(def-mactype :FMOutputPtr (find-mactype '(:pointer :FMOutput)))

(def-mactype :FMOutPtr (find-mactype ':FMOutputPtr))
(defrecord FMetricRec
   (ascent :signed-long)                        ; base line to top
   (descent :signed-long)                       ; base line to bottom
   (leading :signed-long)                       ; leading between lines
   (widMax :signed-long)                        ; maximum character width
   (wTabHandle :Handle)                         ; handle to font width table
)

;type name? (%define-record :FMetricRec (find-record-descriptor ':FMetricRec))

(def-mactype :FMetricRecPtr (find-mactype '(:pointer :FMetricRec)))

(def-mactype :FMetricRecHandle (find-mactype '(:handle :FMetricRec)))
; 
;  *  InitFonts()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  GetFontName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetFontName" 
   ((familyID :SInt16)
    (name (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetFNum()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetFNum" 
   ((name (:pointer :STR255))
    (familyID (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RealFont()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RealFont" 
   ((fontNum :SInt16)
    (size :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SetFontLock()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  FMSwapFont()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FMSwapFont" 
   ((inRec (:pointer :FMInput))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :FMOutput)
() )
; 
;  *  SetFScaleDisable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetFScaleDisable" 
   ((fscaleDisable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FontMetrics()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FontMetrics" 
   ((theMetrics (:pointer :FMetricRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetFractEnable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetFractEnable" 
   ((fractEnable :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetDefFontSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetDefFontSize" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  IsOutline()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_IsOutline" 
   ((numer :Point)
    (denom :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SetOutlinePreferred()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetOutlinePreferred" 
   ((outlinePreferred :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetOutlinePreferred()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetOutlinePreferred" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  OutlineMetrics()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_OutlineMetrics" 
   ((byteCount :SInt16)
    (textPtr :pointer)
    (numer :Point)
    (denom :Point)
    (yMax (:pointer :short))
    (yMin (:pointer :short))
    (awArray (:pointer :signed-long))
    (lsbArray (:pointer :signed-long))
    (boundsArray (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetPreserveGlyph()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetPreserveGlyph" 
   ((preserveGlyph :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetPreserveGlyph()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetPreserveGlyph" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  FlushFonts()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  getfnum()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  getfontname()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  GetSysFont()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetSysFont" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetAppFont()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetAppFont" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; --------------------------------------------------------------------------------------
;   Extended font data functions (available only with Mac OS 8.5 or later)              
; --------------------------------------------------------------------------------------
; 
;  *  SetAntiAliasedTextEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_SetAntiAliasedTextEnabled" 
   ((iEnable :Boolean)
    (iMinFontSize :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  IsAntiAliasedTextEnabled()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_IsAntiAliasedTextEnabled" 
   ((oMinFontSize (:pointer :SInt16))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  QDTextBounds()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_QDTextBounds" 
   ((byteCount :SInt16)
    (textAddr :pointer)
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FetchFontInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.6 and later
;  

(deftrap-inline "_FetchFontInfo" 
   ((fontID :SInt16)
    (fontSize :SInt16)
    (fontStyle :SInt16)
    (info (:pointer :FontInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; --------------------------------------------------------------------------------------
;   Font access and data management functions (available only with Mac OS 9.0 or later) 
; --------------------------------------------------------------------------------------
;  Enumeration 
; 
;  *  FMCreateFontFamilyIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMCreateFontFamilyIterator" 
   ((iFilter (:pointer :FMFilter))              ;  can be NULL 
    (iRefCon :pointer)
    (iOptions :UInt32)
    (ioIterator (:pointer :FMFontFamilyIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMDisposeFontFamilyIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMDisposeFontFamilyIterator" 
   ((ioIterator (:pointer :FMFontFamilyIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMResetFontFamilyIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMResetFontFamilyIterator" 
   ((iFilter (:pointer :FMFilter))              ;  can be NULL 
    (iRefCon :pointer)
    (iOptions :UInt32)
    (ioIterator (:pointer :FMFontFamilyIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMGetNextFontFamily()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetNextFontFamily" 
   ((ioIterator (:pointer :FMFontFamilyIterator))
    (oFontFamily (:pointer :FMFONTFAMILY))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMCreateFontIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMCreateFontIterator" 
   ((iFilter (:pointer :FMFilter))              ;  can be NULL 
    (iRefCon :pointer)
    (iOptions :UInt32)
    (ioIterator (:pointer :FMFontIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMDisposeFontIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMDisposeFontIterator" 
   ((ioIterator (:pointer :FMFontIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMResetFontIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMResetFontIterator" 
   ((iFilter (:pointer :FMFilter))              ;  can be NULL 
    (iRefCon :pointer)
    (iOptions :UInt32)
    (ioIterator (:pointer :FMFontIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMGetNextFont()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetNextFont" 
   ((ioIterator (:pointer :FMFontIterator))
    (oFont (:pointer :FMFONT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Font families 
; 
;  *  FMCreateFontFamilyInstanceIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMCreateFontFamilyInstanceIterator" 
   ((iFontFamily :SInt16)
    (ioIterator (:pointer :FMFontFamilyInstanceIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMDisposeFontFamilyInstanceIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMDisposeFontFamilyInstanceIterator" 
   ((ioIterator (:pointer :FMFontFamilyInstanceIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMResetFontFamilyInstanceIterator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMResetFontFamilyInstanceIterator" 
   ((iFontFamily :SInt16)
    (ioIterator (:pointer :FMFontFamilyInstanceIterator))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMGetNextFontFamilyInstance()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetNextFontFamilyInstance" 
   ((ioIterator (:pointer :FMFontFamilyInstanceIterator))
    (oFont (:pointer :FMFONT))
    (oStyle (:pointer :FMFONTSTYLE))            ;  can be NULL 
    (oSize (:pointer :FMFONTSIZE))              ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMGetFontFamilyFromName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetFontFamilyFromName" 
   ((iName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  FMGetFontFamilyName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetFontFamilyName" 
   ((iFontFamily :SInt16)
    (oName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMGetFontFamilyTextEncoding()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetFontFamilyTextEncoding" 
   ((iFontFamily :SInt16)
    (oTextEncoding (:pointer :TEXTENCODING))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMGetFontFamilyGeneration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetFontFamilyGeneration" 
   ((iFontFamily :SInt16)
    (oGeneration (:pointer :FMGENERATION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Fonts 
; 
;  *  FMGetFontFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetFontFormat" 
   ((iFont :UInt32)
    (oFormat (:pointer :FourCharCode))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMGetFontTableDirectory()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetFontTableDirectory" 
   ((iFont :UInt32)
    (iLength :UInt32)
    (iBuffer :pointer)
    (oActualLength (:pointer :ByteCount))       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMGetFontTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetFontTable" 
   ((iFont :UInt32)
    (iTag :FourCharCode)
    (iOffset :UInt32)
    (iLength :UInt32)
    (iBuffer :pointer)
    (oActualLength (:pointer :ByteCount))       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMGetFontGeneration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetFontGeneration" 
   ((iFont :UInt32)
    (oGeneration (:pointer :FMGENERATION))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMGetFontContainer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetFontContainer" 
   ((iFont :UInt32)
    (oFontContainer (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Conversion 
; 
;  *  FMGetFontFromFontFamilyInstance()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetFontFromFontFamilyInstance" 
   ((iFontFamily :SInt16)
    (iStyle :SInt16)
    (oFont (:pointer :FMFONT))
    (oIntrinsicStyle (:pointer :FMFONTSTYLE))   ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMGetFontFamilyInstanceFromFont()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetFontFamilyInstanceFromFont" 
   ((iFont :UInt32)
    (oFontFamily (:pointer :FMFONTFAMILY))
    (oStyle (:pointer :FMFONTSTYLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMGetATSFontRefFromFont()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FMGetATSFontRefFromFont" 
   ((iFont :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :UInt32
() )
; 
;  *  FMGetATSFontFamilyRefFromFontFamily()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FMGetATSFontFamilyRefFromFontFamily" 
   ((iFamily :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :UInt32
() )
; 
;  *  FMGetFontFromATSFontRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FMGetFontFromATSFontRef" 
   ((iFont :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :UInt32
() )
; 
;  *  FMGetFontFamilyFromATSFontFamilyRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FMGetFontFamilyFromATSFontFamilyRef" 
   ((iFamily :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :SInt16
() )
;  Activation 
; 
;  *  FMActivateFonts()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMActivateFonts" 
   ((iFontContainer (:pointer :FSSpec))
    (iFilter (:pointer :FMFilter))              ;  can be NULL 
    (iRefCon :pointer)
    (iOptions :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMDeactivateFonts()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMDeactivateFonts" 
   ((iFontContainer (:pointer :FSSpec))
    (iFilter (:pointer :FMFilter))              ;  can be NULL 
    (iRefCon :pointer)
    (iOptions :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  FMGetGeneration()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in FontManager 9.0 and later
;  

(deftrap-inline "_FMGetGeneration" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
;  Container Access 
; 
;  *  FMGetFontContainerFromFontFamilyInstance()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FMGetFontContainerFromFontFamilyInstance" 
   ((iFontFamily :SInt16)
    (iStyle :SInt16)
    (iFontSize :SInt16)
    (oFontContainer (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  FMGetFontFamilyResource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_FMGetFontFamilyResource" 
   ((iFontFamily :SInt16)
    (iFontStyle :SInt16)
    (iFontSize :SInt16)
    (iBufferSize :UInt32)
    (ioBuffer :pointer)
    (oSize (:pointer :ByteCount))               ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )

(def-mactype :FontFamilyID (find-mactype ':SInt16))

(def-mactype :FontPointSize (find-mactype ':SInt16))
; --------------------------------------------------------------------------------------
;  Deprecated constant and type definitions                                             
; --------------------------------------------------------------------------------------
;  The font identifier constants are deprecated; use GetFNum or FMGetFontFamilyFromName
;    to find a font family from a standard QuickDraw name.
; 

(defconstant $kFMUseGlobalScopeOption 1)

(defconstant $kFontIDNewYork 2)
(defconstant $kFontIDGeneva 3)
(defconstant $kFontIDMonaco 4)
(defconstant $kFontIDVenice 5)
(defconstant $kFontIDLondon 6)
(defconstant $kFontIDAthens 7)
(defconstant $kFontIDSanFrancisco 8)
(defconstant $kFontIDToronto 9)
(defconstant $kFontIDCairo 11)
(defconstant $kFontIDLosAngeles 12)
(defconstant $kFontIDTimes 20)
(defconstant $kFontIDHelvetica 21)
(defconstant $kFontIDCourier 22)
(defconstant $kFontIDSymbol 23)
(defconstant $kFontIDMobile 24)
;  The following data structures referenced by the low memory global variables of the
;    Font Manager are deprecated on Mac OS X and CarbonLib 1.1. The low memory global
;    variables are not shared between processes and may result in inconsistencies
;    compared to previous releases of the system software. Changes made to the
;    information contained in the low memory global variables, including any
;    indirectly referenced width tables, font family records, and font records, are
;    not reflected in the global state of the Font Manager and may only be accessed
;    through the font access and data management functions of the Font Manager or ATS.
; 
(defrecord WidEntry
   (widStyle :SInt16)                           ; style entry applies to
)

;type name? (%define-record :WidEntry (find-record-descriptor ':WidEntry))
(defrecord WidTable
   (numWidths :SInt16)                          ; number of entries - 1
)

;type name? (%define-record :WidTable (find-record-descriptor ':WidTable))
(defrecord AsscEntry
   (fontSize :SInt16)
   (fontStyle :SInt16)
   (fontID :SInt16)                             ; font resource ID
)

;type name? (%define-record :AsscEntry (find-record-descriptor ':AsscEntry))
(defrecord FontAssoc
   (numAssoc :SInt16)                           ; number of entries - 1
)

;type name? (%define-record :FontAssoc (find-record-descriptor ':FontAssoc))
(defrecord StyleTable
   (fontClass :SInt16)
   (offset :signed-long)
   (reserved :signed-long)
   (indexes (:array :character 48))
)

;type name? (%define-record :StyleTable (find-record-descriptor ':StyleTable))
(defrecord NameTable
   (stringCount :SInt16)
   (baseFontName (:string 255))
)

;type name? (%define-record :NameTable (find-record-descriptor ':NameTable))
(defrecord KernPair
   (kernFirst :character)                       ; 1st character of kerned pair
   (kernSecond :character)                      ; 2nd character of kerned pair
   (kernWidth :SInt16)                          ; kerning in 1pt fixed format
)

;type name? (%define-record :KernPair (find-record-descriptor ':KernPair))
(defrecord KernEntry
   (kernStyle :SInt16)                          ; style the entry applies to
   (kernLength :SInt16)                         ; length of this entry
)

;type name? (%define-record :KernEntry (find-record-descriptor ':KernEntry))
(defrecord KernTable
   (numKerns :SInt16)                           ; number of kerning entries
)

;type name? (%define-record :KernTable (find-record-descriptor ':KernTable))
(defrecord WidthTable
   (tabData (:array :signed-long 256))          ; character widths
   (tabFont :Handle)                            ; font record used to build table
   (sExtra :signed-long)                        ; space extra used for table
   (style :signed-long)                         ; extra due to style
   (fID :SInt16)                                ; font family ID
   (fSize :SInt16)                              ; font size request
   (face :SInt16)                               ; style (face) request
   (device :SInt16)                             ; device requested
   (inNumer :Point)                             ; scale factors requested
   (inDenom :Point)                             ; scale factors requested
   (aFID :SInt16)                               ; actual font family ID for table
   (fHand :Handle)                              ; family record used to build up table
   (usedFam :Boolean)                           ; used fixed point family widths
   (aFace :UInt8)                               ; actual face produced
   (vOutput :SInt16)                            ; vertical scale output value
   (hOutput :SInt16)                            ; horizontal scale output value
   (vFactor :SInt16)                            ; vertical scale output value
   (hFactor :SInt16)                            ; horizontal scale output value
   (aSize :SInt16)                              ; actual size of actual font used
   (tabSize :SInt16)                            ; total size of table
)

;type name? (%define-record :WidthTable (find-record-descriptor ':WidthTable))

(def-mactype :WidthTablePtr (find-mactype '(:pointer :WidthTable)))

(def-mactype :WidthTableHdl (find-mactype '(:handle :WidthTable)))
(defrecord FamRec
   (ffFlags :SInt16)                            ; flags for family
   (ffFamID :SInt16)                            ; family ID number
   (ffFirstChar :SInt16)                        ; ASCII code of 1st character
   (ffLastChar :SInt16)                         ; ASCII code of last character
   (ffAscent :SInt16)                           ; maximum ascent for 1pt font
   (ffDescent :SInt16)                          ; maximum descent for 1pt font
   (ffLeading :SInt16)                          ; maximum leading for 1pt font
   (ffWidMax :SInt16)                           ; maximum widMax for 1pt font
   (ffWTabOff :signed-long)                     ; offset to width table
   (ffKernOff :signed-long)                     ; offset to kerning table
   (ffStylOff :signed-long)                     ; offset to style mapping table
   (ffProperty (:array :SInt16 9))              ; style property info
   (ffIntl (:array :SInt16 2))                  ; for international use
   (ffVersion :SInt16)                          ; version number
)

;type name? (%define-record :FamRec (find-record-descriptor ':FamRec))
(defrecord FontRec
   (fontType :SInt16)                           ; font type
   (firstChar :SInt16)                          ; ASCII code of first character
   (lastChar :SInt16)                           ; ASCII code of last character
   (widMax :SInt16)                             ; maximum character width
   (kernMax :SInt16)                            ; negative of maximum character kern
   (nDescent :SInt16)                           ; negative of descent
   (fRectWidth :SInt16)                         ; width of font rectangle
   (fRectHeight :SInt16)                        ; height of font rectangle
   (owTLoc :UInt16)                             ; offset to offset/width table
   (ascent :SInt16)                             ; ascent
   (descent :SInt16)                            ; descent
   (leading :SInt16)                            ; leading
   (rowWords :SInt16)                           ; row width of bit image / 2 
)

;type name? (%define-record :FontRec (find-record-descriptor ':FontRec))

(def-mactype :FontRecPtr (find-mactype '(:pointer :FontRec)))

(def-mactype :FontRecHdl (find-mactype '(:handle :FontRec)))
; --------------------------------------------------------------------------------------

; #if OLDROUTINENAMES
#| 
(defconstant $newYork 2)
(defconstant $geneva 3)
(defconstant $monaco 4)
(defconstant $venice 5)
(defconstant $london 6)
(defconstant $athens 7)
(defconstant $sanFran 8)
(defconstant $toronto 9)
(defconstant $cairo 11)
(defconstant $losAngeles 12)
(defconstant $times 20)
(defconstant $helvetica 21)
(defconstant $courier 22)
(defconstant $symbol 23)
(defconstant $mobile 24)
 |#

; #endif  /* OLDROUTINENAMES */

; --------------------------------------------------------------------------------------
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __FONTS__ */


(provide-interface "Fonts")