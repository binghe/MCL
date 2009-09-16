(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:protosw.h"
; at Sunday July 2,2006 7:31:19 pm.
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
;  Copyright (c) 1998, 1999 Apple Computer, Inc. All Rights Reserved 
;  Copyright (c) 1995 NeXT Computer, Inc. All Rights Reserved 
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
;  *	@(#)protosw.h	8.1 (Berkeley) 6/2/93
;  * $FreeBSD: src/sys/sys/protosw.h,v 1.28.2.2 2001/07/03 11:02:01 ume Exp $
;  
; #ifndef _SYS_PROTOSW_H_
; #define _SYS_PROTOSW_H_
;  Forward declare these structures referenced from prototypes below. 
; #ifdef _KERNEL
; 
;  * Protocol switch table.
;  *
;  * Each protocol has a handle initializing one of these structures,
;  * which is used for protocol-protocol and system-protocol communication.
;  *
;  * A protocol is called through the pr_init entry before any other.
;  * Thereafter it is called every 200ms through the pr_fasttimo entry and
;  * every 500ms through the pr_slowtimo for timer based actions.
;  * The system will call the pr_drain entry if it is low on space and
;  * this should throw away any non-critical data.
;  *
;  * Protocols pass data between themselves as chains of mbufs using
;  * the pr_input and pr_output hooks.  Pr_input passes data up (towards
;  * the users) and pr_output passes it down (towards the interfaces); control
;  * information passes up and down on pr_ctlinput and pr_ctloutput.
;  * The protocol is responsible for the space occupied by any the
;  * arguments to these entries and must dispose it.
;  *
;  * The userreq routine interfaces protocols to the system and is
;  * described below.
;  

(require-interface "sys/appleapiopts")

(require-interface "sys/socketvar")

(require-interface "sys/queue")
; #ifdef __APPLE_API_UNSTABLE
#| #|
struct protosw {
	short	pr_type;		
	struct	domain *pr_domain;	
	short	pr_protocol;		
	unsigned int pr_flags;		

	void	(*pr_input) __P((struct mbuf *, int len));
					
	int	(*pr_output)	__P((struct mbuf *m, struct socket *so));
					
	void	(*pr_ctlinput)__P((int, struct sockaddr *, void *));
					
	int	(*pr_ctloutput)__P((struct socket *, struct sockopt *));
					

	void	*pr_ousrreq;

	void	(*pr_init) __P((void));	
	void	(*pr_fasttimo) __P((void));
					
	void	(*pr_slowtimo) __P((void));
					
	void	(*pr_drain) __P((void));
					
#if__APPLE__
	int	(*pr_sysctl)();		
#endif	struct	pr_usrreqs *pr_usrreqs;	
#if__APPLE__

	TAILQ_HEAD(pr_sfilter, NFDescriptor) pr_sfilter;
	struct protosw *pr_next;	
	u_long	reserved[4];		
#endif};

#define PR_SLOWHZ	2		
#define PR_FASTHZ	5		


#define PR_ATOMIC	0x01		
#define PR_ADDR		0x02		
#define PR_CONNREQUIRED	0x04		
#define PR_WANTRCVD	0x08		
#define PR_RIGHTS	0x10		
#define PR_IMPLOPCL	0x20		
#define PR_LASTHDR	0x40		


#define PRU_ATTACH		0	
#define PRU_DETACH		1	
#define PRU_BIND		2	
#define PRU_LISTEN		3	
#define PRU_CONNECT		4	
#define PRU_ACCEPT		5	
#define PRU_DISCONNECT		6	
#define PRU_SHUTDOWN		7	
#define PRU_RCVD		8	
#define PRU_SEND		9	
#define PRU_ABORT		10	
#define PRU_CONTROL		11	
#define PRU_SENSE		12	
#define PRU_RCVOOB		13	
#define PRU_SENDOOB		14	
#define PRU_SOCKADDR		15	
#define PRU_PEERADDR		16	
#define PRU_CONNECT2		17	

#define PRU_FASTTIMO		18	
#define PRU_SLOWTIMO		19	
#define PRU_PROTORCV		20	
#define PRU_PROTOSEND		21	

#define PRU_SEND_EOF		22	
#define PRU_NREQ		22

#ifdefPRUREQUESTS
char *prurequests[] = {
	"ATTACH",	"DETACH",	"BIND",		"LISTEN",
	"CONNECT",	"ACCEPT",	"DISCONNECT",	"SHUTDOWN",
	"RCVD",		"SEND",		"ABORT",	"CONTROL",
	"SENSE",	"RCVOOB",	"SENDOOB",	"SOCKADDR",
	"PEERADDR",	"CONNECT2",	"FASTTIMO",	"SLOWTIMO",
	"PROTORCV",	"PROTOSEND",
	"SEND_EOF",
};
#endif
#ifdefKERNEL			

struct ifnet;
struct stat;
struct ucred;
struct uio;


struct pr_usrreqs {
	int	(*pru_abort) __P((struct socket *so));
	int	(*pru_accept) __P((struct socket *so, struct sockaddr **nam));
	int	(*pru_attach) __P((struct socket *so, int proto,
				   struct proc *p));
	int	(*pru_bind) __P((struct socket *so, struct sockaddr *nam,
				 struct proc *p));
	int	(*pru_connect) __P((struct socket *so, struct sockaddr *nam,
				    struct proc *p));
	int	(*pru_connect2) __P((struct socket *so1, struct socket *so2));
	int	(*pru_control) __P((struct socket *so, u_long cmd, caddr_t data,
				    struct ifnet *ifp, struct proc *p));
	int	(*pru_detach) __P((struct socket *so));
	int	(*pru_disconnect) __P((struct socket *so));
	int	(*pru_listen) __P((struct socket *so, struct proc *p));
	int	(*pru_peeraddr) __P((struct socket *so, 
				     struct sockaddr **nam));
	int	(*pru_rcvd) __P((struct socket *so, int flags));
	int	(*pru_rcvoob) __P((struct socket *so, struct mbuf *m,
				   int flags));
	int	(*pru_send) __P((struct socket *so, int flags, struct mbuf *m, 
				 struct sockaddr *addr, struct mbuf *control,
				 struct proc *p));
#define PRUS_OOB	0x1
#define PRUS_EOF	0x2
#define PRUS_MORETOCOME	0x4
	int	(*pru_sense) __P((struct socket *so, struct stat *sb));
	int	(*pru_shutdown) __P((struct socket *so));
	int	(*pru_sockaddr) __P((struct socket *so, 
				     struct sockaddr **nam));
	 
	
	int	(*pru_sosend) __P((struct socket *so, struct sockaddr *addr,
				   struct uio *uio, struct mbuf *top,
				   struct mbuf *control, int flags));
	int	(*pru_soreceive) __P((struct socket *so, 
				      struct sockaddr **paddr,
				      struct uio *uio, struct mbuf **mp0,
				      struct mbuf **controlp, int *flagsp));
	int	(*pru_sopoll) __P((struct socket *so, int events, 
				   struct ucred *cred, void *));
};

extern int	pru_abort_notsupp(struct socket *so);
extern int	pru_accept_notsupp(struct socket *so, struct sockaddr **nam);
extern int	pru_attach_notsupp(struct socket *so, int proto,
				   struct proc *p);
extern int	pru_bind_notsupp(struct socket *so, struct sockaddr *nam,
				 struct proc *p);
extern int	pru_connect_notsupp(struct socket *so, struct sockaddr *nam,
				    struct proc *p);
extern int	pru_connect2_notsupp(struct socket *so1, struct socket *so2);
extern int	pru_control_notsupp(struct socket *so, u_long cmd, caddr_t data,
				    struct ifnet *ifp, struct proc *p);
extern int	pru_detach_notsupp(struct socket *so);
extern int	pru_disconnect_notsupp(struct socket *so);
extern int	pru_listen_notsupp(struct socket *so, struct proc *p);
extern int	pru_peeraddr_notsupp(struct socket *so, 
				     struct sockaddr **nam);
extern int	pru_rcvd_notsupp(struct socket *so, int flags);
extern int	pru_rcvoob_notsupp(struct socket *so, struct mbuf *m,
				   int flags);
extern int	pru_send_notsupp(struct socket *so, int flags, struct mbuf *m, 
				 struct sockaddr *addr, struct mbuf *control,
				 struct proc *p);
extern int	pru_sense_null(struct socket *so, struct stat *sb);
extern int	pru_shutdown_notsupp(struct socket *so);
extern int	pru_sockaddr_notsupp(struct socket *so, 
				     struct sockaddr **nam);
extern int	pru_sosend_notsupp(struct socket *so, struct sockaddr *addr,
				   struct uio *uio, struct mbuf *top,
				   struct mbuf *control, int flags);
extern int	pru_soreceive_notsupp(struct socket *so, 
				      struct sockaddr **paddr,
				      struct uio *uio, struct mbuf **mp0,
				      struct mbuf **controlp, int *flagsp);
extern int	pru_sopoll_notsupp(struct socket *so, int events, 
				   struct ucred *cred);


#endif


#define PRC_IFDOWN		0	
#define PRC_ROUTEDEAD		1	
#define PRC_IFUP		2 	
#define PRC_QUENCH2		3	
#define PRC_QUENCH		4	
#define PRC_MSGSIZE		5	
#define PRC_HOSTDEAD		6	
#define PRC_HOSTUNREACH		7	
#define PRC_UNREACH_NET		8	
#define PRC_UNREACH_HOST	9	
#define PRC_UNREACH_PROTOCOL	10	
#define PRC_UNREACH_PORT	11	

#define PRC_UNREACH_SRCFAIL	13	
#define PRC_REDIRECT_NET	14	
#define PRC_REDIRECT_HOST	15	
#define PRC_REDIRECT_TOSNET	16	
#define PRC_REDIRECT_TOSHOST	17	
#define PRC_TIMXCEED_INTRANS	18	
#define PRC_TIMXCEED_REASS	19	
#define PRC_PARAMPROB		20	
#define PRC_UNREACH_ADMIN_PROHIB	21	

#define PRC_NCMDS		22

#define PRC_IS_REDIRECT(cmd)	\
	((cmd) >= PRC_REDIRECT_NET && (cmd) <= PRC_REDIRECT_TOSHOST)

#ifdefPRCREQUESTS
char	*prcrequests[] = {
	"IFDOWN", "ROUTEDEAD", "IFUP", "DEC-BIT-QUENCH2",
	"QUENCH", "MSGSIZE", "HOSTDEAD", "#7 ",
	"NET-UNREACH", "HOST-UNREACH", "PROTO-UNREACH", "PORT-UNREACH",
	"#12 ", "SRCFAIL-UNREACH", "NET-REDIRECT", "HOST-REDIRECT",
	"TOSNET-REDIRECT", "TOSHOST-REDIRECT", "TX-INTRANS", "TX-REASS",
	"PARAMPROB", "ADMIN-UNREACH"
};
#endif

#define PRCO_GETOPT	0
#define PRCO_SETOPT	1

#define PRCO_NCMDS	2

#ifdefPRCOREQUESTS
char	*prcorequests[] = {
	"GETOPT", "SETOPT",
};
#endif
#ifdefKERNEL
void	pfctlinput __P((int, struct sockaddr *));
void	pfctlinput2 __P((int, struct sockaddr *, void *));
struct protosw *pffindproto __P((int family, int protocol, int type));
struct protosw *pffindtype __P((int family, int type));

extern int net_add_proto(struct protosw *, struct domain *);
extern int net_del_proto(int, int, struct domain *);



#define LINK_PROTOS(psw) \
static void link_ 
; # psw ## _protos() {       int i; 		     for (i=0; i < ((sizeof(psw)/sizeof(psw[0])) - 1); i++) 	     psw[i].pr_next = &psw[i + 1]; } 
#COMPILER-DIRECTIVE 
#endif#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif	/* !_SYS_PROTOSW_H_ */


(provide-interface "protosw")