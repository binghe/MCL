(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ip6_mroute.h"
; at Sunday July 2,2006 7:30:06 pm.
; 	$FreeBSD: src/sys/netinet6/ip6_mroute.h,v 1.2.2.2 2001/07/03 11:01:53 ume Exp $	
; 	$KAME: ip6_mroute.h,v 1.17 2001/02/10 02:05:52 itojun Exp $	
; 
;  * Copyright (C) 1998 WIDE Project.
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
;  
; 	BSDI ip_mroute.h,v 2.5 1996/10/11 16:01:48 pjd Exp	
; 
;  * Definitions for IP multicast forwarding.
;  *
;  * Written by David Waitzman, BBN Labs, August 1988.
;  * Modified by Steve Deering, Stanford, February 1989.
;  * Modified by Ajit Thyagarajan, PARC, August 1993.
;  * Modified by Ajit Thyagarajan, PARC, August 1994.
;  * Modified by Ahmed Helmy, USC, September 1996.
;  *
;  * MROUTING Revision: 1.2
;  
; #ifndef _NETINET6_IP6_MROUTE_H_
; #define _NETINET6_IP6_MROUTE_H_

(require-interface "sys/appleapiopts")
; 
;  * Multicast Routing set/getsockopt commands.
;  
; #ifdef KERNEL
#| #|
#define MRT6_OINIT		100	
#endif
|#
 |#
(defconstant $MRT6_DONE 101)
; #define MRT6_DONE		101	/* shut down forwarder */
(defconstant $MRT6_ADD_MIF 102)
; #define MRT6_ADD_MIF		102	/* add multicast interface */
(defconstant $MRT6_DEL_MIF 103)
; #define MRT6_DEL_MIF		103	/* delete multicast interface */
(defconstant $MRT6_ADD_MFC 104)
; #define MRT6_ADD_MFC		104	/* insert forwarding cache entry */
(defconstant $MRT6_DEL_MFC 105)
; #define MRT6_DEL_MFC		105	/* delete forwarding cache entry */
(defconstant $MRT6_PIM 107)
; #define MRT6_PIM                107     /* enable pim code */
(defconstant $MRT6_INIT 108)
; #define MRT6_INIT		108	/* initialize forwarder (mrt6msg) */

; #if BSD >= 199103
; #define GET_TIME(t)	microtime(&t)
#| 
; #elif defined(sun)
; #define GET_TIME(t)	uniqtime(&t)
 |#

; #else
; #define GET_TIME(t)	((t) = time)

; #endif

; 
;  * Types and macros for handling bitmaps with one bit per multicast interface.
;  

(def-mactype :mifi_t (find-mactype ':UInt16))
;  type of a mif index 
(defconstant $MAXMIFS 64)
; #define MAXMIFS		64
; #ifndef	IF_SETSIZE
(defconstant $IF_SETSIZE 256)
; #define	IF_SETSIZE	256

; #endif


(def-mactype :if_mask (find-mactype ':UInt32))
(defconstant $NIFBITS 32)
; #define	NIFBITS	(sizeof(if_mask) * NBBY)	/* bits per mask */
; #ifndef howmany
; #define	howmany(x, y)	(((x) + ((y) - 1)) / (y))

; #endif

(defrecord if_set
   (ifs_bits (:array :UInt32 8))
)
; #define	IF_SET(n, p)	((p)->ifs_bits[(n)/NIFBITS] |= (1 << ((n) % NIFBITS)))
; #define	IF_CLR(n, p)	((p)->ifs_bits[(n)/NIFBITS] &= ~(1 << ((n) % NIFBITS)))
; #define	IF_ISSET(n, p)	((p)->ifs_bits[(n)/NIFBITS] & (1 << ((n) % NIFBITS)))
; #define	IF_COPY(f, t)	bcopy(f, t, sizeof(*(f)))
; #define	IF_ZERO(p)	bzero(p, sizeof(*(p)))
; 
;  * Argument structure for MRT6_ADD_IF.
;  
(defrecord mif6ctl
   (mif6c_mifi :UInt16)
                                                ;  the index of the mif to be added  
   (mif6c_flags :UInt8)
                                                ;  MIFF_ flags defined below         
   (mif6c_pifi :UInt16)
                                                ;  the index of the physical IF 

; #if notyet
#| 
   (mif6c_rate_limit :UInt32)                   ;  max rate           		     
 |#

; #endif

)
(defconstant $MIFF_REGISTER 1)
; #define	MIFF_REGISTER	0x1	/* mif represents a register end-point */
; 
;  * Argument structure for MRT6_ADD_MFC and MRT6_DEL_MFC
;  
(defrecord mf6cctl
   (mf6cc_origin :sockaddr_in6)
#|
; Warning: type-size: unknown type SOCKADDR_IN6
|#
                                                ;  IPv6 origin of mcasts 
   (mf6cc_mcastgrp :sockaddr_in6)
#|
; Warning: type-size: unknown type SOCKADDR_IN6
|#                                              ;  multicast group associated 
   (mf6cc_parent :UInt16)
                                                ;  incoming ifindex 
   (mf6cc_ifset :IF_SET)
                                                ;  set of forwarding ifs 
)
; 
;  * The kernel's multicast routing statistics.
;  
(defrecord mrt6stat
   (mrt6s_mfc_lookups :U_QUAD_T)
                                                ;  # forw. cache hash table hits   
   (mrt6s_mfc_misses :U_QUAD_T)
                                                ;  # forw. cache hash table misses 
   (mrt6s_upcalls :U_QUAD_T)
                                                ;  # calls to mrouted              
   (mrt6s_no_route :U_QUAD_T)
                                                ;  no route for packet's origin    
   (mrt6s_bad_tunnel :U_QUAD_T)
                                                ;  malformed tunnel options        
   (mrt6s_cant_tunnel :U_QUAD_T)
                                                ;  no room for tunnel options      
   (mrt6s_wrong_if :U_QUAD_T)
                                                ;  arrived on wrong interface	   
   (mrt6s_upq_ovflw :U_QUAD_T)
                                                ;  upcall Q overflow		   
   (mrt6s_cache_cleanups :U_QUAD_T)
                                                ;  # entries with no upcalls 	   
   (mrt6s_drop_sel :U_QUAD_T)
                                                ;  pkts dropped selectively        
   (mrt6s_q_overflow :U_QUAD_T)
                                                ;  pkts dropped - Q overflow       
   (mrt6s_pkt2large :U_QUAD_T)
                                                ;  pkts dropped - size > BKT SIZE  
   (mrt6s_upq_sockfull :U_QUAD_T)
                                                ;  upcalls dropped - socket full   
)

; #if MRT6_OINIT
#| 
; 
;  * Struct used to communicate from kernel to multicast router
;  * note the convenient similarity to an IPv6 header.
;  * XXX old version, superseded by mrt6msg.
;  
(defrecord omrt6msg
   (unused1 :UInt32)
   (im6_msgtype :UInt8)
                                                ;  what type of message	    

; #if 0
; #define MRT6MSG_NOCACHE	1
; #define MRT6MSG_WRONGMIF	2
; #define MRT6MSG_WHOLEPKT	3		/* used for user level encap*/

; #endif

   (im6_mbz :UInt8)
                                                ;  must be zero		    
   (im6_mif :UInt8)
                                                ;  mif rec'd on		    
   (unused2 :UInt8)
   (im6_src :in6_addr)
   (im6_dst :in6_addr))
 |#

; #endif

; 
;  * Structure used to communicate from kernel to multicast router.
;  * We'll overlay the structure onto an MLD header (not an IPv6 header
;  * like igmpmsg{} used for IPv4 implementation). This is because this
;  * structure will be passed via an IPv6 raw socket, on which an application
;  * will only receive the payload i.e. the data after the IPv6 header and all
;  * the extension headers. (see Section 3 of draft-ietf-ipngwg-2292bis-01)
;  
(defrecord mrt6msg
; #define MRT6MSG_NOCACHE		1
; #define MRT6MSG_WRONGMIF	2
; #define MRT6MSG_WHOLEPKT	3		/* used for user level encap*/
   (im6_mbz :UInt8)
                                                ;  must be zero		    
   (im6_msgtype :UInt8)
                                                ;  what type of message	    
   (im6_mif :UInt16)
                                                ;  mif rec'd on		    
   (im6_pad :UInt32)
                                                ;  padding for 64bit arch   
   (im6_src :in6_addr)
#|
; Warning: type-size: unknown type IN6_ADDR
|#
   (im6_dst :in6_addr)
#|
; Warning: type-size: unknown type IN6_ADDR
|#)
; 
;  * Argument structure used by multicast routing daemon to get src-grp
;  * packet counts
;  
(defrecord sioc_sg_req6
   (src :sockaddr_in6)
#|
; Warning: type-size: unknown type SOCKADDR_IN6
|#
   (grp :sockaddr_in6)
#|
; Warning: type-size: unknown type SOCKADDR_IN6
|#
   (pktcnt :U_QUAD_T)
   (bytecnt :U_QUAD_T)
   (wrong_if :U_QUAD_T)
)
; 
;  * Argument structure used by mrouted to get mif pkt counts
;  
(defrecord sioc_mif_req6
   (mifi :UInt16)
                                                ;  mif number				
   (icount :U_QUAD_T)
                                                ;  Input packet count on mif		
   (ocount :U_QUAD_T)
                                                ;  Output packet count on mif		
   (ibytes :U_QUAD_T)
                                                ;  Input byte count on mif		
   (obytes :U_QUAD_T)
                                                ;  Output byte count on mif		
)
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE

struct mif6 {
        u_char   	m6_flags;     	
	u_int      	m6_rate_limit; 	
#ifnotyet
	struct tbf      *m6_tbf;      	
#endif
	struct in6_addr	m6_lcl_addr;   	
	struct ifnet    *m6_ifp;     	
	u_quad_t	m6_pkt_in;	
	u_quad_t	m6_pkt_out;	
	u_quad_t	m6_bytes_in;	
	u_quad_t	m6_bytes_out;	
	struct route_in6 m6_route;
#ifnotyet
	u_int		m6_rsvp_on;	
	struct socket   *m6_rsvpd;	
#endif
};


struct mf6c {
	struct sockaddr_in6  mf6c_origin;	
	struct sockaddr_in6  mf6c_mcastgrp;	
	mifi_t	    	 mf6c_parent; 		
	struct if_set	 mf6c_ifset;		

	u_quad_t    	mf6c_pkt_cnt;		
	u_quad_t    	mf6c_byte_cnt;		
	u_quad_t    	mf6c_wrong_if;		
	int	    	mf6c_expire;		
	struct timeval  mf6c_last_assert;	
	struct rtdetq  *mf6c_stall;		
	struct mf6c    *mf6c_next;		
};

#define MF6C_INCOMPLETE_PARENT ((mifi_t)-1)


#ifndef_NETINET_IP_MROUTE_H_
struct rtdetq {		
    struct mbuf 	*m;		
    struct ifnet	*ifp;		
#ifUPCALL_TIMING
    struct timeval	t;		
#endif
    struct rtdetq	*next;
};
#endif

#define MF6CTBLSIZ	256
#if(MF6CTBLSIZ & (MF6CTBLSIZ - 1)) == 0	  
#define MF6CHASHMOD(h)	((h) & (MF6CTBLSIZ - 1))
#else#define MF6CHASHMOD(h)	((h) % MF6CTBLSIZ)
#endif
#define MAX_UPQ6	4		

int	ip6_mrouter_set __P((struct socket *so, struct sockopt *sopt));
int	ip6_mrouter_get __P((struct socket *so, struct sockopt *sopt));
int	ip6_mrouter_done __P((void));
int	mrt6_ioctl __P((int, caddr_t));
#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* !_NETINET6_IP6_MROUTE_H_ */


(provide-interface "ip6_mroute")