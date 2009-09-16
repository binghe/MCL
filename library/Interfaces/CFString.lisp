(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFString.h"
; at Sunday July 2,2006 7:22:49 pm.
; 	CFString.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFSTRING__)
(defconstant $__COREFOUNDATION_CFSTRING__ 1)
; #define __COREFOUNDATION_CFSTRING__ 1

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFArray")

(require-interface "CoreFoundation/CFData")

(require-interface "CoreFoundation/CFDictionary")

(require-interface "CoreFoundation/CFCharacterSet")

(require-interface "CoreFoundation/CFLocale")

(require-interface "stdarg")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
; 
; Please note: CFStrings are conceptually an array of Unicode characters.
; However, in general, how a CFString stores this array is an implementation
; detail. For instance, CFString might choose to use an array of 8-bit characters;
; to store its contents; or it might use multiple blocks of memory; or whatever.
; Furthermore, the implementation might change depending on the default
; system encoding, the user's language, the OS, or even a given release.
; 
; What this means is that you should use the following advanced functions with care:
; 
;   CFStringGetPascalStringPtr()
;   CFStringGetCStringPtr()
;   CFStringGetCharactersPtr()
; 
; These functions are provided for optimization only. They will either return the desired
; pointer quickly, in constant time, or they return NULL. They might choose to return NULL
; for many reasons; for instance it's possible that for users running in different
; languages these sometimes return NULL; or in a future OS release the first two might
; switch to always returning NULL. Never observing NULL returns in your usages of these
; functions does not mean they won't ever return NULL. (But note the CFStringGetCharactersPtr()
; exception mentioned further below.)
; 
; In your usages of these functions, if you get a NULL return, use the non-Ptr version
; of the functions as shown in this example:
; 
;   Str255 buffer;
;   StringPtr ptr = CFStringGetPascalStringPtr(str, encoding);
;   if (ptr == NULL) {
;       if (CFStringGetPascalString(str, buffer, 256, encoding)) ptr = buffer;
;   }
; 
; Note that CFStringGetPascalString() or CFStringGetCString() calls might still fail --- but
; that will happen in two circumstances only: The conversion from the UniChar contents of CFString
; to the specified encoding fails, or the buffer is too small. If they fail, that means
; the conversion was not possible.
; 
; If you need a copy of the buffer in the above example, you might consider simply
; calling CFStringGetPascalString() in all cases --- CFStringGetPascalStringPtr()
; is simply an optimization.
; 
; In addition, the following functions, which create immutable CFStrings from developer
; supplied buffers without copying the buffers, might have to actually copy
; under certain circumstances (If they do copy, the buffer will be dealt with by the
; "contentsDeallocator" argument.):
; 
;   CFStringCreateWithPascalStringNoCopy()
;   CFStringCreateWithCStringNoCopy()
;   CFStringCreateWithCharactersNoCopy()
; 
; You should of course never depend on the backing store of these CFStrings being
; what you provided, and in other no circumstance should you change the contents
; of that buffer (given that would break the invariant about the CFString being immutable).
; 
; Having said all this, there are actually ways to create a CFString where the backing store
; is external, and can be manipulated by the developer or CFString itself:
; 
;   CFStringCreateMutableWithExternalCharactersNoCopy()
;   CFStringSetExternalCharactersNoCopy()
; 
; A "contentsAllocator" is used to realloc or free the backing store by CFString.
; kCFAllocatorNull can be provided to assure CFString will never realloc or free the buffer.
; Developer can call CFStringSetExternalCharactersNoCopy() to update
; CFString's idea of what's going on, if the buffer is changed externally. In these
; strings, CFStringGetCharactersPtr() is guaranteed to return the external buffer.
; 
; These functions are here to allow wrapping a buffer of UniChar characters in a CFString,
; allowing the buffer to passed into CFString functions and also manipulated via CFString
; mutation functions. In general, developers should not use this technique for all strings,
; as it prevents CFString from using certain optimizations.
; 
;  Identifier for character encoding; the values are the same as Text Encoding Converter TextEncoding.
; 

(def-mactype :CFStringEncoding (find-mactype ':UInt32))
;  Platform-independent built-in encodings; always available on all platforms.
;    Call CFStringGetSystemEncoding() to get the default system encoding.
; 
(defconstant $kCFStringEncodingInvalidId 4294967295)
; #define kCFStringEncodingInvalidId (0xffffffffU)

(defconstant $kCFStringEncodingMacRoman 0)
(defconstant $kCFStringEncodingWindowsLatin1 #x500);  ANSI codepage 1252 

(defconstant $kCFStringEncodingISOLatin1 #x201) ;  ISO 8859-1 

(defconstant $kCFStringEncodingNextStepLatin #xB01);  NextStep encoding

(defconstant $kCFStringEncodingASCII #x600)     ;  0..127 (in creating CFString, values greater than 0x7F are treated as corresponding Unicode value) 

(defconstant $kCFStringEncodingUnicode #x100)   ;  kTextEncodingUnicodeDefault  + kTextEncodingDefaultFormat (aka kUnicode16BitFormat) 

(defconstant $kCFStringEncodingUTF8 #x8000100)  ;  kTextEncodingUnicodeDefault + kUnicodeUTF8Format 

(defconstant $kCFStringEncodingNonLossyASCII #xBFF);  7bit Unicode variants used by Cocoa & Java 

(def-mactype :CFStringBuiltInEncodings (find-mactype ':SINT32))
;  CFString type ID 

(deftrap-inline "_CFStringGetTypeID" 
   (
   )
   :UInt32
() )
;  Macro to allow creation of compile-time constant strings; the argument should be a constant string.
; 
; CFSTR(), not being a "Copy" or "Create" function, does not return a new
; reference for you. So, you should not release the return value. This is
; much like constant C or Pascal strings --- when you use "hello world"
; in a program, you do not free it.
; 
; However, strings returned from CFSTR() can be retained and released in a
; properly nested fashion, just like any other CF type. That is, if you pass
; a CFSTR() return value to a function such as SetMenuItemWithCFString(), the
; function can retain it, then later, when it's done with it, it can release it.
; 
; At this point non-7 bit characters (that is, characters > 127) in CFSTR() are not 
; supported and using them will lead to unpredictable results. This includes escaped
; (\nnn) characters whose values are > 127. Even if it works for you in testing, 
; it might not work for a user with a different language preference.
; 
; #ifdef __CONSTANT_CFSTRINGS__
#| #|
#define CFSTR(cStr)  ((CFStringRef) __builtin___CFStringMakeConstantString ("" cStr ""))
|#
 |#

; #else
; #define CFSTR(cStr)  __CFStringMakeConstantString("" cStr "")

; #endif

; ** Immutable string creation functions **
;  Functions to create basic immutable strings. The provided allocator is used for all memory activity in these functions.
; 
;  These functions copy the provided buffer into CFString's internal storage. 

(deftrap-inline "_CFStringCreateWithPascalString" 
   ((alloc (:pointer :__CFAllocator))
    (pStr (:pointer :STR255))
    (encoding :UInt32)
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFStringCreateWithCString" 
   ((alloc (:pointer :__CFAllocator))
    (cStr (:pointer :char))
    (encoding :UInt32)
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFStringCreateWithCharacters" 
   ((alloc (:pointer :__CFAllocator))
    (chars (:pointer :UniChar))
    (numChars :SInt32)
   )
   (:pointer :__CFString)
() )
;  These functions try not to copy the provided buffer. The buffer will be deallocated 
; with the provided contentsDeallocator when it's no longer needed; to not free
; the buffer, specify kCFAllocatorNull here. As usual, NULL means default allocator.
; 
; NOTE: Do not count on these buffers as being used by the string; 
; in some cases the CFString might free the buffer and use something else
; (for instance if it decides to always use Unicode encoding internally). 
; 
; NOTE: If you are not transferring ownership of the buffer to the CFString
; (for instance, you supplied contentsDeallocator = kCFAllocatorNull), it is your
; responsibility to assure the buffer does not go away during the lifetime of the string.
; If the string is retained or copied, its lifetime might extend in ways you cannot
; predict. So, for strings created with buffers whose lifetimes you cannot
; guarantee, you need to be extremely careful --- do not hand it out to any
; APIs which might retain or copy the strings.
; 

(deftrap-inline "_CFStringCreateWithPascalStringNoCopy" 
   ((alloc (:pointer :__CFAllocator))
    (pStr (:pointer :STR255))
    (encoding :UInt32)
    (contentsDeallocator (:pointer :__CFAllocator))
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFStringCreateWithCStringNoCopy" 
   ((alloc (:pointer :__CFAllocator))
    (cStr (:pointer :char))
    (encoding :UInt32)
    (contentsDeallocator (:pointer :__CFAllocator))
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFStringCreateWithCharactersNoCopy" 
   ((alloc (:pointer :__CFAllocator))
    (chars (:pointer :UniChar))
    (numChars :SInt32)
    (contentsDeallocator (:pointer :__CFAllocator))
   )
   (:pointer :__CFString)
() )
;  Create copies of part or all of the string.
; 

(deftrap-inline "_CFStringCreateWithSubstring" 
   ((alloc (:pointer :__CFAllocator))
    (str (:pointer :__CFString))
    (location :SInt32)
    (length :SInt32)
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFStringCreateCopy" 
   ((alloc (:pointer :__CFAllocator))
    (theString (:pointer :__CFString))
   )
   (:pointer :__CFString)
() )
;  These functions create a CFString from the provided printf-like format string and arguments.
; 

(deftrap-inline "_CFStringCreateWithFormat" 
   ((alloc (:pointer :__CFAllocator))
    (formatOptions (:pointer :__CFDictionary))
    (format (:pointer :__CFString))
#| |...|  ;; What should this do?
    |#
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFStringCreateWithFormatAndArguments" 
   ((alloc (:pointer :__CFAllocator))
    (formatOptions (:pointer :__CFDictionary))
    (format (:pointer :__CFString))
    (arguments (:pointer :void))
   )
   (:pointer :__CFString)
() )
;  Functions to create mutable strings. "maxLength", if not 0, is a hard bound on the length of the string. If 0, there is no limit on the length.
; 

(deftrap-inline "_CFStringCreateMutable" 
   ((alloc (:pointer :__CFAllocator))
    (maxLength :SInt32)
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFStringCreateMutableCopy" 
   ((alloc (:pointer :__CFAllocator))
    (maxLength :SInt32)
    (theString (:pointer :__CFString))
   )
   (:pointer :__CFString)
() )
;  This function creates a mutable string that has a developer supplied and directly editable backing store.
; The string will be manipulated within the provided buffer (if any) until it outgrows capacity; then the
; externalCharactersAllocator will be consulted for more memory. When the CFString is deallocated, the
; buffer will be freed with the externalCharactersAllocator. Provide kCFAllocatorNull here to prevent the buffer
; from ever being reallocated or deallocated by CFString. See comments at top of this file for more info.
; 

(deftrap-inline "_CFStringCreateMutableWithExternalCharactersNoCopy" 
   ((alloc (:pointer :__CFAllocator))
    (chars (:pointer :UniChar))
    (numChars :SInt32)
    (capacity :SInt32)
    (externalCharactersAllocator (:pointer :__CFAllocator))
   )
   (:pointer :__CFString)
() )
; ** Basic accessors for the contents **
;  Number of 16-bit Unicode characters in the string.
; 

(deftrap-inline "_CFStringGetLength" 
   ((theString (:pointer :__CFString))
   )
   :SInt32
() )
;  Extracting the contents of the string. For obtaining multiple characters, calling
; CFStringGetCharacters() is more efficient than multiple calls to CFStringGetCharacterAtIndex().
; If the length of the string is not known (so you can't use a fixed size buffer for CFStringGetCharacters()),
; another method is to use is CFStringGetCharacterFromInlineBuffer() (see further below).
; 

(deftrap-inline "_CFStringGetCharacterAtIndex" 
   ((theString (:pointer :__CFString))
    (idx :SInt32)
   )
   :UInt16
() )

(deftrap-inline "_CFStringGetCharacters" 
   ((theString (:pointer :__CFString))
    (location :SInt32)
    (length :SInt32)
    (buffer (:pointer :UniChar))
   )
   nil
() )
; ** Conversion to other encodings **
;  These two convert into the provided buffer; they return false if conversion isn't possible
; (due to conversion error, or not enough space in the provided buffer). 
; These functions do zero-terminate or put the length byte; the provided bufferSize should include
; space for this (so pass 256 for Str255). More sophisticated usages can go through CFStringGetBytes().
; These functions are equivalent to calling CFStringGetBytes() with 
; the range of the string; lossByte = 0; and isExternalRepresentation = false; 
; if successful, they then insert the leading length of terminating zero, as desired.
; 

(deftrap-inline "_CFStringGetPascalString" 
   ((theString (:pointer :__CFString))
    (buffer (:pointer :UInt8))
    (bufferSize :SInt32)
    (encoding :UInt32)
   )
   :Boolean
() )

(deftrap-inline "_CFStringGetCString" 
   ((theString (:pointer :__CFString))
    (buffer (:pointer :char))
    (bufferSize :SInt32)
    (encoding :UInt32)
   )
   :Boolean
() )
;  These functions attempt to return in O(1) time the desired format for the string.
; Note that although this means a pointer to the internal structure is being returned,
; this can't always be counted on. Please see note at the top of the file for more
; details.
; 

(deftrap-inline "_CFStringGetPascalStringPtr" 
   ((theString (:pointer :__CFString))
    (encoding :UInt32)
   )
   (:pointer :UInt8)
() )
;  May return NULL at any time; be prepared for NULL 

(deftrap-inline "_CFStringGetCStringPtr" 
   ((theString (:pointer :__CFString))
    (encoding :UInt32)
   )
   (:pointer :character)
() )
;  May return NULL at any time; be prepared for NULL 

(deftrap-inline "_CFStringGetCharactersPtr" 
   ((theString (:pointer :__CFString))
   )
   (:pointer :UInt16)
() )
;  May return NULL at any time; be prepared for NULL 
;  The primitive conversion routine; allows you to convert a string piece at a time
;    into a fixed size buffer. Returns number of characters converted. 
;    Characters that cannot be converted to the specified encoding are represented
;    with the byte specified by lossByte; if lossByte is 0, then lossy conversion
;    is not allowed and conversion stops, returning partial results.
;    Pass buffer==NULL if you don't care about the converted string (but just the convertability,
;    or number of bytes required). 
;    maxBufLength indicates the maximum number of bytes to generate. It is ignored when buffer==NULL.
;    Does not zero-terminate. If you want to create Pascal or C string, allow one extra byte at start or end. 
;    Setting isExternalRepresentation causes any extra bytes that would allow 
;    the data to be made persistent to be included; for instance, the Unicode BOM.
; 

(deftrap-inline "_CFStringGetBytes" 
   ((theString (:pointer :__CFString))
    (location :SInt32)
    (length :SInt32)
    (encoding :UInt32)
    (lossByte :UInt8)
    (isExternalRepresentation :Boolean)
    (buffer (:pointer :UInt8))
    (maxBufLen :SInt32)
    (usedBufLen (:pointer :CFINDEX))
   )
   :SInt32
() )
;  This one goes the other way by creating a CFString from a bag of bytes.
; This is much like CFStringCreateWithPascalString or CFStringCreateWithCString,
; except the length is supplied explicitly. In addition, you can specify whether
; the data is an external format --- that is, whether to pay attention to the
; BOM character (if any) and do byte swapping if necessary
; 

(deftrap-inline "_CFStringCreateWithBytes" 
   ((alloc (:pointer :__CFAllocator))
    (bytes (:pointer :UInt8))
    (numBytes :SInt32)
    (encoding :UInt32)
    (isExternalRepresentation :Boolean)
   )
   (:pointer :__CFString)
() )
;  Convenience functions String <-> Data. These generate "external" formats, that is, formats that
;    can be written out to disk. For instance, if the encoding is Unicode, CFStringCreateFromExternalRepresentation()
;    pays attention to the BOM character (if any) and does byte swapping if necessary.
;    Similarly CFStringCreateExternalRepresentation() will always include a BOM character if the encoding is
;    Unicode. See above for description of lossByte.
; 

(deftrap-inline "_CFStringCreateFromExternalRepresentation" 
   ((alloc (:pointer :__CFAllocator))
    (data (:pointer :__CFData))
    (encoding :UInt32)
   )
   (:pointer :__CFString)
() )
;  May return NULL on conversion error 

(deftrap-inline "_CFStringCreateExternalRepresentation" 
   ((alloc (:pointer :__CFAllocator))
    (theString (:pointer :__CFString))
    (encoding :UInt32)
    (lossByte :UInt8)
   )
   (:pointer :__CFData)
() )
;  May return NULL on conversion error 
;  Hints about the contents of a string
; 

(deftrap-inline "_CFStringGetSmallestEncoding" 
   ((theString (:pointer :__CFString))
   )
   :UInt32
() )
;  Result in O(n) time max 

(deftrap-inline "_CFStringGetFastestEncoding" 
   ((theString (:pointer :__CFString))
   )
   :UInt32
() )
;  Result in O(1) time max 
;  General encoding info
; 

(deftrap-inline "_CFStringGetSystemEncoding" 
   (
   )
   :UInt32
() )
;  The default encoding for the system; untagged 8-bit characters are usually in this encoding 

(deftrap-inline "_CFStringGetMaximumSizeForEncoding" 
   ((length :SInt32)
    (encoding :UInt32)
   )
   :SInt32
() )
;  Max bytes a string of specified length (in UniChars) will take up if encoded 
; ** Comparison functions. **
;  Find and compare flags; these are OR'ed together as compareOptions or searchOptions in the various functions. 
;    This typedef doesn't appear in the functions; instead the argument is CFOptionFlags. 
; 

(defconstant $kCFCompareCaseInsensitive 1)
(defconstant $kCFCompareBackwards 4)            ;  Starting from the end of the string 

(defconstant $kCFCompareAnchored 8)             ;  Only at the specified starting point 

(defconstant $kCFCompareNonliteral 16)          ;  If specified, loose equivalence is performed (o-umlaut == o, umlaut) 

(defconstant $kCFCompareLocalized 32)           ;  User's default locale is used for the comparisons 

(defconstant $kCFCompareNumerically 64)         ;  Numeric comparison is used; that is, Foo2.txt < Foo7.txt < Foo25.txt 

(def-mactype :CFStringCompareFlags (find-mactype ':SINT32))
;  The main comparison routine; compares specified range of the first string to (the full range of) the second string.
;    locale == NULL indicates canonical locale.
;    kCFCompareNumerically, added in 10.2, does not work if kCFCompareLocalized is specified on systems before 10.3
;    kCFCompareBackwards and kCFCompareAnchored are not applicable.
; 

(deftrap-inline "_CFStringCompareWithOptions" 
   ((theString1 (:pointer :__CFString))
    (theString2 (:pointer :__CFString))
    (location :SInt32)
    (length :SInt32)
    (compareOptions :UInt32)
   )
   :SInt32
() )
;  Comparison convenience suitable for passing as sorting functions.
;    kCFCompareNumerically, added in 10.2, does not work if kCFCompareLocalized is specified on systems before 10.3
;    kCFCompareBackwards and kCFCompareAnchored are not applicable.
; 

(deftrap-inline "_CFStringCompare" 
   ((theString1 (:pointer :__CFString))
    (theString2 (:pointer :__CFString))
    (compareOptions :UInt32)
   )
   :SInt32
() )
;  CFStringFindWithOptions() returns the found range in the CFRange * argument; you can pass NULL for simple discovery check.
;    If stringToFind is the empty string (zero length), nothing is found.
;    Ignores the kCFCompareNumerically option.
; 

(deftrap-inline "_CFStringFindWithOptions" 
   ((theString (:pointer :__CFString))
    (stringToFind (:pointer :__CFString))
    (location :SInt32)
    (length :SInt32)
    (searchOptions :UInt32)
    (result (:pointer :CFRANGE))
   )
   :Boolean
() )
;  CFStringCreateArrayWithFindResults() returns an array of CFRange pointers, or NULL if there are no matches.
;    Overlapping instances are not found; so looking for "AA" in "AAA" finds just one range.
;    Post 10.1: If kCFCompareBackwards is provided, the scan is done from the end (which can give a different result), and
;       the results are stored in the array backwards (last found range in slot 0).
;    If stringToFind is the empty string (zero length), nothing is found.
;    kCFCompareAnchored causes just the consecutive instances at start (or end, if kCFCompareBackwards) to be reported. So, searching for "AB" in "ABABXAB..." you just get the first two occurrences.
;    Ignores the kCFCompareNumerically option.
; 

(deftrap-inline "_CFStringCreateArrayWithFindResults" 
   ((alloc (:pointer :__CFAllocator))
    (theString (:pointer :__CFString))
    (stringToFind (:pointer :__CFString))
    (location :SInt32)
    (length :SInt32)
    (compareOptions :UInt32)
   )
   (:pointer :__CFArray)
() )
;  Find conveniences; see comments above concerning empty string and options.
; 

(deftrap-inline "_CFStringFind" 
   ((returnArg (:pointer :CFRANGE))
    (theString (:pointer :__CFString))
    (stringToFind (:pointer :__CFString))
    (compareOptions :UInt32)
   )
   nil
() )

(deftrap-inline "_CFStringHasPrefix" 
   ((theString (:pointer :__CFString))
    (prefix (:pointer :__CFString))
   )
   :Boolean
() )

(deftrap-inline "_CFStringHasSuffix" 
   ((theString (:pointer :__CFString))
    (suffix (:pointer :__CFString))
   )
   :Boolean
() )

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
; !
; 	@function CFStringGetRangeOfComposedCharactersAtIndex
; 	Returns the range of the composed character sequence at the specified index.
; 	@param theString The CFString which is to be searched.  If this
;                 		parameter is not a valid CFString, the behavior is
;               		undefined.
; 	@param theIndex The index of the character contained in the
; 			composed character sequence.  If the index is
; 			outside the index space of the string (0 to N-1 inclusive,
; 			where N is the length of the string), the behavior is
; 			undefined.
; 	@result The range of the composed character sequence.
; 

(deftrap-inline "_CFStringGetRangeOfComposedCharactersAtIndex" 
   ((returnArg (:pointer :CFRANGE))
    (theString (:pointer :__CFString))
    (theIndex :SInt32)
   )
   nil
() )
; !
; 	@function CFStringFindCharacterFromSet
; 	Query the range of the first character contained in the specified character set.
; 	@param theString The CFString which is to be searched.  If this
;                 		parameter is not a valid CFString, the behavior is
;               		undefined.
; 	@param theSet The CFCharacterSet against which the membership
; 			of characters is checked.  If this parameter is not a valid
; 			CFCharacterSet, the behavior is undefined.
; 	@param range The range of characters within the string to search. If
; 			the range location or end point (defined by the location
; 			plus length minus 1) are outside the index space of the
; 			string (0 to N-1 inclusive, where N is the length of the
; 			string), the behavior is undefined. If the range length is
; 			negative, the behavior is undefined. The range may be empty
; 			(length 0), in which case no search is performed.
; 	@param searchOptions The bitwise-or'ed option flags to control
; 			the search behavior.  The supported options are
; 			kCFCompareBackwards andkCFCompareAnchored.
; 			If other option flags are specified, the behavior
;                         is undefined.
; 	@param result The pointer to a CFRange supplied by the caller in
; 			which the search result is stored.  Note that the length
;                         of this range could be more than If a pointer to an invalid
; 			memory is specified, the behavior is undefined.
; 	@result true, if at least a character which is a member of the character
; 			set is found and result is filled, otherwise, false.
; 

(deftrap-inline "_CFStringFindCharacterFromSet" 
   ((theString (:pointer :__CFString))
    (theSet (:pointer :__CFCharacterSet))
    (location :SInt32)
    (length :SInt32)
    (searchOptions :UInt32)
    (result (:pointer :CFRANGE))
   )
   :Boolean
() )

; #endif

;  Find range of bounds of the line(s) that span the indicated range (startIndex, numChars),
;    taking into account various possible line separator sequences (CR, CRLF, LF, and Unicode LS, PS).
;    All return values are "optional" (provide NULL if you don't want them)
;      lineStartIndex: index of first character in line
;      lineEndIndex: index of first character of the next line (including terminating line separator characters)
;      contentsEndIndex: index of the first line separator character
;    Thus, lineEndIndex - lineStartIndex is the number of chars in the line, including the line separators
;          contentsEndIndex - lineStartIndex is the number of chars in the line w/out the line separators
; 

(deftrap-inline "_CFStringGetLineBounds" 
   ((theString (:pointer :__CFString))
    (location :SInt32)
    (length :SInt32)
    (lineBeginIndex (:pointer :CFINDEX))
    (lineEndIndex (:pointer :CFINDEX))
    (contentsEndIndex (:pointer :CFINDEX))
   )
   nil
() )
; ** Exploding and joining strings with a separator string **

(deftrap-inline "_CFStringCreateByCombiningStrings" 
   ((alloc (:pointer :__CFAllocator))
    (theArray (:pointer :__CFArray))
    (separatorString (:pointer :__CFString))
   )
   (:pointer :__CFString)
() )
;  Empty array returns empty string; one element array returns the element 

(deftrap-inline "_CFStringCreateArrayBySeparatingStrings" 
   ((alloc (:pointer :__CFAllocator))
    (theString (:pointer :__CFString))
    (separatorString (:pointer :__CFString))
   )
   (:pointer :__CFArray)
() )
;  No separators in the string returns array with that string; string == sep returns two empty strings 
; ** Parsing non-localized numbers from strings **

(deftrap-inline "_CFStringGetIntValue" 
   ((str (:pointer :__CFString))
   )
   :SInt32
() )
;  Skips whitespace; returns 0 on error, MAX or -MAX on overflow 

(deftrap-inline "_CFStringGetDoubleValue" 
   ((str (:pointer :__CFString))
   )
   :double-float
() )
;  Skips whitespace; returns 0.0 on error 
; ** MutableString functions **
;  CFStringAppend("abcdef", "xxxxx") -> "abcdefxxxxx"
;    CFStringDelete("abcdef", CFRangeMake(2, 3)) -> "abf"
;    CFStringReplace("abcdef", CFRangeMake(2, 3), "xxxxx") -> "abxxxxxf"
;    CFStringReplaceAll("abcdef", "xxxxx") -> "xxxxx"
; 

(deftrap-inline "_CFStringAppend" 
   ((theString (:pointer :__CFString))
    (appendedString (:pointer :__CFString))
   )
   nil
() )

(deftrap-inline "_CFStringAppendCharacters" 
   ((theString (:pointer :__CFString))
    (chars (:pointer :UniChar))
    (numChars :SInt32)
   )
   nil
() )

(deftrap-inline "_CFStringAppendPascalString" 
   ((theString (:pointer :__CFString))
    (pStr (:pointer :STR255))
    (encoding :UInt32)
   )
   nil
() )

(deftrap-inline "_CFStringAppendCString" 
   ((theString (:pointer :__CFString))
    (cStr (:pointer :char))
    (encoding :UInt32)
   )
   nil
() )

(deftrap-inline "_CFStringAppendFormat" 
   ((theString (:pointer :__CFString))
    (formatOptions (:pointer :__CFDictionary))
    (format (:pointer :__CFString))
#| |...|  ;; What should this do?
    |#
   )
   nil
() )

(deftrap-inline "_CFStringAppendFormatAndArguments" 
   ((theString (:pointer :__CFString))
    (formatOptions (:pointer :__CFDictionary))
    (format (:pointer :__CFString))
    (arguments (:pointer :void))
   )
   nil
() )

(deftrap-inline "_CFStringInsert" 
   ((str (:pointer :__CFString))
    (idx :SInt32)
    (insertedStr (:pointer :__CFString))
   )
   nil
() )

(deftrap-inline "_CFStringDelete" 
   ((theString (:pointer :__CFString))
    (location :SInt32)
    (length :SInt32)
   )
   nil
() )

(deftrap-inline "_CFStringReplace" 
   ((theString (:pointer :__CFString))
    (location :SInt32)
    (length :SInt32)
    (replacement (:pointer :__CFString))
   )
   nil
() )

(deftrap-inline "_CFStringReplaceAll" 
   ((theString (:pointer :__CFString))
    (replacement (:pointer :__CFString))
   )
   nil
() )
;  Replaces whole string 

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  Replace all occurrences of target in rangeToSearch of theString with replacement.
;    Pays attention to kCFCompareCaseInsensitive, kCFCompareBackwards, kCFCompareNonliteral, and kCFCompareAnchored.
;    kCFCompareBackwards can be used to do the replacement starting from the end, which could give a different result.
;      ex. AAAAA, replace AA with B -> BBA or ABB; latter if kCFCompareBackwards
;    kCFCompareAnchored assures only anchored but multiple instances are found (the instances must be consecutive at start or end)
;      ex. AAXAA, replace A with B -> BBXBB or BBXAA; latter if kCFCompareAnchored
;    Returns number of replacements performed.
; 

(deftrap-inline "_CFStringFindAndReplace" 
   ((theString (:pointer :__CFString))
    (stringToFind (:pointer :__CFString))
    (replacementString (:pointer :__CFString))
    (location :SInt32)
    (length :SInt32)
    (compareOptions :UInt32)
   )
   :SInt32
() )

; #endif

;  This function will make the contents of a mutable CFString point directly at the specified UniChar array.
;    It works only with CFStrings created with CFStringCreateMutableWithExternalCharactersNoCopy().
;    This function does not free the previous buffer.
;    The string will be manipulated within the provided buffer (if any) until it outgrows capacity; then the
;      externalCharactersAllocator will be consulted for more memory.
;    See comments at the top of this file for more info.
; 

(deftrap-inline "_CFStringSetExternalCharactersNoCopy" 
   ((theString (:pointer :__CFString))
    (chars (:pointer :UniChar))
    (length :SInt32)
    (capacity :SInt32)
   )
   nil
() )
;  Works only on specially created mutable strings! 
;  CFStringPad() will pad or cut down a string to the specified size.
;    The pad string is used as the fill string; indexIntoPad specifies which character to start with.
;      CFStringPad("abc", " ", 9, 0) ->  "abc      "
;      CFStringPad("abc", ". ", 9, 1) -> "abc . . ."
;      CFStringPad("abcdef", ?, 3, ?) -> "abc"
; 
;      CFStringTrim() will trim the specified string from both ends of the string.
;      CFStringTrimWhitespace() will do the same with white space characters (tab, newline, etc)
;      CFStringTrim("  abc ", " ") -> "abc"
;      CFStringTrim("* * * *abc * ", "* ") -> "*abc "
; 

(deftrap-inline "_CFStringPad" 
   ((theString (:pointer :__CFString))
    (padString (:pointer :__CFString))
    (length :SInt32)
    (indexIntoPad :SInt32)
   )
   nil
() )

(deftrap-inline "_CFStringTrim" 
   ((theString (:pointer :__CFString))
    (trimString (:pointer :__CFString))
   )
   nil
() )

(deftrap-inline "_CFStringTrimWhitespace" 
   ((theString (:pointer :__CFString))
   )
   nil
() )

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

(deftrap-inline "_CFStringLowercase" 
   ((theString (:pointer :__CFString))
    (locale (:pointer :__CFLocale))
   )
   nil
() )

(deftrap-inline "_CFStringUppercase" 
   ((theString (:pointer :__CFString))
    (locale (:pointer :__CFLocale))
   )
   nil
() )

(deftrap-inline "_CFStringCapitalize" 
   ((theString (:pointer :__CFString))
    (locale (:pointer :__CFLocale))
   )
   nil
() )
#| 
; #else

(deftrap-inline "_CFStringLowercase" 
   ((theString (:pointer :__CFString))
    (localeTBD :pointer)
   )
   nil
() )
;  localeTBD must be NULL on pre-10.3

(deftrap-inline "_CFStringUppercase" 
   ((theString (:pointer :__CFString))
    (localeTBD :pointer)
   )
   nil
() )
;  localeTBD must be NULL on pre-10.3

(deftrap-inline "_CFStringCapitalize" 
   ((theString (:pointer :__CFString))
    (localeTBD :pointer)
   )
   nil
() )
;  localeTBD must be NULL on pre-10.3
 |#

; #endif


; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
; !
; 	@typedef CFStringNormalizationForm
; 	This is the type of Unicode normalization forms as described in
; 	Unicode Technical Report #15.
; 

(defconstant $kCFStringNormalizationFormD 0)    ;  Canonical Decomposition

(defconstant $kCFStringNormalizationFormKD 1)   ;  Compatibility Decomposition

(defconstant $kCFStringNormalizationFormC 2)    ;  Canonical Decomposition followed by Canonical Composition
;  Compatibility Decomposition followed by Canonical Composition

(defconstant $kCFStringNormalizationFormKC 3)
(def-mactype :CFStringNormalizationForm (find-mactype ':SINT32))
; !
; 	@function CFStringNormalize
; 	Normalizes the string into the specified form as described in
; 	Unicode Technical Report #15.
; 	@param theString  The string which is to be normalized.  If this
; 		parameter is not a valid mutable CFString, the behavior is
; 		undefined.
; 	@param theForm  The form into which the string is to be normalized.
; 		If this parameter is not a valid CFStringNormalizationForm value,
; 		the behavior is undefined.
; 

(deftrap-inline "_CFStringNormalize" 
   ((theString (:pointer :__CFString))
    (theForm :SInt32)
   )
   nil
() )

; #endif

;  This returns availability of the encoding on the system
; 

(deftrap-inline "_CFStringIsEncodingAvailable" 
   ((encoding :UInt32)
   )
   :Boolean
() )
;  This function returns list of available encodings.  The returned list is terminated with kCFStringEncodingInvalidId and owned by the system.
; 

(deftrap-inline "_CFStringGetListOfAvailableEncodings" 
   (
   )
   (:pointer :UInt32)
() )
;  Returns name of the encoding; non-localized.
; 

(deftrap-inline "_CFStringGetNameOfEncoding" 
   ((encoding :UInt32)
   )
   (:pointer :__CFString)
() )
;  ID mapping functions from/to Cocoa NSStringEncoding.  Returns kCFStringEncodingInvalidId if no mapping exists.
; 

(deftrap-inline "_CFStringConvertEncodingToNSStringEncoding" 
   ((encoding :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_CFStringConvertNSStringEncodingToEncoding" 
   ((encoding :UInt32)
   )
   :UInt32
() )
;  ID mapping functions from/to Microsoft Windows codepage (covers both OEM & ANSI).  Returns kCFStringEncodingInvalidId if no mapping exists.
; 

(deftrap-inline "_CFStringConvertEncodingToWindowsCodepage" 
   ((encoding :UInt32)
   )
   :UInt32
() )

(deftrap-inline "_CFStringConvertWindowsCodepageToEncoding" 
   ((codepage :UInt32)
   )
   :UInt32
() )
;  ID mapping functions from/to IANA registery charset names.  Returns kCFStringEncodingInvalidId if no mapping exists.
; 

(deftrap-inline "_CFStringConvertIANACharSetNameToEncoding" 
   ((theString (:pointer :__CFString))
   )
   :UInt32
() )

(deftrap-inline "_CFStringConvertEncodingToIANACharSetName" 
   ((encoding :UInt32)
   )
   (:pointer :__CFString)
() )
;  Returns the most compatible MacOS script value for the input encoding 
;  i.e. kCFStringEncodingMacRoman -> kCFStringEncodingMacRoman 
; 	kCFStringEncodingWindowsLatin1 -> kCFStringEncodingMacRoman 
; 	kCFStringEncodingISO_2022_JP -> kCFStringEncodingMacJapanese 

(deftrap-inline "_CFStringGetMostCompatibleMacStringEncoding" 
   ((encoding :UInt32)
   )
   :UInt32
() )
;  The next two functions allow fast access to the contents of a string, 
;    assuming you are doing sequential or localized accesses. To use, call
;    CFStringInitInlineBuffer() with a CFStringInlineBuffer (on the stack, say),
;    and a range in the string to look at. Then call CFStringGetCharacterFromInlineBuffer()
;    as many times as you want, with a index into that range (relative to the start
;    of that range). These are INLINE functions and will end up calling CFString only 
;    once in a while, to fill a buffer.  CFStringGetCharacterFromInlineBuffer() returns 0 if
;    a location outside the original range is specified.
; 
(defconstant $__kCFStringInlineBufferLength 64)
; #define __kCFStringInlineBufferLength 64
(defrecord CFStringInlineBuffer   (buffer (:array :UInt16 64))
   (theString (:pointer :__CFString))
   (directBuffer (:pointer :UniChar))
   (rangeToBuffer :CFRANGE)
                                                ;  Range in string to buffer 
   (bufferedRangeStart :SInt32)
                                                ;  Start of range currently buffered (relative to rangeToBuffer.location) 
   (bufferedRangeEnd :SInt32)
                                                ;  bufferedRangeStart + number of chars actually buffered 
)

; #if defined(CF_INLINE)
#| 
#|
void CFStringInitInlineBuffer(CFStringRef str, CFStringInlineBuffer *buf, CFRange range) {
    buf->theString = str;
    buf->rangeToBuffer = range;
    buf->directBuffer = CFStringGetCharactersPtr(str);
    buf->bufferedRangeStart = buf->bufferedRangeEnd = 0;
|#
#|
UniChar CFStringGetCharacterFromInlineBuffer(CFStringInlineBuffer *buf, CFIndex idx) {
    if (buf->directBuffer) {
	if (idx < 0 || idx >= buf->rangeToBuffer.length) return 0;
        return buf->directBuffer[idx + buf->rangeToBuffer.location];
    }
    if (idx >= buf->bufferedRangeEnd || idx < buf->bufferedRangeStart) {
	if (idx < 0 || idx >= buf->rangeToBuffer.length) return 0;
	if ((buf->bufferedRangeStart = idx - 4) < 0) buf->bufferedRangeStart = 0;
	buf->bufferedRangeEnd = buf->bufferedRangeStart + __kCFStringInlineBufferLength;
	if (buf->bufferedRangeEnd > buf->rangeToBuffer.length) buf->bufferedRangeEnd = buf->rangeToBuffer.length;
	CFStringGetCharacters(buf->theString, CFRangeMake(buf->rangeToBuffer.location + buf->bufferedRangeStart, buf->bufferedRangeEnd - buf->bufferedRangeStart), buf->buffer);
    }
    return buf->buffer[idx - buf->bufferedRangeStart];
|#
 |#

; #else
;  If INLINE functions are not available, we do somewhat less powerful macros that work similarly (except be aware that the buf argument is evaluated multiple times).
; 
; #define CFStringInitInlineBuffer(str, buf, range)     do {(buf)->theString = str; (buf)->rangeToBuffer = range; (buf)->directBuffer = CFStringGetCharactersPtr(str);} while (0)
; #define CFStringGetCharacterFromInlineBuffer(buf, idx)     (((idx) < 0 || (idx) >= (buf)->rangeToBuffer.length) ? 0 : ((buf)->directBuffer ? (buf)->directBuffer[(idx) + (buf)->rangeToBuffer.location] : CFStringGetCharacterAtIndex((buf)->theString, (idx) + (buf)->rangeToBuffer.location)))

; #endif /* CF_INLINE */

;  Rest of the stuff in this file is private and should not be used directly
; 
;  For debugging only
;    Use CFShow() to printf the description of any CFType;
;    Use CFShowStr() to printf detailed info about a CFString
; 

(deftrap-inline "_CFShow" 
   ((obj (:pointer :void))
   )
   nil
() )

(deftrap-inline "_CFShowStr" 
   ((str (:pointer :__CFString))
   )
   nil
() )
;  This function is private and should not be used directly 

(deftrap-inline "___CFStringMakeConstantString" 
   ((cStr (:pointer :char))
   )
   (:pointer :__CFString)
() )
;  Private; do not use 

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* !__COREFOUNDATION_CFSTRING__ */


(provide-interface "CFString")