(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:UnicodeConverter.h"
; at Sunday July 2,2006 7:23:26 pm.
; 
;      File:       CarbonCore/UnicodeConverter.h
;  
;      Contains:   Types, constants, and prototypes for Unicode Converter
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1994-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __UNICODECONVERTER__
; #define __UNICODECONVERTER__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __TEXTCOMMON__
#| #|
#include <CarbonCoreTextCommon.h>
#endif
|#
 |#
; #ifndef __MIXEDMODE__
#| #|
#include <CarbonCoreMixedMode.h>
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
;  Unicode conversion contexts: 

(def-mactype :TextToUnicodeInfo (find-mactype '(:pointer :OpaqueTextToUnicodeInfo)))

(def-mactype :UnicodeToTextInfo (find-mactype '(:pointer :OpaqueUnicodeToTextInfo)))

(def-mactype :UnicodeToTextRunInfo (find-mactype '(:pointer :OpaqueUnicodeToTextRunInfo)))

(def-mactype :ConstTextToUnicodeInfo (find-mactype ':TextToUnicodeInfo))

(def-mactype :ConstUnicodeToTextInfo (find-mactype ':UnicodeToTextInfo))
;  UnicodeMapVersion type & values 

(def-mactype :UnicodeMapVersion (find-mactype ':SInt32))

(defconstant $kUnicodeUseLatestMapping -1)
(defconstant $kUnicodeUseHFSPlusMapping 4)
;  Types used in conversion 
(defrecord UnicodeMapping
   (unicodeEncoding :UInt32)
   (otherEncoding :UInt32)
   (mappingVersion :SInt32)
)

;type name? (%define-record :UnicodeMapping (find-record-descriptor ':UnicodeMapping))

(def-mactype :UnicodeMappingPtr (find-mactype '(:pointer :UnicodeMapping)))

(def-mactype :ConstUnicodeMappingPtr (find-mactype '(:pointer :UnicodeMapping)))
;  Control flags for ConvertFromUnicodeToText and ConvertFromTextToUnicode 

(defconstant $kUnicodeUseFallbacksBit 0)
(defconstant $kUnicodeKeepInfoBit 1)
(defconstant $kUnicodeDirectionalityBits 2)
(defconstant $kUnicodeVerticalFormBit 4)
(defconstant $kUnicodeLooseMappingsBit 5)
(defconstant $kUnicodeStringUnterminatedBit 6)
(defconstant $kUnicodeTextRunBit 7)
(defconstant $kUnicodeKeepSameEncodingBit 8)
(defconstant $kUnicodeForceASCIIRangeBit 9)
(defconstant $kUnicodeNoHalfwidthCharsBit 10)
(defconstant $kUnicodeTextRunHeuristicsBit 11)
(defconstant $kUnicodeMapLineFeedToReturnBit 12);     if kUnicodeUseExternalEncodingFormBit is not set, 
;     input/output UTF-16 (and UTF-32) is assumed to be in native endian. 
;     if kUnicodeUseExternalEncodingFormBit is set, 
;     input UTF-16 (and UTF-32) is assumed to be in big endian 
;     unless it begins with a byte-order-mark, 
;     and output UTF-16 (and UTF-32) will be in big endian. 

(defconstant $kUnicodeUseExternalEncodingFormBit 13)

(defconstant $kUnicodeUseFallbacksMask 1)
(defconstant $kUnicodeKeepInfoMask 2)
(defconstant $kUnicodeDirectionalityMask 12)
(defconstant $kUnicodeVerticalFormMask 16)
(defconstant $kUnicodeLooseMappingsMask 32)
(defconstant $kUnicodeStringUnterminatedMask 64)
(defconstant $kUnicodeTextRunMask #x80)
(defconstant $kUnicodeKeepSameEncodingMask #x100)
(defconstant $kUnicodeForceASCIIRangeMask #x200)
(defconstant $kUnicodeNoHalfwidthCharsMask #x400)
(defconstant $kUnicodeTextRunHeuristicsMask #x800)
(defconstant $kUnicodeMapLineFeedToReturnMask #x1000);     if kUnicodeUseExternalEncodingFormBit is not set, 
;     input/output UTF-16 (and UTF-32) is assumed to be in native endian. 
;     if kUnicodeUseExternalEncodingFormBit is set, 
;     input UTF-16 (and UTF-32) is assumed to be in big endian 
;     unless it begins with a byte-order-mark, 
;     and output UTF-16 (and UTF-32) will be in big endian. 

(defconstant $kUnicodeUseExternalEncodingFormMask #x2000)
;  Values for kUnicodeDirectionality field 

(defconstant $kUnicodeDefaultDirection 0)
(defconstant $kUnicodeLeftToRight 1)
(defconstant $kUnicodeRightToLeft 2)
;  Directionality masks for control flags 

(defconstant $kUnicodeDefaultDirectionMask 0)
(defconstant $kUnicodeLeftToRightMask 4)
(defconstant $kUnicodeRightToLeftMask 8)
;  Control flags for TruncateForUnicodeToText: 
; 
;    Now TruncateForUnicodeToText uses control flags from the same set as used by
;    ConvertFromTextToUnicode, ConvertFromUnicodeToText, etc., but only
;    kUnicodeStringUnterminatedMask is meaningful for TruncateForUnicodeToText.
;    
;    Previously two special control flags were defined for TruncateForUnicodeToText:
;         kUnicodeTextElementSafeBit = 0
;         kUnicodeRestartSafeBit = 1
;    However, neither of these was implemented.
;    Instead of implementing kUnicodeTextElementSafeBit, we now use
;    kUnicodeStringUnterminatedMask since it accomplishes the same thing and avoids
;    having special flags just for TruncateForUnicodeToText
;    Also, kUnicodeRestartSafeBit is unnecessary, since restart-safeness is handled by
;    setting kUnicodeKeepInfoBit with ConvertFromUnicodeToText.
;    If TruncateForUnicodeToText is called with one or both of the old special control
;    flags set (bits 0 or 1), it will not generate a paramErr, but the old bits have no
;    effect on its operation.
; 
;  Filter bits for filter field in QueryUnicodeMappings and CountUnicodeMappings: 

(defconstant $kUnicodeMatchUnicodeBaseBit 0)
(defconstant $kUnicodeMatchUnicodeVariantBit 1)
(defconstant $kUnicodeMatchUnicodeFormatBit 2)
(defconstant $kUnicodeMatchOtherBaseBit 3)
(defconstant $kUnicodeMatchOtherVariantBit 4)
(defconstant $kUnicodeMatchOtherFormatBit 5)

(defconstant $kUnicodeMatchUnicodeBaseMask 1)
(defconstant $kUnicodeMatchUnicodeVariantMask 2)
(defconstant $kUnicodeMatchUnicodeFormatMask 4)
(defconstant $kUnicodeMatchOtherBaseMask 8)
(defconstant $kUnicodeMatchOtherVariantMask 16)
(defconstant $kUnicodeMatchOtherFormatMask 32)
;  Control flags for SetFallbackUnicodeToText 

(defconstant $kUnicodeFallbackSequencingBits 0)

(defconstant $kUnicodeFallbackSequencingMask 3) ;  To indicate that caller fallback routine doesn’t move memory

(defconstant $kUnicodeFallbackInterruptSafeMask 4)
;  values for kUnicodeFallbackSequencing field 

(defconstant $kUnicodeFallbackDefaultOnly 0)
(defconstant $kUnicodeFallbackCustomOnly 1)
(defconstant $kUnicodeFallbackDefaultFirst 2)
(defconstant $kUnicodeFallbackCustomFirst 3)
;  Caller-supplied entry point to a fallback handler 

(def-mactype :UnicodeToTextFallbackProcPtr (find-mactype ':pointer)); (UniChar * iSrcUniStr , ByteCount iSrcUniStrLen , ByteCount * oSrcConvLen , TextPtr oDestStr , ByteCount iDestStrLen , ByteCount * oDestConvLen , LogicalAddress iInfoPtr , ConstUnicodeMappingPtr iUnicodeMappingPtr)

(def-mactype :UnicodeToTextFallbackUPP (find-mactype '(:pointer :OpaqueUnicodeToTextFallbackProcPtr)))
; 
;  *  NewUnicodeToTextFallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_NewUnicodeToTextFallbackUPP" 
   ((userRoutine :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:pointer :OpaqueUnicodeToTextFallbackProcPtr)
() )
; 
;  *  DisposeUnicodeToTextFallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_DisposeUnicodeToTextFallbackUPP" 
   ((userUPP (:pointer :OpaqueUnicodeToTextFallbackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  InvokeUnicodeToTextFallbackUPP()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   available as macro/inline
;  

(deftrap-inline "_InvokeUnicodeToTextFallbackUPP" 
   ((iSrcUniStr (:pointer :UniChar))
    (iSrcUniStrLen :UInt32)
    (oSrcConvLen (:pointer :BYTECOUNT))
    (oDestStr (:pointer :UInt8))
    (iDestStrLen :UInt32)
    (oDestConvLen (:pointer :BYTECOUNT))
    (iInfoPtr (:pointer :void))
    (iUnicodeMappingPtr (:pointer :UnicodeMapping))
    (userUPP (:pointer :OpaqueUnicodeToTextFallbackProcPtr))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Function prototypes 
; 
;  *  CreateTextToUnicodeInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_CreateTextToUnicodeInfo" 
   ((iUnicodeMapping (:pointer :UnicodeMapping))
    (oTextToUnicodeInfo (:pointer :TextToUnicodeInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateTextToUnicodeInfoByEncoding()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_CreateTextToUnicodeInfoByEncoding" 
   ((iEncoding :UInt32)
    (oTextToUnicodeInfo (:pointer :TextToUnicodeInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateUnicodeToTextInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_CreateUnicodeToTextInfo" 
   ((iUnicodeMapping (:pointer :UnicodeMapping))
    (oUnicodeToTextInfo (:pointer :UnicodeToTextInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateUnicodeToTextInfoByEncoding()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_CreateUnicodeToTextInfoByEncoding" 
   ((iEncoding :UInt32)
    (oUnicodeToTextInfo (:pointer :UnicodeToTextInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateUnicodeToTextRunInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_CreateUnicodeToTextRunInfo" 
   ((iNumberOfMappings :UInt32)
    (iUnicodeMappings (:pointer :UnicodeMapping))
    (oUnicodeToTextInfo (:pointer :UNICODETOTEXTRUNINFO))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateUnicodeToTextRunInfoByEncoding()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_CreateUnicodeToTextRunInfoByEncoding" 
   ((iNumberOfEncodings :UInt32)
    (iEncodings (:pointer :TEXTENCODING))
    (oUnicodeToTextInfo (:pointer :UNICODETOTEXTRUNINFO))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  CreateUnicodeToTextRunInfoByScriptCode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_CreateUnicodeToTextRunInfoByScriptCode" 
   ((iNumberOfScriptCodes :UInt32)
    (iScripts (:pointer :SCRIPTCODE))
    (oUnicodeToTextInfo (:pointer :UNICODETOTEXTRUNINFO))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Change the TextToUnicodeInfo to another mapping. 
; 
;  *  ChangeTextToUnicodeInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_ChangeTextToUnicodeInfo" 
   ((ioTextToUnicodeInfo (:pointer :OpaqueTextToUnicodeInfo))
    (iUnicodeMapping (:pointer :UnicodeMapping))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Change the UnicodeToTextInfo to another mapping. 
; 
;  *  ChangeUnicodeToTextInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_ChangeUnicodeToTextInfo" 
   ((ioUnicodeToTextInfo (:pointer :OpaqueUnicodeToTextInfo))
    (iUnicodeMapping (:pointer :UnicodeMapping))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DisposeTextToUnicodeInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_DisposeTextToUnicodeInfo" 
   ((ioTextToUnicodeInfo (:pointer :TextToUnicodeInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DisposeUnicodeToTextInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_DisposeUnicodeToTextInfo" 
   ((ioUnicodeToTextInfo (:pointer :UnicodeToTextInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  DisposeUnicodeToTextRunInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_DisposeUnicodeToTextRunInfo" 
   ((ioUnicodeToTextRunInfo (:pointer :UNICODETOTEXTRUNINFO))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ConvertFromTextToUnicode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_ConvertFromTextToUnicode" 
   ((iTextToUnicodeInfo (:pointer :OpaqueTextToUnicodeInfo))
    (iSourceLen :UInt32)
    (iSourceStr (:pointer :void))
    (iControlFlags :UInt32)
    (iOffsetCount :UInt32)
    (iOffsetArray (:pointer :BYTEOFFSET))       ;  can be NULL 
    (oOffsetCount (:pointer :ItemCount))        ;  can be NULL 
    (oOffsetArray (:pointer :BYTEOFFSET))       ;  can be NULL 
    (iOutputBufLen :UInt32)
    (oSourceRead (:pointer :BYTECOUNT))
    (oUnicodeLen (:pointer :BYTECOUNT))
    (oUnicodeStr (:pointer :UniChar))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ConvertFromUnicodeToText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_ConvertFromUnicodeToText" 
   ((iUnicodeToTextInfo (:pointer :OpaqueUnicodeToTextInfo))
    (iUnicodeLen :UInt32)
    (iUnicodeStr (:pointer :UniChar))
    (iControlFlags :UInt32)
    (iOffsetCount :UInt32)
    (iOffsetArray (:pointer :BYTEOFFSET))       ;  can be NULL 
    (oOffsetCount (:pointer :ItemCount))        ;  can be NULL 
    (oOffsetArray (:pointer :BYTEOFFSET))       ;  can be NULL 
    (iOutputBufLen :UInt32)
    (oInputRead (:pointer :BYTECOUNT))
    (oOutputLen (:pointer :BYTECOUNT))
    (oOutputStr (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ConvertFromUnicodeToTextRun()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_ConvertFromUnicodeToTextRun" 
   ((iUnicodeToTextInfo (:pointer :OpaqueUnicodeToTextRunInfo))
    (iUnicodeLen :UInt32)
    (iUnicodeStr (:pointer :UniChar))
    (iControlFlags :UInt32)
    (iOffsetCount :UInt32)
    (iOffsetArray (:pointer :BYTEOFFSET))       ;  can be NULL 
    (oOffsetCount (:pointer :ItemCount))        ;  can be NULL 
    (oOffsetArray (:pointer :BYTEOFFSET))       ;  can be NULL 
    (iOutputBufLen :UInt32)
    (oInputRead (:pointer :BYTECOUNT))
    (oOutputLen (:pointer :BYTECOUNT))
    (oOutputStr (:pointer :void))
    (iEncodingRunBufLen :UInt32)
    (oEncodingRunOutLen (:pointer :ItemCount))
    (oEncodingRuns (:pointer :TextEncodingRun))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  ConvertFromUnicodeToScriptCodeRun()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_ConvertFromUnicodeToScriptCodeRun" 
   ((iUnicodeToTextInfo (:pointer :OpaqueUnicodeToTextRunInfo))
    (iUnicodeLen :UInt32)
    (iUnicodeStr (:pointer :UniChar))
    (iControlFlags :UInt32)
    (iOffsetCount :UInt32)
    (iOffsetArray (:pointer :BYTEOFFSET))       ;  can be NULL 
    (oOffsetCount (:pointer :ItemCount))        ;  can be NULL 
    (oOffsetArray (:pointer :BYTEOFFSET))       ;  can be NULL 
    (iOutputBufLen :UInt32)
    (oInputRead (:pointer :BYTECOUNT))
    (oOutputLen (:pointer :BYTECOUNT))
    (oOutputStr (:pointer :void))
    (iScriptRunBufLen :UInt32)
    (oScriptRunOutLen (:pointer :ItemCount))
    (oScriptCodeRuns (:pointer :ScriptCodeRun))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Truncate a multibyte string at a safe place. 
; 
;  *  TruncateForTextToUnicode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_TruncateForTextToUnicode" 
   ((iTextToUnicodeInfo (:pointer :OpaqueTextToUnicodeInfo))
    (iSourceLen :UInt32)
    (iSourceStr (:pointer :void))
    (iMaxLen :UInt32)
    (oTruncatedLen (:pointer :BYTECOUNT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Truncate a Unicode string at a safe place. 
; 
;  *  TruncateForUnicodeToText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_TruncateForUnicodeToText" 
   ((iUnicodeToTextInfo (:pointer :OpaqueUnicodeToTextInfo))
    (iSourceLen :UInt32)
    (iSourceStr (:pointer :UniChar))
    (iControlFlags :UInt32)
    (iMaxLen :UInt32)
    (oTruncatedLen (:pointer :BYTECOUNT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Convert a Pascal string to Unicode string. 
; 
;  *  ConvertFromPStringToUnicode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_ConvertFromPStringToUnicode" 
   ((iTextToUnicodeInfo (:pointer :OpaqueTextToUnicodeInfo))
    (iPascalStr (:pointer :STR255))
    (iOutputBufLen :UInt32)
    (oUnicodeLen (:pointer :BYTECOUNT))
    (oUnicodeStr (:pointer :UniChar))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Convert a Unicode string to Pascal string. 
; 
;  *  ConvertFromUnicodeToPString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_ConvertFromUnicodeToPString" 
   ((iUnicodeToTextInfo (:pointer :OpaqueUnicodeToTextInfo))
    (iUnicodeLen :UInt32)
    (iUnicodeStr (:pointer :UniChar))
    (oPascalStr (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Count the available conversion mappings. 
; 
;  *  CountUnicodeMappings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_CountUnicodeMappings" 
   ((iFilter :UInt32)
    (iFindMapping (:pointer :UnicodeMapping))
    (oActualCount (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Get a list of the available conversion mappings. 
; 
;  *  QueryUnicodeMappings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_QueryUnicodeMappings" 
   ((iFilter :UInt32)
    (iFindMapping (:pointer :UnicodeMapping))
    (iMaxCount :UInt32)
    (oActualCount (:pointer :ItemCount))
    (oReturnedMappings (:pointer :UnicodeMapping))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Setup the fallback handler for converting Unicode To Text. 
; 
;  *  SetFallbackUnicodeToText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_SetFallbackUnicodeToText" 
   ((iUnicodeToTextInfo (:pointer :OpaqueUnicodeToTextInfo))
    (iFallback (:pointer :OpaqueUnicodeToTextFallbackProcPtr))
    (iControlFlags :UInt32)
    (iInfoPtr (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Setup the fallback handler for converting Unicode To TextRuns. 
; 
;  *  SetFallbackUnicodeToTextRun()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_SetFallbackUnicodeToTextRun" 
   ((iUnicodeToTextRunInfo (:pointer :OpaqueUnicodeToTextRunInfo))
    (iFallback (:pointer :OpaqueUnicodeToTextFallbackProcPtr))
    (iControlFlags :UInt32)
    (iInfoPtr (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Re-initialize all state information kept by the context objects. 
; 
;  *  ResetTextToUnicodeInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.3 and later
;  

(deftrap-inline "_ResetTextToUnicodeInfo" 
   ((ioTextToUnicodeInfo (:pointer :OpaqueTextToUnicodeInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Re-initialize all state information kept by the context objects. 
; 
;  *  ResetUnicodeToTextInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_ResetUnicodeToTextInfo" 
   ((ioUnicodeToTextInfo (:pointer :OpaqueUnicodeToTextInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Re-initialize all state information kept by the context objects in TextRun conversions. 
; 
;  *  ResetUnicodeToTextRunInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeConverter 1.1 and later
;  

(deftrap-inline "_ResetUnicodeToTextRunInfo" 
   ((ioUnicodeToTextRunInfo (:pointer :OpaqueUnicodeToTextRunInfo))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __UNICODECONVERTER__ */


(provide-interface "UnicodeConverter")