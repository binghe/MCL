(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:if_var.h"
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
;  * Copyright (c) 1982, 1986, 1989, 1993
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
;  *	From: @(#)if.h	8.1 (Berkeley) 6/10/93
;  * $FreeBSD: src/sys/net/if_var.h,v 1.18.2.7 2001/07/24 19:10:18 brooks Exp $
;  
; #ifndef	_NET_IF_VAR_H_
; #define	_NET_IF_VAR_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE__
(defconstant $APPLE_IF_FAM_LOOPBACK 1)
; #define APPLE_IF_FAM_LOOPBACK  1
(defconstant $APPLE_IF_FAM_ETHERNET 2)
; #define APPLE_IF_FAM_ETHERNET  2
(defconstant $APPLE_IF_FAM_SLIP 3)
; #define APPLE_IF_FAM_SLIP      3
(defconstant $APPLE_IF_FAM_TUN 4)
; #define APPLE_IF_FAM_TUN       4
(defconstant $APPLE_IF_FAM_VLAN 5)
; #define APPLE_IF_FAM_VLAN      5
(defconstant $APPLE_IF_FAM_PPP 6)
; #define APPLE_IF_FAM_PPP       6
(defconstant $APPLE_IF_FAM_PVC 7)
; #define APPLE_IF_FAM_PVC       7
(defconstant $APPLE_IF_FAM_DISC 8)
; #define APPLE_IF_FAM_DISC      8
(defconstant $APPLE_IF_FAM_MDECAP 9)
; #define APPLE_IF_FAM_MDECAP    9
(defconstant $APPLE_IF_FAM_GIF 10)
; #define APPLE_IF_FAM_GIF       10
(defconstant $APPLE_IF_FAM_FAITH 11)
; #define APPLE_IF_FAM_FAITH     11
(defconstant $APPLE_IF_FAM_STF 12)
; #define APPLE_IF_FAM_STF       12
(defconstant $APPLE_IF_FAM_FIREWIRE 13)
; #define APPLE_IF_FAM_FIREWIRE  13

; #endif

; 
;  * Structures defining a network interface, providing a packet
;  * transport mechanism (ala level 0 of the PUP protocols).
;  *
;  * Each interface accepts output datagrams of a specified maximum
;  * length, and provides higher level routines with input datagrams
;  * received from its medium.
;  *
;  * Output occurs when the routine if_output is called, with three parameters:
;  *	(*ifp->if_output)(ifp, m, dst, rt)
;  * Here m is the mbuf chain to be sent and dst is the destination address.
;  * The output routine encapsulates the supplied datagram if necessary,
;  * and then transmits it on its medium.
;  *
;  * On input, each interface unwraps the data received by it, and either
;  * places it on the input queue of a internetwork datagram routine
;  * and posts the associated software interrupt, or passes the datagram to a raw
;  * packet input routine.
;  *
;  * Routines exist for locating interfaces by their addresses
;  * or for locating a interface on a certain network, as well as more general
;  * routing and gateway routines maintaining information used to locate
;  * interfaces.  These routines live in the files if.c and route.c
;  
; #ifdef __STDC__
#| #|

struct	mbuf;
struct	proc;
struct	rtentry;
struct	socket;
struct	ether_header;
struct  sockaddr_dl;
#endif
|#
 |#
(defconstant $IFNAMSIZ 16)
; #define	IFNAMSIZ	16

(require-interface "sys/queue")
; #ifdef __APPLE_API_UNSTABLE
#| #|
#ifdef__APPLE__
struct tqdummy;

TAILQ_HEAD(tailq_head, tqdummy);



struct net_event_data {
     u_long		if_family;
     u_long		if_unit;
     char		if_name[IFNAMSIZ];
};
#endif

TAILQ_HEAD(ifnethead, ifnet);	
TAILQ_HEAD(ifaddrhead, ifaddr);	
TAILQ_HEAD(ifprefixhead, ifprefix);
LIST_HEAD(ifmultihead, ifmultiaddr);

#ifdef__APPLE__

struct if_data {
	
	u_char	ifi_type;		
#ifdef__APPLE__
	u_char	ifi_typelen;		
#endif	u_char	ifi_physical;		
	u_char	ifi_addrlen;		
	u_char	ifi_hdrlen;		
	u_char	ifi_recvquota;		
	u_char	ifi_xmitquota;		
	u_long	ifi_mtu;		
	u_long	ifi_metric;		
	u_long	ifi_baudrate;		
	
	u_long	ifi_ipackets;		
	u_long	ifi_ierrors;		
	u_long	ifi_opackets;		
	u_long	ifi_oerrors;		
	u_long	ifi_collisions;		
	u_long	ifi_ibytes;		
	u_long	ifi_obytes;		
	u_long	ifi_imcasts;		
	u_long	ifi_omcasts;		
	u_long	ifi_iqdrops;		
	u_long	ifi_noproto;		
#ifdef__APPLE__
	u_long	ifi_recvtiming;		
	u_long	ifi_xmittiming;		
#endif	struct	timeval ifi_lastchange;	
#ifdef__APPLE__
	u_long	default_proto;		
#endif	u_long	ifi_hwassist;		
	u_long	ifi_reserved1;		
	u_long	ifi_reserved2;		
};
#endif

struct	ifqueue {
	struct	mbuf *ifq_head;
	struct	mbuf *ifq_tail;
	int	ifq_len;
	int	ifq_maxlen;
	int	ifq_drops;
};


struct ifnet {
	void	*if_softc;		
	char	*if_name;		
	TAILQ_ENTRY(ifnet) if_link; 	
	struct	ifaddrhead if_addrhead;	
#ifdef__APPLE__
	struct  tailq_head proto_head;    
#endif        int	if_pcount;		
	struct	bpf_if *if_bpf;		
	u_short	if_index;		
	short	if_unit;		
	short	if_timer;		
	short	if_flags;		
	int	if_ipending;		
	void	*if_linkmib;		
	size_t	if_linkmiblen;		
	struct	if_data if_data;

#ifdef__APPLE__

	int	refcnt;
	int	offercnt;
	int	(*if_output)(struct ifnet *ifnet_ptr, struct mbuf *m);
	int	(*if_ioctl)(struct ifnet *ifnet_ptr, u_long  ioctl_code, void  *ioctl_arg);
	int	(*if_set_bpf_tap)(struct ifnet *ifp, int mode, 
				  int (*bpf_callback)(struct ifnet *, struct mbuf *));
	int	(*if_free)(struct ifnet *ifnet_ptr);
	int	(*if_demux)(struct ifnet  *ifnet_ptr, struct mbuf  *mbuf_ptr, 
			    char *frame_ptr, void  *if_proto_ptr);

	int	(*if_event)(struct ifnet  *ifnet_ptr, caddr_t  event_ptr);

	int	(*if_framer)(struct ifnet    *ifp,
			     struct mbuf     **m,
			     struct sockaddr *dest,
			     char            *dest_linkaddr,
			     char	     *frame_type);

	u_long  if_family;		
	struct tailq_head   if_flt_head;



	void 	*reserved0;	
	void    *if_private;	
	long	if_eflags;		
#endif

	struct	ifmultihead if_multiaddrs; 
	int	if_amcount;		

#ifndef__APPLE__
	int	(*if_output)		
		__P((struct ifnet *, struct mbuf *, struct sockaddr *,
		     struct rtentry *));
	void	(*if_start)		
		__P((struct ifnet *));
	int	(*if_done)		
		__P((struct ifnet *));	
	int	(*if_ioctl)		
		__P((struct ifnet *, u_long, caddr_t));
	void	(*if_watchdog)		
		__P((struct ifnet *));
#endif	int	(*if_poll_recv)		
		__P((struct ifnet *, int *));
	int	(*if_poll_xmit)		
		__P((struct ifnet *, int *));
	void	(*if_poll_intren)	
		__P((struct ifnet *));
	void	(*if_poll_slowinput)	
		__P((struct ifnet *, struct mbuf *));
	void	(*if_init)		
		__P((void *));
	int	(*if_resolvemulti)	
		__P((struct ifnet *, struct sockaddr **, struct sockaddr *));
	struct	ifqueue if_snd;		
	struct	ifqueue *if_poll_slowq;	
#ifdef__APPLE__
	u_long  family_cookie;	
	struct	ifprefixhead if_prefixhead; 
	void *reserved1;	
#else	struct	ifprefixhead if_prefixhead; 
#endif
};
typedef void if_init_f_t __P((void *));

#define if_mtu		if_data.ifi_mtu
#define if_type		if_data.ifi_type
#define if_typelen	if_data.ifi_typelen
#define if_physical	if_data.ifi_physical
#define if_addrlen	if_data.ifi_addrlen
#define if_hdrlen	if_data.ifi_hdrlen
#define if_metric	if_data.ifi_metric
#define if_baudrate	if_data.ifi_baudrate
#define if_hwassist	if_data.ifi_hwassist
#define if_ipackets	if_data.ifi_ipackets
#define if_ierrors	if_data.ifi_ierrors
#define if_opackets	if_data.ifi_opackets
#define if_oerrors	if_data.ifi_oerrors
#define if_collisions	if_data.ifi_collisions
#define if_ibytes	if_data.ifi_ibytes
#define if_obytes	if_data.ifi_obytes
#define if_imcasts	if_data.ifi_imcasts
#define if_omcasts	if_data.ifi_omcasts
#define if_iqdrops	if_data.ifi_iqdrops
#define if_noproto	if_data.ifi_noproto
#define if_lastchange	if_data.ifi_lastchange
#define if_recvquota	if_data.ifi_recvquota
#define if_xmitquota	if_data.ifi_xmitquota
#define if_rawoutput(if, m, sa) if_output(if, m, sa, (struct rtentry *)0)

#ifndef__APPLE__

#define if_addrlist	if_addrhead
#define if_list		if_link
#endif

#define IFI_RECV	1	
#define IFI_XMIT	2	


#define IF_QFULL(ifq)		((ifq)->ifq_len >= (ifq)->ifq_maxlen)
#define IF_DROP(ifq)		((ifq)->ifq_drops++)
#define IF_ENQUEUE(ifq, m) { \
	(m)->m_nextpkt = 0; \
	if ((ifq)->ifq_tail == 0) \
		(ifq)->ifq_head = m; \
	else \
		(ifq)->ifq_tail->m_nextpkt = m; \
	(ifq)->ifq_tail = m; \
	(ifq)->ifq_len++; \
}
#define IF_PREPEND(ifq, m) { \
	(m)->m_nextpkt = (ifq)->ifq_head; \
	if ((ifq)->ifq_tail == 0) \
		(ifq)->ifq_tail = (m); \
	(ifq)->ifq_head = (m); \
	(ifq)->ifq_len++; \
}
#define IF_DEQUEUE(ifq, m) { \
	(m) = (ifq)->ifq_head; \
	if (m) { \
		if (((ifq)->ifq_head = (m)->m_nextpkt) == 0) \
			(ifq)->ifq_tail = 0; \
		(m)->m_nextpkt = 0; \
		(ifq)->ifq_len--; \
	} \
}

#ifdefKERNEL
#define IF_ENQ_DROP(ifq, m)	if_enq_drop(ifq, m)

#ifdefined(__GNUC__) && defined(MT_HEADER)
static __inline int
if_queue_drop(struct ifqueue *ifq, struct mbuf *m)
{
	IF_DROP(ifq);
	return 0;
}

static __inline int
if_enq_drop(struct ifqueue *ifq, struct mbuf *m)
{
	if (IF_QFULL(ifq) &&
	    !if_queue_drop(ifq, m))
		return 0;
	IF_ENQUEUE(ifq, m);
	return 1;
}
#else
#ifdefMT_HEADER
int	if_enq_drop __P((struct ifqueue *, struct mbuf *));
#endif
#endif#endif


#define IF_MINMTU	72
#define IF_MAXMTU	65535

#endif
|#
 |#
;  KERNEL 
; #ifdef __APPLE_API_UNSTABLE
#| #|

struct ifaddr {
	struct	sockaddr *ifa_addr;	
	struct	sockaddr *ifa_dstaddr;	
#define ifa_broadaddr	ifa_dstaddr	
	struct	sockaddr *ifa_netmask;	
#ifndef__APPLE__
	
	struct	if_data if_data;	
#endif	struct	ifnet *ifa_ifp;		
	TAILQ_ENTRY(ifaddr) ifa_link;	
	void	(*ifa_rtrequest)	
		__P((int, struct rtentry *, struct sockaddr *));
	u_short	ifa_flags;		
	short	ifa_refcnt;
	int	ifa_metric;		
#ifdefnotdef
	struct	rtentry *ifa_rt;	
#endif	u_long  ifa_dlt;
	int (*ifa_claim_addr)		
		__P((struct ifaddr *, struct sockaddr *));
};
#define IFA_ROUTE	RTF_UP		


struct ifprefix {
	struct	sockaddr *ifpr_prefix;	
	struct	ifnet *ifpr_ifp;	
	TAILQ_ENTRY(ifprefix) ifpr_list; 
	u_char	ifpr_plen;		
	u_char	ifpr_type;		
};


struct ifmultiaddr {
	LIST_ENTRY(ifmultiaddr) ifma_link; 
	struct	sockaddr *ifma_addr; 	
	struct	sockaddr *ifma_lladdr;	
	struct	ifnet *ifma_ifp;	
	u_int	ifma_refcount;		
	void	*ifma_protospec;	
};

#ifdefKERNEL
#define IFAREF(ifa) ifaref(ifa)
#define IFAFREE(ifa) ifafree(ifa)

#ifdef__APPLE_API_PRIVATE
extern	struct ifnethead ifnet;
extern struct	ifnet	**ifindex2ifnet;
extern	int ifqmaxlen;
extern	struct ifnet loif[];
extern	int if_index;
extern	struct ifaddr **ifnet_addrs;
#endif

#ifndef__APPLE__
void	ether_ifattach __P((struct ifnet *, int));
void	ether_ifdetach __P((struct ifnet *, int));
void	ether_input __P((struct ifnet *, struct ether_header *, struct mbuf *));
void	ether_demux __P((struct ifnet *, struct ether_header *, struct mbuf *));
int	ether_output __P((struct ifnet *,
	   struct mbuf *, struct sockaddr *, struct rtentry *));
int	ether_output_frame __P((struct ifnet *, struct mbuf *));
int	ether_ioctl __P((struct ifnet *, int, caddr_t));
#endif
int	if_addmulti __P((struct ifnet *, struct sockaddr *,
			 struct ifmultiaddr **));
int	if_allmulti __P((struct ifnet *, int));
void	if_attach __P((struct ifnet *));
int	if_delmultiaddr __P((struct ifmultiaddr *ifma));
int	if_delmulti __P((struct ifnet *, struct sockaddr *));
void	if_down __P((struct ifnet *));
void	if_route __P((struct ifnet *, int flag, int fam));
void	if_unroute __P((struct ifnet *, int flag, int fam));
void	if_up __P((struct ifnet *));
 
int	ifioctl __P((struct socket *, u_long, caddr_t, struct proc *));
int	ifpromisc __P((struct ifnet *, int));
struct	ifnet *ifunit __P((const char *));
struct  ifnet *if_withname __P((struct sockaddr *));

int	if_poll_recv_slow __P((struct ifnet *ifp, int *quotap));
void	if_poll_xmit_slow __P((struct ifnet *ifp, int *quotap));
void	if_poll_throttle __P((void));
void	if_poll_unthrottle __P((void *));
void	if_poll_init __P((void));
void	if_poll __P((void));

struct	ifaddr *ifa_ifwithaddr __P((struct sockaddr *));
struct	ifaddr *ifa_ifwithdstaddr __P((struct sockaddr *));
struct	ifaddr *ifa_ifwithnet __P((struct sockaddr *));
struct	ifaddr *ifa_ifwithroute __P((int, struct sockaddr *,
					struct sockaddr *));
struct	ifaddr *ifaof_ifpforaddr __P((struct sockaddr *, struct ifnet *));
void	ifafree __P((struct ifaddr *));
void	ifaref __P((struct ifaddr *));

struct	ifmultiaddr *ifmaof_ifpforaddr __P((struct sockaddr *, 
					    struct ifnet *));
#ifndef__APPLE__
int	if_simloop __P((struct ifnet *ifp, struct mbuf *m,
		struct sockaddr *dst, int hlen));
#endif
#endif


#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif /* !_NET_IF_VAR_H_ */


(provide-interface "if_var")