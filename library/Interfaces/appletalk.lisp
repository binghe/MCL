(in-package :TRAPS)
; Generated from #P"macintosh-hd:hd3:CInterface Translator:Source Interfaces:appletalk.h"
; at Sunday July 2,2006 7:26:38 pm.
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
;  Miscellaneous definitions for AppleTalk used by all protocol 
;  * modules.
;  
; #ifndef _NETAT_APPLETALK_H_
; #define _NETAT_APPLETALK_H_

(require-interface "sys/appleapiopts")

(require-interface "sys/types")

(require-interface "sys/uio")
;  
;    Non-aligned types are used in packet headers. 
; 
;  New fundemental types: non-aligned variations of u_short and u_long 
(defrecord ua_short
   (contents (:array :UInt8 2))
)                                               ;  Unaligned short 
(defrecord ua_long
   (contents (:array :UInt8 4))
)                                               ;  Unaligned long 
;  Two at_net typedefs; the first is aligned the other isn't 

(def-mactype :at_net_al (find-mactype ':UInt16))
;  Aligned AppleTalk network number 

(%define-record :at_net_unal (find-record-descriptor ':ua_short))
;  Unaligned AppleTalk network number 
;  Miscellaneous types 

(def-mactype :at_node (find-mactype ':UInt8))
;  AppleTalk node number 

(def-mactype :at_socket (find-mactype ':UInt8))
;  AppleTalk socket number 

(%define-record :at_net (find-record-descriptor ':ua_short))
;  Default: Unaligned AppleTalk network number 
(defrecord atalk_addr
   (atalk_unused :UInt8)
   (atalk_net :ua_short)
   (atalk_node :UInt8)
)
;  Macros to manipulate unaligned fields 
; #define	UAS_ASSIGN(x,s)	*(unsigned short *) &(x[0]) = (unsigned short) (s)
; #define	UAS_UAS(x,y)	*(unsigned short *) &(x[0]) = *(unsigned short *) &(y[0])
; #define	UAS_VALUE(x)	(*(unsigned short *) &(x[0]))
; #define	UAL_ASSIGN(x,l)	*(unsigned long *) &(x[0]) = (unsigned long) (l)
; #define	UAL_UAL(x,y)	*(unsigned long *) &(x[0]) = *(unsigned long *) &(y[0])
; #define	UAL_VALUE(x)	(*(unsigned long *) &(x[0]))
;  Macros to manipulate at_net variables 
; #define	NET_ASSIGN(x,s)	*(unsigned short *)&(x[0]) = (unsigned short)(s)
; #define	NET_NET(x, y)	*(unsigned short *)&(x[0]) = *(unsigned short *)&(y[0])
; #define	NET_VALUE(x)	(*(unsigned short *) &(x[0]))
; #define ATALK_ASSIGN(a, net, node, unused )   a.atalk_unused = unused; a.atalk_node = node; NET_ASSIGN(a.atalk_net, net)
; #define NET_EQUAL(a, b)	(NET_VALUE(a) == NET_VALUE(b))
; #define NET_NOTEQ(a, b)	(NET_VALUE(a) != NET_VALUE(b))
; #define NET_EQUAL0(a)	(NET_VALUE(a) == 0)
; #define NET_NOTEQ0(a)	(NET_VALUE(a) != 0)
;  
;    AppleTalk Internet Address 
; 
(defrecord at_inet
   (net :UInt16)
                                                ;  Network Address 
   (node :UInt8)
                                                ;  Node number 
   (socket :UInt8)
                                                ;  Socket number 
)
(%define-record :at_inet_t (find-record-descriptor :AT_INET))
; 
;    DDP Address for OT
; 
(defrecord ddp_addr
   (inet :AT_INET)
   (ddptype :UInt16)
)
(%define-record :ddp_addr_t (find-record-descriptor :DDP_ADDR))
; 
;   AppleTalk address
; 
(defrecord at_addr
   (s_net :UInt16)
                                                ;  16-bit network address 
   (s_node :UInt8)
                                                ;  8-bit node # (1-0xfd) 
)
; 
;   Appletalk sockaddr definition
; 
(defrecord sockaddr_at
   (sat_len :UInt8)                             ;  total length 
   (sat_family :UInt8)                          ;  address family (AF_APPLETALK) 
   (sat_port :UInt8)
                                                ;  8-bit "socket number" 
   (sat_addr :AT_ADDR)
                                                ;  16-bit "net" and 8-bit "node 
   (sat_zero (:array :character 8))
                                                ;  used for netrange in netatalk 
)
; #define ATADDR_ANYNET	(u_short)0x0000
; #define ATADDR_ANYNODE	(u_char)0x00
; #define ATADDR_ANYPORT	(u_char)0x00
; #define ATADDR_BCASTNODE (u_char)0xff	/* There is no BCAST for NET */
;  make sure the net, node and socket numbers are in legal range :
;  *
;  * Net#		0		Local Net
;  *		1 - 0xfffe	Legal net nos
;  *		0xffff		Reserved by Apple for future use.
;  * Node#	0		Illegal
;  *		1 - 0x7f	Legal (user node id's)
;  *		0x80 - 0xfe	Legal (server node id's; 0xfe illegal in
;  *				Phase II nodes)
;  *		0xff		Broadcast
;  * Socket#	0		Illegal
;  *		1 - 0xfe	Legal
;  *		0xff		Illegal
;  
; #define valid_at_addr(addr) 	((!(addr) || (addr)->net == 0xffff || (addr)->node == 0 || 	  (addr)->socket == 0 || (addr)->socket == 0xff)? 0: 1)
; ** * ETHERTYPE_ definitions are in netinet/if_ether.h *** 
(defconstant $ETHERTYPE_AT 32923)
; #define ETHERTYPE_AT    0x809B          /* AppleTalk protocol */
(defconstant $ETHERTYPE_AARP 33011)
; #define ETHERTYPE_AARP  0x80F3          /* AppleTalk ARP */
;  
;    DDP protocol types 
; 
(defconstant $DDP_RTMP 1)
; #define DDP_RTMP          0x01
(defconstant $DDP_NBP 2)
; #define DDP_NBP           0x02
(defconstant $DDP_ATP 3)
; #define DDP_ATP           0x03
(defconstant $DDP_ECHO 4)
; #define DDP_ECHO          0x04
(defconstant $DDP_RTMP_REQ 5)
; #define DDP_RTMP_REQ      0x05
(defconstant $DDP_ZIP 6)
; #define DDP_ZIP           0x06
(defconstant $DDP_ADSP 7)
; #define DDP_ADSP          0x07
;  
;    Protocols for the socket API 
; 
(defconstant $ATPROTO_NONE 0)
; #define ATPROTO_NONE  	0		/* no corresponding DDP type exists */
; #define ATPROTO_ATP	DDP_ATP		/* must match DDP type */
; #define ATPROTO_ADSP    DDP_ADSP	/* must match DDP type */
(defconstant $ATPROTO_DDP 249)
; #define ATPROTO_DDP	249		/* *** to be eliminated eventually *** */
(defconstant $ATPROTO_LAP 250)
; #define ATPROTO_LAP   	250 		/* *** to be eliminated eventually *** */
(defconstant $ATPROTO_AURP 251)
; #define ATPROTO_AURP  	251		/* no corresponding DDP type exists */
(defconstant $ATPROTO_ASP 252)
; #define ATPROTO_ASP	252		/* no corresponding DDP type exists */
(defconstant $ATPROTO_AFP 253)
; #define ATPROTO_AFP	253		/* no corresponding DDP type exists */
(defconstant $ATPROTO_RAW 255)
; #define ATPROTO_RAW	255		/* no corresponding DDP type exists */
; 
;   Options for use with [gs]etsockopt at the DDP level.
;   First word of comment is data type; bool is stored in int.
; 
(defconstant $DDP_CHKSUM_ON 1)
; #define DDP_CHKSUM_ON	1	/* int; default = FALSE;
(defconstant $DDP_HDRINCL 2)
; #define DDP_HDRINCL	2	/* int; default = FALSE;
(defconstant $DDP_GETSOCKNAME 3)
; #define DDP_GETSOCKNAME	3	/* used to get ddp_addr_t */
(defconstant $DDP_SLFSND_ON 4)
; #define DDP_SLFSND_ON	4	/* int; default = FALSE;
(defconstant $DDP_STRIPHDR 5)
; #define DDP_STRIPHDR	5	/* int; default = FALSE;
;  
;    AppleTalk protocol retry and timeout 
; 
(defrecord at_retry
   (interval :SInt16)
                                                ;  Retry interval in seconds 
   (retries :SInt16)
                                                ;  Maximum number of retries 
   (backoff :UInt8)                             ;  Retry backoff, must be 1 through 4 
)
(%define-record :at_retry_t (find-record-descriptor :AT_RETRY))
;  
;    Basic NBP Definitions needed for AppleTalk framework
; 
(defconstant $MAX_ZONES 50)
; #define MAX_ZONES 50
(defconstant $NBP_NVE_STR_SIZE 32)
; #define NBP_NVE_STR_SIZE	32	/* Maximum NBP tuple string size */
(defrecord at_nvestr
   (len :UInt8)
   (str (:array :UInt8 32))
)
(%define-record :at_nvestr_t (find-record-descriptor :AT_NVESTR))
;  Entity Name 
(defrecord at_entity
   (object :AT_NVESTR)
   (type :AT_NVESTR)
   (zone :AT_NVESTR)
)
(%define-record :at_entity_t (find-record-descriptor :AT_ENTITY))
(defconstant $NBP_TUPLE_SIZE 99)
; #define NBP_TUPLE_SIZE	((3*NBP_NVE_STR_SIZE)+3) 
;  3 for field lengths + 3*32 for three names 
(defrecord at_nbptuple
   (enu_addr :AT_INET)
   (enu_enum :UInt8)
   (enu_entity :AT_ENTITY)
)
(%define-record :at_nbptuple_t (find-record-descriptor :AT_NBPTUPLE))
;  
;    Basic ATP Definitions needed for LibcAT 
; 
(defconstant $ATP_TRESP_MAX 8)
; #define ATP_TRESP_MAX       8	/* Maximum number of Tresp pkts */
;  Response buffer structure for atp_sendreq() and atp_sendrsp() 
(defrecord at_resp
   (bitmap :UInt8)
                                                ;  Bitmap of responses 
   (filler (:array :UInt8 3))
                                                ;  Force 68K to RISC alignment 
   (resp (:array :IOVEC 8))
                                                ;  Buffer for response data 
   (userdata (:array :signed-long 8))
                                                ;  Buffer for response user data 
)
(%define-record :at_resp_t (find-record-descriptor :AT_RESP))
;  
;    Needed for ASP and ADSP 
; 
(defrecord strbuf_t
   (maxlen :signed-long)                        ;  max buffer length 
   (len :signed-long)                           ;  length of data 
   (buf (:pointer :char))                       ;  pointer to buffer 
)
(defconstant $IFID_HOME 1)
; #define	IFID_HOME	1 		/* home port in ifID_table */
; #define	ATALK_VALUE(a)		((*(u_long *) &(a))&0x00ffffff)
; #define	ATALK_EQUAL(a, b)	(ATALK_VALUE(a) == ATALK_VALUE(b))
(defconstant $VERSION_LENGTH 80)
; #define VERSION_LENGTH		80	/* length of version string */
;  struture containing general information regarding the state of
;  * the Appletalk networking 
;  
(defrecord at_state
   (flags :UInt32)
                                                ;  various init flags 
)
(%define-record :at_state_t (find-record-descriptor :AT_STATE))
;   at_state_t 'flags' defines 
(defconstant $AT_ST_STARTED 1)
; #define AT_ST_STARTED		0x0001	/* set if protocol is fully enabled */
(defconstant $AT_ST_STARTING 2)
; #define AT_ST_STARTING		0x0002	/* set if interfaces are configured */
(defconstant $AT_ST_MULTIHOME 128)
; #define AT_ST_MULTIHOME		0x0080	/* set if multihome mode */
(defconstant $AT_ST_ROUTER 256)
; #define AT_ST_ROUTER		0x0100	/* set if we are a router */
(defconstant $AT_ST_IF_CHANGED 512)
; #define AT_ST_IF_CHANGED	0x0200	/* set when state of any I/F 
(defconstant $AT_ST_RT_CHANGED 1024)
; #define AT_ST_RT_CHANGED	0x0400  /* route table changed (for SNMP)*/
(defconstant $AT_ST_ZT_CHANGED 2048)
; #define AT_ST_ZT_CHANGED 	0x0800  /* zone table changed (for SNMP) */
(defconstant $AT_ST_NBP_CHANGED 4096)
; #define AT_ST_NBP_CHANGED	0x1000  /* if nbp table changed (for SNMP)*/
; #ifdef KERNEL
#| #|
#ifdef__APPLE_API_PRIVATE
extern at_state_t at_state;		

#define ROUTING_MODE	(at_state.flags & AT_ST_ROUTER)
#define MULTIHOME_MODE	(at_state.flags & AT_ST_MULTIHOME)
#define MULTIPORT_MODE (ROUTING_MODE || MULTIHOME_MODE)
#endif
#endif
|#
 |#
;  KERNEL 
;  defines originally from h/at_elap.h 
(defconstant $AT_ADDR 0)
; #define AT_ADDR			0
(defconstant $ET_ADDR 1)
; #define ET_ADDR			1
(defconstant $AT_ADDR_NO_LOOP 2)
; #define AT_ADDR_NO_LOOP		2	/* disables packets from looping back */

; #endif /* _NETAT_APPLETALK_H_ */


(provide-interface "appletalk")