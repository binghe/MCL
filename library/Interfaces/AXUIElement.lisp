(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:AXUIElement.h"
; at Sunday July 2,2006 7:24:41 pm.
; 
;  *  AXUIElement.h
;  *
;  *  Copyright (c) 2002 Apple Computer, Inc. All rights reserved.
;  *
;  
; #ifndef __AXUIELEMENT__
; #define __AXUIELEMENT__
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(require-interface "CoreFoundation/CoreFoundation")

(require-interface "ApplicationServices/ApplicationServices")

(deftrap-inline "_AXAPIEnabled" 
   ((ARG2 (:nil :nil))
   )
   :Boolean
() )

(def-mactype :AXUIElementRef (find-mactype '(:pointer :__AXUIElement)))

(deftrap-inline "_AXUIElementGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_AXUIElementCopyAttributeNames" 
   ((element (:pointer :__AXUIElement))
    (names (:pointer :CFArrayRef))
   )
   :SInt32
() )

(deftrap-inline "_AXUIElementCopyAttributeValue" 
   ((element (:pointer :__AXUIElement))
    (attribute (:pointer :__CFString))
    (value (:pointer :CFTypeRef))
   )
   :SInt32
() )

(deftrap-inline "_AXUIElementGetAttributeValueCount" 
   ((element (:pointer :__AXUIElement))
    (attribute (:pointer :__CFString))
    (count (:pointer :CFIndex))
   )
   :SInt32
() )

(deftrap-inline "_AXUIElementCopyAttributeValues" 
   ((element (:pointer :__AXUIElement))
    (attribute (:pointer :__CFString))
    (index :SInt32)
    (maxValues :SInt32)
    (values (:pointer :CFArrayRef))
   )
   :SInt32
() )

(deftrap-inline "_AXUIElementIsAttributeSettable" 
   ((element (:pointer :__AXUIElement))
    (attribute (:pointer :__CFString))
    (settable (:pointer :Boolean))
   )
   :SInt32
() )

(deftrap-inline "_AXUIElementSetAttributeValue" 
   ((element (:pointer :__AXUIElement))
    (attribute (:pointer :__CFString))
    (value (:pointer :void))
   )
   :SInt32
() )

(deftrap-inline "_AXUIElementCopyParameterizedAttributeNames" 
   ((element (:pointer :__AXUIElement))
    (names (:pointer :CFArrayRef))
   )
   :SInt32
() )

(deftrap-inline "_AXUIElementCopyParameterizedAttributeValue" 
   ((element (:pointer :__AXUIElement))
    (parameterizedAttribute (:pointer :__CFString))
    (parameter (:pointer :void))
    (result (:pointer :CFTypeRef))
   )
   :SInt32
() )

(deftrap-inline "_AXUIElementCopyActionNames" 
   ((element (:pointer :__AXUIElement))
    (names (:pointer :CFArrayRef))
   )
   :SInt32
() )

(deftrap-inline "_AXUIElementCopyActionDescription" 
   ((element (:pointer :__AXUIElement))
    (action (:pointer :__CFString))
    (description (:pointer :CFStringRef))
   )
   :SInt32
() )

(deftrap-inline "_AXUIElementPerformAction" 
   ((element (:pointer :__AXUIElement))
    (action (:pointer :__CFString))
   )
   :SInt32
() )

(deftrap-inline "_AXUIElementCopyElementAtPosition" 
   ((application (:pointer :__AXUIElement))
    (x :single-float)
    (y :single-float)
    (element (:pointer :AXUIELEMENTREF))
   )
   :SInt32
() )

(deftrap-inline "_AXUIElementCreateApplication" 
   ((pid :SInt32)
   )
   (:pointer :__AXUIElement)
() )

(deftrap-inline "_AXUIElementCreateSystemWide" 
   (
   )
   (:pointer :__AXUIElement)
() )

(deftrap-inline "_AXUIElementGetPid" 
   ((element (:pointer :__AXUIElement))
    (pid (:pointer :PID_T))
   )
   :SInt32
() )
;  see CGRemoteOperation.h for documentation of parameters
;  you can only pass the root or application uielement

(deftrap-inline "_AXUIElementPostKeyboardEvent" 
   ((application (:pointer :__AXUIElement))
    (keyChar :UInt16)
    (virtualKey :UInt16)
    (keyDown :Boolean)
   )
   :SInt32
() )
;  Notification APIs

(def-mactype :AXObserverRef (find-mactype '(:pointer :__AXObserver)))

(def-mactype :AXObserverCallback (find-mactype ':pointer)); (AXObserverRef observer , AXUIElementRef element , CFStringRef notification , void * refcon)

(deftrap-inline "_AXObserverGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_AXObserverCreate" 
   ((application :SInt32)
    (callback :pointer)
    (outObserver (:pointer :AXOBSERVERREF))
   )
   :SInt32
() )

(deftrap-inline "_AXObserverAddNotification" 
   ((observer (:pointer :__AXObserver))
    (element (:pointer :__AXUIElement))
    (notification (:pointer :__CFString))
    (refcon :pointer)
   )
   :SInt32
() )

(deftrap-inline "_AXObserverRemoveNotification" 
   ((observer (:pointer :__AXObserver))
    (element (:pointer :__AXUIElement))
    (notification (:pointer :__CFString))
   )
   :SInt32
() )

(deftrap-inline "_AXObserverGetRunLoopSource" 
   ((observer (:pointer :__AXObserver))
   )
   (:pointer :__CFRunLoopSource)
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif // __AXUIELEMENT__


(provide-interface "AXUIElement")