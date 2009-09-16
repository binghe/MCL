(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFDateFormatter.h"
; at Sunday July 2,2006 7:27:16 pm.
; 	CFDateFormatter.h
; 	Copyright (c) 2003-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFDATEFORMATTER__)
(defconstant $__COREFOUNDATION_CFDATEFORMATTER__ 1)
; #define __COREFOUNDATION_CFDATEFORMATTER__ 1

; #if MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_3

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFDate")

(require-interface "CoreFoundation/CFLocale")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(def-mactype :CFDateFormatterRef (find-mactype '(:pointer :__CFDateFormatter)))
;  CFDateFormatters are not thread-safe.  Do not use one from multiple threads!

(deftrap-inline "_CFDateFormatterGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :UInt32
() )
;  date and time format styles

(defconstant $kCFDateFormatterNoStyle 0)
(defconstant $kCFDateFormatterShortStyle 1)
(defconstant $kCFDateFormatterMediumStyle 2)
(defconstant $kCFDateFormatterLongStyle 3)
(defconstant $kCFDateFormatterFullStyle 4)
(def-mactype :CFDateFormatterStyle (find-mactype ':SINT32))
;  The exact formatted result for these date and time styles depends on the
;  locale, but generally:
;      Short is completely numeric, such as "12/13/52" or "3:30pm"
;      Medium is longer, such as "Jan 12, 1952"
;      Long is longer, such as "January 12, 1952" or "3:30:32pm"
;      Full is pretty complete; e.g. "Tuesday, April 12, 1952 AD" or "3:30:42pm PST"
;  The specifications though are left fuzzy, in part simply because a user's
;  preference choices may affect the output, and also the results may change
;  from one OS release to another.  To produce an exactly formatted date you
;  should not rely on styles and localization, but set the format string and
;  use nothing but numbers.

(deftrap-inline "_CFDateFormatterCreate" 
   ((allocator (:pointer :__CFAllocator))
    (locale (:pointer :__CFLocale))
    (dateStyle :SInt32)
    (timeStyle :SInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFDateFormatter)
() )
;  Returns a CFDateFormatter, localized to the given locale, which
;  will format dates to the given date and time styles.

(deftrap-inline "_CFDateFormatterGetLocale" 
   ((formatter (:pointer :__CFDateFormatter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFLocale)
() )

(deftrap-inline "_CFDateFormatterGetDateStyle" 
   ((formatter (:pointer :__CFDateFormatter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )

(deftrap-inline "_CFDateFormatterGetTimeStyle" 
   ((formatter (:pointer :__CFDateFormatter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :SInt32
() )
;  Get the properties with which the date formatter was created.

(deftrap-inline "_CFDateFormatterGetFormat" 
   ((formatter (:pointer :__CFDateFormatter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )

(deftrap-inline "_CFDateFormatterSetFormat" 
   ((formatter (:pointer :__CFDateFormatter))
    (formatString (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )
;  Set the format description string of the date formatter.  This
;  overrides the style settings.  The format of the format string
;  is as defined by the ICU library, and is similar to that found
;  in C# (and Java I believe).  The date formatter starts with a
;  default format string defined by the style arguments with
;  which it was created.

(deftrap-inline "_CFDateFormatterCreateStringWithDate" 
   ((allocator (:pointer :__CFAllocator))
    (formatter (:pointer :__CFDateFormatter))
    (date (:pointer :__CFDate))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )

(deftrap-inline "_CFDateFormatterCreateStringWithAbsoluteTime" 
   ((allocator (:pointer :__CFAllocator))
    (formatter (:pointer :__CFDateFormatter))
    (at :double-float)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFString)
() )
;  Create a string representation of the given date or CFAbsoluteTime
;  using the current state of the date formatter.

(deftrap-inline "_CFDateFormatterCreateDateFromString" 
   ((allocator (:pointer :__CFAllocator))
    (formatter (:pointer :__CFDateFormatter))
    (string (:pointer :__CFString))
    (rangep (:pointer :CFRange))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFDate)
() )

(deftrap-inline "_CFDateFormatterGetAbsoluteTimeFromString" 
   ((formatter (:pointer :__CFDateFormatter))
    (string (:pointer :__CFString))
    (rangep (:pointer :CFRange))
    (atp (:pointer :CFABSOLUTETIME))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :Boolean
() )
;  Parse a string representation of a date using the current state
;  of the date formatter.  The range parameter specifies the range
;  of the string in which the parsing should occur in input, and on
;  output indicates the extent that was used; this parameter can
;  be NULL, in which case the whole string may be used.  The
;  return value indicates whether some date was computed and
;  (if atp is not NULL) stored at the location specified by atp.

(deftrap-inline "_CFDateFormatterSetProperty" 
   ((formatter (:pointer :__CFDateFormatter))
    (key (:pointer :__CFString))
    (value (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   nil
() )

(deftrap-inline "_CFDateFormatterCopyProperty" 
   ((formatter (:pointer :__CFDateFormatter))
    (key (:pointer :__CFString))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :void)
() )
;  Set and get various properties of the date formatter, the set of
;  which may be expanded in the future.
(def-mactype :kCFDateFormatterIsLenient (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFBoolean
(def-mactype :kCFDateFormatterTimeZone (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFTimeZone
(def-mactype :kCFDateFormatterCalendarName (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFDateFormatterDefaultFormat (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
;  CFString
(def-mactype :kCFGregorianCalendar (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif


; #endif /* ! __COREFOUNDATION_CFDATEFORMATTER__ */


(provide-interface "CFDateFormatter")