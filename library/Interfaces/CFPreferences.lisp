(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CFPreferences.h"
; at Sunday July 2,2006 7:23:05 pm.
; 	CFPreferences.h
; 	Copyright (c) 1998-2003, Apple, Inc. All rights reserved.
; 

; #if !defined(__COREFOUNDATION_CFPREFERENCES__)
(defconstant $__COREFOUNDATION_CFPREFERENCES__ 1)
; #define __COREFOUNDATION_CFPREFERENCES__ 1

(require-interface "CoreFoundation/CFBase")

(require-interface "CoreFoundation/CFArray")

(require-interface "CoreFoundation/CFString")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
(def-mactype :kCFPreferencesAnyApplication (find-mactype ':CFStringRef))
(def-mactype :kCFPreferencesCurrentApplication (find-mactype ':CFStringRef))
(def-mactype :kCFPreferencesAnyHost (find-mactype ':CFStringRef))
(def-mactype :kCFPreferencesCurrentHost (find-mactype ':CFStringRef))
(def-mactype :kCFPreferencesAnyUser (find-mactype ':CFStringRef))
(def-mactype :kCFPreferencesCurrentUser (find-mactype ':CFStringRef))
;  NOTE: All CFPropertyListRef values returned from
;          CFPreferences API should be assumed to be immutable.
; 
; 	The "App" functions search the various sources of defaults that
; 	apply to the given application, and should never be called with
; 	kCFPreferencesAnyApplication - only kCFPreferencesCurrentApplication
; 	or an application's ID (its bundle identifier).
; 
;  Searches the various sources of application defaults to find the
; value for the given key. key must not be NULL.  If a value is found,
; it returns it; otherwise returns NULL.  Caller must release the
; returned value 

(deftrap-inline "_CFPreferencesCopyAppValue" 
   ((key (:pointer :__CFString))
    (applicationID (:pointer :__CFString))
   )
   (:pointer :void)
() )
;  Convenience to interpret a preferences value as a boolean directly.
; Returns false if the key doesn't exist, or has an improper format; under
; those conditions, keyExistsAndHasValidFormat (if non-NULL) is set to false 

(deftrap-inline "_CFPreferencesGetAppBooleanValue" 
   ((key (:pointer :__CFString))
    (applicationID (:pointer :__CFString))
    (keyExistsAndHasValidFormat (:pointer :Boolean))
   )
   :Boolean
() )
;  Convenience to interpret a preferences value as an integer directly.
; Returns 0 if the key doesn't exist, or has an improper format; under
; those conditions, keyExistsAndHasValidFormat (if non-NULL) is set to false 

(deftrap-inline "_CFPreferencesGetAppIntegerValue" 
   ((key (:pointer :__CFString))
    (applicationID (:pointer :__CFString))
    (keyExistsAndHasValidFormat (:pointer :Boolean))
   )
   :SInt32
() )
;  Sets the given value for the given key in the "normal" place for
; application preferences.  key must not be NULL.  If value is NULL,
; key is removed instead. 

(deftrap-inline "_CFPreferencesSetAppValue" 
   ((key (:pointer :__CFString))
    (value (:pointer :void))
    (applicationID (:pointer :__CFString))
   )
   nil
() )
;  Adds the preferences for the given suite to the app preferences for
;    the specified application.  To write to the suite domain, use
;    CFPreferencesSetValue(), below, using the suiteName in place
;    of the appName 

(deftrap-inline "_CFPreferencesAddSuitePreferencesToApp" 
   ((applicationID (:pointer :__CFString))
    (suiteID (:pointer :__CFString))
   )
   nil
() )

(deftrap-inline "_CFPreferencesRemoveSuitePreferencesFromApp" 
   ((applicationID (:pointer :__CFString))
    (suiteID (:pointer :__CFString))
   )
   nil
() )
;  Writes all changes in all sources of application defaults.
; Returns success or failure. 

(deftrap-inline "_CFPreferencesAppSynchronize" 
   ((applicationID (:pointer :__CFString))
   )
   :Boolean
() )
;  The primitive get mechanism; all arguments must be non-NULL
; (use the constants above for common values).  Only the exact
; location specified by app-user-host is searched.  The returned
; CFType must be released by the caller when it is finished with it. 

(deftrap-inline "_CFPreferencesCopyValue" 
   ((key (:pointer :__CFString))
    (applicationID (:pointer :__CFString))
    (userName (:pointer :__CFString))
    (hostName (:pointer :__CFString))
   )
   (:pointer :void)
() )
;  Convenience to fetch multiple keys at once.  Keys in 
; keysToFetch that are not present in the returned dictionary
; are not present in the domain.  If keysToFetch is NULL, all
; keys are fetched. 

(deftrap-inline "_CFPreferencesCopyMultiple" 
   ((keysToFetch (:pointer :__CFArray))
    (applicationID (:pointer :__CFString))
    (userName (:pointer :__CFString))
    (hostName (:pointer :__CFString))
   )
   (:pointer :__CFDictionary)
() )
;  The primitive set function; all arguments except value must be
; non-NULL.  If value is NULL, the given key is removed 

(deftrap-inline "_CFPreferencesSetValue" 
   ((key (:pointer :__CFString))
    (value (:pointer :void))
    (applicationID (:pointer :__CFString))
    (userName (:pointer :__CFString))
    (hostName (:pointer :__CFString))
   )
   nil
() )
;  Convenience to set multiple values at once.  Behavior is undefined
; if a key is in both keysToSet and keysToRemove 

(deftrap-inline "_CFPreferencesSetMultiple" 
   ((keysToSet (:pointer :__CFDictionary))
    (keysToRemove (:pointer :__CFArray))
    (applicationID (:pointer :__CFString))
    (userName (:pointer :__CFString))
    (hostName (:pointer :__CFString))
   )
   nil
() )

(deftrap-inline "_CFPreferencesSynchronize" 
   ((applicationID (:pointer :__CFString))
    (userName (:pointer :__CFString))
    (hostName (:pointer :__CFString))
   )
   :Boolean
() )
;  Constructs and returns the list of the name of all applications
; which have preferences in the scope of the given user and host.
; The returned value must be released by the caller; neither argument
; may be NULL. 

(deftrap-inline "_CFPreferencesCopyApplicationList" 
   ((userName (:pointer :__CFString))
    (hostName (:pointer :__CFString))
   )
   (:pointer :__CFArray)
() )
;  Constructs and returns the list of all keys set in the given
; location.  The returned value must be released by the caller;
; all arguments must be non-NULL 

(deftrap-inline "_CFPreferencesCopyKeyList" 
   ((applicationID (:pointer :__CFString))
    (userName (:pointer :__CFString))
    (hostName (:pointer :__CFString))
   )
   (:pointer :__CFArray)
() )

; #if MAC_OS_X_VERSION_10_2 <= MAC_OS_X_VERSION_MAX_ALLOWED
;  Function to determine whether or not a given key has been imposed on the
; user - In cases where machines and/or users are under some kind of management,
; callers should use this function to determine whether or not to disable UI elements
; corresponding to those preference keys. 

(deftrap-inline "_CFPreferencesAppValueIsForced" 
   ((key (:pointer :__CFString))
    (applicationID (:pointer :__CFString))
   )
   :Boolean
() )

; #endif


; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* ! __COREFOUNDATION_CFPREFERENCES__ */


(provide-interface "CFPreferences")