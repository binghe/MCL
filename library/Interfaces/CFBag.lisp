(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFBag.h"
; at Sunday July 2,2006 7:22:46 pm.
; 	CFBag.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFBAG__)
(defconstant $__COREFOUNDATION_CFBAG__ 1)
; #define __COREFOUNDATION_CFBAG__ 1

(require-interface "CoreFoundation/CFBase")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(def-mactype :CFBagRetainCallBack (find-mactype ':pointer)); (CFAllocatorRef allocator , const void * value)

(def-mactype :CFBagReleaseCallBack (find-mactype ':pointer)); (CFAllocatorRef allocator , const void * value)

(def-mactype :CFBagCopyDescriptionCallBack (find-mactype ':pointer)); (const void * value)

(def-mactype :CFBagEqualCallBack (find-mactype ':pointer)); (const void * value1 , const void * value2)

(def-mactype :CFBagHashCallBack (find-mactype ':pointer)); (const void * value)
(defrecord CFBagCallBacks
   (version :SInt32)
   (retain :pointer)
   (release :pointer)
   (copyDescription :pointer)
   (equal :pointer)
   (hash :pointer)
)
(%define-record :kCFTypeBagCallBacks (find-record-descriptor ':CFBagCallBacks))
(%define-record :kCFCopyStringBagCallBacks (find-record-descriptor ':CFBagCallBacks))

(def-mactype :CFBagApplierFunction (find-mactype ':pointer)); (const void * value , void * context)

(def-mactype :CFBagRef (find-mactype '(:pointer :__CFBag)))

(def-mactype :CFMutableBagRef (find-mactype '(:pointer :__CFBag)))

(deftrap-inline "_CFBagGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFBagCreate" 
   ((allocator (:pointer :__CFAllocator))
    (values :pointer)
    (numValues :SInt32)
    (callBacks (:pointer :CFBAGCALLBACKS))
   )
   (:pointer :__CFBag)
() )

(deftrap-inline "_CFBagCreateCopy" 
   ((allocator (:pointer :__CFAllocator))
    (theBag (:pointer :__CFBag))
   )
   (:pointer :__CFBag)
() )

(deftrap-inline "_CFBagCreateMutable" 
   ((allocator (:pointer :__CFAllocator))
    (capacity :SInt32)
    (callBacks (:pointer :CFBAGCALLBACKS))
   )
   (:pointer :__CFBag)
() )

(deftrap-inline "_CFBagCreateMutableCopy" 
   ((allocator (:pointer :__CFAllocator))
    (capacity :SInt32)
    (theBag (:pointer :__CFBag))
   )
   (:pointer :__CFBag)
() )

(deftrap-inline "_CFBagGetCount" 
   ((theBag (:pointer :__CFBag))
   )
   :SInt32
() )

(deftrap-inline "_CFBagGetCountOfValue" 
   ((theBag (:pointer :__CFBag))
    (value :pointer)
   )
   :SInt32
() )

(deftrap-inline "_CFBagContainsValue" 
   ((theBag (:pointer :__CFBag))
    (value :pointer)
   )
   :Boolean
() )

(deftrap-inline "_CFBagGetValue" 
   ((theBag (:pointer :__CFBag))
    (value :pointer)
   )
   (:pointer :void)
() )

(deftrap-inline "_CFBagGetValueIfPresent" 
   ((theBag (:pointer :__CFBag))
    (candidate :pointer)
    (value :pointer)
   )
   :Boolean
() )

(deftrap-inline "_CFBagGetValues" 
   ((theBag (:pointer :__CFBag))
    (values :pointer)
   )
   nil
() )

(deftrap-inline "_CFBagApplyFunction" 
   ((theBag (:pointer :__CFBag))
    (applier :pointer)
    (context :pointer)
   )
   nil
() )

(deftrap-inline "_CFBagAddValue" 
   ((theBag (:pointer :__CFBag))
    (value :pointer)
   )
   nil
() )

(deftrap-inline "_CFBagReplaceValue" 
   ((theBag (:pointer :__CFBag))
    (value :pointer)
   )
   nil
() )

(deftrap-inline "_CFBagSetValue" 
   ((theBag (:pointer :__CFBag))
    (value :pointer)
   )
   nil
() )

(deftrap-inline "_CFBagRemoveValue" 
   ((theBag (:pointer :__CFBag))
    (value :pointer)
   )
   nil
() )

(deftrap-inline "_CFBagRemoveAllValues" 
   ((theBag (:pointer :__CFBag))
   )
   nil
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFBAG__ */


(provide-interface "CFBag")