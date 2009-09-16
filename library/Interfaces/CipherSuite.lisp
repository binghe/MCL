(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:CipherSuite.h"
; at Sunday July 2,2006 7:27:21 pm.
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
; 
; 	File:		CipherSuite.h
; 
; 	Contains:	SSL Cipher Suite definitions. 
; 
; 	Copyright: (c) 1999 by Apple Computer, Inc., all rights reserved.
; 
; 
; #ifndef _SECURITY_CIPHERSUITE_H_
; #define _SECURITY_CIPHERSUITE_H_
;  fetch Uint32 

(require-interface "CoreServices/../Frameworks/CarbonCore.framework/Headers/MacTypes")
; 
;  * Defined as enum for debugging, but in the protocol
;  * it is actually exactly two bytes
;  

(def-mactype :SSLCipherSuite (find-mactype ':UInt32))

(defconstant $SSL_NULL_WITH_NULL_NULL 0)
(defconstant $SSL_RSA_WITH_NULL_MD5 1)
(defconstant $SSL_RSA_WITH_NULL_SHA 2)
(defconstant $SSL_RSA_EXPORT_WITH_RC4_40_MD5 3)
(defconstant $SSL_RSA_WITH_RC4_128_MD5 4)
(defconstant $SSL_RSA_WITH_RC4_128_SHA 5)
(defconstant $SSL_RSA_EXPORT_WITH_RC2_CBC_40_MD5 6)
(defconstant $SSL_RSA_WITH_IDEA_CBC_SHA 7)
(defconstant $SSL_RSA_EXPORT_WITH_DES40_CBC_SHA 8)
(defconstant $SSL_RSA_WITH_DES_CBC_SHA 9)
(defconstant $SSL_RSA_WITH_3DES_EDE_CBC_SHA 10)
(defconstant $SSL_DH_DSS_EXPORT_WITH_DES40_CBC_SHA 11)
(defconstant $SSL_DH_DSS_WITH_DES_CBC_SHA 12)
(defconstant $SSL_DH_DSS_WITH_3DES_EDE_CBC_SHA 13)
(defconstant $SSL_DH_RSA_EXPORT_WITH_DES40_CBC_SHA 14)
(defconstant $SSL_DH_RSA_WITH_DES_CBC_SHA 15)
(defconstant $SSL_DH_RSA_WITH_3DES_EDE_CBC_SHA 16)
(defconstant $SSL_DHE_DSS_EXPORT_WITH_DES40_CBC_SHA 17)
(defconstant $SSL_DHE_DSS_WITH_DES_CBC_SHA 18)
(defconstant $SSL_DHE_DSS_WITH_3DES_EDE_CBC_SHA 19)
(defconstant $SSL_DHE_RSA_EXPORT_WITH_DES40_CBC_SHA 20)
(defconstant $SSL_DHE_RSA_WITH_DES_CBC_SHA 21)
(defconstant $SSL_DHE_RSA_WITH_3DES_EDE_CBC_SHA 22)
(defconstant $SSL_DH_anon_EXPORT_WITH_RC4_40_MD5 23)
(defconstant $SSL_DH_anon_WITH_RC4_128_MD5 24)
(defconstant $SSL_DH_anon_EXPORT_WITH_DES40_CBC_SHA 25)
(defconstant $SSL_DH_anon_WITH_DES_CBC_SHA 26)
(defconstant $SSL_DH_anon_WITH_3DES_EDE_CBC_SHA 27)
(defconstant $SSL_FORTEZZA_DMS_WITH_NULL_SHA 28)
(defconstant $SSL_FORTEZZA_DMS_WITH_FORTEZZA_CBC_SHA 29)
; 
; 	 * Tags for SSL 2 cipher kinds which are not specified 
; 	 * for SSL 3. 
; 	 

(defconstant $SSL_RSA_WITH_RC2_CBC_MD5 #xFF80)
(defconstant $SSL_RSA_WITH_IDEA_CBC_MD5 #xFF81)
(defconstant $SSL_RSA_WITH_DES_CBC_MD5 #xFF82)
(defconstant $SSL_RSA_WITH_3DES_EDE_CBC_MD5 #xFF83)
(defconstant $SSL_NO_SUCH_CIPHERSUITE #xFFFF)

; #endif	/* !_SECURITY_CIPHERSUITE_H_ */


(provide-interface "CipherSuite")