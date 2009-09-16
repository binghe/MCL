(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFTimeZone.h"
; at Sunday July 2,2006 7:22:53 pm.
; 	CFTimeZone.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFTIMEZONE__)
(defconstant $__COREFOUNDATION_CFTIMEZONE__ 1)
; #define __COREFOUNDATION_CFTIMEZONE__ 1

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFArray")

(require-interface "CoreFoundation/CFData")

(require-interface "CoreFoundation/CFDate")

(require-interface "CoreFoundation/CFDictionary")

(require-interface "CoreFoundation/CFString")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(deftrap-inline "_CFTimeZoneGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFTimeZoneCopySystem" 
   (
   )
   (:pointer :__CFTimeZone)
() )

(deftrap-inline "_CFTimeZoneResetSystem" 
   (
   )
   nil
() )

(deftrap-inline "_CFTimeZoneCopyDefault" 
   (
   )
   (:pointer :__CFTimeZone)
() )

(deftrap-inline "_CFTimeZoneSetDefault" 
   ((tz (:pointer :__CFTimeZone))
   )
   nil
() )

(deftrap-inline "_CFTimeZoneCopyKnownNames" 
   (
   )
   (:pointer :__CFArray)
() )

(deftrap-inline "_CFTimeZoneCopyAbbreviationDictionary" 
   (
   )
   (:pointer :__CFDictionary)
() )

(deftrap-inline "_CFTimeZoneSetAbbreviationDictionary" 
   ((dict (:pointer :__CFDictionary))
   )
   nil
() )

(deftrap-inline "_CFTimeZoneCreate" 
   ((allocator (:pointer :__CFAllocator))
    (name (:pointer :__CFString))
    (data (:pointer :__CFData))
   )
   (:pointer :__CFTimeZone)
() )

(deftrap-inline "_CFTimeZoneCreateWithTimeIntervalFromGMT" 
   ((allocator (:pointer :__CFAllocator))
    (ti :double-float)
   )
   (:pointer :__CFTimeZone)
() )

(deftrap-inline "_CFTimeZoneCreateWithName" 
   ((allocator (:pointer :__CFAllocator))
    (name (:pointer :__CFString))
    (tryAbbrev :Boolean)
   )
   (:pointer :__CFTimeZone)
() )

(deftrap-inline "_CFTimeZoneGetName" 
   ((tz (:pointer :__CFTimeZone))
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFTimeZoneGetData" 
   ((tz (:pointer :__CFTimeZone))
   )
   (:pointer :__CFData)
() )

(deftrap-inline "_CFTimeZoneGetSecondsFromGMT" 
   ((tz (:pointer :__CFTimeZone))
    (at :double-float)
   )
   :double-float
() )

(deftrap-inline "_CFTimeZoneCopyAbbreviation" 
   ((tz (:pointer :__CFTimeZone))
    (at :double-float)
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFTimeZoneIsDaylightSavingTime" 
   ((tz (:pointer :__CFTimeZone))
    (at :double-float)
   )
   :Boolean
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFTIMEZONE__ */


(provide-interface "CFTimeZone")