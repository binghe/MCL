(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:rtmp.h"
; at Sunday July 2,2006 7:31:27 pm.
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
;  *	Copyright (c) 1988, 1989 Apple Computer, Inc. 
;  
; #ifndef _NETAT_RTMP_H_
; #define _NETAT_RTMP_H_

(require-interface "sys/appleapiopts")
;  Changed 03-22-94 for router support  LD 
;  RTMP function codes 
(defconstant $RTMP_REQ_FUNC1 1)
; #define RTMP_REQ_FUNC1		0x01	/* RTMP request function code=1 */
(defconstant $RTMP_REQ_FUNC2 2)
; #define RTMP_REQ_FUNC2		0x02	/* Route Data Req with Split Horizon */
(defconstant $RTMP_REQ_FUNC3 3)
; #define RTMP_REQ_FUNC3		0x03	/* Route Data Req no Split Horizon */
(defconstant $RTMP_ROUTER_AGE 50)
; #define RTMP_ROUTER_AGE		50	/* Number of seconds to age router */
;  RTMP response and data packet format 
(defrecord at_rtmp
   (at_rtmp_this_net :ua_short)
   (at_rtmp_id_length :UInt8)
   (at_rtmp_id (:array :UInt8 1))
)
;  RTMP network/distance data tuples 
(defconstant $RTMP_TUPLE_SIZE 3)
; #define RTMP_TUPLE_SIZE		3
;  Extended AppleTalk tuple can be thought of as two of
;  * these tuples back to back.
;  
(defconstant $RTMP_RANGE_FLAG 128)
; #define RTMP_RANGE_FLAG 0x80
(defconstant $RTMP_DISTANCE 15)
; #define RTMP_DISTANCE   0x0f
(defrecord at_rtmp_tuple
   (at_rtmp_net :ua_short)
   (at_rtmp_data :UInt8)
)

; #endif /* _NETAT_RTMP_H_ */


(provide-interface "rtmp")