(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NumberFormatting.h"
; at Sunday July 2,2006 7:23:23 pm.
; 
;      File:       CarbonCore/NumberFormatting.h
;  
;      Contains:   Utilites for formatting numbers
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1996-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __NUMBERFORMATTING__
; #define __NUMBERFORMATTING__
; #ifndef __CONDITIONALMACROS__
#| #|
#include <CarbonCoreConditionalMacros.h>
#endif
|#
 |#
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __INTLRESOURCES__
#| #|
#include <CarbonCoreIntlResources.h>
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
; 
;     Here are the current System 7 routine names and the translations to the older forms.
;     Please use the newer forms in all new code and migrate the older names out of existing
;     code as maintainance permits.
;     
;     New Name                    Old Name(s)
;     
;     ExtendedToString            FormatX2Str
;     FormatRecToString           Format2Str
;     NumToString             
;     StringToExtended            FormatStr2X
;     StringToFormatRec           Str2Format
;     StringToNum             
; 
; 
(defrecord NumFormatString
   (fLength :UInt8)
   (fVersion :UInt8)
   (data (:array :character 254))               ;  private data 
)

;type name? (%define-record :NumFormatString (find-record-descriptor ':NumFormatString))

(%define-record :NumFormatStringRec (find-record-descriptor ':NumFormatString))

(def-mactype :FormatStatus (find-mactype ':SInt16))

(defconstant $fVNumber 0)                       ;  first version of NumFormatString 


(def-mactype :FormatClass (find-mactype ':SInt8))

(defconstant $fPositive 0)
(defconstant $fNegative 1)
(defconstant $fZero 2)

(def-mactype :FormatResultType (find-mactype ':SInt8))

(defconstant $fFormatOK 0)
(defconstant $fBestGuess 1)
(defconstant $fOutOfSynch 2)
(defconstant $fSpuriousChars 3)
(defconstant $fMissingDelimiter 4)
(defconstant $fExtraDecimal 5)
(defconstant $fMissingLiteral 6)
(defconstant $fExtraExp 7)
(defconstant $fFormatOverflow 8)
(defconstant $fFormStrIsNAN 9)
(defconstant $fBadPartsTable 10)
(defconstant $fExtraPercent 11)
(defconstant $fExtraSeparator 12)
(defconstant $fEmptyFormatString 13)
(defrecord FVector
   (start :SInt16)
   (length :SInt16)
)

;type name? (%define-record :FVector (find-record-descriptor ':FVector))
;  index by [fPositive..fZero] 
(defrecord TripleInt
   (contents (:array :FVector 3))
)
; 
;  *  stringtonum()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  numtostring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  StringToNum()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StringToNum" 
   ((theString (:pointer :STR255))
    (theNum (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  NumToString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NumToString" 
   ((theNum :signed-long)
    (theString (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  ExtendedToString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ExtendedToString" 
   ((x (:pointer :EXTENDED80))
    (myCanonical (:pointer :NumFormatString))
    (partsTable (:pointer :NumberParts))
    (outString (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  StringToExtended()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StringToExtended" 
   ((source (:pointer :STR255))
    (myCanonical (:pointer :NumFormatString))
    (partsTable (:pointer :NumberParts))
    (x (:pointer :EXTENDED80))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  StringToFormatRec()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StringToFormatRec" 
   ((inString (:pointer :STR255))
    (partsTable (:pointer :NumberParts))
    (outString (:pointer :NumFormatString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  FormatRecToString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FormatRecToString" 
   ((myCanonical (:pointer :NumFormatString))
    (partsTable (:pointer :NumberParts))
    (outString (:pointer :STR255))
    (positions (:pointer :TRIPLEINT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )

; #if OLDROUTINENAMES
#| 
; #define FormatX2Str(x, myCanonical, partsTable, outString)           ExtendedToString( x, myCanonical, partsTable, outString)
; #define FormatStr2X(source, myCanonical, partsTable, x)           StringToExtended( source, myCanonical, partsTable, x)
; #define Str2Format(inString, partsTable, outString)           StringToFormatRec(inString, partsTable, outString)
; #define Format2Str(myCanonical, partsTable, outString, positions)           FormatRecToString(myCanonical, partsTable, outString, positions)
 |#

; #endif  /* OLDROUTINENAMES */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __NUMBERFORMATTING__ */


(provide-interface "NumberFormatting")