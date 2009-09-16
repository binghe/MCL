(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:StringCompare.h"
; at Sunday July 2,2006 7:23:24 pm.
; 
;      File:       CarbonCore/StringCompare.h
;  
;      Contains:   Public interfaces for String Comparison and related operations
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1985-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __STRINGCOMPARE__
; #define __STRINGCOMPARE__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __MIXEDMODE__
#| #|
#include <CarbonCoreMixedMode.h>
#endif
|#
 |#
; #ifndef __TEXTCOMMON__
#| #|
#include <CarbonCoreTextCommon.h>
#endif
|#
 |#
; #ifndef __SCRIPT__
#| #|
#include <CarbonCoreScript.h>
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
; 
; 
;     Here are the current System 7 routine names and the translations to the older forms.
;     Please use the newer forms in all new code and migrate the older names out of existing
;     code as maintenance permits.
;     
;     NEW NAME                    OLD NAME                    OBSOLETE FORM (no handle)
;     
;     CompareString (Str255)      IUCompPString (hp only)     IUCompString (hp only)
;     CompareText (ptr/len)       IUMagPString                IUMagString
;     IdenticalString (Str255)    IUEqualPString (hp only)    IUEqualString  (hp only)
;     IdenticalText (ptr/len)     IUMagIDPString              IUMagIDString
;     LanguageOrder               IULangOrder
;     ScriptOrder                 IUScriptOrder
;     StringOrder (Str255)        IUStringOrder (hp only)
;     TextOrder (ptr/len)         IUTextOrder
; 
;     RelString
;     CmpString (a only)                  
;     EqualString (hp only)
;     
;     ReplaceText
; 
;     Carbon only supports the new names.  The old names are undefined for Carbon targets.
; 
;     InterfaceLib always has exported the old names.  For C macros have been defined to allow
;     the use of the new names.  For Pascal and Assembly using the new names will result
;     in link errors. 
;     
; 
;  Special language code values for Language Order

(defconstant $systemCurLang -2)                 ;  current (itlbLang) lang for system script

(defconstant $systemDefLang -3)                 ;  default (table) lang for system script

(defconstant $currentCurLang -4)                ;  current (itlbLang) lang for current script

(defconstant $currentDefLang -5)                ;  default lang for current script

(defconstant $scriptCurLang -6)                 ;  current (itlbLang) lang for specified script
;  default language for a specified script

(defconstant $scriptDefLang -7)
;  obsolete names

(defconstant $iuSystemCurLang -2)
(defconstant $iuSystemDefLang -3)
(defconstant $iuCurrentCurLang -4)
(defconstant $iuCurrentDefLang -5)
(defconstant $iuScriptCurLang -6)
(defconstant $iuScriptDefLang -7)
; 
;  *  These routines are available in Carbon with the new names.
;  
; 
;  *  [Mac]ReplaceText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if TARGET_OS_MAC
; #define MacReplaceText ReplaceText

; #endif


(deftrap-inline "_ReplaceText" 
   ((baseText :Handle)
    (substitutionText :Handle)
    (key (:pointer :STR15))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  ScriptOrder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_ScriptOrder" 
   ((script1 :SInt16)
    (script2 :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  [Mac]CompareString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

; #if TARGET_OS_MAC
; #define MacCompareString CompareString

; #endif


(deftrap-inline "_CompareString" 
   ((aStr (:pointer :STR255))
    (bStr (:pointer :STR255))
    (itl2Handle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  IdenticalString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IdenticalString" 
   ((aStr (:pointer :STR255))
    (bStr (:pointer :STR255))
    (itl2Handle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  StringOrder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_StringOrder" 
   ((aStr (:pointer :STR255))
    (bStr (:pointer :STR255))
    (aScript :SInt16)
    (bScript :SInt16)
    (aLang :SInt16)
    (bLang :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  CompareText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_CompareText" 
   ((aPtr :pointer)
    (bPtr :pointer)
    (aLen :SInt16)
    (bLen :SInt16)
    (itl2Handle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  IdenticalText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_IdenticalText" 
   ((aPtr :pointer)
    (bPtr :pointer)
    (aLen :SInt16)
    (bLen :SInt16)
    (itl2Handle :Handle)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  TextOrder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_TextOrder" 
   ((aPtr :pointer)
    (bPtr :pointer)
    (aLen :SInt16)
    (bLen :SInt16)
    (aScript :SInt16)
    (bScript :SInt16)
    (aLang :SInt16)
    (bLang :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  LanguageOrder()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   not available
;  

(deftrap-inline "_LanguageOrder" 
   ((language1 :SInt16)
    (language2 :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  These routines are available in InterfaceLib with old names.
;  *  Macros are provided for C to allow source code use to the new names.
;  
; 
;  *  IUMagPString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IUMagIDPString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IUTextOrder()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IULangOrder()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IUScriptOrder()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IUMagString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IUMagIDString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IUCompPString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IUEqualPString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IUStringOrder()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IUCompString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  IUEqualString()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if CALL_NOT_IN_CARBON
#| 
; #if TARGET_OS_MAC
; #define CompareString(aStr, bStr, itl2Handle)              IUCompPString(aStr, bStr, itl2Handle)

; #endif

; #define CompareText(aPtr, bPtr, aLen, bLen, itl2Handle)          IUMagPString(aPtr, bPtr, aLen, bLen, itl2Handle)
; #define IdenticalString(aStr, bStr, itl2Handle)          IUEqualPString(aStr, bStr, itl2Handle)
; #define IdenticalText(aPtr, bPtr, aLen, bLen, itl2Handle)          IUMagIDPString(aPtr, bPtr, aLen, bLen, itl2Handle)
; #define StringOrder(aStr, bStr, aScript, bScript, aLang, bLang)          IUStringOrder(aStr, bStr, aScript, bScript, aLang, bLang)
; #define TextOrder(aPtr, bPtr, aLen, bLen, aScript, bScript, aLang, bLang)          IUTextOrder(aPtr, bPtr, aLen, bLen, aScript, bScript, aLang, bLang)
; #define LanguageOrder(language1, language2)          IULangOrder(language1, language2)
 |#

; #endif /* CALL_NOT_IN_CARBON */

; 
;  *  iucomppstring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  iuequalpstring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  iustringorder()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  iucompstring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  iuequalstring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  RelString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_RelString" 
   ((str1 (:pointer :STR255))
    (str2 (:pointer :STR255))
    (caseSensitive :Boolean)
    (diacSensitive :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  EqualString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_EqualString" 
   ((str1 (:pointer :STR255))
    (str2 (:pointer :STR255))
    (caseSensitive :Boolean)
    (diacSensitive :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :Boolean
() )
; 
;  *  relstring()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_relstring" 
   ((str1 (:pointer :char))
    (str2 (:pointer :char))
    (caseSensitive :Boolean)
    (diacSensitive :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt16
() )
; 
;  *  equalstring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __STRINGCOMPARE__ */


(provide-interface "StringCompare")