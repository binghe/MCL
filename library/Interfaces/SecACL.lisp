(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SecACL.h"
; at Sunday July 2,2006 7:31:41 pm.
; 
;  * Copyright (c) 2002 Apple Computer, Inc. All Rights Reserved.
;  * 
;  * The contents of this file constitute Original Code as defined in and are
;  * subject to the Apple Public Source License Version 1.2 (the 'License').
;  * You may not use this file except in compliance with the License. Please obtain
;  * a copy of the License at http://www.apple.com/publicsource and read it before
;  * using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS
;  * OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES, INCLUDING WITHOUT
;  * LIMITATION, ANY WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
;  * PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT. Please see the License for the
;  * specific language governing rights and limitations under the License.
;  
; !
; 	@header SecACL
; 	The functions provided in SecACL are for managing entries in the access control list.  
; 
; #ifndef _SECURITY_SECACL_H_
; #define _SECURITY_SECACL_H_

(require-interface "Security/SecBase")

(require-interface "Security/cssmtype")

(require-interface "Security/cssmapple")

(require-interface "CoreFoundation/CoreFoundation")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
; !
; 	@function SecACLGetTypeID
;     @abstract Returns the type identifier of SecACL instances.
;     @result The CFTypeID of SecACL instances.
; 

(deftrap-inline "_SecACLGetTypeID" 
   (
   )
   :UInt32
() )
; !
; 	@function SecACLCreateFromSimpleContents
; 	@abstract Creates a new access control list entry from the application list, description, and prompt selector provided and adds it to an item's access.
; 	@param access An access reference.
; 	@param applicationList An array of SecTrustedApplication instances that will be allowed access without prompting. 
; 	@param description The human readable name that will be used to refer to this item when the user is prompted.
; 	@param promptSelector A pointer to a CSSM prompt selector.
; 	@param newAcl A pointer to an access control list entry.  On return, this points to the reference of the new access control list entry.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
;  

(deftrap-inline "_SecACLCreateFromSimpleContents" 
   ((access (:pointer :OpaqueSecAccessRef))
    (applicationList (:pointer :__CFArray))
    (description (:pointer :__CFString))
    (promptSelector (:pointer :cssm_acl_keychain_prompt_selector))
    (newAcl (:pointer :SECACLREF))
   )
   :SInt32
() )
; !
; 	@function SecACLRemove
; 	@abstract Removes the access control list entry specified.
; 	@param aclRef The reference to the access control list entry to remove.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
;  

(deftrap-inline "_SecACLRemove" 
   ((aclRef (:pointer :OpaqueSecTrustRef))
   )
   :SInt32
() )
; !
; 	@function SecACLGetSimpleContents
; 	@abstract Returns the application list, description, and CSSM prompt selector for a given access control list entry.
; 	@param acl An access control list entry reference.
; 	@param applicationList On return, An array of SecTrustedApplication instances that will be allowed access without prompting, for the given access control list entry.  The caller needs to call CFRelease on this array when it's no longer needed.
; 	@param description On return, the human readable name that will be used to refer to this item when the user is prompted, for the given access control list entry. The caller needs to call CFRelease on this string when it's no longer needed.
; 	@param promptSelector A pointer to a CSSM prompt selector.  On return, this points to the CSSM prompt selector for the given access control list entry.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
;  

(deftrap-inline "_SecACLCopySimpleContents" 
   ((acl (:pointer :OpaqueSecTrustRef))
    (applicationList (:pointer :CFArrayRef))
    (description (:pointer :CFStringRef))
    (promptSelector (:pointer :cssm_acl_keychain_prompt_selector))
   )
   :SInt32
() )
; !
; 	@function SecACLSetSimpleContents
; 	@abstract Sets the application list, description, and CSSM prompt selector for a given access control list entry.
; 	@param acl A reference to the access control list entry to edit.
; 	@param applicationList An application list reference. 
; 	@param description The human readable name that will be used to refer to this item when the user is prompted.
; 	@param promptSelector A pointer to a CSSM prompt selector.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecACLSetSimpleContents" 
   ((acl (:pointer :OpaqueSecTrustRef))
    (applicationList (:pointer :__CFArray))
    (description (:pointer :__CFString))
    (promptSelector (:pointer :cssm_acl_keychain_prompt_selector))
   )
   :SInt32
() )
; !
; 	@function SecACLGetAuthorizations
; 	@abstract Retrieve the CSSM authorization tags of a given access control list entry.
; 	@param acl An access control list entry reference.
; 	@param tags On return, this points to the first item in an array of CSSM authorization tags.
; 	@param tagCount On return, this points to the number of tags in the CSSM authorization tag array.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
;  

(deftrap-inline "_SecACLGetAuthorizations" 
   ((acl (:pointer :OpaqueSecTrustRef))
    (tags (:pointer :CSSM_ACL_AUTHORIZATION_TAG))
    (tagCount (:pointer :UInt32))
   )
   :SInt32
() )
; !
; 	@function SecACLSetAuthorizations
; 	@abstract Sets the CSSM authorization tags of a given access control list entry.
; 	@param acl An access control list entry reference.
; 	@param tags A pointer to the first item in an array of CSSM authorization tags.
; 	@param tagCount The number of tags in the CSSM authorization tag array.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecACLSetAuthorizations" 
   ((acl (:pointer :OpaqueSecTrustRef))
    (tags (:pointer :CSSM_ACL_AUTHORIZATION_TAG))
    (tagCount :UInt32)
   )
   :SInt32
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* !_SECURITY_SECACL_H_ */


(provide-interface "SecACL")