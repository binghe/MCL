(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ep.h"
; at Sunday July 2,2006 7:27:45 pm.
; 
;  * Copyright (c) 2000 Apple Computer, Inc. All rights reserved.
;  *
;  * @APPLE_LICENSE_HEADER_START@
;  * 
;  * The contents of this file constitute Original Code as defined in and
;  * are subject to the Apple Public Source License Version 1.1 (the
;  * "License").  You may not use this file except in compliance with the
;  * License.  Please obtain a copy of the License at
;  * http://www.apple.com/publicsource and read it before using this file.
;  * 
;  * This Original Code and all software distributed under the License are
;  * distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, EITHER
;  * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
;  * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
;  * FITNESS FOR A PARTICULAR PURPOSE OR NON-INFRINGEMENT.  Please see the
;  * License for the specific language governing rights and limitations
;  * under the License.
;  * 
;  * @APPLE_LICENSE_HEADER_END@
;  
; 
;  * ORIGINS: 82
;  *
;  * (C) COPYRIGHT Apple Computer, Inc. 1992-1996
;  * All Rights Reserved
;  *
;  
; #ifndef _NETAT_EP_H_
; #define _NETAT_EP_H_

(require-interface "sys/appleapiopts")
(defconstant $EP_REQUEST 1)
; #define EP_REQUEST         	1  	/* Echo request packet 		*/
(defconstant $EP_REPLY 2)
; #define EP_REPLY           	2  	/* Echo reply packet 		*/
;  Misc. definitions 
(defconstant $EP_DATA_SIZE 585)
; #define EP_DATA_SIZE		585   	/* Maximum size of EP data 	*/

; #endif /* _NETAT_EP_H_ */


(provide-interface "ep")