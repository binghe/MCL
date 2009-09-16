(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:oidscrl.h"
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
;    File:      oidscrl.h
; 
;    Contains:  Object Identifiers for X509 CRLS
; 
;    Copyright: (c) 1999-2000 Apple Computer, Inc., all rights reserved.
; 
; #ifndef _OIDSCRL_H_
(defconstant $_OIDSCRL_H_ 1)
; #define _OIDSCRL_H_  1

(require-interface "Security/cssmconfig")

(require-interface "Security/cssmtype")

(require-interface "Security/oidsbase")
; #ifdef __cplusplus
#| #|
extern "C" {
#endif
|#
 |#
; #define INTEL_X509V2_CRL_R08 INTEL_SEC_FORMATS, 2, 1
; #define INTEL_X509V2_CRL_R08_LENGTH INTEL_SEC_FORMATS_LENGTH+2
;  CRL OIDs 
;  CRL Entry (CRL CertList) OIDS 
;  CRL Entry (CRL CertList) Extension OIDs 
;  CRL Extension OIDs 
;  CRL OIDs 
(def-mactype :CSSMOID_X509V2CRLSignedCrlStruct (find-mactype ':CSSM_OID)); ,;  CRL Entry (CRL CertList) OIDS 
;  CRL Entry (CRL CertList) Extension OIDs 
;  CRL Extension OIDs 

; #ifdef __cplusplus
#| #|
}
#endif
|#
 |#

; #endif /* _OIDSCRL_H_ */


(provide-interface "oidscrl")