(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFDate.h"
; at Sunday July 2,2006 7:22:47 pm.
; 	CFDate.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFDATE__)
(defconstant $__COREFOUNDATION_CFDATE__ 1)
; #define __COREFOUNDATION_CFDATE__ 1

(require-interface "CoreFoundation/CFBase")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(def-mactype :CFTimeInterval (find-mactype ':double-float))

(def-mactype :CFAbsoluteTime (find-mactype ':double-float))
;  absolute time is the time interval since the reference date 
;  the reference date (epoch) is 00:00:00 1 January 2001. 

(deftrap-inline "_CFAbsoluteTimeGetCurrent" 
   (
   )
   :double-float
() )
(def-mactype :kCFAbsoluteTimeIntervalSince1970 (find-mactype ':CFTimeInterval))
(def-mactype :kCFAbsoluteTimeIntervalSince1904 (find-mactype ':CFTimeInterval))

(def-mactype :CFDateRef (find-mactype '(:pointer :__CFDate)))

(deftrap-inline "_CFDateGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFDateCreate" 
   ((allocator (:pointer :__CFAllocator))
    (at :double-float)
   )
   (:pointer :__CFDate)
() )

(deftrap-inline "_CFDateGetAbsoluteTime" 
   ((theDate (:pointer :__CFDate))
   )
   :double-float
() )

(deftrap-inline "_CFDateGetTimeIntervalSinceDate" 
   ((theDate (:pointer :__CFDate))
    (otherDate (:pointer :__CFDate))
   )
   :double-float
() )

(deftrap-inline "_CFDateCompare" 
   ((theDate (:pointer :__CFDate))
    (otherDate (:pointer :__CFDate))
    (context :pointer)
   )
   :SInt32
() )

(def-mactype :CFTimeZoneRef (find-mactype '(:pointer :__CFTimeZone)))
(defrecord CFGregorianDate
   (year :SInt32)
   (month :SInt8)
   (day :SInt8)
   (hour :SInt8)
   (minute :SInt8)
   (second :double-float)
)
(defrecord CFGregorianUnits
   (years :SInt32)
   (months :SInt32)
   (days :SInt32)
   (hours :SInt32)
   (minutes :SInt32)
   (seconds :double-float)
)

(defconstant $kCFGregorianUnitsYears 1)
(defconstant $kCFGregorianUnitsMonths 2)
(defconstant $kCFGregorianUnitsDays 4)
(defconstant $kCFGregorianUnitsHours 8)
(defconstant $kCFGregorianUnitsMinutes 16)
(defconstant $kCFGregorianUnitsSeconds 32)
; #if 0
#| 
(defconstant $kCFGregorianUnitsTimeZone #x100)
(defconstant $kCFGregorianUnitsDayOfWeek #x200)
 |#

; #endif


(defconstant $kCFGregorianAllUnits #xFFFFFF)
(def-mactype :CFGregorianUnitFlags (find-mactype ':SINT32))

(deftrap-inline "_CFGregorianDateIsValid" 
   ((year :SInt32)
    (month :SInt8)
    (day :SInt8)
    (hour :SInt8)
    (minute :SInt8)
    (second :double-float)
    (unitFlags :UInt32)
   )
   :Boolean
() )

(deftrap-inline "_CFGregorianDateGetAbsoluteTime" 
   ((year :SInt32)
    (month :SInt8)
    (day :SInt8)
    (hour :SInt8)
    (minute :SInt8)
    (second :double-float)
    (tz (:pointer :__CFTimeZone))
   )
   :double-float
() )

(deftrap-inline "_CFAbsoluteTimeGetGregorianDate" 
   ((returnArg (:pointer :CFGREGORIANDATE))
    (at :double-float)
    (tz (:pointer :__CFTimeZone))
   )
   nil
() )

(deftrap-inline "_CFAbsoluteTimeAddGregorianUnits" 
   ((at :double-float)
    (tz (:pointer :__CFTimeZone))
    (years :SInt32)
    (months :SInt32)
    (days :SInt32)
    (hours :SInt32)
    (minutes :SInt32)
    (seconds :double-float)
   )
   :double-float
() )

(deftrap-inline "_CFAbsoluteTimeGetDifferenceAsGregorianUnits" 
   ((returnArg (:pointer :CFGREGORIANUNITS))
    (at1 :double-float)
    (at2 :double-float)
    (tz (:pointer :__CFTimeZone))
    (unitFlags :UInt32)
   )
   nil
() )

(deftrap-inline "_CFAbsoluteTimeGetDayOfWeek" 
   ((at :double-float)
    (tz (:pointer :__CFTimeZone))
   )
   :SInt32
() )

(deftrap-inline "_CFAbsoluteTimeGetDayOfYear" 
   ((at :double-float)
    (tz (:pointer :__CFTimeZone))
   )
   :SInt32
() )

(deftrap-inline "_CFAbsoluteTimeGetWeekOfYear" 
   ((at :double-float)
    (tz (:pointer :__CFTimeZone))
   )
   :SInt32
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFDATE__ */


(provide-interface "CFDate")