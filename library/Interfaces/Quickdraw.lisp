(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Quickdraw.h"
; at Sunday July 2,2006 7:24:28 pm.
; 
;      File:       QD/Quickdraw.h
;  
;      Contains:   Interface to Quickdraw Graphics
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
; #ifndef __QUICKDRAW__
; #define __QUICKDRAW__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __COREGRAPHICS__
#| #|
#include <CoreGraphicsCoreGraphics.h>
#endif
|#
 |#
; #ifndef __QUICKDRAWTEXT__

(require-interface "QD/QuickdrawText")

; #endif

; #ifndef __CMTYPES__
#| #|
#include <ColorSyncCMTypes.h>
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
; invalid color table request

(defconstant $invalColReq -1)
;  transfer modes 

(defconstant $srcCopy 0)                        ; the 16 transfer modes

(defconstant $srcOr 1)
(defconstant $srcXor 2)
(defconstant $srcBic 3)
(defconstant $notSrcCopy 4)
(defconstant $notSrcOr 5)
(defconstant $notSrcXor 6)
(defconstant $notSrcBic 7)
(defconstant $patCopy 8)
(defconstant $patOr 9)
(defconstant $patXor 10)
(defconstant $patBic 11)
(defconstant $notPatCopy 12)
(defconstant $notPatOr 13)
(defconstant $notPatXor 14)
(defconstant $notPatBic 15)                     ;  Special Text Transfer Mode 

(defconstant $grayishTextOr 49)
(defconstant $hilitetransfermode 50)
(defconstant $hilite 50)                        ;  Arithmetic transfer modes 

(defconstant $blend 32)
(defconstant $addPin 33)
(defconstant $addOver 34)
(defconstant $subPin 35)
(defconstant $addMax 37)
(defconstant $adMax 37)
(defconstant $subOver 38)
(defconstant $adMin 39)
(defconstant $ditherCopy 64)                    ;  Transparent mode constant 

(defconstant $transparent 36)

(defconstant $italicBit 1)
(defconstant $ulineBit 2)
(defconstant $outlineBit 3)
(defconstant $shadowBit 4)
(defconstant $condenseBit 5)
(defconstant $extendBit 6)
;  QuickDraw color separation constants 

(defconstant $normalBit 0)                      ; normal screen mapping

(defconstant $inverseBit 1)                     ; inverse screen mapping

(defconstant $redBit 4)                         ; RGB additive mapping

(defconstant $greenBit 3)
(defconstant $blueBit 2)
(defconstant $cyanBit 8)                        ; CMYBk subtractive mapping

(defconstant $magentaBit 7)
(defconstant $yellowBit 6)
(defconstant $blackBit 5)

(defconstant $blackColor 33)                    ;  colors expressed in these mappings 

(defconstant $whiteColor 30)
(defconstant $redColor #xCD)
(defconstant $greenColor #x155)
(defconstant $blueColor #x199)
(defconstant $cyanColor #x111)
(defconstant $magentaColor #x89)
(defconstant $yellowColor 69)

(defconstant $picLParen 0)                      ;  standard picture comments 

(defconstant $picRParen 1)
;  gdType values 

(defconstant $clutType 0)                       ;  lookup table 

(defconstant $fixedType 1)                      ;  fixed table - now unused 

(defconstant $directType 2)                     ;  direct values 

;  gdFlags bits. Bits 1..10 are legacy, and currently unused 

(defconstant $gdDevType 0)                      ;  0 = monochrome 1 = color 

(defconstant $interlacedDevice 2)
(defconstant $hwMirroredDevice 4)
(defconstant $roundedDevice 5)
(defconstant $hasAuxMenuBar 6)
(defconstant $burstDevice 7)
(defconstant $ext32Device 8)
(defconstant $ramInit 10)
(defconstant $mainScreen 11)                    ;  1 if main screen 

(defconstant $allInit 12)                       ;  1 if all devices initialized 

(defconstant $screenDevice 13)                  ;  1 if screen device 

(defconstant $noDriver 14)                      ;  1 if no driver for this GDevice 

(defconstant $screenActive 15)                  ;  1 if in use


(defconstant $hiliteBit 7)                      ;  flag bit in LMGet/SetHiliteMode 

(defconstant $pHiliteBit 0)                     ;  flag bit in LMGet/SetHiliteMode when used with BitClr 

;  miscellaneous constants 

(defconstant $defQDColors 127)                  ;  (legacy - now unused) 

(defconstant $RGBDirect 16)                     ;  16 & 32 bits/pixel pixelType value 

(defconstant $baseAddr32 4)                     ;  pmVersion value: pixmap base address is 32-bit address 


(defconstant $sysPatListID 0)
(defconstant $iBeamCursor 1)
(defconstant $crossCursor 2)
(defconstant $plusCursor 3)
(defconstant $watchCursor 4)

(defconstant $kQDGrafVerbFrame 0)
(defconstant $kQDGrafVerbPaint 1)
(defconstant $kQDGrafVerbErase 2)
(defconstant $kQDGrafVerbInvert 3)
(defconstant $kQDGrafVerbFill 4)

; #if OLDROUTINENAMES
#| 
(defconstant $frame 0)
(defconstant $paint 1)
(defconstant $erase 2)
(defconstant $invert 3)
(defconstant $fill 4)
 |#

; #endif  /* OLDROUTINENAMES */


(def-mactype :GrafVerb (find-mactype ':SInt8))

(defconstant $chunky 0)
(defconstant $chunkyPlanar 1)
(defconstant $planar 2)

(def-mactype :PixelType (find-mactype ':SInt8))
(defrecord Bits16
   (contents (:array :SInt16 16))
)
; **************   IMPORTANT NOTE REGARDING Pattern  **************************************
;    Patterns were originally defined as:
;    
;         C:          typedef unsigned char Pattern[8];
;         Pascal:     Pattern = PACKED ARRAY [0..7] OF 0..255;
;         
;    The old array definition of Pattern would cause 68000 based CPU's to crash in certain circum-
;    stances. The new struct definition is safe, but may require source code changes to compile.
;     
; ********************************************************************************************
(defrecord (Pattern :handle)
   (pat (:array :UInt8 8))
)

;type name? (%define-record :Pattern (find-record-descriptor ':Pattern))
; 
;  ConstPatternParam is no longer needed.  It was first created when Pattern was an array.
;  Now that Pattern is a struct, it is more straight forward to just add the "const" qualifier
;  on the parameter type (e.g. "const Pattern * pat" instead of "ConstPatternParam pat").
; 

(def-mactype :ConstPatternParam (find-mactype '(:pointer :Pattern)))

(def-mactype :PatPtr (find-mactype '(:pointer :Pattern)))

(def-mactype :PatHandle (find-mactype '(:handle :Pattern)))

(def-mactype :QDByte (find-mactype ':SInt8))

(def-mactype :QDPtr (find-mactype '(:pointer :SInt8)))

(def-mactype :QDHandle (find-mactype '(:handle :SInt8)))

(def-mactype :QDErr (find-mactype ':SInt16))

(defconstant $singleDevicesBit 0)
(defconstant $dontMatchSeedsBit 1)
(defconstant $allDevicesBit 2)

(defconstant $singleDevices 1)
(defconstant $dontMatchSeeds 2)
(defconstant $allDevices 4)

(def-mactype :DeviceLoopFlags (find-mactype ':UInt32))
; 
;     PrinterStatusOpcode.  For communication with downloading and printing services.
; 

(def-mactype :PrinterStatusOpcode (find-mactype ':SInt32))

(defconstant $kPrinterFontStatus 0)
(defconstant $kPrinterScalingStatus 1)
(defrecord PrinterFontStatus
   (oResult :SInt32)
   (iFondID :SInt16)
   (iStyle :UInt8)
)

;type name? (%define-record :PrinterFontStatus (find-record-descriptor ':PrinterFontStatus))
(defrecord PrinterScalingStatus
   (oScalingFactors :Point)
)

;type name? (%define-record :PrinterScalingStatus (find-record-descriptor ':PrinterScalingStatus))
(defrecord BitMap
   (baseAddr :pointer)
   (rowBytes :SInt16)
   (bounds :Rect)
)

;type name? (%define-record :BitMap (find-record-descriptor ':BitMap))

(def-mactype :BitMapPtr (find-mactype '(:pointer :BitMap)))

(def-mactype :BitMapHandle (find-mactype '(:handle :BitMap)))
(defrecord (Cursor :handle)
   (data :BITS16)
   (mask :BITS16)
   (hotSpot :Point)
)

;type name? (%define-record :Cursor (find-record-descriptor ':Cursor))

(def-mactype :CursPtr (find-mactype '(:pointer :Cursor)))

(def-mactype :CursHandle (find-mactype '(:handle :Cursor)))
(defrecord PenState
   (pnLoc :Point)
   (pnSize :Point)
   (pnMode :SInt16)
   (pnPat :Pattern)
)

;type name? (%define-record :PenState (find-record-descriptor ':PenState))

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
(defrecord (MacRegion :handle)
   (rgnSize :UInt16)                            ;  size in bytes; don't rely on it 
   (rgnBBox :Rect)                              ;  enclosing rectangle; in Carbon use GetRegionBounds 
)

;type name? (def-mactype :MacRegion (find-mactype ':MacRegion))
; 
;    The type name "Region" has a name space collision on Win32.
;    Use MacRegion to be cross-platfrom safe.
; 

(def-mactype :Region (find-mactype ':MacRegion))

(def-mactype :RgnPtr (find-mactype '(:pointer :MacRegion)))

(def-mactype :RgnHandle (find-mactype '(:pointer :RgnPtr)))
 |#

; #else

(def-mactype :RgnHandle (find-mactype '(:pointer :OpaqueRgnHandle)))

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */

(defrecord (Picture :handle)
   (picSize :SInt16)
   (picFrame :Rect)
)

;type name? (%define-record :Picture (find-record-descriptor ':Picture))

(def-mactype :PicPtr (find-mactype '(:pointer :Picture)))

(def-mactype :PicHandle (find-mactype '(:handle :Picture)))
(defrecord MacPolygon
   (polySize :SInt16)
   (polyBBox :Rect)
   (polyPoints (:array :Point 1))
)

;type name? (%define-record :MacPolygon (find-record-descriptor ':MacPolygon))
; 
;    The type name "Polygon" has a name space collision on Win32.
;    Use MacPolygon to be cross-platfrom safe.
; 

(%define-record :Polygon (find-record-descriptor ':MacPolygon))

(def-mactype :PolyPtr (find-mactype '(:pointer :MacPolygon)))

(def-mactype :PolyHandle (find-mactype '(:handle :MacPolygon)))

(def-mactype :QDTextProcPtr (find-mactype ':pointer)); (short byteCount , const void * textBuf , Point numer , Point denom)

(def-mactype :QDLineProcPtr (find-mactype ':pointer)); (Point newPt)

(def-mactype :QDRectProcPtr (find-mactype ':pointer)); (GrafVerb verb , const Rect * r)

(def-mactype :QDRRectProcPtr (find-mactype ':pointer)); (GrafVerb verb , const Rect * r , short ovalWidth , short ovalHeight)

(def-mactype :QDOvalProcPtr (find-mactype ':pointer)); (GrafVerb verb , const Rect * r)

(def-mactype :QDArcProcPtr (find-mactype ':pointer)); (GrafVerb verb , const Rect * r , short startAngle , short arcAngle)

(def-mactype :QDPolyProcPtr (find-mactype ':pointer)); (GrafVerb verb , PolyHandle poly)

(def-mactype :QDRgnProcPtr (find-mactype ':pointer)); (GrafVerb verb , RgnHandle rgn)

(def-mactype :QDBitsProcPtr (find-mactype ':pointer)); (const BitMap * srcBits , const Rect * srcRect , const Rect * dstRect , short mode , RgnHandle maskRgn)

(def-mactype :QDCommentProcPtr (find-mactype ':pointer)); (short kind , short dataSize , Handle dataHandle)

(def-mactype :QDTxMeasProcPtr (find-mactype ':pointer)); (short byteCount , const void * textAddr , Point * numer , Point * denom , FontInfo * info)

(def-mactype :QDGetPicProcPtr (find-mactype ':pointer)); (void * dataPtr , short byteCount)

(def-mactype :QDPutPicProcPtr (find-mactype ':pointer)); (const void * dataPtr , short byteCount)

(def-mactype :QDOpcodeProcPtr (find-mactype ':pointer)); (const Rect * fromRect , const Rect * toRect , UInt16 opcode , SInt16 version)
;  The following is unused on Mac OS X - ignore it! 

(def-mactype :QDStdGlyphsProcPtr (find-mactype ':pointer)); (void * dataStream , ByteCount size)

(def-mactype :QDJShieldCursorProcPtr (find-mactype ':pointer)); (short left , short top , short right , short bottom)

(def-mactype :QDTextUPP (find-mactype '(:pointer :OpaqueQDTextProcPtr)))

(def-mactype :QDLineUPP (find-mactype '(:pointer :OpaqueQDLineProcPtr)))

(def-mactype :QDRectUPP (find-mactype '(:pointer :OpaqueQDRectProcPtr)))

(def-mactype :QDRRectUPP (find-mactype '(:pointer :OpaqueQDRRectProcPtr)))

(def-mactype :QDOvalUPP (find-mactype '(:pointer :OpaqueQDOvalProcPtr)))

(def-mactype :QDArcUPP (find-mactype '(:pointer :OpaqueQDArcProcPtr)))

(def-mactype :QDPolyUPP (find-mactype '(:pointer :OpaqueQDPolyProcPtr)))

(def-mactype :QDRgnUPP (find-mactype '(:pointer :OpaqueQDRgnProcPtr)))

(def-mactype :QDBitsUPP (find-mactype '(:pointer :OpaqueQDBitsProcPtr)))

(def-mactype :QDCommentUPP (find-mactype '(:pointer :OpaqueQDCommentProcPtr)))

(def-mactype :QDTxMeasUPP (find-mactype '(:pointer :OpaqueQDTxMeasProcPtr)))

(def-mactype :QDGetPicUPP (find-mactype '(:pointer :OpaqueQDGetPicProcPtr)))

(def-mactype :QDPutPicUPP (find-mactype '(:pointer :OpaqueQDPutPicProcPtr)))

(def-mactype :QDOpcodeUPP (find-mactype '(:pointer :OpaqueQDOpcodeProcPtr)))

(def-mactype :QDStdGlyphsUPP (find-mactype '(:pointer :OpaqueQDStdGlyphsProcPtr)))

(def-mactype :QDJShieldCursorUPP (find-mactype '(:pointer :OpaqueQDJShieldCursorProcPtr)))
(defrecord QDProcs
   (textProc (:pointer :OpaqueQDTextProcPtr))
   (lineProc (:pointer :OpaqueQDLineProcPtr))
   (rectProc (:pointer :OpaqueQDRectProcPtr))
   (rRectProc (:pointer :OpaqueQDRRectProcPtr))
   (ovalProc (:pointer :OpaqueQDOvalProcPtr))
   (arcProc (:pointer :OpaqueQDArcProcPtr))
   (polyProc (:pointer :OpaqueQDPolyProcPtr))
   (rgnProc (:pointer :OpaqueQDRgnProcPtr))
   (bitsProc (:pointer :OpaqueQDBitsProcPtr))
   (commentProc (:pointer :OpaqueQDCommentProcPtr))
   (txMeasProc (:pointer :OpaqueQDTxMeasProcPtr))
   (getPicProc (:pointer :OpaqueQDGetPicProcPtr))
   (putPicProc (:pointer :OpaqueQDPutPicProcPtr))
)

;type name? (%define-record :QDProcs (find-record-descriptor ':QDProcs))

(def-mactype :QDProcsPtr (find-mactype '(:pointer :QDProcs)))
; 
;  *  NewQDTextUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDTextUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDTextProcPtr)
() )
; 
;  *  NewQDLineUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDLineUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDLineProcPtr)
() )
; 
;  *  NewQDRectUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDRectUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDRectProcPtr)
() )
; 
;  *  NewQDRRectUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDRRectUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDRRectProcPtr)
() )
; 
;  *  NewQDOvalUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDOvalUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDOvalProcPtr)
() )
; 
;  *  NewQDArcUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDArcUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDArcProcPtr)
() )
; 
;  *  NewQDPolyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDPolyUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDPolyProcPtr)
() )
; 
;  *  NewQDRgnUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDRgnUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDRgnProcPtr)
() )
; 
;  *  NewQDBitsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDBitsUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDBitsProcPtr)
() )
; 
;  *  NewQDCommentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDCommentUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDCommentProcPtr)
() )
; 
;  *  NewQDTxMeasUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDTxMeasUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDTxMeasProcPtr)
() )
; 
;  *  NewQDGetPicUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDGetPicUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDGetPicProcPtr)
() )
; 
;  *  NewQDPutPicUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDPutPicUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDPutPicProcPtr)
() )
; 
;  *  NewQDOpcodeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDOpcodeUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDOpcodeProcPtr)
() )
; 
;  *  NewQDStdGlyphsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDStdGlyphsUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDStdGlyphsProcPtr)
() )
; 
;  *  NewQDJShieldCursorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewQDJShieldCursorUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueQDJShieldCursorProcPtr)
() )
; 
;  *  DisposeQDTextUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDTextUPP" 
   ((userUPP (:pointer :OpaqueQDTextProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDLineUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDLineUPP" 
   ((userUPP (:pointer :OpaqueQDLineProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDRectUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDRectUPP" 
   ((userUPP (:pointer :OpaqueQDRectProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDRRectUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDRRectUPP" 
   ((userUPP (:pointer :OpaqueQDRRectProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDOvalUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDOvalUPP" 
   ((userUPP (:pointer :OpaqueQDOvalProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDArcUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDArcUPP" 
   ((userUPP (:pointer :OpaqueQDArcProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDPolyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDPolyUPP" 
   ((userUPP (:pointer :OpaqueQDPolyProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDRgnUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDRgnUPP" 
   ((userUPP (:pointer :OpaqueQDRgnProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDBitsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDBitsUPP" 
   ((userUPP (:pointer :OpaqueQDBitsProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDCommentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDCommentUPP" 
   ((userUPP (:pointer :OpaqueQDCommentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDTxMeasUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDTxMeasUPP" 
   ((userUPP (:pointer :OpaqueQDTxMeasProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDGetPicUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDGetPicUPP" 
   ((userUPP (:pointer :OpaqueQDGetPicProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDPutPicUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDPutPicUPP" 
   ((userUPP (:pointer :OpaqueQDPutPicProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDOpcodeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDOpcodeUPP" 
   ((userUPP (:pointer :OpaqueQDOpcodeProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDStdGlyphsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDStdGlyphsUPP" 
   ((userUPP (:pointer :OpaqueQDStdGlyphsProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeQDJShieldCursorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeQDJShieldCursorUPP" 
   ((userUPP (:pointer :OpaqueQDJShieldCursorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDTextUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDTextUPP" 
   ((byteCount :SInt16)
    (textBuf :pointer)
    (numer :Point)
    (denom :Point)
    (userUPP (:pointer :OpaqueQDTextProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDLineUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDLineUPP" 
   ((newPt :Point)
    (userUPP (:pointer :OpaqueQDLineProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDRectUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDRectUPP" 
   ((verb :SInt8)
    (r (:pointer :Rect))
    (userUPP (:pointer :OpaqueQDRectProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDRRectUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDRRectUPP" 
   ((verb :SInt8)
    (r (:pointer :Rect))
    (ovalWidth :SInt16)
    (ovalHeight :SInt16)
    (userUPP (:pointer :OpaqueQDRRectProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDOvalUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDOvalUPP" 
   ((verb :SInt8)
    (r (:pointer :Rect))
    (userUPP (:pointer :OpaqueQDOvalProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDArcUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDArcUPP" 
   ((verb :SInt8)
    (r (:pointer :Rect))
    (startAngle :SInt16)
    (arcAngle :SInt16)
    (userUPP (:pointer :OpaqueQDArcProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDPolyUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDPolyUPP" 
   ((verb :SInt8)
    (poly (:Handle :MacPolygon))
    (userUPP (:pointer :OpaqueQDPolyProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDRgnUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDRgnUPP" 
   ((verb :SInt8)
    (rgn (:pointer :OpaqueRgnHandle))
    (userUPP (:pointer :OpaqueQDRgnProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDBitsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDBitsUPP" 
   ((srcBits (:pointer :BitMap))
    (srcRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
    (mode :SInt16)
    (maskRgn (:pointer :OpaqueRgnHandle))
    (userUPP (:pointer :OpaqueQDBitsProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDCommentUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDCommentUPP" 
   ((kind :SInt16)
    (dataSize :SInt16)
    (dataHandle :Handle)
    (userUPP (:pointer :OpaqueQDCommentProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDTxMeasUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDTxMeasUPP" 
   ((byteCount :SInt16)
    (textAddr :pointer)
    (numer (:pointer :Point))
    (denom (:pointer :Point))
    (info (:pointer :FontInfo))
    (userUPP (:pointer :OpaqueQDTxMeasProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  InvokeQDGetPicUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDGetPicUPP" 
   ((dataPtr :pointer)
    (byteCount :SInt16)
    (userUPP (:pointer :OpaqueQDGetPicProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDPutPicUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDPutPicUPP" 
   ((dataPtr :pointer)
    (byteCount :SInt16)
    (userUPP (:pointer :OpaqueQDPutPicProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDOpcodeUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDOpcodeUPP" 
   ((fromRect (:pointer :Rect))
    (toRect (:pointer :Rect))
    (opcode :UInt16)
    (version :SInt16)
    (userUPP (:pointer :OpaqueQDOpcodeProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDStdGlyphsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDStdGlyphsUPP" 
   ((dataStream :pointer)
    (size :UInt32)
    (userUPP (:pointer :OpaqueQDStdGlyphsProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  InvokeQDJShieldCursorUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeQDJShieldCursorUPP" 
   ((left :SInt16)
    (top :SInt16)
    (right :SInt16)
    (bottom :SInt16)
    (userUPP (:pointer :OpaqueQDJShieldCursorProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
(defrecord GrafPort
   (device :SInt16)                             ;  not available in Carbon
   (portBits :BitMap)                           ;  in Carbon use GetPortBitMapForCopyBits or IsPortColor
   (portRect :Rect)                             ;  in Carbon use Get/SetPortBounds
   (visRgn (:pointer :OpaqueRgnHandle))         ;  in Carbon use Get/SetPortVisibleRegion
   (clipRgn (:pointer :OpaqueRgnHandle))        ;  in Carbon use Get/SetPortClipRegion
   (bkPat :Pattern)                             ;  not available in Carbon all GrafPorts are CGrafPorts
   (fillPat :Pattern)                           ;  not available in Carbon all GrafPorts are CGrafPorts
   (pnLoc :Point)                               ;  in Carbon use GetPortPenLocation or MoveTo
   (pnSize :Point)                              ;  in Carbon use Get/SetPortPenSize
   (pnMode :SInt16)                             ;  in Carbon use Get/SetPortPenMode
   (pnPat :Pattern)                             ;  not available in Carbon all GrafPorts are CGrafPorts
   (pnVis :SInt16)                              ;  in Carbon use GetPortPenVisibility or Show/HidePen
   (txFont :SInt16)                             ;  in Carbon use GetPortTextFont or TextFont
   (txFace :UInt8)                              ;  in Carbon use GetPortTextFace or TextFace
                                                ; StyleField occupies 16-bits, but only first 8-bits are used
   (txMode :SInt16)                             ;  in Carbon use GetPortTextMode or TextMode
   (txSize :SInt16)                             ;  in Carbon use GetPortTextSize or TextSize
   (spExtra :signed-long)                       ;  in Carbon use GetPortSpExtra or SpaceExtra
   (fgColor :signed-long)                       ;  not available in Carbon 
   (bkColor :signed-long)                       ;  not available in Carbon
   (colrBit :SInt16)                            ;  not available in Carbon
   (patStretch :SInt16)                         ;  not available in Carbon
   (picSave :Handle)                            ;  in Carbon use IsPortPictureBeingDefined
   (rgnSave :Handle)                            ;  not available in Carbon
   (polySave :Handle)                           ;  not available in Carbon
   (grafProcs (:pointer :QDProcs))              ;  not available in Carbon all GrafPorts are CGrafPorts
)

;type name? (def-mactype :GrafPort (find-mactype ':GrafPort))

(def-mactype :GrafPtr (find-mactype '(:pointer :GrafPort)))
; 
;  *  This set of definitions "belongs" in Windows.
;  *  But, there is a circularity in the headers where Windows includes Controls and
;  *  Controls includes Windows. To break the circle, the information
;  *  needed by Controls is moved from Windows to Quickdraw.
;  

(def-mactype :WindowPtr (find-mactype ':GrafPtr))

(def-mactype :DialogPtr (find-mactype ':WindowPtr))
 |#

; #else

(def-mactype :WindowPtr (find-mactype '(:pointer :OpaqueWindowPtr)))

(def-mactype :DialogPtr (find-mactype '(:pointer :OpaqueDialogPtr)))

(def-mactype :GrafPtr (find-mactype '(:pointer :OpaqueGrafPtr)))

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */


(def-mactype :WindowRef (find-mactype ':WindowPtr))
;  DragConstraint constants to pass to DragGray,DragTheRgn, or ConstrainedDragRgn

(def-mactype :DragConstraint (find-mactype ':UInt16))

(defconstant $kNoConstraint 0)
(defconstant $kVerticalConstraint 1)
(defconstant $kHorizontalConstraint 2)

(def-mactype :DragGrayRgnProcPtr (find-mactype ':pointer)); (void)
; 
;  *  Here ends the list of things that "belong" in Windows.
;  
(defrecord RGBColor
   (red :UInt16)                                ; magnitude of red component
   (green :UInt16)                              ; magnitude of green component
   (blue :UInt16)                               ; magnitude of blue component
)

;type name? (%define-record :RGBColor (find-record-descriptor ':RGBColor))

(def-mactype :RGBColorPtr (find-mactype '(:pointer :RGBColor)))

(def-mactype :RGBColorHdl (find-mactype '(:handle :RGBColor)))

(def-mactype :ColorSearchProcPtr (find-mactype ':pointer)); (RGBColor * rgb , long * position)

(def-mactype :ColorComplementProcPtr (find-mactype ':pointer)); (RGBColor * rgb)

(def-mactype :DragGrayRgnUPP (find-mactype '(:pointer :OpaqueDragGrayRgnProcPtr)))

(def-mactype :ColorSearchUPP (find-mactype '(:pointer :OpaqueColorSearchProcPtr)))

(def-mactype :ColorComplementUPP (find-mactype '(:pointer :OpaqueColorComplementProcPtr)))
; 
;  *  NewDragGrayRgnUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDragGrayRgnUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDragGrayRgnProcPtr)
() )
; 
;  *  NewColorSearchUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewColorSearchUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueColorSearchProcPtr)
() )
; 
;  *  NewColorComplementUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewColorComplementUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueColorComplementProcPtr)
() )
; 
;  *  DisposeDragGrayRgnUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDragGrayRgnUPP" 
   ((userUPP (:pointer :OpaqueDragGrayRgnProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeColorSearchUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeColorSearchUPP" 
   ((userUPP (:pointer :OpaqueColorSearchProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeColorComplementUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeColorComplementUPP" 
   ((userUPP (:pointer :OpaqueColorComplementProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeDragGrayRgnUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDragGrayRgnUPP" 
   ((userUPP (:pointer :OpaqueDragGrayRgnProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeColorSearchUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeColorSearchUPP" 
   ((rgb (:pointer :RGBColor))
    (position (:pointer :long))
    (userUPP (:pointer :OpaqueColorSearchProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeColorComplementUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeColorComplementUPP" 
   ((rgb (:pointer :RGBColor))
    (userUPP (:pointer :OpaqueColorComplementProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
(defrecord ColorSpec
   (value :SInt16)                              ; index or other value
   (rgb :RGBColor)                              ; true color
)

;type name? (%define-record :ColorSpec (find-record-descriptor ':ColorSpec))

(def-mactype :ColorSpecPtr (find-mactype '(:pointer :ColorSpec)))
(defrecord CSpecArray
   (contents (:array :ColorSpec 1))
)
(defrecord (ColorTable :handle)
   (ctSeed :signed-long)                        ; unique identifier for table
   (ctFlags :SInt16)                            ; high bit: 0 = PixMap; 1 = device
   (ctSize :SInt16)                             ; number of entries in CTTable
   (ctTable :CSPECARRAY)                        ; array [0..0] of ColorSpec
)

;type name? (%define-record :ColorTable (find-record-descriptor ':ColorTable))

(def-mactype :CTabPtr (find-mactype '(:pointer :ColorTable)))

(def-mactype :CTabHandle (find-mactype '(:handle :ColorTable)))
(defrecord xColorSpec
   (value :SInt16)                              ; index or other value
   (rgb :RGBColor)                              ; true color
   (xalpha :SInt16)
)

;type name? (%define-record :xColorSpec (find-record-descriptor ':xColorSpec))

(def-mactype :xColorSpecPtr (find-mactype '(:pointer :xColorSpec)))
(defrecord xCSpecArray
   (contents (:array :xColorSpec 1))
)
(defrecord MatchRec
   (red :UInt16)
   (green :UInt16)
   (blue :UInt16)
   (matchData :signed-long)
)

;type name? (%define-record :MatchRec (find-record-descriptor ':MatchRec))
; 
;     QuickTime 3.0 makes PixMap data structure available on non-Mac OS's.
;     In order to implement PixMap in these alternate environments, the PixMap
;     had to be extended. The pmReserved field was changed to pmExt which is
;     a Handle to extra info.  The planeBytes field was changed to pixelFormat.
;     
;     In OS X, Quickdraw also uses the new PixMap data structure.
; 
; #ifndef OLDPIXMAPSTRUCT

; #if TARGET_API_MAC_OS8
#| 
; #define OLDPIXMAPSTRUCT 1
 |#

; #else
(defconstant $OLDPIXMAPSTRUCT 0)
; #define OLDPIXMAPSTRUCT 0

; #endif  /* TARGET_API_MAC_OS8 */


; #endif  /* !defined(OLDPIXMAPSTRUCT) */


; #if OLDPIXMAPSTRUCT
#| 
; #define GETPIXMAPPIXELFORMAT(pm)        ( (pm)->pixelSize )
 |#

; #else
; #define GETPIXMAPPIXELFORMAT(pm)        ( ((pm)->pixelFormat != 0) ? (pm)->pixelFormat : (pm)->pixelSize )

; #endif


; #if TARGET_OS_MAC && TARGET_API_MAC_OS8
#| 
; #define NON_MAC_PIXEL_FORMATS   0
 |#

; #else
(defconstant $NON_MAC_PIXEL_FORMATS 1)
; #define NON_MAC_PIXEL_FORMATS   1

; #endif

;  pixel formats

(defconstant $k1MonochromePixelFormat 1)        ;  1 bit indexed

(defconstant $k2IndexedPixelFormat 2)           ;  2 bit indexed

(defconstant $k4IndexedPixelFormat 4)           ;  4 bit indexed

(defconstant $k8IndexedPixelFormat 8)           ;  8 bit indexed

(defconstant $k16BE555PixelFormat 16)           ;  16 bit BE rgb 555 (Mac)

(defconstant $k24RGBPixelFormat 24)             ;  24 bit rgb 

(defconstant $k32ARGBPixelFormat 32)            ;  32 bit argb    (Mac)

(defconstant $k1IndexedGrayPixelFormat 33)      ;  1 bit indexed gray

(defconstant $k2IndexedGrayPixelFormat 34)      ;  2 bit indexed gray

(defconstant $k4IndexedGrayPixelFormat 36)      ;  4 bit indexed gray

(defconstant $k8IndexedGrayPixelFormat 40)      ;  8 bit indexed gray

;  values for PixMap.pixelFormat

(defconstant $k16LE555PixelFormat :|L555|)      ;  16 bit LE rgb 555 (PC)

(defconstant $k16LE5551PixelFormat :|5551|)     ;  16 bit LE rgb 5551

(defconstant $k16BE565PixelFormat :|B565|)      ;  16 bit BE rgb 565

(defconstant $k16LE565PixelFormat :|L565|)      ;  16 bit LE rgb 565

(defconstant $k24BGRPixelFormat :|24BG|)        ;  24 bit bgr 

(defconstant $k32BGRAPixelFormat :|BGRA|)       ;  32 bit bgra    (Matrox)

(defconstant $k32ABGRPixelFormat :|ABGR|)       ;  32 bit abgr    

(defconstant $k32RGBAPixelFormat :|RGBA|)       ;  32 bit rgba    

(defconstant $kYUVSPixelFormat :|yuvs|)         ;  YUV 4:2:2 byte ordering 16-unsigned = 'YUY2'

(defconstant $kYUVUPixelFormat :|yuvu|)         ;  YUV 4:2:2 byte ordering 16-signed

(defconstant $kYVU9PixelFormat :|YVU9|)         ;  YVU9 Planar    9

(defconstant $kYUV411PixelFormat :|Y411|)       ;  YUV 4:1:1 Interleaved  16

(defconstant $kYVYU422PixelFormat :|YVYU|)      ;  YVYU 4:2:2 byte ordering   16

(defconstant $kUYVY422PixelFormat :|UYVY|)      ;  UYVY 4:2:2 byte ordering   16

(defconstant $kYUV211PixelFormat :|Y211|)       ;  YUV 2:1:1 Packed   8

(defconstant $k2vuyPixelFormat :|2vuy|)         ;  UYVY 4:2:2 byte ordering   16

(defrecord (PixMap :handle)
   (baseAddr :pointer)                          ; pointer to pixels
   (rowBytes :SInt16)                           ; offset to next line
   (bounds :Rect)                               ; encloses bitmap
   (pmVersion :SInt16)                          ; pixMap version number
   (packType :SInt16)                           ; defines packing format
   (packSize :signed-long)                      ; length of pixel data
   (hRes :signed-long)                          ; horiz. resolution (ppi)
   (vRes :signed-long)                          ; vert. resolution (ppi)
   (pixelType :SInt16)                          ; defines pixel type
   (pixelSize :SInt16)                          ; # bits in pixel
   (cmpCount :SInt16)                           ; # components in pixel
   (cmpSize :SInt16)                            ; # bits per component

; #if OLDPIXMAPSTRUCT
#| 
   (planeBytes :signed-long)                    ; offset to next plane
   (pmTable (:Handle :ColorTable))              ; color map for this pixMap
   (pmReserved :signed-long)
 |#

; #else
   (pixelFormat :OSType)                        ; fourCharCode representation
   (pmTable (:Handle :ColorTable))              ; color map for this pixMap
   (pmExt :pointer)                             ; Handle to pixMap extension

; #endif

)

;type name? (%define-record :PixMap (find-record-descriptor ':PixMap))

(def-mactype :PixMapPtr (find-mactype '(:pointer :PixMap)))

(def-mactype :PixMapHandle (find-mactype '(:handle :PixMap)))
(defrecord (PixPat :handle)
   (patType :SInt16)                            ; type of pattern
   (patMap (:Handle :PixMap))                   ; the pattern's pixMap
   (patData :Handle)                            ; pixmap's data
   (patXData :Handle)                           ; expanded Pattern data
   (patXValid :SInt16)                          ; flags whether expanded Pattern valid
   (patXMap :Handle)                            ; Handle to expanded Pattern data
   (pat1Data :Pattern)                          ; old-Style pattern/RGB color
)

;type name? (%define-record :PixPat (find-record-descriptor ':PixPat))

(def-mactype :PixPatPtr (find-mactype '(:pointer :PixPat)))

(def-mactype :PixPatHandle (find-mactype '(:handle :PixPat)))
(defrecord (CCrsr :handle)
   (crsrType :SInt16)                           ; type of cursor
   (crsrMap (:Handle :PixMap))                  ; the cursor's pixmap
   (crsrData :Handle)                           ; cursor's data
   (crsrXData :Handle)                          ; expanded cursor data
   (crsrXValid :SInt16)                         ; depth of expanded data (0 if none)
   (crsrXHandle :Handle)                        ; future use
   (crsr1Data :BITS16)                          ; one-bit cursor
   (crsrMask :BITS16)                           ; cursor's mask
   (crsrHotSpot :Point)                         ; cursor's hotspot
   (crsrXTable :signed-long)                    ; private
   (crsrID :signed-long)                        ; private
)

;type name? (%define-record :CCrsr (find-record-descriptor ':CCrsr))

(def-mactype :CCrsrPtr (find-mactype '(:pointer :CCrsr)))

(def-mactype :CCrsrHandle (find-mactype '(:handle :CCrsr)))
(defrecord (GammaTbl :handle)
   (gVersion :SInt16)                           ; gamma version number
   (gType :SInt16)                              ; gamma data type
   (gFormulaSize :SInt16)                       ; Formula data size
   (gChanCnt :SInt16)                           ; number of channels of data
   (gDataCnt :SInt16)                           ; number of values/channel
   (gDataWidth :SInt16)                         ; bits/corrected value (data packed to next larger byte size)
   (gFormulaData (:array :SInt16 1))            ; data for formulas followed by gamma values
)

;type name? (%define-record :GammaTbl (find-record-descriptor ':GammaTbl))

(def-mactype :GammaTblPtr (find-mactype '(:pointer :GammaTbl)))

(def-mactype :GammaTblHandle (find-mactype '(:handle :GammaTbl)))
(defrecord (ITab :handle)
   (iTabSeed :signed-long)                      ; copy of CTSeed from source CTable
   (iTabRes :SInt16)                            ; bits/channel resolution of iTable
   (iTTable (:array :unsigned-byte 1))          ; byte colortable index values
)

;type name? (%define-record :ITab (find-record-descriptor ':ITab))

(def-mactype :ITabPtr (find-mactype '(:pointer :ITab)))

(def-mactype :ITabHandle (find-mactype '(:handle :ITab)))
(defrecord (SProcRec :handle)
   (nxtSrch :Handle)                            ; SProcHndl Handle to next SProcRec
   (srchProc (:pointer :OpaqueColorSearchProcPtr)); search procedure proc ptr
)

;type name? (%define-record :SProcRec (find-record-descriptor ':SProcRec))

(def-mactype :SProcPtr (find-mactype '(:pointer :SProcRec)))

(def-mactype :SProcHndl (find-mactype '(:handle :SProcRec)))
(defrecord (CProcRec :handle)
   (nxtComp :Handle)                            ; CProcHndl Handle to next CProcRec
   (compProc (:pointer :OpaqueColorComplementProcPtr)); complement procedure proc ptr
)

;type name? (%define-record :CProcRec (find-record-descriptor ':CProcRec))

(def-mactype :CProcPtr (find-mactype '(:pointer :CProcRec)))

(def-mactype :CProcHndl (find-mactype '(:handle :CProcRec)))
; 
;     QuickTime 3.0 makes GDevice data structure available on non-Mac OS's.
;     In order to implement GDevice in these alternate environments, the GDevice
;     had to be extended. The gdReserved field was changed to gdExt which is
;     a Handle to extra info.  
; 
; #ifndef OLDGDEVICESTRUCT

; #if TARGET_API_MAC_OS8
#| 
; #define OLDGDEVICESTRUCT 1
 |#

; #else
(defconstant $OLDGDEVICESTRUCT 0)
; #define OLDGDEVICESTRUCT 0

; #endif  /* TARGET_API_MAC_OS8 */


; #endif  /* !defined(OLDGDEVICESTRUCT) */


;type name? (def-mactype :GDevice (find-mactype ':GDevice))

(def-mactype :GDPtr (find-mactype '(:pointer :GDevice)))

(def-mactype :GDHandle (find-mactype '(:handle :GDevice)))
(defrecord (GDevice :handle)
   (gdRefNum :SInt16)                           ; driver's unit number
   (gdID :SInt16)                               ; client ID for search procs
   (gdType :SInt16)                             ; fixed/CLUT/direct
   (gdITable (:Handle :ITab))                   ; Handle to inverse lookup table
   (gdResPref :SInt16)                          ; preferred resolution of GDITable
   (gdSearchProc (:Handle :SProcRec))           ; search proc list head
   (gdCompProc (:Handle :CProcRec))             ; complement proc list
   (gdFlags :SInt16)                            ; grafDevice flags word
   (gdPMap (:Handle :PixMap))                   ; describing pixMap
   (gdRefCon :signed-long)                      ; reference value
   (gdNextGD (:Handle :GDevice))                ; GDHandle Handle of next gDevice
   (gdRect :Rect)                               ;  device's bounds in global coordinates
   (gdMode :signed-long)                        ; device's current mode
   (gdCCBytes :SInt16)                          ; depth of expanded cursor data
   (gdCCDepth :SInt16)                          ; depth of expanded cursor data
   (gdCCXData :Handle)                          ; Handle to cursor's expanded data
   (gdCCXMask :Handle)                          ; Handle to cursor's expanded mask

; #if OLDGDEVICESTRUCT
#| 
   (gdReserved :signed-long)                    ; future use. MUST BE 0
 |#

; #else
   (gdExt :Handle)                              ; QuickTime 3.0 private info

; #endif

)
(defrecord (GrafVars :handle)
   (rgbOpColor :RGBColor)                       ; color for addPin  subPin and average
   (rgbHiliteColor :RGBColor)                   ; color for hiliting
   (pmFgColor :Handle)                          ; palette Handle for foreground color
   (pmFgIndex :SInt16)                          ; index value for foreground
   (pmBkColor :Handle)                          ; palette Handle for background color
   (pmBkIndex :SInt16)                          ; index value for background
   (pmFlags :SInt16)                            ; flags for Palette Manager
)

;type name? (%define-record :GrafVars (find-record-descriptor ':GrafVars))

(def-mactype :GVarPtr (find-mactype '(:pointer :GrafVars)))

(def-mactype :GVarHandle (find-mactype '(:handle :GrafVars)))

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
;type name? (def-mactype :CGrafPort (find-mactype ':CGrafPort))

(def-mactype :CGrafPtr (find-mactype '(:pointer :CGrafPort)))
 |#

; #else

(def-mactype :CGrafPtr (find-mactype ':GrafPtr))

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */


(def-mactype :QDPrinterStatusProcPtr (find-mactype ':pointer)); (PrinterStatusOpcode opcode , CGrafPtr currentPort , void * printerStatus)

(def-mactype :QDPrinterStatusUPP (find-mactype '(:pointer :OpaqueQDPrinterStatusProcPtr)))
(defrecord CQDProcs
   (textProc (:pointer :OpaqueQDTextProcPtr))
   (lineProc (:pointer :OpaqueQDLineProcPtr))
   (rectProc (:pointer :OpaqueQDRectProcPtr))
   (rRectProc (:pointer :OpaqueQDRRectProcPtr))
   (ovalProc (:pointer :OpaqueQDOvalProcPtr))
   (arcProc (:pointer :OpaqueQDArcProcPtr))
   (polyProc (:pointer :OpaqueQDPolyProcPtr))
   (rgnProc (:pointer :OpaqueQDRgnProcPtr))
   (bitsProc (:pointer :OpaqueQDBitsProcPtr))
   (commentProc (:pointer :OpaqueQDCommentProcPtr))
   (txMeasProc (:pointer :OpaqueQDTxMeasProcPtr))
   (getPicProc (:pointer :OpaqueQDGetPicProcPtr))
   (putPicProc (:pointer :OpaqueQDPutPicProcPtr))
   (opcodeProc (:pointer :OpaqueQDOpcodeProcPtr))
   (newProc1 (:pointer :RoutineDescriptor))     ;  this is the StdPix bottleneck -- see ImageCompression.h 
   (glyphsProc (:pointer :OpaqueQDStdGlyphsProcPtr));  unused on Mac OS X 
   (printerStatusProc (:pointer :OpaqueQDPrinterStatusProcPtr));  was newProc3;  now used to communicate status between Printing code and System imaging code 
   (newProc4 (:pointer :RoutineDescriptor))
   (newProc5 (:pointer :RoutineDescriptor))
   (newProc6 (:pointer :RoutineDescriptor))
)

;type name? (%define-record :CQDProcs (find-record-descriptor ':CQDProcs))

(def-mactype :CQDProcsPtr (find-mactype '(:pointer :CQDProcs)))

; #if !OPAQUE_TOOLBOX_STRUCTS
#| 
(defrecord CGrafPort
   (device :SInt16)                             ;  not available in Carbon
   (portPixMap (:Handle :PixMap))               ;  in Carbon use GetPortPixMap
   (portVersion :SInt16)                        ;  in Carbon use IsPortColor
   (grafVars :Handle)                           ;  not available in Carbon
   (chExtra :SInt16)                            ;  in Carbon use GetPortChExtra
   (pnLocHFrac :SInt16)                         ;  in Carbon use Get/SetPortFracHPenLocation
   (portRect :Rect)                             ;  in Carbon use Get/SetPortBounds
   (visRgn (:pointer :OpaqueRgnHandle))         ;  in Carbon use Get/SetPortVisibleRegion
   (clipRgn (:pointer :OpaqueRgnHandle))        ;  in Carbon use Get/SetPortClipRegion
   (bkPixPat (:Handle :PixPat))                 ;  in Carbon use GetPortBackPixPat or BackPixPat
   (rgbFgColor :RGBColor)                       ;  in Carbon use GetPortForeColor or RGBForeColor
   (rgbBkColor :RGBColor)                       ;  in Carbon use GetPortBackColor or RGBBackColor
   (pnLoc :Point)                               ;  in Carbon use GetPortPenLocation or MoveTo
   (pnSize :Point)                              ;  in Carbon use Get/SetPortPenSize
   (pnMode :SInt16)                             ;  in Carbon use Get/SetPortPenMode
   (pnPixPat (:Handle :PixPat))                 ;  in Carbon use Get/SetPortPenPixPat
   (fillPixPat (:Handle :PixPat))               ;  in Carbon use GetPortFillPixPat
   (pnVis :SInt16)                              ;  in Carbon use GetPortPenVisibility or Show/HidePen
   (txFont :SInt16)                             ;  in Carbon use GetPortTextFont or TextFont
   (txFace :UInt8)                              ;  in Carbon use GetPortTextFace or TextFace
                                                ; StyleField occupies 16-bits, but only first 8-bits are used
   (txMode :SInt16)                             ;  in Carbon use GetPortTextMode or TextMode
   (txSize :SInt16)                             ;  in Carbon use GetPortTextSize or TextSize
   (spExtra :signed-long)                       ;  in Carbon use GetPortSpExtra or SpaceExtra
   (fgColor :signed-long)                       ;  not available in Carbon
   (bkColor :signed-long)                       ;  not available in Carbon
   (colrBit :SInt16)                            ;  not available in Carbon
   (patStretch :SInt16)                         ;  not available in Carbon
   (picSave :Handle)                            ;  in Carbon use IsPortPictureBeingDefined
   (rgnSave :Handle)                            ;  in Carbon use IsPortRegionBeingDefined
   (polySave :Handle)                           ;  in Carbon use IsPortPolyBeingDefined
   (grafProcs (:pointer :CQDProcs))             ;  in Carbon use Get/SetPortGrafProcs
)
 |#

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS */


; #if OPAQUE_TOOLBOX_STRUCTS

(def-mactype :CWindowPtr (find-mactype ':WindowPtr))
#| 
; #else

(def-mactype :CWindowPtr (find-mactype ':CGrafPtr))
 |#

; #endif  /* OPAQUE_TOOLBOX_STRUCTS */

(defrecord ReqListRec
   (reqLSize :SInt16)                           ; request list size
   (reqLData (:array :SInt16 1))                ; request list data
)

;type name? (%define-record :ReqListRec (find-record-descriptor ':ReqListRec))
(defrecord OpenCPicParams
   (srcRect :Rect)
   (hRes :signed-long)
   (vRes :signed-long)
   (version :SInt16)
   (reserved1 :SInt16)
   (reserved2 :signed-long)
)

;type name? (%define-record :OpenCPicParams (find-record-descriptor ':OpenCPicParams))

(defconstant $kCursorImageMajorVersion 1)
(defconstant $kCursorImageMinorVersion 0)
(defrecord CursorImageRec
   (majorVersion :UInt16)
   (minorVersion :UInt16)
   (cursorPixMap (:Handle :PixMap))
   (cursorBitMask (:Handle :BitMap))
)

;type name? (%define-record :CursorImageRec (find-record-descriptor ':CursorImageRec))

(def-mactype :CursorImagePtr (find-mactype '(:pointer :CursorImageRec)))

(def-mactype :DeviceLoopDrawingProcPtr (find-mactype ':pointer)); (short depth , short deviceFlags , GDHandle targetDevice , long userData)

(def-mactype :DeviceLoopDrawingUPP (find-mactype '(:pointer :OpaqueDeviceLoopDrawingProcPtr)))
; 
;  *  NewQDPrinterStatusUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  NewDeviceLoopDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDeviceLoopDrawingUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDeviceLoopDrawingProcPtr)
() )
; 
;  *  DisposeQDPrinterStatusUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposeDeviceLoopDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDeviceLoopDrawingUPP" 
   ((userUPP (:pointer :OpaqueDeviceLoopDrawingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeQDPrinterStatusUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokeDeviceLoopDrawingUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDeviceLoopDrawingUPP" 
   ((depth :SInt16)
    (deviceFlags :SInt16)
    (targetDevice (:Handle :GDEVICE))
    (userData :signed-long)
    (userUPP (:pointer :OpaqueDeviceLoopDrawingProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )

; #if !OPAQUE_TOOLBOX_STRUCTS || !TARGET_API_MAC_CARBON
#| 
(defrecord QDGlobals
   (privates (:array :character 76))
   (randSeed :signed-long)                      ;  in Carbon use GetQDGlobalsRandomSeed
   (screenBits :BitMap)                         ;  in Carbon use GetQDGlobalsScreenBits
   (arrow :Cursor)                              ;  in Carbon use GetQDGlobalsArrow
   (dkGray :Pattern)                            ;  in Carbon use GetQDGlobalsDarkGray
   (ltGray :Pattern)                            ;  in Carbon use GetQDGlobalsLightGray
   (gray :Pattern)                              ;  in Carbon use GetQDGlobalsGray
   (black :Pattern)                             ;  in Carbon use GetQDGlobalsBlack
   (white :Pattern)                             ;  in Carbon use GetQDGlobalsWhite
   (thePort (:pointer :OpaqueGrafPtr))          ;  in Carbon use GetQDGlobalsThePort
)

;type name? (def-mactype :QDGlobals (find-mactype ':QDGlobals))

(def-mactype :QDGlobalsPtr (find-mactype '(:pointer :QDGlobals)))

(def-mactype :QDGlobalsHdl (find-mactype '(:pointer :QDGlobalsPtr)))
(def-mactype :qd (find-mactype ':QDGlobals))
 |#

; #endif  /* !OPAQUE_TOOLBOX_STRUCTS || !TARGET_API_MAC_CARBON */

; 
;  *  InitGraf()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  OpenPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  InitPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  ClosePort()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;     General comments about thread-safety of Quickdraw
;     -------------------------------------------------
;     
;     The original design and implementation principles of Quickdraw seriously
;     conflict with the goal of making Quickdraw thread-safe. Many Quickdraw
;     functions rely on globals instead of explicit parameters. Even though the 
;     current port (and the current GDevice) are being maintained per-thread,
;     a simple call like "MoveTo(x, y)" just doesn't make sense with preemptive threads,
;     if two different threads use the same port. More serious obstacles are hiding
;     in picture recording and drawing, or region and polygon recording, or in the
;     presence of custom grafProcs bottleneck procedures. Finally, the global QDError
;     cannot be maintained per thread, because its pervasive access would cause intolerable
;     performance penalties.
;     Currently, nearly all Quickdraw API calls are marked thread-unsafe, even those that
;     seem to work reliably in pthreads, with some plausible precautions. (Note that
;     the absence of crashes in test runs does not guarantee thread-safety!).
;     As the work on making portions of Quickdraw thread-safe progresses, the thread-safe
;     attributes will be updated. 
; 
; 
; 
;    These are Carbon only routines. They do nothing at all on
;    Mac OS 9, but work flawlessly on Mac OS X.
; 
; 
;  *  LockPortBits()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LockPortBits" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  UnlockPortBits()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_UnlockPortBits" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Break a region up into rectangles.

(defconstant $kQDParseRegionFromTop 1)
(defconstant $kQDParseRegionFromBottom 2)
(defconstant $kQDParseRegionFromLeft 4)
(defconstant $kQDParseRegionFromRight 8)
(defconstant $kQDParseRegionFromTopLeft 5)
(defconstant $kQDParseRegionFromBottomRight 10)

(def-mactype :QDRegionParseDirection (find-mactype ':SInt32))

(defconstant $kQDRegionToRectsMsgInit 1)
(defconstant $kQDRegionToRectsMsgParse 2)
(defconstant $kQDRegionToRectsMsgTerminate 3)

(def-mactype :RegionToRectsProcPtr (find-mactype ':pointer)); (UInt16 message , RgnHandle rgn , const Rect * rect , void * refCon)

(def-mactype :RegionToRectsUPP (find-mactype '(:pointer :OpaqueRegionToRectsProcPtr)))
; 
;  *  NewRegionToRectsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewRegionToRectsUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRegionToRectsProcPtr)
() )
; 
;  *  DisposeRegionToRectsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeRegionToRectsUPP" 
   ((userUPP (:pointer :OpaqueRegionToRectsProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeRegionToRectsUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeRegionToRectsUPP" 
   ((message :UInt16)
    (rgn (:pointer :OpaqueRgnHandle))
    (rect (:pointer :Rect))
    (refCon :pointer)
    (userUPP (:pointer :OpaqueRegionToRectsProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  QDRegionToRects()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDRegionToRects" 
   ((rgn (:pointer :OpaqueRgnHandle))
    (dir :SInt32)
    (proc (:pointer :OpaqueRegionToRectsProcPtr))
    (userData :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )

; #if TARGET_OS_WIN32
#| 
; 
;  *  GetPortHWND()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  GetHWNDPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; #define GetPortHWND(port)  (HWND)GetPortNativeWindow(port)
; #define GetHWNDPort(theHWND) GetNativeWindowPort(theHWND)
; 
;  *  GetPortHDC()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  GetPortHBITMAP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  GetPortHPALETTE()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  GetPortHFONT()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  GetDIBFromPICT()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  GetPICTFromDIB()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
 |#

; #endif  /* TARGET_OS_WIN32 */

; 
;  *  [Mac]SetPort()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacSetPort SetPort

; #endif


(deftrap-inline "_SetPort" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetPort()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetPort" 
   ((port (:pointer :GrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  QDSwapPort()
;  *  
;  *  Summary:
;  *    Combines a GetPort(&savePort); SetPort(newPort) sequence.
;  *  
;  *  Discussion:
;  *    On X, the GetPort/SetPort calls act on per-thread globals, and
;  *    cost more processor cycles than in the past, where they were
;  *    simple memory accessors. To optimize, use the QDSwapPort call
;  *    which combines both, and returns a Boolean indicating if the port
;  *    actually did change. Typical usage: portChanged =
;  *    QDSwapPort(newPort, &savePort); // some drawing into newPort if
;  *    (portChanged) QDSwapPort(savePort, NULL);
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inNewPort:
;  *      The new port to be set.
;  *    
;  *    outOldPort:
;  *      Receives the previous port. Can be NULL.
;  *  
;  *  Result:
;  *    A Boolean indicating whether the port was changed, i.e.
;  *    (inNewPort != *outOldPort)
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDSwapPort" 
   ((inNewPort (:pointer :OpaqueGrafPtr))
    (outOldPort (:pointer :CGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Boolean
() )
; 
;  *  GrafDevice()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GrafDevice" 
   ((device :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPortBits()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetPortBits" 
   ((bm (:pointer :BitMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PortSize()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PortSize" 
   ((width :SInt16)
    (height :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MovePortTo()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MovePortTo" 
   ((leftGlobal :SInt16)
    (topGlobal :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetOrigin()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetOrigin" 
   ((h :SInt16)
    (v :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetClip()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetClip" 
   ((rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetClip()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetClip" 
   ((rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ClipRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ClipRect" 
   ((r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  BackPat()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_BackPat" 
   ((pat (:pointer :Pattern))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InitCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InitCursor" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]SetCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacSetCursor SetCursor

; #endif


(deftrap-inline "_SetCursor" 
   ((crsr (:pointer :Cursor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HideCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HideCursor" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]ShowCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacShowCursor ShowCursor

; #endif


(deftrap-inline "_ShowCursor" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ObscureCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ObscureCursor" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HidePen()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HidePen" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ShowPen()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ShowPen" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetPen()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetPen" 
   ((pt (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetPenState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetPenState" 
   ((pnState (:pointer :PenState))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPenState()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetPenState" 
   ((pnState (:pointer :PenState))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PenSize()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PenSize" 
   ((width :SInt16)
    (height :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PenMode()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PenMode" 
   ((mode :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PenPat()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PenPat" 
   ((pat (:pointer :Pattern))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PenNormal()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PenNormal" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MoveTo()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MoveTo" 
   ((h :SInt16)
    (v :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  Move()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Move" 
   ((dh :SInt16)
    (dv :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]LineTo()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacLineTo LineTo

; #endif


(deftrap-inline "_LineTo" 
   ((h :SInt16)
    (v :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  Line()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Line" 
   ((dh :SInt16)
    (dv :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ForeColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ForeColor" 
   ((color :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  BackColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_BackColor" 
   ((color :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ColorBit()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ColorBit" 
   ((whichBit :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]SetRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacSetRect SetRect

; #endif


(deftrap-inline "_SetRect" 
   ((r (:pointer :Rect))
    (left :SInt16)
    (top :SInt16)
    (right :SInt16)
    (bottom :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]OffsetRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacOffsetRect OffsetRect

; #endif


(deftrap-inline "_OffsetRect" 
   ((r (:pointer :Rect))
    (dh :SInt16)
    (dv :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]InsetRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacInsetRect InsetRect

; #endif


(deftrap-inline "_InsetRect" 
   ((r (:pointer :Rect))
    (dh :SInt16)
    (dv :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SectRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SectRect" 
   ((src1 (:pointer :Rect))
    (src2 (:pointer :Rect))
    (dstRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  [Mac]UnionRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacUnionRect UnionRect

; #endif


(deftrap-inline "_UnionRect" 
   ((src1 (:pointer :Rect))
    (src2 (:pointer :Rect))
    (dstRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]EqualRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacEqualRect EqualRect

; #endif


(deftrap-inline "_EqualRect" 
   ((rect1 (:pointer :Rect))
    (rect2 (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  EmptyRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_EmptyRect" 
   ((r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  [Mac]FrameRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacFrameRect FrameRect

; #endif


(deftrap-inline "_FrameRect" 
   ((r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PaintRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PaintRect" 
   ((r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  EraseRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_EraseRect" 
   ((r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]InvertRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacInvertRect InvertRect

; #endif


(deftrap-inline "_InvertRect" 
   ((r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]FillRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacFillRect FillRect

; #endif


(deftrap-inline "_FillRect" 
   ((r (:pointer :Rect))
    (pat (:pointer :Pattern))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FrameOval()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FrameOval" 
   ((r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PaintOval()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PaintOval" 
   ((r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  EraseOval()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_EraseOval" 
   ((r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvertOval()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InvertOval" 
   ((r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FillOval()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FillOval" 
   ((r (:pointer :Rect))
    (pat (:pointer :Pattern))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FrameRoundRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FrameRoundRect" 
   ((r (:pointer :Rect))
    (ovalWidth :SInt16)
    (ovalHeight :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PaintRoundRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PaintRoundRect" 
   ((r (:pointer :Rect))
    (ovalWidth :SInt16)
    (ovalHeight :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  EraseRoundRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_EraseRoundRect" 
   ((r (:pointer :Rect))
    (ovalWidth :SInt16)
    (ovalHeight :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvertRoundRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InvertRoundRect" 
   ((r (:pointer :Rect))
    (ovalWidth :SInt16)
    (ovalHeight :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FillRoundRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FillRoundRect" 
   ((r (:pointer :Rect))
    (ovalWidth :SInt16)
    (ovalHeight :SInt16)
    (pat (:pointer :Pattern))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FrameArc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FrameArc" 
   ((r (:pointer :Rect))
    (startAngle :SInt16)
    (arcAngle :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PaintArc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PaintArc" 
   ((r (:pointer :Rect))
    (startAngle :SInt16)
    (arcAngle :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  EraseArc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_EraseArc" 
   ((r (:pointer :Rect))
    (startAngle :SInt16)
    (arcAngle :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvertArc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InvertArc" 
   ((r (:pointer :Rect))
    (startAngle :SInt16)
    (arcAngle :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FillArc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FillArc" 
   ((r (:pointer :Rect))
    (startAngle :SInt16)
    (arcAngle :SInt16)
    (pat (:pointer :Pattern))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NewRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewRgn" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; 
;  *  OpenRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_OpenRgn" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CloseRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CloseRgn" 
   ((dstRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  BitMapToRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_BitMapToRegion" 
   ((region (:pointer :OpaqueRgnHandle))
    (bMap (:pointer :BitMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  HandleToRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_HandleToRgn" 
   ((oldRegion :Handle)
    (region (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RgnToHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_RgnToHandle" 
   ((region (:pointer :OpaqueRgnHandle))
    (flattenedRgnDataHdl :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  DisposeRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposeRgn" 
   ((rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]CopyRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacCopyRgn CopyRgn

; #endif


(deftrap-inline "_CopyRgn" 
   ((srcRgn (:pointer :OpaqueRgnHandle))
    (dstRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetEmptyRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetEmptyRgn" 
   ((rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]SetRectRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacSetRectRgn SetRectRgn

; #endif


(deftrap-inline "_SetRectRgn" 
   ((rgn (:pointer :OpaqueRgnHandle))
    (left :SInt16)
    (top :SInt16)
    (right :SInt16)
    (bottom :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RectRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RectRgn" 
   ((rgn (:pointer :OpaqueRgnHandle))
    (r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]OffsetRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacOffsetRgn OffsetRgn

; #endif


(deftrap-inline "_OffsetRgn" 
   ((rgn (:pointer :OpaqueRgnHandle))
    (dh :SInt16)
    (dv :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InsetRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InsetRgn" 
   ((rgn (:pointer :OpaqueRgnHandle))
    (dh :SInt16)
    (dv :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SectRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SectRgn" 
   ((srcRgnA (:pointer :OpaqueRgnHandle))
    (srcRgnB (:pointer :OpaqueRgnHandle))
    (dstRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]UnionRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacUnionRgn UnionRgn

; #endif


(deftrap-inline "_UnionRgn" 
   ((srcRgnA (:pointer :OpaqueRgnHandle))
    (srcRgnB (:pointer :OpaqueRgnHandle))
    (dstRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DiffRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DiffRgn" 
   ((srcRgnA (:pointer :OpaqueRgnHandle))
    (srcRgnB (:pointer :OpaqueRgnHandle))
    (dstRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]XorRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacXorRgn XorRgn

; #endif


(deftrap-inline "_XorRgn" 
   ((srcRgnA (:pointer :OpaqueRgnHandle))
    (srcRgnB (:pointer :OpaqueRgnHandle))
    (dstRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RectInRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RectInRgn" 
   ((r (:pointer :Rect))
    (rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  [Mac]EqualRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacEqualRgn EqualRgn

; #endif


(deftrap-inline "_EqualRgn" 
   ((rgnA (:pointer :OpaqueRgnHandle))
    (rgnB (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  EmptyRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_EmptyRgn" 
   ((rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  [Mac]FrameRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacFrameRgn FrameRgn

; #endif


(deftrap-inline "_FrameRgn" 
   ((rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]PaintRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacPaintRgn PaintRgn

; #endif


(deftrap-inline "_PaintRgn" 
   ((rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  EraseRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_EraseRgn" 
   ((rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]InvertRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacInvertRgn InvertRgn

; #endif


(deftrap-inline "_InvertRgn" 
   ((rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]FillRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacFillRgn FillRgn

; #endif


(deftrap-inline "_FillRgn" 
   ((rgn (:pointer :OpaqueRgnHandle))
    (pat (:pointer :Pattern))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ScrollRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ScrollRect" 
   ((r (:pointer :Rect))
    (dh :SInt16)
    (dv :SInt16)
    (updateRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CopyBits()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CopyBits" 
   ((srcBits (:pointer :BitMap))
    (dstBits (:pointer :BitMap))
    (srcRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
    (mode :SInt16)
    (maskRgn (:pointer :OpaqueRgnHandle))       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SeedFill()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SeedFill" 
   ((srcPtr :pointer)
    (dstPtr :pointer)
    (srcRow :SInt16)
    (dstRow :SInt16)
    (height :SInt16)
    (words :SInt16)
    (seedH :SInt16)
    (seedV :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CalcMask()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CalcMask" 
   ((srcPtr :pointer)
    (dstPtr :pointer)
    (srcRow :SInt16)
    (dstRow :SInt16)
    (height :SInt16)
    (words :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CopyMask()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CopyMask" 
   ((srcBits (:pointer :BitMap))
    (maskBits (:pointer :BitMap))
    (dstBits (:pointer :BitMap))
    (srcRect (:pointer :Rect))
    (maskRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OpenPicture()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_OpenPicture" 
   ((picFrame (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :Picture)
() )
; 
;  *  PicComment()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PicComment" 
   ((kind :SInt16)
    (dataSize :SInt16)
    (dataHandle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ClosePicture()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ClosePicture" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  QDGetPictureBounds()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDGetPictureBounds" 
   ((picH (:Handle :Picture))
    (outRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :Rect)
() )
; 
;  *  DrawPicture()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DrawPicture" 
   ((myPicture (:Handle :Picture))
    (dstRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  KillPicture()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_KillPicture" 
   ((myPicture (:Handle :Picture))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OpenPoly()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_OpenPoly" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :MacPolygon)
() )
; 
;  *  ClosePoly()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ClosePoly" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  KillPoly()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_KillPoly" 
   ((poly (:Handle :MacPolygon))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OffsetPoly()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_OffsetPoly" 
   ((poly (:Handle :MacPolygon))
    (dh :SInt16)
    (dv :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FramePoly()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FramePoly" 
   ((poly (:Handle :MacPolygon))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PaintPoly()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PaintPoly" 
   ((poly (:Handle :MacPolygon))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ErasePoly()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ErasePoly" 
   ((poly (:Handle :MacPolygon))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvertPoly()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InvertPoly" 
   ((poly (:Handle :MacPolygon))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FillPoly()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FillPoly" 
   ((poly (:Handle :MacPolygon))
    (pat (:pointer :Pattern))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPt()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetPt" 
   ((pt (:pointer :Point))
    (h :SInt16)
    (v :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LocalToGlobal()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LocalToGlobal" 
   ((pt (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GlobalToLocal()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GlobalToLocal" 
   ((pt (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  Random()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Random" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  StuffHex()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StuffHex" 
   ((thingPtr :pointer)
    (s (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  [Mac]GetPixel()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacGetPixel GetPixel

; #endif


(deftrap-inline "_GetPixel" 
   ((h :SInt16)
    (v :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  ScalePt()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ScalePt" 
   ((pt (:pointer :Point))
    (srcRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MapPt()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MapPt" 
   ((pt (:pointer :Point))
    (srcRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MapRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MapRect" 
   ((r (:pointer :Rect))
    (srcRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MapRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MapRgn" 
   ((rgn (:pointer :OpaqueRgnHandle))
    (srcRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MapPoly()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MapPoly" 
   ((poly (:Handle :MacPolygon))
    (srcRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetStdProcs()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetStdProcs" 
   ((procs (:pointer :QDProcs))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StdRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StdRect" 
   ((verb :SInt8)
    (r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StdRRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StdRRect" 
   ((verb :SInt8)
    (r (:pointer :Rect))
    (ovalWidth :SInt16)
    (ovalHeight :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StdOval()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StdOval" 
   ((verb :SInt8)
    (r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StdArc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StdArc" 
   ((verb :SInt8)
    (r (:pointer :Rect))
    (startAngle :SInt16)
    (arcAngle :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StdPoly()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StdPoly" 
   ((verb :SInt8)
    (poly (:Handle :MacPolygon))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StdRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StdRgn" 
   ((verb :SInt8)
    (rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StdBits()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StdBits" 
   ((srcBits (:pointer :BitMap))
    (srcRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
    (mode :SInt16)
    (maskRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StdComment()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StdComment" 
   ((kind :SInt16)
    (dataSize :SInt16)
    (dataHandle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StdGetPic()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StdGetPic" 
   ((dataPtr :pointer)
    (byteCount :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StdPutPic()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StdPutPic" 
   ((dataPtr :pointer)
    (byteCount :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StdOpcode()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_StdOpcode" 
   ((fromRect (:pointer :Rect))
    (toRect (:pointer :Rect))
    (opcode :UInt16)
    (version :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AddPt()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AddPt" 
   ((src :Point)
    (dst (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  EqualPt()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_EqualPt" 
   ((pt1 :Point)
    (pt2 :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  [Mac]PtInRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacPtInRect PtInRect

; #endif


(deftrap-inline "_PtInRect" 
   ((pt :Point)
    (r (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  Pt2Rect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Pt2Rect" 
   ((pt1 :Point)
    (pt2 :Point)
    (dstRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PtToAngle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PtToAngle" 
   ((r (:pointer :Rect))
    (pt :Point)
    (angle (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SubPt()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SubPt" 
   ((src :Point)
    (dst (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PtInRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PtInRgn" 
   ((pt :Point)
    (rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  StdLine()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StdLine" 
   ((newPt :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OpenCPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  InitCPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  CloseCPort()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  NewPixMap()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewPixMap" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :PixMap)
() )
; 
;  *  DisposePixMap()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposePixMap" 
   ((pm (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CopyPixMap()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CopyPixMap" 
   ((srcPM (:Handle :PixMap))
    (dstPM (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NewPixPat()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewPixPat" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :PixPat)
() )
; 
;  *  DisposePixPat()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposePixPat" 
   ((pp (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CopyPixPat()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CopyPixPat" 
   ((srcPP (:Handle :PixPat))
    (dstPP (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  PenPixPat()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PenPixPat" 
   ((pp (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  BackPixPat()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_BackPixPat" 
   ((pp (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetPixPat()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetPixPat" 
   ((patID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :PixPat)
() )
; 
;  *  MakeRGBPat()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MakeRGBPat" 
   ((pp (:Handle :PixPat))
    (myColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FillCRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FillCRect" 
   ((r (:pointer :Rect))
    (pp (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FillCOval()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FillCOval" 
   ((r (:pointer :Rect))
    (pp (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FillCRoundRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FillCRoundRect" 
   ((r (:pointer :Rect))
    (ovalWidth :SInt16)
    (ovalHeight :SInt16)
    (pp (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FillCArc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FillCArc" 
   ((r (:pointer :Rect))
    (startAngle :SInt16)
    (arcAngle :SInt16)
    (pp (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FillCRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FillCRgn" 
   ((rgn (:pointer :OpaqueRgnHandle))
    (pp (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FillCPoly()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FillCPoly" 
   ((poly (:Handle :MacPolygon))
    (pp (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RGBForeColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RGBForeColor" 
   ((color (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RGBBackColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RGBBackColor" 
   ((color (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetCPixel()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetCPixel" 
   ((h :SInt16)
    (v :SInt16)
    (cPix (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPortPix()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetPortPix" 
   ((pm (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetCPixel()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetCPixel" 
   ((h :SInt16)
    (v :SInt16)
    (cPix (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetForeColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetForeColor" 
   ((color (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetBackColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetBackColor" 
   ((color (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SeedCFill()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SeedCFill" 
   ((srcBits (:pointer :BitMap))
    (dstBits (:pointer :BitMap))
    (srcRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
    (seedH :SInt16)
    (seedV :SInt16)
    (matchProc (:pointer :OpaqueColorSearchProcPtr))
    (matchData :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CalcCMask()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CalcCMask" 
   ((srcBits (:pointer :BitMap))
    (dstBits (:pointer :BitMap))
    (srcRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
    (seedRGB (:pointer :RGBColor))
    (matchProc (:pointer :OpaqueColorSearchProcPtr))
    (matchData :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  OpenCPicture()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_OpenCPicture" 
   ((newHeader (:pointer :OpenCPicParams))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :Picture)
() )
; 
;  *  OpColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_OpColor" 
   ((color (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  HiliteColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_HiliteColor" 
   ((color (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCTable()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposeCTable" 
   ((cTable (:Handle :ColorTable))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetCTable()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetCTable" 
   ((ctID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :ColorTable)
() )
; 
;  *  GetCCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetCCursor" 
   ((crsrID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :CCrsr)
() )
; 
;  *  SetCCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetCCursor" 
   ((cCrsr (:Handle :CCrsr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AllocCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AllocCursor" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposeCCursor" 
   ((cCrsr (:Handle :CCrsr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  GetCIcon(), PlotCIcon(), and DisposeCIcon() moved to Icons.h
; 
;  *  SetStdCProcs()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetStdCProcs" 
   ((procs (:pointer :CQDProcs))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMaxDevice()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetMaxDevice" 
   ((globalRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :GDEVICE)
() )
; 
;  *  GetCTSeed()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetCTSeed" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetDeviceList()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetDeviceList" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :GDEVICE)
() )
; 
;  *  GetMainDevice()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetMainDevice" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :GDEVICE)
() )
; 
;  *  GetNextDevice()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetNextDevice" 
   ((curDevice (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :GDEVICE)
() )
; 
;  *  TestDeviceAttribute()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TestDeviceAttribute" 
   ((gdh (:Handle :GDEVICE))
    (attribute :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  SetDeviceAttribute()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetDeviceAttribute" 
   ((gdh (:Handle :GDEVICE))
    (attribute :SInt16)
    (value :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InitGDevice()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InitGDevice" 
   ((qdRefNum :SInt16)
    (mode :signed-long)
    (gdh (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NewGDevice()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewGDevice" 
   ((refNum :SInt16)
    (mode :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :GDEVICE)
() )
; 
;  *  DisposeGDevice()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DisposeGDevice" 
   ((gdh (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetGDevice()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetGDevice" 
   ((gd (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetGDevice()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetGDevice" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :GDEVICE)
() )
; 
;  *  Color2Index()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Color2Index" 
   ((myColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  Index2Color()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Index2Color" 
   ((index :signed-long)
    (aColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvertColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_InvertColor" 
   ((myColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RealColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RealColor" 
   ((color (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  GetSubTable()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetSubTable" 
   ((myColors (:Handle :ColorTable))
    (iTabRes :SInt16)
    (targetTbl (:Handle :ColorTable))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  MakeITable()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_MakeITable" 
   ((cTabH (:Handle :ColorTable))
    (iTabH (:Handle :ITab))
    (res :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AddSearch()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AddSearch" 
   ((searchProc (:pointer :OpaqueColorSearchProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  AddComp()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AddComp" 
   ((compProc (:pointer :OpaqueColorComplementProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DelSearch()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DelSearch" 
   ((searchProc (:pointer :OpaqueColorSearchProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DelComp()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DelComp" 
   ((compProc (:pointer :OpaqueColorComplementProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetClientID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetClientID" 
   ((id :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ProtectEntry()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ProtectEntry" 
   ((index :SInt16)
    (protect :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ReserveEntry()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ReserveEntry" 
   ((index :SInt16)
    (reserve :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetEntries()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetEntries" 
   ((start :SInt16)
    (count :SInt16)
    (aTable (:pointer :CSPECARRAY))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SaveEntries()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SaveEntries" 
   ((srcTable (:Handle :ColorTable))
    (resultTable (:Handle :ColorTable))
    (selection (:pointer :ReqListRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  RestoreEntries()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RestoreEntries" 
   ((srcTable (:Handle :ColorTable))
    (dstTable (:Handle :ColorTable))
    (selection (:pointer :ReqListRec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  QDError()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_QDError" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  CopyDeepMask()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CopyDeepMask" 
   ((srcBits (:pointer :BitMap))
    (maskBits (:pointer :BitMap))
    (dstBits (:pointer :BitMap))
    (srcRect (:pointer :Rect))
    (maskRect (:pointer :Rect))
    (dstRect (:pointer :Rect))
    (mode :SInt16)
    (maskRgn (:pointer :OpaqueRgnHandle))       ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DeviceLoop()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DeviceLoop" 
   ((drawingRgn (:pointer :OpaqueRgnHandle))
    (drawingProc (:pointer :OpaqueDeviceLoopDrawingProcPtr))
    (userData :signed-long)
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetMaskTable()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetMaskTable" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :pointer
() )
; 
;  *  GetPattern()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetPattern" 
   ((patternID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :Pattern)
() )
; 
;  *  [Mac]GetCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacGetCursor GetCursor

; #endif


(deftrap-inline "_GetCursor" 
   ((cursorID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :Cursor)
() )
; 
;  *  GetPicture()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetPicture" 
   ((pictureID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :Picture)
() )
; 
;  *  DeltaPoint()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_DeltaPoint" 
   ((ptA :Point)
    (ptB :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  ShieldCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ShieldCursor" 
   ((shieldRect (:pointer :Rect))
    (offsetPt :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ScreenRes()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ScreenRes" 
   ((scrnHRes (:pointer :short))
    (scrnVRes (:pointer :short))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetIndPattern()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetIndPattern" 
   ((thePat (:pointer :Pattern))
    (patternListID :SInt16)
    (index :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ptinrect()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  pt2rect()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  pttoangle()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  ptinrgn()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  addpt()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  subpt()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  equalpt()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  stuffhex()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  stdline()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  shieldcursor()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  deltapoint()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_deltapoint" 
   ((ptA (:pointer :Point))
    (ptB (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )

; #if OLDROUTINENAMES
#| 
; #define DisposPixMap(pm) DisposePixMap(pm)
; #define DisposPixPat(pp) DisposePixPat(pp)
; #define DisposCTable(cTable) DisposeCTable(cTable)
; #define DisposCCursor(cCrsr) DisposeCCursor(cCrsr)
; #define DisposGDevice(gdh) DisposeGDevice(gdh)
 |#

; #endif  /* OLDROUTINENAMES */

; 
;     From ToolUtils.i
; 
; 
;  *  PackBits()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_PackBits" 
   ((srcPtr (:pointer :Ptr))
    (dstPtr (:pointer :Ptr))
    (srcBytes :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  UnpackBits()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_UnpackBits" 
   ((srcPtr (:pointer :Ptr))
    (dstPtr (:pointer :Ptr))
    (dstBytes :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SlopeFromAngle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SlopeFromAngle" 
   ((angle :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  AngleFromSlope()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_AngleFromSlope" 
   ((slope :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
;  New transfer modes 

(defconstant $colorXorXFer 52)
(defconstant $noiseXFer 53)
(defconstant $customXFer 54)
;  Custom XFer flags 

(defconstant $kXFer1PixelAtATime 1)             ;  1 pixel passed to custom XFer proc

(defconstant $kXFerConvertPixelToRGB32 2)       ;  All color depths converted to 32 bit RGB

(defrecord CustomXFerRec
   (version :UInt32)
   (srcPixels :pointer)
   (destPixels :pointer)
   (resultPixels :pointer)
   (refCon :UInt32)
   (pixelSize :UInt32)
   (pixelCount :UInt32)
   (firstPixelHV :Point)
   (destBounds :Rect)
)

;type name? (%define-record :CustomXFerRec (find-record-descriptor ':CustomXFerRec))

(def-mactype :CustomXFerRecPtr (find-mactype '(:pointer :CustomXFerRec)))

(def-mactype :CustomXFerProcPtr (find-mactype ':pointer)); (CustomXFerRecPtr info)
; 
;  *  GetPortCustomXFerProc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_GetPortCustomXFerProc" 
   ((port (:pointer :OpaqueGrafPtr))
    (proc (:pointer :CUSTOMXFERPROCPTR))
    (flags (:pointer :UInt32))
    (refCon (:pointer :UInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetPortCustomXFerProc()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_SetPortCustomXFerProc" 
   ((port (:pointer :OpaqueGrafPtr))
    (proc :pointer)
    (flags :UInt32)
    (refCon :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )

(defconstant $kCursorComponentsVersion #x10001)

(defconstant $kCursorComponentType :|curs|)
;  Cursor Component capabilities flags 

(defconstant $cursorDoesAnimate 1)
(defconstant $cursorDoesHardware 2)
(defconstant $cursorDoesUnreadableScreenBits 4)
;  Cursor Component output mode flags 

(defconstant $kRenderCursorInHardware 1)
(defconstant $kRenderCursorInSoftware 2)
;  Cursor Component Info 
(defrecord CursorInfo
   (version :signed-long)                       ;  use kCursorComponentsVersion 
   (capabilities :signed-long)
   (animateDuration :signed-long)               ;  approximate time between animate tickles 
   (bounds :Rect)
   (hotspot :Point)
   (reserved :signed-long)                      ;  must set to zero 
)

;type name? (%define-record :CursorInfo (find-record-descriptor ':CursorInfo))
;  Cursor Component Selectors 

(defconstant $kCursorComponentInit 1)
(defconstant $kCursorComponentGetInfo 2)
(defconstant $kCursorComponentSetOutputMode 3)
(defconstant $kCursorComponentSetData 4)
(defconstant $kCursorComponentReconfigure 5)
(defconstant $kCursorComponentDraw 6)
(defconstant $kCursorComponentErase 7)
(defconstant $kCursorComponentMove 8)
(defconstant $kCursorComponentAnimate 9)
(defconstant $kCursorComponentLastReserved 80)
; 
;  *  OpenCursorComponent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_OpenCursorComponent" 
   ((c (:pointer :ComponentRecord))
    (ci (:pointer :COMPONENTINSTANCE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CloseCursorComponent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_CloseCursorComponent" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  SetCursorComponent()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_SetCursorComponent" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CursorComponentChanged()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_CursorComponentChanged" 
   ((ci (:pointer :ComponentInstanceRecord))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CursorComponentSetData()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 9.0 and later
;  

(deftrap-inline "_CursorComponentSetData" 
   ((ci (:pointer :ComponentInstanceRecord))
    (data :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
;  Quickdraw-specific ColorSync matching 
; 
;  *  CWMatchPixMap()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CWMatchPixMap" 
   ((cw (:pointer :OpaqueCMWorldRef))
    (myPixMap (:pointer :PixMap))
    (progressProc (:pointer :OpaqueCMBitmapCallBackProcPtr))
    (refCon :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CWCheckPixMap()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CWCheckPixMap" 
   ((cw (:pointer :OpaqueCMWorldRef))
    (myPixMap (:pointer :PixMap))
    (progressProc (:pointer :OpaqueCMBitmapCallBackProcPtr))
    (refCon :pointer)
    (resultBitMap (:pointer :BitMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  NCMBeginMatching()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NCMBeginMatching" 
   ((src (:pointer :OpaqueCMProfileRef))
    (dst (:pointer :OpaqueCMProfileRef))
    (myRef (:pointer :CMMATCHREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  CMEndMatching()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMEndMatching" 
   ((myRef (:pointer :OpaqueCMMatchRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NCMDrawMatchedPicture()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NCMDrawMatchedPicture" 
   ((myPicture (:Handle :Picture))
    (dst (:pointer :OpaqueCMProfileRef))
    (myRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CMEnableMatchingComment()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CMEnableMatchingComment" 
   ((enableIt :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NCMUseProfileComment()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_NCMUseProfileComment" 
   ((prof (:pointer :OpaqueCMProfileRef))
    (flags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
;  Available in CarbonLib... 
; 
;  *  IsValidPort()
;  *  
;  *  Summary:
;  *    Attempts to detect invalid ports
;  *  
;  *  Discussion:
;  *    A grafPort structure contains many nested Handles. An attempt to
;  *    guarantee that they are all valid is prohibitively costly. Since
;  *    10.1, IsValidPort only compares the CGrafPtr parameter against
;  *    the list of grafPorts maintained internally by Quickdraw. The
;  *    function returns true if it is found, false otherwise. This is
;  *    enough to detect ports belonging to windows that have been
;  *    closed, or GWorlds that have been deallocated.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    port:
;  *      The CGrafPtr in question.
;  *  
;  *  Result:
;  *    If false, port is definitely invalid. If true, port is probably
;  *    valid (unless memory has been clobbered)
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsValidPort" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  GrafPort 
;  Getters 
; 
;  *  GetPortPixMap()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortPixMap" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :PixMap)
() )
; 
;  *  GetPortBitMapForCopyBits()
;  *  
;  *  Discussion:
;  *    GetPortBitMapForCopyBits is provided for the specific purpose of
;  *    using the return value as a parameter to CopyBits. The return
;  *    value can be used as the srcBits or dstBits parameter to CopyBits
;  *    regardless of whether the port is color. If the port parameter is
;  *    a color port, however, the returned BitMapPtr does not actually
;  *    point to a BitMap; it points to the PixMapHandle and other fields
;  *    in the CGrafPort structure. You should not dereference the
;  *    BitMapPtr or otherwise depend on its contents unless you've
;  *    confirmed that this port is a non-color port.
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
;  

(deftrap-inline "_GetPortBitMapForCopyBits" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :BitMap)
() )
; 
;  *  GetPortBounds()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortBounds" 
   ((port (:pointer :OpaqueGrafPtr))
    (rect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Rect)
() )
; 
;  *  GetPortForeColor()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortForeColor" 
   ((port (:pointer :OpaqueGrafPtr))
    (foreColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :RGBColor)
() )
; 
;  *  GetPortBackColor()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortBackColor" 
   ((port (:pointer :OpaqueGrafPtr))
    (backColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :RGBColor)
() )
; 
;  *  GetPortOpColor()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortOpColor" 
   ((port (:pointer :OpaqueGrafPtr))
    (opColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :RGBColor)
() )
; 
;  *  GetPortHiliteColor()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortHiliteColor" 
   ((port (:pointer :OpaqueGrafPtr))
    (hiliteColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :RGBColor)
() )
; 
;  *  GetPortGrafProcs()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortGrafProcs" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :CQDProcs)
() )
; 
;  *  GetPortTextFont()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortTextFont" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetPortTextFace()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortTextFace" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt8
() )
; 
;  *  GetPortTextMode()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortTextMode" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetPortTextSize()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortTextSize" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetPortChExtra()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortChExtra" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetPortFracHPenLocation()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortFracHPenLocation" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetPortSpExtra()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortSpExtra" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :signed-long
() )
; 
;  *  GetPortPenVisibility()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortPenVisibility" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetPortVisibleRegion()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortVisibleRegion" 
   ((port (:pointer :OpaqueGrafPtr))
    (visRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; 
;  *  GetPortClipRegion()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortClipRegion" 
   ((port (:pointer :OpaqueGrafPtr))
    (clipRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; 
;  *  GetPortBackPixPat()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortBackPixPat" 
   ((port (:pointer :OpaqueGrafPtr))
    (backPattern (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :PixPat)
() )
; 
;  *  GetPortPenPixPat()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortPenPixPat" 
   ((port (:pointer :OpaqueGrafPtr))
    (penPattern (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :PixPat)
() )
; 
;  *  GetPortFillPixPat()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortFillPixPat" 
   ((port (:pointer :OpaqueGrafPtr))
    (fillPattern (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :PixPat)
() )
; 
;  *  GetPortPenSize()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortPenSize" 
   ((port (:pointer :OpaqueGrafPtr))
    (penSize (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Point)
() )
; 
;  *  GetPortPenMode()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortPenMode" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetPortPenLocation()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPortPenLocation" 
   ((port (:pointer :OpaqueGrafPtr))
    (penLocation (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Point)
() )
; 
;  *  IsPortRegionBeingDefined()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_IsPortRegionBeingDefined" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  IsPortPictureBeingDefined()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_IsPortPictureBeingDefined" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  IsPortPolyBeingDefined()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.3 and later
;  

(deftrap-inline "_IsPortPolyBeingDefined" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  IsPortOffscreen()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_IsPortOffscreen" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  IsPortColor()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.0
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
;  

(deftrap-inline "_IsPortColor" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  IsPortVisibleRegionEmpty()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.1
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsPortVisibleRegionEmpty" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Boolean
() )
; 
;  *  IsPortClipRegionEmpty()
;  *  
;  *  Mac OS X threading:
;  *    Thread safe since version 10.1
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IsPortClipRegionEmpty" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Boolean
() )
; 
;  *  SectRegionWithPortClipRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SectRegionWithPortClipRegion" 
   ((port (:pointer :OpaqueGrafPtr))
    (ioRegion (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  SectRegionWithPortVisibleRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SectRegionWithPortVisibleRegion" 
   ((port (:pointer :OpaqueGrafPtr))
    (ioRegion (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
;  Swappers 
; 
;  *  SwapPortPicSaveHandle()
;  *  
;  *  Summary:
;  *    Sets the port's picSave Handle, and returns the previous picSave
;  *  
;  *  Discussion:
;  *    Historically, the picSave field in a GrafPort is != NULL if a
;  *    Picture is being defined; and it has been documented that picture
;  *    definition can be temporarily suspended by saving the current
;  *    picSave Handle and setting picSave to NULL. Restoring the saved
;  *    picSave Handle resumes picture definition.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    port:
;  *      The port whose picSave field is being swapped.
;  *    
;  *    inPicSaveHdl:
;  *      The picSave Handle to be set.
;  *  
;  *  Result:
;  *    The previous picSave Handle in the port.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SwapPortPicSaveHandle" 
   ((port (:pointer :OpaqueGrafPtr))
    (inPicSaveHdl :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :Handle
() )
;  Similarly: 
; 
;  *  SwapPortPolySaveHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SwapPortPolySaveHandle" 
   ((port (:pointer :OpaqueGrafPtr))
    (inPolySaveHdl :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Handle
() )
; 
;  *  SwapPortRegionSaveHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.6 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SwapPortRegionSaveHandle" 
   ((port (:pointer :OpaqueGrafPtr))
    (inRegionSaveHdl :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Handle
() )
;  Setters 
; 
;  *  SetPortBounds()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetPortBounds" 
   ((port (:pointer :OpaqueGrafPtr))
    (rect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPortOpColor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetPortOpColor" 
   ((port (:pointer :OpaqueGrafPtr))
    (opColor (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPortGrafProcs()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetPortGrafProcs" 
   ((port (:pointer :OpaqueGrafPtr))
    (procs (:pointer :CQDProcs))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPortTextFont()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetPortTextFont" 
   ((port (:pointer :OpaqueGrafPtr))
    (txFont :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  SetPortTextSize()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetPortTextSize" 
   ((port (:pointer :OpaqueGrafPtr))
    (txSize :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  SetPortTextFace()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetPortTextFace" 
   ((port (:pointer :OpaqueGrafPtr))
    (face :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  SetPortTextMode()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SetPortTextMode" 
   ((port (:pointer :OpaqueGrafPtr))
    (mode :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  SetPortVisibleRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetPortVisibleRegion" 
   ((port (:pointer :OpaqueGrafPtr))
    (visRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPortClipRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetPortClipRegion" 
   ((port (:pointer :OpaqueGrafPtr))
    (clipRgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPortPenPixPat()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetPortPenPixPat" 
   ((port (:pointer :OpaqueGrafPtr))
    (penPattern (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPortFillPixPat()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.2 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.2 and later
;  

(deftrap-inline "_SetPortFillPixPat" 
   ((port (:pointer :OpaqueGrafPtr))
    (penPattern (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPortBackPixPat()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetPortBackPixPat" 
   ((port (:pointer :OpaqueGrafPtr))
    (backPattern (:Handle :PixPat))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPortPenSize()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetPortPenSize" 
   ((port (:pointer :OpaqueGrafPtr))
    (penSize :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPortPenMode()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetPortPenMode" 
   ((port (:pointer :OpaqueGrafPtr))
    (penMode :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetPortFracHPenLocation()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetPortFracHPenLocation" 
   ((port (:pointer :OpaqueGrafPtr))
    (pnLocHFrac :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  PixMap 
; 
;  *  GetPixBounds()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPixBounds" 
   ((pixMap (:Handle :PixMap))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Rect)
() )
; 
;  *  GetPixDepth()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetPixDepth" 
   ((pixMap (:Handle :PixMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
;  QDGlobals 
;  Getters 
; 
;  *  GetQDGlobalsRandomSeed()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetQDGlobalsRandomSeed" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  GetQDGlobalsScreenBits()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetQDGlobalsScreenBits" 
   ((screenBits (:pointer :BitMap))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :BitMap)
() )
; 
;  *  GetQDGlobalsArrow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetQDGlobalsArrow" 
   ((arrow (:pointer :Cursor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Cursor)
() )
; 
;  *  GetQDGlobalsDarkGray()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetQDGlobalsDarkGray" 
   ((dkGray (:pointer :Pattern))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Pattern)
() )
; 
;  *  GetQDGlobalsLightGray()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetQDGlobalsLightGray" 
   ((ltGray (:pointer :Pattern))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Pattern)
() )
; 
;  *  GetQDGlobalsGray()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetQDGlobalsGray" 
   ((gray (:pointer :Pattern))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Pattern)
() )
; 
;  *  GetQDGlobalsBlack()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetQDGlobalsBlack" 
   ((black (:pointer :Pattern))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Pattern)
() )
; 
;  *  GetQDGlobalsWhite()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetQDGlobalsWhite" 
   ((white (:pointer :Pattern))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Pattern)
() )
; 
;  *  GetQDGlobalsThePort()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetQDGlobalsThePort" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueGrafPtr)
() )
;  Setters 
; 
;  *  SetQDGlobalsRandomSeed()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetQDGlobalsRandomSeed" 
   ((randomSeed :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetQDGlobalsArrow()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_SetQDGlobalsArrow" 
   ((arrow (:pointer :Cursor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  Regions 
; 
;  *  GetRegionBounds()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_GetRegionBounds" 
   ((region (:pointer :OpaqueRgnHandle))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Rect)
() )
; 
;  *  IsRegionRectangular()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_IsRegionRectangular" 
   ((region (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
;  Utilities 
;  To prevent upward dependencies, GetWindowFromPort() is defined in Window Manager interface: 
;       pascal WindowRef        GetWindowFromPort(CGrafPtr port); 
;  NewPtr/OpenCPort doesn't work with opaque structures 
; 
;  *  CreateNewPort()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_CreateNewPort" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueGrafPtr)
() )
; 
;  *  DisposePort()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0 and later
;  

(deftrap-inline "_DisposePort" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  SetQDError()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
;  

(deftrap-inline "_SetQDError" 
   ((err :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  Helpful Carbon-only utilities (finally made public)
; 
;  *  QDLocalToGlobalPoint()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDLocalToGlobalPoint" 
   ((port (:pointer :OpaqueGrafPtr))
    (point (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Point)
() )
; 
;  *  QDGlobalToLocalPoint()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDGlobalToLocalPoint" 
   ((port (:pointer :OpaqueGrafPtr))
    (point (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Point)
() )
; 
;  *  QDLocalToGlobalRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDLocalToGlobalRect" 
   ((port (:pointer :OpaqueGrafPtr))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Rect)
() )
; 
;  *  QDGlobalToLocalRect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDGlobalToLocalRect" 
   ((port (:pointer :OpaqueGrafPtr))
    (bounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :Rect)
() )
; 
;  *  QDLocalToGlobalRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDLocalToGlobalRegion" 
   ((port (:pointer :OpaqueGrafPtr))
    (region (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; 
;  *  QDGlobalToLocalRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDGlobalToLocalRegion" 
   ((port (:pointer :OpaqueGrafPtr))
    (region (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueRgnHandle)
() )
; 
;    Routines available on Mac OS X to flush buffered window ports...
;    These calls do nothing on Mac OS 8/9. QDIsPortBuffered will always return false there.
; 
; 
;  *  QDIsPortBuffered()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDIsPortBuffered" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  QDIsPortBufferDirty()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDIsPortBufferDirty" 
   ((port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  QDFlushPortBuffer()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDFlushPortBuffer" 
   ((port (:pointer :OpaqueGrafPtr))
    (region (:pointer :OpaqueRgnHandle))        ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  QDGetDirtyRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDGetDirtyRegion" 
   ((port (:pointer :OpaqueGrafPtr))
    (rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  QDSetDirtyRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDSetDirtyRegion" 
   ((port (:pointer :OpaqueGrafPtr))
    (rgn (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  QDAddRectToDirtyRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDAddRectToDirtyRegion" 
   ((inPort (:pointer :OpaqueGrafPtr))
    (inBounds (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  QDAddRegionToDirtyRegion()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.5 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDAddRegionToDirtyRegion" 
   ((inPort (:pointer :OpaqueGrafPtr))
    (inRegion (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateCGContextForPort()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateCGContextForPort" 
   ((inPort (:pointer :OpaqueGrafPtr))
    (outContext (:pointer :CGContextRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ClipCGContextToRegion()
;  *  
;  *  Summary:
;  *    Set a CGContext's clip path to the equivalent of a RgnHandle
;  *  
;  *  Discussion:
;  *    The usage model of the clipPath in a CGContext is fundamentally
;  *    different from the usage of a clipRgn in a GrafPort (cf.
;  *    CoreGraphics documentation). When Quickdraw and CoreGraphics
;  *    drawing are being mixed, it is often necessary to convert a QD
;  *    clipRgn to a clipPath in CG. In order to produce the expected
;  *    outcome in ClipCGContextToRegion, this function needs to reset
;  *    any CGContext clipPath, before setting it to the converted
;  *    region. Consequently, the previous clipPath in the CGContext is
;  *    lost, and cannot be restored in a
;  *    CGContextSaveGState/CGContextRestoreGState bracket around the
;  *    ClipCGContextToRegion call.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    gc:
;  *      The CGContext
;  *    
;  *    portRect:
;  *      A bounding box for the region (needed by conversion to
;  *      clipPath). Can be the GrafPort bounds, or the region bounds
;  *    
;  *    region:
;  *      The RgnHandle (usually a clipRgn) to be converted to the
;  *      CGContextClip.
;  *  
;  *  Result:
;  *    OSStatus noErr, or a memory error is some internal allocation
;  *    failed.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_ClipCGContextToRegion" 
   ((gc (:pointer :CGContext))
    (portRect (:pointer :Rect))
    (region (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  SyncCGContextOriginWithPort()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_SyncCGContextOriginWithPort" 
   ((inContext (:pointer :CGContext))
    (port (:pointer :OpaqueGrafPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  QDBeginCGContext()
;  *  
;  *  Summary:
;  *    Allow CoreGraphics drawing in a CGrafPort
;  *  
;  *  Discussion:
;  *    So far, CreateCGContextForPort() was used to create a CGContext
;  *    for CG drawing from a CGrafPort. However, if the current port is
;  *    a printing port, the CreateCGContextForPort fails; consequently,
;  *    there was no way to mix Quickdraw and CoreGraphics drawing and
;  *    still print it. If, instead, the CoreGraphics drawing is
;  *    bracketed by QDBeginCGContext/QDEndCGContext calls, the drawing
;  *    will also appear in print. There are some restrictions on the
;  *    usage of QDBeginCGContext/QDEndCGContext:
;  *    - Between QDBeginCGContext and QDEndCGContext, Quickdraw drawing
;  *    is disabled; only CoreGraphics drawing is allowed
;  *    - QDBeginCGContext/QDEndCGContext calls can not be nested
;  *    - QDEndCGContext releases the CGContext returned from
;  *    QDBeginCGContext and sets it to NULL.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inPort:
;  *      The current port
;  *    
;  *    outContext:
;  *      The CGContextRef to be used for CG drawing
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDBeginCGContext" 
   ((inPort (:pointer :OpaqueGrafPtr))
    (outContext (:pointer :CGContextRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  QDEndCGContext()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.1 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDEndCGContext" 
   ((inPort (:pointer :OpaqueGrafPtr))
    (inoutContext (:pointer :CGContextRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;     They save the pixel data of a region in a packed format for quick save/restore 
;     without using a lot of memory to do a large, hollow region, such as the region
;     used when drag hiliting (which is where this is used).
; 

(def-mactype :QDRegionBitsRef (find-mactype '(:pointer :OpaqueQDRegionBitsRef)))
; 
;  *  QDSaveRegionBits()
;  *  
;  *  Summary:
;  *    Saves the pixel data of a region in a packed format for quick
;  *    restore
;  *  
;  *  Discussion:
;  *    Implemented in CarbonLib, and on Mac OS X in QD proper. Used in
;  *    particular for drag hiliting. The packed format doesn't use too
;  *    much memory for large hollow regions.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    region:
;  *      The RgnHandle corresponding to the pixel data to be saved.
;  *  
;  *  Result:
;  *    The QDRegionBitsRef to be passed later into QDRestoreRegionBits.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDSaveRegionBits" 
   ((region (:pointer :OpaqueRgnHandle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   (:pointer :OpaqueQDRegionBitsRef)
() )
; 
;  *  QDRestoreRegionBits()
;  *  
;  *  Summary:
;  *    Restores the pixel data of a region, as returned from
;  *    QDSaveRegionBits
;  *  
;  *  Discussion:
;  *    Implemented in CarbonLib, and on Mac OS X in QD proper. Used in
;  *    particular for drag hiliting. NOTE: QDRestoreRegionBits also
;  *    calls QDDisposeRegionBits on the regionBits passed in - don't
;  *    call it again!
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    region:
;  *      The RgnHandle corresponding to the regionBits.
;  *    
;  *    regionBits:
;  *      The QDRegionBitsRef returned from a preceding QDSaveRegionBits
;  *      call
;  *  
;  *  Result:
;  *    OSStatus noErr, or paramErr if a NULL parameter is passed in
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDRestoreRegionBits" 
   ((region (:pointer :OpaqueRgnHandle))
    (regionBits (:pointer :OpaqueQDRegionBitsRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;  *  QDDisposeRegionBits()
;  *  
;  *  Summary:
;  *    Disposes of data allocated in QDSaveRegionBits, when the
;  *    QDRegionBitsRef needs to be discarded without being passed to
;  *    QDRestoreRegionBits.
;  *  
;  *  Discussion:
;  *    Implemented in CarbonLib, and on Mac OS X in QD proper. NOTE: If
;  *    the QDRegionBitsRef has been passed to QDRestoreRegionBits, it
;  *    has been deallocated already - don't call QDDisposeRegionBits,
;  *    then.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    regionBits:
;  *      The QDRegionBitsRef returned from a preceding QDSaveRegionBits
;  *      call
;  *  
;  *  Result:
;  *    OSStatus noErr, or paramErr if a NULL parameter is passed in
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDDisposeRegionBits" 
   ((regionBits (:pointer :OpaqueQDRegionBitsRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   :OSStatus
() )
; 
;    Developers need a way to go from a CGDirectDisplay environment to Quickdraw.
;    The following is equivalent to CreateNewPort(), but instead of taking the
;    portPixMap from the current GDevice, it uses the GDevice corresponding to
;    the CGSDisplayID passed in. If the CGSDisplayID is invalid, the mainDevice
;    is used instead.
; 
; 
;  *  CreateNewPortForCGDisplayID()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CreateNewPortForCGDisplayID" 
   ((inCGDisplayID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueGrafPtr)
() )
; 
;    In Mac OS X, developers should be able to turn the WaitCursor (spinning wheel)
;    on and off. QDDisplayWaitCursor() keeps track of nested calls.
;    Passing FALSE will resume automatic wait cursor operation.
;    Call this function only from an application in the foreground.
; 
; 
;  *  QDDisplayWaitCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDDisplayWaitCursor" 
   ((forceWaitCursor :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  QDSetPatternOrigin()
;  *  
;  *  Summary:
;  *    Sets the pattern origin for the current port.
;  *  
;  *  Discussion:
;  *    When a QuickDraw drawing operation uses a pattern (either a
;  *    black&white pattern or a PixPat), the pattern's image is aligned
;  *    with port origin, modified by the pattern origin of the port. For
;  *    example, if the background pattern is a 10x10 image, and a
;  *    rectangle with coordinates (3, 3, 10, 10) is filled with that
;  *    pattern, then only the bottom right 7x7 portion of the pattern
;  *    image will be drawn into the rectangle. When drawing a pattern,
;  *    QuickDraw always starts with the port origin and then adjusts it
;  *    by the pattern origin to determine the actual origin point of
;  *    pattern drawing. QDSetPatternOrigin can be used to set the
;  *    pattern origin relative to the port origin. It is often used in
;  *    conjuction with SetOrigin to maintain the pattern alignment at
;  *    (0,0) in a window's content area, regardless of the port origin;
;  *    for example, after changing the port's origin to (10,10), an
;  *    application might change the port's pattern origin to (-10, -10)
;  *    so that patterns are still aligned with the window's content area.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    origin:
;  *      The new pattern origin of the port.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in NQD 8.5 and later
;  

(deftrap-inline "_QDSetPatternOrigin" 
   ((origin :Point)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  QDGetPatternOrigin()
;  *  
;  *  Summary:
;  *    Returns the pattern origin of the current port.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    origin:
;  *      On exit, contains the current port's pattern origin.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.1 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.3 and later
;  *    Non-Carbon CFM:   in NQD 8.5 and later
;  

(deftrap-inline "_QDGetPatternOrigin" 
   ((origin (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_1_AND_LATER
   nil
() )
; 
;  *  QDIsNamedPixMapCursorRegistered()
;  *  
;  *  Summary:
;  *    Returns whether a named cursor has already been registered.
;  *  
;  *  Discussion:
;  *    The CoreGraphics Scalable Cursor Registry provides support for
;  *    cursors based on PixMaps for crsrData and crsrMask, with sizes up
;  *    to 64x64 pixels. Such cursors need to be registered via
;  *    QDRegisterNamedPixMapCursor, and can then be set by
;  *    QDSetNamedPixMapCursor.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    name:
;  *      (see below at QDRegisterNamedPixMapCursor)
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDIsNamedPixMapCursorRegistered" 
   ((name (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :Boolean
() )
; 
;  *  QDRegisterNamedPixMapCursor()
;  *  
;  *  Summary:
;  *    Register a new cursor by name
;  *  
;  *  Discussion:
;  *    In order to set a PixMapCursor, it needs to be registered first
;  *    by name. This only succeeds if the system supports Hardware
;  *    Cursors (depending on video circuits). There is also the obvious
;  *    companion function QDUnregisterNamedPixMapCursor. NOTE: The
;  *    original implementation of QDUnregisterNamedPixMapCursor was
;  *    misspelled "QDUnregisterNamedPixMapCursur".
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    crsrData:
;  *      A PixMapHandle representing the cursor pixels. If the
;  *      pixelDepth is 32, the crsrMask PixMapHandle can be NULL; in
;  *      this case, the alpha channel in the ARGB PixMap is used as
;  *      mask. If a crsrMask is provided, the alpha channel in crsrData
;  *      is ignored. The pixelDepth can be any of 1, 2, 4, 8, 16 or 32.
;  *    
;  *    crsrMask:
;  *      A PixMapHandle representing the mask. It is assumed to be in
;  *      8-bit deep grayScale format, although other depths are accepted
;  *      and converted to 8-bit grayScale (using CopyBits). The
;  *      (**crsrMask).bounds rectangle needs to match
;  *      (**crsrData).bounds. If the crsrData are 32-bit deep, crsrMask
;  *      can be NULL, and the alpha bytes in the crsrData ARGB pixels
;  *      are used as mask.
;  *    
;  *    hotSpot:
;  *      The usual cursor hotspot, in coordinates relativ to
;  *      (**crsrData).bounds.topLeft.
;  *    
;  *    name:
;  *      A naming convention involving the name of your application and
;  *      descriptive cursor names or resource IDs is suggested. Cursor
;  *      names are 0-terminated C-strings up to a length of 127. $result
;  *              OSStatus: noErr = 0 for success, or (constants from
;  *      MacErrors.h): kQDNoColorHWCursorSupport,
;  *      kQDCursorAlreadyRegistered, paramErr, memFullErr, or a CGError
;  *      as returned internally from CoreGraphics.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDRegisterNamedPixMapCursor" 
   ((crsrData (:Handle :PixMap))
    (crsrMask (:Handle :PixMap))
    (hotSpot :Point)
    (name (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  QDUnregisterNamedPixMapCursur()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDUnregisterNamedPixMapCursur" 
   ((name (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  QDUnregisterNamedPixMapCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDUnregisterNamedPixMapCursor" 
   ((name (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  QDSetNamedPixMapCursor()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDSetNamedPixMapCursor" 
   ((name (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )

(defconstant $kQDXArrowCursor 0)
(defconstant $kQDXIBeamCursor 1)
(defconstant $kQDXIBeamXORCursor 2)
(defconstant $kQDXAliasCursor 3)
(defconstant $kQDXCopyCursor 4)
(defconstant $kQDXMoveCursor 5)
(defconstant $kQDXNumberOfSystemCursors 6)      ;  Must be last 


(def-mactype :QDXSystemCursorID (find-mactype ':UInt32))
; 
;  *  QDGetCursorNameForSystemCursor()
;  *  
;  *  Summary:
;  *    Return the name of one of the predefined Mac OS X system cursors
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    cursorID:
;  *      UInt32 in the range 0 ... kQDXNumberOfSystemCursors - 1 (see
;  *      enum above)
;  *  
;  *  Result:
;  *    const char* name, or NULL if 'cursorID' is out of range
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDGetCursorNameForSystemCursor" 
   ((cursorID :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :character)
() )
; 
;  *  QDSetCursorScale()
;  *  
;  *  Summary:
;  *    Set a scaling factor for the cursor.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    scale:
;  *      Must be at least 0.5, and integer values (1.0, 2.0, 3.0, 4.0)
;  *      are recommended. The scaling factor is system-wide (applies to
;  *      all apps), and is intended for use in such things as assisting
;  *      the visually impaired.  The scaling factor is treated as a hint
;  *      to the system, and the exact scale applied may be limited by
;  *      device driver capabilities and performance considerations.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDSetCursorScale" 
   ((scale :single-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  QDGetCursorScale()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDGetCursorScale" 
   ((outScale (:pointer :float))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  QDGetCursorData()
;  *  
;  *  Summary:
;  *    Allocate and return a PixMapHandle with the cursor data; also
;  *    return the hotSpot. The caller is responsible for calling
;  *    DisposePtr((**crsrData).baseAddr) and DisposePixMap(crsrData)
;  *    when done with the crsrData returned.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    contextCursor:
;  *      A Boolean; if true, return data for the current context cursor,
;  *      if false, return data for the currently showing global cursor.
;  *    
;  *    crsrData:
;  *      Allocates a PixMapHandle and pixelData in baseAddr,
;  *      corresponding to the cursorData. The pixelData are in 32-bit
;  *      ARGB format, with the mask contained in the alpha channel. This
;  *      PixMapHandle can be passed as crsrData to
;  *      QDRegisterNamedPixMapCursor, above (with crsrMask = NULL). If
;  *      the return result indicates an error, NULL is returned.
;  *    
;  *    hotSpot:
;  *      Contains the cursor hotSpot, if successful.
;  *  
;  *  Result:
;  *    noErr if successful, or whatever error is returned from lower
;  *    levels otherwise.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDGetCursorData" 
   ((contextCursor :Boolean)
    (crsrData (:pointer :PIXMAPHANDLE))
    (hotSpot (:pointer :Point))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )

(defconstant $kQDUseDefaultTextRendering 0)     ;  Sets whatever is specified in system defaults.
;  Currently sets kQDUseTrueTypeScalerGlyphs if nothing is specified.

(defconstant $kQDUseTrueTypeScalerGlyphs 1)     ;  bit 0

(defconstant $kQDUseCGTextRendering 2)          ;  bit 1

(defconstant $kQDUseCGTextMetrics 4)            ;  bit 2

(defconstant $kQDSupportedFlags 7)              ;  to request the current state, without changing anything

(defconstant $kQDDontChangeFlags #xFFFFFFFF)
; 
;  *  QDSwapTextFlags()
;  *  
;  *  Summary:
;  *    Returns current flags and optionally sets new flags.
;  *  
;  *  Discussion:
;  *    Currently, only the flag bits in the enum above are supported.
;  *    The typical usage is UInt32 savedFlags =
;  *    QDSwapTextFlags(newFlags); // ... draw text under the conditions
;  *    of "newFlags" ... (void)QDSwapTextFlags(savedFlags);  // restore
;  *    previous setting
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    newFlags:
;  *      Use the enums above; example "kQDUseCGTextRendering |
;  *      kQDUseCGTextMetrics".
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDSwapTextFlags" 
   ((newFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :UInt32
() )
; 
;  *  QDSwapPortTextFlags()
;  *  
;  *  Summary:
;  *    Same as QDSwapTextFlags, but per GrafPort.
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    port:
;  *      Settings per port override any global settings. If port ==
;  *      NULL, the current port is used.
;  *    
;  *    newFlags:
;  *      As in QDSwapTextFlags, above.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDSwapPortTextFlags" 
   ((port (:pointer :OpaqueGrafPtr))
    (newFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :UInt32
() )
; 
;  *  QDGetCGDirectDisplayID()
;  *  
;  *  Summary:
;  *    Return the CGDirectDisplayID corresponding to a GDHandle
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Parameters:
;  *    
;  *    inGDevice:
;  *      The GDevice handle corresponding to the device for which the
;  *      CGDirectDisplayID is requested
;  *  
;  *  Result:
;  *    The CGDirectDisplayID, or 0 if the GDHandle does not represent a
;  *    display.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in ApplicationServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_QDGetCGDirectDisplayID" 
   ((inGDevice (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :_CGDirectDisplayID)
() )
;  
;     LowMem accessor functions previously in LowMem.h
; 
; 
;  *  LMGetScrVRes()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetScrVRes" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  LMSetScrVRes()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetScrVRes" 
   ((value :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetScrHRes()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetScrHRes" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  LMSetScrHRes()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetScrHRes" 
   ((value :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetMainDevice()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetMainDevice" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :GDEVICE)
() )
; 
;  *  LMSetMainDevice()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetMainDevice" 
   ((value (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetDeviceList()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetDeviceList" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :GDEVICE)
() )
; 
;  *  LMSetDeviceList()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetDeviceList" 
   ((value (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetQDColors()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetQDColors" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  LMSetQDColors()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetQDColors" 
   ((value :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetWidthListHand()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetWidthListHand" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  LMSetWidthListHand()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetWidthListHand" 
   ((value :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetHiliteMode()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetHiliteMode" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt8
() )
; 
;  *  LMSetHiliteMode()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetHiliteMode" 
   ((value :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetWidthPtr()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetWidthPtr" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :pointer
() )
; 
;  *  LMSetWidthPtr()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetWidthPtr" 
   ((value :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetWidthTabHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetWidthTabHandle" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  LMSetWidthTabHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetWidthTabHandle" 
   ((value :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetLastSPExtra()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetLastSPExtra" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  LMSetLastSPExtra()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetLastSPExtra" 
   ((value :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetLastFOND()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetLastFOND" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  LMSetLastFOND()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetLastFOND" 
   ((value :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetFractEnable()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetFractEnable" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt8
() )
; 
;  *  LMSetFractEnable()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetFractEnable" 
   ((value :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetTheGDevice()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetTheGDevice" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :GDEVICE)
() )
; 
;  *  LMSetTheGDevice()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetTheGDevice" 
   ((value (:Handle :GDEVICE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetHiliteRGB()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetHiliteRGB" 
   ((hiliteRGBValue (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMSetHiliteRGB()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetHiliteRGB" 
   ((hiliteRGBValue (:pointer :RGBColor))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LMGetCursorNew()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  

(deftrap-inline "_LMGetCursorNew" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  LMSetCursorNew()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 8.5 and later
;  

(deftrap-inline "_LMSetCursorNew" 
   ((value :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __QUICKDRAW__ */


(provide-interface "Quickdraw")