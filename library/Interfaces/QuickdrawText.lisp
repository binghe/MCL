(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:QuickdrawText.h"
; at Sunday July 2,2006 7:24:28 pm.
; 
;      File:       QD/QuickdrawText.h
;  
;      Contains:   Quickdraw Text Interfaces.
;  
;      Version:    Quickdraw-150~1
;  
;      Copyright:  © 1983-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __QUICKDRAWTEXT__
; #define __QUICKDRAWTEXT__
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
;  new CGrafPort bottleneck ("newProc2") function, used in Unicode Text drawing 
; 
;  *  StandardGlyphs()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in QuickDrawText 8.5 and later
;  

(deftrap-inline "_StandardGlyphs" 
   ((dataStream :pointer)
    (size :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  CharToPixel directions 

(defconstant $leftCaret 0)                      ; Place caret for left block

(defconstant $rightCaret -1)                    ; Place caret for right block

(defconstant $kHilite 1)                        ; Direction is SysDirection


(defconstant $smLeftCaret 0)                    ; Place caret for left block - obsolete 

(defconstant $smRightCaret -1)                  ; Place caret for right block - obsolete 

(defconstant $smHilite 1)                       ; Direction is TESysJust - obsolete 

; Constants for styleRunPosition argument in PortionLine, DrawJustified, MeasureJustified, CharToPixel, and PixelToChar.

(defconstant $onlyStyleRun 0)                   ;  This is the only style run on the line 

(defconstant $leftStyleRun 1)                   ;  This is leftmost of multiple style runs on the line 

(defconstant $rightStyleRun 2)                  ;  This is rightmost of multiple style runs on the line 

(defconstant $middleStyleRun 3)                 ;  There are multiple style runs on the line and this is neither the leftmost nor the rightmost. 

(defconstant $smOnlyStyleRun 0)                 ;  obsolete 

(defconstant $smLeftStyleRun 1)                 ;  obsolete 

(defconstant $smRightStyleRun 2)                ;  obsolete 

(defconstant $smMiddleStyleRun 3)               ;  obsolete 

;  type for styleRunPosition parameter in PixelToChar etc. 

(def-mactype :JustStyleCode (find-mactype ':SInt16))
;  Type for truncWhere parameter in TruncString, TruncText 

(def-mactype :TruncCode (find-mactype ':SInt16))
;  Constants for truncWhere argument in TruncString and TruncText 

(defconstant $truncEnd 0)                       ;  Truncate at end 

(defconstant $truncMiddle #x4000)               ;  Truncate in middle 

(defconstant $smTruncEnd 0)                     ;  Truncate at end - obsolete 

(defconstant $smTruncMiddle #x4000)             ;  Truncate in middle - obsolete 

;  Constants for TruncString and TruncText results 

(defconstant $notTruncated 0)                   ;  No truncation was necessary 

(defconstant $truncated 1)                      ;  Truncation performed 

(defconstant $truncErr -1)                      ;  General error 

(defconstant $smNotTruncated 0)                 ;  No truncation was necessary - obsolete 

(defconstant $smTruncated 1)                    ;  Truncation performed   - obsolete 
;  General error - obsolete 

(defconstant $smTruncErr -1)

(def-mactype :StyledLineBreakCode (find-mactype ':SInt8))

(defconstant $smBreakWord 0)
(defconstant $smBreakChar 1)
(defconstant $smBreakOverflow 2)
; QuickTime3.0
;  Constants for txFlags (which used to be the pad field after txFace) 

(defconstant $tfAntiAlias 1)
(defconstant $tfUnicode 2)
(defrecord FontInfo
   (ascent :SInt16)
   (descent :SInt16)
   (widMax :SInt16)
   (leading :SInt16)
)

;type name? (%define-record :FontInfo (find-record-descriptor ':FontInfo))
(defrecord FormatOrder
   (contents (:array :SInt16 1))
)
(def-mactype :FormatOrderPtr (find-mactype '(:pointer :FormatOrder)))
;  FormatStatus was moved to TextUtils.i 
;  OffsetTable moved to IntlResources.i 

(def-mactype :StyleRunDirectionProcPtr (find-mactype ':pointer)); (short styleRunIndex , void * dirParam)

(def-mactype :StyleRunDirectionUPP (find-mactype '(:pointer :OpaqueStyleRunDirectionProcPtr)))
; 
;  *  NewStyleRunDirectionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewStyleRunDirectionUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueStyleRunDirectionProcPtr)
() )
; 
;  *  DisposeStyleRunDirectionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeStyleRunDirectionUPP" 
   ((userUPP (:pointer :OpaqueStyleRunDirectionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeStyleRunDirectionUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeStyleRunDirectionUPP" 
   ((styleRunIndex :SInt16)
    (dirParam :pointer)
    (userUPP (:pointer :OpaqueStyleRunDirectionProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  Pixel2Char()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  Char2Pixel()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PixelToChar()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PixelToChar" 
   ((textBuf :pointer)
    (textLength :signed-long)
    (slop :signed-long)
    (pixelWidth :signed-long)
    (leadingEdge (:pointer :Boolean))
    (widthRemaining (:pointer :Fixed))
    (styleRunPosition :SInt16)
    (numer :Point)
    (denom :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  CharToPixel()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CharToPixel" 
   ((textBuf :pointer)
    (textLength :signed-long)
    (slop :signed-long)
    (offset :signed-long)
    (direction :SInt16)
    (styleRunPosition :SInt16)
    (numer :Point)
    (denom :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  DrawJustified()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DrawJustified" 
   ((textPtr :pointer)
    (textLength :signed-long)
    (slop :signed-long)
    (styleRunPosition :SInt16)
    (numer :Point)
    (denom :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MeasureJustified()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MeasureJustified" 
   ((textPtr :pointer)
    (textLength :signed-long)
    (slop :signed-long)
    (charLocs :pointer)
    (styleRunPosition :SInt16)
    (numer :Point)
    (denom :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PortionLine()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PortionLine" 
   ((textPtr :pointer)
    (textLen :signed-long)
    (styleRunPosition :SInt16)
    (numer :Point)
    (denom :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  HiliteText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HiliteText" 
   ((textPtr :pointer)
    (textLength :SInt16)
    (firstOffset :SInt16)
    (secondOffset :SInt16)
    (offsets (:pointer :OFFSETTABLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DrawJust()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  MeasureJust()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  PortionText()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  VisibleLength()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_VisibleLength" 
   ((textPtr :pointer)
    (textLength :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetFormatOrder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetFormatOrder" 
   ((ordering (:pointer :FormatOrder))
    (firstFormat :SInt16)
    (lastFormat :SInt16)
    (lineRight :Boolean)
    (rlDirProc (:pointer :OpaqueStyleRunDirectionProcPtr))
    (dirParam :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TextFont()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TextFont" 
   ((font :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TextFace()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TextFace" 
   ((face :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TextMode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TextMode" 
   ((mode :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TextSize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TextSize" 
   ((size :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SpaceExtra()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SpaceExtra" 
   ((extra :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DrawChar()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DrawChar" 
   ((ch :character)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DrawString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DrawString" 
   ((s (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]DrawText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacDrawText DrawText

; #endif


(deftrap-inline "_DrawText" 
   ((textBuf :pointer)
    (firstByte :SInt16)
    (byteCount :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CharWidth()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CharWidth" 
   ((ch :character)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  StringWidth()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StringWidth" 
   ((s (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  TextWidth()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TextWidth" 
   ((textBuf :pointer)
    (firstByte :SInt16)
    (byteCount :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  MeasureText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MeasureText" 
   ((count :SInt16)
    (textAddr :pointer)
    (charLocs :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetFontInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetFontInfo" 
   ((info (:pointer :FontInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CharExtra()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CharExtra" 
   ((extra :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StdText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StdText" 
   ((count :SInt16)
    (textAddr :pointer)
    (numer :Point)
    (denom :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StdTxMeas()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StdTxMeas" 
   ((byteCount :SInt16)
    (textAddr :pointer)
    (numer (:pointer :Point))
    (denom (:pointer :Point))
    (info (:pointer :FontInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  StyledLineBreak()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StyledLineBreak" 
   ((textPtr :pointer)
    (textLen :signed-long)
    (textStart :signed-long)
    (textEnd :signed-long)
    (flags :signed-long)
    (textWidth (:pointer :Fixed))
    (textOffset (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt8
() )
; 
;  *  TruncString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TruncString" 
   ((width :SInt16)
    (theString (:pointer :STR255))
    (truncWhere :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  TruncText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TruncText" 
   ((width :SInt16)
    (textPtr :pointer)
    (length (:pointer :short))
    (truncWhere :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  drawstring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  stringwidth()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  stdtext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_stdtext" 
   ((count :SInt16)
    (textAddr :pointer)
    (numer (:pointer :Point))
    (denom (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SwapQDTextFlags()
;  *  
;  *  Discussion:
;  *    Obsolete. Use QDSwapTextFlags instead (in Quickdraw.h).
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SwapQDTextFlags" 
   ((newFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :UInt32
() )

; #if OLDROUTINENAMES
#| 
; #define NPixel2Char(textBuf, textLen, slop, pixelWidth, leadingEdge, widthRemaining, styleRunPosition, numer, denom)     PixelToChar(textBuf, textLen, slop, pixelWidth, leadingEdge, widthRemaining, styleRunPosition, numer, denom) 
; #define NChar2Pixel(textBuf, textLen, slop, offset, direction, styleRunPosition, numer, denom)     CharToPixel(textBuf, textLen, slop, offset, direction, styleRunPosition, numer, denom)
; #define NDrawJust(textPtr, textLength, slop, styleRunPosition, numer, denom)     DrawJustified(textPtr, textLength, slop, styleRunPosition, numer, denom)
; #define NMeasureJust(textPtr, textLength, slop, charLocs, styleRunPosition, numer, denom)     MeasureJustified(textPtr, textLength, slop, charLocs, styleRunPosition, numer, denom)
; #define NPortionText(textPtr, textLen, styleRunPosition, numer, denom)    PortionLine(textPtr, textLen, styleRunPosition, numer, denom)
 |#

; #endif  /* OLDROUTINENAMES */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __QUICKDRAWTEXT__ */


(provide-interface "QuickdrawText")