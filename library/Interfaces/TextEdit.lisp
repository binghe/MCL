(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:TextEdit.h"
; at Sunday July 2,2006 7:24:51 pm.
; 
;      File:       HIToolbox/TextEdit.h
;  
;      Contains:   TextEdit Interfaces.
;  
;      Version:    HIToolbox-145.33~1
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __TEXTEDIT__
; #define __TEXTEDIT__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
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

;type name? (def-mactype :TERec (find-mactype ':TERec))

(def-mactype :TEPtr (find-mactype '(:pointer :TERec)))

;type name? (def-mactype :TEHandle (find-mactype '(:handle :TERec)))

(def-mactype :HighHookProcPtr (find-mactype ':pointer)); (const Rect * r , TEPtr pTE)

(def-mactype :EOLHookProcPtr (find-mactype ':pointer)); (char theChar , TEPtr pTE , TEHandle hTE)

(def-mactype :CaretHookProcPtr (find-mactype ':pointer)); (const Rect * r , TEPtr pTE)

(def-mactype :WidthHookProcPtr (find-mactype ':pointer)); (unsigned short textLen , unsigned short textOffset , void * textBufferPtr , TEPtr pTE , TEHandle hTE)

(def-mactype :TextWidthHookProcPtr (find-mactype ':pointer)); (unsigned short textLen , unsigned short textOffset , void * textBufferPtr , TEPtr pTE , TEHandle hTE)

(def-mactype :NWidthHookProcPtr (find-mactype ':pointer)); (unsigned short styleRunLen , unsigned short styleRunOffset , short slop , short direction , void * textBufferPtr , short * lineStart , TEPtr pTE , TEHandle hTE)

(def-mactype :DrawHookProcPtr (find-mactype ':pointer)); (unsigned short textOffset , unsigned short drawLen , void * textBufferPtr , TEPtr pTE , TEHandle hTE)

(def-mactype :HitTestHookProcPtr (find-mactype ':pointer)); (unsigned short styleRunLen , unsigned short styleRunOffset , unsigned short slop , void * textBufferPtr , TEPtr pTE , TEHandle hTE , unsigned short * pixelWidth , unsigned short * charOffset , Boolean * pixelInChar)

(def-mactype :TEFindWordProcPtr (find-mactype ':pointer)); (unsigned short currentPos , short caller , TEPtr pTE , TEHandle hTE , unsigned short * wordStart , unsigned short * wordEnd)

(def-mactype :TERecalcProcPtr (find-mactype ':pointer)); (TEPtr pTE , unsigned short changeLength , unsigned short * lineStart , unsigned short * firstChar , unsigned short * lastChar)

(def-mactype :TEDoTextProcPtr (find-mactype ':pointer)); (TEPtr pTE , unsigned short firstChar , unsigned short lastChar , short selector , GrafPtr * currentGrafPort , short * charPosition)

(def-mactype :TEClickLoopProcPtr (find-mactype ':pointer)); (TEPtr pTE)

(def-mactype :WordBreakProcPtr (find-mactype ':pointer)); (Ptr text , short charPos)
;  
;     Important note about TEClickLoopProcPtr and WordBreakProcPtr
; 
;     At one point these were defined as returning the function result in the 
;     condition code Z-bit.  This was correct, in that it was what the 68K
;     implementation of TextEdit actually tested.  But, MixedMode had a different 
;     idea of what returning a boolean in the Z-bit meant.  MixedMode was setting
;     the Z-bit the complement of what was wanted.  
;     
;     Therefore, these ProcPtrs have been changed (back) to return the result in
;     register D0.  It turns out that for register based routines, 
;     MixedMode sets the Z-bit of the 68K emulator based on the contents 
;     of the return result register.  Thus we can get the Z-bit set correctly.  
;     
;     But, when TextEdit is recoded in PowerPC, if it calls a 68K ClickLoop
;     or WordBreak routine, register D0 had better have the result (in addition
;     to the Z-bit). Therefore all 68K apps should make sure their ClickLoop or
;     WordBreak routines set register D0 at the end.
; 
;  
;     There is no function to get/set the low-mem for FindWordHook at 0x07F8.
;     This is because it is not a low-mem ProcPtr. That address is the entry
;     in the OS TrapTable for trap 0xA0FE.  You can use Get/SetTrapAddress to 
;     acccess it. 
; 
; 
;     The following ProcPtrs cannot be written in or called from a high-level 
;     language without the help of mixed mode or assembly glue because they 
;     use the following parameter-passing conventions:
; 
;     typedef pascal void (*HighHookProcPtr)(const Rect *r, TEPtr pTE);
;     typedef pascal void (*CaretHookProcPtr)(const Rect *r, TEPtr pTE);
; 
;         In:
;             =>  r                       on stack
;             =>  pTE                     A3.L
;         Out:
;             none
; 
;     typedef pascal Boolean (*EOLHookProcPtr)(char theChar, TEPtr pTE, TEHandle hTE);
; 
;         In:
;             =>  theChar                 D0.B
;             =>  pTE                     A3.L
;             =>  hTE                     A4.L
;         Out:
;             <=  Boolean                 Z bit of the CCR
; 
;     typedef pascal unsigned short (*WidthHookProcPtr)(unsigned short textLen,
;      unsigned short textOffset, void *textBufferPtr, TEPtr pTE, TEHandle hTE);
;     typedef pascal unsigned short (*TextWidthHookProcPtr)(unsigned short textLen,
;      unsigned short textOffset, void *textBufferPtr, TEPtr pTE, TEHandle hTE);
; 
;         In:
;             =>  textLen                 D0.W
;             =>  textOffset              D1.W
;             =>  textBufferPtr           A0.L
;             =>  pTE                     A3.L
;             =>  hTE                     A4.L
;         Out:
;             <=  unsigned short          D1.W
; 
;     typedef pascal unsigned short (*NWidthHookProcPtr)(unsigned short styleRunLen,
;      unsigned short styleRunOffset, short slop, short direction, void *textBufferPtr, 
;      short *lineStart, TEPtr pTE, TEHandle hTE);
; 
;         In:
;             =>  styleRunLen             D0.W
;             =>  styleRunOffset          D1.W
;             =>  slop                    D2.W (low)
;             =>  direction               D2.W (high)
;             =>  textBufferPtr           A0.L
;             =>  lineStart               A2.L
;             =>  pTE                     A3.L
;             =>  hTE                     A4.L
;         Out:
;             <=  unsigned short          D1.W
; 
;     typedef pascal void (*DrawHookProcPtr)(unsigned short textOffset, unsigned short drawLen,
;      void *textBufferPtr, TEPtr pTE, TEHandle hTE);
; 
;         In:
;             =>  textOffset              D0.W
;             =>  drawLen                 D1.W
;             =>  textBufferPtr           A0.L
;             =>  pTE                     A3.L
;             =>  hTE                     A4.L
;         Out:
;             none
; 
;     typedef pascal Boolean (*HitTestHookProcPtr)(unsigned short styleRunLen,
;      unsigned short styleRunOffset, unsigned short slop, void *textBufferPtr,
;      TEPtr pTE, TEHandle hTE, unsigned short *pixelWidth, unsigned short *charOffset, 
;      Boolean *pixelInChar);
; 
;         In:
;             =>  styleRunLen             D0.W
;             =>  styleRunOffset          D1.W
;             =>  slop                    D2.W
;             =>  textBufferPtr           A0.L
;             =>  pTE                     A3.L
;             =>  hTE                     A4.L
;         Out:
;             <=  pixelWidth              D0.W (low)
;             <=  Boolean                 D0.W (high)
;             <=  charOffset              D1.W
;             <=  pixelInChar             D2.W
; 
;     typedef pascal void (*TEFindWordProcPtr)(unsigned short currentPos, short caller, 
;      TEPtr pTE, TEHandle hTE, unsigned short *wordStart, unsigned short *wordEnd);
; 
;         In:
;             =>  currentPos              D0.W
;             =>  caller                  D2.W
;             =>  pTE                     A3.L
;             =>  hTE                     A4.L
;         Out:
;             <=  wordStart               D0.W
;             <=  wordEnd                 D1.W
; 
;     typedef pascal void (*TERecalcProcPtr)(TEPtr pTE, unsigned short changeLength,
;      unsigned short *lineStart, unsigned short *firstChar, unsigned short *lastChar);
; 
;         In:
;             =>  pTE                     A3.L
;             =>  changeLength            D7.W
;         Out:
;             <=  lineStart               D2.W
;             <=  firstChar               D3.W
;             <=  lastChar                D4.W
; 
;     typedef pascal void (*TEDoTextProcPtr)(TEPtr pTE, unsigned short firstChar, unsigned short lastChar,
;                         short selector, GrafPtr *currentGrafPort, short *charPosition);
; 
;         In:
;             =>  pTE                     A3.L
;             =>  firstChar               D3.W
;             =>  lastChar                D4.W
;             =>  selector                D7.W
;         Out:
;             <=  currentGrafPort         A0.L
;             <=  charPosition            D0.W
;             
; 

(def-mactype :HighHookUPP (find-mactype '(:pointer :OpaqueHighHookProcPtr)))

(def-mactype :EOLHookUPP (find-mactype '(:pointer :OpaqueEOLHookProcPtr)))

(def-mactype :CaretHookUPP (find-mactype '(:pointer :OpaqueCaretHookProcPtr)))

(def-mactype :WidthHookUPP (find-mactype '(:pointer :OpaqueWidthHookProcPtr)))

(def-mactype :TextWidthHookUPP (find-mactype '(:pointer :OpaqueTextWidthHookProcPtr)))

(def-mactype :NWidthHookUPP (find-mactype '(:pointer :OpaqueNWidthHookProcPtr)))

(def-mactype :DrawHookUPP (find-mactype '(:pointer :OpaqueDrawHookProcPtr)))

(def-mactype :HitTestHookUPP (find-mactype '(:pointer :OpaqueHitTestHookProcPtr)))

(def-mactype :TEFindWordUPP (find-mactype '(:pointer :OpaqueTEFindWordProcPtr)))

(def-mactype :TERecalcUPP (find-mactype '(:pointer :OpaqueTERecalcProcPtr)))

(def-mactype :TEDoTextUPP (find-mactype '(:pointer :OpaqueTEDoTextProcPtr)))

(def-mactype :TEClickLoopUPP (find-mactype '(:pointer :OpaqueTEClickLoopProcPtr)))

(def-mactype :WordBreakUPP (find-mactype '(:pointer :OpaqueWordBreakProcPtr)))
(defrecord (TERec :handle)
   (destRect :Rect)
   (viewRect :Rect)
   (selRect :Rect)
   (lineHeight :SInt16)
   (fontAscent :SInt16)
   (selPoint :Point)
   (selStart :SInt16)
   (selEnd :SInt16)
   (active :SInt16)
   (wordBreak (:pointer :OpaqueWordBreakProcPtr));  NOTE: This field is ignored on non-Roman systems and on Carbon (see IM-Text 2-60) 
   (clickLoop (:pointer :OpaqueTEClickLoopProcPtr))
   (clickTime :signed-long)
   (clickLoc :SInt16)
   (caretTime :signed-long)
   (caretState :SInt16)
   (just :SInt16)
   (teLength :SInt16)
   (hText :Handle)
   (hDispatchRec :signed-long)                  ;  added to replace recalBack & recalLines.  it's a handle anyway 
   (clikStuff :SInt16)
   (crOnly :SInt16)
   (txFont :SInt16)
   (txFace :UInt8)                              ; StyleField occupies 16-bits, but only first 8-bits are used
   (txMode :SInt16)
   (txSize :SInt16)
   (inPort (:pointer :OpaqueGrafPtr))
   (highHook (:pointer :OpaqueHighHookProcPtr))
   (caretHook (:pointer :OpaqueCaretHookProcPtr))
   (nLines :SInt16)
   (lineStarts (:array :SInt16 16001))
)
;  Justification (word alignment) styles 

(defconstant $teJustLeft 0)
(defconstant $teJustCenter 1)
(defconstant $teJustRight -1)
(defconstant $teForceLeft -2)                   ;  new names for the Justification (word alignment) styles 

(defconstant $teFlushDefault 0)                 ; flush according to the line direction 

(defconstant $teCenter 1)                       ; center justify (word alignment) 

(defconstant $teFlushRight -1)                  ; flush right for all scripts 
; flush left for all scripts 

(defconstant $teFlushLeft -2)
;  Set/Replace style modes 

(defconstant $fontBit 0)                        ; set font

(defconstant $faceBit 1)                        ; set face

(defconstant $sizeBit 2)                        ; set size

(defconstant $clrBit 3)                         ; set color

(defconstant $addSizeBit 4)                     ; add size mode

(defconstant $toggleBit 5)                      ; set faces in toggle mode

;  TESetStyle/TEContinuousStyle modes 

(defconstant $doFont 1)                         ;  set font (family) number

(defconstant $doFace 2)                         ; set character style

(defconstant $doSize 4)                         ; set type size

(defconstant $doColor 8)                        ; set color

(defconstant $doAll 15)                         ; set all attributes

(defconstant $addSize 16)                       ; adjust type size

(defconstant $doToggle 32)                      ; toggle mode for TESetStyle

;  offsets into TEDispatchRec 

(defconstant $EOLHook 0)                        ; [UniversalProcPtr] TEEOLHook

(defconstant $DRAWHook 4)                       ; [UniversalProcPtr] TEWidthHook

(defconstant $WIDTHHook 8)                      ; [UniversalProcPtr] TEDrawHook

(defconstant $HITTESTHook 12)                   ; [UniversalProcPtr] TEHitTestHook

(defconstant $nWIDTHHook 24)                    ; [UniversalProcPtr] nTEWidthHook

(defconstant $TextWidthHook 28)                 ; [UniversalProcPtr] TETextWidthHook

;  selectors for TECustomHook 

(defconstant $intEOLHook 0)                     ; TEIntHook value

(defconstant $intDrawHook 1)                    ; TEIntHook value

(defconstant $intWidthHook 2)                   ; TEIntHook value

(defconstant $intHitTestHook 3)                 ; TEIntHook value

(defconstant $intNWidthHook 6)                  ; TEIntHook value for new version of WidthHook

(defconstant $intTextWidthHook 7)               ; TEIntHook value for new TextWidthHook

(defconstant $intInlineInputTSMTEPreUpdateHook 8); TEIntHook value for TSMTEPreUpdateProcPtr callback

(defconstant $intInlineInputTSMTEPostUpdateHook 9); TEIntHook value for TSMTEPostUpdateProcPtr callback

;  feature or bit definitions for TEFeatureFlag 

(defconstant $teFAutoScroll 0)                  ; 00000001b

(defconstant $teFTextBuffering 1)               ; 00000010b

(defconstant $teFOutlineHilite 2)               ; 00000100b

(defconstant $teFInlineInput 3)                 ; 00001000b 

(defconstant $teFUseWhiteBackground 4)          ; 00010000b 

(defconstant $teFUseInlineInput 5)              ; 00100000b 

(defconstant $teFInlineInputAutoScroll 6)       ; 01000000b 

;  feature or bit definitions for TEFeatureFlag -- Carbon only                
;  To avoid having to call TEIdle in Carbon apps, automatic idling can be activated   
;  via the following feature flag, but you must ensure that the destRect and/or     
;  GrafPort's origin be setup properly for drawing in a given TERec when       
;  the timer fires.    When this feature flag is set, TEIdle is a noop.          
;  Activate this feature flag before calling TEActivate.                 

(defconstant $teFIdleWithEventLoopTimer 7)      ; 10000000b 

;  action for the new "bit (un)set" interface, TEFeatureFlag 

(defconstant $teBitClear 0)
(defconstant $teBitSet 1)                       ; set the selector bit
; no change; just return the current setting

(defconstant $teBitTest -1)
; constants for identifying the routine that called FindWord 

(defconstant $teWordSelect 4)                   ; clickExpand to select word

(defconstant $teWordDrag 8)                     ; clickExpand to drag new word

(defconstant $teFromFind 12)                    ; FindLine called it ($0C)

(defconstant $teFromRecal 16)                   ; RecalLines called it ($10)      obsolete 

; constants for identifying TEDoText selectors 

(defconstant $teFind 0)                         ; TEDoText called for searching

(defconstant $teHighlight 1)                    ; TEDoText called for highlighting

(defconstant $teDraw -1)                        ; TEDoText called for drawing text
; TEDoText called for drawing the caret

(defconstant $teCaret -2)
(defrecord Chars
   (contents (:array :character 32001))
)
(def-mactype :CharsPtr (find-mactype '(:pointer :character)))

(def-mactype :CharsHandle (find-mactype '(:handle :character)))
(defrecord StyleRun
   (startChar :SInt16)                          ; starting character position
   (styleIndex :SInt16)                         ; index in style table
)

;type name? (%define-record :StyleRun (find-record-descriptor ':StyleRun))
(defrecord STElement
   (stCount :SInt16)                            ; number of runs in this style
   (stHeight :SInt16)                           ; line height
   (stAscent :SInt16)                           ; font ascent
   (stFont :SInt16)                             ; font (family) number
   (stFace :UInt8)                              ; StyleField occupies 16-bits, but only first 8-bits are used 
   (stSize :SInt16)                             ; size in points
   (stColor :RGBColor)                          ; absolute (RGB) color
)

;type name? (%define-record :STElement (find-record-descriptor ':STElement))
(defrecord TEStyleTable
   (contents (:array :STElement 1777))
)
(def-mactype :STPtr (find-mactype '(:pointer :STElement)))

(def-mactype :STHandle (find-mactype '(:handle :STElement)))
(defrecord LHElement
   (lhHeight :SInt16)                           ; maximum height in line
   (lhAscent :SInt16)                           ; maximum ascent in line
)

;type name? (%define-record :LHElement (find-record-descriptor ':LHElement))
(defrecord LHTable
   (contents (:array :LHElement 8001))
)
(def-mactype :LHPtr (find-mactype '(:pointer :LHElement)))

(def-mactype :LHHandle (find-mactype '(:handle :LHElement)))
(defrecord ScrpSTElement
   (scrpStartChar :signed-long)                 ; starting character position
   (scrpHeight :SInt16)
   (scrpAscent :SInt16)
   (scrpFont :SInt16)
   (scrpFace :UInt8)                            ; StyleField occupies 16-bits, but only first 8-bits are used
   (scrpSize :SInt16)
   (scrpColor :RGBColor)
)

;type name? (%define-record :ScrpSTElement (find-record-descriptor ':ScrpSTElement))
;  ARRAY [0..1600] OF ScrpSTElement 
(defrecord ScrpSTTable
   (contents (:array :ScrpSTElement 1601))
)
(defrecord (StScrpRec :handle)
   (scrpNStyles :SInt16)                        ; number of styles in scrap
   (scrpStyleTab :SCRPSTTABLE)                  ; table of styles for scrap
)

;type name? (%define-record :StScrpRec (find-record-descriptor ':StScrpRec))

(def-mactype :StScrpPtr (find-mactype '(:pointer :StScrpRec)))

(def-mactype :StScrpHandle (find-mactype '(:handle :StScrpRec)))
(defrecord (NullStRec :handle)
   (teReserved :signed-long)                    ; reserved for future expansion
   (nullScrap (:Handle :StScrpRec))             ; handle to scrap style table
)

;type name? (%define-record :NullStRec (find-record-descriptor ':NullStRec))

(def-mactype :NullStPtr (find-mactype '(:pointer :NullStRec)))

(def-mactype :NullStHandle (find-mactype '(:handle :NullStRec)))
(defrecord (TEStyleRec :handle)
   (nRuns :SInt16)                              ; number of style runs
   (nStyles :SInt16)                            ; size of style table
   (styleTab (:Handle :STElement))              ; handle to style table
   (lhTab (:Handle :LHElement))                 ; handle to line-height table
   (teRefCon :signed-long)                      ; reserved for application use
   (nullStyle (:Handle :NullStRec))             ; Handle to style set at null selection
   (runs (:array :StyleRun 8001))               ; ARRAY [0..8000] OF StyleRun
)

;type name? (%define-record :TEStyleRec (find-record-descriptor ':TEStyleRec))

(def-mactype :TEStylePtr (find-mactype '(:pointer :TEStyleRec)))

(def-mactype :TEStyleHandle (find-mactype '(:handle :TEStyleRec)))
(defrecord (TextStyle :handle)
   (tsFont :SInt16)                             ; font (family) number
   (tsFace :UInt8)                              ; StyleField occupies 16-bits, but only first 8-bits are used
   (tsSize :SInt16)                             ; size in point
   (tsColor :RGBColor)                          ; absolute (RGB) color
)

;type name? (%define-record :TextStyle (find-record-descriptor ':TextStyle))

(def-mactype :TextStylePtr (find-mactype '(:pointer :TextStyle)))

(def-mactype :TextStyleHandle (find-mactype '(:handle :TextStyle)))

(def-mactype :TEIntHook (find-mactype ':SInt16))
; 
;  *  NewHighHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewHighHookUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueHighHookProcPtr)
() )
; 
;  *  NewEOLHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewEOLHookUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueEOLHookProcPtr)
() )
; 
;  *  NewCaretHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewCaretHookUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueCaretHookProcPtr)
() )
; 
;  *  NewWidthHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewWidthHookUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueWidthHookProcPtr)
() )
; 
;  *  NewTextWidthHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewTextWidthHookUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTextWidthHookProcPtr)
() )
; 
;  *  NewNWidthHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewNWidthHookUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueNWidthHookProcPtr)
() )
; 
;  *  NewDrawHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewDrawHookUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueDrawHookProcPtr)
() )
; 
;  *  NewHitTestHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewHitTestHookUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueHitTestHookProcPtr)
() )
; 
;  *  NewTEFindWordUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewTEFindWordUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTEFindWordProcPtr)
() )
; 
;  *  NewTERecalcUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewTERecalcUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTERecalcProcPtr)
() )
; 
;  *  NewTEDoTextUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewTEDoTextUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTEDoTextProcPtr)
() )
; 
;  *  NewTEClickLoopUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewTEClickLoopUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTEClickLoopProcPtr)
() )
; 
;  *  NewWordBreakUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  DisposeHighHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeHighHookUPP" 
   ((userUPP (:pointer :OpaqueHighHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeEOLHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeEOLHookUPP" 
   ((userUPP (:pointer :OpaqueEOLHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeCaretHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeCaretHookUPP" 
   ((userUPP (:pointer :OpaqueCaretHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeWidthHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeWidthHookUPP" 
   ((userUPP (:pointer :OpaqueWidthHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeTextWidthHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeTextWidthHookUPP" 
   ((userUPP (:pointer :OpaqueTextWidthHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeNWidthHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeNWidthHookUPP" 
   ((userUPP (:pointer :OpaqueNWidthHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeDrawHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeDrawHookUPP" 
   ((userUPP (:pointer :OpaqueDrawHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeHitTestHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeHitTestHookUPP" 
   ((userUPP (:pointer :OpaqueHitTestHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeTEFindWordUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeTEFindWordUPP" 
   ((userUPP (:pointer :OpaqueTEFindWordProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeTERecalcUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeTERecalcUPP" 
   ((userUPP (:pointer :OpaqueTERecalcProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeTEDoTextUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeTEDoTextUPP" 
   ((userUPP (:pointer :OpaqueTEDoTextProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeTEClickLoopUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeTEClickLoopUPP" 
   ((userUPP (:pointer :OpaqueTEClickLoopProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  DisposeWordBreakUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
; 
;  *  InvokeHighHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeHighHookUPP" 
   ((r (:pointer :Rect))
    (pTE (:pointer :TEREC))
    (userUPP (:pointer :OpaqueHighHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeEOLHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeEOLHookUPP" 
   ((theChar :character)
    (pTE (:pointer :TEREC))
    (hTE :Handle)
    (userUPP (:pointer :OpaqueEOLHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeCaretHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeCaretHookUPP" 
   ((r (:pointer :Rect))
    (pTE (:pointer :TEREC))
    (userUPP (:pointer :OpaqueCaretHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeWidthHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeWidthHookUPP" 
   ((textLen :UInt16)
    (textOffset :UInt16)
    (textBufferPtr :pointer)
    (pTE (:pointer :TEREC))
    (hTE :Handle)
    (userUPP (:pointer :OpaqueWidthHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt16
() )
; 
;  *  InvokeTextWidthHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeTextWidthHookUPP" 
   ((textLen :UInt16)
    (textOffset :UInt16)
    (textBufferPtr :pointer)
    (pTE (:pointer :TEREC))
    (hTE :Handle)
    (userUPP (:pointer :OpaqueTextWidthHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt16
() )
; 
;  *  InvokeNWidthHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeNWidthHookUPP" 
   ((styleRunLen :UInt16)
    (styleRunOffset :UInt16)
    (slop :SInt16)
    (direction :SInt16)
    (textBufferPtr :pointer)
    (lineStart (:pointer :short))
    (pTE (:pointer :TEREC))
    (hTE :Handle)
    (userUPP (:pointer :OpaqueNWidthHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt16
() )
; 
;  *  InvokeDrawHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeDrawHookUPP" 
   ((textOffset :UInt16)
    (drawLen :UInt16)
    (textBufferPtr :pointer)
    (pTE (:pointer :TEREC))
    (hTE :Handle)
    (userUPP (:pointer :OpaqueDrawHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeHitTestHookUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeHitTestHookUPP" 
   ((styleRunLen :UInt16)
    (styleRunOffset :UInt16)
    (slop :UInt16)
    (textBufferPtr :pointer)
    (pTE (:pointer :TEREC))
    (hTE :Handle)
    (pixelWidth (:pointer :UInt16))
    (charOffset (:pointer :UInt16))
    (pixelInChar (:pointer :Boolean))
    (userUPP (:pointer :OpaqueHitTestHookProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeTEFindWordUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeTEFindWordUPP" 
   ((currentPos :UInt16)
    (caller :SInt16)
    (pTE (:pointer :TEREC))
    (hTE :Handle)
    (wordStart (:pointer :UInt16))
    (wordEnd (:pointer :UInt16))
    (userUPP (:pointer :OpaqueTEFindWordProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeTERecalcUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeTERecalcUPP" 
   ((pTE (:pointer :TEREC))
    (changeLength :UInt16)
    (lineStart (:pointer :UInt16))
    (firstChar (:pointer :UInt16))
    (lastChar (:pointer :UInt16))
    (userUPP (:pointer :OpaqueTERecalcProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeTEDoTextUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeTEDoTextUPP" 
   ((pTE (:pointer :TEREC))
    (firstChar :UInt16)
    (lastChar :UInt16)
    (selector :SInt16)
    (currentGrafPort (:pointer :GrafPtr))
    (charPosition (:pointer :short))
    (userUPP (:pointer :OpaqueTEDoTextProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeTEClickLoopUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeTEClickLoopUPP" 
   ((pTE (:pointer :TEREC))
    (userUPP (:pointer :OpaqueTEClickLoopProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  InvokeWordBreakUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   available as macro/inline
;  
;  feature bit 4 for TEFeatureFlag no longer in use 

(defconstant $teFUseTextServices 4)             ; 00010000b 


; #if OLDROUTINENAMES
#|                                              ;  action for the old C "bit (un)set" interface, TEFeatureFlag 
; #define TEBitClear  teBitClear
; #define TEBitSet    teBitSet
; #define TEBitTest   teBitTest
; #define teFAutoScr  teFAutoScroll
; #define toglBit     toggleBit
 |#

; #endif  /* OLDROUTINENAMES */

; 
;  *  TEScrapHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEScrapHandle" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  TEGetScrapLength()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEGetScrapLength" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )

; #if TARGET_CPU_68K && !TARGET_RT_MAC_CFM
#| 
; #define TEGetScrapLength() ((long) * (unsigned short *) 0x0AB0)
 |#

; #endif

; 
;  *  TEInit()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  TENew()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TENew" 
   ((destRect (:pointer :Rect))
    (viewRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  TEDispose()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEDispose" 
   ((hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TESetText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TESetText" 
   ((text :pointer)
    (length :signed-long)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEGetText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEGetText" 
   ((hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :character)
() )
; 
;  *  TEIdle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEIdle" 
   ((hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TESetSelect()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TESetSelect" 
   ((selStart :signed-long)
    (selEnd :signed-long)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEActivate()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEActivate" 
   ((hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEDeactivate()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEDeactivate" 
   ((hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEKey()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEKey" 
   ((key :character)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TECut()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TECut" 
   ((hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TECopy()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TECopy" 
   ((hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEPaste()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEPaste" 
   ((hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEDelete()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEDelete" 
   ((hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEInsert()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEInsert" 
   ((text :pointer)
    (length :signed-long)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TESetAlignment()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TESetAlignment" 
   ((just :SInt16)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEUpdate()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEUpdate" 
   ((rUpdate (:pointer :Rect))
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TETextBox()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TETextBox" 
   ((text :pointer)
    (length :signed-long)
    (box (:pointer :Rect))
    (just :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEScroll()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEScroll" 
   ((dh :SInt16)
    (dv :SInt16)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TESelView()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TESelView" 
   ((hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEPinScroll()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEPinScroll" 
   ((dh :SInt16)
    (dv :SInt16)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEAutoView()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEAutoView" 
   ((fAuto :Boolean)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TECalText()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TECalText" 
   ((hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEGetOffset()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEGetOffset" 
   ((pt :Point)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  TEGetPoint()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEGetPoint" 
   ((offset :SInt16)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Point
() )
; 
;  *  TEClick()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEClick" 
   ((pt :Point)
    (fExtend :Boolean)
    (h :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEStyleNew()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEStyleNew" 
   ((destRect (:pointer :Rect))
    (viewRect (:pointer :Rect))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  TESetStyleHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TESetStyleHandle" 
   ((theHandle (:Handle :TEStyleRec))
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEGetStyleHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEGetStyleHandle" 
   ((hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :TEStyleRec)
() )
; 
;  *  TEGetStyle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEGetStyle" 
   ((offset :SInt16)
    (theStyle (:pointer :TextStyle))
    (lineHeight (:pointer :short))
    (fontAscent (:pointer :short))
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEStylePaste()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEStylePaste" 
   ((hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TESetStyle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TESetStyle" 
   ((mode :SInt16)
    (newStyle (:pointer :TextStyle))
    (fRedraw :Boolean)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEReplaceStyle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEReplaceStyle" 
   ((mode :SInt16)
    (oldStyle (:pointer :TextStyle))
    (newStyle (:pointer :TextStyle))
    (fRedraw :Boolean)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEGetStyleScrapHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEGetStyleScrapHandle" 
   ((hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :StScrpRec)
() )
; 
;  *  TEStyleInsert()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEStyleInsert" 
   ((text :pointer)
    (length :signed-long)
    (hST (:Handle :StScrpRec))
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEGetHeight()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEGetHeight" 
   ((endLine :signed-long)
    (startLine :signed-long)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  TEContinuousStyle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEContinuousStyle" 
   ((mode (:pointer :short))
    (aStyle (:pointer :TextStyle))
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  TEUseStyleScrap()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEUseStyleScrap" 
   ((rangeStart :signed-long)
    (rangeEnd :signed-long)
    (newStyles (:Handle :StScrpRec))
    (fRedraw :Boolean)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TECustomHook()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TECustomHook" 
   ((which :SInt16)
    (addr (:pointer :UniversalProcPtr))
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TENumStyles()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TENumStyles" 
   ((rangeStart :signed-long)
    (rangeEnd :signed-long)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  TEFeatureFlag()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEFeatureFlag" 
   ((feature :SInt16)
    (action :SInt16)
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  TEGetHiliteRgn()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in DragLib 1.1 and later
;  

(deftrap-inline "_TEGetHiliteRgn" 
   ((region (:pointer :OpaqueRgnHandle))
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  TESetInlineInputContextPtr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  TEConfirmInlineInput()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  
; 
;  *  TESetScrapLength()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TESetScrapLength" 
   ((length :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEFromScrap()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEFromScrap" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  TEToScrap()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TEToScrap" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  TESetClickLoop()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TESetClickLoop" 
   ((clikProc (:pointer :OpaqueTEClickLoopProcPtr))
    (hTE :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TESetWordBreak()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  TEGetDoTextHook()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TEGetDoTextHook" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTEDoTextProcPtr)
() )
; 
;  *  TESetDoTextHook()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TESetDoTextHook" 
   ((value (:pointer :OpaqueTEDoTextProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEGetRecalcHook()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TEGetRecalcHook" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTERecalcProcPtr)
() )
; 
;  *  TESetRecalcHook()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TESetRecalcHook" 
   ((value (:pointer :OpaqueTERecalcProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEGetFindWordHook()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TEGetFindWordHook" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueTEFindWordProcPtr)
() )
; 
;  *  TESetFindWordHook()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TESetFindWordHook" 
   ((value (:pointer :OpaqueTEFindWordProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  TEGetScrapHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TEGetScrapHandle" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  TESetScrapHandle()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TESetScrapHandle" 
   ((value :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  LMGetWordRedraw and LMSetWordRedraw were previously in LowMem.h  
;  Deprecated for Carbon on MacOS X                                 
;  This lomem is no longer used by the implementation of TextEdit   
;  on MacOS X, so setting it will have no effect.                   
; 
;  *  LMGetWordRedraw()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMGetWordRedraw" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt8
() )
; 
;  *  LMSetWordRedraw()
;  *  
;  *  Mac OS X threading:
;  *    Not thread safe
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in Carbon.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LMSetWordRedraw" 
   ((value :UInt8)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  teclick()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if OLDROUTINENAMES
#| 
; #if CALL_NOT_IN_CARBON
; #define TESetJust(just, hTE) TESetAlignment(just, hTE)
; #define TextBox(text, length, box, just) TETextBox(text, length, box, just)
; #define TEStylNew(destRect, viewRect) TEStyleNew(destRect, viewRect)
; #define SetStylHandle(theHandle, hTE) TESetStyleHandle(theHandle, hTE)
; #define SetStyleHandle(theHandle, hTE) TESetStyleHandle (theHandle, hTE)
; #define GetStylHandle(hTE) TEGetStyleHandle(hTE)
; #define GetStyleHandle(hTE) TEGetStyleHandle(hTE)
; #define TEStylPaste(hTE) TEStylePaste(hTE)
; #define GetStylScrap(hTE) TEGetStyleScrapHandle(hTE)
; #define GetStyleScrap(hTE) TEGetStyleScrapHandle(hTE)
; #define SetStylScrap(rangeStart, rangeEnd, newStyles, redraw, hTE) TEUseStyleScrap(rangeStart, rangeEnd, newStyles, redraw, hTE)
; #define SetStyleScrap(rangeStart, rangeEnd, newStyles, redraw, hTE)  TEUseStyleScrap(rangeStart, rangeEnd, newStyles, redraw, hTE)
; #define TEStylInsert(text, length, hST, hTE) TEStyleInsert(text, length, hST, hTE)
; #define TESetScrapLen(length) TESetScrapLength(length)
; #define TEGetScrapLen() TEGetScrapLength()
; #define SetClikLoop(clikProc, hTE) TESetClickLoop(clikProc, hTE)
; #define SetWordBreak(wBrkProc, hTE) TESetWordBreak(wBrkProc, hTE)

; #endif  /* CALL_NOT_IN_CARBON */

 |#

; #endif  /* OLDROUTINENAMES */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __TEXTEDIT__ */


(provide-interface "TextEdit")