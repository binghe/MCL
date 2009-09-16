(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DRCoreNotifications.h"
; at Sunday July 2,2006 7:27:37 pm.
; 
;      File:       DiscRecordingEngine/DRCoreNotifications.h
;  
;      Contains:   Disc Recording notification interfaces.
;  
;       Version:   Technology: Mac OS X
;                  Release:    Mac OS X
;  
;     Copyright:   (c) 2002-2003 by Apple Computer, Inc., all rights reserved
;  
;      Bugs?:      For bug reports, consult the following page on
;                  the World Wide Web:
;  
;                      http://developer.apple.com/bugreporter/
;  
; 
; #ifndef _H_DRCoreNotifications
; #define _H_DRCoreNotifications

; #if PRAGMA_ONCE
#| ; #pragma once
 |#

; #endif

; #ifndef _H_DRCoreObject
#| #|
#include <DiscRecordingEngineDRCoreObject.h>
#endif
|#
 |#
; #ifndef __AVAILABILITYMACROS__

(require-interface "AvailabilityMacros")

; #endif

; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; !
; 	@typedef DRNotificationCenterRef
; 	@abstract	The type of a reference to a DRNotificationCenter object.
; 

(def-mactype :DRNotificationCenterRef (find-mactype '(:pointer :__DRNotificationCenter)))
; !
;     @typedef 	DRNotificationCallback
;     @abstract	Delivers a notification.
;     @param 		center		The notification center that this callback is associated with.
;     @param		observer	The observer specified when this callback was added.
;     @param		name		The notification name.
;     @param		object		The object that this notification is associated with, or
;     						<tt>NULL</tt> when there is no associated object.
;     @param		info		A dictionary object containing additional
;     						notification information, or <tt>NULL</tt> when
;     						there is no associated object.
; 

(def-mactype :DRNotificationCallback (find-mactype ':pointer)); (DRNotificationCenterRef center , void * observer , CFStringRef name , DRTypeRef object , CFDictionaryRef info)
; !
; 	@function	DRNotificationCenterGetTypeID
; 	@abstract	Returns the type identifier of all DRNotificationCenter instances.
; 

(deftrap-inline "_DRNotificationCenterGetTypeID" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   :UInt32
() )
; !
; 	@function	DRNotificationCenterCreate
; 	@abstract	Creates a notification center that can be used to register for
; 				and receive asyncronous notifications.
; 	@result		Returns reference to a new DRNotificationCenter object.
; 

(deftrap-inline "_DRNotificationCenterCreate" 
   (
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__DRNotificationCenter)
() )
; !
; 	@function	DRNotificationCenterCreateRunLoopSource
; 	@abstract	Creates a run-loop source object for a notification center.
; 	@param		center	The notification center that the new run-loop source 
; 						object is for.
; 								
; 						If this parameter is not a valid DRNotificationCenter
; 						object, the behavior is undefined. 
; 	@result				Returns a reference to a CFRunLoopSource object.
; 

(deftrap-inline "_DRNotificationCenterCreateRunLoopSource" 
   ((center (:pointer :__DRNotificationCenter))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   (:pointer :__CFRunLoopSource)
() )
; !
; 	@function	DRNotificationCenterAddObserver
; 	@abstract	Adds an observer callback for a notification center.
;     @param 		center		The notification center that the new observer callback 
;     						is for.
;     @param 		observer	The observer callback to add, which gets passed to the callback.
;     @param 		callback	The observer callback to use for notification delivery.
;     @param 		name		The notification name for adding the observer.
;     @param 		object		The object the notification name is associated with.
; 

(deftrap-inline "_DRNotificationCenterAddObserver" 
   ((center (:pointer :__DRNotificationCenter))
    (observer :pointer)
    (callback :pointer)
    (name (:pointer :__CFString))
    (object (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; !
; 	@function	DRNotificationCenterRemoveObserver
; 	@abstract	Removes an observer callback from a notification center.
;     @param 		center		The notification center that the observer callback will be removed from.
;     @param 		observer	The observer callback to remove.
;     @param 		name		The notification name for removing the observer callback.
;     @param 		object		The object the notification name is associated with.
; 

(deftrap-inline "_DRNotificationCenterRemoveObserver" 
   ((center (:pointer :__DRNotificationCenter))
    (observer :pointer)
    (name (:pointer :__CFString))
    (object (:pointer :void))
   )                                            ; AVAILABLE_MAC_OS_X_VERSION_10_2_AND_LATER
   nil
() )
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _H_DRCoreNotifications */


(provide-interface "DRCoreNotifications")