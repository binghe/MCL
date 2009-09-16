(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFNumber.h"
; at Sunday July 2,2006 7:22:48 pm.
; 	CFNumber.h
; 	Copyright (c) 1999-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFNUMBER__)
(defconstant $__COREFOUNDATION_CFNUMBER__ 1)
; #define __COREFOUNDATION_CFNUMBER__ 1

(require-interface "CoreFoundation/CFBase")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(def-mactype :CFBooleanRef (find-mactype '(:pointer :__CFBoolean)))
(def-mactype :kCFBooleanTrue (find-mactype ':CFBooleanRef))
(def-mactype :kCFBooleanFalse (find-mactype ':CFBooleanRef))

(deftrap-inline "_CFBooleanGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFBooleanGetValue" 
   ((boolean (:pointer :__CFBoolean))
   )
   :Boolean
() )
;  Types from MacTypes.h 

(defconstant $kCFNumberSInt8Type 1)
(defconstant $kCFNumberSInt16Type 2)
(defconstant $kCFNumberSInt32Type 3)
(defconstant $kCFNumberSInt64Type 4)
(defconstant $kCFNumberFloat32Type 5)
(defconstant $kCFNumberFloat64Type 6)           ;  64-bit IEEE 754 
;  Basic C types 

(defconstant $kCFNumberCharType 7)
(defconstant $kCFNumberShortType 8)
(defconstant $kCFNumberIntType 9)
(defconstant $kCFNumberLongType 10)
(defconstant $kCFNumberLongLongType 11)
(defconstant $kCFNumberFloatType 12)
(defconstant $kCFNumberDoubleType 13)           ;  Other 

(defconstant $kCFNumberCFIndexType 14)
(defconstant $kCFNumberMaxType 14)
(def-mactype :CFNumberType (find-mactype ':SINT32))

(def-mactype :CFNumberRef (find-mactype '(:pointer :__CFNumber)))
(def-mactype :kCFNumberPositiveInfinity (find-mactype ':CFNumberRef))
(def-mactype :kCFNumberNegativeInfinity (find-mactype ':CFNumberRef))
(def-mactype :kCFNumberNaN (find-mactype ':CFNumberRef))

(deftrap-inline "_CFNumberGetTypeID" 
   (
   )
   :UInt32
() )
; 
; 	Creates a CFNumber with the given value. The type of number pointed
; 	to by the valuePtr is specified by type. If type is a floating point
; 	type and the value represents one of the infinities or NaN, the
; 	well-defined CFNumber for that value is returned. If either of
; 	valuePtr or type is an invalid value, the result is undefined.
; 

(deftrap-inline "_CFNumberCreate" 
   ((allocator (:pointer :__CFAllocator))
    (theType :SInt32)
    (valuePtr :pointer)
   )
   (:pointer :__CFNumber)
() )
; 
; 	Returns the storage format of the CFNumber's value.  Note that
; 	this is not necessarily the type provided in CFNumberCreate().
; 

(deftrap-inline "_CFNumberGetType" 
   ((number (:pointer :__CFNumber))
   )
   :SInt32
() )
; 
; 	Returns the size in bytes of the type of the number.
; 

(deftrap-inline "_CFNumberGetByteSize" 
   ((number (:pointer :__CFNumber))
   )
   :SInt32
() )
; 
; 	Returns true if the type of the CFNumber's value is one of
; 	the defined floating point types.
; 

(deftrap-inline "_CFNumberIsFloatType" 
   ((number (:pointer :__CFNumber))
   )
   :Boolean
() )
; 
; 	Copies the CFNumber's value into the space pointed to by
; 	valuePtr, as the specified type. If conversion needs to take
; 	place, the conversion rules follow human expectation and not
; 	C's promotion and truncation rules. If the conversion is
; 	lossy, or the value is out of range, false is returned. Best
; 	attempt at conversion will still be in *valuePtr.
; 

(deftrap-inline "_CFNumberGetValue" 
   ((number (:pointer :__CFNumber))
    (theType :SInt32)
    (valuePtr :pointer)
   )
   :Boolean
() )
; 
; 	Compares the two CFNumber instances. If conversion of the
; 	types of the values is needed, the conversion and comparison
; 	follow human expectations and not C's promotion and comparison
; 	rules. Negative zero compares less than positive zero.
; 	Positive infinity compares greater than everything except
; 	itself, to which it compares equal. Negative infinity compares
; 	less than everything except itself, to which it compares equal.
; 	Unlike standard practice, if both numbers are NaN, then they
; 	compare equal; if only one of the numbers is NaN, then the NaN
; 	compares greater than the other number if it is negative, and
; 	smaller than the other number if it is positive. (Note that in
; 	CFEqual() with two CFNumbers, if either or both of the numbers
; 	is NaN, true is returned.)
; 

(deftrap-inline "_CFNumberCompare" 
   ((number (:pointer :__CFNumber))
    (otherNumber (:pointer :__CFNumber))
    (context :pointer)
   )
   :SInt32
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFNUMBER__ */


(provide-interface "CFNumber")