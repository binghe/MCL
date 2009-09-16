(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:TextUtils.h"
; at Sunday July 2,2006 7:23:24 pm.
; 
;      File:       CarbonCore/TextUtils.h
;  
;      Contains:   Text Utilities Interfaces.
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
; #ifndef __TEXTUTILS__
; #define __TEXTUTILS__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __NUMBERFORMATTING__
#| #|
#include <CarbonCoreNumberFormatting.h>
#endif
|#
 |#
; #ifndef __STRINGCOMPARE__
#| #|
#include <CarbonCoreStringCompare.h>
#endif
|#
 |#
; #ifndef __DATETIMEUTILS__
#| #|
#include <CarbonCoreDateTimeUtils.h>
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
; 
;     Here are the current System 7 routine names and the translations to the older forms.
;     Please use the newer forms in all new code and migrate the older names out of existing
;     code as maintainance permits.
;     
;     NEW NAME                    OLD NAMEs                   OBSOLETE FORM (no script code)
; 
;     FindScriptRun
;     FindWordBreaks                                          NFindWord, FindWord
;     GetIndString            
;     GetString
;     Munger
;     NewString               
;     SetString               
;     StyledLineBreak
;     TruncString
;     TruncText
; 
;     UpperString ($A054)         UprString, UprText
;     UppercaseText               SCUpperText (a only)        UpperText ($A456)
;     LowercaseText                                           LwrString, LowerText, LwrText ($A056)
;     StripDiacritics                                         StripText ($A256)
;     UppercaseStripDiacritics                                StripUpperText ($A656)
; 
; 
; 
;  TruncCode, StyledLineBreakCode, and truncation constants moved to QuickDrawText.i 
(defrecord ScriptRunStatus
   (script :SInt8)
   (runVariant :SInt8)
)

;type name? (%define-record :ScriptRunStatus (find-record-descriptor ':ScriptRunStatus))
(defrecord BreakTable
   (charTypes (:array :character 256))
   (tripleLength :SInt16)
   (triples (:array :SInt16 1))
)

;type name? (%define-record :BreakTable (find-record-descriptor ':BreakTable))

(def-mactype :BreakTablePtr (find-mactype '(:pointer :BreakTable)))
(defrecord NBreakTable
   (flags1 :SInt8)
   (flags2 :SInt8)
   (version :SInt16)
   (classTableOff :SInt16)
   (auxCTableOff :SInt16)
   (backwdTableOff :SInt16)
   (forwdTableOff :SInt16)
   (doBackup :SInt16)
   (length :SInt16)                             ;  length of NBreakTable 
   (charTypes (:array :character 256))
   (tables (:array :SInt16 1))
)

;type name? (%define-record :NBreakTable (find-record-descriptor ':NBreakTable))

(def-mactype :NBreakTablePtr (find-mactype '(:pointer :NBreakTable)))
;  The following functions are new names that work on 68k and PowerPC
; 
;  *  Munger()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_Munger" 
   ((h :Handle)
    (offset :signed-long)
    (ptr1 :pointer)
    (len1 :signed-long)
    (ptr2 :pointer)
    (len2 :signed-long)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :SInt32
() )
; 
;  *  NewString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_NewString" 
   ((theString (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :UInt8)
() )
; 
;  *  SetString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_SetString" 
   ((theString (:Handle :UInt8))
    (strNew (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  GetString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetString" 
   ((stringID :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   (:Handle :UInt8)
() )
; 
;  *  GetIndString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_GetIndString" 
   ((theString (:pointer :STR255))
    (strListID :SInt16)
    (index :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  setstring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  newstring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  getindstring()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  FindWordBreaks()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FindWordBreaks" 
   ((textPtr :pointer)
    (textLength :SInt16)
    (offset :SInt16)
    (leadingEdge :Boolean)
    (breaks (:pointer :BreakTable))
    (offsets (:pointer :OFFSETTABLE))
    (script :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  LowercaseText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_LowercaseText" 
   ((textPtr :pointer)
    (len :SInt16)
    (script :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  UppercaseText()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_UppercaseText" 
   ((textPtr :pointer)
    (len :SInt16)
    (script :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  StripDiacritics()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_StripDiacritics" 
   ((textPtr :pointer)
    (len :SInt16)
    (script :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  UppercaseStripDiacritics()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_UppercaseStripDiacritics" 
   ((textPtr :pointer)
    (len :SInt16)
    (script :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  FindScriptRun()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_FindScriptRun" 
   ((textPtr :pointer)
    (textLen :signed-long)
    (lenUsed (:pointer :long))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :ScriptRunStatus
() )
; 
;     The following functions are old names, but are required for PowerPC builds
;     because InterfaceLib exports these names, instead of the new ones.
; 
; 
;  *  FindWord()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  NFindWord()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;    On 68K machines, LwrText, LowerText, StripText, UpperText and StripUpperText
;    return an error code in register D0, but System 7 PowerMacs do not emulate
;    this properly, so checking D0 is unreliable.
; 
; 
;  *  LwrText()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  LowerText()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  StripText()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  UpperText()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  StripUpperText()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
;  The following are new names which are exported by InterfaceLib
; 
;  *  UpperString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_UpperString" 
   ((theString (:pointer :STR255))
    (diacSensitive :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  upperstring()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

(deftrap-inline "_upperstring" 
   ((theString (:pointer :char))
    (diacSensitive :Boolean)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
;  The following are macros which map old names to the names exported by InterfaceLib

; #if OLDROUTINENAMES
#| 
; #define UprString(theString, diacSensitive)           UpperString(theString, diacSensitive)
 |#

; #endif  /* OLDROUTINENAMES */

;  Old routine name but no new names are mapped to it:
; 
;  *  UprText()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;     Functions for converting between C and Pascal Strings
;     (Previously in Strings.h)
;     
;     Note: CopyPascalStringToC, CopyCStringToPascal, c2pstrcpy, and p2cstrcpy
;           are written to allow inplace conversion.  That is, the src and dst
;           parameters can point to the memory location.  These functions
;           are available in CarbonLib and CarbonAccessors.o.
;           
;     Note: c2pstr, C2PStr, p2cstr, and P2CStr are all deprecated.  These functions
;           only do inplace conversion and often require casts to call them.  This can
;           cause bugs because you can easily cast away a const and change the 
;           contents of a read-only buffer.  These functions are available
;           in InterfaceLib, or when building for Carbon if you #define OLDP2C,
;           then they are available as a macro.
;     
; 
; 
;  *  c2pstrcpy()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
;  

(deftrap-inline "_c2pstrcpy" 
   ((dst (:pointer :STR255))
    (src (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  p2cstrcpy()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
;  

(deftrap-inline "_p2cstrcpy" 
   ((dst (:pointer :char))
    (src (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CopyPascalStringToC()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
;  

(deftrap-inline "_CopyPascalStringToC" 
   ((src (:pointer :STR255))
    (dst (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  CopyCStringToPascal()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in CarbonAccessors.o 1.0.2 and later
;  

(deftrap-inline "_CopyCStringToPascal" 
   ((src (:pointer :char))
    (dst (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   nil
() )
; 
;  *  c2pstr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  C2PStr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  p2cstr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  
; 
;  *  P2CStr()
;  *  
;  *  Availability:
;  *    Mac OS X:         not available
;  *    CarbonLib:        not available
;  *    Non-Carbon CFM:   in InterfaceLib 7.1 and later
;  

; #if !TARGET_OS_MAC
#|                                              ;  Added for QuickTime 3.0 
; #define C2PStr(a)  (StringPtr)c2pstr((Ptr)(a))
; #define P2CStr(a)  (Ptr)p2cstr(a)
; #define CopyPascalStringToC(src,dst) p2cstrcpy(dst,src)
; #define CopyCStringToPascal(src,dst) c2pstrcpy(dst,src)
 |#

; #endif


; #if TARGET_OS_MAC && TARGET_API_MAC_CARBON && OLDP2C
#|                                              ;  macros to help source code that uses deprecated inplace  
;  conversion routines to compiler for carbon 
; #define p2cstr(aStr) (p2cstrcpy((char *) aStr, aStr) , (char *) aStr)
; #define c2pstr(aStr) (c2pstrcpy((StringPtr)aStr, aStr) , (StringPtr) aStr)
; #define C2PStr(a)  (StringPtr)c2pstr((Ptr)(a))
; #define P2CStr(a)  (Ptr)p2cstr(a)
 |#

; #endif

; #pragma options align=reset
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* __TEXTUTILS__ */


(provide-interface "TextUtils")