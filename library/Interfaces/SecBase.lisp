(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SecBase.h"
; at Sunday July 2,2006 7:31:41 pm.
; 
;  * Copyright (c) 2000-2002 Apple Computer, Inc. All Rights Reserved.
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
; 	@header SecBase
; 	SecBase contains common declarations for the Security functions. 
; 
; #ifndef _SECURITY_SECBASE_H_
; #define _SECURITY_SECBASE_H_

(require-interface "CoreFoundation/CFBase")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
; #ifndef __SEC_TYPES__
#| #|
#define __SEC_TYPES__


typedef struct OpaqueSecKeychainRef *SecKeychainRef;


typedef struct OpaqueSecKeychainItemRef *SecKeychainItemRef;


typedef struct OpaqueSecKeychainSearchRef *SecKeychainSearchRef;


typedef OSType SecKeychainAttrType;


struct SecKeychainAttribute 
{
    SecKeychainAttrType	tag;
    UInt32 length;
    void *data;
};
typedef struct SecKeychainAttribute SecKeychainAttribute;


typedef SecKeychainAttribute *SecKeychainAttributePtr;


struct SecKeychainAttributeList 
{
    UInt32 count;
    SecKeychainAttribute *attr;
};
typedef struct SecKeychainAttributeList  SecKeychainAttributeList;


typedef UInt32 SecKeychainStatus;
#endif
|#
 |#
; !
;     @typedef SecTrustedApplicationRef
;     @abstract Contains information about a trusted application.
; 

(def-mactype :SecTrustedApplicationRef (find-mactype '(:pointer :OpaqueSecTrustedApplicationRef)))
; !
;     @typedef SecPolicyRef
;     @abstract Contains information about a policy.
; 

(def-mactype :SecPolicyRef (find-mactype '(:pointer :OpaqueSecPolicyRef)))
; !
;     @typedef SecCertificateRef
;     @abstract Contains information about a certificate.
; 

(def-mactype :SecCertificateRef (find-mactype '(:pointer :OpaqueSecCertificateRef)))
; !
;     @typedef SecAccessRef
;     @abstract Contains information about an access.
; 

(def-mactype :SecAccessRef (find-mactype '(:pointer :OpaqueSecAccessRef)))
; !
;     @typedef SecIdentityRef
;     @abstract Contains information about an identity.
; 

(def-mactype :SecIdentityRef (find-mactype '(:pointer :OpaqueSecIdentityRef)))
; !
;     @typedef SecKeyRef
;     @abstract Contains information about a key.
; 

(def-mactype :SecKeyRef (find-mactype '(:pointer :OpaqueSecKeyRef)))
; !
;     @typedef SecACLRef
;     @abstract Contains information about an access control list (ACL) entry.
; 

(def-mactype :SecACLRef (find-mactype '(:pointer :OpaqueSecTrustRef)))
; !
;     @typedef SecKeychainAttributeInfo
;     @abstract Represents an attribute. 
;     @field count The number of tag-format pairs in the respective arrays. 
;     @field tag A pointer to the first attribute tag in the array.
;     @field format A pointer to the first attribute format in the array.
;     @discussion Each tag and format item form a pair.  
; 
(defrecord SecKeychainAttributeInfo
   (count :UInt32)
   (tag (:pointer :UInt32))
   (format (:pointer :UInt32))
)

;type name? (%define-record :SecKeychainAttributeInfo (find-record-descriptor ':SecKeychainAttributeInfo))
; !
; @enum Security Error Codes 
; @abstract Represents the result codes.
; @constant errSecNotAvailable No keychain is available.
; @constant errSecReadOnly Read only error.
; @constant errSecAuthFailed Authorization/Authentication failed.
; @constant errSecNoSuchKeychain The keychain does not exist.
; @constant errSecInvalidKeychain The keychain is not valid.
; @constant errSecDuplicateKeychain A keychain with the same name already exists.
; @constant errSecDuplicateCallback The specified callback is already installed.
; @constant errSecInvalidCallback The specified callback is not valid.
; @constant errSecDuplicateItem The item already exists.
; @constant errSecItemNotFound The item cannot be found.
; @constant errSecBufferTooSmall The buffer is too small.
; @constant errSecDataTooLarge The data is too large.
; @constant errSecNoSuchAttr The attribute does not exist.
; @constant errSecInvalidItemRef The item reference is invalid.
; @constant errSecInvalidSearchRef The search reference is invalid.
; @constant errSecNoSuchClass The keychain item class does not exist.
; @constant errSecNoDefaultKeychain A default keychain does not exist.
; @constant errSecInteractionNotAllowed Interaction is not allowed with the Security Server.
; @constant errSecReadOnlyAttr The attribute is read only.
; @constant errSecWrongSecVersion The version is incorrect.
; @constant errSecKeySizeNotAllowed The key size is not allowed.
; @constant errSecNoStorageModule There is no storage module available.
; @constant errSecNoCertificateModule There is no certificate module available.
; @constant errSecNoPolicyModule There is no policy module available.
; @constant errSecInteractionRequired User interaction is required.
; @constant errSecDataNotAvailable The data is not available.
; @constant errSecDataNotModifiable The data is not modifiable.
; @constant errSecCreateChainFailed The attempt to create a certificate chain failed.
; @constant errSecACLNotSimple The access control list is not in standard simple form.
; @constant errSecPolicyNotFound The policy specified cannot be found.
; @constant errSecInvalidTrustSetting The trust setting is invalid.
; @constant errSecNoAccessForItem The specified item has no access control.
; @constant errSecInvalidOwnerEdit Invalid attempt to change the owner of this item.
; @constant errSecTrustNotAvailable No trust results are available.
; @discussion The assigned error space is discontinuous: -25240..-25279, -25290..25329.
; 
; 
;     Note: the comments that appear after these errors are used to create SecErrorMessages.strings.
;     The comments must not be multi-line, and should be in a form meaningful to an end user. If
;     a different or additional comment is needed, it can be put in the header doc format, or on a
;     line that does not start with errZZZ.
; 

(defconstant $errSecNotAvailable -25291)        ;  No keychain is available. You may need to restart your computer. 

(defconstant $errSecReadOnly -25292)            ;  This keychain cannot be modified. 

(defconstant $errSecAuthFailed -25293)          ;  The user name or passphrase you entered is not correct. 

(defconstant $errSecNoSuchKeychain -25294)      ;  The specified keychain could not be found. 

(defconstant $errSecInvalidKeychain -25295)     ;  The specified keychain is not a valid keychain file. 

(defconstant $errSecDuplicateKeychain -25296)   ;  A keychain with the same name already exists. 

(defconstant $errSecDuplicateCallback -25297)   ;  The specified callback function is already installed. 

(defconstant $errSecInvalidCallback -25298)     ;  The specified callback function is not valid. 

(defconstant $errSecDuplicateItem -25299)       ;  The specified item already exists in the keychain. 

(defconstant $errSecItemNotFound -25300)        ;  The specified item could not be found in the keychain. 

(defconstant $errSecBufferTooSmall -25301)      ;  There is not enough memory available to use the specified item. 

(defconstant $errSecDataTooLarge -25302)        ;  This item contains information which is too large or in a format that cannot be displayed. 

(defconstant $errSecNoSuchAttr -25303)          ;  The specified attribute does not exist. 

(defconstant $errSecInvalidItemRef -25304)      ;  The specified item is no longer valid. It may have been deleted from the keychain. 

(defconstant $errSecInvalidSearchRef -25305)    ;  Unable to search the current keychain. 

(defconstant $errSecNoSuchClass -25306)         ;  The specified item does not appear to be a valid keychain item. 

(defconstant $errSecNoDefaultKeychain -25307)   ;  A default keychain could not be found. 

(defconstant $errSecInteractionNotAllowed -25308);  User interaction is not allowed. 

(defconstant $errSecReadOnlyAttr -25309)        ;  The specified attribute could not be modified. 

(defconstant $errSecWrongSecVersion -25310)     ;  This keychain was created by a different version of the system software and cannot be opened. 

(defconstant $errSecKeySizeNotAllowed -25311)   ;  This item specifies a key size which is too large. 

(defconstant $errSecNoStorageModule -25312)     ;  A required component (data storage module) could not be loaded. You may need to restart your computer. 

(defconstant $errSecNoCertificateModule -25313) ;  A required component (certificate module) could not be loaded. You may need to restart your computer. 

(defconstant $errSecNoPolicyModule -25314)      ;  A required component (policy module) could not be loaded. You may need to restart your computer. 

(defconstant $errSecInteractionRequired -25315) ;  User interaction is required, but is currently not allowed. 

(defconstant $errSecDataNotAvailable -25316)    ;  The contents of this item cannot be retrieved. 

(defconstant $errSecDataNotModifiable -25317)   ;  The contents of this item cannot be modified. 

(defconstant $errSecCreateChainFailed -25318)   ;  One or more certificates required to validate this certificate cannot be found. 

(defconstant $errSecInvalidPrefsDomain -25319)  ;  The specified preferences domain is not valid. 

(defconstant $errSecACLNotSimple -25240)        ;  The specified access control list is not in standard (simple) form. 

(defconstant $errSecPolicyNotFound -25241)      ;  The specified policy cannot be found. 

(defconstant $errSecInvalidTrustSetting -25242) ;  The specified trust setting is invalid. 

(defconstant $errSecNoAccessForItem -25243)     ;  The specified item has no access control. 

(defconstant $errSecInvalidOwnerEdit -25244)    ;  Invalid attempt to change the owner of this item. 
;  No trust results are available. 

(defconstant $errSecTrustNotAvailable -25245)

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* !_SECURITY_SECBASE_H_ */


(provide-interface "SecBase")