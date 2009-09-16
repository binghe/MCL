(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ip.h"
; at Sunday July 2,2006 7:27:14 pm.
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
;  * Copyright (c) 1982, 1986, 1993
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
;  *	@(#)ip.h	8.2 (Berkeley) 6/1/94
;  * $FreeBSD: src/sys/netinet/ip.h,v 1.17 1999/12/22 19:13:20 shin Exp $
;  
; #ifndef _NETINET_IP_H_
; #define _NETINET_IP_H_

(require-interface "sys/appleapiopts")
; 
;  * Definitions for internet protocol version 4.
;  * Per RFC 791, September 1981.
;  
(defconstant $IPVERSION 4)
; #define	IPVERSION	4
; 
;  * Structure of an internet header, naked of options.
;  
(defrecord ip
; #ifdef _IP_VHL
#| #|
	u_char	ip_vhl;			
|#
 |#

; #else

; #if BYTE_ORDER == LITTLE_ENDIAN
#| 
   (ip_hl :UInt32)                              ;(: 4)
                                                ;  header length 
                                                ;(ip_v : 4)
                                                ;  version 
 |#

; #endif


; #if BYTE_ORDER == BIG_ENDIAN
   (ip_v :UInt32)                               ;(: 4)
                                                ;  version 
                                                ;(ip_hl : 4)
                                                ;  header length 

; #endif


; #endif /* not _IP_VHL */

   (ip_tos :UInt8)
                                                ;  type of service 
   (ip_len :UInt16)
                                                ;  total length 
   (ip_id :UInt16)
                                                ;  identification 
   (ip_off :UInt16)
                                                ;  fragment offset field 
(defconstant $IP_RF 32768)
; #define	IP_RF 0x8000			/* reserved fragment flag */
(defconstant $IP_DF 16384)
; #define	IP_DF 0x4000			/* dont fragment flag */
(defconstant $IP_MF 8192)
; #define	IP_MF 0x2000			/* more fragments flag */
(defconstant $IP_OFFMASK 8191)
; #define	IP_OFFMASK 0x1fff		/* mask for fragmenting bits */
   (ip_ttl :UInt8)
                                                ;  time to live 
   (ip_p :UInt8)
                                                ;  protocol 
   (ip_sum :UInt16)
                                                ;  checksum 
   (ip_src :IN_ADDR)
   (ip_dst :IN_ADDR)                            ;  source and dest address 
)
; #ifdef _IP_VHL
#| #|
#define IP_MAKE_VHL(v, hl)	((v) << 4 | (hl))
#define IP_VHL_HL(vhl)		((vhl) & 0x0f)
#define IP_VHL_V(vhl)		((vhl) >> 4)
#define IP_VHL_BORING		0x45
#endif
|#
 |#
(defconstant $IP_MAXPACKET 65535)
; #define	IP_MAXPACKET	65535		/* maximum packet size */
; 
;  * Definitions for IP type of service (ip_tos)
;  
(defconstant $IPTOS_LOWDELAY 16)
; #define	IPTOS_LOWDELAY		0x10
(defconstant $IPTOS_THROUGHPUT 8)
; #define	IPTOS_THROUGHPUT	0x08
(defconstant $IPTOS_RELIABILITY 4)
; #define	IPTOS_RELIABILITY	0x04
(defconstant $IPTOS_MINCOST 2)
; #define	IPTOS_MINCOST		0x02
;  ECN bits proposed by Sally Floyd 
(defconstant $IPTOS_CE 1)
; #define	IPTOS_CE		0x01	/* congestion experienced */
(defconstant $IPTOS_ECT 2)
; #define	IPTOS_ECT		0x02	/* ECN-capable transport */
; 
;  * Definitions for IP precedence (also in ip_tos) (hopefully unused)
;  
(defconstant $IPTOS_PREC_NETCONTROL 224)
; #define	IPTOS_PREC_NETCONTROL		0xe0
(defconstant $IPTOS_PREC_INTERNETCONTROL 192)
; #define	IPTOS_PREC_INTERNETCONTROL	0xc0
(defconstant $IPTOS_PREC_CRITIC_ECP 160)
; #define	IPTOS_PREC_CRITIC_ECP		0xa0
(defconstant $IPTOS_PREC_FLASHOVERRIDE 128)
; #define	IPTOS_PREC_FLASHOVERRIDE	0x80
(defconstant $IPTOS_PREC_FLASH 96)
; #define	IPTOS_PREC_FLASH		0x60
(defconstant $IPTOS_PREC_IMMEDIATE 64)
; #define	IPTOS_PREC_IMMEDIATE		0x40
(defconstant $IPTOS_PREC_PRIORITY 32)
; #define	IPTOS_PREC_PRIORITY		0x20
(defconstant $IPTOS_PREC_ROUTINE 0)
; #define	IPTOS_PREC_ROUTINE		0x00
; 
;  * Definitions for options.
;  
; #define	IPOPT_COPIED(o)		((o)&0x80)
; #define	IPOPT_CLASS(o)		((o)&0x60)
; #define	IPOPT_NUMBER(o)		((o)&0x1f)
(defconstant $IPOPT_CONTROL 0)
; #define	IPOPT_CONTROL		0x00
(defconstant $IPOPT_RESERVED1 32)
; #define	IPOPT_RESERVED1		0x20
(defconstant $IPOPT_DEBMEAS 64)
; #define	IPOPT_DEBMEAS		0x40
(defconstant $IPOPT_RESERVED2 96)
; #define	IPOPT_RESERVED2		0x60
(defconstant $IPOPT_EOL 0)
; #define	IPOPT_EOL		0		/* end of option list */
(defconstant $IPOPT_NOP 1)
; #define	IPOPT_NOP		1		/* no operation */
(defconstant $IPOPT_RR 7)
; #define	IPOPT_RR		7		/* record packet route */
(defconstant $IPOPT_TS 68)
; #define	IPOPT_TS		68		/* timestamp */
(defconstant $IPOPT_SECURITY 130)
; #define	IPOPT_SECURITY		130		/* provide s,c,h,tcc */
(defconstant $IPOPT_LSRR 131)
; #define	IPOPT_LSRR		131		/* loose source route */
(defconstant $IPOPT_SATID 136)
; #define	IPOPT_SATID		136		/* satnet id */
(defconstant $IPOPT_SSRR 137)
; #define	IPOPT_SSRR		137		/* strict source route */
(defconstant $IPOPT_RA 148)
; #define	IPOPT_RA		148		/* router alert */
; 
;  * Offsets to fields in options other than EOL and NOP.
;  
(defconstant $IPOPT_OPTVAL 0)
; #define	IPOPT_OPTVAL		0		/* option ID */
(defconstant $IPOPT_OLEN 1)
; #define	IPOPT_OLEN		1		/* option length */
(defconstant $IPOPT_OFFSET 2)
; #define IPOPT_OFFSET		2		/* offset within option */
(defconstant $IPOPT_MINOFF 4)
; #define	IPOPT_MINOFF		4		/* min value of above */
; 
;  * Time stamp option structure.
;  
(defrecord ip_timestamp
   (ipt_code :UInt8)
                                                ;  IPOPT_TS 
   (ipt_len :UInt8)
                                                ;  size of structure (variable) 
   (ipt_ptr :UInt8)
                                                ;  index of current entry 

; #if BYTE_ORDER == LITTLE_ENDIAN
#| 
   (ipt_flg :UInt32)                            ;(: 4)
                                                ;  flags, see below 
                                                ;(ipt_oflw : 4)
                                                ;  overflow counter 
 |#

; #endif


; #if BYTE_ORDER == BIG_ENDIAN
   (ipt_oflw :UInt32)                           ;(: 4)
                                                ;  overflow counter 
                                                ;(ipt_flg : 4)
                                                ;  flags, see below 

; #endif

   (:variant
   (
   (ipt_time (:array :UInt32 1))
   )
   (
   (ipt_addr :IN_ADDR)
   (ipt_time :UInt32)
#|
 confused about [ 1 #\]
|#
   )
   )
)
;  flag bits for ipt_flg 
(defconstant $IPOPT_TS_TSONLY 0)
; #define	IPOPT_TS_TSONLY		0		/* timestamps only */
(defconstant $IPOPT_TS_TSANDADDR 1)
; #define	IPOPT_TS_TSANDADDR	1		/* timestamps and addresses */
(defconstant $IPOPT_TS_PRESPEC 3)
; #define	IPOPT_TS_PRESPEC	3		/* specified modules only */
;  bits for security (not byte swapped) 
(defconstant $IPOPT_SECUR_UNCLASS 0)
; #define	IPOPT_SECUR_UNCLASS	0x0000
(defconstant $IPOPT_SECUR_CONFID 61749)
; #define	IPOPT_SECUR_CONFID	0xf135
(defconstant $IPOPT_SECUR_EFTO 30874)
; #define	IPOPT_SECUR_EFTO	0x789a
(defconstant $IPOPT_SECUR_MMMM 48205)
; #define	IPOPT_SECUR_MMMM	0xbc4d
(defconstant $IPOPT_SECUR_RESTR 44819)
; #define	IPOPT_SECUR_RESTR	0xaf13
(defconstant $IPOPT_SECUR_SECRET 55176)
; #define	IPOPT_SECUR_SECRET	0xd788
(defconstant $IPOPT_SECUR_TOPSECRET 27589)
; #define	IPOPT_SECUR_TOPSECRET	0x6bc5
; 
;  * Internet implementation parameters.
;  
(defconstant $MAXTTL 255)
; #define	MAXTTL		255		/* maximum time to live (seconds) */
(defconstant $IPDEFTTL 64)
; #define	IPDEFTTL	64		/* default ttl, from RFC 1340 */
(defconstant $IPFRAGTTL 60)
; #define	IPFRAGTTL	60		/* time to live for frags, slowhz */
(defconstant $IPTTLDEC 1)
; #define	IPTTLDEC	1		/* subtracted when forwarding */
(defconstant $IP_MSS 576)
; #define	IP_MSS		576		/* default maximum segment size */

; #endif


(provide-interface "ip")