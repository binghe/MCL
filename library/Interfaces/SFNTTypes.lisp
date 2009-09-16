(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SFNTTypes.h"
; at Sunday July 2,2006 7:23:46 pm.
; 
;      File:       ATS/SFNTTypes.h
;  
;      Contains:   Font file structures.
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
; #ifndef __SFNTTYPES__
; #define __SFNTTYPES__
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

; #pragma options align=mac68k
(defrecord sfntDirectoryEntry
   (tableTag :FourCharCode)
   (checkSum :UInt32)
   (offset :UInt32)
   (length :UInt32)
)

;type name? (%define-record :sfntDirectoryEntry (find-record-descriptor ':sfntDirectoryEntry))
;  The search fields limits numOffsets to 4096. 
(defrecord sfntDirectory
   (format :FourCharCode)
   (numOffsets :UInt16)                         ;  number of tables 
   (searchRange :UInt16)                        ;  (max2 <= numOffsets)*16 
   (entrySelector :UInt16)                      ;  log2(max2 <= numOffsets) 
   (rangeShift :UInt16)                         ;  numOffsets*16-searchRange
   (table (:array :sfntDirectoryEntry 1))       ;  table[numOffsets] 
)

;type name? (%define-record :sfntDirectory (find-record-descriptor ':sfntDirectory))

(defconstant $sizeof_sfntDirectory 12)
;  Cmap - character id to glyph id mapping 

(defconstant $cmapFontTableTag :|cmap|)

(defconstant $kFontUnicodePlatform 0)
(defconstant $kFontMacintoshPlatform 1)
(defconstant $kFontReservedPlatform 2)
(defconstant $kFontMicrosoftPlatform 3)
(defconstant $kFontCustomPlatform 4)

(defconstant $kFontUnicodeDefaultSemantics 0)
(defconstant $kFontUnicodeV1_1Semantics 1)
(defconstant $kFontISO10646_1993Semantics 2)

(defconstant $kFontRomanScript 0)
(defconstant $kFontJapaneseScript 1)
(defconstant $kFontTraditionalChineseScript 2)
(defconstant $kFontChineseScript 2)
(defconstant $kFontKoreanScript 3)
(defconstant $kFontArabicScript 4)
(defconstant $kFontHebrewScript 5)
(defconstant $kFontGreekScript 6)
(defconstant $kFontCyrillicScript 7)
(defconstant $kFontRussian 7)
(defconstant $kFontRSymbolScript 8)
(defconstant $kFontDevanagariScript 9)
(defconstant $kFontGurmukhiScript 10)
(defconstant $kFontGujaratiScript 11)
(defconstant $kFontOriyaScript 12)
(defconstant $kFontBengaliScript 13)
(defconstant $kFontTamilScript 14)
(defconstant $kFontTeluguScript 15)
(defconstant $kFontKannadaScript 16)
(defconstant $kFontMalayalamScript 17)
(defconstant $kFontSinhaleseScript 18)
(defconstant $kFontBurmeseScript 19)
(defconstant $kFontKhmerScript 20)
(defconstant $kFontThaiScript 21)
(defconstant $kFontLaotianScript 22)
(defconstant $kFontGeorgianScript 23)
(defconstant $kFontArmenianScript 24)
(defconstant $kFontSimpleChineseScript 25)
(defconstant $kFontTibetanScript 26)
(defconstant $kFontMongolianScript 27)
(defconstant $kFontGeezScript 28)
(defconstant $kFontEthiopicScript 28)
(defconstant $kFontAmharicScript 28)
(defconstant $kFontSlavicScript 29)
(defconstant $kFontEastEuropeanRomanScript 29)
(defconstant $kFontVietnameseScript 30)
(defconstant $kFontExtendedArabicScript 31)
(defconstant $kFontSindhiScript 31)
(defconstant $kFontUninterpretedScript 32)

(defconstant $kFontMicrosoftSymbolScript 0)
(defconstant $kFontMicrosoftStandardScript 1)
(defconstant $kFontMicrosoftUCS4Script 10)

(defconstant $kFontCustom8BitScript 0)
(defconstant $kFontCustom816BitScript 1)
(defconstant $kFontCustom16BitScript 2)
;  Language codes are zero based everywhere but within a 'cmap' table 

(defconstant $kFontEnglishLanguage 0)
(defconstant $kFontFrenchLanguage 1)
(defconstant $kFontGermanLanguage 2)
(defconstant $kFontItalianLanguage 3)
(defconstant $kFontDutchLanguage 4)
(defconstant $kFontSwedishLanguage 5)
(defconstant $kFontSpanishLanguage 6)
(defconstant $kFontDanishLanguage 7)
(defconstant $kFontPortugueseLanguage 8)
(defconstant $kFontNorwegianLanguage 9)
(defconstant $kFontHebrewLanguage 10)
(defconstant $kFontJapaneseLanguage 11)
(defconstant $kFontArabicLanguage 12)
(defconstant $kFontFinnishLanguage 13)
(defconstant $kFontGreekLanguage 14)
(defconstant $kFontIcelandicLanguage 15)
(defconstant $kFontMalteseLanguage 16)
(defconstant $kFontTurkishLanguage 17)
(defconstant $kFontCroatianLanguage 18)
(defconstant $kFontTradChineseLanguage 19)
(defconstant $kFontUrduLanguage 20)
(defconstant $kFontHindiLanguage 21)
(defconstant $kFontThaiLanguage 22)
(defconstant $kFontKoreanLanguage 23)
(defconstant $kFontLithuanianLanguage 24)
(defconstant $kFontPolishLanguage 25)
(defconstant $kFontHungarianLanguage 26)
(defconstant $kFontEstonianLanguage 27)
(defconstant $kFontLettishLanguage 28)
(defconstant $kFontLatvianLanguage 28)
(defconstant $kFontSaamiskLanguage 29)
(defconstant $kFontLappishLanguage 29)
(defconstant $kFontFaeroeseLanguage 30)
(defconstant $kFontFarsiLanguage 31)
(defconstant $kFontPersianLanguage 31)
(defconstant $kFontRussianLanguage 32)
(defconstant $kFontSimpChineseLanguage 33)
(defconstant $kFontFlemishLanguage 34)
(defconstant $kFontIrishLanguage 35)
(defconstant $kFontAlbanianLanguage 36)
(defconstant $kFontRomanianLanguage 37)
(defconstant $kFontCzechLanguage 38)
(defconstant $kFontSlovakLanguage 39)
(defconstant $kFontSlovenianLanguage 40)
(defconstant $kFontYiddishLanguage 41)
(defconstant $kFontSerbianLanguage 42)
(defconstant $kFontMacedonianLanguage 43)
(defconstant $kFontBulgarianLanguage 44)
(defconstant $kFontUkrainianLanguage 45)
(defconstant $kFontByelorussianLanguage 46)
(defconstant $kFontUzbekLanguage 47)
(defconstant $kFontKazakhLanguage 48)
(defconstant $kFontAzerbaijaniLanguage 49)
(defconstant $kFontAzerbaijanArLanguage 50)
(defconstant $kFontArmenianLanguage 51)
(defconstant $kFontGeorgianLanguage 52)
(defconstant $kFontMoldavianLanguage 53)
(defconstant $kFontKirghizLanguage 54)
(defconstant $kFontTajikiLanguage 55)
(defconstant $kFontTurkmenLanguage 56)
(defconstant $kFontMongolianLanguage 57)
(defconstant $kFontMongolianCyrLanguage 58)
(defconstant $kFontPashtoLanguage 59)
(defconstant $kFontKurdishLanguage 60)
(defconstant $kFontKashmiriLanguage 61)
(defconstant $kFontSindhiLanguage 62)
(defconstant $kFontTibetanLanguage 63)
(defconstant $kFontNepaliLanguage 64)
(defconstant $kFontSanskritLanguage 65)
(defconstant $kFontMarathiLanguage 66)
(defconstant $kFontBengaliLanguage 67)
(defconstant $kFontAssameseLanguage 68)
(defconstant $kFontGujaratiLanguage 69)
(defconstant $kFontPunjabiLanguage 70)
(defconstant $kFontOriyaLanguage 71)
(defconstant $kFontMalayalamLanguage 72)
(defconstant $kFontKannadaLanguage 73)
(defconstant $kFontTamilLanguage 74)
(defconstant $kFontTeluguLanguage 75)
(defconstant $kFontSinhaleseLanguage 76)
(defconstant $kFontBurmeseLanguage 77)
(defconstant $kFontKhmerLanguage 78)
(defconstant $kFontLaoLanguage 79)
(defconstant $kFontVietnameseLanguage 80)
(defconstant $kFontIndonesianLanguage 81)
(defconstant $kFontTagalogLanguage 82)
(defconstant $kFontMalayRomanLanguage 83)
(defconstant $kFontMalayArabicLanguage 84)
(defconstant $kFontAmharicLanguage 85)
(defconstant $kFontTigrinyaLanguage 86)
(defconstant $kFontGallaLanguage 87)
(defconstant $kFontOromoLanguage 87)
(defconstant $kFontSomaliLanguage 88)
(defconstant $kFontSwahiliLanguage 89)
(defconstant $kFontRuandaLanguage 90)
(defconstant $kFontRundiLanguage 91)
(defconstant $kFontChewaLanguage 92)
(defconstant $kFontMalagasyLanguage 93)
(defconstant $kFontEsperantoLanguage 94)
(defconstant $kFontWelshLanguage #x80)
(defconstant $kFontBasqueLanguage #x81)
(defconstant $kFontCatalanLanguage #x82)
(defconstant $kFontLatinLanguage #x83)
(defconstant $kFontQuechuaLanguage #x84)
(defconstant $kFontGuaraniLanguage #x85)
(defconstant $kFontAymaraLanguage #x86)
(defconstant $kFontTatarLanguage #x87)
(defconstant $kFontUighurLanguage #x88)
(defconstant $kFontDzongkhaLanguage #x89)
(defconstant $kFontJavaneseRomLanguage #x8A)
(defconstant $kFontSundaneseRomLanguage #x8B)
;  The following are special "don't care" values to be used in interfaces 

(defconstant $kFontNoPlatformCode -1)
(defconstant $kFontNoScriptCode -1)
(defconstant $kFontNoLanguageCode -1)
(defrecord sfntCMapSubHeader
   (format :UInt16)
   (length :UInt16)
   (languageID :UInt16)                         ;  base-1 
)

;type name? (%define-record :sfntCMapSubHeader (find-record-descriptor ':sfntCMapSubHeader))

(defconstant $sizeof_sfntCMapSubHeader 6)
(defrecord sfntCMapExtendedSubHeader
   (format :UInt16)
   (reserved :UInt16)
   (length :UInt32)
   (language :UInt32)
)

;type name? (%define-record :sfntCMapExtendedSubHeader (find-record-descriptor ':sfntCMapExtendedSubHeader))

(defconstant $sizeof_sfntCMapExtendedSubHeader 12)
(defrecord sfntCMapEncoding
   (platformID :UInt16)                         ;  base-0 
   (scriptID :UInt16)                           ;  base-0 
   (offset :UInt32)
)

;type name? (%define-record :sfntCMapEncoding (find-record-descriptor ':sfntCMapEncoding))

(defconstant $sizeof_sfntCMapEncoding 8)
(defrecord sfntCMapHeader
   (version :UInt16)
   (numTables :UInt16)
   (encoding (:array :sfntCMapEncoding 1))
)

;type name? (%define-record :sfntCMapHeader (find-record-descriptor ':sfntCMapHeader))

(defconstant $sizeof_sfntCMapHeader 4)
;  Name table 

(defconstant $nameFontTableTag :|name|)

(defconstant $kFontCopyrightName 0)
(defconstant $kFontFamilyName 1)
(defconstant $kFontStyleName 2)
(defconstant $kFontUniqueName 3)
(defconstant $kFontFullName 4)
(defconstant $kFontVersionName 5)
(defconstant $kFontPostscriptName 6)
(defconstant $kFontTrademarkName 7)
(defconstant $kFontManufacturerName 8)
(defconstant $kFontDesignerName 9)
(defconstant $kFontDescriptionName 10)
(defconstant $kFontVendorURLName 11)
(defconstant $kFontDesignerURLName 12)
(defconstant $kFontLicenseDescriptionName 13)
(defconstant $kFontLicenseInfoURLName 14)
(defconstant $kFontLastReservedName #xFF)
;  The following is a special "don't care" value to be used in interfaces 

(defconstant $kFontNoNameCode -1)
(defrecord sfntNameRecord
   (platformID :UInt16)                         ;  base-0 
   (scriptID :UInt16)                           ;  base-0 
   (languageID :UInt16)                         ;  base-0 
   (nameID :UInt16)                             ;  base-0 
   (length :UInt16)
   (offset :UInt16)
)

;type name? (%define-record :sfntNameRecord (find-record-descriptor ':sfntNameRecord))

(defconstant $sizeof_sfntNameRecord 12)
(defrecord sfntNameHeader
   (format :UInt16)
   (count :UInt16)
   (stringOffset :UInt16)
   (rec (:array :sfntNameRecord 1))
)

;type name? (%define-record :sfntNameHeader (find-record-descriptor ':sfntNameHeader))

(defconstant $sizeof_sfntNameHeader 6)
;  Fvar table - font variations 

(defconstant $variationFontTableTag :|fvar|)
;  These define each font variation 
(defrecord sfntVariationAxis
   (axisTag :FourCharCode)
   (minValue :signed-long)
   (defaultValue :signed-long)
   (maxValue :signed-long)
   (flags :SInt16)
   (nameID :SInt16)
)

;type name? (%define-record :sfntVariationAxis (find-record-descriptor ':sfntVariationAxis))

(defconstant $sizeof_sfntVariationAxis 20)
;  These are named locations in style-space for the user 
(defrecord sfntInstance
   (nameID :SInt16)
   (flags :SInt16)
   (coord (:array :signed-long 1))              ;  [axisCount] 
                                                ;  room to grow since the header carries a tupleSize field 
)

;type name? (%define-record :sfntInstance (find-record-descriptor ':sfntInstance))

(defconstant $sizeof_sfntInstance 4)
(defrecord sfntVariationHeader
   (version :signed-long)                       ;  1.0 Fixed 
   (offsetToData :UInt16)                       ;  to first axis = 16
   (countSizePairs :UInt16)                     ;  axis+inst = 2 
   (axisCount :UInt16)
   (axisSize :UInt16)
   (instanceCount :UInt16)
   (instanceSize :UInt16)
                                                ;  Éother <count,size> pairs 
   (axis (:array :sfntVariationAxis 1))         ;  [axisCount] 
   (instance (:array :sfntInstance 1))          ;  [instanceCount]  Éother arrays of data 
)

;type name? (%define-record :sfntVariationHeader (find-record-descriptor ':sfntVariationHeader))

(defconstant $sizeof_sfntVariationHeader 16)
;  Fdsc table - font descriptor 

(defconstant $descriptorFontTableTag :|fdsc|)
(defrecord sfntFontDescriptor
   (name :FourCharCode)
   (value :signed-long)
)

;type name? (%define-record :sfntFontDescriptor (find-record-descriptor ':sfntFontDescriptor))
(defrecord sfntDescriptorHeader
   (version :signed-long)                       ;  1.0 in Fixed 
   (descriptorCount :SInt32)
   (descriptor (:array :sfntFontDescriptor 1))
)

;type name? (%define-record :sfntDescriptorHeader (find-record-descriptor ':sfntDescriptorHeader))

(defconstant $sizeof_sfntDescriptorHeader 8)
;  Feat Table - layout feature table 

(defconstant $featureFontTableTag :|feat|)
(defrecord sfntFeatureName
   (featureType :UInt16)
   (settingCount :UInt16)
   (offsetToSettings :SInt32)
   (featureFlags :UInt16)
   (nameID :UInt16)
)

;type name? (%define-record :sfntFeatureName (find-record-descriptor ':sfntFeatureName))
(defrecord sfntFontFeatureSetting
   (setting :UInt16)
   (nameID :UInt16)
)

;type name? (%define-record :sfntFontFeatureSetting (find-record-descriptor ':sfntFontFeatureSetting))
(defrecord sfntFontRunFeature
   (featureType :UInt16)
   (setting :UInt16)
)

;type name? (%define-record :sfntFontRunFeature (find-record-descriptor ':sfntFontRunFeature))
(defrecord sfntFeatureHeader
   (version :SInt32)                            ;  1.0 
   (featureNameCount :UInt16)
   (featureSetCount :UInt16)
   (reserved :SInt32)                           ;  set to 0 
   (names (:array :sfntFeatureName 1))
   (settings (:array :sfntFontFeatureSetting 1))
   (runs (:array :sfntFontRunFeature 1))
)

;type name? (%define-record :sfntFeatureHeader (find-record-descriptor ':sfntFeatureHeader))
;  OS/2 Table 

(defconstant $os2FontTableTag :|OS/2|)
;   Special invalid glyph ID value, useful as a sentinel value, for example 

(defconstant $nonGlyphID #xFFFF)
;    Deprecated "don't care" values - use kFontNoPlatformCode, kFontNoScriptCode, 
;      kFontNoLanguageCode, kFontNoName instead
; 

(defconstant $kFontNoPlatform -1)
(defconstant $kFontNoScript -1)
(defconstant $kFontNoLanguage -1)
(defconstant $kFontNoName -1)
;   Data type used to access names from font name table 

(def-mactype :FontNameCode (find-mactype ':UInt32))
;  Data types for encoding components as used in interfaces 

(def-mactype :FontPlatformCode (find-mactype ':UInt32))

(def-mactype :FontScriptCode (find-mactype ':UInt32))

(def-mactype :FontLanguageCode (find-mactype ':UInt32))
; 
; **  FontVariation is used to specify a coordinate along a variation axis. The name
; **  identifies the axes to be applied, and value is the setting to be used.
; 
(defrecord FontVariation
   (name :FourCharCode)
   (value :signed-long)
)

;type name? (%define-record :FontVariation (find-record-descriptor ':FontVariation))
; #pragma options align=reset

; #endif /* __SFNTTYPES__ */


(provide-interface "SFNTTypes")