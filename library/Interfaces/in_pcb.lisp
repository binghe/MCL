(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:in_pcb.h"
; at Sunday July 2,2006 7:28:11 pm.
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
;  *	@(#)in_pcb.h	8.1 (Berkeley) 6/10/93
;  * $FreeBSD: src/sys/netinet/in_pcb.h,v 1.32.2.4 2001/08/13 16:26:17 ume Exp $
;  
; #ifndef _NETINET_IN_PCB_H_
; #define _NETINET_IN_PCB_H_

(require-interface "sys/appleapiopts")

(require-interface "sys/queue")

(require-interface "netinet6/ipsec")
; #ifdef __APPLE_API_PRIVATE
#| #|

#define in6pcb		inpcb	
#define in6p_sp		inp_sp	


LIST_HEAD(inpcbhead, inpcb);
LIST_HEAD(inpcbporthead, inpcbport);
typedef	u_quad_t	inp_gen_t;


struct in_addr_4in6 {
	u_int32_t	ia46_pad32[3];
	struct	in_addr	ia46_addr4;
};


struct	icmp6_filter;

struct inpcb {
	LIST_ENTRY(inpcb) inp_hash;	
	struct	in_addr reserved1;	
	struct	in_addr reserved2; 
	u_short	inp_fport;		
	u_short	inp_lport;		
	LIST_ENTRY(inpcb) inp_list;	
	caddr_t	inp_ppcb;		
	struct	inpcbinfo *inp_pcbinfo;	
	struct	socket *inp_socket;	
	u_char	nat_owner;		
	u_long  nat_cookie;		
	LIST_ENTRY(inpcb) inp_portlist;	
	struct	inpcbport *inp_phd;	
	inp_gen_t inp_gencnt;		
	int	inp_flags;		
	u_int32_t inp_flow;

	u_char	inp_vflag;
#define INP_IPV4	0x1
#define INP_IPV6	0x2

	u_char inp_ip_ttl;		
	u_char inp_ip_p;		
	
	union {
		
		struct	in_addr_4in6 inp46_foreign;
		struct	in6_addr inp6_foreign;
	} inp_dependfaddr;
	union {
		
		struct	in_addr_4in6 inp46_local;
		struct	in6_addr inp6_local;
	} inp_dependladdr;
	union {
		
		struct	route inp4_route;
		struct	route_in6 inp6_route;
	} inp_dependroute;
	struct {
		
		u_char inp4_ip_tos;
		
		struct mbuf *inp4_options;
		
		struct ip_moptions *inp4_moptions;
	} inp_depend4;
#define inp_faddr	inp_dependfaddr.inp46_foreign.ia46_addr4
#define inp_laddr	inp_dependladdr.inp46_local.ia46_addr4
#define inp_route	inp_dependroute.inp4_route
#define inp_ip_tos	inp_depend4.inp4_ip_tos
#define inp_options	inp_depend4.inp4_options
#define inp_moptions	inp_depend4.inp4_moptions
	struct {
		
		struct mbuf *inp6_options;
		u_int8_t	inp6_hlim;
		u_int8_t	unused_uint8_1;
		ushort	unused_uint16_1;
		
		struct	ip6_pktopts *inp6_outputopts;
		
		struct	ip6_moptions *inp6_moptions;
		
		struct	icmp6_filter *inp6_icmp6filt;
		
		int	inp6_cksum;
		u_short	inp6_ifindex;
		short	inp6_hops;
	} inp_depend6;
#define in6p_faddr	inp_dependfaddr.inp6_foreign
#define in6p_laddr	inp_dependladdr.inp6_local
#define in6p_route	inp_dependroute.inp6_route
#define in6p_ip6_hlim	inp_depend6.inp6_hlim
#define in6p_hops	inp_depend6.inp6_hops	
#define in6p_ip6_nxt	inp_ip_p
#define in6p_flowinfo	inp_flow
#define in6p_vflag	inp_vflag
#define in6p_options	inp_depend6.inp6_options
#define in6p_outputopts	inp_depend6.inp6_outputopts
#define in6p_moptions	inp_depend6.inp6_moptions
#define in6p_icmp6filt	inp_depend6.inp6_icmp6filt
#define in6p_cksum	inp_depend6.inp6_cksum
#define inp6_ifindex	inp_depend6.inp6_ifindex
#define in6p_flags	inp_flags  
#define in6p_socket	inp_socket  
#define in6p_lport	inp_lport  
#define in6p_fport	inp_fport  
#define in6p_ppcb	inp_ppcb  

	int	hash_element;           
	caddr_t inp_saved_ppcb;		
	struct inpcbpolicy *inp_sp;
	u_long	reserved[3];		
};
#endif
|#
 |#
;  __APPLE_API_PRIVATE 
; 
;  * The range of the generation count, as used in this implementation,
;  * is 9e19.  We would have to create 300 billion connections per
;  * second for this number to roll over in a year.  This seems sufficiently
;  * unlikely that we simply don't concern ourselves with that possibility.
;  
; 
;  * Interface exported to userland by various protocols which use
;  * inpcbs.  Hack alert -- only define if struct xsocket is in scope.
;  
; #ifdef _SYS_SOCKETVAR_H_
#| #|
struct	xinpcb {
	size_t	xi_len;		
	struct	inpcb xi_inp;
	struct	xsocket xi_socket;
	u_quad_t	xi_alignment_hack;
};

struct	xinpgen {
	size_t	xig_len;	
	u_int	xig_count;	
	inp_gen_t xig_gen;	
	so_gen_t xig_sogen;	
};
#endif
|#
 |#
;  _SYS_SOCKETVAR_H_ 
; #ifdef __APPLE_API_PRIVATE
#| #|
struct inpcbport {
	LIST_ENTRY(inpcbport) phd_hash;
	struct inpcbhead phd_pcblist;
	u_short phd_port;
};

struct inpcbinfo {		
	struct	inpcbhead *hashbase;
#ifdef__APPLE__
	u_long	hashsize; 
#endif	u_long	hashmask;
	struct	inpcbporthead *porthashbase;
	u_long	porthashmask;
	struct	inpcbhead *listhead;
	u_short	lastport;
	u_short	lastlow;
	u_short	lasthi;
	void   *ipi_zone; 
	u_int	ipi_count;	
	u_quad_t ipi_gencnt;	
#ifdef__APPLE__
     	u_char   all_owners;
     	struct	socket nat_dummy_socket;
	struct	inpcb *last_pcb;
     	caddr_t  dummy_cb;
#endif};

#define INP_PCBHASH(faddr, lport, fport, mask) \
	(((faddr) ^ ((faddr) >> 16) ^ ntohs((lport) ^ (fport))) & (mask))
#define INP_PCBPORTHASH(lport, mask) \
	(ntohs((lport)) & (mask))


#define INP_RECVOPTS		0x01	
#define INP_RECVRETOPTS		0x02	
#define INP_RECVDSTADDR		0x04	
#define INP_HDRINCL		0x08	
#define INP_HIGHPORT		0x10	
#define INP_LOWPORT		0x20	
#define INP_ANONPORT		0x40	
#define INP_RECVIF		0x80	
#define INP_MTUDISC		0x100	
#ifdef__APPLE__
#define INP_STRIPHDR	0x200	
#endif#define  INP_FAITH			0x400   
#define  INP_INADDR_ANY 	0x800   

#define INP_RECVTTL			0x1000

#define IN6P_IPV6_V6ONLY	0x008000 

#define IN6P_PKTINFO		0x010000 
#define IN6P_HOPLIMIT		0x020000 
#define IN6P_HOPOPTS		0x040000 
#define IN6P_DSTOPTS		0x080000 
#define IN6P_RTHDR		0x100000 
#define IN6P_RTHDRDSTOPTS	0x200000 
#define IN6P_AUTOFLOWLABEL	0x800000 
#define IN6P_BINDV6ONLY		0x10000000 

#define INP_CONTROLOPTS		(INP_RECVOPTS|INP_RECVRETOPTS|INP_RECVDSTADDR|\
					INP_RECVIF|\
				 IN6P_PKTINFO|IN6P_HOPLIMIT|IN6P_HOPOPTS|\
				 IN6P_DSTOPTS|IN6P_RTHDR|IN6P_RTHDRDSTOPTS|\
				 IN6P_AUTOFLOWLABEL|INP_RECVTTL)
#define INP_UNMAPPABLEOPTS	(IN6P_HOPOPTS|IN6P_DSTOPTS|IN6P_RTHDR|\
				 IN6P_AUTOFLOWLABEL)

 
#define IN6P_HIGHPORT		INP_HIGHPORT
#define IN6P_LOWPORT		INP_LOWPORT
#define IN6P_ANONPORT		INP_ANONPORT
#define IN6P_RECVIF		INP_RECVIF
#define IN6P_MTUDISC		INP_MTUDISC
#define IN6P_FAITH		INP_FAITH
#define IN6P_CONTROLOPTS INP_CONTROLOPTS
	

#define INPLOOKUP_WILDCARD	1
#ifdef__APPLE__
#define INPCB_ALL_OWNERS	0xff
#define INPCB_NO_OWNER		0x0
#define INPCB_OWNED_BY_X	0x80
#define INPCB_MAX_IDS		7
#endif
#define sotoinpcb(so)	((struct inpcb *)(so)->so_pcb)
#define sotoin6pcb(so)	sotoinpcb(so) 

#define INP_SOCKAF(so) so->so_proto->pr_domain->dom_family

#define INP_CHECK_SOCKAF(so, af) 	(INP_SOCKAF(so) == af)

#ifdefKERNEL
extern int	ipport_lowfirstauto;
extern int	ipport_lowlastauto;
extern int	ipport_firstauto;
extern int	ipport_lastauto;
extern int	ipport_hifirstauto;
extern int	ipport_hilastauto;

void	in_pcbpurgeif0 __P((struct inpcb *, struct ifnet *));
void	in_losing __P((struct inpcb *));
void	in_rtchange __P((struct inpcb *, int));
int	in_pcballoc __P((struct socket *, struct inpcbinfo *, struct proc *));
int	in_pcbbind __P((struct inpcb *, struct sockaddr *, struct proc *));
int	in_pcbconnect __P((struct inpcb *, struct sockaddr *, struct proc *));
void	in_pcbdetach __P((struct inpcb *));
void	in_pcbdisconnect __P((struct inpcb *));
int	in_pcbinshash __P((struct inpcb *));
int	in_pcbladdr __P((struct inpcb *, struct sockaddr *,
	    struct sockaddr_in **));
struct inpcb *
	in_pcblookup_local __P((struct inpcbinfo *,
	    struct in_addr, u_int, int));
struct inpcb *
	in_pcblookup_hash __P((struct inpcbinfo *,
			       struct in_addr, u_int, struct in_addr, u_int,
			       int, struct ifnet *));
void	in_pcbnotifyall __P((struct inpcbhead *, struct in_addr,
	    int, void (*)(struct inpcb *, int)));
void	in_pcbrehash __P((struct inpcb *));
int	in_setpeeraddr __P((struct socket *so, struct sockaddr **nam));
int	in_setsockaddr __P((struct socket *so, struct sockaddr **nam));

#ifdef__APPLE__
int	
in_pcb_grab_port  __P((struct inpcbinfo *pcbinfo,
		       u_short		options,
		       struct in_addr	laddr, 
		       u_short		*lport,  
		       struct in_addr	faddr,
		       u_short		fport,
		       u_int		cookie, 
		       u_char		owner_id));

int	
in_pcb_letgo_port __P((struct inpcbinfo *pcbinfo, 
		       struct in_addr laddr, 
		       u_short lport,
		       struct in_addr faddr,
		       u_short fport, u_char owner_id));

u_char
in_pcb_get_owner __P((struct inpcbinfo *pcbinfo, 
		      struct in_addr laddr, 
		      u_short lport, 
		      struct in_addr faddr,
		      u_short fport,
		      u_int *cookie));

void in_pcb_nat_init(struct inpcbinfo *pcbinfo, int afamily, int pfamily,
		     int protocol);

int
in_pcb_new_share_client(struct inpcbinfo *pcbinfo, u_char *owner_id);

int
in_pcb_rem_share_client(struct inpcbinfo *pcbinfo, u_char owner_id);
#endif

void	in_pcbremlists __P((struct inpcb *inp));
#ifndef__APPLE__
int	prison_xinpcb __P((struct proc *p, struct inpcb *inp));
#endif#endif
#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif /* !_NETINET_IN_PCB_H_ */


(provide-interface "in_pcb")