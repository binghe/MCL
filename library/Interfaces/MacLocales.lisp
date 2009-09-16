(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:MacLocales.h"
; at Sunday July 2,2006 7:23:20 pm.
; 
;      File:       CarbonCore/MacLocales.h
;  
;      Contains:   Types & prototypes for locale functions
;  
;      Version:    CarbonCore-545~1
;  
;      Copyright:  © 1998-2003 by Apple Computer, Inc., all rights reserved.
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef __MACLOCALES__
; #define __MACLOCALES__
; #ifndef __MACTYPES__
#| #|
#include <CarbonCoreMacTypes.h>
#endif
|#
 |#
; #ifndef __MACERRORS__
#| #|
#include <CarbonCoreMacErrors.h>
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
;    TYPES & CONSTANTS
;    -------------------------------------------------------------------------------------------------
; 

(def-mactype :LocaleRef (find-mactype '(:pointer :OpaqueLocaleRef)))

(def-mactype :LocalePartMask (find-mactype ':UInt32))
;  bit set requests the following:

(defconstant $kLocaleLanguageMask 1)            ;  ISO 639-1 or -2 language code (2 or 3 letters)

(defconstant $kLocaleLanguageVariantMask 2)     ;  custom string for language variant

(defconstant $kLocaleScriptMask 4)              ;  ISO 15924 script code (2 letters)

(defconstant $kLocaleScriptVariantMask 8)       ;  custom string for script variant

(defconstant $kLocaleRegionMask 16)             ;  ISO 3166 country/region code (2 letters)

(defconstant $kLocaleRegionVariantMask 32)      ;  custom string for region variant

(defconstant $kLocaleAllPartsMask 63)           ;  all of the above


(def-mactype :LocaleOperationClass (find-mactype ':FourCharCode))
;  constants for LocaleOperationClass are in UnicodeUtilities interfaces

(def-mactype :LocaleOperationVariant (find-mactype ':FourCharCode))
(defrecord LocaleAndVariant
   (locale (:pointer :OpaqueLocaleRef))
   (opVariant :FourCharCode)
)

;type name? (%define-record :LocaleAndVariant (find-record-descriptor ':LocaleAndVariant))

(def-mactype :LocaleNameMask (find-mactype ':UInt32))
;  bit set requests the following:

(defconstant $kLocaleNameMask 1)                ;  name of locale

(defconstant $kLocaleOperationVariantNameMask 2);  name of LocaleOperationVariant

(defconstant $kLocaleAndVariantNameMask 3)      ;  all of the above

; 
;    -------------------------------------------------------------------------------------------------
;    FUNCTION PROTOTYPES
;    -------------------------------------------------------------------------------------------------
; 
;  Convert to or from LocaleRefs (and related utilities)
; 
;  *  LocaleRefFromLangOrRegionCode()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LocalesLib 8.6 and later
;  

(deftrap-inline "_LocaleRefFromLangOrRegionCode" 
   ((lang :SInt16)
    (region :SInt16)
    (locale (:pointer :LOCALEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LocaleRefFromLocaleString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LocalesLib 8.6 and later
;  

(deftrap-inline "_LocaleRefFromLocaleString" 
   ((localeString (:pointer :char))
    (locale (:pointer :LOCALEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LocaleRefGetPartString()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LocalesLib 8.6 and later
;  

(deftrap-inline "_LocaleRefGetPartString" 
   ((locale (:pointer :OpaqueLocaleRef))
    (partMask :UInt32)
    (maxStringLen :UInt32)
    (partString (:pointer :char))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LocaleStringToLangAndRegionCodes()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LocalesLib 9.0 and later
;  

(deftrap-inline "_LocaleStringToLangAndRegionCodes" 
   ((localeString (:pointer :char))
    (lang (:pointer :LANGCODE))
    (region (:pointer :REGIONCODE))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Enumerate locales for a LocaleOperationClass 
; 
;  *  LocaleOperationCountLocales()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LocalesLib 8.6 and later
;  

(deftrap-inline "_LocaleOperationCountLocales" 
   ((opClass :FourCharCode)
    (localeCount (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LocaleOperationGetLocales()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LocalesLib 8.6 and later
;  

(deftrap-inline "_LocaleOperationGetLocales" 
   ((opClass :FourCharCode)
    (maxLocaleCount :UInt32)
    (actualLocaleCount (:pointer :ItemCount))
    (localeVariantList (:pointer :LocaleAndVariant))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Get names for a locale (or a region's language)
; 
;  *  LocaleGetName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LocalesLib 8.6 and later
;  

(deftrap-inline "_LocaleGetName" 
   ((locale (:pointer :OpaqueLocaleRef))
    (opVariant :FourCharCode)
    (nameMask :UInt32)
    (displayLocale (:pointer :OpaqueLocaleRef))
    (maxNameLen :UInt32)
    (actualNameLen (:pointer :UniCharCount))
    (displayName (:pointer :UniChar))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LocaleCountNames()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LocalesLib 8.6 and later
;  

(deftrap-inline "_LocaleCountNames" 
   ((locale (:pointer :OpaqueLocaleRef))
    (opVariant :FourCharCode)
    (nameMask :UInt32)
    (nameCount (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LocaleGetIndName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LocalesLib 8.6 and later
;  

(deftrap-inline "_LocaleGetIndName" 
   ((locale (:pointer :OpaqueLocaleRef))
    (opVariant :FourCharCode)
    (nameMask :UInt32)
    (nameIndex :UInt32)
    (maxNameLen :UInt32)
    (actualNameLen (:pointer :UniCharCount))
    (displayName (:pointer :UniChar))
    (displayLocale (:pointer :LOCALEREF))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LocaleGetRegionLanguageName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LocalesLib 9.0 and later
;  

(deftrap-inline "_LocaleGetRegionLanguageName" 
   ((region :SInt16)
    (languageName (:pointer :STR255))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
;  Get names for a LocaleOperationClass
; 
;  *  LocaleOperationGetName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LocalesLib 8.6 and later
;  

(deftrap-inline "_LocaleOperationGetName" 
   ((opClass :FourCharCode)
    (displayLocale (:pointer :OpaqueLocaleRef))
    (maxNameLen :UInt32)
    (actualNameLen (:pointer :UniCharCount))
    (displayName (:pointer :UniChar))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LocaleOperationCountNames()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LocalesLib 8.6 and later
;  

(deftrap-inline "_LocaleOperationCountNames" 
   ((opClass :FourCharCode)
    (nameCount (:pointer :ItemCount))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_0_AND_LATER
   :OSStatus
() )
; 
;  *  LocaleOperationGetIndName()
;  *  
;  *  Availability:
;  *    Mac OS X:         in version 10.0 and later in CoreServices.framework
;  *    CarbonLib:        in CarbonLib 1.0 and later
;  *    Non-Carbon CFM:   in LocalesLib 8.6 and later
;  

(deftrap-inline "_LocaleOperationGetIndName" 
   ((opClass :FourCharCode)
    (nameIndex :UInt32)
    (maxNameLen :UInt32)
    (actualNameLen (:pointer :UniCharCount))
    (displayName (:pointer :UniChar))
    (displayLocale (:pointer :LOCALEREF))
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

; #endif /* __MACLOCALES__ */


(provide-interface "MacLocales")