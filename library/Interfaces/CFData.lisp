(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFData.h"
; at Sunday July 2,2006 7:22:47 pm.
; 	CFData.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFDATA__)
(defconstant $__COREFOUNDATION_CFDATA__ 1)
; #define __COREFOUNDATION_CFDATA__ 1

(require-interface "CoreFoundation/CFBase")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(def-mactype :CFDataRef (find-mactype '(:pointer :__CFData)))

(def-mactype :CFMutableDataRef (find-mactype '(:pointer :__CFData)))

(deftrap-inline "_CFDataGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFDataCreate" 
   ((allocator (:pointer :__CFAllocator))
    (bytes (:pointer :UInt8))
    (length :SInt32)
   )
   (:pointer :__CFData)
() )

(deftrap-inline "_CFDataCreateWithBytesNoCopy" 
   ((allocator (:pointer :__CFAllocator))
    (bytes (:pointer :UInt8))
    (length :SInt32)
    (bytesDeallocator (:pointer :__CFAllocator))
   )
   (:pointer :__CFData)
() )
;  Pass kCFAllocatorNull as bytesDeallocator to assure the bytes aren't freed 

(deftrap-inline "_CFDataCreateCopy" 
   ((allocator (:pointer :__CFAllocator))
    (theData (:pointer :__CFData))
   )
   (:pointer :__CFData)
() )

(deftrap-inline "_CFDataCreateMutable" 
   ((allocator (:pointer :__CFAllocator))
    (capacity :SInt32)
   )
   (:pointer :__CFData)
() )

(deftrap-inline "_CFDataCreateMutableCopy" 
   ((allocator (:pointer :__CFAllocator))
    (capacity :SInt32)
    (theData (:pointer :__CFData))
   )
   (:pointer :__CFData)
() )

(deftrap-inline "_CFDataGetLength" 
   ((theData (:pointer :__CFData))
   )
   :SInt32
() )

(deftrap-inline "_CFDataGetBytePtr" 
   ((theData (:pointer :__CFData))
   )
   (:pointer :UInt8)
() )

(deftrap-inline "_CFDataGetMutableBytePtr" 
   ((theData (:pointer :__CFData))
   )
   (:pointer :UInt8)
() )

(deftrap-inline "_CFDataGetBytes" 
   ((theData (:pointer :__CFData))
    (location :SInt32)
    (length :SInt32)
    (buffer (:pointer :UInt8))
   )
   nil
() )

(deftrap-inline "_CFDataSetLength" 
   ((theData (:pointer :__CFData))
    (length :SInt32)
   )
   nil
() )

(deftrap-inline "_CFDataIncreaseLength" 
   ((theData (:pointer :__CFData))
    (extraLength :SInt32)
   )
   nil
() )

(deftrap-inline "_CFDataAppendBytes" 
   ((theData (:pointer :__CFData))
    (bytes (:pointer :UInt8))
    (length :SInt32)
   )
   nil
() )

(deftrap-inline "_CFDataReplaceBytes" 
   ((theData (:pointer :__CFData))
    (location :SInt32)
    (length :SInt32)
    (newBytes (:pointer :UInt8))
    (newLength :SInt32)
   )
   nil
() )

(deftrap-inline "_CFDataDeleteBytes" 
   ((theData (:pointer :__CFData))
    (location :SInt32)
    (length :SInt32)
   )
   nil
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFDATA__ */


(provide-interface "CFData")