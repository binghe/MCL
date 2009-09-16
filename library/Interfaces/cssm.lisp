(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:cssm.h"
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
;    File:      cssm.h
; 
;    Contains:  Common Security Services Manager Interface
; 
;    Copyright: (c) 1999-2000 Apple Computer, Inc., all rights reserved.
; 
; 
; #ifndef _CSSM_H_
(defconstant $_CSSM_H_ 1)
; #define _CSSM_H_  1

(require-interface "Security/cssmtype")

(require-interface "Security/emmtype")

(require-interface "Security/cssmapi")

(require-interface "Security/cssmerr")

(require-interface "Security/cssmapple")

; #endif /* _CSSM_H_ */


(provide-interface "cssm")