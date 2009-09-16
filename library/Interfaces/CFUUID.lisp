(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFUUID.h"
; at Sunday July 2,2006 7:23:02 pm.
; 	CFUUID.h
; 	Copyright (c) 1999-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFUUID__)
(defconstant $__COREFOUNDATION_CFUUID__ 1)
; #define __COREFOUNDATION_CFUUID__ 1

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFString")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(def-mactype :CFUUIDRef (find-mactype '(:pointer :__CFUUID)))
(defrecord CFUUIDBytes
   (byte0 :UInt8)
   (byte1 :UInt8)
   (byte2 :UInt8)
   (byte3 :UInt8)
   (byte4 :UInt8)
   (byte5 :UInt8)
   (byte6 :UInt8)
   (byte7 :UInt8)
   (byte8 :UInt8)
   (byte9 :UInt8)
   (byte10 :UInt8)
   (byte11 :UInt8)
   (byte12 :UInt8)
   (byte13 :UInt8)
   (byte14 :UInt8)
   (byte15 :UInt8)
)
;  The CFUUIDBytes struct is a 128-bit struct that contains the
; raw UUID.  A CFUUIDRef can provide such a struct from the
; CFUUIDGetUUIDBytes() function.  This struct is suitable for
; passing to APIs that expect a raw UUID.
; 

(deftrap-inline "_CFUUIDGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFUUIDCreate" 
   ((alloc (:pointer :__CFAllocator))
   )
   (:pointer :__CFUUID)
() )
;  Create and return a brand new unique identifier 

(deftrap-inline "_CFUUIDCreateWithBytes" 
   ((alloc (:pointer :__CFAllocator))
    (byte0 :UInt8)
    (byte1 :UInt8)
    (byte2 :UInt8)
    (byte3 :UInt8)
    (byte4 :UInt8)
    (byte5 :UInt8)
    (byte6 :UInt8)
    (byte7 :UInt8)
    (byte8 :UInt8)
    (byte9 :UInt8)
    (byte10 :UInt8)
    (byte11 :UInt8)
    (byte12 :UInt8)
    (byte13 :UInt8)
    (byte14 :UInt8)
    (byte15 :UInt8)
   )
   (:pointer :__CFUUID)
() )
;  Create and return an identifier with the given contents.  This may return an existing instance with its ref count bumped because of uniquing. 

(deftrap-inline "_CFUUIDCreateFromString" 
   ((alloc (:pointer :__CFAllocator))
    (uuidStr (:pointer :__CFString))
   )
   (:pointer :__CFUUID)
() )
;  Converts from a string representation to the UUID.  This may return an existing instance with its ref count bumped because of uniquing. 

(deftrap-inline "_CFUUIDCreateString" 
   ((alloc (:pointer :__CFAllocator))
    (uuid (:pointer :__CFUUID))
   )
   (:pointer :__CFString)
() )
;  Converts from a UUID to its string representation. 

(deftrap-inline "_CFUUIDGetConstantUUIDWithBytes" 
   ((alloc (:pointer :__CFAllocator))
    (byte0 :UInt8)
    (byte1 :UInt8)
    (byte2 :UInt8)
    (byte3 :UInt8)
    (byte4 :UInt8)
    (byte5 :UInt8)
    (byte6 :UInt8)
    (byte7 :UInt8)
    (byte8 :UInt8)
    (byte9 :UInt8)
    (byte10 :UInt8)
    (byte11 :UInt8)
    (byte12 :UInt8)
    (byte13 :UInt8)
    (byte14 :UInt8)
    (byte15 :UInt8)
   )
   (:pointer :__CFUUID)
() )
;  This returns an immortal CFUUIDRef that should not be released.  It can be used in headers to declare UUID constants with #define. 

(deftrap-inline "_CFUUIDGetUUIDBytes" 
   ((returnArg (:pointer :CFUUIDBYTES))
    (uuid (:pointer :__CFUUID))
   )
   nil
() )

(deftrap-inline "_CFUUIDCreateFromUUIDBytes" 
   ((alloc (:pointer :__CFAllocator))
    (bytes (:pointer :CFUUIDBYTES))
   )
   (:pointer :__CFUUID)
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFUUID__ */


(provide-interface "CFUUID")