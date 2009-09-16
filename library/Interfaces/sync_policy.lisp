(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:sync_policy.h"
; at Sunday July 2,2006 7:26:22 pm.
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
; 
;  * @OSF_COPYRIGHT@
;  
; #ifndef	_SYNC_POLICY_H_
; #define _SYNC_POLICY_H_

(def-mactype :sync_policy_t (find-mactype ':signed-long))
; 
;  *	These options define the wait ordering of the synchronizers
;  
(defconstant $SYNC_POLICY_FIFO 0)
; #define SYNC_POLICY_FIFO		0x0
(defconstant $SYNC_POLICY_FIXED_PRIORITY 1)
; #define SYNC_POLICY_FIXED_PRIORITY	0x1
(defconstant $SYNC_POLICY_REVERSED 2)
; #define SYNC_POLICY_REVERSED		0x2
(defconstant $SYNC_POLICY_ORDER_MASK 3)
; #define SYNC_POLICY_ORDER_MASK		0x3
(defconstant $SYNC_POLICY_LIFO 2)
; #define SYNC_POLICY_LIFO		(SYNC_POLICY_FIFO|SYNC_POLICY_REVERSED)
; 
;  *	These options provide addition (kernel-private) behaviors
;  
; #ifdef	KERNEL_PRIVATE
#| #|
#include <sysappleapiopts.h>

#ifdef __APPLE_API_EVOLVING

#define SYNC_POLICY_PREPOST		0x4

#endif 

#endif
|#
 |#
;  KERNEL_PRIVATE 
(defconstant $SYNC_POLICY_MAX 7)
; #define SYNC_POLICY_MAX			0x7

; #endif 	/*_SYNC_POLICY_H_*/


(provide-interface "sync_policy")