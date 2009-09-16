(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFUserNotification.h"
; at Sunday July 2,2006 7:27:18 pm.
; 	CFUserNotification.h
; 	Copyright (c) 2000-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFUSERNOTIFICATION__)
(defconstant $__COREFOUNDATION_CFUSERNOTIFICATION__ 1)
; #define __COREFOUNDATION_CFUSERNOTIFICATION__ 1

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFDate")

(require-interface "CoreFoundation/CFDictionary")

(require-interface "CoreFoundation/CFString")

(require-interface "CoreFoundation/CFURL")

(require-interface "CoreFoundation/CFRunLoop")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#

(def-mactype :CFUserNotificationRef (find-mactype '(:pointer :__CFUserNotification)))
;  A CFUserNotification is a notification intended to be presented to a 
; user at the console (if one is present).  This is for the use of processes
; that do not otherwise have user interfaces, but may need occasional
; interaction with a user.  There is a parallel API for this functionality
; at the System framework level, described in UNCUserNotification.h.
; 
; The contents of the notification can include a header, a message, textfields,
; a popup button, radio buttons or checkboxes, a progress indicator, and up to
; three ordinary buttons.  All of these items are optional, but a default
; button will be supplied even if not specified unless the
; kCFUserNotificationNoDefaultButtonFlag is set.
; 
; The contents of the notification are specified in the dictionary used to
; create the notification, whose keys should be taken from the list of constants
; below, and whose values should be either strings or arrays of strings
; (except for kCFUserNotificationProgressIndicatorValueKey, in which case the
; value should be a number between 0 and 1, for a "definite" progress indicator,
; or a boolean, for an "indefinite" progress indicator).  Additionally, URLs can
; optionally be supplied for an icon, a sound, and a bundle whose Localizable.strings
; files will be used to localize strings.
;     
; Certain request flags are specified when a notification is created.
; These specify an alert level for the notification, determine whether
; radio buttons or check boxes are to be used, specify which if any of these
; are checked by default, specify whether any of the textfields are to
; be secure textfields, and determine which popup item should be selected
; by default.  A timeout is also specified, which determines how long the
; notification should be supplied to the user (if zero, it will not timeout).
;     
; A CFUserNotification is dispatched for presentation when it is created.
; If any reply is required, it may be awaited in one of two ways:  either
; synchronously, using CFUserNotificationReceiveResponse, or asynchronously,
; using a run loop source.  CFUserNotificationReceiveResponse has a timeout
; parameter that determines how long it will block (zero meaning indefinitely)
; and it may be called as many times as necessary until a response arrives.
; If a notification has not yet received a response, it may be updated with
; new information, or it may be cancelled.  Notifications may not be reused.
;     
; When a response arrives, it carries with it response flags that describe
; which button was used to dismiss the notification, which checkboxes or
; radio buttons were checked, and what the selection of the popup was.
; It also carries a response dictionary, which describes the contents
; of the textfields.  

(def-mactype :CFUserNotificationCallBack (find-mactype ':pointer)); (CFUserNotificationRef userNotification , CFOptionFlags responseFlags)

(deftrap-inline "_CFUserNotificationGetTypeID" 
   (
   )
   :UInt32
() )

(deftrap-inline "_CFUserNotificationCreate" 
   ((allocator (:pointer :__CFAllocator))
    (timeout :double-float)
    (flags :UInt32)
    (error (:pointer :SInt32))
    (dictionary (:pointer :__CFDictionary))
   )
   (:pointer :__CFUserNotification)
() )

(deftrap-inline "_CFUserNotificationReceiveResponse" 
   ((userNotification (:pointer :__CFUserNotification))
    (timeout :double-float)
    (responseFlags (:pointer :CFOPTIONFLAGS))
   )
   :SInt32
() )

(deftrap-inline "_CFUserNotificationGetResponseValue" 
   ((userNotification (:pointer :__CFUserNotification))
    (key (:pointer :__CFString))
    (idx :SInt32)
   )
   (:pointer :__CFString)
() )

(deftrap-inline "_CFUserNotificationGetResponseDictionary" 
   ((userNotification (:pointer :__CFUserNotification))
   )
   (:pointer :__CFDictionary)
() )

(deftrap-inline "_CFUserNotificationUpdate" 
   ((userNotification (:pointer :__CFUserNotification))
    (timeout :double-float)
    (flags :UInt32)
    (dictionary (:pointer :__CFDictionary))
   )
   :SInt32
() )

(deftrap-inline "_CFUserNotificationCancel" 
   ((userNotification (:pointer :__CFUserNotification))
   )
   :SInt32
() )

(deftrap-inline "_CFUserNotificationCreateRunLoopSource" 
   ((allocator (:pointer :__CFAllocator))
    (userNotification (:pointer :__CFUserNotification))
    (callout :pointer)
    (order :SInt32)
   )
   (:pointer :__CFRunLoopSource)
() )
;  Convenience functions for handling the simplest and most common cases:  
; a one-way notification, and a notification with up to three buttons. 

(deftrap-inline "_CFUserNotificationDisplayNotice" 
   ((timeout :double-float)
    (flags :UInt32)
    (iconURL (:pointer :__CFURL))
    (soundURL (:pointer :__CFURL))
    (localizationURL (:pointer :__CFURL))
    (alertHeader (:pointer :__CFString))
    (alertMessage (:pointer :__CFString))
    (defaultButtonTitle (:pointer :__CFString))
   )
   :SInt32
() )

(deftrap-inline "_CFUserNotificationDisplayAlert" 
   ((timeout :double-float)
    (flags :UInt32)
    (iconURL (:pointer :__CFURL))
    (soundURL (:pointer :__CFURL))
    (localizationURL (:pointer :__CFURL))
    (alertHeader (:pointer :__CFString))
    (alertMessage (:pointer :__CFString))
    (defaultButtonTitle (:pointer :__CFString))
    (alternateButtonTitle (:pointer :__CFString))
    (otherButtonTitle (:pointer :__CFString))
    (responseFlags (:pointer :CFOPTIONFLAGS))
   )
   :SInt32
() )
;  Flags 

(defconstant $kCFUserNotificationStopAlertLevel 0)
(defconstant $kCFUserNotificationNoteAlertLevel 1)
(defconstant $kCFUserNotificationCautionAlertLevel 2)
(defconstant $kCFUserNotificationPlainAlertLevel 3)

(defconstant $kCFUserNotificationDefaultResponse 0)
(defconstant $kCFUserNotificationAlternateResponse 1)
(defconstant $kCFUserNotificationOtherResponse 2)
(defconstant $kCFUserNotificationCancelResponse 3)

(defconstant $kCFUserNotificationNoDefaultButtonFlag 32)
(defconstant $kCFUserNotificationUseRadioButtonsFlag 64)
#|
CFOptionFlags CFUserNotificationCheckBoxChecked(CFIndex i) {return ((CFOptionFlags)(1 << (8 + i)));
|#
#|
CFOptionFlags CFUserNotificationSecureTextField(CFIndex i) {return ((CFOptionFlags)(1 << (16 + i)));
|#
#|
CFOptionFlags CFUserNotificationPopUpSelection(CFIndex n) {return ((CFOptionFlags)(n << 24));
|#
;  Keys 
(def-mactype :kCFUserNotificationIconURLKey (find-mactype ':CFStringRef))
(def-mactype :kCFUserNotificationSoundURLKey (find-mactype ':CFStringRef))
(def-mactype :kCFUserNotificationLocalizationURLKey (find-mactype ':CFStringRef))
(def-mactype :kCFUserNotificationAlertHeaderKey (find-mactype ':CFStringRef))
(def-mactype :kCFUserNotificationAlertMessageKey (find-mactype ':CFStringRef))
(def-mactype :kCFUserNotificationDefaultButtonTitleKey (find-mactype ':CFStringRef))
(def-mactype :kCFUserNotificationAlternateButtonTitleKey (find-mactype ':CFStringRef))
(def-mactype :kCFUserNotificationOtherButtonTitleKey (find-mactype ':CFStringRef))
(def-mactype :kCFUserNotificationProgressIndicatorValueKey (find-mactype ':CFStringRef))
(def-mactype :kCFUserNotificationPopUpTitlesKey (find-mactype ':CFStringRef))
(def-mactype :kCFUserNotificationTextFieldTitlesKey (find-mactype ':CFStringRef))
(def-mactype :kCFUserNotificationCheckBoxTitlesKey (find-mactype ':CFStringRef))
(def-mactype :kCFUserNotificationTextFieldValuesKey (find-mactype ':CFStringRef))

; #if MAC_OS_X_VERSION_10_3 <= MAC_OS_X_VERSION_MAX_ALLOWED
(def-mactype :kCFUserNotificationPopUpSelectionKey (find-mactype ':CFStringRef)); AVAILABLE_MAC_OS_X_VERSION_10_3_AND_LATER

; #endif


; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFUSERNOTIFICATION__ */


(provide-interface "CFUserNotification")