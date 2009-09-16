(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SCDynamicStoreKey.h"
; at Sunday July 2,2006 7:31:30 pm.
; 
;  * Copyright (c) 2000-2002 Apple Computer, Inc. All rights reserved.
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
; #ifndef _SCDYNAMICSTOREKEY_H
; #define _SCDYNAMICSTOREKEY_H

(require-interface "sys/cdefs")

(require-interface "CoreFoundation/CoreFoundation")
; !
; 	@header SCDynamicStoreKey
;  
; 
;  * SCDynamicStoreKeyCreate*
;  * - convenience routines that create a CFString key for an item in the store
;  
; !
; 	@function SCDynamicStoreKeyCreate
; 	@discussion Creates a store key using the given format.
;  

(deftrap-inline "_SCDynamicStoreKeyCreate" 
   ((allocator (:pointer :__CFAllocator))
    (fmt (:pointer :__CFString))
#| |...|  ;; What should this do?
    |#
   )
   (:pointer :__CFString)
() )
; !
; 	@function SCDynamicStoreKeyCreateNetworkGlobalEntity
;  

(deftrap-inline "_SCDynamicStoreKeyCreateNetworkGlobalEntity" 
   ((allocator (:pointer :__CFAllocator))
    (domain (:pointer :__CFString))
    (entity (:pointer :__CFString))
   )
   (:pointer :__CFString)
() )
; !
; 	@function SCDynamicStoreKeyCreateNetworkInterface
;  

(deftrap-inline "_SCDynamicStoreKeyCreateNetworkInterface" 
   ((allocator (:pointer :__CFAllocator))
    (domain (:pointer :__CFString))
   )
   (:pointer :__CFString)
() )
; !
; 	@function SCDynamicStoreKeyCreateNetworkInterfaceEntity
;  

(deftrap-inline "_SCDynamicStoreKeyCreateNetworkInterfaceEntity" 
   ((allocator (:pointer :__CFAllocator))
    (domain (:pointer :__CFString))
    (ifname (:pointer :__CFString))
    (entity (:pointer :__CFString))
   )
   (:pointer :__CFString)
() )
; !
; 	@function SCDynamicStoreKeyCreateNetworkServiceEntity
;  

(deftrap-inline "_SCDynamicStoreKeyCreateNetworkServiceEntity" 
   ((allocator (:pointer :__CFAllocator))
    (domain (:pointer :__CFString))
    (serviceID (:pointer :__CFString))
    (entity (:pointer :__CFString))
   )
   (:pointer :__CFString)
() )
; !
; 	@function SCDynamicStoreKeyCreateComputerName
; 	@discussion Creates a key that can be used by the SCDynamicStoreSetNotificationKeys()
; 		function to receive notifications when the current
; 		computer/host name changes.
; 	@result A notification string for the current computer/host name.
; 

(deftrap-inline "_SCDynamicStoreKeyCreateComputerName" 
   ((allocator (:pointer :__CFAllocator))
   )
   (:pointer :__CFString)
() )
; !
; 	@function SCDynamicStoreKeyCreateConsoleUser
; 	@discussion Creates a key that can be used by the SCDynamicStoreSetNotificationKeys()
; 		function to receive notifications when the current "Console"
; 		user changes.
; 	@result A notification string for the current "Console" user.
; 

(deftrap-inline "_SCDynamicStoreKeyCreateConsoleUser" 
   ((allocator (:pointer :__CFAllocator))
   )
   (:pointer :__CFString)
() )
; !
; 	@function SCDynamicStoreKeyCreateHostNames
; 	@discussion Creates a key that can be used in conjunction with
; 		SCDynamicStoreSetNotificationKeys() to receive
; 		notifications when the HostNames entity changes.  The
; 		HostNames entity contains the LocalHostName.
; 	@result A notification string for the HostNames entity.
; 

(deftrap-inline "_SCDynamicStoreKeyCreateHostNames" 
   ((allocator (:pointer :__CFAllocator))
   )
   (:pointer :__CFString)
() )
; !
; 	@function SCDynamicStoreKeyCreateLocation
; 	@discussion Creates a key that can be used in conjunction with
; 		SCDynamicStoreSetNotificationKeys() to receive
; 		notifications when the "location" identifier changes.
; 	@result A notification string for the current "location" identifier.
; 

(deftrap-inline "_SCDynamicStoreKeyCreateLocation" 
   ((allocator (:pointer :__CFAllocator))
   )
   (:pointer :__CFString)
() )
; !
; 	@function SCDynamicStoreKeyCreateProxies
; 	@discussion Creates a key that can be used by the SCDynamicStoreSetNotificationKeys()
; 		function to receive notifications when the current network proxy
; 		settings (HTTP, FTP, ...) are changed.
; 	@result A notification string for the current proxy settings.
; 

(deftrap-inline "_SCDynamicStoreKeyCreateProxies" 
   ((allocator (:pointer :__CFAllocator))
   )
   (:pointer :__CFString)
() )

; #endif /* _SCDYNAMICSTOREKEY_H */


(provide-interface "SCDynamicStoreKey")