(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:UnicodeUtilities.h"
; at Sunday July 2,2006 7:23:25 pm.
; 
;      File:       CarbonCore/UnicodeUtilities.h
;  
;      Contains:   Types, constants, prototypes for Unicode Utilities (Unicode input and text utils)
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1997-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __UNICODEUTILITIES__
; #define __UNICODEUTILITIES__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __MACLOCALES__
#| #|
#include <CarbonCoreMacLocales.h>
#endif
|#
 |#
; #ifndef __TEXTCOMMON__
#| #|
#include <CarbonCoreTextCommon.h>
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
;    -------------------------------------------------------------------------------------------------
;    CONSTANTS & DATA STRUCTURES for UCKeyTranslate & UCKeyboardLayout ('uchr' resource)
;    -------------------------------------------------------------------------------------------------
; 
; 
;    -------------------------------------------------------------------------------------------------
;    UCKeyOutput & related stuff
;    The interpretation of UCKeyOutput depends on bits 15-14.
;    If they are 01, then bits 0-13 are an index in UCKeyStateRecordsIndex (resource-wide list).
;    If they are 10, then bits 0-13 are an index in UCKeySequenceDataIndex (resource-wide list),
;      or if UCKeySequenceDataIndex is not present or the index is beyond the end of the list,
;      then bits 0-15 are a single Unicode character.
;    Otherwise, bits 0-15 are a single Unicode character; a value of 0xFFFE-0xFFFF means no character
;      output.
;    UCKeyCharSeq is similar, but does not support indices in UCKeyStateRecordsIndex. For bits 15-14:
;    If they are 10, then bits 0-13 are an index in UCKeySequenceDataIndex (resource-wide list),
;      or if UCKeySequenceDataIndex is not present or the index is beyond the end of the list,
;      then bits 0-15 are a single Unicode character.
;    Otherwise, bits 0-15 are a single Unicode character; a value of 0xFFFE-0xFFFF means no character
;      output.
;    -------------------------------------------------------------------------------------------------
; 

(def-mactype :UCKeyOutput (find-mactype ':UInt16))

(def-mactype :UCKeyCharSeq (find-mactype ':UInt16))

(defconstant $kUCKeyOutputStateIndexMask #x4000)
(defconstant $kUCKeyOutputSequenceIndexMask #x8000)
(defconstant $kUCKeyOutputTestForIndexMask #xC000);  test bits 14-15

(defconstant $kUCKeyOutputGetIndexMask #x3FFF)  ;  get bits 0-13

; 
;    -------------------------------------------------------------------------------------------------
;    UCKeyStateRecord & related stuff
;    The UCKeyStateRecord information is used as follows. If the current state is zero,
;    output stateZeroCharData and set the state to stateZeroNextState. If the current state
;    is non-zero and there is an entry for it in stateEntryData, then output the corresponding
;    charData and set the state to nextState. Otherwise, output the state terminator from
;    UCKeyStateTerminators for the current state (or nothing if there is no UCKeyStateTerminators
;    table or it has no entry for the current state), then output stateZeroCharData and set the
;    state to stateZeroNextState.
;    -------------------------------------------------------------------------------------------------
; 
(defrecord UCKeyStateRecord
   (stateZeroCharData :UInt16)
   (stateZeroNextState :UInt16)
   (stateEntryCount :UInt16)
   (stateEntryFormat :UInt16)
                                                ;  This is followed by an array of stateEntryCount elements
                                                ;  in the specified format. Here we just show a dummy array.
   (stateEntryData (:array :UInt32 1))
)

;type name? (%define-record :UCKeyStateRecord (find-record-descriptor ':UCKeyStateRecord))
; 
;    Here are the codes for entry formats currently defined.
;    Each entry maps from curState to charData and nextState.
; 

(defconstant $kUCKeyStateEntryTerminalFormat 1)
(defconstant $kUCKeyStateEntryRangeFormat 2)
; 
;    For UCKeyStateEntryTerminal -
;    nextState is always 0, so we don't have a field for it
; 
(defrecord UCKeyStateEntryTerminal
   (curState :UInt16)
   (charData :UInt16)
)

;type name? (%define-record :UCKeyStateEntryTerminal (find-record-descriptor ':UCKeyStateEntryTerminal))
; 
;    For UCKeyStateEntryRange -
;    If curState >= curStateStart and curState <= curStateStart+curStateRange,
;    then it matches the entry, and we transform charData and nextState as follows:
;    If charData < 0xFFFE, then charData += (curState-curStateStart)*deltaMultiplier
;    If nextState != 0, then nextState += (curState-curStateStart)*deltaMultiplier
; 
(defrecord UCKeyStateEntryRange
   (curStateStart :UInt16)
   (curStateRange :UInt8)
   (deltaMultiplier :UInt8)
   (charData :UInt16)
   (nextState :UInt16)
)

;type name? (%define-record :UCKeyStateEntryRange (find-record-descriptor ':UCKeyStateEntryRange))
; 
;    -------------------------------------------------------------------------------------------------
;    UCKeyboardLayout & related stuff
;    The UCKeyboardLayout struct given here is only for the resource header. It specifies
;    offsets to the various subtables which each have their own structs, given below.
;    The keyboardTypeHeadList array selects table offsets that depend on keyboardType. The
;    first entry in keyboardTypeHeadList is the default entry, which will be used if the
;    keyboardType passed to UCKeyTranslate does not match any other entry - i.e. does not fall
;    within the range keyboardTypeFirst..keyboardTypeLast for some entry. The first entry
;    should have keyboardTypeFirst = keyboardTypeLast = 0.
;    -------------------------------------------------------------------------------------------------
; 
(defrecord UCKeyboardTypeHeader
   (keyboardTypeFirst :UInt32)                  ;  first keyboardType in this entry
   (keyboardTypeLast :UInt32)                   ;  last keyboardType in this entry
   (keyModifiersToTableNumOffset :UInt32)       ;  required
   (keyToCharTableIndexOffset :UInt32)          ;  required
   (keyStateRecordsIndexOffset :UInt32)         ;  0 => no table
   (keyStateTerminatorsOffset :UInt32)          ;  0 => no table
   (keySequenceDataIndexOffset :UInt32)         ;  0 => no table
)

;type name? (%define-record :UCKeyboardTypeHeader (find-record-descriptor ':UCKeyboardTypeHeader))
(defrecord UCKeyboardLayout
                                                ;  header only; other tables accessed via offsets
   (keyLayoutHeaderFormat :UInt16)              ;  =kUCKeyLayoutHeaderFormat
   (keyLayoutDataVersion :UInt16)               ;  0x0100 = 1.0, 0x0110 = 1.1, etc.
   (keyLayoutFeatureInfoOffset :UInt32)         ;  may be 0                       
   (keyboardTypeCount :UInt32)                  ;  Dimension for keyboardTypeHeadList[]     
   (keyboardTypeList (:array :UCKeyboardTypeHeader 1))
)

;type name? (%define-record :UCKeyboardLayout (find-record-descriptor ':UCKeyboardLayout))
;  -------------------------------------------------------------------------------------------------
(defrecord UCKeyLayoutFeatureInfo
   (keyLayoutFeatureInfoFormat :UInt16)         ;  =kUCKeyLayoutFeatureInfoFormat
   (reserved :UInt16)
   (maxOutputStringLength :UInt32)              ;  longest possible output string
)

;type name? (%define-record :UCKeyLayoutFeatureInfo (find-record-descriptor ':UCKeyLayoutFeatureInfo))
;  -------------------------------------------------------------------------------------------------
(defrecord UCKeyModifiersToTableNum
   (keyModifiersToTableNumFormat :UInt16)       ;  =kUCKeyModifiersToTableNumFormat
   (defaultTableNum :UInt16)                    ;  For modifier combos not in tableNum[]
   (modifiersCount :UInt32)                     ;  Dimension for tableNum[]
   (tableNum (:array :UInt8 1))
                                                ;  Then there is padding to a 4-byte boundary with bytes containing 0, if necessary.
)

;type name? (%define-record :UCKeyModifiersToTableNum (find-record-descriptor ':UCKeyModifiersToTableNum))
;  -------------------------------------------------------------------------------------------------
(defrecord UCKeyToCharTableIndex
   (keyToCharTableIndexFormat :UInt16)          ;  =kUCKeyToCharTableIndexFormat
   (keyToCharTableSize :UInt16)                 ;  Max keyCode (128 for ADB keyboards)
   (keyToCharTableCount :UInt32)                ;  Dimension for keyToCharTableOffsets[] (usually 6 to 12 tables)
   (keyToCharTableOffsets (:array :UInt32 1))
                                                ;  Each offset in keyToCharTableOffsets is from the beginning of the resource to a
                                                ;  table as follows:
                                                ;     UCKeyOutput       keyToCharData[keyToCharTableSize];
                                                ;  These tables follow the UCKeyToCharTableIndex.
                                                ;  Then there is padding to a 4-byte boundary with bytes containing 0, if necessary.
)

;type name? (%define-record :UCKeyToCharTableIndex (find-record-descriptor ':UCKeyToCharTableIndex))
;  -------------------------------------------------------------------------------------------------
(defrecord UCKeyStateRecordsIndex
   (keyStateRecordsIndexFormat :UInt16)         ;  =kUCKeyStateRecordsIndexFormat
   (keyStateRecordCount :UInt16)                ;  Dimension for keyStateRecordOffsets[]
   (keyStateRecordOffsets (:array :UInt32 1))
                                                ;  Each offset in keyStateRecordOffsets is from the beginning of the resource to a
                                                ;  UCKeyStateRecord. These UCKeyStateRecords follow the keyStateRecordOffsets[] array.
                                                ;  Then there is padding to a 4-byte boundary with bytes containing 0, if necessary.
)

;type name? (%define-record :UCKeyStateRecordsIndex (find-record-descriptor ':UCKeyStateRecordsIndex))
;  -------------------------------------------------------------------------------------------------
(defrecord UCKeyStateTerminators
   (keyStateTerminatorsFormat :UInt16)          ;  =kUCKeyStateTerminatorsFormat
   (keyStateTerminatorCount :UInt16)            ;  Dimension for keyStateTerminators[] (# of nonzero states)
   (keyStateTerminators (:array :UInt16 1))
                                                ;  Note: keyStateTerminators[0] is terminator for state 1, etc.
                                                ;  Then there is padding to a 4-byte boundary with bytes containing 0, if necessary.
)

;type name? (%define-record :UCKeyStateTerminators (find-record-descriptor ':UCKeyStateTerminators))
;  -------------------------------------------------------------------------------------------------
(defrecord UCKeySequenceDataIndex
   (keySequenceDataIndexFormat :UInt16)         ;  =kUCKeySequenceDataIndexFormat
   (charSequenceCount :UInt16)                  ;  Dimension of charSequenceOffsets[] is charSequenceCount+1
   (charSequenceOffsets (:array :UInt16 1))
                                                ;  Each offset in charSequenceOffsets is in bytes, from the beginning of
                                                ;  UCKeySequenceDataIndex to a sequence of UniChars; the next offset indicates the
                                                ;  end of the sequence. The UniChar sequences follow the UCKeySequenceDataIndex.
                                                ;  Then there is padding to a 4-byte boundary with bytes containing 0, if necessary.
)

;type name? (%define-record :UCKeySequenceDataIndex (find-record-descriptor ':UCKeySequenceDataIndex))
;  -------------------------------------------------------------------------------------------------
;  Current format codes for the various tables (bits 12-15 indicate which table)

(defconstant $kUCKeyLayoutHeaderFormat #x1002)
(defconstant $kUCKeyLayoutFeatureInfoFormat #x2001)
(defconstant $kUCKeyModifiersToTableNumFormat #x3001)
(defconstant $kUCKeyToCharTableIndexFormat #x4001)
(defconstant $kUCKeyStateRecordsIndexFormat #x5001)
(defconstant $kUCKeyStateTerminatorsFormat #x6001)
(defconstant $kUCKeySequenceDataIndexFormat #x7001)
; 
;    -------------------------------------------------------------------------------------------------
;    Constants for keyAction parameter in UCKeyTranslate() 
;    -------------------------------------------------------------------------------------------------
; 

(defconstant $kUCKeyActionDown 0)               ;  key is going down

(defconstant $kUCKeyActionUp 1)                 ;  key is going up

(defconstant $kUCKeyActionAutoKey 2)            ;  auto-key down

(defconstant $kUCKeyActionDisplay 3)            ;  get information for key display (as in Key Caps)      

; 
;    -------------------------------------------------------------------------------------------------
;    Bit assignments & masks for keyTranslateOptions parameter in UCKeyTranslate() 
;    -------------------------------------------------------------------------------------------------
; 

(defconstant $kUCKeyTranslateNoDeadKeysBit 0)   ;  Prevents setting any new dead-key states


(defconstant $kUCKeyTranslateNoDeadKeysMask 1)
; 
;    -------------------------------------------------------------------------------------------------
;    CONSTANTS & DATA STRUCTURES for Unicode Collation
;    -------------------------------------------------------------------------------------------------
; 
;  constant for LocaleOperationClass

(defconstant $kUnicodeCollationClass :|ucol|)

(def-mactype :CollatorRef (find-mactype '(:pointer :OpaqueCollatorRef)))

(def-mactype :UCCollateOptions (find-mactype ':UInt32))
;  Sensitivity options

(defconstant $kUCCollateComposeInsensitiveMask 2)
(defconstant $kUCCollateWidthInsensitiveMask 4)
(defconstant $kUCCollateCaseInsensitiveMask 8)
(defconstant $kUCCollateDiacritInsensitiveMask 16);  Other general options 

(defconstant $kUCCollatePunctuationSignificantMask #x8000);  Number-handling options 

(defconstant $kUCCollateDigitsOverrideMask #x10000)
(defconstant $kUCCollateDigitsAsNumberMask #x20000)

(defconstant $kUCCollateStandardOptions 6)
; 
;    Special values to specify various invariant orders for UCCompareTextNoLocale.
;    These values use the high 8 bits of UCCollateOptions.
; 

(defconstant $kUCCollateTypeHFSExtended 1)
;  These constants are used for masking and shifting the invariant order type.

(defconstant $kUCCollateTypeSourceMask #xFF)
(defconstant $kUCCollateTypeShiftBits 24)

(defconstant $kUCCollateTypeMask #xFF000000)

(def-mactype :UCCollationValue (find-mactype ':UInt32))
; 
;    -------------------------------------------------------------------------------------------------
;    CONSTANTS & DATA STRUCTURES for Unicode TextBreak
;    -------------------------------------------------------------------------------------------------
; 
;  constant for LocaleOperationClass

(defconstant $kUnicodeTextBreakClass :|ubrk|)

(def-mactype :TextBreakLocatorRef (find-mactype '(:pointer :OpaqueTextBreakLocatorRef)))
; 
;  *  UCTextBreakType
;  *  
;  *  Discussion:
;  *    Specifies kinds of text boundaries.
;  

(def-mactype :UCTextBreakType (find-mactype ':UInt32))
; 
;    * If the bit specified by this mask is set, boundaries of characters
;    * may be located (with surrogate pairs treated as a single
;    * character).
;    

(defconstant $kUCTextBreakCharMask 1)
; 
;    * If the bit specified by this mask is set, boundaries of character
;    * clusters may be located. A cluster is a group of characters that
;    * should be treated as single text element for editing operations
;    * such as cursor movement. Typically this includes groups such as a
;    * base character followed by a sequence of combining characters, for
;    * example, a Hangul syllable represented as a sequence of conjoining
;    * jamo characters or an Indic consonant cluster.
;    

(defconstant $kUCTextBreakClusterMask 4)
; 
;    * If the bit specified by this mask is set, boundaries of words may
;    * be located. This can be used to determine what to highlight as the
;    * result of a double-click.
;    

(defconstant $kUCTextBreakWordMask 16)
(defconstant $kUCTextBreakLineMask 64)
; 
;    * If the bit specified by this mask is set, boundaries of paragraphs
;    * may be located. This just finds the next hard-line break as
;    * defined by the Unicode standard.
;    

(defconstant $kUCTextBreakParagraphMask #x100)

(def-mactype :UCTextBreakOptions (find-mactype ':UInt32))

(defconstant $kUCTextBreakLeadingEdgeMask 1)
(defconstant $kUCTextBreakGoBackwardsMask 2)
(defconstant $kUCTextBreakIterateMask 4)
; 
;    -------------------------------------------------------------------------------------------------
;    FUNCTION PROTOTYPES
;    -------------------------------------------------------------------------------------------------
; 
; 
;  *  UCKeyTranslate()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeUtilitiesCoreLib 8.5 and later
;  

(deftrap-inline "_UCKeyTranslate" 
   ((keyLayoutPtr (:pointer :UCKeyboardLayout))
    (virtualKeyCode :UInt16)
    (keyAction :UInt16)
    (modifierKeyState :UInt32)
    (keyboardType :UInt32)
    (keyTranslateOptions :UInt32)
    (deadKeyState (:pointer :UInt32))
    (maxStringLength :UInt32)
    (actualStringLength (:pointer :UniCharCount))
    (unicodeString (:pointer :UniChar))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Standard collation functions
; 
;  *  UCCreateCollator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeUtilitiesLib 8.6 and later
;  

(deftrap-inline "_UCCreateCollator" 
   ((locale (:pointer :OpaqueLocaleRef))
    (opVariant :FourCharCode)
    (options :UInt32)
    (collatorRef (:pointer :COLLATORREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  UCGetCollationKey()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeUtilitiesLib 8.6 and later
;  

(deftrap-inline "_UCGetCollationKey" 
   ((collatorRef (:pointer :OpaqueCollatorRef))
    (textPtr (:pointer :UniChar))
    (textLength :UInt32)
    (maxKeySize :UInt32)
    (actualKeySize (:pointer :ItemCount))
    (collationKey (:pointer :UCCOLLATIONVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  UCCompareCollationKeys()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeUtilitiesCoreLib 8.6 and later
;  

(deftrap-inline "_UCCompareCollationKeys" 
   ((key1Ptr (:pointer :UCCOLLATIONVALUE))
    (key1Length :UInt32)
    (key2Ptr (:pointer :UCCOLLATIONVALUE))
    (key2Length :UInt32)
    (equivalent (:pointer :Boolean))
    (order (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  UCCompareText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeUtilitiesLib 8.6 and later
;  

(deftrap-inline "_UCCompareText" 
   ((collatorRef (:pointer :OpaqueCollatorRef))
    (text1Ptr (:pointer :UniChar))
    (text1Length :UInt32)
    (text2Ptr (:pointer :UniChar))
    (text2Length :UInt32)
    (equivalent (:pointer :Boolean))
    (order (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  UCDisposeCollator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeUtilitiesLib 8.6 and later
;  

(deftrap-inline "_UCDisposeCollator" 
   ((collatorRef (:pointer :COLLATORREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Simple collation using default locale
; 
;  *  UCCompareTextDefault()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeUtilitiesLib 8.6 and later
;  

(deftrap-inline "_UCCompareTextDefault" 
   ((options :UInt32)
    (text1Ptr (:pointer :UniChar))
    (text1Length :UInt32)
    (text2Ptr (:pointer :UniChar))
    (text2Length :UInt32)
    (equivalent (:pointer :Boolean))
    (order (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Simple locale-independent collation
; 
;  *  UCCompareTextNoLocale()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeUtilitiesCoreLib 8.6 and later
;  

(deftrap-inline "_UCCompareTextNoLocale" 
   ((options :UInt32)
    (text1Ptr (:pointer :UniChar))
    (text1Length :UInt32)
    (text2Ptr (:pointer :UniChar))
    (text2Length :UInt32)
    (equivalent (:pointer :Boolean))
    (order (:pointer :SInt32))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Standard text break (text boundary) functions
; 
;  *  UCCreateTextBreakLocator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeUtilitiesLib 9.0 and later
;  

(deftrap-inline "_UCCreateTextBreakLocator" 
   ((locale (:pointer :OpaqueLocaleRef))
    (opVariant :FourCharCode)
    (breakTypes :UInt32)
    (breakRef (:pointer :TEXTBREAKLOCATORREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  UCFindTextBreak()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeUtilitiesLib 9.0 and later
;  

(deftrap-inline "_UCFindTextBreak" 
   ((breakRef (:pointer :OpaqueTextBreakLocatorRef))
    (breakType :UInt32)
    (options :UInt32)
    (textPtr (:pointer :UniChar))
    (textLength :UInt32)
    (startOffset :UInt32)
    (breakOffset (:pointer :UNICHARARRAYOFFSET))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  UCDisposeTextBreakLocator()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in UnicodeUtilitiesLib 9.0 and later
;  

(deftrap-inline "_UCDisposeTextBreakLocator" 
   ((breakRef (:pointer :TEXTBREAKLOCATORREF))
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

; #endif /* __UNICODEUTILITIES__ */


(provide-interface "UnicodeUtilities")