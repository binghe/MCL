(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:IntlResources.h"
; at Sunday July 2,2006 7:23:08 pm.
; 
;      File:       CarbonCore/IntlResources.h
;  
;      Contains:   International Resource definitions.
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1983-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __INTLRESOURCES__
; #define __INTLRESOURCES__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #pragma options align=mac68k
;  Bits in the itlcFlags byte 

(defconstant $itlcShowIcon 7)                   ; Show icon even if only one script

(defconstant $itlcDualCaret 6)                  ; Use dual caret for mixed direction text
;  Bits in the itlcSysFlags word 

(defconstant $itlcSysDirection 15)              ; System direction - left to right/right to left

;  One more flag in the itlcFlags byte 

(defconstant $itlcDisableKeyScriptSync 3)       ; Disable font and keyboard script synchrinozation

;  We should define masks, too. 
; Disable font and keyboard script synchrinozation mask

(defconstant $itlcDisableKeyScriptSyncMask 8)

(defconstant $tokLeftQuote 1)                   ;  NumberParts.data[] enumerators                             

(defconstant $tokRightQuote 2)                  ;   In general, these are NOT to be considered indices into the data[] array 

(defconstant $tokLeadPlacer 3)
(defconstant $tokLeader 4)
(defconstant $tokNonLeader 5)
(defconstant $tokZeroLead 6)
(defconstant $tokPercent 7)
(defconstant $tokPlusSign 8)
(defconstant $tokMinusSign 9)
(defconstant $tokThousands 10)
(defconstant $tokReserved 11)                   ;  11 is reserved field 

(defconstant $tokSeparator 12)
(defconstant $tokEscape 13)
(defconstant $tokDecPoint 14)
(defconstant $tokEPlus 15)
(defconstant $tokEMinus 16)
(defconstant $tokMaxSymbols 31)
(defconstant $curNumberPartsVersion 1)          ; current version of NumberParts record


(defconstant $currSymLead 16)
(defconstant $currNegSym 32)
(defconstant $currTrailingZ 64)
(defconstant $currLeadingZ #x80)

(defconstant $mdy 0)
(defconstant $dmy 1)
(defconstant $ymd 2)
(defconstant $myd 3)
(defconstant $dym 4)
(defconstant $ydm 5)

(def-mactype :DateOrders (find-mactype ':SInt8))

(defconstant $timeCycle24 0)                    ; time sequence 0:00 - 23:59

(defconstant $timeCycleZero 1)                  ; time sequence 0:00-11:59, 0:00 - 11:59

(defconstant $timeCycle12 #xFF)                 ; time sequence 12:00 - 11:59, 12:00 - 11:59

(defconstant $zeroCycle 1)                      ; old name for timeCycleZero

(defconstant $longDay 0)                        ; day of the month

(defconstant $longWeek 1)                       ; day of the week

(defconstant $longMonth 2)                      ; month of the year

(defconstant $longYear 3)                       ; year

(defconstant $supDay 1)                         ; suppress day of month

(defconstant $supWeek 2)                        ; suppress day of week

(defconstant $supMonth 4)                       ; suppress month

(defconstant $supYear 8)                        ; suppress year

(defconstant $dayLdingZ 32)
(defconstant $mntLdingZ 64)
(defconstant $century #x80)
(defconstant $secLeadingZ 32)
(defconstant $minLeadingZ 64)
(defconstant $hrLeadingZ #x80)
;  moved OffsetTable back here from QuickdrawText 
(defrecord OffPair
   (offFirst :SInt16)
   (offSecond :SInt16)
)

;type name? (%define-record :OffPair (find-record-descriptor ':OffPair))
(defrecord OffsetTable
   (contents (:array :OffPair 3))
)
(defrecord (Intl0Rec :handle)
   (decimalPt :character)                       ; decimal point character
   (thousSep :character)                        ; thousands separator character
   (listSep :character)                         ; list separator character
   (currSym1 :character)                        ; currency symbol
   (currSym2 :character)
   (currSym3 :character)
   (currFmt :UInt8)                             ; currency format flags
   (dateOrder :UInt8)                           ; order of short date elements: mdy, dmy, etc.
   (shrtDateFmt :UInt8)                         ; format flags for each short date element
   (dateSep :character)                         ; date separator character
   (timeCycle :UInt8)                           ; specifies time cycle: 0..23, 1..12, or 0..11
   (timeFmt :UInt8)                             ; format flags for each time element
   (mornStr (:array :character 4))              ; trailing string for AM if 12-hour cycle
   (eveStr (:array :character 4))               ; trailing string for PM if 12-hour cycle
   (timeSep :character)                         ; time separator character
   (time1Suff :character)                       ; trailing string for AM if 24-hour cycle
   (time2Suff :character)
   (time3Suff :character)
   (time4Suff :character)
   (time5Suff :character)                       ; trailing string for PM if 24-hour cycle
   (time6Suff :character)
   (time7Suff :character)
   (time8Suff :character)
   (metricSys :UInt8)                           ; 255 if metric, 0 if inches etc.
   (intl0Vers :SInt16)                          ; region code (hi byte) and version (lo byte)
)

;type name? (%define-record :Intl0Rec (find-record-descriptor ':Intl0Rec))

(def-mactype :Intl0Ptr (find-mactype '(:pointer :Intl0Rec)))

(def-mactype :Intl0Hndl (find-mactype '(:handle :Intl0Rec)))
(defrecord (Intl1Rec :handle)
   (days (:array :STR15 7))                     ; day names
   (months (:array :STR15 12))                  ; month names
   (suppressDay :UInt8)                         ; 255 for no day, or flags to suppress any element
   (lngDateFmt :UInt8)                          ; order of long date elements
   (dayLeading0 :UInt8)                         ; 255 for leading 0 in day number
   (abbrLen :UInt8)                             ; length for abbreviating names
   (st0 (:array :character 4))                  ; separator strings for long date format
   (st1 (:array :character 4))
   (st2 (:array :character 4))
   (st3 (:array :character 4))
   (st4 (:array :character 4))
   (intl1Vers :SInt16)                          ; region code (hi byte) and version (lo byte)
   (localRtn (:array :SInt16 1))                ; now a flag for opt extension
)

;type name? (%define-record :Intl1Rec (find-record-descriptor ':Intl1Rec))

(def-mactype :Intl1Ptr (find-mactype '(:pointer :Intl1Rec)))

(def-mactype :Intl1Hndl (find-mactype '(:handle :Intl1Rec)))
; fields for optional itl1 extension
(defrecord Itl1ExtRec
   (base :Intl1Rec)                             ; un-extended Intl1Rec
   (version :SInt16)
   (format :SInt16)
   (calendarCode :SInt16)                       ; calendar code for this itl1 resource
   (extraDaysTableOffset :signed-long)          ; offset in itl1 to extra days table
   (extraDaysTableLength :signed-long)          ; length of extra days table
   (extraMonthsTableOffset :signed-long)        ; offset in itl1 to extra months table
   (extraMonthsTableLength :signed-long)        ; length of extra months table
   (abbrevDaysTableOffset :signed-long)         ; offset in itl1 to abbrev days table
   (abbrevDaysTableLength :signed-long)         ; length of abbrev days table
   (abbrevMonthsTableOffset :signed-long)       ; offset in itl1 to abbrev months table
   (abbrevMonthsTableLength :signed-long)       ; length of abbrev months table
   (extraSepsTableOffset :signed-long)          ; offset in itl1 to extra seps table
   (extraSepsTableLength :signed-long)          ; length of extra seps table
   (tables (:array :SInt16 1))                  ; now a flag for opt extension
)

;type name? (%define-record :Itl1ExtRec (find-record-descriptor ':Itl1ExtRec))
(defrecord (UntokenTable :handle)
   (len :SInt16)
   (lastToken :SInt16)
   (index (:array :SInt16 256))                 ; index table; last = lastToken
)

;type name? (%define-record :UntokenTable (find-record-descriptor ':UntokenTable))

(def-mactype :UntokenTablePtr (find-mactype '(:pointer :UntokenTable)))

(def-mactype :UntokenTableHandle (find-mactype '(:handle :UntokenTable)))
(defrecord WideChar
   (:variant
   (
   (a (:array :character 2))
   )
                                                ; 0 is the high order character
   (
   (b :SInt16)
   )
   )
)

;type name? (%define-record :WideChar (find-record-descriptor ':WideChar))
(defrecord WideCharArr
   (size :SInt16)
   (data (:array :WideChar 10))
)

;type name? (%define-record :WideCharArr (find-record-descriptor ':WideCharArr))
(defrecord NumberParts
   (version :SInt16)
   (data (:array :WideChar 31))                 ; index by [tokLeftQuote..tokMaxSymbols]
   (pePlus :WideCharArr)
   (peMinus :WideCharArr)
   (peMinusPlus :WideCharArr)
   (altNumTable :WideCharArr)
   (reserved (:array :character 20))
)

;type name? (%define-record :NumberParts (find-record-descriptor ':NumberParts))

(def-mactype :NumberPartsPtr (find-mactype '(:pointer :NumberParts)))
(defrecord (Itl4Rec :handle)
   (flags :SInt16)                              ; reserved
   (resourceType :signed-long)                  ; contains 'itl4'
   (resourceNum :SInt16)                        ; resource ID
   (version :SInt16)                            ; version number
   (resHeader1 :signed-long)                    ; reserved
   (resHeader2 :signed-long)                    ; reserved
   (numTables :SInt16)                          ; number of tables, one-based
   (mapOffset :signed-long)                     ; offset to table that maps byte to token
   (strOffset :signed-long)                     ; offset to routine that copies canonical string
   (fetchOffset :signed-long)                   ; offset to routine that gets next byte of character
   (unTokenOffset :signed-long)                 ; offset to table that maps token to canonical string
   (defPartsOffset :signed-long)                ; offset to default number parts table
   (resOffset6 :signed-long)                    ; reserved
   (resOffset7 :signed-long)                    ; reserved
   (resOffset8 :signed-long)                    ; reserved
)

;type name? (%define-record :Itl4Rec (find-record-descriptor ':Itl4Rec))

(def-mactype :Itl4Ptr (find-mactype '(:pointer :Itl4Rec)))

(def-mactype :Itl4Handle (find-mactype '(:handle :Itl4Rec)))
;  New NItl4Rec for System 7.0: 
(defrecord (NItl4Rec :handle)
   (flags :SInt16)                              ; reserved
   (resourceType :signed-long)                  ; contains 'itl4'
   (resourceNum :SInt16)                        ; resource ID
   (version :SInt16)                            ; version number
   (format :SInt16)                             ; format code
   (resHeader :SInt16)                          ; reserved
   (resHeader2 :signed-long)                    ; reserved
   (numTables :SInt16)                          ; number of tables, one-based
   (mapOffset :signed-long)                     ; offset to table that maps byte to token
   (strOffset :signed-long)                     ; offset to routine that copies canonical string
   (fetchOffset :signed-long)                   ; offset to routine that gets next byte of character
   (unTokenOffset :signed-long)                 ; offset to table that maps token to canonical string
   (defPartsOffset :signed-long)                ; offset to default number parts table
   (whtSpListOffset :signed-long)               ; offset to white space code list
   (resOffset7 :signed-long)                    ; reserved
   (resOffset8 :signed-long)                    ; reserved
   (resLength1 :SInt16)                         ; reserved
   (resLength2 :SInt16)                         ; reserved
   (resLength3 :SInt16)                         ; reserved
   (unTokenLength :SInt16)                      ; length of untoken table
   (defPartsLength :SInt16)                     ; length of default number parts table
   (whtSpListLength :SInt16)                    ; length of white space code list
   (resLength7 :SInt16)                         ; reserved
   (resLength8 :SInt16)                         ; reserved
)

;type name? (%define-record :NItl4Rec (find-record-descriptor ':NItl4Rec))

(def-mactype :NItl4Ptr (find-mactype '(:pointer :NItl4Rec)))

(def-mactype :NItl4Handle (find-mactype '(:handle :NItl4Rec)))
(defrecord TableDirectoryRecord
   (tableSignature :OSType)                     ; 4 byte long table name 
   (reserved :UInt32)                           ; Reserved for internal use 
   (tableStartOffset :UInt32)                   ; Table start offset in byte
   (tableSize :UInt32)                          ; Table size in byte
)

;type name? (%define-record :TableDirectoryRecord (find-record-descriptor ':TableDirectoryRecord))
(defrecord Itl5Record
   (versionNumber :signed-long)                 ; itl5 resource version number 
   (numberOfTables :UInt16)                     ; Number of tables it contains 
   (reserved (:array :UInt16 3))                ; Reserved for internal use 
   (tableDirectory (:array :TableDirectoryRecord 1)); Table directory records 
)

;type name? (%define-record :Itl5Record (find-record-descriptor ':Itl5Record))
(defrecord RuleBasedTrslRecord
   (sourceType :SInt16)                         ; Transliterate target type for the LHS of the rule 
   (targetType :SInt16)                         ; Transliterate target type for the RHS of the rule 
   (formatNumber :SInt16)                       ; Transliterate resource format number 
   (propertyFlag :SInt16)                       ; Transliterate property flags 
   (numberOfRules :SInt16)                      ; Number of rules following this field 
)

;type name? (%define-record :RuleBasedTrslRecord (find-record-descriptor ':RuleBasedTrslRecord))
(defrecord ItlcRecord
   (itlcSystem :SInt16)                         ; default system script
   (itlcReserved :SInt16)                       ; reserved
   (itlcFontForce :SInt8)                       ; default font force flag
   (itlcIntlForce :SInt8)                       ; default intl force flag
   (itlcOldKybd :SInt8)                         ; MacPlus intl keybd flag
   (itlcFlags :SInt8)                           ; general flags
   (itlcIconOffset :SInt16)                     ; keyboard icon offset; not used in 7.0
   (itlcIconSide :SInt8)                        ; keyboard icon side; not used in 7.0
   (itlcIconRsvd :SInt8)                        ; rsvd for other icon info
   (itlcRegionCode :SInt16)                     ; preferred verXxx code
   (itlcSysFlags :SInt16)                       ; flags for setting system globals
   (itlcReserved4 (:array :SInt8 32))           ; for future use
)

;type name? (%define-record :ItlcRecord (find-record-descriptor ':ItlcRecord))
(defrecord ItlbRecord
   (itlbNumber :SInt16)                         ; itl0 id number
   (itlbDate :SInt16)                           ; itl1 id number
   (itlbSort :SInt16)                           ; itl2 id number
   (itlbFlags :SInt16)                          ; Script flags
   (itlbToken :SInt16)                          ; itl4 id number
   (itlbEncoding :SInt16)                       ; itl5 ID # (optional; char encoding)
   (itlbLang :SInt16)                           ; current language for script 
   (itlbNumRep :SInt8)                          ; number representation code
   (itlbDateRep :SInt8)                         ; date representation code 
   (itlbKeys :SInt16)                           ; KCHR id number
   (itlbIcon :SInt16)                           ; ID # of SICN or kcs#/kcs4/kcs8 suite.
)

;type name? (%define-record :ItlbRecord (find-record-descriptor ':ItlbRecord))
;  New ItlbExtRecord structure for System 7.0 
(defrecord ItlbExtRecord
   (base :ItlbRecord)                           ; un-extended ItlbRecord
   (itlbLocalSize :signed-long)                 ; size of script's local record
   (itlbMonoFond :SInt16)                       ; default monospace FOND ID
   (itlbMonoSize :SInt16)                       ; default monospace font size
   (itlbPrefFond :SInt16)                       ; preferred FOND ID
   (itlbPrefSize :SInt16)                       ; preferred font size
   (itlbSmallFond :SInt16)                      ; default small FOND ID
   (itlbSmallSize :SInt16)                      ; default small font size
   (itlbSysFond :SInt16)                        ; default system FOND ID
   (itlbSysSize :SInt16)                        ; default system font size
   (itlbAppFond :SInt16)                        ; default application FOND ID
   (itlbAppSize :SInt16)                        ; default application font size
   (itlbHelpFond :SInt16)                       ; default Help Mgr FOND ID
   (itlbHelpSize :SInt16)                       ; default Help Mgr font size
   (itlbValidStyles :UInt8)                     ; set of valid styles for script
   (itlbAliasStyle :UInt8)                      ; style (set) to mark aliases
)

;type name? (%define-record :ItlbExtRecord (find-record-descriptor ':ItlbExtRecord))
; #pragma options align=reset

; #endif /* __INTLRESOURCES__ */


(provide-interface "IntlResources")