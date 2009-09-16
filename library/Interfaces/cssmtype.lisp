(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:cssmtype.h"
; at Sunday July 2,2006 7:27:26 pm.
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
;    File:      cssmtype.h
; 
;    Contains:  Common Security Services Manager Common Data Types
; 
;    Copyright: (c) 1999-2000 Apple Computer, Inc., all rights reserved.
; 
; #ifndef _CSSMTYPE_H_
(defconstant $_CSSMTYPE_H_ 1)
; #define _CSSMTYPE_H_  1

(require-interface "Security/cssmconfig")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
;  Handle types. 

(def-mactype :CSSM_HANDLE_PTR (find-mactype '(:POINTER :uint32)))

(def-mactype :CSSM_LONG_HANDLE_PTR (find-mactype '(:POINTER :uint64)))

(def-mactype :CSSM_MODULE_HANDLE_PTR (find-mactype '(:POINTER :CSSM_HANDLE)))

(def-mactype :CSSM_CC_HANDLE (find-mactype ':CSSM_LONG_HANDLE))
;  Cryptographic Context Handle 

(def-mactype :CSSM_CSP_HANDLE (find-mactype ':CSSM_MODULE_HANDLE))
;  Cryptographic Service Provider Handle 

(def-mactype :CSSM_TP_HANDLE (find-mactype ':CSSM_MODULE_HANDLE))
;  Trust Policy Handle 

(def-mactype :CSSM_AC_HANDLE (find-mactype ':CSSM_MODULE_HANDLE))
;  Authorization Computation Handle 

(def-mactype :CSSM_CL_HANDLE (find-mactype ':CSSM_MODULE_HANDLE))
;  Certificate Library Handle 

(def-mactype :CSSM_DL_HANDLE (find-mactype ':CSSM_MODULE_HANDLE))
;  Data Storage Library Handle 

(def-mactype :CSSM_DB_HANDLE (find-mactype ':CSSM_MODULE_HANDLE))
;  Data Storage Database Handle 
;  invalid or NULL value for any CSSM_HANDLE type 

(defconstant $CSSM_INVALID_HANDLE 0)
;  Data Types for Core Services 

(def-mactype :CSSM_BOOL (find-mactype ':sint32))

(defconstant $CSSM_FALSE 0)
(defconstant $CSSM_TRUE -1)
;  The standard declares this as uint32 but we changed it to sint32 to match OSStatus. 

(def-mactype :CSSM_RETURN (find-mactype ':sint32))

(defconstant $CSSM_OK 0)

(defconstant $CSSM_MODULE_STRING_SIZE 64)
(defrecord CSSM_STRING
   (contents (:array :character 68))
)
(defrecord cssm_data
   (Length :UInt32)                             ;  in bytes 
   (Data (:pointer :UInt8))
)

(def-mactype :CSSM_DATA_PTR (find-mactype '(:POINTER :CSSM_DATA)))
(defrecord cssm_guid
   (Data1 :UInt32)
   (Data2 :UInt16)
   (Data3 :UInt16)
   (Data4 (:array :UInt8 8))
)

(def-mactype :CSSM_GUID_PTR (find-mactype '(:POINTER :CSSM_GUID)))

(def-mactype :CSSM_BITMASK (find-mactype ':uint32))

(def-mactype :CSSM_KEY_HIERARCHY (find-mactype ':uint32))

(defconstant $CSSM_KEY_HIERARCHY_NONE 0)
(defconstant $CSSM_KEY_HIERARCHY_INTEG 1)
(defconstant $CSSM_KEY_HIERARCHY_EXPORT 2)

(def-mactype :CSSM_PVC_MODE (find-mactype ':uint32))

(defconstant $CSSM_PVC_NONE 0)
(defconstant $CSSM_PVC_APP 1)
(defconstant $CSSM_PVC_SP 2)

(def-mactype :CSSM_PRIVILEGE_SCOPE (find-mactype ':uint32))

(defconstant $CSSM_PRIVILEGE_SCOPE_NONE 0)
(defconstant $CSSM_PRIVILEGE_SCOPE_PROCESS 1)
(defconstant $CSSM_PRIVILEGE_SCOPE_THREAD 2)
(defrecord cssm_version
   (Major :uint32)
   (Minor :uint32)
)

(def-mactype :CSSM_VERSION_PTR (find-mactype '(:POINTER :CSSM_VERSION)))

(def-mactype :CSSM_SERVICE_MASK (find-mactype ':uint32))

(defconstant $CSSM_SERVICE_CSSM 1)
(defconstant $CSSM_SERVICE_CSP 2)
(defconstant $CSSM_SERVICE_DL 4)
(defconstant $CSSM_SERVICE_CL 8)
(defconstant $CSSM_SERVICE_TP 16)
(defconstant $CSSM_SERVICE_AC 32)
(defconstant $CSSM_SERVICE_KR 64)

(def-mactype :CSSM_SERVICE_TYPE (find-mactype ':uint32))
(defrecord cssm_subservice_uid
   (Guid :CSSM_GUID)
   (Version :CSSM_VERSION)
   (SubserviceId :uint32)
   (SubserviceType :uint32)
)

(def-mactype :CSSM_SUBSERVICE_UID_PTR (find-mactype '(:POINTER :CSSM_SUBSERVICE_UID)))

(def-mactype :CSSM_MODULE_EVENT_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_NOTIFY_INSERT 1)
(defconstant $CSSM_NOTIFY_REMOVE 2)
(defconstant $CSSM_NOTIFY_FAULT 3)

;type name? (def-mactype :(CSSMAPI * CSSM_API_ModuleEventHandler) (find-mactype ':sint32)); (const CSSM_GUID * ModuleGuid , void * AppNotifyCallbackCtx , uint32 SubserviceId , CSSM_SERVICE_TYPE ServiceType , CSSM_MODULE_EVENT EventType)

(def-mactype :CSSM_ATTACH_FLAGS (find-mactype ':uint32))

(defconstant $CSSM_ATTACH_READ_ONLY 1)
;  Non-export privilege range: (0x00000000 - 0x7FFFFFFF) 
;  Vendor specific range: (0x80000000 - 0xFFFFFFFF) 

(%define-record :CSSM_PRIVILEGE (find-record-descriptor ':uint64))

(%define-record :CSSM_USEE_TAG (find-record-descriptor ':CSSM_PRIVILEGE))

(defconstant $CSSM_USEE_LAST #xFF)
(defconstant $CSSM_USEE_NONE 0)
(defconstant $CSSM_USEE_DOMESTIC 1)
(defconstant $CSSM_USEE_FINANCIAL 2)
(defconstant $CSSM_USEE_KRLE 3)
(defconstant $CSSM_USEE_KRENT 4)
(defconstant $CSSM_USEE_SSL 5)
(defconstant $CSSM_USEE_AUTHENTICATION 6)
(defconstant $CSSM_USEE_KEYEXCH 7)
(defconstant $CSSM_USEE_MEDICAL 8)
(defconstant $CSSM_USEE_INSURANCE 9)
(defconstant $CSSM_USEE_WEAK 10)

(def-mactype :CSSM_NET_ADDRESS_TYPE (find-mactype ':uint32))

(defconstant $CSSM_ADDR_NONE 0)
(defconstant $CSSM_ADDR_CUSTOM 1)
(defconstant $CSSM_ADDR_URL 2)                  ;  char* 

(defconstant $CSSM_ADDR_SOCKADDR 3)
(defconstant $CSSM_ADDR_NAME 4)                 ;  char* - qualified by access method 

(defrecord cssm_net_address
   (AddressType :uint32)
   (Address :CSSM_DATA)
)

(def-mactype :CSSM_NET_ADDRESS_PTR (find-mactype '(:POINTER :CSSM_NET_ADDRESS)))

(def-mactype :CSSM_NET_PROTOCOL (find-mactype ':uint32))

(defconstant $CSSM_NET_PROTO_NONE 0)            ;  local 

(defconstant $CSSM_NET_PROTO_CUSTOM 1)          ;  proprietary implementation 

(defconstant $CSSM_NET_PROTO_UNSPECIFIED 2)     ;  implementation default 

(defconstant $CSSM_NET_PROTO_LDAP 3)            ;  light weight directory access protocol 

(defconstant $CSSM_NET_PROTO_LDAPS 4)           ;  ldap/ssl where SSL initiates the connection 

(defconstant $CSSM_NET_PROTO_LDAPNS 5)          ;  ldap where ldap negotiates an SSL session 

(defconstant $CSSM_NET_PROTO_X500DAP 6)         ;  x.500 Directory access protocol 

(defconstant $CSSM_NET_PROTO_FTP 7)             ;  ftp for cert/crl fetch 

(defconstant $CSSM_NET_PROTO_FTPS 8)            ;  ftp/ssl/tls where SSL/TLS initiates the connection 

(defconstant $CSSM_NET_PROTO_OCSP 9)            ;  online certificate status protocol 

(defconstant $CSSM_NET_PROTO_CMP 10)            ;  the cert request protocol in PKIX3 

(defconstant $CSSM_NET_PROTO_CMPS 11)           ;  The ssl/tls derivative of CMP 


;type name? (def-mactype :(CSSMAPI * CSSM_CALLBACK) (find-mactype ':sint32)); (CSSM_DATA_PTR OutData , void * CallerCtx)
(defrecord cssm_crypto_data
   (Param :CSSM_DATA)
   (Callback :cssm_callback)
#|
; Warning: type-size: unknown type CSSM_CALLBACK
|#
   (CallerCtx :pointer)
)

(def-mactype :CSSM_CRYPTO_DATA_PTR (find-mactype '(:POINTER :CSSM_CRYPTO_DATA)))

(def-mactype :CSSM_WORDID_TYPE (find-mactype ':sint32))

(defconstant $CSSM_WORDID__UNK_ -1)             ;  not in dictionary 

(defconstant $CSSM_WORDID__NLU_ 0)              ;  not yet looked up 

(defconstant $CSSM_WORDID__STAR_ 1)
(defconstant $CSSM_WORDID_A 2)
(defconstant $CSSM_WORDID_ACL 3)
(defconstant $CSSM_WORDID_ALPHA 4)
(defconstant $CSSM_WORDID_B 5)
(defconstant $CSSM_WORDID_BER 6)
(defconstant $CSSM_WORDID_BINARY 7)
(defconstant $CSSM_WORDID_BIOMETRIC 8)
(defconstant $CSSM_WORDID_C 9)
(defconstant $CSSM_WORDID_CANCELED 10)
(defconstant $CSSM_WORDID_CERT 11)
(defconstant $CSSM_WORDID_COMMENT 12)
(defconstant $CSSM_WORDID_CRL 13)
(defconstant $CSSM_WORDID_CUSTOM 14)
(defconstant $CSSM_WORDID_D 15)
(defconstant $CSSM_WORDID_DATE 16)
(defconstant $CSSM_WORDID_DB_DELETE 17)
(defconstant $CSSM_WORDID_DB_EXEC_STORED_QUERY 18)
(defconstant $CSSM_WORDID_DB_INSERT 19)
(defconstant $CSSM_WORDID_DB_MODIFY 20)
(defconstant $CSSM_WORDID_DB_READ 21)
(defconstant $CSSM_WORDID_DBS_CREATE 22)
(defconstant $CSSM_WORDID_DBS_DELETE 23)
(defconstant $CSSM_WORDID_DECRYPT 24)
(defconstant $CSSM_WORDID_DELETE 25)
(defconstant $CSSM_WORDID_DELTA_CRL 26)
(defconstant $CSSM_WORDID_DER 27)
(defconstant $CSSM_WORDID_DERIVE 28)
(defconstant $CSSM_WORDID_DISPLAY 29)
(defconstant $CSSM_WORDID_DO 30)
(defconstant $CSSM_WORDID_DSA 31)
(defconstant $CSSM_WORDID_DSA_SHA1 32)
(defconstant $CSSM_WORDID_E 33)
(defconstant $CSSM_WORDID_ELGAMAL 34)
(defconstant $CSSM_WORDID_ENCRYPT 35)
(defconstant $CSSM_WORDID_ENTRY 36)
(defconstant $CSSM_WORDID_EXPORT_CLEAR 37)
(defconstant $CSSM_WORDID_EXPORT_WRAPPED 38)
(defconstant $CSSM_WORDID_G 39)
(defconstant $CSSM_WORDID_GE 40)
(defconstant $CSSM_WORDID_GENKEY 41)
(defconstant $CSSM_WORDID_HASH 42)
(defconstant $CSSM_WORDID_HASHED_PASSWORD 43)
(defconstant $CSSM_WORDID_HASHED_SUBJECT 44)
(defconstant $CSSM_WORDID_HAVAL 45)
(defconstant $CSSM_WORDID_IBCHASH 46)
(defconstant $CSSM_WORDID_IMPORT_CLEAR 47)
(defconstant $CSSM_WORDID_IMPORT_WRAPPED 48)
(defconstant $CSSM_WORDID_INTEL 49)
(defconstant $CSSM_WORDID_ISSUER 50)
(defconstant $CSSM_WORDID_ISSUER_INFO 51)
(defconstant $CSSM_WORDID_K_OF_N 52)
(defconstant $CSSM_WORDID_KEA 53)
(defconstant $CSSM_WORDID_KEYHOLDER 54)
(defconstant $CSSM_WORDID_L 55)
(defconstant $CSSM_WORDID_LE 56)
(defconstant $CSSM_WORDID_LOGIN 57)
(defconstant $CSSM_WORDID_LOGIN_NAME 58)
(defconstant $CSSM_WORDID_MAC 59)
(defconstant $CSSM_WORDID_MD2 60)
(defconstant $CSSM_WORDID_MD2WITHRSA 61)
(defconstant $CSSM_WORDID_MD4 62)
(defconstant $CSSM_WORDID_MD5 63)
(defconstant $CSSM_WORDID_MD5WITHRSA 64)
(defconstant $CSSM_WORDID_N 65)
(defconstant $CSSM_WORDID_NAME 66)
(defconstant $CSSM_WORDID_NDR 67)
(defconstant $CSSM_WORDID_NHASH 68)
(defconstant $CSSM_WORDID_NOT_AFTER 69)
(defconstant $CSSM_WORDID_NOT_BEFORE 70)
(defconstant $CSSM_WORDID_NULL 71)
(defconstant $CSSM_WORDID_NUMERIC 72)
(defconstant $CSSM_WORDID_OBJECT_HASH 73)
(defconstant $CSSM_WORDID_ONE_TIME 74)
(defconstant $CSSM_WORDID_ONLINE 75)
(defconstant $CSSM_WORDID_OWNER 76)
(defconstant $CSSM_WORDID_P 77)
(defconstant $CSSM_WORDID_PAM_NAME 78)
(defconstant $CSSM_WORDID_PASSWORD 79)
(defconstant $CSSM_WORDID_PGP 80)
(defconstant $CSSM_WORDID_PREFIX 81)
(defconstant $CSSM_WORDID_PRIVATE_KEY 82)
(defconstant $CSSM_WORDID_PROMPTED_BIOMETRIC 83)
(defconstant $CSSM_WORDID_PROMPTED_PASSWORD 84)
(defconstant $CSSM_WORDID_PROPAGATE 85)
(defconstant $CSSM_WORDID_PROTECTED_BIOMETRIC 86)
(defconstant $CSSM_WORDID_PROTECTED_PASSWORD 87)
(defconstant $CSSM_WORDID_PROTECTED_PIN 88)
(defconstant $CSSM_WORDID_PUBLIC_KEY 89)
(defconstant $CSSM_WORDID_PUBLIC_KEY_FROM_CERT 90)
(defconstant $CSSM_WORDID_Q 91)
(defconstant $CSSM_WORDID_RANGE 92)
(defconstant $CSSM_WORDID_REVAL 93)
(defconstant $CSSM_WORDID_RIPEMAC 94)
(defconstant $CSSM_WORDID_RIPEMD 95)
(defconstant $CSSM_WORDID_RIPEMD160 96)
(defconstant $CSSM_WORDID_RSA 97)
(defconstant $CSSM_WORDID_RSA_ISO9796 98)
(defconstant $CSSM_WORDID_RSA_PKCS 99)
(defconstant $CSSM_WORDID_RSA_PKCS_MD5 100)
(defconstant $CSSM_WORDID_RSA_PKCS_SHA1 101)
(defconstant $CSSM_WORDID_RSA_PKCS1 102)
(defconstant $CSSM_WORDID_RSA_PKCS1_MD5 103)
(defconstant $CSSM_WORDID_RSA_PKCS1_SHA1 104)
(defconstant $CSSM_WORDID_RSA_PKCS1_SIG 105)
(defconstant $CSSM_WORDID_RSA_RAW 106)
(defconstant $CSSM_WORDID_SDSIV1 107)
(defconstant $CSSM_WORDID_SEQUENCE 108)
(defconstant $CSSM_WORDID_SET 109)
(defconstant $CSSM_WORDID_SEXPR 110)
(defconstant $CSSM_WORDID_SHA1 111)
(defconstant $CSSM_WORDID_SHA1WITHDSA 112)
(defconstant $CSSM_WORDID_SHA1WITHECDSA 113)
(defconstant $CSSM_WORDID_SHA1WITHRSA 114)
(defconstant $CSSM_WORDID_SIGN 115)
(defconstant $CSSM_WORDID_SIGNATURE 116)
(defconstant $CSSM_WORDID_SIGNED_NONCE 117)
(defconstant $CSSM_WORDID_SIGNED_SECRET 118)
(defconstant $CSSM_WORDID_SPKI 119)
(defconstant $CSSM_WORDID_SUBJECT 120)
(defconstant $CSSM_WORDID_SUBJECT_INFO 121)
(defconstant $CSSM_WORDID_TAG 122)
(defconstant $CSSM_WORDID_THRESHOLD 123)
(defconstant $CSSM_WORDID_TIME 124)
(defconstant $CSSM_WORDID_URI 125)
(defconstant $CSSM_WORDID_VERSION 126)
(defconstant $CSSM_WORDID_X509_ATTRIBUTE 127)
(defconstant $CSSM_WORDID_X509V1 #x80)
(defconstant $CSSM_WORDID_X509V2 #x81)
(defconstant $CSSM_WORDID_X509V3 #x82)
(defconstant $CSSM_WORDID_X9_ATTRIBUTE #x83)
(defconstant $CSSM_WORDID_VENDOR_START #x10000)
(defconstant $CSSM_WORDID_VENDOR_END #x7FFF0000)

(def-mactype :CSSM_LIST_ELEMENT_TYPE_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_LIST_ELEMENT_DATUM 0)
(defconstant $CSSM_LIST_ELEMENT_SUBLIST 1)
(defconstant $CSSM_LIST_ELEMENT_WORDID 2)

(def-mactype :CSSM_LIST_TYPE_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_LIST_TYPE_UNKNOWN 0)
(defconstant $CSSM_LIST_TYPE_CUSTOM 1)
(defconstant $CSSM_LIST_TYPE_SEXPR 2)

(def-mactype :CSSM_LIST_ELEMENT_PTR (find-mactype '(:pointer :cssm_list_element)))
(defrecord cssm_list
   (ListType :cssm_list_type)
#|
; Warning: type-size: unknown type CSSM_LIST_TYPE
|#
                                                ;  type of this list 
   (Head (:pointer :cssm_list_element))
                                                ;  head of the list 
   (Tail (:pointer :cssm_list_element))
                                                ;  tail of the list 
)

(def-mactype :CSSM_LIST_PTR (find-mactype '(:POINTER :CSSM_LIST)))
(defrecord cssm_list_element
   (NextElement (:pointer :cssm_list_element))
                                                ;  next list element 
   (WordID :sint32)
                                                ;  integer identifier associated 
                                                ;  with a Word value 
   (ElementType :cssm_list_element_type)
#|
; Warning: type-size: unknown type CSSM_LIST_ELEMENT_TYPE
|#
   (:variant
   (
   (Sublist :CSSM_LIST)
   )
                                                ;  sublist 
   (
   (Word :CSSM_DATA)
   )
                                                ;  a byte-string 
   )
)
(defrecord CSSM_TUPLE                                                ;  5-tuple definition 
   (Issuer :CSSM_LIST)
                                                ;  issuer, or empty if ACL 
   (Subject :CSSM_LIST)
                                                ;  subject 
   (Delegate :sint32)
                                                ;  permission to delegate 
   (AuthorizationTag :CSSM_LIST)
                                                ;  authorization field 
   (ValidityPeriod :CSSM_LIST)
                                                ;  validity information (dates) 
#|
 confused about , * CSSM_TUPLE_PTR
|#
)
(defrecord cssm_tuplegroup
   (NumberOfTuples :uint32)
   (Tuples :cssm_tuple_ptr)
#|
; Warning: type-size: unknown type CSSM_TUPLE_PTR
|#
)

(def-mactype :CSSM_TUPLEGROUP_PTR (find-mactype '(:POINTER :CSSM_TUPLEGROUP)))

(def-mactype :CSSM_SAMPLE_TYPE (find-mactype ':sint32))

(defconstant $CSSM_SAMPLE_TYPE_PASSWORD 79)
(defconstant $CSSM_SAMPLE_TYPE_HASHED_PASSWORD 43)
(defconstant $CSSM_SAMPLE_TYPE_PROTECTED_PASSWORD 87)
(defconstant $CSSM_SAMPLE_TYPE_PROMPTED_PASSWORD 84)
(defconstant $CSSM_SAMPLE_TYPE_SIGNED_NONCE 117)
(defconstant $CSSM_SAMPLE_TYPE_SIGNED_SECRET 118)
(defconstant $CSSM_SAMPLE_TYPE_BIOMETRIC 8)
(defconstant $CSSM_SAMPLE_TYPE_PROTECTED_BIOMETRIC 86)
(defconstant $CSSM_SAMPLE_TYPE_PROMPTED_BIOMETRIC 83)
(defconstant $CSSM_SAMPLE_TYPE_THRESHOLD 123)
(defrecord cssm_sample
   (TypedSample :CSSM_LIST)
   (Verifier (:pointer :CSSM_SUBSERVICE_UID))
)

(def-mactype :CSSM_SAMPLE_PTR (find-mactype '(:POINTER :CSSM_SAMPLE)))
(defrecord cssm_samplegroup
   (NumberOfSamples :uint32)
   (Samples (:pointer :CSSM_SAMPLE))
)

(def-mactype :CSSM_SAMPLEGROUP_PTR (find-mactype '(:POINTER :CSSM_SAMPLEGROUP)))

;type name? (def-mactype :(CSSMAPI * CSSM_MALLOC) (find-mactype '(:pointer :void))); (uint32 size , void * allocref)

;type name? (def-mactype :(CSSMAPI * CSSM_FREE) (find-mactype ':void)); (void * memblock , void * allocref)

;type name? (def-mactype :(CSSMAPI * CSSM_REALLOC) (find-mactype '(:pointer :void))); (void * memblock , uint32 size , void * allocref)

;type name? (def-mactype :(CSSMAPI * CSSM_CALLOC) (find-mactype '(:pointer :void))); (uint32 num , uint32 size , void * allocref)
(defrecord cssm_memory_funcs
   (malloc_func :cssm_malloc)
#|
; Warning: type-size: unknown type CSSM_MALLOC
|#
   (free_func :cssm_free)
#|
; Warning: type-size: unknown type CSSM_FREE
|#
   (realloc_func :cssm_realloc)
#|
; Warning: type-size: unknown type CSSM_REALLOC
|#
   (calloc_func :cssm_calloc)
#|
; Warning: type-size: unknown type CSSM_CALLOC
|#
   (AllocRef :pointer)
)

(def-mactype :CSSM_MEMORY_FUNCS_PTR (find-mactype '(:POINTER :CSSM_MEMORY_FUNCS)))

(%define-record :CSSM_API_MEMORY_FUNCS (find-record-descriptor ':CSSM_MEMORY_FUNCS))

(def-mactype :CSSM_API_MEMORY_FUNCS_PTR (find-mactype '(:pointer :CSSM_MEMORY_FUNCS)))

;type name? (def-mactype :(CSSMAPI * CSSM_CHALLENGE_CALLBACK) (find-mactype ':sint32)); (const CSSM_LIST * Challenge , CSSM_SAMPLEGROUP_PTR Response , void * CallerCtx , const CSSM_MEMORY_FUNCS * MemFuncs)

(def-mactype :CSSM_CERT_TYPE_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_CERT_UNKNOWN 0)
(defconstant $CSSM_CERT_X_509v1 1)
(defconstant $CSSM_CERT_X_509v2 2)
(defconstant $CSSM_CERT_X_509v3 3)
(defconstant $CSSM_CERT_PGP 4)
(defconstant $CSSM_CERT_SPKI 5)
(defconstant $CSSM_CERT_SDSIv1 6)
(defconstant $CSSM_CERT_Intel 8)
(defconstant $CSSM_CERT_X_509_ATTRIBUTE 9)      ;  X.509 attribute cert 

(defconstant $CSSM_CERT_X9_ATTRIBUTE 10)        ;  X9 attribute cert 

(defconstant $CSSM_CERT_TUPLE 11)
(defconstant $CSSM_CERT_ACL_ENTRY 12)
(defconstant $CSSM_CERT_MULTIPLE #x7FFE)
(defconstant $CSSM_CERT_LAST #x7FFF)
;  Applications wishing to define their own custom certificate
; 	   type should define and publicly document a uint32 value greater
; 	   than the CSSM_CL_CUSTOM_CERT_TYPE 

(defconstant $CSSM_CL_CUSTOM_CERT_TYPE #x8000)

(def-mactype :CSSM_CERT_ENCODING_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_CERT_ENCODING_UNKNOWN 0)
(defconstant $CSSM_CERT_ENCODING_CUSTOM 1)
(defconstant $CSSM_CERT_ENCODING_BER 2)
(defconstant $CSSM_CERT_ENCODING_DER 3)
(defconstant $CSSM_CERT_ENCODING_NDR 4)
(defconstant $CSSM_CERT_ENCODING_SEXPR 5)
(defconstant $CSSM_CERT_ENCODING_PGP 6)
(defconstant $CSSM_CERT_ENCODING_MULTIPLE #x7FFE)
(defconstant $CSSM_CERT_ENCODING_LAST #x7FFF)
;  Applications wishing to define their own custom certificate
; 	   encoding should create a uint32 value greater than the
; 	   CSSM_CL_CUSTOM_CERT_ENCODING 

(defconstant $CSSM_CL_CUSTOM_CERT_ENCODING #x8000)
(defrecord cssm_encoded_cert
   (CertType :cssm_cert_type)
#|
; Warning: type-size: unknown type CSSM_CERT_TYPE
|#
                                                ;  type of certificate 
   (CertEncoding :cssm_cert_encoding)
#|
; Warning: type-size: unknown type CSSM_CERT_ENCODING
|#
                                                ;  encoding for this packed cert 
   (CertBlob :CSSM_DATA)
                                                ;  packed cert 
)

(def-mactype :CSSM_ENCODED_CERT_PTR (find-mactype '(:POINTER :CSSM_ENCODED_CERT)))

(def-mactype :CSSM_CERT_PARSE_FORMAT_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_CERT_PARSE_FORMAT_NONE 0)
(defconstant $CSSM_CERT_PARSE_FORMAT_CUSTOM 1)  ;  void* 

(defconstant $CSSM_CERT_PARSE_FORMAT_SEXPR 2)   ;  CSSM_LIST 

(defconstant $CSSM_CERT_PARSE_FORMAT_COMPLEX 3) ;  void* 

(defconstant $CSSM_CERT_PARSE_FORMAT_OID_NAMED 4);  CSSM_FIELDGROUP 

(defconstant $CSSM_CERT_PARSE_FORMAT_TUPLE 5)   ;  CSSM_TUPLE 

(defconstant $CSSM_CERT_PARSE_FORMAT_MULTIPLE #x7FFE)
;  multiple forms, each cert carries a
;    parse format indicator 

(defconstant $CSSM_CERT_PARSE_FORMAT_LAST #x7FFF)
;  Applications wishing to define their
;    own custom parse format should create
;    a * uint32 value greater than the
;    CSSM_CL_CUSTOM_CERT_PARSE_FORMAT 

(defconstant $CSSM_CL_CUSTOM_CERT_PARSE_FORMAT #x8000)
(defrecord cssm_parsed_cert
   (CertType :cssm_cert_type)
#|
; Warning: type-size: unknown type CSSM_CERT_TYPE
|#                                              ;  certificate type 
   (ParsedCertFormat :cssm_cert_parse_format)
#|
; Warning: type-size: unknown type CSSM_CERT_PARSE_FORMAT
|#
                                                ;  struct of ParsedCert 
   (ParsedCert :pointer)                        ;  parsed cert (to be typecast) 
)

(def-mactype :CSSM_PARSED_CERT_PTR (find-mactype '(:POINTER :CSSM_PARSED_CERT)))
(defrecord cssm_cert_pair
   (EncodedCert :CSSM_ENCODED_CERT)             ;  an encoded certificate blob 
   (ParsedCert :CSSM_PARSED_CERT)               ;  equivalent parsed certificate 
)

(def-mactype :CSSM_CERT_PAIR_PTR (find-mactype '(:POINTER :CSSM_CERT_PAIR)))

(def-mactype :CSSM_CERTGROUP_TYPE_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_CERTGROUP_DATA 0)
(defconstant $CSSM_CERTGROUP_ENCODED_CERT 1)
(defconstant $CSSM_CERTGROUP_PARSED_CERT 2)
(defconstant $CSSM_CERTGROUP_CERT_PAIR 3)
(defrecord cssm_certgroup
   (CertType :cssm_cert_type)
#|
; Warning: type-size: unknown type CSSM_CERT_TYPE
|#
   (CertEncoding :cssm_cert_encoding)
#|
; Warning: type-size: unknown type CSSM_CERT_ENCODING
|#
   (NumCerts :uint32)                           ;  # of certificates in this list 
   (:variant
   (
   (CertList (:pointer (:pointer :CSSM_DATA)))
   )
                                                ;  legacy list of single type certificate blobs 
   (
   (EncodedCertList (:pointer (:pointer :CSSM_ENCODED_CERT)))
   )
                                                ;  list of multi-type certificate blobs 
   (
   (ParsedCertList (:pointer (:pointer :CSSM_PARSED_CERT)))
   )
                                                ;  list of multi-type parsed certs 
   (
   (PairCertList (:pointer (:pointer :CSSM_CERT_PAIR)))
   )
                                                ; list of single or multi-type certs with two representations: blob and parsed 
   )
   (CertGroupType :cssm_certgroup_type)
#|
; Warning: type-size: unknown type CSSM_CERTGROUP_TYPE
|#
                                                ;  type of structure in the GroupList 
   (Reserved :pointer)                          ;  reserved for implementation dependent use 
)

(def-mactype :CSSM_CERTGROUP_PTR (find-mactype '(:POINTER :CSSM_CERTGROUP)))
(defrecord cssm_base_certs
   (TPHandle :CSSM_TP_HANDLE)
#|
; Warning: type-size: unknown type CSSM_TP_HANDLE
|#
   (CLHandle :CSSM_CL_HANDLE)
#|
; Warning: type-size: unknown type CSSM_CL_HANDLE
|#
   (Certs :CSSM_CERTGROUP)
)

(def-mactype :CSSM_BASE_CERTS_PTR (find-mactype '(:POINTER :CSSM_BASE_CERTS)))
(defrecord cssm_access_credentials
   (EntryTag :CSSM_STRING)
   (BaseCerts :CSSM_BASE_CERTS)
   (Samples :CSSM_SAMPLEGROUP)
   (Callback :cssm_challenge_callback)
#|
; Warning: type-size: unknown type CSSM_CHALLENGE_CALLBACK
|#
   (CallerCtx :pointer)
)

(def-mactype :CSSM_ACCESS_CREDENTIALS_PTR (find-mactype '(:POINTER :CSSM_ACCESS_CREDENTIALS)))

(def-mactype :CSSM_ACL_SUBJECT_TYPE (find-mactype ':sint32))

(defconstant $CSSM_ACL_SUBJECT_TYPE_ANY 1)
(defconstant $CSSM_ACL_SUBJECT_TYPE_THRESHOLD 123)
(defconstant $CSSM_ACL_SUBJECT_TYPE_PASSWORD 79)
(defconstant $CSSM_ACL_SUBJECT_TYPE_PROTECTED_PASSWORD 87)
(defconstant $CSSM_ACL_SUBJECT_TYPE_PROMPTED_PASSWORD 84)
(defconstant $CSSM_ACL_SUBJECT_TYPE_PUBLIC_KEY 89)
(defconstant $CSSM_ACL_SUBJECT_TYPE_HASHED_SUBJECT 44)
(defconstant $CSSM_ACL_SUBJECT_TYPE_BIOMETRIC 8)
(defconstant $CSSM_ACL_SUBJECT_TYPE_PROTECTED_BIOMETRIC 86)
(defconstant $CSSM_ACL_SUBJECT_TYPE_PROMPTED_BIOMETRIC 83)
(defconstant $CSSM_ACL_SUBJECT_TYPE_LOGIN_NAME 58)
(defconstant $CSSM_ACL_SUBJECT_TYPE_EXT_PAM_NAME 78)
;  Authorization tag type 

(def-mactype :CSSM_ACL_AUTHORIZATION_TAG (find-mactype ':sint32))
;  All vendor specific constants must be in the number range
; 	   starting at CSSM_ACL_AUTHORIZATION_TAG_VENDOR_DEFINED_START 

(defconstant $CSSM_ACL_AUTHORIZATION_TAG_VENDOR_DEFINED_START #x10000)
;  No restrictions. Permission to perform all operations on
; 	   the resource or available to an ACL owner.  

(defconstant $CSSM_ACL_AUTHORIZATION_ANY 1)     ;  Defined authorization tag values for CSPs 

(defconstant $CSSM_ACL_AUTHORIZATION_LOGIN 57)
(defconstant $CSSM_ACL_AUTHORIZATION_GENKEY 41)
(defconstant $CSSM_ACL_AUTHORIZATION_DELETE 25)
(defconstant $CSSM_ACL_AUTHORIZATION_EXPORT_WRAPPED 38)
(defconstant $CSSM_ACL_AUTHORIZATION_EXPORT_CLEAR 37)
(defconstant $CSSM_ACL_AUTHORIZATION_IMPORT_WRAPPED 48)
(defconstant $CSSM_ACL_AUTHORIZATION_IMPORT_CLEAR 47)
(defconstant $CSSM_ACL_AUTHORIZATION_SIGN 115)
(defconstant $CSSM_ACL_AUTHORIZATION_ENCRYPT 35)
(defconstant $CSSM_ACL_AUTHORIZATION_DECRYPT 24)
(defconstant $CSSM_ACL_AUTHORIZATION_MAC 59)
(defconstant $CSSM_ACL_AUTHORIZATION_DERIVE 28) ;  Defined authorization tag values for DLs 

(defconstant $CSSM_ACL_AUTHORIZATION_DBS_CREATE 22)
(defconstant $CSSM_ACL_AUTHORIZATION_DBS_DELETE 23)
(defconstant $CSSM_ACL_AUTHORIZATION_DB_READ 21)
(defconstant $CSSM_ACL_AUTHORIZATION_DB_INSERT 19)
(defconstant $CSSM_ACL_AUTHORIZATION_DB_MODIFY 20)
(defconstant $CSSM_ACL_AUTHORIZATION_DB_DELETE 17)
(defrecord cssm_authorizationgroup
   (NumberOfAuthTags :uint32)
   (AuthTags (:pointer :CSSM_ACL_AUTHORIZATION_TAG))
)

(def-mactype :CSSM_AUTHORIZATIONGROUP_PTR (find-mactype '(:POINTER :CSSM_AUTHORIZATIONGROUP)))
(defrecord cssm_acl_validity_period
   (StartDate :CSSM_DATA)
   (EndDate :CSSM_DATA)
)

(def-mactype :CSSM_ACL_VALIDITY_PERIOD_PTR (find-mactype '(:POINTER :CSSM_ACL_VALIDITY_PERIOD)))
(defrecord cssm_acl_entry_prototype
   (TypedSubject :CSSM_LIST)
   (Delegate :sint32)
   (Authorization :CSSM_AUTHORIZATIONGROUP)
   (TimeRange :CSSM_ACL_VALIDITY_PERIOD)
   (EntryTag :CSSM_STRING)
)

(def-mactype :CSSM_ACL_ENTRY_PROTOTYPE_PTR (find-mactype '(:POINTER :CSSM_ACL_ENTRY_PROTOTYPE)))
(defrecord cssm_acl_owner_prototype
   (TypedSubject :CSSM_LIST)
   (Delegate :sint32)
)

(def-mactype :CSSM_ACL_OWNER_PROTOTYPE_PTR (find-mactype '(:POINTER :CSSM_ACL_OWNER_PROTOTYPE)))

;type name? (def-mactype :(CSSMAPI * CSSM_ACL_SUBJECT_CALLBACK) (find-mactype ':sint32)); (const CSSM_LIST * SubjectRequest , CSSM_LIST_PTR SubjectResponse , void * CallerContext , const CSSM_MEMORY_FUNCS * MemFuncs)
(defrecord cssm_acl_entry_input
   (Prototype :CSSM_ACL_ENTRY_PROTOTYPE)
   (Callback :cssm_acl_subject_callback)
#|
; Warning: type-size: unknown type CSSM_ACL_SUBJECT_CALLBACK
|#
   (CallerContext :pointer)
)

(def-mactype :CSSM_ACL_ENTRY_INPUT_PTR (find-mactype '(:POINTER :CSSM_ACL_ENTRY_INPUT)))
(defrecord cssm_resource_control_context
   (AccessCred (:pointer (:pointer :CSSM_ACCESS_CREDENTIALS)))
   (InitialAclEntry :CSSM_ACL_ENTRY_INPUT)
)

(def-mactype :CSSM_RESOURCE_CONTROL_CONTEXT_PTR (find-mactype '(:POINTER :CSSM_RESOURCE_CONTROL_CONTEXT)))

(def-mactype :CSSM_ACL_HANDLE (find-mactype ':CSSM_HANDLE))
(defrecord cssm_acl_entry_info
   (EntryPublicInfo :CSSM_ACL_ENTRY_PROTOTYPE)
   (EntryHandle :CSSM_ACL_HANDLE)
#|
; Warning: type-size: unknown type CSSM_ACL_HANDLE
|#
)

(def-mactype :CSSM_ACL_ENTRY_INFO_PTR (find-mactype '(:POINTER :CSSM_ACL_ENTRY_INFO)))

(def-mactype :CSSM_ACL_EDIT_MODE (find-mactype ':uint32))

(defconstant $CSSM_ACL_EDIT_MODE_ADD 1)
(defconstant $CSSM_ACL_EDIT_MODE_DELETE 2)
(defconstant $CSSM_ACL_EDIT_MODE_REPLACE 3)
(defrecord cssm_acl_edit
   (EditMode :uint32)
   (OldEntryHandle :CSSM_ACL_HANDLE)
#|
; Warning: type-size: unknown type CSSM_ACL_HANDLE
|#
   (NewEntry (:pointer :CSSM_ACL_ENTRY_INPUT))
)

(def-mactype :CSSM_ACL_EDIT_PTR (find-mactype '(:POINTER :CSSM_ACL_EDIT)))

; #if defined(WIN32)
#| 
(def-mactype :CSSM_PROC_ADDR (find-mactype ':FARPROC))
 |#

; #else

;type name? (def-mactype :(CSSMAPI * CSSM_PROC_ADDR) (find-mactype ':void))

; #endif


(def-mactype :CSSM_PROC_ADDR_PTR (find-mactype '(:pointer :CSSM_PROC_ADDR)))
(defrecord cssm_func_name_addr
   (Name :CSSM_STRING)
   (Address :CSSM_PROC_ADDR)
#|
; Warning: type-size: unknown type CSSM_PROC_ADDR
|#
)

(def-mactype :CSSM_FUNC_NAME_ADDR_PTR (find-mactype '(:POINTER :CSSM_FUNC_NAME_ADDR)))
;  Data Types for Cryptographic Services  
(defrecord cssm_date
   (Year (:array :UInt8 4))
   (Month (:array :UInt8 2))
   (Day (:array :UInt8 2))
)

(def-mactype :CSSM_DATE_PTR (find-mactype '(:POINTER :CSSM_DATE)))
(defrecord cssm_range
   (Min :uint32)                                ;  inclusive minimum value 
   (Max :uint32)                                ;  inclusive maximum value 
)

(def-mactype :CSSM_RANGE_PTR (find-mactype '(:POINTER :CSSM_RANGE)))
(defrecord cssm_query_size_data
   (SizeInputBlock :uint32)                     ;  size of input data block 
   (SizeOutputBlock :uint32)                    ;  size of resulting output data block 
)

(def-mactype :CSSM_QUERY_SIZE_DATA_PTR (find-mactype '(:POINTER :CSSM_QUERY_SIZE_DATA)))

(def-mactype :CSSM_HEADERVERSION (find-mactype ':uint32))

(defconstant $CSSM_KEYHEADER_VERSION 2)
(defrecord cssm_key_size
   (LogicalKeySizeInBits :uint32)               ;  Logical key size in bits 
   (EffectiveKeySizeInBits :uint32)             ;  Effective key size in bits 
)

(def-mactype :CSSM_KEY_SIZE_PTR (find-mactype '(:POINTER :CSSM_KEY_SIZE)))

(def-mactype :CSSM_KEYBLOB_TYPE (find-mactype ':uint32))

(defconstant $CSSM_KEYBLOB_RAW 0)               ;  The blob is a clear, raw key 

(defconstant $CSSM_KEYBLOB_REFERENCE 2)         ;  The blob is a reference to a key 

(defconstant $CSSM_KEYBLOB_WRAPPED 3)           ;  The blob is a wrapped RAW key 

(defconstant $CSSM_KEYBLOB_OTHER #xFFFFFFFF)

(def-mactype :CSSM_KEYBLOB_FORMAT (find-mactype ':uint32))
;  Raw Format 

(defconstant $CSSM_KEYBLOB_RAW_FORMAT_NONE 0)   ;  No further conversion need to be done 

(defconstant $CSSM_KEYBLOB_RAW_FORMAT_PKCS1 1)  ;  RSA PKCS1 V1.5 

(defconstant $CSSM_KEYBLOB_RAW_FORMAT_PKCS3 2)  ;  RSA PKCS3 V1.5 

(defconstant $CSSM_KEYBLOB_RAW_FORMAT_MSCAPI 3) ;  Microsoft CAPI V2.0 

(defconstant $CSSM_KEYBLOB_RAW_FORMAT_PGP 4)    ;  PGP V 

(defconstant $CSSM_KEYBLOB_RAW_FORMAT_FIPS186 5);  US Gov. FIPS 186 - DSS V 

(defconstant $CSSM_KEYBLOB_RAW_FORMAT_BSAFE 6)  ;  RSA Bsafe V3.0 

(defconstant $CSSM_KEYBLOB_RAW_FORMAT_CCA 9)    ;  CCA clear public key blob 

(defconstant $CSSM_KEYBLOB_RAW_FORMAT_PKCS8 10) ;  RSA PKCS8 V1.2 

(defconstant $CSSM_KEYBLOB_RAW_FORMAT_SPKI 11)  ;  SPKI Specification 

(defconstant $CSSM_KEYBLOB_RAW_FORMAT_OCTET_STRING 12)
(defconstant $CSSM_KEYBLOB_RAW_FORMAT_OTHER #xFFFFFFFF);  Other, CSP defined 

;  Wrapped Format 

(defconstant $CSSM_KEYBLOB_WRAPPED_FORMAT_NONE 0);  No further conversion need to be done 

(defconstant $CSSM_KEYBLOB_WRAPPED_FORMAT_PKCS8 1);  RSA PKCS8 V1.2 

(defconstant $CSSM_KEYBLOB_WRAPPED_FORMAT_PKCS7 2)
(defconstant $CSSM_KEYBLOB_WRAPPED_FORMAT_MSCAPI 3)
(defconstant $CSSM_KEYBLOB_WRAPPED_FORMAT_OTHER #xFFFFFFFF);  Other, CSP defined 

;  Reference Format 

(defconstant $CSSM_KEYBLOB_REF_FORMAT_INTEGER 0);  Reference is a number or handle 

(defconstant $CSSM_KEYBLOB_REF_FORMAT_STRING 1) ;  Reference is a string or label 

(defconstant $CSSM_KEYBLOB_REF_FORMAT_SPKI 2)   ;  Reference is an SPKI S-expression 
;  to be evaluated to locate the key 

(defconstant $CSSM_KEYBLOB_REF_FORMAT_OTHER #xFFFFFFFF);  Other, CSP defined 


(def-mactype :CSSM_KEYCLASS (find-mactype ':uint32))

(defconstant $CSSM_KEYCLASS_PUBLIC_KEY 0)       ;  Key is public key 

(defconstant $CSSM_KEYCLASS_PRIVATE_KEY 1)      ;  Key is private key 

(defconstant $CSSM_KEYCLASS_SESSION_KEY 2)      ;  Key is session or symmetric key 

(defconstant $CSSM_KEYCLASS_SECRET_PART 3)      ;  Key is part of secret key 

(defconstant $CSSM_KEYCLASS_OTHER #xFFFFFFFF)   ;  Other 


(def-mactype :CSSM_KEYATTR_FLAGS (find-mactype ':uint32))
;  Valid only during call to an API. Will never be valid when set in a key header 

(defconstant $CSSM_KEYATTR_RETURN_DEFAULT 0)
(defconstant $CSSM_KEYATTR_RETURN_DATA #x10000000)
(defconstant $CSSM_KEYATTR_RETURN_REF #x20000000)
(defconstant $CSSM_KEYATTR_RETURN_NONE #x40000000);  Valid during an API call and in a key header 

(defconstant $CSSM_KEYATTR_PERMANENT 1)
(defconstant $CSSM_KEYATTR_PRIVATE 2)
(defconstant $CSSM_KEYATTR_MODIFIABLE 4)
(defconstant $CSSM_KEYATTR_SENSITIVE 8)
(defconstant $CSSM_KEYATTR_EXTRACTABLE 32)      ;  Valid only in a key header generated by a CSP, not valid during an API call 

(defconstant $CSSM_KEYATTR_ALWAYS_SENSITIVE 16)
(defconstant $CSSM_KEYATTR_NEVER_EXTRACTABLE 64)

(def-mactype :CSSM_KEYUSE (find-mactype ':uint32))

(defconstant $CSSM_KEYUSE_ANY #x80000000)
(defconstant $CSSM_KEYUSE_ENCRYPT 1)
(defconstant $CSSM_KEYUSE_DECRYPT 2)
(defconstant $CSSM_KEYUSE_SIGN 4)
(defconstant $CSSM_KEYUSE_VERIFY 8)
(defconstant $CSSM_KEYUSE_SIGN_RECOVER 16)
(defconstant $CSSM_KEYUSE_VERIFY_RECOVER 32)
(defconstant $CSSM_KEYUSE_WRAP 64)
(defconstant $CSSM_KEYUSE_UNWRAP #x80)
(defconstant $CSSM_KEYUSE_DERIVE #x100)

(def-mactype :CSSM_ALGORITHMS (find-mactype ':uint32))

(defconstant $CSSM_ALGID_NONE 0)
(defconstant $CSSM_ALGID_CUSTOM 1)
(defconstant $CSSM_ALGID_DH 2)
(defconstant $CSSM_ALGID_PH 3)
(defconstant $CSSM_ALGID_KEA 4)
(defconstant $CSSM_ALGID_MD2 5)
(defconstant $CSSM_ALGID_MD4 6)
(defconstant $CSSM_ALGID_MD5 7)
(defconstant $CSSM_ALGID_SHA1 8)
(defconstant $CSSM_ALGID_NHASH 9)
(defconstant $CSSM_ALGID_HAVAL 10)
(defconstant $CSSM_ALGID_RIPEMD 11)
(defconstant $CSSM_ALGID_IBCHASH 12)
(defconstant $CSSM_ALGID_RIPEMAC 13)
(defconstant $CSSM_ALGID_DES 14)
(defconstant $CSSM_ALGID_DESX 15)
(defconstant $CSSM_ALGID_RDES 16)
(defconstant $CSSM_ALGID_3DES_3KEY_EDE 17)
(defconstant $CSSM_ALGID_3DES_2KEY_EDE 18)
(defconstant $CSSM_ALGID_3DES_1KEY_EEE 19)
(defconstant $CSSM_ALGID_3DES_3KEY 17)
(defconstant $CSSM_ALGID_3DES_3KEY_EEE 20)
(defconstant $CSSM_ALGID_3DES_2KEY 18)
(defconstant $CSSM_ALGID_3DES_2KEY_EEE 21)
(defconstant $CSSM_ALGID_3DES_1KEY 20)
(defconstant $CSSM_ALGID_IDEA 22)
(defconstant $CSSM_ALGID_RC2 23)
(defconstant $CSSM_ALGID_RC5 24)
(defconstant $CSSM_ALGID_RC4 25)
(defconstant $CSSM_ALGID_SEAL 26)
(defconstant $CSSM_ALGID_CAST 27)
(defconstant $CSSM_ALGID_BLOWFISH 28)
(defconstant $CSSM_ALGID_SKIPJACK 29)
(defconstant $CSSM_ALGID_LUCIFER 30)
(defconstant $CSSM_ALGID_MADRYGA 31)
(defconstant $CSSM_ALGID_FEAL 32)
(defconstant $CSSM_ALGID_REDOC 33)
(defconstant $CSSM_ALGID_REDOC3 34)
(defconstant $CSSM_ALGID_LOKI 35)
(defconstant $CSSM_ALGID_KHUFU 36)
(defconstant $CSSM_ALGID_KHAFRE 37)
(defconstant $CSSM_ALGID_MMB 38)
(defconstant $CSSM_ALGID_GOST 39)
(defconstant $CSSM_ALGID_SAFER 40)
(defconstant $CSSM_ALGID_CRAB 41)
(defconstant $CSSM_ALGID_RSA 42)
(defconstant $CSSM_ALGID_DSA 43)
(defconstant $CSSM_ALGID_MD5WithRSA 44)
(defconstant $CSSM_ALGID_MD2WithRSA 45)
(defconstant $CSSM_ALGID_ElGamal 46)
(defconstant $CSSM_ALGID_MD2Random 47)
(defconstant $CSSM_ALGID_MD5Random 48)
(defconstant $CSSM_ALGID_SHARandom 49)
(defconstant $CSSM_ALGID_DESRandom 50)
(defconstant $CSSM_ALGID_SHA1WithRSA 51)
(defconstant $CSSM_ALGID_CDMF 52)
(defconstant $CSSM_ALGID_CAST3 53)
(defconstant $CSSM_ALGID_CAST5 54)
(defconstant $CSSM_ALGID_GenericSecret 55)
(defconstant $CSSM_ALGID_ConcatBaseAndKey 56)
(defconstant $CSSM_ALGID_ConcatKeyAndBase 57)
(defconstant $CSSM_ALGID_ConcatBaseAndData 58)
(defconstant $CSSM_ALGID_ConcatDataAndBase 59)
(defconstant $CSSM_ALGID_XORBaseAndData 60)
(defconstant $CSSM_ALGID_ExtractFromKey 61)
(defconstant $CSSM_ALGID_SSL3PreMasterGen 62)
(defconstant $CSSM_ALGID_SSL3MasterDerive 63)
(defconstant $CSSM_ALGID_SSL3KeyAndMacDerive 64)
(defconstant $CSSM_ALGID_SSL3MD5_MAC 65)
(defconstant $CSSM_ALGID_SSL3SHA1_MAC 66)
(defconstant $CSSM_ALGID_PKCS5_PBKDF1_MD5 67)
(defconstant $CSSM_ALGID_PKCS5_PBKDF1_MD2 68)
(defconstant $CSSM_ALGID_PKCS5_PBKDF1_SHA1 69)
(defconstant $CSSM_ALGID_WrapLynks 70)
(defconstant $CSSM_ALGID_WrapSET_OAEP 71)
(defconstant $CSSM_ALGID_BATON 72)
(defconstant $CSSM_ALGID_ECDSA 73)
(defconstant $CSSM_ALGID_MAYFLY 74)
(defconstant $CSSM_ALGID_JUNIPER 75)
(defconstant $CSSM_ALGID_FASTHASH 76)
(defconstant $CSSM_ALGID_3DES 77)
(defconstant $CSSM_ALGID_SSL3MD5 78)
(defconstant $CSSM_ALGID_SSL3SHA1 79)
(defconstant $CSSM_ALGID_FortezzaTimestamp 80)
(defconstant $CSSM_ALGID_SHA1WithDSA 81)
(defconstant $CSSM_ALGID_SHA1WithECDSA 82)
(defconstant $CSSM_ALGID_DSA_BSAFE 83)
(defconstant $CSSM_ALGID_ECDH 84)
(defconstant $CSSM_ALGID_ECMQV 85)
(defconstant $CSSM_ALGID_PKCS12_SHA1_PBE 86)
(defconstant $CSSM_ALGID_ECNRA 87)
(defconstant $CSSM_ALGID_SHA1WithECNRA 88)
(defconstant $CSSM_ALGID_ECES 89)
(defconstant $CSSM_ALGID_ECAES 90)
(defconstant $CSSM_ALGID_SHA1HMAC 91)
(defconstant $CSSM_ALGID_FIPS186Random 92)
(defconstant $CSSM_ALGID_ECC 93)
(defconstant $CSSM_ALGID_MQV 94)
(defconstant $CSSM_ALGID_NRA 95)
(defconstant $CSSM_ALGID_IntelPlatformRandom 96)
(defconstant $CSSM_ALGID_UTC 97)
(defconstant $CSSM_ALGID_HAVAL3 98)
(defconstant $CSSM_ALGID_HAVAL4 99)
(defconstant $CSSM_ALGID_HAVAL5 100)
(defconstant $CSSM_ALGID_TIGER 101)
(defconstant $CSSM_ALGID_MD5HMAC 102)
(defconstant $CSSM_ALGID_PKCS5_PBKDF2 103)
(defconstant $CSSM_ALGID_RUNNING_COUNTER 104)
(defconstant $CSSM_ALGID_LAST #x7FFFFFFF)
;  All algorithms IDs that are vendor specific, and not
;    part of the CSSM specification should be defined relative
;    to CSSM_ALGID_VENDOR_DEFINED. 

(defconstant $CSSM_ALGID_VENDOR_DEFINED #x80000000)

(def-mactype :CSSM_ENCRYPT_MODE (find-mactype ':uint32))

(defconstant $CSSM_ALGMODE_NONE 0)
(defconstant $CSSM_ALGMODE_CUSTOM 1)
(defconstant $CSSM_ALGMODE_ECB 2)
(defconstant $CSSM_ALGMODE_ECBPad 3)
(defconstant $CSSM_ALGMODE_CBC 4)
(defconstant $CSSM_ALGMODE_CBC_IV8 5)
(defconstant $CSSM_ALGMODE_CBCPadIV8 6)
(defconstant $CSSM_ALGMODE_CFB 7)
(defconstant $CSSM_ALGMODE_CFB_IV8 8)
(defconstant $CSSM_ALGMODE_CFBPadIV8 9)
(defconstant $CSSM_ALGMODE_OFB 10)
(defconstant $CSSM_ALGMODE_OFB_IV8 11)
(defconstant $CSSM_ALGMODE_OFBPadIV8 12)
(defconstant $CSSM_ALGMODE_COUNTER 13)
(defconstant $CSSM_ALGMODE_BC 14)
(defconstant $CSSM_ALGMODE_PCBC 15)
(defconstant $CSSM_ALGMODE_CBCC 16)
(defconstant $CSSM_ALGMODE_OFBNLF 17)
(defconstant $CSSM_ALGMODE_PBC 18)
(defconstant $CSSM_ALGMODE_PFB 19)
(defconstant $CSSM_ALGMODE_CBCPD 20)
(defconstant $CSSM_ALGMODE_PUBLIC_KEY 21)
(defconstant $CSSM_ALGMODE_PRIVATE_KEY 22)
(defconstant $CSSM_ALGMODE_SHUFFLE 23)
(defconstant $CSSM_ALGMODE_ECB64 24)
(defconstant $CSSM_ALGMODE_CBC64 25)
(defconstant $CSSM_ALGMODE_OFB64 26)
(defconstant $CSSM_ALGMODE_CFB32 28)
(defconstant $CSSM_ALGMODE_CFB16 29)
(defconstant $CSSM_ALGMODE_CFB8 30)
(defconstant $CSSM_ALGMODE_WRAP 31)
(defconstant $CSSM_ALGMODE_PRIVATE_WRAP 32)
(defconstant $CSSM_ALGMODE_RELAYX 33)
(defconstant $CSSM_ALGMODE_ECB128 34)
(defconstant $CSSM_ALGMODE_ECB96 35)
(defconstant $CSSM_ALGMODE_CBC128 36)
(defconstant $CSSM_ALGMODE_OAEP_HASH 37)
(defconstant $CSSM_ALGMODE_PKCS1_EME_V15 38)
(defconstant $CSSM_ALGMODE_PKCS1_EME_OAEP 39)
(defconstant $CSSM_ALGMODE_PKCS1_EMSA_V15 40)
(defconstant $CSSM_ALGMODE_ISO_9796 41)
(defconstant $CSSM_ALGMODE_X9_31 42)
(defconstant $CSSM_ALGMODE_LAST #x7FFFFFFF)
;  All algorithms modes that are vendor specific, and
;    not part of the CSSM specification should be defined
;    relative to CSSM_ALGMODE_VENDOR_DEFINED. 

(defconstant $CSSM_ALGMODE_VENDOR_DEFINED #x80000000)
(defrecord cssm_keyheader
   (HeaderVersion :uint32)                      ;  Key header version 
   (CspId :CSSM_GUID)                           ;  GUID of CSP generating the key 
   (BlobType :uint32)                           ;  See BlobType enum 
   (Format :uint32)                             ;  Raw or Reference format 
   (AlgorithmId :uint32)                        ;  Algorithm ID of key 
   (KeyClass :uint32)                           ;  Public/Private/Secret, etc. 
   (LogicalKeySizeInBits :uint32)               ;  Logical key size in bits 
   (KeyAttr :uint32)                            ;  Attribute flags 
   (KeyUsage :uint32)                           ;  Key use flags 
   (StartDate :CSSM_DATE)                       ;  Effective date of key 
   (EndDate :CSSM_DATE)                         ;  Expiration date of key 
   (WrapAlgorithmId :uint32)                    ;  == CSSM_ALGID_NONE if clear key 
   (WrapMode :uint32)                           ;  if alg supports multiple wrapping modes 
   (Reserved :uint32)
)

(def-mactype :CSSM_KEYHEADER_PTR (find-mactype '(:POINTER :CSSM_KEYHEADER)))
(defrecord cssm_key
   (KeyHeader :CSSM_KEYHEADER)                  ;  Fixed length key header 
   (KeyData :CSSM_DATA)                         ;  Variable length key data 
)

(def-mactype :CSSM_KEY_PTR (find-mactype '(:POINTER :CSSM_KEY)))

(def-mactype :CSSM_WRAP_KEY_PTR (find-mactype '(:POINTER :CSSM_KEY)))

(def-mactype :CSSM_CSPTYPE (find-mactype ':uint32))

(defconstant $CSSM_CSP_SOFTWARE 1)
(defconstant $CSSM_CSP_HARDWARE 2)
(defconstant $CSSM_CSP_HYBRID 3)
;  From DL. 
(defrecord cssm_dl_db_handle
   (DLHandle :CSSM_DL_HANDLE)
#|
; Warning: type-size: unknown type CSSM_DL_HANDLE
|#
   (DBHandle :CSSM_DB_HANDLE)
#|
; Warning: type-size: unknown type CSSM_DB_HANDLE
|#
)

(def-mactype :CSSM_DL_DB_HANDLE_PTR (find-mactype '(:POINTER :CSSM_DL_DB_HANDLE)))

(def-mactype :CSSM_CONTEXT_TYPE (find-mactype ':uint32))

(defconstant $CSSM_ALGCLASS_NONE 0)
(defconstant $CSSM_ALGCLASS_CUSTOM 1)
(defconstant $CSSM_ALGCLASS_SIGNATURE 2)
(defconstant $CSSM_ALGCLASS_SYMMETRIC 3)
(defconstant $CSSM_ALGCLASS_DIGEST 4)
(defconstant $CSSM_ALGCLASS_RANDOMGEN 5)
(defconstant $CSSM_ALGCLASS_UNIQUEGEN 6)
(defconstant $CSSM_ALGCLASS_MAC 7)
(defconstant $CSSM_ALGCLASS_ASYMMETRIC 8)
(defconstant $CSSM_ALGCLASS_KEYGEN 9)
(defconstant $CSSM_ALGCLASS_DERIVEKEY 10)
;  Attribute data type tags 

(defconstant $CSSM_ATTRIBUTE_DATA_NONE 0)
(defconstant $CSSM_ATTRIBUTE_DATA_UINT32 #x10000000)
(defconstant $CSSM_ATTRIBUTE_DATA_CSSM_DATA #x20000000)
(defconstant $CSSM_ATTRIBUTE_DATA_CRYPTO_DATA #x30000000)
(defconstant $CSSM_ATTRIBUTE_DATA_KEY #x40000000)
(defconstant $CSSM_ATTRIBUTE_DATA_STRING #x50000000)
(defconstant $CSSM_ATTRIBUTE_DATA_DATE #x60000000)
(defconstant $CSSM_ATTRIBUTE_DATA_RANGE #x70000000)
(defconstant $CSSM_ATTRIBUTE_DATA_ACCESS_CREDENTIALS #x80000000)
(defconstant $CSSM_ATTRIBUTE_DATA_VERSION #x1000000)
(defconstant $CSSM_ATTRIBUTE_DATA_DL_DB_HANDLE #x2000000)
(defconstant $CSSM_ATTRIBUTE_DATA_KR_PROFILE #x3000000)
(defconstant $CSSM_ATTRIBUTE_TYPE_MASK #xFF000000)

(def-mactype :CSSM_ATTRIBUTE_TYPE (find-mactype ':uint32))

(defconstant $CSSM_ATTRIBUTE_NONE 0)
(defconstant $CSSM_ATTRIBUTE_CUSTOM #x20000001)
(defconstant $CSSM_ATTRIBUTE_DESCRIPTION #x50000002)
(defconstant $CSSM_ATTRIBUTE_KEY #x40000003)
(defconstant $CSSM_ATTRIBUTE_INIT_VECTOR #x20000004)
(defconstant $CSSM_ATTRIBUTE_SALT #x20000005)
(defconstant $CSSM_ATTRIBUTE_PADDING #x10000006)
(defconstant $CSSM_ATTRIBUTE_RANDOM #x20000007)
(defconstant $CSSM_ATTRIBUTE_SEED #x30000008)
(defconstant $CSSM_ATTRIBUTE_PASSPHRASE #x30000009)
(defconstant $CSSM_ATTRIBUTE_KEY_LENGTH #x1000000A)
(defconstant $CSSM_ATTRIBUTE_KEY_LENGTH_RANGE #x7000000B)
(defconstant $CSSM_ATTRIBUTE_BLOCK_SIZE #x1000000C)
(defconstant $CSSM_ATTRIBUTE_OUTPUT_SIZE #x1000000D)
(defconstant $CSSM_ATTRIBUTE_ROUNDS #x1000000E)
(defconstant $CSSM_ATTRIBUTE_IV_SIZE #x1000000F)
(defconstant $CSSM_ATTRIBUTE_ALG_PARAMS #x20000010)
(defconstant $CSSM_ATTRIBUTE_LABEL #x20000011)
(defconstant $CSSM_ATTRIBUTE_KEY_TYPE #x10000012)
(defconstant $CSSM_ATTRIBUTE_MODE #x10000013)
(defconstant $CSSM_ATTRIBUTE_EFFECTIVE_BITS #x10000014)
(defconstant $CSSM_ATTRIBUTE_START_DATE #x60000015)
(defconstant $CSSM_ATTRIBUTE_END_DATE #x60000016)
(defconstant $CSSM_ATTRIBUTE_KEYUSAGE #x10000017)
(defconstant $CSSM_ATTRIBUTE_KEYATTR #x10000018)
(defconstant $CSSM_ATTRIBUTE_VERSION #x1000019)
(defconstant $CSSM_ATTRIBUTE_PRIME #x2000001A)
(defconstant $CSSM_ATTRIBUTE_BASE #x2000001B)
(defconstant $CSSM_ATTRIBUTE_SUBPRIME #x2000001C)
(defconstant $CSSM_ATTRIBUTE_ALG_ID #x1000001D)
(defconstant $CSSM_ATTRIBUTE_ITERATION_COUNT #x1000001E)
(defconstant $CSSM_ATTRIBUTE_ROUNDS_RANGE #x7000001F)
(defconstant $CSSM_ATTRIBUTE_KRPROFILE_LOCAL #x3000020)
(defconstant $CSSM_ATTRIBUTE_KRPROFILE_REMOTE #x3000021)
(defconstant $CSSM_ATTRIBUTE_CSP_HANDLE #x10000022)
(defconstant $CSSM_ATTRIBUTE_DL_DB_HANDLE #x2000023)
(defconstant $CSSM_ATTRIBUTE_ACCESS_CREDENTIALS #x80000024)
(defconstant $CSSM_ATTRIBUTE_PUBLIC_KEY_FORMAT #x10000025)
(defconstant $CSSM_ATTRIBUTE_PRIVATE_KEY_FORMAT #x10000026)
(defconstant $CSSM_ATTRIBUTE_SYMMETRIC_KEY_FORMAT #x10000027)
(defconstant $CSSM_ATTRIBUTE_WRAPPED_KEY_FORMAT #x10000028)

(def-mactype :CSSM_PADDING (find-mactype ':uint32))

(defconstant $CSSM_PADDING_NONE 0)
(defconstant $CSSM_PADDING_CUSTOM 1)
(defconstant $CSSM_PADDING_ZERO 2)
(defconstant $CSSM_PADDING_ONE 3)
(defconstant $CSSM_PADDING_ALTERNATE 4)
(defconstant $CSSM_PADDING_FF 5)
(defconstant $CSSM_PADDING_PKCS5 6)
(defconstant $CSSM_PADDING_PKCS7 7)
(defconstant $CSSM_PADDING_CIPHERSTEALING 8)
(defconstant $CSSM_PADDING_RANDOM 9)
(defconstant $CSSM_PADDING_PKCS1 10)
;  All padding types that are vendor specific, and not
;    part of the CSSM specification should be defined
;    relative to CSSM_PADDING_VENDOR_DEFINED. 

(defconstant $CSSM_PADDING_VENDOR_DEFINED #x80000000)

(def-mactype :CSSM_KEY_TYPE (find-mactype ':uint32))
(defrecord cssm_context_attribute
   (AttributeType :uint32)
   (AttributeLength :uint32)
   (:variant
   (
   (String (:pointer :char))
   )
   (
   (Uint32 :uint32)
   )
   (
   (AccessCredentials (:pointer (:pointer :CSSM_ACCESS_CREDENTIALS)))
   )
   (
   (Key (:pointer (:pointer :CSSM_KEY)))
   )
   (
   (Data (:pointer (:pointer :CSSM_DATA)))
   )
   (
   (Padding :uint32)
   )
   (
   (Date (:pointer (:pointer :CSSM_DATE)))
   )
   (
   (Range (:pointer (:pointer :CSSM_RANGE)))
   )
   (
   (CryptoData (:pointer (:pointer :CSSM_CRYPTO_DATA)))
   )
   (
   (Version (:pointer (:pointer :CSSM_VERSION)))
   )
   (
   (DLDBHandle (:pointer (:pointer :CSSM_DL_DB_HANDLE)))
   )
   (
   (KRProfile (:pointer :cssm_kr_profile))
   )
   )
)

(def-mactype :CSSM_CONTEXT_ATTRIBUTE_PTR (find-mactype '(:POINTER :CSSM_CONTEXT_ATTRIBUTE)))
(defrecord cssm_context
   (ContextType :uint32)
   (AlgorithmType :uint32)
   (NumberOfAttributes :uint32)
   (ContextAttributes (:pointer (:pointer :CSSM_CONTEXT_ATTRIBUTE)))
   (CSPHandle :CSSM_CSP_HANDLE)
#|
; Warning: type-size: unknown type CSSM_CSP_HANDLE
|#
   (Privileged :sint32)
                                                ; CSSM_KR_POLICY_FLAGS
   (EncryptionProhibited :uint32)
   (WorkFactor :uint32)
   (Reserved :uint32)
                                                ;  reserved for future use 
)

(def-mactype :CSSM_CONTEXT_PTR (find-mactype '(:POINTER :CSSM_CONTEXT)))

(def-mactype :CSSM_SC_FLAGS (find-mactype ':uint32))

(defconstant $CSSM_CSP_TOK_RNG 1)
(defconstant $CSSM_CSP_TOK_CLOCK_EXISTS 64)

(def-mactype :CSSM_CSP_READER_FLAGS (find-mactype ':uint32))

(defconstant $CSSM_CSP_RDR_TOKENPRESENT 1)      ;  Token is present in reader/slot 

(defconstant $CSSM_CSP_RDR_EXISTS 2)
;  Device is a reader with a
; 	   removable token 

(defconstant $CSSM_CSP_RDR_HW 4)                ;  Slot is a hardware slot 


(def-mactype :CSSM_CSP_FLAGS (find-mactype ':uint32))

(defconstant $CSSM_CSP_TOK_WRITE_PROTECTED 2)
(defconstant $CSSM_CSP_TOK_LOGIN_REQUIRED 4)
(defconstant $CSSM_CSP_TOK_USER_PIN_INITIALIZED 8)
(defconstant $CSSM_CSP_TOK_PROT_AUTHENTICATION #x100)
(defconstant $CSSM_CSP_TOK_USER_PIN_EXPIRED #x100000)
(defconstant $CSSM_CSP_TOK_SESSION_KEY_PASSWORD #x200000)
(defconstant $CSSM_CSP_TOK_PRIVATE_KEY_PASSWORD #x400000)
(defconstant $CSSM_CSP_STORES_PRIVATE_KEYS #x1000000)
(defconstant $CSSM_CSP_STORES_PUBLIC_KEYS #x2000000)
(defconstant $CSSM_CSP_STORES_SESSION_KEYS #x4000000)
(defconstant $CSSM_CSP_STORES_CERTIFICATES #x8000000)
(defconstant $CSSM_CSP_STORES_GENERIC #x10000000)

(def-mactype :CSSM_PKCS_OAEP_MGF (find-mactype ':uint32))

(defconstant $CSSM_PKCS_OAEP_MGF_NONE 0)
(defconstant $CSSM_PKCS_OAEP_MGF1_SHA1 1)
(defconstant $CSSM_PKCS_OAEP_MGF1_MD5 2)

(def-mactype :CSSM_PKCS_OAEP_PSOURCE (find-mactype ':uint32))

(defconstant $CSSM_PKCS_OAEP_PSOURCE_NONE 0)
(defconstant $CSSM_PKCS_OAEP_PSOURCE_Pspecified 1)
(defrecord cssm_pkcs1_oaep_params
   (HashAlgorithm :uint32)
   (HashParams :CSSM_DATA)
   (MGF :uint32)
   (MGFParams :CSSM_DATA)
   (PSource :uint32)
   (PSourceParams :CSSM_DATA)
)

(def-mactype :CSSM_PKCS1_OAEP_PARAMS_PTR (find-mactype '(:POINTER :CSSM_PKCS1_OAEP_PARAMS)))
(defrecord cssm_csp_operational_statistics
   (UserAuthenticated :sint32)
                                                ;  CSSM_TRUE if the user is logged in to the token, CSSM_FALSE otherwise. 
   (DeviceFlags :uint32)
   (TokenMaxSessionCount :uint32)               ;  Exported by Cryptoki modules. 
   (TokenOpenedSessionCount :uint32)
   (TokenMaxRWSessionCount :uint32)
   (TokenOpenedRWSessionCount :uint32)
   (TokenTotalPublicMem :uint32)                ;  Storage space statistics. 
   (TokenFreePublicMem :uint32)
   (TokenTotalPrivateMem :uint32)
   (TokenFreePrivateMem :uint32)
)

(def-mactype :CSSM_CSP_OPERATIONAL_STATISTICS_PTR (find-mactype '(:POINTER :CSSM_CSP_OPERATIONAL_STATISTICS)))
;  Indicates that the statistical value can not be revealed or is not
;    relevant for a CSP 

(defconstant $CSSM_VALUE_NOT_AVAILABLE $$~0)
(defrecord cssm_pkcs5_pbkdf1_params
   (Passphrase :CSSM_DATA)
   (InitVector :CSSM_DATA)
)

(def-mactype :CSSM_PKCS5_PBKDF1_PARAMS_PTR (find-mactype '(:POINTER :CSSM_PKCS5_PBKDF1_PARAMS)))

(def-mactype :CSSM_PKCS5_PBKDF2_PRF (find-mactype ':uint32))

(defconstant $CSSM_PKCS5_PBKDF2_PRF_HMAC_SHA1 0)
(defrecord cssm_pkcs5_pbkdf2_params
   (Passphrase :CSSM_DATA)
   (PseudoRandomFunction :uint32)
)

(def-mactype :CSSM_PKCS5_PBKDF2_PARAMS_PTR (find-mactype '(:POINTER :CSSM_PKCS5_PBKDF2_PARAMS)))
(defrecord cssm_kea_derive_params
   (Rb :CSSM_DATA)
   (Yb :CSSM_DATA)
)

(def-mactype :CSSM_KEA_DERIVE_PARAMS_PTR (find-mactype '(:POINTER :CSSM_KEA_DERIVE_PARAMS)))
;  Data Types for Trust Policy Services  
(defrecord cssm_tp_authority_id
   (AuthorityCert (:pointer :CSSM_DATA))
   (AuthorityLocation (:pointer (:pointer :CSSM_NET_ADDRESS)))
)

(def-mactype :CSSM_TP_AUTHORITY_ID_PTR (find-mactype '(:POINTER :CSSM_TP_AUTHORITY_ID)))

(def-mactype :CSSM_TP_AUTHORITY_REQUEST_TYPE_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_TP_AUTHORITY_REQUEST_CERTISSUE 1)
(defconstant $CSSM_TP_AUTHORITY_REQUEST_CERTREVOKE 2)
(defconstant $CSSM_TP_AUTHORITY_REQUEST_CERTSUSPEND 3)
(defconstant $CSSM_TP_AUTHORITY_REQUEST_CERTRESUME 4)
(defconstant $CSSM_TP_AUTHORITY_REQUEST_CERTVERIFY 5)
(defconstant $CSSM_TP_AUTHORITY_REQUEST_CERTNOTARIZE 6)
(defconstant $CSSM_TP_AUTHORITY_REQUEST_CERTUSERECOVER 7)
(defconstant $CSSM_TP_AUTHORITY_REQUEST_CRLISSUE #x100)

;type name? (def-mactype :(CSSMAPI * CSSM_TP_VERIFICATION_RESULTS_CALLBACK) (find-mactype ':sint32)); (CSSM_MODULE_HANDLE ModuleHandle , void * CallerCtx , CSSM_DATA_PTR VerifiedCert)
;  From CL 

(def-mactype :CSSM_OID_PTR (find-mactype '(:POINTER :CSSM_DATA)))
(defrecord cssm_field
   (FieldOid :cssm_oid)
#|
; Warning: type-size: unknown type CSSM_OID
|#
   (FieldValue :CSSM_DATA)
)

(def-mactype :CSSM_FIELD_PTR (find-mactype '(:POINTER :CSSM_FIELD)))
;  TP Again. 
(defrecord cssm_tp_policyinfo
   (NumberOfPolicyIds :uint32)
   (PolicyIds (:pointer (:pointer :CSSM_FIELD)))
   (PolicyControl :pointer)
)

(def-mactype :CSSM_TP_POLICYINFO_PTR (find-mactype '(:POINTER :CSSM_TP_POLICYINFO)))

(def-mactype :CSSM_TP_SERVICES (find-mactype ':uint32))
;  bit masks for additional Authority services available through TP 

(defconstant $CSSM_TP_KEY_ARCHIVE 1)            ;  archive cert & keys 

(defconstant $CSSM_TP_CERT_PUBLISH 2)           ;  register cert in directory 

(defconstant $CSSM_TP_CERT_NOTIFY_RENEW 4)      ;  notify at renewal time 

(defconstant $CSSM_TP_CERT_DIR_UPDATE 8)        ;  update cert registry entry 

(defconstant $CSSM_TP_CRL_DISTRIBUTE 16)        ;  push CRL to everyone 


(def-mactype :CSSM_TP_ACTION (find-mactype ':uint32))

(defconstant $CSSM_TP_ACTION_DEFAULT 0)

(def-mactype :CSSM_TP_STOP_ON (find-mactype ':uint32))

(defconstant $CSSM_TP_STOP_ON_POLICY 0)         ;  use the pre-defined stopping criteria 

(defconstant $CSSM_TP_STOP_ON_NONE 1)           ;  evaluate all condition whether TRUE or FALSE 

(defconstant $CSSM_TP_STOP_ON_FIRST_PASS 2)     ;  stop evaluation at first TRUE 

(defconstant $CSSM_TP_STOP_ON_FIRST_FAIL 3)     ;  stop evaluation at first FALSE 


(def-mactype :CSSM_TIMESTRING (find-mactype '(:pointer :character)))
;  From DL. 
(defrecord cssm_dl_db_list
   (NumHandles :uint32)
   (DLDBHandle (:pointer (:pointer :CSSM_DL_DB_HANDLE)))
)

(def-mactype :CSSM_DL_DB_LIST_PTR (find-mactype '(:POINTER :CSSM_DL_DB_LIST)))
;  TP Again. 
(defrecord cssm_tp_callerauth_context
   (Policy :CSSM_TP_POLICYINFO)
   (VerifyTime (:pointer :character))
   (VerificationAbortOn :uint32)
   (CallbackWithVerifiedCert :cssm_tp_verification_results_callback)
#|
; Warning: type-size: unknown type CSSM_TP_VERIFICATION_RESULTS_CALLBACK
|#
   (NumberOfAnchorCerts :uint32)
   (AnchorCerts (:pointer (:pointer :CSSM_DATA)))
   (DBList (:pointer (:pointer :CSSM_DL_DB_LIST)))
   (CallerCredentials (:pointer (:pointer :CSSM_ACCESS_CREDENTIALS)))
)

(def-mactype :CSSM_TP_CALLERAUTH_CONTEXT_PTR (find-mactype '(:POINTER :CSSM_TP_CALLERAUTH_CONTEXT)))

(def-mactype :CSSM_CRL_PARSE_FORMAT_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_CRL_PARSE_FORMAT_NONE 0)
(defconstant $CSSM_CRL_PARSE_FORMAT_CUSTOM 1)
(defconstant $CSSM_CRL_PARSE_FORMAT_SEXPR 2)
(defconstant $CSSM_CRL_PARSE_FORMAT_COMPLEX 3)
(defconstant $CSSM_CRL_PARSE_FORMAT_OID_NAMED 4)
(defconstant $CSSM_CRL_PARSE_FORMAT_TUPLE 5)
(defconstant $CSSM_CRL_PARSE_FORMAT_MULTIPLE #x7FFE)
(defconstant $CSSM_CRL_PARSE_FORMAT_LAST #x7FFF)
;  Applications wishing to define their own custom parse
; 	   format should create a uint32 value greater than the
; 	   CSSM_CL_CUSTOM_CRL_PARSE_FORMAT 

(defconstant $CSSM_CL_CUSTOM_CRL_PARSE_FORMAT #x8000)
;  From CL. 

(def-mactype :CSSM_CRL_TYPE_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_CRL_TYPE_UNKNOWN 0)
(defconstant $CSSM_CRL_TYPE_X_509v1 1)
(defconstant $CSSM_CRL_TYPE_X_509v2 2)
(defconstant $CSSM_CRL_TYPE_SPKI 3)
(defconstant $CSSM_CRL_TYPE_MULTIPLE #x7FFE)

(def-mactype :CSSM_CRL_ENCODING_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_CRL_ENCODING_UNKNOWN 0)
(defconstant $CSSM_CRL_ENCODING_CUSTOM 1)
(defconstant $CSSM_CRL_ENCODING_BER 2)
(defconstant $CSSM_CRL_ENCODING_DER 3)
(defconstant $CSSM_CRL_ENCODING_BLOOM 4)
(defconstant $CSSM_CRL_ENCODING_SEXPR 5)
(defconstant $CSSM_CRL_ENCODING_MULTIPLE #x7FFE)
(defrecord cssm_encoded_crl
   (CrlType :cssm_crl_type)
#|
; Warning: type-size: unknown type CSSM_CRL_TYPE
|#                                              ;  type of CRL 
   (CrlEncoding :cssm_crl_encoding)
#|
; Warning: type-size: unknown type CSSM_CRL_ENCODING
|#                                              ;  encoding for this packed CRL 
   (CrlBlob :CSSM_DATA)                         ;  packed CRL 
)

(def-mactype :CSSM_ENCODED_CRL_PTR (find-mactype '(:POINTER :CSSM_ENCODED_CRL)))
;  TP Again. 
(defrecord cssm_parsed_crl
   (CrlType :cssm_crl_type)
#|
; Warning: type-size: unknown type CSSM_CRL_TYPE
|#                                              ;  CRL type 
   (ParsedCrlFormat :cssm_crl_parse_format)
#|
; Warning: type-size: unknown type CSSM_CRL_PARSE_FORMAT
|#
                                                ;  struct of ParsedCrl 
   (ParsedCrl :pointer)                         ;  parsed CRL (to be typecast) 
)

(def-mactype :CSSM_PARSED_CRL_PTR (find-mactype '(:POINTER :CSSM_PARSED_CRL)))
(defrecord cssm_crl_pair
   (EncodedCrl :CSSM_ENCODED_CRL)               ;  an encoded CRL blob 
   (ParsedCrl :CSSM_PARSED_CRL)                 ;  equivalent parsed CRL 
)

(def-mactype :CSSM_CRL_PAIR_PTR (find-mactype '(:POINTER :CSSM_CRL_PAIR)))

(def-mactype :CSSM_CRLGROUP_TYPE_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_CRLGROUP_DATA 0)
(defconstant $CSSM_CRLGROUP_ENCODED_CRL 1)
(defconstant $CSSM_CRLGROUP_PARSED_CRL 2)
(defconstant $CSSM_CRLGROUP_CRL_PAIR 3)
(defrecord cssm_crlgroup
   (CrlType :cssm_crl_type)
#|
; Warning: type-size: unknown type CSSM_CRL_TYPE
|#
   (CrlEncoding :cssm_crl_encoding)
#|
; Warning: type-size: unknown type CSSM_CRL_ENCODING
|#
   (NumberOfCrls :uint32)
   (:variant
   (
   (CrlList (:pointer (:pointer :CSSM_DATA)))
   )
                                                ;  CRL blob 
   (
   (EncodedCrlList (:pointer (:pointer :CSSM_ENCODED_CRL)))
   )
                                                ;  CRL blob w/ separate type 
   (
   (ParsedCrlList (:pointer (:pointer :CSSM_PARSED_CRL)))
   )
                                                ;  bushy, parsed CRL 
   (
   (PairCrlList (:pointer (:pointer :CSSM_CRL_PAIR)))
   )
   )
   (CrlGroupType :cssm_crlgroup_type)
#|
; Warning: type-size: unknown type CSSM_CRLGROUP_TYPE
|#
)

(def-mactype :CSSM_CRLGROUP_PTR (find-mactype '(:POINTER :CSSM_CRLGROUP)))
(defrecord cssm_fieldgroup
   (NumberOfFields :signed-long)
                                                ;  number of fields in the array 
   (Fields (:pointer (:pointer :CSSM_FIELD)))
                                                ;  array of fields 
)

(def-mactype :CSSM_FIELDGROUP_PTR (find-mactype '(:POINTER :CSSM_FIELDGROUP)))

(def-mactype :CSSM_EVIDENCE_FORM (find-mactype ':uint32))

(defconstant $CSSM_EVIDENCE_FORM_UNSPECIFIC 0)
(defconstant $CSSM_EVIDENCE_FORM_CERT 1)
(defconstant $CSSM_EVIDENCE_FORM_CRL 2)
(defconstant $CSSM_EVIDENCE_FORM_CERT_ID 3)
(defconstant $CSSM_EVIDENCE_FORM_CRL_ID 4)
(defconstant $CSSM_EVIDENCE_FORM_VERIFIER_TIME 5)
(defconstant $CSSM_EVIDENCE_FORM_CRL_THISTIME 6)
(defconstant $CSSM_EVIDENCE_FORM_CRL_NEXTTIME 7)
(defconstant $CSSM_EVIDENCE_FORM_POLICYINFO 8)
(defconstant $CSSM_EVIDENCE_FORM_TUPLEGROUP 9)
(defrecord cssm_evidence
   (EvidenceForm :uint32)
   (Evidence :pointer)                          ;  Evidence content 
)

(def-mactype :CSSM_EVIDENCE_PTR (find-mactype '(:POINTER :CSSM_EVIDENCE)))
(defrecord cssm_tp_verify_context
   (Action :uint32)
   (ActionData :CSSM_DATA)
   (Crls :CSSM_CRLGROUP)
   (Cred (:pointer (:pointer :CSSM_TP_CALLERAUTH_CONTEXT)))
)

(def-mactype :CSSM_TP_VERIFY_CONTEXT_PTR (find-mactype '(:POINTER :CSSM_TP_VERIFY_CONTEXT)))
(defrecord cssm_tp_verify_context_result
   (NumberOfEvidences :uint32)
   (Evidence (:pointer (:pointer :CSSM_EVIDENCE)))
)

(def-mactype :CSSM_TP_VERIFY_CONTEXT_RESULT_PTR (find-mactype '(:POINTER :CSSM_TP_VERIFY_CONTEXT_RESULT)))
(defrecord cssm_tp_request_set
   (NumberOfRequests :uint32)
   (Requests :pointer)
)

(def-mactype :CSSM_TP_REQUEST_SET_PTR (find-mactype '(:POINTER :CSSM_TP_REQUEST_SET)))
(defrecord cssm_tp_result_set
   (NumberOfResults :uint32)
   (Results :pointer)
)

(def-mactype :CSSM_TP_RESULT_SET_PTR (find-mactype '(:POINTER :CSSM_TP_RESULT_SET)))

(def-mactype :CSSM_TP_CONFIRM_STATUS_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_TP_CONFIRM_STATUS_UNKNOWN 0) ;  indeterminate 

(defconstant $CSSM_TP_CONFIRM_ACCEPT 1)
;  accept results of executing a
; 	   submit-retrieve function pair 

(defconstant $CSSM_TP_CONFIRM_REJECT 2)
;  reject results of executing a
; 	   submit-retrieve function pair 

(defrecord cssm_tp_confirm_response
   (NumberOfResponses :uint32)
   (Responses (:pointer :uint32))
)

(def-mactype :CSSM_TP_CONFIRM_RESPONSE_PTR (find-mactype '(:POINTER :CSSM_TP_CONFIRM_RESPONSE)))

(defconstant $CSSM_ESTIMATED_TIME_UNKNOWN -1)

(defconstant $CSSM_ELAPSED_TIME_UNKNOWN -1)
(defconstant $CSSM_ELAPSED_TIME_COMPLETE -2)
(defrecord cssm_tp_certissue_input
   (CSPSubserviceUid :CSSM_SUBSERVICE_UID)
   (CLHandle :CSSM_CL_HANDLE)
#|
; Warning: type-size: unknown type CSSM_CL_HANDLE
|#
   (NumberOfTemplateFields :uint32)
   (SubjectCertFields (:pointer (:pointer :CSSM_FIELD)))
   (MoreServiceRequests :uint32)
   (NumberOfServiceControls :uint32)
   (ServiceControls (:pointer (:pointer :CSSM_FIELD)))
   (UserCredentials (:pointer (:pointer :CSSM_ACCESS_CREDENTIALS)))
)

(def-mactype :CSSM_TP_CERTISSUE_INPUT_PTR (find-mactype '(:POINTER :CSSM_TP_CERTISSUE_INPUT)))

(def-mactype :CSSM_TP_CERTISSUE_STATUS (find-mactype ':uint32))

(defconstant $CSSM_TP_CERTISSUE_STATUS_UNKNOWN 0);  indeterminate 

(defconstant $CSSM_TP_CERTISSUE_OK 1)           ;  cert issued as requested 

(defconstant $CSSM_TP_CERTISSUE_OKWITHCERTMODS 2)
;  cert issued but cert contents were
; 	   updated by the issuing authority 

(defconstant $CSSM_TP_CERTISSUE_OKWITHSERVICEMODS 3)
;  cert issued but some requested backend
; 	   services were not performed by the
; 	   issuing authority 

(defconstant $CSSM_TP_CERTISSUE_REJECTED 4)
;  cert was not issued due to some error
; 	   condition 

(defconstant $CSSM_TP_CERTISSUE_NOT_AUTHORIZED 5)
;  cert was not issued, the request was
; 	   not authorized 

(defconstant $CSSM_TP_CERTISSUE_WILL_BE_REVOKED 6)
;  cert was issued, but TP has initiated
; 	   a revocation of the certificate 

(defrecord cssm_tp_certissue_output
   (IssueStatus :uint32)
   (CertGroup (:pointer (:pointer :CSSM_CERTGROUP)))
   (PerformedServiceRequests :uint32)
)

(def-mactype :CSSM_TP_CERTISSUE_OUTPUT_PTR (find-mactype '(:POINTER :CSSM_TP_CERTISSUE_OUTPUT)))

(def-mactype :CSSM_TP_CERTCHANGE_ACTION (find-mactype ':uint32))

(defconstant $CSSM_TP_CERTCHANGE_NONE 0)        ;  no change 

(defconstant $CSSM_TP_CERTCHANGE_REVOKE 1)      ;  Revoke the certificate 
;  This action type indicates a request to revoke a single
;    certificate. Notice of the revocation operation remains
;    in affect until the certificate itself expires. Revocation
;    should be used to permanently remove a certificate from use. 

(defconstant $CSSM_TP_CERTCHANGE_HOLD 2)        ;  Hold/suspend the certificate 
;  This action type indicates a request to suspend a
;    single certificate. A suspension operation implies
;    that the requester intends, at some time in the future,
;    to request that the certificate be released from hold,
;    making it available for use again. Placing a hold on
;    a certificate does not obligate the requester to
;    request a release. In practice, a certificate may
;    remain on hold until the certificate itself expires.
;    Revocation should be used to permanently remove a
;    certificate from use. 

(defconstant $CSSM_TP_CERTCHANGE_RELEASE 3)     ;  Release the held certificate 
;  This action type indicates a request to release a
;    single certificate currently on hold. A release
;    operation makes a certificate available for use again.
;    Revocation should be used to permanently remove a
;    certificate from use. 


(def-mactype :CSSM_TP_CERTCHANGE_REASON (find-mactype ':uint32))

(defconstant $CSSM_TP_CERTCHANGE_REASON_UNKNOWN 0);  unspecified 

(defconstant $CSSM_TP_CERTCHANGE_REASON_KEYCOMPROMISE 1);  Subject key believed to be compromised 

(defconstant $CSSM_TP_CERTCHANGE_REASON_CACOMPROMISE 2);  CA’s key believed to be compromised 

(defconstant $CSSM_TP_CERTCHANGE_REASON_CEASEOPERATION 3)
;  certificate holder ceases operation under
; 	   the jurisdiction of this certificate 

(defconstant $CSSM_TP_CERTCHANGE_REASON_AFFILIATIONCHANGE 4)
;  certificate holder has moved from this
; 	   jurisdiction 

(defconstant $CSSM_TP_CERTCHANGE_REASON_SUPERCEDED 5)
;  certificate holder as issued a new, superceding
; 	   certificate 

(defconstant $CSSM_TP_CERTCHANGE_REASON_SUSPECTEDCOMPROMISE 6);  certificate could be compromised 

(defconstant $CSSM_TP_CERTCHANGE_REASON_HOLDRELEASE 7)
;  certificate holder resumes operation under the
; 	   jurisdiction of this certificate 

(defrecord cssm_tp_certchange_input
   (Action :uint32)
   (Reason :uint32)
   (CLHandle :CSSM_CL_HANDLE)
#|
; Warning: type-size: unknown type CSSM_CL_HANDLE
|#
   (Cert (:pointer (:pointer :CSSM_DATA)))
   (ChangeInfo (:pointer (:pointer :CSSM_FIELD)))
   (StartTime (:pointer :character))
   (CallerCredentials (:pointer (:pointer :CSSM_ACCESS_CREDENTIALS)))
)

(def-mactype :CSSM_TP_CERTCHANGE_INPUT_PTR (find-mactype '(:POINTER :CSSM_TP_CERTCHANGE_INPUT)))

(def-mactype :CSSM_TP_CERTCHANGE_STATUS (find-mactype ':uint32))

(defconstant $CSSM_TP_CERTCHANGE_STATUS_UNKNOWN 0);  indeterminate 

(defconstant $CSSM_TP_CERTCHANGE_OK 1)
;  cert state was successfully changed
; 	   beginning at the specified time 

(defconstant $CSSM_TP_CERTCHANGE_OKWITHNEWTIME 2)
;  cert state was successfully changed,
; 	   at a modified effective time 

(defconstant $CSSM_TP_CERTCHANGE_WRONGCA 3)
;  cert state was not changed, the
; 	   selected CA is not authorized to
; 	   change the cert state 

(defconstant $CSSM_TP_CERTCHANGE_REJECTED 4)
;  cert state was not changed due to some
; 	   error condition 

(defconstant $CSSM_TP_CERTCHANGE_NOT_AUTHORIZED 5)
;  cert state was not changed, the
; 	   requester is not authorized to change
; 	   the cert state 

(defrecord cssm_tp_certchange_output
   (ActionStatus :uint32)
   (RevokeInfo :CSSM_FIELD)
)

(def-mactype :CSSM_TP_CERTCHANGE_OUTPUT_PTR (find-mactype '(:POINTER :CSSM_TP_CERTCHANGE_OUTPUT)))
(defrecord cssm_tp_certverify_input
   (CLHandle :CSSM_CL_HANDLE)
#|
; Warning: type-size: unknown type CSSM_CL_HANDLE
|#
   (Cert (:pointer (:pointer :CSSM_DATA)))
   (VerifyContext (:pointer (:pointer :CSSM_TP_VERIFY_CONTEXT)))
)

(def-mactype :CSSM_TP_CERTVERIFY_INPUT_PTR (find-mactype '(:POINTER :CSSM_TP_CERTVERIFY_INPUT)))

(def-mactype :CSSM_TP_CERTVERIFY_STATUS (find-mactype ':uint32))

(defconstant $CSSM_TP_CERTVERIFY_UNKNOWN 0)
(defconstant $CSSM_TP_CERTVERIFY_VALID 1)
(defconstant $CSSM_TP_CERTVERIFY_INVALID 2)
(defconstant $CSSM_TP_CERTVERIFY_REVOKED 3)
(defconstant $CSSM_TP_CERTVERIFY_SUSPENDED 4)
(defconstant $CSSM_TP_CERTVERIFY_EXPIRED 5)
(defconstant $CSSM_TP_CERTVERIFY_NOT_VALID_YET 6)
(defconstant $CSSM_TP_CERTVERIFY_INVALID_AUTHORITY 7)
(defconstant $CSSM_TP_CERTVERIFY_INVALID_SIGNATURE 8)
(defconstant $CSSM_TP_CERTVERIFY_INVALID_CERT_VALUE 9)
(defconstant $CSSM_TP_CERTVERIFY_INVALID_CERTGROUP 10)
(defconstant $CSSM_TP_CERTVERIFY_INVALID_POLICY 11)
(defconstant $CSSM_TP_CERTVERIFY_INVALID_POLICY_IDS 12)
(defconstant $CSSM_TP_CERTVERIFY_INVALID_BASIC_CONSTRAINTS 13)
(defconstant $CSSM_TP_CERTVERIFY_INVALID_CRL_DIST_PT 14)
(defconstant $CSSM_TP_CERTVERIFY_INVALID_NAME_TREE 15)
(defconstant $CSSM_TP_CERTVERIFY_UNKNOWN_CRITICAL_EXT 16)
(defrecord cssm_tp_certverify_output
   (VerifyStatus :uint32)
   (NumberOfEvidence :uint32)
   (Evidence (:pointer (:pointer :CSSM_EVIDENCE)))
)

(def-mactype :CSSM_TP_CERTVERIFY_OUTPUT_PTR (find-mactype '(:POINTER :CSSM_TP_CERTVERIFY_OUTPUT)))
(defrecord cssm_tp_certnotarize_input
   (CLHandle :CSSM_CL_HANDLE)
#|
; Warning: type-size: unknown type CSSM_CL_HANDLE
|#
   (NumberOfFields :uint32)
   (MoreFields (:pointer (:pointer :CSSM_FIELD)))
   (SignScope (:pointer (:pointer :CSSM_FIELD)))
   (ScopeSize :uint32)
   (MoreServiceRequests :uint32)
   (NumberOfServiceControls :uint32)
   (ServiceControls (:pointer (:pointer :CSSM_FIELD)))
   (UserCredentials (:pointer (:pointer :CSSM_ACCESS_CREDENTIALS)))
)

(def-mactype :CSSM_TP_CERTNOTARIZE_INPUT_PTR (find-mactype '(:POINTER :CSSM_TP_CERTNOTARIZE_INPUT)))

(def-mactype :CSSM_TP_CERTNOTARIZE_STATUS (find-mactype ':uint32))

(defconstant $CSSM_TP_CERTNOTARIZE_STATUS_UNKNOWN 0);  indeterminate 

(defconstant $CSSM_TP_CERTNOTARIZE_OK 1)
;  cert fields were added and the result was
; 	   notarized as requested 

(defconstant $CSSM_TP_CERTNOTARIZE_OKWITHOUTFIELDS 2)
;  non-conflicting cert fields were added,
; 	   conflicting cert fields were ignored,
; 	   and the result was notarized as requested 

(defconstant $CSSM_TP_CERTNOTARIZE_OKWITHSERVICEMODS 3)
;  cert fields were added and the result was
; 	   notarized as requested, but some requested
; 	   backend services were not performed by the
; 	   notary 

(defconstant $CSSM_TP_CERTNOTARIZE_REJECTED 4)
;  cert was not notarized due to some error
; 	   condition 

(defconstant $CSSM_TP_CERTNOTARIZE_NOT_AUTHORIZED 5)
;  cert was not notarized, the request was
; 	   not authorized 

(defrecord cssm_tp_certnotarize_output
   (NotarizeStatus :uint32)
   (NotarizedCertGroup (:pointer (:pointer :CSSM_CERTGROUP)))
   (PerformedServiceRequests :uint32)
)

(def-mactype :CSSM_TP_CERTNOTARIZE_OUTPUT_PTR (find-mactype '(:POINTER :CSSM_TP_CERTNOTARIZE_OUTPUT)))
(defrecord cssm_tp_certreclaim_input
   (CLHandle :CSSM_CL_HANDLE)
#|
; Warning: type-size: unknown type CSSM_CL_HANDLE
|#
   (NumberOfSelectionFields :uint32)
   (SelectionFields (:pointer (:pointer :CSSM_FIELD)))
   (UserCredentials (:pointer (:pointer :CSSM_ACCESS_CREDENTIALS)))
)

(def-mactype :CSSM_TP_CERTRECLAIM_INPUT_PTR (find-mactype '(:POINTER :CSSM_TP_CERTRECLAIM_INPUT)))

(def-mactype :CSSM_TP_CERTRECLAIM_STATUS (find-mactype ':uint32))

(defconstant $CSSM_TP_CERTRECLAIM_STATUS_UNKNOWN 0);  indeterminate 

(defconstant $CSSM_TP_CERTRECLAIM_OK 1)
;  a set of one or more certificates were
; 	   returned by the CA for local recovery
; 	   of the associated private key 

(defconstant $CSSM_TP_CERTRECLAIM_NOMATCH 2)
;  no certificates owned by the requester
; 	   were found matching the specified
; 	   selection fields 

(defconstant $CSSM_TP_CERTRECLAIM_REJECTED 3)
;  certificate reclamation failed due
; 	   to some error condition 

(defconstant $CSSM_TP_CERTRECLAIM_NOT_AUTHORIZED 4)
;  certificate reclamation was not
; 	   performed, the request was not
; 	   authorized 

(defrecord cssm_tp_certreclaim_output
   (ReclaimStatus :uint32)
   (ReclaimedCertGroup (:pointer (:pointer :CSSM_CERTGROUP)))
   (KeyCacheHandle :CSSM_LONG_HANDLE)
#|
; Warning: type-size: unknown type CSSM_LONG_HANDLE
|#
)

(def-mactype :CSSM_TP_CERTRECLAIM_OUTPUT_PTR (find-mactype '(:POINTER :CSSM_TP_CERTRECLAIM_OUTPUT)))
(defrecord cssm_tp_crlissue_input
   (CLHandle :CSSM_CL_HANDLE)
#|
; Warning: type-size: unknown type CSSM_CL_HANDLE
|#
   (CrlIdentifier :uint32)
   (CrlThisTime (:pointer :character))
   (PolicyIdentifier (:pointer (:pointer :CSSM_FIELD)))
   (CallerCredentials (:pointer (:pointer :CSSM_ACCESS_CREDENTIALS)))
)

(def-mactype :CSSM_TP_CRLISSUE_INPUT_PTR (find-mactype '(:POINTER :CSSM_TP_CRLISSUE_INPUT)))

(def-mactype :CSSM_TP_CRLISSUE_STATUS (find-mactype ':uint32))

(defconstant $CSSM_TP_CRLISSUE_STATUS_UNKNOWN 0);  indeterminate 

(defconstant $CSSM_TP_CRLISSUE_OK 1)
;  a copy of the most current CRL was
; 	   issued as requested and the time for
; 	   issuing the next CRL is also returned 

(defconstant $CSSM_TP_CRLISSUE_NOT_CURRENT 2)
;  either no CRL has been issued since
; 	   the CRL identified in the request, or
; 	   it is not time to issue an updated CRL.
; 	   no CRL has been returned, but the time
; 	   for issuing the next CRL is included
; 	   in the results 

(defconstant $CSSM_TP_CRLISSUE_INVALID_DOMAIN 3)
;  CRL domain was not recognized or was
; 	   outside the CA jurisdiction, no CRL or
; 	   time for the next CRL has been
; 	   returned. 

(defconstant $CSSM_TP_CRLISSUE_UNKNOWN_IDENTIFIER 4)
;  unrecognized CRL identifier, no CRL or
; 	   time for the next CRL has been
; 	   returned. 

(defconstant $CSSM_TP_CRLISSUE_REJECTED 5)
;  CRL was not issued due to some error
; 	   condition, no CRL or time for the next
; 	   CRL has been returned. 

(defconstant $CSSM_TP_CRLISSUE_NOT_AUTHORIZED 6)
;  CRL was not issued, the request was
; 	   not authorized, no CRL or time for the
; 	   next CRL has been returned. 

(defrecord cssm_tp_crlissue_output
   (IssueStatus :uint32)
   (Crl (:pointer (:pointer :CSSM_ENCODED_CRL)))
   (CrlNextTime (:pointer :character))
)

(def-mactype :CSSM_TP_CRLISSUE_OUTPUT_PTR (find-mactype '(:POINTER :CSSM_TP_CRLISSUE_OUTPUT)))

(def-mactype :CSSM_TP_FORM_TYPE (find-mactype ':uint32))

(defconstant $CSSM_TP_FORM_TYPE_GENERIC 0)
(defconstant $CSSM_TP_FORM_TYPE_REGISTRATION 1)
;  Data Types for Certificate Library Services  

(def-mactype :CSSM_CL_TEMPLATE_TYPE (find-mactype ':uint32))

(defconstant $CSSM_CL_TEMPLATE_INTERMEDIATE_CERT 1)
;  for X509 certificates, a fully-formed
; 	   encoded certificate with empty signature field 

(defconstant $CSSM_CL_TEMPLATE_PKIX_CERTTEMPLATE 2);  as defined in RFC2511, section 5 CertTemplate 


(def-mactype :CSSM_CERT_BUNDLE_TYPE (find-mactype ':uint32))

(defconstant $CSSM_CERT_BUNDLE_UNKNOWN 0)
(defconstant $CSSM_CERT_BUNDLE_CUSTOM 1)
(defconstant $CSSM_CERT_BUNDLE_PKCS7_SIGNED_DATA 2)
(defconstant $CSSM_CERT_BUNDLE_PKCS7_SIGNED_ENVELOPED_DATA 3)
(defconstant $CSSM_CERT_BUNDLE_PKCS12 4)
(defconstant $CSSM_CERT_BUNDLE_PFX 5)
(defconstant $CSSM_CERT_BUNDLE_SPKI_SEQUENCE 6)
(defconstant $CSSM_CERT_BUNDLE_PGP_KEYRING 7)
(defconstant $CSSM_CERT_BUNDLE_LAST #x7FFF)
;  Applications wishing to define their own custom certificate
; 	   bundle type should define and publicly document a uint32
; 	   value greater than CSSM_CL_CUSTOM_CERT_BUNDLE_TYPE 

(defconstant $CSSM_CL_CUSTOM_CERT_BUNDLE_TYPE #x8000)

(def-mactype :CSSM_CERT_BUNDLE_ENCODING (find-mactype ':uint32))

(defconstant $CSSM_CERT_BUNDLE_ENCODING_UNKNOWN 0)
(defconstant $CSSM_CERT_BUNDLE_ENCODING_CUSTOM 1)
(defconstant $CSSM_CERT_BUNDLE_ENCODING_BER 2)
(defconstant $CSSM_CERT_BUNDLE_ENCODING_DER 3)
(defconstant $CSSM_CERT_BUNDLE_ENCODING_SEXPR 4)
(defconstant $CSSM_CERT_BUNDLE_ENCODING_PGP 5)
(defrecord cssm_cert_bundle_header
   (BundleType :uint32)
   (BundleEncoding :uint32)
)

(def-mactype :CSSM_CERT_BUNDLE_HEADER_PTR (find-mactype '(:POINTER :CSSM_CERT_BUNDLE_HEADER)))
(defrecord cssm_cert_bundle
   (BundleHeader :CSSM_CERT_BUNDLE_HEADER)
   (Bundle :CSSM_DATA)
)

(def-mactype :CSSM_CERT_BUNDLE_PTR (find-mactype '(:POINTER :CSSM_CERT_BUNDLE)))

(defconstant $CSSM_FIELDVALUE_COMPLEX_DATA_TYPE #xFFFFFFFF)
;  Data Types for Data Storage Library Services  

(def-mactype :CSSM_DB_ATTRIBUTE_NAME_FORMAT_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_DB_ATTRIBUTE_NAME_AS_STRING 0)
(defconstant $CSSM_DB_ATTRIBUTE_NAME_AS_OID 1)
(defconstant $CSSM_DB_ATTRIBUTE_NAME_AS_INTEGER 2)

(def-mactype :CSSM_DB_ATTRIBUTE_FORMAT_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_DB_ATTRIBUTE_FORMAT_STRING 0)
(defconstant $CSSM_DB_ATTRIBUTE_FORMAT_SINT32 1)
(defconstant $CSSM_DB_ATTRIBUTE_FORMAT_UINT32 2)
(defconstant $CSSM_DB_ATTRIBUTE_FORMAT_BIG_NUM 3)
(defconstant $CSSM_DB_ATTRIBUTE_FORMAT_REAL 4)
(defconstant $CSSM_DB_ATTRIBUTE_FORMAT_TIME_DATE 5)
(defconstant $CSSM_DB_ATTRIBUTE_FORMAT_BLOB 6)
(defconstant $CSSM_DB_ATTRIBUTE_FORMAT_MULTI_UINT32 7)
(defconstant $CSSM_DB_ATTRIBUTE_FORMAT_COMPLEX 8)
(defrecord cssm_db_attribute_info
   (AttributeNameFormat :cssm_db_attribute_name_format)
#|
; Warning: type-size: unknown type CSSM_DB_ATTRIBUTE_NAME_FORMAT
|#
   (:variant
   (
   (AttributeName (:pointer :char))
   )
                                                ;  e.g., "record label" 
   (
   (AttributeOID :cssm_oid)
#|
; Warning: type-size: unknown type CSSM_OID
|#
   )
                                                ;  e.g., CSSMOID_RECORDLABEL 
   (
   (AttributeID :uint32)
   )
                                                ;  e.g., FOUR_CHAR_CODE('recl') 
   )
   (AttributeFormat :cssm_db_attribute_format)
#|
; Warning: type-size: unknown type CSSM_DB_ATTRIBUTE_FORMAT
|#
)

(def-mactype :CSSM_DB_ATTRIBUTE_INFO_PTR (find-mactype '(:POINTER :CSSM_DB_ATTRIBUTE_INFO)))
(defrecord cssm_db_attribute_data
   (Info :CSSM_DB_ATTRIBUTE_INFO)
   (NumberOfValues :uint32)
   (Value (:pointer (:pointer :CSSM_DATA)))
)

(def-mactype :CSSM_DB_ATTRIBUTE_DATA_PTR (find-mactype '(:POINTER :CSSM_DB_ATTRIBUTE_DATA)))

(def-mactype :CSSM_DB_RECORDTYPE (find-mactype ':uint32))
;  Schema Management Name Space Range Definition

(defconstant $CSSM_DB_RECORDTYPE_SCHEMA_START 0)
(defconstant $CSSM_DB_RECORDTYPE_SCHEMA_END 4)  ;  Open Group Application Name Space Range Definition

(defconstant $CSSM_DB_RECORDTYPE_OPEN_GROUP_START 10)
(defconstant $CSSM_DB_RECORDTYPE_OPEN_GROUP_END 18);  Industry At Large Application Name Space Range Definition 

(defconstant $CSSM_DB_RECORDTYPE_APP_DEFINED_START #x80000000)
(defconstant $CSSM_DB_RECORDTYPE_APP_DEFINED_END #xFFFFFFFF);  Record Types defined in the Schema Management Name Space 

(defconstant $CSSM_DL_DB_SCHEMA_INFO 0)
(defconstant $CSSM_DL_DB_SCHEMA_INDEXES 1)
(defconstant $CSSM_DL_DB_SCHEMA_ATTRIBUTES 2)
(defconstant $CSSM_DL_DB_SCHEMA_PARSING_MODULE 3);  Record Types defined in the Open Group Application Name Space 

(defconstant $CSSM_DL_DB_RECORD_ANY 10)
(defconstant $CSSM_DL_DB_RECORD_CERT 11)
(defconstant $CSSM_DL_DB_RECORD_CRL 12)
(defconstant $CSSM_DL_DB_RECORD_POLICY 13)
(defconstant $CSSM_DL_DB_RECORD_GENERIC 14)
(defconstant $CSSM_DL_DB_RECORD_PUBLIC_KEY 15)
(defconstant $CSSM_DL_DB_RECORD_PRIVATE_KEY 16)
(defconstant $CSSM_DL_DB_RECORD_SYMMETRIC_KEY 17)
(defconstant $CSSM_DL_DB_RECORD_ALL_KEYS 18)

(defconstant $CSSM_DB_CERT_USE_TRUSTED 1)       ;  application-defined as trusted 

(defconstant $CSSM_DB_CERT_USE_SYSTEM 2)        ;  the CSSM system cert 

(defconstant $CSSM_DB_CERT_USE_OWNER 4)         ;  private key owned by system user

(defconstant $CSSM_DB_CERT_USE_REVOKED 8)       ;  revoked cert -15913 used w CRL APIs 

(defconstant $CSSM_DB_CERT_USE_SIGNING 16)      ;  use cert for signing only 

(defconstant $CSSM_DB_CERT_USE_PRIVACY 32)      ;  use cert for confidentiality only 

(defrecord cssm_db_record_attribute_info
   (DataRecordType :uint32)
   (NumberOfAttributes :uint32)
   (AttributeInfo (:pointer (:pointer :CSSM_DB_ATTRIBUTE_INFO)))
)

(def-mactype :CSSM_DB_RECORD_ATTRIBUTE_INFO_PTR (find-mactype '(:POINTER :CSSM_DB_RECORD_ATTRIBUTE_INFO)))
(defrecord cssm_db_record_attribute_data
   (DataRecordType :uint32)
   (SemanticInformation :uint32)
   (NumberOfAttributes :uint32)
   (AttributeData (:pointer (:pointer :CSSM_DB_ATTRIBUTE_DATA)))
)

(def-mactype :CSSM_DB_RECORD_ATTRIBUTE_DATA_PTR (find-mactype '(:POINTER :CSSM_DB_RECORD_ATTRIBUTE_DATA)))
(defrecord cssm_db_parsing_module_info
   (RecordType :uint32)
   (ModuleSubserviceUid :CSSM_SUBSERVICE_UID)
)

(def-mactype :CSSM_DB_PARSING_MODULE_INFO_PTR (find-mactype '(:POINTER :CSSM_DB_PARSING_MODULE_INFO)))

(def-mactype :CSSM_DB_INDEX_TYPE (find-mactype ':uint32))

(defconstant $CSSM_DB_INDEX_UNIQUE 0)
(defconstant $CSSM_DB_INDEX_NONUNIQUE 1)

(def-mactype :CSSM_DB_INDEXED_DATA_LOCATION (find-mactype ':uint32))

(defconstant $CSSM_DB_INDEX_ON_UNKNOWN 0)
(defconstant $CSSM_DB_INDEX_ON_ATTRIBUTE 1)
(defconstant $CSSM_DB_INDEX_ON_RECORD 2)
(defrecord cssm_db_index_info
   (IndexType :uint32)
   (IndexedDataLocation :uint32)
   (Info :CSSM_DB_ATTRIBUTE_INFO)
)

(def-mactype :CSSM_DB_INDEX_INFO_PTR (find-mactype '(:POINTER :CSSM_DB_INDEX_INFO)))
(defrecord cssm_db_unique_record
   (RecordLocator :CSSM_DB_INDEX_INFO)
   (RecordIdentifier :CSSM_DATA)
)

(def-mactype :CSSM_DB_UNIQUE_RECORD_PTR (find-mactype '(:POINTER :CSSM_DB_UNIQUE_RECORD)))
(defrecord cssm_db_record_index_info
   (DataRecordType :uint32)
   (NumberOfIndexes :uint32)
   (IndexInfo (:pointer (:pointer :CSSM_DB_INDEX_INFO)))
)

(def-mactype :CSSM_DB_RECORD_INDEX_INFO_PTR (find-mactype '(:POINTER :CSSM_DB_RECORD_INDEX_INFO)))

(def-mactype :CSSM_DB_ACCESS_TYPE_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_DB_ACCESS_READ 1)
(defconstant $CSSM_DB_ACCESS_WRITE 2)
(defconstant $CSSM_DB_ACCESS_PRIVILEGED 4)      ;  versus user mode 


(def-mactype :CSSM_DB_MODIFY_MODE (find-mactype ':uint32))

(defconstant $CSSM_DB_MODIFY_ATTRIBUTE_NONE 0)
(defconstant $CSSM_DB_MODIFY_ATTRIBUTE_ADD 1)
(defconstant $CSSM_DB_MODIFY_ATTRIBUTE_DELETE 2)
(defconstant $CSSM_DB_MODIFY_ATTRIBUTE_REPLACE 3)
(defrecord cssm_dbinfo
                                                ;  meta information about each record type stored in this
;     data store including meta information about record
;     attributes and indexes 
   (NumberOfRecordTypes :uint32)
   (DefaultParsingModules (:pointer (:pointer :CSSM_DB_PARSING_MODULE_INFO)))
   (RecordAttributeNames (:pointer (:pointer :CSSM_DB_RECORD_ATTRIBUTE_INFO)))
   (RecordIndexes (:pointer (:pointer :CSSM_DB_RECORD_INDEX_INFO)))
                                                ;  access restrictions for opening this data store 
   (IsLocal :sint32)
   (AccessPath (:pointer :char))                ;  URL, dir path, etc. 
   (Reserved :pointer)
)

(def-mactype :CSSM_DBINFO_PTR (find-mactype '(:POINTER :CSSM_DBINFO)))

(def-mactype :CSSM_DB_OPERATOR_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_DB_EQUAL 0)
(defconstant $CSSM_DB_NOT_EQUAL 1)
(defconstant $CSSM_DB_LESS_THAN 2)
(defconstant $CSSM_DB_GREATER_THAN 3)
(defconstant $CSSM_DB_CONTAINS 4)
(defconstant $CSSM_DB_CONTAINS_INITIAL_SUBSTRING 5)
(defconstant $CSSM_DB_CONTAINS_FINAL_SUBSTRING 6)

(def-mactype :CSSM_DB_CONJUNCTIVE_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_DB_NONE 0)
(defconstant $CSSM_DB_AND 1)
(defconstant $CSSM_DB_OR 2)
(defrecord cssm_selection_predicate
   (DbOperator :cssm_db_operator)
#|
; Warning: type-size: unknown type CSSM_DB_OPERATOR
|#
   (Attribute :CSSM_DB_ATTRIBUTE_DATA)
)

(def-mactype :CSSM_SELECTION_PREDICATE_PTR (find-mactype '(:POINTER :CSSM_SELECTION_PREDICATE)))

(defconstant $CSSM_QUERY_TIMELIMIT_NONE 0)

(defconstant $CSSM_QUERY_SIZELIMIT_NONE 0)
(defrecord cssm_query_limits
   (TimeLimit :uint32)                          ;  in seconds 
   (SizeLimit :uint32)                          ;  max. number of records to return 
)

(def-mactype :CSSM_QUERY_LIMITS_PTR (find-mactype '(:POINTER :CSSM_QUERY_LIMITS)))

(def-mactype :CSSM_QUERY_FLAGS (find-mactype ':uint32))

(defconstant $CSSM_QUERY_RETURN_DATA 1)
(defrecord cssm_query
   (RecordType :uint32)
   (Conjunctive :cssm_db_conjunctive)
#|
; Warning: type-size: unknown type CSSM_DB_CONJUNCTIVE
|#
   (NumSelectionPredicates :uint32)
   (SelectionPredicate (:pointer (:pointer :CSSM_SELECTION_PREDICATE)))
   (QueryLimits :CSSM_QUERY_LIMITS)
   (QueryFlags :uint32)
)

(def-mactype :CSSM_QUERY_PTR (find-mactype '(:POINTER :CSSM_QUERY)))

(def-mactype :CSSM_DLTYPE_PTR (find-mactype '(:POINTER :uint32)))

(defconstant $CSSM_DL_UNKNOWN 0)
(defconstant $CSSM_DL_CUSTOM 1)
(defconstant $CSSM_DL_LDAP 2)
(defconstant $CSSM_DL_ODBC 3)
(defconstant $CSSM_DL_PKCS11 4)
(defconstant $CSSM_DL_FFS 5)                    ;  flat file system 

(defconstant $CSSM_DL_MEMORY 6)
(defconstant $CSSM_DL_REMOTEDIR 7)

(def-mactype :CSSM_DL_CUSTOM_ATTRIBUTES (find-mactype '(:pointer :void)))

(def-mactype :CSSM_DL_LDAP_ATTRIBUTES (find-mactype '(:pointer :void)))

(def-mactype :CSSM_DL_ODBC_ATTRIBUTES (find-mactype '(:pointer :void)))

(def-mactype :CSSM_DL_FFS_ATTRIBUTES (find-mactype '(:pointer :void)))
(defrecord cssm_dl_pkcs11_attributes
   (DeviceAccessFlags :uint32)
)
(def-mactype :CSSM_DL_PKCS11_ATTRIBUTE (find-mactype '(:POINTER :CSSM_DL_PKCS11_ATTRIBUTES)))

(def-mactype :CSSM_DL_PKCS11_ATTRIBUTE_PTR (find-mactype '(:POINTER :CSSM_DL_PKCS11_ATTRIBUTES)))

(defconstant $CSSM_DB_DATASTORES_UNKNOWN #xFFFFFFFF)
(defrecord cssm_name_list
   (NumStrings :uint32)
   (** (:pointer :callback))                    ;(char String)
)

(def-mactype :CSSM_NAME_LIST_PTR (find-mactype '(:POINTER :CSSM_NAME_LIST)))

(def-mactype :CSSM_DB_RETRIEVAL_MODES (find-mactype ':uint32))

(defconstant $CSSM_DB_TRANSACTIONAL_MODE 0)
(defconstant $CSSM_DB_FILESYSTEMSCAN_MODE 1)
(defrecord cssm_db_schema_attribute_info
   (AttributeId :uint32)
   (AttributeName (:pointer :char))
   (AttributeNameID :cssm_oid)
#|
; Warning: type-size: unknown type CSSM_OID
|#
   (DataType :cssm_db_attribute_format)
#|
; Warning: type-size: unknown type CSSM_DB_ATTRIBUTE_FORMAT
|#
)

(def-mactype :CSSM_DB_SCHEMA_ATTRIBUTE_INFO_PTR (find-mactype '(:POINTER :CSSM_DB_SCHEMA_ATTRIBUTE_INFO)))
(defrecord cssm_db_schema_index_info
   (AttributeId :uint32)
   (IndexId :uint32)
   (IndexType :uint32)
   (IndexedDataLocation :uint32)
)

(def-mactype :CSSM_DB_SCHEMA_INDEX_INFO_PTR (find-mactype '(:POINTER :CSSM_DB_SCHEMA_INDEX_INFO)))
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _CSSMTYPE_H_ */


(provide-interface "cssmtype")