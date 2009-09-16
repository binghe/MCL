(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:DHCPClientPreferences.h"
; at Sunday July 2,2006 7:27:31 pm.
; 
;  * Copyright (c) 2001 Apple Computer, Inc. All rights reserved.
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
; #ifndef _DHCPCLIENTPREFERENCES_H
; #define _DHCPCLIENTPREFERENCES_H

(require-interface "sys/cdefs")

(require-interface "CoreFoundation/CFString")
; !
; 	@header DHCPClientPreferences.h
;  
; !
; 	@function DHCPClientPreferencesSetApplicationOptions
; 	@discussion Updates the DHCP client preferences to include the
; 		given list of options for the given "applicationID".
; 	@param applicationID The application's preference ID, for example:
; 		"com.apple.SystemPreferences".
; 	@param options An array of 8-bit values containing the
; 		DHCP option codes (see RFC 2132) for this applicationID.
; 		A NULL value will clear the list of options for this
; 		application ID.
; 	@param count The number of elements in "options".
; 	@result TRUE if the operation succeeded, FALSE otherwise.
;  

(deftrap-inline "_DHCPClientPreferencesSetApplicationOptions" 
   ((applicationID (:pointer :__CFString))
    (options (:pointer :UInt8))
    (count :sint32)
   )
   :Boolean
() )
; !
; 	@function DHCPClientPreferencesCopyApplicationOptions
; 	@discussion Copies the requested DHCP options for the
; 		given "applicationID".
; 	@param applicationID The application's preference ID, for example
; 		"com.apple.SystemPreferences".
; 	@param count The number of elements in the returned array.
; 	@result The list of options for the given "applicationID", or
; 		NULL if no options are defined or an error occurred.
; 
; 		When done, use free() to release a non-NULL return value.
;  

(deftrap-inline "_DHCPClientPreferencesCopyApplicationOptions" 
   ((applicationID (:pointer :__CFString))
    (count (:pointer :CFIndex))
   )
   (:pointer :UInt8)
() )

; #endif /* _DHCPCLIENTPREFERENCES_H */


(provide-interface "DHCPClientPreferences")