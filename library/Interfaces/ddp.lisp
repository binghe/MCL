(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:ddp.h"
; at Sunday July 2,2006 7:27:29 pm.
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
;  *
;  * ORIGINS: 82
;  *
;  * (C) COPYRIGHT Apple Computer, Inc. 1992-1996
;  * All Rights Reserved
;  *
;  
; #ifndef _NETAT_DDP_H_
; #define _NETAT_DDP_H_

(require-interface "sys/appleapiopts")
;  Header and data sizes 
(defconstant $DDP_HDR_SIZE 5)
; #define  DDP_HDR_SIZE                 5  /* DDP (short) header size */
(defconstant $DDP_X_HDR_SIZE 13)
; #define  DDP_X_HDR_SIZE              13  /* DDP extended header size */
(defconstant $DDP_DATA_SIZE 586)
; #define  DDP_DATA_SIZE              586  /* Maximum DataGram data size */
(defconstant $DDP_DATAGRAM_SIZE 599)
; #define  DDP_DATAGRAM_SIZE          599  /* Maximum DataGram size */
;  DDP socket definitions 
(defconstant $DDP_SOCKET_1st_RESERVED 1)
; #define  DDP_SOCKET_1st_RESERVED      1  /* First in reserved range */
(defconstant $DDP_SOCKET_1st_EXPERIMENTAL 64)
; #define  DDP_SOCKET_1st_EXPERIMENTAL 64  /* First in experimental range */
(defconstant $DDP_SOCKET_1st_DYNAMIC 128)
; #define  DDP_SOCKET_1st_DYNAMIC     128  /* First in dynamic range */
(defconstant $DDP_SOCKET_LAST 253)
; #define  DDP_SOCKET_LAST            253  /* Last socket in any range */
;  DDP type used to replace "0" on packets sent out, for compatibility
;    with Open Transport 
(defconstant $DEFAULT_OT_DDPTYPE 11)
; #define DEFAULT_OT_DDPTYPE 11
;  DDP well-known sockets 
(defconstant $RTMP_SOCKET 1)
; #define RTMP_SOCKET	1	/* RTMP socket number 	*/
(defconstant $NBP_SOCKET 2)
; #define NBP_SOCKET	2  	/* NIS socket number */
(defconstant $EP_SOCKET 4)
; #define	EP_SOCKET	4	/* EP socket number */
(defconstant $ZIP_SOCKET 6)
; #define ZIP_SOCKET	6  	/* ZIP socket number */
;  DDP extended header packet format 
(defrecord at_ddp_t
   (unused :uint32)                             ;(: 2)
                                                ;(hopcount : 4)
                                                ;(length : 10)
                                                ;  Datagram length 
   (checksum :ua_short)
                                                ;  Checksum 
   (dst_net :ua_short)
                                                ;  Destination network number 
   (src_net :ua_short)
                                                ;  Source network number 
   (dst_node :UInt8)
                                                ;  Destination node ID 
   (src_node :UInt8)
                                                ;  Source node ID 
   (dst_socket :UInt8)
                                                ;  Destination socket number 
   (src_socket :UInt8)
                                                ;  Source socket number 
   (type :UInt8)
                                                ;  Protocol type 
   (data (:array :character 586))
)
; #define	DDPLEN_ASSIGN(ddp, len)		ddp->length = len
; #define	DDPLEN_VALUE(ddp)		ddp->length
;  DDP module statistics and configuration 
(defrecord at_ddp_stats
                                                ;  General 
                                                ;  Receive stats 
   (rcv_bytes :uint32)
   (rcv_packets :uint32)
   (rcv_bad_length :uint32)
   (rcv_unreg_socket :uint32)
   (rcv_bad_socket :uint32)
   (rcv_bad_checksum :uint32)
   (rcv_dropped_nobuf :uint32)
                                                ;  Transmit stats 
   (xmit_bytes :uint32)
   (xmit_packets :uint32)
   (xmit_BRT_used :uint32)
   (xmit_bad_length :uint32)
   (xmit_bad_addr :uint32)
   (xmit_dropped_nobuf :uint32)
)
(%define-record :at_ddp_stats_t (find-record-descriptor :AT_DDP_STATS))
;  DDP streams module ioctls 
(defconstant $AT_MID_DDP 203)
; #define	AT_MID_DDP	203
; #define DDP_IOC_MYIOCTL(i)      ((i>>8) == AT_MID_DDP)
(defconstant $DDP_IOC_GET_CFG 51969)
; #define DDP_IOC_GET_CFG        	((AT_MID_DDP<<8) | 1)
; #ifdef NOT_USED
#| #|
#define DDP_IOC_BIND_SOCK	((AT_MID_DDP<<8) | 2)
#define DDP_IOC_GET_STATS	((AT_MID_DDP<<8) | 3)
#define DDP_IOC_LSTATUS_TABLE	((AT_MID_DDP<<8) | 4)
#define DDP_IOC_ULSTATUS_TABLE	((AT_MID_DDP<<8) | 5)
#define DDP_IOC_RSTATUS_TABLE	((AT_MID_DDP<<8) | 6)
#define DDP_IOC_SET_WROFF	((AT_MID_DDP<<8) | 7 )
#define DDP_IOC_SET_OPTS	((AT_MID_DDP<<8) | 8 )
#define DDP_IOC_GET_OPTS	((AT_MID_DDP<<8) | 9 )
#define DDP_IOC_GET_SOCK	((AT_MID_DDP<<8) | 10)
#define DDP_IOC_GET_PEER	((AT_MID_DDP<<8) | 11)
#define DDP_IOC_SET_PEER	((AT_MID_DDP<<8) | 12)
#define DDP_IOC_SET_PROTO	((AT_MID_DDP<<8) | 13)
#endif
|#
 |#
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE

#define DDP_MIN_NETWORK		0x0001
#define DDP_MAX_NETWORK		0xfffe
#define DDP_STARTUP_LOW		0xff00
#define DDP_STARTUP_HIGH	DDP_MAX_NETWORK

typedef	struct {
	void **inputQ;
	int  *pidM;
	char  **socketM;
	char  *dbgBits;
} proto_reg_t;


#define FROM_US(ddp)	((NET_VALUE(ddp->src_net) ==\
	ifID_home->ifThisNode.s_net) && \
	ifID_home->ifThisNode.s_node == ddp->src_node)

#define RT_LOOKUP_OKAY(ifID, ddp) \
     ((ROUTING_MODE && ifID->ifRoutingState==PORT_ONLINE) || \
      (MULTIHOME_MODE && FROM_US(ddp)))

#ifdefNOT_YET

int ddp_adjmsg(gbuf_t *m, int len);
gbuf_t *ddp_growmsg(gbuf_t  *mp, int len);
	     

int ddp_add_if(at_ifaddr_t *ifID);
int ddp_rem_if(at_ifaddr_t *ifID);
int ddp_bind_socket(ddp_socket_t *socketp);
int ddp_close_socket(ddp_socket_t *socketp);
int ddp_output(gbuf_t **mp, at_socket src_socket, int src_addr_included);
void ddp_input(gbuf_t   *mp, at_ifaddr_t *ifID);
int ddp_router_output(
     gbuf_t  *mp,
     at_ifaddr_t *ifID,
     int addr_type,
     at_net_al router_net,
     at_node router_node,
     etalk_addr_t *enet_addr);


int ddp_close(gref_t *gref);
void ddp_putmsg(gref_t *gref, gbuf_t *mp);
gbuf_t *ddp_compress_msg(gbuf_t *mp);
void ddp_stop(gbuf_t *mioc, gref_t *gref);
	     

void ddp_bit_reverse(unsigned char *);

#endif


int ddp_shutdown(int);

#endif
#endif
|#
 |#
;  KERNEL 

; #endif /* _NETAT_DDP_H_ */


(provide-interface "ddp")