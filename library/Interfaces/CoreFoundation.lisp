(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CoreFoundation.h"
; at Sunday July 2,2006 7:22:42 pm.
; 	CoreFoundation.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_COREFOUNDATION__)
(defconstant $__COREFOUNDATION_COREFOUNDATION__ 1)
; #define __COREFOUNDATION_COREFOUNDATION__ 1

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFArray")

(require-interface "CoreFoundation/CFBag")

(require-interface "CoreFoundation/CFCharacterSet")

(require-interface "CoreFoundation/CFData")

(require-interface "CoreFoundation/CFDate")

(require-interface "CoreFoundation/CFDictionary")

(require-interface "CoreFoundation/CFNumber")

(require-interface "CoreFoundation/CFPropertyList")

(require-interface "CoreFoundation/CFSet")

(require-interface "CoreFoundation/CFString")

(require-interface "CoreFoundation/CFTimeZone")

(require-interface "CoreFoundation/CFTree")

(require-interface "CoreFoundation/CFURL")

(require-interface "CoreFoundation/CFXMLNode")

(require-interface "CoreFoundation/CFXMLParser")

; #if TARGET_API_MAC_OS8
#| |#

(require-interface "CoreFoundation/CFBundle")

#||#

(require-interface "CoreFoundation/CFPlugIn")

#||#

(require-interface "CoreFoundation/CFPreferences")

#||#

(require-interface "CoreFoundation/CFStringEncodingExt")

#||#

(require-interface "CoreFoundation/CFURLAccess")

#||#

(require-interface "CoreFoundation/CFUUID")

#|
 |#

; #else	/* Mac OS X */

(require-interface "stdarg")

(require-interface "assert")

(require-interface "ctype")

(require-interface "errno")

(require-interface "float")

(require-interface "limits")

(require-interface "locale")

(require-interface "math")

(require-interface "setjmp")

(require-interface "signal")

(require-interface "stddef")

(require-interface "stdio")

(require-interface "stdlib")

(require-interface "string")

(require-interface "time")

; #if defined(__STDC_VERSION__) && (199901L <= __STDC_VERSION__)
#| 
(require-interface "inttypes")
; #include <iso646.h>

(require-interface "stdbool")
|#

(require-interface "stdint")

#|
 |#

; #endif


(require-interface "CoreFoundation/CFBinaryHeap")

(require-interface "CoreFoundation/CFBitVector")

(require-interface "CoreFoundation/CFBundle")

(require-interface "CoreFoundation/CFByteOrder")

(require-interface "CoreFoundation/CFPlugIn")

(require-interface "CoreFoundation/CFURLAccess")

(require-interface "CoreFoundation/CFUUID")

; #if defined(__MACH__)
#| |#

(require-interface "CoreFoundation/CFDateFormatter")

#||#

(require-interface "CoreFoundation/CFLocale")

#||#

(require-interface "CoreFoundation/CFNumberFormatter")

#||#

(require-interface "CoreFoundation/CFUserNotification")

#|
 |#

; #endif


; #if defined(__MACH__) || defined(__WIN32__)
#| |#

(require-interface "CoreFoundation/CFMachPort")

#||#

(require-interface "CoreFoundation/CFMessagePort")

#||#

(require-interface "CoreFoundation/CFRunLoop")

#||#

(require-interface "CoreFoundation/CFSocket")

#|
 |#

; #endif


; #if !defined(DARWIN)

(require-interface "CoreFoundation/CFNotificationCenter")

(require-interface "CoreFoundation/CFPreferences")

(require-interface "CoreFoundation/CFStream")

(require-interface "CoreFoundation/CFStringEncodingExt")

; #endif /* !DARWIN */


; #endif


; #endif /* ! __COREFOUNDATION_COREFOUNDATION__ */


(provide-interface "CoreFoundation")