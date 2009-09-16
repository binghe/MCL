(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:disklabel.h"
; at Sunday July 2,2006 7:27:40 pm.
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
; #ifndef _MACHINE_DISKLABEL_H_
; #define _MACHINE_DISKLABEL_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_OBSOLETE
#| #|
#define LABELSECTOR	(1024  DEV_BSIZE)	
#define LABELOFFSET	0			
#define MAXPARTITIONS	8			
#define RAW_PART	2			


struct cpu_disklabel {
	int	cd_dummy;			
};
#endif
|#
 |#
;  __APPLE_API_OBSOLETE 

; #endif /* _MACHINE_DISKLABEL_H_ */


(provide-interface "disklabel")