(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:route.h"
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
;  * Copyright (c) 1980, 1986, 1993
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
;  *	@(#)route.h	8.3 (Berkeley) 4/19/94
;  * $FreeBSD: src/sys/net/route.h,v 1.36.2.1 2000/08/16 06:14:23 jayanth Exp $
;  
; #ifndef _NET_ROUTE_H_
; #define _NET_ROUTE_H_

(require-interface "sys/appleapiopts")
; 
;  * Kernel resident routing tables.
;  *
;  * The routing tables are initialized when interface addresses
;  * are set by making entries for all directly connected interfaces.
;  
; 
;  * A route consists of a destination address and a reference
;  * to a routing entry.  These are often held by protocols
;  * in their control blocks, e.g. inpcb.
;  

; #if !defined(KERNEL) || defined(__APPLE_API_PRIVATE)
(defrecord route
   (ro_rt (:pointer :rtentry))
   (ro_dst :SOCKADDR)
   (reserved (:array :UInt32 2))
                                                ;  for future use if needed 
)
#| 
; #else
 |#

; #endif

; 
;  * These numbers are used by reliable protocols for determining
;  * retransmission behavior and are included in the routing structure.
;  
(defrecord rt_metrics
   (rmx_locks :UInt32)
                                                ;  Kernel must leave these values alone 
   (rmx_mtu :UInt32)
                                                ;  MTU for this path 
   (rmx_hopcount :UInt32)
                                                ;  max hops expected 
   (rmx_expire :UInt32)
                                                ;  lifetime for route, e.g. redirect 
   (rmx_recvpipe :UInt32)
                                                ;  inbound delay-bandwidth product 
   (rmx_sendpipe :UInt32)
                                                ;  outbound delay-bandwidth product 
   (rmx_ssthresh :UInt32)
                                                ;  outbound gateway buffer limit 
   (rmx_rtt :UInt32)
                                                ;  estimated round trip time 
   (rmx_rttvar :UInt32)
                                                ;  estimated rtt variance 
   (rmx_pksent :UInt32)
                                                ;  packets sent using this route 
   (rmx_filler (:array :UInt32 4))
                                                ;  will be used for T/TCP later 
)
; 
;  * rmx_rtt and rmx_rttvar are stored as microseconds;
;  * RTTTOPRHZ(rtt) converts to a value suitable for use
;  * by a protocol slowtimo counter.
;  
(defconstant $RTM_RTTUNIT 1000000)
; #define	RTM_RTTUNIT	1000000	/* units for rtt, rttvar, as units per sec */
; #define	RTTTOPRHZ(r)	((r) / (RTM_RTTUNIT / PR_SLOWHZ))
; 
;  * XXX kernel function pointer `rt_output' is visible to applications.
;  
; 
;  * We distinguish between routes to hosts and routes to networks,
;  * preferring the former if available.  For each route we infer
;  * the interface to use from the gateway address supplied when
;  * the route was entered.  Routes that forward packets through
;  * gateways are marked so that the output routines know to address the
;  * gateway rather than the ultimate destination.
;  
; #ifndef RNF_NORMAL

(require-interface "net/radix")

; #endif

; #ifdef __APPLE_API_UNSTABLE
#| #|
struct rtentry {
	struct	radix_node rt_nodes[2];	
#define rt_key(r)	((struct sockaddr *)((r)->rt_nodes->rn_key))
#define rt_mask(r)	((struct sockaddr *)((r)->rt_nodes->rn_mask))
	struct	sockaddr *rt_gateway;	
	int32_t	rt_refcnt;		
	u_long	rt_flags;		
	struct	ifnet *rt_ifp;		
        u_long  rt_dlt;			
	struct	ifaddr *rt_ifa;		
	struct	sockaddr *rt_genmask;	
	caddr_t	rt_llinfo;		
	struct	rt_metrics rt_rmx;	
	struct	rtentry *rt_gwroute;	
	int	(*rt_output) __P((struct ifnet *, struct mbuf *,
				  struct sockaddr *, struct rtentry *));
					
	struct	rtentry *rt_parent; 	
	u_long	generation_id;		
};
#endif
|#
 |#
;  __APPLE_API_UNSTABLE 
; 
;  * Following structure necessary for 4.3 compatibility;
;  * We should eventually move it to a compat file.
;  
(defrecord ortentry
   (rt_hash :UInt32)
                                                ;  to speed lookups 
   (rt_dst :SOCKADDR)
                                                ;  key 
   (rt_gateway :SOCKADDR)
                                                ;  value 
   (rt_flags :SInt16)
                                                ;  up/down?, host/net 
   (rt_refcnt :SInt16)
                                                ;  # held references 
   (rt_use :UInt32)
                                                ;  raw # packets forwarded 
   (rt_ifp (:pointer :ifnet))
                                                ;  the answer: interface to use 
)
; #define rt_use rt_rmx.rmx_pksent
(defconstant $RTF_UP 1)
; #define	RTF_UP		0x1		/* route usable */
(defconstant $RTF_GATEWAY 2)
; #define	RTF_GATEWAY	0x2		/* destination is a gateway */
(defconstant $RTF_HOST 4)
; #define	RTF_HOST	0x4		/* host entry (net otherwise) */
(defconstant $RTF_REJECT 8)
; #define	RTF_REJECT	0x8		/* host or net unreachable */
(defconstant $RTF_DYNAMIC 16)
; #define	RTF_DYNAMIC	0x10		/* created dynamically (by redirect) */
(defconstant $RTF_MODIFIED 32)
; #define	RTF_MODIFIED	0x20		/* modified dynamically (by redirect) */
(defconstant $RTF_DONE 64)
; #define RTF_DONE	0x40		/* message confirmed */
(defconstant $RTF_DELCLONE 128)
; #define RTF_DELCLONE	0x80		/* delete cloned route */
(defconstant $RTF_CLONING 256)
; #define RTF_CLONING	0x100		/* generate new routes on use */
(defconstant $RTF_XRESOLVE 512)
; #define RTF_XRESOLVE	0x200		/* external daemon resolves name */
(defconstant $RTF_LLINFO 1024)
; #define RTF_LLINFO	0x400		/* generated by link layer (e.g. ARP) */
(defconstant $RTF_STATIC 2048)
; #define RTF_STATIC	0x800		/* manually added */
(defconstant $RTF_BLACKHOLE 4096)
; #define RTF_BLACKHOLE	0x1000		/* just discard pkts (during updates) */
(defconstant $RTF_PROTO2 16384)
; #define RTF_PROTO2	0x4000		/* protocol specific routing flag */
(defconstant $RTF_PROTO1 32768)
; #define RTF_PROTO1	0x8000		/* protocol specific routing flag */
(defconstant $RTF_PRCLONING 65536)
; #define RTF_PRCLONING	0x10000		/* protocol requires cloning */
(defconstant $RTF_WASCLONED 131072)
; #define RTF_WASCLONED	0x20000		/* route generated through cloning */
(defconstant $RTF_PROTO3 262144)
; #define RTF_PROTO3	0x40000		/* protocol specific routing flag */
; 			0x80000		   unused 
(defconstant $RTF_PINNED 1048576)
; #define RTF_PINNED	0x100000	/* future use */
(defconstant $RTF_LOCAL 2097152)
; #define	RTF_LOCAL	0x200000 	/* route represents a local address */
(defconstant $RTF_BROADCAST 4194304)
; #define	RTF_BROADCAST	0x400000	/* route represents a bcast address */
(defconstant $RTF_MULTICAST 8388608)
; #define	RTF_MULTICAST	0x800000	/* route represents a mcast address */
;  0x1000000 and up unassigned 
; 
;  * Routing statistics.
;  
(defrecord rtstat
   (rts_badredirect :SInt16)
                                                ;  bogus redirect calls 
   (rts_dynamic :SInt16)
                                                ;  routes created by redirects 
   (rts_newgateway :SInt16)
                                                ;  routes modified by redirects 
   (rts_unreach :SInt16)
                                                ;  lookups which failed 
   (rts_wildcard :SInt16)
                                                ;  lookups satisfied by a wildcard 
)
; 
;  * Structures for routing messages.
;  
(defrecord rt_msghdr
   (rtm_msglen :UInt16)
                                                ;  to skip over non-understood messages 
   (rtm_version :UInt8)
                                                ;  future binary compatibility 
   (rtm_type :UInt8)
                                                ;  message type 
   (rtm_index :UInt16)
                                                ;  index for associated ifp 
   (rtm_flags :signed-long)
                                                ;  flags, incl. kern & message, e.g. DONE 
   (rtm_addrs :signed-long)
                                                ;  bitmask identifying sockaddrs in msg 
   (rtm_pid :SInt32)
                                                ;  identify sender 
   (rtm_seq :signed-long)
                                                ;  for sender to identify action 
   (rtm_errno :signed-long)
                                                ;  why failed 
   (rtm_use :signed-long)
                                                ;  from rtentry 
   (rtm_inits :UInt32)
                                                ;  which metrics we are initializing 
   (rtm_rmx :RT_METRICS)                        ;  metrics themselves 
)
(defconstant $RTM_VERSION 5)
; #define RTM_VERSION	5	/* Up the ante and ignore older versions */
; 
;  * Message types.
;  
(defconstant $RTM_ADD 1)
; #define RTM_ADD		0x1	/* Add Route */
(defconstant $RTM_DELETE 2)
; #define RTM_DELETE	0x2	/* Delete Route */
(defconstant $RTM_CHANGE 3)
; #define RTM_CHANGE	0x3	/* Change Metrics or flags */
(defconstant $RTM_GET 4)
; #define RTM_GET		0x4	/* Report Metrics */
(defconstant $RTM_LOSING 5)
; #define RTM_LOSING	0x5	/* Kernel Suspects Partitioning */
(defconstant $RTM_REDIRECT 6)
; #define RTM_REDIRECT	0x6	/* Told to use different route */
(defconstant $RTM_MISS 7)
; #define RTM_MISS	0x7	/* Lookup failed on this address */
(defconstant $RTM_LOCK 8)
; #define RTM_LOCK	0x8	/* fix specified metrics */
(defconstant $RTM_OLDADD 9)
; #define RTM_OLDADD	0x9	/* caused by SIOCADDRT */
(defconstant $RTM_OLDDEL 10)
; #define RTM_OLDDEL	0xa	/* caused by SIOCDELRT */
(defconstant $RTM_RESOLVE 11)
; #define RTM_RESOLVE	0xb	/* req to resolve dst to LL addr */
(defconstant $RTM_NEWADDR 12)
; #define RTM_NEWADDR	0xc	/* address being added to iface */
(defconstant $RTM_DELADDR 13)
; #define RTM_DELADDR	0xd	/* address being removed from iface */
(defconstant $RTM_IFINFO 14)
; #define RTM_IFINFO	0xe	/* iface going up/down etc. */
(defconstant $RTM_NEWMADDR 15)
; #define	RTM_NEWMADDR	0xf	/* mcast group membership being added to if */
(defconstant $RTM_DELMADDR 16)
; #define	RTM_DELMADDR	0x10	/* mcast group membership being deleted */
; #ifdef KERNEL_PRIVATE
#| #|
#define RTM_GET_SILENT	0x11
#endif
|#
 |#
; 
;  * Bitmask values for rtm_inits and rmx_locks.
;  
(defconstant $RTV_MTU 1)
; #define RTV_MTU		0x1	/* init or lock _mtu */
(defconstant $RTV_HOPCOUNT 2)
; #define RTV_HOPCOUNT	0x2	/* init or lock _hopcount */
(defconstant $RTV_EXPIRE 4)
; #define RTV_EXPIRE	0x4	/* init or lock _expire */
(defconstant $RTV_RPIPE 8)
; #define RTV_RPIPE	0x8	/* init or lock _recvpipe */
(defconstant $RTV_SPIPE 16)
; #define RTV_SPIPE	0x10	/* init or lock _sendpipe */
(defconstant $RTV_SSTHRESH 32)
; #define RTV_SSTHRESH	0x20	/* init or lock _ssthresh */
(defconstant $RTV_RTT 64)
; #define RTV_RTT		0x40	/* init or lock _rtt */
(defconstant $RTV_RTTVAR 128)
; #define RTV_RTTVAR	0x80	/* init or lock _rttvar */
; 
;  * Bitmask values for rtm_addrs.
;  
(defconstant $RTA_DST 1)
; #define RTA_DST		0x1	/* destination sockaddr present */
(defconstant $RTA_GATEWAY 2)
; #define RTA_GATEWAY	0x2	/* gateway sockaddr present */
(defconstant $RTA_NETMASK 4)
; #define RTA_NETMASK	0x4	/* netmask sockaddr present */
(defconstant $RTA_GENMASK 8)
; #define RTA_GENMASK	0x8	/* cloning mask sockaddr present */
(defconstant $RTA_IFP 16)
; #define RTA_IFP		0x10	/* interface name sockaddr present */
(defconstant $RTA_IFA 32)
; #define RTA_IFA		0x20	/* interface addr sockaddr present */
(defconstant $RTA_AUTHOR 64)
; #define RTA_AUTHOR	0x40	/* sockaddr for author of redirect */
(defconstant $RTA_BRD 128)
; #define RTA_BRD		0x80	/* for NEWADDR, broadcast or p-p dest addr */
; 
;  * Index offsets for sockaddr array for alternate internal encoding.
;  
(defconstant $RTAX_DST 0)
; #define RTAX_DST	0	/* destination sockaddr present */
(defconstant $RTAX_GATEWAY 1)
; #define RTAX_GATEWAY	1	/* gateway sockaddr present */
(defconstant $RTAX_NETMASK 2)
; #define RTAX_NETMASK	2	/* netmask sockaddr present */
(defconstant $RTAX_GENMASK 3)
; #define RTAX_GENMASK	3	/* cloning mask sockaddr present */
(defconstant $RTAX_IFP 4)
; #define RTAX_IFP	4	/* interface name sockaddr present */
(defconstant $RTAX_IFA 5)
; #define RTAX_IFA	5	/* interface addr sockaddr present */
(defconstant $RTAX_AUTHOR 6)
; #define RTAX_AUTHOR	6	/* sockaddr for author of redirect */
(defconstant $RTAX_BRD 7)
; #define RTAX_BRD	7	/* for NEWADDR, broadcast or p-p dest addr */
(defconstant $RTAX_MAX 8)
; #define RTAX_MAX	8	/* size of array to allocate */
(defrecord rt_addrinfo
   (rti_addrs :signed-long)
   (rti_info (:array :pointer 8))
)
(defrecord route_cb
   (ip_count :signed-long)
   (ip6_count :signed-long)
   (ipx_count :signed-long)
   (ns_count :signed-long)
   (iso_count :signed-long)
   (any_count :signed-long)
)
; #ifdef KERNEL
#| #|
#ifndef__APPLE__
#define RTFREE(rt) \
	do { \
		if ((rt)->rt_refcnt <= 1) \
			rtfree(rt); \
		else \
			(rt)->rt_refcnt--; \
	} while (0)
#else#define RTFREE(rt)	rtfree(rt)
#endif
#ifdef__APPLE_API_PRIVATE
extern struct route_cb route_cb;
extern struct radix_node_head *rt_tables[AF_MAX+1];

struct ifmultiaddr;
struct proc;

void	 route_init __P((void));
void	 rt_ifmsg __P((struct ifnet *));
void	 rt_missmsg __P((int, struct rt_addrinfo *, int, int));
void	 rt_newaddrmsg __P((int, struct ifaddr *, int, struct rtentry *));
void	 rt_newmaddrmsg __P((int, struct ifmultiaddr *));
int	 rt_setgate __P((struct rtentry *,
	    struct sockaddr *, struct sockaddr *));
void	 rtalloc __P((struct route *));
void	 rtalloc_ign __P((struct route *, u_long));
struct rtentry *
	 rtalloc1 __P((struct sockaddr *, int, u_long));
void	rtfree __P((struct rtentry *));
void	rtref __P((struct rtentry *));

void	rtunref __P((struct rtentry *));
void	rtsetifa __P((struct rtentry *, struct ifaddr *));
int	 rtinit __P((struct ifaddr *, int, int));
int	 rtioctl __P((int, caddr_t, struct proc *));
void	 rtredirect __P((struct sockaddr *, struct sockaddr *,
	    struct sockaddr *, int, struct sockaddr *, struct rtentry **));
int	 rtrequest __P((int, struct sockaddr *,
	    struct sockaddr *, struct sockaddr *, int, struct rtentry **));
#endif
#endif
|#
 |#

; #endif


(provide-interface "route")