(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SystemConfiguration.h"
; at Sunday July 2,2006 7:31:31 pm.
; 
;  * Copyright (c) 2000-2003 Apple Computer, Inc. All rights reserved.
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
; #ifndef _SYSTEMCONFIGURATION_H
; #define _SYSTEMCONFIGURATION_H

(require-interface "sys/cdefs")

(require-interface "CoreFoundation/CoreFoundation")
; !
; 	@header SystemConfiguration.h
; 	The SystemConfiguration framework provides access to the
; 	data used to configure a running system.  The APIs provided
; 	by this framework communicate with the "configd" daemon.
; 
; 	The "configd" daemon manages a "dynamic store" reflecting the
; 	desired configuration settings as well as the current state
; 	of the system.  The daemon provides a notification mechanism
; 	for user-level processes which need to be aware of changes
; 	made to the data.  Lastly, the daemon loads a number of
; 	bundles (or plug-ins) that monitor low-level kernel events
; 	and, via a set of policy modules, keep the state data up
; 	to date.
;  
; !
; 	@enum
; 	@discussion Returned status codes.
; 
; 	@constant kSCStatusOK			Success
; 	@constant kSCStatusFailed		Non-specific Failure
; 	@constant kSCStatusInvalidArgument	Invalid argument
; 	@constant kSCStatusAccessError		Permission denied
; 	@constant kSCStatusNoKey		No such key
; 	@constant kSCStatusKeyExists		Data associated with key already defined
; 	@constant kSCStatusLocked		Lock already held
; 	@constant kSCStatusNeedLock		Lock required for this operation
; 
; 	@constant kSCStatusNoStoreSession	Configuration daemon session not active
; 	@constant kSCStatusNoStoreServer	Configuration daemon not (no longer) available
; 	@constant kSCStatusNotifierActive	Notifier is currently active
; 
; 	@constant kSCStatusNoPrefsSession	Preference session not active
; 	@constant kSCStatusPrefsBusy		Preferences update currently in progress
; 	@constant kSCStatusNoConfigFile		Configuration file not found
; 	@constant kSCStatusNoLink		No such link
; 	@constant kSCStatusStale		Write attempted on stale version of object
; 	@constant kSCStatusMaxLink		Maximum link count exceeded
; 
; 	@constant kSCStatusReachabilityUnknown
; 		A determination could not be made regarding the reachability
; 		of the specified nodename/address.
; 
; 
; 	 * Generic status codes
; 	 

(defconstant $kSCStatusOK 0)                    ;  Success 

(defconstant $kSCStatusFailed #x3E9)            ;  Non-specific failure 

(defconstant $kSCStatusInvalidArgument #x3EA)   ;  Invalid argument 

(defconstant $kSCStatusAccessError #x3EB)
;  Permission denied
; 							   - must be root to obtain lock
; 							   - could not create access/create preferences
; 							 

(defconstant $kSCStatusNoKey #x3EC)             ;  No such key 

(defconstant $kSCStatusKeyExists #x3ED)         ;  Key already defined 

(defconstant $kSCStatusLocked #x3EE)            ;  Lock already held 

(defconstant $kSCStatusNeedLock #x3EF)          ;  Lock required for this operation 
; 
; 	 * SCDynamicStore status codes
; 	 

(defconstant $kSCStatusNoStoreSession #x7D1)    ;  Configuration daemon session not active 

(defconstant $kSCStatusNoStoreServer #x7D2)     ;  Configuration daemon not (no longer) available 

(defconstant $kSCStatusNotifierActive #x7D3)    ;  Notifier is currently active 
; 
; 	 * SCPreferences status codes
; 	 

(defconstant $kSCStatusNoPrefsSession #xBB9)    ;  Preference session not active 

(defconstant $kSCStatusPrefsBusy #xBBA)         ;  Preferences update currently in progress 

(defconstant $kSCStatusNoConfigFile #xBBB)      ;  Configuration file not found 

(defconstant $kSCStatusNoLink #xBBC)            ;  No such link 

(defconstant $kSCStatusStale #xBBD)             ;  Write attempted on stale version of object 

(defconstant $kSCStatusMaxLink #xBBE)           ;  Maximum link count exceeded 
; 
; 	 * SCNetwork status codes
; 	 

(defconstant $kSCStatusReachabilityUnknown #xFA1);  Network reachability cannot be determined 

;  store access APIs 

(require-interface "SystemConfiguration/SCDynamicStore")

(require-interface "SystemConfiguration/SCDynamicStoreKey")

(require-interface "SystemConfiguration/SCDynamicStoreCopySpecific")
;  preference access APIs 

(require-interface "SystemConfiguration/SCPreferences")

(require-interface "SystemConfiguration/SCPreferencesPath")
;  store and preference scheme definitions 

(require-interface "SystemConfiguration/SCSchemaDefinitions")
;  network reachability / connection APIs 

(require-interface "SystemConfiguration/SCNetwork")

(require-interface "SystemConfiguration/SCNetworkReachability")

(require-interface "SystemConfiguration/SCNetworkConnection")
; !
; 	@function SCError
; 	@discussion Returns a last SystemConfiguration.framework API error code.
; 	@result The last error encountered.
;  

(deftrap-inline "_SCError" 
   ((ARG2 (:NIL :NIL))
   )
   :signed-long
() )
; !
; 	@function SCErrorString
; 	@discussion Returns a pointer to the error message string associated
; 		with the specified status.
; 	@param status The SCDynamicStoreStatus to be returned.
; 	@result The error message string.
;  

(deftrap-inline "_SCErrorString" 
   ((status :signed-long)
   )
   (:pointer :character)
() )

; #endif /* _SYSTEMCONFIGURATION_H */


(provide-interface "SystemConfiguration")