(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFLocale.h"
; at Sunday July 2,2006 7:22:49 pm.
; 	CFLocale.h
; 	Copyright (c) 2002-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFLOCALE__)
(defconstant $__COREFOUNDATION_CFLOCALE__ 1)
; #define __COREFOUNDATION_CFLOCALE__ 1

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

(require-interface "CoreFoundation/CFBase")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(def-mactype :CFLocaleRef (find-mactype '(:pointer :__CFLocale)))

(deftrap-inline "_CFLocaleGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )

(deftrap-inline "_CFLocaleGetSystem" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFLocale)
() )
;  Returns the "root", canonical locale.  Contains fixed "backstop" settings.

(deftrap-inline "_CFLocaleCopyCurrent" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFLocale)
() )
;  Returns the logical "user" locale for the current user.
;  [This is Copy in the sense that you get a retain you have to release,
;  but we may return the same cached object over and over.]  Settings
;  you get from this locale do not change under you as CFPreferences
;  are changed (for safety and correctness).  Generally you would not
;  grab this and hold onto it forever, but use it to do the operations
;  you need to do at the moment, then throw it away.  (The non-changing
;  ensures that all the results of your operations are consistent.)

(deftrap-inline "_CFLocaleCreateCanonicalLocaleIdentifierFromString" 
   ((allocator (:pointer :__CFAllocator))
    (localeIdentifier (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )
;  Map an arbitrary locale identification string (something close at
;  least) to the canonical identifier.

(deftrap-inline "_CFLocaleCreateCanonicalLocaleIdentifierFromScriptManagerCodes" 
   ((allocator (:pointer :__CFAllocator))
    (lcode :SInt16)
    (rcode :SInt16)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )
;  Map a Mac OS LangCode and RegionCode to the canonical locale identifier.

(deftrap-inline "_CFLocaleCreate" 
   ((allocator (:pointer :__CFAllocator))
    (localeIdentifier (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFLocale)
() )
;  Returns a CFLocaleRef for the locale named by the "arbitrary" locale identifier.

(deftrap-inline "_CFLocaleCreateCopy" 
   ((allocator (:pointer :__CFAllocator))
    (locale (:pointer :__CFLocale))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFLocale)
() )
;  Having gotten a CFLocale from somebody, code should make a copy
;  if it is going to use it for several operations
;  or hold onto it.  In the future, there may be mutable locales.

(deftrap-inline "_CFLocaleGetIdentifier" 
   ((locale (:pointer :__CFLocale))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )
;  Returns the locale's identifier.  This may not be the same string
;  that the locale was created with (CFLocale may canonicalize it).

(deftrap-inline "_CFLocaleGetValue" 
   ((locale (:pointer :__CFLocale))
    (key (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :void)
() )
;  Returns the value for the given key.  This is how settings and state
;  are accessed via a CFLocale.  Values might be of any CF type.
;  Locale Keys
(def-mactype :kCFLocaleMeasurementSystem (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  "Metric" or "U.S."
(def-mactype :kCFLocaleDecimalSeparator (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kCFLocaleGroupingSeparator (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kCFLocaleCurrencySymbol (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
(def-mactype :kCFLocaleCurrencyCode (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  ISO 3-letter currency code

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif


; #endif /* ! __COREFOUNDATION_CFLOCALE__ */


(provide-interface "CFLocale")