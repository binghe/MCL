(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:in.h"
; at Sunday July 2,2006 7:27:13 pm.
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
;  * Copyright (c) 1982, 1986, 1990, 1993
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
;  *	@(#)in.h	8.3 (Berkeley) 1/3/94
;  * $FreeBSD: src/sys/netinet/in.h,v 1.48.2.2 2001/04/21 14:53:06 ume Exp $
;  
; #ifndef _NETINET_IN_H_
; #define _NETINET_IN_H_

(require-interface "sys/appleapiopts")
; 
;  * Constants and structures defined by the internet system,
;  * Per RFC 790, September 1981, and numerous additions.
;  
; 
;  * Protocols (RFC 1700)
;  
(defconstant $IPPROTO_IP 0)
; #define	IPPROTO_IP		0		/* dummy for IP */
(defconstant $IPPROTO_HOPOPTS 0)
; #define	IPPROTO_HOPOPTS	0		/* IP6 hop-by-hop options */
(defconstant $IPPROTO_ICMP 1)
; #define	IPPROTO_ICMP		1		/* control message protocol */
(defconstant $IPPROTO_IGMP 2)
; #define	IPPROTO_IGMP		2		/* group mgmt protocol */
(defconstant $IPPROTO_GGP 3)
; #define	IPPROTO_GGP		3		/* gateway^2 (deprecated) */
(defconstant $IPPROTO_IPV4 4)
; #define IPPROTO_IPV4		4 		/* IPv4 encapsulation */
; #define IPPROTO_IPIP		IPPROTO_IPV4	/* for compatibility */
(defconstant $IPPROTO_TCP 6)
; #define	IPPROTO_TCP		6		/* tcp */
(defconstant $IPPROTO_ST 7)
; #define	IPPROTO_ST		7		/* Stream protocol II */
(defconstant $IPPROTO_EGP 8)
; #define	IPPROTO_EGP		8		/* exterior gateway protocol */
(defconstant $IPPROTO_PIGP 9)
; #define	IPPROTO_PIGP		9		/* private interior gateway */
(defconstant $IPPROTO_RCCMON 10)
; #define	IPPROTO_RCCMON		10		/* BBN RCC Monitoring */
(defconstant $IPPROTO_NVPII 11)
; #define	IPPROTO_NVPII		11		/* network voice protocol*/
(defconstant $IPPROTO_PUP 12)
; #define	IPPROTO_PUP		12		/* pup */
(defconstant $IPPROTO_ARGUS 13)
; #define	IPPROTO_ARGUS		13		/* Argus */
(defconstant $IPPROTO_EMCON 14)
; #define	IPPROTO_EMCON		14		/* EMCON */
(defconstant $IPPROTO_XNET 15)
; #define	IPPROTO_XNET		15		/* Cross Net Debugger */
(defconstant $IPPROTO_CHAOS 16)
; #define	IPPROTO_CHAOS		16		/* Chaos*/
(defconstant $IPPROTO_UDP 17)
; #define	IPPROTO_UDP		17		/* user datagram protocol */
(defconstant $IPPROTO_MUX 18)
; #define	IPPROTO_MUX		18		/* Multiplexing */
(defconstant $IPPROTO_MEAS 19)
; #define	IPPROTO_MEAS		19		/* DCN Measurement Subsystems */
(defconstant $IPPROTO_HMP 20)
; #define	IPPROTO_HMP		20		/* Host Monitoring */
(defconstant $IPPROTO_PRM 21)
; #define	IPPROTO_PRM		21		/* Packet Radio Measurement */
(defconstant $IPPROTO_IDP 22)
; #define	IPPROTO_IDP		22		/* xns idp */
(defconstant $IPPROTO_TRUNK1 23)
; #define	IPPROTO_TRUNK1		23		/* Trunk-1 */
(defconstant $IPPROTO_TRUNK2 24)
; #define	IPPROTO_TRUNK2		24		/* Trunk-2 */
(defconstant $IPPROTO_LEAF1 25)
; #define	IPPROTO_LEAF1		25		/* Leaf-1 */
(defconstant $IPPROTO_LEAF2 26)
; #define	IPPROTO_LEAF2		26		/* Leaf-2 */
(defconstant $IPPROTO_RDP 27)
; #define	IPPROTO_RDP		27		/* Reliable Data */
(defconstant $IPPROTO_IRTP 28)
; #define	IPPROTO_IRTP		28		/* Reliable Transaction */
(defconstant $IPPROTO_TP 29)
; #define	IPPROTO_TP		29 		/* tp-4 w/ class negotiation */
(defconstant $IPPROTO_BLT 30)
; #define	IPPROTO_BLT		30		/* Bulk Data Transfer */
(defconstant $IPPROTO_NSP 31)
; #define	IPPROTO_NSP		31		/* Network Services */
(defconstant $IPPROTO_INP 32)
; #define	IPPROTO_INP		32		/* Merit Internodal */
(defconstant $IPPROTO_SEP 33)
; #define	IPPROTO_SEP		33		/* Sequential Exchange */
(defconstant $IPPROTO_3PC 34)
; #define	IPPROTO_3PC		34		/* Third Party Connect */
(defconstant $IPPROTO_IDPR 35)
; #define	IPPROTO_IDPR		35		/* InterDomain Policy Routing */
(defconstant $IPPROTO_XTP 36)
; #define	IPPROTO_XTP		36		/* XTP */
(defconstant $IPPROTO_DDP 37)
; #define	IPPROTO_DDP		37		/* Datagram Delivery */
(defconstant $IPPROTO_CMTP 38)
; #define	IPPROTO_CMTP		38		/* Control Message Transport */
(defconstant $IPPROTO_TPXX 39)
; #define	IPPROTO_TPXX		39		/* TP++ Transport */
(defconstant $IPPROTO_IL 40)
; #define	IPPROTO_IL		40		/* IL transport protocol */
(defconstant $IPPROTO_IPV6 41)
; #define 	IPPROTO_IPV6		41		/* IP6 header */
(defconstant $IPPROTO_SDRP 42)
; #define	IPPROTO_SDRP		42		/* Source Demand Routing */
(defconstant $IPPROTO_ROUTING 43)
; #define 	IPPROTO_ROUTING	43		/* IP6 routing header */
(defconstant $IPPROTO_FRAGMENT 44)
; #define 	IPPROTO_FRAGMENT	44		/* IP6 fragmentation header */
(defconstant $IPPROTO_IDRP 45)
; #define	IPPROTO_IDRP		45		/* InterDomain Routing*/
(defconstant $IPPROTO_RSVP 46)
; #define 	IPPROTO_RSVP		46 		/* resource reservation */
(defconstant $IPPROTO_GRE 47)
; #define	IPPROTO_GRE		47		/* General Routing Encap. */
(defconstant $IPPROTO_MHRP 48)
; #define	IPPROTO_MHRP		48		/* Mobile Host Routing */
(defconstant $IPPROTO_BHA 49)
; #define	IPPROTO_BHA		49		/* BHA */
(defconstant $IPPROTO_ESP 50)
; #define	IPPROTO_ESP		50		/* IP6 Encap Sec. Payload */
(defconstant $IPPROTO_AH 51)
; #define	IPPROTO_AH		51		/* IP6 Auth Header */
(defconstant $IPPROTO_INLSP 52)
; #define	IPPROTO_INLSP		52		/* Integ. Net Layer Security */
(defconstant $IPPROTO_SWIPE 53)
; #define	IPPROTO_SWIPE		53		/* IP with encryption */
(defconstant $IPPROTO_NHRP 54)
; #define	IPPROTO_NHRP		54		/* Next Hop Resolution */
;  55-57: Unassigned 
(defconstant $IPPROTO_ICMPV6 58)
; #define 	IPPROTO_ICMPV6	58		/* ICMP6 */
(defconstant $IPPROTO_NONE 59)
; #define 	IPPROTO_NONE		59		/* IP6 no next header */
(defconstant $IPPROTO_DSTOPTS 60)
; #define 	IPPROTO_DSTOPTS	60		/* IP6 destination option */
(defconstant $IPPROTO_AHIP 61)
; #define	IPPROTO_AHIP		61		/* any host internal protocol */
(defconstant $IPPROTO_CFTP 62)
; #define	IPPROTO_CFTP		62		/* CFTP */
(defconstant $IPPROTO_HELLO 63)
; #define	IPPROTO_HELLO		63		/* "hello" routing protocol */
(defconstant $IPPROTO_SATEXPAK 64)
; #define	IPPROTO_SATEXPAK	64		/* SATNET/Backroom EXPAK */
(defconstant $IPPROTO_KRYPTOLAN 65)
; #define	IPPROTO_KRYPTOLAN	65		/* Kryptolan */
(defconstant $IPPROTO_RVD 66)
; #define	IPPROTO_RVD		66		/* Remote Virtual Disk */
(defconstant $IPPROTO_IPPC 67)
; #define	IPPROTO_IPPC		67		/* Pluribus Packet Core */
(defconstant $IPPROTO_ADFS 68)
; #define	IPPROTO_ADFS		68		/* Any distributed FS */
(defconstant $IPPROTO_SATMON 69)
; #define	IPPROTO_SATMON		69		/* Satnet Monitoring */
(defconstant $IPPROTO_VISA 70)
; #define	IPPROTO_VISA		70		/* VISA Protocol */
(defconstant $IPPROTO_IPCV 71)
; #define	IPPROTO_IPCV		71		/* Packet Core Utility */
(defconstant $IPPROTO_CPNX 72)
; #define	IPPROTO_CPNX		72		/* Comp. Prot. Net. Executive */
(defconstant $IPPROTO_CPHB 73)
; #define	IPPROTO_CPHB		73		/* Comp. Prot. HeartBeat */
(defconstant $IPPROTO_WSN 74)
; #define	IPPROTO_WSN		74		/* Wang Span Network */
(defconstant $IPPROTO_PVP 75)
; #define	IPPROTO_PVP		75		/* Packet Video Protocol */
(defconstant $IPPROTO_BRSATMON 76)
; #define	IPPROTO_BRSATMON	76		/* BackRoom SATNET Monitoring */
(defconstant $IPPROTO_ND 77)
; #define	IPPROTO_ND		77		/* Sun net disk proto (temp.) */
(defconstant $IPPROTO_WBMON 78)
; #define	IPPROTO_WBMON		78		/* WIDEBAND Monitoring */
(defconstant $IPPROTO_WBEXPAK 79)
; #define	IPPROTO_WBEXPAK		79		/* WIDEBAND EXPAK */
(defconstant $IPPROTO_EON 80)
; #define	IPPROTO_EON		80		/* ISO cnlp */
(defconstant $IPPROTO_VMTP 81)
; #define	IPPROTO_VMTP		81		/* VMTP */
(defconstant $IPPROTO_SVMTP 82)
; #define	IPPROTO_SVMTP		82		/* Secure VMTP */
(defconstant $IPPROTO_VINES 83)
; #define	IPPROTO_VINES		83		/* Banyon VINES */
(defconstant $IPPROTO_TTP 84)
; #define	IPPROTO_TTP		84		/* TTP */
(defconstant $IPPROTO_IGP 85)
; #define	IPPROTO_IGP		85		/* NSFNET-IGP */
(defconstant $IPPROTO_DGP 86)
; #define	IPPROTO_DGP		86		/* dissimilar gateway prot. */
(defconstant $IPPROTO_TCF 87)
; #define	IPPROTO_TCF		87		/* TCF */
(defconstant $IPPROTO_IGRP 88)
; #define	IPPROTO_IGRP		88		/* Cisco/GXS IGRP */
(defconstant $IPPROTO_OSPFIGP 89)
; #define	IPPROTO_OSPFIGP		89		/* OSPFIGP */
(defconstant $IPPROTO_SRPC 90)
; #define	IPPROTO_SRPC		90		/* Strite RPC protocol */
(defconstant $IPPROTO_LARP 91)
; #define	IPPROTO_LARP		91		/* Locus Address Resoloution */
(defconstant $IPPROTO_MTP 92)
; #define	IPPROTO_MTP		92		/* Multicast Transport */
(defconstant $IPPROTO_AX25 93)
; #define	IPPROTO_AX25		93		/* AX.25 Frames */
(defconstant $IPPROTO_IPEIP 94)
; #define	IPPROTO_IPEIP		94		/* IP encapsulated in IP */
(defconstant $IPPROTO_MICP 95)
; #define	IPPROTO_MICP		95		/* Mobile Int.ing control */
(defconstant $IPPROTO_SCCSP 96)
; #define	IPPROTO_SCCSP		96		/* Semaphore Comm. security */
(defconstant $IPPROTO_ETHERIP 97)
; #define	IPPROTO_ETHERIP		97		/* Ethernet IP encapsulation */
(defconstant $IPPROTO_ENCAP 98)
; #define	IPPROTO_ENCAP		98		/* encapsulation header */
(defconstant $IPPROTO_APES 99)
; #define	IPPROTO_APES		99		/* any private encr. scheme */
(defconstant $IPPROTO_GMTP 100)
; #define	IPPROTO_GMTP		100		/* GMTP*/
(defconstant $IPPROTO_IPCOMP 108)
; #define	IPPROTO_IPCOMP	108		/* payload compression (IPComp) */
;  101-254: Partly Unassigned 
(defconstant $IPPROTO_PIM 103)
; #define	IPPROTO_PIM		103		/* Protocol Independent Mcast */
(defconstant $IPPROTO_PGM 113)
; #define	IPPROTO_PGM		113		/* PGM */
;  255: Reserved 
;  BSD Private, local use, namespace incursion 
(defconstant $IPPROTO_DIVERT 254)
; #define	IPPROTO_DIVERT		254		/* divert pseudo-protocol */
(defconstant $IPPROTO_RAW 255)
; #define	IPPROTO_RAW		255		/* raw IP packet */
(defconstant $IPPROTO_MAX 256)
; #define	IPPROTO_MAX		256
;  last return value of *_input(), meaning "all job for this pkt is done".  
(defconstant $IPPROTO_DONE 257)
; #define	IPPROTO_DONE		257
; 
;  * Local port number conventions:
;  *
;  * When a user does a bind(2) or connect(2) with a port number of zero,
;  * a non-conflicting local port address is chosen.
;  * The default range is IPPORT_RESERVED through
;  * IPPORT_USERRESERVED, although that is settable by sysctl.
;  *
;  * A user may set the IPPROTO_IP option IP_PORTRANGE to change this
;  * default assignment range.
;  *
;  * The value IP_PORTRANGE_DEFAULT causes the default behavior.
;  *
;  * The value IP_PORTRANGE_HIGH changes the range of candidate port numbers
;  * into the "high" range.  These are reserved for client outbound connections
;  * which do not want to be filtered by any firewalls.
;  *
;  * The value IP_PORTRANGE_LOW changes the range to the "low" are
;  * that is (by convention) restricted to privileged processes.  This
;  * convention is based on "vouchsafe" principles only.  It is only secure
;  * if you trust the remote host to restrict these ports.
;  *
;  * The default range of ports and the high range can be changed by
;  * sysctl(3).  (net.inet.ip.port{hi,low}{first,last}_auto)
;  *
;  * Changing those values has bad security implications if you are
;  * using a a stateless firewall that is allowing packets outside of that
;  * range in order to allow transparent outgoing connections.
;  *
;  * Such a firewall configuration will generally depend on the use of these
;  * default values.  If you change them, you may find your Security
;  * Administrator looking for you with a heavy object.
;  *
;  * For a slightly more orthodox text view on this:
;  *
;  *            ftp://ftp.isi.edu/in-notes/iana/assignments/port-numbers
;  *
;  *    port numbers are divided into three ranges:
;  *
;  *                0 -  1023 Well Known Ports
;  *             1024 - 49151 Registered Ports
;  *            49152 - 65535 Dynamic and/or Private Ports
;  *
;  
; 
;  * Ports < IPPORT_RESERVED are reserved for
;  * privileged processes (e.g. root).         (IP_PORTRANGE_LOW)
;  * Ports > IPPORT_USERRESERVED are reserved
;  * for servers, not necessarily privileged.  (IP_PORTRANGE_DEFAULT)
;  
(defconstant $IPPORT_RESERVED 1024)
; #define	IPPORT_RESERVED		1024
(defconstant $IPPORT_USERRESERVED 5000)
; #define	IPPORT_USERRESERVED	5000
; 
;  * Default local port range to use by setting IP_PORTRANGE_HIGH
;  
(defconstant $IPPORT_HIFIRSTAUTO 49152)
; #define	IPPORT_HIFIRSTAUTO	49152
(defconstant $IPPORT_HILASTAUTO 65535)
; #define	IPPORT_HILASTAUTO	65535
; 
;  * Scanning for a free reserved port return a value below IPPORT_RESERVED,
;  * but higher than IPPORT_RESERVEDSTART.  Traditionally the start value was
;  * 512, but that conflicts with some well-known-services that firewalls may
;  * have a fit if we use.
;  
(defconstant $IPPORT_RESERVEDSTART 600)
; #define IPPORT_RESERVEDSTART	600
; 
;  * Internet address (a structure for historical reasons)
;  
(defrecord in_addr
   (s_addr :UInt32)
)
; 
;  * Definitions of bits in internet address integers.
;  * On subnets, the decomposition of addresses to host and net parts
;  * is done according to subnet mask, not the masks here.
;  
; #define	IN_CLASSA(i)		(((u_int32_t)(i) & 0x80000000) == 0)
(defconstant $IN_CLASSA_NET 4278190080)
; #define	IN_CLASSA_NET		0xff000000
(defconstant $IN_CLASSA_NSHIFT 24)
; #define	IN_CLASSA_NSHIFT	24
(defconstant $IN_CLASSA_HOST 16777215)
; #define	IN_CLASSA_HOST		0x00ffffff
(defconstant $IN_CLASSA_MAX 128)
; #define	IN_CLASSA_MAX		128
; #define	IN_CLASSB(i)		(((u_int32_t)(i) & 0xc0000000) == 0x80000000)
(defconstant $IN_CLASSB_NET 4294901760)
; #define	IN_CLASSB_NET		0xffff0000
(defconstant $IN_CLASSB_NSHIFT 16)
; #define	IN_CLASSB_NSHIFT	16
(defconstant $IN_CLASSB_HOST 65535)
; #define	IN_CLASSB_HOST		0x0000ffff
(defconstant $IN_CLASSB_MAX 65536)
; #define	IN_CLASSB_MAX		65536
; #define	IN_CLASSC(i)		(((u_int32_t)(i) & 0xe0000000) == 0xc0000000)
(defconstant $IN_CLASSC_NET 4294967040)
; #define	IN_CLASSC_NET		0xffffff00
(defconstant $IN_CLASSC_NSHIFT 8)
; #define	IN_CLASSC_NSHIFT	8
(defconstant $IN_CLASSC_HOST 255)
; #define	IN_CLASSC_HOST		0x000000ff
; #define	IN_CLASSD(i)		(((u_int32_t)(i) & 0xf0000000) == 0xe0000000)
(defconstant $IN_CLASSD_NET 4026531840)
; #define	IN_CLASSD_NET		0xf0000000	/* These ones aren't really */
(defconstant $IN_CLASSD_NSHIFT 28)
; #define	IN_CLASSD_NSHIFT	28		/* net and host fields, but */
(defconstant $IN_CLASSD_HOST 268435455)
; #define	IN_CLASSD_HOST		0x0fffffff	/* routing needn't know.    */
; #define	IN_MULTICAST(i)		IN_CLASSD(i)
; #define	IN_EXPERIMENTAL(i)	(((u_int32_t)(i) & 0xf0000000) == 0xf0000000)
; #define	IN_BADCLASS(i)		(((u_int32_t)(i) & 0xf0000000) == 0xf0000000)
; #define	INADDR_ANY		(u_int32_t)0x00000000
; #define	INADDR_LOOPBACK		(u_int32_t)0x7f000001
; #define	INADDR_BROADCAST	(u_int32_t)0xffffffff	/* must be masked */
; #ifndef KERNEL
(defconstant $INADDR_NONE 4294967295)
; #define	INADDR_NONE		0xffffffff		/* -1 return */

; #endif

; #define	INADDR_UNSPEC_GROUP	(u_int32_t)0xe0000000	/* 224.0.0.0 */
; #define	INADDR_ALLHOSTS_GROUP	(u_int32_t)0xe0000001	/* 224.0.0.1 */
; #define	INADDR_ALLRTRS_GROUP	(u_int32_t)0xe0000002	/* 224.0.0.2 */
; #define	INADDR_MAX_LOCAL_GROUP	(u_int32_t)0xe00000ff	/* 224.0.0.255 */
; #ifdef __APPLE__
; #define IN_LINKLOCALNETNUM	(u_int32_t)0xA9FE0000 /* 169.254.0.0 */
; #define IN_LINKLOCAL(i)		(((u_int32_t)(i) & IN_CLASSB_NET) == IN_LINKLOCALNETNUM)

; #endif

(defconstant $IN_LOOPBACKNET 127)
; #define	IN_LOOPBACKNET		127			/* official! */
; 
;  * Socket address, internet style.
;  
(defrecord sockaddr_in
   (sin_len :UInt8)
   (sin_family :UInt8)
   (sin_port :UInt16)
   (sin_addr :IN_ADDR)
   (sin_zero (:array :character 8))
)
(defconstant $INET_ADDRSTRLEN 16)
; #define INET_ADDRSTRLEN                 16
; 
;  * Structure used to describe IP options.
;  * Used to store options internally, to pass them to a process,
;  * or to restore options retrieved earlier.
;  * The ip_dst is used for the first-hop gateway when using a source route
;  * (this gets put into the header proper).
;  
(defrecord ip_opts
   (ip_dst :IN_ADDR)
                                                ;  first hop, 0 w/o src rt 
   (ip_opts (:array :character 40))
                                                ;  actually variable in size 
)
; 
;  * Options for use with [gs]etsockopt at the IP level.
;  * First word of comment is data type; bool is stored in int.
;  
(defconstant $IP_OPTIONS 1)
; #define	IP_OPTIONS		1    /* buf/ip_opts; set/get IP options */
(defconstant $IP_HDRINCL 2)
; #define	IP_HDRINCL		2    /* int; header is included with data */
(defconstant $IP_TOS 3)
; #define	IP_TOS			3    /* int; IP type of service and preced. */
(defconstant $IP_TTL 4)
; #define	IP_TTL			4    /* int; IP time to live */
(defconstant $IP_RECVOPTS 5)
; #define	IP_RECVOPTS		5    /* bool; receive all IP opts w/dgram */
(defconstant $IP_RECVRETOPTS 6)
; #define	IP_RECVRETOPTS		6    /* bool; receive IP opts for response */
(defconstant $IP_RECVDSTADDR 7)
; #define	IP_RECVDSTADDR		7    /* bool; receive IP dst addr w/dgram */
(defconstant $IP_RETOPTS 8)
; #define	IP_RETOPTS		8    /* ip_opts; set/get IP options */
(defconstant $IP_MULTICAST_IF 9)
; #define	IP_MULTICAST_IF		9    /* u_char; set/get IP multicast i/f  */
(defconstant $IP_MULTICAST_TTL 10)
; #define	IP_MULTICAST_TTL	10   /* u_char; set/get IP multicast ttl */
(defconstant $IP_MULTICAST_LOOP 11)
; #define	IP_MULTICAST_LOOP	11   /* u_char; set/get IP multicast loopback */
(defconstant $IP_ADD_MEMBERSHIP 12)
; #define	IP_ADD_MEMBERSHIP	12   /* ip_mreq; add an IP group membership */
(defconstant $IP_DROP_MEMBERSHIP 13)
; #define	IP_DROP_MEMBERSHIP	13   /* ip_mreq; drop an IP group membership */
(defconstant $IP_MULTICAST_VIF 14)
; #define IP_MULTICAST_VIF	14   /* set/get IP mcast virt. iface */
(defconstant $IP_RSVP_ON 15)
; #define IP_RSVP_ON		15   /* enable RSVP in kernel */
(defconstant $IP_RSVP_OFF 16)
; #define IP_RSVP_OFF		16   /* disable RSVP in kernel */
(defconstant $IP_RSVP_VIF_ON 17)
; #define IP_RSVP_VIF_ON		17   /* set RSVP per-vif socket */
(defconstant $IP_RSVP_VIF_OFF 18)
; #define IP_RSVP_VIF_OFF		18   /* unset RSVP per-vif socket */
(defconstant $IP_PORTRANGE 19)
; #define IP_PORTRANGE		19   /* int; range to choose for unspec port */
(defconstant $IP_RECVIF 20)
; #define	IP_RECVIF		20   /* bool; receive reception if w/dgram */
;  for IPSEC 
(defconstant $IP_IPSEC_POLICY 21)
; #define	IP_IPSEC_POLICY		21   /* int; set/get security policy */
(defconstant $IP_FAITH 22)
; #define	IP_FAITH		22   /* bool; accept FAITH'ed connections */
; #ifdef __APPLE__
(defconstant $IP_STRIPHDR 23)
; #define IP_STRIPHDR      	23   /* bool: drop receive of raw IP header */

; #endif

(defconstant $IP_RECVTTL 24)
; #define IP_RECVTTL			24	/* bool; receive reception TTL w/dgram */
(defconstant $IP_FW_ADD 40)
; #define	IP_FW_ADD     		40   /* add a firewall rule to chain */
(defconstant $IP_FW_DEL 41)
; #define	IP_FW_DEL    		41   /* delete a firewall rule from chain */
(defconstant $IP_FW_FLUSH 42)
; #define	IP_FW_FLUSH   		42   /* flush firewall rule chain */
(defconstant $IP_FW_ZERO 43)
; #define	IP_FW_ZERO    		43   /* clear single/all firewall counter(s) */
(defconstant $IP_FW_GET 44)
; #define	IP_FW_GET     		44   /* get entire firewall rule chain */
(defconstant $IP_FW_RESETLOG 45)
; #define	IP_FW_RESETLOG		45   /* reset logging counters */
;  These older firewall socket option codes are maintained for backward compatibility. 
(defconstant $IP_OLD_FW_ADD 50)
; #define	IP_OLD_FW_ADD     	50   /* add a firewall rule to chain */
(defconstant $IP_OLD_FW_DEL 51)
; #define	IP_OLD_FW_DEL    	51   /* delete a firewall rule from chain */
(defconstant $IP_OLD_FW_FLUSH 52)
; #define	IP_OLD_FW_FLUSH   	52   /* flush firewall rule chain */
(defconstant $IP_OLD_FW_ZERO 53)
; #define	IP_OLD_FW_ZERO    	53   /* clear single/all firewall counter(s) */
(defconstant $IP_OLD_FW_GET 54)
; #define	IP_OLD_FW_GET     	54   /* get entire firewall rule chain */
(defconstant $IP_NAT__XXX 55)
; #define IP_NAT__XXX			55   /* set/get NAT opts XXX Deprecated, do not use */
(defconstant $IP_OLD_FW_RESETLOG 56)
; #define	IP_OLD_FW_RESETLOG	56   /* reset logging counters */
(defconstant $IP_DUMMYNET_CONFIGURE 60)
; #define	IP_DUMMYNET_CONFIGURE	60   /* add/configure a dummynet pipe */
(defconstant $IP_DUMMYNET_DEL 61)
; #define	IP_DUMMYNET_DEL		61   /* delete a dummynet pipe from chain */
(defconstant $IP_DUMMYNET_FLUSH 62)
; #define	IP_DUMMYNET_FLUSH	62   /* flush dummynet */
(defconstant $IP_DUMMYNET_GET 64)
; #define	IP_DUMMYNET_GET		64   /* get entire dummynet pipes */
; 
;  * Defaults and limits for options
;  
(defconstant $IP_DEFAULT_MULTICAST_TTL 1)
; #define	IP_DEFAULT_MULTICAST_TTL  1	/* normally limit m'casts to 1 hop  */
(defconstant $IP_DEFAULT_MULTICAST_LOOP 1)
; #define	IP_DEFAULT_MULTICAST_LOOP 1	/* normally hear sends if a member  */
(defconstant $IP_MAX_MEMBERSHIPS 20)
; #define	IP_MAX_MEMBERSHIPS	20	/* per socket */
; 
;  * Argument structure for IP_ADD_MEMBERSHIP and IP_DROP_MEMBERSHIP.
;  
(defrecord ip_mreq
   (imr_multiaddr :IN_ADDR)
                                                ;  IP multicast address of group 
   (imr_interface :IN_ADDR)
                                                ;  local IP address of interface 
)
; 
;  * Argument for IP_PORTRANGE:
;  * - which range to search when port is unspecified at bind() or connect()
;  
(defconstant $IP_PORTRANGE_DEFAULT 0)
; #define	IP_PORTRANGE_DEFAULT	0	/* default range */
(defconstant $IP_PORTRANGE_HIGH 1)
; #define	IP_PORTRANGE_HIGH	1	/* "high" - request firewall bypass */
(defconstant $IP_PORTRANGE_LOW 2)
; #define	IP_PORTRANGE_LOW	2	/* "low" - vouchsafe security */
; 
;  * Definitions for inet sysctl operations.
;  *
;  * Third level is protocol number.
;  * Fourth level is desired variable within that protocol.
;  
(defconstant $IPPROTO_MAXID 52)
; #define	IPPROTO_MAXID	(IPPROTO_AH + 1)	/* don't list to IPPROTO_MAX */
; #define	CTL_IPPROTO_NAMES { 	{ "ip", CTLTYPE_NODE }, 	{ "icmp", CTLTYPE_NODE }, 	{ "igmp", CTLTYPE_NODE }, 	{ "ggp", CTLTYPE_NODE }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ "tcp", CTLTYPE_NODE }, 	{ 0, 0 }, 	{ "egp", CTLTYPE_NODE }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ "pup", CTLTYPE_NODE }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ "udp", CTLTYPE_NODE }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ "idp", CTLTYPE_NODE }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ 0, 0 }, 	{ "ipsec", CTLTYPE_NODE }, }
; 
;  * Names for IP sysctl objects
;  
(defconstant $IPCTL_FORWARDING 1)
; #define	IPCTL_FORWARDING	1	/* act as router */
(defconstant $IPCTL_SENDREDIRECTS 2)
; #define	IPCTL_SENDREDIRECTS	2	/* may send redirects when forwarding */
(defconstant $IPCTL_DEFTTL 3)
; #define	IPCTL_DEFTTL		3	/* default TTL */
; #ifdef notyet
#| #|
#define IPCTL_DEFMTU		4	
#endif
|#
 |#
(defconstant $IPCTL_RTEXPIRE 5)
; #define IPCTL_RTEXPIRE		5	/* cloned route expiration time */
(defconstant $IPCTL_RTMINEXPIRE 6)
; #define IPCTL_RTMINEXPIRE	6	/* min value for expiration time */
(defconstant $IPCTL_RTMAXCACHE 7)
; #define IPCTL_RTMAXCACHE	7	/* trigger level for dynamic expire */
(defconstant $IPCTL_SOURCEROUTE 8)
; #define	IPCTL_SOURCEROUTE	8	/* may perform source routes */
(defconstant $IPCTL_DIRECTEDBROADCAST 9)
; #define	IPCTL_DIRECTEDBROADCAST	9	/* may re-broadcast received packets */
(defconstant $IPCTL_INTRQMAXLEN 10)
; #define IPCTL_INTRQMAXLEN	10	/* max length of netisr queue */
(defconstant $IPCTL_INTRQDROPS 11)
; #define	IPCTL_INTRQDROPS	11	/* number of netisr q drops */
(defconstant $IPCTL_STATS 12)
; #define	IPCTL_STATS		12	/* ipstat structure */
(defconstant $IPCTL_ACCEPTSOURCEROUTE 13)
; #define	IPCTL_ACCEPTSOURCEROUTE	13	/* may accept source routed packets */
(defconstant $IPCTL_FASTFORWARDING 14)
; #define	IPCTL_FASTFORWARDING	14	/* use fast IP forwarding code */
(defconstant $IPCTL_KEEPFAITH 15)
; #define	IPCTL_KEEPFAITH		15	/* FAITH IPv4->IPv6 translater ctl */
(defconstant $IPCTL_GIF_TTL 16)
; #define	IPCTL_GIF_TTL		16	/* default TTL for gif encap packet */
(defconstant $IPCTL_MAXID 17)
; #define	IPCTL_MAXID		17
; #define	IPCTL_NAMES { 	{ 0, 0 }, 	{ "forwarding", CTLTYPE_INT }, 	{ "redirect", CTLTYPE_INT }, 	{ "ttl", CTLTYPE_INT }, 	{ "mtu", CTLTYPE_INT }, 	{ "rtexpire", CTLTYPE_INT }, 	{ "rtminexpire", CTLTYPE_INT }, 	{ "rtmaxcache", CTLTYPE_INT }, 	{ "sourceroute", CTLTYPE_INT },  	{ "directed-broadcast", CTLTYPE_INT }, 	{ "intr-queue-maxlen", CTLTYPE_INT }, 	{ "intr-queue-drops", CTLTYPE_INT }, 	{ "stats", CTLTYPE_STRUCT }, 	{ "accept_sourceroute", CTLTYPE_INT }, 	{ "fastforwarding", CTLTYPE_INT }, 	{ "keepfaith", CTLTYPE_INT }, 	{ "gifttl", CTLTYPE_INT }, }
;  INET6 stuff 
; #define __KAME_NETINET_IN_H_INCLUDED_

(require-interface "netinet6/in6")
; #undef __KAME_NETINET_IN_H_INCLUDED_
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE
struct ifnet; struct mbuf;	

int	 in_broadcast __P((struct in_addr, struct ifnet *));
int	 in_canforward __P((struct in_addr));
int	 in_cksum __P((struct mbuf *, int));
int      in_cksum_skip __P((struct mbuf *, u_short, u_short));
u_short	 in_addword __P((u_short, u_short));
u_short  in_pseudo __P((u_int, u_int, u_int));
int	 in_localaddr __P((struct in_addr));
char 	*inet_ntoa __P((struct in_addr)); 
u_long	in_netof __P((struct in_addr));
#endif
#endif
|#
 |#
;  KERNEL 

; #endif


(provide-interface "in")