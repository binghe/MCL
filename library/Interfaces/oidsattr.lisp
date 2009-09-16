(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:oidsattr.h"
; at Sunday July 2,2006 7:31:07 pm.
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
;    File:      oidsattr.h
; 
;    Contains:  Cert/CRL related OIDs.
; 
;    Copyright: (c) 1999-2000 Apple Computer, Inc., all rights reserved.
; 
; #ifndef	_CDSA_OIDSATTR_H_
; #define _CDSA_OIDSATTR_H_

(require-interface "Security/cssmtype")

(require-interface "Security/oidsbase")
;  
;  * Directory name component identifiers.
;  
(def-mactype :CSSMOID_ObjectClass (find-mactype ':CSSM_OID)); ,
;  PKCS 9 
(def-mactype :CSSMOID_EmailAddress (find-mactype ':CSSM_OID)); ,
;  PKIX 
(def-mactype :CSSMOID_QT_CPS (find-mactype ':CSSM_OID)); ,
;  PKCS7 
;  PKCS8 
;  PKCS12 
(def-mactype :CSSMOID_PKCS7_Data (find-mactype ':CSSM_OID)); ,;  PKCS8 
;  PKCS12 


; #endif	/* _CDSA_OIDSATTR_H_*/


(provide-interface "oidsattr")