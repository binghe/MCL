(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFBase.h"
; at Sunday July 2,2006 7:22:42 pm.
; 	CFBase.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFBASE__)
(defconstant $__COREFOUNDATION_CFBASE__ 1)
; #define __COREFOUNDATION_CFBASE__ 1

; #if defined(__WIN32__)
#| 
(require-interface "windows")
 |#

; #endif


(require-interface "stdint")

(require-interface "stdbool")

(require-interface "AvailabilityMacros")

; #if !defined(DARWIN)

; #if defined(__CF_USE_FRAMEWORK_INCLUDES__) || (defined(__MACH__) && !defined(__MWERKS__)) 
#| |#

(require-interface "CoreServices/../Frameworks/CarbonCore.framework/Headers/MacTypes")

#|
 |#

; #else

(require-interface "MacTypes")

; #endif


; #endif /* !DARWIN */


; #if defined(DARWIN)
#| 
; #if defined(__MACH__)
|#

(require-interface "CarbonCore/MacTypes")

#|
; #else

;type name? (def-mactype :Boolean (find-mactype ':UInt8))

;type name? (def-mactype :UInt8 (find-mactype ':UInt8))

;type name? (def-mactype :SInt8 (find-mactype ':SInt8))

;type name? (def-mactype :UInt16 (find-mactype ':UInt16))

;type name? (def-mactype :SInt16 (find-mactype ':SInt16))

;type name? (def-mactype :UInt32 (find-mactype ':UInt32))

;type name? (def-mactype :SInt32 (find-mactype ':SInt32))

;type name? (%define-record :UInt64 (find-record-descriptor ':uint64_t))

;type name? (%define-record :SInt64 (find-record-descriptor ':int64_t))

(def-mactype :Float32 (find-mactype ':single-float))

(def-mactype :Float64 (find-mactype ':double-float))

(def-mactype :UniChar (find-mactype ':UInt16))

(def-mactype :StringPtr (find-mactype '(:pointer :UInt8)))

(def-mactype :ConstStringPtr (find-mactype '(:pointer :UInt8)))
(defrecord Str255
   (length :UInt8)
   (contents (:array :UInt8 255))
)
(def-mactype :ConstStr255Param (find-mactype '(:pointer :UInt8)))

(def-mactype :OSErr (find-mactype ':SInt16))

(def-mactype :OSStatus (find-mactype ':SInt32))

(def-mactype :UTF32Char (find-mactype ':UInt32))

(def-mactype :UTF16Char (find-mactype ':UInt16))

(def-mactype :UTF8Char (find-mactype ':UInt8))

; #endif

 |#

; #endif /* DARWIN */


; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

; #if !defined(NULL)
; #define NULL	0

; #endif


; #if !defined(TRUE)
#| 
; #define TRUE	1
 |#

; #endif


; #if !defined(FALSE)
(defconstant $FALSE 0)
; #define FALSE	0

; #endif


; #if defined(__WIN32__)
#| 
; #undef CF_EXPORT

; #if defined(CF_BUILDING_CF)
; #define CF_EXPORT __declspec(dllexport) extern

; #else
; #define CF_EXPORT __declspec(dllimport) extern

; #endif

 |#

; #elif defined(macintosh)
#| 
; #if defined(__MWERKS__)
; #define CF_EXPORT __declspec(export) extern

; #endif

 |#

; #endif


; #if !defined(CF_EXPORT)
; #define CF_EXPORT extern

; #endif


; #if !defined(CF_INLINE)

; #if defined(__GNUC__)
#| 
; #define CF_INLINE static __inline__
 |#

; #elif defined(__MWERKS__) || defined(__cplusplus)
#| 
; #define CF_INLINE static inline
 |#

; #elif defined(__WIN32__)
#| 
; #define CF_INLINE static __inline__
 |#

; #endif


; #endif

(def-mactype :kCFCoreFoundationVersionNumber (find-mactype ':double))
(defconstant $kCFCoreFoundationVersionNumber10_0 196.4)
; #define kCFCoreFoundationVersionNumber10_0 196.4
(defconstant $kCFCoreFoundationVersionNumber10_0_3 196.5)
; #define kCFCoreFoundationVersionNumber10_0_3 196.5

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
(defconstant $kCFCoreFoundationVersionNumber10_1 226.0)
; #define kCFCoreFoundationVersionNumber10_1 226.0
;  Note these do not follow the usual numbering policy from the base release 
(defconstant $kCFCoreFoundationVersionNumber10_1_2 227.2)
; #define kCFCoreFoundationVersionNumber10_1_2 227.2
(defconstant $kCFCoreFoundationVersionNumber10_1_4 227.3)
; #define kCFCoreFoundationVersionNumber10_1_4 227.3

; #endif


; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
(defconstant $kCFCoreFoundationVersionNumber10_2 263.0)
; #define kCFCoreFoundationVersionNumber10_2 263.0

; #endif


(def-mactype :CFTypeID (find-mactype ':UInt32))

(def-mactype :CFOptionFlags (find-mactype ':UInt32))

(def-mactype :CFHashCode (find-mactype ':UInt32))

(def-mactype :CFIndex (find-mactype ':SInt32))
;  Base "type" of all "CF objects", and polymorphic functions on them 

(def-mactype :CFTypeRef (find-mactype '(:pointer :void)))

(def-mactype :CFStringRef (find-mactype '(:pointer :__CFString)))

(def-mactype :CFMutableStringRef (find-mactype '(:pointer :__CFString)))
; 
;         Type to mean any instance of a property list type;
;         currently, CFString, CFData, CFNumber, CFBoolean, CFDate,
;         CFArray, and CFDictionary.
; 

(def-mactype :CFPropertyListRef (find-mactype ':CFTypeRef))
;  Values returned from comparison functions 

(defconstant $kCFCompareLessThan -1)
(defconstant $kCFCompareEqualTo 0)
(defconstant $kCFCompareGreaterThan 1)
(def-mactype :CFComparisonResult (find-mactype ':SINT32))
;  A standard comparison function 

(def-mactype :CFComparatorFunction (find-mactype ':pointer)); (const void * val1 , const void * val2 , void * context)
;  Constant used by some functions to indicate failed searches. 
;  This is of type CFIndex. 

(defconstant $kCFNotFound -1)
;  Range type 
(defrecord CFRange
   (location :SInt32)
   (length :SInt32)
)

; #if defined(CF_INLINE)
#| 
#|
CFRange CFRangeMake(CFIndex loc, CFIndex len) {
    CFRange range;
    range.location = loc;
    range.length = len;
    return range;
|#
 |#

; #else
; #define CFRangeMake(LOC, LEN) __CFRangeMake(LOC, LEN)

; #endif

;  Private; do not use 

(deftrap-inline "___CFRangeMake" 
   ((returnArg (:pointer :CFRANGE))
    (loc :SInt32)
    (len :SInt32)
   )
   nil
() )

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  Null representant 

(def-mactype :CFNullRef (find-mactype '(:pointer :__CFNull)))

(deftrap-inline "_CFNullGetTypeID" 
   (
   )
   :UInt32
() )
(def-mactype :kCFNull (find-mactype ':CFNullRef))
;  the singleton null instance

; #endif

;  Allocator API
; 
;    Most of the time when specifying an allocator to Create functions, the NULL
;    argument indicates "use the default"; this is the same as using kCFAllocatorDefault
;    or the return value from CFAllocatorGetDefault().  This assures that you will use
;    the allocator in effect at that time.
; 
;    You should rarely use kCFAllocatorSystemDefault, the default default allocator.
; 

(def-mactype :CFAllocatorRef (find-mactype '(:pointer :__CFAllocator)))
;  This is a synonym for NULL, if you'd rather use a named constant. 
(def-mactype :kCFAllocatorDefault (find-mactype ':CFAllocatorRef))
;  Default system allocator; you rarely need to use this. 
(def-mactype :kCFAllocatorSystemDefault (find-mactype ':CFAllocatorRef))
;  This allocator uses malloc(), realloc(), and free(). This should not be
;    generally used; stick to kCFAllocatorDefault whenever possible. This
;    allocator is useful as the "bytesDeallocator" in CFData or
;    "contentsDeallocator" in CFString where the memory was obtained as a
;    result of malloc() type functions.
; 
(def-mactype :kCFAllocatorMalloc (find-mactype ':CFAllocatorRef))
;  Null allocator which does nothing and allocates no memory. This allocator
;    is useful as the "bytesDeallocator" in CFData or "contentsDeallocator"
;    in CFString where the memory should not be freed. 
; 
(def-mactype :kCFAllocatorNull (find-mactype ':CFAllocatorRef))
;  Special allocator argument to CFAllocatorCreate() which means
;    "use the functions given in the context to allocate the allocator
;    itself as well". 
; 
(def-mactype :kCFAllocatorUseContext (find-mactype ':CFAllocatorRef))

(def-mactype :CFAllocatorRetainCallBack (find-mactype ':pointer)); (const void * info)

(def-mactype :CFAllocatorReleaseCallBack (find-mactype ':pointer)); (const void * info)

(def-mactype :CFAllocatorCopyDescriptionCallBack (find-mactype ':pointer)); (const void * info)

(def-mactype :CFAllocatorAllocateCallBack (find-mactype ':pointer)); (CFIndex allocSize , CFOptionFlags hint , void * info)

(def-mactype :CFAllocatorReallocateCallBack (find-mactype ':pointer)); (void * ptr , CFIndex newsize , CFOptionFlags hint , void * info)

(def-mactype :CFAllocatorDeallocateCallBack (find-mactype ':pointer)); (void * ptr , void * info)

(def-mactype :CFAllocatorPreferredSizeCallBack (find-mactype ':pointer)); (CFIndex size , CFOptionFlags hint , void * info)
(defrecord CFAllocatorContext
   (version :SInt32)
   (info :pointer)
   (retain :pointer)
   (release :pointer)
   (copyDescription :pointer)
   (allocate :pointer)
   (reallocate :pointer)
   (deallocate :pointer)
   (preferredSize :pointer)
)

(deftrap-inline "_CFAllocatorGetTypeID" 
   (
   )
   :UInt32
() )
; 
; 	CFAllocatorSetDefault() sets the allocator that is used in the current
; 	thread whenever NULL is specified as an allocator argument. This means
; 	that most, if not all allocations will go through this allocator. It
; 	also means that any allocator set as the default needs to be ready to
; 	deal with arbitrary memory allocation requests; in addition, the size
; 	and number of requests will change between releases.
; 
; 	An allocator set as the default will never be released, even if later
; 	another allocator replaces it as the default. Not only is it impractical
; 	for it to be released (as there might be caches created under the covers
; 	that refer to the allocator), in general it's also safer and more
; 	efficient to keep it around.
; 
; 	If you wish to use a custom allocator in a context, it's best to provide
; 	it as the argument to the various creation functions rather than setting
; 	it as the default. Setting the default allocator is not encouraged.
; 
; 	If you do set an allocator as the default, either do it for all time in
; 	your app, or do it in a nested fashion (by restoring the previous allocator
; 	when you exit your context). The latter might be appropriate for plug-ins
; 	or libraries that wish to set the default allocator.
; 

(deftrap-inline "_CFAllocatorSetDefault" 
   ((allocator (:pointer :__CFAllocator))
   )
   nil
() )

(deftrap-inline "_CFAllocatorGetDefault" 
   (
   )
   (:pointer :__CFAllocator)
() )

(deftrap-inline "_CFAllocatorCreate" 
   ((allocator (:pointer :__CFAllocator))
    (context (:pointer :CFALLOCATORCONTEXT))
   )
   (:pointer :__CFAllocator)
() )

(deftrap-inline "_CFAllocatorAllocate" 
   ((allocator (:pointer :__CFAllocator))
    (size :SInt32)
    (hint :UInt32)
   )
   (:pointer :void)
() )

(deftrap-inline "_CFAllocatorReallocate" 
   ((allocator (:pointer :__CFAllocator))
    (ptr :pointer)
    (newsize :SInt32)
    (hint :UInt32)
   )
   (:pointer :void)
() )

(deftrap-inline "_CFAllocatorDeallocate" 
   ((allocator (:pointer :__CFAllocator))
    (ptr :pointer)
   )
   nil
() )

(deftrap-inline "_CFAllocatorGetPreferredSizeForSize" 
   ((allocator (:pointer :__CFAllocator))
    (size :SInt32)
    (hint :UInt32)
   )
   :SInt32
() )

(deftrap-inline "_CFAllocatorGetContext" 
   ((allocator (:pointer :__CFAllocator))
    (context (:pointer :CFALLOCATORCONTEXT))
   )
   nil
() )
;  Polymorphic CF functions 

(deftrap-inline "_CFGetTypeID" 
   ((cf (:pointer :void))
   )
   :UInt32
() )

(deftrap-inline "_CFCopyTypeIDDescription" 
   ((type_id :UInt32)
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFRetain" 
   ((cf (:pointer :void))
   )
   (:pointer :void)
() )

(deftrap-inline "_CFRelease" 
   ((cf (:pointer :void))
   )
   nil
() )

(deftrap-inline "_CFGetRetainCount" 
   ((cf (:pointer :void))
   )
   :SInt32
() )

(deftrap-inline "_CFEqual" 
   ((cf1 (:pointer :void))
    (cf2 (:pointer :void))
   )
   :Boolean
() )

(deftrap-inline "_CFHash" 
   ((cf (:pointer :void))
   )
   :UInt32
() )

(deftrap-inline "_CFCopyDescription" 
   ((cf (:pointer :void))
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFGetAllocator" 
   ((cf (:pointer :void))
   )
   (:pointer :__CFAllocator)
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFBASE__ */


(provide-interface "CFBase")