(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFNotificationCenter.h"
; at Sunday July 2,2006 7:23:04 pm.
; 	CFNotificationCenter.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFNOTIFICATIONCENTER__)
(defconstant $__COREFOUNDATION_CFNOTIFICATIONCENTER__ 1)
; #define __COREFOUNDATION_CFNOTIFICATIONCENTER__ 1

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFDictionary")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(def-mactype :CFNotificationCenterRef (find-mactype '(:pointer :__CFNotificationCenter)))

(def-mactype :CFNotificationCallback (find-mactype ':pointer)); (CFNotificationCenterRef center , void * observer , CFStringRef name , const void * object , CFDictionaryRef userInfo)

(defconstant $CFNotificationSuspensionBehaviorDrop 1);  The server will not queue any notifications with this name and object while the process/app is in the background.

(defconstant $CFNotificationSuspensionBehaviorCoalesce 2);  The server will only queue the last notification of the specified name and object; earlier notifications are dropped. 

(defconstant $CFNotificationSuspensionBehaviorHold 3);  The server will hold all matching notifications until the queue has been filled (queue size determined by the server) at which point the server may flush queued notifications.

(defconstant $CFNotificationSuspensionBehaviorDeliverImmediately 4);  The server will deliver notifications matching this registration whether or not the process is in the background.  When a notification with this suspension behavior is matched, it has the effect of first flushing any queued notifications.

(def-mactype :CFNotificationSuspensionBehavior (find-mactype ':SINT32))

(deftrap-inline "_CFNotificationCenterGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFNotificationCenterGetDistributedCenter" 
   (
   )
   (:pointer :__CFNotificationCenter)
() )

(deftrap-inline "_CFNotificationCenterAddObserver" 
   ((center (:pointer :__CFNotificationCenter))
    (observer :pointer)
    (callBack :pointer)
    (name (:pointer :__CFString))
    (object :pointer)
    (suspensionBehavior :SInt32)
   )
   nil
() )

(deftrap-inline "_CFNotificationCenterRemoveObserver" 
   ((center (:pointer :__CFNotificationCenter))
    (observer :pointer)
    (name (:pointer :__CFString))
    (object :pointer)
   )
   nil
() )

(deftrap-inline "_CFNotificationCenterRemoveEveryObserver" 
   ((center (:pointer :__CFNotificationCenter))
    (observer :pointer)
   )
   nil
() )

(deftrap-inline "_CFNotificationCenterPostNotification" 
   ((center (:pointer :__CFNotificationCenter))
    (name (:pointer :__CFString))
    (object :pointer)
    (userInfo (:pointer :__CFDictionary))
    (deliverImmediately :Boolean)
   )
   nil
() )

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED

(defconstant $kCFNotificationDeliverImmediately 1)
(defconstant $kCFNotificationPostToAllSessions 2)

(deftrap-inline "_CFNotificationCenterPostNotificationWithOptions" 
   ((center (:pointer :__CFNotificationCenter))
    (name (:pointer :__CFString))
    (object :pointer)
    (userInfo (:pointer :__CFDictionary))
    (options :UInt32)
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER
   :void
() )

; #endif


; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFNOTIFICATIONCENTER__ */


(provide-interface "CFNotificationCenter")