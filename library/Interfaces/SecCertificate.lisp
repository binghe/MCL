(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:SecCertificate.h"
; at Sunday July 2,2006 7:31:42 pm.
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
; 	@header SecCertificate
; 	The functions provided in SecCertificate implement and manage a particular type of keychain item that represents a certificate.  You can store a certificate in a keychain, but a certificate can also be a transient object.
; 	
; 	You can use a certificate as a keychain item in most functions.
; 
; #ifndef _SECURITY_SECCERTIFICATE_H_
; #define _SECURITY_SECCERTIFICATE_H_

(require-interface "Security/SecBase")

(require-interface "Security/cssmtype")
;  @@@ Here for X509 specific defines

(require-interface "Security/x509defs")

; #if defined(__cplusplus)
#|
extern "C" {
#endif
|#
; !
; 	@enum CertificateItemAttributes
; 	@abstract Indicates the type of a certificate item attribute.
; 	@constant kSecSubjectItemAttr Indicates a DER-encoded subject distinguished name.
; 	@constant kSecIssuerItemAttr Indicates a DER-encoded issuer distinguished name.
; 	@constant kSecSerialNumberItemAttr Indicates a DER-encoded certificate serial number.
; 	@constant kSecPublicKeyHashItemAttr Indicates a public key hash.
; 	@constant kSecSubjectKeyIdentifierItemAttr Indicates a subject key identifier.
; 	@constant kSecCertTypeItemAttr Indicates a certificate type.
; 	@constant kSecCertEncodingItemAttr Indicates a certificate encoding.
; 

(defconstant $kSecSubjectItemAttr :|subj|)
(defconstant $kSecIssuerItemAttr :|issu|)
(defconstant $kSecSerialNumberItemAttr :|snbr|)
(defconstant $kSecPublicKeyHashItemAttr :|hpky|)
(defconstant $kSecSubjectKeyIdentifierItemAttr :|skid|)
(defconstant $kSecCertTypeItemAttr :|ctyp|)
(defconstant $kSecCertEncodingItemAttr :|cenc|)
; !
; 	@function SecCertificateGetTypeID
; 	@abstract Returns the type identifier of SecCertificate instances.
; 	@result The CFTypeID of SecCertificate instances.
; 

(deftrap-inline "_SecCertificateGetTypeID" 
   (
   )
   :UInt32
() )
; #pragma mark ÑÑÑÑ Certificate Operations ÑÑÑÑ
; !
; 	@function SecCertificateCreateFromData
; 	@abstract Creates a certificate based on the input data, type, and encoding. 
;     @param data A pointer to the certificate data.
;     @param type The certificate type as defined in cssmtype.h.
;     @param encoding The certificate encoding as defined in cssmtype.h.
; 	@param certificate On return, a pointer to the newly created certificate reference.
;     @result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecCertificateCreateFromData" 
   ((data (:pointer :CSSM_DATA))
    (type :cssm_cert_type)
    (encoding :cssm_cert_encoding)
    (certificate (:pointer :SECCERTIFICATEREF))
   )
   :SInt32
() )
; !
; 	@function SecCertificateAddToKeychain
; 	@abstract Adds a certificate to the keychain specified.
;     @param certificate A reference to the certificate to add to the keychain.
;     @param keychain A reference to the keychain to which to add the certificate. Pass NULL to add the certificate to the default keychain.
;     @result A result code.  See "Security Error Codes" (SecBase.h).
; 	@discussion This function call only works if the certificate was created using the SecCertificateCreateFromData function and the certificate has not yet been added to a keychain.
; 

(deftrap-inline "_SecCertificateAddToKeychain" 
   ((certificate (:pointer :OpaqueSecCertificateRef))
    (keychain (:pointer :OpaqueSecKeychainRef))
   )
   :SInt32
() )
; !
; 	@function SecCertificateGetData
; 	@abstract Retrieves the data for a given certificate.
;     @param certificate A reference to the certificate from which to retrieve the data.
;     @param data On return, a pointer to the data for the certificate specified.  The caller must allocate the space for a CSSM_DATA structure before calling this function.  This data pointer is only guaranteed to remain valid as long as the certificate remains unchanged and valid.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecCertificateGetData" 
   ((certificate (:pointer :OpaqueSecCertificateRef))
    (data (:pointer (:pointer :CSSM_DATA)))
   )
   :SInt32
() )
; !
; 	@function SecCertificateGetItem
; 	@abstract Retrieves the keychain item reference for a given certificate.
;     @param certificate A reference to the certificate from which to obtain the keychain item reference.
;     @param item On return, a pointer to the keychain item reference of the certificate specified. If the certificate is not based on a keychain item, the value of item is NULL.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecCertificateGetItem" 
   ((certificate (:pointer :OpaqueSecCertificateRef))
    (item (:pointer :SecKeychainItemRef))
   )
   :SInt32
() )
; !
; 	@function SecCertificateGetType
; 	@abstract Retrieves the type for a given certificate.
;     @param certificate A reference to the certificate from which to obtain the type.
;     @param certificateType On return, a pointer to the certificate type of the certificate specified. Certificate types are defined in cssmtype.h
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecCertificateGetType" 
   ((certificate (:pointer :OpaqueSecCertificateRef))
    (certificateType (:pointer :cssm_cert_type))
   )
   :SInt32
() )
; !
; 	@function SecCertificateGetSubject
; 	@abstract Retrieves the subject for a given certificate.
;     @param certificate A reference to the certificate from which to obtain the subject.
;     @param subject On return, a pointer to the subject of the given certificate.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecCertificateGetSubject" 
   ((certificate (:pointer :OpaqueSecCertificateRef))
    (subject (:pointer :CSSM_X509_NAME))
   )
   :SInt32
() )
; !
; 	@function SecCertificateGetIssuer
; 	@abstract Retrieves the issuer of a given certificate.
;     @param certificate A reference to the certificate from which to obtain the issuer.
;     @param issuer On return, a pointer to the issuer of the given certificate.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecCertificateGetIssuer" 
   ((certificate (:pointer :OpaqueSecCertificateRef))
    (issuer (:pointer :CSSM_X509_NAME))
   )
   :SInt32
() )
; !
; 	@function SecCertificateGetCLHandle
; 	@abstract Retrieves the certificate library handle for a given certificate.
;     @param certificate A reference to the certificate from which to obtain the certificate library handle.
;     @param clHandle On return, a pointer to the certificate library handle of the given certificate.  This handle remains valid at least as long as the certificate does.
; 	@result A result code.  See "Security Error Codes" (SecBase.h).
; 

(deftrap-inline "_SecCertificateGetCLHandle" 
   ((certificate (:pointer :OpaqueSecCertificateRef))
    (clHandle (:pointer :CSSM_CL_HANDLE))
   )
   :SInt32
() )

; #if defined(__cplusplus)
#|
}
#endif
|#

; #endif /* !_SECURITY_SECCERTIFICATE_H_ */


(provide-interface "SecCertificate")