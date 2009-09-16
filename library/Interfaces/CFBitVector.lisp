(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFBitVector.h"
; at Sunday July 2,2006 7:23:00 pm.
; 	CFBitVector.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFBITVECTOR__)
(defconstant $__COREFOUNDATION_CFBITVECTOR__ 1)
; #define __COREFOUNDATION_CFBITVECTOR__ 1

(require-interface "CoreFoundation/CFBase")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(def-mactype :CFBit (find-mactype ':UInt32))

(def-mactype :CFBitVectorRef (find-mactype '(:pointer :__CFBitVector)))

(def-mactype :CFMutableBitVectorRef (find-mactype '(:pointer :__CFBitVector)))

(deftrap-inline "_CFBitVectorGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFBitVectorCreate" 
   ((allocator (:pointer :__CFAllocator))
    (bytes (:pointer :UInt8))
    (numBits :SInt32)
   )
   (:pointer :__CFBitVector)
() )

(deftrap-inline "_CFBitVectorCreateCopy" 
   ((allocator (:pointer :__CFAllocator))
    (bv (:pointer :__CFBitVector))
   )
   (:pointer :__CFBitVector)
() )

(deftrap-inline "_CFBitVectorCreateMutable" 
   ((allocator (:pointer :__CFAllocator))
    (capacity :SInt32)
   )
   (:pointer :__CFBitVector)
() )

(deftrap-inline "_CFBitVectorCreateMutableCopy" 
   ((allocator (:pointer :__CFAllocator))
    (capacity :SInt32)
    (bv (:pointer :__CFBitVector))
   )
   (:pointer :__CFBitVector)
() )

(deftrap-inline "_CFBitVectorGetCount" 
   ((bv (:pointer :__CFBitVector))
   )
   :SInt32
() )

(deftrap-inline "_CFBitVectorGetCountOfBit" 
   ((bv (:pointer :__CFBitVector))
    (location :SInt32)
    (length :SInt32)
    (value :UInt32)
   )
   :SInt32
() )

(deftrap-inline "_CFBitVectorContainsBit" 
   ((bv (:pointer :__CFBitVector))
    (location :SInt32)
    (length :SInt32)
    (value :UInt32)
   )
   :Boolean
() )

(deftrap-inline "_CFBitVectorGetBitAtIndex" 
   ((bv (:pointer :__CFBitVector))
    (idx :SInt32)
   )
   :UInt32
() )

(deftrap-inline "_CFBitVectorGetBits" 
   ((bv (:pointer :__CFBitVector))
    (location :SInt32)
    (length :SInt32)
    (bytes (:pointer :UInt8))
   )
   nil
() )

(deftrap-inline "_CFBitVectorGetFirstIndexOfBit" 
   ((bv (:pointer :__CFBitVector))
    (location :SInt32)
    (length :SInt32)
    (value :UInt32)
   )
   :SInt32
() )

(deftrap-inline "_CFBitVectorGetLastIndexOfBit" 
   ((bv (:pointer :__CFBitVector))
    (location :SInt32)
    (length :SInt32)
    (value :UInt32)
   )
   :SInt32
() )

(deftrap-inline "_CFBitVectorSetCount" 
   ((bv (:pointer :__CFBitVector))
    (count :SInt32)
   )
   nil
() )

(deftrap-inline "_CFBitVectorFlipBitAtIndex" 
   ((bv (:pointer :__CFBitVector))
    (idx :SInt32)
   )
   nil
() )

(deftrap-inline "_CFBitVectorFlipBits" 
   ((bv (:pointer :__CFBitVector))
    (location :SInt32)
    (length :SInt32)
   )
   nil
() )

(deftrap-inline "_CFBitVectorSetBitAtIndex" 
   ((bv (:pointer :__CFBitVector))
    (idx :SInt32)
    (value :UInt32)
   )
   nil
() )

(deftrap-inline "_CFBitVectorSetBits" 
   ((bv (:pointer :__CFBitVector))
    (location :SInt32)
    (length :SInt32)
    (value :UInt32)
   )
   nil
() )

(deftrap-inline "_CFBitVectorSetAllBits" 
   ((bv (:pointer :__CFBitVector))
    (value :UInt32)
   )
   nil
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFBITVECTOR__ */


(provide-interface "CFBitVector")