(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:OSBase.h"
; at Sunday July 2,2006 7:25:44 pm.
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
;  * Copyright (c) 1999 Apple Computer, Inc.  All rights reserved.
;  *
;  * HISTORY
;  *
;  
; #ifndef _OS_OSBASE_H
; #define _OS_OSBASE_H

(require-interface "sys/cdefs")

(require-interface "libkern/OSTypes")

(require-interface "stdint")
#|
uint64_t
__OSAbsoluteTime(
	AbsoluteTime	abstime)
{
	return (*(uint64_t *)&abstime);
|#
#|
uint64_t *
__OSAbsoluteTimePtr(
	AbsoluteTime	*abstime)
{
	return ((uint64_t *)abstime);
|#

; #endif /* _OS_OSBASE_H */


(provide-interface "OSBase")