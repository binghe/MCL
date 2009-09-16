(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:task_ledger.h"
; at Sunday July 2,2006 7:32:04 pm.
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

(require-interface "sys/appleapiopts")
; #ifndef _MACH_TASK_LEDGER_H_
; #define _MACH_TASK_LEDGER_H_
; #ifdef  __APPLE_API_EVOLVING
#| #|


#define ITEM_THREADS		0	
#define ITEM_TASKS		1	

#define ITEM_VM	   		2	

#define LEDGER_N_ITEMS		3	

#define LEDGER_UNLIMITED	0	

#endif
|#
 |#
;  __APPLE_API_EVOLVING 

; #endif  /* _MACH_TASK_LEDGER_H_ */


(provide-interface "task_ledger")