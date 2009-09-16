(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:igmp.h"
; at Sunday July 2,2006 7:28:00 pm.
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
;  * Copyright (c) 1988 Stephen Deering.
;  * Copyright (c) 1992, 1993
;  *	The Regents of the University of California.  All rights reserved.
;  *
;  * This code is derived from software contributed to Berkeley by
;  * Stephen Deering of Stanford University.
;  *
;  * Redistribution and use in source and binary forms, with or without
;  * modification, are permitted provided that the following conditions
;  * are met:
;  * 1. Redistributions of source code must retain the above copyright
;  *    notice, this list of conditions and the following disclaimer.
;  * 2. Redistributions in binary form must reproduce the above copyright
;  *    notice, this list of conditions and the following disclaimer in the
;  *    documentation and/or other materials provided with the distribution.
;  * 3. All advertising materials mentioning features or use of this software
;  *    must display the following acknowledgement:
;  *	This product includes software developed by the University of
;  *	California, Berkeley and its contributors.
;  * 4. Neither the name of the University nor the names of its contributors
;  *    may be used to endorse or promote products derived from this software
;  *    without specific prior written permission.
;  *
;  * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
;  * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;  * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
;  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
;  * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;  * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
;  * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
;  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
;  * SUCH DAMAGE.
;  *
;  *	@(#)igmp.h	8.1 (Berkeley) 6/10/93
;  * $FreeBSD: src/sys/netinet/igmp.h,v 1.10 1999/08/28 00:49:15 peter Exp $
;  
; #ifndef _NETINET_IGMP_H_
; #define _NETINET_IGMP_H_

(require-interface "sys/appleapiopts")
; 
;  * Internet Group Management Protocol (IGMP) definitions.
;  *
;  * Written by Steve Deering, Stanford, May 1988.
;  *
;  * MULTICAST Revision: 3.5.1.2
;  
; 
;  * IGMP packet format.
;  
(defrecord igmp
   (igmp_type :UInt8)
                                                ;  version & type of IGMP message  
   (igmp_code :UInt8)
                                                ;  subtype for routing msgs        
   (igmp_cksum :UInt16)
                                                ;  IP-style checksum               
   (igmp_group :IN_ADDR)
                                                ;  group address being reported    
)
;   (zero for queries)             
(defconstant $IGMP_MINLEN 8)
; #define IGMP_MINLEN		     8
; 
;  * Message types, including version number.
;  
(defconstant $IGMP_MEMBERSHIP_QUERY 17)
; #define IGMP_MEMBERSHIP_QUERY   	0x11	/* membership query         */
(defconstant $IGMP_V1_MEMBERSHIP_REPORT 18)
; #define IGMP_V1_MEMBERSHIP_REPORT	0x12	/* Ver. 1 membership report */
(defconstant $IGMP_V2_MEMBERSHIP_REPORT 22)
; #define IGMP_V2_MEMBERSHIP_REPORT	0x16	/* Ver. 2 membership report */
(defconstant $IGMP_V2_LEAVE_GROUP 23)
; #define IGMP_V2_LEAVE_GROUP		0x17	/* Leave-group message	    */
(defconstant $IGMP_DVMRP 19)
; #define IGMP_DVMRP			0x13	/* DVMRP routing message    */
(defconstant $IGMP_PIM 20)
; #define IGMP_PIM			0x14	/* PIM routing message	    */
(defconstant $IGMP_MTRACE_RESP 30)
; #define IGMP_MTRACE_RESP		0x1e  /* traceroute resp.(to sender)*/
(defconstant $IGMP_MTRACE 31)
; #define IGMP_MTRACE			0x1f  /* mcast traceroute messages  */
(defconstant $IGMP_MAX_HOST_REPORT_DELAY 10)
; #define IGMP_MAX_HOST_REPORT_DELAY   10    /* max delay for response to     */
;   query (in seconds) according 
;   to RFC1112                   
(defconstant $IGMP_TIMER_SCALE 10)
; #define IGMP_TIMER_SCALE     10		/* denotes that the igmp code field */
;  specifies time in 10th of seconds
; 
;  * The following four defininitions are for backwards compatibility.
;  * They should be removed as soon as all applications are updated to
;  * use the new constant names.
;  
; #define IGMP_HOST_MEMBERSHIP_QUERY	IGMP_MEMBERSHIP_QUERY
; #define IGMP_HOST_MEMBERSHIP_REPORT	IGMP_V1_MEMBERSHIP_REPORT
; #define IGMP_HOST_NEW_MEMBERSHIP_REPORT	IGMP_V2_MEMBERSHIP_REPORT
; #define IGMP_HOST_LEAVE_MESSAGE		IGMP_V2_LEAVE_GROUP

; #endif /* _NETINET_IGMP_H_ */


(provide-interface "igmp")