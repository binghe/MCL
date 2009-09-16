(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:PictUtils.h"
; at Sunday July 2,2006 7:24:32 pm.
; 
;      File:       QD/PictUtils.h
;  
;      Contains:   Picture Utilities Interfaces.
;  
;      Version:    Quickdraw-150~1
;  
;      Copyright:  © 1990-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __PICTUTILS__
; #define __PICTUTILS__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __PALETTES__
#| #|
#include <QDPalettes.h>
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
;  verbs for the GetPictInfo, GetPixMapInfo, and NewPictInfo calls 

(defconstant $returnColorTable 1)
(defconstant $returnPalette 2)
(defconstant $recordComments 4)
(defconstant $recordFontInfo 8)
(defconstant $suppressBlackAndWhite 16)
;  color pick methods 

(defconstant $systemMethod 0)                   ;  system color pick method 

(defconstant $popularMethod 1)                  ;  method that chooses the most popular set of colors 

(defconstant $medianMethod 2)                   ;  method that chooses a good average mix of colors 

;  color bank types 

(defconstant $ColorBankIsCustom -1)
(defconstant $ColorBankIsExactAnd555 0)
(defconstant $ColorBankIs555 1)

(def-mactype :PictInfoID (find-mactype ':signed-long))
(defrecord CommentSpec
   (count :SInt16)                              ;  number of occurrances of this comment ID 
   (ID :SInt16)                                 ;  ID for the comment in the picture 
)

;type name? (%define-record :CommentSpec (find-record-descriptor ':CommentSpec))

(def-mactype :CommentSpecPtr (find-mactype '(:pointer :CommentSpec)))

(def-mactype :CommentSpecHandle (find-mactype '(:handle :CommentSpec)))
(defrecord FontSpec
   (pictFontID :SInt16)                         ;  ID of the font in the picture 
   (sysFontID :SInt16)                          ;  ID of the same font in the current system file 
   (size (:array :signed-long 4))               ;  bit array of all the sizes found (1..127) (bit 0 means > 127) 
   (style :SInt16)                              ;  combined style of all occurrances of the font 
   (nameOffset :signed-long)                    ;  offset into the fontNamesHdl handle for the font’s name 
)

;type name? (%define-record :FontSpec (find-record-descriptor ':FontSpec))

(def-mactype :FontSpecPtr (find-mactype '(:pointer :FontSpec)))

(def-mactype :FontSpecHandle (find-mactype '(:handle :FontSpec)))
(defrecord PictInfo
   (version :SInt16)                            ;  this is always zero, for now 
   (uniqueColors :signed-long)                  ;  the number of actual colors in the picture(s)/pixmap(s) 
   (thePalette (:Handle :Palette))              ;  handle to the palette information 
   (theColorTable (:Handle :ColorTable))        ;  handle to the color table 
   (hRes :signed-long)                          ;  maximum horizontal resolution for all the pixmaps 
   (vRes :signed-long)                          ;  maximum vertical resolution for all the pixmaps 
   (depth :SInt16)                              ;  maximum depth for all the pixmaps (in the picture) 
   (sourceRect :Rect)                           ;  the picture frame rectangle (this contains the entire picture) 
   (textCount :signed-long)                     ;  total number of text strings in the picture 
   (lineCount :signed-long)                     ;  total number of lines in the picture 
   (rectCount :signed-long)                     ;  total number of rectangles in the picture 
   (rRectCount :signed-long)                    ;  total number of round rectangles in the picture 
   (ovalCount :signed-long)                     ;  total number of ovals in the picture 
   (arcCount :signed-long)                      ;  total number of arcs in the picture 
   (polyCount :signed-long)                     ;  total number of polygons in the picture 
   (regionCount :signed-long)                   ;  total number of regions in the picture 
   (bitMapCount :signed-long)                   ;  total number of bitmaps in the picture 
   (pixMapCount :signed-long)                   ;  total number of pixmaps in the picture 
   (commentCount :signed-long)                  ;  total number of comments in the picture 
   (uniqueComments :signed-long)                ;  the number of unique comments in the picture 
   (commentHandle (:Handle :CommentSpec))       ;  handle to all the comment information 
   (uniqueFonts :signed-long)                   ;  the number of unique fonts in the picture 
   (fontHandle (:Handle :FontSpec))             ;  handle to the FontSpec information 
   (fontNamesHandle :Handle)                    ;  handle to the font names 
   (reserved1 :signed-long)
   (reserved2 :signed-long)
)

;type name? (%define-record :PictInfo (find-record-descriptor ':PictInfo))

(def-mactype :PictInfoPtr (find-mactype '(:pointer :PictInfo)))

(def-mactype :PictInfoHandle (find-mactype '(:handle :PictInfo)))

(def-mactype :InitPickMethodProcPtr (find-mactype ':pointer)); (SInt16 colorsRequested , UInt32 * dataRef , SInt16 * colorBankType)

(def-mactype :RecordColorsProcPtr (find-mactype ':pointer)); (UInt32 dataRef , RGBColor * colorsArray , SInt32 colorCount , SInt32 * uniqueColors)

(def-mactype :CalcColorTableProcPtr (find-mactype ':pointer)); (UInt32 dataRef , SInt16 colorsRequested , void * colorBankPtr , CSpecArray resultPtr)

(def-mactype :DisposeColorPickMethodProcPtr (find-mactype ':pointer)); (UInt32 dataRef)

(def-mactype :InitPickMethodUPP (find-mactype '(:pointer :OpaqueInitPickMethodProcPtr)))

(def-mactype :RecordColorsUPP (find-mactype '(:pointer :OpaqueRecordColorsProcPtr)))

(def-mactype :CalcColorTableUPP (find-mactype '(:pointer :OpaqueCalcColorTableProcPtr)))

(def-mactype :DisposeColorPickMethodUPP (find-mactype '(:pointer :OpaqueDisposeColorPickMethodProcPtr)))
; 
;  *  NewInitPickMethodUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewInitPickMethodUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueInitPickMethodProcPtr)
() )
; 
;  *  NewRecordColorsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewRecordColorsUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRecordColorsProcPtr)
() )
; 
;  *  NewCalcColorTableUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCalcColorTableUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCalcColorTableProcPtr)
() )
; 
;  *  NewDisposeColorPickMethodUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDisposeColorPickMethodUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDisposeColorPickMethodProcPtr)
() )
; 
;  *  DisposeInitPickMethodUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeInitPickMethodUPP" 
   ((userUPP (:pointer :OpaqueInitPickMethodProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeRecordColorsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeRecordColorsUPP" 
   ((userUPP (:pointer :OpaqueRecordColorsProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCalcColorTableUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCalcColorTableUPP" 
   ((userUPP (:pointer :OpaqueCalcColorTableProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDisposeColorPickMethodUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDisposeColorPickMethodUPP" 
   ((userUPP (:pointer :OpaqueDisposeColorPickMethodProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeInitPickMethodUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeInitPickMethodUPP" 
   ((colorsRequested :SInt16)
    (dataRef (:pointer :UInt32))
    (colorBankType (:pointer :SInt16))
    (userUPP (:pointer :OpaqueInitPickMethodProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeRecordColorsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeRecordColorsUPP" 
   ((dataRef :UInt32)
    (colorsArray (:pointer :RGBColor))
    (colorCount :SInt32)
    (uniqueColors (:pointer :SInt32))
    (userUPP (:pointer :OpaqueRecordColorsProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeCalcColorTableUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCalcColorTableUPP" 
   ((dataRef :UInt32)
    (colorsRequested :SInt16)
    (colorBankPtr :pointer)
    (resultPtr (:pointer :CSPECARRAY))
    (userUPP (:pointer :OpaqueCalcColorTableProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  InvokeDisposeColorPickMethodUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDisposeColorPickMethodUPP" 
   ((dataRef :UInt32)
    (userUPP (:pointer :OpaqueDisposeColorPickMethodProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetPictInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetPictInfo" 
   ((thePictHandle (:Handle :Picture))
    (thePictInfo (:pointer :PictInfo))
    (verb :SInt16)
    (colorsRequested :SInt16)
    (colorPickMethod :SInt16)
    (version :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetPixMapInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetPixMapInfo" 
   ((thePixMapHandle (:Handle :PixMap))
    (thePictInfo (:pointer :PictInfo))
    (verb :SInt16)
    (colorsRequested :SInt16)
    (colorPickMethod :SInt16)
    (version :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  NewPictInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewPictInfo" 
   ((thePictInfoID (:pointer :PICTINFOID))
    (verb :SInt16)
    (colorsRequested :SInt16)
    (colorPickMethod :SInt16)
    (version :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RecordPictInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RecordPictInfo" 
   ((thePictInfoID :signed-long)
    (thePictHandle (:Handle :Picture))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RecordPixMapInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RecordPixMapInfo" 
   ((thePictInfoID :signed-long)
    (thePixMapHandle (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  RetrievePictInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RetrievePictInfo" 
   ((thePictInfoID :signed-long)
    (thePictInfo (:pointer :PictInfo))
    (colorsRequested :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  DisposePictInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposePictInfo" 
   ((thePictInfoID :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

; #if OLDROUTINENAMES
#| 
; #define DisposPictInfo(thePictInfoID) DisposePictInfo(thePictInfoID)
 |#

; #endif  /* OLDROUTINENAMES */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __PICTUTILS__ */


(provide-interface "PictUtils")