(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ip6protosw.h"
; at Sunday July 2,2006 7:30:07 pm.
; 	$FreeBSD: src/sys/netinet6/ip6protosw.h,v 1.2.2.3 2001/07/03 11:01:54 ume Exp $	
; 	$KAME: ip6protosw.h,v 1.22 2001/02/08 18:02:08 itojun Exp $	
; 
;  * Copyright (C) 1995, 1996, 1997, and 1998 WIDE Project.
;  * All rights reserved.
;  *
;  * Redistribution and use in source and binary forms, with or without
;  * modification, are permitted provided that the following conditions
;  * are met:
;  * 1. Redistributions of source code must retain the above copyright
;  *    notice, this list of conditions and the following disclaimer.
;  * 2. Redistributions in binary form must reproduce the above copyright
;  *    notice, this list of conditions and the following disclaimer in the
;  *    documentation and/or other materials provided with the distribution.
;  * 3. Neither the name of the project nor the names of its contributors
;  *    may be used to endorse or promote products derived from this software
;  *    without specific prior written permission.
;  *
;  * THIS SOFTWARE IS PROVIDED BY THE PROJECT AND CONTRIBUTORS ``AS IS'' AND
;  * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;  * ARE DISCLAIMED.  IN NO EVENT SHALL THE PROJECT OR CONTRIBUTORS BE LIABLE
;  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
;  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
;  * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;  * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
;  * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
;  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
;  * SUCH DAMAGE.
;  *
;  
; 	BSDI protosw.h,v 2.3 1996/10/11 16:02:40 pjd Exp	
; -
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
;  *	@(#)protosw.h	8.1 (Berkeley) 6/2/93
;  
; #ifndef _NETINET6_IP6PROTOSW_H_
; #define _NETINET6_IP6PROTOSW_H_

(require-interface "sys/appleapiopts")
; #ifdef __APPLE_API_PRIVATE
#| #|



struct mbuf;
struct sockaddr;
struct socket;
struct domain;
struct proc;
struct ip6_hdr;
struct icmp6_hdr;
struct in6_addr;
struct pr_usrreqs;


struct ip6ctlparam {
	struct mbuf *ip6c_m;		
	struct icmp6_hdr *ip6c_icmp6;	
	struct ip6_hdr *ip6c_ip6;	
	int ip6c_off;			
	struct sockaddr_in6 *ip6c_src;	
	struct sockaddr_in6 *ip6c_dst;	
	struct in6_addr *ip6c_finaldst;	
	void *ip6c_cmdarg;		
	u_int8_t ip6c_nxt;		
};

struct ip6protosw {
	short	pr_type;		
	struct	domain *pr_domain;	
	short	pr_protocol;		
        unsigned int pr_flags;          

	int	(*pr_input) __P((struct mbuf **, int *));
					
	int	(*pr_output)	__P((struct mbuf *m, struct socket *so,
				     struct sockaddr_in6 *, struct mbuf *));
					
	void	(*pr_ctlinput)__P((int, struct sockaddr *, void *));
					
	int	(*pr_ctloutput)__P((struct socket *, struct sockopt *));
					

	int	(*pr_usrreq)		
			__P((struct socket *, int, struct mbuf *,
			     struct mbuf *, struct mbuf *, struct proc *));


	void	(*pr_init) __P((void));	
	void	(*pr_fasttimo) __P((void));
					
	void	(*pr_slowtimo) __P((void));
					
	void	(*pr_drain) __P((void));
					
#ifdef__APPLE__
	
	int	(*pr_sysctl)();		
#endif
	struct	pr_usrreqs *pr_usrreqs;	
#ifdef__APPLE__
	
	TAILQ_HEAD(pr6_sfilter, NFDescriptor) pr_sfilter;
	struct ip6protosw *pr_next;	
	u_long reserved[4];
#endif};

#endif
|#
 |#
;  __APPLE_API_PRIVATE 

; #endif


(provide-interface "ip6protosw")