(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ATSTypes.h"
; at Sunday July 2,2006 7:23:45 pm.
; 
;      File:       ATS/ATSTypes.h
;  
;      Contains:   Public interfaces for Apple Type Services components.
;  
;      Version:    ATS-135~1
;  
;      Copyright:  © 1997-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __ATSTYPES__
; #define __ATSTYPES__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
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

(def-mactype :FMGeneration (find-mactype ':UInt32))
;  The FMFontFamily reference represents a collection of fonts with the same design
;    characteristics. It replaces the standard QuickDraw font identifer and may be used
;    with all QuickDraw functions including GetFontName and TextFont. It cannot be used
;    with the Resource Manager to access information from a FOND resource handle. A font
;    reference does not imply a particular script system, nor is the character encoding
;    of a font family determined by an arithmetic mapping of its value.
; 

(def-mactype :FMFontFamily (find-mactype ':SInt16))

(def-mactype :FMFontStyle (find-mactype ':SInt16))

(def-mactype :FMFontSize (find-mactype ':SInt16))
;  
;    The font family is a collection of fonts, each of which is identified
;    by an FMFont reference that maps to a single object registered with
;    the font database. The font references associated with the font
;    family consist of individual outline and bitmapped fonts that may be
;    used with the font access routines of the Font Manager and ATS.
; 

(def-mactype :FMFont (find-mactype ':UInt32))
(defrecord FMFontFamilyInstance
   (fontFamily :SInt16)
   (fontStyle :SInt16)
)

;type name? (%define-record :FMFontFamilyInstance (find-record-descriptor ':FMFontFamilyInstance))
(defrecord FMFontFamilyIterator
   (reserved (:array :UInt32 16))
)

;type name? (%define-record :FMFontFamilyIterator (find-record-descriptor ':FMFontFamilyIterator))
(defrecord FMFontIterator
   (reserved (:array :UInt32 16))
)

;type name? (%define-record :FMFontIterator (find-record-descriptor ':FMFontIterator))
(defrecord FMFontFamilyInstanceIterator
   (reserved (:array :UInt32 16))
)

;type name? (%define-record :FMFontFamilyInstanceIterator (find-record-descriptor ':FMFontFamilyInstanceIterator))

(defconstant $kInvalidGeneration 0)
(defconstant $kInvalidFontFamily -1)
(defconstant $kInvalidFont 0)

(defconstant $kFMCurrentFilterFormat 0)

(def-mactype :FMFilterSelector (find-mactype ':UInt32))

(defconstant $kFMFontTechnologyFilterSelector 1)
(defconstant $kFMFontContainerFilterSelector 2)
(defconstant $kFMGenerationFilterSelector 3)
(defconstant $kFMFontFamilyCallbackFilterSelector 4)
(defconstant $kFMFontCallbackFilterSelector 5)
(defconstant $kFMFontDirectoryFilterSelector 6)

(defconstant $kFMTrueTypeFontTechnology :|true|)
(defconstant $kFMPostScriptFontTechnology :|typ1|)

(def-mactype :FMFontFamilyCallbackFilterProcPtr (find-mactype ':pointer)); (FMFontFamily iFontFamily , void * iRefCon)

(def-mactype :FMFontCallbackFilterProcPtr (find-mactype ':pointer)); (FMFont iFont , void * iRefCon)

(def-mactype :FMFontFamilyCallbackFilterUPP (find-mactype '(:pointer :OpaqueFMFontFamilyCallbackFilterProcPtr)))

(def-mactype :FMFontCallbackFilterUPP (find-mactype '(:pointer :OpaqueFMFontCallbackFilterProcPtr)))
; 
;  *  NewFMFontFamilyCallbackFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewFMFontFamilyCallbackFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueFMFontFamilyCallbackFilterProcPtr)
() )
; 
;  *  NewFMFontCallbackFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewFMFontCallbackFilterUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueFMFontCallbackFilterProcPtr)
() )
; 
;  *  DisposeFMFontFamilyCallbackFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeFMFontFamilyCallbackFilterUPP" 
   ((userUPP (:pointer :OpaqueFMFontFamilyCallbackFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeFMFontCallbackFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeFMFontCallbackFilterUPP" 
   ((userUPP (:pointer :OpaqueFMFontCallbackFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeFMFontFamilyCallbackFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeFMFontFamilyCallbackFilterUPP" 
   ((iFontFamily :SInt16)
    (iRefCon :pointer)
    (userUPP (:pointer :OpaqueFMFontFamilyCallbackFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  InvokeFMFontCallbackFilterUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeFMFontCallbackFilterUPP" 
   ((iFont :UInt32)
    (iRefCon :pointer)
    (userUPP (:pointer :OpaqueFMFontCallbackFilterProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
(defrecord FMFontDirectoryFilter
   (fontFolderDomain :SInt16)
   (reserved (:array :UInt32 2))
)

;type name? (%define-record :FMFontDirectoryFilter (find-record-descriptor ':FMFontDirectoryFilter))
(defrecord FMFilter
   (format :UInt32)
   (selector :UInt32)
   (:variant
   (
   (fontTechnologyFilter :FourCharCode)
   )
   (
   (fontContainerFilter :FSSpec)
   )
   (
   (generationFilter :UInt32)
   )
   (
   (fontFamilyCallbackFilter (:pointer :OpaqueFMFontFamilyCallbackFilterProcPtr))
   )
   (
   (fontCallbackFilter (:pointer :OpaqueFMFontCallbackFilterProcPtr))
   )
   (
   (fontDirectoryFilter :FMFontDirectoryFilter)
   )
   )
)

;type name? (%define-record :FMFilter (find-record-descriptor ':FMFilter))

(def-mactype :ATSOptionFlags (find-mactype ':UInt32))

(def-mactype :ATSGeneration (find-mactype ':UInt32))

(def-mactype :ATSFontContainerRef (find-mactype ':UInt32))

(def-mactype :ATSFontFamilyRef (find-mactype ':UInt32))

(def-mactype :ATSFontRef (find-mactype ':UInt32))

(def-mactype :ATSGlyphRef (find-mactype ':UInt16))

(def-mactype :ATSFontSize (find-mactype ':single-float))

(defconstant $kATSGenerationUnspecified 0)
(defconstant $kATSFontContainerRefUnspecified 0)
(defconstant $kATSFontFamilyRefUnspecified 0)
(defconstant $kATSFontRefUnspecified 0)
(defrecord ATSFontMetrics
   (version :UInt32)
   (ascent :single-float)                       ;  Maximum height above baseline reached by the glyphs in the font 
                                                ;  or maximum distance to the right of the centerline reached by the glyphs in the font 
   (descent :single-float)                      ;  Maximum depth below baseline reached by the glyphs in the font 
                                                ;  or maximum distance to the left of the centerline reached by the glyphs in the font 
   (leading :single-float)                      ;  Desired spacing between lines of text 
   (avgAdvanceWidth :single-float)
   (maxAdvanceWidth :single-float)              ;  Maximum advance width or height of the glyphs in the font 
   (minLeftSideBearing :single-float)           ;  Minimum left or top side bearing 
   (minRightSideBearing :single-float)          ;  Minimum right or bottom side bearing 
   (stemWidth :single-float)                    ;  Width of the dominant vertical stems of the glyphs in the font 
   (stemHeight :single-float)                   ;  Vertical width of the dominant horizontal stems of glyphs in the font 
   (capHeight :single-float)                    ;  Height of a capital letter from the baseline to the top of the letter 
   (xHeight :single-float)                      ;  Height of lowercase characters in a font, specifically the letter x, excluding ascenders and descenders 
   (italicAngle :single-float)                  ;  Angle in degrees counterclockwise from the vertical of the dominant vertical strokes of the glyphs in the font 
   (underlinePosition :single-float)            ;  Distance from the baseline for positioning underlining strokes 
   (underlineThickness :single-float)           ;  Stroke width for underlining 
)

;type name? (%define-record :ATSFontMetrics (find-record-descriptor ':ATSFontMetrics))

(defconstant $kATSItalicQDSkew #x4000)          ;  fixed value of 0.25 

(defconstant $kATSBoldQDStretch #x18000)        ;  fixed value of 1.50 

(defconstant $kATSRadiansFactor #x478)          ;  fixed value of approx. pi/180 (0.0174560546875) 

;  Glyph outline path constants used in ATSFontGetNativeCurveType. 

(def-mactype :ATSCurveType (find-mactype ':UInt16))

(defconstant $kATSCubicCurveType 1)
(defconstant $kATSQuadCurveType 2)
(defconstant $kATSOtherCurveType 3)
;  
;     This is what the ATSGlyphRef is set to when the glyph is deleted -
;     that is, when the glyph is set to no longer appear when the layout
;     is actually drawn
; 

(defconstant $kATSDeletedGlyphcode #xFFFF)
(defrecord ATSUCurvePath
   (vectors :UInt32)
   (controlBits (:array :UInt32 1))
   (vector (:array :Float32Point 1))
)

;type name? (%define-record :ATSUCurvePath (find-record-descriptor ':ATSUCurvePath))
(defrecord ATSUCurvePaths
   (contours :UInt32)
   (contour (:array :ATSUCurvePath 1))
)

;type name? (%define-record :ATSUCurvePaths (find-record-descriptor ':ATSUCurvePaths))
;  Glyph ideal metrics 
(defrecord ATSGlyphIdealMetrics
   (advance :Float32Point)
   (sideBearing :Float32Point)
   (otherSideBearing :Float32Point)
)

;type name? (%define-record :ATSGlyphIdealMetrics (find-record-descriptor ':ATSGlyphIdealMetrics))
;  Glyph screen metrics 
(defrecord ATSGlyphScreenMetrics
   (deviceAdvance :Float32Point)
   (topLeft :Float32Point)
   (height :UInt32)
   (width :UInt32)
   (sideBearing :Float32Point)
   (otherSideBearing :Float32Point)
)

;type name? (%define-record :ATSGlyphScreenMetrics (find-record-descriptor ':ATSGlyphScreenMetrics))
;  Glyph References 

(def-mactype :GlyphID (find-mactype ':UInt16))
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __ATSTYPES__ */


(provide-interface "ATSTypes")