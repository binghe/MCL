(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:if_arp.h"
; at Sunday July 2,2006 7:27:58 pm.
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
;  * Copyright (c) 1986, 1993
;  *	The Regents of the University of California.  All rights reserved.
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
;  *	@(#)if_arp.h	8.1 (Berkeley) 6/10/93
;  * $FreeBSD: src/sys/net/if_arp.h,v 1.14.2.1 2000/07/11 20:46:55 archie Exp $
;  
; #ifndef _NET_IF_ARP_H_
; #define	_NET_IF_ARP_H_

(require-interface "sys/appleapiopts")

(require-interface "netinet/in")
; 
;  * Address Resolution Protocol.
;  *
;  * See RFC 826 for protocol description.  ARP packets are variable
;  * in size; the arphdr structure defines the fixed-length portion.
;  * Protocol type values are the same as those for 10 Mb/s Ethernet.
;  * It is followed by the variable-sized fields ar_sha, arp_spa,
;  * arp_tha and arp_tpa in that order, according to the lengths
;  * specified.  Field names used correspond to RFC 826.
;  
(defrecord arphdr
   (ar_hrd :UInt16)
                                                ;  format of hardware address 
; #define ARPHRD_ETHER 	1	/* ethernet hardware format */
; #define ARPHRD_IEEE802	6	/* token-ring hardware format */
; #define ARPHRD_FRELAY 	15	/* frame relay hardware format */
; #define ARPHRD_IEEE1394	24	/* IEEE1394 hardware address */
; #define ARPHRD_IEEE1394_EUI64 27 /* IEEE1394 EUI-64 */
   (ar_pro :UInt16)
                                                ;  format of protocol address 
   (ar_hln :UInt8)
                                                ;  length of hardware address 
   (ar_pln :UInt8)
                                                ;  length of protocol address 
   (ar_op :UInt16)
                                                ;  one of: 
; #define	ARPOP_REQUEST	1	/* request to resolve address */
; #define	ARPOP_REPLY	2	/* response to previous request */
; #define	ARPOP_REVREQUEST 3	/* request protocol address given hardware */
; #define	ARPOP_REVREPLY	4	/* response giving protocol address */
; #define ARPOP_INVREQUEST 8 	/* request to identify peer */
; #define ARPOP_INVREPLY	9	/* response identifying peer */
                                                ; 
;  * The remaining fields are variable in size,
;  * according to the sizes above.
;  
; #ifdef COMMENT_ONLY
#| #|
	u_char	ar_sha[];	
	u_char	ar_spa[];	
	u_char	ar_tha[];	
	u_char	ar_tpa[];	
#endif
|#
 |#
)
; 
;  * ARP ioctl request
;  
(defrecord arpreq
   (arp_pa :SOCKADDR)
                                                ;  protocol address 
   (arp_ha :SOCKADDR)
                                                ;  hardware address 
   (arp_flags :signed-long)
                                                ;  flags 
)
;   arp_flags and at_flags field values 
(defconstant $ATF_INUSE 1)
; #define	ATF_INUSE	0x01	/* entry in use */
(defconstant $ATF_COM 2)
; #define ATF_COM		0x02	/* completed entry (enaddr valid) */
(defconstant $ATF_PERM 4)
; #define	ATF_PERM	0x04	/* permanent entry */
(defconstant $ATF_PUBL 8)
; #define	ATF_PUBL	0x08	/* publish entry (respond for other host) */
(defconstant $ATF_USETRAILERS 16)
; #define	ATF_USETRAILERS	0x10	/* has requested trailers */
; #ifdef __APPLE_API_UNSTABLE
#| #|

#ifdef__APPLE__

struct ether_multi {
	u_char	enm_addrlo[6];		
	u_char	enm_addrhi[6];		
	struct	arpcom *enm_ac;		
	u_int	enm_refcount;		
	struct	ether_multi *enm_next;	
};


struct ether_multistep {
	struct ether_multi  *e_enm;
};
#endif

#ifdefKERNEL

struct	arpcom {
	
	struct 	ifnet ac_if;		
	u_char	ac_enaddr[6];		
#ifdef__APPLE__
	struct	in_addr ac_ipaddr;	
	struct	ether_multi *ac_multiaddrs; 
#endif	int	ac_multicnt;		
#ifndef__APPLE__
	void	*ac_netgraph;		
#endif};


#endif#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif /* !_NET_IF_ARP_H_ */


(provide-interface "if_arp")