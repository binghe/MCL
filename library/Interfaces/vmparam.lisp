(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:vmparam.h"
; at Sunday July 2,2006 7:32:15 pm.
; 
;  * Copyright (c) 2000-2002 Apple Computer, Inc. All rights reserved.
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
; #ifndef	_BSD_I386_VMPARAM_H_
(defconstant $_BSD_I386_VMPARAM_H_ 1)
; #define	_BSD_I386_VMPARAM_H_ 1

(require-interface "sys/resource")
(defconstant $USRSTACK 3221196800)
; #define	USRSTACK	0xbfff9000
; 
;  * Virtual memory related constants, all in bytes
;  
; #ifndef DFLDSIZ
(defconstant $DFLDSIZ 6291456)
; #define	DFLDSIZ		(6*1024*1024)		/* initial data size limit */

; #endif

; #ifndef MAXDSIZ
; #define	MAXDSIZ		(RLIM_INFINITY)		/* max data size */

; #endif

; #ifndef	DFLSSIZ
(defconstant $DFLSSIZ 8359936)
; #define	DFLSSIZ		(8*1024*1024 - 7*4*1024)	/* initial stack size limit */

; #endif

; #ifndef	MAXSSIZ
(defconstant $MAXSSIZ 67080192)
; #define	MAXSSIZ		(64*1024*1024 - 7*4*1024)	/* max stack size */

; #endif

; #ifndef	DFLCSIZ
(defconstant $DFLCSIZ 0)
; #define DFLCSIZ		(0)			/* initial core size limit */

; #endif

; #ifndef	MAXCSIZ
; #define MAXCSIZ		(RLIM_INFINITY)		/* max core size */

; #endif	/* MAXCSIZ */


; #endif	/* _BSD_I386_VMPARAM_H_ */


(provide-interface "vmparam")