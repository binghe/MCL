(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SecIdentity.h"
; at Sunday July 2,2006 7:31:43 pm.
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
; 	@header SecIdentity
; 	The functions provided in SecIdentity implement a convenient way to match private keys with certificates.
; 
; #ifndef _SECURITY_SECIDENTITY_H_
; #define _SECURITY_SECIDENTITY_H_

(require-interface "Security/SecBase")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
; !
; 	@function SecIdentityGetTypeID
; 	@abstract Returns the type identifier of SecIdentity instances.
; 	@result The CFTypeID of SecIdentity instances.
; 

(deftrap-inline "_SecIdentityGetTypeID" 
   (
   )
   :UInt32
() )
; !
; 	@function SecIdentityGetCertificate
;     @abstract Returns a reference to a certificate for the given identity reference.
;     @param identityRef An identity reference.
; 	@param certificateRef On return, a pointer to the found certificate reference.
;     @result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecIdentityCopyCertificate" 
   ((identityRef (:pointer :OpaqueSecIdentityRef))
    (certificateRef (:pointer :SECCERTIFICATEREF))
   )
   :SInt32
() )
; !
; 	@function SecIdentityGetPrivateKey
;     @abstract Returns the private key associated with an identity.
;     @param identityRef An identity reference.
; 	@param privateKeyRef On return, a pointer to the private key for the given identity. The private key must be of class type kSecAppleKeyItemClass.
;     @result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecIdentityCopyPrivateKey" 
   ((identityRef (:pointer :OpaqueSecIdentityRef))
    (privateKeyRef (:pointer :SECKEYREF))
   )
   :SInt32
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* !_SECURITY_SECIDENTITY_H_ */


(provide-interface "SecIdentity")