(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:mbuf.h"
; at Sunday July 2,2006 7:30:26 pm.
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
;  * Mach Operating System
;  * Copyright (c) 1987 Carnegie-Mellon University
;  * All rights reserved.  The CMU software License Agreement specifies
;  * the terms and conditions for use and redistribution.
;  
; 
;  * Copyright (c) 1994 NeXT Computer, Inc. All rights reserved.
;  *
;  * Copyright (c) 1982, 1986, 1988 Regents of the University of California.
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
;  * 3. All advertising materials mentioning features or use of this software
;  *    must display the following acknowledgement:
;  *      This product includes software developed by the University of
;  *      California, Berkeley and its contributors.
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
;  *	@(#)mbuf.h	8.3 (Berkeley) 1/21/94
;  **********************************************************************
;  * HISTORY
;  * 20-May-95  Mac Gillon (mgillon) at NeXT
;  *	New version based on 4.4
;  *	Purged old history
;  
; #ifndef	_SYS_MBUF_H_
; #define	_SYS_MBUF_H_

(require-interface "sys/appleapiopts")

(require-interface "sys/lock")
; 
;  * Mbufs are of a single size, MSIZE (machine/param.h), which
;  * includes overhead.  An mbuf may add a single "mbuf cluster" of size
;  * MCLBYTES (also in machine/param.h), which has no additional overhead
;  * and is used instead of the internal data area; this is done when
;  * at least MINCLSIZE of data must be stored.
;  
; #ifdef __APPLE_API_UNSTABLE
#| #|
#define MLEN		(MSIZE - sizeof(struct m_hdr))	
#define MHLEN		(MLEN - sizeof(struct pkthdr))	

#define MINCLSIZE	(MHLEN + MLEN)	
#define M_MAXCOMPRESS	(MHLEN  2)	

#define NMBPCL		(sizeof(union mcluster)  sizeof(struct mbuf))


#define mtod(m,t)       ((t)m_mtod(m))
#define dtom(x)         m_dtom(x)
#define mtocl(x)        m_mtocl(x)
#define cltom(x)        m_cltom(x)

#define MCLREF(p)       m_mclref(p)
#define MCLUNREF(p)     m_mclunref(p)


struct m_hdr {
	struct	mbuf *mh_next;		
	struct	mbuf *mh_nextpkt;	
	long	mh_len;			
	caddr_t	mh_data;		
	short	mh_type;		
	short	mh_flags;		
};


struct	pkthdr {
	int	len;			
	struct	ifnet *rcvif;		

	
	void	*header;		
        
        int     csum_flags;                    
        int     csum_data;              
	struct mbuf *aux;		
	void	*reserved1;		
	void	*reserved2;		
};



struct m_ext {
	caddr_t	ext_buf;		
	void	(*ext_free)(caddr_t , u_int, caddr_t);	
	u_int	ext_size;		
	caddr_t	ext_arg;		
	struct	ext_refsq {		
		struct ext_refsq *forward, *backward;
	} ext_refs;
};

struct mbuf {
	struct	m_hdr m_hdr;
	union {
		struct {
			struct	pkthdr MH_pkthdr;	
			union {
				struct	m_ext MH_ext;	
				char	MH_databuf[MHLEN];
			} MH_dat;
		} MH;
		char	M_databuf[MLEN];		
	} M_dat;
};

#define m_next		m_hdr.mh_next
#define m_len		m_hdr.mh_len
#define m_data		m_hdr.mh_data
#define m_type		m_hdr.mh_type
#define m_flags		m_hdr.mh_flags
#define m_nextpkt	m_hdr.mh_nextpkt
#define m_act		m_nextpkt
#define m_pkthdr	M_dat.MH.MH_pkthdr
#define m_ext		M_dat.MH.MH_dat.MH_ext
#define m_pktdat	M_dat.MH.MH_dat.MH_databuf
#define m_dat		M_dat.M_databuf


#define M_EXT		0x0001	
#define M_PKTHDR	0x0002	
#define M_EOR		0x0004	
#define M_PROTO1	0x0008	
#define M_PROTO2	0x0010	
#define M_PROTO3	0x0020	
#define M_PROTO4	0x0040	
#define M_PROTO5	0x0080	


#define M_BCAST		0x0100	
#define M_MCAST		0x0200	
#define M_FRAG		0x0400	
#define M_FIRSTFRAG	0x0800	
#define M_LASTFRAG	0x1000	


#define M_COPYFLAGS	(M_PKTHDR|M_EOR|M_PROTO1|M_PROTO1|M_PROTO2|M_PROTO3 | \
			    M_PROTO4|M_PROTO5|M_BCAST|M_MCAST|M_FRAG)


#define CSUM_IP                 0x0001          
#define CSUM_TCP                0x0002          
#define CSUM_UDP                0x0004          
#define CSUM_IP_FRAGS           0x0008          
#define CSUM_FRAGMENT           0x0010          
        
#define CSUM_IP_CHECKED         0x0100          
#define CSUM_IP_VALID           0x0200          
#define CSUM_DATA_VALID         0x0400          
#define CSUM_PSEUDO_HDR         0x0800          
#define CSUM_TCP_SUM16          0x1000          
 
#define CSUM_DELAY_DATA         (CSUM_TCP | CSUM_UDP)
#define CSUM_DELAY_IP           (CSUM_IP)       



#define MT_FREE		0	
#define MT_DATA		1	
#define MT_HEADER	2	
#define MT_SOCKET	3	
#define MT_PCB		4	
#define MT_RTABLE	5	
#define MT_HTABLE	6	
#define MT_ATABLE	7	
#define MT_SONAME	8	
#define MT_SOOPTS	10	
#define MT_FTABLE	11	
#define MT_RIGHTS	12	
#define MT_IFADDR	13	
#define MT_CONTROL	14	
#define MT_OOBDATA	15	
#define MT_MAX		32	



#include <sysmalloc.h>

#define M_DONTWAIT	M_NOWAIT
#define M_WAIT		M_WAITOK

#ifdef__APPLE_API_PRIVATE 




extern
decl_simple_lock_data(, mbuf_slock);
#define MBUF_LOCK() usimple_lock(&mbuf_slock);
#define MBUF_UNLOCK() usimple_unlock(&mbuf_slock);
#define MBUF_LOCKINIT() simple_lock_init(&mbuf_slock);

#endif



#if1
#define MCHECK(m) m_mcheck(m)
#else#define MCHECK(m)
#endif
#ifdef__APPLE_API_PRIVATE
extern struct mbuf *mfree;				
extern simple_lock_data_t   mbuf_slock;
#endif


#define MGET(m, how, type) ((m) = m_get((how), (type)))

#define MGETHDR(m, how, type)	((m) = m_gethdr((how), (type)))


union mcluster {
	union	mcluster *mcl_next;
	char	mcl_buf[MCLBYTES];
};

#define MCLALLOC(p, how)	((p) = m_mclalloc(how))

#define MCLFREE(p)	m_mclfree(p)

#define MCLGET(m, how) 	((m) = m_mclget(m, how))

#define MCLHASREFERENCE(m) m_mclhasreference(m)



#define MFREE(m, n) ((n) = m_free(m))


#define M_COPY_PKTHDR(to, from)		m_copy_pkthdr(to, from)


#define M_ALIGN(m, len)				\
	{ (m)->m_data += (MLEN - (len)) &~ (sizeof(long) - 1); }

#define MH_ALIGN(m, len) \
	{ (m)->m_data += (MHLEN - (len)) &~ (sizeof(long) - 1); }


#define M_LEADINGSPACE(m)	m_leadingspace(m)


#define M_TRAILINGSPACE(m)	m_trailingspace(m)


#define M_PREPEND(m, plen, how) 	((m) = m_prepend_2((m), (plen), (how)))


#define MCHTYPE(m, t) 		m_mchtype(m, t)


#define M_COPYALL	1000000000


#define  m_copy(m, o, l)	m_copym((m), (o), (l), M_DONTWAIT)


struct mbstat {
	u_long	m_mbufs;	
	u_long	m_clusters;	
	u_long	m_spare;	
	u_long	m_clfree;	
	u_long	m_drops;	
	u_long	m_wait;		
	u_long	m_drain;	
	u_short	m_mtypes[256];	
	u_long	m_mcfail;	
	u_long	m_mpfail;	
	u_long	m_msize;	
	u_long	m_mclbytes;	
	u_long	m_minclsize;	
	u_long	m_mlen;		
	u_long	m_mhlen;	
};


struct mauxtag {
	int af;
	int type;
};

#ifdefKERNEL
extern union 	mcluster *mbutl;	
extern union 	mcluster *embutl;	
extern short 	*mclrefcnt;		
extern int 	*mcl_paddr;		
extern struct 	mbstat mbstat;		
extern int 	nmbclusters;		
extern union 	mcluster *mclfree;	
extern int	max_linkhdr;		
extern int	max_protohdr;		
extern int	max_hdr;		
extern int	max_datalen;		

struct	mbuf *m_copym __P((struct mbuf *, int, int, int));
struct	mbuf *m_split __P((struct mbuf *, int, int));
struct	mbuf *m_free __P((struct mbuf *));
struct	mbuf *m_get __P((int, int));
struct	mbuf *m_getpacket __P((void));
struct	mbuf *m_getclr __P((int, int));
struct	mbuf *m_gethdr __P((int, int));
struct	mbuf *m_prepend __P((struct mbuf *, int, int));
struct  mbuf *m_prepend_2 __P((struct mbuf *, int, int));
struct	mbuf *m_pullup __P((struct mbuf *, int));
struct	mbuf *m_retry __P((int, int));
struct	mbuf *m_retryhdr __P((int, int));
void m_adj __P((struct mbuf *, int));
int	 m_clalloc __P((int, int));
void m_freem __P((struct mbuf *));
int m_freem_list __P((struct mbuf *));
struct	mbuf *m_devget __P((char *, int, int, struct ifnet *, void (*)()));
char   *mcl_to_paddr __P((char *));
struct mbuf *m_pulldown __P((struct mbuf*, int, int, int*));
struct mbuf *m_aux_add __P((struct mbuf *, int, int));
struct mbuf *m_aux_find __P((struct mbuf *, int, int));
void m_aux_delete __P((struct mbuf *, struct mbuf *));

struct mbuf *m_mclget __P((struct mbuf *, int));
caddr_t m_mclalloc __P((int));
void m_mclfree __P((caddr_t p));
int m_mclhasreference __P((struct mbuf *));
void m_copy_pkthdr __P((struct mbuf *, struct mbuf*));

int m_mclref __P((struct mbuf *));
int m_mclunref __P((struct mbuf *));

void *          m_mtod __P((struct mbuf *));
struct mbuf *   m_dtom __P((void *));
int             m_mtocl __P((void *));
union mcluster *m_cltom __P((int ));

int m_trailingspace __P((struct mbuf *));
int m_leadingspace __P((struct mbuf *));

void m_mchtype __P((struct mbuf *m, int t));

void m_mcheck __P((struct mbuf*));

#endif#endif
|#
 |#
;  __APPLE_API_UNSTABLE 

; #endif	/* !_SYS_MBUF_H_ */


(provide-interface "mbuf")