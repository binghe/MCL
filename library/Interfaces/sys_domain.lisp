(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:sys_domain.h"
; at Sunday July 2,2006 7:30:15 pm.
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
; #ifndef _SYSTEM_DOMAIN_H_
; #define _SYSTEM_DOMAIN_H_

(require-interface "sys/appleapiopts")
;  Kernel Events Protocol 
(defconstant $SYSPROTO_EVENT 1)
; #define SYSPROTO_EVENT 		1	/* kernel events protocol */
;  Kernel Control Protocol 
(defconstant $SYSPROTO_CONTROL 2)
; #define SYSPROTO_CONTROL       	2	/* kernel control protocol */
(defconstant $AF_SYS_CONTROL 2)
; #define AF_SYS_CONTROL		2	/* corresponding sub address type */
;  System family socket address 
(defrecord sockaddr_sys
   (ss_len :UInt8)
                                                ;  sizeof(struct sockaddr_sys) 
   (ss_family :UInt8)
                                                ;  AF_SYSTEM 
   (ss_sysaddr :UInt16)
                                                ;  protocol address in AF_SYSTEM 
   (ss_reserved (:array :UInt32 7))             ;  reserved to the protocol use 
)
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE

extern struct domain systemdomain;


int kern_event_init();
int kern_control_init();

#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* _SYSTEM_DOMAIN_H_ */


(provide-interface "sys_domain")