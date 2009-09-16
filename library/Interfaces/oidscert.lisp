(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:oidscert.h"
; at Sunday July 2,2006 7:31:08 pm.
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
;  File:      oidscert.h
; 
;  Contains:  Object Identifiers for X509 Certificate Library
; 
;  Copyright: (c) 1999-2000 Apple Computer, Inc., all rights reserved.
; 
; #ifndef _OIDSCERT_H_
(defconstant $_OIDSCERT_H_ 1)
; #define _OIDSCERT_H_  1

(require-interface "Security/cssmconfig")

(require-interface "Security/cssmtype")

(require-interface "Security/oidsbase")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; #define INTEL_X509V3_CERT_R08 INTEL_SEC_FORMATS, 1, 1
; #define INTEL_X509V3_CERT_R08_LENGTH INTEL_SEC_FORMATS_LENGTH + 2
;  Prefix for defining Certificate Extension field OIDs 
; #define INTEL_X509V3_CERT_PRIVATE_EXTENSIONS INTEL_X509V3_CERT_R08, 50
; #define INTEL_X509V3_CERT_PRIVATE_EXTENSIONS_LENGTH INTEL_X509V3_CERT_R08_LENGTH + 1
;  Prefix for defining signature field OIDs 
; #define INTEL_X509V3_SIGN_R08 INTEL_SEC_FORMATS, 3, 2
; #define INTEL_X509V3_SIGN_R08_LENGTH INTEL_SEC_FORMATS_LENGTH + 2
;  Suffix specifying format or representation of a field value                                      
;  Note that if a format suffix is not specified, a flat data representation is implied. 
(defconstant $INTEL_X509_C_DATATYPE 1)
; #define INTEL_X509_C_DATATYPE					1
(defconstant $INTEL_X509_LDAPSTRING_DATATYPE 2)
; #define INTEL_X509_LDAPSTRING_DATATYPE		2
;  Certificate OIDS 
;  normalized & encoded
;  encoded
;  CSSM_X509_NAME
;  normalized & encoded
;  encoded
;  CSSM_X509_NAME
;  Signature OID Fields 
;  Extension OID Fields 
(def-mactype :CSSMOID_X509V3SignedCertificate (find-mactype ':CSSM_OID)); ,;  normalized & encoded
;  encoded
;  CSSM_X509_NAME
;  normalized & encoded
;  encoded
;  CSSM_X509_NAME
;  Signature OID Fields 
;  Extension OID Fields 

; ** 
;  *** Apple addenda
;  **
;  
;  * Standard Cert and CRL extensions.
;  
(def-mactype :CSSMOID_SubjectDirectoryAttributes (find-mactype ':CSSM_OID)); ,
; 
;  * Netscape extensions.
;  
(def-mactype :CSSMOID_NetscapeCertType (find-mactype ':CSSM_OID))
; 
;  * Field values for CSSMOID_NetscapeCertType, a bit string.
;  * Assumes a 16 bit field, even though currently only 8 bits
;  * are defined. 
;  
(defconstant $CE_NCT_SSL_Client 32768)
; #define CE_NCT_SSL_Client	0x8000
(defconstant $CE_NCT_SSL_Server 16384)
; #define CE_NCT_SSL_Server	0x4000
(defconstant $CE_NCT_SMIME 8192)
; #define CE_NCT_SMIME		0x2000
(defconstant $CE_NCT_ObjSign 4096)
; #define CE_NCT_ObjSign		0x1000
(defconstant $CE_NCT_Reserved 2048)
; #define CE_NCT_Reserved		0x0800
(defconstant $CE_NCT_SSL_CA 1024)
; #define CE_NCT_SSL_CA		0x0400
(defconstant $CE_NCT_SMIME_CA 512)
; #define CE_NCT_SMIME_CA		0x0200
(defconstant $CE_NCT_ObjSignCA 256)
; #define CE_NCT_ObjSignCA	0x0100
; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _OIDSCERT_H_ */


(provide-interface "oidscert")