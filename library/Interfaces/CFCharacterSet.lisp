(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFCharacterSet.h"
; at Sunday July 2,2006 7:22:47 pm.
; 	CFCharacterSet.h
; 	Copyright (c) 1999-2003, Apple, Inc. All rights reserved.
; 
; !
; 	@header CFCharacterSet
;         CFCharacterSet represents a set, or a bag, of Unicode characters.
;         The API consists of 3 groups:
;         1) creation/manipulation of CFCharacterSet instances,
;         2) query of a single Unicode character membership,
;         and 3) bitmap representation related (reading/writing).
;         Conceptually, CFCharacterSet is a 136K byte bitmap array of
;         which each bit represents a Unicode code point.  It could
;         contain the Unicode characters in ISO 10646 Basic Multilingual
;         Plane (BMP) and characters in Plane 1 through Plane 16
;         accessible via surrogate paris in the Unicode Transformation
;         Format, 16-bit encoding form (UTF-16).  In other words, it can
;         store values from 0x00000 to 0x10FFFF in the Unicode
;         Transformation Format, 32-bit encoding form (UTF-32).  However,
;         in general, how CFCharacterSet stores the information is an
;         implementation detail.  Note even CFData used for the external
;         bitmap representation rarely has 136K byte.  For detailed
;         discussion of the external bitmap representation, refer to the
;         comments for CFCharacterSetCreateWithBitmapRepresentation below.
;         Note that the existance of non-BMP characters in a character set
;         does not imply the membership of the corresponding surrogate
;         characters.  For example, a character set with U+10000 does not
;         match with U+D800.
; 

; #if !defined(__COREFOUNDATION_CFCHARACTERSET__)
(defconstant $__COREFOUNDATION_CFCHARACTERSET__ 1)
; #define __COREFOUNDATION_CFCHARACTERSET__ 1

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFData")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
; !
; 	@typedef CFCharacterSetRef
; 	This is the type of a reference to immutable CFCharacterSets.
; 

(def-mactype :CFCharacterSetRef (find-mactype '(:pointer :__CFCharacterSet)))
; !
; 	@typedef CFMutableCharacterSetRef
; 	This is the type of a reference to mutable CFMutableCharacterSets.
; 

(def-mactype :CFMutableCharacterSetRef (find-mactype '(:pointer :__CFCharacterSet)))
; !
; 	@typedef CFCharacterSetPredefinedSet
;         Type of the predefined CFCharacterSet selector values.
; 

(defconstant $kCFCharacterSetControl 1)         ;  Control character set (Unicode General Category Cc and Cf) 

(defconstant $kCFCharacterSetWhitespace 2)      ;  Whitespace character set (Unicode General Category Zs and U0009 CHARACTER TABULATION) 

(defconstant $kCFCharacterSetWhitespaceAndNewline 3);  Whitespace and Newline character set (Unicode General Category Z*, U000A ~ U000D, and U0085) 

(defconstant $kCFCharacterSetDecimalDigit 4)    ;  Decimal digit character set 

(defconstant $kCFCharacterSetLetter 5)          ;  Letter character set (Unicode General Category L* & M*) 

(defconstant $kCFCharacterSetLowercaseLetter 6) ;  Lowercase character set (Unicode General Category Ll) 

(defconstant $kCFCharacterSetUppercaseLetter 7) ;  Uppercase character set (Unicode General Category Lu and Lt) 

(defconstant $kCFCharacterSetNonBase 8)         ;  Non-base character set (Unicode General Category M*) 

(defconstant $kCFCharacterSetDecomposable 9)    ;  Canonically decomposable character set 

(defconstant $kCFCharacterSetAlphaNumeric 10)   ;  Alpha Numeric character set (Unicode General Category L*, M*, & N*) 

(defconstant $kCFCharacterSetPunctuation 11)    ;  Punctuation character set (Unicode General Category P*) 
;  Illegal character set 

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED

(defconstant $kCFCharacterSetIllegal 12)        ;  Titlecase character set (Unicode General Category Lt) 

; #endif


; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

(defconstant $kCFCharacterSetCapitalizedLetter 13);  Symbol character set (Unicode General Category S*) 

; #endif


(defconstant $kCFCharacterSetSymbol 14)
(def-mactype :CFCharacterSetPredefinedSet (find-mactype ':SINT32))
; !
; 	@function CFCharacterSetGetTypeID
; 	Returns the type identifier of all CFCharacterSet instances.
; 

(deftrap-inline "_CFCharacterSetGetTypeID" 
   (
   )
   :UInt32
() )
; !
; 	@function CFCharacterSetGetPredefined
; 	Returns a predefined CFCharacterSet instance.
; 	@param theSetIdentifier The CFCharacterSetPredefinedSet selector
;                 which specifies the predefined character set.  If the
;                 value is not in CFCharacterSetPredefinedSet, the behavior
;                 is undefined.
; 	@result A reference to the predefined immutable CFCharacterSet.
;                 This instance is owned by CF.
; 

(deftrap-inline "_CFCharacterSetGetPredefined" 
   ((theSetIdentifier :SInt32)
   )
   (:pointer :__CFCharacterSet)
() )
; !
; 	@function CFCharacterSetCreateWithCharactersInRange
; 	Creates a new immutable character set with the values from the given range.
; 	@param alloc The CFAllocator which should be used to allocate
; 		memory for the array and its storage for values. This
; 		parameter may be NULL in which case the current default
; 		CFAllocator is used. If this reference is not a valid
; 		CFAllocator, the behavior is undefined.
; 	@param theRange The CFRange which should be used to specify the
;                 Unicode range the character set is filled with.  It
;                 accepts the range in 32-bit in the UTF-32 format.  The
;                 valid character point range is from 0x00000 to 0x10FFFF.
;                 If the range is outside of the valid Unicode character
;                 point, the behavior is undefined.
; 	@result A reference to the new immutable CFCharacterSet.
; 

(deftrap-inline "_CFCharacterSetCreateWithCharactersInRange" 
   ((alloc (:pointer :__CFAllocator))
    (location :SInt32)
    (length :SInt32)
   )
   (:pointer :__CFCharacterSet)
() )
; !
; 	@function CFCharacterSetCreateWithCharactersInString
; 	Creates a new immutable character set with the values in the given string.
; 	@param alloc The CFAllocator which should be used to allocate
; 		memory for the array and its storage for values. This
; 		parameter may be NULL in which case the current default
; 		CFAllocator is used. If this reference is not a valid
; 		CFAllocator, the behavior is undefined.
; 	@param theString The CFString which should be used to specify
;                 the Unicode characters the character set is filled with.
;                 If this parameter is not a valid CFString, the behavior
;                 is undefined.
;         @result A reference to the new immutable CFCharacterSet.
; 

(deftrap-inline "_CFCharacterSetCreateWithCharactersInString" 
   ((alloc (:pointer :__CFAllocator))
    (theString (:pointer :__CFString))
   )
   (:pointer :__CFCharacterSet)
() )
; !
; 	@function CFCharacterSetCreateWithBitmapRepresentation
; 	Creates a new immutable character set with the bitmap representtion in the given data.
; 	@param alloc The CFAllocator which should be used to allocate
; 		memory for the array and its storage for values. This
; 		parameter may be NULL in which case the current default
; 		CFAllocator is used. If this reference is not a valid
; 		CFAllocator, the behavior is undefined.
; 	@param theData The CFData which should be used to specify the
;                 bitmap representation of the Unicode character points
;                 the character set is filled with.  The bitmap
;                 representation could contain all the Unicode character
;                 range starting from BMP to Plane 16.  The first 8K bytes
;                 of the data represents the BMP range.  The BMP range 8K
;                 bytes can be followed by zero to sixteen 8K byte
;                 bitmaps, each one with the plane index byte prepended.
;                 For example, the bitmap representing the BMP and Plane 2
;                 has the size of 16385 bytes (8K bytes for BMP, 1 byte
;                 index + 8K bytes bitmap for Plane 2).  The plane index
;                 byte, in this case, contains the integer value two.  If
;                 this parameter is not a valid CFData or it contains a
;                 Plane index byte outside of the valid Plane range
;                 (1 to 16), the behavior is undefined.
;         @result A reference to the new immutable CFCharacterSet.
; 

(deftrap-inline "_CFCharacterSetCreateWithBitmapRepresentation" 
   ((alloc (:pointer :__CFAllocator))
    (theData (:pointer :__CFData))
   )
   (:pointer :__CFCharacterSet)
() )

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
; !
; 	@function CFCharacterSetCreateInvertedSet
; 	Creates a new immutable character set that is the invert of the specified character set.
; 	@param alloc The CFAllocator which should be used to allocate
; 			memory for the array and its storage for values. This
; 			parameter may be NULL in which case the current default
; 			CFAllocator is used. If this reference is not a valid
; 			CFAllocator, the behavior is undefined.
; 	@param theSet The CFCharacterSet which is to be inverted.  If this
;                 		parameter is not a valid CFCharacterSet, the behavior is
;               		undefined.
; 	@result A reference to the new immutable CFCharacterSet.
; 

(deftrap-inline "_CFCharacterSetCreateInvertedSet" 
   ((alloc (:pointer :__CFAllocator))
    (theSet (:pointer :__CFCharacterSet))
   )
   (:pointer :__CFCharacterSet)
() )
; !
; 	@function CFCharacterSetIsSupersetOfSet
; 	Reports whether or not the character set is a superset of the character set specified as the second parameter.
; 	@param theSet  The character set to be checked for the membership of theOtherSet.
; 		If this parameter is not a valid CFCharacterSet, the behavior is undefined.
; 	@param theOtherset  The character set to be checked whether or not it is a subset of theSet.
; 		If this parameter is not a valid CFCharacterSet, the behavior is undefined.
; 

(deftrap-inline "_CFCharacterSetIsSupersetOfSet" 
   ((theSet (:pointer :__CFCharacterSet))
    (theOtherset (:pointer :__CFCharacterSet))
   )
   :Boolean
() )
; !
; 	@function CFCharacterSetHasMemberInPlane
; 	Reports whether or not the character set contains at least one member character in the specified plane.
; 	@param theSet  The character set to be checked for the membership.  If this
; 		parameter is not a valid CFCharacterSet, the behavior is undefined.
; 	@param thePlane  The plane number to be checked for the membership.
; 		The valid value range is from 0 to 16.  If the value is outside of the valid
; 		plane number range, the behavior is undefined.
; 

(deftrap-inline "_CFCharacterSetHasMemberInPlane" 
   ((theSet (:pointer :__CFCharacterSet))
    (thePlane :SInt32)
   )
   :Boolean
() )

; #endif

; !
; 	@function CFCharacterSetCreateMutable
; 	Creates a new empty mutable character set.
; 	@param allocator The CFAllocator which should be used to allocate
; 		memory for the array and its storage for values. This
; 		parameter may be NULL in which case the current default
; 		CFAllocator is used. If this reference is not a valid
; 		CFAllocator, the behavior is undefined.
; 	@result A reference to the new mutable CFCharacterSet.
; 

(deftrap-inline "_CFCharacterSetCreateMutable" 
   ((alloc (:pointer :__CFAllocator))
   )
   (:pointer :__CFCharacterSet)
() )

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
; !
; 	@function CFCharacterSetCreateCopy
; 	Creates a new character set with the values from the given character set.  This function tries to compact the backing store where applicable.
; 	@param allocator The CFAllocator which should be used to allocate
; 		memory for the array and its storage for values. This
; 		parameter may be NULL in which case the current default
; 		CFAllocator is used. If this reference is not a valid
; 		CFAllocator, the behavior is undefined.
; 	@param theSet The CFCharacterSet which is to be copied.  If this
;                 parameter is not a valid CFCharacterSet, the behavior is
;                 undefined.
; 	@result A reference to the new CFCharacterSet.
; 

(deftrap-inline "_CFCharacterSetCreateCopy" 
   ((alloc (:pointer :__CFAllocator))
    (theSet (:pointer :__CFCharacterSet))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   (:pointer :__CFCharacterSet)
() )

; #endif /* MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED */

; !
; 	@function CFCharacterSetCreateMutableCopy
; 	Creates a new mutable character set with the values from the given character set.
; 	@param allocator The CFAllocator which should be used to allocate
; 		memory for the array and its storage for values. This
; 		parameter may be NULL in which case the current default
; 		CFAllocator is used. If this reference is not a valid
; 		CFAllocator, the behavior is undefined.
; 	@param theSet The CFCharacterSet which is to be copied.  If this
;                 parameter is not a valid CFCharacterSet, the behavior is
;                 undefined.
; 	@result A reference to the new mutable CFCharacterSet.
; 

(deftrap-inline "_CFCharacterSetCreateMutableCopy" 
   ((alloc (:pointer :__CFAllocator))
    (theSet (:pointer :__CFCharacterSet))
   )
   (:pointer :__CFCharacterSet)
() )
; !
; 	@function CFCharacterSetIsCharacterMember
; 	Reports whether or not the Unicode character is in the character set.
; 	@param theSet The character set to be searched. If this parameter
;                 is not a valid CFCharacterSet, the behavior is undefined.
; 	@param theChar The Unicode character for which to test against the
;                 character set.  Note that this function takes 16-bit Unicode
;                 character value; hence, it does not support access to the
;                 non-BMP planes.  
;         @result true, if the value is in the character set, otherwise false.
; 

(deftrap-inline "_CFCharacterSetIsCharacterMember" 
   ((theSet (:pointer :__CFCharacterSet))
    (theChar :UInt16)
   )
   :Boolean
() )

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
; !
; 	@function CFCharacterSetIsLongCharacterMember
; 	Reports whether or not the UTF-32 character is in the character set.
; 	@param theSet The character set to be searched. If this parameter
;                		 is not a valid CFCharacterSet, the behavior is undefined.
; 	@param theChar The UTF-32 character for which to test against the
; 			character set.
;         @result true, if the value is in the character set, otherwise false.
; 

(deftrap-inline "_CFCharacterSetIsLongCharacterMember" 
   ((theSet (:pointer :__CFCharacterSet))
    (theChar :UInt32)
   )
   :Boolean
() )

; #endif

; !
; 	@function CFCharacterSetCreateBitmapRepresentation
; 	Creates a new immutable data with the bitmap representation from the given character set.
; 	@param allocator The CFAllocator which should be used to allocate
; 		memory for the array and its storage for values. This
; 		parameter may be NULL in which case the current default
; 		CFAllocator is used. If this reference is not a valid
; 		CFAllocator, the behavior is undefined.
; 	@param theSet The CFCharacterSet which is to be used create the
;                 bitmap representation from.  Refer to the comments for
;                 CFCharacterSetCreateWithBitmapRepresentation for the
;                 detailed discussion of the bitmap representation format.
;                 If this parameter is not a valid CFCharacterSet, the
;                 behavior is undefined.
; 	@result A reference to the new immutable CFData.
; 

(deftrap-inline "_CFCharacterSetCreateBitmapRepresentation" 
   ((alloc (:pointer :__CFAllocator))
    (theSet (:pointer :__CFCharacterSet))
   )
   (:pointer :__CFData)
() )
; !
; 	@function CFCharacterSetAddCharactersInRange
; 	Adds the given range to the charaacter set.
; 	@param theSet The character set to which the range is to be added.
;                 If this parameter is not a valid mutable CFCharacterSet,
;                 the behavior is undefined.
;         @param theRange The range to add to the character set.  It accepts
;                 the range in 32-bit in the UTF-32 format.  The valid
;                 character point range is from 0x00000 to 0x10FFFF.  If the
;                 range is outside of the valid Unicode character point,
;                 the behavior is undefined.
; 

(deftrap-inline "_CFCharacterSetAddCharactersInRange" 
   ((theSet (:pointer :__CFCharacterSet))
    (location :SInt32)
    (length :SInt32)
   )
   nil
() )
; !
; 	@function CFCharacterSetRemoveCharactersInRange
; 	Removes the given range from the charaacter set.
; 	@param theSet The character set from which the range is to be
;                 removed.  If this parameter is not a valid mutable
;                 CFCharacterSet, the behavior is undefined.
;         @param theRange The range to remove from the character set.
;                 It accepts the range in 32-bit in the UTF-32 format.
;                 The valid character point range is from 0x00000 to 0x10FFFF.
;                 If the range is outside of the valid Unicode character point,
;                 the behavior is undefined.
; 

(deftrap-inline "_CFCharacterSetRemoveCharactersInRange" 
   ((theSet (:pointer :__CFCharacterSet))
    (location :SInt32)
    (length :SInt32)
   )
   nil
() )
; !
; 	@function CFCharacterSetAddCharactersInString
; 	Adds the characters in the given string to the charaacter set.
; 	@param theSet The character set to which the characters in the
;                 string are to be added.  If this parameter is not a
;                 valid mutable CFCharacterSet, the behavior is undefined.
;         @param theString The string to add to the character set.
;                 If this parameter is not a valid CFString, the behavior
;                 is undefined.
; 

(deftrap-inline "_CFCharacterSetAddCharactersInString" 
   ((theSet (:pointer :__CFCharacterSet))
    (theString (:pointer :__CFString))
   )
   nil
() )
; !
; 	@function CFCharacterSetRemoveCharactersInString
; 	Removes the characters in the given string from the charaacter set.
; 	@param theSet The character set from which the characters in the
;                 string are to be remove.  If this parameter is not a
;                 valid mutable CFCharacterSet, the behavior is undefined.
;         @param theString The string to remove from the character set.
;                 If this parameter is not a valid CFString, the behavior
;                 is undefined.
; 

(deftrap-inline "_CFCharacterSetRemoveCharactersInString" 
   ((theSet (:pointer :__CFCharacterSet))
    (theString (:pointer :__CFString))
   )
   nil
() )
; !
; 	@function CFCharacterSetUnion
; 	Forms the union with the given character set.
; 	@param theSet The destination character set into which the
;                 union of the two character sets is stored.  If this
;                 parameter is not a valid mutable CFCharacterSet, the
;                 behavior is undefined.
; 	@param theOtherSet The character set with which the union is
;                 formed.  If this parameter is not a valid CFCharacterSet,
;                 the behavior is undefined.
; 

(deftrap-inline "_CFCharacterSetUnion" 
   ((theSet (:pointer :__CFCharacterSet))
    (theOtherSet (:pointer :__CFCharacterSet))
   )
   nil
() )
; !
; 	@function CFCharacterSetIntersect
; 	Forms the intersection with the given character set.
; 	@param theSet The destination character set into which the
;                 intersection of the two character sets is stored.
;                 If this parameter is not a valid mutable CFCharacterSet,
;                 the behavior is undefined.
; 	@param theOtherSet The character set with which the intersection
;                 is formed.  If this parameter is not a valid CFCharacterSet,
;                 the behavior is undefined.
; 

(deftrap-inline "_CFCharacterSetIntersect" 
   ((theSet (:pointer :__CFCharacterSet))
    (theOtherSet (:pointer :__CFCharacterSet))
   )
   nil
() )
; !
; 	@function CFCharacterSetInvert
; 	Inverts the content of the given character set.
; 	@param theSet The character set to be inverted.
;                 If this parameter is not a valid mutable CFCharacterSet,
;                 the behavior is undefined.
; 

(deftrap-inline "_CFCharacterSetInvert" 
   ((theSet (:pointer :__CFCharacterSet))
   )
   nil
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* !__COREFOUNDATION_CFCHARACTERSET__ */


(provide-interface "CFCharacterSet")