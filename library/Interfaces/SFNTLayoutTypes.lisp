(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SFNTLayoutTypes.h"
; at Sunday July 2,2006 7:23:45 pm.
; 
;      File:       ATS/SFNTLayoutTypes.h
;  
;      Contains:   SFNT file layout structures and constants.
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
; #ifndef __SFNTLAYOUTTYPES__
; #define __SFNTLAYOUTTYPES__
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
;  ----------------------------------------------------------------------------------------- 
;  CONSTANTS 
; 
;     The following values can be used to set run feature values. Note that unless the
;     feature is defaulted differently in different fonts, the zero value for the
;     selectors represents the default value.  Check the following URL site for further info:
;     "http://fonts.apple.com/Registry"
; 
; 
;  *  Summary:
;  *    Feature types
;  

(defconstant $kAllTypographicFeaturesType 0)
(defconstant $kLigaturesType 1)
(defconstant $kCursiveConnectionType 2)
(defconstant $kLetterCaseType 3)
(defconstant $kVerticalSubstitutionType 4)
(defconstant $kLinguisticRearrangementType 5)
(defconstant $kNumberSpacingType 6)
(defconstant $kSmartSwashType 8)
(defconstant $kDiacriticsType 9)
(defconstant $kVerticalPositionType 10)
(defconstant $kFractionsType 11)
(defconstant $kOverlappingCharactersType 13)
(defconstant $kTypographicExtrasType 14)
(defconstant $kMathematicalExtrasType 15)
(defconstant $kOrnamentSetsType 16)
(defconstant $kCharacterAlternativesType 17)
(defconstant $kDesignComplexityType 18)
(defconstant $kStyleOptionsType 19)
(defconstant $kCharacterShapeType 20)
(defconstant $kNumberCaseType 21)
(defconstant $kTextSpacingType 22)
(defconstant $kTransliterationType 23)
(defconstant $kAnnotationType 24)
(defconstant $kKanaSpacingType 25)
(defconstant $kIdeographicSpacingType 26)
(defconstant $kUnicodeDecompositionType 27)
(defconstant $kRubyKanaType 28)
(defconstant $kCJKSymbolAlternativesType 29)
(defconstant $kIdeographicAlternativesType 30)
(defconstant $kCJKVerticalRomanPlacementType 31)
(defconstant $kItalicCJKRomanType 32)
(defconstant $kCJKRomanSpacingType 103)
(defconstant $kLastFeatureType -1)
; 
;  *  Summary:
;  *    Selectors for feature type kAllTypographicFeaturesType
;  

(defconstant $kAllTypeFeaturesOnSelector 0)
(defconstant $kAllTypeFeaturesOffSelector 1)
; 
;  *  Summary:
;  *    Selectors for feature type kLigaturesType
;  

(defconstant $kRequiredLigaturesOnSelector 0)
(defconstant $kRequiredLigaturesOffSelector 1)
(defconstant $kCommonLigaturesOnSelector 2)
(defconstant $kCommonLigaturesOffSelector 3)
(defconstant $kRareLigaturesOnSelector 4)
(defconstant $kRareLigaturesOffSelector 5)
(defconstant $kLogosOnSelector 6)
(defconstant $kLogosOffSelector 7)
(defconstant $kRebusPicturesOnSelector 8)
(defconstant $kRebusPicturesOffSelector 9)
(defconstant $kDiphthongLigaturesOnSelector 10)
(defconstant $kDiphthongLigaturesOffSelector 11)
(defconstant $kSquaredLigaturesOnSelector 12)
(defconstant $kSquaredLigaturesOffSelector 13)
(defconstant $kAbbrevSquaredLigaturesOnSelector 14)
(defconstant $kAbbrevSquaredLigaturesOffSelector 15)
(defconstant $kSymbolLigaturesOnSelector 16)
(defconstant $kSymbolLigaturesOffSelector 17)
; 
;  *  Summary:
;  *    Selectors for feature type kCursiveConnectionType
;  

(defconstant $kUnconnectedSelector 0)
(defconstant $kPartiallyConnectedSelector 1)
(defconstant $kCursiveSelector 2)
; 
;  *  Summary:
;  *    Selectors for feature type kLetterCaseType
;  

(defconstant $kUpperAndLowerCaseSelector 0)
(defconstant $kAllCapsSelector 1)
(defconstant $kAllLowerCaseSelector 2)
(defconstant $kSmallCapsSelector 3)
(defconstant $kInitialCapsSelector 4)
(defconstant $kInitialCapsAndSmallCapsSelector 5)
; 
;  *  Summary:
;  *    Selectors for feature type kVerticalSubstitutionType
;  

(defconstant $kSubstituteVerticalFormsOnSelector 0)
(defconstant $kSubstituteVerticalFormsOffSelector 1)
; 
;  *  Summary:
;  *    Selectors for feature type kLinguisticRearrangementType
;  

(defconstant $kLinguisticRearrangementOnSelector 0)
(defconstant $kLinguisticRearrangementOffSelector 1)
; 
;  *  Summary:
;  *    Selectors for feature type kNumberSpacingType
;  

(defconstant $kMonospacedNumbersSelector 0)
(defconstant $kProportionalNumbersSelector 1)
(defconstant $kThirdWidthNumbersSelector 2)
(defconstant $kQuarterWidthNumbersSelector 3)
; 
;  *  Summary:
;  *    Selectors for feature type kSmartSwashType
;  

(defconstant $kWordInitialSwashesOnSelector 0)
(defconstant $kWordInitialSwashesOffSelector 1)
(defconstant $kWordFinalSwashesOnSelector 2)
(defconstant $kWordFinalSwashesOffSelector 3)
(defconstant $kLineInitialSwashesOnSelector 4)
(defconstant $kLineInitialSwashesOffSelector 5)
(defconstant $kLineFinalSwashesOnSelector 6)
(defconstant $kLineFinalSwashesOffSelector 7)
(defconstant $kNonFinalSwashesOnSelector 8)
(defconstant $kNonFinalSwashesOffSelector 9)
; 
;  *  Summary:
;  *    Selectors for feature type kDiacriticsType
;  

(defconstant $kShowDiacriticsSelector 0)
(defconstant $kHideDiacriticsSelector 1)
(defconstant $kDecomposeDiacriticsSelector 2)
; 
;  *  Summary:
;  *    Selectors for feature type kVerticalPositionType
;  

(defconstant $kNormalPositionSelector 0)
(defconstant $kSuperiorsSelector 1)
(defconstant $kInferiorsSelector 2)
(defconstant $kOrdinalsSelector 3)
; 
;  *  Summary:
;  *    Selectors for feature type kFractionsType
;  

(defconstant $kNoFractionsSelector 0)
(defconstant $kVerticalFractionsSelector 1)
(defconstant $kDiagonalFractionsSelector 2)
; 
;  *  Summary:
;  *    Selectors for feature type kOverlappingCharactersType
;  

(defconstant $kPreventOverlapOnSelector 0)
(defconstant $kPreventOverlapOffSelector 1)
; 
;  *  Summary:
;  *    Selectors for feature type kTypographicExtrasType
;  

(defconstant $kHyphensToEmDashOnSelector 0)
(defconstant $kHyphensToEmDashOffSelector 1)
(defconstant $kHyphenToEnDashOnSelector 2)
(defconstant $kHyphenToEnDashOffSelector 3)
(defconstant $kSlashedZeroOnSelector 4)
(defconstant $kSlashedZeroOffSelector 5)
(defconstant $kFormInterrobangOnSelector 6)
(defconstant $kFormInterrobangOffSelector 7)
(defconstant $kSmartQuotesOnSelector 8)
(defconstant $kSmartQuotesOffSelector 9)
(defconstant $kPeriodsToEllipsisOnSelector 10)
(defconstant $kPeriodsToEllipsisOffSelector 11)
; 
;  *  Summary:
;  *    Selectors for feature type kMathematicalExtrasType
;  

(defconstant $kHyphenToMinusOnSelector 0)
(defconstant $kHyphenToMinusOffSelector 1)
(defconstant $kAsteriskToMultiplyOnSelector 2)
(defconstant $kAsteriskToMultiplyOffSelector 3)
(defconstant $kSlashToDivideOnSelector 4)
(defconstant $kSlashToDivideOffSelector 5)
(defconstant $kInequalityLigaturesOnSelector 6)
(defconstant $kInequalityLigaturesOffSelector 7)
(defconstant $kExponentsOnSelector 8)
(defconstant $kExponentsOffSelector 9)
; 
;  *  Summary:
;  *    Selectors for feature type kOrnamentSetsType
;  

(defconstant $kNoOrnamentsSelector 0)
(defconstant $kDingbatsSelector 1)
(defconstant $kPiCharactersSelector 2)
(defconstant $kFleuronsSelector 3)
(defconstant $kDecorativeBordersSelector 4)
(defconstant $kInternationalSymbolsSelector 5)
(defconstant $kMathSymbolsSelector 6)
; 
;  *  Summary:
;  *    Selectors for feature type kCharacterAlternativesType
;  

(defconstant $kNoAlternatesSelector 0)
; 
;  *  Summary:
;  *    Selectors for feature type kDesignComplexityType
;  

(defconstant $kDesignLevel1Selector 0)
(defconstant $kDesignLevel2Selector 1)
(defconstant $kDesignLevel3Selector 2)
(defconstant $kDesignLevel4Selector 3)
(defconstant $kDesignLevel5Selector 4)
; 
;  *  Summary:
;  *    Selectors for feature type kStyleOptionsType
;  

(defconstant $kNoStyleOptionsSelector 0)
(defconstant $kDisplayTextSelector 1)
(defconstant $kEngravedTextSelector 2)
(defconstant $kIlluminatedCapsSelector 3)
(defconstant $kTitlingCapsSelector 4)
(defconstant $kTallCapsSelector 5)
; 
;  *  Summary:
;  *    Selectors for feature type kCharacterShapeType
;  

(defconstant $kTraditionalCharactersSelector 0)
(defconstant $kSimplifiedCharactersSelector 1)
(defconstant $kJIS1978CharactersSelector 2)
(defconstant $kJIS1983CharactersSelector 3)
(defconstant $kJIS1990CharactersSelector 4)
(defconstant $kTraditionalAltOneSelector 5)
(defconstant $kTraditionalAltTwoSelector 6)
(defconstant $kTraditionalAltThreeSelector 7)
(defconstant $kTraditionalAltFourSelector 8)
(defconstant $kTraditionalAltFiveSelector 9)
(defconstant $kExpertCharactersSelector 10)
; 
;  *  Summary:
;  *    Selectors for feature type kNumberCaseType
;  

(defconstant $kLowerCaseNumbersSelector 0)
(defconstant $kUpperCaseNumbersSelector 1)
; 
;  *  Summary:
;  *    Selectors for feature type kTextSpacingType
;  

(defconstant $kProportionalTextSelector 0)
(defconstant $kMonospacedTextSelector 1)
(defconstant $kHalfWidthTextSelector 2)
; 
;  *  Summary:
;  *    Selectors for feature type kTransliterationType
;  

(defconstant $kNoTransliterationSelector 0)
(defconstant $kHanjaToHangulSelector 1)
(defconstant $kHiraganaToKatakanaSelector 2)
(defconstant $kKatakanaToHiraganaSelector 3)
(defconstant $kKanaToRomanizationSelector 4)
(defconstant $kRomanizationToHiraganaSelector 5)
(defconstant $kRomanizationToKatakanaSelector 6)
(defconstant $kHanjaToHangulAltOneSelector 7)
(defconstant $kHanjaToHangulAltTwoSelector 8)
(defconstant $kHanjaToHangulAltThreeSelector 9)
; 
;  *  Summary:
;  *    Selectors for feature type kAnnotationType
;  

(defconstant $kNoAnnotationSelector 0)
(defconstant $kBoxAnnotationSelector 1)
(defconstant $kRoundedBoxAnnotationSelector 2)
(defconstant $kCircleAnnotationSelector 3)
(defconstant $kInvertedCircleAnnotationSelector 4)
(defconstant $kParenthesisAnnotationSelector 5)
(defconstant $kPeriodAnnotationSelector 6)
(defconstant $kRomanNumeralAnnotationSelector 7)
(defconstant $kDiamondAnnotationSelector 8)
(defconstant $kInvertedBoxAnnotationSelector 9)
(defconstant $kInvertedRoundedBoxAnnotationSelector 10)
; 
;  *  Summary:
;  *    Selectors for feature type kKanaSpacingType
;  

(defconstant $kFullWidthKanaSelector 0)
(defconstant $kProportionalKanaSelector 1)
; 
;  *  Summary:
;  *    Selectors for feature type kIdeographicSpacingType
;  

(defconstant $kFullWidthIdeographsSelector 0)
(defconstant $kProportionalIdeographsSelector 1)
(defconstant $kHalfWidthIdeographsSelector 2)
; 
;  *  Summary:
;  *    Selectors for feature type kUnicodeDecompositionType
;  

(defconstant $kCanonicalCompositionOnSelector 0)
(defconstant $kCanonicalCompositionOffSelector 1)
(defconstant $kCompatibilityCompositionOnSelector 2)
(defconstant $kCompatibilityCompositionOffSelector 3)
(defconstant $kTranscodingCompositionOnSelector 4)
(defconstant $kTranscodingCompositionOffSelector 5)
; 
;  *  Summary:
;  *    Selectors for feature type kRubyKanaType
;  

(defconstant $kNoRubyKanaSelector 0)
(defconstant $kRubyKanaSelector 1)
; 
;  *  Summary:
;  *    Selectors for feature type kCJKSymbolAlternativesType
;  

(defconstant $kNoCJKSymbolAlternativesSelector 0)
(defconstant $kCJKSymbolAltOneSelector 1)
(defconstant $kCJKSymbolAltTwoSelector 2)
(defconstant $kCJKSymbolAltThreeSelector 3)
(defconstant $kCJKSymbolAltFourSelector 4)
(defconstant $kCJKSymbolAltFiveSelector 5)
; 
;  *  Summary:
;  *    Selectors for feature type kIdeographicAlternativesType
;  

(defconstant $kNoIdeographicAlternativesSelector 0)
(defconstant $kIdeographicAltOneSelector 1)
(defconstant $kIdeographicAltTwoSelector 2)
(defconstant $kIdeographicAltThreeSelector 3)
(defconstant $kIdeographicAltFourSelector 4)
(defconstant $kIdeographicAltFiveSelector 5)
; 
;  *  Summary:
;  *    Selectors for feature type kCJKVerticalRomanPlacementType
;  

(defconstant $kCJKVerticalRomanCenteredSelector 0)
(defconstant $kCJKVerticalRomanHBaselineSelector 1)
; 
;  *  Summary:
;  *    Selectors for feature type kItalicCJKRomanType
;  

(defconstant $kNoCJKItalicRomanSelector 0)
(defconstant $kCJKItalicRomanSelector 1)
; 
;  *  Summary:
;  *    Selectors for feature type kCJKRomanSpacingType
;  

(defconstant $kHalfWidthCJKRomanSelector 0)
(defconstant $kProportionalCJKRomanSelector 1)
(defconstant $kDefaultCJKRomanSelector 2)
(defconstant $kFullWidthCJKRomanSelector 3)
;  --------------------------------------------------------------------------- 
;  ---------------- Table Specific Typedefs and Constants -------------------- 
;  --------------------------------------------------------------------------- 
;  FORMATS FOR TABLE: lookup tables - used within various other tables 

(defconstant $kSFNTLookupSimpleArray 0)         ;  a simple array indexed by glyph code 

(defconstant $kSFNTLookupSegmentSingle 2)       ;  segment mapping to single value 

(defconstant $kSFNTLookupSegmentArray 4)        ;  segment mapping to lookup array 

(defconstant $kSFNTLookupSingleTable 6)         ;  sorted list of glyph, value pairs 

(defconstant $kSFNTLookupTrimmedArray 8)        ;  a simple trimmed array indexed by glyph code 


(def-mactype :SFNTLookupTableFormat (find-mactype ':UInt16))

(def-mactype :SFNTLookupValue (find-mactype ':UInt16))

(def-mactype :SFNTLookupOffset (find-mactype ':UInt16))

(def-mactype :SFNTLookupKind (find-mactype ':UInt32))
; 
;     A BinarySearchHeader defines the five standard fields needed to perform quick
;     lookups in a lookup table (note that using UInt16s, and not ItemCounts or
;     similar types, is important here, since these tables are in fonts, and the
;     documented font formats specify 16-bit quantities).
; 
(defrecord SFNTLookupBinarySearchHeader
   (unitSize :UInt16)                           ;  size of a unit in bytes 
   (nUnits :UInt16)                             ;  number of units in table 
   (searchRange :UInt16)                        ;  (largest power of two <= nUnits) * unitSize 
   (entrySelector :UInt16)                      ;  log2 (largest power of two <= nUnits) 
   (rangeShift :UInt16)                         ;  (nUnits - largest power of two <= nUnits) * unitSize 
)

;type name? (%define-record :SFNTLookupBinarySearchHeader (find-record-descriptor ':SFNTLookupBinarySearchHeader))
;  A format 0 lookup table maps all glyphs in the font to lookup values 
(defrecord SFNTLookupArrayHeader
   (lookupValues (:array :UInt16 1))
)

;type name? (%define-record :SFNTLookupArrayHeader (find-record-descriptor ':SFNTLookupArrayHeader))
;  A format 8 lookup table maps some range of glyphs in the font to lookup values 
(defrecord SFNTLookupTrimmedArrayHeader
   (firstGlyph :UInt16)
   (count :UInt16)
   (valueArray (:array :UInt16 1))
)

;type name? (%define-record :SFNTLookupTrimmedArrayHeader (find-record-descriptor ':SFNTLookupTrimmedArrayHeader))
; 
;     Format 2 and format 4 lookup tables map ranges of glyphs to either single lookup
;     values (format 2), or per-glyph lookup values (format 4). Since both formats
;     use the same kind of data, only one unified set of segment-related structures
;     is defined.
; 
(defrecord SFNTLookupSegment
   (lastGlyph :UInt16)
   (firstGlyph :UInt16)
   (value (:array :UInt16 1))
)

;type name? (%define-record :SFNTLookupSegment (find-record-descriptor ':SFNTLookupSegment))
(defrecord SFNTLookupSegmentHeader
   (binSearch :SFNTLookupBinarySearchHeader)
   (segments (:array :SFNTLookupSegment 1))
)

;type name? (%define-record :SFNTLookupSegmentHeader (find-record-descriptor ':SFNTLookupSegmentHeader))
;  A format 6 lookup table maps single glyphs to lookup values. 
(defrecord SFNTLookupSingle
   (glyph :UInt16)
   (value (:array :UInt16 1))
)

;type name? (%define-record :SFNTLookupSingle (find-record-descriptor ':SFNTLookupSingle))
(defrecord SFNTLookupSingleHeader
   (binSearch :SFNTLookupBinarySearchHeader)
   (entries (:array :SFNTLookupSingle 1))
)

;type name? (%define-record :SFNTLookupSingleHeader (find-record-descriptor ':SFNTLookupSingleHeader))
;  The format-specific part of the subtable header 
(defrecord SFNTLookupFormatSpecificHeader
   (:variant
   (
   (theArray :SFNTLookupArrayHeader)
   )
   (
   (segment :SFNTLookupSegmentHeader)
   )
   (
   (single :SFNTLookupSingleHeader)
   )
   (
   (trimmedArray :SFNTLookupTrimmedArrayHeader)
   )
   )
)

;type name? (%define-record :SFNTLookupFormatSpecificHeader (find-record-descriptor ':SFNTLookupFormatSpecificHeader))
;  The overall subtable header 
(defrecord SFNTLookupTable
   (format :UInt16)                             ;  table format 
   (fsHeader :SFNTLookupFormatSpecificHeader)   ;  format specific header 
)

;type name? (%define-record :SFNTLookupTable (find-record-descriptor ':SFNTLookupTable))

(def-mactype :SFNTLookupTablePtr (find-mactype '(:pointer :SFNTLookupTable)))

(def-mactype :SFNTLookupTableHandle (find-mactype '(:handle :SFNTLookupTable)))
;  --------------------------------------------------------------------------- 
;  GENERAL FORMATS FOR STATE TABLES -- prefix "ST" 

(defconstant $kSTClassEndOfText 0)
(defconstant $kSTClassOutOfBounds 1)
(defconstant $kSTClassDeletedGlyph 2)
(defconstant $kSTClassEndOfLine 3)
(defconstant $kSTSetMark #x8000)
(defconstant $kSTNoAdvance #x4000)
(defconstant $kSTMarkEnd #x2000)
(defconstant $kSTLigActionMask #x3FFF)
(defconstant $kSTRearrVerbMask 15)

(def-mactype :STClass (find-mactype ':UInt8))

(def-mactype :STEntryIndex (find-mactype ':UInt8))
(defrecord STHeader
   (filler :UInt8)
   (nClasses :UInt8)
   (classTableOffset :UInt16)
   (stateArrayOffset :UInt16)
   (entryTableOffset :UInt16)
)

;type name? (%define-record :STHeader (find-record-descriptor ':STHeader))
(defrecord STClassTable
   (firstGlyph :UInt16)
   (nGlyphs :UInt16)
   (classes (:array :UInt8 1))
)

;type name? (%define-record :STClassTable (find-record-descriptor ':STClassTable))
(defrecord STEntryZero
   (newState :UInt16)
   (flags :UInt16)
)

;type name? (%define-record :STEntryZero (find-record-descriptor ':STEntryZero))
(defrecord STEntryOne
   (newState :UInt16)
   (flags :UInt16)
   (offset1 :UInt16)
)

;type name? (%define-record :STEntryOne (find-record-descriptor ':STEntryOne))
(defrecord STEntryTwo
   (newState :UInt16)
   (flags :UInt16)
   (offset1 :UInt16)
   (offset2 :UInt16)
)

;type name? (%define-record :STEntryTwo (find-record-descriptor ':STEntryTwo))
;  --------------------------------------------------------------------------- 
;  GENERAL FORMATS FOR STATE TABLES to be used with 'morx' tables -- prefix "STX" 

(defconstant $kSTXHasLigAction #x2000)

(def-mactype :STXClass (find-mactype ':UInt16))

(def-mactype :STXStateIndex (find-mactype ':UInt16))

(def-mactype :STXEntryIndex (find-mactype ':UInt16))
(defrecord STXHeader
   (nClasses :UInt32)
   (classTableOffset :UInt32)
   (stateArrayOffset :UInt32)
   (entryTableOffset :UInt32)
)

;type name? (%define-record :STXHeader (find-record-descriptor ':STXHeader))

(%define-record :STXClassTable (find-record-descriptor ':SFNTLookupTable))
(defrecord STXEntryZero
   (newState :UInt16)
   (flags :UInt16)
)

;type name? (%define-record :STXEntryZero (find-record-descriptor ':STXEntryZero))
(defrecord STXEntryOne
   (newState :UInt16)
   (flags :UInt16)
   (index1 :UInt16)
)

;type name? (%define-record :STXEntryOne (find-record-descriptor ':STXEntryOne))
(defrecord STXEntryTwo
   (newState :UInt16)
   (flags :UInt16)
   (index1 :UInt16)
   (index2 :UInt16)
)

;type name? (%define-record :STXEntryTwo (find-record-descriptor ':STXEntryTwo))
;  --------------------------------------------------------------------------- 
;  FORMATS FOR TABLE: 'lcar' 
;  CONSTANTS 

(defconstant $kLCARTag #x6C636172)              ;  'lcar' 

(defconstant $kLCARCurrentVersion #x10000)      ;  current version number for 'lcar' table 

(defconstant $kLCARLinearFormat 0)
(defconstant $kLCARCtlPointFormat 1)
;  TYPES 
(defrecord LcarCaretClassEntry
   (count :UInt16)
   (partials (:array :UInt16 1))                ;  these are either FUnits or control-point numbers 
)

;type name? (%define-record :LcarCaretClassEntry (find-record-descriptor ':LcarCaretClassEntry))
(defrecord LcarCaretTable
   (version :signed-long)
   (format :UInt16)
   (lookup :SFNTLookupTable)
)

;type name? (%define-record :LcarCaretTable (find-record-descriptor ':LcarCaretTable))

(def-mactype :LcarCaretTablePtr (find-mactype '(:pointer :LcarCaretTable)))
;  --------------------------------------------------------------------------- 
;  FORMATS FOR TABLE: 'just' 
;  CONSTANTS 

(defconstant $kJUSTTag #x6A757374)              ;  'just' 

(defconstant $kJUSTCurrentVersion #x10000)
(defconstant $kJUSTStandardFormat 0)
(defconstant $kJUSTnoGlyphcode #xFFFF)          ;  used in a pcConditionalAddAction 

(defconstant $kJUSTpcDecompositionAction 0)
(defconstant $kJUSTpcUnconditionalAddAction 1)
(defconstant $kJUSTpcConditionalAddAction 2)
(defconstant $kJUSTpcGlyphStretchAction 3)
(defconstant $kJUSTpcDuctilityAction 4)
(defconstant $kJUSTpcGlyphRepeatAddAction 5)
;  Justification priority levels 

(defconstant $kJUSTKashidaPriority 0)
(defconstant $kJUSTSpacePriority 1)
(defconstant $kJUSTLetterPriority 2)
(defconstant $kJUSTNullPriority 3)
(defconstant $kJUSTPriorityCount 4)
;  Justification flags 

(defconstant $kJUSTOverridePriority #x8000)
(defconstant $kJUSTOverrideLimits #x4000)
(defconstant $kJUSTOverrideUnlimited #x2000)
(defconstant $kJUSTUnlimited #x1000)
(defconstant $kJUSTPriorityMask 3)
;  TYPES 

(def-mactype :JustPCActionType (find-mactype ':UInt16))

(def-mactype :JustificationFlags (find-mactype ':UInt16))
;  A JustPCDecompositionAction defines a ligature decomposition action. 
(defrecord JustPCDecompositionAction
   (lowerLimit :signed-long)
   (upperLimit :signed-long)
   (order :UInt16)
   (count :UInt16)
   (glyphs (:array :UInt16 1))
)

;type name? (%define-record :JustPCDecompositionAction (find-record-descriptor ':JustPCDecompositionAction))
;  A JUSTPCUnconditionalAddAction defines an unconditional glyph add action. 

(def-mactype :JustPCUnconditionalAddAction (find-mactype ':UInt16))
; 
;     A JUSTPCConditionalAddAction defines a glyph substitution and add action. If the addGlyph
;     is equal to kJUSTnoGlyphcode, then no glyph will be added, and the justification for
;     the line will be redone.
; 
(defrecord JustPCConditionalAddAction
   (substThreshhold :signed-long)               ;  threshhold of growth factor at which subst occurs 
   (addGlyph :UInt16)
   (substGlyph :UInt16)
)

;type name? (%define-record :JustPCConditionalAddAction (find-record-descriptor ':JustPCConditionalAddAction))
;  A PCDuctilityAction defines a ductile axis along which the glyph will be varied. 
(defrecord JustPCDuctilityAction
   (ductilityAxis :UInt32)
   (minimumLimit :signed-long)
   (noStretchValue :signed-long)
   (maximumLimit :signed-long)
)

;type name? (%define-record :JustPCDuctilityAction (find-record-descriptor ':JustPCDuctilityAction))
; 
;     A PCGlyphRepetitionAction defines a glyph which will not be stretched or otherwise
;     transformed, but rather which will be emplaced however many times are needed to fill
;     the needed gap.
; 
(defrecord JustPCGlyphRepeatAddAction
   (flags :UInt16)
   (glyph :UInt16)
)

;type name? (%define-record :JustPCGlyphRepeatAddAction (find-record-descriptor ':JustPCGlyphRepeatAddAction))
;  PCActionSubrecords contain the actual postcompensation actions. 
(defrecord JustPCActionSubrecord
   (theClass :UInt16)                           ;  justification class value associated with this rec 
   (theType :UInt16)
   (length :UInt32)
   (data :UInt32)                               ;  not really a UInt32; cast as ptr to appropriate action 
)

;type name? (%define-record :JustPCActionSubrecord (find-record-descriptor ':JustPCActionSubrecord))
;  The set of postcompensation records is defined in a PCAction struct. 
(defrecord JustPCAction
   (actionCount :UInt32)                        ;  long for alignment purposes 
   (actions (:array :JustPCActionSubrecord 1))
)

;type name? (%define-record :JustPCAction (find-record-descriptor ':JustPCAction))
; 
;     JustWidthDeltaEntry is the justification table entry structure.  The justClass value (which is
;     actually limited to 7 bits by the state table structure) is defined as a long for PPC alignment reasons.
; 
(defrecord JustWidthDeltaEntry
   (justClass :UInt32)
   (beforeGrowLimit :signed-long)               ;  ems AW can grow by at most on LT 
   (beforeShrinkLimit :signed-long)             ;  ems AW can shrink by at most on LT 
   (afterGrowLimit :signed-long)                ;  ems AW can grow by at most on RB 
   (afterShrinkLimit :signed-long)              ;  ems AW can shrink by at most on RB 
   (growFlags :UInt16)                          ;  flags controlling grow case 
   (shrinkFlags :UInt16)                        ;  flags controlling shrink case 
)

;type name? (%define-record :JustWidthDeltaEntry (find-record-descriptor ':JustWidthDeltaEntry))
(defrecord JustWidthDeltaGroup
   (count :UInt32)
   (entries (:array :JustWidthDeltaEntry 1))
)

;type name? (%define-record :JustWidthDeltaGroup (find-record-descriptor ':JustWidthDeltaGroup))
;  Overall structure of a postcompensation table is defined in PostcompTable. 
(defrecord JustPostcompTable
   (lookupTable :SFNTLookupTable)
                                                ;  action records here 
)

;type name? (%define-record :JustPostcompTable (find-record-descriptor ':JustPostcompTable))
(defrecord JustDirectionTable
   (justClass :UInt16)                          ;  offset to state table (0=none) 
   (widthDeltaClusters :UInt16)                 ;  offset to clusters 
   (postcomp :UInt16)                           ;  offset to postcomp table (0=none) 
   (lookup :SFNTLookupTable)
)

;type name? (%define-record :JustDirectionTable (find-record-descriptor ':JustDirectionTable))
(defrecord JustTable
   (version :signed-long)
   (format :UInt16)
   (horizHeaderOffset :UInt16)
   (vertHeaderOffset :UInt16)
)

;type name? (%define-record :JustTable (find-record-descriptor ':JustTable))
;  --------------------------------------------------------------------------- 
;  FORMATS FOR TABLE: 'opbd' 
;  CONSTANTS 

(defconstant $kOPBDTag #x6F706264)              ;  'opbd' 

(defconstant $kOPBDCurrentVersion #x10000)
(defconstant $kOPBDDistanceFormat 0)
(defconstant $kOPBDControlPointFormat 1)
;  TYPES 

(def-mactype :OpbdTableFormat (find-mactype ':UInt16))
; 
;     The OpbdSideValues struct is the lookup result from the FindSingle call for the
;     optical tables. It contains the 4 FUnit values that are relevant to the specified
;     glyph, or the 4 control gxPoint values.
; 
(defrecord OpbdSideValues
   (leftSideShift :SInt16)
   (topSideShift :SInt16)
   (rightSideShift :SInt16)
   (bottomSideShift :SInt16)
)

;type name? (%define-record :OpbdSideValues (find-record-descriptor ':OpbdSideValues))
(defrecord OpbdTable
   (version :signed-long)
   (format :UInt16)
   (lookupTable :SFNTLookupTable)
)

;type name? (%define-record :OpbdTable (find-record-descriptor ':OpbdTable))
;  --------------------------------------------------------------------------- 
;  FORMATS FOR TABLE: 'mort' 
;  CONSTANTS 

(defconstant $kMORTTag #x6D6F7274)              ;  'mort' 

(defconstant $kMORTCurrentVersion #x10000)      ;  current version number for 'mort' table 
;  Coverage masks 

(defconstant $kMORTCoverVertical #x8000)
(defconstant $kMORTCoverDescending #x4000)
(defconstant $kMORTCoverIgnoreVertical #x2000)
(defconstant $kMORTCoverTypeMask 15)            ;  Subtable types 

(defconstant $kMORTRearrangementType 0)
(defconstant $kMORTContextualType 1)
(defconstant $kMORTLigatureType 2)
(defconstant $kMORTSwashType 4)
(defconstant $kMORTInsertionType 5)             ;  Ligature subtable constants 

(defconstant $kMORTLigLastAction #x80000000)
(defconstant $kMORTLigStoreLigature #x40000000)
(defconstant $kMORTLigFormOffsetMask #x3FFFFFFF)
(defconstant $kMORTLigFormOffsetShift 2)        ;  Rearrangement subtable actions 

(defconstant $kMORTraNoAction 0)                ;     no action   

(defconstant $kMORTraxA 1)                      ;       Ax => xA    

(defconstant $kMORTraDx 2)                      ;       xD => Dx    

(defconstant $kMORTraDxA 3)                     ;      AxD => DxA   

(defconstant $kMORTraxAB 4)                     ;    ABx => xAB   

(defconstant $kMORTraxBA 5)                     ;    ABx => xBA   

(defconstant $kMORTraCDx 6)                     ;    xCD => CDx   

(defconstant $kMORTraDCx 7)                     ;    xCD => DCx   

(defconstant $kMORTraCDxA 8)                    ;   AxCD => CDxA  

(defconstant $kMORTraDCxA 9)                    ;   AxCD => DCxA  

(defconstant $kMORTraDxAB 10)                   ;   ABxD => DxAB  

(defconstant $kMORTraDxBA 11)                   ;   ABxD => DxBA  

(defconstant $kMORTraCDxAB 12)                  ;  ABxCD => CDxAB 

(defconstant $kMORTraCDxBA 13)                  ;  ABxCD => CDxBA 

(defconstant $kMORTraDCxAB 14)                  ;  ABxCD => DCxAB 

(defconstant $kMORTraDCxBA 15)                  ;  ABxCD => DCxBA 
;  Insertion subtable constants 

(defconstant $kMORTDoInsertionsBefore #x80)
(defconstant $kMORTIsSplitVowelPiece 64)
(defconstant $kMORTInsertionsCountMask 63)
(defconstant $kMORTCurrInsertKashidaLike #x2000)
(defconstant $kMORTMarkInsertKashidaLike #x1000)
(defconstant $kMORTCurrInsertBefore #x800)
(defconstant $kMORTMarkInsertBefore #x400)
(defconstant $kMORTMarkJustTableCountMask #x3F80)
(defconstant $kMORTMarkJustTableCountShift 7)   ;  JustTableIndex for marked character 

(defconstant $kMORTCurrJustTableCountMask 127)
(defconstant $kMORTCurrJustTableCountShift 0)   ;  JustTableIndex for current character 

(defconstant $kMORTCurrInsertCountMask #x3E0)
(defconstant $kMORTCurrInsertCountShift 5)      ;  count to insert after current glyphRec 

(defconstant $kMORTMarkInsertCountMask 31)
(defconstant $kMORTMarkInsertCountShift 0)      ;  count to insert after marked glyphRec 

;  TYPES 

(def-mactype :MortSubtableMaskFlags (find-mactype ':UInt32))

(def-mactype :MortLigatureActionEntry (find-mactype ':UInt32))
(defrecord MortRearrangementSubtable
   (header :STHeader)
)

;type name? (%define-record :MortRearrangementSubtable (find-record-descriptor ':MortRearrangementSubtable))
(defrecord MortContextualSubtable
   (header :STHeader)
   (substitutionTableOffset :UInt16)
)

;type name? (%define-record :MortContextualSubtable (find-record-descriptor ':MortContextualSubtable))
(defrecord MortLigatureSubtable
   (header :STHeader)
   (ligatureActionTableOffset :UInt16)
   (componentTableOffset :UInt16)
   (ligatureTableOffset :UInt16)
)

;type name? (%define-record :MortLigatureSubtable (find-record-descriptor ':MortLigatureSubtable))
(defrecord MortSwashSubtable
   (lookup :SFNTLookupTable)
)

;type name? (%define-record :MortSwashSubtable (find-record-descriptor ':MortSwashSubtable))
(defrecord MortInsertionSubtable
   (header :STHeader)
)

;type name? (%define-record :MortInsertionSubtable (find-record-descriptor ':MortInsertionSubtable))
(defrecord MortSpecificSubtable
   (:variant
   (
   (rearrangement :MortRearrangementSubtable)
   )
   (
   (contextual :MortContextualSubtable)
   )
   (
   (ligature :MortLigatureSubtable)
   )
   (
   (swash :MortSwashSubtable)
   )
   (
   (insertion :MortInsertionSubtable)
   )
   )
)

;type name? (%define-record :MortSpecificSubtable (find-record-descriptor ':MortSpecificSubtable))
(defrecord MortSubtable
   (length :UInt16)
   (coverage :UInt16)
   (flags :UInt32)
   (u :MortSpecificSubtable)
)

;type name? (%define-record :MortSubtable (find-record-descriptor ':MortSubtable))
(defrecord MortFeatureEntry
   (featureType :UInt16)
   (featureSelector :UInt16)
   (enableFlags :UInt32)
   (disableFlags :UInt32)
)

;type name? (%define-record :MortFeatureEntry (find-record-descriptor ':MortFeatureEntry))
(defrecord MortChain
   (defaultFlags :UInt32)                       ;  default flags for this chain 
   (length :UInt32)                             ;  byte length of this chain 
   (nFeatures :UInt16)                          ;  number of feature entries 
   (nSubtables :UInt16)                         ;  number of subtables 
   (featureEntries (:array :MortFeatureEntry 1))
                                                ;  the subtables follow 
)

;type name? (%define-record :MortChain (find-record-descriptor ':MortChain))
(defrecord MortTable
   (version :signed-long)
   (nChains :UInt32)
   (chains (:array :MortChain 1))
)

;type name? (%define-record :MortTable (find-record-descriptor ':MortTable))
;  --------------------------------------------------------------------------- 
;  FORMATS FOR TABLE: 'morx' (version 2 and beyond metamorphosis tables) 
;  CONSTANTS 

(defconstant $kMORXTag #x6D6F7278)              ;  'morx' 

(defconstant $kMORXCurrentVersion #x20000)      ;  version number for current 'morx' table 
;  Coverage masks 

(defconstant $kMORXCoverVertical #x80000000)
(defconstant $kMORXCoverDescending #x40000000)
(defconstant $kMORXCoverIgnoreVertical #x20000000)
(defconstant $kMORXCoverTypeMask #xFF)
;  TYPES 
(defrecord MorxRearrangementSubtable
   (header :STXHeader)
)

;type name? (%define-record :MorxRearrangementSubtable (find-record-descriptor ':MorxRearrangementSubtable))
(defrecord MorxContextualSubtable
   (header :STXHeader)
   (substitutionTableOffset :UInt32)
)

;type name? (%define-record :MorxContextualSubtable (find-record-descriptor ':MorxContextualSubtable))
(defrecord MorxLigatureSubtable
   (header :STXHeader)
   (ligatureActionTableOffset :UInt32)
   (componentTableOffset :UInt32)
   (ligatureTableOffset :UInt32)
)

;type name? (%define-record :MorxLigatureSubtable (find-record-descriptor ':MorxLigatureSubtable))
(defrecord MorxInsertionSubtable
   (header :STXHeader)
   (insertionGlyphTableOffset :UInt32)
)

;type name? (%define-record :MorxInsertionSubtable (find-record-descriptor ':MorxInsertionSubtable))
(defrecord MorxSpecificSubtable
   (:variant
   (
   (rearrangement :MorxRearrangementSubtable)
   )
   (
   (contextual :MorxContextualSubtable)
   )
   (
   (ligature :MorxLigatureSubtable)
   )
   (
   (swash :MortSwashSubtable)
   )
   (
   (insertion :MorxInsertionSubtable)
   )
   )
)

;type name? (%define-record :MorxSpecificSubtable (find-record-descriptor ':MorxSpecificSubtable))
(defrecord MorxSubtable
   (length :UInt32)
   (coverage :UInt32)
   (flags :UInt32)
   (u :MorxSpecificSubtable)
)

;type name? (%define-record :MorxSubtable (find-record-descriptor ':MorxSubtable))
(defrecord MorxChain
   (defaultFlags :UInt32)                       ;  default flags for this chain 
   (length :UInt32)                             ;  byte length of this chain 
   (nFeatures :UInt32)                          ;  number of feature entries 
   (nSubtables :UInt32)                         ;  number of subtables 
   (featureEntries (:array :MortFeatureEntry 1))
                                                ;  the subtables follow 
)

;type name? (%define-record :MorxChain (find-record-descriptor ':MorxChain))
(defrecord MorxTable
   (version :signed-long)
   (nChains :UInt32)
   (chains (:array :MorxChain 1))
)

;type name? (%define-record :MorxTable (find-record-descriptor ':MorxTable))
;  --------------------------------------------------------------------------- 
;  FORMATS FOR TABLE: 'prop' 
;  CONSTANTS 

(defconstant $kPROPTag #x70726F70)              ;  'prop' 

(defconstant $kPROPCurrentVersion #x30000)      ;  current version number for 'prop' table 

(defconstant $kPROPPairOffsetShift 8)
(defconstant $kPROPPairOffsetSign 7)
(defconstant $kPROPIsFloaterMask #x8000)        ;  glyph is floater 

(defconstant $kPROPCanHangLTMask #x4000)        ;  glyph can hang left/top 

(defconstant $kPROPCanHangRBMask #x2000)        ;  glyph can hang right/bottom 

(defconstant $kPROPUseRLPairMask #x1000)        ;  if glyph lands in RL streak, use paired glyph 

(defconstant $kPROPPairOffsetMask #xF00)        ;  4-bit signed offset to other pair member 

(defconstant $kPROPRightConnectMask #x80)       ;  glyph connects to glyph on right 

(defconstant $kPROPZeroReserved 96)             ;  must be zero 

(defconstant $kPROPDirectionMask 31)            ;  direction bits 

;  These are the Unicode direction classes (plus the Special European Number class). 

(defconstant $kPROPLDirectionClass 0)           ;  Left-to-Right 

(defconstant $kPROPRDirectionClass 1)           ;  Right-to-Left 

(defconstant $kPROPALDirectionClass 2)          ;  Right-to-Left Arabic Letter 

(defconstant $kPROPENDirectionClass 3)          ;  European Number 

(defconstant $kPROPESDirectionClass 4)          ;  European Number Seperator 

(defconstant $kPROPETDirectionClass 5)          ;  European Number Terminator 

(defconstant $kPROPANDirectionClass 6)          ;  Arabic Number 

(defconstant $kPROPCSDirectionClass 7)          ;  Common Number Seperator 

(defconstant $kPROPPSDirectionClass 8)          ;  Paragraph Seperator (also referred to as Block Separator) 

(defconstant $kPROPSDirectionClass 9)           ;  Segment Seperator 

(defconstant $kPROPWSDirectionClass 10)         ;  Whitespace 

(defconstant $kPROPONDirectionClass 11)         ;  Other Neutral 

(defconstant $kPROPSENDirectionClass 12)        ;  Special European Number (not a Unicode class) 

(defconstant $kPROPLREDirectionClass 13)        ;  Left-to-Right Embeding 

(defconstant $kPROPLRODirectionClass 14)        ;  Left-to-Right Override 

(defconstant $kPROPRLEDirectionClass 15)        ;  Right-to-Left Embeding 

(defconstant $kPROPRLODirectionClass 16)        ;  Right-to-Left Override 

(defconstant $kPROPPDFDirectionClass 17)        ;  Pop Directional Format 

(defconstant $kPROPNSMDirectionClass 18)        ;  Non-Spacing Mark 

(defconstant $kPROPBNDirectionClass 19)         ;  Boundary Neutral 

(defconstant $kPROPNumDirectionClasses 20)      ;  Number of Unicode directional types + Special European Number 

;  TYPES 

(def-mactype :PropCharProperties (find-mactype ':UInt16))
(defrecord PropTable
   (version :signed-long)
   (format :UInt16)
   (defaultProps :UInt16)
   (lookup :SFNTLookupTable)
)

;type name? (%define-record :PropTable (find-record-descriptor ':PropTable))
(defrecord PropLookupSegment
   (lastGlyph :UInt16)
   (firstGlyph :UInt16)
   (value :UInt16)
)

;type name? (%define-record :PropLookupSegment (find-record-descriptor ':PropLookupSegment))
(defrecord PropLookupSingle
   (glyph :UInt16)
   (props :UInt16)
)

;type name? (%define-record :PropLookupSingle (find-record-descriptor ':PropLookupSingle))
;  --------------------------------------------------------------------------- 
;  FORMATS FOR TABLE: 'trak' 
;  CONSTANTS 

(defconstant $kTRAKTag #x7472616B)              ;  'trak' 

(defconstant $kTRAKCurrentVersion #x10000)      ;  current version number for 'trak' table 

(defconstant $kTRAKUniformFormat 0)             ;     kTRAKPerGlyphFormat         = 2

;  TYPES 

(def-mactype :TrakValue (find-mactype ':SInt16))
(defrecord TrakTableEntry
   (track :signed-long)
   (nameTableIndex :UInt16)
   (sizesOffset :UInt16)                        ;  offset to array of TrackingValues 
)

;type name? (%define-record :TrakTableEntry (find-record-descriptor ':TrakTableEntry))
(defrecord TrakTableData
   (nTracks :UInt16)
   (nSizes :UInt16)
   (sizeTableOffset :UInt32)
   (trakTable (:array :TrakTableEntry 1))
)

;type name? (%define-record :TrakTableData (find-record-descriptor ':TrakTableData))
(defrecord TrakTable
   (version :signed-long)
   (format :UInt16)
   (horizOffset :UInt16)
   (vertOffset :UInt16)
)

;type name? (%define-record :TrakTable (find-record-descriptor ':TrakTable))
;  --------------------------------------------------------------------------- 
;  FORMATS FOR TABLE: 'kern' 
;  CONSTANTS 

(defconstant $kKERNTag #x6B65726E)              ;  'kern' 

(defconstant $kKERNCurrentVersion #x10000)
(defconstant $kKERNVertical #x8000)             ;  set if this table has vertical kerning information 

(defconstant $kKERNResetCrossStream #x8000)     ;  this value in a cross-stream table means reset to zero 

(defconstant $kKERNCrossStream #x4000)          ;  set if this table contains cross-stream kerning values 

(defconstant $kKERNVariation #x2000)            ;  set if this table contains variation kerning values 

(defconstant $kKERNUnusedBits #x1F00)           ;  UNUSED, MUST BE ZERO 

(defconstant $kKERNFormatMask #xFF)             ;  format of this subtable 


(defconstant $kKERNOrderedList 0)               ;  ordered list of kerning pairs 

(defconstant $kKERNStateTable 1)                ;  state table for n-way contextual kerning 

(defconstant $kKERNSimpleArray 2)               ;  simple n X m array of kerning values 

(defconstant $kKERNIndexArray 3)                ;  modifed version of SimpleArray 

;  Message Type Flags 

(defconstant $kKERNLineStart 1)                 ;  Array of glyphs starts a line 

(defconstant $kKERNLineEndKerning 2)            ;  Array of glyphs ends a line 

(defconstant $kKERNNoCrossKerning 4)            ;  Prohibit cross kerning 

(defconstant $kKERNNotesRequested 8)            ;  Caller wants kerning notes 

(defconstant $kKERNNoStakeNote 1)               ;  Indicates a glyph was involved in a kerning pair/group 

(defconstant $kKERNCrossStreamResetNote 2)      ;  Indicates a return-to-baseline in cross-stream kerning 

(defconstant $kKERNNotApplied 1)                ;  All kerning values were zero, kerning call had no effect 

;  TYPES 

(def-mactype :KernTableFormat (find-mactype ':UInt8))

(def-mactype :KernSubtableInfo (find-mactype ':UInt16))

(def-mactype :KernKerningValue (find-mactype ':SInt16))

(def-mactype :KernArrayOffset (find-mactype ':UInt16))
;  header for version 0 kerning table 
(defrecord KernVersion0Header
   (version :UInt16)                            ;  font version number (will be 0!) 
   (nTables :UInt16)                            ;  number of subtables present 
   (firstSubtable (:array :UInt16 1))           ;  first subtable starts here 
)

;type name? (%define-record :KernVersion0Header (find-record-descriptor ':KernVersion0Header))
;  Header for a kerning table 
(defrecord KernTableHeader
   (version :signed-long)                       ;  font version number (currently 1.0) 
   (nTables :SInt32)                            ;  number of subtables present 
   (firstSubtable (:array :UInt16 1))           ;  first subtable starts here 
)

;type name? (%define-record :KernTableHeader (find-record-descriptor ':KernTableHeader))

(def-mactype :KernTableHeaderPtr (find-mactype '(:pointer :KernTableHeader)))

(def-mactype :KernTableHeaderHandle (find-mactype '(:handle :KernTableHeader)))
; 
;     F O R M A T   S P E C I F I C   D E F I N I T I O N S
; 
;     kernOrderedList:
;     
;     The table is a sorted list of [left glyph, right glyph, value] triples.
;     There's enough information in the header so that the list can be
;     efficiently binary searched. 
; 
;  defines a single kerning pair of Glyphcodes  
(defrecord KernKerningPair
   (left :UInt16)
   (right :UInt16)
)

;type name? (%define-record :KernKerningPair (find-record-descriptor ':KernKerningPair))
;  a single list entry 
(defrecord KernOrderedListEntry
   (pair :KernKerningPair)                      ;  the kerning pair 
   (value :SInt16)                              ;  the kerning value for the above pair 
)

;type name? (%define-record :KernOrderedListEntry (find-record-descriptor ':KernOrderedListEntry))

(def-mactype :KernOrderedListEntryPtr (find-mactype '(:pointer :KernOrderedListEntry)))
;  the header information for binary searching the list 
(defrecord KernOrderedListHeader
   (nPairs :UInt16)                             ;  number of kerning pairs in table 
   (searchRange :UInt16)                        ;  (largest power of two <= nPairs) * entry size 
   (entrySelector :UInt16)                      ;  log2 (largest power of two <= nPairs) 
   (rangeShift :UInt16)                         ;  (nPairs - largest power of two <= nPairs) * entry size 
   (table (:array :UInt16 1))                   ;  entries are first glyph, second glyph, and value 
)

;type name? (%define-record :KernOrderedListHeader (find-record-descriptor ':KernOrderedListHeader))
;  KernStateTable: like the the generic state tables 
(defrecord KernStateHeader
   (header :STHeader)                           ;  state table header 
   (valueTable :UInt16)                         ;  offset to kerning value table 
   (firstTable (:array :UInt8 1))               ;  first table starts here 
)

;type name? (%define-record :KernStateHeader (find-record-descriptor ':KernStateHeader))
(defrecord KernStateEntry
   (newState :UInt16)
   (flags :UInt16)                              ;  flags per above enum 
)

;type name? (%define-record :KernStateEntry (find-record-descriptor ':KernStateEntry))
; 
;     Kern offset table header.
;     The offset table is a trimmed array from firstGlyph to limitGlyph.
;     Glyphs outside of this range should get zero for right-hand glyphs
;     and the offset of the beginning of the kerning array for left-hand glyphs.
; 
(defrecord KernOffsetTable
   (firstGlyph :UInt16)                         ;  first glyph in class range 
   (nGlyphs :UInt16)                            ;  number of glyphs in class range 
   (offsetTable (:array :UInt16 1))             ;  offset table starts here 
)

;type name? (%define-record :KernOffsetTable (find-record-descriptor ':KernOffsetTable))

(def-mactype :KernOffsetTablePtr (find-mactype '(:pointer :KernOffsetTable)))
;  Header information for accessing offset tables and kerning array 
; 
;     KernSimpleArray:
;     
;     The array is an nXm array of kenring values. Each row in the array
;     represents one left-hand glyph, and each column one right-hand glyph.
;     The zeroth row and column always represent glyphs that are out of bounds
;     and will always contain zero.
;     
;     A pair is looked up by indexing the left-hand glyph through the left
;     offset table, the right-hand glyph through the right offset table,
;     adding both offsets to the starting address of the kerning array,
;     and fetching the kerning value pointed to.
; 
;  Kern offset table header. 
;  The offset table is a trimmed array from firstGlyph to limitGlyph. 
;  Glyphs outside of this range should get zero for right-hand glyphs 
;  and the offset of the beginning of the kerning array for left- 
;  hand glyphs. 
(defrecord KernSimpleArrayHeader
   (rowWidth :UInt16)                           ;  width, in bytes, of a row in the table 
   (leftOffsetTable :UInt16)                    ;  offset to left-hand offset table 
   (rightOffsetTable :UInt16)                   ;  offset to right-hand offset table 
   (theArray :UInt16)                           ;  offset to start of kerning array 
   (firstTable (:array :UInt16 1))              ;  first offset table starts here... 
)

;type name? (%define-record :KernSimpleArrayHeader (find-record-descriptor ':KernSimpleArrayHeader))
;  Index Array 
(defrecord KernIndexArrayHeader
   (glyphCount :UInt16)
   (kernValueCount :UInt8)
   (leftClassCount :UInt8)
   (rightClassCount :UInt8)
   (flags :UInt8)                               ;  set to 0 for now 
   (kernValue (:array :SInt16 1))               ;  actual kerning values reference by index in kernIndex 
   (leftClass (:array :UInt8 1))                ;  maps left glyph to offset into kern index 
   (rightClass (:array :UInt8 1))               ;  maps right glyph to offset into kern index 
   (kernIndex (:array :UInt8 1))                ;  contains indicies into kernValue 
)

;type name? (%define-record :KernIndexArrayHeader (find-record-descriptor ':KernIndexArrayHeader))
;  format specific part of subtable header 
(defrecord KernFormatSpecificHeader
   (:variant
   (
   (orderedList :KernOrderedListHeader)
   )
   (
   (stateTable :KernStateHeader)
   )
   (
   (simpleArray :KernSimpleArrayHeader)
   )
   (
   (indexArray :KernIndexArrayHeader)
   )
   )
)

;type name? (%define-record :KernFormatSpecificHeader (find-record-descriptor ':KernFormatSpecificHeader))
;  version 0 subtable header 
(defrecord KernVersion0SubtableHeader
   (version :UInt16)                            ;  kerning table version number 
   (length :UInt16)                             ;  length in bytes (including this header) 
   (stInfo :UInt16)                             ;  sub-table info 
   (fsHeader :KernFormatSpecificHeader)         ;  format specific sub-header 
)

;type name? (%define-record :KernVersion0SubtableHeader (find-record-descriptor ':KernVersion0SubtableHeader))
;  Overall Subtable header format 
(defrecord KernSubtableHeader
   (length :SInt32)                             ;  length in bytes (including this header) 
   (stInfo :UInt16)                             ;  subtable info 
   (tupleIndex :SInt16)                         ;  tuple index for variation subtables 
   (fsHeader :KernFormatSpecificHeader)         ;  format specific sub-header 
)

;type name? (%define-record :KernSubtableHeader (find-record-descriptor ':KernSubtableHeader))

(def-mactype :KernSubtableHeaderPtr (find-mactype '(:pointer :KernSubtableHeader)))
;  --------------------------------------------------------------------------- 
;  FORMATS FOR TABLE: 'bsln' 
;  CONSTANTS 

(defconstant $kBSLNTag #x62736C6E)              ;  'bsln' 

(defconstant $kBSLNCurrentVersion #x10000)      ;  current version number for 'bsln' table 

(defconstant $kBSLNDistanceFormatNoMap 0)
(defconstant $kBSLNDistanceFormatWithMap 1)
(defconstant $kBSLNControlPointFormatNoMap 2)
(defconstant $kBSLNControlPointFormatWithMap 3)
;  Baseline classes and constants 

(defconstant $kBSLNRomanBaseline 0)
(defconstant $kBSLNIdeographicCenterBaseline 1)
(defconstant $kBSLNIdeographicLowBaseline 2)
(defconstant $kBSLNHangingBaseline 3)
(defconstant $kBSLNMathBaseline 4)
(defconstant $kBSLNLastBaseline 31)
(defconstant $kBSLNNumBaselineClasses 32)
(defconstant $kBSLNNoBaselineOverride #xFF)
;  TYPES 

(def-mactype :BslnBaselineClass (find-mactype ':UInt32))
;  The BslnBaselineRecord array defines the baseline deltas for the line. 
(defrecord BslnBaselineRecord
   (contents (:array :signed-long 32))
)
; 
;     BslnFormat0Part is the format-specific data for a distance table with no mapping (i.e.
;     all the glyphs belong to the defaultBaseline).
; 
(defrecord BslnFormat0Part
   (deltas (:array :SInt16 32))
)

;type name? (%define-record :BslnFormat0Part (find-record-descriptor ':BslnFormat0Part))
;  BslnFormat1Part is the format-specific data for a distance table with a gxMapping. 
(defrecord BslnFormat1Part
   (deltas (:array :SInt16 32))
   (mappingData :SFNTLookupTable)
)

;type name? (%define-record :BslnFormat1Part (find-record-descriptor ':BslnFormat1Part))
; 
;     BslnFormat2Part is the format-specific data for a control-point table with no
;     mapping (i.e. all the glyphs belong to the defaultBaseline). It specifies a single
;     glyph to use and the set of control points in that glyph that designate each of
;     the baselines.
; 
(defrecord BslnFormat2Part
   (stdGlyph :UInt16)
   (ctlPoints (:array :SInt16 32))
)

;type name? (%define-record :BslnFormat2Part (find-record-descriptor ':BslnFormat2Part))
; 
;     BslnFormat3Part is the format-specific data for a distance table with a mapping. Like
;     format 2, it contains a single glyph and its set of control-point values for each
;     of the baselines.
; 
(defrecord BslnFormat3Part
   (stdGlyph :UInt16)
   (ctlPoints (:array :SInt16 32))
   (mappingData :SFNTLookupTable)
)

;type name? (%define-record :BslnFormat3Part (find-record-descriptor ':BslnFormat3Part))
;  The BslnFormatUnion is a union containing the format-specific parts of the baseline table. 
(defrecord BslnFormatUnion
   (:variant
   (
   (fmt0Part :BslnFormat0Part)
   )
   (
   (fmt1Part :BslnFormat1Part)
   )
   (
   (fmt2Part :BslnFormat2Part)
   )
   (
   (fmt3Part :BslnFormat3Part)
   )
   )
)

;type name? (%define-record :BslnFormatUnion (find-record-descriptor ':BslnFormatUnion))
;  The table format used in BaselineTable 

(def-mactype :BslnTableFormat (find-mactype ':UInt16))
;  BaselineTable defines the top-level format of the baseline table in the font. 
(defrecord BslnTable
   (version :signed-long)
   (format :UInt16)
   (defaultBaseline :UInt16)
   (parts :BslnFormatUnion)
)

;type name? (%define-record :BslnTable (find-record-descriptor ':BslnTable))

(def-mactype :BslnTablePtr (find-mactype '(:pointer :BslnTable)))
;  --------------------------------------------------------------------------- 
; #pragma options align=reset

; #endif /* __SFNTLAYOUTTYPES__ */


(provide-interface "SFNTLayoutTypes")