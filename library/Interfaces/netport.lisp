(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:netport.h"
; at Sunday July 2,2006 7:30:34 pm.
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
;  Copyright (c) 1995 NeXT Computer, Inc. All Rights Reserved 
;  
;  * Copyright (c) 1987,1988,1989 Carnegie-Mellon University All rights reserved.
;  
; #ifndef	_SYS_NETPORT_H_
; #define _SYS_NETPORT_H_

(def-mactype :netaddr_t (find-mactype ':UInt32))
; 
;  * Network Port structure.
;  
(defrecord np_uid_t
   (np_uid_high :signed-long)
   (np_uid_low :signed-long)
)
(defrecord network_port_t
   (np_receiver :UInt32)
   (np_owner :UInt32)
   (np_puid :NP_UID_T)
   (np_sid :NP_UID_T)
)

; #endif	/* !_SYS_NETPORT_H_ */


(provide-interface "netport")