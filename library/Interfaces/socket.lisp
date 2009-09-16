(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:socket.h"
; at Sunday July 2,2006 7:27:06 pm.
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
;  Copyright (c) 1998, 1999 Apple Computer, Inc. All Rights Reserved 
;  Copyright (c) 1995 NeXT Computer, Inc. All Rights Reserved 
; 
;  * Copyright (c) 1982, 1985, 1986, 1988, 1993, 1994
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
;  *	@(#)socket.h	8.4 (Berkeley) 2/21/94
;  * $FreeBSD: src/sys/sys/socket.h,v 1.39.2.7 2001/07/03 11:02:01 ume Exp $
;  
; #ifndef _SYS_SOCKET_H_
; #define	_SYS_SOCKET_H_
; #ifndef __APPLE__
#| #|
#include <machineansi.h>
#endif
|#
 |#
; #define _NO_NAMESPACE_POLLUTION

(require-interface "machine/param")
; #undef _NO_NAMESPACE_POLLUTION
; 
;  * Definitions related to sockets: types, address families, options.
;  
; 
;  * Data types.
;  

(def-mactype :sa_family_t (find-mactype ':UInt8))
; #ifdef	_BSD_SOCKLEN_T_

(def-mactype :socklen_t (find-mactype ':SInt32))
; #undef	_BSD_SOCKLEN_T_

; #endif

; 
;  * Types
;  
(defconstant $SOCK_STREAM 1)
; #define	SOCK_STREAM	1		/* stream socket */
(defconstant $SOCK_DGRAM 2)
; #define	SOCK_DGRAM	2		/* datagram socket */
(defconstant $SOCK_RAW 3)
; #define	SOCK_RAW	3		/* raw-protocol interface */
(defconstant $SOCK_RDM 4)
; #define	SOCK_RDM	4		/* reliably-delivered message */
(defconstant $SOCK_SEQPACKET 5)
; #define	SOCK_SEQPACKET	5		/* sequenced packet stream */
; 
;  * Option flags per-socket.
;  
(defconstant $SO_DEBUG 1)
; #define	SO_DEBUG	0x0001		/* turn on debugging info recording */
(defconstant $SO_ACCEPTCONN 2)
; #define	SO_ACCEPTCONN	0x0002		/* socket has had listen() */
(defconstant $SO_REUSEADDR 4)
; #define	SO_REUSEADDR	0x0004		/* allow local address reuse */
(defconstant $SO_KEEPALIVE 8)
; #define	SO_KEEPALIVE	0x0008		/* keep connections alive */
(defconstant $SO_DONTROUTE 16)
; #define	SO_DONTROUTE	0x0010		/* just use interface addresses */
(defconstant $SO_BROADCAST 32)
; #define	SO_BROADCAST	0x0020		/* permit sending of broadcast msgs */
(defconstant $SO_USELOOPBACK 64)
; #define	SO_USELOOPBACK	0x0040		/* bypass hardware when possible */
(defconstant $SO_LINGER 128)
; #define	SO_LINGER	0x0080		/* linger on close if data present */
(defconstant $SO_OOBINLINE 256)
; #define	SO_OOBINLINE	0x0100		/* leave received OOB data in line */
(defconstant $SO_REUSEPORT 512)
; #define	SO_REUSEPORT	0x0200		/* allow local address & port reuse */
(defconstant $SO_TIMESTAMP 1024)
; #define	SO_TIMESTAMP	0x0400		/* timestamp received dgram traffic */
; #ifndef __APPLE__
#| #|
#define SO_ACCEPTFILTER	0x1000		
|#
 |#

; #else
(defconstant $SO_DONTTRUNC 8192)
; #define SO_DONTTRUNC	0x2000		/* APPLE: Retain unread data */
;   (ATOMIC proto) 
(defconstant $SO_WANTMORE 16384)
; #define SO_WANTMORE		0x4000		/* APPLE: Give hint when more data ready */
(defconstant $SO_WANTOOBFLAG 32768)
; #define SO_WANTOOBFLAG	0x8000		/* APPLE: Want OOB in MSG_FLAG on receive */

; #endif

; 
;  * Additional options, not kept in so_options.
;  
(defconstant $SO_SNDBUF 4097)
; #define SO_SNDBUF	0x1001		/* send buffer size */
(defconstant $SO_RCVBUF 4098)
; #define SO_RCVBUF	0x1002		/* receive buffer size */
(defconstant $SO_SNDLOWAT 4099)
; #define SO_SNDLOWAT	0x1003		/* send low-water mark */
(defconstant $SO_RCVLOWAT 4100)
; #define SO_RCVLOWAT	0x1004		/* receive low-water mark */
(defconstant $SO_SNDTIMEO 4101)
; #define SO_SNDTIMEO	0x1005		/* send timeout */
(defconstant $SO_RCVTIMEO 4102)
; #define SO_RCVTIMEO	0x1006		/* receive timeout */
(defconstant $SO_ERROR 4103)
; #define	SO_ERROR	0x1007		/* get error status and clear */
(defconstant $SO_TYPE 4104)
; #define	SO_TYPE		0x1008		/* get socket type */
; efine	SO_PRIVSTATE	0x1009		   get/deny privileged state 
; #ifdef __APPLE__
(defconstant $SO_NREAD 4128)
; #define SO_NREAD	0x1020		/* APPLE: get 1st-packet byte count */
(defconstant $SO_NKE 4129)
; #define SO_NKE		0x1021		/* APPLE: Install socket-level NKE */
(defconstant $SO_NOSIGPIPE 4130)
; #define SO_NOSIGPIPE	0x1022		/* APPLE: No SIGPIPE on EPIPE */
(defconstant $SO_NOADDRERR 4131)
; #define SO_NOADDRERR	0x1023		/* APPLE: Returns EADDRNOTAVAIL when src is not available anymore */

; #endif

; 
;  * Structure used for manipulating linger option.
;  
(defrecord linger
   (l_onoff :signed-long)
                                                ;  option on/off 
   (l_linger :signed-long)
                                                ;  linger time 
)
; #ifndef __APPLE__
#| #|
struct	accept_filter_arg {
	char	af_name[16];
	char	af_arg[256-16];
};
#endif
|#
 |#
; 
;  * Level number for (get/set)sockopt() to apply to socket itself.
;  
(defconstant $SOL_SOCKET 65535)
; #define	SOL_SOCKET	0xffff		/* options for socket level */
; 
;  * Address families.
;  
(defconstant $AF_UNSPEC 0)
; #define	AF_UNSPEC	0		/* unspecified */
(defconstant $AF_LOCAL 1)
; #define	AF_LOCAL	1		/* local to host (pipes) */
; #define	AF_UNIX		AF_LOCAL	/* backward compatibility */
(defconstant $AF_INET 2)
; #define	AF_INET		2		/* internetwork: UDP, TCP, etc. */
(defconstant $AF_IMPLINK 3)
; #define	AF_IMPLINK	3		/* arpanet imp addresses */
(defconstant $AF_PUP 4)
; #define	AF_PUP		4		/* pup protocols: e.g. BSP */
(defconstant $AF_CHAOS 5)
; #define	AF_CHAOS	5		/* mit CHAOS protocols */
(defconstant $AF_NS 6)
; #define	AF_NS		6		/* XEROX NS protocols */
(defconstant $AF_ISO 7)
; #define	AF_ISO		7		/* ISO protocols */
; #define	AF_OSI		AF_ISO
(defconstant $AF_ECMA 8)
; #define	AF_ECMA		8		/* European computer manufacturers */
(defconstant $AF_DATAKIT 9)
; #define	AF_DATAKIT	9		/* datakit protocols */
(defconstant $AF_CCITT 10)
; #define	AF_CCITT	10		/* CCITT protocols, X.25 etc */
(defconstant $AF_SNA 11)
; #define	AF_SNA		11		/* IBM SNA */
(defconstant $AF_DECnet 12)
; #define AF_DECnet	12		/* DECnet */
(defconstant $AF_DLI 13)
; #define AF_DLI		13		/* DEC Direct data link interface */
(defconstant $AF_LAT 14)
; #define AF_LAT		14		/* LAT */
(defconstant $AF_HYLINK 15)
; #define	AF_HYLINK	15		/* NSC Hyperchannel */
(defconstant $AF_APPLETALK 16)
; #define	AF_APPLETALK	16		/* Apple Talk */
(defconstant $AF_ROUTE 17)
; #define	AF_ROUTE	17		/* Internal Routing Protocol */
(defconstant $AF_LINK 18)
; #define	AF_LINK		18		/* Link layer interface */
(defconstant $pseudo_AF_XTP 19)
; #define	pseudo_AF_XTP	19		/* eXpress Transfer Protocol (no AF) */
(defconstant $AF_COIP 20)
; #define	AF_COIP		20		/* connection-oriented IP, aka ST II */
(defconstant $AF_CNT 21)
; #define	AF_CNT		21		/* Computer Network Technology */
(defconstant $pseudo_AF_RTIP 22)
; #define pseudo_AF_RTIP	22		/* Help Identify RTIP packets */
(defconstant $AF_IPX 23)
; #define	AF_IPX		23		/* Novell Internet Protocol */
(defconstant $AF_SIP 24)
; #define	AF_SIP		24		/* Simple Internet Protocol */
(defconstant $pseudo_AF_PIP 25)
; #define pseudo_AF_PIP	25		/* Help Identify PIP packets */
; #ifdef __APPLE__
; define pseudo_AF_BLUE	26	   Identify packets for Blue Box - Not used 
(defconstant $AF_NDRV 27)
; #define AF_NDRV		27		/* Network Driver 'raw' access */

; #endif

(defconstant $AF_ISDN 28)
; #define	AF_ISDN		28		/* Integrated Services Digital Network*/
; #define	AF_E164		AF_ISDN		/* CCITT E.164 recommendation */
(defconstant $pseudo_AF_KEY 29)
; #define	pseudo_AF_KEY	29		/* Internal key-management function */
(defconstant $AF_INET6 30)
; #define	AF_INET6	30		/* IPv6 */
(defconstant $AF_NATM 31)
; #define	AF_NATM		31		/* native ATM access */
; #ifdef __APPLE__
(defconstant $AF_SYSTEM 32)
; #define AF_SYSTEM	32		/* Kernel event messages */
(defconstant $AF_NETBIOS 33)
; #define AF_NETBIOS	33		/* NetBIOS */
(defconstant $AF_PPP 34)
; #define AF_PPP		34		/* PPP communication protocol */
#| 
; #else
; #define	AF_ATM		30		/* ATM */
 |#

; #endif

(defconstant $pseudo_AF_HDRCMPLT 35)
; #define pseudo_AF_HDRCMPLT 35		/* Used by BPF to not rewrite headers
; #ifndef __APPLE__
#| #|
#define AF_NETGRAPH	32		
#endif
|#
 |#
(defconstant $AF_MAX 36)
; #define	AF_MAX		36
; 
;  * Structure used by kernel to store most
;  * addresses.
;  
(defrecord sockaddr
   (sa_len :UInt8)
                                                ;  total length 
   (sa_family :UInt8)
                                                ;  address family 
   (sa_data (:array :character 14))
                                                ;  actually longer; address value 
)
(defconstant $SOCK_MAXADDRLEN 255)
; #define	SOCK_MAXADDRLEN	255		/* longest possible addresses */
; 
;  * Structure used by kernel to pass protocol
;  * information in raw sockets.
;  
(defrecord sockproto
   (sp_family :UInt16)
                                                ;  address family 
   (sp_protocol :UInt16)
                                                ;  protocol 
)
; 
;  * RFC 2553: protocol-independent placeholder for socket addresses
;  
(defconstant $_SS_MAXSIZE 128)
; #define	_SS_MAXSIZE	128
(defconstant $_SS_ALIGNSIZE 8)
; #define	_SS_ALIGNSIZE	(sizeof(int64_t))
(defconstant $_SS_PAD1SIZE 6)
; #define	_SS_PAD1SIZE	(_SS_ALIGNSIZE - sizeof(u_char) - sizeof(sa_family_t))
(defconstant $_SS_PAD2SIZE 112)
; #define	_SS_PAD2SIZE	(_SS_MAXSIZE - sizeof(u_char) - sizeof(sa_family_t) - 				_SS_PAD1SIZE - _SS_ALIGNSIZE)
(defrecord sockaddr_storage
   (ss_len :UInt8)
                                                ;  address length 
   (ss_family :UInt8)
                                                ;  address family 
   (__ss_pad1 (:array :character 6))
   (__ss_align :int64_t)
                                                ;  force desired structure storage alignment 
   (__ss_pad2 (:array :character 112))
)
; 
;  * Protocol families, same as address families for now.
;  
; #define	PF_UNSPEC	AF_UNSPEC
; #define	PF_LOCAL	AF_LOCAL
; #define	PF_UNIX		PF_LOCAL	/* backward compatibility */
; #define	PF_INET		AF_INET
; #define	PF_IMPLINK	AF_IMPLINK
; #define	PF_PUP		AF_PUP
; #define	PF_CHAOS	AF_CHAOS
; #define	PF_NS		AF_NS
; #define	PF_ISO		AF_ISO
; #define	PF_OSI		AF_ISO
; #define	PF_ECMA		AF_ECMA
; #define	PF_DATAKIT	AF_DATAKIT
; #define	PF_CCITT	AF_CCITT
; #define	PF_SNA		AF_SNA
; #define PF_DECnet	AF_DECnet
; #define PF_DLI		AF_DLI
; #define PF_LAT		AF_LAT
; #define	PF_HYLINK	AF_HYLINK
; #define	PF_APPLETALK	AF_APPLETALK
; #define	PF_ROUTE	AF_ROUTE
; #define	PF_LINK		AF_LINK
; #define	PF_XTP		pseudo_AF_XTP	/* really just proto family, no AF */
; #define	PF_COIP		AF_COIP
; #define	PF_CNT		AF_CNT
; #define	PF_SIP		AF_SIP
; #define	PF_IPX		AF_IPX		/* same format as AF_NS */
; #define PF_RTIP		pseudo_AF_RTIP	/* same format as AF_INET */
; #define PF_PIP		pseudo_AF_PIP
; #ifdef __APPLE__
; #define PF_NDRV		AF_NDRV

; #endif

; #define	PF_ISDN		AF_ISDN
; #define	PF_KEY		pseudo_AF_KEY
; #define	PF_INET6	AF_INET6
; #define	PF_NATM		AF_NATM
; #ifdef __APPLE__
; #define PF_SYSTEM	AF_SYSTEM
; #define PF_NETBIOS	AF_NETBIOS
; #define PF_PPP		AF_PPP
#| 
; #else
; #define	PF_ATM		AF_ATM
; #define	PF_NETGRAPH	AF_NETGRAPH
 |#

; #endif

; #define	PF_MAX		AF_MAX
; 
;  * Definitions for network related sysctl, CTL_NET.
;  *
;  * Second level is protocol family.
;  * Third level is protocol number.
;  *
;  * Further levels are defined by the individual families below.
;  
; #define NET_MAXID	AF_MAX
; #define CTL_NET_NAMES { 	{ 0, 0 }, 	{ "local", CTLTYPE_NODE }, 	{ "inet", CTLTYPE_NODE }, 	{ "implink", CTLTYPE_NODE }, 	{ "pup", CTLTYPE_NODE }, 	{ "chaos", CTLTYPE_NODE }, 	{ "xerox_ns", CTLTYPE_NODE }, 	{ "iso", CTLTYPE_NODE }, 	{ "emca", CTLTYPE_NODE }, 	{ "datakit", CTLTYPE_NODE }, 	{ "ccitt", CTLTYPE_NODE }, 	{ "ibm_sna", CTLTYPE_NODE }, 	{ "decnet", CTLTYPE_NODE }, 	{ "dec_dli", CTLTYPE_NODE }, 	{ "lat", CTLTYPE_NODE }, 	{ "hylink", CTLTYPE_NODE }, 	{ "appletalk", CTLTYPE_NODE }, 	{ "route", CTLTYPE_NODE }, 	{ "link_layer", CTLTYPE_NODE }, 	{ "xtp", CTLTYPE_NODE }, 	{ "coip", CTLTYPE_NODE }, 	{ "cnt", CTLTYPE_NODE }, 	{ "rtip", CTLTYPE_NODE }, 	{ "ipx", CTLTYPE_NODE }, 	{ "sip", CTLTYPE_NODE }, 	{ "pip", CTLTYPE_NODE }, 	{ 0, 0 }, 	{ "ndrv", CTLTYPE_NODE }, 	{ "isdn", CTLTYPE_NODE }, 	{ "key", CTLTYPE_NODE }, 	{ "inet6", CTLTYPE_NODE }, 	{ "natm", CTLTYPE_NODE }, 	{ "sys", CTLTYPE_NODE }, 	{ "netbios", CTLTYPE_NODE }, 	{ "ppp", CTLTYPE_NODE }, 	{ "hdrcomplete", CTLTYPE_NODE }, }
; 
;  * PF_ROUTE - Routing table
;  *
;  * Three additional levels are defined:
;  *	Fourth: address family, 0 is wildcard
;  *	Fifth: type of info, defined below
;  *	Sixth: flag(s) to mask with for NET_RT_FLAGS
;  
(defconstant $NET_RT_DUMP 1)
; #define NET_RT_DUMP	1		/* dump; may limit to a.f. */
(defconstant $NET_RT_FLAGS 2)
; #define NET_RT_FLAGS	2		/* by flags, e.g. RESOLVING */
(defconstant $NET_RT_IFLIST 3)
; #define NET_RT_IFLIST	3		/* survey interface list */
(defconstant $NET_RT_MAXID 4)
; #define	NET_RT_MAXID	4
; #define CTL_NET_RT_NAMES { 	{ 0, 0 }, 	{ "dump", CTLTYPE_STRUCT }, 	{ "flags", CTLTYPE_STRUCT }, 	{ "iflist", CTLTYPE_STRUCT }, }
; 
;  * Maximum queue length specifiable by listen.
;  
(defconstant $SOMAXCONN 128)
; #define	SOMAXCONN	128
; 
;  * Message header for recvmsg and sendmsg calls.
;  * Used value-result for recvmsg, value only for sendmsg.
;  
(defrecord msghdr
   (msg_name (:pointer :character))
                                                ;  optional address 
   (msg_namelen :SInt32)
                                                ;  size of address 
   (msg_iov (:pointer :IOVEC))
                                                ;  scatter/gather array 
   (msg_iovlen :UInt32)
                                                ;  # elements in msg_iov 
   (msg_control (:pointer :character))
                                                ;  ancillary data, see below 
   (msg_controllen :SInt32)
                                                ;  ancillary data buffer len 
   (msg_flags :signed-long)
                                                ;  flags on received message 
)
(defconstant $MSG_OOB 1)
; #define	MSG_OOB		0x1		/* process out-of-band data */
(defconstant $MSG_PEEK 2)
; #define	MSG_PEEK	0x2		/* peek at incoming message */
(defconstant $MSG_DONTROUTE 4)
; #define	MSG_DONTROUTE	0x4		/* send without using routing tables */
(defconstant $MSG_EOR 8)
; #define	MSG_EOR		0x8		/* data completes record */
(defconstant $MSG_TRUNC 16)
; #define	MSG_TRUNC	0x10		/* data discarded before delivery */
(defconstant $MSG_CTRUNC 32)
; #define	MSG_CTRUNC	0x20		/* control data lost before delivery */
(defconstant $MSG_WAITALL 64)
; #define	MSG_WAITALL	0x40		/* wait for full request or error */
(defconstant $MSG_DONTWAIT 128)
; #define	MSG_DONTWAIT	0x80		/* this message should be nonblocking */
(defconstant $MSG_EOF 256)
; #define	MSG_EOF		0x100		/* data completes connection */
; #ifdef __APPLE__
(defconstant $MSG_WAITSTREAM 512)
; #define MSG_WAITSTREAM  0x200           /* wait up to full request.. may return partial */
(defconstant $MSG_FLUSH 1024)
; #define MSG_FLUSH	0x400		/* Start of 'hold' seq; dump so_temp */
(defconstant $MSG_HOLD 2048)
; #define MSG_HOLD	0x800		/* Hold frag in so_temp */
(defconstant $MSG_SEND 4096)
; #define MSG_SEND	0x1000		/* Send the packet in so_temp */
(defconstant $MSG_HAVEMORE 8192)
; #define MSG_HAVEMORE	0x2000		/* Data ready to be read */
(defconstant $MSG_RCVMORE 16384)
; #define MSG_RCVMORE	0x4000		/* Data remains in current pkt */

; #endif

(defconstant $MSG_COMPAT 32768)
; #define MSG_COMPAT      0x8000		/* used in sendit() */
; 
;  * Header for ancillary data objects in msg_control buffer.
;  * Used for additional information with/about a datagram
;  * not expressible by flags.  The format is a sequence
;  * of message elements headed by cmsghdr structures.
;  
(defrecord cmsghdr
   (cmsg_len :SInt32)
                                                ;  data byte count, including hdr 
   (cmsg_level :signed-long)
                                                ;  originating protocol 
   (cmsg_type :signed-long)
                                                ;  protocol-specific type 
                                                ;  followed by	u_char  cmsg_data[]; 
)
; #ifndef __APPLE__
#| #|

#define CMGROUP_MAX 16


struct cmsgcred {
	pid_t	cmcred_pid;		
	uid_t	cmcred_uid;		
	uid_t	cmcred_euid;		
	gid_t	cmcred_gid;		
	short	cmcred_ngroups;		
	gid_t	cmcred_groups[CMGROUP_MAX];	
};
#endif
|#
 |#
;  given pointer to struct cmsghdr, return pointer to data 
; #define	CMSG_DATA(cmsg)		((u_char *)(cmsg) + 				 ALIGN(sizeof(struct cmsghdr)))
;  given pointer to struct cmsghdr, return pointer to next cmsghdr 
; #define	CMSG_NXTHDR(mhdr, cmsg)		(((caddr_t)(cmsg) + ALIGN((cmsg)->cmsg_len) + 	  ALIGN(sizeof(struct cmsghdr)) > 	    (caddr_t)(mhdr)->msg_control + (mhdr)->msg_controllen) ? 	    (struct cmsghdr *)NULL : 	    (struct cmsghdr *)((caddr_t)(cmsg) + ALIGN((cmsg)->cmsg_len)))
; #define	CMSG_FIRSTHDR(mhdr)	((struct cmsghdr *)(mhdr)->msg_control)
;  RFC 2292 additions 
; #define	CMSG_SPACE(l)		(ALIGN(sizeof(struct cmsghdr)) + ALIGN(l))
; #define	CMSG_LEN(l)		(ALIGN(sizeof(struct cmsghdr)) + (l))
; #ifdef KERNEL
#| #|
#define CMSG_ALIGN(n)	ALIGN(n)
#endif
|#
 |#
;  "Socket"-level control message types: 
(defconstant $SCM_RIGHTS 1)
; #define	SCM_RIGHTS	0x01		/* access rights (array of int) */
(defconstant $SCM_TIMESTAMP 2)
; #define	SCM_TIMESTAMP	0x02		/* timestamp (struct timeval) */
(defconstant $SCM_CREDS 3)
; #define	SCM_CREDS	0x03		/* process creds (struct cmsgcred) */
; 
;  * 4.3 compat sockaddr, move to compat file later
;  
(defrecord osockaddr
   (sa_family :UInt16)
                                                ;  address family 
   (sa_data (:array :character 14))
                                                ;  up to 14 bytes of direct address 
)
; 
;  * 4.3-compat message header (move to compat file later).
;  
(defrecord omsghdr
   (msg_name (:pointer :character))
                                                ;  optional address 
   (msg_namelen :signed-long)
                                                ;  size of address 
   (msg_iov (:pointer :IOVEC))
                                                ;  scatter/gather array 
   (msg_iovlen :signed-long)
                                                ;  # elements in msg_iov 
   (msg_accrights (:pointer :character))
                                                ;  access rights sent/received 
   (msg_accrightslen :signed-long)
)
; 
;  * howto arguments for shutdown(2), specified by Posix.1g.
;  
(defconstant $SHUT_RD 0)
; #define	SHUT_RD		0		/* shut down the reading side */
(defconstant $SHUT_WR 1)
; #define	SHUT_WR		1		/* shut down the writing side */
(defconstant $SHUT_RDWR 2)
; #define	SHUT_RDWR	2		/* shut down both sides */

; #if SENDFILE
#| 
; 
;  * sendfile(2) header/trailer struct
;  
(defrecord sf_hdtr
   (headers (:pointer :IOVEC))
                                                ;  pointer to an array of header struct iovec's 
   (hdr_cnt :signed-long)
                                                ;  number of header iovec's 
   (trailers (:pointer :IOVEC))
                                                ;  pointer to an array of trailer struct iovec's 
   (trl_cnt :signed-long)
                                                ;  number of trailer iovec's 
)
 |#

; #endif

; #ifndef	KERNEL

(require-interface "sys/cdefs")
#|
 confused about __P #\( #\( int #\, struct sockaddr * #\, socklen_t * #\) #\)
|#
#|
 confused about __P #\( #\( int #\, const struct sockaddr * #\, socklen_t #\) #\)
|#
#|
 confused about __P #\( #\( int #\, const struct sockaddr * #\, socklen_t #\) #\)
|#
#|
 confused about __P #\( #\( int #\, struct sockaddr * #\, socklen_t * #\) #\)
|#
#|
 confused about __P #\( #\( int #\, struct sockaddr * #\, socklen_t * #\) #\)
|#
#|
 confused about __P #\( #\( int #\, int #\, int #\, void * #\, int * #\) #\)
|#
#|
 confused about __P #\( #\( int #\, int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, void * #\, size_t #\, int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, void * #\, size_t #\, int #\, struct sockaddr * #\, socklen_t * #\) #\)
|#
#|
 confused about __P #\( #\( int #\, struct msghdr * #\, int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, const void * #\, size_t #\, int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, const void * #\, size_t #\, int #\, const struct sockaddr * #\, socklen_t #\) #\)
|#
#|
 confused about __P #\( #\( int #\, const struct msghdr * #\, int #\) #\)
|#

; #if SENDFILE
#| 
 |#

; #endif

#|
 confused about __P #\( #\( int #\, int #\, int #\, const void * #\, socklen_t #\) #\)
|#
#|
 confused about __P #\( #\( int #\, int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, int #\, int #\) #\)
|#
#|
 confused about __P #\( #\( int #\, int #\, int #\, int * #\) #\)
|#
#|
 confused about __P #\( #\( int #\, struct sockaddr * #\) #\)
|#

; #endif /* !KERNEL */


; #endif /* !_SYS_SOCKET_H_ */


(provide-interface "socket")