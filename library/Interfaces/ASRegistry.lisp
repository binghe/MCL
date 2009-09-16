(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ASRegistry.h"
; at Sunday July 2,2006 7:25:10 pm.
; 
;      File:       OpenScripting/ASRegistry.h
;  
;      Contains:   AppleScript Registry constants.
;  
;      Version:    OSA-62~76
;  
;      Copyright:  © 1991-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __ASREGISTRY__
; #define __ASREGISTRY__
; #ifndef __APPLICATIONSERVICES__
#| #|
#include <ApplicationServicesApplicationServices.h>
#endif
|#
 |#

(require-interface "AvailabilityMacros")

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif


(defconstant $keyAETarget :|targ|)
(defconstant $keySubjectAttr :|subj|)           ;  Magic 'returning' parameter: 

(defconstant $keyASReturning :|Krtn|)           ;  AppleScript Specific Codes: 

(defconstant $kASAppleScriptSuite :|ascr|)
(defconstant $kASScriptEditorSuite :|ToyS|)
(defconstant $kASTypeNamesSuite :|tpnm|)        ;  dynamic terminologies 

(defconstant $typeAETE :|aete|)
(defconstant $typeAEUT :|aeut|)
(defconstant $kGetAETE :|gdte|)
(defconstant $kGetAEUT :|gdut|)
(defconstant $kUpdateAEUT :|udut|)
(defconstant $kUpdateAETE :|udte|)
(defconstant $kCleanUpAEUT :|cdut|)
(defconstant $kASComment :|cmnt|)
(defconstant $kASLaunchEvent :|noop|)
(defconstant $keyScszResource :|scsz|)
(defconstant $typeScszResource :|scsz|)         ;  subroutine calls 

(defconstant $kASSubroutineEvent :|psbr|)
(defconstant $keyASSubroutineName :|snam|)
(defconstant $kASPrepositionalSubroutine :|psbr|)
(defconstant $keyASPositionalArgs :|parg|)
;  Add this parameter to a Get Data result if your app handled the 'as' parameter 

(defconstant $keyAppHandledCoercion :|idas|)
;  Miscellaneous AppleScript commands 

(defconstant $kASStartLogEvent :|log1|)
(defconstant $kASStopLogEvent :|log0|)
(defconstant $kASCommentEvent :|cmnt|)
;  Operator Events: 
;  Binary: 

(defconstant $kASAdd :|+   |)
(defconstant $kASSubtract :|-   |)
(defconstant $kASMultiply :|*   |)
(defconstant $kASDivide :|/   |)
(defconstant $kASQuotient :|div |)
(defconstant $kASRemainder :|mod |)
(defconstant $kASPower :|^   |)
(defconstant $kASEqual :|=   |)
(defconstant $kASNotEqual #xAD202020)
(defconstant $kASGreaterThan :|>   |)
(defconstant $kASGreaterThanOrEqual :|>=  |)
(defconstant $kASLessThan :|<   |)
(defconstant $kASLessThanOrEqual :|<=  |)
(defconstant $kASComesBefore :|cbfr|)
(defconstant $kASComesAfter :|cafr|)
(defconstant $kASConcatenate :|ccat|)
(defconstant $kASStartsWith :|bgwt|)
(defconstant $kASEndsWith :|ends|)
(defconstant $kASContains :|cont|)

(defconstant $kASAnd :|AND |)
(defconstant $kASOr :|OR  |)                    ;  Unary: 

(defconstant $kASNot :|NOT |)
(defconstant $kASNegate :|neg |)
(defconstant $keyASArg :|arg |)
;  event code for the 'error' statement 

(defconstant $kASErrorEventCode :|err |)
(defconstant $kOSAErrorArgs :|erra|)
(defconstant $keyAEErrorObject :|erob|)         ;  Properties: 

(defconstant $pLength :|leng|)
(defconstant $pReverse :|rvse|)
(defconstant $pRest :|rest|)
(defconstant $pInherits :|c@#^|)
(defconstant $pProperties :|pALL|)              ;  User-Defined Record Fields: 

(defconstant $keyASUserRecordFields :|usrf|)
(defconstant $typeUserRecordFields :|list|)
;  Prepositions: 

(defconstant $keyASPrepositionAt :|at  |)
(defconstant $keyASPrepositionIn :|in  |)
(defconstant $keyASPrepositionFrom :|from|)
(defconstant $keyASPrepositionFor :|for |)
(defconstant $keyASPrepositionTo :|to  |)
(defconstant $keyASPrepositionThru :|thru|)
(defconstant $keyASPrepositionThrough :|thgh|)
(defconstant $keyASPrepositionBy :|by  |)
(defconstant $keyASPrepositionOn :|on  |)
(defconstant $keyASPrepositionInto :|into|)
(defconstant $keyASPrepositionOnto :|onto|)
(defconstant $keyASPrepositionBetween :|btwn|)
(defconstant $keyASPrepositionAgainst :|agst|)
(defconstant $keyASPrepositionOutOf :|outo|)
(defconstant $keyASPrepositionInsteadOf :|isto|)
(defconstant $keyASPrepositionAsideFrom :|asdf|)
(defconstant $keyASPrepositionAround :|arnd|)
(defconstant $keyASPrepositionBeside :|bsid|)
(defconstant $keyASPrepositionBeneath :|bnth|)
(defconstant $keyASPrepositionUnder :|undr|)

(defconstant $keyASPrepositionOver :|over|)
(defconstant $keyASPrepositionAbove :|abve|)
(defconstant $keyASPrepositionBelow :|belw|)
(defconstant $keyASPrepositionApartFrom :|aprt|)
(defconstant $keyASPrepositionGiven :|givn|)
(defconstant $keyASPrepositionWith :|with|)
(defconstant $keyASPrepositionWithout :|wout|)
(defconstant $keyASPrepositionAbout :|abou|)
(defconstant $keyASPrepositionSince :|snce|)
(defconstant $keyASPrepositionUntil :|till|)
;  Terminology & Dialect things: 

(defconstant $kDialectBundleResType :|Dbdl|)    ;  AppleScript Classes and Enums: 

(defconstant $cConstant :|enum|)
(defconstant $cClassIdentifier :|pcls|)
(defconstant $cObjectBeingExamined :|exmn|)
(defconstant $cList :|list|)
(defconstant $cSmallReal :|sing|)
(defconstant $cReal :|doub|)
(defconstant $cRecord :|reco|)
(defconstant $cReference :|obj |)
(defconstant $cUndefined :|undf|)
(defconstant $cMissingValue :|msng|)
(defconstant $cSymbol :|symb|)
(defconstant $cLinkedList :|llst|)
(defconstant $cVector :|vect|)
(defconstant $cEventIdentifier :|evnt|)
(defconstant $cKeyIdentifier :|kyid|)
(defconstant $cUserIdentifier :|uid |)
(defconstant $cPreposition :|prep|)
(defconstant $cKeyForm :|kfrm|)
(defconstant $cScript :|scpt|)
(defconstant $cHandler :|hand|)
(defconstant $cProcedure :|proc|)

(defconstant $cHandleBreakpoint :|brak|)

(defconstant $cClosure :|clsr|)
(defconstant $cRawData :|rdat|)
(defconstant $cStringClass :|TEXT|)
(defconstant $cNumber :|nmbr|)
(defconstant $cListElement :|celm|)
(defconstant $cListOrRecord :|lr  |)
(defconstant $cListOrString :|ls  |)
(defconstant $cListRecordOrString :|lrs |)
(defconstant $cNumberOrString :|ns  |)
(defconstant $cNumberOrDateTime :|nd  |)
(defconstant $cNumberDateTimeOrString :|nds |)
(defconstant $cAliasOrString :|sf  |)
(defconstant $cSeconds :|scnd|)
(defconstant $typeSound :|snd |)
(defconstant $enumBooleanValues :|boov|)        ;   Use this instead of typeBoolean to avoid with/without conversion  

(defconstant $kAETrue :|true|)
(defconstant $kAEFalse :|fals|)
(defconstant $enumMiscValues :|misc|)
(defconstant $kASCurrentApplication :|cura|)    ;  User-defined property ospecs: 

(defconstant $formUserPropertyID :|usrp|)

(defconstant $cString :|TEXT|)                  ;  old name for cStringClass - can't be used in .r files

;  Global properties: 

(defconstant $pASIt :|it  |)
(defconstant $pASMe :|me  |)
(defconstant $pASResult :|rslt|)
(defconstant $pASSpace :|spac|)
(defconstant $pASReturn :|ret |)
(defconstant $pASTab :|tab |)
(defconstant $pASPi :|pi  |)
(defconstant $pASParent :|pare|)
(defconstant $kASInitializeEventCode :|init|)
(defconstant $pASPrintLength :|prln|)
(defconstant $pASPrintDepth :|prdp|)
(defconstant $pASTopLevelScript :|ascr|)
;  Considerations 

(defconstant $kAECase :|case|)
(defconstant $kAEDiacritic :|diac|)
(defconstant $kAEWhiteSpace :|whit|)
(defconstant $kAEHyphens :|hyph|)
(defconstant $kAEExpansion :|expa|)
(defconstant $kAEPunctuation :|punc|)
(defconstant $kAEZenkakuHankaku :|zkhk|)
(defconstant $kAESmallKana :|skna|)
(defconstant $kAEKataHiragana :|hika|)
(defconstant $kASConsiderReplies :|rmte|)
(defconstant $enumConsiderations :|cons|)
;  Considerations bit masks 

(defconstant $kAECaseConsiderMask 1)
(defconstant $kAEDiacriticConsiderMask 2)
(defconstant $kAEWhiteSpaceConsiderMask 4)
(defconstant $kAEHyphensConsiderMask 8)
(defconstant $kAEExpansionConsiderMask 16)
(defconstant $kAEPunctuationConsiderMask 32)
(defconstant $kASConsiderRepliesConsiderMask 64)
(defconstant $kAECaseIgnoreMask #x10000)
(defconstant $kAEDiacriticIgnoreMask #x20000)
(defconstant $kAEWhiteSpaceIgnoreMask #x40000)
(defconstant $kAEHyphensIgnoreMask #x80000)
(defconstant $kAEExpansionIgnoreMask #x100000)
(defconstant $kAEPunctuationIgnoreMask #x200000)
(defconstant $kASConsiderRepliesIgnoreMask #x400000)
(defconstant $enumConsidsAndIgnores :|csig|)

(defconstant $cCoercion :|coec|)
(defconstant $cCoerceUpperCase :|txup|)
(defconstant $cCoerceLowerCase :|txlo|)
(defconstant $cCoerceRemoveDiacriticals :|txdc|)
(defconstant $cCoerceRemovePunctuation :|txpc|)
(defconstant $cCoerceRemoveHyphens :|txhy|)
(defconstant $cCoerceOneByteToTwoByte :|txex|)
(defconstant $cCoerceRemoveWhiteSpace :|txws|)
(defconstant $cCoerceSmallKana :|txsk|)
(defconstant $cCoerceZenkakuhankaku :|txze|)
(defconstant $cCoerceKataHiragana :|txkh|)      ;  Lorax things: 

(defconstant $cZone :|zone|)
(defconstant $cMachine :|mach|)
(defconstant $cAddress :|addr|)
(defconstant $cRunningAddress :|radd|)
(defconstant $cStorage :|stor|)
;  DateTime things: 

(defconstant $pASWeekday :|wkdy|)
(defconstant $pASMonth :|mnth|)
(defconstant $pASDay :|day |)
(defconstant $pASYear :|year|)
(defconstant $pASTime :|time|)
(defconstant $pASDateString :|dstr|)
(defconstant $pASTimeString :|tstr|)            ;  Months 

(defconstant $cMonth :|mnth|)
(defconstant $cJanuary :|jan |)
(defconstant $cFebruary :|feb |)
(defconstant $cMarch :|mar |)
(defconstant $cApril :|apr |)
(defconstant $cMay :|may |)
(defconstant $cJune :|jun |)
(defconstant $cJuly :|jul |)
(defconstant $cAugust :|aug |)
(defconstant $cSeptember :|sep |)
(defconstant $cOctober :|oct |)
(defconstant $cNovember :|nov |)
(defconstant $cDecember :|dec |)
;  Weekdays 

(defconstant $cWeekday :|wkdy|)
(defconstant $cSunday :|sun |)
(defconstant $cMonday :|mon |)
(defconstant $cTuesday :|tue |)
(defconstant $cWednesday :|wed |)
(defconstant $cThursday :|thu |)
(defconstant $cFriday :|fri |)
(defconstant $cSaturday :|sat |)                ;  AS 1.1 Globals: 

(defconstant $pASQuote :|quot|)
(defconstant $pASSeconds :|secs|)
(defconstant $pASMinutes :|min |)
(defconstant $pASHours :|hour|)
(defconstant $pASDays :|days|)
(defconstant $pASWeeks :|week|)                 ;  Writing Code things: 

(defconstant $cWritingCodeInfo :|citl|)
(defconstant $pScriptCode :|pscd|)
(defconstant $pLangCode :|plcd|)                ;  Magic Tell and End Tell events for logging: 

(defconstant $kASMagicTellEvent :|tell|)
(defconstant $kASMagicEndTellEvent :|tend|)

; #endif /* __ASREGISTRY__ */


(provide-interface "ASRegistry")