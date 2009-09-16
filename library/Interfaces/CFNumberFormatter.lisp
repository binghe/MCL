(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFNumberFormatter.h"
; at Sunday July 2,2006 7:27:17 pm.
; 	CFNumberFormatter.h
; 	Copyright (c) 2003-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFNUMBERFORMATTER__)
(defconstant $__COREFOUNDATION_CFNUMBERFORMATTER__ 1)
; #define __COREFOUNDATION_CFNUMBERFORMATTER__ 1

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFNumber")

(require-interface "CoreFoundation/CFLocale")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(def-mactype :CFNumberFormatterRef (find-mactype '(:pointer :__CFNumberFormatter)))
;  CFNumberFormatters are not thread-safe.  Do not use one from multiple threads!

(deftrap-inline "_CFNumberFormatterGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )
;  number format styles

(defconstant $kCFNumberFormatterNoStyle 0)
(defconstant $kCFNumberFormatterDecimalStyle 1)
(defconstant $kCFNumberFormatterCurrencyStyle 2)
(defconstant $kCFNumberFormatterPercentStyle 3)
(defconstant $kCFNumberFormatterScientificStyle 4)
(def-mactype :CFNumberFormatterStyle (find-mactype ':SINT32))

(deftrap-inline "_CFNumberFormatterCreate" 
   ((allocator (:pointer :__CFAllocator))
    (locale (:pointer :__CFLocale))
    (style :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFNumberFormatter)
() )
;  Returns a CFNumberFormatter, localized to the given locale, which
;  will format numbers to the given style.

(deftrap-inline "_CFNumberFormatterGetLocale" 
   ((formatter (:pointer :__CFNumberFormatter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFLocale)
() )

(deftrap-inline "_CFNumberFormatterGetStyle" 
   ((formatter (:pointer :__CFNumberFormatter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
;  Get the properties with which the number formatter was created.

(deftrap-inline "_CFNumberFormatterGetFormat" 
   ((formatter (:pointer :__CFNumberFormatter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )

(deftrap-inline "_CFNumberFormatterSetFormat" 
   ((formatter (:pointer :__CFNumberFormatter))
    (formatString (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
;  Set the format description string of the number formatter.  This
;  overrides the style settings.  The format of the format string
;  is as defined by the ICU library, and is similar to that found
;  in Microsoft Excel and NSNumberFormatter (and Java I believe).
;  The number formatter starts with a default format string defined
;  by the style argument with which it was created.

(deftrap-inline "_CFNumberFormatterCreateStringWithNumber" 
   ((allocator (:pointer :__CFAllocator))
    (formatter (:pointer :__CFNumberFormatter))
    (number (:pointer :__CFNumber))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )

(deftrap-inline "_CFNumberFormatterCreateStringWithValue" 
   ((allocator (:pointer :__CFAllocator))
    (formatter (:pointer :__CFNumberFormatter))
    (numberType :SInt32)
    (valuePtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )
;  Create a string representation of the given number or value
;  using the current state of the number formatter.

(defconstant $kCFNumberFormatterParseIntegersOnly 1);  only parse integers 

(def-mactype :CFNumberFormatterOptionFlags (find-mactype ':SINT32))

(deftrap-inline "_CFNumberFormatterCreateNumberFromString" 
   ((allocator (:pointer :__CFAllocator))
    (formatter (:pointer :__CFNumberFormatter))
    (string (:pointer :__CFString))
    (rangep (:pointer :CFRange))
    (options :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFNumber)
() )

(deftrap-inline "_CFNumberFormatterGetValueFromString" 
   ((formatter (:pointer :__CFNumberFormatter))
    (string (:pointer :__CFString))
    (rangep (:pointer :CFRange))
    (numberType :SInt32)
    (valuePtr :pointer)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  Parse a string representation of a number using the current state
;  of the number formatter.  The range parameter specifies the range
;  of the string in which the parsing should occur in input, and on
;  output indicates the extent that was used; this parameter can
;  be NULL, in which case the whole string may be used.  The
;  return value indicates whether some number was computed and
;  (if valuePtr is not NULL) stored at the location specified by
;  valuePtr.  The numberType indicates the type of value pointed
;  to by valuePtr.

(deftrap-inline "_CFNumberFormatterSetProperty" 
   ((formatter (:pointer :__CFNumberFormatter))
    (key (:pointer :__CFString))
    (value (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_CFNumberFormatterCopyProperty" 
   ((formatter (:pointer :__CFNumberFormatter))
    (key (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :void)
() )
;  Set and get various properties of the number formatter, the set of
;  which may be expanded in the future.
(def-mactype :kCFNumberFormatterCurrencyCode (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFNumberFormatterDecimalSeparator (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFNumberFormatterCurrencyDecimalSeparator (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFNumberFormatterAlwaysShowDecimalSeparator (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFBoolean
(def-mactype :kCFNumberFormatterGroupingSeparator (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFNumberFormatterUseGroupingSeparator (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFBoolean
(def-mactype :kCFNumberFormatterPercentSymbol (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFNumberFormatterZeroSymbol (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFNumberFormatterNaNSymbol (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFNumberFormatterInfinitySymbol (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFNumberFormatterMinusSign (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFNumberFormatterPlusSign (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFNumberFormatterCurrencySymbol (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFNumberFormatterExponentSymbol (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFNumberFormatterMinIntegerDigits (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFNumber
(def-mactype :kCFNumberFormatterMaxIntegerDigits (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFNumber
(def-mactype :kCFNumberFormatterMinFractionDigits (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFNumber
(def-mactype :kCFNumberFormatterMaxFractionDigits (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFNumber
(def-mactype :kCFNumberFormatterGroupingSize (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFNumber
(def-mactype :kCFNumberFormatterSecondaryGroupingSize (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFNumber
(def-mactype :kCFNumberFormatterRoundingMode (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFNumber
(def-mactype :kCFNumberFormatterRoundingIncrement (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFNumber
(def-mactype :kCFNumberFormatterFormatWidth (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFNumber
(def-mactype :kCFNumberFormatterPaddingPosition (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFNumber
(def-mactype :kCFNumberFormatterPaddingCharacter (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFNumberFormatterDefaultFormat (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString

(defconstant $kCFNumberFormatterRoundCeiling 0)
(defconstant $kCFNumberFormatterRoundFloor 1)
(defconstant $kCFNumberFormatterRoundDown 2)
(defconstant $kCFNumberFormatterRoundUp 3)
(defconstant $kCFNumberFormatterRoundHalfEven 4)
(defconstant $kCFNumberFormatterRoundHalfDown 5)
(defconstant $kCFNumberFormatterRoundHalfUp 6)
(def-mactype :CFNumberFormatterRoundingMode (find-mactype ':SINT32))

(defconstant $kCFNumberFormatterPadBeforePrefix 0)
(defconstant $kCFNumberFormatterPadAfterPrefix 1)
(defconstant $kCFNumberFormatterPadBeforeSuffix 2)
(defconstant $kCFNumberFormatterPadAfterSuffix 3)
(def-mactype :CFNumberFormatterPadPosition (find-mactype ':SINT32))

(deftrap-inline "_CFNumberFormatterGetDecimalInfoForCurrencyCode" 
   ((currencyCode (:pointer :__CFString))
    (defaultFractionDigits (:pointer :int32_t))
    (roundingIncrement (:pointer :double))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  Returns the number of fraction digits that should be displayed, and
;  the rounding increment (or 0.0 if no rounding is done by the currency)
;  for the given currency.  Returns false if the currency code is unknown
;  or the information is not available.
;  Not localized because these are properties of the currency.

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif


; #endif /* ! __COREFOUNDATION_CFNUMBERFORMATTER__ */


(provide-interface "CFNumberFormatter")