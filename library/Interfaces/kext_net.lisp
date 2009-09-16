(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:kext_net.h"
; at Sunday July 2,2006 7:30:15 pm.
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
;  Copyright (C) 1999 Apple Computer, Inc.  
; 
;  * Support for network filter kernel extensions
;  * Justin C. Walker, 990319
;  
; #ifndef NET_KEXT_NET_H
; #define NET_KEXT_NET_H

(require-interface "sys/appleapiopts")

(require-interface "sys/queue")

(require-interface "sys/socketvar")
; #ifdef __APPLE_API_UNSTABLE
#| #|


struct NFDescriptor
{	TAILQ_ENTRY(NFDescriptor) nf_next;	
	TAILQ_ENTRY(NFDescriptor) nf_list;	
	unsigned int nf_handle;			
	int nf_flags;
	
	int (*nf_connect)();			
	void (*nf_disconnect)();		
	int (*nf_read)();			
	int (*nf_write)();			
	int (*nf_get)();			
	int (*nf_set)();			
	
	struct  sockif *nf_soif;		
	struct	sockutil *nf_soutil;		
	u_long	reserved[4];			
};

#define NFD_GLOBAL	0x01
#define NFD_PROG	0x02
#define NFD_VISIBLE	0x80000000

#define NFF_BEFORE		0x01
#define NFF_AFTER		0x02

#ifdefKERNEL

extern int register_sockfilter(struct NFDescriptor *,
			       struct NFDescriptor *,
			       struct protosw *, int);

extern int unregister_sockfilter(struct NFDescriptor *, struct protosw *, int);

#ifdef__APPLE_API_PRIVATE
TAILQ_HEAD(nf_list, NFDescriptor);

extern struct nf_list nf_list;
#endif
#endif
#define NKE_OK 0
#define NKE_REMOVE -1


struct so_nke
{	unsigned int nke_handle;
	unsigned int nke_where;
	int nke_flags; 
	unsigned long reserved[4];	
};


struct sockif
{	int (*sf_soabort)(struct socket *, struct kextcb *);
	int (*sf_soaccept)(struct socket *, struct sockaddr **,
			   struct kextcb *);
	int (*sf_sobind)(struct socket *, struct sockaddr *, struct kextcb *);
	int (*sf_soclose)(struct socket *, struct kextcb *);
	int (*sf_soconnect)(struct socket *, struct sockaddr *,
			    struct kextcb *);
	int (*sf_soconnect2)(struct socket *, struct socket *,
			     struct kextcb *);
	int (*sf_socontrol)(struct socket *, struct sockopt *,
			    struct kextcb *);
	int (*sf_socreate)(struct socket *, struct protosw *, struct kextcb *);
	int (*sf_sodisconnect)(struct socket *, struct kextcb *);
	int (*sf_sofree)(struct socket *, struct kextcb *);
	int (*sf_sogetopt)(struct socket *, int, int, struct mbuf **,
			   struct kextcb *);
	int (*sf_sohasoutofband)(struct socket *, struct kextcb *);
	int (*sf_solisten)(struct socket *, struct kextcb *);
	int (*sf_soreceive)(struct socket *, struct sockaddr **, struct uio **,
			    struct mbuf **, struct mbuf **, int *,
			    struct kextcb *);
	int (*sf_sorflush)(struct socket *, struct kextcb *);
	int (*sf_sosend)(struct socket *, struct sockaddr **, struct uio **,
			 struct mbuf **, struct mbuf **, int *,
			 struct kextcb *);
	int (*sf_sosetopt)(struct socket *, int, int, struct mbuf *,
			   struct kextcb *);
	int (*sf_soshutdown)(struct socket *, int, struct kextcb *);
	
	int (*sf_socantrcvmore)(struct socket *, struct kextcb *);
	
	int (*sf_socantsendmore)(struct socket *, struct kextcb *);
	
	int (*sf_soisconnected)(struct socket *, struct kextcb *);
	int (*sf_soisconnecting)(struct socket *, struct kextcb *);
	
	int (*sf_soisdisconnected)(struct socket *, struct kextcb *);
	
	int (*sf_soisdisconnecting)(struct socket *, struct kextcb *);
	
	int (*sf_sonewconn)(struct socket *, int, struct kextcb *);
	int (*sf_soqinsque)(struct socket *, struct socket *, int,
			     struct kextcb *);
	int (*sf_soqremque)(struct socket *, int, struct kextcb *);
	int (*sf_soreserve)(struct socket *, u_long, u_long, struct kextcb *);
	int (*sf_sowakeup)(struct socket *, struct sockbuf *,
			    struct kextcb *);
	u_long	reserved[4];
};



struct sockutil
{	
	int (*su_sb_lock)(struct sockbuf *, struct kextcb *);
	
	int (*su_sbappend)(struct sockbuf *, struct mbuf *, struct kextcb *);
	
	int (*su_sbappendaddr)(struct sockbuf *, struct sockaddr *,
			       struct mbuf *, struct mbuf *, struct kextcb *);
	
	int (*su_sbappendcontrol)(struct sockbuf *, struct mbuf *,
				  struct mbuf *, struct kextcb *);
	
	int (*su_sbappendrecord)(struct sockbuf *, struct mbuf *,
				  struct kextcb *);
	
	int (*su_sbcompress)(struct sockbuf *, struct mbuf *, struct mbuf *,
			      struct kextcb *);
	
	int (*su_sbdrop)(struct sockbuf *, int, struct kextcb *);
	
	int (*su_sbdroprecord)(struct sockbuf *, struct kextcb *);
	
	int (*su_sbflush)(struct sockbuf *, struct kextcb *);
	
	int (*su_sbinsertoob)(struct sockbuf *, struct mbuf *,
			       struct kextcb *);
	
	int (*su_sbrelease)(struct sockbuf *, struct kextcb *);
	int (*su_sbreserve)(struct sockbuf *, u_long, struct kextcb *);
	
	int (*su_sbwait)(struct sockbuf *, struct kextcb *);
	u_long	reserved[4];
};
#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif


(provide-interface "kext_net")