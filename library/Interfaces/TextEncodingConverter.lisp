(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:TextEncodingConverter.h"
; at Sunday July 2,2006 7:23:26 pm.
; 
;      File:       CarbonCore/TextEncodingConverter.h
;  
;      Contains:   Text Encoding Conversion Interfaces.
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
; #ifndef __TEXTENCODINGCONVERTER__
; #define __TEXTENCODINGCONVERTER__
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
; #ifndef __CFSTRING__

(require-interface "CoreFoundation/CFString")

; #endif


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

(def-mactype :TECPluginSignature (find-mactype ':OSType))

(def-mactype :TECPluginVersion (find-mactype ':UInt32))
;  plugin signatures 

(defconstant $kTECSignature :|encv|)
(defconstant $kTECUnicodePluginSignature :|puni|)
(defconstant $kTECJapanesePluginSignature :|pjpn|)
(defconstant $kTECChinesePluginSignature :|pzho|)
(defconstant $kTECKoreanPluginSignature :|pkor|)
;  converter object reference 

(def-mactype :TECObjectRef (find-mactype '(:pointer :OpaqueTECObjectRef)))

(def-mactype :TECSnifferObjectRef (find-mactype '(:pointer :OpaqueTECSnifferObjectRef)))

(def-mactype :TECPluginSig (find-mactype ':OSType))
(defrecord TECConversionInfo
   (sourceEncoding :UInt32)
   (destinationEncoding :UInt32)
   (reserved1 :UInt16)
   (reserved2 :UInt16)
)

;type name? (%define-record :TECConversionInfo (find-record-descriptor ':TECConversionInfo))
; 
;  *  TECInternetNameUsageMask
;  *  
;  *  Discussion:
;  *    Mask values that control the mapping between TextEncoding and
;  *    IANA charset name or MIB enum.
;  

(def-mactype :TECInternetNameUsageMask (find-mactype ':UInt32))
;  Use one of the following
; 
;    * Use the default type of mapping given other usage information
;    * (none currently defined).
;    

(defconstant $kTECInternetNameDefaultUsageMask 0)
; 
;    * Use the closest possible match between TextEncoding value and IANA
;    * charset name or MIB enum
;    

(defconstant $kTECInternetNameStrictUsageMask 1)
; 
;    * When mapping from IANA charset name or MIB enum to TextEncoding,
;    * map to the largest superset of the encoding specified by the
;    * charset name or MIB enum (i.e. be tolerant). When mapping from
;    * TextEncoding to IANA charset name or MIB enum, typically map to
;    * the most generic or widely recognized charset name or MIB enum.
;    

(defconstant $kTECInternetNameTolerantUsageMask 2)
;  Special values for MIB enums 

(defconstant $kTEC_MIBEnumDontCare -1)
;  return number of encodings types supported by user's configuraton of the encoding converter 
; 
;  *  TECCountAvailableTextEncodings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.1 and later
;  

(deftrap-inline "_TECCountAvailableTextEncodings" 
   ((numberEncodings (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  fill in an array of type TextEncoding passed in by the user with types of encodings the current configuration of the encoder can handle. 
; 
;  *  TECGetAvailableTextEncodings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECGetAvailableTextEncodings" 
   ((availableEncodings (:pointer :TEXTENCODING))
    (maxAvailableEncodings :UInt32)
    (actualAvailableEncodings (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  return number of from-to encoding conversion pairs supported  
; 
;  *  TECCountDirectTextEncodingConversions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECCountDirectTextEncodingConversions" 
   ((numberOfEncodings (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  fill in an array of type TextEncodingPair passed in by the user with types of encoding pairs the current configuration of the encoder can handle. 
; 
;  *  TECGetDirectTextEncodingConversions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECGetDirectTextEncodingConversions" 
   ((availableConversions (:pointer :TECConversionInfo))
    (maxAvailableConversions :UInt32)
    (actualAvailableConversions (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  return number of encodings a given encoding can be converter into 
; 
;  *  TECCountDestinationTextEncodings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECCountDestinationTextEncodings" 
   ((inputEncoding :UInt32)
    (numberOfEncodings (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  fill in an array of type TextEncodingPair passed in by the user with types of encodings pairs the current configuration of the encoder can handle. 
; 
;  *  TECGetDestinationTextEncodings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECGetDestinationTextEncodings" 
   ((inputEncoding :UInt32)
    (destinationEncodings (:pointer :TEXTENCODING))
    (maxDestinationEncodings :UInt32)
    (actualDestinationEncodings (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  get info about a text encoding 
; 
;  *  TECGetTextEncodingInternetName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.1 and later
;  

(deftrap-inline "_TECGetTextEncodingInternetName" 
   ((textEncoding :UInt32)
    (encodingName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECGetTextEncodingFromInternetName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.1 and later
;  

(deftrap-inline "_TECGetTextEncodingFromInternetName" 
   ((textEncoding (:pointer :TEXTENCODING))
    (encodingName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  create/dispose converters 
; 
;  *  TECCreateConverter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.1 and later
;  

(deftrap-inline "_TECCreateConverter" 
   ((newEncodingConverter (:pointer :TECOBJECTREF))
    (inputEncoding :UInt32)
    (outputEncoding :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECCreateConverterFromPath()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECCreateConverterFromPath" 
   ((newEncodingConverter (:pointer :TECOBJECTREF))
    (inPath (:pointer :TEXTENCODING))
    (inEncodings :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECDisposeConverter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.1 and later
;  

(deftrap-inline "_TECDisposeConverter" 
   ((newEncodingConverter (:pointer :OpaqueTECObjectRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  convert text encodings 
; 
;  *  TECClearConverterContextInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECClearConverterContextInfo" 
   ((encodingConverter (:pointer :OpaqueTECObjectRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECConvertText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECConvertText" 
   ((encodingConverter (:pointer :OpaqueTECObjectRef))
    (inputBuffer (:pointer :UInt8))
    (inputBufferLength :UInt32)
    (actualInputLength (:pointer :BYTECOUNT))
    (outputBuffer (:pointer :UInt8))
    (outputBufferLength :UInt32)
    (actualOutputLength (:pointer :BYTECOUNT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECFlushText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECFlushText" 
   ((encodingConverter (:pointer :OpaqueTECObjectRef))
    (outputBuffer (:pointer :UInt8))
    (outputBufferLength :UInt32)
    (actualOutputLength (:pointer :BYTECOUNT))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  one-to-many routines 
; 
;  *  TECCountSubTextEncodings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECCountSubTextEncodings" 
   ((inputEncoding :UInt32)
    (numberOfEncodings (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECGetSubTextEncodings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECGetSubTextEncodings" 
   ((inputEncoding :UInt32)
    (subEncodings (:pointer :TEXTENCODING))
    (maxSubEncodings :UInt32)
    (actualSubEncodings (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECGetEncodingList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.1 and later
;  

(deftrap-inline "_TECGetEncodingList" 
   ((encodingConverter (:pointer :OpaqueTECObjectRef))
    (numEncodings (:pointer :ItemCount))
    (encodingList (:pointer :Handle))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECCreateOneToManyConverter()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECCreateOneToManyConverter" 
   ((newEncodingConverter (:pointer :TECOBJECTREF))
    (inputEncoding :UInt32)
    (numOutputEncodings :UInt32)
    (outputEncodings (:pointer :TEXTENCODING))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECConvertTextToMultipleEncodings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECConvertTextToMultipleEncodings" 
   ((encodingConverter (:pointer :OpaqueTECObjectRef))
    (inputBuffer (:pointer :UInt8))
    (inputBufferLength :UInt32)
    (actualInputLength (:pointer :BYTECOUNT))
    (outputBuffer (:pointer :UInt8))
    (outputBufferLength :UInt32)
    (actualOutputLength (:pointer :BYTECOUNT))
    (outEncodingsBuffer (:pointer :TextEncodingRun))
    (maxOutEncodingRuns :UInt32)
    (actualOutEncodingRuns (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECFlushMultipleEncodings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECFlushMultipleEncodings" 
   ((encodingConverter (:pointer :OpaqueTECObjectRef))
    (outputBuffer (:pointer :UInt8))
    (outputBufferLength :UInt32)
    (actualOutputLength (:pointer :BYTECOUNT))
    (outEncodingsBuffer (:pointer :TextEncodingRun))
    (maxOutEncodingRuns :UInt32)
    (actualOutEncodingRuns (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  international internet info 
; 
;  *  TECCountWebTextEncodings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECCountWebTextEncodings" 
   ((locale :SInt16)
    (numberEncodings (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECGetWebTextEncodings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECGetWebTextEncodings" 
   ((locale :SInt16)
    (availableEncodings (:pointer :TEXTENCODING))
    (maxAvailableEncodings :UInt32)
    (actualAvailableEncodings (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECCountMailTextEncodings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECCountMailTextEncodings" 
   ((locale :SInt16)
    (numberEncodings (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECGetMailTextEncodings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECGetMailTextEncodings" 
   ((locale :SInt16)
    (availableEncodings (:pointer :TEXTENCODING))
    (maxAvailableEncodings :UInt32)
    (actualAvailableEncodings (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  examine text encodings 
; 
;  *  TECCountAvailableSniffers()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECCountAvailableSniffers" 
   ((numberOfEncodings (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECGetAvailableSniffers()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECGetAvailableSniffers" 
   ((availableSniffers (:pointer :TEXTENCODING))
    (maxAvailableSniffers :UInt32)
    (actualAvailableSniffers (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECCreateSniffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECCreateSniffer" 
   ((encodingSniffer (:pointer :TECSNIFFEROBJECTREF))
    (testEncodings (:pointer :TEXTENCODING))
    (numTextEncodings :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECSniffTextEncoding()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECSniffTextEncoding" 
   ((encodingSniffer (:pointer :OpaqueTECSnifferObjectRef))
    (inputBuffer (:pointer :UInt8))
    (inputBufferLength :UInt32)
    (testEncodings (:pointer :TEXTENCODING))
    (numTextEncodings :UInt32)
    (numErrsArray (:pointer :ItemCount))
    (maxErrs :UInt32)
    (numFeaturesArray (:pointer :ItemCount))
    (maxFeatures :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECDisposeSniffer()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECDisposeSniffer" 
   ((encodingSniffer (:pointer :OpaqueTECSnifferObjectRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECClearSnifferContextInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.2 and later
;  

(deftrap-inline "_TECClearSnifferContextInfo" 
   ((encodingSniffer (:pointer :OpaqueTECSnifferObjectRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECSetBasicOptions()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.3 and later
;  *    Non-Carbon CFM:   in TextEncodingConverter 1.5 and later
;  

(deftrap-inline "_TECSetBasicOptions" 
   ((encodingConverter (:pointer :OpaqueTECObjectRef))
    (controlFlags :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
;  Map TextEncoding values to/from IANA charset names and/or MIB enums, with usage control 
; 
;  *  TECCopyTextEncodingInternetNameAndMIB()
;  *  
;  *  Summary:
;  *    Converts a TextEncoding value to an IANA charset name and/or a
;  *    MIB enum value
;  *  
;  *  Discussion:
;  *    Given a TextEncoding value, this function maps it to an IANA
;  *    charset name (if encodingNamePtr is non-NULL) and/or a MIB enum
;  *    value (if mibEnumPtr is non-NULL), as specified by the usage
;  *    parameter.
;  *  
;  *  Parameters:
;  *    
;  *    textEncoding:
;  *      A TextEncoding value to map to a charset name and/or MIB enum.
;  *    
;  *    usage:
;  *      Specifies the type of mapping desired (see
;  *      TECInternetNameUsageMask above).
;  *    
;  *    encodingNamePtr:
;  *      If non-NULL, is a pointer to a CStringRef for an immutable
;  *      CFString created by this function; when the caller is finished
;  *      with it, the caller must dispose of it by calling CFRelease.
;  *    
;  *    mibEnumPtr:
;  *      If non-NULL, is a pointer to an SInt32 that will be set to the
;  *      appropriate MIB enum value, or to 0 (or kTEC_MIBEnumDontCare)
;  *      if there is no appropriate MIB enum value (valid MIB enums
;  *      begin at 3).
;  *  
;  *  Result:
;  *    The function returns paramErr if encodingNamePtr and mibEnumPtr
;  *    are both NULL. It returns kTextUnsupportedEncodingErr if it has
;  *    no data for the supplied textEncoding. It returns noErr if it
;  *    found useful data.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TECCopyTextEncodingInternetNameAndMIB" 
   ((textEncoding :UInt32)
    (usage :UInt32)
    (encodingNamePtr (:pointer :CFSTRINGREF))   ;  can be NULL 
    (mibEnumPtr (:pointer :SInt32))             ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; 
;  *  TECGetTextEncodingFromInternetNameOrMIB()
;  *  
;  *  Summary:
;  *    Converts an IANA charset name or a MIB enum value to a
;  *    TextEncoding value
;  *  
;  *  Discussion:
;  *    If encodingName is non-NULL, this function treats it as an IANA
;  *    charset name and maps it to a TextEncoding value; in this case
;  *    mibEnum is ignored, and may be set to kTEC_MIBEnumDontCare.
;  *    Otherwise, this function maps the mibEnum to a TextEncoding
;  *    value. In either case, the mapping is controlled by the usage
;  *    parameter. The textEncodingPtr parameter must be non-NULL.
;  *  
;  *  Result:
;  *    The function returns paramErr if textEncodingPtr is NULL. It
;  *    returns kTextUnsupportedEncodingErr if it has no data for the
;  *    supplied encodingName or mibEnum. It returns noErr if it found
;  *    useful data.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.3 and later in CoreServices.framework
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TECGetTextEncodingFromInternetNameOrMIB" 
   ((textEncodingPtr (:pointer :TEXTENCODING))
    (usage :UInt32)
    (encodingName (:pointer :__CFString))
    (mibEnum :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :OSStatus
() )
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __TEXTENCODINGCONVERTER__ */


(provide-interface "TextEncodingConverter")