(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:TextCommon.h"
; at Sunday July 2,2006 7:23:11 pm.
; 
;      File:       CarbonCore/TextCommon.h
;  
;      Contains:   TextEncoding-related types and constants, and prototypes for related functions
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1995-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __TEXTCOMMON__
; #define __TEXTCOMMON__
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

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; #pragma options align=mac68k
;  TextEncodingBase type & values 
;  (values 0-32 correspond to the Script Codes defined in Inside Macintosh: Text pages 6-52 and 6-53 

(def-mactype :TextEncodingBase (find-mactype ':UInt32))
;  Mac OS encodings

(defconstant $kTextEncodingMacRoman 0)
(defconstant $kTextEncodingMacJapanese 1)
(defconstant $kTextEncodingMacChineseTrad 2)
(defconstant $kTextEncodingMacKorean 3)
(defconstant $kTextEncodingMacArabic 4)
(defconstant $kTextEncodingMacHebrew 5)
(defconstant $kTextEncodingMacGreek 6)
(defconstant $kTextEncodingMacCyrillic 7)
(defconstant $kTextEncodingMacDevanagari 9)
(defconstant $kTextEncodingMacGurmukhi 10)
(defconstant $kTextEncodingMacGujarati 11)
(defconstant $kTextEncodingMacOriya 12)
(defconstant $kTextEncodingMacBengali 13)
(defconstant $kTextEncodingMacTamil 14)
(defconstant $kTextEncodingMacTelugu 15)
(defconstant $kTextEncodingMacKannada 16)
(defconstant $kTextEncodingMacMalayalam 17)
(defconstant $kTextEncodingMacSinhalese 18)
(defconstant $kTextEncodingMacBurmese 19)
(defconstant $kTextEncodingMacKhmer 20)
(defconstant $kTextEncodingMacThai 21)
(defconstant $kTextEncodingMacLaotian 22)
(defconstant $kTextEncodingMacGeorgian 23)
(defconstant $kTextEncodingMacArmenian 24)
(defconstant $kTextEncodingMacChineseSimp 25)
(defconstant $kTextEncodingMacTibetan 26)
(defconstant $kTextEncodingMacMongolian 27)
(defconstant $kTextEncodingMacEthiopic 28)
(defconstant $kTextEncodingMacCentralEurRoman 29)
(defconstant $kTextEncodingMacVietnamese 30)
(defconstant $kTextEncodingMacExtArabic 31)     ;  The following use script code 0, smRoman

(defconstant $kTextEncodingMacSymbol 33)
(defconstant $kTextEncodingMacDingbats 34)
(defconstant $kTextEncodingMacTurkish 35)
(defconstant $kTextEncodingMacCroatian 36)
(defconstant $kTextEncodingMacIcelandic 37)
(defconstant $kTextEncodingMacRomanian 38)
(defconstant $kTextEncodingMacCeltic 39)
(defconstant $kTextEncodingMacGaelic 40)
(defconstant $kTextEncodingMacKeyboardGlyphs 41)
;  The following are older names for backward compatibility

(defconstant $kTextEncodingMacTradChinese 2)
(defconstant $kTextEncodingMacRSymbol 8)
(defconstant $kTextEncodingMacSimpChinese 25)
(defconstant $kTextEncodingMacGeez 28)
(defconstant $kTextEncodingMacEastEurRoman 29)
(defconstant $kTextEncodingMacUninterp 32)
; 
;    Beginning in Mac OS 8.5, the following meta-value is used to indicate Unicode in some parts
;    of the Mac OS which previously only expected a Mac OS script code. In some of these places,
;    only 7 bits are available to indicate encoding (script code), so kTextEncodingUnicodeDefault
;    cannot be used. For example, kTextEncodingMacUnicode can be used to indicate Unicode in the
;    7-bit script code field of a Unicode input method's ComponentDescription.componentFlags field;
;    it can also be used to indicate Unicode in the 16-bit script code field of an AppleEvent's
;    typeIntlWritingCode text tag.
; 

(defconstant $kTextEncodingMacUnicode 126)      ;  Meta-value, Unicode as a Mac encoding

;  Variant Mac OS encodings that use script codes other than 0
;  The following use script code 4, smArabic

(defconstant $kTextEncodingMacFarsi #x8C)       ;  Like MacArabic but uses Farsi digits
;  The following use script code 7, smCyrillic

(defconstant $kTextEncodingMacUkrainian #x98)   ;  Meta-value in TEC 1.5 & later; maps to kTextEncodingMacCyrillic variant    
;  The following use script code 28, smEthiopic

(defconstant $kTextEncodingMacInuit #xEC)       ;  The following use script code 32, smUnimplemented

(defconstant $kTextEncodingMacVT100 #xFC)       ;  VT100/102 font from Comm Toolbox: Latin-1 repertoire + box drawing etc

;  Special Mac OS encodings

(defconstant $kTextEncodingMacHFS #xFF)         ;  Meta-value, should never appear in a table.

;  Unicode & ISO UCS encodings begin at 0x100

(defconstant $kTextEncodingUnicodeDefault #x100);  Meta-value, should never appear in a table.

(defconstant $kTextEncodingUnicodeV1_1 #x101)
(defconstant $kTextEncodingISO10646_1993 #x101) ;  Code points identical to Unicode 1.1

(defconstant $kTextEncodingUnicodeV2_0 #x103)   ;  New location for Korean Hangul

(defconstant $kTextEncodingUnicodeV2_1 #x103)   ;  We treat both Unicode 2.0 and Unicode 2.1 as 2.1

(defconstant $kTextEncodingUnicodeV3_0 #x104)
(defconstant $kTextEncodingUnicodeV3_1 #x105)   ;  Adds characters requiring surrogate pairs in UTF-16

(defconstant $kTextEncodingUnicodeV3_2 #x106)
(defconstant $kTextEncodingUnicodeV4_0 #x108)
;  ISO 8-bit and 7-bit encodings begin at 0x200

(defconstant $kTextEncodingISOLatin1 #x201)     ;  ISO 8859-1, Western European

(defconstant $kTextEncodingISOLatin2 #x202)     ;  ISO 8859-2, Central European

(defconstant $kTextEncodingISOLatin3 #x203)     ;  ISO 8859-3, South European (Maltese...)

(defconstant $kTextEncodingISOLatin4 #x204)     ;  ISO 8859-4, North European & some Baltic

(defconstant $kTextEncodingISOLatinCyrillic #x205);  ISO 8859-5

(defconstant $kTextEncodingISOLatinArabic #x206);  ISO 8859-6, = ASMO 708, =DOS CP 708

(defconstant $kTextEncodingISOLatinGreek #x207) ;  ISO 8859-7

(defconstant $kTextEncodingISOLatinHebrew #x208);  ISO 8859-8

(defconstant $kTextEncodingISOLatin5 #x209)     ;  ISO 8859-9, Turkish

(defconstant $kTextEncodingISOLatin6 #x20A)     ;  ISO 8859-10, Nordic                    

(defconstant $kTextEncodingISOLatin7 #x20D)     ;  ISO 8859-13, Baltic Rim                   

(defconstant $kTextEncodingISOLatin8 #x20E)     ;  ISO 8859-14, Celtic                    

(defconstant $kTextEncodingISOLatin9 #x20F)     ;  ISO 8859-15, 8859-1 changed for EURO & CP1252 letters  

(defconstant $kTextEncodingISOLatin10 #x210)    ;  ISO 8859-16, Romanian

;  MS-DOS & Windows encodings begin at 0x400

(defconstant $kTextEncodingDOSLatinUS #x400)    ;  code page 437

(defconstant $kTextEncodingDOSGreek #x405)      ;  code page 737 (formerly code page 437G)

(defconstant $kTextEncodingDOSBalticRim #x406)  ;  code page 775

(defconstant $kTextEncodingDOSLatin1 #x410)     ;  code page 850, "Multilingual"

(defconstant $kTextEncodingDOSGreek1 #x411)     ;  code page 851

(defconstant $kTextEncodingDOSLatin2 #x412)     ;  code page 852, Slavic

(defconstant $kTextEncodingDOSCyrillic #x413)   ;  code page 855, IBM Cyrillic

(defconstant $kTextEncodingDOSTurkish #x414)    ;  code page 857, IBM Turkish

(defconstant $kTextEncodingDOSPortuguese #x415) ;  code page 860

(defconstant $kTextEncodingDOSIcelandic #x416)  ;  code page 861

(defconstant $kTextEncodingDOSHebrew #x417)     ;  code page 862

(defconstant $kTextEncodingDOSCanadianFrench #x418);  code page 863

(defconstant $kTextEncodingDOSArabic #x419)     ;  code page 864

(defconstant $kTextEncodingDOSNordic #x41A)     ;  code page 865

(defconstant $kTextEncodingDOSRussian #x41B)    ;  code page 866

(defconstant $kTextEncodingDOSGreek2 #x41C)     ;  code page 869, IBM Modern Greek

(defconstant $kTextEncodingDOSThai #x41D)       ;  code page 874, also for Windows

(defconstant $kTextEncodingDOSJapanese #x420)   ;  code page 932, also for Windows; Shift-JIS with additions

(defconstant $kTextEncodingDOSChineseSimplif #x421);  code page 936, also for Windows; was EUC-CN, now GBK (EUC-CN extended)

(defconstant $kTextEncodingDOSKorean #x422)     ;  code page 949, also for Windows; Unified Hangul Code (EUC-KR extended)

(defconstant $kTextEncodingDOSChineseTrad #x423);  code page 950, also for Windows; Big-5

(defconstant $kTextEncodingWindowsLatin1 #x500) ;  code page 1252

(defconstant $kTextEncodingWindowsANSI #x500)   ;  code page 1252 (alternate name)

(defconstant $kTextEncodingWindowsLatin2 #x501) ;  code page 1250, Central Europe

(defconstant $kTextEncodingWindowsCyrillic #x502);  code page 1251, Slavic Cyrillic

(defconstant $kTextEncodingWindowsGreek #x503)  ;  code page 1253

(defconstant $kTextEncodingWindowsLatin5 #x504) ;  code page 1254, Turkish

(defconstant $kTextEncodingWindowsHebrew #x505) ;  code page 1255

(defconstant $kTextEncodingWindowsArabic #x506) ;  code page 1256

(defconstant $kTextEncodingWindowsBalticRim #x507);  code page 1257

(defconstant $kTextEncodingWindowsVietnamese #x508);  code page 1258

(defconstant $kTextEncodingWindowsKoreanJohab #x510);  code page 1361, for Windows NT

;  Various national standards begin at 0x600

(defconstant $kTextEncodingUS_ASCII #x600)
(defconstant $kTextEncodingANSEL #x601)         ;  ANSEL (ANSI Z39.47) for library use

(defconstant $kTextEncodingJIS_X0201_76 #x620)  ;  JIS Roman and 1-byte katakana (halfwidth)

(defconstant $kTextEncodingJIS_X0208_83 #x621)
(defconstant $kTextEncodingJIS_X0208_90 #x622)
(defconstant $kTextEncodingJIS_X0212_90 #x623)
(defconstant $kTextEncodingJIS_C6226_78 #x624)
(defconstant $kTextEncodingShiftJIS_X0213_00 #x628);  Shift-JIS format encoding of JIS X0213 planes 1 and 2

(defconstant $kTextEncodingJIS_X0213_MenKuTen #x629);  JIS X0213 in plane-row-column notation (3 bytes)

(defconstant $kTextEncodingGB_2312_80 #x630)
(defconstant $kTextEncodingGBK_95 #x631)        ;  annex to GB 13000-93; for Windows 95; EUC-CN extended

(defconstant $kTextEncodingGB_18030_2000 #x632)
(defconstant $kTextEncodingKSC_5601_87 #x640)   ;  same as KSC 5601-92 without Johab annex

(defconstant $kTextEncodingKSC_5601_92_Johab #x641);  KSC 5601-92 Johab annex

(defconstant $kTextEncodingCNS_11643_92_P1 #x651);  CNS 11643-1992 plane 1

(defconstant $kTextEncodingCNS_11643_92_P2 #x652);  CNS 11643-1992 plane 2

(defconstant $kTextEncodingCNS_11643_92_P3 #x653);  CNS 11643-1992 plane 3 (was plane 14 in 1986 version)

;  ISO 2022 collections begin at 0x800

(defconstant $kTextEncodingISO_2022_JP #x820)   ;  RFC 1468

(defconstant $kTextEncodingISO_2022_JP_2 #x821) ;  RFC 1554

(defconstant $kTextEncodingISO_2022_JP_1 #x822) ;  RFC 2237

(defconstant $kTextEncodingISO_2022_JP_3 #x823) ;  JIS X0213

(defconstant $kTextEncodingISO_2022_CN #x830)   ;  RFC 1922

(defconstant $kTextEncodingISO_2022_CN_EXT #x831);  RFC 1922

(defconstant $kTextEncodingISO_2022_KR #x840)   ;  RFC 1557

;  EUC collections begin at 0x900

(defconstant $kTextEncodingEUC_JP #x920)        ;  ISO 646, 1-byte katakana, JIS 208, JIS 212

(defconstant $kTextEncodingEUC_CN #x930)        ;  ISO 646, GB 2312-80

(defconstant $kTextEncodingEUC_TW #x931)        ;  ISO 646, CNS 11643-1992 Planes 1-16

(defconstant $kTextEncodingEUC_KR #x940)        ;  RFC 1557: ISO 646, KS C 5601-1987

;  Misc standards begin at 0xA00

(defconstant $kTextEncodingShiftJIS #xA01)      ;  plain Shift-JIS

(defconstant $kTextEncodingKOI8_R #xA02)        ;  RFC 1489, Russian internet standard

(defconstant $kTextEncodingBig5 #xA03)          ;  Big-5 (has variants)

(defconstant $kTextEncodingMacRomanLatin1 #xA04);  Mac OS Roman permuted to align with ISO Latin-1

(defconstant $kTextEncodingHZ_GB_2312 #xA05)    ;  HZ (RFC 1842, for Chinese mail & news)

(defconstant $kTextEncodingBig5_HKSCS_1999 #xA06);  Big-5 with Hong Kong special char set supplement

(defconstant $kTextEncodingVISCII #xA07)        ;  RFC 1456, Vietnamese

(defconstant $kTextEncodingKOI8_U #xA08)        ;  RFC 2319, Ukrainian

(defconstant $kTextEncodingBig5_E #xA09)        ;  Taiwan Big-5E standard

;  Other platform encodings

(defconstant $kTextEncodingNextStepLatin #xB01) ;  NextStep Latin encoding

(defconstant $kTextEncodingNextStepJapanese #xB02);  NextStep Japanese encoding (variant of EUC-JP)

;  EBCDIC & IBM host encodings begin at 0xC00

(defconstant $kTextEncodingEBCDIC_US #xC01)     ;  basic EBCDIC-US

(defconstant $kTextEncodingEBCDIC_CP037 #xC02)  ;  code page 037, extended EBCDIC (Latin-1 set) for US,Canada...

;  Special values

(defconstant $kTextEncodingMultiRun #xFFF)      ;  Multi-encoding text with external run info

(defconstant $kTextEncodingUnknown #xFFFF)      ;  Unknown or unspecified                  

;  TextEncodingVariant type & values 

(def-mactype :TextEncodingVariant (find-mactype ':UInt32))
;  Default TextEncodingVariant, for any TextEncodingBase

(defconstant $kTextEncodingDefaultVariant 0)
;  Variants of kTextEncodingMacRoman                                                        

(defconstant $kMacRomanDefaultVariant 0)        ;  meta value, maps to 1 or 2 depending on System 

(defconstant $kMacRomanCurrencySignVariant 1)   ;  Mac OS version < 8.5, 0xDB is CURRENCY SIGN

(defconstant $kMacRomanEuroSignVariant 2)       ;  Mac OS version >= 8.5, 0xDB is EURO SIGN      

;  Variants of kTextEncodingMacCyrillic (for TEC 1.5 and later)                             

(defconstant $kMacCyrillicDefaultVariant 0)     ;  meta value, maps to 1, 2, or 3 depending on System

(defconstant $kMacCyrillicCurrSignStdVariant 1) ;  Mac OS < 9.0 (RU,BG), 0xFF = CURRENCY SIGN, 0xA2/0xB6 = CENT / PARTIAL DIFF.

(defconstant $kMacCyrillicCurrSignUkrVariant 2) ;  Mac OS < 9.0 (UA,LangKit), 0xFF = CURRENCY SIGN, 0xA2/0xB6 = GHE WITH UPTURN

(defconstant $kMacCyrillicEuroSignVariant 3)    ;  Mac OS >= 9.0, 0xFF is EURO SIGN, 0xA2/0xB6 = GHE WITH UPTURN

;  Variants of kTextEncodingMacIcelandic                                                    

(defconstant $kMacIcelandicStdDefaultVariant 0) ;  meta value, maps to 2 or 4 depending on System 

(defconstant $kMacIcelandicTTDefaultVariant 1)  ;  meta value, maps to 3 or 5 depending on System 
;  The following are for Mac OS version < 8.5, 0xDB is CURRENCY SIGN             

(defconstant $kMacIcelandicStdCurrSignVariant 2);  0xBB/0xBC are fem./masc. ordinal indicators

(defconstant $kMacIcelandicTTCurrSignVariant 3) ;  0xBB/0xBC are fi/fl ligatures
;  The following are for Mac OS version >= 8.5, 0xDB is EURO SIGN                  

(defconstant $kMacIcelandicStdEuroSignVariant 4);  0xBB/0xBC are fem./masc. ordinal indicators

(defconstant $kMacIcelandicTTEuroSignVariant 5) ;  0xBB/0xBC are fi/fl ligatures

;  Variants of kTextEncodingMacCroatian                                                     

(defconstant $kMacCroatianDefaultVariant 0)     ;  meta value, maps to 1 or 2 depending on System 

(defconstant $kMacCroatianCurrencySignVariant 1);  Mac OS version < 8.5, 0xDB is CURRENCY SIGN       

(defconstant $kMacCroatianEuroSignVariant 2)    ;  Mac OS version >= 8.5, 0xDB is EURO SIGN      

;  Variants of kTextEncodingMacRomanian                                                     

(defconstant $kMacRomanianDefaultVariant 0)     ;  meta value, maps to 1 or 2 depending on System 

(defconstant $kMacRomanianCurrencySignVariant 1);  Mac OS version < 8.5, 0xDB is CURRENCY SIGN       

(defconstant $kMacRomanianEuroSignVariant 2)    ;  Mac OS version >= 8.5, 0xDB is EURO SIGN      

;  Variants of kTextEncodingMacJapanese

(defconstant $kMacJapaneseStandardVariant 0)
(defconstant $kMacJapaneseStdNoVerticalsVariant 1)
(defconstant $kMacJapaneseBasicVariant 2)
(defconstant $kMacJapanesePostScriptScrnVariant 3)
(defconstant $kMacJapanesePostScriptPrintVariant 4)
(defconstant $kMacJapaneseVertAtKuPlusTenVariant 5)
;  Variants of kTextEncodingMacArabic

(defconstant $kMacArabicStandardVariant 0)      ;  0xC0 is 8-spoke asterisk, 0x2A & 0xAA are asterisk (e.g. Cairo)

(defconstant $kMacArabicTrueTypeVariant 1)      ;  0xC0 is asterisk, 0x2A & 0xAA are multiply signs (e.g. Baghdad)

(defconstant $kMacArabicThuluthVariant 2)       ;  0xC0 is Arabic five-point star, 0x2A & 0xAA are multiply signs

(defconstant $kMacArabicAlBayanVariant 3)       ;  8-spoke asterisk, multiply sign, Koranic ligatures & parens

;  Variants of kTextEncodingMacFarsi

(defconstant $kMacFarsiStandardVariant 0)       ;  0xC0 is 8-spoke asterisk, 0x2A & 0xAA are asterisk (e.g. Tehran)

(defconstant $kMacFarsiTrueTypeVariant 1)       ;  asterisk, multiply signs, Koranic ligatures, geometric shapes

;  Variants of kTextEncodingMacHebrew

(defconstant $kMacHebrewStandardVariant 0)
(defconstant $kMacHebrewFigureSpaceVariant 1)
;  Variants of kTextEncodingMacGreek

(defconstant $kMacGreekDefaultVariant 0)        ;  meta value, maps to 1 or 2 depending on System

(defconstant $kMacGreekNoEuroSignVariant 1)     ;  Mac OS version < 9.2.2, 0x9C is SOFT HYPHEN, 0xFF is undefined

(defconstant $kMacGreekEuroSignVariant 2)       ;  Mac OS version >= 9.2.2, 0x9C is EURO SIGN, 0xFF is SOFT HYPHEN

;  Variants of kTextEncodingMacVT100                                                        

(defconstant $kMacVT100DefaultVariant 0)        ;  meta value, maps to 1 or 2 depending on System 

(defconstant $kMacVT100CurrencySignVariant 1)   ;  Mac OS version < 8.5, 0xDB is CURRENCY SIGN       

(defconstant $kMacVT100EuroSignVariant 2)       ;  Mac OS version >= 8.5, 0xDB is EURO SIGN      

;  Variants of Unicode & ISO 10646 encodings

(defconstant $kUnicodeNoSubset 0)
(defconstant $kUnicodeCanonicalDecompVariant 2) ;  canonical decomposition (NFD); excludes composed characters

(defconstant $kUnicodeCanonicalCompVariant 3)   ;  canonical composition (NFC); uses the composed chars as of Unicode 3.1

(defconstant $kUnicodeHFSPlusDecompVariant 8)   ;  decomposition for HFS+; doesn't decompose in 2000-2FFF, F900-FAFF, 2F800-2FAFF

(defconstant $kUnicodeHFSPlusCompVariant 9)     ;  composition based on HFS+ decomposition

;  Variants of kTextEncodingISOLatin1

(defconstant $kISOLatin1StandardVariant 0)
(defconstant $kISOLatin1MusicCDVariant 1)
; 
;    Variants of kTextEncodingISOLatinArabic, kTextEncodingISOLatinHebrew.
;    Per RFC 1556 and ECMA TR/53, there are three ways of handling bidirectional text
;    in the ISO character sets 8859-6 (Arabic) and 8859-8 (Hebrew).
;    1. Implicit or Logical order is "a presentation method in which the direction is
;    determined by an algorithm according to the type of characters and their position
;    relative to the adjacent characters and according to their primary direction." This
;    is the method normally used for Unicode and for the Mac OS and Windows Arabic and
;    Hebrew encodings.
;    2. Visual order assumes the text is already ordered such that it can be displayed
;    in a left-to-right display direction with no further directional processing. This
;    is equivalent to treating all characters as having strong left-right directionality.
;    This is the default assumed for internet Hebrew text encoded in ISO 8859-8, unless
;    the charset label suffix specifically indicates implicit (-i) or explicit (-e)
;    ordering.
;    3. Explicit order is "a presentation method in which the direction is explicitly
;    defined by using control sequences which are interleaved within the text and are
;    used for direction determination."
; 

(defconstant $kISOLatinArabicImplicitOrderVariant 0)
(defconstant $kISOLatinArabicVisualOrderVariant 1)
(defconstant $kISOLatinArabicExplicitOrderVariant 2)

(defconstant $kISOLatinHebrewImplicitOrderVariant 0)
(defconstant $kISOLatinHebrewVisualOrderVariant 1)
(defconstant $kISOLatinHebrewExplicitOrderVariant 2)
;  Variants of kTextEncodingWindowsLatin1

(defconstant $kWindowsLatin1StandardVariant 0)
(defconstant $kWindowsLatin1PalmVariant 1)      ;  PalmSource variant of cp1252

;  Variants of kTextEncodingDOSJapanese

(defconstant $kDOSJapaneseStandardVariant 0)
(defconstant $kDOSJapanesePalmVariant 1)        ;  PalmSource variant of cp932

; 
;    Variants of EUC_CN
;    The DOSVariant is like kTextEncodingDOSChineseSimplif, but with the
;    basic EUC_CN part mapped as per kTextEncodingEUC_CN.
; 

(defconstant $kEUC_CN_BasicVariant 0)
(defconstant $kEUC_CN_DOSVariant 1)
; 
;    Variants of EUC_KR
;    The DOSVariant is like kTextEncodingDOSKorean, but with the
;    basic EUC_KR part mapped as per kTextEncodingEUC_KR.
; 

(defconstant $kEUC_KR_BasicVariant 0)
(defconstant $kEUC_KR_DOSVariant 1)
; 
;    Variants of ShiftJIS
;    The DOSVariant is like kTextEncodingDOSJapanese, but with the
;    basic ShiftJIS part mapped as per kTextEncodingShiftJIS.
; 

(defconstant $kShiftJIS_BasicVariant 0)
(defconstant $kShiftJIS_DOSVariant 1)
(defconstant $kShiftJIS_MusicCDVariant 2)       ;  MusicShiftJIS, per RIS-506 (RIAJ)

; 
;    Variants of Big-5 encoding
;    The DOSVariant is like kTextEncodingDOSChineseTrad, but with the
;    basic Big5 part mapped as per kTextEncodingBig5.
; 

(defconstant $kBig5_BasicVariant 0)
(defconstant $kBig5_StandardVariant 1)          ;  0xC6A1-0xC7FC: kana, Cyrillic, enclosed numerics

(defconstant $kBig5_ETenVariant 2)              ;  adds kana, Cyrillic, radicals, etc with hi bytes C6-C8,F9

(defconstant $kBig5_DOSVariant 3)
;  Variants of MacRomanLatin1                                                               

(defconstant $kMacRomanLatin1DefaultVariant 0)  ;  meta value, maps to others depending on System

(defconstant $kMacRomanLatin1StandardVariant 2) ;  permuted MacRoman, EuroSignVariant

(defconstant $kMacRomanLatin1TurkishVariant 6)  ;  permuted MacTurkish

(defconstant $kMacRomanLatin1CroatianVariant 8) ;  permuted MacCroatian, EuroSignVariant

(defconstant $kMacRomanLatin1IcelandicVariant 11);  permuted MacIcelandic, StdEuroSignVariant

(defconstant $kMacRomanLatin1RomanianVariant 14);  permuted MacRomanian, EuroSignVariant

;  Unicode variants not yet supported (and not fully defined)

(defconstant $kUnicodeNoCompatibilityVariant 1)
(defconstant $kUnicodeNoCorporateVariant 4)
;  The following are older names for backward compatibility

(defconstant $kMacRomanStandardVariant 0)
(defconstant $kMacIcelandicStandardVariant 0)
(defconstant $kMacIcelandicTrueTypeVariant 1)
(defconstant $kJapaneseStandardVariant 0)
(defconstant $kJapaneseStdNoVerticalsVariant 1)
(defconstant $kJapaneseBasicVariant 2)
(defconstant $kJapanesePostScriptScrnVariant 3)
(defconstant $kJapanesePostScriptPrintVariant 4)
(defconstant $kJapaneseVertAtKuPlusTenVariant 5);  kJapaneseStdNoOneByteKanaVariant = 6,  // replaced by kJapaneseNoOneByteKanaOption
;  kJapaneseBasicNoOneByteKanaVariant = 7,    // replaced by kJapaneseNoOneByteKanaOption    

(defconstant $kHebrewStandardVariant 0)
(defconstant $kHebrewFigureSpaceVariant 1)
(defconstant $kUnicodeMaxDecomposedVariant 2)   ;  replaced by kUnicodeCanonicalDecompVariant

(defconstant $kUnicodeNoComposedVariant 3)      ;  this really meant NoComposing; replaced by kUnicodeCanonicalCompVariant
;  The following Japanese variant options were never supported and are now deprecated.
;  In TEC 1.4 and later their functionality is replaced by the Unicode Converter options listed.

(defconstant $kJapaneseNoOneByteKanaOption 32)  ;  replaced by UnicodeConverter option kUnicodeNoHalfwidthCharsBit

(defconstant $kJapaneseUseAsciiBackslashOption 64);  replaced by UnicodeConverter option kUnicodeForceASCIIRangeBit

;  TextEncodingFormat type & values 

(def-mactype :TextEncodingFormat (find-mactype ':UInt32))
;  Default TextEncodingFormat for any TextEncodingBase

(defconstant $kTextEncodingDefaultFormat 0)     ;  Formats for Unicode & ISO 10646

(defconstant $kUnicodeUTF16Format 0)            ;  UTF16 form (16-bit units), native or external byte order (see below)

(defconstant $kUnicodeUTF7Format 1)             ;  UTF7 form

(defconstant $kUnicodeUTF8Format 2)             ;  UTF8 form

(defconstant $kUnicodeUTF32Format 3)            ;  UTF32 form (32-bit units), native or external byte order (see below)

(defconstant $kUnicodeUTF16BEFormat 4)          ;  UTF16 form, explicit big-endian byte order, no BOM

(defconstant $kUnicodeUTF16LEFormat 5)          ;  UTF16 form, explicit little-endian byte order, no BOM

(defconstant $kUnicodeUTF32BEFormat 6)          ;  UTF32 form, explicit big-endian byte order, no BOM

(defconstant $kUnicodeUTF32LEFormat 7)          ;  UTF32 form, explicit little-endian byte order, no BOM

(defconstant $kUnicodeSCSUFormat 8)             ;  Std. Compression Scheme for Unicode, Unicode Tech Std. #6
;  Note for kUnicodeUTF16Format and kUnicodeUTF32Format:
;  - An array of UTF16Char (UniChar) or UTF32Char is normally understood to use "internal" or
;  platform-native byte ordering for kUnicodeUTF16Format and kUnicodeUTF32Format; the array MAY
;  begin with byte-order mark (BOM), but the BOM should match the internal ordering.
;  - If an array of bytes (such as char *) that can be in various encodings is specified to be
;  in Unicode with kUnicodeUTF16Format or kUnicodeUTF32Format (not explicitly BE or LE), then it
;  is assumed to use "external" byte ordering, which means: If there is a BOM at the beginning
;  of text, the BOM specifies the byte ordering, otherwise big-endian is assumed.
;  Synonyms for some Unicode formats

(defconstant $kUnicode16BitFormat 0)
(defconstant $kUnicode32BitFormat 3)
;  TextEncoding type 

(def-mactype :TextEncoding (find-mactype ':UInt32))
;  name part selector for GetTextEncodingName

(def-mactype :TextEncodingNameSelector (find-mactype ':UInt32))

(defconstant $kTextEncodingFullName 0)
(defconstant $kTextEncodingBaseName 1)
(defconstant $kTextEncodingVariantName 2)
(defconstant $kTextEncodingFormatName 3)
;  Types used in conversion 
(defrecord TextEncodingRun
   (offset :UInt32)
   (textEncoding :UInt32)
)

;type name? (%define-record :TextEncodingRun (find-record-descriptor ':TextEncodingRun))

(def-mactype :TextEncodingRunPtr (find-mactype '(:pointer :TextEncodingRun)))

(def-mactype :ConstTextEncodingRunPtr (find-mactype '(:pointer :TextEncodingRun)))
(defrecord ScriptCodeRun
   (offset :UInt32)
   (script :SInt16)
)

;type name? (%define-record :ScriptCodeRun (find-record-descriptor ':ScriptCodeRun))

(def-mactype :ScriptCodeRunPtr (find-mactype '(:pointer :ScriptCodeRun)))

(def-mactype :ConstScriptCodeRunPtr (find-mactype '(:pointer :ScriptCodeRun)))

(def-mactype :TextPtr (find-mactype '(:pointer :UInt8)))

(def-mactype :ConstTextPtr (find-mactype '(:pointer :UInt8)))
;  Basic types for Unicode characters and strings:

(def-mactype :UniCharArrayPtr (find-mactype '(:pointer :UInt16)))

(def-mactype :ConstUniCharArrayPtr (find-mactype '(:pointer :UInt16)))
; 
;    UniCharArrayHandle is a handle type to correspond to UniCharArrayPtr,
;    i.e. a handle to an array of UniChars (UInt16s).
; 

(def-mactype :UniCharArrayHandle (find-mactype '(:handle :UInt16)))
; 
;    UniCharArrayOffset is used to indicate an edge offset in an array
;    of UniChars (UInt16s).  
; 

(def-mactype :UniCharArrayOffset (find-mactype ':UInt32))
;  enums for TextEncoding Conversion routines

(defconstant $kTextScriptDontCare -128)
(defconstant $kTextLanguageDontCare -128)
(defconstant $kTextRegionDontCare -128)
;  struct for TECGetInfo
(defrecord TECInfo
   (format :UInt16)                             ;  format code for this struct
   (tecVersion :UInt16)                         ;  TEC version in BCD, e.g. 0x0121 for 1.2.1
   (tecTextConverterFeatures :UInt32)           ;  bitmask indicating TEC features/fixes
   (tecUnicodeConverterFeatures :UInt32)        ;  bitmask indicating UnicodeConverter features/fixes
   (tecTextCommonFeatures :UInt32)              ;  bitmask indicating TextCommon features/fixes
   (tecTextEncodingsFolderName (:string 31))    ;  localized name of Text Encodings folder (pascal string)
   (tecExtensionFileName (:string 31))          ;  localized name of TEC extension (pascal string)
   (tecLowestTEFileVersion :UInt16)             ;  Lowest version (BCD) of all files in Text Encodings folder
   (tecHighestTEFileVersion :UInt16)            ;  Highest version (BCD) of all files in Text Encodings folder
)

;type name? (%define-record :TECInfo (find-record-descriptor ':TECInfo))

(def-mactype :TECInfoPtr (find-mactype '(:pointer :TECInfo)))

(def-mactype :TECInfoHandle (find-mactype '(:handle :TECInfo)))
;  Value for TECInfo format code

(defconstant $kTECInfoCurrentFormat 2)          ;  any future formats will just add fields at the end

; 
;    Defined feature/fix bits for tecUnicodeConverterFeatures field
;    Bit:                             Meaning if set:
;    ----                             ---------------
;    kTECKeepInfoFixBit               Unicode Converter no longer ignores other control flags if
;                                     kUnicodeKeepInfoBit is set. Bug fix in TEC Manager 1.2.1.
;    kTECFallbackTextLengthFixBit     Unicode Converter honors the *srcConvLen and *destConvLen
;                                     returned by caller-supplied fallback handler for any status it
;                                     returns except for kTECUnmappableElementErr (previously it only
;                                     honored these values if noErr was returned). Bug fix in TEC
;                                     Manager 1.2.1.
;    kTECTextRunBitClearFixBit        ConvertFromUnicodeToTextRun & ConvertFromUnicodeToScriptCodeRun
;                                     function correctly if the kUnicodeTextRunBit is set (previously
;                                     their determination of best target encoding was incorrect). Bug
;                                     fix in TEC Manager 1.3.
;    kTECTextToUnicodeScanFixBit      ConvertFromTextToUnicode uses an improved scanner and maintains
;                                     some resulting state information, which it uses for mapping.
;                                     This has several effects:
;                                     - Improved mapping of 0x30-0x39 digits in Mac OS Arabic, fewer
;                                       direction overrides when mapping Mac OS Arabic & Hebrew, and
;                                       improved mapping of certain characters in Indic encodings.
;                                     - Malformed input produces kTextMalformedInputErr.
;                                     - ConvertFromTextToUnicode accepts and uses the control flags
;                                       kUnicodeKeepInfoMask and kUnicodeStringUnterminatedMask.
;                                     Bug fix and enhancement in TEC Manager 1.3.
;    kTECAddForceASCIIChangesBit      Define new control flag bits kUnicodeForceASCIIRangeBit and
;                                     kUnicodeNoHalfwidthCharsBit for use with
;                                     ConvertFromTextToUnicode, ConvertFromUnicodeToText, etc.
;                                     Enhancement in TEC Manager 1.4.
;    kTECPreferredEncodingFixBit      CreateUnicodeToTextRunInfo and related functions fix a problem
;                                     that occurred when a preferred encoding was specified that did
;                                     not match the System script; the preferred script was not
;                                     actually placed first in the ordered list of encodings to use.
;                                     Bug fix in TEC Manager 1.4.
;    kTECAddTextRunHeuristicsBit      Define new control flag bit kUnicodeTextRunHeuristicsBit for
;                                     use with ConvertFromUnicodeToTextRun.
;    kTECAddFallbackInterruptBit      Define new option kUnicodeFallbackInterruptSafeMask for use
;                                     with SetFallbackUnicodeToText. If a client fallback handler is
;                                     installed without specifying this bit, ConvertFromUnicodeToText
;                                     will HLock the tables it uses (in case the fallback handler
;                                     moves memory); otherwise, it won't.
; 

(defconstant $kTECKeepInfoFixBit 0)
(defconstant $kTECFallbackTextLengthFixBit 1)
(defconstant $kTECTextRunBitClearFixBit 2)
(defconstant $kTECTextToUnicodeScanFixBit 3)
(defconstant $kTECAddForceASCIIChangesBit 4)
(defconstant $kTECPreferredEncodingFixBit 5)
(defconstant $kTECAddTextRunHeuristicsBit 6)
(defconstant $kTECAddFallbackInterruptBit 7)

(defconstant $kTECKeepInfoFixMask 1)
(defconstant $kTECFallbackTextLengthFixMask 2)
(defconstant $kTECTextRunBitClearFixMask 4)
(defconstant $kTECTextToUnicodeScanFixMask 8)
(defconstant $kTECAddForceASCIIChangesMask 16)
(defconstant $kTECPreferredEncodingFixMask 32)
(defconstant $kTECAddTextRunHeuristicsMask 64)
(defconstant $kTECAddFallbackInterruptMask #x80)
; 
;    -------------------------------------------------------------------------------------------------
;    CONSTANTS for common and special Unicode code values
;    -------------------------------------------------------------------------------------------------
; 

(defconstant $kUnicodeByteOrderMark #xFEFF)
(defconstant $kUnicodeObjectReplacement #xFFFC) ;  placeholder for non-text object

(defconstant $kUnicodeReplacementChar #xFFFD)   ;  Unicode replacement for unconvertable input char

(defconstant $kUnicodeSwappedByteOrderMark #xFFFE);  not a Unicode char; byte-swapped version of FEFF

(defconstant $kUnicodeNotAChar #xFFFF)          ;  not a Unicode char; may be used as a terminator

; 
;    -------------------------------------------------------------------------------------------------
;    CONSTANTS & DATA STRUCTURES for Unicode Properties
;    -------------------------------------------------------------------------------------------------
; 

(def-mactype :UCCharPropertyType (find-mactype ':SInt32))

(defconstant $kUCCharPropTypeGenlCategory 1)    ;  requests enumeration value

(defconstant $kUCCharPropTypeCombiningClass 2)  ;  requests numeric value 0..255

(defconstant $kUCCharPropTypeBidiCategory 3)    ;  requests enumeration value


(def-mactype :UCCharPropertyValue (find-mactype ':UInt32))
;  General Category enumeration values (requested by kUCCharPropTypeGenlCategory)
;  Normative categories:

(defconstant $kUCGenlCatOtherNotAssigned 0)     ;  Cn Other, Not Assigned

(defconstant $kUCGenlCatOtherControl 1)         ;  Cc Other, Control

(defconstant $kUCGenlCatOtherFormat 2)          ;  Cf Other, Format

(defconstant $kUCGenlCatOtherSurrogate 3)       ;  Cs Other, Surrogate

(defconstant $kUCGenlCatOtherPrivateUse 4)      ;  Co Other, Private Use

(defconstant $kUCGenlCatMarkNonSpacing 5)       ;  Mn Mark, Non-Spacing

(defconstant $kUCGenlCatMarkSpacingCombining 6) ;  Mc Mark, Spacing Combining

(defconstant $kUCGenlCatMarkEnclosing 7)        ;  Me Mark, Enclosing

(defconstant $kUCGenlCatNumberDecimalDigit 8)   ;  Nd Number, Decimal Digit

(defconstant $kUCGenlCatNumberLetter 9)         ;  Nl Number, Letter

(defconstant $kUCGenlCatNumberOther 10)         ;  No Number, Other

(defconstant $kUCGenlCatSeparatorSpace 11)      ;  Zs Separator, Space

(defconstant $kUCGenlCatSeparatorLine 12)       ;  Zl Separator, Line

(defconstant $kUCGenlCatSeparatorParagraph 13)  ;  Zp Separator, Paragraph

(defconstant $kUCGenlCatLetterUppercase 14)     ;  Lu Letter, Uppercase

(defconstant $kUCGenlCatLetterLowercase 15)     ;  Ll Letter, Lowercase

(defconstant $kUCGenlCatLetterTitlecase 16)     ;  Lt Letter, Titlecase
;  Informative categories:

(defconstant $kUCGenlCatLetterModifier 17)      ;  Lm Letter, Modifier

(defconstant $kUCGenlCatLetterOther 18)         ;  Lo Letter, Other

(defconstant $kUCGenlCatPunctConnector 20)      ;  Pc Punctuation, Connector

(defconstant $kUCGenlCatPunctDash 21)           ;  Pd Punctuation, Dash

(defconstant $kUCGenlCatPunctOpen 22)           ;  Ps Punctuation, Open

(defconstant $kUCGenlCatPunctClose 23)          ;  Pe Punctuation, Close

(defconstant $kUCGenlCatPunctInitialQuote 24)   ;  Pi Punctuation, Initial quote

(defconstant $kUCGenlCatPunctFinalQuote 25)     ;  Pf Punctuation, Final quote

(defconstant $kUCGenlCatPunctOther 26)          ;  Po Punctuation, Other

(defconstant $kUCGenlCatSymbolMath 28)          ;  Sm Symbol, Math

(defconstant $kUCGenlCatSymbolCurrency 29)      ;  Sc Symbol, Currency

(defconstant $kUCGenlCatSymbolModifier 30)      ;  Sk Symbol, Modifier

(defconstant $kUCGenlCatSymbolOther 31)         ;  So Symbol, Other

;  Bidirectional Category enumeration values (requested by kUCCharPropTypeBidiCategory)

(defconstant $kUCBidiCatNotApplicable 0)        ;  for now use this for unassigned
;  Strong types:

(defconstant $kUCBidiCatLeftRight 1)            ;  L  Left-to-Right

(defconstant $kUCBidiCatRightLeft 2)            ;  R  Right-to-Left
;  Weak types:

(defconstant $kUCBidiCatEuroNumber 3)           ;  EN European Number

(defconstant $kUCBidiCatEuroNumberSeparator 4)  ;  ES European Number Separator

(defconstant $kUCBidiCatEuroNumberTerminator 5) ;  ET European Number Terminator

(defconstant $kUCBidiCatArabicNumber 6)         ;  AN Arabic Number

(defconstant $kUCBidiCatCommonNumberSeparator 7);  CS Common Number Separator
;  Separators:

(defconstant $kUCBidiCatBlockSeparator 8)       ;  B  Paragraph Separator (was Block Separator)

(defconstant $kUCBidiCatSegmentSeparator 9)     ;  S  Segment Separator
;  Neutrals:

(defconstant $kUCBidiCatWhitespace 10)          ;  WS Whitespace

(defconstant $kUCBidiCatOtherNeutral 11)        ;  ON Other Neutrals (unassigned codes could use this)
;  New categories for Unicode 3.0

(defconstant $kUCBidiCatRightLeftArabic 12)     ;  AL Right-to-Left Arabic (was Arabic Letter)

(defconstant $kUCBidiCatLeftRightEmbedding 13)  ;  LRE    Left-to-Right Embedding

(defconstant $kUCBidiCatRightLeftEmbedding 14)  ;  RLE    Right-to-Left Embedding

(defconstant $kUCBidiCatLeftRightOverride 15)   ;  LRO    Left-to-Right Override

(defconstant $kUCBidiCatRightLeftOverride 16)   ;  RLO    Right-to-Left Override

(defconstant $kUCBidiCatPopDirectionalFormat 17);  PDF    Pop Directional Format

(defconstant $kUCBidiCatNonSpacingMark 18)      ;  NSM    Non-Spacing Mark

(defconstant $kUCBidiCatBoundaryNeutral 19)     ;  BN Boundary Neutral

; 
;    -------------------------------------------------------------------------------------------------
;    Prototypes for TextEncoding functions
;    -------------------------------------------------------------------------------------------------
; 
; 
;  *  CreateTextEncoding()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextCommon 1.1 and later
;  

(deftrap-inline "_CreateTextEncoding" 
   ((encodingBase :UInt32)
    (encodingVariant :UInt32)
    (encodingFormat :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  GetTextEncodingBase()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextCommon 1.1 and later
;  

(deftrap-inline "_GetTextEncodingBase" 
   ((encoding :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  GetTextEncodingVariant()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextCommon 1.1 and later
;  

(deftrap-inline "_GetTextEncodingVariant" 
   ((encoding :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  GetTextEncodingFormat()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextCommon 1.1 and later
;  

(deftrap-inline "_GetTextEncodingFormat" 
   ((encoding :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  ResolveDefaultTextEncoding()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextCommon 1.1 and later
;  

(deftrap-inline "_ResolveDefaultTextEncoding" 
   ((encoding :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :UInt32
() )
; 
;  *  GetTextEncodingName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextCommon 1.1 and later
;  

(deftrap-inline "_GetTextEncodingName" 
   ((iEncoding :UInt32)
    (iNamePartSelector :UInt32)
    (iPreferredRegion :SInt16)
    (iPreferredEncoding :UInt32)
    (iOutputBufLen :UInt32)
    (oNameLength (:pointer :BYTECOUNT))
    (oActualRegion (:pointer :REGIONCODE))      ;  can be NULL 
    (oActualEncoding (:pointer :TEXTENCODING))  ;  can be NULL 
    (oEncodingName (:pointer :UInt8))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  TECGetInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextCommon 1.2.1 and later
;  

(deftrap-inline "_TECGetInfo" 
   ((tecInfo (:pointer :TECINFOHANDLE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  UpgradeScriptInfoToTextEncoding()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextCommon 1.1 and later
;  

(deftrap-inline "_UpgradeScriptInfoToTextEncoding" 
   ((iTextScriptID :SInt16)
    (iTextLanguageID :SInt16)
    (iRegionID :SInt16)
    (iTextFontname (:pointer :STR255))
    (oEncoding (:pointer :TEXTENCODING))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  RevertTextEncodingToScriptInfo()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextCommon 1.1 and later
;  

(deftrap-inline "_RevertTextEncodingToScriptInfo" 
   ((iEncoding :UInt32)
    (oTextScriptID (:pointer :SCRIPTCODE))
    (oTextLanguageID (:pointer :LANGCODE))      ;  can be NULL 
    (oTextFontname (:pointer :STR255))          ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  GetTextEncodingFromScriptInfo()
;  *  
;  *  Summary:
;  *    Converts any combination of a Mac OS script code, a language
;  *    code, and a region code to a text encoding.
;  *  
;  *  Discussion:
;  *    This function is almost identical to
;  *    UpgradeScriptInfoToTextEncoding except it doesn't take a font
;  *    name and it is available in CoreServices.
;  *  
;  *  Parameters:
;  *    
;  *    iTextScriptID:
;  *      A valid Script Manager script code. The Mac OS Script Manager
;  *      defines constants for script codes using this format: smXxx. To
;  *      designate the system script, specify the meta-value of
;  *      smSystemScript. To indicate that you do not want to provide a
;  *      script code for this parameter, specify the constant
;  *      kTextScriptDontCare.
;  *    
;  *    iTextLanguageID:
;  *      A valid Script Manager language code. The Mac OS Script Manager
;  *      defines constants for language codes using this format:
;  *      langXxx. To indicate that you do not want to provide a language
;  *      code for this parameter, specify the constant
;  *      kTextLanguageDontCare.
;  *    
;  *    iTextRegionID:
;  *      A valid Script Manager region code. The Mac OS Script Manager
;  *      defines constants for region codes using this format: verXxx.
;  *      To indicate that you do not want to provide a region code for
;  *      this parameter, specify the constant kTextRegionDontCare.
;  *    
;  *    oEncoding:
;  *      A pointer to a value of type TextEncoding. On return, this
;  *      value holds the text encoding specification that the function
;  *      created from the other values you provided.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetTextEncodingFromScriptInfo" 
   ((iTextScriptID :SInt16)
    (iTextLanguageID :SInt16)
    (iTextRegionID :SInt16)
    (oEncoding (:pointer :TEXTENCODING))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  GetScriptInfoFromTextEncoding()
;  *  
;  *  Summary:
;  *    Converts the given Mac OS text encoding specification to the
;  *    corresponding script code and, if possible, language code.
;  *  
;  *  Discussion:
;  *    This function is almost identical to
;  *    RevertTextEncodingToScriptInfo except it doesn't return a font
;  *    name and it is available in CoreServices.
;  *  
;  *  Parameters:
;  *    
;  *    iEncoding:
;  *      The text encoding specification to be converted.
;  *    
;  *    oTextScriptID:
;  *      A pointer to a value of type ScriptCode. On return, a Mac OS
;  *      script code that corresponds to the text encoding specification
;  *      you identified in the iEncoding parameter. If you do not pass a
;  *      pointer for this parameter, the function returns a paramErr
;  *      result code.
;  *    
;  *    oTextLanguageID:
;  *      A pointer to a value of type LangCode. On input, if you do not
;  *      want the function to return the language code, specify NULL as
;  *      the value of this parameter. On return, the appropriate
;  *      language code, if the language can be unambiguously derived
;  *      from the text encoding specification, for example, Japanese,
;  *      and you did not set the parameter to NULL. If you do not
;  *      specify NULL on input and the language is ambiguousÑthat is,
;  *      the function cannot accurately derive it from the text encoding
;  *      specificationÑthe function returns a value of
;  *      kTextLanguageDontCare.
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.2 and later in CoreServices.framework
;  *    CarbonLib:        not available in CarbonLib 1.x, is available on Mac OS X version 10.2 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_GetScriptInfoFromTextEncoding" 
   ((iEncoding :UInt32)
    (oTextScriptID (:pointer :SCRIPTCODE))
    (oTextLanguageID (:pointer :LANGCODE))      ;  can be NULL 
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :OSStatus
() )
; 
;  *  NearestMacTextEncodings()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextCommon 1.5 and later
;  

(deftrap-inline "_NearestMacTextEncodings" 
   ((generalEncoding :UInt32)
    (bestMacEncoding (:pointer :TEXTENCODING))
    (alternateMacEncoding (:pointer :TEXTENCODING))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  UCGetCharProperty()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in TextCommon 1.5 and later
;  

(deftrap-inline "_UCGetCharProperty" 
   ((charPtr (:pointer :UniChar))
    (textLength :UInt32)
    (propType :SInt32)
    (propValue (:pointer :UCCHARPROPERTYVALUE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;    -------------------------------------------------------------------------------------------------
;    Surrogate pair utilities
;    -------------------------------------------------------------------------------------------------
; 

; #if !defined(UC_INLINE)

; #if defined(__GNUC__)
#| 
; #define UC_INLINE static __inline__
 |#

; #elif defined(__MWERKS__) || defined(__cplusplus)
#| 
; #define UC_INLINE static inline
 |#

; #endif


; #endif

;  surrogate ranges

(defconstant $kUCHighSurrogateRangeStart #xD800)
(defconstant $kUCHighSurrogateRangeEnd #xDBFF)
(defconstant $kUCLowSurrogateRangeStart #xDC00)
(defconstant $kUCLowSurrogateRangeEnd #xDFFF)
; !
;    @function UCIsSurrogateHighCharacter
;    Reports whether or not the character is a high surrogate.
;   @param character  The character to be checked.
;  @result true, if character is a high surrogate, otherwise false.
; 
#|
 confused about UC_INLINE                       ;  return ( ( character >= kUCHighSurrogateRangeStart ) && (character <= kUCHighSurrogateRangeEnd ) ? true : false ); 
 return #\( #\( character & 0xFC00UL #\) == kUCHighSurrogateRangeStart #\)
|#
; !
;   @function UCIsSurrogateLowCharacter
;     Reports whether or not the character is a low surrogate.
;    @param character  The character to be checked.
;  @result true, if character is a low surrogate, otherwise false.
; 
#|
 confused about UC_INLINE                       ;  return ( ( character >= kUCLowSurrogateRangeStart ) && ( character <= kUCLowSurrogateRangeEnd ) ? true : false ); 
 return #\( #\( character & 0xFC00UL #\) == kUCLowSurrogateRangeStart #\)
|#
; !
;    @function UCGetUnicodeScalarValueForSurrogatePair
;   Returns the UTF-32 value corresponding to the surrogate pair passed in.
;     @param surrogateHigh  The high surrogate character.  If this parameter
;          is not a valid high surrogate character, the behavior is undefined.
;     @param surrogateLow  The low surrogate character.  If this parameter
;            is not a valid low surrogate character, the behavior is undefined.
;  @result The UTF-32 value for the surrogate pair.
; 
#|
 confused about UC_INLINE return #\( #\( surrogateHigh - kUCHighSurrogateRangeStart #\) << 10 #\) + #\( surrogateLow - kUCLowSurrogateRangeStart #\) + 0x0010000UL
|#
; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __TEXTCOMMON__ */


(provide-interface "TextCommon")