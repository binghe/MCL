(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:NSObjCRuntime.h"
; at Sunday July 2,2006 7:30:53 pm.
; 	NSObjCRuntime.h
; 	Copyright (c) 1994-2003, Apple, Inc. All rights reserved.
; 

; #if defined(__WIN32__)
#| 
; #undef FOUNDATION_EXPORT

; #if defined(NSBUILDINGFOUNDATION)
; #define FOUNDATION_EXPORT __declspec(dllexport) extern

; #else
; #define FOUNDATION_EXPORT __declspec(dllimport) extern

; #endif


; #if !defined(FOUNDATION_IMPORT)
; #define FOUNDATION_IMPORT __declspec(dllimport) extern

; #endif

 |#

; #endif


; #if defined(__cplusplus)
#|
    #define FOUNDATION_EXPORT extern "C"
    #define FOUNDATION_IMPORT extern "C"
#endif
|#

; #if !defined(FOUNDATION_EXPORT)
; #define FOUNDATION_EXPORT extern

; #endif


; #if !defined(FOUNDATION_IMPORT)
; #define FOUNDATION_IMPORT extern

; #endif


; #if !defined(FOUNDATION_STATIC_INLINE)
; #define FOUNDATION_STATIC_INLINE static __inline__

; #endif


; #if !defined(FOUNDATION_EXTERN_INLINE)
; #define FOUNDATION_EXTERN_INLINE extern __inline__

; #endif


; #import <objc/objc.h>

(require-interface "stdarg")

(require-interface "stdint")

(require-interface "AvailabilityMacros")

; #if defined(__hpux__)
#| |#

(require-interface "sys/param")

#|
 |#

; #endif

(def-mactype :NSFoundationVersionNumber (find-mactype ':double))
(defconstant $NSFoundationVersionNumber10_0 397.4)
; #define NSFoundationVersionNumber10_0 397.4

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
(defconstant $NSFoundationVersionNumber10_1 425.0)
; #define NSFoundationVersionNumber10_1 425.0

; #endif


; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
(defconstant $NSFoundationVersionNumber10_2 462.0)
; #define NSFoundationVersionNumber10_2 462.0

; #endif


(deftrap-inline "_NSStringFromSelector" 
   ((aSelector (:pointer :SEL))
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSSelectorFromString" 
   ((returnArg (:pointer :SEL))
    (aSelectorName (:pointer :NSString))
   )
   nil
() )

(deftrap-inline "_NSClassFromString" 
   ((aClassName (:pointer :NSString))
   )
   :class
() )

(deftrap-inline "_NSStringFromClass" 
   ((aClass :class)
   )
   (:pointer :NSString)
() )

(deftrap-inline "_NSGetSizeAndAlignment" 
   ((typePtr (:pointer :char))
    (sizep (:pointer :UInt32))
    (alignp (:pointer :UInt32))
   )
   (:pointer :character)
() )

(deftrap-inline "_NSLog" 
   ((format (:pointer :NSString))
#| |...|  ;; What should this do?
    |#
   )
   nil
() )

(deftrap-inline "_NSLogv" 
   ((format (:pointer :NSString))
    (args (:pointer :void))
   )
   nil
() )
(def-mactype :_NSComparisonResult (find-mactype ':sint32))

(defconstant $NSOrderedAscending -1)
(defconstant $NSOrderedSame 0)
(defconstant $NSOrderedDescending 1)
(def-mactype :NSComparisonResult (find-mactype ':SINT32))

(defconstant $NSNotFound #x7FFFFFFF)

; #if !defined(YES)
; #define YES	(BOOL)1

; #endif


; #if !defined(NO)
; #define NO	(BOOL)0

; #endif


; #if !defined(nil)
; #define nil	(id)0

; #endif


; #if !defined(Nil)
; #define Nil	(Class)0

; #endif


; #if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#| 
; #if !defined(MIN)
; #define MIN(A,B)	({ __typeof__(A) __a = (A); __typeof__(B) __b = (B); __a < __b ? __a : __b; })

; #endif


; #if !defined(MAX)
; #define MAX(A,B)	({ __typeof__(A) __a = (A); __typeof__(B) __b = (B); __a < __b ? __b : __a; })

; #endif


; #if !defined(ABS)
; #define ABS(A)	({ __typeof__(A) __a = (A); __a < 0 ? -__a : __a; })

; #endif

 |#

; #else

; #if !defined(MIN)
; #define MIN(A,B)	((A) < (B) ? (A) : (B))

; #endif


; #if !defined(MAX)
; #define MAX(A,B)	((A) > (B) ? (A) : (B))

; #endif


; #if !defined(ABS)
; #define ABS(A)	((A) < 0 ? (-(A)) : (A))

; #endif


; #endif	/* __GNUC__ */


(provide-interface "NSObjCRuntime")