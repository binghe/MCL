(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ScalerStreamTypes.h"
; at Sunday July 2,2006 7:23:47 pm.
; 
;      File:       ATS/ScalerStreamTypes.h
;  
;      Contains:   Scaler streaming data structures and constants for OFA 1.x
;  
;      Version:    ATS-135~1
;  
;      Copyright:  © 1994-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __SCALERSTREAMTYPES__
; #define __SCALERSTREAMTYPES__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __SFNTTYPES__
#| #|
#include <ATSSFNTTypes.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=mac68k
;  ScalerStream input/output types 

(defconstant $cexec68K 1)
(defconstant $truetypeStreamType 1)
(defconstant $type1StreamType 2)
(defconstant $type3StreamType 4)
(defconstant $type42StreamType 8)
(defconstant $type42GXStreamType 16)
(defconstant $portableStreamType 32)
(defconstant $flattenedStreamType 64)
(defconstant $cidType2StreamType #x80)
(defconstant $cidType0StreamType #x100)
(defconstant $type1CFFStreamType #x200)
(defconstant $evenOddModifierStreamType #x8000)
(defconstant $eexecBinaryModifierStreamType #x10000);  encrypted portion of Type1Stream to be binary 

(defconstant $unicodeMappingModifierStreamType #x20000);  include glyph ID to unicode mapping info for PDF 

(defconstant $scalerSpecifcModifierMask #xF000) ;  for scaler's internal use 
;  16 bits for Apple, 4 bits for scaler 

(defconstant $streamTypeModifierMask #xFFFFF000)
;  Possible streamed font formats 

(def-mactype :scalerStreamTypeFlag (find-mactype ':UInt32))

(defconstant $downloadStreamAction 0)           ;  Transmit the (possibly sparse) font data 

(defconstant $asciiDownloadStreamAction 1)      ;  Transmit font data to a 7-bit ASCII destination 

(defconstant $fontSizeQueryStreamAction 2)      ;  Estimate in-printer memory used if the font were downloaded 

(defconstant $encodingOnlyStreamAction 3)       ;  Transmit only the encoding for the font 

(defconstant $prerequisiteQueryStreamAction 4)  ;  Return a list of prerequisite items needed for the font 

(defconstant $prerequisiteItemStreamAction 5)   ;  Transmit a specified prerequisite item 

(defconstant $variationQueryStreamAction 6)     ;  Return information regarding support for variation streaming 

(defconstant $variationPSOperatorStreamAction 7);  Transmit Postscript code necessary to effect variation of a font 


(def-mactype :scalerStreamAction (find-mactype ':signed-long))
;  Special variationCount value meaning include all variation data 

(defconstant $selectAllVariations -1)
(defrecord scalerPrerequisiteItem
   (enumeration :signed-long)                   ;  Shorthand tag identifying the item 
   (size :signed-long)                          ;  Worst case vm in printer item requires 
   (name (:array :UInt8 1))                     ;  Name to be used by the client when emitting the item (Pascal string) 
)

;type name? (%define-record :scalerPrerequisiteItem (find-record-descriptor ':scalerPrerequisiteItem))
(defrecord scalerStream
   (streamRefCon :pointer)                      ;  <- private reference for client 
   (targetVersion (:pointer :char))             ;  <- e.g. Postscript printer name (C string) 
   (types :UInt32)                              ;  <->    Data stream formats desired/supplied 
   (action :signed-long)                        ;  <-     What action to take 
   (memorySize :UInt32)                         ;  -> Worst case memory use (vm) in printer or as sfnt 
   (variationCount :signed-long)                ;  <- The number of variations, or selectAllVariations 
   (variations :pointer)                        ;  <- A pointer to an array of the variations (gxFontVariation) 
   (:variant
                                                ;  Normal font streaming information
   (
   (encoding (:pointer :UInt16))                ;  <- Intention is * unsigned short[256] 
   (glyphBits (:pointer :long))                 ;  <->    Bitvector: a bit for each glyph, 1 = desired/supplied 
   (name (:pointer :char))                      ;  <->    The printer font name to use/used (C string) 
   )
                                                ;  Used to obtain a list of prerequisites from the scaler
   (
   (size :signed-long)                          ;  ->     Size of the prereq. list in bytes (0 indicates no prerequisites)
   (list :pointer)                              ;  <- Pointer to client block to hold list (nil = list size query only) 
   )
   (
   (prerequisiteItem :signed-long)
   )
                                                ;  <-     Enumeration value for the prerequisite item to be streamed.
   (
   (variationQueryResult :signed-long)
   )
                                                ;  -> Output from the variationQueryStreamAction 
   )
)

;type name? (%define-record :scalerStream (find-record-descriptor ':scalerStream))
(defrecord scalerStreamData
   (hexFlag :signed-long)                       ;  Indicates that the data is to be interpreted as hex, versus binary 
   (byteCount :signed-long)                     ;  Number of bytes in the data being streamed 
   (data :pointer)                              ;  Pointer to the data being streamed 
)

;type name? (%define-record :scalerStreamData (find-record-descriptor ':scalerStreamData))
; #pragma options align=reset

; #endif /* __SCALERSTREAMTYPES__ */


(provide-interface "ScalerStreamTypes")