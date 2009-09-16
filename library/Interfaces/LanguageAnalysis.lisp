(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:LanguageAnalysis.h"
; at Sunday July 2,2006 7:24:44 pm.
; 
;      File:       LangAnalysis/LanguageAnalysis.h
;  
;      Contains:   Language Analysis Manager Interfaces
;  
;      Version:    LanguageAnalysis-124~1
;  
;      Copyright:  © 1996-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __LANGUAGEANALYSIS__
; #define __LANGUAGEANALYSIS__
; #ifndef __CORESERVICES__
#| #|
#include <CoreServicesCoreServices.h>
#endif
|#
 |#
; #ifndef __AEREGISTRY__
#| #|
#include <AEAERegistry.h>
#endif
|#
 |#
; #ifndef __DICTIONARY__

(require-interface "LangAnalysis/Dictionary")

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
; #pragma options align=power

(def-mactype :LAEnvironmentRef (find-mactype '(:pointer :OpaqueLAEnvironmentRef)))

(def-mactype :LAContextRef (find-mactype '(:pointer :OpaqueLAContextRef)))

(def-mactype :LAPropertyKey (find-mactype ':FourCharCode))

(def-mactype :LAPropertyType (find-mactype ':FourCharCode))
; 
;     Data structure for high level API
; 
(defrecord LAMorphemeRec
   (sourceTextLength :UInt32)
   (sourceTextPtr (:pointer :void))
   (morphemeTextLength :UInt32)
   (morphemeTextPtr (:pointer :void))
   (partOfSpeech :UInt32)
)

;type name? (%define-record :LAMorphemeRec (find-record-descriptor ':LAMorphemeRec))
(defrecord LAMorphemesArray
   (morphemesCount :UInt32)
   (processedTextLength :UInt32)
   (morphemesTextLength :UInt32)
   (morphemes (:array :LAMorphemeRec 1))
)

;type name? (%define-record :LAMorphemesArray (find-record-descriptor ':LAMorphemesArray))

(def-mactype :LAMorphemesArrayPtr (find-mactype '(:pointer :LAMorphemesArray)))

(defconstant $kLAMorphemesArrayVersion 0)
; 
;     Definitions for result path/bundle structure
; 

(%define-record :LAMorphemeBundle (find-record-descriptor ':AEDesc))

(%define-record :LAMorphemePath (find-record-descriptor ':AEDesc))

(%define-record :LAMorpheme (find-record-descriptor ':AEDesc))

(%define-record :LAHomograph (find-record-descriptor ':AEDesc))

(defconstant $keyAELAMorphemeBundle :|lmfb|)
(defconstant $keyAELAMorphemePath :|lmfp|)
(defconstant $keyAELAMorpheme :|lmfn|)
(defconstant $keyAELAHomograph :|lmfh|)

(defconstant $typeLAMorphemeBundle :|reco|)
(defconstant $typeLAMorphemePath :|reco|)
(defconstant $typeLAMorpheme :|list|)
(defconstant $typeLAHomograph :|list|)
; 
;     Definitions for morpheme/homograph information
; 

(defconstant $keyAEMorphemePartOfSpeechCode :|lamc|)
(defconstant $keyAEMorphemeTextRange :|lamt|)

(defconstant $typeAEMorphemePartOfSpeechCode :|lamc|)
(defconstant $typeAEMorphemeTextRange :|lamt|)

(def-mactype :MorphemePartOfSpeech (find-mactype ':UInt32))
(defrecord MorphemeTextRange
   (sourceOffset :UInt32)
   (length :UInt32)
)

;type name? (%define-record :MorphemeTextRange (find-record-descriptor ':MorphemeTextRange))
; 
;     Mask for High level API convert flags 
; 

(defconstant $kLAEndOfSourceTextMask 1)
; 
;     Constants for leading/trailing path of analysis function
; 

(defconstant $kLADefaultEdge 0)
(defconstant $kLAFreeEdge 1)
(defconstant $kLAIncompleteEdge 2)
; 
;     Constants for confirm and shift function
; 

(defconstant $kLAAllMorphemes 0)
; 
;     Library version
; 
; 
;  *  LALibraryVersion()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LALibraryVersion" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;     High level API
; 
; 
;  *  LATextToMorphemes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LATextToMorphemes" 
   ((context (:pointer :OpaqueLAContextRef))
    (preferedEncoding :UInt32)
    (textLength :UInt32)
    (sourceText (:pointer :void))
    (bufferSize :UInt32)
    (convertFlags :UInt32)
    (structureVersion :UInt32)
    (acceptedLength (:pointer :ByteCount))
    (resultBuffer (:pointer :LAMorphemesArray))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Handling Context
; 
; 
;  *  LAOpenAnalysisContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LAOpenAnalysisContext" 
   ((environ (:pointer :OpaqueLAEnvironmentRef))
    (context (:pointer :LACONTEXTREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LACloseAnalysisContext()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LACloseAnalysisContext" 
   ((context (:pointer :OpaqueLAContextRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Handling Environment
; 
; 
;  *  LAGetEnvironmentList()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LAGetEnvironmentList" 
   ((maxCount :UInt32)
    (actualCount (:pointer :UInt32))
    (environmentList (:pointer :LAENVIRONMENTREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LAGetEnvironmentName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LAGetEnvironmentName" 
   ((environment (:pointer :OpaqueLAEnvironmentRef))
    (environmentName (:pointer :Str63))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LAGetEnvironmentRef()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LAGetEnvironmentRef" 
   ((targetEnvironmentName (:pointer :UInt8))
    (environment (:pointer :LAENVIRONMENTREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LACreateCustomEnvironment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LACreateCustomEnvironment" 
   ((baseEnvironment (:pointer :OpaqueLAEnvironmentRef))
    (newEnvironmentName (:pointer :UInt8))
    (persistent :Boolean)
    (newEnvironment (:pointer :LAENVIRONMENTREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LADeleteCustomEnvironment()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LADeleteCustomEnvironment" 
   ((environment (:pointer :OpaqueLAEnvironmentRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Handling dictionries
; 
; 
;  *  LAOpenDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LAOpenDictionary" 
   ((environ (:pointer :OpaqueLAEnvironmentRef))
    (dictionary (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LACloseDictionary()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LACloseDictionary" 
   ((environ (:pointer :OpaqueLAEnvironmentRef))
    (dictionary (:pointer :FSSpec))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LAListAvailableDictionaries()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LAListAvailableDictionaries" 
   ((environ (:pointer :OpaqueLAEnvironmentRef))
    (maxCount :UInt32)
    (actualCount (:pointer :ItemCount))
    (dictionaryList (:pointer :FSSpec))
    (opened (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LAAddNewWord()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LAAddNewWord" 
   ((environ (:pointer :OpaqueLAEnvironmentRef))
    (dictionary (:pointer :FSSpec))
    (dataList (:pointer :AEDesc))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Analyzing text
; 
; 
;  *  LAMorphemeAnalysis()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LAMorphemeAnalysis" 
   ((context (:pointer :OpaqueLAContextRef))
    (text (:pointer :UInt16))
    (textLength :UInt32)
    (leadingPath (:pointer :LAMORPHEMEPATH))
    (trailingPath (:pointer :LAMORPHEMEPATH))
    (pathCount :UInt32)
    (result (:pointer :LAMORPHEMEBUNDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LAContinuousMorphemeAnalysis()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LAContinuousMorphemeAnalysis" 
   ((context (:pointer :OpaqueLAContextRef))
    (text (:pointer :UInt16))
    (textLength :UInt32)
    (incrementalText :Boolean)
    (leadingPath (:pointer :LAMORPHEMEPATH))
    (trailingPath (:pointer :LAMORPHEMEPATH))
    (modified (:pointer :Boolean))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LAGetMorphemes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LAGetMorphemes" 
   ((context (:pointer :OpaqueLAContextRef))
    (result (:pointer :LAMORPHEMEPATH))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LAShiftMorphemes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LAShiftMorphemes" 
   ((context (:pointer :OpaqueLAContextRef))
    (morphemeCount :UInt32)
    (path (:pointer :LAMORPHEMEPATH))
    (shiftedLength (:pointer :UniCharCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LAResetAnalysis()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in ApplicationServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LanguageAnalysisLib 1.0 and later
;  

(deftrap-inline "_LAResetAnalysis" 
   ((context (:pointer :OpaqueLAContextRef))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;     Check Language Analysis Manager availability
; 

; #if TARGET_RT_MAC_CFM
; #ifdef __cplusplus
#| #|
    inline pascal Boolean LALanguageAnalysisAvailable() { return (LALibraryVersion != (void*)kUnresolvedCFragSymbolAddress); }
|#
 |#

; #else
; #define LALanguageAnalysisAvailable()   ((LALibraryVersion != (void*)kUnresolvedCFragSymbolAddress)

; #endif

#| 
; #elif TARGET_RT_MAC_MACHO
;  Language Analysis Manager is always available on OS X 
; #ifdef __cplusplus
#|
    inline pascal Boolean LALanguageAnalysisAvailable() { return true; }
|#

; #else
; #define LALanguageAnalysisAvailable()   (true)

; #endif

 |#

; #endif  /*  */

; 
; =============================================================================================
;     Definitions for Japanese Analysis Module
; =============================================================================================
; 
; 
;     Names for default environments for Japanese analysis
; 
(defconstant $kLAJapaneseKanaKanjiEnvironment "\\pKanaKanjiConversion")
; #define kLAJapaneseKanaKanjiEnvironment             "\pKanaKanjiConversion"
(defconstant $kLAJapaneseMorphemeAnalysisEnvironment "\\pJapaneseMorphemeAnalysis")
; #define kLAJapaneseMorphemeAnalysisEnvironment      "\pJapaneseMorphemeAnalysis"
(defconstant $kLAJapaneseTTSEnvironment "\\pJapaneseTextToSpeech")
; #define kLAJapaneseTTSEnvironment                   "\pJapaneseTextToSpeech"
; 
;     File cretor for dictionary of Apple Japanese access method
; 

(defconstant $kAppleJapaneseDictionarySignature :|jlan|)
; 
;     Engine limitations
; 

(defconstant $kMaxInputLengthOfAppleJapaneseEngine #xC8)
; 
;     Definitions of information in the path/bundle
; 

(def-mactype :JapanesePartOfSpeech (find-mactype ':UInt32))

(def-mactype :HomographWeight (find-mactype ':UInt16))

(def-mactype :HomographAccent (find-mactype ':UInt8))
; 
;     AE keywords and type definitions for morpheme/homograph information
; 

(defconstant $keyAEHomographDicInfo :|lahd|)
(defconstant $keyAEHomographWeight :|lahw|)
(defconstant $keyAEHomographAccent :|laha|)

(defconstant $typeAEHomographDicInfo :|lahd|)
(defconstant $typeAEHomographWeight :|shor|)
(defconstant $typeAEHomographAccent :|laha|)
; 
;     Structure for dictionary information of homograph
; 
(defrecord HomographDicInfoRec
   (dictionaryID (:pointer :OpaqueDCMObjectID))
   (uniqueID :UInt32)
)

;type name? (%define-record :HomographDicInfoRec (find-record-descriptor ':HomographDicInfoRec))
; 
; =============================================================================================
;     Definitions for Japanese part of speeches
; =============================================================================================
; 
; 
;     Masks for part of speeches
; 

(defconstant $kLASpeechRoughClassMask #xF000)
(defconstant $kLASpeechMediumClassMask #xFF00)
(defconstant $kLASpeechStrictClassMask #xFFF0)
(defconstant $kLASpeechKatsuyouMask 15)
; 
;     Part of speeches
; 

(defconstant $kLASpeechMeishi 0)                ;  noun 

(defconstant $kLASpeechFutsuuMeishi 0)          ;  general noun 

(defconstant $kLASpeechJinmei #x100)            ;  person name 

(defconstant $kLASpeechJinmeiSei #x110)         ;  family name 

(defconstant $kLASpeechJinmeiMei #x120)         ;  first name 

(defconstant $kLASpeechChimei #x200)            ;  place name 

(defconstant $kLASpeechSetsubiChimei #x210)     ;  place name with suffix 

(defconstant $kLASpeechSoshikimei #x300)        ;  organization name 

(defconstant $kLASpeechKoyuuMeishi #x400)       ;  proper noun 

(defconstant $kLASpeechSahenMeishi #x500)       ;  special noun 

(defconstant $kLASpeechKeidouMeishi #x600)      ;  special noun 

(defconstant $kLASpeechRentaishi #x1000)
(defconstant $kLASpeechFukushi #x2000)          ;  adverb 

(defconstant $kLASpeechSetsuzokushi #x3000)     ;  conjunction 

(defconstant $kLASpeechKandoushi #x4000)
(defconstant $kLASpeechDoushi #x5000)           ;  verb 

(defconstant $kLASpeechGodanDoushi #x5000)
(defconstant $kLASpeechKagyouGodan #x5000)
(defconstant $kLASpeechSagyouGodan #x5010)
(defconstant $kLASpeechTagyouGodan #x5020)
(defconstant $kLASpeechNagyouGodan #x5030)
(defconstant $kLASpeechMagyouGodan #x5040)
(defconstant $kLASpeechRagyouGodan #x5050)
(defconstant $kLASpeechWagyouGodan #x5060)
(defconstant $kLASpeechGagyouGodan #x5070)
(defconstant $kLASpeechBagyouGodan #x5080)
(defconstant $kLASpeechIchidanDoushi #x5100)
(defconstant $kLASpeechKahenDoushi #x5200)
(defconstant $kLASpeechSahenDoushi #x5300)
(defconstant $kLASpeechZahenDoushi #x5400)
(defconstant $kLASpeechKeiyoushi #x6000)        ;  adjective 

(defconstant $kLASpeechKeiyoudoushi #x7000)
(defconstant $kLASpeechSettougo #x8000)         ;  prefix

(defconstant $kLASpeechSuujiSettougo #x8100)    ;  prefix for numbers 

(defconstant $kLASpeechSetsubigo #x9000)        ;  suffix 

(defconstant $kLASpeechJinmeiSetsubigo #x9100)  ;  suffix for person name 

(defconstant $kLASpeechChimeiSetsubigo #x9200)  ;  suffix for place name 

(defconstant $kLASpeechSoshikimeiSetsubigo #x9300);  suffix for organization name 

(defconstant $kLASpeechSuujiSetsubigo #x9400)   ;  suffix for numbers 

(defconstant $kLASpeechMuhinshi #xA000)         ;  no category 

(defconstant $kLASpeechTankanji #xA000)         ;  character 

(defconstant $kLASpeechKigou #xA100)            ;  symbol 

(defconstant $kLASpeechKuten #xA110)
(defconstant $kLASpeechTouten #xA120)
(defconstant $kLASpeechSuushi #xA200)           ;  numbers 

(defconstant $kLASpeechDokuritsugo #xA300)
(defconstant $kLASpeechSeiku #xA400)
(defconstant $kLASpeechJodoushi #xB000)         ;  auxiliary verb 

(defconstant $kLASpeechJoshi #xC000)            ;  postpositional particle 

; 
;     Conjugations
;  

(defconstant $kLASpeechKatsuyouGokan 1)         ;  stem 

(defconstant $kLASpeechKatsuyouMizen 2)
(defconstant $kLASpeechKatsuyouRenyou 3)
(defconstant $kLASpeechKatsuyouSyuushi 4)
(defconstant $kLASpeechKatsuyouRentai 5)
(defconstant $kLASpeechKatsuyouKatei 6)
(defconstant $kLASpeechKatsuyouMeirei 7)
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __LANGUAGEANALYSIS__ */


(provide-interface "LanguageAnalysis")