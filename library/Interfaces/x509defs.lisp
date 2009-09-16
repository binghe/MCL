(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:x509defs.h"
; at Sunday July 2,2006 7:31:42 pm.
; 
;  * Copyright (c) 2000-2001 Apple Computer, Inc. All Rights Reserved.
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
; 
;    File:      x509defs.h
; 
;    Contains:  Data structures for X509 Certificate Library field values
; 
;    Copyright: (c) 1999-2000 Apple Computer, Inc., all rights reserved.
; 
; #ifndef _X509DEFS_H_
(defconstant $_X509DEFS_H_ 1)
; #define _X509DEFS_H_  1

(require-interface "Security/cssmtype")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#

(def-mactype :CSSM_BER_TAG (find-mactype ':uint8))
(defconstant $BER_TAG_UNKNOWN 0)
; #define BER_TAG_UNKNOWN 0
(defconstant $BER_TAG_BOOLEAN 1)
; #define BER_TAG_BOOLEAN 1
(defconstant $BER_TAG_INTEGER 2)
; #define BER_TAG_INTEGER 2
(defconstant $BER_TAG_BIT_STRING 3)
; #define BER_TAG_BIT_STRING 3
(defconstant $BER_TAG_OCTET_STRING 4)
; #define BER_TAG_OCTET_STRING 4
(defconstant $BER_TAG_NULL 5)
; #define BER_TAG_NULL 5
(defconstant $BER_TAG_OID 6)
; #define BER_TAG_OID 6
(defconstant $BER_TAG_OBJECT_DESCRIPTOR 7)
; #define BER_TAG_OBJECT_DESCRIPTOR 7
(defconstant $BER_TAG_EXTERNAL 8)
; #define BER_TAG_EXTERNAL 8
(defconstant $BER_TAG_REAL 9)
; #define BER_TAG_REAL 9
(defconstant $BER_TAG_ENUMERATED 10)
; #define BER_TAG_ENUMERATED 10
;  12 to 15 are reserved for future versions of the recommendation 
(defconstant $BER_TAG_PKIX_UTF8_STRING 12)
; #define BER_TAG_PKIX_UTF8_STRING 12
(defconstant $BER_TAG_SEQUENCE 16)
; #define BER_TAG_SEQUENCE 16
(defconstant $BER_TAG_SET 17)
; #define BER_TAG_SET 17
(defconstant $BER_TAG_NUMERIC_STRING 18)
; #define BER_TAG_NUMERIC_STRING 18
(defconstant $BER_TAG_PRINTABLE_STRING 19)
; #define BER_TAG_PRINTABLE_STRING 19
(defconstant $BER_TAG_T61_STRING 20)
; #define BER_TAG_T61_STRING 20
; #define BER_TAG_TELETEX_STRING BER_TAG_T61_STRING
(defconstant $BER_TAG_VIDEOTEX_STRING 21)
; #define BER_TAG_VIDEOTEX_STRING 21
(defconstant $BER_TAG_IA5_STRING 22)
; #define BER_TAG_IA5_STRING 22
(defconstant $BER_TAG_UTC_TIME 23)
; #define BER_TAG_UTC_TIME 23
(defconstant $BER_TAG_GENERALIZED_TIME 24)
; #define BER_TAG_GENERALIZED_TIME 24
(defconstant $BER_TAG_GRAPHIC_STRING 25)
; #define BER_TAG_GRAPHIC_STRING 25
(defconstant $BER_TAG_ISO646_STRING 26)
; #define BER_TAG_ISO646_STRING 26
(defconstant $BER_TAG_GENERAL_STRING 27)
; #define BER_TAG_GENERAL_STRING 27
; #define BER_TAG_VISIBLE_STRING BER_TAG_ISO646_STRING
;  28 - are reserved for future versions of the recommendation 
(defconstant $BER_TAG_PKIX_UNIVERSAL_STRING 28)
; #define BER_TAG_PKIX_UNIVERSAL_STRING 28
(defconstant $BER_TAG_PKIX_BMP_STRING 30)
; #define BER_TAG_PKIX_BMP_STRING 30
;  Data Structures for X.509 Certificates 
(defrecord cssm_x509_algorithm_identifier
   (algorithm :cssm_oid)
#|
; Warning: type-size: unknown type CSSM_OID
|#
   (parameters :CSSM_DATA)
)

(def-mactype :CSSM_X509_ALGORITHM_IDENTIFIER_PTR (find-mactype '(:POINTER :CSSM_X509_ALGORITHM_IDENTIFIER)))
;  X509 Distinguished name structure 
(defrecord cssm_x509_type_value_pair
   (type :cssm_oid)
#|
; Warning: type-size: unknown type CSSM_OID
|#
   (valueType :uint8)                           ;  The Tag to be used when 
                                                ; this value is BER encoded 
   (value :CSSM_DATA)
)

(def-mactype :CSSM_X509_TYPE_VALUE_PAIR_PTR (find-mactype '(:POINTER :CSSM_X509_TYPE_VALUE_PAIR)))
(defrecord cssm_x509_rdn
   (numberOfPairs :UInt32)
   (AttributeTypeAndValue (:pointer (:pointer :CSSM_X509_TYPE_VALUE_PAIR)))
)

(def-mactype :CSSM_X509_RDN_PTR (find-mactype '(:POINTER :CSSM_X509_RDN)))
(defrecord cssm_x509_name
   (numberOfRDNs :UInt32)
   (RelativeDistinguishedName (:pointer (:pointer :CSSM_X509_RDN)))
)

(def-mactype :CSSM_X509_NAME_PTR (find-mactype '(:POINTER :CSSM_X509_NAME)))
;  Public key info struct 
(defrecord cssm_x509_subject_public_key_info
   (algorithm :CSSM_X509_ALGORITHM_IDENTIFIER)
   (subjectPublicKey :CSSM_DATA)
)

(def-mactype :CSSM_X509_SUBJECT_PUBLIC_KEY_INFO_PTR (find-mactype '(:POINTER :CSSM_X509_SUBJECT_PUBLIC_KEY_INFO)))
(defrecord cssm_x509_time
   (timeType :uint8)
   (time :CSSM_DATA)
)

(def-mactype :CSSM_X509_TIME_PTR (find-mactype '(:POINTER :CSSM_X509_TIME)))
;  Validity struct 
(defrecord x509_validity
   (notBefore :CSSM_X509_TIME)
   (notAfter :CSSM_X509_TIME)
)
(%define-record :CSSM_X509_VALIDITY (find-record-descriptor :X509_VALIDITY))

(def-mactype :CSSM_X509_VALIDITY_PTR (find-mactype '(:POINTER :X509_VALIDITY)))
; #define CSSM_X509_OPTION_PRESENT CSSM_TRUE
; #define CSSM_X509_OPTION_NOT_PRESENT CSSM_FALSE

(def-mactype :CSSM_X509_OPTION (find-mactype ':SInt32))
(defrecord cssm_x509ext_basicConstraints
   (cA :SInt32)
   (pathLenConstraintPresent :SInt32)
   (pathLenConstraint :UInt32)
)

(def-mactype :CSSM_X509EXT_BASICCONSTRAINTS_PTR (find-mactype '(:POINTER :CSSM_X509EXT_BASICCONSTRAINTS)))
(def-mactype :extension_data_format (find-mactype ':sint32))

(defconstant $CSSM_X509_DATAFORMAT_ENCODED 0)
(defconstant $CSSM_X509_DATAFORMAT_PARSED 1)
(defconstant $CSSM_X509_DATAFORMAT_PAIR 2)
(def-mactype :CSSM_X509EXT_DATA_FORMAT (find-mactype ':SINT32))
(defrecord cssm_x509_extensionTagAndValue
   (type :uint8)
   (value :CSSM_DATA)
)
(%define-record :CSSM_X509EXT_TAGandVALUE (find-record-descriptor :CSSM_X509_EXTENSIONTAGANDVALUE))

(def-mactype :CSSM_X509EXT_TAGandVALUE_PTR (find-mactype '(:POINTER :CSSM_X509_EXTENSIONTAGANDVALUE)))
(defrecord cssm_x509ext_pair
   (tagAndValue :CSSM_X509_EXTENSIONTAGANDVALUE)
   (parsedValue :pointer)
)

(def-mactype :CSSM_X509EXT_PAIR_PTR (find-mactype '(:POINTER :CSSM_X509EXT_PAIR)))
;  Extension structure 
(defrecord cssm_x509_extension
   (extnId :cssm_oid)
#|
; Warning: type-size: unknown type CSSM_OID
|#
   (critical :SInt32)
   (format :SInt32)
   (:variant
   (
   (tagAndValue (:pointer :CSSM_X509EXT_TAGANDVALUE))
   )
   (
   (parsedValue :pointer)
   )
   (
   (valuePair (:pointer :CSSM_X509EXT_PAIR))
   )
   )
   (BERvalue :CSSM_DATA)
)

(def-mactype :CSSM_X509_EXTENSION_PTR (find-mactype '(:POINTER :CSSM_X509_EXTENSION)))
(defrecord cssm_x509_extensions
   (numberOfExtensions :UInt32)
   (extensions (:pointer (:pointer :CSSM_X509_EXTENSION)))
)

(def-mactype :CSSM_X509_EXTENSIONS_PTR (find-mactype '(:POINTER :CSSM_X509_EXTENSIONS)))
;  X509V3 certificate structure 
(defrecord cssm_x509_tbs_certificate
   (version :CSSM_DATA)
   (serialNumber :CSSM_DATA)
   (signature :CSSM_X509_ALGORITHM_IDENTIFIER)
   (issuer :CSSM_X509_NAME)
   (validity :X509_VALIDITY)
   (subject :CSSM_X509_NAME)
   (subjectPublicKeyInfo :CSSM_X509_SUBJECT_PUBLIC_KEY_INFO)
   (issuerUniqueIdentifier :CSSM_DATA)
   (subjectUniqueIdentifier :CSSM_DATA)
   (extensions :CSSM_X509_EXTENSIONS)
)

(def-mactype :CSSM_X509_TBS_CERTIFICATE_PTR (find-mactype '(:POINTER :CSSM_X509_TBS_CERTIFICATE)))
;  Signature structure 
(defrecord cssm_x509_signature
   (algorithmIdentifier :CSSM_X509_ALGORITHM_IDENTIFIER)
   (encrypted :CSSM_DATA)
)

(def-mactype :CSSM_X509_SIGNATURE_PTR (find-mactype '(:POINTER :CSSM_X509_SIGNATURE)))
;  Signed certificate structure 
(defrecord cssm_x509_signed_certificate
   (certificate :CSSM_X509_TBS_CERTIFICATE)
   (signature :CSSM_X509_SIGNATURE)
)

(def-mactype :CSSM_X509_SIGNED_CERTIFICATE_PTR (find-mactype '(:POINTER :CSSM_X509_SIGNED_CERTIFICATE)))
(defrecord cssm_x509ext_policyQualifierInfo
   (policyQualifierId :cssm_oid)
#|
; Warning: type-size: unknown type CSSM_OID
|#
   (value :CSSM_DATA)
)

(def-mactype :CSSM_X509EXT_POLICYQUALIFIERINFO_PTR (find-mactype '(:POINTER :CSSM_X509EXT_POLICYQUALIFIERINFO)))
(defrecord cssm_x509ext_policyQualifiers
   (numberOfPolicyQualifiers :UInt32)
   (policyQualifier (:pointer :CSSM_X509EXT_POLICYQUALIFIERINFO))
)

(def-mactype :CSSM_X509EXT_POLICYQUALIFIERS_PTR (find-mactype '(:POINTER :CSSM_X509EXT_POLICYQUALIFIERS)))
(defrecord cssm_x509ext_policyInfo
   (policyIdentifier :cssm_oid)
#|
; Warning: type-size: unknown type CSSM_OID
|#
   (policyQualifiers :CSSM_X509EXT_POLICYQUALIFIERS)
)

(def-mactype :CSSM_X509EXT_POLICYINFO_PTR (find-mactype '(:POINTER :CSSM_X509EXT_POLICYINFO)))
;  Data Structures for X.509 Certificate Revocations Lists 
;  x509V2 entry in the CRL revokedCertificates sequence 
(defrecord cssm_x509_revoked_cert_entry
   (certificateSerialNumber :CSSM_DATA)
   (revocationDate :CSSM_X509_TIME)
   (extensions :CSSM_X509_EXTENSIONS)
)

(def-mactype :CSSM_X509_REVOKED_CERT_ENTRY_PTR (find-mactype '(:POINTER :CSSM_X509_REVOKED_CERT_ENTRY)))
(defrecord cssm_x509_revoked_cert_list
   (numberOfRevokedCertEntries :UInt32)
   (revokedCertEntry (:pointer (:pointer :CSSM_X509_REVOKED_CERT_ENTRY)))
)

(def-mactype :CSSM_X509_REVOKED_CERT_LIST_PTR (find-mactype '(:POINTER :CSSM_X509_REVOKED_CERT_LIST)))
;  x509v2 Certificate Revocation List (CRL) (unsigned) structure 
(defrecord cssm_x509_tbs_certlist
   (version :CSSM_DATA)
   (signature :CSSM_X509_ALGORITHM_IDENTIFIER)
   (issuer :CSSM_X509_NAME)
   (thisUpdate :CSSM_X509_TIME)
   (nextUpdate :CSSM_X509_TIME)
   (revokedCertificates (:pointer (:pointer :CSSM_X509_REVOKED_CERT_LIST)))
   (extensions :CSSM_X509_EXTENSIONS)
)

(def-mactype :CSSM_X509_TBS_CERTLIST_PTR (find-mactype '(:POINTER :CSSM_X509_TBS_CERTLIST)))
(defrecord cssm_x509_signed_crl
   (tbsCertList :CSSM_X509_TBS_CERTLIST)
   (signature :CSSM_X509_SIGNATURE)
)

(def-mactype :CSSM_X509_SIGNED_CRL_PTR (find-mactype '(:POINTER :CSSM_X509_SIGNED_CRL)))
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _X509DEFS_H_ */


(provide-interface "x509defs")