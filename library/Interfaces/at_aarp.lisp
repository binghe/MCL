(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:at_aarp.h"
; at Sunday July 2,2006 7:26:40 pm.
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
; #ifndef _NETAT_AT_AARP_H_
; #define _NETAT_AT_AARP_H_

(require-interface "sys/appleapiopts")
; 
;  *	Copyright (c) 1988, 1989 Apple Computer, Inc. 
;  
;  "@(#)at_aarp.h: 2.0, 1.6; 10/4/93; Copyright 1988-89, Apple Computer, Inc." 
;  This is a header file for AARP. 
;  *
;  * Author: R. C. Venkatraman
;  * Date  : 3/2/88
;  *
;  
;  AARP packet 
#|
; Warning: type-size: unknown type ETALK_ADDR
|#
#|
; Warning: type-size: unknown type ETALK_ADDR
|#
(defrecord aarp_pkt_t
   (hardware_type :UInt16)
   (stack_type :UInt16)
                                                ;  indicates appletalk or xns
   (hw_addr_len :UInt8)
                                                ;  len of hardware addr, e.g
; 						 * ethernet addr len, in bytes
; 						 
   (stack_addr_len :UInt8)
                                                ;  protocol stack addr len,
; 						 * e.g., appletalk addr len
; 						 * in bytes
; 						 
   (aarp_cmd :UInt16)
   (src_addr :etalk_addr)
   (src_at_addr :ATALK_ADDR)
   (dest_addr :etalk_addr)
   (dest_at_addr :ATALK_ADDR)
                                                ;  desired or dest. at addr 
)
;  Constants currently defined in AARP 
(defconstant $AARP_AT_TYPE 33011)
; #define AARP_AT_TYPE			0x80F3	/* indicates aarp packet */
(defconstant $AARP_ETHER_HW_TYPE 1)
; #define AARP_ETHER_HW_TYPE		0x1
(defconstant $AARP_AT_PROTO 32923)
; #define AARP_AT_PROTO			0x809B	/* indicates stack type */
(defconstant $AARP_ETHER_ADDR_LEN 6)
; #define AARP_ETHER_ADDR_LEN		6	/* in bytes */
(defconstant $AARP_AT_ADDR_LEN 4)
; #define AARP_AT_ADDR_LEN		4 	/* in bytes */
;  AARP cmd definitions 
(defconstant $AARP_REQ_CMD 1)
; #define AARP_REQ_CMD			0x1	/* address lookup request */
(defconstant $AARP_RESP_CMD 2)
; #define AARP_RESP_CMD			0x2	/* address match response */
(defconstant $AARP_PROBE_CMD 3)
; #define AARP_PROBE_CMD			0x3	/* new kid probing...     */
;  AARP timer and retry counts 
(defconstant $AARP_MAX_PROBE_RETRIES 20)
; #define	AARP_MAX_PROBE_RETRIES		20
; #define AARP_PROBE_TIMER_INT		HZ/30	/* HZ defines in param.h */
(defconstant $AARP_MAX_REQ_RETRIES 10)
; #define AARP_MAX_REQ_RETRIES		10
; #define AARP_REQ_TIMER_INT              HZ/30
(defconstant $AARP_MAX_NODES_TRIED 200)
; #define	AARP_MAX_NODES_TRIED		200	/* max no. of addresses tried */
;  on the same net before     
;  giving up on the net#      
(defconstant $AARP_MAX_NETS_TRIED 10)
; #define	AARP_MAX_NETS_TRIED		10	/* max no. of net nos tried   */
;  before giving up on startup
;  Probe states 
(defconstant $PROBE_IDLE 1)
; #define PROBE_IDLE			0x1	/* There is no node addr */
(defconstant $PROBE_TENTATIVE 2)
; #define PROBE_TENTATIVE			0x2	/* probing */
(defconstant $PROBE_DONE 3)
; #define PROBE_DONE			0x3	/* an appletalk addr has been */
;  assigned for the given node
;  Errors returned by AARP routines 
(defconstant $AARP_ERR_NOT_OURS 1)
; #define AARP_ERR_NOT_OURS		1	/* not our appletalk address */
; ***********************************************
;  Declarations for AARP Address Map Table (AMT) 
; ***********************************************
#|
; Warning: type-size: unknown type ETALK_ADDR
|#
(defrecord aarp_amt_t
   (dest_at_addr :ATALK_ADDR)
   (dest_addr :etalk_addr)
   (dummy (:array :character 2))                ;  pad out to struct size of 32 
   (last_time :signed-long)
                                                ;  the last time that this addr
; 						 * was used. Read in lbolt
; 						 * whenever the addr is used.
; 						 
   (no_of_retries :signed-long)
                                                ;  number of times we've xmitted 
   (m (:pointer :gbuf_t))
                                                ;  ptr to msg blk to be sent out 
   (elapp (:pointer :at_ifaddr_t))
   (error :signed-long)
   (tmo :signed-long)
)
(defconstant $AMT_BSIZ 4)
; #define	AMT_BSIZ			 4		/* bucket size */
(defconstant $AMT_NB 64)
; #define	AMT_NB				64		/* number of buckets */
(defconstant $AMTSIZE 256)
; #define	AMTSIZE				(AMT_BSIZ * AMT_NB)
(defrecord aarp_amt_array   (et_aarp_amt (:array :AARP_AMT_T 256))
)
; #define	AMT_HASH(a) 									((NET_VALUE(((struct atalk_addr *)&a)->atalk_net) + ((struct atalk_addr *)&a)->atalk_node) % AMT_NB)
; #define	AMT_LOOK(at, at_addr, elapp) {								register n; 									at = &aarp_table[elapp->ifPort]->et_aarp_amt[AMT_HASH(at_addr) * AMT_BSIZ];	 			for (n = 0 ; ; at++) {					                	    if (ATALK_EQUAL(at->dest_at_addr, at_addr))	                        		break; 							        	    if (++n >= AMT_BSIZ) {					        	        at = NULL;                                                      		break;                                                                      }										}                                                                               }
; #define	NEW_AMT(at, at_addr, elapp) {								register n; 									register aarp_amt_t *myat;                                              	myat = at = &aarp_table[elapp->ifPort]->et_aarp_amt[AMT_HASH(at_addr) * AMT_BSIZ];				for (n = 0 ; ; at++) {					                	    if (at->last_time == 0)             					        break;  								    if (++n >= AMT_BSIZ) {					        	        at = aarp_lru_entry(myat); 							break;                                                                      }                                                                   	}                                                                       	}
; #define	AARP_NET_MCAST(p, elapp)						 	(NET_VALUE((p)->dst_net) == elapp->ifThisNode.s_net)			) /* network-wide broadcast */ 
; #define AARP_CABLE_MCAST(p)								(NET_VALUE((p)->dst_net) == 0x0000				                )
; #define AARP_BROADCAST(p, elapp)                                                        (((p)->dst_node == 0xff)  &&                                            	(                                                                                (NET_VALUE((p)->dst_net) == 0x0000) ||				         	 (NET_VALUE((p)->dst_net) == elapp->ifThisNode.s_net))	        ) /* is this some kind of a broadcast address (?) */
; #define ETHER_ADDR_EQUAL(addr1p, addr2p)						((										  ((addr1p)->etalk_addr_octet[0]==(addr2p)->etalk_addr_octet[0]) &&		  ((addr1p)->etalk_addr_octet[1]==(addr2p)->etalk_addr_octet[1]) &&		  ((addr1p)->etalk_addr_octet[2]==(addr2p)->etalk_addr_octet[2]) &&		  ((addr1p)->etalk_addr_octet[3]==(addr2p)->etalk_addr_octet[3]) &&		  ((addr1p)->etalk_addr_octet[4]==(addr2p)->etalk_addr_octet[4]) &&		  ((addr1p)->etalk_addr_octet[5]==(addr2p)->etalk_addr_octet[5])		 ) ? 1 : 0									)
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE

int aarp_chk_addr(at_ddp_t  *, at_ifaddr_t *);
int aarp_rcv_pkt(aarp_pkt_t *, at_ifaddr_t *);

#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* _NETAT_AT_AARP_H_ */


(provide-interface "at_aarp")