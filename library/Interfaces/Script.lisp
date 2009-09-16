(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:Script.h"
; at Sunday July 2,2006 7:23:08 pm.
; 
;      File:       CarbonCore/Script.h
;  
;      Contains:   Script Manager interfaces
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1986-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __SCRIPT__
; #define __SCRIPT__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __INTLRESOURCES__

(require-interface "CarbonCore/IntlResources")

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
;  Meta script codes:

(defconstant $smSystemScript -1)                ;  designates system script.

(defconstant $smCurrentScript -2)               ;  designates current font script.
;  designates any script

(defconstant $smAllScripts -3)
; 
;    Script codes:
;    These specify a Mac OS encoding that is related to a FOND ID range.
;    Some of the encodings have several variants (e.g. for different localized systems)
;     which all share the same script code.
;    Not all of these script codes are currently supported by Apple software.
;    Notes:
;    - Script code 0 (smRoman) is also used (instead of smGreek) for the Greek encoding
;      in the Greek localized system.
;    - Script code 28 (smEthiopic) is also used for the Inuit encoding in the Inuktitut
;      system.
; 

(defconstant $smRoman 0)
(defconstant $smJapanese 1)
(defconstant $smTradChinese 2)                  ;  Traditional Chinese

(defconstant $smKorean 3)
(defconstant $smArabic 4)
(defconstant $smHebrew 5)
(defconstant $smGreek 6)
(defconstant $smCyrillic 7)
(defconstant $smRSymbol 8)                      ;  Right-left symbol

(defconstant $smDevanagari 9)
(defconstant $smGurmukhi 10)
(defconstant $smGujarati 11)
(defconstant $smOriya 12)
(defconstant $smBengali 13)
(defconstant $smTamil 14)
(defconstant $smTelugu 15)
(defconstant $smKannada 16)                     ;  Kannada/Kanarese

(defconstant $smMalayalam 17)
(defconstant $smSinhalese 18)
(defconstant $smBurmese 19)
(defconstant $smKhmer 20)                       ;  Khmer/Cambodian

(defconstant $smThai 21)
(defconstant $smLao 22)
(defconstant $smGeorgian 23)
(defconstant $smArmenian 24)
(defconstant $smSimpChinese 25)                 ;  Simplified Chinese

(defconstant $smTibetan 26)
(defconstant $smMongolian 27)
(defconstant $smEthiopic 28)
(defconstant $smGeez 28)                        ;  Synonym for smEthiopic

(defconstant $smCentralEuroRoman 29)            ;  For Czech, Slovak, Polish, Hungarian, Baltic langs

(defconstant $smVietnamese 30)
(defconstant $smExtArabic 31)                   ;  extended Arabic

(defconstant $smUninterp 32)                    ;  uninterpreted symbols, e.g. palette symbols

;  Extended script code for full Unicode input

(defconstant $smUnicodeScript 126)
;  Obsolete script code names (kept for backward compatibility):

(defconstant $smChinese 2)                      ;  (Use smTradChinese or smSimpChinese)

(defconstant $smRussian 7)                      ;  Use smCyrillic
;  smMaldivian = 25: deleted, no code for Maldivian

(defconstant $smLaotian 22)                     ;  Use smLao                                     

(defconstant $smAmharic 28)                     ;  Use smEthiopic or smGeez

(defconstant $smSlavic 29)                      ;  Use smCentralEuroRoman

(defconstant $smEastEurRoman 29)                ;  Use smCentralEuroRoman

(defconstant $smSindhi 31)                      ;  Use smExtArabic

(defconstant $smKlingon 32)
; 
;    Language codes:
;    These specify a language implemented using a particular Mac OS encoding.
;    Not all of these language codes are currently supported by Apple software.
; 

(defconstant $langEnglish 0)                    ;  smRoman script

(defconstant $langFrench 1)                     ;  smRoman script

(defconstant $langGerman 2)                     ;  smRoman script

(defconstant $langItalian 3)                    ;  smRoman script

(defconstant $langDutch 4)                      ;  smRoman script

(defconstant $langSwedish 5)                    ;  smRoman script

(defconstant $langSpanish 6)                    ;  smRoman script

(defconstant $langDanish 7)                     ;  smRoman script

(defconstant $langPortuguese 8)                 ;  smRoman script

(defconstant $langNorwegian 9)                  ;  (Bokmal) smRoman script

(defconstant $langHebrew 10)                    ;  smHebrew script

(defconstant $langJapanese 11)                  ;  smJapanese script

(defconstant $langArabic 12)                    ;  smArabic script

(defconstant $langFinnish 13)                   ;  smRoman script

(defconstant $langGreek 14)                     ;  Greek script (monotonic) using smRoman script code

(defconstant $langIcelandic 15)                 ;  modified smRoman/Icelandic script

(defconstant $langMaltese 16)                   ;  Roman script

(defconstant $langTurkish 17)                   ;  modified smRoman/Turkish script

(defconstant $langCroatian 18)                  ;  modified smRoman/Croatian script

(defconstant $langTradChinese 19)               ;  Chinese (Mandarin) in traditional characters

(defconstant $langUrdu 20)                      ;  smArabic script

(defconstant $langHindi 21)                     ;  smDevanagari script

(defconstant $langThai 22)                      ;  smThai script

(defconstant $langKorean 23)                    ;  smKorean script


(defconstant $langLithuanian 24)                ;  smCentralEuroRoman script

(defconstant $langPolish 25)                    ;  smCentralEuroRoman script

(defconstant $langHungarian 26)                 ;  smCentralEuroRoman script

(defconstant $langEstonian 27)                  ;  smCentralEuroRoman script

(defconstant $langLatvian 28)                   ;  smCentralEuroRoman script

(defconstant $langSami 29)                      ;  language of the Sami people of N. Scandinavia             

(defconstant $langFaroese 30)                   ;  modified smRoman/Icelandic script                      

(defconstant $langFarsi 31)                     ;  modified smArabic/Farsi script

(defconstant $langPersian 31)                   ;  Synonym for langFarsi

(defconstant $langRussian 32)                   ;  smCyrillic script

(defconstant $langSimpChinese 33)               ;  Chinese (Mandarin) in simplified characters

(defconstant $langFlemish 34)                   ;  smRoman script

(defconstant $langIrishGaelic 35)               ;  smRoman or modified smRoman/Celtic script (without dot above)   

(defconstant $langAlbanian 36)                  ;  smRoman script

(defconstant $langRomanian 37)                  ;  modified smRoman/Romanian script

(defconstant $langCzech 38)                     ;  smCentralEuroRoman script

(defconstant $langSlovak 39)                    ;  smCentralEuroRoman script

(defconstant $langSlovenian 40)                 ;  modified smRoman/Croatian script

(defconstant $langYiddish 41)                   ;  smHebrew script

(defconstant $langSerbian 42)                   ;  smCyrillic script

(defconstant $langMacedonian 43)                ;  smCyrillic script

(defconstant $langBulgarian 44)                 ;  smCyrillic script

(defconstant $langUkrainian 45)                 ;  modified smCyrillic/Ukrainian script

(defconstant $langByelorussian 46)              ;  smCyrillic script

(defconstant $langBelorussian 46)               ;  Synonym for langByelorussian                          


(defconstant $langUzbek 47)                     ;  Cyrillic script

(defconstant $langKazakh 48)                    ;  Cyrillic script

(defconstant $langAzerbaijani 49)               ;  Azerbaijani in Cyrillic script

(defconstant $langAzerbaijanAr 50)              ;  Azerbaijani in Arabic script

(defconstant $langArmenian 51)                  ;  smArmenian script

(defconstant $langGeorgian 52)                  ;  smGeorgian script

(defconstant $langMoldavian 53)                 ;  smCyrillic script

(defconstant $langKirghiz 54)                   ;  Cyrillic script

(defconstant $langTajiki 55)                    ;  Cyrillic script

(defconstant $langTurkmen 56)                   ;  Cyrillic script

(defconstant $langMongolian 57)                 ;  Mongolian in smMongolian script

(defconstant $langMongolianCyr 58)              ;  Mongolian in Cyrillic script

(defconstant $langPashto 59)                    ;  Arabic script

(defconstant $langKurdish 60)                   ;  smArabic script

(defconstant $langKashmiri 61)                  ;  Arabic script

(defconstant $langSindhi 62)                    ;  Arabic script

(defconstant $langTibetan 63)                   ;  smTibetan script

(defconstant $langNepali 64)                    ;  smDevanagari script

(defconstant $langSanskrit 65)                  ;  smDevanagari script

(defconstant $langMarathi 66)                   ;  smDevanagari script

(defconstant $langBengali 67)                   ;  smBengali script

(defconstant $langAssamese 68)                  ;  smBengali script

(defconstant $langGujarati 69)                  ;  smGujarati script

(defconstant $langPunjabi 70)                   ;  smGurmukhi script


(defconstant $langOriya 71)                     ;  smOriya script

(defconstant $langMalayalam 72)                 ;  smMalayalam script

(defconstant $langKannada 73)                   ;  smKannada script

(defconstant $langTamil 74)                     ;  smTamil script

(defconstant $langTelugu 75)                    ;  smTelugu script

(defconstant $langSinhalese 76)                 ;  smSinhalese script

(defconstant $langBurmese 77)                   ;  smBurmese script

(defconstant $langKhmer 78)                     ;  smKhmer script

(defconstant $langLao 79)                       ;  smLao script

(defconstant $langVietnamese 80)                ;  smVietnamese script

(defconstant $langIndonesian 81)                ;  smRoman script

(defconstant $langTagalog 82)                   ;  Roman script

(defconstant $langMalayRoman 83)                ;  Malay in smRoman script

(defconstant $langMalayArabic 84)               ;  Malay in Arabic script

(defconstant $langAmharic 85)                   ;  smEthiopic script

(defconstant $langTigrinya 86)                  ;  smEthiopic script

(defconstant $langOromo 87)                     ;  smEthiopic script

(defconstant $langSomali 88)                    ;  smRoman script

(defconstant $langSwahili 89)                   ;  smRoman script

(defconstant $langKinyarwanda 90)               ;  smRoman script

(defconstant $langRuanda 90)                    ;  synonym for langKinyarwanda

(defconstant $langRundi 91)                     ;  smRoman script

(defconstant $langNyanja 92)                    ;  smRoman script

(defconstant $langChewa 92)                     ;  synonym for langNyanja

(defconstant $langMalagasy 93)                  ;  smRoman script

(defconstant $langEsperanto 94)                 ;  Roman script


(defconstant $langWelsh #x80)                   ;  modified smRoman/Celtic script

(defconstant $langBasque #x81)                  ;  smRoman script

(defconstant $langCatalan #x82)                 ;  smRoman script

(defconstant $langLatin #x83)                   ;  smRoman script

(defconstant $langQuechua #x84)                 ;  smRoman script

(defconstant $langGuarani #x85)                 ;  smRoman script

(defconstant $langAymara #x86)                  ;  smRoman script

(defconstant $langTatar #x87)                   ;  Cyrillic script

(defconstant $langUighur #x88)                  ;  Arabic script

(defconstant $langDzongkha #x89)                ;  (lang of Bhutan) smTibetan script

(defconstant $langJavaneseRom #x8A)             ;  Javanese in smRoman script

(defconstant $langSundaneseRom #x8B)            ;  Sundanese in smRoman script

(defconstant $langGalician #x8C)                ;  smRoman script

(defconstant $langAfrikaans #x8D)               ;  smRoman script                                   


(defconstant $langBreton #x8E)                  ;  smRoman or modified smRoman/Celtic script                 

(defconstant $langInuktitut #x8F)               ;  Inuit script using smEthiopic script code                 

(defconstant $langScottishGaelic #x90)          ;  smRoman or modified smRoman/Celtic script                 

(defconstant $langManxGaelic #x91)              ;  smRoman or modified smRoman/Celtic script                 

(defconstant $langIrishGaelicScript #x92)       ;  modified smRoman/Gaelic script (using dot above)               

(defconstant $langTongan #x93)                  ;  smRoman script                                   

(defconstant $langGreekAncient #x94)            ;  Classical Greek, polytonic orthography                    

(defconstant $langGreenlandic #x95)             ;  smRoman script                                   

(defconstant $langAzerbaijanRoman #x96)         ;  Azerbaijani in Roman script                             

(defconstant $langNynorsk #x97)                 ;  Norwegian Nyorsk in smRoman


(defconstant $langUnspecified #x7FFF)           ;  Special code for use in resources (such as 'itlm')           

; 
;    Obsolete language code names (kept for backward compatibility):
;    Misspelled, ambiguous, misleading, considered pejorative, archaic, etc.
; 

(defconstant $langPortugese 8)                  ;  Use langPortuguese

(defconstant $langMalta 16)                     ;  Use langMaltese

(defconstant $langYugoslavian 18)               ;  (use langCroatian, langSerbian, etc.)

(defconstant $langChinese 19)                   ;  (use langTradChinese or langSimpChinese)

(defconstant $langLettish 28)                   ;  Use langLatvian                                     

(defconstant $langLapponian 29)                 ;  Use langSami

(defconstant $langLappish 29)                   ;  Use langSami

(defconstant $langSaamisk 29)                   ;  Use langSami                                    

(defconstant $langFaeroese 30)                  ;  Use langFaroese                                     

(defconstant $langIrish 35)                     ;  Use langIrishGaelic                                  

(defconstant $langGalla 87)                     ;  Use langOromo                                 

(defconstant $langAfricaans #x8D)               ;  Use langAfrikaans                                

(defconstant $langGreekPoly #x94)               ;  Use langGreekAncient

; 
;    Region codes:
;    These typically specify a combination of a language code and a particular region.
;    Some of these numeric values are reserved just for extra resource IDs associated
;    with certain regions; these are not actual region codes, and are noted in the comments.
;    Not all of the region codes are currently supported by Apple software.
;    When relevant, the following list also provides:
;    - The Apple part number (P/N) code for software localized for the specified region.
;    - The two-letter ISO language and country codes (from ISO 639 and ISO 3166). The
;      language code (lowercase) is first, then '_', then the country code (uppercase).
; 
;  P/N    ISO    codes  comments

(defconstant $verUS 0)                          ;        en_US

(defconstant $verFrance 1)                      ;  F  fr_FR

(defconstant $verBritain 2)                     ;  B  en_GB

(defconstant $verGermany 3)                     ;  D  de_DE

(defconstant $verItaly 4)                       ;  T  it_IT

(defconstant $verNetherlands 5)                 ;  N  nl_NL

(defconstant $verFlemish 6)                     ;  FN nl_BE     Flemish (Dutch) for Belgium                 

(defconstant $verSweden 7)                      ;  S  sv_SE

(defconstant $verSpain 8)                       ;  E  es_ES       Spanish for Spain

(defconstant $verDenmark 9)                     ;  DK da_DK

(defconstant $verPortugal 10)                   ;  PO pt_PT     Portuguese for Portugal

(defconstant $verFrCanada 11)                   ;  C  fr_CA       French for Canada

(defconstant $verNorway 12)                     ;  H  nb_NO       Bokmål

(defconstant $verIsrael 13)                     ;  HB he_IL     Hebrew

(defconstant $verJapan 14)                      ;  J  ja_JP

(defconstant $verAustralia 15)                  ;  X  en_AU       English for Australia

(defconstant $verArabic 16)                     ;  AB ar       Arabic for N Africa, Arabian peninsula, Levant

(defconstant $verFinland 17)                    ;  K  fi_FI

(defconstant $verFrSwiss 18)                    ;  SF fr_CH     French Swiss

(defconstant $verGrSwiss 19)                    ;  SD de_CH     German Swiss

(defconstant $verGreece 20)                     ;  GR el_GR     Monotonic Greek (modern)

(defconstant $verIceland 21)                    ;  IS is_IS

(defconstant $verMalta 22)                      ;  MA mt_MT

(defconstant $verCyprus 23)                     ;  CY el_CY

(defconstant $verTurkey 24)                     ;  TU tr_TR

(defconstant $verYugoCroatian 25)               ;  YU hr_HR     Croatian for Yugoslavia; now use verCroatia (68)


(defconstant $verNetherlandsComma 26)           ;               ID for KCHR resource - Dutch

(defconstant $verFlemishPoint 27)               ;               ID for KCHR resource - Belgium

(defconstant $verCanadaComma 28)                ;               ID for KCHR resource - Canadian ISO

(defconstant $verCanadaPoint 29)                ;               ID for KCHR resource - Canadian; now unused

(defconstant $vervariantPortugal 30)            ;               ID for resource; now unused

(defconstant $vervariantNorway 31)              ;               ID for resource; now unused

(defconstant $vervariantDenmark 32)             ;               ID for KCHR resource - Danish Mac Plus


(defconstant $verIndiaHindi 33)                 ;        hi_IN     Hindi for India

(defconstant $verPakistanUrdu 34)               ;  UR ur_PK     Urdu for Pakistan                        

(defconstant $verTurkishModified 35)            ;        tr_TR

(defconstant $verItalianSwiss 36)               ;  ST it_CH     Italian Swiss

(defconstant $verInternational 37)              ;  Z  en-ASCII English for international use; ASCII chars only     
;               38 is unassigned

(defconstant $verRomania 39)                    ;  RO ro_RO

(defconstant $verGreekAncient 40)               ;        grc      Ancient Greek, polytonic orthography          

(defconstant $verLithuania 41)                  ;  LT lt_LT

(defconstant $verPoland 42)                     ;  PL pl_PL

(defconstant $verHungary 43)                    ;  MG hu_HU

(defconstant $verEstonia 44)                    ;  EE et_EE

(defconstant $verLatvia 45)                     ;  LV lv_LV

(defconstant $verSami 46)                       ;        se                                        

(defconstant $verFaroeIsl 47)                   ;  FA fo_FO                                    

(defconstant $verIran 48)                       ;  PS fa_IR     Persian/Farsi

(defconstant $verRussia 49)                     ;  RS ru_RU     Russian

(defconstant $verIreland 50)                    ;  GA ga_IE     Irish Gaelic for Ireland (without dot above)     

(defconstant $verKorea 51)                      ;  KH ko_KR

(defconstant $verChina 52)                      ;  CH zh_CN     Simplified Chinese

(defconstant $verTaiwan 53)                     ;  TA zh_TW     Traditional Chinese

(defconstant $verThailand 54)                   ;  TH th_TH

(defconstant $verScriptGeneric 55)              ;  SS          Generic script system (no language or script)       

(defconstant $verCzech 56)                      ;  CZ cs_CZ

(defconstant $verSlovak 57)                     ;  SL sk_SK

(defconstant $verEastAsiaGeneric 58)            ;  FE          Generic East Asia system (no language or script) 

(defconstant $verMagyar 59)                     ;        hu_HU     Unused; see verHungary

(defconstant $verBengali 60)                    ;        bn         Bangladesh or India

(defconstant $verBelarus 61)                    ;  BY be_BY


(defconstant $verUkraine 62)                    ;  UA uk_UA
;               63 is unassigned

(defconstant $verGreeceAlt 64)                  ;        el_GR     unused                              

(defconstant $verSerbian 65)                    ;  SR sr_YU                                    

(defconstant $verSlovenian 66)                  ;  SV sl_SI                                    

(defconstant $verMacedonian 67)                 ;  MD mk_MK                                    

(defconstant $verCroatia 68)                    ;  CR hr_HR
;               69 is unassigned

(defconstant $verGermanReformed 70)             ;        de-1996     Reformed orthography (used formerly unassigned 70)   

(defconstant $verBrazil 71)                     ;  BR pt_BR     Portuguese for Brazil

(defconstant $verBulgaria 72)                   ;  BG bg_BG

(defconstant $verCatalonia 73)                  ;  CA ca_ES     Catalan for Spain

(defconstant $verMultilingual 74)               ;  ZM mul        (no language or script)

(defconstant $verScottishGaelic 75)             ;  GD gd

(defconstant $verManxGaelic 76)                 ;  GV gv       Isle of Man

(defconstant $verBreton 77)                     ;  BZ br

(defconstant $verNunavut 78)                    ;  IU iu_CA     Inuktitut for Canada

(defconstant $verWelsh 79)                      ;  CU cy
;               80 is ID for KCHR resource - Canadian CSA

(defconstant $verIrishGaelicScript 81)          ;  GS ga-dots_IE  Irish Gaelic for Ireland (using dot above)

(defconstant $verEngCanada 82)                  ;  V  en_CA       English for Canada

(defconstant $verBhutan 83)                     ;  BH dz_BT     Dzongkha for Bhutan

(defconstant $verArmenian 84)                   ;  HY hy_AM

(defconstant $verGeorgian 85)                   ;  KR ka_GE

(defconstant $verSpLatinAmerica 86)             ;  LA es_XL     Spanish for Latin America (private ISO 3166 code)
;               87 is ID for KCHR resource - Spanish ISO

(defconstant $verTonga 88)                      ;  TS to_TO
;               89 is ID for KCHR resource - Polish Modified
;               90 is ID for KCHR resource - Catalan ISO

(defconstant $verFrenchUniversal 91)            ;        fr         French generic

(defconstant $verAustria 92)                    ;  AU de_AT     German for Austria
;  Y          93 is unused alternate for verSpLatinAmerica

(defconstant $verGujarati 94)                   ;        gu_IN

(defconstant $verPunjabi 95)                    ;        pa         Pakistan or India

(defconstant $verIndiaUrdu 96)                  ;        ur_IN     Urdu for India

(defconstant $verVietnam 97)                    ;        vi_VN


(defconstant $verFrBelgium 98)                  ;  BF fr_BE     French for Belgium                       

(defconstant $verUzbek 99)                      ;  BD uz_UZ                                    

(defconstant $verSingapore 100)                 ;  SG en_SG     (Assume English, not Chinese or Malay)                                 

(defconstant $verNynorsk 101)                   ;  NY nn_NO     Norwegian Nynorsk                        

(defconstant $verAfrikaans 102)                 ;  AK af_ZA                                    

(defconstant $verEsperanto 103)                 ;        eo                                        

(defconstant $verMarathi 104)                   ;        mr_IN                                      

(defconstant $verTibetan 105)                   ;        bo                                        

(defconstant $verNepal 106)                     ;        ne_NP                                      

(defconstant $verGreenland 107)                 ;        kl                                        

(defconstant $verIrelandEnglish 108)            ;        en_IE     English for Ireland, with Euro for currency

; 
;    Other extra resource IDs assigned in the same number space:
;     179 is ID for KCHR & itl_ resources - Cornish
;     581 is ID for KCHR resource - Irish Gaelic script alternate
;     582 is ID for KCHR resource - Ogham
;     779 is ID for KCHR resource - Welsh alternate
;    1111 is ID for KCHR resource - French numeric
; 
; 
;    Obsolete region code names (kept for backward compatibility):
;    Misspelled or alternate form, ambiguous, misleading, considered pejorative, archaic, etc.
; 

(defconstant $verFrBelgiumLux 6)                ;  Incorrect; 6 is Flemish, not French, for Belgium; use verFlemish     

(defconstant $verBelgiumLux 6)                  ;  Use verFlemish

(defconstant $verArabia 16)                     ;  Use verArabic

(defconstant $verYugoslavia 25)                 ;  Use verYugoCroatian (same number, now unused), or newer verCroatia

(defconstant $verBelgiumLuxPoint 27)            ;  Use verFlemishPoint

(defconstant $verIndia 33)                      ;  Use verIndiaHindi

(defconstant $verPakistan 34)                   ;  Use verPakistanUrdu                                  

(defconstant $verRumania 39)                    ;  Alternate for verRomania                              

(defconstant $verGreecePoly 40)                 ;  Use verGreekAncient                                  

(defconstant $verLapland 46)                    ;  Use verSami                                       

(defconstant $verFaeroeIsl 47)                  ;  Use verFaroeIsl                                     

(defconstant $verGenericFE 58)                  ;  Use verEastAsiaGeneric                              

(defconstant $verFarEastGeneric 58)             ;  Use verEastAsiaGeneric

(defconstant $verByeloRussian 61)               ;  Alternate for verBelarus                              

(defconstant $verUkrania 62)                    ;  Use verUkraine

(defconstant $verAlternateGr 64)                ;  Use verGreeceAlt                                   

(defconstant $verSerbia 65)                     ;  Alternate for verSerbian                              

(defconstant $verSlovenia 66)                   ;  Alternate for verSlovenian                            

(defconstant $verMacedonia 67)                  ;  Alternate for verMacedonian                             

(defconstant $verBrittany 77)                   ;  Alternate for verBreton                              

(defconstant $verWales 79)                      ;  Alternate for verWelsh                              

(defconstant $verArmenia 84)                    ;  Alternate for verArmenian                           

(defconstant $verGeorgia 85)                    ;  Alternate for verGeorgian                           

(defconstant $verAustriaGerman 92)              ;  Use verAustria                                   

(defconstant $verTibet 105)                     ;  Use verTibetan                                   


(defconstant $minCountry 0)
(defconstant $maxCountry 108)
;  Calendar Codes 

(defconstant $calGregorian 0)
(defconstant $calArabicCivil 1)
(defconstant $calArabicLunar 2)
(defconstant $calJapanese 3)
(defconstant $calJewish 4)
(defconstant $calCoptic 5)
(defconstant $calPersian 6)
;  Integer Format Codes 

(defconstant $intWestern 0)
(defconstant $intArabic 1)
(defconstant $intRoman 2)
(defconstant $intJapanese 3)
(defconstant $intEuropean 4)
(defconstant $intOutputMask #x8000)
;  CharByte byte types 

(defconstant $smSingleByte 0)
(defconstant $smFirstByte -1)
(defconstant $smLastByte 1)
(defconstant $smMiddleByte 2)
;  CharType field masks 

(defconstant $smcTypeMask 15)
(defconstant $smcReserved #xF0)
(defconstant $smcClassMask #xF00)
(defconstant $smcOrientationMask #x1000)        ; two-byte script glyph orientation

(defconstant $smcRightMask #x2000)
(defconstant $smcUpperMask #x4000)
(defconstant $smcDoubleMask #x8000)
;  Basic CharType character types 

(defconstant $smCharPunct 0)
(defconstant $smCharAscii 1)
(defconstant $smCharEuro 7)
(defconstant $smCharExtAscii 7)                 ;  More correct synonym for smCharEuro 
;  Additional CharType character types for script systems 

(defconstant $smCharKatakana 2)                 ; Japanese Katakana

(defconstant $smCharHiragana 3)                 ; Japanese Hiragana

(defconstant $smCharIdeographic 4)              ; Hanzi, Kanji, Hanja

(defconstant $smCharTwoByteGreek 5)             ; 2-byte Greek in Far East systems

(defconstant $smCharTwoByteRussian 6)           ; 2-byte Cyrillic in Far East systems

(defconstant $smCharBidirect 8)                 ; Arabic/Hebrew

(defconstant $smCharContextualLR 9)             ; Contextual left-right: Thai, Indic scripts

(defconstant $smCharNonContextualLR 10)         ; Non-contextual left-right: Cyrillic, Greek

(defconstant $smCharHangul 12)                  ; Korean Hangul

(defconstant $smCharJamo 13)                    ; Korean Jamo

(defconstant $smCharBopomofo 14)                ; Chinese Bopomofo

(defconstant $smCharGanaKana 15)                ; Shared for Japanese Hiragana & Katakana
;  old names for some of above, for backward compatibility 

(defconstant $smCharFISKana 2)                  ; Katakana

(defconstant $smCharFISGana 3)                  ; Hiragana

(defconstant $smCharFISIdeo 4)                  ; Hanzi, Kanji, Hanja


(defconstant $smCharFISGreek 5)                 ; 2-byte Greek in Far East systems

(defconstant $smCharFISRussian 6)               ; 2-byte Cyrillic in Far East systems
;  CharType classes for punctuation (smCharPunct) 

(defconstant $smPunctNormal 0)
(defconstant $smPunctNumber #x100)
(defconstant $smPunctSymbol #x200)
(defconstant $smPunctBlank #x300)               ;  Additional CharType classes for punctuation in two-byte systems 

(defconstant $smPunctRepeat #x400)              ;  repeat marker 

(defconstant $smPunctGraphic #x500)             ;  line graphics 
;  CharType Katakana and Hiragana classes for two-byte systems 

(defconstant $smKanaSmall #x100)                ; small kana character

(defconstant $smKanaHardOK #x200)               ; can have dakuten

(defconstant $smKanaSoftOK #x300)               ; can have dakuten or han-dakuten
;  CharType Ideographic classes for two-byte systems 

(defconstant $smIdeographicLevel1 0)            ; level 1 char

(defconstant $smIdeographicLevel2 #x100)        ; level 2 char

(defconstant $smIdeographicUser #x200)          ; user char
;  old names for above, for backward compatibility 

(defconstant $smFISClassLvl1 0)                 ; level 1 char

(defconstant $smFISClassLvl2 #x100)             ; level 2 char

(defconstant $smFISClassUser #x200)             ; user char
;  CharType Jamo classes for Korean systems 

(defconstant $smJamoJaeum 0)                    ; simple consonant char

(defconstant $smJamoBogJaeum #x100)             ; complex consonant char

(defconstant $smJamoMoeum #x200)                ; simple vowel char

(defconstant $smJamoBogMoeum #x300)             ; complex vowel char

;  CharType glyph orientation for two-byte systems 

(defconstant $smCharHorizontal 0)               ;  horizontal character form, or for both 

(defconstant $smCharVertical #x1000)            ;  vertical character form 
;  CharType directions 

(defconstant $smCharLeft 0)
(defconstant $smCharRight #x2000)               ;  CharType case modifers 

(defconstant $smCharLower 0)
(defconstant $smCharUpper #x4000)               ;  CharType character size modifiers (1 or multiple bytes). 

(defconstant $smChar1byte 0)
(defconstant $smChar2byte #x8000)
;  TransliterateText target types for Roman 

(defconstant $smTransAscii 0)                   ; convert to ASCII

(defconstant $smTransNative 1)                  ; convert to font script

(defconstant $smTransCase #xFE)                 ; convert case for all text

(defconstant $smTransSystem #xFF)               ; convert to system script
;  TransliterateText target types for two-byte scripts 

(defconstant $smTransAscii1 2)                  ; 1-byte Roman

(defconstant $smTransAscii2 3)                  ; 2-byte Roman

(defconstant $smTransKana1 4)                   ; 1-byte Japanese Katakana

(defconstant $smTransKana2 5)                   ; 2-byte Japanese Katakana


(defconstant $smTransGana2 7)                   ; 2-byte Japanese Hiragana (no 1-byte Hiragana)

(defconstant $smTransHangul2 8)                 ; 2-byte Korean Hangul

(defconstant $smTransJamo2 9)                   ; 2-byte Korean Jamo

(defconstant $smTransBopomofo2 10)              ; 2-byte Chinese Bopomofo
;  TransliterateText target modifiers 

(defconstant $smTransLower #x4000)              ; target becomes lowercase

(defconstant $smTransUpper #x8000)              ; target becomes uppercase
;  TransliterateText resource format numbers 

(defconstant $smTransRuleBaseFormat 1)          ; Rule based trsl resource format 

(defconstant $smTransHangulFormat 2)            ; Table based Hangul trsl resource format
;  TransliterateText property flags 

(defconstant $smTransPreDoubleByting 1)         ; Convert all text to double byte before transliteration

(defconstant $smTransPreLowerCasing 2)          ; Convert all text to lower case before transliteration

;  TransliterateText source mask - general 

(defconstant $smMaskAll #xFFFFFFFF)             ; Convert all text
;  TransliterateText source masks 

(defconstant $smMaskAscii 1)                    ; 2^smTransAscii

(defconstant $smMaskNative 2)                   ; 2^smTransNative
;  TransliterateText source masks for two-byte scripts 

(defconstant $smMaskAscii1 4)                   ; 2^smTransAscii1

(defconstant $smMaskAscii2 8)                   ; 2^smTransAscii2

(defconstant $smMaskKana1 16)                   ; 2^smTransKana1

(defconstant $smMaskKana2 32)                   ; 2^smTransKana2

(defconstant $smMaskGana2 #x80)                 ; 2^smTransGana2

(defconstant $smMaskHangul2 #x100)              ; 2^smTransHangul2

(defconstant $smMaskJamo2 #x200)                ; 2^smTransJamo2

(defconstant $smMaskBopomofo2 #x400)            ; 2^smTransBopomofo2

;  Result values from GetScriptManagerVariable and SetScriptManagerVariable calls. 

(defconstant $smNotInstalled 0)                 ; routine not available in script

(defconstant $smBadVerb -1)                     ; Bad verb passed to a routine
; Bad script code passed to a routine

(defconstant $smBadScript -2)
;  Values for script redraw flag. 

(defconstant $smRedrawChar 0)                   ; Redraw character only

(defconstant $smRedrawWord 1)                   ; Redraw entire word (2-byte systems)
; Redraw entire line (bidirectional systems)

(defconstant $smRedrawLine -1)
;  GetScriptManagerVariable and SetScriptManagerVariable verbs 

(defconstant $smVersion 0)                      ; Script Manager version number

(defconstant $smMunged 2)                       ; Globals change count

(defconstant $smEnabled 4)                      ; Count of enabled scripts, incl Roman

(defconstant $smBidirect 6)                     ; At least one bidirectional script

(defconstant $smFontForce 8)                    ; Force font flag

(defconstant $smIntlForce 10)                   ; Force intl flag

(defconstant $smForced 12)                      ; Script was forced to system script

(defconstant $smDefault 14)                     ; Script was defaulted to Roman script

(defconstant $smPrint 16)                       ; Printer action routine

(defconstant $smSysScript 18)                   ; System script

(defconstant $smLastScript 20)                  ; Last keyboard script

(defconstant $smKeyScript 22)                   ; Keyboard script

(defconstant $smSysRef 24)                      ; System folder refNum

(defconstant $smKeyCache 26)                    ; obsolete

(defconstant $smKeySwap 28)                     ; Swapping table handle

(defconstant $smGenFlags 30)                    ; General flags long

(defconstant $smOverride 32)                    ; Script override flags

(defconstant $smCharPortion 34)                 ; Ch vs SpExtra proportion
;  New for System 7.0: 

(defconstant $smDoubleByte 36)                  ; Flag for double-byte script installed

(defconstant $smKCHRCache 38)                   ; Returns pointer to KCHR cache

(defconstant $smRegionCode 40)                  ; Returns current region code (verXxx)

(defconstant $smKeyDisableState 42)             ; Returns current keyboard disable state

;  GetScriptVariable and SetScriptVariable verbs. 
;  Note: Verbs private to script systems are negative, while 
;  those general across script systems are non-negative. 

(defconstant $smScriptVersion 0)                ; Script software version

(defconstant $smScriptMunged 2)                 ; Script entry changed count

(defconstant $smScriptEnabled 4)                ; Script enabled flag

(defconstant $smScriptRight 6)                  ; Right to left flag

(defconstant $smScriptJust 8)                   ; Justification flag

(defconstant $smScriptRedraw 10)                ; Word redraw flag

(defconstant $smScriptSysFond 12)               ; Preferred system font

(defconstant $smScriptAppFond 14)               ; Preferred Application font

(defconstant $smScriptBundle 16)                ; Beginning of itlb verbs

(defconstant $smScriptNumber 16)                ; Script itl0 id

(defconstant $smScriptDate 18)                  ; Script itl1 id

(defconstant $smScriptSort 20)                  ; Script itl2 id

(defconstant $smScriptFlags 22)                 ; flags word

(defconstant $smScriptToken 24)                 ; Script itl4 id

(defconstant $smScriptEncoding 26)              ; id of optional itl5, if present

(defconstant $smScriptLang 28)                  ; Current language for script


(defconstant $smScriptNumDate 30)               ; Script Number/Date formats.

(defconstant $smScriptKeys 32)                  ; Script KCHR id

(defconstant $smScriptIcon 34)                  ; ID # of SICN or kcs#/kcs4/kcs8 suite

(defconstant $smScriptPrint 36)                 ; Script printer action routine

(defconstant $smScriptTrap 38)                  ; Trap entry pointer

(defconstant $smScriptCreator 40)               ; Script file creator

(defconstant $smScriptFile 42)                  ; Script file name

(defconstant $smScriptName 44)                  ; Script name
;  There is a hole here for old Kanji private verbs 46-76 
;  New for System 7.0: 

(defconstant $smScriptMonoFondSize 78)          ; default monospace FOND (hi) & size (lo)

(defconstant $smScriptPrefFondSize 80)          ; preferred FOND (hi) & size (lo)

(defconstant $smScriptSmallFondSize 82)         ; default small FOND (hi) & size (lo)

(defconstant $smScriptSysFondSize 84)           ; default system FOND (hi) & size (lo)

(defconstant $smScriptAppFondSize 86)           ; default app FOND (hi) & size (lo)

(defconstant $smScriptHelpFondSize 88)          ; default Help Mgr FOND (hi) & size (lo)

(defconstant $smScriptValidStyles 90)           ; mask of valid styles for script

(defconstant $smScriptAliasStyle 92)            ; style (set) to use for aliases

;  special negative verbs for Get/SetScriptVariable that were associated with WorldScriptI 
;  move them here to be public 
;  WorldScript private verbs 

(defconstant $smLayoutCache -309)               ;  HiWrd(param) is # entries, LoWrd is max input length

(defconstant $smOldVerbSupport -311)            ;  param is added to old verbs to map to WSI verb

(defconstant $smSetKashidas -291)               ;  param is ON or OFF, old verb = -36

(defconstant $smSetKashProp -287)               ;  param is kashida proportion, old verb = -32

(defconstant $smScriptSysBase -281)             ;  param is associated font to use w/ system font (old verb = -26)

(defconstant $smScriptAppBase -283)             ;  param is associated font to use w/ app font (old verb = -28)

(defconstant $smScriptFntBase -285)             ;  param is associated font to use w/ all other fonts (old verb = -30)

(defconstant $smScriptLigatures -263)           ;  old verb = -8
;  old verb = -12

(defconstant $smScriptNumbers -267)
;  Special script code values for International Utilities 

(defconstant $iuSystemScript -1)                ;  <obsolete>  system script 
;  <obsolete>  current script (for font of grafPort) 

(defconstant $iuCurrentScript -2)
;  Negative verbs for KeyScript 

(defconstant $smKeyNextScript -1)               ;  Switch to next available script 

(defconstant $smKeySysScript -2)                ;  Switch to the system script 

(defconstant $smKeySwapScript -3)               ;  Switch to previously-used script 
;  New for System 7.0: 

(defconstant $smKeyNextKybd -4)                 ;  Switch to next keyboard in current keyscript 

(defconstant $smKeySwapKybd -5)                 ;  Switch to previously-used keyboard in current keyscript 

(defconstant $smKeyDisableKybds -6)             ;  Disable keyboards not in system or Roman script 

(defconstant $smKeyEnableKybds -7)              ;  Re-enable keyboards for all enabled scripts 

(defconstant $smKeyToggleInline -8)             ;  Toggle inline input for current keyscript 

(defconstant $smKeyToggleDirection -9)          ;  Toggle default line direction (TESysJust) 

(defconstant $smKeyNextInputMethod -10)         ;  Switch to next input method in current keyscript 

(defconstant $smKeySwapInputMethod -11)         ;  Switch to last-used input method in current keyscript 

(defconstant $smKeyDisableKybdSwitch -12)       ;  Disable switching from the current keyboard 

(defconstant $smKeySetDirLeftRight -15)         ;  Set default line dir to left-right, align left 

(defconstant $smKeySetDirRightLeft -16)         ;  Set default line dir to right-left, align right 
;  Set keyscript to Roman. Does nothing if Roman-only system, unlike KeyScript(smRoman) which forces an update to current default Roman keyboard 

(defconstant $smKeyRoman -17)
;  Optional font and keyboard script synchronization 
;  One more flag in the smGenFlags long. 

(defconstant $smfDisableKeyScriptSync 27)       ; Disable font and keyboard script synchronization

;  We should define masks, too. 
; Disable font and keyboard script synchronization mask

(defconstant $smfDisableKeyScriptSyncMask #x8000000)
;  Force keyboard script switching flag and mask for zero and positive KeyScript verbs 

(defconstant $smKeyForceKeyScriptBit 7)         ;  Force keyboard script switching flag 
;  its mask 

(defconstant $smKeyForceKeyScriptMask #x80)
;  Bits in the smScriptFlags word 
;   (bits above 8 are non-static) 

(defconstant $smsfIntellCP 0)                   ; Script has intelligent cut & paste

(defconstant $smsfSingByte 1)                   ; Script has only single bytes

(defconstant $smsfNatCase 2)                    ; Native chars have upper & lower case

(defconstant $smsfContext 3)                    ; Script is contextual

(defconstant $smsfNoForceFont 4)                ; Script will not force characters

(defconstant $smsfB0Digits 5)                   ; Script has alternate digits at B0-B9

(defconstant $smsfAutoInit 6)                   ; Auto initialize the script

(defconstant $smsfUnivExt 7)                    ; Script is handled by universal extension

(defconstant $smsfSynchUnstyledTE 8)            ; Script synchronizes for unstyled TE

(defconstant $smsfForms 13)                     ; Uses contextual forms for letters

(defconstant $smsfLigatures 14)                 ; Uses contextual ligatures

(defconstant $smsfReverse 15)                   ; Reverses native text, right-left
;  Bits in the smGenFlags long. 
;  First (high-order) byte is set from itlc flags byte. 

(defconstant $smfShowIcon 31)                   ; Show icon even if only one script

(defconstant $smfDualCaret 30)                  ; Use dual caret for mixed direction text

(defconstant $smfNameTagEnab 29)                ; Reserved for internal use

(defconstant $smfUseAssocFontInfo 28)           ; Use the associated font info for FontMetrics calls <48>

;  Roman script constants 
;  The following are here for backward compatibility, but should not be used. 
;  This information should be obtained using GetScript. 

(defconstant $romanSysFond #x3FFF)              ; system font id number

(defconstant $romanAppFond 3)                   ; application font id number

(defconstant $romanFlags 7)                     ; roman settings
;  Script Manager font equates. 

(defconstant $smFondStart #x4000)               ; start from 16K

(defconstant $smFondEnd #xC000)                 ; past end of range at 48K
;  Miscellaneous font equates. 

(defconstant $smUprHalfCharSet #x80)            ; first char code in top half of std char set

;  Character Set Extensions 

(defconstant $diaeresisUprY #xD9)
(defconstant $fraction #xDA)
(defconstant $intlCurrency #xDB)
(defconstant $leftSingGuillemet #xDC)
(defconstant $rightSingGuillemet #xDD)
(defconstant $fiLigature #xDE)
(defconstant $flLigature #xDF)
(defconstant $dblDagger #xE0)
(defconstant $centeredDot #xE1)
(defconstant $baseSingQuote #xE2)
(defconstant $baseDblQuote #xE3)
(defconstant $perThousand #xE4)
(defconstant $circumflexUprA #xE5)
(defconstant $circumflexUprE #xE6)
(defconstant $acuteUprA #xE7)
(defconstant $diaeresisUprE #xE8)
(defconstant $graveUprE #xE9)
(defconstant $acuteUprI #xEA)
(defconstant $circumflexUprI #xEB)
(defconstant $diaeresisUprI #xEC)
(defconstant $graveUprI #xED)
(defconstant $acuteUprO #xEE)
(defconstant $circumflexUprO #xEF)
(defconstant $appleLogo #xF0)
(defconstant $graveUprO #xF1)
(defconstant $acuteUprU #xF2)
(defconstant $circumflexUprU #xF3)
(defconstant $graveUprU #xF4)
(defconstant $dotlessLwrI #xF5)
(defconstant $circumflex #xF6)
(defconstant $tilde #xF7)
(defconstant $macron #xF8)
(defconstant $breveMark #xF9)
(defconstant $overDot #xFA)
(defconstant $ringMark #xFB)
(defconstant $cedilla #xFC)
(defconstant $doubleAcute #xFD)
(defconstant $ogonek #xFE)
(defconstant $hachek #xFF)
;  ScriptTokenType values 

(defconstant $tokenIntl 4)                      ; the itl resource number of the tokenizer
; used internally as an empty flag

(defconstant $tokenEmpty -1)

(defconstant $tokenUnknown 0)                   ; chars that do not match a defined token type

(defconstant $tokenWhite 1)                     ; white space

(defconstant $tokenLeftLit 2)                   ; literal begin

(defconstant $tokenRightLit 3)                  ; literal end

(defconstant $tokenAlpha 4)                     ; alphabetic

(defconstant $tokenNumeric 5)                   ; numeric

(defconstant $tokenNewLine 6)                   ; new line

(defconstant $tokenLeftComment 7)               ; open comment

(defconstant $tokenRightComment 8)              ; close comment

(defconstant $tokenLiteral 9)                   ; literal

(defconstant $tokenEscape 10)                   ; character escape (e.g. '\' in "\n", "\t")

(defconstant $tokenAltNum 11)                   ; alternate number (e.g. $B0-B9 in Arabic,Hebrew)

(defconstant $tokenRealNum 12)                  ; real number

(defconstant $tokenAltReal 13)                  ; alternate real number

(defconstant $tokenReserve1 14)                 ; reserved

(defconstant $tokenReserve2 15)                 ; reserved

(defconstant $tokenLeftParen 16)                ; open parenthesis

(defconstant $tokenRightParen 17)               ; close parenthesis

(defconstant $tokenLeftBracket 18)              ; open square bracket

(defconstant $tokenRightBracket 19)             ; close square bracket


(defconstant $tokenLeftCurly 20)                ; open curly bracket

(defconstant $tokenRightCurly 21)               ; close curly bracket

(defconstant $tokenLeftEnclose 22)              ; open guillemet

(defconstant $tokenRightEnclose 23)             ; close guillemet

(defconstant $tokenPlus 24)
(defconstant $tokenMinus 25)
(defconstant $tokenAsterisk 26)                 ; times/multiply

(defconstant $tokenDivide 27)
(defconstant $tokenPlusMinus 28)                ; plus or minus symbol

(defconstant $tokenSlash 29)
(defconstant $tokenBackSlash 30)
(defconstant $tokenLess 31)                     ; less than symbol

(defconstant $tokenGreat 32)                    ; greater than symbol

(defconstant $tokenEqual 33)
(defconstant $tokenLessEqual2 34)               ; less than or equal, 2 characters (e.g. <=)

(defconstant $tokenLessEqual1 35)               ; less than or equal, 1 character

(defconstant $tokenGreatEqual2 36)              ; greater than or equal, 2 characters (e.g. >=)

(defconstant $tokenGreatEqual1 37)              ; greater than or equal, 1 character

(defconstant $token2Equal 38)                   ; double equal (e.g. ==)

(defconstant $tokenColonEqual 39)               ; colon equal


(defconstant $tokenNotEqual 40)                 ; not equal, 1 character

(defconstant $tokenLessGreat 41)                ; less/greater, Pascal not equal (e.g. <>)

(defconstant $tokenExclamEqual 42)              ; exclamation equal, C not equal (e.g. !=)

(defconstant $tokenExclam 43)                   ; exclamation point

(defconstant $tokenTilde 44)                    ; centered tilde

(defconstant $tokenComma 45)
(defconstant $tokenPeriod 46)
(defconstant $tokenLeft2Quote 47)               ; open double quote

(defconstant $tokenRight2Quote 48)              ; close double quote

(defconstant $tokenLeft1Quote 49)               ; open single quote

(defconstant $tokenRight1Quote 50)              ; close single quote

(defconstant $token2Quote 51)                   ; double quote

(defconstant $token1Quote 52)                   ; single quote

(defconstant $tokenSemicolon 53)
(defconstant $tokenPercent 54)
(defconstant $tokenCaret 55)
(defconstant $tokenUnderline 56)
(defconstant $tokenAmpersand 57)
(defconstant $tokenAtSign 58)
(defconstant $tokenBar 59)                      ; vertical bar


(defconstant $tokenQuestion 60)
(defconstant $tokenPi 61)                       ; lower-case pi

(defconstant $tokenRoot 62)                     ; square root symbol

(defconstant $tokenSigma 63)                    ; capital sigma

(defconstant $tokenIntegral 64)                 ; integral sign

(defconstant $tokenMicro 65)
(defconstant $tokenCapPi 66)                    ; capital pi

(defconstant $tokenInfinity 67)
(defconstant $tokenColon 68)
(defconstant $tokenHash 69)                     ; e.g. #

(defconstant $tokenDollar 70)
(defconstant $tokenNoBreakSpace 71)             ; non-breaking space

(defconstant $tokenFraction 72)
(defconstant $tokenIntlCurrency 73)
(defconstant $tokenLeftSingGuillemet 74)
(defconstant $tokenRightSingGuillemet 75)
(defconstant $tokenPerThousand 76)
(defconstant $tokenEllipsis 77)
(defconstant $tokenCenterDot 78)
(defconstant $tokenNil 127)

(defconstant $delimPad -2)                      ;  obsolete, misspelled token names kept for backward compatibility 

(defconstant $tokenTilda 44)
(defconstant $tokenCarat 55)
;  Table selectors for GetItlTable 

(defconstant $smWordSelectTable 0)              ;  get word select break table from 'itl2' 

(defconstant $smWordWrapTable 1)                ;  get word wrap break table from 'itl2' 

(defconstant $smNumberPartsTable 2)             ;  get default number parts table from 'itl4' 

(defconstant $smUnTokenTable 3)                 ;  get unToken table from 'itl4' 

(defconstant $smWhiteSpaceList 4)               ;  get white space list from 'itl4' 

(defconstant $iuWordSelectTable 0)              ;  <obsolete>  get word select break table from 'itl2' 

(defconstant $iuWordWrapTable 1)                ;  <obsolete>  get word wrap break table from 'itl2' 

(defconstant $iuNumberPartsTable 2)             ;  <obsolete>  get default number parts table from 'itl4' 

(defconstant $iuUnTokenTable 3)                 ;  <obsolete>  get unToken table from 'itl4' 

(defconstant $iuWhiteSpaceList 4)               ;  <obsolete>  get white space list from 'itl4' 

;  end of stuff moved from Packages.h 

(defconstant $tokenOK 0)                        ;  TokenResults 

(defconstant $tokenOverflow 1)                  ;  TokenResults 

(defconstant $stringOverflow 2)                 ;  TokenResults 

(defconstant $badDelim 3)                       ;  TokenResults 

(defconstant $badEnding 4)                      ;  TokenResults 

(defconstant $crash 5)                          ;  TokenResults 


(def-mactype :TokenResults (find-mactype ':SInt8))
(defrecord CharByteTable
   (contents (:array :character 256))
)                                               ;  "TokenType" was renamed to "ScriptTokenType" because of a name collisions

(def-mactype :ScriptTokenType (find-mactype ':SInt16))
(defrecord DelimType
   (contents (:array :SInt16 2))
)
(defrecord CommentType
   (contents (:array :SInt16 4))
)
(defrecord TokenRec
   (theToken :SInt16)
   (position :pointer)                          ; pointer into original source
   (length :signed-long)                        ; length of text in original source
   (stringPosition (:pointer :UInt8))           ; Pascal/C string copy of identifier
)

;type name? (%define-record :TokenRec (find-record-descriptor ':TokenRec))

(def-mactype :TokenRecPtr (find-mactype '(:pointer :TokenRec)))
(defrecord TokenBlock
   (source :pointer)                            ; pointer to stream of characters
   (sourceLength :signed-long)                  ; length of source stream
   (tokenList :pointer)                         ; pointer to array of tokens
   (tokenLength :signed-long)                   ; maximum length of TokenList
   (tokenCount :signed-long)                    ; number tokens generated by tokenizer
   (stringList :pointer)                        ; pointer to stream of identifiers
   (stringLength :signed-long)                  ; length of string list
   (stringCount :signed-long)                   ; number of bytes currently used
   (doString :Boolean)                          ; make strings & put into StringList
   (doAppend :Boolean)                          ; append to TokenList rather than replace
   (doAlphanumeric :Boolean)                    ; identifiers may include numeric
   (doNest :Boolean)                            ; do comments nest?
   (leftDelims (:array :SInt16 2))
   (rightDelims (:array :SInt16 2))
   (leftComment (:array :SInt16 4))
   (rightComment (:array :SInt16 4))
   (escapeCode :SInt16)                         ; escape symbol code
   (decimalCode :SInt16)
   (itlResource :Handle)                        ; handle to itl4 resource of current script
   (reserved (:array :signed-long 8))           ; must be zero!
)

;type name? (%define-record :TokenBlock (find-record-descriptor ':TokenBlock))

(def-mactype :TokenBlockPtr (find-mactype '(:pointer :TokenBlock)))
; 
;  *  GetSysDirection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetSysDirection" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  SetSysDirection()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetSysDirection" 
   ((value :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FontScript()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FontScript" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  IntlScript()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_IntlScript" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  FontToScript()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FontToScript" 
   ((fontNumber :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  GetScriptManagerVariable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetScriptManagerVariable" 
   ((selector :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetScriptManagerVariable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetScriptManagerVariable" 
   ((selector :SInt16)
    (param :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  GetScriptVariable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetScriptVariable" 
   ((script :SInt16)
    (selector :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  SetScriptVariable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetScriptVariable" 
   ((script :SInt16)
    (selector :SInt16)
    (param :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  CharacterByteType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CharacterByteType" 
   ((textBuf :pointer)
    (textOffset :SInt16)
    (script :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  CharacterType()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_CharacterType" 
   ((textBuf :pointer)
    (textOffset :SInt16)
    (script :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  TransliterateText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_TransliterateText" 
   ((srcHandle :Handle)
    (dstHandle :Handle)
    (target :SInt16)
    (srcMask :signed-long)
    (script :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSErr
() )
; 
;  *  FillParseTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FillParseTable" 
   ((table (:pointer :CHARBYTETABLE))
    (script :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  GetIntlResource()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetIntlResource" 
   ((theID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Handle
() )
; 
;  *  ClearIntlResourceCache()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ClearIntlResourceCache" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetIntlResourceTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetIntlResourceTable" 
   ((script :SInt16)
    (tableCode :SInt16)
    (itlHandle (:pointer :Handle))
    (offset (:pointer :long))
    (length (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetScriptUtilityAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SetScriptUtilityAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  GetScriptQDPatchAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SetScriptQDPatchAddress()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  SetIntlResource()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  CharByte()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  CharType()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  Transliterate()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  ParseTable()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IntlTokenize()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_IntlTokenize" 
   ((tokenParam (:pointer :TokenBlock))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt8
() )

; #if OLDROUTINENAMES
#| 
; #define SetSysJust(newJust) SetSysDirection(newJust)
; #define GetSysJust() GetSysDirection()
; #define Font2Script(fontNumber) FontToScript(fontNumber)
; #define GetEnvirons(verb) GetScriptManagerVariable(verb)
; #define SetEnvirons(verb, param) SetScriptManagerVariable(verb, param)
; #define GetScript(script, verb) GetScriptVariable(script, verb)
; #define SetScript(script, verb, param) SetScriptVariable(script, verb, param)
; #define IUGetIntl(theID) GetIntlResource(theID) 
; #define IUSetIntl(refNum, theID, intlHandle) SetIntlResource(refNum, theID, intlHandle)
; #define IUClearCache() ClearIntlResourceCache()
; #define IUGetItlTable(script, tableCode, itlHandle, offset, length)          GetIntlResourceTable(script, tableCode, itlHandle, offset, length)
 |#

; #endif  /* OLDROUTINENAMES */

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __SCRIPT__ */


(provide-interface "Script")