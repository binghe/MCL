(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFMessagePort.h"
; at Sunday July 2,2006 7:27:16 pm.
; 	CFMessagePort.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFMESSAGEPORT__)
(defconstant $__COREFOUNDATION_CFMESSAGEPORT__ 1)
; #define __COREFOUNDATION_CFMESSAGEPORT__ 1

(require-interface "CoreFoundation/CFString")

(require-interface "CoreFoundation/CFRunLoop")

(require-interface "CoreFoundation/CFData")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(def-mactype :CFMessagePortRef (find-mactype '(:pointer :__CFMessagePort)))

(defconstant $kCFMessagePortSuccess 0)
(defconstant $kCFMessagePortSendTimeout -1)
(defconstant $kCFMessagePortReceiveTimeout -2)
(defconstant $kCFMessagePortIsInvalid -3)
(defconstant $kCFMessagePortTransportError -4)
(defrecord CFMessagePortContext
   (version :SInt32)
   (info :pointer)
   (retain (:pointer :callback))                ;(void * (const void * info))
   (release (:pointer :callback))               ;(void (const void * info))
   (copyDescription (:pointer :callback))       ;(CFStringRef (const void * info))
)

(def-mactype :CFMessagePortCallBack (find-mactype ':pointer)); (CFMessagePortRef local , SInt32 msgid , CFDataRef data , void * info)
;  If callout wants to keep a hold of the data past the return of the callout, it must COPY the data. This includes the case where the data is given to some routine which _might_ keep a hold of it; System will release returned CFData. 

(def-mactype :CFMessagePortInvalidationCallBack (find-mactype ':pointer)); (CFMessagePortRef ms , void * info)

(deftrap-inline "_CFMessagePortGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFMessagePortCreateLocal" 
   ((allocator (:pointer :__CFAllocator))
    (name (:pointer :__CFString))
    (callout :pointer)
    (context (:pointer :CFMESSAGEPORTCONTEXT))
    (shouldFreeInfo (:pointer :Boolean))
   )
   (:pointer :__CFMessagePort)
() )

(deftrap-inline "_CFMessagePortCreateRemote" 
   ((allocator (:pointer :__CFAllocator))
    (name (:pointer :__CFString))
   )
   (:pointer :__CFMessagePort)
() )

(deftrap-inline "_CFMessagePortIsRemote" 
   ((ms (:pointer :__CFMessagePort))
   )
   :Boolean
() )

(deftrap-inline "_CFMessagePortGetName" 
   ((ms (:pointer :__CFMessagePort))
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFMessagePortSetName" 
   ((ms (:pointer :__CFMessagePort))
    (newName (:pointer :__CFString))
   )
   :Boolean
() )

(deftrap-inline "_CFMessagePortGetContext" 
   ((ms (:pointer :__CFMessagePort))
    (context (:pointer :CFMESSAGEPORTCONTEXT))
   )
   nil
() )

(deftrap-inline "_CFMessagePortInvalidate" 
   ((ms (:pointer :__CFMessagePort))
   )
   nil
() )

(deftrap-inline "_CFMessagePortIsValid" 
   ((ms (:pointer :__CFMessagePort))
   )
   :Boolean
() )

(deftrap-inline "_CFMessagePortGetInvalidationCallBack" 
   ((ms (:pointer :__CFMessagePort))
   )
   :pointer
() )

(deftrap-inline "_CFMessagePortSetInvalidationCallBack" 
   ((ms (:pointer :__CFMessagePort))
    (callout :pointer)
   )
   nil
() )
;  NULL replyMode argument means no return value expected, dont wait for it 

(deftrap-inline "_CFMessagePortSendRequest" 
   ((remote (:pointer :__CFMessagePort))
    (msgid :SInt32)
    (data (:pointer :__CFData))
    (sendTimeout :double-float)
    (rcvTimeout :double-float)
    (replyMode (:pointer :__CFString))
    (returnData (:pointer :CFDataRef))
   )
   :SInt32
() )

(deftrap-inline "_CFMessagePortCreateRunLoopSource" 
   ((allocator (:pointer :__CFAllocator))
    (local (:pointer :__CFMessagePort))
    (order :SInt32)
   )
   (:pointer :__CFRunLoopSource)
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFMESSAGEPORT__ */


(provide-interface "CFMessagePort")