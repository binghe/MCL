(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFMachPort.h"
; at Sunday July 2,2006 7:27:16 pm.
; 	CFMachPort.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFMACHPORT__)
(defconstant $__COREFOUNDATION_CFMACHPORT__ 1)
; #define __COREFOUNDATION_CFMACHPORT__ 1

; #if defined(__MACH__)
#| |#

(require-interface "CoreFoundation/CFRunLoop")

#||#

(require-interface "mach/port")

#|
; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(def-mactype :CFMachPortRef (find-mactype '(:pointer :__CFMachPort)))
(defrecord CFMachPortContext
   (version :SInt32)
   (info :pointer)
   (retain (:pointer :callback))                ;(void * (const void * info))
   (release (:pointer :callback))               ;(void (const void * info))
   (copyDescription (:pointer :callback))       ;(CFStringRef (const void * info))
)

(def-mactype :CFMachPortCallBack (find-mactype ':pointer)); (CFMachPortRef port , void * msg , CFIndex size , void * info)

(def-mactype :CFMachPortInvalidationCallBack (find-mactype ':pointer)); (CFMachPortRef port , void * info)

(deftrap-inline "_CFMachPortGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFMachPortCreate" 
   ((allocator (:pointer :__CFAllocator))
    (callout :CFMachPortCallBack)
    (context (:pointer :cfmachportcontext))
    (shouldFreeInfo (:pointer :Boolean))
   )
   :CFMachPortRef
() )

(deftrap-inline "_CFMachPortCreateWithPort" 
   ((allocator (:pointer :__CFAllocator))
    (portNum :pointer)
    (callout :CFMachPortCallBack)
    (context (:pointer :cfmachportcontext))
    (shouldFreeInfo (:pointer :Boolean))
   )
   :CFMachPortRef
() )

(deftrap-inline "_CFMachPortGetPort" 
   ((port :CFMachPortRef)
   )
   :pointer
() )

(deftrap-inline "_CFMachPortGetContext" 
   ((port :CFMachPortRef)
    (context (:pointer :cfmachportcontext))
   )
   nil
() )

(deftrap-inline "_CFMachPortInvalidate" 
   ((port :CFMachPortRef)
   )
   nil
() )

(deftrap-inline "_CFMachPortIsValid" 
   ((port :CFMachPortRef)
   )
   :Boolean
() )

(deftrap-inline "_CFMachPortGetInvalidationCallBack" 
   ((port :CFMachPortRef)
   )
   :CFMachPortInvalidationCallBack
() )

(deftrap-inline "_CFMachPortSetInvalidationCallBack" 
   ((port :CFMachPortRef)
    (callout :CFMachPortInvalidationCallBack)
   )
   nil
() )

(deftrap-inline "_CFMachPortCreateRunLoopSource" 
   ((allocator (:pointer :__CFAllocator))
    (port :CFMachPortRef)
    (order :SInt32)
   )
   (:pointer :__CFRunLoopSource)
() )

; #if defined(__cplusplus)
#|
}
#endif
|#
 |#

; #endif /* __MACH__ */


; #endif /* ! __COREFOUNDATION_CFMACHPORT__ */


(provide-interface "CFMachPort")