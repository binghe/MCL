(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFStringEncodingExt.h"
; at Sunday July 2,2006 7:23:05 pm.
; 	CFStringEncodingExt.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFSTRINGENCODINGEXT__)
(defconstant $__COREFOUNDATION_CFSTRINGENCODINGEXT__ 1)
; #define __COREFOUNDATION_CFSTRINGENCODINGEXT__ 1

(require-interface "CoreFoundation/CFBase")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
;   kCFStringEncodingMacRoman = 0L, defined in CoreFoundation/CFString.h 

(defconstant $kCFStringEncodingMacJapanese 1)
(defconstant $kCFStringEncodingMacChineseTrad 2)
(defconstant $kCFStringEncodingMacKorean 3)
(defconstant $kCFStringEncodingMacArabic 4)
(defconstant $kCFStringEncodingMacHebrew 5)
(defconstant $kCFStringEncodingMacGreek 6)
(defconstant $kCFStringEncodingMacCyrillic 7)
(defconstant $kCFStringEncodingMacDevanagari 9)
(defconstant $kCFStringEncodingMacGurmukhi 10)
(defconstant $kCFStringEncodingMacGujarati 11)
(defconstant $kCFStringEncodingMacOriya 12)
(defconstant $kCFStringEncodingMacBengali 13)
(defconstant $kCFStringEncodingMacTamil 14)
(defconstant $kCFStringEncodingMacTelugu 15)
(defconstant $kCFStringEncodingMacKannada 16)
(defconstant $kCFStringEncodingMacMalayalam 17)
(defconstant $kCFStringEncodingMacSinhalese 18)
(defconstant $kCFStringEncodingMacBurmese 19)
(defconstant $kCFStringEncodingMacKhmer 20)
(defconstant $kCFStringEncodingMacThai 21)
(defconstant $kCFStringEncodingMacLaotian 22)
(defconstant $kCFStringEncodingMacGeorgian 23)
(defconstant $kCFStringEncodingMacArmenian 24)
(defconstant $kCFStringEncodingMacChineseSimp 25)
(defconstant $kCFStringEncodingMacTibetan 26)
(defconstant $kCFStringEncodingMacMongolian 27)
(defconstant $kCFStringEncodingMacEthiopic 28)
(defconstant $kCFStringEncodingMacCentralEurRoman 29)
(defconstant $kCFStringEncodingMacVietnamese 30)
(defconstant $kCFStringEncodingMacExtArabic 31) ;  The following use script code 0, smRoman 

(defconstant $kCFStringEncodingMacSymbol 33)
(defconstant $kCFStringEncodingMacDingbats 34)
(defconstant $kCFStringEncodingMacTurkish 35)
(defconstant $kCFStringEncodingMacCroatian 36)
(defconstant $kCFStringEncodingMacIcelandic 37)
(defconstant $kCFStringEncodingMacRomanian 38)
(defconstant $kCFStringEncodingMacCeltic 39)
(defconstant $kCFStringEncodingMacGaelic 40)    ;  The following use script code 4, smArabic 

(defconstant $kCFStringEncodingMacFarsi #x8C)   ;  Like MacArabic but uses Farsi digits 
;  The following use script code 7, smCyrillic 

(defconstant $kCFStringEncodingMacUkrainian #x98);  The following use script code 32, smUnimplemented 

(defconstant $kCFStringEncodingMacInuit #xEC)
(defconstant $kCFStringEncodingMacVT100 #xFC)   ;  VT100/102 font from Comm Toolbox: Latin-1 repertoire + box drawing etc 
;  Special Mac OS encodings

(defconstant $kCFStringEncodingMacHFS #xFF)     ;  Meta-value, should never appear in a table 
;  Unicode & ISO UCS encodings begin at 0x100 
;  We don't use Unicode variations defined in TextEncoding; use the ones in CFString.h, instead. 
;  ISO 8-bit and 7-bit encodings begin at 0x200 
;   kCFStringEncodingISOLatin1 = 0x0201, defined in CoreFoundation/CFString.h 

(defconstant $kCFStringEncodingISOLatin2 #x202) ;  ISO 8859-2 

(defconstant $kCFStringEncodingISOLatin3 #x203) ;  ISO 8859-3 

(defconstant $kCFStringEncodingISOLatin4 #x204) ;  ISO 8859-4 

(defconstant $kCFStringEncodingISOLatinCyrillic #x205);  ISO 8859-5 

(defconstant $kCFStringEncodingISOLatinArabic #x206);  ISO 8859-6, =ASMO 708, =DOS CP 708 

(defconstant $kCFStringEncodingISOLatinGreek #x207);  ISO 8859-7 

(defconstant $kCFStringEncodingISOLatinHebrew #x208);  ISO 8859-8 

(defconstant $kCFStringEncodingISOLatin5 #x209) ;  ISO 8859-9 

(defconstant $kCFStringEncodingISOLatin6 #x20A) ;  ISO 8859-10 

(defconstant $kCFStringEncodingISOLatinThai #x20B);  ISO 8859-11 

(defconstant $kCFStringEncodingISOLatin7 #x20D) ;  ISO 8859-13 

(defconstant $kCFStringEncodingISOLatin8 #x20E) ;  ISO 8859-14 

(defconstant $kCFStringEncodingISOLatin9 #x20F) ;  ISO 8859-15 
;  MS-DOS & Windows encodings begin at 0x400 

(defconstant $kCFStringEncodingDOSLatinUS #x400);  code page 437 

(defconstant $kCFStringEncodingDOSGreek #x405)  ;  code page 737 (formerly code page 437G) 

(defconstant $kCFStringEncodingDOSBalticRim #x406);  code page 775 

(defconstant $kCFStringEncodingDOSLatin1 #x410) ;  code page 850, "Multilingual" 

(defconstant $kCFStringEncodingDOSGreek1 #x411) ;  code page 851 

(defconstant $kCFStringEncodingDOSLatin2 #x412) ;  code page 852, Slavic 

(defconstant $kCFStringEncodingDOSCyrillic #x413);  code page 855, IBM Cyrillic 

(defconstant $kCFStringEncodingDOSTurkish #x414);  code page 857, IBM Turkish 

(defconstant $kCFStringEncodingDOSPortuguese #x415);  code page 860 

(defconstant $kCFStringEncodingDOSIcelandic #x416);  code page 861 

(defconstant $kCFStringEncodingDOSHebrew #x417) ;  code page 862 

(defconstant $kCFStringEncodingDOSCanadianFrench #x418);  code page 863 

(defconstant $kCFStringEncodingDOSArabic #x419) ;  code page 864 

(defconstant $kCFStringEncodingDOSNordic #x41A) ;  code page 865 

(defconstant $kCFStringEncodingDOSRussian #x41B);  code page 866 

(defconstant $kCFStringEncodingDOSGreek2 #x41C) ;  code page 869, IBM Modern Greek 

(defconstant $kCFStringEncodingDOSThai #x41D)   ;  code page 874, also for Windows 

(defconstant $kCFStringEncodingDOSJapanese #x420);  code page 932, also for Windows 

(defconstant $kCFStringEncodingDOSChineseSimplif #x421);  code page 936, also for Windows 

(defconstant $kCFStringEncodingDOSKorean #x422) ;  code page 949, also for Windows; Unified Hangul Code 

(defconstant $kCFStringEncodingDOSChineseTrad #x423);  code page 950, also for Windows 
;   kCFStringEncodingWindowsLatin1 = 0x0500, defined in CoreFoundation/CFString.h 

(defconstant $kCFStringEncodingWindowsLatin2 #x501);  code page 1250, Central Europe 

(defconstant $kCFStringEncodingWindowsCyrillic #x502);  code page 1251, Slavic Cyrillic 

(defconstant $kCFStringEncodingWindowsGreek #x503);  code page 1253 

(defconstant $kCFStringEncodingWindowsLatin5 #x504);  code page 1254, Turkish 

(defconstant $kCFStringEncodingWindowsHebrew #x505);  code page 1255 

(defconstant $kCFStringEncodingWindowsArabic #x506);  code page 1256 

(defconstant $kCFStringEncodingWindowsBalticRim #x507);  code page 1257 

(defconstant $kCFStringEncodingWindowsKoreanJohab #x510);  code page 1361, for Windows NT 

(defconstant $kCFStringEncodingWindowsVietnamese #x508);  code page 1258 
;  Various national standards begin at 0x600 
;   kCFStringEncodingASCII = 0x0600, defined in CoreFoundation/CFString.h 

(defconstant $kCFStringEncodingJIS_X0201_76 #x620)
(defconstant $kCFStringEncodingJIS_X0208_83 #x621)
(defconstant $kCFStringEncodingJIS_X0208_90 #x622)
(defconstant $kCFStringEncodingJIS_X0212_90 #x623)
(defconstant $kCFStringEncodingJIS_C6226_78 #x624)
(defconstant $kCFStringEncodingShiftJIS_X0213_00 #x628);  Shift-JIS format encoding of JIS X0213 planes 1 and 2

(defconstant $kCFStringEncodingGB_2312_80 #x630)
(defconstant $kCFStringEncodingGBK_95 #x631)    ;  annex to GB 13000-93; for Windows 95 

(defconstant $kCFStringEncodingGB_18030_2000 #x632)
(defconstant $kCFStringEncodingKSC_5601_87 #x640);  same as KSC 5601-92 without Johab annex 

(defconstant $kCFStringEncodingKSC_5601_92_Johab #x641);  KSC 5601-92 Johab annex 

(defconstant $kCFStringEncodingCNS_11643_92_P1 #x651);  CNS 11643-1992 plane 1 

(defconstant $kCFStringEncodingCNS_11643_92_P2 #x652);  CNS 11643-1992 plane 2 

(defconstant $kCFStringEncodingCNS_11643_92_P3 #x653);  CNS 11643-1992 plane 3 (was plane 14 in 1986 version) 
;  ISO 2022 collections begin at 0x800 

(defconstant $kCFStringEncodingISO_2022_JP #x820)
(defconstant $kCFStringEncodingISO_2022_JP_2 #x821)
(defconstant $kCFStringEncodingISO_2022_JP_1 #x822);  RFC 2237

(defconstant $kCFStringEncodingISO_2022_JP_3 #x823);  JIS X0213

(defconstant $kCFStringEncodingISO_2022_CN #x830)
(defconstant $kCFStringEncodingISO_2022_CN_EXT #x831)
(defconstant $kCFStringEncodingISO_2022_KR #x840);  EUC collections begin at 0x900 

(defconstant $kCFStringEncodingEUC_JP #x920)    ;  ISO 646, 1-byte katakana, JIS 208, JIS 212 

(defconstant $kCFStringEncodingEUC_CN #x930)    ;  ISO 646, GB 2312-80 

(defconstant $kCFStringEncodingEUC_TW #x931)    ;  ISO 646, CNS 11643-1992 Planes 1-16 

(defconstant $kCFStringEncodingEUC_KR #x940)    ;  ISO 646, KS C 5601-1987 
;  Misc standards begin at 0xA00 

(defconstant $kCFStringEncodingShiftJIS #xA01)  ;  plain Shift-JIS 

(defconstant $kCFStringEncodingKOI8_R #xA02)    ;  Russian internet standard 

(defconstant $kCFStringEncodingBig5 #xA03)      ;  Big-5 (has variants) 

(defconstant $kCFStringEncodingMacRomanLatin1 #xA04);  Mac OS Roman permuted to align with ISO Latin-1 

(defconstant $kCFStringEncodingHZ_GB_2312 #xA05);  HZ (RFC 1842, for Chinese mail & news) 

(defconstant $kCFStringEncodingBig5_HKSCS_1999 #xA06);  Big-5 with Hong Kong special char set supplement
;  Other platform encodings
;   kCFStringEncodingNextStepLatin = 0x0B01, defined in CoreFoundation/CFString.h 
;  EBCDIC & IBM host encodings begin at 0xC00 

(defconstant $kCFStringEncodingEBCDIC_US #xC01) ;  basic EBCDIC-US 

(defconstant $kCFStringEncodingEBCDIC_CP037 #xC02);  code page 037, extended EBCDIC (Latin-1 set) for US,Canada... 

(def-mactype :CFStringEncodings (find-mactype ':SINT32))

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* !__COREFOUNDATION_CFSTRINGENCODINGEXT__ */


(provide-interface "CFStringEncodingExt")