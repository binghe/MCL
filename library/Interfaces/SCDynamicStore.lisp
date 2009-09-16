(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SCDynamicStore.h"
; at Sunday July 2,2006 7:31:28 pm.
; 
;  * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * This file contains Original Code and/or Modifications of Original Code
;  * as defined in and that are subject to the Apple Public Source License
;  * Version 2.0 (the 'License'). You may not use this file except in
;  * compliance with the License. Please obtain a copy of the License at
;  * http://www.opensource.apple.com/apsl/ and read it before using this
;  * file.
;  * 
;  * The Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
;  * Please see the License for the specific language governing rights and
;  * limitations under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; #ifndef _SCDYNAMICSTORE_H
; #define _SCDYNAMICSTORE_H

(require-interface "sys/cdefs")

(require-interface "sys/syslog")

(require-interface "mach/message")

(require-interface "CoreFoundation/CoreFoundation")
; !
; 	@header SCDynamicStore
; 	The SystemConfiguration framework provides access to the
; 	data used to configure a running system.  The APIs provided
; 	by this framework communicate with the "configd" daemon.
; 
; 	The "configd" daemon manages a "dynamic store" reflecting the
; 	desired configuration settings as well as the current state
; 	of the system.  The daemon provides a notification mechanism
; 	for user-level processes that need to be aware of changes
; 	made to the data.  Lastly, the daemon loads a number of
; 	bundles (or plug-ins) that monitor low-level kernel events
; 	and, via a set of policy modules, keep the state data up
; 	to date.
;  
; !
; 	@typedef SCDynamicStoreRef
; 	@discussion This is the handle to an open "dynamic store" session
; 		with the system configuration daemon.
;  

(def-mactype :SCDynamicStoreRef (find-mactype '(:pointer :__SCDynamicStore)))
; !
; 	@typedef SCDynamicStoreContext
;  
(defrecord SCDynamicStoreContext
   (version :SInt32)
   (info :pointer)
   (retain (:pointer :callback))                ;(void * (const void * info))
   (release (:pointer :callback))               ;(void (const void * info))
   (copyDescription (:pointer :callback))       ;(CFStringRef (const void * info))
)
; !
; 	@typedef SCDynamicStoreCallBack
; 	@discussion Type of the callback function used when a
; 		dynamic store change is delivered.
; 	@param store The "dynamic store" session.
; 	@param changedKeys The list of changed keys.
; 	@param info ....
;  

(def-mactype :SCDynamicStoreCallBack (find-mactype ':pointer)); (SCDynamicStoreRef store , CFArrayRef changedKeys , void * info)
; !
; 	@function SCDynamicStoreGetTypeID
; 	Returns the type identifier of all SCDynamicStore instances.
;  

(deftrap-inline "_SCDynamicStoreGetTypeID" 
   (
   )
   :UInt32
() )
; !
; 	@function SCDynamicStoreCreate
; 	@discussion Creates a new session used to interact with the dynamic
; 		store maintained by the SystemConfiguration server.
; 	@param allocator The CFAllocator which should be used to allocate
; 		memory for the local "dynamic store" and its storage for
; 		values.
; 		This parameter may be NULL in which case the current
; 		default CFAllocator is used. If this reference is not
; 		a valid CFAllocator, the behavior is undefined.
; 	@param name A string that describes the name of the calling
; 		process or plug-in of the caller.
; 	@param callout The function to be called when a watched value
; 		in the "dynamic store" is changed.
; 		A NULL value can be specified if no callouts are
; 		desired.
; 	@param context The SCDynamicStoreContext associated with the callout.
; 	@result A reference to the new SCDynamicStore.
;  

(deftrap-inline "_SCDynamicStoreCreate" 
   ((allocator (:pointer :__CFAllocator))
    (name (:pointer :__CFString))
    (callout :pointer)
    (context (:pointer :SCDYNAMICSTORECONTEXT))
   )
   (:pointer :__SCDynamicStore)
() )
; !
; 	@function SCDynamicStoreCreateRunLoopSource
; 	@discussion Creates a new session used to interact with the dynamic
; 		store maintained by the SystemConfiguration server.
; 	@param allocator The CFAllocator which should be used to allocate
; 		memory for the local "dynamic store" and its storage for
; 		values.
; 		This parameter may be NULL in which case the current
; 		default CFAllocator is used. If this reference is not
; 		a valid CFAllocator, the behavior is undefined.
; 	@param store The "dynamic store" session.
; 	@param order On platforms which support it, this parameter
; 		determines the order in which the sources which are
; 		ready to be processed are handled.  A lower order
; 		number causes processing before higher order number
; 		sources. It is inadvisable to depend on the order
; 		number for any architectural or design aspect of
; 		code. In the absence of any reason to do otherwise,
; 		zero should be used.
; 	@result A reference to the new CFRunLoopSource.
; 		You must release the returned value.
; 
;  

(deftrap-inline "_SCDynamicStoreCreateRunLoopSource" 
   ((allocator (:pointer :__CFAllocator))
    (store (:pointer :__SCDynamicStore))
    (order :SInt32)
   )
   (:pointer :__CFRunLoopSource)
() )
; !
; 	@function SCDynamicStoreCopyKeyList
; 	@discussion Returns an array of CFString keys representing the
; 		configuration "dynamic store" entries that match a
; 		specified pattern.
; 	@param store The "dynamic store" session.
; 	@param pattern A regex(3) regular expression pattern that
; 		will be used to match the "dynamic store" keys.
; 	@result The list of matching keys.
; 		You must release the returned value.
; 		A NULL value will be returned if the list could not be obtained.
;  

(deftrap-inline "_SCDynamicStoreCopyKeyList" 
   ((store (:pointer :__SCDynamicStore))
    (pattern (:pointer :__CFString))
   )
   (:pointer :__CFArray)
() )
; !
; 	@function SCDynamicStoreAddValue
; 	@discussion Adds the key-value pair to the "dynamic store" if no
; 		such key already exists.
; 	@param store The "dynamic store" session.
; 	@param key The key of the value to add to the "dynamic store".
; 	@param value The value to add to the "dynamic store".
; 	@result TRUE if the key was added; FALSE if the key was already
; 		present in the "dynamic store" or if an error was encountered.
;  

(deftrap-inline "_SCDynamicStoreAddValue" 
   ((store (:pointer :__SCDynamicStore))
    (key (:pointer :__CFString))
    (value (:pointer :void))
   )
   :Boolean
() )
; !
; 	@function SCDynamicStoreAddTemporaryValue
; 	@discussion Adds the key-value pair on a temporary basis to the
; 		"dynamic store" if no such key already exists.  This entry
; 		will, unless updated by another session, automatically be
; 		removed when the session is closed.
; 	@param store The "dynamic store" session.
; 	@param key The key of the value to add to the "dynamic store".
; 	@param value The value to add to the "dynamic store".
; 	@result TRUE if the key was added; FALSE if the key was already
; 		present in the "dynamic store" or if an error was encountered.
;  

(deftrap-inline "_SCDynamicStoreAddTemporaryValue" 
   ((store (:pointer :__SCDynamicStore))
    (key (:pointer :__CFString))
    (value (:pointer :void))
   )
   :Boolean
() )
; !
; 	@function SCDynamicStoreCopyValue
; 	@discussion Obtains a value from the "dynamic store" for the
; 		specified key.
; 	@param store The "dynamic store" session.
; 	@param key The key you wish to obtain.
; 	@result The value from the store that is associated with the
; 		given key.  The value is returned as a Core Foundation
; 		Property List data type.
; 		You must release the returned value.
; 		If no value was located, NULL is returned.
;  

(deftrap-inline "_SCDynamicStoreCopyValue" 
   ((store (:pointer :__SCDynamicStore))
    (key (:pointer :__CFString))
   )
   (:pointer :void)
() )
; !
; 	@function SCDynamicStoreCopyMultiple
; 	@discussion Fetches multiple values in the "dynamic store".
; 	@param store The "dynamic store" session.
; 	@param keys The keys to be fetched; NULL if no specific keys
; 		are requested.
; 	@param patterns The regex(3) pattern strings to be fetched; NULL
; 		if no key patterns are requested.
; 	@result A dictionary containing the specific keys which were found
; 		in the "dynamic store" and any keys which matched the specified
; 		patterns; NULL is returned if an error was encountered.
; 		You must release the returned value.
;  

(deftrap-inline "_SCDynamicStoreCopyMultiple" 
   ((store (:pointer :__SCDynamicStore))
    (keys (:pointer :__CFArray))
    (patterns (:pointer :__CFArray))
   )
   (:pointer :__CFDictionary)
() )
; !
; 	@function SCDynamicStoreSetValue
; 	@discussion Adds or replaces a value in the "dynamic store" for
; 		the specified key.
; 	@param store The "dynamic store" session.
; 	@param key The key you wish to set.
; 	@param value The value to add to or replace in the "dynamic store".
; 	@result TRUE if the key was updated; FALSE if an error was encountered.
;  

(deftrap-inline "_SCDynamicStoreSetValue" 
   ((store (:pointer :__SCDynamicStore))
    (key (:pointer :__CFString))
    (value (:pointer :void))
   )
   :Boolean
() )
; !
; 	@function SCDynamicStoreSetMultiple
; 	@discussion Updates multiple values in the "dynamic store".
; 	@param store The "dynamic store" session.
; 	@param keysToSet Key/value pairs you wish to set into the "dynamic store".
; 	@param keysToRemove A list of keys you wish to remove from the "dynamic store".
; 	@param keysToNotify A list of keys to flag as changed (without actually changing the data).
; 	@result TRUE if the dynamic store updates were successful; FALSE if an error was encountered.
;  

(deftrap-inline "_SCDynamicStoreSetMultiple" 
   ((store (:pointer :__SCDynamicStore))
    (keysToSet (:pointer :__CFDictionary))
    (keysToRemove (:pointer :__CFArray))
    (keysToNotify (:pointer :__CFArray))
   )
   :Boolean
() )
; !
; 	@function SCDynamicStoreRemoveValue
; 	@discussion Removes the value of the specified key from the
; 		"dynamic store".
; 	@param store The "dynamic store" session.
; 	@param key The key of the value you wish to remove.
; 	@result TRUE if the key was removed; FALSE if no value was
; 		located or an error was encountered.
;  

(deftrap-inline "_SCDynamicStoreRemoveValue" 
   ((store (:pointer :__SCDynamicStore))
    (key (:pointer :__CFString))
   )
   :Boolean
() )
; !
; 	@function SCDynamicStoreNotifyValue
; 	@discussion Triggers a notification to be delivered for the
; 		specified key in the dynamic store.
; 	@param store The "dynamic store" session.
; 	@param key The key which should be flagged as changed (without actually changing the data).
; 	@result TRUE if the value was updated; FALSE if an error was encountered.
;  

(deftrap-inline "_SCDynamicStoreNotifyValue" 
   ((store (:pointer :__SCDynamicStore))
    (key (:pointer :__CFString))
   )
   :Boolean
() )
; !
; 	@function SCDynamicStoreSetNotificationKeys
; 	@discussion Specifies a set of specific keys and key patterns
; 		which should be monitored for changes.
; 	@param store The "dynamic store" session being watched.
; 	@param keys The keys to be monitored; NULL if no specific keys
; 		are to be monitored.
; 	@param patterns The regex(3) pattern strings to be monitored; NULL
; 		if no key patterns are to be monitored.
; 	@result TRUE if the monitored keys were set; FALSE if an error
; 		was encountered.
;  

(deftrap-inline "_SCDynamicStoreSetNotificationKeys" 
   ((store (:pointer :__SCDynamicStore))
    (keys (:pointer :__CFArray))
    (patterns (:pointer :__CFArray))
   )
   :Boolean
() )
; !
; 	@function SCDynamicStoreCopyNotifiedKeys
; 	@discussion Returns an array of CFString keys representing the
; 		"dynamic store" entries that have changed since this
; 		function was last called.
; 	@param store The "dynamic store" session.
; 	@result The list of changed keys.
; 		You must release the returned value.
; 		A NULL value will be returned if the list could not be obtained.
;  

(deftrap-inline "_SCDynamicStoreCopyNotifiedKeys" 
   ((store (:pointer :__SCDynamicStore))
   )
   (:pointer :__CFArray)
() )

; #endif /* _SCDYNAMICSTORE_H */


(provide-interface "SCDynamicStore")