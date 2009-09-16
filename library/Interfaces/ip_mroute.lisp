(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ip_mroute.h"
; at Sunday July 2,2006 7:30:07 pm.
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
;  * Copyright (c) 1989 Stephen Deering.
;  * Copyright (c) 1992, 1993
;  *	The Regents of the University of California.  All rights reserved.
;  *
;  * This code is derived from software contributed to Berkeley by
;  * Stephen Deering of Stanford University.
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
;  *	@(#)ip_mroute.h	8.1 (Berkeley) 6/10/93
;  
; #ifndef _NETINET_IP_MROUTE_H_
; #define _NETINET_IP_MROUTE_H_

(require-interface "sys/appleapiopts")
; 
;  * Definitions for IP multicast forwarding.
;  *
;  * Written by David Waitzman, BBN Labs, August 1988.
;  * Modified by Steve Deering, Stanford, February 1989.
;  * Modified by Ajit Thyagarajan, PARC, August 1993.
;  * Modified by Ajit Thyagarajan, PARC, August 1994.
;  *
;  * MROUTING Revision: 3.3.1.3
;  
; 
;  * Multicast Routing set/getsockopt commands.
;  
(defconstant $MRT_INIT 100)
; #define	MRT_INIT	100	/* initialize forwarder */
(defconstant $MRT_DONE 101)
; #define	MRT_DONE	101	/* shut down forwarder */
(defconstant $MRT_ADD_VIF 102)
; #define	MRT_ADD_VIF	102	/* create virtual interface */
(defconstant $MRT_DEL_VIF 103)
; #define	MRT_DEL_VIF	103	/* delete virtual interface */
(defconstant $MRT_ADD_MFC 104)
; #define MRT_ADD_MFC	104	/* insert forwarding cache entry */
(defconstant $MRT_DEL_MFC 105)
; #define MRT_DEL_MFC	105	/* delete forwarding cache entry */
(defconstant $MRT_VERSION 106)
; #define MRT_VERSION	106	/* get kernel version number */
(defconstant $MRT_ASSERT 107)
; #define MRT_ASSERT      107     /* enable PIM assert processing */
; #define GET_TIME(t)	microtime(&t)
; 
;  * Types and macros for handling bitmaps with one bit per virtual interface.
;  
(defconstant $MAXVIFS 32)
; #define	MAXVIFS 32

(def-mactype :vifbitmap_t (find-mactype ':UInt32))

(def-mactype :vifi_t (find-mactype ':UInt16))
;  type of a vif index 
; #define ALL_VIFS (vifi_t)-1
; #define	VIFM_SET(n, m)		((m) |= (1 << (n)))
; #define	VIFM_CLR(n, m)		((m) &= ~(1 << (n)))
; #define	VIFM_ISSET(n, m)	((m) & (1 << (n)))
; #define	VIFM_CLRALL(m)		((m) = 0x00000000)
; #define	VIFM_COPY(mfrom, mto)	((mto) = (mfrom))
; #define	VIFM_SAME(m1, m2)	((m1) == (m2))
; 
;  * Argument structure for MRT_ADD_VIF.
;  * (MRT_DEL_VIF takes a single vifi_t argument.)
;  
(defrecord vifctl
   (vifc_vifi :UInt16)
                                                ;  the index of the vif to be added 
   (vifc_flags :UInt8)
                                                ;  VIFF_ flags defined below 
   (vifc_threshold :UInt8)
                                                ;  min ttl required to forward on vif 
   (vifc_rate_limit :UInt32)
                                                ;  max rate 
   (vifc_lcl_addr :IN_ADDR)
                                                ;  local interface address 
   (vifc_rmt_addr :IN_ADDR)
                                                ;  remote address (tunnels only) 
)
(defconstant $VIFF_TUNNEL 1)
; #define	VIFF_TUNNEL	0x1		/* vif represents a tunnel end-point */
(defconstant $VIFF_SRCRT 2)
; #define VIFF_SRCRT	0x2		/* tunnel uses IP source routing */
; 
;  * Argument structure for MRT_ADD_MFC and MRT_DEL_MFC
;  * (mfcc_tos to be added at a future point)
;  
(defrecord mfcctl
   (mfcc_origin :IN_ADDR)
                                                ;  ip origin of mcasts       
   (mfcc_mcastgrp :IN_ADDR)
                                                ;  multicast group associated
   (mfcc_parent :UInt16)
                                                ;  incoming vif              
   (mfcc_ttls (:array :UInt8 32))
                                                ;  forwarding ttls on vifs   
)
; 
;  * The kernel's multicast routing statistics.
;  
(defrecord mrtstat
   (mrts_mfc_lookups :UInt32)
                                                ;  # forw. cache hash table hits   
   (mrts_mfc_misses :UInt32)
                                                ;  # forw. cache hash table misses 
   (mrts_upcalls :UInt32)
                                                ;  # calls to mrouted              
   (mrts_no_route :UInt32)
                                                ;  no route for packet's origin    
   (mrts_bad_tunnel :UInt32)
                                                ;  malformed tunnel options        
   (mrts_cant_tunnel :UInt32)
                                                ;  no room for tunnel options      
   (mrts_wrong_if :UInt32)
                                                ;  arrived on wrong interface	   
   (mrts_upq_ovflw :UInt32)
                                                ;  upcall Q overflow		   
   (mrts_cache_cleanups :UInt32)
                                                ;  # entries with no upcalls 	   
   (mrts_drop_sel :UInt32)
                                                ;  pkts dropped selectively        
   (mrts_q_overflow :UInt32)
                                                ;  pkts dropped - Q overflow       
   (mrts_pkt2large :UInt32)
                                                ;  pkts dropped - size > BKT SIZE  
   (mrts_upq_sockfull :UInt32)
                                                ;  upcalls dropped - socket full 
)
; 
;  * Argument structure used by mrouted to get src-grp pkt counts
;  
(defrecord sioc_sg_req
   (src :IN_ADDR)
   (grp :IN_ADDR)
   (pktcnt :UInt32)
   (bytecnt :UInt32)
   (wrong_if :UInt32)
)
; 
;  * Argument structure used by mrouted to get vif pkt counts
;  
(defrecord sioc_vif_req
   (vifi :UInt16)
                                                ;  vif number				
   (icount :UInt32)
                                                ;  Input packet count on vif		
   (ocount :UInt32)
                                                ;  Output packet count on vif		
   (ibytes :UInt32)
                                                ;  Input byte count on vif		
   (obytes :UInt32)
                                                ;  Output byte count on vif		
)
; 
;  * The kernel's virtual-interface structure.
;  
(defrecord vif
   (v_flags :UInt8)
                                                ;  VIFF_ flags defined above         
   (v_threshold :UInt8)
                                                ;  min ttl required to forward on vif
   (v_rate_limit :UInt32)
                                                ;  max rate			     
   (v_tbf (:pointer :tbf))
                                                ;  token bucket structure at intf.   
   (v_lcl_addr :IN_ADDR)
                                                ;  local interface address           
   (v_rmt_addr :IN_ADDR)
                                                ;  remote address (tunnels only)     
   (v_ifp (:pointer :ifnet))
                                                ;  pointer to interface              
   (v_pkt_in :UInt32)
                                                ;  # pkts in on interface            
   (v_pkt_out :UInt32)
                                                ;  # pkts out on interface           
   (v_bytes_in :UInt32)
                                                ;  # bytes in on interface	     
   (v_bytes_out :UInt32)
                                                ;  # bytes out on interface	     
   (v_route :route)
#|
; Warning: type-size: unknown type ROUTE
|#
                                                ;  cached route if this is a tunnel 
   (v_rsvp_on :UInt32)
                                                ;  RSVP listening on this vif 
   (v_rsvpd (:pointer :SOCKET))
                                                ;  RSVP daemon socket 
)
; 
;  * The kernel's multicast forwarding cache entry structure 
;  * (A field for the type of service (mfc_tos) is to be added 
;  * at a future point)
;  
(defrecord mfc
   (mfc_origin :IN_ADDR)
                                                ;  IP origin of mcasts   
   (mfc_mcastgrp :IN_ADDR)
                                                ;  multicast group associated
   (mfc_parent :UInt16)
                                                ;  incoming vif              
   (mfc_ttls (:array :UInt8 32))
                                                ;  forwarding ttls on vifs   
   (mfc_pkt_cnt :UInt32)
                                                ;  pkt count for src-grp     
   (mfc_byte_cnt :UInt32)
                                                ;  byte count for src-grp    
   (mfc_wrong_if :UInt32)
                                                ;  wrong if for src-grp	     
   (mfc_expire :signed-long)
                                                ;  time to clean entry up    
   (mfc_last_assert :TIMEVAL)
                                                ;  last time I sent an assert
   (mfc_stall (:pointer :rtdetq))
                                                ;  q of packets awaiting mfc 
   (mfc_next (:pointer :mfc))
                                                ;  next mfc entry            
)
; 
;  * Struct used to communicate from kernel to multicast router
;  * note the convenient similarity to an IP packet
;  
(defrecord igmpmsg
   (unused1 :UInt32)
   (unused2 :UInt32)
   (im_msgtype :UInt8)
                                                ;  what type of message	    
; #define IGMPMSG_NOCACHE		1
; #define IGMPMSG_WRONGVIF	2
   (im_mbz :UInt8)
                                                ;  must be zero		    
   (im_vif :UInt8)
                                                ;  vif rec'd on		    
   (unused3 :UInt8)
   (im_src :IN_ADDR)
   (im_dst :IN_ADDR))
; 
;  * Argument structure used for pkt info. while upcall is made
;  
(defrecord rtdetq
   (m (:pointer :mbuf))
                                                ;  A copy of the packet		    
   (ifp (:pointer :ifnet))
                                                ;  Interface pkt came in on	    
   (xmt_vif :UInt16)
                                                ;  Saved copy of imo_multicast_vif  

; #if UPCALL_TIMING
#| 
   (t :TIMEVAL)
                                                ;  Timestamp 
 |#

; #endif /* UPCALL_TIMING */

   (next (:pointer :rtdetq))
                                                ;  Next in list of packets          
)
(defconstant $MFCTBLSIZ 256)
; #define MFCTBLSIZ	256

; #if (MFCTBLSIZ & (MFCTBLSIZ - 1)) == 0	  /* from sys:route.h */
;  from sys:route.h 
#| 
; #define MFCHASHMOD(h)	((h) & (MFCTBLSIZ - 1))
 |#

; #else
; #define MFCHASHMOD(h)	((h) % MFCTBLSIZ)

; #endif

(defconstant $MAX_UPQ 4)
; #define MAX_UPQ	4		/* max. no of pkts in upcall Q */
; 
;  * Token Bucket filter code 
;  
(defconstant $MAX_BKT_SIZE 10000)
; #define MAX_BKT_SIZE    10000             /* 10K bytes size 		*/
(defconstant $MAXQSIZE 10)
; #define MAXQSIZE        10                /* max # of pkts in queue 	*/
; 
;  * the token bucket filter at each vif
;  
(defrecord tbf
   (tbf_last_pkt_t :TIMEVAL)                    ;  arr. time of last pkt 	
   (tbf_n_tok :UInt32)
                                                ;  no of tokens in bucket 	
   (tbf_q_len :UInt32)
                                                ;  length of queue at this vif	
   (tbf_max_q_len :UInt32)
                                                ;  max. queue length		
   (tbf_q (:pointer :mbuf))
                                                ;  Packet queue			
   (tbf_t (:pointer :mbuf))
                                                ;  tail-insertion pointer	
)
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE

struct sockopt;

extern int	(*ip_mrouter_set) __P((struct socket *, struct sockopt *));
extern int	(*ip_mrouter_get) __P((struct socket *, struct sockopt *));
extern int	(*ip_mrouter_done) __P((void));
#ifMROUTING
extern int	(*mrt_ioctl) __P((int, caddr_t));
#elseextern int	(*mrt_ioctl) __P((int, caddr_t, struct proc *));
#endif
#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* _NETINET_IP_MROUTE_H_ */


(provide-interface "ip_mroute")